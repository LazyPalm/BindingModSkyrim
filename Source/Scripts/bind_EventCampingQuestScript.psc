Scriptname bind_EventCampingQuestScript extends Quest  

float eventEndTime = 0.0
float taskPauseTime = 2.0

bool menuActive = false
bool keyPressed = false

Actor theSub
Actor theDom

ObjectReference theFurniture
ObjectReference theFirePit
ObjectReference theBedroll
ObjectReference theClearedSpot

bool foundFurnitureFlag
bool subInFurnitureFlag

event OnInit()

    if self.IsRunning()

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        menuActive = false
        keyPressed = false

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        if mqs.CampingEventMinHours == 0 && mqs.CampingEventMaxHours == 0
            mqs.CampingEventMinHours = 4
            mqs.CampingEventMaxHours = 8
        endif

        ;debug.MessageBox("CampingEventMinHours: " + mqs.CampingEventMinHours + " CampingEventMaxHours: " + mqs.CampingEventMaxHours)

        if FoundFurniture.GetReference()
            foundFurnitureFlag = true
            theFurniture = FoundFurniture.GetReference()
        else
            foundFurnitureFlag = false
        endif
        
        ; if mqs.DomPreferenceBoundSleepMinHours == 0 && mqs.DomPreferenceBoundSleepMaxHours == 0
        ;     ;give them defaults
        ;     mqs.DomPreferenceBoundSleepMinHours = 4
        ;     mqs.DomPreferenceBoundSleepMaxHours = 8
        ; endif

        bcs.DoStartEvent()
        bcs.SetEventName(self.GetName())

        PrepareSub()

    endif

endevent

event SafewordEvent()
    
    bind_Utility.WriteToConsole("camping quest safeword ending")

    if theFurniture != none
        theFurniture.Delete()
        theFurniture = none
    endif

    if theFirePit != none
        theFirePit.Delete()
        theFirePit = none
    endif

    if theBedroll != none
        theBedroll.Delete()
        theBedroll = none
    endif

    if theClearedSpot != none
        theClearedSpot.Delete()
        theClearedSpot = none
    endif

    bind_Utility.DoSleep(2.0)

    self.Stop()

endevent

event PressedAction(bool longPress)

    bind_Utility.WriteInternalMonologue("There is nothing I can do...")

    bind_Utility.WriteToConsole("pressed action in camping quest - no state")

endevent

function PrepareSub()

    bind_Utility.DisablePlayer()

    fs.EventGetSubReady(theSub, theDom, playAnimations = true, stripClothing = true, addGag = true, freeWrists = true, removeAll = false)

    bind_Utility.DoSleep(2.0)

    bind_Utility.EnablePlayer()

    if foundFurnitureFlag
        SetObjectiveDisplayed(10, true)
        GoToState("MoveToFurnitureState")
    else
        SetObjectiveDisplayed(20, true)
        GoToState("PlaceFurnitureState")
    endif

endfunction

state MoveToFurnitureState

    event PressedAction(bool longPress)

        if theFurniture.GetDistance(theSub) > 200.0
            bind_Utility.WriteInternalMonologue("I need to get closer...")
        else
            SetObjectiveCompleted(10)
            SetObjectiveDisplayed(10, false)
            SetObjectiveDisplayed(30, true)
            GoToState("BuildFireState")
        endif

        bind_Utility.WriteToConsole("pressed action in camping quest - MoveToFurnitureState")
    
    endevent

endstate

; function DomSaysMakeCampHere()

;     bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.Commenty)

; endfunction

state PlaceFurnitureState

    event PressedAction(bool longPress)

        GoToState("")
        AddCampsiteObject(0)
        SetObjectiveCompleted(20)
        SetObjectiveDisplayed(20, false)
        SetObjectiveDisplayed(30, true)
        GoToState("BuildFireState")
    
        bind_Utility.WriteToConsole("pressed action in camping quest - PlaceFurnitureState")
    
    endevent

endstate

state BuildFireState

    event PressedAction(bool longPress)

        if theFurniture.GetDistance(theSub) > 1500.0
            bind_Utility.WriteInternalMonologue("I need to move closer to the furniture...")
        else
            GoToState("")
            AddCampsiteObject(1)
            SetObjectiveCompleted(30)
            SetObjectiveDisplayed(30, false)
            SetObjectiveDisplayed(40, true)
            GoToState("PlaceBedrollState")
        endif
    
        bind_Utility.WriteToConsole("pressed action in camping quest - BuildFireState")
    
    endevent

endstate

