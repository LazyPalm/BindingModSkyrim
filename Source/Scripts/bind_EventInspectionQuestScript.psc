Scriptname bind_EventInspectionQuestScript extends Quest  

Actor theSub
Actor theDom

bool pressedAction
bool removedHeavyBondage
bool removedShackles
bool orderedToStrip
bool failedInspection
int commandCount
int totalCommands
int dirtLevel

bool inPose
int currentPose

int POSE_STANDING = 0
int POSE_KNEELING = 1
int POSE_INSPECTION = 2
int POSE_ASS_OUT = 3
int POSE_SHOW_SEX = 4
int POSE_ATTENTION = 5

int sexEvent

ObjectReference startingMarker

event OnInit()

    if self.IsRunning()

        GoToState("")

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("AnimationEnd", "OnSexEndEvent")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        bcs.DoStartEvent()
        bcs.SetEventName(self.GetName())

        removedHeavyBondage = false
        removedShackles = false
        commandCount = 0
        orderedToStrip = false
        failedInspection = false
        pressedAction = false
        inPose = false
        currentPose = 0
        sexEvent = 0
        totalCommands = Utility.RandomInt(3, 5)
        bind_Utility.WriteToConsole("total commands: " + totalCommands)

        dirtLevel = 0 
        if fs.CleanModsRunning()
            fs.UpdateCleanTracking()
            dirtLevel = main.SubDirtLevel
            bind_Utility.WriteToConsole("dirtLevel: " + dirtLevel)
        endif

        StartEvent()

    endif

endevent

event SafewordEvent()
    
    bind_Utility.WriteToConsole("inspection quest safeword ending")

    if startingMarker != none
        startingMarker.Delete()
        startingMarker = none
    endif

    self.Stop()

endevent

event PressedAction(bool longPress)

    ;bind_Utility.WriteInternalMonologue("There is nothing else for me to do...")

    if !pressedAction
        pressedAction = true
        ShowActionMenu()
        pressedAction = false
    endif

endevent

event OnSexEndEvent(string eventName, string argString, float argNum, form sender)

    ;debug.MessageBox("in sex end??")

    sexEvent = 3 ;end this
    IssueNextCommand()

endevent

function StartEvent()

    startingMarker = theSub.PlaceAtMe(bind_InspectionItemsList.GetAt(1))
    startingMarker.Enable()

    if theSub.IsInFaction(bman.WearingHeavyBondageFaction()) && main.SoftCheckDDNG == 0 ;NOTE - with NG poses can be used with heavy bondage
        fs.EventDomTyingAnimation(theSub, theDom, true)
        if bman.RemoveItem(theSub, bman.BONDAGE_TYPE_HEAVYBONDAGE())
            bind_Utility.DoSleep()
            removedHeavyBondage = true
        endif
    endif
    
    if theSub.IsInFaction(bman.WearingAnkleShacklesFaction())
        fs.EventDomTyingAnimation(theSub, theDom, false)
        if bman.RemoveItem(theSub, bman.BONDAGE_TYPE_ANKLE_SHACKLES())
            bind_Utility.DoSleep()
            removedShackles = true
        endif
    endif

    SetObjectiveDisplayed(10, true)

    if !gms.IsNude(theSub)
        OrderToStrip()
    else
        IssueNextCommand()
    endif

endfunction

function OrderToStrip()

    orderedToStrip = true

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeStripCommand())

    bind_Utility.WriteInternalMonologue("I have been ordered to strip.")

    GoToState("OrderedToStripState")
    RegisterForSingleUpdate(10.0)

endfunction

state OrderedToStripState

    event OnUpdate()

        if !CheckForMovement()

            if gms.IsNude(theSub)
                ;bind_Utility.WriteInternalMonologue(main.GetDomTitle() + " looks pleased at my nudity...")

            else
                bind_Utility.WriteInternalMonologue("I am not naked yet. Shit.")
                failedInspection = true
            endif

        endif

        GoToState("")
        LookAtSub()

    endevent

endstate

function OrderToStand()

    commandCount += 1

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypePoseOrderReset())

    bind_Utility.WriteInternalMonologue("I have been ordered to stand.")

    GoToState("OrderToStandState")
    RegisterForSingleUpdate(10.0)
    
endfunction

state OrderToStandState

    event OnUpdate()

        if currentPose == POSE_STANDING

        else
            bind_Utility.WriteInternalMonologue("I was supposed to stand up...")
            failedInspection = true
        endif

        GoToState("")
        IssueNextCommand()

    endevent

endstate

function OrderToKnees()

    commandCount += 1

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypePoseOrderKneel())

    bind_Utility.WriteInternalMonologue("I have been ordered to my knees.")

    GoToState("OrderToKneesState")
    RegisterForSingleUpdate(10.0)

endfunction

state OrderToKneesState

    event OnUpdate()

        if currentPose == POSE_KNEELING
            ;bind_Utility.WriteInternalMonologue(main.GetDomTitle() + " likes me on my knees...")

        else
            bind_Utility.WriteInternalMonologue("I was supposed to get on my knees...")
            failedInspection = true
        endif

        GoToState("")
        LookAtSub()

    endevent

