Scriptname bind_ZapHelper extends Quest  

bool Function CheckValid() Global
    return Game.GetModByName("ZazAnimationPack.esm") != 255
EndFunction

string Function GetVersion() Global
    return zbfUtil.GetVersionStr()
EndFunction

; zbfBondageShell Function GetZbfBondageShell() Global
;     return Quest.GetQuest("zbf") as zbfBondageShell
; EndFunction

; zbfUtil Function GetZbfUtility() Global

; EndFunction

; Keyword Function GetBindingKeyword() Global
;     ;zbfWornDevice
;     return Keyword.GetKeyword("zbfWornDevice")
;     ; string assetsFile = "ZaZAnimationPack.esm"
;     ; return Game.GetFormFromFile(0x0800A17C, assetsFile) as Keyword
; EndFunction

Keyword Function GetFurnitureKeyword() Global
    ;zbfFurniture
    return Keyword.GetKeyword("zbfFurniture")
    ; string assetsFile = "ZaZAnimationPack.esm"
    ; return Game.GetFormFromFile(0x0800762B, assetsFile) as Keyword
EndFunction

; Keyword Function GetFurnitureWaterWheelKeyword() Global
;     ;zbfFurnitureWaterWheelMini
;     return Keyword.GetKeyword("zbfFurnitureWaterWheelMini")
;     ; string assetsFile = "ZaZAnimationPack.esm"
;     ; return Game.GetFormFromFile(0x08056946, assetsFile) as Keyword
; EndFunction



; string function GetJsonItemsFileName() Global
;     return "binding_zap_items.json"
; endfunction

; string function GetJsonFurnitureFileName() Global
;     return "binding_zap_furniture.json"
; endfunction

; string function GetDefault(string itemCategory) Global
;     return JsonUtil.GetPathStringValue(GetJsonItemsFileName(), "." + itemCategory)
; endfunction

; string function GetList(string itemCategory) Global
;     string list = ""
;     string path = "." + itemCategory
;     string[] items = JsonUtil.PathMembers(GetJsonItemsFileName(), path)
;     ;Debug.MessageBox("path: " + path + " len: " + items.Length)
;     int i = 0
;     while i < items.Length
;         if i > 0
;             list += ","
;         endif
;         list += items[i]
;         i += 1
;     endwhile
;     return list
; endfunction

; Armor function GetItem(string itemCategory, string itemName) Global
;     ; string path = "." + itemCategory + "." + itemName
;     ; string[] itemArray = JsonUtil.PathStringElements(GetJsonItemsFileName(), path)
;     ; return Game.GetFormFromFile(PO3_SKSEFunctions.StringToInt(itemArray[0]), itemArray[1]) as Armor
;     string path = "." + itemCategory + "." + itemName
;     string fileName = JsonUtil.GetPathStringValue(GetJsonItemsFileName(), path + ".fname")
;     string item = JsonUtil.GetPathStringValue(GetJsonItemsFileName(), path + ".item_inv")
;     return Game.GetFormFromFile(PO3_SKSEFunctions.StringToInt(item), fileName) as Armor
; endfunction

; int[] function GetItemSlots(string itemCategory, string itemName) Global
;     string path = "." + itemCategory + "." + itemName + ".slots"
;     ;Debug.MessageBox("path: " + path)
;     ;Debug.MessageBox("items: " + JsonUtil.PathIntElements(GetJsonItemsFileName(), path))
;     return JsonUtil.PathIntElements(GetJsonItemsFileName(), path)
; endfunction



; ; string Function BindingsWristList() Global
; ;     string list = "ZAP WRI Ropes,ZAP WRI Handcuffs Black,ZAP WRI Handcuffs Copper,ZAP WRI Handcuffs Gold,ZAP WRI Handcuffs Shiny"
; ;     return list
; ; EndFunction

; ; string Function BindingsElbowList() Global
; ;     string list = "ZAP ELB Ropes 1,ZAP ELB Ropes 2"
; ;     return list
; ; EndFunction

; ; string Function BindingsBodyList() Global
; ;     string list = "ZAP BOD Breast Rope Extreme,ZAP BOD Breast Waist Extreme,ZAP BOD Chastity Bra,ZAP BOD Shibari,ZAP BOD Waist and Breast,ZAP BOD Waist Rope"
; ;     return list
; ; EndFunction

