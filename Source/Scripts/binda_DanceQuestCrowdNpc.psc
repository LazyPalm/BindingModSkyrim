Scriptname binda_DanceQuestCrowdNpc extends ReferenceAlias  

Actor me
int widget
int widgetText
bool widgetVisible
iWant_Widgets iwd

event OnInit()

    me = self.GetActorReference()

    if me
        me.SetLookAt(Game.GetPlayer(), true)
        
        debug.Trace("binda_DanceQuestCrowdNpc initialized. AliasIndex: " + AliasIndex)

        RegisterForModEvent("bind_CycleEvent", "OnBindCycleEvent")

        widgetVisible = false
        iwd = Quest.GetQuest("iWant_WidgetQuest") as iWant_Widgets
        if iwd
            int topSpace = 40
            int yPosBar = (AliasIndex * 50) + topSpace
            int yPosText = yPosBar + 20
            widget = iwd.loadMeter(40, yPosBar, false)
            iwd.setMeterPercent(widget, 0)
            ;iwd.SetName(me.GetDisplayName())
            iwd.setVisible(widget, 1)
            widgetText = iwd.loadText(me.GetDisplayName(), "$EverywhereFont", 24, 40, yPosText, true)
            widgetVisible = true
        endif
    endif

endevent

event OnBindCycleEvent(int cycleCount, int modState)
    debug.Trace("binda_DanceQuestCrowdNpc received bind_CycleEvent - Cycle: " + cycleCount + ", State: " + modState)
    ; Add your logic here using the descriptive names
endevent

function EndDance()
    if me
        if widgetVisible
            iwd.setVisible(widget, 0)
            iwd.setVisible(widgetText, 0)
        endif
        me.ClearLookAt()
    endif
endfunction

; event OnObjectUnload()
;     debug.MessageBox("in here...")
;     if GetReference()
;         me.ClearLookAt()
;         debug.MessageBox("The quest has ended, so this alias is now dead. idx: " + AliasIndex)
;     endif
;     ; Actor target = GetReference() as Actor
;     ; if target
;     ;     target.ClearLookAt()
;     ; endif
; endevent

; event OnAliasShutdown()
;     debug.MessageBox("in here...")
;     if GetReference()
;         me.ClearLookAt()
;         debug.MessageBox("The quest has ended, so this alias is now dead. idx: " + AliasIndex)
;     endif
; endevent

Int Property AliasIndex Auto