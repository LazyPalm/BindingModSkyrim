Scriptname bind_EventPutOnDisplayQuestScript extends Quest  

float eventEndTime = 0.0

bool menuActive = false
bool keyPressed = false

bind_MainQuestScript mqs 
bind_Controller bcs
bind_BondageManager bms
bind_GearManager gms
bind_Functions fs
bind_FurnitureManager fman

Actor theSub
Actor theDom
ObjectReference furn

ObjectReference furnitureMarker

bool addFurniture = false

ObjectReference[] foundFurniture
ObjectReference[] foundMarkers
int[] usedFurniture

event OnInit()

    if self.IsRunning()

        Quest q = Quest.GetQuest("bind_MainQuest")
        mqs = q as bind_MainQuestScript
        bcs = q as bind_Controller
        bms = q as bind_BondageManager
        gms = q as bind_GearManager
        fs = q as bind_Functions
        fman = q as bind_FurnitureManager

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
        RegisterForModEvent("bind_EventCombatStartedInEvent", "CombatStartedInEvent")

        if mqs.PutOnDisplayMinMinutes == 0 && mqs.PutOnDisplayMaxMinutes == 0
            mqs.PutOnDisplayMinMinutes = 10
            mqs.PutOnDisplayMaxMinutes = 20
        endif

        menuActive = false
        keyPressed = false

        ;furn = TheFurniture.GetReference()
        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        bcs.DoStartEvent()
        bcs.SetEventName(self.GetName())

        SetObjectiveDisplayed(10, true)

        ScanForFurniture()
        if foundFurniture.Length == 0
            addFurniture = true
            addFurniture()
        endif

        MarkFurniture()

        ; if furn == none
        ;     addFurniture = true
        ; else
        ;     if furn.GetDistance(theSub) > 1000.0
        ;         addFurniture = true
        ;     endif
        ; endif

        ; if addFurniture
        ;     addFurniture()
        ; endif

        ; furnitureMarker = furn.PlaceAtMe(bind_PutOnDisplayItemsList.GetAt(0))
        ; furnitureMarker.Enable()

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

event CombatStartedInEvent(Form akTarget)
    if bind_Utility.ConfirmBox("Your party has been attacked. End this?", "I must fight", fs.GetDomTitle() + " can handle this. Leave me.")
        fs.Safeword()
    endif
endevent

state KneelByFurnitureState

    event PressedAction(bool longPress)

        if !keyPressed
            keyPressed = true

            bind_Utility.WriteToConsole("distance to furn: " + theSub.GetDistance(furn))

            if FindNearest(theSub, 200.0, false) > -1 ; theSub.GetDistance(furn) <= 200.0                
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

function ScanForFurniture()

    Keyword[] kw
    
    if mqs.SoftCheckDM3 == 1 && mqs.EnableModDM3 == 1
        kw = new Keyword[3]
        kw[0] = bind_DDHelper.GetFurnitureKeyword()
        kw[1] = bind_ZAPHelper.GetFurnitureKeyword()
        kw[2] = bind_Dm3Helper.GetFurnitureKeyword()
    else 
        kw = new Keyword[2]
        kw[0] = bind_DDHelper.GetFurnitureKeyword()
        kw[1] = bind_ZAPHelper.GetFurnitureKeyword()
    endif

    ;Debug.MessageBox(kw)

    foundFurniture = bind_SkseFunctions.GetFurniture(theSub, kw, 2000.0)

    ;debug.MessageBox(foundFurniture)

endfunction

function AddFurniture()

    ;TODO - let player add markers and add as many furniture items as player + slavecount

    ;debug.MessageBox("adding furniture...")

    float x = theDom.GetAngleX()
    float y = theDom.GetAngleY()
    float z = theDom.GetAngleZ()
    
    bind_MovementQuestScript.PlayDoWork(theDom)

    Form dev
    if mqs.SoftCheckDM3 == 1 && mqs.EnableModDM3 == 1 && Utility.RandomInt(1, 2) == 1
        dev = bind_DM3Helper.GetRandomItem()
    else
        dev = bind_DDCFurnitureList.GetAt(Utility.RandomInt(0, bind_DDCFurnitureList.GetSize() - 1))
    endif

    bind_Utility.WriteToConsole("adding furniture: " + dev.GetName())
    PO3_SKSEFunctions.AddKeywordToForm(dev, bind_FurnitureItem)
    ObjectReference obj = theDom.PlaceAtMe(dev, 1, true, true)
    obj.MoveTo(theDom, 120.0 * Math.Sin(z), 120.0 * Math.Cos(z), 0)
    obj.SetAngle(0.0, 0.0, z + 180)

    obj.Enable()
    obj.SetActorOwner(theSub.GetActorBase())
    ;furn = obj
    ;TheFurniture.ForceRefTo(obj)
    
    foundFurniture = new ObjectReference[1]
    foundFurniture[0] = obj
    
    bind_Utility.DoSleep(2.0)

