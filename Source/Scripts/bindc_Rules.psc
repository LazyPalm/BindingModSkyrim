Scriptname bindc_Rules extends Quest conditional

;constants
int property DESTINATION_TYPE_INN = 1 autoReadOnly
int property DESTINATION_TYPE_CASTLE = 2 autoReadOnly
int property DESTINATION_TYPE_PLAYERHOME = 3 autoReadOnly

int property RULES_SUB_MANAGED = 0 autoReadOnly
int property RULES_DOM_MANAGED = 1 autoReadOnly
int property RULES_HYBRID_MANAGED = 2 autoReadOnly

int property RULE_TYPE_BEHAVIOR = 1 autoReadOnly
int property RULE_TYPE_BONDAGE = 2 autoReadOnly

int property RULE_OPTION_HARD_LIMIT = 1 autoReadOnly
int property RULE_OPTION_SAFE_AREAS = 2 autoReadOnly
int property RULE_OPTION_PERMANENT = 3 autoReadOnly
int property RULE_OPTION_PERMANENT_SAFE_AREAS = 4 autoReadOnly
int property RULE_OPTION_UNSAFE_AREAS = 5 autoReadOnly
int property RULE_OPTION_PERMANENT_UNSAFE_AREAS = 6 autoReadOnly

int property BEHAVIOR_RULE_NUDITY = 0 autoReadOnly
int property BEHAVIOR_RULE_NO_BED = 1 autoReadOnly
int property BEHAVIOR_RULE_DISMISSED = 2 autoReadOnly
int property BEHAVIOR_RULE_PRAYER_NO_SHOES = 3 autoReadOnly
int property BEHAVIOR_RULE_PRAYER_NUDITY = 4 autoReadOnly
int property BEHAVIOR_RULE_PRAYER_MUST_POSE = 5 autoReadOnly
int property BEHAVIOR_RULE_PRAYER_MUST_ASK = 6 autoReadOnly
int property BEHAVIOR_RULE_PRAYER_CLEAN = 7 autoReadOnly
int property BEHAVIOR_RULE_PRAYER_WHIPPED = 8 autoReadOnly
int property BEHAVIOR_RULE_SPEECH_DOM = 9 autoReadOnly
int property BEHAVIOR_RULE_SPEECH_ASK = 10 autoReadOnly
int property BEHAVIOR_RULE_SPEECH_POSE = 11 autoReadOnly
int property BEHAVIOR_RULE_ENTRY_CASTLE = 12 autoReadOnly
int property BEHAVIOR_RULE_ENTRY_INN = 13 autoReadOnly
int property BEHAVIOR_RULE_ENTRY_PLAYER_HOME = 14 autoReadOnly
int property BEHAVIOR_RULE_FOOD_ASK = 15 autoReadOnly
int property BEHAVIOR_RULE_FOOD_SIT_ON_FLOOR = 16 autoReadOnly
int property BEHAVIOR_RULE_SEX_GIVE_THANKS = 17 autoReadOnly
int property BEHAVIOR_RULE_ASK_READ_SCROLL = 18 autoReadOnly
int property BEHAVIOR_RULE_ASK_TO_TRAIN = 19 autoReadOnly
int property BEHAVIOR_RULE_PROPER_FEMALE_ARMOR = 20 autoReadOnly

;public variables
int property RulesNudityRequired auto conditional
int property RulesControlledBy auto conditional
int property RulesUpdatedFlag auto conditional
int property RulesBehaviorMax auto conditional
int property RulesBondageMax auto conditional
int property RulesBehaviorMin auto conditional
int property RulesBondageMin auto conditional

;conditional variables for rules
int property BehaviorRuleNudity auto conditional ;0
int property BehaviorRuleNoBeds auto conditional ;1
int property BehaviorRuleDismissed auto conditional ;2
int property BehaviorRulePrayerNoShoes auto conditional ;3
int property BehaviorRulePrayerNudity auto conditional ;4
int property BehaviorRulePrayerMustPose auto conditional ;5
int property BehaviorRulePrayer auto conditional ;6
int property BehaviorRulePrayerClean auto conditional ;7
int property BehaviorRulePrayerWhipped auto conditional ;8
int property BehaviorRuleSpeechDomOnly auto conditional ;9
int property BehaviorRuleSpeechAsk auto conditional ;10
int property BehaviorRuleSpeechPose auto conditional ;l1
int property BehaviorEnterExitRuleCastle auto conditional ;12
int property BehaviorEnterExitRuleInn auto conditional ;13
int property BehaviorEnterExitRulePlayerHome auto conditional ;14
int property BehaviorFoodRule auto conditional ;15
int property BehaviorFoodSitOnFloor auto conditional ;16
int property BehaviorRuleSexGiveThanks auto conditional ;17
int property BehaviorRuleLearnSpell auto conditional ;18
int property BehaviorStudiesAskToTrainMustAsk auto conditional ;19
;int property BehaviorRuleAskToTrain auto conditional ;20
int property BehaviorRuleProperFemaleArmor auto conditional ;20


;rules tracking variables
int property BehaviorFoodRuleMustAskPermission auto conditional
float property BehaviorFoodRuleMustAskEndTime auto conditional
int property BehaviorEnterExitRuleCastlePermission auto conditional
int property BehaviorEnterExitRuleInnPermission auto conditional
int property BehaviorEnterExitRulePlayerHomePermission auto conditional
;int property BehaviorEnterExitRule auto conditional
int property BehaviorEnterExitRuleCurrentDoorType auto conditional
int property BehaviorEnterExitRuleCurrentLocationType auto conditional
int property BehaviorStudiesAskToTrainPermission auto conditional
float property BehaviorStudiesAskToTrainEndTime auto conditional 
int property BehaviorRuleLearnSpellPermission auto conditional


;private variables
string[] dRuleName
string[] bRuleName

int dRuleCount
int bRuleCount

int activeBondageRules
int activeBehaviorRules

Actor thePlayer

bindc_Rules function GetRules() global
    return Quest.GetQuest("bindc_MainQuest") as bindc_Rules
endfunction

function LoadGame()
    if thePlayer == none
        thePlayer = Game.GetPlayer()
    endif
    BuildDRulesArray()
    BuildBRulesArray()
    TurnOnVariables()
endfunction

