Scriptname bind_Functions extends Quest  

int loopCounter = 0

Actor theSubRef
Actor theDomRef

bool runSoftChecks
int softCheckLastDD
int softCheckLastZAP
string mcmMessage

int oldModVersion
bool chimSentBindingCommand

int timesMasturbated = 0

string domTitle = "Master"

bool _tempRemovedWristsForOutsideOfCitiesAndTowns



Location lastLocation
Location currentLocation
Location currentOutdoorLocation

ObjectReference furniture1
; ObjectReference furniture2
; ObjectReference furniture3
; ObjectReference furniture4

int lastObjective = 0

int OBJECTIVE_NONE = 0
int OBJECTIVE_FIND_DOM = 1
int OBJECTIVE_BE_GOOD = 5

int OBJECTIVE_SELECTED_FURNITURE = 500

int inConversation = 0

int saveGameUid

Event OnInit()

	if self.IsRunning()

		main.SoftCheckDD = 1
		main.SoftCheckZAP = 1

		;main.IsSub = 0

		theSubRef = Game.GetPlayer()

		; if theSubRef.IsInFaction(bind_SubmissiveFaction)
		; 	theSubRef.RemoveFromFaction(bind_SubmissiveFaction)
		; endif

		LoadGame()

	endif

EndEvent

function LoadGame()

	;3/23/25 - updated

	if TheDom.GetReference()
		;note - needed this fix after migrating code to this script (for existing saves)
		theDomRef = TheDom.GetReference() as Actor
	endif

	main.SubName = theSubRef.GetActorBase().GetName()

	if saveGameUid == 0
		;NOTE - not sure if still using this for MCM saves
		saveGameUid = Utility.RandomInt(1000000, 5000000)
	endif

	RegisterForControl("Activate")

	RegisterForModEvent("bind_EnteringSafeAreaEvent", "EnteringSafeAreaEvent")
	RegisterForModEvent("bind_LeavingSafeAreaEvent", "LeavingSafeAreaEvent")

	RegisterForModEvent("bind_PauseStartEvent", "OnPauseStart")
    RegisterForModEvent("bind_PauseEndEvent", "OnPauseEnd")

	;RegisterForModEvent("CHIM_CommandReceived", "ChimCommand")

	If !theSubRef.HasSpell(ActionButtonMagicEffect)
		theSubRef.AddSpell(ActionButtonMagicEffect)
	Endif

	RegisterForTrackedStatsEvent()

	;NOTE - removed soft check for these mods
	main.SoftCheckDD = 1
	main.SoftCheckZAP = 1
	runSoftChecks = 0

	if main.AdventuringCheckAfterSeconds == 0.0
		main.AdventuringCheckAfterSeconds = 15.0
	endif

	SoftChecks()

	if saveGameUid == 0
		saveGameUid = Utility.RandomInt(1000000, 5000000)
		;TODO - add this to a global??
	endif

	gmanage.LoadGame(false)
	brain.LoadGame(false)
	fman.LoadGame()
	pman.LoadGame(theSubRef)
	rman.LoadGame()
	;crowds.LoadGame(saveGameUid) ;move to storageutil per actor

	;TODO - change bondage manager structures to use storageutil
	bms.LoadGame(false)

	if theDomRef != none
		string title = StorageUtil.GetStringValue(theDomRef, "bind_dom_new_name")
		bind_Utility.WriteToConsole("dom title: " + title)
		Actor tc = TitleContainer.GetReference() as Actor
		tc.GetActorBase().SetName(title)

		if theDomRef.IsInFaction(bind_DominantNpcFaction)
			theDomRef.SetRelationshipRank(theSubRef, 4) ;set to lover - this clears per load
		endif

	endif

	if !bind_GoAdventuringQuest.IsRunning()
		bind_GoAdventuringQuest.Start()
	endif

	if StorageUtil.GetIntValue(theSubRef, "kneeling_required", 1) == 0 ;if does not exist - required is the default state
		bind_GlobalKneelingOK.SetValue(1.0) ;if not required, always make this OK
	endif

endfunction

; Event ChimCommand(String npcname,String command,String parm)

; 	if EnableModChim == 1

; 		bind_Utility.WriteToConsole("recieved CHIM command: " + command)

; 		if command=="ExtCmdTieWrists"

; 			chimSentBindingCommand = true ;turning on this flag will let Binding know that CHIM is ready to get suggestions
			
; 			bms.AddItem(theSubRef, bms.BONDAGE_TYPE_HEAVYBONDAGE())

; 			; parse parameters and do stuff
			
; 			; Finally, send request of type funcrect with the result. THis will make a request to LLM again.
; 			;SPGPapFunctions.requestMessage("command@"+command+"@"+parameter+"@"+theDomRef.GetDisplayName()+" binds "+theSubRef.GetDisplayName()+ "'s wrists","funcret");	// Pass return function to LLM
; 			AIAgentFunctions.logMessageForActor(npcname +" wrists have been tied.","infoaction", npcname)

; 		elseif command == "ExtCmdWhipSub"

; 			chimSentBindingCommand = true

; 			if ModInRunningState()
; 				debug.MessageBox("start whipping quest")
; 			endif

; 		elseif command == "ExtCmdUntieWrists"

; 			chimSentBindingCommand = true

; 			bms.RemoveItem(theSubRef, bms.BONDAGE_TYPE_HEAVYBONDAGE())

; 			AIAgentFunctions.logMessageForActor(npcname +" wrists have been untied.","infoaction", npcname)

; 		elseif command == "ExtCmdUndressSub"

; 			chimSentBindingCommand = true

; 			gmanage.RemoveWornGear(theSubRef)

; 			AIAgentFunctions.logMessageForActor(npcname +" has been stripped of clothing.","infoaction", npcname)

; 		endif

; 	endif
	
; EndEvent

