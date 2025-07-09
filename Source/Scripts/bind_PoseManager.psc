Scriptname bind_PoseManager extends Quest conditional

int property PoseIdleState auto conditional

int IDLE_STATE_NONE = 0
int IDLE_STATE_ATTENTION = 1
int IDLE_STATE_KNEELING = 2
int IDLE_STATE_HOGTIED = 3
int IDLE_STATE_BOUND_SLEEPING = 4
int IDLE_STATE_DEEP_KNEELING = 5
int IDLE_STATE_SPREAD_KNEELING = 6
int IDLE_STATE_SHOW_ASS = 7
int IDLE_STATE_PRESENT_WRISTS = 8
int IDLE_STATE_PRAYER = 9
int IDLE_STATE_SIT_GROUND = 10
int IDLE_STATE_BEING_WHIPPED = 11
int IDLE_STATE_BOUND_ON_KNEES = 12
int IDLE_STATE_CONVERSATION_POSE = 13
int IDLE_STATE_INSPECTION = 14

string idleHighKneel
string idleHighKneelSystemName
string idleHighKneelBound
string idleHighKneelBoundSystemName

string idleDeepKneel 
string idleDeepKneelSystemName
string idleDeepKneelBound 
string idleDeepKneelBoundSystemName

string idleSpreadKneel
string idleSpreadKneelSystemName
string idleSpreadKneelBound
string idleSpreadKneelBoundSystemName

string idleAttention
string idleAttentionSystemName
string idleAttentionBound
string idleAttentionBoundSystemName

string idlePresentHands
string idlePresentHandsSystemName
string idlePresentHandsBound
string idlePresentHandsBoundSystemName

string idleShowAss
string idleShowAssSystemName
string idleShowAssBound
string idleShowAssBoundSystemName

string idleGetWhipped
string idleGetWhippedSystemName
string idleGetWhippedBound
string idleGetWhippedBoundSystemName

string idlePrayer 
string idlePrayerSystemName
string idlePrayerBound
string idlePrayerBoundSystemName

string idleSitGround
string idleSitGroundSystemName
string idleSitGroundBound
string idleSitGroundBoundSystemName

string idleConversationPose
string idleConversationPoseSystemName
string idleConversationPoseBound
string idleConversationPoseBoundSystemName

bool setupCompleted

bool replaceGag

Actor theSubRef

Function LoadGame(Actor a)

    theSubRef = a

EndFunction

Function ClearFavorites()
    idleHighKneel = ""
    idleHighKneelSystemName = ""
    idleHighKneelBound = ""
    idleHighKneelBoundSystemName = ""
    
    idleDeepKneel = ""
    idleDeepKneelSystemName = ""
    idleDeepKneelBound = ""
    idleDeepKneelBoundSystemName = ""
    
    idleSpreadKneel = ""
    idleSpreadKneelSystemName = ""
    idleSpreadKneelBound = ""
    idleSpreadKneelBoundSystemName = ""
    
    idleAttention = ""
    idleAttentionSystemName = ""
    idleAttentionBound = ""
    idleAttentionBoundSystemName = ""
    
    idlePresentHands = ""
    idlePresentHandsSystemName = ""
    idlePresentHandsBound = ""
    idlePresentHandsBoundSystemName = ""
    
    idleShowAss = ""
    idleShowAssSystemName = ""
    idleShowAssBound = ""
    idleShowAssBoundSystemName = ""
    
    idleGetWhipped = ""
    idleGetWhippedSystemName = ""
    idleGetWhippedBound = ""
    idleGetWhippedBoundSystemName = ""
EndFunction

