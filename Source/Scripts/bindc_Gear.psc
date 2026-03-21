Scriptname bindc_Gear extends Quest  

event LoadGame()

endevent

int function UndressActor(Actor akActor, bool useMemory = false) global

    int count = 0

    Formlist inventory = Game.GetFormFromFile(0x000D67, "binding.esm") as FormList
    FormList foundItems = Game.GetFormFromFile(0x000D68, "binding.esm") as FormList

    ;StorageUtil.FormListClear(akActor, "bindc_strip_buffer")

    foundItems.Revert()

	Keyword kwHeavy = Keyword.GetKeyword("ArmorHeavy")
	Keyword kwLight = Keyword.GetKeyword("ArmorLight")
    Keyword kwClothing = Keyword.GetKeyword("ArmorClothing")
    Keyword kwDeviousInv = Keyword.GetKeyword("zad_InventoryDevice")

    int i = 0
    int invSize = inventory.GetSize()
    while i < invSize
        Form f = inventory.GetAt(i)
        if akActor.IsEquipped(f) && f.IsPlayable()
            bindc_Util.WriteInformation(f.GetName())
            if f.HasKeyword(kwHeavy) || f.HasKeyword(kwLight) || f.HasKeyword(kwClothing)
                bindc_Util.WriteInformation("found clothing or armor")
                foundItems.AddForm(f)
            endif
        endif
        i += 1
    endwhile

    ;debug.MessageBox(foundItems.GetSize())

    i = 0
    int foundSize = foundItems.GetSize()
    while i < foundSize
        Form f = foundItems.GetAt(i)
        akActor.UnequipItem(f, false, true)
        count += 1
        i += 1
    endwhile

    if useMemory
        Form[] items = foundItems.ToArray()
        ;debug.MessageBox(items)
        StorageUtil.FormListCopy(akActor, "bindc_strip_buffer", items)
    endif

    return count

endfunction

int function DressActor(Actor akActor) global

    int count = 0

    Form[] items = StorageUtil.FormListToArray(akActor, "bindc_strip_buffer")

    ;debug.MessageBox(items)

    int i = 0
    while i < items.Length
        Form f = items[i]
        akActor.EquipItem(f, false, false)
        count += 1
        i += 1
    endwhile

    return count

endfunction

int function ChangeActorsClothing(Actor akActor, Form[] items) global
    
    int count = 0


    return count

endfunction

Form[] function GetWornOutfit(Actor akActor) global

    zadLibs z = Game.GetFormFromFile(0x00F624, "Devious Devices - Integration.esm") as zadlibs

    Formlist inventory = Game.GetFormFromFile(0x000D67, "binding.esm") as FormList
    FormList foundItems = Game.GetFormFromFile(0x000D68, "binding.esm") as FormList

    foundItems.Revert()

    akActor.GetAllForms(inventory)

    Keyword invKw = Keyword.GetKeyword("zad_InventoryDevice")
    Keyword invRend = Keyword.GetKeyword("zad_Lockable")

    int i = 0
    int invSize = inventory.GetSize()
    while i < invSize
        Form f = inventory.GetAt(i)
        if akActor.IsEquipped(f) && f.IsPlayable()
            bindc_Util.WriteInformation(f.GetName())
            if f.HasKeyword(invKw)
                bindc_Util.WriteInformation("found inventory device")
                foundItems.AddForm(f)
            elseif f.HasKeyword(invRend)
                ;skip these
            else
                foundItems.AddForm(f)
            endif
        endif
        i += 1
    endwhile

    return foundItems.ToArray()

endfunction

function TryOnOutfitStart(Actor akActor, string outfitName) global

endfunction

function TryOnOutfitEnd() global

endfunction