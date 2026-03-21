Scriptname bindc_Util extends Quest  

function SendSimpleModEvent(string eventName) global

    int handle = ModEvent.Create(eventName)
    if handle
        ModEvent.Send(handle)
    endif

endfunction

function WriteInternalMonologue(string msg) global
    debug.Notification("<font color='" + StorageUtil.GetStringValue(none, "bind_color_inner_text", "#8C6CD0") + "'>" + msg + "</font>")
endfunction

function WriteDomCommand(string msg) global
    ;#CC0033
    debug.Notification("<font color='" + StorageUtil.GetStringValue(none, "bind_color_dom_text", "#CC0033") + "'>" + msg + "</font>")
endfunction

function WriteModNotification(string msg) global
    ;#4060AF
    ;#99FFFF - cyan if this is blue is too dark
    debug.Notification("<font color='" + StorageUtil.GetStringValue(none, "bind_color_mod_text", "#4060AF") + "'>" + msg + "</font>")
endfunction

function WriteInformation(string msg) global
    ;get global to see if this is enabled
    if StorageUtil.GetIntValue(none, "bindc_write_to_console", 1) == 1
        MiscUtil.PrintConsole("[bindc]: " + msg)
    endif
    Debug.Trace("[bindc]: " + msg)
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

float function GetTime() global
    return Utility.GetCurrentGameTime()
endfunction

float function GetHoursAsFloat(int hours) global
    return (1.0 / 24.0) * (hours as float)
endfunction

function DoSleep(float f = 0.5) global
    Utility.Wait(f)
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

string Function SanitizeAZ09Space(String str) global
    if str == ""
        return ""
    endif

    String allowed = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 "
    String out = ""

    int i = 0
    int n = StringUtil.GetLength(str) 
    while i < n
        String ch = StringUtil.Substring(str, i, 1)
        if StringUtil.Find(allowed, ch) != -1
            out = out + ch
        endif
        i += 1
    endwhile

    return out
EndFunction

Function AnimateChangeClothing(Actor akActor) global

    int Gender = akActor.GetLeveledActorBase().GetSex()
    Debug.SendAnimationEvent(akActor, "Arrok_Undress_G" + Gender)

EndFunction