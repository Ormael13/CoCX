/*
 Debug pane and related functions
 Author: Fake-Name
 */
package classes.display {
import classes.BaseContent;
import classes.CoC_Settings;
import classes.CoC;

import flash.system.Security;

public class DebugInfo extends BaseContent {

	public function debugPane():void
	{
		clearOutput();
		displayHeader("Debug information!");

		outputText("\nPossible flash sandboxing contexts:");
		outputText("<ul>");
		outputText("<li><b>\"localWithNetwork\"</b> means images <b><u>will not work</u></b>!</li>");
		outputText("<li><b>\"localWithFile\"</b> means images can work.</li>");
		outputText("<li><b>\"localTrusted\"</b> means images can work, and you've somehow managed to install this swf into a flash trusted directory. How did you manage that?</li>");
		outputText("</ul>");
		outputText("\nNote that you still need the proper folder structure to have functional images.");

		outputText("\n\nCurrent Sandbox mode: <b>" + Security.sandboxType + "</b>");
		outputText("\n<hr /> --------"); // HR Tag! WHY U NO WORK?

		outputText("\nCurrently have " + images.getLoadedImageCount() + " images loaded into cache.");



		if (CoC_Settings.haltOnErrors)  // Using a static class so I can grab it from anywhere.
			outputText("\nCurrently set to halt on all errors.");
		else
			outputText("\nParsing or description errors only generate warning message");

		outputText("\n<hr /> --------"); // HR Tag! WHY U NO WORK?

		outputText("\n\n<b>FUNCTIONALITY ON THIS PAGE IS IN ALPHA-RELEASE STATUS</b>\n");
		outputText("<b>IF YOU DON'T KNOW WHAT YOU ARE DOING AND/OR HAVE UNSAVED GAME PROGRESS, DO NOT CLICK ANY BUTTON EXCEPT \"BACK\"</b>\n");


		outputText(images.showImage("monster-ceraph"));

		menu();

		addButton(5, "Parser Tests", doThatTestingThang,this.debugPane);
		addButton(6, "Halt on Errors", toggleHaltSettings);
		addButton(14, "Back", CoC.instance.mainMenu.mainMenu);
	}

	public function toggleHaltSettings():void
	{
		//toggle debug
		CoC_Settings.haltOnErrors = !CoC_Settings.haltOnErrors;
		debugPane();
	}

	public function DebugInfo() {
	}

}
}
