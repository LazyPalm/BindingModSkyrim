Scriptname bindc_Mcm extends SKI_ConfigBase

int[] controlGroup1
int[] controlGroup2
int[] controlGroup3
int[] controlGroup4
int[] controlGroup5
int[] controlGroup6

bool toggled1

string selectedStr1
string selectedStr2
string selectedStr3
string selectedStr4

int selectedInt1
int selectedInt2
int selectedInt3
int selectedInt4

Form[] formArr1
Form[] formArr2
Form[] formArr3

string[] strArr1
string[] strArr2

int[] intArr1
int[] intArr2

Actor thePlayer

event OnConfigOpen()

    Quest qold = Quest.GetQuest("bind_MainQuest")
    if qold == none

        if thePlayer == none
            thePlayer = Game.GetPlayer()
        endif

        if controlGroup1.Length == 0 || controlGroup2.Length == 0 || controlGroup3.Length == 0 || controlGroup4.Length == 0 || controlGroup5.Length == 0 || controlGroup6.Length == 0
            controlGroup1 = new int[50]
            controlGroup2 = new int[50]
            controlGroup3 = new int[50]
            controlGroup4 = new int[50]
            controlGroup5 = new int[50]
            controlGroup6 = new int[50]
        endif

        Pages = new string[6]

        Pages[0] = "Status Info"
        Pages[1] = "Debug Mod"
        Pages[2] = "Rules Settings"
        Pages[3] = "Event Settings"
        Pages[4] = "Bondage Outfits"
        Pages[5] = "Submissive Settings"

    else

        Pages = new string[1]

        Pages[0] = "Mod Offline"

    endif

endevent

event OnPageReset(string page)

    SetCursorFillMode(LEFT_TO_RIGHT)
    
    SetCursorPosition(0)

    ClearTempVariables()

    if page == "Mod Offline"
        AddTextOption("Binding Updated is disabled", "")
    endif

    If page == ""
        GoToState("DisplaySplashState")
    elseif page == "Status Info"
        GoToState("DisplayStatusState")
    elseif page == "Debug Mod"
        GoToState("DisplayDebugState")
    elseif page == "Rules Settings"
        GoToState("RulesSettingsState")
    elseif page == "Event Settings"
        GoToState("EventSettingsState")
    elseif page == "Bondage Outfits"
        GoToState("BondageOutfitsState")
    elseif page == "Submissive Settings"
        GoToState("SubmissiveSettingsState")
    endif

    DisplayPage()

endevent

function DisplayPage()
endfunction

event OnOptionSelect(int option)
endevent

event OnConfigClose()
endevent

event OnOptionSliderOpen(int option)
endevent

event OnOptionSliderAccept(int option, float value)
endevent

event OnOptionMenuOpen(int option)
endevent

event OnOptionMenuAccept(int option, int index)
endevent

event OnOptionInputOpen(int option)
endevent

event OnOptionInputAccept(int option, string value)
endevent

string function FormatRuleText(int rule, int ruleType)
endfunction

function ClearTempVariables()

    ;todo - figure out how to do this between different states - another variable?

    ; toggled1 = false
    
    ; selectedStr1 = ""
    ; selectedStr2 = ""
    ; selectedStr3 = ""
    ; selectedStr4 = ""

    ; selectedInt1 = 0
    ; selectedInt2 = 0
    ; selectedInt3 = 0
    ; selectedInt4 = 0

endfunction

;****************************************************************************
state DisplaySplashState

    function DisplayPage()
    endfunction

endstate

;****************************************************************************
state DisplayStatusState

    function DisplayPage()

        AddHeaderOption("Mod Data")
        AddHeaderOption("")

        AddTextOption("Save ID", StorageUtil.GetIntValue(none, "bindc_save_id", -1))
        AddTextOption("Paused", data_script.MainScript.ModPaused)
        AddTextOption("DHLP", data_script.MainScript.DhlpSuspend)
        AddTextOption("DHLP By Mod", data_script.MainScript.DhlpSuspendByMod)
        AddTextOption("Event Running", data_script.MainScript.EventIsRunning)
        AddTextOption("Event Name", data_script.MainScript.RunningEventName)

        AddHeaderOption("User Data")
        AddHeaderOption("")

        AddTextOption("Bondage Outfit", StorageUtil.GetIntValue(thePlayer, "bindc_outfit_id", -1))
        AddTextOption("Pose", StorageUtil.SetIntValue(thePlayer, "bindc_pose", 0))


    endfunction

endstate

;****************************************************************************
state DisplayDebugState

    function DisplayPage()
        controlGroup1[0] = AddToggleOption("Run Safeword", toggled1)
    endfunction

    event OnOptionSelect(int option)
        if option == controlGroup1[0]
            toggled1 = ToggleBool(toggled1)
            SetToggleOptionValue(option, toggled1)
        endif
    endevent

    event OnConfigClose()
        if toggled1
            data_script.MainScript.SafeWord()
            toggled1 = false
        endif
    endevent

endstate

