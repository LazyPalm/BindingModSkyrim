Scriptname bindc_SimpleSlaveryQuestSub extends ReferenceAlias  

event OnLocationChange(Location akOldLoc, Location akNewLoc)

    bindc_SimpleSlaveryQuest ssq = GetOwningQuest() as bindc_SimpleSlaveryQuest
    ssq.LocationChanged()

endevent