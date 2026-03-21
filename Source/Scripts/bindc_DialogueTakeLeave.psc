;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname bindc_DialogueTakeLeave Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Faction CurrentFollowerFaction = Game.GetFormFromFile(0x05C84E, "Skyrim.esm") as Faction
if akSpeaker.IsInFaction(CurrentFollowerFaction)
    bindc_Util.WriteInformation(akSpeaker.GetDisplayName() + " is a current follower")
    Quest q = Quest.GetQuest("DialogueFollower")
    if q != none
        (q as DialogueFollowerScript).FollowerWait()
    endif
else 
    bindc_Util.WriteInformation(akSpeaker.GetDisplayName() + " is not a current follower")
endif
(GetOwningQuest() as bindc_Slave).TakeLeave()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
