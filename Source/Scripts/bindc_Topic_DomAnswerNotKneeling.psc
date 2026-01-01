;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bindc_Topic_DomAnswerNotKneeling Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

int gag = StorageUtil.GetIntValue(none, "bindc_setting_kneeling_gagged_when_not", 0)
int infraction = StorageUtil.GetIntValue(none, "bindc_setting_kneeling_infraction_when_not", 0)

if gag == 1
    (GetOwningQuest() as bindc_Slavery).StartGaggedPunishment()
endif

if infraction == 1
    bindc_Util.MarkInfraction("I am not allowed speak to " + bindc_Util.GetDomTitle() + " without kneeling", false)
endif

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
