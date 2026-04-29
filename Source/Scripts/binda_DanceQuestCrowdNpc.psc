Scriptname binda_DanceQuestCrowdNpc extends ReferenceAlias  

Actor me
Actor thePlayer

int widget
int widgetText
bool widgetVisible
iWant_Widgets iwd

int likesDance
int likesCurrentDance
string danceAnimation

event OnInit()

    me = self.GetActorReference()
    thePlayer = Game.GetPlayer()

    if me
        me.SetLookAt(thePlayer, true)
        
        debug.Trace("binda_DanceQuestCrowdNpc initialized. AliasIndex: " + AliasIndex)

        danceAnimation = ""
        likesCurrentDance = 0

        RegisterForModEvent("bind_CycleEvent", "OnBindCycleEvent")

        likesDance = 50

        widgetVisible = false
        iwd = Quest.GetQuest("iWant_WidgetQuest") as iWant_Widgets
        if iwd
            int topSpace = 40
            int yPosBar = (AliasIndex * 50) + topSpace
            int yPosText = yPosBar + 20
            widget = iwd.loadMeter(40, yPosBar, false)
            iwd.setMeterPercent(widget, likesDance)
            iwd.setMeterRGB(widget, 255, 0, 0, 0, 0, 0, 127, 0, 0)
            ;iwd.SetName(me.GetDisplayName())
            iwd.setVisible(widget, 1)
            widgetText = iwd.loadText(me.GetDisplayName(), "$EverywhereFont", 24, 40, yPosText, true)
            widgetVisible = true
            RegisterForSingleUpdate(15.0)
        endif

        ;debug.MessageBox("registered: " + me.GetDisplayName())
    endif

endevent

event OnUpdate()
    if likesDance < 100
        if (StorageUtil.GetStringValue(thePlayer, "bind_dance_animation") != danceAnimation) || danceAnimation == ""
            string likes = ""
            if Utility.RandomInt(1, 3) > 1
                likesCurrentDance = 1
                likes = " (+)"
            else
                likesCurrentDance = 0
                likes = " (-)"
            endif
            ;debug.MessageBox(me.GetDisplayName() + " likes: " + likes + " stored anim: " + StorageUtil.GetStringValue(thePlayer, "bind_dance_animation") + " anim: " + danceAnimation)
            iwd.setText(widgetText, me.GetDisplayName() + likes)
            danceAnimation = StorageUtil.GetStringValue(thePlayer, "bind_dance_animation")
        endif
        if likesCurrentDance == 1
            likesDance += Utility.RandomInt(0, 15) ;if likes current dance 
        else    
            likesDance += Utility.RandomInt(-5, 0)
        endif
        if likesDance < 0
            likesDance = 0
        endif
        if likesDance >= 100
            likesDance = 100
            ;debug.MessageBox("award gold...")
            float lastTip = StorageUtil.GetFloatValue(me, "bind_last_tip")
            if lastTip == 0.0 || (bind_Utility.GetTime() - lastTip >= 1.0)
                int award = Utility.RandomInt(1,5)
                ;Actor playerRef = Game.GetPlayer()
                MiscObject goldCoin = Game.GetFormFromFile(0x0000000F, "Skyrim.esm") as MiscObject
                if goldCoin
                    StorageUtil.SetFloatValue(me, "bind_last_tip", bind_Utility.GetTime())
                    thePlayer.AddItem(goldCoin, award)
                    bind_Utility.WriteNotification(me.GetDisplayName() + " gives a " + award + " gold coin tip...", bind_Utility.TextColorRed())
                endif
            endif
        endif
        iwd.setMeterPercent(widget, likesDance)
        RegisterForSingleUpdate(15.0)
    endif
endevent

event OnBindCycleEvent(int cycleCount, int modState)
    debug.Trace("binda_DanceQuestCrowdNpc received bind_CycleEvent - Cycle: " + cycleCount + ", State: " + modState)
    ; Add your logic here using the descriptive names
endevent

function EndDance()
    UnregisterForUpdate()
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