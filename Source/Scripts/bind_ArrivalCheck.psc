Scriptname bind_ArrivalCheck extends Quest  

event OnInit()

    if self.IsRunning()

        ;debug.MessageBox("started arrival check")

        bcs.DoStartEvent(false)
        bcs.SetEventName(self.GetName())

        bind_Utility.WriteNotification("Applying bondage set...", bind_Utility.TextColorBlue())

        mqs.NeedsBondageSetChange = 0

        bind_MovementQuestScript.FaceTarget(fs.GetDomRef(), fs.GetSubRef())
        bind_MovementQuestScript.PlayDoWork(fs.GetDomRef())

        bms.EquipBondageOutfit(fs.GetSubRef(), mqs.ActiveBondageSetId)

        bcs.DoEndEvent(false)

        self.Stop()

    endif

endevent

bind_MainQuestScript property mqs auto
bind_BondageManager property bms auto
bind_Controller property bcs auto
bind_Functions property fs auto