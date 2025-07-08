Scriptname bind_RemovedFollowerQuestScript extends Quest  

event OnInit()

    ;debug.MessageBox("started removed follower quest script")

	bind_Utility.WriteToConsole("RemovedFollowerQuestScript - OnInit - checking for removed followers")

	RegisterForSingleUpdate(1.0)

endevent

Event OnUpdate()			
	UnregisterForUpdate()
	; Do everything we need to here
	RunCheck()
	;GotoState("active") ; Switch to a state that doesn't use OnUpdate()
EndEvent

function RunCheck()

	if self.IsRunning()

		bind_Utility.WriteToConsole("dom is not a follower - clearing dom")

		fs.ClearDom()

		self.Stop()

	endif

endfunction

bind_Functions property fs auto