Scriptname bind_DM3Helper extends Quest  

bool Function CheckValid() Global
    return Game.GetModByName("dse-display-model.esp") != 255
EndFunction

dse_dm_QuestController Function GetMainQuest() Global
    return Quest.GetQuest("dse_dm_QuestController") as dse_dm_QuestController
Endfunction

Keyword Function GetFurnitureKeyword() Global
    return Keyword.GetKeyword("dse_dm_KeywordFurniture")
    ;return Game.GetFormFromFile(0x0300182B,"dse-display-model.esp") as Keyword
EndFunction

string Function FurnitureList() Global
    string list = "DM3 Alessias Perch,DM3 Alokzaam 1,DM3 Alokzaam 2,DM3 Alokzaam 3,DM3 Alokzaam 4,DM3 Bovahdin,DM3 Cage,DM3 Chair,DM3 Chapel Dibella,"
    list = list + "DM3 Chapel Souls,DM3 Coffin 1,DM3 Coffin 2,DM3 Dollstand,DM3 Dollstand Double,DM3 Frame,DM3 Horse Rig,DM3 Maras Tear,DM3 Pony Rope,"
    list = list + "DM3 Pony Wood,DM3 Queenbreaker,DM3 Almalexia Seat,DM3 The Board,DM3 The Vigilant"

    return list
EndFunction

Activator function GetRandomItem() global

    string dm3File = "dse-display-model.esp"

    int i = Utility.RandomInt(1, 22)

    If i == 1
         return Game.GetFormFromFile(0x030053A3, dm3File) as Activator ;dse_dm_FurnAlessiasPerch01
    ElseIf i == 2
        return Game.GetFormFromFile(0x0300538F, dm3File) as Activator ;dse_dm_FurnAlokzaam01
    ElseIf i == 3
        return Game.GetFormFromFile(0x03005395, dm3File) as Activator ;dse_dm_FurnAlokzaam01
    ElseIf i == 4
        return Game.GetFormFromFile(0x03005396, dm3File) as Activator ;dse_dm_FurnAlokzaam01
    ElseIf i == 5
        return Game.GetFormFromFile(0x030059013, dm3File) as Activator ;dse_dm_FurnAlokzaam01
    ElseIf i == 6
        return Game.GetFormFromFile(0x030053A7, dm3File) as Activator ;dse_dm_FurnTheVigilant01
    ElseIf i == 7
        return Game.GetFormFromFile(0x030053A4, dm3File) as Activator ;dse_dm_FurnBovahdin01
    ElseIf i == 8
        return Game.GetFormFromFile(0x030063F4, dm3File) as Activator ;dse_dm_FurnCage01
    ElseIf i == 9
        return Game.GetFormFromFile(0x0300A52F, dm3File) as Activator ;dse_dm_FurnChair01
    ElseIf i == 10
        return Game.GetFormFromFile(0x030053A5, dm3File) as Activator ;dse_dm_FurnChapelDibella01
    ElseIf i == 11
        return Game.GetFormFromFile(0x03016254, dm3File) as Activator ;dse_dm_FurnChapelSouls01
    ElseIf i == 12
        return Game.GetFormFromFile(0x0301625A, dm3File) as Activator ;dse_dm_FurnCoffin01
    ElseIf i == 13
        return Game.GetFormFromFile(0x03016261, dm3File) as Activator ;dse_dm_FurnCoffin02
    ElseIf i == 14
        return Game.GetFormFromFile(0x0300182A, dm3File) as Activator ;dse_dm_FurnDollstand01
    ElseIf i == 15
        return Game.GetFormFromFile(0x03002DC0, dm3File) as Activator ;dse_dm_FurnDoubleDollstand01
    ElseIf i == 16
        return Game.GetFormFromFile(0x0300DB67, dm3File) as Activator ;dse_dm_FurnFrame01
    ElseIf i == 17
        return Game.GetFormFromFile(0x0300C5A1, dm3File) as Activator ;dse_dm_FurnMarasTear01
    ElseIf i == 18
        return Game.GetFormFromFile(0x03002DC5, dm3File) as Activator ;dse_dm_FurnPonyRope01
    ElseIf i == 19
        return Game.GetFormFromFile(0x03002DC6, dm3File) as Activator ;dse_dm_FurnPonyWood01
    ElseIf i == 20
        return Game.GetFormFromFile(0x03005E79, dm3File) as Activator ;dse_dm_FurnQueenbreaker01
    ElseIf i == 21
        return Game.GetFormFromFile(0x030053A6, dm3File) as Activator ;dse_dm_FurnSeatAlmalexia01
    ElseIf i == 22
        return Game.GetFormFromFile(0x030141F8, dm3File) as Activator ;dse_dm_FurnTheBoard01
    endif

endfunction

