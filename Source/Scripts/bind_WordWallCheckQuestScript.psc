Scriptname bind_WordWallCheckQuestScript extends Quest  

string wallLocation

event OnInit()

    if self.IsRunning()

        ;debug.MessageBox("word wall check started")

        wallLocation = fs.GetCurrentLocation().GetName()

        RegisterForSingleUpdate(30.0)

    endif

endEvent

event OnUpdate()

    Actor theSub = fs.GetSubRef()

    if TheWordWall.GetReference()

        bind_Utility.WriteToConsole("learned wall location: " + wallLocation)

        ;StorageUtil.StringListAdd(theSub, "bind_learned_walls", wallLocation, false) ;false will keep this from being double added - when added in wordwallquest also

        if main.DomUseWordWallEvent == 1

            int knownCount = StorageUtil.GetIntValue(theSub, "bind_known_words", 0)

            int currentCount = Game.queryStat("Words Of Power Learned")

            bind_Utility.WriteToConsole("stored wop count: " + knownCount + " current wop count: " + currentCount)

            if currentCount > knownCount
                ;learned without permission
                fs.CalculateDistanceAtAction()
                bool hasSyrimUnbound = Game.IsPluginInstalled("Skyrim Unbound.esp")
                if (currentCount > 1 && hasSyrimUnbound) || !hasSyrimUnbound 
                    ;NOTE - this is not a problem with vanilla skyrim, but skyrim unbound give you a wop after killing a dragon
                    ;which could be near a word wall
                    debug.MessageBox("I did not perform the ritual for the " + wallLocation + " word wall")
                    fs.MarkSubBrokeRule("I did not perform the ritual for the word wall", true)
                endif
            endif

        endif

    else

        bind_Utility.WriteToConsole("No word wall detected - wop from dragon")

    endif

    self.Stop()

endevent

ReferenceAlias property TheWordWall auto

bind_MainQuestScript property main auto
bind_Functions property fs auto