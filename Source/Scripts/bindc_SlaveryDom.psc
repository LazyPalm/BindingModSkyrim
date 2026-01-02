Scriptname bindc_SlaveryDom extends ReferenceAlias  

event OnLocationChange(Location akOldLoc, Location akNewLoc)

    bindc_Slavery slv = (GetOwningQuest() as bindc_Slavery)

    slv.DomChangedLocations(akOldLoc, akNewLoc)

    ;if slv.GetDistanceToSub() <= bindc_Util.MaxCheckRange()
        int flag = slv.GetNeedOutfitChangeFlag()
        if flag == 2
            StartOutfitTimer1() 
        elseif flag == 1
            StartDomChangeOutfit()
        endif
    ;else
    ;    debug.MessageBox("dom distance: " + slv.GetDistanceToSub())
    ;endif

endevent

function StartDomChangeOutfit()
    GoToState("MoveDomToSubState")
    UnregisterForUpdate()
    RegisterForSingleUpdate(5.0)
endfunction

function StartOutfitTimer1()
    GoToState("OutfitTimer1State")
    UnregisterForUpdate()
    RegisterForSingleUpdate(5.0)
endfunction

state OutfitTimer1State
    event OnUpdate()
        GoToState("")
        bindc_Slavery slv = (GetOwningQuest() as bindc_Slavery)
        if slv.GetDistanceToSub() <= bindc_Util.MaxCheckRange()
            bindc_Util.WriteInternalMonologue("I must ask to have my bondage changed...")
            GoToState("OutfitTimer2State")
            UnregisterForUpdate()
            RegisterForSingleUpdate(15.0)
        endif
    endevent
endstate

state OutfitTimer2State
    event OnUpdate()
        GoToState("")
        bindc_Slavery slv = (GetOwningQuest() as bindc_Slavery)
        if slv.GetNeedOutfitChangeFlag() == 2 && slv.GetDistanceToSub() <= bindc_Util.MaxCheckRange()
            slv.OutfitChangeTimerExpired()
        endif
    endevent
endstate

state MoveDomToSubState
    event OnUpdate()
        GoToState("")
        bindc_Util.WriteInternalMonologue(bindc_Util.GetDomTitle() + " is going to change my bondage...")
        bindc_Slavery slv = (GetOwningQuest() as bindc_Slavery)
        if slv.GetDistanceToSub() <= bindc_Util.MaxCheckRange()
            slv.MoveDomToSub()
        endif
    endevent
endstate