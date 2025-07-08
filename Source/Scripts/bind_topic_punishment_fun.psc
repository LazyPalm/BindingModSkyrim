;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bind_topic_punishment_fun Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

;(GetOwningQuest() as bind_MainQuestScript).WhipSub(false)

bind_PoseManager.StandFromKneeling(Game.GetPlayer())

bind_WhippingQuest.Start()

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest property bind_WhippingQuest auto
Faction property bind_KneelingFaction auto