string Function _GetSystemName(string displayName)
    If displayName == "Stand At Attention"
        return "IdleHandsBehindBack"
    ElseIf displayName == "Pray"
        return "IdlePray"
    ElseIf displayName == "Bound On Knees"
        return "IdleBoundKneesStart"
    ElseIf displayName == "Greybeard Meditate"
        return "IdleGreybeardMeditateEnter"
    ElseIf displayName == "Kneeling"
        return "IdleKneeling"
    ElseIf displayName == "ZAP Kneel"
        return "ZapWriPose06"
    ElseIf displayName == "DD Kneel X Front"
        return "ft_bdsm_idle_egyptian"
    ElseIf displayName == "DD Kneel Hands Out"
        return "ft_surrender"
    ElseIf displayName == "ZAP Spread Kneel"
        return "ZapWriPose07"
    ElseIf displayName == "ZAP Show Ass"
        return "ZapWriPose03"
    ElseIf displayName == "ZAP Attention"
        return "ZazAPC051"
    ElseIf displayName == "ZAP Deep Kneel"
        return "ZapWriPose08"
    ElseIf displayName == "DD Inspection"
        return "ft_bdsm_idle_inspection"
    ElseIf displayName == "DD Collar Me"
        return "ft_bdsm_idle_collarme"
    ElseIf displayName == "zazapc001 stand head bow"
        return "zazapc001"
    ElseIf displayName == "zazapc002 stand head bow spread"
        return "zazapc002"
    ElseIf displayName == "zazapc003 stand bow"
        return "zazapc003"
    ElseIf displayName == "zazapc006 stand deep bow"
        return "zazapc006"
    ElseIf displayName == "zazapc007 stand deep bow spread"
        return "zazapc007"
    ElseIf displayName == "zazapc016 knees bow sm spread"
        return "zazapc016"
    ElseIf displayName == "zazapc017 knees bow spread"
        return "zazapc017"
    ElseIf displayName == "zazapc018 kneel sm bow"
        return "zazapc018"
    ElseIf displayName == "zazapc019 kneel sm bow spread"
        return "zazapc019"
    ElseIf displayName == "zazapc020 kneel bow spread"
        return "zazapc020"
    ElseIf displayName == "zazapc052 stand spread"
        return "zazapc052"
    ElseIf displayName == "zazapc053 stand sm spread"
        return "zazapc053"
    ElseIf displayName == "zazapc058 knees"
        return "zazapc058"
    ElseIf displayName == "zazapoa010 stand x behind head"
        return "zazapoa010"
    ElseIf displayName == "zazapoa011 stand boxed"
        return "zazapoa011"
    ElseIf displayName == "zazapoa016 stand x"
        return "zazapoa016"
    ElseIf displayName == "zazapoa019 stand x front"
        return "zazapoa019"
    ElseIf displayName == "zapwripose04 stand bent 90"
        return "zapwripose04"
    ElseIf displayName == "zapwripose05 stand show p"
        return "zapwripose05"
    ElseIf displayName == "zapwripose06 knees"
        return "zapwripose06"
    ElseIf displayName == "zapwripose09 squat"
        return "zapwripose09"
    ElseIf displayName == "zapwripose10 squat spread"
        return "zapwripose10"
    ElseIf displayName == "zaparmbpose06 kneel"
        return "zaparmbpose06"
    Else
        return ""
    EndIf
EndFunction

string Function GetIdlesList()

    string list
    list = "Stand At Attention,Pray,Bound On Knees,Greybeard Meditate,Kneeling"

    If main.SoftCheckZAP == 1
        list = list + ",ZAP Kneel,ZAP Deep Kneel,ZAP Spread Kneel,ZAP Show Ass,ZAP Attention,zazapc001 stand head bow,"
        list = list + "zazapc002 stand head bow spread,zazapc003 stand bow,zazapc006 stand deep bow,"
        list = list + "zazapc007 stand deep bow spread,zazapc016 knees bow sm spread,zazapc017 knees bow spread,"
        list = list + "zazapc018 kneel sm bow,zazapc019 kneel sm bow spread,zazapc020 kneel bow spread,"
        list = list + "zazapc052 stand spread,zazapc053 stand sm spread,zazapc058 knees,zapwripose04 stand bent 90,"
        list = list + "zapwripose05 stand show p,zapwripose06 knees,zapwripose09 squat,zapwripose10 squat spread,"
        list = list + "zaparmbpose06 kneel"
    EndIf

    If main.SoftCheckDD == 1
        list = list + ",DD Kneel X Front,DD Kneel Hands Out,DD Inspection,DD Collar Me"
    EndIf

    ;Debug.MessageBox(list)

    return list

EndFunction

Function SetHighKneel(string idleName, bool bound = false)
    If bound
        idleHighKneelBound = idleName
        idleHighKneelBoundSystemName = _GetSystemName(idleName)
    Else
        idleHighKneel = idleName
        idleHighKneelSystemName = _GetSystemName(idleName)
    EndIf
EndFunction

string Function GetHighKneel(bool bound = false)
    string result = ""
    If bound
        result = idleHighKneelBound
    Else    
        result = idleHighKneel
    EndIf
    If result == ""
        result = GetHighKneelDefault()
    endif
    return result
EndFunction

string Function GetHighKneelDefault()
    string playIdle = ""
    If main.SoftCheckZAP == 1
        playIdle = "ZAP Kneel" ;"ZapWriPose06"
    ElseIf main.SoftCheckDD == 1
        playIdle = "DD Collar Me" ;"ft_bdsm_idle_collarme"
    Else
        playIdle = "Bound On Knees" ;"IdleBoundKneesStart"
    EndIf
    return playIdle
endfunction

Function SetDeepKneel(string idleName, bool bound = false)
    If bound
        idleDeepKneelBound = idleName
        idleDeepKneelBoundSystemName = _GetSystemName(idleName)
    Else
        idleDeepKneel = idleName
        idleDeepKneelSystemName = _GetSystemName(idleName)
    EndIf
