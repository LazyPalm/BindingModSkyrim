Scriptname bind_TheThirdSub extends ReferenceAlias  

bind_MainQuestScript main
bind_BondageManager BondageManager
bind_RulesManager RulesManager
bind_Functions fs
bool loadedScripts = false

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
    
    ;bind_Utility.WriteToConsole("second sub - OnObjectEquipped akBaseObject: " + akBaseObject.GetName() + " bm busy: " + BondageManager.EquippingBondageOutfit)

    Actor a = self.GetActorReference()

    bool removed = false
    
    if !loadedScripts
        Quest q = Quest.GetQuest("bind_MainQuest")
        main = q as bind_MainQuestScript
        BondageManager = q as bind_BondageManager
        RulesManager = q as bind_RulesManager    
        fs = q as bind_Functions
        loadedScripts = true
    endif

    ;if !BondageManager.EquippingBondageOutfit
        
        bool nudeRule = RulesManager.IsNudityRequired(a, fs.InSafeArea() == 1) 

        int wearingSetId = StorageUtil.GetIntValue(a, "bind_wearing_outfit_id")

        ;bind_Utility.WriteToConsole("second sub - setId: " + wearingSetId)

        if wearingSetId > 0

            ;bind_Utility.WriteToConsole("second sub - blocks: " + JsonUtil.IntListToArray(main.BindingGameOutfitFile, wearingSetId + "_block_slots"))

            Armor dev = akBaseObject as Armor
            if dev != none
                
                int slotMask = dev.GetSlotMask()
                
                ;string f = "bind_bondage_outfit_" + wearingSetId + ".json"
                
                bool hasBlock = JsonUtil.IntListHas(main.BindingGameOutfitFile, wearingSetId + "_block_slots", slotMask)
                
                if hasBlock || (nudeRule && slotMask != 128) ;allow shoes on nudity rule
                    if !BondageManager.ZadKeywordsCheck(dev) && !dev.HasKeyWordString("sexlabnostrip")
                        a.UnequipItem(dev, false, true)
                        removed = true
                    endif
                endif

                bind_Utility.WriteToConsole("third sub - setId: " + wearingSetId + " f: " + main.BindingGameOutfitFile + " dev: " + dev + " slot: " + slotMask + " hasBlock: " + hasBlock)

            endif
        endif

    ;endif

EndEvent