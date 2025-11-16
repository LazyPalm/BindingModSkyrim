Scriptname bind_PrayerShrine extends ReferenceAlias  

Event OnActivate(ObjectReference akActionRef)
    ;Debug.MessageBox("Activated by " + akActionRef)
    ; If akActionRef == fs.GetSubRef() && fs.ModInRunningState()
    ;     ;Debug.MessageBox("You activated a shrine...")
    ;     fs.SubPrayedAtShrine()
    ; EndIf

EndEvent

bind_Functions property fs auto