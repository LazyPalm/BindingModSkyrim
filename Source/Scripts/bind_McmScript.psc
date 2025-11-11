Scriptname bind_McmScript extends SKI_ConfigBase  

string version

string selectedPage

int clickedBackupBondageOutfits
int clickedRestoreBondageOutfits
int clickedResetCurrentSaveBondageOutfits
int clickedUpdateTemplateFromCurrentSave

string[] letters
string selectedLetter
int menuChangeLetter

int inputDomTitle

;bondage
int toggleHarshUseBoots
int toggleHarshUseAnkles
int toggleHarshUseCollar
int toggleHarshUseNipple
int toggleHarshUseChastity
int toggleHarshUseHood
int toggleHarshUseBlindfold

int toggleBedtimeUseHood

;sex
int sliderDomArousal
int sliderChastityRemovalChance
int toggleFreeUse
int toggleSexUseFramework

;bound sex flags
int toggleBoundSexCuffs
int toggleBoundSexHeavyBondage
int toggleBoundSexGag
int toggleBoundSexBlindfold
int toggleBoundSexHood
int toggleBoundSexAPlug
int toggleBoundSexVPlug
int toggleDomWantsPrivacy

;bound masturbation
int toggleBoundMasturbationCuffs
int toggleBoundMasturbationGag
int toggleBoundMasturbationBlindfold
int toggleBoundMasturbationHood
int toggleBoundMasturbationAPlug
int toggleBoundMasturbationVPlug
int toggleBoundMasturbationUnties

int[] inputSLUseTags
string[] slUseTags
int[] inputSLBlockTags
string[] slBlockTags
int[] toggleUseSLTag
int[] toggleBlockSLTag

;poses
int menuHighKneelType
int menuDeepKneelType
int menuSpreadKneelType
int menuAttentionType
int menuPresentHandsType
int menuConversationPoseType
int menuShowAssType
int menuHighKneelTypeBound
int menuDeepKneelTypeBound
int menuSpreadKneelTypeBound
int menuAttentionTypeBound
int menuPresentHandsTypeBound
int menuShowAssTypeBound
int menuConversationPoseTypeBound

string[] idleTypes

;rules
string[] rulesList
int menuToggleRuleActive
int menuToggleRuleEnabled
int toggleRuleCleanPlayerHome
int menuRulesControlType
int togglePointsBySex
int togglePointsByHarsh
int togglePointsByFurniture
int togglePointsByBeingGood
int sliderPointsMax
string[] speechTypes
string[] prayerTypes

;punishment
int sliderPunishmentMinGold
int sliderPunishmentMaxGold
int sliderPunishmentGoldPercentage

;preferences
int toggleAdventuringUse
int sliderAdventuringPointCost
int toggleAdventuringGoodBehavior
int toggleAdventuringTimeOfDayCheck
int sliderAdventuringGoldGoal
int toggleAdventuringImporantKill
int toggleAdventuringUseDwarven

int toggleManualAdventureMode
int toggleAdventuringFreeHands
int toggleAdventuringAllowClothing
int toggleAdventuringSuspendRules
int toggleAdventuringAutomatic
int sliderAdventuringSeconds

int toggleRandomSubInFurniture
int sliderFurnitureHours
int sliderFurnitureChance
int sliderFurnitureMin
int sliderFurnitureMax
int sliderFurnitureForSleep
int toggleRandomHarshBondage
int sliderHarshBondageHours
int sliderHarshBondageChance
int sliderHarshBondageMin
int sliderHarshBonadgeMax
int toggleInspections
int sliderInspectionsChance
int sliderInspectionsHours
int sliderRulesChance
int sliderRulesHoursBetween
int sliderRulesMinBehavior
int sliderRulesMaxBehavior
int sliderRulesMinBondage
int sliderRulesMaxBondage
int toggleFreeDismissedDisabled
int toggleWhippingRandom
int sliderWhippingChance
int sliderWhippingHours
int toggleCampingRandom
int sliderCampingChance

int toggleRequireKneeling
int toggleInfractionForNotKneeling
int toggleGaggedForNotKneeling
int toggleKneelingOnlyRequiedInSafeAreas

int toggleCleanSub
int toggleUnplugGagsOnly
int toggleRemoveGagForDialogue
int toggleNoFreedom
int toggleEventWordWall
int toggleDragonSoulRitual
int toggleChastiseSub
int toggleStartupQuests
int toggleFakeSleep

int toggleGameplayAnyNpcCanDom

int toggleCleanUpNonBindingItemsFromBags

int toggleSimpleSlaveryFemale
int toggleSimpleSlaveryMale


;debug
int toggleRunSafeword
int toggleClearPunishments
int toggleAddPunishment
int toggleAddPoints
int changeRunSafeword
int changeClearPunishments
int changeAddPunishment
int changeAddRulePoints
int toggleWriteLogs
int keymapActionKey
int actionKeyModifierOption
int toggleFurnitureMenu
int menuFurnitureType
int toggleDisplayLocationChange

;dependencies
int toggleEnableDD
int toggleEnableZAP
int toggleEnableDM3
int toggleEnablePamaBeatup
int toggleEnableDirtAndBlood
int toggleEnableBathingInSkyrim
int toggleEnableMME
int toggleEnableChim
int toggleEnableSkyrimNet

;load/save
int toggleSaveMcm
int changeSaveMcm
int toggleLoadMcm
int changeLoadMcm
int menuMcmSaves
string selectedSave
string[] savesList

;controls
int togglePauseMod
int togglePauseModAction

string[] bondageTypes
int[] bondageTypesMenu

string[] furnitureTypes
;string selectedFurnitureType

string[] ruleManagementTypes
string selectedRuleManagementType
int toggleRulesMenuLockout
int toggleRulesMenuLockoutValue

int[] toggleBehaviorRules
int[] toggleBehaviorRuleOptions
int[] toggleBondageRules
int[] toggleBondageRuleOptions

int[] toggleBehaviorHard
int[] toggleBondageHard

int[] toggleProtection

int toggleNudityRequired
int toggleUseFastRuleCheck

int keyCodeLeftControl = 29
int keyCodeRightControl = 157
int keyCodeLeftAlt = 56
int keyCodeRightAlt = 184
int keyCodeLeftShift = 42
int keyCodeRightShift = 54

;skyrimnet
int menuSlaveryType
string[] slaveryTypes

int menuSlaveryInSkyrim
string[] slaveryInSkyrimTypes

int menuIndenturedServants
string[] indenturedServantsInSkyrimTypes

;outfits
int selectedOutfit
int outfitSafe
int outfitUnsafe
int outfitNude
int outfitErotic
int outfitBikini
int toggleOutfitsLearn

;bondage outfits
string[] materials

;string bondageOutfitFile

int toggleUseOutfit
int inputBondageSetName
int clickedNewOutfit
int menuBondageOutfitsList
string selectedBondageOutfit
int selectedBondageOutfitId
;int selectedBondageOutfitIndex
int toggleBondageOutfitUseRandomBondage
int toggleBondageOutfitRulesBased
string[] bondageOutfitUsageKey
string[] bondageOutfitUsageList
int[] bondageSetUsedForToggle
int clickedLearnBondageOutfit
int clickedLearnWornGear
string[] bondageOutfitBlocks
int[] bondageOutfitBlocksSlots
int[] bondageOutfitBlockToggle
int[] bondageSetRemoveDdToggle
int[] bondageSetRemoveGearToggle
int bondageSetRemoveExistingGearToggle
int inputDeviousKeywordSearch
string deviousKeywordSearch
string[] searchResults
Form[] searchResultsForms
int menuSearchResults
string selectedFoundItem
int selectedFoundItemId
int clickedFoundItem
int[] sliderChance
string[] bondageSetNames
string[] bondageSetFileNames
int[] bondageSetIds
int currentBondageOutfitIndex

;AI thinking
int toggleEnableActionDressingRoom
int toggleEnableActionBed
int toggleEnableActionWhip
int toggleEnableActionSex
int toggleEnableActionFurniture
int toggleEnableActionHarshBondage
int toggleEnableActionCamping
int toggleEnableActionInspection

Actor theSub

string slTagsFile = "bind_sl_tags.json"

Event OnConfigOpen()

    version = "0.4.29"

    theSub = fs.GetSubRef()

    Pages = new string[20]

    Pages[0] = "Status Info"
    Pages[1] = "Bondage Status"
    Pages[2] = "Bondage Outfits"
    Pages[3] = "Event Settings"
    Pages[4] = "Points"
    Pages[5] = "Poses"
    Pages[6] = "Gameplay Preferences"
    Pages[7] = "Punishment"
    Pages[8] = "Rules - Behavior"
    Pages[9] = "Rules Settings"
    Pages[10] = "Sex & Arousal"
    Pages[11] = "SexLab Tags"
    Pages[12] = "Stripping"
    Pages[13] = "Debug"
    Pages[14] = "Dependencies"
    Pages[15] = "Current Factions"
    Pages[16] = "Control Panel"
    Pages[17] = "SkyrimNet"
    Pages[18] = "Backup Settings"
    Pages[19] = "Rules - Bondage"

    MakeArrays()

    if toggleBehaviorHard.Length != 50 ;lets rebuild...
        toggleBehaviorHard = new int[50]
    endif
    if toggleBondageHard.Length != 50
        toggleBondageHard = new int[50]
    endif
    if toggleBehaviorRules.Length != 50
        toggleBehaviorRules = new int[50]
    endif
    if toggleBehaviorRuleOptions.Length != 50
        toggleBehaviorRuleOptions = new int[50]
    endif
    if toggleBondageRules.Length != 50
        toggleBondageRules = new int[50]
    endif
    if toggleBondageRuleOptions.Length != 50
        toggleBondageRuleOptions = new int[50]
    endif

    string[] useTags = StorageUtil.StringListToArray(theSub, "bind_use_sl_tags")
    string[] blockTags = StorageUtil.StringListToArray(theSub, "bind_block_sl_tags")

    int i = 0
    if inputSLUseTags.Length != 20
        inputSLUseTags = new int[20]
        slUseTags = new string[20]
        ;string[] useTags = StringUtil.Split(main.SexUseSLTags, ",")
        i = 0
        while i < useTags.Length
            slUseTags[i] = usetags[i]
            i += 1
        endwhile
    endif

    if inputSLBlockTags.Length != 10
        inputSLBlockTags = new int[10]
        slBlockTags = new string[20]
        ;string[] blockTags = StringUtil.Split(main.SexBlockSLTags, ",")
        i = 0
        while i < blockTags.Length
            slBlockTags[i] = blockTags[i]
            i += 1
        endwhile
    endif

    if letters.Length != 26
        letters = new string[26]
        letters[0] = "a"
        letters[1] = "b"
        letters[2] = "c"
        letters[3] = "d"
        letters[4] = "e"
        letters[5] = "f"
        letters[6] = "g"
        letters[7] = "h"
        letters[8] = "i"
        letters[9] = "j"
        letters[10] = "k"
        letters[11] = "l"
        letters[12] = "m"
        letters[13] = "n"
        letters[14] = "o"
        letters[15] = "p"
        letters[16] = "q"
        letters[17] = "r"
        letters[18] = "s"
        letters[19] = "t"
        letters[20] = "u"
        letters[21] = "v"
        letters[22] = "w"
        letters[23] = "x"
        letters[24] = "y"
        letters[25] = "z"
    endif
    selectedLetter = "a"

EndEvent

Event OnPageReset(string page)

    ; string msg = "does this work??"
	; bool continue = ShowMessage(msg, true, "$Yes", "$No")

    SetCursorFillMode(LEFT_TO_RIGHT)
    
    SetCursorPosition(0)
    
    ;If main.InStartup()
        ;DisplayStartupMessage()
    ;EndIf

    ;Else

    selectedPage = page

        DisplayMcmMessages()

        If (page == "")  

            DisplayStatus()

        ElseIf page == "Status Info"

            DisplayStatus()

        ElseIf page == "Poses"

            DisplayPoseSettings()

        ElseIf page == "Sex & Arousal"

            DisplaySexSettings()

        elseif page == "SexLab Tags"

            bind_Utility.WriteToConsole("sexlab version: " + SexLabUtil.GetVersion())

            if SexLabUtil.GetVersion() < 20000

                DisplaySlTagSettings()

            else

                AddTextOption("Disabled for P+", "")

            endif

        ElseIf page == "Bondage Status"

            DisplayBondageStatus()

        ; ElseIf page == "Bondage Settings"

        ;     DisplayBondageSettings()

        ElseIf page == "Points"

            DisplayPointsSettings()

        ElseIf page == "Punishment"

            DisplayPunishmentSettings()

        ElseIf page == "Rules - Behavior"

            DisplayBehaviorRules()

        elseif page == "Rules - Bondage"

            DisplayBondageRules()

        ElseIf page == "Rules Settings"
        
            DisplayRules()

        ElseIf page == "Gameplay Preferences"

            DisplayPreferences()

        ElseIf page == "Stripping"

            DisplayStrippingSettings()

        ElseIf page == "Debug"

            DisplayDebug()

        ; ElseIf page == "Diagnostics"

        ;     DisplayDiagnostics()

        ElseIf page == "Event Settings"

            DisplayEventSettings()

        ; ElseIf page == "Load / Save"

        ;     DisplayLoadSave()

        ; ElseIf page == "Mod Settings"

        ;     AddTextOption("test 1", "")

        ElseIf page == "Dependencies"

            DisplayDependencies()

        elseif page == "Current Factions"
            
            DisplayFactions(Game.GetPlayer())
            DisplayFactions(fs.GetDomRef())

        elseif page == "Control Panel"

            DisplayControlPanel()
    
        elseif page == "SkyrimNet"

            DisplaySkyrimNet()

        elseif page == "Outfits"

            DisplayOutfits()

        elseif page == "Bondage Outfits"

            DisplayBondageOutfits()
        
        elseif page == "Backup Settings"

            DisplayBackup()

        EndIf

    ;Endif

    
endEvent

event OnOptionHighlight(int option)

    ;preferences help
    if option == toggleAdventuringAutomatic
        SetInfoText("This will trigger automatic bondage outfit changes when changing locations.")
    elseif option == toggleAdventuringSuspendRules
        SetInfoText("This will store/restore all bondage/clothing automatically when leaving/entering cities and towns. This overrides other adventuring strip options.")
    elseif option == toggleGameplayAnyNpcCanDom
        SetInfoText("This is an experimental feature. When it enabled it will allow you to add any NPC as your dominant. They will stay at a fixed location and you will be required to report in regularly. You can will gain access to their residence.")
    elseif option == toggleCleanUpNonBindingItemsFromBags
        SetInfoText("Enabling this will destroy all unused/unequiped Devious Devices items from player inventory. If Disabled, mod will only remove Binding unequipped Devious Devices items (from failed or layered equips).")

    ;outfits management help
    elseif option == toggleBondageOutfitRulesBased
        SetInfoText("Enabling this option will cause the set to use the Bondage Rules system to determine which items should be equipped. It works with both random and fixed item sets. In a random set, all chance percentages are treated as 100%, so the rules alone decide what is equipped. Complete sets are preferable because if an item is missing from the set, the rule cannot be enforced.")

    ;events help
    elseif option == toggleEventWordWall
        SetInfoText("Require player to kneel near a Word Wall and perform a ritual with your dominant before learning the word of power.")

    ;rules help
    elseif option == menuRulesControlType
        SetInfoText("Set a rules control mode: Sub Managed - player changes rules (MCM & Dialogue), Hybrid - dom triggers changes, player picks rules, Dom Managed - dom triggers changes and picks rules.")
    elseif option == toggleNudityRequired
        SetInfoText("Always require nudity. This will override the Nudity rule in Behavior Rules. Use adventuring option in preferences menu to disable when leaving cities and towns.")
    elseif option == toggleRulesMenuLockout
        SetInfoText("Use this option to lock yourself out of the rules settings menu. It will last one in game week.")
    elseif option == sliderRulesChance
        SetInfoText("This will set the chance of the dom trying to add or remove rules each game hour. Used in Hybrid and Dom rules control modes.")
    elseif option == toggleUseFastRuleCheck
        SetInfoText("Enabling this will remove dialog and animations in the Check Rules quest. It will have less immersion, but it will run faster.")

    ;debug help
    elseif option == toggleRunSafeword
        SetInfoText("Check this option and leave MCM menu to activate. This option will remove the player from furniture, remove bondage, and terminate any active quests/events.")

    ;other mods integration help
    elseif option == toggleEnableMME
        SetInfoText("Enabling or Disabling will start the Dairy Quest. The dominant will make the PC a milk slave. While the quest is running the dominant will provide Lactacid and command PC to milk and take any produced bottles.")

    ; elseif option == toggleEnableChim
    ;     SetInfoText("This will enable the AI Follower Framework CHIM. You must copy the Binding plugin to HerikaServer\\ext folder in the CHIM server folder to recieve commands.")
    elseif option == toggleEnableSkyrimNet
        SetInfoText("This will enable the AI framework SkyrimNet.")

    elseif option == toggleAdventuringUse
        SetInfoText("Enable this to add an Adventuring Quest option during dialogue with the Dominant. This quest provides a formal way of earning gold or complete quests using a bondage outfit suited for dungeon crawling. It pairs well with any-location-bondage outfits when not adventuring. To replicate 0.3.x Binding, create Safe and Unsafe Area outfits and refrain from enabling this option.")

    elseif option == sliderAdventuringPointCost
        SetInfoText("This slider allows the player to set a point cost for starting the Adventuring Quest.")

    elseif option == toggleAdventuringGoodBehavior
        SetInfoText("Block starting the Adventuring Quest if the player is due punishments.")

    elseif option == toggleAdventuringTimeOfDayCheck
        SetInfoText("The dominant will block starting the Adventuring Quest from 8PM to 4AM.")

    elseif option == sliderAdventuringGoldGoal
        SetInfoText("This slider sets a gold goal for the Adventuring Quest. You must earn this much gold or earn a punishment.")

    elseif option == toggleAdventuringImporantKill
        SetInfoText("This slider sets a kills goal for the Adventuring Quest. Kill a Dragon, Dadera or 25 undead or earn a punishment. Will provide more options in future releases.")

    elseif option == toggleAdventuringUseDwarven
        SetInfoText("Lock the player into Dwarven Devious Armor for the duration of the quest.")

    elseif option == toggleBehaviorRules[0]
        SetInfoText("No slot 32 armor is allowed. Player must remain nude.")
    elseif option == toggleBehaviorRules[1]
        SetInfoText("Not allowed to sleep in beds. Must ask Dom to sleep - starts Bound Sleep quest.")
    elseif option == toggleBehaviorRules[2]
        SetInfoText("When entering castles, inns, and player homes, Dom might order the player to stand at attention.")
    elseif option == toggleBehaviorRules[3]
        SetInfoText("When using shrines, player must remove shoes.")
    elseif option == toggleBehaviorRules[4]
        SetInfoText("When using shrines, player must remove slot 32 body item.")
    elseif option == toggleBehaviorRules[5]
        SetInfoText("When using shrines, player must use the Prayer pose from the Action menu.")
    elseif option == toggleBehaviorRules[6]
        SetInfoText("Player must ask Dom before using a shrine.")
    elseif option == toggleBehaviorRules[7]
        SetInfoText("If Dirt & Blood or Bathing in Skyrim are enabled, player must be washed before using a shrine.")
    elseif option == toggleBehaviorRules[8]
        SetInfoText("Player must be whipped before using a shrine. Lasts 1 game day.")
    elseif option == toggleBehaviorRules[9]
        SetInfoText("Player must used the conversation pose to have the Dom start a conversation. No direct NPC conversation is allowed.")
    elseif option == toggleBehaviorRules[10]
        SetInfoText("Player must ask the dom before speaking to an NPC. Lasts until location changes.")
    elseif option == toggleBehaviorRules[11]
        SetInfoText("Player must use the Conversation pose from the Action menu before starting coversation with an NPC.")
    elseif option == toggleBehaviorRules[12]
        SetInfoText("Player must ask the Dom before entering or leaving a castle.")
    elseif option == toggleBehaviorRules[13]
        SetInfoText("Player must ask the Dom before entering or leaving a inn.")
    elseif option == toggleBehaviorRules[14]
        SetInfoText("Player must ask the Dom before entering or leaving a player home.")
    elseif option == toggleBehaviorRules[15]
        SetInfoText("Player must ask the Dom before consuming food or drink.")
    elseif option == toggleBehaviorRules[16]
        SetInfoText("Player must use the Sit on Ground pose before consuming food or drink.")
    elseif option == toggleBehaviorRules[17]
        SetInfoText("Player has 1 game hour to thank Dom after having sex.")
    elseif option == toggleBehaviorRules[18]
        SetInfoText("Player must ask the Dom before reading books to learn spells or skills.")
    elseif option == toggleBehaviorRules[19]
        SetInfoText("Player must ask the Dom before speaking to a trainer.")
    elseif option == toggleBehaviorRules[20]
        SetInfoText("Player must wear Binki armor (slaArmorHalfNakedBikniKeyword, slaArmorHalfNakedKeyword).")
    elseif option == toggleBehaviorRules[21]
        SetInfoText("Player must wear Binki armor (slaArmorPrettyKeyword, eroticArmorKeyword, slaAmorSpendexKeyword, slaArmorHalfNakedKeyword).")

    elseif option == toggleSimpleSlaveryFemale
        SetInfoText("Simple slavery outcome will can use a female hireling if no potential doms have been selected.")
    elseif option == toggleSimpleSlaveryMale
        SetInfoText("Simple slavery outcome will can use a male hireling if no potential doms have been selected.")
    endif

endevent

function DisplayBackup()

    AddHeaderOption("Bondage Outfit Backup")
    AddHeaderOption("")

    clickedBackupBondageOutfits = AddTextOption("Backup: bondage templates", "")

    clickedRestoreBondageOutfits = AddTextOption("Restore: bondage templates", "")

    clickedResetCurrentSaveBondageOutfits = AddTextOption("Reset: save game bondage outfits", "")

    clickedUpdateTemplateFromCurrentSave = AddTextOption("Update: templates from save", "")

endfunction

