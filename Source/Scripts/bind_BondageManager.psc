Scriptname bind_BondageManager extends Quest conditional

int property HarshBondageUseBoots auto conditional
int property HarshBondageUseAnkles auto conditional
int property HarshBondageUseCollar auto conditional
int property HarshBondageUseNipple auto conditional
int property HarshBondageUseChastity auto conditional
int property HarshBondageUseBlindfold auto conditional
int property HarshBondageUseHood auto conditional

int property BedtimeUseHood auto conditional

string property ActiveBondageSet auto conditional

string property LastAddedItemName auto conditional

bool property EquippingBondageOutfit auto conditional

; int property CurrentFavoriteSet auto conditional
; int property UseFavoriteSet auto conditional
; float property CurrentFavoriteSetEndTime auto conditional

string[] bondageTypes

float sleepTime = 0.5

bind_BondageManager function GetBondageManager() global 
    return Quest.GetQuest("bind_MainQuest") as bind_BondageManager
endfunction

Actor theSubRef

bool setupOutfitUsedArray
bool createdOutfitLocalFiles = false

Function LoadGame(bool rebuildStorage = false)
    
    theSubRef = Game.GetPlayer()

    ;createdOutfitLocalFiles = false ;remove this

    ;StorageUtil.StringListClear(theSubRef, "bind_bondage_outfit_file_list")

    if !MiscUtil.FileExists("data/skse/plugins/StorageUtilData/binding/games/outfits_" + main.SaveGameUid + ".json") && createdOutfitLocalFiles
        createdOutfitLocalFiles = false
        debug.MessageBox("Creating missing outfits file")
    endif

    if !createdOutfitLocalFiles

        createdOutfitLocalFiles = true

        CreateBondageOutfitFile()

    else

        ; string[] fList = MiscUtil.FilesInFolder(main.GameSaveFolder)
        ; int i = 0
        ; while i < fList.Length
        ;     StorageUtil.StringListAdd(theSubRef, "bind_bondage_outfit_file_list", fList[i])
        ;     i += 1
        ; endwhile

    endif

    if bondageTypes.Length != 18
        bondageTypes = new string[18]
        bondageTypes[0] = "Ankle Shackles"
        bondageTypes[1] = "Arm Cuffs"
        bondageTypes[2] = "Blindfold"
        bondageTypes[3] = "Boots"
        bondageTypes[4] = "Belt"
        bondageTypes[5] = "Collar"
        bondageTypes[6] = "Corset"
        bondageTypes[7] = "Gag"
        bondageTypes[8] = "Gloves"
        bondageTypes[9] = "Harness"
        bondageTypes[10] = "Binder"
        bondageTypes[11] = "Hood"
        bondageTypes[12] = "Leg Cuffs"
        bondageTypes[13] = "N Piercing"
        bondageTypes[14] = "V Piercing"
        bondageTypes[15] = "A Plug"
        bondageTypes[16] = "V Plug"
        bondageTypes[17] = "Suit"
    endif

EndFunction

function CreateBondageOutfitFile()
    string templateFolder = "data/skse/plugins/StorageUtilData/binding/templates/outfits/"
    string templateFolderJson = "binding/templates/outfits/"

    string[] fList = MiscUtil.FilesInFolder(templateFolder)
    int i = 0
    while i < fList.Length
        int outfitId = JsonUtil.GetIntValue(templateFolderJson + fList[i], "outfit_id")
        string outfitName = JsonUtil.GetStringValue(templateFolderJson + fList[i], "bondage_outfit_name")

        JsonUtil.IntListAdd(main.BindingGameOutfitFile, "outfit_id_list", outfitId)
        JsonUtil.StringListAdd(main.BindingGameOutfitFile, "outfit_name_list", outfitName)

        JsonUtil.SetFloatValue(main.BindingGameOutfitFile, outfitId + "_dynamic_bondage_expires", 0.0)

        JsonUtil.FormListCopy(main.BindingGameOutfitFile, outfitId + "_dynamic_bondage_items", JsonUtil.FormListToArray(templateFolderJson + fList[i], "dynamic_bondage_items"))
        JsonUtil.FormListCopy(main.BindingGameOutfitFile, outfitId + "_fixed_bondage_items", JsonUtil.FormListToArray(templateFolderJson + fList[i], "fixed_bondage_items"))

        JsonUtil.SetIntValue(main.BindingGameOutfitFile, outfitId + "_outfit_enabled", JsonUtil.GetIntValue(templateFolderJson + fList[i], "outfit_enabled"))
        JsonUtil.SetIntValue(main.BindingGameOutfitFile, outfitId + "_remove_existing_gear", JsonUtil.GetIntValue(templateFolderJson + fList[i], "remove_existing_gear"))
        JsonUtil.SetIntValue(main.BindingGameOutfitFile, outfitId + "_use_random_bondage", JsonUtil.GetIntValue(templateFolderJson + fList[i], "use_random_bondage"))

        JsonUtil.IntListCopy(main.BindingGameOutfitFile, outfitId + "_block_slots", JsonUtil.IntListToArray(templateFolderJson + fList[i], "block_slots"))
        JsonUtil.IntListCopy(main.BindingGameOutfitFile, outfitId + "_random_bondage_chance", JsonUtil.IntListToArray(templateFolderJson + fList[i], "random_bondage_chance"))

        JsonUtil.StringListCopy(main.BindingGameOutfitFile, outfitId + "_used_for", JsonUtil.StringListToArray(templateFolderJson + fList[i], "used_for"))

        JsonUtil.SetStringValue(main.BindingGameOutfitFile, outfitId + "_bondage_outfit_name", JsonUtil.GetStringValue(templateFolderJson + fList[i], "bondage_outfit_name"))

        i += 1
    endwhile

    JsonUtil.Save(main.BindingGameOutfitFile)
endfunction

string function DDVersionString()
    return zlib.GetVersionString()
endfunction

Int Function GetDayOfWeek() Global
	return (Math.Floor(Utility.GetCurrentGameTime()) as int) % 7
EndFunction

; Form function RandomEquip(Actor a, FormList fl) 
;     Form dev = fl.GetAt(Utility.RandomInt(0, fl.GetSize() - 1))
;     if dev
;         ; AddSpecificItem(a, dev as Armor)
;         ; bind_Utility.DoSleep(0.5)
;         return dev
;     else
;         return none
;     endif
; endfunction

bool function ZadKeywordsCheck(Form item)
    bool lockable = item.HasKeyWordString("zad_Lockable")
    bool inventory = item.HasKeyWordString("zad_InventoryDevice")
    bool questItem = item.HasKeywordString("zad_QuestItem")
    bool blockGeneric = item.HasKeyWordString("zad_BlockGeneric")
    return (lockable || inventory || questItem || blockGeneric)
endfunction

