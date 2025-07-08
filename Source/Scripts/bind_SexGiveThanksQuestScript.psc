Scriptname bind_SexGiveThanksQuestScript extends Quest  

event OnInit()

    if self.IsRunning()
        
        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        RegisterForSingleUpdate(60.0)

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("give thanks for sex quest safeword ending")
    self.Stop()
endevent

event PressedAction(bool longPress)
endevent

event OnUpdate()

    if fs.ModInRunningState()
        EventEnd()
    else
        ;extend it (events, dhlp, etc.)
        RegisterForSingleUpdate(60.0)
    endif

endevent

function EventEnd()

    if sms.SubRequiredToThankForSex == 1 ;this should have been set to 2 from dialogue, fail if not
        fs.MarkSubBrokeRule("I forgot to give thanks for sex")
    elseif sms.SubRequiredToThankForSex == 2
        bind_Utility.WriteToConsole("sub gave thanks for sex completed - success")
    endif

    self.Stop()

endfunction

bind_MainQuestScript property mqs auto
bind_Functions property fs auto
bind_SexManager property sms auto
