Scriptname bind_RulesManager extends Quest conditional

; import StringUtil

; string _rulesTemplate = ""
; string _rulesTemplateDisplayName = ""

; string[] _rulesArr
; string[] _rulesDisplayNameArr ;need to make this work, short name is not good for output

; int[] _enabledArr
; int[] _activeArr
; int[] _likeArr
; float[] _ruleAddedDate

int property UseFastRuleCheck auto conditional

; int property BehaviorFoodRuleMustAsk auto conditional
; int property BehaviorEnterExitRuleCastle auto conditional
; int property BehaviorEnterExitRuleInn auto conditional
; int property BehaviorEnterExitRulePlayerHome auto conditional

int property BehaviorFoodRule auto conditional
int property BehaviorFoodRuleMustAskPermission auto conditional
float property BehaviorFoodRuleMustAskEndTime auto conditional

int property BehaviorEnterExitRuleCastlePermission auto conditional
int property BehaviorEnterExitRuleInnPermission auto conditional
int property BehaviorEnterExitRulePlayerHomePermission auto conditional
int property BehaviorEnterExitRuleCastle auto conditional
int property BehaviorEnterExitRuleInn auto conditional
int property BehaviorEnterExitRulePlayerHome auto conditional
int property BehaviorEnterExitRule auto conditional
int property BehaviorEnterExitRuleCurrentDoorType auto conditional
int property BehaviorEnterExitRuleCurrentLocationType auto conditional

int property DESTINATION_TYPE_INN = 1 autoReadOnly
int property DESTINATION_TYPE_CASTLE = 2 autoReadOnly
int property DESTINATION_TYPE_PLAYERHOME = 3 autoReadOnly

int property BehaviorStudiesAskToTrainMustAsk auto conditional
int property BehaviorStudiesAskToTrainPermission auto conditional
float property BehaviorStudiesAskToTrainEndTime auto conditional 

int property BehaviorIndoorsRuleDismissed auto conditional

int property BehaviorRuleLearnSpell auto conditional
int property BehaviorRuleLearnSpellPermission auto conditional

int property BehaviorRulePrayer auto conditional

int property BehaviorRuleBikiniArmor auto conditional
int property BehaviorRuleEroticArmor auto conditional

int property BehaviorRuleSpeechAsk auto conditional

; string bondageRulesKeys = ""
; string[] bondageRulesArr
; int[] bondageRulesSettingsArr
; int[] bondageHardSettingsArr
; float[] bondageProtectionArr ;these will be set by players asking to keep the rules
; int[] bondageRuleToBondageType

; string behaviorRulesGroups = ""
; string behaviorRulesKeys = ""
; string[] behaviorRulesArr
; string[] behaviorRulesGroupArr
; int[] behaviorRulesSettingsArr
; int[] behaviorHardSettingsArr
; float[] behaviorProtectionArr

; int property IsRuleActive auto conditional
; int property RuleIndex auto conditional

; int property IsHandsBlockingRuleActive auto conditional ;handcuffs, armbinders, etc.
; int property IsSpeechBlockingRuleActive auto conditional ;gags, mouth blocking
; int property IsSpeechLimitingRuleActive auto conditional ;speech rules like no conversation 
; int property IsBedLimitingRuleActive auto conditional ;no beds

; int property HardLimitAlwaysNude auto conditional
; int property HardLimitBound auto conditional
; int property HardLimitNoBeds auto conditional
; int property HardLimitDismissed auto conditional
; int property HardLimitCollar auto conditional
; int property HardLimitChastity auto conditional
; int property HardLimitShackles auto conditional
; int property HardLimitCorset auto conditional
; int property HardLimitBoots auto conditional
; int property HardLimitGagged auto conditional
; int property HardLimitPiercing auto conditional
; int property HardLimitBlindfold auto conditional
; int property HardLimitHood auto conditional
; int property HardLimitAnalPlug auto conditional

bind_RulesManager function GetRulesManager() global
    return Quest.GetQuest("bind_MainQuest") as bind_RulesManager
endfunction

