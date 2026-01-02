Scriptname bindc_Slavery extends Quest  

Actor dom
Actor sub1
Actor sub2
Actor sub3

bindc_Poser p
bindc_Rules r
bindc_Bondage b
bindc_Main m
bindc_Gear g

Location oldLocation
Location newLocation

bool kneelingFlag = false
bool posingFlag = false
bool gagPulledOut = false
bool domOnTheMove = false
;int outfitTimerRunning = 0
bool isIndoors

int inConversation

int targetOutfitId = 0
int needOutfitChange = 0

event OnInit()

    if self.IsRunning()
        bindc_Util.WriteInformation("Starting Binding Slavery Quest")
        Startup()
    endif

endevent

function LoadGame()
    
    RegisterForControl("Activate")

endfunction

function Startup()

    RegisterForControl("Activate")

    p = data_script.PoserScript
    r = data_script.RulesScript    
    b = data_script.BondageScript
    m = data_script.MainScript
    g = data_script.GearScript

    DomRef.ForceRefTo(StorageUtil.GetFormValue(none, "bindc_dom") as Actor)
    ;TODO - ForceRefTo for sub2/sub3
    if DomRef.GetActorReference() != none
        dom = DomRef.GetActorReference()
    endif
    if Sub1Ref.GetActorReference() != none
        sub1 = Sub1Ref.GetActorReference()
    endif
    if Sub2Ref.GetActorReference() != none
        sub2 = Sub2Ref.GetActorReference()
    endif
    if Sub3Ref.GetActorReference() != none
        sub3 = Sub3Ref.GetActorReference()
    endif

    int currentOutfitId = StorageUtil.GetIntValue(sub1, "bindc_outfit_id", -1)

    if currentOutfitId == -2
        ;safeword forced refresh
        b.RemoveAllBondageItems(sub1, false)
        StorageUtil.SetIntValue(sub1, "bindc_outfit_id", -1)
    endif

    Location loc = sub1.GetCurrentLocation()
    int outfitId = b.GetBondageSetForLocation(sub1, loc, currentOutfitId)

    if data_script.SlaveryQuest_InGaggedPunishment == 1
        outfitId = b.GetBondageOutfitForEvent(sub1, "event_gagged_for_punishment")
    endif

    ;debug.MessageBox("loc: " + loc.GetName() + " outfit: " + outfitId)
    if outfitId > 0
        b.EquipBondageOutfit(sub1, outfitId)
        StorageUtil.SetIntValue(sub1, "bindc_outfit_id", outfitId)
    endif

endfunction

event OnControlUp(string control, float HoldTime)
	If control == "Activate"
        If inConversation == 0 || inConversation == 2
            If UI.IsMenuOpen("Dialogue Menu")
                inConversation = 1
                ;NOTE - force greets did not seem to trigger this, but had a report people were getting +infraction from forcegreet
                ProcessConversation()
            EndIf
        EndIf
	EndIf

endevent

event OnUpdate()

    if domOnTheMove
        ActorUtil.ClearPackageOverride(dom)
        domOnTheMove = false
    endif

endevent

