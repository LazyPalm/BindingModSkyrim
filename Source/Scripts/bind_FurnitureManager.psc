Scriptname bind_FurnitureManager extends Quest  

string keywordDM3Furniture = "dse_dm_keywordFurniture"

Keyword kwDM3
Keyword kwZap
Keyword kwDDC

int formTypeFuniture = 40
int formTypeMisc = 32
int formTypeActivator = 24

int selectedFurnitureIdx = 0
string selectedFurniture
bool furnitureSelected

int foundFurnitureResult
bool isCleaning
int dm3Slot = 0

bool ddcEventRegistered

string zapFurnitureJson = "bind_zap_furniture.json"

Function LoadGame()

	; bondageShell = zbfBondageShell.GetApi()
	; playerSlot = zbfBondageShell.GetApi().FindPlayer()

EndFunction

event DdcDeviceEvent(Form a, Form furnitureItem, bool lockStatus)

    Actor act = a as Actor

    if lockStatus
        if !act.IsInFaction(bind_LockedInFurnitureFaction)
            act.AddToFaction(bind_LockedInFurnitureFaction)
        endif
    else
        if act.IsInFaction(bind_LockedInFurnitureFaction)
            act.RemoveFromFaction(bind_LockedInFurnitureFaction)
        endif
    endif

endevent

string Function FurnitureList()
    ; string list = "Bar Stool, Dungeon Bed, Bitch Lesson, On Ground Struggle Rope, On Rug Struggle Rope, Body Gibbet On Pole, Pole Sitting Struggle, Pole Standing Struggle, Buried, Bound Kneeling,"
    ; list = list + "Chained Under Gallow 1, Chained Under Gallow 2, Chained Under Gallow 3, Chained Under Gallow 4, Chained Under Gallow 5, Chair Bondage 1, Chair Bondage Reverse 1,"
    ; list = list + "Chair Bondage Reverse 2, Chair Bondage Reverse 3, Chair Bondage Reverse 4, Chair Bondage Reverse 5, Chair Bondage Reverse 6, Chair Sit Tied, Cross Rope 1, Cross Rope 2, Cross Rope 3,"
    ; list = list + "Crux, EM Pole Hanging, EM Pole Kneeling, EM Pole Standing, Garotte Dynamic, Garotte Static, Gibbet L Post A, Gibbet L Post B, Gibbet S Post A, Gibbet S Post B, Gibbet Slim,"
    ; list = list + "Hogtie Place 1, Hogtie Place 2, Hogtie Place 3, Hogtie Place 4, Horizontal Pole Outdoor, Imp. Shackle Rigid, Imp. Shackle Strict, Imp. Shackle, Kennel, Tied On Pillows,"
    ; list = list + "Table, Outdoor Table, Pillory, Pole Bondage 1, Pole Bondage 2, Pole Bondage 3, Pole Bondage 4, Pole Bondage 5, Pole Bondage 6, Rack, Rack Back, Rack Dynamic, Pillars, Sleeping On Roll,"
    ; list = list + "Torture Pole 1, Torture Pole 2, Torture Pole 3, Torture Pole 4, Torture Pole 5, Tree Aspen Back, Tree Aspen Front, Tree Aspen Wedged, Tree Aspen Hanging, Tree Spruce,"
    ; list = list + "Tree Spruce Laying, Water Wheel, WCN Wooden Horse, Whipping Pole Back, Whipping Pole Front, Sex Machine, Strappado, Wooden Horse, X Cross, X Cross Heavy Back, X Cross Heavy Front,"
    ; list = list + "DD Bondage Chair, DD Bondage Pole, DD Cross, DD Gallows Overhead, DD Gallows Strappado, DD Gallows Hogtie, DD Gallows Upside Down, DD Gallows Horse, DD Pillory, DD Pillory 2,"
    ; list = list + "DD Post, DD Shackle Wall, DD Torture Pole 1, DD Torture Pole 2, DD Torture Pole 3, DD Torture Pole 4, DD Torture Pole 5, DD Horse, DD X Cross"
    string list = ""
    ;If mqs.SoftCheckDD == 1 ;&& mqs.EnableModDD == 1
        list = list + bind_DDHelper.FurnitureList()
    ;EndIf
    ; If mqs.SoftCheckZAP == 1 ;&& mqs.EnableModZAP == 1
    ;     If list != ""
    ;         list = list + ","
    ;     EndIf
    ;     list = list + bind_ZapHelper.FurnitureList()
    ; EndIf
    If mqs.SoftCheckDM3 == 1 && mqs.EnableModDM3 == 1
        If list != ""
            list = list + ","
        EndIf
        list = list + bind_DM3Helper.FurnitureList()
     EndIf
    return list