function EquipBondageOutfit(Actor a, int setId)

    ; if StorageUtil.GetIntValue(a, "bind_wearing_outfit_id") == setId
    ;     debug.MessageBox("this should not happen??")
    ; endif

    float sleepWait = 0.1

    if setId == -1

        bind_Utility.WriteToConsole("EquipBondageOutfit - no outfit found - cleaning DD items off")

        RemoveAllBondageItems(a, false)

        StorageUtil.SetIntValue(a, "bind_wearing_outfit_id", -1) ;NOTE - this is used by the sub alias to determine blocks
        StorageUtil.SetStringValue(a, "bind_wearing_outfit_name", "")

        return

    endif

    int i

    EquippingBondageOutfit = true

    ;string f = main.GameSaveFolderJson + "bind_bondage_outfit_" + setId + ".json"

    ;NOTE - there is probably no reason to clean this out
    if a.WornHasKeyword(Keyword.GetKeyword("ArmorCuirass")) || a.WornHasKeyword(Keyword.GetKeyword("ClothingBody"))
        StorageUtil.FormListClear(a, "bind_strip_list")
        bind_Utility.WriteToConsole("clearing strip buffer")
    else
        bind_Utility.WriteToConsole("keeping strip buffer")
    endif

    ;bind_Utility.WriteToConsole("EquipBondageOutfit f: " + f)

    RemoveAllBondageItems(a, false)

    if JsonUtil.GetIntValue(main.BindingGameOutfitFile, setId + "_remove_existing_gear", 0) == 1
        Form[] inventory = a.GetContainerForms()
        i = 0
        while i < inventory.Length
            Form item = inventory[i]
            If item.IsPlayable()
                if a.IsEquipped(item) && !ZadKeywordsCheck(item) && !item.HasKeyWordString("sexlabnostrip")
                    if !((item as Armor).IsJewelry())
                        a.UnequipItem(item, false, true)
                        bind_Utility.DoSleep(sleepWait)
                        bind_Utility.WriteToConsole("EquipBondageOutfit - removing: " + item)
                        StorageUtil.FormListAdd(a, "bind_strip_list", item, false)
                    endif
                endif
            endif
            i += 1
        endwhile
    else
        ;note - no need to do this if all existing gear is being removed
        ;unequip blocks
        StorageUtil.FormListClear(a, "bind_strip_list_blocked")
        int[] blocks = JsonUtil.IntListToArray(main.BindingGameOutfitFile, setId + "_block_slots")
        i = 0
        while i < blocks.Length
            Armor item = a.GetWornForm(blocks[i]) as Armor
            if item != none
                if !ZadKeywordsCheck(item) && !item.HasKeyWordString("sexlabnostrip")
                    a.UnequipItem(item, false, true)
                    bind_Utility.WriteToConsole("EquipBondageOutfit - removing: " + item)
                    StorageUtil.FormListAdd(a, "bind_strip_list_blocked", item, false)
                    StorageUtil.FormListRemove(a, "bind_strip_list", item)
                    bind_Utility.DoSleep(sleepWait)
                endif
            endif
            i += 1
        endwhile

        Form[] addBackItems = StorageUtil.FormListToArray(a, "bind_strip_list")
        i = 0
        while i < addBackItems.Length
            bool blockedFlag = false
            int slot = (addBackItems[i] as Armor).GetSlotMask()
            int i2 = 0
            while i2 < blocks.Length
                if blocks[i2] == slot
                    blockedFlag = true
                    i2 = 500
                endif
                i2 += 1
            endwhile
            if a.GetItemCount(addBackItems[i]) > 0 && !blockedFlag
                bind_Utility.WriteToConsole("EquipBondageOutfit - strip list restore: " + addBackItems[i].GetName())
                a.EquipItem(addBackItems[i], false, true)
                bind_Utility.DoSleep(sleepWait)
            endif
            if blockedFlag
                StorageUtil.FormListAdd(a, "bind_strip_list_blocked", addBackItems[i], false)
            endif
            i += 1
        endwhile

        StorageUtil.FormListClear(a, "bind_strip_list")
        Form[] blockItems = StorageUtil.FormListToArray(a, "bind_strip_list_blocked")
        i = 0
        while i < blockItems.Length
            StorageUtil.FormListAdd(a, "bind_strip_list", blockItems[i])
            i += 1
        endwhile

    endif

    ;does the set have stored armor & clothing?
    Form[] wornItems = JsonUtil.FormListToArray(main.BindingGameOutfitFile, setId + "_fixed_worn_items")
    i = 0
    while i < wornItems.Length
        Form item = wornItems[i]
        if a.GetItemCount(item) > 0
            if !a.IsEquipped(item)
                bind_Utility.WriteToConsole("EquipBondageOutfit - fixed worn items add: " + item.GetName())
                a.EquipItem(item, false, true)
                bind_Utility.DoSleep(sleepWait)
            endif
        else
            bind_Utility.WriteToConsole(item.GetName() + " is no longer in your bag")
        endif
        i += 1
    endwhile

    int useRandom = JsonUtil.GetIntValue(main.BindingGameOutfitFile, setId + "_use_random_bondage", 0)

    Form[] setItems

    bind_Utility.WriteToConsole("EquipBondageOutfit - userandom: " + userandom)

    if useRandom == 1

        float expirationDate = JsonUtil.GetFloatValue(main.BindingGameOutfitFile, setId + "_dynamic_bondage_expires", 0.0)
        if expirationDate < bind_Utility.GetTime() || JsonUtil.FormListCount(main.BindingGameOutfitFile, setId + "_dynamic_bondage_items") == 0
            
            bind_Utility.WriteNotification("resetting dynamic gear", bind_Utility.TextColorRed())

            JsonUtil.FormListClear(main.BindingGameOutfitFile, setId + "_dynamic_bondage_items")
            JsonUtil.SetFloatValue(main.BindingGameOutfitFile, setId + "_dynamic_bondage_expires", bind_Utility.AddTimeToCurrentTime(Utility.RandomInt(3, 24), 0)) ;testing 3-24 hours
      
            int material = Utility.RandomInt(1, 4) ;change to 3
            string materialSearch = ""

            material = 3 ;for testing

            if material == 1
                materialSearch = "rope"
            elseif material == 2
                materialSearch = "leather"
            elseif material == 3
                materialSearch = "ebonite"
            elseif material == 4
                materialSearch = "iron"
            endif

            int color = 0
            string colorSearch = ""
            if material == 1 ;rope
                color = Utility.RandomInt(1, 4)
                if color == 4
                    colorSearch = "-black,-red,-white"
                endif
            elseif material == 2 || material == 3 ;leather
                color = Utility.RandomInt(1, 3)
            elseif material == 4 ;iron
                ;color = 1
            endif
            if color == 1
                colorSearch = "black"
            elseif color == 2
                colorSearch = "red"
            elseif color == 3
                colorSearch = "white"
            endif

            int[] chances = JsonUtil.IntListToArray(main.BindingGameOutfitFile, setId + "_random_bondage_chance")
            bind_Utility.WriteToConsole("EquipBondageOutfit - chances:" + chances + " mat: " + material + " col: " + color)

            string searchString = ""
            string rf = "binding/bind_dd_search_result.json"

            bool armsBound = false
            Form bodyItem
            Form armItem

            ;anal plug - 0
            if Utility.RandomInt(0, 100) < chances[0]
                searchString = "anal,plug"
                FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
            endif
            ;vag plug - 1
            if Utility.RandomInt(0, 100) < chances[1]
                searchString = "vaginal,plug"
                FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
            endif
            ;vag piercing - 2
            if Utility.RandomInt(0, 100) < chances[2]
                searchString = "genital,piercing"
                FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
            endif
            ;nipple piercing - 3
            if Utility.RandomInt(0, 100) < chances[3]
                searchString = "nipple,piercing"
                FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
            endif      
            if Utility.RandomInt(0, 100) < chances[5] ;body - 5
                if material == 1 || material == 2 || material == 3
                    int bodyType = Utility.RandomInt(1, 3)
                    if bodyType == 1
                        searchString = "harness,-collar,-gag," + materialSearch + "," + colorSearch
                    elseif bodyType == 2
                        searchString = "corset," + materialSearch + "," + colorSearch
                    elseif bodyType == 3
                        searchString = "belt," + colorSearch
                        if material == 1
                            searchString = "crotch,-harness," + colorSearch
                        endif
                    endif
                elseif material == 4
                    int bodyType = Utility.RandomInt(1, 2)
                    if bodyType == 1
                        searchString = "belt,iron"
                    elseif bodyType == 2 
                        ;searchString = "iron chain harness,-("
                        searchString = "iron chain harness,body"
                    endif
                endif
                bodyItem = FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
            endif
            ;arms - 4
            if Utility.RandomInt(0, 100) < chances[4]
                if material == 1 || material == 2 || material == 3
                    int armType = Utility.RandomInt(1, 2)
                    if armType == 1
                        searchString = "binder,-strait," + materialSearch + "," + colorSearch
                        armsBound = true
                    elseif armType == 2
                        searchString = "arm,cuff," + materialSearch + "," + colorSearch
                    endif
                elseif material == 4
                    int bindArms = Utility.RandomInt(1, 2)
                    ;bindArms = 1
                    if bindArms == 1
                        armsBound = true
                        int armType = Utility.RandomInt(1, 3)
                        if armType == 1
                            searchString = "yoke"                        
                        elseif armType == 2
                            searchString = "manacles"
                        elseif armType == 3
                            searchString = "elbow shackles"
                        endif
                    elseif bindArms == 2
                        searchString = "steel,cuffs,(arms)"
                    endif
                    ;debug.MessageBox(searchString)
                endif
                armItem = FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
            endif
            if Utility.RandomInt(0, 100) < chances[6] ;legs
                int legType = Utility.RandomInt(1, 2)
                if material == 1 || material == 2 || material == 3
                    searchString = "leg,cuff," + materialSearch + "," + colorSearch
                elseif material == 4
                    int bindLegs = Utility.RandomInt(1,2)
                    if bindLegs == 1
                        searchString = "fetters"
                    else
                        searchString = "steel,cuffs,(legs)"
                    endif
                endif
                FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
            endif
            if Utility.RandomInt(0, 100) < chances[7] ;boots
                if material == 2 || material == 3
                    searchString = "boots,-pony," + materialSearch + "," + colorSearch
                    FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
                elseif material == 1 ;rope with iron boots (maybe get rid of this?)
                    searchString = "boots,iron"
                    FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
                elseif material == 4
                    searchString = "boots," + materialSearch
                    FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
                endif
            endif
            if Utility.RandomInt(0, 100) < chances[8] ;gloves
                if material == 2 || material == 3
                    searchString = "gloves," + materialSearch + "," + colorSearch
                    FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
                endif
            endif       
            if Utility.RandomInt(0, 100) < chances[10] ;gag
                if material == 4
                    int gagType = Utility.RandomInt(1, 2)
                    if gagType == 1
                        searchString = "gag," + materialSearch
                    else
                        searchString = "bridle"
                    endif
                else
                    searchString = "gag," + materialSearch + "," + colorSearch
                endif
                FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
            endif
            if Utility.RandomInt(0, 100) < chances[11] ;blindfold
                if material == 1 || material == 2 || material == 3
                    searchString = "blindfold," + materialSearch + "," + colorSearch
                    FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
                elseif material == 4
                    searchString = "blindfold,leather,black"
                    FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
                endif
            endif
            if Utility.RandomInt(0, 100) < chances[12] ;hood
                if material == 1 || material == 4
                    searchString = "hood,leather,black"
                else
                    searchString = "hood," + materialSearch + "," + colorSearch
                endif
                FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
            endif
            if Utility.RandomInt(0, 100) < chances[9] ;collar - 9 (moved this up to let the body and arms unequip it)
                if !zlib.GetRenderedDevice(bodyItem as Armor).HasKeyWord(zlib.zad_DeviousCollar) && !zlib.GetRenderedDevice(armItem as Armor).HasKeyWord(zlib.zad_DeviousCollar)
                    if material == 4
                        int collarType = Utility.RandomInt(1,2)
                        if collarType == 1
                            searchString = "collar,-chain," + materialSearch
                        elseif collarType == 2
                            searchString = "steel,collar,(padded),-posture"
                        endif
                    else
                        searchString = "collar," + materialSearch + "," + colorSearch
                    endif
                    FindRandomItem(main.BindingGameOutfitFile, rf, searchString, setId)
                else
                    bind_Utility.WriteToConsole("body item has collar")
                endif
            endif  

            JsonUtil.Save(main.BindingGameOutfitFile)

        endif

        setItems = JsonUtil.FormListToArray(main.BindingGameOutfitFile, setId + "_dynamic_bondage_items")

    else
    
        setItems = JsonUtil.FormListToArray(main.BindingGameOutfitFile, setId + "_fixed_bondage_items")

    endif

    bind_Utility.WriteToConsole("EquipBondageOutfit - items: " + setItems)

    if setItems != none
        i = 0
        while i < setItems.Length
            Form dev = setItems[i]
            if dev
                AddSpecificItem(a, dev as Armor)
                bind_Utility.DoSleep(sleepWait)
            endif
            i += 1
        endwhile
    endif

    StorageUtil.SetIntValue(a, "bind_wearing_outfit_id", setId) ;NOTE - this is used by the sub alias to determine blocks
    StorageUtil.SetStringValue(a, "bind_wearing_outfit_name", JsonUtil.GetStringValue(main.BindingGameOutfitFile, setId + "_bondage_outfit_name", ""))

    bind_Utility.DoSleep(2.0)

    int handle = ModEvent.Create("bind_BondageOutfitEquipped")
    if handle
        ModEvent.Send(handle)
    endif

    EquippingBondageOutfit = false

endfunction

Form function FindRandomItem(string fileName, string resultsFileName, string searchString, int setId)
    string[] items = SearchDeviousItems(searchString)
    ;debug.MessageBox("search: " + searchString + " results: " + items)
    Form dev = JsonUtil.FormListRandom(resultsFileName, "found_items")
    if dev != none
        bind_Utility.WriteToConsole("FindRandomItem: " + dev.GetName())
        JsonUtil.FormListAdd(fileName, setId + "_dynamic_bondage_items", dev)
    endif
    return dev
endfunction