Event OnTrackedStatsEvent(string asStatFilter, int aiStatValue)

	bind_Utility.WriteToConsole("mainscript - OnTrackedStatsEvent - asStatFilter: " + asStatFilter + " aiStatValue: " + aiStatValue)

	;https://ck.uesp.net/wiki/ListOfTrackedStats

	;NOTE - could used Days Passed vs process in updatestats quest for daily updates - been good checks
	;NOTE - wondering if Hours Slept is the missing stat I need for survival mods when skipping time in sleep - maybe adjust it to match
	;NOTE - Training Sessions vs. not talking to trainer for training rules check

    if (asStatFilter == "Words Of Power Learned")
		;debug.MessageBox("word of power learned..."
		; StorageUtil.SetIntValue(theSub, "bind_known_words", aiStatValue) ;the check quest will compare this to the current stat for words - to check for infractions
		;NOTE - left this in as an example - this seems a better place to do rules checks vs. querying stats during removal events on thesub alias script
		;NOTE - could run detection quest to fill aliases like word walls - since word power story manager game node does not share events
	endif
endEvent

Function SetFutureDom(Actor dom)

	;FutureDom.ForceRefTo(dom)

	if !dom.IsInFaction(bind_FutureDomFaction)
		dom.AddToFaction(bind_FutureDomFaction)
	endif

	StorageUtil.FormListAdd(theSubRef, "bind_future_doms", dom, false)

	Form[] list = StorageUtil.FormListToArray(theSubRef, "bind_future_doms")
	;debug.MessageBox(list)

	StorageUtil.SetIntValue(theSubRef, "bind_has_future_dom", 1)

	;theSubRef.GetActorBase().SetEssential(true) ;this will allow the death alt functions to work

	If dom.GetActorBase().GetSex() == 1
		WindowOutput("I wonder if she knows what I like?")
	Else
		WindowOutput("I wonder if he knows what I like?")
	EndIf

	if !bind_DefeatedQuest.IsRunning()
		bind_DefeatedQuest.Start()
	endif

	;TODO - start this quest??

EndFunction

Function ClearDom()

	LogOutput("ClearDom()")

	;*********************************************************
	if theDomRef.IsInFaction(bind_DominantNpcFaction)

		int oldRank = StorageUtil.GetIntValue(theDomRef, "bind_old_rank")
		theDomRef.SetRelationshipRank(theSubRef, oldRank)

		if StorageUtil.GetFormValue(theSubRef, "bind_dom_house_faction")
			Faction buildingFaction = StorageUtil.GetFormValue(theSubRef, "bind_dom_house_faction") as Faction
			if buildingFaction
				if theSubRef.IsInFaction(buildingFaction)
					theSubRef.RemoveFromFaction(buildingFaction) ;revoke access to dom's home
				endif
			endif
			StorageUtil.UnsetFormValue(theSubRef, "bind_dom_house_faction")
		endif

		;remove key??

		theDomRef.RemoveFromFaction(bind_DominantNpcFaction)
	endif
	;*********************************************************

	bind_PoseManager.StandFromKneeling(theSubRef)

	main.IsSub = 0

	if theSubRef.IsInFaction(bind_SubmissiveFaction)
		theSubRef.RemoveFromFaction(bind_SubmissiveFaction)
	endif

	rman.ResetRules()

	bms.RemoveAllBondageItems(theSubRef)

	bind_Utility.DoSleep(2.0)

	gmanage.RestoreWornGear(theSubRef)

	theDomRef = none

	main.DominantName = ""

	TheDom.Clear()

	bind_GlobalInfractions.SetValue(0)

	HelperDisplayObjective(OBJECTIVE_FIND_DOM)

	Debug.MessageBox("You have been freed.")

EndFunction

event OnControlDown(string control)

endevent

Event OnControlUp(string control, float HoldTime)
	LogOutput("OnControlUp()")

	If control == "Activate"
		If main.IsSub == 1
			;activationKeyPressed = true
			;ActivationTime = Utility.GetCurrentGameTime()
			If inConversation == 0 || inConversation == 2
				If UI.IsMenuOpen("Dialogue Menu")
					inConversation = 1
					;NOTE - force greets did not seem to trigger this, but had a report people were getting +infraction from forcegreet
					;Debug.MessageBox("in conversation...")
					;WindowOutput("detected conversation started...")
					ProcessConversation()
				EndIf
			EndIf
		EndIf
	EndIf

	; If control == "Activate" && Game.UsingGamepad()
	; 	If HoldTime >= 0.5 && HoldTime < 5.0
	; 		;WindowOutput("testing menu: " + HoldTime)
	; 		If SubIdleState == IDLE_STATE_NONE
	; 			ProcessInput(ActionKeyMappedKeyCode, 1.0)
	; 		Else
	; 			ProcessInput(ActionKeyMappedKeyCode, 0.0)
	; 		EndIf
	; 	ElseIf HoldTime >= 5.0
	; 		;WindowOutput("testing sw: " + HoldTime)
	; 		ProcessInput(KEY_ACTION, 5.0)
	; 	EndIf
	; 	;NOTE: need to hold down the activator on the control since clicks are used for menus
	; 	;ProcessInput(KEY_ACTION, HoldTime)
	; EndIf

EndEvent

Function SoftChecks()

	;KEEP THIS - 3/8/25

	If runSoftchecks == 0
		main.SoftCheckDM3 = 0
		main.SoftCheckPama = 0
		main.SoftCheckDirtAndBlood = 0
		main.SoftCheckBathingInSkyrim = 0
		main.SoftCheckSweepingOrganizesStuff = 0
		main.SoftCheckMME = 0
		main.SoftCheckDDNG = 0
		main.SoftCheckChim = 0
		main.SoftCheckSkyrimNet = 0
		main.SoftCheckGoToBed = 0
		;WindowOutput("found at: " + Game.GetModByName("dse-display-model.esp"))
		If bind_PamaHelper.CheckValid()
			bind_Utility.WriteToConsole("soft check found PamaInteractiveBeatup.esm")
			main.SoftCheckPama = 1
		EndIf
		If bind_DirtAndBloodHelper.CheckValid()
			bind_Utility.WriteToConsole("soft check found Dirt and Blood - Dynamic Visuals.esp")
			main.SoftCheckDirtAndBlood = 1
		EndIf
		if bind_BathingInSkyrimHelper.CheckValid()
			bind_Utility.WriteToConsole("soft check found Bathing in Skyrim.esp")
			main.SoftCheckBathingInSkyrim = 1
		endif
		If bind_DM3Helper.CheckValid()
			bind_Utility.WriteToConsole("soft check found dse-display-model.esp")
			main.SoftCheckDM3 = 1
		EndIf
		if Game.IsPluginInstalled("sweepingOrganizesStuff.esp")
			bind_Utility.WriteToConsole("soft check found sweepingOrganizesStuff.esp")
			main.SoftCheckSweepingOrganizesStuff = 1
		endif
		if Game.IsPluginInstalled("MilkModNEW.esp")
			bind_Utility.WriteToConsole("soft check found MilkModNEW.esp")
			main.SoftCheckMME = 1
		endif
		if bms.DDVersionString() == "5.2-NG"
			main.SoftCheckDDNG = 1
		endif
		if Game.IsPluginInstalled("Gotobed.esp")
			main.SoftCheckGoToBed = 1
		endif
		if Game.IsPluginInstalled("AIAgent.esp")
			main.SoftCheckChim = 1			
		endif
		if Game.IsPluginInstalled("SkyrimNet.esp")
			main.SoftCheckSkyrimNet = 1
		endif
		; If Game.GetModByName("sweepingOrganizesStuff.esp") != 255
		; 	SoftCheckSweepingOrganizesStuff = 1
		; EndIf
		runSoftchecks = 1
	EndIf

EndFunction

int lastLocationSafetyFlag = 0

function ProcessLocationChange(Location oldLocation, Location newLocation)

	;KEEP THIS - 3/8/25

	bool safeLocation = SafeLocationTest(newLocation)
	bind_Utility.WriteToConsole(newLocation.GetName() + " is safe: " + safeLocation)
	if safeLocation
		bind_GlobalSafeZone.SetValue(2)
		StorageUtil.SetIntValue(theSubRef, "bind_safe_area", 1)
		if lastLocationSafetyFlag == 2 || lastLocationSafetyFlag == 0
			;debug.MessageBox("entering a safe area")
			bind_Utility.WriteToConsole("Entering a safe area")
			bind_Utility.SendSimpleModEvent("bind_EnteringSafeAreaEvent")
		endif
		lastLocationSafetyFlag = 1
	else
		bind_GlobalSafeZone.SetValue(1)
		StorageUtil.SetIntValue(theSubRef, "bind_safe_area", 0)
		if lastLocationSafetyFlag == 1 || lastLocationSafetyFlag == 0
			;debug.MessageBox("entering a dangerous area")
			bind_Utility.WriteToConsole("Enter a dangerous area")
			bind_Utility.SendSimpleModEvent("bind_LeavingSafeAreaEvent")
		endif
		lastLocationSafetyFlag = 2
	endif

	bind_GlobalTimeEnteredLocation.SetValue(bind_Utility.GetTime())
	lastLocation = oldLocation
	currentLocation = newLocation

	if !theSubRef.GetParentCell().IsInterior()
		bind_GlobalTimeEnteredOutdoorLocation.SetValue(bind_Utility.GetTime())
		currentOutdoorLocation = newLocation
		TheSubCurrentOutdoorLocation.ForceLocationTo(newLocation)
	endif

	TheSubCurrentLocation.ForceLocationTo(newLocation)

	; bind_Utility.WriteToConsole("city or town: " + InCityOrTownCheck())

	; int checkValue = bind_GlobalLocationEnteredCheck.GetValue() as int
	; if InCityOrTownCheck()
	; 	if checkValue < 1
	; 		bind_GlobalRulesInEffect.SetValue(1) ;rules always on in cities and towns
	; 		bind_GlobalLocationEnteredCheck.SetValue(1) ;adventure quest will set to -1 after check
	; 	endif
	; else
	; 	if checkValue > -1
	; 		;if conditions for rules in mcm
	; 		bind_GlobalRulesInEffect.SetValue(0) ;suspend rules if mcm settings allow outside of towns and cities
	; 		;endif
	; 		bind_GlobalLocationEnteredCheck.SetValue(-1) ;adventure quest will set to -2 after check
	; 	endif
	; endif

	bool isIndoors = theSubRef.IsInInterior()

	if isIndoors
		main.SubIndoors = 1
	else
		main.SubIndoors = 0
	endif

	; bool enteringSafeArea = false
	; bool leavingSafeArea = false

	; int safeArea = bind_GlobalSafeZone.GetValue() as int
	; int newSafeArea = safeArea

	; if newLocation.HasKeyWord(LocTypeCity) || newLocation.HasKeyWord(LocTypeTown)

	; 	;bind_Utility.WriteToConsole("in city town")

	; 	if safeArea < 2 ;coming from unsafe area (or default)
	; 		newSafeArea = 2
	; 		enteringSafeArea = true
	; 	elseif safeArea == 3 ;leaving a building in the town or city
	; 		newSafeArea = 2
	; 		enteringSafeArea = false
	; 	endif

	; elseif isIndoors

	; 	;bind_Utility.WriteToConsole("in indoors")

	; 	if safeArea == 2 ;only set this to 3 if already in a city or town
	; 		newSafeArea = 3
	; 	endif

	; 	;don't set a default here, can't tell if interior is in a safe space without history
	
	; else

	; 	;bind_Utility.WriteToConsole("in other")

	; 	if safeArea == 2
	; 		newSafeArea = 1
	; 		leavingSafeArea = true
	; 	endif

	; 	if safeArea == 0
	; 		safeArea = 1 ;default
	; 	endif

	; endif

	; if enteringSafeArea

	; 	;TODO - modify the location change detection quest to be a normal quest
	; 	;start it here, and set a 30-60s update after the init
	; 	;have it check the nudity and bondage rules, status and suspended flags
	; 	;do a is running check to make sure it does not try to start again until it is completed (OK if this even fires many times while one quest run is happening)
	; 	;will not matter if the player leaves the safe area because it will check the state of whatever area they are in when the update happens
	; 	;newlocation - can match location alias on main quest vs. event data
	; 	;have quest auto strip and tie player if breaking rules
	; 	;UPDATE - the story manager location change event does not fire as often as needed when changing areas. this code might be stuck here.

	; 	;IDEA - could this just fire everytime an location change happens - then can use it to auto tie / untie
	; 	;and the 30-60 seconds should help deal with walking on the edge of zones??

	; 	if bind_GlobalSuspendHeavyBondage.GetValue() == 1.0
	; 		bind_GlobalSuspendHeavyBondage.SetValue(0)
	; 	endif

	; 	if bind_GlobalSuspendNudity.GetValue() == 1.0
	; 		bind_GlobalSuspendNudity.SetValue(0)
	; 	endif

	;     ; int handle = ModEvent.Create("bind_EnteringSafeAreaEvent")
	; 	; if handle
	;     ;     ModEvent.Send(handle)
	;     ; endif
	
	; elseif leavingSafeArea
		
	; 	if bind_GlobalSuspendHeavyBondage.GetValue() == 0.0
	; 		bind_GlobalSuspendHeavyBondage.SetValue(1)
	; 	endif

	; 	if bind_GlobalSuspendNudity.GetValue() == 0.0
	; 		bind_GlobalSuspendNudity.SetValue(1)
	; 	endif
	    
	; 	; int handle = ModEvent.Create("bind_LeavingSafeAreaEvent")
	;     ; if handle
	;     ;     ModEvent.Send(handle)
	;     ; endif

	; 	bind_Utility.WriteToConsole("clearning rules location permissions")
	; 	rman.ClearLocationPermissions() ;note - should be valid until you leave the city or town (should it be on entering also?)

	; endif

	; bind_GlobalSafeZone.SetValue(newSafeArea)
	; ;TODO - the safe area global flag could be a gate for all of the script events
	; ;so put on events can be gated to safe areas


	; bind_Utility.WriteToConsole("safe area: " + newSafeArea + " entering safe: " + enteringSafeArea + " leaving safe: " + leavingSafeArea + " indoors: " + isIndoors)

	; ;NOTE - run the rules check and rules suspend quest
	; if !bind_GoAdventuringQuest.IsRunning()
	; 	bind_GoAdventuringQuest.Start()
	; endif

	rman.ClearLocationPermissions(theSubRef)

	;clear stuff

	bind_GlobalLocationHasFurniture.SetValue(0)

endfunction

Function ProcessConversation()

	if main.IsSub == 0
		return
	endif

	;KEEP THIS - 3/8/25

	;Need a conversation manager?
	;need the abiltity scan the cell and use it to open up dialog options for permissions to speak
		;can I talk to this shopkeeper? (scan on kneel?)
		;this could be used for general posing also (always need to kneel for a jarl)
	;speaking options
		;not allowed at all?
			;maybe this opens the kneel to get the follower to speak to NPCS (like shopkeeper)
		;ask permission
		;posing before speaking

	if bcs.GetCurrentModState() != bind_Controller.GetModStateRunning()
		bind_Utility.WriteToConsole("ProcessConversation not in running state")
		inConversation = 2
		return
	endif

	bool result = true

	;result = cman.ConversationCheck(theSubRef, theDomRef) ; cman.ScanForNpcs(theSubRef, theDomRef)

	if theDomRef.IsInDialogueWithPlayer()
		result = false
	endif

	bind_Utility.WriteToConsole("conv check for dom failed: " + result)

	if result

		;If cman.IsSubInConversation()
			
		CalculateDistanceAtAction()
		;WindowOutput("the sub is having a conversation")

		;Speech Rule:Dom Speaks,Speech Rule:Must Ask,Speech Rule:Must Pose

		if rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_SPEECH_DOM()) == 1 ;rman.GetBehaviorRuleByName("Speech Rule:Dom Speaks") == 1
			float tempSpeakingPermission = StorageUtil.GetFloatValue(theSubRef, "bind_temp_speaking_permission", 0.0)
			if tempSpeakingPermission < bind_Utility.GetTime()
				MarkSubBrokeRule("What was I thinking? I am not allowed to speak", true)
			endif

		elseif rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_SPEECH_ASK()) == 1 ; rman.GetBehaviorRuleByName("Speech Rule:Must Ask") == 1
			if StorageUtil.GetIntValue(theSubRef, "bind_has_speech_permission", 0) == 0
				MarkSubBrokeRule("Oh no, I forgot to ask permission to speak", true)
			endif

		elseif rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_SPEECH_POSE()) == 1 ; rman.GetBehaviorRuleByName("Speech Rule:Must Pose") == 1
			if !pman.InConversationPose()
				MarkSubBrokeRule("Oh dear, I was not posed properly", true)
			endif

		elseif rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_ASK_TO_TRAIN()) == 1 ;rman.BehaviorStudiesAskToTrainMustAsk == 1
			Actor trainer = ConversationTargetNpc.GetReference() as Actor
			if trainer.IsInFaction(JobTrainerFaction)
				if rman.BehaviorStudiesAskToTrainPermission == 1
				else
					MarkSubBrokeRule("I can't speak to a trainer without asking first", true)
				endif
			endif

		endif

	EndIf

	inConversation = 2

