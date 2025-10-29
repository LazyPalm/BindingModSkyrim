Scriptname bind_SkseFunctions hidden 

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
Form[] function CreateRandomDeviousSet(FormList deviousItems, int material, int color, int[] chancesList) global native
Form[] function StripBySlots(Actor act, int[] stripList) global native
function EquipBondageOutfit(Actor act, Form[] ddItems) global native