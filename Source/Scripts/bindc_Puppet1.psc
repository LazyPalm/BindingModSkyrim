Scriptname bindc_Puppet1 extends Quest  

ReferenceAlias property MoveActorToTarget auto
ReferenceAlias property MoveActorToBed auto
ReferenceAlias property HoldPosition auto
ReferenceAlias property DoSit auto
ReferenceAlias property DoTie auto
ReferenceAlias property TheTarget auto
ReferenceAlias property TheBed auto

bool breakLoop

function MoveToTarget(Actor akActor, ObjectReference target, bool runUntilArrival = false)
    Clear(akActor, false)
    TheTarget.ForceRefTo(target)
    MoveActorToTarget.ForceRefTo(akActor)
    akActor.EvaluatePackage()
    if runUntilArrival
        breakLoop = false
        int counter = 0
        float d = akActor.GetDistance(target)
        bindc_Util.WriteInformation("starting distance: " + d)
        while (counter < 30 && d > 200.0) || breakLoop
            d = akActor.GetDistance(target)
            bindc_Util.WriteInformation("counter: " + counter + " distance: " + d)
            bindc_Util.DoSleep(0.5)
            counter += 1
        endwhile
    endif
endfunction

function MoveToBed(Actor akActor, ObjectReference target)
    Clear(akActor, false)
    TheBed.ForceRefTo(target)
    MoveActorToBed.ForceRefTo(akActor)
    akActor.EvaluatePackage()
endfunction

function DoNotMove(Actor akActor)
    Clear(akActor, false)
    HoldPosition.ForceRefTo(akActor)
    akActor.EvaluatePackage()
endfunction

function Clear(Actor akActor, bool runEvaluate = true)
    breakLoop = true
    if MoveActorToTarget.GetReference() != none
        MoveActorToTarget.Clear()
    endif
    if MoveActorToBed.GetReference() != none
        MoveActorToBed.Clear()
    endif
    if HoldPosition.GetReference() != none
        HoldPosition.Clear()
    endif
    if TheBed.GetReference() != none
        TheBed.Clear()
    endif
    if TheTarget.GetReference() != none
        TheTarget.Clear()
    endif
    if runEvaluate
        akActor.EvaluatePackage()
    endif
endfunction