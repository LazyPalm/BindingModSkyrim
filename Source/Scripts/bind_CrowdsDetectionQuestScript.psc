Scriptname bind_CrowdsDetectionQuestScript extends Quest  

event OnInit()

    if self.IsRunning()

        bind_Utility.WriteToConsole("crowd detection running")

        bool doReady = false

        if Crowd1.GetReference()
            debug.MessageBox("adding " + Crowd1.GetActorReference().GetDisplayName())
            cqs.AddCrowd(Crowd1.GetReference())
            doReady = true
        endif

        if Crowd2.GetReference()
            debug.MessageBox("adding " + Crowd2.GetActorReference().GetDisplayName())
            cqs.AddCrowd(Crowd2.GetReference())
            doReady = true
        endif

        if Crowd3.GetReference()
            debug.MessageBox("adding " + Crowd3.GetActorReference().GetDisplayName())
            cqs.AddCrowd(Crowd3.GetReference())
            doReady = true
        endif

        if Crowd4.GetReference()
            debug.MessageBox("adding " + Crowd4.GetActorReference().GetDisplayName())
            cqs.AddCrowd(Crowd4.GetReference())
            doReady = true
        endif

        if Crowd5.GetReference()
            debug.MessageBox("adding " + Crowd5.GetActorReference().GetDisplayName())
            cqs.AddCrowd(Crowd5.GetReference())
            doReady = true
        endif

        if Crowd6.GetReference()
            debug.MessageBox("adding " + Crowd6.GetActorReference().GetDisplayName())
            cqs.AddCrowd(Crowd6.GetReference())
            doReady = true
        endif

        if doReady
            cqs.CrowdReady()
        endif

        ;cqs.SetCrowd(Crowd1.GetReference(), Crowd2.GetReference(), Crowd3.GetReference(), Crowd4.GetReference(), Crowd5.GetReference(), Crowd6.GetReference())

        ;RegisterForSingleUpdate(5.0)

        self.Stop()

    endif

endEvent

ReferenceAlias property Crowd1 auto
ReferenceAlias property Crowd2 auto
ReferenceAlias property Crowd3 auto
ReferenceAlias property Crowd4 auto
ReferenceAlias property Crowd5 auto
ReferenceAlias property Crowd6 auto

bind_CrowdsQuestScript property cqs auto