;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bnd_SF_bind_DairyMilkMarketSc_0A08AF5D Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;end - scene 2 end

bind_DairyMilkMarketScript mms = Quest.GetQuest("bind_DairyMilkMarket") as bind_DairyMilkMarketScript
mms.StartTrade()

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
