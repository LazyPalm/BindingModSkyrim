Scriptname bind_ThinkingDom extends Quest conditional

int property EnableActionDressingRoom auto conditional
int property EnableActionBed auto conditional
int property EnableActionWhip auto conditional
int property EnableActionSex auto conditional
int property EnableActionFurniture auto conditional
int property EnableActionHarshBondage auto conditional
int property EnableActionCamping auto conditional

;possibility for random basic personality traits?

;trust indicators (lie modifier)
;fatigue indicators
;homesick

bool likesCreated

;materials tracking
;items tracking
;location tracking
;previous events tracking and feedback

;isplayerinregion = weathersnow

;determine cold by location and altitude? Not everybody will have frostfall or the surival mode in AE.


int arrayCreated

bool chimSentBindingCommand

Actor theSubRef
Actor theDomRef
string pronounHimHer
string pronounHeShe
string pronounHisHer
string pronounHisHers
string domName

float llmTemp = 0.699999988
int maxTokens = 1024
int skyrimNetRegistered = 0

bind_ThinkingDom function GetThinkingDom() global
    return Quest.GetQuest("bind_MainQuest") as bind_ThinkingDom
endfunction

Function LoadGame(bool rebuildStorage = false)
    
    _SetupStorage(rebuildStorage)
    _SetLikes()
    ;for testing
    ;RulesInEffect = 3

    theSubRef = fs.GetSubRef()
    theDomRef = fs.GetDomRef()

    domName = ""
    if theDomRef
        domName = theDomRef.GetDisplayName()
    endif

    pronounHimHer = "him"
    pronounHeShe = "he"
    pronounHisHer = "his"
    pronounHisHers = "his"

    if theSubRef.GetActorBase().GetSex() == 1
        pronounHimHer = "her"
        pronounHeShe = "she"
        pronounHisHer = "her"
        pronounHisHers = "hers"
    endif

    RegisterForModEvent("bind_EnteringSafeAreaEvent", "EnteringSafeAreaEvent")
    RegisterForModEvent("bind_LeavingSafeAreaEvent", "LeavingSafeAreaEvent")
    RegisterForModEvent("bind_ConversationPoseEvent", "ConversationPoseEvent")

    RegisterForModEvent("bind_SubKneeledEvent", "SubKneeledEvent") ;kneeling event
    RegisterForModEvent("bind_SubLeftKneelEvent", "SubLeftKneelEvent")
    RegisterForModEvent("bind_SubLookedAtFurnitureEvent", "SubLookedAtFurnitureEvent")

    if main.SoftCheckSkyrimNet == 1 ;&& main.EnableModSkyrimNet == 1
        RegisterDecorators()
        RegisterFunctions()
    endif

EndFunction

function RegisterDecorators()

    bind_Utility.WriteToConsole("Registering SkyrimNet decorators")

    ;is dom
    ;is sub - this is always player for now - but might expand
    ;is potential dom - for defeated quest

    ;add furniture description decorator
        ;use this for knowing what kind of furniture sub will be locked into
        ;and use it to describe the furniture the sub is locked into (for dom teasing/comments - crowd comments)
        ;maybe have an optional long furinture description in a JSON file that could be created and then loaded in??

    ;punishments due decorator

    ;not noticed decorator - so the dom can make comments about how they think the sub is up to something

    ;rules decorators

    ;bondage decorators

    ; SkyrimNetApi.RegisterDecorator("binding_is_dom", "bind_ThinkingDom", "DecoratorIsDom")

    ; SkyrimNetApi.RegisterDecorator("binding_info", "bind_ThinkingDom", "DecoratorInfo")

endfunction

