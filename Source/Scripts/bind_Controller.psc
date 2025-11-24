Scriptname bind_Controller extends Quest  

Actor actorSub
;Actor actorDom

bool processingKey = false

int cycles = 0

int MOD_STATE_INIT = 0
int MOD_STATE_RUNNING = 1
int MOD_STATE_PAUSED = 2
int MOD_STATE_DHLP = 3
int MOD_STATE_EVENT = 4

int keyCodeLeftControl = 29
int keyCodeRightControl = 157
int keyCodeLeftAlt = 56
int keyCodeRightAlt = 184
int keyCodeLeftShift = 42
int keyCodeRightShift = 54

int lastModState = 0

int registerEvents

event OnInit()

    if self.IsRunning()

        ;bind_Utility.WriteToConsole("started...")
        
        ;;DoInitTasks()

        LoadGame()

    endif

endEvent

function LoadGame()

    UnregisterForUpdate()

    DoInitTasks()

    ; Quest mq = Quest.GetQuest("bind_MovementQuest")
    ; if !mq.IsRunning()
    ;     mq.Start()
    ; endif

    ; if registerEvents != 1
    ;     registerEvents = 1
    ;     RegisterForModEvent("AnimationEnd", "OnSexEndEvent")
    ;     RegisterForModEvent("AnimationEnd", "OnSexEndEvent")
    ;     RegisterForModEvent("ZapSlaveActionDone", "OnSlaveActionDone")
    ;     RegisterForModEvent("ZapSlaveSexLabDone", "OnSlaveSexLabDone")
    ; endif

    ; RegisterForControl("Activate")
    ; RegisterForKey(bind_GlobalActionKey.GetValue() as int)

    if !bind_MovementQuest.IsRunning()
        bind_MovementQuest.Start()
    endif

    if !bind_CrowdsQuest.IsRunning()
        bind_CrowdsQuest.Start()
    endif

    if !bind_LocationChangeDetectionQuest.IsRunning()
        ;bind_LocationChangeDetectionQuest.Start()
        bind_LocationChangeDetectionQuest.Stop() ;NOTE - moved detection to Functions / ProcessLocationChange
    endif

    if !bind_EntryExitQuest.IsRunning()
        ;bind_EntryExitQuest.Start()
    endif

    if !bind_BoundForLocations.IsRunning()
        bind_BoundForLocations.Start()
    endif

    if bind_GoAdventuringQuest.IsRunning()
        bind_GoAdventuringQuestScript adventure = bind_GoAdventuringQuest as bind_GoAdventuringQuestScript
        adventure.LoadGame()
    endif

    ;actorDom = fs.GetDomRef() ; TheDom.GetReference() as Actor

endfunction

function DoInitTasks()

    actorSub = Game.GetPlayer()

    RegisterForControl("Activate")
    RegisterForKey(bind_GlobalActionKey.GetValue() as int)
    
    ;RegisterForKey(bind_GlobalActionKey.GetValue() as int)

    RegisterForModEvent("dhlp-Suspend", "OnDhlpSuspend")
    RegisterForModEvent("dhlp-Resume", "OnDhlpResume") 

    RegisterForModEvent("bind_PauseStartEvent", "OnPauseStart")
    RegisterForModEvent("bind_PauseEndEvent", "OnPauseEnd")

    SetModState(MOD_STATE_RUNNING)
    RegisterForSingleUpdate(1.0)

endfunction

event OnUpdate()
    
    ;NOTE - main game loop
	DoUpdate()

    cycles += 1
    bind_Utility.WriteToConsole("cycle: " + cycles)

    int handle = ModEvent.Create("bind_CycleEvent")
    if handle
        ModEvent.PushInt(handle, cycles)
        ModEvent.PushInt(handle, bind_GlobalModState.GetValue() as int)
        ModEvent.Send(handle)
    endif

    if main.NeedsBondageSetChange == 1
        RegisterForSingleUpdate(20.0) ;speed this up
    else
	    RegisterForSingleUpdate(60.0)
    endif

endevent

