Scriptname bind_ArrivalCheck extends Quest  

event OnInit()

    if self.IsRunning()

        if TheWordWallRef.GetReference() != none
            bind_Utility.WriteInternalMonologue("I can sense a spoken power to be learned here...")
            fs.EventSetWordWall(TheWordWallRef.GetReference())
        else
            fs.EventClearWordWall()
        endif

        self.Stop()

    endif

endevent

bind_MainQuestScript property mqs auto
bind_BondageManager property bms auto
bind_Controller property bcs auto
bind_Functions property fs auto

ReferenceAlias property TheWordWallRef auto