Scriptname binda_Util extends Quest  



;*****************************************************
;Private API
;*****************************************************

;MCM settings
int function SettingEventDanceCooldownHours(int changeHours = -1) global
    GlobalVariable g = Game.GetFormFromFile(0x0043A0, "Binding.esm") as GlobalVariable
    if g
        if changeHours > -1
            g.SetValue(changeHours)
        endif
        return g.GetValue() as int
    else 
        return -1
    endif
endfunction

int function SettingEventDanceChance(int changeChance = -1) global
    GlobalVariable g = Game.GetFormFromFile(0x00439D, "Binding.esm") as GlobalVariable
    if g
        if changeChance > -1
            g.SetValue(changeChance)
        endif
        return g.GetValue() as int
    else 
        return -1
    endif
endfunction

int function SettingEventDanceEnabled(int changeEnabled = -1) global
    GlobalVariable g = Game.GetFormFromFile(0x00439B, "Binding.esm") as GlobalVariable
    if g
        if changeEnabled > -1
            g.SetValue(changeEnabled)
        endif
        return g.GetValue() as int
    else 
        return -1
    endif
endfunction

int function SettingActionKey(int changeKeyCode = -1) global
    GlobalVariable g = Game.GetFormFromFile(0x004E65, "Binding.esm") as GlobalVariable
    if g
        if changeKeyCode > -1
            Quest q = Quest.GetQuest("binda_MainQuest")
            if q
                binda_Input iq = q as binda_Input
                if iq
                    iq.RemapKey(g.GetValue() as int, changeKeyCode)
                    g.SetValue(changeKeyCode)
                endif
            endif
        endif
        return g.GetValue() as int
    else 
        return -1
    endif
endfunction

int function SettingModifierKey(int changeKeyCode = -1) global
    GlobalVariable g = Game.GetFormFromFile(0x004E66, "Binding.esm") as GlobalVariable
    if g
        if changeKeyCode > -1
            Quest q = Quest.GetQuest("binda_MainQuest")
            if q
                binda_Input iq = q as binda_Input
                if iq
                    iq.RemapKey(g.GetValue() as int, changeKeyCode)
                    g.SetValue(changeKeyCode)
                endif
            endif
        endif
        return g.GetValue() as int
    else 
        return -1
    endif
endfunction

;variables
int function ModState(int changeModState = -1) global
    GlobalVariable g = Game.GetFormFromFile(0x004902, "Binding.esm") as GlobalVariable
    if g
        if changeModState > -1
            g.SetValue(changeModState)
        endif
        return g.GetValue() as int
    else 
        return -1
    endif
endfunction
