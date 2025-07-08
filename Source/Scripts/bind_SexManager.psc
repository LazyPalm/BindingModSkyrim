Scriptname bind_SexManager extends Quest conditional

int property SubRequiredToThankForSex auto conditional
int property SubHasMasturbationPermission auto conditional

;bound sex flags
int property BoundSexCuffs auto conditional
int property BoundSexHeavyBondage auto conditional
int property BoundSexGag auto conditional
int property BoundSexBlindfold auto conditional
int property BoundSexHood auto conditional
int property BoundSexAPlug auto conditional
int property BoundSexVPlug auto conditional

;bound masturbation
int property BoundMasturbationCuffs auto conditional
int property BoundMasturbationGag auto conditional
int property BoundMasturbationBlindfold auto conditional
int property BoundMasturbationHood auto conditional
int property BoundMasturbationAPlug auto conditional
int property BoundMasturbationVPlug auto conditional
int property BoundMasturbationUnties auto conditional

function UpdateArousalLevels()
    bind_GlobalSexArousalDom.SetValue(slau.GetActorArousal(fs.GetDomRef()))
    bind_GlobalSexArousalSub.SetValue(slau.GetActorArousal(fs.GetSubRef()))
endfunction

bool function StartSexScene(Actor sub, Actor dom = none)

    bool result

	string useTags
	string blockTags

    useTags = ""
    blockTags = ""

	string[] useArray = StorageUtil.StringListToArray(sub, "bind_use_sl_tags")
	string[] blockArray = StorageUtil.StringListToArray(sub, "bind_block_sl_tags")

    bind_Utility.WriteToConsole("StartTwoPersonSex useArray " + useArray + " blockArray: " + blockArray)

	int i = 0

    if mqs.SexUseFramework == 0
        while i < useArray.Length
            if useTags != ""
                useTags += ","
            endif
            useTags += useArray[i]
            i += 1
        endwhile
    elseif mqs.SexUseFramework == 1
        if useArray.Length > 0
            useTags = useArray[Utility.RandomInt(0, useArray.Length - 1)]    
        endif
    endif

	i = 0
	while i < blockArray.Length
		if blockTags != ""
			blockTags += ","
		endif
		blockTags += blockArray[i]
		i += 1
	endwhile

    if useTags == ""
        if sub.GetActorBase().GetSex() == 1
            useTags += "F"
        else
            useTags += "M"
        endif
        if dom
            if dom.GetActorBase().GetSex() == 1
                useTags += "F"
            else
                useTags += "M"
            endif
        endif
        if useTags == "MF"
            useTags = "FM" ;NOTE - might work the other way, but sex lab tags list did not have this version
        endif
    endif

	bind_Utility.WriteToConsole("StartTwoPersonSex USE: " + useTags + " BLOCK: " + blockTags)

    Actor[] sceneActors
    
    if dom
        sceneActors = new Actor[2]
        sceneActors[0] = sub
        sceneActors[1] = dom
    else
        sceneActors = new Actor[1]
        sceneActors[0] = sub
    endif

    ;TODO - add SexLab / DD setting in MCM and if/then here to start from different frameworks

    ; sslBaseAnimation[] slanim = zlibs.SelectValidDDAnimations(actors = sceneActors, count = 2, forceaggressive = false, includetag = useTags, suppresstag = blockTags)
    ; bind_Utility.WriteToConsole("slanim: " + slanim)

    if mqs.SexUseFramework == 1

        result = zlibs.StartValidDDAnimation(SexActors = sceneActors, forceaggressive = false, includetag = useTags, suppresstag = blockTags, victim = sub, allowbed = true)

        bind_Utility.WriteToConsole("StartValidDDAnimation: " + result)

    elseif mqs.SexUseFramework == 0

        sslBaseAnimation[] sanims

        sanims = sfx.GetAnimationsByTags(ActorCount = sceneActors.Length, Tags = useTags, TagSuppress = blockTags, RequireAll = false)
        bind_Utility.WriteToConsole(sanims)
        If sanims.Length > 0		
            if sfx.StartSex(Positions = sceneActors, anims = sanims, allowbed = true) == -1
                result = false
            else
                result = true
            endif
        Else
            Debug.MessageBox("No sexlab animations could be found")
            result = false
        EndIf

        bind_Utility.WriteToConsole("StartSex: " + result)

    endif

	return result

endfunction

zadLibs property zlibs auto
slaUtilScr property slau auto
SexLabFramework property sfx auto

bind_MainQuestScript property mqs auto
bind_Functions property fs auto

GlobalVariable property bind_GlobalSexArousalDom auto
GlobalVariable property bind_GlobalSexArousalSub auto

