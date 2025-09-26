Scriptname bind_GearManager extends Quest conditional

; int property UndressedFlag auto conditional

; int property ProtectHeadOnStrip auto conditional ;30
; int property ProtectHairOnStrip auto conditional ;31
; int property ProtectBodyOnStrip auto conditional ;32
; int property ProtectHandsOnStrip auto conditional ;33
; int property ProtectForearmsOnStrip auto conditional ;34
; int property ProtectAmuletOnStrip auto conditional ;35
; int property ProtectRingOnStrip auto conditional ;36
; int property ProtectFeetOnStrip auto conditional ;37
; int property ProtectCalvesOnStrip auto conditional ;38
; int property ProtectCircletOnStrip auto conditional ;42
; int property ProtectEarsOnStrip auto conditional ;43

; int property ProtectFaceMouthOnStrip auto conditional ;44
; int property ProtectNeckOnStrip auto conditional ;45 (cape, scarf, shawl, neck-tie)
; int property ProtectChestPrimaryOnStrip auto conditional ;46 (chest primary, outergarment)
; int property ProtectBackOnStrip auto conditional ;47 (backpacks, wings)
; int property ProtectBeltOnStrip auto conditional ;49 (pelvis primary, outergarment)
; int property ProtectPelvisOnStrip auto conditional ;52 (pelvis secondary, undergarment)
; int property ProtectLegPrimaryOnStrip auto conditional ;53 (right leg, outergarment)
; int property ProtectLegSecondaryOnStrip auto conditional ;54 (left leg, undergarment)
; int property ProtectJewelryOnStrip auto conditional ;55 (face alternative, jewelry)
; int property ProtectChestSecondaryOnStrip auto conditional ;56 (chest secondary, undergarment)
; int property ProtectShoulderOnStrip auto conditional ;57
; int property ProtectArmSecondaryOnStrip auto conditional ;58 (left arm, undergarnment)
; int property ProtectArmPrimaryOnStrip auto conditional ;59 (right arm, outergarment)

string property CurrentOutfit auto conditional
int property OutfitsLearn auto conditional

int kSlotMaskHead = 0x00000001  ;30
int kSlotMaskHair = 0x00000002  ;31
int kSlotMaskBody = 0x00000004  ;32
int kSlotMaskHands = 0x00000008  ;33
int kSlotMaskForearms = 0x00000010  ;34
int kSlotMaskAmulet = 0x00000020  ;35
int kSlotMaskRing = 0x00000040  ;36
int kSlotMaskFeet = 0x00000080  ;37
int kSlotMaskCalves = 0x00000100  ;38
int kSlotMaskShield = 0x00000200  ; SHIELD
int kSlotMaskTail = 0x00000400  ; TAIL
int kSlotMaskLongHair = 0x00000800  ; LongHair
int kSlotMaskCirclet = 0x00001000  ;42
int kSlotMaskEars = 0x00002000  ;43
int kSlotMaskFaceMouth = 0x00004000 ;44
int kSlotMaskNeck = 0x00008000 ;45
int kSlotMaskChestPrimary = 0x00010000 ;46
int kSlotMaskBack = 0x00020000 ;47
int kSlotMaskPelvisPrimary = 0x00080000 ;49
int kSlotMaskPelvisSecondary = 0x00400000 ;52
int kSlotMaskLegPrimary = 0x00800000 ;53
int kSlotMaskLegSecondary = 0x01000000 ;54
int kSlotMaskJewelry = 0x02000000 ;55
int kSlotMaskChestSecondary = 0x04000000 ;56
int kSlotMaskShoulder = 0x08000000 ;57
int kSlotMaskArmSecondary = 0x10000000 ;58
int kSlotMaskArmPrimary = 0x20000000 ;59

int[] slotMaskArray
string[] slotNameArray
int[] slotProtectionArray
string[] slotFriendlyName

;https://wiki.nexusmods.com/index.php/Skyrim_bodyparts_number

; Form[] gearBufferHead
; Form[] gearBufferHair
; Form[] gearBufferBody
; Form[] gearBufferHands
; Form[] gearBufferForearms

; Form gearBufferAmulet0
; Form gearBufferRing0 

; Form[] gearBufferFeet
; Form[] gearBufferCalves

; Form gearBufferCirclet0
; Form gearBufferEars0

; Form[] gearBufferWeapon
; Form[] gearBufferOffhandWeapon
; Form[] gearBufferShield

; Form gearBufferFaceMount0
; Form gearBufferNeck0
; Form gearBufferChestPrimary0
; Form gearBufferBack0
; Form gearBufferBelt0
; Form gearBufferPelvis0
; Form gearBufferLegPrimary0
; Form gearBufferLegSecondary0
; Form gearBufferJewelry0
; Form gearBufferChestSecondary0
; Form gearBufferShoulder0
; Form gearBufferArmSecondary0
; Form gearBufferArmPrimary0

; Form gearBufferAmmo
; Form gearBufferAmmo2

; ;Form gearBufferBelt1
; ;Form gearBufferPelvis1

; Spell spellLeftHand
; Spell spellRightHand

; int arrayCreated

; bool wasUndressed

Keyword slaArmorPrettyKeyword
Keyword eroticArmorKeyword
Keyword slaAmorSpendexKeyword
Keyword slaArmorHalfNakedBikniKeyword
Keyword slaArmorHalfNakedKeyword

Function LoadGame(bool rebuildStorage = false)	
    SetupStorage(rebuildStorage)
EndFunction

