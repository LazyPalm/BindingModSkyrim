;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SF_bindc_SimpleSlaveryPaymen_0B006AE4 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;payment scene ended

bindc_SimpleSlaveryQuest ssq = GetOwningQuest() as bindc_SimpleSlaveryQuest
ssq.PaymentSceneEnded()

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
