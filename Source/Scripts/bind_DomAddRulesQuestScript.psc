Scriptname bind_DomAddRulesQuestScript extends Quest  

Actor theSub
Actor theDom

bool doBondageRules = false

int add = 0
int choice = 0
int rule = 0

bind_ThinkingDom think
string selectedRuleAiSummary

event OnInit()

    if self.IsRunning()

        ;debug.MessageBox("in here???")
        
        GoToState("")

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        think = bind_ThinkingDom.GetThinkingDom()

        add = 0
        choice = 0
        rule = 0

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_DomRuleSceneCompleted", "DomRuleSceneEnded")
        RegisterForModEvent("bind_DomRuleSceneGiveThanksCompleted", "DomRuleSceneGiveThanksEnded")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        ;SetObjectiveDisplayed(10, true)

        EventStart()

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("dom add rules quest safeword ending")
    self.Stop()
endevent


event PressedAction(bool longPress)

    bind_Utility.WriteInternalMonologue("I am getting a rules change and need to pay attention...")

    bind_Utility.WriteToConsole("pressed action in dom add rules quest - no state")

endevent

event DomRuleSceneEnded()
    DomRuleSceneEndedFunction()
endevent

function DomRuleSceneEndedFunction()

    string playerResponse = "{{ player.name }} was silent about the rules change."

    string ruleName = "";
    if bind_GlobalEventVar2.GetValue() == 1
        ruleName = brm.GetFriendlyBehaviorRuleName(rule) ;brm.GetBehaviorRuleByIndex(rule)
    elseif bind_GlobalEventVar2.GetValue() == 2
        ruleName = brm.GetFriendlyBondageRuleName(rule) ;brm.GetBondageRuleByIndex(rule)
    endif
    
    ;debug.MessageBox(ruleName)
    
    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
        
    if add == 1
        listMenu.AddEntryItem("Adding " + ruleName + " (default)")
        listMenu.AddEntryItem("Give Thanks for adding...")
        ;listMenu.AddEntryItem("Ask to not add this rule...")
    elseif add == 2
        listMenu.AddEntryItem("Remove " + ruleName + " (default)")
        listMenu.AddEntryItem("Give Thanks for removing...")
        if fs.GetPoints() > 0
            listMenu.AddEntryItem("Beg to keep this rule...")
        endif
    endif

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()
    
    if listReturn == 0
        bind_GlobalEventVar4.SetValue(1)
        
    ;other options - spend points
    elseif listReturn == 1
        bind_GlobalEventVar4.SetValue(2) ;gave thanks
        playerResponse = "{{ player.name }} was thankful about the rules change."

    elseif listReturn == 2
        bind_GlobalEventVar4.SetValue(3) ;begged to keep
        add = 3 ;change to protect
        playerResponse = "{{ player.name }} begged to keep the rule. " + theDom.GetDisplayName() + " agreed to keep it in place."

    else
        bind_GlobalEventVar4.SetValue(1)
    endif

    ;make adjustments to this based on response

    if add == 1
        if choice == 1
            brm.SetBehaviorRule(theSub, rule, 1)
            brm.SetBehaviorRuleEnd(theSub, rule, bind_Utility.AddTimeToCurrentTime(Utility.RandomInt(24, 96), 0))
            ;brm.SetBehaviorRuleSettingByIndex(rule, 1)
        elseif choice == 2
            brm.SetBondageRule(theSub, rule, 1)
            brm.SetBondageRuleEnd(theSub, rule, bind_Utility.AddTimeToCurrentTime(Utility.RandomInt(24, 96), 0))
            ;brm.SetBondageRuleSettingByIndex(rule, 1)
        endif
    elseif add == 2
        if choice == 1
            ;brm.SetBehaviorRuleSettingByIndex(rule, 0)
            brm.SetBehaviorRule(theSub, rule, 0)
        elseif choice == 2
            ;brm.SetBondageRuleSettingByIndex(rule, 0)
            brm.SetBondageRule(theSub, rule, 0)
        endif
    elseif add == 3
        if choice == 1
            ;brm.SetBehaviorProtectionByIndex(rule, 1)
            brm.SetBehaviorRuleEnd(theSub, rule, bind_Utility.AddTimeToCurrentTime(Utility.RandomInt(48, 168), 0))
            fs.DeductPoint()
        elseif choice == 2
            ;brm.SetBondageProtectionByIndex(rule, 1)
            brm.SetBondageRuleEnd(theSub, rule, bind_Utility.AddTimeToCurrentTime(Utility.RandomInt(48, 168), 0))
            fs.DeductPoint()
        endif
    endif

    ; if add == 1 && choice == 2
    ;     int typeNumber = rule
    ;     bind_Utility.WriteToConsole("add type number: " + typeNumber)
    ;     if !theSub.IsInFaction(bms.WearingBondageItemFaction(typeNumber))       
    ;         bind_Utility.WriteToConsole("not in faction: " + bms.WearingBondageItemFaction(typeNumber))
    ;         bms.AddItem(theSub, typeNumber)
    ;     endif    
    ; elseif add == 2 && choice == 2
    ;     int typeNumber = rule
    ;     bind_Utility.WriteToConsole("remove type number: " + typeNumber)
    ;     if theSub.IsInFaction(bms.WearingBondageItemFaction(typeNumber))       
    ;         bind_Utility.WriteToConsole("in faction: " + bms.WearingBondageItemFaction(typeNumber))
    ;         bms.RemoveItem(theSub, typeNumber)
    ;     endif   
    ; endif

    UpdateTimers()

    if think.IsAiReady()
        ;SkyrimNetApi.DirectNarration(playerResponse, theDom)
        think.UseDirectNarration(theDom, playerResponse)
        ;bind_Utility.DoSleep(10.0)
        DomRuleSceneGiveThanksEndedFunction()
    else
        bind_DoAdRuQuSceneGiveThanks.Start()
    endif

    ;bind_DoAdRuQuSceneGiveThanks.Start()

