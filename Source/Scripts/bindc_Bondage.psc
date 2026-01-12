Scriptname bindc_Bondage extends Quest  

float sleepTime = 0.5
bool bondageSafeAreaFlag = false
bool equippingBondageOutfit = false
;bool createdOutfitLocalFiles = false

string outfitFileNameRaw
string outfitFileNameJson

function LoadGame()

    int saveId = StorageUtil.GetIntValue(none, "bindc_save_id", -1)
    outfitFileNameRaw = "data/skse/plugins/StorageUtilData/binding/games/outfits_" + saveId + ".json"
    outfitFileNameJson = "binding/games/outfits_" + saveId + ".json"

    ; bindc_Util.WriteInformation("outfitFileNameJson: " + outfitFileNameJson)

    ; if !MiscUtil.FileExists(outfitFileNameRaw) && createdOutfitLocalFiles
    ;     createdOutfitLocalFiles = false
    ;     debug.MessageBox("Creating missing outfits file")
    ; endif

    ; if !createdOutfitLocalFiles
    ;     createdOutfitLocalFiles = true
    ;     CreateBondageOutfitFile()
    ; else
    ;     UpdateBondageFile()
    ; endif

    if StorageUtil.GetIntValue(none, "bindc_created_outfits", 0) == 0
        StorageUtil.SetIntValue(none, "bindc_created_outfits", 1)
        CreateBondageOutfitFile()
    endif

endfunction

string function GetOutfitsFileName() ;public
    return outfitFileNameJson
endfunction

bool function IsEquippingBondageOutfit() ;public
    return equippingBondageOutfit
endfunction

bool function ZadKeywordsCheck(Form item)
    bool lockable = item.HasKeyWordString("zad_Lockable")
    bool inventory = item.HasKeyWordString("zad_InventoryDevice")
    bool questItem = item.HasKeywordString("zad_QuestItem")
    bool blockGeneric = item.HasKeyWordString("zad_BlockGeneric")
    bool blockZap = item.HasKeywordString("zbfWornDevice")
    return (lockable || inventory || questItem || blockGeneric || blockZap)
endfunction

