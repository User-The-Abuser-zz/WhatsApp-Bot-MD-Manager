@echo off
setlocal

set "configFile=.\setup\config.txt"

set "installDir="
for /f "usebackq delims=" %%a in ("%configFile%") do (
    set "installDir=%%a"
)

setlocal enabledelayedexpansion

for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set "datum_zeit=%%I"
set "aktuelles_datum=!datum_zeit:~0,4!-!datum_zeit:~4,2!-!datum_zeit:~6,2!_!datum_zeit:~8,2!-!datum_zeit:~10,2!-!datum_zeit:~12,2!"

set "config_source=%installDir%\botName\config.env"
set "backup_base_dir=%USERPROFILE%\Desktop\WhatsApp-Bot-MD Backup"
set "backup_dir=%backup_base_dir%\Backup_%aktuelles_datum%"

mkdir "%backup_dir%" > nul 2>&1
copy /y "%config_source%" "%backup_dir%\config.env" > nul 2>&1
