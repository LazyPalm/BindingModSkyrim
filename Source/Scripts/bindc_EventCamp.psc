Scriptname bindc_EventCamp extends Quest  

Actor theSub
Actor theDom

float eventEndTime = 0.0
float taskPauseTime = 2.0

bool menuActive = false
bool keyPressed = false

ObjectReference theFurniture
ObjectReference theFirePit
ObjectReference theBedroll
ObjectReference theClearedSpot
ObjectReference theFurnitureMarker

bool foundFurnitureFlag

int minHours = 0 
int maxHours = 0

int arrivedFlag = 0

int sexThreadId = -1

; Quest puppetQuest
; bindc_Puppet1 puppet

event OnInit()

    if self.IsRunning()

        if data_script.MainScript.StartEvent(self, "Camping", true)
        
            RegisterForModEvent("AnimationEnd", "OnSexEndEvent")

            GoToState("")

            minHours = StorageUtil.GetIntValue(none, "bindc_event_camp_min", data_script.EventCampMinDefault)
            maxHours = StorageUtil.GetIntValue(none, "bindc_event_camp_max", data_script.EventCampMaxDefault)

            theSub = Game.GetPlayer()
            theDom = bindc_Util.GetDom()
            TheDomRef.ForceRefTo(theDom)

            if FoundFurniture.GetReference()
                foundFurnitureFlag = true
                theFurniture = FoundFurniture.GetReference()
            else
                foundFurnitureFlag = false
            endif

            ; puppetQuest = Quest.GetQuest("bindc_Puppet1Quest")
            ; if !puppetQuest.IsRunning()
            ;     puppetQuest.Start()
            ; endif
            ; puppet = puppetQuest as bindc_Puppet1
            
            SetObjectiveDisplayed(5, true)

            arrivedFlag = 1
            bindc_EventCampSceneMoveToPlayer.Start()
            ;NOTE - calls PrepareSub()

        else

            self.Stop()

        endif

    endif

endevent

function ActionShortPress()

    ; data_script.MainScript.EndRunningEvent()
    ; return

    bindc_Util.WriteInternalMonologue("There is nothing I can do...")
    bindc_Util.WriteInformation("pressed action in camping quest - no state")
endfunction

function ActionLongPress()
endfunction

function SafeWord()

    bindc_Util.WriteInformation("camping quest safeword ending")

    if data_script.SexLabScript.SceneRunningCheck(sexThreadId)
        data_script.SexLabScript.StopRunningScene(sexThreadId)
    endif

    if theFurniture != none && !foundFurnitureFlag
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

endfunction

; event CombatStartedInEvent(Form akTarget)
;     if bindc_Util.ConfirmBox("Your party has been attacked. End this?", "I must fight", fs.GetDomTitle() + " can handle this. Leave me.")
;         fs.Safeword()
;     endif
; endevent

function DoBedTest()

    theBedroll = AddCampsiteObject(1)

    debug.MessageBox(theBedroll.GetName())

    theBedroll.SetActorOwner(theDom.GetActorBase())

    ;puppet.MoveToBed(theDom, theBedroll)

    bindc_Util.SleepOnTarget(theDom, theBedroll)

endfunction

function PrepareSub()

    ; DoBedTest()
    ; return

    int outfitId = data_script.BondageScript.GetBondageOutfitForEvent(theSub, "event_camping")
    if outfitId == 0
        outfitId = data_script.BondageScript.GetBondageOutfitForEvent(theSub, "event_any_event")
    endif
    if outfitId > 0
    else 
        debug.MessageBox("No camping outfit was found")
        data_script.MainScript.EndRunningEvent() ;should always be the last line
        return
    endif

    bindc_Util.DisablePlayer()

    ; puppet.TheTarget.ForceRefTo(theSub)
    ; puppet.MoveActorToTarget.ForceRefTo(theDom)
    ; thedom.EvaluatePackage()

    ;puppet.MoveToTarget(theDom, theSub, true)

    ;bindc_Util.MoveToPlayer(theDom)
    
    bindc_Util.PlayTyingAnimation(theDom, theSub)

    bindc_Util.FadeOutApplyNoDisable()

    data_script.BondageScript.EquipBondageOutfit(theSub, outfitId)
    bindc_Util.DoSleep(3.0)

    bindc_Util.StopAnimations(thedom)

    bindc_Util.EnablePlayer()

    bindc_Util.FadeOutRemoveNoDisable()

    SetObjectiveCompleted(5)
    SetObjectiveDisplayed(5, false)

    bindc_EventCampSceneSetupCamp.Start()

    if foundFurnitureFlag
        SetObjectiveDisplayed(10, true)
        GoToState("MoveToFurnitureState")
    else
        SetObjectiveDisplayed(20, true)
        GoToState("PlaceFurnitureState")
    endif

