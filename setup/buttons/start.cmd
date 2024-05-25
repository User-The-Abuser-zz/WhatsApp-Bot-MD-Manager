@echo off
setlocal

set "configFile=.\setup\config.txt"

set "installDir="
for /f "usebackq delims=" %%a in ("%configFile%") do (
    set "installDir=%%a"
)

if exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" (
    powershell -Command "Start-Process 'cmd' -Verb RunAs -ArgumentList '/c mode con: cols=200 lines=200 && cd /d %installDir%\botName && pm2 start . --name botName --attach --time'"
) else (
    runas /user:Administrator "cmd /c mode con: cols=200 lines=200 && cd /d %installDir%\botName && pm2 start . --name botName --attach --time"
)
