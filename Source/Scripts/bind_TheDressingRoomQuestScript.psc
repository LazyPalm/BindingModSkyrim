Scriptname bind_TheDressingRoomQuestScript extends Quest  

Actor theSub
Actor theDom

bool pressedButton
string[] bondageTypes
string[] materialTypes
string[] usageList

string loadedSetName = ""

event OnInit()

    if self.IsRunning()
        
        GoToState("")

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

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

        usageList = new string[18]
        usageList[0] = "Location - All Areas"
        usageList[1] = "Location - All Safe Areas"
        usageList[2] = "Location - All Dangerous Areas"
        usageList[3] = "Location - Any City"
        usageList[4] = "Location - Dawnstar"
        usageList[5] = "Location - Falkreath"
        usageList[6] = "Location - Windhelm"
        usageList[7] = "Location - Markarth"
        usageList[8] = "Location - Morthal"
        usageList[9] = "Location - Riften"
        usageList[10] = "Location - Solitude"
        usageList[11] = "Location - High Hrothgar"
        usageList[12] = "Location - Whiterun"
        usageList[13] = "Location - Winterhold"
        usageList[14] = "Location - Raven Rock"       
        usageList[15] = "Location - Towns"
        usageList[16] = "Location - Player Home"
        usageList[17] = "Event - Harsh Bondage"
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

        bind_Utility.DisablePlayer()
        fs.EventGetSubReady(theSub, theDom, playAnimations = true, stripClothing = true, addGag = false, freeWrists = false, removeAll = true)
        bind_Utility.EnablePlayer()

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("souls from bones quest safeword ending")
    self.Stop()
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
        listMenu.AddEntryItem("Save Set - (new)")
    else
        listMenu.AddEntryItem("Save Set - " + loadedSetName)
    endif
    listMenu.AddEntryItem("Load Set")
    ;listMenu.AddEntryItem("Add Item - By Bondage Type")
    listMenu.AddEntryItem("Add Item - Binding List")
    listMenu.AddEntryItem("Add Items - DD Lists")
    listMenu.AddEntryItem("Remove Item")

    if loadedSetName == ""
        
    else
        listMenu.AddEntryItem("Set Uses - " + loadedSetName)
        listMenu.AddEntryItem("Delete Set - " + loadedSetName)
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
        bms.BrowseDdItemsList(theSub, none, 2)
        ;MaterialTypeMenu()
    elseif listReturn == 6
        RemoveItemsMenu()
    elseif listReturn == 7
        SetUsesMenu()
    elseif listReturn == 8
        DeleteSetMenu()
    
    endif

endfunction

function SetUsesMenu()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Menu")

    int i = 0
    while i < usageList.Length

        bind_Utility.WriteToConsole("used_for_" + usageList[i] + " count: " + StorageUtil.StringListCount(TheWardrobe, "used_for_" + usageList[i]))

        bool hasSet = StorageUtil.StringListHas(TheWardrobe, "used_for_" + usageList[i], loadedSetName)

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

        bool hasSet = StorageUtil.StringListHas(TheWardrobe, "used_for_" + usageList[listReturn - 1], loadedSetName)
        if hasSet
            bind_Utility.WriteToConsole("removing from uses: used_for_" + usageList[listReturn - 1] + " set: " + loadedSetName)
            StorageUtil.StringListRemove(TheWardrobe, "used_for_" + usageList[listReturn - 1], loadedSetName)
        else
            int idx = StorageUtil.StringListAdd(TheWardrobe, "used_for_" + usageList[listReturn - 1], loadedSetName)
            bind_Utility.WriteToConsole("adding to uses: used_for_" + usageList[listReturn - 1] + " set: " + loadedSetName + " idx: " + idx)
        endif

        SetUsesMenu()

    endif

endfunction

function DeleteSetMenu()

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
        if listReturn == 0

        else
            loadedSetName = ""
        endif

    else

    endif

    bms.RemoveAllDetectedBondageItems(theSub)

endfunction

function LoadSetsMenu()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Menu")
    string[] setsList = StorageUtil.StringListToArray(TheWardrobe, "sets_list")
    int i = 0
    while i < setsList.Length
        listMenu.AddEntryItem("Set - " + setsList[i])
        i += 1
    endwhile
    listMenu.OpenMenu()

    int listReturn = listMenu.GetResultInt()
    if listReturn == 0
        ParentMenu()
    elseif listReturn >= 1
        loadedSetName = setsList[listReturn - 1]
        LoadSet()
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

    bms.RemoveAllDetectedBondageItems(theSub)

    ;do a if dd keyword check and run this if so
    ;bms.RemoveAllDetectedBondageItems(theSub)

    bind_Utility.DoSleep(2.0)
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
            StorageUtil.StringListAdd(TheWardrobe, "sets_list", result)
        else
            return
        endif
    else
    endif

    GoToState("WorkingState")

    StorageUtil.FormListClear(TheWardrobe, "set_" + loadedSetName)

	Form[] inventory = theSub.GetContainerForms()
	int i = 0
    int kwi = 0
	while i < inventory.Length
        Form dev = inventory[i]
        if dev.HasKeyWord(zlib.zad_inventoryDevice)
            bind_Utility.WriteToConsole("found zad_inventoryDevice: " + dev)
            if dev.HasKeyWord(zlib.zad_QuestItem) || dev.HasKeyWord(zlib.zad_BlockGeneric)
                bind_Utility.WriteToConsole("quest or blocking device")
            else
                bind_Utility.WriteToConsole("dev: " + dev.GetName() + " binding item: " + StorageUtil.GetIntValue(dev, "binding_bondage_item", 0))

                StorageUtil.FormListAdd(TheWardrobe, "set_" + loadedSetName, dev, false)


            endif
        endif
        i += 1
    endwhile

    GoToState("")

    debug.MessageBox("Set " + loadedSetName + " saved")

endfunction

function LoadSet()

    GoToState("WorkingState")

    bms.RemoveAllDetectedBondageItems(theSub)

    Form[] setItems = StorageUtil.FormListToArray(TheWardrobe, "set_" + loadedSetName)

    int i = 0
    while i < setItems.Length
        Form dev = setItems[i]
        if dev
            ;bms.AddItemPassingDevice(theSub, dev as Armor)
            bms.AddSpecificItem(theSub, dev as Armor)
            bind_Utility.DoSleep(0)
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