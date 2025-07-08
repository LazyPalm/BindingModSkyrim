Scriptname bind_SoulsFromBonesQuestScript extends Quest  

Actor theSub
Actor theDom

ObjectReference obj

bool showWantsToTalk
bool pressedButton
;bool isTalking

event OnInit()

    if self.IsRunning()
        
        GoToState("")

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
        RegisterForModEvent("bind_CycleEvent", "CycleEvent")
        RegisterForModEvent("AnimationEnd", "OnSexEndEvent")

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        ;debug.MessageBox("in souls from bones")

        SetObjectiveDisplayed(10, true)

        GoToState("WantsToTalk")
        RegisterForSingleUpdate(1.0)

        bcs.DoStartEvent()
        bcs.SetEventName(self.GetName())

        ;EventStart()

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("souls from bones quest safeword ending")
    self.Stop()
endevent

event PressedAction(bool longPress)
endevent

event CycleEvent(int cycles, int modState)
endevent

; function SetTalking(bool t)
;     isTalking = t
; endfunction

state WantsToTalk

    Event OnUpdate()			

        if !UI.IsMenuOpen("Dialogue Menu")
            bind_Utility.WriteNotification(fs.GetDomTitle() + " wants to speak with you...", bind_Utility.TextColorRed())
        endif

        ; if !isTalking
        ;     bind_Utility.WriteNotification(mqs.GetDomTitle() + " wants to talk...", bind_Utility.TextColorRed())
        ; endif

        if theSub.GetDistance(TheDeadDragon.GetReference()) > 1500.0
            
            UnregisterForUpdate()
            fs.MarkSubBrokeRule("I was supposed to talk to " + fs.GetDomTitle())
            FailEvent()

        else

            RegisterForSingleUpdate(15.0)

        endif

    EndEvent

    event PressedAction(bool longPress)
        
        if !pressedButton 
            pressedButton = true
            bind_Controller.SendActionKneelTriggerEvent()
            bind_Utility.DoSleep(2.0)
            pressedButton = false
        endif

    endevent

endstate

function StartEvent()

    GotoState("")

    bind_PoseManager.StandFromKneeling(theSub)

    bind_Utility.DisablePlayer()

    if theSub.GetDistance(TheDeadDragon.GetReference()) > 1000.0

    endif

    bind_MovementQuestScript.PlayDoWork(theDom)
    bind_Utility.DoSleep(2.0)
    float z = theDom.GetAngleZ()
    obj = theDom.PlaceAtMe(bind_SexFurniture.GetAt(Utility.RandomInt(0, bind_SexFurniture.GetSize() - 1)), 1, true, true)
    obj.MoveTo(theDom, 120.0 * Math.Sin(theDom.GetAngleZ()), 120.0 * Math.Cos(theDom.GetAngleZ()), 0)
    obj.SetAngle(0.0, 0.0, z)
    obj.Enable()
    obj.SetActorOwner(theSub.GetActorBase())

    if obj.HasKeywordString("zadc_FurnitureDevice")
        (obj as zadcFurnitureScript).SendDeviceModEvents = true
        (obj as zadcFurnitureScript).ScriptedDevice = true
    endif

    fs.EventGetSubReady(theSub, theDom, playAnimations = true, stripClothing = true, addGag = true, freeWrists = true, removeAll = true)

    ;TODO: add a soulstone plug or two??

    bind_MovementQuestScript.FaceTarget(theDom, theSub)
    bind_MovementQuestScript.PlayDoWork(theDom)

    if zclib.LockActor(theSub, obj)
        bind_Utility.DoSleep(2.0)
    endif

    zclib.PlaySexScene(theSub, theDom)

    PlayEffects()

endfunction

event OnSexEndEvent(string eventName, string argString, float argNum, form sender)

    ;debug.MessageBox("sex finished...")

    ;PlayEffects()

    DragonPowerAbsorbFXS.Stop(theSub)

    StopEvent()

endevent

function PlayEffects()

    bind_Utility.DoSleep(10.0)

    DragonAbsorbEffect.Play(TheDeadDragon.GetActorReference(), 8, theSub)
    DragonAbsorbManEffect.Play(theSub, 8, TheDeadDragon.GetActorReference())

    NPCDragonDeathSequenceWind.play(TheDeadDragon.GetActorReference()) 
    NPCDragonDeathSequenceExplosion.play(TheDeadDragon.GetActorReference()) 

    bind_Utility.DoSleep(5.0)

    DragonAbsorbEffect.Stop(TheDeadDragon.GetActorReference())
    DragonAbsorbManEffect.Stop(theSub)

    bind_Utility.DoSleep(2.0)

    DragonPowerAbsorbFXS.Play(theSub)

endfunction

function StopEvent()

    bind_MovementQuestScript.WalkTo(theDom, theSub)

    bind_MovementQuestScript.PlayDoWork(theDom)

    zclib.UnlockActor(theSub)

    bind_Utility.DisablePlayer()

    bind_Utility.DoSleep(1.0)

    fs.EventCleanUpSub(theSub, theDom, true)

    bind_Utility.EnablePlayer()

    obj.Delete()
    obj = none

    int roll = Utility.RandomInt(1, 3)
    bind_Utility.WriteToConsole("roll: " + roll)
    if  roll == 3
        bind_Utility.WriteInternalMonologue("We found a deeper part of the dragon's soul...")
        theSub.ModActorValue("DragonSouls", 1)
    else
        bind_Utility.WriteInternalMonologue("The dragon's soul has been captured...")
    endif

    SetObjectiveCompleted(10)
    SetObjectiveDisplayed(10, false)

    theSub.AddToFaction(bind_DragonSlayerFaction)
    TheDeadDragon.GetActorReference().AddToFaction(bind_DragonSoulCapturedFaction)

    SetStage(20)

    bcs.DoEndEvent()

    self.Stop()

endfunction

function FailEvent()

    SetObjectiveDisplayed(10, false)

    SetStage(30)

    bcs.DoEndEvent()

    self.Stop()

endfunction

zadcLibs property zclib auto

bind_MainQuestScript property mqs auto
bind_BondageManager property bms auto
bind_Controller property bcs auto
bind_GearManager property gms auto
bind_Functions property fs auto

Faction property bind_DragonSlayerFaction auto
Faction property bind_DragonSoulCapturedFaction auto

ReferenceAlias property TheDeadDragon auto

Formlist property bind_SexFurniture auto

EffectShader Property DragonPowerAbsorbFXS Auto

VisualEffect Property DragonAbsorbEffect Auto
VisualEffect Property DragonAbsorbManEffect Auto

Sound property NPCDragonDeathSequenceFireLPM auto
Sound property NPCDragonDeathSequenceWind auto
Sound property NPCDragonDeathSequenceExplosion auto
Sound property NPCDragonDeathSequenceSmolderLPM auto
