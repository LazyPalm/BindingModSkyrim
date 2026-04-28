Scriptname bind_CrowdsQuestScript extends Quest  

Actor actor1
Actor actor2
Actor actor3
Actor actor4
Actor actor5
Actor actor6

bool currentlyActive

int totalActors

bool readyHasRun = false

event OnInit()

    if self.IsRunning()

        RegisterForModEvent("bind_QuestEvStartEvent", "QuestEvStartEvent")
        RegisterForModEvent("bind_QuestEvEndEvent", "QuestEvEndEvent")
        RegisterForModEvent("bind_CycleEvent", "CycleEvent")
        RegisterForModEvent("bind_LocationChangeEvent", "LocationChangeEvent")
 
    endif

endEvent

event QuestEvStartEvent()

    ;NOTE - disabled 4/28/26 - replacing this with the binda_crowdcommentsquest

    ; bind_Utility.WriteToConsole("crowds detected new event")

    ; StartDetection()

    ; currentlyActive = true

endevent

function StartDetection()
    if !bind_CrowdsDetectionQuest.IsRunning()
        bind_CrowdsDetectionQuest.Start()
    endif
endfunction

event QuestEvEndEvent()

    bind_Utility.WriteToConsole("crowds detected event ending")

    currentlyActive = false

    if actor1.IsInFaction(bind_CrowdIsActive)
        actor1.RemoveFromFaction(bind_CrowdIsActive)
    endif
    if actor2.IsInFaction(bind_CrowdIsActive)
        actor2.RemoveFromFaction(bind_CrowdIsActive)
    endif
    if actor3.IsInFaction(bind_CrowdIsActive)
        actor3.RemoveFromFaction(bind_CrowdIsActive)
    endif
    if actor4.IsInFaction(bind_CrowdIsActive)
        actor4.RemoveFromFaction(bind_CrowdIsActive)
    endif
    if actor5.IsInFaction(bind_CrowdIsActive)
        actor5.RemoveFromFaction(bind_CrowdIsActive)
    endif
    if actor6.IsInFaction(bind_CrowdIsActive)
        actor6.RemoveFromFaction(bind_CrowdIsActive)
    endif

    ; SetActiveState(actor1, false)
    ; SetActiveState(actor2, false)
    ; SetActiveState(actor3, false)
    ; SetActiveState(actor4, false)
    ; SetActiveState(actor5, false)
    ; SetActiveState(actor6, false)

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

    readyHasRun = false

endevent

;int chatCount

event CycleEvent(int cycles, int modState)

    Actor thePlayer = fs.GetSubRef()
    Keyword kwHb = Keyword.GetKeyword("zad_DeviousHeavyBondage")

    if currentlyActive ;|| thePlayer.WornHasKeyword(kwHb)

        ;fs.EventStartCrowds()

        ;chatCount = 0

        bool runDetection = true

        if actor1 && !SetActiveState(actor1)
            debug.MessageBox(actor1.GetDisplayName() + " is leaving...")
            actor1 = none
            Crowd1.Clear()
            runDetection = false ;give people a chance to wander before detecting again
        endif
        if actor2 && !SetActiveState(actor2)
            debug.MessageBox(actor2.GetDisplayName() + " is leaving...")
            actor2 = none
            Crowd2.Clear()
            runDetection = false 
        endif
        if actor3 && !SetActiveState(actor3)
            debug.MessageBox(actor3.GetDisplayName() + " is leaving...")
            actor3 = none
            Crowd3.Clear()
            runDetection = false 
        endif
        if actor4 && !SetActiveState(actor4)
            debug.MessageBox(actor4.GetDisplayName() + " is leaving...")
            actor4 = none
            Crowd4.Clear()
            runDetection = false 
        endif
        if actor5 && !SetActiveState(actor5)
            debug.MessageBox(actor5.GetDisplayName() + " is leaving...")
            actor5 = none
            Crowd5.Clear()
            runDetection = false 
        endif
        if actor6 && !SetActiveState(actor6)
            debug.MessageBox(actor6.GetDisplayName() + " is leaving...")
            actor6 = none
            Crowd6.Clear()
            runDetection = false 
        endif

        if actor1 && actor1.GetDistance(thePlayer) > 2000.0
            debug.MessageBox(actor1.GetDisplayName() + " is being removed for distance...")
            actor1 = none
            Crowd1.Clear()
            runDetection = false ;give people a chance to wander before detecting again
        endif

        if actor2 && actor2.GetDistance(thePlayer) > 2000.0
            debug.MessageBox(actor2.GetDisplayName() + " is being removed for distance...")
            actor2 = none
            Crowd2.Clear()
            runDetection = false ;give people a chance to wander before detecting again
        endif

        if actor3 && actor3.GetDistance(thePlayer) > 2000.0
            debug.MessageBox(actor3.GetDisplayName() + " is being removed for distance...")
            actor3 = none
            Crowd3.Clear()
            runDetection = false ;give people a chance to wander before detecting again
        endif

        if actor4 && actor4.GetDistance(thePlayer) > 2000.0
            debug.MessageBox(actor4.GetDisplayName() + " is being removed for distance...")
            actor4 = none
            Crowd4.Clear()
            runDetection = false ;give people a chance to wander before detecting again
        endif

        if actor5 && actor5.GetDistance(thePlayer) > 2000.0
            debug.MessageBox(actor5.GetDisplayName() + " is being removed for distance...")
            actor5 = none
            Crowd5.Clear()
            runDetection = false ;give people a chance to wander before detecting again
        endif

        if actor6 && actor6.GetDistance(thePlayer) > 2000.0
            debug.MessageBox(actor6.GetDisplayName() + " is being removed for distance...")
            actor6 = none
            Crowd6.Clear()
            runDetection = false ;give people a chance to wander before detecting again
        endif

        if runDetection
            StartDetection()
        endif

        ; SetActiveState(actor2)
        ; SetActiveState(actor3)
        ; SetActiveState(actor4)
        ; SetActiveState(actor5)
        ; SetActiveState(actor6)

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

