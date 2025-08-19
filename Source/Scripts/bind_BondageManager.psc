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

string bondageOutfitsFile = "bind_bondage_outfits.json"

bind_BondageManager function GetBondageManager() global 
    return Quest.GetQuest("bind_MainQuest") as bind_BondageManager
endfunction

Function LoadGame(bool rebuildStorage = false)
    
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

function EquipBondageOutfit(Actor a, int setId)

    int i

    EquippingBondageOutfit = true

    string f = "bind_bondage_outfit_" + setId + ".json"

    bind_Utility.WriteToConsole("EquipBondageOutfit f: " + f)

    RemoveAllBondageItems(a, true)

    if JsonUtil.GetIntValue(f, "remove_existing_gear", 0) == 1
        Form[] inventory = a.GetContainerForms()
        i = 0
        while i < inventory.Length
            Form item = inventory[i]
            If item.IsPlayable()
                if a.IsEquipped(item) && !item.HasKeyWordString("zad_Lockable") && !item.HasKeyWordString("zad_InventoryDevice") && !item.HasKeyWordString("sexlabnostrip")
                    a.UnequipItem(item, false, true)
                endif
            endif
            i += 1
        endwhile
    else
        ;note - no need to do this if all existing gear is being removed
        ;unequip blocks
        int[] blocks = JsonUtil.IntListToArray(f, "block_slots")
        i = 0
        while i < blocks.Length
            Armor item = a.GetWornForm(blocks[i]) as Armor
            if item != none
                if !item.HasKeyWordString("zad_Lockable") && !item.HasKeyWordString("zad_InventoryDevice") && !item.HasKeyWordString("sexlabnostrip")
                    a.UnequipItem(item, false, true)
                    bind_Utility.DoSleep(0.25)
                endif
            endif
            i += 1
        endwhile

    endif

    ;does the set have stored armor & clothing?
    Form[] wornItems = JsonUtil.FormListToArray(f, "fixed_worn_items")
    i = 0
    while i < wornItems.Length
        Form item = wornItems[i]
        if a.GetItemCount(item) > 0
            if !a.IsEquipped(item)
                a.EquipItem(item, false, true)
                bind_Utility.DoSleep(0.25)
            endif
        else
            bind_Utility.WriteNotification(item.GetName() + " is no longer in your bag", bind_Utility.TextColorRed())
        endif
        i += 1
    endwhile

    int useRandom = JsonUtil.GetIntValue(f, "use_random_bondage", 0)

    Form[] setItems

    bind_Utility.WriteToConsole("EquipBondageOutfit - userandom: " + userandom)

    if useRandom == 1

        JsonUtil.FormListClear(f, "dynamic_bondage_items")

        int material = Utility.RandomInt(1, 3)
        int color = 0
        if material == 1 ;rope
            color = Utility.RandomInt(1, 4)
        elseif material == 2 ;leather
            color = Utility.RandomInt(1, 3)
        elseif material == 3 ;iron
            color = 1
        endif

        int[] chances = JsonUtil.IntListToArray(f, "random_bondage_chance")
        bind_Utility.WriteToConsole("EquipBondageOutfit - chances:" + chances + " mat: " + material + " col: " + color)

        ;anal plug - 0
        if Utility.RandomInt(0, 100) < chances[0]
            bind_Utility.WriteToConsole("using anal plug")
            FormList fl = bind_dd.GetAt(0) as FormList
            JsonUtil.FormListAdd(f, "dynamic_bondage_items", fl.GetAt(Utility.RandomInt(0, fl.GetSize() - 1)))
        endif
        ;vag plug - 1
        if Utility.RandomInt(0, 100) < chances[1]
            bind_Utility.WriteToConsole("using vag plug")
            FormList fl = bind_dd.GetAt(1) as FormList
            JsonUtil.FormListAdd(f, "dynamic_bondage_items", fl.GetAt(Utility.RandomInt(0, fl.GetSize() - 1)))
        endif
        ;vag piercing - 2
        if Utility.RandomInt(0, 100) < chances[2]
            bind_Utility.WriteToConsole("using vag piercing")
            FormList fl = bind_dd.GetAt(2) as FormList
            JsonUtil.FormListAdd(f, "dynamic_bondage_items", fl.GetAt(Utility.RandomInt(0, fl.GetSize() - 1)))
        endif
        ;nipple piercing - 3
        if Utility.RandomInt(0, 100) < chances[3]
            bind_Utility.WriteToConsole("using nip piercing")
            FormList fl = bind_dd.GetAt(3) as FormList
            JsonUtil.FormListAdd(f, "dynamic_bondage_items", fl.GetAt(Utility.RandomInt(0, fl.GetSize() - 1)))
        endif
        ;arms - 4
        if Utility.RandomInt(0, 100) < chances[4]
            bind_Utility.WriteToConsole("using arms")
            FormList arms = bind_dd.GetAt(4) as FormList
            FormList fl
            if material == 3
                fl = arms.GetAt(0) as FormList
            elseif material == 2 && color == 1
                fl = arms.GetAt(1) as FormList
            elseif material == 2 && color == 2
                fl = arms.GetAt(2) as FormList
            elseif material == 2 && color == 3
                fl = arms.GetAt(3) as FormList
            elseif material == 1 && color == 1
                fl = arms.GetAt(4) as FormList
            elseif material == 1 && color == 2
                fl = arms.GetAt(5) as FormList
            elseif material == 1 && color == 3
                fl = arms.GetAt(6) as FormList
            elseif material == 1 && color == 4
                fl = arms.GetAt(7) as FormList
            endif
            JsonUtil.FormListAdd(f, "dynamic_bondage_items", fl.GetAt(Utility.RandomInt(0, fl.GetSize() - 1)))
        endif

        JsonUtil.Save(f)

        setItems = JsonUtil.FormListToArray(f, "dynamic_bondage_items")

    else
    
        setItems = JsonUtil.FormListToArray(f, "fixed_bondage_items")

    endif

    bind_Utility.WriteToConsole("EquipBondageOutfit - items: " + setItems)

    if setItems != none
        i = 0
        while i < setItems.Length
            Form dev = setItems[i]
            if dev
                AddSpecificItem(a, dev as Armor)
                bind_Utility.DoSleep(0.25)
            endif
            i += 1
        endwhile
    endif

    StorageUtil.SetIntValue(a, "bind_wearing_outfit_id", setId) ;NOTE - this is used by the sub alias to determine blocks
    StorageUtil.SetStringValue(a, "bind_wearing_outfit_name", JsonUtil.GetStringValue(f, "bondage_outfit_name", ""))

    bind_Utility.DoSleep(2.0)

    EquippingBondageOutfit = false

