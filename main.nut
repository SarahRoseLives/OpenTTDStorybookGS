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
                local PAGE_1 = Story.NewStoryPage(company_id, GSText(GSText.STR_PAGE1_TITLE),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE1_LINE1)
                );

                // Create a new story page with your desired text
                local PAGE_2 = Story.NewStoryPage(company_id, GSText(GSText.STR_PAGE3_TITLE),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE3_LINE1),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE3_LINE2),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE3_LINE3),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE3_LINE4),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE3_LINE5),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE3_LINE6),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE3_LINE7),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE3_LINE8),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE3_LINE9),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE3_LINE10)
                );

                // Create a new story page with your desired text
                local PAGE_3 = Story.NewStoryPage(company_id, GSText(GSText.STR_PAGE2_TITLE),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE2_LINE1),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE2_LINE2),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE2_LINE3),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE2_LINE4),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE2_LINE5),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE2_LINE6),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE2_LINE7),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE2_LINE8),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE2_LINE9),
                    GSStoryPage.SPET_TEXT, 0, GSText(GSText.STR_PAGE2_LINE10)
                );                

                // Show the newly created story page
       
                GSStoryPage.Show(PAGE_1)
             

                break;
            }

            // Handle other events if needed
        }
    }
}
