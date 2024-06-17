#Requires AutoHotkey v2.0

if (A_ScriptFullPath = A_LineFile)
{
	MsgBox("This script is not meant to be executed.", , 16)
	ExitApp 2
}

class AutoOpen
{
	__New()
	{
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
	}
}

; Not really actively using this like I once was, safe to disable
; AutoOpenSingleton := AutoOpen()
