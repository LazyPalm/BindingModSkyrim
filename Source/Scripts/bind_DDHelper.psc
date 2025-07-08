Scriptname bind_DDHelper extends Quest  

bool Function CheckValid() Global
    return Game.GetModByName("Devious Devices - Integration.esm") != 255
EndFunction

zadLibs Function GetZadLibs() Global
    return Quest.GetQuest("zadQuest") as zadLibs
Endfunction

zadcLibs Function GetZadcLibs() Global
    return Quest.GetQuest("zadcQuest") as zadcLibs
Endfunction

Keyword Function GetBindingKeyword() Global
    return Keyword.GetKeyword("zad_InventoryDevice")
EndFunction

Keyword Function GetLockableKeyword() Global
    return Keyword.GetKeyword("zad_Lockable")
EndFunction

Keyword Function GetBlockItemKeyword() Global
    return Keyword.GetKeyword("zad_BlockGeneric")
EndFunction

Keyword Function GetQuestItemKeyword() Global
    return Keyword.GetKeyword("zad_QuestItem")
EndFunction

Keyword Function GetPanelGagKeyword() Global
    return Keyword.GetKeyword("zad_DeviousGagPanel")
EndFunction

Keyword Function GetFurnitureKeyword() Global
    return Keyword.GetKeyword("zadc_FurnitureDevice")
EndFunction

string function GetJsonItemsFileName() Global
    return "binding_dd_items.json"
endfunction

string function GetJsonFurnitureFileName() Global
    return "binding_dd_furniture.json"
endfunction

; string Function BindingsWristList() Global
;     string list = "DD Steel Manacles"

;     return list
; EndFunction

string function GetDefault(string itemCategory) Global
    return JsonUtil.GetPathStringValue(GetJsonItemsFileName(), "." + itemCategory)
endfunction

string function GetList(string itemCategory) Global
    string list = ""
    string path = "." + itemCategory
    string[] items = JsonUtil.PathMembers(GetJsonItemsFileName(), path)
    ;Debug.MessageBox("path: " + path + " len: " + items.Length)
    int i = 0
    while i < items.Length
        if i > 0
            list += ","
        endif
        list += items[i]
        i += 1
    endwhile
    return list
endfunction

; string Function BindingsElbowList() Global
;     string list = "DD Rope Armbinder,DD Ebonite Armbinder,DD Ebonite Armbinder R, DD Ebonite Armbinder W,DD Ebonite Elbowbinder,DD Ebonite Elbowbinder R,"
;     list = list + "DD Ebonite Elbowbinder W,DD Iron Elbow Shackles,DD Iron Elbow Shackles Collar,DD Iron Elbow Shackles Hook"
;     return list
;     ;DD Steel Manacles should be in wrists list (split?)
; EndFunction

; string Function BindingsBodyList() Global
;     string list = "DD Rope Harness Extreme,DD Rope Harness Full Top,DD Rope Harness Hishi,DD Rope Harness Penta Crotch,DD Rope Harness Penta,DD Rope Harness Simple Crotch,"
;     list = list + "DD Rope Harness Full,DD Rope Harness,DD Rope Harness Simple,DD Rope Harness Top Crotch,DD Rope Harness Top,DD Ebonite Harness Body,"
;     list = list + "DD Ebonite Harness Body R,DD Ebonite Harness Body W,DD Ebonite Harness No Collar,DD Ebonite Harness No Collar R,DD Ebonite Harness No Collar W,"
;     list = list + "DD Ebonite Harness Reg,DD Ebonite Harness Reg R,DD Ebonite Harness Reg W,DD Ebonite Harness Reg NC,DD Ebonite Harness Reg NC R,"
;     list = list + "DD Ebonite Harness Reg NC W,DD Chain Harness,DD Chain Harness Full"
;     return list
; EndFunction

; String function BindingsGagsList() Global
;     string list = "DD Rope Bit Gag,DD Rope Ball Gag,DD Ebonite Panel Gag,DD Ebonite Panel Gag R,DD Ebonite Panel Gag W,DD Ebonite Strap Ball Gag,"
;     list = list + "DD Ebonite Strap Ball Gag R,DD Ebonite Strap Ball Gag W,DD Ebonite Strap Ring Gag,DD Ebonite Strap Ring Gag R,DD Ebonite Strap Ring Gag W,"
;     list = list + "DD Iron Wooden Bit Gag,DD Iron Bit Gag,DD Iron Ring Gag,DD Iron Pear Gag,DD Iron Bridle Full,DD Iron Bridle Half"
;     return list
; EndFunction

; String function BindingsCorsetsList() Global
;     string list = "DD Rope Corset,DD Rope Corset Penta,DD Rope Corset Simple,DD Rope Corset Top,DD Rope Corset EXP,DD Rope Corset Penta EXP,DD Rope Corset Simple EXP,"
;     list = list + "DD Rope Corset Top EXP,DD Ebonite Corset,DD Ebonite Corset R,DD Ebonite Corset W"
;     return list
; EndFunction

; String function BindingsBootsList() Global
;     string list = "DD Iron Boots Ring,DD Iron Boots Ballet,DD Iron Boots Ballet Heel,DD Ebonite Boots,DD Ebonite Boots R,DD Ebonite Boots W,"
;     list = list + "DD Ebonite Heels,DD Ebonite Heels R,DD Ebonite Heels W"
;     return list
; EndFunction

