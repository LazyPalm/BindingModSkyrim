Scriptname bind_ActionMenu extends Quest  

event OnInit()

    if self.IsRunning()

        RegisterForModEvent("bind_ActionOpenMenuEvent", "ActionOpenMenu")
        RegisterForModEvent("bind_LatencyCheck", "LatencyCheck")

    endif

endEvent

event LatencyCheck(float timeIn)

    float timeOut = bind_Utility.GetTime()
    debug.MessageBox("Latency check in: " + timeIn + " out: " + timeOut + " dif: " + (timeOut - timeIn))

endevent

event ActionOpenMenu()
    ShowActionMenu()
endevent

function ShowActionMenu()
endfunction

function ShowMoreMenu()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Menu")
    listMenu.AddEntryItem("Masturbate")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ShowActionMenu()
    elseif listReturn == 1
        if functions_script.ModInRunningState()
            if functions_script.GetSubRef().WornHasKeyword(bondage_manager.zlib.zad_DeviousBelt)
                debug.MessageBox("You look down helplessly at the belt locking away your sex. There will be no self pleasure for now...")
            else
                bind_BoundMasturbationQuest.Start()
            endif
        endif
    endif

endfunction

function ShowDebugMenu()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Menu")
    listMenu.AddEntryItem("Test Dom Rule Change")
    listMenu.AddEntryItem("Direct Narration Test")
    listMenu.AddEntryItem("Skyrim Bondage Rule Test")
    ;listMenu.AddEntryItem("30s DHLP Test") ;send a dhlp event, register for a 30 second event and resume in onupdate - might need to be a new script

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ShowActionMenu()
    elseif listReturn == 1
        rules_manager.DomManagedRuleChange(functions_script.GetSubRef(), true)
    elseif listReturn == 2
        if think.IsAiReady()
            think.UseDirectNarration(functions_script.GetDomRef(), "You have defeated {{ player.name }} in battle, who is now tied kneeling at your feet. Talk to them about their fate. When the conversation is over you will untie and free them or fuck them based on their answers and your mood.")
        endif
    elseif listReturn == 3
        if think.IsAiReady()
            bind_ThinkingDom.AddBondageRule_Execute(functions_script.GetDomRef(), "", "{\"rule\":\"Random Rule\"}")
        endif
    endif

endfunction

