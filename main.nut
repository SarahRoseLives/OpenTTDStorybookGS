/** Import SuperLib for GameScript **/
import("util.superlib", "SuperLib", 36);
Story <- SuperLib.Story;

class MainClass extends GSController {}

function MainClass::Start()
{
    // Main Game Script loop
    while (true) {
        // Handle incoming messages from OpenTTD
        this.HandleEvents();
    }
}

/*
 * This method handles incoming events from OpenTTD.
 */
function MainClass::HandleEvents()
{
    if(GSEventController.IsEventWaiting()) {
        local ev = GSEventController.GetNextEvent();
        if (ev == null) return;

        local ev_type = ev.GetEventType();
        switch (ev_type) {
            case GSEvent.ET_COMPANY_NEW: {
                local company_event = GSEventCompanyNew.Convert(ev);
                local company_id = company_event.GetCompanyID();

                // Display a welcome message and rules for the new company
                //Story.ShowMessage(company_id, "Here are our server commands.", "Commands");

				Story.ShowMessage(company_id, "Here are our server commands:\n- Command 1\n- Command 2\n- Command 3", "Commands");


                Story.ShowMessage(company_id, "These are the rules for the server.", "Rules");
                
                Story.ShowMessage(company_id, "Welcome to the game!", "Welcome");
                break;
            }

            // Handle other events if needed
        }
    }
}
