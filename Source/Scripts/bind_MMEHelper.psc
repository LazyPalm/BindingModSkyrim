Scriptname bind_MMEHelper extends Quest  

bool function CheckValid() Global
    return Game.IsPluginInstalled("MilkModNEW.esp")
endfunction

MilkQUEST function GetMilkQuest() global
    return Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
endfunction

bind_MMEHelper function GetMMEHelper() global
    return Quest.GetQuest("bind_MainQuest") as bind_MMEHelper
endfunction

Keyword function GetBoundMilkPumpKeyword() global
    return Keyword.GetKeyword("MME_zbfFurnitureMilkoMaticB")
    ;return Game.GetFormFromFile(0x0307E3BD, "MilkModNEW.esp") as Keyword
endfunction

float function GetLactacidLevel(Actor a) global
    return MME_Storage.getLactacidCurrent(a)
endfunction

float function GetMilkLevel(Actor a) global
    return MME_Storage.getMilkCurrent(a)
endfunction

float function GetMilkMax(Actor a) global
    return MME_Storage.getMilkMaximum(a)
endfunction

float function GetTimesMilked(Actor a) global
    return StorageUtil.GetFloatValue(a, "MME.MilkMaid.TimesMilked", 0.0)
endfunction

function MakeMilkSlave(Actor a) global
    ;NOTE - does not work for Player
    ;MilkQUEST milk = GetMilkQuest()
    ;milk.AssignSlotSlave(a, 1, 0.0)
     StorageUtil.SetIntValue(a, "bind_milk_slave", 1)
endfunction

Spell function GetMilkLeakSpell() global
    MilkQUEST milk = GetMilkQuest()
    return milk.MilkLeak
endfunction

Spell function GetMilkSelfSpell() global
    MilkQuest milk = GetMilkQuest()
    return milk.MilkSelf
endfunction

Armor function GetMilkCuirass() global
    MilkQuest milk = GetMilkQuest()
    return milk.MilkCuirass
endfunction

function FreeFromMilkSlavery(Actor a) global
    MilkQUEST milk = GetMilkQuest()
    milk.MaidRemove(a)
    StorageUtil.SetIntValue(a, "bind_milk_slave", 0)
endfunction

function FeedLactacid(Actor a, int qty = 1) global
    MilkQUEST milk = GetMilkQuest()
    int i = 0
    while i < qty
        a.EquipItem(milk.MME_Util_Potions.GetAt(0), true, true)
        bind_Utility.DoSleep(0.1)
        i += 1
    endwhile
endfunction

function GiveLactacid(Actor a, int qty = 1) global
    MilkQUEST milk = GetMilkQuest()
    a.AddItem(milk.MME_Util_Potions.GetAt(0), qty, true)
endfunction

Form function GetLactacid() global
    MilkQUEST milk = GetMilkQuest()
    return milk.MME_Util_Potions.GetAt(0)
endfunction