function EquipBondageOutfit(Actor a, int setId)

    float sleepWait = 0.1
    equippingBondageOutfit = true

    if setId == -1

        bindc_Util.WriteInformation("EquipBondageOutfit - no outfit found - cleaning DD items off")

        RemoveAllBondageItems(a, false)

        StorageUtil.SetIntValue(a, "bind_wearing_outfit_id", -1) ;NOTE - this is used by the sub alias to determine blocks
        StorageUtil.SetStringValue(a, "bind_wearing_outfit_name", "")

        equippingBondageOutfit = false

        return

    endif

    StorageUtil.SetIntValue(a, "bind_wearing_outfit_id", setId) ;NOTE - this is used by the sub alias to determine blocks
    ;StorageUtil.SetStringValue(a, "bind_wearing_outfit_name", JsonUtil.GetStringValue(outfitFileNameJson, setId + "_bondage_outfit_name", ""))
    StorageUtil.SetStringValue(a, "bind_wearing_outfit_name", StorageUtil.GetStringValue(none, "bindc_outfit_" + setId + "_bondage_outfit_name", ""))

    int i

    Form[] ddRemoveItems = new Form[25]
    Form[] wornBondageItems = bindc_SKSE.GetDeviousInventory(a)
    i = 0
    int removeIdx = 0
    while i < wornBondageItems.Length
        Form f = wornBondageItems[i]
        int bindingItemFlag = StorageUtil.GetIntValue(f, "bindc_item_flag", 0)
        if bindingItemFlag == 1 && a.IsEquipped(f)
            ;debug.MessageBox("item: " + f.GetName() + " binding: " + bindingItemFlag)
            ;StorageUtil.FormListAdd(none, "bindc_remove_dd_list", f, false)
            ddRemoveItems[removeIdx] = f
            removeIdx += 1
        endif
        ;debug.MessageBox("item: " + f.GetName() + " binding: " + bindingItemFlag)
        i += 1
    endwhile

    ;EquippingBondageOutfit = true

    ;int useRulesBased = JsonUtil.GetIntValue(outfitFileNameJson, setId + "_rules_based", 0)
    int useRulesBased = StorageUtil.GetIntValue(none, "bindc_outfit_" + setId + "_rules_based", 0)

    ;NOTE - there is probably no reason to clean this out
    if a.WornHasKeyword(Keyword.GetKeyword("ArmorCuirass")) || a.WornHasKeyword(Keyword.GetKeyword("ClothingBody"))
        StorageUtil.FormListClear(a, "bind_strip_list")
        bindc_Util.WriteInformation("clearing strip buffer")
    else
        bindc_Util.WriteInformation("keeping strip buffer")
    endif

    if StorageUtil.GetIntValue(none, "bindc_outfit_" + setId + "_remove_existing_gear", 0) == 1
    ;if JsonUtil.GetIntValue(outfitFileNameJson, setId + "_remove_existing_gear", 0) == 1
        StorageUtil.FormListClear(a, "bind_strip_list")
        StorageUtil.FormListCopy(a, "bind_strip_list", bindc_SKSE.DoStripActor(a, false))
    endif

    ;add outfits fixed gear (non devious)
    ; Form[] fixedGear = StorageUtil.FormListToArray(none, "bindc_outfit_" + setId + "_fixed_worn_items")
    ; debug.MessageBox(fixedGear)
    ; ;Form[] fixedGear = JsonUtil.FormListToArray(outfitFileNameJson, setId + "_fixed_worn_items")
    ; if (fixedGear.Length > 0) 
    ;     bindc_SKSE.DoDressActor(a, fixedGear)
    ; endif

    ;unequip blocks
    StorageUtil.FormListClear(a, "bind_strip_list_blocked")
    int[] blocks = StorageUtil.IntListToArray(none, "bindc_outfit_" + setId + "_block_slots")
    ;int[] blocks = JsonUtil.IntListToArray(outfitFileNameJson, setId + "_block_slots")
    Form[] removedItems = bindc_SKSE.StripBySlots(a, blocks)
    StorageUtil.FormListCopy(a, "bind_strip_list", removedItems)

    int useRandom = StorageUtil.GetIntValue(none, "bindc_outfit_" + setId + "_use_random_bondage", 0)
    ;int useRandom = JsonUtil.GetIntValue(outfitFileNameJson, setId + "_use_random_bondage", 0)

    Form[] setItems
    Form[] fixedGear = StorageUtil.FormListToArray(none, "bindc_outfit_" + setId + "_fixed_worn_items")

    bindc_Util.WriteInformation("EquipBondageOutfit - userandom: " + userandom)

    if useRandom == 1

        float expirationDate = StorageUtil.GetFloatValue(none, "bindc_outfit_" + setId + "_dynamic_bondage_expires", 0.0)
        ;float expirationDate = JsonUtil.GetFloatValue(outfitFileNameJson, setId + "_dynamic_bondage_expires", 0.0)
        if expirationDate < bindc_Util.GetTime() || JsonUtil.FormListCount(outfitFileNameJson, setId + "_dynamic_bondage_items") == 0
            
            bindc_Util.WriteModNotification("resetting dynamic gear")

            StorageUtil.FormListClear(none, "bindc_outfit_" + setId + "_dynamic_bondage_items")
            StorageUtil.SetFloatValue(none, "bindc_outfit_" + setId + "_dynamic_bondage_expires", bindc_Util.AddTimeToCurrentTime(Utility.RandomInt(3, 24), 0)) ;testing 3-24 hours
            ;JsonUtil.FormListClear(outfitFileNameJson, setId + "_dynamic_bondage_items")
            ;JsonUtil.SetFloatValue(outfitFileNameJson, setId + "_dynamic_bondage_expires", bindc_Util.AddTimeToCurrentTime(Utility.RandomInt(3, 24), 0)) ;testing 3-24 hours

            if useRulesBased == 1
                Form[] randomSetItems = bindc_SKSE.CreateRandomDeviousSet(bindc_dd_all, Utility.RandomInt(1, 3), Utility.RandomInt(1, 4), none)
                StorageUtil.FormListCopy(none, "bindc_outfit_" + setId + "_dynamic_bondage_items", randomSetItems)
                ;JsonUtil.FormListCopy(outfitFileNameJson, setId + "_dynamic_bondage_items", randomSetItems)
                bindc_Util.WriteInformation("random set length: " + randomSetItems.Length)
            else
                int[] chances = StorageUtil.IntListToArray(none, "bindc_outfit_" + setId + "_random_bondage_chance")
                ;int[] chances = JsonUtil.IntListToArray(outfitFileNameJson, setId + "_random_bondage_chance")
                Form[] randomSetItems = bindc_SKSE.CreateRandomDeviousSet(bindc_dd_all, Utility.RandomInt(1, 3), Utility.RandomInt(1, 4), chances)
                StorageUtil.FormListCopy(none, "bindc_outfit_" + setId + "_dynamic_bondage_items", randomSetItems)
                ;JsonUtil.FormListCopy(outfitFileNameJson, setId + "_dynamic_bondage_items", randomSetItems)
                bindc_Util.WriteInformation("random set length: " + randomSetItems.Length)
            endif

        endif

        setItems = StorageUtil.FormListToArray(none, "bindc_outfit_" + setId + "_dynamic_bondage_items")
        ;setItems = JsonUtil.FormListToArray(outfitFileNameJson, setId + "_dynamic_bondage_items")

    else
    
        setItems = StorageUtil.FormListToArray(none, "bindc_outfit_" + setId + "_fixed_bondage_items")
        ;setItems = JsonUtil.FormListToArray(outfitFileNameJson, setId + "_fixed_bondage_items")

    endif

    bindc_Util.WriteInformation("EquipBondageOutfit - items: " + "bindc_outfit_" + setItems)

    Form[] tempItems = new Form[25] ;form list copy was failing on this - maybe a papyrusutil issue?
    int idx = 0

    ;debug.MessageBox(setItems)

    int leaveBondageItems = StorageUtil.GetIntValue(none, "bindc_outfit_" + setId + "_leave_bondage_items", 0)
    ;int leaveBondageItems = JsonUtil.GetIntValue(outfitFileNameJson, setId + "_leave_bondage_items", 0)

    ; Form[] wornBondageItems
    ; if leaveBondageItems == 1
    ;     wornBondageItems = StorageUtil.FormListToArray(a, "binding_worn_bondage_items")
    ;     debug.MessageBox(wornBondageItems)
    ; endif

    bool safeArea = (StorageUtil.GetIntValue(none, "bindc_safe_area", 1) == 2)

    if setItems != none
        i = 0
        while i < setItems.Length
            Form dev = setItems[i]
            if dev

                bool addThisItem = false
                bool blocked = false
                int option = -1

                if StorageUtil.GetIntValue(none, "bindc_slavery_running", 0) > 0
                    if StorageUtil.GetIntValue(a, "bindc_temp_gag_removal", 0) > 0
                        if dev.HasKeyWordString("zbfWornGag")
                            blocked = true
                        endif
                        if dev.HasKeywordString("zad_InventoryDevice")
                            Armor rDev = data_script.zlib.GetRenderedDevice(dev as Armor)
                            if rDev.HasKeywordString("zad_DeviousGag")
                                blocked = true
                            endif
                        endif
                        bindc_Util.WriteInternalMonologue("I am not being gagged again yet...")
                    endif
                endif

                if !blocked
                    if useRulesBased == 1
                        ;int brule = -1
                        Armor renderedItem = data_script.zlib.GetRenderedDevice(dev as Armor)
                        int brule = bindc_SKSE.FindRule(renderedItem)                  
                        ;debug.MessageBox(brule)
                        if brule > -1                            
                            if (data_script.RulesScript.GetBondageRule(a, brule) == 1)
                                int bopt = data_script.RulesScript.GetBondageRuleOption(a, brule)
                                if (bopt == 0 || bopt == data_script.RulesScript.RULE_OPTION_PERMANENT || (safeArea && (bopt == data_script.RulesScript.RULE_OPTION_SAFE_AREAS || bopt == data_script.RulesScript.RULE_OPTION_PERMANENT_SAFE_AREAS)) || (!safeArea && (bopt == data_script.RulesScript.RULE_OPTION_UNSAFE_AREAS || bopt == data_script.RulesScript.RULE_OPTION_PERMANENT_UNSAFE_AREAS)))
                                    tempItems[idx] = dev as Form
                                    idx += 1
                                endif
                            endif
                        endif
                    else
                        tempItems[idx] = dev as Form
                        idx += 1
                    endif  
                endif   

            endif
            i += 1
        endwhile
        ; if wornBondageItems.Length > 0
        ;     ;append last set if keeping items
        ;     i = 0
        ;     while i < wornBondageItems.Length
        ;         Form f = wornBondageItems[i]
        ;         tempItems[idx] = f
        ;         idx += 1
        ;         i += 1
        ;     endwhile
        ; endif
    endif

    ;debug.MessageBox(tempItems)

    bindc_Util.WriteInformation("equipbondageoutfit - actor: " + a.GetDisplayName())
    bindc_Util.WriteInformation("equipbondageoutfit - tempitems: " + tempItems)

    ;dat.ProtectSltr = 1 ;for testing - add to mcm

    int ProtectSltr = data_script.Preference_ProtectSltr
    int RemoveUsedItems = data_script.Preference_CleanUpNonBindingItemsFromBags

    ;bindc_SKSE.EquipBondageOutfit(a, tempItems, (ProtectSltr == 1 && a == Game.GetPlayer()), leaveBondageItems == 1)

    ;debug.MessageBox(ddRemoveItems)
    bindc_SKSE.EquipBondageOutfit2(a, tempItems, ddRemoveItems)

    ; StorageUtil.SetIntValue(a, "bind_wearing_outfit_id", setId) ;NOTE - this is used by the sub alias to determine blocks
    ; StorageUtil.SetStringValue(a, "bind_wearing_outfit_name", JsonUtil.GetStringValue(outfitFileNameJson, setId + "_bondage_outfit_name", ""))

    bindc_Util.DoSleep(2.0)

    ;debug.MessageBox(fixedGear)
    ;Form[] fixedGear = JsonUtil.FormListToArray(outfitFileNameJson, setId + "_fixed_worn_items")
    if (fixedGear.Length > 0) 
        bindc_SKSE.DoDressActor(a, fixedGear)
    endif

    int handle = ModEvent.Create("bindc_BondageOutfitEquipped")
    if handle
        ModEvent.Send(handle)
    endif

    ;if (leaveBondageItems == 0)
        StorageUtil.FormListClear(a, "binding_worn_bondage_items")
    ;endif    

    StorageUtil.FormListCopy(a, "binding_worn_bondage_items", tempItems)

    if RemoveUsedItems == 1
        bindc_SKSE.CleanUnusedBondageItemsFromInventory(a)
    endif

    ;the stored outfit id bindc_outfit_id is the desired outfit, which is not set here
    ;this stores the currently equipped outfit, used on aliases for strip functions
    StorageUtil.SetIntValue(a, "bindc_equipped_outfit_id", setId) 

    ;EquippingBondageOutfit = false
    equippingBondageOutfit = false

