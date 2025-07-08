Scriptname bind_EventBoundSleepQuestScript extends Quest  

float eventEndTime = 0.0

bool menuActive = false
bool keyPressed = false

Actor theSub
Actor theDom
ObjectReference theBed
ObjectReference theFurniture
bool foundFurniture
bool subInFurniture
int bedOwnership
ActorBase oldBedOwner
Faction oldBedFaction

event OnInit()

    if self.IsRunning()

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        menuActive = false
        keyPressed = false

        theBed = fs.EventGetNearbyBed()
        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        if NearestFurniture.GetReference()
            foundFurniture = true
            theFurniture = NearestFurniture.GetReference()
        else
            foundFurniture = false
        endif

        subInFurniture = false
        
        if mqs.DomPreferenceBoundSleepMinHours == 0 && mqs.DomPreferenceBoundSleepMaxHours == 0
            ;give them defaults
            mqs.DomPreferenceBoundSleepMinHours = 4
            mqs.DomPreferenceBoundSleepMaxHours = 8
        endif

        bcs.DoStartEvent()
        bcs.SetEventName(self.GetName())

        SetObjectiveDisplayed(10, true)

        EventStart()

    endif

endevent

event SafewordEvent()

    bind_Utility.WriteToConsole("bound sleep quest safeword ending")

    FixBedOwnership()

    self.Stop()

endevent

event PressedAction(bool longPress)

    bind_Utility.WriteInternalMonologue("There is nothing I can do...")

    bind_Utility.WriteToConsole("pressed action in Bound Sleep - no state")

endevent

function EventStart()

    bind_Utility.DisablePlayer()

    fs.EventGetSubReady(theSub, theDom, playAnimations = true, stripClothing = true, addGag = false, freeWrists = false, removeAll = true)

    int furnitureRoll = Utility.RandomInt(1, 100)

    if foundFurniture && (furnitureRoll <= mqs.BedtimeFurnitureForSleep)
        FurnitureForSleep()
    else
        HogtiedForSleep()
    endif

    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeSexyBondagePet())

    CloseTheDoor()

    GetDomReadyForSleep()

    SetObjectiveCompleted(10)
    SetObjectiveDisplayed(10, false)
    SetObjectiveDisplayed(20, true)

    eventEndTime = bind_Utility.AddTimeToCurrentTime(Utility.RandomInt(mqs.DomPreferenceBoundSleepMinHours, mqs.DomPreferenceBoundSleepMaxHours), 0) 
    bind_Utility.WriteToConsole("current time: " + bind_Utility.GetTime() + " event end time: " + eventEndTime)

    GoToState("WaitingState")
    RegisterForSingleUpdate(1.0)

endfunction

function CloseTheDoor()

    if TheDoor.GetReference()

        ObjectReference d = TheDoor.GetReference()

        if theDom.GetDistance(d) <= 1500.0

            bind_Utility.WriteToConsole("door: " + d)

            bind_MovementQuestScript.WalkTo(theDom, d)

            d.SetOpen(false)

        endif

    endif

endfunction

function HogtiedForSleep()

    bind_MovementQuestScript.PlayDoWork(theDom)

    bms.AddHogtieBindings(theSub, useBlindfold = false, useHood = (bms.BedtimeUseHood == 1))

    bind_Utility.DoSleep(1.0)

    bind_MovementQuestScript.StartHogtied(theSub)

endfunction

function FurnitureForSleep()

    bind_MovementQuestScript.Follow(theSub, theDom)

    bind_MovementQuestScript.WalkTo(theDom, theFurniture)

    bind_MovementQuestScript.StopFollowing()

    bind_MovementQuestScript.WalkTo(theSub, theFurniture)

    bind_MovementQuestScript.PlayDoWork(theDom)

    fms.LockInFurniture(theSub, theFurniture)

    if bms.BedtimeUseHood == 1
        bms.AddItem(theSub, bms.BONDAGE_TYPE_HOOD())
    else
        bms.AddItem(theSub, bms.BONDAGE_TYPE_GAG())
    endif

    subInFurniture = 1

endfunction

function GetDomReadyForSleep()

    ChangeBedOwnership()

    bind_MovementQuestScript.StartSleep(theDom, theBed)

endfunction

