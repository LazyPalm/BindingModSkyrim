Scriptname binda_TheActivatorAlias extends ReferenceAlias  

Event OnActivate(ObjectReference akActionRef)
    
    ;bind_Utility.WriteToConsole("distance: " + akActionRef.GetDistance(self.GetReference()))

    bind_Utility.WriteToConsole("binda_TheActivatorAlias - activated by: " + akActionRef.GetDisplayName() + " obj: " + self.GetReference())

    ObjectReference obj = self.GetReference()

    Actor a = akActionRef as Actor
    if a && obj
        if obj.HasKeywordString("zadc_FurnitureDevice")
            if !a.IsInFaction(InFurnitureFaction)
                a.SetFactionRank(InFurnitureFaction, 2)
            endif
        endif
        if obj.HasKeywordString("dse_dm_KeywordFurniture")
            if !a.IsInFaction(InFurnitureFaction)
                a.SetFactionRank(InFurnitureFaction, 3)
            endif
        endif
    endif

EndEvent

Faction property InFurnitureFaction auto