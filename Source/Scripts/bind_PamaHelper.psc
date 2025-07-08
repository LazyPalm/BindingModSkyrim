Scriptname bind_PamaHelper   

bool Function CheckValid() Global
    return Game.GetModByName("PamaInteractiveBeatup.esm") != 255
EndFunction

pamaBeatupCore Function GetPamaBeatupCore() Global
    return Quest.GetQuest("pama_PBU") as pamaBeatupCore
Endfunction

bool Function WhipActor(Actor sub, Actor dom, string msg = "", ObjectReference furn = none) Global
    
    bool result = true

    If msg != ""
        Debug.Notification(msg)
    EndIf

    pamaBeatupCore pcore = GetPamaBeatupCore()

    pcore.setWeaponChoice(0)
    pcore.setDurationChoice(0)
    int idx = Utility.RandomInt(1, 2)
    int pcoreResult = pcore.StartVictimSession(sub, idx, true, furn) ;NOTE - furn does not seem to work (check on zaz types)
    
    if pcoreResult == 0 ;not slotted in furniture (not the cancel button)
        result = false
    Else
        pcore.launchHireling(0, dom, true)
    EndIf

    return result

EndFunction

bool Function EndWhipActor(Actor sub) Global

    bool result = true

    pamaBeatupCore pcore = GetPamaBeatupCore()

    pcore.stopHireling()
    pcore.EndVictimSession(sub)

    return result

EndFunction