EndFunction

string Function GetSelectedFurniture()
    return selectedFurniture
EndFunction

Function SetSelectedFuniture(string itemName)
    selectedFurniture = itemName
    ;Debug.MessageBox(idx)
EndFunction

function AddFurnitureByForm(Actor a, Form dev)

    float z = a.GetAngleZ()
    bool add = false

    bind_Utility.WriteToConsole("Adding: " + selectedFurniture)

    If dev.HasKeywordString("zadc_FurnitureDevice") || dev.HasKeywordString("zbfFurniture")
        add = true
    EndIf

    if dev.HasKeywordString("dse_dm_KeywordFurniture")
        If mqs.SoftCheckDM3 == 1 && mqs.EnableModDM3 == 1
            add = true
        EndIf
    endif

    if add
        PO3_SKSEFunctions.AddKeywordToForm(dev, bind_FurnitureItem)
        ObjectReference obj = a.PlaceAtMe(dev, 1, true, true)
        obj.MoveTo(a, 120.0 * Math.Sin(a.GetAngleZ()), 120.0 * Math.Cos(a.GetAngleZ()), 0)
        obj.SetAngle(0.0, 0.0, z)
        obj.Enable()
        obj.SetActorOwner(a.GetActorBase())
    endif

endfunction

Function AddFurniture(Actor a)

    If selectedFurniture == ""
        Debug.MessageBox("No furniture type selected in MCM")
        return
    EndIf

	float newZ = a.GetAngleZ()

    bind_Utility.WriteToConsole("Adding: " + selectedFurniture)

    If mqs.SoftCheckDD == 1 && (StringUtil.Substring(selectedFurniture, 0, 2) != "ZA" && StringUtil.Substring(selectedFurniture, 0, 2) != "DM")
        Form dev = bind_DDHelper.GetFurnitureItem(selectedFurniture)
        PO3_SKSEFunctions.AddKeywordToForm(dev, bind_FurnitureItem)
        ObjectReference obj = a.PlaceAtMe(dev, 1, true, true)
        obj.SetAngle(0.0, 0.0, newZ)
        obj.Enable()
        obj.SetActorOwner(a.GetActorBase())
        ;Utility.Wait(1.0)
        ;FurnitureEditRef.ForceRefTo(obj)
        ;furnitureSelected = true
    EndIf

    ; If mqs.SoftCheckZAP == 1 && StringUtil.Substring(selectedFurniture, 0, 2) == "ZA"
    ;     ObjectReference obj = a.PlaceAtMe(bind_ZapHelper.GetFurnitureItem(selectedFurniture), 1, true, true)
    ;     obj.SetAngle(0.0, 0.0, newZ)
    ;     obj.Enable()
    ;     ;Utility.Wait(1.0)
    ;     obj.SetActorOwner(a.GetActorBase())
    ;     ;FurnitureEditRef.ForceRefTo(obj)
    ;     ;furnitureSelected = true
    ; EndIf

    If mqs.SoftCheckDM3 == 1 && mqs.EnableModDM3 == 1 && StringUtil.Substring(selectedFurniture, 0, 2) == "DM"
        Form dev = bind_DM3Helper.GetFurnitureItem(selectedFurniture)
        PO3_SKSEFunctions.AddKeywordToForm(dev, bind_FurnitureItem)
        ObjectReference obj = a.PlaceAtMe(dev, 1, true, true)
        obj.SetAngle(0.0, 0.0, newZ)
        obj.Enable()
        obj.SetActorOwner(a.GetActorBase())
    EndIf

	; ObjectReference obj = a.PlaceAtMe(zhelp.GetFurniture(selectedFurnitureIdx), 1, true, true)
	; obj.SetAngle(0.0, 0.0, newZ)
	; obj.Enable()
    ; obj.SetActorOwner(a.GetActorBase())

EndFunction

