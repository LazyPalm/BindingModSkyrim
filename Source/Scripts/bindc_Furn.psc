Scriptname bindc_Furn extends Quest  

ObjectReference selectedFurniture
ObjectReference selectedFurnitureMarker
Keyword[] kwList

bool function LockInFurniture(Actor akActor, ObjectReference furn)

    bool isPlayer = akActor == Game.GetPlayer()
    bool lockResult = false

    Form f = furn.GetBaseObject()
    if f != none
        if f.HasKeyword(zadc_FurnitureDevice)
            (furn as zadcFurnitureScript).ScriptedDevice = true
            (furn as zadcFurnitureScript).PreventWaitandSleep = false
            if zclib.LockActor(akActor, furn)
                StorageUtil.SetIntValue(akActor, "bindc_in_furniture", 1)
                lockResult = true
            endif

        elseif f.HasKeyword(zbfFurniture)
           if isPlayer
                zbfSlot playerSlot = zbfBondageShell.GetApi().FindPlayer()
                playerSlot.SetFurniture(furn)
                StorageUtil.SetIntValue(akActor, "bindc_in_furniture", 2)
                lockResult = true
            else
                zbfSlot slot = zbfBondageShell.GetApi().SlotActor(akActor)
                slot.SetFurniture(furn) 
                StorageUtil.SetIntValue(akActor, "bindc_in_furniture", 2)
                lockResult = true
            endif

        elseif f.HasKeywordString("dse_dm_KeywordFurniture")
            if Game.IsPluginInstalled("dse-display-model.esp")
                ;dse_dm_QuestController dm3Quest = Quest.GetQuest("dse_dm_QuestController") as dse_dm_QuestController
                dse_dm_ActiPlaceableBase dm3Device = furn as dse_dm_ActiPlaceableBase
                int slot = dm3Device.GetNextSlot()
                if slot > -1
                    dm3Device.ActivateByActor(akActor, slot)
                    StorageUtil.SetIntValue(akActor, "bindc_in_furniture", 3)
                    StorageUtil.SetFormValue(akActor, "bindc_in_furniture_dse_ref", furn)
                    StorageUtil.SetIntValue(akActor, "bindc_in_furniture_dse_slot", slot)
                    lockResult = true
                endif
            endif

        endif
    endif

    return lockResult

endfunction

bool function UnlockFromFurniture(Actor akActor)

    bool isPlayer = akActor == Game.GetPlayer()
    bool unlockResult = false

    int lockType = StorageUtil.GetIntValue(akActor, "bindc_in_furniture", 0)

    if lockType == 1 ;ddc
        if zclib.UnlockActor(akActor)
            unlockResult = true
        endif

    elseif lockType == 2 ;zap
        if isPlayer
            zbfSlot playerSlot = zbfBondageShell.GetApi().FindPlayer()
            playerSlot.SetFurniture(none)
            unlockResult = true
        else
            zbfSlot slot = zbfBondageShell.GetApi().SlotActor(akActor)
            slot.SetFurniture(none)
            debug.SendAnimationEvent(akActor, "IdleForceDefaultState")
            unlockResult = true
        endif

    elseif lockType == 3 ;dse
        if Game.IsPluginInstalled("dse-display-model.esp")
            ObjectReference f = StorageUtil.GetFormValue(akActor, "bindc_in_furniture_dse_ref") as ObjectReference
            int slot = StorageUtil.GetIntValue(akActor, "bindc_in_furniture_dse_slot", 0)
            dse_dm_ActiPlaceableBase dm3Device = f as dse_dm_ActiPlaceableBase
            dm3Device.ReleaseActorSlot(slot)
            unlockResult = true
        endif

    endif

    if unlockResult
        StorageUtil.SetIntValue(akActor, "bindc_in_furniture", 0)
    endif

    return unlockResult

endfunction

