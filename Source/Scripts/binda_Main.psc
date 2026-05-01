Scriptname binda_Main extends Quest  

Actor thePlayer

event OnInit()
    if IsRunning()
        LoadGame()
    endif
endevent

function LoadGame()

    thePlayer = Game.GetPlayer()

    RegisterForModEvent("bind_SetDomModEvent", "SetDom")
    RegisterForModEvent("bind_StartedPosingModEvent", "StartedPose")
    RegisterForModEvent("bind_StoppedPosingModEvent", "StoppedPose")

endfunction

event SetDom(Form dom)

    Actor akDom = dom as Actor
    if akDom
        ;Debug.MessageBox(akDom.GetDisplayName())
        if !akDom.IsInFaction(binda_DomFaction)
            akDom.SetFactionRank(binda_DomFaction, 1)
            thePlayer.SetFactionRank(binda_SubFaction, 1)
            thePlayer.SetFactionRank(binda_PoseFaction, 0)
        endif
    endif

endevent

event StartedPose(int pose)
    if pose > 0
        thePlayer.SetFactionRank(binda_PoseFaction, pose)
    endif
endevent

event StoppedPose()
    thePlayer.SetFactionRank(binda_PoseFaction, 0)
endevent

Faction property binda_DomFaction auto
Faction property binda_SubFaction auto
Faction property binda_PoseFaction auto