EndFunction

string Function GetDeepKneel(bool bound = false)
    string result = ""
    If bound
        result = idleDeepKneelBound
    Else
        result = idleDeepKneel
    EndIf
    If result == ""
        result = GetDeepKneelDefault()
    endif
    return result
EndFunction

string Function GetDeepKneelDefault()
    string playIdle = ""
    If main.SoftCheckZAP == 1
        playIdle = "ZAP Deep Kneel" ;"ZapWriPose08"
    ElseIf main.SoftCheckDD == 1
        playIdle = "DD Collar Me" ;"ft_bdsm_idle_collarme"
    Else
        playIdle = "Bound On Knees" ;"IdleBoundKneesStart"
    EndIf
    return playIdle
endfunction

Function SetSpreadKneel(string idleName, bool bound = false)
    If bound
        idleSpreadKneelBound = idleName
        idleSpreadKneelBoundSystemName = _GetSystemName(idleName)
    Else
        idleSpreadKneel = idleName
        idleSpreadKneelSystemName = _GetSystemName(idleName)
    EndIf
EndFunction

string Function GetSpreadKneel(bool bound = false)
    string result = ""
    If bound
        result = idleSpreadKneelBound
    Else
        result = idleSpreadKneel
    EndIf
    If result == ""
        result = GetSpreadKneelDefault()
    endif
    return result
EndFunction

string Function GetSpreadKneelDefault()
    string playIdle = ""
    If main.SoftCheckZAP == 1
        playIdle = "ZAP Spread Kneel" ;"ZapWriPose07"
    ElseIf main.SoftCheckDD == 1
        playIdle = "DD Collar Me" ;"ft_bdsm_idle_collarme"
    Else
        playIdle = "Bound On Knees" ;"IdleBoundKneesStart"
    EndIf
    return playIdle
endfunction

Function SetAttention(string idleName, bool bound = false)
    If bound
        idleAttentionBound = idleName
        idleAttentionBoundSystemName = _GetSystemName(idleName)
    Else
        idleAttention = idleName
        idleAttentionSystemName = _GetSystemName(idleName)
    EndIf
EndFunction

string Function GetAttention(bool bound = false)
    string result = ""
    If bound
        result = idleAttentionBound
    Else
        result = idleAttention
    EndIf
    If result == ""
        result = GetAttentionDefault()
    endif
    return result
EndFunction

string Function GetAttentionDefault()
    return "Stand At Attention" 
endfunction

Function SetPresentHands(string idleName, bool bound = false)
    If bound
        idlePresentHandsBound = idleName
        idlePresentHandsBoundSystemName = _GetSystemName(idleName)
    Else
        idlePresentHands = idleName
        idlePresentHandsSystemName = _GetSystemName(idleName)
    EndIf
EndFunction

string Function GetPresentHands(bool bound = false)
    string result = ""
    If bound
        result =  idlePresentHandsBound
    Else
        result =  idlePresentHands
    EndIf
    If result == ""
        result = GetPresentHandsDefault()
    endif
    return result
EndFunction

string Function GetPresentHandsDefault()
    string playIdle = ""
    If main.SoftCheckZAP == 1
        playIdle = "ZAP Attention" ;"ZazAPC051"
    ElseIf main.SoftCheckDD == 1
        playIdle = "DD Kneel Hands Out" ;"ft_surrender"
    Else
        playIdle = "Bound On Knees" ;"IdleBoundKneesStart"
    EndIf
    return playIdle
endfunction

Function SetShowAss(string idleName, bool bound = false)
    If bound
        idleShowAssBound = idleName
        idleShowAssBoundSystemName = _GetSystemName(idleName)
    Else
        idleShowAss = idleName
        idleShowAssSystemName = _GetSystemName(idleName)
    EndIf
EndFunction

string Function GetShowAss(bool bound = false)
    string result = ""
    If bound
        result = idleShowAssBound
    Else
        result = idleShowAss
    EndIf
    If result == ""
        result = GetShowAssDefault()
    endif
    return result
EndFunction

string Function GetShowAssDefault()
    string playIdle = ""
    If main.SoftCheckZAP == 1
        playIdle = "ZAP Show Ass" ;"ZapWriPose03"
    ElseIf main.SoftCheckDD == 1
        playIdle = "DD Inspection" ;"ft_bdsm_idle_inspection"
    Else
        playIdle = "Bound On Knees" ;"IdleBoundKneesStart"
    EndIf
    return playIdle
endfunction

Function SetConversationPose(string idleName, bool bound = false)
    If bound
        idleConversationPoseBound = idleName
        idleConversationPoseBoundSystemName = _GetSystemName(idleName)
    Else
        idleConversationPose = idleName
        idleConversationPoseSystemName = _GetSystemName(idleName)
    EndIf
