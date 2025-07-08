Scriptname bind_PrologueHarshBondageQuestScript extends Quest  

Actor theSub
Actor theDom

bool startedQuest
bool pressedButton
;bool inDialogue

event OnInit()

    if self.IsRunning()

        ;debug.MessageBox("pro started...")

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        startedQuest = false
        ;inDialogue = false
        pressedButton = false

        bcs.DoStartEvent()
        bcs.SetEventName(self.GetName())

        GotoState("GetAttentionState")
        RegisterForSingleUpdate(1.0)

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("prologue harsh bondage quest safeword ending")
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

auto state GetAttentionState
    event OnUpdate()

        ;bind_Utility.WriteToConsole("event time left: " + (eventEndTime - bind_Utility.GetTime()))

        if startedQuest
            ;what is next??

        else
            if !UI.IsMenuOpen("Dialogue Menu")
                bind_Utility.WriteNotification(fs.GetDomTitle() + " wants to speak with you...", bind_Utility.TextColorRed())
            endif
            RegisterForSingleUpdate(15.0)
        endif

    endevent
endstate

function StartTheQuest() ;NOTE - this is called from the blocking dialog in the quest

    UnregisterForUpdate()

    startedQuest = true

    bind_PoseManager.StandFromKneeling(theSub)

    bcs.DoEndEvent()

    bind_Utility.DoSleep(1.0)

    bind_EventHarshBondageQuest.Start()

    self.Stop()

endfunction

bind_MainQuestScript property main auto
bind_Controller property bcs auto
bind_Functions property fs auto

Faction property bind_KneelingFaction auto

Quest property bind_EventHarshBondageQuest auto