Scriptname bind_ActionButtonMagicEffectScript extends ActiveMagicEffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
    bind_Utility.WriteToConsole("action button spell clicked")

    bam.ShowActionMenu()

    ; int handle = ModEvent.Create("bind_ActionOpenMenuEvent")
    ; if handle
    ;     ModEvent.Send(handle)
    ; endif

EndEvent

bind_ActionMenu property bam auto