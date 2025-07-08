Scriptname bind_ThinkingDom extends Quest conditional

;big maybe idea
;maybe have the point system based on good events (bondage show, no punishments that day, getting enough sleep, etc.) 
;and bad events (masturbation with permission, gagged punishment, dom gets too much damage, missing bedtime)
;you can use points to change rules, get sex, remove gag, craft, etc.?? buy items?

;can spend points when punishements due

;have dom personality to trigger events and when dom full control pick bondage

;NOTE - probably very important since you can switch and then return to a follower (needs to be sticky)

;NOTE - processing routine for this has to be segmented, would be tempting script lag fate to try and run a complex process every
;cycle of the main timing loop

;int property OutputNextEvent auto conditional

;int property DialogAllowRulesConversation auto conditional

;NOTE - trigger event will switch follower to force greet AI package(s)
;Example - 
    ;if user skipped time, dom will ask something to the effect of "Why did you ask the gods to speed up time?"
    ;sub will have various conversation options
        ;admit fault - use this to drill into shorter / longer events (attitude modifier adjusts this)
        ;lie - setup a random (but display probably of success or failure - speech modifier?)
        ;bratty / angry responses

;Example 2
    ;after care type conversations after flogging / long events
    ;learn store materials / favorite items
    ;use less liked items / furnitures / etc. for punishment

