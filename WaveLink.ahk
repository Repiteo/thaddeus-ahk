#Requires AutoHotkey v2.0

#Include Include/PreventStandalone.ahk

WaveLink := 0 ; 0 = initial value, -1 = not found, 1 = found

WaveLinkStartup()
{

}

WaveLinkValidate()
{

}

ToDecibel(volume)
{
	return Round(20 * Log(volume) - 40, 1)
}

MixerLabel(string, volume)
{
	return string "`n`n`n`n`n`n`n`n`n`n" ToDecibel(volume) " dB`n" volume
}
