Scriptname bind_GoAdventuringQuestScript extends Quest  

Actor theDom
Actor theSub

float waitForSeconds = 5.0

event OnInit()

    if self.IsRunning()

        waitForSeconds = mqs.AdventuringCheckAfterSeconds

        theDom = fs.GetDomRef()
        theSub = fs.GetSubRef()

        RegisterForModEvent("bind_EnteringSafeAreaEvent", "EnteringSafeAreaEvent")
        RegisterForModEvent("bind_LeavingSafeAreaEvent", "LeavingSafeAreaEvent")

        bind_Utility.WriteToConsole("running adventure quest...")

        ;RegisterForSingleUpdate(waitForSeconds) 

        GotoState("RunCheckState")

    endif

endEvent

event EnteringSafeAreaEvent()
endevent

event LeavingSafeAreaEvent()
endevent

function EnteringSafeArea()
endfunction

function LeavingSafeArea()
endfunction

function ResetTimers()
    ;NOTE - if the player triggers another location change while this is running, reset the timer
    bind_Utility.WriteToConsole("adventure quest reset timer")
    UnregisterForUpdate()
    RegisterForSingleUpdate(waitForSeconds)
endfunction

state RunCheckState

    event EnteringSafeAreaEvent()
        ResetTimers()
    endevent

    event LeavingSafeAreaEvent()
        ResetTimers()
    endevent

    event OnUpdate()
        
        int safeZone = bind_GlobalSafeZone.GetValue() as int

        ;debug.MessageBox("safeZone: " + safeZone)

        if safeZone >= 2
            ;in a safe area
            bind_Utility.WriteToConsole("Safe area checks")
            EnteringSafeArea()

        else
            ;in an unsafe area
            bind_Utility.WriteToConsole("Outside safe area checks")
            LeavingSafeArea()

        endif

        ;self.Stop()

    endevent

    function EnteringSafeArea()

        if !theDom
            ;this gets lost when changing doms
            theDom = fs.GetDomRef()
        endif

        if mqs.AdventuringAutomatic == 0
            ;TODO - this needs to check if player has active bondage rules            
            if !fs.GetSafeAreaBondageApplied()
                fs.MarkSubBrokeRule("I did not ask to have my safe area bondage rules added")
            endif
            ;debug.MessageBox("entering....")
            return
        endif

        ; if !fs.ModInRunningState()
        ;     bind_Utility.WriteToConsole("EnteringSafeArea exiting mod not in running state")
        ;     ;return
        ; endif

        StorageUtil.SetIntValue(theSub, "bind_safe_area_interaction_check", 1) ;set to starting

        if theDom.GetDistance(theSub) < 1500.0

            bool nudityRuleFlag = rms.IsNudityRequired(theSub, true) 

            ;debug.MessageBox(nudityRuleFlag)

            if nudityRuleFlag
                gms.RemoveWornGear(theSub)
            endif

            debug.MessageBox("Go quest - EnteringSafeArea")
            bms.UpdateBondage(theSub, false)

            StorageUtil.SetIntValue(theSub, "bind_safe_area_interaction_check", 2) ;set to completed

        else

            ;NOTE - need the dom to do an LOS check and run the rule enforcement code when they see the sub

            bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is not nearby to enforce my rules...")

            StorageUtil.SetIntValue(theSub, "bind_safe_area_interaction_check", 3) ;set to to-do

        endif

    endfunction

    function LeavingSafeArea()

        if mqs.AdventuringAutomatic == 0
            ;debug.MessageBox("leaving....")
            return
        endif

        ; if !fs.ModInRunningState()
        ;     bind_Utility.WriteToConsole("LeavingSafeArea exiting mod not in running state")
        ;     ;return
        ; endif

        ;debug.MessageBox("LeavingSafeArea")

        StorageUtil.SetIntValue(theSub, "bind_safe_area_interaction_check", 0) ;set to off

        bool nudityRuleFlag = rms.IsNudityRequired(theSub, false) 

        ;debug.MessageBox(nudityRuleFlag)

        debug.MessageBox("Go quest - LeavingSafeArea")
        bms.UpdateBondage(theSub, false)

        if !nudityRuleFlag
            gms.RestoreWornGear(theSub)
        endif

    endfunction

    ; function EnteringSafeArea()

    ;     bool nudeFlag = gms.IsNude(theSub)
    ;     bool boundFlag = theSub.IsInFaction(bms.WearingHeavyBondageFaction())

    ;     bool nudityRuleFlag = rms.IsNudityRequired() ; (rms.GetBehaviorRuleByName("Body Rule:Nudity") == 1)
    ;     bool boundRuleFlag = rms.IsHeavyBondageRequired() ;(rms.GetBondageRuleByName("Bound Rule") == 1)

    ;     bool brokeNudityRule = false
    ;     bool brokeBoundRule = false

    ;     bool autoStrip = false
    ;     bool autoBind = false

    ;     if mqs.AdventuringSuspendRules == 1
    ;         if nudityRuleFlag
    ;             gms.RemoveWornGear(theSub)
    ;         endif
    ;         bind_Utility.DoSleep()
    ;         bms.RestoreFromSnapshot(theSub)
    ;         return
    ;     endif

    ;     if mqs.AdventuringAutomatic == 1

    ;         if nudityRuleFlag && !nudeFlag
    ;             autoStrip = true
    ;         endif

    ;         if boundRuleFlag && !boundFlag
    ;             autoBind = true
    ;         endif

    ;     else
            
    ;         if nudityRuleFlag && !nudeFlag
    ;             brokeNudityRule = true
    ;             autoStrip = true
    ;             mqs.CalculateDistanceAtAction()
    ;         endif
            
    ;         if boundRuleFlag && !boundFlag
    ;             brokeBoundRule = true
    ;             autoBind = true
    ;             mqs.CalculateDistanceAtAction()
    ;         endif

    ;         if brokeNudityRule && brokeBoundRule
    ;             mqs.MarkSubBrokeRule("I was supposed to be nude and bound", true)
    ;         elseif brokeNudityRule
    ;             mqs.MarkSubBrokeRule("I was supposed to be nude", true)
    ;         elseif brokeBoundRule 
    ;             mqs.MarkSubBrokeRule("I was supposed to be bound", true)
    ;         endif

    ;     endif

    ;     if autoStrip && bind_GlobalSuspendNudity.GetValue() == 0.0
    ;         gms.RemoveWornGear(theSub)
    ;     endif

    ;     if autoBind && bind_GlobalSuspendHeavyBondage.GetValue() == 0.0
    ;         if theSub.IsOnMount()
    ;             theSub.Dismount()
    ;             bind_Utility.DoSleep()
    ;         endif
    ;         bms.AddItem(theSub, bms.BONDAGE_TYPE_HEAVYBONDAGE())
    ;     endif

    ; endfunction
    
    ; function LeavingSafeArea()

    ;     if mqs.AdventuringSuspendRules == 1
    ;         bms.SnapshotCurrentBondage(theSub)
    ;         bind_Utility.DoSleep()
    ;         bms.RemoveAllBondageItems(theSub)
    ;         bind_Utility.DoSleep(1.0)
    ;         gms.RestoreWornGear(theSub)
    ;         return
    ;     endif

    ;     bool nudeFlag = gms.IsNude(theSub)
    ;     bool boundFlag = theSub.IsInFaction(bms.WearingHeavyBondageFaction())

    ;     bool nudityRuleFlag = rms.IsNudityRequired(); (rms.GetBehaviorRuleByName("Body Rule:Nudity") == 1)
    ;     bool boundRuleFlag = rms.IsHeavyBondageRequired() ;(rms.GetBondageRuleByName("Bound Rule") == 1)

    ;     if mqs.AdventuringAutomatic == 1

    ;         if mqs.AdventuringFreeHands == 1 && boundFlag
    ;             bms.RemoveItem(theSub, bms.BONDAGE_TYPE_HEAVYBONDAGE())
    ;         endif

    ;         if mqs.AdventuringAllowClothing == 1 && nudeFlag
    ;             gms.RestoreWornGear(theSub)
    ;         endif
                
    ;     else

    ;         if mqs.AdventuringFreeHands == 1 && boundRuleFlag && boundFlag

    ;         endif

    ;         if mqs.AdventuringAllowClothing == 1 && nudityRuleFlag && nudeFlag

    ;         endif

    ;     endif

    ; endfunction

endstate

bind_Controller property bcs auto
bind_BondageManager property bms auto
bind_GearManager property gms auto
bind_MainQuestScript property mqs auto
bind_RulesManager property rms auto
bind_Functions property fs auto

GlobalVariable property bind_GlobalSafeZone auto

GlobalVariable property bind_GlobalSuspendHeavyBondage auto
GlobalVariable property bind_GlobalSuspendNudity auto