Function LoadGame()

    ; ;bondageRulesKeys = "Bound Rule,Collared Rule,Chastity Rule,Boots Rule,Corset Rule,Gagged Rule,Shackles Rule,Piercing Rule,Blindfold Rule,Hood Rule"
    ; bondageRulesKeys = "Ankle Shackles Rule,Arm Cuffs Rule,Blindfold Rule,Boots Rule,Belt Rule,Collar Rule,Corset Rule,Gag Rule,Gloves Rule,Harness Rule,"
    ; bondageRulesKeys += "Heavy Bondage Rule,Hood Rule,Leg Cuffs Rule,Nipple Piercing Rule,Vaginal Piercing Rule,Anal Plug Rule,Vaginal Plug Rule,Suit Rule"
    ; bondageRulesArr = StringUtil.Split(bondageRulesKeys, ",")
    ; if bondageRulesSettingsArr.Length == 0
    ;     bondageRulesSettingsArr = new int[50]
    ; endif
    ; if bondageHardSettingsArr.Length == 0
    ;     bondageHardSettingsArr = new int[50]
    ; endif
    ; if bondageProtectionArr.Length == 0
    ;     bondageProtectionArr = new float[50]
    ; endif
    ; if bondageRuleToBondageType.Length == 0
    ;     bondageRuleToBondageType = new int[50]
    ;     bondageRuleToBondageType[0] = bbm.BONDAGE_TYPE_ANKLE_SHACKLES()
    ;     bondageRuleToBondageType[1] = bbm.BONDAGE_TYPE_ARM_CUFFS()
    ;     bondageRuleToBondageType[2] = bbm.BONDAGE_TYPE_BLINDFOLD()
    ;     bondageRuleToBondageType[3] = bbm.BONDAGE_TYPE_BOOTS()
    ;     bondageRuleToBondageType[4] = bbm.BONDAGE_TYPE_BELT()
    ;     bondageRuleToBondageType[5] = bbm.BONDAGE_TYPE_COLLAR()
    ;     bondageRuleToBondageType[6] = bbm.BONDAGE_TYPE_CORSET()
    ;     bondageRuleToBondageType[7] = bbm.BONDAGE_TYPE_GAG()
    ;     bondageRuleToBondageType[8] = bbm.BONDAGE_TYPE_GLOVES()
    ;     bondageRuleToBondageType[9] = bbm.BONDAGE_TYPE_HARNESS()
    ;     bondageRuleToBondageType[10] = bbm.BONDAGE_TYPE_HEAVYBONDAGE()
    ;     bondageRuleToBondageType[11] = bbm.BONDAGE_TYPE_HOOD()
    ;     bondageRuleToBondageType[12] = bbm.BONDAGE_TYPE_LEG_CUFFS()
    ;     bondageRuleToBondageType[13] = bbm.BONDAGE_TYPE_N_PIERCING()
    ;     bondageRuleToBondageType[14] = bbm.BONDAGE_TYPE_V_PIERCING()
    ;     bondageRuleToBondageType[15] = bbm.BONDAGE_TYPE_A_PLUG()
    ;     bondageRuleToBondageType[16] = bbm.BONDAGE_TYPE_V_PLUG()
    ;     bondageRuleToBondageType[17] = bbm.BONDAGE_TYPE_SUIT()
    ; endif

    ; behaviorRulesGroups = "Body Rule,Indoors Rule,Prayer Rule,Speech Rule,Entry/Exit Rule,Food Rule,Sex Rule,Studies"

    ; behaviorRulesGroupArr = StringUtil.Split(behaviorRulesGroups, ",")

    ; behaviorRulesKeys = "Body Rule:Nudity,Indoors Rule:No Beds,Indoors Rule:Dismissed,"
    ; behaviorRulesKeys += "Prayer Rule:No Shoes,Prayer Rule:Nudity,Prayer Rule:Must Pose,Prayer Rule:Must Ask,Prayer Rule:Perfectly Clean,Prayer Rule:Whipped,"
    ; behaviorRulesKeys += "Speech Rule:Dom Speaks,Speech Rule:Must Ask,Speech Rule:Must Pose,Entry/Exit Rule:Castle,Entry/Exit Rule:Inn,Entry/Exit Rule:Player Home,"
    ; behaviorRulesKeys += "Food Rule:Must Ask,Food Rule:Sit On Floor,Sex Rule:Give Thanks,Studies:Ask To Read Scroll,Studies:Ask To Train"

    ; behaviorRulesArr = StringUtil.Split(behaviorRulesKeys, ",")

    ; if behaviorRulesSettingsArr.Length == 0
    ;     behaviorRulesSettingsArr = new int[50]
    ; endif
    ; if behaviorHardSettingsArr.Length == 0
    ;     behaviorHardSettingsArr = new int[50]
    ; endif
    ; if behaviorProtectionArr.Length == 0
    ;     behaviorProtectionArr = new float[50]
    ; endif

    ; ;set rules template value
    ; _rulesTemplate = "Nudity,Bound,No Beds,Dismissed,Collared,Chastity,Boots,Corset,Gagged,Shackles,Piercing,Blindfold,Hood" ;,Anal Plug,Blindfold,Hood,Vaginal Plug"
    ; ;_rulesTemplateDisplayName = "Always Nude,Always Bound,No Beds,Dismissed,Collared,Chastity,Boots,Corset,Gagged,Shackles,Piercing"

    ; Int idx = 0
    ; _rulesArr = StringUtil.Split(_rulesTemplate, ",")

    ; int arrLen = _rulesArr.Length
    ; If _enabledArr.Length == 0
    ;     _enabledArr = new int[50]
    ;     ;TODO - loop and set all to 1
    ; EndIf

    ; If _activeArr.Length == 0
    ;     _activeArr = new int[50]
    ; EndIf

    ; If _likeArr.Length == 0
    ;     _likeArr = new int[50]
    ; EndIf

    ; If _ruleAddedDate.Length == 0
    ;     _ruleAddedDate = new float[50]
    ; EndIf

    ;FindInactiveRule()

EndFunction

; int Function HardLimitCount()
;     int count = 0
;     count = count + HardLimitAlwaysNude
;     count = count + HardLimitBound
;     count = count + HardLimitNoBeds
;     count = count + HardLimitDismissed
;     count = count + HardLimitCollar
;     count = count + HardLimitChastity
;     count = count + HardLimitShackles
;     count = count + HardLimitCorset
;     count = count + HardLimitBoots
;     count = count + HardLimitGagged
;     count = count + HardLimitPiercing
;     count = count + HardLimitBlindfold
;     count = count + HardLimitHood
;     return count
; EndFunction

Function ResetRules()



    ; behaviorRulesSettingsArr = new int[50]
    ; bondageRulesSettingsArr = new int[50]

    ; _enabledArr = new int[50]
    ; _activeArr = new int[50]
    ; _likeArr = new int[50]
EndFunction

; string[] function GetBondageRulesList() 
;     return bondageRulesArr
; endfunction

; string function GetBondageRuleByIndex(int i)
;     return bondageRulesArr[i]
; endfunction

int[] function GetBondageRulesSettingsList(Actor a)
    int idx = 0
    int[] list = new int[18]
    While idx < list.Length
        list[idx] = GetBondageRule(a, idx)
        idx += 1 
    EndWhile
    return list
endfunction

; int function GetBondageRuleSettingByIndex(int i)
;     return bondageRulesSettingsArr[i]
; endfunction

; function SetBondageRuleSettingByIndex(int i, int v)
;     bondageRulesSettingsArr[i] = v
; endfunction

; int[] function GetBondageHardLimitsList()
;     return bondageHardSettingsArr
; endfunction

; int function GetBondageHardLimitByIndex(int i)
;     return bondageHardSettingsArr[i]
; endfunction

; function SetBondageHardLimitByIndex(int i, int v)
;     bondageHardSettingsArr[i] = v
; endfunction

; function SetBondageProtectionByIndex(int i, int days)
;     bondageProtectionArr[i] = bind_Utility.AddTimeToCurrentTime(days, 0)
; endfunction

; int[] function GetBondageRuleToBondageTypeList()
;     return bondageRuleToBondageType
; endfunction

; int function GetBondageRuleByName(string ruleName)
;     int result = -1
;     int idx = 0
;     While idx < bondageRulesArr.Length
;         If bondageRulesArr[idx] == ruleName
;             result = bondageRulesSettingsArr[idx]
;             idx = bondageRulesArr.Length ;break loop
;         EndIf
;         idx += 1 
;     EndWhile
;     return result
; endfunction

; function SetBondageRuleByName(string ruleName, int ruleValue) 
;     int idx = 0
;     While idx < bondageRulesArr.Length
;         If bondageRulesArr[idx] == ruleName
;             bondageRulesSettingsArr[idx] = ruleValue
;             idx = bondageRulesArr.Length ;break loop
;         EndIf
;         idx += 1 
;     EndWhile
; endfunction

; string[] function GetBehaviorRulesList()
;     return behaviorRulesArr
; endfunction

; string function GetBehaviorRuleByIndex(int i)
;     return behaviorRulesArr[i]
; endfunction

int[] function GetBehaviorRulesSettingsList(Actor a)
    int idx = 0
    int[] list = new int[20]
    While idx < list.Length
        list[idx] = GetBehaviorRule(a, idx)
        idx += 1 
    EndWhile
    return list
endfunction

; int function GetBehaviorRuleSettingByIndex(int i)
;     return behaviorRulesSettingsArr[i]
; endfunction