endfunction

event DomRuleSceneGiveThanksEnded()
    DomRuleSceneGiveThanksEndedFunction()
endevent

function DomRuleSceneGiveThanksEndedFunction()

    ;debug.MessageBox("this happened??")

    int setId = StorageUtil.GetIntValue(theSub, "bind_wearing_outfit_id", 0)

    if add == 1 && choice == 2
        bind_Utility.WriteToConsole("add type number: " + rule)
        if setId > 0
            bms.EquipBondageOutfit(theSub, setId)
        endif
        ; if !theSub.IsInFaction(bms.WearingBondageItemFaction(rule))       
        ;     bind_Utility.WriteToConsole("not in faction: " + bms.WearingBondageItemFaction(rule))
        ;     ;bms.AddItem(theSub, rule)
        ;     if setId > 0
        ;         bms.EquipBondageOutfit(theSub, setId)
        ;     endif
        ; endif    
    elseif add == 2 && choice == 2
        bind_Utility.WriteToConsole("remove type number: " + rule)
        if setId > 0
            bms.EquipBondageOutfit(theSub, setId)
        endif
        ; if theSub.IsInFaction(bms.WearingBondageItemFaction(rule))       
        ;     bind_Utility.WriteToConsole("in faction: " + bms.WearingBondageItemFaction(rule))
        ;     ;bms.RemoveItem(theSub, rule)
        ;     if setId > 0
        ;         bms.EquipBondageOutfit(theSub, setId)
        ;     endif
        ; endif   
    endif

    if add == 1
        if choice == 1
            if rule == 0
                bind_Utility.WriteInternalMonologue("I guess my body is for all to see...")
            else
                bind_Utility.WriteInternalMonologue("I have more rules to follow...")
            endif
        endif

        if choice == 2
            if rule == 0
                ;bind_Utility.WriteInternalMonologue("I hope I don't need my hands for anything...")
            else
                bind_Utility.WriteInternalMonologue("I will be wearning more bondage...")
            endif
        endif
    
    elseif add == 2
        if choice == 1
            if rule == 0
                bind_Utility.WriteInternalMonologue("I will be warmer with clothes...")
            else
                bind_Utility.WriteInternalMonologue("I have less rules to follow...")
            endif
        endif

        if choice == 2
            if rule == 0
                ;bind_Utility.WriteInternalMonologue("It will feel good to have my wrists free...")
            else
                bind_Utility.WriteInternalMonologue("I will miss the extra bondage...")
            endif
        endif

    endif

    ;debug.MessageBox("in here...")

    EventEnd()