function DisplayBondageOutfits()

    ;inputBondageSetName = AddInputOption("Bondage Set Name", "")

    AddHeaderOption("Current Outfit")
    AddHeaderOption("")

    AddTextOption("Currently Wearing Outfit", StorageUtil.GetIntValue(theSub, "bind_wearing_outfit_id", -1))
    AddTextOption("", StorageUtil.GetStringValue(theSub, "bind_wearing_outfit_name", ""))

    AddHeaderOption("Manage Outfits")
    AddHeaderOption("")

    clickedNewOutfit = AddTextOption("Create New Outfit", "")

    menuBondageOutfitsList = AddMenuOption("Bondage Outfits", selectedBondageOutfit)

    if selectedBondageOutfit != ""

        AddHeaderOption("Selected - " + selectedBondageOutfit)
        AddHeaderOption("")

        toggleUseOutfit = AddToggleOption("Use This Set", JsonUtil.GetIntValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_outfit_enabled", 0))
        AddTextOption("", "")

        inputBondageSetName = AddInputOption("Bondage Outfit Name", selectedBondageOutfit)
        AddTextOption("Bondage Outfit ID", selectedBondageOutfitId) 
        
        ;delete set goes here

        int useRandomBondage = JsonUtil.GetIntValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_use_random_bondage", 0)
        int useRulesBased = JsonUtil.GetIntValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_rules_based", 0)

        toggleBondageOutfitUseRandomBondage = AddToggleOption("Use Random Bondage", useRandomBondage)
        toggleBondageOutfitRulesBased = AddToggleOption("Use Bondage Rules", useRulesBased)

        ;if useRandomBondage == 1

            int[] chances = JsonUtil.IntListToArray(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance")

            if chances.Length != 13
                chances = new int[13]
                i  = 0
                while i < 13
                    chances[i] = 0
                    JsonUtil.IntListSet(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", i, 0)
                    i += 1
                endwhile
                JsonUtil.Save(main.BindingGameOutfitFile)
            endif

            AddHeaderOption("Item Chances")
            AddHeaderOption("* Used when random bondage is ENABLED")

            sliderChance[0] = AddSliderOption("Anal Plug", chances[0], "{0}")
            sliderChance[1] = AddSliderOption("Vaginal Plug", chances[1], "{0}")
            sliderChance[2] = AddSliderOption("Genital Piercing", chances[2], "{0}")
            sliderChance[3] = AddSliderOption("Nipple Piercing", chances[3], "{0}")
            sliderChance[4] = AddSliderOption("Arm Bondage", chances[4], "{0}")
            sliderChance[5] = AddSliderOption("Body Bondage", chances[5], "{0}")
            sliderChance[6] = AddSliderOption("Leg Bondage", chances[6], "{0}")
            sliderChance[7] = AddSliderOption("Boots", chances[7], "{0}")
            sliderChance[8] = AddSliderOption("Gloves", chances[8], "{0}")
            sliderChance[9] = AddSliderOption("Collar", chances[9], "{0}")
            sliderChance[10] = AddSliderOption("Gag", chances[10], "{0}")
            sliderChance[11] = AddSliderOption("Blindfold", chances[11], "{0}")
            sliderChance[12] = AddSliderOption("Hood", chances[12], "{0}")
            AddTextOption("", "")

            AddHeaderOption("Current Dynamic Items - Devious Devices")
            
            float expirationDate = JsonUtil.GetFloatValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_dynamic_bondage_expires", 0.0)
            if expirationDate > 0.0
                AddHeaderOption("Time Remaining: " + (expirationDate - bind_Utility.GetTime()))
            else
                AddHeaderOption("")
            endif

            Form[] setItems = JsonUtil.FormListToArray(main.BindingGameOutfitFile, selectedBondageOutfitId + "_dynamic_bondage_items")
            i = 0
            while i < setItems.Length
                AddTextOption(setItems[i].GetName(), "")
                i += 1
            endwhile
            if setItems.length > 0
                if setItems.Length % 2 > 0
                    AddTextOption("", "")
                endif
            endif

        ;else

            AddHeaderOption("Add Item - Bondage Devices")
            AddHeaderOption("* Used when random bondage is DISABLED")
            inputDeviousKeywordSearch = AddInputOption("Keyword Search", deviousKeywordSearch)
            menuSearchResults = AddMenuOption("Items Found", selectedFoundItem)
            clickedFoundItem = AddTextOption("Add Found Item To Fixed Items", "")
            AddTextOption("", "")        

            AddHeaderOption("Fixed Items - Bondage Devices")
            AddHeaderOption("* Used when random bondage is DISABLED")
            clickedLearnBondageOutfit = AddTextOption("Learn Worn DD Items", "")
            AddTextOption("", "")
            setItems = JsonUtil.FormListToArray(main.BindingGameOutfitFile, selectedBondageOutfitId + "_fixed_bondage_items")
            i = 0
            while i < setItems.Length
                bondageSetRemoveDdToggle[i] = AddTextOption(setItems[i].GetName(), "")
                i += 1
            endwhile
            if setItems.length > 0
                if setItems.Length % 2 > 0
                    AddTextOption("", "")
                endif
            endif

        ;endif

        AddHeaderOption("Fixed Items - Clothing & Armor")
        AddHeaderOption("")
        clickedLearnWornGear = AddTextOption("Learn Worn Gear", "")
        bondageSetRemoveExistingGearToggle = AddToggleOption("Remove Existing Gear On Outfit Equip", JsonUtil.GetIntValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_remove_existing_gear", 0))
        Form[] wornItems = JsonUtil.FormListToArray(main.BindingGameOutfitFile, selectedBondageOutfitId + "_fixed_worn_items")
        i = 0
        while i < wornItems.Length
            bondageSetRemoveGearToggle[i] = AddTextOption(wornItems[i].GetName(), "")
            i += 1
        endwhile
        if wornItems.length > 0
            if wornItems.Length % 2 > 0
                AddTextOption("", "")
            endif
        endif

        AddHeaderOption("Block Equiping")
        AddHeaderOption("")
        i = 0
        while i < bondageOutfitBlocks.Length
            bondageOutfitBlockToggle[i] = AddToggleOption(bondageOutfitBlocks[i], JsonUtil.IntListHas(main.BindingGameOutfitFile, selectedBondageOutfitId + "_block_slots", bondageOutfitBlocksSlots[i]))
            i += 1
        endwhile
        AddTextOption("", "")

        AddHeaderOption("Set Used For")
        AddHeaderOption("")
        int i = 0
        while i < bondageSetUsedForToggle.Length
            bondageSetUsedForToggle[i] = AddToggleOption(bondageOutfitUsageList[i], JsonUtil.StringListHas(main.BindingGameOutfitFile, selectedBondageOutfitId + "_used_for", bondageOutfitUsageKey[i]))
            i += 1
        endwhile


    endif

endfunction

function DisplayOutfits()

    Form[] items ;= StorageUtil.FormListToArray(a, "binding_outfit_set_" + setName)

    string safeText = ""
    string unsafeText = ""
    string nudeText = ""
    string eroticText = ""
    string bikiniText = ""

    string selectedMessage = "Selected"
    if selectedOutfit == 1
        safeText = selectedMessage
        items = StorageUtil.FormListToArray(theSub, "binding_outfit_set_safe")
    elseif selectedOutfit == 2
        unsafeText = selectedMessage
        items = StorageUtil.FormListToArray(theSub, "binding_outfit_set_unsafe")
    elseif selectedOutfit == 3
        nudeText = selectedMessage
        items = StorageUtil.FormListToArray(theSub, "binding_outfit_set_nude")
    elseif selectedOutfit == 4
        eroticText = selectedMessage
        items = StorageUtil.FormListToArray(theSub, "binding_outfit_set_erotic")
    elseif selectedOutfit == 5
        bikiniText = selectedMessage
        items = StorageUtil.FormListToArray(theSub, "binding_outfit_set_bikini")
    endif

    AddHeaderOption("Outfits")
    AddHeaderOption("")

    outfitSafe = AddTextOption("Safe Areas Outfit", safeText)
    outfitUnsafe = AddTextOption("Unsafe Areas Outfit", unsafeText)
    outfitNude = AddTextOption("Nude Outfit", nudeText)
    outfitErotic = AddTextOption("Erotic Armor Outfit", eroticText)
    outfitBikini = AddTextOption("Bikini Armor Outfit", bikiniText)
    toggleOutfitsLearn = AddToggleOption("Outfits Learn Changes", gmanage.OutfitsLearn)

    if selectedOutfit > 0

        AddHeaderOption("Outfit Items")
        AddHeaderOption("")

        int i = 0
        while i < items.Length
            AddTextOption(items[i].GetName(), "")
            i += 1
        endwhile

    endif

endfunction

function DisplaySkyrimNet()

    if main.SoftCheckSkyrimNet == 1 && main.EnableModSkyrimNet == 1

        slaveryTypes = new string[6]
        slaveryTypes[0] = "Consensual BDSM"
        slaveryTypes[1] = "Non-consensual BDSM"
        slaveryTypes[2] = "Indentured Servant"
        slaveryTypes[3] = "Pleasure Slave"
        slaveryTypes[4] = "Fighting Slave"
        slaveryTypes[5] = "Custom"

        slaveryInSkyrimTypes = new string[5]
        slaveryInSkyrimTypes[0] = "Slavery Rare / Frowned Upon"
        slaveryInSkyrimTypes[1] = "Slavery Uncommon / Tolerated"
        slaveryInSkyrimTypes[2] = "Slavery Commmon / Legal"
        slaveryInSkyrimTypes[3] = "Slavery Government Sanctioned"
        slaveryInSkyrimTypes[4] = "Kinky Skyrim"
        slaveryInSkyrimTypes[5] = "Custom"

        indenturedServantsInSkyrimTypes = new string[3]
        indenturedServantsInSkyrimTypes[0] = "Indentured Rare / Frowned Upon"
        indenturedServantsInSkyrimTypes[1] = "Indentured Common / Legal"
        indenturedServantsInSkyrimTypes[2] = "Custom"

        AddHeaderOption("Prompt Options")
        AddHeaderOption("")

        AddTextOption("Slavery In Skyrim", "")
        AddTextOption("Indentured Servants In Skyrim", "")
        menuSlaveryInSkyrim = AddMenuOption("", slaveryInSkyrimTypes[main.bind_GlobalSettingsSlaveryInSkyrim.GetValue() as int])
        menuIndenturedServants = AddMenuOption("", indenturedServantsInSkyrimTypes[main.bind_GlobalSettingsIndenturedInSkyrim.GetValue() as int])
        menuSlaveryType = AddMenuOption("Slavery Type", slaveryTypes[main.SkryimNetSlaveryType])
        AddTextOption("", "")

        AddHeaderOption("Actions")
        AddHeaderOption("")

        toggleEnableActionDressingRoom = AddToggleOption("Dressing Room", brain.EnableActionDressingRoom)
        toggleEnableActionBed = AddToggleOption("Bound Bedtime", brain.EnableActionBed)
        toggleEnableActionWhip = AddToggleOption("Whipping", brain.EnableActionWhip)
        toggleEnableActionSex = AddToggleOption("Bound Sex", brain.EnableActionSex)
        toggleEnableActionFurniture = AddToggleOption("Put On Display - Furniture", brain.EnableActionFurniture)
        toggleEnableActionHarshBondage = AddToggleOption("Harsh Bondage", brain.EnableActionHarshBondage)
        toggleEnableActionCamping = AddToggleOption("Camping", brain.EnableActionCamping)
        toggleEnableActionInspection = AddToggleOption("Inspection", brain.EnableActionInspection)

    else

        if main.SoftCheckSkyrimNet == 0
            AddTextOption("SkyrimNet", "Not Found")
        else
            AddTextOption("SkyrimNet", "Not Enabled")
        endif

    endif

endfunction

function DisplayFactions(Actor a)

    string name = a.GetActorBase().GetName()

    AddHeaderOption("Factions - " + name)
    AddHeaderOption("")

    Faction[] factions = a.GetFactions(-128, 127)
    int i = 0
    while i < factions.Length
        AddTextOption(PO3_SKSEFunctions.GetFormEditorID(factions[i]), a.GetFactionRank(factions[i])) ;+ " - " + factions[i].GetName()
        i += 1
    endwhile

endfunction

function DisplayControlPanel()

    AddHeaderOption("Run Control & Status")
    AddHeaderOption("")

    string runState = "Unknown"
    if bind_GlobalModState.GetValue() == bind_Controller.GetModStateRunning()
        runState = "Running"
    elseif bind_GlobalModState.GetValue() == bind_Controller.GetModStatePaused()
        runState = "Paused"
    elseif bind_GlobalModState.GetValue() == bind_Controller.GetModStateDhlp()
        runState = "DHLP Suspended"
    elseif bind_GlobalModState.GetValue() == bind_Controller.GetModStateEvent()
        runState = "In Event - " + main.ActiveQuestName
    endif

    if bind_GlobalModState.GetValue() == bind_Controller.GetModStateRunning()
        togglePauseMod = AddToggleOption("Pause Binding (exit MCM to process)", togglePauseModAction)
    elseif bind_GlobalModState.GetValue() == bind_Controller.GetModStatePaused()
        togglePauseMod = AddToggleOption("Resume Binding (exit MCM to process)", togglePauseModAction)
    else
        AddTextOption("", "")
    endif

    AddTextOption("Binding Run State", runState)

    AddHeaderOption("Diagnostic Information")
    AddHeaderOption("")

    AddTextOption("Safe Area", fs.InSafeArea())
    AddTextOption("Bondage Set", main.ActiveBondageSetId)
    ;AddTextOption("Outfit", gmanage.CurrentOutfit)

    ; AddHeaderOption("Quests - Core")
    ; AddHeaderOption("")

    ; AddTextOption("Main Quest", (Quest.GetQuest("bind_MainQuest")).IsRunning())
    ; AddTextOption("Movement Quest", (Quest.GetQuest("bind_MovementQuest")).IsRunning())
    ; AddTextOption("Crowds Quest", (Quest.GetQuest("bind_CrowdsQuest")).IsRunning())
    ; AddTextOption("Go Adventuring Quest", (Quest.GetQuest("bind_GoAdventuringQuest")).IsRunning())
    ; AddTextOption("Kneeling Quest", (Quest.GetQuest("bind_KneelingQuest")).IsRunning())
    ; AddTextOption("Update Stats Quest", (Quest.GetQuest("bind_UpdateStatsQuest")).IsRunning())

    ; AddHeaderOption("Quests - Side")
    ; AddHeaderOption("")
    ; AddTextOption("Bound For Locations Quest", (Quest.GetQuest("bind_BoundForLocations")).IsRunning())
    ; AddTextOption("Bound Masturbation Quest", (Quest.GetQuest("bind_BoundMasturbationQuest")).IsRunning())
    ; AddTextOption("Bound Sex Quest", (Quest.GetQuest("bind_BoundSexQuest")).IsRunning())
    ; AddTextOption("Conversation Quest", (Quest.GetQuest("bind_CoversationQuest")).IsRunning())
    ; AddTextOption("Dom Adds Rules Quest", (Quest.GetQuest("bind_DomAddRulesQuest")).IsRunning())
    ; AddTextOption("Bound Sleep Quest", (Quest.GetQuest("bind_EventBoundSleepQuest")).IsRunning())
    ; AddTextOption("Camping Quest", (Quest.GetQuest("bind_EventCampingQuest")).IsRunning())
    ; AddTextOption("Gagged For Punishment Quest", (Quest.GetQuest("bind_EventGagForPunQuest")).IsRunning())
    ; AddTextOption("Harsh Bondage Quest", (Quest.GetQuest("bind_EventHarshBondageQuest")).IsRunning())
    ; AddTextOption("Inspection Quest", (Quest.GetQuest("bind_EventInspectionQuest")).IsRunning())
    ; AddTextOption("Put On Display Quest", (Quest.GetQuest("bind_EventPutOnDisplayQuest")).IsRunning())
    ; AddTextOption("Freed For Work Quest", (Quest.GetQuest("bind_FreedForWorkQuest")).IsRunning())
    ; AddTextOption("Free Use Quest", (Quest.GetQuest("bind_FreeUseQuest")).IsRunning())
    ; AddTextOption("Rules Check Quest", (Quest.GetQuest("bind_RulesCheckQuest")).IsRunning())
    ; AddTextOption("Sex Give Thanks Quest", (Quest.GetQuest("bind_SexGiveThanksQuest")).IsRunning())
    ; AddTextOption("Souls From Bones Quest", (Quest.GetQuest("bind_SoulsFromBonesQuest")).IsRunning())
    ; AddTextOption("The Dressing Room Quest", (Quest.GetQuest("bind_TheDressingRoomQuest")).IsRunning())
    ; AddTextOption("Ungagged For Needs Quest", (Quest.GetQuest("bind_UngaggedForNeedsQuest")).IsRunning())
    ; AddTextOption("Whipping Quest", (Quest.GetQuest("bind_WhippingQuest")).IsRunning())
    ; AddTextOption("Word Wall Quest", (Quest.GetQuest("bind_WordWallQuest")).IsRunning())

endfunction

Function DisplayMcmMessages()
    ; If main.GetMcmMessage() != ""
    ;     AddHeaderOption("Messages")
    ;     AddHeaderOption("")
    ;     string[] msgList
    ;     msgList = StringUtil.Split(main.GetMcmMessage(), "|")
    ;     int idx = 0
    ;     While idx < msgList.Length
    ;         AddTextOption("* - " + msgList[idx], "")
    ;         AddTextOption("", "")
    ;         idx = idx + 1
    ;     EndWhile
    ;     AddTextOption("","")
    ;     AddTextOption("","")
    ; EndIf
EndFunction

Function DisplayStrippingSettings()

    AddHeaderOption("Strip Preferences - Keep Items")
    AddHeaderOption("")

    string[] slotNames = gmanage.GetSlotMaskNames()
    int[] slotProtections = gmanage.GetSlotProtections()
    string[] friendlyNames = gmanage.GetSlotMaskFriendlyNames()

    if toggleProtection.Length != 27
        toggleProtection = new int[27]
    endif

    int i = 0
    while i < slotNames.Length
        toggleProtection[i] = AddToggleOption(friendlyNames[i], slotProtections[i])
        i += 1
    endwhile

EndFunction

Function DisplayPoseSettings()

    idleTypes = StringUtil.Split(pman.GetIdlesList(), ",")

    AddHeaderOption("Poses")
    AddHeaderOption("")

    menuHighKneelType = AddMenuOption("Kneel", pman.GetHighKneel())
    menuDeepKneelType = AddMenuOption("Deep Kneel - Sleep", pman.GetDeepKneel())
    menuSpreadKneelType = AddMenuOption("Spread Kneel - Sex", pman.GetSpreadKneel())
    menuAttentionType = AddMenuOption("Attention - Dismissed", pman.GetAttention())
    menuPresentHandsType = AddMenuOption("Present Hands", pman.GetPresentHands())
    menuShowAssType = AddMenuOption("Show Ass - Whip", pman.GetShowAss())
    menuConversationPoseType = AddMenuOption("Conversation Pose", pman.GetConversationPose())
    AddTextOption("", "")

    AddHeaderOption("Poses When Arms Bound")
    AddHeaderOption("")

    menuHighKneelTypeBound = AddMenuOption("Kneel", pman.GetHighKneel(true))
    menuDeepKneelTypeBound = AddMenuOption("Deep Kneel - Sleep", pman.GetDeepKneel(true))
    menuSpreadKneelTypeBound = AddMenuOption("Spread Kneel - Sex", pman.GetSpreadKneel(true))
    menuAttentionTypeBound = AddMenuOption("Attention - Dismissed", pman.GetAttention(true))
    menuPresentHandsTypeBound = AddMenuOption("Present Hands", pman.GetPresentHands(true))
    menuShowAssTypeBound = AddMenuOption("Show Ass - Whip", pman.GetShowAss(true))
    menuConversationPoseTypeBound = AddMenuOption("Conversation Pose", pman.GetConversationPose(true))
    AddTextOption("", "")

EndFunction

Function DisplayStartupMessage()

    AddHeaderOption("Binding Is Starting")
    AddHeaderOption("")
    AddTextOption("Mod detection is in progress..", "")
    AddTextOption("","")
    AddTextOption("","")
    AddTextOption("","")

EndFunction

Function DisplayDependencies()

    ; int sexLabFound = 0
    ; If Game.GetModByName("SexLab.esm") != 255
    ;     sexLabFound = 1
    ; EndIf

    ; int sexLabArousedFound = 0
    ; If Game.GetModByName("SexLabAroused.esm") != 255
    ;     sexLabArousedFound = 1
    ; EndIf

    ; AddHeaderOption("Sex Frameworks")
    ; AddHeaderOption("")
    ;AddTextOption("SexLab",  DisplayBoolean(sexLabFound))
    ;AddTextOption("", "")
    ;AddHeaderOption("Arousal Frameworks")
    ;AddHeaderOption("")
    ;AddTextOption("SexLab Aroused",  DisplayBoolean(sexLabArousedFound))
    ;AddTextOption("", "")
    ; AddHeaderOption("Bondage/Furniture Frameworks")
    ; AddHeaderOption("(at least 1 required)")
    ; AddTextOption("ZAP (" + main.SoftCheckZAPVersion + ")",  DisplayBoolean(main.SoftCheckZAP))
    ; ;AddTextOption("", "")
    ; ;toggleEnableZAP = AddToggleOption("Use ZAP", main.EnableModZAP)
    ; AddTextOption("Devious Devices", DisplayBoolean(main.SoftCheckDD))
    ; ;AddTextOption("", "")
    ; ;toggleEnableDD = AddToggleOption("Use DD", main.EnableModDD)

    AddHeaderOption("Required Mods")
    AddHeaderOption("")

    if Game.IsPluginInstalled("Devious Devices - Assets.esm")
        AddTextOption("Devious Devices", "Yes")
    else
        AddTextOption("Devious Devices", "No")
    endif

    int papUtilVersion = PapyrusUtil.GetVersion()
    if papUtilVersion > 0
        AddTextOption("Papyrus Utility", "Yes - " + papUtilVersion)
    else
        AddTextOption("Papyrus Utility", "No")
    endif

    if po3_Tweaks.IsTweakInstalled("Stack Dump Timeout Modifier")
        AddTextOption("powerofthree's Tweaks", "Yes")
    else
        AddTextOption("powerofthree's Tweaks", "No")
    endif

    int[] po3Version = PO3_SKSEFunctions.GetPapyrusExtenderVersion()
    if po3Version
        AddTextOption("powerofthree's Papyrus Extender", "Yes - " + po3Version[0] + "." + po3Version[1] + "." + po3Version[2])
    else
        
        AddTextOption("powerofthree's Papyrus Extender", "No")
    endif

    if Game.IsPluginInstalled("SexLab.esm")
        AddTextOption("SexLab", "Yes - " + SexLabUtil.GetStringVer())
    else
        AddTextOption("SexLab", "No")
    endif

    If Game.IsPluginInstalled("ZaZAnimationPack.esm")
        AddTextOption("ZAP", "Yes - " + zbfUtil.GetVersionStr())
    else
        AddTextOption("ZAP", "No")
    endif

    ;AddTextOption("", "")

    AddHeaderOption("Optional Mods")
    AddHeaderOption("")
    AddTextOption("Display Model 3 (DSE)", DisplayBoolean(main.SoftCheckDM3))
    toggleEnableDM3 = AddToggleOption("Enable", main.EnableModDM3)
    AddTextOption("Pama's Interactive Beatup Module", DisplayBoolean(main.SoftCheckPama))

    if main.SoftCheckPama == 1
        toggleEnablePamaBeatup = AddToggleOption("Enable", main.EnableModPama)
    else
        AddTextOption("", "")
    endif

    AddTextOption("Dirt & Blood", DisplayBoolean(main.SoftCheckDirtAndBlood))
    
    if main.SoftCheckDirtAndBlood == 1
        toggleEnableDirtAndBlood = AddToggleOption("Clean Slave - Use This", main.EnableModDirtAndBlood)
    else
        AddTextOption("", "")
    endif

    AddTextOption("Bathing In Skyrim", DisplayBoolean(main.SoftCheckBathingInSkyrim))
    
    if main.SoftCheckBathingInSkyrim == 1
        toggleEnableBathingInSkyrim = AddToggleOption("Clean Slave - Use This", main.EnableModBathingInSkyrim)
    else
        AddTextOption("", "")
    endif

    AddTextOption("Milk Mod Economy", DisplayBoolean(main.SoftCheckMME))
    if main.SoftCheckMME == 1
        toggleEnableMME = AddToggleOption("Enable", main.EnableModMME)
        ; if !theSub.IsInFaction(bind_MilkSlaveFaction) || theSub.GetFactionRank(bind_MilkSlaveFaction) == 2
        ;     toggleEnableMME = AddToggleOption("Enable", main.EnableModMME)
        ; else
        ;     AddTextOption("Enable", "Change In-process")
        ; endif
    else
        AddTextOption("", "")
    endif

    AddTextOption("Sweeping Organizes Stuff", DisplayBoolean(main.SoftCheckSweepingOrganizesStuff))
    AddTextOption("", "")
    AddTextOption("Devious Devices NG", DisplayBoolean(main.SoftCheckDDNG))
    AddTextOption("", "")

    ; AddTextOption("CHIM", DisplayBoolean(main.SoftCheckChim))
    ; if main.SoftCheckChim == 1
    ;     toggleEnableChim = AddToggleOption("Enable", main.EnableModChim)
    ; else
    ;     AddTextOption("", "")
    ;     main.EnableModChim = 0
    ; endif

    AddTextOption("SkyrimNet", DisplayBoolean(main.SoftCheckSkyrimNet))
    if main.SoftCheckSkyrimNet == 1
        toggleEnableSkyrimNet = AddToggleOption("Enable", main.EnableModSkyrimNet)
    else
        AddTextOption("", "")
        main.EnableModSkyrimNet = 0
    endif

    AddTextOption("Go To Bed", DisplayBoolean(main.SoftCheckGoToBed))
    AddTextOption("", "")

    AddTextOption("Gunslinger Poses", DisplayBoolean(main.SoftCheckGunslinger))
    AddTextOption("* Tested with GSPoses SE 20 03 from LL", "")

    ; AddHeaderOption("Utility Mods")
    ; AddHeaderOption("")

    ; A;ddTextOption("PapyrusUtil", JsonUtil.GetPathStringValue("binding_config.json", ".dep_test"))
    ; ;AddTextOption("Should return .dep_test from binding_config.json", "")

    ; AddTextOption("powerofthree's Tweaks", po3_Tweaks.IsTweakInstalled("Stack Dump Timeout Modifier"))
    ; ;AddTextOption("Should return true", "")

    ; float randomFloat = PO3_SKSEFunctions.GenerateRandomFloat(1.0, 100.0)
    ; AddTextOption("powerofthree's Papyrus Extender", randomFloat)
    ; AddTextOption("Should return float between 1.0 and 100.0", "")

    ; AddTextOption("PO3PE Test 2 - StringToInt", PO3_SKSEFunctions.StringToInt("0x060486E3"))
    ; AddTextOption("Should convert 0x060486E3 to 100959971", "")

EndFunction

Function DisplaySexSettings()

    AddHeaderOption("Sex Settings")
    AddHeaderOption("")

    toggleFreeUse = AddToggleOption("Free Use Sex", main.SexFreeUse)
    sliderDomArousal = AddSliderOption("Dom Arousal Needed For Sex", main.SexDomArousalLevelToTrigger, "{0}")
    sliderChastityRemovalChance = AddSliderOption("Chance For Chastity Removal", main.SexChanceOfChastityRemoval, "{0}")

    string sexFramework = "SexLab"
    if main.SexUseFramework == 1
        sexFramework = "Devious Devices - SL"
    endif
    toggleSexUseFramework = AddTextOption("Use Framework For Sex", sexFramework)

    toggleDomWantsPrivacy = AddToggleOption("Sex Requires Privacy", main.SexDomWantsPrivacy)
    AddTextOption("", "")

    ;unties for sex

    AddHeaderOption("Bound Sex Settings")
    AddHeaderOption("")
    AddTextOption("* Use outfits to manage DD items for event", "")
    AddTextOption("", "")

    ;bound sex flags
    ; toggleBoundSexCuffs = AddToggleOption("Add Cuffs", sms.BoundSexCuffs)
    ; toggleBoundSexHeavyBondage = AddToggleOption("Add Heavy Bondage", sms.BoundSexHeavyBondage)
    ; toggleBoundSexGag = AddToggleOption("Add Gag", sms.BoundSexGag)
    ; toggleBoundSexBlindfold = AddToggleOption("Add Blindfold", sms.BoundSexBlindfold)
    ; toggleBoundSexHood = AddToggleOption("Add Hood", sms.BoundSexHood)
    ; toggleBoundSexAPlug = AddToggleOption("Add Anal Plug", sms.BoundSexAPlug)
    ; toggleBoundSexVPlug = AddToggleOption("Add Vaginal Plug", sms.BoundSexVPlug)
    ; AddTextOption("", "")

    AddHeaderOption("Bound Masturbation Settings")
    AddHeaderOption("")
    AddTextOption("* Use outfits to manage DD items for event", "")
    AddTextOption("", "")

    ;bound masturbation
    ; toggleBoundMasturbationCuffs = AddToggleOption("Add Cuffs", sms.BoundMasturbationCuffs)
    ; toggleBoundMasturbationGag = AddToggleOption("Add Gag", sms.BoundMasturbationGag)
    ; toggleBoundMasturbationBlindfold = AddToggleOption("Add Blindfold", sms.BoundMasturbationBlindfold)
    ; toggleBoundMasturbationHood = AddToggleOption("Add Hood", sms.BoundMasturbationHood)
    ; toggleBoundMasturbationAPlug = AddToggleOption("Add Anal Plug", sms.BoundMasturbationAPlug)
    ; toggleBoundMasturbationVPlug = AddToggleOption("Add Vaginal Plug", sms.BoundMasturbationVPlug)
    ; toggleBoundMasturbationUnties = AddToggleOption("Remove Heavy Bondage", sms.BoundMasturbationUnties)
    ; AddTextOption("", "")

    ; AddHeaderOption("SL Animation Tags")
    ; AddHeaderOption("")

    int i = 0
    
    ; while i < inputSLUseTags.Length
    ;     inputSLUseTags[i] = AddInputOption("Use Tag " + i, slUseTags[i])
    ;     i += 1
    ; endwhile

    ;inputSLBlockTags = AddInputOption("Block Tags", main.SexBlockSLTags)

    ; StorageUtil.IntListClear(theSub, "bind_sl_tag_toggles")
    ; StorageUtil.StringListClear(theSub, "bind_sl_tags")

    ; AddHeaderOption("SL Animation Tags")
    ; AddHeaderOption("")

    ; string[] tags = bind_SexLabHelper.GetAllAnimationTags(2)
    ; bind_Utility.WriteToConsole("sexlab GetAllAnimationTags count: " + tags.Length)

    ; if tags.Length > 128

    ;     while i < inputSLUseTags.Length
    ;         inputSLUseTags[i] = AddInputOption("Use Tag " + i, slUseTags[i])
    ;         i += 1
    ;     endwhile

    ; else

    ;     menuChangeLetter = AddMenuOption("Select SL Group", selectedLetter)

    ;     i = 0
    ;     while i < tags.Length

    ;         if StringUtil.SubString(tags[i], 0, 1) == selectedLetter

    ;             string currentState = ""
    ;             if StorageUtil.StringListCountValue(theSub, "bind_use_sl_tags", tags[i]) > 0
    ;                 currentState = "Use"
    ;             elseif StorageUtil.StringListCountValue(theSub, "bind_block_sl_tags", tags[i]) > 0
    ;                 currentState = "Blocked"
    ;             endif

    ;             int toggleId = AddTextOption(tags[i], currentState)

    ;             StorageUtil.IntListAdd(theSub, "bind_sl_tag_toggles", toggleId)
    ;             StorageUtil.StringListAdd(theSub, "bind_sl_tags", tags[i])

    ;         endif

    ;         i += 1
    ;     endwhile

    ;     bind_Utility.WriteToConsole("bind_sl_tag_toggles")
    ;     bind_Utility.WriteToConsole("list count: " + StorageUtil.IntListCount(theSub, "bind_sl_tag_toggles"))

    ; endif


    ; if !JsonUtil.JsonExists(slTagsFile)
    ;     i = 0
    ;     while i < tags.Length
    ;         JsonUtil.SetPathStringValue(slTagsFile, "tags", tags[i])
    ;         i += 1
    ;     endwhile
    ;     JsonUtil.Save(slTagsFile)
    ; endif

    ;string useTagsKey = "bind_use_sl_tags"
    ;string blockTagsKey = "bind_block_sl_tags"

    ;string[] useTags = StorageUtil.StringListToArray(theSub, "bind_use_sl_tags")
    ;string[] blockTags = StorageUtil.StringListToArray(theSub, "bind_block_sl_tags")

    ; bool useSlTag
    ; bool blockSlTag
    
    ; i = 0
    ; while i < tags.Length || i > 128

    ;     useSlTag = false
    ;     blockSlTag = false

    ;     If StringUtil.Find(main.SexUseSLTags, tags[i]) > -1 
    ;         useSlTag = true
    ;     endif

    ;     If StringUtil.Find(main.SexBlockSLTags, tags[i]) > -1 
    ;         blockSlTag = true
    ;     endif

    ;     toggleUseSLTag[i] = AddToggleOption(tags[i], useSlTag)
    ;     toggleBlockSLTag[i] = AddToggleOption("Block - " + tags[i], blockSlTag)
        
    ;     i += 1

    ; endwhile

    string[] useTags = StorageUtil.StringListToArray(theSub, "bind_use_sl_tags")
    string[] blockTags = StorageUtil.StringListToArray(theSub, "bind_block_sl_tags")

    AddHeaderOption("SL Animation Tags - Used")
    AddHeaderOption("")
    i = 0
    while i < inputSLUseTags.Length
        inputSLUseTags[i] = AddInputOption("Use Tag " + i, slUseTags[i])
        i += 1
    endwhile
    ; while i < useTags.Length
    ;     AddTextOption(useTags[i], "")        
    ;     i += 1
    ; endwhile
    ; if useTags.Length % 2 > 0
    ;     AddTextOption("", "")
    ; endif

    AddHeaderOption("SL Animation Tags - Blocked")
    AddHeaderOption("")
    i = 0
    ; while i < blockTags.Length
    ;     AddTextOption(blockTags[i], "")        
    ;     i += 1
    ; endwhile    
    while i < inputSLBlockTags.Length
        inputSLBlockTags[i] = AddInputOption("Block Tag " + i, slBlockTags[i])
        i += 1
    endwhile

EndFunction

function DisplaySlTagSettings()

    int i

    StorageUtil.IntListClear(theSub, "bind_sl_tag_toggles")
    StorageUtil.StringListClear(theSub, "bind_sl_tags")

    AddHeaderOption("SL Animation Tags")
    AddHeaderOption("")

    bind_Utility.WriteToConsole("querying sexlab for tags.")

    string[] tags = bind_SexLabHelper.GetAllAnimationTags(2)
    bind_Utility.WriteToConsole("sexlab GetAllAnimationTags count: " + tags.Length)

    if tags.Length == 0

        AddTextOption("No tags found", "")

        ; i = 0
        ; while i < inputSLUseTags.Length
        ;     inputSLUseTags[i] = AddInputOption("Use Tag " + i, slUseTags[i])
        ;     i += 1
        ; endwhile

        ; i = 0
        ; while i < inputSLBlockTags.Length
        ;     inputSLBlockTags[i] = AddInputOption("Block Tag " + i, slBlockTags[i])
        ;     i += 1
        ; endwhile

        return

    endif

    if tags.Length > 128
        menuChangeLetter = AddMenuOption("Select SL Group", selectedLetter)
        AddTextOption("", "")
    endif

    ; if tags.Length > 10

    ;     i = 0
    ;     while i < inputSLUseTags.Length
    ;         inputSLUseTags[i] = AddInputOption("Use Tag " + i, slUseTags[i])
    ;         i += 1
    ;     endwhile

    ;     i = 0
    ;     while i < inputSLBlockTags.Length
    ;         inputSLBlockTags[i] = AddInputOption("Block Tag " + i, slBlockTags[i])
    ;         i += 1
    ;     endwhile

    ; else

        i = 0
        while i < tags.Length

            if StringUtil.SubString(tags[i], 0, 1) == selectedLetter || tags.Length <= 128

                string currentState = ""
                if StorageUtil.StringListCountValue(theSub, "bind_use_sl_tags", tags[i]) > 0
                    currentState = "Use"
                elseif StorageUtil.StringListCountValue(theSub, "bind_block_sl_tags", tags[i]) > 0
                    currentState = "Blocked"
                endif

                int toggleId = AddTextOption(tags[i], currentState)

                StorageUtil.IntListAdd(theSub, "bind_sl_tag_toggles", toggleId)
                StorageUtil.StringListAdd(theSub, "bind_sl_tags", tags[i])

            endif

            i += 1
        endwhile

    ; endif

    bind_Utility.WriteToConsole("bind_sl_tag_toggles")
    bind_Utility.WriteToConsole("list count: " + StorageUtil.IntListCount(theSub, "bind_sl_tag_toggles"))

endfunction

Function DisplayBondageStatus()

    int kSlotMaskWristsArms = 0x20000000 ; wrists/arms - 59
    int kSlotMaskElbows = 0x00010000 ; elbows - 46
    int kSlotMaskAnklesLegs = 0x00800000 ; ankles/legs - 53
    int kSlotMaskCollar = 0x00008000 ; collar - 45
    int kSlotMaskChastity = 0x00080000 ; belt - 49
    int kSlotMaskBody = 0x00000004  ; BODY - 32
    int kSlotMaskGag = 0x00004000  ; gag - 44
    int kSlotMaskBody2 = 0x10000000 ; Body 2 - 58
    int kSlotMaskNipple = 0x00200000 ; Nipple - 51
    int kSlotMaskAss = 0x00040000 ; Ass - 48
    int kSlotMaskVaginal = 0x08000000 ; vaginal - 57
    int kSlotMaskBalls = 0x00400000 ; balls - 52
    int kSlotMaskBoots = 0x00000080  ; Feet - 37
    int kSlotMaskBlindfold = 0x02000000 ; blindfold - 55
    int kSlotMaskHead = 0x00000001 ; head - 30 
    int kSlotMaskHair = 0x00000002 ; hair - 31
    int kSlotMaskCirclet = 0x00001000 ; circlet - 42

    AddHeaderOption("Current Bondage")
    AddHeaderOption("")

    string inFurniture
    inFurniture = "No"
    if theSub.IsInFaction(fmanage.GetLockedInFurnitureFaction())
        inFurniture = "Yes"
    endif
    ; If main.SubInFurniture == 1
    ;     inFurniture = "Yes - ZAP"
    ; ElseIf main.SubInFurniture == 2
    ;     inFurniture = "Yes - DDC"
    ; EndIf

    string handsText
    handsText = "No"
    If theSub.IsInFaction(bmanage.WearingHeavyBondageFaction()) ;bmanage.DetectedHandsInBondage == 1
        handsText = "Yes" ;"Yes - Other Mod / Player"
    ;ElseIf bmanage.DetectedHandsInBondage == 2
        ;handsText = "Yes" ;"Yes - Binding"
    EndIf

    string gagText
    gagText = "No"
    If theSub.IsInFaction(bmanage.WearingGagFaction()) ;bmanage.DetectedGagInMouth == 1
        gagText = "Yes" ; "Yes - Other Mod / Player"
    ;ElseIf bmanage.DetectedGagInMouth == 2
       ;gagText = "Yes" ;"Yes - Binding"
    EndIf

    AddTextOption("In Furniture", inFurniture)
    ; AddTextOption("Wrists Bound", DisplayBoolean(main.SubWristsBound))
    ; AddTextOption("Arms Bound", DisplayBoolean(main.SubArmsBound))
    ; AddTextOption("Elbows Bound", DisplayBoolean(main.SubElbowsBound))
    ; AddTextOption("Ankles Bound", DisplayBoolean(main.SubAnklesBound))
    ;AddTextOption("Stripped", DisplayBoolean(main.SubStripped))
    ; AddTextOption("Gagged", DisplayBoolean(main.SubGagged))
    AddTextOption("Hogtied / Floor Bound", "") ;DisplayBoolean(main.SubHogtied)) ;TODO - add a faction for hogtied
    AddTextOption("Hands Bound", handsText)
    ;AddTextOption("Collared", DisplayBoolean(main.SubCollared))
    ; AddTextOption("In Chastity", DisplayBoolean(main.SubInChastityDevice))
    AddTextOption("Gagged", gagText)

    AddHeaderOption("Detected Bondage")
    AddHeaderOption("")
    AddTextOption("Blindfold (slot 55)", TestBondageItem(kSlotMaskBlindfold))
    AddTextOption("Hood (slots 30 Head)", TestBondageItem(kSlotMaskHead))
    AddTextOption("Hood (slots 31 Hair)", TestBondageItem(kSlotMaskHair))
    AddTextOption("Hood (slots 42 Circlet)", TestBondageItem(kSlotMaskCirclet))
    AddTextOption("Wrists / Arms (slot 59)", TestBondageItem(kSlotMaskWristsArms))
    AddTextOption("Elbows (slot 46)", TestBondageItem(kSlotMaskElbows))
    AddTextOption("Ankles / Legs (slot 53)", TestBondageItem(kSlotMaskAnklesLegs))
    AddTextOption("Boots (slot 37)", TestBondageItem(kSlotMaskBoots))
    AddTextOption("Collar (slot 45)", TestBondageItem(kSlotMaskCollar))
    AddTextOption("Chastity / Belt (slot 49)", TestBondageItem(kSlotMaskChastity))
    AddTextOption("Body (slot 32)", TestBondageItem(kSlotMaskBody))
    AddTextOption("Body 2 (slot 58)", TestBondageItem(kSlotMaskBody2))
    AddTextOption("Gag (slot 44)", TestBondageItem(kSlotMaskGag))
    AddTextOption("Nipples (slot 51)", TestBondageItem(kSlotMaskNipple))
    AddTextOption("Ass (slot 48)", TestBondageItem(kSlotMaskAss))
    AddTextOption("Female Privacy (slot 57)", TestBondageItem(kSlotMaskVaginal))
    AddTextOption("Male Privacy (slot 52)", TestBondageItem(kSlotMaskBalls))
    AddTextOption("", "")

    ; AddHeaderOption("Stored Bondage")
    ; AddHeaderOption("")
    ; string[] items = bmanage.GetStoredItemsDisplayList(theSub)
    ; int i = 0
    ; while i < items.Length
    ;     AddTextOption("Slot " + i, items[i])
    ;     i += 1
    ; endwhile

EndFunction

string function TestBondageItem(int slotMask)

    Form f = theSub.GetWornForm(slotMask)

    if f == none
        return ""
    endif

    string txt = "Clothing/Armor"

    if f.HasKeywordString("zad_Lockable")
        txt = "Yes"
        ; txt = "Yes - "
        ; int bindingItem = bmanage.GetBindingBondageItem(f)
        ; if bindingItem == 1
        ;     txt += "Binding"
        ; elseif bindingItem == 2
        ;     txt += "Binding (event)"
        ; else
        ;     txt += "Other Mod"
        ; endif
    endif

    return txt

endfunction

function InitBondageTypesArray()
    if bondageTypes.Length != 18
        bondageTypes = new string[18]
        bondageTypes[0] = "Ankle Shackles"
        bondageTypes[1] = "Arm Cuffs"
        bondageTypes[2] = "Blindfold"
        bondageTypes[3] = "Boots"
        bondageTypes[4] = "Belt"
        bondageTypes[5] = "Collar"
        bondageTypes[6] = "Corset"
        bondageTypes[7] = "Gag"
        bondageTypes[8] = "Gloves"
        bondageTypes[9] = "Harness"
        bondageTypes[10] = "Binder"
        bondageTypes[11] = "Hood"
        bondageTypes[12] = "Leg Cuffs"
        bondageTypes[13] = "N Piercing"
        bondageTypes[14] = "V Piercing"
        bondageTypes[15] = "A Plug"
        bondageTypes[16] = "V Plug"
        bondageTypes[17] = "Suit"
    endif
endfunction

; Function DisplayBondageSettings()

;     AddTextOption("Bondage favorites menus have been moved", "")
;     AddTextOption("Action button -> Settings -> Manage Favorites", "")

;     ; if bondageTypesMenu.Length != 18
;     ;     bondageTypesMenu = new int[18]
;     ; endif

;     ; InitBondageTypesArray()

;     ; AddHeaderOption("Bondage Settings")
;     ; AddHeaderOption("")

;     ; int i = 0
;     ; while i < bondageTypes.Length
;     ;     bondageTypesMenu[i] = AddMenuOption(bondageTypes[i], bmanage.GetFavoriteItemName(theSub, i))
;     ;     i += 1
;     ; endwhile

; EndFunction

Function DisplayPunishmentSettings()

    AddHeaderOption("Punishment Status")
    AddHeaderOption("")

    AddTextOption("Punishments Due", bind_GlobalInfractions.GetValue() as int)
    AddTextOption("Times Punished", bind_GlobalTimesPunished.GetValue() as int)

    AddTextOption("Unnoticed Rule Breaking - Not Confessed", bind_GlobalTimesInfractionsNotNoticed.GetValue() as int)
    AddTextOption("Unnoticed Rule Breaking - Confessed", bind_GlobalTimesInfractionsConfessed.GetValue() as int)

    AddHeaderOption("Punishment Settings")
    AddHeaderOption("")

    sliderPunishmentMinGold = AddSliderOption("Gold Loss - Min", bind_GlobalPunishmentMinGold.GetValue() as int, "{0}")
    sliderPunishmentMaxGold = AddSliderOption("Gold Loss - Max", bind_GlobalPunishmentMaxGold.GetValue() as int, "{0}")
    sliderPunishmentGoldPercentage = AddSliderOption("Gold Loss - Percentage", bind_GlobalPunishmentGoldPercentage.GetValue() as int, "{0}")

    AddTextOption("", "")

    AddHeaderOption("Recent Infractions")
    AddHeaderOption("")

    int i = 0
    string[] list = StorageUtil.StringListToArray(theSub, "bind_infractions_list")
    float[] times = StorageUtil.FloatListToArray(theSub, "bind_infractions_time")
    while i < list.Length
        AddTextOption(times[i], "")
        AddTextOption(list[i], "")

        i += 1
    endwhile

EndFunction

Function DisplayEventSettings()

    ; toggleHarshUseBoots = AddToggleOption("Harsh Bondage - Use Boots", bmanage.HarshBondageUseBoots)
    ; toggleHarshUseAnkles = AddToggleOption("Harsh Bondage - Use Ankles", bmanage.HarshBondageUseAnkles)
    ; toggleHarshUseCollar = AddToggleOption("Harsh Bondage - Use Collar", bmanage.HarshBondageUseCollar)
    ; toggleHarshUseNipple = AddToggleOption("Harsh Bondage - Use Clamps", bmanage.HarshBondageUseNipple)
    ; toggleHarshUseChastity = AddToggleOption("Harsh Bondage - Use Chastity", bmanage.HarshBondageUseChastity)
    ; toggleHarshUseHood = AddToggleOption("Harsh Bondage - Use Hood", bmanage.HarshBondageUseHood)
    ; toggleHarshUseBlindfold = AddToggleOption("Harsh Bondage - Use Blindfold", bmanage.HarshBondageUseBlindfold)

    AddHeaderOption("Adventuring")
    AddHeaderOption("")
    toggleAdventuringUse = AddToggleOption("Adventuring - Use", main.AdventuringUse)
    sliderAdventuringPointCost = AddSliderOption("Adventuring - Point Cost", main.AdventuringPointCost, "{0}")
    toggleAdventuringGoodBehavior = AddToggleOption("Adventuring - No Infractions", main.AdventuringGoodBehavior)
    toggleAdventuringTimeOfDayCheck = AddToggleOption("Adventuring - Daytime Start Only", main.AdventuringTimeOfDayCheck)
    sliderAdventuringGoldGoal = AddSliderOption("Adventuring - Gold Goal", main.AdventuringGoldGoal, "{0}")
    toggleAdventuringImporantKill = AddToggleOption("Adventuring - Must Get Important Kill", main.AdventuringImporantKill)

    if main.SoftCheckDwarvenDeviousCuirass == 1
        toggleAdventuringUseDwarven = AddToggleOption("Adventuring - Use Dwarven Devious Cuirass", main.AdventuringUseDwarven)
        AddTextOption("", "")
    endif

    AddHeaderOption("Bound Bedtime (No Beds Rule Active)")
    AddHeaderOption("")
    sliderFurnitureForSleep = AddSliderOption("Furniture - Chance For Sleep Use", main.BedtimeFurnitureForSleep, "{0}")
    AddTextOption("", "")
    ;toggleBedtimeUseHood = AddToggleOption("Bound Bedtime - Use Hood", bmanage.BedtimeUseHood)

    AddHeaderOption("Camping")
    AddHeaderOption("")
    toggleCampingRandom = AddToggleOption("Camping - Random Use", main.CampingRandomUse)
    sliderCampingChance = AddSliderOption("Camping - Chance For Camping", main.CampingChance, "{0}")

    AddHeaderOption("Harsh Bondage")
    AddHeaderOption("")
    toggleRandomHarshBondage = AddToggleOption("Harsh Bondage - Random Use", main.HarshBondageRandomUse)
    AddTextOption("", "")
    sliderHarshBondageHours = AddSliderOption("Harsh Bondage - Hours Between Use", main.HarshBondageHoursBetweenUse, "{0}")
    sliderHarshBondageChance = AddSliderOption("Harsh Bondage - Chance To Use", main.HarshBondageChance, "{0}%")
    sliderHarshBondageMin = AddSliderOption("Harsh Bondage - Min. Minutes", main.HarshBondageMinMinutes, "{0}")
    sliderHarshBonadgeMax = AddSliderOption("Harsh Bondage - Max Minutes", main.HarshBondageMaxMinutes, "{0}")

    AddHeaderOption("Inspection")
    AddHeaderOption("")
    toggleInspections = AddToggleOption("Inspection - Random Inspections", main.InspectionsRandomUse)
    AddTextOption("", "")
    sliderInspectionsHours = AddSliderOption("Inspection - Hours Between", main.InspectionHoursBetween, "{0}")
    sliderInspectionsChance = AddSliderOption("Inspection - Chance Of Inspection", main.InspectionChance, "{0}%")

    AddHeaderOption("Put On Display (Special Furniture)")
    AddHeaderOption("")
    toggleRandomSubInFurniture = AddToggleOption("Furniture - Random Use", main.PutOnDisplayRandomUse)
    AddTextOption("", "")
    sliderFurnitureHours = AddSliderOption("Furniture - Hours Between Use", main.PutOnDisplayHoursBetweenUse, "{0}")
    sliderFurnitureChance = AddSliderOption("Furniture - Chance To Use", main.PutOnDisplayChance, "{0}%")
    sliderFurnitureMin = AddSliderOption("Furniture - Min. Minutes", main.PutOnDisplayMinMinutes, "{0}")
    sliderFurnitureMax = AddSliderOption("Furniture - Max Minutes", main.PutOnDisplayMaxMinutes, "{0}")
    
    AddHeaderOption("Whipping")
    AddHeaderOption("")
    toggleWhippingRandom = AddToggleOption("Whipping - Random Use", main.WhippingRandomUse)
    AddTextOption("", "")
    sliderWhippingHours = AddSliderOption("Whipping - Hours Between", main.WhippingHoursBetween, "{0}")
    sliderWhippingChance = AddSliderOption("Whipping - Chance Of Whipping", main.WhippingChance, "{0}%")

    AddHeaderOption("Other Events")
    AddHeaderOption("")
    toggleEventWordWall = AddToggleOption("Event - Word Wall", main.DomUseWordWallEvent)
    toggleDragonSoulRitual = AddToggleOption("Event - Souls From Bones", main.DomUseDragonSoulRitual)
    ; toggleChastiseSub = AddToggleOption("Event - Chastise Sub For Rule Breaking", main.DomChastiseForRuleBreaking)
    ; AddTextOption("", "")

EndFunction

Function DisplayPreferences()

    AddHeaderOption("Bondage Outfit Changes")
    AddHeaderOption("")

    ;toggleManualAdventureMode = AddToggleOption("Switch to Manual (Action Menu)", main.AdventuringManual)
    ;toggleAdventuringFreeHands = AddToggleOption("Free Hands from Bondage", main.AdventuringFreeHands)
    ;toggleAdventuringAllowClothing = AddToggleOption("Allow Clothing", main.AdventuringAllowClothing)
    ;toggleAdventuringAutomatic = AddToggleOption("Auto When Entering/Leaving", main.AdventuringAutomatic)
    sliderAdventuringSeconds = AddSliderOption("Run Check After Seconds", main.AdventuringCheckAfterSeconds, "{0}")
    ;toggleAdventuringSuspendRules = AddToggleOption("Suspend Rules & Auto *", main.AdventuringSuspendRules)
    
    AddTextOption("", "")


    AddHeaderOption("Dominant Preferences")
    AddHeaderOption("")

    toggleCleanSub = AddToggleOption("Dirt - Clean Sub Required", main.DomPreferenceCleanSub)
    toggleUnplugGagsOnly = AddToggleOption("Gags - Unplug Panel Gags Only", main.DomOnlyUnplugsPanelGags)
    toggleRemoveGagForDialogue = AddToggleOption("Gags - Remove For Dialogue", main.DomRemovesGagForDialogue)

    AddTextOption("", "")

    ;get data from config file
    ;TODO - move this back to main or rules
    int kneelingRequired = StorageUtil.GetIntValue(theSub, "kneeling_required", 1)
    int gaggedForNotKneeling = StorageUtil.GetIntValue(theSub, "gagged_for_not_kneeling", 1)
    int ruleInfractionForNotKneeling = StorageUtil.GetIntValue(theSub, "rule_infraction_for_not_kneeling", 1)
    int kneelingOnlyRequiedInSafeAreas = StorageUtil.GetIntValue(theSub, "kneeling_safe_areas_only", 1)

    AddHeaderOption("Kneeling Preferences")
    AddHeaderOption("")
    toggleRequireKneeling = AddToggleOption("Kneeling Required To Speak", kneelingRequired)
    toggleGaggedForNotKneeling = AddToggleOption("Kneeling Required - Gagged For Not", gaggedForNotKneeling)
    toggleInfractionForNotKneeling = AddToggleOption("Kneeling Required - Infraction For Not", ruleInfractionForNotKneeling)
    ;toggleKneelingOnlyRequiedInSafeAreas = AddToggleOption("Kneeling Required - Only In Safe Area", ruleInfractionForNotKneeling)
    AddTextOption("", "")


    AddHeaderOption("Other Preferences")
    AddHeaderOption("")

    toggleFreeDismissedDisabled = AddToggleOption("Do Not Free Sub When Follower Dismissed", main.PreferenceFreeWhenDismissedDisabled)
    toggleNoFreedom = AddToggleOption("Hide Free Me Dialog Option", main.DomWillNotOfferFreedom)
    toggleStartupQuests = AddToggleOption("Enable Pre-enslavement Events", main.DomStartupQuestsEnabled)
    toggleGameplayAnyNpcCanDom = AddToggleOption("Any NPC can be your Dominant", main.GameplayAnyNpcCanDom)
    toggleSimpleSlaveryFemale = AddToggleOption("Simple Slavery - Female Hireling Fallbacks", main.SimpleSlaveryFemaleFallback)
    toggleSimpleSlaveryMale = AddToggleOption("Simple Slavery - Male Hireling Fallbacks", main.SimpleSlaveryMaleFallback)
    toggleCleanUpNonBindingItemsFromBags = AddToggleOption("Clean Unused Bondage Items From Inventory", main.CleanUpNonBindingItemsFromBags)
    

    ;toggleFakeSleep = AddToggleOption("Use Fake Sleep In Furniture", main.GamePreferenceUseFakeSleep)
    ;AddTextOption("", "")


EndFunction

Function DisplayStatus()

    AddHeaderOption("Save Information")
    AddHeaderOption("")
    AddTextOption("Save UID", main.SaveGameUid)
    AddTextOption("", "")

    AddHeaderOption("Submissive Status")
    AddHeaderOption("")

    AddTextOption("Have Dominant", DisplayBoolean(main.IsSub))
    AddTextOption("Dominant Name", main.DominantName)

    inputDomTitle = AddInputOption("Dominant Title", fs.GetDomTitle())

    If main.DominantSex == 1
        AddTextOption("Dominant Sex", "Female")
    Else
        AddTextOption("Dominant Sex", "Male")
    EndIf
    AddTextOption("Stripped", gmanage.IsNude(theSub))
    If main.DomPreferenceCleanSub == 0
        AddTextOption("How Dirty", "Clean Slave - OFF")
    Else
        AddTextOption("How Dirty (spotless clean 0, very dirty 100)", main.SubDirtLevel)
    EndIf
    AddTextOption("Dialogue Posed", pman.InConversationPose())
    AddTextOption("Dialogue Permission", StorageUtil.GetIntValue(theSub, "bind_has_speech_permission", 0))

EndFunction

Function DisplayPointsSettings()

    AddHeaderOption("Points Status")
    AddHeaderOption("")

    AddTextOption("Current Points", bind_GlobalPoints.GetValue() as int)
    sliderPointsMax = AddSliderOption("Max Points", main.PointsMax, "{0}")
    togglePointsBySex = AddToggleOption("Points From Sex", main.PointsEarnFromSex)
    togglePointsByHarsh = AddToggleOption("Points From Harsh Bondage", main.PointsEarnFromHarshBondage)
    togglePointsByFurniture = AddToggleOption("Points From Furniture", main.PointsEarnFromFurniture)
    togglePointsByBeingGood = AddToggleOption("Points From Being Good", main.PointsEarnFromBeingGood)
    

EndFunction

string[] behaviorList
int[] behaviorHard
int[] behaviorSettings

Function DisplayBehaviorRules()

    ; if toggleBehaviorRules.Length != 50
    ;     toggleBehaviorRules = new int[50]
    ;     toggleBondageRules = new int[50]
    ; endif

    ; AddTextOption("Behavior Rules menus have been moved", "")
    ; AddTextOption("Action button -> Settings -> Manage Rules", "")

    ; return

    AddHeaderOption("Behavior Rules")
    AddHeaderOption("")

    behaviorList = rman.GetBehaviorRuleNameArray() ;rman.GetBehaviorRulesList()
    ;behaviorSettings = rman.GetBehaviorRulesSettingsList()
    ;behaviorHard = rman.GetBehaviorHardLimitsList()

    int i = 0
    while i < behaviorList.Length

        int ruleSetting = rman.GetBehaviorRule(theSub, i)
        int ruleOption = rman.GetBehaviorRuleOption(theSub, i)
        float ruleEndTime = 0.0

        if ruleSetting == 1
            ruleEndTime = rman.GetBehaviorRuleEnd(theSub, i)
        endif

        ; string ruleText = "Off"
        ; if ruleSetting == 1
        ;     ruleText = "On"
        ; endif
        ; if ruleOption == 1
        ;     ruleText += " - Blocked / Hard Limit"
        ; elseif ruleOption == 2
        ;     ruleText += " - Safe Areas"
        ; elseif ruleOption == 3
        ;     ruleText += " - Permanent"
        ; elseif ruleOption == 4
        ;     ruleText += " - Permanent Safe Areas"
        ; endif

        if bind_GlobalRulesControlledBy.GetValue() > 0

            string ruleName = behaviorList[i]
            if ruleEndTime > 0.0
                float hoursLeft = (ruleEndTime - bind_Utility.GetTime()) * 24.0
                ruleName += " (" + Math.Ceiling(hoursLeft) + "h)"
            elseif ruleEndTime <= 0.0 && ruleSetting == 1
                ruleName += " (expired)"
            endif 

            string displayText = ""
            if ruleSetting == 1
                displayText = "On"
            endif

            AddTextOption(ruleName, displayText)

            ; string displayText = behaviorList[i]
            ; if ruleEndTime > 0.0
            ;     float hoursLeft = (ruleEndTime - bind_Utility.GetTime()) * 24.0
            ;     displayText += " (" + Math.Ceiling(hoursLeft) + "h)"
            ; endif

        else

            string displayText = ""
            if ruleSetting == 1
                displayText = "On"
            endif

            toggleBehaviorRules[i] = AddTextOption(behaviorList[i], displayText)

        endif

        string optionText = ""
        if ruleOption == 1
            optionText = "Blocked / Hard Limit"
        elseif ruleOption == 2
            optionText = "Safe Areas"
        elseif ruleOption == 3
            optionText = "Permanent"
        elseif ruleOption == 4
            optionText = "Permanent Safe Areas"
        elseif ruleOption == 5
            optionText = "Unsafe Areas"
        elseif ruleOption == 6
            optionText = "Permanent Unsafe Areas"
        endif

        toggleBehaviorRuleOptions[i] = AddTextOption("Options", optionText)

        ; If bind_GlobalRulesControlledBy.GetValue() > 0
        ;     string displayText = ""
        ;     if behaviorSettings[i] == 1
        ;         displayText = "ACTIVE / ON"
        ;     endif
        ;     if behaviorHard[i] == 1 && bind_GlobalRulesControlledBy.GetValue() == 1
        ;         displayText = "Disabled - Hard Limit"
        ;     endif
        ;     AddTextOption(behaviorList[i], displayText)
        ; else
        ;     toggleBehaviorRules[i] = AddToggleOption(behaviorList[i], behaviorSettings[i])
        ; endif
        i += 1
    endwhile

    ; If ((behaviorList.Length as int) % 2) != 0.0
    ;     AddTextOption("", "")
    ; EndIf

EndFunction

string[] bondageList
int[] bondageHard
int[] bondageSettings

function DisplayBondageRules()

    int[] outfitIdList = JsonUtil.IntListToArray(main.BindingGameOutfitFile, "outfit_id_list")

    bool found = false

    int i = 0
    while i < outfitIdList.Length
        if JsonUtil.GetIntValue(main.BindingGameOutfitFile, outfitIdList[i] + "_rules_based", 0) == 1   
            found = true
        endif
        i += 1
    endwhile

    if found
        AddTextOption("Rules Based Outfits Found", "Yes")
    else
        AddTextOption("Rules Based Outfits Found", "No")
    endif
    AddTextOption("", "")
    AddTextOption("", "")
    AddTextOption("", "")

    AddHeaderOption("Bondage Rules")
    AddHeaderOption("")

    bondageList = rman.GetBondageRuleNameArray() 

    i = 0
    while i < bondageList.Length

        int ruleSetting = rman.GetBondageRule(theSub, i)
        int ruleOption = rman.GetBondageRuleOption(theSub, i)
        float ruleEndTime = 0.0

        if ruleSetting == 1
            ruleEndTime = rman.GetBondageRuleEnd(theSub, i)
        endif

        if bind_GlobalRulesControlledBy.GetValue() > 0

            string ruleName = bondageList[i]
            if ruleEndTime > 0.0
                float hoursLeft = (ruleEndTime - bind_Utility.GetTime()) * 24.0
                ruleName += " (" + Math.Ceiling(hoursLeft) + "h)"
            elseif ruleEndTime <= 0.0 && ruleSetting == 1
                ruleName += " (expired)"
            endif 

            string displayText = ""
            if ruleSetting == 1
                displayText = "On"
            endif

            AddTextOption(ruleName, displayText)

        else

            string displayText = ""
            if ruleSetting == 1
                displayText = "On"
            endif

            toggleBondageRules[i] = AddTextOption(bondageList[i], displayText)

        endif

        string optionText = ""
        if ruleOption == 1
            optionText = "Blocked / Hard Limit"
        elseif ruleOption == 2
            optionText = "Safe Areas"
        elseif ruleOption == 3
            optionText = "Permanent"
        elseif ruleOption == 4
            optionText = "Permanent Safe Areas"
        elseif ruleOption == 5
            optionText = "Unsafe Areas"
        elseif ruleOption == 6
            optionText = "Permanent Unsafe Areas"
        endif

        toggleBondageRuleOptions[i] = AddTextOption("Options", optionText)

        i += 1
    endwhile

    ; string[] bondageList = rman.GetBondageRuleNameArray() ; rman.GetBondageRulesList()
    ; ;int[] bondageSettings = rman.GetBondageRulesSettingsList()
    ; ;int[] bondageHard = rman.GetBondageHardLimitsList()

    ; int i = 0
    ; while i < bondageList.Length

    ;     int ruleSetting = rman.GetBondageRule(theSub, i) ;StorageUtil.GetIntValue(theSub, "bind_rule_setting_" + i, 0)
    ;     int ruleOption = rman.GetBondageRuleOption(theSub, i) ;StorageUtil.GetIntValue(theSub, "bind_rule_option_" + i, 0)

    ;     ; string ruleText = "Off"
    ;     ; if ruleSetting == 1
    ;     ;     ruleText = "On"
    ;     ; endif
    ;     ; if ruleOption == 1
    ;     ;     ruleText += " - Blocked / Hard Limit"
    ;     ; elseif ruleOption == 2
    ;     ;     ruleText += " - Safe Areas"
    ;     ; elseif ruleOption == 3
    ;     ;     ruleText += " - Permanent"
    ;     ; elseif ruleOption == 4
    ;     ;     ruleText += " - Permanent Safe Areas"
    ;     ; endif

    ;     toggleBondageRules[i] = AddTextOption(bondageList[i], FormatRuleText(ruleSetting, ruleOption))

    ;     i += 1

    ; endwhile

    ; If ((bondageList.Length as int) % 2) != 0.0
    ;     AddTextOption("", "")
    ; EndIf

endfunction

Function DisplayRules()

    if main.RulesMenuLockoutTime > bind_Utility.GetTime()
        AddTextOption("Rules menu locked", "")
        return
    endif

    ; if toggleBehaviorHard.Length != 50 ;lets rebuild...
    ;     toggleBehaviorHard = new int[50]
    ; endif
    ; if toggleBondageHard.Length != 50
    ;     toggleBondageHard = new int[50]
    ; endif

    ruleManagementTypes = new String[3]
    ruleManagementTypes[0] = "Sub Managed"
    ruleManagementTypes[1] = "Dom Managed"
    ruleManagementTypes[2] = "Hybrid"

    AddHeaderOption("Rules Settings")
    AddHeaderOption("")

    selectedRuleManagementType = ruleManagementTypes[bind_GlobalRulesControlledBy.GetValue() as int]
    menuRulesControlType = AddMenuOption("Rules Control", selectedRuleManagementType)
    
    ;toggleNudityRequired = AddToggleOption("Nudity Required", bind_GlobalRulesNudityRequired.GetValue())
    toggleRulesMenuLockout = AddToggleOption("Lock Menu 1 Week - Exit MCM To Save", toggleRulesMenuLockoutValue)
    toggleUseFastRuleCheck = AddToggleOption("Use Fast Rules Check", rman.UseFastRuleCheck)

    AddTextOption("", "")

    AddHeaderOption("Dom & Hybrid Managed Options")
    AddHeaderOption("")

    sliderRulesChance = AddSliderOption("Rules - Chance Add (Hourly)", bind_GlobalRulesChangeChance.GetValue(), "{0}%")
    sliderRulesHoursBetween = AddSliderOption("Rules - Hours Between Changes", bind_GlobalRulesHoursBetween.GetValue(), "{0}")

    sliderRulesMinBehavior = AddSliderOption("Behavior Rules - Min Rules", bind_GlobalRulesBehaviorMin.GetValue(), "{0}")
    sliderRulesMaxBehavior = AddSliderOption("Behavior Rules - Max Rules", bind_GlobalRulesBehaviorMax.GetValue(), "{0}")
    sliderRulesMinBondage = AddSliderOption("Bondage Rules - Min Rules", bind_GlobalRulesBondageMin.GetValue(), "{0}")
    sliderRulesMaxBondage = AddSliderOption("Bondage Rules - Max Rules", bind_GlobalRulesBondageMax.GetValue(), "{0}")



    ; AddHeaderOption("Set Hard Limits - Behavior")
    ; AddHeaderOption("")

    ; behaviorList = rman.GetBehaviorRulesList()
    ; behaviorHard = rman.GetBehaviorHardLimitsList()

    ; int i = 0
    ; while i < behaviorList.Length
    ;     toggleBehaviorHard[i] = AddToggleOption(behaviorList[i], behaviorHard[i])
    ;     i += 1
    ; endwhile

    ; If ((behaviorList.Length as int) % 2) != 0.0
    ;     AddTextOption("", "")
    ; EndIf

    ; AddHeaderOption("Set Hard Limits - Bondage")
    ; AddHeaderOption("")

    ; string[] bondageList = rman.GetBondageRulesList()
    ; int[] bondageHard = rman.GetBondageHardLimitsList()

    ; i = 0
    ; while i < bondageList.Length
    ;     toggleBondageHard[i] = AddToggleOption(bondageList[i], bondageHard[i])
    ;     i += 1
    ; endwhile

    ; If ((bondageList.Length as int) % 2) != 0.0
    ;     AddTextOption("", "")
    ; EndIf

    AddHeaderOption("Other Rules - Using External Mods")
    AddHeaderOption("")

    If main.SoftCheckSweepingOrganizesStuff == 1
        toggleRuleCleanPlayerHome = AddToggleOption("Clean Player Home", main.RuleMustCleanPlayerHome)
    Else
        AddTextOption("Sweeping Organizes Stuff", "Not Found")
    EndIf

EndFunction

Function DisplayDebug()

    AddHeaderOption("Punishments")
    AddHeaderOption("Safeword")

    toggleClearPunishments = AddToggleOption("Clear Punishments Due", changeClearPunishments)

    if bind_GlobalModState.GetValue() == bind_Controller.GetModStateRunning() || bind_GlobalModState.GetValue() == bind_Controller.GetModStateEvent()
        toggleRunSafeword = AddToggleOption("Use Safeword", changeRunSafeword)
    else
        AddTextOption("", "")
    endif
    
    toggleAddPunishment = AddToggleOption("Add Test Punishment Due", changeAddPunishment)    
    AddTextOption("", "")

    toggleAddPoints = AddToggleOption("Add Rule Points", changeAddRulePoints)
    AddTextOption("", "")

    AddHeaderOption("Input Settings")
    AddHeaderOption("")
    keymapActionKey = AddKeyMapOption("Binding Action Key", bind_GlobalActionKey.GetValue() as int) ; main.ActionKeyMappedKeyCode)
    int mdKey = main.ActionKeyModifier
    if main.ActionKeyModifier == 0
        mdKey = -1
    endif        
    actionKeyModifierOption = AddTextOption("Action Key Modifier", GetModifierString(mdKey))

    AddHeaderOption("Save MCM Settings")
    AddHeaderOption("")

    savesList = McmGetSaveList()

    menuMcmSaves = AddMenuOption("Selected Save", "")
    toggleLoadMcm = AddToggleOption("Load Selected (exit menu after)", changeLoadMcm)

    toggleSaveMcm = AddToggleOption("New Save (exit menu after)", changeSaveMcm)
    AddTextOption("","")

    AddHeaderOption("System")
    AddHeaderOption("")
    toggleWriteLogs = AddToggleOption("Write Detailed Logs", main.WriteLogs)
    toggleDisplayLocationChange = AddToggleOption("Show Location Change", main.DisplayLocationChange)
    AddTextOption("Binding Version", version)

EndFunction

event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	{Called when a key has been remapped}

	bool continue = true
	if (conflictControl != "" && keyCode != 1)
		string msg
		if (conflictControl != "")
			msg = "This key is mapped to:\n'" + conflictControl + "'\n(" + conflictName + ")\n\nDo you want to continue?"
		else
			msg = "This key is mapped to:\n'" + conflictControl + "'\n\nDo you want to continue?"
		endIf
		continue = ShowMessage(msg, true, "$Yes", "$No")
	endIf

	; clear if escape key
	if (keyCode == 1)
		keyCode = -1
	endIf

	if (continue)
        if option == keymapActionKey
            UnregisterForKey(main.ActionKeyMappedKeyCode)
            bind_GlobalActionKey.SetValue(keyCode)
            RegisterForKey(keyCode)
            SetKeyMapOptionValue(keymapActionKey, keyCode)
        endIf
    endif

endevent

string lastOpenedText

event OnOptionInputOpen(int option)

    if selectedPage == "Bondage Outfits"

    endif

    ; lastOpenedText = ""
    ; string displayValue = ""
    ;string[] usedTags = StringUtil.Split(main.SexUseSLTags, ",")

    int i = 0
    while i < inputSLUseTags.Length
        if option == inputSLUseTags[i]
            SetInputDialogStartText(slUseTags[i])
        endif
        i += 1
    endwhile

    i = 0
    while i < inputSLBlockTags.Length
        if option == inputSLBlockTags[i]
            SetInputDialogStartText(slBlockTags[i])
        endif
        i += 1
    endwhile

    if option == inputBondageSetName
        SetInputDialogStartText(selectedBondageOutfit)
    endif

    if option == inputDeviousKeywordSearch
        SetInputDialogStartText(deviousKeywordSearch)
    endif

    if option == inputDomTitle
        SetInputDialogStartText(fs.GetDomTitle())
    endif

	; if option == inputSLUseTags
	; 	SetInputDialogStartText(main.SexUseSLTags)
    ; elseif option == inputSLBlockTags
    ;     SetInputDialogStartText(main.SexBlockSLTags)
	; endIf
endEvent


event OnOptionInputAccept(int option, string value)

    if selectedPage == "Bondage Outfits"

    endif

    bool updateSlUsed = false

    int i = 0
    while i < inputSLUseTags.Length
        if option == inputSLUseTags[i]
            slUseTags[i] = value
            SetInputOptionValue(inputSLUseTags[i], value)
            updateSlUsed = true
        endif
        i += 1
    endwhile

    if updateSlUsed
        ;string[] blockTags = StorageUtil.StringListToArray(theSub, "bind_block_sl_tags")
        StorageUtil.StringListClear(theSub, "bind_use_sl_tags")
        i = 0
        while i < inputSLUseTags.Length
            if slUseTags[i] != ""
                StorageUtil.StringListAdd(theSub, "bind_use_sl_tags", slUseTags[i], true)
            endif
            i += 1
        endwhile
    endif

    bool updateSlBlocked = false
    i = 0
    while i < inputSLBlockTags.Length
        if option == inputSLBlockTags[i]
            slBlockTags[i] = value
            SetInputOptionValue(inputSLBlockTags[i], value)
            updateSlBlocked = true
        endif
        i += 1
    endwhile
    
    if updateSlBlocked
        StorageUtil.StringListClear(theSub, "bind_block_sl_tags")
        i = 0
        while i < inputSLBlockTags.Length
            if slBlockTags[i] != ""
                StorageUtil.StringListAdd(theSub, "bind_block_sl_tags", slBlockTags[i], true)
            endif
            i += 1
        endwhile
    endif

    if option == inputDomTitle
        if value != ""
            fs.SettingsSetDomTitleByString(value)
            SetInputOptionValue(option, value)
        endif
    endif

    if option == inputBondageSetName
        SetInputOptionValue(inputBondageSetName, value)
        JsonUtil.SetStringValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_bondage_outfit_name", value)

        JsonUtil.StringListSet(main.BindingGameOutfitFile, "outfit_name_list", currentBondageOutfitIndex, value)

        JsonUtil.Save(main.BindingGameOutfitFile)

        ;selectedBondageOutfit = ""
        ;selectedBondageOutfitId = 0
        ;selectedBondageOutfitIndex = -1
        ;ForcePageReset()
        SetInputOptionValue(option, value)
    endif

    if option == inputDeviousKeywordSearch

        searchResultsForms = bind_SkseFunctions.SearchFormListsByKeyword(value, bmanage.bind_zap_all, bmanage.bind_dd_all)
        ;debug.MessageBox(list)

        ;SetInputOptionValue(inputDeviousKeywordSearch, "Running Search...")

        selectedFoundItemId = -1
        selectedFoundItem = ""

        ; Form[] items = bind_SkseFunctions.SearchDeviousByKeywords(bmanage.bind_dd_all, value)
        ; debug.MessageBox(items.Length)

        string buffer = ""
        int idx = 0
        while idx < searchResultsForms.Length
            if buffer != "" 
                buffer += "|"
            endif
            buffer += searchResultsForms[idx].GetName()
            idx += 1
        endwhile

        searchResults = StringUtil.Split(buffer, "|") ;bmanage.SearchDeviousItems(value)
        bind_Utility.WriteToConsole("searchResults: " + searchResults.Length)

        SetInputOptionValue(inputDeviousKeywordSearch, "Found: " + searchResults.Length)        
    endif

	; if option == inputSLUseTags
    ;     ;parse and validate with list??
    ;     main.SexUseSLTags = value
	; 	SetInputOptionValue(inputSLUseTags, value)
    ; elseif option == inputSLBlockTags
    ;     main.SexBlockSLTags = value
    ;     SetInputOptionValue(inputSLBlockTags, value)
	; endIf
endEvent

; Event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
	
;     if option == keymapActonKey
;         UnregisterForKey(main.ActionKeyMappedKeyCode)
; 		;main.ActionKeyMappedKeyCode = keyCode
;         bind_GlobalActionKey.SetValue(keyCode)
;         RegisterForKey(keyCode)
; 		SetKeyMapOptionValue(keymapActonKey, keyCode)
; 	endIf

; EndEvent

string function FormatRuleText(int ruleSetting, int ruleOption)
    string ruleText = "off"
    if ruleSetting == 1
        ruleText = "ON"
    endif
    if ruleOption == 1
        ruleText += " - Blocked / Hard Limit"
    elseif ruleOption == 2
        ruleText += " - Safe Areas"
    elseif ruleOption == 3
        ruleText += " - Permanent"
    elseif ruleOption == 4
        ruleText += " - Permanent Safe Areas"
    endif
    return ruleText
endfunction

Event OnOptionSelect(int option)

    int i

    if selectedPage == "Backup Settings"

        if option == clickedResetCurrentSaveBondageOutfits
            if ShowMessage("Reset current save bondage outfits from bondage outfit template data?", true, "$Yes", "$No")
                ; string folder = "data/skse/plugins/StorageUtilData/binding/templates/outfits/"
                ; string gameFolder = "data/skse/plugins/StorageUtilData/binding/games/" + main.SaveGameUid + "/outfits/"
                ; string outfitsFileText = MiscUtil.ReadFromFile(folder + "bind_bondage_outfits.json")
                ; ;ShowMessage(outfitsFileText, false)
                ; MiscUtil.WriteToFile(gameFolder + "bind_bondage_outfits.json", outfitsFileText, false, false)

                ; string backupOutfitList = ""

                ; int[] outfitList = JsonUtil.IntListToArray("binding/templates/bind_bondage_outfits.json", "bondage_set_ids")

                ; i = 0
                ; string outfitFileText
                ; while i < outfitList.Length
                ;     if backupOutfitList != ""
                ;         backupOutfitList += "|"
                ;     endif
                ;     backupOutfitList += outfitList[i]
                ;     outfitFileText = MiscUtil.ReadFromFile(folder + "bind_bondage_outfit_" + outfitList[i] + ".json")
                ;     MiscUtil.WriteToFile(gameFolder + "bind_bondage_outfit_" + outfitList[i] + ".json", outfitFileText, false, false)
                ;     i += 1
                ; endwhile

                ; selectedBondageOutfit = ""
                ; selectedBondageOutfitId = 0

                bmanage.CreateBondageOutfitFile()

                ShowMessage("Bondage outfits refreshed from template data. Be sure to re-load the save.", false)
            endif
        endif

        if option == clickedBackupBondageOutfits
            if ShowMessage("Make bondage outfit templates backup?", true, "$Yes", "$No")
                string folder = "data/skse/plugins/StorageUtilData/binding/templates/outfits/"
                string backupFolder = "data/skse/plugins/StorageUtilData/binding_backup/templates/outfits/"
                string outfitsFileText = MiscUtil.ReadFromFile(folder + "bind_bondage_outfits.json")
                ;ShowMessage(outfitsFileText, false)
                MiscUtil.WriteToFile(backupFolder + "bind_bondage_outfits.json", outfitsFileText, false, false)

                string backupOutfitList = ""

                int[] outfitList = JsonUtil.IntListToArray("binding/templates/bind_bondage_outfits.json", "bondage_set_ids")

                i = 0
                string outfitFileText
                while i < outfitList.Length
                    if backupOutfitList != ""
                        backupOutfitList += "|"
                    endif
                    backupOutfitList += outfitList[i]
                    outfitFileText = MiscUtil.ReadFromFile(folder + "bind_bondage_outfit_" + outfitList[i] + ".json")
                    MiscUtil.WriteToFile(backupFolder + "bind_bondage_outfit_" + outfitList[i] + ".json", outfitFileText, false, false)
                    i += 1
                endwhile

                MiscUtil.WriteToFile(backupFolder + "bind_bondage_outfit_list_backup.txt", backupOutfitList, false, false)

                ShowMessage("Backup Completed. Be sure to leave the backup files in the MO2 binding_backup overwrite folder.", false)
            endif
        endif

        if option == clickedRestoreBondageOutfits
            string folder = "data/skse/plugins/StorageUtilData/binding/templates/outfits/"
            string backupFolder = "data/skse/plugins/StorageUtilData/binding_backup/templates/outfits/"
            if !MiscUtil.FileExists(backupFolder + "bind_bondage_outfits.json")
                ShowMessage("No backup exists", false)
            else
                if ShowMessage("Restore bondage outfit templates backup? This will overwrite your current outfit templates.", true, "$Yes", "$No")

                    string outfitsFileText = MiscUtil.ReadFromFile(backupFolder + "bind_bondage_outfits.json")

                    ;debug.MessageBox(outfitsFileText)

                    MiscUtil.WriteToFile(folder + "bind_bondage_outfits.json", outfitsFileText, false, false)

                    string backupOutfitList = MiscUtil.ReadFromFile(backupfolder + "bind_bondage_outfit_list_backup.txt")

                    debug.MessageBox(backupOutfitList)

                    string[] outfitList = StringUtil.Split(backupOutfitList, "|")
                    
                    ;ShowMessage(outfitList, false)

                    i = 0
                    string outfitFileText
                    while i < outfitList.Length
                        outfitFileText = MiscUtil.ReadFromFile(backupFolder + "bind_bondage_outfit_" + outfitList[i] + ".json")
                        MiscUtil.WriteToFile(folder + "bind_bondage_outfit_" + outfitList[i] + ".json", outfitFileText, false, false)
                        i += 1
                    endwhile

                    ShowMessage("Restore Completed. Template data will be available for new games.", false)
                endif
            endif
        endif

        if option == clickedUpdateTemplateFromCurrentSave
            string folder = "data/skse/plugins/StorageUtilData/binding/templates/outfits/"
            string folderJson = "binding/templates/outfits/"
            ;string gameFolder = "data/skse/plugins/StorageUtilData/binding/games/" + main.SaveGameUid + "/outfits/"
            if ShowMessage("Update bondage outfit templates with data from this save game? WARNING: this will overwrite templates for new games.", true, "$Yes", "$No")

                ;bondageSetNames = JsonUtil.StringListToArray(main.BindingGameOutfitFile, "outfit_name_list")
                int[] setIdList = JsonUtil.IntListToArray(main.BindingGameOutfitFile, "outfit_id_list")
                i = 0
                while i < setIdList.Length

                    int setId = setIdList[i]

                    string fileName = folder + "bind_bondage_outfit_" + setId + ".json"
                    string jsonFileName = folderJson + "bind_bondage_outfit_" + setId + ".json"

                    MiscUtil.WriteToFile(fileName, "{}", false, false) ;clear the json
                                        
                    JsonUtil.SetIntValue(jsonFileName, "outfit_id", setId)
                    JsonUtil.SetFloatValue(jsonFileName, "dynamic_bondage_expires", 0.0)
                    JsonUtil.FormListCopy(jsonFileName, "dynamic_bondage_items", JsonUtil.FormListToArray(main.BindingGameOutfitFile, setId + "_dynamic_bondage_items"))
                    JsonUtil.FormListCopy(jsonFileName, "fixed_bondage_items", JsonUtil.FormListToArray(main.BindingGameOutfitFile, setId + "_fixed_bondage_items"))
                    JsonUtil.SetIntValue(jsonFileName, "outfit_enabled", JsonUtil.GetIntValue(main.BindingGameOutfitFile, setId + "_outfit_enabled"))
                    JsonUtil.SetIntValue(jsonFileName, "remove_existing_gear", JsonUtil.GetIntValue(main.BindingGameOutfitFile, setId + "_remove_existing_gear"))
                    JsonUtil.SetIntValue(jsonFileName, "use_random_bondage", JsonUtil.GetIntValue(main.BindingGameOutfitFile, setId + "_use_random_bondage"))
                    JsonUtil.IntListCopy(jsonFileName, "block_slots", JsonUtil.IntListToArray(main.BindingGameOutfitFile, setId + "_block_slots"))
                    JsonUtil.IntListCopy(jsonFileName, "random_bondage_chance", JsonUtil.IntListToArray(main.BindingGameOutfitFile, setId + "_random_bondage_chance"))
                    JsonUtil.StringListCopy(jsonFileName, "used_for", JsonUtil.StringListToArray(main.BindingGameOutfitFile, setId + "_used_for"))
                    JsonUtil.SetStringValue(jsonFileName, "bondage_outfit_name", JsonUtil.GetStringValue(main.BindingGameOutfitFile, setId + "_bondage_outfit_name"))
                    JsonUtil.Save(jsonFileName)

                    i += 1

                endwhile

                ShowMessage("Bondage template update completed.", false)
            endif
        endif

    endif

    if selectedPage == "Bondage Outfits"

        if option == clickedNewOutfit
            if ShowMessage("Create new outfit?", true, "$Yes", "$No")
                int uid = Utility.RandomInt(100000000,999999999)
                string newSetName = "Bondage Set " + uid
                ;string fileName = main.GameSaveFolderJson + "bind_bondage_outfit_" + uid + ".json"
                
                JsonUtil.StringListAdd(main.BindingGameOutfitFile, "outfit_name_list", newSetName)
                JsonUtil.IntListAdd(main.BindingGameOutfitFile, "outfit_id_list", uid)
                ;JsonUtil.SetStringValue(fileName, "bondage_outfit_name", newSetName)
                ;JsonUtil.SetIntValue(fileName, "outfit_id", uid)
                JsonUtil.Save(main.BindingGameOutfitFile)

                ShowMessage("Bondage outfit " + uid + " created.", false)
                ;ForcePageReset()
            endif
        endif

        if option == toggleUseOutfit
            int newValue = 0

            if JsonUtil.GetIntValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_outfit_enabled", 0) == 1
                JsonUtil.SetIntValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_outfit_enabled", 0)
                newValue = 0
            else
                JsonUtil.SetIntValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_outfit_enabled", 1)
                newValue = 1
            endif    

            SetToggleOptionValue(option, newValue)
        endif

        if option == toggleBondageOutfitRulesBased
            int useRulesBased = JsonUtil.GetIntValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_rules_based", 0)
            if useRulesBased == 0
                useRulesBased = 1
            else
                useRulesBased = 0
            endif
            JsonUtil.SetIntValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_rules_based", useRulesBased)
            JsonUtil.Save(main.BindingGameOutfitFile)
            SetToggleOptionValue(toggleBondageOutfitRulesBased, useRulesBased)
        endif

        if option == toggleBondageOutfitUseRandomBondage
            int useRandomBondage = JsonUtil.GetIntValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_use_random_bondage", 0)
            if useRandomBondage == 0
                useRandomBondage = 1
                if JsonUtil.IntListCount(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance") == 0
                    JsonUtil.IntListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", 0) ;a plug 0
                    JsonUtil.IntListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", 0) ;v plug 1
                    JsonUtil.IntListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", 0) ;v pier 2
                    JsonUtil.IntListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", 0) ;n pier 3
                    JsonUtil.IntListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", 0) ;arms 4
                    JsonUtil.IntListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", 0) ;body 5
                    JsonUtil.IntListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", 0) ;legs 6
                    JsonUtil.IntListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", 0) ;boots 7
                    JsonUtil.IntListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", 0) ;gloves 8
                    JsonUtil.IntListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", 0) ;collar 9
                    JsonUtil.IntListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", 0) ;gag 10
                    JsonUtil.IntListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", 0) ;blindfold 11
                    JsonUtil.IntListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", 0) ;hood 12
                endif
            else
                useRandomBondage = 0
            endif
            JsonUtil.SetIntValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_use_random_bondage", useRandomBondage)
            JsonUtil.Save(main.BindingGameOutfitFile)
            SetToggleOptionValue(toggleBondageOutfitUseRandomBondage, useRandomBondage)
            ;bind_Utility.DoSleep(1.0)
            ;ForcePageReset()
            ;DisplayBondageOutfits()
        endif

        if option == clickedLearnBondageOutfit
            if ShowMessage("Learn worn DD items?", true, "$Yes", "$No")
                bmanage.LearnWornDdItemsToSet(theSub, selectedBondageOutfitId)
                ForcePageReset()
            endif
        endif

        if option == clickedLearnWornGear
            if ShowMessage("Learn worn armor and clothing?", true, "$Yes", "$No")
                gmanage.LearnWornItemsForBondageOutfit(theSub, selectedBondageOutfitId)
                ForcePageReset()
            endif
        endif

        if option == clickedFoundItem
            if selectedFoundItemId > -1
                if ShowMessage("Add DD item " + selectedFoundItem + "?", true, "$Yes", "$No")
                    ;string resultsFile = "binding/bind_dd_search_result.json"
                    Form dev = searchResultsForms[selectedFoundItemId] ;JsonUtil.FormListGet(resultsFile, "found_items", selectedFoundItemId)
                    if dev
                        JsonUtil.FormListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_fixed_bondage_items", dev, false)
                    endif
                    ForcePageReset()
                endif
            endif
        endif

        if option == bondageSetRemoveExistingGearToggle
            if JsonUtil.GetIntValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_remove_existing_gear", 0) == 0
                JsonUtil.SetIntValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_remove_existing_gear", 1)
                SetToggleOptionValue(option, 1)
            else
                JsonUtil.SetIntValue(main.BindingGameOutfitFile, selectedBondageOutfitId + "_remove_existing_gear", 0)
                SetToggleOptionValue(option, 0)
            endif
            JsonUtil.Save(main.BindingGameOutfitFile)
            
        endif

        i = 0
        while i < bondageSetUsedForToggle.Length
            if option == bondageSetUsedForToggle[i]
                if JsonUtil.StringListHas(main.BindingGameOutfitFile, selectedBondageOutfitId + "_used_for", bondageOutfitUsageKey[i])
                    JsonUtil.StringListRemove(main.BindingGameOutfitFile, selectedBondageOutfitId + "_used_for", bondageOutfitUsageKey[i])
                    SetToggleOptionValue(option, 0)
                else
                    JsonUtil.StringListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_used_for", bondageOutfitUsageKey[i])
                    SetToggleOptionValue(option, 1)
                endif
                JsonUtil.Save(main.BindingGameOutfitFile)

            endif
            i += 1
        endwhile

        i = 0
        while i < bondageOutfitBlockToggle.Length
            if option == bondageOutfitBlockToggle[i]
                if JsonUtil.IntListHas(main.BindingGameOutfitFile, selectedBondageOutfitId + "_block_slots", bondageOutfitBlocksSlots[i])
                    ;JsonUtil.StringListRemove(main.BindingGameOutfitFile, selectedBondageOutfitId + "_blocks", bondageOutfitBlocks[i])
                    JsonUtil.IntListRemove(main.BindingGameOutfitFile, selectedBondageOutfitId + "_block_slots", bondageOutfitBlocksSlots[i])
                    SetToggleOptionValue(option, 0)
                else
                    ;JsonUtil.StringListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_blocks", bondageOutfitBlocks[i])
                    JsonUtil.IntListAdd(main.BindingGameOutfitFile, selectedBondageOutfitId + "_block_slots", bondageOutfitBlocksSlots[i])
                    SetToggleOptionValue(option, 1)
                endif
                JsonUtil.Save(main.BindingGameOutfitFile)
            endif
            i += 1
        endwhile

        i = 0
        while i < bondageSetRemoveDdToggle.Length
            if option == bondageSetRemoveDdToggle[i]
                Form dev = JsonUtil.FormListGet(main.BindingGameOutfitFile, selectedBondageOutfitId + "_fixed_bondage_items", i)
                if ShowMessage("Remove " + dev.GetName() + "?", true, "$Yes", "$No")
                    JsonUtil.FormListRemove(main.BindingGameOutfitFile, selectedBondageOutfitId + "_fixed_bondage_items", dev, true)
                    ForcePageReset()
                endif
            endif
            i += 1
        endwhile

        i = 0
        while i < bondageSetRemoveGearToggle.Length
            if option == bondageSetRemoveGearToggle[i]
                Form dev = JsonUtil.FormListGet(main.BindingGameOutfitFile, selectedBondageOutfitId + "_fixed_worn_items", i)
                if ShowMessage("Remove " + dev.GetName() + "?", true, "$Yes", "$No")
                    JsonUtil.FormListRemove(main.BindingGameOutfitFile, selectedBondageOutfitId + "_fixed_worn_items", dev, true)
                    ForcePageReset()
                endif
            endif
            i += 1
        endwhile

    endif

    bool completed = false

    if option == toggleEnableActionDressingRoom
        int newValue = ToggleValue(brain.EnableActionDressingRoom)
        brain.EnableActionDressingRoom = newValue
        SetToggleOptionValue(option, newValue)
        completed = true
    endif

    if option == toggleEnableActionBed
        int newValue = ToggleValue(brain.EnableActionBed)
        brain.EnableActionBed = newValue
        SetToggleOptionValue(option, newValue)
        completed = true
    endif

    if option == toggleEnableActionWhip
        int newValue = ToggleValue(brain.EnableActionWhip)
        brain.EnableActionWhip = newValue
        SetToggleOptionValue(option, newValue)
        completed = true
    endif

    if option == toggleEnableActionSex
        int newValue = ToggleValue(brain.EnableActionSex)
        brain.EnableActionSex = newValue
        SetToggleOptionValue(option, newValue)
        completed = true
    endif

    if option == toggleEnableActionFurniture
        int newValue = ToggleValue(brain.EnableActionFurniture)
        brain.EnableActionFurniture = newValue
        SetToggleOptionValue(option, newValue)
        completed = true
    endif

    if option == toggleEnableActionHarshBondage
        int newValue = ToggleValue(brain.EnableActionHarshBondage)
        brain.EnableActionHarshBondage = newValue
        SetToggleOptionValue(option, newValue)
        completed = true
    endif

    if option == toggleEnableActionCamping
        int newValue = ToggleValue(brain.EnableActionCamping)
        brain.EnableActionCamping = newValue
        SetToggleOptionValue(option,newValue)
        completed = true
    endif

    if option == toggleEnableActionInspection
        int newValue = ToggleValue(brain.EnableActionInspection)
        brain.EnableActionInspection = newValue
        SetToggleOptionValue(option,newValue)
        completed = true
    endif

    if option == actionKeyModifierOption && !completed
        int currentModifier = main.ActionKeyModifier
        int newModifier = AdvanceModifierValue(currentModifier)
        main.ActionKeyModifier = newModifier
        SetTextOptionValue(option, GetModifierString(newModifier))
        completed = true
    endif

    if option == toggleSexUseFramework && !completed
        main.SexUseFramework = ToggleValue(main.SexUseFramework)
        string sexFramework = "SexLab"
        if main.SexUseFramework == 1
            sexFramework = "Devious Devices - SL"
        endif
        SetTextOptionValue(option, sexFramework)
        completed = true
    endif

    if option == toggleDomWantsPrivacy && !completed
        int newValue = ToggleValue(main.SexDomWantsPrivacy)
        main.SexDomWantsPrivacy = newValue
        SetToggleOptionValue(option, newValue)
        completed = true
    endif            

    if selectedPage == "Rules - Bondage"
        i = 0
        if !completed
            while i < rman.GetBondageRulesCount()
                if option == toggleBondageRuleOptions[i]
                    int ruleOption = rman.GetBondageRuleOption(theSub, i)
                    if bind_GlobalRulesControlledBy.GetValue() > 0
                        ruleOption += 1
                        if ruleOption > 6
                            ruleOption = 0
                        endif

                    else
                        ruleOption += 1
                        if ruleOption < 2
                            ruleOption = 2
                        elseif ruleOption == 3
                            ruleOption = 5
                        elseif ruleOption == 6
                            ruleOption = 0
                        endif

                    endif
                    string displayText = ""
                    if ruleOption == 1
                        displayText = "Blocked / Hard Limit"
                    elseif ruleOption == 2
                        displayText = "Safe Areas"
                    elseif ruleOption == 3
                        displayText = "Permanent"
                    elseif ruleOption == 4
                        displayText = "Permanent Safe Areas"
                    elseif ruleOption == 5
                        displayText = "Unsafe Areas"
                    elseif ruleOption == 6
                        displayText = "Permanent Unsafe Areas"
                    endif
                    rman.SetBondageRuleOption(theSub, i, ruleOption)
                    SetTextOptionValue(option, displayText)
                    completed = true
                endif
                if option == toggleBondageRules[i]
                    int ruleSetting = rman.GetBondageRule(theSub, i)

                    if bind_GlobalRulesControlledBy.GetValue() > 0

                    else
                        ruleSetting += 1
                        if ruleSetting > 1
                            ruleSetting = 0
                        endif
                    endif

                    string displayText = ""
                    if ruleSetting == 1
                        displayText = "On"
                    endif

                    rman.SetBondageRule(theSub, i, ruleSetting)
  
                    SetTextOptionValue(option, displayText)
                    completed = true
                endif
                i += 1
            endwhile
        endif
    endif

    if selectedPage == "Rules - Behavior"
        i = 0
        if !completed
            while i < rman.GetBehaviorRulesCount()
                if option == toggleBehaviorRuleOptions[i]
                    int ruleOption = rman.GetBehaviorRuleOption(theSub, i)
                    if bind_GlobalRulesControlledBy.GetValue() > 0
                        ruleOption += 1
                        if ruleOption > 6
                            ruleOption = 0
                        endif

                    else
                        ruleOption += 1
                        if ruleOption < 2
                            ruleOption = 2
                        elseif ruleOption == 3
                            ruleOption = 5
                        elseif ruleOption == 6
                            ruleOption = 0
                        endif

                    endif
                    string displayText = ""
                    if ruleOption == 1
                        displayText = "Blocked / Hard Limit"
                    elseif ruleOption == 2
                        displayText = "Safe Areas"
                    elseif ruleOption == 3
                        displayText = "Permanent"
                    elseif ruleOption == 4
                        displayText = "Permanent Safe Areas"
                    elseif ruleOption == 5
                        displayText = "Unsafe Areas"
                    elseif ruleOption == 6
                        displayText = "Permanent Unsafe Areas"
                    endif
                    rman.SetBehaviorRuleOption(theSub, i, ruleOption)
                    SetTextOptionValue(option, displayText)
                    completed = true
                endif
                if option == toggleBehaviorRules[i]
                    int ruleSetting = rman.GetBehaviorRule(theSub, i)
                    ;int ruleOption = rman.GetBehaviorRuleOption(theSub, i)

                    if bind_GlobalRulesControlledBy.GetValue() > 0
                        ; ruleOption += 1
                        ; if ruleOption > 4
                        ;     ruleOption = 0
                        ; endif
                    else
                        ruleSetting += 1
                        if ruleSetting > 1
                            ruleSetting = 0
                        endif

                        ; if ruleOption == 2
                        ;     ruleOption == 3
                        ; else
                        ;     if


                        ; ruleOption += 1
                        ; if ruleOption > 4
                        ;     ruleOption = 0
                        ;     ruleSetting += 1
                        ;     if ruleSetting > 1
                        ;         ruleSetting = 0
                        ;     endif
                        ; endif
                    endif

                    string displayText = ""
                    if ruleSetting == 1
                        displayText = "On"
                    endif

                    rman.SetBehaviorRule(theSub, i, ruleSetting)
                    ;rman.SetBehaviorRuleOption(theSub, i, ruleOption)

                    SetTextOptionValue(option, displayText)
                    completed = true
                endif
                i += 1
            endwhile
        endif
    endif

    ; if !completed
    ;     i = 0
    ;     while i < rman.GetBondageRulesCount()
    ;         if option == toggleBondageRules[i]
    ;             int ruleSetting = StorageUtil.GetIntValue(theSub, "bind_rule_setting_" + i, 0)
    ;             int ruleOption = StorageUtil.GetIntValue(theSub, "bind_rule_option_" + i, 0)

    ;             if bind_GlobalRulesControlledBy.GetValue() > 0
    ;                 ruleOption += 1
    ;                 if ruleOption > 4
    ;                     ruleOption = 0
    ;                 endif
    ;             else
    ;                 ruleOption += 1
    ;                 if ruleOption > 4
    ;                     ruleOption = 0
    ;                     ruleSetting += 1
    ;                     if ruleSetting > 1
    ;                         ruleSetting = 0
    ;                     endif
    ;                 endif
    ;             endif

    ;             StorageUtil.SetIntValue(theSub, "bind_rule_setting_" + i, ruleSetting)
    ;             StorageUtil.SetIntValue(theSub, "bind_rule_option_" + i, ruleOption)

    ;             SetTextOptionValue(option, FormatRuleText(ruleSetting, ruleOption))
    ;             completed = true
    ;         endif
    ;         i += 1
    ;     endwhile
    ; endif

    int idx = -1
    if !completed
        idx = StorageUtil.IntListFind(theSub, "bind_sl_tag_toggles", option)
        if idx > -1
            string slTag = StorageUtil.StringListGet(theSub, "bind_sl_tags", idx)
            string newText = ""
            bind_Utility.WriteToConsole("clicked: " + slTag + " idx: " + idx)
            if StorageUtil.StringListCountValue(theSub, "bind_use_sl_tags", slTag) > 0
                StorageUtil.StringListRemove(theSub, "bind_use_sl_tags", slTag)
                StorageUtil.StringListAdd(theSub, "bind_block_sl_tags", slTag)
                newText = "Blocked"
            elseif StorageUtil.StringListCountValue(theSub, "bind_block_sl_tags", slTag) > 0
                StorageUtil.StringListRemove(theSub, "bind_block_sl_tags", slTag)
                newText = ""
            else
                StorageUtil.StringListAdd(theSub, "bind_use_sl_tags", slTag)
                newText = "Use"
            endif
            bind_Utility.WriteToConsole("newText: " + newText)
            SetTextOptionValue(option, newText)
            completed = true
        endif
    endif

    ; while i < 50
    ;     if option == toggleBehaviorRules[i]
    ;         bind_Utility.WriteToConsole(option + " toggleBehaviorRules")
    ;         int newValue = ToggleValue(rman.GetBehaviorRuleSettingByIndex(i))
    ;         rman.SetBehaviorRuleSettingByIndex(i, newValue)
    ;         if behaviorList[i] == "Body Rule:Nudity" ;NOTE - might need others if they impact clothing in city/town
    ;             bind_GlobalRulesUpdatedFlag.SetValue(1)
    ;         endif
    ;         SetToggleOptionValue(toggleBehaviorRules[i], newValue)
    ;     endif
    ;     if option == toggleBondageRules[i]
    ;         int newValue = ToggleValue(rman.GetBondageRuleSettingByIndex(i))
    ;         rman.SetBondageRuleSettingByIndex(i, newValue)

    ;         ;StorageUtil.SetIntValue(theSub, "bind_rule_setting_" + i, newValue)
    ;         ; if newValue == 0
    ;         ;     if theSub.IsInFaction(bind_BondageRulesFactionList.GetAt(i) as Faction)
    ;         ;         theSub.RemoveFromFaction(bind_BondageRulesFactionList.GetAt(i) as Faction)
    ;         ;     endif
    ;         ; else
    ;         ;     if !theSub.IsInFaction(bind_BondageRulesFactionList.GetAt(i) as Faction)
    ;         ;         theSub.AddToFaction(bind_BondageRulesFactionList.GetAt(i) as Faction)
    ;         ;     endif
    ;         ; endif

    ;         bind_GlobalRulesUpdatedFlag.SetValue(1)
    ;         SetToggleOptionValue(toggleBondageRules[i], newValue)
    ;     endif
    ;     if option == toggleBehaviorHard[i]
    ;         bind_Utility.WriteToConsole(option + " toggleBehaviorHard")
    ;         int newValue = ToggleValue(rman.GetBehaviorHardLimitByIndex(i))
    ;         rman.SetBehaviorHardLimitByIndex(i, newValue)
    ;         SetToggleOptionValue(toggleBehaviorHard[i], newValue)
    ;     endif
    ;     if option == toggleBondageHard[i]
    ;         int newValue = ToggleValue(rman.GetBondageHardLimitByIndex(i))
    ;         rman.SetBondageHardLimitByIndex(i, newValue)
    ;         SetToggleOptionValue(toggleBondageHard[i], newValue)
    ;     endif
    ;     i += 1
    ; endwhile

    if option == toggleNudityRequired
        bind_GlobalRulesNudityRequired.SetValue(ToggleValue(bind_GlobalRulesNudityRequired.GetValue() as int))
        SetToggleOptionValue(toggleNudityRequired, bind_GlobalRulesNudityRequired.GetValue() as int)
    endif

    if option == toggleUseFastRuleCheck
        rman.UseFastRuleCheck = ToggleValue(rman.UseFastRuleCheck)
        SetToggleOptionValue(toggleUseFastRuleCheck, rman.UseFastRuleCheck)
    endif

    if option == toggleRulesMenuLockout
        toggleRulesMenuLockoutValue = ToggleValue(toggleRulesMenuLockoutValue)
        SetToggleOptionValue(toggleRulesMenuLockout, toggleRulesMenuLockoutValue)
    endif

    If option == toggleHarshUseBoots
        bmanage.HarshBondageUseBoots = ToggleValue(bmanage.HarshBondageUseBoots)
        SetToggleOptionValue(toggleHarshUseBoots, bmanage.HarshBondageUseBoots)
    EndIf

    If option == toggleHarshUseAnkles
        bmanage.HarshBondageUseAnkles = ToggleValue(bmanage.HarshBondageUseAnkles)
        SetToggleOptionValue(toggleHarshUseAnkles, bmanage.HarshBondageUseAnkles)
    EndIf

    If option == toggleHarshUseCollar
        bmanage.HarshBondageUseCollar = ToggleValue(bmanage.HarshBondageUseCollar)
        SetToggleOptionValue(toggleHarshUseCollar, bmanage.HarshBondageUseCollar)
    EndIf

    If option == toggleHarshUseNipple
        bmanage.HarshBondageUseNipple = ToggleValue(bmanage.HarshBondageUseNipple)
        SetToggleOptionValue(toggleHarshUseNipple, bmanage.HarshBondageUseNipple)
    EndIf

    If option == toggleHarshUseChastity
        bmanage.HarshBondageUseChastity = ToggleValue(bmanage.HarshBondageUseChastity)
        SetToggleOptionValue(toggleHarshUseChastity, bmanage.HarshBondageUseChastity)
    EndIf

    If option == toggleHarshUseHood
        bmanage.HarshBondageUseHood = ToggleValue(bmanage.HarshBondageUseHood)
        SetToggleOptionValue(toggleHarshUseHood, bmanage.HarshBondageUseHood)
    EndIf

    If option == toggleHarshUseBlindfold
        bmanage.HarshBondageUseBlindfold = ToggleValue(bmanage.HarshBondageUseBlindfold)
        SetToggleOptionValue(toggleHarshUseBlindfold, bmanage.HarshBondageUseBlindfold)
    EndIf


    If option == toggleBedtimeUseHood
        bmanage.BedtimeUseHood = ToggleValue(bmanage.BedtimeUseHood)
        SetToggleOptionValue(toggleBedtimeUseHood, bmanage.BedtimeUseHood) 
    EndIf

    If option == togglePointsBySex
        main.PointsEarnFromSex = ToggleValue(main.PointsEarnFromSex)
        SetToggleOptionValue(togglePointsBySex, main.PointsEarnFromSex)
    EndIf

    If option == togglePointsByHarsh
        main.PointsEarnFromHarshBondage = ToggleValue(main.PointsEarnFromHarshBondage)
        SetToggleOptionValue(togglePointsByHarsh, main.PointsEarnFromHarshBondage)
    EndIf

    If option == togglePointsByFurniture
        main.PointsEarnFromFurniture = ToggleValue(main.PointsEarnFromFurniture)
        SetToggleOptionValue(togglePointsByFurniture, main.PointsEarnFromFurniture)
    EndIf

    If option == togglePointsByBeingGood
        main.PointsEarnFromBeingGood = ToggleValue(main.PointsEarnFromBeingGood)
        SetToggleOptionValue(togglePointsByBeingGood, main.PointsEarnFromBeingGood)
    EndIf

    If option == toggleRuleCleanPlayerHome
        main.RuleMustCleanPlayerHome = ToggleValue(main.RuleMustCleanPlayerHome)
        SetToggleOptionValue(toggleRuleCleanPlayerHome, main.RuleMustCleanPlayerHome)
    EndIf

    ;preferences
    if option == toggleManualAdventureMode
        main.AdventuringManual = ToggleValue(main.AdventuringManual)
        SetToggleOptionValue(toggleManualAdventureMode, main.AdventuringManual)
    endif

    If option == toggleAdventuringFreeHands
        main.AdventuringFreeHands = ToggleValue(main.AdventuringFreeHands)
        SetToggleOptionValue(toggleAdventuringFreeHands, main.AdventuringFreeHands)
    EndIf

    If option == toggleAdventuringAllowClothing
        main.AdventuringAllowClothing = ToggleValue(main.AdventuringAllowClothing)
        SetToggleOptionValue(toggleAdventuringAllowClothing, main.AdventuringAllowClothing)
    EndIf

    If option == toggleAdventuringSuspendRules
        main.AdventuringSuspendRules = ToggleValue(main.AdventuringSuspendRules)
        SetToggleOptionValue(toggleAdventuringSuspendRules, main.AdventuringSuspendRules)
    EndIf

    If option == toggleAdventuringAutomatic
        main.AdventuringAutomatic = ToggleValue(main.AdventuringAutomatic)
        SetToggleOptionValue(toggleAdventuringAutomatic, main.AdventuringAutomatic)
    EndIf

    If option == toggleRandomSubInFurniture
        main.PutOnDisplayRandomUse = ToggleValue(main.PutOnDisplayRandomUse)
        SetToggleOptionValue(toggleRandomSubInFurniture, main.PutOnDisplayRandomUse)
    EndIf

    If option == toggleRandomHarshBondage
        main.HarshBondageRandomUse = ToggleValue(main.HarshBondageRandomUse)
        SetToggleOptionValue(toggleRandomHarshBondage, main.HarshBondageRandomUse)
    EndIf

    If option == toggleInspections
        main.InspectionsRandomUse = ToggleValue(main.InspectionsRandomUse)
        SetToggleOptionValue(toggleInspections, main.InspectionsRandomUse)
    EndIf

    if option == toggleWhippingRandom
        main.WhippingRandomUse = ToggleValue(main.WhippingRandomUse)
        SetToggleOptionValue(option, main.WhippingRandomUse)
    endif

    if option == toggleCampingRandom
        main.CampingRandomUse = ToggleValue(main.CampingRandomUse)
        SetToggleOptionValue(option, main.CampingRandomUse)
    endif

    If option == toggleRunSafeword
        changeRunSafeword = ToggleValue(changeRunSafeword)
        SetToggleOptionValue(toggleRunSafeword, changeRunSafeword)
    EndIf

    If option == toggleClearPunishments
        changeClearPunishments = ToggleValue(changeClearPunishments)
        SetToggleOptionValue(toggleClearPunishments, changeClearPunishments)
    EndIf

    If option == toggleAddPunishment
        changeAddPunishment = ToggleValue(changeAddPunishment)
        SetToggleOptionValue(toggleAddPunishment, changeAddPunishment)
    EndIf

    if option == toggleAddPoints
        changeAddRulePoints = ToggleValue(changeAddRulePoints)
        SetToggleOptionValue(toggleAddPoints, changeAddRulePoints)
    endif

    If option == toggleFurnitureMenu
        main.ShowFurnitureMenu = ToggleValue(main.ShowFurnitureMenu)
        SetToggleOptionValue(toggleFurnitureMenu, main.ShowFurnitureMenu)
    EndIf

    if option == toggleFreeUse
        main.SexFreeUse = ToggleValue(main.SexFreeUse)
        SetToggleOptionValue(toggleFreeUse, main.SexFreeUse)
    EndIf

    ;bound sex flags
    if option ==  toggleBoundSexCuffs
        sms.BoundSexCuffs = ToggleValue(sms.BoundSexCuffs)
        SetToggleOptionValue(toggleBoundSexCuffs, sms.BoundSexCuffs)
    endif
    if option ==  toggleBoundSexHeavyBondage
        sms.BoundSexHeavyBondage = ToggleValue(sms.BoundSexHeavyBondage)
        SetToggleOptionValue(toggleBoundSexHeavyBondage, sms.BoundSexHeavyBondage)
    endif
    if option ==  toggleBoundSexGag
        sms.BoundSexGag = ToggleValue(sms.BoundSexGag)
        SetToggleOptionValue(toggleBoundSexGag, sms.BoundSexGag)
    endif
    if option ==  toggleBoundSexBlindfold
        sms.BoundSexBlindfold = ToggleValue(sms.BoundSexBlindfold)
        SetToggleOptionValue(toggleBoundSexBlindfold, sms.BoundSexBlindfold)
    endif
    if option ==  toggleBoundSexHood
        sms.BoundSexHood = ToggleValue(sms.BoundSexHood)
        SetToggleOptionValue(toggleBoundSexHood, sms.BoundSexHood)
    endif
    if option ==  toggleBoundSexAPlug
        sms.BoundSexAPlug = ToggleValue(sms.BoundSexAPlug)
        SetToggleOptionValue(toggleBoundSexAPlug, sms.BoundSexAPlug)
    endif
    if option ==  toggleBoundSexVPlug
        sms.BoundSexVPlug = ToggleValue(sms.BoundSexVPlug)
        SetToggleOptionValue(toggleBoundSexVPlug, sms.BoundSexVPlug)
    endif
    ;bound masturbation
    if option ==  toggleBoundMasturbationCuffs
        sms.BoundMasturbationCuffs = ToggleValue(sms.BoundMasturbationCuffs)
        SetToggleOptionValue(toggleBoundMasturbationCuffs, sms.BoundMasturbationCuffs)
    endif
    if option ==  toggleBoundMasturbationGag
        sms.BoundMasturbationGag = ToggleValue(sms.BoundMasturbationGag)
        SetToggleOptionValue(toggleBoundMasturbationGag, sms.BoundMasturbationGag)
    endif
    if option ==  toggleBoundMasturbationBlindfold
        sms.BoundMasturbationBlindfold = ToggleValue(sms.BoundMasturbationBlindfold)
        SetToggleOptionValue(toggleBoundMasturbationBlindfold, sms.BoundMasturbationBlindfold)
    endif
    if option ==  toggleBoundMasturbationHood
        sms.BoundMasturbationHood = ToggleValue(sms.BoundMasturbationHood)
        SetToggleOptionValue(toggleBoundMasturbationHood, sms.BoundMasturbationHood)
    endif
    if option ==  toggleBoundMasturbationAPlug
        sms.BoundMasturbationAPlug = ToggleValue(sms.BoundMasturbationAPlug)
        SetToggleOptionValue(toggleBoundMasturbationAPlug, sms.BoundMasturbationAPlug)
    endif
    if option ==  toggleBoundMasturbationVPlug
        sms.BoundMasturbationVPlug = ToggleValue(sms.BoundMasturbationVPlug)
        SetToggleOptionValue(toggleBoundMasturbationVPlug, sms.BoundMasturbationVPlug)
    endif
    if option ==  toggleBoundMasturbationUnties
        sms.BoundMasturbationUnties = ToggleValue(sms.BoundMasturbationUnties)
        SetToggleOptionValue(toggleBoundMasturbationUnties, sms.BoundMasturbationUnties)
    endif

    If option == toggleFreeDismissedDisabled
        main.PreferenceFreeWhenDismissedDisabled = ToggleValue(main.PreferenceFreeWhenDismissedDisabled)
        SetToggleOptionValue(toggleFreeDismissedDisabled, main.PreferenceFreeWhenDismissedDisabled)
    EndIf

    i = 0
    while i < toggleProtection.Length
        if option == toggleProtection[i]
            int newValue = ToggleValue(gmanage.GetSlotProtection(i))
            gmanage.SetSlotProtection(i, newValue)
            SetToggleOptionValue(toggleProtection[i], newValue)
        endif
        i += 1
    endwhile

    If option == toggleCleanSub
        main.DomPreferenceCleanSub = ToggleValue(main.DomPreferenceCleanSub)
        SetToggleOptionValue(toggleCleanSub, main.DomPreferenceCleanSub)
    EndIf

    If option == toggleUnplugGagsOnly
        main.DomOnlyUnplugsPanelGags = ToggleValue(main.DomOnlyUnplugsPanelGags)
        SetToggleOptionValue(toggleUnplugGagsOnly, main.DomOnlyUnplugsPanelGags)
    EndIf

    If option == toggleRemoveGagForDialogue
        main.DomRemovesGagForDialogue = ToggleValue(main.DomRemovesGagForDialogue)
        SetToggleOptionValue(toggleRemoveGagForDialogue, main.DomRemovesGagForDialogue)
    EndIf

    If option == toggleNoFreedom
        main.DomWillNotOfferFreedom = ToggleValue(main.DomWillNotOfferFreedom)
        SetToggleOptionValue(toggleNoFreedom, main.DomWillNotOfferFreedom)
    EndIf

    If option == toggleEventWordWall
        main.DomUseWordWallEvent = ToggleValue(main.DomUseWordWallEvent)
        SetToggleOptionValue(toggleEventWordWall, main.DomUseWordWallEvent)
    EndIf

    If option == toggleDragonSoulRitual
        main.DomUseDragonSoulRitual = ToggleValue(main.DomUseDragonSoulRitual)
        SetToggleOptionValue(toggleDragonSoulRitual, main.DomUseDragonSoulRitual)
    EndIf

    If option == toggleChastiseSub
        main.DomChastiseForRuleBreaking = ToggleValue(main.DomChastiseForRuleBreaking)
        SetToggleOptionValue(toggleChastiseSub, main.DomChastiseForRuleBreaking)
    EndIf

    If option == toggleStartupQuests
        main.DomStartupQuestsEnabled = ToggleValue(main.DomStartupQuestsEnabled)
        SetToggleOptionValue(toggleStartupQuests, main.DomStartupQuestsEnabled)
        if main.DomStartupQuestsEnabled == 0
            Form[] futureDoms = StorageUtil.FormListToArray(fs.GetSubRef(), "bind_future_doms")
            if futureDoms.Length > 0
                int fdi = 0
                while fdi < futureDoms.Length
                    Actor fd = futureDoms[fdi] as Actor
                    if fd.IsInFaction(fs.bind_FutureDomFaction)
                        fd.RemoveFromFaction(fs.bind_FutureDomFaction)
                    endif
                    fdi += 1
                endwhile
                StorageUtil.FormListClear(fs.GetSubRef(), "bind_future_doms")
            endif
            Quest q = Quest.GetQuest("bind_DefeatedQuest")
            if q.IsRunning()
                q.Stop()
            endif
        endif
    EndIf

    if option == toggleFakeSleep
        main.GamePreferenceUseFakeSleep = ToggleValue(main.GamePreferenceUseFakeSleep)
        SetToggleOptionValue(toggleFakeSleep, main.GamePreferenceUseFakeSleep)
    endif

    if option == toggleGameplayAnyNpcCanDom
        main.GameplayAnyNpcCanDom = ToggleValue(main.GameplayAnyNpcCanDom)
        SetToggleOptionValue(toggleGameplayAnyNpcCanDom, main.GameplayAnyNpcCanDom)
    endif

    if option == toggleSimpleSlaveryFemale
        main.SimpleSlaveryFemaleFallback = ToggleValue(main.SimpleSlaveryFemaleFallback)
        SetToggleOptionValue(option, main.SimpleSlaveryFemaleFallback)
        ; if main.SimpleSlaveryFemaleFallback == 0 && main.SimpleSlaveryMaleFallback == 0
        ;     main.SimpleSlaveryMaleFallback = 1
        ;     SetToggleOptionValue(toggleSimpleSlaveryMale, main.SimpleSlaveryMaleFallback)
        ; endif
    endif

    if option == toggleSimpleSlaveryMale
        main.SimpleSlaveryMaleFallback = ToggleValue(main.SimpleSlaveryMaleFallback)
        SetToggleOptionValue(option, main.SimpleSlaveryMaleFallback)
        ; if main.SimpleSlaveryFemaleFallback == 0 && main.SimpleSlaveryMaleFallback == 0
        ;     main.SimpleSlaveryFemaleFallback = 1
        ;     SetToggleOptionValue(toggleSimpleSlaveryFemale, main.SimpleSlaveryFemaleFallback)
        ; endif
    endif

    if option == toggleCleanUpNonBindingItemsFromBags
        main.CleanUpNonBindingItemsFromBags = ToggleValue(main.CleanUpNonBindingItemsFromBags)
        SetToggleOptionValue(toggleCleanUpNonBindingItemsFromBags, main.CleanUpNonBindingItemsFromBags)
    endif


    ;debug
    If option == toggleWriteLogs
        main.WriteLogs = ToggleValue(main.WriteLogs)
        SetToggleOptionValue(toggleWriteLogs, main.WriteLogs)
    EndIF

    If option == toggleDisplayLocationChange
        main.DisplayLocationChange = ToggleValue(main.DisplayLocationChange)
        SetToggleOptionValue(toggleDisplayLocationChange, main.DisplayLocationChange)
    EndIf

    ;diagnostics
    If option == toggleEnableZAP
        main.EnableModZAP = ToggleValue(main.EnableModZAP)
        SetToggleOptionValue(toggleEnableZAP, main.EnableModZAP)
        ;bmanage.ClearFavorites()
        fmanage.SetSelectedFuniture("")
        pman.ClearFavorites()
    EndIf

    If option == toggleEnableDD 
        main.EnableModDD = ToggleValue(main.EnableModDD)
        SetToggleOptionValue(toggleEnableDD, main.EnableModDD)
        ;bmanage.ClearFavorites()
        fmanage.SetSelectedFuniture("")
        pman.ClearFavorites()
    EndIf

    If option == toggleEnableDM3
        main.EnableModDM3 = ToggleValue(main.EnableModDM3)
        SetToggleOptionValue(toggleEnableDM3, main.EnableModDM3)
        fmanage.SetSelectedFuniture("")
    EndIf

    If option == toggleEnablePamaBeatup
        main.EnableModPama = ToggleValue(main.EnableModPama)
        SetToggleOptionValue(toggleEnablePamaBeatup, main.EnableModPama)
    EndIf

    if option == toggleEnableChim
        main.EnableModChim = ToggleValue(main.EnableModChim)
        SetToggleOptionValue(toggleEnableChim, main.EnableModChim)
    endif

    if option == toggleEnableSkyrimNet
        main.EnableModSkyrimNet = ToggleValue(main.EnableModSkyrimNet)
        SetToggleOptionValue(toggleEnableSkyrimNet, main.EnableModSkyrimNet)
    endif

    if option == toggleEnableMME
        ;if !theSub.IsInFaction(bind_MilkSlaveFaction) || theSub.GetFactionRank(bind_MilkSlaveFaction) == 2 || theSub.GetFactionRank(bind_MilkSlaveFaction) == 1
            main.EnableModMME = ToggleValue(main.EnableModMME)
            if main.EnableModMME == 1
                theSub.SetFactionRank(bind_MilkSlaveFaction, 1) ;have quest add
                bind_GlobalMilkTriggerRun.SetValue(1.0)
            else
                bind_MMEHelper.FreeFromMilkSlavery(theSub)
                if theSub.IsInFaction(bind_MilkSlaveFaction)
                    theSub.SetFactionRank(bind_MilkSlaveFaction, 0)
                    theSub.RemoveFromFaction(bind_MilkSlaveFaction)
                    bind_GlobalMilkTriggerRun.SetValue(0.0)
                endif

                ; if theSub.GetFactionRank(bind_MilkSlaveFaction) == 2
                ;     theSub.SetFactionRank(bind_MilkSlaveFaction, 3) ;have quest remove
                ;     bind_GlobalMilkTriggerRun.SetValue(1.0)
                ; elseif theSub.GetFactionRank(bind_MilkSlaveFaction) == 1
                ;     theSub.SetFactionRank(bind_MilkSlaveFaction, 0)
                ;     theSub.RemoveFromFaction(bind_MilkSlaveFaction)
                ;     bind_GlobalMilkTriggerRun.SetValue(0.0)
                ; else

                ;endif
            endif
            SetToggleOptionValue(toggleEnableMME, main.EnableModMME)
        ;endif
    endif

    if option == toggleEnableDirtAndBlood
        main.EnableModDirtAndBlood = ToggleValue(main.EnableModDirtAndBlood)
        SetToggleOptionValue(toggleEnableDirtAndBlood, main.EnableModDirtAndBlood) 
        if main.EnableModDirtAndBlood == 1
            main.EnableModBathingInSkyrim = 0
            SetToggleOptionValue(toggleEnableBathingInSkyrim, main.EnableModBathingInSkyrim) 
        endif
    endif

    if option == toggleEnableBathingInSkyrim
        main.EnableModBathingInSkyrim = ToggleValue(main.EnableModBathingInSkyrim)
        SetToggleOptionValue(toggleEnableBathingInSkyrim, main.EnableModBathingInSkyrim) 
        if main.EnableModBathingInSkyrim == 1
            main.EnableModDirtAndBlood = 0
            SetToggleOptionValue(toggleEnableDirtAndBlood, main.EnableModDirtAndBlood) 
        endif
    endif

    If option == toggleSaveMcm
        changeSaveMcm = ToggleValue(changeSaveMcm)
        SetToggleOptionValue(toggleSaveMcm, changeSaveMcm)
        If changeSaveMcm == 1
            changeLoadMcm = 0
            SetToggleOptionValue(toggleLoadMcm, changeLoadMcm)
        EndIf
    EndIf

    If option == toggleLoadMcm
        If selectedSave != ""
            changeLoadMcm = ToggleValue(changeLoadMcm)
            SetToggleOptionValue(toggleLoadMcm, changeLoadMcm)
            If changeLoadMcm == 1
                changeSaveMcm = 0
                SetToggleOptionValue(toggleSaveMcm, changeSaveMcm)
            EndIf
        Else
            changeLoadMcm = 0
            SetToggleOptionValue(toggleLoadMcm, changeLoadMcm)
        EndIf
    EndIf

    if option == togglePauseMod
        if togglePauseModAction == 0
            togglePauseModAction = 1
        else
            togglePauseModAction = 0
        endif
        SetToggleOptionValue(option, togglePauseModAction)
    endif

    if option == toggleRequireKneeling
        int kneelingRequired = ToggleValue(StorageUtil.GetIntValue(theSub, "kneeling_required", 1))
        if kneelingRequired == 0 
	    	bind_GlobalKneelingOK.SetValue(1.0)
    	endif
        bind_Utility.WriteToConsole("toggleRequireKneeling: " + kneelingRequired)
        StorageUtil.SetIntValue(theSub, "kneeling_required", kneelingRequired)
        bind_GlobalPreferenceRequireKneeling.SetValue(kneelingRequired)
        SetToggleOptionValue(toggleRequireKneeling, kneelingRequired)
    endif

    if option == toggleKneelingOnlyRequiedInSafeAreas
        int kneelingOnlyRequiedInSafeAreas = ToggleValue(StorageUtil.GetIntValue(theSub, "kneeling_safe_areas_only", 1))
        StorageUtil.SetIntValue(theSub, "kneeling_safe_areas_only", kneelingOnlyRequiedInSafeAreas)
        SetToggleOptionValue(toggleKneelingOnlyRequiedInSafeAreas, kneelingOnlyRequiedInSafeAreas)
    endif

    if option == toggleGaggedForNotKneeling
        int gaggedForNotKneeling = ToggleValue(StorageUtil.GetIntValue(theSub, "gagged_for_not_kneeling", 1))
        bind_Utility.WriteToConsole("toggleGaggedForNotKneeling: " + gaggedForNotKneeling)
        StorageUtil.SetIntValue(theSub, "gagged_for_not_kneeling", gaggedForNotKneeling)
        SetToggleOptionValue(toggleGaggedForNotKneeling, gaggedForNotKneeling)
    endif

    if option == toggleInfractionForNotKneeling
        string skey = "rule_infraction_for_not_kneeling"
        int svalue = ToggleValue(StorageUtil.GetIntValue(theSub, skey, 1))
        bind_Utility.WriteToConsole(skey + ": " + svalue)
        StorageUtil.SetIntValue(theSub, skey, svalue)
        SetToggleOptionValue(toggleInfractionForNotKneeling, svalue)
    endif

    if option == outfitSafe
        selectedOutfit = 1
        ForcePageReset()
    endif

    if option == outfitUnsafe
        selectedOutfit = 2
        ForcePageReset()
    endif

    if option == outfitNude
        selectedOutfit = 3
        ForcePageReset()
    endif

    if option == outfitErotic
        selectedOutfit = 4
        ForcePageReset()
    endif

    if option == outfitBikini
        selectedOutfit = 5
        ForcePageReset()
    endif

    if option == toggleOutfitsLearn
        if gmanage.OutfitsLearn == 0
            gmanage.OutfitsLearn = 1
        else
            gmanage.OutfitsLearn = 0
        endif
        SetToggleOptionValue(toggleOutfitsLearn, gmanage.OutfitsLearn)
    endif

    if option == toggleAdventuringUse
        int newValue = ToggleValue(main.AdventuringUse)
        main.AdventuringUse = newValue
        SetToggleOptionValue(toggleAdventuringUse, newValue)
    endif

    if option == toggleAdventuringGoodBehavior
        int newValue = ToggleValue(main.AdventuringGoodBehavior)
        main.AdventuringGoodBehavior = newValue
        SetToggleOptionValue(toggleAdventuringGoodBehavior, newValue)
    endif

    if option == toggleAdventuringTimeOfDayCheck
        int newValue = ToggleValue(main.AdventuringTimeOfDayCheck)
        main.AdventuringTimeOfDayCheck = newValue
        SetToggleOptionValue(toggleAdventuringTimeOfDayCheck, newValue)
    endif

    if option == toggleAdventuringImporantKill
        int newValue = ToggleValue(main.AdventuringImporantKill)
        main.AdventuringImporantKill = newValue
        SetToggleOptionValue(toggleAdventuringImporantKill, newValue)
    endif

    if option == toggleAdventuringUseDwarven
        int newValue = ToggleValue(main.AdventuringUseDwarven)
        main.AdventuringUseDwarven = newValue
        SetToggleOptionValue(toggleAdventuringUseDwarven, newValue)
    endif

EndEvent

Event OnConfigClose()

    if main.DomStartupQuestsEnabled == 0
        if bind_DefeatedQuest.IsRunning()
            bind_DefeatedQuest.Stop()
        endif
    endif

    if toggleRulesMenuLockoutValue == 1
        toggleRulesMenuLockoutValue = 0
        main.RulesMenuLockoutTime = bind_Utility.AddTimeToCurrentTime(168, 0) ;7 game days
    endif

    if togglePauseModAction == 1
        togglePauseModAction = 0
        if bind_GlobalModState.GetValue() == bind_Controller.GetModStateRunning()
            bind_Controller.SendPauseStartEvent()
            debug.MessageBox("Pausing Binding")
        elseif bind_GlobalModState.GetValue() == bind_Controller.GetModStatePaused()
            bind_Controller.SendPauseEndEvent()
            debug.MessageBox("Resuming Binding")
        endif
    endif

    If changeRunSafeword == 1
        changeRunSafeword = 0
        fs.SafeWord()
    EndIf

    If changeSaveMcm == 1
        changeSaveMcm = 0
        McmSaveFunction()
    EndIf

    If changeLoadMcm == 1
        If selectedSave != ""
            changeLoadMcm = 0
            McmLoadFunction(selectedSave)
            selectedSave = ""
        EndIf
    EndIf

    If changeClearPunishments == 1
        changeClearPunishments = 0
        fs.ClearPunishments()
    EndIf

    If changeAddPunishment == 1
        changeAddPunishment = 0
        fs.MarkSubBrokeRule()
    EndIf

    if changeAddRulePoints == 1
        changeAddRulePoints = 0
        ;main.RulePoints += 5
        bind_GlobalPoints.SetValue(bind_GlobalPoints.GetValue() + 5.0)
        debug.MessageBox("Added 5 rule points")
    endif

    ; if main.ModInRunningState()
    ;     ;NOTE - run updates if mod is idle
    ;     if bind_GlobalRulesUpdatedFlag.GetValue() == 1.0 && main.GetDomRef().GetDistance(theSub) < 1500.0
    ;         bind_RulesCheckQuest.Start()
    ;     else
    ;         StorageUtil.SetIntValue(theSub, "bind_safe_area_interaction_check", 3) ;set to to-do
    ;     endif
    ; endif

EndEvent

Event OnOptionSliderOpen(Int option)

    int i
    if selectedPage == "Bondage Outfits"
        int[] chances = JsonUtil.IntListToArray(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance")
        while i < sliderChance.Length
            if sliderChance[i] == option
                SetSliderDialogStartValue(chances[i])
                SetSliderDialogDefaultValue(50)
                SetSliderDialogRange(0, 100)
                SetSliderDialogInterval(5)
            endif
            i += 1
        endwhile
    endif

    If option == sliderFurnitureHours
        SetSliderDialogStartValue(main.PutOnDisplayHoursBetweenUse)
        SetSliderDialogDefaultValue(12)
        SetSliderDialogRange(0, 24)
        SetSliderDialogInterval(1)
    ElseIf option == sliderFurnitureMin
        SetSliderDialogStartValue(main.PutOnDisplayMinMinutes)
        SetSliderDialogDefaultValue(10)
        SetSliderDialogRange(0, 120)
        SetSliderDialogInterval(1)
    ElseIf option == sliderFurnitureMax
        SetSliderDialogStartValue(main.PutOnDisplayMaxMinutes)
        SetSliderDialogDefaultValue(10)
        SetSliderDialogRange(0, 120)
        SetSliderDialogInterval(1)
    ElseIf option == sliderHarshBondageHours
        SetSliderDialogStartValue(main.HarshBondageHoursBetweenUse)
        SetSliderDialogDefaultValue(12)
        SetSliderDialogRange(0, 24)
        SetSliderDialogInterval(1)
    ElseIf option == sliderHarshBondageMin
        SetSliderDialogStartValue(main.HarshBondageMinMinutes)
        SetSliderDialogDefaultValue(10)
        SetSliderDialogRange(0, 120)
        SetSliderDialogInterval(1)
    ElseIf option == sliderHarshBonadgeMax
        SetSliderDialogStartValue(main.HarshBondageMaxMinutes)
        SetSliderDialogDefaultValue(10)
        SetSliderDialogRange(0, 120)
        SetSliderDialogInterval(1)
    ElseIf option == sliderInspectionsHours
        SetSliderDialogStartValue(main.InspectionHoursBetween)
        SetSliderDialogDefaultValue(12)
        SetSliderDialogRange(0, 24)
        SetSliderDialogInterval(1)
    ElseIf option == sliderFurnitureChance
        SetSliderDialogStartValue(main.PutOnDisplayChance)
        SetSliderDialogDefaultValue(10)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(1)
    ElseIf option == sliderFurnitureForSleep
        SetSliderDialogStartValue(main.BedtimeFurnitureForSleep)
        SetSliderDialogDefaultValue(10)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(1)       
    ElseIf option == sliderHarshBondageChance
        SetSliderDialogStartValue(main.HarshBondageChance)
        SetSliderDialogDefaultValue(10)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(1)
    ElseIf option == sliderInspectionsChance
        SetSliderDialogStartValue(main.InspectionChance)
        SetSliderDialogDefaultValue(10)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(1)
    elseif option == sliderWhippingChance
        SetSliderDialogStartValue(main.WhippingChance)
        SetSliderDialogDefaultValue(main.WhippingChance)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(1)

    elseif option == sliderWhippingHours
        SetSliderDialogStartValue(main.WhippingHoursBetween)
        SetSliderDialogDefaultValue(main.WhippingHoursBetween)
        SetSliderDialogRange(0, 24)
        SetSliderDialogInterval(1)

    elseif option == sliderCampingChance
        SetSliderDialogStartValue(main.CampingChance)
        SetSliderDialogDefaultValue(main.CampingChance)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(1)

    ElseIf option == sliderRulesChance
        SetSliderDialogStartValue(bind_GlobalRulesChangeChance.GetValue())
        SetSliderDialogDefaultValue(25)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(1)
    elseif option == sliderRulesHoursBetween
        SetSliderDialogStartValue(bind_GlobalRulesHoursBetween.GetValue())
        SetSliderDialogDefaultValue(1)
        SetSliderDialogRange(0, 24)
        SetSliderDialogInterval(1)
    
    ElseIf option == sliderRulesMinBehavior
        SetSliderDialogStartValue(bind_GlobalRulesBehaviorMin.GetValue())
        SetSliderDialogDefaultValue(0)
        SetSliderDialogRange(0, 15)
        SetSliderDialogInterval(1)
    ElseIf option == sliderRulesMaxBehavior
        SetSliderDialogStartValue(bind_GlobalRulesBehaviorMax.GetValue())
        SetSliderDialogDefaultValue(5)
        SetSliderDialogRange(0, 15)
        SetSliderDialogInterval(1)

    ElseIf option == sliderRulesMinBondage
        SetSliderDialogStartValue(bind_GlobalRulesBondageMin.GetValue())
        SetSliderDialogDefaultValue(0)
        SetSliderDialogRange(0, 15)
        SetSliderDialogInterval(1)
    ElseIf option == sliderRulesMaxBondage
        SetSliderDialogStartValue(bind_GlobalRulesBondageMax.GetValue())
        SetSliderDialogDefaultValue(5)
        SetSliderDialogRange(0, 15)
        SetSliderDialogInterval(1)



    ElseIf option == sliderDomArousal
        SetSliderDialogStartValue(main.SexDomArousalLevelToTrigger)
        SetSliderDialogDefaultValue(75)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(1)
    ElseIf option == sliderChastityRemovalChance
        SetSliderDialogStartValue(main.SexChanceOfChastityRemoval)
        SetSliderDialogDefaultValue(25)
        SetSliderDialogRange(0, 100)
        SetSliderDialogInterval(1)
    ElseIf option == sliderPointsMax
        SetSliderDialogStartValue(main.PointsMax)
        SetSliderDialogDefaultValue(3)
        SetSliderDialogRange(0, 20)
        SetSliderDialogInterval(1)
    elseif option == sliderAdventuringSeconds
        SetSliderDialogStartValue(main.AdventuringCheckAfterSeconds)
        SetSliderDialogDefaultValue(15)
        SetSliderDialogRange(1, 30)
        SetSliderDialogInterval(1)

    elseif option == sliderPunishmentMinGold
        SetSliderDialogStartValue(bind_GlobalPunishmentMinGold.GetValue())
        SetSliderDialogDefaultValue(50)
        SetSliderDialogRange(50, 500)
        SetSliderDialogInterval(25)

    elseif option == sliderPunishmentMaxGold
        SetSliderDialogStartValue(bind_GlobalPunishmentMaxGold.GetValue())
        SetSliderDialogDefaultValue(100)
        SetSliderDialogRange(50, 500)
        SetSliderDialogInterval(25)

    elseif option == sliderPunishmentGoldPercentage
        SetSliderDialogStartValue(bind_GlobalPunishmentGoldPercentage.GetValue())
        SetSliderDialogDefaultValue(25)
        SetSliderDialogRange(5, 100)
        SetSliderDialogInterval(5)

    elseif option == sliderAdventuringPointCost
        SetSliderDialogStartValue(main.AdventuringPointCost)
        SetSliderDialogDefaultValue(0)
        SetSliderDialogRange(0, 5)
        SetSliderDialogInterval(1)

    elseif option == sliderAdventuringGoldGoal
        SetSliderDialogStartValue(main.AdventuringGoldGoal)
        SetSliderDialogDefaultValue(0)
        SetSliderDialogRange(0, 1000)
        SetSliderDialogInterval(25)


    EndIf

EndEvent

Event OnOptionSliderAccept(Int option, Float value)

    int i
    if selectedPage == "Bondage Outfits"
        int[] chances = JsonUtil.IntListToArray(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance")
        while i < sliderChance.Length
            if sliderChance[i] == option
                JsonUtil.IntListSet(main.BindingGameOutfitFile, selectedBondageOutfitId + "_random_bondage_chance", i, value as int)
                ;ForcePageReset()
            endif
            i += 1
        endwhile
    endif

    If option == sliderFurnitureHours
        main.PutOnDisplayHoursBetweenUse = (value as int)  
    ElseIf option == sliderFurnitureMin
        main.PutOnDisplayMinMinutes = (value as int)
        If main.PutOnDisplayMinMinutes >= main.PutOnDisplayMaxMinutes
            ;Debug.MessageBox("Higher than max minutes. Try again.")
            main.PutOnDisplayMaxMinutes = main.PutOnDisplayMinMinutes
        EndIf
    ElseIf option == sliderFurnitureMax
        main.PutOnDisplayMaxMinutes = (value as int)
        If main.PutOnDisplayMaxMinutes <= main.PutOnDisplayMinMinutes
            ;Debug.MessageBox("Lower than min minutes. Try again.")
            main.PutOnDisplayMinMinutes = main.PutOnDisplayMaxMinutes
        EndIf
    ElseIf option == sliderHarshBondageHours
        main.HarshBondageHoursBetweenUse = (value as int)
        bind_GlobalEventHarshBondageHoursBetween.SetValue(value as int)
    ElseIf option == sliderHarshBondageMin
        main.HarshBondageMinMinutes = (value as int)
        If main.HarshBondageMinMinutes >= main.HarshBondageMaxMinutes
            ;Debug.MessageBox("Higher than max minutes. Try again.")
            main.HarshBondageMaxMinutes = main.HarshBondageMinMinutes
        EndIf
    ElseIf option == sliderHarshBonadgeMax
        main.HarshBondageMaxMinutes = (value as int)
        If main.HarshBondageMaxMinutes <= main.HarshBondageMinMinutes
            ;Debug.MessageBox("Lower than min minutes. Try again.")
            main.HarshBondageMinMinutes = main.HarshBondageMaxMinutes
        EndIf
    ElseIf option == sliderInspectionsHours
        main.InspectionHoursBetween = (value as int)
    ElseIf option == sliderFurnitureChance
        main.PutOnDisplayChance = (value as int)
        bind_GlobalEventPutOnDisplayChance.SetValue(value)  
    ElseIf option == sliderFurnitureForSleep
        main.BedtimeFurnitureForSleep = (value as int)
    ElseIf option == sliderHarshBondageChance
        main.HarshBondageChance = (value as int)
        bind_GlobalEventHarshBondageChance.SetValue(value as int)
    ElseIf option == sliderInspectionsChance
        main.InspectionChance = (value as int)
        bind_GlobalEventInspectionChance.SetValue(value)
    elseif option == sliderWhippingChance
        main.WhippingChance = (value as int)
        main.bind_GlobalEventWhippingChance.SetValue(value)
    elseif option == sliderWhippingHours
        main.WhippingHoursBetween = (value as int)
    elseif option == sliderCampingChance
        main.CampingChance = (value as int)
        main.bind_GlobalEventCampingChance.SetValue(value)
    ElseIf option == sliderRulesChance
        bind_GlobalRulesChangeChance.SetValue(value as int)
    elseif option == sliderRulesHoursBetween
        bind_GlobalRulesHoursBetween.SetValue(value as int)
    
    ElseIf option == sliderRulesMinBehavior
        bind_GlobalRulesBehaviorMin.SetValue(value as int)
        if bind_GlobalRulesBehaviorMax.GetValue() < value
            bind_GlobalRulesBehaviorMax.SetValue(value as int)
        endif
    ElseIf option == sliderRulesMaxBehavior
        bind_GlobalRulesBehaviorMax.SetValue(value as int)
        if bind_GlobalRulesBehaviorMin.GetValue() > value
            bind_GlobalRulesBehaviorMin.SetValue(value as int)
        endif
    ElseIf option == sliderRulesMinBondage
        bind_GlobalRulesBondageMin.SetValue(value as int)
        if bind_GlobalRulesBondageMax.GetValue() < value
            bind_GlobalRulesBondageMax.SetValue(value as int)
        endif
    ElseIf option == sliderRulesMaxBondage
        bind_GlobalRulesBondageMax.SetValue(value as int)
        if bind_GlobalRulesBondageMin.GetValue() > value
            bind_GlobalRulesBondageMin.SetValue(value as int)
        endif


    ElseIf option == sliderDomArousal
        main.SexDomArousalLevelToTrigger = (value as int)
    ElseIf option == sliderChastityRemovalChance
        main.SexChanceOfChastityRemoval = (value as int)
    ElseIf option == sliderPointsMax
        main.PointsMax = (value as int)
    elseif option == sliderAdventuringSeconds
        main.AdventuringCheckAfterSeconds = value

    elseif option == sliderPunishmentMinGold
        bind_GlobalPunishmentMinGold.SetValue(value as int)
        If bind_GlobalPunishmentMinGold.GetValue() >= bind_GlobalPunishmentMaxGold.GetValue()
            bind_GlobalPunishmentMaxGold.SetValue(bind_GlobalPunishmentMinGold.GetValue())
        EndIf

    elseif option == sliderPunishmentMaxGold
        bind_GlobalPunishmentMaxGold.SetValue(value as int)
        If bind_GlobalPunishmentMaxGold.GetValue() <= bind_GlobalPunishmentMinGold.GetValue()
            bind_GlobalPunishmentMinGold.SetValue(bind_GlobalPunishmentMaxGold.GetValue())
        EndIf

    elseif option == sliderPunishmentGoldPercentage
        bind_GlobalPunishmentGoldPercentage.SetValue(value as int)

    elseif option == sliderAdventuringPointCost
        main.AdventuringPointCost = value as int

    elseif option == sliderAdventuringGoldGoal
        main.AdventuringGoldGoal = value as int

    Endif

    SetSliderOptionValue(option, value, "{0}")  
    
EndEvent

string[] function ConvertFormListToStringArray(FormList fml)
    string buffer = ""
    int i = 0
    while i < fml.GetSize()
        if buffer != ""
            buffer += "|"
        endif
        string devName = fml.GetAt(i).GetName()
        if StringUtil.GetLength(devName) > 50
            devName = StringUtil.SubString(devName, 0, 50)
        endif
        buffer += devName
        i += 1
    endwhile
    return StringUtil.Split(buffer, "|")
endfunction

Event OnOptionMenuOpen(int option)

    if selectedPage == "Bondage Outfits"

    endif    

    if option == menuSlaveryType
        SetMenuDialogOptions(slaveryTypes)
        SetMenuDialogStartIndex(main.SkryimNetSlaveryType)
    endif

    if option == menuSlaveryInSkyrim
        SetMenuDialogOptions(slaveryInSkyrimTypes)
        SetMenuDialogStartIndex(main.bind_GlobalSettingsSlaveryInSkyrim.GetValue() as int)
    endif

    if option == menuIndenturedServants
        SetMenuDialogOptions(indenturedServantsInSkyrimTypes)
        SetMenuDialogStartIndex(main.bind_GlobalSettingsIndenturedInSkyrim.GetValue() as int)
    endif

    if option == menuChangeLetter
        SetMenuDialogOptions(letters)
        SetMenuDialogStartIndex(letters.Find(selectedLetter))
    endif

    If option == menuHighKneelType
        SetMenuDialogOptions(idleTypes)
        SetMenuDialogStartIndex(idleTypes.Find(pman.GetHighKneel()))
    EndIf

    If option == menuHighKneelTypeBound
        SetMenuDialogOptions(idleTypes)
        SetMenuDialogStartIndex(idleTypes.Find(pman.GetHighKneel(true)))
    EndIf

    If option == menuDeepKneelType
        SetMenuDialogOptions(idleTypes)
        SetMenuDialogStartIndex(idleTypes.Find(pman.GetDeepKneel()))
    EndIf

    If option == menuDeepKneelTypeBound
        SetMenuDialogOptions(idleTypes)
        SetMenuDialogStartIndex(idleTypes.Find(pman.GetDeepKneel(true)))
    EndIf

    If option == menuSpreadKneelType
        SetMenuDialogOptions(idleTypes)
        SetMenuDialogStartIndex(idleTypes.Find(pman.GetSpreadKneel()))
    EndIf

    If option == menuSpreadKneelTypeBound
        SetMenuDialogOptions(idleTypes)
        SetMenuDialogStartIndex(idleTypes.Find(pman.GetSpreadKneel(true)))
    EndIf

    If option == menuAttentionType
        SetMenuDialogOptions(idleTypes)
        SetMenuDialogStartIndex(idleTypes.Find(pman.GetAttention()))
    EndIf

    If option == menuAttentionTypeBound
        SetMenuDialogOptions(idleTypes)
        SetMenuDialogStartIndex(idleTypes.Find(pman.GetAttention(true)))
    EndIf

    If option == menuPresentHandsType
        SetMenuDialogOptions(idleTypes)
        SetMenuDialogStartIndex(idleTypes.Find(pman.GetPresentHands()))
    EndIf

    If option == menuPresentHandsTypeBound
        SetMenuDialogOptions(idleTypes)
        SetMenuDialogStartIndex(idleTypes.Find(pman.GetPresentHands(true)))
    EndIf

    If option == menuShowAssType
        SetMenuDialogOptions(idleTypes)
        SetMenuDialogStartIndex(idleTypes.Find(pman.GetShowAss()))
    EndIf

    If option == menuShowAssTypeBound
        SetMenuDialogOptions(idleTypes)
        SetMenuDialogStartIndex(idleTypes.Find(pman.GetShowAss(true)))
    EndIf

    If option == menuConversationPoseType
        SetMenuDialogOptions(idleTypes)
        SetMenuDialogStartIndex(idleTypes.Find(pman.GetConversationPose()))
    EndIf

    If option == menuConversationPoseTypeBound
        SetMenuDialogOptions(idleTypes)
        SetMenuDialogStartIndex(idleTypes.Find(pman.GetConversationPose(true)))
    EndIf

    ; int i = 0
    ; while i < bondageTypes.Length
    ;     if option == bondageTypesMenu[i]
    ;         string[] itemsList = ConvertFormListToStringArray(bind_BondageList.GetAt(i) as FormList)
    ;         SetMenuDialogOptions(itemsList)
    ;         SetMenuDialogStartIndex(itemsList.Find(bmanage.GetFavoriteItemName(theSub, i)))
    ;     endif
    ;     i += 1
    ; endwhile

    If option == menuRulesControlType
        SetMenuDialogOptions(ruleManagementTypes)
        SetMenuDialogStartIndex(bind_GlobalRulesControlledBy.GetValue() as int)
    EndIf

    If option == menuMcmSaves
        SetMenuDialogOptions(savesList)
        SetMenuDialogStartIndex(0)
    EndIf

    if option == menuBondageOutfitsList

        ; StorageUtil.StringListClear(theSub, "bind_bondage_outfits_names_temp")

        ; bondageSetFileNames = MiscUtil.FilesInFolder(main.GameSaveFolder)

        ; ;debug.MessageBox(bondageSetFileNames)

        ; int i = 0
        ; while i < bondageSetFileNames.Length
        ;     string outfitName = JsonUtil.GetStringValue(main.GameSaveFolderJson + bondageSetFileNames[i], "bondage_outfit_name")
        ;     StorageUtil.StringListAdd(theSub, "bind_bondage_outfits_names_temp", outfitName)
        ;     ;StorageUtil.StringListAdd(theSubRef, "bind_bondage_outfit_file_list", bondageSetFileNames[i])
        ;     i += 1
        ; endwhile

        ; bondageSetNames = StorageUtil.StringListToArray(theSub, "bind_bondage_outfits_names_temp")

        bondageSetNames = JsonUtil.StringListToArray(main.BindingGameOutfitFile, "outfit_name_list")
        bondageSetIds = JsonUtil.IntListToArray(main.BindingGameOutfitFile, "outfit_id_list")

        ; StorageUtil.StringListClear(theSub, "bind_bondage_outfits_list")
        ; StorageUtil.StringListClear(theSub, "bind_bondage_files_list")
        ; ;string[] list = MiscUtil.FilesInFolder(main.GameSaveFolder)
        ; string[] list = StorageUtil.StringListToArray(theSub, "bind_bondage_outfit_file_list")
        ; ;debug.MessageBox(list)
        ; int i = 0
        ; while i < list.Length
        ;     StorageUtil.StringListAdd(theSub, "bind_bondage_outfits_list", JsonUtil.GetStringValue(main.GameSaveFolderJson + list[i], "bondage_outfit_name", ""))
        ;     StorageUtil.StringListAdd(theSub, "bind_bondage_files_list", list[i])
        ;     i += 1
        ; endwhile
        ; bondageSetNames = StorageUtil.StringListToArray(theSub, "bind_bondage_outfits_list")
        ; bondageSetFileNames = StorageUtil.StringListToArray(theSub, "bind_bondage_files_list")

        ;debug.MessageBox(bondageSetFileNames)

        SetMenuDialogOptions(bondageSetNames)
        SetMenuDialogStartIndex(bondageSetNames.Find(selectedBondageOutfit))

    endif

    if option == menuSearchResults
        SetMenuDialogOptions(searchResults)
        SetMenuDialogStartIndex(0)
    endif

EndEvent

Event OnOptionMenuAccept(int option, int index)

    if selectedPage == "Bondage Outfits"

    endif    

    if option == menuSlaveryType
        if main.SkryimNetSlaveryType != index
            main.SkryimNetSlaveryType = index
            main.bind_GlobalSettingsSubType.SetValue(index)
            SetMenuOptionValue(menuSlaveryType, SlaveryTypes[main.SkryimNetSlaveryType])
            ForcePageReset()
        endif
    endif

    if option == menuSlaveryInSkyrim
        if main.bind_GlobalSettingsSlaveryInSkyrim.GetValue() != index
            main.bind_GlobalSettingsSlaveryInSkyrim.SetValue(index)
            SetMenuOptionValue(menuSlaveryInSkyrim, slaveryInSkyrimTypes[main.bind_GlobalSettingsSlaveryInSkyrim.GetValue() as int])
            ForcePageReset()
        endif
    endif

    if option == menuIndenturedServants
        if main.bind_GlobalSettingsIndenturedInSkyrim.GetValue() != index
            main.bind_GlobalSettingsIndenturedInSkyrim.SetValue(index)
            SetMenuOptionValue(menuIndenturedServants, indenturedServantsInSkyrimTypes[main.bind_GlobalSettingsIndenturedInSkyrim.GetValue() as int])
            ForcePageReset()
        endif
    endif

    if option == menuChangeLetter
        if selectedLetter != letters[index]
            selectedLetter = letters[index]
            SetMenuOptionValue(menuChangeLetter, letters[index])
            ForcePageReset()
        endif
    endif

    If option == menuHighKneelType
        If pman.GetHighKneel() != idleTypes[index]
            pman.SetHighKneel(idleTypes[index])
            SetMenuOptionValue(menuHighKneelType, idleTypes[index])
        EndIf
    EndIf

    If option == menuHighKneelTypeBound
        If pman.GetHighKneel(true) != idleTypes[index]
            pman.SetHighKneel(idleTypes[index], true)
            SetMenuOptionValue(menuHighKneelTypeBound, idleTypes[index])
        EndIf
    EndIf

    If option == menuDeepKneelType
        If pman.GetDeepKneel() != idleTypes[index]
            pman.SetDeepKneel(idleTypes[index])
            SetMenuOptionValue(menuDeepKneelType, idleTypes[index])
        EndIf
    EndIf

    If option == menuDeepKneelTypeBound
        If pman.GetDeepKneel(true) != idleTypes[index]
            pman.SetDeepKneel(idleTypes[index], true)
            SetMenuOptionValue(menuDeepKneelTypeBound, idleTypes[index])
        EndIf
    EndIf

    If option == menuSpreadKneelType
        If pman.GetSpreadKneel() != idleTypes[index]
            pman.SetSpreadKneel(idleTypes[index])
            SetMenuOptionValue(menuSpreadKneelType, idleTypes[index])
        EndIf
    EndIf

    If option == menuSpreadKneelTypeBound
        If pman.GetSpreadKneel(true) != idleTypes[index]
            pman.SetSpreadKneel(idleTypes[index], true)
            SetMenuOptionValue(menuSpreadKneelTypeBound, idleTypes[index])
        EndIf
    EndIf

    If option == menuAttentionType
        If pman.GetAttention() != idleTypes[index]
            pman.SetAttention(idleTypes[index])
            SetMenuOptionValue(menuAttentionType, idleTypes[index])
        EndIf
    EndIf

    If option == menuAttentionTypeBound
        If pman.GetAttention(true) != idleTypes[index]
            pman.SetAttention(idleTypes[index], true)
            SetMenuOptionValue(menuAttentionTypeBound, idleTypes[index])
        EndIf
    EndIf

    If option == menuPresentHandsType
        If pman.GetPresentHands() != idleTypes[index]
            pman.SetPresentHands(idleTypes[index])
            SetMenuOptionValue(menuPresentHandsType, idleTypes[index])
        EndIf
    EndIf

    If option == menuPresentHandsTypeBound
        If pman.GetPresentHands(true) != idleTypes[index]
            pman.SetPresentHands(idleTypes[index], true)
            SetMenuOptionValue(menuPresentHandsTypeBound, idleTypes[index])
        EndIf
    EndIf

    If option == menuShowAssType
        If pman.GetShowAss() != idleTypes[index]
            pman.SetShowAss(idleTypes[index])
            SetMenuOptionValue(menuShowAssType, idleTypes[index])
        EndIf
    EndIf

    If option == menuShowAssTypeBound
        If pman.GetShowAss(true) != idleTypes[index]
            pman.SetShowAss(idleTypes[index], true)
            SetMenuOptionValue(menuShowAssTypeBound, idleTypes[index])
        EndIf
    EndIf

    If option == menuConversationPoseType
        If pman.GetConversationPose() != idleTypes[index]
            pman.SetConversationPose(idleTypes[index])
            SetMenuOptionValue(menuConversationPoseType, idleTypes[index])
        EndIf
    EndIf

    If option == menuConversationPoseTypeBound
        If pman.GetConversationPose(true) != idleTypes[index]
            pman.SetConversationPose(idleTypes[index], true)
            SetMenuOptionValue(menuConversationPoseTypeBound, idleTypes[index])
        EndIf
    EndIf

    ; int i = 0
    ; while i < bondageTypes.Length
    ;     if option == bondageTypesMenu[i] && index >= 0
    ;         ;bind_Utility.WriteToConsole("i: " + i + " index: " + index)
    ;         FormList fml = bind_BondageList.GetAt(i) as FormList
    ;         ;bind_Utility.WriteToConsole("fml: " + fml)
    ;         string[] itemsList = ConvertFormListToStringArray(fml)
    ;         Form dev = fml.GetAt(index) as Form
    ;         ;bind_Utility.WriteToConsole("dev: " + dev)
    ;         bmanage.StoreFavoriteItem(theSub, i, dev)
    ;         if bmanage.GetStoredItem(theSub, i)
    ;             ;update if this is equipped
    ;             bind_GlobalRulesUpdatedFlag.SetValue(1)
    ;         endif            
    ;         SetMenuOptionValue(bondageTypesMenu[i], itemsList[index])
    ;     endif
    ;     i += 1
    ; endwhile

    If option == menuRulesControlType
        If bind_GlobalRulesControlledBy.GetValue() != index
            bind_GlobalRulesControlledBy.SetValue(index)
            selectedRuleManagementType = ruleManagementTypes[index]
            SetMenuOptionValue(menuRulesControlType, selectedRuleManagementType)
        EndIf
    EndIf

    If option == menuMcmSaves
        selectedSave = savesList[index]
        SetMenuOptionValue(menuMcmSaves, savesList[index])
    EndIf

    if option == menuBondageOutfitsList

        ; string fileName = main.GameSaveFolderJson + bondageSetFileNames[index]

        ; ;ShowMessage(fileName, false)

        ; selectedBondageOutfit = JsonUtil.GetStringValue(fileName, "bondage_outfit_name", "") ;bondageSetNames[index]
        ; selectedBondageOutfitId = JsonUtil.GetIntValue(fileName, "outfit_id", 0) ;bondageSetIds[index]
        ; ;selectedBondageOutfitIndex = index
        
        ; bondageOutfitFile = fileName ;main.GameSaveFolderJson + "/bind_bondage_outfit_" + selectedBondageOutfitId + ".json"

        selectedBondageOutfit = bondageSetNames[index]
        selectedBondageOutfitId = bondageSetIds[index]
        currentBondageOutfitIndex = index

        ;SetMenuOptionValue(menuBondageOutfitsList, bondageSetNames[index])
        ForcePageReset()

    endif

    if option == menuSearchResults
        selectedFoundItem = searchResults[index]
        selectedFoundItemId = index
        SetMenuOptionValue(menuSearchResults, selectedFoundItem)
    endif

EndEvent

string Function DisplayBoolean(int v)
    If v == 1
        return "Yes"
    Else
        return "No"
    EndIf
EndFunction

int Function ToggleValue(int v)
    If v == 0
        return 1
    Else
        return 0
    EndIf
EndFunction

bind_MainQuestScript property main auto
bind_BondageManager property bmanage auto
bind_ThinkingDom property brain auto
bind_GearManager property gmanage auto
bind_FurnitureManager property fmanage auto
bind_PoseManager property pman auto
bind_RulesManager property rman auto
bind_SexManager property sms auto
bind_Functions property fs auto

GlobalVariable property bind_GlobalModState auto
GlobalVariable property bind_GlobalActionKey auto

GlobalVariable property bind_GlobalPreferenceRequireKneeling auto

GlobalVariable property bind_GlobalRulesControlledBy auto

GlobalVariable property bind_GlobalEventHarshBondageChance auto
GlobalVariable property bind_GlobalEventHarshBondageHoursBetween auto

GlobalVariable property bind_GlobalEventInspectionChance auto

GlobalVariable property bind_GlobalEventPutOnDisplayChance auto

GlobalVariable property bind_GlobalInfractions auto
GlobalVariable property bind_GlobalTimesInfractionsNotNoticed auto
GlobalVariable property bind_GlobalTimesInfractionsConfessed auto
GlobalVariable property bind_GlobalTimesPunished auto
GlobalVariable property bind_GlobalPoints auto

GlobalVariable property bind_GlobalRulesUpdatedFlag auto
GlobalVariable property bind_GlobalRulesNudityRequired auto
GlobalVariable property bind_GlobalRulesBondageMin auto
GlobalVariable property bind_GlobalRulesBondageMax auto
GlobalVariable property bind_GlobalRulesBehaviorMin auto
GlobalVariable property bind_GlobalRulesBehaviorMax auto
GlobalVariable property bind_GlobalRulesHoursBetween auto
GlobalVariable property bind_GlobalRulesChangeChance auto

GlobalVariable property bind_GlobalPunishmentMinGold auto
GlobalVariable property bind_GlobalPunishmentMaxGold auto
GlobalVariable property bind_GlobalPunishmentGoldPercentage auto

GlobalVariable property bind_GlobalKneelingOK auto

FormList property bind_BondageList auto
FormList property bind_BondageRulesFactionList auto

Quest property bind_RulesCheckQuest auto
Quest property bind_DefeatedQuest auto

Faction property bind_MilkSlaveFaction auto
GlobalVariable property bind_GlobalMilkTriggerRun auto

string[] Function McmGetSaveList()

    return JsonUtil.JsonInFolder("/binding/mcm/")

EndFunction

;Save Function
Function McmSaveFunction()

    UIExtensions.InitMenu("UITextEntryMenu")
    UIExtensions.OpenMenu("UITextEntryMenu")
    string result = UIExtensions.GetMenuResultString("UITextEntryMenu")

    ;debug.MessageBox("save name " + result)

    if result != ""
        string saveFileName = "/binding/mcm/" + result + ".json"

        ;debug
        JsonUtil.SetPathIntValue(saveFileName, "debug_actionkey", bind_GlobalActionKey.GetValue() as int)
        JsonUtil.SetPathIntValue(saveFileName, "debug_actionkeymodifier", main.actionKeyModifier)

        ;sex
        JsonUtil.SetPathIntValue(saveFileName, "sex_freeuse", main.SexFreeUse)
        JsonUtil.SetPathIntValue(saveFileName, "sex_domarousallevel", main.SexDomArousalLevelToTrigger)
        JsonUtil.SetPathIntValue(saveFileName, "sex_chastityremoval", main.SexChanceOfChastityRemoval)

        ;poses
        JsonUtil.SetPathStringValue(saveFileName, "pose_highkneel", pman.GetHighKneel())
        JsonUtil.SetPathStringValue(saveFileName, "pose_highkneelbound", pman.GetHighKneel(true))
        JsonUtil.SetPathStringValue(saveFileName, "pose_deepkneel", pman.GetDeepKneel())
        JsonUtil.SetPathStringValue(saveFileName, "pose_deepkneelbound", pman.GetDeepKneel(true))
        JsonUtil.SetPathStringValue(saveFileName, "pose_spreadkneel", pman.GetSpreadKneel())
        JsonUtil.SetPathStringValue(saveFileName, "pose_spreadkneelbound", pman.GetSpreadKneel(true))
        JsonUtil.SetPathStringValue(saveFileName, "pose_attention", pman.GetAttention())
        JsonUtil.SetPathStringValue(saveFileName, "pose_attentionbound", pman.GetAttention(true))
        JsonUtil.SetPathStringValue(saveFileName, "pose_presenthands", pman.GetPresentHands())
        JsonUtil.SetPathStringValue(saveFileName, "pose_presenthandsbound", pman.GetPresentHands(true))
        JsonUtil.SetPathStringValue(saveFileName, "pose_showass", pman.GetShowAss())
        JsonUtil.SetPathStringValue(saveFileName, "pose_showassbound", pman.GetShowAss(true))
        JsonUtil.SetPathStringValue(saveFileName, "pose_conversation", pman.GetConversationPose())
        JsonUtil.SetPathStringValue(saveFileName, "pose_conversationbound", pman.GetConversationPose(true))

        ;rules
        JsonUtil.SetPathIntValue(saveFileName, "rules_nudity_required", bind_GlobalRulesNudityRequired.GetValue() as int)
        JsonUtil.SetPathIntValue(saveFileName, "rules_control", bind_GlobalRulesControlledBy.GetValue() as int)
        JsonUtil.SetPathIntValue(saveFileName, "rules_pointsmax", main.PointsMax)
        JsonUtil.SetPathIntValue(saveFileName, "rules_earn_sex", main.PointsEarnFromSex)
        JsonUtil.SetPathIntValue(saveFileName, "rules_earn_harsh", main.PointsEarnFromHarshBondage)
        JsonUtil.SetPathIntValue(saveFileName, "rules_earn_furniture", main.PointsEarnFromFurniture)
        JsonUtil.SetPathIntValue(saveFileName, "rules_earn_good", main.PointsEarnFromBeingGood)
        JsonUtil.SetPathIntValue(saveFileName, "rule_cleanhome", main.RuleMustCleanPlayerHome)

        ;string[] bRuleList = rman.GetBehaviorRuleNameArray()
        ;behaviorSettings = rman.GetBehaviorRulesSettingsList()
        ;behaviorHard = rman.GetBehaviorHardLimitsList()
    
        int i = 0
        while i < rman.GetBehaviorRulesCount()
            JsonUtil.SetPathIntValue(saveFileName, "rule_behavior_setting_" + i, rman.GetBehaviorRule(theSub, i))
            JsonUtil.SetPathIntValue(saveFileName, "rule_behavior_hard_" + i, rman.GetBehaviorRuleOption(theSub, i))
            i += 1
        endwhile

        ;string[] bondageList = rman.GetBondageRulesList()
        ;int[] bondageSettings = rman.GetBondageRulesSettingsList()
        ;int[] bondageHard = rman.GetBondageHardLimitsList()
    
        i = 0
        while i < rman.GetBondageRulesCount()
            JsonUtil.SetPathIntValue(saveFileName, "rule_bondage_setting_" + i, rman.GetBondageRule(theSub, i))
            JsonUtil.SetPathIntValue(saveFileName, "rule_bondage_hard_" + i, rman.GetBondageRuleOption(theSub, i))
            i += 1
        endwhile
    
        ;bondage
        JsonUtil.SetPathIntValue(saveFileName, "boundsex_cuffs", sms.BoundSexCuffs)
        JsonUtil.SetPathIntValue(saveFileName, "boundsex_heavy", sms.BoundSexHeavyBondage)
        JsonUtil.SetPathIntValue(saveFileName, "boundsex_gag", sms.BoundSexGag)
        JsonUtil.SetPathIntValue(saveFileName, "boundsex_blindfold", sms.BoundSexBlindfold)
        JsonUtil.SetPathIntValue(saveFileName, "boundsex_hood", sms.BoundSexHood)
        JsonUtil.SetPathIntValue(saveFileName, "boundsex_aplug", sms.BoundSexAPlug)
        JsonUtil.SetPathIntValue(saveFileName, "boundsex_vplug", sms.BoundSexVPlug)

        JsonUtil.SetPathIntValue(saveFileName, "boundmasturbation_cuffs", sms.BoundMasturbationCuffs)
        JsonUtil.SetPathIntValue(saveFileName, "boundmasturbation_gag", sms.BoundMasturbationGag)
        JsonUtil.SetPathIntValue(saveFileName, "boundmasturbation_blindfold", sms.BoundMasturbationBlindfold)
        JsonUtil.SetPathIntValue(saveFileName, "boundmasturbation_hood", sms.BoundMasturbationHood)
        JsonUtil.SetPathIntValue(saveFileName, "boundmasturbation_aplug", sms.BoundMasturbationAPlug)
        JsonUtil.SetPathIntValue(saveFileName, "boundmasturbation_vplug", sms.BoundMasturbationVPlug)
        JsonUtil.SetPathIntValue(saveFileName, "boundmasturbation_unties", sms.BoundMasturbationUnties)

        JsonUtil.SetPathIntValue(saveFileName, "harshbondage_boots", bmanage.HarshBondageUseBoots)
        JsonUtil.SetPathIntValue(saveFileName, "harshbondage_ankles", bmanage.HarshBondageUseAnkles)
        JsonUtil.SetPathIntValue(saveFileName, "harshbondage_collar", bmanage.HarshBondageUseCollar)
        JsonUtil.SetPathIntValue(saveFileName, "harshbondage_nipple", bmanage.HarshBondageUseNipple)
        JsonUtil.SetPathIntValue(saveFileName, "harshbondage_chastity", bmanage.HarshBondageUseChastity)
        JsonUtil.SetPathIntValue(saveFileName, "bedtime_usehood", bmanage.BedtimeUseHood)

        InitBondageTypesArray()
        string skeyf = "bind_favorite_dd_"
        i = 0
        while i < bondageTypes.Length
            bind_Utility.WriteToConsole("writing bondage favorites: " + i)
            Form[] favorites1 = StorageUtil.FormListToArray(theSub, skeyf + i + "_1")
            Form[] favorites2 = StorageUtil.FormListToArray(theSub, skeyf + i + "_2")
            Form[] favorites3 = StorageUtil.FormListToArray(theSub, skeyf + i + "_3")
            JsonUtil.SetPathFormArray(saveFileName, "favorite_bondage_" + i + "_1", favorites1)
            JsonUtil.SetPathFormArray(saveFileName, "favorite_bondage_" + i + "_2", favorites2)
            JsonUtil.SetPathFormArray(saveFileName, "favorite_bondage_" + i + "_3", favorites3)
            ; Form dev = bmanage.GetFavoriteItem(theSub, i)
            ; if dev
            ;     JsonUtil.SetPathFormValue(saveFileName, "favorite_bondage_" + i, dev)
            ; endif
            i += 1
        endwhile

        ;gear
        string[] slotNames = gmanage.GetSlotMaskNames()
        int[] slotProtections = gmanage.GetSlotProtections()
       
        i = 0
        while i < slotNames.Length
            JsonUtil.SetPathIntValue(saveFileName, "strip_protection_" + i, slotProtections[i])
            i += 1
        endwhile

        ;preferences
        JsonUtil.SetPathIntValue(saveFileName, "dp_untiedanger", main.DomPreferenceUntieForDangerousAreas)
        JsonUtil.SetPathIntValue(saveFileName, "dp_dressdanger", main.DomPreferenceDressForDangerousAreas)
        JsonUtil.SetPathIntValue(saveFileName, "dp_untieoutsidecity", main.DomPreferenceUntieHandsOutsideOfCitiesAndTowns)
        JsonUtil.SetPathIntValue(saveFileName, "dp_dressoutsidecity", main.DomPreferenceDressOutsideOfCitiesAndTowns)
        JsonUtil.SetPathIntValue(saveFileName, "dp_furniture", main.PutOnDisplayRandomUse)
        JsonUtil.SetPathIntValue(saveFileName, "dp_furniturehours", main.PutOnDisplayHoursBetweenUse)
        JsonUtil.SetPathIntValue(saveFileName, "dp_furniturechance", main.PutOnDisplayChance)
        JsonUtil.SetPathIntValue(saveFileName, "dp_furnituremin", main.PutOnDisplayMinMinutes)
        JsonUtil.SetPathIntValue(saveFileName, "dp_furnituremax", main.PutOnDisplayMaxMinutes)
        JsonUtil.SetPathIntValue(saveFileName, "dp_furnituresleep", main.BedtimeFurnitureForSleep)
        JsonUtil.SetPathIntValue(saveFileName, "dp_harsh", main.HarshBondageRandomUse)
        JsonUtil.SetPathIntValue(saveFileName, "dp_harshhours", main.HarshBondageHoursBetweenUse)
        JsonUtil.SetPathIntValue(saveFileName, "dp_harshchance", main.HarshBondageChance)
        JsonUtil.SetPathIntValue(saveFileName, "dp_harshmin", main.HarshBondageMinMinutes)
        JsonUtil.SetPathIntValue(saveFileName, "dp_harshmax", main.HarshBondageMaxMinutes)
        JsonUtil.SetPathIntValue(saveFileName, "dp_inspect", main.InspectionsRandomUse)
        JsonUtil.SetPathIntValue(saveFileName, "dp_inspecthours", main.InspectionHoursBetween)
        JsonUtil.SetPathIntValue(saveFileName, "dp_inspectchance", main.InspectionChance)
        JsonUtil.SetPathIntValue(saveFileName, "dp_cleansub", main.DomPreferenceCleanSub)
        JsonUtil.SetPathIntValue(saveFileName, "dp_gagsunplug", main.DomOnlyUnplugsPanelGags)
        JsonUtil.SetPathIntValue(saveFileName, "dp_rules_perhour", main.RulesChancePerHour)
        JsonUtil.SetPathIntValue(saveFileName, "dp_rules_max", main.RulesMaxNumber)
        JsonUtil.SetPathIntValue(saveFileName, "preference_freefollowerdimissed", main.PreferenceFreeWhenDismissedDisabled)
        JsonUtil.SetPathIntValue(saveFileName, "dp_usewordwall", main.DomUseWordWallEvent)
        JsonUtil.SetPathIntValue(saveFileName, "gp_anynpccandom", main.GameplayAnyNpcCanDom)

        JsonUtil.Save(saveFileName)


        bind_Utility.WriteToConsole("Binding MCM settings saved to " + saveFileName)

    else

        bind_Utility.WriteToConsole("No save name was entered.")

    endif

EndFunction

; Load Function
Function McmLoadFunction(string saveFileName)

    if saveFileName == ""
        return
    endif

    saveFileName = "/binding/mcm/" + saveFileName
    
    ;debug
    bind_GlobalActionKey.SetValue(JsonUtil.GetPathIntValue(saveFileName, "debug_actionkey"))
    main.ActionKeyModifier = JsonUtil.GetPathIntValue(saveFileName, "debug_actionkeymodifier")

    ;sex settings
    main.SexFreeUse = JsonUtil.GetPathIntValue(saveFileName, "sex_freeuse")
    main.SexDomArousalLevelToTrigger = JsonUtil.GetPathIntValue(saveFileName, "sex_domarousallevel")
    main.SexChanceOfChastityRemoval = JsonUtil.GetPathIntValue(saveFileName, "sex_chastityremoval")
    pman.SetHighKneel(JsonUtil.GetPathStringValue(saveFileName, "pose_highkneel"))
    pman.SetHighKneel(JsonUtil.GetPathStringValue(saveFileName, "pose_highkneelbound"),true)
    pman.SetDeepKneel(JsonUtil.GetPathStringValue(saveFileName, "pose_deepkneel"))
    pman.SetDeepKneel(JsonUtil.GetPathStringValue(saveFileName, "pose_deepkneelbound"),true)
    pman.SetSpreadKneel(JsonUtil.GetPathStringValue(saveFileName, "pose_spreadkneel"))
    pman.SetSpreadKneel(JsonUtil.GetPathStringValue(saveFileName, "pose_spreadkneelbound"),true)
    pman.SetAttention(JsonUtil.GetPathStringValue(saveFileName, "pose_attention"))
    pman.SetAttention(JsonUtil.GetPathStringValue(saveFileName, "pose_attentionbound"),true)
    pman.SetPresentHands(JsonUtil.GetPathStringValue(saveFileName, "pose_presenthands"))
    pman.SetPresentHands(JsonUtil.GetPathStringValue(saveFileName, "pose_presenthandsbound"),true)
    pman.SetShowAss(JsonUtil.GetPathStringValue(saveFileName, "pose_showass"))
    pman.SetShowAss(JsonUtil.GetPathStringValue(saveFileName, "pose_showassbound"),true)
    pman.SetConversationPose(JsonUtil.GetPathStringValue(saveFileName, "pose_conversation"))
    pman.SetConversationPose(JsonUtil.GetPathStringValue(saveFileName, "pose_conversationbound"), true)

    ;bondage settings
    sms.BoundSexCuffs = JsonUtil.GetPathIntValue(saveFileName, "boundsex_cuffs")
    sms.BoundSexHeavyBondage = JsonUtil.GetPathIntValue(saveFileName, "boundsex_heavy")
    sms.BoundSexGag = JsonUtil.GetPathIntValue(saveFileName, "boundsex_gag")
    sms.BoundSexBlindfold = JsonUtil.GetPathIntValue(saveFileName, "boundsex_blindfold")
    sms.BoundSexHood = JsonUtil.GetPathIntValue(saveFileName, "boundsex_hood")
    sms.BoundSexAPlug = JsonUtil.GetPathIntValue(saveFileName, "boundsex_aplug")
    sms.BoundSexVPlug = JsonUtil.GetPathIntValue(saveFileName, "boundsex_vplug")

    sms.BoundMasturbationCuffs = JsonUtil.GetPathIntValue(saveFileName, "boundmasturbation_cuffs")
    sms.BoundMasturbationGag = JsonUtil.GetPathIntValue(saveFileName, "boundmasturbation_gag")
    sms.BoundMasturbationBlindfold = JsonUtil.GetPathIntValue(saveFileName, "boundmasturbation_blindfold")
    sms.BoundMasturbationHood = JsonUtil.GetPathIntValue(saveFileName, "boundmasturbation_hood")
    sms.BoundMasturbationAPlug = JsonUtil.GetPathIntValue(saveFileName, "boundmasturbation_aplug")
    sms.BoundMasturbationVPlug = JsonUtil.GetPathIntValue(saveFileName, "boundmasturbation_vplug")
    sms.BoundMasturbationUnties = JsonUtil.GetPathIntValue(saveFileName, "boundmasturbation_unties")

    bmanage.HarshBondageUseBoots = JsonUtil.GetPathIntValue(saveFileName, "harshbondage_boots")
    bmanage.HarshBondageUseAnkles = JsonUtil.GetPathIntValue(saveFileName, "harshbondage_ankles")
    bmanage.HarshBondageUseCollar = JsonUtil.GetPathIntValue(saveFileName, "harshbondage_collar")
    bmanage.HarshBondageUseNipple = JsonUtil.GetPathIntValue(saveFileName, "harshbondage_nipple")
    bmanage.HarshBondageUseChastity = JsonUtil.GetPathIntValue(saveFileName, "harshbondage_chastity")
    bmanage.BedtimeUseHood = JsonUtil.GetPathIntValue(saveFileName, "bedtime_usehood")

    InitBondageTypesArray()
    string skeyf = "bind_favorite_dd_"
    int i = 0
    while i < bondageTypes.Length
        bind_Utility.WriteToConsole("reading bondage favorites: " + i)

        Form[] favorites1 = JsonUtil.PathFormElements(saveFileName, "favorite_bondage_" + i + "_1")  ;StorageUtil.FormListToArray(theSub, skeyf + i + "_1")
        Form[] favorites2 = JsonUtil.PathFormElements(saveFileName, "favorite_bondage_" + i + "_2")  ;StorageUtil.FormListToArray(theSub, skeyf + i + "_2")
        Form[] favorites3 = JsonUtil.PathFormElements(saveFileName, "favorite_bondage_" + i + "_3")  ;StorageUtil.FormListToArray(theSub, skeyf + i + "_3")
        
        StorageUtil.FormListCopy(theSub, skeyf + i + "_1", favorites1)
        StorageUtil.FormListCopy(theSub, skeyf + i + "_2", favorites2)
        StorageUtil.FormListCopy(theSub, skeyf + i + "_3", favorites3)

        ; Form dev = JsonUtil.GetPathFormValue(saveFileName, "favorite_bondage_" + i)
        ; if dev
        ;     bmanage.StoreFavoriteItem(theSub, i, dev)
        ; endif
        i += 1
    endwhile

    ;rules
    bind_GlobalRulesNudityRequired.SetValue(JsonUtil.GetPathIntValue(saveFileName, "rules_nudity_required"))
    bind_GlobalRulesControlledBy.SetValue(JsonUtil.GetPathIntValue(saveFileName, "rules_control"))
    main.PointsMax = JsonUtil.GetPathIntValue(saveFileName, "rules_pointsmax")
    main.PointsEarnFromSex = JsonUtil.GetPathIntValue(saveFileName, "rules_earn_sex")
    main.PointsEarnFromHarshBondage = JsonUtil.GetPathIntValue(saveFileName, "rules_earn_harsh")
    main.PointsEarnFromFurniture = JsonUtil.GetPathIntValue(saveFileName, "rules_earn_furniture")
    main.PointsEarnFromBeingGood = JsonUtil.GetPathIntValue(saveFileName, "rules_earn_good")
    main.RuleMustCleanPlayerHome = JsonUtil.GetPathIntValue(saveFileName, "rule_cleanhome")

    ; behaviorList = rman.GetBehaviorRulesList()

    ; i = 0
    ; while i < behaviorList.Length
    ;     rman.SetBehaviorRuleSettingByIndex(i, JsonUtil.GetPathIntValue(saveFileName, "rule_behavior_setting_" + i, 0))
    ;     rman.SetBehaviorHardLimitByIndex(i, JsonUtil.GetPathIntValue(saveFileName, "rule_behavior_hard_" + i, 0))        
    ;     i += 1
    ; endwhile

    ; string[] bondageList = rman.GetBondageRulesList()

    ; i = 0
    ; while i < bondageList.Length
    ;     rman.SetBondageRuleSettingByIndex(i, JsonUtil.GetPathIntValue(saveFileName, "rule_bondage_setting_" + i, 0))
    ;     rman.SetBondageHardLimitByIndex(i, JsonUtil.GetPathIntValue(saveFileName, "rule_bondage_hard_" + i, 0))     
    ;     i += 1
    ; endwhile

    i = 0
    while i < rman.GetBehaviorRulesCount()
        rman.SetBehaviorRule(theSub, i, JsonUtil.GetPathIntValue(saveFileName, "rule_behavior_setting_" + i))
        rman.SetBehaviorRuleOption(theSub, i, JsonUtil.GetPathIntValue(saveFileName, "rule_behavior_hard_" + i))
        i += 1
    endwhile

    ;string[] bondageList = rman.GetBondageRulesList()
    ;int[] bondageSettings = rman.GetBondageRulesSettingsList()
    ;int[] bondageHard = rman.GetBondageHardLimitsList()

    i = 0
    while i < rman.GetBondageRulesCount()
        rman.SetBondageRule(theSub, i, JsonUtil.GetPathIntValue(saveFileName, "rule_bondage_setting_" + i))
        rman.SetBondageRuleOption(theSub, i, JsonUtil.GetPathIntValue(saveFileName, "rule_bondage_hard_" + i))
        i += 1
    endwhile


    ;gear
    string[] slotNames = gmanage.GetSlotMaskNames()
    
    i = 0
    while i < slotNames.Length
        gmanage.SetSlotProtection(i, JsonUtil.GetPathIntValue(saveFileName, "strip_protection_" + i, 0))
        i += 1
    endwhile

    ;preferences
    main.DomPreferenceUntieForDangerousAreas = JsonUtil.GetPathIntValue(saveFileName, "dp_untiedanger")
    main.DomPreferenceDressForDangerousAreas = JsonUtil.GetPathIntValue(saveFileName, "dp_dressdanger")
    main.DomPreferenceUntieHandsOutsideOfCitiesAndTowns = JsonUtil.GetPathIntValue(saveFileName, "dp_untieoutsidecity")
    main.DomPreferenceDressOutsideOfCitiesAndTowns = JsonUtil.GetPathIntValue(saveFileName, "dp_dressoutsidecity")
    main.PutOnDisplayRandomUse = JsonUtil.GetPathIntValue(saveFileName, "dp_furniture")
    main.PutOnDisplayHoursBetweenUse = JsonUtil.GetPathIntValue(saveFileName, "dp_furniturehours")
    main.PutOnDisplayChance = JsonUtil.GetPathIntValue(saveFileName, "dp_furniturechance")
    main.PutOnDisplayMinMinutes = JsonUtil.GetPathIntValue(saveFileName, "dp_furnituremin")
    main.PutOnDisplayMaxMinutes = JsonUtil.GetPathIntValue(saveFileName, "dp_furnituremax")
    main.BedtimeFurnitureForSleep = JsonUtil.GetPathIntValue(saveFileName, "dp_furnituresleep")
    main.HarshBondageRandomUse = JsonUtil.GetPathIntValue(saveFileName, "dp_harsh")
    main.HarshBondageHoursBetweenUse = JsonUtil.GetPathIntValue(saveFileName, "dp_harshhours")
    main.HarshBondageChance = JsonUtil.GetPathIntValue(saveFileName, "dp_harshchance")
    main.HarshBondageMinMinutes = JsonUtil.GetPathIntValue(saveFileName, "dp_harshmin")
    main.HarshBondageMaxMinutes = JsonUtil.GetPathIntValue(saveFileName, "dp_harshmax")
    main.InspectionsRandomUse = JsonUtil.GetPathIntValue(saveFileName, "dp_inspect")
    main.InspectionHoursBetween = JsonUtil.GetPathIntValue(saveFileName, "dp_inspecthours")
    main.InspectionChance = JsonUtil.GetPathIntValue(saveFileName, "dp_inspectchance")
    main.DomPreferenceCleanSub = JsonUtil.GetPathIntValue(saveFileName, "dp_cleansub")
    main.DomOnlyUnplugsPanelGags = JsonUtil.GetPathIntValue(saveFileName, "dp_gagsunplug")
    main.RulesChancePerHour = JsonUtil.GetPathIntValue(saveFileName, "dp_rules_perhour")
    main.RulesMaxNumber = JsonUtil.GetPathIntValue(saveFileName, "dp_rules_max")
    main.PreferenceFreeWhenDismissedDisabled = JsonUtil.GetPathIntValue(saveFileName, "preference_freefollowerdimissed")
    main.DomUseWordWallEvent = JsonUtil.GetPathIntValue(saveFileName, "dp_usewordwall")
    main.GameplayAnyNpcCanDom = JsonUtil.GetPathIntValue(saveFileName, "gp_anynpccandom")

    bind_Utility.WriteToConsole("Binding MCM settings loaded from " + saveFileName)

EndFunction

string function GetModifierString(int modifierValue)
    string modifierStr = "None"
    if modifierValue == keyCodeLeftAlt
        modifierStr = "Left Alt"
    elseif modifierValue == keyCodeRightAlt
        modifierStr = "Right Alt"
    elseif modifierValue == keyCodeLeftShift
        modifierStr = "Left Shift"
    elseif modifierValue == keyCodeRightShift
        modifierStr = "Right Shift"
    elseif modifierValue == keyCodeRightControl
        modifierStr = "Right Control"
    endif
    return modifierStr
endfunction

int function AdvanceModifierValue(int currentModifier)
    int newModifier = 0
    if currentModifier == 0
        newModifier = keyCodeLeftAlt
    elseif currentModifier == keyCodeLeftAlt
        newModifier = keyCodeRightAlt
    elseif currentModifier == keyCodeRightAlt
        newModifier = keyCodeLeftShift
    elseif currentModifier == keyCodeLeftShift
        newModifier = keyCodeRightShift
    elseif currentModifier == keyCodeRightShift
        newModifier = keyCodeRightControl
    elseif currentModifier == keyCodeRightControl
        newModifier = 0
    endif
    return newModifier
endfunction

bool madeArrays

function MakeArrays()

    bool refresh = true

    if bondageOutfitUsageKey.Length != 33 || refresh

        bondageSetUsedForToggle = new int[33]

        ;bondageOutfitUsageKey = new string[33]        
        string temp = "location_all_areas|location_any_city|location_dawnstar|location_falkreath|location_windhelm|location_markarth|location_morthal|location_riften|"
        temp += "location_solitude|location_high_hrothgar|location_whiterun|location_winterhold|location_raven Rock|location_towns|location_player_home|location_safe_area|"
        temp += "location_unsafe_area|location_inn|event_any_event|event_harsh_bondage|event_bound_masturbation|event_bound_sex|event_dairy|event_bound_sleep|event_camping|"
        temp += "event_put_on_display|event_public_humilation|event_whipping|event_souls_from_bones|event_word_wall|event_gagged_for_punishment|event_go_adventuring|event_free_for_work"
        bondageOutfitUsageKey = StringUtil.Split(temp, "|")
        
        ;bondageOutfitUsageList = new string[32]
        temp = "Location - All Areas|Location - Any City|Location - Dawnstar|Location - Falkreath|Location - Windhelm|Location - Markarth|Location - Morthal|Location - Riften"
        temp += "|Location - Solitude|Location - High Hrothgar|Location - Whiterun|Location - Winterhold|Location - Raven Rock |Location - Towns|Location - Player Home|Location - Safe Areas"
        temp += "|Location - Unsafe Areas|Location - Inn|Event - Any Event|Event - Harsh Bondage|Event - Bound Masturbation|Event - Bound Sex|Event - Dairy|Event - Bound Sleep|Event - Camping"
        temp += "|Event - Put On Display|Event - Public Humliation|Event - Whipping|Event - Souls From Bones|Event - Word Wall|Event - Gagged For Punishment|Event - Go Adventuring"
        temp += "|Event - Free For Work"
        bondageOutfitUsageList = StringUtil.Split(temp, "|")

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

        bondageOutfitBlockToggle = new int[13]

        bondageSetRemoveDdToggle = new int[25]
        bondageSetRemoveGearToggle = new int[25]

        sliderChance = new int[13]

   endif

endfunction