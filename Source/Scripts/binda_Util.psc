Scriptname binda_Util extends Quest  



;*****************************************************
;Private API
;*****************************************************
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