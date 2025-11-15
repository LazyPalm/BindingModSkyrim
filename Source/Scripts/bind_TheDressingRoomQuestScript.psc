Scriptname bind_TheDressingRoomQuestScript extends Quest  

Actor theSub
Actor theDom

bool pressedButton
string[] bondageTypes
string[] materialTypes
string[] usageList
string[] usageKey
string[] blocks
int[] blockSlots

string loadedSetName = ""
int loadedSetId = 0

string bondageOutfitFile

int wearingSetId

event OnInit()

    if self.IsRunning()
        
        GoToState("")

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
        RegisterForModEvent("bind_EventCombatStartedInEvent", "CombatStartedInEvent")

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        StorageUtil.FormListClear(theSub, "binding_bondage_specific_list")

        blocks = new string[13]
        blocks[0] = "Body - Slot 32"
        blocks[1] = "Hands - Slot 33"
        blocks[2] = "Forearms - Slot 34"
        blocks[3] = "Feet  - Slot 37"
        blocks[4] = "Chest Primary - Slot 46"
        blocks[5] = "Chest Secondary - Slot 56"
        blocks[6] = "Pelvis Primary - Slot 49"
        blocks[7] = "Pelvis Secondary - Slot 54"
        blocks[8] = "Leg Primary - Slot 53"
        blocks[9] = "Leg Secondary - Slot 54"
        blocks[10] = "Shoulder - Slot 57"
        blocks[11] = "Arm Primary - Slot 59"
        blocks[12] = "Arm Secondary - Slot 58"

        blockSlots = new int[13]
        blockSlots[0] = 0x00000004  ;32
        blockSlots[1] = 0x00000008  ;33
        blockSlots[2] = 0x00000010  ;34
        blockSlots[3] = 0x00000080  ;37
        blockSlots[4] = 0x00010000 ;46
        blockSlots[5] = 0x04000000 ;56
        blockSlots[6] = 0x00080000 ;49
        blockSlots[7] = 0x00400000 ;52
        blockSlots[8] = 0x00800000 ;53
        blockSlots[9] = 0x01000000 ;54
        blockSlots[10] = 0x08000000 ;57
        blockSlots[11] = 0x20000000 ;59
        blockSlots[12] = 0x10000000 ;58

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

        materialTypes = new string[14]
        materialTypes[0] = "Natural Rope"
        materialTypes[1] = "Black Rope"
        materialTypes[2] = "Red Rope"
        materialTypes[3] = "White Rope"
        materialTypes[4] = "Lustrous"
        materialTypes[5] = "Ebonite Black"
        materialTypes[6] = "Ebonite Red"
        materialTypes[7] = "Ebonite White"
        materialTypes[8] = "Leather Black"
        materialTypes[9] = "Leather Red"
        materialTypes[10] = "Leather White"
        materialTypes[11] = "Transparent"
        materialTypes[12] = "Iron/Steel"
        materialTypes[13] = "Chain"

        string temp = "location_all_areas|location_any_city|location_dawnstar|location_falkreath|location_windhelm|location_markarth|location_morthal|location_riften|"
        temp += "location_solitude|location_high_hrothgar|location_whiterun|location_winterhold|location_raven Rock|location_towns|location_player_home|location_safe_area|"
        temp += "location_unsafe_area|location_inn|event_any_event|event_harsh_bondage|event_bound_masturbation|event_bound_sex|event_dairy|event_bound_sleep|event_camping|"
        temp += "event_put_on_display|event_public_humilation|event_whipping|event_souls_from_bones|event_word_wall|event_gagged_for_punishment|event_go_adventuring|event_free_for_work|"
        temp += "event_hogtied|event_simple_slavery"
        usageKey = StringUtil.Split(temp, "|")

        temp = "Location - All Areas|Location - Any City|Location - Dawnstar|Location - Falkreath|Location - Windhelm|Location - Markarth|Location - Morthal|Location - Riften"
        temp += "|Location - Solitude|Location - High Hrothgar|Location - Whiterun|Location - Winterhold|Location - Raven Rock |Location - Towns|Location - Player Home|Location - Safe Areas"
        temp += "|Location - Unsafe Areas|Location - Inn|Event - Any Event|Event - Harsh Bondage|Event - Bound Masturbation|Event - Bound Sex|Event - Dairy|Event - Bound Sleep|Event - Camping"
        temp += "|Event - Put On Display|Event - Public Humliation|Event - Whipping|Event - Souls From Bones|Event - Word Wall|Event - Gagged For Punishment|Event - Go Adventuring"
        temp += "|Event - Free For Work|Event - Hogtied|Event - Simple Slavery"
        usageList = StringUtil.Split(temp, "|")

        ; usageKey = new string[30]
        ; usageKey[0] = "location_all_areas"
        ; usageKey[1] = "location_any_city"
        ; usageKey[2] = "location_dawnstar"
        ; usageKey[3] = "location_falkreath"
        ; usageKey[4] = "location_windhelm"
        ; usageKey[5] = "location_markarth"
        ; usageKey[6] = "location_morthal"
        ; usageKey[7] = "location_riften"
        ; usageKey[8] = "location_solitude"
        ; usageKey[9] = "location_high_hrothgar"
        ; usageKey[10] = "location_whiterun"
        ; usageKey[11] = "location_winterhold"
        ; usageKey[12] = "location_raven Rock"       
        ; usageKey[13] = "location_towns"
        ; usageKey[14] = "location_player_home"
        ; usageKey[15] = "event_any_event"
        ; usageKey[16] = "event_harsh_bondage"
        ; usageKey[17] = "event_bound_masturbation"
        ; usageKey[18] = "event_bound_sex"
        ; usageKey[19] = "event_dairy"
        ; usageKey[20] = "event_bound_sleep"
        ; usageKey[21] = "event_camping"
        ; usageKey[22] = "event_put_on_display"
        ; usageKey[23] = "event_public_humilation"
        ; usageKey[24] = "event_whipping"
        ; usageKey[25] = "event_souls_from_bones"
        ; usageKey[26] = "event_word_wall"
        ; usageKey[27] = "event_gagged_for_punishment"
        ; usageKey[28] = "event_go_adventuring"
        ; usageKey[29] = "event_free_for_work"

        ; usageList = new string[30]
        ; usageList[0] = "Location - All Areas"
        ; usageList[1] = "Location - Any City"
        ; usageList[2] = "Location - Dawnstar"
        ; usageList[3] = "Location - Falkreath"
        ; usageList[4] = "Location - Windhelm"
        ; usageList[5] = "Location - Markarth"
        ; usageList[6] = "Location - Morthal"
        ; usageList[7] = "Location - Riften"
        ; usageList[8] = "Location - Solitude"
        ; usageList[9] = "Location - High Hrothgar"
        ; usageList[10] = "Location - Whiterun"
        ; usageList[11] = "Location - Winterhold"
        ; usageList[12] = "Location - Raven Rock"       
        ; usageList[13] = "Location - Towns"
        ; usageList[14] = "Location - Player Home"
        ; usageList[15] = "Event - Any Event"
        ; usageList[16] = "Event - Harsh Bondage"
        ; usageList[17] = "Event - Bound Masturbation"
        ; usageList[18] = "Event - Bound Sex"
        ; usageList[19] = "Event - Dairy"
        ; usageList[20] = "Event - Bound Sleep"
        ; usageList[21] = "Event - Camping"
        ; usageList[22] = "Event - Put On Display"
        ; usageList[23] = "Event - Public Humliation"
        ; usageList[24] = "Event - Whipping"
        ; usageList[25] = "Event - Souls From Bones"
        ; usageList[26] = "Event - Word Wall"
        ; usageList[27] = "Event - Gagged For Punishment"
        ; usageList[28] = "Event - Go Adventuring"
        ; usageList[29] = "Event - Free For Work"

        ; usageList[17] = "Day - Sundas"
        ; usageList[18] = "Day - Morndas"
        ; usageList[19] = "Day - Tirdas"
        ; usageList[20] = "Day - Middas"
        ; usageList[21] = "Day - Turdas"
        ; usageList[22] = "Day - Fredas"
        ; usageList[23] = "Day - Loredas"


        SetObjectiveDisplayed(10, true)

        ; GoToState("WantsToTalk")
        ; RegisterForSingleUpdate(1.0)

        bcs.DoStartEvent()
        bcs.SetEventName(self.GetName())

        wearingSetId = StorageUtil.GetIntValue(theSub, "bind_wearing_outfit_id")
        StorageUtil.SetIntValue(theSub, "bind_wearing_outfit_id", 0)

        bind_Utility.DisablePlayer()
        ;fs.EventGetSubReady(theSub, theDom) ;, playAnimations = true, stripClothing = true, addGag = false, freeWrists = false, removeAll = true)
        
        if bind_Utility.ConfirmBox("Remove worn bondage items?")
            bms.RemoveAllBondageItems(theSub, true) ;bms.RemoveAllDetectedBondageItems(theSub)
            bind_Utility.DoSleep(1.0)
        endif

        if bind_Utility.ConfirmBox("Remove worn clothing?")
            gms.RemoveWornGear(theSub)
            bind_Utility.DoSleep(1.0)
        endif
        
        bind_Utility.EnablePlayer()

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("the dressing room quest safeword ending")
    self.Stop()