endstate

function OrderToShowAss()

    commandCount += 1

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypePoseOrderAssOut())

    bind_Utility.WriteInternalMonologue("I have been ordered to show my ass.")

    GoToState("OrderToShowAssState")
    RegisterForSingleUpdate(10.0)

endfunction

state OrderToShowAssState

    event OnUpdate()

        if currentPose == POSE_ASS_OUT

            ;verify heading - ass pointed at dom

            ;bind_Utility.WriteInternalMonologue(main.GetDomTitle() + " likes me bent over...")

        else
            bind_Utility.WriteInternalMonologue("I was supposed to be showing my ass...")
            failedInspection = true
        endif

        GoToState("")
        LookAtSub()

    endevent

endstate

function OrderToInspection()

    commandCount += 1

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypePoseOrderInspection())

    bind_Utility.WriteInternalMonologue("I have been ordered to the inspection pose.")

    GoToState("OrderToInspectionState")
    RegisterForSingleUpdate(10.0)

endfunction

state OrderToInspectionState

    event OnUpdate()

        if currentPose == POSE_INSPECTION
            ;bind_Utility.WriteInternalMonologue("I feel so on display...")

        else
            bind_Utility.WriteInternalMonologue("I was supposed to standing in inspection...")
            failedInspection = true
        endif

        GoToState("")
        LookAtSub()

    endevent

endstate

function OrderToShowSex()

    commandCount += 1

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypePoseOrderShowSex())

    bind_Utility.WriteInternalMonologue("I have been ordered to show my sex.")

    GoToState("OrderToShowSexState")
    RegisterForSingleUpdate(10.0)

endfunction

state OrderToShowSexState

    event OnUpdate()

        ;needst to be facing dom

        if currentPose == POSE_SHOW_SEX
            ;bind_Utility.WriteInternalMonologue("I feel so exposed...")

        else
            bind_Utility.WriteInternalMonologue("I was supposed to showing my sex...")
            failedInspection = true
        endif

        GoToState("")
        LookAtSub()

    endevent

endstate

function OrderAttention()

    commandCount += 1

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypePoseOrderAttention())

    bind_Utility.WriteInternalMonologue("I have been ordered to stand at attention.")

    GoToState("OrderAttentionState")
    RegisterForSingleUpdate(10.0)

endfunction

state OrderAttentionState

    event OnUpdate()

        ;needst to be facing dom

        if currentPose == POSE_ATTENTION
            bind_Utility.WriteInternalMonologue("I am standing very proper...")

        else
            bind_Utility.WriteInternalMonologue("I was supposed to be at attention...")
            failedInspection = true
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
            bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeBodyComment())
        endif

        ;possible good comment?
    endif

    GoToState("LookAtSubState")
    RegisterForSingleUpdate(5.0)

endfunction

state LookAtSubState

    event OnUpdate()

        GoToState("")
        IssueNextCommand()

    endevent

endstate

function IssueNextCommand()

    if main.DomPreferenceCleanSub == 1
        if dirtLevel > 25
            bind_Utility.WriteInternalMonologue("I am not allowed to be this dirty...")
            bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTooDirty())
            Debug.SendAnimationEvent(theSub, "IdleForceDefaultState")
            SetStage(30)
            EventEnd()
            return
        endif
    endif

    if failedInspection

        bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentDisappointmentComment())

        fs.MarkSubBrokeRule("I failed my inspection")

        Debug.SendAnimationEvent(theSub, "IdleForceDefaultState")

        SetStage(30)

        EventEnd()

    else

        ;check command count

        ;issue next command

        if commandCount <= totalCommands

            if currentPose == 0

                int command = Utility.RandomInt(1, 5)

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

                int arousal = bind_SlaHelper.GetArousal(theDom)
                if arousal >= main.SexDomArousalLevelToTrigger
                    sexEvent = 2
                else
                    sexEvent = 1
                endif

            endif

            if sexEvent == 3

                Debug.SendAnimationEvent(theSub, "IdleForceDefaultState")

                SetStage(20)

                EventEnd()

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

    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentDomStartingSex())

    bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is going to have sex with me.")

	if !sms.StartSexScene(theSub, theDom)
        debug.MessageBox("Could not start sex scene")
        sexEvent = 3 ;end this
        IssueNextCommand()
        return
    endif

    ; if !bind_SexLabHelper.StartTwoPersonSex(theDom, theSub)
    ;     sexEvent = 3 ;end this
    ;     IssueNextCommand()
    ;     return
    ; endif
    
    GoToState("HavingSexState")
    sexEvent = 3

endfunction

state HavingSexState
    event PressedAction(bool longPress)
        bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is having sex with me...")
    endevent
endstate

