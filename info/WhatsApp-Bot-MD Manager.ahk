#SingleInstance Force

if not A_IsAdmin
{
    MsgBox, 4, Admin Rights Required, This script needs to run with administrator privileges. Restart with admin rights?
    IfMsgBox, Yes
    {
        Run *RunAs "%A_ScriptFullPath%",, UseErrorLevel
        if ErrorLevel
        {
            MsgBox, 16, Error!, Failed to restart with admin rights. Please try running the script as an administrator.
            ExitApp
        }
        else
        {
            ExitApp
        }
    }
}

Gui, Margin, 0, 20, 0, 0

DesktopShortcut := A_Desktop "\Whatsapp-Bot-MD Manager.lnk"
If (FileExist(DesktopShortcut))
{
    SkipShortcutCreation := 1
}

If !SkipShortcutCreation
{
    MsgBox, 4,, Create a desktop shortcut for Whatsapp-Bot-MD Manager?
    IfMsgBox Yes
    {
        CustomIconPath := A_ScriptDir "\setup\icon.ico"
        TargetPath := A_ScriptDir "\Whatsapp-Bot-MD Manager.exe"
        ShortcutPath := A_Desktop "\Whatsapp-Bot-MD Manager.lnk"

        CreateShortcut(TargetPath, ShortcutPath, , , CustomIconPath)

        MsgBox Desktop shortcut was created!
	oShell := ""
    }
}

CreateShortcut(Target, LinkFile, Arguments="", WorkingDir="", IconFile="", IconNumber=0) {
    oShell := ComObjCreate("WScript.Shell")
    oShortcut := oShell.CreateShortcut(LinkFile)
    oShortcut.TargetPath := Target
    oShortcut.Arguments := Arguments
    oShortcut.WorkingDirectory := WorkingDir
    oShortcut.IconLocation := IconFile ", " IconNumber
    oShortcut.Save()
}

SetWorkingDir, %A_ScriptDir%

CreateGUI:
    Gui, +LastFound
    Gui, Add, Button, x40 y20 w390 h30 gOpenSetupCMD, Install Bot
    Gui, Add, Text,  x25 y67 w10 h30, 1
    Gui, Add, Button, x40 y60 w180 h30 gOpenQRCMD, Get Session ID
    Gui, Add, Text,  x440 y67 w30 h30, 2
    Gui, Add, Button, x250 y60 w180 h30 gOpenConfigCMD, Edit Config
    Gui, Add, Text,  x25 y107 w10 h30, 3
    Gui, Add, Button, x40 y100 w180 h30 gOpenStartCMD, Start Bot
    Gui, Add, Text,  x440 y107 w30 h30, 4
    Gui, Add, Button, x250 y100 w180 h30 gOpenStopCMD, Stop Bot
    Gui, Add, Text,  x25 y147 w10 h30, 5
    Gui, Add, Button, x40 y140 w180 h30 gOpenMonitorCMD, Monitor Bot
    Gui, Add, Text,  x440 y147 w30 h30, 6
    Gui, Add, Button, x250 y140 w180 h30 gOpenUninstallCMD, Uninstall Bot
    Gui, Add, Text,  x25 y187 w10 h30, 7
    Gui, Add, Button, x40 y180 w180 h30 w180 h30 gOpenbotNameCMD, Open Directory
    Gui, Add, Text,  x440 y187 w30 h30, 8
    Gui, Add, Button, x250 y180 w180 h30 w180 h30 gOpenBackupCMD, Create Backup
    Gui, Add, Text,  x25 y227 w10 h30, 9
    Gui, Add, Button, x40 y220 w180 h30 w180 h30 gOpenRestartCMD, Restart Bot
    Gui, Add, Text,  x440 y227 w30 h30, 10
    Gui, Add, Button, x250 y220 w180 h30 w180 h30 gOpenPM2KillCMD, Force Stop
    Gui, Add, Text,  x20 y267 w15 h30, 11
    Gui, Add, Button, x40 y260 w180 h30 gOpenUninstallAllCMD, Uninstall Everything
    Gui, Add, Text,  x440 y267 w30 h30, 12
    Gui, Add, Button, x250 y260 w180 h30 gOpenUpdateCMD, Update Packages

    Gui, Add, Button, x40 y300 w180 h30 gOpenUpdateManagerCMD, Update Manager
    Gui, Add, Button, x250 y300 w180 h30 gExitButton, Exit

    Gui, Show,, WhatsApp-Bot-MD Manager 1.0.0