EndFunction

ObjectReference subInFurnitureItemRef

;TODO - 3/24/25 move all of these permissions functions to the rules manager
Function SubEnteredFurniture(ObjectReference furn)
	
	LogOutput("SubEnteredFurniture()")

	if main.SoftCheckMME == 1 && main.EnableModMME == 1
		if !bind_DairyQuest.IsRunning()
			if furn.HasKeyWord(Keyword.GetKeyword("MME_zbfFurniture"))
				CalculateDistanceAtAction()
				MarkSubBrokeRule("I milked without having permission", true)
			endif
		endif
	endif

	subInFurnitureItemRef = furn

EndFunction

Function SubLeftFurniture(ObjectReference furn)
	
	LogOutput("SubLeftFurniture()")

	subInFurnitureItemRef = none

EndFunction

ObjectReference function GetSubInFurnitureItem()
	return subInFurnitureItemRef
endfunction

Function SubPrayedAtShrine()
	LogOutput("In SubPrayedAtShrine()")

	if main.IsSub == 0
		return
	endif

	bool result = true

	CalculateDistanceAtAction()

	;update dirt and blood
	; if SoftCheckDirtAndBlood == 1
	; 	SubDirtLevel = bind_DirtAndBloodHelper.ConvertCleanlinessToBinding(bind_DirtAndBloodHelper.GetCleanlinessLevel(theSubRef))
	; endif
	UpdateCleanTracking()

	;Prayer Rule:No Shoes,Prayer Rule:Nudity,Prayer Rule:Must Pose,Prayer Rule:Must Ask,Prayer Rule:Perfectly Clean,Prayer Rule:Whipped

	if rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_PRAYER_NUDITY())  == 1 ; rman.GetBehaviorRuleByName("Prayer Rule:Nudity") == 1
		if !gmanage.IsNude(theSubRef)
			bind_Utility.WriteInternalMonologue("Oh no, I forgot to take off my clothes...")
			result = false
		endif
	endif

	if rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_PRAYER_NO_SHOES())  == 1 ;rman.GetBehaviorRuleByName("Prayer Rule:No Shoes") == 1
		If !gmanage.IsWearingNoShoes(theSubRef)
			bind_Utility.WriteInternalMonologue("Oh my, I forgot to remove my shoes...")
			result = false
		EndIf
	endif

	if rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_PRAYER_MUST_POSE())  == 1 ;rman.GetBehaviorRuleByName("Prayer Rule:Must Pose") == 1
		If !pman.InPrayerPose() ; SubIdleState == IDLE_STATE_PRAYER
			bind_Utility.WriteInternalMonologue("By the Divines, I forgot to pose...")
			result = false
		EndIf
	endif

	if rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_PRAYER_MUST_ASK())  == 1 ;rman.GetBehaviorRuleByName("Prayer Rule:Must Ask") == 1
		if StorageUtil.GetIntValue(theSubRef, "bind_has_prayer_permission", 0) == 0
			bind_Utility.WriteInternalMonologue("By the Divines, I didn't ask to pray...")
			result = false
		endif
	endif

	if rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_PRAYER_CLEAN())  == 1 ;rman.GetBehaviorRuleByName("Prayer Rule:Perfectly Clean") == 1
		If main.SubDirtLevel > 0
			bind_Utility.WriteInternalMonologue("I am far too dirty to recieve blessings...")
			result = false
		EndIf
	endif

	if rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_PRAYER_WHIPPED())  == 1 ;rman.GetBehaviorRuleByName("Prayer Rule:Whipped") == 1
		;TODO - store last whipped time
		float lastWhipped = StorageUtil.GetFloatValue(theSubRef, "bind_last_whipped", 0.0)
		if bind_Utility.GetTime() - lastWhipped >= 1.0 || lastWhipped == 0.0
			bind_Utility.WriteInternalMonologue("I need to be red from a whip to recieve blessings...")
			result = false
		endif
	endif

	If result
		bind_Utility.WriteInternalMonologue("Hopefully the Divines will be pleased with my respect...")
		;TODO - tailor these to shrine
	else
		AdjustRuleInfractions(1)
		bind_Utility.WriteNotification("+1 infraction", bind_Utility.TextColorRed())
	EndIf

	;zero out permissions flags
	StorageUtil.SetIntValue(theSubRef, "bind_has_prayer_permission", 0)

EndFunction

Function SubUsedDoor(ObjectReference doorRef)
	LogOutput("SubUsedDoor()")

	if main.IsSub == 0
		return
	endif

	bool isIndoors = theSubRef.IsInInterior()

	ObjectReference destination = PO3_SKSEFunctions.GetDoorDestination(doorRef)
	if !destination
		bind_Utility.WriteToConsole("door " + doorRef + " has no destination")
		return
	endif

	Location doorLoc = destination.GetCurrentLocation()

	if !isIndoors
		;outdoor checks
		if doorLoc.HasKeywordString("LocTypeInn") && rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_ENTRY_INN())  == 1 ; rman.BehaviorEnterExitRuleInn == 1
		elseif doorLoc.HasKeywordString("LocTypeCastle") && rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_ENTRY_CASTLE())  == 1 ;rman.BehaviorEnterExitRuleCastle == 1
		elseif doorLoc.HasKeywordString("LocTypePlayerHouse") && rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_ENTRY_PLAYER_HOME())  == 1 ;rman.BehaviorEnterExitRulePlayerHome == 1
		else
			return ;permission not needed
		endif
	else
		;indoor checks
		if currentLocation.HasKeywordString("LocTypeInn") && rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_ENTRY_INN())  == 1 ;rman.BehaviorEnterExitRuleInn == 1
		elseif currentLocation.HasKeywordString("LocTypeCastle") && rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_ENTRY_CASTLE())  == 1 ;rman.BehaviorEnterExitRuleCastle == 1
		elseif currentLocation.HasKeywordString("LocTypePlayerHouse") && rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_ENTRY_PLAYER_HOME())  == 1 ;rman.BehaviorEnterExitRulePlayerHome == 1
		else
			return ;permission not needed
		endif
	endif

	bind_Utility.DoSleep(5.0) ;wait a few seconds for dom to arrive
	;CalculateDistanceAtAction()

	;int hasPermission = StorageUtil.GetIntValue(doorRef, "binding_door_permission", 0)
	;debug.MessageBox("permission: " + hasPermission)

    int permission = StorageUtil.GetIntValue(doorRef, "bind_door_sub_permission", 0)
    float permissionEndDate = StorageUtil.GetFloatValue(doorRef, "bind_door_sub_permission_end_date")

	bind_Utility.WriteToConsole("door permission: " + permission + " end date: " + permissionEndDate)

	string enterExitMsg = "enter"
	if isIndoors
		enterExitMsg = "leave"
	endif

	if permission == 1 && bind_Utility.GetTime() > permissionEndDate
		MarkSubBrokeRule("My permission to " + enterExitMsg + " expired", true)
	elseif permission == 1
		bind_Utility.WriteInternalMonologue("I had permssion to " + enterExitMsg + "...")
	else
		MarkSubBrokeRule("I did not have permission to " + enterExitMsg, true)
	endif

	StorageUtil.SetIntValue(doorRef, "bind_door_sub_permission", 0)

	; int doorType = StorageUtil.GetIntValue(doorRef, "binding_door_type", 0)
	; string doorName = StorageUtil.GetStringValue(doorRef, "binding_door_name", "")

	; bool brokeRule = false
	; if doorType == 10 || doorType == 20 || doorType == 30
	; 	if doorType == 10
	; 		if rman.BehaviorEnterExitRuleInnPermission != 1 && rman.BehaviorEnterExitRuleInn == 1
	; 			brokeRule = true
	; 		endif
	; 	elseif doorType == 20
	; 		if rman.BehaviorEnterExitRuleCastlePermission != 1 && rman.BehaviorEnterExitRuleCastle == 1
	; 			brokeRule = true
	; 		endif
	; 	elseif doorType == 30
	; 		if rman.BehaviorEnterExitRuleInnPermission != 1 && rman.BehaviorEnterExitRuleInn == 1
	; 			brokeRule = true
	; 		endif
	; 	endif
	; 	if brokeRule
	; 		CalculateDistanceAtAction()
	; 		bind_Utility.DoSleep(5.0)
	; 		MarkSubBrokeRule("I did not have permission to enter " + doorName)
	; 	endif

	; elseif doorType == 11 || doorType == 21 || doorType == 31
	; 	if doorType == 11
	; 		if rman.BehaviorEnterExitRuleInnPermission != 2 && rman.BehaviorEnterExitRuleInn == 1
	; 			brokeRule = true
	; 		endif
	; 	elseif doorType == 21
	; 		if rman.BehaviorEnterExitRuleCastlePermission != 2 && rman.BehaviorEnterExitRuleCastle == 1
	; 			brokeRule = true
	; 		endif
	; 	elseif doorType == 31
	; 		if rman.BehaviorEnterExitRuleInnPermission != 2 && rman.BehaviorEnterExitRuleInn == 1
	; 			brokeRule = true
	; 		endif
	; 	endif
	; 	if brokeRule
	; 		CalculateDistanceAtAction()
	; 		bind_Utility.DoSleep(5.0)
	; 		MarkSubBrokeRule("I did not have permission to leave " + doorName)
	; 	endif

	; endif

	; rman.BehaviorEnterExitRuleInnPermission = 3
	; rman.BehaviorEnterExitRuleCastlePermission = 3
	; rman.BehaviorEnterExitRuleInnPermission = 3


