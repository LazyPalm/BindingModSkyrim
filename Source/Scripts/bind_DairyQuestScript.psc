
Scriptname bind_DairyQuestScript extends Quest  

Actor theSub
Actor theDom

bool gettingMilked
bool questEnding
bool inMilkFurniture
bool pressedButton

float startingLactacid

event OnInit()

    if self.IsRunning()

        if bind_MMEHelper.CheckValid() && mqs.EnableModMME == 1

            bind_GlobalMilkTriggerRun.SetValue(0.0)

            bcs.DoStartEvent(false)
            bcs.SetEventName(self.GetName())

            RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
            RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")
            RegisterForModEvent("bind_EventFurnitureSit", "EventFurnitureSit")
            RegisterForModEvent("bind_EventFurnitureGetUp", "EventFurnitureGetUp")
            RegisterForModEvent("bind_EventCombatStartedInEvent", "CombatStartedInEvent")

            theSub = fs.GetSubRef()
            theDom = fs.GetDomRef()

            gettingMilked = false
            questEnding = false

            SetObjectiveDisplayed(5)
            SetStage(10)
            GotoState("GetAttentionState")
            RegisterForSingleUpdate(1.0)
    
        else

            bind_Utility.WriteToConsole("Dairy quest cannot be started - MME is not valid or not enabled")
            self.Stop()

        endif
        
    endif

endEvent

event SafewordEvent()

    UnregisterForUpdate()
    
    bind_Utility.WriteToConsole("dairy quest safeword ending")

    self.Stop()

endevent

event CombatStartedInEvent(Form akTarget)
    if bind_Utility.ConfirmBox("Your party has been attacked. End this?", "I must fight", fs.GetDomTitle() + " can handle this. Leave me.")
        fs.Safeword()
    endif
endevent

event PressedAction(bool longPress)
    bind_Utility.WriteToConsole("pressed action in dairy quest - no state")
endevent

event EventFurnitureSit()

    inMilkFurniture = false

    ObjectReference furn = fs.GetSubInFurnitureItem()

    ;debug.MessageBox(furn)

    if furn.HasKeyWord(Keyword.GetKeyword("MME_zbfFurniture"))
        inMilkFurniture = true
        ;debug.MessageBox("This is a milking machine...")
        bind_Utility.WriteToConsole("Dairy quest - sub entered milking machine")
        GoToState("InMilkingMachineState")
        UnregisterForUpdate()
    endif

endevent

event EventFurnitureGetUp()
    bind_Utility.WriteToConsole("dariy quest - leaving furniture")
    if gettingMilked && inMilkFurniture
        if bind_MMEHelper.CheckValid()
            float milkLevel = bind_MMEHelper.GetMilkLevel(theSub)
            if milkLevel >= 1.0
                ;sub left furniture early, shift this back to the waiting state - in case other milking is used
                GoToState("WaitForMilkingUpdate")
                RegisterForSingleUpdate(15.0)
                bind_Utility.WriteNotification("You have not drained enough milk...", bind_Utility.TextColorRed())   
            else
                ;sub is milked
                ;UnregisterForUpdate()
                SetObjectiveCompleted(30)
                SetStage(40)
                GoToState("WaitForMilkInInventory")
                RegisterForSingleUpdate(5.0)        
            endif
            bind_GlobalMilkCurrentLevel.SetValue(milkLevel)
        else
            EndTheQuest() ;this should not happen
        endif
        inMilkFurniture = false
    endif
endevent

auto state GetAttentionState

    event OnUpdate()

        bind_Utility.WriteToConsole("pressed action in dairy quest - GetAttentionState")

        if !UI.IsMenuOpen("Dialogue Menu")
            bind_Utility.WriteNotification(fs.GetDomTitle() + " wants to speak with you...", bind_Utility.TextColorRed())
        endif

        RegisterForSingleUpdate(15.0)

    endevent

    event PressedAction(bool longPress)
        if !pressedButton 
            pressedButton = true
            bind_Controller.SendActionKneelTriggerEvent()
            bind_Utility.DoSleep(2.0)
            pressedButton = false
        endif
    endevent

endstate

function GiveLactacidBottle(int qty = 1)

    UnregisterForUpdate()
    SetStage(20)
    SetObjectiveCompleted(5, true)
    SetObjectiveDisplayed(5, false)
    SetObjectiveDisplayed(10, true)
    GoToState("")

    if theDom.IsInFaction(bind_ForceGreetFaction)
        theDom.RemoveFromFaction(bind_ForceGreetFaction)
    endif

    if bind_MMEHelper.CheckValid()
        bind_MovementQuestScript.FaceTarget(theDom, theSub)
        bind_MovementQuestScript.PlayDoWork(theDom)
        bind_MMEHelper.GiveLactacid(theSub, qty)
        if qty == 1
            bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " provided me a bottle of Lactacid to drink...")
        else
            bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " provided me " + qty + " bottles of Lactacid to drink...")
        endif
        SetObjectiveCompleted(10)
        SetObjectiveDisplayed(20, true)
        startingLactacid = bind_MMEHelper.GetLactacidLevel(theSub)
        GoToState("WaitForLactacidUpdate")
        RegisterForSingleUpdate(15.0)
    else
        EndTheQuest()
    endif