Function SetupStorage(bool rebuildStorage)

	slaArmorPrettyKeyword = Keyword.GetKeyword("sla_armorpretty")
	eroticArmorKeyword = Keyword.GetKeyword("Eroticarmor")
	slaAmorSpendexKeyword = Keyword.GetKeyword("sla_armorspendex")
	slaArmorHalfNakedBikniKeyword = Keyword.GetKeyword("sla_armorhalfnakedbikini")
	slaArmorHalfNakedKeyword = Keyword.GetKeyword("sla_armorhalfnaked")

	if slotProtectionArray.Length != 27
		slotProtectionArray = new int[27]
	endif

	if slotNameArray.Length != 27
		slotNameArray = new string[27]
		slotNameArray[0] = "kSlotMaskHead"
		slotNameArray[1] = "kSlotMaskHair"
		slotNameArray[2] = "kSlotMaskBody"
		slotNameArray[3] = "kSlotMaskHands"
		slotNameArray[4] = "kSlotMaskForearms"
		slotNameArray[5] = "kSlotMaskAmulet"
		slotNameArray[6] = "kSlotMaskRing"
		slotNameArray[7] = "kSlotMaskFeet"
		slotNameArray[8] = "kSlotMaskCalves"
		slotNameArray[9] = "kSlotMaskShield"
		slotNameArray[10] = "kSlotMaskTail"
		slotNameArray[11] = "kSlotMaskLongHair"
		slotNameArray[12] = "kSlotMaskCirclet"
		slotNameArray[13] = "kSlotMaskEars"
		slotNameArray[14] = "kSlotMaskFaceMouth"
		slotNameArray[15] = "kSlotMaskNeck"
		slotNameArray[16] = "kSlotMaskChestPrimary"
		slotNameArray[17] = "kSlotMaskBack"
		slotNameArray[18] = "kSlotMaskPelvisPrimary"
		slotNameArray[19] = "kSlotMaskPelvisSecondary"
		slotNameArray[20] = "kSlotMaskLegPrimary"
		slotNameArray[21] = "kSlotMaskLegSecondary"
		slotNameArray[22] = "kSlotMaskJewelry"
		slotNameArray[23] = "kSlotMaskChestSecondary"
		slotNameArray[24] = "kSlotMaskShoulder"
		slotNameArray[25] = "kSlotMaskArmSecondary"
		slotNameArray[26] = "kSlotMaskArmPrimary"
	endif

	if slotMaskArray.Length != 27
		slotMaskArray = new int[27]
		slotMaskArray[0] = 0x00000001  ;30
		slotMaskArray[1] = 0x00000002  ;31
		slotMaskArray[2] = 0x00000004  ;32
		slotMaskArray[3] = 0x00000008  ;33
		slotMaskArray[4] = 0x00000010  ;34
		slotMaskArray[5] = 0x00000020  ;35
		slotMaskArray[6] = 0x00000040  ;36
		slotMaskArray[7] = 0x00000080  ;37
		slotMaskArray[8] = 0x00000100  ;38
		slotMaskArray[9] = 0x00000200  ;SHIELD
		slotMaskArray[10] = 0x00000400  ;TAIL
		slotMaskArray[11] = 0x00000800  ;LongHair
		slotMaskArray[12] = 0x00001000  ;42
		slotMaskArray[13] = 0x00002000  ;43
		slotMaskArray[14] = 0x00004000 ;44
		slotMaskArray[15] = 0x00008000 ;45
		slotMaskArray[16] = 0x00010000 ;46
		slotMaskArray[17] = 0x00020000 ;47
		slotMaskArray[18] = 0x00080000 ;49
		slotMaskArray[19] = 0x00400000 ;52
		slotMaskArray[20] = 0x00800000 ;53
		slotMaskArray[21] = 0x01000000 ;54
		slotMaskArray[22] = 0x02000000 ;55
		slotMaskArray[23] = 0x04000000 ;56
		slotMaskArray[24] = 0x08000000 ;57
		slotMaskArray[25] = 0x10000000 ;58
		slotMaskArray[26] = 0x20000000 ;59
	endif

	if slotFriendlyName.Length != 27
		slotFriendlyName = new string[27]
		slotFriendlyName[0] = "Slot Mask Head - 30"
		slotFriendlyName[1] = "Slot Mask Hair - 31"
		slotFriendlyName[2] = "Slot Mask Body - 32"
		slotFriendlyName[3] = "Slot Mask Hands - 33"
		slotFriendlyName[4] = "Slot Mask Forearms - 34"
		slotFriendlyName[5] = "Slot Mask Amulet - 35"
		slotFriendlyName[6] = "Slot Mask Ring - 36"
		slotFriendlyName[7] = "Slot Mask Feet - 37"
		slotFriendlyName[8] = "Slot Mask Calves - 38"
		slotFriendlyName[9] = "Slot Mask Shield - 39"
		slotFriendlyName[10] = "Slot Mask Tail - 40"
		slotFriendlyName[11] = "Slot Mask Long Hair - 41"
		slotFriendlyName[12] = "Slot Mask Circlet - 42"
		slotFriendlyName[13] = "Slot Mask Ears - 43"
		slotFriendlyName[14] = "Slot Mask Face Mouth - 44"
		slotFriendlyName[15] = "Slot Mask Neck - 45"
		slotFriendlyName[16] = "Slot Mask Chest Primary - 46"
		slotFriendlyName[17] = "Slot Mask Back - 47"
		slotFriendlyName[18] = "Slot Mask Pelvis Primary - 49"
		slotFriendlyName[19] = "Slot Mask Pelvis Secondary - 52"
		slotFriendlyName[20] = "Slot Mask Leg Primary - 53"
		slotFriendlyName[21] = "Slot Mask Leg Secondary - 54"
		slotFriendlyName[22] = "Slot Mask Jewelry - 55"
		slotFriendlyName[23] = "Slot Mask Chest Secondary - 56"
		slotFriendlyName[24] = "Slot Mask Shoulder - 57"
		slotFriendlyName[25] = "Slot Mask Arm Secondary - 58"
		slotFriendlyName[26] = "Slot Mask Arm Primary - 59"
	endif

    ; If rebuildStorage
    ;     arrayCreated = 0
    ; EndIf

    ; If arrayCreated == 0
 
    ;     gearBufferBody = new Form[3]
    ;     gearBufferHands = new Form[3]
    ;     gearBufferForearms = new Form[3]
    ;     gearBufferCalves = new Form[3]
    ;     gearBufferFeet = new Form[3]
    ;     gearBufferHead = new Form[3]
    ;     gearBufferHair = new Form[3]
    ;     gearBufferWeapon = new Form[3]
    ;     gearBufferOffhandWeapon = new Form[3]
    ;     gearBufferShield = new Form[3]
    
    ;     arrayCreated = 1

    ; EndIf

