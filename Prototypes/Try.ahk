#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include FindText.ahk
WinGetPos, KONOFAN_X, KONOFAN_Y, KONOFAN_W, KONOFAN_H, Fantastic Days
KONOFAN_Y += 40
KONOFAN_H -= 40

;Random, clkX, 0.2, 0.8
;Random, clkY, 0.2, 0.6
;posX := Floor(clkX*KONOFAN_W)
;posY := Floor(clkY*KONOFAN_H)
;konofanHandle := DllCall("user32\WindowFromPoint", "UInt64", (KONOFAN_X+100 & 0xFFFFFFFF)|(KONOFAN_Y+100 << 32), "Ptr")   
;ControlClick,, % "ahk_id " konofanHandle,,,, NA x%posX% y%posY%
;ExitApp

Text := "|<Begin>*135$44.zzzzzrzsDzzzszw0zzzzDz77zzzzzltwTkRsAQQ3k6A10CCMtX601baSMlkQM1baAQ7W0NtX71sXyCMlkQQzk6AQ0D0S1X78DwDyRvnzzzz7zzzzzw3zzzzzz1zzy"
Reg := 9
error1 := error2 := 0

if (ScanRegion(Text, Reg))
msgbox, ok
else
msgbox, poop
ExitApp

ScanRegion(inputText, Region, err1 := 0, err2 := 0)
{      
    /*
        Regions look like this
            0 = entire region

            1 | 2 | 3
            4 | 5 | 6
            7 | 8 | 9

            |    10    |
            |__________|
            |          |
            |    11    |
    */

    ;	FindText(
    ;      X1 --> the search scope's upper left corner X coordinates
    ;    , Y1 --> the search scope's upper left corner Y coordinates
    ;    , X2 --> the search scope's lower right corner X coordinates
    ;    , Y2 --> the search scope's lower right corner Y coordinates
    ;    , err1 --> Fault tolerance percentage of text       (0.1=10%)
    ;    , err0 --> Fault tolerance percentage of background (0.1=10%)
    ;    , Text --> can be a lot of text parsed into images, separated by "|"
    ;    , ScreenShot --> if the value is 0, the last screenshot will be used
    ;    , FindAll --> if the value is 0, Just find one result and return
    ;    , JoinText --> if the value is 1, Join all Text for combination lookup
    ;    , offsetX --> Set the max text offset (X) for combination lookup
    ;    , offsetY --> Set the max text offset (Y) for combination lookup
    ;    , dir --> Nine directions for searching: up, down, left, right and center
    ;	)
    local X := KONOFAN_X
    , Y := KONOFAN_Y
    , W := KONOFAN_W
    , H := KONOFAN_H

    switch Region
    {
        case 0:
            return FindText(X, Y, X+W, Y+H, err1, err2, inputText)
        case 1:
            return FindText(X, Y, X+(W//3), Y+(H//3), err1, err2, inputText)
        case 2:
            return FindText(X+(W//3), Y, X+((2*W)//3), Y+(H//3), err1, err2, inputText)
        case 3:
            return FindText(X+((2*W)//3), Y, X+W, Y+(H//3), err1, err2, inputText)
        case 4:
            return FindText(X, Y+(H//3), X+(W//3), Y+((2*H)//3), err1, err2, inputText)
        case 5:
            return Findtext(X+(W//3), Y+(H//3), X+((2*W)//3), Y+((2*H)//3), err1, err2, inputText)
        case 6:
            return FindText(X+((2*W)//3), Y+(H//3), X+W, Y+((2*H)//3), err1, err2, inputText)
        case 7:
            return FindText(X, Y+((2*H)//3), X+(W//3), Y+H, err1, err2, inputText)
        case 8:
            return FindText(X+(W//3), Y+((2*H)//3), X+((2*W)//3), Y+H, err1, err2, inputText)
        case 9:
            return FindText(X+((2*W)//3), y+((2*H)//3), X+W, Y+H, err1, err2, inputText)
        case 10:
            return FindText(X, Y, X+w, Y+(H//2), err1, err2, inputText)
        case 11:
            return FindText(X, Y+(H//2), X+W, Y+H, err1, err2, inputText)
    }
}

