Scriptname bind_UpdateStatsQuestScript extends Quest  

Actor theSub
Actor theDom

ObjectReference startingMarker

event OnInit()

    if self.IsRunning()

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        ;condition this to inside of cities and towns?

        ; ;training check
        ; int trainingCount = Game.QueryStat("Training Sessions")
        ; int storedTrainingCount = StorageUtil.GetIntValue(theSub, "binding_training_sessions", 0)
        ; ;debug.MessageBox("training: " + trainingCount + " stored: " + storedTrainingCount)
        ; if trainingCount != storedTrainingCount
        ;     ;check permission
        ;     if storedTrainingCount == 0
        ;         ;do a warning first time?
        ;         fs.WarnSubForBrokenRule("I was supposed to ask before training", true)
        ;     else
        ;         if rms.BehaviorStudiesAskToTrainMustAsk == 1 && rms.BehaviorStudiesAskToTrainPermission == 0
        ;             fs.MarkSubBrokeRule("I was supposed to ask before training", true)
        ;         endif
        ;     endif
        ;     ;todo - make sure rules manager times this out??
        ;     StorageUtil.SetIntValue(theSub, "binding_training_sessions", trainingCount)
        ; endif

        ;scan for furniture
        if NearbyFurniture.GetReference() != none
            bind_Utility.WriteToConsole("update stats quest - found furniture")
            fs.EventSetFurniture(NearbyFurniture.GetReference())
            bind_GlobalLocationHasFurniture.SetValue(1)
        else
            bind_GlobalLocationHasFurniture.SetValue(0)
        endif

        ;update for clean slave
        fs.UpdateCleanTracking()
        bind_GlobalSexCleanPassed.SetValue(1)
        if mqs.DomPreferenceCleanSub == 1
            if mqs.SubDirtLevel > 25
                bind_GlobalSexCleanPassed.SetValue(0)
            endif
        endif

        ;update arousal tracking
        sms.UpdateArousalLevels()

        ;rules
        rms.UpdateTimePermissions()

        float currentTime = bind_Utility.GetTime()

        if currentTime - bind_GlobalStatsCheckedForDay.GetValue() > 1.0
            bind_GlobalStatsCheckedForDay.SetValue(Math.Floor(currentTime))

            ;NOTE - do daily updates here

            ;award points for being good
            if fs.GetPointsFromBeingGood()
                if fs.GetRuleInfractions() == 0
                    fs.AddPoint()
                    bind_Utility.WriteNotification(fs.GetDomTitle() + " has awarded a point for being good all day...", bind_Utility.TextColorBlue())
                endif
            else
                ;in old version points were awarded for not breaking rules recently. should it still work that way??
            endif

        endif

        if currentTime - bind_GlobalStatsCheckedForHour.GetValue() > 0.04166
            bind_Utility.WriteToConsole("updatestatsquest - running hourly update")
            bind_GlobalStatsCheckedForHour.SetValue(Math.Floor(currentTime))

            MilkUpdates(theSub)

        endif

        self.Stop()

    endif

endevent

function MilkUpdates(Actor sub)

    if mqs.SoftCheckMME == 1 && mqs.EnableModMME == 1 && fs.ModInRunningState()
        if sub.GetFactionRank(bind_MilkSlaveFaction) == 2 ;active
            ;int hasPermission = StorageUtil.GetIntValue(sub, "bind_milking_permission", 0)
            ;debug.Notification("updating milk") ;TODO - remove this
            float currentMilk = bind_MMEHelper.GetMilkLevel(sub)
            float maxMilk = bind_MMEHelper.GetMilkMax(sub)
            float currentLactacid = bind_MMEHelper.GetLactacidLevel(sub)
            float timesMilked = bind_MMEHelper.GetTimesMilked(sub)
            bind_Utility.WriteToConsole("stats - stored times milked: " + bind_GlobalMilkedTimesMilked.GetValue() + " from mme: " + timesMilked)
            ; int detectedMilkLeak = StorageUtil.GetIntValue(sub, "bind_had_milk_leak", 0)
            ; if hasPermission == 0 && timesMilked > bind_GlobalMilkedTimesMilked.GetValue() && detectedMilkLeak == 0
            ;     fs.MarkSubBrokeRule("I milked without having permission", false)
            ; endif
            ; StorageUtil.SetIntValue(sub, "bind_milking_permission", 0)
            bind_GlobalMilkCurrentLevel.SetValue(currentMilk)
            bind_GlobalMilkMaxLevel.SetValue(maxMilk)
            bind_GlobalMilkLactacidLevel.SetValue(currentLactacid)
            bind_GlobalMilkedTimesMilked.SetValue(timesMilked)
            if (currentLactacid < 0.25) || (currentMilk >= (maxMilk * 0.75))
                bind_GlobalMilkTriggerRun.SetValue(1.0)
            endif
            ;StorageUtil.SetIntValue(sub, "bind_had_milk_leak", 0)
        endif
    endif

endfunction

bind_MainQuestScript property mqs auto
bind_SexManager property sms auto
bind_RulesManager property rms auto
bind_Functions property fs auto

ReferenceAlias property NearbyFurniture auto

GlobalVariable property bind_GlobalLocationHasFurniture auto
GlobalVariable property bind_GlobalSexCleanPassed auto
GlobalVariable property bind_GlobalStatsCheckedForDay auto
GlobalVariable property bind_GlobalStatsCheckedForHour auto

Faction property bind_MilkSlaveFaction auto
GlobalVariable property bind_GlobalMilkCurrentLevel auto
GlobalVariable property bind_GlobalMilkMaxLevel auto
GlobalVariable property bind_GlobalMilkLactacidLevel auto
GlobalVariable property bind_GlobalMilkedTimesMilked auto
GlobalVariable property bind_GlobalMilkTriggerRun auto