; String function BindingsAnklesList() Global
;     string list = "DD Rope Ankle Cuffs,DD Ebonite Leg Cuffs,DD Ebonite Leg Cuffs R,DD Ebonite Leg Cuffs W,DD Shackles Black,DD Shackles Silver,"
;     list = list + "DD Iron Chain Shackles"
;     return list
; EndFunction

; String function BindingsCollarsList() Global
;     string list = "DD Ebonite Collar,DD Ebonite Collar R,DD Ebonite Collar W,DD Ebonite Harness Collar,DD Ebonite Harness Collar R, DD Ebonite Harness Collar W,"
;     list = list + "DD Bell Collar,DD Pet Collar,DD Kitten Collar,DD Rope 1 Collar,DD Rope 2 Collar,DD Iron Collar,DD Iron Chain Collar"
;     return list
; EndFunction

; String function BindingsChastityList() Global
;     string list = "DD Belt Padded,DD Belt Iron,DD Belt LS Padded,DD Belt LS Padded R,DD Belt LS Padded W,DD Belt LS Padded Open,DD Belt LS Padded Open R,"
;     list = list + "DD Belt LS Padded Open W,DD Rope Crotch"
;     return list
; EndFunction

; String function BindingsPiercingList() Global
;     string list = "DD Nipple Pink Soulgem,DD Nipple Purple Soulgem,DD Nipple Purple Soulgem,DD Nipple Rings Black"
;     return list
; EndFunction

; String Function BindingsHoodsList() Global
;     string list = "DD Leather Hood"
;     return list
; EndFunction

; String Function BindingsBlindfoldsList() Global
;     string list = "DD Rope Blindfold,DD Leather Blindfold"
;     return list
; EndFunction

; string Function DefaultBindingsWrist() Global
;     return "DD Steel Manacles"
; EndFunction

; string Function DefaultBindingsElbow() Global
;     return "DD Ebonite Armbinder"
; EndFunction

; string Function DefaultBindingsBody() Global
;     return "DD Ebonite Harness No Collar"
; EndFunction

; string Function DefaultBindingsGag() Global
;     return "DD Ebonite Panel Gag"
; EndFunction

; String Function DefaultBindingsCorset() Global
;     return "DD Ebonite Corset"
; EndFunction

; String Function DefaultBindingsBoots() Global
;     return "DD Iron Boots Ring"
; EndFunction

; String Function DefaultBindingsAnkles() Global
;     return "DD Ebonite Leg Cuffs"
; EndFunction

; String Function DefaultBindingsCollar() Global
;     return "DD Ebonite Collar"
; EndFunction

; string function DefaultBindingsChastity() Global
;     return "DD Belt LS Padded"
; EndFunction

; string Function DefaultBindingsPiercing() Global
;     return "DD Nipple Pink Soulgem"
; EndFunction

; string Function DefaultBindingsClamps() Global
;     return "DD Nipple Clamps"
; EndFunction

; string Function DefaultBindingsShackles() Global
;     return "DD Shackles Black" ;"DD Iron Chain Shackles"; 
; EndFunction

; String Function DefaultBindingsHood() Global
;     return "DD Leather Hood"
; EndFunction

; String Function DefaultBindingsBlindfold() Global
;     return "DD Leather Blindfold"
; EndFunction

; Armor function GetItemRendered(string itemCategory, string itemName) Global
;     string path = "." + itemCategory + "." + itemName
;     ;string[] itemArray = JsonUtil.PathStringElements(GetJsonItemsFileName(), path)
;     string fileName = JsonUtil.GetPathStringValue(GetJsonItemsFileName(), path + ".fname")
;     string item = JsonUtil.GetPathStringValue(GetJsonItemsFileName(), path + ".item_rend")
;     return Game.GetFormFromFile(PO3_SKSEFunctions.StringToInt(item), fileName) as Armor
; endfunction

; Armor function GetItem(string itemCategory, string itemName) Global
;     string path = "." + itemCategory + "." + itemName
;     debug.trace("[binding]: bind_DDHelper - GetItem - path: " + path)
;     ;string[] itemArray = JsonUtil.PathStringElements(GetJsonItemsFileName(), path)
;     string fileName = JsonUtil.GetPathStringValue(GetJsonItemsFileName(), path + ".fname")
;     debug.trace("[binding]: bind_DDHelper - GetItem - fileName: " + fileName)
;     string item = JsonUtil.GetPathStringValue(GetJsonItemsFileName(), path + ".item_inv")
;     debug.trace("[binding]: bind_DDHelper - GetItem - item: " + item)
;     Armor a = Game.GetFormFromFile(PO3_SKSEFunctions.StringToInt(item), fileName) as Armor
;     debug.trace("[binding]: bind_DDHelper - GetItem - getformfromfile result: " + a)
;     return a
; endfunction

; int[] function GetItemSlots(string itemCategory, string itemName) Global
;     string path = "." + itemCategory + "." + itemName + ".slots"
;     return JsonUtil.PathIntElements(GetJsonItemsFileName(), path)
; endfunction

; Armor Function GetBindingItemRendered(string itemName) Global
    
;     string assetsFile = "Devious Devices - Assets.esm"
;     string integrationFile = "Devious Devices - Integration.esm"
;     string expansionFile = "Devious Devices - Expansion.esm"

;     ;blindfolds
;     If itemName == "DD Rope Blindfold"
;         return Game.GetFormFromFile(0x0604816B, expansionFile) as Armor ;zadx_blindfold_Rope_Black_Inventory
;     endif

; EndFunction

; Armor Function GetBindingItem(string itemName) Global
;     string assetsFile = "Devious Devices - Assets.esm"
;     string integrationFile = "Devious Devices - Integration.esm"
;     string expansionFile = "Devious Devices - Expansion.esm"

