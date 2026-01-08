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

        Quest qold = Quest.GetQuest("bind_MainQuest")
        if qold == none

            ;normal start of this quest

            usedHireling = false
            addAsDom = false
            noBuyer = false

            bindc_Util.FadeOutApplyNoDisable("I am being moved to a new location...")

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

            ;Game.SetPlayerAIDriven(true)
            bindc_Util.DisablePlayer(true)

            MoveSubs()

            if foundDom
                dom.MoveTo(dancer)
            endif

            Utility.Wait(2.0)

            UndressParty()

            SecureSubs()

            bindc_Util.DisablePlayer(true)

            bindc_Util.FadeOutRemoveNoDisable()

            bindc_SimpleSlaveryGetSlaveScene.Start()

            ;Game.SetPlayerAIDriven(false)

        else

            ;using the esl
            Quest qs = Quest.GetQuest("BindingSlaveStart")
            qs.Start()

            self.Stop()

        endif

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

    int bondageOutfitId = data_script.BondageScript.GetBondageOutfitForEvent(sub, "event_simple_slavery_in_furniture") 
    if bondageOutfitId > -1
        data_script.BondageScript.EquipBondageOutfit(sub, bondageOutfitId)
    endif

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

    int[] randomList = bindc_SKSE.GetRandomNumbers(1, 4, 4)

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

    bindc_SKSE.DoStripActor(sub, false)
    LockInFurniture(sub, randomList[3])

endfunction

bool function FindDom()

    bool result = false

    if sub.IsInFaction(data_script.MainScript.bindc_SubFaction)
        ;already a binding sub
        dom = StorageUtil.GetFormValue(none, "bindc_dom") as Actor
        result = true
    else
        ;see if any future doms have been set
        Form[] list = StorageUtil.FormListToArray(none, "bindc_future_doms")
        if list.Length == 0
            ;use a hireling
            int femaleFallback = StorageUtil.GetIntValue(none, "bindc_event_ss_female_hirelings", 1)
            int maleFallback = StorageUtil.GetIntValue(none, "bindc_event_ss_male_hirelings", 1)

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

    bindc_Util.FadeOutApplyNoDisable()

    zbfSlot slot = zbfBondageShell.GetApi().FindPlayer()
    slot.SetFurniture(none)

    int bondageOutfitId = data_script.BondageScript.GetBondageOutfitForEvent(sub, "event_simple_slavery") 
    if bondageOutfitId > -1
        data_script.BondageScript.EquipBondageOutfit(sub, bondageOutfitId)
    endif

    bindc_Util.FadeOutRemoveNoDisable()

    bindc_Util.DoSleep(3.0)
    
    ;start move to office scene
    bindc_SimpleSlaveryWalkToOfficeScene.Start()

endfunction

function WalkToOfficeSceneEnded()

    ;debug.MessageBox("it ended...")

    bindc_Util.FadeOutApplyNoDisable()

    int bondageOutfitId = data_script.BondageScript.GetBondageOutfitForEvent(sub, "event_simple_slavery_in_furniture") 
    if bondageOutfitId > -1
        data_script.BondageScript.EquipBondageOutfit(sub, bondageOutfitId)
    endif

    bindc_Util.DoSleep(2.0)

    zbfSlot slot = zbfBondageShell.GetApi().FindPlayer()
    slot.SetFurniture(dancer)

    bindc_Util.FadeOutRemoveNoDisable()

    bindc_Util.DoSleep(3.0)

    bindc_SimpleSlaveryPaymentScene.Start()

endfunction

function PaymentSceneEnded()

    bindc_Util.FadeOutApplyNoDisable()

    zbfSlot slot = zbfBondageShell.GetApi().FindPlayer()
    slot.SetFurniture(none)

    bindc_Util.DoSleep(2.0)

    FreeSubs()

    DressSubs()

    if addAsDom
        MakeFollower()
        bindc_Util.DoSleep(1.0)
        SetDom(dom)

    endif

    int bondageOutfitId = data_script.BondageScript.GetBondageOutfitForEvent(sub, "event_simple_slavery") 
    if bondageOutfitId > -1
        data_script.BondageScript.EquipBondageOutfit(sub, bondageOutfitId)
    endif

    bindc_Util.FadeOutRemoveNoDisable()

    bindc_Util.DoSleep(3.0)

    ;Game.SetPlayerAIDriven(false)
    bindc_Util.EnablePlayer(true)

    bindc_Util.WriteInternalMonologue("I can leave this place, but will I be free again?")

endfunction

function FreeSubs()

    if Follower1.GetActorReference() != none
        if Follower1.GetActorReference() != dom
            zbfSlot slot = zbfBondageShell.GetApi().SlotActor(Follower1.GetActorReference())
            slot.SetFurniture(none)
            bindc_Util.DoSleep(1.0)
            Follower1.GetActorReference().MoveTo(bindc_SimpleSlaveryRoomHeadingMarker)
        endif
    endif

    if Follower2.GetActorReference() != none
        if Follower2.GetActorReference() != dom
            zbfSlot slot = zbfBondageShell.GetApi().SlotActor(Follower2.GetActorReference())
            slot.SetFurniture(none)
            bindc_Util.DoSleep(1.0)
            Follower2.GetActorReference().MoveTo(bindc_SimpleSlaveryRoomHeadingMarker)
        endif
    endif

    if Follower3.GetActorReference() != none
        if Follower3.GetActorReference() != dom
            zbfSlot slot = zbfBondageShell.GetApi().SlotActor(Follower3.GetActorReference())
            slot.SetFurniture(none)
            bindc_Util.DoSleep(1.0)
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

function SetDom(Actor d)

    ;TODO - move this to utility??
  
    StorageUtil.SetFormValue(none, "bindc_dom", d)
    StorageUtil.SetFormValue(none, "bindc_future_dom", none)

	ActorBase domActorBase = d.GetActorBase()

    StorageUtil.SetStringValue(none, "bindc_dom_name", domActorBase.GetName())
    
    int sex = domActorBase.GetSex()
    StorageUtil.SetStringValue(none, "bindc_dom_sex", sex)

    string existingTitle = StorageUtil.GetStringValue(none, "bindc_dom_title", "")

	if existingTitle == "Mistress" || existingTitle == "Master" || existingTitle == "" ;NOTE - only toggle this if the user has not set a custom title
		If sex == 1
			StorageUtil.SetStringValue(none, "bindc_dom_title", "Mistress")
		Else
			StorageUtil.SetStringValue(none, "bindc_dom_title", "Master")
		EndIf
	endif

	if !sub.IsInFaction(bindc_SubFaction)
		sub.AddToFaction(bindc_SubFaction)
	endif

    if !dom.IsInFaction(bindc_DomFaction)
        dom.addToFaction(bindc_DomFaction)
    endif

endfunction

ObjectReference property bindc_SimpleSlaveryRoomHeadingMarker auto

ReferenceAlias property MaleHireling auto
ReferenceAlias property FemaleHireling auto
ReferenceAlias property TheDom auto

Faction property PotentialFollowerFaction auto
Faction property bindc_SubFaction auto
Faction property bindc_DomFaction auto

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

bindc_Data property data_script auto