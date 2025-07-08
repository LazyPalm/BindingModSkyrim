Scriptname bind_DirtAndBloodHelper extends Quest

int _loadedSpells

Spell _dirt1
Spell _dirt2
Spell _dirt3
Spell _dirt4

Spell _blood1
Spell _blood2
Spell _blood3
Spell _blood4

int Property LoadedSpells
    int Function Get()
        return _loadedSpells
    EndFunction
    Function Set(int value)
        _loadedSpells = value
    EndFunction
EndProperty

Spell Property Blood1
    Spell Function Get()
        return _blood1
    EndFunction
    Function Set(Spell value)
        _blood1 = value
    EndFunction
EndProperty

Spell Property Blood2
    Spell Function Get()
        return _blood2
    EndFunction
    Function Set(Spell value)
        _blood2 = value
    EndFunction
EndProperty

Spell Property Blood3
    Spell Function Get()
        return _blood3
    EndFunction
    Function Set(Spell value)
        _blood3 = value
    EndFunction
EndProperty

Spell Property Blood4
    Spell Function Get()
        return _blood4
    EndFunction
    Function Set(Spell value)
        _blood4 = value
    EndFunction
EndProperty

Spell Property Dirt1
    Spell Function Get()
        return _dirt1
    EndFunction
    Function Set(Spell value)
        _dirt1 = value
    EndFunction
EndProperty

Spell Property Dirt2
    Spell Function Get()
        return _dirt2
    EndFunction
    Function Set(Spell value)
        _dirt2 = value
    EndFunction
EndProperty

Spell Property Dirt3
    Spell Function Get()
        return _dirt3
    EndFunction
    Function Set(Spell value)
        _dirt3 = value
    EndFunction
EndProperty

Spell Property Dirt4
    Spell Function Get()
        return _dirt4
    EndFunction
    Function Set(Spell value)
        _dirt4 = value
    EndFunction
EndProperty

bool Function CheckValid() Global
    return Game.GetModByName("Dirt and Blood - Dynamic Visuals.esp") != 255
EndFunction

bind_DirtAndBloodHelper Function GetHelper() Global

    bind_DirtAndBloodHelper dab = Quest.GetQuest("bind_MainQuest") as bind_DirtAndBloodHelper

    If dab.LoadedSpells == 0
        string dirtAndBloodFile = "Dirt and Blood - Dynamic Visuals.esp"

        dab.Dirt1 = Game.GetFormFromFile(0x03000806, dirtAndBloodFile) as Spell
        dab.Dirt2 = Game.GetFormFromFile(0x03000807, dirtAndBloodFile) as Spell
        dab.Dirt3 = Game.GetFormFromFile(0x03000808, dirtAndBloodFile) as Spell
        dab.Dirt4 = Game.GetFormFromFile(0x03000838, dirtAndBloodFile) as Spell
    
        dab.Blood1 = Game.GetFormFromFile(0x03000809, dirtAndBloodFile) as Spell
        dab.Blood2 = Game.GetFormFromFile(0x0300080A, dirtAndBloodFile) as Spell
        dab.Blood3 = Game.GetFormFromFile(0x0300080B, dirtAndBloodFile) as Spell
        dab.Blood4 = Game.GetFormFromFile(0x03000839, dirtAndBloodFile) as Spell

        dab.LoadedSpells = 1
    EndIf

    return dab

EndFunction

int Function GetDirtLevel(Actor a) Global

    bind_DirtAndBloodHelper dab = GetHelper()

    int level = 0

    If a.HasSpell(dab.Dirt4)
        level = 4
    ElseIf a.HasSpell(dab.Dirt3)
        level = 3
    ElseIf a.HasSpell(dab.Dirt2)
        level = 2
    ElseIf a.HasSpell(dab.Dirt1)
        level = 1
    EndIf

    return level

EndFunction

int Function GetBloodLevel(Actor a) Global

    bind_DirtAndBloodHelper dab = GetHelper()

    int level = 0

    If a.HasSpell(dab.Blood4)
        level = 4
    ElseIf a.HasSpell(dab.Blood3)
        level = 3
    ElseIf a.HasSpell(dab.Blood2)
        level = 2
    ElseIf a.HasSpell(dab.Blood1)
        level = 1
    EndIf

    return level

EndFunction

int Function GetCleanlinessLevel(Actor a) Global

    ;NOTE - this function looks for the high water mark between blood or dirt
    ;assumes covered in blood is just as unclean as being covered in dirt

    bind_DirtAndBloodHelper dab = GetHelper()

    int cleanLevel = 0

    ;use the higher level of blood or dirt to return a number above
    If a.HasSpell(dab.Dirt4) || a.HasSpell(dab.Blood4)
        cleanLevel = 4
    ElseIf a.HasSpell(dab.Dirt3) || a.HasSpell(dab.Blood3)
        cleanLevel = 3
    ElseIf a.HasSpell(dab.Dirt2) || a.HasSpell(dab.Blood2)
        cleanLevel = 2
    ElseIf a.HasSpell(dab.Dirt1) || a.HasSpell(dab.Blood1)
        cleanLevel = 1
    EndIf

    return cleanLevel

EndFunction

int Function ConvertCleanlinessToBinding(int dirtLevel) Global
    int value
    If dirtLevel == 0
        value = 0
    ElseIf dirtLevel == 1
        value = 25
    ElseIf dirtLevel == 2
        value = 50
    ElseIf dirtLevel == 3
        value = 75
    ElseIf dirtLevel == 4
        value = 100
    EndIf
    return value
EndFunction