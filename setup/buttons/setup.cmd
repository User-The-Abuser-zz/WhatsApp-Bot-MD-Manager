@echo off
setlocal

set "configFile=.\setup\config.txt"

set "installDir="
for /f "usebackq delims=" %%a in ("%configFile%") do (
    set "installDir=%%a"
)

set "tempDir=C:\temp"
set "bocchiDir=%installDir%\botName"
set "dataDir=.\setup\data"

echo Installing Chocolatey...

:check_choco
where choco >nul 2>nul
if %errorlevel% neq 0 (
    start .\setup\chocolatey-2.2.2.0.msi
    timeout /t 1 /nobreak >nul
    goto check_choco
)

echo Chocolatey installation complete!

echo Installing Node.js...

:check_node
where node >nul 2>nul
if %errorlevel% neq 0 (
    if exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" (
        powershell -Command "Start-Process 'cmd' -Verb RunAs -ArgumentList '/c choco install nodejs-lts -y'"
    ) else (
        runas /user:Administrator "cmd /c choco install nodejs-lts -y"
    )
    timeout /t 1 /nobreak >nul
    goto check_node
)

echo Node.js installation complete!

echo Installing Git...

:check_git
where git >nul 2>nul
if %errorlevel% neq 0 (
    if exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" (
        powershell -Command "Start-Process 'cmd' -Verb RunAs -ArgumentList '/c choco install git -y'"
    ) else (
        runas /user:Administrator "cmd /c choco install git -y"
    )
    timeout /t 1 /nobreak >nul
    goto check_git
)

echo Git installation complete!

echo Dependencies installed successfully!

echo Cloning Git repository...
git clone https://github.com/lyfe00011/whatsapp-bot-md "C:\temp\botName"

echo Copy data...
xcopy /E /I /Y /S /H "%tempDir%\*" "%installDir%"
rd /s /q "%tempDir%

xcopy /I /Y ".\setup\config.txt" "%installDir%"
xcopy /E /I /Y "%dataDir%" "%installDir%"

if exist "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" (
    powershell -Command "Start-Process 'cmd' -Verb RunAs -ArgumentList '/c call \"%installDir%\install.cmd\"'"
) else (
    runas /user:Administrator "cmd /c call \"%installDir%\install.cmd\""
)
