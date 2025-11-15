Scriptname bind_MainQuestScript extends Quest conditional 

int property SaveGameUid auto conditional
string property GameSaveFolder auto conditional
string property GameSaveFolderJson auto conditional

string property BindingGameFolder auto conditional ;this should replace the two above?
string property BindingGameOutfitFile auto conditional

string property ActiveQuestName auto conditional

;string property BondageSetLocation auto conditional
int property ActiveBondageSetId auto conditional
string property ActiveBondageSetName auto conditional
int property NeedsBondageSetChange auto conditional

int property LogOutputToScreen auto conditional
int property ActionKeyMappedKeyCode auto conditional
int property ActionKeyModifier auto conditional
int property ShowFurnitureMenu auto conditional
int property CleanUpNonBindingItemsFromBags auto conditional

int property SoftCheckHasBondageFramework auto conditional
int property SoftCheckHasSexFramework auto conditional
int property SoftCheckPama auto conditional
int property SoftCheckDirtAndBlood auto conditional
int property SoftCheckBathingInSkyrim auto conditional
int property SoftCheckDM3 auto conditional
int property SoftCheckDD auto conditional
int property SoftCheckZAP auto conditional
int property SoftCheckDDNG auto conditional
string property SoftCheckZAPVersion auto conditional
int property SoftCheckMME auto conditional
int property SoftCheckChim auto conditional
int property SoftCheckSkyrimNet auto conditional
int property SoftCheckGoToBed auto conditional
int property SoftCheckDwarvenDeviousCuirass auto conditional
int property SoftCheckGunslinger auto conditional

int property SoftCheckSweepingOrganizesStuff auto conditional


int property ModsVersion auto conditional
int property EnableModPama auto conditional
int property EnableModDM3 auto conditional
int property EnableModDD auto conditional
int property EnableModZAP auto conditional
int property EnableModDirtAndBlood auto conditional
int property EnableModBathingInSkyrim auto conditional
int property EnableModMME auto conditional
int property EnableModChim auto conditional
int property EnableModSkyrimNet auto conditional


int property IsSub auto conditional
int property SubCount auto conditional
int property HasSecondSub auto conditional
int property HasThirdSub auto conditional

int property DomDoorDiscovery auto conditional
int property PreferenceFreeWhenDismissedDisabled auto conditional
int property SubIdleState auto conditional 
int property ModInDebugMode auto conditional
int property GamePreferenceUseFakeSleep auto conditional

int property SexFreeUse auto conditional
int property SexDomArousalLevelToTrigger auto conditional
int property SexChanceOfChastityRemoval auto conditional
int property SexUseFramework auto conditional
int property SexDomWantsPrivacy auto conditional

string property SubName auto conditional
string property DominantName auto conditional
int property DominantSex auto conditional
int property DomInCombat auto conditional


int property SuspendRulesOutsideOfCitiesAndTowns auto conditional
int property SuspendRulesNearEnemies auto conditional
int property SuspendRulesAutomatic auto conditional

int property AdventuringManual auto conditional
int property AdventuringFreeHands auto conditional
int property AdventuringAllowClothing auto conditional
int property AdventuringSuspendRules auto conditional
int property AdventuringAutomatic auto conditional
int property AdventuringSafeBondageApplied auto conditional
float property AdventuringCheckAfterSeconds auto conditional

int property AdventuringCheckStatus auto conditional
int property AdventuringUse auto conditional
int property AdventuringPointCost auto conditional
int property AdventuringGoodBehavior auto conditional
int property AdventuringTimeOfDayCheck auto conditional
int property AdventuringGoldGoal auto conditional
int property AdventuringImporantKill auto conditional
int property AdventuringUseDwarven auto conditional

int property DomPreferenceUntieForCombat auto conditional

int property DomPreferenceDressForCombat auto conditional
int property DomPreferenceUntieForDangerousAreas auto conditional
int property DomPreferenceDressForDangerousAreas auto conditional
int property DomPreferenceUntieHandsOutsideOfCitiesAndTowns auto conditional
int property DomPreferenceDressOutsideOfCitiesAndTowns auto conditional

int property DomPreferenceAllowsWeapons auto conditional
int property DomPreferenceNoArmor auto conditional
int property DomPreferenceUseRequiredOutfit auto conditional

int property PutOnDisplayRandomUse auto conditional
int property PutOnDisplayHoursBetweenUse auto conditional
int property PutOnDisplayMinMinutes auto conditional
int property PutOnDisplayMaxMinutes auto conditional
int property PutOnDisplayChance auto conditional

int property BedtimeFurnitureForSleep auto conditional