; function SetBehaviorRuleSettingByIndex(int i, int v)
;     if behaviorRulesArr[i] == "Food Rule:Must Ask"
;         BehaviorFoodRuleMustAsk = v
;     elseif behaviorRulesArr[i] == "Entry/Exit Rule:Castle"
;         BehaviorEnterExitRuleCastle = v
;     elseif behaviorRulesArr[i] == "Entry/Exit Rule:Inn"
;         BehaviorEnterExitRuleInn = v
;     elseif behaviorRulesArr[i] == "Entry/Exit Rule:Player Home"
;         BehaviorEnterExitRulePlayerHome = v
;     elseif behaviorRulesArr[i] == "Studies:Ask To Train"
;         BehaviorStudiesAskToTrainMustAsk = v
;     elseif behaviorRulesArr[i] == "Indoors Rule:Dismissed"
;         BehaviorIndoorsRuleDismissed = v
;     endif
;     behaviorRulesSettingsArr[i] = v
; endfunction

; int[] function GetBehaviorHardLimitsList()
;     return behaviorHardSettingsArr
; endfunction

; int function GetBehaviorHardLimitByIndex(int i)
;     return behaviorHardSettingsArr[i]
; endfunction

; function SetBehaviorHardLimitByIndex(int i, int v)
;     behaviorHardSettingsArr[i] = v
; endfunction

; function SetBehaviorProtectionByIndex(int i, int days)
;     behaviorProtectionArr[i] = bind_Utility.AddTimeToCurrentTime(days, 0)
; endfunction

; int function GetBehaviorRuleByName(string ruleName)
;     int result = -1
;     int idx = 0
;     While idx < behaviorRulesArr.Length
;         If behaviorRulesArr[idx] == ruleName
;             result = behaviorRulesSettingsArr[idx]
;             idx = behaviorRulesArr.Length ;break loop
;         EndIf
;         idx += 1 
;     EndWhile
;     return result
; endfunction

; function SetBehaviorRuleByName(string ruleName, int ruleValue) 
;     int idx = 0
;     While idx < behaviorRulesArr.Length
;         If behaviorRulesArr[idx] == ruleName
;             behaviorRulesSettingsArr[idx] = ruleValue
;             if ruleName == "Food Rule:Must Ask"
;                 BehaviorFoodRuleMustAsk = ruleValue
;             elseif ruleName == "Entry/Exit Rule:Castle"
;                 BehaviorEnterExitRuleCastle = ruleValue
;             elseif ruleName == "Entry/Exit Rule:Inn"
;                 BehaviorEnterExitRuleInn = ruleValue
;             elseif ruleName == "Entry/Exit Rule:Player Home"
;                 BehaviorEnterExitRulePlayerHome = ruleValue
;             endif
;             idx = behaviorRulesArr.Length ;break loop
;         EndIf
;         idx += 1 
;     EndWhile
; endfunction


; int function FindFreeBehaviorRule()

;     ; int groupId = Utility.RandomInt(0, behaviorRulesGroupArr.Length - 1)
;     ; string groupName = behaviorRulesGroupArr[groupId]

;     return FindRandomRule(behaviorRulesSettingsArr, behaviorRulesArr.Length, false, behaviorHardSettingsArr, behaviorProtectionArr)

; endfunction

; int function FindActiveBehaviorRule()
;     return FindRandomRule(behaviorRulesSettingsArr, behaviorRulesArr.Length, true, behaviorHardSettingsArr, behaviorProtectionArr)
; endfunction

; int function FindFreeBondageRule()
;     return FindRandomRule(bondageRulesSettingsArr, bondageRulesArr.Length, false, bondageHardSettingsArr, bondageProtectionArr)
; endfunction

; int function FindActiveBondageRule()
;     return FindRandomRule(bondageRulesSettingsArr, bondageRulesArr.Length, true, bondageHardSettingsArr, bondageProtectionArr)
; endfunction

; int function FindRandomRule(int[] items, int count, bool inUse, int[] hard, float[] protect) ;need to pass in hard limits array and protection arrays
;     string buffer = "";

;     float currentTime = bind_Utility.GetTime()

;     int idx = 0
;     While idx < count

;         if (items[idx] == 0 && !inUse) || (items[idx] == 1 && inUse)

;             if (!inUse && hard[idx] == 0) || (inUse && protect[idx] < currentTime)
;                 ;protection array will look for inUse
;                 ;hard limits array will look for !inUse

;                 if buffer == ""
;                     buffer = idx
;                 else
;                     buffer = buffer + "," + idx
;                 endif
;             endif
;         endif

;         idx += 1 
;     EndWhile

;     string[] arr = StringUtil.Split(buffer, ",")

;     bind_Utility.WriteToConsole("inuse: " + inUse + " buffer: " + buffer)

;     if arr.length == 0
;         return -1
;     else
;         int rnd = Utility.RandomInt(0, arr.Length - 1)
;         return arr[rnd] as int
;     endif
; endfunction


int function GetActiveBondageRulesCount(Actor a)
    return StorageUtil.GetIntValue(a, "bind_active_bondage_rules", 0)
    ; int idx = 0
    ; int count = 0
    ; While idx < GetBondageRulesCount()
    ;     If GetBondageRule(a, idx) > 0
    ;         count += 1
    ;     EndIf
    ;     idx += 1 
    ; EndWhile
    ; return count
endfunction

int function GetActiveBehaviorRulesCount(Actor a)
    int idx = 0
    int count = 0
    While idx < GetBehaviorRulesCount()
        If GetBehaviorRule(a, idx) > 0
            count += 1
        EndIf
        idx += 1 
    EndWhile
    return count
endfunction

int function RULES_SUB_MANAGED()
    return 0
endfunction

int function RULES_DOM_MANAGED()
    return 1
endfunction

int function RULES_HYBRID_MANAGED()
    return 2
endfunction

; bool function SuspendedHeavyBondage()
;     if bind_GlobalSuspendHeavyBondage.GetValue() == 1
;         return true
;     else
;         return false
;     endif
; endfunction

; bool function SuspendedNudity()
;     if bind_GlobalSuspendNudity.GetValue() == 1
;         return true
;     else
;         return false
;     endif
; endfunction

bool function IsNudityRequired(Actor a, bool safeArea)
    ; if bind_GlobalRulesNudityRequired.GetValue() == 1.0
    ;     return true
    ; else

    ;TODO - have this work with safe locations and the safe option to determine if nudity is required
    ;vs. having the global suspend variable set

    int nudityRule = GetBehaviorRule(a, BEHAVIOR_RULE_NUDITY())
    int nudityRuleOption = GetBehaviorRuleOption(a, BEHAVIOR_RULE_NUDITY())

    bool onlySafeAreas = false
    if nudityRuleOption == RULE_OPTION_SAFE_AREAS() || nudityRuleOption == RULE_OPTION_PERMANENT_SAFE_AREAS()
        onlySafeAreas = true
    endif
        
    if (nudityRule == 1 && !onlySafeAreas) || (nudityRule == 1 && safeArea && onlySafeAreas) ;GetBehaviorRuleByName("Body Rule:Nudity") == 1
        return true
    else
        return false
    endif

endfunction

