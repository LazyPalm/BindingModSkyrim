Scriptname bind_Utility extends Quest  

Function WindowOutput(string msg) global
	Debug.Notification(msg)
EndFunction

Function LogOutput(string msg, bool critical = false) global
    bind_MainQuestScript main = Quest.GetQuest("bind_MainQuest") as bind_MainQuestScript
    If main.WriteLogs == 1
        Debug.Trace("[binding]: " + msg)
    EndIf
EndFunction

float function CalculateDistanceBetweenTwoPoints(float x1, float y1, float x2, float y2) global
	return ((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
endfunction


;************************************
;2025 functions here
;************************************

function AdvanceGameTime(float hours) global

    ;NOTE - this an example provided by tasairis on reddit

    GlobalVariable GameHour 
    GlobalVariable GameDay 
    GlobalVariable GameDaysPassed 
    GlobalVariable GameMonth 
    GlobalVariable GameYear 

    float hour
    int day
    int month

    ;allow times more than a day, since the code below won't handle it well
    while hours > 24.0
        AdvanceGameTime(24.0)
        hours -= 24.0
    endwhile

    ;but don't subtract time
    if hours <= 0.0
        return
    endif

    GameHour = Game.GetForm(0x00000038) as GlobalVariable
    GameDaysPassed = Game.GetForm(0x00000039) as GlobalVariable
    GameDay = Game.GetForm(0x00000037) as GlobalVariable
    GameMonth = Game.GetForm(0x00000036) as GlobalVariable        
    GameYear = Game.GetForm(0x00000035) as GlobalVariable

    bind_Utility.WriteToConsole("skip time current: " + hours + "skip " + GameHour.GetValue() + "h " + GameDaysPassed.GetValue() + "gdp " + GameDay.GetValue() + "gd " + GameMonth.GetValue() + "gm " + GameYear.GetValue() + "gy")

    hour = GameHour.GetValue() + hours

    if hour >= 24.0

        ;advance the day
        hour -= 24.0
        day = GameDay.GetValue() as int + 1
        GameDaysPassed.mod(1.0)

        month = GameMonth.GetValue() as int

        if ( \
            day == 29 && month == 2 || \
            day == 31 && (month == 4 || month == 6 || month == 9 || month == 11) || \
            day == 32 && (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) \
        )
            ;advance the month
            day = 1
            month += 1

            if month > 12
                ;advance the year
                month = 1
                GameYear.mod(1.0)
            endif

            GameMonth.SetValue(month as float)

        endif

        GameDay.SetValue(day as float)

    endif

    GameHour.SetValue(hour)

   bind_Utility.WriteToConsole("skip time adjusted: " + hours + "skip " + GameHour.GetValue() + "h " + GameDaysPassed.GetValue() + "gdp " + GameDay.GetValue() + "gd " + GameMonth.GetValue() + "gm " + GameYear.GetValue() + "gy")

endfunction




bool Function FakeSleep(int hours) global

    bool addRested = false

    int rnd = Utility.RandomInt(1, 100)

    string tyepOfRest = "a fitful"

    if hours == 6
        addRested = (rnd <= 25)
    elseif hours == 7
        addRested = (rnd <= 50)
    elseif hours == 8
        addRested = (rnd <= 75)
    elseif hours > 8
        addRested = true
    endif
    
    if addRested
        tyepOfRest = "an OK"
    endif

    bind_Utility.AdvanceGameTime(hours)
    
    Game.FadeOutGame(false, true, (hours as float), 1.0)
    
    bind_Utility.DoSleep((hours as float) * 1.5)

    If hours == 1
        bind_Utility.WriteNotification("You manage a fitful 1 hour of rest in your position...", bind_Utility.TextColorBlue())
    Else
        bind_Utility.WriteNotification("You manage " + tyepOfRest + " " + hours + " hours of rest in your position...", bind_Utility.TextColorBlue())
    EndIf

    return addRested

EndFunction

;colors - red, blue, violet, white
function WriteNotification(string msg, string color = "white") global
    if color == "red"
        debug.Notification("<font color='#ff0000'>" + msg + "</font>")
    elseif color == "blue"
        debug.Notification("<font color='#0000ff'>" + msg + "</font>")
    elseif color == "violet"
        debug.Notification("<font color='#8000ff'>" + msg + "</font>")
    else
        debug.Notification(msg)   
    endif
        
endfunction

function WriteInternalMonologue(string msg) global
    debug.Notification("<font color='#8000ff'>" + msg + "</font>")
endfunction

float function AddTimeToCurrentTime(int hours, int minutes = 0) global
	float time = 0.0
    if hours > 0
		time += ((hours as float) / 24.0)
	endif
    if minutes > 0
		time += ((minutes as float) / 1440.0)
	endif
    ;debug.MessageBox(time)
	float currentTime = Utility.GetCurrentGameTime()
	float newTimer = currentTime + time
    return newTimer
endfunction

float function AddTimeToTime(float t, int hours, int minutes = 0) global
	float time = 0.0
    if hours > 0
		time += ((hours as float) / 24.0)
	endif
    if minutes > 0
		time += ((minutes as float) / 1440.0)
	endif
	float newTimer = t + time
    return newTimer
endfunction

string function TextColorRed() global
    return "red"
endfunction

string function TextColorBlue() global
    return "blue"
endfunction

string function TextColorPurple() global
    return "violet"
endfunction

function DoSleep(float f = 0.5) global
    Utility.Wait(f)
endfunction

float function GetTime() global
    return Utility.GetCurrentGameTime()
endfunction

function WriteToConsole(string msg) global
    ;get global to see if this is enabled
    MiscUtil.PrintConsole("[BIND]: " + msg)
    Debug.Trace("[BINDING]: " + msg)
endfunction

function DisablePlayer(bool disableControls = false) global
    if disableControls
    
    else
    
    endif
    Game.SetPlayerAIDriven(true)
endfunction

function EnablePlayer(bool enableControls = true) global    
    Game.SetPlayerAIDriven(false)
    if enableControls

    else

    endif
endfunction

function SendSimpleModEvent(string eventName) global

    int handle = ModEvent.Create(eventName)
    if handle
        ModEvent.Send(handle)
    endif

endfunction

string[] function GetLetters() global

    string[] letters = new string[26]
    
    letters[0] = "a"
    letters[1] = "b"
    letters[2] = "c"
    letters[3] = "d"
    letters[4] = "e"
    letters[5] = "f"
    letters[6] = "g"
    letters[7] = "h"
    letters[8] = "i"
    letters[9] = "j"
    letters[10] = "k"
    letters[11] = "l"
    letters[12] = "m"
    letters[13] = "n"
    letters[14] = "o"
    letters[15] = "p"
    letters[16] = "q"
    letters[17] = "r"
    letters[18] = "s"
    letters[19] = "t"
    letters[20] = "u"
    letters[21] = "v"
    letters[22] = "w"
    letters[23] = "x"
    letters[24] = "y"
    letters[25] = "z"

    return letters

endfunction

string function JsonIntValueReturn(string name, int value) global
    return "{\"" + name + "\":\"" + value + "\"}"    
endfunction