;****************************************************************************
state EventSettingsState

    function DisplayPage()

        AddHeaderOption("Harsh Bondage")
        AddHeaderOption("")

        controlGroup1[0] = AddToggleOption("Enabled", StorageUtil.GetIntValue(none, "bindc_event_harsh_enabled", 1)) 
        controlGroup1[1] = AddTextOption("Last Run", bindc_Util.DisplayTimeElapsed(StorageUtil.GetFloatValue(none, "bindc_event_harsh_last", 0.0), bindc_Util.GetTime()))
        controlGroup1[2] = AddSliderOption("Start Chance Per Minute", StorageUtil.GetIntValue(none, "bindc_event_harsh_chance", 5), "{0}")
        controlGroup1[3] = AddSliderOption("Cooldown Hours", StorageUtil.GetIntValue(none, "bindc_event_harsh_cooldown", 6), "{0}")
        controlGroup1[4] = AddSliderOption("Runs Minimum Minutes", StorageUtil.GetIntValue(none, "bindc_event_harsh_min", 20), "{0}")
        controlGroup1[5] = AddSliderOption("Runs Maximum Minutes", StorageUtil.GetIntValue(none, "bindc_event_harsh_max", 30), "{0}")

    endfunction

    event OnOptionSliderOpen(int option)

        if option == controlGroup1[2]
            SetSliderDialogStartValue(StorageUtil.GetIntValue(none, "bindc_event_harsh_chance", 5))
            SetSliderDialogDefaultValue(5)
            SetSliderDialogRange(0, 100)
            SetSliderDialogInterval(1)
        elseif option == controlGroup1[3]
            SetSliderDialogStartValue(StorageUtil.GetIntValue(none, "bindc_event_harsh_cooldown", 6))
            SetSliderDialogDefaultValue(6)
            SetSliderDialogRange(0, 48)
            SetSliderDialogInterval(1) 
        endif

    endevent

    event OnOptionSliderAccept(int option, float value)

        if option == controlGroup1[2]
            StorageUtil.SetIntValue(none, "bindc_event_harsh_chance", value as int)
        elseif option == controlGroup1[3]
            StorageUtil.SetIntValue(none, "bindc_event_harsh_cooldown", value as int)
        endif

        SetSliderOptionValue(option, value, "{0}")

    endevent

    event OnOptionSelect(int option)

        if option == controlGroup1[0]
            int harshEnabled = ToggleInt(StorageUtil.GetIntValue(none, "bindc_event_harsh_enabled", 0))
            StorageUtil.SetIntValue(none, "bindc_event_harsh_enabled", harshEnabled)
            SetToggleOptionValue(option, harshEnabled)
        endif

    endevent

endstate

;****************************************************************************
string[] ruleMenuOptions
string[] ruleMenuOptionsOnly

state RulesSettingsState

    string function FormatRuleText(int rule, int ruleType) ;1 - behavior, 2 - bondage
        
        string ruleText = "disabled"
        int onOff = 0
        int option = 0
        
        if ruleType == 1
            onOff = data_script.RulesScript.GetBehaviorRule(thePlayer, rule)
            option = data_script.RulesScript.GetBehaviorRuleOption(thePlayer, rule)
        else
            onOff = data_script.RulesScript.GetBondageRule(thePlayer, rule)
            option = data_script.RulesScript.GetBondageRuleOption(thePlayer, rule)
        endif
        
        if onOff == 1
            ruleText = "on"
        endif

        ; if ruleText != ""
        ;     ruleText += " "
        ; endif

        if option == 0

        elseif option == data_script.RulesScript.RULE_OPTION_HARD_LIMIT
            ruleText += ":hard"
        elseif option == data_script.RulesScript.RULE_OPTION_SAFE_AREAS
            ruleText += ":sf"
        elseif option == data_script.RulesScript.RULE_OPTION_PERMANENT
            ruleText += ":perm"
        elseif option == data_script.RulesScript.RULE_OPTION_PERMANENT_SAFE_AREAS
            ruleText += ":psf"
        elseif option == data_script.RulesScript.RULE_OPTION_UNSAFE_AREAS
            ruleText += ":usf"
        elseif option == data_script.RulesScript.RULE_OPTION_PERMANENT_UNSAFE_AREAS
            ruleText += ":pusf"
        endif

        return ruleText

    endfunction

    function DisplayPage()

        if ruleMenuOptions.Length != 9 || ruleMenuOptionsOnly.Length != 7
            ruleMenuOptions = new string[9]
            ruleMenuOptions[0] = "OFF - Turn Rule Off"
            ruleMenuOptions[1] = "ON - Turn Rule On"
            ruleMenuOptions[2] = "Option - Default"
            ruleMenuOptions[3] = "Option - Hard Limit - Never Add This (HARD)"
            ruleMenuOptions[4] = "Option - Only In Safe Areas (SF)"
            ruleMenuOptions[5] = "Option - Make Rule Permanent (PERM)"
            ruleMenuOptions[6] = "Option - Make Rule Permanent In Safe Areas (PSF)"
            ruleMenuOptions[7] = "Option - Only In Unsafe Areas (USF)"
            ruleMenuOptions[8] = "Option - Make Rule Permanent In Unsafe Areas (PUSF)"

            ruleMenuOptionsOnly = new string[7]
            ruleMenuOptionsOnly[0] = "Option - Default"
            ruleMenuOptionsOnly[1] = "Option - Hard Limit - Never Add This (HARD)"
            ruleMenuOptionsOnly[2] = "Option - Only In Safe Areas (SF)"
            ruleMenuOptionsOnly[3] = "Option - Make Rule Permanent (PERM)"
            ruleMenuOptionsOnly[4] = "Option - Make Rule Permanent In Safe Areas (PSF)"
            ruleMenuOptionsOnly[5] = "Option - Only In Unsafe Areas (USF)"
            ruleMenuOptionsOnly[6] = "Option - Make Rule Permanent In Unsafe Areas (PUSF)"
        endif

        int domControlledBehavior = StorageUtil.GetIntValue(none, "bindc_dom_controls_behavior_rules", 0)
        int domControlledBondage = StorageUtil.GetIntValue(none, "bindc_dom_controls_bondage_rules", 0)
        string[] brules =  data_script.RulesScript.GetBehaviorRuleNameArray()
        string[] bndRules = data_script.RulesScript.GetBondageRuleNameArray()

        AddHeaderOption("Rules Settings")
        AddHeaderOption("")
        controlGroup1[0] = AddToggleOption("Dom Controls Behavior Rules", domControlledBehavior)
        controlGroup1[1] = AddToggleOption("Dom Controls Bondage Rules", domControlledBondage)

        AddHeaderOption("Behavior Rules")
        AddHeaderOption("")

        int i = 0
        while i < brules.Length
            controlGroup2[i] = AddMenuOption(brules[i], FormatRuleText(i, 1))
            i += 1
        endwhile

        if brules.length > 0
            if brules.Length % 2 > 0
                AddEmptyOption()
            endif
        endif

        AddHeaderOption("Bondage Rules")
        AddHeaderOption("")

        i = 0
        while i < bndRules.Length
            controlGroup3[i] = AddMenuOption(bndRules[i], FormatRuleText(i, 2))
            i += 1
        endwhile

    endfunction

    event OnOptionMenuOpen(int option)

        int i = 0
        int domControlled = StorageUtil.GetIntValue(none, "bindc_dom_controls_behavior_rules", 0)
        string[] rules =  data_script.RulesScript.GetBehaviorRuleNameArray()
        while i < rules.Length
            if option == controlGroup2[i]
                if domControlled == 1
                    SetMenuDialogOptions(ruleMenuOptionsOnly)
                else
                    SetMenuDialogOptions(ruleMenuOptions)
                endif
            endif
            i += 1
        endwhile

        i = 0
        domControlled = StorageUtil.GetIntValue(none, "bindc_dom_controls_bondage_rules", 0)
        rules =  data_script.RulesScript.GetBondageRuleNameArray()
        while i < rules.Length
            if option == controlGroup3[i]
                if domControlled == 1
                    SetMenuDialogOptions(ruleMenuOptionsOnly)
                else
                    SetMenuDialogOptions(ruleMenuOptions)
                endif
            endif
            i += 1
        endwhile

    endevent

    event OnOptionMenuAccept(int option, int index)

        int i = 0
        int domControlled = StorageUtil.GetIntValue(none, "bindc_dom_controls_behavior_rules", 0)
        string[] rules =  data_script.RulesScript.GetBehaviorRuleNameArray()
        while i < rules.Length
            if option == controlGroup2[i]
                if domControlled == 1
                    data_script.RulesScript.SetBehaviorRuleOption(thePlayer, i, index)
                else
                    if index == 0 || index == 1
                        data_script.RulesScript.SetBehaviorRule(thePlayer, i, index == 1)
                    endif
                    if index > 1 && index < 8
                        data_script.RulesScript.SetBehaviorRuleOption(thePlayer, i, index - 2)
                    endif
                endif
                SetMenuOptionValue(controlGroup2[i], FormatRuleText(i, 1))
            endif
            i += 1
        endwhile

        i = 0
        domControlled = StorageUtil.GetIntValue(none, "bindc_dom_controls_behavior_rules", 0)
        rules =  data_script.RulesScript.GetBondageRuleNameArray()
        while i < rules.Length
            if option == controlGroup3[i]
                if domControlled == 1
                    data_script.RulesScript.SetBondageRuleOption(thePlayer, i, index)
                else
                    if index == 0 || index == 1
                        data_script.RulesScript.SetBondageRule(thePlayer, i, index == 1)
                    endif
                    if index > 1 && index < 8
                        data_script.RulesScript.SetBondageRuleOption(thePlayer, i, index - 2)
                    endif
                endif
                SetMenuOptionValue(controlGroup3[i], FormatRuleText(i, 2))
            endif
            i += 1
        endwhile

    endevent

    event OnOptionSelect(int option)

        if option == controlGroup1[0]
            int domControlled = ToggleInt(StorageUtil.GetIntValue(none, "bindc_dom_controls_behavior_rules", 0))
            StorageUtil.SetIntValue(none, "bindc_dom_controls_behavior_rules", domControlled)
            SetToggleOptionValue(option, domControlled)
            ForcePageReset()
        elseif option == controlGroup1[1]
            int domControlled = ToggleInt(StorageUtil.GetIntValue(none, "bindc_dom_controls_bondage_rules", 0))
            StorageUtil.SetIntValue(none, "bindc_dom_controls_bondage_rules", domControlled)
            SetToggleOptionValue(option, domControlled)
            ForcePageReset()     
        endif

    endevent

