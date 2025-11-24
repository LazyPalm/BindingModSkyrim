;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SF_bindc_SimpleSlaveryWalkTo_0B006ADC Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;end walk to office

bindc_SimpleSlaveryQuest ssq = GetOwningQuest() as bindc_SimpleSlaveryQuest
ssq.WalkToOfficeSceneEnded()

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
