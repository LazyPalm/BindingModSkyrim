Scriptname bindc_SimpleSlaveryQuest extends Quest  

Actor sub
Actor dom

ObjectReference[] foundFurniture
Actor[] partyList

bool usedHireling
bool addAsDom
bool noBuyer

event OnInit()

    if self.IsRunning()

        usedHireling = false
        addAsDom = false
        noBuyer = false

        bind_Utility.FadeOutApplyNoDisable("I am being moved to a new location...")

        SetStage(10)

        bindc_GlobalPlaySceneVar.SetValue(1)
        HoldingCellDoor.SetOpen(false)

        bool foundDom = true
        sub = Game.GetPlayer()
        ;scan for npcs followers around sub when this starts
        ;partyList = MiscUtil.ScanCellNPCsByFaction(PotentialFollowerFaction, sub, 2000.0)

        if !FindDom()
            foundDom = false
            noBuyer = true
            bindc_GlobalPlaySceneVar.SetValue(2)
        endif

        Game.SetPlayerAIDriven(true)

        MoveSubs()

        if foundDom
            dom.MoveTo(dancer)
        endif

        Utility.Wait(2.0)

        UndressParty()

        SecureSubs()

        bind_Utility.FadeOutRemoveNoDisable()

        bindc_SimpleSlaveryGetSlaveScene.Start()

        ;Game.SetPlayerAIDriven(false)

    endif

endevent

function MoveSubs()

    sub.MoveTo(bindc_SimpleSlaveryRoomHeadingMarker)

    if Follower1.GetActorReference() != none
        Follower1.GetActorReference().MoveTo(bindc_SimpleSlaveryRoomHeadingMarker)
    endif

    if Follower2.GetActorReference() != none
        Follower2.GetActorReference().MoveTo(bindc_SimpleSlaveryRoomHeadingMarker)
    endif

    if Follower3.GetActorReference() != none
        Follower3.GetActorReference().MoveTo(bindc_SimpleSlaveryRoomHeadingMarker)
    endif

endfunction

function UndressParty()

    int bondageOutfitId = bind_Utility.PriApiGetBondageOutfitId("event_simple_slavery_in_furniture")
    ;debug.MessageBox(bondageOutfitId)

    if Follower1.GetActorReference() != none
        if Follower1.GetActorReference() != dom
            (Follower1 as bindc_NpcControl).StripMe()
        endif
    endif

    if Follower2.GetActorReference() != none
        if Follower2.GetActorReference() != dom
            (Follower2 as bindc_NpcControl).StripMe()
        endif
    endif

    if Follower3.GetActorReference() != none
        if Follower3.GetActorReference() != dom
            (Follower3 as bindc_NpcControl).StripMe()
        endif
    endif

    bind_Utility.PriApiEquipBondageOutfit(sub, bondageOutfitId)
    ;bind_SkseFunctions.DoStripActor(sub, false)

endfunction

function LockInFurniture(Actor a, int i)

    zbfSlot slot

    if a == Game.GetPlayer()
        slot = zbfBondageShell.GetApi().FindPlayer()
    else
        slot = zbfBondageShell.GetApi().SlotActor(a)
    endif

    if i == 1
        a.MoveTo(pole1)
        slot.SetFurniture(pole1)
    elseif i == 2
        a.MoveTo(pole2)
        slot.SetFurniture(pole2)
    elseif i == 3
        a.MoveTo(pole3)
        slot.SetFurniture(pole3)
    elseif i == 4
        a.MoveTo(pole4)
        slot.SetFurniture(pole4)
    endif

endfunction

function SecureSubs()

    int[] randomList = bind_SkseFunctions.GetRandomNumbers(1, 4, 4)

    if Follower1.GetActorReference() != none
        if Follower1.GetActorReference() != dom
            LockInFurniture(Follower1.GetActorReference(), randomList[0])
        endif
    endif

    if Follower2.GetActorReference() != none
        if Follower2.GetActorReference() != dom
            LockInFurniture(Follower2.GetActorReference(), randomList[1])
        endif
    endif

    if Follower3.GetActorReference() != none
        if Follower3.GetActorReference() != dom
            LockInFurniture(Follower3.GetActorReference(), randomList[2])
        endif
    endif

    bind_SkseFunctions.DoStripActor(sub, false)
    LockInFurniture(sub, randomList[3])