endfunction

state MoveToFurnitureState

    function ActionShortPress()

        if theFurniture.GetDistance(theSub) > 200.0
            bindc_Util.WriteInternalMonologue("I need to get closer...")
        else
            SetObjectiveCompleted(10)
            SetObjectiveDisplayed(10, false)
            SetObjectiveDisplayed(30, true)
            GoToState("BuildFireState")
        endif

        bindc_Util.WriteInformation("pressed action in camping quest - MoveToFurnitureState")
    
    endfunction

endstate

state PlaceFurnitureState

    function ActionShortPress()

        GoToState("")

        ;todo - add a user drops furniture item menu mode option here?

        theFurniture = AddCampsiteObject(2)
        theFurnitureMarker = AddCampsiteObject(3)
        theFurnitureMarker.MoveTo(theFurniture)
                
        ;foundFurnitureFlag = true
        SetObjectiveCompleted(20)
        SetObjectiveDisplayed(20, false)
        SetObjectiveDisplayed(30, true)
        GoToState("BuildFireState")
    
        bindc_Util.WriteInformation("pressed action in camping quest - PlaceFurnitureState")
    
    endfunction

endstate

state BuildFireState

    function ActionShortPress()

        if theFurniture.GetDistance(theSub) > 1500.0
            bindc_Util.WriteInternalMonologue("I need to move closer to the furniture...")
        else
            GoToState("")
            theFirePit = AddCampsiteObject(0)
            SetObjectiveCompleted(30)
            SetObjectiveDisplayed(30, false)
            SetObjectiveDisplayed(40, true)
            GoToState("PlaceBedrollState")
        endif
    
        bindc_Util.WriteInformation("pressed action in camping quest - BuildFireState")
    
    endfunction

endstate

state PlaceBedrollState

    function ActionShortPress()

        if theFurniture.GetDistance(theSub) > 1500.0
            bindc_Util.WriteInternalMonologue("I need to move closer to the furniture...")
        else
            GoToState("")
            theBedroll = AddCampsiteObject(1)
            theBedroll.SetActorOwner(theDom.GetActorBase())
            SetObjectiveCompleted(40)
            SetObjectiveDisplayed(40, false)
            SetObjectiveDisplayed(50, true)
            GoToState("ClearSpotState")
        endif
    
        bindc_Util.WriteInformation("pressed action in camping quest - PlaceBedrollState")
    
    endfunction

endstate

state ClearSpotState

    function ActionShortPress()

        if theFurniture.GetDistance(theSub) > 1500.0
            bindc_Util.WriteInternalMonologue("I need to move closer to the furniture...")
        else
            GoToState("")
            theClearedSpot = AddCampsiteObject(2)
            SetObjectiveCompleted(50)
            SetObjectiveDisplayed(50, false)
            SetObjectiveDisplayed(60, true)
            GoToState("KneelAndWaitState")
        endif
    
        bindc_Util.WriteInformation("pressed action in camping quest - ClearSpotState")
    
    endfunction

endstate

state KneelAndWaitState

    function ActionShortPress()

        if theFurniture.GetDistance(theSub) > 150.0
            bindc_Util.WriteInternalMonologue("I need to kneel very close to the furniture...")
        else

            GoToState("")

            bindc_Util.DisablePlayer()

            ;TODO - since kneel under util animations?
            debug.SendAnimationEvent(theSub, StorageUtil.GetStringValue(none, "bindc_pose_kneel", "ZazAPC017"))

            SetObjectiveCompleted(60)

            CampReady()

        endif

        bindc_Util.WriteInformation("pressed action in camping quest - KneelAndWaitState")

    endfunction

