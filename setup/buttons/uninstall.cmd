@echo off
setlocal

set "configFile=.\setup\config.txt"

set "installDir="
for /f "usebackq delims=" %%a in ("%configFile%") do (
    set "installDir=%%a"
)

echo Please use "Force Stop" before uninstalling WhatsApp-Bot-MD! Do you want to continue? (Y/N)
choice /c yn /n >nul

if errorlevel 2 (
    echo The script will exit.
    pause
    exit /b
)

if exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" (
    powershell -Command "Start-Process 'cmd' -Verb RunAs -ArgumentList '/c pm2 kill && echo Uninstalling WhatsApp-Bot-MD... && rmdir /s /q %installDir% && echo Uninstall complete! && pause'"
) else (
    runas /user:Administrator "cmd /c pm2 kill && echo Uninstalling WhatsApp-Bot-MD... && rmdir /s /q %installDir% && echo Uninstall complete! && pause"
)
