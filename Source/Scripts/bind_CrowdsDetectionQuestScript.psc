Scriptname bind_CrowdsDetectionQuestScript extends Quest  

event OnInit()

    if self.IsRunning()

        bind_Utility.WriteToConsole("crowd detection running")

        cqs.SetCrowd(Crowd1.GetReference(), Crowd2.GetReference(), Crowd3.GetReference(), Crowd4.GetReference(), Crowd5.GetReference(), Crowd6.GetReference())

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