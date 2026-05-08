Scriptname binda_TheActivatorAlias extends ReferenceAlias  

function AliasChanged(Actor akActor)

    ObjectReference obj = self.GetReference()

    ; if !(obj.HasKeywordString("zadc_FurnitureDevice") || obj.HasKeywordString("dse_dm_KeywordFurniture"))
    ;     if akActor.IsInFaction(InFurnitureFaction)
    ;         if akActor.GetFactionRank(InFurnitureFaction) > 1 ;only do this for ddc/dse furnitures
    ;             akActor.RemoveFromFaction(InFurnitureFaction) ;this is added by the activator 
    ;         endif
    ;     endif
    ; endif

endfunction

event OnActivate(ObjectReference akActionRef)
    
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

        if obj as TempleBlessingScript
            Quest q = Quest.GetQuest("binda_RulesBlessingQuest")
            if q 
                if !q.IsRunning()
                    q.Start()
                endif
            endif
        endif

    endif

endevent

Faction property InFurnitureFaction auto