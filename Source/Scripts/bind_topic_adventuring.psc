;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bind_topic_adventuring Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

bind_PoseManager.StandFromKneeling(Game.GetPlayer())

Quest adventure = Quest.GetQuest("bind_GoAdventuringQuest")
if !adventure.IsRunning()
    adventure.Start()
endif

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
