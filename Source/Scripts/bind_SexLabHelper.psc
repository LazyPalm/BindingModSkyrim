Scriptname bind_SexLabHelper extends Quest  

bool Function CheckValid() Global
    return Game.GetModByName("SexLab.esm") != 255
EndFunction

SexLabFramework Function GetHelper() Global
   return Quest.GetQuest("SexLabQuestFramework") as SexLabFramework
EndFunction

ObjectReference Function SearchForBed(Actor a, float searchDistance) global
    SexLabFramework sfx = GetHelper()
	return sfx.FindBed(a, searchDistance, false)
EndFunction

bool Function StartTwoPersonSex(Actor dom, Actor sub) global

	bool result = true

	string useTags = ""
	string blockTags = ""

	string[] useArray = StorageUtil.StringListToArray(sub, "bind_use_sl_tags")
	string[] blockArray = StorageUtil.StringListToArray(sub, "bind_block_sl_tags")

	int i = 0
	while i < useArray.Length
		if useTags != ""
			useTags += ","
		endif
		useTags += useArray[i]
		i += 1
	endwhile

	i = 0
	while i < blockArray.Length
		if blockTags != ""
			blockTags += ","
		endif
		blockTags += blockArray[i]
		i += 1
	endwhile

	bind_Utility.WriteToConsole("StartTwoPersonSex USE: " + useTags + " BLOCK: " + blockTags)

    SexLabFramework sfx = GetHelper()
	Actor[] sceneActors = new Actor[2]
	sceneActors[0] = sub
	sceneActors[1] = dom
	sslBaseAnimation[] sanims
	; sanims = sfx.GetAnimationsByTags(ActorCount = 2, Tags = "Aggressive", TagSuppress = "", RequireAll = true)
	; If sanism.Length == 0
	; 	sanims = sfx.PickAnimationsByActors(sceneActors)
	; EndIf
	;sanims = sfx.PickAnimationsByActors(Positions = sceneActors, Limit = 64, Aggressive = true)
	sanims = sfx.GetAnimationsByTags(ActorCount = 2, Tags = useTags, TagSuppress = blockTags, RequireAll = false)
	bind_Utility.WriteToConsole(sanims)
	If sanims.Length > 0		
		if sfx.StartSex(Positions = sceneActors, anims = sanims, allowbed = true) == -1
			result = false
		endif
	Else
		Debug.MessageBox("No sexlab animations could be found")
		result = false
    EndIf

	return result

EndFunction

bool function StartOnePersonSex(Actor a) global
	bool result = true
    SexLabFramework sfx = GetHelper()
	;sfx.QuickStart(Actor1 = a)

	Actor[] sceneActors = new Actor[1]
	sceneActors[0] = a
	sslBaseAnimation[] sanims
	sanims = sfx.GetAnimationsByTags(ActorCount = 1, Tags = "", TagSuppress = "", RequireAll = true)
	If sanims.Length > 0		
		if sfx.StartSex(Positions = sceneActors, anims = sanims, allowbed = true) == -1
			return result
		endif
	Else
		Debug.MessageBox("No sexlab animations could be found")
		result = false
    EndIf

	return result
EndFunction

string[] function GetAllAnimationTags(int actorCount) global
	SexLabFramework sfx = GetHelper()
	return sfx.GetAllAnimationTags(actorCount, true)
endfunction