function BuildFormList(FormList list) global

    string dm3File = "dse-display-model.esp"

    list.AddForm(Game.GetFormFromFile(0x030053A3, dm3File)) ;dse_dm_FurnAlessiasPerch01
    list.AddForm(Game.GetFormFromFile(0x0300538F, dm3File))  ;dse_dm_FurnAlokzaam01
    list.AddForm(Game.GetFormFromFile(0x03005395, dm3File))  ;dse_dm_FurnAlokzaam01
    list.AddForm(Game.GetFormFromFile(0x03005396, dm3File))  ;dse_dm_FurnAlokzaam01
    list.AddForm(Game.GetFormFromFile(0x030059013, dm3File))  ;dse_dm_FurnAlokzaam01
    list.AddForm(Game.GetFormFromFile(0x03007455, dm3File))  ;dse_dm_FurnBall01
    list.AddForm(Game.GetFormFromFile(0x030053A4, dm3File))  ;dse_dm_FurnBovahdin01
    list.AddForm(Game.GetFormFromFile(0x030063F4, dm3File))  ;dse_dm_FurnCage01
    list.AddForm(Game.GetFormFromFile(0x0300A52F, dm3File))  ;dse_dm_FurnChair01
    list.AddForm(Game.GetFormFromFile(0x030053A5, dm3File))  ;dse_dm_FurnChapelDibella01
    list.AddForm(Game.GetFormFromFile(0x03016254, dm3File))  ;dse_dm_FurnChapelSouls01
    list.AddForm(Game.GetFormFromFile(0x0301625A, dm3File))  ;dse_dm_FurnCoffin01
    list.AddForm(Game.GetFormFromFile(0x03016261, dm3File))  ;dse_dm_FurnCoffin02
    list.AddForm(Game.GetFormFromFile(0x0300182A, dm3File))  ;dse_dm_FurnDollstand01
    list.AddForm(Game.GetFormFromFile(0x03002DC0, dm3File))  ;dse_dm_FurnDoubleDollstand01
    list.AddForm(Game.GetFormFromFile(0x0300DB67, dm3File))  ;dse_dm_FurnFrame01
    list.AddForm(Game.GetFormFromFile(0x0300C5BF, dm3File))  ;dse_dm_FurnHorseRig01
    list.AddForm(Game.GetFormFromFile(0x0300C5A1, dm3File))  ;dse_dm_FurnMarasTear01
    list.AddForm(Game.GetFormFromFile(0x03002DC5, dm3File))  ;dse_dm_FurnPonyRope01
    list.AddForm(Game.GetFormFromFile(0x03002DC6, dm3File))  ;dse_dm_FurnPonyWood01
    list.AddForm(Game.GetFormFromFile(0x03005E79, dm3File))  ;dse_dm_FurnQueenbreaker01
    list.AddForm(Game.GetFormFromFile(0x030053A6, dm3File))  ;dse_dm_FurnSeatAlmalexia01
    list.AddForm(Game.GetFormFromFile(0x030141F8, dm3File))  ;dse_dm_FurnTheBoard01
    list.AddForm(Game.GetFormFromFile(0x030053A7, dm3File))  ;dse_dm_FurnTheVigilant01

endfunction

