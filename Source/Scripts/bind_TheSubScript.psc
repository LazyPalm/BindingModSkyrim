Scriptname bind_TheSubScript extends ReferenceAlias  

int IDLE_STATE_SIT_GROUND = 10

int foodEaten
int spellsLearned

bool cheatDeath = false

ObjectReference currentConversationTarget

event OnInit()

	kwArmorCuirass = Keyword.GetKeyword("ArmorCuirass")
	kwClothingBody = Keyword.GetKeyword("ClothingBody")

	RegisterForSleep()
	RegisterforCrosshairRef()

	foodEaten = Game.queryStat("Food Eaten")
	spellsLearned = Game.queryStat("Spells Learned")

endevent

event OnPlayerTeleport()
	debug.MessageBox("teleported??")
endevent

Event OnPlayerLoadGame()

	;debug.MessageBox("loaded game")

	;MQS.LoadGame()

	(GetOwningQuest() as bind_Controller).LoadGame()
	(GetOwningQuest() as bind_Functions).LoadGame()

	; ;TODO - figure why this will not work as a passed parameter (seems to be a ZAP issue, DD parameters work fine)
	; ;they will happily fill on CK, but they 100% will not work (multiple tests)

	; zbfWornDevice = Keyword.GetKeyword("zbfWornDevice")
	; zbfWornWrist = Keyword.GetKeyword("zbfWornWrist")
	; zbfWornElbows = Keyword.GetKeyword("zbfWornElbows")
	; zbfWornAnkles = Keyword.GetKeyword("zbfWornAnkles")
	; zbfWornGag = Keyword.GetKeyword("zbfWornGag") 
	; zbfWornCollar = Keyword.GetKeyword("zbfWornCollar")
	; zbfWornBelt = Keyword.GetKeyword("zbfWornBelt")

	kwArmorCuirass = Keyword.GetKeyword("ArmorCuirass")
	kwClothingBody = Keyword.GetKeyword("ClothingBody")
	;;kwFoodItem = Keyword.GetKeyword("VendorItemFood")

	RegisterForSleep()
	RegisterforCrosshairRef()

	foodEaten = Game.queryStat("Food Eaten")
	spellsLearned = Game.queryStat("Spells Learned")

EndEvent

bool processHit

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
	bool abBashAttack, bool abHitBlocked)

	if !processHit
		processHit = true
		
		if bind_GlobalModState.GetValue() == 1.0
			If MQS.IsSub == 0 && MQS.DomStartupQuestsEnabled == 1
				If fs.FutureDom != none
					float baseHealthValue = fs.GetSubRef().GetBaseActorValue("Health")
					float healthValue = fs.GetSubRef().GetActorValue("Health")		
					If (healthValue < (baseHealthValue / 2.0)) && (healthValue > 0) 
						;(healthValue < ((baseHealthValue / 3.0) * 2.0)) && (healthValue > 0) ;(healthValue < (baseHealthValue / 2.0)) && (healthValue > 0)
						If !cheatDeath
							cheatDeath = true
							;TODO - make this a quest!!!
							;MQS.TheDominantFollowerEvent()
						EndIf
					EndIf
				EndIf
			EndIf
		endif

		processHit = false
	endif

EndEvent

Event OnEnterBleedout()

	if bind_GlobalModState.GetValue() == 1.0

		;MQS.GetSubRef().GetActorBase().SetEssential(true)
		;MQS.GetSubRef().SetNoBleedoutRecovery(true)

		;Debug.MessageBox("We entered bleedout...")

		If MQS.IsSub == 0

			;SendModEvent("dhlp-Suspend")

			;MQS.SubIdleState = 11 ;IDLE_STATE_WOUNDED_FROM_COMBAT

			;MQS.FutureDom.GetActorReference().SetActorValue("Health", 20000.0)

			;MQS.GetSubRef().SheatheWeapon()
			;MQS.GetSubRef().StopCombatAlarm()

			;Utility.Wait(3.0)

			; int result = Utility.RandomInt(2, 3)		
			; If result == 1
			; 	;Debug.SendAnimationEvent(MQS.GetSubRef(), "IdleWounded_01")
			; ElseIf result == 2
			; 	Debug.SendAnimationEvent(MQS.GetSubRef(), "IdleWounded_02")
			; ElseIf result == 3
			; 	Debug.SendAnimationEvent(MQS.GetSubRef(), "IdleWounded_03")
			; EndIf

			;Debug.SendAnimationEvent(MQS.GetSubRef(), "IdleWounded_02")

			;Utility.Wait(5.0)

			;MQS.TheDominantFollowerEvent()
		
		ElseIf MQS.IsSub == 1
			;internal bondage death alternative??
		EndIf

		;MQS.GetSubRef().ResetHealthAndLimbs()

	endif

