Scriptname binda_GuardsEquipBondage extends Quest conditional

int property GuardIsBusy auto conditional

event OnInit()

    if IsRunning()

        RegisterForModEvent("bind_ChangeOutfitCompletedModEvent", "ChangeOutfitCompletedModEvent")

        GuardIsBusy = 0

        ;debug.MessageBox("guard should do their thing...")

    endif

endevent

event ChangeOutfitCompletedModEvent(Form akActor)

    if akActor == Game.GetPlayer()

        bind_Utility.PriApiEventEnd(false, false)

        debug.MessageBox("ending quest...")

        self.Stop()

    endif

endevent

function EquipBondage(Actor theGuard)

    GuardIsBusy = 1

    int setId = 0

    bind_MainQuestScript mq = Quest.GetQuest("bind_MainQuest") as bind_MainQuestScript
    if mq
        setId = mq.ActiveBondageSetId
        mq.NeedsBondageSetChange = 0
    endif

    bind_Utility.PriApiEventStart("Guard Equips Bondage", false)

    int handle = ModEvent.Create("bind_BondageUpdateModEvent")
    if handle
        ModEvent.PushForm(handle, Game.GetPlayer())
        ModEvent.PushInt(handle, setId)
        ModEvent.Send(handle)
    endif

    ; bind_Utility.PriApiUpdatePlayerBondage(theGuard)

    ; bind_Utility.PriApiEventEnd(false, false)

    ; ;debug.MessageBox("ending quest...")

    ; self.Stop()

endfunction