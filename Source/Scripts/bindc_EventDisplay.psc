Scriptname bindc_EventDisplay extends Quest  

Actor theSub
Actor theDom

int minMinutes = 0
int maxMinutes = 0

int foundFurnitureCount = 0

ObjectReference[] nearby
ObjectReference kneelingBy

float kneelingByDistance = 0.0
float eventEndTime = 0.0

bool buttonPressed = false

ObjectReference[] markers

event OnInit()

    if self.IsRunning()

        if data_script.MainScript.StartEvent(self, "Display", true)

            markers = new ObjectReference[5]
        
            RegisterForModEvent("AnimationEnd", "OnSexEndEvent")
            RegisterForModEvent("bindc_SleepWaitMenuClosed", "SleepWaitMenuClosed")

            GoToState("")

            minMinutes = StorageUtil.GetIntValue(none, "bindc_event_display_min", data_script.EventDisplayMinDefault)
            maxMinutes = StorageUtil.GetIntValue(none, "bindc_event_display_max", data_script.EventDisplayMaxDefault)

            theSub = Game.GetPlayer()
            theDom = bindc_Util.GetDom()
            TheDomRef.ForceRefTo(theDom)
            
            SetObjectiveDisplayed(5, true)

            PrepareSub()

        else

            self.Stop()

        endif

    endif

endevent

function ActionShortPress()
endfunction

function ActionLongPress()
endfunction

function SafeWord()

    ;do in furniture test - add to bindc_furn
    ;release if in?? - might be better to do this globally in safeword

    DeleteFurnitureMarkers()

    bindc_Util.WriteInformation("display quest safeword ending")

endfunction

event OnSexEndEvent(string eventName, string argString, float argNum, form sender)
endevent

event SleepWaitMenuClosed()
endevent

function ActionMenu()
endfunction

function PrepareSub()

    int outfitId = data_script.BondageScript.GetBondageOutfitForEvent(theSub, "event_put_on_display")
    if outfitId == 0
        outfitId = data_script.BondageScript.GetBondageOutfitForEvent(theSub, "event_any_event")
    endif
    if outfitId > 0
    else 
        debug.MessageBox("No put on display outfit was found")
        data_script.MainScript.EndRunningEvent() ;should always be the last line
        return
    endif

    bindc_Util.DisablePlayer()

    bindc_Util.MoveToPlayer(theDom)
    
    bindc_Util.PlayTyingAnimation(theDom, theSub)

    bindc_Util.FadeOutApplyNoDisable()

    data_script.BondageScript.EquipBondageOutfit(theSub, outfitId)
    bindc_Util.DoSleep(3.0)

    bindc_Util.StopAnimations(thedom)

    bindc_Util.EnablePlayer()

    bindc_Util.FadeOutRemoveNoDisable()

    bindc_Util.DoSleep(2.0)

    SetObjectiveCompleted(5)
    SetObjectiveDisplayed(5, false)

    if DetectFurniture()
        bindc_EventDisplaySceneKneelBy.Start()
        SetObjectiveDisplayed(20, true)
        GoToState("KneelByFurnitureState")
    else
        bindc_EventDisplaySceneAddFurniture.Start()
        SetObjectiveDisplayed(10, true)
        GoToState("AddFurnitureState")
    endif

endfunction

state AddFurnitureState

    function ActionMenu()
        UIListMenu furnMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

        furnMenu.AddEntryItem("Open Furniture Menu")
        if data_script.FurnScript.IsFurnitureNearActor(theSub, 3000.0)
            furnMenu.AddEntryItem("Tell " + bindc_Util.GetDomTitle() + " the task is done")
        endif

        furnMenu.OpenMenu()
        int furnResult = furnMenu.GetResultInt()

        if furnResult == 0
            data_script.FurnScript.FurnitureMenu()
        elseif furnResult == 1
            if DetectFurniture()
                SetObjectiveCompleted(10)
                SetObjectiveDisplayed(10, false)
                SetObjectiveDisplayed(20, true)
                GoToState("KneelByFurnitureState")
            else
                bindc_Util.WriteInternalMonologue("I still need to place furniture...")
            endif
        endif
    endfunction

    function ActionShortPress()

        if !buttonPressed
            buttonPressed = true
            ActionMenu()
            buttonPressed = false 
        endif

    endfunction

endstate

state KneelByFurnitureState

    function ActionShortPress()

        if !buttonPressed
            buttonPressed = true
            if !FurnitureDistanceCheck()
                bindc_Util.WriteInternalMonologue("I need to kneel closer to the furniture...")
            else
                SecureSub()
            endif
            buttonPressed = false
        endif

    endfunction

endstate

