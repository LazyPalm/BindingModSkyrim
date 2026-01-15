Scriptname bindc_EventQuest extends Quest conditional

Actor dom
Actor sub

ObjectReference globalMarker
Package pMoveToPlayer
Package pMoveToGlobal

bindc_Bondage bm

Actor function GetSub()
    if sub == none
        sub = Game.GetPlayer()
    endif
    return sub
    Weather w = Weather.GetCurrentWeather()
endfunction

Actor function GetDom()
    if dom == none
        dom = StorageUtil.GetFormValue(none, "bindc_dom") as Actor
    endif
    return dom
endfunction

string function GetDomTitle()
    return StorageUtil.GetStringValue(none, "bindc_dom_title")
endfunction

function MoveToObject(Actor akActor, ObjectReference destination, float distance = 200.0)

    if globalMarker == none
        globalMarker = Game.GetFormFromFile(0x00AB1D, "binding.esm") as ObjectReference
    endif

    if pMoveToGlobal == none
        pMoveToGlobal = Game.GetFormFromFile(0x00AB1E, "binding.esm") as Package
    endif

    ;debug.MessageBox(globalMarker)
    ;debug.MessageBox(pMoveToGlobal)

    globalMarker.MoveTo(destination)
    bindc_Util.DoSleep()

    ActorUtil.AddPackageOverride(akActor, pMoveToGlobal, 90)
    akActor.EvaluatePackage()

    WaitForArrival(akActor, destination, distance)

    ActorUtil.RemovePackageOverride(akActor, pMoveToGlobal)
    akActor.EvaluatePackage()

    ;debug.MessageBox("this finished...")

endfunction

function MoveToPlayer(Actor akActor, float distance = 200.0)

    if pMoveToPlayer == none
        pMoveToPlayer = Game.GetFormFromFile(0x000896, "binding.esm") as Package
    endif

    ;debug.MessageBox(pMoveToPlayer)

    if sub == none
        sub = Game.GetPlayer()
    endif

    ActorUtil.AddPackageOverride(akActor, pMoveToPlayer, 90)
    akActor.EvaluatePackage()

    WaitForArrival(akActor, sub, distance)

    ActorUtil.RemovePackageOverride(akActor, pMoveToPlayer)
    akActor.EvaluatePackage()

    ;debug.MessageBox("this finished...")

endfunction

function WaitForArrival(Actor akActor, ObjectReference destination, float distance)

    ;TODO - add a check in the loop to see if NPC is stuck

    int counter = 0
    while counter < 60 && akActor.GetDistance(destination) > distance && StorageUtil.GetIntValue(none, "bindc_safeword_running", 0) == 0
        bindc_Util.DoSleep(0.5)
        bindc_Util.WriteInformation("counter: " + counter)
        counter += 1
    endwhile

    if (akActor.GetDistance(destination) > (distance * 1.5)) && StorageUtil.GetIntValue(none, "bindc_safeword_running", 0) == 0 ;teleport if they didn't make it
        akActor.MoveTo(destination)
    endif

endfunction

bool function PrepareSub(Actor theSub, Actor theDom, string eventSystemName)

    if bm == none
        Quest q = Quest.GetQuest("bindc_MainQuest")
        bm = q as bindc_Bondage
    endif

    int outfitId = bm.GetBondageOutfitForEvent(theSub, eventSystemName)
    if outfitId == 0
        outfitId = bm.GetBondageOutfitForEvent(theSub, "event_any_event")
    endif
    if outfitId > 0
    else 
        return false
    endif

    bindc_Util.DisablePlayer()

    bindc_Util.PlayTyingAnimation(theDom, theSub)

    bindc_Util.FadeOutApplyNoDisable()

    bm.EquipBondageOutfit(theSub, outfitId)

    bindc_Util.DoSleep(2.0)

    bindc_Util.StopAnimations(thedom)

    bindc_Util.EnablePlayer()

    bindc_Util.FadeOutRemoveNoDisable()

    return true

endfunction
