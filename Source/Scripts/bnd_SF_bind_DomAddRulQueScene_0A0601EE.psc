;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname bnd_SF_bind_DomAddRulQueScene_0A0601EE Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
; Actor a = Game.GetPlayer() as Actor

; if !a.IsInFaction(bind_WearingCollarFaction)
;     if bbm.AddBondageItemByType(a, bbm.BONDAGE_TYPE_COLLAR())
;         ;add to faction?
;     endif
; endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
;scene end
int handle = ModEvent.Create("bind_DomRuleSceneCompleted")
if handle
    ModEvent.Send(handle)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
;scene start - REMOVE RULE SCENE
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable property bind_GlobalEventVar2 auto
GlobalVariable property bind_GlobalEventVar3 auto
GlobalVariable property bind_GlobalEventVar4 auto

bind_RulesManager property brm auto
bind_BondageManager property bbm auto

Faction property bind_WearingCollarFaction auto