endfunction

int function GetBondageSetForLocation(Location currentLocation, int currentBondageSet)

    string outfitKey = ""
    int[] outfitIds

    bool isSafeArea = false

    if currentLocation.HasKeywordString("LocTypePlayerHouse")
        isSafeArea = true
        outfitKey = "location_player_home"
        bool hasSet = JsonUtil.IntListHas(bondageOutfitsFile, "used_for_" + outfitKey, currentBondageSet)
        if hasSet
            return currentBondageSet
        endif
        outfitIds = JsonUtil.IntListToArray(bondageOutfitsFile, "used_for_" + outfitKey)
        bind_Utility.WriteToConsole("key: " + outfitKey + " outfitIds: " + outfitIds)
    endif

    if currentLocation.HasKeywordString("LocTypeInn")
        isSafeArea = true
        outfitKey = "location_inn"
        bool hasSet = JsonUtil.IntListHas(bondageOutfitsFile, "used_for_" + outfitKey, currentBondageSet)
        if hasSet
            return currentBondageSet
        endif
        outfitIds = JsonUtil.IntListToArray(bondageOutfitsFile, "used_for_" + outfitKey)
        bind_Utility.WriteToConsole("key: " + outfitKey + " outfitIds: " + outfitIds)
    endif

    if currentLocation.HasKeywordString("LocTypeTown") && outfitIds.Length == 0
        isSafeArea = true
        outfitKey = "location_towns"
        bool hasSet = JsonUtil.IntListHas(bondageOutfitsFile, "used_for_" + outfitKey, currentBondageSet)
        if hasSet
            return currentBondageSet
        endif
        outfitIds = JsonUtil.IntListToArray(bondageOutfitsFile, "used_for_" + outfitKey)
        bind_Utility.WriteToConsole("key: " + outfitKey + " outfitIds: " + outfitIds)
    endif
    
    if currentLocation.HasKeywordString("LocTypeCity") && outfitIds.Length == 0
        isSafeArea = true
        outfitKey = ""
        string locationName = currentLocation.GetName()
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
            bool hasSet = JsonUtil.IntListHas(bondageOutfitsFile, "used_for_" + outfitKey, currentBondageSet)
            if hasSet
                return currentBondageSet
            endif
            outfitIds = JsonUtil.IntListToArray(bondageOutfitsFile, "used_for_" + outfitKey)
            bind_Utility.WriteToConsole("key: " + outfitKey + " outfitIds: " + outfitIds)
        endif
    endif

    if currentLocation.HasKeywordString("LocTypeCity") && outfitIds.Length == 0
        isSafeArea = true
        outfitKey = "location_any_city"
        bool hasSet = JsonUtil.IntListHas(bondageOutfitsFile, "used_for_" + outfitKey, currentBondageSet)
        if hasSet
            return currentBondageSet
        endif
        outfitIds = JsonUtil.IntListToArray(bondageOutfitsFile, "used_for_" + outfitKey)
        bind_Utility.WriteToConsole("key: " + outfitKey + " outfitIds: " + outfitIds)
    endif

    if isSafeArea && outfitIds.Length == 0
        ;debug.MessageBox("safe area")
        outfitKey = "location_safe_area"
        bool hasSet = JsonUtil.IntListHas(bondageOutfitsFile, "used_for_" + outfitKey, currentBondageSet)
        if hasSet
            return currentBondageSet
        endif
        outfitIds = JsonUtil.IntListToArray(bondageOutfitsFile, "used_for_" + outfitKey)
        bind_Utility.WriteToConsole("key: " + outfitKey + " outfitIds: " + outfitIds)
    elseif !isSafeArea && outfitIds.Length == 0
        ;dangerous area
        ;debug.MessageBox("unsafe area")
        outfitKey = "location_unsafe_area"
        bool hasSet = JsonUtil.IntListHas(bondageOutfitsFile, "used_for_" + outfitKey, currentBondageSet)
        if hasSet
            return currentBondageSet
        endif
        outfitIds = JsonUtil.IntListToArray(bondageOutfitsFile, "used_for_" + outfitKey)
        bind_Utility.WriteToConsole("key: " + outfitKey + " outfitIds: " + outfitIds)
    endif

    if outfitIds.Length == 0
        outfitKey = "location_all_areas"
        bool hasSet = JsonUtil.IntListHas(bondageOutfitsFile, "used_for_" + outfitKey, currentBondageSet)
        if hasSet
            return currentBondageSet
        endif
        outfitIds = JsonUtil.IntListToArray(bondageOutfitsFile, "used_for_" + outfitKey)
        bind_Utility.WriteToConsole("key: " + outfitKey + " outfitIds: " + outfitIds)
    endif

    if outfitIds.Length == 0
        return -1
    endif

    return outfitIds[Utility.RandomInt(0, outfitIds.Length - 1)]

    ;debug.MessageBox(outfitIds)