bool Function SelectFurniture(Actor a)

    bool found
    found = false

    ObjectReference foundFurn = ScanForFurniture(a)
    If foundFurn
        FurnitureEditRef.ForceRefTo(foundFurn)
        furnitureSelected = true
        found = true
    Else
        Debug.MessageBox("No furniture found")
    EndIf


    ; ObjectReference ddcFound = Game.FindClosestReferenceOfAnyTypeInListFromRef(bind_DdcItems, a, 2000.0)
    ; If ddcFound
    ;     ; FurnitureEditRef.ForceRefTo(ddcFound)
    ;     ; furnitureSelected = true
    ;     ; found = true
    ; Else

    ; EndIf

	; ObjectReference zbfFound = Game.FindClosestReferenceOfAnyTypeInListFromRef(zbfListFurnitures, a, 2000.0)
	; If zbfFound
    ;     bool useThis
    ;     useThis = false
    ;     If ddcFound
    ;         If ddcFound.GetDistance(a) > zbfFound.GetDistance(a)
    ;             useThis = true
    ;         Else
    ;             FurnitureEditRef.ForceRefTo(ddcFound)
    ;             furnitureSelected = true
    ;             found = true
    ;         EndIf
    ;     Else
    ;         useThis = true
    ;     EndIf
    ;     If useThis
    ;         FurnitureEditRef.ForceRefTo(zbfFound)
    ;         furnitureSelected = true
    ;         found = true
    ;     EndIf
	; ElseIf ddcFound
    ;     FurnitureEditRef.ForceRefTo(ddcFound)
    ;     furnitureSelected = true
    ;     found = true
    ; Else

	; EndIf

    return found

EndFunction

bool Function HasSelectedFurniture()
    return furnitureSelected
EndFUnction

Function DeleteFurniture()

	ObjectReference furn
	furn = FurnitureEditRef.GetReference()
    FurnitureEditRef.Clear()

    Utility.Wait(1.0)

    If furn == none
        Debug.MessageBox("No furniture to delete")
        return
    EndIf

    ;If furn.HasKeyWord(zadc_FurnitureDevice)
    ; main.WindowOutput("Disabling furniture item. Please wait.")
    ; furn.Disable()

    ; Utility.Wait(1.0)
    
	; bool disableFurniture = false
    ; bool deleteFailed = false

	; int idx = 0
	; While !disableFurniture
	; 	idx = idx + 1
	; 	If idx > 20
	; 		;NOTE - this is taking too long, hit the eject button!
    ;         deleteFailed = true
    ;         disableFurniture = true
    ;     EndIf
    ;     If furn.IsDisabled()
    ;         disableFurniture = true
    ;     EndIf
	; 	Utility.Wait(1.0)
	; EndWhile

    ; if deleteFailed
    ;     Debug.MessageBox("Delete failed.")
    ;     return
    ; EndIf

    ; Utility.Wait(5.0)
    ;EndIf

    ;mqs.WindowOutput("Deleting furniture item.")
	furn.Delete()
	Utility.Wait(1.0)
    furnitureSelected = false

EndFunction

Function MoveFurniture(Actor a)

	float newX = a.GetAngleX()
	float newY = a.GetAngleY()
	float newZ = a.GetAngleZ()

	; FurnitureEditRef.GetReference().MoveTo(a)
	; FurnitureEditRef.GetReference().SetAngle(0.0, 0.0, newZ)


    float z = a.GetAngleZ()
    ObjectReference obj = FurnitureEditRef.GetReference()
    obj.MoveTo(a, 120.0 * Math.Sin(a.GetAngleZ()), 120.0 * Math.Cos(a.GetAngleZ()), 0)
    obj.SetAngle(0.0, 0.0, z + 180)

EndFunction

Function SetFurnitureAngle(float x, float y, float z)

    ObjectReference furn
    furn = FurnitureEditRef.GetReference()

    float currentX = furn.GetAngleX()
    float currentY = furn.GetAngleY()
    float currentZ = furn.GetAngleZ()

	If x != 0.0
		furn.SetAngle(currentX + x, currentY, currentZ)
	EndIf

	If y != 0.0
		furn.SetAngle(currentX, currentY + y, currentZ)
	EndIf

	If z != 0.0
		furn.SetAngle(currentX, currentY, currentZ + z)
	EndIf

EndFunction

