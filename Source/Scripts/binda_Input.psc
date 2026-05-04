Scriptname binda_Input extends Quest  

; int actionKey = 0
; int modifierKey = 0

event OnInit()
    RegisterKeys()
endevent

function LoadGame()
    RegisterKeys()
endfunction

function RegisterKeys()

    if binda_KeyActionGlobal.GetValue() > 0
        RegisterForKey(binda_KeyActionGlobal.GetValue() as int)
    endif

    if binda_KeyModGlobal.GetValue() > 0
        RegisterForKey(binda_KeyModGlobal.GetValue() as int)
    endif

endfunction

bool modifierPressed = false
bool processingKey = false

Event OnKeyDown(Int keyCode)

    if !Utility.IsInMenuMode() && !UI.IsTextInputEnabled()
    
        if keyCode == binda_KeyActionGlobal.GetValue() && (modifierPressed || binda_KeyModGlobal.GetValue() == 0); Double check it's our key
            if !processingKey
                processingKey = true
                debug.Notification("Pressed the action key!!!!")
            endif
        endif

        if keyCode == binda_KeyModGlobal.GetValue()
            modifierPressed = true
        endif

    endif

EndEvent

Event OnKeyUp(Int keyCode, Float holdTime)
    
    if keyCode == binda_KeyActionGlobal.GetValue() && processingKey

        int modState = binda_ModStateGlobal.GetValue() as int

        if modState == 1
            ;running
            if holdTime < 0.5
                SendActionOpenMenuEvent()
            else
                SendActionKneelTriggerEvent()
            endif

        elseif modState == 4
            ;in event
            SendEventPressedActionEvent(holdTime >= 0.5)

        endif

        processingKey = false

    endif

    if keyCode == binda_KeyModGlobal.GetValue()
        modifierPressed = false
        ;Debug.Notification("Key released after " + holdTime + " seconds.")
    endif

EndEvent

function SendEventPressedActionEvent(bool longPress)
    int handle = ModEvent.Create("bind_EventPressedActionEvent")
    if handle
        ModEvent.PushBool(handle, longPress)
        ModEvent.Send(handle)
    endif
endfunction

function SendActionOpenMenuEvent()
    int handle = ModEvent.Create("bind_ActionOpenMenuEvent")
    if handle
        ModEvent.Send(handle)
    endif
endfunction

function SendActionKneelTriggerEvent()
    int handle = ModEvent.Create("bind_ActionKneelTriggerEvent")
    if handle
        ModEvent.Send(handle)
    endif
endfunction

function RemapKey(int oldValue, int newValue)
    if oldValue > 0
        UnregisterForKey(oldValue)
    endif
    if newValue > 0
        RegisterForKey(newValue)
    endif
endfunction

GlobalVariable property binda_ModStateGlobal auto
GlobalVariable property binda_KeyActionGlobal auto
GlobalVariable property binda_KeyModGlobal auto