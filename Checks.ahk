global KONOFAN_X, KONOFAN_Y, KONOFAN_W, KONOFAN_H
, MAINMENU_TEXT := "|<Play Store>*118$39.bTznzzs/zw/zzRFPiAn/efQvOq3FftPK3sgzfOrTFbZMKLzyzzzzzzjzzzw"
, REWARDS_TEXT := "|<Next>*134$38.7lzzztkwTzzyQDDzzzb1nsCQs1Aw1XC0F6CQ7b6HXbXtlkM1syQQ6Ty7b7VXz8tlww3bC0T7UNlkU"
, REPLAY_TEXT := "|<Replay>*159$54.00000A000zU000A000zk000A000ss000A000ssT3wATb7sMzbyADX6ttnbCA1n6zlzb7A7nazlzb7ATnitllb7Axlgstk77Atlwssz7yCxkwsQzbyCTks00D7M2DUs00070003k00070007k000200030U"
, REPLAYCONF_TEXT := "|<Battle>*147$48.000001U0zU0A31U0zk0A31U0kk0A31U0klyDntVwllyDXtXyzU7A31X7zkTA31XzktzA31XzkPbA31X0kvXC31X0znrDntnyzVz7lslyU"
, ZEROMEAT_TEXT := "|<Recover>*146$64.80000000003y000000000Dw000000000kkQ1kQ0070P33sDXwMsy7wARlmQlX6QMzlXC1XaAslXyDwkC6Qnz6Aszn0sMqDwMlXUC3VXMs1X760M6C7VU6AATlyTkQ7wMksz3sS0kDlW"
, HARDFIN_TEXT := "|<1-Ch. 1-1>*156$67.00006000000000730000001k0DtU00C00ts0CMk00D00zw0C0T00DU1yi0C0Ds04k0L70706Q00M03XXvU3600AT1llxk1X0067Uss0M0lU0300QQ0C0MlU1U0CC03zANk0k07300z6AM0M03k"
, FALSEHARDFIN_TEXT := "|<Ch. 1-4>*153$54.00k0000001kk000000Dwk00700CCMk00D00SQ0y00T00ys0zU0H01ys0nU0301is0lU037nCs0lU033rzM0lU0307zQ0lX0300CDwlb0300C7slX03006U"
, HARDZEROMENU_TEXT := "|</3>*51$17.zDzwTzsUTn0T7wyDtwzntw7XsDDyATwMzsns17k6DkwzzlzzbzzU"
, HARDZEROBATTLE_TEXT := "|<Replay (Dark_BG)>*80$54.00000A000zU000A000zk000A000ss000A000ssT3wATb7sMzbyADX7ttnbCA1n6zlzb7A7nazlzb7ATnitlzb7Axlgttk77Atlwssz7yCxkwsQzbyCTks08D7s2DUs00070003k00070007k000200030U"
, BATTLEPREP_TEXT := "|<Party>*140$42.0Tzztzz0DzztzzD7zztzzDa3kM8sD6FkM8t67tntwt0D1ntwl0w1ntyHDwtntyHDwtnty3Dw1nsD7Dy1nwD7zzzzzzDzzzzzsDzzzzzsTU"
, HASBATTLES_TEXT := "|<Prepare (Light BG)>*143$62.UTzzzzzzzzk3zzzzzzzzwQTzzzzzzzz7b3kw3sD1sltUk70S1kM0QNwtnXyQyQ06TCQwzbDD07bU3DC1nk0Ttsznn6QwT7yTDwsnbD7lzblz4QtnswTty1k70Qz0zzzzwzzzzzzzzzzDzzzzzzzzznzzzzzU"
, EVNTFIN_TEXT := "|<HARD 1>*152$58.000060A003UkC1z3z00y30w7yDy0DsA6kMMkQ1zUkP1Vn1k4zz3i66A303sAQQTkkA0DUlzlb30k0y37z6AA703sAsCMsks0DUn0NVnz00q3A1a3Dk03U"
, EVNTQUEST_TEXT := "|<Quest>*148$48.s3zzzzzbk1zzzzzbXszzzzzbbstnkS3UbwtnUAHU7wtn7Azbbwtn0ADbbwtn0C3bXstn7zVbXltn7zlbk1s3UA3Us7w3kA3kzDzzzzzzz1zzzzzzzVzzzzzzU"

