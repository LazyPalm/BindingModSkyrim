Scriptname bindc_Main extends Quest conditional

;constants
int property DHLP_STATE_OFF = 0 autoReadOnly
int property DHLP_STATE_SUSPENDING = 10 autoReadOnly
int property DHLP_STATE_SUSPENDED = 11 autoReadOnly
int property DHLP_STATE_RESUMING = 20 autoReadOnly
int property DHLP_STATE_SUSPENDED_OTHER_MOD = 30 autoReadOnly

int keyCodeLeftControl = 29
int keyCodeRightControl = 157
int keyCodeLeftAlt = 56
int keyCodeRightAlt = 184
int keyCodeLeftShift = 42
int keyCodeRightShift = 54

;mod globals
string property DhlpSuspendByMod auto conditional
int property DhlpSuspend auto conditional
int property ModPaused auto conditional
int property RunningSoftChecks auto conditional
int property EventIsRunning auto conditional
string property RunningEventName auto conditional

Actor property thePlayer auto

int cycle = 0
string currentRunningState = ""

int actionKey
int modKey
bool processingKey

Quest eventQuest

event OnInit()

    if self.IsRunning()
        LoadGame()
        ;player alias will load these on game reloads
        ; Quest q = Quest.GetQuest("bindc_MainQuest")
        ; (q as bindc_Bondage).LoadGame()
        ; (q as bindc_Rules).LoadGame()
        ; (q as bindc_Gear).LoadGame()
    endif

endevent

function LoadGame()

    Quest qold = Quest.GetQuest("bind_MainQuest")
    if qold == none

        ;************************************************
        ;startup settings - these will go to the mcm
        StorageUtil.SetIntValue(none, "bindc_write_to_console", 1) ;todo - set this in the mcm
        StorageUtil.SetIntValue(none, "bindc_action_key", 43)
        StorageUtil.SetIntValue(none, "bindc_action_mod", -1)
        bindc_Util.ModifyPoints(3)
        bindc_Util.ModifyInfractions(1)
        ;************************************************

        if StorageUtil.GetIntValue(none, "bindc_save_id", -1) == -1
            StorageUtil.SetIntValue(none, "bindc_save_id", Utility.RandomInt(1000000, 5000000))
        endif

        RegisterForModEvent("dhlp-Suspend", "OnDhlpSuspend")
        RegisterForModEvent("dhlp-Resume", "OnDhlpResume") 

        actionKey = StorageUtil.GetIntValue(none, "bindc_action_key", -1)
        modKey = StorageUtil.GetIntValue(none, "bindc_action_mod", -1)

        RegisterForControl("Activate")
        RegisterForKey(actionKey)

        if thePlayer == none
            thePlayer = Game.GetPlayer()
        endif

        GoToState("SoftCheckStateStart")
        currentRunningState = "SoftCheckStateStart"

        if DhlpSuspend != DHLP_STATE_SUSPENDED_OTHER_MOD
            DhlpSuspend = DHLP_STATE_OFF
        endif

        Quest q = Quest.GetQuest("bindc_MainQuest")
        (q as bindc_Bondage).LoadGame()
        (q as bindc_Rules).LoadGame()
        (q as bindc_Gear).LoadGame()
        (q as bindc_Util).LoadGame()

        cycle = 0
        TriggerLoop(5.0)

    else

    endif

endfunction

event OnUpdate()
    cycle += 1
    bindc_Util.WriteInformation("OnUpdate cycle: " + cycle + " state: " + currentRunningState)
    ProcessLoop()
    RegisterForSingleUpdate(30.0) ;change to 60, 90 or 120
endevent

