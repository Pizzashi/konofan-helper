;====================Compiler directives====================;
;@Ahk2Exe-SetName Konofan Helper
;@Ahk2Exe-SetMainIcon Main.ico
;@Ahk2Exe-AddResource Main.ico, 160  ; Replaces 'H on blue'
;@Ahk2Exe-AddResource Main.ico, 206  ; Replaces 'S on green'
;@Ahk2Exe-AddResource Main.ico, 207  ; Replaces 'H on red'
;@Ahk2Exe-AddResource Main.ico, 208  ; Replaces 'S on red'
;@Ahk2Exe-SetCopyright Copyright @ Baconfry 2021
;@Ahk2Exe-SetCompanyName Furaico
;@Ahk2Exe-SetVersion 0.0.0.1
;===========================================================;

global APP_VERSION := "Konofan Helper v0.0.0.1"
#NoEnv                                          ; Needed for blazing fast performance
#SingleInstance, Force                          ; Allows only one instance of the script to run
SetWorkingDir %A_ScriptDir%                     ; Needed by some functions to work properly
; This code appears only in the compiled script
/*@Ahk2Exe-Keep
ListLines Off                                   ; Turns off logging script actions for improved performance
#KeyHistory 0                                   ; Turns off loggins keystrokes for improved performance
*/

; This code appears only in the compiled script
/*@Ahk2Exe-Keep
Menu, Tray, Add, %APP_VERSION%, QuitHelper
Menu, Tray, Disable, %APP_VERSION%
Menu, Tray, Add ; Adds line separator
Menu, Tray, NoStandard
Menu, Tray, Add, Exit, QuitHelper
*/

#Include Assets.ahk
#Include Checks.ahk
#Include Click.ahk
#Include Resize.ahk
#Include GUI.ahk
#Include Push.ahk
#Include FindText.ahk
#Include WinGetPosEx.ahk

global LEVEL_REPEAT := 0
     , HARD_GRIND := 0
     , EVENT_GRIND := 0
     , NOTIFY_EVENTS := 0

UpdateTrayStatus() ; Initial tray update

; Ctrl + F12 = Repeat a certain level till you run out of meat (useful for farming an event stage for tickets) [RED BORDER]
; Ctrl + F11 = Normal hard mode grinder [ORANGE BORDER]
; Ctrl + F10 = Event hard mode grinder [YELLOW BORDER]
; Ctrl + F9 = Resize the window to a supported resolution.

^F12::
    if (LEVEL_REPEAT) {
        LEVEL_REPEAT := 0
        UpdateTrayStatus()
        DisableAll()
        Alert("Onii-sama, level grinding is now off.", true, false)
    } else {
        DisableAll()
        RetrieveEmulatorPos()
        SetTimer, LevelFarmer, 1000
        SetTimer, CrashTest, 5000
        LEVEL_REPEAT := 1
        UpdateTrayStatus()
        PaintWindow()
        Alert("Onii-sama, level grinding is now on.", true, false)
    }
return

^F11::
    if (HARD_GRIND) {
        HARD_GRIND := 0
        UpdateTrayStatus()
        DisableAll()
        Alert("Onii-sama, hard mode grinding is now off.", true, false)
    } else {
        DisableAll()
        RetrieveEmulatorPos()
        SetTimer, HardGrinder, 1000
        SetTimer, CrashTest, 5000
        HARD_GRIND := 1
        UpdateTrayStatus()
        PaintWindow()
        Alert("Onii-sama, hard mode grinding is now on.", true, false)
    }
return

^F10::
    if (EVENT_GRIND) {
        EVENT_GRIND := 0
        UpdateTrayStatus()
        DisableAll()
        Alert("Onii-sama, event hard mode grinding is now off.", true, false)
    } else {
        DisableAll()
        RetrieveEmulatorPos()
        SetTimer, EventGrinder, 1000
        SetTimer, CrashTest, 5000
        EVENT_GRIND := 1
        UpdateTrayStatus()
        PaintWindow()
        Alert("Onii-sama, event hard mode grinding is now on.", true, false)
    }
return

