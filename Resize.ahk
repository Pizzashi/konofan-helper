ResizeEmu()
{
    hWnd := WinExist("Fantastic Days")
    if (hWnd = 0) {
        Msgbox, 0, % " Konofan Helper", % "Can't find the Bluestacks window. Please make sure it is renamed to ""Fantastic Days"" (without the quotes)."
        exit
    }
    WinGetPosEx(hWnd,,, tempW, tempH)

    if (tempW = 800) {
        Msgbox, 0, % " Konofan Helper", % "The emulator is in a supported resolution."
        return
    } else {
        Alert("Onii-sama, please wait for a bit.", false, false)
        Loop
        {
            if (tempW = 800) {
                Unalert()
                Msgbox, 0, % " Konofan Helper", % "The emulator is now in a supported resolution."
                break
            }
            if (A_Index = 10) {
                Unalert()
                Msgbox, 0, % " Konofan Helper", % "Error: The emulator cannot be resized properly. Please move the window around, resize it arbitrarily, minimize other windows, and try again."
                break
            }

            WinActivate, Fantastic Days
            WinMove, Fantastic Days,,,, 800, 490
            WinGetPosEx(hWnd,,, tempW, tempH)
        }
    }
}