endstate

function CampReady()

    theFurnitureMarker.Delete()
    bindc_Util.DoSleep(1.0)
    theFurnitureMarker = none

    GlobalMarker.GetReference().MoveTo(theClearedSpot)
    arrivedFlag = 5
    bindc_EventCampSceneMoveToGlobalMarker.Start()
    ;NOTE - calls CampReady2()

    ;bindc_Util.MoveToTarget(theDom, theClearedSpot)

    ; bindc_Util.PlaySittingAnimation(theDom, theFirePit)

    ; GoToState("LetSubStewState")

    ; RegisterForSingleUpdate(Utility.RandomFloat(15.0, 35.0))

endfunction

function CampReady2()

    bindc_Util.PlaySittingAnimation(theDom, theFirePit)

    GoToState("LetSubStewState")

    RegisterForSingleUpdate(Utility.RandomFloat(15.0, 35.0))

endfunction

state LetSubStewState

    event OnUpdate()

        bindc_Util.StopAnimations(theDom)

        arrivedFlag = 2
        bindc_EventCampSceneMoveToPlayer.Start()
        ;NOTE - calls SecureSub()

    endevent

    function ActionShortPress()

        bindc_Util.WriteInternalMonologue(bindc_Util.GetDomTitle() + " seems to be making me wait...")

        ; if td.IsAiReady()
        ;     td.UseDirectNarration(theDom, "{{ player.name }} Is grunting through their gag to get  " + thedom.GetDisplayName() + "'s attention.  " + thedom.GetDisplayName() + " is relaxing by the fire, and does want be bothered.  " + thedom.GetDisplayName() + " will tie them up for the night shortly.")
        ; endif
    
        bindc_Util.WriteInformation("pressed action in camping quest - LetSubStewState")
    
    endfunction

endstate

function SecureSub()

    ;bindc_Util.StopAnimations(theDom)

    ;bindc_Util.MoveToPlayer(theDom)

    bindc_Util.PlayTyingAnimation(theDom, theSub)

    bindc_Util.FadeOutApply()
    bindc_Util.DoSleep(2.0)

    if foundFurnitureFlag

        data_script.FurnScript.LockInFurniture(theSub, theFurniture)

    else

        Debug.SendAnimationEvent(theSub, "bind_PoleKneeling_A1_LP")
        bindc_Util.DoSleep(1.0)
        theSub.SetVehicle(theFurniture)

    endif

    bindc_Util.StopAnimations(theDom)

    bindc_Util.FadeOutRemove()

    GlobalMarker.GetReference().MoveTo(theClearedSpot)
    arrivedFlag = 6
    bindc_EventCampSceneMoveToGlobalMarker.Start()
    ;NOTE - calls SecureSub2()

    ;bindc_Util.MoveToTarget(theDom, theClearedSpot)
    
    ; bindc_Util.PlaySittingAnimation(theDom, theFirePit)

    ; GoToState("LookAtFireState")

    ; RegisterForSingleUpdate(Utility.RandomFloat(15.0, 35.0))

endfunction

function SecureSub2()
    
    bindc_Util.PlaySittingAnimation(theDom, theFirePit)

    GoToState("LookAtFireState")

    RegisterForSingleUpdate(Utility.RandomFloat(15.0, 35.0))

endfunction

bool hasMasturbated = false

state LookAtFireState

    event OnUpdate()

        int roll = Utility.RandomInt(1, 2) ;TODO - change this so this is random

        ;needs?
        ;patrol?
        ;eating?
        ;cooking?
        ;sharpen sword?

        if roll == 1 && !hasMasturbated
            DomMasturbate()
            hasMasturbated = true
        else
            PutDomToBed()
        endif

    endevent

    function ActionShortPress()

        bindc_Util.WriteInternalMonologue(bindc_Util.GetDomTitle() + " is enjoying the fire. I am not allowed to sleep yet...")
    
        ; if td.IsAiReady()
        ;     td.UseDirectNarration(theDom, "{{ player.name }} is tied to their bed on the ground and grunting through their gag to get  " + thedom.GetDisplayName() + "'s attention.  " + thedom.GetDisplayName() + " is relaxing by the fire, and does not want be bothered.")
        ; endif

        bindc_Util.WriteInformation("pressed action in camping quest - LookAtFireState")
    
    endfunction