state PlaceBedrollState

    event PressedAction(bool longPress)

        if theFurniture.GetDistance(theSub) > 1500.0
            bind_Utility.WriteInternalMonologue("I need to move closer to the furniture...")
        else
            GoToState("")
            AddCampsiteObject(2)
            SetObjectiveCompleted(40)
            SetObjectiveDisplayed(40, false)
            SetObjectiveDisplayed(50, true)
            GoToState("ClearSpotState")
        endif
    
        bind_Utility.WriteToConsole("pressed action in camping quest - PlaceBedrollState")
    
    endevent

endstate

state ClearSpotState

    event PressedAction(bool longPress)

        if theFurniture.GetDistance(theSub) > 1500.0
            bind_Utility.WriteInternalMonologue("I need to move closer to the furniture...")
        else
            GoToState("")
            AddCampsiteObject(3)
            SetObjectiveCompleted(50)
            SetObjectiveDisplayed(50, false)
            SetObjectiveDisplayed(60, true)
            GoToState("KneelAndWaitState")
        endif
    
        bind_Utility.WriteToConsole("pressed action in camping quest - ClearSpotState")
    
    endevent

endstate

state KneelAndWaitState

    event PressedAction(bool longPress)

        if theFurniture.GetDistance(theSub) > 150.0
            bind_Utility.WriteInternalMonologue("I need to kneel very close to the furniture...")
        else

            GoToState("")

            bind_Utility.DisablePlayer()

            bind_MovementQuestScript.PlayKneel(theSub)

            SetObjectiveCompleted(60)

            CampReady()

        endif

        bind_Utility.WriteToConsole("pressed action in camping quest - KneelAndWaitState")

    endevent

endstate

function CampReady()

    bind_MovementQuestScript.WalkTo(theDom, theClearedSpot)

    bind_MovementQuestScript.FaceTarget(theDom, theFirePit)

    bind_MovementQuestScript.PlaySitOnGround(theDom)

    GoToState("LetSubStewState")

    RegisterForSingleUpdate(30.0)

endfunction

state LetSubStewState

    event OnUpdate()

        SecureSub()

    endevent

    event PressedAction(bool longPress)

        bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " seems to be making me wait...")

        if td.IsAiReady()
            td.MakeAiComment(theDom, "{ player.name } Is grunting through their gag to get your attention. You are relaxing by the fire, and don't want be bothered until you are ready to tie them up.")
        endif
    
        bind_Utility.WriteToConsole("pressed action in camping quest - LetSubStewState")
    
    endevent

endstate

function SecureSub()

    bind_MovementQuestScript.PlayReset(theDom)

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    bind_MovementQuestScript.WalkTo(theDom, theFurniture)

    bind_MovementQuestScript.PlayDoWork(theDom)
    bind_Utility.DoSleep(2.0)

    fms.LockInFurniture(theSub, theFurniture)

    bind_MovementQuestScript.WalkTo(theDom, theClearedSpot)

    bind_MovementQuestScript.FaceTarget(theDom, theFirePit)

    bind_MovementQuestScript.PlaySitOnGround(theDom)

    GoToState("LookAtFireState")

    RegisterForSingleUpdate(30.0)

endfunction

state LookAtFireState

    event OnUpdate()

        PutDomToBed()

    endevent

    event PressedAction(bool longPress)

        bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is enjoying the fire. I am not allowed to sleep yet...")
    
        if td.IsAiReady()
            td.MakeAiComment(theDom, "{ player.name } is tied to their bed on the ground and grunting through their gag to get your attention. You are relaxing by the fire, and don't want be bothered.")
        endif

        bind_Utility.WriteToConsole("pressed action in camping quest - LookAtFireState")
    
    endevent

endstate

function PutDomToBed()

    bind_MovementQuestScript.PlayReset(theDom)
    bind_Utility.DoSleep()

    if td.IsAiReady()
        td.MakeAiComment(theDom, "You are ready to sleep. Tell { player.name }, your submissive goodnight, and they are not to disturb you while you sleep.")
    endif

    bind_MovementQuestScript.StartSleep(theDom, theBedroll)

    eventEndTime = bind_Utility.AddTimeToCurrentTime(Utility.RandomInt(mqs.CampingEventMinHours, mqs.CampingEventMaxHours), 0) 
    bind_Utility.WriteToConsole("current time: " + bind_Utility.GetTime() + " event end time: " + eventEndTime)

    GoToState("WaitingState")
    RegisterForSingleUpdate(1.0)

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
    
        bind_Utility.WriteToConsole("pressed action in Camping - WaitingState")
    
    endevent

endstate

function WakeDom()

    bind_MovementQuestScript.EndSleep()

    bind_MovementQuestScript.WalkTo(theDom, theClearedSpot)

    bind_MovementQuestScript.FaceTarget(theDom, theFirePit)

    bind_MovementQuestScript.PlaySitOnGround(theDom)

    GoToState("DomWakingState")

    RegisterForSingleUpdate(30.0)

endfunction

