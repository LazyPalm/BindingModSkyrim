Scriptname bindc_Pre extends Quest  

Actor theSub 

function ActionMenu()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("Manage Future Dominants")
	listMenu.AddEntryItem("Add Future Dominant")

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ManageFutureDomsMenu()
	elseif listReturn == 1
		AddFutureDomsMenu()

    endif
	
endfunction

function AddFutureDomsMenu()
	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    listMenu.AddEntryItem("<-- Return To Menu")
	Actor[] nearbyFollowers = MiscUtil.ScanCellNPCsByFaction(PotentialFollowerFaction, Game.GetPlayer()) 
    int i = 0
    while i < nearbyFollowers.Length
		if !StorageUtil.FormListHas(none, "bindc_future_doms", nearbyFollowers[i])
        	listMenu.AddEntryItem(nearbyFollowers[i].GetDisplayName())
		endif
        i += 1
    endwhile

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ActionMenu()
	elseif listReturn > 0
		Actor a = nearbyFollowers[listReturn - 1] as Actor
		if bindc_Util.ConfirmBox("Add " + a.GetDisplayName() + "?")
			StorageUtil.FormListAdd(none, "bindc_future_doms", nearbyFollowers[listReturn - 1])
		endif
		AddFutureDomsMenu()
	endif

endfunction

function ManageFutureDomsMenu()

    UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
    
    listMenu.AddEntryItem("<-- Return To Menu")

	Form[] future = StorageUtil.FormListToArray(none, "bindc_future_doms")
    ;Form[] future = JsonUtil.FormListToArray("binding/bind_future.json", "future_doms")
    ;debug.MessageBox(future)

    int i = 0
    while i < future.Length
        Actor a = future[i] as Actor
        listMenu.AddEntryItem(a.GetDisplayName())
        i += 1
    endwhile

    listMenu.OpenMenu()
    int listReturn = listMenu.GetResultInt()

    if listReturn == 0
        ActionMenu()
	elseif listReturn > 0
		Actor a = future[listReturn - 1] as Actor
		if bindc_Util.ConfirmBox("Remove " + a.GetDisplayName() + "?")
			StorageUtil.FormListRemove(none, "bindc_future_doms", a)			
		endif
		ManageFutureDomsMenu()
    endif

endfunction

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

Faction property PotentialFollowerFaction auto

ReferenceAlias property ActorBaseAlias auto
