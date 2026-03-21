Scriptname bindc_Main extends Quest  

float updateInterval = 30.0

Actor thePlayer

Quest freePerson
Quest slave

int keyCodeLeftControl = 29
int keyCodeRightControl = 157
int keyCodeLeftAlt = 56
int keyCodeRightAlt = 184
int keyCodeLeftShift = 42
int keyCodeRightShift = 54

int actionKey
int modKey

int settingsKey
int settingsModKey

bool processingKey
bool runningStartQuests

event OnInit()

    if IsRunning()
        ;************************************************
        ;startup settings - these will go to the mcm
        StorageUtil.SetIntValue(thePlayer, "bindc_write_to_console", 1) ;todo - set this in the mcm
        ;************************************************

        thePlayer = Game.GetPlayer()

        LoadGame()
    endif

endevent

event OnKeyUp(Int KeyCode, Float HoldTime)	

    if !processingKey   

        processingKey = true

        bool modKeysPressed = false
        if modKey > 0
            modKeysPressed = Input.IsKeyPressed(modKey)
        endif
        if settingsModKey > 0 && !modKeysPressed
            modKeysPressed = Input.IsKeyPressed(settingsModKey)
        endif

        if keyCode == actionKey

            if (modKey == 0 && !modKeysPressed) || (Input.IsKeyPressed(modKey))

                bindc_Util.WriteInformation("action key press time: " + holdTime)

                if thePlayer.IsWeaponDrawn()

                    bindc_Util.WriteModNotification("Action key disabled when combat ready")

                else

                    if holdTime <= 0.5
                        bindc_Util.SendSimpleModEvent("BindingEventShortPress")
                    else
                        bindc_Util.SendSimpleModEvent("BindingEventLongPress")
                    endif

                endif

            endif

        endif

        if keyCode == settingsKey

            if (settingsModKey == 0 && !modKeysPressed) || (Input.IsKeyPressed(settingsModKey))

                ShowSettingsMenu()

            endif

        endif

        processingKey = false

    endif

endevent

function LoadGame()

    UnregisterForUpdate()

    processingKey = false
    runningStartQuests = false

    ; if StorageUtil.GetIntValue(thePlayer, "bindc_save_id", -1) == -1
    ;     StorageUtil.SetIntValue(thePlayer, "bindc_save_id", Utility.RandomInt(1000000, 5000000))
    ; endif

    RegisterForModEvent("dhlp-Suspend", "OnDhlpSuspend")
    RegisterForModEvent("dhlp-Resume", "OnDhlpResume") 

    actionKey = JsonUtil.GetIntValue(bindc_Data.SettingsFile(), "key_action", 0) ; StorageUtil.GetIntValue(thePlayer, "bindc_action_key", 27)
    ;debug.MessageBox("action: " + actionKey)
    modKey = JsonUtil.GetIntValue(bindc_Data.SettingsFile(), "key_action_mod", 0) ; StorageUtil.GetIntValue(thePlayer, "bindc_action_mod", -1)

    settingsKey = JsonUtil.GetIntValue(bindc_Data.SettingsFile(), "key_setting", 0) ; StorageUtil.GetIntValue(thePlayer, "bindc_settings_key", 27)
    settingsModKey = JsonUtil.GetIntValue(bindc_Data.SettingsFile(), "key_setting_mod", 0) ; StorageUtil.GetIntValue(thePlayer, "bindc_settings_mod", 54)

    RegisterForControl("Activate")

    if actionKey > 0
        RegisterForKey(actionKey)
    endif
    if settingsKey > 0 && settingsKey != actionKey
        RegisterForKey(settingsKey)
    endif

    if freePerson == none
        freePerson = Quest.GetQuest("bindc_FreeQuest")
    endif

    if slave == none
        slave = Quest.GetQuest("bindc_SlaveQuest")
    endif

    ; if bindc_data.Enslaved() == 0
    ;     bindc_Data.ModState(1)
    ;     ;     if !freePerson.IsRunning()
    ; ;         freePerson.Start()
    ; ;     endif
    ; endif

    bindc_Util.SendSimpleModEvent("BindingEventLoadGame")

    ;StateTrigger() ;this needs to be here in case main quest is stopped / started
    RegisterForSingleUpdate(updateInterval)

    debug.MessageBox("load completed...")

endfunction

ObjectReference function GetConversationTarget() global
    Quest q = Quest.GetQuest("bindc_MainQuest")
    if q != none
        return (q as bindc_Main).ConversationTargetNpc.GetReference()
    else 
        return none
    endif
endfunction 

function SetConversationTarget(ObjectReference target)
    ConversationTargetNpc.ForceRefTo(target)
    bindc_Util.SendSimpleModEvent("BindingEventSetConversationTarget")
endfunction

function ClearConversationTarget()
    ConversationTargetNpc.Clear()
    bindc_Util.SendSimpleModEvent("BindingEventClearConversationTarget")
endfunction

