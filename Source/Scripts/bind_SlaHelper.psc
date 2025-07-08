Scriptname bind_SlaHelper extends Quest  

bool Function CheckValid() Global
    return Game.GetModByName("SexLabAroused.esm") != 255
EndFunction

;slaUtilScr Property slau Auto
slaUtilScr Function GetHelper() Global
    return Quest.GetQuest("sla_Framework") as slaUtilScr
EndFunction

int Function GetArousal(Actor a) global
    slaUtilScr slau = GetHelper()
    return slau.GetActorArousal(a)
EndFunction