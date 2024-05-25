@echo off
setlocal

set "versionFile=.\version.txt"

set "version="
for /f "usebackq delims=" %%a in ("%versionFile%") do (
    set "version=%%a"
)

set "repoPath=https://github.com/User-The-Abuser/WhatsApp-Bot-MD-Manager"

set "versionPath=https://raw.githubusercontent.com/User-The-Abuser/WhatsApp-Bot-MD-Manager/main/version.txt"

set "tempDir=%~dp0\repo_clone"

set "tempFile=%~dp0\latestversion.tmp"

certutil -urlcache -split -f "%versionPath%" "%tempFile%" >nul

set "latestversion="
< "%tempFile%" set /p latestversion=

del "%tempFile%" >nul 2>&1

echo Installed Version: %version%
echo Latest Version: %latestversion%
echo.
echo Please use "Force Stop PM2" before updating WhatsApp-Bot-MD Manager! Do you want to continue? (Y/N)

choice /c yn /n >nul

if errorlevel 2 (
    echo The script will exit.
    pause
    exit /b
)

echo Installing Update...
git clone "%repoPath%" "%tempDir%" >nul
xcopy /E /I /Y /S /H "%tempDir%\*" ".\"

rmdir /s /q "%tempDir%" >nul

set "version="
for /f "usebackq delims=" %%a in ("%versionFile%") do (
    set "version=%%a"
)

echo Update complete!
echo Installed Version: %version%
echo Latest Version: %latestversion%

pause