Activator Function GetFurnitureItem(string itemName) Global

    string dm3File = "dse-display-model.esp"

    If itemName == "DM3 Alessias Perch"
         return Game.GetFormFromFile(0x030053A3, dm3File) as Activator ;dse_dm_FurnAlessiasPerch01
    ElseIf itemName == "DM3 Alokzaam 1"
        return Game.GetFormFromFile(0x0300538F, dm3File) as Activator ;dse_dm_FurnAlokzaam01
    ElseIf itemName == "DM3 Alokzaam 2"
        return Game.GetFormFromFile(0x03005395, dm3File) as Activator ;dse_dm_FurnAlokzaam01
    ElseIf itemName == "DM3 Alokzaam 3"
        return Game.GetFormFromFile(0x03005396, dm3File) as Activator ;dse_dm_FurnAlokzaam01
    ElseIf itemName == "DM3 Alokzaam 4"
        return Game.GetFormFromFile(0x030059013, dm3File) as Activator ;dse_dm_FurnAlokzaam01
    ElseIf itemName == "DM3 Ball"
        return Game.GetFormFromFile(0x03007455, dm3File) as Activator ;dse_dm_FurnBall01
    ElseIf itemName == "DM3 Bovahdin"
        return Game.GetFormFromFile(0x030053A4, dm3File) as Activator ;dse_dm_FurnBovahdin01
    ElseIf itemName == "DM3 Cage"
        return Game.GetFormFromFile(0x030063F4, dm3File) as Activator ;dse_dm_FurnCage01
    ElseIf itemName == "DM3 Chair"
        return Game.GetFormFromFile(0x0300A52F, dm3File) as Activator ;dse_dm_FurnChair01
    ElseIf itemName == "DM3 Chapel Dibella"
        return Game.GetFormFromFile(0x030053A5, dm3File) as Activator ;dse_dm_FurnChapelDibella01
    ElseIf itemName == "DM3 Chapel Souls"
        return Game.GetFormFromFile(0x03016254, dm3File) as Activator ;dse_dm_FurnChapelSouls01
    ElseIf itemName == "DM3 Coffin 1"
        return Game.GetFormFromFile(0x0301625A, dm3File) as Activator ;dse_dm_FurnCoffin01
    ElseIf itemName == "DM3 Coffin 2"
        return Game.GetFormFromFile(0x03016261, dm3File) as Activator ;dse_dm_FurnCoffin02
    ElseIf itemName == "DM3 Dollstand"
        return Game.GetFormFromFile(0x0300182A, dm3File) as Activator ;dse_dm_FurnDollstand01
    ElseIf itemName == "DM3 Dollstand Double"
        return Game.GetFormFromFile(0x03002DC0, dm3File) as Activator ;dse_dm_FurnDoubleDollstand01
    ElseIf itemName == "DM3 Frame"
        return Game.GetFormFromFile(0x0300DB67, dm3File) as Activator ;dse_dm_FurnFrame01
    ElseIf itemName == "DM3 Horse Rig"
        return Game.GetFormFromFile(0x0300C5BF, dm3File) as Activator ;dse_dm_FurnHorseRig01
    ElseIf itemName == "DM3 Maras Tear"
        return Game.GetFormFromFile(0x0300C5A1, dm3File) as Activator ;dse_dm_FurnMarasTear01
    ElseIf itemName == "DM3 Pony Rope"
        return Game.GetFormFromFile(0x03002DC5, dm3File) as Activator ;dse_dm_FurnPonyRope01
    ElseIf itemName == "DM3 Pony Wood"
        return Game.GetFormFromFile(0x03002DC6, dm3File) as Activator ;dse_dm_FurnPonyWood01
    ElseIf itemName == "DM3 Queenbreaker"
        return Game.GetFormFromFile(0x03005E79, dm3File) as Activator ;dse_dm_FurnQueenbreaker01
    ElseIf itemName == "DM3 Almalexia Seat"
        return Game.GetFormFromFile(0x030053A6, dm3File) as Activator ;dse_dm_FurnSeatAlmalexia01
    ElseIf itemName == "DM3 The Board"
        return Game.GetFormFromFile(0x030141F8, dm3File) as Activator ;dse_dm_FurnTheBoard01
    ElseIf itemName == "DM3 The Vigilant"
        return Game.GetFormFromFile(0x030053A7, dm3File) as Activator ;dse_dm_FurnTheVigilant01

    Else
        return none
    EndIf

EndFunction

int Function LockInFurniture(ObjectReference item, Actor act) Global

    dse_dm_QuestController dm3Quest = GetMainQuest()
    dse_dm_ActiPlaceableBase dm3Device = item as dse_dm_ActiPlaceableBase

    ;NOTE: our scan has already indicated that there is an open slot on this furniture

    int slot = 0

    if (!dm3Device.IsEmptySlot(slot))
        ;if slot 0 is occupied, this will drop the actor into the 2nd slot
        ;NOTE - need to check and see if there are dm3 furnitures with more than 2 slots
        slot = dm3Device.GetNextSlot()
    endif

    dm3Device.ActivateByActor(act, slot)

    return slot

EndFunction

bool function LockedInCheck(ObjectReference item, Actor act) Global
    dse_dm_QuestController dm3Quest = GetMainQuest()
    dse_dm_ActiPlaceableBase dm3Device = item as dse_dm_ActiPlaceableBase
    return (dm3Device.GetNextSlot(act) != -1)
endfunction

Function UnlockFromFurniture(ObjectReference item, int slot) Global

    dse_dm_QuestController dm3Quest = GetMainQuest()
    dse_dm_ActiPlaceableBase dm3Device = item as dse_dm_ActiPlaceableBase
    dm3Device.ReleaseActorSlot(slot)

EndFunction

bool Function FurnitureHasFreeSlots(ObjectReference item) Global
    dse_dm_QuestController dm3Quest = GetMainQuest()
    dse_dm_ActiPlaceableBase dm3Device = item as dse_dm_ActiPlaceableBase
    String dm3File = dm3Quest.Devices.GetFileByID(dm3Device.DeviceID)
    int slotCount = dm3Quest.Devices.GetDeviceActorSlotCount(dm3File)
    int actorCount = dm3Device.GetMountedActorCount()
    If slotCount > actorCount
        return true
    Else
        return false
    EndIf
EndFunction