EndFunction

bool function IsBinkiArmor(Armor a)
	if a.HasKeyWord(slaArmorHalfNakedBikniKeyword) ||  a.HasKeyWord(slaArmorHalfNakedKeyword)
		return true
	else
		return false
	endif
endfunction

bool function IsEroticArmor(Armor a)
	if a.HasKeyWord(slaArmorPrettyKeyword) || a.HasKeyWord(eroticArmorKeyword) || a.HasKeyWord(slaAmorSpendexKeyword) || a.HasKeyWord(slaArmorHalfNakedKeyword)
		return true
	else
		return false
	endif
endfunction

string[] function GetSlotMaskNames()
	return slotNameArray
endfunction

string[] function GetSlotMaskFriendlyNames()
	return slotFriendlyName
endfunction

int[] function GetSlotProtections()
	return slotProtectionArray
endfunction

int function GetSlotProtection(int i)
	return slotProtectionArray[i]
endfunction

function SetSlotProtection(int i, int p)
	slotProtectionArray[i] = p
endfunction

; Function ResetGearBuffers(int idx)
; 	gearBufferHead[idx] = none
; 	gearBufferHead[idx] = none
; 	gearBufferBody[idx] = none
; 	gearBufferForearms[idx] = none
; 	gearBufferHands[idx] = none
; 	gearBufferFeet[idx] = none
; 	gearBufferWeapon[idx] = none
; 	gearBufferOffhandWeapon[idx] = none
; 	gearBufferShield[idx] = none
; 	If idx == 0
; 		gearBufferAmulet0 = none
; 		gearBufferRing0 = none 
; 		gearBufferCirclet0 = none
; 		gearBufferEars0 = none

; 		gearBufferFaceMount0 = none
; 		gearBufferNeck0 = none
; 		gearBufferChestPrimary0 = none
; 		gearBufferBack0 = none
; 		gearBufferBelt0 = none
; 		gearBufferPelvis0 = none
; 		gearBufferLegPrimary0 = none
; 		gearBufferLegSecondary0 = none
; 		gearBufferJewelry0 = none
; 		gearBufferChestSecondary0 = none
; 		gearBufferShoulder0 = none
; 		gearBufferArmSecondary0 = none
; 		gearBufferArmPrimary0 = none

; 	; ElseIf idx == 1
; 	; 	gearBufferBelt1 = none
; 	; 	gearBufferPelvis1 = none
; 	EndIf
; EndFunction

; bool Function TempUndress(Actor a, int idx)
; 	wasUndressed = true
; 	bool result
; 	result = false
; 	If !IsNude(a)
; 		wasUndressed = false
; 		Undress(a, idx)
; 		result = true
; 	EndIf
; 	return result
; EndFunction

; bool Function ClearTempUndress(Actor a, int idx)
; 	bool result
; 	result = false
; 	If wasUndressed == false
; 		Dress(a, idx)
; 		result = true
; 	EndIf
; 	return result
; EndFunction

bool function ResetStripList(Actor act) global
	StorageUtil.FormListClear(act, "bind_strip_list")
endfunction

bool function RemoveWornGear(Actor act)

	; Form[] outfitItems
	; if CurrentOutfit != ""
	; 	outfitItems = StorageUtil.FormListToArray(act, "binding_outfit_set_" + CurrentOutfit)
	; endif

	; int i

	;TODO - change this to unequip items (vs. removing to hidden container) and store an array with StorageUtil of the items for re-equipping

	Form[] inventory = act.GetContainerForms()

	StorageUtil.FormListClear(act, "bind_strip_list")

	int i = 0
	while i < inventory.Length

		Form item = inventory[i]

		; if (item as ammo)
		; 	;debug.MessageBox(item)
		; 	if main.GetSubRef() == act
		; 		act.RemoveItem(item, 1000, true, StorageChest)
		; 	else
		; 		act.RemoveItem(item, 1000, true, StorageChestDom)
		; 	endif
		; endif

		If item.IsPlayable()

			if act.IsEquipped(item) && !bman.ZadKeywordsCheck(item) && !item.HasKeyWordString("sexlabnostrip")

				int slot = -1
				if item as Armor
					slot = (item as Armor).GetSlotMask()
				endif
	
				bind_Utility.WriteToConsole("item: " + item + " slot: " + slot)

				int slotProtected = 0

				int idx = 0
				while idx < slotMaskArray.Length
					if slotMaskArray[idx] == slot
						slotProtected = slotProtectionArray[idx]
						bind_Utility.WriteToConsole("found " + slotNameArray[idx])
						idx = slotMaskArray.Length
					endif
					idx += 1
				endwhile

				if slotProtected == 0

					if main.GetSubRef() == act
						;act.RemoveItem(item, 1000, true, StorageChest)
					else
						;act.RemoveItem(item, 1000, true, StorageChestDom)
					endif

					StorageUtil.FormListAdd(act, "bind_strip_list", item)

					act.UnequipItem(item, false, true)


				elseif slotProtected == 1
					bind_Utility.WriteToConsole("slot is protected")
				endif

			endif
		
		EndIf
		
		i += 1
	
	endwhile

	return true  

endfunction