bool function IsBikiniRequired(Actor a, bool safeArea)

    int nudityRule = GetBehaviorRule(a, BEHAVIOR_RULE_BIKINI_ARMOR())
    int nudityRuleOption = GetBehaviorRuleOption(a, BEHAVIOR_RULE_BIKINI_ARMOR())

    bool onlySafeAreas = false
    if nudityRuleOption == RULE_OPTION_SAFE_AREAS() || nudityRuleOption == RULE_OPTION_PERMANENT_SAFE_AREAS()
        onlySafeAreas = true
    endif
        
    if (nudityRule == 1 && !onlySafeAreas) || (nudityRule == 1 && safeArea && onlySafeAreas) ;GetBehaviorRuleByName("Body Rule:Nudity") == 1
        return true
    else
        return false
    endif

endfunction

bool function IsEroticArmorRequired(Actor a, bool safeArea)

    int nudityRule = GetBehaviorRule(a, BEHAVIOR_RULE_EROTIC_ARMOR())
    int nudityRuleOption = GetBehaviorRuleOption(a, BEHAVIOR_RULE_EROTIC_ARMOR())

    bool onlySafeAreas = false
    if nudityRuleOption == RULE_OPTION_SAFE_AREAS() || nudityRuleOption == RULE_OPTION_PERMANENT_SAFE_AREAS()
        onlySafeAreas = true
    endif
        
    if (nudityRule == 1 && !onlySafeAreas) || (nudityRule == 1 && safeArea && onlySafeAreas) ;GetBehaviorRuleByName("Body Rule:Nudity") == 1
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
    if bondageRuleOption == RULE_OPTION_SAFE_AREAS() || bondageRuleOption == RULE_OPTION_PERMANENT_SAFE_AREAS()
        onlySafeAreas = true
    endif

    ;debug.MessageBox("onlySafeAreas: " + onlySafeAreas + " bondageRule: " + bondageRule)

    if (bondageRule == 1 && !onlySafeAreas) || (bondageRule == 1 && safeArea && onlySafeAreas) ; GetBondageRuleByName("Heavy Bondage Rule") == 1
        return true
    else
        return false
    endif

endfunction

function ClearLocationPermissions(Actor theSub)

   ;debug.MessageBox("this is happening??")

    BehaviorEnterExitRuleCastlePermission = 0
    BehaviorEnterExitRuleInnPermission = 0
    BehaviorEnterExitRulePlayerHomePermission = 0

    StorageUtil.SetIntValue(theSub, "bind_has_speech_permission", 0)
    StorageUtil.SetIntValue(theSub, "bind_has_prayer_permission", 0)

    StorageUtil.SetFloatValue(theSub, "bind_temp_speaking_permission", 0)

endfunction

function UpdateTimePermissions()

    float ct = bind_Utility.GetTime()

    if BehaviorFoodRuleMustAskPermission == 1
        if BehaviorFoodRuleMustAskEndTime < ct
            bind_Utility.WriteInternalMonologue("My food and drink permission has ended...")
            BehaviorFoodRuleMustAskPermission = 0
        endif
    endif

    if BehaviorStudiesAskToTrainPermission == 1
        If BehaviorStudiesAskToTrainEndTime < ct
            bind_Utility.WriteInternalMonologue("My training permission has ended...")
            BehaviorStudiesAskToTrainPermission = 0
        endif
    endif

endfunction

function BrokeEntryRule()
    UnregisterForUpdate()
    GotoState("BrokeEntryRuleState")
    RegisterForSingleUpdate(5.0)
endfunction

function BrokeExitRule()
    UnregisterForUpdate()
    GotoState("BrokeExitRuleState")
    RegisterForSingleUpdate(5.0)
endfunction

function TrainingRuleCheck()
    UnregisterForUpdate()
    GotoState("TrainingRuleCheckState")
    RegisterForSingleUpdate(5.0)
endfunction

event OnUpdate()
endevent

state BrokeEntryRuleState
    event OnUpdate()       
        bind_Functions fs = Quest.GetQuest("bind_MainQuest") as bind_Functions 
        fs.MarkSubBrokeRule("I did not have permission to enter...", true)
        GoToState("")
    endevent
endstate

state BrokeExitRuleState
    event OnUpdate()       
        bind_Functions fs = Quest.GetQuest("bind_MainQuest") as bind_Functions 
        fs.MarkSubBrokeRule("I did not have permission to exit...", true)
        GoToState("")
    endevent
endstate

state TrainingRuleCheckState
    event OnUpdate()       
        ;training check
        bind_Functions fs = Quest.GetQuest("bind_MainQuest") as bind_Functions
        int trainingCount = Game.QueryStat("Training Sessions")
        int storedTrainingCount = StorageUtil.GetIntValue(fs.GetSubRef(), "binding_training_sessions", 0)
        bind_Utility.WriteToConsole("TrainingRuleCheckState - training: " + trainingCount + " stored: " + storedTrainingCount + " perm: " + BehaviorStudiesAskToTrainPermission)
        if trainingCount != storedTrainingCount
            ;check permission
            if storedTrainingCount == 0
                ;do a warning first time?
                if BehaviorStudiesAskToTrainMustAsk == 1 && BehaviorStudiesAskToTrainPermission == 0
                    fs.WarnSubForBrokenRule("I was supposed to ask before training", true)
                endif
            else
                if BehaviorStudiesAskToTrainMustAsk == 1 && BehaviorStudiesAskToTrainPermission == 0
                    fs.MarkSubBrokeRule("I was supposed to ask before training", true)
                endif
            endif
            ;todo - make sure rules manager times this out??
            StorageUtil.SetIntValue(fs.GetSubRef(), "binding_training_sessions", trainingCount)
        endif
        GoToState("")
    endevent
endstate


;******************************************************************************************************************************

int function RULE_TYPE_BEHAVIOR()
    return 1
endfunction

int function RULE_TYPE_BONDAGE()
    return 2
endfunction


int function RULE_OPTION_HARD_LIMIT()
    return 1
endfunction

int function RULE_OPTION_SAFE_AREAS()
    return 2
endfunction

int function RULE_OPTION_PERMANENT()
    return 3
endfunction

int function RULE_OPTION_PERMANENT_SAFE_AREAS()
    return 4
endfunction

int function RULE_OPTION_UNSAFE_AREAS()
    return 5
endfunction

int function RULE_OPTION_PERMANENT_UNSAFE_AREAS()
    return 6
endfunction



string[] dRuleName
int dRuleCount

function _BuildDRulesArray()
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

int function GetBondageRulesCount()
    _BuildDRulesArray()
    return dRuleCount
endfunction

string[] function GetBondageRuleNameArray()
    _BuildDRulesArray()
    return dRuleName
endfunction

string function GetFriendlyBondageRuleName(int rule)
    _BuildDRulesArray()
    return dRuleName[rule]
endfunction