endfunction

Form function FindRandomItem(string fileName, string resultsFileName, string searchString, int setId)
    Form[] items = bindc_SKSE.SearchDeviousByKeywords(bindc_dd_all, searchString) ; SearchDeviousItems(searchString)
    ;debug.MessageBox("search: " + searchString + " results: " + items)
    Form dev = items[Utility.RandomInt(0, items.Length - 1)] ;JsonUtil.FormListRandom(resultsFileName, "found_items")
    if dev != none
        bindc_Util.WriteInformation("FindRandomItem: " + dev.GetName())
        JsonUtil.FormListAdd(fileName, setId + "_dynamic_bondage_items", dev)
    endif
    bindc_Util.DoSleep()
    return dev
endfunction

int function GetBondageSetForLocation(Actor akActor, Location currentLocation, int currentBondageSet)

    string outfitKey = ""
    int[] outfitIds

    bool isSafeArea = false

    ; if !JsonUtil.IntListHas(bondageOutfitsFile, "enabled_oufits", currentBondageSet)
    ;     ;check to see if the current set is still enabled
    ;     currentBondageSet = -1
    ; endif

    StorageUtil.StringListClear(akActor, "binding_location_tags")

    if currentLocation.HasKeywordString("LocTypePlayerHouse")
        isSafeArea = true
        outfitKey = "location_player_home"
        StorageUtil.StringListAdd(akActor, "binding_location_tags", outfitKey)
    endif

    if currentLocation.HasKeywordString("LocTypeInn")
        isSafeArea = true
        outfitKey = "location_inn"
        StorageUtil.StringListAdd(akActor, "binding_location_tags", outfitKey)
    endif

    bool buildingInCity = false
    bool buildingInTown = false
    if outfitIds.Length == 0
        if currentLocation.HasKeywordString("LocTypeDwelling") || currentLocation.HasKeywordString("LocTypeStore") || currentLocation.HasKeywordString("LocTypeTemple") || currentLocation.HasKeywordString("LocTypeBarracks") || currentLocation.HasKeywordString("LocTypeCastle") || currentLocation.HasKeywordString("LocTypeJail")
            isSafeArea = true
            Location parentLoc = currentLocation.GetParent()
            if parentLoc.HasKeywordString("LocTypeTown")
                ;debug.MessageBox("building in town")
                buildingInTown = true
            elseif parentLoc.HasKeywordString("LocTypeCity")
                ;debug.MessageBox("buildling in city")
                buildingInCity = true
                ;TODO - figure out the best way to do this by city, i.e. location_riften
            endif 
        endif
    endif

    if currentLocation.HasKeywordString("LocTypeTown") || buildingInTown
        isSafeArea = true
        outfitKey = "location_towns"
        StorageUtil.StringListAdd(akActor, "binding_location_tags", outfitKey)
    endif
    
    if currentLocation.HasKeywordString("LocTypeCity") || buildingInCity
        isSafeArea = true
        outfitKey = ""
        string locationName = currentLocation.GetName()
        if buildingInCity
            Location parentLoc = currentLocation.GetParent()
            locationName = parentLoc.GetName()
        endif
        if locationName == "Dawnstar"
            outfitKey = "location_dawnstar"
        elseif locationName == "Falkreath"
            outfitKey = "location_falkreath"
        elseif locationName == "Windhelm"
            outfitKey = "location_windhelm"
        elseif locationName == "Markarth"
            outfitKey = "location_markarth"
        elseif locationName == "Morthal"
            outfitKey = "location_morthal"
        elseif locationName == "Riften"
            outfitKey = "location_riften"
        elseif locationName == "Solitude"
            outfitKey = "location_solitude"
        elseif locationName == "High Hrothgar"
            outfitKey = "location_high_hrothgar"
        elseif locationName == "Whiterun"
            outfitKey = "location_whiterun"
        elseif locationName == "Winterhold"
            outfitKey = "location_winterhold"
        elseif locationName == "Raven Rock"
            outfitKey = "location_raven Rock"  
        endif
        if outfitKey != ""
            StorageUtil.StringListAdd(akActor, "binding_location_tags", outfitKey)
        endif
    endif

    if (currentLocation.HasKeywordString("LocTypeCity") || buildingInCity)
        isSafeArea = true
        outfitKey = "location_any_city"
        StorageUtil.StringListAdd(akActor, "binding_location_tags", outfitKey)
    endif

    if isSafeArea
        ;debug.MessageBox("safe area")
        outfitKey = "location_safe_area"
        StorageUtil.StringListAdd(akActor, "binding_location_tags", outfitKey)
    elseif !isSafeArea && outfitIds.Length == 0
        ;dangerous area
        ;debug.MessageBox("unsafe area")
        outfitKey = "location_unsafe_area"
        StorageUtil.StringListAdd(akActor, "binding_location_tags", outfitKey)
    endif

    StorageUtil.StringListAdd(akActor, "binding_location_tags", "location_all_areas")

    string[] locTagList = StorageUtil.StringListToArray(akActor, "binding_location_tags")

    ;debug.MessageBox(locTagList)
    bindc_Util.WriteInformation("search for tags: " + locTagList)

    ;string[] fList = MiscUtil.FilesInFolder(dat.GameSaveFolder)

    ;int[] outfitIdList = JsonUtil.IntListToArray(outfitFileNameJson, "outfit_id_list")
    int[] outfitIdList = StorageUtil.IntListToArray(none, "bindc_outfit_id_list")

    bool foundOutfits = false
    bool outfitValid = false

    StorageUtil.IntListClear(akActor, "binding_found_outfit_id_list")

    int i = 0
    int i2 = 0
    while i < locTagList.Length
        string tag = locTagList[i]
        i2 = 0
        while i2 < outfitIdList.Length
            if StorageUtil.StringListHas(none, "bindc_outfit_" + outfitIdList[i2] + "_used_for", tag)
                if StorageUtil.GetIntValue(none, "bindc_outfit_" + outfitIdList[i2] + "_outfit_enabled", 0) == 1
            ; if JsonUtil.StringListHas(outfitFileNameJson, outfitIdList[i2] + "_used_for", tag)
            ;     if JsonUtil.GetIntValue(outfitFileNameJson, outfitIdList[i2] + "_outfit_enabled", 0) == 1
                    ;debug.MessageBox(fList[i2])
                    bindc_Util.WriteInformation("found: " + outfitIdList[i2])
                    int outfitId = outfitIdList[i2]; JsonUtil.GetIntValue(outfitFileNameJson, outfitIdList[i2] + "_outfit_id", -1)
                    if outfitId == currentBondageSet
                        outfitValid = true
                    endif
                    StorageUtil.IntListAdd(akActor, "binding_found_outfit_id_list", outfitId)
                    foundOutfits = true
                endif
            endif
            i2 += 1
        endwhile
        i += 1
        if foundOutfits
            i = 500 ;break the loop on this tag
        endif
    endwhile

    if outfitValid
        return currentBondageSet
    endif

    int[] list = StorageUtil.IntListToArray(akActor, "binding_found_outfit_id_list")

    bondageSafeAreaFlag = isSafeArea

    return list[Utility.RandomInt(0, list.Length - 1)]

    ;return outfitIds[Utility.RandomInt(0, outfitIds.Length - 1)]

