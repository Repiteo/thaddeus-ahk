#Requires AutoHotkey v2.0

; Ensure script isn't running as standalone
; ==========
if (A_ScriptFullPath = A_LineFile)
{
	MsgBox("This script is not meant to be executed.",,16)
	ExitApp 2
}
