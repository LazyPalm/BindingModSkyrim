Scriptname bind_Movement extends Quest  

Actor actorSub
bool processingEvent = false
bool startedMovementQuest = false

;TODO - move all of this long press handling to bind_action menu or bind_posemanager and retire this script
;most of what was planned ended up in the bind_movementquest

event OnInit()

    if self.IsRunning()

        RegisterForModEvent("bind_ActionKneelTriggerEvent", "ProcessKneelTrigger")

        actorSub = Game.GetPlayer()

    endif

endEvent

event ProcessKneelTrigger()

    ;debug.MessageBox("triggering kneeling...")

    if !processingEvent
        processingEvent = true
        if pms.IsInPose()
            pms.ResumeStanding()
            bind_Utility.EnablePlayer()
        elseif actorSub.IsOnMount()
            ;don't do anything if riding
        else
            pms.DoHighKneel()
            bind_Utility.DisablePlayer()
        endif
        ; if !actorSub.IsInFaction(bind_KneelingFaction)
        ;     bind_Utility.DisablePlayer()
        ;     actorSub.AddToFaction(bind_KneelingFaction)
        ;     bind_KneelingQuest.Start()
        ; else
        ;     bind_KneelingQuest.Stop()
        ;     actorSub.RemoveFromFaction(bind_KneelingFaction)
        ;     PlayDefault(actorSub)
        ;     bind_Utility.EnablePlayer()
        ; endif
        ; actorSub.EvaluatePackage()
        processingEvent = false
    endif

endevent

function PlayDefault(Actor a)
    Debug.SendAnimationEvent(a, "IdleForceDefaultState")
endfunction

Faction property bind_KneelingFaction auto

Quest property bind_KneelingQuest auto

bind_PoseManager property pms auto