; ; String function BindingsGagsList() Global
; ;     string list = "ZAP GAG Ball,ZAP GAG Harness Ball,ZAP GAG Harness Panel,ZAP GAG Harness Ring,ZAP GAG Panel,ZAP GAG Muzzle,ZAP GAG Ring,ZAP GAG Bit"
; ;     return list
; ; EndFunction

; ; String function BindingsCorsetsList() Global
; ;     string list = ""
; ;     return list
; ; EndFunction

; ; String function BindingsBootsList() Global
; ;     string list = "ZAP Shackles"
; ;     return list
; ; EndFunction

; ; String function BindingsAnklesList() Global
; ;     string list = "ZAP ANK Ropes,ZAP ANK Simple Black,ZAP ANK Simple Copper,ZAP ANK Simple Gold,ZAP ANK Simple Shiny"
; ;     return list
; ; EndFunction

; ; String function BindingsCollarsList() Global
; ;     string list = "ZAP COL Rope,ZAP COL Simple Black,ZAP COL Simple Copper,ZAP COL Simple Gold,ZAP COL Simple Shiny,"
; ;     list = list + "ZAP COL Leather Rings,ZAP COL Leather Belt,ZAP COL Padded,ZAP COL Posture Leather,ZAP COL Posture Padded,"
; ;     list = list + "ZAP COL Iron Black,ZAP COL Harness"
; ;     return list
; ; EndFunction

; ; String function BindingsChastityList() Global
; ;     string list = "ZAP CHA Iron,ZAP CHA Padded,ZAP CHA Padded Ass Open,ZAP CHA Iron With Plugs"
; ;     return list
; ; EndFunction

; ; String function BindingsPiercingList() Global
; ;     string list = "ZAP Nipple Screw"
; ;     return list
; ; EndFunction

; ; String Function BindingsHoodsList() Global
; ;     string list = "ZAP Hood,ZAP Hood Light,ZAP Hood Canvas"
; ;     return list
; ; EndFunction

; ; String Function BindingsBlindfoldsList() Global
; ;     string list = "ZAP Blindfold 5"
; ;     return list
; ; EndFunction

; ; string Function DefaultBindingsWrist() Global
; ;     return "ZAP WRI Ropes"
; ; EndFunction

; ; string Function DefaultBindingsElbow() Global
; ;     return "ZAP ELB Ropes 1"
; ; EndFunction

; ; string Function DefaultBindingsBody() Global
; ;     return "ZAP BOD Shibari"
; ; EndFunction

; ; string Function DefaultBindingsGag() Global
; ;     return "ZAP GAG Bit"
; ; EndFunction

; ; String Function DefaultBindingsCorset() Global
; ;     return ""
; ; EndFunction

; ; String Function DefaultBindingsBoots() Global
; ;     return "ZAP Shackles"
; ; EndFunction

; ; String Function DefaultBindingsAnkles() Global
; ;     return "ZAP ANK Ropes"
; ; EndFunction

; ; String Function DefaultBindingsCollar() Global
; ;     return "ZAP COL Simple Black"
; ; EndFunction

; ; string function DefaultBindingsChastity() Global
; ;     return "ZAP CHA Padded"
; ; EndFunction

; ; string Function DefaultBindingsPiercing() Global
; ;     return "ZAP CLA Nipple Screw"
; ; EndFunction

; ; string Function DefaultBindingsClamps() Global
; ;     return "ZAP CLA Nipple Screw"
; ; EndFunction

; ; string Function DefaultBindingsShackles() Global
; ;     return "ZAP Shackles"
; ; EndFunction

; ; String Function DefaultBindingsHood() Global
; ;     return "ZAP Hood"
; ; EndFunction

; ; String Function DefaultBindingsBlindfold() Global
; ;     return "ZAP Blindfold 5"
; ; EndFunction

; ; Armor Function GetBindingItem(string itemName) Global
; ;     string assetsFile = "ZaZAnimationPack.esm"