endfunction

; function SetActiveBondageSet(bool safeLocation, Location currentLocation) 

;     bind_Utility.WriteToConsole("SetActiveBondageSet - safeLocation: " + safeLocation + " currentLocation: " + currentLocation)

;     ActiveBondageSet = ""

;     ;test current set to see if it is still active vs clearing??
;     ;bool hasSet = StorageUtil.StringListHas(TheWardrobe, "used_for_" + queststList[i], ActiveBondageSet)

;     int dayOfWeek = GetDayOfWeek()

;     ; queststList[0] = "Location - All Areas"
;     ; queststList[1] = "Location - All Safe Areas"
;     ; queststList[2] = "Location - All Dangerous Areas"
;     ; queststList[3] = "Location - Any City"
;     ; queststList[4] = "Location - Dawnstar"
;     ; queststList[5] = "Location - Falkreath"
;     ; queststList[6] = "Location - Windhelm"
;     ; queststList[7] = "Location - Markarth"
;     ; queststList[8] = "Location - Morthal"
;     ; queststList[9] = "Location - Riften"
;     ; queststList[10] = "Location - Solitude"
;     ; queststList[11] = "Location - High Hrothgar"
;     ; queststList[12] = "Location - Whiterun"
;     ; queststList[13] = "Location - Winterhold"
;     ; queststList[14] = "Location - Raven Rock"       
;     ; queststList[15] = "Location - Towns"
;     ; queststList[16] = "Location - Player Home"
;     ; queststList[17] = "Day - Sundas"
;     ; queststList[18] = "Day - Morndas"
;     ; queststList[19] = "Day - Tirdas"
;     ; queststList[20] = "Day - Middas"
;     ; queststList[21] = "Day - Turdas"
;     ; queststList[22] = "Day - Fredas"
;     ; queststList[23] = "Day - Loredas"

