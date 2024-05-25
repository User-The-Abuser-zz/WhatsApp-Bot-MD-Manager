@echo off
if exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" (
    powershell -Command "Start-Process 'cmd' -Verb RunAs -ArgumentList '/c pm2 delete botName'"
) else (
    runas /user:Administrator "cmd /c pm2 delete botName"
)
