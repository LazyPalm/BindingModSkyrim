Scriptname binda_EventDanceTheSubAlias extends ReferenceAlias  

Event OnPlayerLoadGame()
    (GetOwningQuest() as binda_EventDance).LoadGame()
endevent