endfunction

string pickMenu = ""

function HybridManagedRuleChange()

    int behaviorRulesActive = brm.GetActiveBehaviorRulesCount(theSub)
    int bondageRulesActive = brm.GetActiveBondageRulesCount(theSub)

    int addRoll = Utility.RandomInt(0, 10)
    bind_Utility.WriteToConsole("add roll: " + addRoll)
    if addRoll > 3
        add = 1
    else
        add = 2
    endif

    ;add = Utility.RandomInt(1, 2) ;only want these set once

    choice = Utility.RandomInt(1, 2) ;only want these set once

    if bind_GlobalRulesBehaviorMax.GetValue() == 0.0 && bind_GlobalRulesBondageMax.GetValue() > 0.0
        choice = 2
    elseif bind_GlobalRulesBehaviorMax.GetValue() > 0.0 && bind_GlobalRulesBondageMax.GetValue() == 0.0
        choice = 1
    endif

    ;choice only supported
    if !doBondageRules
        choice = 1
    endif

    if choice == 1
        ;behavior
        if behaviorRulesActive <= bind_GlobalRulesBehaviorMin.GetValue()
            add = 1
        elseif behaviorRulesActive >= bind_GlobalRulesBehaviorMax.GetValue()
            add = 2
        endif

    else
        ;bondage
        if bondageRulesActive <= bind_GlobalRulesBondageMin.GetValue()
            add = 1
        elseif bondageRulesActive >= bind_GlobalRulesBondageMax.GetValue()
            add = 2
        endif

    endif

    bind_GlobalEventVar1.SetValue(add)
    bind_GlobalEventVar2.SetValue(choice)

    HybridManagedPick()

endfunction

function HybridManagedPick()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    string[] rules
    int[] settings

    if choice == 1
        rules = brm.GetBehaviorRuleNameArray()
        settings = brm.GetBehaviorRulesSettingsList(theSub)
    elseif choice == 2
        rules = brm.GetBondageRuleNameArray()
        settings = brm.GetBondageRulesSettingsList(theSub)
    endif

    int[] indexList = new int[50]

    int i = 0
    int i2 = 0
    while i < rules.Length

        if add == 1 && settings[i] == 0
            listMenu.AddEntryItem("Add - " + rules[i])
            indexList[i2] = i 
            i2 += 1
        elseif add == 2 && settings[i] == 1
            listMenu.AddEntryItem("Remove - " + rules[i])
            indexList[i2] = i 
            i2 += 1
        endif

        i += 1
    endwhile

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()
    if listReturn < rules.Length
        rule = indexList[listReturn]
        if think.IsAiReady()
            CreateSelectedRuleAiSummary(choice, add, rule)
        endif
    else
        HybridManagedPick()
    endif

    bind_GlobalEventVar3.SetValue(rule)

endfunction

function SubManagedPickAdd()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
        
    listMenu.AddEntryItem("Add rule (default)")
    listMenu.AddEntryItem("Remove rule")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        add = 1
    elseif listReturn == 1
        add = 2
    else
        add = 1
    endif

    SubManagedPickChoice()

endfunction

function SubManagedPickChoice()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    listMenu.AddEntryItem("<-- Go Back")
    listMenu.AddEntryItem("Behavior rule (default)")
    if doBondageRules
        listMenu.AddEntryItem("Bondage rule")
    endif

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        SubManagedPickAdd()
        return
    elseif listReturn == 1
        choice = 1
    elseif listReturn == 2
        choice = 2
    else
        choice = 1
    endif

    SubManagedPickRule()

endfunction