endfunction

int function GetBondageOutfitForEvent(Actor akActor, string eventName)

    ;int[] outfitIdList = JsonUtil.IntListToArray(outfitFileNameJson, "outfit_id_list")
    int[] outfitIdList = StorageUtil.IntListToArray(none, "bindc_outfit_id_list")

    ;debug.MessageBox(outfitIdList)

    bool foundOutfits = false
    bool outfitValid = false

    StorageUtil.IntListClear(akActor, "binding_found_outfit_id_list")

    int i = 0

    while i < outfitIdList.Length
        if StorageUtil.StringListHas(none, "bindc_outfit_" + outfitIdList[i] + "_used_for", eventName)
            if StorageUtil.GetIntValue(none, "bindc_outfit_" + outfitIdList[i] + "_outfit_enabled", 0) == 1
        ; if JsonUtil.StringListHas(outfitFileNameJson, outfitIdList[i] + "_used_for", eventName)
        ;     if JsonUtil.GetIntValue(outfitFileNameJson, outfitIdList[i] + "_outfit_enabled", 0) == 1
                ;debug.MessageBox(fList[i2])
                bindc_Util.WriteInformation("found: " + outfitIdList[i])
                int outfitId = outfitIdList[i]; JsonUtil.GetIntValue(main.Outfit_FileName, outfitIdList[i2] + "_outfit_id", -1)
                StorageUtil.IntListAdd(akActor, "binding_found_outfit_id_list", outfitId)
                foundOutfits = true
            endif
        endif
        i += 1
    endwhile

    int[] list = StorageUtil.IntListToArray(akActor, "binding_found_outfit_id_list")

    return list[Utility.RandomInt(0, list.Length - 1)]

