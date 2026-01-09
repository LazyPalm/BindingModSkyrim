Scriptname bindc_EventInspect extends Quest

Actor theSub
Actor theDom

bool pressedAction
bool longPressedAction
bool failedInspection
bool autoMode = false

int commandCount
int totalCommands

bool inPose
int currentPose

int POSE_STANDING = 0
int POSE_KNEELING = 1
int POSE_INSPECTION = 2
int POSE_ASS_OUT = 3
int POSE_SHOW_SEX = 4
int POSE_ATTENTION = 5

bool didKneel = false
bool didInspect = false
bool didAssOut = false 
bool didShowSex = false 
bool didAttention = false

int sexEvent

bool domStartedSex = false
bool sexAnimationRan = false

float commandRespondTime = 15.0

Form[] rItems

ObjectReference startingMarker

event OnInit()

    if self.IsRunning()

        if data_script.MainScript.StartEvent(self, "Inspect", true)

            GoToState("")

            RegisterForModEvent("AnimationEnd", "OnSexEndEvent")

            theSub = Game.GetPlayer()
            theDom = bindc_Util.GetDom()
            TheDomRef.ForceRefTo(theDom)

            bindc_Util.UpdateDirtLevels(theSub)

            domStartedSex = false
            sexAnimationRan = false
            commandCount = 0
            failedInspection = false
            pressedAction = false
            inPose = false
            currentPose = 0
            sexEvent = 0
            totalCommands = Utility.RandomInt(2, 3)
            bindc_Util.WriteInformation("total commands: " + totalCommands)

            SetObjectiveDisplayed(10, true)

            StartInspect()

        endif

    else

        self.Stop()

    endif

endevent

function ActionShortPress()

    ;bindc_Util.WriteInternalMonologue("There is nothing else for me to do...")

    if !pressedAction && !longPressedAction
        pressedAction = true
        ShowActionMenu()
        pressedAction = false
    endif

endfunction

function ActionLongPress()

    if CheckForMovement()
        return
    endif

    if !longPressedAction
        longPressedAction = true
        autoMode = true
        bindc_Util.WriteNotification("Auto mode enabled", bindc_Util.TextColorBlue())
        bindc_Util.DisablePlayer()
        commandRespondTime = 5.0
        UnregisterForUpdate()
        RegisterForSingleUpdate(1.0)
        ;longPressedAction = false ;don't enable this again
    endif

endfunction

function SafeWord()

    bindc_Util.WriteInformation("inspection quest safeword ending")

    if startingMarker != none
        startingMarker.Delete()
        startingMarker = none
    endif

endfunction

; event CombatStartedInEvent(Form akTarget)
;     if bindc_Util.ConfirmBox("Your party has been attacked. End this?", "I must fight", fs.GetDomTitle() + " can handle this. Leave me.")
;         fs.Safeword()
;     endif
; endevent

event OnSexEndEvent(string eventName, string argString, float argNum, form sender)

    sexAnimationRan = true
    sexEvent = 3 ;end this
    IssueNextCommand()

endevent

function StartInspect()

    bindc_InspectSceneIntro.Start()

    ;todo - make sub turn forward, l side, r side, back in addition to poses??

    int outfitId = data_script.BondageScript.GetBondageOutfitForEvent(theSub, "event_inspection")
    if outfitId == 0
        outfitId = data_script.BondageScript.GetBondageOutfitForEvent(theSub, "event_any_event")
    endif
    if outfitId > 0
    else 
        debug.MessageBox("No inspection outfit was found")
        data_script.MainScript.EndRunningEvent() ;should always be the last line
        return
    endif

    bindc_Util.DisablePlayer()

    bindc_Util.MoveToPlayer(theDom)
    
    bindc_Util.PlayTyingAnimation(theDom, theSub)

    bindc_Util.FadeOutApplyNoDisable()

    data_script.BondageScript.EquipBondageOutfit(theSub, outfitId)
    bindc_Util.DoSleep(3.0)

    bindc_Util.StopAnimations(thedom)

    bindc_Util.EnablePlayer()

    bindc_Util.FadeOutRemoveNoDisable()

    ;display stand at marker
    startingMarker = theSub.PlaceAtMe(MAGINVHealSpellArt)
    startingMarker.Enable()

    IssueNextCommand()