bool function RestoreWornGear(Actor act)
	
	;Form[] inventory

	Form[] inventory = StorageUtil.FormListToArray(act, "bind_strip_list")

	; if main.GetSubRef() == act
	; 	inventory = StorageChest.GetContainerForms()
	; else
	; 	inventory = StorageChestDom.GetContainerForms()
	; endif

	int i = 0
	while i < inventory.Length

		Form item = inventory[i]

		; if main.GetSubRef() == act
		; 	StorageChest.RemoveItem(item, 1, true, act)
		; else
		; 	StorageChestDom.RemoveItem(item, 1, true, act)
		; endif

		if act.GetItemCount(item) > 0
			if !act.IsEquipped(item)
				act.EquipItem(item, false, true)
			endif
		endif

		i += 1
	
	endwhile

	StorageUtil.FormListClear(act, "bind_strip_list")

	return true

endfunction

; function TryToUndress(Actor a)

; endfunction

; function TryToDress(Actor a)

; endfunction

; Function Undress(Actor a, int idx)

; 	If a.GetWornForm(kSlotMaskHead) != none
; 		gearBufferHead[idx] = a.GetWornForm(kSlotMaskHead) 
; 		If ProtectHeadOnStrip == 0 && !IsBondageItem(gearBufferHead[idx])
; 			a.UnequipItem(gearBufferHead[idx], false, true)
; 		EndIf
; 	Else
; 		gearBufferHead[idx] = none
; 	EndIf

; 	If a.GetWornForm(kSlotMaskHair) != none
; 		gearBufferHair[idx] = a.GetWornForm(kSlotMaskHair)
; 		If ProtectHairOnStrip == 0 && !IsBondageItem(gearBufferHair[idx])
; 			a.UnequipItem(gearBufferHair[idx], false, true)
; 		EndIf
; 	Else
; 		gearBufferHair[idx] = none
; 	EndIf

; 	If a.GetWornForm(kSlotMaskBody) != none
; 		gearBufferBody[idx] = a.GetWornForm(kSlotMaskBody)
; 		If (ProtectBodyOnStrip == 0 || rman.GetBehaviorRuleByName("Body Rule:Nudity") == 1) && !IsBondageItem(gearBufferBody[idx]) ;NOTE - always nude will override this protection 
; 			a.UnequipItem(gearBufferBody[idx], false, true)
; 		EndIf
; 	Else
; 		gearBufferBody[idx] = none
; 	EndIf
	
; 	If a.GetWornForm(kSlotMaskForearms) != none
; 		gearBufferForearms[idx] = a.GetWornForm(kSlotMaskForearms)
; 		If ProtectForearmsOnStrip == 0 && !IsBondageItem(gearBufferForearms[idx])
; 			a.UnequipItem(gearBufferForearms[idx], false, true)
; 		EndIf
; 	Else
; 		gearBufferForearms[idx] = none
; 	EndIf
	
; 	If a.GetWornForm(kSlotMaskAmulet) != none
; 		If idx == 0
; 			gearBufferAmulet0 = a.GetWornForm(kSlotMaskAmulet)
; 			If ProtectAmuletOnStrip == 0 && !IsBondageItem(gearBufferAmulet0)
; 				a.UnequipItem(gearBufferAmulet0, false, true)
; 			Else
; 				gearBufferAmulet0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskRing) != none
; 		If idx == 0
; 			gearBufferRing0 = a.GetWornForm(kSlotMaskRing)
; 			If ProtectRingOnStrip == 0 && !IsBondageItem(gearBufferRing0)
; 				a.UnequipItem(gearBufferRing0, false, true)
; 			Else
; 				gearBufferRing0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskHands) != none
; 		gearBufferHands[idx] = a.GetWornForm(kSlotMaskHands)
; 		If ProtectHandsOnStrip == 0 && !IsBondageItem(gearBufferHands[idx])
; 			a.UnequipItem(gearBufferHands[idx], false, true)
; 		EndIf
; 	Else
; 		gearBufferHands[idx] = none
; 	EndIf
	
; 	If a.GetWornForm(kSlotMaskFeet) != none
; 		;If main.DetectedBoots == 0 
; 			;zero here would indicate shoes/boots equipped (GetWornForm != none) and and they are not DD or ZAP
; 			gearBufferFeet[idx] = a.GetWornForm(kSlotMaskFeet) 
; 			If ProtectFeetOnStrip == 0 && !IsBondageItem(gearBufferFeet[idx])
; 				a.UnequipItem(gearBufferFeet[idx], false, true)
; 			EndIf
; 		;EndIf
; 	Else
; 		gearBufferFeet[idx] = none
; 	EndIf

; 	If a.GetWornForm(kSlotMaskCalves) != none
; 		gearBufferCalves[idx] = a.GetWornForm(kSlotMaskCalves)
; 		If ProtectCalvesOnStrip == 0 && !IsBondageItem(gearBufferCalves[idx])
; 			a.UnequipItem(gearBufferCalves[idx], false, true)
; 		EndIf
; 	Else
; 		gearBufferCalves[idx] = none
; 	EndIf

