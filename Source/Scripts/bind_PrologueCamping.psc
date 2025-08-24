Scriptname bind_PrologueCamping extends Quest  

Actor theSub
Actor theDom

bool startedQuest
bool pressedButton

event OnInit()

    if self.IsRunning()

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        startedQuest = false
        ;inDialogue = false
        pressedButton = false

        bcs.DoStartEvent()
        bcs.SetEventName(self.GetName())

        if think.IsAiReady()
            think.WriteShortTermEvent(theDom, "camping", theDom.GetDisplayName() + " has decided to camp for the night with {{ player.name }}.")
        endif

        GotoState("GetAttentionState")
        RegisterForSingleUpdate(1.0)

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("prologue camping quest safeword ending")
    self.Stop()
endevent

event PressedAction(bool longPress)
    
    if !pressedButton 
        pressedButton = true
        bind_Controller.SendActionKneelTriggerEvent()
        bind_Utility.DoSleep(2.0)
        pressedButton = false
    endif

endevent

bool firstTime = true

auto state GetAttentionState
    event OnUpdate()

        ;bind_Utility.WriteToConsole("event time left: " + (eventEndTime - bind_Utility.GetTime()))

        if startedQuest
            ;what is next??

        else
            if !theSub.IsInFaction(bind_KneelingFaction)
                bind_Utility.WriteNotification(fs.GetDomTitle() + " signals for you to kneel...", bind_Utility.TextColorRed())
                if think.IsAiReady() && !theSub.IsInFaction(bind_KneelingFaction)
                    if firstTime
                        ;think.UseDirectNarration(theDom, thedom.GetDisplayName() + " orders {{ player.name }} to kneel.")
                        firstTime = false
                    else
                        think.UseDirectNarration(theDom, thedom.GetDisplayName() + " orders {{ player.name }} to kneel. {{ player.name }} did not comply the first time.")
                    endif
                endif
            else
                PlayScene()
            endif
            RegisterForSingleUpdate(20.0)
        endif

    endevent
endstate

function PlayScene()

    UnregisterForUpdate()
    GoToState("")

    if theSub.GetDistance(theDom) > 500.0
        bind_MovementQuestScript.WalkTo(theDom, theSub)
    endif

    if think.IsAiReady()
        think.UseDirectNarration(theDom, thedom.GetDisplayName() + " explains to {{ player.name }} that they will be sleeping here for the night and that { player.name }} needs to find the perfect flat location to make camp.")
        bind_Utility.DoSleep(10.0)
        StartTheQuest()
    else   
        bind_PrologueCampingScene.Start()
    endif

endfunction

function StartTheQuest() ;NOTE - this is called from the blocking dialog in the quest

    startedQuest = true

    bind_PoseManager.StandFromKneeling(theSub)

    bind_Utility.DoSleep(1.0)

    bcs.DoEndEvent()

    bind_Utility.DoSleep(1.0)

    bind_EventCampingQuest.Start()

    self.Stop()

endfunction

bind_MainQuestScript property main auto
bind_Controller property bcs auto
bind_Functions property fs auto
bind_ThinkingDom property think auto

Scene property bind_PrologueCampingScene auto

Faction property bind_KneelingFaction auto

Quest property bind_EventCampingQuest auto