Function SetFuniturePosition(float x, float y, float z)

    ObjectReference furn
    furn = FurnitureEditRef.GetReference()

    float currentX = furn.GetPositionX()
    float currentY = furn.GetPositionY()
    float currentZ = furn.GetPositionZ()

	If x != 0.0
		furn.SetPosition(currentX + x, currentY, currentZ)
	EndIf

	If y != 0.0
		furn.SetPosition(currentX, currentY + y, currentZ)
	EndIf

	If z != 0.0
		furn.SetPosition(currentX, currentY, currentZ + z)
	EndIf

	; If x != 0.0
	; 	furn.SetPosition(furn.GetPositionX() + x, furn.GetPositionY(), furn.GetPositionZ())
	; EndIf

	; If y != 0.0
	; 	furn.SetPosition(furn.GetPositionX(), furn.GetPositionY() + y, furn.GetPositionZ())
	; EndIf

	; If z != 0.0
	; 	furn.SetPosition(furn.GetPositionX(), furn.GetPositionY(), furn.GetPositionZ() + z)
	; EndIf

EndFunction

int Function GetFoundFurnitureType()
    return foundFurnitureResult
EndFunction

bool Function GetCleaningFurniture()
    return isCleaning
EndFunction

; ObjectReference Function FindFurniture(Actor a, float distance)

;     foundFurnitureResult = 0
;     isCleaning = false
;     ObjectReference found
;     found = none

;     ObjectReference ddcFound = Game.FindClosestReferenceOfAnyTypeInListFromRef(bind_DdcItems, a, distance)
; 	ObjectReference zbfFound = Game.FindClosestReferenceOfAnyTypeInListFromRef(zbfListFurnitures, a, distance)

;     If ddcFound && zbfFound
;         If ddcfound.GetDistance(a) < zbfFound.GetDistance(a)
;             found = ddcfound
;             foundFurnitureResult = 2
;         Else
;             found = zbfFound
;             foundFurnitureResult = 1
;         EndIf
;     ElseIf ddcFound
;         found = ddcFound
;         foundFurnitureResult = 2
;     ElseIf zbfFound
;         found = zbfFound
;         foundFurnitureResult = 1
;     EndIf

;     If found != none
;         If found.IsDisabled()
;             found = none
;             foundFurnitureResult = 0
;         EndIf
;         If foundFurnitureResult == 1
;             If found.HasKeyWord(zbfFurnitureWaterWheelMini)
;                 isCleaning = true
;             EndIf
;         EndIf
;     Else
;     EndIf

;     return found

; EndFunction

