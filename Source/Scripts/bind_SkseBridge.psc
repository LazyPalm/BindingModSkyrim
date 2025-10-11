Scriptname bind_SkseBridge hidden

int function SetToken(Actor act, Armor arm) global
    bind_Utility.WriteToConsole("bind_SkseBridge - SetToken - " + arm)
    StorageUtil.SetIntValue(act, "zad_RemovalToken" + arm, 1)	
    return 0
endfunction

int function SetDeviousRemovalTokens(Actor act, Form[] items) global
    ;debug.MessageBox(items)
    if items.Length > 0
        int i = 0
        while i < items.Length
            bind_Utility.WriteToConsole("bind_SkseBridge - SetToken - " + items[i])
            StorageUtil.SetIntValue(act, "zad_RemovalToken" + items[i], 1)	            
            i += 1
        endwhile
    endif
endfunction

int function LockDevice(Actor act, Armor arm) global
    zadLibs zlib = Quest.GetQuest("zadQuest") as zadLibs
    zlib.LockDevice(act, arm, true)
    return 0
endfunction

int function DisplayCaption(Actor act, string text) global
    ;debug.MessageBox(text)
    ;bind_SkseFunctions.PlayerChatOutput(act, text)
    return 0
endfunction