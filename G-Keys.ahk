#Requires AutoHotkey v2.0

#Include Include/Initialize.ahk
#Include WaveLink.ahk

; Scan Code & Virtual Key reference: https://docs.google.com/spreadsheets/d/1GSj0gKDxyWAecB3SIyEZ2ssPETZkkxn67gdIwL1zFUs/

; Variables
; ==========

CanBuffer := 0  ; Global buffer variable for timer when default scroll is too fast

; Functions
; ==========

doBuffer()
{
	global
	CanBuffer := 0
	return
}

; Mouse
; ==========

; Virtual Keys: http://www.kbdedit.com/manual/low_level_vk_list.html

#HotIf WinActive("ahk_exe WindowsTerminal.exe") or WinActive("ahk_class Engine")
*XButton1:: Send "{RCtrl down}{RShift down}{Tab}{RShift up}{RCtrl up}"
*XButton2:: Send "{RCtrl down}{Tab}{RCtrl up}"

#HotIf WinActive("ahk_exe rider64.exe")
*XButton1:: Send "{RAlt down}{Left}{RAlt up}"
*XButton2:: Send "{RAlt down}{Right}{RAlt up}"

#HotIf WinActive("ahk_exe chrome.exe") or WinActive("ahk_exe msedge.exe") or WinActive("ahk_exe Gtuner.exe") or WinActive("ahk_exe explorer.exe")
*XButton1:: Send "{RCtrl down}{RShift down}{Tab}{RShift up}{RCtrl up}"
*XButton2:: Send "{RCtrl down}{Tab}{RCtrl up}"
*F13:: Send "{RCtrl down}{t}{RCtrl up}"  ; VK54 = t                -- New Tab
<^F13:: Send "{RCtrl down}{w}{RCtrl up}" ; VK57 = w                -- Close Tab
<+F13:: Send "{RCtrl down}{y}{RCtrl up}" ; VK59 = y                -- Duplicate Tab
<!F13:: Send "{RCtrl down}{RShift down}{t}{RShift up}{RCtrl up}" ; -- Restore Closed Tab
; ^Tab::Send "{U+0009}" ; literal tab input

#HotIf WinActive("ahk_exe code.exe") or WinActive("ahk_exe gimp-2.10.exe")
*XButton1:: Send "{RCtrl down}{PgUp}{RCtrl up}"
*XButton2:: Send "{RCtrl down}{PgDn}{RCtrl up}"
*F13:: Send "{RCtrl down}{n}{RCtrl up}"  ; VK4E = n              ; -- New Tab
<^F13:: Send "{RCtrl down}{w}{RCtrl up}"                         ; -- Close Tab
<!F13:: Send "{RCtrl down}{RShift down}{t}{RShift up}{RCtrl up}" ; -- Restore Closed Tab

#HotIf WinActive("ahk_exe devenv.exe") ; Visual Studio
*XButton1::
{
	Send "{RCtrl down}{RAlt down}"
	Sleep 1
	Send "{PgUp}"
	Sleep 1
	Send "{RAlt up}{RCtrl up}"
}
*XButton2::
{
	Send "{RCtrl down}{RAlt down}"
	Sleep 1
	Send "{PgDn}"
	Sleep 1
	Send "{RAlt up}{RCtrl up}"
}

#HotIf WinActive("ahk_exe mpc-be64.exe") ; Media Player Classic - Black Edition
*XButton1:: Send "{RCtrl down}{Left}{RCtrl up}" ; -- Backward 1 frame
*XButton2:: Send "{RCtrl down}{Right}{RCtrl up}" ; -- Forward 1 frame

#HotIf WinActive("ahk_exe dontstarve_steam.exe") or WinActive("ahk_exe dontstarve_steam_x64.exe") ; Don't Starve
*XButton1:: ; -- Rotate Left
{
	Send "{q down}" ; VK4E = q
	Sleep 100
	Send "{q up}"
}
*XButton2:: ; -- Rotate Right
{
	Send "{e down}" ; VK4E = e
	Sleep 100
	Send "{e up}"
}