EndFunction

string Function GetConversationPose(bool bound = false)
    string result = ""
    If bound
        result = idleConversationPoseBound
    Else
        result = idleConversationPose
    EndIf
    If result == ""
        result = GetConversationPoseDefault()
    endif
    return result
EndFunction

string Function GetConversationPoseDefault()
    return "Stand At Attention"
EndFunction

Function DoHighKneel()
    string playIdle
    playIdle = ""
    If theSubRef.IsInFaction(bman.WearingHeavyBondageFaction()) ;bman2.DetectedHandsInBondage > 0
        playIdle = idleHighKneelBoundSystemName
    Else
        playIdle = idleHighKneelSystemName  
    EndIf
    ;Debug.MessageBox(playIdle)
    If playIdle == ""
        playIdle = _GetSystemName(GetHighKneelDefault())
        ; If main.SoftCheckZAP == 1
        ;     playIdle = "ZapWriPose06"
        ; ElseIf main.SoftCheckDD == 1
        ;     playIdle = "ft_bdsm_idle_collarme"
        ; Else
        ;     playIdle = "IdleBoundKneesStart"
        ; EndIf
    EndIf
    bind_Utility.WriteToConsole("DoHighKneel idle: " + playIdle)
    PoseIdleState = IDLE_STATE_KNEELING

    Debug.SendAnimationEvent(theSubRef, playIdle)

    AddToFaction(bind_KneelingFaction)

    StorageUtil.SetIntValue(theSubRef, "pose_high_kneel", 1)

    if theSubRef.IsInFaction(bind_WearingGagFaction) ;&& !theSubRef.IsInFaction(bind_WearingLocationSpecificBondageFaction)
        ;TODO - need an equip and store added to bondage manager for quick gag removal and replacing (then remove the bind_WearingLocationSpecificBondageFaction check)
        replaceGag = true
        bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is pull my gag out a bit to speak...")
        ;bman.RemoveItem(theSubRef, bman.BONDAGE_TYPE_GAG())
        ; theSubRef.AddSpell(zadgag_SpeechDebuff)
        ; zadgag_SpeechDebuff.Cast(theSubRef, theSubRef)
        zgqs.canTalk = true
    endif

    if bind_GlobalModState.GetValue() == bind_Controller.GetModStateRunning()
        ;bind_KneelingQuest.Start()
    endif

    if StorageUtil.GetIntValue(theSubRef, "kneeling_required", 1) == 1 ;if does not exist - required is the default state
		bind_GlobalKneelingOK.SetValue(1.0)
	endif



EndFunction

bool Function InHighKneel()
    If PoseIdleState == IDLE_STATE_KNEELING
        return true
    Else
        return false 
    EndIf
EndFunction

Function DoDeepKneel()
    string playIdle
    playIdle = ""
    If theSubRef.IsInFaction(bman.WearingHeavyBondageFaction()) ;bman2.DetectedHandsInBondage > 0
        playIdle = idleDeepKneelBoundSystemName
    Else
        playIdle = idleDeepKneelSystemName
    EndIf  
    If playIdle == ""
        playIdle = _GetSystemName(GetDeepKneelDefault())
        ; If main.SoftCheckZAP == 1
        ;     playIdle = "ZapWriPose08"
        ; ElseIf main.SoftCheckDD == 1
        ;     playIdle = "ft_bdsm_idle_collarme"
        ; Else
        ;     playIdle = "IdleBoundKneesStart"
        ; EndIf
    EndIf
    ;main.WindowOutput("DoDeepKneel idle: " + playIdle)
    PoseIdleState = IDLE_STATE_DEEP_KNEELING
    AddToFaction(bind_PoseDeepKneelFaction)
    Debug.SendAnimationEvent(theSubRef, playIdle)
EndFunction

bool Function InDeepKneel()
    If PoseIdleState == IDLE_STATE_DEEP_KNEELING
        return true
    Else
        return false 
    EndIf
EndFunction

Function DoSpreadKneel()
    string playIdle
    playIdle = ""
    If theSubRef.IsInFaction(bman.WearingHeavyBondageFaction()) ;bman2.DetectedHandsInBondage > 0
        playIdle = idleSpreadKneelBoundSystemName
    Else
        playIdle = idleSpreadKneelSystemName  
    EndIf
    If playIdle == ""
        playIdle = _GetSystemName(GetSpreadKneelDefault())
        ; If main.SoftCheckZAP == 1
        ;     playIdle = "ZapWriPose07"
        ; ElseIf main.SoftCheckDD == 1
        ;     playIdle = "ft_bdsm_idle_collarme"
        ; Else
        ;     playIdle = "IdleBoundKneesStart"
        ; EndIf
    EndIf
    ;main.WindowOutput("DoSpreadKneel idle: " + playIdle)
    PoseIdleState = IDLE_STATE_SPREAD_KNEELING
    AddToFaction(bind_PoseSpreadKneelFaction)
    Debug.SendAnimationEvent(theSubRef, playIdle)