EndEvent

Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)

	if bind_GlobalModState.GetValue() == 1.0

	endif

	;Debug.MessageBox(akCaster + " applied the " + akEffect + " on us")

	;NOTE - maybe look for activation pressed and this magic effect (within x seconds) to determine if shrine was used?
	;MQS.ActivationTime

EndEvent

bool lookedAtFurniture

Event OnCrosshairRefChange(ObjectReference ref)

	if ref != currentConversationTarget
		fs.ClearConversationTargetNpc()
	endif

	if ref as Actor
		currentConversationTarget = ref
		fs.SetConversationTargetNpc(ref as Actor)
	endif

	;TODO - not sure about this only working while running state
	;this is to keep it from ditching targets while an event is running, but targeting in the event might be needed?? 3/8/25
	if bind_GlobalModState.GetValue() == 1.0

		;Maybe only run checks if the activation key has been pressed?

		If MQS.IsSub == 1
			If ref ;Used to determine if it's none or not.
				;Debug.Notification("Crosshair had " + ref.GetDisplayName() + " type " + ref.GetType() + " id " + ref + " targeted.")
				int foundType = ref.GetType()
				If foundType == 62
					If MQS.DomUseDragonSoulRitual == 1
						; If MQS.SubNearDeadDragon == 0
						; 	If ref as MGRitual05DragonScript
						; 		;Debug.MessageBox("found dead dragon...")
						; 		DeadDragon.ForceRefTo(ref)
						; 		MQS.SubNearDeadDragon = 1
						; 		MQS.WindowOutput("I should talk to " + MQS.GetDomTitle() + " about this dragon...")
						; 		;MQS.SoulsFromBones()
						; 	EndIf
						; EndIf
					EndIf
					if ref as Actor
						;MQS.SetConversationTarget(ref as Actor)
						;currentConversationTarget = ref
						;fs.SetConversationTargetNpc(ref as Actor)
						;if RulesManager.BehaviorStudiesAskToTrainMustAsk == 1 && RulesManager.BehaviorStudiesAskToTrainPermission == 0
						if ref == fs.GetDomRef()

							if fs.ModInRunningState()
								if StorageUtil.GetIntValue(self.GetReference(), "bind_safe_area_interaction_check", 0) == 3
									;debug.MessageBox("start rules check quest")
									if !bind_RulesCheckQuest.IsRunning()
										bind_RulesCheckQuest.Start()
									endif
									StorageUtil.SetIntValue(self.GetReference(), "bind_safe_area_interaction_check", 4) ;set to completed
								endif
							endif

						elseif RulesManager.GetBehaviorRule(fs.GetSubRef(), RulesManager.BEHAVIOR_RULE_ASK_TO_TRAIN())  == 1 && RulesManager.BehaviorStudiesAskToTrainPermission == 0
							Actor trainer = ref as Actor
							if trainer.IsInFaction(JobTrainerFaction)
								bind_Utility.WriteInternalMonologue("I must ask permission before speaking to a trainer...")
							endif
						endif
					endif
				ElseIf foundType == 61 ;kReference - 61
					string displayName = ref.GetDisplayName()

					bool foundShrine = false
					bool foundDoor = false
					If ref.GetBaseObject() as Door
						; ;found door
						; ;Debug.MessageBox("it was a door...")
						BuildingDoor.ForceRefTo(ref)
						; MQS.CalculateDistanceAtAction()

						;debug.MessageBox("locked: " + ref.IsLocked())

						if MQS.DomDoorDiscovery == 1 && ref.IsLocked()
							;NOTE - NPC doms will give the player a copy of the key, this code will "learn" the building faction the first time the player unlocks the door
							;this will keep the trespassing messages away
							ObjectReference destination = PO3_SKSEFunctions.GetDoorDestination(ref)
							if destination.GetBaseObject() as Door
								Location doorLoc = destination.GetCurrentLocation()
								Faction buildingFaction = destination.GetFactionOwner()

								Faction[] factions = fs.GetDomRef().GetFactions(-128, 127)
								int i = 0
								while i < factions.Length
									if factions[i] == buildingFaction
										debug.MessageBox(fs.GetDomTitle() + " lives here...")
										if !fs.GetSubRef().IsInFaction(factions[i])
											fs.GetSubRef().AddToFaction(factions[i])
											StorageUtil.SetFormValue(fs.GetSubRef(), "bind_dom_house_faction", factions[i])
											MQS.DomDoorDiscovery = 0
										endif
									endif
									i += 1
								endwhile

								;debug.MessageBox(doorLoc.GetName() + " faction: " + destination.GetFactionOwner())
							endif
						endif

						; int doorType = StorageUtil.GetIntValue(ref, "binding_door_type", 0)
						; string doorName = StorageUtil.GetStringValue(ref, "binding_door_name", "")

						; if doorType == 0
						; 	ObjectReference destination = PO3_SKSEFunctions.GetDoorDestination(ref)
						; 	if mqs.SubIndoors == 0							
						; 		;debug.messageBox(destination.GetName())
						; 		if destination.GetBaseObject() as Door
						; 			Location doorLoc = destination.GetCurrentLocation()
						; 			doorName = doorLoc.GetName()
						; 			BuildingDoorDestination.ForceLocationTo(doorLoc)
						; 			if doorLoc.HasKeywordString("LocTypeInn")
						; 				doorType = 10
						; 			elseif doorLoc.HasKeywordString("LocTypeCastle")
						; 				doorType = 20
						; 			elseif doorLoc.HasKeywordString("LocTypePlayerHouse")
						; 				doorType = 30
						; 			endif
						; 			bind_Utility.WriteToConsole("This door leads to: " + doorName)
									
						; 		endif
						; 	elseif mqs.SubIndoors == 1
						; 		if destination.GetBaseObject() as Door
						; 			Location doorLoc = destination.GetCurrentLocation()
						; 			Location subLoc = self.GetReference().GetCurrentLocation()
						; 			BuildingDoorDestination.ForceLocationTo(doorLoc)
						; 			doorName = subLoc.GetName()
						; 			if doorLoc.HasKeywordString("LocTypeCity") || doorLoc.HasKeywordString("LocTypeTown")
						; 				if subLoc.HasKeywordString("LocTypeInn")
						; 					doorType = 11
						; 				elseif subLoc.HasKeywordString("LocTypeCastle")
						; 					doorType = 21
						; 				elseif subLoc.HasKeywordString("LocTypePlayerHouse")
						; 					doorType = 31
						; 				endif
						; 			endif
						; 			bind_Utility.WriteToConsole("This door leads to: " + doorLoc.GetName())
						; 		endif
						; 	endif
						; 	if doorType > 0
						; 		StorageUtil.SetStringValue(ref, "binding_door_name", doorName)
						; 		StorageUtil.SetIntValue(ref, "binding_door_type", doorType)
						; 	endif
						; else
						; 	bind_Utility.WriteToConsole("stored door - type: " + doorType + " name: " + doorName)
						; endif

						; if doorType == 10
						; 	if RulesManager.BehaviorEnterExitRuleInn == 1 && RulesManager.BehaviorEnterExitRuleInnPermission == 0
						; 		bind_Utility.WriteInternalMonologue("I need permission to enter " + doorName + "...")
						; 	endif
						; elseif doorType == 11
						; 	if RulesManager.BehaviorEnterExitRuleInn == 1 && RulesManager.BehaviorEnterExitRuleInnPermission == 0
						; 		bind_Utility.WriteInternalMonologue("I need permission to leave " + doorName + "...")
						; 	endif
						; elseif doorType == 20
						; 	if RulesManager.BehaviorEnterExitRuleCastle == 1 && RulesManager.BehaviorEnterExitRuleCastlePermission == 0
						; 		bind_Utility.WriteInternalMonologue("I need permission to enter " + doorName + "...")
						; 	endif
						; elseif doorType == 21
						; 	if RulesManager.BehaviorEnterExitRuleCastle == 1 && RulesManager.BehaviorEnterExitRuleCastlePermission == 0
						; 		bind_Utility.WriteInternalMonologue("I need permission to leave " + doorName + "...")
						; 	endif
						; elseif doorType == 30
						; 	if RulesManager.BehaviorEnterExitRulePlayerHome == 1 && RulesManager.BehaviorEnterExitRulePlayerHomePermission == 0
						; 		bind_Utility.WriteInternalMonologue("I need permission to enter " + doorName + "...")
						; 	endif
						; elseif doorType == 31
						; 	if RulesManager.BehaviorEnterExitRulePlayerHome == 1 && RulesManager.BehaviorEnterExitRulePlayerHomePermission == 0
						; 		bind_Utility.WriteInternalMonologue("I need permission to leave " + doorName + "...")
						; 	endif
						; endif

					ElseIf ref as TempleBlessingScript
						string shrineName = ref.GetDisplayName()
						;Debug.MessageBox("it was a shrine...")
						PrayerShrine.ForceRefTo(ref)
						fs.CalculateDistanceAtAction()

					elseif ref.HasKeywordString("zadc_FurnitureDevice") || ref.HasKeywordString("dse_dm_KeywordFurniture")
						;bind_Utility.WriteInternalMonologue("This furniture looks like fun...")
						;MQS.Furniture1Ref.ForceRefTo(ref)
						fs.EventSetFurniture(ref)
						bind_GlobalLocationHasFurniture.SetValue(1)
						if !lookedAtFurniture
							lookedAtFurniture = true
							bind_Utility.SendSimpleModEvent("bind_SubLookedAtFurnitureEvent")
						endif

					elseif bind_FormListBeds.HasForm(ref.GetBaseObject())
						bind_Utility.WriteInternalMonologue("This bed looks very comfortable for " + fs.GetDomTitle() + "...")
						fs.SetNearbyBed(ref)
						MQS.bind_GlobalLocationHasBed.SetValue(1)

					; ElseIf displayName == "Door"
					; 	;float dist = ref.GetDistance(MQS.GetSubRef())
					; 	;Debug.MessageBox(dist)
					; 	foundDoor = true
					; ElseIf displayName == "Wooden  Door"
					; 	foundDoor = true
					; ElseIf displayName == "Large Wooden Door"
					; 	foundDoor = true
					; ElseIf displayName == "Shrine Of Talos"
					; 	foundShrine = true
					; ElseIf displayName == "Shrine Of Akatosh"
					; 	foundShrine = true
					; ElseIf displayName == "Shrine Of Arkay"
					; 	foundShrine = true
					; ElseIf displayName == "Shrine Of Dibella"
					; 	foundShrine = true
					; ElseIf displayName == "Shrine Of Julianos"
					; 	foundShrine = true
					; ElseIf displayName == "Shrine Of Kynareth"
					; 	foundShrine = true
					; ElseIf displayName == "Shrine Of Mara"
					; 	foundShrine = true
					; ElseIf displayName == "Shrine Of Stendarr"
					; 	foundShrine = true
					; ElseIf displayName == "Shrine Of Zenithar"
					; 	foundShrine = true
						;either attach an on activate script to a alias
						;or apply this to a variable in main that could be examined when activator is pressed (would save the forcerefto step)
						;NOTE - went with the forceref for now - will test performance
					EndIf

					; If foundDoor
					; 	BuildingDoor.ForceRefTo(ref)
					; EndIf

					; If foundShrine
					; 	MQS.WindowOutput("Found " + displayName + "...")
					; 	PrayerShrine.ForceRefTo(ref)
					; EndIf
				EndIf

				;kCharacter = 62
				;TODO - replace cell scan in conversation manager with an NPC set here, should not have the outdoor cell change issues
				;and should work bettter in crowds

				;NOTE - maybe this would be better for furniture also?
				;kActivator = 24
				;kFurniture = 40

				;NOTE - this should work for doors. when asking to enter or exit a location.

			EndIf
		EndIf

	endif

