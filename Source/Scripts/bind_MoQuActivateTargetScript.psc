Scriptname bind_MoQuActivateTargetScript extends ReferenceAlias  

Event OnActivate(ObjectReference akActionRef)
    ;Debug.MessageBox("Activated by " + akActionRef)



    If akActionRef == TheDom.GetReference()
        ;Debug.MessageBox("Dom closed the door")
        ;main.SubPrayedAtShrine()

    EndIf

EndEvent

ReferenceAlias property TheDom auto