;     bool found = false

;     string[] setsList

;     if !safeLocation
;         ;debug.MessageBox("looking for dangerous areas sets")
;         setsList = GetSetsByUsage("Location - All Dangerous Areas")
;         if setsList.Length > 0
;             found = true
;         endif

;     elseif currentLocation.HasKeywordString("LocTypePlayerHouse")
;         setsList = GetSetsByUsage("Location - Player Home")
;         if setsList.Length > 0
;             found = true
;         endif

;     elseif currentLocation.HasKeywordString("LocTypeTown")
;         ;debug.MessageBox("in a town??")
;         setsList = GetSetsByUsage("Location - Towns")
;         if setsList.Length > 0
;             found = true
;         endif

;     elseif currentLocation.HasKeywordString("LocTypeCity")

;         string locationName = currentLocation.GetName()

;         ;debug.MessageBox(currentLocation.GetName())

;         if locationName == "Dawnstar"
;             setsList = GetSetsByUsage("Location - Dawnstar")
;             if setsList.Length > 0
;                 found = true
;             endif

;         elseif locationName == "Falkreath"
;             setsList = GetSetsByUsage("Location - Falkreath")
;             if setsList.Length > 0
;                 found = true
;             endif

;         elseif locationName == "Windhelm"
;             setsList = GetSetsByUsage("Location - Windhelm")
;             if setsList.Length > 0
;                 found = true
;             endif

;         elseif locationName == "Markarth"
;             setsList = GetSetsByUsage("Location - Markarth")
;             if setsList.Length > 0
;                 found = true
;             endif

;         elseif locationName == "Morthal"
;             setsList = GetSetsByUsage("Location - Morthal")
;             if setsList.Length > 0
;                 found = true
;             endif

;         elseif locationName == "Riften"
;             setsList = GetSetsByUsage("Location - Riften")
;             if setsList.Length > 0
;                 found = true
;             endif

;         elseif locationName == "Solitude"
;             setsList = GetSetsByUsage("Location - Solitude")
;             if setsList.Length > 0
;                 found = true
;             endif

;         elseif locationName == "High Hrothgar"
;             setsList = GetSetsByUsage("Location - High Hrothgar")
;             if setsList.Length > 0
;                 found = true
;             endif

;         elseif locationName == "Whiterun"
;             setsList = GetSetsByUsage("Location - Whiterun")
;             if setsList.Length > 0
;                 found = true
;             endif

;         elseif locationName == "Winterhold"
;             setsList = GetSetsByUsage("Location - Winterhold")
;             if setsList.Length > 0
;                 found = true
;             endif

;         elseif locationName == "Raven Rock"
;             setsList = GetSetsByUsage("Location - Raven Rock")
;             if setsList.Length > 0
;                 found = true
;             endif

;         endif

;     endif

;     if !found
;         if currentLocation.HasKeywordString("LocTypeCity")
;             ;check any city
;             setsList = GetSetsByUsage("Location - Any City")
;             if setsList.Length > 0
;                 found = true
;             endif
;         endif
;     endif

;     if !found
;         if safeLocation
;             setsList = GetSetsByUsage("Location - All Safe Areas")
;             if setsList.Length > 0
;                 found = true
;             endif
;         ; else
;         ;     setsList = GetSetsByUsage("Location - All Dangerous Areas")
;         ;     if setsList.Length > 0
;         ;         found = true
;         ;     endif
;         endif
;     endif