endfunction

function OrderToStand()

    bindc_Util.FaceTarget(theDom, theSub)

    bindc_InspectScenePoseStandUp.Start()

    bindc_Util.WriteInternalMonologue("I have been ordered to stand.")

    GoToState("OrderToStandState")

    RegisterForSingleUpdate(commandRespondTime)
    
endfunction

state OrderToStandState

    event OnUpdate()

        if autoMode
            theSub.PlayIdle(ResetIdle)
            inPose = false
            currentPose = POSE_STANDING
        else 
            if currentPose == POSE_STANDING
                ;nothing to set
            else
                bindc_Util.WriteInternalMonologue("I was supposed to stand up...")
                failedInspection = true
            endif
        endif

        GoToState("")
        IssueNextCommand()

    endevent

endstate

function OrderToKnees()

    commandCount += 1

    bindc_Util.FaceTarget(theDom, theSub)

    bindc_InspectScenePoseKneel.Start()

    bindc_Util.WriteInternalMonologue("I have been ordered to my knees.")

    GoToState("OrderToKneesState")

    RegisterForSingleUpdate(commandRespondTime)

endfunction

state OrderToKneesState

    event OnUpdate()

        if autoMode
            theSub.PlayIdle(KneelingIdle)
            inPose = true
            didKneel = true
            currentPose = POSE_KNEELING
        else 
            if currentPose == POSE_KNEELING
                ;bindc_Util.WriteInternalMonologue(main.GetDomTitle() + " likes me on my knees...")
                didKneel = true
            else
                bindc_Util.WriteInternalMonologue("I was supposed to get on my knees...")
                failedInspection = true
            endif
        endif

        GoToState("")
        LookAtSub()

    endevent

endstate

function OrderToShowAss()

    commandCount += 1

    ;bindc_Util.FaceTarget(theDom, theSub)

    bindc_InspectScenePoseAssOut.Start()

    bindc_Util.WriteInternalMonologue("I have been ordered to show my ass.")

    GoToState("OrderToShowAssState")
    RegisterForSingleUpdate(commandRespondTime)

endfunction

state OrderToShowAssState

    event OnUpdate()

        if autoMode
            theSub.PlayIdle(ShowAssIdle)
            inPose = true
            didAssOut = true
            currentPose = POSE_ASS_OUT
        else 
            if currentPose == POSE_ASS_OUT
                ;verify heading - ass pointed at dom
                ;bindc_Util.WriteInternalMonologue(main.GetDomTitle() + " likes me bent over...")
                didAssOut = true
            else
                bindc_Util.WriteInternalMonologue("I was supposed to be showing my ass...")
                failedInspection = true
            endif
        endif

        GoToState("")
        LookAtSub()

    endevent

endstate

function OrderToInspection()

    commandCount += 1

    bindc_Util.FaceTarget(theDom, theSub)

    bindc_InspectScenePoseInspection.Start()

    bindc_Util.WriteInternalMonologue("I have been ordered to the inspection pose.")

    GoToState("OrderToInspectionState")
    RegisterForSingleUpdate(commandRespondTime)

endfunction

state OrderToInspectionState

    event OnUpdate()

        if autoMode
            theSub.PlayIdle(InspectionIdle)
            inPose = true
            didInspect = true
            currentPose = POSE_INSPECTION
        else 
            if currentPose == POSE_INSPECTION
                ;bindc_Util.WriteInternalMonologue("I feel so on display...")
                didInspect = true
            else
                bindc_Util.WriteInternalMonologue("I was supposed to standing in inspection...")
                failedInspection = true
            endif
        endif

        GoToState("")
        LookAtSub()

    endevent

endstate

function OrderToShowSex()

    commandCount += 1

    bindc_Util.FaceTarget(theDom, theSub)

    bindc_InspectScenePoseShowSex.Start()

    bindc_Util.WriteInternalMonologue("I have been ordered to show my sex.")

    GoToState("OrderToShowSexState")
    RegisterForSingleUpdate(commandRespondTime)

endfunction

