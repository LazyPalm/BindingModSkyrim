Scriptname bind_DefeatedQuestScript extends Quest conditional  

int property DialoguePhase auto conditional

Actor theSub
Actor futureDom

bool eventRemovedClothing
bool eventAddedGag
bool fadeToBlackActive

bool tiedToPole

ObjectReference bondagePole

event OnInit()

    if self.IsRunning()

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        theSub = Game.GetPlayer()
        tiedToPole = false

        bind_Utility.WriteToConsole("defeated quest running")

        ;SetStage(0)

    endif

endEvent

function GameLoaded()
    if tiedToPole
        bind_Utility.DisablePlayer()
    endif
endfunction

event SafewordEvent()
    
    bind_Utility.WriteToConsole("defeated quest safeword reset")

    SetStage(0)

    debug.SendAnimationEvent(theSub, "IdleForceDefaultState")
    bind_Utility.DoSleep(1.0)
    theSub.SetVehicle(none)
    tiedToPole = false

    if futureDom.IsInFaction(bind_ForceGreetFaction)
        futureDom.RemoveFromFaction(bind_ForceGreetFaction)
    endif

    bind_MainQuestScript m = Quest.GetQuest("bind_MainQuest") as bind_MainQuestScript
    m.ResetDefeatedQuest = 1

    ;self.Stop()

endevent

event PressedAction(bool longPress)

    ;bind_Utility.WriteInternalMonologue("There is nothing I can do...")

    futureDom.Activate(theSub)

    bind_Utility.WriteToConsole("pressed action in defeated quest - no state")

endevent

function PlayerIsDown()

    bind_Controller con = Quest.GetQuest("bind_MainQuest") as bind_Controller
    con.DoStartEvent(true)

    if GetStage() == 0

        con.SetEventName("Defeated - First Time")
        
        SetStage(10)
        
        PickFutureDom()

        SaveThePlayer(false)

        SetObjectiveDisplayed(10, true)

    elseif GetStage() == 20

        con.SetEventName("Defeated - Second Time")

        SetObjectiveCompleted(20)
        SetObjectiveDisplayed(30, true)

        SetStage(30)

        TheFutureDom.ForceRefTo(futureDom)

        SaveThePlayer(true)
    
    endif




endfunction

function AskForSecondChance()

    SetStage(20)

    if futureDom.IsInFaction(bind_ForceGreetFaction)
        futureDom.RemoveFromFaction(bind_ForceGreetFaction)
    endif

    UntiePlayer()

    TheFutureDom.Clear() ;should walk away if not a follower

    SetObjectiveCompleted(10)
    SetObjectiveDisplayed(20, true)

    bind_Controller con = Quest.GetQuest("bind_MainQuest") as bind_Controller
    con.DoEndEvent(true)

endfunction

function AcceptEnslavement()

    if GetStage() == 30
        SetObjectiveCompleted(30)
    endif
    
    SetStage(100)

    SetObjectiveDisplayed(10, false)
    SetObjectiveDisplayed(20, false)
    SetObjectiveDisplayed(30, false)

    if futureDom.IsInFaction(bind_ForceGreetFaction)
        futureDom.RemoveFromFaction(bind_ForceGreetFaction)
    endif

    UntiePlayer()

    DialogueFollowerScript dfs = Quest.GetQuest("DialogueFollower") as DialogueFollowerScript
    dfs.SetFollower(futureDom)

    TheFutureDom.Clear() 

    fs.SetDom(futureDom)

    bind_Controller con = Quest.GetQuest("bind_MainQuest") as bind_Controller
    con.DoEndEvent(true)

    ;SetDom function will terminate this quest

endfunction

function PickFutureDom()

    Form[] futureDoms = StorageUtil.FormListToArray(theSub, "bind_future_doms")
    ;debug.MessageBox(futureDoms)
    futureDom = futureDoms[Utility.RandomInt(0, futureDoms.Length - 1)] as Actor
    TheFutureDom.ForceRefTo(futureDom)

endfunction

Form[] playerGear

function UntiePlayer()

    bind_MovementQuestScript.PlayDoWork(futureDom)
    bind_Utility.DoSleep(1.0)
    ;fms.UnlockFromFurniture(theSub, bondagePole, true)
    bind_Utility.FadeOutApply()

    debug.SendAnimationEvent(theSub, "IdleForceDefaultState")
    bind_Utility.DoSleep(1.0)
    ;theSub.SetDontMove(false)
    theSub.SetVehicle(none)
    tiedToPole = false
    ;(theSub as ObjectReference).SetMotionType(0)

    ;bind_Utility.DisablePlayer()

    if eventAddedGag
        if bms.RemoveItem(theSub, bms.BONDAGE_TYPE_GAG())
            bind_Utility.DoSleep()
        endif
    endif

    bind_MovementQuestScript.PlayDressUndress(theSub)
    ;gms.RestoreWornGear(theSub)
    ;fs.GetSubDressed()
    if eventRemovedClothing
        bind_SkseFunctions.DoDressActor(theSub, playerGear)
    endif
    bind_Utility.DoSleep(1.0)

    bind_Utility.FadeOutRemove()

    ;bind_Utility.DoSleep(1.0)
    bind_Utility.EnablePlayer()
    Game.EnablePlayerControls()

