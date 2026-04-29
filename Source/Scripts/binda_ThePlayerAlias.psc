Scriptname binda_ThePlayerAlias extends ReferenceAlias  

bool lookedAtFurniture
bool processingCrosshair

Actor me

event OnInit()
	RegisterforCrosshairRef()
    me = self.GetActorReference()
    RegisterForAnimationEvent(self.GetReference(), "IdleStop") 
endevent

Event OnPlayerLoadGame()
    RegisterforCrosshairRef()
    me = self.GetActorReference()
    RegisterForAnimationEvent(self.GetReference(), "IdleStop") 
endevent

bool restartDance = false

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
    if (asEventName == "IdleStop")
        if StorageUtil.GetIntValue(me, "bind_dancing", 0) == 1            
            restartDance = true
            bind_Utility.WriteNotification(me.GetDisplayName() + " wants to dance again...", bind_Utility.TextColorRed())
            RegisterForSingleUpdate(3.0)
        endif
    endif
EndEvent

event OnUpdate()
    if restartDance
        string animationName = StorageUtil.GetStringValue(me, "bind_dance_animation")
        if animationName != ""
            debug.SendAnimationEvent(me, animationName)
        else 
            ;this should not happen
            ;end dance??
        endif
        restartDance = false
    endif
endevent

event OnCrosshairRefChange(ObjectReference ref)

	if !processingCrosshair && ref != none

		processingCrosshair = true

        bind_Utility.WriteToConsole("crosshair - ref: " + ref)

        if TheActivator.GetReference() != ref

            if ref.HasKeywordString("zadc_FurnitureDevice") || ref.HasKeywordString("dse_dm_KeywordFurniture")
                
                TheActivator.ForceRefTo(ref)
                bind_Utility.WriteToConsole("filled theactivator ref: " + ref.GetName())

            ; elseif ref.HasKeywordString("zbfFurniture")

            ;     ;nothing needed here - onsit works for furniture

            else

                ;clear furniture faction
                if me.IsInFaction(InFurnitureFaction)
                    if me.GetFactionRank(InFurnitureFaction) > 1 ;only do this for ddc/dse furnitures
                        me.RemoveFromFaction(InFurnitureFaction) ;this is added by the activator 
                    endif
                endif

            endif

        endif

		processingCrosshair = false

	endif

endevent

Event OnSit(ObjectReference akFurniture)
	
	;debug.MessageBox(akFurniture)

    if akFurniture.HasKeywordString("zbfFurniture")
        ;debug.MessageBox("has zbfFurniture keyword ff: " + InFurnitureFaction + " me: " + me)
        if !me.IsInFaction(InFurnitureFaction)
            me.SetFactionRank(InFurnitureFaction, 1) ;this is added by the activator 
        endif
    endif

EndEvent

Event OnGetUp(ObjectReference akFurniture)

    ;debug.MessageBox(akFurniture)

    if akFurniture.HasKeywordString("zbfFurniture")
        if me.IsInFaction(InFurnitureFaction)
            me.RemoveFromFaction(InFurnitureFaction) ;this is added by the activator 
        endif
    endif

EndEvent

ReferenceAlias property TheActivator auto

Faction property InFurnitureFaction auto