state OrderToShowSexState

    event OnUpdate()

        ;needst to be facing dom

        if autoMode
            theSub.PlayIdle(ShowSexIdle)
            inPose = true
            didShowSex = true
            currentPose = POSE_SHOW_SEX
        else 
            if currentPose == POSE_SHOW_SEX
                ;bindc_Util.WriteInternalMonologue("I feel so exposed...")
                didShowSex = true
            else
                bindc_Util.WriteInternalMonologue("I was supposed to showing my sex...")
                failedInspection = true
            endif
        endif

        GoToState("")
        LookAtSub()

    endevent

endstate

function OrderAttention()

    commandCount += 1

    bindc_Util.FaceTarget(theDom, theSub)

    bindc_InspectScenePoseAttention.Start()

    bindc_Util.WriteInternalMonologue("I have been ordered to stand at attention.")

    GoToState("OrderAttentionState")
    RegisterForSingleUpdate(commandRespondTime)

endfunction

state OrderAttentionState

    event OnUpdate()

        ;needst to be facing dom

        if autoMode
            theSub.PlayIdle(AttentionIdle)
            inPose = true
            didAttention = true
            currentPose = POSE_ATTENTION
        else
            if currentPose == POSE_ATTENTION
                bindc_Util.WriteInternalMonologue("I am standing very proper...")
                didAttention = true
            else
                bindc_Util.WriteInternalMonologue("I was supposed to be at attention...")
                failedInspection = true
            endif
        endif

        GoToState("")
        LookAtSub()

    endevent

endstate

function LookAtSub()

    if failedInspection
        ;disappointed comment
    else
        ;make dirt comment

        if Utility.RandomInt(1, 2) == 2
            bindc_InspectSceneLookComment.Start()
        endif

        ;possible good comment?
    endif

    GoToState("LookAtSubState")
    RegisterForSingleUpdate(10.0)

endfunction

state LookAtSubState

    event OnUpdate()

        GoToState("")
        IssueNextCommand()

    endevent

endstate

int function GenerateCommand()

    string available = ""

    if !didKneel
        available += "1"
    endif
    if !didInspect
        if available != ""
            available += "|"
        endif
        available += "2"
    endif
    if !didAssOut 
        if available != ""
            available += "|"
        endif
        available += "3"
    endif
    if !didShowSex 
        if available != ""
            available += "|"
        endif
        available += "4"
    endif
    if !didAttention
        if available != ""
            available += "|"
        endif
        available += "5"
    endif

    bindc_Util.WriteInformation("available commands: " + available)

    string[] arr = StringUtil.Split(available, "|")
    return arr[Utility.RandomInt(0, arr.Length - 1)] as int

endfunction

function IssueNextCommand()

    if StorageUtil.GetIntValue(none, "bindc_clean_slave", 0) == 1
        if StorageUtil.GetIntValue(theSub, "bindc_dirt_level", 0) > 25
            bindc_Util.MarkInfraction("I am not allowed to be this dirty", false)
            bindc_InspectSceneDirty.Start()
            Debug.SendAnimationEvent(theSub, "IdleForceDefaultState")
            SetStage(30)
            EventInspectEnd()
            return
        endif
    endif

    if failedInspection

        bindc_InspectSceneFailed.Start()

        bindc_Util.MarkInfraction("I failed my inspection", false)

        Debug.SendAnimationEvent(theSub, "IdleForceDefaultState")

        SetStage(30)

        EventInspectEnd()

    else

         ;check command count

         ;issue next command

        if commandCount < totalCommands

            if currentPose == 0

                int command = GenerateCommand() ;Utility.RandomInt(1, 5)

                if command == 1
                    OrderToKnees()
                elseif command == 2
                    OrderToShowAss()
                elseif command == 3
                    OrderToInspection()
                elseif command == 4
                    OrderToShowSex()
                elseif command == 5
                    OrderAttention()
                endif

            else

                OrderToStand()

            endif

        else

            if sexEvent == 0

                int arousal = data_script.SexLabScript.UpdateArousalLevels(theDom)
                int needed = StorageUtil.GetIntValue(none, "bindc_dom_arousal_need_for_sex", 70)

                if arousal >= needed ; main.SexDomArousalLevelToTrigger
                    sexEvent = 2
                else
                    sexEvent = 1
                endif

            endif

            if sexEvent == 3

                Debug.SendAnimationEvent(theSub, "IdleForceDefaultState")

                SetStage(20)

                EventInspectEnd()

            endif

            if sexEvent == 1
                OrderToMasturbate()
            endif

            if sexEvent == 2
                HaveSex()
            endif
            
         endif

    endif
    

