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