int function GetBehaviorRuleConditionalByIndex(int idx)

    if idx == 0
        return BehaviorRuleNudity
    elseif idx == 1 
        return BehaviorRuleNoBeds
    elseif idx == 2 
        return BehaviorRuleDismissed
    elseif idx == 3 
        return BehaviorRulePrayerNoShoes
    elseif idx == 4 
        return BehaviorRulePrayerNudity
    elseif idx == 5 
        return BehaviorRulePrayerMustPose
    elseif idx == 6 
        return BehaviorRulePrayer
    elseif idx == 7 
        return BehaviorRulePrayerClean
    elseif idx == 8 
        return BehaviorRulePrayerWhipped
    elseif idx == 9 
        return BehaviorRuleSpeechDomOnly
    elseif idx == 10 
        return BehaviorRuleSpeechAsk
    elseif idx == 11 
        return BehaviorRuleSpeechPose
    elseif idx == 12 
        return BehaviorEnterExitRuleCastle
    elseif idx == 13 
        return BehaviorEnterExitRuleInn
    elseif idx == 14 
        return BehaviorEnterExitRulePlayerHome
    elseif idx == 15 
        return BehaviorFoodRule
    elseif idx == 16 
        return BehaviorFoodSitOnFloor
    elseif idx == 17 
        return BehaviorRuleSexGiveThanks
    elseif idx == 18
        return BehaviorRuleLearnSpell
    elseif idx == 19 
        return BehaviorStudiesAskToTrainMustAsk
    elseif idx == 21 
        return BehaviorRuleProperFemaleArmor
    else
        return -1
    endif

endfunction

function SetBehaviorRuleConditionalByIndex(int idx, int value)

    if idx == 0
        BehaviorRuleNudity = value 
    elseif idx == 1 
        BehaviorRuleNoBeds = value 
    elseif idx == 2 
        BehaviorRuleDismissed = value 
    elseif idx == 3 
        BehaviorRulePrayerNoShoes = value 
    elseif idx == 4 
        BehaviorRulePrayerNudity = value 
    elseif idx == 5 
        BehaviorRulePrayerMustPose = value 
    elseif idx == 6 
        BehaviorRulePrayer = value 
    elseif idx == 7 
        BehaviorRulePrayerClean = value 
    elseif idx == 8 
        BehaviorRulePrayerWhipped = value 
    elseif idx == 9 
        BehaviorRuleSpeechDomOnly = value 
    elseif idx == 10 
        BehaviorRuleSpeechAsk = value 
    elseif idx == 11 
        BehaviorRuleSpeechPose = value 
    elseif idx == 12 
        BehaviorEnterExitRuleCastle = value 
    elseif idx == 13 
        BehaviorEnterExitRuleInn = value 
    elseif idx == 14 
        BehaviorEnterExitRulePlayerHome = value 
    elseif idx == 15 
        BehaviorFoodRule = value 
    elseif idx == 16 
        BehaviorFoodSitOnFloor = value 
    elseif idx == 17 
        BehaviorRuleSexGiveThanks = value 
    elseif idx == 18
        BehaviorRuleLearnSpell = value 
    elseif idx == 19 
        BehaviorStudiesAskToTrainMustAsk = value 
    elseif idx == 20 
        BehaviorRuleProperFemaleArmor = value 
    endif

endfunction

function TurnOnVariables()

    Actor a = thePlayer

    ;need this incase this quest is stopped/started

    ; BehaviorRuleDismissed = GetBehaviorRule(a, BEHAVIOR_RULE_DISMISSED)
    ; BehaviorStudiesAskToTrainMustAsk = GetBehaviorRule(a, BEHAVIOR_RULE_ASK_TO_TRAIN)
    ; BehaviorRuleLearnSpell = GetBehaviorRule(a, BEHAVIOR_RULE_ASK_READ_SCROLL)
    ; BehaviorFoodRule = GetBehaviorRule(a, BEHAVIOR_RULE_FOOD_ASK)
    ; BehaviorRulePrayer = GetBehaviorRule(a, BEHAVIOR_RULE_PRAYER_MUST_ASK)
    ; BehaviorEnterExitRuleCastle = GetBehaviorRule(a, BEHAVIOR_RULE_ENTRY_CASTLE)
    ; BehaviorEnterExitRuleInn = GetBehaviorRule(a, BEHAVIOR_RULE_ENTRY_INN)
    ; BehaviorEnterExitRulePlayerHome = GetBehaviorRule(a, BEHAVIOR_RULE_ENTRY_PLAYER_HOME)
    ; BehaviorRuleProperFemaleArmor = GetBehaviorRule(a, BEHAVIOR_RULE_PROPER_FEMALE_ARMOR)
    ; BehaviorRuleSpeechAsk = GetBehaviorRule(a, BEHAVIOR_RULE_SPEECH_ASK)
    ; BehaviorRuleSpeechDomOnly = GetBehaviorRule(a, BEHAVIOR_RULE_SPEECH_DOM)
    ; RulesNudityRequired = GetBehaviorRule(a, BEHAVIOR_RULE_NUDITY)

    int idx = 0
    while idx < bRuleName.Length
        SetBehaviorRuleConditionalByIndex(idx, GetBehaviorRule(a, idx))
        idx += 1 
    endwhile

    ;debug.MessageBox(BehaviorRuleSpeechAsk)

    ; if BehaviorEnterExitRuleCastle == 1 || BehaviorEnterExitRuleInn == 1 || BehaviorEnterExitRulePlayerHome == 1
    ;     BehaviorEnterExitRule = 1
    ; else
    ;     BehaviorEnterExitRule = 0
    ; endif

endfunction

function BuildDRulesArray()
    dRuleCount = 18
    if dRuleName.Length != dRuleCount
        dRuleName = new String[18]
        dRuleName[0] = "Ankle Shackles Rule"
        dRuleName[1] = "Arm Cuffs Rule"
        dRuleName[2] = "Blindfold Rule"
        dRuleName[3] = "Boots Rule"
        dRuleName[4] = "Belt Rule"
        dRuleName[5] = "Collar Rule"
        dRuleName[6] = "Corset Rule"
        dRuleName[7] = "Gag Rule"
        dRuleName[8] = "Gloves Rule"
        dRuleName[9] = "Harness Rule"
        dRuleName[10] = "Heavy Bondage Rule"
        dRuleName[11] = "Hood Rule"
        dRuleName[12] = "Leg Cuffs Rule"
        dRuleName[13] = "Nipple Piercing Rule"
        dRuleName[14] = "Vaginal Piercing Rule"
        dRuleName[15] = "Anal Plug Rule"
        dRuleName[16] = "Vaginal Plug Rule"
        dRuleName[17] = "Suit Rule"
    endif