function ProcessLoop()

    ; if domOnTheMove
    ;     float d = dom.GetDistance(sub1)
    ;     bindc_Util.WriteInformation("dom distance: " + d)
    ;     if d <= 256.0
    ;         debug.MessageBox("loop triggered dom arrived...")
    ;         DomArrived() ;do this because the travel package sometimes does not fire
    ;     endif
    ; endif

    float ct = bindc_Util.GetTime()

    r.UpdateTimePermissions()

    if StorageUtil.GetIntValue(sub1, "bindc_temp_gag_removal", 0) > 0
        int loopsLeft = StorageUtil.GetIntValue(sub1, "bindc_temp_gag_removal")
        loopsLeft -= 1
        StorageUtil.SetIntValue(sub1, "bindc_temp_gag_removal", loopsLeft)
        bindc_Util.WriteInformation("gag free: " + loopsLeft)
    endif

    if data_script.SlaveryQuest_GaggedPunishmentEndTime > 0.0
        if data_script.SlaveryQuest_GaggedPunishmentEndTime < ct
            data_script.SlaveryQuest_InGaggedPunishment = 2
            bindc_Util.WriteInternalMonologue(bindc_Util.GetDomTitle() + " signals it is time for the gag to be removed...")
        endif
    endif

    ; if needOutfitChange > 0
    ;     if (needOutfitChange == 1 && !outfitTimerRunning)
    ;         if dom.GetDistance(sub1) <= bindc_Util.MaxCheckRange()
    ;             bindc_Util.WriteInformation("activating outfit change 1 from the loop...")
    ;             MoveDomToSub()
    ;         endif
    ;     elseif (needOutfitChange == 2 && !outfitTimerRunning)
    ;         if dom.GetDistance(sub1) <= bindc_Util.MaxCheckRange()
    ;             bindc_Util.WriteInformation("activating outfit change 2 from the loop...")
    ;             if p.InPresentHandsPose(sub1)
    ;                 MoveDomToSub()
    ;             else
    ;                 StartOutfitTimer()
    ;             endif
    ;         endif
    ;     endif
    ; endif

endfunction

function AddWheelMenuOption(UIWheelMenu menu, int optionIndex, string optionName, bool enabled = true)
    menu.SetPropertyIndexString("optionText", optionIndex, optionName)
    menu.SetPropertyIndexString("optionLabelText", optionIndex, optionName)
    menu.SetPropertyIndexBool("optionEnabled", optionIndex, enabled)
endfunction

function ActionMenu()

    UIWheelMenu actionMenu = UIExtensions.GetMenu("UIWheelMenu") as UIWheelMenu
    
    AddWheelMenuOption(actionMenu, 0, "Close")

    if kneelingFlag || posingFlag
        AddWheelMenuOption(actionMenu, 1, "Resume Standing")
    else
        AddWheelMenuOption(actionMenu, 1, "Kneel")
        AddWheelMenuOption(actionMenu, 2, "Pose")
    endif

    AddWheelMenuOption(actionMenu, 7, "Pause")

    int actionResult = actionMenu.OpenMenu()

    if actionResult == 0
        ;close menu
    elseif actionResult == 1
        Kneel()
    elseif actionResult == 2
        PoseMenu()
    
    elseif actionResult == 7
        Pause()
    endif

endfunction

function PoseMenu()

    if sub1.IsOnMount()
        bindc_Util.WriteInternalMonologue("I need to get off this horse first...")
        return
    endif

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Menu")
    listMenu.AddEntryItem("Kneel - Not To Speak") ;1
    listMenu.AddEntryItem("Spread Kneel - For Sex") ;2
    listMenu.AddEntryItem("Attention") ;3
    listMenu.AddEntryItem("Present Hands - For Bondage") ;4
    listMenu.AddEntryItem("Whipped - For Punishment") ;5
    listMenu.AddEntryItem("Show Ass") ;6
    listMenu.AddEntryItem("Prayer") ;7
    listMenu.AddEntryItem("Sit On Ground") ;8
    listMenu.AddEntryItem("Conversation - For Dialogue") ;9
    listMenu.AddEntryItem("Deep Kneel - For Sleep") ;10
    listMenu.AddEntryItem("Doorstep Kneel - Entry/Exit") ;11

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn > 0
        posingFlag = true
        bindc_Util.DisablePlayer(false)
    endif

    if listReturn == 0
        ActionMenu()
    elseif listReturn == 1
        p.Kneel(sub1)
    elseif listReturn == 2
        p.SpreadKneelPose(sub1)
    elseif listReturn == 3
        p.AttentionPose(sub1)
    elseif listReturn == 4
        p.PresentHandsPose(sub1)
        SubPresentedHands()
    elseif listReturn == 5
        p.WhippingPose(sub1)
    elseif listReturn == 6
        p.AssOutPose(sub1)
    elseif listReturn == 7
        p.PrayerPose(sub1)
    elseif listReturn == 8
        p.SitOnGroundPose(sub1)
    elseif listReturn == 9
        p.ConversationPose(sub1)
        StartDomConversation()
    elseif listReturn == 10
        p.DeepKneelPose(sub1)
    elseif listReturn == 11
        p.DoorstepPose(sub1)
        MoveDomToSub()
    endif