function ShowOutfitsMenu()

    Actor a = functions_script.GetSubRef()
    int kSlotMaskBody = 0x00000004  ;32

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Settings Menu")
    listMenu.AddEntryItem("Learn nude outfit")
    listMenu.AddEntryItem("Learn bikini outfit")
    listMenu.AddEntryItem("Learn erotic armor outfit")
    listMenu.AddEntryItem("Learn safe area outfit")
    listMenu.AddEntryItem("Learn unsafe area outfit")
    listMenu.AddEntryItem("Try on nude outfit")
    listMenu.AddEntryItem("Try on bikini outfit")
    listMenu.AddEntryItem("Try on erotic armor outfit")
    listMenu.AddEntryItem("Try on safe area outfit")
    listMenu.AddEntryItem("Try on unsafe area outfit")
    listMenu.AddEntryItem("Add Bikini Keyword on Slot 32")
    listMenu.AddEntryItem("Add Erotic Armor Keyword on Slot 32")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ShowSettingsMenu()
    elseif listReturn == 1
        gear_manager.LearnOutfit(a, "nude")
        debug.MessageBox("Nude outfit learned")
    elseif listReturn == 2
        gear_manager.LearnOutfit(a, "bikini")
        debug.MessageBox("Bikini outfit learned")
    elseif listReturn == 3
        gear_manager.LearnOutfit(a, "erotic")
        debug.MessageBox("Erotic Armor outfit learned")
    elseif listReturn == 4
        gear_manager.LearnOutfit(a, "safe")
        debug.MessageBox("Safe area outfit learned")
    elseif listReturn == 5
        gear_manager.LearnOutfit(a, "unsafe")
        debug.MessageBox("Unsafe area outfit learned")
    elseif listReturn == 6
        gear_manager.WearOutfit(a, "nude")
        debug.MessageBox("Nude outfit equipped")
    elseif listReturn == 7
        gear_manager.WearOutfit(a, "bikini")
        debug.MessageBox("Bikini outfit equipped")
    elseif listReturn == 8
        gear_manager.WearOutfit(a, "erotic")
        debug.MessageBox("Erotic Armor outfit equipped")
    elseif listReturn == 9
        gear_manager.WearOutfit(a, "safe")
        debug.MessageBox("Safe area outfit equipped")
    elseif listReturn == 10
        gear_manager.WearOutfit(a, "unsafe")
        debug.MessageBox("Unsafe area outfit equipped")
    elseif listReturn == 11
        Keyword kw = Keyword.GetKeyword("bind_ArmorBikini")
        Armor bodyItem = a.GetWornForm(kSlotMaskBody) as Armor
        if bodyItem != none
            if !bodyItem.HasKeyWord(kw)
                PO3_SKSEFunctions.AddKeywordToForm(bodyItem, kw)
                if Keyword.GetKeyword("sla_armorhalfnakedbikini")
                    PO3_SKSEFunctions.AddKeywordToForm(bodyItem, Keyword.GetKeyword("sla_armorhalfnakedbikini"))
                endif
                debug.MessageBox("Bikini keyword added")
            else
                debug.MessageBox("Already has bikini keyword")
            endif
        else
            debug.MessageBox("No slot 32 item found")
        endif
    elseif listReturn == 12
        Keyword kw = Keyword.GetKeyword("bind_ArmorErotic")
        Armor bodyItem = a.GetWornForm(kSlotMaskBody) as Armor
        if bodyItem != none
            if !bodyItem.HasKeyWord(kw)
                PO3_SKSEFunctions.AddKeywordToForm(bodyItem, kw)
                if Keyword.GetKeyword("Eroticarmor") != none
                    PO3_SKSEFunctions.AddKeywordToForm(bodyItem, Keyword.GetKeyword("Eroticarmor"))
                endif
                debug.MessageBox("Erotic armor keyword added")
            else
                debug.MessageBox("Already has erotic armor keyword")
            endif
        else
            debug.MessageBox("No slot 32 item found")
        endif
    endif

endfunction

