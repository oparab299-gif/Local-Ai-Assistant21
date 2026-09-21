# Local Enterprise AI Assistant: Final Project Report

## 1. Project Overview
The goal of this project was to build a highly secure, privacy-first, **Air-Gapped Enterprise AI Assistant** capable of processing financial documents (Expense Reports, Invoices, Receipts). 
A critical constraint was that the entire full-stack application and AI models had to run locally and completely offline on a standard laptop with an **i3 processor and 8GB of RAM**, without relying on paid cloud APIs like OpenAI.

## 2. Technology Stack
*   **Frontend UI:** React.js (Vite)
*   **Backend Server:** Python (FastAPI, Uvicorn, python-multipart)
*   **PDF Parsing:** PyMuPDF (`fitz`)
*   **AI Engine:** Ollama (Local AI inference)

## 3. AI Models: Exploration & Final Selection
Running AI locally on 8GB of RAM requires strict memory management. We tested and finalized the following models:

### Text & PDF Engine: `qwen2.5:3b` (Finalized)
*   **Why we chose it:** It is a 3-billion parameter model that is lightning fast and highly capable of reasoning. It follows strict system prompts beautifully.
*   **Storage Location:** E:\ Drive (Custom environment variable routing).

### Vision Engine: `llava-phi3` (Finalized)
*   **The Journey:** We initially tested the standard `llava` (7B) model. However, at 4.7 GB, it was too heavy for the RAM limits and failed at Optical Character Recognition (OCR) on dense spreadsheets because it compressed images down to 336x336 pixels (causing "Repetition Collapse" hallucinations).
*   **The Solution:** We deleted `llava` and installed Microsoft's `llava-phi3` (3.8B). At only 2.6 GB, it is highly optimized for document reading, fits perfectly in 8GB RAM, and handles standard photo receipts effortlessly.

## 4. Key Architectural Features & Problem Solving

### A. The VLM vs. PDF Discovery (100% Accuracy)
During testing, we discovered a major limitation of modern Local Vision Models (VLMs). When fed dense, dark-themed corporate spreadsheets, VLMs hallucinate mathematical data.
**Solution:** We engineered a dual-pipeline architecture. For perfect accuracy on dense data, the system forces Native PDF parsing using `PyMuPDF` to extract raw digital text (100% mathematical accuracy). The `llava-phi3` Vision model is reserved strictly for standard image files (like photos of cafe receipts).

### B. Cybersecurity & Prompt Injection Defense
We secured the application against malicious prompt hacking.
*   **Jailbreak Defense:** Hardcoded a `SECURITY PROTOCOL` in the Python backend. If a user says *"Ignore previous instructions"*, the AI peacefully declines the request.
*   **Anti-Redaction Override:** Financial AIs are natively trained (via RLHF) to censor sensitive data by outputting `[redacted]`. We bypassed this safety filter by injecting a `CRITICAL SAFETY OVERRIDE` declaring the AI as an "Authorized Financial System," forcing it to output exact dollar amounts.

### C. Multi-Modal Context Sanitizer
When a user uploads a new image, passing multiple historical images to a Vision AI causes severe confusion. We built a "Memory Sanitizer" in `server.py` that aggressively strips old image pixels from the chat history while preserving the text conversation, forcing the AI to focus 100% on the newest image.

### D. Session Memory & Amnesia Prevention
We implemented `backend_memory.json` so the AI remembers the context of uploaded files across multiple questions. We also wired a `/clear` API endpoint to the React **"+ New Chat"** button to permanently wipe the JSON file, preventing the AI from accidentally mixing up old expense reports with new ones.

## 5. How to Run the Project
We built a fully automated boot sequence for easy demonstration.

1.  **Start the AI Engine:** Ensure the Ollama app is running in the Windows background (Llama icon in the taskbar).
2.  **1-Click Boot:** Double-click the `start_project.bat` file located in the root directory.
    *   *This will automatically launch two terminal windows.*
    *   *Terminal 1 starts the FastAPI Python server (`localhost:8000`).*
    *   *Terminal 2 starts the React Frontend (`localhost:5173`).*
3.  **Access the UI:** Open Google Chrome and navigate to `http://localhost:5173`.
4.  **Usage:** Click the attachment icon to upload a `.pdf`, `.jpg`, or `.png`, and prompt the AI to generate a Markdown table of the expenses!
