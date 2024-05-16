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
                // Create a new story page with your desired text
                local RULES = Story.NewStoryPage(company_id, GSText(GSText.STR_RULES_TITLE),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_RULES_LINE1),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_RULES_LINE2),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_RULES_LINE3),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_RULES_LINE4),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_RULES_LINE5)
                );

                // Create a new story page with your desired text
                local BOT_COMMANDS = Story.NewStoryPage(company_id, GSText(GSText.STR_BOT_COMMANDS_TITLE),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE1),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE2),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE3),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE4),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE5),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE6),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE7),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE8),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE9),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE10),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE11),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE12),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE13),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE14),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE15),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE16),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE17),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE18),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_BOT_COMMANDS_LINE19)
                );

                // Create a new story page with your desired text
                local WELCOME_TO_MODTRACK = Story.NewStoryPage(company_id, GSText(GSText.STR_WELCOME_TO_MODTRACK_TITLE),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_WELCOME_TO_MODTRACK_LINE1),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_WELCOME_TO_MODTRACK_LINE2),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_WELCOME_TO_MODTRACK_LINE3),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_WELCOME_TO_MODTRACK_LINE4),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_WELCOME_TO_MODTRACK_LINE5),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_WELCOME_TO_MODTRACK_LINE6),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_WELCOME_TO_MODTRACK_LINE7),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_WELCOME_TO_MODTRACK_LINE8),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_WELCOME_TO_MODTRACK_LINE9),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_WELCOME_TO_MODTRACK_LINE10),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_WELCOME_TO_MODTRACK_LINE11),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_WELCOME_TO_MODTRACK_LINE12)
                );

                GSStoryPage.Show(WELCOME_TO_MODTRACK);
                break;
            }
            // Handle other events if needed
        }
    }
}
