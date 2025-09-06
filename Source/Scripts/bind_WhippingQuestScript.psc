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
        RegisterForModEvent("bind_EventCombatStartedInEvent", "CombatStartedInEvent")

        menuActive = false

        StartTheQuest()

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("whipping quest safeword ending")

    if whippingFramework == 2
        if bind_PamaHelper.CheckValid()
            bind_PamaHelper.EndWhipActor(theSub)
            bind_Utility.DoSleep()
        endif
    else
        ;if using ZAP
        WhipScene.Stop()
    endif

    self.Stop()

endevent

Event OnSlaveActionDone(String asType, String asMessage, Form akMaster, Int aiSceneIndex)

    WhippingCompleted()

EndEvent

event PressedAction(bool longPress)
endevent

event CombatStartedInEvent(Form akTarget)
    if bind_Utility.ConfirmBox("Your party has been attacked. End this?", "I must fight", fs.GetDomTitle() + " can handle this. Leave me.")
        fs.Safeword()
    endif
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

    fs.EventGetSubReady(theSub, theDom, "event_whipping") ;, playAnimations = true, stripClothing = true, addGag = true, freeWrists = true, removeAll = false)

    ;mqs.EvHelpStripAndRemoveBondage(true, mqs.GetEventHandleBondageFreeWristsAddGag(), false, false) ;TODO - build a better version of this?

    ;bind_MovementQuestScript.StopWorking(theDom)

    bind_Utility.DoSleep(2.0)

    if mqs.SoftCheckPama == 1 && mqs.EnableModPama == 1
        whippingFramework = 2
        if bind_PamaHelper.CheckValid()
            int furnitureType = Utility.RandomInt(1, 2)
            bind_Utility.WriteToConsole("whip furniture type: " + furnitureType)
            if think.IsAiReady()
                if furnitureType == 1
                    think.WriteShortTermEvent(theSub, "bound", "{{ player.name }} is stretched standing between two bondage posts, wrists tied to each; ready to be whipped.")
                else
                    think.WriteShortTermEvent(theSub, "bound", "{{ player.name }} hangs by their wrists tied to post above them, their toes brushing the ground, body stretched; ready to be whipped.")
                    ;think.UseDirectNarration(theDom, "{{ player.name }} hangs by their wrists tied to post above them, their toes brushing the ground, body stretched; ready to be whipped.")
                endif
            else
            endif
            bind_PamaHelper.WhipActor(theSub, theDom, furnitureType)
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

    fs.EventStartCrowds()

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

    fs.EventStopCrowds()

    if think.IsAiReady()
        think.UseDirectNarration(theDom, "{{ player.name }} collapses to the ground after the beating, spent and moaning.")
    endif

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

    mqs.bind_GlobalEventWhippingNextRun.SetValue(bind_Utility.AddTimeToCurrentTime(mqs.WhippingHoursBetween, 0))

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
    
    listMenu.AddEntryItem("Need to make it stop")
    listMenu.AddEntryItem("I deserve more punishment")

    if think.IsAiReady()
        listMenu.AddEntryItem("Hurts so good (masochist)")
        listMenu.AddEntryItem("Better make it stop before I cum (masochist)")
    endif

    listMenu.AddEntryItem("")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        if think.IsAiReady()
            think.WriteShortTermEvent(theDom, "whipped", theDom.GetDisplayName() + " ends {{ player.name }}'s whipping after deciding they have had enough.")
        endif
        GotoState("")
        WhippingCompleted()
    elseif listReturn == 1
        if think.IsAiReady()
            think.WriteShortTermEvent(theSub, "whipped", "{{ player.name }} closes their eyes and sinks into the lashes, accepting that this is needed.")
            ;think.UseDirectNarration(theDom, thedom.GetDisplayName() + " sees {{ player.name }} close their eyes and sink into the lashes, accepting that this is needed.")
        endif
    elseif listReturn == 2
        if think.IsAiReady()
            think.WriteShortTermEvent(theSub, "whipped", "{{ player.name }} make moans of pleasure from the sting of the whip, thinking it hurts so good.")
            ;think.UseDirectNarration(theDom, thedom.GetDisplayName() + " hears {{ player.name }} make moans of please from the sting of the whip.")
        endif
    elseif listReturn == 3
        if think.IsAiReady()
            think.WriteShortTermEvent(theDom, "whipped", theDom.GetDisplayName() + " ends {{ player.name }}'s whipping before they orgasm from it.")
            think.WriteShortTermEvent(theSub, "whipped", "{{ player.name }} moans as the whipping ends before climax has been reached.")
            ;think.UseDirectNarration(theDom, thedom.GetDisplayName() + " ends {{ player.name }}'s whipping because they are getting too turned on by it.")
            GotoState("")
            WhippingCompleted()
        endif
    endif

    menuActive = false

endfunction

bind_MainQuestScript property mqs auto
bind_Controller property bcs auto
bind_Functions property fs auto
bind_ThinkingDom property think auto

Scene Property WhipScene Auto ;from zap