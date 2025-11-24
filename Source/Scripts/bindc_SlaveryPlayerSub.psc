Scriptname bindc_SlaveryPlayerSub extends ReferenceAlias  

event OnLocationChange(Location akOldLoc, Location akNewLoc)

    bindc_Slavery sl = Quest.GetQuest("bindc_SlaveryQuest") as bindc_Slavery
    sl.ProcessLocationChange(akOldLoc, akNewLoc)

endevent