; 	If a.GetWornForm(kSlotMaskCirclet) != none 
; 		If idx == 0
; 			gearBufferCirclet0 = a.GetWornForm(kSlotMaskCirclet)
; 			If ProtectCircletOnStrip == 0 && !IsBondageItem(gearBufferCirclet0)
; 				a.UnequipItem(gearBufferCirclet0, false, true)
; 			Else
; 				gearBufferCirclet0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskEars) != none
; 		If idx == 0
; 			gearBufferEars0 = a.GetWornForm(kSlotMaskEars)
; 			If ProtectEarsOnStrip == 0 && !IsBondageItem(gearBufferEars0)
; 				a.UnequipItem(gearBufferEars0, false, true)
; 			Else
; 				gearBufferEars0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskFaceMouth) != none
; 		If idx == 0
; 			gearBufferFaceMount0 = a.GetWornForm(kSlotMaskFaceMouth)
; 			If ProtectFaceMouthOnStrip == 0 && !IsBondageItem(gearBufferFaceMount0)
; 				a.UnequipItem(gearBufferFaceMount0, false, true)
; 			Else
; 				gearBufferFaceMount0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskNeck) != none
; 		If idx == 0
; 			gearBufferNeck0 = a.GetWornForm(kSlotMaskNeck)
; 			If ProtectNeckOnStrip == 0 && !IsBondageItem(gearBufferNeck0)
; 				a.UnequipItem(gearBufferNeck0, false, true)
; 			Else
; 				gearBufferNeck0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskChestPrimary) != none
; 		If idx == 0
; 			gearBufferChestPrimary0 = a.GetWornForm(kSlotMaskChestPrimary)
; 			If ProtectChestPrimaryOnStrip == 0 && !IsBondageItem(gearBufferChestPrimary0)
; 				a.UnequipItem(gearBufferChestPrimary0, false, true)
; 			Else
; 				gearBufferChestPrimary0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskBack) != none
; 		If idx == 0
; 			gearBufferBack0 = a.GetWornForm(kSlotMaskBack)
; 			If ProtectBackOnStrip == 0 && !IsBondageItem(gearBufferBack0)
; 				a.UnequipItem(gearBufferBack0, false, true)
; 			Else
; 				gearBufferBack0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskPelvisPrimary) != none
; 		If idx == 0
; 			gearBufferBelt0 = a.GetWornForm(kSlotMaskPelvisPrimary)
; 			If ProtectBeltOnStrip == 0 && !IsBondageItem(gearBufferBelt0)
; 				a.UnequipItem(gearBufferBelt0, false, true)
; 			Else
; 				gearBufferBelt0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskPelvisSecondary) != none
; 		If idx == 0
; 			gearBufferPelvis0 = a.GetWornForm(kSlotMaskPelvisSecondary)
; 			If ProtectPelvisOnStrip == 0 && !IsBondageItem(gearBufferPelvis0)
; 				a.UnequipItem(gearBufferPelvis0, false, true)
; 			Else
; 				gearBufferPelvis0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskLegPrimary) != none
; 		If idx == 0
; 			gearBufferLegPrimary0 = a.GetWornForm(kSlotMaskLegPrimary)
; 			If ProtectLegPrimaryOnStrip == 0 && !IsBondageItem(gearBufferLegPrimary0)
; 				a.UnequipItem(gearBufferLegPrimary0, false, true)
; 			Else
; 				gearBufferLegPrimary0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskLegSecondary) != none
; 		If idx == 0
; 			gearBufferLegSecondary0 = a.GetWornForm(kSlotMaskLegSecondary)
; 			If ProtectLegSecondaryOnStrip == 0 && !IsBondageItem(gearBufferLegSecondary0)
; 				a.UnequipItem(gearBufferLegSecondary0, false, true)
; 			Else
; 				gearBufferLegSecondary0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskJewelry) != none
; 		If idx == 0
; 			gearBufferJewelry0 = a.GetWornForm(kSlotMaskJewelry)
; 			If ProtectJewelryOnStrip == 0 && !IsBondageItem(gearBufferJewelry0)
; 				a.UnequipItem(gearBufferJewelry0, false, true)
; 			Else
; 				gearBufferJewelry0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskChestSecondary) != none
; 		If idx == 0
; 			gearBufferChestSecondary0 = a.GetWornForm(kSlotMaskChestSecondary)
; 			If ProtectChestSecondaryOnStrip == 0 && !IsBondageItem(gearBufferChestSecondary0)
; 				a.UnequipItem(gearBufferChestSecondary0, false, true)
; 			Else
; 				gearBufferChestSecondary0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskShoulder) != none
; 		If idx == 0
; 			gearBufferShoulder0 = a.GetWornForm(kSlotMaskShoulder)
; 			If ProtectShoulderOnStrip == 0 && !IsBondageItem(gearBufferShoulder0)
; 				a.UnequipItem(gearBufferShoulder0, false, true)
; 			Else
; 				gearBufferShoulder0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskArmSecondary) != none
; 		If idx == 0
; 			gearBufferArmSecondary0 = a.GetWornForm(kSlotMaskArmSecondary)
; 			If ProtectArmSecondaryOnStrip == 0 && !IsBondageItem(gearBufferArmSecondary0)
; 				a.UnequipItem(gearBufferArmSecondary0, false, true)
; 			Else
; 				gearBufferArmSecondary0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetWornForm(kSlotMaskArmPrimary) != none
; 		If idx == 0
; 			gearBufferArmPrimary0 = a.GetWornForm(kSlotMaskArmPrimary)
; 			If ProtectArmPrimaryOnStrip == 0 && !IsBondageItem(gearBufferArmPrimary0)
; 				a.UnequipItem(gearBufferArmPrimary0, false, true)
; 			Else
; 				gearBufferArmPrimary0 = none
; 			EndIf
; 		EndIf
; 	EndIf

; 	If a.GetEquippedWeapon() != none
; 		gearBufferWeapon[idx] = a.GetEquippedWeapon()
; 		a.UnequipItem(gearBufferWeapon[idx], false, true)
; 	Else
; 		gearBufferWeapon[idx] = none
; 	EndIf
; 	If a.GetEquippedWeapon(true) != none
; 		gearBufferOffhandWeapon[idx] = a.GetEquippedWeapon(true)
; 		a.UnequipItem(gearBufferOffhandWeapon[idx], false, true)
; 	Else
; 		gearBufferOffhandWeapon[idx] = none
; 	EndIf
; 	If a.GetEquippedShield() != none
; 		gearBufferShield[idx] = a.GetEquippedShield()
; 		a.UnequipItem(gearBufferShield[idx], false, true)
; 	Else
; 		gearBufferShield[idx] = none
; 	EndIf

