Scriptname bindc_EventSex extends bindc_EventQuest  

Actor theSub
Actor theDom

bool keyPressed = false

bool hadSex = false

int sexThreadId = -1

event OnInit()

    if self.IsRunning()

        if data_script.MainScript.StartEvent(self, "Sex", true)
        
            RegisterForModEvent("AnimationEnd", "OnSexEndEvent")

            theSub = Game.GetPlayer()
            theDom = bindc_Util.GetDom()
            TheDomRef.ForceRefTo(theDom)

            ;bindc_EventSexQuestSceneMoveToPlayer.Start()
            MoveToObject(theDom, theSub, 200.0)

            StartSexEvent()

        else

            self.Stop()

        endif

    endif

endevent

function ActionShortPress()
    bindc_Util.WriteInternalMonologue("There is nothing else for me to do...")
endfunction

function ActionLongPress()
    if !keyPressed
        keyPressed = true
        if data_script.SexLabScript.SceneRunningCheck(sexThreadId)
            if bindc_Util.ConfirmBox("End the sex scene?")
                data_script.SexLabScript.StopRunningScene(sexThreadId)
            endif
        endif
        keyPressed = false
    endif
endfunction

event OnSexEndEvent(string eventName, string argString, float argNum, form sender)

    hadSex = true
    EndSexEvent()

endevent

function SafeWord()

    GoToState("SafewordState")
    if data_script.SexLabScript.SceneRunningCheck(sexThreadId)
        data_script.SexLabScript.StopRunningScene(sexThreadId)
    endif

    bindc_Util.WriteInformation("sex quest safeword ending")

endfunction

state SafewordState

    event OnSexEndEvent(string eventName, string argString, float argNum, form sender)
    endevent

endstate

function Arrived()

    debug.Notification("arrived...")

    StartSexEvent()

endfunction

function StartSexEvent()

    if !PrepareSub(theSub, theDom, "event_bound_sex")
        debug.MessageBox("No sex outfit was found")
        data_script.MainScript.EndRunningEvent() ;should always be the last line
        return
    endif

    ; int outfitId = data_script.BondageScript.GetBondageOutfitForEvent(theSub, "event_bound_sex")
    ; if outfitId == 0
    ;     outfitId = data_script.BondageScript.GetBondageOutfitForEvent(theSub, "event_any_event")
    ; endif
    ; if outfitId > 0
    ; else 
    ;     debug.MessageBox("No sex outfit was found")
    ;     data_script.MainScript.EndRunningEvent() ;should always be the last line
    ;     return
    ; endif

    ; bindc_Util.MoveToPlayer(theDom)

    ; bindc_Util.DisablePlayer()

    ; bindc_Util.PlayTyingAnimation(theDom, theSub)

    ; bindc_Util.FadeOutApplyNoDisable()

    ; data_script.BondageScript.EquipBondageOutfit(theSub, outfitId)
    ; bindc_Util.DoSleep(3.0)

    ; bindc_Util.StopAnimations(thedom)

    ; bindc_Util.EnablePlayer()

    ; bindc_Util.FadeOutRemoveNoDisable()

    sexThreadId = data_script.SexLabScript.StartSexScene(theSub, theDom)

    if sexThreadId > -1
        GoToState("HavingSexState")
    else
        EndSexEvent()
    endif

endfunction

state HavingSexState

    function ActionShortPress()
        bindc_Util.WriteInternalMonologue("This feels good...")
    endfunction

    function ActionLongPress()
        if data_script.SexLabScript.SceneRunningCheck(sexThreadId)
            if bindc_Util.ConfirmBox("End the sex scene?")
                data_script.SexLabScript.StopRunningScene(sexThreadId)
            endif
        endif
    endfunction

endstate

function EndSexEvent()

    GoToState("")

    if hadSex
        bindc_Rules r = data_script.RulesScript
        if r.GetBehaviorRule(theSub, r.BEHAVIOR_RULE_SEX_GIVE_THANKS) == 1 ;NOTE - this will switch to 2 if modified by safe/unsafe areas
            r.NeedsToThankForSex()
        endif
    endif

    data_script.MainScript.EndRunningEvent()

endfunction

bindc_Data property data_script auto

ReferenceAlias property TheDomRef auto 

Scene property bindc_EventSexQuestSceneMoveToPlayer auto