Scriptname bindc_Bondage extends Quest  

event OnInit()

endevent

event LoadGame()

endevent

int function EquipItems(Actor akActor, Form[] items) global

    int count = 0

    zadLibs z = Game.GetFormFromFile(0x00F624, "Devious Devices - Integration.esm") as zadlibs

    int i = 0
    while i < items.Length
        Armor dev = items[i] as Armor
        Keyword kw = z.GetDeviceKeyword(dev)
        if !akActor.WornHasKeyword(kw)
            if z.LockDevice(akActor, dev, false)
                count += 1
            endif
        endif
        i += 1
    endwhile

    return count

endfunction

int function RemoveItems(Actor akActor, bool useMemory = false) global

    int count = 0

    zadLibs z = Game.GetFormFromFile(0x00F624, "Devious Devices - Integration.esm") as zadlibs

    Formlist inventory = Game.GetFormFromFile(0x000D67, "binding.esm") as FormList
    FormList foundItems = Game.GetFormFromFile(0x000D68, "binding.esm") as FormList

    akActor.GetAllForms(inventory)

    foundItems.Revert()

    Keyword invKw = Keyword.GetKeyword("zad_InventoryDevice")

    int i = 0
    int invSize = inventory.GetSize()
    while i < invSize
        Form f = inventory.GetAt(i)
        if f.HasKeyword(invKw); akActor.IsEquipped(f)
            bindc_Util.WriteInformation(f.GetName())
            Armor dev = f as Armor
            if dev != none
                Armor rend = z.GetRenderedDevice(dev)
                if akActor.IsEquipped(rend)
                    bindc_Util.WriteInformation("found worn rendered device - adding")
                    foundItems.AddForm(f)
                endif
            endif
        endif
        i += 1
    endwhile

    debug.MessageBox(foundItems.ToArray())

    i = 0
    int foundSize = foundItems.GetSize()
    while i < foundSize
        Armor dev = foundItems.GetAt(i) as Armor
        if z.UnlockDevice(akActor, dev)
            count += 1
        endif
        i += 1
    endwhile

    if useMemory
        Form[] items = foundItems.ToArray()
        StorageUtil.FormListCopy(akActor, "bind_removed_bondage_items", items)
    endif

    return count

endfunction

int function RestoreItems(Actor akActor) global

    int count = 0

    zadLibs z = Game.GetFormFromFile(0x00F624, "Devious Devices - Integration.esm") as zadlibs

    Form[] items = StorageUtil.FormListToArray(akActor, "bind_removed_bondage_items")

    int i = 0
    while i < items.Length
        Armor dev = items[i] as Armor
        if z.LockDevice(akActor, dev, false)
            count += 1
        endif
        i += 1
    endwhile

    return count

endfunction

Form[] function GetWornItems(Actor akActor) global

    zadLibs z = Game.GetFormFromFile(0x00F624, "Devious Devices - Integration.esm") as zadlibs

    Formlist inventory = Game.GetFormFromFile(0x000D67, "binding.esm") as FormList
    FormList foundItems = Game.GetFormFromFile(0x000D68, "binding.esm") as FormList

    foundItems.Revert()

    akActor.GetAllForms(inventory)

    Keyword invKw = Keyword.GetKeyword("zad_InventoryDevice")

    int i = 0
    int invSize = inventory.GetSize()
    while i < invSize
        Form f = inventory.GetAt(i)
        if akActor.IsEquipped(f)
            bindc_Util.WriteInformation(f.GetName())
            if f.HasKeyword(invKw)
                bindc_Util.WriteInformation("found inventory device")
                foundItems.AddForm(f)
            endif
        endif
        i += 1
    endwhile

    return foundItems.ToArray()

endfunction