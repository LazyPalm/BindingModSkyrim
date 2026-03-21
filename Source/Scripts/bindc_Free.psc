Scriptname bindc_Free extends Quest  

Actor thePlayer
ObjectReference conversationTarget

event OnInit()

    if IsRunning()

        ;bindc_Data.ModState(1)
        bindc_Main.StopSlaveQuest()

        RegisterForModEvent("BindingEventCycle", "BindingEventCycle")
        RegisterForModEvent("BindingEventShortPress", "BindingEventShortPress")
        RegisterForModEvent("BindingEventSetConversationTarget", "BindingEventSetConversationTarget")
        RegisterForModEvent("BindingEventClearConversationTarget", "BindingEventClearConversationTarget")

        thePlayer = Game.GetPlayer()

    endif

endevent

event BindingEventSetConversationTarget()
    conversationTarget = bindc_Main.GetConversationTarget()
    ;debug.MessageBox(conversationTarget)
endevent

event BindingEventClearConversationTarget()
    conversationTarget = none
endevent

event BindingEventCycle()

    ;debug.MessageBox("got cycle event...")

endevent

event BindingEventShortPress()

    ;debug.MessageBox("action short press")

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    if conversationTarget != none

        if (conversationTarget as Actor).GetFactionRank(bindc_MasterFaction) == 1

            if bindc_Util.ConfirmBox("Start check-in with " + conversationTarget.GetDisplayName() + "?")
                bindc_TakeLeaveTimerGlobal.SetValue(0.0)
                bindc_Main.StartSlaveQuest()
            endif

        else

            if bindc_Util.ConfirmBox("Enslave " + thePlayer.GetDisplayName() + " to " + conversationTarget.GetDisplayName() + "?")

                ;listMenu.AddEntryItem("Enslave " + thePlayer.GetDisplayName() + " to " + conversationTarget.GetDisplayName() + "?")

                ;listMenu.OpenMenu()
                ;int listReturn = listMenu.GetResultInt()

                ;if listReturn == 0
                ;    if bindc_Util.ConfirmBox("Are you sure?")
                EnslavePlayer(conversationTarget)
                ;    endif
                ;else

                ;endif

            endif

        endif

    else 
        bindc_Util.WriteModNotification("No NPC is selected...")

    endif

endevent

function EnslavePlayer(ObjectReference domRef)

    Actor dom = domRef as Actor
    if dom == none
        debug.MessageBox("dom is empty...")
        return
    endif

    if !dom.IsInFaction(bindc_MasterFaction)
        dom.SetFactionRank(bindc_MasterFaction, 1)
        debug.MessageBox("dom: " + dom.GetDisplayName() + " master rank: " + dom.GetFactionRank(bindc_MasterFaction))
    endif

    if !thePlayer.IsInFaction(bindc_SlaveFaction)
        thePlayer.SetFactionRank(bindc_SlaveFaction, 1)
    endif



    bindc_Data.Enslaved(1)
    ;bindc_Data.ModState(0)
    bindc_Main.StartSlaveQuest()

    ; Quest slave = Quest.GetQuest("bindc_SlaveQuest")
    ; if slave != none
    ;     slave.Start()
    ; endif

    ;Stop()

endfunction

Faction property bindc_MasterFaction auto
Faction property bindc_SlaveFaction auto

GlobalVariable property bindc_TakeLeaveTimerGlobal auto