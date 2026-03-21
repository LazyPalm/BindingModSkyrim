Scriptname bindc_Slave extends Quest  
Actor theSlave
Actor theMaster

float lastNearMaster = 0.0

bool haveLeavePermission = false
bool processingShortPress = false

int currentPose = 1

int POSE_IDLE = 1
int POSE_KNEELING = 2

;******************************************************************************************
; START
;******************************************************************************************

event OnInit()

    if IsRunning()

        ;bindc_Data.ModState(2)

        theSlave = Game.GetPlayer()
        theMaster = TheMasterAlias.GetActorReference()
        lastNearMaster = bindc_Util.GetTime()

        ;StorageUtil.SetIntValue(theSlave, "bindc_slave_running", 1)

        if bindc_Data.GreetedDom() == 0
            SetObjectiveDisplayed(10, true)
            GoToState("GreetOwnerState")
            UnregisterForUpdate()
            RegisterForUpdate(60.0)
        else
            SetObjectiveDisplayed(10, false)
            SetObjectiveDisplayed(20, true)
            GoToState("RunningState")
            UnregisterForUpdate()
        endif

        LoadGame()

    endif

endevent

event LoadGame()

    ; Quest free = Quest.GetQuest("bindc_FreeQuest")
    ; if free.IsRunning()
    ;     free.Stop()
    ; endif
    bindc_Main.StopFreeQuest()

    bondageRuleChanges = false

    RegisterForModEvent("BindingEventCycle", "BindingEventCycle")
    RegisterForModEvent("BindingEventShortPress", "BindingEventShortPress")
    RegisterForModEvent("BindingEventSetConversationTarget", "BindingEventSetConversationTarget")
    RegisterForModEvent("BindingEventClearConversationTarget", "BindingEventClearConversationTarget")
    RegisterForModEvent("BindingChangedLocationWithDelay", "BindingChangedLocationWithDelay")
    ;RegisterForModEvent("BindingTryOnOutfit", "BindingTryOnOutfit")

endevent

;******************************************************************************************
; STATE SPECIFIC EVENTS
;******************************************************************************************

event BindingEventSetConversationTarget()
    ;ConversationTargetNpc.ForceRefTo(bindc_Main.GetConversationTarget())
endevent

event BindingEventClearConversationTarget()
    ;ConversationTargetNpc.Clear()
endevent

event BindingEventCycle()
endevent

event BindingEventShortPress()
endevent

event BindingChangedLocationWithDelay()
endevent

event OnUpdate()
endevent

;******************************************************************************************
; STATE SPECIFIC FUNCTIONS
;******************************************************************************************

function Arrived()
    ActorUtil.RemovePackageOverride(theMaster, bindc_PackageSlaveQuestMoveToSlave)
    ActorUtil.AddPackageOverride(theMaster, bindc_PackageSlaveQuestDoNothing, 80)
    theMaster.EvaluatePackage()
endfunction

function DialogueWithMaster()
endfunction

function KneelingDomInTravelRange()
endfunction

; auto state StartUpState
; endstate

;******************************************************************************************
; STATE - PREPARE
;******************************************************************************************
state PrepareSlaveState
    
    event BindingEventShortPress()
        ;block menu
    endevent

    function Arrived()
        ;debug.MessageBox("bind player...")
        ActorUtil.RemovePackageOverride(theMaster, bindc_PackageSlaveQuestMoveToSlave)
        ActorUtil.AddPackageOverride(theMaster, bindc_PackageSlaveQuestDoNothing, 80)
        theMaster.EvaluatePackage()
        if currentPose == POSE_KNEELING
            Stand()
        endif
        BindSlave(theSlave)
        GoToState("RunningState")
    endfunction

endstate

