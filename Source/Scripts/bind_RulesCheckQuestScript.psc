Scriptname bind_RulesCheckQuestScript extends Quest  

Actor theSub
Actor theDom

float sleepTime = 0.1

event OnInit()

    if self.IsRunning()
        
        GoToState("")

        RegisterForModEvent("bind_EventPressedActionEvent", "PressedAction")
        RegisterForModEvent("bind_SafewordEvent", "SafewordEvent")

        theSub = fs.GetSubRef()
        theDom = fs.GetDomRef()

        EventStart()

    endif

endevent

event SafewordEvent()
    bind_Utility.WriteToConsole("rules check quest safeword ending")
    self.Stop()
endevent

event PressedAction(bool longPress)
    bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is busy looking me over...")
endevent

function EventStart()

    int safeZone = bind_GlobalSafeZone.GetValue() as int
    bool safeArea

    if safeZone >= 2
        safeArea = true
        ;in a safe area
    else
        safeArea = false
        ;in an unsafe area
    endif


    bind_GlobalRulesUpdatedFlag.SetValue(0)

    bcs.DoStartEvent()
    bcs.SetEventName(self.GetName())

    if rms.UseFastRuleCheck == 0

        bind_Utility.DisablePlayer()

        bind_MovementQuestScript.WalkTo(theDom, theSub)

        bind_MovementQuestScript.MakeComment(theDom, theSub, bind_MovementQuestScript.GetCommentRulesCheck())

        bind_MovementQuestScript.FaceTarget(theDom, theSub)

        bind_MovementQuestScript.StartWorking(theDom)

    endif

    ;bms.RemoveAllBondageItems(theSub)

    CheckBehaviorRules(safeArea)

    ;debug.MessageBox("in here??")

    bms.UpdateBondage(theSub, true)

    bms.SnapshotCurrentBondage(theSub)

    ; if (safeZone >= 2 && mqs.AdventuringSuspendRules == 1) || mqs.AdventuringSuspendRules == 0

    ;     CheckBondageRules()

    ; endif

    if rms.UseFastRuleCheck == 0

        bind_MovementQuestScript.StopWorking(theDom)

        bind_Utility.EnablePlayer()

    endif

    bcs.DoEndEvent()

    self.Stop()

endfunction

function CheckBehaviorRules(bool safeArea)

    ; behaviorRulesKeys = "Body Rule:Nudity,Indoors Rule:No Beds,Indoors Rule:Dismissed,"
    ; behaviorRulesKeys += "Prayer Rule:No Shoes,Prayer Rule:Nudity,Prayer Rule:Must Pose,Prayer Rule:Must Ask,Prayer Rule:Perfectly Clean,Prayer Rule:Whipped,"
    ; behaviorRulesKeys += "Speech Rule:Dom Speaks,Speech Rule:Must Ask,Speech Rule:Must Pose,Entry/Exit Rule:Castle,Entry/Exit Rule:Inn,Entry/Exit Rule:Player Home,"
    ; behaviorRulesKeys += "Food Rule:Must Ask,Food Rule:Sit On Floor,Sex Rule:Give Thanks,Studies:Ask To Read Scroll,Studies:Ask To Train"

    ;int nudityRule = rms.GetBehaviorRuleByName("Body Rule:Nudity")

    if rms.IsNudityRequired(theSub, safeArea)
        gms.RemoveWornGear(theSub)
    else

    endif

    ;TODO - need a location to make this work right
    ;story manager will probably be OK to keep to towns and cities but dialogue should probably be location aware also
    ;want to do a snapshot when leaving and returning to safe areas to quickly reapply devices

endfunction

; function CheckBondageRules()

;     ;bondageRulesKeys = "Bound Rule,Collared Rule,Chastity Rule,Boots Rule,Corset Rule,Gagged Rule,Shackles Rule,Piercing Rule,Blindfold Rule,Hood Rule"

;     string[] bondageRules = rms.GetBondageRulesList()
;     int[] bondageSettings = rms.GetBondageRulesSettingsList()
;     int[] bondageHard = rms.GetBondageHardLimitsList()
;     int[] bondageTrans = rms.GetBondageRuleToBondageTypeList()

;     int i = 0
;     while i < bondageRules.Length

;         if bondageHard[i] == 1
;             ;TODO - disable rule if hard limit has been set
;             ;this is needed for dom & hybrid controlled to turn off rules

;         endif

;         bind_Utility.WriteToConsole("check bondage rule: " + i)

;         if bondageSettings[i] == 1 && bondageHard[i] == 0

;             int typeNumber = i ;bondageTrans[i]

;             bool addItem = true

;             ;check for suspended flags
;             if typeNumber == bms.BONDAGE_TYPE_HEAVYBONDAGE()
;                 if bind_GlobalSuspendHeavyBondage.GetValue() == 1.0
;                     bind_Utility.WriteToConsole("heavy bondage suspended flag found")
;                     addItem = false
;                 endif
;             elseif typeNumber == bms.BONDAGE_TYPE_GAG()
;                 if bind_GlobalSuspendGag.GetValue() == 1.0
;                     bind_Utility.WriteToConsole("gag suspended flag found")
;                     addItem = false
;                 endif
;             endif

;             if addItem
;                 if bms.AddItem(theSub, typeNumber)
;                     bind_Utility.DoSleep(sleepTime)
;                     bind_Utility.WriteToConsole("adding item: " + typeNumber)
;                 else
;                     bind_Utility.WriteToConsole("add failed: " + typeNumber)
;                 endif
;             endif

;             bind_Utility.WriteToConsole("check bondage rule: " + typeNumber + " add: " + additem)

;         endif

;         i += 1
;     endwhile

;     bms.SnapshotCurrentBondage(theSub)

; endfunction

bind_MainQuestScript property mqs auto
bind_BondageManager property bms auto
bind_RulesManager property rms auto
bind_Controller property bcs auto
bind_GearManager property gms auto
bind_Functions property fs auto

GlobalVariable property bind_GlobalRulesUpdatedFlag auto

GlobalVariable property bind_GlobalSuspendGag auto
GlobalVariable property bind_GlobalSuspendHeavyBondage auto
GlobalVariable property bind_GlobalSuspendNudity auto

GlobalVariable property bind_GlobalSafeZone auto