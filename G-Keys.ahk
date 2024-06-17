#Requires AutoHotkey v2.0

#Include Include/Initialize.ahk
#Include Include/WaveLink.ahk
#Include Include/AutoOpen.ahk

; Scan Code & Virtual Key reference: https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/

; Mouse
; ==========

#HotIf WinActive("ahk_exe WindowsTerminal.exe") or WinActive("ahk_class Engine") or WinActive("ahk_exe Photoshop.exe") or WinActive("ahk_exe ahk_exe FontLab 8.exe")
*F13:: Send "{RCtrl down}{RShift down}{Tab}{RShift up}{RCtrl up}"
*F14:: Send "{RCtrl down}{Tab}{RCtrl up}"

#HotIf WinActive("ahk_exe rider64.exe") or WinActive("ahk_exe rustrover64.exe")
*F13:: Send "{RAlt down}{Left}{RAlt up}"
*F14:: Send "{RAlt down}{Right}{RAlt up}"

#HotIf WinActive("ahk_exe chrome.exe") or WinActive("ahk_exe msedge.exe") or WinActive("ahk_exe Gtuner.exe") or WinActive("ahk_exe explorer.exe")
*F13:: Send "{RCtrl down}{RShift down}{Tab}{RShift up}{RCtrl up}"
*F14:: Send "{RCtrl down}{Tab}{RCtrl up}"
*F15:: Send "{RCtrl down}{t}{RCtrl up}"                          ; -- New Tab
<^F15:: Send "{RCtrl down}{w}{RCtrl up}"                         ; -- Close Tab
<+F15:: Send "{RCtrl down}{y}{RCtrl up}"                         ; -- Duplicate Tab
<!F15:: Send "{RCtrl down}{RShift down}{t}{RShift up}{RCtrl up}" ; -- Restore Closed Tab
; ^Tab::Send "{U+0009}" ; literal tab input

#HotIf WinActive("ahk_exe code.exe") or WinActive("ahk_exe gimp-2.10.exe")
*F13:: Send "{RCtrl down}{PgUp}{RCtrl up}"
*F14:: Send "{RCtrl down}{PgDn}{RCtrl up}"
*F15:: Send "{RCtrl down}{n}{RCtrl up}"                          ; -- New Tab
<^F15:: Send "{RCtrl down}{w}{RCtrl up}"                         ; -- Close Tab
<!F15:: Send "{RCtrl down}{RShift down}{t}{RShift up}{RCtrl up}" ; -- Restore Closed Tab

#HotIf WinActive("ahk_exe devenv.exe") ; Visual Studio
*F13:: Send "{RCtrl down}{RAlt down}{PgUp}{RAlt up}{RCtrl up}"
*F14:: Send "{RCtrl down}{RAlt down}{PgDn}{RAlt up}{RCtrl up}"

#HotIf WinActive("ahk_exe mpc-be64.exe")    ; Media Player Classic - Black Edition
*F13:: Send "{RCtrl down}{Left}{RCtrl up}"  ; -- Backward 1 frame
*F14:: Send "{RCtrl down}{Right}{RCtrl up}" ; -- Forward 1 frame

#HotIf WinActive("ahk_exe dontstarve_steam.exe") or WinActive("ahk_exe dontstarve_steam_x64.exe") ; Don't Starve
*F13:: Send "{q}" ; -- Rotate Left
*F14:: Send "{e}" ; -- Rotate Right

#HotIf WinActive("ahk_exe CULTIC.exe")
*F15:: Send "{q}"

#HotIf WinActive("ahk_exe hl2.exe")
*F15:: Send "{v}"

#HotIf WinActive("ahk_exe eggwife-Win64-Shipping.exe")
*F15:: SendEvent "{Blind}{c}"

#HotIf WinActive("ahk_exe Postal2.exe")
	or WinActive("ahk_exe ParadiseLost.exe")
	or WinActive("ahk_exe Postal4-Win64-Shipping.exe") ; Postal
*F13:: Send "{Blind}{[}"
*F14:: Send "{Blind}{]}"
*F15:: Send "{Blind}{\}"

#HotIf WinActive("Nightmare Reaper")
*F15:: Send "{Blind}{\ down}"
*F15 up:: Send "{Blind}{\ up}"

#HotIf WinActive("ahk_class TscShellContainerClass")
~vkFF::
{
	; An artificial vkFF keystroke is detected when the RDP client becomes active.
	; At that point, the RDP client installs its own keyboard hook which takes
	; precedence over ours, so…
	if (A_TimeIdlePhysical > A_TimeSinceThisHotkey)
	{
		Suspend True
		Suspend False ; …reinstall our hook.
		Sleep 50
	}
}

; This is mainly done so that they aren't treated as mouse "clicks"
; if not actually focused on a window yet.
#HotIf
*F13::
{
	if GetKeyState("ScrollLock", "T")
		Send "{XButton1}"
	else if GetKeyState("CapsLock", "T")
		Send "{WheelLeft}"
	else
		Send "{Browser_Back}"
}
*F14::
{
	if GetKeyState("ScrollLock", "T")
		Send "{XButton2}"
	else if GetKeyState("CapsLock", "T")
		Send "{WheelRight}"
	else
		Send "{Browser_Forward}"
}

; Virtual Keys: http://www.kbdedit.com/manual/low_level_vk_list.html

; G Keys
; ==========

*SC073:: ;G1
{
	; Mic mute toggle
	try SoundSetMute -1, , "Mic In"
	Send "{SC073 down}"
}
*SC073 up::
{
	Send "{SC073 up}"
}

*SC070:: ;G2
{
	Send "{SC070 down}"
	; Open key history, scroll down
	KeyHistory
	Send "{F5}"
}
*SC070 up::
{
	Send "{SC070 up}"
}

*SC07D:: ;G3
{
	Send "{SC07D down}"
}
*SC07D up::
{
	Send "{SC07D up}"
}

*SC079:: ;G4
{
	Send "{SC079 down}"
}
*SC079 up::
{
	Send "{SC079 up}"
}

*SC07B:: ;G5
{
	; Open explorer shortcut
	if WinActive("ahk_exe code.exe") or WinActive("ahk_exe Unity.exe") or WinActive("ahk_exe rider64.exe") or WinActive("ahk_class Engine")
		Send "{RAlt down}{RShift down}{R}{RShift up}{RAlt up}"
	if WinActive("ahk_exe rider64.exe") or WinActive("ahk_exe rustrover64.exe")
		Send "{RCtrl down}{RAlt down}{RShift down}{R}{RShift up}{RAlt up}{RCtrl up}"
	if WinActive("ahk_exe devenv.exe")
	{
		Send "{RAlt down}{RCtrl down}{RShift down}"
		Sleep 1
		Send "{E}"
		Sleep 1
		Send "{RShift up}{RCtrl up}{RAlt up}"
	}
	if WinActive("ahk_exe plastic.exe")
		Send "{RCtrl down}{RShift down}{S}{RShift up}{RCtrl up}"
	Send "{SC07B down}"
	return
}
*SC07B up::
{
	Send "{SC07B up}"
	return
}

*SC07E:: ;G6
{
	; Emergency undo when hotkey modifiers seem down for no reason
	Send "{LCtrl up}{LAlt up}{LShift up}{LWin up}{RCtrl up}{RAlt up}{RShift up}{RWin up}"
	Send "{SC07E down}"
	return
}
*SC07E up::
{
	Send "{SC07E up}"
	return
}