EndFunction

bool Function InSpreadKneel()
    If PoseIdleState == IDLE_STATE_SPREAD_KNEELING
        return true
    Else
        return false 
    EndIf
EndFunction

Function DoAttention()
    string playIdle
    playIdle = ""
    If theSubRef.IsInFaction(bman.WearingHeavyBondageFaction()) ;bman2.DetectedHandsInBondage > 0
        playIdle = idleAttentionBoundSystemName
    Else
        playIdle = idleAttentionSystemName  
    EndIf
    If playIdle == ""
        playIdle = _GetSystemName(GetAttentionDefault())
        ; If main.SoftCheckZAP == 1
        ;     playIdle = "IdleHandsBehindBack"
        ; ElseIf main.SoftCheckDD == 1
        ;     playIdle = "IdleHandsBehindBack"
        ; Else
        ;     playIdle = "IdleHandsBehindBack"
        ; EndIf
    EndIf
   ; main.SubDialogueInCorrectPose = 1
    ;main.WindowOutput("DoAttention idle: " + playIdle)
    PoseIdleState = IDLE_STATE_ATTENTION
    AddToFaction(bind_PoseAttentionFaction)
    Debug.SendAnimationEvent(theSubRef, playIdle)
EndFunction

bool Function InAttention()
    If PoseIdleState == IDLE_STATE_ATTENTION
        return true
    Else
        return false 
    EndIf
EndFunction

Function DoPresentHands()
    string playIdle
    playIdle = ""
    If theSubRef.IsInFaction(bman.WearingHeavyBondageFaction()) ;bman2.DetectedHandsInBondage > 0
        playIdle = idlePresentHandsBoundSystemName
    Else
        playIdle = idlePresentHandsSystemName  
    EndIf
    If playIdle == ""
        playIdle = _GetSystemName(GetPresentHandsDefault())
        ; If main.SoftCheckZAP == 1
        ;     playIdle = "ZazAPC051"
        ; ElseIf main.SoftCheckDD == 1
        ;     playIdle = "ft_surrender"
        ; Else
        ;     playIdle = "IdleBoundKneesStart"
        ; EndIf
    EndIf
    ;main.WindowOutput("DoPresentHands idle: " + playIdle)
    PoseIdleState = IDLE_STATE_PRESENT_WRISTS
    AddToFaction(bind_PosePresentHandsFaction)
    Debug.SendAnimationEvent(theSubRef, playIdle)
EndFunction

bool Function InPresentHands()
    If PoseIdleState == IDLE_STATE_PRESENT_WRISTS
        return true
    Else
        return false 
    EndIf
EndFunction

Function DoShowAss()
    string playIdle
    playIdle = ""
    If theSubRef.IsInFaction(bman.WearingHeavyBondageFaction()) ;bman2.DetectedHandsInBondage > 0
        playIdle = idleShowAssBoundSystemName
    Else
        playIdle = idleShowAssSystemName  
    EndIf
    If playIdle == ""
        playIdle = _GetSystemName(GetShowAssDefault())
        ; If main.SoftCheckZAP == 1
        ;     playIdle = "ZapWriPose03"
        ; ElseIf main.SoftCheckDD == 1
        ;     playIdle = "ft_bdsm_idle_inspection"
        ; Else
        ;     playIdle = "IdleBoundKneesStart"
        ; EndIf
    EndIf
    ;main.WindowOutput("DoShowAss idle: " + playIdle)
    PoseIdleState = IDLE_STATE_SHOW_ASS
    AddToFaction(bind_PoseAssOutFaction)
    Debug.SendAnimationEvent(theSubRef, playIdle)
EndFunction

bool Function InShowAss()
    If PoseIdleState == IDLE_STATE_SHOW_ASS
        return true
    Else
        return false 
    EndIf
EndFunction

Function DoGetWhippedPose()
    ;NOTE - this is the pose for the system to use when getting whipped, the doshowass is for requesting whippings
    string playIdle
    If theSubRef.IsInFaction(bman.WearingHeavyBondageFaction()) ;bman2.DetectedHandsInBondage > 0
        playIdle = idleGetWhippedBoundSystemName
    Else
        playIdle = idleGetWhippedSystemName 
    EndIf
    If playIdle == ""
        If main.SoftCheckZAP == 1
            playIdle = "IdleHandsBehindBack"
        ElseIf main.SoftCheckDD == 1
            playIdle = "ft_bdsm_idle_inspection"
        Else
            playIdle = "IdleHandsBehindBack"
        EndIf
    EndIf
    ;main.WindowOutput("DoGetWhippedPose idle: " + playIdle)
    AddToFaction(bind_PoseWhippedFaction)
    Debug.SendAnimationEvent(theSubRef, playIdle)
