@echo off
setlocal

set "configFile=.\setup\config.txt"

set "installDir="
for /f "usebackq delims=" %%a in ("%configFile%") do (
    set "installDir=%%a"
)

echo Please use "Force Stop" before updating BocchiBot! Do you want to continue? (Y/N)
choice /c yn /n >nul

if errorlevel 2 (
    echo The script will exit.
    pause
    exit /b
)

if exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" (
    powershell -Command "Start-Process 'cmd' -Verb RunAs -ArgumentList '/c choco upgrade chocolatey -y && choco upgrade nodejs-lts -y && choco upgrade git -y && choco upgrade ffmpeg -y && npm install npm@latest -g && npm install pm2@latest -g && npm install node-gyp -g && pm2 update && cd /d %installDir%\BocchiBot && npm update && echo Update complete! && pause'"
) else (
    runas /user:Administrator "cmd /c choco upgrade chocolatey -y && choco upgrade nodejs-lts -y && choco upgrade git -y && choco upgrade ffmpeg -y && npm install npm@latest -g && npm install pm2@latest -g && npm install node-gyp -g && pm2 update && cd /d %installDir%\BocchiBot && npm update && echo Update complete! && pause"
)
