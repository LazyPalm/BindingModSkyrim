Scriptname bind_PublicHumiliationQuestScript extends Quest  

Actor theSub
Actor theDom

bool keyPressed
bool usingSet

float eventEndTime
float minimumDistance

ObjectReference thePublicSquare

event OnInit()

    if self.IsRunning()

        ;debug.MessageBox("put on display pro started...")

        bcs.DoStartEvent()
        bcs.SetEventName(self.GetName())

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        if mqs.PublicHumiliationMinMinutes == 0 && mqs.PublicHumiliationMaxMinutes == 0
            mqs.PublicHumiliationMinMinutes = 60
            mqs.PublicHumiliationMaxMinutes = 120
        endif

        eventEndTime = 0.0
        minimumDistance = 1000.0

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        thePublicSquare = PublicSquareMarker.GetReference()

        SetStage(10)

        StartTheQuest()

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("public humiliation quest safeword ending")
    self.Stop()
endevent

event PressedAction(bool longPress)
    bind_Utility.WriteInternalMonologue("There is nothing for me to do...")
endevent

function StartTheQuest()

    BindSub()

    ;debug.MessageBox("distance: " + thePublicSquare.GetDistance(theSub) + " min: " + minimumDistance)

    if thePublicSquare.GetDistance(theSub) <= minimumDistance

        ;debug.MessageBox("here")

        GoToState("WaitingState")
        SetObjectiveDisplayed(20, true)

    else

        ;debug.MessageBox("travel")

        GoToState("TravelState")
        SetObjectiveDisplayed(10, true)

    endif

    RegisterForSingleUpdate(1.0)

endfunction

function BindSub()

    bind_Utility.DisablePlayer()

    fs.EventGetSubReady(theSub, theDom, "event_public_humilation") ;, playAnimations = true, stripClothing = true, addGag = false, freeWrists = false, removeAll = true)

    ; string foundSet = bms.GetRandomSet("Public Humiliation")
    ; usingSet = false

    ; If foundSet != ""

    ;     bind_Utility.WriteToConsole("Public Humiliation - found set: " + foundSet)

    ;     usingSet = true

    ;     bms.EquipSet(theSub, foundSet)

    ; Else

    ;     bool zresult

    ;     int i = 0
    ;     while i < bind_PublicHumiliationItemsList.GetSize()
    ;         Form dev = bind_PublicHumiliationItemsList.GetAt(i)
    ;         zresult = bms.AddSpecificItem(theSub, dev as Armor)
    ;         bind_Utility.DoSleep()
    ;         i += 1
    ;     endwhile

    ; EndIf

    bind_MovementQuestScript.StopWorking(theDom)

    ;bind_Utility.WriteInternalMonologue("It looks like " + main.GetDomTitle() + " will keep me like this for a bit...")

    bind_Utility.EnablePlayer()

endfunction

state TravelState

    event OnUpdate()

        bind_Utility.WriteToConsole("current distance: " + thePublicSquare.GetDistance(theSub))

        if thePublicSquare.GetDistance(theSub) <= minimumDistance
            Arrived()
            GoToState("WaitingState")
            RegisterForSingleUpdate(1.0)
        else
            RegisterForSingleUpdate(15.0)
        endif

    endevent

endstate

function Arrived()

    SetObjectiveCompleted(10)
    SetObjectiveDisplayed(10, false)
    SetObjectiveDisplayed(20, true)
    
    eventEndTime = bind_Utility.AddTimeToCurrentTime(0, Utility.RandomInt(mqs.PublicHumiliationMinMinutes, mqs.PublicHumiliationMaxMinutes)) 

    bind_Utility.WriteInternalMonologue("Everyone is looking at me...")

    if !theSub.IsInFaction(bind_CrowdTriggerToWatch)
        theSub.AddToFaction(bind_CrowdTriggerToWatch)
    endif

endfunction

state WaitingState

    event OnUpdate()

        bind_Utility.WriteToConsole("event time left: " + (eventEndTime - bind_Utility.GetTime()))

        if bind_Utility.GetTime() > eventEndTime
            GoToState("")
            EndTheQuest()
        else
            if TestForShock()
                RegisterForSingleUpdate(10.0) ;shock more often
            else
                RegisterForSingleUpdate(15.0)
            endif
        endif

    endevent

    event PressedAction(bool longPress)
        
        if !keyPressed
            keyPressed = true
            ShowMenu()
            keyPressed = false
        endif
    
        bind_Utility.WriteToConsole("pressed action in public humiliation - waiting state")

    endevent
    
endstate

bool function TestForShock()

    bool result = false

    if thePublicSquare.GetDistance(theSub) > minimumDistance

        bms.TriggerShock(theSub)

        bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is shocking me for moving too far...")

        eventEndTime = bind_Utility.AddTimeToTime(eventEndTime, 0, 10)
        bind_Utility.WriteNotification("Ten minutes added for not obeying", bind_Utility.TextColorRed())

        result = true

    endif

    return result

endfunction

function FreeSub()

    bind_Utility.DisablePlayer()

    if usingSet

    endif

    ; bms.RemoveAllDetectedBondageItems(theSub)
    ; bind_Utility.DoSleep(2.0)

    fs.EventCleanUpSub(theSub, theDom, true)

    if theSub.IsInFaction(bind_CrowdTriggerToWatch)
        theSub.RemoveFromFaction(bind_CrowdTriggerToWatch)
    endif

    bind_Utility.EnablePlayer()

    ;fs.AdjustRuleInfractions(-1)

endfunction

function EndTheQuest()

    SetObjectiveCompleted(20)
    ;SetObjectiveDisplayed(20, false)

    bind_Utility.WriteInternalMonologue("It seems that I am about to be freed...")

    FreeSub()

    bcs.DoEndEvent()
    
    SetStage(20)

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
        bind_Utility.WriteToConsole("public humiliation - skip to end - minutes left: " + minutesLeft + " hours: " + (minutesLeft / 60.0))
        bind_Utility.AdvanceGameTime((minutesLeft / 60.0))
        UnregisterForUpdate()
        RegisterForSingleUpdate(1.0)
    else
    endif

endfunction

bind_MainQuestScript property mqs auto
bind_Controller property bcs auto
bind_BondageManager property bms auto
bind_Functions property fs auto

FormList property bind_PublicHumiliationItemsList auto

ReferenceAlias property PublicSquareMarker auto

Faction property bind_CrowdTriggerToWatch auto