;Example 3
    ;more complex engagement options for players (for sure optional - only certains types would enjoy this)
    ;push different characters to screen to force player attention (hit a key now, don't hit a key now) when stuck a place

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

Function LoadGame(bool rebuildStorage = false)
    
    _SetupStorage(rebuildStorage)
    _SetLikes()
    ;for testing
    ;RulesInEffect = 3

    theSubRef = fs.GetSubRef()
    theDomRef = fs.GetDomRef()

    domName = theDomRef.GetActorBase().GetName()

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

	;RegisterForModEvent("CHIM_CommandReceived", "ChimCommand")

    RegisterForModEvent("bind_EnteringSafeAreaEvent", "EnteringSafeAreaEvent")
    RegisterForModEvent("bind_LeavingSafeAreaEvent", "LeavingSafeAreaEvent")
    RegisterForModEvent("bind_ConversationPoseEvent", "ConversationPoseEvent")

    RegisterForModEvent("bind_SubKneeledEvent", "SubKneeledEvent") ;kneeling event
    RegisterForModEvent("bind_SubLookedAtFurnitureEvent", "SubLookedAtFurnitureEvent")

    if main.SoftCheckSkyrimNet == 1 ;&& main.EnableModSkyrimNet == 1
        RegisterSkyrimNetFunctions()
    endif

EndFunction

function RegisterSkyrimNetFunctions()

    if skyrimNetRegistered != 1 ;NOTE - this is an integer vs. bool so it can be incremented up to force a new registration of actions/decoractors

        ;TODO: move registeractions into here

        skyrimNetRegistered = 1
    
    endif

    bind_Utility.WriteToConsole("Registering SkyrimNet actions")

    SkyrimNetApi.RegisterDecorator("get_hour", "bind_ThinkingDom", "Decorator_Function")

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

    SkyrimNetApi.RegisterAction("ExtCmdBindingWhip", "Give " + theSubRef.GetDisplayName() + " a good beating for punishment or fun.", \
                                    "bind_ThinkingDom", "BindingWhip_IsEligible", \
                                    "bind_ThinkingDom", "BindingWhip_Execute", \
                                    "", "PAPYRUS", \
                                    1, "")
                                    
    SkyrimNetApi.RegisterAction("ExtCmdBindingSex", "Have sex with " + theSubRef.GetDisplayName() + ".", \
                                    "bind_ThinkingDom", "BindingSex_IsEligible", \
                                    "bind_ThinkingDom", "BindingSex_Execute", \
                                    "", "PAPYRUS", \
                                    1, "")    

    SkyrimNetApi.RegisterAction("ExtCmdBindingFurniture", "Lock " + theSubRef.GetDisplayName() + " into bondage furniture like pillories, stockades, racks, wall manacles, cruxes.", \
                                    "bind_ThinkingDom", "BindingFurniture_IsEligible", \
                                    "bind_ThinkingDom", "BindingFurniture_Execute", \
                                    "", "PAPYRUS", \
                                    1, "")    

    SkyrimNetApi.RegisterAction("ExtCmdBindingHarshBondage", "Tie " + theSubRef.GetDisplayName() + " into inescapably tight bondage for punishment or fun .", \
                                    "bind_ThinkingDom", "BindingHarshBondage_IsEligible", \
                                    "bind_ThinkingDom", "BindingHarshBondage_Execute", \
                                    "", "PAPYRUS", \
                                    1, "")   

    ;"Setup a camp for the night. This can ONLY be used after the 18th hour or before the 6th hour of the day. The current hour is {{ get_hour(npc.UUID) }}."                                    

    SkyrimNetApi.RegisterAction("ExtCmdBindingCamping", "Setup a camp for the night. This can ONLY be used after the 18th hour of the day. The current hour is {{ get_hour(npc.UUID) }}.", \
                                    "bind_ThinkingDom", "BindingCamping_IsEligible", \
                                    "bind_ThinkingDom", "BindingCamping_Execute", \
                                    "", "PAPYRUS", \
                                    1, "")   

endfunction

string function Decorator_Function(Actor akActor) global
    float Time = Utility.GetCurrentGameTime()
	Time -= Math.Floor(Time) ; Remove "previous in-game days passed" bit
	Time *= 24 ; Convert from fraction of a day to number of hours
    string result
    result = "" + Time
    bind_Utility.WriteToConsole("DecoratorFunction actor: " + akActor + " result: " + result)
	Return result
endfunction

function OnLLMResponse(string response) global

    bind_Utility.WriteToConsole("SkyrimNet OnLLMResponse: " + response)

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

    if !f.UseSkyrimNetCheck(akOriginator)
        return false
    endif

    result = true

    return result

endfunction

bool function BindingSex_IsEligible(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingSex_IsEligible actor: " + akOriginator)

    bool result

    bind_Functions f = bind_Functions.GetBindingFunctions()

    if !f.UseSkyrimNetCheck(akOriginator)
        return false
    endif

    ;do arousal check

    result = true

    return result

endfunction

bool function BindingFurniture_IsEligible(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingFurniture_IsEligible actor: " + akOriginator)

    bool result

    bind_Functions f = bind_Functions.GetBindingFunctions()

    if !f.UseSkyrimNetCheck(akOriginator)
        return false
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

    if !f.UseSkyrimNetCheck(akOriginator)
        return false
    endif

    result = true

    return result

endfunction

bool function BindingCamping_IsEligible(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingCamping_IsEligible actor: " + akOriginator)

    bool result

    bind_Functions f = bind_Functions.GetBindingFunctions()

    if !f.UseSkyrimNetCheck(akOriginator)
        return false
    endif

    result = true

    return result

endfunction

function BindingTieWrists_Execute(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingTieWrists_Execute actor: " + akOriginator)

    bind_BondageManager bm = bind_BondageManager.GetBindingBondageManager()
    bind_Functions f = bind_Functions.GetBindingFunctions()

    Form dev = bm.GetDdRandomItem(bm.BONDAGE_TYPE_HEAVYBONDAGE())
    StorageUtil.SetFormValue(f.GetSubRef(), "bind_thinkingdom_wrists", dev)
    bm.AddSpecificItem(f.GetSubRef(), dev)

endfunction

function BindingUntieWrists_Execute(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingUntieWrists_Execute actor: " + akOriginator)

    bind_BondageManager bm = bind_BondageManager.GetBindingBondageManager()
    bind_Functions f = bind_Functions.GetBindingFunctions()

    Form dev = StorageUtil.GetFormValue(f.GetSubRef(), "bind_thinkingdom_wrists")
    if dev
        bm.RemoveSpecificItem(f.GetSubRef(), dev)
    endif

endfunction

function BindingWhip_Execute(Actor akOriginator, string contextJson, string paramsJson) global

    bind_Utility.WriteToConsole("SkyrimNet called: BindingWhip_Execute actor: " + akOriginator)

    Quest whip = Quest.GetQuest("bind_WhippingQuest")
    bind_Functions f = bind_Functions.GetBindingFunctions()

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
        ;string suggestion = "Comment about being on their knees."
        ;int result = SkyrimNetApi.SendCustomPromptToLLM(suggestion, llmTemp, maxTokens, "bind_ThinkingDom", "OnLLMResponse")      
        ;int result = SkyrimNetApi.RegisterDialogueToListener(theDomRef, theSubRef, suggestion)
        ;int result = SkyrimNetApi.RegisterEvent("custom", theSubRef.GetDisplayName() + " has dropped to " + pronounHisHer + " knees and is kneeling submissively. Perhaps you should comment about " + pronounHimHer + " pleasing you.", theDomRef, theSubRef)
        MakeAiComment(theDomRef, "{ player.name } dropped submissively to their knees for you.")
        ;bind_Utility.WriteToConsole("SkyrimNet SendCustomPromptToLLM result: " + result)  
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

function MakeAiComment(Actor a, string commentPrompt)

    if main.EnableModSkyrimNet == 1

        commentPrompt + "\n- Always use unique comments and write this in " + theDomRef.GetName() + "'s voice."

        SkyrimNetApi.DirectNarration(commentPrompt, a)
        bind_Utility.WriteToConsole("MakeAiComment - actor: " + a + " prompt: " + commentPrompt)

    endif

endfunction

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