int function GetBondageSetForLocation(Location currentLocation, int currentBondageSet)

    string outfitKey = ""
    int[] outfitIds

    bool isSafeArea = false

    ; if !JsonUtil.IntListHas(bondageOutfitsFile, "enabled_oufits", currentBondageSet)
    ;     ;check to see if the current set is still enabled
    ;     currentBondageSet = -1
    ; endif

    StorageUtil.StringListClear(theSubRef, "binding_location_tags")

    if currentLocation.HasKeywordString("LocTypePlayerHouse")
        isSafeArea = true
        outfitKey = "location_player_home"
        StorageUtil.StringListAdd(theSubRef, "binding_location_tags", outfitKey)
    endif

    if currentLocation.HasKeywordString("LocTypeInn")
        isSafeArea = true
        outfitKey = "location_inn"
        StorageUtil.StringListAdd(theSubRef, "binding_location_tags", outfitKey)
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
        StorageUtil.StringListAdd(theSubRef, "binding_location_tags", outfitKey)
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
            StorageUtil.StringListAdd(theSubRef, "binding_location_tags", outfitKey)
        endif
    endif

    if (currentLocation.HasKeywordString("LocTypeCity") || buildingInCity)
        isSafeArea = true
        outfitKey = "location_any_city"
        StorageUtil.StringListAdd(theSubRef, "binding_location_tags", outfitKey)
    endif

    if isSafeArea
        ;debug.MessageBox("safe area")
        outfitKey = "location_safe_area"
        StorageUtil.StringListAdd(theSubRef, "binding_location_tags", outfitKey)
    elseif !isSafeArea && outfitIds.Length == 0
        ;dangerous area
        ;debug.MessageBox("unsafe area")
        outfitKey = "location_unsafe_area"
        StorageUtil.StringListAdd(theSubRef, "binding_location_tags", outfitKey)
    endif

    StorageUtil.StringListAdd(theSubRef, "binding_location_tags", "location_all_areas")

    string[] locTagList = StorageUtil.StringListToArray(theSubRef, "binding_location_tags")

    ;debug.MessageBox(locTagList)
    bind_Utility.WriteToConsole("search for tags: " + locTagList)

    ;string[] fList = MiscUtil.FilesInFolder(main.GameSaveFolder)

    int[] outfitIdList = JsonUtil.IntListToArray(main.BindingGameOutfitFile, "outfit_id_list")

    bool foundOutfits = false
    bool outfitValid = false

    StorageUtil.IntListClear(theSubRef, "binding_found_outfit_id_list")

    int i = 0
    int i2 = 0
    while i < locTagList.Length
        string tag = locTagList[i]
        i2 = 0
        while i2 < outfitIdList.Length
            if JsonUtil.StringListHas(main.BindingGameOutfitFile, outfitIdList[i2] + "_used_for", tag)
                if JsonUtil.GetIntValue(main.BindingGameOutfitFile, outfitIdList[i2] + "_outfit_enabled", 0) == 1
                    ;debug.MessageBox(fList[i2])
                    bind_Utility.WriteToConsole("found: " + outfitIdList[i2])
                    int outfitId = outfitIdList[i2]; JsonUtil.GetIntValue(main.BindingGameOutfitFile, outfitIdList[i2] + "_outfit_id", -1)
                    if outfitId == currentBondageSet
                        outfitValid = true
                    endif
                    StorageUtil.IntListAdd(theSubRef, "binding_found_outfit_id_list", outfitId)
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

    int[] list = StorageUtil.IntListToArray(theSubRef, "binding_found_outfit_id_list")

    return list[Utility.RandomInt(0, list.Length - 1)]

    ;return outfitIds[Utility.RandomInt(0, outfitIds.Length - 1)]

endfunction

string[] function GetSetsByUsage(string usage)
    return StorageUtil.StringListToArray(TheWardrobe, "used_for_" + usage)
endfunction

bool function AddSpecificItem(Actor act, Form dev)
    bool result = false
    if dev
        SetBindingBondageItem(dev)
        result = zlib.LockDevice(act, dev as Armor, true)
        if result
            
            StorageUtil.FormListAdd(act, "binding_worn_bondage_items", dev, false)
            ;StorageUtil.FormListAdd(act, "binding_bondage_specific_list", dev, false)
        endif
    endif
    return result
endfunction

bool function RemoveSpecificItem(Actor act, Form dev)
    bool result = false
    if dev
        SetBindingBondageItem(dev)
        result = zlib.UnlockDevice(act, dev as Armor, none, none, true)
        if result
            StorageUtil.FormListRemove(act, "binding_worn_bondage_items", dev, true)
            ;StorageUtil.FormListRemove(act, "binding_bondage_specific_list", dev, true)
        endif
    endif
    return result
endfunction

Form[] function GetSpecificItems(Actor act)
    ;return StorageUtil.FormListToArray(act, "binding_bondage_specific_list")
    return StorageUtil.FormListToArray(act, "binding_worn_bondage_items")
endfunction

; bool function AddItemPassingDevice(Actor act, Armor dev)
;     bool result = false

;     if dev
;         StorageUtil.SetIntValue(dev, "binding_bondage_item", 1)
;         SetBindingBondageItem(dev)
;         result = zlib.LockDevice(act, dev, true)
;     endif

;     return result
; endfunction

Armor function GetRenderedItem(Form inventoryItem)
    return zlib.GetRenderedDevice(inventoryItem as Armor)
endfunction

bool function AddItem(Actor act, int typeNumber, string setName = "")

    ; if CurrentFavoriteSetEndTime < bind_Utility.GetTime() && UseFavoriteSet == 0
    ;     ;set new set
    ;     string randomSet = GetRandomSet("all") ;need to change this
    ;     debug.MessageBox(randomSet)
    ;     if randomSet != ""
    ;         CurrentFavoriteSet = Utility.RandomInt(1, 3)
    ;         bind_Utility.WriteToConsole("New favorite bondage set: " + CurrentFavoriteSet)
    ;         CurrentFavoriteSetEndTime = bind_Utility.AddTimeToCurrentTime(Utility.RandomInt(4, 24), 0)
    ;     endif
    ; endif

    ;debug.MessageBox("in here???")

    bool result = false

    if act.IsInFaction(bind_BondageFactions.GetAt(typeNumber) as Faction)
        bind_Utility.WriteToConsole("additem already equipped type: " + typeNumber)
        return result
    endif

    Form dev

    ; if setName == ""
    ;     dev = GetFavoriteItem(act, typeNumber)
    ; else
    ;     ;dev = get an item from stored set _setname_(typenumber)
    ; endif

    ; bind_Utility.DoSleep(sleepTime)
    ; if !dev
    ;     FormList fList = bind_BondageList.GetAt(typeNumber) as FormList
    ;     dev = fList.GetAt(Utility.RandomInt(0, fList.GetSize() - 1))
    ; endif

    string skeyf = "bind_favorite_dd_"

    ; int trySet = 0
    ; If UseFavoriteSet == 0
    ;     trySet = CurrentFavoriteSet
    ; else
    ;     trySet = UseFavoriteSet
    ; endif

    if ActiveBondageSet != ""

        Form[] setItems = StorageUtil.FormListToArray(TheWardrobe, "set_" + ActiveBondageSet)
        Keyword kw = GetDDKeyword(typenumber)

        ;debug.MessageBox("set set: " + ActiveBondageSet + " items: " + setItems + " keyword: " + kw)

        int i = 0
        while i < setItems.Length
            Form item = setItems[i]
            Form renderedItem = zlib.GetRenderedDevice(item as Armor)
            if renderedItem
                if renderedItem.HasKeyWord(kw)
                    dev = item
                    i = 500 ;found item
                endif
            endif
            i += 1
        endwhile

        if !dev
            ;;debug.Notification("No items for typenumber: " + typenumber)
        else
            ;debug.MessageBox(dev)
        endif

    else

        ;debug.MessageBox("random")

        dev = GetDdRandomItem(typenumber)

    endif

    ; Form[] favorites = StorageUtil.FormListToArray(act, skeyf + typeNumber + "_" + trySet)
    ; if favorites.Length > 0
    ;     dev = favorites[Utility.RandomInt(0, favorites.length - 1)]
    ;     bind_Utility.WriteToConsole("Found favorite: " + dev.GetName())
    ; else
        ;dev = GetDdRandomItem(typenumber)
        ;bind_Utility.WriteToConsole("No favorite / using random: " + dev.GetName())
        ; LeveledItem list
        ; if typeNumber == BONDAGE_TYPE_HEAVYBONDAGE()
        ;     list = ddLists.zad_dev_armbinders

        ; ;TODO - make others

        ; endif
        ; ;get random
        ; dev = ddLists.GetRandomDevice(list)
    ;endif

    ;debug.MessageBox(dev)

    ;bind_Utility.WriteToConsole("additem dev: " + dev)

    ;Do slot checks??

    if dev
        ;StorageUtil.SetIntValue(dev, "binding_bondage_item", 1)
        SetBindingBondageItem(dev)
        LastAddedItemName = dev.GetName()
        result = zlib.LockDevice(act, dev as Armor, true)
    endif

    bind_Utility.WriteToConsole("additem - dev: " + dev + " result: " + result)

    if result
        ;debug.MessageBox("adding: " + dev.GetName())
        StorageUtil.FormListAdd(act, "binding_worn_bondage_items", dev, false)
        StoreEquippedItem(act, typeNumber, dev)

        ; bind_Utility.DoSleep()
        ; Armor rdev = zlib.GetWornRenderedDeviceByKeyword(act, bind_DDKeywords.GetAt(typeNumber) as Keyword)
        ; if rdev
        ;     bind_Utility.WriteToConsole("found rendered item")
        ;     SetBindingBondageItem(rdev)
        ; endif
    endif

    ;bind_Utility.WriteToConsole("add item result: " + result)

    return result

endfunction

Armor function GetDdRandomItem(int typeNumber)
    Armor dev
    LeveledItem list
    if typeNumber == BONDAGE_TYPE_ANKLE_SHACKLES()
        list = ddLists.zad_dev_ankleshackles  
    elseif typeNumber == BONDAGE_TYPE_ARM_CUFFS()
        list = ddLists.zad_dev_armcuffs
    elseif typeNumber == BONDAGE_TYPE_BLINDFOLD()
        list = ddLists.zad_dev_blindfolds
    elseif typeNumber == BONDAGE_TYPE_BOOTS()
        list = ddLists.zad_dev_boots
    elseif typeNumber == BONDAGE_TYPE_BELT()
        list = ddLists.zad_dev_chastitybelts
    elseif typeNumber == BONDAGE_TYPE_COLLAR()
        list = ddLists.zad_dev_collars
    elseif typeNumber == BONDAGE_TYPE_CORSET()
        list = ddLists.zad_dev_corsets
    elseif typeNumber == BONDAGE_TYPE_GAG()
        list = ddLists.zad_dev_gags
    elseif typeNumber == BONDAGE_TYPE_GLOVES()
        list = ddLists.zad_dev_gloves
    elseif typeNumber == BONDAGE_TYPE_HARNESS()
        list = ddLists.zad_dev_harnesses
    elseif typeNumber == BONDAGE_TYPE_HEAVYBONDAGE()
        list = ddLists.zad_dev_heavyrestraints
    elseif typeNumber == BONDAGE_TYPE_HOOD()
        list = ddLists.zad_dev_hoods
    elseif typeNumber == BONDAGE_TYPE_LEG_CUFFS()
        list = ddLists.zad_dev_legcuffs
    elseif typeNumber == BONDAGE_TYPE_N_PIERCING()
        list = ddLists.zad_dev_piercings_nipple
    elseif typeNumber == BONDAGE_TYPE_V_PIERCING()
        list = ddLists.zad_dev_piercings_vaginal
    elseif typeNumber == BONDAGE_TYPE_A_PLUG()
        list = ddLists.zad_dev_plugs_anal
    elseif typeNumber == BONDAGE_TYPE_V_PLUG()
        list = ddLists.zad_dev_plugs_vaginal
    elseif typeNumber == BONDAGE_TYPE_SUIT()
        list = ddLists.zad_dev_suits
    endif
    ;get random
    dev = ddLists.GetRandomDevice(list)
    return dev