bool Function LockInFurniture(Actor a, ObjectReference furn, bool player = true)
    
    StorageUtil.SetFormValue(a, "binding_locked_in_furniture", furn)
  
    if !ddcEventRegistered
        ddcEventRegistered = true
        RegisterForModEvent("DDC_DeviceEvent", "DdcDeviceEvent")
    endif

    If mqs.SoftCheckDM3 == 1
        If kwDM3 == none
            kwDM3 = bind_DM3Helper.GetFurnitureKeyword()
            ;kwDM3 = Game.GetFormFromFile(0x0300182B,"dse-display-model.esp") as Keyword
        EndIF
    EndIf

    If mqs.SoftCheckZAP == 1
        If kwZAP == none
            kwZAP = Keyword.GetKeyword("zbfFurniture")
        EndIf
    EndIf

    If mqs.SoftCheckDD == 1
        If kwDDC == none
            kwDDC = bind_DDHelper.GetFurnitureKeyword()
        EndIf
    EndIf

    int result
    result = 0
    ; If furn.HasKeyWord(zbfFurniture)
    ;     ;zap furniture
    ;     If player
    ;         playerSlot.SetFurniture(furn) 
    ;     Else
    ;         ;TODO: other actors
    ;     EndIf
    ;     result = 1
    ; ElseIf furn.HasKeyWord(zadc_FurnitureDevice)
    ;     ;dd contraption
    ;     zclib.LockActor(a, furn)
    ;     result = 2
    ; EndIf
    ; If mqs.SoftCheckZAP == 1
    ;     If furn.HasKeyWord(kwZAP)
    ;         bind_ZapHelper.LockInFurniture(furn, a)
    ;         result = 1
    ;     EndIf
    ; EndIf
    if mqs.SoftCheckZAP == 1
        If furn.HasKeyWord(kwZAP)       
            zbfSlot playerSlot = zbfBondageShell.GetApi().FindPlayer()
            playerSlot.SetFurniture(furn)
            bind_Utility.DoSleep(1.0)
            if !a.IsInFaction(bind_LockedInFurnitureFaction)
                a.AddToFaction(bind_LockedInFurnitureFaction)
            endif
        endif
    endif
    If mqs.SoftCheckDD == 1
        If furn.HasKeyWord(kwDDC)

            (furn as zadcFurnitureScript).SendDeviceModEvents = true
            (furn as zadcFurnitureScript).ScriptedDevice = true
            (furn as zadcFurnitureScript).PreventWaitandSleep = false

            bind_DDHelper.LockInFurniture(furn, a)

            int i = 0
            while !a.IsInFaction(bind_LockedInFurnitureFaction) && i < 60
                bind_Utility.WriteToConsole("furniture lock: " + i)
                i += 1
                bind_Utility.DoSleep(1.0)
            endwhile

            result =  2
        EndIf
    EndIf
    If mqs.SoftCheckDM3 == 1
        If furn.HasKeyWord(kwDM3)
            dm3slot = bind_DM3Helper.LockInFurniture(furn, a)

            bind_DDHelper.LockInFurniture(furn, a)

            int i = 0
            while !bind_DM3Helper.LockedInCheck(furn, a) && i < 60
                bind_Utility.WriteToConsole("furniture lock: " + i)
                i += 1
                bind_Utility.DoSleep(1.0)
            endwhile

            if !a.IsInFaction(bind_LockedInFurnitureFaction)
                a.AddToFaction(bind_LockedInFurnitureFaction)
            endif

            result = 3
        EndIf
    EndIf

    string furnitureName = furn.GetBaseObject().GetName()

    if StringUtil.Find(furnitureName, "Chair", 0) > -1
        bind_GlobalInFurniture.SetValue(1)
    elseif StringUtil.Find(furnitureName, "Pillory", 0) > -1
        bind_GlobalInFurniture.SetValue(2)

    elseif StringUtil.Find(furnitureName, "Pole (Overhead)", 0) > -1
        bind_GlobalInFurniture.SetValue(4)
    elseif StringUtil.Find(furnitureName, "Pole (Strappado)", 0) > -1
        bind_GlobalInFurniture.SetValue(5)
    elseif StringUtil.Find(furnitureName, "Pole (Hogtie)", 0) > -1
        bind_GlobalInFurniture.SetValue(6)
    elseif StringUtil.Find(furnitureName, "Pole (Upside Down)", 0) > -1
        bind_GlobalInFurniture.SetValue(7)
    elseif StringUtil.Find(furnitureName, "Pole (Wooden Horse)", 0) > -1
        bind_GlobalInFurniture.SetValue(8)
    elseif StringUtil.Find(furnitureName, "Restraint Post (Chained)", 0) > -1
        bind_GlobalInFurniture.SetValue(9)
    elseif StringUtil.Find(furnitureName, "Restraint Post (Standing)", 0) > -1
        bind_GlobalInFurniture.SetValue(10)
    elseif StringUtil.Find(furnitureName, "Restraint Post (Hanging)", 0) > -1
        bind_GlobalInFurniture.SetValue(11)

    elseif StringUtil.Find(furnitureName, "X-Cross (Reversed)", 0) > -1
        bind_GlobalInFurniture.SetValue(20)
    elseif StringUtil.Find(furnitureName, "X-Cross", 0) > -1
        bind_GlobalInFurniture.SetValue(21)

    elseif StringUtil.Find(furnitureName, "Cross", 0) > -1
        bind_GlobalInFurniture.SetValue(3)

    elseif StringUtil.Find(furnitureName, "Horse", 0) > -1
        bind_GlobalInFurniture.SetValue(12)    

    elseif StringUtil.Find(furnitureName, "Wheel", 0) > -1
        bind_GlobalInFurniture.SetValue(13)    

    elseif StringUtil.Find(furnitureName, "Torture Pole (Standing Reversed)", 0) > -1
        bind_GlobalInFurniture.SetValue(14)    
    elseif StringUtil.Find(furnitureName, "Torture Pole (Standing)", 0) > -1
        bind_GlobalInFurniture.SetValue(15)    
    elseif StringUtil.Find(furnitureName, "Torture Pole (Hanging)", 0) > -1
        bind_GlobalInFurniture.SetValue(16)    
    elseif StringUtil.Find(furnitureName, "Torture Pole (Kneeling)", 0) > -1
        bind_GlobalInFurniture.SetValue(17)    
    elseif StringUtil.Find(furnitureName, "Torture Pole (Sitting)", 0) > -1
        bind_GlobalInFurniture.SetValue(18)    

    elseif (StringUtil.Find(furnitureName, "Wall", 0) > -1 && StringUtil.Find(furnitureName, "Shackle", 0) > -1)
        bind_GlobalInFurniture.SetValue(19)    

    elseif StringUtil.Find(furnitureName, "Stockade Fuck Machine", 0) > -1
        bind_GlobalInFurniture.SetValue(22)  


    endif

    StorageUtil.SetIntValue(a, "binding_furniture_status", result)
    If player
        ;mqs.SetFurnitureStatus(result)
        ;main.SubInFurniture = result
    EndIf
    return true
