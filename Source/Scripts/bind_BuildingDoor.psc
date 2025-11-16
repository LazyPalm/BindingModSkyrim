Scriptname bind_BuildingDoor extends ReferenceAlias  

Event OnActivate(ObjectReference akActionRef)
    
    ; ;Debug.MessageBox("Activated by " + akActionRef + " locked: " + self.GetReference().IsLocked())
        
    ; If akActionRef == fs.GetSubRef()

    ;     fs.CalculateDistanceAtAction()
    
    ;     ; if main.DomDoorDiscovery == 1

    ;     ;     debug.MessageBox(self.GetReference().GetFactionOwner())

    ;     ; endif
    
    
    ;     ;Debug.MessageBox("You used a door...")
    ;     fs.SubUsedDoor(self.GetReference())
    ; EndIf

EndEvent

bind_Functions property fs auto