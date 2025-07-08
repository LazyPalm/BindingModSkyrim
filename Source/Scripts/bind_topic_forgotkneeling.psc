;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bind_topic_forgotkneeling Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

Actor theSub = Game.GetPlayer()

int gaggedForNotKneeling = StorageUtil.GetIntValue(theSub, "gagged_for_not_kneeling", 1)
int ruleInfractionForNotKneeling = StorageUtil.GetIntValue(theSub, "rule_infraction_for_not_kneeling", 1)

if ruleInfractionForNotKneeling == 1
    (GetOwningQuest() as bind_Functions).MarkSubBrokeRule("I must kneel to speak...")
endif

if gaggedForNotKneeling == 1
    bind_EventGagForPunQuest.Start()
endif

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest property bind_EventGagForPunQuest auto

;bind_MainQuestScript property main auto