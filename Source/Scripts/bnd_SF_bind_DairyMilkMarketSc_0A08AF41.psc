;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bnd_SF_bind_DairyMilkMarketSc_0A08AF41 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;end - dairy milk market scene

;debug.MessageBox("next...")

bind_DairyMilkMarketScript mms = Quest.GetQuest("bind_DairyMilkMarket") as bind_DairyMilkMarketScript
mms.LockSubInFurniture()

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