endfunction

function Pause()
    if bindc_Util.ConfirmBox("Confirm pause Binding")
        b.RemoveAllBondageItems(sub1, false)
        m.StartPause()
    endif
endfunction

function Kneel(bool cancelKneel = false)

    if !kneelingFlag && !posingFlag && !cancelKneel
        kneelingFlag = true
        bindc_Util.DisablePlayer()
        p.Kneel(sub1)
        MoveDomToSub()
        ; arrived = false
        ; ActorUtil.AddPackageOverride(dom, bindc_PackageSlaveryMoveToPlayer, 80)
        ; dom.EvaluatePackage()
    elseif kneelingFlag || cancelKneel
        kneelingFlag = false
        posingFlag = false
        if domOnTheMove
            ActorUtil.ClearPackageOverride(dom)
            domOnTheMove = false
        endif
        ; domOnTheMove = false
        ; GoToState("")
        PushInGag()
        p.ClearPose(sub1)
        bindc_Util.EnablePlayer()
    elseif posingFlag
        posingFlag = false
        kneelingFlag = false
        if domOnTheMove
            ActorUtil.ClearPackageOverride(dom)
            domOnTheMove = false
        endif
        if bindc_Slavery_Scene_DomToNpc.IsPlaying()
            bindc_Slavery_Scene_DomToNpc.Stop()
        endif
        ; domOnTheMove = false
        ; GoToState("")
        p.ClearPose(sub1)
        bindc_Util.EnablePlayer()
    endif

endfunction

function Stand()

endfunction

function MoveDomToSub()
    float d = dom.GetDistance(sub1)
    bindc_Util.WriteInformation("MoveDomToSub distance: " + d)
    if d > bindc_Util.MaxCheckRange()
        bindc_Util.WriteInternalMonologue(bindc_Util.GetDomTitle() + " is too far away to notice me...")
    elseif d < 128.0
        ;arrived = false 
        ;debug.MessageBox("skipping travel...")
        DomArrived()
    else
        ;arrived = false
        ActorUtil.AddPackageOverride(dom, bindc_PackageSlaveryMoveToPlayer, 90)
        bindc_Util.DoSleep()
        dom.EvaluatePackage()
        domOnTheMove = true
        bindc_Util.WriteInformation("adding bindc_PackageSlaveryMoveToPlayer")
        ; GoToState("DomTravelingState")
        ; RegisterForSingleUpdate(1.0)
    endif
endfunction

function DomArrived()

    bindc_Util.WriteInformation("dom arrived...")

    ;GoToState("")
    if p.IsKneeling(sub1)
        ActorUtil.ClearPackageOverride(dom)
        ActorUtil.AddPackageOverride(dom, bindc_PackageSlaveryHoldPosition, 90)
        dom.EvaluatePackage()
        if data_script.SlaveryQuest_InGaggedPunishment == 2
            EndGaggedPunishment()
        else 
            PullOutGag()
        endif
        
    elseif p.InConversationPose(sub1)
        PullOutGag()
        StorageUtil.SetFloatValue(sub1, "bindc_temp_speaking_permission", bindc_Util.AddTimeToCurrentTime(1, 0))
        bindc_Slavery_Scene_DomToNpc.Start()

    elseif p.InDoorstepPose(sub1)
        if isIndoors
            if r.BehaviorEnterExitRuleCurrentLocationType > 0
                bindc_Slavery_Scene_ExitPermission.Start()
                GrantExitPermission()
            endif
        else
            if r.BehaviorEnterExitRuleCurrentDoorType > 0
                bindc_Slavery_Scene_EntryPermission.Start()
                GrantEntryPermission()
            endif
        endif

    elseif needOutfitChange == 1
        needOutfitChange = 0
        ;outfitTimerRunning = 0
        EquipOutfit()

    elseif p.InPresentHandsPose(sub1) && needOutfitChange == 2
        needOutfitChange = 0
        ;outfitTimerRunning = 0
        EquipOutfit()

    endif
