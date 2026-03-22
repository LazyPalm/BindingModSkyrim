Scriptname bindc_ThePlayerAlias extends ReferenceAlias  

ObjectReference currentConversationTarget

Location oldLocation
Location newLocation
bool IsSafe

Actor thePlayer

event OnInit()

	RegisterForSleep()
	RegisterforCrosshairRef()

endevent

event OnPlayerLoadGame()

	RegisterForSleep()
	RegisterforCrosshairRef()

    ;debug.MessageBox("reloading...")
	
    (GetOwningQuest() as bindc_Main).LoadGame()
    (GetOwningQuest() as bindc_Bondage).LoadGame()
    (GetOwningQuest() as bindc_Rules).LoadGame()
    (GetOwningQuest() as bindc_Gear).LoadGame()
    ; (GetOwningQuest() as bind_Menus).LoadGame()

endevent

event OnLocationChange(Location akOldLoc, Location akNewLoc)

    isSafe = false

    if thePlayer == none
        thePlayer = self.GetActorReference()
    endif

	if akNewLoc.HasKeyWord(LocTypeInn) || akNewLoc.HasKeyword(LocTypeCity) || akNewLoc.HasKeyword(LocTypeTown) || akNewLoc.HasKeyWord(LocTypeStore) || akNewLoc.HasKeyWord(LocTypeDwelling) || akNewLoc.HasKeyWord(LocTypeCastle) || akNewLoc.HasKeyWord(LocTypeHouse)
		;safe area
		StorageUtil.SetIntValue(thePlayer, "bindc_safe_area", 2)
        isSafe = true
    elseif akNewLoc.HasKeyword(LocTypePlayerHouse)
		;safe area
		StorageUtil.SetIntValue(thePlayer, "bindc_safe_area", 3)
        isSafe = true
	else
		;dangerous areaa
		StorageUtil.SetIntValue(thePlayer, "bindc_safe_area", 1)
	endif

    bindc_Util.WriteInformation("changed locations - loc: " + akNewLoc.GetName() + " safe: " + IsSafe)

    oldLocation = akOldLoc
    newLocation = akNewLoc

    bindc_Util.SendSimpleModEvent("BindingChangedLocation")

    GoToState("ChangedLocationState")
    UnregisterForUpdate()
    RegisterForSingleUpdate(10.0) ;ten second pause to allow load in

endevent

event OnUpdate()
endevent

state ChangedLocationState
    event OnUpdate()
        bindc_Util.SendSimpleModEvent("BindingChangedLocationWithDelay")
        (GetOwningQuest() as bindc_Main).TryStartQuests()
        GoToState("")
    endevent
endstate

bool processingCrosshair

event OnCrosshairRefChange(ObjectReference ref)

	if !processingCrosshair

		processingCrosshair = true

		if ref != currentConversationTarget
            if currentConversationTarget != none
                if currentConversationTarget.GetDistance(thePlayer) > 500.0
                    (GetOwningQuest() as bindc_Main).ClearConversationTarget()
                endif
            endif
		endif

		;if MQS.PreferenceHoldConversationTarget == 1
        if ref as Actor
            currentConversationTarget = ref
            (GetOwningQuest() as bindc_Main).SetConversationTarget(ref as Actor)
        endif
		;endif

		processingCrosshair = false

	endif

endevent

Keyword property LocTypePlayerHouse auto
Keyword property LocTypeInn auto
Keyword property LocTypeCity auto
Keyword property LocTypeTown auto
Keyword property LocTypeStore auto
Keyword property LocTypeDwelling auto
Keyword property LocTypeCastle auto
Keyword property LocTypeHouse auto