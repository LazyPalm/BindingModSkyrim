Scriptname bind_BoundSexQuestScript extends Quest  

Actor theSub
Actor theDom

event OnInit()

    if self.IsRunning()

        GoToState("")

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("AnimationEnd", "OnSexEndEvent")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
        RegisterForModEvent("bind_EventCombatStartedInEvent", "CombatStartedInEvent")

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        SetObjectiveDisplayed(10, true)

        StartEvent()

    endif

endevent

event SafewordEvent()
    
    bind_Utility.WriteToConsole("bound sex quest safeword ending")

    self.Stop()

endevent

event CombatStartedInEvent(Form akTarget)
    if bind_Utility.ConfirmBox("Your party has been attacked. End this?", "I must fight", fs.GetDomTitle() + " can handle this. Leave me.")
        fs.Safeword()
    endif
endevent

event PressedAction(bool longPress)

    bind_Utility.WriteInternalMonologue("I am getting fucked...")

    ; if !pressedAction
    ;     pressedAction = true
    ;     ShowActionMenu()
    ;     pressedAction = false
    ; endif

endevent

event OnSexEndEvent(string eventName, string argString, float argNum, form sender)

    StopEvent(sexAnimationRan = true)

endevent

function StartEvent()

    bcs.DoStartEvent()
    bcs.SetEventName(self.GetName())

    bind_Utility.DisablePlayer()

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    fs.EventGetSubReady(theSub, theDom, "event_bound_sex") ;, playAnimations = true, stripClothing = true, addGag = false, freeWrists = false, removeAll = false)

    ;remove chastity chance
    if theSub.IsInFaction(bms.WearingBeltFaction())
        int roll = Utility.RandomInt(0, 99)
        if roll <= mqs.SexChanceOfChastityRemoval
            if bms.RemoveItem(theSub, bms.BONDAGE_TYPE_BELT())
                bind_Utility.DoSleep()
            endif
        else
            bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is leaving this chastity belt locked...")
        endif
    endif

    ;set other bondage

    if !theSub.IsInFaction(bms.WearingBeltFaction())
        ;add plugs if not locked in a belt
        ;todo - check for an open belt??
        if sms.BoundSexAPlug == 1
            if bms.AddItem(theSub, bms.BONDAGE_TYPE_A_PLUG())
                bind_Utility.DoSleep()
            endif
        endif
        if sms.BoundSexVPlug == 1
            if bms.AddItem(theSub, bms.BONDAGE_TYPE_V_PLUG())
                bind_Utility.DoSleep()
            endif
        endif
    endif

    if sms.BoundSexGag == 1
        if !theSub.IsInFaction(bms.WearingGagFaction())
            if bms.AddItem(theSub, bms.BONDAGE_TYPE_GAG())
                bind_Utility.DoSleep()
            endif
        endif
    endif

    if sms.BoundSexBlindfold == 1
        if !theSub.IsInFaction(bms.WearingBlindfoldFaction())
            if bms.AddItem(theSub, bms.BONDAGE_TYPE_BLINDFOLD())
                bind_Utility.DoSleep()
            endif
        endif
    endif

    if sms.BoundSexHood == 1
        if !theSub.IsInFaction(bms.WearingHoodFaction())
            if bms.AddItem(theSub, bms.BONDAGE_TYPE_HOOD())
                bind_Utility.DoSleep()
            endif
        endif
    endif

    if sms.BoundSexHeavyBondage == 1
        if !theSub.IsInFaction(bms.WearingHeavyBondageFaction())
            if bms.AddItem(theSub, bms.BONDAGE_TYPE_HEAVYBONDAGE())
                bind_Utility.DoSleep()
            endif
        endif
    endif

    if sms.BoundSexCuffs == 1
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

    bind_Utility.DoSleep(2.0)

    bind_Utility.EnablePlayer()

    if !sms.StartSexScene(theSub, theDom)
        debug.MessageBox("Could not start sex scene")
        StopEvent(sexAnimationRan = false)
    endif

    ; if !bind_SexLabHelper.StartTwoPersonSex(theDom, theSub)
    ;     StopEvent()
    ; endif

    ;bind_MovementQuestScript.PlayDoWork(theDom)

endfunction

function StopEvent(bool sexAnimationRan)

    bind_Utility.DisablePlayer()

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    fs.EventCleanUpSub(theSub, theDom, true)

    bind_Utility.EnablePlayer()

    bcs.DoEndEvent()

    SetObjectiveCompleted(10)
    SetObjectiveDisplayed(10, false)
    SetStage(20)

    if sexAnimationRan
        if rms.GetBehaviorRule(theSub, rms.BEHAVIOR_RULE_SEX_GIVE_THANKS()) == 1 
            sms.SubRequiredToThankForSex = 1
            if !bind_SexGiveThanksQuest.IsRunning()
                bind_SexGiveThanksQuest.Start()
            endif
        else
            sms.SubRequiredToThankForSex = 0
        endif
    endif

    ;update arousal tracking
    sms.UpdateArousalLevels()

    self.Stop()

endfunction

bind_MainQuestScript property mqs auto
bind_BondageManager property bms auto
bind_Controller property bcs auto
bind_GearManager property gms auto
bind_SexManager property sms auto
bind_RulesManager property rms auto
bind_Functions property fs auto

Quest property bind_SexGiveThanksQuest auto