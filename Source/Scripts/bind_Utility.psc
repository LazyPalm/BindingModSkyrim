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
        debug.Notification("<font color='#0000FF'>" + msg + "</font>")
    elseif color == "violet"
        debug.Notification("<font color='#8000ff'>" + msg + "</font>")
    elseif color == "green"
        debug.Notification("<font color='#228B22'>" + msg + "</font>")
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

int function GetCurrentHour() global

    float currentGameDays = Utility.GetCurrentGameTime()
    float totalHours = currentGameDays * 24.0
    ;float currentHourFloat = totalHours % 24.0
    int currentHour = (totalHours as int) % 24; currentHourFloat as int
    return currentHour

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

string function TextColorGreen() global
    return "green"
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

bool function UiIsOpen() global
    If (!Utility.IsInMenuMode()) \
	&& (!UI.IsMenuOpen("Dialogue Menu")) \
	&& (!UI.IsMenuOpen("Console")) \
	&& (!UI.IsMenuOpen("Crafting Menu")) \
	&& (!UI.IsMenuOpen("MessageBoxMenu")) \
	&& (!UI.IsMenuOpen("ContainerMenu")) \
	&& (!UI.IsTextInputEnabled())
        return false
	Else
		return true
	EndIf
endfunction

bool function IsReady(Actor akSub, Actor akDom) global

    bool result = true

	If (!Utility.IsInMenuMode()) \
	&& (!UI.IsMenuOpen("Dialogue Menu")) \
	&& (!UI.IsMenuOpen("Console")) \
	&& (!UI.IsMenuOpen("Crafting Menu")) \
	&& (!UI.IsMenuOpen("MessageBoxMenu")) \
	&& (!UI.IsMenuOpen("ContainerMenu")) \
	&& (!UI.IsTextInputEnabled())
		;IsInMenuMode to block when game is paused with menus open
		;Dialogue Menu check to block when dialog is open
		;Console check to block when console is open - console does not trigger IsInMenuMode and thus needs its own check
		;Crafting Menu check to block when crafting menus are open - game is not paused so IsInMenuMode does not work
		;MessageBoxMenu check to block when message boxes are open - while they pause the game, they do not trigger IsInMenuMode
		;ContainerMenu check to block when containers are accessed - while they pause the game, they do not trigger IsInMenuMode
		;IsTextInputEnabled check to block when editable text fields are open
	Else
		result = False
	EndIf

    ;in combat check - dragons might be attaching city or towns
    if akSub.IsInCombat() || akDom.IsInCombat() || akSub.IsWeaponDrawn()
        result = false
    endif

    ;zap whipping plays in a scene - so do a scene check
    ;this is probably helpful for any mod that is running scenes outside of dhlp protected events including the base game
    if akSub.GetCurrentScene() || akDom.GetCurrentScene()
        result = false
    endif

    return result

endfunction

bool function ConfirmBox(string msg, string yesText = "", string noText = "") global

    bind_Utility.WriteToConsole("displaying confirmbox: " + msg)

    if yesText == ""
        yesText = "Yes"
    else 
        yesText = "Yes - " + yesText
    endif
    if noText == ""
        noText = "No"
    else 
        noText = "No - " + noText
    endif

    int listReturn = 0

    while listReturn < 1

        UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
        listMenu.AddEntryItem(msg)
        listMenu.AddEntryItem(yesText)
        listMenu.AddEntryItem(noText)
        listMenu.OpenMenu()
        listReturn = listMenu.GetResultInt()

    endwhile

    if listReturn == 1
        return true
    else
        return false
    endif

endfunction

function FadeOutInstant() global
    bind_Utility u = Quest.GetQuest("bind_MainQuest") as bind_Utility
    ;u.FadeToBlackImod.Apply()
    ;Utility.Wait(2.75)
    u.FadeToBlackHoldImod.Apply()
    bind_Utility.DisablePlayer()
endfunction

function FadeOutApply(string msg = "") global
    if msg != ""
        bind_Utility.WriteInternalMonologue(msg)
    endif
    bind_Utility u = Quest.GetQuest("bind_MainQuest") as bind_Utility
    ;u.FadeToBlackImod.Apply()
    ;Utility.Wait(2.75)
    u.FadeToBlackHoldImod.ApplyCrossFade(1.5)
    Utility.Wait(1.5)
    bind_Utility.DisablePlayer()
endfunction

