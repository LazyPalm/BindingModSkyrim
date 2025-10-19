;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bnd_TIF__0A0001A0 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;ask for entry
;(GetOwningQuest() as bind_MainQuestScript).GrantEntryExitPermission(true)

ObjectReference ref = BuildingDoor.GetReference()
if ref
    StorageUtil.SetIntValue(ref, "bind_door_sub_permission", 1)
    StorageUtil.SetFloatValue(ref, "bind_door_sub_permission_end_date", bind_Utility.AddTimeToCurrentTime(0, 30))
endif

bind_Utility.WriteInternalMonologue("I have permission to enter...")

bind_PoseManager.StandFromKneeling(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias property BuildingDoor auto
