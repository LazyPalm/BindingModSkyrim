Scriptname bindc_EventWhip extends bindc_EventQuest  

Actor theSub
Actor theDom

bool menuActive = false
bool foundPama = false
bool foundSkyrimNet = false
bool keyPressed = false

int dirtAndBloodChance = 0

int whippingFramework = 0

event OnInit()

    if self.IsRunning()

        if data_script.MainScript.StartEvent(self, "Whip", true)
        
            if Game.IsPluginInstalled("PamaInteractiveBeatup.esm")
                foundPama = true
            endif

            if Game.IsPluginInstalled("SkyrimNet.esp")
                foundSkyrimNet = true
            endif

            theSub = GetSub()
            theDom = GetDom()
            TheDomRef.ForceRefTo(theDom)
            
            GoToState("StartPhase")

            RegisterForModEvent("ZapSlaveActionDone", "OnSlaveActionDone")
            RegisterForModEvent("AnimationEnd", "OnSexEndEvent")

            menuActive = false

            StartTheQuest()

        else

            self.Stop()

        endif

    endif

endevent

function ActionShortPress()
    bindc_Util.WriteInternalMonologue("There is nothing else for me to do...")
endfunction

function ActionLongPress()
    if !keyPressed
        keyPressed = true
        ; if data_script.SexLabScript.SceneRunningCheck(sexThreadId)
        ;     if bindc_Util.ConfirmBox("End the sex scene?")
        ;         data_script.SexLabScript.StopRunningScene(sexThreadId)
        ;     endif
        ; endif
        keyPressed = false
    endif
endfunction

event OnSexEndEvent(string eventName, string argString, float argNum, form sender)

    ; hadSex = true
    ; EndSexEvent()

endevent

function SafeWord()

     bindc_Util.WriteInformation("whipping quest safeword ending")

    if whippingFramework == 2
        ;if bind_PamaHelper.CheckValid()
            EndWhipActor(theSub)
            bindc_Util.DoSleep()
        ;endif
    else
        ;if using ZAP
        WhipScene.Stop()
    endif

endfunction

Event OnSlaveActionDone(String asType, String asMessage, Form akMaster, Int aiSceneIndex)

    WhippingCompleted()

EndEvent

state StartPhase
    function ActionShortPress()
        bindc_Util.WriteInternalMonologue("I must take this...")
    endfunction
endstate

state WhippingCompleted
    function ActionShortPress()
        if !menuActive
            StandupMenu()
        endif
    endfunction
endstate