;******************************************************************************************
; STATE - GREET
;******************************************************************************************
state GreetOwnerState

    event BindingEventShortPress()

        if !processingShortPress

            processingShortPress = true

            bindc_Util.WriteInformation("greet owner state BindingEventShortPress happened...")

            ShowActionMenu()
            
            processingShortPress = false

        endif

    endevent

    function KneelingDomInTravelRange()
        SetObjectiveCompleted(10, true)
        SetObjectiveDisplayed(20, true)
        bindc_Data.GreetedDom(1)
        GoToState("PrepareSlaveState") ;send to PrepareSlaveState 
    endfunction

    event BindingEventCycle()

        CheckDistance()

        ;debug.MessageBox("got cycle event...")

    endevent

    event OnUpdate()
        debug.MessageBox("You failed to greet your owner.")
        SetObjectiveFailed(10, true)
        SetObjectiveDisplayed(20, true)
        GoToState("RunningState")
    endevent

endstate

;******************************************************************************************
; STATE - RUNNING
;******************************************************************************************
state RunningState

    event OnUpdate()
    endevent

    event BindingEventShortPress()

        if !processingShortPress

            processingShortPress = true

            bindc_Util.WriteInformation("running state BindingEventShortPress happened...")

            ShowActionMenu()
            
            processingShortPress = false

        endif

    endevent

    event BindingChangedLocationWithDelay()

        ;debug.MessageBox("isafe: " + newLocationSafe)

        ;TODO - optional, instead of ending this quest - add infractions for not being near and keep the quest running
        ;this might be more robust?
        ;slave/sub probably needs to end the quest to get untied regardless

        ;TODO - change this for time passed not interacting with dom / being very near to dom - 2 hours or so (this should deal with fast travel and make the safe areas thing not as big of a deal)

        float ct = bindc_Util.GetTime()
        float checkHours = bindc_util.GetHoursAsFloat(1)
        
        bindc_Util.WriteInformation("last near master: " + (ct - lastNearMaster) + " hours as float: " + checkHours)

        if (ct - lastNearMaster) > checkHours ;StorageUtil.GetIntValue(theSlave, "bindc_safe_area", 0) != 2
            
            bool endQuest = true
            
            ;check to see if master is nearby
            ;set end quest to false if so
            if CheckDistance()
                endQuest = false
            endif

            if endQuest

                bindc_Data.GreetedDom(0)
        
                if !haveLeavePermission
                    debug.MessageBox("You did not have permission to leave...")
                endif
        
                ; Quest free = Quest.GetQuest("bindc_FreeQuest")
                ; if free != none
                ;     free.Start()
                ; endif

                ;bindc_Data.ModState(1)
                bindc_Main.StartFreeQuest()

                ;StorageUtil.SetIntValue(theSlave, "bindc_slave_running", 2)

                ;Stop()

            endif

        endif

    endevent

    event BindingEventCycle()

        CheckDistance()

    endevent

endstate

;******************************************************************************************
; ANY STATE FUNCITIONS
;******************************************************************************************

function TakeLeave()

    float f = bindc_Util.GetTime() + bindc_util.GetHoursAsFloat(1) ; + (1.0 / 24.0)
    bindc_TakeLeaveTimerGlobal.SetValue(f) ;should a location change zero this out? unknown location (wilderness)??

    debug.MessageBox("current time: " + bindc_Util.GetTime() + " exit time: " + f)

    debug.MessageBox("You have an hour to leave the area...")

    bindc_Data.GreetedDom(0)

    if currentPose == POSE_KNEELING
        Stand()
    endif

    bindc_Bondage.RemoveItems(theSlave)

    ;bindc_Data.ModState(1)
    bindc_Main.StartFreeQuest()

    ;Stop()

endfunction