function ChangeBedOwnership()

    bedOwnership = 0

    ActorBase bedOwner = theBed.GetActorOwner()

    if bedOwner
        bedOwnership = 1
        oldBedOwner = bedOwner
    else
        Faction bedFaction = theBed.GetFactionOwner()
        if bedFaction
            bedOwnership = 2
            oldBedFaction = bedFaction
        endif
    endif

    theBed.SetActorOwner(theDom.GetActorBase())

endfunction

state WaitingState

    event OnUpdate()

        bind_Utility.WriteToConsole("event time left: " + (eventEndTime - bind_Utility.GetTime()))

        if bind_Utility.GetTime() > eventEndTime
            WakeDom()
        else
            RegisterForSingleUpdate(15.0)
        endif

    endevent

    event PressedAction(bool longPress)

        if !keyPressed
            keyPressed = true
            ShowSleepMenu()
            keyPressed = false
        endif
    
        bind_Utility.WriteToConsole("pressed action in Bound Sleep - WaitingState")
    
    endevent

endstate

function ShowSleepMenu()

    if mqs.SoftCheckGoToBed == 1
        float startTime = bind_Utility.GetTime()
        GTB_UIUtil.ShowSleepWaitMenu(true)
        bind_Utility.DoSleep(2.0)
        float sleepTime = bind_Utility.GetTime() - startTime
        bind_Utility.WriteToConsole("sleep time: " + sleepTime)
        if sleepTime > 0.01 ;one hour was .042 when testing
            UnregisterForUpdate()
            WakeDom()
        endif
    else

        UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

        int max = 10

        listMenu.AddEntryItem("I will just keep waiting...")
        int i = 1
        while i <= max
            if i == 1
                listMenu.AddEntryItem("Sleep " + i + " hour")
            else
                listMenu.AddEntryItem("Sleep " + i + " hours")
            endif
            i += 1
        endwhile
        
        listMenu.OpenMenu()
        int listReturn = listMenu.GetResultInt()
        if listReturn == 0
        elseif listReturn > 0 && listReturn <= max
            if bind_Utility.FakeSleep(listReturn)
                if !theSub.HasSpell(Rested)
                    theSub.AddSpell(Rested)
                    bind_Utility.DoSleep()
                endif
                Rested.Cast(theSub)
            endif
            UnregisterForUpdate()
            WakeDom()
        else
        endif

    endif

endfunction

function WakeDom()

    SetObjectiveCompleted(20)
    SetObjectiveDisplayed(20, false)
    SetObjectiveDisplayed(30, true)

    bind_MovementQuestScript.EndSleep()

    FixBedOwnership()

    bind_MovementQuestScript.StartSandbox(theDom, theSub)

    GotoState("DomWakeState")

    RegisterForSingleUpdate(30.0)

endfunction

function FixBedOwnership()

    if bedOwnership == 1
        theBed.SetActorOwner(oldBedOwner)
    elseif bedOwnership == 2
        theBed.SetFactionOwner(oldBedFaction)
    endif

endfunction

state DomWakeState

    event OnUpdate()
        EventEnd()
    endevent

endstate

function EventEnd()

    FreeTheSub()

endfunction

function FreeTheSub()

    SetObjectiveCompleted(30)
    SetObjectiveDisplayed(30, false)
    SetObjectiveDisplayed(40, true)

    bind_MovementQuestScript.EndSandbox()

    bind_MovementQuestScript.WalkTo(theDom, theSub)

    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeUntyingSub())

    bind_MovementQuestScript.PlayDoWork(theDom)

    if subInFurniture == 1
        fms.UnlockFromFurniture(theSub, theFurniture)
        bind_Utility.DisablePlayer()
        bind_Utility.DoSleep(1.0)
    else
        bind_MovementQuestScript.EndHogtied(theSub)
    endif

    fs.EventCleanUpSub(theSub, theDom, true)

    bind_Utility.EnablePlayer()

    SetObjectiveCompleted(40)
    SetObjectiveDisplayed(40, false)

    SetStage(20)

    bcs.DoEndEvent()

    self.Stop()

endfunction

bind_MainQuestScript property mqs auto
bind_BondageManager property bms auto
bind_Controller property bcs auto
bind_GearManager property gms auto
bind_FurnitureManager property fms auto
bind_Functions property fs auto

ReferenceAlias property NearestFurniture auto
ReferenceAlias property TheDoor auto

Spell Property Rested auto