function SubManagedPickRule()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

    listMenu.AddEntryItem("<-- Go Back")

    string[] rules
    int[] settings

    if choice == 1
        rules = brm.GetBehaviorRuleNameArray()
        settings = brm.GetBehaviorRulesSettingsList(theSub)
    elseif choice == 2
        rules = brm.GetBondageRuleNameArray()
        settings = brm.GetBondageRulesSettingsList(theSub)
    endif

    int[] indexList = new int[50]

    int i = 0
    int i2 = 0
    while i < rules.Length

        if add == 1 && settings[i] == 0
            listMenu.AddEntryItem(rules[i])
            indexList[i2] = i 
            i2 += 1
        elseif add == 2 && settings[i] == 1
            listMenu.AddEntryItem(rules[i])
            indexList[i2] = i 
            i2 += 1
        endif

        i += 1
    endwhile

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()
    if listReturn == 0
        SubManagedPickChoice()
        return
    elseif listReturn > 0 && listReturn < rules.Length
        rule = indexList[listReturn - 1]
        if think.IsAiReady()
            CreateSelectedRuleAiSummary(choice, add, rule)
        endif
    else
        SubManagedPickRule()
    endif

    bind_GlobalEventVar1.SetValue(add)
    bind_GlobalEventVar2.SetValue(choice)
    bind_GlobalEventVar3.SetValue(rule)

endfunction

bool function HasBondageRulesOutfit()

    int[] outfitIdList = JsonUtil.IntListToArray(bmqs.BindingGameOutfitFile, "outfit_id_list")

    bool found = false

    int i = 0
    while i < outfitIdList.Length
        if JsonUtil.GetIntValue(bmqs.BindingGameOutfitFile, outfitIdList[i] + "_rules_based", 0) == 1   
            found = true
        endif
        i += 1
    endwhile

    bind_Utility.WriteToConsole("add rules quest - rules based outfit check: " + found)

    return found

endfunction

function EventStart()

    if bind_GlobalRulesBehaviorMax.GetValue() == 0.0 && bind_GlobalRulesBondageMax.GetValue() == 0.0
        bind_Utility.WriteToConsole("max behavior and bondage rules set to 0 - aborting quest")
        self.Stop()
        return
    endif

    doBondageRules = HasBondageRulesOutfit()

    bcs.DoStartEvent()
    bcs.SetEventName(self.GetName())

    bind_Utility.DisablePlayer()

    int controlMode = bind_GlobalRulesControlledBy.GetValue() as int

    if controlMode == brm.RULES_DOM_MANAGED()

        DomManagedRuleChange()

    elseif controlMode == brm.RULES_SUB_MANAGED()

        SubManagedPickAdd()

        ;debug.MessageBox("add: " + add + " choice: " + choice + " rule: " + rule)

    elseif controlMode == brm.RULES_HYBRID_MANAGED()

        HybridManagedRuleChange()

    endif


    if rule == -1
        bind_Utility.WriteToConsole("dom add rules quest - could not add rule")
        SilentEventEnd()       
        return
    endif

    if choice == 2
        bind_GlobalEventBondageItemType.SetValue(rule)
    ;     int[] bTypes = brm.GetBondageRuleToBondageTypeList()
    ;     bind_GlobalEventBondageItemType.SetValue(bTypes[rule])
    ;     bind_Utility.WriteToConsole("add bondage rule b type: " + bind_GlobalEventBondageItemType.GetValue())
    endif

    SetObjectiveDisplayed(10, true)

    if think.IsAiReady()
        if selectedRuleAiSummary != ""
            think.UseDirectNarration(theDom, theDom.GetDisplayName() + " is changing {{ player.name }}'s rules to " + selectedRuleAiSummary)
            DomRuleSceneEndedFunction()
        else
            EventEnd()
        endif
    else

        if add == 1
            bind_DomAddRulQueSceneAdd.Start()
        elseif add == 2
            bind_DomAddRulQueSceneRemove.Start()
        else
            ;this should never happen
            bind_Utility.WriteToConsole("dom rules manage failure - add: " + add)
            EventEnd()
        endif

    endif


endfunction

function CreateSelectedRuleAiSummary(int behaviorOrBondage, int addOrRemove, int ruleIdx)
    selectedRuleAiSummary = ""
    if behaviorOrBondage == 1
        if addOrRemove == 1
            selectedRuleAiSummary = "Adding " + brm.GetFriendlyBehaviorRuleName(ruleIdx) + " behavior rule"
        elseif addOrRemove == 2
            selectedRuleAiSummary = "Removing " + brm.GetFriendlyBehaviorRuleName(ruleIdx) + " behavior rule"
        endif
    elseif behaviorOrBondage == 2
        if addOrRemove == 1
            selectedRuleAiSummary = "Adding " + brm.GetFriendlyBondageRuleName(ruleIdx) + " bondage rule"
        elseif addOrRemove == 2
            selectedRuleAiSummary = "Removing " + brm.GetFriendlyBondageRuleName(ruleIdx) + " bondage rule"
        endif
    endif
