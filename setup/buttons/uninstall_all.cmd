@echo off
setlocal

set "configFile=.\setup\config.txt"

set "installDir="
for /f "usebackq delims=" %%a in ("%configFile%") do (
    set "installDir=%%a"
)

set "packages=ffmpeg nodejs-lts git curl yarn chocolatey"

echo Please restart your PC before uninstalling WhatsApp-Bot-MD! Do you want to continue? (Y/N)
choice /c yn /n >nul

if errorlevel 2 (
    echo The script will exit.
    pause
    exit /b
)

set "script="
set "script=%script%pm2 kill && echo Uninstalling WhatsApp-Bot-MD. Please wait... && rmdir /s /q %installDir% && "
set "script=%script%choco -? >nul 2>&1 && if errorlevel 1 (echo Chocolatey is not installed.) && "
set "script=%script%for %%i in (%packages%) do (choco list --local-only | findstr /c:"%%i" >nul && if not errorlevel 1 (echo Uninstalling %%i... && choco uninstall %%i -y) else (echo %%i is not installed.)) && "
set "script=%script%rmdir /s /q C:\ProgramData\chocolatey && "
set "script=%script%rmdir /s /q C:\ProgramData\ChocolateyHttpCache && "
set "script=%script%rmdir /s /q C:\Users\%USERNAME%\.chocolatey && "
set "script=%script%del /f C:\Users\%USERNAME%\.yarnrc && "
set "script=%script%rmdir /s /q C:\Users\%USERNAME%\.pm2 && "
set "script=%script%rmdir /s /q C:\Users\%USERNAME%\AppData\Local\npm-cache && "
set "script=%script%rmdir /s /q C:\Users\%USERNAME%\AppData\Roaming\npm && "
set "script=%script%rmdir /s /q C:\Users\%USERNAME%\AppData\Roaming\npm-cache && "
set "script=%script%rmdir /s /q C:\Program Files\Git && "
set "script=%script%rmdir /s /q C:\Program Files\nodejs && "
set "script=%script%echo Uninstall complete! && pause"

if exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" (
    powershell -Command "Start-Process 'cmd' -Verb RunAs -ArgumentList '/c %script%'"
) else (
    runas /user:Administrator "cmd /c %script%"
)

if exist "%USERPROFILE%\Desktop\WhatsApp-Bot-MD Manager.lnk" (
    del "%USERPROFILE%\Desktop\WhatsApp-Bot-MD Manager.lnk"
)
