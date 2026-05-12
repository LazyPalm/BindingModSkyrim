Scriptname binda_GearManagerAlias extends ReferenceAlias

Actor me

Form currentDevice

Form[] deviceList
Form[] removeList

zadLibs z

int arraySize

event OnInit()
    StartUp()
endevent

event OnPlayerLoadGame()
    StartUp()
endevent

event OnUpdate()
    bind_Utility.WriteToConsole("binda_GearManagerAlias hit the failsafe due to timing out")
    GoToState("")
endevent

function StartUp()

    ;arraySize = 15
    me = self.GetActorReference()

    RegisterForModEvent("bind_BondageUpdateModEvent", "UpdateBondageModEvent")

endfunction

function SendAddOutfit(Actor akActor, int setId) global
    int handle = ModEvent.Create("bind_BondageUpdateModEvent")
    if handle
        ModEvent.PushForm(handle, akActor)
        ModEvent.PushInt(handle, setId)
        ModEvent.Send(handle)
    endif
endfunction

event UpdateBondageModEvent(Form akActor, int setId)

    if (akActor as Actor) == me && setid > 0

        Form[] items = binda_Bondage.GetBondageItems(setid)
        bind_Utility.WriteToConsole("UpdateBondageModEvent items: " + items)

        Form[] clothing = binda_Bondage.GetClothing(setId)

        Form[] addItems
        addItems = Utility.CreateFormArray((items.Length + clothing.Length))

        int i = 0
        while i < items.Length
            addItems[i] = items[i]
            i += 1
        endwhile

        int offset = items.Length
        i = 0
        while i < clothing.Length
            addItems[(offset + i)] = clothing[i]
            i += 1
        endwhile

        ;re-order array items??

        bool removeGear = binda_Bondage.RemoveGearSetting(setId)
        bool leaveBondageItems = binda_Bondage.LeaveBondageItemsEquipped(setId)

        StorageUtil.SetIntValue(me, "bind_wearing_outfit_id", setId)
        ;update set name??

        bind_MainQuestScript mqs = Quest.GetQuest("bind_MainQuest") as bind_MainQuestScript
        if mqs
            mqs.TargetBondageSetId = -1
            mqs.ActiveBondageSetId = setId
        endif

        AddOutfit(addItems, removeGear, leaveBondageItems)

    endif

endevent

event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
    ;test for this mods items in all states?
endevent

event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
    if akBaseObject.HasKeywordString("zad_InventoryDevice")
        if StorageUtil.GetIntValue(akBaseObject, "binding_item") == 0
            StorageUtil.SetIntValue(akBaseObject, "binding_item", 10)
        endif
    endif
endevent

function InternalUnequipItem()
endfunction

function InternalEquipItem()
endfunction

function StripClothing()

    ; Head	0x00000001
    ; Hair / Circlet	0x00000002
    ; Body (Chest)	0x00000004
    ; Hands (Gauntlets)	0x00000008
    ; Forearms	0x00000010
    ; Amulet	0x00000020
    ; Ring	0x00000040
    ; Feet (Boots)	0x00000080
    ; Shield	0x00000200

    ;int[] slotMasks = new int[]

    ;int index
    int slotsChecked
    slotsChecked += 0x00100000
    slotsChecked += 0x00200000 ;ignore reserved slots
    slotsChecked += 0x80000000

    int thisSlot = 0x01
    while (thisSlot < 0x80000000)
        if (Math.LogicalAnd(slotsChecked, thisSlot) != thisSlot) ;only check slots we haven't found anything equipped on already
            Armor thisArmor = me.GetWornForm(thisSlot) as Armor
            if (thisArmor)
                if StorageUtil.FormListHas(me, "bind_safe_to_remove", thisArmor)
                    
                    me.UnequipItem(thisArmor, 1, true)
                else 
                    if thisArmor.IsPlayable() && !thisArmor.IsJewelry() && (!thisArmor.HasKeywordString("zad_Lockable"))
                        ;debug.MessageBox(thisArmor.GetName() + " val: " + thisArmor + " zad: " + thisArmor.HasKeywordString("zad_Lockable"))
                        StorageUtil.FormListAdd(me, "bind_safe_to_remove", thisArmor)
                        me.UnequipItem(thisArmor, 1, true)
                    endif
                endif
                slotsChecked += thisArmor.GetSlotMask() ;add all slots this item covers to our slotsChecked variable
            else ;no armor was found on this slot
                slotsChecked += thisSlot
            endif
        endif
        thisSlot *= 2 ;double the number to move on to the next slot
    endWhile

    ;will move this after I figure out Enchantment logic
    ; if (thisArmor.GetEnchantment()) ;check for basic enchantments
    ;     wornEnchantedForms[index] = thisArmor.getName()
    ;     index += 1
    ; elseif (WornObject.GetEnchantment(target, 0, thisSlot)) ;check for player-added enchantments
    ;     wornEnchantedForms[index] = WornObject.GetDisplayName(target, 0, thisSlot)
    ;     if (!wornEnchantedForms[index]) ;if it wasn't given a custom name, take the item's original name:
    ;         wornEnchantedForms[index] = thisArmor.getName()
    ;     endif
    ;     index += 1
    ; endif    

