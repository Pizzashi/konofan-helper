#NoEnv
#SingleInstance, Force
#Persistent

global Monitor := 1
SetTimer, MousePosCheck, 50

Gui, Win:New, ToolWindow AlwaysOnTop, CoordHelper
Gui, Win:Add, Text, vAbsDisplayedX w150, Abs Cursor X: 0
Gui, Win:Add, Text, vAbsDisplayedY w150, Abs Cursor Y: 0
Gui, Win:Add, Text, vRelDisplayedX w150, Rel Cursor X: 0
Gui, Win:Add, Text, vRelDisplayedY w150, Rel Cursor Y: 0
Gui, Win:Add, Button, gToggleMonitoring, % "On/Off"
Gui, Win:Show, w150 h200

return

ToggleMonitoring:
    if !(Monitor)
    {
        SetTimer, MousePosCheck, 50
        Monitor := 1
    }
    else
    {
        SetTimer, MousePosCheck, Off
        GuiControl, Win:, AbsDisplayedX, % "Abs Cursor X: Off"
        GuiControl, Win:, AbsDisplayedY, % "Abs Cursor Y: Off"
        GuiControl, Win:, RelDisplayedX, % "Rel Cursor X: Off"
        GuiControl, Win:, RelDisplayedY, % "Rel Cursor Y: Off"
        Monitor := 0
    }
return

MousePosCheck:
    WinGetPos, KONOFAN_X, KONOFAN_Y, KONOFAN_W, KONOFAN_H, Fantastic Days
    prevX := cursorX
    , prevY := cursorY
    CoordMode, Mouse, Screen
    MouseGetPos, cursorX, cursorY
    if (prevX != cursorX || prevY != cursorY)
    {
        absX := cursorX
        , absY := cursorY
        cursorX -= KONOFAN_X
        , cursorY -= (KONOFAN_Y+40)
        cursorX := (cursorX >= 0 && cursorX <= KONOFAN_W) ? cursorX : "N/A"
        , cursorY := (cursorY >= 0 && cursorY <= (KONOFAN_H-40)) ? cursorY : "N/A"
        cursorX := (cursorX = "N/A" || cursorY = "N/A") ? "N/A" : cursorX
        , cursorY := (cursorX = "N/A" || cursorY = "N/A") ? "N/A" : cursorY
        GuiControl, Win:, AbsDisplayedX, % "Abs Cursor X: " . absX
        GuiControl, Win:, AbsDisplayedY, % "Abs Cursor Y: " . absY
        GuiControl, Win:, RelDisplayedX, % "Rel Cursor X: " . cursorX
        GuiControl, Win:, RelDisplayedY, % "Rel Cursor Y: " . cursorY
    }
return

WinGuiClose:
ExitApp