endevent

event CombatStartedInEvent(Form akTarget)
    if bind_Utility.ConfirmBox("Your party has been attacked. End this?", "I must fight", fs.GetDomTitle() + " can handle this. Leave me.")
        fs.Safeword()
    endif
endevent

event PressedAction(bool longPress)

    if !pressedButton
        pressedButton = true
        ParentMenu()
        pressedButton = false
    endif

endevent

state WorkingState

    event PressedAction(bool longPress)
    endevent

endstate

function ParentMenu()


    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("End This")
    listMenu.AddEntryItem("Clear Items")
    if loadedSetName == ""
        listMenu.AddEntryItem("Save Outfit - (new)")
    else
        listMenu.AddEntryItem("Save Outfit - " + loadedSetName)
    endif
    listMenu.AddEntryItem("Load Outfit")
    ;listMenu.AddEntryItem("Add Item - By Bondage Type")
    listMenu.AddEntryItem("Add Item") ; - Binding List")
    listMenu.AddEntryItem("Item Search")
    ;listMenu.AddEntryItem("Add Items - DD Lists")
    listMenu.AddEntryItem("Remove Item")

    if loadedSetName == ""
        
    else
        listMenu.AddEntryItem("Outfit Uses - " + loadedSetName)
        listMenu.AddEntryItem("Delete Outfit - " + loadedSetName)
        listMenu.AddEntryItem("Armor/Clothing Blocks - " + loadedSetName)
    endif

    listMenu.OpenMenu()

    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        EndTheQuest()
    elseif listReturn == 1
        ClearItemsMenu()
    elseif listReturn == 2
        SaveSet()
    elseif listReturn == 3     
        LoadSetsMenu()
    elseif listReturn == 4
        BondageTypesMenu()
    elseif listReturn == 5
        BondageItemSearch()
    ; elseif listReturn == 5
    ;     bms.BrowseDdItemsList(theSub, none, 2)
    ;     ;MaterialTypeMenu()
    elseif listReturn == 6
        RemoveItemsMenu()
    elseif listReturn == 7
        SetUsesMenu()
    elseif listReturn == 8
        DeleteSetMenu()
    elseif listReturn == 9
        SetArmorBlocks()
    
    endif

