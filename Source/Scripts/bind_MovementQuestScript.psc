Scriptname bind_MovementQuestScript extends Quest  

event OnInit()

    if self.IsRunning()
        RegisterForModEvent("bind_SceneMakeCommentEnd", "MadeCommentEvent")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
        eventRegistered = true
    endif

endevent

bool commentCompleted = false
bool eventRegistered = false

event SafewordEvent()
    bind_Utility.WriteToConsole("movement quest safeword refresh")

    TheTarget.Clear()
    MoveToTarget.Clear()
    Working.Clear()
    FollowTargetA.Clear()
    FollowTargetB.Clear()
    Sleeping.Clear()
    Sandboxing.Clear()
    TheBed.Clear()
    SandboxNearThis.Clear()
    CommentSource.Clear()
    CommentTarget.Clear()
    GettingWhipped.Clear()
    DoReset.Clear()
    HogtiedActor.Clear()
    ActivateTarget.Clear()
    ActivateActor.Clear()

    ;self.Stop()
endevent

event MadeCommentEvent()
    ;debug.MessageBox("comment completed...")
    commentCompleted = true
endevent

function SetCommentType(int type)

    if !eventRegistered
        RegisterForModEvent("bind_SceneMakeCommentEnd", "MadeCommentEvent")
        eventRegistered = true
    endif

    bind_GlobalCommentType.SetValue(type)

endfunction

int function GetCommentType()
    return bind_GlobalCommentType.GetValue() as int
endfunction

bool function GetCommentCompleted()
    return commentCompleted
endfunction

function ResetCommentCompleted()
    commentCompleted = false
endfunction

int function GetCommentTypeFollowMe() global
    return 100
endfunction

int function GetCommentTypeHoldPosition() global
    return 101
endfunction

int function GetCommentTypeDismissed() global
    return 102
endfunction

int function GetCommentTypeStripCommand() global
    return 110
endfunction

int function GetCommentTypeGetDressedCommand() global
    return 111
endfunction

int function GetCommentTypePackUpCamp() global
    return 200
endfunction

int function GetCommentTypeStartGagSub() global
    return 300
endfunction

int function GetCommentTypeEndGagSub() global
    return 400
endfunction

int function GetCommentTypeSexyBondagePet() global
    return 500
endfunction

int function GetCommentTypeUntyingSub() global
    return 510
endfunction

int function GetCommentTypeBodyComment() global
    return 511
endfunction

int function GetCommentTypeRefuseToUntie() global
    return 520
endfunction

int function GetCommentRulesCheck() global
    return 600
endfunction

int function GetCommentDisappointmentComment() global
    return 610
endfunction

int function GetCommentTooDirty() global
    return 615
endfunction

int function GetCommentDomStartingSex() global
    return 700
endfunction

int function GetCommentDomOrderToMasturbate() global
    return 701
endfunction

int function GetCommentTypePoseOrderKneel() global
    return 800
endfunction

int function GetCommentTypePoseOrderInspection() global
    return 805
endfunction

int function GetCommentTypePoseOrderAssOut() global
    return 810
endfunction

int function GetCommentTypePoseOrderShowSex() global
    return 815
endfunction

int function GetCommentTypePoseOrderAttention() global
    return 820
endfunction

int function GetCommentTypePoseOrderReset() global
    return 825
endfunction

function MakeComment(Actor source, Actor target, int commentType) global

    bind_Utility.WriteToConsole("MakeComment source: " + source.GetDisplayName() + " target: " + target.GetDisplayName() + " commentType " + commentType)

    bind_MainQuestScript mq = Quest.GetQuest("bind_MainQuest") as bind_MainQuestScript
    bind_ThinkingDom td = Quest.GetQuest("bind_MainQuest") as bind_ThinkingDom
    if td.IsAiReady()

        string prompt = ""
        if commentType == GetCommentTypePackUpCamp()
            prompt = "Order { player.name }, to clean up the area used for camping."

        elseif commentType == GetCommentTypeUntyingSub()
            prompt = "Since you like to see them tied up, tell { player.name } how dispointed you are that it is time to untie them."

        endif

        bind_Utility.WriteToConsole("In AI comment - prompt: " + prompt)

        if prompt != ""
            td.MakeAiComment(source, prompt)
        endif

    else

        bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript

        bm.CommentSource.ForceRefTo(source)
        bm.CommentTarget.ForceRefTo(target)

        bm.ResetCommentCompleted()
        bm.SetCommentType(commentType)

        bm.bind_SceneMakeComment.Start()

        int i = 0
        while !bm.GetCommentCompleted() && i < 30
            bind_Utility.DoSleep(1.0)
            i += 1
        endwhile

        bind_Utility.WriteToConsole("makecommment completed: " + commentType)

        bm.CommentSource.Clear()
        bm.CommentTarget.Clear()

    endif

