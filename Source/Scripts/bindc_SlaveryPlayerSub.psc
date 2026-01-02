Scriptname bindc_SlaveryPlayerSub extends ReferenceAlias  

int foodEaten
int spellsLearned

Actor a

event OnInit()
    if GetOwningQuest().IsRunning()
        LoadGame()
    endif
endevent

event OnPlayerLoadGame()
    LoadGame()
    (GetOwningQuest() as bindc_Slavery).LoadGame()
endevent

function LoadGame()

    if a == none
        a = self.GetActorReference()
    endif

    RegisterForSleep()
    RegisterforCrosshairRef()

	foodEaten = Game.queryStat("Food Eaten")
	spellsLearned = Game.queryStat("Spells Learned")

endfunction

event OnCrosshairRefChange(ObjectReference ref)

    ; if ref.GetBaseObject() As Door
    ;     debug.MessageBox("door: " + ref)
    ; endif

endevent

event OnLocationChange(Location akOldLoc, Location akNewLoc)

	if akNewLoc.HasKeyword(LocTypePlayerHouse) || akNewLoc.HasKeyWord(LocTypeInn) || akNewLoc.HasKeyword(LocTypeCity) || akNewLoc.HasKeyword(LocTypeTown) || akNewLoc.HasKeyWord(LocTypeStore) || akNewLoc.HasKeyWord(LocTypeDwelling) || akNewLoc.HasKeyWord(LocTypeCastle) || akNewLoc.HasKeyWord(LocTypeHouse)
		;safe area
		StorageUtil.SetIntValue(none, "bindc_safe_area", 2)
	else
		;dangerous areaa
		StorageUtil.SetIntValue(none, "bindc_safe_area", 1)
	endif

    bindc_Slavery sl = GetOwningQuest() as bindc_Slavery
    sl.ProcessLocationChange(akOldLoc, akNewLoc)

endevent

event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)

endevent

event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)

endevent

event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
    GotoState("ProcessingOnItemRemoved")

    bindc_Rules r = data_script.RulesScript

    If akBaseItem as book
        int spellsLearnedNow = Game.queryStat("Spells Learned")
        If spellsLearnedNow > spellsLearned
            If r.GetBehaviorRule(a, r.BEHAVIOR_RULE_ASK_READ_SCROLL)  == 1
                If StorageUtil.GetIntValue(a, "bindc_has_read_scroll_permission", 0) == 0
                    bindc_Util.MarkInfraction("I didn't ask to study " + akBaseItem.GetName())
                Else
                    ;OK
                    StorageUtil.SetIntValue(a, "bindc_has_read_scroll_permission", 0)
                EndIf
            EndIf
            spellsLearned = spellsLearnedNow
        EndIf
    EndIf

    If akBaseItem as potion
        Potion food = akBaseItem as Potion

        If food.IsFood()

            int foodEatenNow = Game.queryStat("Food Eaten")

            If foodEatenNow > foodEaten

                bool isLiquid = false
                If food.GetUseSound() == ITMPotionUse
                    isLiquid = true
                EndIf

                bool failed = false
                If r.GetBehaviorRule(a, r.BEHAVIOR_RULE_FOOD_ASK)  == 1
                    If r.BehaviorFoodRuleMustAskPermission == 0
                        failed = true
                        If isLiquid
                            bindc_Util.MarkInfraction("I forgot to ask to drink the " + akBaseItem.GetName())
                        Else
                            bindc_Util.MarkInfraction("I forgot to ask to eat the " + akBaseItem.GetName())
                        EndIf
                    Else
                        ;OK
                    EndIf
                Else
                    ;OK
                EndIf

                If !failed ;no need to double mark points
                    If r.GetBehaviorRule(a, r.BEHAVIOR_RULE_FOOD_SIT_ON_FLOOR) == 1 
                        If StorageUtil.GetIntValue(a, "bindc_pose", 0) == 20
                            ;OK
                        Else
                            bindc_Util.MarkInfraction("I must be sitting on the ground to eat")
                        EndIf
                    EndIf
                EndIf

                foodEaten = foodEatenNow

            EndIf

        
        EndIf
    
    EndIf

    GoToState("")
endevent

state ProcessingOnItemRemoved
	Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	endevent
endstate

event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)

endevent

event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)

endevent

event OnSleepStop(bool abInterrupted)
    bindc_Rules r = data_script.RulesScript
	If r.GetBehaviorRule(a, r.BEHAVIOR_RULE_NO_BED) == 1 ; rman.GetBehaviorRuleByName("Indoors Rule:No Beds") == 1 ;&& !EvHelpIsRunning()
        bindc_Util.MarkInfraction("I broke the no beds rule...")
	EndIf
endevent

bindc_Data property data_script auto

Form property ITMPotionUse auto

Keyword property LocTypePlayerHouse auto
Keyword property LocTypeInn auto
Keyword property LocTypeCity auto
Keyword property LocTypeTown auto
Keyword property LocTypeStore auto
Keyword property LocTypeDwelling auto
Keyword property LocTypeCastle auto
Keyword property LocTypeHouse auto