function RegisterFunctions()

    if skyrimNetRegistered != 1 ;NOTE - this is an integer vs. bool so it can be incremented up to force a new registration of actions/decoractors

        ;TODO: move registeractions into here

        skyrimNetRegistered = 1
    
    endif

    bind_Utility.WriteToConsole("Registering SkyrimNet actions")

    ;SkyrimNetApi.RegisterDecorator("get_hour", "bind_ThinkingDom", "Decorator_Function")

    ; SkyrimNetApi.RegisterAction("ExtCmdBindingTieWrists", "Bind {{ player.name }}'s wrists.", \
    ;                                 "bind_ThinkingDom", "BindingTieWrists_IsEligible", \
    ;                                 "bind_ThinkingDom", "BindingTieWrists_Execute", \
    ;                                 "", "PAPYRUS", \
    ;                                 1, "")

    ; SkyrimNetApi.RegisterAction("ExtCmdBindingUntieWrists", "Remove bindings from {{ player.name }}'s wrists.", \
    ;                                 "bind_ThinkingDom", "BindingUntieWrists_IsEligible", \
    ;                                 "bind_ThinkingDom", "BindingUntieWrists_Execute", \
    ;                                 "", "PAPYRUS", \
    ;                                 1, "")

    ; SkyrimNetApi.RegisterAction("BindingCheckRules", "Makes sure {{ player.name }} is following their bondage rules.", \
    ;                                 "bind_ThinkingDom", "BindingCheckRules_IsEligible", \
    ;                                 "bind_ThinkingDom", "BindingCheckRules_Execute", \
    ;                                 "", "PAPYRUS", \
    ;                                 1, "")

    SkyrimNetApi.RegisterAction("BindingDressingRoom", "Let {{ player.name }} try on new bondage gear. Only use this if {{ player.name }} asks.", \
                                    "bind_ThinkingDom", "BindingDressingRoom_IsEligible", \
                                    "bind_ThinkingDom", "BindingDressingRoom_Execute", \
                                    "", "PAPYRUS", \
                                    1, "")

    SkyrimNetApi.RegisterAction("BindingBed", "Put {{ player.name }} to bed for the night to sleep hogtied or bound to furniture.", \
                                    "bind_ThinkingDom", "BindingSleep_IsEligible", \
                                    "bind_ThinkingDom", "BindingSleep_Execute", \
                                    "", "PAPYRUS", \
                                    1, "")

    SkyrimNetApi.RegisterAction("BindingWhip", "Give {{ player.name }} a good beating for punishment or fun.", \
                                    "bind_ThinkingDom", "BindingWhip_IsEligible", \
                                    "bind_ThinkingDom", "BindingWhip_Execute", \
                                    "", "PAPYRUS", \
                                    1, "")
                                    
    SkyrimNetApi.RegisterAction("BindingSex", "Have sex with {{ player.name }} using bondage gear.", \
                                    "bind_ThinkingDom", "BindingSex_IsEligible", \
                                    "bind_ThinkingDom", "BindingSex_Execute", \
                                    "", "PAPYRUS", \
                                    1, "")    

    SkyrimNetApi.RegisterAction("BindingFurniture", "Lock {{ player.name }} into bondage furniture like pillories, stockades, racks, wall manacles, cruxes.", \
                                    "bind_ThinkingDom", "BindingFurniture_IsEligible", \
                                    "bind_ThinkingDom", "BindingFurniture_Execute", \
                                    "", "PAPYRUS", \
                                    1, "")    

    SkyrimNetApi.RegisterAction("BindingHarshBondage", "Tie {{ player.name }} into inescapably tight bondage for punishment or fun .", \
                                    "bind_ThinkingDom", "BindingHarshBondage_IsEligible", \
                                    "bind_ThinkingDom", "BindingHarshBondage_Execute", \
                                    "", "PAPYRUS", \
                                    1, "")   

    ;"Setup a camp for the night. This can ONLY be used after the 18th hour or before the 6th hour of the day. The current hour is {{ get_hour(npc.UUID) }}."                                    

    ;TODO - this decorator is the wrong way to do this. the hours of the day just needs to be in the BindingCamping_IsEligible check
    SkyrimNetApi.RegisterAction("BindingCamping", "Setup a kinky camp for the night.", \  
                                    "bind_ThinkingDom", "BindingCamping_IsEligible", \
                                    "bind_ThinkingDom", "BindingCamping_Execute", \
                                    "", "PAPYRUS", \
                                    1, "")   
                                    ;removed this - " This can ONLY be used after the 18th hour of the day. The current hour is {{ get_hour(npc.UUID) }}.", \


    ;RegisterBondageRule()


endfunction

function RegisterBondageRule()

    string rules = rman.FindOpenBondageRulesByName(theSubRef)

    bind_Utility.WriteToConsole("RegisterBondageRule - rules: " + rules)

    SkyrimNetApi.RegisterAction("BindingAddBondageRule", "Add a bondage rule for {{ player.name }} to follow.", \
                                    "bind_ThinkingDom", "AddBondageRule_IsEligible", \
                                    "bind_ThinkingDom", "AddBondageRule_Execute", \
                                    "", "PAPYRUS", \
                                    1, "{\"rule\":\"" + rules + "\"}")  