EndFunction

Function BedtimeCheck()

	if main.IsSub == 0
		return
	endif

	LogOutput("BedtimeCheck()")
	If rman.GetBehaviorRule(theSubRef, rman.BEHAVIOR_RULE_NO_BED())  == 1 ; rman.GetBehaviorRuleByName("Indoors Rule:No Beds") == 1 ;&& !EvHelpIsRunning()
		If theSubRef.IsInFaction(bind_InBoundSleepFaction)  ;SubIdleState != IDLE_STATE_BOUND_SLEEPING
			;WindowOutput("You broke the no beds rule...")
			CalculateDistanceAtAction()
			;DialogThreadVariantLevel2 = DIALOG_VARIANT_L2_NO_BEDS
			MarkSubBrokeRule("You broke the no beds rule...", true)
		EndIf
	EndIf
	; If EvHelpIsRunning()
	; 	If EventName == "Bound Bedtime" && EventPhase == 200
	; 		;WindowOutput("The sleep event ended!!!")
	; 		BedtimeSleepReturnToFurniture()
	; 	EndIf
	; EndIf
EndFunction

Function SubThanksForSex()

	LogOutput("SubThanksForSex()")

	bind_PoseManager.StandFromKneeling(theSubRef)

	sms.SubRequiredToThankForSex = 2

EndFunction

Function GrantEatDrinkPermission()
	
	LogOutput("GrantEatDrinkPermission()")

	bind_PoseManager.StandFromKneeling(theSubRef)

	rman.BehaviorFoodRuleMustAskPermission = 1
	;StorageUtil.SetIntValue(theSubRef, "bind_has_eat_drink_permission", 1)
	rman.BehaviorFoodRuleMustAskEndTime = bind_Utility.AddTimeToCurrentTime(0, 30) ;grant 30 minutes

	;SubEatDrinkPermission = 1
	;activatorEndEatDrink = bind_Utility.AddTimeToCurrentTime(0, 30)
	;StorageUtil.SetIntValue(theSubRef, "bind_has_eat_drink_permission", 1)
	;StorageUtil.SetFloatValue(theSubRef, "bind_has_eat_drink_permission_end", bind_Utility.AddTimeToCurrentTime(0, 30))

	bind_Utility.WriteInternalMonologue("I need to eat quickly...")

EndFunction

Function GrantLearnSpellPermission()

	LogOutput("GrantLearnSpellPermission()")

	bind_PoseManager.StandFromKneeling(theSubRef)

	;SubLearnSpellHasPermission = 1
	StorageUtil.SetIntValue(theSubRef, "bind_has_read_scroll_permission", 1)
	StorageUtil.SetFloatValue(theSubRef, "bind_has_read_scroll_permmission_end", bind_Utility.AddTimeToCurrentTime(1, 0))

	;activatorLearnSpells = bind_Utility.AddTimeToCurrentTime(1, 0)

	bind_Utility.WriteInternalMonologue("I need to do my studies...")

EndFunction

Function GrantSpeechPermission()
	LogOutput("GrantSpeechPermission()")

	bind_PoseManager.StandFromKneeling(theSubRef)

	;SubDialogueHasPermission = 1

	StorageUtil.SetIntValue(theSubRef, "bind_has_speech_permission", 1)

	bind_Utility.WriteInternalMonologue("I have permission to speak...")

EndFunction

Function GrantPrayerPermission()
	LogOutput("GrantPrayerPermission()")

	bind_PoseManager.StandFromKneeling(theSubRef)

	;SubPrayerHasPermission = 1

	StorageUtil.SetIntValue(theSubRef, "bind_has_prayer_permission", 1)

	bind_Utility.WriteInternalMonologue("I have permission to seek a blessing...")

	;Debug.MessageBox("prayer")

EndFunction

; Function GrantEntryExitPermission(bool entry)
; 	LogOutput("GrantEntryExitPermission()")

; 	bind_PoseManager.StandFromKneeling(theSubRef)

; 	int doorType = StorageUtil.GetIntValue(BuildingDoor.GetReference(), "binding_door_type", 0)
; 	string doorName = StorageUtil.GetStringValue(BuildingDoor.GetReference(), "binding_door_name", "")

; 	if doorType == 10 || doorType == 20 || doorType == 30
; 		if doorType == 10
; 			rman.BehaviorEnterExitRuleInnPermission = 1
; 		elseif doorType == 20
; 			rman.BehaviorEnterExitRuleCastlePermission = 1
; 		elseif doorType == 30
; 			rman.BehaviorEnterExitRuleInnPermission = 1
; 		endif
; 		bind_Utility.WriteInternalMonologue("I have permission to enter " + doorName)
; 	elseif doorType == 11 || doorType == 21 || doorType == 31
; 		if doorType == 11
; 			rman.BehaviorEnterExitRuleInnPermission = 2
; 		elseif doorType == 21
; 			rman.BehaviorEnterExitRuleCastlePermission = 2
; 		elseif doorType == 31
; 			rman.BehaviorEnterExitRuleInnPermission = 2
; 		endif
; 		bind_Utility.WriteInternalMonologue("I have permission to leave " + doorName)
; 	endif

; 	;StorageUtil.SetIntValue(BuildingDoor.GetReference(), "binding_door_permission", 1)


; EndFunction

function GrantMasturbationPermission()

	bind_PoseManager.StandFromKneeling(theSubRef)

	sms.SubHasMasturbationPermission = 1

	bind_Utility.WriteToConsole("masturbation permission: " + sms.SubHasMasturbationPermission)

endfunction

function GrantTalkToTrainerPermission() 

	bind_PoseManager.StandFromKneeling(theSubRef)

	rman.BehaviorStudiesAskToTrainPermission = 1
	rman.BehaviorStudiesAskToTrainEndTime = bind_Utility.AddTimeToCurrentTime(0, 15)

	bind_Utility.WriteInternalMonologue("I have 15 minutes to speak to this trainer...")

	bind_Utility.WriteToConsole("training permission: " + rman.BehaviorStudiesAskToTrainPermission)

endfunction

Function DeductPoint()
	if bind_GlobalPoints.GetValue() > 0
		bind_Utility.WriteNotification("A point has been deducted...", bind_Utility.TextColorBlue())
		bind_GlobalPoints.Mod(-1)
	else
		bind_Utility.WriteToConsole("DeductPoint is trying to go negative") ;this should not happen
	endif
EndFunction

function AddPoint()
	if bind_GlobalPoints.GetValue() < main.PointsMax
		bind_Utility.WriteNotification("You have gained a point...", bind_Utility.TextColorBlue())
		bind_GlobalPoints.Mod(1)
	endif
endfunction

int function GetPoints()
	return bind_GlobalPoints.GetValue() as int
endfunction

bool function GetPointsFromHarshBondage()
	return (main.PointsEarnFromHarshBondage == 1)
endfunction

bool function GetPointsFromFurniture()
	return (main.PointsEarnFromFurniture == 1)
endfunction

bool function GetPointsFromBeingGood()
	return (main.PointsEarnFromBeingGood == 1)
endfunction

Actor Function GetSubRef()
	return theSubRef
EndFunction

Actor Function GetDomRef()
	return theDomRef
EndFunction

string Function GetDomTitle()
	return domTitle
EndFunction

Function CalculateDistanceAtAction()
	main.SubDistanceFromDomAtAction = theSubRef.GetDistance(theDomRef)

	;TODO - line of sight check when under 3000 units
	; if (Game.GetPlayer().HasLOS(Bob_Alias.GetReference()))
	; 	Debug.Trace("The player can see Bob")
	;   endIf
EndFunction

function UpdateCleanTracking()
	If (main.SoftCheckDirtAndBlood == 1 && main.EnableModDirtAndBlood == 1)
		main.SubDirtLevel = bind_DirtAndBloodHelper.ConvertCleanlinessToBinding(bind_DirtAndBloodHelper.GetCleanlinessLevel(theSubRef))
		bind_Utility.WriteToConsole("updated clean from D&B: " + main.SubDirtLevel)
	elseif (main.SoftCheckBathingInSkyrim == 1 && main.EnableModBathingInSkyrim == 1)
		main.SubDirtLevel = bind_BathingInSkyrimHelper.ConvertCleanlinessToBinding(bind_BathingInSkyrimHelper.GetCleanlinessLevel(theSubRef))
		bind_Utility.WriteToConsole("updated clean from BISR: " + main.SubDirtLevel)
	else	
		;internal system
	endif
endfunction

bool function CleanModsRunning()
	If (main.SoftCheckDirtAndBlood == 1 && main.EnableModDirtAndBlood == 1)
		return true
	elseif (main.SoftCheckBathingInSkyrim == 1 && main.EnableModBathingInSkyrim == 1)
		return true
	else
		return false
	endif
endfunction

;TODO - 3/24/25 move all of the cleaning functions and bathing external mod functions to a cleaning/dirt manager
Function _CheckForBathing()
	If CleanModsRunning()
		; If theSubRef.IsSwimming()
		; 	If subWentForSwim == 0
		; 		subWentForSwim = 1
		; 	EndIf
		; Else
		; 	If subWentForSwim == 1 ;got out of the water
		; 		SubDirtLevel = bind_DirtAndBloodHelper.ConvertCleanlinessToBinding(bind_DirtAndBloodHelper.GetCleanlinessLevel(theSubRef))
		; 		WindowOutput("updated d&b clean level: " + SubDirtLevel)
		; 		subWentForSwim = 0
		; 	EndIf
		; EndIf
		return ;don't use the internal system d & b is detected
	EndIf
	If gmanage.IsNude(theSubRef)
		If theSubRef.IsSwimming()
			If main.SubDirtLevel == 0
				If main.DomPreferenceCleanSub == 1
					WindowOutput("You are fully cleaned...")
				EndIf
			Else
				If main.DomPreferenceCleanSub == 1
					WindowOutput("The water is washing away the dirt...")
				EndIf
				main.SubDirtLevel = main.SubDirtLevel - 50
				If main.SubDirtLevel < 0
					main.SubDirtLevel = 0
				EndIf
			EndIF
		EndIf
	EndIf
EndFunction

Function DirtFromCombat()
	If CleanModsRunning()
		return ;don't use the internal system d & b / bis is detected
	EndIf
	If main.IsSub == 0
		return
	EndIf
	main.SubDirtLevel = main.SubDirtLevel + 1
	If main.SubDirtLevel > 100
		;covered in muck
		main.SubDirtLevel = 100
	EndIf
	If main.DomPreferenceCleanSub == 0 ;zero this out if turned off
		main.SubDirtLevel = 0
	EndIf