RetrieveEmulatorPos()
{
    ; Make sure to rename the Bluestacks emulator containing Azur Lane to "Azur Lane"
    ; Using WinGetPosEx because WinGetPos (vanilla command is somewhat buggy)
    hWnd := WinExist("Fantastic Days")
    WinGetPosEx(hWnd, KONOFAN_X, KONOFAN_Y, KONOFAN_W, KONOFAN_H)
    
    ; Bluestacks' toolbar is a flat 40 (no matter the resolution), and it's not included in ControlClick's scope
    ; Exclude the emulator's toolbar in the dimensions
    KONOFAN_Y += 40, KONOFAN_H -= 40
    if (KONOFAN_X = "" || KONOFAN_X < 0) {
        Msgbox, 0, % " Konofan Helper", % "Emulator seems to be out of bounds. Please make sure that it is COMPLETELY visible on the screen and recalibrate by restarting the monitoring status. " . "X: " KONOFAN_X . " Y: " KONOFAN_Y "." 
        exit
    }
    if (KONOFAN_W != 800)
    {
        Msgbox, 0, % " Konofan Helper", % "Looks like you're not using a supported resolution, hit Ctrl + F8 to fix this."
        DisableAll()
        Exit
    }
}

class EventModeCheck
{
    eventModeDone()
    {
        return ScanRegion(EVNTFIN_TEXT, 2)
    }

    onQuestMenu()
    {
        return ScanRegion(EVNTQUEST_TEXT, 1)
    }
}

class HardModeCheck
{
    ; Pls start at chapter 6-4 with 720 meat supply
    ; Use Melissa + Iris + Emilia whenever possible
    normalModeDone() ; Added FALSEHARDFIN_TEXT because Hard Chap. 1-4 seems to trigger HARDFIN_TEXT
    {
        return ( ScanRegion(HARDFIN_TEXT, 2) && !(ScanRegion(FALSEHARDFIN_TEXT, 2)) )
    }

    hasBattles()
    {
        return ScanRegion(HASBATTLES_TEXT, 9)
    }

    zeroBattles()
    {
        return ScanRegion(HARDZEROMENU_TEXT, 9)
    }
}

class LevelWinCheck
{
    onMainMenu()
    {
        return ScanRegion(MAINMENU_TEXT, 1)
    }

    onPreparation()
    {
        return ScanRegion(BATTLEPREP_TEXT, 1)
    }

    onRewards()
    {
        return ScanRegion(REWARDS_TEXT, 8)
    }
    
    onReplay()
    {
        return ScanRegion(REPLAY_TEXT, 8)
    }

    onConfirmation()
    {
        return ScanRegion(REPLAYCONF_TEXT, 2, 0.15, 0.15)
    }

    zeroMeat()
    {
        return ScanRegion(ZEROMEAT_TEXT, 10)
    }

    cantBattle()
    {
        return ScanRegion(HARDZEROBATTLE_TEXT, 8)
    }
}

ScanRegion(inputText, Region, err1 := 0, err2 := 0)
{      
    /*
    ; Regions look like this
    ;   0 = entire region
    ;
    ;   1 | 2 | 3
    ;   4 | 5 | 6
    ;   7 | 8 | 9
    ;
    ;   |    10    |
    ;   |__________|
    ;   |          |
    ;   |    11    |
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
        default:
            Msgbox, 0, % " Konofan Helper", % "Selected region to be scanned is out of bounds."
            return
    }
}