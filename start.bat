@echo off
setlocal
cd /d "%~dp0"

set "PORT=8000"
set "URL=http://localhost:%PORT%/index.html"

echo ============================================
echo   HTML Tag Checker - local server
echo   URL: %URL%
echo   (Press Ctrl+C in this window to stop)
echo ============================================
echo.

rem --- Try Python (python, then py) ---
where python >nul 2>nul && (
    start "" "%URL%"
    python -m http.server %PORT%
    goto :eof
)

where py >nul 2>nul && (
    start "" "%URL%"
    py -m http.server %PORT%
    goto :eof
)

rem --- Fallback: Node.js (npx) ---
where npx >nul 2>nul && (
    start "" "%URL%"
    npx --yes http-server -p %PORT%
    goto :eof
)

rem --- No server tool: open the file directly ---
echo Python / Node.js not found. Opening the file directly.
echo (URL fetch feature may be limited under file://)
echo.
start "" "%~dp0index.html"
pause
