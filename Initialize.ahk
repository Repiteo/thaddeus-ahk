#Include PreventStandalone.ahk
#Requires AutoHotkey v2.0

; Check for UI Access
; ==========
if (!A_IsCompiled && !InStr(A_AhkPath, "_UIA.exe"))
{
	Run "*UIAccess " A_ScriptFullPath
	ExitApp
}

; Initialize
; ==========

A_ScriptName := "G-Keys"  ; Clean script name
A_IconTip := A_ScriptName ; Tooltip matches script name
#SingleInstance Ignore    ; No longer need "ignore" because of UI Access (ie: no need to run as admin)
#WinActivateForce         ; Allegedly helps with flickering, may need more tests
SetWorkingDir A_ScriptDir ; Consistent working directory
ProcessSetPriority "High" ; Not sure if this will ever matter, but it's a safety net

SetKeyDelay 0, 0
KeyHistory 500
InstallKeybdHook
InstallMouseHook
A_MaxHotkeysPerInterval := 200

; Only worry about a tray icon if not compiled
if not A_IsCompiled
	TraySetIcon "G-Keys.ico"

; TODO: See if opening programs is feasible if hidden windows can be detected, commented out for now
; DetectHiddenWindows True
; DetectHiddenText    True

; Startup commands
; ==========

SetNumLockState 1
SetCapsLockState 0
SetScrollLockState 0

; Hotkey modfiers start explicit up in case a reset is needed
Send "{LCtrl up}{LAlt up}{LShift up}{LWin up}{RCtrl up}{RAlt up}{RShift up}{RWin up}"
