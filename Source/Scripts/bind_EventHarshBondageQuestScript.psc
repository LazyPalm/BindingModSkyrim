Scriptname bind_EventHarshBondageQuestScript extends Quest  

Actor theSub
Actor theDom

float eventEndTime = 0.0

bool usingSet

event OnInit()

    if self.IsRunning()

        GoToState("")

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
        
        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        if main.HarshBondageMinMinutes == 0 && main.HarshBondageMaxMinutes == 0
            main.HarshBondageMinMinutes = 15
            main.HarshBondageMaxMinutes = 30
        endif

        bcs.DoStartEvent()
        bcs.SetEventName(self.GetName())

        SetObjectiveDisplayed(10, true)

        TieUpSub()

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("harsh bondage quest safeword ending")
    self.Stop()
endevent

event PressedAction(bool longPress)
    bind_Utility.WriteInternalMonologue("There is nothing else for me to do...")
endevent

state WaitingState

    event OnUpdate()

        bind_Utility.WriteToConsole("event time left: " + (eventEndTime - bind_Utility.GetTime()))

        if bind_Utility.GetTime() > eventEndTime
            GoToState("")
            FreeSub()
        else
            RegisterForSingleUpdate(15.0)
        endif

    endevent

    ; event PressedAction(bool longPress)
    
    ;     bind_Utility.WriteInternalMonologue("There is nothing for me to do...")

    ;     bind_Utility.WriteToConsole("action key pressed")
    
    ; endevent

endstate

function TieUpSub()

    bind_Utility.DisablePlayer()

    fs.EventGetSubReady(theSub, theDom, "event_harsh_bondage") ;, playAnimations = true, stripClothing = true, addGag = false, freeWrists = false, removeAll = true)

    ; string foundSet = bman.GetRandomSet("Event - Harsh Bondage")
    ; usingSet = false

    ; If foundSet != ""

    ;     bind_Utility.WriteToConsole("harsh bondage - found set: " + foundSet)

    ;     usingSet = true

    ;     bman.EquipSet(theSub, foundSet)

    ; Else

    ;     bool zresult

    ;     zresult = bman.AddSpecificItem(theSub, bind_HarshBondageItemsList.GetAt(0) as armor) ;bman.BONDAGE_TYPE_HARNESS())
    ;     bind_Utility.DoSleep()
    ;     zresult = bman.AddSpecificItem(theSub, bind_HarshBondageItemsList.GetAt(1) as armor) ; bman.BONDAGE_TYPE_HEAVYBONDAGE())
    ;     bind_Utility.DoSleep()

    ;     If bman.HarshBondageUseNipple == 1
    ;         zresult = bman.AddSpecificItem(theSub,  bind_HarshBondageItemsList.GetAt(2) as armor) ;"clamps_list", bman.GetFavoriteNippleClamps(),true)
    ;         bind_Utility.DoSleep()
    ;     EndIf
    ;     If bman.HarshBondageUseAnkles == 1
    ;         zresult = bman.AddSpecificItem(theSub, bind_HarshBondageItemsList.GetAt(3) as armor) ; bman.BONDAGE_TYPE_LEG_CUFFS())
    ;         bind_Utility.DoSleep()
    ;     EndIf
    ;     If bman.HarshBondageUseCollar == 1
    ;         zresult = bman.AddSpecificItem(theSub, bind_HarshBondageItemsList.GetAt(4) as armor) ; bman.BONDAGE_TYPE_COLLAR())
    ;         bind_Utility.DoSleep()
    ;     EndIf
    ;     If bman.HarshBondageUseBoots == 1
    ;         zresult = bman.AddSpecificItem(theSub, bind_HarshBondageItemsList.GetAt(5) as armor) ; bman.BONDAGE_TYPE_BOOTS())
    ;         bind_Utility.DoSleep()
    ;     EndIf
    ;     If bman.HarshBondageUseChastity == 1
    ;         zresult = bman.AddSpecificItem(theSub, bind_HarshBondageItemsList.GetAt(6) as armor) ; bman.BONDAGE_TYPE_BELT())
    ;         bind_Utility.DoSleep()
    ;     Endif
    ;     If bman.HarshBondageUseHood == 1
    ;         zresult = bman.AddSpecificItem(theSub, bind_HarshBondageItemsList.GetAt(7) as armor) ; bman.BONDAGE_TYPE_HOOD()) ;this will block a gag and blindfold
    ;         bind_Utility.DoSleep()
    ;     Else
    ;         If bman.HarshBondageUseBlindfold == 1
    ;             zresult = bman.AddSpecificItem(theSub, bind_HarshBondageItemsList.GetAt(8) as armor) ; bman.BONDAGE_TYPE_BLINDFOLD()) ;only try to equip if no hood
    ;             bind_Utility.DoSleep()
    ;         EndIf
    ;         zresult = bman.AddSpecificItem(theSub, bind_HarshBondageItemsList.GetAt(9) as armor) ; bman.BONDAGE_TYPE_GAG()) ;always try to equip if no hood
    ;         bind_Utility.DoSleep()
    ;     EndIf

    ; EndIf

    ; bind_MovementQuestScript.StopWorking(theDom)

    bind_Utility.WriteInternalMonologue("It looks like " + fs.GetDomTitle() + " will keep me like this for a bit...")

    bind_Utility.EnablePlayer()

    If Utility.RandomInt(1, 2) == 2
        ;dom decides to take advantage
        ;TestSex()
    EndIf

    eventEndTime = bind_Utility.AddTimeToCurrentTime(0, Utility.RandomInt(main.HarshBondageMinMinutes, main.HarshBondageMaxMinutes)) 
    
    GotoState("WaitingState")

    SetObjectiveCompleted(10)
    SetObjectiveDisplayed(10, false)
    SetObjectiveDisplayed(20, true)

    RegisterForSingleUpdate(1.0)
    