function DeleteFurniture()

	selectedFurniture.Delete()
    bindc_Util.DoSleep(2.0)
    selectedFurniture = none
    selectedFurnitureMarker.Disable()

endfunction

function MoveFurniture()

    Actor a = Game.GetPlayer()

    float x = a.GetAngleX()
    float y = a.GetAngleY()
    float z = a.GetAngleZ()

    selectedFurniture.MoveTo(a, 120.0 * Math.Sin(z), 120.0 * Math.Cos(z), 0)
    selectedFurniture.SetAngle(0.0, 0.0, z + 180)

    selectedFurnitureMarker.MoveTo(selectedFurniture)

endfunction

function AddFurnitureByForm(Form dev)

    Actor a = Game.GetPlayer()

    ; float z = a.GetAngleZ()
    bool add = false

    bind_Utility.WriteToConsole("Adding: " + dev.GetName())

    If dev.HasKeywordString("zadc_FurnitureDevice") || dev.HasKeywordString("zbfFurniture")
        add = true
    EndIf

    if dev.HasKeywordString("dse_dm_KeywordFurniture")
        if Game.IsPluginInstalled("dse-display-model.esp")
            add = true
        endif
    endif

    if add

        float x = a.GetAngleX()
        float y = a.GetAngleY()
        float z = a.GetAngleZ()

        ObjectReference obj = a.PlaceAtMe(dev, 1, true, true)

        obj.MoveTo(a, 120.0 * Math.Sin(z), 120.0 * Math.Cos(z), 0)
        obj.SetAngle(0.0, 0.0, z + 180)

        obj.Enable()

        PO3_SKSEFunctions.AddKeywordToRef(obj, bindc_FurnitureItem)

        StorageUtil.SetIntValue(obj, "bindc_furniture", 1)

        obj.SetActorOwner(a.GetActorBase())

        StorageUtil.SetFloatValue(obj, "bindc_furniture_ax", obj.GetAngleX())
        StorageUtil.SetFloatValue(obj, "bindc_furniture_ay", obj.GetAngleY())
        StorageUtil.SetFloatValue(obj, "bindc_furniture_az", obj.GetAngleZ())

        StorageUtil.SetFloatValue(obj, "bindc_furniture_px", obj.GetPositionX())
        StorageUtil.SetFloatValue(obj, "bindc_furniture_py", obj.GetPositionY())
        StorageUtil.SetFloatValue(obj, "bindc_furniture_pz", obj.GetPositionZ())

    endif

endfunction

ObjectReference[] function FindFurnitureNearActor(Actor akActor, float distance = 2000.0) 
    BuildKeywordList()
    return bindc_SKSE.GetFurniture(Game.GetPlayer(), kwList, distance)
endfunction

bool function IsFurnitureNearActor(Actor akActor, float distance = 2000.0) 
    BuildKeywordList()
    return bindc_SKSE.ScanForFurniture(Game.GetPlayer(), kwList, distance) > 0
endfunction

function FurnitureMenu()

	float distanceToMovePlus = 10.0
	float distanceToMoveMinus = distanceToMovePlus * -1

	UIListMenu furnMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

	furnMenu.AddEntryItem("<-- Leave Furniture Menu")
	furnMenu.AddEntryItem("Add Item")
	furnMenu.AddEntryItem("Select")
    furnMenu.AddEntryItem("Clear Selected")
	furnMenu.AddEntryItem("Move")
	furnMenu.AddEntryItem("Delete")
    furnMenu.AddEntryItem("Fine Tune Position/Angle")

	furnMenu.OpenMenu()
	int furnResult = furnMenu.GetResultInt()

	if furnResult == 0
        Quest q = Quest.GetQuest("bindc_SlaveryQuest")
        if q != none
            if q.IsRunning()
                (q as bindc_Slavery).ActionMenu()
                return
            endif
        endif
        q = Quest.GetQuest("bindc_EventDisplayQuest")
        if q != none
            if q.IsRunning()
                (q as bindc_EventDisplay).ActionMenu()
                return
            endif
        endif
    elseif furnResult == 1
        AddFurnitureMenu()
    elseif furnResult == 2
        SelectFurnitureMenu()
    elseif furnResult > 2 && selectedFurniture == none
        debug.Notification("No furniture is selected.")
        FurnitureMenu()
    elseif furnResult == 3
        selectedFurniture = none
        selectedFurnitureMarker.Disable()
        FurnitureMenu()
    elseif furnResult == 4
        MoveFurniture()
    elseif furnResult == 5
        DeleteFurniture()
    elseif furnResult == 6
        FineTuneMenu()

    endif

