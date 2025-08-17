Scriptname bind_BoundMasturbationQuestScript extends Quest  

Actor theSub
Actor theDom

bool replaceGear

int endMessage

event OnInit()

    if self.IsRunning()

        GoToState("")

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("AnimationEnd", "OnSexEndEvent")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        ;SetObjectiveDisplayed(10, true)

        StartEvent()

    endif

endevent

event SafewordEvent()
    
    bind_Utility.WriteToConsole("bound masturbation quest safeword ending")

    self.Stop()

endevent

event PressedAction(bool longPress)

    bind_Utility.WriteInternalMonologue("I am too busy with myself...")

    ; if !pressedAction
    ;     pressedAction = true
    ;     ShowActionMenu()
    ;     pressedAction = false
    ; endif

endevent

event OnSexEndEvent(string eventName, string argString, float argNum, form sender)

    StopEvent()

endevent

function StartEvent()

    bcs.DoStartEvent()
    bcs.SetEventName(self.GetName())

    replaceGear = false
    endMessage = 0

    if theDom.GetDistance(theSub) < 3000.0 && sms.SubHasMasturbationPermission == 1

        replaceGear = true

        bind_Utility.DisablePlayer()

        bind_MovementQuestScript.FaceTarget(theDom, theSub)

        fs.EventGetSubReady(theSub, theDom, "event_bound_masturbation")

        ;remove chastity chance
        if theSub.IsInFaction(bms.WearingBeltFaction())
            if bms.RemoveItem(theSub, bms.BONDAGE_TYPE_BELT())
                bind_Utility.DoSleep()
            endif
        endif

        if sms.BoundMasturbationUnties == 1
            if theSub.IsInFaction(bms.WearingHeavyBondageFaction())
                if bms.RemoveItem(theSub, bms.BONDAGE_TYPE_HEAVYBONDAGE())
                    bind_Utility.DoSleep()
                endif
            endif
        endif

        ;set other bondage

        if sms.BoundMasturbationAPlug == 1
            if bms.AddItem(theSub, bms.BONDAGE_TYPE_A_PLUG())
                bind_Utility.DoSleep()
            endif
        endif

        if sms.BoundMasturbationVPlug == 1
            if bms.AddItem(theSub, bms.BONDAGE_TYPE_V_PLUG())
                bind_Utility.DoSleep()
            endif
        endif

        if sms.BoundMasturbationGag == 1
            if !theSub.IsInFaction(bms.WearingGagFaction())
                if bms.AddItem(theSub, bms.BONDAGE_TYPE_GAG())
                    bind_Utility.DoSleep()
                endif
            endif
        endif

        if sms.BoundMasturbationBlindfold == 1
            if !theSub.IsInFaction(bms.WearingBlindfoldFaction())
                if bms.AddItem(theSub, bms.BONDAGE_TYPE_BLINDFOLD())
                    bind_Utility.DoSleep()
                endif
            endif
        endif

        if sms.BoundMasturbationBlindfold == 1
            if !theSub.IsInFaction(bms.WearingHoodFaction())
                if bms.AddItem(theSub, bms.BONDAGE_TYPE_HOOD())
                    bind_Utility.DoSleep()
                endif
            endif
        endif

        if sms.BoundMasturbationHood == 1
            if !theSub.IsInFaction(bms.WearingHeavyBondageFaction())
                if bms.AddItem(theSub, bms.BONDAGE_TYPE_HEAVYBONDAGE())
                    bind_Utility.DoSleep()
                endif
            endif
        endif

        if sms.BoundMasturbationCuffs == 1
            if !theSub.IsInFaction(bms.WearingHeavyBondageFaction()) && !theSub.IsInFaction(bms.WearingArmCuffsFaction())
                if bms.AddItem(theSub, bms.BONDAGE_TYPE_ARM_CUFFS())
                    bind_Utility.DoSleep()
                endif
            endif
            if !theSub.IsInFaction(bms.WearingLegCuffsFaction())
                if bms.AddItem(theSub, bms.BONDAGE_TYPE_LEG_CUFFS())
                    bind_Utility.DoSleep()
                endif
            endif
        endif

        bind_Utility.EnablePlayer()
        
        endMessage = 1

    elseif sms.SubHasMasturbationPermission == 0
        ;breaking rules
        endMessage = 2

    else
        ;too far for the dom to notice
        endMessage = 3

    endif

	if !sms.StartSexScene(theSub)
        debug.MessageBox("Could not start sex scene")
        StopEvent()
    endif

    ; if !bind_SexLabHelper.StartOnePersonSex(theSub)
    ;     StopEvent()
    ; endif

    ;bind_MovementQuestScript.PlayDoWork(theDom)

endfunction

function StopEvent()

    if replaceGear

        bind_Utility.DisablePlayer()

        bind_MovementQuestScript.FaceTarget(theDom, theSub)

        fs.EventCleanUpSub(theSub, theDom, true)

        bind_Utility.EnablePlayer()

    endif

    if endMessage == 1

    elseif endMessage == 2
        fs.MarkSubBrokeRule("I am going to get punished for touching myself")

    elseif endMessage == 3
        bind_Utility.WriteInternalMonologue("I hope I do not get caught...")

    endif

    ;update arousal tracking
    sms.UpdateArousalLevels()

    sms.SubHasMasturbationPermission = 0

    bcs.DoEndEvent()

    ; SetObjectiveCompleted(10)
    ; SetObjectiveDisplayed(10, false)
    ; SetStage(20)

    self.Stop()

endfunction

bind_MainQuestScript property mqs auto
bind_BondageManager property bms auto
bind_Controller property bcs auto
bind_GearManager property gms auto
bind_SexManager property sms auto
bind_RulesManager property rms auto
bind_Functions property fs auto