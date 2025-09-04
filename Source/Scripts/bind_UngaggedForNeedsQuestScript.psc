Scriptname bind_UngaggedForNeedsQuestScript extends Quest  

Actor theSub
Actor theDom

int minuteCounter
bool replaceGag
bool replacePlug
bool replaceHood

bool endingFlag
bool runningFlag

Form removedGag

bool endingQuest = false

float endTime

event OnInit()

    if self.IsRunning()
       
        RegisterForModEvent("bind_CycleEvent", "CycleEvent")
        RegisterForModEvent("bind_QuestEvEndEvent", "QuestEvEndEvent")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_BondageOutfitEquipped", "OutfitEquipped")

        minuteCounter = 5

        endTime = bind_Utility.AddTimeToCurrentTime(2, 0)

        replaceGag = false
        replacePlug = false
        replaceHood = false

        runningFlag = false
        endingFlag = false

        theDom = fs.GetDomRef()
        theSub = fs.GetSubRef()

        bcs.DoStartEvent(sendDhlp = false)
        bcs.SetEventName(self.GetName())

        SetObjectiveDisplayed(10, true)

        UngagSub()

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("ungagged for needs quest safeword ending")
    bind_GlobalSuspendGag.SetValue(0) ;reset this flag
    self.Stop()
endevent

event OutfitEquipped()
    removedGag = none
endevent

event PressedAction(bool longPress)

    if !endingQuest

        float ct = bind_Utility.GetTime()
        float timeLeft = endTime - ct
        float minutesLeft = (endTime - ct) * 1440.0

        if bind_Utility.ConfirmBox("End removed gag time? (" + minutesLeft + " m)", "I am finished", "There is more to do")
            GagSub()
        endif
    endif

endevent

function UngagSub()

    bind_Utility.DisablePlayer()
    bind_MovementQuestScript.WalkTo(theDom, theSub)
    bind_MovementQuestScript.PlayDoWork(theDom)
    bind_Utility.DoSleep(2.0)

    Form[] ddItems = StorageUtil.FormListToArray(theSub, "binding_worn_bondage_items")

    ;debug.MessageBox(ddItems)

    int i = 0
    while i < ddItems.Length
        Form dev = ddItems[i]
        Armor renderedItem = bms.GetRenderedItem(dev)
        if renderedItem.HasKeywordString("zad_DeviousGag")
            ;debug.MessageBox(dev)
            if bms.RemoveSpecificItem(theSub, dev)
                removedGag = dev
                StorageUtil.StringListAdd(theSub, "binding_keyword_blocks", "zad_DeviousGag")
                i = 500
            endif
        endif
        i += 1
    endwhile

    ; if theSub.IsInFaction(bms.WearingHoodFaction())
    ;     if bms.RemoveItem(theSub, bms.BONDAGE_TYPE_HOOD())
    ;         replaceHood = true
    ;     endif
    ; endif
    
    ; if theSub.IsInFaction(bms.WearingGagFaction())
    ;     if bms.GagHasPlug(theSub) && mqs.DomOnlyUnplugsPanelGags == 1
    ;         bms.RemoveGagPlug(theSub)
    ;         replacePlug = true
    ;     else
    ;         if bms.RemoveItem(theSub, bms.BONDAGE_TYPE_GAG())
    ;             replaceGag = true
    ;         endif
    ;     endif
    ;     bind_GlobalSuspendGag.SetValue(1)
    ; endif

    bind_Utility.EnablePlayer()

    runningFlag = true

endfunction

function GagSub()

    bind_Utility.DisablePlayer()
    bind_MovementQuestScript.WalkTo(theDom, theSub)
    bind_MovementQuestScript.PlayDoWork(theDom)
    bind_Utility.DoSleep(2.0)

    StorageUtil.StringListRemove(theSub, "binding_keyword_blocks", "zad_DeviousGag")

    if removedGag != none

        if bms.AddSpecificItem(theSub, removedGag)
        endif

    else

        Form[] ddItems = StorageUtil.FormListToArray(theSub, "binding_worn_bondage_items")

        ;debug.MessageBox(ddItems)

        int i = 0
        while i < ddItems.Length
            Form dev = ddItems[i]
            Armor renderedItem = bms.GetRenderedItem(dev)
            if renderedItem.HasKeywordString("zad_DeviousGag")
                ;debug.MessageBox(dev)
                if bms.AddSpecificItem(theSub, dev)
                    i = 500
                endif
            endif
            i += 1
        endwhile

    endif

    ; if replaceGag
    ;     if bms.AddItem(theSub, bms.BONDAGE_TYPE_GAG())
    ;         bind_Utility.DoSleep()
    ;     endif
    ; endif

    ; if replacePlug
    ;     bms.ReplaceGagPlug(theSub)
    ; endif

    ; if replaceHood
    ;     if bms.AddItem(theSub, bms.BONDAGE_TYPE_HOOD())
    ;         bind_Utility.DoSleep()
    ;     endif
    ; endif

    ;bind_GlobalSuspendGag.SetValue(0)

    bind_Utility.EnablePlayer()

    fs.DeductPoint()

    bcs.DoEndEvent()

    self.Stop()

endfunction

function CycleEvent(int cycles, int modState)

    ; if modState == bind_Controller.GetModStateRunning() && runningFlag
    ;     ;this will only use minutes if no other events are running

    ;     minuteCounter -= 1
    ;     bind_Utility.WriteToConsole("ungagged for needs minutes: " + minuteCounter)

    ;     if minuteCounter == 0
    ;         if !endingFlag
    ;             runningFlag = false
    ;             endingFlag = true ;don't think this could double call, but just in case
    ;             GagSub()
    ;         endif
    ;     endif

    ; endif

    if runningFlag

        float ct = bind_Utility.GetTime()

        ;minuteCounter -= 1
        bind_Utility.WriteToConsole("ungagged time remaining: " + (endTime - ct))

        if ct > endTime ;minuteCounter == 0
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