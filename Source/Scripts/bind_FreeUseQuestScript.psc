Scriptname bind_FreeUseQuestScript extends Quest  

event OnInit()

    if self.IsRunning()
    
        bind_MovementQuestScript.MakeComment(fs.GetDomRef(), fs.GetSubRef(), bind_MovementQuestScript.GetCommentDomStartingSex())

        if fs.ModInRunningState()
            bind_BoundSexQuest.Start()
        endif

        ;SetStage(20)
    
        self.Stop()

    endif

endevent

Quest property bind_BoundSexQuest auto

bind_Functions property fs auto