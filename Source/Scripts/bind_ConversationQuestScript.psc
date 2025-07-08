Scriptname bind_ConversationQuestScript extends Quest  

bool playingScene
bool standingAgain

event OnInit()

    if self.IsRunning()

        playingScene = true
        standingAgain = false

        bcs.DoStartEvent()
        bcs.SetEventName(self.GetName())

        RegisterForModEvent("bind_ConversationSceneCompleted", "SceneCompleted")
        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")

        bind_MovementQuestScript.WalkTo(TheDom.GetReference() as Actor, TheSub.GetReference() as Actor, 150.0, 15)

        DomToNpcScene.Start()

    endif

endEvent

;TODO - capture tab key and end quest on dialogue closing?

event PressedAction(bool longPress)
    
    if longPress
        bind_Utility.WriteToConsole("forcing conversation quest to end")
        EndQuest()
    endif

    if playingScene
        string actorName = (NearestNpcRef.GetReference() as Actor).GetActorBase().GetName()
        bind_Utility.WriteInternalMonologue("There is a chat going on with " + actorName + "...")
    else
        if !standingAgain
            bind_Utility.WriteToConsole("triggering resume standing")
            EndQuest()
            standingAgain = true
        endif
    endif

endevent

event SceneCompleted()

    bind_Utility.WriteToConsole("bind_ConversationSceneCompleted event fired")

    playingScene = false

    (NearestNpcRef.GetReference() as Actor).Activate(TheSub.GetReference() as Actor)

endevent

function EndQuest()

    pms.ResumeStanding()
    bind_Utility.EnablePlayer()

    bcs.DoEndEvent()

    self.Stop()

endfunction

ReferenceAlias property TheDom auto
ReferenceAlias property TheSub auto
ReferenceAlias property NearestNpcRef auto

Scene property DomToNpcScene auto

bind_Controller property bcs auto
bind_PoseManager property pms auto