endfunction

bool function RemoveItem(Actor act, int typeNumber)

    Form dev = GetStoredItem(act, typeNumber)

    bool result = false

    if dev
        result = zlib.UnlockDevice(act, dev as Armor, none, bind_DDKeywords.GetAt(typeNumber) as Keyword, true)
    endif

    if result
        StorageUtil.FormListRemove(act, "binding_worn_bondage_items", dev, true)
        ;maybe do a dd keyword check on the wornform to make sure it is gone??

        ClearStoredItem(act, typeNumber)        
    endif

    return result

endfunction

function StoreEquippedItem(Actor act, int typeNumber, Form dev)
    StorageUtil.SetFormValue(act, "bind_bondage_stored_" + typeNumber, dev)
endfunction

Form function GetStoredItem(Actor act, int typeNumber)
    return StorageUtil.GetFormValue(act, "bind_bondage_stored_" + typeNumber, none)
endfunction

function ClearStoredItem(Actor act, int typeNumber)
    StorageUtil.SetFormValue(act, "bind_bondage_stored_" + typeNumber, none)
endfunction

string[] function GetStoredItemsDisplayList(Actor act)

    string[] items = new string[18]

    int i = 0
    while i < items.Length
        Form dev = GetStoredItem(act, i)
        if dev
            items[i] = dev.GetName()
        else
            items[i] = " (none)"
        endif
        i += 1
    endwhile

    return items

endfunction

bool function SnapshotCurrentBondage(Actor act)

    ; int i = 0
    ; while i < bind_BondageList.GetSize()

    ;     Form dev = GetStoredItem(act, i)

    ;     StorageUtil.SetFormValue(act, "bind_bondage_buffer_" + i, dev)

    ;     i += 1
    ; endwhile

    ;TODO - improve snapshot to look for any DD items that are not in slots by keyword checks
    ;add to an array and reapply using restore from snapshot
    i = 0
    ; StorageUtil.FormListClear(act, "bind_bondage_buffer_other")
    ; while i < bind_DDKeywords.GetSize()
    ;     if act.WornHasKeyWord(bind_DDKeywords.GetAt(i) as Keyword)

    ;     endif
    ;     i += 1
    ; endwhile

    StorageUtil.FormListClear(act, "bind_snapshot")
	Form[] inventory = act.GetContainerForms()
	int i = 0
	while i < inventory.Length
		Form item = inventory[i]
        if item.HasKeyWord(zlib.zad_InventoryDevice) && act.IsEquipped(item)
            ;worn dd item
            StorageUtil.FormListAdd(act, "bind_snapshot", item)
        endif
        i += 1
    endwhile

    bind_Utility.WriteToConsole("created DD items snapshot")

    return true

endfunction

bool function RestoreFromSnapshot(Actor act)

    ; int i = 0
    ; while i < bind_BondageList.GetSize()

    ;     Form dev = StorageUtil.GetFormValue(act, "bind_bondage_buffer_" + i, none)

    ;     if dev

    ;         StorageUtil.SetFormValue(act, "bind_bondage_stored_" + i, dev)

    ;         SetBindingBondageItem(dev)
            
    ;         bool result = zlib.LockDevice(act, dev as Armor, true)

    ;     endif

    ;     i += 1
    ; endwhile

    Form[] items = StorageUtil.FormListToArray(act, "bind_snapshot")
    if items.Length > 0
        int i = 0
        while i < items.Length
            Form dev = items[i]
            if dev
                ;StorageUtil.SetFormValue(act, "bind_bondage_stored_" + i, dev)
                ;SetBindingBondageItem(dev)
                bool result = zlib.LockDevice(act, dev as Armor, true)
            endif
            i += 1
        endwhile
    endif

    bind_Utility.WriteToConsole("restoring DD items from snapshot")

    return true

endfunction

function TriggerShock(Actor act)
    zlib.ShockActor(act)
endfunction





Function RemoveAllDetectedBondageItems(Actor act)

    int i = 0

    if act.WornHasKeyWord(zlib.zad_Lockable)
        while i < bind_DDKeywords.GetSize()
            Keyword kw = bind_DDKeywords.GetAt(i) as Keyword
            if act.WornHasKeyword(kw)
                if zlib.UnlockDeviceByKeyword(act, kw, false)
                    bind_Utility.WriteToConsole("removing by keyword: " + kw)
                endif
                bind_Utility.DoSleep(sleepTime)
            endif
            i += 1
        endwhile
    endif

    StorageUtil.FormListClear(act, "binding_worn_bondage_items") ;clear the stored items list

    return

    ;debug.MessageBox("in here???")

    ; Keyword[] zadKeywords = new Keyword[35]

    ; zadKeywords[0] = zlib.zad_DeviousPlug
    ; zadKeywords[1] = zlib.zad_DeviousBelt
    ; zadKeywords[2] = zlib.zad_DeviousBra
    ; zadKeywords[3] = zlib.zad_DeviousCollar
    ; zadKeywords[4] = zlib.zad_DeviousArmCuffs
    ; zadKeywords[5] = zlib.zad_DeviousLegCuffs
    ; zadKeywords[6] = zlib.zad_DeviousArmbinder
    ; zadKeywords[7] = zlib.zad_DeviousArmbinderElbow
    ; zadKeywords[8] = zlib.zad_DeviousHeavyBondage
    ; zadKeywords[9] = zlib.zad_DeviousHobbleSkirt
    ; zadKeywords[10] = zlib.zad_DeviousHobbleSkirtRelaxed
    ; zadKeywords[11] = zlib.zad_DeviousAnkleShackles
    ; zadKeywords[12] = zlib.zad_DeviousStraitJacket
    ; zadKeywords[13] = zlib.zad_DeviousCuffsFront
    ; zadKeywords[14] = zlib.zad_DeviousPetSuit
    ; zadKeywords[15] = zlib.zad_DeviousYoke
    ; zadKeywords[16] = zlib.zad_DeviousYokeBB
    ; zadKeywords[17] = zlib.zad_DeviousCorset
    ; zadKeywords[18] = zlib.zad_DeviousClamps
    ; zadKeywords[19] = zlib.zad_DeviousGloves
    ; zadKeywords[20] = zlib.zad_DeviousHood
    ; zadKeywords[21] = zlib.zad_DeviousSuit
    ; zadKeywords[22] = zlib.zad_DeviousElbowTie
    ; zadKeywords[23] = zlib.zad_DeviousGag
    ; zadKeywords[24] = zlib.zad_DeviousGagLarge
    ; zadKeywords[25] = zlib.zad_DeviousGagPanel
    ; zadKeywords[26] = zlib.zad_DeviousPlugVaginal
    ; zadKeywords[27] = zlib.zad_DeviousPlugAnal
    ; zadKeywords[28] = zlib.zad_DeviousHarness
    ; zadKeywords[29] = zlib.zad_DeviousBlindfold
    ; zadKeywords[30] = zlib.zad_DeviousBoots
    ; zadKeywords[31] = zlib.zad_DeviousPiercingsNipple
    ; zadKeywords[32] = zlib.zad_DeviousPiercingsVaginal
    ; zadKeywords[33] = zlib.zad_DeviousBondageMittens
    ; zadKeywords[34] = zlib.zad_DeviousPonyGear

    ; string zadKeywords = "zad_DeviousArmCuffs,zad_DeviousArmbinder,zad_DeviousGag,zad_DeviousHarness,zad_DeviousCollar,zad_DeviousHeavyBondage,"
    ; zadKeywords = zadKeywords + "zad_DeviousPlugAnal,zad_DeviousBelt,zad_DeviousPiercingsVaginal,zad_DeviousPiercingsNipple,zad_DeviousLegCuffs,"
    ; zadKeywords = zadKeywords + "zad_DeviousBlindfold,zad_DeviousBra,zad_DeviousPlugVaginal,zad_DeviousHood,zad_DeviousBoots,zad_DeviousArmbinderElbow"
    ; string[] arr = StringUtil.Split(zadKeywords, ",")


	Form[] inventory = act.GetContainerForms()
	;int i = 0
    int kwi = 0

    ;debug.MessageBox("inv len: " + inventory.Length)
    bind_Utility.WriteToConsole("remove all devices - inv len: " + inventory.Length)

	while i < inventory.Length
        Form dev = inventory[i]
        bind_Utility.WriteToConsole("dev: " + dev.GetName())
        if dev.HasKeyWord(zlib.zad_inventoryDevice)
            bind_Utility.WriteToConsole("found zad_inventoryDevice: " + dev)
            if dev.HasKeyWord(zlib.zad_QuestItem) || dev.HasKeyWord(zlib.zad_BlockGeneric)
                bind_Utility.WriteToConsole("quest or blocking device")
            else
                bind_Utility.WriteToConsole("dev: " + dev.GetName() + " binding item: " + StorageUtil.GetIntValue(dev, "binding_bondage_item", 0))
                if zlib.UnlockDevice(act, dev as Armor, none, none, true)
                    bind_Utility.WriteToConsole("removed device")
                    bind_Utility.DoSleep(sleepTime)
                endif
            endif
        endif
        i += 1
    endwhile

    ;clear storage
    i = 0
    while i < bind_BondageList.GetSize()
        ClearStoredItem(act, i)
        i += 1
    endwhile

    ;debug.MessageBox("done")

EndFunction

