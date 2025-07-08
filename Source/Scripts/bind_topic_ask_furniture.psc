;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bind_topic_ask_furniture Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;sub asking to be put in furniture

;(GetOwningQuest() as bind_MainQuestScript).SubAsksForFuniture()

bind_PoseManager.StandFromKneeling(Game.GetPlayer())

bind_EventPutOnDisplayQuest.Start()

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest property bind_EventPutOnDisplayQuest auto
Faction property bind_KneelingFaction auto