function AdvanceGameLoop()
    UnregisterForUpdate()
    RegisterForSingleUpdate(1.0)
endfunction

event OnKeyUp(Int KeyCode, Float HoldTime)	
	ProcessInput(KeyCode, HoldTime)
endevent

Event OnControlUp(string control, float HoldTime)
	If control == "Activate" && Game.UsingGamepad()
        ;check pose manager in pose and no event running
        ;send stand event if so
        ;bind_Utility.WriteToConsole("activate pressed on gamepad")
    elseif control == "Activate"
        ;bind_Utility.WriteToConsole("activate pressed on keyboard")
	EndIf
EndEvent

event OnDhlpSuspend(string eventName, string strArg, float numArg, Form sender)
    bind_Utility.WriteToConsole("OnDhlpSuspend sender: " + sender.GetName() + " id: " + sender.GetFormID())
    if (sender != self) && (bind_GlobalModState.GetValue() != MOD_STATE_DHLP) ;NOTE - (bind_GlobalModState.GetValue() != MOD_STATE_DHLP) - should guard against a mod double sending DHLP events
        lastModState = bind_GlobalModState.GetValue() as int ;NOTE - this should be running or paused, events have triggered DHLP state for other mods
        GoToState("DhlpState")
        SetModState(MOD_STATE_DHLP)
    endif
endevent

event OnDhlpResume(string eventName, string strArg, float numArg, Form sender)
    bind_Utility.WriteToConsole("OnDhlpResume sender: " + sender.GetName() + " id: " + sender.GetFormID())
    if sender != self
        if lastModState == MOD_STATE_RUNNING || lastModState == MOD_STATE_EVENT
            GotoState("RunningState")
            SetModState(MOD_STATE_RUNNING)
        elseif lastModState == MOD_STATE_PAUSED
            GoToState("PausedState")
            SetModState(MOD_STATE_PAUSED)
        else
            ;NOTE - this should not happen
            GotoState("RunningState")
            SetModState(MOD_STATE_RUNNING)
        endif
        
    endif
endevent

event OnPauseStart()
    bind_Utility.WriteToConsole("bind_PauseStartEvent processed")
    SetModState(MOD_STATE_PAUSED)
    GoToState("PausedState")
endevent

event OnPauseEnd()
    bind_Utility.WriteToConsole("bind_PauseEndEvent processed")
    SetModState(MOD_STATE_RUNNING)
    GoToState("RunningState")
endevent

function DoUpdate()
endfunction

function ProcessInput(int keyCode, float holdTime)
endfunction

function SetModState(int modState)
    if bind_GlobalModState.GetValue() != modState
        bind_GlobalModState.SetValue(modState)
    endif
endfunction