^F9::
    if (NOTIFY_EVENTS) {
        NOTIFY_EVENTS := false
        UpdateTrayStatus()
        Alert("Onii-sama, phone notifications are now off.", true, false)
    }
    else {
        NOTIFY_EVENTS := true
        UpdateTrayStatus()
        Alert("Onii-sama, phone notifications are now on.", true, true, false)
    }
return

^F8::ResizeEmu()

UpdateTrayStatus()
{
    levelGrinder := (LEVEL_REPEAT) ? "on" : "off"
    , hardGrinder := (HARD_GRIND) ? "on" : "off"
    , eventGrinder := (EVENT_GRIND) ? "on" : "off"
	, pushNotifications := (NOTIFY_EVENTS) ? "on" : "off"
    Menu, Tray, Tip, % "Level Grinder: " levelGrinder "`n"
                     . "Hard Autopilot: " hardGrinder "`n"
                     . "Event Autopilot: " eventGrinder "`n`n"
                     . "Push Notifications: " pushNotifications
}

DisableAll()
{
    SetTimer, CrashTest, Off
    ; LevelGrind
    SetTimer, LevelFarmer, Off
    SetTimer, ReplayWinCheck, Off
    SetTimer, ConfirmationWinCheck, Off
    SetTimer, ZeroMeatCheck, Off
    LEVEL_REPEAT := 0
    ; Normal Hard Mode grinder
    SetTimer, HardGrinder, Off
    SetTimer, ReplayWinCheckH, Off
    SetTimer, ConfirmationWinCheckH, Off
    SetTimer, AvailLevelPickerH, Off
    SetTimer, PreparationCheckH, Off
    SetTimer, ZeroMeatCheckH, Off
    HARD_GRIND := 0
    ; Event Hard Mode grinder
    SetTimer, EventGrinder, Off
    SetTimer, ReplayWinCheckE, Off
    SetTimer, ConfirmationWinCheckE, Off
    SetTimer, AvailLevelPickerE, Off
    SetTimer, PreparationCheckE, Off
    SetTimer, ZeroMeatCheckE, Off
    EVENT_GRIND := 0

    UpdateTrayStatus()
    PaintWindow(0)
    return
}

CrashTest:
    if (LevelWinCheck.onMainMenu())
    {
        SetTimer, CrashTest, Off
        Alert("Onii-sama, the game has crashed.", false, true)
        DisableAll()
    }
return

;=====================LevelFarmer subroutines=====================;
LevelFarmer:
    if (LevelWinCheck.onAffinityScrn())
    {
        Click.affinityScreen()
    }
    else if (LevelWinCheck.onRewards())
    {
        Click.rewardsWindow()
        SetTimer, LevelFarmer, Off
        SetTimer, ReplayWinCheck, 1000
    }
return

ReplayWinCheck:
    if (LevelWinCheck.onReplay())
    {
        Click.replayWindow()
        SetTimer, ReplayWinCheck, Off
        SetTimer, ConfirmationWinCheck, 1000
    }
return

ConfirmationWinCheck:
    if (LevelWinCheck.onConfirmation())
    {
        Sleep, 250
        Click.replayConfirmation()
        SetTimer, ZeroMeatCheck, -1000 ; Check if meat is not enough for another battle
        SetTimer, ConfirmationWinCheck, Off
        SetTimer, LevelFarmer, 1000
    }
return

ZeroMeatCheck:
    if (LevelWinCheck.zeroMeat()) ; Farming is finished
    {
        Alert("Onii-sama, level grinding is complete.", true, false)
        DisableAll()
    }
return
;=================================================================;

;=====================HardGrinder subroutines=====================;
HardGrinder:
    if (LevelWinCheck.onAffinityScrn())
    {
        Click.affinityScreen()
    }
    else if (LevelWinCheck.onRewards())
    {
        Click.rewardsWindow()
        SetTimer, HardGrinder, Off
        SetTimer, ReplayWinCheckH, 3500
    }
return

ReplayWinCheckH:
    if (LevelWinCheck.onReplay()) ; CASE 1: There's still battles
    {
        Click.replayWindow()
        SetTimer, ReplayWinCheckH, Off
        SetTimer, ConfirmationWinCheckH, 1000
    }
    else if (LevelWinCheck.cantBattle()) ; CASE 2: Out of battles
    {
        Click.battleNext()
        SetTimer, ReplayWinCheckH, Off
        SetTimer, AvailLevelPickerH, 1000
    }
