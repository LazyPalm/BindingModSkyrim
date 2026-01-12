Scriptname bindc_Data extends Quest conditional

;******************************************************
;CONSTANTS
;******************************************************
int property EventBoundSleepEnabledDefault = 1 autoReadOnly
int property EventBoundSleepChanceDefault = 50 autoReadOnly
int property EventBoundSleepCooldownDefault = 20 autoReadOnly

int property EventCampEnabledDefault = 1 autoReadOnly
int property EventCampMinDefault = 4 autoReadOnly
int property EventCampMaxDefault = 8 autoReadOnly
int property EventCampChanceDefault = 5 autoReadOnly
int property EventCampCooldownDefault = 20 autoReadOnly

int property EventFreeEnabledDefault = 1 autoReadOnly
int property EventFreeCooldownDefault = 4 autoReadOnly

int property EventHarshEnabledDefault = 1 autoReadOnly
int property EventHarshMinDefault = 20 autoReadOnly
int property EventHarshMaxDefault = 30 autoReadOnly
int property EventHarshChanceDefault = 5 autoReadOnly
int property EventHarshCooldownDefault = 6 autoReadOnly

int property EventInspectEnabledDefault = 1 autoReadOnly
int property EventInspectChanceDefault = 5 autoReadOnly
int property EventInspectCooldownDefault = 20 autoReadOnly

int property EventDisplayEnabledDefault = 1 autoReadOnly
int property EventDisplayMinDefault = 30 autoReadOnly
int property EventDisplayMaxDefault = 45 autoReadOnly
int property EventDisplayChanceDefault = 5 autoReadOnly
int property EventDisplayCooldownDefault = 6 autoReadOnly

int property DomArousalNeededForSex = 70 autoReadOnly

;******************************************************
;SETTINGS
;******************************************************

;submissive preferences
int property SubPref_KneelingRequired auto conditional

;preferences
int property Preference_CleanUpNonBindingItemsFromBags auto conditional
int property Preference_ProtectSltr auto conditional

;******************************************************
;VARIABLES
;******************************************************
int property SlaveryQuest_InGaggedPunishment auto conditional ;being in here protects this against safeword quest restarting
float property SlaveryQuest_GaggedPunishmentEndTime auto conditional

;******************************************************
;Linked
;******************************************************

zadLibs property zlib auto
zadGagQuestScript property zgqs auto

bindc_Main property MainScript auto
bindc_Rules property RulesScript auto
bindc_Bondage property BondageScript auto
bindc_Poser property PoserScript auto
bindc_Gear property GearScript auto
bindc_SexLab property SexLabScript auto
bindc_Furn property FurnScript auto