event OnKeyUp(Int KeyCode, Float HoldTime)	

    if keyCode == actionKey
        if !processingKey                
            processingKey = true

            bool bLeftControPressed = Input.IsKeyPressed(keyCodeLeftControl)
            bool bRightControlPressed = Input.IsKeyPressed(keyCodeRightControl)
            bool bLeftAltPressed = Input.IsKeyPressed(keyCodeLeftAlt)
            bool bRightAltPressed = Input.IsKeyPressed(keyCodeRightAlt)
            bool bLeftShiftPressed = Input.IsKeyPressed(keyCodeLeftShift)
            bool bRightShiftPressed = Input.IsKeyPressed(keyCodeRightShift)
            bool modifiersPressed = (bLeftControPressed || bRightControlPressed || bLeftAltPressed || bRightAltPressed || bLeftShiftPressed || bRightShiftPressed)

            bindc_Util.WriteInformation("action key press time: " + holdTime)

            ;TODO - check player faction for already kneeling

            if (modKey == -1 && !modifiersPressed) || (Input.IsKeyPressed(modKey))

                if thePlayer.IsWeaponDrawn()

                    bindc_Util.WriteNotification("Action key disabled when combat ready", bindc_Util.TextColorBlue())

                else

                    if holdTime <= 0.5
                        int handle = ModEvent.Create("bindc_ActionShortPressEvent")
                        if handle
                            ModEvent.Send(handle)
                        endif
                        ActionShortPress()
                    else
                        int handle = ModEvent.Create("bindc_ActionLongPressEvent")
                        if handle
                            ModEvent.Send(handle)
                        endif                        
                        ActionLongPress()
                    endif

                endif

            endif

            processingKey = false
        endif
    endif

endevent

function ProcessLoop()
endfunction

function StartPause()
endfunction

bool function StartEvent(Quest q, string eventName, bool sendDhlp = false)
    return false
endfunction

function EndRunningEvent()
endfunction

function ActionShortPress()
endfunction

function ActionLongPress()
endfunction

function SafeWord()
endfunction

int function EventCheck(string n, int num, float currentTime)
endfunction

function TriggerLoop(float s = 1.0)
    ;make the loop cycle faster than the normal 30s
    UnregisterForUpdate()
    RegisterForSingleUpdate(s)
endfunction

state SoftCheckStateStart
    function ProcessLoop()
        RunSoftChecks()
    endfunction
endstate

state SoftCheckStateRunning
    function SafeWord()
        bindc_Util.WriteNotification("Can't run safeword during Binding startup", bindc_Util.TextColorRed())
    endfunction
endstate

state DhlpSuspendedState
    function SafeWord()
        bindc_Util.WriteNotification("Can't run safeword during DHLP suspend", bindc_Util.TextColorRed())
    endfunction
endstate

state SafewordState
endstate

state PausedState

    function SafeWord()
        bindc_Util.WriteNotification("Can't run safeword when Binding is paused", bindc_Util.TextColorRed())
    endfunction

    function ActionShortPress()
        if bindc_Util.ConfirmBox("Resume Binding?")   
            Debug.MessageBox("Resuming Binding")
            GoToState("RunningState")
            currentRunningState = "RunningState"
            ModPaused = 0
            if !bindc_SlaveryQuest.IsRunning()
                bindc_SlaveryQuest.Start()
                StorageUtil.SetIntValue(none, "bindc_slavery_running", 1)
            endif
        endif
    endfunction

    function ActionLongPress()
    
    endfunction

endstate

