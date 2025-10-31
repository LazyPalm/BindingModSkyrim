Scriptname bind_CrowdsQuestScript extends Quest  

Actor actor1
Actor actor2
Actor actor3
Actor actor4
Actor actor5
Actor actor6

bool currentlyActive

int totalActors

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

int chatCount

event CycleEvent(int cycles, int modState)

    if currentlyActive

        chatCount = 0

        SetActiveState(actor1, (Utility.RandomInt(1, 3) >= 2))
        SetActiveState(actor2, (Utility.RandomInt(1, 3) >= 2))
        SetActiveState(actor3, (Utility.RandomInt(1, 3) >= 2))
        SetActiveState(actor4, (Utility.RandomInt(1, 3) >= 2))
        SetActiveState(actor5, (Utility.RandomInt(1, 3) >= 2))
        SetActiveState(actor6, (Utility.RandomInt(1, 3) >= 2))

        ; if think.IsAiReady()

        ;     if totalActors > 0
        ;         int selectedActor = Utility.RandomInt(1, totalActors)
        ;         Actor act
        ;         if selectedActor == 1
        ;             act = actor1
        ;         elseif selectedActor == 2
        ;             act = actor2
        ;         elseif selectedActor == 3
        ;             act = actor3
        ;         elseif selectedActor == 4
        ;             act = actor4
        ;         elseif selectedActor == 5
        ;             act = actor5
        ;         elseif selectedActor == 6
        ;             act = actor6
        ;         endif
        ;         debug.MessageBox("making comment: " + act.GetDisplayName())
        ;         if StringUtil.Find(act.GetDisplayName(), "guard", 0) > -1
        ;             think.UseDirectNarration(act, act.GetDisplayName() + " makes a lustful or lewd comment about {{ player.name }}'s current uncomfortable situation.")
        ;         else
        ;             think.UseDirectNarration(act, act.GetDisplayName() + " makes a comment {{ player.name }}'s current uncomfortable situation.")
        ;         endif
        ;     endif

        ; endif


    endif

endevent

event LocationChangeEvent(Form oldLocation, Form newLocation)

endevent

function SetCrowd(ObjectReference c1, ObjectReference c2, ObjectReference c3, ObjectReference c4, ObjectReference c5, ObjectReference c6)
    ;bind_CrowdsDetectionQuest will run, load found aliases, and call this function to load crowd aliases
    ;will assign personality faction if it does not already exist

    ;debug.MessageBox("found a crowd!!!")
    
    totalActors = 0

    if c1
        actor1 = c1 as Actor
        if think.IsAiReady()
            ClearFactions(actor1)
        else
            SetFactions(actor1)
        endif
        Crowd1.ForceRefTo(c1)
        totalActors += 1
    endif

    if c2
        actor2 = c2 as Actor
        if think.IsAiReady()
            ClearFactions(actor2)
        else
            SetFactions(actor2)
        endif
        Crowd2.ForceRefTo(c2)
        totalActors += 1
    endif

    if c3
        actor3 = c3 as Actor
        if think.IsAiReady()
            ClearFactions(actor3)
        else
            SetFactions(actor3)
        endif
        Crowd3.ForceRefTo(c3)
        totalActors += 1
    endif

    if c4
        actor4 = c4 as Actor
        if think.IsAiReady()
            ClearFactions(actor4)
        else
            SetFactions(actor4)
        endif
        Crowd4.ForceRefTo(c4)
        totalActors += 1
    endif

    if c5
        actor5 = c5 as Actor
        if think.IsAiReady()
            ClearFactions(actor5)
        else
            SetFactions(actor5)
        endif
        Crowd5.ForceRefTo(c5)
        totalActors += 1
    endif

    if c6
        actor6 = c6 as Actor
        if think.IsAiReady()
            ClearFactions(actor6)
        else
            SetFactions(actor6)
        endif
        Crowd6.ForceRefTo(c6)
        totalActors += 1
    endif

endfunction

function ClearFactions(Actor c)
    if c.IsInFaction(bind_CrowdTypeLust)
        c.RemoveFromFaction(bind_CrowdTypeLust)
        SetActiveState(c, (Utility.RandomInt(1, 2) == 2))
    endif
    if c.IsInFaction(bind_CrowdTypeMock) 
        c.RemoveFromFaction(bind_CrowdTypeMock)
        SetActiveState(c, (Utility.RandomInt(1, 2) == 2))
    endif 
    if c.IsInFaction(bind_CrowdTypePity)
        c.RemoveFromFaction(bind_CrowdTypePity)
        SetActiveState(c, (Utility.RandomInt(1, 2) == 2))
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

        if think.IsAiReady()
            if Utility.RandomInt(1, 2) == 2 && chatCount < 3
                chatCount += 1
                ; if StringUtil.Find(c.GetDisplayName(), "guard", 0) > -1
                ;     bind_Utility.WriteToConsole("crowds quest - guard " + c.GetDisplayName() + " makes a comment")
                ;     ;think.UseDirectNarration(c, c.GetDisplayName() + " without shame, since this is a common sight in Skyrim, has a lustful or lewd comment about {{ player.name }}'s current situation.")
                ;     SkyrimNetApi.DirectNarration(c.GetDisplayName() + " without shame, since this is a common sight in Skyrim, has a lustful or lewd comment about {{ player.name }}'s current situation.", c)
                ; else
                if Utility.RandomInt(1, 2) == 2 && c != fs.GetDomRef()
                    bind_Utility.WriteToConsole("crowds quest - " + c.GetDisplayName() + " chats with dom")
                    SkyrimNetApi.DirectNarration(c.GetDisplayName() + " starts a conversation with " + fs.GetDomRef().GetDisplayName() + " about {{ player.name }}'s current situation.", c, fs.GetDomRef())
                else
                    bind_Utility.WriteToConsole("crowds quest - " + c.GetDisplayName() + " makes a comment")
                    SkyrimNetApi.DirectNarration(c.GetDisplayName() + " makes a comment {{ player.name }}'s current situation.", c)
                endif
                ;endif
            endif
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

bind_ThinkingDom property think auto
bind_Functions property fs auto