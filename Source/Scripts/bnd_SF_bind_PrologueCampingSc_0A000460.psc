;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bnd_SF_bind_PrologueCampingSc_0A000460 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;completed bind_prologuecampingscene

bind_PrologueCamping camp = Quest.GetQuest("bind_PrologueCampingQuest") as bind_PrologueCamping
camp.StartTheQuest()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
