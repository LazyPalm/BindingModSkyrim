Scriptname bind_SkseBridge hidden

int function SetToken(Actor act, Armor arm) global
    bind_Utility.WriteToConsole("bind_SkseBridge - SetToken - " + arm)
    StorageUtil.SetIntValue(act, "zad_RemovalToken" + arm, 1)	
    return 0
endfunction

int function SetDeviousRemovalTokens(Actor act, Form[] items) global
    ;debug.MessageBox(items)
    if items.Length > 0
        int i = 0
        while i < items.Length
            bind_Utility.WriteToConsole("bind_SkseBridge - SetToken - " + items[i])
            StorageUtil.SetIntValue(act, "zad_RemovalToken" + items[i], 1)	            
            i += 1
        endwhile
    endif
endfunction

int function LockDevice(Actor act, Armor arm) global
    zadLibs zlib = Quest.GetQuest("zadQuest") as zadLibs
    zlib.LockDevice(act, arm, false)
    Utility.Wait(1.0)
    return 0
endfunction

int function UnlockDevice(Actor act, Armor arm) global
    zadLibs zlib = Quest.GetQuest("zadQuest") as zadLibs
    zlib.UnlockDevice(act, arm, none, none, true, true)
    Utility.Wait(1.0)
    return 0
endfunction

int function DisplayCaption(Actor act, string text) global
    ;debug.MessageBox(text)
    ;bind_SkseFunctions.PlayerChatOutput(act, text)
    return 0
endfunction

int function CrosshairNpc(Actor act) global
    ;debug.Notification("crosshair over: " + act.GetDisplayName())

    ;set conversation target
    bind_Functions fs = Quest.GetQuest("bind_MainQuest") as bind_Functions
    fs.ConversationTargetNpc.ForceRefTo(act)

    ;NOTE - when using conversation target (posing) check distance and clear if player has moved away too far
    return 0
endfunction

int function CrosshairDoor(Form d, ObjectReference o) global

    ; debug.MessageBox(o)
    ; debug.MessageBox(d.GetName())

    Quest q = Quest.GetQuest("bind_MainQuest")
    bind_Functions fs = q as bind_Functions
    fs.SubLookedAtDoor(o)

    ; ObjectReference destination = PO3_SKSEFunctions.GetDoorDestination(o)
    ; if destination.GetBaseObject() as Door
    ;     Location doorLoc = destination.GetCurrentLocation()
    ;     Quest q = Quest.GetQuest("bind_MainQuest")
    ;     bind_Functions fs = q as bind_Functions
    ;     bind_RulesManager rm = q as bind_RulesManager
    ;     rm.BehaviorEnterExitRuleCurrentDoorType = 0
    ;     fs.BuildingDoor.ForceRefTo(o)
    ;     if doorLoc != none
    ;         fs.BuildingDoorDestination.ForceLocationTo(doorLoc)
    ;         if (doorLoc.HasKeywordString("LocTypeInn") && rm.BehaviorEnterExitRuleInn == 1) 
    ;             rm.BehaviorEnterExitRuleCurrentDoorType = rm.DESTINATION_TYPE_INN
    ;             if rm.BehaviorEnterExitRuleInnPermission == 0
    ;                 bind_Utility.WriteInternalMonologue("I need permission to enter " + doorLoc.GetName() + "...")
    ;             endif
    ;         elseif (doorLoc.HasKeywordString("LocTypeCastle") && rm.BehaviorEnterExitRuleCastle == 1) 
    ;             rm.BehaviorEnterExitRuleCurrentDoorType = rm.DESTINATION_TYPE_CASTLE
    ;             if rm.BehaviorEnterExitRuleCastlePermission == 0
    ;                 bind_Utility.WriteInternalMonologue("I need permission to enter " + doorLoc.GetName() + "...")
    ;             endif
    ;         elseif (doorLoc.HasKeywordString("LocTypePlayerHouse") && rm.BehaviorEnterExitRulePlayerHome == 1) 
    ;             rm.BehaviorEnterExitRuleCurrentDoorType = rm.DESTINATION_TYPE_PLAYERHOME
    ;             if rm.BehaviorEnterExitRulePlayerHomePermission == 0
    ;                 bind_Utility.WriteInternalMonologue("I need permission to enter " + doorLoc.GetName() + "...")
    ;             endif
    ;         endif
    ;     else
    ;         fs.BuildingDoorDestination.Clear()
    ;     endif
    ; endif

    return 0

endfunction

int function CrosshairBed(ObjectReference o) global
    bind_Functions fs = Quest.GetQuest("bind_MainQuest") as bind_Functions
    fs.NearbyBed.ForceRefTo(o) 
    return 0
endfunction

int function ActivatedShrine(string shrineName, string shrineGod) global
    bind_Functions fs = Quest.GetQuest("bind_MainQuest") as bind_Functions
    fs.SubPrayedAtShrine(shrineGod)
    return 0
endfunction

int function ActivatedDragon(ObjectReference o) global

    Quest q = Quest.GetQuest("bind_MainQuest")
    bind_Functions fs = q as bind_Functions
    bind_MainQuestScript main = q as bind_MainQuestScript

    if !StorageUtil.FormListHas(fs.GetSubRef(), "binding_dragons_list", o)
        ;debug.MessageBox("activated dragon: " + o)
        StorageUtil.FormListAdd(fs.GetSubRef(), "binding_dragons_list", o)
        ;Debug.MessageBox("start: " + main.DomStartupQuestsEnabled)
        if fs.ModInRunningState() && main.DomStartupQuestsEnabled == 1
            Quest souls = Quest.GetQuest("bind_SoulsFromBonesQuest")
            souls.Start()
        endif
    else
        ;debug.MessageBox("re-activated dragon: " + o)
    endif

    return 0

endfunction