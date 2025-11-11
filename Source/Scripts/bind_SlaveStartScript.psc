Scriptname bind_SlaveStartScript extends Quest  

Actor theSub
Actor theDom

event OnInit()

    if self.IsRunning()
        
        theSub = Game.GetPlayer()

        Quest q = Quest.GetQuest("bind_MainQuest")
        mqs = q as bind_MainQuestScript
        fs = q as bind_Functions

        if !FindDom()
            debug.MessageBox("You never laid eyes on a worthy dominant.")
            self.Stop()
        endif

        MovePlayerToDom()

        self.Stop()

    endif

endevent

function MovePlayerToDom()

   	Game.EnableFastTravel()
	Game.FastTravel(theDom)

endfunction

bool function FindDom()

    bool result = false

    if mqs.IsSub == 1
        ;already a binding sub
        theDom = fs.GetDomRef()
        result = true
    else
        ;see if any future doms have been set
        Form[] list = StorageUtil.FormListToArray(theSub, "bind_future_doms")
        if list.Length == 0
            ;get followers


        else 
            ;selected a future dom
            theDom = list[Utility.RandomInt(0, list.Length - 1)] as Actor
            result = true
        endif

    endif

    if result
        TheDomRef.ForceRefTo(theDom)
    endif

    return result

endfunction

bind_MainQuestScript mqs
bind_Functions fs

ReferenceAlias property TheDomRef auto

FormList property bind_SafeLocationsList auto

Activator property zadc_RestraintPost auto
Activator property zadc_BondagePole auto

Faction property bind_ForceGreetFaction auto