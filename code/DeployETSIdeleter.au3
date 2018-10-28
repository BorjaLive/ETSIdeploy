#include <Crypt.au3>

$tmp_folder = @DesktopDir&"\TMP"


Sleep(2000)

DirRemove(@DesktopDir&"\TMP", 1)
DirRemove(@DesktopDir&"\git", 1)
DirRemove(@DesktopDir&"\codeblocks", 1)
DirRemove(@DesktopDir&"\ETSIcode", 1)