endfunction

function BuildBRulesArray()
    bRuleCount = 21
    if bRuleName.Length != bRuleCount
        bRuleName = new String[21]
        bRuleName[0] = "Body Rule:Nudity"
        bRuleName[1] = "Indoors Rule:No Beds"
        bRuleName[2] = "Indoors Rule:Dismissed"
        bRuleName[3] = "Prayer Rule:No Shoes"
        bRuleName[4] = "Prayer Rule:Nudity"
        bRuleName[5] = "Prayer Rule:Must Pose"
        bRuleName[6] = "Prayer Rule:Must Ask"
        bRuleName[7] = "Prayer Rule:Perfectly Clean"
        bRuleName[8] = "Prayer Rule:Whipped"
        bRuleName[9] = "Speech Rule:Dom Speaks"
        bRuleName[10] = "Speech Rule:Must Ask"
        bRuleName[11] = "Speech Rule:Must Pose"
        bRuleName[12] = "Entry/Exit Rule:Castle"
        bRuleName[13] = "Entry/Exit Rule:Inn"
        bRuleName[14] = "Entry/Exit Rule:Player Home"
        bRuleName[15] = "Food Rule:Must Ask"
        bRuleName[16] = "Food Rule:Sit On Floor"
        bRuleName[17] = "Sex Rule:Give Thanks"
        bRuleName[18] = "Studies:Ask To Read Scroll"
        bRuleName[19] = "Studies:Ask To Train"
        bRuleName[20] = "Body Rule:Proper Female Armor"
        ;bRuleName[21] = "Body Rule:Erotic Armor"
    endif
endfunction

;**************************************
;checks
;**************************************
bool function IsNudityRequired(Actor a, bool safeArea)

    ;TODO - have this work with safe locations and the safe option to determine if nudity is required
    ;vs. having the global suspend variable set

    int nudityRule = GetBehaviorRule(a, BEHAVIOR_RULE_NUDITY)
    int nudityRuleOption = GetBehaviorRuleOption(a, BEHAVIOR_RULE_NUDITY)

    bool onlySafeAreas = false
    if nudityRuleOption == RULE_OPTION_SAFE_AREAS || nudityRuleOption == RULE_OPTION_PERMANENT_SAFE_AREAS
        onlySafeAreas = true
    endif
        
    if (nudityRule == 1 && !onlySafeAreas) || (nudityRule == 1 && safeArea && onlySafeAreas) ;GetBehaviorRuleByName("Body Rule:Nudity") == 1
        return true
    else
        return false
    endif

endfunction

bool function IsProperFemaleArmorRequired(Actor a, bool safeArea)

    int rule = GetBehaviorRule(a, BEHAVIOR_RULE_PROPER_FEMALE_ARMOR)
    int ruleOption = GetBehaviorRuleOption(a, BEHAVIOR_RULE_PROPER_FEMALE_ARMOR)

    bool onlySafeAreas = false
    if ruleOption == RULE_OPTION_SAFE_AREAS || ruleOption == RULE_OPTION_PERMANENT_SAFE_AREAS
        onlySafeAreas = true
    endif
        
    if (rule == 1 && !onlySafeAreas) || (rule == 1 && safeArea && onlySafeAreas) ;GetBehaviorRuleByName("Body Rule:Nudity") == 1
        return true
    else
        return false
    endif

endfunction

bool function IsHeavyBondageRequired(Actor a, bool safeArea)

    int heavyBondage = 10 ;need to pull this from bondage manager - can't get the script linking to work so removing for now

    int bondageRule = GetBondageRule(a, heavyBondage)
    int bondageRuleOption = GetBondageRuleOption(a, heavyBondage)

    bool onlySafeAreas = false
    if bondageRuleOption == RULE_OPTION_SAFE_AREAS || bondageRuleOption == RULE_OPTION_PERMANENT_SAFE_AREAS
        onlySafeAreas = true
    endif

    ;debug.MessageBox("onlySafeAreas: " + onlySafeAreas + " bondageRule: " + bondageRule)

    if (bondageRule == 1 && !onlySafeAreas) || (bondageRule == 1 && safeArea && onlySafeAreas) ; GetBondageRuleByName("Heavy Bondage Rule") == 1
        return true
    else
        return false
    endif

endfunction

;**************************************
;behavior rules
;**************************************

int[] function GetBehaviorRulesSettingsList(Actor a)
    int idx = 0
    int[] list = new int[25]
    While idx < list.Length
        list[idx] = GetBehaviorRule(a, idx)
        idx += 1 
    EndWhile
    return list
endfunction

int function GetActiveBehaviorRulesCount(Actor a)
    return StorageUtil.GetIntValue(a, "bindc_active_behavior_rules", 0)
endfunction

int function GetBehaviorRulesCount()
    return bRuleCount
endfunction

string[] function GetBehaviorRuleNameArray()
    return bRuleName
endfunction

string function GetFriendlyBehaviorRuleName(int rule)
    return bRuleName[rule]
endfunction

string function FindExpiredBehaviorRules(Actor a)
    string list = ""
    activeBehaviorRules = 0
    int opt
    float endTime
    float ct = bindc_Util.GetTime()
    int i = 0
    while i < GetBehaviorRulesCount()
        if GetBehaviorRule(a, i) == 1
            activeBehaviorRules += 1
            opt = GetBehaviorRuleOption(a, i)
            endTime = GetBehaviorRuleEnd(a, i)
            if !(opt == RULE_OPTION_PERMANENT || opt == RULE_OPTION_PERMANENT_SAFE_AREAS || opt == RULE_OPTION_PERMANENT_UNSAFE_AREAS) && ct > endTime ;permanent rules never get removed
                if list != ""
                    list += "|"
                endif
                list += i
            endif
        endif
        i += 1
    endwhile
    return list
endfunction