endfunction

bool function RemoveGag(Actor akActor)

    bool result = false

    Form[] wornItems = StorageUtil.FormListToArray(akActor, "binding_worn_bondage_items")
    debug.MessageBox("worn items: " + wornItems)

    if wornItems.Length > 0
        int i = 0
        while i < wornItems.Length
            Armor dev = wornItems[i] as Armor
            ;todo - add if for binding storageutil flag
            if dev

                debug.MessageBox(dev.GetName())

                if dev.HasKeyWordString("zbfWornGag")
                    if akActor.IsEquipped(dev)
                        akActor.UnequipItemEx(dev)
                        bindc_Util.DoSleep(sleepTime)
                        bindc_Util.WriteInformation("RemoveGag - removing stored item: " + dev)    
                        i = 500 ;break
                        result = true
                    endif
                endif

                if dev.HasKeywordString("zad_InventoryDevice")
                    Armor rDev = data_script.zlib.GetRenderedDevice(dev)
                    debug.MessageBox(rDev)
                    if rDev.HasKeywordString("zad_DeviousGag")
                        if data_script.zlib.UnlockDevice(akActor, dev, none, none, true)
                            bindc_Util.DoSleep(sleepTime)
                            
                            if akActor.IsEquipped(rDev)
                                debug.MessageBox("rendered was not removed. removing.")
                                akActor.UnequipItemEx(rDev)
                                bindc_Util.DoSleep(sleepTime)
                            endif
                            bindc_Util.WriteInformation("RemoveGag - removing stored item: " + dev)    
                            i = 500 ;break    
                            result = true        
                        endif
                    endif
                endif
                
            endif
            i += 1
        endwhile
    endif

    return result