endfunction

Function PlayKnockedDown(Actor a, bool isBound = false) global
    If isBound
        Debug.SendAnimationEvent(a, "ZapWriPose14")
    Else
        int result = Utility.RandomInt(1, 3)		
        If result == 1
            Debug.SendAnimationEvent(a, "IdleWounded_01")
        ElseIf result == 2
            Debug.SendAnimationEvent(a, "IdleWounded_02")
        ElseIf result == 3
            Debug.SendAnimationEvent(a, "IdleWounded_03")
        EndIf
    EndIf
endfunction

Function PlayDressUndress(Actor a) global
    int Gender = a.GetLeveledActorBase().GetSex()
    Debug.SendAnimationEvent(a, "Arrok_Undress_G" + Gender)
EndFunction

function FaceTwoActors(Actor a1, Actor a2) global
    float zOffset = a1.GetHeadingAngle(a2)
    a1.SetAngle(a1.GetAngleX(), a1.GetAngleY(), a1.GetAngleZ() + zOffset)
    zOffset = a2.GetHeadingAngle(a1)
    a2.SetAngle(a2.GetAngleX(), a2.GetAngleY(), a2.GetAngleZ() + zOffset)
endfunction

function FaceTarget(Actor a, ObjectReference target) global
    float zOffset = a.GetHeadingAngle(target)
    a.SetAngle(a.GetAngleX(), a.GetAngleY(), a.GetAngleZ() + zOffset)
endfunction

function FaceAwayFromTarget(Actor a, ObjectReference target) global
    float zOffset = a.GetHeadingAngle(target) + 180
    a.SetAngle(a.GetAngleX(), a.GetAngleY(), a.GetAngleZ() + zOffset)
endfunction

function PlayKneel(Actor a) global
    Debug.SendAnimationEvent(a, "ZapWriPose06")
endfunction

function PlaySitOnGround(Actor a) global
    Debug.SendAnimationEvent(a, "IdleSitCrossLeggedEnter")
endfunction

function PlayDoWork(Actor a, float seconds = 3.0) global
    Debug.SendAnimationEvent(a, "IdleLockPick")
    bind_Utility.DoSleep(seconds)
endfunction

function PlayReset(Actor a) global
    Debug.SendAnimationEvent(a, "IdleForceDefaultState")
endfunction

function PlayTieUntie(Actor a, Actor target, float seconds = 3.0) global
    float zOffset = a.GetHeadingAngle(target)
    a.SetAngle(a.GetAngleX(), a.GetAngleY(), a.GetAngleZ() + zOffset)
    Debug.SendAnimationEvent(a, "IdleLockPick")
    bind_Utility.DoSleep(seconds)
endfunction

function StartSandbox(Actor a, ObjectReference sandboxNear) global
    bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript
    bm.SandboxNearThis.ForceRefTo(sandboxNear)
    bm.Sandboxing.ForceRefTo(a)
    a.EvaluatePackage()
endfunction

function EndSandbox() global
    bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript
    bm.Sandboxing.Clear()
    bm.SandboxNearThis.Clear()
endfunction

function StartSleep(Actor a, ObjectReference bed) global
    bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript
    bm.TheBed.ForceRefTo(bed)
    bm.Sleeping.ForceRefTo(a)
    a.EvaluatePackage()
endfunction

function EndSleep() global
    bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript
    bm.Sleeping.Clear()
    bm.TheBed.Clear()
endfunction

function StartHogtied(Actor a) global
    bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript
    bm.HogtiedActor.ForceRefTo(a)
    a.EvaluatePackage()
endfunction