string function FindOpenBehaviorRules(Actor a)
    string list = ""
    int opt
    int i = 0
    while i < GetBehaviorRulesCount()
        if GetBehaviorRule(a, i) == 0
            opt = GetBehaviorRuleOption(a, i)
            if !opt == RULE_OPTION_HARD_LIMIT
                if list != ""
                    list += "|"
                endif
                list += i
            endif
        endif
        i += 1
    endwhile
    return list
endfunction

function SetBehaviorRule(Actor a, int rule, bool on) 
    
    int setting = 0
    if on
        setting = 1
    endif

    SetBehaviorRuleConditionalByIndex(rule, setting)

    StorageUtil.SetIntValue(a, "bindc_brule_setting_" + rule, setting)

    ; if rule == BEHAVIOR_RULE_DISMISSED
    ;     BehaviorRuleDismissed = setting
    ; elseif rule == BEHAVIOR_RULE_ASK_TO_TRAIN
    ;     BehaviorStudiesAskToTrainMustAsk = setting
    ; elseif rule == BEHAVIOR_RULE_ASK_READ_SCROLL
    ;     BehaviorRuleLearnSpell = setting
    ; elseif rule == BEHAVIOR_RULE_FOOD_ASK
    ;     BehaviorFoodRule = setting
    ; elseif rule == BEHAVIOR_RULE_PRAYER_MUST_ASK
    ;     BehaviorRulePrayer = setting

    ; elseif rule == BEHAVIOR_RULE_ENTRY_CASTLE
    ;     BehaviorEnterExitRuleCastle = setting
    ; elseif rule == BEHAVIOR_RULE_ENTRY_INN
    ;     BehaviorEnterExitRuleInn = setting
    ; elseif rule == BEHAVIOR_RULE_ENTRY_PLAYER_HOME
    ;     BehaviorEnterExitRulePlayerHome = setting

    ; elseif rule == BEHAVIOR_RULE_PROPER_FEMALE_ARMOR
    ;     BehaviorRuleProperFemaleArmor = setting
        
    ; elseif rule == BEHAVIOR_RULE_SPEECH_ASK
    ;     BehaviorRuleSpeechAsk = setting

    ; elseif rule == BEHAVIOR_RULE_SPEECH_DOM
    ;     BehaviorRuleSpeechDomOnly = setting

    ; elseif rule == BEHAVIOR_RULE_NUDITY
    ;     RulesNudityRequired = setting
        
    ;     ;elseif other rules??

    ; endif

    ; if BehaviorEnterExitRuleCastle == 1 || BehaviorEnterExitRuleInn == 1 || BehaviorEnterExitRulePlayerHome == 1
    ;     BehaviorEnterExitRule = 1
    ; else
    ;     BehaviorEnterExitRule = 0
    ; endif

    int active = 0
    int idx = 0
    While idx < bRuleCount
        active += StorageUtil.GetIntValue(a, "bindc_brule_setting_" + idx, 0)
        idx += 1 
    EndWhile
    StorageUtil.SetIntValue(a, "bindc_active_behavior_rules", active)

endfunction

int function GetBehaviorRule(Actor a, int rule)
    return StorageUtil.GetIntValue(a, "bindc_brule_setting_" + rule, 0)
endfunction

function SetBehaviorRuleOption(Actor a, int rule, int option)
    StorageUtil.SetIntValue(a, "bindc_brule_option_" + rule, option)
endfunction

int function GetBehaviorRuleOption(Actor a, int rule)
    return StorageUtil.GetIntValue(a, "bindc_brule_option_" + rule, 0)
endfunction

function SetBehaviorRuleEnd(Actor a, int rule, float endTime)
    StorageUtil.SetFloatValue(a, "bindc_brule_end_" + rule, endTime)
endfunction

float function GetBehaviorRuleEnd(Actor a, int rule)
    return StorageUtil.GetFloatValue(a, "bindc_brule_end_" + rule, 0.0)
endfunction

function SetBehaviorRulePermission(Actor a, int rule, int permission)
    StorageUtil.SetIntValue(a, "bindc_brule_perm_" + rule, permission)
endfunction

int function GetBehaviorRulePermission(Actor a, int rule)
    return StorageUtil.GetIntValue(a, "bindc_brule_perm_" + rule, 0)
endfunction


;**************************************
;bondage rules
;**************************************

int[] function GetBondageRulesSettingsList(Actor a)
    int idx = 0
    int[] list = new int[25]
    While idx < list.Length
        list[idx] = GetBondageRule(a, idx)
        idx += 1 
    EndWhile
    return list
endfunction

int function GetActiveBondageRulesCount(Actor a)
    return StorageUtil.GetIntValue(a, "bindc_active_bondage_rules", 0)
endfunction

int function GetBondageRulesCount()
    return dRuleCount
endfunction

string[] function GetBondageRuleNameArray()
    return dRuleName
endfunction

string function GetFriendlyBondageRuleName(int rule)
    return dRuleName[rule]
endfunction

function SetBondageRule(Actor a, int rule, bool on) 

    ; int setting = 0
    ; if on
    ;     setting = 1
    ; endif

    ; StorageUtil.SetIntValue(a, "bindc_brule_setting_" + rule, setting)

    if on
        StorageUtil.SetIntValue(a, "bindc_rule_setting_" + rule, 1)
    else
        StorageUtil.SetIntValue(a, "bindc_rule_setting_" + rule, 0)
    endif
    int active = 0
    int idx = 0
    While idx < dRuleCount
        active += StorageUtil.GetIntValue(a, "bindc_rule_setting_" + idx, 0)
        idx += 1 
    EndWhile
    StorageUtil.SetIntValue(a, "bindc_active_bondage_rules", active)
endfunction

int function GetBondageRule(Actor a, int rule)
    return StorageUtil.GetIntValue(a, "bindc_rule_setting_" + rule, 0)
endfunction

function SetBondageRuleOption(Actor a, int rule, int option)
    StorageUtil.SetIntValue(a, "bindc_rule_option_" + rule, option)
endfunction

int function GetBondageRuleOption(Actor a, int rule)
    return StorageUtil.GetIntValue(a, "bindc_rule_option_" + rule, 0)
endfunction

function SetBondageRuleEnd(Actor a, int rule, float endTime)
    StorageUtil.SetFloatValue(a, "bindc_rule_end_" + rule, endTime)