function FadeOutRemove(string msg = "") global
    if msg != ""
        bind_Utility.WriteInternalMonologue(msg)
    endif
    bind_Utility u = Quest.GetQuest("bind_MainQuest") as bind_Utility
    u.FadeToBlackHoldImod.Remove()
    bind_Utility.EnablePlayer()
endfunction

function FadeOutApplyNoDisable(string msg = "") global
    if msg != ""
        bind_Utility.WriteInternalMonologue(msg)
    endif
    bind_Utility u = Quest.GetQuest("bind_MainQuest") as bind_Utility
    ;u.FadeToBlackImod.Apply()
    ;Utility.Wait(2.75)
    u.FadeToBlackHoldImod.ApplyCrossFade(1.5)
    Utility.Wait(1.5)
endfunction

function FadeOutRemoveNoDisable(string msg = "") global
    if msg != ""
        bind_Utility.WriteInternalMonologue(msg)
    endif
    bind_Utility u = Quest.GetQuest("bind_MainQuest") as bind_Utility
    u.FadeToBlackHoldImod.Remove()
endfunction

;***************************************************************
;start private api
;***************************************************************

function PriApiSetDom(Actor akActor) global
    bind_Functions fs = Quest.GetQuest("bind_MainQuest") as bind_Functions
    fs.SetDom(akActor)
endfunction

int function PriApiVariable(string varName) global
    bind_MainQuestScript main = Quest.GetQuest("bind_MainQuest") as bind_MainQuestScript
    if varName == "SexDomWantsPrivacy"
        return main.SexDomWantsPrivacy
    elseif varName == "NeedsBondageSetChange"
        return main.NeedsBondageSetChange
    elseif varName == "ActionKeyModifier"
        return main.ActionKeyModifier
    elseif varName == "SimpleSlaveryFemaleFallback"
        return main.SimpleSlaveryFemaleFallback
    elseif varName == "SimpleSlaveryMaleFallback"
        return main.SimpleSlaveryMaleFallback
    else
        return -1
    endif

endfunction

; string function PriApiVariableStr(string varName) global
;     bind_MainQuestScript main = Quest.GetQuest("bind_MainQuest") as bind_MainQuestScript
;     if varName == ""

;     else
;         return ""
;     endif
; endfunction

; function PriApiSetVariableStr(string varName, string value) global
;     bind_MainQuestScript main = Quest.GetQuest("bind_MainQuest") as bind_MainQuestScript
;     if varName == "ActiveQuestName"
;         main.ActiveQuestName = value
;     endif
; endfunction

Faction function PriApiSubFaction() global
    bind_Functions fs = Quest.GetQuest("bind_MainQuest") as bind_Functions
    return fs.bind_SubmissiveFaction
endfunction

bool function PriApiRunningState() global
    bind_Functions fs = Quest.GetQuest("bind_MainQuest") as bind_Functions
    return fs.ModInRunningState()
endfunction

Actor function PriApiGetDom() global
    bind_Functions fs = Quest.GetQuest("bind_MainQuest") as bind_Functions
    return fs.GetDomRef()
endfunction

string function PriApiGetDomTitle() global
    bind_Functions fs = Quest.GetQuest("bind_MainQuest") as bind_Functions
    return fs.GetDomTitle()
endfunction

bool function PriApiPlayerIsSub() global
    bind_MainQuestScript main = Quest.GetQuest("bind_MainQuest") as bind_MainQuestScript
    if main.IsSub == 1
        return true
    else 
        return false
    endif
endfunction

Location Function PriApiGetCurrentLocation() global
    bind_Functions fs = Quest.GetQuest("bind_MainQuest") as bind_Functions
    return fs.GetCurrentLocation()
EndFunction

bool function PriApiEventStart(string eventName, bool sendDhlp = true) global
    Quest q = Quest.GetQuest("bind_MainQuest")
    bind_Controller bc = q as bind_Controller
    bind_Functions fs = q as bind_Functions
    if !fs.ModInRunningState()
        return false
    else
        bc.DoStartEvent(sendDhlp)
        bc.SetEventName(eventName)
        return true
    endif
endfunction

bool function PriApiEventEnd(bool sendDhlp = true) global
    Quest q = Quest.GetQuest("bind_MainQuest")
    bind_Controller bc = q as bind_Controller
    bind_Functions fs = q as bind_Functions
    if fs.ModInRunningState()
        ;no quest is running
        return false
    else
        bc.DoEndEvent(sendDhlp)
        return true
    endif
endfunction

