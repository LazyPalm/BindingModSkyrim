Scriptname bind_ArrivalCheck extends Quest  

event OnInit()

    if self.IsRunning()

        if TheWordWallRef.GetReference() != none
            bind_Utility.WriteInternalMonologue("I can sense a spoken power to be learned here...")
            fs.EventSetWordWall(TheWordWallRef.GetReference())

            ;TODO - location check not needed since the activator disappears
            ; Location loc = TheWordWallRef.GetReference().GetCurrentLocation()
            ; if loc != none
            ;     string wallLocationName = loc.GetName()
            ;     if wallLocationName != ""
            ;         if !StorageUtil.StringListHas(Game.GetPlayer(), "bind_learned_walls", wallLocationName)
            ;             bind_Utility.WriteInternalMonologue("I can sense a spoken power to be learned here...")
            ;             ;bind_Utility.WriteInternalMonologue("I need to speak with " + fs.GetDomTitle() + "...")
            ;             fs.EventSetWordWall(TheWordWallRef.GetReference())
            ;         else
            ;             bind_Utility.WriteInternalMonologue("I have learned this wall's knowledge...")
            ;         endif
            ;     endif
            ; endif
        else
            ;debug.MessageBox("no word wall...")
            fs.EventClearWordWall()
        endif

        ;debug.MessageBox("started arrival check")

        ; bcs.DoStartEvent(false)
        ; bcs.SetEventName(self.GetName())

        ; bind_Utility.WriteNotification("Applying bondage set...", bind_Utility.TextColorBlue())

        ; bind_Utility.WriteToConsole("bind_ArrivalCheck outfit id: " + mqs.ActiveBondageSetId)

        ; mqs.NeedsBondageSetChange = 0

        ; bind_MovementQuestScript.FaceTarget(fs.GetDomRef(), fs.GetSubRef())
        ; bind_MovementQuestScript.PlayDoWork(fs.GetDomRef())

        ; ;debug.MessageBox(mqs.ActiveBondageSetId)

        ; bms.EquipBondageOutfit(fs.GetSubRef(), mqs.ActiveBondageSetId)

        ; if fs.TheSecondSub.GetReference() != none
        ;     bms.EquipBondageOutfit(fs.TheSecondSub.GetActorReference(), mqs.ActiveBondageSetId)
        ; endif
        ; if fs.TheThirdSub.GetReference() != none
        ;     bms.EquipBondageOutfit(fs.TheThirdSub.GetActorReference(), mqs.ActiveBondageSetId)
        ; endif

        ; bcs.DoEndEvent(false)

        self.Stop()

    endif

endevent

bind_MainQuestScript property mqs auto
bind_BondageManager property bms auto
bind_Controller property bcs auto
bind_Functions property fs auto

ReferenceAlias property TheWordWallRef auto