;     ;Debug.MessageBox(itemName)

;     ;arms/wrists/elbows
;     If itemName == "DD Rope Armbinder" 
;         return Game.GetFormFromFile(0x060486E3, expansionFile) as Armor ;zadx_Armbinder_Rope_Inventory
;     ; ElseIf itemName == "DD Rope Armbinder W" ;zadx_Armbinder_Rope_White_Inventory
;     ;     return Game.GetFormFromFile(0x060592C8, expansionFile) as Armor
;     ; ElseIf itemName == "DD Rope Armbinder B" ;zadx_Armbinder_Rope_Black_Inventory
;     ;     return Game.GetFormFromFile(0x060592CC, expansionFile) as Armor
;     ; ElseIf itemName == "DD Rope Armbinder R" ;zadx_Armbinder_Rope_Red_Inventory
;     ;     return Game.GetFormFromFile(0x060592CA, expansionFile) as Armor
;     ElseIf itemName == "DD Rope Arm Cuffs" 
;         return Game.GetFormFromFile(0x0604E8A1, expansionFile) as Armor ;zadx_rope_cuffs_Arms_Inventory (don't list these)
    
;     ElseIf itemName == "DD Ebonite Armbinder" 
;         return Game.GetFormFromFile(0x0600D4D6, expansionFile) as Armor ;zadx_EboniteArmbinderInventory
;     ElseIf itemName == "DD Ebonite Armbinder R" 
;         return Game.GetFormFromFile(0x060110F2, expansionFile) as Armor ;zadx_RDEarmbinderInventory
;     ElseIf itemName == "DD Ebonite Armbinder W" 
;         return Game.GetFormFromFile(0x0600F016, expansionFile) as Armor ;zadx_WTEarmbinderInventory
;     ElseIf itemName == "DD Ebonite Elbowbinder"        
;         return Game.GetFormFromFile(0x060415A3, expansionFile) as Armor ;zadx_ElbowbinderEboniteInventory
;     ElseIf itemName == "DD Ebonite Elbowbinder R"        
;         return Game.GetFormFromFile(0x060415A5, expansionFile) as Armor ;zadx_ElbowbinderEboniteRedInventory
;     ElseIf itemName == "DD Ebonite Elbowbinder W"        
;         return Game.GetFormFromFile(0x060415A7, expansionFile) as Armor ;zadx_ElbowbinderEboniteWhiteInventory

;     ElseIf itemName == "DD Iron Elbow Shackles" 
;         return Game.GetFormFromFile(0x06053629, expansionFile) as Armor ;zadx_elbowshackles_Inventory
;     ElseIf itemName == "DD Iron Elbow Shackles Collar" 
;         return Game.GetFormFromFile(0x060530C1, expansionFile) as Armor ;zadx_elbowshacklesCollar_Inventory
;     ElseIf itemName == "DD Iron Elbow Shackles Hook" 
;         return Game.GetFormFromFile(0x06053625, expansionFile) as Armor ;zadx_elbowshacklesHook_Inventory
;     ElseIf itemName == "DD Steel Manacles" 
;         return Game.GetFormFromFile(0x0603D2E6, expansionFile) as Armor ;zadx_shackles_steel_Inventory

;     ;body
;     ElseIf itemName == "DD Rope Harness Extreme"
;         return Game.GetFormFromFile(0x0604EE33, expansionFile) as Armor ;zadx_rope_harness_Extreme_Inventory
;     ElseIf itemName == "DD Rope Harness Full Top"
;         return Game.GetFormFromFile(0x0604EE35, expansionFile) as Armor ;zadx_rope_harness_FullTop_Inventory
;     ElseIf itemName == "DD Rope Harness Hishi"
;         return Game.GetFormFromFile(0x0604EE37, expansionFile) as Armor ;zadx_rope_harness_Hishi_Inventory
;     ElseIf itemName == "DD Rope Harness Penta Crotch"
;         return Game.GetFormFromFile(0x0604EE39, expansionFile) as Armor ;zadx_rope_harness_Penta_Crotch_Inventory
;     ElseIf itemName == "DD Rope Harness Penta"
;         return Game.GetFormFromFile(0x0604EE3B, expansionFile) as Armor ;zadx_rope_harness_Penta_Inventory
;     ElseIf itemName == "DD Rope Harness Simple Crotch"
;         return Game.GetFormFromFile(0x0604EE3D, expansionFile) as Armor ;zadx_rope_harness_Simple_Crotch_Inventory
;     ElseIf itemName == "DD Rope Harness Simple"
;         return Game.GetFormFromFile(0x0604EE3F, expansionFile) as Armor ;zadx_rope_harness_Simple_Inventory
;     ElseIf itemName == "DD Rope Harness Top Crotch"
;         return Game.GetFormFromFile(0x0604EE41, expansionFile) as Armor ;zadx_rope_harness_Top_Crotch_Inventory
;     ElseIf itemName == "DD Rope Harness Top"
;         return Game.GetFormFromFile(0x0604EE44, expansionFile) as Armor ;zadx_rope_harness_Top_Inventory
;     ElseIf itemName == "DD Rope Harness Full"
;         return Game.GetFormFromFile(0x060486E0, expansionFile) as Armor ;zadx_Harness_Rope_Full_Inventory
;     ElseIf itemName == "DD Rope Harness"
;         return Game.GetFormFromFile(0x060592AC, expansionFile) as Armor ;zadx_Harness_Rope_Inventory

;     ElseIf itemName == "DD Ebonite Harness"
;         return Game.GetFormFromFile(0x0600D4CF, expansionFile) as Armor ;zadx_EboniteHarnessInventory
;     ElseIf itemName == "DD Ebonite Harness R"
;         return Game.GetFormFromFile(0x060110E8, expansionFile) as Armor ;zadx_RDEboniteHarnessInventory
;     ElseIf itemName == "DD Ebonite Harness W"
;         return Game.GetFormFromFile(0x0600F006, expansionFile) as Armor ;zadx_WTEboniteHarnessInventory
;     ElseIf itemName == "DD Ebonite Harness No Collar"
;         return Game.GetFormFromFile(0x06001E3D, expansionFile) as Armor ;zadx_EboniteHarnessNCInventory
;     ElseIf itemName == "DD Ebonite Harness No Collar R"
;         return Game.GetFormFromFile(0x06000E10, expansionFile) as Armor ;zadx_RDEboniteHarnessNCInventory
;     ElseIf itemName == "DD Ebonite Harness No Collar W"
;         return Game.GetFormFromFile(0x0605735C, expansionFile) as Armor ;zadx_WTEboniteHarnessNCInventory
;     ElseIf itemName == "DD Ebonite Harness Reg"
;         return Game.GetFormFromFile(0x06016A07, expansionFile) as Armor ;zadx_EboniteHarnessRegInventory
;     ElseIf itemName == "DD Ebonite Harness Reg R"
;         return Game.GetFormFromFile(0x06016A0A, expansionFile) as Armor ;zadx_RDEboniteHarnessRegInventory
;     ElseIf itemName == "DD Ebonite Harness Reg W"
;         return Game.GetFormFromFile(0x06016A0E, expansionFile) as Armor ;zadx_WTEharnessRegInventory
;     ElseIf itemName == "DD Ebonite Harness Reg NC"
;         return Game.GetFormFromFile(0x06001E3B, expansionFile) as Armor ;zadx_EboniteHarnessRegNCInventory
;     ElseIf itemName == "DD Ebonite Harness Reg NC R"
;         return Game.GetFormFromFile(0x0605735A, expansionFile) as Armor ;zadx_RDEboniteHarnessRegNCInventory
;     ElseIf itemName == "DD Ebonite Harness Reg NC W"
;         return Game.GetFormFromFile(0x06057358, expansionFile) as Armor ;zadx_WTEboniteHarnessRegNCInventory

;     ElseIf itemName == "DD Chain Harness"
;         return Game.GetFormFromFile(0x0601C0B7, expansionFile) as Armor ;zadx_HR_ChainHarnessBodyInventory
;     ElseIf itemName == "DD Chain Harness Full"
;         return Game.GetFormFromFile(0x0601C0C6, expansionFile) as Armor ;zadx_HR_ChainHarnessFullInventory

;     ;gags
;     ElseIf itemName == "DD Rope Bit Gag"
;         return Game.GetFormFromFile(0x060486D3, expansionFile) as Armor ;zadx_gag_rope_bit_Inventory
;     ElseIf itemName == "DD Rope Ball Gag"
;         return Game.GetFormFromFile(0x060486D0, expansionFile) as Armor ;zadx_gag_rope_ball_Inventory

;     ElseIf itemName == "DD Ebonite Panel Gag"
;         return Game.GetFormFromFile(0x0600D4F3, expansionFile) as Armor ;zadx_GagEbonitePanelInventory
;     ElseIf itemName == "DD Ebonite Panel Gag R"
;         return Game.GetFormFromFile(0x06011130, expansionFile) as Armor ;zadx_RDEGagEbHarnPanelInventory
;     ElseIf itemName == "DD Ebonite Panel Gag W"
;         return Game.GetFormFromFile(0x0600F054, expansionFile) as Armor ;zadx_WTEGagEbHarnPanelInventory
;     ElseIf itemName == "DD Ebonite Strap Ball Gag"
;         return Game.GetFormFromFile(0x06047C05, expansionFile) as Armor ;zadx_GagEboniteStrapBallBig_Inventory
;     ElseIf itemName == "DD Ebonite Strap Ball Gag R"
;         return Game.GetFormFromFile(0x06001D98, expansionFile) as Armor ;zadx_RDEGagEboniteStrapBallBig_Inventory
;     ElseIf itemName == "DD Ebonite Strap Ball Gag W"
;         return Game.GetFormFromFile(0x06001DAE, expansionFile) as Armor ;zadx_WTEGagEboniteStrapBallBig_Inventory
;     ; ElseIf itemName == "DD Ebonite Strap Ball Gag"
;     ;     return Game.GetFormFromFile(0x0600D4F6, expansionFile) as Armor ;zadx_GagEboniteStrapBallInventory
;     ElseIf itemName == "DD Ebonite Strap Ring Gag"
;         return Game.GetFormFromFile(0x0600D4F8, expansionFile) as Armor ;zadx_GagEboniteStrapRingInventory
;     ElseIf itemName == "DD Ebonite Strap Ring Gag R"
;         return Game.GetFormFromFile(0x0601114A, expansionFile) as Armor ;zadx_RDEGagEbStrapRingInventory
;     ElseIf itemName == "DD Ebonite Strap Ring Gag W"
;         return Game.GetFormFromFile(0x0600F062, expansionFile) as Armor ;zadx_WTEGagEbStrapRingInventory

;     ElseIf itemName == "DD Iron Wooden Bit Gag"
;         return Game.GetFormFromFile(0x0601F6CB, expansionFile) as Armor ;zadx_HR_IronBitGagWoodInventory
;     ElseIf itemName == "DD Iron Bit Gag"
;         return Game.GetFormFromFile(0x0601F6C9, expansionFile) as Armor ;zadx_HR_IronBitGagInventory
;     ElseIf itemName == "DD Iron Ring Gag"
;         return Game.GetFormFromFile(0x0601F6C7, expansionFile) as Armor ;zadx_HR_IronRingGagInventory
;     ElseIf itemName == "DD Iron Pear Gag"
;         return Game.GetFormFromFile(0x0601C62C, expansionFile) as Armor ;zadx_HR_PearGagInventory
;     ElseIf itemName == "DD Iron Bridle Full"
;         return Game.GetFormFromFile(0x0601B074, expansionFile) as Armor ;zadx_HR_BridleFullInventory
;     ElseIf itemName == "DD Iron Bridle Half"
;         return Game.GetFormFromFile(0x0601B072, expansionFile) as Armor ;zadx_HR_BridleHalfInventory

;     ;corsets 
;     ElseIf itemName == "DD Rope Corset"
;         return Game.GetFormFromFile(0x0604E8C0, expansionFile) as Armor ;zadx_rope_harness_corset_Inventory
;     ElseIf itemName == "DD Rope Corset Penta"
;         return Game.GetFormFromFile(0x0604E8B9, expansionFile) as Armor ;zadx_rope_harness_corset_Penta_Inventory
;     ElseIf itemName == "DD Rope Corset Simple"
;         return Game.GetFormFromFile(0x0604E8BB, expansionFile) as Armor ;zadx_rope_harness_corset_Simple_Inventory
;     ElseIf itemName == "DD Rope Corset Top"
;         return Game.GetFormFromFile(0x0604E8BD, expansionFile) as Armor ;zadx_rope_harness_corset_Top_Inventory
;     ElseIf itemName == "DD Rope Corset EXP"
;         return Game.GetFormFromFile(0x0604EE31, expansionFile) as Armor ;zadx_rope_harness_corsetExp_Inventory
;     ElseIf itemName == "DD Rope Corset Penta EXP"
;         return Game.GetFormFromFile(0x0604EE2B, expansionFile) as Armor ;zadx_rope_harness_corsetExp_Penta_Inventory
;     ElseIf itemName == "DD Rope Corset Simple EXP"
;         return Game.GetFormFromFile(0x0604EE2D, expansionFile) as Armor ;zadx_rope_harness_corsetExp_Simple_Inventory
;     ElseIf itemName == "DD Rope Corset Top EXP"
;         return Game.GetFormFromFile(0x0604EE2F, expansionFile) as Armor ;zadx_rope_harness_corsetExp_Top_Inventory
;     ElseIf itemName == "DD Ebonite Corset"
;         return Game.GetFormFromFile(0x060159A8, expansionFile) as Armor ;zadx_EbRestrictiveCorsetInventory
;     ElseIf itemName == "DD Ebonite Corset R"
;         return Game.GetFormFromFile(0x060159CD, expansionFile) as Armor ;zadx_RDErestrictiveCorsetInventory
;     ElseIf itemName == "DD Ebonite Corset W"
;         return Game.GetFormFromFile(0x060159B8, expansionFile) as Armor ;zadx_WTErestrictiveCorsetInventory

;     ;boots 
;     ElseIf itemName == "DD Iron Boots Ring"
;         return Game.GetFormFromFile(0x060048B8, expansionFile) as Armor ;zadx_bootsLockingInventory
;     ElseIf itemName == "DD Iron Boots Ballet"
;         return Game.GetFormFromFile(0x0601F6CE, expansionFile) as Armor ;zadx_HR_IronBalletBootsInventory
;     ElseIf itemName == "DD Iron Boots Ballet Heel"
;         return Game.GetFormFromFile(0x0601FC31, expansionFile) as Armor ;zadx_HR_IronBalletBootsHeelInventory
;     ElseIf itemName == "DD Ebonite Boots"
;         return Game.GetFormFromFile(0x060159AE, expansionFile) as Armor ;zadx_EbRestrictiveBootsInventory
;     ElseIf itemName == "DD Ebonite Boots R"
;         return Game.GetFormFromFile(0x060159D3, expansionFile) as Armor ;zadx_RDErestrictiveBootsInventory
;     ElseIf itemName == "DD Ebonite Boots W"
;         return Game.GetFormFromFile(0x060159BF, expansionFile) as Armor ;zadx_WTErestrictiveBootsInventory
;     ElseIf itemName == "DD Ebonite Heels"
;         return Game.GetFormFromFile(0x0605859C, expansionFile) as Armor ;zadx_ebonite_heels_black_Inventory
;     ElseIf itemName == "DD Ebonite Heels R"
;         return Game.GetFormFromFile(0x06058596, expansionFile) as Armor ;zadx_ebonite_heels_red_Inventory
;     ElseIf itemName == "DD Ebonite Heels W"
;         return Game.GetFormFromFile(0x06058594, expansionFile) as Armor ;zadx_ebonite_heels_white_Inventory
    
;     ;legs/ankles 
;     ElseIf itemName == "DD Ebonite Leg Cuffs"
;             return Game.GetFormFromFile(0x0600D4E3, expansionFile) as Armor ;zadx_cuffs_EboniteLegsInventory
;     ElseIf itemName == "DD Ebonite Leg Cuffs R"
;         return Game.GetFormFromFile(0x06011108, expansionFile) as Armor ;zadx_RDECuffsELegsInventory
;     ElseIf itemName == "DD Ebonite Leg Cuffs W"
;         return Game.GetFormFromFile(0x0600F02C, expansionFile) as Armor ;zadx_WTECuffsELegsInventory
;     ElseIf itemName == "DD Shackles Black" 
;         return Game.GetFormFromFile(0x0603D2E8, expansionFile) as Armor ;zadx_AnkleShackles_Black_Inventory
;     ElseIf itemName == "DD Shackles Silver" 
;         return Game.GetFormFromFile(0x0603D2EB, expansionFile) as Armor ;zadx_AnkleShackles_Silver_Inventory
;     ElseIf itemName == "DD Rope Ankle Cuffs" 
;         return Game.GetFormFromFile(0x0904E8A3, expansionFile) as Armor ;zadx_rope_cuffs_legs_Inventory
;     ElseIf itemName == "DD Iron Chain Shackles" 
;         return Game.GetFormFromFile(0x0602F517, expansionFile) as Armor ;zadx_ZaZ_IronChainShacklesInventory
        

;     ;zadx_cuffs_Padded_Legs_LS_Black_Inventory
;     ;zadx_cuffs_Padded_Legs_LS_Red_Inventory
;     ;zadx_cuffs_Padded_Legs_LS_White_Inventory

;     ;collars 
;     ElseIf itemName == "DD Ebonite Collar"
;         return Game.GetFormFromFile(0x0600D4DF, expansionFile) as Armor ;zadx_cuffs_EboniteCollarInventory
;     ElseIf itemName == "DD Ebonite Collar R"
;         return Game.GetFormFromFile(0x06011100, expansionFile) as Armor ;zadx_RDECuffsECollarInventory
;     ElseIf itemName == "DD Ebonite Collar W"
;         return Game.GetFormFromFile(0x0600F020, expansionFile) as Armor ;zadx_WTECuffsECollarInventory
;     ElseIf itemName == "DD Ebonite Harness Collar"
;         return Game.GetFormFromFile(0x0600D4D3, expansionFile) as Armor ;zadx_EboniteHarnessCollarInventory
;     ElseIf itemName == "DD Ebonite Harness Collar R"
;         return Game.GetFormFromFile(0x060110EC, expansionFile) as Armor ;zadx_RDEHarnessCollarInventory
;     ElseIf itemName == "DD Ebonite Harness Collar W"
;         return Game.GetFormFromFile(0x0600F010, expansionFile) as Armor ;zadx_WTEHarnessCollarInventory
;     ElseIf itemName == "DD Bell Collar"
;         return Game.GetFormFromFile(0x0604F910, expansionFile) as Armor ;zadx_Collar_Bell_Inventory
;     ElseIf itemName == "DD Pet Collar"
;         return Game.GetFormFromFile(0x0604F914, expansionFile) as Armor ;zadx_Collar_Pet_Inventory
;     ElseIf itemName == "DD Kitten Collar"
;         return Game.GetFormFromFile(0x0604F912, expansionFile) as Armor ;zadx_Collar_Kitten_Inventory
;     ElseIf itemName == "DD Rope 1 Collar"
;         return Game.GetFormFromFile(0x060486D7, expansionFile) as Armor ;zadx_Collar_Rope_1_Inventory
;     ElseIf itemName == "DD Rope 2 Collar"
;         return Game.GetFormFromFile(0x060486DA, expansionFile) as Armor ;zadx_Collar_Rope_2_Inventory
;     ElseIf itemName == "DD Iron Collar"
;         return Game.GetFormFromFile(0x0601E687, expansionFile) as Armor ;zadx_HR_IronCollarInventory
;     ElseIf itemName == "DD Iron Chain Collar"
;         return Game.GetFormFromFile(0x0602E4DC, expansionFile) as Armor ;zadx_HR_IronCollarChain01Inventory
;     ;zadx_Collar_Posture_LS_Black_Inventory
;     ;zadx_Collar_Posture_LS_Red_Inventory
;     ;zadx_Collar_Posture_LS_White_Inventory
;     ;zadx_cuffs_Padded_Collar_LS_Black_Inventory
;     ;zadx_cuffs_Padded_Collar_LS_Red_Inventory
;     ;zadx_cuffs_Padded_Collar_LS_White_Inventory

;     ;chastity 
;     ElseIf itemName == "DD Belt Padded"
;          return Game.GetFormFromFile(0x05009A7B, integrationFile) as Armor ;zad_beltPaddedInventory
;     ElseIf itemName == "DD Belt Iron"
;         return Game.GetFormFromFile(0x0500EB5D, integrationFile) as Armor ;zad_beltIronInventory
;     ElseIf itemName == "DD Belt LS Padded"
;         return Game.GetFormFromFile(0x06058630, expansionFile) as Armor ;zadx_chastitybelt_Padded_LS_Black_Inventory
;     ElseIf itemName == "DD Belt LS Padded R"
;         return Game.GetFormFromFile(0x0605862E, expansionFile) as Armor ;zadx_chastitybelt_Padded_LS_Red_Inventory
;     ElseIf itemName == "DD Belt LS Padded W"
;         return Game.GetFormFromFile(0x0605862C, expansionFile) as Armor ;zadx_chastitybelt_Padded_LS_White_Inventory
;     ElseIf itemName == "DD Belt LS Padded Open"
;         return Game.GetFormFromFile(0x06058CBF, expansionFile) as Armor ;zadx_chastitybelt_PaddedOpen_LS_Black_Inventory
;     ElseIf itemName == "DD Belt LS Padded Open R"
;         return Game.GetFormFromFile(0x060012C6, expansionFile) as Armor ;zadx_chastitybelt_PaddedOpen_LS_Red_Inventory
;     ElseIf itemName == "DD Belt LS Padded Open W"
;         return Game.GetFormFromFile(0x060012C8, expansionFile) as Armor ;zadx_chastitybelt_PaddedOpen_LS_White_Inventory
;     ElseIf itemName == "DD Rope Crotch"
;         return Game.GetFormFromFile(0x0604E89F, expansionFile) as Armor ;zadx_rope_crotch_Inventory

;     ;piercing 
;     ElseIf itemName == "DD Nipple Pink Soulgem"
;         return Game.GetFormFromFile(0x050409A2, integrationFile) as Armor ;zad_piercingNsoulInventory 
;     ElseIf itemName == "DD Nipple Purple Soulgem"
;         return Game.GetFormFromFile(0x06014925, expansionFile) as Armor ;zadx_piercingNCommonSoulInventory 
;     ElseIf itemName == "DD Nipple Purple Soulgem"
;         return Game.GetFormFromFile(0x06014929, expansionFile) as Armor ;zadx_piercingNShockSoulInventory 
;     ElseIf itemName == "DD Nipple Rings Black"
;         return Game.GetFormFromFile(0x0601CB91, expansionFile) as Armor ;zadx_HR_NipplePiercingsInventory 

;     ;clamps 
;     ElseIf itemName == "DD Nipple Clamps"
;         return Game.GetFormFromFile(0x0601C62A, expansionFile) as Armor ;zadx_HR_NippleClampsInventory

;     ;blindfolds
;     ElseIf itemName == "DD Rope Blindfold"
;         return Game.GetFormFromFile(0x0604816C, expansionFile) as Armor ;zadx_blindfold_Rope_Black_Inventory
;         ;return Game.GetFormFromFile(0x0604816C, expansionFile) as Armor ;zadx_blindfold_Rope_Inventory
;     ElseIf itemName == "DD Leather Blindfold"
;         return Game.GetFormFromFile(0x06004E25, expansionFile) as Armor ;zadx_blindfoldBlockingInventory
;     ;zadx_EboniteBlindfoldInventory
;     ;zadx_RDEEBlindfoldInventory
;     ;zadx_WTEEBlindfoldInventory

;     ;hoods
;     ElseIf itemName == "DD Leather Hood"
;         return Game.GetFormFromFile(0x0603D850, expansionFile) as Armor ;zadx_hood_leather_black_Inventory
;     ;can't find black ebonite
;     ;zadx_hood_ebonite_red_Inventory
;     ;zadx_hood_ebonite_white_Inventory

;     Else
;         return none
;     EndIf
; EndFunction

; bool Function AddBinding(Actor a, Armor item) Global
;     zadLibs zlib = GetZadLibs()
;     return zlib.LockDevice(a, item, true)
; EndFunction

; bool Function RemoveBinding(Actor a, Armor item, Armor renderedItem = none) Global
;     zadLibs zlib = GetZadLibs()
;     return zlib.UnlockDevice(a, item, renderedItem, none, true)
; EndFunction

; Armor Function GetRenderedByKeyword(Actor a, Keyword kw) Global
;     zadLibs zlib = GetZadLibs()
;     return zlib.GetWornRenderedDeviceByKeyword(a, kw)
; EndFunction

; bool Function RemoveBindingByKeyword(Actor a, Keyword kw) Global
;     zadLibs zlib = GetZadLibs()
;     return zlib.UnlockDeviceByKeyword(a, kw, true)
; EndFunction

; Armor Function GetWornDevice(Actor a, Keyword kw) Global
;     zadLibs zlib = GetZadLibs()
;     return zlib.GetWornDevice(a, kw)
; EndFunction

; Function UnplugGag(Actor a) Global
;     zadLibs zlib = GetZadLibs()
;     zlib.UnPlugPanelGag(a)
; EndFunction

; Function PlugGag(Actor a) Global
;     zadLibs zlib = GetZadLibs()
;     zlib.PlugPanelGag(a)
; EndFunction

; Function RemoveGagEffect(Actor a) Global
;     ; string integrationFile = "Devious Devices - Integration.esm"
;     ; Faction f = Game.GetFormFromFile(0x0504653B, integrationFile) as Faction
;     ; a.AddToFaction(f)
;     zadLibs zlib = GetZadLibs()
;     zlib.PauseDialogue()
;     ; zlib.RemoveGagEffect(a)
;     ; zlib.SendGagEffectEvent(a, true)
; EndFunction

; Function AddGagEffect(Actor a) Global
;     ; string integrationFile = "Devious Devices - Integration.esm"
;     ; Faction f = Game.GetFormFromFile(0x0504653B, integrationFile) as Faction
;     ; a.RemoveFromFaction(f)
;     zadLibs zlib = GetZadLibs()
;     zlib.ResumeDialogue()
;     ;zlib.ApplyGagEffect(a)
;     ;zlib.SendGagEffectEvent(a, false)
; EndFunction

; Armor Function GetRendered(Armor a) Global
;     zadLibs zlib = GetZadLibs()
;     return zlib.GetRenderedDevice(a)
; EndFunction

string Function FurnitureList() Global
    string list = ""
    string path = ".furniture_list"
    string[] items = JsonUtil.PathMembers(GetJsonFurnitureFileName(), path)
    ;Debug.MessageBox("path: " + path + " len: " + items.Length)
    int i = 0
    while i < items.Length
        if i > 0
            list += ","
        endif
        list += items[i]
        i += 1
    endwhile
    return list

    ; string list = "DD Bondage Chair,DD Bondage Pole,DD Cross,DD Gallow Overhead,DD Gallow Strappado,DD Gallow Hogtied,DD Gallow Upside Down,DD Gallow Horse,"
    ; list = list + "DD Pillory,DD Pillory 2,DD Restraint Post,DD Shackle Wall Iron,DD Torture Pole 1,DD Torture Pole 2,DD Torture Pole 3,DD Torture Pole 4,"
    ; list = list + "DD Torture Pole 5,DD Wooden Horse,DD X Cross"

    ; return list
EndFunction

Activator Function GetFurnitureItem(string itemName) Global

    string path = ".furniture_list." + itemName
    string[] itemArray = JsonUtil.PathStringElements(GetJsonFurnitureFileName(), path)

    ;Debug.MessageBox(path)

    return Game.GetFormFromFile(PO3_SKSEFunctions.StringToInt(itemArray[0]), itemArray[1]) as Activator

    ; string contraptionsFile = "Devious Devices - Contraptions.esm"
    ; If itemName == "DD Bondage Chair"
    ;      return Game.GetFormFromFile(0x07007DB9, contraptionsFile) as Activator ;zadc_BondageChair
    ; ElseIf itemName == "DD Bondage Pole"
    ;     return Game.GetFormFromFile(0x0700845D, contraptionsFile) as Activator ;zadc_BondagePole
    ; ElseIf itemName == "DD Cross"
    ;     return Game.GetFormFromFile(0x07005904, contraptionsFile) as Activator ;zadc_cross
    ; ElseIf itemName == "DD Gallow Overhead"
    ;     return Game.GetFormFromFile(0x07001D96, contraptionsFile) as Activator ;zadc_gallowspole_overhead
    ; ElseIf itemName == "DD Gallow Strappado"
    ;     return Game.GetFormFromFile(0x070063F7, contraptionsFile) as Activator ;zadc_gallowspole_strappado
    ; ElseIf itemName == "DD Gallow Hogtied"
    ;     return Game.GetFormFromFile(0x07008324, contraptionsFile) as Activator ;zadc_gallowspole_suspend_hogtie
    ; ElseIf itemName == "DD Gallow Upside Down"
    ;     return Game.GetFormFromFile(0x07008325, contraptionsFile) as Activator ;zadc_gallowspole_upside_down
    ; ElseIf itemName == "DD Gallow Horse"
    ;     return Game.GetFormFromFile(0x070063F9, contraptionsFile) as Activator ;zadc_gallowspole_woodenhorse
    ; ElseIf itemName == "DD Pillory"
    ;     return Game.GetFormFromFile(0x0700D997, contraptionsFile) as Activator ;zadc_Pillory
    ; ElseIf itemName == "DD Pillory 2"
    ;     return Game.GetFormFromFile(0x07007EF5, contraptionsFile) as Activator ;zadc_Pillory2
    ; ElseIf itemName == "DD Restraint Post"
    ;     return Game.GetFormFromFile(0x070089C4, contraptionsFile) as Activator ;zadc_RestraintPost
    ; ElseIf itemName == "DD Shackle Wall Iron"
    ;     return Game.GetFormFromFile(0x070099F4, contraptionsFile) as Activator ;zadc_ShackleWallIron
    ; ElseIf itemName == "DD Torture Pole 1"
    ;     return Game.GetFormFromFile(0x0700E9E6, contraptionsFile) as Activator ;zadc_TorturePole01
    ; ElseIf itemName == "DD Torture Pole 2"
    ;     return Game.GetFormFromFile(0x0700E9E7, contraptionsFile) as Activator ;zadc_TorturePole02
    ; ElseIf itemName == "DD Torture Pole 3"
    ;     return Game.GetFormFromFile(0x0700E9E8, contraptionsFile) as Activator ;zadc_TorturePole03
    ; ElseIf itemName == "DD Torture Pole 4"
    ;     return Game.GetFormFromFile(0x0700E9E9, contraptionsFile) as Activator ;zadc_TorturePole04
    ; ElseIf itemName == "DD Torture Pole 5"
    ;     return Game.GetFormFromFile(0x0700E9EA, contraptionsFile) as Activator ;zadc_TorturePole05
    ; ElseIf itemName == "DD Wooden Horse"
    ;     return Game.GetFormFromFile(0x07006963, contraptionsFile) as Activator ;zadc_WoodenHorse
    ; ElseIf itemName == "DD X Cross"
    ;     return Game.GetFormFromFile(0x070012C7, contraptionsFile) as Activator ;zadc_xcross


    ; Else
    ;     return none
    ; EndIf

EndFunction

bool Function LockInFurniture(ObjectReference item, Actor a) Global
    zadcLibs zclib = GetZadcLibs()
    return zclib.LockActor(a, item)
EndFunction

bool Function UnlockFromFurniture(Actor a) Global
    zadcLibs zclib = GetZadcLibs()
    return zclib.UnlockActor(a)
EndFunction

bool Function FurnitureSex(Actor inFurnA, Actor a) Global
    zadcLibs zclib = GetZadcLibs()
    return zclib.PlaySexScene(inFurnA, a)
    ;ObjectReference f, 
    ;zadcFurnitureScript furns = f as zadcFurnitureScript
    ;furns.SexScene(a)
EndFunction