endfunction

string keywords
string[] searchResults
Form[] searchResultsForms
string resultsFile = "binding/bind_dd_search_result.json"

function BondageItemSearch()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Menu")
    listMenu.AddEntryItem("Directions")
    listMenu.AddEntryItem("Keywords: " + keywords)

    int i = 0
    while i < searchResults.Length
        listMenu.AddEntryItem(searchResults[i])
        i += 1
    endwhile

    listMenu.OpenMenu()

    int listReturn = listMenu.GetResultInt()
    if listReturn == 0
        ParentMenu()
    elseif listReturn == 1
        debug.MessageBox("Enter keywords seperated by commas to search for items. If you want to exclude a keyword use a minus in front of the keyword. Example: red,leather,-collar")
        ;BondageItemSearch()
    elseif listReturn == 2
        UIExtensions.InitMenu("UITextEntryMenu")
        UIExtensions.OpenMenu("UITextEntryMenu")
        string result = UIExtensions.GetMenuResultString("UITextEntryMenu")
        if result != ""
            keywords = result

            searchResultsForms = bind_SkseFunctions.SearchFormListsByKeyword(keywords, bms.bind_zap_all, bms.bind_dd_all)
            string buffer = ""
            int idx = 0
            while idx < searchResultsForms.Length
                if buffer != "" 
                    buffer += "|"
                endif
                buffer += searchResultsForms[idx].GetName()
                idx += 1
            endwhile

            searchResults = StringUtil.Split(buffer, "|") ;bmanage.SearchDeviousItems(value)

            ;searchResults = bms.SearchDeviousItems(keywords)
            BondageItemSearch()
        endif
    elseif listReturn > 2
        Form dev = searchResultsForms[listReturn - 3] ;JsonUtil.FormListGet(resultsFile, "found_items", listReturn - 3)
        if dev
            bms.AddSpecificItem(theSub, dev as Armor)
        endif
    endif

