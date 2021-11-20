class Click
{  
    rewardsWindow()
    {
        ClickEmu(0.5*KONOFAN_W, 0.9*KONOFAN_H)
    }

    replayWindow()
    {
        ClickEmu(0.5*KONOFAN_W, 0.9*KONOFAN_H)
    }

    battleNext()
    {
        ClickEmu(0.71*KONOFAN_W, 0.89*KONOFAN_H)
    }

    replayConfirmation()
    {
        ClickEmu(0.6*KONOFAN_W, 0.7*KONOFAN_H)
    }

    battlePreparation()
    {
        ClickEmu(0.85*KONOFAN_W, 0.75*KONOFAN_H)
    }

    battleBegin()
    {
        ClickEmu(0.88*KONOFAN_W, 0.89*KONOFAN_H)
    }

    hardPrevArrow()
    {
        ClickEmu(0.35*KONOFAN_W, 0.5*KONOFAN_H)
    }

    eventHardFour()
    {
        ClickEmu(0.71*KONOFAN_W, 0.31*KONOFAN_H)
    }
}

ClickEmu(posX, posY)
{
    ; https://www.autohotkey.com/boards/viewtopic.php?f=7&t=33596
    ; ctrl + f: "click without moving the cursor"

    konofanHandle := DllCall("user32\WindowFromPoint", "UInt64", (KONOFAN_X+100 & 0xFFFFFFFF)|(KONOFAN_Y+100 << 32), "Ptr")
            
    ControlClick,, % "ahk_id " konofanHandle,,,, NA x%posX% y%posY%
}