;     if !found
;         ;check all areas
;         setsList = GetSetsByUsage("Location - All Areas")
;         if setsList.Length > 0
;             found = true
;         endif
;     endif
       
;     if setsList.Length > 0
;         ActiveBondageSet = setsList[Utility.RandomInt(0, setsList.Length - 1)]
;     endif

;     if ActiveBondageSet != ""
;         bind_Utility.WriteNotification("Switched to bondage set " + ActiveBondageSet)
;     else
;         bind_Utility.WriteNotification("No bondage set found, using random items")
;     endif

;     ;debug.MessageBox("day of week: " + dayOfWeek + " active set: " + ActiveBondageSet)

;     bind_Utility.WriteToConsole("Selected bondage set: " + ActiveBondageSet)

; endfunction

string[] function GetSetsByUsage(string usage)
    return StorageUtil.StringListToArray(TheWardrobe, "used_for_" + usage)
endfunction

bool function AddSpecificItem(Actor act, Form dev)
    bool result = false
    if dev
        SetBindingBondageItem(dev)
        result = zlib.LockDevice(act, dev as Armor, true)
        if result
            StorageUtil.FormListAdd(act, "binding_bondage_specific_list", dev, false)
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
            StorageUtil.FormListRemove(act, "binding_bondage_specific_list", dev, true)
        endif
    endif
    return result
endfunction

Form[] function GetSpecificItems(Actor act)
    return StorageUtil.FormListToArray(act, "binding_bondage_specific_list")
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
                bind_Utility.WriteToConsole("removing stored item: " + dev)                
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
                        bind_Utility.WriteToConsole("removing by keyword: " + kw)
                    endif
                    bind_Utility.DoSleep(sleepTime)
                endif
                i += 1
            endwhile
        endif
        if act.WornHasKeyWord(zlib.zad_Lockable)
            debug.MessageBox("fail safe removal")
        	Form[] inventory = act.GetContainerForms()
            i = 0
            while i < inventory.Length
                Form dev = inventory[i]
                if dev.HasKeyWord(zlib.zad_Lockable) && act.IsEquipped(dev)
                    zlib.UnlockDevice(act, dev as Armor, none, none, true)
                    bind_Utility.WriteToConsole("removing non-binding rendered item: " + dev.GetName())
                endif
                i += 1
            endwhile
        endif
    endif

	Form[] inventory = act.GetContainerForms()
    i = 0
    bind_Utility.WriteToConsole("clean up bags: " + inventory.Length)

	while i < inventory.Length
        Form dev = inventory[i]
        
        ;TODO - figure out how to deal with failed render devices

        if dev.HasKeyWord(zlib.zad_InventoryDevice) && !act.IsEquipped(dev)
            int flag = GetBindingBondageItem(dev)
            if flag == 1 || main.CleanUpNonBindingItemsFromBags == 1
                bind_Utility.WriteToConsole("removing binding item: " + dev.GetName())
                act.RemoveItem(dev, 100, true, none)
            else
                bind_Utility.WriteToConsole("leaving non-binding item: " + dev.GetName())
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

