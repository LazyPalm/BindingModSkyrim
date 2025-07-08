Scriptname bind_DairyScriptQuestScript extends Quest  

event OnInit()

    if self.IsRunning()

        bind_Utility.WriteToConsole("Dairy script quest starting Dairy quest from SM")

        if !bind_DairyQuest.IsRunning()
            bind_DairyQuest.Start()
        endif

        self.Stop()
    endif

endevent

Quest property bind_DairyQuest auto