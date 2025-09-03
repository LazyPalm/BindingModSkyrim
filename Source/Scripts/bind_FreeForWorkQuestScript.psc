Scriptname bind_FreeForWorkQuestScript extends Quest  

Actor theSub
Actor theDom

int minuteCounter

bool endingFlag
bool runningFlag

bool addedShackles

bool endingQuest = false

float endTime

event OnInit()

    if self.IsRunning()
       
        RegisterForModEvent("bind_CycleEvent", "CycleEvent")
        RegisterForModEvent("bind_QuestEvEndEvent", "QuestEvEndEvent")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
        RegisterForModEvent("bind_EventCombatStartedInEvent", "CombatStartedInEvent")
        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")

        minuteCounter = 5 ;change this to 10? have an MCM setting??

        endTime = bind_Utility.AddTimeToCurrentTime(2, 0)

        addedShackles = false

        runningFlag = false
        endingFlag = false

        theDom = fs.GetDomRef()
        theSub = fs.GetSubRef()

        bcs.DoStartEvent(sendDhlp = false)
        bcs.SetEventName(self.GetName())

        SetObjectiveDisplayed(10, true)

        FreeSub()

    endif

endevent

;TODO - main script needs to send a location change event, so this quest can 
;bump back on the heavy bondage suspended flag if arriving at a city or town turns it off
;should this be in a faction vs. global??

event SafewordEvent()
    bind_Utility.WriteToConsole("freed for work quest safeword ending")
    bind_GlobalSuspendHeavyBondage.SetValue(0)
    self.Stop()
endevent

event CombatStartedInEvent(Form akTarget)
    if bind_Utility.ConfirmBox("Your party has been attacked. End this?", "I must fight", fs.GetDomTitle() + " can handle this. Leave me.")
        fs.Safeword()
    endif
endevent

event PressedAction(bool longPress)

    if !endingQuest

        float ct = bind_Utility.GetTime()
        float timeLeft = endTime - ct

        if bind_Utility.ConfirmBox("End crafting time? (" + timeLeft + " remaining)", "I am finished", "There is more to do")
            BindSub()
        endif
    endif

endevent

function FreeSub()

    bind_Utility.DisablePlayer()
    bind_MovementQuestScript.WalkTo(theDom, theSub)
    bind_MovementQuestScript.PlayDoWork(theDom)
    bind_Utility.DoSleep(2.0)

    fs.EventGetSubReady(theSub, theDom, "event_free_for_work")

    ; if theSub.IsInFaction(bms.WearingHeavyBondageFaction())
    ;     if bms.RemoveItem(theSub, bms.BONDAGE_TYPE_HEAVYBONDAGE())
    ;         bind_Utility.DoSleep()
    ;     endif
    ; endif

    ; if !theSub.IsInFaction(bms.WearingAnkleShacklesFaction())
    ;     if bms.AddItem(theSub, bms.BONDAGE_TYPE_ANKLE_SHACKLES())
    ;         addedShackles = true
    ;         bind_Utility.DoSleep()
    ;     endif
    ; endif

    ; bind_GlobalSuspendHeavyBondage.SetValue(2)

    bind_Utility.EnablePlayer()

    runningFlag = true

endfunction

function BindSub()

    runningFlag = false
    endingQuest = true

    bind_Utility.DisablePlayer()
    bind_MovementQuestScript.WalkTo(theDom, theSub)
    bind_MovementQuestScript.PlayDoWork(theDom)
    bind_Utility.DoSleep(2.0)

    ; if bms.AddItem(theSub, bms.BONDAGE_TYPE_HEAVYBONDAGE())
    ;     bind_Utility.DoSleep()
    ; endif

    ; if addedShackles
    ;     if bms.RemoveItem(theSub, bms.BONDAGE_TYPE_ANKLE_SHACKLES())
    ;         bind_Utility.DoSleep()
    ;     endif
    ; endif

    fs.EventCleanUpSub(theSub, theDom, true)

    ;bind_GlobalSuspendHeavyBondage.SetValue(0)

    bind_Utility.EnablePlayer()

    fs.DeductPoint()

    bcs.DoEndEvent()

    self.Stop()

endfunction

function CycleEvent(int cycles, int modState)

    if runningFlag

        float ct = bind_Utility.GetTime()

        ;minuteCounter -= 1
        bind_Utility.WriteToConsole("freed for work time remaining: " + (endTime - ct))

        if ct > endTime ;minuteCounter == 0
            if !endingFlag
                runningFlag = false
                endingFlag = true ;don't think this could double call, but just in case
                BindSub()
            endif
        endif

    endif

endfunction

function QuestEvEndEvent()

endfunction

GlobalVariable property bind_GlobalSuspendHeavyBondage auto

bind_MainQuestScript property mqs auto
bind_Controller property bcs auto
bind_BondageManager property bms auto
bind_Functions property fs auto