#include <Crypt.au3>

$tmp_folder = @DesktopDir&"\TMP"


If Not FileExists($tmp_folder) Then DirCreate($tmp_folder)

_Crypt_DecryptFile("DATA\git.B0vE",$tmp_folder&"\git.7z","1d10t_B0vEcodePASS_Tr00l",$CALG_AES_256)
_Crypt_DecryptFile("DATA\codeblocks.B0vE",$tmp_folder&"\codeblocks.7z","1d10t_B0vEcodePASS_Tr00l",$CALG_AES_256)
_Crypt_DecryptFile("DATA\7za.B0vE",$tmp_folder&"\7za.exe","1d10t_B0vEcodePASS_Tr00l",$CALG_AES_256)
_Crypt_DecryptFile("DATA\DeployETSIexecutor.B0vE",$tmp_folder&"\DeployETSIexecutor.exe","1d10t_B0vEcodePASS_Tr00l",$CALG_AES_256)
_Crypt_DecryptFile("DATA\DeployETSIdeleter.B0vE",$tmp_folder&"\DeployETSIdeleter.exe","1d10t_B0vEcodePASS_Tr00l",$CALG_AES_256)

Run($tmp_folder&"\DeployETSIexecutor.exe")