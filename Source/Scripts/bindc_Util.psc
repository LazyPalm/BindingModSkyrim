Scriptname bindc_Util extends Quest  

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

function WriteInformation(string msg) global
    ;get global to see if this is enabled
    if StorageUtil.GetIntValue(none, "bindc_write_to_console", 0) == 1
        MiscUtil.PrintConsole("[BINDC]: " + msg)
    endif
    Debug.Trace("[BINDC]: " + msg)
endfunction

string function DisplayTimeElapsed(float dt1, float dt2) global

    float diff = dt2 - dt1

    int totalMinutes = Math.Floor(diff * 1440)
    int hours = Math.Floor(totalMinutes / 60)
    int minutes = Math.Floor(totalMinutes % 60)

    return diff + " - " + hours + "h " + minutes + "m"

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

function DisablePlayer(bool disableControls = false) global
    if disableControls
        Game.DisablePlayerControls(abMovement = true, abFighting = true, abCamSwitch = false, abLooking = false, abSneaking = true, abMenu = false, abActivate = false, abJournalTabs = false, aiDisablePOVType = 0)
    else
    
    endif
    Game.SetPlayerAIDriven(true)
endfunction

function EnablePlayer(bool enableControls = true) global    
    Game.SetPlayerAIDriven(false)
    if enableControls
        Game.EnablePlayerControls()
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

    bindc_Util.WriteInformation("displaying confirmbox: " + msg)

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
    bindc_Util u = Quest.GetQuest("bindc_MainQuest") as bindc_Util
    ;u.FadeToBlackImod.Apply()
    ;Utility.Wait(2.75)
    u.FadeToBlackHoldImod.Apply()
    bindc_Util.DisablePlayer()
endfunction

function FadeOutApply(string msg = "") global
    if msg != ""
        bindc_Util.WriteInternalMonologue(msg)
    endif
    bindc_Util u = Quest.GetQuest("bindc_MainQuest") as bindc_Util
    ;u.FadeToBlackImod.Apply()
    ;Utility.Wait(2.75)
    u.FadeToBlackHoldImod.ApplyCrossFade(1.5)
    Utility.Wait(1.5)
    bindc_Util.DisablePlayer()
endfunction

function FadeOutRemove(string msg = "") global
    if msg != ""
        bindc_Util.WriteInternalMonologue(msg)
    endif
    bindc_Util u = Quest.GetQuest("bindc_MainQuest") as bindc_Util
    u.FadeToBlackHoldImod.Remove()
    bindc_Util.EnablePlayer()
endfunction

function FadeOutApplyNoDisable(string msg = "") global
    if msg != ""
        bindc_Util.WriteInternalMonologue(msg)
    endif
    bindc_Util u = Quest.GetQuest("bindc_MainQuest") as bindc_Util
    ;u.FadeToBlackImod.Apply()
    ;Utility.Wait(2.75)
    u.FadeToBlackHoldImod.ApplyCrossFade(1.5)
    Utility.Wait(1.5)
endfunction

function FadeOutRemoveNoDisable(string msg = "") global
    if msg != ""
        bindc_Util.WriteInternalMonologue(msg)
    endif
    bindc_Util u = Quest.GetQuest("bindc_MainQuest") as bindc_Util
    u.FadeToBlackHoldImod.Remove()
endfunction

bool function StartDhlp() global
    bindc_Main m = Quest.GetQuest("bindc_MainQuest") as bindc_Main
    bool result = false
    if m.DhlpSuspend == m.DHLP_STATE_OFF
        m.DhlpSuspend = m.DHLP_STATE_SUSPENDING
        m.SendModEvent("dhlp-Suspend")
        result = true
    endif
    return result
endfunction

function EndDhlp() global
    bindc_Main m = Quest.GetQuest("bindc_MainQuest") as bindc_Main
    if m.DhlpSuspend == m.DHLP_STATE_SUSPENDED
        m.DhlpSuspend = m.DHLP_STATE_RESUMING
        m.SendModEvent("dhlp-Resume")
    endif
endfunction

Actor function GetDom() global
    return StorageUtil.GetFormValue(none, "bindc_dom") as Actor
endfunction

string function GetDomTitle() global
    return StorageUtil.GetStringValue(none, "bindc_dom_title")
endfunction

int function GetDomSex() global
    return StorageUtil.GetIntValue(none, "bindc_dom_sex")
endfunction

float function MaxCheckRange() global
    return 2000.0
endfunction

function MarkInfraction(string msg, bool distanceCheck = true) global
    float maxDistance = 2000.0
    Actor dom = StorageUtil.GetFormValue(none, "bindc_dom") as Actor
	string domTitle = StorageUtil.GetStringValue(none, "bindc_dom_title", "")
    bool outOfRange = (Game.GetPlayer().GetDistance(dom) > maxDistance) && distanceCheck
    bool mark = false
    if StorageUtil.GetIntValue(none, "bindc_infractions_msgbox", 0) == 1
        if outOfRange
            debug.MessageBox(msg + ". " + domTitle + " is not here to notice...")
        else
            debug.MessageBox(msg + " +1 infraction")
            mark = true
        endif
    else
        bindc_Util.WriteNotification(msg + "...", bindc_Util.TextColorRed())
        if outOfRange
            bindc_Util.WriteNotification(domTitle + " is not here to notice...", bindc_Util.TextColorRed())
        else
            bindc_Util.WriteNotification("+1 infraction", bindc_Util.TextColorRed())
            mark = true
        endif
    endif
    if mark
        StorageUtil.SetIntValue(none, "bindc_infractions", StorageUtil.GetIntValue(none, "bindc_infractions", 0) + 1)
    endif
endfunction

int function GetInfractions() global
    return StorageUtil.GetIntValue(none, "bindc_infractions", 0)
endfunction

function ModifyInfractions(int infractions) global
    int i = StorageUtil.GetIntValue(none, "bindc_infractions", 0)
    i += infractions
    if i > 128
        i = 128
    endif
    if i < 0
        i = 0
    endif
    StorageUtil.SetIntValue(none, "bindc_infractions", i)
    bindc_Util u = Quest.GetQuest("bindc_MainQuest") as bindc_Util    
    Game.GetPlayer().SetFactionRank(u.bindc_InfractionsFaction, i)
endfunction

int function GetPoints() global
    return StorageUtil.GetIntValue(none, "bindc_points", 0)
endfunction

function ModifyPoints(int points) global
    int p = StorageUtil.GetIntValue(none, "bindc_points", 0)
    p += points
    if p > 128
        p = 128
    endif
    if p < 0
        p = 0
    endif
    StorageUtil.SetIntValue(none, "bindc_points", p)
    bindc_Util u = Quest.GetQuest("bindc_MainQuest") as bindc_Util    
    Game.GetPlayer().SetFactionRank(u.bindc_PointsFaction, p)
endfunction

function PlayTyingAnimation(Actor akActor, Actor akActorTarget) global
    float zOffset = akActor.GetHeadingAngle(akActorTarget)
    akActor.SetAngle(akActor.GetAngleX(), akActor.GetAngleY(), akActor.GetAngleZ() + zOffset)
    Debug.SendAnimationEvent(akActor, "IdleLockPick")
endfunction

function StopAnimations(Actor akActor) global
    Debug.SendAnimationEvent(akActor, "IdleForceDefaultState")
    akActor.EvaluatePackage()
endfunction

ImageSpaceModifier property FadeToBlackImod auto
ImageSpaceModifier property FadeToBlackHoldImod auto

Faction property PotentialFollowerFaction auto
Faction property bindc_InfractionsFaction auto
Faction property bindc_PointsFaction auto