endfunction

function AddOutfit(Form[] items, bool removeGear, bool leaveBondageItems)

    GoToState("BuildingListsState")
    RegisterForSingleUpdate(30.0)

    arraySize = items.Length

    ; if deviceList.Length != arraySize
    ;     deviceList = Utility.ResizeFormArray(deviceList, arraySize, none)
    ; endif

    deviceList = Utility.CreateFormArray(arraySize)
    removeList = Utility.CreateFormArray(arraySize)

    z = Quest.GetQuest("zadQuest") as zadLibs
    if !z
        bind_Utility.WriteNotification("zlib could not be loaded", bind_Utility.TextColorRed()) ;this should not happen
        GoToState("")
        return
    endif

    GoToState("RemovingItemsState")

    ;equip new items
    int i = 0
    while i < items.Length
        deviceList[i] = items[i]
        i += 1
    endwhile

    if removeGear
        StripClothing()
    endif

    GoToState("BusyState")

    int ri = 0
    int bindingItem = 0

	i = me.GetNumItems()
	while i > 0			
		i -= 1
		Form kForm = me.GetNthForm(i)	
		if (kForm As Armor)
            Armor idevice = kForm As Armor
            if idevice && me.IsEquipped(idevice)
                bindingItem = StorageUtil.GetIntValue(idevice, "binding_item", 0)
                if bindingItem == 1 || bindingItem == 2
                    removeList[ri] = kForm
                    ri += 1	
                endif
            endif
		endif
	endwhile

    bind_Utility.WriteToConsole("remove list: " + removeList + " ri: " + ri)

    if ri == 0 || leaveBondageItems
        InternalEquipItem()
    else
        InternalUnequipItem()
    endif

endfunction

state BuildingListsState

    function AddOutfit(Form[] items, bool removeGear, bool leaveBondageItems)
    endfunction

endstate

state RemovingItemsState

    function AddOutfit(Form[] items, bool removeGear, bool leaveBondageItems)
    endfunction

endstate

state BusyState

    event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)

        if akBaseObject == currentDevice

            int i = 0
            while i < arraySize
                if akBaseObject == removeList[i]
                    removeList[i] = none
                    i = arraySize
                endif
                i += 1
            endwhile

            InternalUnequipItem()

        endif

    endevent

    event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)

        if akBaseObject == currentDevice

            int i = 0
            while i < arraySize
                if akBaseObject == deviceList[i]
                    deviceList[i] = none
                    if akBaseObject.HasKeywordString("zad_InventoryDevice")
                        if StorageUtil.GetIntValue(akBaseObject, "binding_item") == 0
                            StorageUtil.SetIntValue(akBaseObject, "binding_item", 10)
                        endif
                    endif
                    i = arraySize
                endif
                i += 1
            endwhile

            InternalEquipItem()

        endif

    endevent

    function InternalEquipItem()

        int i = 0
        while i < arraySize
            if deviceList[i] != none
                Form f = deviceList[i]
                if f as Armor
                    currentDevice = f
                    if !me.IsEquipped(f)
                        if f.HasKeywordString("zad_InventoryDevice")
                            StorageUtil.SetIntValue(f, "binding_item", 1)
                            z.LockDevice(me, f as Armor, false)
                        else
                            StorageUtil.SetIntValue(f, "binding_item", 2)
                            me.EquipItem(f, false, true)
                        endif
                    endif
                    return
                endif
            endif
            i += 1
        endwhile

        ;nothing left to equip

        int handle = ModEvent.Create("bind_ChangeOutfitCompletedModEvent")
        if handle
            ModEvent.PushForm(handle, me)
            ModEvent.Send(handle)
        endif

        UnregisterForUpdate()
        GoToState("")

    endfunction

    function InternalUnequipItem()

        int i = 0
        while i < arraySize
            if removeList[i] != none
                Form f = removeList[i]
                if f as Armor
                    currentDevice = f
                    if StorageUtil.GetIntValue(f, "binding_item") == 1
                        z.UnlockDevice(me, f as Armor, none, none, true, true)
                    else
                        me.UnequipItem(f, 1, true)
                    endif
                    return
                endif
            endif
            i += 1
        endwhile

        ;nothing left to unequip
        InternalEquipItem()

    endfunction

    function AddOutfit(Form[] items, bool removeGear, bool leaveBondageItems)
    endfunction

endstate
