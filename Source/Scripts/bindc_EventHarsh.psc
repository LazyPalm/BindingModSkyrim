Scriptname bindc_EventHarsh extends Quest  

Actor theSub
Actor theDom

float eventEndTime = 0.0

int minMinutes = 0 ;get from mcm?
int maxMinutes = 0
int hoursBetween = 0

bool usingSet

event OnInit()

    if self.IsRunning()

        GoToState("")

        minMinutes = StorageUtil.GetIntValue(none, "bindc_event_harsh_min", 20)
        maxMinutes = StorageUtil.GetIntValue(none, "bindc_event_harsh_max", 30)
        hoursBetween = StorageUtil.GetIntValue(none, "bindc_event_harsh_cooldown", 4)

        theSub = Game.GetPlayer()
        theDom = bindc_Util.GetDom()

        SetStage(10)
        SetObjectiveDisplayed(10, true)

        TieUpSub()

    endif

endevent

function ActionShortPress()
    debug.MessageBox("this is doing something...")
endfunction

function ActionLongPress()
endfunction

state WaitingState

    function ActionShortPress()
        debug.MessageBox("this is doing something (waiting)...")
    endfunction

    event OnUpdate()

        bindc_Util.WriteInformation("event time left: " + (eventEndTime - bindc_Util.GetTime()))

        if bindc_Util.GetTime() > eventEndTime
            GoToState("")
            FreeSub()
        else
            RegisterForSingleUpdate(15.0)
        endif

    endevent

endstate

function TieUpSub()

    int outfitId = data_script.BondageScript.GetBondageOutfitForEvent(theSub, "event_harsh_bondage")
    if outfitId > 0
    else 
        debug.MessageBox("No Harsh Bondage outfit was found")
        data_script.MainScript.EndRunningEvent() ;should always be the last line
        return
    endif

    bindc_Util.DisablePlayer()

    bindc_Util.FadeOutApplyNoDisable()

    data_script.BondageScript.EquipBondageOutfit(theSub, outfitId)
    bindc_Util.DoSleep(3.0)

    bindc_Util.EnablePlayer()

    bindc_Util.FadeOutRemoveNoDisable()

    bindc_Util.WriteInternalMonologue("I appear to be trussed up for a bit...")

    eventEndTime = bindc_Util.AddTimeToCurrentTime(0, Utility.RandomInt(minMinutes, maxMinutes)) 
    
    GotoState("WaitingState")

    SetObjectiveCompleted(10)
    SetObjectiveDisplayed(10, false)
    SetObjectiveDisplayed(20, true)

    RegisterForSingleUpdate(1.0)
    
endfunction

function FreeSub()

    SetObjectiveCompleted(20)
    SetObjectiveDisplayed(20, false)
    SetObjectiveDisplayed(30, true)

    bindc_Util.WriteInternalMonologue("It seems that I am about to be freed...")

    ActorUtil.AddPackageOverride(theDom, bindc_PackageMoveToPlayer, 80)
    theDom.EvaluatePackage()

    int timer = 60
    while theDom.GetDistance(theSub) > 256.0 || timer == 0
        bindc_Util.DoSleep(1.0)
        timer -= 1
    endwhile

    debug.Notification("close enough...")

    bindc_Util.DisablePlayer()

    bindc_Util.FadeOutApplyNoDisable()

    int lastOutfitId = StorageUtil.GetIntValue(theSub, "bindc_outfit_id", -1)
    if lastOutfitId > 0
        data_script.BondageScript.EquipBondageOutfit(theSub, lastOutfitId)
        bindc_Util.DoSleep(3.0)
    else 
        ;remove stuff??
    endif

    bindc_Util.EnablePlayer()

    bindc_Util.FadeOutRemoveNoDisable()

    int awardsPoints = StorageUtil.GetIntValue(none, "bindc_event_harsh_points", 0) ;awards points
    string domTitle = bindc_Util.GetDomTitle()

    if bindc_Util.GetInfractions() > 0
        bindc_Util.WriteNotification(domTitle + " canceled a punishment for being a good bondage pet.", bindc_Util.TextColorBlue())
        bindc_Util.ModifyInfractions(-1)
    elseif awardsPoints == 1
        bindc_Util.WriteNotification(domTitle + " enjoyed seeing you suffer in bondage and decided to award you a point.", bindc_Util.TextColorBlue())
        bindc_Util.ModifyPoints(1)
    else 
        bindc_Util.WriteNotification(domTitle + " enjoyed the bondage show...", bindc_Util.TextColorBlue())
    endif

    float ct = bindc_Util.GetTime()
    StorageUtil.SetFloatValue(none, "bindc_event_harsh_last", ct)

    SetStage(20)
    SetObjectiveCompleted(30)
    SetObjectiveDisplayed(30, false)

    ActorUtil.ClearPackageOverride(theDom)

    data_script.MainScript.EndRunningEvent() ;should always be the last line

endfunction

bindc_Data property data_script auto

Package property bindc_PackageMoveToPlayer auto