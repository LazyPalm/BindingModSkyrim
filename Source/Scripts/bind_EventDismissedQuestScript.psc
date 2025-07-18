Scriptname bind_EventDismissedQuestScript extends Quest  

Actor theSub
Actor theDom

bool pressedKey

event OnInit()

    if self.IsRunning()

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        GoToState("StartUpState")

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        RegisterForSingleUpdate(5.0)

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("event dismissed quest safeword ending")
    self.Stop()
endevent

event PressedAction(bool longPress)
endevent

state StartUpState
    event OnUpdate()

        if theDom.GetDistance(theSub) < 1500.0
            EventStart()
        else
            bind_Utility.WriteToConsole("aborting dismissed quest - dom not in area")
            self.Stop()
        endif

    endevent
endstate

function EventStart()

    bcs.DoStartEvent()
    bcs.SetEventName(self.GetName())

    GoToState("AttentionCheckState")

    bind_MovementQuestScript.FaceTarget(theDom, theSub)
    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeHoldPosition())

    bind_Utility.WriteInternalMonologue("I have been ordered to stay in attention until dismissed...")

    bind_MovementQuestScript.StartSandbox(theDom, theSub)

    RegisterForSingleUpdate(5.0)

endfunction

state AttentionCheckState

    event PressedAction(bool longPress)
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
            GoToState("WaitingState")
            RegisterForSingleUpdate(Utility.RandomFloat(15.0, 45.0))
        else
            ;failed
            GoToState("")
            FailedToGetIntoAttention()
        endif

    endevent

endstate

state WaitingState

    event PressedAction(bool longPress)
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

    bind_MovementQuestScript.EndSandbox()
    bind_MovementQuestScript.WalkTo(theDom, theSub)
    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeDismissed())

    GoToState("ResumeStandingState")

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