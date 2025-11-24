Scriptname bindc_Slavery extends Quest  

Actor dom
Actor sub1
Actor sub2
Actor sub3

event OnInit()

    if self.IsRunning()
        Startup()
        

    endif

endevent

function Startup()
    if DomRef.GetActorReference() != none
        dom = DomRef.GetActorReference()
    endif
    if Sub1Ref.GetActorReference() != none
        sub1 = Sub1Ref.GetActorReference()
    endif
    if Sub2Ref.GetActorReference() != none
        sub2 = Sub2Ref.GetActorReference()
    endif
    if Sub3Ref.GetActorReference() != none
        sub3 = Sub3Ref.GetActorReference()
    endif
endfunction

function ProcessLocationChange(Location akOldLoc, Location akNewLoc)

endfunction

ReferenceAlias property DomRef Auto
ReferenceAlias property Sub1Ref Auto
ReferenceAlias property Sub2Ref Auto
ReferenceAlias property Sub3Ref Auto
