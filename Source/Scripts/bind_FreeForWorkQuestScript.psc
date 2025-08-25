Scriptname bind_FreeForWorkQuestScript extends Quest  

Actor theSub
Actor theDom

int minuteCounter

bool endingFlag
bool runningFlag

bool addedShackles

event OnInit()

    if self.IsRunning()
       
        RegisterForModEvent("bind_CycleEvent", "CycleEvent")
        RegisterForModEvent("bind_QuestEvEndEvent", "QuestEvEndEvent")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
        RegisterForModEvent("bind_EventCombatStartedInEvent", "CombatStartedInEvent")

        minuteCounter = 5 ;change this to 10? have an MCM setting??

        addedShackles = false

        runningFlag = false
        endingFlag = false

        theDom = fs.GetDomRef()
        theSub = fs.GetSubRef()

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

function FreeSub()

    bind_Utility.DisablePlayer()
    bind_MovementQuestScript.WalkTo(theDom, theSub)
    bind_MovementQuestScript.PlayDoWork(theDom)
    bind_Utility.DoSleep(2.0)

    if theSub.IsInFaction(bms.WearingHeavyBondageFaction())
        if bms.RemoveItem(theSub, bms.BONDAGE_TYPE_HEAVYBONDAGE())
            bind_Utility.DoSleep()
        endif
    endif

    if !theSub.IsInFaction(bms.WearingAnkleShacklesFaction())
        if bms.AddItem(theSub, bms.BONDAGE_TYPE_ANKLE_SHACKLES())
            addedShackles = true
            bind_Utility.DoSleep()
        endif
    endif

    bind_GlobalSuspendHeavyBondage.SetValue(2)

    bind_Utility.EnablePlayer()

    runningFlag = true

endfunction

function BindSub()

    bind_Utility.DisablePlayer()
    bind_MovementQuestScript.WalkTo(theDom, theSub)
    bind_MovementQuestScript.PlayDoWork(theDom)
    bind_Utility.DoSleep(2.0)

    if bms.AddItem(theSub, bms.BONDAGE_TYPE_HEAVYBONDAGE())
        bind_Utility.DoSleep()
    endif

    if addedShackles
        if bms.RemoveItem(theSub, bms.BONDAGE_TYPE_ANKLE_SHACKLES())
            bind_Utility.DoSleep()
        endif
    endif

    bind_GlobalSuspendHeavyBondage.SetValue(0)

    bind_Utility.EnablePlayer()

    fs.DeductPoint()

    self.Stop()

endfunction

function CycleEvent(int cycles, int modState)

    if modState == bind_Controller.GetModStateRunning() && runningFlag
        ;this will only use minutes if no other events are running

        minuteCounter -= 1
        bind_Utility.WriteToConsole("freed for work minutes: " + minuteCounter)

        if minuteCounter == 0
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