endfunction

function HaveSex()

    domStartedSex = true

    bindc_InspectSceneSex.Start()

    bindc_Util.WriteInternalMonologue(bindc_Util.GetDomTitle() + " is going to have sex with me...")

    if !data_script.SexLabScript.StartSexScene(theSub, theDom)
        debug.MessageBox("Could not start sex scene")
        sexEvent = 3 ;end this
        IssueNextCommand()
        return
    endif
    
    GoToState("HavingSexState")
    sexEvent = 3

endfunction

state HavingSexState
    function ActionShortPress()
        bindc_Util.WriteInternalMonologue(bindc_Util.GetDomTitle() + " is having sex with me...")
    endfunction
endstate

function OrderToMasturbate()

    bindc_Util.FaceTarget(theDom, theSub)

    bindc_InspectSceneMasturbate.Start()

    bindc_Util.WriteInternalMonologue("I have been ordered to masturbate.")

    GoToState("OrderToMasturbate")
    RegisterForSingleUpdate(10.0)

endfunction

state OrderToMasturbate
    event OnUpdate()
        if autoMode
            if data_script.SexLabScript.StartSexScene(theSub)
                debug.MessageBox("Could not start sex scene")
            endif
            sexEvent = 3        
            GoToState("MasurbatingState")
        else
            if sexEvent != 3
                failedInspection = true
                LookAtSub()
            endif
        endif
    endevent
endstate

state MasurbatingState
    function ActionShortPress()
        bindc_Util.WriteInternalMonologue("I trying to get off, since " + bindc_Util.GetDomTitle() + " commanded me to...")
    endfunction
endstate

function EventInspectEnd()

    startingMarker.Delete()
    startingMarker = none

    bindc_Util.MoveToPlayer(theDom)

    bindc_Util.DisablePlayer()

    bindc_Util.PlayTyingAnimation(theDom, theSub)

    bindc_Util.FadeOutApplyNoDisable()

    int lastOutfitId = StorageUtil.GetIntValue(theSub, "bindc_outfit_id", -1)
    if lastOutfitId > 0
        data_script.BondageScript.EquipBondageOutfit(theSub, lastOutfitId)
        bindc_Util.DoSleep(3.0)
    else 
        ;remove stuff??
    endif

    bindc_Util.StopAnimations(theDom) ;NOTE - slavery quest will do the outfit change when it starts

    bindc_Util.FadeOutRemoveNoDisable()

    bindc_Util.ClearPackages(theDom)

    bindc_Util.EnablePlayer()

    float ct = bindc_Util.GetTime()
    StorageUtil.SetFloatValue(none, "bindc_event_inspect_last", ct)

    data_script.MainScript.EndRunningEvent()

;     if sexAnimationRan && domStartedSex
;         bind_RulesManager rms = Quest.GetQuest("bind_MainQuest") as bind_RulesManager
;         Quest q = Quest.GetQuest("bind_SexGiveThanksQuest")
;         if rms.GetBehaviorRule(theSub, rms.BEHAVIOR_RULE_SEX_GIVE_THANKS()) == 1 
;             sms.SubRequiredToThankForSex = 1
;             if !q.IsRunning()
;                 q.Start()
;             endif
;         else
;             sms.SubRequiredToThankForSex = 0
;         endif
;     endif

endfunction