endfunction

float function GetBondageRuleEnd(Actor a, int rule)
    return StorageUtil.GetFloatValue(a, "bindc_rule_end_" + rule, 0.0)
endfunction

string function FindOpenBondageRulesByName(Actor a)
    string list = ""
    int idx = 0
    While idx < dRuleCount
        string ruleName = dRuleName[idx]
        int bondageRule = GetBondageRule(a, idx)
        int bondageRuleOption = GetBondageRuleOption(a, idx)
        if bondageRuleOption != RULE_OPTION_HARD_LIMIT && bondageRule == 0
            if list != ""
                list += "|"
            endif
            list += ruleName
        endif
        idx += 1 
    EndWhile
    return list
endfunction

int function GetBondageRuleIdByName(string ruleName)
    int result = -1
    int idx = 0
    While idx < dRuleName.Length
        If dRuleName[idx] == ruleName
            result = idx
        EndIf
        idx += 1 
    EndWhile
    return result
endfunction

string function FindExpiredBondageRules(Actor a)
    string list = ""
    activeBondageRules = 0
    int opt
    float endTime
    float ct = bindc_Util.GetTime()
    int i = 0
    while i < GetBondageRulesCount()
        if GetBondageRule(a, i) == 1
            activeBondageRules += 1
            opt = GetBondageRuleOption(a, i)
            endTime = GetBondageRuleEnd(a, i)
            if !(opt == RULE_OPTION_PERMANENT || opt == RULE_OPTION_PERMANENT_SAFE_AREAS || opt == RULE_OPTION_PERMANENT_UNSAFE_AREAS) && ct > endTime ;permanent rules never get removed
                if list != ""
                    list += "|"
                endif
                list += i
            endif
        endif
        i += 1
    endwhile
    return list
endfunction

string function FindOpenBondageRules(Actor a)
    string list = ""
    int opt
    int i = 0
    while i < GetBondageRulesCount()
        if GetBondageRule(a, i) == 0
            opt = GetBondageRuleOption(a, i)
            if !opt == RULE_OPTION_HARD_LIMIT
                if list != ""
                    list += "|"
                endif
                list += i
            endif
        endif
        i += 1
    endwhile
    return list
endfunction

;***********************************************************
;grant permissions
;***********************************************************

Function GrantEatDrinkPermission()
	BehaviorFoodRuleMustAskPermission = 1
	BehaviorFoodRuleMustAskEndTime = bindc_Util.AddTimeToCurrentTime(0, 30) ;grant 30 minutes
	bindc_Util.WriteInternalMonologue("I need to eat and drink quickly...")
EndFunction

function GrantEntryPermission()
    BehaviorEnterExitRuleInnPermission = 0
    BehaviorEnterExitRuleCastlePermission = 0
    BehaviorEnterExitRulePlayerHomePermission = 0
    if BehaviorEnterExitRuleCurrentDoorType == DESTINATION_TYPE_INN
        BehaviorEnterExitRuleInnPermission = 1
        bindc_Util.WriteInternalMonologue("I have permission to enter the inn...")
    elseif BehaviorEnterExitRuleCurrentDoorType == DESTINATION_TYPE_CASTLE
        BehaviorEnterExitRuleCastlePermission = 1
        bindc_Util.WriteInternalMonologue("I have permission to enter the castle...")
    elseif BehaviorEnterExitRuleCurrentDoorType == DESTINATION_TYPE_PLAYERHOME
        BehaviorEnterExitRulePlayerHomePermission = 1
        bindc_Util.WriteInternalMonologue("I have permission to enter this home...")
    endif
endfunction

function GrantExitPermission()
    ;debug.MessageBox("current loc type: " + BehaviorEnterExitRuleCurrentLocationType)
    BehaviorEnterExitRuleInnPermission = 0
    BehaviorEnterExitRuleCastlePermission = 0
    BehaviorEnterExitRulePlayerHomePermission = 0
    if BehaviorEnterExitRuleCurrentLocationType == DESTINATION_TYPE_INN
        BehaviorEnterExitRuleInnPermission = 1
        bindc_Util.WriteInternalMonologue("I have permission to leave the inn...")
    elseif BehaviorEnterExitRuleCurrentLocationType == DESTINATION_TYPE_CASTLE
        BehaviorEnterExitRuleCastlePermission = 1
        bindc_Util.WriteInternalMonologue("I have permission to leave the castle...")
    elseif BehaviorEnterExitRuleCurrentLocationType == DESTINATION_TYPE_PLAYERHOME
        BehaviorEnterExitRulePlayerHomePermission = 1
        bindc_Util.WriteInternalMonologue("I have permission to leave this home...")
    endif
endfunction

Function GrantLearnSpellPermission()
	StorageUtil.SetIntValue(thePlayer, "bindc_has_read_scroll_permission", 1)
	StorageUtil.SetFloatValue(thePlayer, "bindc_has_read_scroll_permmission_end", bindc_Util.AddTimeToCurrentTime(1, 0))
	bindc_Util.WriteInternalMonologue("I have an hour to do my studies...")
EndFunction

Function GrantSpeechPermission()
	StorageUtil.SetIntValue(thePlayer, "bindc_has_speech_permission", 1)
	bindc_Util.WriteInternalMonologue("I have permission to speak...")
EndFunction

Function GrantPrayerPermission()
	StorageUtil.SetIntValue(thePlayer, "bindc_has_prayer_permission", 1)
	bindc_Util.WriteInternalMonologue("I have permission to seek a blessing...")
EndFunction

function GrantTalkToTrainerPermission() 
    BehaviorStudiesAskToTrainPermission = 1
    BehaviorStudiesAskToTrainEndTime = bindc_Util.AddTimeToCurrentTime(1, 0)
	bindc_Util.WriteInternalMonologue("I have an hour to learn from this trainer...")
endfunction


;**************************************
;permissions / rules checks
;**************************************