function ShowSettingsMenu()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Menu")
    listMenu.AddEntryItem("Change Dominant Title (" + functions_script.SettingsGetDomTitle() + ")")
    listMenu.AddEntryItem("Run Latency Check")
    ; listMenu.AddEntryItem("Browse Bondage Items")
    ; listMenu.AddEntryItem("Manage Favorites - For Bondage Rules")
    ;listMenu.AddEntryItem("Manage Rules")
    ;listMenu.AddEntryItem("Learn Worn DD Items as Set")    
    listMenu.AddEntryItem("Debug Tests")
    listMenu.AddEntryItem("Clear Future Doms List")
    listMenu.AddEntryItem("Run Dressing Room Quest")
    listMenu.AddEntryItem("Whitelist Items")
    ;listMenu.AddEntryItem("Manage Outfits")
    ; listMenu.AddEntryItem("Test Dom Tie 15s")
    ; listMenu.AddEntryItem("Dom Follow 30s")
    ; listMenu.AddEntryItem("Make Dom Say Follow Me")
    ; listMenu.AddEntryItem("BM - Take Snapshot")
    ; listMenu.AddEntryItem("BM - Remove All")
    ; listMenu.AddEntryItem("BM - Restore From Snapshot")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ShowActionMenu()
    elseif listReturn == 1
        functions_script.SettingsSetDomTitle()
    elseif listReturn == 2
        int handle = ModEvent.Create("bind_LatencyCheck")
        if handle
            ModEvent.PushFloat(handle, bind_Utility.GetTime())
            ModEvent.Send(handle)
        endif
    ; elseif listReturn == 3
    ;     bondage_manager.BrowseDdItemsList(functions_script.GetSubRef(), none, 1)
    ; elseif listReturn == 4
    ;     bondage_manager.ManageFavorites(functions_script.GetSubRef())
    ; elseif listReturn == 3
    ;     rules_manager.ManageRules(functions_script.GetSubRef())
    ; elseif listReturn == 3
    ;     bondage_manager.SaveWornDdItemsAsSet(functions_script.GetSubRef())
    elseif listReturn == 3
        ShowDebugMenu()
    elseif listReturn == 4
        StorageUtil.FormListClear(functions_script.GetSubRef(), "bind_future_doms")
        debug.MessageBox("Future doms list has been cleared")
    elseif listReturn == 5
        Quest q = Quest.GetQuest("bind_TheDressingRoomQuest")
        bind_Functions f = bind_Functions.GetBindingFunctions()
        if f.ModInRunningState()
            ;debug.MessageBox("start bind_TheDressingRoomQuest quest")
            if !q.IsRunning()
                q.Start()
            endif
        endif
    elseif listReturn == 6
        gear_manager.WhitelistItems(Game.GetPlayer())
    ; elseif listReturn == 7
    ;     ShowOutfitsMenu()
        ;     bind_MovementQuestScript.WalkTo(mqs.GetDomRef(), mqs.GetSubRef(), 128.0, 60)
    ; elseif listReturn == 3
    ;     bind_MovementQuestScript.StartWorking(mqs.GetDomRef())
    ;     bind_Utility.DoSleep(15.0)
    ;     bind_MovementQuestScript.StopWorking(mqs.GetDomRef())
    ; elseif listReturn == 4
    ;     bind_MovementQuestScript.Follow(mqs.GetDomRef(), mqs.GetSubRef())
    ;     bind_Utility.DoSleep(30.0)
    ;     bind_MovementQuestScript.StopFollowing()
    ; elseif listReturn == 5
    ;     bind_MovementQuestScript.MakeComment(mqs.GetDomRef(), mqs.GetSubRef(), bind_MovementQuestScript.GetCommentTypeFollowMe())
    ; elseif listReturn == 6
    ;     bondage_manager.SnapshotCurrentBondage(mqs.GetSubRef())
    ; elseif listReturn == 7
    ;     bondage_manager.RemoveAllBondageItems(mqs.GetSubRef())
    ; elseif listReturn == 8
    ;     bondage_manager.RestoreFromSnapshot(mqs.GetSubRef())
    endif

endfunction

