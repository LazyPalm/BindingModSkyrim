Scriptname bindc_EventHelper extends Quest  

string property RunningEventName auto conditional

int function EventCheck(string n, int num, float currentTime, int enabledDefault, int chanceDefault, int cooldownDefault)
    if StorageUtil.GetIntValue(none, "bindc_event_" + n + "_enabled", enabledDefault) == 0
        bindc_Util.WriteInformation("EventCheck - event: " + n + " [disabled]")
        return -1
    endif
    int roll = Utility.RandomInt(1, 100)
    int chance = StorageUtil.GetIntValue(none, "bindc_event_" + n + "_chance", chanceDefault)
    float last = StorageUtil.GetFloatValue(none, "bindc_event_" + n + "_last", 0.0)
    int cool = StorageUtil.GetIntValue(none, "bindc_event_" + n + "_cooldown", cooldownDefault)
    float next = bindc_Util.AddTimeToTime(last, cool, 0)
    int result
    if roll <= chance
        if next < currentTime
            result = num
        else
            result = 0
        endif
    endif
    bindc_Util.WriteInformation("EventCheck - event: " + n + " roll: " + roll + " chance: " + chance + " ct: " + currentTime + " last: " + last + " cool: " + cool + " next: " + next)
    return result
endfunction

int function EventTest() global

    Quest q = Quest.GetQuest("bindc_MainQuest")
    bindc_EventHelper h = q as bindc_EventHelper
    bindc_Data d = q as bindc_Data

    int safeArea = StorageUtil.GetIntValue(none, "bindc_safe_area", 2)
    float ct = bindc_Util.GetTime()
    int startEvent = 0

    if safeArea == 2

        int[] rnd = bindc_SKSE.GetRandomNumbers(1, 5, 5)
        bindc_Util.WriteInformation("event check rnd: " + rnd)
        int i = 0
        while i < rnd.Length && startEvent == 0
            int test = rnd[i]
            if test == 1
                startEvent = h.EventCheck("harsh", 1, ct, d.EventHarshEnabledDefault, d.EventHarshChanceDefault, d.EventHarshCooldownDefault)
            elseif test == 2
                startEvent = h.EventCheck("display", 2, ct, d.EventDisplayEnabledDefault, d.EventDisplayChanceDefault, d.EventDisplayCooldownDefault)
            elseif test == 3
                startEvent = h.EventCheck("inspect", 3, ct, d.EventInspectEnabledDefault, d.EventInspectChanceDefault, d.EventInspectCooldownDefault)
            endif
            i += 1
        endwhile
              
    else
    
    endif

    return startEvent

endfunction

bool function PrepareSub(Actor theSub, Actor theDom, string eventSystemName) global

    Quest q = Quest.GetQuest("bindc_MainQuest")
    bindc_EventHelper h = q as bindc_EventHelper
    bindc_Data d = q as bindc_Data

    int outfitId = d.BondageScript.GetBondageOutfitForEvent(theSub, eventSystemName)
    if outfitId == 0
        outfitId = d.BondageScript.GetBondageOutfitForEvent(theSub, "event_any_event")
    endif
    if outfitId > 0
    else 
        debug.MessageBox("No " + eventSystemName + " outfit was found")
        d.MainScript.EndRunningEvent()
        return false
    endif

    ;bindc_Util.MoveToPlayer(theDom)

    bindc_Util.DisablePlayer()

    bindc_Util.PlayTyingAnimation(theDom, theSub)

    bindc_Util.FadeOutApplyNoDisable()

    d.BondageScript.EquipBondageOutfit(theSub, outfitId)
    bindc_Util.DoSleep(2.0)

    bindc_Util.StopAnimations(thedom)

    bindc_Util.EnablePlayer()

    bindc_Util.FadeOutRemoveNoDisable()

    return true

endfunction

;bindc_Data property data_script auto
