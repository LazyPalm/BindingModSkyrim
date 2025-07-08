Scriptname bind_PunishmentManager extends Quest  

; Weapon storedWeapon1
; Weapon storedWeapon2
; Armor storedSheild

; ObjectReference whippingFurniture 
; bool inFurniture

; int AI_DOM_HOLD = 10
; int AI_SUB_WHIPPED = 130
; int AI_DOM_WHIP = 500

; Function Update(float currentTime)


; EndFunction

; ;NOTE - we need an internal lightweight system for people that only have DD installed
; ;ZAP might not be included and pama's beatup module requires ZAP
; Function WhipActor(Actor sub, Actor dom, string msg = "")

;     main.SetDomAI(AI_DOM_HOLD)

;     ;rotate dom
;     float zOff = dom.GetHeadingAngle(sub)
;     dom.SetAngle(dom.GetAngleX(), dom.GetAngleY(), dom.GetAngleZ() + zOff)

;     Utility.Wait(1.0)

;     If main.SoftCheckDD == 1
;         If whippingFurniture == none
;             Form furn = bind_DDHelper.GetFurnitureItem("DD Gallow Overhead")
;             whippingFurniture = sub.PlaceAtMe(furn, 1, true, true)

;         EndIf
;         whippingFurniture.MoveTo(sub)
;         whippingFurniture.SetAngle(0.0, 0.0, dom.GetAngleZ() - 180)
;         whippingFurniture.Enable()

;         fman.LockInFurniture(sub, whippingFurniture, 1)
;         inFurniture = true
;     Else
;         sub.SetAngle(sub.GetAngleX(), sub.GetAngleY(), dom.GetAngleZ()) ; - 180) ;-180 for front
;         main.SetSubAI(AI_SUB_WHIPPED)
;         inFurniture = false
;     EndIf

;     dom.AddItem(WoodenSword, 1)

;     ;TODO - gear manager should store these items
; 	If dom.GetEquippedWeapon() != none
; 		storedWeapon1 = dom.GetEquippedWeapon()
; 		dom.UnequipItem(storedWeapon1, false, true)
; 	Else
; 		storedWeapon1 = none
; 	EndIf
; 	If dom.GetEquippedWeapon(true) != none
; 		storedWeapon2 = dom.GetEquippedWeapon(true)
; 		dom.UnequipItem(storedWeapon2, false, true)
; 	Else
; 		storedWeapon2 = none
; 	EndIf
; 	If dom.GetEquippedShield() != none
; 		storedSheild = dom.GetEquippedShield()
; 		dom.UnequipItem(storedSheild, false, true)
; 	Else
; 		storedSheild = none
; 	EndIf

;     main.SetDomAI(AI_DOM_WHIP)

; EndFunction

; Function EndWhipActor(Actor sub, Actor dom)

;     main.SetDomAI(AI_DOM_HOLD)

;     If inFurniture
;         If main.SoftCheckDD == 1
;             fman.UnlockFromFurniture(sub, whippingFurniture, true)
;             Utility.Wait(2.0)
;             whippingFurniture.Disable()
;         EndIf
;     Else
;         main.ClearSubAI()
;     EndIf

;     main.ClearDomAI()

; 	If storedWeapon1 != none
; 		dom.EquipItem(storedWeapon1, false, true)
; 	EndIf
; 	If storedWeapon2 != none
; 		dom.EquipItem(storedWeapon2, false, true)
; 	EndIf
; 	If storedSheild != none
; 		dom.EquipItem(storedSheild, false, true)
; 	EndIf

;     dom.RemoveItem(WoodenSword, 1)

; EndFunction

bind_MainQuestScript property main auto
bind_FurnitureManager property fman auto

Weapon property WoodenSword auto

;will need this at some point for adding whip marks
;SlaveTats.simple_add_tattoo(theSubRef, "Slave Marks", "Slave (left breast)", 0, true, true, 1.0)