endfunction

function SilentEventEnd()
    bind_Utility.EnablePlayer()
    bind_GlobalEventVar1.SetValue(0)
    bind_GlobalEventVar2.SetValue(0)
    bind_GlobalEventVar3.SetValue(0)
    bind_GlobalEventVar4.SetValue(0)
    bcs.DoEndEvent()
    self.Stop()
endfunction

function EventEnd()

    bind_Utility.EnablePlayer()

    bind_GlobalEventVar1.SetValue(0)
    bind_GlobalEventVar2.SetValue(0)
    bind_GlobalEventVar3.SetValue(0)
    bind_GlobalEventVar4.SetValue(0)

    SetObjectiveCompleted(10)
    SetObjectiveDisplayed(10, false)

    SetStage(20)

    bcs.DoEndEvent()

    self.Stop()

endfunction

function UpdateTimers()

    float currentTime = bind_Utility.GetTime()
    bind_GlobalRulesLastRule.SetValue(currentTime)
    bind_GlobalRulesNextRule.SetValue(bind_Utility.AddTimeToTime(currentTime, bind_GlobalRulesHoursBetween.GetValue() as int, 0))

endfunction

function DomManagedRuleChange()

    rule = -1 ;clear rule

    ; ;see if a rule has expired
    ; bool expiredFound = false

    ; int expiredBondageRule = brm.FindExpiredRule(theSub, brm.RULE_TYPE_BONDAGE())
    ; int expiredBehaviorRule = brm.FindExpiredRule(theSub, brm.RULE_TYPE_BEHAVIOR())

    ; if expiredBondageRule > -1 && expiredBehaviorRule > -1
    ;     float bondageExpired = brm.GetBondageRuleEnd(theSub, expiredBondageRule)
    ;     float behaviorExpired = brm.GetBehaviorRuleEnd(theSub, expiredBehaviorRule)
    ;     if bondageExpired < behaviorExpired
    ;         expiredBehaviorRule = -1 ;choose bondage rule
    ;     else
    ;         expiredBondageRule = -1 ;choose behavior rule
    ;     endif
    ; endif

    ; if expiredBondageRule > -1 && expiredBehaviorRule == -1
    ;     choice = 2
    ;     add = 2 ;set to remove
    ;     rule = expiredBondageRule
    ;     expiredFound = true
    ; elseif expiredBondageRule == -1 && expiredBehaviorRule > -1
    ;     choice = 1
    ;     add = 2 ;set to remove
    ;     rule = expiredBehaviorRule
    ;     expiredFound = true
    ; elseif expiredBondageRule > -1 && expiredBehaviorRule > -1
    ;     ;should not happen
    ; else
    ;     ;no expired rules found
    ;     expiredFound = false
    ; endif

    ; if !expiredFound
    ;     ;see if a rule needs to be added

    ;     bool breakLoop = false
    ;     bool tested1 = false
    ;     bool tested2 = false

    ;     choice = Utility.RandomInt(1, 2)
    ;     add = 1 ;set to add

    ;     while !breakloop && !(tested1 && tested2)
    ;         if choice == 1 ;behavior
    ;             tested1 = true
    ;             if bind_GlobalRulesBehaviorMax.GetValue() == 0.0
    ;                 choice == 2
    ;             else
    ;                 int behaviorRulesActive = brm.GetActiveBehaviorRulesCount(theSub)
    ;                 if behaviorRulesActive < bind_GlobalRulesBehaviorMax.GetValue()
    ;                     rule = brm.FindOpenRule(theSub, brm.RULE_TYPE_BEHAVIOR())
    ;                     if rule > -1
    ;                         breakLoop = true
    ;                     else
    ;                         choice = 2
    ;                     endif
    ;                 else
    ;                     choice = 2
    ;                 endif
    ;             endif
    ;         elseif choice == 2 ;bondage
    ;             tested2 = true
    ;             if bind_GlobalRulesBondageMax.GetValue() == 0.0
    ;                 choice == 1
    ;             else
    ;                 int bondageRulesActive = brm.GetActiveBondageRulesCount(theSub)
    ;                 if bondageRulesActive < bind_GlobalRulesBondageMax.GetValue()
    ;                     rule = brm.FindOpenRule(theSub, brm.RULE_TYPE_BONDAGE())
    ;                     if rule > -1
    ;                         breakLoop = true
    ;                     else
    ;                         choice = 1
    ;                     endif
    ;                 else
    ;                     choice = 1
    ;                 endif
    ;             endif
    ;         endif

    ;         bind_Utility.WriteToConsole("add loop breakloop: " + breakloop + " tested1 " + tested1 + " tested2: " + tested2)
    ;         bind_Utility.DoSleep()
    ;     endwhile

    ; endif



    ; int addRoll = Utility.RandomInt(0, 10)
    ; bind_Utility.WriteToConsole("add roll: " + addRoll)
    ; if addRoll > 3
    ;     add = 1
    ; else
    ;     add = 2
    ; endif

    ; if choice == 1
    ;     ;behavior
    ;     if behaviorRulesActive <= bind_GlobalRulesBehaviorMin.GetValue()
    ;         add = 1
    ;     elseif behaviorRulesActive >= bind_GlobalRulesBehaviorMax.GetValue()
    ;         add = 2
    ;     endif

    ;     if add == 1
    ;         rule = brm.FindFreeBehaviorRule()
    ;     elseif add == 2
    ;         rule = brm.FindActiveBehaviorRule()
    ;     endif

    ; else
    ;     ;bondage
    ;     if bondageRulesActive <= bind_GlobalRulesBondageMin.GetValue()
    ;         add = 1
    ;     elseif bondageRulesActive >= bind_GlobalRulesBondageMax.GetValue()
    ;         add = 2
    ;     endif

    ;     if add == 1
    ;         rule = brm.FindFreeBondageRule()
    ;     elseif add == 2
    ;         rule = brm.FindActiveBondageRule()
    ;     endif

    ; endif

    string selectedAction = brm.DomManagedRuleChange(fs.GetSubRef(), false)

    if selectedAction != ""
        string[] arr = StringUtil.Split(selectedAction, "|")
        if arr.Length == 2
            string actionType = arr[0]
            rule = arr[1] as int

            if actionType == "1" ;remove bondage rule
                add = 2
                choice = 2
            elseif actionType == "2" ;remove behavior rule
                add = 2
                choice = 1
            elseif actionType == "3" ;add bondage rule
                add = 1
                choice = 2
            elseif actionType == "4" ;add behavior rule
                add = 1
                choice = 1
            endif

            if !doBondageRules
                choice = 1
            endif

            ;debug.MessageBox("Action: " + actionType + " Rule: " + rule)

        endif
    endif

    if think.IsAiReady()
        CreateSelectedRuleAiSummary(choice, add, rule)
    endif

    bind_GlobalEventVar1.SetValue(add)
    bind_GlobalEventVar2.SetValue(choice)
    bind_GlobalEventVar3.SetValue(rule)

    bind_Utility.WriteToConsole("add: " + add + " choice: " + choice + " rule: " + rule)

endfunction


bind_MainQuestScript property bmqs auto
bind_Controller property bcs auto
bind_RulesManager property brm auto
bind_BondageManager property bms auto
bind_Functions property fs auto

Scene property bind_DomAddRulQueSceneAdd auto
Scene property bind_DomAddRulQueSceneRemove auto
Scene property bind_DoAdRuQuSceneGiveThanks auto

GlobalVariable property bind_GlobalEventVar1 auto
GlobalVariable property bind_GlobalEventVar2 auto
GlobalVariable property bind_GlobalEventVar3 auto
GlobalVariable property bind_GlobalEventVar4 auto
GlobalVariable property bind_GlobalEventBondageItemType auto

GlobalVariable property bind_GlobalRulesLastRule auto
GlobalVariable property bind_GlobalRulesNextRule auto
GlobalVariable property bind_GlobalRulesHoursBetween auto

GlobalVariable property bind_GlobalRulesBehaviorMin auto
GlobalVariable property bind_GlobalRulesBehaviorMax auto
GlobalVariable property bind_GlobalRulesBondageMin auto
GlobalVariable property bind_GlobalRulesBondageMax auto

GlobalVariable property bind_GlobalRulesControlledBy auto