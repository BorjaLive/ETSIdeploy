#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <Crypt.au3>
#include <File.au3>

$tmp_folder = @DesktopDir&"\TMP"



$GUI = GUICreate("ETSI Deploy B0vE",550,70,-1,-1,$WS_POPUP)
$GUI_label = GUICtrlCreateLabel("Desconecte la memoria flash.",25,15,500,40,$SS_CENTER)
GUICtrlSetFont($GUI_label,28)
GUICtrlSetColor($GUI_label,0xffffff)
GUISetBkColor(0xed1a1a,$GUI)
GUISetState(@SW_SHOW, $GUI)

Do
   $disp = DriveGetDrive("REMOVABLE")
   $connected = false
   If Not @Error Then
	  For $i = 1 To $disp[0]
		 If FileExists($disp[$i]&"\DeployETSI.exe") Then $connected = true
	  Next
   EndIf
   Sleep(1000)
Until $connected = false

GUISetState(@SW_HIDE, $GUI)



ShellExecuteWait($tmp_folder&'\7za.exe','x -aoa -o"'&@DesktopDir&'" "'&@DesktopDir&'\TMP\git.7z"')
ShellExecuteWait($tmp_folder&'\7za.exe','x -aoa -o"'&@DesktopDir&'" "'&@DesktopDir&'\TMP\codeblocks.7z"')

If FileExists(@TempDir&"\ETSI_B0vE") Then DirRemove(@TempDir&"\ETSI_B0vE",1)
DirCreate(@TempDir&"\ETSI_B0vE")
FileMove($tmp_folder&"\DeployETSIdeleter.exe",@TempDir&"\ETSI_B0vE\DeployETSIdeleter.exe")

ShellExecuteWait(@DesktopDir&'\git\git-cmd.exe','git clone "https://github.com/BorjaLive/ETSIcode.git" & exit',@DesktopDir)

If FileExists(@AppDataDir&"\CodeBlocks") Then DirMove(@AppDataDir&"\CodeBlocks",@TempDir&"\ETSI_B0vE\CodeBlocks")
DirCopy(@DesktopDir&"\codeblocks\AppData\codeblocks",@AppDataDir&"\CodeBlocks")

RunWait(@DesktopDir&"\codeblocks\codeblocks.exe")

;Salida

$basura = _FileListToArrayRec(@DesktopDir&"\ETSIcode","*.exe;*.o",1,1,0,2)
If Not @error Then
   For $i = 1 To $basura[0]
	  FileDelete($basura[$i])
   Next
EndIf

ShellExecuteWait(@DesktopDir&'\git\git-cmd.exe','git add . & git commit -m "Cambios desde UHU '&@MDAY&'/'&@MON&'/'&@YEAR&'" & git push origin & exit',@DesktopDir&"\ETSIcode")

DirRemove(@AppDataDir&"\CodeBlocks",1)
If FileExists(@TempDir&"\ETSI_B0vE\CodeBlocks") Then DirMove(@TempDir&"\ETSI_B0vE\CodeBlocks",@AppDataDir&"\CodeBlocks")

Run(@TempDir&"\ETSI_B0vE\DeployETSIdeleter.exe")