Function PrayedAtShrine(string shrineGod, bool isNude, bool wearingShoes, bool inPose)
	
    bool result = true
	string msg = ""

	;UpdateCleanTracking() ;TODO - add this!!

	if GetBehaviorRule(thePlayer, BEHAVIOR_RULE_PRAYER_NUDITY) == 1
		if !isNude
			msg = "I forgot to take off my clothes before prayer"
			result = false
		endif
	endif
	if GetBehaviorRule(thePlayer, BEHAVIOR_RULE_PRAYER_NO_SHOES) == 1 && result
		If !wearingShoes
			msg = "I forgot to remove my shoes before prayer"
			result = false
		EndIf
	endif
	if GetBehaviorRule(thePlayer, BEHAVIOR_RULE_PRAYER_MUST_POSE) == 1 && result
		If !inPose
			msg = "I forgot to pose before prayer"
			result = false
		EndIf
	endif
	if GetBehaviorRule(thePlayer, BEHAVIOR_RULE_PRAYER_MUST_ASK) == 1 && result
		if StorageUtil.GetIntValue(thePlayer, "bindc_has_prayer_permission", 0) == 0
			msg = "I didn't ask to pray"
			result = false
		endif
	endif
	if GetBehaviorRule(thePlayer, BEHAVIOR_RULE_PRAYER_CLEAN) == 1 && result
		If StorageUtil.GetIntValue(thePlayer, "bindc_dirt_level", 0) > 0
			msg = "I am far too dirty to recieve blessings"
			result = false
		EndIf
	endif
	if GetBehaviorRule(thePlayer, BEHAVIOR_RULE_PRAYER_WHIPPED) == 1 && result
		;TODO - store last whipped time
		float lastWhipped = StorageUtil.GetFloatValue(thePlayer, "bindc_last_whipped", 0.0)
		if bindc_Util.GetTime() - lastWhipped >= 1.0 || lastWhipped == 0.0
			msg = "I need to be red from a whip to recieve blessings"
			result = false
		endif
	endif

	If result
		bindc_Util.WriteInternalMonologue("Hopefully " + shrineGod + " will be pleased with my respect...")
	else
		bindc_Util.MarkInfraction(msg, true)
	EndIf

	;zero out permissions flags
	StorageUtil.SetIntValue(thePlayer, "bindc_has_prayer_permission", 0)

EndFunction

function LookedAtDoor(ObjectReference doorRef, bool isIndoors, Location currentLocation)

    ;debug.MessageBox("BehaviorEnterExitRulePlayerHome: " + BehaviorEnterExitRulePlayerHome + " BehaviorEnterExitRuleInn: " + BehaviorEnterExitRuleInn + " BehaviorEnterExitRuleCastle: " + BehaviorEnterExitRuleCastle)

    ObjectReference destination = PO3_SKSEFunctions.GetDoorDestination(doorRef)
    if destination
        Location doorLoc = destination.GetCurrentLocation()
        if doorLoc != none
            bool changingLocation = false
            if doorLoc != currentLocation
                changingLocation = true
            endif
            bindc_Util.WriteInformation("door - " + doorLoc.GetName() + " current - " + currentLocation.GetName() + " changingLocation - " + changingLocation)
            if changingLocation
                if isIndoors
                    BehaviorEnterExitRuleCurrentLocationType = 0
                    if currentLocation.HasKeywordString("LocTypeInn") && BehaviorEnterExitRuleInn == 1
                        BehaviorEnterExitRuleCurrentLocationType = DESTINATION_TYPE_INN
                        if BehaviorEnterExitRuleInnPermission == 0
                            bindc_Util.WriteInternalMonologue("I need permission to leave " + currentLocation.GetName() + "...")
                        else 
                            bindc_Util.WriteInternalMonologue("I HAVE permission to leave " + currentLocation.GetName() + "...")
                        endif
                    elseif currentLocation.HasKeywordString("LocTypeCastle") && BehaviorEnterExitRuleCastle == 1
                        BehaviorEnterExitRuleCurrentLocationType = DESTINATION_TYPE_CASTLE
                        if BehaviorEnterExitRuleCastlePermission == 0
                            bindc_Util.WriteInternalMonologue("I need permission to leave " + currentLocation.GetName() + "...")
                        else 
                            bindc_Util.WriteInternalMonologue("I HAVE permission to leave " + currentLocation.GetName() + "...")
                        endif
                    elseif currentLocation.HasKeywordString("LocTypePlayerHouse") && BehaviorEnterExitRulePlayerHome == 1
                        BehaviorEnterExitRuleCurrentLocationType = DESTINATION_TYPE_PLAYERHOME
                        if BehaviorEnterExitRulePlayerHomePermission == 0
                            bindc_Util.WriteInternalMonologue("I need permission to leave " + currentLocation.GetName() + "...")
                        else 
                            bindc_Util.WriteInternalMonologue("I HAVE permission to leave " + currentLocation.GetName() + "...")
                        endif
                    endif 
                else
                    BehaviorEnterExitRuleCurrentDoorType = 0
                    if (doorLoc.HasKeywordString("LocTypeInn") && BehaviorEnterExitRuleInn == 1) 
                        BehaviorEnterExitRuleCurrentDoorType = DESTINATION_TYPE_INN
                        if BehaviorEnterExitRuleInnPermission == 0
                            bindc_Util.WriteInternalMonologue("I need permission to enter " + doorLoc.GetName() + "...")
                        else
                            bindc_Util.WriteInternalMonologue("I HAVE permission to enter " + doorLoc.GetName() + "...")
                        endif
                    elseif (doorLoc.HasKeywordString("LocTypeCastle") && BehaviorEnterExitRuleCastle == 1) 
                        BehaviorEnterExitRuleCurrentDoorType = DESTINATION_TYPE_CASTLE
                        if BehaviorEnterExitRuleCastlePermission == 0
                            bindc_Util.WriteInternalMonologue("I need permission to enter " + doorLoc.GetName() + "...")
                        else
                            bindc_Util.WriteInternalMonologue("I HAVE permission to enter " + doorLoc.GetName() + "...")
                        endif
                    elseif (doorLoc.HasKeywordString("LocTypePlayerHouse") && BehaviorEnterExitRulePlayerHome == 1) 
                        BehaviorEnterExitRuleCurrentDoorType = DESTINATION_TYPE_PLAYERHOME
                        if BehaviorEnterExitRulePlayerHomePermission == 0
                            bindc_Util.WriteInternalMonologue("I need permission to enter " + doorLoc.GetName() + "...")
                        else
                            bindc_Util.WriteInternalMonologue("I HAVE permission to enter " + doorLoc.GetName() + "...")
                        endif
                    endif
                endif
            endif
        endif
    endif