function StartTheQuest()

    dirtAndBloodChance = 0

    ; if Game.GetModByName("Dirt and Blood - Dynamic Visuals.esp") != 255
    ;     Dirty_Quest_MCM dirty = Quest.GetQuest("Dirty_QuesMCM") as Dirty_Quest_MCM
    ;     dirtAndBloodChance = dirty.Dirty_PlayerHitBloodyChance.GetValue() as int
    ;     bindc_Util.WriteInformation("storing dirtAndBloodChance: " + dirtAndBloodChance)
    ;     dirty.Dirty_PlayerHitBloodyChance.SetValue(-100) ;d&b hit chance is 1-100 roll
    ; endif

    ; if !PrepareSub(theSub, theDom, "event_bound_sex")
    ;     debug.MessageBox("No sex outfit was found")
    ;     data_script.MainScript.EndRunningEvent() ;should always be the last line
    ;     return
    ; endif

    ; bcs.DoStartEvent()
    ; bcs.SetEventName(self.GetName())

    ;bind_MovementQuestScript.WalkTo(theDom, theSub)

    MoveToPlayer(theDom, 200.0)

    ;bind_MovementQuestScript.StartWorking(theDom)

    if !PrepareSub(theSub, theDom, "event_whipping")
        debug.MessageBox("No whipping outfit was found")
        data_script.MainScript.EndRunningEvent() ;should always be the last line
        return
    endif

    ;fs.EventGetSubReady(theSub, theDom, "event_whipping") ;, playAnimations = true, stripClothing = true, addGag = true, freeWrists = true, removeAll = false)

    ;mqs.EvHelpStripAndRemoveBondage(true, mqs.GetEventHandleBondageFreeWristsAddGag(), false, false) ;TODO - build a better version of this?

    ;bind_MovementQuestScript.StopWorking(theDom)

    if foundSkyrimNet
        if bindc_Util.GetInfractions() > 0
            SkyrimNetApi.RegisterPersistentEvent(theDom.GetDisplayName() + " decides to whip {{ player.name }} for sexual pleasure.", theDom, theSub)
        else
            SkyrimNetApi.RegisterPersistentEvent(theDom.GetDisplayName() + " decides to whip {{ player.name }} to correct unacceptable bevahior.", theDom, theSub)
        endif
    endif

    bindc_Util.DoSleep(2.0)

    if foundPama
        whippingFramework = 2
            bindc_Util.FaceTarget(theSub, theDom)
        ;if bind_PamaHelper.CheckValid()
            int furnitureType = Utility.RandomInt(1, 2)
            bindc_Util.WriteInformation("whip furniture type: " + furnitureType)
            ; if think.IsAiReady()
            ;     if furnitureType == 1
            ;         think.WriteShortTermEvent(theSub, "bound", "{{ player.name }} is stretched standing between two bondage posts, wrists tied to each; ready to be whipped.")
            ;     else
            ;         think.WriteShortTermEvent(theSub, "bound", "{{ player.name }} hangs by their wrists tied to post above them, their toes brushing the ground, body stretched; ready to be whipped.")
            ;         ;think.UseDirectNarration(theDom, "{{ player.name }} hangs by their wrists tied to post above them, their toes brushing the ground, body stretched; ready to be whipped.")
            ;     endif
            ; else
            ; endif
            WhipActor(theSub, theDom, furnitureType)
            GotoState("PamaWhippingFirstStage")
            RegisterForSingleUpdate(Utility.RandomFloat(30.0, 50.0))
        ;ndif
    else
        whippingFramework = 1
        bindc_Util.PlayWhipAnimation(theSub, theDom)
        bindc_Util.DoSleep(2.0)
        zbfSlaveActions slaveActions = zbfSlaveActions.GetApi()
        slaveActions.WhipPlayer(theDom, "", 30.0, 50.0, "")
    endif

    ;fs.EventStartCrowds()

endfunction

state PamaWhippingFirstStage

    event OnUpdate()
        GotoState("PamaWhippingSecondStage")
    endevent

    function ActionShortPress()
        bindc_Util.WriteInternalMonologue(GetDomTitle() + " is not listening to my pleas to stop...")
    endfunction

endstate

state PamaWhippingSecondStage

    function ActionShortPress()
        if !menuActive
            PamaMenu()
        endif
    endfunction

endstate

function WhippingCompleted()

    if whippingFramework == 2
       ;if bind_PamaHelper.CheckValid()
            EndWhipActor(theSub)
            ;bindc_Util.DoSleep()
        ;endif
    endif

    ;bind_MovementQuestScript.EndGetWhippedPosition(theSub)

    ;bindc_Util.DoSleep(1.0)

    bindc_Util.DoSleep(1.0)

    bindc_Util.StopAnimations(theSub)

    bindc_Util.PlayKnockedDownAnimation(theSub)

    ;fs.EventStopCrowds()

    ; if think.IsAiReady()
    ;     think.UseDirectNarration(theDom, "{{ player.name }} collapses to the ground after the beating, spent and moaning.")
    ; endif

    if foundSkyrimNet
        SkyrimNetApi.RegisterPersistentEvent("{{ player.name }} collapses to the ground after the whipping, spent and moaning.", theSub)
    endif

    bindc_Util.WriteModNotification("Press Action key to stand up...")

    GotoState("WhippingCompleted")

endfunction