EndFunction

Function HelperDisplayObjective(int num)
	If lastObjective != num
		SetObjectiveCompleted(lastObjective, true)
		SetObjectiveDisplayed(lastObjective, false)
	EndIf
	If num == OBJECTIVE_NONE
		SetObjectiveCompleted(num, true)
		SetObjectiveDisplayed(num, false)
	Else
		SetObjectiveCompleted(num, false)
		SetObjectiveDisplayed(num)
		lastObjective = num
	EndIf
EndFunction

Function WindowOutput(string msg)
	Debug.Notification(msg)
EndFunction

Function LogOutput(string msg, bool critical = false)
	bind_Utility.WriteToConsole(msg)
	; If WriteLogs == 1
	; 	If LogOutputToScreen == 1
	; 		Debug.Notification("[binding]: " + msg)
	; 	Else
	; 		;add MCM setting for all logging or just critical
	; 		Debug.Trace("[binding]: " + msg)
	; 	EndIf
	; EndIf
EndFunction

;TODO - 3/24/25 move all of the rules functions to the rules manager
int Function MarkSubBrokeRule(string msg = "", bool runDistanceCheck = false)
	if main.IsSub == 0
		return GetRuleInfractions()
	endif
	;DialogChanceRoll = Utility.RandomInt(0, 100)
	;Float speechRating = theSubRef.GetAV("Speechcraft")
	;int modifiedRoll = DialogChanceRoll + ((speechRating / 2.0) as int)
	;LogOutput("roll: " + DialogChanceRoll + " speech: " + speechRating + " mod: " + modifiedRoll)
	;DialogChanceRoll = modifiedRoll
	If (main.SubDistanceFromDomAtAction > 1500.0 && runDistanceCheck)
		If msg != ""
			bind_Utility.WriteInternalMonologue(msg + "...")
			bind_Utility.WriteInternalMonologue(domTitle + " is not here to notice...")
		Else
			bind_Utility.WriteInternalMonologue(domTitle + " is not here to notice I broke a rule...")
		EndIf
		;RuleInfractionsNotNoticedByDomUnconfessed += 1
		bind_GlobalTimesInfractionsNotNoticed.SetValue(bind_GlobalTimesInfractionsNotNoticed.GetValue() + 1)		
		return GetRuleInfractions()
	Else
		If main.DomChastiseForRuleBreaking == 1
			; ;WindowOutput(msg + "...")
			; If !EvHelpIsRunning()
			; 	Debug.MessageBox("DialogChanceRoll: " + DialogChanceRoll)
			; 	;ChastiseSubEvent()
			; 	brain.MarkInfraction()
			; 	AdjustRuleInfractions(1)
			; Else
			; 	WindowOutput("Good thing I am already being punished...")
			; 	; If msg != ""
			; 	; 	WindowOutput(msg + "... +1 infraction")
			; 	; Else
			; 	; 	WindowOutput("Rule broken... +1 infraction")
			; 	; EndIf
			; EndIf

		Else
			If msg != ""
				bind_Utility.WriteInternalMonologue(msg + "... +1 infraction")
			Else
				bind_Utility.WriteInternalMonologue("Oh no, I broke a rule... +1 infraction") ;this should never happen??
			EndIf
			;brain.MarkInfraction()
			AdjustRuleInfractions(1)
		EndIf
		return GetRuleInfractions()
	EndIf
EndFunction

int Function MarkSubPunished()
	;brain.MarkPunished()
	If GetRuleInfractions() > 0
		AdjustRuleInfractions(-1)
		;RuleInfractionPunishments += 1
		bind_GlobalTimesPunished.SetValue(bind_GlobalTimesPunished.GetValue() + 1)
		return GetRuleInfractions()
	Else
		return 0
	EndIf
EndFunction

;TODO - 3/24/25 move furniture menu stuff over to the action menu script
Function AddFurniture()

	WindowOutput("Placing furniture item...")

	fman.AddFurniture(theSubRef)

	; float newZ = theSubRef.GetAngleZ()

	; Form bfurn = Game.GetFormFromFile(0x07059B69, "zazanimationpack.esm")
	; ObjectReference obj = theSubRef.PlaceAtMe(bfurn, 1, true, true)
	; obj.SetAngle(0.0, 0.0, newZ)
	; obj.Enable()

EndFunction

Function FindNearestFurniture()

	If !fman.SelectFurniture(theSubRef)
		WindowOutput("No ZAP furniture could be found...")
	EndIf

	HelperDisplayObjective(OBJECTIVE_SELECTED_FURNITURE)

EndFunction

Function DeleteFurniture()

	If !fman.HasSelectedFurniture()
		WindowOutput("No furniture selected...")
		return
	EndIf

	fman.DeleteFurniture()

EndFunction

Function MoveFurniture()

	If !fman.HasSelectedFurniture()
		WindowOutput("No furniture selected...")
		return
	EndIf

	WindowOutput("this should not happen???")

	fman.MoveFurniture(theSubRef)

EndFunction

Function SetFurnitureAngleChange(float x, float y, float z)

	If !fman.HasSelectedFurniture()
		WindowOutput("No furniture selected...")
		return
	EndIf

	fman.SetFurnitureAngle(x, y, z)

EndFunction

Function SetFuniturePositionChange(float x, float y, float z)

	If !fman.HasSelectedFurniture()
		WindowOutput("No furniture selected...")
		return
	EndIf

	fman.SetFuniturePosition(x, y, z)

EndFunction

function SetBuildingDoor(ObjectReference d)
	BuildingDoor.ForceRefTo(d)
endfunction

function ClearBuildingDoor()
	BuildingDoor.Clear()
endfunction

function SetBuildingDoorLocation(Location l)
	BuildingDoorDestination.ForceLocationTo(l)
endfunction

function ClearBuildingDoorLocation()
	BuildingDoorDestination.Clear()
endfunction

function SetPublicSquareMarker(ObjectReference m)
	PublicSquareMarker.ForceRefTo(m)
endfunction

function ClearPublicSquareMarker()
	PublicSquareMarker.Clear()
endfunction

;#--------------------------------------------------------------------------------------------------------------
;#
;# 	Start Debug functions
;#
;#--------------------------------------------------------------------------------------------------------------

Function ClearPunishments()

	LogOutput("ClearPunishments()")

	WindowOutput("Debug: clearing punishments...")

	ResetRuleInfractions()

EndFunction

Function SafeWord()

	LogOutput("SafeWord()")

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		listMenu.AddEntryItem("Remove Binding Bondage")
		listMenu.AddEntryItem("Remove ALL Generic Bondage")
		listMenu.AddEntryItem("Remove Binding Bondage & Restore")
	EndIf

	bool removeAllGeneric = false
	bool restoreBondage = false

	listMenu.OpenMenu()
	int listReturn = listMenu.GetResultInt()
	if listReturn == 1
		removeAllGeneric = true
	elseif listReturn == 2
		restoreBondage = true
	endif

	if theSubRef.IsInFaction(fman.GetLockedInFurnitureFaction())
		Form dev = StorageUtil.GetFormValue(theSubRef, "binding_locked_in_furniture")
		if dev
			WindowOutput("Safeword: freeing from furniture...")
			bind_Utility.WriteToConsole("safeword - releasing from furniture: " + dev)
			fman.UnlockFromFurniture(theSubRef, dev as ObjectReference, true)
		endif
	endif

	; if fadeToBlackActive
	; 	FadeToBlackHoldImod.Remove()
	; 	fadeToBlackActive = false
	; endif

	; If slaveActionRunning
	; 	WindowOutput("Safeword: cancelling slave actions...")
	; 	slaveActionRunning =  0
	; EndIf

	WindowOutput("Safeword: removing bondage devices...")
	;bms.FreeAll(theSubRef, 0)
	;bind_BondageManager bms = (Quest.GetQuest("bind_mainquest") as bind_BondageManager)
	If removeAllGeneric
		;debug.MessageBox("bm: " + bms + " sub: " + theSubRef)
		bind_Utility.WriteToConsole("safeword - removing all generic bondage")
		bms.RemoveAllDetectedBondageItems(theSubRef)
	Else
		bind_Utility.WriteToConsole("safeword - removing stored bondage")
		bms.RemoveAllBondageItems(theSubRef)
	EndIf

	WindowOutput("Safeword: repairing bondage factions...")
	int i = 0
	while i < 18
		if !theSubRef.WornHasKeyWord(bms.GetDDKeyword(i))
			if theSubRef.IsInFaction(bms.WearingBondageItemFaction(i))
				bind_Utility.WriteToConsole("safeword - removing bondage faction " + i)
				theSubRef.RemoveFromFaction(bms.WearingBondageItemFaction(i))
			endif
		else
			;quest and non generic items can add back factions
			if !theSubRef.IsInFaction(bms.WearingBondageItemFaction(i))
				bind_Utility.WriteToConsole("safeword - adding bondage faction " + i)
				theSubRef.AddToFaction(bms.WearingBondageItemFaction(i))
			endif
		endif
		i += 1
	endwhile

	if restoreBondage
		WindowOutput("Safeword: re-applying bondage...")
		bms.UpdateBondage(theSubRef, false)
	endif

	FutureDom.Clear()

    int handle = ModEvent.Create("bind_SafewordEvent")
    if handle
		bind_Utility.WriteToConsole("safeword - sending safeword event")
        ModEvent.Send(handle)
    endif	

	if bcs.GetCurrentModState() == bind_Controller.GetModStateEvent()
		bind_Utility.WriteToConsole("safeword - changing event mod state back to running")
		bcs.DoEndEvent()
	endif

	pman.ResumeStanding()
	bind_Utility.EnablePlayer()
	;Debug.SendAnimationEvent(theSubRef, "IdleForceDefaultState")

	WindowOutput("Safeword: completed...")

EndFunction

;#--------------------------------------------------------------------------------------------------------------
;#
;# 	End Debug functions
;#
;#--------------------------------------------------------------------------------------------------------------