function SetBondageRule(Actor a, int rule, bool on) 

    ; int setting = 0
    ; if on
    ;     setting = 1
    ; endif

    ; StorageUtil.SetIntValue(a, "bind_brule_setting_" + rule, setting)

    if on
        StorageUtil.SetIntValue(a, "bind_rule_setting_" + rule, 1)
    else
        StorageUtil.SetIntValue(a, "bind_rule_setting_" + rule, 0)
    endif
    int active = 0
    int idx = 0
    While idx < 18
        active += StorageUtil.GetIntValue(a, "bind_rule_setting_" + idx, 0)
        idx += 1 
    EndWhile
    StorageUtil.SetIntValue(a, "bind_active_bondage_rules", active)
endfunction

int function GetBondageRule(Actor a, int rule)
    return StorageUtil.GetIntValue(a, "bind_rule_setting_" + rule, 0)
endfunction

function SetBondageRuleOption(Actor a, int rule, int option)
    StorageUtil.SetIntValue(a, "bind_rule_option_" + rule, option)
endfunction

int function GetBondageRuleOption(Actor a, int rule)
    return StorageUtil.GetIntValue(a, "bind_rule_option_" + rule, 0)
endfunction

function SetBondageRuleEnd(Actor a, int rule, float endTime)
    StorageUtil.SetFloatValue(a, "bind_rule_end_" + rule, endTime)
endfunction

float function GetBondageRuleEnd(Actor a, int rule)
    return StorageUtil.GetFloatValue(a, "bind_rule_end_" + rule, 0.0)
endfunction

string function FindOpenBondageRulesByName(Actor a)
    string list = ""
    int idx = 0
    While idx < 18
        string ruleName = dRuleName[idx]
        int bondageRule = GetBondageRule(a, idx)
        int bondageRuleOption = GetBondageRuleOption(a, idx)
        if bondageRuleOption != RULE_OPTION_HARD_LIMIT() && bondageRule == 0
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





string[] bRuleName
int bRuleCount

function _BuildBRulesArray()
    bRuleCount = 22
    if bRuleName.Length != bRuleCount
        bRuleName = new String[22]
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
        bRuleName[20] = "Body Rule:Bikini Armor"
        bRuleName[21] = "Body Rule:Erotic Armor"
    endif
endfunction

int function GetBehaviorRulesCount()
    _BuildBRulesArray()
    return bRuleCount
endfunction

string[] function GetBehaviorRuleNameArray()
    _BuildBRulesArray()
    return bRuleName
endfunction

string function GetFriendlyBehaviorRuleName(int rule)
    _BuildBRulesArray()
    return bRuleName[rule]
endfunction

int function BEHAVIOR_RULE_NUDITY()
    return 0
endfunction

int function BEHAVIOR_RULE_NO_BED()
    return 1
endfunction

int function BEHAVIOR_RULE_DISMISSED()
    return 2
endfunction

int function BEHAVIOR_RULE_PRAYER_NO_SHOES()
    return 3
endfunction

int function BEHAVIOR_RULE_PRAYER_NUDITY()
    return 4
endfunction

int function BEHAVIOR_RULE_PRAYER_MUST_POSE()
    return 5
endfunction

int function BEHAVIOR_RULE_PRAYER_MUST_ASK()
    return 6
endfunction

int function BEHAVIOR_RULE_PRAYER_CLEAN()
    return 7
endfunction

int function BEHAVIOR_RULE_PRAYER_WHIPPED()
    return 8
endfunction

int function BEHAVIOR_RULE_SPEECH_DOM()
    return 9
endfunction

int function BEHAVIOR_RULE_SPEECH_ASK()
    return 10
endfunction

int function BEHAVIOR_RULE_SPEECH_POSE()
    return 11
endfunction

int function BEHAVIOR_RULE_ENTRY_CASTLE()
    return 12
endfunction

int function BEHAVIOR_RULE_ENTRY_INN()
    return 13
endfunction

int function BEHAVIOR_RULE_ENTRY_PLAYER_HOME()
    return 14
endfunction

int function BEHAVIOR_RULE_FOOD_ASK()
    return 15
endfunction

int function BEHAVIOR_RULE_FOOD_SIT_ON_FLOOR()
    return 16
endfunction

int function BEHAVIOR_RULE_SEX_GIVE_THANKS()
    return 17
endfunction

int function BEHAVIOR_RULE_ASK_READ_SCROLL()
    return 18
endfunction

int function BEHAVIOR_RULE_ASK_TO_TRAIN()
    return 19
endfunction

int function BEHAVIOR_RULE_BIKINI_ARMOR()
    return 20
endfunction

int function BEHAVIOR_RULE_EROTIC_ARMOR()
    return 21
endfunction

int activeBondageRules
int activeBehaviorRules

string function FindExpiredBondageRules(Actor a)
    string list = ""
    activeBondageRules = 0
    int opt
    float endTime
    float ct = bind_Utility.GetTime()
    int i = 0
    while i < GetBondageRulesCount()
        if GetBondageRule(a, i) == 1
            activeBondageRules += 1
            opt = GetBondageRuleOption(a, i)
            endTime = GetBondageRuleEnd(a, i)
            if !(opt == RULE_OPTION_PERMANENT() || opt == RULE_OPTION_PERMANENT_SAFE_AREAS() || opt == RULE_OPTION_PERMANENT_UNSAFE_AREAS()) && ct > endTime ;permanent rules never get removed
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

string function FindExpiredBehaviorRules(Actor a)
    string list = ""
    activeBehaviorRules = 0
    int opt
    float endTime
    float ct = bind_Utility.GetTime()
    int i = 0
    while i < GetBehaviorRulesCount()
        if GetBehaviorRule(a, i) == 1
            activeBehaviorRules += 1
            opt = GetBehaviorRuleOption(a, i)
            endTime = GetBehaviorRuleEnd(a, i)
            if !(opt == RULE_OPTION_PERMANENT() || opt == RULE_OPTION_PERMANENT_SAFE_AREAS() || opt == RULE_OPTION_PERMANENT_UNSAFE_AREAS()) && ct > endTime ;permanent rules never get removed
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
            if !opt == RULE_OPTION_HARD_LIMIT()
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
            if !opt == RULE_OPTION_HARD_LIMIT()
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

; int function FindExpiredRule(Actor a, int ruleType)

;     bind_Utility.WriteToConsole("starting FindExpiredRule - ruleType: " + ruleType)

;     int result = -1

;     if ruleType == 0
;         return result
;     endif

;     int i = 0

;     int rule
;     int opt
;     float endTime
;     float lastEndTime = 0.0

;     int max
;     if ruleType == RULE_TYPE_BEHAVIOR()
;         max = GetBehaviorRulesCount()
;     elseif ruleType == RULE_TYPE_BONDAGE()
;         max = GetBondageRulesCount()
;     endif

;     float ct = bind_Utility.GetTime()

