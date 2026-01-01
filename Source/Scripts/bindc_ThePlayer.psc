Scriptname bindc_ThePlayer extends ReferenceAlias   

event OnPlayerLoadGame()

	(GetOwningQuest() as bindc_Main).LoadGame()
	; (GetOwningQuest() as bindc_Bondage).LoadGame()
    ; (GetOwningQuest() as bindc_Rules).LoadGame()
	; (GetOwningQuest() as bindc_Gear).LoadGame()

endevent

event OnLocationChange(Location akOldLoc, Location akNewLoc)

	;keeping this code here so it does not have to be repeated in quests

	if akNewLoc.HasKeyword(LocTypePlayerHouse) || akNewLoc.HasKeyWord(LocTypeInn) || akNewLoc.HasKeyword(LocTypeCity) || akNewLoc.HasKeyword(LocTypeTown) || akNewLoc.HasKeyWord(LocTypeStore) || akNewLoc.HasKeyWord(LocTypeDwelling) || akNewLoc.HasKeyWord(LocTypeCastle) || akNewLoc.HasKeyWord(LocTypeHouse)
		;safe area
		StorageUtil.SetIntValue(none, "bindc_safe_area", 2)
	else
		;dangerous areaa
		StorageUtil.SetIntValue(none, "bindc_safe_area", 1)
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