endfunction

function UsedDoor(ObjectReference doorRef, bool isIndoors, Location currentLocation) 

    bindc_Util.WriteInformation("UsedDoor - BehaviorEnterExitRulePlayerHome: " + BehaviorEnterExitRulePlayerHome + " BehaviorEnterExitRuleInn: " + BehaviorEnterExitRuleInn + " BehaviorEnterExitRuleCastle: " + BehaviorEnterExitRuleCastle)

    ObjectReference destination = PO3_SKSEFunctions.GetDoorDestination(doorRef)
    if destination
        Location doorLoc = destination.GetCurrentLocation()
        if doorLoc != none
            bool changingLocation = false
            if doorLoc != currentLocation
                changingLocation = true
            endif

            bindc_Util.WriteInformation("door - " + doorLoc.GetName() + " current - " + currentLocation.GetName() + " changingLocation - " + changingLocation)

            if changingLocation

                if isIndoors
                    if (currentLocation.HasKeywordString("LocTypeInn") && BehaviorEnterExitRuleInn == 1) 
                        if !BehaviorEnterExitRuleInnPermission == 1
                            BrokeExitRule()
                        endif
                    elseif (currentLocation.HasKeywordString("LocTypeCastle") && BehaviorEnterExitRuleCastle == 1) 
                        if !BehaviorEnterExitRuleCastlePermission == 1
                            BrokeExitRule()
                        endif
                    elseif (currentLocation.HasKeywordString("LocTypePlayerHouse") && BehaviorEnterExitRulePlayerHome == 1) 
                        if !BehaviorEnterExitRulePlayerHomePermission == 1
                            BrokeExitRule()
                        endif
                    endif
                else
                    if (doorLoc.HasKeywordString("LocTypeInn") && BehaviorEnterExitRuleInn == 1) 
                        if !BehaviorEnterExitRuleInnPermission == 1
                            BrokeEntryRule()
                        endif
                    elseif (doorLoc.HasKeywordString("LocTypeCastle") && BehaviorEnterExitRuleCastle == 1) 
                        if !BehaviorEnterExitRuleCastlePermission == 1
                            BrokeEntryRule()
                        endif
                    elseif (doorLoc.HasKeywordString("LocTypePlayerHouse") && BehaviorEnterExitRulePlayerHome == 1) 
                        if !BehaviorEnterExitRulePlayerHomePermission == 1
                            BrokeEntryRule()
                        endif
                    endif
                endif

            else

            endif

        endif
    endif

    ;ClearLocationPermissions()

endfunction

function UpdateRulesByLocation(Location newLocation)

    bool safeArea = (StorageUtil.GetIntValue(none, "bindc_safe_area", 1) == 2)
    int option

    ;debug.MessageBox("safeArea: " + safeArea)

    bindc_Util.WriteInformation("UpdateRulesByLocation safeArea: " + safeArea + " start: " + bindc_Util.GetTime())

    int idx = 0
    While idx < bRuleCount
        int rule = GetBehaviorRule(thePlayer, idx)
        if rule > 0
            option = GetBehaviorRuleOption(thePlayer, idx)
            int conditionalValue = GetBehaviorRuleConditionalByIndex(idx)
            if ((option == RULE_OPTION_SAFE_AREAS || option == RULE_OPTION_PERMANENT_SAFE_AREAS) && !safeArea && conditionalValue > 0)
                SetBehaviorRuleConditionalByIndex(idx, 2)
                conditionalValue = 2
            elseif ((option == RULE_OPTION_UNSAFE_AREAS || option == RULE_OPTION_PERMANENT_UNSAFE_AREAS) && safeArea && conditionalValue > 0)
                SetBehaviorRuleConditionalByIndex(idx, 2)
                conditionalValue = 2
            elseif conditionalValue == 2
                SetBehaviorRuleConditionalByIndex(idx, 1)
                conditionalValue = 1
            endif
            bindc_Util.WriteInformation("UpdateRulesByLocation rule: " + bRuleName[idx] + " old: " + rule + " option: " + option + " cond: " + conditionalValue)
        endif
        idx += 1 
    EndWhile

    bindc_Util.WriteInformation("UpdateRulesByLocation end: " + bindc_Util.GetTime())

    ClearLocationPermissions()

endfunction

bool clearedSpeechPermission

function ClearLocationPermissions()

    clearedSpeechPermission = false

    BehaviorEnterExitRuleCurrentLocationType = 0
    BehaviorEnterExitRuleCurrentDoorType = 0

    ;debug.MessageBox("this is happening??")

    BehaviorEnterExitRuleCastlePermission = 0
    BehaviorEnterExitRuleInnPermission = 0
    BehaviorEnterExitRulePlayerHomePermission = 0

    if StorageUtil.GetIntValue(thePlayer, "bindc_has_speech_permission", 0) == 1
        StorageUtil.SetIntValue(thePlayer, "bindc_has_speech_permission", 0)
        clearedSpeechPermission = true
    endif

    ;debug.MessageBox("cleared speech: " + clearedSpeechPermission)

    StorageUtil.SetIntValue(thePlayer, "bindc_has_prayer_permission", 0)
    StorageUtil.SetFloatValue(thePlayer, "bindc_temp_speaking_permission", 0)

    UnregisterForUpdate()
    GotoState("ChangedLocationMessageState")
    RegisterForSingleUpdate(3.0)

endfunction

function UpdateTimePermissions()

    float ct = bindc_Util.GetTime()

    if BehaviorFoodRuleMustAskPermission == 1
        if BehaviorFoodRuleMustAskEndTime < ct
            bindc_Util.WriteInternalMonologue("I can no longer eat or drink...")
            BehaviorFoodRuleMustAskPermission = 0
        endif
    endif

    if BehaviorStudiesAskToTrainPermission == 1
        If BehaviorStudiesAskToTrainEndTime < ct
            bindc_Util.WriteInternalMonologue("My training permission has ended...")
            BehaviorStudiesAskToTrainPermission = 0
        endif
    endif

endfunction

bool brokeEntryRule
bool brokeExitRule

