Scriptname binda_GearManagerAlias extends ReferenceAlias

Actor me

Form currentDevice

Form[] deviceList
int[] protect
Form[] removeList

zadLibs z

int arraySize

event OnInit()
    StartUp()
endevent

event OnPlayerLoadGame()
    StartUp()
endevent

function StartUp()

    arraySize = 15
    me = self.GetActorReference()

    RegisterForModEvent("bind_BondageUpdateModEvent", "UpdateBondageModEvent")

endfunction

event UpdateBondageModEvent(Form akActor, int setId)

    ;debug.MessageBox("akActor: " + akActor + " setId: " + setId)

    if (akActor as Actor) == me && setid > 0

        Form[] items = bind_BondageManager.GetBondageItems(setid)
        bind_Utility.WriteToConsole("UpdateBondageModEvent items: " + items)

        Form[] clothing = bind_BondageManager.GetClothing(setId)

        Form[] addItems
        addItems = Utility.CreateFormArray((items.Length + clothing.Length))

        int i = 0
        while i < items.Length
            addItems[i] = items[i]
            i += 1
        endwhile

        int offset = items.Length
        ; if offset < 0
        ;     offset = 0
        ; endif
        i = 0
        while i < clothing.Length
            addItems[(offset + i)] = clothing[i]
            i += 1
        endwhile

        ;re-order array items??

        ;debug.MessageBox(addItems)

        bool removeGear = bind_BondageManager.RemoveGearSetting(setId)

        StorageUtil.SetIntValue(me, "bind_wearing_outfit_id", setId)
        ;update set name??

        bind_MainQuestScript mqs = Quest.GetQuest("bind_MainQuest") as bind_MainQuestScript
        if mqs
            mqs.TargetBondageSetId = -1
            mqs.ActiveBondageSetId = setId
        endif

        AddOutfit(addItems, removeGear)

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

; function AddToRemoveList(Form f)
;     int i = 0
;     while i < arraySize
;         if removeList[i] == none
;             removeList[i] = f
;             return
;         endif
;         i += 1
;     endwhile
; endfunction

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
                if thisArmor.IsPlayable() && !thisArmor.IsJewelry() && (!thisArmor.HasKeywordString("zad_Lockable"))
                    ;debug.MessageBox(thisArmor.GetName() + " val: " + thisArmor + " zad: " + thisArmor.HasKeywordString("zad_Lockable"))
                    me.UnEquipItem(thisArmor, 1, true)
                endif
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
                slotsChecked += thisArmor.GetSlotMask() ;add all slots this item covers to our slotsChecked variable
            else ;no armor was found on this slot
                slotsChecked += thisSlot
            endif
        endif
        thisSlot *= 2 ;double the number to move on to the next slot
    endWhile

    ; ;head
    ; Form equippedItem = me.GetWornForm(0x00000001)
    ; if equippedItem && equippedItem.IsPlayable()
    ;     me.RemoveItem(equippedItem, 1, true)
    ; endif

    ; ;body
    ; equippedItem = me.GetWornForm(0x00000004)
    ; if equippedItem && equippedItem.IsPlayable()
    ;     me.RemoveItem(equippedItem, 1, true)
    ; endif

    ; ;hands
    ; equippedItem = me.GetWornForm(0x00000008)
    ; if equippedItem && equippedItem.IsPlayable()
    ;     me.RemoveItem(equippedItem, 1, true)
    ; endif

    ; ;forearms
    ; equippedItem = me.GetWornForm(0x00000010)
    ; if equippedItem && equippedItem.IsPlayable()
    ;     me.RemoveItem(equippedItem, 1, true)
    ; endif

    ; ;feet
    ; equippedItem = me.GetWornForm(0x00000080)
    ; if equippedItem && equippedItem.IsPlayable()
    ;     me.RemoveItem(equippedItem, 1, true)
    ; endif

    ; ;shield
    ; equippedItem = me.GetWornForm(0x00000200)
    ; if equippedItem && equippedItem.IsPlayable()
    ;     me.RemoveItem(equippedItem, 1, true)
    ; endif

endfunction