endfunction

function MarkFurniture()

    foundMarkers = new ObjectReference[25]
    usedFurniture = new int[25]

    int i = 0
    while i < foundFurniture.Length
        foundMarkers[i] = foundFurniture[i].PlaceAtMe(bind_PutOnDisplayItemsList.GetAt(0))
        foundMarkers[i].Enable()
        usedFurniture[i] = 1
        i += 1
    endwhile

    ; furnitureMarker = furn.PlaceAtMe(bind_PutOnDisplayItemsList.GetAt(0))
    ; furnitureMarker.Enable()

endfunction

function DeleteMarkers()

    int i = 0
    while i < foundFurniture.Length
        foundMarkers[i].Delete()
        foundMarkers[i] = none
        i += 1
    endwhile

endfunction

int function FindNearest(ObjectReference a, float maxDistance = 200.0, bool unusedOnly = false) 
    int nearest = -1
    int i = 0
    float dist = 0.0
    while i < foundFurniture.Length
        float d = a.GetDistance(foundFurniture[i])
        bind_Utility.WriteToConsole("d: " + d + " dist: " + dist + " used: " + usedFurniture[i])
        if d <= maxDistance && (dist == 0.0 || d < dist) && (unusedOnly == false || (unusedOnly && usedFurniture[i] == 1))
            nearest = i
        endif
        i += 1
    endwhile
    return nearest
endfunction

int dm3Slot = -1
int dm3SecondSubSlot = -1
int dm3ThirdSubSlot = -1

ObjectReference furn2
ObjectReference furn3

