@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

set PORT=8000
set URL=http://localhost:%PORT%/index.html

echo ============================================
echo   HTML 태그 검사기 로컬 서버
echo   주소: %URL%
echo   (종료하려면 이 창에서 Ctrl+C)
echo ============================================
echo.

rem --- Python 우선 (python -> py 순서로 탐색) ---
where python >nul 2>nul
if %errorlevel%==0 (
    start "" "%URL%"
    python -m http.server %PORT%
    goto :eof
)

where py >nul 2>nul
if %errorlevel%==0 (
    start "" "%URL%"
    py -m http.server %PORT%
    goto :eof
)

rem --- Node.js (npx) 폴백 ---
where npx >nul 2>nul
if %errorlevel%==0 (
    start "" "%URL%"
    npx --yes http-server -p %PORT%
    goto :eof
)

rem --- 서버 도구가 없으면 파일을 직접 열기 ---
echo Python / Node.js 가 없어 로컬 서버를 띄울 수 없습니다.
echo 파일을 브라우저로 직접 엽니다. (URL 불러오기 기능은 제한될 수 있습니다)
echo.
start "" "%~dp0index.html"
pause
