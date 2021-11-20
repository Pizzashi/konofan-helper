ResizeEmu()
{
    hWnd := WinExist("Fantastic Days")
    WinGetPosEx(hWnd,,, tempW, tempH)

    if (tempW = 800) {
        Msgbox, 0, % " Konofan Helper", % "The emulator is in a supported resolution."
        return
    } else {
        Loop
        {
            if (tempW = 800) {
                Msgbox, 0, % " Konofan Helper", % "The emulator is now in a supported resolution."
                break
            }
            if (A_Index = 5) {
                Msgbox, 0, % " Konofan Helper", % "Error: The emulator cannot be resized properly. Please move it around, resize arbitrarily, minimize other windows, and try again."
                break
            }

            WinActivate, Fantastic Days
            WinMove, Fantastic Days,,,, 800, 490
            WinGetPosEx(hWnd,,, tempW, tempH)
        }
    }
}