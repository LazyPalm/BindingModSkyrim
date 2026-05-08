Scriptname bind_BoundForLocationsScript extends Quest  

bool firstChangeCompleted

Actor theSub
Actor theDom

Location currentLocation

Quest guardBondageQuest

bool playingGlow

event OnInit()

    if self.IsRunning()

        RegisterForModEvent("bind_ChangeOutfitCompletedModEvent", "ChangeOutfitCompletedModEvent")

        ;debug.MessageBox("started arrival check")

        bcs.DoStartEvent(false)
        bcs.SetEventName(self.GetName())
        playingGlow = false

        bind_Utility.WriteToConsole("bind_BoundForLocations outfit id: " + mqs.ActiveBondageSetId)
        
        if mqs.PreferenceSpellChangeBondage == 1

            playingGlow = true
            BlueGlow.Play(fs.GetSubRef(), 10.0)

            mqs.NeedsBondageSetChange = 0

            int handle = ModEvent.Create("bind_BondageUpdateModEvent")
            if handle
                ModEvent.PushForm(handle, fs.GetSubRef())
                ModEvent.PushInt(handle, mqs.TargetBondageSetId)
                ModEvent.Send(handle)
            endif

            

        else

            float dist = fs.GetDomRef().GetDistance(fs.GetSubRef())

            if dist > 3000.0

                bind_Utility.WriteToConsole("bind_BoundForLocations too far to use dom - dist: " + dist)

                if mqs.PreferenceGuardsEquipBondage == 1
                    if guardBondageQuest == none
                        guardBondageQuest = Quest.GetQuest("binda_GuardsEquipBondageQuest")
                    endif
                    if guardBondageQuest.IsRunning()
                        guardBondageQuest.Stop() ;if it is running from a failed forcegreet
                    endif
                    if !guardBondageQuest.IsRunning()
                        guardBondageQuest.Start()
                        bind_Utility.WriteToConsole("starting binda_GuardsEquipBondageQuest")
                    endif
                endif

            else

                mqs.NeedsBondageSetChange = 0

                if fs.GetDomRef().GetDistance(fs.GetSubRef()) > 255.0
                    bind_Utility.WriteInternalMonologue("I need to get closer to " + fs.GetDomTitle() + "...")
                    bind_MovementQuestScript.WalkTo(fs.GetDomRef(), fs.GetSubRef(), 255.0)
                endif
                bind_MovementQuestScript.FaceTarget(fs.GetDomRef(), fs.GetSubRef())
                bind_MovementQuestScript.PlayDoWork(fs.GetDomRef())

                bind_Utility.WriteNotification("Applying bondage set...", bind_Utility.TextColorBlue())

                int handle = ModEvent.Create("bind_BondageUpdateModEvent")
                if handle
                    ModEvent.PushForm(handle, fs.GetSubRef())
                    ModEvent.PushInt(handle, mqs.TargetBondageSetId)
                    ModEvent.Send(handle)
                endif

            endif

        endif

        ; bcs.DoEndEvent(false)

        ; self.Stop()

    endif

endevent

event ChangeOutfitCompletedModEvent(Form akActor)

    if akActor == Game.GetPlayer()

        if playingGlow
            BlueGlow.Stop(fs.GetSubRef())
        endif

        bcs.DoEndEvent(false)

        self.Stop()

    endif

endevent

bind_MainQuestScript property mqs auto
bind_BondageManager property bms auto
bind_Controller property bcs auto
bind_GearManager property gms auto
bind_RulesManager property rms auto
bind_Functions property fs auto

Keyword property LocTypeClearable auto
Keyword property LocTypeInn auto  
Keyword property LocTypeCastle auto  
Keyword property LocTypeCity auto  
Keyword property LocTypeTown auto
Keyword property LocTypeStore auto  
Keyword property LocTypeDungeon auto
Keyword property LocTypeDwelling auto
Keyword property LocTypePlayerHouse auto
Keyword property LocTypeHouse auto

LocationAlias property CurrentLocationAlias auto

Faction property bind_WearingLocationSpecificBondageFaction auto

GlobalVariable property bind_GlobalRulesUpdatedFlag auto

VisualEffect property BlueGlow auto