function AddOutfit(Form[] items, bool removeGear)

    GoToState("BuildingListsState")

    if deviceList.Length != arraySize
        deviceList = Utility.ResizeFormArray(deviceList, arraySize, none)
    endif

    ; if removeList.Length != arraySize
    ;     removeList = Utility.ResizeFormArray(removeList, arraySize, none)
    ; endif

    protect = new int[15]
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
        ;if !me.IsEquipped(items[i])
            deviceList[i] = items[i]
        ; else 
        ;     int ip = 0
        ;     while ip < arraySize
        ;         if removeList[ip] == items[i]
        ;             protect[ip] = 1
        ;             bind_Utility.WriteToConsole("protect: " + items[i].GetName() + " at: " + ip)
        ;             ip = arraySize ;break
        ;         endif
        ;         ip += 1
        ;     endwhile
        ;endif
        i += 1
    endwhile

    ;debug.MessageBox("items: " + deviceList + " total: " + totalDevices + " remove: " + removeList + " remove total: " + totalRemoveDevices)

    if removeGear
        StripClothing()
    endif

    GoToState("BusyState")

    int ri = 0

	i = me.GetNumItems()
	while i > 0			
		i -= 1
		Form kForm = me.GetNthForm(i)	
		if (kForm As Armor)
            Armor idevice = kForm As Armor
            if idevice && me.IsEquipped(idevice)
                if StorageUtil.GetIntValue(idevice, "binding_item") == 1 || StorageUtil.GetIntValue(idevice, "binding_item") == 2
                    removeList[ri] = kForm
                    ri += 1	
                endif
                ; if idevice.IsPlayable() && (idevice.HasKeywordString("ArmorCuirass") || idevice.HasKeywordString("ClothingBody")) && removeGear
                ;     removeList[ri] = kForm
                ;     ri += 1	
                ; endif
                ; if idevice.HasKeyword(z.zad_InventoryDevice) && StorageUtil.GetIntValue(idevice, "binding_item") == 1	
                ;     removeList[ri] = kForm
                ;     ri += 1			
                ;     debug.MessageBox("possible zad remove: " + idevice.GetName() + " stored: " + StorageUtil.GetIntValue(idevice, "binding_item"))
                ; elseif idevice.IsPlayable() && (!idevice.IsJewelry()) && (!idevice.HasKeyword(z.zad_Lockable)) && removeGear
                ;     removeList[ri] = kForm
                ;     ri += 1                    
                ;     debug.MessageBox("possible clothing/armor remove: " + idevice.GetName())
                ; endif
            endif
		endif
	endwhile

    bind_Utility.WriteToConsole("remove list: " + removeList + " ri: " + ri)

    if ri == 0
        InternalEquipItem()
    else
        InternalUnequipItem()
    endif

endfunction

function AddOutfitItems()



endfunction

state BuildingListsState

    function AddOutfit(Form[] items, bool removeGear)
    endfunction

endstate

state RemovingItemsState

    function AddOutfit(Form[] items, bool removeGear)
    endfunction

endstate

state BusyState

    event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)

        if akBaseObject == currentDevice

            int i = 0
            while i < arraySize
                if akBaseObject == removeList[i]
                    ;Debug.MessageBox(akBaseObject + " stored: " + StorageUtil.GetIntValue(akBaseObject, "binding_item"))
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
                        ;AddToRemoveList(akBaseObject)
                    endif
                    i = arraySize
                endif
                i += 1
            endwhile

            InternalEquipItem()

        endif

    endevent

    function InternalEquipItem()

        ;debug.MessageBox("***** InternalEquipItem")
        ;debug.MessageBox(deviceList)

        int i = 0
        while i < arraySize
            if deviceList[i] != none
                Form f = deviceList[i]
                if f as Armor
                    ;debug.MessageBox(f)
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
        ;debug.MessageBox(removeList)

        int handle = ModEvent.Create("bind_ChangeOutfitCompletedModEvent")
        if handle
            ModEvent.PushForm(handle, me)
            ModEvent.Send(handle)
        endif

        GoToState("")

    endfunction

    function InternalUnequipItem()

        ;debug.MessageBox("***** InternalEquipItem")

        ;debug.MessageBox("currentRemoveIndex: " + currentRemoveIndex + " totalRemoveDevices: " + totalRemoveDevices)

        int i = 0
        while i < arraySize
            if removeList[i] != none && protect[i] == 0
                Form f = removeList[i]
                if f as Armor
                    currentDevice = f
                    if StorageUtil.GetIntValue(f, "binding_item") == 1 ; f.HasKeywordString("zad_InventoryDevice")
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

    function AddOutfit(Form[] items, bool removeGear)
    endfunction

endstate