bool Function RemoveAllBondageItems(Actor act, bool nonBindingItems = true)

    Form[] wornItems = StorageUtil.FormListToArray(act, "binding_worn_bondage_items")
    ;debug.MessageBox(wornItems)

    int i

    if wornItems
        i = 0
        while i < wornItems.Length
            Armor dev = wornItems[i] as Armor
            if zlib.UnlockDevice(act, dev, none, none, true)
                bind_Utility.WriteToConsole("RemoveAllBondageItems - removing stored item: " + dev)                
            endif
            bind_Utility.DoSleep(sleepTime)
            i += 1
        endwhile
    endif

    ;phase 2 ???
    ;walk items by dd keyword get item
    ;check if it has a binding stored decorator on the form
    
    StorageUtil.FormListClear(act, "binding_worn_bondage_items")

    if nonBindingItems
        if act.WornHasKeyWord(zlib.zad_Lockable)
            i = 0
            while i < bind_DDKeywords.GetSize()
                Keyword kw = bind_DDKeywords.GetAt(i) as Keyword
                if act.WornHasKeyword(kw)
                    if zlib.UnlockDeviceByKeyword(act, kw, false)
                        bind_Utility.WriteToConsole("RemoveAllBondageItems - removing by keyword: " + kw)
                    endif
                    bind_Utility.DoSleep(sleepTime)
                endif
                i += 1
            endwhile
        endif
        ; if act.WornHasKeyWord(zlib.zad_Lockable)
        ;     debug.MessageBox("fail safe removal")
        ; 	Form[] inventory = act.GetContainerForms()
        ;     i = 0
        ;     while i < inventory.Length
        ;         Form dev = inventory[i]
        ;         if dev.HasKeyWord(zlib.zad_Lockable) && act.IsEquipped(dev)
        ;             if !dev.HasKeyWord(zlib.zad_QuestItem) && !dev.HasKeyWord(zlib.zad_BlockGeneric)
        ;                 zlib.UnlockDevice(act, dev as Armor, none, none, true)
        ;                 bind_Utility.WriteToConsole("removing non-binding rendered item: " + dev.GetName())
        ;             endif
        ;         endif
        ;         i += 1
        ;     endwhile
        ; endif
    endif

	Form[] inventory = act.GetContainerForms()
    i = 0
    bind_Utility.WriteToConsole("clean up bags: " + inventory.Length)

	while i < inventory.Length
        Form dev = inventory[i]
        
        ;TODO - figure out how to deal with failed render devices

        if dev.HasKeyWord(zlib.zad_InventoryDevice) && !act.IsEquipped(dev) && !dev.HasKeyWord(zlib.zad_QuestItem)
            int flag = GetBindingBondageItem(dev)
            if flag == 1 || main.CleanUpNonBindingItemsFromBags == 1
                bind_Utility.WriteToConsole("RemoveAllBondageItems - removing binding item: " + dev.GetName())
                act.RemoveItem(dev, 100, true, none)
            else
                bind_Utility.WriteToConsole("RemoveAllBondageItems - leaving non-binding item: " + dev.GetName())
            endif
        endif
        i += 1
    endwhile



    return true



    bool result

    i = 0
    while i < bind_BondageList.GetSize()

        Form dev = GetStoredItem(act, i)

        bind_Utility.WriteToConsole("RemoveAllBondageItems i: " + i + " found: " + dev)

        if dev
            
            int flag = GetBindingBondageItem(dev)

            bind_Utility.WriteToConsole("flag: " + flag)

            result = false

            if flag == 1
                result = zlib.UnlockDevice(act, dev as Armor, none, bind_DDKeywords.GetAt(i) as Keyword, true)

                bind_Utility.WriteToConsole("remove result: " + result)
            endif

            if result
                ClearStoredItem(act, i) 
            endif

        endif

        i += 1
    endwhile

    ;remove specific items
    Form[] specificItems = StorageUtil.FormListToArray(act, "binding_bondage_specific_list")
    if specificItems.Length > 0
        i = 0
        while i < specificItems.Length
            result = zlib.UnlockDevice(act, specificItems[i] as Armor, none, none, true)
            i += 1
        endwhile
        StorageUtil.FormListClear(act, "binding_bondage_specific_list")
    endif

    return true

EndFunction

; function UpdateBondage(Actor a, bool removeExisting = false)

;     ;debug.MessageBox("UpdateBondage called")

;     int i
;     int operation
;     int rank

;     bool safeArea = (StorageUtil.GetIntValue(a, "bind_safe_area", 0) == 1)

;     if !a.IsInFaction(bind_EventActiveFaction)

;         ;NOT IN EVENT - RUNNING

;         bind_Utility.WriteToConsole("UpdateBondage no event faction found")

;         if a.IsInFaction(bind_BondageRulesDisableFaction)
            
;             bind_Utility.WriteToConsole("UpdateBondage disable rules faction found")

;             ;remove all binding items
;             RemoveAllBondageItems(a, false)


;         else

;             bool removedAllItems = false

;             if removeExisting
;                 RemoveAllBondageItems(a, false)
;                 removedAllItems = true
;                 bind_Utility.DoSleep(1.0) ;give dd enough time to clear so that keyword checks below are accurate
;             endif

;             ;apply rules bondage
;             ;i = 0

;             string[] ruleNames = rms.GetBondageRuleNameArray()

;             bind_Utility.WriteToConsole("UpdateBondage rulescheck:")

;         ; dRuleName[0] = "Ankle Shackles Rule"
;         ; dRuleName[1] = "Arm Cuffs Rule"
;         ; dRuleName[2] = "Blindfold Rule"
;         ; dRuleName[3] = "Boots Rule"
;         ; dRuleName[4] = "Belt Rule"
;         ; dRuleName[5] = "Collar Rule"
;         ; dRuleName[6] = "Corset Rule"
;         ; dRuleName[7] = "Gag Rule"
;         ; dRuleName[8] = "Gloves Rule"
;         ; dRuleName[9] = "Harness Rule"
;         ; dRuleName[10] = "Heavy Bondage Rule"
;         ; dRuleName[11] = "Hood Rule"
;         ; dRuleName[12] = "Leg Cuffs Rule"
;         ; dRuleName[13] = "Nipple Piercing Rule"
;         ; dRuleName[14] = "Vaginal Piercing Rule"
;         ; dRuleName[15] = "Anal Plug Rule"
;         ; dRuleName[16] = "Vaginal Plug Rule"
;         ; dRuleName[17] = "Suit Rule"

;             int[] equipOrder = new int[18]
;             equipOrder[0] = 15 ;anal plug
;             equipOrder[1] = 16 ;v plug
;             equipOrder[2] = 14 ;v piercing
;             equipOrder[3] = 13 ;n piercing
;             equipOrder[4] = 17 ;suits
;             equipOrder[5] = 9 ;harness
;             equipOrder[6] = 6 ;corset
;             equipOrder[7] = 4 ;belt
;             equipOrder[8] = 5 ;collar
;             equipOrder[9] = 8 ;gloves
;             equipOrder[10] = 3 ;boots
;             equipOrder[11] = 1 ;arm cuffs
;             equipOrder[12] = 12 ;leg cuffs
;             equipOrder[13] = 10 ;heavy bondage
;             equipOrder[14] = 0 ;ankle shackles
;             equipOrder[15] = 2 ;blindfold
;             equipOrder[16] = 11 ;hood
;             equipOrder[17] = 7 ;gag


;             int idx = 0
;             ;TODO - run this in reverse??? so plugs get set first - suit can block everyting else?
;             while idx < bind_DDKeywords.GetSize() ;bind_BondageRulesFactionList.GetSize()

;                 operation = 0

;                 i = equipOrder[idx]

;                 int ruleSetting = StorageUtil.GetIntValue(a, "bind_rule_setting_" + i, 0)
;                 int ruleOption = StorageUtil.GetIntValue(a, "bind_rule_option_" + i, 0)

;                 ; if ruleOption == 1
;                 ;     ruleText += " - Blocked / Hard Limit"
;                 ; elseif ruleOption == 2
;                 ;     ruleText += " - Safe Areas Only"
;                 ; elseif ruleOption == 3
;                 ;     ruleText += " - Always On"
;                 ; elseif ruleOption == 4
;                 ;     ruleText += " - Always On In Safe Areas"
;                 ; endif

;                 ; if i == BONDAGE_TYPE_SUIT() && ruleSetting == 1 && !safeArea ;see if heavy bondage should be removed in unsafe areas
;                 ;     ;debug.MessageBox("in the condition")
;                 ;     ;heavy bondage check on suits - suits are lower in the list, so this should only happen for that slot
;                 ;     if a.WornHasKeyWord(bind_DDKeywords.GetAt(BONDAGE_TYPE_HEAVYBONDAGE()) as Keyword)
;                 ;         ;debug.MessageBox("found heavy bondage keyword")
;                 ;         int heavyBondageOption = StorageUtil.GetIntValue(a, "bind_rule_option_" + BONDAGE_TYPE_HEAVYBONDAGE(), 0)
;                 ;         if heavyBondageOption == 2 || heavyBondageOption == 4
;                 ;             ruleOption = heavyBondageOption
;                 ;             bind_Utility.WriteToConsole("suits has heavy bondage - using heavy bondage safe areas option")
;                 ;         endif
;                 ;     endif
;                 ; endif

;                 if ruleSetting == 1 ;a.IsInFaction(bind_BondageRulesFactionList.GetAt(i) as Faction)
;                     ;TODO - check faction rank??
                    
;                     operation = 1 ;normal check if equipped
                    
;                     if ruleOption == 2 || ruleOption == 4 ;safe area only
;                         if !safeArea
;                             operation = 2 ;remove this if not in a safe area
;                         endif
;                     endif
                    
;                     if ruleOption == 5 || ruleOption == 6 ;unsafe area only
;                         if safeArea
;                             operation = 2 ;remove this if in safe area
;                         endif
;                     endif

;                     ;rank = a.GetFactionRank(bind_BondageRulesFactionList.GetAt(i) as Faction)

;                     ;bind_Utility.WriteToConsole("faction: " + i + " rank " + rank)
;                 else

;                     operation = 2 ;normal remove

;                     ; if ruleOption == 2 || ruleOption == 4 ;safe area only
;                     ;     if !safeArea
;                     ;         operation = 3 ;don't try to remove this if in a safe area
;                     ;     endif
;                     ; endif

;                     ; if ruleOption == 5 || ruleOption == 6 ;unsafe area only
;                     ;     if !safeArea
;                     ;         operation = 3 ;don't try to remove this if in an unsafe area
;                     ;     endif
;                     ; endif

;                 endif

;                 int kwc = 0
;                 int ddResult = 0

;                 if operation == 1
;                     ;if !a.WornHasKeyWord(bind_DDKeywords.GetAt(i) as Keyword)
;                     ;    kwc = 2
;                         ;bind_Utility.WriteToConsole("keyword not found: " + i)
;                         if AddItem(a, i)
;                             ddResult = 1
;                             ;bind_Utility.WriteToConsole("adding: " + i)
;                             bind_Utility.DoSleep(sleepTime)
;                         else
;                             ddResult = 2
;                         endif
;                     ;else
;                     ;    kwc = 1
;                     ;endif
;                 elseif operation == 2
;                     ;if a.WornHasKeyWord(bind_DDKeywords.GetAt(i) as Keyword)
;                     ;    kwc = 1
;                         ;bind_Utility.WriteToConsole("keyword found: " + i)
;                         if RemoveItem(a, i)
;                             ddResult = 1
;                             ;bind_Utility.WriteToConsole("removing: " + i)
;                             bind_Utility.DoSleep(sleepTime)
;                         else 
;                             ddResult = 2
;                         endif
;                     ;else
;                     ;    kwc = 2
;                     ;endif
;                 elseif operation == 3
;                     ;leave the things alone
;                     if removedAllItems
;                         ;should we re-equip??
;                     endif
;                 endif

;                 bind_Utility.WriteToConsole("rule setting: " + ruleSetting + " rule option: " + ruleOption + " operation: " + operation + " keyword check: " + kwc + " dd result: " + ddresult + " - " + ruleNames[i])                

;                 idx += 1

;             endwhile

;         endif

;     else

;         ;IN EVENT

;         ;check for event remove all bondage faction
;         ;run RemoveAllBondageItems(a) if so

;         ;

;     endif



; endfunction


int function GetBindingBondageItem(Form f)
    return StorageUtil.GetIntValue(f, "binding_bondage_item", 0)
endfunction