endfunction

function FreeSub()

    SetObjectiveCompleted(20)
    SetObjectiveDisplayed(20, false)
    SetObjectiveDisplayed(30, true)

    bind_Utility.WriteInternalMonologue("It seems that I am about to be freed...")

    bind_Utility.DisablePlayer()

    if usingSet
        bman.RemoveAllDetectedBondageItems(theSub)
        bind_Utility.DoSleep(2.0)
    endif

    fs.EventCleanUpSub(theSub, theDom, true)

    bind_Utility.EnablePlayer()

    If fs.GetRuleInfractions() > 0
        bind_Utility.WriteNotification(fs.GetDomTitle() + " canceled a punishment for being a good bondage pet.", bind_Utility.TextColorBlue())
        fs.AdjustRuleInfractions(-1)
    elseif fs.GetPointsFromHarshBondage()
        bind_Utility.WriteNotification(fs.GetDomTitle() + " enjoyed seeing you suffer in bondage and decided to award you a point.", bind_Utility.TextColorBlue())
        fs.AddPoint()
    Else 
    	bind_Utility.WriteNotification(fs.GetDomTitle() + " enjoyed the bondage show...", bind_Utility.TextColorBlue())
    EndIf

    float ct = bind_Utility.GetTime()
    bind_GlobalEventHarshBondageNextRun.SetValue(bind_Utility.AddTimeToTime(ct, bind_GlobalEventHarshBondageHoursBetween.GetValue() as int, 0))
    bind_GlobalEventHarshBondageLastRun.SetValue(ct)

    bcs.DoEndEvent()

    SetStage(20)
    SetObjectiveCompleted(30)
    SetObjectiveDisplayed(30, false)

    self.Stop()

endfunction

bind_MainQuestScript property main auto
bind_BondageManager property bman auto
bind_Controller property bcs auto
bind_GearManager property gms auto
bind_Functions property fs auto

GlobalVariable property bind_GlobalEventHarshBondageNextRun auto
GlobalVariable property bind_GlobalEventHarshBondageLastRun auto
GlobalVariable property bind_GlobalEventHarshBondageHoursBetween auto

FormList property bind_HarshBondageItemsList auto