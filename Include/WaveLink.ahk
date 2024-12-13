#Requires AutoHotkey v2.0

if (A_ScriptFullPath = A_LineFile)
{
	MsgBox("This script is not meant to be executed.", , 16)
	ExitApp 2
}

class MediaKey
{
	__New(name)
	{
		this.DeviceName := "Wave Link " name
		this.IniName := StrReplace(name, A_Space)
		this.Volume := IniRead("G-Keys.ini", "WaveLink", this.IniName "Volume", 50)
		this.Muted := IniRead("G-Keys.ini", "WaveLink", this.IniName "Muted", false)

		SoundSetVolume(this.Volume, , this.DeviceName)
		SoundSetMute(this.Muted, , this.DeviceName)
	}

	Save()
	{
		IniWrite(this.Volume, "G-Keys.ini", "WaveLink", this.IniName "Volume")
		IniWrite(this.Muted, "G-Keys.ini", "WaveLink", this.IniName "Muted")
	}

	UpdateMute()
	{
		this.Muted := !this.Muted
		SoundSetMute(this.Muted, , this.DeviceName)
	}

	RaiseVolume()
	{
		this.Volume := Min(100, this.Volume + 1)
		SoundSetVolume(this.Volume, , this.DeviceName)
	}

	LowerVolume()
	{
		this.Volume := Max(0, this.Volume - 1)
		SoundSetVolume(this.Volume, , this.DeviceName)
	}
}

class WaveLink extends Gui
{
	MediaKeyIndex := IniRead("G-Keys.ini", "WaveLink", "MediaKeyIndex", 1)
	SoundDevices := [MediaKey("System"), MediaKey("Voice Chat"), MediaKey("Browser"), MediaKey("Music")]

	__New()
	{
		super.__New("+AlwaysOnTop +ToolWindow -Caption", "Volume MultiMix", this)

		this.BackColor := "Black"
		WinSetTransColor("FEFEFE 230", this)
		this.SetFont("cWhite", "Segoe UI")
		this.Add("Text", "vTxt" 1 " w40 Center Section", this.MixerLabel("System", this.SoundDevices[1].Volume))
		this.Add("Progress", "vBar" 1 " h100 w10 xp+15 yp+22 Center Vertical", this.SoundDevices[1].Volume)
		this.Add("Text", "vTxt" 2 " w40 Center ys", this.MixerLabel("Voice", this.SoundDevices[2].Volume))
		this.Add("Progress", "vBar" 2 " h100 w10 xp+15 yp+22 Center Vertical", this.SoundDevices[2].Volume)
		this.Add("Text", "vTxt" 3 " w40 Center ys", this.MixerLabel("Browser", this.SoundDevices[3].Volume))
		this.Add("Progress", "vBar" 3 " h100 w10 xp+15 yp+22 Center Vertical", this.SoundDevices[3].Volume)
		this.Add("Text", "vTxt" 4 " w40 Center ys", this.MixerLabel("Music", this.SoundDevices[4].Volume))
		this.Add("Progress", "vBar" 4 " h100 w10 xp+15 yp+22 Center Vertical", this.SoundDevices[4].Volume)
	}

	Save()
	{
		if not FileExist("G-Keys.ini")
			FileAppend("", "G-Keys.ini", "UTF-8-RAW")

		IniWrite(this.MediaKeyIndex, "G-Keys.ini", "WaveLink", "MediaKeyIndex")
		Loop 4
		{
			this.SoundDevices[A_Index].Save()
		}
		this.Hide()
	}

	Display()
	{
		this.Show("x10 y50 NoActivate")
		Loop 4
		{
			this["Bar" A_Index].Opt(this.MediaKeyIndex = A_Index ? "cGreen" : "cBlue")
			this["Bar" A_Index].Opt(this.SoundDevices[A_Index].Muted = 0 ? "BackgroundDefault" : "BackgroundMaroon")
		}

		static Timer := ObjBindMethod(this, "Save")
		SetTimer Timer, -1400
	}

	UpdateIndex(index)
	{
		this.MediaKeyIndex := Integer(Max(Min(index, 4), 1))
		this.Display()
	}

	UpdateMute()
	{
		this.SoundDevices[this.MediaKeyIndex].UpdateMute()
		this.Display()
	}

	RaiseVolume()
	{
		this.SoundDevices[this.MediaKeyIndex].RaiseVolume()
		volume := this.SoundDevices[this.MediaKeyIndex].Volume
		name := StrSplit(this.SoundDevices[this.MediaKeyIndex].DeviceName, A_Space)[3]
		this["Txt" this.MediaKeyIndex].Value := this.MixerLabel(name, volume)
		this["Bar" this.MediaKeyIndex].Value := volume
		this.Display()
	}

	LowerVolume()
	{
		this.SoundDevices[this.MediaKeyIndex].LowerVolume()
		volume := this.SoundDevices[this.MediaKeyIndex].Volume
		name := StrSplit(this.SoundDevices[this.MediaKeyIndex].DeviceName, A_Space)[3]
		this["Txt" this.MediaKeyIndex].Value := this.MixerLabel(name, volume)
		this["Bar" this.MediaKeyIndex].Value := volume
		this.Display()
	}

	ToDecibel(volume)
	{
		return Round(20 * Log(volume) - 40, 1)
	}

	MixerLabel(string, volume)
	{
		return string "`n`n`n`n`n`n`n`n`n`n" this.ToDecibel(volume) " dB`n" volume
	}
}

; Migrated to Stream Deck for audio control
; WaveLinkSingleton := WaveLink()
; *Media_Stop:: WaveLinkSingleton.UpdateIndex(1)
; *Media_Prev:: WaveLinkSingleton.UpdateIndex(2)
; *Media_Play_Pause:: WaveLinkSingleton.UpdateIndex(3)
; *Media_Next:: WaveLinkSingleton.UpdateIndex(4)
; *Volume_Mute:: WaveLinkSingleton.UpdateMute()
; *Volume_Up:: WaveLinkSingleton.RaiseVolume()
; *Volume_Down:: WaveLinkSingleton.LowerVolume()

; Alternative implementation
try {
	if SoundGetVolume(, "Wave Link System") == 100
		and SoundGetVolume(, "Wave Link Voice Chat") == 100
		and SoundGetVolume(, "Wave Link Browser") == 100
		and SoundGetVolume(, "Wave Link Music") == 100 {
		SoundSetVolume(50, , "Wave Link System")
		SoundSetVolume(50, , "Wave Link Voice Chat")
		SoundSetVolume(50, , "Wave Link Browser")
		SoundSetVolume(50, , "Wave Link Music")
	}
}