state DomWakingState

    event OnUpdate()

        FreeSub()

    endevent

    event PressedAction(bool longPress)

        bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is waking. When we I be freed?")
    
        if td.IsAiReady()
            td.MakeAiComment(theDom, "Tell { player.name } that you are enjoying the view of them all tied up.")
        endif

        bind_Utility.WriteToConsole("pressed action in camping quest - DomWakingState")
    
    endevent

endstate

function FreeSub()

    bind_MovementQuestScript.PlayReset(theDom)

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    bind_MovementQuestScript.WalkTo(theDom, theFurniture)

    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeUntyingSub())

    bind_MovementQuestScript.PlayDoWork(theDom)
    bind_Utility.DoSleep(2.0)

    fms.UnlockFromFurniture(theSub, theFurniture)

    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypePackUpCamp())

    theClearedSpot.Delete()
    bind_Utility.DoSleep()
    theClearedSpot = none

    bind_Utility.EnablePlayer() ;NOTE - some dd furniture does not do this automatically??

    SetObjectiveDisplayed(60, false)
    SetObjectiveDisplayed(100, true)
    GoToState("CleanUpCampState")

    ; if foundFurnitureFlag
    ;     SetObjectiveDisplayed(110, true)
    ;     GoToState("PackUpBedroll")
    ; else
    ;     SetObjectiveDisplayed(100, true)
    ;     GoToState("PackUpFurniture")
    ; endif

endfunction

state CleanUpCampState

    event PressedAction(bool longPress)


        bool didSomething = false

        if TryToRemoveCampItem(theSub, theBedroll)
            didSomething = true
            theBedroll = none
        endif

        if TryToRemoveCampItem(theSub, theFirePit)
            didSomething = true
            theFirePit = none
        endif

        if !foundFurnitureFlag
            if TryToRemoveCampItem(theSub, theFurniture)
                didSomething = true
                theFurniture = none
            endif
        endif
        
        if !didSomething
            bind_Utility.WriteInternalMonologue("I need to get closer to something...")
        else 
            bind_MovementQuestScript.PlayReset(theSub)
        endif

        if theBedroll == none && theFirePit == none && (theFurniture == none || foundFurnitureFlag)
            SetObjectiveCompleted(100, true)
            EndTheQuest()
        endif

    endevent

endstate

function EndTheQuest()

    bind_Utility.DisablePlayer()

    bind_MovementQuestScript.WalkTo(theDom, theSub)

    fs.EventCleanUpSub(theSub, theDom, true)

    bind_Utility.EnablePlayer()

    bcs.DoEndEvent()

    SetObjectiveDisplayed(100, false)

    SetStage(20)

    self.Stop()

endfunction

bool function TryToRemoveCampItem(Actor s, ObjectReference item)
    bool result = false
    if item != none
        if item.GetDistance(theSub) <= 128.0
            bind_MovementQuestScript.PlayDoWork(theSub, 2.0)
            item.Delete()
            result = true
        endif
    endif
    return result
endfunction

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

function AddCampsiteObject(int idx)

    bind_MovementQuestScript.PlayDoWork(theSub)
    bind_Utility.DoSleep(taskPauseTime)
    float z = theSub.GetAngleZ()
    ObjectReference obj = theSub.PlaceAtMe(bind_CampsiteList.GetAt(idx), 1, true, true)
    obj.MoveTo(theSub, 120.0 * Math.Sin(theSub.GetAngleZ()), 120.0 * Math.Cos(theSub.GetAngleZ()), 0)
    obj.SetAngle(0.0, 0.0, z)
    obj.Enable()
    obj.SetActorOwner(theSub.GetActorBase())

    if idx == 2
        obj.SetActorOwner(theDom.GetActorBase())
    endif

    if obj.HasKeywordString("zadc_FurnitureDevice")
        (obj as zadcFurnitureScript).SendDeviceModEvents = true
        (obj as zadcFurnitureScript).ScriptedDevice = true
    endif

    if obj.HasKeywordString("zbfFurniture")
        float x = obj.GetPositionX()
        float y = obj.GetPositionY()
        z = obj.GetPositionZ() - 25.0
        obj.SetPosition(x, y, z)
    endif

    if idx == 0
        theFurniture = obj
    elseif idx == 1
        theFirePit = obj
    elseif idx == 2
        theBedroll = obj
    elseif idx == 3
        theClearedSpot = obj
    endif

endfunction


ReferenceAlias property FoundFurniture auto

bind_MainQuestScript property mqs auto
bind_BondageManager property bms auto
bind_Controller property bcs auto
bind_GearManager property gms auto
bind_FurnitureManager property fms auto
bind_Functions property fs auto
bind_ThinkingDom property td auto

Spell Property Rested auto

FormList property bind_CampsiteList auto