Function ShowFurnitureSelectionMenu()

	;string[] furnitureTypes = StringUtil.Split(fman.FurnitureList(), ",")

	string[] letters = bind_Utility.GetLetters()

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		listMenu.AddEntryItem("Return to Furniture Menu")
		listMenu.AddEntryItem("DDC Items")
		if main.SoftCheckDM3 == 1 && main.EnableModDM3 == 1
			listMenu.AddEntryItem("DM3 (DSE)")
		else
			listMenu.AddEntryItem("DM3 (DSE) - Not found or not enabled")
		endif

		int i = 0
		while i < letters.Length
			listMenu.AddEntryItem("ZAP Items " + letters[i])
			i += 1
		endwhile

		; int i = 0
		; while i < furnitureTypes.Length
		; 	listMenu.AddEntryItem(furnitureTypes[i])
		; 	i += 1
		; endwhile
	EndIf

	listMenu.OpenMenu()
	int listReturn = listMenu.GetResultInt()

	If listReturn == 0
		ShowFurniturePlacementMenu()
	elseif listReturn == 1
		ShowDDCFurnitureItems()
	elseif listReturn == 2
		if main.SoftCheckDM3 == 1 && main.EnableModDM3 == 1
			ShowDSEFurnitureItems()
		else
			Debug.MessageBox("DM3 (DSE) was not found or is not enabled")
		endif
	elseif listReturn > 2
		ShowZAPFurnitureItems(letters[listReturn - 3])
	; Else
	; 	fman.SetSelectedFuniture(furnitureTypes[listReturn - 1])
	; 	bind_Utility.DoSleep(1.0)
	; 	AddFurniture()
	EndIf

EndFunction

function ShowDDCFurnitureItems()

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		listMenu.AddEntryItem("Return to Furniture Menu")
		int i = 0
		while i < bind_DDCFurnitureList.GetSize()
			Form dev = bind_DDCFurnitureList.GetAt(i)
			listMenu.AddEntryItem(dev.GetName())
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int listReturn = listMenu.GetResultInt()

	If listReturn == 0
		ShowFurnitureSelectionMenu()
	else
		Form dev = bind_DDCFurnitureList.GetAt(listReturn - 1)
		if dev
			debug.MessageBox("DDC adding: " + dev.GetName() + " form: " + dev)
			fman.AddFurnitureByForm(theSubRef, dev)
		else
			Debug.MessageBox("Could not get DDC furniture from list")
		endif
	endif

endfunction

function ShowDSEFurnitureItems()

	if main.SoftCheckDM3 == 1

		if bind_DSEFurnitureList.GetSize() == 0
			bind_DM3Helper.BuildFormList(bind_DSEFurnitureList)
		endif

		UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
		if listMenu
			listMenu.AddEntryItem("Return to Furniture Menu")
			int i = 0
			while i < bind_DSEFurnitureList.GetSize()
				Form dev = bind_DSEFurnitureList.GetAt(i)
				listMenu.AddEntryItem(dev.GetName())
				i += 1
			endwhile
		EndIf
	
		listMenu.OpenMenu()
		int listReturn = listMenu.GetResultInt()
	
		If listReturn == 0
			ShowFurnitureSelectionMenu()
		else
			Form dev = bind_DSEFurnitureList.GetAt(listReturn - 1)
			if dev
				debug.MessageBox("DM3 (DSE) adding: " + dev.GetName() + " form: " + dev)
				fman.AddFurnitureByForm(theSubRef, dev)
			else
				Debug.MessageBox("Could not get DM3 (DSE) furniture from list")
			endif
		endif
	

	endif

endfunction

Function ShowZAPFurnitureItems(string letter)

	string[] itemNames = new string[128]
	Form[] items = new Form[128]
	int itemNameIdx = 0

	UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
	if listMenu
		listMenu.AddEntryItem("Return to Furniture Menu")
		int i = 0
		while i < bind_ZapFurnitureList.GetSize()
			string item = bind_ZapFurnitureList.GetAt(i).GetName()
			if StringUtil.SubString(item, 0, 1) == letter
				Form dev = bind_ZapFurnitureList.GetAt(i)
				itemNames[itemNameIdx] = dev.GetName()
				items[itemNameIdx] = dev
				itemNameIdx += 1
				listMenu.AddEntryItem(PO3_SKSEFunctions.GetFormEditorID(dev) + " - " + dev.GetName()) ;PO3_SKSEFunctions.GetFormEditorID(dev)
			endif
			i += 1
		endwhile
	EndIf

	listMenu.OpenMenu()
	int listReturn = listMenu.GetResultInt()

	If listReturn == 0
		ShowFurnitureSelectionMenu()
	Else
		string selectedName = itemNames[listReturn - 1]
		Form dev = items[listReturn - 1]
		debug.MessageBox("ZAP adding: " + selectedName + " form: " + dev)
		if selectedName != ""
			if dev
				fman.AddFurnitureByForm(theSubRef, dev)
			else
				Debug.MessageBox("Could not get ZAP furniture " + selectedName + " from list")
			endif
		endif
	EndIf

endfunction

Function ShowFurniturePlacementMenu()

	float distanceToMovePlus = 10.0
	float distanceToMoveMinus = distanceToMovePlus * -1

	UIListMenu furnMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

	furnMenu.AddEntryItem("<-- Return to Menu") ;1
	furnMenu.AddEntryItem("Add Item") ;2
	furnMenu.AddEntryItem("Select Nearest") ;3
	furnMenu.AddEntryItem("Move") ;4
	furnMenu.AddEntryItem("Delete") ;5
	furnMenu.AddEntryItem("Angle X + " + distanceToMovePlus) ;6
	furnMenu.AddEntryItem("Angle X - " + distanceToMovePlus) ;7
	furnMenu.AddEntryItem("Angle Y + " + distanceToMovePlus) ;8
	furnMenu.AddEntryItem("Angle Y - " + distanceToMovePlus) ;9
	furnMenu.AddEntryItem("Angle Z + " + distanceToMovePlus) ;10
	furnMenu.AddEntryItem("Angle Z - " + distanceToMovePlus) ;11
	furnMenu.AddEntryItem("Position X + " + distanceToMovePlus) ;12
	furnMenu.AddEntryItem("Position X - " + distanceToMovePlus) ;13
	furnMenu.AddEntryItem("Position Y + " + distanceToMovePlus) ;14
	furnMenu.AddEntryItem("Position Y - " + distanceToMovePlus) ;15
	furnMenu.AddEntryItem("Position Z + " + distanceToMovePlus) ;16
	furnMenu.AddEntryItem("Position Z - " + distanceToMovePlus) ;17

	furnMenu.OpenMenu()
	int furnResult = furnMenu.GetResultInt()

	If furnResult == 0
		;ShowActionMenu()
	ElseIf furnResult == 1
		ShowFurnitureSelectionMenu()
		;AddFurniture()
	ElseIf furnResult == 2
		FindNearestFurniture()
	ElseIf furnResult == 3
		MoveFurniture()
	ElseIf furnResult == 4
		DeleteFurniture()
	ElseIf furnResult == 5
		SetFurnitureAngleChange(distanceToMovePlus, 0.0, 0.0)
	ElseIf furnResult == 6
		SetFurnitureAngleChange(distanceToMoveMinus, 0.0, 0.0)
	ElseIf furnResult == 7
		SetFurnitureAngleChange(0.0, distanceToMovePlus, 0.0)
	ElseIf furnResult == 8
		SetFurnitureAngleChange(0.0, distanceToMoveMinus, 0.0)
	ElseIf furnResult == 9
		SetFurnitureAngleChange(0.0, 0.0, distanceToMovePlus)
	ElseIf furnResult == 10
		SetFurnitureAngleChange(0.0, 0.0, distanceToMoveMinus)
	ElseIf furnResult == 11
		SetFuniturePositionChange(distanceToMovePlus, 0.0, 0.0)
	ElseIf furnResult == 12
		SetFuniturePositionChange(distanceToMoveMinus, 0.0, 0.0)
	ElseIf furnResult == 14
		SetFuniturePositionChange(0.0, distanceToMovePlus, 0.0)
	ElseIf furnResult == 15
		SetFuniturePositionChange(0.0, distanceToMoveMinus, 0.0)
	ElseIf furnResult == 16
		SetFuniturePositionChange(0.0, 0.0, distanceToMovePlus)
	ElseIf furnResult == 17
		SetFuniturePositionChange(0.0, 0.0, distanceToMoveMinus)
	EndIf

EndFunction








event EnteringSafeAreaEvent()

	bind_Utility.WriteInternalMonologue("I am entering a safe area...")

	; StorageUtil.SetIntValue(theSubRef, "bind_safe_area_interaction_check", 1) ;set to starting

	; if theDomRef.GetDistance(theSubRef) < 1500.0

	; 	bool nudityRuleFlag = rman.IsNudityRequired(theSubRef, true) 

	; 	;debug.MessageBox(nudityRuleFlag)

	; 	if nudityRuleFlag
	; 		gmanage.RemoveWornGear(theSubRef)
	; 	endif

	; 	bms.UpdateBondage(theSubRef, false)

	; 	StorageUtil.SetIntValue(theSubRef, "bind_safe_area_interaction_check", 2) ;set to completed

	; else

	; 	;NOTE - need the dom to do an LOS check and run the rule enforcement code when they see the sub

	; 	bind_Utility.WriteInternalMonologue(GetDomTitle() + " is not nearby to enforce my rules...")

	; 	StorageUtil.SetIntValue(theSubRef, "bind_safe_area_interaction_check", 3) ;set to to-do

	; endif

endevent

event LeavingSafeAreaEvent()

	bind_Utility.WriteInternalMonologue("I am leaving a safe area. I must be on guard...")

	; StorageUtil.SetIntValue(theSubRef, "bind_safe_area_interaction_check", 0) ;set to off

	; bool nudityRuleFlag = rman.IsNudityRequired(theSubRef, false) 

	; ;debug.MessageBox(nudityRuleFlag)

	; bms.UpdateBondage(theSubRef, false)

	; if !nudityRuleFlag
	; 	gmanage.RestoreWornGear(theSubRef)
	; endif

endevent

event OnPauseStart()
	int restoredGear = 0
	int removedBondage = 0
	if bms.IsInBondage(theSubRef)
		bms.SnapshotCurrentBondage(theSubRef)
		bms.RemoveAllDetectedBondageItems(theSubRef)
		removedBondage = 1
	endif
	if gmanage.IsNude(theSubRef)
		gmanage.RestoreWornGear(theSubRef)
		restoredGear = 1
	endif
	StorageUtil.SetIntValue(theSubRef, "binding_pause_restored_gear", restoredGear)
	StorageUtil.SetIntValue(theSubRef, "binding_pause_removed_bondage", removedBondage)
endevent

event OnPauseEnd()
	if StorageUtil.GetIntValue(theSubRef, "binding_pause_restored_gear", 0) == 1
		gmanage.RemoveWornGear(theSubRef)
	endif
	if StorageUtil.GetIntValue(theSubRef, "binding_pause_removed_bondage", 0) == 1
		bms.RestoreFromSnapshot(theSubRef)
	endif
endevent

