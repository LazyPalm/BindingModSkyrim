Scriptname bind_EventGagForPunQuestScript extends Quest  

Actor theSub
Actor theDom

bind_ThinkingDom think

event OnInit()

    if self.IsRunning()
        
        GoToState("")

        think = bind_ThinkingDom.GetThinkingDom()

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
        RegisterForModEvent("bind_EventCombatStartedInEvent", "CombatStartedInEvent")

        EventStart()

    endif

endevent

event SafewordEvent()
    debug.MessageBox("Ending gagged for punishment quest")
    bind_Utility.WriteToConsole("gagged for punishment quest safeword ending")
    self.Stop()
endevent

event CombatStartedInEvent(Form akTarget)
    if bind_Utility.ConfirmBox("Your party has been attacked. End this?", "I must fight", fs.GetDomTitle() + " can handle this. Leave me.")
        fs.Safeword()
    endif
endevent

event PressedAction(bool longPress)
    bind_Utility.WriteInternalMonologue("There is nothing else for me to do...")
endevent

state TimeToRemoveGag

    event OnUpdate()

        EventEnd()

    endevent

endstate

function EventStart()

    theSub = fs.GetSubRef()
    theDom = fs.GetDomRef()

    SetObjectiveDisplayed(10, true)

    bcs.DoStartEvent()
    bcs.SetEventName(self.GetName())

    bind_Utility.DisablePlayer()

    bind_MovementQuestScript.WalkTo(theDom, theSub)

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    bind_MovementQuestScript.StartWorking(theDom)

    fs.EventGetSubReady(theSub, theDom, "event_gagged_for_punishment")

    ;bm.AddItem(theSub, bm.BONDAGE_TYPE_GAG())
    ;bind_Utility.DoSleep(3.0)

    bind_MovementQuestScript.StopWorking(theDom)

    if think.IsAiReady()
        string narrationString = theDom.GetDisplayName() + " is gagging {{ player.name }} for not kneeling before speaking."
        think.UseDirectNarration(theDom, narrationString)
    else
        bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeStartGagSub())
    endif

    bind_Utility.EnablePlayer()

    GotoState("TimeToRemoveGag")
    RegisterForSingleUpdate(120.0)

endfunction

function EventEnd()

    bind_Utility.WriteNotification("Time to remove the gag...", bind_Utility.TextColorBlue())

    bind_MovementQuestScript.WalkTo(theDom, theSub)

    bind_Utility.DisablePlayer()

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    bind_MovementQuestScript.StartWorking(theDom)

    ; bm.RemoveItem(theSub, bm.BONDAGE_TYPE_GAG())
    ; bind_Utility.DoSleep(3.0)

    fs.EventCleanUpSub(theSub, theDom, true)

    bind_MovementQuestScript.StopWorking(theDom)

    if think.IsAiReady()
        string narrationString = theDom.GetDisplayName() + " removes the gag and hopes that {{ player.name }} learned not to speak without kneeling."
        think.UseDirectNarration(theDom, narrationString)
    else
        bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeEndGagSub())
    endif

    bind_Utility.EnablePlayer()

    bcs.DoEndEvent()

    SetObjectiveCompleted(10, true)
    SetStage(20)

    self.Stop()

endfunction

bind_BondageManager property bm auto
bind_MainQuestScript property mqs auto
bind_Controller property bcs auto
bind_Functions property fs auto