function OrderToMasturbate()

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentDomOrderToMasturbate())

    bind_Utility.WriteInternalMonologue("I have been ordered to masturbate.")

    GoToState("OrderToMasturbate")
    RegisterForSingleUpdate(10.0)

endfunction

state OrderToMasturbate
    event OnUpdate()
        if sexEvent != 3
            failedInspection = true
            LookAtSub()
        endif
    endevent
endstate

state MasurbatingState
    event PressedAction(bool longPress)
        bind_Utility.WriteInternalMonologue("I trying to get off, since " + fs.GetDomTitle() + " commanded me to...")
    endevent
endstate

function EventEnd()

    bind_Utility.DisablePlayer()

    if orderedToStrip && gms.IsNude(theSub)
        bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeGetDressedCommand())
        bind_MovementQuestScript.PlayDressUndress(theSub)
        ;gms.RestoreWornGear(theSub)
        fs.GetSubDressed()
        bind_Utility.DoSleep(1.0)
    endif

    if removedHeavyBondage || removedShackles
        fs.EventDomTyingAnimation(theSub, theDom, removedHeavyBondage)
    endif

    if removedHeavyBondage
        if bman.AddItem(theSub, bman.BONDAGE_TYPE_HEAVYBONDAGE())
            bind_Utility.DoSleep()
        endif
    endif

    if removedShackles
        if bman.AddItem(theSub, bman.BONDAGE_TYPE_HEAVYBONDAGE())
            bind_Utility.DoSleep()
        endif
    endif

    bind_Utility.EnablePlayer()

    startingMarker.Delete()
    startingMarker = none

    bcs.DoEndEvent()

    bind_GlobalEventInspectionNextRun.SetValue(bind_Utility.AddTimeToCurrentTime(main.InspectionHoursBetween, 0))

    self.Stop()

endfunction

function ShowActionMenu()

    UIWheelMenu actionMenu = UIExtensions.GetMenu("UIWheelMenu") as UIWheelMenu
    
    if !gms.IsNude(theSub)
        actionMenu.SetPropertyIndexString("optionText", 0, "Strip")
        actionMenu.SetPropertyIndexString("optionLabelText", 0, "Strip")
        actionMenu.SetPropertyIndexBool("optionEnabled", 0, true)
    else
        actionMenu.SetPropertyIndexString("optionText", 0, "Dress")
        actionMenu.SetPropertyIndexString("optionLabelText", 0, "Dress")
        actionMenu.SetPropertyIndexBool("optionEnabled", 0, true)
    endif

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
        if theSub.IsInFaction(bman.WearingHeavyBondageFaction())
            bind_MovementQuestScript.PlayDoWork(theDom)
        else
            bind_MovementQuestScript.PlayDressUndress(theSub)
        endif
        if !gms.IsNude(theSub)
            gms.WearOutfit(theSub, "nude")
        else
            fs.GetSubDressed()
        endif
    elseif actionResult == 1
    	theSub.PlayIdle(ResetIdle)
        ;Debug.SendAnimationEvent(theSub, "IdleForceDefaultState")
        inPose = false
        currentPose = POSE_STANDING
    elseif actionResult == 2
        theSub.PlayIdle(KneelingIdle)
    	;Debug.SendAnimationEvent(theSub, "ZapWriPose07")
        inPose = true
        currentPose = POSE_KNEELING
    elseif actionResult == 3
        theSub.PlayIdle(InspectionIdle)
    	;Debug.SendAnimationEvent(theSub, "ft_bdsm_idle_inspection")
        inPose = true
        currentPose = POSE_INSPECTION
    elseif actionResult == 4
        theSub.PlayIdle(ShowAssIdle)
    	;Debug.SendAnimationEvent(theSub, "ZapWriPose03") ;zapwripose04
        inPose = true
        currentPose = POSE_ASS_OUT
    elseif actionResult == 5
        theSub.PlayIdle(ShowSexIdle)
        ;Debug.SendAnimationEvent(theSub, "TepiShowVagina")
        inPose = true
        currentPose = POSE_SHOW_SEX
    elseif actionResult == 6
        theSub.PlayIdle(AttentionIdle)
        inPose = true
        currentPose = POSE_ATTENTION
    elseif actionResult == 7
        ;bind_SexLabHelper.StartOnePersonSex(theSub)
        if !sms.StartSexScene(theSub)
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
        bind_Utility.WriteInternalMonologue("I am not allowed to move during an inspection.")
        failedInspection = true
        return true
    else
        return false
    endif

endfunction

bind_MainQuestScript property main auto
bind_BondageManager property bman auto
bind_Controller property bcs auto
bind_GearManager property gms auto
bind_SexManager property sms auto
bind_Functions property fs auto

Formlist property bind_InspectionItemsList auto

Idle property ResetIdle auto
Idle property ShowSexIdle auto
Idle property ShowAssIdle auto
Idle property LayingShowSexIdle auto
Idle property InspectionIdle auto
Idle property AttentionIdle auto
Idle property KneelingIdle auto

GlobalVariable property bind_GlobalEventInspectionNextRun auto
