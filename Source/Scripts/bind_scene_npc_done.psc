;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bind_scene_npc_done Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;scene dom to nearest npc
; akSpeaker.Activate(Game.GetPlayer())
; (GetOwningQuest() as bind_MainQuestScript).SetDomAI(10) ;hold the dom until the the sub leaves kneeling position (NFF will wander)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