function EndHogtied(Actor a) global
    bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript
    bm.HogtiedActor.Clear()
    bm.DoReset.ForceRefTo(a)
    a.EvaluatePackage()
    bm.DoReset.Clear()
endfunction

function StartWorking(Actor a) global
    bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript
    bm.Working.ForceRefTo(a)
    a.EvaluatePackage()
endfunction

function StopWorking(Actor a) global
    bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript
    bm.Working.Clear()
    bm.DoReset.ForceRefTo(a)
    a.EvaluatePackage()
    bm.DoReset.Clear()
endfunction

function StartGetWhippedPosition(Actor a) global
    bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript
    bm.GettingWhipped.ForceRefTo(a)
    a.EvaluatePackage()
endfunction

function EndGetWhippedPosition(Actor a) global
    bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript
    bm.GettingWhipped.Clear()
    bm.DoReset.ForceRefTo(a)
    a.EvaluatePackage()
    bm.DoReset.Clear()
endfunction

function Follow(Actor a, Actor targetToFollow) global
    bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript
    bm.FollowTargetA.ForceRefTo(targetToFollow)
    bm.FollowTargetB.ForceRefTo(a)
    a.EvaluatePackage()
endfunction

function StopFollowing() global
    bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript
    bm.FollowTargetA.Clear()
    bm.FollowTargetB.Clear()
endfunction

function ActivateTarget(Actor a, ObjectReference target) global

    bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript
    bm.ActivateActor.ForceRefTo(a)
    bm.ActivateTarget.ForceRefTo(target)
    a.EvaluatePackage()

    ;do more things!!!

endfunction

function WalkTo(Actor a, ObjectReference target, float targetDistance = 128.0, int maxSeconds = 30) global

    if a.GetDistance(target) <= targetDistance
        bind_Utility.WriteToConsole("walk to canceled due to distance")
        return
    endif

    bind_MovementQuestScript bm = Quest.GetQuest("bind_MovementQuest") as bind_MovementQuestScript

    bm.MoveToTarget.ForceRefTo(a)
    bm.TheTarget.ForceRefTo(target)
    a.EvaluatePackage()

    int maxTics = maxSeconds * 2

    ;TODO - maybe change this to a loop that keeps moving as long as olddistance != newdistance, so if the actor
    ;gets stuck it will end the loop, or end on arrival vs. time based safety

    int i = 0
    float lastDistance = 0.0
    int ticksStuckAtThisDistance = 0
    while (a.GetDistance(target) > targetDistance) && (i <= maxTics)
        float distanceFromTarget = a.GetDistance(target)
        if lastDistance == 0.0
            lastDistance = distanceFromTarget
        endif
        bind_Utility.DoSleep(0.5)
        bind_Utility.WriteToConsole("tdist: " + targetDistance + " maxtics: " + maxTics + " tic: " + i + " distance: " + distanceFromTarget)
        if lastDistance - distanceFromTarget < 0.1
            ticksStuckAtThisDistance += 1
            if ticksStuckAtThisDistance == 4
                bind_Utility.WriteToConsole("stuck teleporting")
                i = maxTics ;break the loop
            endif
        else
            lastDistance = distanceFromTarget
            ticksStuckAtThisDistance = 0
        endif
        i += 1
    endwhile

    if a.GetDistance(target) > targetDistance
        a.MoveTo(target)
    endif

    bm.MoveToTarget.Clear()
    bm.TheTarget.Clear()

endfunction

GlobalVariable property bind_GlobalCommentType auto

Scene property bind_SceneMakeComment auto

ReferenceAlias property TheTarget auto
ReferenceAlias property MoveToTarget auto
ReferenceAlias property Working auto
ReferenceAlias property FollowTargetA auto
ReferenceAlias property FollowTargetB auto
ReferenceAlias property Sleeping auto
ReferenceAlias property Sandboxing auto
ReferenceAlias property TheBed auto
ReferenceAlias property SandboxNearThis auto
ReferenceAlias property CommentSource auto
ReferenceAlias property CommentTarget auto
ReferenceAlias property GettingWhipped auto
ReferenceAlias property DoReset auto
ReferenceAlias property HogtiedActor auto
ReferenceAlias property ActivateTarget auto
ReferenceAlias property ActivateActor auto