endfunction

function SetArmorBlocks()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Menu")

    int i = 0
    while i < blocks.Length

        ;bind_Utility.WriteToConsole("used_for_" + usageList[i] + " count: " + StorageUtil.StringListCount(TheWardrobe, "used_for_" + usageList[i]))

        bool hasBlock = JsonUtil.StringListHas(mqs.BindingGameOutfitFile, loadedSetId + "_blocks", blocks[i])

        string blockText = ""
        if hasBlock
            blockText = " - Yes"
        endif

        listMenu.AddEntryItem("Block - " + blocks[i] + blockText)
        i += 1
    endwhile
    listMenu.OpenMenu()

    int listReturn = listMenu.GetResultInt()
    if listReturn == 0
        ParentMenu()
    elseif listReturn >= 1
        int id = listReturn - 1
        bool hasBlock = JsonUtil.StringListHas(mqs.BindingGameOutfitFile, loadedSetId + "_blocks", blocks[id])
        if hasBlock
            JsonUtil.StringListRemove(mqs.BindingGameOutfitFile, loadedSetId + "_blocks", blocks[id])
            JsonUtil.IntListRemove(mqs.BindingGameOutfitFile, loadedSetId + "_block_slots", blockSlots[id])
            JsonUtil.Save(mqs.BindingGameOutfitFile)
        else
            JsonUtil.StringListAdd(mqs.BindingGameOutfitFile, loadedSetId + "_blocks", blocks[id])
            JsonUtil.IntListAdd(mqs.BindingGameOutfitFile, loadedSetId + "_block_slots", blockSlots[id])
            JsonUtil.Save(mqs.BindingGameOutfitFile)
        endif

        SetArmorBlocks()
    endif

endfunction

function SetUsesMenu()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Menu")

    int i = 0
    while i < usageList.Length

        ;bind_Utility.WriteToConsole("used_for_" + usageList[i] + " count: " + StorageUtil.StringListCount(TheWardrobe, "used_for_" + usageList[i]))

        bool hasSet = JsonUtil.StringListHas(mqs.BindingGameOutfitFile, loadedSetId + "_used_for", usageKey[i])

        string inUseText = ""
        if hasSet
            inUseText = " - Yes"
        endif

        listMenu.AddEntryItem("Use For - " + usageList[i] + inUseText)
        i += 1
    endwhile
    listMenu.OpenMenu()

    int listReturn = listMenu.GetResultInt()
    if listReturn == 0
        ParentMenu()
    elseif listReturn >= 1

        bool hasSet =  JsonUtil.StringListHas(mqs.BindingGameOutfitFile, loadedSetId + "_used_for", usageKey[i])
        if hasSet
            ;bind_Utility.WriteToConsole("removing from uses: used_for_" + usageKey[listReturn - 1] + " set: " + loadedSetName)
            JsonUtil.StringListRemove(mqs.BindingGameOutfitFile, loadedSetId + "_used_for", usageKey[listReturn - 1])
            JsonUtil.Save(mqs.BindingGameOutfitFile)
        else
            JsonUtil.StringListAdd(mqs.BindingGameOutfitFile, loadedSetId + "_used_for", usageKey[listReturn - 1], false)
            JsonUtil.Save(mqs.BindingGameOutfitFile)
            ;bind_Utility.WriteToConsole("adding to uses: used_for_" + usageKey[listReturn - 1] + " set: " + loadedSetName + " idx: " + idx)
        endif

        SetUsesMenu()

    endif