int function PriApiGetBondageOutfitId(string eventName) global
    
    Quest q = Quest.GetQuest("bind_MainQuest")
    bind_MainQuestScript main = q as bind_MainQuestScript
    bind_BondageManager bms = q as bind_BondageManager

	int eventOutfitId = 0

	string[] fList = MiscUtil.FilesInFolder(main.GameSaveFolder)

	if eventName != ""
		eventOutfitId = bms.GetBondageOutfitForEvent(eventName)
		bind_Utility.WriteToConsole("PriApiGetBondageOutfitId - eventName: " + eventName + " - outfit: " + eventOutfitId)
	endif

	if eventOutfitId == 0
		eventOutfitId = bms.GetBondageOutfitForEvent("event_any_event")
		bind_Utility.WriteToConsole("PriApiGetBondageOutfitId - eventName: any event - outfit: " + eventOutfitId)
	endif

	return eventOutfitId

endfunction

function PriApiEquipBondageOutfit(Actor akActor, int outfitId) global

    Quest q = Quest.GetQuest("bind_MainQuest")
    bind_BondageManager bms = q as bind_BondageManager
    bms.EquipBondageOutfit(akActor, outfitId)

endfunction

;***************************************************************
;end private api
;***************************************************************

function ManageSelectedFollowersList(string storageKey, Faction addToFaction = none) global

    Form[] inList
    Actor act = Game.GetPlayer()

    bind_Utility u = Quest.GetQuest("bind_MainQuest") as bind_Utility

    Form selectedActor
    Form[] theActors = storageutil.FormListToArray(act, storageKey)

    if theActors.Length == 0
        debug.MessageBox("No future doms found")
        return
    endif

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    int i = 0
    while i < theActors.Length
        Actor a = theActors[i] as Actor
        listMenu.AddEntryItem(a.GetDisplayName())
        i += 1
    endwhile

    listMenu.OpenMenu()
    int r = listMenu.GetResultInt()
    if r >= 0
        selectedActor = theActors[r]
    endif

    if selectedActor != none

        listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
        listMenu.AddEntryItem("Remove " + (selectedActor as Actor).GetDisplayName())
        listMenu.AddEntryItem("Yes")
        listMenu.AddEntryItem("No") 
        listMenu.OpenMenu()
        r = listMenu.GetResultInt()
        if r == 1
            if storageKey != ""
                if StorageUtil.FormListHas(act, storageKey, selectedActor)
                    StorageUtil.FormListRemove(act, storageKey, selectedActor)
                    if addToFaction != none
                        if act.IsInFaction(addToFaction)
                            act.RemoveFromFaction(addToFaction)
                        endif
                    endif
                endif
            endif
            bind_Utility.ManageSelectedFollowersList(storageKey, addToFaction)
        elseif r == 0 || r == 2
            bind_Utility.ManageSelectedFollowersList(storageKey, addToFaction)
        endif

    endif

endfunction

function SelectFollowersList(float scanDistance = 2000.0, string storageKey, Faction addToFaction = none) global

    Form[] inList
    Actor act = Game.GetPlayer()

    bind_Utility u = Quest.GetQuest("bind_MainQuest") as bind_Utility

    Actor selectedActor
    Actor[] theActors = MiscUtil.ScanCellNPCsByFaction(u.PotentialFollowerFaction, act, scanDistance)

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    int i = 0
    while i < theActors.Length
        string selected = "" 
        if storageKey != ""
            if StorageUtil.FormListHas(act, storageKey, theActors[i])
                selected = " - ACTIVE"
            endif
        endif
        listMenu.AddEntryItem(theActors[i].GetDisplayName() + selected)
        i += 1
    endwhile

    listMenu.OpenMenu()
    int r = listMenu.GetResultInt()
    if r >= 0
        selectedActor = theActors[r]
    endif

    if selectedActor != none
        if storageKey != ""
            if StorageUtil.FormListHas(act, storageKey, selectedActor)
                StorageUtil.FormListRemove(act, storageKey, selectedActor)
                if addToFaction != none
                    if act.IsInFaction(addToFaction)
                        act.RemoveFromFaction(addToFaction)
                    endif
                endif
            else
                StorageUtil.FormListAdd(act, storageKey, selectedActor, false)
                if addToFaction != none
                    if !act.IsInFaction(addToFaction)
                        act.addToFaction(addToFaction)
                    endif
                endif
            endif
        endif
        bind_Utility.SelectFollowersList(scanDistance, storageKey, addToFaction) ;re-display list
    endif

endfunction

ImageSpaceModifier property FadeToBlackImod auto
ImageSpaceModifier property FadeToBlackHoldImod auto

Faction property PotentialFollowerFaction auto