function ShowPoseMenu()

    if functions_script.GetSubRef().IsOnMount()
        bind_Utility.WriteInternalMonologue("I need to get off this horse first...")
        return
    endif

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Menu")
    listMenu.AddEntryItem("Kneel")
    listMenu.AddEntryItem("Spread Kneel - For Sex")
    listMenu.AddEntryItem("Attention")
    listMenu.AddEntryItem("Present Hands - For Bondage")
    listMenu.AddEntryItem("Whipped - For Punishment")
    listMenu.AddEntryItem("Show Ass")
    listMenu.AddEntryItem("Prayer")
    listMenu.AddEntryItem("Sit On Groud")
    listMenu.AddEntryItem("Conversation - For Dialogue")
    listMenu.AddEntryItem("Deep Kneel - For Sleep")
    listMenu.AddEntryItem("Doorstep Kneel - Entry/Exit")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn >= 1
        bind_Utility.DisablePlayer()
        ;mqs.GetSubRef().SetDontMove()
    endif

    if listReturn == 0
        ShowActionMenuNested()
    elseif listReturn == 1
        pose_manager.DoHighKneel()
        SendKneelingEvent()
    elseif listReturn == 2
        pose_manager.DoSpreadKneel()
        if think.IsAiReady()
            string prompt = "{{ player.name }} is kneeling with legs spead wide with a desire for sex."
            if functions_script.GetRuleInfractions() > 0
                prompt += " They have been bad and you will explain they must work off punishments first. You will not give them what they want."
            else
                prompt += " They have been good and probably deserve to be tied and given what they want."
            endif
            ;BETTER? OR BOTH?
            ;add punishments due decorator at the prompt and display the lines above
            think.UseDirectNarration(functions_script.GetDomRef(), prompt)
        else
            functions_script.PoseForSex()            
        endif
    elseif listReturn == 3     
        pose_manager.DoAttention()
    elseif listReturn == 4     
        pose_manager.DoPresentHands()
        functions_script.PoseForBondage()
    elseif listReturn == 5     
        pose_manager.DoGetWhippedPose()
        if think.IsAiReady()
            string prompt = "{{ player.name }} has entered a bent foward at the waist pose indicating a desire to be whipped."
            if functions_script.GetRuleInfractions() > 0
                prompt += " They have been very bad lately."
            else
                prompt += " The have been good lately and must just desire the sting of a whip."
            endif
            ;BETTER? OR BOTH?
            ;add punishments due decorator at the prompt and display the lines above
            think.UseDirectNarration(functions_script.GetDomRef(), prompt)
        else
            functions_script.PoseForWhipping()
        endif
    elseif listReturn == 6     
        pose_manager.DoShowAss()
    elseif listReturn == 7     
        pose_manager.DoPrayerPose()
    elseif listReturn == 8     
        pose_manager.DoSitOnGround()
    elseif listReturn == 9     
        pose_manager.DoConversationPose()
    elseif listReturn == 10    
        pose_manager.DoDeepKneel()
        functions_script.PoseForSleep()
    elseif listReturn == 11
        pose_manager.DoDoorstepPose()
        if think.IsAiReady()
            ;have skyrimnet call an action
        else

        endif
        if functions_script.ModInRunningState()
            if !bind_EntryExitQuest.IsRunning()
                bind_EntryExitQuest.Start()
            endif
        endif
    endif

endfunction

auto state StandingState

    function ShowActionMenu()

        if bind_Utility.UiIsOpen()
            bind_Utility.WriteToConsole("Can't show action menu - UI is open")
            return
        endif

        GoToState("MenuOpenState")

        ShowActionMenuNested()

        GoToState("StandingState")

    endfunction

endstate

