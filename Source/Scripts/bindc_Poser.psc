Scriptname bindc_Poser extends Quest conditional 

int property POSE_TYPE_NONE = 0 autoReadOnly
int property POSE_TYPE_KNEELING = 10 autoReadOnly
int property POSE_TYPE_SITTING_GROUND = 20 autoReadOnly 
int property POSE_TYPE_PRAYER = 30 autoReadOnly
int property POSE_TYPE_SPREAD_KNEEL = 40 autoReadOnly
int property POSE_TYPE_ATTENTION = 50 autoReadOnly
int property POSE_TYPE_PRESENT_HANDS = 60 autoReadOnly
int property POSE_TYPE_WHIPPING = 70 autoReadOnly
int property POSE_TYPE_ASS_OUT = 80 autoReadOnly
int property POSE_TYPE_CONVERSATION = 90 autoReadOnly
int property POSE_TYPE_DEEP_KNEEL = 100 autoReadOnly
int property POSE_TYPE_DOORSTEP = 110 autoReadOnly

bool function IsNotPosed(Actor akActor)
    return StorageUtil.GetIntValue(akActor, "bindc_pose", 0) == POSE_TYPE_NONE
endfunction

bool function InPrayerPose(Actor akActor)
    return StorageUtil.GetIntValue(akActor, "bindc_pose", 0) == POSE_TYPE_PRAYER
endfunction

bool function IsSittingOnGround(Actor akActor)
    return StorageUtil.GetIntValue(akActor, "bindc_pose", 0) == POSE_TYPE_SITTING_GROUND
endfunction

bool function IsKneeling(Actor akActor)
    return StorageUtil.GetIntValue(akActor, "bindc_pose", 0) == POSE_TYPE_KNEELING
endfunction

bool function InDoorstepPose(Actor akActor)
    return StorageUtil.GetIntValue(akActor, "bindc_pose", 0) == POSE_TYPE_DOORSTEP
endfunction

bool function InConversationPose(Actor akActor)
    return StorageUtil.GetIntValue(akActor, "bindc_pose", 0) == POSE_TYPE_CONVERSATION
endfunction

bool function InPresentHandsPose(Actor akActor)
    return StorageUtil.GetIntValue(akActor, "bindc_pose", 0) == POSE_TYPE_PRESENT_HANDS
endfunction

function Kneel(Actor akActor)
    debug.SendAnimationEvent(akActor, StorageUtil.GetStringValue(none, "bindc_pose_kneel", "ZazAPC017")); "ZazAPC018") ;ZapWriPose06 
    StorageUtil.SetIntValue(akActor, "bindc_pose", POSE_TYPE_KNEELING)
    if !akActor.IsInFaction(bindc_KneelingFaction)
        akActor.SetFactionRank(bindc_KneelingFaction, 0)
    endif
    if akActor.GetFactionRank(bindc_KneelingFaction) == 0
        akActor.SetFactionRank(bindc_KneelingFaction, 1)
    endif
endfunction

function ClearPose(Actor akActor)
    debug.SendAnimationEvent(akActor, "IdleForceDefaultState")
    StorageUtil.SetIntValue(akActor, "bindc_pose", POSE_TYPE_NONE)
    if !akActor.IsInFaction(bindc_KneelingFaction)
        akActor.SetFactionRank(bindc_KneelingFaction, 0)
    endif
    if akActor.GetFactionRank(bindc_KneelingFaction) == 1
        akActor.SetFactionRank(bindc_KneelingFaction, 0)
    endif
endfunction

function PrayerPose(Actor akActor)
    debug.SendAnimationEvent(akActor, StorageUtil.GetStringValue(none, "bindc_pose_prayer", "IdleGreybeardMeditateEnter"))
    StorageUtil.SetIntValue(akActor, "bindc_pose", POSE_TYPE_PRAYER)
endfunction

function SitOnGroundPose(Actor akActor)
    debug.SendAnimationEvent(akActor, StorageUtil.GetStringValue(none, "bindc_pose_sit", "IdleSitCrossLeggedEnter"))
    StorageUtil.SetIntValue(akActor, "bindc_pose", POSE_TYPE_SITTING_GROUND)
endfunction

function SpreadKneelPose(Actor akActor)
    debug.SendAnimationEvent(akActor, StorageUtil.GetStringValue(none, "bindc_pose_spread", "ZapWriPose07"))
    StorageUtil.SetIntValue(akActor, "bindc_pose", POSE_TYPE_SPREAD_KNEEL)
endfunction

function AttentionPose(Actor akActor)
    debug.SendAnimationEvent(akActor, StorageUtil.GetStringValue(none, "bindc_pose_attention", "IdleHandsBehindBack"))
    StorageUtil.SetIntValue(akActor, "bindc_pose", POSE_TYPE_ATTENTION)
endfunction

function PresentHandsPose(Actor akActor)
    debug.SendAnimationEvent(akActor, StorageUtil.GetStringValue(none, "bindc_pose_present", "ft_surrender"))
    StorageUtil.SetIntValue(akActor, "bindc_pose", POSE_TYPE_PRESENT_HANDS)
endfunction

function WhippingPose(Actor akActor)
    debug.SendAnimationEvent(akActor, StorageUtil.GetStringValue(none, "bindc_pose_whip", "ft_bdsm_idle_inspection"))
    StorageUtil.SetIntValue(akActor, "bindc_pose", POSE_TYPE_WHIPPING)
endfunction

function AssOutPose(Actor akActor)
    debug.SendAnimationEvent(akActor, StorageUtil.GetStringValue(none, "bindc_pose_ass", "ZapWriPose03"))
    StorageUtil.SetIntValue(akActor, "bindc_pose", POSE_TYPE_ASS_OUT)
endfunction

function ConversationPose(Actor akActor)
    debug.SendAnimationEvent(akActor, StorageUtil.GetStringValue(none, "bindc_pose_conversation", "IdleHandsBehindBack"))
    StorageUtil.SetIntValue(akActor, "bindc_pose", POSE_TYPE_CONVERSATION)
endfunction

function DeepKneelPose(Actor akActor)
    debug.SendAnimationEvent(akActor, StorageUtil.GetStringValue(none, "bindc_pose_deep", "ZazAPC020")) ;17,18
    StorageUtil.SetIntValue(akActor, "bindc_pose", POSE_TYPE_DEEP_KNEEL)
endfunction

function DoorstepPose(Actor akActor)
    debug.SendAnimationEvent(akActor, StorageUtil.GetStringValue(none, "bindc_pose_door", "ZapWriPose08"))
    StorageUtil.SetIntValue(akActor, "bindc_pose", POSE_TYPE_DOORSTEP)
endfunction

Faction property bindc_KneelingFaction auto