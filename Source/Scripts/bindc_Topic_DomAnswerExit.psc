;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bindc_Topic_DomAnswerExit Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

;ask to leave
(GetOwningQuest() as bindc_Slavery).GrantExitPermission()
; Quest q = Quest.GetQuest("bindc_MainQuest")
; bindc_Rules rm = q as bindc_Rules

; rm.BehaviorEnterExitRuleInnPermission = 0
; rm.BehaviorEnterExitRuleCastlePermission = 0
; rm.BehaviorEnterExitRulePlayerHomePermission = 0

; if rm.BehaviorEnterExitRuleCurrentLocationType == rm.DESTINATION_TYPE_INN
;     rm.BehaviorEnterExitRuleInnPermission = 1
; elseif rm.BehaviorEnterExitRuleCurrentLocationType == rm.DESTINATION_TYPE_CASTLE
;     rm.BehaviorEnterExitRuleCastlePermission = 1
; elseif rm.BehaviorEnterExitRuleCurrentLocationType == rm.DESTINATION_TYPE_PLAYERHOME
;     rm.BehaviorEnterExitRulePlayerHomePermission = 1
; endif

; bindc_Util.WriteInternalMonologue("I have permission to leave...")

;bind_PoseManager.StandFromKneeling(Game.GetPlayer())


;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