function BindSlave(Actor slave) ;slave as parameter for follower slaves?

    bindc_Util.WriteModNotification("Updating " + slave.GetDisplayName() + "'s bondage...")

    bindc_Bondage.RemoveItems(theSlave)

    Form[] items = JsonUtil.FormListToArray(bindc_Data.SettingsFile(), "default_bondage_items")
    ;debug.MessageBox(items)
    int i = 0
    while i < items.Length
        if theSlave.GetItemCount(items[i]) == 0
            theSlave.AddItem(items[i], 1, false)
        endif
        i += 1
    endwhile

    int safeArea = StorageUtil.GetIntValue(theSlave, "bindc_safe_area", 0)

    int[] bondageRules = bindc_Rules.GetBondageRules(theMaster)

    FormList foundItems = Game.GetFormFromFile(0x000D68, "binding.esm") as FormList
    foundItems.Revert()

    i = 0
    while i < bondageRules.Length
        if bondageRules[i] == 1
            foundItems.AddForm(items[i])
        endif
        i += 1
    endwhile

    if foundItems.GetSize() > 0
        bindc_Bondage.EquipItems(theSlave, foundItems.ToArray())
    endif

    ;debug.MessageBox(bondageRules)

endfunction

bool function CheckDistance()
    bool inRange = false
    float dist = theMaster.GetDistance(theSlave)
    bindc_Util.WriteInformation("distance check: " + dist)
    if dist < 1000.0
        lastNearMaster = bindc_Util.GetTime()
        bindc_Util.WriteInformation("update last near: " + lastNearMaster)
        inRange = true
    endif
    return inRange
endfunction

function Kneel()

    bindc_Util.DisablePlayer(true)

    currentPose = POSE_KNEELING
    theSlave.SetFactionRank(bindc_SlaveFaction, 2)

    debug.SendAnimationEvent(theSlave, StorageUtil.GetStringValue(none, "bindc_pose_kneel", "ZazAPC017"))

    if theMaster.GetDistance(theSlave) < 1000.0

        KneelingDomInTravelRange()
        
        ActorUtil.AddPackageOverride(theMaster, bindc_PackageSlaveQuestMoveToSlave, 80)
        theMaster.EvaluatePackage()

    else 

        bindc_Util.WriteInternalMonologue(theMaster.GetDisplayName() + " is too far to notice me kneeling...")

    endif

endfunction

function Stand()

    ;replace gag here?

    currentPose = POSE_IDLE
    theSlave.SetFactionRank(bindc_SlaveFaction, 1)

    debug.SendAnimationEvent(theSlave, "IdleForceDefaultState")

    ActorUtil.RemovePackageOverride(theMaster, bindc_PackageSlaveQuestMoveToSlave)
    ActorUtil.RemovePackageOverride(theMaster, bindc_PackageSlaveQuestDoNothing)    
    ;MoveToSlaveRef.Clear()
    theMaster.EvaluatePackage()

    bindc_Util.DoSleep(1.0)

    debug.SendAnimationEvent(theMaster, "IdleForceDefaultState")

    bindc_Util.EnablePlayer(true)

endfunction

function ShowActionMenu()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    listMenu.AddEntryItem("--- Binding Action Menu ---")

    if currentPose == POSE_IDLE
        listMenu.AddEntryItem("Kneel")
    else
        listMenu.AddEntryItem("Stand up / Relax Pose")
    endif

    listMenu.AddEntryItem("Undress")

    listMenu.AddEntryItem("Bondage Rules")

    ;listMenu.AddEntryItem("Settings")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ShowActionMenu()
    elseif listReturn == 1
        if currentPose == POSE_IDLE
            Kneel()
        else
            Stand()
        endif
    elseif listReturn == 2
        bindc_Util.AnimateChangeClothing(theSlave)
        bindc_Gear.UndressActor(theSlave)
    ; elseif listReturn == 2
    ;     bindc_Menus.ShowSettingsMenu()

    elseif listReturn == 3
        ManageBondageRules()


    else

    endif

endfunction

bool bondageRuleChanges = false

function ManageBondageRules()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    listMenu.AddEntryItem("<--- Leave Bondage Rules")

    string[] bondageRules = bindc_Rules.GetBondageRuleNames()
    int[] active = bindc_Rules.GetBondageRules(theMaster)
    int[] options = bindc_Rules.GetBondageRuleOptions(theMaster)

    ;debug.MessageBox(active)

    int i = 0
    while i < bondageRules.Length
        string text = bondageRules[i]
        if active[i] == 1
            text += " (ON)"
        endif
        listMenu.AddEntryItem(text)
        i += 1
    endwhile



    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ShowActionMenu()
    elseif listReturn > 0
        ManageBondageRule(listReturn - 1, bondageRules[listReturn - 1])
    else
        Debug.MessageBox("bondageRuleChanges: " + bondageRuleChanges)
        if bondageRuleChanges
            bondageRuleChanges = false
            BindSlave(theSlave)
        endif
    endif


