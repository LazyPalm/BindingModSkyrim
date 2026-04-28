Scriptname binda_Dance extends Quest  

function EndDance()

    ;Quest mq = Game.GetFormFromFile(0x0012C2, "ArcaneSexbotBDSM.esm") as Quest

    Alias[] crowd = self.GetAliases()

    ;debug.MessageBox(crowd)

    int i = 0
    while i < crowd.Length
        binda_DanceQuestCrowdNpc c = crowd[i] as binda_DanceQuestCrowdNpc
        if c
            c.EndDance()
        endif
        i += 1
    endwhile

    self.Stop()

    ;debug.MessageBox("ending the dancing quest...")

endfunction