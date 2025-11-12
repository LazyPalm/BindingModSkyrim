Scriptname bind_SlaveStartScript extends Quest  

Actor theSub
Actor theDom

int usedHireling = 0

event OnInit()

    if self.IsRunning()
        
        theSub = Game.GetPlayer()

        Quest q = Quest.GetQuest("bind_MainQuest")
        mqs = q as bind_MainQuestScript
        fs = q as bind_Functions
        bcs = q as bind_Controller

        FadeToBlackHoldImod.Apply()
        MovePlayer()

        if !FindDom()
            FadeToBlackHoldImod.Remove()
            debug.MessageBox("You never laid eyes on a worthy dominant.")
            self.Stop()
        endif

        bind_Utility.WriteInternalMonologue("I was forced off stage, chained, blindfolded.")
        bind_Utility.WriteInternalMonologue("What will happen to me next?")

        bcs.DoStartEvent()
        bcs.SetEventName(self.GetName())

        if Game.IsPluginInstalled("Follower Slavery Mod.esp")
            if theSub.GetDistance(theDom) < 1000.0 && mqs.IsSub == 1
                ;if they are this close, they got sucked up by follower slavery
                FadeToBlackHoldImod.Remove()
                debug.MessageBox("Representatives from the auction house realized your " + fs.GetDomTitle() + " was not supposed to be in the auction. " + fs.GetDomPronoun(false) + " has been freed and an apology issued for the misunderstanding. You have been rightfully returned to " + fs.GetDomPos(true) + " possession.")          
                bcs.DoEndEvent()
                self.Stop()
            endif
        endif

        MoveDomToPlayer()

        if mqs.IsSub == 1
            debug.MessageBox("You have purchased by " + fs.GetDomRef().GetDisplayName())
            bcs.DoEndEvent()
            self.Stop()
        else
            GetSubReady()
        endif

        FadeToBlackHoldImod.Remove()

    endif

endevent

function MovePlayer()

    theSub.MoveTo(bind_RiftenSlaveExit)
   	Game.EnableFastTravel()
	Game.FastTravel(bind_RiftenSlaveExit)

endfunction

function MoveDomToPlayer()

    theDom.MoveTo(theSub)
    ;theDom.SetPosition(theDom.GetPositionX() + Utility.RandomFloat(-250.0, 250.0), theDom.GetPositionY() + Utility.RandomFloat(-250.0, 250.0), theDom.GetPositionZ() + 100.0) ;adding z in case elevation changes

    ;bind_Utility.DoSleep(3.0)

    ; if !theDom.IsInFaction(bind_ForceGreetFaction)
    ;     theDom.AddToFaction(bind_ForceGreetFaction)
    ; endif

    if !theDom.IsEnabled()
        theDom.Enable()
    endif

endfunction

function GetSubReady()
    fs.EventGetSubReady(theSub, theDom, "event_simple_slavery")
endfunction

function MakeFollower()

    if usedHireling == 1
        HirelingQuest hq = Quest.GetQuest("HirelingQuest") as HirelingQuest
	    hq.HasHirelingGV.Value=1
    	theDom.AddToFaction(hq.CurrentHireling)
    endif

    DialogueFollowerScript dfs = Quest.GetQuest("DialogueFollower") as DialogueFollowerScript
    dfs.SetFollower(theDom)

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
            ;use a hireling
            if mqs.SimpleSlaveryFemaleFallback == 1 && mqs.SimpleSlaveryMaleFallback == 1
                if Utility.RandomInt(1, 2) == 1
                    theDom = MaleHireling.GetActorReference()
                else
                    theDom = FemaleHireling.GetActorReference()
                endif
                result = true
            elseif mqs.SimpleSlaveryFemaleFallback == 1
                theDom = FemaleHireling.GetActorReference()
                result = true
            elseif mqs.SimpleSlaveryMaleFallback == 1
                theDom = MaleHireling.GetActorReference()
                result = true
            endif

            if result
                usedHireling = 1
            endif

            ;debug.MessageBox(f)

            ; debug.MessageBox(mqs.SimpleSlaveryFemaleFallback)
            ; debug.MessageBox(mqs.SimpleSlaveryMaleFallback)
            ; debug.MessageBox(bind_HirelingsList.GetSize())
            


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

function StartBinding()

    MakeFollower()

    fs.SetDom(theDom)

    bcs.DoEndEvent()

    self.Stop()

endfunction

bind_MainQuestScript mqs
bind_Functions fs
bind_Controller bcs

ReferenceAlias property TheDomRef auto

FormList property bind_SafeLocationsList auto

Activator property zadc_RestraintPost auto
Activator property zadc_BondagePole auto

Faction property bind_ForceGreetFaction auto

;FormList property bind_HirelingsList auto

ReferenceAlias property FemaleHireling auto
ReferenceAlias property MaleHireling auto

ObjectReference property bind_RiftenSlaveExit auto

ImageSpaceModifier property FadeToBlackHoldImod auto