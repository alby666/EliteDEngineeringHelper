; ===========================================================
; Script execution behavior
; You can ignore this first section
; ===========================================================
; Recommended for performance and compatibility with future AutoHotkey releases
#NoEnv
; Force one instance of script
#SingleInstance Force
; Ensures a consistent starting directory
SetWorkingDir %A_ScriptDir%
; Delay between each command. Increase if operations are skipped
SetKeyDelay, 50, 50

; ===========================================================
; Information
; ===========================================================

; Script version: 0.1 (05-09-2024)
; See full script documentation at: https://github.com/<TBC>
; Script created by CMDR Byrne666

; Script inspired by https://github.com/mmseng/AislingMatHelper

; Requires AutoHotkey v1.1.31.00 or later

; Hotkey variables
; See these docs for the syntax for other keys and key modifiers (such as Ctrl):
; - https://www.autohotkey.com/docs/Hotkeys.htm
; - https://www.autohotkey.com/docs/KeyList.htm
Apply1Level = F1 ; Applies a single level of engineering
Apply2Levels = F2 ; Applies two levels of engineering, etc...
Apply3Levels = F3 
Apply4Levels = F4 
Apply5Levels = F5 

ReloadKey = F9 ; Kill and reload script (useful if things go wrong)
Kill = +F9 ; Kill script entirely (useful for when you're done playing)

; Menu navigation variables
KeyUp = w
KeyDown = s
KeyLeft = a
KeyRight = d
KeySelect = Space

; Audible feedback variables
EnableBeeps = True ; True = enable beeps to provide audible feedback when you press a hotkey, False = disable beeps
HighBeep = 2000 ; Frequency
MidBeep = 1500 ; Frequency
LowBeep = 1000 ; Frequency
BeepLength = 100 ; Milliseconds

; Delay after clicking "GENERATE MODIFICATION" on the engineering page
DelayLoop = 3500
DelayShortLoop = 400

; ===========================================================
; No need to edit below
; ===========================================================

; Map hotkeys to labels
Hotkey, %Apply1Level%, Engineer1
Hotkey, %Apply2Levels%, Engineer2
Hotkey, %Apply3Levels%, Engineer3
Hotkey, %Apply4Levels%, Engineer4
Hotkey, %Apply5Levels%, Engineer5
Hotkey, %ReloadKey%, JumpReload
Hotkey, %Kill%, JumpKill

; Beep to signal that initial processing is done and the script is awaiting hotkeys to be pressed
if(EnableBeeps) {
	SoundBeep, %HighBeep%, %BeepLength%
}

; End script until hotkey is pressed
Return

Engineer1:
    Gosub ApplySingleEngineeringLevel
    Beep("Complete")
    Return

Engineer2:
    Gosub ApplySingleEngineeringLevel
    Gosub SelectNextEngineeringLevel
    Gosub ApplySingleEngineeringLevel
    Beep("Complete")
    Return

Engineer3:
    Gosub ApplySingleEngineeringLevel
    Gosub SelectNextEngineeringLevel
    Gosub ApplySingleEngineeringLevel
    Gosub SelectNextEngineeringLevel
    Gosub ApplySingleEngineeringLevel
    Beep("Complete")
    Return

Engineer4:
    Gosub ApplySingleEngineeringLevel
    Gosub SelectNextEngineeringLevel
    Gosub ApplySingleEngineeringLevel
    Gosub SelectNextEngineeringLevel
    Gosub ApplySingleEngineeringLevel
    Gosub SelectNextEngineeringLevel
    Gosub ApplySingleEngineeringLevel
    Beep("Complete")
    Return

Engineer5:
    Gosub ApplySingleEngineeringLevel
    Gosub SelectNextEngineeringLevel
    Gosub ApplySingleEngineeringLevel
    Gosub SelectNextEngineeringLevel
    Gosub ApplySingleEngineeringLevel
    Gosub SelectNextEngineeringLevel
    Gosub ApplySingleEngineeringLevel
    Gosub SelectNextEngineeringLevel
    Gosub ApplySingleEngineeringLevel
    Beep("Complete")
    Return

ApplySingleEngineeringLevel: 
    global LevelsToApply

    ; Space 4 times to apply engineering (3 presses only required for lvl 1 but last keystoke does nothing)
    ; Select Generate Modification
    Send {%KeySelect%}
    Sleep %DelayShortLoop%

    ; Click Generate Modification
    Send {%KeySelect%} 
    Sleep %DelayShortLoop%

    ; Click Generate for first application
    Send {%KeySelect%}
    Sleep %DelayLoop%

    ; Second application
    Send {%KeySelect%}
    Sleep %DelayLoop%

    ; Third application
    Send {%KeySelect%}
    Sleep %DelayLoop%

    ; Fourth application
    Send {%KeySelect%}
    Sleep %DelayLoop%

    ; Fifth application
    Send {%KeySelect%}
    Sleep %DelayShortLoop%

    Return


SelectNextEngineeringLevel:
    Send {%KeyLeft%}
    Sleep %DelayShortLoop%
    Send {%KeyDown%}
    Sleep %DelayShortLoop%
    Return

; Beep logic
Beep(Action) {
	global EnableBeeps
	
	if(EnableBeeps) {
		global LowBeep
		global MidBeep
		global HighBeep
		global BeepLength
		
		switch Action {
			case "EngineerOne":
				SoundBeep, %LowBeep%, %BeepLength%
				SoundBeep, %MidBeep%, %BeepLength%
			case "EngineerMulitple":
				SoundBeep, %LowBeep%, %BeepLength%
				SoundBeep, %MidBeep%, %BeepLength%
				SoundBeep, %MidBeep%, %BeepLength%
			case "Complete":
				SoundBeep, %HighBeep%, %BeepLength%
			case "Reload":
				SoundBeep, %LowBeep%, %BeepLength%
				SoundBeep, %MidBeep%, %BeepLength%
				SoundBeep, %LowBeep%, %BeepLength%
			case "Kill":
				SoundBeep, %LowBeep%, %BeepLength%
				SoundBeep, %LowBeep%, %BeepLength%
				SoundBeep, %LowBeep%, %BeepLength%
			Default:
				MsgBox Invalid Action sent to Beep function - %Action%!
				ExitApp
		}
	}
}

; --------------------------------------

; Quick exit option in case something goes horribly wrong
JumpReload:
	Beep("Reload")

	; Make sure all virtually-pressed keys are released
	GoSub Release
	
	; Reload the script instead, so we don't have to manually relaunch it
	; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=97746&p=434107#p434107
	Reload
	
	; To prevent anything below this from running before the script is finished being killed and reloaded
	Return

; --------------------------------------

; Quick exit option in case something goes horribly wrong
JumpKill:
	Beep("Kill")

	; Make sure all virtually-pressed keys are released
	GoSub Release
	
	; Exit the script
	ExitApp

    ; Release any keys that might be virtually depressed, in preparation for reloading or killing
Release:
    Send {%KeyUp% up}
    Send {%KeyDown% up}
    Send {%KeyLeft% up}
    Send {%KeyRight% up}
    Send {%KeySelect% up}
    Return
; ===========================================================
; EOF
; ===========================================================