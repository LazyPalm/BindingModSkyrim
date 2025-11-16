Scriptname bind_KneelingQuestScript extends Quest  

event OnInit()

    if self.IsRunning()

        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        RegisterForSingleUpdate(0.5)

    endif

endEvent

event SafewordEvent()
    
    bind_Utility.WriteToConsole("kneeling quest safeword ending")

    self.Stop()

endevent

event OnUpdate()

    debug.MessageBox("is this still happening?")

    bind_Utility.WriteToConsole("kneeing quest is updating. door: " + TheNearestDoor.GetReference())

    int crowdSize = bind_SkseFunctions.CalculateCrowd(fs.GetSubRef(), fs.GetDomRef(), 1000.0, 3000.0)
    ;debug.MessageBox(crowdSize)
    bind_CrowdSize.SetValue(crowdSize)

    If TheNearestDoor.GetReference() != none
        ObjectReference ref = TheNearestDoor.GetReference()       
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
        endif

    endif

    if NearbyFurniture.GetReference() != none
        fs.EventSetFurniture(NearbyFurniture.GetReference())
        bind_GlobalLocationHasFurniture.SetValue(1)
    else
        fs.EventClearFurniture()
        bind_GlobalLocationHasFurniture.SetValue(0)
    endif

    If NearbyBed.GetReference() != none
        fs.SetNearbyBed(NearbyBed.GetReference())
    else
        fs.ClearNearbyBed()
    endif

    If ThePublicSquare.GetReference() != none
        fs.SetPublicSquareMarker(ThePublicSquare.GetReference())
    else
        fs.ClearPublicSquareMarker()
    endif

    if mqs.DomUseWordWallEvent == 1
        if TheWordWall.GetReference() != none
            fs.EventSetWordWall(TheWordWall.GetReference())
            ;StartWordWall(TheWordWall.GetReference())
        else
            fs.EventClearWordWall()
        endif
    endif

    mqs.AdventuringCheckStatus = 0
    if mqs.AdventuringUse == 1
        mqs.AdventuringCheckStatus = 1
        if mqs.AdventuringGoodBehavior == 1
            if fs.GetRuleInfractions() > 0
                mqs.AdventuringCheckStatus = 2 ;need punishment
            endif            
        endif
        if mqs.AdventuringTimeOfDayCheck == 1 && mqs.AdventuringCheckStatus == 1
            int currentHour = bind_Utility.GetCurrentHour()
            if currentHour > 20 || currentHour < 4
                mqs.AdventuringCheckStatus = 3 ;need to sleep
            endif
        endif
        if mqs.AdventuringPointCost > 0 && mqs.AdventuringCheckStatus == 1
            if fs.GetPoints() < mqs.AdventuringPointCost
                mqs.AdventuringCheckStatus = 4 ;need more points
            endif
        endif
    endif

    self.Stop() ;need this for testing

endevent

function StartWordWall(ObjectReference wordWall)

    fs.EventSetWordWall(wordWall)

    int found = StorageUtil.FormListFind(fs.GetSubRef(), "bind_learned_walls", wordWall)
    if found > -1
        bind_Utility.WriteInternalMonologue("I have studied this word wall...")
        return
    endif

    if fs.ModInRunningState() && wordWall.GetDistance(fs.GetSubRef()) < 1000.0

        UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
        
        listMenu.AddEntryItem("Start Word Wall")
        listMenu.AddEntryItem("I am just kneeling...")

        listMenu.OpenMenu()
        int listReturn = listMenu.GetResultInt()

        if listReturn == 0
            bind_WordWallQuest.Start()
        endif

    endif

endfunction

ReferenceAlias property NearbyFurniture auto
ReferenceAlias property TheWordWall auto
ReferenceAlias property TheNearestDoor auto
ReferenceAlias property ThePublicSquare auto
ReferenceAlias property NearbyBed auto

bind_MainQuestScript property mqs auto
bind_Functions property fs auto

Quest property bind_WordWallQuest auto

GlobalVariable property bind_GlobalLocationHasFurniture auto
GlobalVariable property bind_CrowdSize auto