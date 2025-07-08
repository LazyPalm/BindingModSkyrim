Scriptname bind_TheDomScript extends ReferenceAlias  

Event OnActivate(ObjectReference akActionRef)
    ;Debug.MessageBox("Activated by " + akActionRef)
    If akActionRef == Game.GetPlayer()
        ;bind_Utility.WriteToConsole("does this happen???")
    EndIf

EndEvent

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
    
    if bind_GlobalModState.GetValue() == 1.0
        
        ;bind_MainQuestScript MQS = (GetOwningQuest() as bind_MainQuestScript)

        ; if (akTarget == Game.GetPlayer())
        ;   if (aeCombatState == 0)
        ;     Debug.Trace("We have left combat!")
        ;   elseif (aeCombatState == 1)
        ;     Debug.Trace("We have entered combat with the player!")
        ;   elseif (aeCombatState == 2)
        ;     Debug.Trace("We are searching for the player...")
        ;   endIf
        ; endIf

        If aeCombatState == 1

            (GetOwningQuest() as bind_MainQuestScript).DomInCombat = 1
        ;     ;Debug.Notification("dom started combat")
        ;     (GetOwningQuest() as bind_MainQuestScript).UntieBoundSubForCombat()
        EndIf

        If aeCombatState == 0
            (GetOwningQuest() as bind_Functions).DirtFromCombat()
            (GetOwningQuest() as bind_MainQuestScript).DomInCombat = 0
        ;     ;Debug.Notification("dom ended combat")
        ;     (GetOwningQuest() as bind_MainQuestScript).BindSubAfterCombat()

        EndIf

    endif

EndEvent

GlobalVariable property bind_GlobalModState auto