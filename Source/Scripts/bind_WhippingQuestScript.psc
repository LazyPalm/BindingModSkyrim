Scriptname bind_WhippingQuestScript extends Quest  

Actor theSub
Actor theDom

bool menuActive = false

int dirtAndBloodChance = 0

int whippingFramework = 0

event OnInit()

    if self.IsRunning()
        
        GoToState("StartPhase")

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("ZapSlaveActionDone", "OnSlaveActionDone")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        menuActive = false

        StartTheQuest()

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("whipping quest safeword ending")

    ;if using ZAP
    WhipScene.Stop()

    self.Stop()
endevent

Event OnSlaveActionDone(String asType, String asMessage, Form akMaster, Int aiSceneIndex)

    WhippingCompleted()

EndEvent

event PressedAction(bool longPress)
endevent

state StartPhase
    event PressedAction(bool longPress)

        bind_Utility.WriteInternalMonologue("I must take this...")

    endevent
endstate

state WhippingCompleted
    event PressedAction(bool longPress)

        if !menuActive
            StandupMenu()
        endif

    endevent
endstate

function StartTheQuest()

    dirtAndBloodChance = 0
    ; if Game.GetModByName("Dirt and Blood - Dynamic Visuals.esp") != 255
    ;     Dirty_Quest_MCM dirty = Quest.GetQuest("Dirty_QuesMCM") as Dirty_Quest_MCM
    ;     dirtAndBloodChance = dirty.Dirty_PlayerHitBloodyChance.GetValue() as int
    ;     bind_Utility.WriteToConsole("storing dirtAndBloodChance: " + dirtAndBloodChance)
    ;     dirty.Dirty_PlayerHitBloodyChance.SetValue(-100) ;d&b hit chance is 1-100 roll
    ; endif

    theSub = fs.GetSubRef()
    theDom = fs.GetDomRef()

    bcs.DoStartEvent()
    bcs.SetEventName(self.GetName())

    bind_Utility.DisablePlayer()

    bind_MovementQuestScript.WalkTo(theDom, theSub)

    ;bind_MovementQuestScript.StartWorking(theDom)

    fs.EventGetSubReady(theSub, theDom, playAnimations = true, stripClothing = true, addGag = true, freeWrists = true, removeAll = false)

    ;mqs.EvHelpStripAndRemoveBondage(true, mqs.GetEventHandleBondageFreeWristsAddGag(), false, false) ;TODO - build a better version of this?

    ;bind_MovementQuestScript.StopWorking(theDom)

    bind_Utility.DoSleep(2.0)

    if mqs.SoftCheckPama == 1 && mqs.EnableModPama == 1
        whippingFramework = 2
        if bind_PamaHelper.CheckValid()
            bind_PamaHelper.WhipActor(theSub, theDom)
            GotoState("PamaWhippingFirstStage")
            RegisterForSingleUpdate(Utility.RandomFloat(30.0, 50.0))
        endif
    else
        whippingFramework = 1
        bind_MovementQuestScript.StartGetWhippedPosition(theSub)
        bind_Utility.DoSleep(2.0)
        zbfSlaveActions slaveActions = zbfSlaveActions.GetApi()
        slaveActions.WhipPlayer(theDom, "", 30.0, 50.0, "")
    endif

endfunction

state PamaWhippingFirstStage

    event OnUpdate()

        GotoState("PamaWhippingSecondStage")

    endevent

    event PressedAction(bool longPress)

        bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is not listening to my pleas to stop...")

    endevent

endstate

state PamaWhippingSecondStage

    event PressedAction(bool longPress)

        if !menuActive
            PamaMenu()
        endif

    endevent

endstate

function WhippingCompleted()

    if whippingFramework == 2
        if bind_PamaHelper.CheckValid()
            bind_PamaHelper.EndWhipActor(theSub)
            bind_Utility.DoSleep()
        endif
    endif

    bind_MovementQuestScript.EndGetWhippedPosition(theSub)

    ;bind_Utility.DoSleep(1.0)

    bind_Utility.DoSleep()

    bind_MovementQuestScript.PlayReset(theSub)

    bind_MovementQuestScript.PlayKnockedDown(theSub, false)

    bind_Utility.WriteNotification("Press Action key to stand up...", bind_Utility.TextColorBlue())

    GotoState("WhippingCompleted")

endfunction

function EndTheQuest()

    GotoState("")

    bind_MovementQuestScript.PlayReset(theSub)

    bind_Utility.DoSleep(2.0)

    ;bind_MovementQuestScript.StartWorking(theDom)

    fs.EventCleanUpSub(theSub, theDom, true)

    ;bind_MovementQuestScript.StopWorking(theDom)

    bind_Utility.DoSleep(2.0)

    bind_Utility.EnablePlayer()

    ; if dirtAndBloodChance > 0.0
    ;     if Game.GetModByName("Dirt and Blood - Dynamic Visuals.esp") != 255
    ;         bind_Utility.WriteToConsole("fixing dirtAndBloodChance: " + dirtAndBloodChance)
    ;         Dirty_Quest_MCM dirty = Quest.GetQuest("Dirty_QuesMCM") as Dirty_Quest_MCM
    ;         dirty.Dirty_PlayerHitBloodyChance.SetValue(dirtAndBloodChance) 
    ;     endif
    ; endif

    if fs.GetRuleInfractions() > 0
        fs.MarkSubPunished()
        if fs.GetRuleInfractions() > 0
            bind_Utility.WriteInternalMonologue("I have recieved a punishment. " + fs.GetRuleInfractions() + " more to go...")
        else
            bind_Utility.WriteInternalMonologue("I have recieved all of my punishments...")
        endif
    else
        ;TODO - reward??
    endif

    ;update last whipped flag - used in prayer rules (and ??)
    StorageUtil.SetFloatValue(theSub, "bind_last_whipped", bind_Utility.GetTime())

    bcs.DoEndEvent()

    self.Stop()

endfunction

function StandupMenu()

    menuActive = true

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("I am ready to stand")
    listMenu.AddEntryItem("I need to rest longer")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        EndTheQuest()
    endif

    menuActive = false

endfunction

function PamaMenu()

    menuActive = true

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("Please make this stop")
    listMenu.AddEntryItem("I deserve more punishment")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        GotoState("")
        WhippingCompleted()
    endif

    menuActive = false

endfunction

bind_MainQuestScript property mqs auto
bind_Controller property bcs auto
bind_Functions property fs auto

Scene Property WhipScene Auto ;from zap