function SetBindingBondageItem(Form f)
    
    Float ct = bind_Utility.GetTime()

    StorageUtil.SetFloatValue(f, "binding_bondage_item_added", ct)
    StorageUtil.SetIntValue(f, "binding_bondage_item", 1)

endfunction

Function AddGagEffect()
    zlib.ResumeDialogue()
EndFunction

Function RemoveGagEffect()
    zlib.PauseDialogue()
EndFunction

int Function BONDAGE_TYPE_ANKLE_SHACKLES()
    return 0
EndFunction

int Function BONDAGE_TYPE_ARM_CUFFS()
    return 1
EndFunction

int Function BONDAGE_TYPE_BLINDFOLD()
    return 2
EndFunction

int Function BONDAGE_TYPE_BOOTS()
    return 3
EndFunction

int Function BONDAGE_TYPE_BELT()
    return 4
EndFunction

int Function BONDAGE_TYPE_COLLAR()
    return 5
EndFunction

int Function BONDAGE_TYPE_CORSET()
    return 6
EndFunction

int Function BONDAGE_TYPE_GAG()
    return 7
EndFunction

int Function BONDAGE_TYPE_GLOVES()
    return 8
EndFunction

int Function BONDAGE_TYPE_HARNESS()
    return 9
EndFunction

int function BONDAGE_TYPE_HEAVYBONDAGE()
    return 10
endfunction

int Function BONDAGE_TYPE_HOOD()
    return 11
EndFunction

int Function BONDAGE_TYPE_LEG_CUFFS()
    return 12
EndFunction

int Function BONDAGE_TYPE_N_PIERCING()
    return 13
EndFunction

int Function BONDAGE_TYPE_V_PIERCING()
    return 14
EndFunction

int function BONDAGE_TYPE_A_PLUG()
    return 15
endfunction

int function BONDAGE_TYPE_V_PLUG()
    return 16
endfunction

int function BONDAGE_TYPE_SUIT()
    return 17
endfunction



bool Function IsBondageItem(Form f)
    bool result
    result = false

    if f.HasKeyWord(zlib.zad_Lockable)
        result = true
    endif

    return result
EndFunction

bool function IsInBondage(Actor a)
    if a.WornHasKeyWord(zlib.zad_Lockable)
        return true
    else
        return false
    endif
endfunction

bool function IsGagged(Actor a)
    if a.WornHasKeyWord(zlib.zad_DeviousGag)
        return true
    else
        return false
    endif
endfunction

bool Function GagHasPlug(Actor a)
    if a.WornHasKeyWord(zlib.zad_DeviousGagPanel)
        return true
    else 
        return false
    endif
EndFunction

Function RemoveGagPlug(Actor act)
    if act.WornHasKeyWord(zlib.zad_DeviousGagPanel)
        zlib.UnPlugPanelGag(act)
    endif
EndFunction

Function ReplaceGagPlug(Actor act)
    if act.WornHasKeyWord(zlib.zad_DeviousGagPanel)
        zlib.PlugPanelGag(act)
    endif
EndFunction


Form function GetFavoriteItem(Actor act, int typeNumber)
    return StorageUtil.GetFormValue(act, "bind_bondage_favorite_" + typeNumber, none)
endfunction

string function GetFavoriteItemName(Actor act, int typeNumber)
    return StorageUtil.GetStringValue(act, "bind_bondage_favorite_name_" + typeNumber, "")
endfunction

function StoreFavoriteItem(Actor act, int typeNumber, Form dev)
    if dev
        StorageUtil.SetStringValue(act, "bind_bondage_favorite_name_" + typeNumber, dev.GetName())
        StorageUtil.SetFormValue(act, "bind_bondage_favorite_" + typeNumber, dev)
    endif
endfunction

function AddHogtieBindings(Actor act, bool useBlindfold = false, bool useHood = false)
    int i = 0
    while i < bind_HogtiedItemsList.GetSize()
        Form dev = bind_HogtiedItemsList.GetAt(i)
        if dev
            bool addItemFlag = false
            Form rdev = zlib.GetRenderedDevice(dev as Armor)

            if useBlindfold && rdev.HasKeyWord(zlib.zad_DeviousBlindfold) && !rdev.HasKeyWord(zlib.zad_DeviousHood)
                addItemFlag = true
            elseif useHood && rdev.HasKeyWord(zlib.zad_DeviousHood)
                addItemFlag = true
            elseif !rdev.HasKeyWord(zlib.zad_DeviousBlindfold) && !rdev.HasKeyWord(zlib.zad_DeviousHood)
                addItemFlag = true
            endif

            if addItemFlag
                AddSpecificItem(act, dev as Armor)
            endif
        endif
        i += 1
    endwhile
endfunction

string function GetRandomSet(string purpose)

    string result = ""

    ;"Harsh Bondage","Location - Castle","Location - Player Home"

    string[] setsList = StorageUtil.StringListToArray(TheWardrobe, "used_for_" + purpose)
    if setsList.Length > 0
        result = setsList[Utility.RandomInt(0, setsList.Length - 1)]
    endif

    return result

endfunction

function EquipSet(Actor act, string setName)

    Form[] setItems = StorageUtil.FormListToArray(TheWardrobe, "set_" + setName)

    int i = 0
    while i < setItems.Length
        Form dev = setItems[i]
        if dev
            AddSpecificItem(act, dev as Armor)
            ;AddItemPassingDevice(act, dev as Armor)
            bind_Utility.DoSleep(sleepTime)
        endif
        i += 1
    endwhile

endfunction

; bool Function SetValid(string setName)

; EndFunction

; string Function GetSetNames()
;     return "Bound Sleep,Harsh Bondage 1,Harsh Bondage 2,Harsh Bondage 3,Harsh Bondage 4,Harsh Bondage 5"
; EndFunction

; string Function GetSet(string setName)
    
; EndFunction

; int function GetSetId(string setName)

; endfunction

; string[] function FindSets(string containsName, bool validOnly = true)
;     return none
; endfunction

; Function EquipSet(Actor act, int idx, string setName, bool eventBondage = false)

; EndFunction 

; Function StoreSet(string setName, string setDetails)

; EndFunction

Function DetectAddedItem(Actor act, Form item, int idx)

    If item as Armor

        if item.HasKeyWord(zlib.zad_Lockable)

            int i = 0
            while i < bind_DDKeywords.GetSize()
                if item.HasKeyWord(bind_DDKeywords.GetAt(i) as Keyword) 
                    if !act.IsInFaction(bind_BondageFactions.GetAt(i) as Faction)
                        act.AddToFaction(bind_BondageFactions.GetAt(i) as Faction)
                    endif
                endif
                i += 1
            endwhile

        endif

    EndIf

EndFunction

Function DetectRemovedItem(Actor act, Form item, int idx)

    If item as Armor

        if item.HasKeyWord(zlib.zad_Lockable)

            int i = 0
            while i < bind_DDKeywords.GetSize()
                if item.HasKeyWord(bind_DDKeywords.GetAt(i) as Keyword) 
                    if act.IsInFaction(bind_BondageFactions.GetAt(i) as Faction) && !act.WornHasKeyWord(bind_DDKeywords.GetAt(i) as Keyword) ;NOTE - pretty sure WornHasKeyWord should work at this point
                        act.RemoveFromFaction(bind_BondageFactions.GetAt(i) as Faction)
                    endif
                endif
                i += 1
            endwhile

        endif

    EndIf

EndFunction

bool eventRemoveGag = false

bool eventReplaceGag = false
bool eventReplaceHeavyBondage = false

function RemoveBondageForEvent(bool addGag)

endfunction

function UntieWristsForEvent(bool addGag)

endfunction

function RestoreBondageAfterEvent()

endfunction

Faction function WearingAnkleShacklesFaction()
    return bind_BondageFactions.GetAt(0) as Faction
endfunction

Faction function WearingArmCuffsFaction()
    return bind_BondageFactions.GetAt(1) as Faction
endfunction

Faction function WearingBlindfoldFaction()
    return bind_BondageFactions.GetAt(2) as Faction
endfunction

Faction function WearingBootsFaction()
    return bind_BondageFactions.GetAt(3) as Faction
endfunction

Faction function WearingBeltFaction()
    return bind_BondageFactions.GetAt(4) as Faction
endfunction

Faction function WearingCollarFaction()
    return bind_BondageFactions.GetAt(5) as Faction
endfunction

Faction function WearingCorsetFaction()
    return bind_BondageFactions.GetAt(6) as Faction
endfunction

Faction function WearingGagFaction()
    return bind_BondageFactions.GetAt(7) as Faction
endfunction

Faction function WearingGlovesFaction()
    return bind_BondageFactions.GetAt(8) as Faction
endfunction

Faction function WearningHarnessFaction()
    return bind_BondageFactions.GetAt(9) as Faction
endfunction

Faction function WearingHeavyBondageFaction()
    return bind_BondageFactions.GetAt(10) as Faction
endfunction

Faction function WearingHoodFaction()
    return bind_BondageFactions.GetAt(11) as Faction
endfunction

Faction function WearingLegCuffsFaction()
    return bind_BondageFactions.GetAt(12) as Faction
endfunction

Faction function WearingNPiercingFaction()
    return bind_BondageFactions.GetAt(13) as Faction
endfunction

Faction function WearingVPiercingFaction()
    return bind_BondageFactions.GetAt(14) as Faction
endfunction

Faction function WearingAPlugFaction()
    return bind_BondageFactions.GetAt(15) as Faction
endfunction

Faction function WearingVPlugFaction()
    return bind_BondageFactions.GetAt(16) as Faction
endfunction

Faction function WearingSuitFaction()
    return bind_BondageFactions.GetAt(17) as Faction
endfunction

Faction function WearingBondageItemFaction(int typeNumber)
    return bind_BondageFactions.GetAt(typeNumber) as Faction
endfunction

Keyword function GetDDKeyword(int idx)
    return bind_DDKeywords.GetAt(idx) as Keyword
endfunction

int function GetTotalDDKeywords()
    return bind_DDKeywords.GetSize()
endfunction

; function ManageFavorites(Actor a)

;     UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

;     int i = 1
;     while i < 4
;         if CurrentFavoriteSet == i && UseFavoriteSet == 0
;             listMenu.AddEntryItem("Favorite Set " + i + " - Current Random Set")
;         else
;             listMenu.AddEntryItem("Favorite Set " + i)
;         endif
;         i += 1
;     endwhile

;     listMenu.AddEntryItem("Browse Bondage Items - DD List")
;     listMenu.AddEntryItem("Browse Bondage Items - Binding List")

;     if UseFavoriteSet == 0
;         listMenu.AddEntryItem("Use Random Favorite Set - YES")
;     elseif UseFavoriteSet == 1
;         listMenu.AddEntryItem("Use Favorite Set - 1")
;     elseif UseFavoriteSet == 2
;         listMenu.AddEntryItem("Use Favorite Set - 2")
;     elseif UseFavoriteSet == 3
;         listMenu.AddEntryItem("Use Favorite Set - 3")
;     endif

