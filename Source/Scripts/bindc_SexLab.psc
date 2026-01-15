Scriptname bindc_SexLab extends SexLabFramework  

function LoadGame()
    RegisterForModEvent("AnimationEnd", "OnSexEndEvent")
endfunction

event OnSexEndEvent(string eventName, string argString, float argNum, form sender)

    bindc_Util.WriteInformation("sexlab AnimationEnd - eventName: " + eventName + " argString: " + argString + " argNum: " + argNum + " sender: " + sender)

    sslThreadController c = sender as sslThreadController
    if c != none
        debug.MessageBox("threadid " + c.tid)
        StorageUtil.IntListRemove(none, "bindc_sexlab_threads", c.tid)
    endif

endevent

int function UpdateArousalLevels(Actor akActor)
    int level = slau.GetActorArousal(akActor)
    StorageUtil.SetIntValue(akActor, "bindc_arousal_level", level)
    return level
endfunction

function StopRunningScene(int threadId)

    if threadId > -1
        sslThreadController c = GetController(threadId)
        if c != none
            c.EndAnimation()
        endif
    endif

endfunction

bool function SceneRunningCheck(int threadId)
    if threadId > -1
        if StorageUtil.IntListHas(none, "bindc_arousal_level", threadId)
            return true
        endif
    else
        return false
    endif
endfunction

int function StartSexScene(Actor akActor1, Actor akActor2 = none)

    int threadId = 0

    bool result

	string useTags
	string blockTags

    useTags = ""
    blockTags = ""

	string[] useArray = StorageUtil.StringListToArray(none, "bindc_use_sl_tags")
	string[] blockArray = StorageUtil.StringListToArray(none, "bindc_block_sl_tags")

    bindc_Util.WriteInformation("StartSexScene useArray " + useArray + " blockArray: " + blockArray)

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

    if useTags == ""
        if akActor1.GetActorBase().GetSex() == 1
            useTags += "F"
        else
            useTags += "M"
        endif
        if akActor2
            if akActor2.GetActorBase().GetSex() == 1
                useTags += "F"
            else
                useTags += "M"
            endif
        endif
        if useTags == "MF"
            useTags = "FM" ;NOTE - might work the other way, but sex lab tags list did not have this version
        endif
    endif

	bindc_Util.WriteInformation("StartSexScene USE: " + useTags + " BLOCK: " + blockTags)

    Actor[] sceneActors
    
    if akActor2
        sceneActors = new Actor[2]
        sceneActors[0] = akActor1
        sceneActors[1] = akActor2
    else
        sceneActors = new Actor[1]
        sceneActors[0] = akActor1
    endif

    sslBaseAnimation[] sanims

    sanims = GetAnimationsByTags(ActorCount = sceneActors.Length, Tags = useTags, TagSuppress = blockTags, RequireAll = false)
    bindc_Util.WriteInformation(sanims)
    If sanims.Length > 0		
        threadId = StartSex(Positions = sceneActors, anims = sanims, allowbed = true)
        if threadId == -1
            result = false
        else
            result = true
        endif
    Else
        Debug.MessageBox("No sexlab animations could be found")
        result = false
    EndIf

    if result
        StorageUtil.IntListAdd(none, "bindc_sexlab_threads", threadId)
    endif

    bindc_Util.WriteInformation("StartSex: " + result)

	return threadId

endfunction

slaUtilScr property slau auto