function EventStart()

    int nearest = FindNearest(theSub, 200.0, false)
    furn = foundFurniture[nearest]
    usedFurniture[nearest] = 2 ;mark in use

    ;debug.MessageBox("usedFurniture: " + usedFurniture)

    bind_Utility.DisablePlayer()

    ; furnitureMarker.Delete()
    ; furnitureMarker = none

    DeleteMarkers()

    bind_MovementQuestScript.PlayKneel(theSub)
    ;fs.EventGetSubReady(theSub, theDom, "event_put_on_display");, true, true, true, false)

    bind_MovementQuestScript.WalkTo(theDom, theSub)
    bind_MovementQuestScript.PlayDoWork(theDom)

    ;FadeToBlackHoldImod.Apply()
    bind_Utility.FadeOutApply("I am being secured to the " + furn.GetBaseObject().GetName() + "...")

    ;fs.EventGetSubReady(theSub, theDom, "event_put_on_display")

    fs.EventGetPartyReady("event_put_on_display")

    ;bind_Utility.WriteInternalMonologue("I am being secured to the " + furn.GetBaseObject().GetName() + "...")

    ; Keyword kwDM3 = bind_DM3Helper.GetFurnitureKeyword()
    ; if furn.HasKeyword(kwDM3)
    ;     dm3Slot = bind_DM3Helper.LockInFurniture(furn, theSub)
    ; else
    ;     fman.LockInFurniture(theSub, furn, true)
    ; endif

    ;fman.LockInFurniture(theSub, furn, true)
    bind_FurnitureManager.LockInFurniture2(theSub, furn)
    StorageUtil.SetFormValue(theSub, "binding_in_furniture", furn)

    bool sub1Used = false
    bool sub2Used = false

    string doubleName = "Double Dollstand Variant 1"
    if mqs.SubCount > 0 && furn.GetBaseObject().GetName() == doubleName
        ;debug.MessageBox("max: " + bind_DM3Helper.MaxActors(furn))

        int useSub = 0
        if mqs.SubCount == 1
            if fs.TheSecondSub.GetActorReference() != none
                useSub = 1
            else 
                useSub = 2
            endif
        elseif mqs.SubCount == 2
            useSub = Utility.RandomInt(1, 2)
        endif

        if useSub == 1
            if bind_DM3Helper.FurnitureHasFreeSlots(furn)
                bind_FurnitureManager.LockInFurniture2(fs.TheSecondSub.GetActorReference(), furn)
                sub1Used = true
            endif
        elseif useSub == 2
            if bind_DM3Helper.FurnitureHasFreeSlots(furn)
                bind_FurnitureManager.LockInFurniture2(fs.TheThirdSub.GetActorReference(), furn)
                sub2Used = true
            endif
        endif

    endif

    if mqs.SubCount > 0

        if fs.TheSecondSub.GetReference() != none && !sub1Used
            nearest = FindNearest(furn, 2000.0, true)
            Actor secondSub = fs.TheSecondSub.GetActorReference()
            if nearest > -1
                furn2 = foundFurniture[nearest]
                bind_FurnitureManager.LockInFurniture2(secondSub, furn2, 2)
                usedFurniture[nearest] = 2 ;mark in use
            else 
                bind_BondageManager.HogtieActor(secondSub)
                if secondSub.IsInFaction(fman.bind_LockedInFurnitureFaction)
                    secondSub.RemoveFromFaction(fman.bind_LockedInFurnitureFaction)
                endif
            endif
        endif

        if fs.TheThirdSub.GetReference() != none && !sub2Used
            nearest = FindNearest(furn, 2000.0, true)
            Actor thirdSub = fs.TheThirdSub.GetActorReference()
            if nearest > -1
                furn2 = foundFurniture[nearest]
                bind_FurnitureManager.LockInFurniture2(thirdSub, furn2, 2)
                usedFurniture[nearest] = 2 ;mark in use
            else 
                bind_BondageManager.HogtieActor(thirdSub)
                if thirdSub.IsInFaction(fman.bind_LockedInFurnitureFaction)
                    thirdSub.RemoveFromFaction(fman.bind_LockedInFurnitureFaction)
                endif
            endif
        endif

    endif

    ;debug.MessageBox("dm3 - dm3Slot: " + dm3Slot + " dm3SecondSubSlot: " + dm3SecondSubSlot + " dm3ThirdSubSlot: " + dm3ThirdSubSlot)

    ;bind_Utility.DoSleep(2.0)

    if !theSub.IsInFaction(bind_CrowdTriggerToWatch)
        theSub.AddToFaction(bind_CrowdTriggerToWatch)
    endif

    SetObjectiveCompleted(10)
    SetObjectiveDisplayed(10, false)
    SetObjectiveDisplayed(20, true)

    eventEndTime = bind_Utility.AddTimeToCurrentTime(0, Utility.RandomInt(mqs.PutOnDisplayMinMinutes, mqs.PutOnDisplayMaxMinutes)) 

    GoToState("WaitingState")
    RegisterForSingleUpdate(1.0)

    ;FadeToBlackHoldImod.Remove()
    bind_Utility.FadeOutRemove("")

    bind_MovementQuestScript.StartSandbox(theDom, theSub)

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

    ;FadeToBlackHoldImod.Apply()

    bind_Utility.FadeOutApply("I am being released from the " + furn.GetBaseObject().GetName() + "...")

    ;fman.UnlockFromFurniture(theSub, furn, true)
    bind_FurnitureManager.UnlockFromFurniture2(theSub)

    if fs.TheSecondSub.GetReference() != none
        Actor secondSub = fs.TheSecondSub.GetActorReference()
        if secondSub.IsInFaction(fman.bind_LockedInFurnitureFaction)
            bind_FurnitureManager.UnlockFromFurniture2(secondSub)
        else
            bind_BondageManager.FreeActorFromHogtie(secondSub)
        endif
    endif 
    if fs.TheThirdSub.GetReference() != none
        Actor thirdSub = fs.TheThirdSub.GetActorReference()
        if thirdSub.IsInFaction(fman.bind_LockedInFurnitureFaction)
            bind_FurnitureManager.UnlockFromFurniture2(thirdSub)
        else
            bind_BondageManager.FreeActorFromHogtie(thirdSub)
        endif
    endif

    ;bind_Utility.DisablePlayer()

    ;bind_Utility.DoSleep(1.0)

    fs.EventClearUpParty()

    ;bind_Utility.EnablePlayer()

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

    bind_Utility.FadeOutRemove()

    if addFurniture
        if !bind_Utility.ConfirmBox("Keep this bondage furniture?")
            TheFurniture.Clear()
            Utility.Wait(1.0)
            furn.Delete()
            furn = none
        endif
    endif

    bcs.DoEndEvent()

    ;FadeToBlackHoldImod.Remove()

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



GlobalVariable property bind_GlobalEventPutOnDisplayNextRun auto

ReferenceAlias property TheFurniture auto

Faction property bind_CrowdTriggerToWatch auto

FormList property bind_PutOnDisplayItemsList auto
FormList property bind_DDCFurnitureList auto

Keyword property bind_FurnitureItem auto

ImageSpaceModifier property FadeToBlackHoldImod auto