Return

ReadConfigFile() {
    ConfigFile := A_ScriptDir "\setup\config.txt"
    If !FileExist(ConfigFile) {
        MsgBox, 16, Error, Config file does not exist!
        Return
    }
    FileRead, InstallDir, %ConfigFile%
    Return InstallDir
}

OpenSetupCMD:
    Gui, SelectVersion: Destroy
    Gui, InstallPath: New
    Gui, Add, Text,, Select Installation Directory:
    Gui, Add, Edit, x20 y30 w300 h25 vInstallDir, % ReadConfigFile()
    Gui, Add, Button, x330 y30 w50 h25 gBrowseButton, Browse
    Gui, Add, Button, x380 y30 w50 h25 gResetStandardPath, Standard
    Gui, Add, Button, x20 y70 w180 h30 gConfirmInstall, Confirm
    Gui, Add, Button, x220 y70 w180 h30 gCancelInstall, Cancel
    Gui, Show,, BocchiBot Installation Path
Return

BrowseButton:
    FileSelectFolder, InstallDir,,3,Select Installation Directory
    if ErrorLevel
        return
    FileDelete, %A_ScriptDir%\setup\config.txt
    FileAppend, %installDir%, %A_ScriptDir%\setup\config.txt
    GuiControl,, InstallDir, %installDir%
Return

ResetStandardPath:
    FileDelete, %A_ScriptDir%\setup\config.txt
    FileAppend, C:\WhatsApp-Bot-MD, %A_ScriptDir%\setup\config.txt
    GuiControl,, InstallDir, C:\WhatsApp-Bot-MD
Return

ConfirmInstall:
    Gui, Submit, NoHide
    Run, %A_ScriptDir%\setup\buttons\setup.cmd
    Gui, InstallPath: Destroy
Return

CancelInstall:
    Gui, SelectVersion: Destroy
    Gui, InstallPath: Destroy
Return

OpenQRCMD:
    Run, https://qr-hazel-alpha.vercel.app/md
Return

OpenConfigCMD:
    Run, %A_ScriptDir%\setup\buttons\config.cmd
Return

OpenStartCMD:
    Run, %A_ScriptDir%\setup\buttons\start.cmd
Return

OpenStopCMD:
    Run, %A_ScriptDir%\setup\buttons\stop.cmd
Return

OpenMonitorCMD:
    Run, %A_ScriptDir%\setup\buttons\monitor.cmd
Return

OpenUninstallCMD:
    Run, %A_ScriptDir%\setup\buttons\uninstall.cmd
Return

OpenbotNameCMD:
    Run, %A_ScriptDir%\setup\buttons\botname.cmd
Return

OpenBackupCMD:
    Run, %A_ScriptDir%\setup\buttons\backup.cmd
Return

OpenRestartCMD:
    Run, %A_ScriptDir%\setup\buttons\restart.cmd
Return

OpenPM2KillCMD:
    Run, %A_ScriptDir%\setup\buttons\pm2_kill.cmd
Return

OpenUninstallAllCMD:
    Run, %A_ScriptDir%\setup\buttons\uninstall_all.cmd
Return

OpenUpdateCMD:
    Run, %A_ScriptDir%\setup\buttons\update.cmd
Return

OpenUpdateManagerCMD:
    Run, %A_ScriptDir%\setup\buttons\update_manager.cmd
    ExitApp
Return

ExitButton:
    ExitApp
Return

GuiClose:
    ExitApp
Return