EndFunction

bool Function UnlockFromFurniture(Actor a, ObjectReference furn, bool player = true)

    bind_GlobalInFurniture.SetValue(0)

    if !ddcEventRegistered
        ddcEventRegistered = true
        RegisterForModEvent("DDC_DeviceEvent", "DdcDeviceEvent")
    endif

    ; If furn.HasKeyWord(zbfFurniture)
    ;     ;zap furniture
    ;     If player
    ;         ;Debug.MessageBox("here?")
    ;         playerSlot.SetFurniture(none)
    ;     Else
    ;         ;TODO: other actors
    ;     EndIf
    ; ElseIf furn.HasKeyWord(zadc_FurnitureDevice)
    ;     ;dd contraption
    ;     zclib.UnlockActor(a)
    ; EndIf
    ; If mqs.SoftCheckZAP == 1
    ;     If furn.HasKeyWord(kwZAP)
    ;         bind_ZapHelper.UnlockFromFurniture()
    ;     EndIf
    ; EndIf
    if mqs.SoftCheckZAP == 1
        zbfSlot playerSlot = zbfBondageShell.GetApi().FindPlayer()
        playerSlot.SetFurniture(none)
        bind_Utility.DoSleep(1.0)
        if a.IsInFaction(bind_LockedInFurnitureFaction)
            a.RemoveFromFaction(bind_LockedInFurnitureFaction)
        endif
    endif
    If mqs.SoftCheckDD == 1
        If furn.HasKeyWord(kwDDC)
            bind_DDHelper.UnlockFromFurniture(a)

            int i = 0
            while a.IsInFaction(bind_LockedInFurnitureFaction) && i < 60
                bind_Utility.WriteToConsole("furniture unlock: " + i)
                i += 1
                bind_Utility.DoSleep(1.0)
            endwhile

        EndIf
    EndIf
    If mqs.SoftCheckDM3 == 1
        If furn.HasKeyWord(kwDM3)
            bind_DM3Helper.UnlockFromFurniture(furn, dm3slot)

            ; int i = 0
            ; while bind_DM3Helper.LockedInCheck(furn, a) && i < 60
            ;     bind_Utility.WriteToConsole("furniture unlock: " + i)
            ;     i += 1
            ;     bind_Utility.DoSleep(1.0)
            ; endwhile

            if a.IsInFaction(bind_LockedInFurnitureFaction)
                a.RemoveFromFaction(bind_LockedInFurnitureFaction)
            endif

        EndIf
    EndIf
    If player
        ;Debug.MessageBox("in here?")
        ;main.SubInFurniture = 0
        ;mqs.SetFurnitureStatus(0)
    EndIf
    
    Utility.Wait(2.0)

    StorageUtil.SetFormValue(a, "binding_locked_in_furniture", none)
    StorageUtil.SetIntValue(a, "binding_furniture_status", 0)

    return true
EndFunction

