Scriptname bindc_NpcControl extends ReferenceAlias  

bool nudityFlag = false

event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)

    Actor a = self.GetActorReference()

    ;debug.MessageBox("akBaseObject: " + akBaseObject)

    if nudityFlag
        
            Armor dev = akBaseObject as Armor

            bind_Utility.WriteToConsole("follower script - dev: " + dev + " actor: " + a.GetDisplayName())

            if dev != none
                
                if !dev.HasKeyWordString("sexlabnostrip") && !dev.HasKeyWordString("zbfWornDevice") ;add DD and ZAP keywords
                    a.UnequipItem(dev, false, true)
                endif

                bind_Utility.WriteToConsole("follower script REMOVED - dev: " + dev + " actor: " + a.GetDisplayName())

            endif

    endif

endevent

function StripMe(bool animation = false)

    ;debug.MessageBox("in here??")

    nudityFlag = true

    Actor a = self.GetActorReference()

    if !a.IsInFaction(bindc_NudityFaction)
        a.AddToFaction(bindc_NudityFaction)
    endif

    SexLabFramework sfx = Quest.GetQuest("SexLabQuestFramework") as SexLabFramework
    Form[] items = sfx.StripActor(a, none, animation)

    ; Form[] items = bind_SkseFunctions.DoStripActor(a, false)
    StorageUtil.FormListCopy(a, "binding_strip_storage", items)

endfunction

function DressMe()

    nudityFlag = false

    Actor a = self.GetActorReference()

    if a.IsInFaction(bindc_NudityFaction)
        a.RemoveFromFaction(bindc_NudityFaction)
    endif

    Form[] items = StorageUtil.FormListToArray(a, "binding_strip_storage")
    SexLabFramework sfx = Quest.GetQuest("SexLabQuestFramework") as SexLabFramework
    sfx.UnstripActor(a, items, false)

endfunction

string function TestMe()
    return "hello world..."
endfunction

Faction property bindc_NudityFaction auto