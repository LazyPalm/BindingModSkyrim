Scriptname bind_PrologueWhipping extends Quest  

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
            think.WriteShortTermEvent(theDom, "whipped", theDom.GetDisplayName() + " has decided to give {{ player.name }} a whipping.")
        endif

        GotoState("GetAttentionState")
        RegisterForSingleUpdate(1.0)

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("prologue whipping quest safeword ending")
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
                bind_Utility.WriteNotification(fs.GetDomTitle() + " orders you to your knees...", bind_Utility.TextColorRed())
                if think.IsAiReady() && !theSub.IsInFaction(bind_KneelingFaction)
                    if firstTime
                        think.UseDirectNarration(theDom, thedom.GetDisplayName() + " orders {{ player.name }} to kneel.")
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

    bind_MovementQuestScript.WalkTo(theDom, theSub)

    if think.IsAiReady()
        int infractions = fs.GetRuleInfractions()
        if infractions == 0
            think.UseDirectNarration(theDom, thedom.GetDisplayName() + " explains to {{ player.name }} that they will be whipped for fun, but DOES NOT hit {{ player.name }} yet.")
        else
            think.UseDirectNarration(theDom, thedom.GetDisplayName() + " explains to {{ player.name }} that they will be whipped for punishment due to " + infractions + " rule infractions, but DOES NOT hit {{ player.name }} yet.")
        endif
        
        bind_Utility.DoSleep(10.0)
        StartTheQuest()
    else   
        debug.MessageBox("Still need to build this scene...")
        StartTheQuest()

        ;todo - make a scene...

        ;bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeDismissed())
    endif

endfunction

function StartTheQuest() ;NOTE - this is called from the blocking dialog in the quest

    startedQuest = true

    bind_PoseManager.StandFromKneeling(theSub)

    bcs.DoEndEvent()

    bind_Utility.DoSleep(1.0)

    bind_WhippingQuest.Start()

    self.Stop()

endfunction

bind_MainQuestScript property main auto
bind_Controller property bcs auto
bind_Functions property fs auto
bind_ThinkingDom property think auto

Faction property bind_KneelingFaction auto

Quest property bind_WhippingQuest auto