;     listMenu.OpenMenu()
;     int listReturn = listMenu.GetResultInt()

;     if listReturn >= 0 && listReturn < 3
;         ViewFavoritesList(a, listReturn + 1)
;     elseif listReturn == 3
;         BrowseDdItemsList(a, none, 1)
;     elseif listReturn == 4
;         BindingBondageTypesMenu(a, 1)
;     elseif listReturn == 5
;         UseFavoriteSet += 1
;         if UseFavoriteSet > 3
;             UseFavoriteSet = 0
;         endif
;         ManageFavorites(a)
;     else
;         ;???
;     endif

; endfunction

; function ViewFavoritesList(Actor a, int setNumber)

;     string skeyf = "bind_favorite_dd_"

;     UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
;     listMenu.AddEntryItem("<-- Back")

;     string[] setKeys = new string[128]
;     Form[] setItems = new Form[128]
;     int[] setBranches = new int[128]
;     int si = 1 ;start at one since 0 is the back button

;     int i = 0
;     int i2 = 0
;     while i < bind_BondageFactions.GetSize()
;         Form[] items = StorageUtil.FormListToArray(a, skeyf + i + "_" + setNumber)
;         if items.Length > 0
;             i2 = 0
;             while i2 < items.Length
;                 listMenu.AddEntryItem(items[i2].GetName())
;                 setKeys[si] = skeyf + i + "_" + setNumber
;                 setItems[si] = items[i2]
;                 setBranches[si] = i
;                 si += 1
;                 i2 += 1
;             endwhile
;         endif
;         i += 1
;     endwhile

;     listMenu.OpenMenu()
;     int listReturn = listMenu.GetResultInt()

;     if listReturn == 0
;         ManageFavorites(a)
;     elseif listReturn > 0
;         BrowseDdItemsListSubMenu(a, none, 3, setBranches[listReturn], setItems[listReturn], setNumber)
;     endif

; endfunction

; bool madeFavoritesChanges

; string favoritesFileName = "bind_dd_favorites.json"

function BrowseDdItemsListSubMenu(Actor a, LeveledItem list, int mode, int branch, Form item, int setNumber = 0)

    string skeyf = "bind_favorite_dd_"

    int[] counts = new int[4]

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    string itemName = item.GetName()

    listMenu.AddEntryItem("<-- Back")
    listMenu.AddEntryItem("Equip this item")

    ; int i = 1
    ; while i < 4
    ;     counts[i] = StorageUtil.FormListCountValue(a, skeyf + branch + "_" + i, item)
    ;     if counts[i] == 1
    ;         listMenu.AddEntryItem(itemName + " - F" + i + " - YES")
    ;     else
    ;         listMenu.AddEntryItem(itemName + " - F" + i)
    ;     endif
    ;     i += 1
    ; endwhile
    ; if mode == 2
    ;     listMenu.AddEntryItem("Equip this item")
    ; endif

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        if mode == 1 || mode == 2
            BrowseDdItemsList(a, list, mode)
        elseif mode == 3
            ;ViewFavoritesList(a, setNumber)
        endif

    ;elseif listReturn > 0 && listReturn < 4
        ; if counts[listReturn] == 0
        ;     PO3_SKSEFunctions.AddKeywordToForm(item, bind_BondageTypeKeywords.GetAt(branch) as Keyword)
        ;     StorageUtil.FormListAdd(a, skeyf + branch + "_" + listReturn, item)
        ;     JsonUtil.FormListAdd(favoritesFileName, "set" + listReturn + ".branch" + branch, item)
        ;     JsonUtil.Save(favoritesFileName)
        ; else
        ;     StorageUtil.FormListRemove(a, skeyf + branch + "_" + listReturn, item, true)
        ;     JsonUtil.FormListRemove(favoritesFileName, "set" + listReturn + ".branch" + branch, item)
        ;     JsonUtil.Save(favoritesFileName)
        ; endif
        ; madeFavoritesChanges = true

        ;BrowseDdItemsListSubMenu(a, list, mode, branch, item, setNumber) ;show this menu again
    elseif listReturn == 1
        AddSpecificItem(a, item as Armor)
    else
        ; if madeFavoritesChanges
        ;     UpdateBondage(a, true)
        ;     madeFavoritesChanges = false
        ; endif
    endif

endfunction

function BrowseDdItemsList(Actor a, LeveledItem list, int mode)

    ObjectReference w = TheWardrobe

    ;actions
    ;1 - set favorites
    ;2 - equip

    int branch = -1

    string skey = "bind_browse_dd"
    string skeyf = "bind_favorite_dd_"

    if list == none
        list = zad_dev_all
        StorageUtil.FormListClear(w, skey)
    endif
    if StorageUtil.FormListCountValue(w, skey, list as Form) == 0
        StorageUtil.FormListAdd(w, skey, list as Form)
    endif

    Form[] nodes = StorageUtil.FormListToArray(w, skey)

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    int size = list.GetNumForms()

    int i = 0
    int i2 = 0

    while i < nodes.Length
        string nodeName = PO3_SKSEFunctions.GetFormEditorID(nodes[i])

        if nodeName == "zad_dev_suits_petsuits"
            branch = BONDAGE_TYPE_SUIT()
        elseif nodeName == "zad_dev_mittens"
            branch = BONDAGE_TYPE_GLOVES()
        elseif nodeName == "zad_dev_heavyrestraints"
            branch = BONDAGE_TYPE_HEAVYBONDAGE()
        elseif nodeName == "zad_dev_gags"
            branch = BONDAGE_TYPE_GAG()
        elseif nodeName == "zad_dev_suits"
            branch = BONDAGE_TYPE_SUIT()
        elseif nodeName == "zad_dev_chastitybelts"
            branch = BONDAGE_TYPE_BELT()
        elseif nodeName == "zad_dev_chastitybras"
            branch = BONDAGE_TYPE_HARNESS() ;TODO - add new bondage type and rule type for this
        elseif nodeName == "zad_dev_harnesses"
            branch = BONDAGE_TYPE_HARNESS()
        elseif nodeName == "zad_dev_boots"
            branch = BONDAGE_TYPE_BOOTS()
        elseif nodeName == "zad_dev_collars"
            branch = BONDAGE_TYPE_COLLAR()
        elseif nodeName == "zad_dev_blindfolds"
            branch = BONDAGE_TYPE_BLINDFOLD()
        elseif nodeName == "zad_dev_armcuffs"
            branch = BONDAGE_TYPE_ARM_CUFFS()
        elseif nodeName == "zad_dev_corsets"
            branch = BONDAGE_TYPE_CORSET()
        elseif nodeName == "zad_dev_plugs_anal"
            branch = BONDAGE_TYPE_A_PLUG()
        elseif nodeName == "zad_dev_plugs_vaginal"
            branch = BONDAGE_TYPE_V_PLUG()
        elseif nodeName == "zad_dev_piercings_nipple"
            branch = BONDAGE_TYPE_N_PIERCING()
        elseif nodeName == "zad_dev_piercings_vaginal"
            branch = BONDAGE_TYPE_V_PIERCING()
        elseif nodeName == "zad_dev_gloves"
            branch = BONDAGE_TYPE_GLOVES()
        elseif nodeName == "zad_dev_hoods"
            branch = BONDAGE_TYPE_HOOD()         
        elseif nodeName == "zad_dev_legcuffs"
            branch = BONDAGE_TYPE_LEG_CUFFS()
        elseif nodeName == "zad_dev_ankleshackles"
            branch = BONDAGE_TYPE_ANKLE_SHACKLES()
        endif

        listMenu.AddEntryItem("<-- " + nodeName)
        i += 1
    endwhile

    i = 0
    while i < size
        Form f = list.GetNthForm(i)

        if f as LeveledItem
            listMenu.AddEntryItem("--> " + PO3_SKSEFunctions.GetFormEditorID(f))
        elseif f as Armor

            string favoriteText = ""

            i2 = 1
            while i2 <= 3
                if StorageUtil.FormListCountValue(a, skeyf + branch + "_" + i2, f) > 0
                    if favoriteText == ""
                        favoriteText = " - "
                    endif
                    favoriteText += "[F" + i2 + "]"
                endif
                i2 += 1
            endwhile

            listMenu.AddEntryItem(f.GetName() + favoriteText)

        endif

        i += 1
    endwhile

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn >= 0 && listReturn < nodes.Length
        ;StorageUtil.FormListRemove(a, skey, nodes[listReturn], true)
        StorageUtil.FormListResize(w, skey, StorageUtil.FormListFind(w, skey, nodes[listReturn]))
        BrowseDdItemsList(a, nodes[listReturn] as LeveledItem, mode)
    endif

    if (listReturn >= nodes.Length && listReturn < (size + nodes.Length))

        Form f = list.GetNthForm(listReturn - nodes.Length)
        if f as LeveledItem
            BrowseDdItemsList(a, f as LeveledItem, mode)
        elseif f as Armor
            ;BrowseDdItemsListSubMenu(Actor a, LeveledItem list, int mode, int branch, Form item)
            BrowseDdItemsListSubMenu(a, list, mode, branch, f)
            ; if mode == 1
            ;     i2 = 1
            ;     bool isOn = false
            ;     while i2 <= 3
            ;         if StorageUtil.FormListCountValue(a, skeyf + branch + "_" + i2, f) > 0
            ;             isOn = true
            ;             StorageUtil.FormListRemove(a, skeyf + branch + "_" + i2, f, true)
            ;             if i2 < 3
            ;                 StorageUtil.FormListAdd(a, skeyf + branch + "_" + (i2 + 1), f)
            ;             endif
            ;             i2 = 100 ;break the loop
            ;         endif
            ;         i2 += 1
            ;     endwhile
            ;     if !isOn
            ;         StorageUtil.FormListAdd(a, skeyf + branch + "_1", f)
            ;     endif
            ;     bind_Utility.WriteToConsole("branch: " + branch)
            ;     BrowseDdItemsList(a, list, mode)
            ; elseif mode == 2

            ; endif
        endif

    else
        ; if madeFavoritesChanges
        ;     UpdateBondage(a, true)
        ;     madeFavoritesChanges = false
        ; endif

    endif

endfunction


function BindingBondageTypesMenu(Actor a, int mode)

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Menu")
    int i = 0
    while i < bondageTypes.Length
        listMenu.AddEntryItem("Add - " + bondageTypes[i])
        i += 1
    endwhile
    listMenu.OpenMenu()

    int listReturn = listMenu.GetResultInt()
    if listReturn == 0
        ;ManageFavorites(a)
    elseif listReturn >= 1 && listReturn <= bondageTypes.Length
        BindingAddBondageTypeItemsMenu(a, listReturn - 1, mode)
    else
        ; if madeFavoritesChanges
        ;     UpdateBondage(a, true)
        ;     madeFavoritesChanges = false
        ; endif
    endif

endfunction