endfunction

function DomChangedLocations(Location oldLoc, Location newLoc)

    ;debug.MessageBox("dom changed locations...")

endfunction

function OutfitChangeTimerExpired()
    if !p.InPresentHandsPose(sub1)
        bindc_Util.MarkInfraction("I didn't ask for a bondage change", true)
    endif
    needOutfitChange = 1
    ;outfitTimerRunning = 2
    MoveDomToSub()
endfunction

int function GetNeedOutfitChangeFlag()
    return needOutfitChange
endfunction

float function GetDistanceToSub()
    return dom.GetDistance(sub1)
endfunction

function SubPresentedHands()
    float d = dom.GetDistance(sub1)
    bindc_Util.WriteInformation("MoveDomToSub distance: " + d)
    if d > bindc_Util.MaxCheckRange()
        bindc_Util.WriteInternalMonologue(bindc_Util.GetDomTitle() + " is too far away to notice me...")
    elseif d < 128.0
        DomArrived()
    else
        MoveDomToSub()
    endif
endfunction

function AskedForHarshBondage()
    Kneel(true)
    bindc_Util.DoSleep(1.0)
    m.StartEvent("Harsh Bondage", true)
endfunction

function PullOutGag()
    if b.IsGagged(sub1)
        bindc_Util.WriteInternalMonologue("My gag is getting losened to speak...")
        b.ToggleGaggedEffect(sub1)
        gagPulledOut = true
    endif
endfunction

function PushInGag()
    if b.IsGagged(sub1) && gagPulledOut
        bindc_Util.WriteInternalMonologue("My gag is being pushed back in...")
        b.ToggleGaggedEffect(sub1)
        gagPulledOut = false
    endif
endfunction

event OnTrackedStatsEvent(string asStatFilter, int aiStatValue)

	bindc_Util.WriteInformation("bindc_Slavery - OnTrackedStatsEvent - asStatFilter: " + asStatFilter + " aiStatValue: " + aiStatValue)

	;https://ck.uesp.net/wiki/ListOfTrackedStats

	if (asStatFilter == "Skill Increases")
		r.TrainingRuleCheck()		
	endif

endevent

function EquipOutfit()
    bindc_Util.DoSleep(1.0)
    bindc_Util.PlayTyingAnimation(dom, sub1)
    bindc_Util.WriteNotification("close enough...")
    if targetOutfitId > 0
        b.EquipBondageOutfit(sub1, targetOutfitId)
        StorageUtil.SetIntValue(sub1, "bindc_outfit_id", targetOutfitId)
    else
        b.RemoveAllBondageItems(sub1, false)
        StorageUtil.SetIntValue(sub1, "bindc_outfit_id", -1)
    endif
    StorageUtil.SetIntValue(none, "bindc_outfit_last_safe", StorageUtil.GetIntValue(none, "bindc_safe_area", 1))
    bindc_Util.StopAnimations(dom)
    if posingFlag
        Kneel(false)
    endif
endfunction