function UpdateBondage(Actor a, bool removeExisting = false)

    ;debug.MessageBox("UpdateBondage called")

    int i
    int operation
    int rank

    bool safeArea = (StorageUtil.GetIntValue(a, "bind_safe_area", 0) == 1)

    if !a.IsInFaction(bind_EventActiveFaction)

        ;NOT IN EVENT - RUNNING

        bind_Utility.WriteToConsole("UpdateBondage no event faction found")

        if a.IsInFaction(bind_BondageRulesDisableFaction)
            
            bind_Utility.WriteToConsole("UpdateBondage disable rules faction found")

            ;remove all binding items
            RemoveAllBondageItems(a, false)


        else

            bool removedAllItems = false

            if removeExisting
                RemoveAllBondageItems(a, false)
                removedAllItems = true
                bind_Utility.DoSleep(1.0) ;give dd enough time to clear so that keyword checks below are accurate
            endif

            ;apply rules bondage
            ;i = 0

            string[] ruleNames = rms.GetBondageRuleNameArray()

            bind_Utility.WriteToConsole("UpdateBondage rulescheck:")

        ; dRuleName[0] = "Ankle Shackles Rule"
        ; dRuleName[1] = "Arm Cuffs Rule"
        ; dRuleName[2] = "Blindfold Rule"
        ; dRuleName[3] = "Boots Rule"
        ; dRuleName[4] = "Belt Rule"
        ; dRuleName[5] = "Collar Rule"
        ; dRuleName[6] = "Corset Rule"
        ; dRuleName[7] = "Gag Rule"
        ; dRuleName[8] = "Gloves Rule"
        ; dRuleName[9] = "Harness Rule"
        ; dRuleName[10] = "Heavy Bondage Rule"
        ; dRuleName[11] = "Hood Rule"
        ; dRuleName[12] = "Leg Cuffs Rule"
        ; dRuleName[13] = "Nipple Piercing Rule"
        ; dRuleName[14] = "Vaginal Piercing Rule"
        ; dRuleName[15] = "Anal Plug Rule"
        ; dRuleName[16] = "Vaginal Plug Rule"
        ; dRuleName[17] = "Suit Rule"

            int[] equipOrder = new int[18]
            equipOrder[0] = 15 ;anal plug
            equipOrder[1] = 16 ;v plug
            equipOrder[2] = 14 ;v piercing
            equipOrder[3] = 13 ;n piercing
            equipOrder[4] = 17 ;suits
            equipOrder[5] = 9 ;harness
            equipOrder[6] = 6 ;corset
            equipOrder[7] = 4 ;belt
            equipOrder[8] = 5 ;collar
            equipOrder[9] = 8 ;gloves
            equipOrder[10] = 3 ;boots
            equipOrder[11] = 1 ;arm cuffs
            equipOrder[12] = 12 ;leg cuffs
            equipOrder[13] = 10 ;heavy bondage
            equipOrder[14] = 0 ;ankle shackles
            equipOrder[15] = 2 ;blindfold
            equipOrder[16] = 11 ;hood
            equipOrder[17] = 7 ;gag


            int idx = 0
            ;TODO - run this in reverse??? so plugs get set first - suit can block everyting else?
            while idx < bind_DDKeywords.GetSize() ;bind_BondageRulesFactionList.GetSize()

                operation = 0

                i = equipOrder[idx]

                int ruleSetting = StorageUtil.GetIntValue(a, "bind_rule_setting_" + i, 0)
                int ruleOption = StorageUtil.GetIntValue(a, "bind_rule_option_" + i, 0)

                ; if ruleOption == 1
                ;     ruleText += " - Blocked / Hard Limit"
                ; elseif ruleOption == 2
                ;     ruleText += " - Safe Areas Only"
                ; elseif ruleOption == 3
                ;     ruleText += " - Always On"
                ; elseif ruleOption == 4
                ;     ruleText += " - Always On In Safe Areas"
                ; endif

                ; if i == BONDAGE_TYPE_SUIT() && ruleSetting == 1 && !safeArea ;see if heavy bondage should be removed in unsafe areas
                ;     ;debug.MessageBox("in the condition")
                ;     ;heavy bondage check on suits - suits are lower in the list, so this should only happen for that slot
                ;     if a.WornHasKeyWord(bind_DDKeywords.GetAt(BONDAGE_TYPE_HEAVYBONDAGE()) as Keyword)
                ;         ;debug.MessageBox("found heavy bondage keyword")
                ;         int heavyBondageOption = StorageUtil.GetIntValue(a, "bind_rule_option_" + BONDAGE_TYPE_HEAVYBONDAGE(), 0)
                ;         if heavyBondageOption == 2 || heavyBondageOption == 4
                ;             ruleOption = heavyBondageOption
                ;             bind_Utility.WriteToConsole("suits has heavy bondage - using heavy bondage safe areas option")
                ;         endif
                ;     endif
                ; endif

                if ruleSetting == 1 ;a.IsInFaction(bind_BondageRulesFactionList.GetAt(i) as Faction)
                    ;TODO - check faction rank??
                    
                    operation = 1 ;normal check if equipped
                    
                    if ruleOption == 2 || ruleOption == 4 ;safe area only
                        if !safeArea
                            operation = 2 ;remove this if not in a safe area
                        endif
                    endif
                    
                    if ruleOption == 5 || ruleOption == 6 ;unsafe area only
                        if safeArea
                            operation = 2 ;remove this if in safe area
                        endif
                    endif

                    ;rank = a.GetFactionRank(bind_BondageRulesFactionList.GetAt(i) as Faction)

                    ;bind_Utility.WriteToConsole("faction: " + i + " rank " + rank)
                else

                    operation = 2 ;normal remove

                    ; if ruleOption == 2 || ruleOption == 4 ;safe area only
                    ;     if !safeArea
                    ;         operation = 3 ;don't try to remove this if in a safe area
                    ;     endif
                    ; endif

                    ; if ruleOption == 5 || ruleOption == 6 ;unsafe area only
                    ;     if !safeArea
                    ;         operation = 3 ;don't try to remove this if in an unsafe area
                    ;     endif
                    ; endif

                endif

                int kwc = 0
                int ddResult = 0

                if operation == 1
                    ;if !a.WornHasKeyWord(bind_DDKeywords.GetAt(i) as Keyword)
                    ;    kwc = 2
                        ;bind_Utility.WriteToConsole("keyword not found: " + i)
                        if AddItem(a, i)
                            ddResult = 1
                            ;bind_Utility.WriteToConsole("adding: " + i)
                            bind_Utility.DoSleep(sleepTime)
                        else
                            ddResult = 2
                        endif
                    ;else
                    ;    kwc = 1
                    ;endif
                elseif operation == 2
                    ;if a.WornHasKeyWord(bind_DDKeywords.GetAt(i) as Keyword)
                    ;    kwc = 1
                        ;bind_Utility.WriteToConsole("keyword found: " + i)
                        if RemoveItem(a, i)
                            ddResult = 1
                            ;bind_Utility.WriteToConsole("removing: " + i)
                            bind_Utility.DoSleep(sleepTime)
                        else 
                            ddResult = 2
                        endif
                    ;else
                    ;    kwc = 2
                    ;endif
                elseif operation == 3
                    ;leave the things alone
                    if removedAllItems
                        ;should we re-equip??
                    endif
                endif

                bind_Utility.WriteToConsole("rule setting: " + ruleSetting + " rule option: " + ruleOption + " operation: " + operation + " keyword check: " + kwc + " dd result: " + ddresult + " - " + ruleNames[i])                

                idx += 1

            endwhile

        endif

    else

        ;IN EVENT

        ;check for event remove all bondage faction
        ;run RemoveAllBondageItems(a) if so

        ;

    endif



