Scriptname bind_WordWallQuestDomScript extends ReferenceAlias  

bool sentAbort

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
    
    If aeCombatState == 1

        if !sentAbort
            sentAbort = true
            (GetOwningQuest() as bind_WordWallQuestScript).EmergencyQuestEnd()
        endif

    EndIf

    If aeCombatState == 0

    EndIf

EndEvent