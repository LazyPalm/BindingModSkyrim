Scriptname bind_FutureDomScript extends ReferenceAlias  

Event OnCombatStateChanged(Actor akTarget, int aeCombatState)
    
    bind_MainQuestScript MQS = (GetOwningQuest() as bind_MainQuestScript)

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
        ;MQS.FutureDom.GetActorReference().SetActorValue("Health", 20000.0)
    EndIf

    If aeCombatState == 0
        ;Debug.MessageBox("dom left combat")

        ; If MQS.SubIdleState == 11 ;IDLE_STATE_WOUNDED_FROM_COMBAT
        ;     ;MQS.GetSubRef().StopCombat()
        ;     ;self.GetActorReference().StopCombat()
        ; EndIf

    EndIf

EndEvent