@echo off
setlocal

set "configFile=%~dp0\config.txt"

set "installDir="
for /f "usebackq delims=" %%a in ("%configFile%") do (
    set "installDir=%%a"
)

choco list --local-only ffmpeg | findstr /C:"1 packages installed" > nul
if errorlevel 1 (
    echo ffmpeg is not installed, starting the installation...
    choco install ffmpeg -y
)

choco list --local-only curl | findstr /C:"1 packages installed" > nul
if errorlevel 1 (
    echo curl is not installed, starting the installation...
    choco install curl -y
)

npm list -g --depth=0 | findstr /C:"yarn" > nul
if errorlevel 1 (
    echo yarn is not installed, starting the installation...
    npm install -g yarn -y
)

npm list -g --depth=0 | findstr /C:"pm2" > nul
if errorlevel 1 (
    echo pm2 is not installed, starting the installation...
    npm install -g pm2 -y
)

if exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" (
    powershell -Command "Start-Process 'cmd' -Verb RunAs -ArgumentList '/c cd %installDir%\botName && yarn install --network-concurrency 1 && del "%installDir%\install.cmd" && del "%installDir%\config.txt" && echo Installation complete! && pause'"
) else (
    runas /user:Administrator "cmd /c cd %installDir%\botName && yarn install --network-concurrency 1 && del "%installDir%\install.cmd" && del "%installDir%\config.txt" && echo Installation complete! && pause"
)