function ProcessEquipOutfit()

    int safeArea = StorageUtil.GetIntValue(none, "bindc_safe_area", 1)
    int lastEquipSafeArea = StorageUtil.GetIntValue(none, "bindc_outfit_last_safe", 0)

    int currentOutfitId = StorageUtil.GetIntValue(sub1, "bindc_outfit_id", -1)
    int autoOutfitChanges = StorageUtil.GetIntValue(none, "bindc_auto_changes", 0)
    int presentHands = StorageUtil.GetIntValue(none, "bindc_present_hands", 0)

    int outfitId = b.GetBondageSetForLocation(sub1, newLocation, currentOutfitId)

    int usesRules = 0
    if outfitId > 0
        usesRules = StorageUtil.GetIntValue(none, "bindc_outfit_" + outfitId + "_rules_based", 0)
    endif

    if data_script.SlaveryQuest_InGaggedPunishment == 1
        outfitId = b.GetBondageOutfitForEvent(sub1, "event_gagged_for_punishment")
    endif

    bindc_Util.WriteInformation("outfit id: " + outfitId + " current: " + currentOutfitId + " userules: " + usesRules + " safe: " + safeArea + " lastesfa: " + lastEquipSafeArea)

    if outfitId > 0 && ((currentOutfitId != outfitId) || (usesRules == 1 && safeArea != lastEquipSafeArea))
        if autoOutfitChanges == 1
            b.EquipBondageOutfit(sub1, outfitId)
            StorageUtil.SetIntValue(sub1, "bindc_outfit_id", outfitId)
            StorageUtil.SetIntValue(none, "bindc_outfit_last_safe", safeArea)
        elseif presentHands == 1
            needOutfitChange = 2
            targetOutfitId = outfitId
        else
            needOutfitChange = 1
            targetOutfitId = outfitId
        endif
    elseif outfitId > 0 && ((currentOutfitId == outfitId) || (usesRules == 1 && safeArea == lastEquipSafeArea))
        bindc_Util.WriteInformation("leaving outfit equipped: " + outfitId)
    else
        ;remove bindings items if no outfit
        if autoOutfitChanges == 1
            b.RemoveAllBondageItems(sub1, false)
            StorageUtil.SetIntValue(sub1, "bindc_outfit_id", -1)
            StorageUtil.SetIntValue(none, "bindc_outfit_last_safe", safeArea)
        elseif presentHands == 1
            needOutfitChange = 2
            targetOutfitId = -1
        else
            needOutfitChange = 1
            targetOutfitId = -1
        endif
    endif

endfunction

function ProcessLocationChange(Location akOldLoc, Location akNewLoc)

    isIndoors = sub1.IsInInterior()
    oldLocation = akOldLoc
    newLocation = akNewLoc
    TheCurrentLoction.ForceLocationTo(akNewLoc)

    ProcessEquipOutfit()

    ; int currentOutfitId = StorageUtil.GetIntValue(sub1, "bindc_outfit_id", -1)
    ; int autoOutfitChanges = StorageUtil.GetIntValue(none, "bindc_auto_changes", 0)
    ; int outfitId = b.GetBondageSetForLocation(sub1, akNewLoc, currentOutfitId)
    ; int usesRules = 0
    ; if outfitId > 0
    ;     usesRules = StorageUtil.GetIntValue(none, "bindc_outfit_" + outfitId + "_rules_based", 0)
    ; endif
    ; if data_script.SlaveryQuest_InGaggedPunishment == 1
    ;     outfitId = b.GetBondageOutfitForEvent(sub1, "event_gagged_for_punishment")
    ; endif
    ; if outfitId > 0 && (currentOutfitId != outfitId || usesRules == 1)
    ;     if autoOutfitChanges == 1
    ;         b.EquipBondageOutfit(sub1, outfitId)
    ;         StorageUtil.SetIntValue(sub1, "bindc_outfit_id", outfitId)
    ;     else
    ;         needOutfitChange = 2
    ;         targetOutfitId = outfitId
    ;     endif
    ; elseif outfitId > 0 && currentOutfitId == outfitId
    ;     bindc_Util.WriteInformation("leaving outfit equipped: " + outfitId)
    ; else
    ;     ;remove bindings items if no outfit
    ;     if autoOutfitChanges == 1
    ;         b.RemoveAllBondageItems(sub1, false)
    ;         StorageUtil.SetIntValue(sub1, "bindc_outfit_id", -1)
    ;     else
    ;         needOutfitChange = 2
    ;         targetOutfitId = -1
    ;     endif
    ; endif

    ;todo - this on a delay
    ;EntryExitChecks(akOldLoc, akNewLoc)

    GoToState("EntryExitState")
    UnregisterForUpdate()
    RegisterForSingleUpdate(2.0)
    ;outfitTimerRunning = 1

    ;TODO - permissions need to flip between 1 or 2 depending on rule safe/unsafe options
    ;so if it is only enabled in safe areas (or vice versa) you don't get dinged for eating in that area and dialogue is hidden
    ;BehaviorFoodRuleMustAskPermission

    ;r.UpdateRulesByLocation(akNewLoc)

