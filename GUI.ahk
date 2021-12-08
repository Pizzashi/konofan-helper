Unalert()
{
    Global
    Gui, Alert:Destroy
}

Alert(message, autoDestruct := false, pushNotifications := true, notifyPhoneOnly := true)
{
    Global
    
    ; If push notifications for phone were turned on
    if (NOTIFY_EVENTS && pushNotifications) {
        NotificationPush(message)
        if (notifyPhoneOnly)
            return
    }

    assistantAvatar := Assets . "\iris.png"

    Gui, Alert:Destroy
    Gui, Alert:New, +ToolWindow -Caption +AlwaysOnTop +HwndAlertHwnd
    Gui, Alert:Color, FFFF83
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
}

FadeOut()
{
    Global
    ; This is a fadeout animation that lasts for 300 ms
    DllCall("AnimateWindow", "UInt", AlertHwnd, "Int", 300, "UInt", 0x90000)
    Gui, Alert:Destroy
}

; Pass zero to this function to delete the marker.
PaintWindow(paintWindow := 1)
{
    if (paintWindow) {
        ; For some really weird reason, the height and width used by Gui() are 4/5 of the values obtained in WinGetPos
        ; Although x and y values are correct
        ; BUT for some reason, FindText() uses the original values. What the hell?
        if (LEVEL_REPEAT)
            BarColor := "008000" ; Green
        else if (HARD_GRIND)
            BarColor := "FF0000" ; Red
        else if (EVENT_GRIND)
            BarColor :="000080" ; Navy blue
        guiW := Floor(KONOFAN_W*4/5)
        , guiH := Floor(KONOFAN_H*4/5)
        , bottomY := (guiH-3)
        , rightX := (guiW-3)
        
        Gui, Painter:New, +ToolWindow -Caption +AlwaysOnTop +LastFound
        Gui, Painter:Color, Black
        Gui, Painter:Add, Progress, % "x0 y0 h3 " "Background"BarColor " w"guiW              ; Top bar
        Gui, Painter:Add, Progress, % "x0 y0 w3 " "Background"BarColor " h"guiH              ; Left bar
        Gui, Painter:Add, Progress, % "y0 w3 "    "Background"BarColor " h"guiH " x"rightX   ; Right bar
        Gui, Painter:Add, Progress, % "x0 h3 "    "Background"BarColor " w"guiW " y"bottomY  ; Bottom bar
        WinSet, TransColor, Black 150 ; Turns the background invisible
        Gui, Painter:Show, NoActivate x%KONOFAN_X% y%KONOFAN_Y% w%KONOFAN_W% h%KONOFAN_H%
    } else {
        Gui, Painter:Destroy
    }
}