EndFunction

Function DoPrayerPose()
    string playIdle
    If theSubRef.IsInFaction(bman.WearingHeavyBondageFaction()) ;bman2.DetectedHandsInBondage > 0
        playIdle = idlePrayerBound
    Else
        playIdle = idlePrayer 
    EndIf
    If playIdle == ""
        playIdle = "IdleGreybeardMeditateEnter"
    EndIf
    
    PoseIdleState = IDLE_STATE_PRAYER

    Debug.SendAnimationEvent(theSubRef, playIdle)

    AddToFaction(bind_PosePrayerFaction)

EndFunction

bool Function InPrayerPose()
    If PoseIdleState == IDLE_STATE_PRAYER
        return true
    Else
        return false 
    EndIf
EndFunction

Function DoSitOnGround()
    string playIdle
    If theSubRef.IsInFaction(bman.WearingHeavyBondageFaction()) ;bman2.DetectedHandsInBondage > 0
        playIdle = idleSitGroundBoundSystemName
    Else
        playIdle = idleSitGroundSystemName 
    EndIf
    If playIdle == ""
        playIdle = "IdleSitCrossLeggedEnter"
    EndIf
    PoseIdleState = IDLE_STATE_SIT_GROUND
    AddToFaction(bind_PoseSitOnGroundFaction)
    Debug.SendAnimationEvent(theSubRef, playIdle)
EndFunction

bool Function InSitOnGround()
    If PoseIdleState == IDLE_STATE_SIT_GROUND
        return true
    Else
        return false 
    EndIf
EndFunction

Function DoHogtiedPose()

    ;does DD have some lying down bound animation?
    ;make ZAP rotate the 6 different poses (randmonint)

    string playIdle

    If main.SoftCheckZAP == 1
        playIdle = "ZazAPCAO05"
        int rnd = Utility.RandomInt(1, 5)
        playIdle = playIdle + rnd
    ElseIf main.SoftCheckDD == 1
        playIdle = "ft_bdsm_idle_egyptian"
    Else
        playIdle = "IdleBoundKneesStart"
    EndIf

    ;playIdle = "ft_fall_over_armbinder_1"

    bind_Utility.LogOutput("DoHogtiedPose idle: " + playIdle)
    PoseIdleState = IDLE_STATE_HOGTIED
    Debug.SendAnimationEvent(theSubRef, playIdle)

EndFunction

bool Function InHogtiedPose()
    If PoseIdleState == IDLE_STATE_HOGTIED
        return true
    Else
        return false 
    EndIf
EndFunction

Function DoBoundOnKnees()
    string playIdle
    playIdle = "IdleBoundKneesStart"
    PoseIdleState = IDLE_STATE_BOUND_ON_KNEES
    Debug.SendAnimationEvent(theSubRef, playIdle)
EndFunction

bool Function InBoundOnKnees()
    If PoseIdleState == IDLE_STATE_BOUND_ON_KNEES
        return true
    Else
        return false 
    EndIf
EndFunction

Function DoConversationPose()
    string playIdle
    playIdle = ""
    If theSubRef.IsInFaction(bman.WearingHeavyBondageFaction()) ;bman2.DetectedHandsInBondage > 0
        playIdle = idleConversationPoseBoundSystemName
    Else
        playIdle = idleConversationPoseSystemName  
    EndIf
    If playIdle == ""
        playIdle = _GetSystemName(GetConversationPoseDefault())
    EndIf
    ;main.SubDialogueInCorrectPose = 1
    ;main.WindowOutput("DoAttention idle: " + playIdle)
    PoseIdleState = IDLE_STATE_CONVERSATION_POSE
    
    Debug.SendAnimationEvent(theSubRef, playIdle)

    AddToFaction(bind_PoseConversationFaction)

    if theSubRef.IsInFaction(bind_WearingGagFaction) ;&& !theSubRef.IsInFaction(bind_WearingLocationSpecificBondageFaction)
        replaceGag = true
        ;theSubRef.AddSpell(zadgag_SpeechDebuff)
        ;bman.RemoveItem(theSubRef, bman.BONDAGE_TYPE_GAG())
        zgqs.canTalk = true
    endif

    if rms.GetBehaviorRule(theSubRef, rms.BEHAVIOR_RULE_SPEECH_DOM()) == 1 ;.GetBehaviorRuleByName("Speech Rule:Dom Speaks") == 1
        
        if main.SoftCheckChim == 1 && main.EnableModChim == 1
            bind_Utility.WriteToConsole("CHIM enabled, not starting bind_ConversationQuest")
            bind_Utility.SendSimpleModEvent("bind_ConversationPoseEvent")
        else
            bind_ConversationQuest.Start()
        endif

        StorageUtil.SetFloatValue(theSubRef, "bind_temp_speaking_permission", bind_Utility.AddTimeToCurrentTime(1, 0))
    endif