endfunction

bool function RemoveAllBondageItems(Actor akActor, bool nonBindingItems = true)

    if nonBindingItems
        bindc_SKSE.UnequipAllBondage(akActor)
        return true
    endif
        
    ;bindc_item_flag

    Form[] wornItems = StorageUtil.FormListToArray(akActor, "binding_worn_bondage_items") ;todo - remove this logic
    ;debug.MessageBox(wornItems)

    int i

    ;todo - use skse function to get all bondage items

    if wornItems
        i = 0
        while i < wornItems.Length
            Armor dev = wornItems[i] as Armor
            ;todo - add if for binding storageutil flag
            if dev
                if dev.HasKeyWordString("zbfWornDevice")
                    akActor.UnequipItemEx(dev)
                    bindc_Util.DoSleep(sleepTime)
                else
                    if data_script.zlib.UnlockDevice(akActor, dev, none, none, true)
                        bindc_Util.DoSleep(sleepTime)
                        Armor rDev = data_script.zlib.GetRenderedDevice(dev)
                        if akActor.IsEquipped(rDev)
                            debug.MessageBox("rendered was not removed. removing.")
                            akActor.UnequipItemEx(rDev)
                            bindc_Util.DoSleep(sleepTime)
                        endif
                        bindc_Util.WriteInformation("RemoveAllBondageItems - removing stored item: " + dev)                
                    endif
                endif
                
            endif
            i += 1
        endwhile
    endif

    StorageUtil.FormListClear(akActor, "binding_worn_bondage_items")

    return true

endfunction

int[] function CreateBlocksArray(bool leaveShoes = false)
    int[] blocks
    if leaveShoes
        blocks = new int[12]
    else
        blocks = new int[13]
    endif
    blocks[0] =	4
	blocks[1] =	16
	blocks[2] =	65536
	blocks[3] =	524288
	blocks[4] =	8388608
	blocks[5] =	134217728
	blocks[6] =	268435456
	blocks[7] =	8
	blocks[8] =	67108864
	blocks[9] =	4194304
	blocks[10] = 16777216
	blocks[11] = 536870912
    if !leaveShoes
        blocks[12] = 128
    endif
    return blocks
endfunction

int[] function CreateChancesArray(bool random = false)
    int[] chances = new int[13]
    if random
        chances[0] = Utility.RandomInt(0, 100)
        chances[1] = Utility.RandomInt(0, 100)
        chances[2] = Utility.RandomInt(0, 100)
        chances[3] = Utility.RandomInt(0, 100)
        chances[4] = Utility.RandomInt(0, 100)
        chances[5] = Utility.RandomInt(0, 100)
        chances[6] = Utility.RandomInt(0, 100)
        chances[7] = Utility.RandomInt(0, 100)
        chances[8] = Utility.RandomInt(0, 100)
        chances[9] = Utility.RandomInt(0, 100)
        chances[10] = Utility.RandomInt(0, 100)
        chances[11] = Utility.RandomInt(0, 100)
        chances[12] = Utility.RandomInt(0, 100)
    else
        int i = 0
        while i < 13
            chances[i] = 0
            i += 1
        endwhile
    endif
    return chances
