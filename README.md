# Local Enterprise AI Assistant 🚀

A highly secure, air-gapped, multi-modal AI Assistant designed for Enterprise Data Analysis. It runs **100% offline** on local hardware (optimized for 8GB RAM laptops) and processes PDFs, Images, and text using Local AI models.

---

## 🛠️ Installation Guide (For a Fresh PC)

If you want to run this project on a friend's PC, follow these exact steps:

### Step 1: Install Prerequisites
Before you begin, ensure the PC has these three programs installed:
1. **[Git](https://git-scm.com/downloads)** (To download the code)
2. **[Python 3.10+](https://www.python.org/downloads/)** (For the Backend)
3. **[Node.js](https://nodejs.org/)** (For the Frontend)
4. **[Ollama](https://ollama.com/)** (The AI Engine)

### Step 2: Download the Code
Open a Command Prompt and run:
```bash
git clone https://github.com/oparab299-gif/Local-Ai-Assistant21.git
cd Local-Ai-Assistant21
```

### Step 3: Install the AI Models
Open a terminal and download the required AI models via Ollama:
```bash
# Download the Text & PDF Engine (Lightning fast, highly capable)
ollama pull qwen2.5:3b

# Download the Vision Engine (Optimized for OCR and reading receipts)
ollama pull llava-phi3
```

### Step 4: Install Backend Dependencies (Python)
Open a terminal inside the project folder and run:
```bash
pip install fastapi uvicorn python-multipart pymupdf ollama
```

### Step 5: Install Frontend Dependencies (React)
Open a terminal inside the project folder and run:
```bash
npm install
```

---

## 🚀 How to Run the App

Once everything is installed, starting the app takes just one click!

1. Make sure **Ollama** is running in your Windows system tray.
2. Double-click the **`start_project.bat`** file located in the project folder.
3. Two terminal windows will automatically open to boot the servers.
4. Open Google Chrome and go to: `http://localhost:5173`

---

## 🏗️ Architecture & Features
*   **Dual-Pipeline AI:** Automatically routes PDFs to `qwen2.5:3b` for perfect digital text extraction, and images (`.jpg`, `.png`) to `llava-phi3` for Vision OCR.
*   **Prompt Injection Defense:** Hardcoded security protocols prevent jailbreaking and unauthorized overarching commands.
*   **RLHF Bypass:** Bypasses standard AI safety filters to ensure financial data is outputted raw and not censored as `[redacted]`.
*   **Amnesia Prevention:** Maintains conversational memory across turns using a backend JSON state manager.

*For a deep dive into the code and architecture, check out the `docs/` folder!*