int property HarshBondageRandomUse auto conditional
int property HarshBondageHoursBetweenUse auto conditional
int property HarshBondageChance auto conditional
int property HarshBondageMinMinutes auto conditional
int property HarshBondageMaxMinutes auto conditional

int property InspectionsRandomUse auto conditional
int property InspectionChance auto conditional
int property InspectionHoursBetween auto conditional

int property WhippingRandomUse auto conditional
int property WhippingChance auto conditional
int property WhippingHoursBetween auto conditional

int property CampingRandomUse auto conditional
int property CampingChance auto conditional

int property DomPreferenceBoundSleepMinHours auto conditional
int property DomPreferenceBoundSleepMaxHours auto conditional

int property CampingEventMinHours auto conditional
int property CampingEventMaxHours auto conditional

int property PublicHumiliationMinMinutes auto conditional
int property PublicHumiliationMaxMinutes auto conditional

int property DomPreferenceCleanSub auto conditional
int property DomOnlyUnplugsPanelGags auto conditional
int property DomRemovesGagForDialogue auto conditional
int property DomWillNotOfferFreedom auto conditional
int property DomUseWordWallEvent auto conditional
int property DomUseDragonSoulRitual auto conditional
int property DomChastiseForRuleBreaking auto conditional
int property DomStartupQuestsEnabled auto conditional

int property WriteLogs auto conditional

int property DisplayLocationChange auto conditional
int property SubIndoors auto conditional

int property RulePoints auto conditional
float property RulesMenuLockoutTime auto conditional

int property SubDirtLevel auto conditional

int property RuleMustCleanPlayerHome auto conditional
int property SubCleanedPlayerHome auto conditional

float property SubDistanceFromDomAtAction auto conditional

int property GameplayAnyNpcCanDom auto conditional

int property QuestDrankQty auto conditional
int property QuestAteQty auto conditional

;***********************************************************
;thinking dom script conditional variables
int property PunishmentsDue auto conditional
int property PunishmentsTotal auto conditional

int property RulesChancePerHour auto conditional
int property RulesMaxNumber auto conditional

int property PointsMax auto conditional
int property PointsEarnFromSex auto conditional
int property PointsEarnFromHarshBondage auto conditional
int property PointsEarnFromFurniture auto conditional
int property PointsEarnFromBeingGood auto conditional

int property LikesWeatherTemp auto conditional ;1 - cold, 2 - cool, 3 - warm

int property LikesCityWhiterun auto conditional
int property LikesCityMarkarth auto conditional
int property LikesCityMorthal auto conditional
int property LikesCityWindhelm auto conditional
int property LikesCitySolitude auto conditional
int property LikesCityFalkreath auto conditional
int property LikesCityRiften auto conditional
int property LikesCityWinterhold auto conditional
int property LikesCityRavenRock auto conditional
int property LikesCityDawnstar auto conditional

int property SimpleSlaveryFemaleFallback auto conditional
int property SimpleSlaveryMaleFallback auto conditional

int property ExperimentalFeaturesFlag auto conditional
int property ProtectSltr auto conditional

;*********************************************************
;skyrimnet variables
int property SkryimNetSlaveryType auto conditional

GlobalVariable property bind_GlobalSettingsSubType auto
GlobalVariable property bind_GlobalSettingsSlaveryInSkyrim auto
GlobalVariable property bind_GlobalSettingsIndenturedInSkyrim auto

GlobalVariable property bind_GlobalPlayerNudity auto

GlobalVariable property bind_GlobalRulesBondageMax auto
GlobalVariable property bind_GlobalRulesBondageMin auto
GlobalVariable property bind_GlobalRulesBehaviorMax auto
GlobalVariable property bind_GlobalRulesBehaviorMin auto
GlobalVariable property bind_GlobalRulesLastRule auto
GlobalVariable property bind_GlobalRulesNextRule auto
GlobalVariable property bind_GlobalRulesHoursBetween auto

GlobalVariable property bind_GlobalLocationHasBed auto
GlobalVariable property bind_GlobalLocationHasFurniture auto

GlobalVariable property bind_GlobalEventCampingChance auto
GlobalVariable property bind_GlobalEventCampingNextRun auto
GlobalVariable property bind_GlobalEventWhippingChance auto
GlobalVariable property bind_GlobalEventWhippingNextRun auto

GlobalVariable property bind_GlobalEventHarshBondageNextRun auto
GlobalVariable property bind_GlobalEventInspectionNextRun auto
GlobalVariable property bind_GlobalEventPutOnDisplayNextRun auto


event OnInit()

endevent

bind_MainQuestScript function GetMainQuestScript() global
    return Quest.GetQuest("bind_MainQuest") as bind_MainQuestScript
endfunction