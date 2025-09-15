Scriptname bind_EntryExitQuestScript extends Quest  

event OnInit()

    if self.IsRunning()

        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")

        Actor theSub = fs.GetSubRef()
        Actor theDom = fs.GetDomRef()

        If theSub.GetDistance(theDom) < 2000.0

            bcs.DoStartEvent(false)
            bcs.SetEventName(self.GetName())
            bind_Utility.DisablePlayer()

            ObjectReference ref = TheDoor.GetReference()       
            fs.SetBuildingDoor(ref)
            Form doorDestination = StorageUtil.GetFormValue(ref, "binding_door_destination", none)
            Location loc

            if !doorDestination
                bind_Utility.WriteToConsole("first visit to this door.")
                ObjectReference destination = PO3_SKSEFunctions.GetDoorDestination(ref)
                bind_Utility.WriteToConsole("po3 destination: " + destination)
                if destination.GetBaseObject() as Door
                    loc = destination.GetCurrentLocation()
                    StorageUtil.SetFormValue(ref, "binding_door_destination", loc as Form)
                endif
            else
                loc = doorDestination as Location
            endif

            if ref
                bind_Utility.WriteToConsole("This door leads to: " + loc.GetName())
                if loc
                    fs.SetBuildingDoorLocation(loc)
                else
                    ;no destination - invalid door
                    fs.ClearBuildingDoorLocation()
                    fs.ClearBuildingDoor()
                endif

                bind_MovementQuestScript.WalkTo(theDom, theSub, 128.0, 20)

                if theSub.GetParentCell().IsInterior()

                    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeLeaveBuilding())

                    StorageUtil.SetIntValue(ref, "bind_door_sub_permission", 1)
                    StorageUtil.SetFloatValue(ref, "bind_door_sub_permission_end_date", bind_Utility.AddTimeToCurrentTime(0, 30))

                    bind_Utility.WriteInternalMonologue("I have permission to leave...")

                else

                    bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeEnterBuilding())

                    StorageUtil.SetIntValue(ref, "bind_door_sub_permission", 1)
                    StorageUtil.SetFloatValue(ref, "bind_door_sub_permission_end_date", bind_Utility.AddTimeToCurrentTime(0, 30))

                    bind_Utility.WriteInternalMonologue("I have permission to enter " + loc.GetName() + "...")

                endif

            endif

            bind_Utility.EnablePlayer()
            bcs.DoEndEvent(false)

        else
            if theSub.GetParentCell().IsInterior()
                bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is not nearby to grant permission to leave...")
            else
                bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is not nearby to grant permission to enter...")
            endif
        endif

        self.Stop()

    endif

endevent

event SafewordEvent()

    bind_Utility.WriteToConsole("entry/exit quest safeword ending")

    self.Stop()

endevent

event PressedAction(bool longPress)
    bind_Utility.WriteToConsole("pressed action in entry/exit quest - no state")
endevent

ReferenceAlias property TheDoor auto

bind_Functions property fs auto
bind_Controller property bcs auto