function ShowActionMenu()

    if CheckForMovement()
        return
    endif

    UIWheelMenu actionMenu = UIExtensions.GetMenu("UIWheelMenu") as UIWheelMenu

    actionMenu.SetPropertyIndexString("optionText", 0, "Close This")
    actionMenu.SetPropertyIndexString("optionLabelText", 0, "Close This")
    actionMenu.SetPropertyIndexBool("optionEnabled", 0, 1)

    actionMenu.SetPropertyIndexString("optionText", 1, "Resume Standing")
    actionMenu.SetPropertyIndexString("optionLabelText", 1, "Resume Standing")
    actionMenu.SetPropertyIndexBool("optionEnabled", 1, inPose)

    actionMenu.SetPropertyIndexString("optionText", 2, "Kneel")
    actionMenu.SetPropertyIndexString("optionLabelText", 2, "Kneel")
    actionMenu.SetPropertyIndexBool("optionEnabled", 2, !inPose)

    actionMenu.SetPropertyIndexString("optionText", 3, "Inspection")
    actionMenu.SetPropertyIndexString("optionLabelText", 3, "Inspection")
    actionMenu.SetPropertyIndexBool("optionEnabled", 3, !inPose)

    actionMenu.SetPropertyIndexString("optionText", 4, "Ass Out")
    actionMenu.SetPropertyIndexString("optionLabelText", 4, "Ass Out")
    actionMenu.SetPropertyIndexBool("optionEnabled", 4, !inPose)

    actionMenu.SetPropertyIndexString("optionText", 5, "Show Sex")
    actionMenu.SetPropertyIndexString("optionLabelText", 5, "Show Sex")
    actionMenu.SetPropertyIndexBool("optionEnabled", 5, !inPose)

    actionMenu.SetPropertyIndexString("optionText", 6, "Attention")
    actionMenu.SetPropertyIndexString("optionLabelText", 6, "Attention")
    actionMenu.SetPropertyIndexBool("optionEnabled", 6, !inPose)

    actionMenu.SetPropertyIndexString("optionText", 7, "Masturbate")
    actionMenu.SetPropertyIndexString("optionLabelText", 7, "Masturbate")
    actionMenu.SetPropertyIndexBool("optionEnabled", 7, true)

    int actionResult = actionMenu.OpenMenu()

    if actionResult == 0
        ;close

    elseif actionResult == 1
    	theSub.PlayIdle(ResetIdle)
        inPose = false
        currentPose = POSE_STANDING

    elseif actionResult == 2
        theSub.PlayIdle(KneelingIdle)
        inPose = true
        currentPose = POSE_KNEELING

    elseif actionResult == 3
        theSub.PlayIdle(InspectionIdle)
        inPose = true
        currentPose = POSE_INSPECTION

    elseif actionResult == 4
        theSub.PlayIdle(ShowAssIdle)
        inPose = true
        currentPose = POSE_ASS_OUT

    elseif actionResult == 5
        theSub.PlayIdle(ShowSexIdle)
        inPose = true
        currentPose = POSE_SHOW_SEX

    elseif actionResult == 6
        theSub.PlayIdle(AttentionIdle)
        inPose = true
        currentPose = POSE_ATTENTION

    elseif actionResult == 7
        if data_script.SexLabScript.StartSexScene(theSub)
            debug.MessageBox("Could not start sex scene")
        endif
        sexEvent = 3        
        GoToState("MasurbatingState")

    endif

    UnregisterForUpdate()
    RegisterForSingleUpdate(1.0)

endfunction

bool function CheckForMovement()

    if theSub.GetDistance(startingMarker) > 150.0
        bindc_Util.WriteInternalMonologue("I am not allowed to move during an inspection...")
        failedInspection = true
        return true
    else
        return false
    endif

endfunction

bindc_Data property data_script auto

Form property XMarker auto
Form property MAGINVHealSpellArt auto

Idle property ResetIdle auto
Idle property ShowSexIdle auto
Idle property ShowAssIdle auto
Idle property LayingShowSexIdle auto
Idle property InspectionIdle auto
Idle property AttentionIdle auto
Idle property KneelingIdle auto

ReferenceAlias property TheDomRef auto

Scene property bindc_InspectScenePoseAssOut auto
Scene property bindc_InspectScenePoseAttention auto
Scene property bindc_InspectScenePoseInspection auto
Scene property bindc_InspectScenePoseKneel auto
Scene property bindc_InspectScenePoseShowSex auto
Scene property bindc_InspectScenePoseStandUp auto
Scene property bindc_InspectSceneDirty auto
Scene property bindc_InspectSceneFailed auto
Scene property bindc_InspectSceneLookComment auto
Scene property bindc_InspectSceneMasturbate auto
Scene property bindc_InspectSceneSex auto
Scene property bindc_InspectSceneIntro auto