EndEvent

Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)

	if bind_GlobalModState.GetValue() == 1.0
		

	endif

	;Debug.Trace("Player went to sleep at: " + Utility.GameTimeToString(afSleepStartTime))
	;Debug.Trace("Player wants to wake up at: " + Utility.GameTimeToString(afDesiredSleepEndTime))

endEvent

Event OnSleepStop(bool abInterrupted)

	;NOTE - might need this for quests??
	if abInterrupted
		;Debug.Trace("Player was woken by something!")
	else
		;Debug.Trace("Player woke up naturally")
	endIf

	if bind_GlobalModState.GetValue() == 1.0
		;Debug.Notification("In OnSleepStop()")

		If MQS.IsSub == 1
			fs.BedtimeCheck()
		EndIf
	endif

endEvent

;NOTE - does not work on the player
; Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
; 	if (aeCombatState == 0)
; 		Debug.Notification("LEAVING COMBAT")
; 	elseif (aeCombatState == 1)
; 		Debug.Notification("ENTERING COMBAT")
; 	elseif (aeCombatState == 2)
; 		Debug.Notification("COMBAT SEARCHING...")
; 	endIf
; EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	;Debug.MessageBox("event even fire??")

	;debug.MessageBox("changed locations: " + MQS.IsSub)

	if bind_GlobalModState.GetValue() == 1.0 || bind_GlobalModState.GetValue() == 4.0 ;this would exclued dhlp and paused states
		if MQS.IsSub == 1
			fs.ProcessLocationChangeAnyState(akOldLoc, akNewLoc)
		endif
	endif

	if bind_GlobalModState.GetValue() == 1.0
		if MQS.IsSub == 1
			;debug.MessageBox("in here...")

			cheatDeath = false
			lookedAtFurniture = false
			fs.ClearConversationTargetNpc()
			fs.ProcessLocationChange(akOldLoc, akNewLoc)

			int handle = ModEvent.Create("bind_LocationChangeEvent")
			if handle
				ModEvent.PushForm(handle, akOldLoc)
				ModEvent.PushForm(handle, akNewLoc)
				ModEvent.Send(handle)
			endif

		endif
	endif
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
    
	; if (akBaseObject as ammo)
	; 	GearManager.SetAmmo(akBaseObject)
	; endif

	;NOTE - faction setting stuff that can happen in any state - even paused
	Actor theSub = self.GetReference() as Actor
	bool isBodyItem = false
	if akBaseObject.HasKeyWord(kwArmorCuirass) || akBaseObject.HasKeyWord(kwClothingBody)
		isBodyItem = true
		if theSub.IsInFaction(bind_NudityFaction)
			theSub.RemoveFromFaction(bind_NudityFaction)
		endif
		MQS.bind_GlobalPlayerNudity.SetValue(3) ;dressed
	endif
	if BondageManager.IsBondageItem(akBaseObject)
		BondageManager.DetectAddedItem(theSub, akBaseObject, 0)
	endif

	; if akBaseObject.HasKeyWord(bms.zlib.zad_DeviousGag)
	; 	if !theSub.IsInFaction(bind_WearingGagFaction)
	; 		theSub.AddToFaction(bind_WearingGagFaction)
	; 	endif
	; endif

	bool removed = false

	bool safeZone = (bind_GlobalSafeZone.GetValue() >= 2.0)

	; if akBaseObject as Armor
	; 	GearManager.AddItemToOutfit(theSub, akBaseObject as Armor)
	; endif

	;TODO - this needs to use whatever the equipped set is - events are not working
	if MQS.IsSub == 1

		;NOTE - any state operations (events and normal state)

		if !BondageManager.EquippingBondageOutfit

			bool nudeRule = RulesManager.IsNudityRequired(theSub, safeZone) 

			int wearingSetId = StorageUtil.GetIntValue(theSub, "bind_wearing_outfit_id")
			if wearingSetId > 0
				Armor dev = akBaseObject as Armor
				if dev != none
					
					int slotMask = dev.GetSlotMask()
					
					string f = "bind_bondage_outfit_" + wearingSetId + ".json"
					
					bool hasBlock = JsonUtil.IntListHas(f, "block_slots", slotMask)
					
					if hasBlock || (nudeRule && slotMask != 128) ;allow shoes on nudity rule
						if !BondageManager.ZadKeywordsCheck(dev) && !dev.HasKeyWordString("sexlabnostrip")
							;bind_Utility.WriteToConsole("block: " + slotMask + " dev: " + dev)
							bind_Utility.WriteInternalMonologue("I am not allowed to wear this...")
							theSub.UnequipItem(dev, false, true)
							removed = true
						endif
					endif

					bind_Utility.WriteToConsole("setId: " + wearingSetId + " f: " + f + " dev: " + dev + " slot: " + slotMask + " hasBlock: " + hasBlock)

				endif
			endif

		endif

	endif

	if bind_GlobalModState.GetValue() == 1.0

		;NOTE - normal state operations only (not during events)

		;Debug.MessageBox("here???")

		; If akBaseObject as Spell
		; 	Debug.Notification("spell was equiped...")
		; EndIf

		;MQS.ResetStripBuffers(0) ;do we need to do this still?

		If MQS.IsSub == 1 ;&& fs.GetModState() == 1 ;TODO - && mod running state check from global

			Armor item = akBaseObject as Armor
			if item != none
				if !item.IsJewelry()
					if RulesManager.IsBikiniRequired(theSub, safeZone)
						if GearManager.IsBinkiArmor(item) || StorageUtil.FormListHas(theSub, "bind_bikini_white_list", item)
							;debug.Notification("bikini armor - YES")
						else
							;debug.Notification("bikini armor - NO")
							bind_Utility.WriteInternalMonologue("I am only allowed to wear bikini armor...")
							theSub.UnequipItem(item, false, true)	
							removed = true					
						endif
					elseif RulesManager.IsEroticArmorRequired(theSub, safeZone)
						if GearManager.IsEroticArmor(item) || StorageUtil.FormListHas(theSub, "bind_erotic_white_list", item)
							;debug.Notification("erotic armor - YES")
						else
							;debug.Notification("erotic armor - NO")
							bind_Utility.WriteInternalMonologue("I am only allowed to wear erotic armor...")
							theSub.UnequipItem(item, false, true)	
							removed = true
						endif
					endif
				endif
			endif


			;Debug.MessageBox(akBaseObject)

			If akBaseObject == SimpleBroom
				If MQS.SoftCheckSweepingOrganizesStuff == 1
					;Debug.MessageBox("sos cleaning up...")
					MQS.SubCleanedPlayerHome = 1
				EndIf
			EndIf

			; If isBodyItem
			; 	; bool isInventoryMenuOpen = UI.IsMenuOpen("InventoryMenu")
			; 	; If isInventoryMenuOpen
			; 	; 	;Debug.MessageBox("resetting this...")
			; 	; 	GearManager.ResetUndressedFlag()
			; 	; EndIf
			; 	If RulesManager.IsNudityRequired(theSub, safeZone) ;GetBehaviorRule(theSub, RulesManager.BEHAVIOR_RULE_NUDITY())  == 1 ; ;RulesManager.IsNudityRequired() ;RulesManager.GetBehaviorRuleByName("Body Rule:Nudity") == 1 ;&& MQS.ModDHLPSuspended == 0  ;MQS.RuleAlwaysNude == 1 && MQS.ModDHLPSuspended == 0
			; 		bool failedCheck = true
			; 		If BondageManager.IsBondageItem(akBaseObject)
			; 			;make sure this is not a bondage item
			; 			failedCheck = false
			; 		EndIf
			; 		; If RulesManager.SuspendedNudity() ;!MQS.InCityOrTownCheck() && (MQS.AdventuringAllowClothing == 1 || MQS.AdventuringSuspendRules == 1)
			; 		; 	failedCheck = false ;NOTE - first priority check
			; 		; ; ElseIf (MQS.DomInCombat == 1 && MQS.DomPreferenceDressForCombat == 1) ;NOTE - test this a lot
			; 		; ; 	failedCheck = false ;NOTE - second priority check
			; 		; EndIf
			; 		If failedCheck ;&& ((MQS.DomPreferenceDressOutsideOfCitiesAndTowns == 0) || (MQS.DomPreferenceDressOutsideOfCitiesAndTowns == 1 && (MQS.InLocation == 100 || MQS.InLocation == 101)))
			; 			fs.CalculateDistanceAtAction()
			; 			;MQS.DialogThreadVariantLevel2 = 200 ;nudity required
			; 			fs.MarkSubBrokeRule("Oh no, I broke the nudity rule", true)
			; 			;Debug.Notification("You are violating the nudity rule...")
			; 			;MQS.RuleInfractions = MQS.RuleInfractions + 1
			; 		EndIf
			; 	EndIf



			; 	;MQS.SubStripped = 0 ;TODO - this is going have issues with the sexlab strip editor
			; EndIf

		EndIf



		;BondageManager.DetectAddedItem(theSub, akBaseObject, 0)

	endif

	if !removed
		if akBaseObject as Armor && StorageUtil.FormListCount(theSub, "bind_strip_list") > 0
			Armor dev = akBaseObject as Armor
			int slot = dev.GetSlotMask() ;TODO - use this to remove other items from array
			int idx = 0
			Form[] list = StorageUtil.FormListToArray(theSub, "bind_strip_list")
			while idx < list.Length
				Armor listItem = list[idx] as Armor
				if listItem.GetSlotMask() == slot
					StorageUtil.FormListRemove(theSub, "bind_strip_list", listItem)
					bind_Utility.WriteToConsole("strip list removed: " + listItem.GetName())
				endif
				idx += 1
			endwhile
			StorageUtil.FormListAdd(theSub, "bind_strip_list", dev)
			bind_Utility.WriteToConsole("strip list appended: " + dev.GetName())
		endif
		;StorageUtil.FormListClear(theSub, "bind_strip_list")
		;bind_Utility.WriteToConsole("strip array cleared")
	endif

	;NOTE - this might be worth turn back on
	; Form bodyItem = a.GetWornForm(kSlotMaskBody)
	; If bodyItem == none
	; 	(GetOwningQuest() as bind_MainQuestScript).SubStripped = 1
	; Else
	; 	(GetOwningQuest() as bind_MainQuestScript).SubStripped = 0
	; 	If (GetOwningQuest() as bind_MainQuestScript).RuleNudityEnforced() && (GetOwningQuest() as bind_MainQuestScript).InLocation != 200
	; 		Debug.Notification("You are violating the nudity rule...")
	; 	EndIf
	; EndIf

EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)

	;NOTE - faction setting stuff that can happen in any state - even paused
	Actor theSub = self.GetReference() as Actor
	bool isBodyItem = false
	if akBaseObject.HasKeyWord(kwArmorCuirass) || akBaseObject.HasKeyWord(kwClothingBody)
		isBodyItem = true
		if !theSub.IsInFaction(bind_NudityFaction)
			theSub.AddToFaction(bind_NudityFaction)
		endif
		MQS.bind_GlobalPlayerNudity.SetValue(1) ;nude
	endif
	if BondageManager.IsBondageItem(akBaseObject)
		BondageManager.DetectRemovedItem(theSub, akBaseObject, 0)
	endif

	; if akBaseObject.HasKeyWord(bms.zlib.zad_DeviousGag)
	; 	if theSub.IsInFaction(bind_WearingGagFaction)
	; 		theSub.RemoveFromFaction(bind_WearingGagFaction)
	; 	endif
	; endif

	; if akBaseObject as Armor
	; 	GearManager.RemoveItemFromOutfit(theSub, akBaseObject as Armor)
	; endif


	if bind_GlobalModState.GetValue() == 1.0

		; if (akBaseObject as ammo)
		; 	GearManager.ClearAmmo()
		; endif		

		If MQS.IsSub == 1

			; If isBodyItem
			; 	; If RulesManager.GetBehaviorRuleByName("Body Rule:Nudity") == 1 && !RulesManager.SuspendedNudity() ;&& MQS.InLocation != 200 && MQS.DomPreferenceDressOutsideOfCitiesAndTowns == 0 ;MQS.RuleAlwaysNude == 1 && MQS.InLocation != 200 && MQS.DomPreferenceDressOutsideOfCitiesAndTowns == 0
			; 	; 	;bind_Utility.WriteInternalMonologue("I am following the nudity rule...") ;only display this if the rule is on and nudity is not suspended
			; 	; EndIf



			; 	;MQS.SubStripped = 1 ;TODO - this is going have issues with the sexlab strip editor
			; EndIf



		EndIf

		;BondageManager.DetectRemovedItem(theSub, akBaseObject, 0)

		If MQS.IsSub == 0 && MQS.DomStartupQuestsEnabled == 1
			cheatDeath = false ;this should get reset on pre-enslavement
		endif

	endif

EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)

	Actor theSub = self.GetReference() as Actor

	if MQS.SoftCheckMME == 1 && MQS.EnableModMME == 1 && MQS.IsSub == 1
		;todo - find the keyword for milk - use this to set a flag that will start a quest to get the dom to collect new bottles
		if akBaseItem.HasKeywordString("MME_Milk") && bind_GlobalModState.GetValue() == 1.0
			;debug.MessageBox("in here??")
			bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is collecting my milk...")
			theSub.RemoveItem(akBaseItem, aiItemCount, false, fs.GetDomRef())
		endif
	endif

	; if !akSourceContainer
	;   Debug.MessageBox("I picked up " + aiItemCount + "x " + akBaseItem + " from the world")
	; elseif akSourceContainer == Game.GetPlayer()
	;   Debug.MessageBox("The player gave me " + aiItemCount + "x " + akBaseItem)
	; else
	;   Debug.MessageBox("I got " + aiItemCount + "x " + akBaseItem + " from another container")
	; endIf
EndEvent

state ProcessingOnItemRemoved
	Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	endevent
endstate

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)

	GotoState("ProcessingOnItemRemoved")

	Actor theSub = self.GetReference() as Actor

	; if MQS.IsSub == 1 && bind_GlobalModState.GetValue() == bind_Controller.GetModStateEvent()
	; 	If akBaseItem as potion
	; 		StorageUtil.FormListAdd(theSub, "bind_quest_ate_potion", akBaseItem, true)
	; 		; Potion food = akBaseItem as Potion
	; 		; If food.IsFood()
	; 		 	debug.MessageBox("in here??")
	; 		; 	StorageUtil.FormListAdd(theSub, "bind_quest_ate_food", akBaseItem, true)
	; 		; 	If food.GetUseSound() == ITMPotionUse
	; 		; 		mqs.QuestDrankQty += 1
	; 		; 	else
	; 		; 		mqs.QuestAteQty += 1
	; 		; 	EndIf
	; 		; endif
	; 	endif
	; endif

	If MQS.IsSub == 1 && bind_GlobalModState.GetValue() == 1.0

		int type = akBaseItem.GetType()
		If type == 46
			;food
		ElseIf type == 27
			;book
		EndIf

		If akBaseItem as book
			int spellsLearnedNow = Game.queryStat("Spells Learned")
			If spellsLearnedNow > spellsLearned
				;Debug.MessageBox("You learned a spell...")
				;TODO - get permssion to learn spells working
				If RulesManager.GetBehaviorRule(theSub, RulesManager.BEHAVIOR_RULE_ASK_READ_SCROLL())  == 1 ; RulesManager.GetBehaviorRuleByName("Studies:Ask To Read Scroll") == 1
					If StorageUtil.GetIntValue(theSub, "bind_has_read_scroll_permission", 0) == 0
						fs.CalculateDistanceAtAction()
						;MQS.DialogThreadVariantLevel2 = 1400 ;no tomes without permission
						fs.MarkSubBrokeRule("I didn't ask to study " + akBaseItem.GetName())
					Else
						;OK
						StorageUtil.SetIntValue(theSub, "bind_has_read_scroll_permission", 0)
						;MQS.SubLearnSpellHasPermission = 0 ;reset this after learning
					EndIf
				EndIf

				spellsLearned = spellsLearnedNow
			EndIf
		EndIf

		If akBaseItem as potion
			Potion food = akBaseItem as Potion

			If food.IsFood()

				;Bool isInventoryMenuOpen = UI.IsMenuOpen("InventoryMenu")
				int foodEatenNow = Game.queryStat("Food Eaten")

				If foodEatenNow > foodEaten

					bool isLiquid = false
					If food.GetUseSound() == ITMPotionUse
						isLiquid = true
					EndIf

					;Debug.MessageBox("in here...")

					bool failed = false
					If RulesManager.GetBehaviorRule(theSub, RulesManager.BEHAVIOR_RULE_FOOD_ASK())  == 1 ;RulesManager.BehaviorFoodRuleMustAsk == 1
						If RulesManager.BehaviorFoodRuleMustAskPermission == 0
							failed = true
							fs.CalculateDistanceAtAction()
							If isLiquid
								;MQS.DialogThreadVariantLevel2 = 1500 ;no drinks without permission 
								fs.MarkSubBrokeRule("I forgot to ask to drink the " + akBaseItem.GetName())
							Else
								;MQS.DialogThreadVariantLevel2 = 1501 ;no food without permission 
								fs.MarkSubBrokeRule("I forgot to ask to eat the " + akBaseItem.GetName())
							EndIf
						Else
							;OK
						EndIf
					Else
						;OK
					EndIf

					If !failed ;no need to double mark points
						; If MQS.RitualEatDrinkGetFed == 1
						; 	;not built yet
						; EndIf
					EndIf

					If !failed ;no need to double mark points
						If RulesManager.GetBehaviorRule(theSub, RulesManager.BEHAVIOR_RULE_FOOD_SIT_ON_FLOOR())  == 1 ;RulesManager.GetBehaviorRuleByName("Food Rule:Sit On Floor") == 1
							If theSub.IsInFaction(bind_PoseSitOnGroundFaction) ;MQS.SubIdleState == IDLE_STATE_SIT_GROUND
								;OK
							Else
								fs.CalculateDistanceAtAction()
								;MQS.DialogThreadVariantLevel2 = 1502 ;must eat on ground
								fs.MarkSubBrokeRule("My ass must be on the ground to eat")
							EndIf
						EndIf
					EndIf

					foodEaten = foodEatenNow

				EndIf

			
			EndIf
		
		EndIf

	EndIf

	GotoState("")

