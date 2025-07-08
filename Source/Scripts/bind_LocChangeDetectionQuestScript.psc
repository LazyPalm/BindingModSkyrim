Scriptname bind_LocChangeDetectionQuestScript extends Quest  

bool oldAreaWasSafe

event OnInit()

    if self.IsRunning()
        RegisterForModEvent("bind_LocationChangeEvent", "LocationChangeEvent")
    endif

endEvent

event LocationChangeEvent(Form oldLocation, Form newLocation)

    ; ;debug.MessageBox("this fired??")

    ; Location currentLocation = newLocation as Location
    ; Location parentLocation = PO3_SKSEFunctions.GetParentLocation(currentLocation)

    ; Actor sub = TheSub.GetReference() as Actor

    ; bool isIndoors = sub.IsInInterior()
    ; bool safeArea = false

    ; bind_GlobalSafeZone.SetValue(1)
    ; if isIndoors
    ;     ;NOTE - Solitude does not have the loctypecity keyword when returned from getparentlocation, so testing by name
    ;     ;NOTE - testing for inn / player house for current location since there are free standing inns and homes outside of towns cities
    ;     if parentLocation.HasKeyword(LocTypeCity) || parentLocation.HasKeyword(LocTypeTown) || parentLocation.GetName() == "Solitude" || currentLocation.HasKeyWord(LocTypeInn) || currentLocation.HasKeyWord(LocTypePlayerHouse)
    ;         safeArea = true 
    ;         bind_GlobalSafeZone.SetValue(3)
    ;     endif
    ; else
    ;     if currentLocation.HasKeyword(LocTypeCity) || currentLocation.HasKeyword(LocTypeTown)
    ;         safeArea = true 
    ;         bind_GlobalSafeZone.SetValue(2)
    ;     endif
    ; endif

    ; if oldAreaWasSafe != safeArea

    ;     if safeArea
    ;         StorageUtil.SetIntValue(sub, "bind_safe_area", 1)
    ;         RestoreRules()
    ;         bind_Utility.SendSimpleModEvent("bind_EnteringSafeAreaEvent")
    ;         ;rms.ClearLocationPermissions(sub, true)
    ;     else
    ;         StorageUtil.SetIntValue(sub, "bind_safe_area", 0)
    ;         SuspendRules()
    ;         bind_Utility.SendSimpleModEvent("bind_LeavingSafeAreaEvent")
    ;         ;rms.ClearLocationPermissions(sub, false) ;note - should be valid until you leave the city or town (should it be on entering also?)
    ;     endif

    ;     if !bind_GoAdventuringQuest.IsRunning()
    ;         bind_GoAdventuringQuest.Start()
    ;     endif

    ; endif

    ; ;rms.ClearLocationPermissions(sub, safeArea)

    ; bind_Utility.WriteToConsole(parentLocation.GetName() + " : " +  currentLocation.GetName() + " safe area: " + safeArea)

    ; oldAreaWasSafe = safeArea

endevent

function RestoreRules()
    if bind_GlobalSuspendHeavyBondage.GetValue() == 1.0
        bind_GlobalSuspendHeavyBondage.SetValue(0)
    endif
    if bind_GlobalSuspendNudity.GetValue() == 1.0
        bind_GlobalSuspendNudity.SetValue(0)
    endif
endfunction

function SuspendRules()
    if bind_GlobalSuspendHeavyBondage.GetValue() == 0.0
        bind_GlobalSuspendHeavyBondage.SetValue(1)
    endif
    if bind_GlobalSuspendNudity.GetValue() == 0.0
        bind_GlobalSuspendNudity.SetValue(1)
    endif
endfunction

ReferenceAlias property HostileNpc1 auto
ReferenceAlias property TheSub auto

LocationAlias property TheSubLocation auto
LocationAlias property TheSubOldLocation auto

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

GlobalVariable property bind_GlobalSafeZone auto
GlobalVariable property bind_GlobalSuspendHeavyBondage auto
GlobalVariable property bind_GlobalSuspendNudity auto

bind_MainQuestScript property mqs auto
bind_RulesManager property rms auto

Quest property bind_GoAdventuringQuest auto