state RunningState

    function SafeWord()
        RunSafeword()
    endfunction

    function StartPause()
        Debug.MessageBox("Pausing Binding")
        GoToState("PausedState")
        currentRunningState = "PausedState"
        ModPaused = 1        
        if bindc_SlaveryQuest.IsRunning()
            bindc_SlaveryQuest.Stop()
            StorageUtil.SetIntValue(none, "bindc_slavery_running", 0)
        endif
    endfunction

    function ActionShortPress()
        if bindc_SlaveryQuest.IsRunning()
            bindc_Slavery s = bindc_SlaveryQuest as bindc_Slavery
            s.ActionMenu()
        endif
        if bindc_PreQuest.IsRunning()
            bindc_Pre p = bindc_PreQuest as bindc_Pre
            p.ActionMenu()
        endif
    endfunction

    function ActionLongPress()
        if bindc_SlaveryQuest.IsRunning()
            bindc_Slavery s = bindc_SlaveryQuest as bindc_Slavery
            s.Kneel()
        endif
    endfunction

    bool function StartEvent(Quest q, string eventName, bool sendDhlp = false)
                
        EventIsRunning = 1
        RunningEventName = eventName
        eventQuest = q

        GoToState("InEventState")
        currentRunningState = "InEventState"

        ; if eventName == "Harsh Bondage"
        ;     eventQuest = Quest.GetQuest("bindc_EventHarshQuest")
        ; elseif eventName == "Camping"
        ;     eventQuest = Quest.GetQuest("bindc_EventCampQuest")
        ; endif

        if bindc_SlaveryQuest.IsRunning()
            bindc_SlaveryQuest.Stop()
            StorageUtil.SetIntValue(none, "bindc_slavery_running", 0)
        endif

        debug.MessageBox("starting: " + eventName)

        return true

    endfunction

    int function EventCheck(string n, int num, float currentTime)
        if StorageUtil.GetIntValue(none, "bindc_event_" + n + "_enabled", 0) == 0
            bindc_Util.WriteInformation("EventCheck - event: " + n + " [disabled]")
            return -1
        endif
        int roll = Utility.RandomInt(1, 100)
        int chance = StorageUtil.GetIntValue(none, "bindc_event_" + n + "_chance", 5)
        float last = StorageUtil.GetFloatValue(none, "bindc_event_" + n + "_last", 0.0)
        int cool = StorageUtil.GetIntValue(none, "bindc_event_" + n + "_cooldown", 6)
        float next = bindc_Util.AddTimeToTime(last, cool, 0)
        int result
        if roll <= chance
            if next < currentTime
                result = num
            else
                result = 0
            endif
        endif
        bindc_Util.WriteInformation("EventCheck - event: " + n + " roll: " + roll + " chance: " + chance + " ct: " + currentTime + " last: " + last + " cool: " + cool + " next: " + next)
        return result
    endfunction

    function ProcessLoop()

        if thePlayer.IsInFaction(bindc_SubFaction)

            if bindc_PreQuest.IsRunning()
                bindc_PreQuest.Stop()
            endif

            int safeArea = StorageUtil.GetIntValue(none, "bindc_safe_area", 2)
            float ct = bindc_Util.GetTime()
            int startEvent = 0

            if safeArea == 2

                int[] rnd = bindc_SKSE.GetRandomNumbers(1, 5, 5)
                int i = 0
                while i < rnd.Length && startEvent == 0
                    int test = rnd[i]
                    if test == 1
                        startEvent = EventCheck("harsh", 1, ct)
                    elseif test == 2

                    elseif test == 3

                    endif
                    i += 1
                endwhile

                ; startEvent = EventCheck("harsh", 1, ct)
                ; if startEvent == 0

                ; endif
                ; if startEvent == 0

                ; endif                
            else
            
            endif

            if startEvent > 0
                Quest q
                if startEvent == 1
                    q = Quest.GetQuest("bindc_EventHarshQuest")
                endif
                if q != none
                    q.Start()
                endif
            else

                if !bindc_SlaveryQuest.IsRunning()
                    bindc_SlaveryQuest.Start()
                    StorageUtil.SetIntValue(none, "bindc_slavery_running", 1)
                endif

                bindc_Slavery slv = bindc_SlaveryQuest as bindc_Slavery
                slv.ProcessLoop()

            endif





        else
            if bindc_SlaveryQuest.IsRunning()
                bindc_SlaveryQuest.Stop()
                StorageUtil.SetIntValue(none, "bindc_slavery_running", 0)
            endif
            if !bindc_PreQuest.IsRunning()
                bindc_PreQuest.Start()
            endif
        endif



    endfunction

endstate