EndEvent

Event OnSit(ObjectReference akFurniture)
	If MQS.IsSub == 1 ;&& bind_GlobalModState.GetValue() == 1.0
		fs.SubEnteredFurniture(akFurniture)
	EndIf
    int handle = ModEvent.Create("bind_EventFurnitureSit")
    if handle
        ModEvent.Send(handle)
    endif
EndEvent

Event OnGetUp(ObjectReference akFurniture)
	If MQS.IsSub == 1 ;&& bind_GlobalModState.GetValue() == 1.0
		fs.SubLeftFurniture(akFurniture)
	EndIf
    int handle = ModEvent.Create("bind_EventFurnitureGetUp")
    if handle
        ModEvent.Send(handle)
    endif
EndEvent

bool processingSpellCast

Event OnSpellCast(Form akSpell)
	;debug.MessageBox(akSpell)

	if !processingSpellCast
		processingSpellCast = true

		bind_Utility.WriteToConsole("OnSpellCast spell: " + akSpell)

		if mqs.SoftCheckMME == 1 && mqs.EnableModMME == 1
			;NOTE: might need an MME integration setting to allow players to milk without permission and then have a regular collection (in this script also)
			;debug.MessageBox("in here 1")
			if akSpell == bind_MMEHelper.GetMilkSelfSpell()
				if !bind_DairyQuest.IsRunning()
					fs.CalculateDistanceAtAction()
					fs.MarkSubBrokeRule("I did not have permission to milk myself", true)
				endif
				;debug.messageBox("in here 2")
				;write infraction for using this?? portable milker
				;StorageUtil.SetIntValue(self.GetReference(), "bind_had_milk_leak", 1)
			endif
		endif

		processingSpellCast = false
	endif

