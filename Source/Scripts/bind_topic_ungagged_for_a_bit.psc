;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bind_topic_ungagged_for_a_bit Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;dialog ask to be temp ungagged
;(GetOwningQuest() as bind_MainQuestScript).UngagedForABit()

bind_PoseManager.StandFromKneeling(Game.GetPlayer())

bind_UngaggedForNeedsQuest.Start()

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Faction property bind_KneelingFaction auto
Quest property bind_UngaggedForNeedsQuest auto