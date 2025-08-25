Scriptname bind_WordWallQuestScript extends Quest

Actor theDom
Actor theSub

bool pressedKey
bool learnedWord
string wallLocationName

ObjectReference wordWall

event OnInit()

	if self.IsRunning()

		theDom = fs.GetDomRef()
		theSub = fs.GetSubRef()
		learnedWord = false

		wordWall = TheWordWall.GetReference()
		
		wallLocationName = fs.GetCurrentLocation().GetName()

		;bind_Utility.WriteToConsole("location name: " + wallLocationName)
		;bind_Utility.WriteToConsole("known walls: " + StorageUtil.StringListToArray(theSub, "bind_learned_walls"))

		; int found = StorageUtil.StringListFind(theSub, "bind_learned_walls", wallLocationName)
		; if found > -1

		; 	bind_Utility.WriteInternalMonologue("I have studied this word wall before...")
			
		; 	self.Stop()

		; else

			GoToState("")

			bcs.DoStartEvent()
			bcs.SetEventName(self.GetName())

			RegisterForTrackedStatsEvent()

			RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
			RegisterForModEvent("AnimationEnd", "OnSexEndEvent")
			RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
			RegisterForModEvent("bind_EventCombatStartedInEvent", "CombatStartedInEvent")

			SetObjectiveDisplayed(10, true)

			if !theDom.IsInFaction(bind_ForceGreetFaction)
				theDom.AddToFaction(bind_ForceGreetFaction)
			endif

		;endif

	endif

	;main.LogOutput("WordWallQuestScript - OnInit - started the word wall quest")

	;RegisterForSingleUpdate(1.0)

	;TODO - rebuild this whole thing 3/26/25 - the part of the event in mainscript has been removed

endevent

event SafewordEvent()
    
    bind_Utility.WriteToConsole("word wall quest safeword ending")

    self.Stop()

endevent

event CombatStartedInEvent(Form akTarget)
    if bind_Utility.ConfirmBox("Your party has been attacked. End this?", "I must fight", fs.GetDomTitle() + " can handle this. Leave me.")
        fs.Safeword()
    endif
endevent

event PressedAction(bool longPress)
endevent

; State active
; 	Event OnUpdate()
; 		; Do nothing in here.
; 	EndEvent
; EndState

function Accepted()

	if theDom.IsInFaction(bind_ForceGreetFaction)
		theDom.RemoveFromFaction(bind_ForceGreetFaction)
	endif

	SetObjectiveCompleted(10)
	SetObjectiveDisplayed(10, false)
	SetObjectiveDisplayed(20, true)

	bind_PoseManager.StandFromKneeling(theSub)

    bind_Utility.DisablePlayer()

    bind_MovementQuestScript.FaceTarget(theDom, theSub)

    fs.EventGetSubReady(theSub, theDom, "event_word_wall") ;, playAnimations = true, stripClothing = true, addGag = false, freeWrists = true, removeAll = true)

	bind_Utility.DoSleep()

	if !theSub.IsInFaction(bms.WearingBlindfoldFaction()) || !theSub.IsInFaction(bms.WearingHoodFaction())
		if bms.AddItem(theSub, bms.BONDAGE_TYPE_BLINDFOLD())
			bind_Utility.DoSleep()
		endif
	endif

	;add soul plug to ass?

    bind_Utility.EnablePlayer()

    ;bind_SexLabHelper.StartTwoPersonSex(theDom, theSub)

	if !sms.StartSexScene(theSub, theDom)
        debug.MessageBox("Could not start sex scene")
		SetObjectiveCompleted(20)
		SetObjectiveDisplayed(20, false)
		SetObjectiveDisplayed(30, true)
    endif

endfunction

event OnSexEndEvent(string eventName, string argString, float argNum, form sender)

    ;StopEvent()

	SetObjectiveCompleted(20)
	SetObjectiveDisplayed(20, false)
	SetObjectiveDisplayed(30, true)
	GotoState("ReadingWallState")

endevent