endfunction

function DeleteSetMenu()

    debug.MessageBox("not working yet")
    return

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    listMenu.AddEntryItem("Delete set " + loadedSetName)
    listMenu.AddEntryItem("Keep set " + loadedSetName)
    listMenu.OpenMenu()

    int listReturn = listMenu.GetResultInt()
    if listReturn == 0

        ;remove favorites
        int i = 0
        while i < usageList.Length
            bind_Utility.WriteToConsole("used_for_" + usageList[i] + " count: " + StorageUtil.StringListCount(TheWardrobe, "used_for_" + usageList[i]))
            bool hasSet = StorageUtil.StringListHas(TheWardrobe, "used_for_" + usageList[i], loadedSetName)
            if hasSet
                StorageUtil.StringListRemove(TheWardrobe, "used_for_" + usageList[i], loadedSetName, true)
                bind_Utility.WriteToConsole("removed from: used_for_" + usageList[i])
            endif
            i += 1
        endwhile

        ;remove from sets list
        StorageUtil.StringListRemove(TheWardrobe, "sets_list", loadedSetName)

        ;remove set
        StorageUtil.FormListClear(TheWardrobe, "set_" + loadedSetName)

        bms.RemoveAllDetectedBondageItems(theSub)

        debug.MessageBox("Set " + loadedSetName + " deleted")
        loadedSetName = ""

    endif


endfunction

function ClearItemsMenu()

    if loadedSetName != ""

        UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
        listMenu.AddEntryItem("Keep set " + loadedSetName + " open")
        listMenu.AddEntryItem("Close set " + loadedSetName)
        listMenu.OpenMenu()

        int listReturn = listMenu.GetResultInt()

        StorageUtil.FormListClear(theSub, "binding_bondage_specific_list")

        if listReturn == 0
        else
            loadedSetName = ""
            StorageUtil.SetIntValue(theSub, "bind_wearing_outfit_id", 0)
        endif

    else

        StorageUtil.FormListClear(theSub, "binding_bondage_specific_list")
        debug.MessageBox("Items cleared")

    endif

    bms.RemoveAllBondageItems(theSub, true)
    ;bms.RemoveAllDetectedBondageItems(theSub)

    gms.RemoveWornGear(theSub)

endfunction

function LoadSetsMenu()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Menu")

    ;string[] setsList = StorageUtil.StringListToArray(TheWardrobe, "sets_list")

    ; StorageUtil.StringListClear(theSub, "bind_bondage_outfits_list")
    ; StorageUtil.IntListClear(theSub, "bind_bondage_files_list")

    ; string[] list = MiscUtil.FilesInFolder(mqs.GameSaveFolder)
    ; int i = 0
    ; while i < list.Length
    ;     StorageUtil.StringListAdd(theSub, "bind_bondage_outfits_list", JsonUtil.GetStringValue(mqs.GameSaveFolderJson + list[i], "bondage_outfit_name", ""))
    ;     StorageUtil.IntListAdd(theSub, "bind_bondage_files_list", JsonUtil.GetIntValue(mqs.GameSaveFolderJson + list[i], "outfit_id", 0))
    ;     i += 1
    ; endwhile

    int i

    string[] bondageSetNames = JsonUtil.StringListToArray(mqs.BindingGameOutfitFile, "outfit_name_list")
    int[] bondageSetIds = JsonUtil.IntListToArray(mqs.BindingGameOutfitFile, "outfit_id_list")

    i = 0
    while i < bondageSetNames.Length
        listMenu.AddEntryItem("Outfit - " + bondageSetNames[i])
        i += 1
    endwhile
    listMenu.OpenMenu()

    int listReturn = listMenu.GetResultInt()
    if listReturn == 0
        ParentMenu()
    elseif listReturn >= 1
        loadedSetName = bondageSetNames[listReturn - 1]
        loadedSetId = bondageSetIds[listReturn - 1]
        ;bondageOutfitFile = mqs.GameSaveFolderJson + "bind_bondage_outfit_" + loadedSetId + ".json"
        LoadSet()
        StorageUtil.SetIntValue(theSub, "bind_wearing_outfit_id", loadedSetId)
    endif