EndFunction

bool Function InConversationPose()
    If PoseIdleState == IDLE_STATE_CONVERSATION_POSE
        return true
    Else
        return false 
    EndIf
EndFunction

function DoInspection()

    string playIdle = "ft_bdsm_idle_inspection"

    PoseIdleState = IDLE_STATE_INSPECTION
    
    Debug.SendAnimationEvent(theSubRef, playIdle)

    AddToFaction(bind_PoseInspectionFaction)

endfunction

bool Function InInspectionPose()
    If PoseIdleState == IDLE_STATE_INSPECTION
        return true
    Else
        return false 
    EndIf
EndFunction

Function DoUndress()

    int Gender = theSubRef.GetLeveledActorBase().GetSex()
    Debug.SendAnimationEvent(theSubRef, "Arrok_Undress_G" + Gender)

EndFunction

Function ResumeStanding()    
	string standingIdle 
    ;standingIdle = bman2.GetStandingIdle(0)
    ;If standingIdle == ""
        standingIdle = "IdleForceDefaultState"
    ;EndIf
    ;Debug.MessageBox("stand idle: " + standingIdle)
    ;main.SubDialogueInCorrectPose = 0
	bind_Utility.LogOutput("returned idle: " + standingIdle)
    PoseIdleState = IDLE_STATE_NONE
	Debug.SendAnimationEvent(theSubRef, standingIdle)
    RemovePosingFactions()
    EndQuests()
EndFunction

bool Function InNoPose()
    If PoseIdleState == IDLE_STATE_NONE
        return true
    Else
        return false 
    EndIf
EndFunction

bool function IsInPose()
    if theSubRef.IsInFaction(bind_InPoseFaction)
        return true
    else
        return false
    endif
endfunction

function AddToFaction(Faction f)
    if !theSubRef.IsInFaction(bind_InPoseFaction)
        theSubRef.AddToFaction(bind_InPoseFaction)
    endif
    if !theSubRef.IsInFaction(f)
        theSubRef.AddToFaction(f)
    endif
endfunction

function RemovePosingFactions()

    StorageUtil.SetIntValue(theSubRef, "pose_high_kneel", 0)

    if StorageUtil.GetIntValue(theSubRef, "kneeling_required", 1) == 1 
		bind_GlobalKneelingOK.SetValue(0.0) ; standing / not posing again
	endif

    if replaceGag
        replaceGag = false
        ;theSubRef.RemoveSpell(zadgag_SpeechDebuff)
        ;bman.AddItem(theSubRef, bman.BONDAGE_TYPE_GAG())
        zgqs.canTalk = false
        if theSubRef.IsInFaction(bind_KneelingFaction) ;should still be in this faction before standing
            bind_Utility.WriteInternalMonologue(fs.GetDomTitle() + " is shoving my gag back in...")
        endif
        ;bind_Utility.WriteInternalMonologue(main.GetDomTitle() + " is shoving my gag back in...")
        ;TODO - add a gag keyword check on safeword and set this to false if detected - just in case
    endif

    if theSubRef.IsInFaction(bind_InPoseFaction)
        theSubRef.RemoveFromFaction(bind_InPoseFaction)
    endif

    if theSubRef.IsInFaction(bind_KneelingFaction)
        theSubRef.RemoveFromFaction(bind_KneelingFaction)
    endif

    if theSubRef.IsInFaction(bind_PoseConversationFaction)
        theSubRef.RemoveFromFaction(bind_PoseConversationFaction)
    endif

    if theSubRef.IsInFaction(bind_PosePrayerFaction)
        theSubRef.RemoveFromFaction(bind_PosePrayerFaction)
    endif

    if theSubRef.IsInFaction(bind_PoseInspectionFaction)
        theSubRef.RemoveFromFaction(bind_PoseInspectionFaction)
    endif

    if theSubRef.IsInFaction(bind_PoseAssOutFaction)
        theSubRef.RemoveFromFaction(bind_PoseAssOutFaction)
    endif

    if theSubRef.IsInFaction(bind_PoseAttentionFaction)
        theSubRef.RemoveFromFaction(bind_PoseAttentionFaction)
    endif

    if theSubRef.IsInFaction(bind_PoseDeepKneelFaction)
        theSubRef.RemoveFromFaction(bind_PoseDeepKneelFaction)
    endif

    if theSubRef.IsInFaction(bind_PosePresentHandsFaction)
        theSubRef.RemoveFromFaction(bind_PosePresentHandsFaction)
    endif

    if theSubRef.IsInFaction(bind_PoseSitOnGroundFaction)
        theSubRef.RemoveFromFaction(bind_PoseSitOnGroundFaction)
    endif

    if theSubRef.IsInFaction(bind_PoseSpreadKneelFaction)
        theSubRef.RemoveFromFaction(bind_PoseSpreadKneelFaction)
    endif

    if theSubRef.IsInFaction(bind_PoseWhippedFaction)
        theSubRef.RemoveFromFaction(bind_PoseWhippedFaction)
    endif

