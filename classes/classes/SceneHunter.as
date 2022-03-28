package classes {

import classes.GlobalFlags.*;
import coc.view.MainView;
import coc.view.StatsView;
import flash.display.StageQuality;
import flash.text.TextFormat;
import classes.internals.SaveableState;

public class SceneHunter extends BaseContent {
    public function settingsPage():void {
        clearOutput();
        menu();
		displayHeader("SceneHunter Settings - WIP");
        outputText("The following are QoL improvements meant to make some scenes (and their variations) easier to access.");
        outputText("\nAll these features blend into the game (almost) seamlessly, are lore-accurate and don't change anything gameplay-related.");
        
        addButton(0, "UniHerms", toggle, kFLAGS.SCENEHUNTER_UNI_HERMS);
        outputText("\n\n<b>Universal Herms</b>: ");
        if (flags[kFLAGS.SCENEHUNTER_UNI_HERMS]) {
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
            outputText("\nMakes scenes unique to male/female PCs accessible to herms. Allows the player to choose the scene when the sex is led by the PC, randomly selects it in rape scenes.");
            outputText("\n<i>New scenes lack the description of herm's other genitalia. Some scenes may look slightly off (rare).</i>");
        }
        else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\nHerms don't get any new scenes.");
        }

        addButton(1, "DickSelect", toggle, kFLAGS.SCENEHUNTER_DICK_SELECT);
        outputText("\n\n<b>Dick Select</b>: ");
        if (flags[kFLAGS.SCENEHUNTER_DICK_SELECT]) {
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
            outputText("\nWhen the scene presents different options for small/big/TOO big dick sizes, adds selectors for the player to choose the exact 'tool' if different options are available. The dick is selected randomly in rape scenes.");
            outputText("\n<i>Well, you can change which dick will be used now. Yay. Though some rare scenes (especially small dick femdom) may look slightly weird if you have a bigger cock.</i>");
        }
        else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\nThe biggest <b>fitting</b> dick is always used.");
        }

        addButton(2, "MutEx Scenes", toggle, kFLAGS.SCENEHUNTER_MUTEX_SCENES);
        outputText("\n\n<b>Mutually exclusive scenes</b>: ");
        if (flags[kFLAGS.SCENEHUNTER_MUTEX_SCENES]) {
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
            outputText("\nSome originally mutually exclusive scenes (when you've selected one scene, you'll never access the other one in this playthrough) are no longer mutually exclusive.");
            outputText("\n<i>This opens up more scenes, but <b>some</b> of them may look off. They are still explained in the game, but be warned that the original writers intended otherwise.</i>");
        }
        else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\n...stay mutually exclusive, as intended by the writers...");
            outputText("\n<i>Some one-time scenes with different options can still be replayed using 'Camp Actions -> Spend Time -> Recall'.</i>");
        }
        outputText("\nNPCs with MutEx scenes: Lottie, Whitney...");
        //Scene list link
        addButton(3, "Printing", toggle, kFLAGS.SCENEHUNTER_PRINT_CHECKS);
        outputText("\n\n<b>Check printing</b>: ");
        if (flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS]) {
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
            outputText("\nSome failed race, dick size and other attribute checks are explicitly printed in the middle of the scene.");
            outputText("\n<i>Can be a little immersion-breaking, but helps you understand when you're missing some secret requirements.</i>");
        }
        else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\nNo extra information is printed, you'll have to find new race-specific scenes yourself");
        }

        addButton(5, "Scene List", openURL, "https://cocxianxia.fandom.com/wiki/Conditional_Scenes");
        outputText("\n\n<b>Conditional Scenes list:</b> <u><a href='https://cocxianxia.fandom.com/wiki/Conditional_Scenes'>https://cocxianxia.fandom.com/wiki/Conditional_Scenes</a></u>");
        outputText("\n<i>This list contains minor spoilers for the entirety of the game. You've been warned.</i>");

        addButton(6, "Reference", openURL, "https://cocxianxia.fandom.com/wiki/Scene_Reference");
        outputText("\n\n<b>Scene Reference:</b> <u><a href='https://cocxianxia.fandom.com/wiki/Scene_Reference'>https://cocxianxia.fandom.com/wiki/Scene_Reference</a></u>");
        outputText("\n<i>This list contains <b>major</b> spoilers for the entirety of the game. You've been warned.</i>");

        addButton(9, "Back", CoC.instance.gameSettings.settingsScreenMain);
    }

	public function toggle(flag:int):void {
		flags[flag] = !flags[flag];
		settingsPage();
	}
    
}
}
//CHARVIEW_ARMOR_HIDDEN