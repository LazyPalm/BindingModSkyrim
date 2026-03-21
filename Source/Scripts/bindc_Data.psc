Scriptname bindc_Data extends Quest conditional

; string property STORAGE_KEY_MOD_STATE = "bindc_mod_state" autoReadOnly
; string property STORAGE_KEY_SLAVE = "bindc_slave" autoReadOnly

; string function StorageKeyModState() global
;     return "bindc_mod_state"
; endfunction

; int property SLAVE_STATE_FREE = 0 autoReadOnly
; int property SLAVE_STATE_ENSLAVED = 1 autoReadOnly

; int property Enslaved
;     int function Get()
;         return StorageUtil.GetIntValue(none, "bindc_slave", 0)
;     endfunction
;     function Set(int value)
;         StorageUtil.SetIntValue(none, "bindc_slave", value)
;     endfunction
; endproperty

; float function EventLastUpdate(bool mark = false) global
;     ;NOTE - events will set this from the cycle function so the main loop can determine events are running or have finished
;     ;this should only be needed if events terminate unexpectedly
;     if mark
;         return StorageUtil.SetFloatValue(none, "bindc_event_last_update", bindc_Util.GetTime())
;     endif
;     return StorageUtil.GetFloatValue(none, "bindc_event_last_update", 0.0)
; endfunction

; int function ModState(int idle0_free1_slave2_event3 = -1) global

;     if idle0_free1_slave2_event3 > -1

;         Quest slave = Quest.GetQuest("bindc_SlaveQuest")
;         Quest free = Quest.GetQuest("bindc_FreeQuest")
        
;         if idle0_free1_slave2_event3 == 3
;             ;needs conditional or just stop both?
;             if slave != none
;                 debug.MessageBox("stopped slave quest")
;                 slave.Stop()
;             endif
;             if free != none
;                 free.Stop()
;             endif
;         elseif idle0_free1_slave2_event3 == 1            
;             if slave != none
;                 debug.MessageBox("stopped slave quest")
;                 slave.Stop()
;             endif
;             if free != none
;                 free.Start()
;             endif
;         elseif idle0_free1_slave2_event3 == 2
;             if free != none
;                 free.Stop()
;             endif
;             if slave != none
;                 debug.MessageBox("started slave quest")
;                 slave.Start()
;             endif
;         elseif idle0_free1_slave2_event3 == 0
;             if StorageUtil.GetIntValue(none, "bindc_slave", 0) == 1
;                 if free != none
;                     free.Start() ;slave quest will end this, free needs to run if it can't start (alias not optional)
;                 endif
;                 if slave != none
;                     debug.MessageBox("started slave quest")
;                     slave.Start()
;                 endif
;                 idle0_free1_slave2_event3 = 2
;             else
;                 if free != none
;                     free.Start()
;                 endif
;                 idle0_free1_slave2_event3 = 1
;             endif
;         endif

;         return StorageUtil.SetIntValue(none, "bindc_mod_state", idle0_free1_slave2_event3)

;     endif

;     return StorageUtil.GetIntValue(none, "bindc_mod_state", 0)

; endfunction

int function Enslaved(int free0_enslaved1 = -1) global
    if free0_enslaved1 > -1
        return StorageUtil.SetIntValue(none, "bindc_slave", free0_enslaved1)
    endif
    return StorageUtil.GetIntValue(none, "bindc_slave", 0)
endfunction

int function GreetedDom(int no0_yes1 = -1) global
    if no0_yes1 > -1
        return StorageUtil.SetIntValue(none, "bindc_greeted", no0_yes1)
    endif
    return StorageUtil.GetIntValue(none, "bindc_greeted", 0)
endfunction

string function SettingsFile() global
    return "binding/exp.json"
endfunction

; int function GetSlave() global
;     return StorageUtil.GetIntValue(none, "bindc_slave", 0)
; endfunction

; function SetSlave(int value) global
;     StorageUtil.SetIntValue(none, "bindc_slave", value)
; endfunction