endfunction

function ManageBondageRule(int idx, string ruleName)

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    float[] ruleSettings = bindc_Rules.GetBondageRule(theMaster, idx)

    ; result[0] = StorageUtil.IntListGet(dom, "bindc_bondage_rules_state", idx)
    ; result[1] = StorageUtil.IntListGet(dom, "bindc_bondage_rules_option", idx)
    ; result[2] = StorageUtil.FloatListGet(dom, "bindc_bondage_rules_expire", idx)

    listMenu.AddEntryItem("<--- Leave " + ruleName)

    listMenu.AddEntryItem("Expires: " + ruleSettings[2])

    if ruleSettings[0] == 1.0
        listMenu.AddEntryItem("Active: ON")
    else
        listMenu.AddEntryItem("Active: OFF")
    endif

    if ruleSettings[1] == 1.0
        listMenu.AddEntryItem("Option - Blocked: ON")
    else
        listMenu.AddEntryItem("Option - Blocked: OFF")
    endif

    if ruleSettings[1] == 2.0
        listMenu.AddEntryItem("Option - Safe Areas: ON")
    else
        listMenu.AddEntryItem("Option - Safe Areas: OFF")
    endif

    if ruleSettings[1] == 3.0
        listMenu.AddEntryItem("Option - Safe Areas Permanent: ON")
    else
        listMenu.AddEntryItem("Option - Safe Areas Permanent: OFF")
    endif

    if ruleSettings[1] == 4.0
        listMenu.AddEntryItem("Option - Unsafe Areas: ON")
    else
        listMenu.AddEntryItem("Option - Unsafe Areas: OFF")
    endif

    if ruleSettings[1] == 5.0
        listMenu.AddEntryItem("Option - Unsafe Areas Permanent: ON")
    else
        listMenu.AddEntryItem("Option - Unsafe Areas Permanent: OFF")
    endif

    if ruleSettings[1] == 6.0
        listMenu.AddEntryItem("Option - All Areas Permanent: ON")
    else
        listMenu.AddEntryItem("Option - All Areas Permanent: OFF")
    endif

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ManageBondageRules()
    elseif listReturn == 1
        ManageBondageRule(idx, ruleName)
    elseif listReturn == 2
        if ruleSettings[0] == 1.0
            bindc_Rules.SetBondageRule(theMaster, idx, 0)
        else
            bindc_Rules.SetBondageRule(theMaster, idx, 1)
        endif
        ;debug.MessageBox("this work???")
        bondageRuleChanges = true
        ManageBondageRule(idx, ruleName)
    elseif listReturn > 2
        int opt = (listReturn - 2)
        if ruleSettings[1] == opt
            bindc_Rules.SetBondageRule(theMaster, idx, ruleSettings[0] as int, 0)
        else
            bindc_Rules.SetBondageRule(theMaster, idx, ruleSettings[0] as int, opt)
        endif
        bondageRuleChanges = true
        ManageBondageRule(idx, ruleName)


    else
        Debug.MessageBox("bondageRuleChanges: " + bondageRuleChanges)
        if bondageRuleChanges
            bondageRuleChanges = false
            BindSlave(theSlave)
        endif
    endif

endfunction

;******************************************************************************************
; LINKED
;******************************************************************************************

GlobalVariable property bindc_TakeLeaveTimerGlobal auto

ReferenceAlias property TheMasterAlias auto
;ReferenceAlias property MoveToSlaveRef auto

Package property bindc_PackageSlaveQuestMoveToSlave auto
Package property bindc_PackageSlaveQuestDoNothing auto

Faction property bindc_SlaveFaction auto