endfunction


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

    string bondageOutfitFile
    bondageOutfitFile = "bind_bondage_outfit_" + outfitId + ".json"

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

endfunction

function SaveWornDdItemsAsSet(Actor theSub)

    string bondageOutfitFile

    UIExtensions.InitMenu("UITextEntryMenu")
    UIExtensions.OpenMenu("UITextEntryMenu")
    string result = UIExtensions.GetMenuResultString("UITextEntryMenu")
    if result != ""
        ;loadedSetName = result

        int lastUid = JsonUtil.GetIntValue(bondageOutfitsFile, "last_set_uid", 1000)
        JsonUtil.StringListAdd(bondageOutfitsFile, "bondage_set_names", result, false)
        int nextId = lastUid + 1
        JsonUtil.IntListAdd(bondageOutfitsFile, "bondage_set_ids", nextId, false)
        JsonUtil.SetIntValue(bondageOutfitsFile, "last_set_uid", nextId)
        JsonUtil.Save(bondageOutfitsFile)
        bondageOutfitFile = "bind_bondage_outfit_" + nextId + ".json"
        ;loadedSetId = nextId

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


bind_BondageManager function GetBindingBondageManager() global
    return Quest.GetQuest("bind_MainQuest") as bind_BondageManager
endfunction

bind_MainQuestScript property main auto
bind_RulesManager property rms auto

zadLibs property zlib auto

FormList property bind_dd auto

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