endfunction

state WaitForLactacidUpdate

    event PressedAction(bool longPress)
        bind_Utility.WriteToConsole("pressed action in dairy quest - WaitForLactacidUpdate")
        bind_Utility.WriteInternalMonologue("I need to drink this Lactacid...")
    endevent

    event OnUpdate()
        if bind_MMEHelper.CheckValid()
            float lactacidLevel = bind_MMEHelper.GetLactacidLevel(theSub)
            ;debug.MessageBox(lactacidLevel)
            if lactacidLevel == startingLactacid
                RegisterForSingleUpdate(15.0)
            else
                ;sub drank potion
                GoToState("")
                if !theSub.GetFactionRank(bind_MilkSlaveFaction) != 2
                    theSub.SetFactionRank(bind_MilkSlaveFaction, 2)
                    bind_MMEHelper.MakeMilkSlave(theSub)
                endif
                SetObjectiveCompleted(20)
                EndTheQuest()                
            endif
        endif
    endevent
endstate

function FeedLactacidBottle(int qty = 1)

    UnregisterForUpdate()
    GoToState("")
    SetStage(20)
    SetObjectiveCompleted(5, true)
    SetObjectiveDisplayed(5, false)
    SetObjectiveDisplayed(10, true)

    if theDom.IsInFaction(bind_ForceGreetFaction)
        theDom.RemoveFromFaction(bind_ForceGreetFaction)
    endif

    if bind_MMEHelper.CheckValid()
        bind_Utility.DisablePlayer()
        bind_MovementQuestScript.FaceTarget(theDom, theSub)
        bind_MovementQuestScript.PlayDoWork(theDom)
        bind_Utility.DoSleep()
        bind_MMEHelper.FeedLactacid(theSub, qty)
        bind_Utility.DoSleep(2.0)
        string bottle = "me a bottle"
        if qty > 1
            bottle = "me " + qty + " bottles"
        endif
        bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is feeding " + bottle + " of Lactacid...")
        bind_Utility.EnablePlayer()
        ;debug.MessageBox("faction: " + theSub.GetFactionRank(bind_MilkSlaveFaction))
        if theSub.GetFactionRank(bind_MilkSlaveFaction) != 2
            theSub.SetFactionRank(bind_MilkSlaveFaction, 2)
            bind_MMEHelper.MakeMilkSlave(theSub)
        endif
        SetObjectiveCompleted(10)
    endif

    EndTheQuest()

endfunction

bool replacePiercings
function FindStall()

    UnregisterForUpdate()
    GoToState("")

    bind_PoseManager.StandFromKneeling(theSub)

    ;StorageUtil.SetIntValue(theSub, "bind_milking_permission", 1)

    if theDom.IsInFaction(bind_ForceGreetFaction)
        theDom.RemoveFromFaction(bind_ForceGreetFaction)
    endif

    SetStage(30)
    SetObjectiveCompleted(5, true)
    SetObjectiveDisplayed(5, false)
    SetObjectiveDisplayed(30, true)

    bind_GlobalMilkCurrentLevel.SetValue(0.0) ;clear this out to end dialogue

    replacePiercings = true
    ;if theSub.IsInFaction(bms.WearingNPiercingFaction())
        bind_Utility.DisablePlayer()

        ;bind_Utility.WriteInternalMonologue(mqs.GetDomTitle() + " is removing my piercings...")

        bind_MovementQuestScript.WalkTo(theDom, theSub)
        bind_MovementQuestScript.FaceTwoActors(theSub, theDom)
        bind_MovementQuestScript.PlayDoWork(theDom)

        fs.EventGetSubReady(theSub, theDom, "event_dairy") ;, playAnimations = true, stripClothing = true, addGag = false, freeWrists = false, removeAll = true)

        ; bind_Utility.DoSleep()
        ; if bms.RemoveItem(theSub, bms.BONDAGE_TYPE_N_PIERCING())
        ;     bind_Utility.DoSleep()
        ;     replacePiercings = true
        ; endif
        bind_Utility.EnablePlayer()
    ;endif
   
    if bind_MMEHelper.CheckValid()
        ;bind_Utility.WriteInternalMonologue("I need to go find a milking stall...")
        gettingMilked = true
        GoToState("WaitForMilkingUpdate")
        RegisterForSingleUpdate(15.0)
    else
        EndTheQuest() ;this should not happen
    endif

