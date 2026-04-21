Scriptname binda_GuardsEquipBondage extends Quest conditional

int property GuardIsBusy auto conditional

event OnInit()

    if IsRunning()

        GuardIsBusy = 0

        ;debug.MessageBox("guard should do their thing...")

    endif

endevent

function EquipBondage(Actor theGuard)

    GuardIsBusy = 1

    bind_Utility.PriApiEventStart("Guard Equips Bondage", false)

    bind_Utility.PriApiUpdatePlayerBondage(theGuard)

    bind_Utility.PriApiEventEnd(false)

    ;debug.MessageBox("ending quest...")

    self.Stop()

endfunction