# Codebase Architecture & File Explanations

This document explains the purpose and functionality of every major script and code file written for the **Local Enterprise AI Assistant**.

---

## 1. The Core Backend Server (`server.py`)
**Purpose:** The central nervous system of the application. It receives files from the frontend, processes them, talks to the AI models, and enforces cybersecurity rules.

**What it does:**
*   **FastAPI Setup:** Creates a high-performance HTTP web server on port 8000. It handles CORS so the React frontend (running on port 5173) is allowed to talk to it.
*   **PDF Extraction (`fitz`):** Uses the `PyMuPDF` library to rip the raw digital text out of uploaded PDFs directly from RAM, ensuring 100% mathematical accuracy without saving files to the hard drive.
*   **Multi-Modal Routing:** Checks if the user uploaded an image (`.png`, `.jpg`). If yes, it converts the image to `base64` pixel bytes and routes it to the `llava-phi3` Vision model. If it's a PDF or normal text, it routes it to the much faster `qwen2.5:3b` text model.
*   **Cybersecurity Overrides:** Injects strict system prompts that block "Jailbreak" hacking attempts, and forcefully disables the AI's RLHF safety filters so it doesn't redact (`[redacted]`) sensitive financial numbers.
*   **Context Sanitizer:** Silently deletes old image pixels from the chat history when a new image is uploaded, preventing the Vision AI from hallucinating or confusing multiple images.
*   **The Brain Wipe (`/clear`):** Deletes the `backend_memory.json` file when the user requests a new chat, giving the AI total amnesia so old documents don't contaminate new conversations.

---

## 2. The React Frontend Logic (`src/hooks/useChatSession.js`)
**Purpose:** The bridge between the user interface and the Python backend.

**What it does:**
*   **API Communication:** Replaces the old "mock data" logic with real HTTP `fetch()` calls. It packages the user's text and raw file uploads into a `FormData` object and sends it securely to `server.py`.
*   **State Management:** Manages the `messages` array that displays the chat bubbles on the screen.
*   **Persistent Memory:** Automatically saves your chat history into the browser's `localStorage`. If you refresh Google Chrome, your chat doesn't disappear.
*   **Reset Engine:** When the user clicks "+ New Chat", this script clears the browser memory *and* sends a DELETE request to Python's `/clear` endpoint to wipe the backend memory simultaneously.

---

## 3. The Input UI Component (`src/components/Composer.jsx`)
**Purpose:** The text box and attachment button where the user actually types and uploads files.

**What it does:**
*   **File Handling:** Captures the raw `File` object from your computer when you click the paperclip icon (rather than just saving the file name).
*   **Lazy Auto-Summary Feature:** Contains custom logic that enables the "Send" button even if the text box is empty, *as long as a file is attached*. If the user sends a blank message with a PDF, it automatically injects a hidden prompt asking the AI to summarize it.

---

## 4. The Automation Script (`start_project.bat`)
**Purpose:** A Windows batch script designed for easy, 1-click bootups during college presentations.

**What it does:**
*   It automatically opens two completely separate Command Prompt windows.
*   In Window 1, it runs `uvicorn server:app --reload` to start the Python backend.
*   In Window 2, it runs `npm run dev` to start the React frontend.
*   This prevents the user from having to manually open terminals and remember the commands.

---

## 5. Early Prototypes (Phase 1)
These scripts were written early in the project to prove the AI could work offline before we built the web server.

*   **`read_pdf_ai.py`**: A pure Python terminal script that proved we could read a local PDF receipt and send the raw text to the `qwen2.5:3b` model.
*   **`expense_rag.py`**: A proof-of-concept script for setting up ChromaDB (Vector Database) to demonstrate how massive 100+ page documents could be chunked and searched in future updates.
