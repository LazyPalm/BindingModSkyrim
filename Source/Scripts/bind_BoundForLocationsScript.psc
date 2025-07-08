Scriptname bind_BoundForLocationsScript extends Quest  

bool firstChangeCompleted

Actor theSub
Actor theDom

Location currentLocation

event OnInit()

    if self.IsRunning()

        bind_Utility.WriteToConsole("Bound for location quest starting")

        RegisterForModEvent("bind_LocationChangeEvent", "LocationChangeEvent")
        RegisterForModEvent("bind_QuestEvStartEvent", "QuestEvStartEvent")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        bind_Utility.WriteToConsole("started bound for location")

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        ; if !theSub.IsInInterior()
        ;     QuestEventEnd()

        ; else
        ;     RegisterForSingleUpdate(5.0)

        ; endif

    endif

endevent

event QuestEvStartEvent()

    bind_Utility.WriteToConsole("bound for location - detected new event")

    if theSub.IsInFaction(bind_WearingLocationSpecificBondageFaction)
        theSub.RemoveFromFaction(bind_WearingLocationSpecificBondageFaction)
        StorageUtil.SetIntValue(theSub, "bind_safe_area_interaction_check", 3) 
    endif

    ;set the rules check flag to on - since the snapshot will get messed up by the quest starting
    ;bind_GlobalRulesUpdatedFlag.SetValue(1)
    ;StorageUtil.SetIntValue(theSub, "bind_safe_area_interaction_check", 3) ;set to to-do

    ;self.Stop()

endevent

event LocationChangeEvent(Form oldLocation, Form newLocation)

    if fs.ModInRunningState()

        currentLocation = newLocation as Location
        ;Location parentLocation = PO3_SKSEFunctions.GetParentLocation(currentLocation)

        bind_Utility.WriteToConsole("bound for location - location: " + currentLocation.GetName() + " inside: " + theSub.IsInInterior())
        if !theSub.IsInInterior()
            LocationExit()
        else
            LocationEntry()
        endif

    else       
        bind_Utility.WriteToConsole("bound for location - mod not in running state")
    endif

endevent

event SafewordEvent()
    
    bind_Utility.WriteToConsole("bound for location quest safeword ending")

    if theSub.IsInFaction(bind_WearingLocationSpecificBondageFaction)
        theSub.RemoveFromFaction(bind_WearingLocationSpecificBondageFaction)
    endif

    ;self.Stop()

endevent

; event OnUpdate()

;     float distance = theDom.GetDistance(theSub)

;     bind_Utility.WriteToConsole("updating bound for location")

;     Location loc = CurrentLocationAlias.GetLocation()

;     if loc.HasKeyWord(LocTypeCastle) && distance < 1500.0
;         AddCastleBondage()
;     endif
    
;     if loc.HasKeyWord(LocTypePlayerHouse) && distance < 1500.0
;         AddPlayerHouseBondage()
;     endif

; endevent

function LocationEntry()

    float distance = theDom.GetDistance(theSub)

    bind_Utility.WriteToConsole("updating bound for location")

    Location loc = currentLocation ;CurrentLocationAlias.GetLocation()

    if loc.HasKeyWord(LocTypeCastle) && distance < 1500.0
        AddCastleBondage()
    endif
    
    if loc.HasKeyWord(LocTypePlayerHouse) && distance < 1500.0
        AddPlayerHouseBondage()
    endif

endfunction

function AddCastleBondage()
    string setName = bms.GetRandomSet("Location - Castle")
    bind_Utility.WriteToConsole("castle - found set: " + setName)
    if setName != ""
        bind_Utility.WriteInternalMonologue("I am getting special bondage for " + currentLocation.GetName() + "...")
        EquipTheSet(setName)
    endif
endfunction

function AddPlayerHouseBondage()
    string setName = bms.GetRandomSet("Location - Player Home")
    bind_Utility.WriteToConsole("player home - found set: " + setName)
    if setName != ""
        bind_Utility.WriteInternalMonologue("I am getting special bondage for home...")
        EquipTheSet(setName)
    endif
endfunction

function EquipTheSet(string setName)
    bind_MovementQuestScript.PlayDoWork(theDom)
    bms.SnapshotCurrentBondage(theSub)
    bms.RemoveAllDetectedBondageItems(theSub)
    bind_Utility.DoSleep(2.0)
    bms.EquipSet(theSub, setName)
    if !theSub.IsInFaction(bind_WearingLocationSpecificBondageFaction)
        theSub.AddToFaction(bind_WearingLocationSpecificBondageFaction)
    endif
endfunction

function LocationExit()

    if theSub.IsInFaction(bind_WearingLocationSpecificBondageFaction)
        bind_MovementQuestScript.PlayDoWork(theDom)
        ;bms.RemoveAllDetectedBondageItems(theSub)
        bms.RemoveAllDetectedBondageItems(theSub)
        bind_Utility.DoSleep(2.0)
        bms.RestoreFromSnapshot(theSub)
        theSub.RemoveFromFaction(bind_WearingLocationSpecificBondageFaction)
    endif

    ;bind_Utility.WriteToConsole("ending the bound for location quest")

    ;self.Stop()

endfunction

bind_MainQuestScript property mqs auto
bind_BondageManager property bms auto
bind_Controller property bcs auto
bind_GearManager property gms auto
bind_RulesManager property rms auto
bind_Functions property fs auto

Keyword property LocTypeClearable auto
Keyword property LocTypeInn auto  
Keyword property LocTypeCastle auto  
Keyword property LocTypeCity auto  
Keyword property LocTypeTown auto
Keyword property LocTypeStore auto  
Keyword property LocTypeDungeon auto
Keyword property LocTypeDwelling auto
Keyword property LocTypePlayerHouse auto
Keyword property LocTypeHouse auto

LocationAlias property CurrentLocationAlias auto

Faction property bind_WearingLocationSpecificBondageFaction auto

GlobalVariable property bind_GlobalRulesUpdatedFlag auto