#HotIf WinActive("ahk_exe CULTIC.exe")
*F13:: Send "{q}"

#HotIf WinActive("ahk_exe Inscryption.exe")
*XButton1:: Send "{Blind}{Left}"
*XButton2:: Send "{Blind}{Right}"

#HotIf WinActive("ahk_exe eggwife-Win64-Shipping.exe")
*F13:: SendEvent "{Blind}{c}" ; VK43 = C

#HotIf WinActive("ahk_exe Postal2.exe")
	or WinActive("ahk_exe ParadiseLost.exe")
	or WinActive("ahk_exe Postal4-Win64-Shipping.exe") ; Postal
*XButton1:: Send "{Blind}{[}" ; VKDB = [
*XButton2:: Send "{Blind}{[}" ; VKDD = ]
*F13:: Send "{Blind}{\}" ; VKDC = \

#HotIf WinActive("Nightmare Reaper")
*F13:: Send "{Blind}{\ down}"
*F13 up:: Send "{Blind}{\ up}"

#HotIf WinActive("ahk_exe Photoshop.exe")
*XButton1::
{
	global
	if (CanBuffer = 0)
	{
		Send "{RCtrl down}{RShift down}{Tab}{RShift up}{RCtrl up}"
		SetTimer(doBuffer, -100)
		CanBuffer := 1
	}
	return
}
*XButton1 up::
{
	global
	CanBuffer := 0
	return
}
*XButton2::
{
	global
	if (CanBuffer = 0)
	{
		Send "{RCtrl down}{Tab}{RCtrl up}"
		SetTimer(doBuffer, -100)
		CanBuffer := 1
	}
	return
}
*XButton2 up::
{
	global
	CanBuffer := 0
	return
}

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
; if not actually focused on a window yet
#HotIf
*XButton1:: Send "{Browser_Back}"    ; Alt of {XButton1}
*XButton2:: Send "{Browser_Forward}" ; Alt of {XButton2}

; G Keys
; ==========

*SC073:: ;G1
{
	; Mic mute toggle
	try SoundSetMute -1, , "Mic In"
	Send "{SC073 down}"
	return
}
*SC073 up::
{
	Send "{SC073 up}"
	return
}

*SC070:: ;G2
{
	Send "{SC070 down}"
	; Open key history, scroll down
	KeyHistory
	Send "{F5}"
	return
}
*SC070 up::
{
	Send "{SC070 up}"
	return
}

*SC07D:: ;G3
{
	Send "{SC07D down}"
	return
}
*SC07D up::
{
	Send "{SC07D up}"
	return
}

*SC079:: ;G4
{
	Send "{SC079 down}"
	return
}
*SC079 up::
{
	Send "{SC079 up}"
	return
}

*SC07B:: ;G5
{
	; Open explorer shortcut
	if WinActive("ahk_exe code.exe") or WinActive("ahk_exe Unity.exe") or WinActive("ahk_exe rider64.exe") or WinActive("ahk_class Engine")
		Send "{RAlt down}{RShift down}{R}{RShift up}{RAlt up}"
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

; Auto-open programs
; ==========

Loop
{
	if not ProcessExist("Unity Hub.exe")
	{
		try
		{
			Run "C:\Program Files\Unity Hub\Unity Hub.exe"
			WinWait "Unity Hub"
			WinClose "Unity Hub"
		}
	}
	if not WinExist("ahk_exe Discord.exe")
	{
		if ProcessExist("Discord.exe")
		{
			try
			{
				Run "C:\Users\Thaddeus\AppData\Local\Discord\Update.exe --processStart Discord.exe"
				WinWait "Discord"
				WinRestore "Discord"
				WinMinimize "Discord"
			}
		}
	}
	Sleep 1000
}