endstate

event OnSexEndEvent(string eventName, string argString, float argNum, form sender)
endevent

function DomMasturbate()

    bindc_Util.StopAnimations(theDom)
    bindc_Util.DoSleep(1.0)

    sexThreadId = data_script.SexLabScript.StartSexScene(theDom, none)

    if sexThreadId > -1
        GoToState("DomMasturbateState")
    else
        PutDomToBed() ;sexlab start failed
    endif

endfunction

state DomMasturbateState

    function ActionShortPress()
        bindc_Util.WriteInternalMonologue(bindc_Util.GetDomTitle() + " seems having a bit of fun without me...")
    endfunction

    function ActionLongPress()
        if data_script.SexLabScript.SceneRunningCheck(sexThreadId)
            if bindc_Util.ConfirmBox("End the sex scene?")
                data_script.SexLabScript.StopRunningScene(sexThreadId)
            endif
        endif
    endfunction

    event OnSexEndEvent(string eventName, string argString, float argNum, form sender)

        ;debug.MessageBox("completed it...")

        hasMasturbated = true

        GoToState("LookAtFireState")
        GlobalMarker.GetReference().MoveTo(theClearedSpot)
        arrivedFlag = 7
        bindc_EventCampSceneMoveToGlobalMarker.Start()
        ;NOTE - calls ReturnToFire()
        
        ;ReturnToFire()

    endevent

endstate

function ReturnToFire()

    ;GoToState("LookAtFireState")

    ;bindc_Util.MoveToTarget(theDom, theClearedSpot)

    bindc_Util.PlaySittingAnimation(theDom, theFirePit)

    RegisterForSingleUpdate(Utility.RandomFloat(15.0, 35.0))

endfunction

function PutDomToBed()

    theBedroll.SetActorOwner(theDom.GetActorBase())

    bindc_Util.StopAnimations(theDom)
    bindc_Util.DoSleep()

    bindc_Util.SleepOnTarget(theDom, theBedroll)

    bindc_Util.WriteInternalMonologue(bindc_Util.GetDomTitle() + " seems to be going to bed...")

    ; if td.IsAiReady()
    ;     td.UseDirectNarration(theDom, thedom.GetDisplayName() + "is ready to sleep. Tell {{ player.name }} goodnight, and they are not to disturb " + thedom.GetDisplayName() + " while sleep.")
    ; endif

    eventEndTime = bindc_Util.AddTimeToCurrentTime(Utility.RandomInt(minHours, maxHours), 0) 
    bindc_Util.WriteInformation("current time: " + bindc_Util.GetTime() + " event end time: " + eventEndTime)

    GoToState("WaitingState")
    RegisterForSingleUpdate(1.0)

endfunction

state WaitingState

    event OnUpdate()

        bindc_Util.WriteInformation("event time left: " + (eventEndTime - bindc_Util.GetTime()))

        if bindc_Util.GetTime() > eventEndTime
            WakeDom()
        else
            RegisterForSingleUpdate(15.0)
        endif

    endevent

    function ActionShortPress()

        if !keyPressed
            keyPressed = true
            ; if !changedPos
            ;     changedPos = true
            ;     ChangeSubPosition()
            ; endif
            ShowSleepMenu()
            keyPressed = false
        endif
    
        bindc_Util.WriteInformation("pressed action in Camping - WaitingState")
    
    endfunction

endstate

function WakeDom()

    bindc_Util.StopSleepOnTarget(theDom)

    GlobalMarker.GetReference().MoveTo(theClearedSpot)
    arrivedFlag = 8
    bindc_EventCampSceneMoveToGlobalMarker.Start()
    ;NOTE - calls WakeDom2()

    ;bindc_Util.MoveToTarget(theDom, theClearedSpot)

    ; bindc_Util.PlaySittingAnimation(theDom, theFirePit)

    ; GoToState("DomWakingState")

    ; RegisterForSingleUpdate(30.0)

