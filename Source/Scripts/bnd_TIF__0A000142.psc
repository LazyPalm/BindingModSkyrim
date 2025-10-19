;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bnd_TIF__0A000142 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
bind_Utility.WriteToConsole("start dom conversation...")

; Actor thePlayer = Game.GetPlayer()
; if StorageUtil.GetIntValue(thePlayer, "kneeling_safe_areas_only", 1) == 1 && bind_GlobalSafeZone.GetValue() == 1 ;1 is unsafe area
;     bind_GlobalKneelingOK.SetValue(1.0)
; endif

if !bind_KneelingQuest.IsRunning()
    bind_KneelingQuest.Start()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest property bind_KneelingQuest auto
GlobalVariable property bind_GlobalSafeZone auto
GlobalVariable property bind_GlobalKneelingOK auto
