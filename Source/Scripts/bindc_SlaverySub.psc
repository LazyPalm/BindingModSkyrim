Scriptname bindc_SlaverySub extends ReferenceAlias  

int kSlotMaskBody = 0x00000004 ;body

Actor a

event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)

    if a == none
        a = self.GetActorReference()
    endif

    bool removed = false
    bool safeArea = (StorageUtil.GetIntValue(none, "bindc_safe_area", 1) == 2)
    bool nudeRule = r.IsNudityRequired(a, safeArea) 

    bindc_Bondage b = data_script.BondageScript
    bindc_Rules r = data_script.RulesScript

    Armor dev = akBaseObject as Armor

    if dev != none && !b.IsEquippingBondageOutfit()
        if !dev.IsJewelry() && !b.ZadKeywordsCheck(dev) && !dev.HasKeywordString("sexlabnostrip")

            int slotMask = dev.GetSlotMask()

            ;outfit / nudity blocks
            int equippedOutfitId = StorageUtil.GetIntValue(a, "bindc_equipped_outfit_id", -1) 
            if equippedOutfitId > -1 || nudeRule
                bool hasBlock = false 
                if equippedOutfitId > -1
                    hasBlock = StorageUtil.IntListHas(none, "bindc_outfit_" + equippedOutfitId + "_block_slots", slotMask)
                endif
                if hasBlock || (nudeRule && slotMask != 128) ;allow shoes on nudity rule
                    if !b.ZadKeywordsCheck(dev) && !dev.HasKeyWordString("sexlabnostrip")
                        bindc_Util.WriteInternalMonologue("I am not allowed to wear this...")
                        bindc_Util.WriteNotification("Nudity rule or bondage set block found", bindc_Util.TextColorRed())
                        a.UnequipItem(dev, false, true)
                        removed = true
                    endif
                endif
                bindc_Util.WriteInformation("nude rule: " + nudeRule + " setId: " + equippedOutfitId + " f: " + b.GetOutfitsFileName() + " dev: " + dev + " slot: " + slotMask + " hasBlock: " + hasBlock)
            endif

            if !removed 
                ;proper female armor rule
                if slotMask == kSlotMaskBody
                    if r.IsProperFemaleArmorRequired(a, safeArea) && a.GetActorBase().GetSex() == 1
                        if data_script.GearScript.IsProperFemaleArmor(dev) || StorageUtil.FormListHas(a, "bindc_proper_female_armor_white_list", dev)
                            ;item OK
                        else
                            bindc_Util.WriteInternalMonologue("I am only allowed to wear proper female armor...")
                            a.UnequipItem(dev, false, true)	
                            removed = true					
                        endif
                    endif
                endif
            endif

        endif
    endif

endevent

bindc_Data property data_script auto