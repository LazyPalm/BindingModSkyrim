Scriptname binda_ThePlayerAliasCrosshair extends ReferenceAlias  

Actor me

event OnInit()
    
	RegisterforCrosshairRef()
    me = self.GetActorReference()

endevent

Event OnPlayerLoadGame()

    RegisterforCrosshairRef()
    me = self.GetActorReference()

endevent

auto state ReadyState

    event OnCrosshairRefChange(ObjectReference ref)

        if ref != none

            GoToState("BusyState")

            bind_Utility.WriteToConsole("crosshair - ref: " + ref)

            if TheActivator.GetReference() != ref

                int foundType = ref.GetType()
                if foundType == 61

                    if ref.HasKeywordString("zadc_FurnitureDevice") || ref.HasKeywordString("dse_dm_KeywordFurniture")
                        
                        TheActivator.ForceRefTo(ref)
                        (TheActivator as binda_TheActivatorAlias).AliasChanged(me)
                        bind_Utility.WriteToConsole("filled theactivator ref: " + ref.GetName())

                    elseif ref as TempleBlessingScript

                        TheActivator.ForceRefTo(ref)
                        (TheActivator as binda_TheActivatorAlias).AliasChanged(me)
                        bind_Utility.WriteToConsole("filled theactivator ref: " + ref.GetName())

                    endif

                else

                    ;clear furniture faction
                    if me.IsInFaction(InFurnitureFaction)
                        if me.GetFactionRank(InFurnitureFaction) > 1 ;only do this for ddc/dse furnitures
                            me.RemoveFromFaction(InFurnitureFaction) ;this is added by the activator 
                        endif
                    endif

                endif

            endif

            RegisterForSingleUpdate(1.0)

        endif

    endevent

endstate

state BusyState

    event OnUpdate()

        GoToState("ReadyState")

    endevent

    event OnCrosshairRefChange(ObjectReference ref)

    endevent

endstate

ReferenceAlias property TheActivator auto

Faction property InFurnitureFaction auto