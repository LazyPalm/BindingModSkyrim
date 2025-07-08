Scriptname bind_DairyMilkMarketScript extends Quest  

event OnInit()

	if self.IsRunning()

		bind_Utility.WriteToConsole("dairy milk market started - quest not working yet")

		;debug.MessageBox("sell the milk?")

		self.Stop()
		
	endif

endevent