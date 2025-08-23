Scriptname bind_ActionButtonMagicEffectScript extends ActiveMagicEffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
    bind_Utility.WriteToConsole("action button spell clicked")

    ;bam.ShowActionMenu()

    int currentState = bcs.GetCurrentModState()

    if currentState == bind_Controller.GetModStateRunning()
        bind_Controller.SendActionOpenMenuEvent()
    elseif currentState == bind_Controller.GetModStateEvent()
        bind_Controller.SendEventPressedActionEvent(false)
    endif

    ; int handle = ModEvent.Create("bind_ActionOpenMenuEvent")
    ; if handle
    ;     ModEvent.Send(handle)
    ; endif

EndEvent

bind_ActionMenu property bam auto
bind_Controller property bcs auto