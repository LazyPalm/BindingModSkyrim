Scriptname binda_ThePlayerAlias extends ReferenceAlias  

bool lookedAtFurniture
bool processingCrosshair

Actor me

Location oldLocation
Location newLocation
bool IsSafe

event OnInit()
	RegisterforCrosshairRef()
    me = self.GetActorReference()
    RegisterForAnimationEvent(self.GetReference(), "IdleStop") 
endevent

Event OnPlayerLoadGame()
    RegisterforCrosshairRef()
    me = self.GetActorReference()
    RegisterForAnimationEvent(self.GetReference(), "IdleStop") 
    (GetOwningQuest() as binda_Main).LoadGame()
    (GetOwningQuest() as binda_Input).LoadGame()
endevent

bool restartDance = false

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
    if (asEventName == "IdleStop")
        if StorageUtil.GetIntValue(me, "bind_dancing", 0) == 1            
            ;TODO: need a changed dance flag that gets set if dance is already playing
            ;this would trigger this idle stop, but we would not need to restart the dance animation
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
            int soundInstance = StorageUtil.GetIntValue(me, "bind_sound_instance", -1)
            if soundInstance > -1
                Sound music = StorageUtil.GetFormValue(me, "bind_sound") as Sound
                if music
                    soundInstance = music.Play(me as ObjectReference)
                    StorageUtil.SetIntValue(me, "bind_sound_instance", soundInstance)
                endif
            endif
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

Event OnLocationChange(Location akOldLoc, Location akNewLoc)

    isSafe = false

	if akNewLoc.HasKeyWord(LocTypeInn) || akNewLoc.HasKeyword(LocTypeCity) || akNewLoc.HasKeyword(LocTypeTown) || akNewLoc.HasKeyWord(LocTypeStore) || akNewLoc.HasKeyWord(LocTypeDwelling) || akNewLoc.HasKeyWord(LocTypeCastle) || akNewLoc.HasKeyWord(LocTypeHouse)
		;safe area
        binda_SafeLocationGlobal.SetValue(2)
		StorageUtil.SetIntValue(me, "binda_safe_area", 2)
        isSafe = true
    elseif akNewLoc.HasKeyword(LocTypePlayerHouse)
		;safe area
        binda_SafeLocationGlobal.SetValue(3)
		StorageUtil.SetIntValue(me, "binda_safe_area", 3)
        isSafe = true
	else
		;dangerous areaa
        binda_SafeLocationGlobal.SetValue(1)
		StorageUtil.SetIntValue(me, "binda_safe_area", 1)
	endif

    bind_Utility.WriteToConsole("changed locations - loc: " + akNewLoc.GetName() + " safe: " + IsSafe)

    oldLocation = akOldLoc
    newLocation = akNewLoc

    int handle = ModEvent.Create("binda_LocationChangeModEvent")
    if handle
        ModEvent.PushForm(handle, akOldLoc)
        ModEvent.PushForm(handle, akNewLoc)
        ModEvent.Send(handle)
    endif

EndEvent

ReferenceAlias property TheActivator auto

Faction property InFurnitureFaction auto

GlobalVariable property binda_SafeLocationGlobal auto

Keyword property LocTypePlayerHouse auto
Keyword property LocTypeInn auto
Keyword property LocTypeCity auto
Keyword property LocTypeTown auto
Keyword property LocTypeStore auto
Keyword property LocTypeDwelling auto
Keyword property LocTypeCastle auto
Keyword property LocTypeHouse auto