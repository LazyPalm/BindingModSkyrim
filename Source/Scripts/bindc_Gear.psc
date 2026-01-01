Scriptname bindc_Gear extends Quest

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

Keyword slaArmorPrettyKeyword
Keyword eroticArmorKeyword
Keyword slaAmorSpandexKeyword
Keyword slaArmorHalfNakedBikiniKeyword
Keyword slaArmorHalfNakedKeyword

function LoadGame()
	
    slaArmorPrettyKeyword = Keyword.GetKeyword("sla_armorpretty")
	eroticArmorKeyword = Keyword.GetKeyword("Eroticarmor")
	slaAmorSpandexKeyword = Keyword.GetKeyword("sla_armorspandex")
	slaArmorHalfNakedBikiniKeyword = Keyword.GetKeyword("sla_armorhalfnakedbikini")
	slaArmorHalfNakedKeyword = Keyword.GetKeyword("sla_armorhalfnaked")

endfunction

bool function IsProperFemaleArmor(Armor a)

    if eroticArmorKeyword != none
        if a.HasKeyWord(eroticArmorKeyword)
            return true
        endif
    endif

    if slaAmorSpandexKeyword != none
        if a.HasKeyWord(slaAmorSpandexKeyword)
            return true
        endif
    endif

    if slaArmorHalfNakedKeyword != none
        if a.HasKeyWord(slaArmorHalfNakedKeyword)
            return true
        endif
    endif

    if slaArmorHalfNakedBikiniKeyword != none
        if a.HasKeyWord(slaArmorHalfNakedBikiniKeyword)
            return true
        endif
    endif

    ;do a fallback check - see if this item can be found in TAWOBA
    string fileName = ""
    if Game.IsPluginInstalled("TheAmazingWorldOfBikiniArmor.esp")
        fileName = "TheAmazingWorldOfBikiniArmor.esp"
    elseif Game.IsPluginInstalled("The Amazing World Of Bikini Armors REMASTERED.esp")
        fileName = "The Amazing World Of Bikini Armors REMASTERED.esp"
    endif
    if fileName != ""
        Form gf = Game.GetFormFromFile(a.GetFormID(), fileName)
        if gf != none
            return true
        endif
    endif

    return false

endfunction

bool Function IsNude(Actor a)
    bool isNude = true
    If a.WornHasKeyWord(ArmorCuirass) || a.WornHasKeyWord(ClothingBody)
        isNude = false
    else
    endif
	return isNude
EndFunction

bool Function IsWearingNoShoes(Actor a)
	If a.GetWornForm(kSlotMaskFeet) == none
		return true
	Else
		return false
	EndIf
EndFunction

Keyword property ArmorCuirass auto
Keyword property ClothingBody auto