function SecureSub()

    GoToState("")
    
    bindc_Util.DisablePlayer()
    
    debug.SendAnimationEvent(theSub, StorageUtil.GetStringValue(none, "bindc_pose_kneel", "ZazAPC017"))
    
    bindc_Util.MoveToPlayer(theDom)

    bindc_Util.PlayTyingAnimation(theDom, theSub)

    bindc_Util.FadeOutApply()
    bindc_Util.DoSleep(2.0)

    data_script.FurnScript.LockInFurniture(theSub, kneelingBy)

    bindc_Util.StopAnimations(theDom)

    bindc_Util.FadeOutRemove()

    SetObjectiveCompleted(20)
    SetObjectiveDisplayed(20, false)
    SetObjectiveDisplayed(30, true)

    ;sandbox dom or clear ref and let NFF do it??

    eventEndTime = bindc_Util.AddTimeToCurrentTime(0, Utility.RandomInt(minMinutes, maxMinutes)) 

    DeleteFurnitureMarkers()

    bindc_EventDisplaySceneWait.Start()

    GoToState("WaitingState")
    RegisterForSingleUpdate(1.0)

endfunction

state WaitingState

    event OnUpdate()

        float ct = bindc_Util.GetTime()

        bindc_Util.WriteInformation("event time left: " + (eventEndTime - ct))

        if ct > eventEndTime
            EndDisplayEvent()
        else
            RegisterForSingleUpdate(15.0)
        endif

    endevent

    function ActionShortPress()
    endfunction

    event SleepWaitMenuClosed()
        UnregisterForUpdate() ;advance the loop once sleep is done
        RegisterForSingleUpdate(1.0)
    endevent

endstate

function EndDisplayEvent()

    GoToState("")
    SetObjectiveCompleted(30)
    SetObjectiveDisplayed(30, false)
    SetObjectiveDisplayed(40, true)

    bindc_Util.MoveToPlayer(theDom)

    bindc_EventDisplaySceneRelease.Start()

    bindc_Util.PlayTyingAnimation(theDom, theSub)

    bindc_Util.FadeOutApply()
    bindc_Util.DoSleep(2.0)

    data_script.FurnScript.UnlockFromFurniture(theSub)

    bindc_Util.StopAnimations(theDom)

    bindc_Util.FadeOutRemove()

    bindc_Util.ClearPackages(theDom)

    bindc_Util.EnablePlayer()

    float ct = bindc_Util.GetTime()
    StorageUtil.SetFloatValue(none, "bindc_event_display_last", ct)

    SetObjectiveCompleted(40)
    SetObjectiveDisplayed(40, false)

    data_script.MainScript.EndRunningEvent()

endfunction

bool function FurnitureDistanceCheck()
    bool isClose = false
    int i = 0
    while i < nearby.Length
        ObjectReference furn = nearby[i]
        float d = furn.GetDistance(theSub) 
        if kneelingBy == none
            kneelingBy = furn
            kneelingByDistance = d
        else
            if d < kneelingByDistance
                kneelingBy = furn
                kneelingByDistance = d
            endif
        endif
        if d < 128.0
            isClose = true
        endif
        i += 1
    endwhile
    return isClose
endfunction

bool function DetectFurniture()
    bool result = false

    ;NOTE - need to use this method because DSE is is a soft requirement and can't fill the aliases by keywordstring
    ;and if adding furniture, will need to fill aliases in that method in the same way

    nearby = data_script.FurnScript.FindFurnitureNearActor(theSub, 3000.0)

    ;debug.MessageBox(nearby)

    int i = 0
    while i < nearby.Length
        ObjectReference furn = nearby[i]
        if i == 0
            Furniture1Ref.ForceRefTo(furn)
            ShowFurnitureMarker(0, furn)
        elseif i == 1
            Furniture2Ref.ForceRefTo(furn)
            ShowFurnitureMarker(1, furn)
        elseif i == 2
            Furniture3Ref.ForceRefTo(furn)
            ShowFurnitureMarker(2, furn)
        elseif i == 3
            Furniture4Ref.ForceRefTo(furn)
            ShowFurnitureMarker(3, furn)
        elseif i == 4
            Furniture5Ref.ForceRefTo(furn)
            ShowFurnitureMarker(4, furn)
        endif
        result = true
        i += 1
    endwhile

    return result
endfunction

function ShowFurnitureMarker(int idx, ObjectReference furn)
    if markers[idx] == none
        markers[idx] = furn.PlaceAtMe(bindc_SpellEffectsList.GetAt(1), 1)
    else 
        markers[idx].MoveTo(furn)
    endif
    markers[idx].Enable()
endfunction

function HideFurnitureMarkers()
    int i = 0
    while i < markers.Length
        if markers[i] != none
            markers[i].Disable()
        endif
        i += 1
    endwhile
endfunction

function DeleteFurnitureMarkers()
    int i = 0
    while i < markers.Length
        if markers[i] != none
            markers[i].Delete()
            ;bindc_Util.DoSleep()
            ;markers[i] = none
        endif
        i += 1
    endwhile
endfunction

bindc_Data property data_script auto

ReferenceAlias property TheDomRef auto

ReferenceAlias property Furniture1Ref auto
ReferenceAlias property Furniture2Ref auto
ReferenceAlias property Furniture3Ref auto
ReferenceAlias property Furniture4Ref auto
ReferenceAlias property Furniture5Ref auto

FormList property bindc_SpellEffectsList auto

Scene property bindc_EventDisplaySceneAddFurniture auto
Scene property bindc_EventDisplaySceneKneelBy auto
Scene property bindc_EventDisplaySceneRelease auto
Scene property bindc_EventDisplaySceneWait auto