endfunction

function MaterialTypeMenu()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Menu")
    int i = 0
    while i < materialTypes.Length
        listMenu.AddEntryItem("Add - " + materialTypes[i])
        i += 1
    endwhile
    listMenu.OpenMenu()

    int listReturn = listMenu.GetResultInt()
    if listReturn == 0
        ParentMenu()
    elseif listReturn >= 1
        AddMaterialTypeItemsMenu(listReturn - 1)
    endif

endfunction

function RemoveItemsMenu()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    Form[] items = bms.GetSpecificItems(theSub)

    listMenu.AddEntryItem("<-- Return To Menu")
    int i = 0
    while i < items.Length
        listMenu.AddEntryItem("Remove - " + items[i].GetName())
        i += 1
    endwhile
    listMenu.OpenMenu()

    int listReturn = listMenu.GetResultInt()
    if listReturn == 0
        ParentMenu()
    elseif listReturn >= 1
        if bms.RemoveSpecificItem(theSub, items[listReturn - 1])
        endif
    endif

endfunction

function AddMaterialTypeItemsMenu(int type)

    FormList items = bind_MaterialList.GetAt(type) as FormList

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Material Types")
    int i = 0
    while i < items.GetSize()
        listMenu.AddEntryItem("Add - " + Items.GetAt(i).GetName())
        ;bind_Utility.WriteToConsole("list item: " + Items.GetAt(i).GetName())
        i += 1
    endwhile
    listMenu.OpenMenu()

    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        MaterialTypeMenu()
    elseif listReturn >= 1
        Form dev = items.GetAt(listReturn - 1)
        bms.AddSpecificItem(theSub, dev as Armor)
        ;bms.AddItemPassingDevice(theSub, dev as Armor)
        ;debug.MessageBox(dev)
    endif

endfunction

function BondageTypesMenu()

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
        ParentMenu()
    elseif listReturn >= 1
        AddBondageTypeItemsMenu(listReturn - 1)
    endif

endfunction

function AddBondageTypeItemsMenu(int type)

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
        BondageTypesMenu()
    elseif listReturn >= 1
        Form dev = items.GetAt(listReturn - 1)
        bms.AddSpecificItem(theSub, dev as Armor)
        ;bms.AddItemPassingDevice(theSub, dev as Armor)
        ;debug.MessageBox(dev)
    endif

endfunction

function EndTheQuest()

    SetObjectiveCompleted(10)

    bind_Utility.DisablePlayer()

    ;bms.RemoveAllDetectedBondageItems(theSub)

    ;do a if dd keyword check and run this if so
    ;bms.RemoveAllDetectedBondageItems(theSub)

    ; bind_Utility.DoSleep(2.0)
    fs.EventCleanUpSub(theSub, theDom, true)
    
    bind_Utility.EnablePlayer()

    SetObjectiveDisplayed(10, false)
    SetStage(20)

    bcs.DoEndEvent()

    self.Stop()

endfunction