;     while i < max
;         ;bind_Utility.WriteToConsole("testing rule: " + i)
;         if ruleType == RULE_TYPE_BEHAVIOR()
;             rule = GetBehaviorRule(a, i)
;         elseif ruleType == RULE_TYPE_BONDAGE()
;             rule = GetBondageRule(a, i)
;         endif
;         if rule == 1 ;look at active rules
;             if ruleType == RULE_TYPE_BEHAVIOR()
;                 opt = GetBehaviorRuleOption(a, i)
;                 endTime = GetBehaviorRuleEnd(a, i)
;             elseif ruleType == RULE_TYPE_BONDAGE()
;                 opt = GetBondageRuleOption(a, i)
;                 endTime = GetBondageRuleEnd(a, i)
;             endif
;             if !(opt == RULE_OPTION_PERMANENT() || opt == RULE_OPTION_PERMANENT_SAFE_AREAS() || opt == RULE_OPTION_PERMANENT_UNSAFE_AREAS()) && ct > endTime ;permanent rules never get removed
;                 if endTime < lastEndTime || lastEndTime == 0.0
;                     lastEndTime = endTime
;                     result = i
;                 endif
;             endif
;         endif
;         i += 1
;     endwhile

;     bind_Utility.WriteToConsole("FindExpiredRule max: " + max + " ruleType: " + ruleType + " oldest expired rule result: " + result)

;     return result

; endfunction

; int function FindOpenRule(Actor a, int ruleType) ;1 - behavior, 2 - bondage
    
;     bind_Utility.WriteToConsole("starting FindOpenRule - ruleType: " + ruleType)

;     int result = -1

;     if ruleType == 0
;         return result
;     endif

;     int[] openRules = new int[25]

;     int oi = 0
;     int i = 0

;     while i < openRules.Length
;         openRules[i] = -1
;         i += 1
;     endwhile

;     int rule
;     int opt

;     int max
;     if ruleType == RULE_TYPE_BEHAVIOR()
;         max = GetBehaviorRulesCount()
;     elseif ruleType == RULE_TYPE_BONDAGE()
;         max = GetBondageRulesCount()
;     endif

;     i = 0
;     while i < max
;         if ruleType == RULE_TYPE_BEHAVIOR()
;             rule = GetBehaviorRule(a, i)
;         elseif ruleType == RULE_TYPE_BONDAGE()
;             rule = GetBondageRule(a, i)
;         endif
;         bind_Utility.WriteToConsole("check " + i + " rule: " + rule)
;         if rule == 0 ;look at inactive rules
;             if ruleType == RULE_TYPE_BEHAVIOR()
;                 opt = GetBehaviorRuleOption(a, i)
;             elseif ruleType == RULE_TYPE_BONDAGE()
;                 opt = GetBondageRuleOption(a, i)
;             endif
;             if !opt == RULE_OPTION_HARD_LIMIT()
;                 openRules[oi] = i 
;                 oi += 1
;             endif
;         endif
;         i += 1
;     endwhile

;     bind_Utility.WriteToConsole("FindOpenRule - openRules[]: " + openRules)

;     if oi > 0
;         int rnd = Utility.RandomInt(0, oi - 1)
;         result = openRules[rnd]
;     endif

;     bind_Utility.WriteToConsole("FindOpenRule max: " + max + " ruleType: " + ruleType + " result: " + result)

;     return result

; endfunction

function SetBehaviorRule(Actor a, int rule, bool on) 
    
    int setting = 0
    if on
        setting = 1
    endif

    StorageUtil.SetIntValue(a, "bind_brule_setting_" + rule, setting)
    if rule == BEHAVIOR_RULE_DISMISSED()
        BehaviorIndoorsRuleDismissed = setting
    elseif rule == BEHAVIOR_RULE_ASK_TO_TRAIN()
        BehaviorStudiesAskToTrainMustAsk = setting
    elseif rule == BEHAVIOR_RULE_ASK_READ_SCROLL()
        BehaviorRuleLearnSpell = setting
    elseif rule == BEHAVIOR_RULE_FOOD_ASK()
        BehaviorFoodRule = setting
    elseif rule == BEHAVIOR_RULE_PRAYER_MUST_ASK()
        BehaviorRulePrayer = setting

    elseif rule == BEHAVIOR_RULE_ENTRY_CASTLE()
        BehaviorEnterExitRuleCastle = setting
    elseif rule == BEHAVIOR_RULE_ENTRY_INN()
        BehaviorEnterExitRuleInn = setting
    elseif rule == BEHAVIOR_RULE_ENTRY_PLAYER_HOME()
        BehaviorEnterExitRulePlayerHome = setting

    elseif rule == BEHAVIOR_RULE_BIKINI_ARMOR()
        BehaviorRuleBikiniArmor = setting
        BehaviorRuleEroticArmor = 0
        StorageUtil.SetIntValue(a, "bind_brule_setting_" + BEHAVIOR_RULE_EROTIC_ARMOR(), 0)
    elseif rule == BEHAVIOR_RULE_EROTIC_ARMOR()
        BehaviorRuleEroticArmor = setting
        BehaviorRuleBikiniArmor = 0
        StorageUtil.SetIntValue(a, "bind_brule_setting_" + BEHAVIOR_RULE_BIKINI_ARMOR(), 0)
    
    elseif rule == BEHAVIOR_RULE_SPEECH_ASK()
        BehaviorRuleSpeechAsk = setting
        
    
        ;elseif other rules??

    

    endif

    if BehaviorEnterExitRuleCastle == 1 || BehaviorEnterExitRuleInn == 1 || BehaviorEnterExitRulePlayerHome == 1
        BehaviorEnterExitRule = 1
    else
        BehaviorEnterExitRule = 0
    endif

endfunction

int function GetBehaviorRule(Actor a, int rule)
    return StorageUtil.GetIntValue(a, "bind_brule_setting_" + rule, 0)
endfunction

function SetBehaviorRuleOption(Actor a, int rule, int option)
    StorageUtil.SetIntValue(a, "bind_brule_option_" + rule, option)
endfunction

int function GetBehaviorRuleOption(Actor a, int rule)
    return StorageUtil.GetIntValue(a, "bind_brule_option_" + rule, 0)
endfunction

function SetBehaviorRuleEnd(Actor a, int rule, float endTime)
    StorageUtil.SetFloatValue(a, "bind_brule_end_" + rule, endTime)
endfunction

float function GetBehaviorRuleEnd(Actor a, int rule)
    return StorageUtil.GetFloatValue(a, "bind_brule_end_" + rule, 0.0)
endfunction

function SetBehaviorRulePermission(Actor a, int rule, int permission)
    StorageUtil.SetIntValue(a, "bind_brule_perm_" + rule, permission)
endfunction

int function GetBehaviorRulePermission(Actor a, int rule)
    return StorageUtil.GetIntValue(a, "bind_brule_perm_" + rule, 0)
endfunction



function ManageRules(Actor a)

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("Behavior Rules")
    ;listMenu.AddEntryItem("Bondage Rules")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ManageBehaviorRules(a)
    ; elseif listReturn == 1
    ;     ManageBondageRules(a)
    endif

