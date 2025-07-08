Scriptname bind_UngaggedForNeedsQuestScript extends Quest  

Actor theSub
Actor theDom

int minuteCounter
bool replaceGag
bool replacePlug
bool replaceHood

bool endingFlag
bool runningFlag

event OnInit()

    if self.IsRunning()
       
        RegisterForModEvent("bind_CycleEvent", "CycleEvent")
        RegisterForModEvent("bind_QuestEvEndEvent", "QuestEvEndEvent")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        minuteCounter = 5

        replaceGag = false
        replacePlug = false
        replaceHood = false

        runningFlag = false
        endingFlag = false

        theDom = fs.GetDomRef()
        theSub = fs.GetSubRef()

        SetObjectiveDisplayed(10, true)

        UngagSub()

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("ungagged for needs quest safeword ending")
    bind_GlobalSuspendGag.SetValue(0) ;reset this flag
    self.Stop()
endevent

function UngagSub()

    bind_Utility.DisablePlayer()
    bind_MovementQuestScript.WalkTo(theDom, theSub)
    bind_MovementQuestScript.PlayDoWork(theDom)
    bind_Utility.DoSleep(2.0)

    if theSub.IsInFaction(bms.WearingHoodFaction())
        if bms.RemoveItem(theSub, bms.BONDAGE_TYPE_HOOD())
            replaceHood = true
        endif
    endif
    
    if theSub.IsInFaction(bms.WearingGagFaction())
        if bms.GagHasPlug(theSub) && mqs.DomOnlyUnplugsPanelGags == 1
            bms.RemoveGagPlug(theSub)
            replacePlug = true
        else
            if bms.RemoveItem(theSub, bms.BONDAGE_TYPE_GAG())
                replaceGag = true
            endif
        endif
        bind_GlobalSuspendGag.SetValue(1)
    endif

    bind_Utility.EnablePlayer()

    runningFlag = true

endfunction

function GagSub()

    bind_Utility.DisablePlayer()
    bind_MovementQuestScript.WalkTo(theDom, theSub)
    bind_MovementQuestScript.PlayDoWork(theDom)
    bind_Utility.DoSleep(2.0)

    if replaceGag
        if bms.AddItem(theSub, bms.BONDAGE_TYPE_GAG())
            bind_Utility.DoSleep()
        endif
    endif

    if replacePlug
        bms.ReplaceGagPlug(theSub)
    endif

    if replaceHood
        if bms.AddItem(theSub, bms.BONDAGE_TYPE_HOOD())
            bind_Utility.DoSleep()
        endif
    endif

    bind_GlobalSuspendGag.SetValue(0)

    bind_Utility.EnablePlayer()

    fs.DeductPoint()

    self.Stop()

endfunction

function CycleEvent(int cycles, int modState)

    if modState == bind_Controller.GetModStateRunning() && runningFlag
        ;this will only use minutes if no other events are running

        minuteCounter -= 1
        bind_Utility.WriteToConsole("ungagged for needs minutes: " + minuteCounter)

        if minuteCounter == 0
            if !endingFlag
                runningFlag = false
                endingFlag = true ;don't think this could double call, but just in case
                GagSub()
            endif
        endif

    endif

endfunction

function FixPanelGagAfterEventOrPause()
    if replacePlug
        bind_Utility.WriteToConsole("ungagged for needs - fixing panel gag & plug after event end")
        if !theSub.IsInFaction(bms.WearingGagFaction())
            if bms.AddItem(theSub, bms.BONDAGE_TYPE_GAG()) ;put back on the panel gag
                bind_Utility.DoSleep()
            endif
        endif
        if bms.GagHasPlug(theSub) ;in case user changes the favorite gag type
            bms.RemoveGagPlug(theSub)
        endif
    endif
endfunction

function QuestEvEndEvent()
    FixPanelGagAfterEventOrPause()
endfunction

GlobalVariable property bind_GlobalSuspendGag auto

bind_MainQuestScript property mqs auto
bind_Controller property bcs auto
bind_BondageManager property bms auto
bind_Functions property fs auto