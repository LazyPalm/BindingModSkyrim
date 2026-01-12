Scriptname bindc_SKSE extends Quest  

string function GetComputerTime() global native
bool function ShowSleepDialogue() global native
function PlayerChat(Actor act, string chatText) global native
function PlayerChatOutput(Actor act, string chatText) global native
Form[] function DoStripActor(Actor act, bool removeDevious) global native ;returns items count removed
function DoDressActor(Actor act, Form[] items) global native
int function StripItemsCount() global native
Form function GetStripItem(int idx) global native
bool function NudityTest(Actor act) global native
Form[] function SearchDevious(FormList deviousItems, int color, int itemType) global native
Form[] function SearchDeviousByKeywords(FormList deviousItems, string keywords) global native
Form[] function SearchFormListsByKeyword(string keywords, FormList formList, FormList formList2 = none, FormList formList3 = none) global native
Form[] function CreateRandomDeviousSet(FormList deviousItems, int material, int color, int[] chancesList) global native
Form[] function StripBySlots(Actor act, int[] stripList) global native
function EquipBondageOutfit(Actor act, Form[] ddItems, bool protectSltr = false, bool leaveBondageItems = false) global native
function EquipBondageOutfit2(Actor act, Form[] ddItems, Form[] ddRemoveItems) global native
Form[] function GetWornDevious(Actor act) global native
Form[] function GetWornGear(Actor act) global native
Form[] function GetDeviousInventory(Actor act) global native
int function CalculateCrowd(Actor searchByActor, actor ignoreActor = none, float soundDistance = 1000.0, float visualDistance = 3000.0) global native ;returns count of npcs with line of sight
int function ScanForFurniture(Actor searchByActor, Keyword[] keywordList, float distance = 3000.0) global native
ObjectReference[] function GetFurniture(Actor searchByActor, Keyword[] keywordList, float distance = 3000.0, string keyword = "") global native
function CleanUnusedBondageItemsFromInventory(Actor act) global native
function UnequipAllBondage(Actor act) global native
int[] function GetRandomNumbers(int minRange, int maxRange, int numberToReturn) global native
int function FindRule(Armor item) global native
string function IntToHex(int value) global native

int function SetToken(Actor act, Armor arm) global
    bindc_Util.WriteInformation("bindc_SKSE - SetToken - " + arm)
    StorageUtil.SetIntValue(act, "zad_RemovalToken" + arm, 1)	
    return 0
endfunction

int function SetDeviousRemovalTokens(Actor act, Form[] items) global
    ;debug.MessageBox(items)
    if items.Length > 0
        int i = 0
        while i < items.Length
            bindc_Util.WriteInformation("bindc_SKSE - SetToken - " + items[i])
            StorageUtil.SetIntValue(act, "zad_RemovalToken" + items[i], 1)	            
            i += 1
        endwhile
    endif
endfunction

int function LockDevice(Actor act, Armor arm) global
    zadLibs zlib = Quest.GetQuest("zadQuest") as zadLibs
    ;StorageUtil.SetIntValue(arm, "binding_item_flag", 1)
    StorageUtil.SetIntValue(arm, "bindc_item_flag", 1)
    zlib.LockDevice(act, arm, false)
    Utility.Wait(2.0)
    return 0
endfunction

int function UnlockDevice(Actor act, Armor arm) global
    zadLibs zlib = Quest.GetQuest("zadQuest") as zadLibs
    zlib.UnlockDevice(act, arm, none, none, true, true)
    Utility.Wait(1.0)
    return 0
endfunction

int function DisplayCaption(Actor act, string text) global
    ;debug.MessageBox(text)
    ;bind_SkseFunctions.PlayerChatOutput(act, text)
    return 0
endfunction

int function CrosshairNpc(Actor act) global
    Quest sq = Quest.GetQuest("bindc_SlaveryQuest")
    if sq.IsRunning()
        bindc_Slavery sqs = sq as bindc_Slavery
        sqs.CrosshairTargetNpc(act)
    endif    

    ;NOTE - when using conversation target (posing) check distance and clear if player has moved away too far
    return 0
endfunction

int function CrosshairDoor(Form d, ObjectReference o) global
    Quest sq = Quest.GetQuest("bindc_SlaveryQuest")
    if sq.IsRunning()
        bindc_Slavery sqs = sq as bindc_Slavery
        sqs.SubLookedAtDoor(o)
    endif

    return 0

endfunction

int function CrosshairBed(ObjectReference o) global
    Quest sq = Quest.GetQuest("bindc_SlaveryQuest")
    if sq.IsRunning()
        bindc_Slavery sqs = sq as bindc_Slavery
        ;sqs.NearbyBed.ForceRefTo(o) 
    endif

    return 0
endfunction

int function ActivatedShrine(string shrineName, string shrineGod) global
    Quest sq = Quest.GetQuest("bindc_SlaveryQuest")
    if sq.IsRunning()
        bindc_Slavery sqs = sq as bindc_Slavery
        sqs.SubPrayedAtShrine(shrineGod)
    endif

    return 0
endfunction

int function ActivatedDragon(ObjectReference o) global

    ; Quest q = Quest.GetQuest("bind_MainQuest")
    ; bind_Functions fs = q as bind_Functions
    ; bind_MainQuestScript main = q as bind_MainQuestScript

    ; if !StorageUtil.FormListHas(fs.GetSubRef(), "binding_dragons_list", o)
    ;     ;debug.MessageBox("activated dragon: " + o)
    ;     StorageUtil.FormListAdd(fs.GetSubRef(), "binding_dragons_list", o)
    ;     ;Debug.MessageBox("start: " + main.DomStartupQuestsEnabled)
    ;     if fs.ModInRunningState() && main.DomStartupQuestsEnabled == 1
    ;         Quest souls = Quest.GetQuest("bind_SoulsFromBonesQuest")
    ;         souls.Start()
    ;     endif
    ; else
    ;     ;debug.MessageBox("re-activated dragon: " + o)
    ; endif

    return 0

endfunction

int function ActivatedDoor(ObjectReference o) global
    Quest sq = Quest.GetQuest("bindc_SlaveryQuest")
    if sq.IsRunning()
        bindc_Slavery sqs = sq as bindc_Slavery
        sqs.SubUsedADoor(o)
    endif

    return 0
endfunction

int function SleepMenuClosed() global
    ;debug.MessageBox("SKSE closed sleep/wait menu")
    bindc_Util.SendSimpleModEvent("bindc_SleepWaitMenuClosed")
    return 0
endfunction