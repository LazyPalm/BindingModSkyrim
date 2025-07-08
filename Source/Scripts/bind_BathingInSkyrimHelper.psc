Scriptname bind_BathingInSkyrimHelper extends Quest  

int _loadedSpells

Spell _dirt1
Spell _dirt2
Spell _dirt3
Spell _dirt4

int Property LoadedSpells
    int Function Get()
        return _loadedSpells
    EndFunction
    Function Set(int value)
        _loadedSpells = value
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
    return Game.IsPluginInstalled("Bathing in Skyrim.esp")
EndFunction

bind_BathingInSkyrimHelper Function GetHelper() Global

    bind_BathingInSkyrimHelper bis = Quest.GetQuest("bind_MainQuest") as bind_BathingInSkyrimHelper

    If bis.LoadedSpells == 0
        string fileName = "Bathing in Skyrim.esp"

        FormList list = Game.GetFormFromFile(0x0301408F, fileName) as FormList

        bis.Dirt1 = list.GetAt(0) as Spell
        bis.Dirt2 = list.GetAt(1) as Spell
        bis.Dirt3 = list.GetAt(2) as Spell
        bis.Dirt4 = list.GetAt(3) as Spell

        bis.LoadedSpells = 1
    EndIf

    return bis

EndFunction

int Function GetCleanlinessLevel(Actor a) Global

    bind_BathingInSkyrimHelper bis = GetHelper()

    int cleanLevel = 0

    If a.HasSpell(bis.Dirt4)
        cleanLevel = 4 ;BIS - Filthy
    ElseIf a.HasSpell(bis.Dirt3)
        cleanLevel = 3 ;BIS - Dirty
    ElseIf a.HasSpell(bis.Dirt2)
        cleanLevel = 2 ;BIS - Not Dirty
    ElseIf a.HasSpell(bis.Dirt1)
        cleanLevel = 1 ;BIS - Clean
    EndIf

    return cleanLevel

EndFunction

int Function ConvertCleanlinessToBinding(int cleanLevel) Global
    int value
    If cleanLevel == 0
        value = 0
    ElseIf cleanLevel == 1 ;BIS - Clean
        value = 0
    ElseIf cleanLevel == 2 ;BIS - Not Dirty
        value = 25
    ElseIf cleanLevel == 3 ;BIS - Dirty
        value = 50
    ElseIf cleanLevel == 4 ;BIS - Filthy
        value = 100
    EndIf
    return value
EndFunction