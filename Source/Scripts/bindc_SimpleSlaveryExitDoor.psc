Scriptname bindc_SimpleSlaveryExitDoor extends ObjectReference  

event OnActivate(ObjectReference akActionRef)

    Quest q = Quest.GetQuest("BindingSimpleSlaveryQuest")
    if q.IsRunning()
        bindc_SimpleSlaveryQuest ssq = q as bindc_SimpleSlaveryQuest
        ssq.UsedDoorToExit()
    endif

endevent