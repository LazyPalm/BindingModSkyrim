Scriptname binda_RulesBlessing extends Quest  

event OnInit()

    if IsRunning()
        ;debug.MessageBox("used the shrine...")
        Stop()
    endif

endevent