endfunction

state EntryExitState
    event OnUpdate()
        GoToState("")
        r.UpdateRulesByLocation(newLocation)
        ; if needOutfitChange > 0
        ;     bindc_Util.WriteInformation("starting ChangeOutfitState timer")
        ;     GoToState("ChangeOutfitState")
        ;     UnregisterForUpdate()
        ;     RegisterForSingleUpdate(10.0)
        ; endif
    endevent
endstate

; state ChangeOutfitState
;     event OnUpdate()
;         GoToState("")
;         ;debug.MessageBox("getting dom to change bondage...")
;         if needOutfitChange == 1
;             if dom.GetDistance(sub1) <= bindc_Util.MaxCheckRange()
;                 MoveDomToSub()
;                 outfitTimerRunning = 2
;             else
;                 outfitTimerRunning = 0
;             endif
;         elseif needOutfitChange == 2
;             if dom.GetDistance(sub1) <= bindc_Util.MaxCheckRange()
;                 StartOutfitTimer()
;                 bindc_Util.WriteInformation("starting OutfitTimerState timer")
;             else
;                 outfitTimerRunning = 0
;             endif
;         endif
;     endevent
; endstate



bool subUsingDoor = false

function SubUsedADoor(ObjectReference ref)
    subUsingDoor = true
    r.UsedDoor(ref, isIndoors, newLocation)
    subUsingDoor = false
endfunction

function SubLookedAtDoor(ObjectReference ref) 
    if subUsingDoor
        bindc_Util.WriteInformation("SubLookedAtDoor is busy - exiting")
        return
    endif
    r.LookedAtDoor(ref, isIndoors, newLocation)
endfunction

function SubPrayedAtShrine(string shrineGod)
    r.PrayedAtShrine(shrineGod, g.IsNude(sub1), g.IsWearingNoShoes(sub1), p.InPrayerPose(sub1))
endfunction

function GrantEatDrinkPermission()
    r.GrantEatDrinkPermission()
endfunction

function GrantEntryPermission()
    r.GrantEntryPermission()
endfunction

function GrantExitPermission()
    r.GrantExitPermission()
endfunction

function GrantLearnSpellPermission()
    r.GrantLearnSpellPermission()
endfunction

function GrantSpeechPermission()
    r.GrantSpeechPermission()
endfunction

function GrantPrayerPermission()
    r.GrantPrayerPermission()
endfunction

function GrantTalkToTrainerPermission()
    r.GrantTalkToTrainerPermission()
endfunction

function RewardGagRemoval()

    PushInGag()
    bindc_Util.DoSleep()

    if b.RemoveGag(sub1)
        StorageUtil.SetIntValue(sub1, "bindc_temp_gag_removal", 10) ;set this for 10 minutes (5 now due to 30s loop vs. 60s) - testing real time vs game time
        bindc_Util.ModifyPoints(-1)
        bindc_Util.WriteNotification("My gag is being removed... -1 points", bindc_Util.TextColorRed())
    endif

endfunction

function StartDomConversation()

    ; if b.IsGagged(sub1)
    ;     bindc_Util.WriteInternalMonologue(bindc_Util.GetDomTitle() + " will not while I am gagged...")
    ;     return
    ; endif

    if r.GetBehaviorRule(sub1, r.BEHAVIOR_RULE_SPEECH_DOM) == 1 && TheConversationTarget.GetActorReference() != dom

        bindc_Util.WriteInformation("have dom start conversation with: " + TheConversationTarget.GetActorReference().GetActorBase().GetName())

        MoveDomToSub()

        ; PullOutGag() ;this need to be made silent and does not seem to be working?

        ; bindc_Slavery_Scene_DomToNpc.Start()

        ; StorageUtil.SetFloatValue(sub1, "bindc_temp_speaking_permission", bindc_Util.AddTimeToCurrentTime(1, 0))

    endif