endfunction

; string function Decorator_Function(Actor akActor) global
;     float Time = Utility.GetCurrentGameTime()
; 	Time -= Math.Floor(Time) ; Remove "previous in-game days passed" bit
; 	Time *= 24 ; Convert from fraction of a day to number of hours
;     string result
;     result = "" + Time
;     bind_Utility.WriteToConsole("DecoratorFunction actor: " + akActor + " result: " + result)
; 	Return result
; endfunction

string function DecoratorInfo(Actor akActor) global

    bind_Functions fun = bind_Functions.GetBindingFunctions()

    Form dev = StorageUtil.GetFormValue(fun.GetSubRef(), "binding_locked_in_furniture", none)
    int inFurniture = 0
    string furnitureName = ""
    if dev
        inFurniture = 1
        furnitureName = dev.GetName()
    endif 

    ;int isKneeling = 0
    ;fix this

    int isDom = 0
    if fun.GetDomRef() == akActor
        isDom = 1
    endif
    int isBound = fun.SubInBondage()
    int isGagged = fun.SubIsGagged()
    int isCollared = fun.SubIsCollared()
    int isKneeling = fun.GetIsKneeling()

    int nudity = arcs_API.CheckNudity(fun.GetSubRef()) ;might move this code over?

    string output = "{"

    output += "\"player_is_sub\":" + fun.PlayerIsSub() + ","
    output += "\"is_dom\":" + isDom + ","
    output += "\"safe_area\":" + fun.InSafeArea() + ","
    output += "\"sub_type\":" + fun.SkyrimNetSlaveryType() + ","
    output += "\"has_indentured\":1,"
    output += "\"has_slavery\":3,"
    output += "\"infractions\":" + fun.GetRuleInfractions() + ","
    output += "\"sub_in_furniture\":" + inFurniture + ","
    output += "\"furniture_name\":\"" + furnitureName + "\","
    output += "\"sub_bound\":" + isBound + ","
    output += "\"is_gagged\":" + isGagged + ","
    output += "\"is_kneeling\":" + isKneeling + ","
    output += "\"is_collared\":" + isCollared + ","
    output += "\"is_nude\":" + nudity

    output += "}"

    bind_Utility.WriteToConsole(output)

    ;bind_Utility.WriteToConsole("DecoratorInfo - player_is_sub: " + fun.PlayerIsSub() + " is_dom: " + isDom + " sub_in_furniture: " + inFurniture + " sub_bound: " + isBound + " is_gagged: " + isGagged + " is_kneeling: " + isKneeling)

    return output

endfunction

string function DecoratorIsDom(Actor akActor) global
    bind_Functions fun = bind_Functions.GetBindingFunctions()
    if fun.GetDomRef() == akActor
        bind_Utility.JsonIntValueReturn("is_dom", 1)
    else
        bind_Utility.JsonIntValueReturn("is_dom", 0)  
    endif
endfunction

; string function DecoratorSubFurnitureStatus(Actor akActor) global

;     bind_Functions fun = bind_Functions.GetBindingFunctions()

;     Form dev = StorageUtil.GetFormValue(fun.GetSubRef(), "binding_locked_in_furniture", none)
;     int inFurniture = 0
;     string furnitureName = ""
;     if dev
;         inFurniture = 1
;         furnitureName = dev.GetName()
;     endif 

;     return bind_Utility.JsonIntValueReturn("is_dom", 1)

; endfunction

bool function AddBondageRule_IsEligible(Actor akOriginator, string contextJson, string paramsJson) global

    return true

    bool result
    result = true

    bind_BondageManager bm = bind_BondageManager.GetBindingBondageManager()
    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_MainQuestScript m = bind_MainQuestScript.GetMainQuestScript()
    bind_RulesManager r = bind_RulesManager.GetRulesManager()

    string reason = ""

    if !f.UseSkyrimNetCheck(akOriginator)
        result = false
        reason = "Failed UseSkyrimNetCheck"
        ;debug.MessageBox("skycheck: " + result)
    endif

    if f.InSafeArea() == 0
        result = false ;needs to be safe area
        reason = "Failed Safe Area"
        ;debug.MessageBox("safearea: " + result)
    endif

    if m.bind_GlobalRulesBondageMax.GetValue() <= r.GetActiveBondageRulesCount(f.GetSubRef())
        result = false
        reason = "At max rules"
    endif

    ;debug.MessageBox(result)

    bind_Utility.WriteToConsole("SkyrimNet called: AddBondageRule_IsEligible actor: " + akOriginator + " result: " + result + " reason: " + reason)

    return result