endfunction

function EndQuests()
    if bind_KneelingQuest.IsRunning()
        ;bind_KneelingQuest.Stop()
    endif

    ; if bind_ConversationQuest.IsRunning()
    ;     (bind_ConversationQuest as bind_ConversationQuestScript).EndQuest()
    ; endif


endfunction

function StandFromKneeling(Actor a) global

    if StorageUtil.GetIntValue(a, "pose_high_kneel", 0) == 1
		bind_Controller.SendActionKneelTriggerEvent()
		bind_Utility.DoSleep(2.0)
    endif

endfunction

;zadexpressionlibs property zexplib auto
; zadLibs property zlib auto
; Spell property zadgag_SpeechDebuff auto

zadGagQuestScript property zgqs auto

bind_MainQuestScript property main auto
bind_BondageManager property bman auto
bind_RulesManager property rms auto
bind_Functions property fs auto
;bind_BondageManager property bman2 auto

Quest property bind_KneelingQuest auto
Quest property bind_ConversationQuest auto

GlobalVariable property bind_GlobalModState auto
GlobalVariable property bind_GlobalKneelingOK auto

Faction property bind_InPoseFaction auto

Faction property bind_KneelingFaction auto
Faction property bind_PoseAssOutFaction auto
Faction property bind_PoseAttentionFaction auto
Faction property bind_PoseConversationFaction auto
Faction property bind_PoseDeepKneelFaction auto
Faction property bind_PosePrayerFaction auto
Faction property bind_PosePresentHandsFaction auto
Faction property bind_PoseSitOnGroundFaction auto
Faction property bind_PoseSpreadKneelFaction auto
Faction property bind_PoseWhippedFaction auto
Faction property bind_PoseInspectionFaction auto

Faction property bind_WearingGagFaction auto
Faction property bind_WearingLocationSpecificBondageFaction auto

;dom idles?
;

;IdleComeThisWay - quick animation summoning somebody to a location
;IdleExamine
;IdleLockPick
;IdlePointClose

;sub idles?
;
;IdlePray - arms both up and out sightly raised (looping)
;IdleSurrender - does a quick arms up above head and returns to normal (not sure what it would be useful for)
;IdleKneeling - might a good untied idle (looks a bit like like a knight to a lord) (looping)
;IdleGreybeardMeditateEnter - might make a good untied kneel. on knees with arms spread. (looping)
;BoundStandingCut - quick animation where cross wrists bound in front are cut loose
;IdleBoundKneesStart - this is a pretty good kneel with arms behind back, but has leather bindings (looping)
;IdleSilentBow - quick animation with a slight bow and arms sweeping out
;IdleSitCrossLeggedEnter - this would be perfect for a sit on the floor rule (looping) [USE THIS!!!]
;IdleWoodChopEnterInstant - chopping wood with ake and logs, this might be great for camp setup (looping)
;OffsetBoundStandingStart - hands behind back, need to test more??



;ZazAPC011 laying flat with hands behind back - sleep? camping?
;17 kneel headdown knees wide bound wrists
;18 bow head down kneel sitting on feet
;19 bow head down kneel with wide knees
;20 deep bow head down kneel with wide knees

;51 hands behind back (zap armbinder pos?), standing very straight, feet together
;53 hands behind back (zap elbowbinder?), standing straight, feet slightly apart

;58 kneeling (zap elbowbinder), legs wide

;ZazAPOA008 - standing wrists crossed x, feet slightly spread
;10 - wrists crossed in x behind head, feet slightly spread
;13 - standing (elbowbinder) - feet slightly spread
;14 - wrists touching in front - feet slightly spread
;23 - standing (eblowbinder tight) - feet slightly spread

;spread - sex
;deep kneel - sleep, camping (maybe furniture during the day, camping at night if by furniture)
;high kneel - speaking
;present wrists - tied / untied
;attention - dismisal / maybe dom merchant talk??

;should look at this? akTarget.PlayIdle(IdleStop_Loose) - use to stop SendAnimationEvent

;hogtied
;ZazAPCAO051 - 55