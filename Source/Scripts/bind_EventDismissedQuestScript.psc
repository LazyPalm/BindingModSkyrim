Scriptname bind_EventDismissedQuestScript extends Quest  

Actor theSub
Actor theDom

bool pressedKey

event OnInit()

    if self.IsRunning()

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        bcs.DoStartEvent()
        bcs.SetEventName(self.GetName())

        GoToState("StartUpState")

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
        RegisterForModEvent("bind_EventCombatStartedInEvent", "CombatStartedInEvent")

        RegisterForSingleUpdate(5.0)

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("event dismissed quest safeword ending")
    self.Stop()
endevent

event CombatStartedInEvent(Form akTarget)
    if bind_Utility.ConfirmBox("Your party has been attacked. End this?", "I must fight", fs.GetDomTitle() + " can handle this. Leave me.")
        fs.Safeword()
    endif
endevent

event PressedAction(bool longPress)
endevent

state StartUpState
    event OnUpdate()

        if theDom.GetDistance(theSub) < 1500.0
            EventStart()
        else
            ;debug.MessageBox("dom not in area... aborting")
            bind_Utility.WriteToConsole("aborting dismissed quest - dom not in area")
            self.Stop()
        endif

    endevent
endstate

function EventStart()

    GoToState("AttentionCheckState")

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    if think.IsAiReady()
        think.UseDirectNarration(theDom, thedom.GetDisplayName() + " orders {{ player.name }} to stand at attention and not to move until dismissed.")
    else
        bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeHoldPosition())
    endif

    bind_Utility.WriteInternalMonologue("I have been ordered to stay at attention until dismissed...")

    bind_MovementQuestScript.StartSandbox(theDom, theSub)

    RegisterForSingleUpdate(5.0)

    ;debug.MessageBox("ran event start")

endfunction

state AttentionCheckState

    event PressedAction(bool longPress)
        ;debug.MessageBox("pressed action")
        if !pressedKey
            pressedKey = true
            if !pms.InAttention()
                pms.DoAttention()
            else
                pms.ResumeStanding()
            endif
            pressedKey = false
        endif
    endevent

    event OnUpdate()

        if pms.InAttention()
            ;suceess
            ;debug.MessageBox("send to waiting")
            GoToState("WaitingState")
            RegisterForSingleUpdate(Utility.RandomFloat(15.0, 45.0))
        else
            ;failed
            ;debug.MessageBox("not at attention")
            GoToState("")
            FailedToGetIntoAttention()
        endif

    endevent

endstate

state WaitingState

    event PressedAction(bool longPress)
        ;debug.MessageBox("hit action key too soon, failed")
        GoToState("")
        pms.ResumeStanding()
        FailedToStayAtAttention()
    endevent

    event OnUpdate()
        GoToState("")
        ReleaseFromAttention()
    endevent

endstate

function FailedToGetIntoAttention()
    
    fs.MarkSubBrokeRule("I failed to stand at attention")

    bind_MovementQuestScript.EndSandbox()

    SetStage(30)

    EndTheQuest()

endfunction

function FailedToStayAtAttention()

    fs.MarkSubBrokeRule("I left attention before I was instructed")

    bind_MovementQuestScript.EndSandbox()

    SetStage(30)

    EndTheQuest()

endfunction

function ReleaseFromAttention()

    ;debug.MessageBox("releasing from attention")

    bind_MovementQuestScript.EndSandbox()
    bind_MovementQuestScript.WalkTo(theDom, theSub)

    if think.IsAiReady()
        think.UseDirectNarration(theDom, thedom.GetDisplayName() + " releases {{ player.name }} from standing at attention.")
    else
        bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeDismissed())
    endif

    GoToState("ResumeStandingState")

    bind_Utility.WriteInternalMonologue("I am allowed to move again...")

endfunction

state ResumeStandingState

    event PressedAction(bool longPress)
        GoToState("")
        SetStage(20)
        pms.ResumeStanding()
        EndTheQuest()
    endevent

endstate

function EndTheQuest()

    bcs.DoEndEvent()

    self.Stop()

endfunction


bind_BondageManager property bm auto
bind_MainQuestScript property mqs auto
bind_Controller property bcs auto
bind_PoseManager property pms auto
bind_Functions property fs auto
bind_ThinkingDom property think auto