state InEventState

    function SafeWord()
        if RunningEventName == "Harsh Bondage"
            (eventQuest as bindc_EventHarsh).SafeWord()
        elseif RunningEventName == "Camping"
            (eventQuest as bindc_EventCamp).SafeWord()
        elseif RunningEventName == "Inspect"
            (eventQuest as bindc_EventInspect).SafeWord()
        endif
        RunSafeword()
    endfunction

    function ActionShortPress()
        if RunningEventName == "Harsh Bondage"
            (eventQuest as bindc_EventHarsh).ActionShortPress()
        elseif RunningEventName == "Camping"
            (eventQuest as bindc_EventCamp).ActionShortPress()
        elseif RunningEventName == "Inspect"
            (eventQuest as bindc_EventInspect).ActionShortPress()
        endif
    endfunction

    function ActionLongPress()
        if RunningEventName == "Harsh Bondage"
            (eventQuest as bindc_EventHarsh).ActionLongPress()
        elseif RunningEventName == "Camping"
            (eventQuest as bindc_EventCamp).ActionLongPress()
        elseif RunningEventName == "Inspect"
            (eventQuest as bindc_EventInspect).ActionLongPress()
        endif
    endfunction

    function EndRunningEvent()
        
        if eventQuest.IsRunning()
            eventQuest.Stop()
        endif

        EventIsRunning = 0
        RunningEventName = ""

        GoToState("RunningState")

        if !bindc_SlaveryQuest.IsRunning()
            bindc_SlaveryQuest.Start()
            StorageUtil.SetIntValue(none, "bindc_slavery_running", 1)
        endif

    endfunction

endstate

function RunSoftChecks()
    RunningSoftChecks = 1
    GoToState("SoftCheckStateRunning")
    currentRunningState = "SoftCheckStateRunning"

    Quest mcmQuest = Quest.GetQuest("bindc_McmQuest")
    if !mcmQuest.IsRunning()
        mcmQuest.Start()
    endif

    ;do soft checks here

    if EventIsRunning == 1
        GoToState("InEventState")
        currentRunningState = "InEventState"
    else
        GoToState("RunningState")
        currentRunningState = "RunningState"
    endif
    TriggerLoop()
    RunningSoftChecks = 0
endfunction

event OnDhlpSuspend(string eventName, string strArg, float numArg, Form sender)
    DhlpSuspendByMod = sender.GetName()
    bindc_Util.WriteInformation("OnDhlpSuspend - sender: " + sender.GetName() + " id: " + sender.GetFormID())
    if (sender != self) 
        DhlpSuspend = DHLP_STATE_SUSPENDING
        GoToState("DhlpSuspendedState")
        currentRunningState = "DhlpSuspendedState"
        HandleOtherModDhlpStart()
    else 
        ;event start should have set the script state to inevent
        DhlpSuspend = DHLP_STATE_SUSPENDED
    endif
endevent

event OnDhlpResume(string eventName, string strArg, float numArg, Form sender)
    bindc_Util.WriteInformation("OnDhlpResume - sender: " + sender.GetName() + " id: " + sender.GetFormID())
    DhlpSuspend = DHLP_STATE_OFF
    if RunningSoftChecks == 1
        GoToState("SoftCheckStateRunning")
        currentRunningState = "SoftCheckStateRunning"
    elseif ModPaused == 1
        GoToState("PausedState")
        currentRunningState = "PausedState"
    elseif EventIsRunning == 1
        GoToState("InEventState")
        currentRunningState = "InEventState"
    else
        GoToState("RunningState")
        currentRunningState = "RunningState"
    endif
endevent

function RunSafeword()
    GoToState("SafewordState")
    currentRunningState = "SafewordState"
    ShutdownQuests()
    StorageUtil.SetIntValue(thePlayer, "bindc_outfit_id", -2) ;force a re-equip
    bindc_Util.WriteNotification("Safeword completed. Restarting slavery quest.", bindc_Util.TextColorRed())
    GoToState("RunningState")
    currentRunningState = "RunningState"
    TriggerLoop()
endfunction

function ShutdownQuests()
    if bindc_SlaveryQuest.IsRunning()
        bindc_SlaveryQuest.Stop()
        StorageUtil.SetIntValue(none, "bindc_slavery_running", 0)
    endif
    if bindc_PreQuest.IsRunning()
        bindc_PreQuest.Stop()
    endif
    if eventQuest != none
        ;stop running events
        if eventQuest.IsRunning()
            eventQuest.Stop()
        endif
        EventIsRunning = 0
        RunningEventName = ""
    endif
endfunction

function HandleOtherModDhlpStart()
    ;stop quests

    DhlpSuspend = DHLP_STATE_SUSPENDED_OTHER_MOD
endfunction

Quest property bindc_SlaveryQuest auto
Quest property bindc_PreQuest auto

Faction property bindc_DomFaction auto
Faction property bindc_SubFaction auto