bool function AddCrowd(ObjectReference c)

    bool result = false

    if c
        Actor a = c as Actor
        
        if a.IsInFaction(bind_CrowdIsActive)
            return false
        endif

        if a
            if Crowd1.GetReference() == none                
                actor1 = a
                SetFactions(a)
                Crowd1.ForceRefTo(c)
                totalActors += 1
                result = true
            endif
            if !result && Crowd2.GetReference() == none
                actor2 = a
                SetFactions(a)
                Crowd2.ForceRefTo(c)
                totalActors += 1
                result = true
            endif
            if !result && Crowd3.GetReference() == none
                actor3 = a
                SetFactions(a)
                Crowd3.ForceRefTo(c)
                totalActors += 1
                result = true
            endif
            if !result && Crowd4.GetReference() == none
                actor4 = a
                SetFactions(a)
                Crowd4.ForceRefTo(c)
                totalActors += 1
                result = true
            endif
            if !result && Crowd5.GetReference() == none
                actor5 = a
                SetFactions(a)
                Crowd5.ForceRefTo(c)
                totalActors += 1
                result = true
            endif
            if !result && Crowd6.GetReference() == none
                actor6 = a
                SetFactions(a)
                Crowd6.ForceRefTo(c)
                totalActors += 1
                result = true
            endif
        endif
    endif

    return result

endfunction

function CrowdReady() 
    if totalActors > 0 && !readyHasRun
        readyHasRun = true
        if think.IsAiReady()
            if StorageUtil.SetIntValue(Game.GetPlayer(), "binding_furniture_status", 0) > 0
                SkyrimNetApi.RegisterPersistentEvent("{{ player.name }} is locked helplessly in a bondage furniture device; nearby people notice and want to get a closer look.", fs.GetSubRef())
            else
                SkyrimNetApi.RegisterPersistentEvent("{{ player.name }} is bound and exposed; nearby people notice and want to get a closer look.", fs.GetSubRef())
            endif
        endif
    endif
endfunction

; function SetCrowd(ObjectReference c1, ObjectReference c2, ObjectReference c3, ObjectReference c4, ObjectReference c5, ObjectReference c6)
;     ;bind_CrowdsDetectionQuest will run, load found aliases, and call this function to load crowd aliases
;     ;will assign personality faction if it does not already exist

;     ;debug.MessageBox("found a crowd!!!")
    
;     totalActors = 0

;     if c1
;         actor1 = c1 as Actor
;         ; if think.IsAiReady()
;         ;     ClearFactions(actor1)
;         ; else
;         ;     SetFactions(actor1)
;         ; endif
;         SetFactions(actor1)
;         Crowd1.ForceRefTo(c1)
;         totalActors += 1
;     endif

;     if c2
;         actor2 = c2 as Actor
;         ; if think.IsAiReady()
;         ;     ClearFactions(actor2)
;         ; else
;         ;     SetFactions(actor2)
;         ; endif
;         SetFactions(actor2)
;         Crowd2.ForceRefTo(c2)
;         totalActors += 1
;     endif

;     if c3
;         actor3 = c3 as Actor
;         ; if think.IsAiReady()
;         ;     ClearFactions(actor3)
;         ; else
;         ;     SetFactions(actor3)
;         ; endif
;         SetFactions(actor3)
;         Crowd3.ForceRefTo(c3)
;         totalActors += 1
;     endif

;     if c4
;         actor4 = c4 as Actor
;         ; if think.IsAiReady()
;         ;     ClearFactions(actor4)
;         ; else
;         ;     SetFactions(actor4)
;         ; endif
;         SetFactions(actor4)
;         Crowd4.ForceRefTo(c4)
;         totalActors += 1
;     endif

;     if c5
;         actor5 = c5 as Actor
;         ; if think.IsAiReady()
;         ;     ClearFactions(actor5)
;         ; else
;         ;     SetFactions(actor5)
;         ; endif
;         SetFactions(actor5)
;         Crowd5.ForceRefTo(c5)
;         totalActors += 1
;     endif

