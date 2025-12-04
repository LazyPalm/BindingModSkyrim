Scriptname bind_DefeatedQuestSubScript extends ReferenceAlias

bool cheatDeath
bool testHealth

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, \
	bool abBashAttack, bool abHitBlocked)

    Actor theSub = self.GetReference() as Actor

    if !testHealth
        testHealth = true
        if StorageUtil.GetIntValue(theSub, "bind_has_future_dom", 0) == 1

            float baseHealthValue = theSub.GetBaseActorValue("Health")
            float healthValue = theSub.GetActorValue("Health")		
            If (healthValue < (baseHealthValue / 2.0)) && (healthValue > 0) 
                If !cheatDeath
                    cheatDeath = true
                    (GetOwningQuest() as bind_DefeatedQuestScript).PlayerIsDown()
                EndIf
            EndIf

        endif
        testHealth = false
    endif

    ;bind_Utility.WriteToConsole("defeat quest sub script hit by: " + akProjectile)

EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
    
    bool isIndoors = self.GetActorReference().IsInInterior()
    if !isIndoors
        StorageUtil.SetFormValue(self.GetActorReference(), "bind_defeat_last_loc", akNewLoc)
    endif

    cheatDeath = false
endevent