endfunction

function WakeDom2()

    bindc_Util.PlaySittingAnimation(theDom, theFirePit)

    GoToState("DomWakingState")

    RegisterForSingleUpdate(30.0)

endfunction

state DomWakingState

    event OnUpdate()

        bindc_Util.StopAnimations(theDom)

        arrivedFlag = 3
        bindc_EventCampSceneMoveToPlayer.Start()
        ;NOTE - calls FreeSub()

    endevent

    function ActionShortPress()

        bindc_Util.WriteInternalMonologue(bindc_Util.GetDomTitle() + " is waking. When will I be freed?")
    
        ; if td.IsAiReady()
        ;     td.UseDirectNarration(theDom, thedom.GetDisplayName() + " is enjoying the view of {{ player.name }} all tied up.")
        ; endif

        bindc_Util.WriteInformation("pressed action in camping quest - DomWakingState")
    
    endfunction

endstate

function FreeSub()

    ;bindc_Util.StopAnimations(theDom)
    ;bindc_Util.DoSleep()

    ;bindc_Util.MoveToTarget(theDom, theSub)

    bindc_Util.PlayTyingAnimation(theDom, theSub)

    bindc_Util.DoSleep(2.0)

    bindc_Util.FadeOutApply()
    bindc_Util.DoSleep(2.0)

    if foundFurnitureFlag

        data_script.FurnScript.UnlockFromFurniture(theSub)

    else

        debug.SendAnimationEvent(theSub, "IdleForceDefaultState")
        theSub.SetVehicle(none)

    endif

    bindc_Util.FadeOutRemove()

     ; if td.IsAiReady()
    ;     td.UseDirectNarration(theDom, thedom.GetDisplayName() + " orders {{ player.name }} to get the camp site packed and cleaned.")
    ; else
    ; endif

    if !foundFurnitureFlag
        ;clean up markers
        theFurniture.Delete()
    endif

    theClearedSpot.Delete()
    bindc_Util.DoSleep()

    if !foundFurnitureFlag
        ;clean up markers
        theFurniture = none
    endif
    
    theClearedSpot = none
    
    bindc_Util.EnablePlayer() ;NOTE - some dd furniture does not do this automatically??

    SetObjectiveDisplayed(60, false)
    SetObjectiveDisplayed(100, true)
    GoToState("CleanUpCampState")

    bindc_EventCampScenePackCamp.Start()

    ; if foundFurnitureFlag
    ;     SetObjectiveDisplayed(110, true)
    ;     GoToState("PackUpBedroll")
    ; else
    ;     SetObjectiveDisplayed(100, true)
    ;     GoToState("PackUpFurniture")
    ; endif

endfunction

state CleanUpCampState

    function ActionShortPress()


        bool didSomething = false

        if TryToRemoveCampItem(theSub, theBedroll)
            didSomething = true
            theBedroll = none
        endif

        if TryToRemoveCampItem(theSub, theFirePit)
            didSomething = true
            theFirePit = none
        endif

        ; if !foundFurnitureFlag
        ;     if TryToRemoveCampItem(theSub, theFurniture)
        ;         didSomething = true
        ;         theFurniture = none
        ;     endif
        ; endif
        
        if !didSomething
            bindc_Util.WriteInternalMonologue("I need to get closer to something...")
        else 

        endif

        if theBedroll == none && theFirePit == none && (theFurniture == none || foundFurnitureFlag)
            SetObjectiveCompleted(100, true)

            arrivedFlag = 4
            bindc_EventCampSceneMoveToPlayer.Start()
            ;NOTE - calls EndTheQuest()
        endif

    endfunction

endstate