Event OnTrackedStatsEvent(string asStatFilter, int aiStatValue)
    if (asStatFilter == "Words Of Power Learned")
		learnedWord = true
		StorageUtil.SetIntValue(theSub, "bind_known_words", aiStatValue) ;the check quest will compare this to the current stat for words - to check for infractions
		SetObjectiveCompleted(30)
		SetObjectiveDisplayed(30, false)
		SetObjectiveDisplayed(40, true)
		GoToState("KneelingToCompleteState")
    endif
endEvent

state ReadingWallState

	event PressedAction(bool longPress)

		if !pressedKey
			pressedKey = true

			UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu

			listMenu.AddEntryItem("I will keep trying to read the wall...")
			listMenu.AddEntryItem("This wall has been read.")

			listMenu.OpenMenu()
			int listReturn = listMenu.GetResultInt()
			if listReturn == 0
			elseif listReturn == 1
				GoToState("")
				EndTheQuest()
			else
			endif

			pressedKey = false
		endif

	endevent

endstate

state KneelingToCompleteState

	event PressedAction(bool longPress)

		if !pressedKey
			pressedKey = true
			if theSub.GetDistance(theDom) >= 200.0
				bind_Utility.WriteInternalMonologue("I need to get closer...")
			else
				GoToState("")
				EndTheQuest()
			endif
			pressedKey = false
		endif

	endevent

endstate

function EndTheQuest()

    bind_Utility.DisablePlayer()

    pms.DoHighKneel()

	bind_Utility.DoSleep(1.0)

	fs.EventCleanUpSub(theSub, theDom, true)

	pms.ResumeStanding()

    bind_Utility.EnablePlayer()

    bcs.DoEndEvent()

    SetObjectiveCompleted(40)
    SetObjectiveDisplayed(40, false)
    SetStage(20)

	StorageUtil.StringListAdd(theSub, "bind_learned_walls", wallLocationName, false)

	self.Stop()

endfunction

function EmergencyQuestEnd()
	;NOTE - need this if attacked by creature while learning word wall - bleak falls barrow

	StorageUtil.SetIntValue(theSub, "bind_known_words", Game.queryStat("Words Of Power Learned")) ;NOTE: not sure if this will be updated at this point

	fs.EventCleanUpSub(theSub, theDom, false)

    bcs.DoEndEvent()

    SetObjectiveCompleted(40)
    SetObjectiveDisplayed(40, false)
    SetStage(20)

	if learnedWord
		StorageUtil.StringListAdd(theSub, "bind_learned_walls", wallLocationName, false)
	endif

	self.Stop()

endfunction

; Event OnUpdate()			
; 	UnregisterForUpdate()
; 	; Do everything we need to here
; 	RunCheck()
; 	;GotoState("active") ; Switch to a state that doesn't use OnUpdate()
; EndEvent

; function RunCheck()

; 	if self.IsRunning()

; 		; Cell kCell = main.GetSubRef().GetParentCell()

; 		; ;check to see if this happened near a word wall
; 		; bool nearWordWall = false
; 		; int idx = kCell.GetNumRefs(24) ;24 is an activator
; 		; while idx
; 		; 	idx -= 1
; 		; 	ObjectReference ref = kCell.GetNthRef(idx, 24)
; 		; 	If ref as WordWallTriggerScript			
; 		; 		nearWordWall = true
; 		; 	EndIf
; 		; endwhile

; 		; bool hasPermission = main.WordWallEventHasPermission()

; 		; main.LogOutput("WordWallQuestScript - RunCheck - has permission: " + hasPermission + " nearwordwall: " + nearWordWall)

; 		; if !hasPermission && nearwordwall
; 		; 	main.MarkSubBrokeRule("I was not prepared to learn the shout", true)
; 		; endif

; 		; main.WordWallEventResetPermission()

; 		self.Stop()

; 	endif

; endfunction

ReferenceAlias property TheWordWall auto

bind_MainQuestScript property main auto
bind_BondageManager property bms auto
bind_PoseManager property pms auto
bind_Controller property bcs auto
bind_SexManager property sms auto
bind_Functions property fs auto

Faction property bind_ForceGreetFaction auto