; 	if gearBufferAmmo != none
; 		gearBufferAmmo2 = gearBufferAmmo
; 		a.UnequipItem(gearBufferAmmo, false, true)
; 	else
; 		gearBufferAmmo2 = none ;dont' want this trying to re-equip something that is not equipped
; 	endif

; 	UndressedFlag = 2

; EndFunction

; Function Dress(Actor a, int idx)
	
; 	If gearBufferHead[idx] != none
; 		a.EquipItem(gearBufferHead[idx], false, true)
; 	EndIf
; 	If gearBufferHair[idx] != none
; 		a.EquipItem(gearBufferHair[idx], false, true)
; 	EndIf
; 	If gearBufferBody[idx] != none
; 		a.EquipItem(gearBufferBody[idx], false, true)
; 	EndIf
; 	If gearBufferForearms[idx] != none
; 		a.EquipItem(gearBufferForearms[idx], false, true)
; 	EndIf
	
; 	If gearBufferAmulet0 != none
; 		a.EquipItem(gearBufferAmulet0, false, true)
; 	EndIf
; 	If gearBufferRing0 != none
; 		a.EquipItem(gearBufferRing0, false, true)
; 	EndIf

; 	If gearBufferHands[idx] != none
; 		a.EquipItem(gearBufferHands[idx], false, true)
; 	EndIf
; 	If gearBufferFeet[idx] != none
; 		a.EquipItem(gearBufferFeet[idx], false, true)
; 	EndIf
; 	If gearBufferCalves[idx] != none
; 		a.EquipItem(gearBufferCalves[idx], false, true)
; 	EndIf

; 	If gearBufferCirclet0 != none
; 		a.EquipItem(gearBufferCirclet0, false, true)
; 	EndIf
; 	If gearBufferEars0 != none
; 		a.EquipItem(gearBufferEars0, false, true)
; 	EndIf
	
; 	If gearBufferFaceMount0 != none
; 		a.EquipItem(gearBufferFaceMount0, false, true)
; 	EndIf
; 	If gearBufferNeck0 != none
; 		a.EquipItem(gearBufferNeck0, false, true)
; 	EndIf	
; 	If gearBufferChestPrimary0 != none
; 		a.EquipItem(gearBufferChestPrimary0, false, true)
; 	EndIf	
; 	If gearBufferBack0 != none
; 		a.EquipItem(gearBufferBack0, false, true)
; 	EndIf	
; 	If gearBufferBelt0 != none
; 		a.EquipItem(gearBufferBelt0, false, true)
; 	EndIf
; 	If gearBufferPelvis0 != none
; 		a.EquipItem(gearBufferPelvis0, false, true)
; 	EndIf
; 	If gearBufferLegPrimary0 != none
; 		a.EquipItem(gearBufferLegPrimary0, false, true)
; 	EndIf	
; 	If gearBufferLegSecondary0 != none
; 		a.EquipItem(gearBufferLegSecondary0, false, true)
; 	EndIf	
; 	If gearBufferJewelry0 != none
; 		a.EquipItem(gearBufferJewelry0, false, true)
; 	EndIf	
; 	If gearBufferChestSecondary0 != none
; 		a.EquipItem(gearBufferChestSecondary0, false, true)
; 	EndIf	
; 	If gearBufferShoulder0 != none
; 		a.EquipItem(gearBufferShoulder0, false, true)
; 	EndIf	
; 	If gearBufferArmSecondary0 != none
; 		a.EquipItem(gearBufferArmSecondary0, false, true)
; 	EndIf	
; 	If gearBufferArmPrimary0 != none
; 		a.EquipItem(gearBufferArmPrimary0, false, true)
; 	EndIf	

; 	If gearBufferWeapon[idx] != none
; 		a.EquipItem(gearBufferWeapon[idx], false, true)
; 	EndIf
; 	If gearBufferOffhandWeapon[idx] != none
; 		a.EquipItem(gearBufferOffhandWeapon[idx], false, true)
; 	EndIf
; 	If gearBufferShield[idx] != none
; 		a.EquipItem(gearBufferShield[idx], false, true)
; 	EndIf

; 	if gearBufferAmmo2 != none
; 		a.EquipItem(gearBufferAmmo2, false, true)
; 	endif

; 	UndressedFlag = 1
; 	ResetgearBuffers(idx)

; EndFunction

; bool Function IsBondageItem(Form f)
; 	If bman.IsBondageItem(f)
; 		return true
; 	Else
; 		return false
; 	EndIf
; EndFunction

bool Function IsNude(Actor a)
	; If UndressedFlag == 1
	; 	return false
	; ElseIf UndressedFlag == 2
	; 	return true
	; Else
		bool isNude = true

		If a.WornHasKeyWord(ArmorCuirass) || a.WornHasKeyWord(ClothingBody)
			isNude = false
		else
			; Form bodyItem = a.GetWornForm(kSlotMaskBody)
			; if bodyItem != none
			; 	isNude = false
			; endif
		endif

		; Form bodyItem = a.GetWornForm(kSlotMaskBody)
		; If bodyItem == none			
		; 	return true
		; Else
		; 	If a.WornHasKeyWord(ArmorCuirass) || a.WornHasKeyWord(ClothingBody)
		; 		return false
		; 	Else
		; 		return true
		; 	EndIf
		; EndIf
	; EndIf

	return isNude

EndFunction

; Function ResetUndressedFlag()
; 	UndressedFlag = 0
; EndFunction

bool Function IsWearingNoShoes(Actor a)
	If a.GetWornForm(kSlotMaskFeet) == none
		return true
	Else
		return false
	EndIf
EndFunction

bool wearOutfitRunning

function AddItemToOutfit(Actor a, Armor item)

	if !wearOutfitRunning && CurrentOutfit != "" && OutfitsLearn == 1

		debug.Notification("adding item: " + item.GetName() + " to set: " + CurrentOutfit)

		StorageUtil.FormListAdd(a, "binding_outfit_set_" + CurrentOutfit, item, false)

	endif

