Scriptname bind_EntryExitQuestScript extends Quest  

event OnInit()

    ;TODO - 11/16 unused code - mark for removal?

    if self.IsRunning()

        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")

        Actor theSub = fs.GetSubRef()
        Actor theDom = fs.GetDomRef()

        ;debug.MessageBox("did this start?")

        bool isIndoors = theSub.IsInInterior()

        If theSub.GetDistance(theDom) < 2000.0

            bcs.DoStartEvent(false)
            bcs.SetEventName(self.GetName())

            ObjectReference ref = TheDoor.GetReference()     

            ;debug.MessageBox(ref)
            
            if (ref == none) 

                Quest q = Quest.GetQuest("bind_MainQuest")
                bind_RulesManager rm = q as bind_RulesManager        
                rm.BehaviorEnterExitRuleInnPermission = 1
                rm.BehaviorEnterExitRuleCastlePermission = 1
                rm.BehaviorEnterExitRulePlayerHomePermission = 1
                bind_Utility.WriteInternalMonologue("I have permission to teleport to a location...")

            else
                ObjectReference destination = PO3_SKSEFunctions.GetDoorDestination(ref)
                if destination.GetBaseObject() as Door
                    Location doorLoc = destination.GetCurrentLocation()
                    ;debug.MessageBox("name: " + doorLoc.GetName())
                    Quest q = Quest.GetQuest("bind_MainQuest")
                    ;bind_Functions fs = q as bind_Functions
                    bind_RulesManager rm = q as bind_RulesManager

                    rm.BehaviorEnterExitRuleCurrentDoorType = 0
                    rm.BehaviorEnterExitRuleInnPermission = 0
                    rm.BehaviorEnterExitRuleCastlePermission = 0
                    rm.BehaviorEnterExitRulePlayerHomePermission = 0

                    fs.BuildingDoor.ForceRefTo(ref)
                    if doorLoc != none
                        fs.BuildingDoorDestination.ForceLocationTo(doorLoc)
                        if isIndoors
                            Location currentLocation = fs.TheSubCurrentLocation.GetLocation()
                            if currentLocation != none
                                if rm.BehaviorEnterExitRuleCurrentLocationType == rm.DESTINATION_TYPE_INN
                                    rm.BehaviorEnterExitRuleInnPermission = 1
                                    bind_Utility.WriteInternalMonologue("I have permission to leave " + currentLocation.GetName() + "...")
                                elseif rm.BehaviorEnterExitRuleCurrentLocationType == rm.DESTINATION_TYPE_CASTLE
                                    rm.BehaviorEnterExitRuleCastlePermission = 1
                                    bind_Utility.WriteInternalMonologue("I have permission to leave " + currentLocation.GetName() + "...")
                                elseif rm.BehaviorEnterExitRuleCurrentLocationType == rm.DESTINATION_TYPE_PLAYERHOME
                                    rm.BehaviorEnterExitRulePlayerHomePermission = 1
                                    bind_Utility.WriteInternalMonologue("I have permission to leave " + currentLocation.GetName() + "...")
                                endif                            
                            endif
                        else
                            if (doorLoc.HasKeywordString("LocTypeInn") && rm.BehaviorEnterExitRuleInn == 1) 
                                rm.BehaviorEnterExitRuleCurrentDoorType = rm.DESTINATION_TYPE_INN
                                rm.BehaviorEnterExitRuleInnPermission = 1
                                bind_Utility.WriteInternalMonologue("I have permission to enter " + doorLoc.GetName() + "...")
                            elseif (doorLoc.HasKeywordString("LocTypeCastle") && rm.BehaviorEnterExitRuleCastle == 1) 
                                rm.BehaviorEnterExitRuleCurrentDoorType = rm.DESTINATION_TYPE_CASTLE
                                rm.BehaviorEnterExitRuleCastlePermission = 1
                                bind_Utility.WriteInternalMonologue("I have permission to enter " + doorLoc.GetName() + "...")
                            elseif (doorLoc.HasKeywordString("LocTypePlayerHouse") && rm.BehaviorEnterExitRulePlayerHome == 1) 
                                rm.BehaviorEnterExitRuleCurrentDoorType = rm.DESTINATION_TYPE_PLAYERHOME
                                rm.BehaviorEnterExitRulePlayerHomePermission = 1
                                bind_Utility.WriteInternalMonologue("I have permission to enter " + doorLoc.GetName() + "...")
                            endif
                        endif
                    else
                        fs.BuildingDoorDestination.Clear()
                    endif

                else       

                endif

            endif

            bcs.DoEndEvent(false)

        ;     bcs.DoStartEvent(false)
        ;     bcs.SetEventName(self.GetName())
        ;     bind_Utility.DisablePlayer()

        ;     ObjectReference ref = TheDoor.GetReference()       
        ;     fs.SetBuildingDoor(ref)
        ;     Form doorDestination = StorageUtil.GetFormValue(ref, "binding_door_destination", none)
        ;     Location loc

        ;     if !doorDestination
        ;         bind_Utility.WriteToConsole("first visit to this door.")
        ;         ObjectReference destination = PO3_SKSEFunctions.GetDoorDestination(ref)
        ;         bind_Utility.WriteToConsole("po3 destination: " + destination)
        ;         if destination.GetBaseObject() as Door
        ;             loc = destination.GetCurrentLocation()
        ;             StorageUtil.SetFormValue(ref, "binding_door_destination", loc as Form)
        ;         endif
        ;     else
        ;         loc = doorDestination as Location
        ;     endif

        ;     if ref
        ;         bind_Utility.WriteToConsole("This door leads to: " + loc.GetName())
        ;         if loc
        ;             fs.SetBuildingDoorLocation(loc)
        ;         else
        ;             ;no destination - invalid door
        ;             fs.ClearBuildingDoorLocation()
        ;             fs.ClearBuildingDoor()
        ;         endif

        ;         bind_MovementQuestScript.WalkTo(theDom, theSub, 128.0, 20)

        ;         if theSub.GetParentCell().IsInterior()

        ;             bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeLeaveBuilding())

        ;             StorageUtil.SetIntValue(ref, "bind_door_sub_permission", 1)
        ;             StorageUtil.SetFloatValue(ref, "bind_door_sub_permission_end_date", bind_Utility.AddTimeToCurrentTime(0, 30))

        ;             bind_Utility.WriteInternalMonologue("I have permission to leave...")

        ;         else

        ;             bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentTypeEnterBuilding())

        ;             StorageUtil.SetIntValue(ref, "bind_door_sub_permission", 1)
        ;             StorageUtil.SetFloatValue(ref, "bind_door_sub_permission_end_date", bind_Utility.AddTimeToCurrentTime(0, 30))

        ;             bind_Utility.WriteInternalMonologue("I have permission to enter " + loc.GetName() + "...")

        ;         endif

        ;     endif

        ;     bind_Utility.EnablePlayer()
            
        ;bcs.DoEndEvent(false)

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