;     if c6
;         actor6 = c6 as Actor
;         ; if think.IsAiReady()
;         ;     ClearFactions(actor6)
;         ; else
;         ;     SetFactions(actor6)
;         ; endif
;         SetFactions(actor6)
;         Crowd6.ForceRefTo(c6)
;         totalActors += 1
;     endif

;     if totalActors > 0
;         if think.IsAiReady()
;             if StorageUtil.SetIntValue(Game.GetPlayer(), "binding_furniture_status", 0) > 0
;                 SkyrimNetApi.RegisterPersistentEvent("{{ player.name }} is locked helplessly in a bondage furniture device; nearby people notice and want to get a closer look.", fs.GetSubRef())
;             else
;                 SkyrimNetApi.RegisterPersistentEvent("{{ player.name }} is bound and exposed; nearby people notice and want to get a closer look.", fs.GetSubRef())
;             endif
;         endif
;     endif

; endfunction

; function ClearFactions(Actor c)
;     if c.IsInFaction(bind_CrowdTypeLust)
;         c.RemoveFromFaction(bind_CrowdTypeLust)
;         SetActiveState(c, (Utility.RandomInt(1, 2) == 2))
;     endif
;     if c.IsInFaction(bind_CrowdTypeMock) 
;         c.RemoveFromFaction(bind_CrowdTypeMock)
;         SetActiveState(c, (Utility.RandomInt(1, 2) == 2))
;     endif 
;     if c.IsInFaction(bind_CrowdTypePity)
;         c.RemoveFromFaction(bind_CrowdTypePity)
;         SetActiveState(c, (Utility.RandomInt(1, 2) == 2))
;     endif
    
; endfunction

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
        SetActiveState(c, true) ; (Utility.RandomInt(1, 2) == 2))
    endif
endfunction

bool function SetActiveState(Actor a, bool resetCycles = false)
    if a == none
        return false
    endif

    if resetCycles

        bind_Utility.WriteToConsole("SetActiveState a: " + a.GetDisplayName() + " - resetting")

        StorageUtil.SetIntValue(a, "bind_crowd_cycles", 0)

        if !a.IsInFaction(bind_CrowdIsActive)
            a.AddToFaction(bind_CrowdIsActive)
        endif

        return true

    else

        int cycles = StorageUtil.GetIntValue(a, "bind_crowd_cycles", 0)
    ;if cycles == 0

        cycles += 1
        bind_Utility.WriteToConsole("SetActiveState a: " + a.GetDisplayName() + " cycles: " + cycles)
        StorageUtil.SetIntValue(a, "bind_crowd_cycles", cycles)
        if cycles > 5
            if Utility.RandomInt(1, 2) == 2
                ;leaving
                if a.IsInFaction(bind_CrowdIsActive)
                    a.RemoveFromFaction(bind_CrowdIsActive)
                endif
                return false
            else 
                return true
            endif
        else 
            return true
        endif

    endif

    ;if activeFlag

        ;if !c.IsInFaction(bind_CrowdIsActive)
            ;c.AddToFaction(bind_CrowdIsActive)
            ;c.SetFactionRank(bind_CrowdIsActive, 1)
       ; endif

        ; if think.IsAiReady()
        ;     if Utility.RandomInt(1, 2) == 2 && chatCount < 3
        ;         chatCount += 1
        ;         ; if StringUtil.Find(c.GetDisplayName(), "guard", 0) > -1
        ;         ;     bind_Utility.WriteToConsole("crowds quest - guard " + c.GetDisplayName() + " makes a comment")
        ;         ;     ;think.UseDirectNarration(c, c.GetDisplayName() + " without shame, since this is a common sight in Skyrim, has a lustful or lewd comment about {{ player.name }}'s current situation.")
        ;         ;     SkyrimNetApi.DirectNarration(c.GetDisplayName() + " without shame, since this is a common sight in Skyrim, has a lustful or lewd comment about {{ player.name }}'s current situation.", c)
        ;         ; else
        ;         if Utility.RandomInt(1, 2) == 2 && c != fs.GetDomRef()
        ;             bind_Utility.WriteToConsole("crowds quest - " + c.GetDisplayName() + " chats with dom")
        ;             SkyrimNetApi.DirectNarration(c.GetDisplayName() + " starts a conversation with " + fs.GetDomRef().GetDisplayName() + " about {{ player.name }}'s current situation.", c, fs.GetDomRef())
                    
        ;         else
        ;             bind_Utility.WriteToConsole("crowds quest - " + c.GetDisplayName() + " makes a comment")
        ;             SkyrimNetApi.DirectNarration(c.GetDisplayName() + " makes a comment about {{ player.name }}'s current situation.", c)
        ;         endif
        ;         ;endif
        ;     endif
        ; endif

    ;else
        ;if c.IsInFaction(bind_CrowdIsActive)
    ;        c.SetFactionRank(bind_CrowdIsActive, 2)
            ;c.RemoveFromFaction(bind_CrowdIsActive)
        ;endif
    ;endif
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