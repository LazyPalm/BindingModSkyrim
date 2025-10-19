;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bnd_SF_bind_PrologueWhippingS_0A00045E Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;ending bind_prologuewhippingscene
bind_PrologueWhipping whip = Quest.GetQuest("bind_PrologueWhippingQuest") as bind_PrologueWhipping
whip.StartTheQuest()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