function SetNpcDom(Actor dom)

	if theSubRef == none
		theSubRef = Game.GetPlayer()
	endif

	StorageUtil.SetIntValue(dom, "bind_old_rank", dom.GetRelationshipRank(theSubRef))

	dom.SetRelationshipRank(theSubRef, 4) ;make lover - NOTE: this will have to happen at load also (templated actors clear?)

	main.DomDoorDiscovery = 1 ;turn this flag on to find dom's house faction (code in player alias script - crosshair)

	Form[] inventory = dom.GetContainerForms()
	int i = 0
	while i < inventory.Length
		Form item = inventory[i]
		bind_Utility.WriteToConsole("Inventory: " + item.GetName() + " type: " + item.GetType())
		if item.GetType() == 45
			bind_Utility.WriteToConsole("giving player a copy of the house key")
			theSubRef.AddItem(item, 1)
		endif
		i += 1
	endwhile

	if !dom.IsInFaction(bind_DominantNpcFaction)
		dom.AddToFaction(bind_DominantNpcFaction) ;special faction to account for dom not being near sub often - new dialogue / quests?
	endif

	SetDom(dom)

endfunction

function SetDom(Actor dom)

	;todo - remove this start
	if theSubRef == none
		theSubRef = Game.GetPlayer()
	endif
	;todo - remove this end

	TheDom.ForceRefTo(dom)
	theDomRef = dom

	;bcs.SetDom(dom)

	; if !theDomRef.IsInFaction(bind_DominantFaction)
	; 	theDomRef.AddToFaction(bind_DominantFaction)
	; endif

	FutureDom.Clear() ;clear this in case it was filled

	ActorBase domActorBase = dom.GetActorBase()

	main.DominantName = domActorBase.GetName()
	main.DominantSex = domActorBase.GetSex()
	if domTitle == "Mistress" || domTitle == "Master" ;NOTE - only toggle this if the user has not set a custom title
		If main.DominantSex == 1
			domTitle = "Mistress"
		Else
			domTitle = "Master"
		EndIf
	endif

	StorageUtil.SetStringValue(theDomRef, "bind_dom_new_name", domTitle)

	Actor tc = TitleContainer.GetReference() as Actor
	tc.GetActorBase().SetName(domTitle)

	main.IsSub = 1

	if !theSubRef.IsInFaction(bind_SubmissiveFaction)
		theSubRef.AddToFaction(bind_SubmissiveFaction)
	endif

	HelperDisplayObjective(OBJECTIVE_BE_GOOD)

	Location l
	l = theDomRef.GetCurrentLocation()
	ProcessLocationChange(l, l)

	if bind_DefeatedQuest.IsRunning()
		bind_DefeatedQuest.Stop()
	endif

endfunction

string function SettingsGetDomTitle()
	return domTitle
endfunction

function SettingsSetDomTitle()

    UIExtensions.InitMenu("UITextEntryMenu")
    UIExtensions.OpenMenu("UITextEntryMenu")
    string result = UIExtensions.GetMenuResultString("UITextEntryMenu")

    if result != ""
		StorageUtil.SetStringValue(theDomRef, "bind_dom_new_name", result)
		Actor tc = TitleContainer.GetReference() as Actor
		tc.GetActorBase().SetName(result)
		domTitle = result
    endif

endfunction

ObjectReference function EventGetNearbyBed()
	return NearbyBed.GetReference()
endfunction

function SetNearbyBed(ObjectReference bed)
	NearbyBed.ForceRefTo(bed)
endfunction

function ClearNearbyBed()
	NearbyBed.Clear()
endfunction

function EventSetWordWall(ObjectReference ww)
	TheWordWall.ForceRefTo(ww)
endfunction

function EventClearWordWall()
	TheWordWall.Clear()
endfunction

function EventSetFurniture(ObjectReference furn)
	furniture1 = furn
	Furniture1Ref.ForceRefTo(furn)
endfunction

function EventClearFurniture()
	furniture1 = none
	Furniture1Ref.Clear()
endfunction

ObjectReference function EventGetFurniture()
	if furniture1 == none
		if Furniture1Ref.GetReference() != none
			furniture1 = Furniture1Ref.GetReference()
		endif
	endif
	return furniture1
endfunction

bool function EventHasFurniture()
	if furniture1 == none
		if Furniture1Ref.GetReference() != none
			furniture1 = Furniture1Ref.GetReference()
		endif
	endif
	if furniture1 != none
		return true
	else
		return false
	endif
endfunction

int function GetRuleInfractions()
	return bind_GlobalInfractions.GetValue() as int
endfunction

function AdjustRuleInfractions(int changeBy)
	bind_Utility.WriteToConsole("current infractions: " + bind_GlobalInfractions.GetValue() + " change by: " + changeBy)
	;RuleInfractions += changeBy
	if changeBy > 0
		bind_GlobalInfractionsMostRecent.SetValue(bind_Utility.GetTime()) ;set last infraction time
	endif
	bind_GlobalInfractions.SetValue(bind_GlobalInfractions.GetValue() + changeBy)
endfunction

function ResetRuleInfractions()
	bind_Utility.WriteToConsole("clearing infractions")
	;RuleInfractions = 0
	bind_GlobalInfractions.SetValue(0)
endfunction

float function GetMostRecentInfraction()
	return bind_GlobalInfractionsMostRecent.GetValue()
endfunction

; int function GetEventHandleBondageFreeWristsAddGag()
; ; int EVENT_HANDLE_BONDAGE_NOCHANGES = 0
; ; int EVENT_HANDLE_BONDAGE_FREEWRISTS = 3
; ; int EVENT_HANDLE_BONDAGE_ONLY_KEEP_DECORATIONS = 4
; 	return EVENT_HANDLE_BONDAGE_FREEWRISTS_ADDGAG
; endfunction

; int function GetEventHandleBondageRemoveAll()
; 	return EVENT_HANDLE_BONDAGE_REMOVEALL
; endfunction

function SetConversationTargetNpc(Actor a)
	ConversationTargetNpc.ForceRefTo(a)
endfunction

function ClearConversationTargetNpc()
	ConversationTargetNpc.Clear()
endfunction

ObjectReference function GetConversationTarget()
	return ConversationTargetNpc.GetReference()
endfunction

Location function GetCurrentLocation()
	return currentLocation
endfunction

bool eventRemovedClothing

function EventGetSubReady(Actor sub, Actor dom, bool playAnimations = true, bool stripClothing = true, bool addGag = false, bool freeWrists = false, bool removeAll = false)

	eventRemovedClothing = false

    bind_MovementQuestScript.WalkTo(dom, sub)

	bind_MovementQuestScript.FaceTarget(dom, sub)
	bind_Utility.DoSleep()

	if playAnimations
    	bind_MovementQuestScript.PlayDoWork(dom)
	endif

    if bms.SnapshotCurrentBondage(sub)
        bind_Utility.DoSleep()
    endif

	if removeAll
		if bms.RemoveAllDetectedBondageItems(sub) ; bms.RemoveAllBondageItems(sub)
			bind_Utility.DoSleep(1.0)
		endif
	else
		if sub.IsInFaction(bms.WearingHeavyBondageFaction()) && freeWrists
			bms.RemoveItem(sub, bms.BONDAGE_TYPE_HEAVYBONDAGE())
			bind_Utility.DoSleep()
		endif
	endif

    if !sub.IsInFaction(bms.WearingGagFaction()) && addGag
        bms.AddItem(sub, bms.BONDAGE_TYPE_GAG())
        bind_Utility.DoSleep()
    endif

	if !gmanage.IsNude(sub) && stripClothing
		if gmanage.RemoveWornGear(sub)
			eventRemovedClothing = true
			bind_Utility.DoSleep(1.0)
		endif
	endif

endfunction

function EventCleanUpSub(Actor sub, Actor dom, bool playAnimations = true)

    bind_MovementQuestScript.WalkTo(dom, sub)

	bind_MovementQuestScript.FaceTarget(dom, sub)
	bind_Utility.DoSleep()

	if playAnimations
    	bind_MovementQuestScript.PlayDoWork(dom)
	endif

    if bms.RemoveAllDetectedBondageItems(sub)
        bind_Utility.DoSleep(1.0)
    endif

	if eventRemovedClothing
		if gmanage.RestoreWornGear(sub)
			bind_Utility.DoSleep(1.0)
		endif
	endif

    if bms.RestoreFromSnapshot(sub)
        bind_Utility.DoSleep(1.0)
    endif

endfunction

function EventDomTyingAnimation(Actor sub, Actor dom, bool rotateSub = false)

	if sub.GetDistance(dom) > 160.0
		bind_MovementQuestScript.WalkTo(dom, sub)
	endif

	bind_MovementQuestScript.FaceTarget(dom, sub)
	bind_Utility.DoSleep()

	if rotateSub
		bind_MovementQuestScript.FaceAwayFromTarget(sub, dom)
		bind_Utility.DoSleep()
	endif

	bind_MovementQuestScript.PlayDoWork(dom)

endfunction

bool function InCityOrTownCheck()
	if currentOutdoorLocation.HasKeyWord(LocTypeCity) || currentOutdoorLocation.HasKeyWord(LocTypeTown)
		return true
	else
		return false
	endif
endfunction

int function GetModState()
	return bcs.bind_GlobalModState.GetValue() as int
endfunction

bool function ModInRunningState()
	if bcs.bind_GlobalModState.GetValue() == bind_Controller.GetModStateRunning()
		return true
	else
		return false
	endif
endfunction

function GoldToCharity()

	float minGold = bind_GlobalPunishmentMinGold.GetValue()
	float maxGold = bind_GlobalPunishmentMaxGold.GetValue()
	float goldPct = bind_GlobalPunishmentGoldPercentage.GetValue()

	float goldQty = theSubRef.GetGoldAmount()

	float removeGold = goldQty * (goldPct * 0.01)

	bind_Utility.WriteToConsole("goldtocharity remove gold: " + removeGold)

	if removeGold < minGold
		removeGold = minGold
		bind_Utility.WriteToConsole("ajusted to min - " + removeGold)
	elseif removeGold > maxGold
		removeGold = maxGold
		bind_Utility.WriteToConsole("ajusted to max - " + removeGold)
	endif

	int fixedRemove = Math.Floor(removeGold)

	theSubRef.RemoveItem(Gold, fixedRemove)

	If GetRuleInfractions() > 0
		MarkSubPunished()
	EndIf

	;TODO - add some dialog to the poor of skyrim to give thanks?

	WindowOutput(GetDomTitle() + " will redistribute my " + fixedRemove + " gold to the needy of Skyrim...")

endfunction