endfunction

bool function FindDom()

    bool result = false

    ; Quest q = Quest.GetQuest("bind_MainQuest")
    ; bind_MainQuestScript mqs = q as bind_MainQuestScript
    ; bind_Functions fs = q as bind_Functions

    if bind_Utility.PriApiPlayerIsSub()
        ;already a binding sub
        dom = bind_Utility.PriApiGetDom()
        result = true
    else
        ;see if any future doms have been set
        Form[] list = StorageUtil.FormListToArray(sub, "bind_future_doms")
        if list.Length == 0
            ;use a hireling
            int femaleFallback = bind_Utility.PriApiVariable("SimpleSlaveryFemaleFallback")
            int maleFallback = bind_Utility.PriApiVariable("SimpleSlaveryMaleFallback")

            ;debug.MessageBox("femaleFallback: " + femaleFallback + " maleFallback: " + maleFallback)

            if femaleFallback == 1 && maleFallback == 1
                if Utility.RandomInt(1, 2) == 1
                    dom = MaleHireling.GetActorReference()
                else
                    dom = FemaleHireling.GetActorReference()
                endif
                result = true
            elseif femaleFallback == 1 && maleFallback == 0
                ;debug.MessageBox("in here??")
                dom = FemaleHireling.GetActorReference()
                result = true
            elseif maleFallback == 1 && femaleFallback == 0
                dom = MaleHireling.GetActorReference()
                result = true
            endif

            ;debug.MessageBox(dom)

            if result
                addAsDom = true
                usedHireling = true
            endif

        else 
            ;selected a future dom
            dom = list[Utility.RandomInt(0, list.Length - 1)] as Actor
            result = true
            addAsDom = true
        endif

    endif

    if result
        TheDom.ForceRefTo(dom)
    endif

    return result

endfunction

function GetSubSceneEnded()
    ;debug.MessageBox("ended...")

    bind_Utility.FadeOutApplyNoDisable()

    zbfSlot slot = zbfBondageShell.GetApi().FindPlayer()
    slot.SetFurniture(none)

    int bondageOutfitId = bind_Utility.PriApiGetBondageOutfitId("event_simple_slavery")
    bind_Utility.PriApiEquipBondageOutfit(sub, bondageOutfitId)

    bind_Utility.FadeOutRemoveNoDisable()

    bind_Utility.DoSleep(3.0)
    
    ;start move to office scene
    bindc_SimpleSlaveryWalkToOfficeScene.Start()

endfunction

function WalkToOfficeSceneEnded()

    ;debug.MessageBox("it ended...")

    bind_Utility.FadeOutApplyNoDisable()

    int bondageOutfitId = bind_Utility.PriApiGetBondageOutfitId("event_simple_slavery_in_furniture")
    bind_Utility.PriApiEquipBondageOutfit(sub, bondageOutfitId)

    bind_Utility.DoSleep(2.0)

    zbfSlot slot = zbfBondageShell.GetApi().FindPlayer()
    slot.SetFurniture(dancer)

    bind_Utility.FadeOutRemoveNoDisable()

    bind_Utility.DoSleep(3.0)

    bindc_SimpleSlaveryPaymentScene.Start()

endfunction

function PaymentSceneEnded()

    bind_Utility.FadeOutApplyNoDisable()

    zbfSlot slot = zbfBondageShell.GetApi().FindPlayer()
    slot.SetFurniture(none)

    bind_Utility.DoSleep(2.0)

    FreeSubs()

    DressSubs()

    if addAsDom
        MakeFollower()
        bind_Utility.DoSleep(1.0)
        bind_Utility.PriApiSetDom(dom)
    endif

    int bondageOutfitId = bind_Utility.PriApiGetBondageOutfitId("event_simple_slavery")
    bind_Utility.PriApiEquipBondageOutfit(sub, bondageOutfitId)

    bind_Utility.FadeOutRemoveNoDisable()

    bind_Utility.DoSleep(3.0)

    Game.SetPlayerAIDriven(false)

    bind_Utility.WriteInternalMonologue("I can leave this place, but will I be free again?")

endfunction