endfunction

function FineTuneMenu()

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		listMenu.AddEntryItem("<-- Leave Fine Tune Menu")
        listMenu.AddEntryItem("Return To Original Pos/Angle")
        listMenu.AddEntryItem("Set Angle X - " + selectedFurniture.GetAngleX())
        listMenu.AddEntryItem("Set Angle Y - " + selectedFurniture.GetAngleY())
        listMenu.AddEntryItem("Set Angle Z - " + selectedFurniture.GetAngleZ())
        listMenu.AddEntryItem("Change Position X (+ or - 0.0 to 500.0)")
        listMenu.AddEntryItem("Change Position Y (+ or - 0.0 to 500.0)")
        listMenu.AddEntryItem("Change Position Z (+ or - 0.0 to 500.0)")
	endif

	listMenu.OpenMenu()
	int listReturn = listMenu.GetResultInt()

	if listReturn == 0
		FurnitureMenu()
    elseif listReturn == 1
        selectedFurniture.SetAngle(StorageUtil.GetFloatValue(selectedFurniture, "bindc_furniture_ax"), StorageUtil.GetFloatValue(selectedFurniture, "bindc_furniture_ay"), StorageUtil.GetFloatValue(selectedFurniture, "bindc_furniture_az"))
        selectedFurniture.SetPosition(StorageUtil.GetFloatValue(selectedFurniture, "bindc_furniture_px"), StorageUtil.GetFloatValue(selectedFurniture, "bindc_furniture_py"), StorageUtil.GetFloatValue(selectedFurniture, "bindc_furniture_pz"))
        bindc_Util.DoSleep(1.0)
        FineTuneMenu()
    elseif listReturn > 1
        float change = DisplayNumberInput()
        if change < -500 || change > 500.0
            change = 0.0
        endif
        ;debug.MessageBox("change:" + change)
        if listReturn == 2 && (change >= 0 && change <= 360)
            selectedFurniture.SetAngle(change, selectedFurniture.GetAngleY(), selectedFurniture.GetAngleZ())
        elseif listReturn == 3 && (change >= 0 && change <= 360)
            selectedFurniture.SetAngle(selectedFurniture.GetAngleX(), change, selectedFurniture.GetAngleZ())
        elseif listReturn == 4 && (change >= 0 && change <= 360)
            selectedFurniture.SetAngle(selectedFurniture.GetAngleX(), selectedFurniture.GetAngleY(), change)
        elseif listReturn == 5
            selectedFurniture.SetPosition(selectedFurniture.GetPositionX() + change, selectedFurniture.GetPositionY(), selectedFurniture.GetPositionZ())
        elseif listReturn == 6
            selectedFurniture.SetPosition(selectedFurniture.GetPositionX(), selectedFurniture.GetPositionY() + change, selectedFurniture.GetPositionZ())
        elseif listReturn == 7
            selectedFurniture.SetPosition(selectedFurniture.GetPositionX(), selectedFurniture.GetPositionY(), selectedFurniture.GetPositionZ() + change)
        endif
        bindc_Util.DoSleep(1.0)
        FineTuneMenu()
    endif

endfunction

float function DisplayNumberInput()
    float userInput = 0.0
	UIExtensions.InitMenu("UITextEntryMenu")
	int result = UIExtensions.OpenMenu("UITextEntryMenu")
	if result == 1
		userInput = UIExtensions.GetMenuResultString("UITextEntryMenu") as int
    endif
    return userInput
