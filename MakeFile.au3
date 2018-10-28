#include <Crypt.au3>

Const $copiler = "D:\programs\AutoIt3\Aut2Exe\Aut2exe.exe"
Const $proyectDir = "D:\Projects\ETSIdeploy"

Const $toCompile[3][3] = [["DeployETSI.au3","DeployETSI.exe","icon.ico"],["DeployETSIdeleter.au3","DeployETSIdeleter.exe","icon.ico"],["DeployETSIexecutor.au3","DeployETSIexecutor.exe","icon.ico"]]

;Limpiar saldia
DirRemove("exe",1)
DirCreate("exe")
DirRemove("out",1)
DirCreate("out")

;Compilar
For $i = 0 To UBound($toCompile)-1
   ShellExecuteWait($copiler,"/in code\"&$toCompile[$i][0]&" /out exe\"&$toCompile[$i][1]&" /icon res\"&$toCompile[$i][2],$proyectDir)
Next

;Ensamblar PROCESOS MODIFICABLES----------------------------------
Const $dataDir = "DATA"
Const $toCompress[2][2] = [["codeblocks","codeblocks.7z"],["git","git.7z"]]
Const $compressLevel = "-m0=lzma2"
Const $toEncrypt[5][2] = [["codeblocks.7z","codeblocks.B0vE"],["git.7z","git.B0vE"],["DeployETSIdeleter.exe","DeployETSIdeleter.B0vE"],["DeployETSIexecutor.exe","DeployETSIexecutor.B0vE"],["7za.exe","7za.B0vE"]]
Const $cryptPASS = "1d10t_B0vEcodePASS_Tr00l"
;Terreno
DirCreate("out\"&$dataDir)
FileCopy("res\7za.exe","out\"&$dataDir&"\7za.exe")
For $i = 0 To UBound($toCompile)-1
   FileMove("exe\"&$toCompile[$i][1],"out\"&$dataDir&"\"&$toCompile[$i][1])
Next
;Comprimir
For $i = 0 To UBound($toCompress)-1
   ShellExecuteWait('7za.exe','a '&$compressLevel&' "'&$proyectDir&'\out\'&$dataDir&"\"&$toCompress[$i][1]&'" "'&$proyectDir&'\res\'&$toCompress[$i][0]&'"')
Next
;Encriptar
For $i = 0 To UBound($toEncrypt)-1
   _Crypt_EncryptFile("out\"&$dataDir&"\"&$toEncrypt[$i][0], "out\"&$dataDir&"\"&$toEncrypt[$i][1],$cryptPASS,$CALG_AES_256)
   FileDelete("out\"&$dataDir&"\"&$toEncrypt[$i][0])
Next
;Montar
FileMove("out\"&$dataDir&"\DeployETSI.exe","out\DeployETSI.exe")
FileCopy("res\autorun.inf","out\autorun.inf")