function FreeSubs()

    if Follower1.GetActorReference() != none
        if Follower1.GetActorReference() != dom
            zbfSlot slot = zbfBondageShell.GetApi().SlotActor(Follower1.GetActorReference())
            slot.SetFurniture(none)
            bind_Utility.DoSleep(1.0)
            Follower1.GetActorReference().MoveTo(bindc_SimpleSlaveryRoomHeadingMarker)
        endif
    endif

    if Follower2.GetActorReference() != none
        if Follower2.GetActorReference() != dom
            zbfSlot slot = zbfBondageShell.GetApi().SlotActor(Follower2.GetActorReference())
            slot.SetFurniture(none)
            bind_Utility.DoSleep(1.0)
            Follower2.GetActorReference().MoveTo(bindc_SimpleSlaveryRoomHeadingMarker)
        endif
    endif

    if Follower3.GetActorReference() != none
        if Follower3.GetActorReference() != dom
            zbfSlot slot = zbfBondageShell.GetApi().SlotActor(Follower3.GetActorReference())
            slot.SetFurniture(none)
            bind_Utility.DoSleep(1.0)
            Follower3.GetActorReference().MoveTo(bindc_SimpleSlaveryRoomHeadingMarker)
        endif
    endif

endfunction

; function MoveSubsToHoldingArea()

;     if Follower1.GetActorReference() != none
;         if Follower1.GetActorReference() != dom
;             Follower1.GetActorReference().MoveTo(bindc_SimpleSlaveryRoomHeadingMarker)
;         endif
;     endif

;     if Follower2.GetActorReference() != none
;         if Follower2.GetActorReference() != dom
;             Follower2.GetActorReference().MoveTo(bindc_SimpleSlaveryRoomHeadingMarker)
;         endif
;     endif

;     if Follower3.GetActorReference() != none
;         if Follower3.GetActorReference() != dom
;             Follower3.GetActorReference().MoveTo(bindc_SimpleSlaveryRoomHeadingMarker)
;         endif
;     endif

; endfunction

function DressSubs()

    if Follower1.GetActorReference() != none
        if Follower1.GetActorReference() != dom
            (Follower1 as bindc_NpcControl).DressMe()
        endif
    endif

    if Follower2.GetActorReference() != none
        if Follower2.GetActorReference() != dom
            (Follower2 as bindc_NpcControl).DressMe()
        endif
    endif

    if Follower3.GetActorReference() != none
        if Follower3.GetActorReference() != dom
            (Follower3 as bindc_NpcControl).DressMe()
        endif
    endif

endfunction

function LocationChanged()
    ; debug.MessageBox("location changed")
    ; if readyToEnd
    ;     debug.MessageBox("ending??")
    ;     RegisterForSingleUpdate(10.0)
    ; endif
endfunction

function UsedDoorToExit()
    RegisterForSingleUpdate(10.0)
endfunction

event OnUpdate()
    EndQuest()
endevent

function MakeFollower()

    if usedHireling == true
        HirelingQuest hq = Quest.GetQuest("HirelingQuest") as HirelingQuest
	    hq.HasHirelingGV.Value=1
    	dom.AddToFaction(hq.CurrentHireling)
    endif

    DialogueFollowerScript dfs = Quest.GetQuest("DialogueFollower") as DialogueFollowerScript
    dfs.SetFollower(dom)

endfunction

function EndQuest()

    if noBuyer
        debug.MessageBox("Your missing buyer has provided you with a chance at freedom. Find a blacksmith to remove these chains.")
    endif

    SetStage(20)

    self.Stop()

    ;debug.MessageBox("this happen?")

endfunction

ObjectReference property bindc_SimpleSlaveryRoomHeadingMarker auto

ReferenceAlias property MaleHireling auto
ReferenceAlias property FemaleHireling auto
ReferenceAlias property TheDom auto

Faction property PotentialFollowerFaction auto

ObjectReference property pole1 auto
ObjectReference property pole2 auto
ObjectReference property pole3 auto
ObjectReference property pole4 auto
ObjectReference property dancer auto

ReferenceAlias property Follower1 auto
ReferenceAlias property Follower2 auto
ReferenceAlias property Follower3 auto

ObjectReference property HoldingCellDoor auto

Scene property bindc_SimpleSlaveryGetSlaveScene auto
Scene property bindc_SimpleSlaveryWalkToOfficeScene auto
Scene property bindc_SimpleSlaveryPaymentScene auto

GlobalVariable property bindc_GlobalPlaySceneVar auto