function SaveSet()

    if loadedSetName == ""
        ;display dialogue 
        UIExtensions.InitMenu("UITextEntryMenu")
        UIExtensions.OpenMenu("UITextEntryMenu")
        string result = UIExtensions.GetMenuResultString("UITextEntryMenu")
        if result != ""
            loadedSetName = result

            int uid = Utility.RandomInt(100000000,999999999)
            ;string fileName = mqs.GameSaveFolderJson + "bind_bondage_outfit_" + uid + ".json"
            
            JsonUtil.StringListAdd(mqs.BindingGameOutfitFile, "outfit_name_list", loadedSetName)
            JsonUtil.IntListAdd(mqs.BindingGameOutfitFile, "outfit_id_list", uid)

            ;JsonUtil.SetStringValue(fileName, "bondage_outfit_name", loadedSetName)
            ;JsonUtil.SetIntValue(fileName, "outfit_id", uid)
            JsonUtil.Save(mqs.BindingGameOutfitFile)
            ;bondageOutfitFile = fileName
            loadedSetId = uid

            JsonUtil.Save(mqs.BindingGameOutfitFile)

            ;StorageUtil.StringListAdd(TheWardrobe, "sets_list", result)
        else
            return
        endif
    else
    endif

    GoToState("WorkingState")

    JsonUtil.FormListClear(mqs.BindingGameOutfitFile, "fixed_bondage_items")
    ;StorageUtil.FormListClear(TheWardrobe, "set_" + loadedSetName)

	; Form[] inventory = theSub.GetContainerForms()
	; int i = 0
    ; int kwi = 0
	; while i < inventory.Length
    ;     Form dev = inventory[i]
    ;     if dev.HasKeyWord(zlib.zad_inventoryDevice) && theSub.IsEquipped(dev)
    ;         bind_Utility.WriteToConsole("found zad_inventoryDevice: " + dev)
    ;         if dev.HasKeyWord(zlib.zad_QuestItem) || dev.HasKeyWord(zlib.zad_BlockGeneric)
    ;             bind_Utility.WriteToConsole("quest or blocking device")
    ;         else
    ;             bind_Utility.WriteToConsole("dev: " + dev.GetName() + " binding item: " + StorageUtil.GetIntValue(dev, "binding_bondage_item", 0))

    ;             ;StorageUtil.FormListAdd(TheWardrobe, "set_" + loadedSetName, dev, false)
    ;             JsonUtil.FormListAdd(bondageOutfitFile, "fixed_bondage_items", dev, false)

    ;         endif
    ;     endif
    ;     i += 1
    ; endwhile

    bms.LearnWornDdItemsToSet(theSub, loadedSetId)

    gms.LearnWornItemsForBondageOutfit(theSub, loadedSetId)

    GoToState("") 

    debug.MessageBox("Set " + loadedSetName + " saved")

endfunction

function LoadSet()

    GoToState("WorkingState")

    bms.RemoveAllBondageItems(theSub, true)

    ;bms.RemoveAllDetectedBondageItems(theSub)

    ;Form[] setItems = StorageUtil.FormListToArray(TheWardrobe, "set_" + loadedSetName)

    int i

    Form[] wornItems = JsonUtil.FormListToArray(mqs.BindingGameOutfitFile, loadedSetId + "_fixed_worn_items")
    i = 0
    while i < wornItems.Length
        Form item = wornItems[i]
        if theSub.GetItemCount(item) > 0
            if !theSub.IsEquipped(item)
                theSub.EquipItem(item, false, true)
                bind_Utility.DoSleep(0.25)
            endif
        else
            bind_Utility.WriteToConsole(item.GetName() + " is no longer in your bag")
        endif
        i += 1
    endwhile

    Form[] setItems = JsonUtil.FormListToArray(mqs.BindingGameOutfitFile, loadedSetId + "_fixed_bondage_items")
    i = 0
    while i < setItems.Length
        Form dev = setItems[i]
        if dev
            ;bms.AddItemPassingDevice(theSub, dev as Armor)
            bms.AddSpecificItem(theSub, dev as Armor)
            bind_Utility.DoSleep(0.25)
        endif
        i += 1
    endwhile

    GoToState("")

endfunction

bind_MainQuestScript property mqs auto
bind_BondageManager property bms auto
bind_Controller property bcs auto
bind_GearManager property gms auto
bind_Functions property fs auto

FormList property bind_BondageList auto
FormList property bind_MaterialList auto

ObjectReference property TheWardrobe auto

zadLibs property zlib auto