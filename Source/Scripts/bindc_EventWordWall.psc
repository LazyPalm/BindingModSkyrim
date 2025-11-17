Scriptname bindc_EventWordWall extends Quest  

event OnInit()

    if self.IsRunning()

        ;debug.MessageBox(self.GetName())

        bind_Utility.PriApiEventStart(self.GetName(), true)

        TheDom.ForceRefTo(bind_Utility.PriApiGetDom())

        bind_Utility.DoSleep(30.0)

        bind_Utility.PriApiEventEnd(true)

        debug.MessageBox("ended...")

    endif

endevent

ReferenceAlias property TheDom auto
ReferenceAlias property TheWordWall auto