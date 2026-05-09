Scriptname binda_Bondage extends Quest  

bool function RemoveGearSetting(int setId) global

    Quest mq = Quest.GetQuest("bind_MainQuest") 
    bind_MainQuestScript mqs = mq as bind_MainQuestScript

    if JsonUtil.GetIntValue(mqs.BindingGameOutfitFile, setId + "_remove_existing_gear", 0) == 1
        return true
    else 
        return false
    endif

endfunction

bool function LeaveBondageItemsEquipped(int setId) global

    Quest mq = Quest.GetQuest("bind_MainQuest") 
    bind_MainQuestScript mqs = mq as bind_MainQuestScript

    if JsonUtil.GetIntValue(mqs.BindingGameOutfitFile, setId + "_leave_items", 0) == 1
        return true
    else 
        return false
    endif

endfunction

Form[] function GetClothing(int setId) global

    Quest mq = Quest.GetQuest("bind_MainQuest") 
    bind_MainQuestScript mqs = mq as bind_MainQuestScript

    return JsonUtil.FormListToArray(mqs.BindingGameOutfitFile, setId + "_fixed_worn_items")

endfunction

Form[] function GetBondageItems(int setId) global

    Quest mq = Quest.GetQuest("bind_MainQuest") 
    bind_MainQuestScript mqs = mq as bind_MainQuestScript
    bind_BondageManager bms = mq as bind_BondageManager

    Form[] setItems

    int useRulesBased = JsonUtil.GetIntValue(mqs.BindingGameOutfitFile, setId + "_rules_based", 0)
    int useRandom = JsonUtil.GetIntValue(mqs.BindingGameOutfitFile, setId + "_use_random_bondage", 0)

    bind_Utility.WriteToConsole("GetBondageItems - userandom: " + userandom + " userules: " + useRulesBased)

    if useRandom == 1

        float expirationDate = JsonUtil.GetFloatValue(mqs.BindingGameOutfitFile, setId + "_dynamic_bondage_expires", 0.0)
        if expirationDate < bind_Utility.GetTime() || JsonUtil.FormListCount(mqs.BindingGameOutfitFile, setId + "_dynamic_bondage_items") == 0
            
            bind_Utility.WriteNotification("resetting dynamic gear", bind_Utility.TextColorRed())

            JsonUtil.FormListClear(mqs.BindingGameOutfitFile, setId + "_dynamic_bondage_items")
            JsonUtil.SetFloatValue(mqs.BindingGameOutfitFile, setId + "_dynamic_bondage_expires", bind_Utility.AddTimeToCurrentTime(Utility.RandomInt(3, 24), 0)) ;testing 3-24 hours

            if useRulesBased == 1
                int[] emptyList
                Form[] randomSetItems = bind_SkseFunctions.CreateRandomDeviousSet(bms.bind_dd_all, Utility.RandomInt(1, 3), Utility.RandomInt(1, 4), emptyList)
                JsonUtil.FormListCopy(mqs.BindingGameOutfitFile, setId + "_dynamic_bondage_items", randomSetItems)
                bind_Utility.WriteToConsole("random set length: " + randomSetItems.Length)
            else
                int[] chances = JsonUtil.IntListToArray(mqs.BindingGameOutfitFile, setId + "_random_bondage_chance")
                Form[] randomSetItems = bind_SkseFunctions.CreateRandomDeviousSet(bms.bind_dd_all, Utility.RandomInt(1, 3), Utility.RandomInt(1, 4), chances)
                JsonUtil.FormListCopy(mqs.BindingGameOutfitFile, setId + "_dynamic_bondage_items", randomSetItems)
                bind_Utility.WriteToConsole("random set length: " + randomSetItems.Length)
            endif

        endif

        setItems = JsonUtil.FormListToArray(mqs.BindingGameOutfitFile, setId + "_dynamic_bondage_items")

    else
    
        setItems = JsonUtil.FormListToArray(mqs.BindingGameOutfitFile, setId + "_fixed_bondage_items")

    endif

    return setItems

endfunction