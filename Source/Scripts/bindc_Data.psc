Scriptname bindc_Data extends Quest conditional

;******************************************************
;CONSTANTS
;******************************************************




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