endfunction

function ManageBehaviorRules(Actor a)
    
    _BuildBRulesArray()
 
    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Back")

    int i = 0
    while i < bRuleName.Length
        int onFlag = GetBehaviorRule(a, i)
        int optionsFlag = GetBehaviorRuleOption(a, i)
        string extraText = BuildExtraText(onFlag, optionsFlag)
        listMenu.AddEntryItem(bRuleName[i] + extraText)
        i += 1
    endwhile

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ManageRules(a)
    elseif listReturn > 0
        ViewBehaviorRule(a, listReturn - 1)
    endif

endfunction

function ViewBehaviorRule(Actor a, int rule)

    int controlMode = bind_GlobalRulesControlledBy.GetValue() as int

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
   
    listMenu.AddEntryItem("<-- Behavior Rules")

    string ruleName = bRuleName[rule]
    int onFlag = GetBehaviorRule(a, rule)
    int optionsFlag = GetBehaviorRuleOption(a, rule)

    if onFlag == 1
        ruleName += " [ON"
        if controlMode == RULES_DOM_MANAGED() || controlMode == RULES_HYBRID_MANAGED()
            float ruleEndTime = GetBehaviorRuleEnd(a, rule)
            float hoursLeft = (ruleEndTime - bind_Utility.GetTime()) * 24.0
            ruleName += " " + Math.Ceiling(hoursLeft) + "h"
        endif
        ruleName += "]"
    else
        ruleName += " [OFF]"
    endif

    listMenu.AddEntryItem(ruleName)

    DisplayRuleOptions(listMenu, optionsFlag)

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ManageBehaviorRules(a)
    endif

    if listReturn == 1
        if controlMode == RULES_DOM_MANAGED()
        elseif controlMode == RULES_SUB_MANAGED()
            if listReturn == 1
                if onFlag == 1
                    SetBehaviorRule(a, rule, false)
                else
                    SetBehaviorRule(a, rule, true)
                    if rule == BEHAVIOR_RULE_NUDITY()
                        StorageUtil.SetIntValue(a, "bind_safe_area_interaction_check", 3) ;set to to-do
                        bind_GlobalRulesUpdatedFlag.SetValue(1)
                    endif
                endif
            endif
        elseif controlMode == RULES_HYBRID_MANAGED()
        endif
        ViewBehaviorRule(a, rule)
    endif

    if listReturn > 1
        if controlMode == RULES_SUB_MANAGED() || controlMode == RULES_HYBRID_MANAGED()
            int optionSelect = -1
            if listReturn == 2
                optionSelect = 2
            elseif listReturn == 3
                optionSelect = 5
            endif
            bind_Utility.WriteNotification("optionSelect: " + optionSelect + " optionsFlag: " + optionsFlag)
            if optionSelect == optionsFlag
                optionSelect = 0 ;toggled turn off
            endif
            SetBehaviorRuleOption(a, rule, optionSelect)
            ;bind_GlobalRulesUpdatedFlag.SetValue(1)
            ;StorageUtil.SetIntValue(a, "bind_safe_area_interaction_check", 3) ;set to to-do
            ViewBehaviorRule(a, rule)
        else
            int optionSelect = (listReturn - 1)
            if optionSelect == optionsFlag
                optionSelect = 0 ;toggled turn off
            endif
            SetBehaviorRuleOption(a, rule, optionSelect)
            ;bind_GlobalRulesUpdatedFlag.SetValue(1)
            ;StorageUtil.SetIntValue(a, "bind_safe_area_interaction_check", 3) ;set to to-do
            ViewBehaviorRule(a, rule)
        endif

        ; int optionSelect = (listReturn - 1)
        ; if optionSelect == optionsFlag
        ;     optionSelect = 0 ;toggled turn off
        ; endif
        ; SetBehaviorRuleOption(a, rule, optionSelect)
        ; ViewBehaviorRule(a, rule)
    endif

endfunction

function ManageBondageRules(Actor a)

    _BuildDRulesArray()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Back")

    int i = 0
    while i < dRuleName.Length
        int onFlag = GetBondageRule(a, i)
        int optionsFlag = GetBondageRuleOption(a, i)
        string extraText = BuildExtraText(onFlag, optionsFlag)
        listMenu.AddEntryItem(dRuleName[i] + extraText)
        i += 1
    endwhile

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ManageRules(a)
    elseif listReturn > 0
        ViewBondageRule(a, listReturn - 1)
    endif

endfunction

function ViewBondageRule(Actor a, int rule)

    int controlMode = bind_GlobalRulesControlledBy.GetValue() as int
    
    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Bondage Rules")

    string ruleName = dRuleName[rule]
    int onFlag = GetBondageRule(a, rule)
    int optionsFlag = GetBondageRuleOption(a, rule)

    if onFlag == 1
        ruleName += " [ON"
        if controlMode == RULES_DOM_MANAGED() || controlMode == RULES_HYBRID_MANAGED()
            float ruleEndTime = GetBondageRuleEnd(a, rule)
            float hoursLeft = (ruleEndTime - bind_Utility.GetTime()) * 24.0
            ruleName += " " + Math.Ceiling(hoursLeft) + "h"
        endif
        ruleName += "]"
    else
        ruleName += " [OFF]"
    endif

    listMenu.AddEntryItem(ruleName)

    DisplayRuleOptions(listMenu, optionsFlag)

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ManageBondageRules(a)
    endif

    if listReturn == 1
        if controlMode == RULES_DOM_MANAGED()
        elseif controlMode == RULES_SUB_MANAGED()
            if listReturn == 1
                if onFlag == 1
                    SetBondageRule(a, rule, false)
                else
                    SetBondageRule(a, rule, true)
                endif
                bind_GlobalRulesUpdatedFlag.SetValue(1)
                StorageUtil.SetIntValue(a, "bind_safe_area_interaction_check", 3) ;set to to-do
            endif
        elseif controlMode == RULES_HYBRID_MANAGED()
        endif
        ViewBondageRule(a, rule)
    endif

    if listReturn > 1
        if controlMode == RULES_SUB_MANAGED() || controlMode == RULES_HYBRID_MANAGED()
            int optionSelect = -1
            if listReturn == 2
                optionSelect = 2
            elseif listReturn == 3
                optionSelect = 5
            endif
            bind_Utility.WriteNotification("optionSelect: " + optionSelect + " optionsFlag: " + optionsFlag)
            if optionSelect == optionsFlag
                optionSelect = 0 ;toggled turn off
            endif
            SetBondageRuleOption(a, rule, optionSelect)
            bind_GlobalRulesUpdatedFlag.SetValue(1)
            StorageUtil.SetIntValue(a, "bind_safe_area_interaction_check", 3) ;set to to-do
            ViewBondageRule(a, rule)
        else
            int optionSelect = (listReturn - 1)
            if optionSelect == optionsFlag
                optionSelect = 0 ;toggled turn off
            endif
            SetBondageRuleOption(a, rule, optionSelect)
            bind_GlobalRulesUpdatedFlag.SetValue(1)
            StorageUtil.SetIntValue(a, "bind_safe_area_interaction_check", 3) ;set to to-do
            ViewBondageRule(a, rule)
        endif
    endif