function ShowActionMenuNested()

    bool safeZone = (bind_GlobalSafeZone.GetValue() >= 2.0)

    UIWheelMenu actionMenu = UIExtensions.GetMenu("UIWheelMenu") as UIWheelMenu
    
    actionMenu.SetPropertyIndexString("optionText", 0, "Close")
    actionMenu.SetPropertyIndexString("optionLabelText", 0, "Close")
    actionMenu.SetPropertyIndexBool("optionEnabled", 0, true)

    if pose_manager.IsInPose()
        actionMenu.SetPropertyIndexString("optionText", 1, "Kneel")
        actionMenu.SetPropertyIndexString("optionLabelText", 1, "Kneel")
        actionMenu.SetPropertyIndexBool("optionEnabled", 1, false)

        actionMenu.SetPropertyIndexString("optionText", 2, "Resume Standing")
        actionMenu.SetPropertyIndexString("optionLabelText", 2, "Resume Standing")
        actionMenu.SetPropertyIndexBool("optionEnabled", 2, true)
    else
        actionMenu.SetPropertyIndexString("optionText", 1, "Kneel")
        actionMenu.SetPropertyIndexString("optionLabelText", 1, "Kneel")
        actionMenu.SetPropertyIndexBool("optionEnabled", 1, true)

        actionMenu.SetPropertyIndexString("optionText", 2, "Pose")
        actionMenu.SetPropertyIndexString("optionLabelText", 2, "Pose")
        actionMenu.SetPropertyIndexBool("optionEnabled", 2, true)
    endif

    Actor a = functions_script.GetSubRef()
    Actor dom = functions_script.GetDomRef()

    if safeZone ;!a.IsInFaction(bondage_manager.WearingHeavyBondageFaction())
        ; actionMenu.SetPropertyIndexString("optionText", 3, "Safe Zone Bondage")
        ; actionMenu.SetPropertyIndexString("optionLabelText", 3, "Safe Zone Bondage")
        ; actionMenu.SetPropertyIndexBool("optionEnabled", 3, true)        
        ;actionMenu.SetPropertyIndexString("optionText", 3, "Bind Wrists")
        ;actionMenu.SetPropertyIndexString("optionLabelText", 3, "Bind Wrists")
        ;actionMenu.SetPropertyIndexBool("optionEnabled", 3, true)
    else
        ; actionMenu.SetPropertyIndexString("optionText", 3, "Dangerous Area Bondage")
        ; actionMenu.SetPropertyIndexString("optionLabelText", 3, "Dangerous Area Bondage")
        ; actionMenu.SetPropertyIndexBool("optionEnabled", 3, true)
        ;actionMenu.SetPropertyIndexString("optionText", 3, "Free Wrists")
        ;actionMenu.SetPropertyIndexString("optionLabelText", 3, "Free Wrists")
        ;actionMenu.SetPropertyIndexBool("optionEnabled", 3, true)
    endif

    ; actionMenu.SetPropertyIndexString("optionText", 4, "Choose Outfit")
    ; actionMenu.SetPropertyIndexString("optionLabelText", 4, "Choose Outfit")
    ; actionMenu.SetPropertyIndexBool("optionEnabled", 4, true)

    if !gear_manager.IsNude(a)
        actionMenu.SetPropertyIndexString("optionText", 4, "Strip")
        actionMenu.SetPropertyIndexString("optionLabelText", 4, "Strip")
        actionMenu.SetPropertyIndexBool("optionEnabled", 4, true)
    else
        actionMenu.SetPropertyIndexString("optionText", 4, "Dress")
        actionMenu.SetPropertyIndexString("optionLabelText", 4, "Dress")
        actionMenu.SetPropertyIndexBool("optionEnabled", 4, true)
    endif

    actionMenu.SetPropertyIndexString("optionText", 5, "Furniture")
    actionMenu.SetPropertyIndexString("optionLabelText", 5, "Furniture")
    actionMenu.SetPropertyIndexBool("optionEnabled", 5, true)

    actionMenu.SetPropertyIndexString("optionText", 6, "More Options")
    actionMenu.SetPropertyIndexString("optionLabelText", 6, "More")
    actionMenu.SetPropertyIndexBool("optionEnabled", 6, true)

    actionMenu.SetPropertyIndexString("optionText", 7, "Settings")
    actionMenu.SetPropertyIndexString("optionLabelText", 7, "Settings")
    actionMenu.SetPropertyIndexBool("optionEnabled", 7, true)

    int actionResult = actionMenu.OpenMenu()

    bool isBoundFlag = a.IsInFaction(bondage_manager.WearingHeavyBondageFaction())
    bool isNudeFlag = gear_manager.IsNude(a)
    ;bool boundRule = rules_manager.IsHeavyBondageRequired(a, safeZone) ;(rules_manager.GetBondageRuleByName("Bound Rule") == 1)
    bool nudeRule = rules_manager.IsNudityRequired(a, safeZone) ; (rules_manager.GetBehaviorRuleByName("Body Rule:Nudity") == 1)

    if actionResult == 0
        ;close menu
    elseif actionResult == 1
        pose_manager.DoHighKneel()
        SendKneelingEvent()
    elseif actionResult == 2
        if pose_manager.IsInPose()
            pose_manager.ResumeStanding()
            bind_Utility.EnablePlayer()
            SendLeftKneelEvent()
            ;mqs.GetSubRef().SetDontMove(false)
        else
            ShowPoseMenu()
        endif
    elseif actionResult == 3        
        bind_Utility.WriteToConsole("action menu in result 3 - hbf: " + isBoundFlag)
        ; if a.GetDistance(dom) > 1000
        ;     bind_Utility.WriteInternalMonologue(functions_script.GetDomTitle() + " is not around to help me...")
        ; else
        if a.IsOnMount()
            bind_Utility.WriteInternalMonologue("I need to get off this horse first...")
        else
            ; if safeZone
            ;     ;bondage_manager.ActiveBondageSet = "" ;clear active set - this lets player pick a new set
            ;     functions_script.ApplySafeAreaBondage()
            ; else
            ;     functions_script.ApplyDangerousAreaBondage()
            ; endif
            ;functions_script.PoseForBondage()
            ; bind_Utility.DisablePlayer()
            ; if !isBoundFlag
            ;     PlayDomTyingAnimation(dom, a, true)
            ;     ;debug.MessageBox("bondage_manager: " + bondage_manager + " type " + bondage_manager.BONDAGE_TYPE_HEAVYBONDAGE())
            ;     if bondage_manager.AddItem(a, bondage_manager.BONDAGE_TYPE_HEAVYBONDAGE())
            ;     endif
            ; else
            ;     if !boundRule ;|| rules_manager.SuspendedHeavyBondage()
            ;         PlayDomTyingAnimation(dom, a, true)
            ;         if bondage_manager.RemoveItem(a, bondage_manager.BONDAGE_TYPE_HEAVYBONDAGE())
            ;         endif
            ;     else
            ;         bind_MovementQuestScript.MakeComment(dom, a, bind_MovementQuestScript.GetCommentTypeRefuseToUntie())
            ;     endif
            ; endif
            ;bind_Utility.EnablePlayer()
        endif
    elseif actionResult == 4
        if isBoundFlag && a.GetDistance(dom) > 1000
            bind_Utility.WriteInternalMonologue(functions_script.GetDomTitle() + " is not around to help me...")
        elseif a.IsOnMount()
            bind_Utility.WriteInternalMonologue("I need to get off this horse first...")
        else
            if isBoundFlag
                ; bind_Utility.WriteInternalMonologue("I can't change outfits while bound...")
                ; bind_Utility.DisablePlayer()
                ; ChooseOutfitMenu()
                ; functions_script.EventDomTyingAnimation(a, dom, false)
                ; bind_Utility.EnablePlayer()

                if !gear_manager.IsNude(a)
                    functions_script.EventDomTyingAnimation(a, dom, false)
                    gear_manager.RemoveWornGear(a)
                else
                    if !nudeRule ;|| rules_manager.SuspendedNudity()
                        functions_script.EventDomTyingAnimation(a, dom, false)
                        gear_manager.RestoreWornGear(a)
                        ;ChoseOutfitMenu()
                    else
                        bind_Utility.WriteInternalMonologue(functions_script.GetDomTitle() + " will not undress me...")
                    endif
                endif
                bind_Utility.EnablePlayer()
            else
                ; bind_Utility.DisablePlayer()
                ; ChooseOutfitMenu()
                ; bind_MovementQuestScript.PlayDressUndress(a)
                ; bind_Utility.EnablePlayer()

                bind_MovementQuestScript.PlayDressUndress(a)
                if !gear_manager.IsNude(a)
                    if think.IsAiReady()
                        think.UseDirectNarration(functions_script.GetDomRef(), "{{ player.name }} is removing their clothing.")
                    endif
                    gear_manager.RemoveWornGear(a)
                else
                    if think.IsAiReady()
                        think.UseDirectNarration(functions_script.GetDomRef(), "{{ player.name }} is getting dressed into their clothing.")
                    endif
                    gear_manager.RestoreWornGear(a)
                    ;ChoseOutfitMenu()
                endif
            endif
        endif
    elseif actionResult == 5
        functions_script.ShowFurniturePlacementMenu()
    elseif actionResult == 6
        ShowMoreMenu()
    elseif actionResult == 7
        ShowSettingsMenu()
    endif