endfunction

function SaveThePlayer(bool addGag)

    ObjectReference safeLoc

    Location lastLoc = StorageUtil.GetFormValue(theSub, "bind_defeat_last_loc", none) as Location
    if lastLoc == none
        debug.MessageBox("No last location found. Using Riverwood.")
        safeLoc = bind_SafeLocationsList.GetAt(0) as ObjectReference
    else
        float lastDistance = 0.0
        int idx = 0
        bind_Utility.WriteToConsole("bind_SafeLocationsList len: " + bind_SafeLocationsList.GetSize())
        while idx < bind_SafeLocationsList.GetSize()
            ObjectReference sl = bind_SafeLocationsList.GetAt(idx) as ObjectReference
            float distance = theSub.GetDistance(sl); theSubRef.GetDistance(sl)
            if distance < lastDistance || lastDistance == 0.0
                lastDistance = distance
                safeLoc = sl
            endif
            idx += 1
        endwhile
    endif

    ;debug.MessageBox(safeLoc)

    theSub.MoveTo(safeLoc)
	Game.EnableFastTravel()
	Game.FastTravel(safeLoc)

    FadeToBlackHoldImod.Apply()

    bind_Utility.WriteInternalMonologue("Where am I? Why can't I move?")
    ;bind_Utility.WriteInternalMonologue("Why am I blindfolded?")

    Game.DisablePlayerControls() ;NOTE - this will always make the player sheate the weapon
    bind_Utility.DisablePlayer()
    bind_Utility.DoSleep()

    theSub.SheatheWeapon()
	theSub.StopCombatAlarm()
	theSub.StopCombat()
	bind_Utility.DoSleep()

    ; eventRemovedClothing = false
	; if !gms.IsNude(theSub)
	; 	if gms.RemoveWornGear(theSub)
	; 		eventRemovedClothing = true
	; 		bind_Utility.DoSleep(1.0)
	; 	endif
	; endif

    playerGear = bind_SkseFunctions.DoStripActor(theSub, false)
    bind_Utility.DoSleep(1.0)
    eventRemovedClothing = true

    Debug.SendAnimationEvent(theSub, "bind_PoleKneeling_A1_LP")
    bind_Utility.DoSleep(1.0)
    ;theSub.SetDontMove(true)
    theSub.SetVehicle(safeLoc)
    tiedToPole = true
    ;(theSub as ObjectReference).SetMotionType(4)

    ;Game.EnablePlayerControls()

    ; bondagePole = StorageUtil.GetFormValue(safeLoc, "bind_safe_loc_furniture", none) as ObjectReference
    ; if bondagePole
    ;     ;furniture in this location
    ; else
    ;     float z = theSub.GetAngleZ()
    ;     bondagePole = theSub.PlaceAtMe(zadc_BondagePole, 1, true, true)
    ;     bondagePole.SetAngle(0.0, 0.0, z)
    ;     bondagePole.Enable()
    ;     bondagePole.SetActorOwner(theSub.GetActorBase())
    ;     StorageUtil.SetFormValue(safeLoc, "bind_safe_loc_furniture", bondagePole)
    ; endif

    ; fms.LockInFurniture(theSub, bondagePole, true)



    eventAddedGag = false
    if addGag
        eventAddedGag = true
        if bms.AddItem(theSub, bms.BONDAGE_TYPE_GAG())
            bind_Utility.DoSleep()
        endif
    endif

    ; bms.AddHogtieBindings(theSub, useBlindfold = false, useHood = false)
    ; bind_Utility.DoSleep(1.0)
    ; bind_MovementQuestScript.StartHogtied(theSub)

    futureDom.MoveTo(theSub)
    futureDom.SetPosition(futureDom.GetPositionX() + Utility.RandomFloat(-128.0, 128.0), futureDom.GetPositionY() + Utility.RandomFloat(-128.0, 128.0), futureDom.GetPositionZ() + 100.0) ;adding z in case elevation changes
    ;futureDom.MoveTo(theSub)

    float zOffset = futureDom.GetHeadingAngle(theSub)
    futureDom.SetAngle(futureDom.GetAngleX(), futureDom.GetAngleY(), futureDom.GetAngleZ() + zOffset)

    bind_Utility.DoSleep(3.0)

    FadeToBlackHoldImod.Remove()

    bind_Utility.DoSleep(1.0)

    if !futureDom.IsInFaction(bind_ForceGreetFaction)
        futureDom.AddToFaction(bind_ForceGreetFaction)
    endif

    ;debug.MessageBox(playerGear)

    ;TODO:
    ;
    ;See if this works with direct naration
    ;"You have defeated {{ player.name }} in battle, who is now tied kneeling at your feet. Talk to them about their fate. When the conversation is over you will untie and free them or enslave them based on their answers and your mood."

endfunction

FormList property bind_SafeLocationsList auto

ReferenceAlias property TheFutureDom auto

bind_BondageManager property bms auto
bind_GearManager property gms auto
bind_FurnitureManager property fms auto
bind_MainQuestScript property mqs auto
bind_Functions property fs auto

Activator property zadc_RestraintPost auto
Activator property zadc_BondagePole auto

Faction property bind_ForceGreetFaction auto

ImageSpaceModifier property FadeToBlackHoldImod auto
