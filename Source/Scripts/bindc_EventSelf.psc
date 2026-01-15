Scriptname bindc_EventSelf extends bindc_EventQuest  

Actor theSub
Actor theDom

bool keyPressed = false

int sexThreadId1 = -1
int sexThreadId2 = -1

bool endedThread1 = false
bool endedThread2 = false

event OnInit()

    if self.IsRunning()

        if data_script.MainScript.StartEvent(self, "Self", true)
        
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
        if data_script.SexLabScript.SceneRunningCheck(sexThreadId1)
            if bindc_Util.ConfirmBox("End the sex scene?")
                data_script.SexLabScript.StopRunningScene(sexThreadId1)
            endif
        endif
        keyPressed = false
    endif
endfunction

event OnSexEndEvent(string eventName, string argString, float argNum, form sender)

    if !endedThread1
        endedThread1 = true
    elseif !endedThread2
        endedThread2 = true
    endif

    if ((endedThread1 && sexThreadId2 == -1) || (endedThread1 && endedThread2))
        EndSexEvent()

    endif

endevent

function SafeWord()

    GoToState("SafewordState")
    if data_script.SexLabScript.SceneRunningCheck(sexThreadId1)
        data_script.SexLabScript.StopRunningScene(sexThreadId1)
    endif
    if data_script.SexLabScript.SceneRunningCheck(sexThreadId2)
        data_script.SexLabScript.StopRunningScene(sexThreadId2)
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

    sexThreadId1 = data_script.SexLabScript.StartSexScene(theSub)

    if sexThreadId1 > -1
        if Utility.RandomInt(1, 2) == 2 ;turn this to a chance in the mcm?
            ;make dom masturbate also
            GoToState("DomSelfState")
            RegisterForSingleUpdate(5.0)
        else
            GoToState("HavingSexState")
        endif
    else
        EndSexEvent()
    endif

endfunction

state DomSelfState

    event OnUpdate()
        GoToState("HavingSexState")
        sexThreadId2 = data_script.SexLabScript.StartSexScene(theDom)
    endevent

endstate

state HavingSexState

    function ActionShortPress()
        bindc_Util.WriteInternalMonologue("This feels good...")
    endfunction

    function ActionLongPress()
        if data_script.SexLabScript.SceneRunningCheck(sexThreadId1)
            if bindc_Util.ConfirmBox("End the sex scene?")
                data_script.SexLabScript.StopRunningScene(sexThreadId1)
                if data_script.SexLabScript.SceneRunningCheck(sexThreadId2)
                    data_script.SexLabScript.StopRunningScene(sexThreadId2)
                endif
            endif
        endif
    endfunction

endstate

function EndSexEvent()

    GoToState("")

    data_script.MainScript.EndRunningEvent()

endfunction

bindc_Data property data_script auto

ReferenceAlias property TheDomRef auto 