endfunction

function ChooseOutfitMenu()

    Actor a = functions_script.GetSubRef()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("Safe Area Armor/Clothing")
    listMenu.AddEntryItem("Unsafe Area Armor/Clothing")
    listMenu.AddEntryItem("Erotic Armor")
    listMenu.AddEntryItem("Bikini Armor")
    listMenu.AddEntryItem("Nude with Jewelry")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        gear_manager.WearOutfit(a, "safe")
    elseif listReturn == 1
        gear_manager.WearOutfit(a, "unsafe")
    elseif listReturn == 2
        gear_manager.WearOutfit(a, "erotic")
    elseif listReturn == 3
        gear_manager.WearOutfit(a, "bikini")
    elseif listReturn == 4
        gear_manager.WearOutfit(a, "nude")
    endif

endfunction

state MenuOpenState

    function ShowActionMenu()
        bind_Utility.WriteToConsole("menu is already open...")
    endfunction

endstate

function SendKneelingEvent()
   int handle = ModEvent.Create("bind_SubKneeledEvent")
    if handle
        ModEvent.Send(handle)
    endif
endfunction

function SendLeftKneelEvent()
   int handle = ModEvent.Create("bind_SubLeftKneelEvent")
    if handle
        ModEvent.Send(handle)
    endif