function BindingAddBondageTypeItemsMenu(Actor a, int type, int mode)

    FormList items = bind_BondageList.GetAt(type) as FormList

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Bondage Types")
    int i = 0
    while i < items.GetSize()
        listMenu.AddEntryItem("Add - " + Items.GetAt(i).GetName())
        ;bind_Utility.WriteToConsole("list item: " + Items.GetAt(i).GetName())
        i += 1
    endwhile
    listMenu.OpenMenu()

    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        BindingBondageTypesMenu(a, mode)
    elseif listReturn >= 1 && listReturn <= items.GetSize()
        Form dev = items.GetAt(listReturn - 1)
        BindingBondageItemSubMenu(a, mode, type, dev)
    else
        ; if madeFavoritesChanges
        ;     UpdateBondage(a, true)
        ;     madeFavoritesChanges = false
        ; endif
    endif

endfunction

function BindingBondageItemSubMenu(Actor a, int mode, int branch, Form item)

    string skeyf = "bind_favorite_dd_"

    int[] counts = new int[4]

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    string itemName = item.GetName()

    listMenu.AddEntryItem("<-- Back")
    int i = 1
    while i < 4
        counts[i] = StorageUtil.FormListCountValue(a, skeyf + branch + "_" + i, item)
        if counts[i] == 1
            listMenu.AddEntryItem(itemName + " - F" + i + " - YES")
        else
            listMenu.AddEntryItem(itemName + " - F" + i)
        endif
        i += 1
    endwhile
    if mode == 2
        listMenu.AddEntryItem("Equip this item")
    endif

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        if mode == 1 || mode == 2
            BindingAddBondageTypeItemsMenu(a, branch, mode)
        elseif mode == 3
            ;note supported
        endif

    elseif listReturn > 0 && listReturn < 4
        ; if counts[listReturn] == 0
        ;     PO3_SKSEFunctions.AddKeywordToForm(item, bind_BondageTypeKeywords.GetAt(branch) as Keyword)
        ;     StorageUtil.FormListAdd(a, skeyf + branch + "_" + listReturn, item)
        ;     JsonUtil.FormListAdd(favoritesFileName, "set" + listReturn + ".branch" + branch, item)
        ;     JsonUtil.Save(favoritesFileName)
        ; else
        ;     StorageUtil.FormListRemove(a, skeyf + branch + "_" + listReturn, item, true)
        ;     JsonUtil.FormListRemove(favoritesFileName, "set" + listReturn + ".branch" + branch, item)
        ;     JsonUtil.Save(favoritesFileName)
        ; endif
        ; madeFavoritesChanges = true

        BindingBondageItemSubMenu(a, mode, branch, item) ;show this menu again
    elseif listReturn == 4
        AddSpecificItem(a, item as Armor)
    else
        ; if madeFavoritesChanges
        ;     UpdateBondage(a, true)
        ;     madeFavoritesChanges = false
        ; endif
    endif

endfunction

function LearnWornDdItemsToSet(Actor theSub, int outfitId)

    ; string bondageOutfitFile
    ; bondageOutfitFile = main.GameSaveFolderJson + "bind_bondage_outfit_" + outfitId + ".json"

    GoToState("WorkingState")

    JsonUtil.FormListClear(main.BindingGameOutfitFile, outfitId + "_fixed_bondage_items")
    ;StorageUtil.FormListClear(TheWardrobe, "set_" + loadedSetName)

	Form[] inventory = theSub.GetContainerForms()
	int i = 0
    int kwi = 0
	while i < inventory.Length
        Form dev = inventory[i]
        if dev.HasKeyWord(zlib.zad_inventoryDevice) && theSub.IsEquipped(dev)
            bind_Utility.WriteToConsole("found zad_inventoryDevice: " + dev)
            if dev.HasKeyWord(zlib.zad_QuestItem) || dev.HasKeyWord(zlib.zad_BlockGeneric)
                bind_Utility.WriteToConsole("quest or blocking device")
            else
                bind_Utility.WriteToConsole("dev: " + dev.GetName() + " binding item: " + StorageUtil.GetIntValue(dev, "binding_bondage_item", 0))

                ;StorageUtil.FormListAdd(TheWardrobe, "set_" + loadedSetName, dev, false)
                JsonUtil.FormListAdd(main.BindingGameOutfitFile, outfitId + "_fixed_bondage_items", dev, false)

            endif
        endif
        i += 1
    endwhile

    GoToState("")

    JsonUtil.Save(main.BindingGameOutfitFile)

endfunction

function SaveWornDdItemsAsSet(Actor theSub)

    string bondageOutfitFile

    UIExtensions.InitMenu("UITextEntryMenu")
    UIExtensions.OpenMenu("UITextEntryMenu")
    string result = UIExtensions.GetMenuResultString("UITextEntryMenu")
    if result != ""
        int uid = Utility.RandomInt(100000000,999999999)
        string fileName = main.GameSaveFolderJson + "bind_bondage_outfit_" + uid + ".json"
        JsonUtil.SetStringValue(fileName, "bondage_outfit_name", result)
        JsonUtil.SetIntValue(fileName, "outfit_id", uid)
        JsonUtil.Save(fileName)
        bondageOutfitFile = fileName
        ;StorageUtil.StringListAdd(TheWardrobe, "sets_list", result)
    else
        return
    endif

    GoToState("WorkingState")

    JsonUtil.FormListClear(bondageOutfitFile, "fixed_bondage_items")
    ;StorageUtil.FormListClear(TheWardrobe, "set_" + loadedSetName)

	Form[] inventory = theSub.GetContainerForms()
	int i = 0
    int kwi = 0
	while i < inventory.Length
        Form dev = inventory[i]
        if dev.HasKeyWord(zlib.zad_inventoryDevice) && theSub.IsEquipped(dev)
            bind_Utility.WriteToConsole("found zad_inventoryDevice: " + dev)
            if dev.HasKeyWord(zlib.zad_QuestItem) || dev.HasKeyWord(zlib.zad_BlockGeneric)
                bind_Utility.WriteToConsole("quest or blocking device")
            else
                bind_Utility.WriteToConsole("dev: " + dev.GetName() + " binding item: " + StorageUtil.GetIntValue(dev, "binding_bondage_item", 0))

                ;StorageUtil.FormListAdd(TheWardrobe, "set_" + loadedSetName, dev, false)
                JsonUtil.FormListAdd(bondageOutfitFile, "fixed_bondage_items", dev, false)

            endif
        endif
        i += 1
    endwhile

    GoToState("")

    JsonUtil.Save(bondageOutfitFile)

    ; ;display dialogue 
    ; UIExtensions.InitMenu("UITextEntryMenu")
    ; UIExtensions.OpenMenu("UITextEntryMenu")
    ; string setName = UIExtensions.GetMenuResultString("UITextEntryMenu")
    ; if setName != ""
    ;     StorageUtil.StringListAdd(TheWardrobe, "sets_list", setName)
    ; else
    ;     return
    ; endif

    ; StorageUtil.FormListClear(TheWardrobe, "set_" + setName)

	; Form[] inventory = a.GetContainerForms()
	; int i = 0
    ; int kwi = 0
	; while i < inventory.Length
    ;     Form dev = inventory[i]
    ;     if dev.HasKeyWord(zlib.zad_inventoryDevice) && a.IsEquipped(dev)
    ;         bind_Utility.WriteToConsole("found zad_inventoryDevice: " + dev)
    ;         if dev.HasKeyWord(zlib.zad_QuestItem) || dev.HasKeyWord(zlib.zad_BlockGeneric)
    ;             bind_Utility.WriteToConsole("quest or blocking device")
    ;         else
    ;             bind_Utility.WriteToConsole("dev: " + dev.GetName() + " binding item: " + StorageUtil.GetIntValue(dev, "binding_bondage_item", 0))

    ;             StorageUtil.FormListAdd(TheWardrobe, "set_" + setName, dev, false)


    ;         endif
    ;     endif
    ;     i += 1
    ; endwhile

    debug.MessageBox("Set " + result + " saved")

endfunction

string[] function SearchDeviousItems(string keywords)

    string[] keywordArr = StringUtil.Split(keywords, ",")

    string f = "binding/bind_dd_db.json"

    int i = 0

    int counter = 0
    int groupNmber = 1

    if !JsonUtil.JsonExists(f)

        bind_Utility.WriteToConsole("Creating DD database json")

        while i < bind_dd_all.GetSize()
            Form dev =  bind_dd_all.GetAt(i)
            if counter > 100
                counter = 0
                groupNmber += 1
            Endif
            JsonUtil.StringListAdd(f, "group_" + groupNmber + "_names", dev.GetName())
            JsonUtil.FormListAdd(f, "group_" + groupNmber + "_items", dev)
            i += 1
            counter += 1
        endwhile

        JsonUtil.Save(f)

    endif

    string result = ""
    int foundCount = 0

    string resultsFile = "binding/bind_dd_search_result.json"
    JsonUtil.StringListClear(resultsFile, "found_names")
    JsonUtil.FormListClear(resultsFile, "found_items")

    i = 1
    while i < 20
        int idx = 0
        int idx2 = 0
        string[] itemNames = JsonUtil.StringListToArray(f, "group_" + i + "_names")
        Form[] items = JsonUtil.FormListToArray(f, "group_" + i + "_items")
        if itemNames.Length == 0
            i = 20 ;break if empty
        endif
        while idx < itemNames.Length
            string itemName = itemNames[idx]
            bool passedTests = true
            idx2 = 0
            while idx2 < keywordArr.Length
                string searchFor = keywordArr[idx2]
                if StringUtil.Find(searchFor, "-", 0) > -1
                    searchFor = StringUtil.SubString(searchFor, 1) ;not in string condition
                    if StringUtil.Find(itemName, searchFor, 0) > -1
                        passedTests = false
                    endif
                else
                    if StringUtil.Find(itemName, searchFor, 0) == -1
                        passedTests = false
                    endif
                endif
                idx2 += 1
            endwhile
            if passedTests
                if result == ""
                    result = itemName
                else
                    result += "|" + itemName
                endif
                JsonUtil.FormListAdd(resultsFile, "found_items", items[idx])
                JsonUtil.StringListAdd(resultsFile, "found_names", itemName)
            endif
            idx += 1
        endwhile
        i += 1
    endwhile
    JsonUtil.Save(resultsFile)

    return StringUtil.Split(result, "|")

endfunction


bind_BondageManager function GetBindingBondageManager() global
    return Quest.GetQuest("bind_MainQuest") as bind_BondageManager
endfunction

bind_MainQuestScript property main auto
bind_RulesManager property rms auto

zadLibs property zlib auto

FormList property bind_dd auto
FormList property bind_dd_all auto

FormList property bind_BondageList auto
FormList property bind_BondageFactions auto
FormList property bind_DDKeywords auto
Formlist property bind_HogtiedItemsList auto
Formlist property bind_BondageTypeKeywords auto

ObjectReference property TheWardrobe auto

Faction property bind_BondageRulesDisableFaction auto
Faction property bind_EventActiveFaction auto

FormList property bind_BondageRulesFactionList auto

LeveledItem property zad_dev_all auto

zadDeviceLists property ddLists auto