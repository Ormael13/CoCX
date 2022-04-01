package classes {

import classes.GlobalFlags.kFLAGS;
import classes.Appearance;

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
            outputText("\nWhen the scene presents different options for small/big/ dick sizes, adds selectors for the player to choose the exact 'tool' if different options are available. The dick is selected randomly in rape scenes. Also in scenes with options for multicocks and single cock, sometimes lets you choose if you want to use only one.");
            outputText("\n<i>Well, you can change which dick will be used now. Yay. Though some rare scenes (especially small dick femdom) may look slightly weird if you have a bigger cock.</i>");
        }
        else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\nThe biggest <b>fitting</b> dick is always used. Multicocks too.");
        }

        addButton(2, "Other", toggle, kFLAGS.SCENEHUNTER_OTHER);
        outputText("\n\n<b>Other changes</b>: ");
        if (flags[kFLAGS.SCENEHUNTER_OTHER])
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
        else
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
        outputText("\nTweaks which didn't fit into the previous categories. Full list goes here.");
        outputText("\nChristmas elf: enabled sex option even when corrupt.");
        outputText("\nLizan Rogue: medium-corrupt PCs now can persuade Lizan Rogue.");
        outputText("\nNaga <b>after</b> Samirah recruitment: enabled scenes. They're too good to miss.");
        outputText("\n<i>This opens up more scenes. They are lore-accurate and still explained in the game (so you won't get Amily living with corrupt Jojo or other nonsense), but be warned that the original writers intended some details to work the other way.</i>");
        outputText("\n<i>Some one-time scenes with many options and checks can be replayed using 'Camp Actions -> Spend Time -> Recall'.</i>");
        //Scene list link
        addButton(3, "PrintChecks", toggle, kFLAGS.SCENEHUNTER_PRINT_CHECKS);
        outputText("\n\n<b>Print Checks:</b>: ");
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

    //restore the previous text and start the next function
    public function restoreText(textToRestore:String = "", fun:Function = null):void {
        CoC.instance.currentText = textToRestore;
        if (fun != null)
            fun();
    }
    
    //--------------------------------------------------------------------------------------------------
    // UniHerms
    //--------------------------------------------------------------------------------------------------

    public function get uniHerms():Boolean {
        return flags[kFLAGS.SCENEHUNTER_UNI_HERMS];
    }

    /**
    * Prints the dialogue to select the part to use in the scene. Automatically checks if the part exists.
    * If only one option is available, goes with it.
    * If disabled: herm > (cock/vag) > ass
    * @param    dickPriority    Used if uniHerms are disabled. 1 - cock over vag, -1 - vag over cock. 0 - rand. 
    * @param    dickF           Dick button
    * @param    vagF            Vagina button
    * @param    assA            Ass button function. Can be an array, then [0] is the text, and [1] is the function
    * @param    hermF            Herm button
    * @param    dickActive      If false, "dick" button will be disabled.
    * @param    dickDisabledMsg The message to write on the disabled dick button
    */
    public function selectGender(dickF:Function, vagF:Function, assA:* = null, hermF:Function = null, dickPriority:int = 0, dickActive:Boolean = true, dickDisabledMsg:String = ""):void {
        //decomposing ass
        var assText:String = (AssA is Array) ? assA[0] : "Ass";
        var assF:Function = (assA is Function)  ? assA as Function :
                            (assA is Array)     ? assA[1] :
                            null;
        //booleans
        var dickB:Boolean = dickF != null && player.hasCock();
        var vagB:Boolean = vagF != null && player.hasVagina();
        var assB:Boolean = assF != null;
        var hermB:Boolean = hermF != null && player.hasCock() && player.hasVagina();
        //Auto-calls. No auto call when dick is just inactive - player should know!
        if (!(dickB && dickActive) && !vagB && !assB && !(hermB && dickActive)) { //sanity checks
            outputText("<b><u>SceneHunter.selectGender() was called in a wrong way. Please report this.</b></u>");
            goNext(true);
            return;
        }
        /* if ONLY dick is available  - no "active" checks in the first part, should be failsafe
        or if !uniHerms:
            - dick active and higher priority than vag (always higher than ass!!)
            - dick active and no vag */
        if (hermB && (!dickB && !vagB && !assB || !uniHerms) && dickActive) { //!uniherms - auto
            hermF();
            return;
        }
        if (dickB && (!hermB && !vagB && !assB || !uniHerms && (!player.hasVagina() || dickPriority == 1 || dickPriority == 0 && rand(2) == 0)) && dickActive) { //!uniherms - if priority
            dickF();
            return;
        }
        // for !uniHerms: if dick should be called, it was ALREADY called. So call vag anyway, vag > ass
        if (vagB && (!hermB && !dickB && !assB || !uniHerms)) {
            vagF();
            return;
        }
        // with !uniHerms reached only when dick/vag are impossible, call it
        if (assB && (!hermB && !dickB && !vagB || !uniHerms)) {
            assF();
            return;
        }
        //Dialogue
        var beforeText:String = CoC.instance.currentText;
        outputText("\n\n<b>Which part of your body do you want to use?</b>");
        menu();
        if (dickF != null) {
            if (player.hasCock()) {
                if (dickActive)
                    addButton(0, "Dick", restoreText, beforeText, dickF);
                else
                    addButtonDisabled(0, "Dick", dickDisabledMsg);
            }
            else
                addButtonDisabled(0, "Dick", "You don't have any.");
        }
        if (vagF != null) {
            if (player.hasVagina())
                    addButton(1, "Vagina", restoreText, beforeText, vagF);
            else
                addButtonDisabled(1, "Vagina", "You don't have any.");
        }
        if (assF != null)
            addButton(2, assText, restoreText, beforeText, assF);
        if (hermF != null) {
            if (player.hasCock() && player.hasVagina()) {
                if (dickActive) //checking the size here too... though not sure if it should work this way
                    addButton(3, "Herm", restoreText, beforeText, hermF);
                else
                    addButtonDisabled(3, "Herm", dickDisabledMsg);
            }
            else
                addButtonDisabled(3, "Herm", "Not a herm.");
        }
    }

    //--------------------------------------------------------------------------------------------------
    // DickSelect
    //--------------------------------------------------------------------------------------------------

    public function get dickSelect():Boolean { 
        return flags[kFLAGS.SCENEHUNTER_DICK_SELECT];
    }

    /**
    * The dialogue to select fitting or not fitting dick. If dickSelect is disabled, tries to call "fitting" function
    * If doesn't fit, selects the biggest one because HELL WHY NOT.
    * When disabled, overrides "tentacle always fit" behavior.
    * @param    fitF        Function to call when fits
    * @param    nofitF      Function to call when doesn't
    * @param    maxSize     Maximum fitting size
    * @param    compareBy   (Optional) Measurement to compare
    */
    public function selectFitNofit(fitF:Function, nofitF:Function, maxSize:Number, compareBy:String = "area"):void {
        //Auto-calls
        if (!dickSelect) {
            if (player.findCock(1, -1, maxSize, compareBy, false) >= 0)
                fitF();
            else
                nofitF();
            return;
        }
        //Dialogue
        var beforeText:String = CoC.instance.currentText;
        outputText("\n\n<b>Will you use the dick that will certainly fit, or press your luck and try to use a bigger 'tool'?</b>");
        menu();
        //fitting cocks
        if (player.findCock(1, -1, maxSize, compareBy, true) >= 0)
            addButton(0, "Fitting", restoreText, beforeText, fitF);
        else
            addButtonDisabled(0, "Fitting", "Requires dick " + compareBy + " less than " + maxSize);
        //too big
        if (player.findCock(1, maxSize, -1, compareBy, true) >= 0)
            addButton(1, "Too big", restoreText, beforeText, nofitF);
        else
            addButtonDisabled(1, "Too big", "Requires dick " + compareBy + " greater than " + maxSize);
    }

    //Calls the 'fun' function, finding the biggest cock index in selected limits
    public function callFitNofit(fun:Function, max:Number, compareBy:String = "area"):void {
        if (!dickSelect) {
            var x:int = player.cockThatFits(max, compareBy);
            if (x < 0) x = player.smallestCockIndex(); //selecting smallest here, not biggest. Because you disabled me. Ass.
            fun(x);
            return;
        }
        //Invalid calls may be created, but must NEVER be called.
        var fitF:Function   = curry(fun, player.findCock(1, -1, max, compareBy));
        var nofitF:Function = curry(fun, player.findCock(1, max , -1, compareBy)); //selecting bigger here, because you're cool.
        selectFitNofit(fitF, nofitF, max, compareBy);
    }

    /**
    * The dialogue to select one of 3 dick sizes. There's no points in the game when more are used.
    * When disabled, selects the biggest one.
    * Always overrides "tentacles always fit" behavior for 'smaller' options - your 3-foot-long tentacle is not SMALL in any way :)
    * Assumes that you have any fitting dick - no max size for "Big"
    * @param    bigF, mediumF, smallF   Function for "Big", "Medium", "Small" buttons respectively.
    * @param    bigMin, smallMax        Borderline sizes for "Big"-"Medium" and "Medium"-"Small"
    * @param    compareBy               (Optional) Measurement to compare
    * @param    totalMax                Global maximum size - for bigF limitting
    */
    public function selectBigSmall(bigF:Function, bigMin:Number, mediumF:Function, smallMax:Number = -1, smallF:Function = null, compareBy:String = "area", totalMax:Number = -1):void {
        var smallProvided:Boolean = smallMax >= 0 && smallF != null;
        //Auto-calls
        if (!dickSelect) {
            if (player.findCock(1, bigMin, totalMax, compareBy) >= 0)
                bigF();
            else if (player.findCock(1, smallProvided ? smallMax : -1, bigMin, compareBy, false) >= 0) //called even if mediumMin is not provived (-1 = no minimum)
                mediumF();
            else
                smallF(); //if smallMax is provided, smallF MUST be provided too
            return;
        }
        //Dialogue
        var beforeText:String = CoC.instance.currentText;
        outputText("\n\n<b>Will you use a big" + (smallProvided ? ", medium": "") + " or small sized dick?</b>");
        menu();
        //big cocks
        if (player.findCock(1, bigMin, totalMax, compareBy) >= 0)
            addButton(0, "Big", restoreText, beforeText, bigF);
        else
            addButtonDisabled(0, "Big", "Requires dick " + compareBy + " greater than " + bigMin + (totalMax != -1 ? (" but less than " + totalMax) : ""));
        //medium-small
        if (smallProvided) {
            //medium cocks
            if (player.findCock(1, smallMax, bigMin, compareBy, false) >= 0) //tentacles don't fit
                addButton(1, "Medium", restoreText, beforeText, mediumF);
            else
                addButtonDisabled(1, "Medium", "Requires dick " + compareBy + " greater than " + smallMax + " and less than " + bigMin);
            //small cocks
            if (player.findCock(1, -1, smallMax, compareBy, false) >= 0) //tentacles don't fit
                addButton(2, "Small", restoreText, beforeText, smallF);
            else
                addButtonDisabled(2, "Small", "Requires dick " + compareBy + " less than " + smallMax);
        }
        else {
            //replaced "Medium" text with "Small" to avoid player confusion
            if (player.findCock(1, -1, bigMin, compareBy, false) >= 0) //tentacles don't fit
                addButton(1, "Small", restoreText, beforeText, mediumF);
            else
                addButtonDisabled(1, "Small", "Requires dick " + compareBy + " less than " + bigMin);
        }
    }

    //Calls the 'fun' function, finding the biggest cock index in selected limits
    public function callBigSmall(fun:Function, bigMin:Number, smallMax:Number = -1, compareBy:String = "area", totalMax:Number = -1):void {
        if (!dickSelect) {
            fun(player.findCock(1, -1, totalMax, compareBy));
            return;
        }
        //Invalid calls may be created, but must NEVER be called.
        var bigF:Function   = curry(fun, player.findCock(1, bigMin, totalMax, compareBy));
        var mediumF:Function= curry(fun, player.findCock(1, smallMax , bigMin, compareBy));
        var smallF:Function = smallMax > 0 ? curry(fun, player.findCock(1, -1 , smallMax, compareBy)) : null;
        selectBigSmall(bigF, bigMin, mediumF, smallMax, smallF, compareBy, totalMax);
    }

    /**
    * The dialogue to select single cock or multicocks
    * If doesn't fit, selects the biggest one because HELL WHY NOT.
    * When disabled, overrides "tentacle always fit" behavior.
    * @param    singleF     Single cock
    * @param    twoF        Multicock / Two cocks (or more)
    * @param    threeF      (Optional) Three (or more)
    * @param    fourF       (Optional) Four (or more)
    * @param    moreF       (Optional) More (5, 10)
    */
    public function selectSingleMulti(singleF:Function, twoF:Function, threeF:Function = null, fourF:Function = null, compareBy:String = "area", totalMax:Number = -1):void {
        var cnt:int = player.countCocks(-1, totalMax, compareBy);
        //Auto-calls
        if (!dickSelect) {
            if (fourF  != null && cnt >= 4)
                fourF();
            else if (threeF != null && cnt >= 3)
                threeF();
            else if (twoF   != null && cnt >= 2)
                fourF();
            else if (singleF != null)
                singleF();
            return;
        }
        //If single, no bother
        if (cnt == 1) {
            print("Failed: multicock check");
            singleF();
            return;
        }
        //Dialogue
        var beforeText:String = CoC.instance.currentText;
        outputText("\n\n<b>Since you have several cocks, will you use more at the same time to get more pleasure, or try to use less hoping for a better treatment?</b>");
        //menu
        menu();
        if (singleF != null)
            addButton(1, "Single", restoreText, beforeText, singleF);
        if (twoF != null) {
            if (cnt >= 2)
                addButton(2, "Two", restoreText, beforeText, twoF);
            else
                addButtonDisabled(2, "Two", "Not enough.");
        }
        if (threeF != null) {
            if (cnt >= 3)
                addButton(2, "Three", restoreText, beforeText, threeF);
            else
                addButtonDisabled(2, "Three", "Not enough.");
        }
        if (fourF != null) {
            if (cnt >= 4)
                addButton(3, "Four", restoreText, beforeText, fourF);
            else
                addButtonDisabled(3, "Four", "Not enough.");
        }
    }
    
    //--------------------------------------------------------------------------------------------------
    // Other
    //--------------------------------------------------------------------------------------------------

    public function get other():Boolean {
        return flags[kFLAGS.SCENEHUNTER_OTHER];
    }
    //nothing more here for now... Will it just check the value, or new next will be here too?
    
    //--------------------------------------------------------------------------------------------------
    // PrintChecks
    //--------------------------------------------------------------------------------------------------

    public function get printChecks():Boolean {
        return flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS];
    }

    public function print(text:String):void {
        if (printChecks)
            outputText("\n<b>" + text + "</b>\n");
    }

    //Some common checks for easier access
    
    //Prints dick requirements if not found
    public function check_dick_typed(type:CockTypesEnum, minSize:Number = -1, maxSize:Number = -1, compareBy:String = "area", moreText:String = ""):void {
        if (printChecks && player.findCockWithType(type, 1, minSize, maxSize, compareBy) < 0) {
            outputText("\n\n<b>FAILED DICK CHECK:")
            if (type != CockTypesEnum.UNDEFINED)
                outputText("\n    Type: " + Appearance.cockNoun(type));
            if (minSize != -1)
                outputText("\n    Min " + compareBy + ": " + minSize);
            if (maxSize != -1)
                outputText("\n    Max " + compareBy + ": " + maxSize);
            if (moreText)
                outputText("\n" + moreText);
            outputText("</b>\n\n")
        }
    }
    public function check_dick(minSize:Number = -1, maxSize:Number = -1, compareBy:String = "area", moreText:String = ""):void {
        check_dick_typed(CockTypesEnum.UNDEFINED, minSize, maxSize, compareBy, moreText);
    }
    
    //Prints dick requirements if not found
    public function check_race(race:String):void {
        if (printChecks && player.race() != race) {
            outputText("\n\n<b>FAILED RACE CHECK:")
            outputText("\n    Expected: " + race);
            outputText("</b>\n\n")
        }
    }
}
}