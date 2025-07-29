Scriptname bind_DomAddRulesScriptQuestScript extends Quest  

event OnInit()

    if !bind_DomAddRulesQuest.IsRunning()
        bind_DomAddRulesQuest.Start()
    endif

    self.Stop()

    ; if self.IsRunning()

    ;     bind_ThinkingDom think = bind_ThinkingDom.GetThinkingDom()
    ;     bind_Functions f = bind_Functions.GetBindingFunctions()

    ;     if think.IsAiReady()

    ;         SkyrimNetApi.DirectNarration(f.GetDomRef().GetDisplayName() + " wants to use action AddBondageRule", f.GetDomRef())
    ;         bind_Utility.WriteToConsole("bind_DomAddRulesScriptQuestScript - sent DirectNarration request for a rules change")
    ;         debug.MessageBox("bind_DomAddRulesScriptQuestScript - sent DirectNarration request for a rules change")

    ;     else

    ;         if !bind_DomAddRulesQuest.IsRunning()
    ;             bind_DomAddRulesQuest.Start()
    ;         endif

    ;     endif

    ;     self.Stop()

    ; endif

endevent

Quest property bind_DomAddRulesQuest auto