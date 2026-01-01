Scriptname bindc_Pre extends Quest  

Actor theSub 

function SetDom(Actor dom)
  
	if theSub == none
		theSub = Game.GetPlayer()
	endif

    StorageUtil.SetFormValue(none, "bindc_dom", dom)
    StorageUtil.SetFormValue(none, "bindc_future_dom", none)

	ActorBase domActorBase = dom.GetActorBase()

    StorageUtil.SetStringValue(none, "bindc_dom_name", domActorBase.GetName())
    
    int sex = domActorBase.GetSex()
    StorageUtil.SetStringValue(none, "bindc_dom_sex", sex)

    string existingTitle = StorageUtil.GetStringValue(none, "bindc_dom_title", "")

	if existingTitle == "Mistress" || existingTitle == "Master" || existingTitle == "" ;NOTE - only toggle this if the user has not set a custom title
		If sex == 1
			StorageUtil.SetStringValue(none, "bindc_dom_title", "Mistress")
		Else
			StorageUtil.SetStringValue(none, "bindc_dom_title", "Master")
		EndIf
	endif

	if !theSub.IsInFaction(bindc_SubFaction)
		theSub.AddToFaction(bindc_SubFaction)
	endif

    if !dom.IsInFaction(bindc_DomFaction)
        dom.addToFaction(bindc_DomFaction)
    endif

    debug.MessageBox(dom.GetDisplayName() + " is your new Dominant.")

	(Quest.GetQuest("bindc_MainQuest") as bindc_Main).TriggerLoop()


endfunction

Faction property bindc_SubFaction auto
Faction property bindc_DomFaction auto