endstate

;****************************************************************************
string[] bondageOutfitBlocks
int[] bondageOutfitBlocksSlots
string[] bondageOutfitUsageKey
string[] bondageOutfitUsageList
bool buildOutfitArrays

state BondageOutfitsState

    function DisplayPage()

        int i

        if !buildOutfitArrays
            bondageOutfitBlocks = new string[13]
            bondageOutfitBlocks[0] = "Body - Slot 32"
            bondageOutfitBlocks[1] = "Hands - Slot 33"
            bondageOutfitBlocks[2] = "Forearms - Slot 34"
            bondageOutfitBlocks[3] = "Feet  - Slot 37"
            bondageOutfitBlocks[4] = "Chest Primary - Slot 46"
            bondageOutfitBlocks[5] = "Chest Secondary - Slot 56"
            bondageOutfitBlocks[6] = "Pelvis Primary - Slot 49"
            bondageOutfitBlocks[7] = "Pelvis Secondary - Slot 54"
            bondageOutfitBlocks[8] = "Leg Primary - Slot 53"
            bondageOutfitBlocks[9] = "Leg Secondary - Slot 54"
            bondageOutfitBlocks[10] = "Shoulder - Slot 57"
            bondageOutfitBlocks[11] = "Arm Primary - Slot 59"
            bondageOutfitBlocks[12] = "Arm Secondary - Slot 58"

            bondageOutfitBlocksSlots = new int[13]
            bondageOutfitBlocksSlots[0] = 0x00000004  ;32
            bondageOutfitBlocksSlots[1] = 0x00000008  ;33
            bondageOutfitBlocksSlots[2] = 0x00000010  ;34
            bondageOutfitBlocksSlots[3] = 0x00000080  ;37
            bondageOutfitBlocksSlots[4] = 0x00010000 ;46
            bondageOutfitBlocksSlots[5] = 0x04000000 ;56
            bondageOutfitBlocksSlots[6] = 0x00080000 ;49
            bondageOutfitBlocksSlots[7] = 0x00400000 ;52
            bondageOutfitBlocksSlots[8] = 0x00800000 ;53
            bondageOutfitBlocksSlots[9] = 0x01000000 ;54
            bondageOutfitBlocksSlots[10] = 0x08000000 ;57
            bondageOutfitBlocksSlots[11] = 0x20000000 ;59
            bondageOutfitBlocksSlots[12] = 0x10000000 ;58

            string temp = "location_all_areas|location_any_city|location_dawnstar|location_falkreath|location_windhelm|location_markarth|location_morthal|location_riften|"
            temp += "location_solitude|location_high_hrothgar|location_whiterun|location_winterhold|location_raven Rock|location_towns|location_player_home|location_safe_area|"
            temp += "location_unsafe_area|location_inn|event_any_event|event_harsh_bondage|event_bound_masturbation|event_bound_sex|event_dairy|event_bound_sleep|event_camping|"
            temp += "event_put_on_display|event_public_humilation|event_whipping|event_souls_from_bones|event_word_wall|event_gagged_for_punishment|event_go_adventuring|event_free_for_work|"
            temp += "event_hogtied|event_simple_slavery"
            bondageOutfitUsageKey = StringUtil.Split(temp, "|")
            
            temp = "Location - All Areas|Location - Any City|Location - Dawnstar|Location - Falkreath|Location - Windhelm|Location - Markarth|Location - Morthal|Location - Riften"
            temp += "|Location - Solitude|Location - High Hrothgar|Location - Whiterun|Location - Winterhold|Location - Raven Rock |Location - Towns|Location - Player Home|Location - Safe Areas"
            temp += "|Location - Unsafe Areas|Location - Inn|Event - Any Event|Event - Harsh Bondage|Event - Bound Masturbation|Event - Bound Sex|Event - Dairy|Event - Bound Sleep|Event - Camping"
            temp += "|Event - Put On Display|Event - Public Humliation|Event - Whipping|Event - Souls From Bones|Event - Word Wall|Event - Gagged For Punishment|Event - Go Adventuring"
            temp += "|Event - Free For Work|Event - Hogtied|Event - Simple Slavery"
            bondageOutfitUsageList = StringUtil.Split(temp, "|")

            buildOutfitArrays = true
        endif

        AddHeaderOption("Manage Outfits")
        AddHeaderOption("")

        controlGroup1[0] = AddMenuOption("Select Bondage Outfit", "")
        ;AddEmptyOption()

        controlGroup1[10] = AddInputOption("Create Outfit", "")

        if selectedStr1 != ""

            int useRandomBondage = StorageUtil.GetIntValue(none, "bindc_outfit_" + selectedInt1 + "_use_random_bondage", 0)
            int useRulesBased = StorageUtil.GetIntValue(none, "bindc_outfit_" + selectedInt1 + "_rules_based", 0)
            int outfitEnabled = StorageUtil.GetIntValue(none, "bindc_outfit_" + selectedInt1 + "_outfit_enabled", 0)
            int removeGear = StorageUtil.GetIntValue(none, "bindc_outfit_" + selectedInt1 + "_remove_existing_gear", 0)
            int leaveBondageItems = StorageUtil.GetIntValue(none, "bindc_outfit_" + selectedInt1 + "_leave_bondage_items", 0)

            AddHeaderOption("Outfit Settings")
            AddHeaderOption("")

            controlGroup1[1] = AddInputOption("Name", selectedStr1)
            AddTextOption("Outfit ID", selectedInt1)
            controlGroup1[2] = AddToggleOption("Use Random Bondage", useRandomBondage)
            controlGroup1[3] = AddToggleOption("Use Bondage Rules", useRulesBased)
            controlGroup1[4] = AddToggleOption("Outfit Enabled", outfitEnabled)
            controlGroup1[9] = AddToggleOption("Strip All Clothing & Armor", removeGear)
            controlGroup1[12] = AddToggleOption("Leave Equipped Bondage Items", leaveBondageItems)
            AddEmptyOption()
              
            if useRandomBondage == 1 && useRulesBased == 0
                ;random bondage
                int[] chances = StorageUtil.IntListToArray(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance")

                AddHeaderOption("Random Bondage Chances")
                AddHeaderOption("")

                controlGroup2[0] = AddSliderOption("Anal Plug", chances[0], "{0}")
                controlGroup2[1] = AddSliderOption("Vaginal Plug", chances[1], "{0}")
                controlGroup2[2] = AddSliderOption("Genital Piercing", chances[2], "{0}")
                controlGroup2[3] = AddSliderOption("Nipple Piercing", chances[3], "{0}")
                controlGroup2[4] = AddSliderOption("Arm Bondage", chances[4], "{0}")
                controlGroup2[5] = AddSliderOption("Body Bondage", chances[5], "{0}")
                controlGroup2[6] = AddSliderOption("Leg Bondage", chances[6], "{0}")
                controlGroup2[7] = AddSliderOption("Boots", chances[7], "{0}")
                controlGroup2[8] = AddSliderOption("Gloves", chances[8], "{0}")
                controlGroup2[9] = AddSliderOption("Collar", chances[9], "{0}")
                controlGroup2[10] = AddSliderOption("Gag", chances[10], "{0}")
                controlGroup2[11] = AddSliderOption("Blindfold", chances[11], "{0}")
                controlGroup2[12] = AddSliderOption("Hood", chances[12], "{0}")
                AddEmptyOption()

            elseif useRandomBondage == 1 && useRulesBased == 1

                ;nothing here?

            else
                ;fixed bondage
                AddHeaderOption("Add Bondage Item(s)")
                AddHeaderOption("")

                controlGroup1[5] = AddInputOption("Search", selectedStr2)
                controlGroup1[6] = AddMenuOption("Search Results", selectedStr3) ;todo - display found count?
                ;controlGroup1[7] = AddMenuOption("From Inventory", "") ;AddTextOption("Add Item", selectedStr3)
                controlGroup1[8] = AddTextOption("Learn All Worn DD/ZAP Items", "")
                AddEmptyOption()

                AddHeaderOption("Bondage Items")
                AddHeaderOption("")
                formArr1 = StorageUtil.FormListToArray(none, "bindc_outfit_" + selectedInt1 + "_fixed_bondage_items")
                 i = 0
                while i < formArr1.Length && i < 50 ;cap this at the max of the control group array
                    controlGroup3[i] = AddTextOption(formArr1[i].GetName(), "")
                    i += 1
                endwhile
                if formArr1.length > 0
                    if formArr1.Length % 2 > 0
                        AddEmptyOption()
                    endif
                endif

            endif

            AddHeaderOption("Add Clothing & Armor")
            AddHeaderOption("")
            controlGroup1[11] = AddTextOption("Learn All Worn Items", "")
            AddEmptyOption()

            AddHeaderOption("Clothing & Armor Items")
            AddHeaderOption("")
            formArr3 = StorageUtil.FormListToArray(none, "bindc_outfit_" + selectedInt1 + "_fixed_worn_items")
              i = 0
            while i < formArr3.Length
                controlGroup6[i] = AddTextOption(formArr3[i].GetName(), "")
                i += 1
            endwhile
            if formArr3.length > 0
                if formArr3.Length % 2 > 0
                    AddEmptyOption()
                endif
            endif

            AddHeaderOption("Block Equipping - Clothing & Armor")
            AddHeaderOption("")
            i = 0
            while i < bondageOutfitBlocks.Length
                controlGroup4[i] = AddToggleOption(bondageOutfitBlocks[i], StorageUtil.IntListHas(none, "bindc_outfit_" + selectedInt1 + "_block_slots", bondageOutfitBlocksSlots[i]))
                 i += 1
            endwhile
            AddEmptyOption()

            AddHeaderOption("Outfit Used For")
            AddHeaderOption("")
            i = 0
            while i < bondageOutfitUsageList.Length
                controlGroup5[i] = AddToggleOption(bondageOutfitUsageList[i], StorageUtil.StringListHas(none, "bindc_outfit_" + selectedInt1 + "_used_for", bondageOutfitUsageKey[i]))
                 i += 1
            endwhile

        endif

    endfunction

    event OnOptionSelect(int option)

        int i = 0
        while i < formArr1.Length && i < 50 ;remove bondage items
            if option == controlGroup3[i]
                Form dev = StorageUtil.FormListGet(none, "bindc_outfit_" + selectedInt1 + "_fixed_bondage_items", i)
                if ShowMessage("Remove " + dev.GetName() + "?", true)
                    StorageUtil.FormListRemove(none, "bindc_outfit_" + selectedInt1 + "_fixed_bondage_items", dev, true)
                    ForcePageReset()
                endif
            endif
            i += 1
        endwhile

        i = 0
        while i < formArr3.Length && i < 50
            if option == controlGroup6[i]
                Form dev = StorageUtil.FormListGet(none, "bindc_outfit_" + selectedInt1 + "_fixed_worn_items", i)
                if ShowMessage("Remove " + dev.GetName() + "?", true)
                    StorageUtil.FormListRemove(none, "bindc_outfit_" + selectedInt1 + "_fixed_worn_items", dev, true)
                    ForcePageReset()
                endif
            endif
            i += 1
        endwhile

        i = 0
        while i < bondageOutfitUsageList.Length
            if option == controlGroup5[i]
                if StorageUtil.StringListHas(none, "bindc_outfit_" + selectedInt1 + "_used_for", bondageOutfitUsageKey[i])
                    StorageUtil.StringListRemove(none, "bindc_outfit_" + selectedInt1 + "_used_for", bondageOutfitUsageKey[i])
                    SetToggleOptionValue(option, 0)
                else
                    StorageUtil.StringListAdd(none, "bindc_outfit_" + selectedInt1 + "_used_for", bondageOutfitUsageKey[i])
                    SetToggleOptionValue(option, 1)
                endif
                

            endif
            i += 1
        endwhile

        i = 0
        while i < bondageOutfitBlocks.Length
            if option == controlGroup4[i]
                if StorageUtil.IntListHas(none, "bindc_outfit_" + selectedInt1 + "_block_slots", bondageOutfitBlocksSlots[i])
                    StorageUtil.IntListRemove(none, "bindc_outfit_" + selectedInt1 + "_block_slots", bondageOutfitBlocksSlots[i])
                    SetToggleOptionValue(option, 0)
                else
                    StorageUtil.IntListAdd(none, "bindc_outfit_" + selectedInt1 + "_block_slots", bondageOutfitBlocksSlots[i])
                    SetToggleOptionValue(option, 1)
                endif
                
            endif
            i += 1
        endwhile

        if option == controlGroup1[2] ;use random
            int useRandomBondage = StorageUtil.GetIntValue(none, "bindc_outfit_" + selectedInt1 + "_use_random_bondage", 0)
            if ShowMessage("Toggle Use Random Bondage", true)
                if useRandomBondage == 0
                    useRandomBondage = 1
                    if StorageUtil.IntListCount(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance") == 0
                        StorageUtil.IntListAdd(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance", 0) ;a plug 0
                        StorageUtil.IntListAdd(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance", 0) ;v plug 1
                        StorageUtil.IntListAdd(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance", 0) ;v pier 2
                        StorageUtil.IntListAdd(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance", 0) ;n pier 3
                        StorageUtil.IntListAdd(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance", 0) ;arms 4
                        StorageUtil.IntListAdd(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance", 0) ;body 5
                        StorageUtil.IntListAdd(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance", 0) ;legs 6
                        StorageUtil.IntListAdd(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance", 0) ;boots 7
                        StorageUtil.IntListAdd(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance", 0) ;gloves 8
                        StorageUtil.IntListAdd(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance", 0) ;collar 9
                        StorageUtil.IntListAdd(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance", 0) ;gag 10
                        StorageUtil.IntListAdd(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance", 0) ;blindfold 11
                        StorageUtil.IntListAdd(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance", 0) ;hood 12
                    endif
                else
                    useRandomBondage = 0
                endif
                StorageUtil.SetIntValue(none, "bindc_outfit_" + selectedInt1 + "_use_random_bondage", useRandomBondage)
                
                ForcePageReset()
            endif

        elseif option == controlGroup1[3] ;use rules
            if ShowMessage("Toggle Use Bondage Rules", true)
                int useRulesBased = StorageUtil.GetIntValue(none, "bindc_outfit_" + selectedInt1 + "_rules_based", 0)
                if useRulesBased == 0
                    useRulesBased = 1
                else
                    useRulesBased = 0
                endif
                StorageUtil.SetIntValue(none, "bindc_outfit_" + selectedInt1 + "_rules_based", useRulesBased)
                
                ForcePageReset()
            endif

        elseif option == controlGroup1[4] ;enabled
            int newValue = 0
            if StorageUtil.GetIntValue(none, "bindc_outfit_" + selectedInt1 + "_outfit_enabled", 0) == 1
                StorageUtil.SetIntValue(none, "bindc_outfit_" + selectedInt1 + "_outfit_enabled", 0)
                newValue = 0
            else
                StorageUtil.SetIntValue(none, "bindc_outfit_" + selectedInt1 + "_outfit_enabled", 1)
                newValue = 1
            endif    
            SetToggleOptionValue(option, newValue)

        elseif option == controlGroup1[9] ;strip clothing & armor
            if StorageUtil.GetIntValue(none, "bindc_outfit_" + selectedInt1 + "_remove_existing_gear", 0) == 0
                StorageUtil.SetIntValue(none, "bindc_outfit_" + selectedInt1 + "_remove_existing_gear", 1)
                SetToggleOptionValue(option, 1)
            else
                StorageUtil.SetIntValue(none, "bindc_outfit_" + selectedInt1 + "_remove_existing_gear", 0)
                SetToggleOptionValue(option, 0)
            endif
            

        elseif option == controlGroup1[8] ;learn all dd/zap items
            if ShowMessage("Learn worn DD/ZAP items? This will clear your existing items.", true)
                data_script.BondageScript.LearnWornDdItemsToSet(thePlayer, selectedInt1)
                ForcePageReset()
            endif

        elseif option == controlGroup1[11] ;learn all clothing & armor
            if ShowMessage("Learn worn armor and clothing?", true, "$Yes", "$No")
                StorageUtil.FormListClear(none, "bindc_outfit_" + "bindc_outfit_" + selectedInt1 + "_fixed_worn_items")
                Form[] items = bindc_SKSE.GetWornGear(thePlayer)
                i = 0
                while i < items.Length
                    Form f = items[i]
                    if f.IsPlayable() && thePlayer.IsEquipped(f)
                        if !data_script.BondageScript.ZadKeywordsCheck(f) && !f.HasKeyWordString("SexLabNoStrip") ;no dd devices
                            StorageUtil.FormListAdd(none, "bindc_outfit_" + selectedInt1 + "_fixed_worn_items", f, false)
                        endif
                    endif
                    i+=1
                endwhile

                ForcePageReset()
            endif
        elseif option == controlGroup1[12] ;leave bondage items
            if StorageUtil.GetIntValue(none, "bindc_outfit_" + selectedInt1 + "_leave_bondage_items", 0) == 0
                StorageUtil.SetIntValue(none, "bindc_outfit_" + selectedInt1 + "_leave_bondage_items", 1)
                SetToggleOptionValue(option, 1)
            else
                StorageUtil.SetIntValue(none, "bindc_outfit_" + selectedInt1 + "_leave_bondage_items", 0)
                SetToggleOptionValue(option, 0)
            endif
            

        endif

    endevent

    event OnOptionMenuOpen(int option)

        if option == controlGroup1[0]

            strArr1 = StorageUtil.StringListToArray(none, "bindc_outfit_name_list")
            intArr1 = StorageUtil.IntListToArray(none, "bindc_outfit_id_list")

            int i = 0
            while i < strArr1.Length
                if strArr1[i] == ""
                    strArr1[i] = "Missing name - " + strArr1[i]
                endif
                i += 1
            endwhile

            SetMenuDialogOptions(strArr1)
            SetMenuDialogStartIndex(strArr1.Find(selectedStr1))

        elseif option == controlGroup1[6]

            SetMenuDialogOptions(strArr2)
            ;SetMenuDialogStartIndex(-1) ;strArr2.Find(selectedStr3))

        endif

    endevent

    event OnOptionMenuAccept(int option, int index)

        if option == controlGroup1[0]

            selectedStr1 = strArr1[index]
            selectedInt1 = intArr1[index]

            ForcePageReset()

        elseif option == controlGroup1[6]

            if index >= 0
                if ShowMessage("Add " + strArr2[index] + "?", true)
                    Form dev = formArr2[index]
                    if dev
                        StorageUtil.FormListAdd(none, "bindc_outfit_" + selectedInt1 + "_fixed_bondage_items", dev, false)
                    endif
                    ForcePageReset()
                endif
            endif

        endif

    endevent       
    
    event OnOptionSliderOpen(Int option)
        
        int i = 0

        int[] chances = StorageUtil.IntListToArray(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance")
        while i < controlGroup2.Length
            if controlGroup2[i] == option
                SetSliderDialogStartValue(chances[i])
                SetSliderDialogDefaultValue(50)
                SetSliderDialogRange(0, 100)
                SetSliderDialogInterval(5)
            endif
            i += 1
        endwhile

    endevent

    event OnOptionSliderAccept(Int option, Float value)

        int i = 0

        int[] chances = StorageUtil.IntListToArray(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance")
        while i < controlGroup2.Length
            if controlGroup2[i] == option
                StorageUtil.IntListSet(none, "bindc_outfit_" + selectedInt1 + "_random_bondage_chance", i, value as int)
                SetSliderOptionValue(option, value, "{0}")
            endif
            i += 1
        endwhile

    endevent

    event OnOptionInputOpen(int option)

        if option == controlGroup1[5]
            ;dd/zap search
        endif

        if option == controlGroup1[1]
            ;name set
            SetInputDialogStartText(selectedStr1)
        endif

        if option == controlGroup1[10]
            ;create outfit
            SetInputDialogStartText("")
        endif

    endevent

    event OnOptionInputAccept(int option, string value)

        if option == controlGroup1[5]

            formArr2 = bind_SkseFunctions.SearchFormListsByKeyword(value, data_script.BondageScript.bindc_dd_all) ;, bmanage.bind_zap_all)

            selectedStr2 = value

            string buffer = ""
            int idx = 0
            while idx < formArr2.Length
                if buffer != "" 
                    buffer += "|"
                endif
                buffer += formArr2[idx].GetName()
                idx += 1
            endwhile

            strArr2 = StringUtil.Split(buffer, "|")

            selectedStr3 = "" + strArr2.Length

            bind_Utility.WriteToConsole("searchResults: " + strArr2.Length)

            SetInputOptionValue(option, selectedStr2)
            SetMenuOptionValue(controlGroup1[6], selectedStr3)    

        endif

        if option == controlGroup1[1]
            ;name set
            if selectedStr1 == value
                ;do nothing
            elseif StorageUtil.StringListFind(none, "bindc_outfit_name_list", value) > -1
                ShowMessage(value + " is already in use")
            else
                int idx = StorageUtil.StringListFind(none, "bindc_outfit_name_list", selectedStr1)
                if idx > -1
                    StorageUtil.SetStringValue(none, "bindc_outfit_" + selectedInt1 + "_bondage_outfit_name", value)
                    StorageUtil.StringListSet(none, "bindc_outfit_name_list", idx, value)
                    
                    selectedStr1 = value
                    SetInputOptionValue(option, value)
                endif
            endif
        endif

        if option == controlGroup1[10]
            ;create outfit

            if value != ""

                if StorageUtil.StringListFind(none, "bindc_outfit_name_list", value) > -1
                    ShowMessage(value + " is already in use")
                else
                    if ShowMessage("Create new outfit - " + value + "?", true, "$Yes", "$No")
                        int uid = Utility.RandomInt(100000000,999999999)
                        StorageUtil.StringListAdd(none, "bindc_outfit_name_list", value)
                        StorageUtil.IntListAdd(none, "bindc_outfit_id_list", uid)

                        StorageUtil.IntListCopy(none, "bindc_outfit_" + uid + "_random_bondage_chance", data_script.BondageScript.CreateChancesArray(true))
                        StorageUtil.SetStringValue(none, "bindc_outfit_" + uid + "_bondage_outfit_name", value)

                        ; bondageSetNames = StorageUtil.StringListToArray(main.BindingGameOutfitFile, "outfit_name_list")
                        ; bondageSetIds = StorageUtil.IntListToArray(main.BindingGameOutfitFile, "outfit_id_list")
                        ; SetMenuDialogOptions(bondageSetNames)
                        ; SetMenuDialogStartIndex(bondageSetNames.Find(value))

                        ShowMessage(value + " - bondage outfit created.", false)
                    endif
                endif

            endif

        endif

    endevent

endstate

;****************************************************************************
state SubmissiveSettingsState

    function DisplayPage()

        AddHeaderOption("Poses")
        AddHeaderOption("")

        controlGroup1[0] = AddInputOption("Kneel", StorageUtil.GetStringValue(none, "bindc_pose_kneel", "ZazAPC017"))
        controlGroup1[1] = AddInputOption("Prayer", StorageUtil.GetStringValue(none, "bindc_pose_prayer", "IdleGreybeardMeditateEnter"))
        controlGroup1[2] = AddInputOption("Sit On Ground", StorageUtil.GetStringValue(none, "bindc_pose_sit", "IdleSitCrossLeggedEnter"))
        controlGroup1[3] = AddInputOption("Spread Kneel", StorageUtil.GetStringValue(none, "bindc_pose_spread", "ZapWriPose07"))
        controlGroup1[4] = AddInputOption("Attention", StorageUtil.GetStringValue(none, "bindc_pose_attention", "IdleHandsBehindBack"))
        controlGroup1[5] = AddInputOption("Present Hands", StorageUtil.GetStringValue(none, "bindc_pose_present", "ft_surrender"))
        controlGroup1[6] = AddInputOption("Whip", StorageUtil.GetStringValue(none, "bindc_pose_whip", "ft_bdsm_idle_inspection"))
        controlGroup1[7] = AddInputOption("Ass Out", StorageUtil.GetStringValue(none, "bindc_pose_ass", "ZapWriPose03"))
        controlGroup1[8] = AddInputOption("Conversation", StorageUtil.GetStringValue(none, "bindc_pose_conversation", "IdleHandsBehindBack"))
        controlGroup1[9] = AddInputOption("Deep Kneel", StorageUtil.GetStringValue(none, "bindc_pose_deep", "ZazAPC020"))
        controlGroup1[10] = AddInputOption("Doorstep", StorageUtil.GetStringValue(none, "bindc_pose_door", "ZapWriPose08"))
        AddEmptyOption()

        AddHeaderOption("Kneeling")
        AddHeaderOption("")
        controlGroup1[11] = AddToggleOption("Kneeling Required To Speak", data_script.SubPref_KneelingRequired)
        controlGroup1[12] = AddToggleOption("Kneeling Required - Gagged For Not", StorageUtil.GetIntValue(none, "bindc_setting_kneeling_gagged_when_not", 0))
        controlGroup1[13] = AddToggleOption("Kneeling Required - Infraction For Not", StorageUtil.GetIntValue(none, "bindc_setting_kneeling_infraction_when_not", 0))
        AddEmptyOption()

        AddHeaderOption("Punishment")
        AddHeaderOption("")
        ; sliderPunishmentMinGold = AddSliderOption("Gold Loss - Min", bind_GlobalPunishmentMinGold.GetValue() as int, "{0}")
        ; sliderPunishmentMaxGold = AddSliderOption("Gold Loss - Max", bind_GlobalPunishmentMaxGold.GetValue() as int, "{0}")
        ; sliderPunishmentGoldPercentage = AddSliderOption("Gold Loss - Percentage", bind_GlobalPunishmentGoldPercentage.GetValue() as int, "{0}")

        AddHeaderOption("Other")
        AddHeaderOption("")
        controlGroup3[0] = AddToggleOption("Auto Outfit Changes", StorageUtil.GetIntValue(none, "bindc_auto_changes", 0))
        controlGroup3[1] = AddToggleOption("Present Hands Outfit Change", StorageUtil.GetIntValue(none, "bindc_present_hands", 0))
        ;toggleCleanSub = AddToggleOption("Dirt - Clean Sub Required", main.DomPreferenceCleanSub)


    endfunction

    event OnOptionSelect(int option)

        if option == controlGroup1[11] ;kneeling required
            data_script.SubPref_KneelingRequired = ToggleInt(data_script.SubPref_KneelingRequired) 
            SetToggleOptionValue(option, data_script.SubPref_KneelingRequired)

        elseif option == controlGroup1[12] ;gagged when not kneeling
            int gaggedForNot = ToggleInt(StorageUtil.GetIntValue(none, "bindc_setting_kneeling_gagged_when_not", 0))
            StorageUtil.SetIntValue(none, "bindc_setting_kneeling_gagged_when_not", gaggedForNot)
            SetToggleOptionValue(option, gaggedForNot)

        elseif option == controlGroup1[13] ;infraction when not kneeling
            int infractionForNot = ToggleInt(StorageUtil.GetIntValue(none, "bindc_setting_kneeling_infraction_when_not", 0))
            StorageUtil.SetIntValue(none, "bindc_setting_kneeling_infraction_when_not", infractionForNot)
            SetToggleOptionValue(option, infractionForNot)

        elseif option == controlGroup3[0]
            int autoChanges = ToggleInt(StorageUtil.GetIntValue(none, "bindc_auto_changes", 0))
            StorageUtil.SetIntValue(none, "bindc_auto_changes", autoChanges)
            SetToggleOptionValue(option, autoChanges)

        elseif option == controlGroup3[0]
            int presentHands = ToggleInt(StorageUtil.GetIntValue(none, "bindc_present_hands", 0))
            StorageUtil.SetIntValue(none, "bindc_present_hands", presentHands)
            SetToggleOptionValue(option, presentHands)

        endif

    endevent

    event OnOptionInputOpen(int option)

        if option == controlGroup1[0] || option == controlGroup1[1] || option == controlGroup1[2] || option == controlGroup1[3] || option == controlGroup1[4] || option == controlGroup1[5] || option == controlGroup1[6] || option == controlGroup1[7] || option == controlGroup1[8] || option == controlGroup1[9] || option == controlGroup1[10]
            SetInputDialogStartText("")
        endif

    endevent

    event OnOptionInputAccept(int option, string value)

        if option == controlGroup1[0]
            if value == ""
                value = "ZazAPC017"
            endif
            StorageUtil.SetStringValue(none, "bindc_pose_kneel", value)
            SetInputOptionValue(option, value)
        elseif option == controlGroup1[1]
            if value == ""
                value = "IdleGreybeardMeditateEnter"
            endif
            StorageUtil.SetStringValue(none, "bindc_pose_prayer", value)
            SetInputOptionValue(option, value)
        elseif option == controlGroup1[2]
            if value == ""
                value = "IdleSitCrossLeggedEnter"
            endif
            StorageUtil.SetStringValue(none, "bindc_pose_sit", value)
            SetInputOptionValue(option, value)
        elseif option == controlGroup1[3]
            if value == ""
                value = "ZapWriPose07"
            endif
            StorageUtil.SetStringValue(none, "bindc_pose_spread", value)
            SetInputOptionValue(option, value)
        elseif option == controlGroup1[4]
            if value == ""
                value = "IdleHandsBehindBack"
            endif
            StorageUtil.SetStringValue(none, "bindc_pose_attention", value)
            SetInputOptionValue(option, value)
        elseif option == controlGroup1[5]
            if value == ""
                value = "ft_surrender"
            endif
            StorageUtil.SetStringValue(none, "bindc_pose_present", value)
            SetInputOptionValue(option, value)
        elseif option == controlGroup1[6]
            if value == ""
                value = "ft_bdsm_idle_inspection"
            endif
            StorageUtil.SetStringValue(none, "bindc_pose_whip", value)
            SetInputOptionValue(option, value)
        elseif option == controlGroup1[7]
            if value == ""
                value = "ZapWriPose03"
            endif
            StorageUtil.SetStringValue(none, "bindc_pose_ass", value)
            SetInputOptionValue(option, value)
        elseif option == controlGroup1[8]
            if value == ""
                value = "IdleHandsBehindBack"
            endif
            StorageUtil.SetStringValue(none, "bindc_pose_conversation", value)
            SetInputOptionValue(option, value)
        elseif option == controlGroup1[9]
            if value == ""
                value = "ZazAPC020"
            endif
            StorageUtil.SetStringValue(none, "bindc_pose_deep", value)
            SetInputOptionValue(option, value)
        elseif option == controlGroup1[10]
            if value == ""
                value = "ZapWriPose08"
            endif
            StorageUtil.SetStringValue(none, "bindc_pose_door", value)
            SetInputOptionValue(option, value)
        endif

    endevent

endstate

bool function ToggleBool(bool currentValue)
    if currentValue
        return false
    else
        return true
    endif
endfunction

int function ToggleInt(int currentValue)
    if currentValue == 1
        return 0
    else
        return 1
    endif
endfunction

bindc_Data property data_script auto