auto state RunningState

    function ProcessInput(int keyCode, float holdTime)

        if keyCode == bind_GlobalActionKey.GetValue() as int
            if !processingKey                
                processingKey = true

                bool bLeftControPressed = Input.IsKeyPressed(keyCodeLeftControl)
                bool bRightControlPressed = Input.IsKeyPressed(keyCodeRightControl)
                bool bLeftAltPressed = Input.IsKeyPressed(keyCodeLeftAlt)
                bool bRightAltPressed = Input.IsKeyPressed(keyCodeRightAlt)
                bool bLeftShiftPressed = Input.IsKeyPressed(keyCodeLeftShift)
                bool bRightShiftPressed = Input.IsKeyPressed(keyCodeRightShift)
                bool modifiersPressed = (bLeftControPressed || bRightControlPressed || bLeftAltPressed || bRightAltPressed || bLeftShiftPressed || bRightShiftPressed)

                bind_Utility.WriteToConsole("action key press time: " + holdTime)

                ;TODO - check player faction for already kneeling

                if (main.ActionKeyModifier == 0 && !modifiersPressed) || (Input.IsKeyPressed(main.ActionKeyModifier))

                    if actorSub.IsWeaponDrawn()

                        bind_Utility.WriteNotification("Action key disabled when combat ready", bind_Utility.TextColorBlue())

                    else

                        if holdTime <= 0.5
                            bind_Controller.SendActionOpenMenuEvent()
                        else
                            bind_Controller.SendActionKneelTriggerEvent()
                        endif

                    endif

                endif

                processingKey = false
            endif
        endif
            

    endfunction

    function DoUpdate()

        ;debug.MessageBox("in controller??")

        if ReadyForStoryManager()

            ; Keyword[] kw = new Keyword[2]
            ; kw[0] = Keyword.GetKeyword("zadc_FurnitureDevice") 
            ; kw[1] = Keyword.GetKeyword("zbfFurniture")
            ; int fcount = bind_SkseFunctions.ScanForFurniture(fs.GetSubRef(), kw, 3000.0)

            int crowdSize = bind_SkseFunctions.CalculateCrowd(fs.GetSubRef(), fs.GetDomRef(), 1000.0, 3000.0)
            bind_CrowdSize.SetValue(crowdSize)

            if main.SexDomWantsPrivacy == 1
                if crowdSize == 0
                    bind_CrowdSizeCheck.SetValue(1)
                else
                    bind_CrowdSizeCheck.SetValue(0)
                endif
            else
                bind_CrowdSizeCheck.SetValue(1)
            endif

            bind_Utility.WriteToConsole("SendStoryEvent current location: " + fs.GetCurrentLocation())
            bind_StoryManager.SendStoryEvent(fs.GetCurrentLocation(), fs.GetDomRef(), actorSub, 5555, 0)
        else
            bind_Utility.WriteToConsole("Could not SendStoryEvent due to ReadyForStoryManager check failure")
        endif

    endfunction

    ;look for sex lab / zap events



endstate

state EventActiveState

    function ProcessInput(int keyCode, float holdTime)
        if keyCode == bind_GlobalActionKey.GetValue() as int
            if !processingKey
                processingKey = true

                if holdTime <= 0.5
                    bind_Controller.SendEventPressedActionEvent(false)
                else
                    bind_Controller.SendEventPressedActionEvent(true)
                endif

                bind_Utility.WriteToConsole("sending action pressed event: " + holdTime)
            
                processingKey = false
            endif
        endif
    endfunction

    function DoUpdate()

        ;send update event to quest every cycle?? instead of internal timing loops??
        ;probably a bad idea, but it is interesting

    endfunction



endstate

state PausedState

    function ProcessInput(int keyCode, float holdTime)
        if keyCode == bind_GlobalActionKey.GetValue() as int
            if !processingKey
                processingKey = true
                bind_Utility.WriteToConsole("in paused state")
                bind_Utility.WriteNotification("Binding is paused...", bind_Utility.TextColorBlue())
                processingKey = false
            endif
        endif
    endfunction
    
endstate

state DhlpState

endstate

function SendEventPressedActionEvent(bool longPress) global
    int handle = ModEvent.Create("bind_EventPressedActionEvent")
    if handle
        ModEvent.PushBool(handle, longPress)
        ModEvent.Send(handle)
    endif
endfunction

function SendActionOpenMenuEvent() global
    int handle = ModEvent.Create("bind_ActionOpenMenuEvent")
    if handle
        ModEvent.Send(handle)
    endif
endfunction

function SendActionKneelTriggerEvent() global
    int handle = ModEvent.Create("bind_ActionKneelTriggerEvent")
    if handle
        ModEvent.Send(handle)
    endif
endfunction

function DoStartEvent(bool sendDhlp = true) 

    SetModState(MOD_STATE_EVENT)
    
    if sendDhlp
        SendModEvent("dhlp-Suspend")
    endif

    int handle = ModEvent.Create("bind_QuestEvStartEvent")
    if handle
        ModEvent.Send(handle)
    endif

    GoToState("EventActiveState")

endfunction

function SetEventName(string eventName)
    bind_Utility.WriteToConsole("SetEventName eventName: " + eventName)
    main.ActiveQuestName = eventName
endfunction