endfunction

bool function BindingCheckRules_IsEligible(Actor akOriginator, string contextJson, string paramsJson) global
    bool result = true
    string reason = ""
    bind_Functions f = bind_Functions.GetBindingFunctions()
    if !f.UseSkyrimNetCheck(akOriginator)
        result = false
        reason = "Failed UseSkyrimNetCheck"
    endif
    if f.InSafeArea() == 0
        result = false ;needs to be safe area
        reason = "Failed Safe Area"
    endif
    bind_Utility.WriteToConsole("SkyrimNet called: BindingCheckRules_IsEligible actor: " + akOriginator + " result: " + result + " reason: " + reason)
    return result
endfunction

bool function BindingDressingRoom_IsEligible(Actor akOriginator, string contextJson, string paramsJson) global
    bool result = true
    string reason = ""
    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_ThinkingDom think = bind_ThinkingDom.GetThinkingDom()
    if think.EnableActionDressingRoom == 0
        result = false
        reason = "Action not enabled"
    endif
    if !f.UseSkyrimNetCheck(akOriginator)
        result = false
        reason = "Failed UseSkyrimNetCheck"
    endif
    if f.InSafeArea() == 0
        result = false ;needs to be safe area
        reason = "Failed Safe Area"
    endif
    bind_Utility.WriteToConsole("SkyrimNet called: BindingDressingRoom_IsEligible actor: " + akOriginator + " result: " + result + " reason: " + reason)
    return result
endfunction

bool function BindingSleep_IsEligible(Actor akOriginator, string contextJson, string paramsJson) global
    bool result = true
    string reason = ""
    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_ThinkingDom think = bind_ThinkingDom.GetThinkingDom()
    if think.EnableActionBed == 0
        result = false
        reason = "Action not enabled"
    endif
    if !f.UseSkyrimNetCheck(akOriginator)
        result = false
        reason = "Failed UseSkyrimNetCheck"
    endif
    if f.InSafeArea() == 0
        result = false ;needs to be safe area
        reason = "Failed Safe Area"
    endif
    if !f.HasNearbyBed()
        result = false
        reason = "Not near a bed"
    endif
    bind_Utility.WriteToConsole("SkyrimNet called: BindingSleep_IsEligible actor: " + akOriginator + " result: " + result + " reason: " + reason)
    return result
endfunction

