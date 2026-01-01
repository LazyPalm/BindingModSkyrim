;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SF_bindc_Slavery_Scene_DomTo_08006F4E Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
bindc_Slavery sqs = GetOwningQuest() as bindc_Slavery
(sqs.TheConversationTarget.GetReference() as Actor).Activate(Game.GetPlayer())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
