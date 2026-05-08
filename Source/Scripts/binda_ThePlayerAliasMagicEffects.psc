Scriptname binda_ThePlayerAliasMagicEffects extends ReferenceAlias  

; auto state ReadyState

;     event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
        
;         GoToState("BusyState")
        
;         if akEffect.HasKeyword(Keyword.GetKeyword("MagicBlessing"))
;             GoToState("PrayedAtShrineState")
;         endif

;         RegisterForSingleUpdate(1.0)

;     endEvent

; endstate

; state PrayedAtShrineState

;     event OnUpdate()

;         ; Quest q = Quest.GetQuest("binda_RulesBlessingQuest")
;         ; if q 
;         ;     if !q.IsRunning()
;         ;         q.Start()
;         ;     endif
;         ; endif

;         GoToState("ReadyState")

;     endevent

;     event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)

;     endevent

; endstate

; state BusyState

;     event OnUpdate()

;         GoToState("ReadyState")

;     endevent

;     event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)

;     endevent

; endstate