endfunction

state WaitForMilkingUpdate
    event OnUpdate()
        if bind_MMEHelper.CheckValid()
            float milkLevel = bind_MMEHelper.GetMilkLevel(theSub)
            if milkLevel >= 1.0
                bind_GlobalMilkCurrentLevel.SetValue(milkLevel)
                ;bind_Utility.WriteInternalMonologue("I still have milk to drain...")
                RegisterForSingleUpdate(15.0)
            else
                ;sub is milked
                gettingMilked = false
                SetObjectiveCompleted(30)
                SetStage(40)
                UnregisterForUpdate()
                GoToState("WaitForMilkInInventory")
                RegisterForSingleUpdate(5.0)        
            endif
        else
            EndTheQuest() ;this should not happen
        endif
    endevent
endstate

bool removedMilk = false
state WaitForMilkInInventory
    event OnUpdate()

        Form[] inventory = theSub.GetContainerForms()
        int i = 0
        while i < inventory.Length    
            Form item = inventory[i]
            if item.HasKeywordString("MME_Milk")
                theSub.RemoveItem(item, 1000, true, theDom)
                ;debug.MessageBox("removing milk")
                removedMilk = true
            endif
            i += 1
        endwhile

        bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " collected my milk bottles...")
        bind_Utility.DoSleep()
        fs.AddPoint()
        bind_Utility.DoSleep()

        ; if !removedMilk
        ;     RegisterForSingleUpdate(15.0)
        ; else

        UnregisterForUpdate()
        GoToState("")
        EndTheQuest()            

            ;bind_Utility.WriteInternalMonologue("I am getting rewarded for being a good cow...")            
            

        ;endif

    endevent
endstate

function EndMilkSlavery()

    if bind_MMEHelper.CheckValid()

        bind_MMEHelper.FreeFromMilkSlavery(theSub)

        if theSub.IsInFaction(bind_MilkSlaveFaction)
            theSub.SetFactionRank(bind_MilkSlaveFaction, 0)
            bind_Utility.DoSleep()
            theSub.RemoveFromFaction(bind_MilkSlaveFaction)
        endif

    endif

    EndTheQuest()

endfunction

function EndTheQuest()

    if !questEnding

        questEnding = true

        bind_PoseManager.StandFromKneeling(theSub)

        if replacePiercings
                        
            bind_Utility.DisablePlayer()

            ;bind_Utility.WriteInternalMonologue(mqs.GetDomTitle() + " putting back in my piercings...")
            
            bind_MovementQuestScript.WalkTo(TheDom, theSub)
            bind_MovementQuestScript.FaceTwoActors(theSub, theDom)        
            bind_MovementQuestScript.PlayDoWork(theDom)
            bind_Utility.DoSleep()
            
            fs.EventCleanUpSub(theSub, theDom, true)

            ; if bms.AddItem(theSub, bms.BONDAGE_TYPE_N_PIERCING())
            ;     bind_Utility.DoSleep()
            ; endif
            
            bind_Utility.EnablePlayer()

        endif

        if bind_MMEHelper.CheckValid()
            bind_GlobalMilkCurrentLevel.SetValue(bind_MMEHelper.GetMilkLevel(theSub))
            bind_GlobalMilkMaxLevel.SetValue(bind_MMEHelper.GetMilkMax(theSub))
            bind_GlobalMilkLactacidLevel.SetValue(bind_MMEHelper.GetLactacidLevel(theSub))
            bind_GlobalMilkedTimesMilked.SetValue(bind_MMEHelper.GetTimesMilked(theSub))
            bind_Utility.DoSleep() ;stats quest was hitting a bit fast behind this
            bind_Utility.WriteToConsole("dairy - times milked: " + bind_GlobalMilkedTimesMilked.GetValue())
        endif

        bcs.DoEndEvent(false)

        SetStage(100)

        self.Stop()

    endif

endfunction

bind_MainQuestScript property mqs auto
bind_BondageManager property bms auto
bind_Controller property bcs auto
bind_GearManager property gms auto
bind_Functions property fs auto

Faction property bind_MilkSlaveFaction auto
Faction property bind_ForceGreetFaction auto

GlobalVariable property bind_GlobalMilkCurrentLevel auto
GlobalVariable property bind_GlobalMilkMaxLevel auto
GlobalVariable property bind_GlobalMilkLactacidLevel auto
GlobalVariable property bind_GlobalMilkedTimesMilked auto
GlobalVariable property bind_GlobalMilkTriggerRun auto