#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

assistantAvatar := "D:\Users\Baconfry\Documents\GitHub\konofan-helper\Assets\iris.png"
message := "Onii-sama, this is a test message."


Gui, Alert:Destroy
Gui, Alert:New, +ToolWindow -Caption +AlwaysOnTop +HwndAlertHwnd
Gui, Alert:Color, FFFF65
Gui, Alert:Margin, 15, 10
Gui, Alert:Font, s13 c00008c, Segoe UI
Gui, Alert:Add, Picture, h40 w-1, % assistantAvatar
Gui, Alert:Add, Text, x+10 yp+7 Center, % message
Gui, Alert:Show, y20 x20 NoActivate

OnMessage(0x201, "FadeOut")

if (autoDestruct) {
    ; Wait two seconds before clearing the notif
    Sleep, 2000
    FadeOut()
}

FadeOut()
{
    Global
    ; This is a fadeout animation that lasts for 300 ms
    DllCall("AnimateWindow", "UInt", AlertHwnd, "Int", 300, "UInt", 0x90000)
    Gui, Alert:Destroy
}