;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname bind_scene_apothecary_strip Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;scene dom to apothecary - strip sub
; (GetOwningQuest() as bind_MainQuestScript).DomBindSub(true)
; (GetOwningQuest() as bind_MainQuestScript).StripSub(false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
