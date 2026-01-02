Scriptname bindc_SlaveryDom extends ReferenceAlias  

event OnLocationChange(Location akOldLoc, Location akNewLoc)

    bindc_Slavery slv = (GetOwningQuest() as bindc_Slavery)

    slv.DomChangedLocations(akOldLoc, akNewLoc)

    if slv.GetDistanceToSub() <= bindc_Util.MaxCheckRange()
        int flag = slv.GetNeedOutfitChangeFlag()
        if flag == 2
            StartOutfitTimer() 
        elseif flag == 1
            GoToState("MoveDomToSubState")
            UnregisterForUpdate()
            RegisterForSingleUpdate(5.0)
        endif
    else
        debug.MessageBox("dom distance: " + slv.GetDistanceToSub())
    endif

endevent

function StartOutfitTimer()
    bindc_Util.WriteInternalMonologue("I must ask to have my bondage changed...")
    GoToState("OutfitTimerState")
    UnregisterForUpdate()
    RegisterForSingleUpdate(15.0)
endfunction

state OutfitTimerState
    event OnUpdate()
        GoToState("")
        bindc_Slavery slv = (GetOwningQuest() as bindc_Slavery)
        if slv.GetNeedOutfitChangeFlag() == 2
            slv.OutfitChangeTimerExpired()
        endif
    endevent
endstate

state MoveDomToSubState
    event OnUpdate()
        GoToState("")
        bindc_Slavery slv = (GetOwningQuest() as bindc_Slavery)
        slv.MoveDomToSub()
    endevent
endstate