; ;     ;wrists
; ;     If itemName == "ZAP WRI Handcuffs Black"
; ;         return Game.GetFormFromFile(0x02081D25, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP WRI Handcuffs Copper"
; ;         return Game.GetFormFromFile(0x02081D31, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP WRI Handcuffs Gold"
; ;         return Game.GetFormFromFile(0x02081D32, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP WRI Handcuffs Shiny"
; ;         return Game.GetFormFromFile(0x02081D30, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP WRI Ropes" ;zbfWristRope02parallel
; ;         return Game.GetFormFromFile(0x0202BC32, assetsFile) as Armor

; ;     ;elbows
; ;     ElseIf itemName == "ZAP ELB Ropes 1"
; ;         return Game.GetFormFromFile(0x0202C6FB, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP ELB Ropes 2"
; ;         return Game.GetFormFromFile(0x0202DC89, assetsFile) as Armor

; ;     ;ankles
; ;     ElseIf itemName == "ZAP Shackles" ;zbfAnkleIronHDT
; ;         return Game.GetFormFromFile(0x02004009, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP ANK Ropes" ;zbfAnkleRope02
; ;         return Game.GetFormFromFile(0x02004003, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP ANK Simple Black" ;zbfAnkleSimpleBlack
; ;         return Game.GetFormFromFile(0x02004007, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP ANK Simple Copper" ;zbfAnkleSimpleCopper
; ;         return Game.GetFormFromFile(0x0202431F, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP ANK Simple Gold" ;zbfAnkleSimpleGold
; ;         return Game.GetFormFromFile(0x0200400D, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP ANK Simple Shiny" ;zbfAnkleSimpleShiny
; ;         return Game.GetFormFromFile(0x0200400C, assetsFile) as Armor

; ;     ;body
; ;     ElseIf itemName == "ZAP BOD Breast Rope Extreme" ;zbfBreastRopeExtreme02
; ;         return Game.GetFormFromFile(0x020795DD, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP BOD Breast Waist Extreme" ;zbfBreastRopeWithWaistRopeExtreme02
; ;         return Game.GetFormFromFile(0x0207A0A3, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP BOD Chastity Bra" ;zbfBraChastity01
; ;         return Game.GetFormFromFile(0x0200700E, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP BOD Shibari" ;zbfBodyBondageShibari
; ;         return Game.GetFormFromFile(0x02035338, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP BOD Waist and Breast" ;zbfWaistAndBreastRope02
; ;         return Game.GetFormFromFile(0x02073F7A, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP BOD Waist Rope" ;zbfWaistRope02
; ;         return Game.GetFormFromFile(0x02031D38, assetsFile) as Armor

        

; ;     ;collars
; ;     ElseIf itemName == "ZAP COL Rope" ;zbfCollarRope02
; ;         return Game.GetFormFromFile(0x02005012, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP COL Simple Black" ;zbfCollarSimpleBlack
; ;         return Game.GetFormFromFile(0x02003004, assetsFile) as Armor     
; ;     ElseIf itemName == "ZAP COL Simple Copper" ;zbfCollarSimpleCopper
; ;         return Game.GetFormFromFile(0x02024323, assetsFile) as Armor    
; ;     ElseIf itemName == "ZAP COL Simple Gold" ;zbfCollarSimpleGold
; ;         return Game.GetFormFromFile(0x02022765, assetsFile) as Armor    
; ;     ElseIf itemName == "ZAP COL Simple Shiny" ;zbfCollarSimpleShiny
; ;         return Game.GetFormFromFile(0x02023853, assetsFile) as Armor    
; ;     ElseIf itemName == "ZAP COL Leather Rings" ;zbfCollarLeather01
; ;         return Game.GetFormFromFile(0x02007010, assetsFile) as Armor    
; ;     ElseIf itemName == "ZAP COL Leather Belt" ;zbfCollarLeatherBinds
; ;         return Game.GetFormFromFile(0x0200500B, assetsFile) as Armor    
; ;     ElseIf itemName == "ZAP COL Padded" ;zbfCollarPadded01
; ;         return Game.GetFormFromFile(0x02007011, assetsFile) as Armor  
; ;     ElseIf itemName == "ZAP COL Posture Leather" ;zbfCollarPosture01
; ;         return Game.GetFormFromFile(0x02007012, assetsFile) as Armor  
; ;     ElseIf itemName == "ZAP COL Posture Padded" ;zbfCollarPosture02
; ;         return Game.GetFormFromFile(0x02007013, assetsFile) as Armor  
; ;     ElseIf itemName == "ZAP COL Iron Black" ;zbfCollarIronBlack
; ;         return Game.GetFormFromFile(0x0200500C, assetsFile) as Armor  
; ;     ElseIf itemName == "ZAP COL Harness" ;zbfCollarHarness01
; ;         return Game.GetFormFromFile(0x0200700F, assetsFile) as Armor  

; ;     ;chastity
; ;     ElseIf itemName == "ZAP CHA Iron" ;zbfBeltChastity03
; ;         return Game.GetFormFromFile(0x0200700B, assetsFile) as Armor  
; ;     ElseIf itemName == "ZAP CHA Padded" ;zbfBeltChastity04
; ;         return Game.GetFormFromFile(0x0200700C, assetsFile) as Armor  
; ;     ElseIf itemName == "ZAP CHA Padded Ass Open" ;zbfBeltChastity05
; ;         return Game.GetFormFromFile(0x0200700D, assetsFile) as Armor  
; ;     ElseIf itemName == "ZAP CHA Iron With Plugs" ;zbfBeltChastity02Plug
; ;         return Game.GetFormFromFile(0x0200500A, assetsFile) as Armor  

; ;     ;piercings/clamps
; ;     ElseIf itemName == "ZAP Nipple Screw" ;zbfNippleScrews01
; ;         return Game.GetFormFromFile(0x020817BC, assetsFile) as Armor        

; ;     ;hood
; ;     ElseIf itemName == "ZAP Hood" ;zbfHoodDark
; ;         return Game.GetFormFromFile(0x02005006, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP Hood Light" ;zbfHoodLight
; ;         return Game.GetFormFromFile(0x02005007, assetsFile) as Armor
; ;     ElseIf itemName == "ZAP Hood Canvas" ;zbfBlindHood
; ;         return Game.GetFormFromFile(0x02005002, assetsFile) as Armor

; ;     ;blindfolds
; ;     ElseIf itemName == "ZAP Blindfold 5" ;zbfBlindEyeMask05
; ;         return Game.GetFormFromFile(0x0200700A, assetsFile) as Armor

; ;     ;gags
; ;     ElseIf itemName == "ZAP GAG Ball" ;zbfGagBall02
; ;         return Game.GetFormFromFile(0x02007007, assetsFile) as Armor 
; ;     ElseIf itemName == "ZAP GAG Harness Ball" ;zbfGagHarnessBall01
; ;         return Game.GetFormFromFile(0x02007003, assetsFile) as Armor 
; ;     ElseIf itemName == "ZAP GAG Harness Panel" ;zbfGagHarnessPanel01
; ;         return Game.GetFormFromFile(0x02007004, assetsFile) as Armor 
; ;     ElseIf itemName == "ZAP GAG Harness Panel Open" ;zbfGagHarnessPanel02 - don't add to the list (use for plug/unplug)
; ;         return Game.GetFormFromFile(0x02007005, assetsFile) as Armor 
; ;     ElseIf itemName == "ZAP GAG Harness Ring" ;zbfGagHarnessRing01
; ;         return Game.GetFormFromFile(0x02007006, assetsFile) as Armor 
; ;     ElseIf itemName == "ZAP GAG Panel" ;zbfGagLeatherPanel
; ;         return Game.GetFormFromFile(0x02002005, assetsFile) as Armor 
; ;     ElseIf itemName == "ZAP GAG Muzzle" ;zbfGagMuzzle02
; ;         return Game.GetFormFromFile(0x02002013, assetsFile) as Armor 
; ;     ElseIf itemName == "ZAP GAG Ring" ;zbfGagRing02
; ;         return Game.GetFormFromFile(0x02007008, assetsFile) as Armor 
; ;     ElseIf itemName == "ZAP GAG Bit" ;zbfGagWoodBit
; ;         return Game.GetFormFromFile(0x02002002, assetsFile) as Armor 

        

; ;     Else
; ;         return none
; ;     EndIf
; ; EndFunction

; string Function GetStandingIdle(Armor handBindings) Global
;     zbfBondageShell zbfs = zbfBondageShell.GetApi()
;     string handIdle = zbfs.GetArmAnimFromKeywords(handBindings)
;     ;Debug.MessageBox("idle" + handIdle)
;     return handIdle
; EndFunction

; bool Function AddBinding(Actor a, Armor item) Global
;     zbfUtil.WearItem(a, item, true)
;     If item.HasKeyWord(Keyword.GetKeyword("zbfWornGag"))
;         zbfBondageShell zbfs = zbfBondageShell.GetApi()
;         zbfs.SetGaggedPerk(a, true)
;     EndIf
;     return true
; EndFunction

; bool Function RemoveBinding(Actor a, Armor item) Global
;     zbfUtil.UnwearItem(a, item, true)
;     If item.HasKeyWord(Keyword.GetKeyword("zbfWornGag"))
;         zbfBondageShell zbfs = zbfBondageShell.GetApi()
;         zbfs.SetGaggedPerk(a, false)
;     EndIf
;     return true
; EndFunction

; bool Function WhipActor(Actor target, Actor source, string msg = "") Global
;     If msg != ""
;         Debug.Notification(msg)
;     EndIf
;     zbfSlaveActions slaveActions = zbfSlaveActions.GetApi()
;     slaveActions.WhipPlayer(source, msg, 20.0, 50.0, "")
; EndFunction

; string Function FurnitureList() Global
;     string list = "ZAP Bar Stool,ZAP Barrel,ZAP Bed,ZAP Bitch Lesson,ZAP Bound On Knees,ZAP Buried In Groud,ZAP Chair Bondage,ZAP Chair Bondage 2,ZAP Chair Bondage Reverse,"
;     list = list + "ZAP Cross Roped 1, ZAP Cross Roped 2,ZAP Crux,ZAP Crux Outdoor,ZAP EM Pole Hanging,ZAP EM Pole Kneeling,ZAP EM Pole Standing,ZAP Fairytail Glass Coffin,"
;     list = list + "ZAP Fucking Machine,ZAP Garotte,ZAP Gibbet Body Pole,ZAP Hogtied Place,ZAP Kennel Bondage,ZAP Milking Machine,ZAP On Ground Roped,ZAP Pillory,"
;     list = list + "ZAP Pole Bondage 1,ZAP Pole Bondage 2,ZAP Pole Bondage 3,ZAP Pole Bondage 4,ZAP Pole Bondage 5,ZAP Pole Bondage 6,ZAP Pole On Knees,ZAP Pole Sit Struggle,"
;     list = list + "ZAP Pole Stand Struggle,ZAP Rack,ZAP Rack Reverse,ZAP Restraint Pole 1,ZAP Restraint Pole 2,ZAP Restraint Pole 3,ZAP Restraint Pole 4,ZAP Restraint Pole 5,"
;     list = list + "ZAP Restraint Pole 6,ZAP Sacrificial Pillars,ZAP Shackles Wall,ZAP Spread Eagle Poles,ZAP Table,ZAP Table Outdoor,ZAP Tied Bedroll Right,ZAP Tied Bedroll Left,"
;     list = list + "ZAP Tied On Pillows,ZAP Torture Pole,ZAP Tree Reverse,ZAP Tree,ZAP Trees Wedged,ZAP Tree Wedged,ZAP Tree Y Struggle,ZAP Tree Y Struggle R,"
;     list = list + "ZAP Under Gallow Arms Up,ZAP Under Gallow Strappado,ZAP Water Wheel Mini,ZAP Wooden Horse,ZAP Wooden Horse 2,ZAP X Cross Heavy,ZAP X Cross Heavy Reverse,"
;     list = list + "ZAP X Cross Outdoor,ZAP Tied in Frame,ZAP Restraint Post,ZAP Pyre"
;     return list
; EndFunction

; Furniture Function GetFurnitureItem(string itemName) Global

;     ;Debug.MessageBox(itemName)

;     string assetsFile = "ZaZAnimationPack.esm"
;     If ItemName == "ZAP Bar Stool"
;         return Game.GetFormFromFile(0x02059AE2, assetsFile) as Furniture ;zbfBarStool
;     ElseIf itemName == "ZAP Barrel"
;         return Game.GetFormFromFile(0x02059B50, assetsFile) as Furniture ;zbfLyingBarrel
;     ElseIf itemName == "ZAP Bed"
;         return Game.GetFormFromFile(0x02045C32, assetsFile) as Furniture ;zbfBedOfBondageDungeon
;     ElseIf itemName == "ZAP Bitch Lesson"
;         return Game.GetFormFromFile(0x02059B69, assetsFile) as Furniture ;zbfBitchLesson01 (CAMP)
;     ElseIf itemName == "ZAP Bound On Knees"
;         return Game.GetFormFromFile(0x02063A4F, assetsFile) as Furniture ;zbfCaptiveBoundOnKneesMarker
;     ElseIf itemName == "ZAP Buried In Groud"
;         return Game.GetFormFromFile(0x0208076C, assetsFile) as Furniture ;zbfBuriedIntoTheGroundWithShovelsAround (CAMP)
;     ElseIf itemName == "ZAP Chair Bondage"
;         return Game.GetFormFromFile(0x02048881, assetsFile) as Furniture ;zbfChairBondage01
;     ElseIf itemName == "ZAP Chair Bondage 2"
;         return Game.GetFormFromFile(0x02059ADC, assetsFile) as Furniture ;zbfChairSitTied
;     ElseIf itemName == "ZAP Chair Bondage Reverse"
;         return Game.GetFormFromFile(0x02048882, assetsFile) as Furniture ;zbfChairBondageReverse01
;     ElseIf itemName == "ZAP Cross Roped 1"
;         return Game.GetFormFromFile(0x02026D33, assetsFile) as Furniture ;zbfCrossRopedPose01
;     ElseIf itemName == "ZAP Cross Roped 2"
;         return Game.GetFormFromFile(0x02026D34, assetsFile) as Furniture ;zbfCrossRopedPose02
;     ElseIf itemName == "ZAP Crux"
;         return Game.GetFormFromFile(0x0203BC6D, assetsFile) as Furniture ;zbfCrux
;     ElseIf itemName == "ZAP Crux Outdoor"
;         return Game.GetFormFromFile(0x0203BC6E, assetsFile) as Furniture ;zbfCruxOutdoor (CAMP)
;     ElseIf itemName == "ZAP EM Pole Hanging"
;         return Game.GetFormFromFile(0x0208B4FB, assetsFile) as Furniture ;zbfEMPoleHanging
;     ElseIf itemName == "ZAP EM Pole Kneeling"
;         return Game.GetFormFromFile(0x0208B4FC, assetsFile) as Furniture ;zbfEMPoleKneeling
;     ElseIf itemName == "ZAP EM Pole Standing"
;         return Game.GetFormFromFile(0x0208B4FA, assetsFile) as Furniture ;zbfEMPoleStanding
;     ElseIf itemName == "ZAP Fairytail Glass Coffin"
;         return Game.GetFormFromFile(0x020553A1, assetsFile) as Furniture ;zbfFairytailGlassCoffin
;     ElseIf itemName == "ZAP Fucking Machine"
;         return Game.GetFormFromFile(0x0203C792, assetsFile) as Furniture ;zbfFuckMachineSitting
;     ElseIf itemName == "ZAP Garotte"
;         return Game.GetFormFromFile(0x0204CA31, assetsFile) as Furniture ;zbfGarotteStatic
;     ElseIf itemName == "ZAP Gibbet Body Pole"
;         return Game.GetFormFromFile(0x0204EAC7, assetsFile) as Furniture ;zbfBodyGibbetWithPole
;     ElseIf itemName == "ZAP Hogtied Place"
;         return Game.GetFormFromFile(0x0204559C, assetsFile) as Furniture ;zbfHogtiePlace01 (CAMP)
;     ElseIf itemName == "ZAP Kennel Bondage"
;         return Game.GetFormFromFile(0x0207D6AC, assetsFile) as Furniture ;zbfKennelBondage
;     ElseIf itemName == "ZAP Milking Machine"
;         return Game.GetFormFromFile(0x02026D2E, assetsFile) as Furniture ;zbfMilkOMatic1
;     ElseIf itemName == "ZAP On Ground Roped"
;         return Game.GetFormFromFile(0x0207D6AC, assetsFile) as Furniture ;zbfBitchOnTheGroundStruggling_Rope   
;     ElseIf itemName == "ZAP Pillory"
;         return Game.GetFormFromFile(0x0200FDE1, assetsFile) as Furniture ;zbfPillory01
;     ElseIf itemName == "ZAP Pole Bondage 1"
;         return Game.GetFormFromFile(0x02045624, assetsFile) as Furniture ;zbfPoleBondage01  
;     ElseIf itemName == "ZAP Pole Bondage 2"
;         return Game.GetFormFromFile(0x02045625, assetsFile) as Furniture ;zbfPoleBondage02  
;     ElseIf itemName == "ZAP Pole Bondage 3"
;         return Game.GetFormFromFile(0x02045626, assetsFile) as Furniture ;zbfPoleBondage03  
;     ElseIf itemName == "ZAP Pole Bondage 4"
;         return Game.GetFormFromFile(0x02045627, assetsFile) as Furniture ;zbfPoleBondage04  
;     ElseIf itemName == "ZAP Pole Bondage 5"
;         return Game.GetFormFromFile(0x02045628, assetsFile) as Furniture ;zbfPoleBondage05  
;     ElseIf itemName == "ZAP Pole Bondage 6"
;         return Game.GetFormFromFile(0x02045629, assetsFile) as Furniture ;zbfPoleBondage06  
;     ElseIf itemName == "ZAP Pole On Knees"
;         return Game.GetFormFromFile(0x02078046, assetsFile) as Furniture ;zbfCaptiveBoundKneeling_StdWood  
;     ElseIf itemName == "ZAP Pole Sit Struggle"
;         return Game.GetFormFromFile(0x02044ABA, assetsFile) as Furniture ;zbfBondagePoleSittingStruggling   
;     ElseIf itemName == "ZAP Pole Stand Struggle"
;         return Game.GetFormFromFile(0x02044AB2, assetsFile) as Furniture ;zbfBondagePoleStandingStruggling   
;     ElseIf itemName == "ZAP Rack"
;         return Game.GetFormFromFile(0x0200E2BF, assetsFile) as Furniture ;zbfRack01   
;     ElseIf itemName == "ZAP Rack Reverse"
;         return Game.GetFormFromFile(0x0206451E, assetsFile) as Furniture ;zbfRack02BackFace   
;     ElseIf itemName == "ZAP Restraint Pole 1"
;         return Game.GetFormFromFile(0x0203B117, assetsFile) as Furniture ;zbfRestraintPoleShackles01   
;     ElseIf itemName == "ZAP Restraint Pole 2"
;         return Game.GetFormFromFile(0x0203B118, assetsFile) as Furniture ;zbfRestraintPoleShackles02   
;     ElseIf itemName == "ZAP Restraint Pole 3"
;         return Game.GetFormFromFile(0x0203B119, assetsFile) as Furniture ;zbfRestraintPoleShackles03   
;     ElseIf itemName == "ZAP Restraint Pole 4"
;         return Game.GetFormFromFile(0x0203B11A, assetsFile) as Furniture ;zbfRestraintPoleShackles04   
;     ElseIf itemName == "ZAP Restraint Pole 5"
;         return Game.GetFormFromFile(0x0203B11B, assetsFile) as Furniture ;zbfRestraintPoleShackles05   
;     ElseIf itemName == "ZAP Restraint Pole 6"
;         return Game.GetFormFromFile(0x0203B11C, assetsFile) as Furniture ;zbfRestraintPoleShackles06   
;     ElseIf itemName == "ZAP Sacrificial Pillars"
;         return Game.GetFormFromFile(0x02059B48, assetsFile) as Furniture ;zbfSacrificialPillars
;     ElseIf itemName == "ZAP Shackles Wall"
;         return Game.GetFormFromFile(0x0203B6DB, assetsFile) as Furniture ;zbfImpShackleWallVanilla
;     ElseIf itemName == "ZAP Spread Eagle Poles" 
;         return Game.GetFormFromFile(0x0207F1B8, assetsFile) as Furniture ;zbfOutdoorHorizontallyPoled_FarmWoodBrown (CAMP)      
;     ElseIf itemName == "ZAP Table"
;         return Game.GetFormFromFile(0x020488AF, assetsFile) as Furniture ;zbfMTableBondage
;     ElseIf itemName == "ZAP Table Outdoor"
;         return Game.GetFormFromFile(0x0203F2E0, assetsFile) as Furniture ;zbfOutdoorBondageTable (CAMP)
;     ElseIf itemName == "ZAP Tied Bedroll Left"
;         return Game.GetFormFromFile(0x02062A0C, assetsFile) as Furniture ;zbfSleepingLeftSideBedRollMulti (CAMP)
;     ElseIf itemName == "ZAP Tied Bedroll Right"
;         return Game.GetFormFromFile(0x02062A0D, assetsFile) as Furniture ;zbfSleepingRightSideBedRollMulti
;     ElseIf itemName == "ZAP Tied On Pillows"
;         return Game.GetFormFromFile(0x0208C539, assetsFile) as Furniture ;zbfLayingTiedOnPillowsBackFace
;     ElseIf itemName == "ZAP Torture Pole"
;         return Game.GetFormFromFile(0x02037EB4, assetsFile) as Furniture ;zbfTorturePole01
;     ElseIf itemName == "ZAP Tree Reverse"
;         return Game.GetFormFromFile(0x02049E75, assetsFile) as Furniture ;zbfTreeBondageAspenTreeBackFaceGreen
;     ElseIf itemName == "ZAP Tree"
;         return Game.GetFormFromFile(0x02049E77, assetsFile) as Furniture ;zbfTreeBondageAspenTreeFrontFaceGreen
;     ElseIf itemName == "ZAP Trees Wedged"
;         return Game.GetFormFromFile(0x02049E79, assetsFile) as Furniture ;zbfTreeBondageAspenTreesWedgedGreen
;     ElseIf itemName == "ZAP Tree Wedged"
;         return Game.GetFormFromFile(0x02049E7D, assetsFile) as Furniture ;zbfTreeBondageAspenTreeWithoutRopeGreen
;     ElseIf itemName == "ZAP Tree Y Struggle"
;         return Game.GetFormFromFile(0x020863C2, assetsFile) as Furniture ;zbfTreeBondageAspenTreeYBondageStrugglingFBGreen
;     ElseIf itemName == "ZAP Tree Y Struggle R"
;         return Game.GetFormFromFile(0x0208692E, assetsFile) as Furniture ;zbfTreeBondageAspenTreeYBondageStrugglingFFGreen
;     ElseIf itemName == "ZAP Under Gallow Arms Up"
;         return Game.GetFormFromFile(0x020455D5, assetsFile) as Furniture ;zbfChainedUnderTheGallow01  
;     ElseIf itemName == "ZAP Under Gallow Strappado"
;         return Game.GetFormFromFile(0x020455D9, assetsFile) as Furniture ;zbfChainedUnderTheGallow05      
;     ElseIf itemName == "ZAP Water Wheel Mini"
;         return Game.GetFormFromFile(0x02056955, assetsFile) as Furniture ;zbfWaterWheelMini  
;     ElseIf itemName == "ZAP Wooden Horse"
;         return Game.GetFormFromFile(0x0200DD49, assetsFile) as Furniture ;zbfWoodenHorse  
;     ElseIf itemName == "ZAP Wooden Horse 2"
;         return Game.GetFormFromFile(0x0205ABE7, assetsFile) as Furniture ;zbfWcnWoodenHorse    
;     ElseIf itemName == "ZAP X Cross Heavy"
;         return Game.GetFormFromFile(0x020419F8, assetsFile) as Furniture ;zbfXCrossHeavyFBquiet  
;     ElseIf itemName == "ZAP X Cross Heavy Reverse"
;         return Game.GetFormFromFile(0x020419E8, assetsFile) as Furniture ;zbfXCrossHeavyFFquiet  
;     ElseIf itemName == "ZAP X Cross Outdoor"
;         return Game.GetFormFromFile(0x020500AF, assetsFile) as Furniture ;zbfXCrossOutdoor_FarmWood (CAMP)  
;     ElseIf itemName == "ZAP Wheel Short Tilt"
;         return Game.GetFormFromFile(0x02045BCC, assetsFile) as Furniture ;zbfMWheelShortTilt03 (CAMP)  
;     ElseIf itemName == "ZAP Tied in Frame"
;         return Game.GetFormFromFile(0x0205EDD0, assetsFile) as Furniture ;zbfStruggleRopeWithPolesFarmWoodBrown 
;     ElseIf itemName == "ZAP Restraint Post"
;         return Game.GetFormFromFile(0x02026D38, assetsFile) as Furniture ;zbfMultipleRestraintPostPole 
;     ElseIf itemName == "ZAP Pyre"
;         return Game.GetFormFromFile(0x0205D272, assetsFile) as Furniture ;zbfPyre (CAMP) 
        
        

;     Else
;         return none
;     EndIf

; EndFunction

; Function LockInFurniture(ObjectReference item, Actor act) Global
; 	;zbfBondageShell bondageShell = GetZbfBondageShell()
;     zbfSlot playerSlot = zbfBondageShell.GetApi().FindPlayer()
;     playerSlot.SetFurniture(item) 
; 	; playerSlot = zbfBondageShell.GetApi().FindPlayer()
; EndFunction

; Function UnlockFromFurniture() Global
;     zbfSlot playerSlot = zbfBondageShell.GetApi().FindPlayer()
;     playerSlot.SetFurniture(none) 
; EndFunction
