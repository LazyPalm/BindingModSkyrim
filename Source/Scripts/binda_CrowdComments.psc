Scriptname binda_CrowdComments extends Quest  

Actor thePlayer

event OnInit()

    thePlayer = Game.GetPlayer()

    RegisterForModEvent("bind_CycleEvent", "OnBindCycleEvent")

endevent

event OnBindCycleEvent(int cycleCount, int modState)
    debug.Trace("binda_CrowdComments received bind_CycleEvent - Cycle: " + cycleCount + ", State: " + modState)
    ; Add your logic here using the descriptive names
    ;debug.MessageBox("cycle happened...")

    Actor[] list = MiscUtil.ScanCellNPCs(thePlayer) ;ignores dead by default
    int i = 0
    while i < list.Length
        Actor a = list[i]
        if a && !a.IsInFaction(CrowdTypeFaction) 
            if !a.HasKeywordString("ActorTypeChild") && !a.GetRace().IsChildRace() && a != thePlayer
                a.SetFactionRank(CrowdTypeFaction, Utility.RandomInt(1, 4))
                ;1 - neutral
                ;2 - lustful
                ;3 - mocking
                ;4 - pity
                debug.MessageBox("setting type faction a: " + a.GetDisplayName() + " rank: " + a.GetFactionRank(CrowdTypeFaction))
            endif
        endif
        bind_Utility.DoSleep(0.1)
        i += 1
    endwhile

endevent

Faction property CrowdTypeFaction auto