return

ConfirmationWinCheckH: ; The only subroutine action for CASE 1
    if (LevelWinCheck.onConfirmation())
    {
        Sleep, 250
        Click.replayConfirmation()
        SetTimer, ZeroMeatCheckH, -1000 ; Check if meat is not enough for another battle
        SetTimer, ConfirmationWinCheckH, Off
        SetTimer, HardGrinder, 1000
    }
return

AvailLevelPickerH: ; This and the subroutine below are the actions for CASE 2
    noBattlesLeft := HardModeCheck.zeroBattles()

    if (HardModeCheck.normalModeDone() && noBattlesLeft) ; Done
    {
        Alert("Onii-sama, hard mode grinding is complete.", true, false)
        DisableAll()
    }
    else if (noBattlesLeft)
    {
        Click.hardPrevArrow()
    }
    else if (HardModeCheck.hasBattles())
    {
        Sleep, 500
        Click.battlePreparation()
        SetTimer, AvailLevelPickerH, Off
        SetTimer, PreparationCheckH, 1000
    }
return

PreparationCheckH:
    if (LevelWinCheck.onPreparation())
    {
        Click.battleBegin()
        SetTimer, PreparationCheckH, Off
        SetTimer, HardGrinder, 1000
    }
return

ZeroMeatCheckH:
    if (LevelWinCheck.zeroMeat()) ; Farming is finished
    {
        Alert("Onii-sama, we ran out of stamina.", true, false)
        DisableAll()
    }
return
;=================================================================;

;====================EventGrinder subroutines=====================;
EventGrinder:
    if (LevelWinCheck.onAffinityScrn())
    {
        Click.affinityScreen()
    }
    else if (LevelWinCheck.onRewards())
    {
        Click.rewardsWindow()
        SetTimer, EventGrinder, Off
        SetTimer, ReplayWinCheckE, 3500
    }
return

ReplayWinCheckE:
    if (LevelWinCheck.onReplay()) ; CASE 1: There's still battles
    {
        Click.replayWindow()
        SetTimer, ReplayWinCheckE, Off
        SetTimer, ConfirmationWinCheckE, 1000
    }
    else if (LevelWinCheck.cantBattle()) ; CASE 2: Out of battles
    {
        Click.battleNext()
        SetTimer, ReplayWinCheckE, Off
        SetTimer, AvailLevelPickerE, 1000
    }
return

ConfirmationWinCheckE: ; The only subroutine action for CASE 1
    if (LevelWinCheck.onConfirmation())
    {
        Sleep, 250
        Click.replayConfirmation()
        SetTimer, ZeroMeatCheckE, -1000 ; Check if meat is not enough for another battle
        SetTimer, ConfirmationWinCheckE, Off
        SetTimer, EventGrinder, 1000
    }
return

AvailLevelPickerE: ; This and the subroutine below are the actions for CASE 2
    noBattlesLeft := HardModeCheck.zeroBattles()

    if (EventModeCheck.eventModeDone() && noBattlesLeft) ; Done
    {
        Alert("Onii-sama, event hard mode grinding is complete.", true, false)
        DisableAll()
    }
    else if (noBattlesLeft)
    {
        Click.hardPrevArrow()
    }
    else if (HardModeCheck.hasBattles())
    {
        Sleep, 500
        Click.battlePreparation()
        SetTimer, AvailLevelPickerE, Off
        SetTimer, PreparationCheckE, 1000
    }
    else if (EventModeCheck.onQuestMenu())
    {
        Click.eventHardFour()
    }
return

PreparationCheckE:
    if (LevelWinCheck.onPreparation())
    {
        Click.battleBegin()
        SetTimer, PreparationCheckE, Off
        SetTimer, EventGrinder, 1000
    }
return

ZeroMeatCheckE:
    if (LevelWinCheck.zeroMeat()) ; Farming is finished
    {
        Alert("Onii-sama, we ran out of stamina.", true, false)
        DisableAll()
    }
return
;=================================================================;

QuitHelper:
ExitApp