endfunction

function RemoveItemFromOutfit(Actor a, Armor item)

	if !wearOutfitRunning && CurrentOutfit != "" && OutfitsLearn == 1

		debug.Notification("removing item: " + item.GetName() + " to set: " + CurrentOutfit)

		StorageUtil.FormListRemove(a, "binding_outfit_set_" + CurrentOutfit, item, true)

	endif

endfunction

function WearOutfit(Actor a, string setName)

	bind_Utility.WriteToConsole("wear outfit: " + setName)
	;debug.MessageBox("something called this...")

	wearOutfitRunning = true

	if RemoveWornGear(a)

		Form[] items = StorageUtil.FormListToArray(a, "binding_outfit_set_" + setName)

		if items.Length > 0
			int idx = 0
			while idx < items.Length
				Form item = items[idx]
				if item
					bind_Utility.WriteToConsole("WearOutfit - adding item: " + item)
					if a.GetItemCount(item) > 0
						if !a.IsEquipped(item)
							a.EquipItem(item, false, true)
						endif
					else
						bind_Utility.WriteNotification(item.GetName() + " is no longer in your bag", bind_Utility.TextColorRed())
					endif
				endif
				idx += 1
			endwhile
		endif

	endif
	
	RegisterForSingleUpdate(5.0)

	CurrentOutfit = setName

endfunction

event OnUpdate()
	bind_Utility.WriteToConsole("wear outfit running flag off")
	wearOutfitRunning = false
endevent

; function WearEroticOutfit(Actor a, string setName)

; 	if RemoveWornGear(a)

; 		Form[] items = StorageUtil.FormListToArray(a, "binding_erotic_set_" + setName)

;         if items.Length > 0
;             int idx = 0
;             while idx < items.Length
;                 Form item = items[idx]
;                 if item
;                     bind_Utility.WriteToConsole("WearEroticOutfit - adding item: " + item)
; 					if a.GetItemCount(item) > 0
; 						if !a.IsEquipped(item)
; 							a.EquipItem(item, false, true)
; 						endif
; 					else
; 						bind_Utility.WriteNotification(item.GetName() + " is no longer in your bag", bind_Utility.TextColorRed())
; 					endif
;                 endif
;                 idx += 1
;             endwhile
;         endif

; 	endif

; endfunction

; function LearnOutfit(Actor a, string setName)

;     StorageUtil.FormListClear(a, "binding_outfit_set_" + setName)

; 	Armor bodyItem = a.GetWornForm(kSlotMaskBody) as Armor

; 	Form[] inventory = a.GetContainerForms()
; 	int i = 0
;     int kwi = 0
; 	while i < inventory.Length
;         Form dev = inventory[i]
;         if !dev.HasKeyWord(bman.zlib.zad_inventoryDevice) && !dev.HasKeyWord(bman.zlib.zad_Lockable) && a.IsEquipped(dev) && dev.IsPlayable() ;no dd devices
; 			bind_Utility.WriteToConsole("dev: " + dev.GetName())
; 			StorageUtil.FormListAdd(a, "binding_outfit_set_" + setName, dev, false)
;         endif
;         i += 1
;     endwhile

; endfunction

function LearnWornItemsForBondageOutfit(Actor a, int outfitId)

	bind_MainQuestScript m = Quest.GetQuest("bind_MainQuest") as bind_MainQuestScript

	string bondageOutfitFile
    bondageOutfitFile = m.GameSaveFolderJson + "bind_bondage_outfit_" + outfitId + ".json"

    GoToState("WorkingState")

    JsonUtil.FormListClear(bondageOutfitFile, "fixed_worn_items")

	Form[] inventory = a.GetContainerForms()
	int i = 0
    int kwi = 0
	while i < inventory.Length
        Form dev = inventory[i]
		if dev.IsPlayable()
			if a.IsEquipped(dev)
				if !bman.ZadKeywordsCheck(dev) && !dev.HasKeyWordString("SexLabNoStrip") ;no dd devices
					bind_Utility.WriteToConsole("LearnWornItemsForBondageOutfit - dev: " + dev.GetName())
					;StorageUtil.FormListAdd(a, "binding_outfit_set_" + setName, dev, false)
					JsonUtil.FormListAdd(bondageOutfitFile, "fixed_worn_items", dev, false)
				else

				endif
			endif
		endif
        i += 1
    endwhile

    GoToState("")

    JsonUtil.Save(bondageOutfitFile)

endfunction