function DoEndEvent(bool sendDhlp = true)

    SetModState(MOD_STATE_RUNNING)
    
    if sendDhlp
        SendModEvent("dhlp-Resume")
    endif

    int handle = ModEvent.Create("bind_QuestEvEndEvent")
    if handle
        ModEvent.Send(handle)
    endif
    
    GoToState("RunningState")

endfunction

int function GetCurrentModState()
    return bind_GlobalModState.GetValue() as int
endfunction

function SendPauseStartEvent() global
    int handle = ModEvent.Create("bind_PauseStartEvent")
    if handle
        ModEvent.Send(handle)
    endif
endfunction

function SendPauseEndEvent() global
    int handle = ModEvent.Create("bind_PauseEndEvent")
    if handle
        ModEvent.Send(handle)
    endif
endfunction

int function GetModStateRunning() global
    return 1
endfunction

int function GetModStatePaused() global
    return 2
endfunction

int function GetModStateDhlp() global
    return 3
endfunction

int function GetModStateEvent() global
    return 4
endfunction

bool function ReadyForStoryManager()

    bool result = true

    if !SafeProcess() ;UI open checks
        bind_Utility.WriteToConsole("ReadyForStoryManager - safeprocess failed")
        result = false
    endif

    ;in combat check - dragons might be attaching city or towns
    if actorSub.IsInCombat() || fs.GetDomRef().IsInCombat() || actorSub.IsWeaponDrawn()
        bind_Utility.WriteToConsole("ReadyForStoryManager - combat checks failed")
        result = false
    endif

    ;zap whipping plays in a scene - so do a scene check
    ;this is probably helpful for any mod that is running scenes outside of dhlp protected events including the base game
    if actorSub.GetCurrentScene() ;|| actorDom.GetCurrentScene()
        bind_Utility.WriteToConsole("ReadyForStoryManager - scene checks failed")
        result = false
    endif

    ;sex lab assigns a faction during sex
    if actorSub.IsInFaction(SexLabAnimatingFaction) || fs.GetDomRef().IsInFaction(SexLabAnimatingFaction)
        bind_Utility.WriteToConsole("ReadyForStoryManager - sexlab faction checks failed")
        result = false
    endif

    return result

endfunction

Bool Function SafeProcess()
    ;this code provided by IsharaMeradin on nexus
	If (!Utility.IsInMenuMode()) \
	&& (!UI.IsMenuOpen("Dialogue Menu")) \
	&& (!UI.IsMenuOpen("Console")) \
	&& (!UI.IsMenuOpen("Crafting Menu")) \
	&& (!UI.IsMenuOpen("MessageBoxMenu")) \
	&& (!UI.IsMenuOpen("ContainerMenu")) \
	&& (!UI.IsTextInputEnabled())
		;IsInMenuMode to block when game is paused with menus open
		;Dialogue Menu check to block when dialog is open
		;Console check to block when console is open - console does not trigger IsInMenuMode and thus needs its own check
		;Crafting Menu check to block when crafting menus are open - game is not paused so IsInMenuMode does not work
		;MessageBoxMenu check to block when message boxes are open - while they pause the game, they do not trigger IsInMenuMode
		;ContainerMenu check to block when containers are accessed - while they pause the game, they do not trigger IsInMenuMode
		;IsTextInputEnabled check to block when editable text fields are open
		Return True
	Else
		Return False
	EndIf
EndFunction

; function SetDom(Actor dom)
;     actorDom = dom
; endfunction


GlobalVariable property bind_GlobalModState auto
GlobalVariable property bind_GlobalActionKey auto
GlobalVariable property bind_CrowdSize auto
GlobalVariable property bind_CrowdSizeCheck auto

ReferenceAlias property TheDom auto
ReferenceAlias property TheSub auto

Keyword property bind_StoryManager auto

bind_MainQuestScript property main auto
bind_Functions property fs auto

Quest property bind_MovementQuest auto
Quest property bind_CrowdsQuest auto
Quest property bind_LocationChangeDetectionQuest auto
Quest property bind_EntryExitQuest auto
Quest property bind_BoundForLocations auto
Quest property bind_GoAdventuringQuest auto

Faction property SexLabAnimatingFaction auto