endfunction

function ProcessConversation()

    bool runChecks = true

	if dom.IsInDialogueWithPlayer()
		runChecks = false
	endif

    if runChecks

        debug.MessageBox(StorageUtil.GetIntValue(sub1, "bindc_has_speech_permission", 0))

		if r.GetBehaviorRule(sub1, r.BEHAVIOR_RULE_SPEECH_DOM) == 1 
			float tempSpeakingPermission = StorageUtil.GetFloatValue(sub1, "bindc_temp_speaking_permission", 0.0)
			if tempSpeakingPermission < bindc_Util.GetTime()
				bindc_Util.MarkInfraction("What was I thinking? I am not allowed to speak", true)
			endif

		elseif r.GetBehaviorRule(sub1, r.BEHAVIOR_RULE_SPEECH_ASK) == 1
			if StorageUtil.GetIntValue(sub1, "bindc_has_speech_permission", 0) == 0
				bindc_Util.MarkInfraction("Oh no, I forgot to ask permission to speak", true)
			endif

		elseif r.GetBehaviorRule(sub1, r.BEHAVIOR_RULE_SPEECH_POSE) == 1
			if !p.InConversationPose(sub1)
				bindc_Util.MarkInfraction("Oh dear, I was not posed properly", true)
			endif
		endif

    endif

    inConversation = 2

endfunction

function CrosshairTargetNpc(Actor targetNpc)
    if p.IsNotPosed(sub1) 
        TheConversationTarget.ForceRefTo(targetNpc)
        bindc_Util.WriteInformation("crosshair target npc: " + targetNpc.GetDisplayName())
    endif
endfunction

function StartGaggedPunishment()
    bindc_Util.PlayTyingAnimation(dom, sub1)
    data_script.SlaveryQuest_InGaggedPunishment = 1
    int outfitId = b.GetBondageOutfitForEvent(sub1, "event_gagged_for_punishment")
    if outfitId > 0
        b.EquipBondageOutfit(sub1, outfitId)
        StorageUtil.SetIntValue(sub1, "bindc_outfit_id", outfitId)
    endif
    data_script.SlaveryQuest_GaggedPunishmentEndTime = bindc_Util.AddTimeToCurrentTime(0, 30)
    bindc_Util.WriteInternalMonologue(bindc_Util.GetDomTitle() + " is punishing me with a gag...")
    bindc_Util.StopAnimations(dom)
endfunction

function EndGaggedPunishment()
    bindc_Util.PlayTyingAnimation(dom, sub1)
    int outfitId = b.GetBondageSetForLocation(sub1, newLocation, -1)
    if outfitId > 0
        b.EquipBondageOutfit(sub1, outfitId)
        StorageUtil.SetIntValue(sub1, "bindc_outfit_id", outfitId)
    endif
    data_script.SlaveryQuest_InGaggedPunishment = 0
    data_script.SlaveryQuest_GaggedPunishmentEndTime = 0.0
    bindc_Util.WriteInternalMonologue(bindc_Util.GetDomTitle() + " is removing my punishment gag...")
    bindc_Util.StopAnimations(dom)
endfunction

ReferenceAlias property DomRef Auto
ReferenceAlias property Sub1Ref Auto
ReferenceAlias property Sub2Ref Auto
ReferenceAlias property Sub3Ref Auto
ReferenceAlias property TheBuildingDoor auto
ReferenceAlias property TheConversationTarget auto

Faction property bindc_KneelingFaction auto

Package property bindc_PackageMoveToPlayer auto
Package property bindc_PackageSlaveryMoveToPlayer auto
Package property bindc_PackageSlaveryHoldPosition auto

bindc_Data property data_script auto

LocationAlias property TheCurrentLoction auto
LocationAlias property TheDoorDestination auto

Scene property bindc_Slavery_Scene_EntryPermission auto
Scene property bindc_Slavery_Scene_ExitPermission auto
Scene property bindc_Slavery_Scene_DomToNpc auto