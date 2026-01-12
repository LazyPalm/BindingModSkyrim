Scriptname bindc_EventQuest extends Quest conditional

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
    bindc_EventQuest eq = q as bindc_EventQuest

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
                startEvent = eq.EventCheck("harsh", 1, ct, eq.data_script.EventHarshEnabledDefault, eq.data_script.EventHarshChanceDefault, eq.data_script.EventHarshCooldownDefault)
            elseif test == 2
                startEvent = eq.EventCheck("display", 2, ct, eq.data_script.EventDisplayEnabledDefault, eq.data_script.EventDisplayChanceDefault, eq.data_script.EventDisplayCooldownDefault)
            elseif test == 3
                startEvent = eq.EventCheck("inspect", 3, ct, eq.data_script.EventInspectEnabledDefault, eq.data_script.EventInspectChanceDefault, eq.data_script.EventInspectCooldownDefault)
            endif
            i += 1
        endwhile

        ; startEvent = EventCheck("harsh", 1, ct)
        ; if startEvent == 0

        ; endif
        ; if startEvent == 0

        ; endif                
    else
    
    endif

    return startEvent

endfunction

bindc_Data property data_script auto