Scriptname bind_DomAddRulesScriptQuestScript extends Quest  

event OnInit()

    if self.IsRunning()

        if !bind_DomAddRulesQuest.IsRunning()
            bind_DomAddRulesQuest.Start()
        endif

        self.Stop()

    endif

endevent

Quest property bind_DomAddRulesQuest auto