;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname bnd_SF_bind_DomAddRulQueScene_0A0601EF Extends Scene Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
;phase 2 start

;can we put a UI menu inside of a scene??? for getting user input?? will it pause or blow it up?
;then have it trigger player dialogue responses and branching (you are getting a new rule -> menu: OK, Hell no -> selects OK -> I enjoy new rules. thank you mistress!)

;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE

;start - ADD RULE SCENE

;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE

;phase 2


;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE

;end
int handle = ModEvent.Create("bind_DomRuleSceneCompleted")
if handle
    ModEvent.Send(handle)
endif

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable property bind_GlobalEventVar2 auto
GlobalVariable property bind_GlobalEventVar3 auto
GlobalVariable property bind_GlobalEventVar4 auto

bind_RulesManager property brm auto