endfunction

; function PlayDomTyingAnimation(Actor dom, Actor sub, bool faceAwayFromDom = false)
;     bind_MovementQuestScript.WalkTo(dom, sub)
;     bind_MovementQuestScript.FaceTarget(dom, sub)
;     if faceAwayFromDom
;         bind_MovementQuestScript.FaceAwayFromTarget(sub, dom)
;     endif
;     bind_MovementQuestScript.PlayDoWork(dom)
;     bind_Utility.DoSleep(2.0)
; endfunction

; function TieUntie(Actor a, Actor dom)

;     if a.GetDistance(dom) > 1000
;         bind_Utility.WriteInternalMonologue(functions_script.GetDomTitle() + " is not around to help me...")
;         return
;     endif

;     bool safeZone = (bind_GlobalSafeZone.GetValue() >= 2.0)
;     bool isBoundFlag = a.IsInFaction(bondage_manager.WearingHeavyBondageFaction())
;     bool boundRule = rules_manager.IsHeavyBondageRequired(a, safeZone) 


;     bind_Utility.DisablePlayer()
;     if !isBoundFlag
;         PlayDomTyingAnimation(dom, a, true)
;         ;debug.MessageBox("bondage_manager: " + bondage_manager + " type " + bondage_manager.BONDAGE_TYPE_HEAVYBONDAGE())
;         if bondage_manager.AddItem(a, bondage_manager.BONDAGE_TYPE_HEAVYBONDAGE())
;         endif
;     else
;         if !boundRule ;|| rules_manager.SuspendedHeavyBondage()
;             PlayDomTyingAnimation(dom, a, true)
;             if bondage_manager.RemoveItem(a, bondage_manager.BONDAGE_TYPE_HEAVYBONDAGE())
;             endif
;         else
;             bind_MovementQuestScript.MakeComment(dom, a, bind_MovementQuestScript.GetCommentTypeRefuseToUntie())
;         endif
;     endif
;     bind_Utility.EnablePlayer()

; endfunction

;bind_MainQuestScript property mqs auto

bind_PoseManager property pose_manager auto
bind_BondageManager property bondage_manager auto
bind_GearManager property gear_manager auto
bind_RulesManager property rules_manager auto
bind_Functions property functions_script auto
bind_ThinkingDom property think auto

Quest property bind_BoundMasturbationQuest auto
Quest property bind_EntryExitQuest auto

GlobalVariable property bind_GlobalSafeZone auto