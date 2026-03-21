Scriptname bindc_Rules extends Quest  


Actor thePlayer

event OnInit()
    thePlayer = Game.GetPlayer()
endevent

event LoadGame()

endevent

function BuildStorageArrays(Actor dom) global

    if StorageUtil.GetIntValue(dom, "bindc_created_rules_arrays", 0) == 0

        int[] blankArray
        blankArray = Utility.ResizeIntArray(blankArray, 25, 0)

        ;debug.MessageBox(blankArray)

        float[] blankArrayFloat
        blankArrayFloat = Utility.ResizeFloatArray(blankArrayFloat, 25, 0.0)

        StorageUtil.IntListCopy(dom, "bindc_bondage_rules_state", blankArray)
        StorageUtil.IntListCopy(dom, "bindc_bondage_rules_option", blankArray)
        StorageUtil.FloatListCopy(dom, "bindc_bondage_rules_expire", blankArrayFloat)
        StorageUtil.IntListCopy(dom, "bindc_slave_rules_state", blankArray)
        StorageUtil.IntListCopy(dom, "bindc_slave_rules_option", blankArray)
        StorageUtil.FloatListCopy(dom, "bindc_slave_rules_expire", blankArrayFloat)
        ;randomly enable rules at creation??

        ;Utility.ResizeIntArray()

        StorageUtil.SetIntValue(dom, "bindc_created_rules_arrays", 1)

    endif

endfunction

int[] function GetBondageRules(Actor dom) global
    bindc_Rules.BuildStorageArrays(dom)
    return StorageUtil.IntListToArray(dom, "bindc_bondage_rules_state")
endfunction


int[] function GetBondageRuleOptions(Actor dom) global
    bindc_Rules.BuildStorageArrays(dom)
    return StorageUtil.IntListToArray(dom, "bindc_bondage_rules_option")
endfunction

float[] function GetBondageRuleExpires(Actor dom) global
    bindc_Rules.BuildStorageArrays(dom)
    return StorageUtil.FloatListToArray(dom, "bindc_bondage_rules_expire")
endfunction

float[] function GetBondageRule(Actor dom, int idx) global
    float[] result = new float[3]
    bindc_Rules.BuildStorageArrays(dom)
    result[0] = StorageUtil.IntListGet(dom, "bindc_bondage_rules_state", idx)
    result[1] = StorageUtil.IntListGet(dom, "bindc_bondage_rules_option", idx)
    result[2] = StorageUtil.FloatListGet(dom, "bindc_bondage_rules_expire", idx)
    return result
endfunction

function SetBondageRule(Actor dom, int idx, int ruleState = -1, int ruleOption = -1, float expires = 0.0) global
    if ruleState > -1
        StorageUtil.IntListSet(dom, "bindc_bondage_rules_state", idx, ruleState)
    endif
    if ruleOption > -1
        StorageUtil.IntListSet(dom, "bindc_bondage_rules_option", idx, ruleOption)
    endif
    if expires > 0.0
        StorageUtil.FloatListSet(dom, "bindc_bondage_rules_expire", idx, expires)
    endif
endfunction

string[] function GetBondageRuleNames() global
    string names = "Nipple Piercing Rule|Vaginal Piercing Rule|Anal Plug Rule|Vaginal Plug Rule|Suit Rule|Harness Rule|Heavy Bondage Rule|Cuffs Rule|"
    names += "Gloves Rule|Boots Rule|Ankle Shackles Rule|Hood Rule|Blindfold Rule|Gag Rule|Collar Rule"
    return StringUtil.Split(names, "|")
endfunction

string function GetBondageRuleName(int idx) global
    string names = "Nipple Piercing Rule|Vaginal Piercing Rule|Anal Plug Rule|Vaginal Plug Rule|Suit Rule|Harness Rule|Heavy Bondage Rule|Cuffs Rule|"
    names += "Gloves Rule|Boots Rule|Ankle Shackles Rule|Hood Rule|Blindfold Rule|Gag Rule|Collar Rule"
    string[] arr = StringUtil.Split(names, "|")
    return arr[idx]
endfunction

string[] function GetBondageKeywords() global
    string keywordsList = "zad_DeviousPiercingsNipple|zad_DeviousPiercingsVaginal|zad_DeviousPlugAnal|zad_DeviousPlugVaginal|zad_DeviousSuit|zad_DeviousHarness,zad_DeviousCorset,zad_DeviousBelt|"
    keywordsList += "zad_DeviousArmCuffs,zad_DeviousLegCuffs|zad_DeviousGloves|zad_DeviousBoots|zad_DeviousAnkleShackles|zad_DeviousHood|zad_DeviousBlindfold|"
    keywordsList += "zad_DeviousGag|zad_DeviousCollar"
    return StringUtil.Split(keywordsList, "|")
endfunction