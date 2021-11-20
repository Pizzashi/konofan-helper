Assets := A_Temp . "\KonofanHelper"

; Saratoga photo: hhttps://konofan.fandom.com/wiki/Character:Iris

; FileInstall won't work if the folder doesn't exist already
if !FileExist("%A_Temp%\KonofanHelper")
    FileCreateDir, %Assets%

if !FileExist("%A_Temp%\KonofanHelper\iris.png")
    FileInstall, Assets\iris.png, %Assets%\iris.png, 1

; This OnExit function will delete temporary files once the script is closed
OnExit("ClearAssets")

ClearAssets()
{
    Global
    FileRemoveDir, %Assets%, 1
}