function EndTheQuest()

    GotoState("")

    bindc_Util.StopAnimations(theSub)

    bindc_Util.DoSleep(2.0)

    ;bind_MovementQuestScript.StartWorking(theDom)

    ;fs.EventCleanUpSub(theSub, theDom, true)

    ;bind_MovementQuestScript.StopWorking(theDom)

    bindc_Util.DoSleep(2.0)

    bindc_Util.EnablePlayer()

    ; if dirtAndBloodChance > 0.0
    ;     if Game.GetModByName("Dirt and Blood - Dynamic Visuals.esp") != 255
    ;         bindc_Util.WriteInformation("fixing dirtAndBloodChance: " + dirtAndBloodChance)
    ;         Dirty_Quest_MCM dirty = Quest.GetQuest("Dirty_QuesMCM") as Dirty_Quest_MCM
    ;         dirty.Dirty_PlayerHitBloodyChance.SetValue(dirtAndBloodChance) 
    ;     endif
    ; endif

    if bindc_Util.GetInfractions() > 0
        bindc_Util.ModifyInfractions(-1)
        if bindc_Util.GetInfractions() > 0
            bindc_Util.WriteInternalMonologue("I have recieved a punishment. " + bindc_Util.GetInfractions() + " more to go...")
        else
            bindc_Util.WriteInternalMonologue("I have recieved all of my punishments...")
        endif
    else
        ;TODO - reward??
    endif

    ;update last whipped flag - used in prayer rules (and ??)
    ;StorageUtil.SetFloatValue(theSub, "bind_last_whipped", bindc_Util.GetTime())

    ;mqs.bind_GlobalEventWhippingNextRun.SetValue(bindc_Util.AddTimeToCurrentTime(mqs.WhippingHoursBetween, 0))

    ;bcs.DoEndEvent()

    float ct = bindc_Util.GetTime()
    StorageUtil.SetFloatValue(theSub, "bindc_last_whipped", ct)
    StorageUtil.SetFloatValue(none, "bindc_event_whip_last", ct)

    data_script.MainScript.EndRunningEvent()

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

    ; if think.IsAiReady()
    ;     listMenu.AddEntryItem("Hurts so good (masochist)")
    ;     listMenu.AddEntryItem("Better make it stop before I cum (masochist)")
    ; endif

    listMenu.AddEntryItem("")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ; if think.IsAiReady()
        ;     think.WriteShortTermEvent(theDom, "whipped", theDom.GetDisplayName() + " ends {{ player.name }}'s whipping after deciding they have had enough.")
        ; endif
        GotoState("")
        WhippingCompleted()
    ; elseif listReturn == 1
    ;     if think.IsAiReady()
    ;         think.WriteShortTermEvent(theSub, "whipped", "{{ player.name }} closes their eyes and sinks into the lashes, accepting that this is needed.")
    ;         ;think.UseDirectNarration(theDom, thedom.GetDisplayName() + " sees {{ player.name }} close their eyes and sink into the lashes, accepting that this is needed.")
    ;     endif
    ; elseif listReturn == 2
    ;     if think.IsAiReady()
    ;         think.WriteShortTermEvent(theSub, "whipped", "{{ player.name }} make moans of pleasure from the sting of the whip, thinking it hurts so good.")
    ;         ;think.UseDirectNarration(theDom, thedom.GetDisplayName() + " hears {{ player.name }} make moans of please from the sting of the whip.")
    ;     endif
    ; elseif listReturn == 3
    ;     if think.IsAiReady()
    ;         think.WriteShortTermEvent(theDom, "whipped", theDom.GetDisplayName() + " ends {{ player.name }}'s whipping before they orgasm from it.")
    ;         think.WriteShortTermEvent(theSub, "whipped", "{{ player.name }} moans as the whipping ends before climax has been reached.")
    ;         ;think.UseDirectNarration(theDom, thedom.GetDisplayName() + " ends {{ player.name }}'s whipping because they are getting too turned on by it.")
    ;         GotoState("")
    ;         WhippingCompleted()
    ;     endif
    endif

    menuActive = false

endfunction

pamaBeatupCore Function GetPamaBeatupCore()
    return Quest.GetQuest("pama_PBU") as pamaBeatupCore
Endfunction

bool Function WhipActor(Actor sub, Actor dom, int useFurnitureType, string msg = "", ObjectReference furn = none)
    
    bool result = true

    If msg != ""
        Debug.Notification(msg)
    EndIf

    pamaBeatupCore pcore = GetPamaBeatupCore()

    pcore.setWeaponChoice(0)
    pcore.setDurationChoice(0)
    ;int idx = Utility.RandomInt(1, 2)
    int pcoreResult = pcore.StartVictimSession(sub, useFurnitureType, true, furn) ;NOTE - furn does not seem to work (check on zaz types)
    
    if pcoreResult == 0 ;not slotted in furniture (not the cancel button)
        result = false
    Else
        pcore.launchHireling(0, dom, true)
    EndIf

    return result

EndFunction

bool Function EndWhipActor(Actor sub)

    bool result = true

    pamaBeatupCore pcore = GetPamaBeatupCore()

    pcore.stopHireling()
    pcore.EndVictimSession(sub)

    return result

EndFunction

bindc_Data property data_script auto

ReferenceAlias property TheDomRef auto 

Scene Property WhipScene Auto ;from zap