endfunction

function DisplayRuleOptions(UIListMenu listMenu, int optionsFlag)

    int controlMode = bind_GlobalRulesControlledBy.GetValue() as int

    bind_Utility.WriteNotification("controlMode: " + controlMode)

    if controlMode == RULES_SUB_MANAGED() || controlMode == RULES_HYBRID_MANAGED()

        if optionsFlag == RULE_OPTION_SAFE_AREAS()
            listMenu.AddEntryItem("Option - Safe Areas [ON]")
        else
            listMenu.AddEntryItem("Option - Safe Areas")
        endif

        if optionsFlag == RULE_OPTION_UNSAFE_AREAS()
            listMenu.AddEntryItem("Option - Unsafe Areas [ON]")
        else
            listMenu.AddEntryItem("Option - Unsafe Areas")
        endif

    endif

    if controlMode == RULES_DOM_MANAGED()

        if optionsFlag == RULE_OPTION_HARD_LIMIT()
            listMenu.AddEntryItem("Option - Hard Limit [ON]")
        else
            listMenu.AddEntryItem("Option - Hard Limit")
        endif

        if optionsFlag == RULE_OPTION_SAFE_AREAS()
            listMenu.AddEntryItem("Option - Safe Areas [ON]")
        else
            listMenu.AddEntryItem("Option - Safe Areas")
        endif

        if optionsFlag == RULE_OPTION_PERMANENT()
            listMenu.AddEntryItem("Option - Permanent [ON]")
        else
            listMenu.AddEntryItem("Option - Permanent")
        endif
        
        if optionsFlag == RULE_OPTION_PERMANENT_SAFE_AREAS()
            listMenu.AddEntryItem("Option - Permanent Safe Areas [ON]")
        else
            listMenu.AddEntryItem("Option - Permanent Safe Areas")
        endif
        
        if optionsFlag == RULE_OPTION_UNSAFE_AREAS()
            listMenu.AddEntryItem("Option - Unsafe Areas [ON]")
        else
            listMenu.AddEntryItem("Option - Unsafe Areas")
        endif

        if optionsFlag == RULE_OPTION_PERMANENT_UNSAFE_AREAS()
            listMenu.AddEntryItem("Option - Permanent Unsafe Areas [ON]")
        else
            listMenu.AddEntryItem("Option - Permanent Unsafe Areas")
        endif

    endif
    
endfunction

string function BuildExtraText(int onFlag, int optionsFlag)
    string extraText = ""
    if optionsFlag == RULE_OPTION_HARD_LIMIT()
        extraText += " Hard Limit"
    elseif optionsFlag == RULE_OPTION_PERMANENT()
        extraText += " Permanent"
    elseif optionsFlag == RULE_OPTION_PERMANENT_SAFE_AREAS()
        extraText += " Permanent Safe"
    elseif optionsFlag == RULE_OPTION_PERMANENT_UNSAFE_AREAS()
        extraText += " Permanent Unsafe"
    elseif optionsFlag == RULE_OPTION_SAFE_AREAS()
        extraText += " Safe"
    elseif optionsFlag == RULE_OPTION_UNSAFE_AREAS()
        extraText += " Unsafe"
    endif
    if onFlag == 1
        extraText += " [ON]"
    endif
    if extraText != ""
        extraText = " -" + extraText
    endif
    return extraText
endfunction



string function PickAction(string expBondage, string expBehavior, string openBondage, string openBehavior)

    string canDo = ""
    string result = ""
    
    if expBondage != "" && (bind_GlobalRulesBondageMin.GetValue() < activeBondageRules)
        canDo = "1"
    endif
    if expBehavior != "" && (bind_GlobalRulesBehaviorMin.GetValue() < activeBehaviorRules)
        if canDo != ""
            canDo += "|"
        endif
        canDo += "2"
    endif
    if openBondage != "" && (bind_GlobalRulesBondageMax.GetValue() > activeBondageRules)
        if canDo != ""
            canDo += "|"
        endif
        canDo += "3"
    endif
    if openBehavior != "" && (bind_GlobalRulesBehaviorMax.GetValue() > activeBehaviorRules)
        if canDo != ""
            canDo += "|"
        endif
        canDo += "4"
    endif

    bind_Utility.WriteToConsole("canDo: " + canDo)

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

    bind_Utility.WriteToConsole("expiredBondageRules: " + expiredBondageRules)
    bind_Utility.WriteToConsole("expiredBehaviorRules: " + expiredBehaviorRules)
    bind_Utility.WriteToConsole("openBondageRules: " + openBondageRules)
    bind_Utility.WriteToConsole("openBehaviorRules: " + openBehaviorRules)
    bind_Utility.WriteToConsole("active rules bondage: " + activeBondageRules + " behavior: " + activeBehaviorRules)
    bind_Utility.WriteToConsole("max rules bondage: " + bind_GlobalRulesBondageMax.GetValue() + " behavior: " + bind_GlobalRulesBehaviorMax.GetValue())
    bind_Utility.WriteToConsole("min rules bondage: " + bind_GlobalRulesBondageMin.GetValue() + " behavior: " + bind_GlobalRulesBehaviorMin.GetValue())

    string selectedAction = PickAction(expiredBondageRules, expiredBehaviorRules, openBondageRules, openBehaviorRules)

    bind_Utility.WriteToConsole("selectedAction: " + selectedAction)

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
                SetBondageRuleEnd(theSub, rule, bind_Utility.AddTimeToCurrentTime(Utility.RandomInt(24, 96), 0))
            elseif actionType == "4"
                SetBehaviorRule(theSub, rule, 1)
                SetBehaviorRuleEnd(theSub, rule, bind_Utility.AddTimeToCurrentTime(Utility.RandomInt(24, 96), 0))               
            endif

            debug.MessageBox("Action: " + actionType + " Rule: " + rule)

        endif
    endif

    return selectedAction

endfunction


; bind_BondageManager property bbm auto
; bind_MainQuestScript property mqs auto

GlobalVariable property bind_GlobalSuspendHeavyBondage auto
GlobalVariable property bind_GlobalSuspendNudity auto
GlobalVariable property bind_GlobalRulesNudityRequired auto
GlobalVariable property bind_GlobalRulesControlledBy auto
GlobalVariable property bind_GlobalRulesUpdatedFlag auto

GlobalVariable property bind_GlobalRulesBehaviorMax auto
GlobalVariable property bind_GlobalRulesBondageMax auto
GlobalVariable property bind_GlobalRulesBehaviorMin auto
GlobalVariable property bind_GlobalRulesBondageMin auto


;**********************************
;ideas
;**********************************
;dom wants to stay in inn - sub has to follow them around and kneel at their feet as they sit and move about