endfunction

function CreateOutfit(int outfitId, string outfitName, int blockClothing, int allowShoes, int useRandom, int rulesBased, int removeExistingGear, int leaveBondageItems, string usedFor, string usedFor2 = "", FormList fixedItems = none)

    StorageUtil.IntListAdd(none, "bindc_outfit_id_list", outfitId)
    StorageUtil.StringListAdd(none, "bindc_outfit_name_list", outfitName)

    StorageUtil.SetStringValue(none, "bindc_outfit_" + outfitId + "_bondage_outfit_name", outfitName)
    StorageUtil.SetFloatValue(none, "bindc_outfit_" + outfitId + "_dynamic_bondage_expires", 0.0)

    StorageUtil.SetIntValue(none, "bindc_outfit_" + outfitId + "_use_random_bondage", useRandom)
    StorageUtil.SetIntValue(none, "bindc_outfit_" + outfitId + "_rules_based", rulesBased)
    StorageUtil.SetIntValue(none, "bindc_outfit_" + outfitId + "_outfit_enabled", 1)
    StorageUtil.SetIntValue(none, "bindc_outfit_" + outfitId + "_remove_existing_gear", removeExistingGear)
    StorageUtil.SetIntValue(none, "bindc_outfit_" + outfitId + "_leave_bondage_items", leaveBondageItems)

    if blockClothing == 1
        StorageUtil.IntListClear(none, "bindc_outfit_" + outfitId + "_block_slots")
        StorageUtil.IntListCopy(none, "bindc_outfit_" + outfitId + "_block_slots", CreateBlocksArray(allowShoes == 1))
    endif

    StorageUtil.FormListClear(none, "bindc_outfit_" + outfitId + "_fixed_bondage_items")
    int i = 0
    if fixedItems != none
        while i < fixedItems.GetSize()
            StorageUtil.FormListAdd(none, "bindc_outfit_" + outfitId + "_fixed_bondage_items", fixedItems.GetAt(i))
            i += 1
        endwhile
    endif

    StorageUtil.StringListClear(none, "bindc_outfit_" + outfitId + "_used_for")
    StorageUtil.StringListAdd(none, "bindc_outfit_" + outfitId + "_used_for", usedFor)
    if usedFor2 != ""
    StorageUtil.StringListAdd(none, "bindc_outfit_" + outfitId + "_used_for", usedFor2)
    endif

    StorageUtil.IntListClear(none, "bindc_outfit_" + outfitId + "_random_bondage_chance")
    StorageUtil.IntListCopy(none, "bindc_outfit_" + outfitId + "_random_bondage_chance", CreateChancesArray(useRandom && !rulesBased))

endfunction

function CreateBondageOutfitFile()

    StorageUtil.IntListClear(none, "bindc_outfit_id_list")
    StorageUtil.StringListClear(none, "bindc_outfit_name_list")

    CreateOutfit(1000, "Safe Areas Outfit", 1, 1, 0, 1, 0, 0, "location_safe_area", "", bindc_OutfitSafeAreas)
    CreateOutfit(1001, "Hogtied Outfit", 1, 0, 0, 0, 1, 0, "event_bound_sleep", "event_hogtied", bindc_OutfitHogtied)
    CreateOutfit(1002, "Harsh Bondage Outfit", 1, 0, 0, 0, 1, 0, "event_harsh_bondage", "", bindc_OutfitHarshBondage)
    CreateOutfit(1003, "All Areas Outfit", 0, 0, 0, 0, 0, 0, "location_all_areas", "", bindc_OutfitAllAreas)
    CreateOutfit(1004, "All Events Outfit", 1, 0, 0, 0, 1, 0, "event_any_event", "", bindc_OutfitAllEvents)

endfunction

; function UpdateBondageFile()

;     ;TODO - make this add and remove outfits???
;     ;this would be good for swapping outfit types on the fly (always bound, rules, etc.)

;     string templateFolder = "data/skse/plugins/StorageUtilData/binding/templates/outfits/"
;     string templateFolderJson = "binding/templates/outfits/"

;     string[] fList = MiscUtil.FilesInFolder(templateFolder)
;     int outfitCount = JsonUtil.IntListCount(outfitFileNameJson, "outfit_id_list")

;     if fList.Length > outfitCount ;add outfits
;         int i = 0
;         while i < fList.Length
;             int outfitId = JsonUtil.GetIntValue(templateFolderJson + fList[i], "outfit_id")
;             string outfitName = JsonUtil.GetStringValue(templateFolderJson + fList[i], "bondage_outfit_name")

;             if !JsonUtil.IntListHas(outfitFileNameJson, "outfit_id_list", outfitId)

;                 Debug.Notification("Adding outfit " + outfitId)