bool Function SafeLocationTest(Location l)

	bool isSafe = false
	bool parentSafe = false
	int i = 0

	bool isIndoors = theSubRef.IsInInterior()

	bind_Utility.WriteToConsole("Testing location: " + l.GetName() + " indoors: " + isIndoors)

	if isIndoors
		while i < bind_SafeLocationTypesList.GetSize()
			if l.HasKeyWord(bind_SafeLocationTypesList.GetAt(i) as Keyword)
				isSafe = true
				bind_Utility.WriteToConsole("Found keyword: " + i)
			endif
			i += 1
		endwhile
	else
		while i < bind_SafeOutdoorLocationsTypeList.GetSize()
			if l.HasKeyWord(bind_SafeOutdoorLocationsTypeList.GetAt(i) as Keyword)
				isSafe = true
				bind_Utility.WriteToConsole("Found keyword: " + i)
			endif
			i += 1
		endwhile
	endif

	;TODO - run city, hold, town tests first and break

	; i = 0
	; while i < bind_SafeLocationTypesList.GetSize()
	; 	if l.HasKeyWord(bind_SafeLocationTypesList.GetAt(i) as Keyword)
	; 		isSafe = true
	; 		bind_Utility.WriteToConsole("Found keyword: " + i)
	; 	endif
	; 	i += 1
	; endwhile

	; ; bool isIndoors = theSubRef.IsInInterior()

	; ; if isIndoors
	; ; 	main.SubIndoors = 1
	; ; else
	; ; 	parentSafe = true ;no need to test if outdoors
	; ; endif

	; Location p = PO3_SKSEFunctions.GetParentLocation(l)
	; if p
	; 	bind_Utility.WriteToConsole("Testing parent location: " + p.GetName())
	; 	i = 0
	; 	while i < bind_SafeLocationTypesList.GetSize()
	; 		if l.HasKeyWord(bind_SafeLocationTypesList.GetAt(i) as Keyword)
	; 			parentSafe = true
	; 			bind_Utility.WriteToConsole("Found keyword: " + i)
	; 		endif
	; 		i += 1
	; 	endwhile
	; endif

	; bind_Utility.WriteToConsole("results - safe: " + isSafe + " parent safe: " + parentSafe)

	; if !parentSafe
	; 	isSafe = false
	; endif

	; ; bool clearable = l.HasKeyWord(Keyword.GetKeyword("LocTypeClearable"))

	; ; bind_Utility.WriteToConsole("clearable: " + clearable)

	; ; if clearable
	; ; 	isSafe = false
	; ; endif

	return isSafe

endfunction

bind_Functions function GetBindingFunctions() global
	return Quest.GetQuest("bind_MainQuest") as bind_Functions
endfunction

int function PlayerIsSub()
	return main.IsSub
endfunction

int function SubInBondage()
	int result = 0
	if bms.IsInBondage(theSubRef)
		result = 1
	endif
	return result
endfunction

int function SubIsGagged()
	int result = 0
	if bms.IsGagged(theSubRef)
		result = 1
	endif
	return result
endfunction

bool function UseSkyrimNetCheck(Actor akActor)
	return (main.EnableModSkyrimNet == 1 && main.IsSub == 1 && theDomRef == akActor && ModInRunningState())
endfunction

bool function LocationHasFurniture()
	return (bind_GlobalLocationHasFurniture.GetValue() == 1)
endfunction

function PoseForSex()
	if ModInRunningState()
		if theSubRef.GetDistance(theDomRef) > 1000.0
			bind_Utility.WriteInternalMonologue(GetDomTitle() + " is not around to have sex with me...")
		else
			int domArousal = bind_SlaHelper.GetArousal(theDomRef)
			bind_Utility.WriteToConsole("dom arousal: " + domArousal + " triggers at: " + main.SexDomArousalLevelToTrigger)
			if domArousal >= main.SexDomArousalLevelToTrigger
				if theSubRef.GetDistance(theDomRef) > 160.0
					bind_MovementQuestScript.WalkTo(theDomRef, theSubRef)
					bind_Utility.DoSleep(2.0)
				endif
				pman.ResumeStanding()
				if !bind_BoundSexQuest.IsRunning()
					bind_BoundSexQuest.Start()
				endif
			else
				bind_Utility.WriteInternalMonologue(GetDomTitle() + " does not seem to want to fuck me...")
			endif
		endif
	endif
endfunction

function PoseForWhipping()
	if ModInRunningState()
		if theSubRef.GetDistance(theDomRef) > 1000.0
			bind_Utility.WriteInternalMonologue(GetDomTitle() + " is not around to whip me...")
		else
			if theSubRef.GetDistance(theDomRef) > 160.0
				bind_MovementQuestScript.WalkTo(theDomRef, theSubRef)
				bind_Utility.DoSleep(2.0)
			endif
			pman.ResumeStanding()
			if !bind_WhippingQuest.IsRunning()
				bind_WhippingQuest.Start()
			endif
		endif
	endif
endfunction

function PoseForSleep()
	if ModInRunningState()
		if !bind_KneelingQuest.IsRunning()
			bind_KneelingQuest.Start()
			bind_Utility.DoSleep(2.0)
		endif
		ObjectReference bed = EventGetNearbyBed()
		;debug.MessageBox("bed: " + bed)
		if bed
			if bed.GetDistance(theSubRef) < 1000.0
				if theSubRef.GetDistance(theDomRef) > 160.0
					bind_MovementQuestScript.WalkTo(theDomRef, theSubRef)
					bind_Utility.DoSleep(2.0)
				endif				
				pman.ResumeStanding()
				if !bind_EventBoundSleepQuest.IsRunning()
					bind_EventBoundSleepQuest.Start()
				endif
			else
				bind_Utility.WriteInternalMonologue("I am not close enough to the bed...")
			endif
		endif
	endif
endfunction

function PoseForBondage()
    
	if theSubRef.GetDistance(theDomRef) > 1000.0
        bind_Utility.WriteInternalMonologue(GetDomTitle() + " is not around to help me...")
        return
    endif

    bool safeZone = (bind_GlobalSafeZone.GetValue() >= 2.0)
    bool isBoundFlag = theSubRef.IsInFaction(bms.WearingHeavyBondageFaction())
    bool boundRule = rman.IsHeavyBondageRequired(theSubRef, safeZone) 

    bind_Utility.DisablePlayer()
    if !isBoundFlag
		if theSubRef.GetDistance(theDomRef) > 160.0
			bind_MovementQuestScript.WalkTo(theDomRef, theSubRef)
			bind_Utility.DoSleep(2.0)
		endif
		pman.ResumeStanding()
        EventDomTyingAnimation(theSubRef, theDomRef, true)
        ;debug.MessageBox("bms: " + bms + " type " + bms.BONDAGE_TYPE_HEAVYBONDAGE())
        if bms.AddItem(theSubRef, bms.BONDAGE_TYPE_HEAVYBONDAGE())
        endif
    else
        if !boundRule ;|| rms.SuspendedHeavyBondage()
			if theSubRef.GetDistance(theDomRef) > 160.0
				bind_MovementQuestScript.WalkTo(theDomRef, theSubRef)
				bind_Utility.DoSleep(2.0)
			endif
			pman.ResumeStanding()
            EventDomTyingAnimation(theSubRef, theDomRef, true)
            if bms.RemoveItem(theSubRef, bms.BONDAGE_TYPE_HEAVYBONDAGE())
            endif
        else
            bind_MovementQuestScript.MakeComment(theDomRef, theSubRef, bind_MovementQuestScript.GetCommentTypeRefuseToUntie())
        endif
    endif
    bind_Utility.EnablePlayer()

endfunction



bind_ThinkingDom property brain auto
bind_BondageManager property bms auto
bind_GearManager property gmanage auto
bind_FurnitureManager property fman auto
bind_PoseManager property pman auto
bind_RulesManager property rman auto
bind_SexManager property sms auto
bind_MainQuestScript property main auto
bind_Controller property bcs auto

ReferenceAlias property TheDom auto
ReferenceAlias property TheSub auto
ReferenceAlias property NearbyBed auto
ReferenceAlias property FutureDom auto
ReferenceAlias property TitleContainer auto
ReferenceAlias property BuildingDoor auto
ReferenceAlias property TheWordWall auto
ReferenceAlias property ConversationTargetNpc auto
ReferenceAlias property PublicSquareMarker auto
ReferenceAlias property Furniture1Ref auto

LocationAlias property TheSubCurrentLocation auto
LocationAlias property TheSubCurrentOutdoorLocation auto
LocationAlias property BuildingDoorDestination auto

MiscObject property Gold auto

Keyword property LocTypeClearable auto
Keyword property LocTypeInn auto  
Keyword property LocTypeCastle auto  
Keyword property LocTypeCity auto  
Keyword property LocTypeTown auto
Keyword property LocTypeStore auto  
Keyword property LocTypeDungeon auto
Keyword property LocTypeDwelling auto
Keyword property LocTypePlayerHouse auto
Keyword property LocTypeHouse auto

Faction property bind_DominantFaction auto
Faction property bind_DominantNpcFaction auto
Faction property bind_SubmissiveFaction auto
Faction property bind_InBoundSleepFaction auto
Faction property bind_InHogtiedFaction auto
Faction property bind_KneelingFaction auto

Faction property bind_FutureDomFaction auto

Faction property JobTrainerFaction auto



GlobalVariable property bind_GlobalInfractions auto
GlobalVariable property bind_GlobalInfractionsMostRecent auto
GlobalVariable property bind_GlobalTimesInfractionsNotNoticed auto
GlobalVariable property bind_GlobalTimesPunished auto
GlobalVariable property bind_GlobalPoints auto
GlobalVariable property bind_GlobalTimeEnteredLocation auto
GlobalVariable property bind_GlobalTimeEnteredOutdoorLocation auto

GlobalVariable property bind_GlobalLocationEnteredCheck auto
GlobalVariable property bind_GlobalLocationHasFurniture auto
GlobalVariable property bind_GlobalSafeZone auto

GlobalVariable property bind_GlobalSuspendHeavyBondage auto
GlobalVariable property bind_GlobalSuspendNudity auto

GlobalVariable property bind_GlobalPunishmentMinGold auto
GlobalVariable property bind_GlobalPunishmentMaxGold auto
GlobalVariable property bind_GlobalPunishmentGoldPercentage auto

GlobalVariable property bind_GlobalRulesInEffect auto

GlobalVariable property bind_GlobalKneelingOK auto

Quest property bind_GoAdventuringQuest auto
Quest property bind_DefeatedQuest auto
Quest property bind_DairyQuest auto
Quest property bind_KneelingQuest auto
Quest property bind_EventBoundSleepQuest auto
Quest property bind_BoundSexQuest auto
Quest property bind_BoundMasturbationQuest auto
Quest property bind_WhippingQuest auto


Spell property ActionButtonMagicEffect auto

FormList property bind_SafeLocationTypesList auto
FormList property bind_SafeOutdoorLocationsTypeList auto
FormList property bind_ZapFurnitureList auto
FormList property bind_DDCFurnitureList auto
FormList property bind_DSEFurnitureList auto ;NOTE - empty by default DM3 - helper will load