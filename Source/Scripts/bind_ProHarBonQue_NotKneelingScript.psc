;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bind_ProHarBonQue_NotKneelingScript Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

Actor theSub = Game.GetPlayer()

;maybe use this for a more harsh gag in the harshbondage quest??
int gaggedForNotKneeling = StorageUtil.GetIntValue(theSub, "gagged_for_not_kneeling", 1)

int ruleInfractionForNotKneeling = StorageUtil.GetIntValue(theSub, "rule_infraction_for_not_kneeling", 1)

if ruleInfractionForNotKneeling == 1
    fs.MarkSubBrokeRule("I must kneel to speak...")
endif

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

bind_Functions property fs auto
