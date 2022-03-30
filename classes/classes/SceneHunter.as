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
            outputText("\nMakes scenes unique to male/female genders accessible to herms. Allows player to choose the scene when the sex is driven by PC, randomly selects it in rape scenes.");
            outputText("\n<i>New scenes lack the description of herm's other genitalia. Some scenes may look slightly off (rare).</i>");
        }
        else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\nHerms doesn't get any new scenes.");
        }

        addButton(1, "DickSelect", toggle, kFLAGS.SCENEHUNTER_DICK_SELECT);
        outputText("\n\n<b>Dick Select</b>: ");
        if (flags[kFLAGS.SCENEHUNTER_DICK_SELECT]) {
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
            outputText("\nWhen the scene presents different options for small / big / TOO big dick sizes, adds selectors for the player to choose the exact 'tool' if different options are available. The dick is selected randomly in rape scenes.");
            outputText("\n<i>Well, you can select the dick to use now. Yay. Though some rare scenes (especially small dick femdom) may look slightly weird if you have a bigger cock.</i>");
        }
        else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\nThe biggest <b>fitting</b> dick is always used.");
        }

        addButton(2, "MutEx Scenes", toggle, kFLAGS.SCENEHUNTER_MUTEX_SCENES);
        outputText("\n\n<b>Mutually exclusive scenes</b>: ");
        if (flags[kFLAGS.SCENEHUNTER_MUTEX_SCENES]) {
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
            outputText("\nSome originally mutually exclusive scenes (when you've selected one scene, you'll never access the other one in this playthrough) are NOT exclusive now.");
            outputText("\n<i>This opens up more different scenes, but <b>some</b> of them may look off. They are still explained in the game, but be warned that original writers intended otherwise.</i>");
        }
        else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\n...stay mutually exclusive, as intended by the writers..");
            outputText("\n<i>Some one-time scenes with different options can still be replayed using 'Camp Actions -> Spend Time -> Recall' menu.</i>");
        }
        outputText("\nNPCs with MutEx scenes: Lottie, Whitney...");
        //Scene list link
        addButton(3, "PrintChecks", toggle, kFLAGS.SCENEHUNTER_PRINT_CHECKS);
        outputText("\n\n<b>Print Checks:</b>: ");
        if (flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS]) {
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
            outputText("\nSome race, dick size and other attributes (failed) checks are explicitly printed in the middle of the scene.");
            outputText("\n<i>Can be a little immersion-breaking, but helps to understand when you miss some secret requirements.</i>");
        }
        else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\nNo extra information is printed, you'll have find new race-specific scenes yourself");
        }

        addButton(5, "Scene List", openURL, "https://cocxianxia.fandom.com/wiki/Conditional_Scenes");
        outputText("\n\n<b>Conditional Scenes list:</b> <u><a href='https://cocxianxia.fandom.com/wiki/Conditional_Scenes'>https://cocxianxia.fandom.com/wiki/Conditional_Scenes</a></u>");
        outputText("\n<i>The list contains minor spoilers for the entirety of the game. You've been warned.</i>");

        addButton(6, "Reference", openURL, "https://cocxianxia.fandom.com/wiki/Scene_Reference");
        outputText("\n\n<b>Scene Reference:</b> <u><a href='https://cocxianxia.fandom.com/wiki/Scene_Reference'>https://cocxianxia.fandom.com/wiki/Scene_Reference</a></u>");
        outputText("\n<i>The list contains <b>major</b> spoilers for the entirety of the game. You've been warned.</i>");

        addButton(9, "Back", CoC.instance.gameSettings.settingsScreenMain);
    }

	public function toggle(flag:int):void {
		flags[flag] = !flags[flag];
		settingsPage();
	}

    public function get uniHerms():Boolean {
        return flags[kFLAGS.SCENEHUNTER_UNI_HERMS];
    }

    public function get dickSelect():Boolean {
        return flags[kFLAGS.SCENEHUNTER_DICK_SELECT];
    }

    public function get mutExScenes():Boolean {
        return flags[kFLAGS.SCENEHUNTER_MUTEX_SCENES];
    }

    public function get printChecks():Boolean {
        return flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS];
    }
    
    //--------------------------------------------------------------------------------------------------
    // UniHerms
    //--------------------------------------------------------------------------------------------------

    /**
    * Prints the dialogue to select the part to use in the scene. Automatically checks if the part exists.
    * If only one option is available, goes with it.
    * @param    dickPriority    Used if uniHerms are disabled. If true, selects dick option (if possible). False - vag or ass.
                                Vag is always "better" than ass.
    * @param    dickF           Functions to call for dick, vag, ass buttons. Buttons are not displayed when "null"
    * @param    vagF
    * @param    assF
    * @param    dickActive      If false, "dick" button will be disabled.
    * @param    dickDisabledMsg The message to write on the disabled dick button
    */
    public function selectPart(dickF:Function, vagF:Function, assF:Function = null, dickActive:Boolean = true, dickDisabledMsg:String = "", dickPriority:Boolean = true):void {
        var beforeText:String = CoC.instance.currentText;
        //Auto-calls. No auto call when dick is just inactive - player should know!
        if (!(dickF && player.hasCock() && dickActive) && !(vagF && player.hasVagina()) && !assF) { //sanity checks
            if (dickF && player.hasCock() && !dickActive)
                outputText("<b><u>SceneHunter.selectPart() was called, but the ONLY option - dick - is disabled. Please report this.</b></u>");
            else
                outputText("<b><u>SceneHunter.selectPart() was called in a wrong way. Please report this.</b></u>");
            goNext(true);
            return;
        }
        /* if ONLY dick is available  - no "active" checks in the first part, should be failsafe
        or if !uniHerms:
            - dick active and higher priority than vag (always higher than ass!!)
            - dick active and no vag */
        if ((dickF && player.hasCock()) && (!(vagF && player.hasVagina()) && !assF || !uniHerms && dickActive && (dickPriority || !player.hasVagina()))) {
            dickF();
            return;
        }
        // for !uniHerms: if dick should be called, it was ALREADY called. So call vag anyway, vag > ass
        if ((vagF && player.hasVagina()) && (!(dickF && player.hasCock()) && !assF || !uniHerms))) {
            vagF();
            return;
        }
        // with !uniHerms reached only when dick/vag are impossible, call it
        if (!(dickF && player.hasCock()) && !(vagF && player.hasVagina()) && assF || !uniHerms) {
            assF();
            return;
        }
        //Dialogue
        outputText("\n\n<b>Which part of your body do you want to use?</b>")
        menu();
        if (dickF) {
            if (player.hasCock()) {
                if (dickActive)
                    addButton(0, "Dick", sh_continue, dickF, beforeText);
                else
                    addButtonDisabled(0, "Dick", dickDisabledMsg);
            }
            else
                addButtonDisabled(0, "Dick", "You don't have any.");
        }
        if (vagF) {
            if (player.hasVagina())
                    addButton(1, "Vagina", sh_continue, vagF, beforeText);
            else
                addButtonDisabled(1, "Vagina", "You don't have any.");
        }
        if (assF)
            addButton(2, "Ass", sh_continue, assF, beforeText);
    }

    //restore the previous text and start the next function
    public function sh_continue(fun:Function, textToRestore:String = ""):void {
        CoC.instance.currentText = textToRestore;
        fun();
    }

    //--------------------------------------------------------------------------------------------------
    // DickSelect
    //--------------------------------------------------------------------------------------------------
    /**
    * Prints the dialogue to select the dick to use in the scene.
    * If only one option is available, goes with it.
    * @param    fitF   Functio
    * @param    
    * @param    assF
    * @param    dickActive          If false, "dick" button will be disabled.
    * @param    dickDisabledMsg     The message to write on the disabled dick button
    */
    /*
    public function selectDickFit(dickF:Function, vagF:Function, assF:Function = null, dickActive:Boolean = true, dickDisabledMsg:String = ""):void {
        var beforeText:String = CoC.instance.currentText;
        outputText("\n\n<b>Which part of your body do you want to use?</b>")
        menu();
        if (dickF) {
            if (player.hasCock()) {
                if (dickActive)
                    addButton(0, "Dick", uh_continue, dickF, beforeText);
                else
                    addButtonDisabled(0, "Dick", dickDisabledMsg);
            }
            else
                addButtonDisabled(0, "Dick", "You don't have any.");
        }
        if (vagF) {
            if (player.hasVagina())
                    addButton(1, "Vagina", uh_continue, vagF, beforeText);
            else
                addButtonDisabled(1, "Vagina", "You don't have any.");
        }
        if (assF)
            addButton(2, "Ass", uh_continue, assF, beforeText);
    }
*/
}
}
//CHARVIEW_ARMOR_HIDDEN