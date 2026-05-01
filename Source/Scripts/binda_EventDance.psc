Scriptname binda_EventDance extends Quest  

bool gotTip = false
bool npcPleased = false
bool danceReady = false

Actor theSub
Actor theDom

event OnInit()

    if IsRunning()

        if bind_Utility.PriApiEventStart("Commanded To Dance", true)

            theSub = Game.GetPlayer()
            theDom = TheDomAlias.GetActorReference()

            RegisterForModEvent("bind_DancingNpcPleasedModEvent", "NpcPleased")
            RegisterForModEvent("bind_DancingGotTippedModEvent", "GotTipped")
            RegisterForModEvent("binda_LocationChangeModEvent", "ChangedLocation")
            RegisterForModEvent("bind_StoppedDancingModEvent", "StoppedDancing")

            RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
            RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

            SetStage(10)
            SetObjectiveDisplayed(10, true)

            binda_EventDanceQuestStartScene.Start()

        else

            Stop()

        endif

    endif

endevent

event OnUpdateGameTime()

    danceReady = false
    if bind_PoseManager.PriApiIsInPose(theSub)
        bind_PoseManager.PriApiPlayerStand()
    endif

    SetObjectiveFailed(20, true)
    binda_EventDanceQuestFailedScene.Start()

endevent

event OnUpdate()

endevent

event SafewordEvent()

    bind_Utility.WriteToConsole("dancing event safeword ending")

    if bind_PoseManager.PriApiIsInPose(theSub)
        bind_PoseManager.PriApiPlayerStand()
    endif

    self.Stop()

endevent

event PressedAction(bool longPress)

    if danceReady

        UIListMenu listMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
        
        string fileName = "binding/dance.json"

        string[] shortList = JsonUtil.StringListToArray(fileName, "short_names")
        string[] pluginList = JsonUtil.StringListToArray(fileName, "plugin")
        string[] animationList = JsonUtil.StringListToArray(fileName, "animation_name")
        string[] descList = JsonUtil.StringListToArray(fileName, "short_description")

        listMenu.AddEntryItem("Stop Dancing")
        int i = 0
        while i < shortList.Length
            listMenu.AddEntryItem(shortList[i])
            i += 1
        endwhile

        listMenu.OpenMenu()
        int listReturn = listMenu.GetResultInt()
        string listSelect = listMenu.GetResultString()

        string danceType = ""

        if listReturn == 0
            if bind_PoseManager.PriApiIsInPose(theSub)
                bind_PoseManager.PriApiPlayerStand()
            endif
        elseif listReturn > 0
            int idx = listReturn - 1
            if idx > 0
                bind_PoseManager.PriApiDance(theSub, pluginList[idx], animationList[idx], descList[idx])
            endif
        endif

    endif

endevent

event NpcPleased(Form npc)
    npcPleased = true
endevent

event GotTipped(Form npc, int gold)
    gotTip = true
endevent

event ChangedLocation(Form oldLoc, Form newLoc)

endevent

event StoppedDancing()

    if gotTip
        danceReady = false
        SetObjectiveCompleted(20, true)
        binda_EventDanceQuestSuccessScene.Start()
    endif

endevent

function StartPlayed()

    int outfitId = bind_Utility.PriApiGetBondageOutfitId("event_dancing")
    ;debug.MessageBox(outfitId)
    if outfitId > 0
        bind_utility.PriApiEquipBondageOutfit(theSub, outfitId)
    endif

    SetObjectiveCompleted(10, true)
    SetObjectiveDisplayed(20, true)
    
    bind_Utility.WriteInternalMonologue("I have two hours to complete this task...")

    danceReady = true

    RegisterForUpdateGameTime(2.0)

endfunction

function SuccessPlayed()

    bind_MovementQuestScript.FaceTarget(theDom, theSub)
    bind_MovementQuestScript.PlayDoWork(theDom)

    bind_Utility.PriApiUpdatePlayerBondage(theDom)

    bind_Utility.PriApiEventEnd(false, true)

    binda_EventDanceLastGlobal.SetValue(bind_Utility.GetTime())
    binda_EventDanceNextGlobal.SetValue(bind_Utility.GetTime() + (binda_EventDanceCooldownHoursGlobal.GetValue() / 24.0))

    SetStage(20)
    Stop()

endfunction

function FailedPlayed()

    bind_Utility.PriApiUpdatePlayerBondage(theDom)

    bind_Utility.PriApiEventEnd(true, true)

    binda_EventDanceLastGlobal.SetValue(bind_Utility.GetTime())
    binda_EventDanceNextGlobal.SetValue(bind_Utility.GetTime() + (binda_EventDanceCooldownHoursGlobal.GetValue() / 24.0))

    SetStage(30)
    Stop()

endfunction

GlobalVariable property binda_EventDanceLastGlobal auto
GlobalVariable property binda_EventDanceNextGlobal auto
GlobalVariable property binda_EventDanceCooldownHoursGlobal auto 

Scene property binda_EventDanceQuestStartScene auto
Scene property binda_EventDanceQuestSuccessScene auto
Scene property binda_EventDanceQuestFailedScene auto

ReferenceAlias property TheDomAlias auto