@echo off
echo ===================================================
echo Starting Enterprise Local AI Assistant...
echo ===================================================

echo [1] Starting React Frontend...
start cmd /k "cd /d E:\localai\Local-Ai && npm run dev"

echo [2] Starting Python FastAPI Backend...
start cmd /k "cd /d E:\localai\Local-Ai && uvicorn server:app --reload"

echo ===================================================
echo Both servers are starting up in new windows!
echo Please wait a few seconds, then open your browser to:
echo http://localhost:5173
echo ===================================================
pause