;                 JsonUtil.IntListAdd(outfitFileNameJson, "outfit_id_list", outfitId)
;                 JsonUtil.StringListAdd(outfitFileNameJson, "outfit_name_list", outfitName)
;                 JsonUtil.SetFloatValue(outfitFileNameJson, outfitId + "_dynamic_bondage_expires", 0.0)
;                 JsonUtil.FormListCopy(outfitFileNameJson, outfitId + "_dynamic_bondage_items", JsonUtil.FormListToArray(templateFolderJson + fList[i], "dynamic_bondage_items"))
;                 JsonUtil.FormListCopy(outfitFileNameJson, outfitId + "_fixed_bondage_items", JsonUtil.FormListToArray(templateFolderJson + fList[i], "fixed_bondage_items"))
;                 JsonUtil.SetIntValue(outfitFileNameJson, outfitId + "_outfit_enabled", JsonUtil.GetIntValue(templateFolderJson + fList[i], "outfit_enabled"))
;                 JsonUtil.SetIntValue(outfitFileNameJson, outfitId + "_remove_existing_gear", JsonUtil.GetIntValue(templateFolderJson + fList[i], "remove_existing_gear"))
;                 JsonUtil.SetIntValue(outfitFileNameJson, outfitId + "_use_random_bondage", JsonUtil.GetIntValue(templateFolderJson + fList[i], "use_random_bondage"))
;                 JsonUtil.IntListCopy(outfitFileNameJson, outfitId + "_block_slots", JsonUtil.IntListToArray(templateFolderJson + fList[i], "block_slots"))
;                 JsonUtil.IntListCopy(outfitFileNameJson, outfitId + "_random_bondage_chance", JsonUtil.IntListToArray(templateFolderJson + fList[i], "random_bondage_chance"))
;                 JsonUtil.StringListCopy(outfitFileNameJson, outfitId + "_used_for", JsonUtil.StringListToArray(templateFolderJson + fList[i], "used_for"))
;                 JsonUtil.SetStringValue(outfitFileNameJson, outfitId + "_bondage_outfit_name", JsonUtil.GetStringValue(templateFolderJson + fList[i], "bondage_outfit_name"))

;             endif
            
;             i += 1
;         endwhile
;     endif

; endfunction

bool function IsBound(Actor akActor)
    if akActor.WornHasKeyword(data_script.zlib.zad_DeviousHeavyBondage) ;todo - add zbf hands bound or correct keyword?
        return true
    else 
        return false
    endif
endfunction

bool function IsGagged(Actor akActor)
    if akActor.WornHasKeyword(data_script.zlib.zad_DeviousGag) ;todo - add zbf gags
        return true
    else 
        return false
    endif
endfunction

function ToggleGaggedEffect(Actor akActor)
    if IsGagged(akActor)
        int removed = StorageUtil.GetIntValue(akActor, "bindc_removed_gag_effect", 0)
        if removed == 0
            StorageUtil.SetIntValue(akActor, "bindc_removed_gag_effect", 1)
            data_script.zgqs.canTalk = true
        else
            StorageUtil.SetIntValue(akActor, "bindc_removed_gag_effect", 0)
            data_script.zgqs.canTalk = false
        endif
    endif
endfunction

;*********************************************************************************
;outfit functions
;*********************************************************************************
function LearnWornDdItemsToSet(Actor theSub, int outfitId)

    GoToState("WorkingState")

    string outfitFile = GetOutfitsFileName()

    JsonUtil.FormListClear(outfitFile, outfitId + "_fixed_bondage_items")

	Form[] inventory = theSub.GetContainerForms()
	int i = 0
    int kwi = 0
	while i < inventory.Length
        Form dev = inventory[i]
        if (dev.HasKeyWord(data_script.zlib.zad_inventoryDevice) || dev.HasKeywordString("zbfWornDevice")) && theSub.IsEquipped(dev)
            bindc_Util.WriteInformation("found zad_inventoryDevice: " + dev)
            if dev.HasKeyWord(data_script.zlib.zad_QuestItem) || dev.HasKeyWord(data_script.zlib.zad_BlockGeneric)
                bindc_Util.WriteInformation("quest or blocking device")
            else
                JsonUtil.FormListAdd(outfitFile, outfitId + "_fixed_bondage_items", dev, false)
            endif
        endif
        i += 1
    endwhile

    JsonUtil.Save(outfitFile)

    GoToState("")

endfunction

state WorkingState

    function LearnWornDdItemsToSet(Actor theSub, int outfitId)
    endfunction

endstate

;zadLibs property zlib auto

bindc_Data property data_script auto

FormList property bindc_dd_all auto

FormList property bindc_OutfitHarshBondage auto
FormList property bindc_OutfitHogtied auto
FormList property bindc_OutfitSafeAreas auto
FormList property bindc_OutfitAllAreas auto
FormList property bindc_OutfitAllEvents auto