endfunction

function BuildKeywordList()
    if kwList.Length == 0
        if Game.IsPluginInstalled("dse-display-model.esp")
            kwList = new Keyword[3]
            kwList[0] = zadc_FurnitureDevice
            kwList[1] = zbfFurniture
            kwList[2] = Keyword.GetKeyword("dse_dm_KeywordFurniture")
        else
            kwList = new Keyword[2]
            kwList[0] = zadc_FurnitureDevice
            kwList[1] = zbfFurniture
        endif
    endif
endfunction

function SelectFurnitureMenu()

    BuildKeywordList()

    ObjectReference[] items = bindc_SKSE.GetFurniture(Game.GetPlayer(), kwList, 2000.0)

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		listMenu.AddEntryItem("<-- Leave Select Furniture Menu")
        int i = 0
        while i < items.Length
            ObjectReference item = items[i]
            if StorageUtil.GetIntValue(item, "bindc_furniture", 0) == 1
                if item == selectedFurniture
                    listMenu.AddEntryItem(item.GetBaseObject().GetName() + " (selected)")
                else
                    listMenu.AddEntryItem(item.GetBaseObject().GetName())
                endif
            endif
            i += 1
        endwhile
    endif

	listMenu.OpenMenu()
	int listReturn = listMenu.GetResultInt()

	if listReturn == 0
		FurnitureMenu()
    elseif listReturn > 0
        selectedFurniture = items[listReturn - 1]
        if selectedFurnitureMarker == none
            selectedFurnitureMarker = selectedFurniture.PlaceAtMe(MAGINVIceSpellArt, 1)
        endif
        selectedFurnitureMarker.MoveTo(selectedFurniture) ;, 0, 0, selectedFurnitureMarker.GetHeight())
        selectedFurnitureMarker.Enable()
        bindc_Util.FaceTarget(Game.GetPlayer(), selectedFurniture)
        SelectFurnitureMenu()
    endif

endfunction

function AddFurnitureMenu()

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		listMenu.AddEntryItem("<-- Leave Add Furniture Menu")
		listMenu.AddEntryItem("DDC Items")
		listMenu.AddEntryItem("ZAP Items")
		if Game.IsPluginInstalled("dse-display-model.esp")
			listMenu.AddEntryItem("Display Model 3 (DSE) Items")
		endif
	endif

	listMenu.OpenMenu()
	int listReturn = listMenu.GetResultInt()

	if listReturn == 0
		FurnitureMenu()
	elseif listReturn == 1
		AddDdcMenu()
	elseif listReturn == 2
		AddZapMenu()
	elseif listReturn == 3
        AddDseMenu()

    endif

endfunction

function AddDdcMenu()

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		listMenu.AddEntryItem("<-- Leave Add DDC Menu")
		int i = 0
		while i < bindc_furniture_ddc.GetSize()
			Form dev = bindc_furniture_ddc.GetAt(i)
			listMenu.AddEntryItem(dev.GetName())
			i += 1
		endwhile
	endif

	listMenu.OpenMenu()
	int listReturn = listMenu.GetResultInt()

	If listReturn == 0
		AddFurnitureMenu()
	else
		Form dev = bindc_furniture_ddc.GetAt(listReturn - 1)
		if dev
			bind_Utility.WriteToConsole("DDC adding: " + dev.GetName() + " form: " + dev)
			AddFurnitureByForm(dev)
		else
			debug.MessageBox("Could not get DDC furniture from list")
		endif
	endif

endfunction

function AddZapMenu()

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		listMenu.AddEntryItem("<-- Leave Add Zap Menu")
		int i = 50
		while i < 1150
			listMenu.AddEntryItem("Items " + (i - 50) + " - " + i)
			i += 50
		endwhile
	endif

	listMenu.OpenMenu()
	int listReturn = listMenu.GetResultInt()

	If listReturn == 0
		AddFurnitureMenu()
	else
        AddZapSubMenu(listReturn)
	endif