bool function BindingTieWrists_IsEligible(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingTieWrists_IsEligible actor: " + akOriginator)

    bool result

    bind_BondageManager bm = bind_BondageManager.GetBindingBondageManager()
    bind_Functions f = bind_Functions.GetBindingFunctions()

    if !f.UseSkyrimNetCheck(akOriginator)
        return false
    endif

    if f.GetSubRef().WornHasKeyWord(bm.zlib.zad_DeviousHeavyBondage)
        result = false
    else
        result = true
    endif

    return result

endfunction

bool function BindingUntieWrists_IsEligible(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingUntieWrists_IsEligible actor: " + akOriginator)

    bool result

    bind_BondageManager bm = bind_BondageManager.GetBindingBondageManager()
    bind_Functions f = bind_Functions.GetBindingFunctions()

    if !f.UseSkyrimNetCheck(akOriginator)
        return false
    endif

    if f.GetSubRef().WornHasKeyWord(bm.zlib.zad_DeviousHeavyBondage)
        result = true
    else
        result = false
    endif

    return result

endfunction

bool function BindingWhip_IsEligible(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingWhip_IsEligible actor: " + akOriginator)

    bool result

    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_ThinkingDom think = bind_ThinkingDom.GetThinkingDom()
    if think.EnableActionWhip == 0
        return false
    endif

    if !f.UseSkyrimNetCheck(akOriginator)
        return false
    endif

    if f.InSafeArea() == 0
        return false ;needs to be safe area
    endif

    result = true

    return result

endfunction

bool function BindingSex_IsEligible(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingSex_IsEligible actor: " + akOriginator)

    bool result

    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_ThinkingDom think = bind_ThinkingDom.GetThinkingDom()
    if think.EnableActionSex == 0
        return false
    endif

    if !f.UseSkyrimNetCheck(akOriginator)
        return false
    endif

    if f.InSafeArea() == 0
        return false ;needs to be safe area
    endif

    ;do arousal check

    result = true

    return result

endfunction

bool function BindingFurniture_IsEligible(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingFurniture_IsEligible actor: " + akOriginator)

    bool result

    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_ThinkingDom think = bind_ThinkingDom.GetThinkingDom()
    if think.EnableActionFurniture == 0
        return false
    endif

    if !f.UseSkyrimNetCheck(akOriginator)
        return false
    endif

    if f.InSafeArea() == 0
        return false ;needs to be safe area
    endif

    if f.LocationHasFurniture()
        result = true
    else
        result = false
    endif

    return result

endfunction

bool function BindingHarshBondage_IsEligible(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingHarshBondage_IsEligible actor: " + akOriginator)

    bool result

    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_ThinkingDom think = bind_ThinkingDom.GetThinkingDom()
    if think.EnableActionHarshBondage== 0
        return false
    endif

    if !f.UseSkyrimNetCheck(akOriginator)
        return false
    endif

    if f.InSafeArea() == 0
        return false ;needs to be safe area
    endif

    result = true

    return result

endfunction

bool function BindingCamping_IsEligible(Actor akOriginator, string contextJson, string paramsJson) global

    ;TODO - add the global is adult check

    bind_Utility.WriteToConsole("SkyrimNet called: BindingCamping_IsEligible actor: " + akOriginator)

    bool result

    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_ThinkingDom think = bind_ThinkingDom.GetThinkingDom()
    if think.EnableActionCamping == 0
        return false
    endif

    if !f.UseSkyrimNetCheck(akOriginator)
        return false
    endif

    if f.InSafeArea() == 1
        return false ;can't camp in cities or towns
    endif

    if f.AreaIsIndoors() == 1
        return false
    endif

    ;TODO - other checks:
    ;* outside safe area
    ;* time of day check

    result = true

    return result

endfunction

; function BindingTieWrists_Execute(Actor akOriginator, string contextJson, string paramsJson) global

;     bind_Utility.WriteToConsole("SkyrimNet called: BindingTieWrists_Execute actor: " + akOriginator)

;     bind_BondageManager bm = bind_BondageManager.GetBindingBondageManager()
;     bind_Functions f = bind_Functions.GetBindingFunctions()

;     Form dev = bm.GetDdRandomItem(bm.BONDAGE_TYPE_HEAVYBONDAGE())
;     StorageUtil.SetFormValue(f.GetSubRef(), "bind_thinkingdom_wrists", dev)
;     bm.AddSpecificItem(f.GetSubRef(), dev)

; endfunction

; function BindingUntieWrists_Execute(Actor akOriginator, string contextJson, string paramsJson) global

;     bind_Utility.WriteToConsole("SkyrimNet called: BindingUntieWrists_Execute actor: " + akOriginator)

;     bind_BondageManager bm = bind_BondageManager.GetBindingBondageManager()
;     bind_Functions f = bind_Functions.GetBindingFunctions()

;     Form dev = StorageUtil.GetFormValue(f.GetSubRef(), "bind_thinkingdom_wrists")
;     if dev
;         bm.RemoveSpecificItem(f.GetSubRef(), dev)
;     endif

; endfunction

function AddBondageRule_Execute(Actor akOriginator, string contextJson, string paramsJson) global
    bind_Utility.WriteToConsole("SkyrimNet called: ddBondageRule_Execute actor: " + akOriginator)

    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_RulesManager r = bind_RulesManager.GetRulesManager()
    bind_ThinkingDom t = bind_ThinkingDom.GetThinkingDom()
    bind_BondageManager b = bind_BondageManager.GetBondageManager()
    bind_MainQuestScript m = bind_MainQuestScript.GetMainQuestScript()

    bind_PoseManager.StandFromKneeling(f.GetSubRef())

    string rule = SkyrimNetApi.GetJsonString(paramsJson, "rule", "") 

    if rule == "Random Rule"
        string rules = r.FindOpenBondageRulesByName(f.GetSubRef())
        string[] arr = StringUtil.Split(rules, "|")
        if arr.Length > 0
            rule = arr[Utility.RandomInt(0, arr.Length - 1)]
        endif
    endif

    debug.MessageBox(rule)

    int ruleIdx = r.GetBondageRuleIdByName(rule)
    if ruleIdx > -1
        r.SetBondageRule(f.GetSubRef(), ruleIdx, 1)
        r.SetBondageRuleEnd(f.GetSubRef(), ruleIdx, bind_Utility.AddTimeToCurrentTime(Utility.RandomInt(24, 96), 0))
        float currentTime = bind_Utility.GetTime()
        m.bind_GlobalRulesLastRule.SetValue(currentTime)
        m.bind_GlobalRulesNextRule.SetValue(bind_Utility.AddTimeToTime(currentTime, m.bind_GlobalRulesHoursBetween.GetValue() as int, 0))
        bind_MovementQuestScript.FaceTarget(f.GetDomRef(), f.GetSubRef())
        bind_MovementQuestScript.PlayDoWork(f.GetDomRef())
        if b.AddItem(f.GetSubRef(), ruleIdx)
        endif
        SkyrimNetApi.DirectNarration(f.GetDomRef().GetDisplayName() + " has added a new required bondage rule the " + rule + " that {{ player.name }} must follow, and locked " + b.LastAddedItemName + " on {{ player.name }}'s body", f.GetSubRef())
        t.RegisterBondageRule() ;refresh this action registration with an updated rules list
    endif


endfunction

function BindingCheckRules_Execute(Actor akOriginator, string contextJson, string paramsJson) global
    bind_Utility.WriteToConsole("SkyrimNet called: BindingCheckRules_Execute actor: " + akOriginator)
    Quest q = Quest.GetQuest("bind_RulesCheckQuest")
    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_PoseManager.StandFromKneeling(f.GetSubRef())
    if f.ModInRunningState()
        debug.MessageBox("start bind_RulesCheckQuest quest")
        if !q.IsRunning()
            q.Start()
        endif
    endif
endfunction

function BindingDressingRoom_Execute(Actor akOriginator, string contextJson, string paramsJson) global
    bind_Utility.WriteToConsole("SkyrimNet called: BindingDressingRoom_Execute actor: " + akOriginator)
    Quest q = Quest.GetQuest("bind_TheDressingRoomQuest")
    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_PoseManager.StandFromKneeling(f.GetSubRef())
    if f.ModInRunningState()
        debug.MessageBox("start bind_TheDressingRoomQuest quest")
        if !q.IsRunning()
            q.Start()
        endif
    endif
endfunction

function BindingSleep_Execute(Actor akOriginator, string contextJson, string paramsJson) global
    bind_Utility.WriteToConsole("SkyrimNet called: BindingSleep_Execute actor: " + akOriginator)
    Quest q = Quest.GetQuest("bind_EventBoundSleepQuest")
    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_PoseManager.StandFromKneeling(f.GetSubRef())
    if f.ModInRunningState()
        debug.MessageBox("start bind_EventBoundSleepQuest quest")
        if !q.IsRunning()
            q.Start()
        endif
    endif
endfunction

function BindingWhip_Execute(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingWhip_Execute actor: " + akOriginator)

    Quest whip = Quest.GetQuest("bind_WhippingQuest")
    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_PoseManager.StandFromKneeling(f.GetSubRef())

    if f.ModInRunningState()
        debug.MessageBox("start whipping quest")
        if !whip.IsRunning()
            whip.Start()
        endif
    endif

endfunction

function BindingSex_Execute(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingSex_Execute actor: " + akOriginator)

    Quest boundSex = Quest.GetQuest("bind_BoundSexQuest")
    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_PoseManager.StandFromKneeling(f.GetSubRef())

    if f.ModInRunningState()
        debug.MessageBox("start sex quest")
        if !boundSex.IsRunning()
            boundSex.Start()
        endif
    endif

endfunction


function BindingFurniture_Execute(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingFurniture_Execute actor: " + akOriginator)

    Quest pod = Quest.GetQuest("bind_EventPutOnDisplayQuest")
    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_PoseManager.StandFromKneeling(f.GetSubRef())

    if f.ModInRunningState()
        debug.MessageBox("start put on display quest")
        if !pod.IsRunning()
            pod.Start()
        endif
    endif

endfunction

function BindingHarshBondage_Execute(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingHarshBondage_Execute actor: " + akOriginator)

    Quest harsh = Quest.GetQuest("bind_EventHarshBondageQuest")
    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_PoseManager.StandFromKneeling(f.GetSubRef())

    if f.ModInRunningState()
        debug.MessageBox("start harsh bondage quest")
        if !harsh.IsRunning()
            harsh.Start()
        endif
    endif

endfunction

function BindingCamping_Execute(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingCamping_Execute actor: " + akOriginator)

    Quest camp = Quest.GetQuest("bind_EventCampingQuest")
    bind_Functions f = bind_Functions.GetBindingFunctions()
    bind_PoseManager.StandFromKneeling(f.GetSubRef())

    if f.ModInRunningState()
        debug.MessageBox("start camping quest")
        if !camp.IsRunning()
            camp.Start()
        endif
    endif

endfunction

event ConversationPoseEvent()

    if main.EnableModSkyrimNet == 1

    endif

endevent

event SubKneeledEvent()

    if main.EnableModSkyrimNet == 1
        ;UseDirectNarration(theDomRef, "{{ player.name }} dropped submissively to their knees for " + domName)
    endif

endevent

event SubLeftKneelEvent()

    if main.EnableModSkyrimNet == 1
        ;UseDirectNarration(theDomRef, "{{ player.name }} has stood up and left their kneeling position " + domName)
    endif

endevent

event SubLookedAtFurnitureEvent()

    if main.EnableModSkyrimNet == 1

    endif

endevent

event EnteringSafeAreaEvent()

    if main.EnableModSkyrimNet == 1

    endif

endevent

event LeavingSafeAreaEvent()

    if main.EnableModSkyrimNet == 1

    endif

endevent

function WriteShortTermEvent(Actor a, string eventType, string eventText)

    SkyrimNetApi.RegisterShortLivedEvent(eventType + "_" + a.GetDisplayName(), eventType, "", eventText, 60000, a, None)

endfunction

bool function UseDirectNarration(Actor a, string commentPrompt)

    bool result = false

    if main.EnableModSkyrimNet == 1

        ;commentPrompt += " Be sure to make this a unique comment and try not to repeat."

        SkyrimNetApi.DirectNarration(commentPrompt, a)
        bind_Utility.WriteToConsole("UsedDirectNarration - actor: " + a + " prompt: " + commentPrompt)

        Utility.Wait(5.0)

        ; GotoState("DirectNarrationCooldownState")
        ; UnregisterForUpdate()
        ; RegisterForSingleUpdate(10.0)

        result = true

    endif

    return result

endfunction

state DirectNarrationCooldownState

    bool function UseDirectNarration(Actor a, string commentPrompt)
        bind_Utility.WriteToConsole("direct narration is in cool down state")
        return false
    endfunction

    event OnUpdate()
        debug.Notification("Direct Narration has cooled down")
        GoToState("")
    endevent

endstate

bool function IsAiReady()
    return (main.SoftCheckChim == 1 && main.EnableModChim == 1) || (main.SoftCheckSkyrimNet == 1 && main.EnableModSkyrimNet == 1)
endfunction

Armor wristBondage

Function _SetLikes()

    If !likesCreated
        main.LikesWeatherTemp = Utility.RandomInt(1, 3) ;1 - cold, 2 - cool, 3 - warm

        main.LikesCityWhiterun = Utility.RandomInt(1, 3)
        main.LikesCityMarkarth = Utility.RandomInt(1, 3)
        main.LikesCityMorthal = Utility.RandomInt(1, 3)
        main.LikesCityWindhelm = Utility.RandomInt(1, 3)
        main.LikesCitySolitude = Utility.RandomInt(1, 3)
        main.LikesCityFalkreath = Utility.RandomInt(1, 3)
        main.LikesCityRiften = Utility.RandomInt(1, 3)
        main.LikesCityWinterhold = Utility.RandomInt(1, 3)
        main.LikesCityRavenRock = Utility.RandomInt(1, 3)
        main.LikesCityDawnstar = Utility.RandomInt(1, 3)

        likesCreated = true
    EndIf

EndFunction

Function _SetupStorage(bool rebuildStorage)

    If rebuildStorage
        arrayCreated = 0
    EndIf

    If arrayCreated == 0
 
        ;arrayCreated = 1

    EndIf

EndFunction

bind_MainQuestScript property main auto
bind_RulesManager property rman auto
bind_BondageManager property bms auto
bind_GearManager property gms auto
bind_Functions property fs auto
bind_PoseManager property pms auto

;bind_MainQuestScript property mqs auto

Quest property bind_WhippingQuest auto
Quest property bind_EventPutOnDisplayQuest auto