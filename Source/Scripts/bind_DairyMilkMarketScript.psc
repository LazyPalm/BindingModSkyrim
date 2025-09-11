Scriptname bind_DairyMilkMarketScript extends Quest  

Actor theDom
Actor theSub
ObjectReference furn

bool inspected = false

event OnInit()

	if self.IsRunning()

		if bind_Utility.ConfirmBox(fs.GetDomTitle() + " wants to sell your milk")

			bind_Utility.WriteToConsole("dairy milk market started")

			theDom = fs.GetDomRef()
			theSub = fs.GetSubRef()

			furn = TheFurniture.GetReference()
			;(furn as zadcFurnitureScript).ScriptedDevice = true

			bool hasMilk = false

			Form[] inventory = theDom.GetContainerForms()
			int i = 0
			while i < inventory.Length
				Form f = inventory[i]
				if f.HasKeywordString("MME_Milk")
					hasMilk = true
					i = 500
				endif
				i += 1
			endwhile

			if hasMilk

				;debug.MessageBox("milk found")
				bcs.DoStartEvent(true)
				bcs.SetEventName(self.GetName())
				SetStage(10)
				SetObjectiveDisplayed(10)

				float lastTime = StorageUtil.GetFloatValue(TheShopKeep.GetReference(), "bind_last_milk_market", 0.0)
				
				if bind_Utility.GetTime() - lastTime >= 1.0
					inspected = true
					bind_Utility.DisablePlayer()
					fs.EventGetSubReady(theSub, theDom, "event_milkmarket")
					bind_MilkMarketScene.Start()
				else
					inspected = false
					bind_DairyMilkMarketShortScene.Start()
				endif

			else
				debug.MessageBox("no milk")
				self.Stop()
			endif

		else

			self.Stop()

		endif
		
	endif

endevent

function LockSubInFurniture()

	;debug.MessageBox("LockSubInFurniture...")

	GoToState("LockInState")
	RegisterForSingleUpdate(5.0)

endfunction

event OnUpdate()
endevent

state LockInState

	event OnUpdate()

		;debug.MessageBox("in the update...")

		GotoState("")

		if fman.LockInFurniture(theSub, furn, true)
			
			;debug.MessageBox("worked??")

			SetObjectiveCompleted(10)
			SetObjectiveDisplayed(20)

			bind_MilkMarketScene2.Start()

		endif
		
	endevent

endstate

function StartTrade()

	GoToState("TradeState")
	RegisterForSingleUpdate(3.0)

endfunction

state TradeState 

	event OnUpdate()

		;debug.MessageBox("in the update...")

		GotoState("")

		SetObjectiveCompleted(20)
		SetObjectiveDisplayed(30)

		; debug.MessageBox("Open trade??")

		; MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
		; MilkQ.MilkE.InitiateDialogueTrade(theDom, 2)

		string saleSummary = ""
		int totalGold = 0

		Form[] inventory = theDom.GetContainerForms()
		int i = 0
		while i < inventory.Length
			Form f = inventory[i]
			if f.HasKeywordString("MME_Milk")
				int cost = f.GetGoldValue()
				int qty = theDom.GetItemCount(f)
				if saleSummary != ""
					saleSummary += ", "
				endif
				saleSummary += f.GetName() + " qty: " + qty + " cost: " + cost + " total: " + (cost * qty)
				totalGold += (cost * qty)
				theDom.RemoveItem(f, qty, true, none)
			endif
			i += 1
		endwhile

		debug.MessageBox("Transaction Summary: " + saleSummary + " - total gold: " + totalGold)

		theSub.AddItem(Gold, totalGold, false)

		SetObjectiveCompleted(30)

		EndTheQuest()

		; MilkECON econ = Quest.GetQuest("MME_MilkQUEST") as MilkECON
		; econ.InitiateDialogueTrade(theDom, 2)
		
	endevent

endstate

function EndTheQuest()
	
	if inspected

		StorageUtil.SetFloatValue(TheShopKeep.GetReference(), "bind_last_milk_market", bind_Utility.GetTime())

		bind_MovementQuestScript.WalkTo(TheDom, theSub)     
		bind_MovementQuestScript.PlayDoWork(theDom)
		bind_Utility.DoSleep()

		if fman.UnlockFromFurniture(theSub, furn, true)
		endif
		bind_Utility.DoSleep(3.0)

		bind_Utility.DisablePlayer()
	
		bind_MovementQuestScript.PlayDoWork(theDom)
		bind_Utility.DoSleep()
		
		fs.EventCleanUpSub(theSub, theDom, true)

		bind_Utility.EnablePlayer()

	else


	endif

	SetStage(20)

	bcs.DoEndEvent(true)

	self.Stop()

endfunction

bind_Functions property fs auto
bind_Controller property bcs auto
bind_FurnitureManager property fman auto

Scene property bind_MilkMarketScene auto
Scene property bind_MilkMarketScene2 auto
Scene property bind_DairyMilkMarketShortScene auto

ReferenceAlias property TheFurniture auto
ReferenceAlias property TheShopKeep auto

MiscObject property Gold auto