function BrokeEntryRule()
    brokeEntryRule = true 
    brokeExitRule = false
    ; UnregisterForUpdate()
    ; GotoState("BrokeEntryRuleState")
    ; RegisterForSingleUpdate(5.0)
endfunction

function BrokeExitRule()
    brokeEntryRule = false 
    brokeExitRule = true
    ; UnregisterForUpdate()
    ; GotoState("BrokeExitRuleState")
    ; RegisterForSingleUpdate(5.0)
endfunction

function TrainingRuleCheck()
    UnregisterForUpdate()
    GotoState("TrainingRuleCheckState")
    RegisterForSingleUpdate(5.0)
endfunction

event OnUpdate()
endevent

state ChangedLocationMessageState
    event OnUpdate()
        GoToState("")
        if brokeEntryRule
            bindc_Util.MarkInfraction("I did not have permission to enter", true)
        elseif brokeExitRule
            bindc_Util.MarkInfraction("I did not have permission to exit", true)
        endif
        if clearedSpeechPermission
            bindc_Util.WriteInternalMonologue("My speech permission has ended...")
        endif        
        brokeEntryRule = false 
        brokeExitRule = false       
    endevent
endstate

; state BrokeEntryRuleState
;     event OnUpdate()       
;         bindc_Util.MarkInfraction("I did not have permission to enter", true)
;         GoToState("")
;     endevent
; endstate

; state BrokeExitRuleState
;     event OnUpdate()       
;         bindc_Util.MarkInfraction("I did not have permission to exit", true)
;         GoToState("")
;     endevent
; endstate

state TrainingRuleCheckState
    event OnUpdate()       
        ;training check
        int trainingCount = Game.QueryStat("Training Sessions")
        int storedTrainingCount = StorageUtil.GetIntValue(none, "bindc_training_sessions", 0)
        bindc_Util.WriteInformation("TrainingRuleCheckState - training: " + trainingCount + " stored: " + storedTrainingCount + " perm: " + BehaviorStudiesAskToTrainPermission)
        if trainingCount != storedTrainingCount
            ;check permission
            if BehaviorStudiesAskToTrainMustAsk == 1 && BehaviorStudiesAskToTrainPermission == 0
                bindc_Util.MarkInfraction("I was supposed to ask before training", true)
            endif
            StorageUtil.SetIntValue(none, "bindc_training_sessions", trainingCount)
        endif
        GoToState("")
    endevent
endstate

;**********************************
;rules quest functions
;**********************************

string function PickAction(string expBondage, string expBehavior, string openBondage, string openBehavior)

    string canDo = ""
    string result = ""
    
    if expBondage != "" && (RulesBondageMin < activeBondageRules)
        canDo = "1"
    endif
    if expBehavior != "" && (RulesBehaviorMin < activeBehaviorRules)
        if canDo != ""
            canDo += "|"
        endif
        canDo += "2"
    endif
    if openBondage != "" && (RulesBondageMax > activeBondageRules)
        if canDo != ""
            canDo += "|"
        endif
        canDo += "3"
    endif
    if openBehavior != "" && (RulesBehaviorMax > activeBehaviorRules)
        if canDo != ""
            canDo += "|"
        endif
        canDo += "4"
    endif

    bindc_Util.WriteInformation("canDo: " + canDo)

    if canDo != ""
        string[] arr = StringUtil.Split(canDo, "|") 
        result = arr[Utility.RandomInt(0, arr.Length - 1)]
    endif

    string[] arr
    if result == "1"
        arr = StringUtil.Split(expBondage, "|")
    elseif result == "2"
        arr = StringUtil.Split(expBehavior, "|")
    elseif result == "3"
        arr = StringUtil.Split(openBondage, "|")
    elseif result == "4"
        arr = StringUtil.Split(openBehavior, "|")
    endif
    if arr.length > 0
        result += "|"
        result += arr[Utility.RandomInt(0, arr.length - 1)]
    endif

    return result

endfunction

string function DomManagedRuleChange(Actor theSub, bool testChanges = false)

    ;bind_GlobalRulesBondageMax.SetValue(0)
    ;bind_GlobalRulesBondageMin.SetValue(0) ;note - disable bondage rules

    string expiredBondageRules = FindExpiredBondageRules(theSub)
    string expiredBehaviorRules = FindExpiredBehaviorRules(theSub)
    string openBondageRules = FindOpenBondageRules(theSub)
    string openBehaviorRules = FindOpenBehaviorRules(theSub)

    bindc_Util.WriteInformation("expiredBondageRules: " + expiredBondageRules)
    bindc_Util.WriteInformation("expiredBehaviorRules: " + expiredBehaviorRules)
    bindc_Util.WriteInformation("openBondageRules: " + openBondageRules)
    bindc_Util.WriteInformation("openBehaviorRules: " + openBehaviorRules)
    bindc_Util.WriteInformation("active rules bondage: " + activeBondageRules + " behavior: " + activeBehaviorRules)
    bindc_Util.WriteInformation("max rules bondage: " + RulesBondageMax + " behavior: " + RulesBehaviorMax)
    bindc_Util.WriteInformation("min rules bondage: " + RulesBondageMin + " behavior: " + RulesBehaviorMin)

    string selectedAction = PickAction(expiredBondageRules, expiredBehaviorRules, openBondageRules, openBehaviorRules)

    bindc_Util.WriteInformation("selectedAction: " + selectedAction)

    if selectedAction != "" && testChanges
        string[] arr = StringUtil.Split(selectedAction, "|")
        if arr.Length == 2
            string actionType = arr[0]
            int rule = arr[1] as int

            if actionType == "1"
                SetBondageRule(theSub, rule, 0)
            elseif actionType == "2"
                SetBehaviorRule(theSub, rule, 0)
            elseif actionType == "3"
                SetBondageRule(theSub, rule, 1)
                SetBondageRuleEnd(theSub, rule, bindc_Util.AddTimeToCurrentTime(Utility.RandomInt(24, 96), 0))
            elseif actionType == "4"
                SetBehaviorRule(theSub, rule, 1)
                SetBehaviorRuleEnd(theSub, rule, bindc_Util.AddTimeToCurrentTime(Utility.RandomInt(24, 96), 0))               
            endif

            debug.MessageBox("Action: " + actionType + " Rule: " + rule)

        endif
    endif

    return selectedAction

endfunction