Scriptname bind_EventPutOnDisplayQuestScript extends Quest  

float eventEndTime = 0.0

bool menuActive = false
bool keyPressed = false

Actor theSub
Actor theDom
ObjectReference furn

ObjectReference furnitureMarker

event OnInit()

    if self.IsRunning()

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        if mqs.PutOnDisplayMinMinutes == 0 && mqs.PutOnDisplayMaxMinutes == 0
            mqs.PutOnDisplayMinMinutes = 10
            mqs.PutOnDisplayMaxMinutes = 20
        endif

        menuActive = false
        keyPressed = false

        furn = TheFurniture.GetReference()
        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        bcs.DoStartEvent()
        bcs.SetEventName(self.GetName())

        SetObjectiveDisplayed(10, true)

        furnitureMarker = furn.PlaceAtMe(bind_PutOnDisplayItemsList.GetAt(0))
        furnitureMarker.Enable()

        GoToState("KneelByFurnitureState")

    endif

endevent

event SafewordEvent()

    bind_Utility.WriteToConsole("put on display quest safeword ending")

    if furnitureMarker != none
        furnitureMarker.Delete()
        furnitureMarker = none
    endif

    self.Stop()

endevent

state KneelByFurnitureState

    event PressedAction(bool longPress)

        if !keyPressed
            keyPressed = true

            bind_Utility.WriteToConsole("distance to furn: " + theSub.GetDistance(furn))

            if theSub.GetDistance(furn) <= 200.0
                GoToState("")
                EventStart()
            else
                bind_Utility.WriteInternalMonologue("I need to move closer...")
            endif

            keyPressed = false
        endif

    endevent

endstate

event PressedAction(bool longPress)

    bind_Utility.WriteInternalMonologue("There is nothing I can do...")

    bind_Utility.WriteToConsole("pressed action in put on display - no state")

endevent

function EventStart()

    bind_Utility.DisablePlayer()

    furnitureMarker.Delete()
    furnitureMarker = none

    bind_MovementQuestScript.PlayKneel(theSub)

    fs.EventGetSubReady(theSub, theDom, "event_put_on_display");, true, true, true, false)

    bind_MovementQuestScript.PlayDoWork(theDom)

    fman.LockInFurniture(theSub, furn, true)

    bind_Utility.DoSleep(2.0)

    if !theSub.IsInFaction(bind_CrowdTriggerToWatch)
        theSub.AddToFaction(bind_CrowdTriggerToWatch)
    endif

    SetObjectiveCompleted(10)
    SetObjectiveDisplayed(10, false)
    SetObjectiveDisplayed(20, true)

    bind_MovementQuestScript.StartSandbox(theDom, theSub)

    eventEndTime = bind_Utility.AddTimeToCurrentTime(0, Utility.RandomInt(mqs.PutOnDisplayMinMinutes, mqs.PutOnDisplayMaxMinutes)) 

    GoToState("WaitingState")
    RegisterForSingleUpdate(1.0)

endfunction

state WaitingState

    event OnUpdate()

        bind_Utility.WriteToConsole("event time left: " + (eventEndTime - bind_Utility.GetTime()))

        if bind_Utility.GetTime() > eventEndTime
            EventEnd()
        else
            RegisterForSingleUpdate(15.0)
        endif

    endevent

    event PressedAction(bool longPress)

        if !keyPressed
            keyPressed = true
            ShowMenu()
            keyPressed = false
        endif
    
        bind_Utility.WriteToConsole("pressed action in put on display - waiting state")
    
    endevent

endstate

function EventEnd()

    SetObjectiveCompleted(20)
    SetObjectiveDisplayed(20, false)
    SetObjectiveDisplayed(30, true)

    bind_MovementQuestScript.EndSandbox()

    bind_MovementQuestScript.WalkTo(theDom, theSub)

    bind_MovementQuestScript.PlayDoWork(theDom)

    fman.UnlockFromFurniture(theSub, furn, true)

    bind_Utility.DisablePlayer()

    bind_Utility.DoSleep(1.0)

    fs.EventCleanUpSub(theSub, theDom, true)

    bind_Utility.EnablePlayer()

    if theSub.IsInFaction(bind_CrowdTriggerToWatch)
        theSub.RemoveFromFaction(bind_CrowdTriggerToWatch)
    endif

    SetObjectiveCompleted(30)
    SetObjectiveDisplayed(30, false)

    SetStage(20)

    If fs.GetRuleInfractions() > 0
        ; bind_Utility.WriteNotification(mqs.GetDomTitle() + " canceled a punishment.", bind_Utility.TextColorBlue())
        ; mqs.AdjustRuleInfractions(-1)
    elseif fs.GetPointsFromFurniture()
        bind_Utility.WriteNotification(fs.GetDomTitle() + " enjoyed seeing you suffer in furniture and decided to award you a point.", bind_Utility.TextColorBlue())
        fs.AddPoint()
    Else 
    	;bind_Utility.WriteNotification(mqs.GetDomTitle() + " enjoyed the furniture show...", bind_Utility.TextColorBlue())
    EndIf

    bind_GlobalEventPutOnDisplayNextRun.SetValue(bind_Utility.AddTimeToCurrentTime(mqs.PutOnDisplayHoursBetweenUse, 0))

    bcs.DoEndEvent()

    self.Stop()

endfunction

function ShowMenu()

    float minutesLeft = (eventEndTime - bind_Utility.GetTime()) * 1440.0

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    listMenu.AddEntryItem("I will just keep waiting (" + Math.Ceiling(minutesLeft) + " m).")
    listMenu.AddEntryItem("Beg the gods to skip to the end.")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()
    if listReturn == 0
    elseif listReturn == 1
        bind_Utility.WriteToConsole("put on display - skip to end - minutes left: " + minutesLeft + " hours: " + (minutesLeft / 60.0))
        bind_Utility.AdvanceGameTime((minutesLeft / 60.0))
        UnregisterForUpdate()
        RegisterForSingleUpdate(1.0)
    else
    endif

endfunction

bind_MainQuestScript property mqs auto
bind_Controller property bcs auto
bind_BondageManager property bms auto
bind_GearManager property gms auto
bind_Functions property fs auto

bind_FurnitureManager property fman auto

GlobalVariable property bind_GlobalEventPutOnDisplayNextRun auto

ReferenceAlias property TheFurniture auto

Faction property bind_CrowdTriggerToWatch auto

FormList property bind_PutOnDisplayItemsList auto