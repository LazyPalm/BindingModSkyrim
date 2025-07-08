Scriptname bind_CrowdsQuestScript extends Quest  

Actor actor1
Actor actor2
Actor actor3
Actor actor4
Actor actor5
Actor actor6

bool currentlyActive

event OnInit()

    if self.IsRunning()

        RegisterForModEvent("bind_QuestEvStartEvent", "QuestEvStartEvent")
        RegisterForModEvent("bind_QuestEvEndEvent", "QuestEvEndEvent")
        RegisterForModEvent("bind_CycleEvent", "CycleEvent")
        RegisterForModEvent("bind_LocationChangeEvent", "LocationChangeEvent")
 
    endif

endEvent

event QuestEvStartEvent()

    bind_Utility.WriteToConsole("crowds detected new event")

    StartDetection()

    currentlyActive = true

endevent

function StartDetection()
    if !bind_CrowdsDetectionQuest.IsRunning()
        bind_CrowdsDetectionQuest.Start()
    endif
endfunction

event QuestEvEndEvent()

    bind_Utility.WriteToConsole("crowds detected event ending")

    currentlyActive = false

    SetActiveState(actor1, false)
    SetActiveState(actor2, false)
    SetActiveState(actor3, false)
    SetActiveState(actor4, false)
    SetActiveState(actor5, false)
    SetActiveState(actor6, false)

    actor1 = none
    actor2 = none
    actor3 = none
    actor4 = none
    actor5 = none

    ;clear the aliases
    Crowd1.Clear()
    Crowd2.Clear()
    Crowd3.Clear()
    Crowd4.Clear()
    Crowd5.Clear()
    Crowd6.Clear()

endevent

event CycleEvent(int cycles, int modState)

    if currentlyActive
        SetActiveState(actor1, (Utility.RandomInt(1, 2) == 2))
        SetActiveState(actor2, (Utility.RandomInt(1, 2) == 2))
        SetActiveState(actor3, (Utility.RandomInt(1, 2) == 2))
        SetActiveState(actor4, (Utility.RandomInt(1, 2) == 2))
        SetActiveState(actor5, (Utility.RandomInt(1, 2) == 2))
        SetActiveState(actor6, (Utility.RandomInt(1, 2) == 2))
    endif

endevent

event LocationChangeEvent(Form oldLocation, Form newLocation)

endevent

function SetCrowd(ObjectReference c1, ObjectReference c2, ObjectReference c3, ObjectReference c4, ObjectReference c5, ObjectReference c6)
    ;bind_CrowdsDetectionQuest will run, load found aliases, and call this function to load crowd aliases
    ;will assign personality faction if it does not already exist

    ;debug.MessageBox("found a crowd!!!")
    
    if c1
        actor1 = c1 as Actor
        SetFactions(actor1)
        Crowd1.ForceRefTo(c1)
    endif

    if c2
        actor2 = c2 as Actor
        SetFactions(actor2)
        Crowd2.ForceRefTo(c2)
    endif

    if c3
        actor3 = c3 as Actor
        SetFactions(actor3)
        Crowd3.ForceRefTo(c3)
    endif

    if c4
        actor4 = c4 as Actor
        SetFactions(actor4)
        Crowd4.ForceRefTo(c4)
    endif

    if c5
        actor5 = c5 as Actor
        SetFactions(actor5)
        Crowd5.ForceRefTo(c5)
    endif

    if c6
        actor6 = c6 as Actor
        SetFactions(actor6)
        Crowd6.ForceRefTo(c6)
    endif

endfunction

function SetFactions(Actor c)
    if c.IsInFaction(bind_CrowdTypeLust) || c.IsInFaction(bind_CrowdTypeMock) || c.IsInFaction(bind_CrowdTypePity)
        ;nothing to change
    else
        int roll = Utility.RandomInt(1, 3)
        if roll == 1
            c.AddToFaction(bind_CrowdTypeLust)
        elseif roll == 2
            c.AddToFaction(bind_CrowdTypeMock)
        elseif roll == 3
            c.AddToFaction(bind_CrowdTypePity)
        endif
        SetActiveState(c, (Utility.RandomInt(1, 2) == 2))
    endif
endfunction

function SetActiveState(Actor c, bool activeFlag)
    if c == none
        return
    endif
    if activeFlag
        if !c.IsInFaction(bind_CrowdIsActive)
            c.AddToFaction(bind_CrowdIsActive)
        endif
    else
        if c.IsInFaction(bind_CrowdIsActive)
            c.RemoveFromFaction(bind_CrowdIsActive)
        endif
    endif
endfunction

ReferenceAlias property Crowd1 auto
ReferenceAlias property Crowd2 auto
ReferenceAlias property Crowd3 auto
ReferenceAlias property Crowd4 auto
ReferenceAlias property Crowd5 auto
ReferenceAlias property Crowd6 auto

Quest property bind_CrowdsDetectionQuest auto

Faction property bind_CrowdTypeLust auto
Faction property bind_CrowdTypeMock auto
Faction property bind_CrowdTypePity auto
Faction property bind_CrowdIsActive auto