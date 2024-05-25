@echo off
setlocal

set "configFile=.\setup\config.txt"

set "installDir="
for /f "usebackq delims=" %%a in ("%configFile%") do (
    set "installDir=%%a"
)

echo Please restart your PC before uninstalling WhatsApp-Bot-MD! Do you want to continue? (Y/N)
choice /c yn /n >nul

if errorlevel 2 (
    echo The script will exit.
    pause
    exit /b
)

echo Uninstalling Node.js. Please wait...

choco uninstall nodejs -y

:check_node
where node >nul 2>nul
if %errorlevel% neq 0 (
    timeout /t 1 /nobreak >nul
    goto check_node
)

echo Node.js successfully uninstalled!

echo Uninstalling Git. Please wait...

choco uninstall git -y

:check_git
where git >nul 2>nul
if %errorlevel% neq 0 (
    timeout /t 1 /nobreak >nul
    goto check_git
)

echo Git successfully uninstalled!

if exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" (
    powershell -Command "Start-Process 'cmd' -Verb RunAs -ArgumentList '/c pm2 kill && echo Uninstalling WhatsApp-Bot-MD. Please wait... && rmdir /s /q %installDir% && choco uninstall ffmpeg -y && choco uninstall curl -y && choco uninstall yarn -y && choco uninstall nodejs-lts && choco uninstall git && choco uninstall chocolatey -y && rmdir /s /q C:\ProgramData\chocolatey && rmdir /s /q C:\ProgramData\ChocolateyHttpCache && rmdir /s /q C:\Users\%USERNAME%\.chocolatey && del /f C:\Users\%USERNAME%\.yarnrc && rmdir /s /q C:\Users\%USERNAME%\.pm2 && rmdir /s /q C:\Users\%USERNAME%\AppData\Local\npm-cache && rmdir /s /q C:\Users\%USERNAME%\AppData\Roaming\npm && rmdir /s /q C:\Users\%USERNAME%\AppData\Roaming\npm-cache && rmdir /s /q C:\Program Files\Git && rmdir /s /q C:\Program Files\nodejs && echo Uninstall complete! && pause'"
) else (
    runas /user:Administrator "cmd /c pm2 kill && echo Uninstalling WhatsApp-Bot-MD. Please wait... && rmdir /s /q %installDir% && choco uninstall ffmpeg -y && choco uninstall curl -y && choco uninstall yarn -y && choco uninstall nodejs-lts && choco uninstall git && choco uninstall chocolatey -y && rmdir /s /q C:\ProgramData\chocolatey && rmdir /s /q C:\ProgramData\ChocolateyHttpCache && rmdir /s /q C:\Users\%USERNAME%\.chocolatey && del /f C:\Users\%USERNAME%\.yarnrc && rmdir /s /q C:\Users\%USERNAME%\.pm2 && rmdir /s /q C:\Users\%USERNAME%\AppData\Local\npm-cache && rmdir /s /q C:\Users\%USERNAME%\AppData\Roaming\npm && rmdir /s /q C:\Users\%USERNAME%\AppData\Roaming\npm-cache && rmdir /s /q C:\Program Files\Git && rmdir /s /q C:\Program Files\nodejs && echo Uninstall complete! && pause"
)

if exist "%USERPROFILE%\Desktop\WhatsApp-Bot-MD Manager.lnk" (
    del "%USERPROFILE%\Desktop\WhatsApp-Bot-MD Manager.lnk"
)