function LearnOutfit(Actor a, string setName) 

	;sets - safe/unsafe/bikini/erotic/nude

    ;     gear_manager.LearnEroticOutfit(a, "nude")
    ;     debug.MessageBox("Nude outfit learned")
    ; elseif listReturn == 2
    ;     gear_manager.LearnEroticOutfit(a, "bikini", "", true, "bikini")
    ;     debug.MessageBox("Bikini outfit learned")
    ; elseif listReturn == 3
    ;     gear_manager.LearnEroticOutfit(a, "erotic", "sla_armorpretty|Eroticarmor|sla_armorspendex|sla_armorhalfnaked|sla_armorhalfnakedbikini", true)
    ;     debug.MessageBox("Erotic Armor outfit learned")
    ; elseif listReturn == 4
    ;     gear_manager.LearnOutfit(a, "safe")
    ;     debug.MessageBox("Safe area outfit learned")
    ; elseif listReturn == 5
    ;     gear_manager.LearnOutfit(a, "unsafe")

	string allowedKeyword = ""
	bool allowNonBodyArmor = false
	bool allowBodyArmor = false
	string nameKeyword = ""

	if setName == "nude"

	elseif setName == "bikini"
		allowedKeyword = "sla_armorhalfnakedbikini|bind_ArmorBikini"
		nameKeyword = "bikini"
		allowNonBodyArmor = true
	elseif setName == "erotic"
		allowedKeyword = "sla_armorpretty|Eroticarmor|sla_armorspendex|sla_armorhalfnaked|sla_armorhalfnakedbikini|bind_ArmorErotic"
		allowNonBodyArmor = true
	elseif setName == "safe"
		allowNonBodyArmor = true
		allowBodyArmor = true
	elseif setName == "unsafe"
		allowNonBodyArmor = true
		allowBodyArmor = true
	endif

    StorageUtil.FormListClear(a, "binding_outfit_set_" + setName)

	Armor bodyItem = a.GetWornForm(kSlotMaskBody) as Armor
	; Armor pelvis2 = a.GetWornForm(kSlotMaskPelvisSecondary) as Armor
	; debug.MessageBox("p2: " + pelvis2.GetName())

	Form[] inventory = a.GetContainerForms()
	int i = 0
    int kwi = 0
	while i < inventory.Length
        Form dev = inventory[i]
		if a.IsEquipped(dev)
			if !bman.ZadKeywordsCheck(dev) && !dev.HasKeyWordString("SexLabNoStrip") ;no dd devices

				bool storeThis = true
				if bodyItem != none && !allowBodyArmor
					;debug.MessageBox(bodyItem)
					if bodyItem == dev
						storeThis = false
						if nameKeyword != ""
							if StringUtil.Find(dev.GetName(), nameKeyword, 0) > -1
								storeThis = true
							endif
						endif
						if allowedKeyword != ""
							string[] arr = StringUtil.Split(allowedKeyword, "|")
							;debug.MessageBox(arr)
							if arr.Length > 0
								int idx = 0
								while idx < arr.Length
									if dev.HasKeyWordString(arr[idx])
										;debug.MessageBox("found keyword??")
										storeThis = true
									endif
									idx += 1
								endwhile
							endif
						endif
					endif
				endif

				if !allowNonBodyArmor && (bodyItem != dev)
					debug.MessageBox("make it in here???")
					if dev.HasKeywordString("ArmorJewelry") 
						;always allow jewelry
					elseif dev.HasKeyWordString("ClothingFeet") 
						;always allow shoes
					else
						storethis = false
					endif
				endif

				if storeThis
					bind_Utility.WriteToConsole("dev: " + dev.GetName())
					StorageUtil.FormListAdd(a, "binding_outfit_set_" + setName, dev, false)
				endif

			else

				;bind_Utility.WriteToConsole("ignoring item - dev: " + dev.GetName() + " idx: " + i)

			endif
		endif
        i += 1
    endwhile

endfunction

Form[] wornItems 
Form[] inBag

function WhitelistItems(Actor a)

	wornItems = new Form[128]
	inBag = a.GetContainerForms()

	int i = 0
	int i2 = 0	
	while i < inBag.Length
		Form dev = inBag[i]
		if dev as Armor
			if dev.IsPlayable()
				wornItems[i2] = dev
				i2 += 1
			endif
		endif
		i += 1
	endwhile

	WhitelistItemsLoaded(a)

endfunction

function WhitelistItemsLoaded(Actor a)

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
	int i = 0
	while i < wornItems.Length
		Form dev = wornItems[i]
		string inWhiteList = ""
		if StorageUtil.FormListHas(a, "bind_bikini_white_list", dev)
			inWhiteList = "BIKINI - "
		endif
		if StorageUtil.FormListHas(a, "bind_erotic_white_list", dev)
			inWhiteList = "EROTIC - "
		endif
		listMenu.AddEntryItem(inWhiteList + dev.GetName())
		i += 1
	endwhile

	; int i = 0
	; int i2 = 0	
	; while i < slotFriendlyName.Length
	; 	Form dev = a.GetWornForm(slotMaskArray[i])
	; 	if dev != none
	; 		wornItems[i2] = dev
	; 		i2 += 1
	; 		string inWhiteList = ""
	; 		if StorageUtil.FormListHas(a, "bind_bikini_white_list", dev)
	; 			inWhiteList = "BIKINI - "
	; 		endif
	; 		if StorageUtil.FormListHas(a, "bind_erotic_white_list", dev)
	; 			inWhiteList = "EROTIC - "
	; 		endif
	; 		listMenu.AddEntryItem(inWhiteList + dev.GetName())
	; 	endif
	; 	i += 1
	; endwhile

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

	if listReturn >= 0
		Form dev = wornItems[listReturn]
		;debug.MessageBox(dev)
		if StorageUtil.FormListHas(a, "bind_bikini_white_list", dev)
			StorageUtil.FormListRemove(a, "bind_bikini_white_list", dev)
			StorageUtil.FormListAdd(a, "bind_erotic_white_list", dev)
		elseif StorageUtil.FormListHas(a, "bind_erotic_white_list", dev)
			StorageUtil.FormListRemove(a, "bind_erotic_white_list", dev)
		else
			StorageUtil.FormListAdd(a, "bind_bikini_white_list", dev)
		endif
		WhitelistItemsLoaded(a)
	endif


endfunction

; function SetAmmo(Form a)
; 	gearBufferAmmo = a
; endfunction

; function ClearAmmo()
; 	gearBufferAmmo = none
; endfunction

bind_Functions property main auto
bind_BondageManager property bman auto
bind_RulesManager property rman auto

Keyword property ArmorCuirass auto
Keyword property ClothingBody auto

ObjectReference property StorageChest auto
ObjectReference property StorageChestDom auto

;*************************************************************
;interesting functions
;
;; 36 - ring slot
;Armor myPrecious = gollum.GetEquippedArmorInSlot(36)
;
; ; Force the player to unequip the full helmets
; Game.GetPlayer().UnequipItemSlot(30)
;
;int SlotMask = ArmorProperty.GetSlotMask()
; if (SlotMask == 4)
; 	Debug.Trace("This armor is equipped on the body, and only the body.")
; endif