ObjectReference Function ScanForFurniture(Actor a)
   
    foundFurnitureResult = 0

    ;TODO: this probably will not be needed, it was easy enough to build a formlist for 
    ;DDC items, can do the same for DM3 
    ;Maybe a large form list for all the possible items? might be tricky because soft requirement for DM3

    ;TODO: move to OnInit
    ; Quest dm3Q = bind_DM3Helper.GetQuest()
    ; Debug.MessageBox(dm3Q.GetStage())

    If mqs.SoftCheckDM3 == 1
        If kwDM3 == none
            kwDM3 = bind_DM3Helper.GetFurnitureKeyword()
            ;kwDM3 = Game.GetFormFromFile(0x0300182B,"dse-display-model.esp") as Keyword
        EndIF
    EndIf

    If mqs.SoftCheckZAP == 1
        If kwZAP == none
            kwZAP = Keyword.GetKeyword("zbfFurniture")
        EndIf
    EndIf

    If mqs.SoftCheckDD == 1
        If kwDDC == none
            kwDDC = bind_DDHelper.GetFurnitureKeyword()
        EndIf
    EndIf

    Cell kCell = a.GetParentCell()
	Int iIndex = kCell.GetNumRefs(formTypeFuniture)

	;mqs.WindowOutput("Found " + iIndex + " furniture items")

    ;Debug.MessageBox(iIndex)

    ObjectReference nearestFurn
    nearestFurn = none
    float foundAtDistance = 0.0

	bool foundZaz = false
	ObjectReference furn

	If (iIndex > 0)
		While iIndex
			iIndex -= 1
            furn = kCell.GetNthRef(iIndex, formTypeFuniture)

            If mqs.SoftCheckZAP == 1 ;&& mqs.EnableModZAP == 1
                If furn.HasKeyWord(kwZAP) && !furn.IsDisabled() && !furn.IsFurnitureInUse() ;not sure if IsFurnitureInUse() works on activators? need to test this
                    ;mqs.WindowOutput("found zap!")
                    If nearestFurn == none
                        nearestFurn = furn
                        foundAtDistance = furn.GetDistance(a)
                        foundFurnitureResult = 1
                    Else
                        If furn.GetDistance(a) < foundAtDistance
                            nearestFurn = furn
                            foundAtDistance = furn.GetDistance(a)
                            foundFurnitureResult = 1
                        EndIf
                    EndIf
                EndIf
            EndIf

		EndWhile
	EndIf

    If mqs.SoftCheckDM3 == 1 || mqs.SoftCheckDD == 1

        kCell = a.GetParentCell()
        iIndex = kCell.GetNumRefs(formTypeActivator)

        ;mqs.WindowOutput("Found " + iIndex + " misc items")

        If (iIndex > 0)
            While iIndex
                iIndex -= 1
                furn = kCell.GetNthRef(iIndex, formTypeActivator)

                If mqs.SoftCheckDM3 == 1 && mqs.EnableModDM3 == 1
                    If furn.HasKeyWord(kwDM3) && !furn.IsDisabled()
                        If bind_DM3Helper.FurnitureHasFreeSlots(furn)
                            ;Debug.Notification("found dm3!")
                            If nearestFurn == none
                                nearestFurn = furn
                                foundAtDistance = furn.GetDistance(a)
                                foundFurnitureResult = 3
                            Else
                                If furn.GetDistance(a) < foundAtDistance
                                    nearestFurn = furn
                                    foundAtDistance = furn.GetDistance(a)
                                    foundFurnitureResult = 3
                                EndIf
                            EndIf
                        EndIf
                    EndIf
                EndIf

                ;If mqs.SoftCheckDD == 1  ;&& mqs.EnableModDD == 1
                    If furn.HasKeyWord(kwDDC) && !furn.IsDisabled() && !furn.IsFurnitureInUse()
                        ;Debug.Notification("found ddc!")
                        If nearestFurn == none
                            nearestFurn = furn
                            foundAtDistance = furn.GetDistance(a)
                            foundFurnitureResult = 2
                        Else
                            If furn.GetDistance(a) < foundAtDistance
                                nearestFurn = furn
                                foundAtDistance = furn.GetDistance(a)
                                foundFurnitureResult = 2
                            EndIf
                        EndIf
                    EndIf
                ;EndIf

    
    
            EndWhile
        EndIf

    EndIf

    return nearestFurn

EndFunction

Faction function GetLockedInFurnitureFaction()
    return bind_LockedInFurnitureFaction
endfunction

bind_MainQuestScript property mqs auto
bind_Functions property fs auto

ReferenceAlias property FurnitureEditRef auto

Faction property bind_LockedInFurnitureFaction auto

Keyword property bind_FurnitureItem auto

FormList property bind_ZapFurnitureList auto

GlobalVariable property bind_GlobalInFurniture auto