EndEvent

int kSlotMaskBody = 0x00000004  ; BODY

bind_MainQuestScript property MQS auto
bind_BondageManager property BondageManager auto
bind_GearManager property GearManager auto
bind_RulesManager property RulesManager auto
bind_Controller property bcs auto
bind_Functions property fs auto

Keyword property ArmorClothing auto
Keyword property ArmorLight auto
Keyword property ArmorHeavy auto

Keyword property VendorItemFood auto

Keyword kwArmorCuirass
Keyword kwClothingBody
;Keyword kwFoodItem

Form property ITMPoisonUse auto
Form property ITMPotionUse auto
Form property ITMFoodEat auto
; SoundDescriptor property NPCHumanEatSoup auto

ReferenceAlias property PrayerShrine auto
ReferenceAlias property BuildingDoor auto
ReferenceAlias property DeadDragon auto

LocationAlias property BuildingDoorDestination auto

MiscObject Property SimpleBroom Auto

FormList property bind_FormListBeds auto

Faction property bind_WearingCollarFaction auto
Faction property bind_WearingGagFaction auto
Faction property bind_WearingHeavyBondageFaction auto

Faction property bind_NudityFaction auto

Faction property bind_PoseSitOnGroundFaction auto

Faction property JobTrainerFaction auto

GlobalVariable property bind_GlobalModState auto
GlobalVariable property	bind_GlobalLocationHasFurniture auto
GlobalVariable property bind_GlobalSafeZone auto

Quest property bind_RulesCheckQuest auto
Quest property bind_DairyQuest auto