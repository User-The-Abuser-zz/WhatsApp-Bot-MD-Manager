@echo off
if exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" (
    powershell -Command "Start-Process 'cmd' -Verb RunAs -ArgumentList '/c mode con: cols=200 lines=200 && pm2 monit'"
) else (
    runas /user:Administrator "cmd /c mode con: cols=200 lines=50 && pm2 monit"
)
