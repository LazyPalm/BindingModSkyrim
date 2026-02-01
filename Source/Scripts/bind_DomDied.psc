Scriptname bind_DomDied extends Quest  

event OnInit()

    if IsRunning()
        
        bind_Functions fs = Quest.GetQuest("bind_MainQuest") as bind_Functions
        fs.ClearDom()

    endif

endevent