function EndTheQuest()

    ;bindc_Util.MoveToPlayer(theDom)

    bindc_Util.DisablePlayer()

    bindc_Util.PlayTyingAnimation(theDom, theSub)

    bindc_Util.FadeOutApplyNoDisable()

    int lastOutfitId = StorageUtil.GetIntValue(theSub, "bindc_outfit_id", -1)
    if lastOutfitId > 0
        data_script.BondageScript.EquipBondageOutfit(theSub, lastOutfitId)
        bindc_Util.DoSleep(3.0)
    else 
        ;remove stuff??
    endif

    bindc_Util.StopAnimations(theDom) ;NOTE - slavery quest will do the outfit change when it starts

    bindc_Util.FadeOutRemoveNoDisable()

    SetObjectiveDisplayed(100, false)

    bindc_Util.ClearPackages(theDom)

    bindc_Util.EnablePlayer()

    float ct = bindc_Util.GetTime()
    StorageUtil.SetFloatValue(none, "bindc_event_camp_last", ct)

    data_script.MainScript.EndRunningEvent()

endfunction

bool function TryToRemoveCampItem(Actor s, ObjectReference item)
    bool result = false
    if item != none
        if item.GetDistance(theSub) <= 128.0
            bindc_Util.PlayWorkAnimation(theSub, 2.0)
            item.Delete()
            result = true
        endif
    endif
    return result
endfunction

function ShowSleepMenu()

    if Game.IsPluginInstalled("Gotobed.esp")
        float startTime = bindc_Util.GetTime()
        GTB_UIUtil.ShowSleepWaitMenu(true)
        bindc_Util.DoSleep(2.0)
        float sleepTime = bindc_Util.GetTime() - startTime
        bindc_Util.WriteInformation("sleep time: " + sleepTime)
        if sleepTime > 0.01 ;one hour was .042 when testing
            ;TODO - add wake dom confirm box?
            UnregisterForUpdate()
            WakeDom()
        endif
    else
        float startTime = bindc_Util.GetTime()
        bind_SkseFunctions.ShowSleepDialogue()
        bindc_Util.DoSleep(2.0)
        float sleepTime = bindc_Util.GetTime() - startTime
        bindc_Util.WriteInformation("sleep time: " + sleepTime)
        if sleepTime > 0.01 ;one hour was .042 when testing
            UnregisterForUpdate()
            WakeDom()
        endif

    endif

endfunction

ObjectReference function AddCampsiteObject(int idx)

    bindc_Util.PlayWorkAnimation(theSub, 2.0)
    ;bindc_Util.DoSleep(taskPauseTime)
    float z = theSub.GetAngleZ()
    ObjectReference obj = theSub.PlaceAtMe(bindc_CampItemsList.GetAt(idx), 1, true, true)
    obj.MoveTo(theSub, 120.0 * Math.Sin(theSub.GetAngleZ()), 120.0 * Math.Cos(theSub.GetAngleZ()), 0)
    obj.SetAngle(0.0, 0.0, z)
    obj.Enable()
    
    if idx == 1
        obj.SetActorOwner(theDom.GetActorBase())
    else 
        obj.SetActorOwner(theSub.GetActorBase())
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

    return obj

endfunction

function Arrived()

    int af = arrivedFlag
    arrivedFlag = 0 ;NOTE - need to zero this out before the functions are call since the might adjust the value

    bindc_Util.WriteModNotification("arrived " + af + "...")

    if af == 1
        PrepareSub()
    elseif af == 2
        SecureSub()
    elseif af == 3
        FreeSub()
    elseif af == 4
        EndTheQuest()
    elseif af == 5
        CampReady2()
    elseif af == 6
        SecureSub2()
    elseif af == 7
        ReturnToFire()
    elseif af == 8
        WakeDom2()

    endif

endfunction

FormList property bindc_CampItemsList auto

bindc_Data property data_script auto

Package property bindc_PackageMoveToPlayer auto

ReferenceAlias property FoundFurniture auto
ReferenceAlias property TheDomRef auto
ReferenceAlias property GlobalMarker auto

Scene property bindc_EventCampSceneSetupCamp auto
Scene property bindc_EventCampScenePackCamp auto
Scene property bindc_EventCampSceneMoveToGlobalMarker auto
Scene property bindc_EventCampSceneMoveToPlayer auto