Scriptname bindc_TryOutfit extends Quest  

string outfitName = ""
Actor thePlayer

event OnInit()

    if IsRunning()

        ;bindc_Data.ModState(3)
        bindc_Main.StopFreeQuest()
        bindc_Main.StopSlaveQuest()
        
        bindc_Main.StartEvent(self)

        RegisterForModEvent("BindingEventCycle", "BindingEventCycle")
        RegisterForModEvent("BindingEventShortPress", "BindingEventShortPress")

        thePlayer = Game.GetPlayer()
        outfitName = StorageUtil.GetStringValue(thePlayer, "bindc_test_outfit_name")

        GoToState("StartBindState")
        RegisterForSingleUpdate(1.0)

    endif

endevent

event BindingEventShortPress()
endevent

event BindingEventCycle()
endevent

state StartBindState

    event OnUpdate()

        if outfitName != ""
            bindc_Bondage.RemoveItems(thePlayer, true)
            bindc_Gear.UndressActor(thePlayer, true)
            Form[] items = StorageUtil.FormListToArray(thePlayer, "bindc_outfit_" + outfitName)
            bindc_Bondage.EquipItems(thePlayer, items)
            GoToState("WaitingState")
        endif

    endevent

endstate

state WaitingState

    event BindingEventShortPress()
        if bindc_Util.ConfirmBox("End slave outfit preview?")
            int count = 0
            count = bindc_Bondage.RemoveItems(thePlayer, false)
            count = bindc_Gear.UndressActor(thePlayer, false)
            count = bindc_Gear.DressActor(thePlayer)
            count = bindc_Bondage.RestoreItems(thePlayer)
            debug.MessageBox("Slave outfit preview ended.")
            ;bindc_Data.ModState(0)
            Stop()
        endif
    endevent

endstate