endfunction

function AddZapSubMenu(int range)

    int topRange = range * 50
    int bottomRange = topRange - 50

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		listMenu.AddEntryItem("<-- Leave Add ZAP (" + bottomRange + " - " + topRange + ")")
		int i = bottomRange
		while i < topRange + 1
			Form dev = bindc_furniture_zap.GetAt(i)
			listMenu.AddEntryItem(dev.GetName())
			i += 1
		endwhile
	endif

	listMenu.OpenMenu()
	int listReturn = listMenu.GetResultInt()

	If listReturn == 0
		AddZapMenu()
	else
		Form dev = bindc_furniture_zap.GetAt(listReturn - 1 + bottomRange)
		if dev
			bind_Utility.WriteToConsole("ZAP adding: " + dev.GetName() + " form: " + dev)
			AddFurnitureByForm(dev)
		else
			debug.MessageBox("Could not get ZAP furniture from list")
		endif
	endif

endfunction

function AddDseMenu()

    if bindc_furniture_dse.GetSize() == 0
        ;load items
        bindc_Util.WriteModNotification("Loading DSE items. This could take some time.")
        string dseFile = "dse-display-model.esp"
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000182A, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x00002DC0, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x00002DC5, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x00002DC6, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000538F, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x00005395, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x00005396, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x000053A3, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x000053A4, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x000053A5, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x000053A6, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x000053A7, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x00005913, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x00005E79, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x000063EF, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x000063F4, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x00007455, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000746C, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000748C, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000748D, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000748E, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000748F, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x00007490, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x00007491, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000749A, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000A52F, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000A536, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000AFFE, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000B00F, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000B010, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000C5A1, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000C5A9, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000C5B8, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000C5BF, dseFile))
        ; bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000CB2F, dseFile)) ;clutter - not sure what to do with these yet
        ; bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000D095, dseFile)) ;clutter
        ; bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000D096, dseFile)) ;clutter
        ; bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000D097, dseFile)) ;clutter
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000D5FF, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000DB67, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000E0CD, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000EBA2, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000EBA4, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000EBA9, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000EBB5, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000F67A, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000FBDE, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000FBDF, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000FBE0, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000FBE1, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000FBE2, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000FBE3, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000FBE4, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0000FBE5, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x000106AE, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x000141F8, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0001624C, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x00016254, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x0001625A, dseFile))
        bindc_furniture_dse.AddForm(Game.GetFormFromFile(0x00016261, dseFile))
        bindc_Util.WriteModNotification("DSE item loading completed.")
    endif

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		listMenu.AddEntryItem("<-- Leave Add DSE Menu")
		int i = 0
		while i < bindc_furniture_dse.GetSize()
			Form dev = bindc_furniture_dse.GetAt(i)
			listMenu.AddEntryItem(dev.GetName())
			i += 1
		endwhile
	endif

	listMenu.OpenMenu()
	int listReturn = listMenu.GetResultInt()

	If listReturn == 0
		AddFurnitureMenu()
	else
		Form dev = bindc_furniture_dse.GetAt(listReturn - 1)
		if dev
			bind_Utility.WriteToConsole("DSE adding: " + dev.GetName() + " form: " + dev)
			AddFurnitureByForm(dev)
		else
			debug.MessageBox("Could not get DSE furniture from list")
		endif
	endif

endfunction

FormList property bindc_furniture_zap auto
FormList property bindc_furniture_ddc auto
FormList property bindc_furniture_dse auto ;NOTE - soft requirement - list will get filled runtime

Keyword property bindc_FurnitureItem auto

Keyword property zadc_FurnitureDevice auto
Keyword property zbfFurniture auto

Form property MAGINVIceSpellArt auto

zadcLibs property zclib auto