function TryStartQuests()

    bool check = true

    if slave.IsRunning() || freePerson.IsRunning()
        check = false
    endif
    
    if RunningEventQuest != none
        if RunningEventQuest.IsRunning()
            check = false
        endif
    endif

    bindc_Util.WriteInformation("TryStartQuests check: " + check)

    if check

        if bindc_Data.Enslaved() == 1 ;&& bindc_Data.ModState() < 3 ;StorageUtil.GetIntValue(thePlayer, "bindc_mod_state", 0) == 2
            if !runningStartQuests
                runningStartQuests = true
                if !slave.IsRunning()
                    ;debug.MessageBox("master detection trying to start slave quest")
                    slave.Start()
                    bindc_Util.DoSleep(2.0)
                endif
                if !slave.IsRunning()
                    if !freePerson.IsRunning()
                        freePerson.Start()
                    endif
                endif
                ;bindc_Data.ModState(0) ;setting the mod to idle will start the right quests and set the correct state
                ;slave.Start() ;NOTE - quest will only start if master alias is filled (in faction & in range)
                runningStartQuests = false
            endif
        else
            if !runningStartQuests
                runningStartQuests = true
                if !freePerson.IsRunning()
                    freePerson.Start()
                endif
                runningStartQuests = false
            endif
        endif
    endif

endfunction

event OnUpdate()

    bindc_Util.WriteInformation("cycle - " + bindc_Util.GetTime())

    bindc_Util.SendSimpleModEvent("BindingEventCycle")

    TryStartQuests()

    RegisterForSingleUpdate(updateInterval)

endevent

function StartEvent(Quest q) global
    ;debug.MessageBox("startevent: " + q)
    Quest mq = Quest.GetQuest("bindc_MainQuest")
    if mq != none
        bindc_Main main = mq as bindc_Main
        main.RunningEventQuest = q
        ;debug.MessageBox("in here???")
    endif
endfunction

function StartFreeQuest() global
    Quest free = Quest.GetQuest("bindc_FreeQuest")
    if !free.IsRunning()
        free.Start()
    endif
endfunction

function StopFreeQuest() global
    Quest free = Quest.GetQuest("bindc_FreeQuest")
    if free.IsRunning()
        free.Stop()
    endif
endfunction

function StartSlaveQuest() global
    Quest slv = Quest.GetQuest("bindc_SlaveQuest")
    if !slv.IsRunning()
        slv.Start()
    endif
endfunction

function StopSlaveQuest() global
    Quest slv = Quest.GetQuest("bindc_SlaveQuest")
    if slv.IsRunning()
        slv.Stop()
    endif
endfunction

;******************************************************************************************
; SETTING MENU
;******************************************************************************************

function ShowSettingsMenu()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    listMenu.AddEntryItem("--- Binding Settings Menu ---")
    listMenu.AddEntryItem("Learn Outfit (Enter name at prompt)")
    listMenu.AddEntryItem("List Outfits")
    listMenu.AddEntryItem("Add Default Items To Inventory")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ShowSettingsMenu()
    elseif listReturn == 1
        LearnOutfit()
    elseif listReturn == 2
        ListOutfitsMenu()
    elseif listReturn == 3
        Form[] items = JsonUtil.FormListToArray(bindc_Data.SettingsFile(), "default_bondage_items")
        ;debug.MessageBox(items)
        int i = 0
        while i < items.Length
            if thePlayer.GetItemCount(items[i]) == 0
                thePlayer.AddItem(items[i], 1, false)
            endif
            i += 1
        endwhile

    else

    endif

endfunction

function LearnOutfit()

    UIExtensions.InitMenu("UITextEntryMenu")
    UIExtensions.OpenMenu("UITextEntryMenu")
    string result = UIExtensions.GetMenuResultString("UITextEntryMenu")
    result = bindc_Util.SanitizeAZ09Space(result) ;make sure no special characters are in the name
    if result != ""
        if StorageUtil.StringListCountValue(thePlayer, "bindc_outfit_list", result) > 0
            if !bindc_Util.ConfirmBox(result + " already exists. Update?")
                return
            endif
        endif
        
        Form[] items = bindc_Gear.GetWornOutfit(thePlayer)
        debug.MessageBox(items)
        StorageUtil.FormListCopy(thePlayer, "bindc_outfit_" + result, items)

        StorageUtil.StringListAdd(thePlayer, "bindc_outfit_list", result, false)

        Debug.MessageBox(result + " has been saved")
    endif

endfunction

function ListOutfitsMenu()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    listMenu.AddEntryItem("<-- Leave List Outfits Menu")

    string[] outfits = StorageUtil.StringListToArray(thePlayer, "bindc_outfit_list")
    int i = 0
    while i < outfits.Length
        listMenu.AddEntryItem("Slave Outfit: " + outfits[i])
        i += 1
    endwhile

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ShowSettingsMenu()
    elseif listReturn > 0
        OutfitOptionsMenu(outfits[listReturn - 1])
    endif

endfunction

function OutfitOptionsMenu(string outfitName)

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    listMenu.AddEntryItem("<-- Leave Slave Outfit: " + outfitName)

    listMenu.AddEntryItem("Try on")
    listMenu.AddEntryItem("Delete")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ListOutfitsMenu()
    elseif listReturn == 1
        StorageUtil.SetStringValue(thePlayer, "bindc_test_outfit_name", outfitName)
        Quest q = Quest.GetQuest("bindc_TryOutfitQuest")
        if q != none
            q.Start()
        endif
    elseif listReturn == 2
        if bindc_Util.ConfirmBox("Delete slave outfit: " + outfitName + "?")
            StorageUtil.FormListClear(thePlayer, "bindc_outfit_" + outfitName)
            StorageUtil.StringListRemove(thePlayer, "bindc_outfit_list", outfitName, true)
            debug.MessageBox(outfitName + " deleted.")
        endif

    endif

endfunction

ReferenceAlias property ConversationTargetNpc auto

Quest property RunningEventQuest auto