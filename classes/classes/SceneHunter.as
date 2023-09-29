package classes {
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Dungeons.D3.IncubusMechanicScenes;
import classes.Scenes.Dungeons.DemonLab;
import classes.Scenes.NPCs.BelisaFollower;
import classes.Scenes.NPCs.CelessScene;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.NPCs.LilyFollower;
import classes.Scenes.NPCs.PatchouliScene;
import classes.Scenes.SceneLib;

public class SceneHunter extends BaseContent {
    public function settingsPage():void {
        clearOutput();
        menu();
        displayHeader("SceneHunter Settings");
        outputText("The following are QoL improvements meant to make some scenes (and their variations) easier to access.");
        outputText("\nAll these features blend into the game (almost) seamlessly, are lore-accurate and don't change anything gameplay-related.");
        outputText("\nSH checks are currently added into all parts of the game, excluding worms content.");
        outputText("\n\n<b>If you notice any bugs (missing options, weirdness in scenes, dead ends) caused by enabling/disabling any of SH options (or ANY new issues in the scenes listed above), please report it in Discord and it will be fixed quickly. A lot of code was moved whiile setting SH up, so it was very easy to miss something.</b>");

        addButton(0, "UniHerms", toggle, kFLAGS.SCENEHUNTER_UNI_HERMS);
        outputText("\n\n<b>Universal Herms:</b> ");
        if (flags[kFLAGS.SCENEHUNTER_UNI_HERMS]) {
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
            outputText("\nMakes scenes unique to male/female PCs accessible to herms. Allows the player to choose the scene when the sex is led by the PC, randomly selects it in rape scenes.");
            outputText("\nAlso adjusted some genderless (anal/oral only) scenes, so they will look fitting - no genderless mentions or jokes.");
            outputText("\n<i>New scenes may lack the description of herm's other genitalia. Some scenes may look slightly off (rare).</i>");
        } else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\nHerms don't get any new scenes.");
        }

        addButton(1, "DickSelect", toggle, kFLAGS.SCENEHUNTER_DICK_SELECT);
        outputText("\n\n<b>Dick Select:</b> ");
        if (flags[kFLAGS.SCENEHUNTER_DICK_SELECT]) {
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
            outputText("\nWhen the scene presents different options for small/big/ dick sizes, adds selectors for the player to choose the exact 'tool' if different options are available. The dick is selected randomly in rape scenes. Also in scenes with options for multicocks and single cock, sometimes lets you choose if you want to use only one.");
            outputText("\n<i>Well, you can change, which dick will be used now. Yay. Though some rare scenes (especially small dick femdom) may look slightly weird if you have a bigger cock.</i>");
        } else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\nThe biggest <b>fitting</b> dick is always used. Multicocks too.");
        }

        addButton(2, "LossSelect", toggle, kFLAGS.SCENEHUNTER_LOSS_SELECT);
        outputText("\n\n<b>Loss Select:</b> ");
        if (flags[kFLAGS.SCENEHUNTER_LOSS_SELECT]) {
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
            outputText("\nSome scenes with many loss variations will allow you to select the specific scene. Works best in conjunction with UniHerms or Dick select, which open more scenes.");
            outputText("\n<i>Wait, it's illegal, the monster should choose how to rape you... fuck the RNG!</i>");
        } else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\nAll loss scenes are selected randomly, their conditions are <b>hidden</b>. PrintChecks feature will <b>not</b> print anything for some.");
        }

        addButton(3, "MockFights", toggle, kFLAGS.SCENEHUNTER_MOCK_FIGHTS);
        outputText("\n\n<b>Mock Fights:</b> ");
        if (flags[kFLAGS.SCENEHUNTER_MOCK_FIGHTS]) {
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
            outputText("\nYou can 'mock-fight' some camp NPCs to recall their rape scenes.");
            outputText("\n<i>They will behave as if they were never recruited... let's consider it a part of the roleplay, huh?</i>");
        } else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\nYou can't recall win/lose rape scenes for your camp NPCs.");
        }

        addButton(4, "PrintChecks", toggle, kFLAGS.SCENEHUNTER_PRINT_CHECKS);
        outputText("\n\n<b>Print Checks:</b> ");
        if (flags[kFLAGS.SCENEHUNTER_PRINT_CHECKS]) {
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
            outputText("\nSome failed race, dick size and other attribute checks are explicitly printed in the middle of the scene.");
            outputText("\n<i>Can be a little immersion-breaking, but helps you understand when you're missing some secret requirements.</i>");
        } else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\nNo extra information is printed, you'll have to find new race-specific scenes yourself.");
        }

        addButton(5, "Other", toggle, kFLAGS.SCENEHUNTER_OTHER);
        outputText("\n\n<b>Other changes:</b> ");
        if (flags[kFLAGS.SCENEHUNTER_OTHER])
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
        else
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
        outputText("\nTweaks that didn't fit into any previous category. Full list goes here.");
        outputText("\n- Corruption Tolerance: works twice as effective (10 per perk point).");
        outputText("\n- Christmas elf: enabled sex option even when corrupt.");
        outputText("\n- Lizan Rogue: medium-corrupt PCs now can persuade Lizan Rogue.");
        outputText("\n- Naga <b>after</b> Samirah recruitment: enabled scenes. They're too good to miss.");
        outputText("\n- Green slime: removed rape corruption checks.");
        outputText("\n- Gnoll: disabled dick size requirements in multicock anal. Because why not?");
        outputText("\n- Unicorn: Celess can be 'recruited' after fucking the unicorn. Meant for people who don't feel the overwhelming love for horsecocks and gender-changing, but still want their legendary equipment.");
        outputText("\n- Nightmare: The encounter can be postponed. It'll probably be annoying though..");
        outputText("\n- Benoit: can be feminized even after having sex with. The talk should start automatically when PC has a vagina & Benoit's affection is higher than 40.");
        outputText("\n- Benoite ('Femoit'): when impregnating her, you can select the size of the resultant clutch.");
        outputText("\n- Imps - 'regular' imp menu now accesible from imp lord/overlord menu.");
        outputText("\n- Whitney - can switch between sub and dom and reset oral training stages.");
        outputText("\n- Lottie - allows to repeat one-time min/max scenes, unlocking more sex options. Also removes the conditions from repeating scenes in her sex menu.");
        outputText("\n- Izma(el) - enables the options to turn Izma into Izmael or remove her dick <b>after</b> reverting her from bro state.");
        outputText("\n- Kiha - corruption thresholds for talking and first sex are raised to 66 because I still want my dragon waifu around :3");
        outputText("\n- Kiha, Sheila - rape scene is triggered not only if they have high lust, but also if you have high enough libido.");
        outputText("\n- Marble - all three 'Fuck Her' scenes can be accessed by selector.");
        outputText("\n- Lianna's LubeSpray can be bought in HeXinDao (description changes) for easier access.");
        outputText("\n- Urta - affection doesn't decay overtime anymore.");
        outputText("\n- Urta's quest, final scene - all follower lines are enabled at the same time (was random from 5 options before).");
        outputText("\n- 'Recall' - opens up alt versions of some scenes that probably nobody wants to see normally, but still might be interesting.");
        outputText("\n- The cabin doesn't disable imp attacks anymore. You still can build a wall or something else though.");
        outputText("\n- Disables Raphael dress timer - you can't fail his date by not wearing it.");
        outputText("\n- Disables Zenji vs Celess freakout. Stupid troll shouldn't ask you to kill your daughter.");
        outputText("\n<i>Most changes are lore-accurate and explained in the game (so everything feels logical), but be warned that the original writers probably intended some details to work the other way.</i>");
        outputText("\n<i>Some one-time scenes with many options and checks can be replayed using 'Camp Actions > Spend Time > Recall'.</i>");

        outputText("\n\n<b><u>SAVE-RELATED FLAGS</u></b>\n");
        outputText("The following flags are applied to the save - you <b>must</b> be <i>in a game session</i> (e.g. load your save, hit \"Main Menu\", change them. If you load a save, they will be set to the saved values.");
        addButton(6, "Polygamy", togglePolygamy)
            .disableIf(!player, "Requires a loaded save. Set to 0 at the start of the game.");
        outputText("\n\n<b>Polygamy:</b> ");
        if (polygamy) {
            outputText("<b><font color=\"#008000\">ENABLED</font></b>");
            outputText("\nYou can marry everyone at the same time.");
            outputText("\n<i>Of course, scenes don't include anything related to this. The mentions of 'love and fidelity' will be present in all marriage scenes.</i>");
        } else {
            outputText("<b><font color=\"#800000\">DISABLED</font></b>");
            outputText("\nYou can marry only one person, like in a <i>completely normal</i> world which Mareth is.");
        }

        addButton(10, "Scene List", openURL, "https://cocxianxia.fandom.com/wiki/Conditional_Scenes");
        outputText("\n\n<b>Conditional Scenes list:</b> <u><a href='https://cocxianxia.fandom.com/wiki/Conditional_Scenes'>https://cocxianxia.fandom.com/wiki/Conditional_Scenes</a></u>");
        outputText("\n<i>This list contains minor spoilers for the entirety of the game. You've been warned.</i>");

        addButton(11, "Reference", openURL, "https://cocxianxia.fandom.com/wiki/Scene_Reference");
        outputText("\n\n<b>Scene Reference:</b> <u><a href='https://cocxianxia.fandom.com/wiki/Scene_Reference'>https://cocxianxia.fandom.com/wiki/Scene_Reference</a></u>");
        outputText("\n<i>This list contains <b>major</b> spoilers for the entirety of the game. You've been warned.</i>");

        addButton(14, "Back", CoC.instance.gameSettings.settingsScreenMain);
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
        return _passCheck || flags[kFLAGS.SCENEHUNTER_UNI_HERMS];
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
    public function selectGender(dickF:Function, vagF:Function, assA:* = null, hermF:Function = null,
                                 dickPriority:int = 1, dickActive:Boolean = true, dickDisabledMsg:String = ""):void {
        //decomposing ass
        var assText:String = (assA is Array) ? assA[0] : "Ass";
        var assF:Function = (assA is Function) ? assA as Function :
            (assA is Array) ? assA[1] :
                null;
        //booleans
        var dickB:Boolean = dickF != null && player.hasCock();
        var vagB:Boolean = vagF != null && player.hasVagina();
        var assB:Boolean = assF != null;
        var hermB:Boolean = hermF != null && player.hasCock() && player.hasVagina();
        //Auto-calls. No auto call when dick is just inactive — player should know!
        if (!(dickB && dickActive) && !vagB && !assB && !(hermB && dickActive)) { //sanity checks
            outputText("<b><u>SceneHunter.selectGender() was called in a wrong way. Please report this.</b></u>");
            doNext(playerMenu);
            return;
        }
        /* if ONLY dick is available  — no "active" checks in the first part, should be failsafe
        or if !uniHerms:
            — dick active and higher priority than vag (always higher than ass!!)
            — dick active and no vag */
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
            } else
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
            } else
                addButtonDisabled(3, "Herm", "Not a herm.");
        }
        _passCheck = false; //reset one-time check skipper
    }

    //--------------------------------------------------------------------------------------------------
    // DickSelect
    //--------------------------------------------------------------------------------------------------

    public function get dickSelect():Boolean {
        return _passCheck || flags[kFLAGS.SCENEHUNTER_DICK_SELECT];
    }

    /**
     * The dialogue to select fitting or not fitting dick. If dickSelect is disabled, tries to call "fitting" function
     * If doesn't fit, selects the biggest one because HELL WHY NOT.
     * @param    fitF        Function to call when fits
     * @param    nofitF      Function to call when doesn't
     * @param    maxSize     Maximum fitting size
     * @param    compareBy   (Optional) Measurement to compare
     */
    public function selectFitNofit(fitF:Function, nofitF:Function, maxSize:Number, compareBy:String = "area"):void {
        //Auto-calls
        if (!dickSelect) {
            if (player.findCock(1, -1, maxSize, compareBy) >= 0) {
                print("Failed/passed size check - dick fits, but you certainly can try to use something <i>bigger</i> than " + maxSize + " " + compareBy);
                fitF();
            } else {
                print("Failed/passed size check - dick doesn't fit " + maxSize + " " + compareBy);
                nofitF();
            }
            return;
        }
        //Dialogue
        var beforeText:String = CoC.instance.currentText;
        outputText("\n\n<b>Will you use the dick that will certainly fit, or press your luck and try to use a bigger 'tool'?</b>");
        menu();
        //fitting cocks
        if (player.findCock(1, -1, maxSize, compareBy) >= 0)
            addButton(0, "Fitting", restoreText, beforeText, fitF);
        else
            addButtonDisabled(0, "Fitting", "Requires dick " + compareBy + " less than " + maxSize);
        //too big
        if (player.findCock(1, maxSize, -1, compareBy) >= 0)
            addButton(1, "Too big", restoreText, beforeText, nofitF);
        else
            addButtonDisabled(1, "Too big", "Requires dick " + compareBy + " greater than " + maxSize);
        _passCheck = false; //reset one-time check skipper
    }

    //Calls the 'fun' function, finding the biggest cock index in selected limits
    public function callFitNofit(fun:Function, max:Number, compareBy:String = "area"):void {
        //Invalid calls may be created, but must NEVER be called.
        var fitF:Function = curry(fun, player.findCock(1, -1, max, compareBy));
        var nofitF:Function = curry(fun, player.findCock(1, max, -1, compareBy)); //selecting bigger here, because you're cool.
        selectFitNofit(fitF, nofitF, max, compareBy);
    }

    /**
     * The dialogue to select one of 3 dick sizes. There's no points in the game when more are used.
     * When disabled, selects the biggest one.
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
            if (player.findCock(1, bigMin, totalMax, compareBy) >= 0) {
                print("Passed? Size check, but alt scene available for dicks smaller than " + bigMin + " " + compareBy);
                bigF();
            } else if (player.findCock(1, smallProvided ? smallMax : -1, bigMin, compareBy) >= 0) {
                print("Failed size check, dick must be bigger than " + bigMin + " " + compareBy);
                if (smallProvided) print("Passed? Another size check, but alt scene available for dicks smaller than " + smallMax + " " + compareBy);
                mediumF();
            } else {
                print("Failed 2 size checks, dick must be bigger than " + smallMax + " or " + bigMin + " " + compareBy);
                smallF(); //if smallMax is provided, smallF MUST be provided too
            }
            return;
        }
        //Dialogue
        var beforeText:String = CoC.instance.currentText;
        outputText("\n\n<b>Will you use a big" + (smallProvided ? ", medium" : "") + " or small sized dick?</b>");
        menu();
        //big cocks
        if (player.findCock(1, bigMin, totalMax, compareBy) >= 0)
            addButton(0, "Big", restoreText, beforeText, bigF);
        else
            addButtonDisabled(0, "Big", "Requires dick " + compareBy + " greater than " + bigMin + (totalMax != -1 ? (" but less than " + totalMax) : ""));
        //medium-small
        if (smallProvided) {
            //medium cocks
            if (player.findCock(1, smallMax, bigMin, compareBy) >= 0) //tentacles don't fit
                addButton(1, "Medium", restoreText, beforeText, mediumF);
            else
                addButtonDisabled(1, "Medium", "Requires dick " + compareBy + " greater than " + smallMax + " and less than " + bigMin);
            //small cocks
            if (player.findCock(1, -1, smallMax, compareBy) >= 0) //tentacles don't fit
                addButton(2, "Small", restoreText, beforeText, smallF);
            else
                addButtonDisabled(2, "Small", "Requires dick " + compareBy + " less than " + smallMax);
        } else {
            //replaced "Medium" text with "Small" to avoid player confusion
            if (player.findCock(1, -1, bigMin, compareBy) >= 0) //tentacles don't fit
                addButton(1, "Small", restoreText, beforeText, mediumF);
            else
                addButtonDisabled(1, "Small", "Requires dick " + compareBy + " less than " + bigMin);
        }
        _passCheck = false; //reset one-time check skipper
    }

    //Calls the 'fun' function, finding the biggest cock index in selected limits
    public function callBigSmall(fun:Function, bigMin:Number, smallMax:Number = -1, compareBy:String = "area", totalMax:Number = -1):void {
        //Invalid calls may be created, but must NEVER be called.
        var bigF:Function = curry(fun, player.findCock(1, bigMin, totalMax, compareBy));
        var mediumF:Function = curry(fun, player.findCock(1, smallMax, bigMin, compareBy));
        var smallF:Function = smallMax > 0 ? curry(fun, player.findCock(1, -1, smallMax, compareBy)) : null;
        selectBigSmall(bigF, bigMin, mediumF, smallMax, smallF, compareBy, totalMax);
    }

    /**
     * The dialogue to select single cock or multicocks
     * If doesn't fit, selects the biggest one because HELL WHY NOT.
     * @param    singleF     Single cock
     * @param    multiF      Multiple cocks
     * @param    compareBy   (Optional) Measurement to compare
     * @param    maxSize     Maximum size for the first dick. -1 (default) = limitless
     * @param    maxSize2    Maximum size for the second dick. -2 (default) - use the same, -1 = limitless.
     */
    public function selectSingleMulti(singleF:Function, multiF:Function, compareBy:String = "area", maxSize:Number = -1, maxSize2:Number = -2):void {
        if (maxSize2 == -2) maxSize2 = maxSize;
        var first:int = player.findCock(1, -1, maxSize, compareBy);
        var multiEn:Boolean = player.findCockNotIn([first], 1, -1, maxSize2, compareBy) >= 0; //try to find the second one
        //Auto-calls
        if (!dickSelect) {
            if (!multiEn) {
                print("Failed check: multiple fitting cocks.");
                singleF();
            } else multiF();
            return;
        }
        //Dialogue
        var beforeText:String = CoC.instance.currentText;
        outputText("\n\n<b>Will you try to use more cocks at the same time to get more pleasure, or only one hoping for a better treatment?</b>");
        //menu
        menu();
        addButton(0, "Single", restoreText, beforeText, singleF);
        addButton(1, "Multiple", restoreText, beforeText, multiF)
            .disableIf(!multiEn, "Not enough dicks." + (maxSize2 >= 0 ? "Requires another cock fitting "+maxSize2+" "+compareBy : ""));
        _passCheck = false; //reset one-time check skipper
    }

    //--------------------------------------------------------------------------------------------------
    // SelectLoss
    //--------------------------------------------------------------------------------------------------

    public function get lossSelect():Boolean {
        return _passCheck || flags[kFLAGS.SCENEHUNTER_LOSS_SELECT];
    }

    /**
     * Loss scene selection menu. Selects the scene randomly if disabled. Each array item can be composed as:
     * Button: [position, "Name", function]
     * Disabled button: [position, "Name", null]
     * Button with condition: [position, "Name", function, "disabled tooltip", condition, "enabled tooltip"]
     * @param    options    Scene array
     * @param    msg        Message to print before menu
     */
    public function selectLossMenu(options:Array, msg:String = ""):void {
        var choices:Array = []; //enabled functions
        //init when enabled
        if (lossSelect) {
            outputText(msg);
            menu();
        }
        //select choices or add buttons
        for (var i:int = 0; i < options.length; ++i) {
            var arr:Array = options[i] as Array;
            if (arr == null) throw new Error("selectLossMenu called with non-array arguments!");
            //button
            if (arr.length == 3) {
                if (lossSelect) {
                    if (arr[2] == null) addButtonDisabled(arr[0], arr[1], "");
                    else addButton.apply(this, arr);
                } else if (arr[2] != null)
                    choices.push(arr[2]);
            }
            //condition
            else if (arr.length >= 5 && arr.length <= 6) {
                if (lossSelect)
                    addButtonIfTrue.apply(this, arr);
                else {
                    if (arr[4]) //check condition
                        choices.push(arr[2]);
                    else print("Loss scene (random) check failed: " + arr[3]); //print msg if printer is enabled
                }
            } else throw new Error("selectLossMenu - argument length mismatch!");
        }
        //if disabled, just select random choice
        if (!lossSelect)
            choices[rand(choices.length)]();
        _passCheck = false; //reset one-time check skipper
    }

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

    //--------------------------------------------------------------------------------------------------
    // Polygamy
    //--------------------------------------------------------------------------------------------------

    //flag bits
    public static const POLYGAMY_ENABLED    :int = 1 << 0; //enabled flag
    public static const POLYGAMY_CHICHI     :int = 1 << 1; //saves who you were married to
    public static const POLYGAMY_ETNA       :int = 1 << 2;
    public static const POLYGAMY_ZENJI      :int = 1 << 2;
    public static const POLYGAMY_ALVINA     :int = 1 << 3;
    public static const POLYGAMY_KIHA       :int = 1 << 4;
    public static const polyBits:Object = {
        "Chi Chi": POLYGAMY_CHICHI,
        "Etna": POLYGAMY_ETNA,
        "Zenji": POLYGAMY_ZENJI,
        "Alvina": POLYGAMY_ALVINA,
        "Kiha": POLYGAMY_KIHA
    }

    public function get polygamy():Boolean {
        return Boolean(flags[kFLAGS.SCENEHUNTER_POLYGAMY] & POLYGAMY_ENABLED);
    }

    //Checks if the player can marry someone.
    public function canMarry():Boolean {
        return Boolean(!flags[kFLAGS.MARRIAGE_FLAG] || polygamy);
    }

    public function marry(name:String):void {
        if (!polygamy) flags[kFLAGS.MARRIAGE_FLAG] = name;
        if (!polyBits.hasOwnProperty(name)) CoC_Settings.error("Married "+name+" without registering them in SceneHunter.");
        else flags[kFLAGS.SCENEHUNTER_POLYGAMY] |= polyBits[name];
    }

    public function married(name:String):Boolean {
        if (!polygamy) return flags[kFLAGS.MARRIAGE_FLAG] == name;
        else if (polyBits.hasOwnProperty(name)) return Boolean(flags[kFLAGS.SCENEHUNTER_POLYGAMY] & polyBits[name]);
        else {
            CoC_Settings.error("Checking " + name + " marriage without registering them in SceneHunter.");
            return false;
        }
    }

    public function togglePolygamy():void {
        var name:String
        if (flags[kFLAGS.SCENEHUNTER_POLYGAMY]) {
            var pcnt:int = 0;
            //assume the worst case.
            clearOutput();
            outputText("Since you have already married several characters, you have to pick only one. Others will be saved here and restored if you turn Polygamy back on.");
            menu();
            for (name in polyBits)
                if (Boolean(flags[kFLAGS.SCENEHUNTER_POLYGAMY] & polyBits[name]))
                    addButton(pcnt++, name, disablePoly, name);
            //best case? Skip to settings!
            if (pcnt == 1) disablePoly(button(0).labelText); //the button should contain spouse's name
            else if (pcnt == 0) disablePoly(""); // no marriages - just disable it
        } else {
            //Fix 'unmarried' NPCs
            if (flags[kFLAGS.SCENEHUNTER_POLYGAMY] & POLYGAMY_CHICHI && flags[kFLAGS.MARRIAGE_FLAG] != "Chi Chi")
                flags[kFLAGS.CHI_CHI_FOLLOWER] = 6;
            if (flags[kFLAGS.SCENEHUNTER_POLYGAMY] & POLYGAMY_ETNA && flags[kFLAGS.MARRIAGE_FLAG] != "Etna")
                flags[kFLAGS.ETNA_FOLLOWER] = 4;
            if (flags[kFLAGS.SCENEHUNTER_POLYGAMY] & POLYGAMY_ZENJI && flags[kFLAGS.MARRIAGE_FLAG] != "Zenji")
                flags[kFLAGS.ZENJI_PROGRESS] = 12;
            if (flags[kFLAGS.SCENEHUNTER_POLYGAMY] & POLYGAMY_ALVINA && flags[kFLAGS.MARRIAGE_FLAG] != "Alvina")
                flags[kFLAGS.ALVINA_FOLLOWER] = 21;
            //Enable Polygamy
            flags[kFLAGS.MARRIAGE_FLAG] = "POLYGAMY"; //just to break anything that doesn't support it
            flags[kFLAGS.SCENEHUNTER_POLYGAMY] ^= POLYGAMY_ENABLED;
            settingsPage();
        }

        function disablePoly(singleName:String):void {
            if (singleName) {
                var singleBit:int = polyBits[singleName];
                //revert some flags to pre-marriage state
                if (flags[kFLAGS.SCENEHUNTER_POLYGAMY] & POLYGAMY_CHICHI && singleBit != POLYGAMY_CHICHI)
                    flags[kFLAGS.CHI_CHI_FOLLOWER] = 3;
                if (flags[kFLAGS.SCENEHUNTER_POLYGAMY] & POLYGAMY_ETNA && singleBit != POLYGAMY_ETNA)
                    flags[kFLAGS.ETNA_FOLLOWER] = 2;
                if (flags[kFLAGS.SCENEHUNTER_POLYGAMY] & POLYGAMY_ZENJI && singleBit != POLYGAMY_ZENJI)
                    flags[kFLAGS.ZENJI_PROGRESS] = 11;
                if (flags[kFLAGS.SCENEHUNTER_POLYGAMY] & POLYGAMY_ALVINA && singleBit != POLYGAMY_ALVINA) {
                    flags[kFLAGS.ALVINA_FOLLOWER] = 20;
                    if (flags[kFLAGS.SLEEP_WITH] == "Alvina") flags[kFLAGS.SLEEP_WITH] = "";
                }
            }
            //set marriage flag
            flags[kFLAGS.MARRIAGE_FLAG] = singleName;
            flags[kFLAGS.SCENEHUNTER_POLYGAMY] ^= POLYGAMY_ENABLED;
            settingsPage();
        }
    }

    //--------------------------------------------------------------------------------------------------
    // Other
    //--------------------------------------------------------------------------------------------------

    public function get other():Boolean {
        return flags[kFLAGS.SCENEHUNTER_OTHER];
    }

    //Can be set to avoid exactly **ONE** check. For example, start uniHerms selector without uniHerms enabled.
    private var _passCheck:Boolean = false;

    //Skips the next check. For example, start uniHerms selector without uniHerms enabled. (Excluding 'other' checks - they work differently each time.)
    public function passCheckOnce():void {
        _passCheck = true;
    }

    //No disabling flag for this one, but I'll leave it here for now in case I'll need to lock it..
    /**
     * The dialogue to select scene options based on corruption.
     * @param    pureButton Array ["Name", function, optional - "Description"] for the first button
     * @param    corButton  Array ["Name", function, optional - "Description"] for the second button
     * @param    maxForPure Max corruption for pure button
     * @param    minForCor  Max corruption for pure button
     * @param    tolerance  Whether or not corruption tolerance should be used in the check
     */
    public function selectPureCor(pureButton:Array, corButton:Array, maxForPure:int, minForCor:int = -1, tolerance:Boolean = true):void {
        //Auto-calls - no (until Orm kicks my ass for changing the game too much)
        //Dialogue
        var beforeText:String = CoC.instance.currentText;
        outputText("\n\n<b>What will you do?</b>");
        menu();
        //modify the values
        if (minForCor < 0) minForCor = maxForPure;
        if (tolerance) {
            maxForPure += player.corruptionTolerance;
            minForCor -= player.corruptionTolerance;
        }
        //good button
        if (player.cor <= maxForPure)
            addButton(0, pureButton[0], restoreText, beforeText, pureButton[1], null, pureButton.length > 2 ? pureButton[2] : "");
        else
            addButtonDisabled(0, pureButton[0], "You're too corrupted for it! (req. corruption less than " + maxForPure + ")");
        //bad button
        if (player.cor >= minForCor)
            addButton(1, corButton[0], restoreText, beforeText, corButton[1], null, corButton.length > 2 ? corButton[2] : "");
        else
            addButtonDisabled(1, corButton[0], "You're too pure to even think of it! (req. corruption more than " + minForCor + ")");
    }

    //--------------------------------------------------------------------------------------------------
    // Recall & MockFight
    //--------------------------------------------------------------------------------------------------
    /*
    Recalling is 'technically' a SceneHunter feature, so I'll store its flags & functions here.
    Set to true to disable everything but text in recalled scenes
    */
    public var _recalling:Boolean = false; //set to true when a scene is recalled.
    public var _mocking:Boolean = false; //set to true when a scene is recalled.

    public function get mockFights():Boolean {
        return _passCheck || flags[kFLAGS.SCENEHUNTER_MOCK_FIGHTS];
    }

    public function recallScenes():void {
        clearOutput();
        outputText("You close your eyes, remembering all this life put you through. All your fights, friends... lovers.\n\n");
        outputText("Though many things are still repeatable, you still remember some unique events of your life, and one question bothers you - what would happen if you were different at the moment? How would you and your companions look and behave right now?\n");
        outputText("Falling asleep, you think about it, recalling the exact time and place...\n\n");
        outputText("\n\n\nAll scenes listed here are unique one-timers. Most of them contain multiple choices or different variations for player's race or bodyparts. When recalling, your <b>current</b> body and game state is used, so you can try to explore more options for yourself!");
        outputText("\nOf course, you need to unlock the scene in the game first.");
        outputText("\nPlease note that most of hidden checks and forks will stay hidden unless you enable other SceneHunter options.");
        outputText("\nTo replay win/lose rape scenes with some of your camp NPC, enable 'Mock Fights' in SceneHunter and select the new options in dialogues.</i>");
        outputText("\n\n<b>Recalling wastes some in-game time, but it will never change any of your stats. If such occasion occurs, please report it as a bug.</b></i>");
        recalling = true; //Setting the flag to disable everything but text
        menu();

        //Tamani first time
        if (flags[kFLAGS.TAMANI_MET] == 1 && player.hasCock())
            addButton(0, "TamaniFirst", SceneLib.forest.tamaniScene.tamaniFirstTimeConsentual)
                .hint("First time with Tamani.");
        //Tamani first time
        if (player.hasKeyItem("Deluxe Dildo") >= 0 && player.hasVagina())
            addButton(1, "TamaniLes", SceneLib.forest.tamaniScene.preferTamaniFemdom)
                .hint("Girl-on-girl event with Tamani.");
        //Erlking revenge
        if (player.hasKeyItem("Golden Antlers") >= 0 && player.gender > 0)
            addButton(2, "Erlk.Revenge", SceneLib.forest.erlkingScene.howDareYou)
                .hint("You show Erlking <b>who</b> is the hunter here.");
        //Unicorn
        if (CelessScene.instance.questFinishedUnicorn || sceneHunter.other && CelessScene.instance.questFinishedNightmare)
            addButton(3, "Unicorn", CelessScene.instance.celessUnicornIntro2, 0)
                .hint("Let that pure unicorn guard penetrate your ass again."
                    + (!CelessScene.instance.questFinishedUnicorn ? "\n\n<b>Brought here by SceneHunter:Other.</b>" : ""));
        //Nightmare
        if (CelessScene.instance.questFinishedNightmare || sceneHunter.other && CelessScene.instance.questFinishedNightmare)
            addButton(4, "Nightmare", SceneLib.forest.nightmareScene.nightmareVictory)
                .hint("Demonic bicorn fucks you into a pile of mess."
                    + (!CelessScene.instance.questFinishedNightmare ? "\n\n<b>Brought here by SceneHunter:Other.</b>" : ""));
        //Venus cock scenes
        if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2 && flags[kFLAGS.KAIJU_COCK] == 1)
            addButton(5, "VenusCock", SceneLib.boat.kaiju.kaijuGrowsWangus)
                .hint("Venus discovers her new cock.");
        if (flags[kFLAGS.TIMES_EGGED_IN_EXGARTUAN] > 0 && player.hasCock())
            addButton(6, "EggExgartuan", SceneLib.masturbation.eggExgartuan)
                .hint("Your small egg-fight with your dick-demon.");

        addButton(8, "Places", recallScenes_places);
        addButton(9, "Dungeons", recallScenes_dungeons);
        addButton(10, "CampNPCs-1", recallScenes_NPCs);
        addButton(11, "CampNPCs-2", recallScenes_NPCs_2);
        addButton(12, "CampNPCs-3", recallScenes_NPCs_3);
        if (flags[kFLAGS.URTA_QUEST_STATUS] >= 1) addButton(13, "UrtaQuest", recallScenes_quest);
        addButton(14, "Wake Up", recallWakeUpImpl);
    }

    private function recallScenes_places():void {
        menu();
        //Benoit stuff
        if (flags[kFLAGS.BENOIT_TIMES_SEXED_FEMPCS] > 0 && player.hasVagina())
            addButton(0, "Benoit1stEgg", SceneLib.bazaar.benoit.eggySuggest)
                .hint("Benoit's first egging.");
        if (flags[kFLAGS.BENOIT_TESTED_BASILISK_WOMB] == 1 && player.hasVagina())
            addButton(1, "BenoitBWomb", SceneLib.bazaar.benoit.tryToConvertToBassyWomb)
                .hint("Your first Basilisk Womb test.");
        if (flags[kFLAGS.TIMES_FUCKED_FEMOIT] > 0 && player.hasCock())
            addButton(2, "Femoit1st", SceneLib.bazaar.benoit.femoitFirstTimeYes)
                .hint("First Benoite experience.");
        //Corrupted Marae
        if (flags[kFLAGS.MET_MARAE_CORRUPTED] > 0 && player.gender > 0)
            addButton(3, "C.Marae(1)", SceneLib.boat.marae.firstCorruptEncounter)
                .hint("Repeat your encounters with the corrupted goddess.");
        if (flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] > 0 && player.gender > 0)
            addButton(4, "C.Marae(2)", SceneLib.boat.marae.level2MaraeEncounter)
                .hint("Repeat your encounters with the corrupted goddess.");
        //Sapphire
        if (flags[kFLAGS.SAPPHIRE_AFFECTION] == 100)
            addButton(5, "SapphireFirst", SceneLib.templeofdivine.sapphire.sapphireFirstTime)
                .hint("Sapphire discovers carnal pleasures");
        if (flags[kFLAGS.OWCA_SACRIFICE_DISABLED])
            addButton(6, "OwcaDemons", SceneLib.owca.loseOrSubmitToVapula)
                .hint("Why not submit to lusty demons again, huh?");
        if (flags[kFLAGS.OWCA_UNLOCKED] == -1 || sceneHunter.other && flags[kFLAGS.OWCA_SACRIFICE_DISABLED])
            addButton(7, "RapeRebecc", SceneLib.owca.loseOrSubmitToVapula)
                .hint("Payback for the sheep-girl."
                    + (flags[kFLAGS.OWCA_UNLOCKED] != -1 ? "\n\n<b>Brought here by SceneHunter:Other.</b>" : ""));

        //Sub-pages
        if (player.hasStatusEffect(StatusEffects.MetWhitney) && player.statusEffectv1(StatusEffects.MetWhitney) > 1)
            addButton(10, "Farm", recallScenes_farm);
        if (player.statusEffectv1(StatusEffects.TelAdre) >= 1)
            addButton(11, "TelAdre", recallScenes_telAdre);

        addButton(14, "Back", recallScenes);
    }

    private function recallScenes_farm():void {
        menu();
        if (player.hasStatusEffect(StatusEffects.KeltOff) || sceneHunter.other && flags[kFLAGS.KELT_BREAK_LEVEL] >= 4) //allowing for Kelly in 'Other' because I want!
            addButton(0, "KeltRape", SceneLib.farm.keltScene.fuckKeltsShitUp)
                .hint("Revenge for the arrogant centaur."
                    + (!player.hasStatusEffect(StatusEffects.KeltOff) ? "\n\n<b>Brought here by SceneHunter:Other.</b>" : ""));
        if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 1 && player.hasCock())
            addButton(1, "KeltBreak1", SceneLib.farm.kelly.breakKeltGo)
                .hint("Kelt Breaking - Stage 1.");
        if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 2 && player.hasCock())
            addButton(2, "KeltBreak2", SceneLib.farm.kelly.secondKeltBreaking)
                .hint("Kelt Breaking - Stage 2.");
        if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 3 && player.hasCock())
            addButton(3, "KeltBreak3", SceneLib.farm.kelly.breakingKeltNumeroThree)
                .hint("Kelt Breaking - Stage 3.");
        if (flags[kFLAGS.KELT_BREAK_LEVEL] >= 4 && player.hasCock())
            addButton(4, "KeltBreak4", SceneLib.farm.kelly.finalKeltBreaking)
                .hint("Kelt Breaking - Stage 4.");
        if (flags[kFLAGS.KELLY_VAGINALLY_FUCKED_COUNT] > 0 && player.hasCock())
            addButton(5, "KellyVirgin", SceneLib.farm.kelly.takeKellysVirginity)
                .hint("Virgin Fuck!");
        if (player.hasStatusEffect(StatusEffects.Marble))
            addButton(6, "MarbleMeet", SceneLib.marbleScene.encounterMarbleInitially)
                .hint("First meeting. Should it go nice... or not?");
        if (player.statusEffectv1(StatusEffects.FuckedMarble) > 0)
            addButton(7, "MarblSexFarm", SceneLib.marbleScene.standardSex)
                .hint("Marble invites you to her bed.");
        if (player.statusEffectv2(StatusEffects.FuckedMarble) > 0)
            addButton(8, "MilkySex", SceneLib.marbleScene.marbleMilkSex)
                .hint("Something hot after milking. Why not?");
        if (player.statusEffectv2(StatusEffects.FuckedMarble) > 0)
            addButton(9, "MilkySex", SceneLib.marbleScene.marbleMilkSex)
                .hint("Something hot after milking. Why not?");
        addButton(14, "Back", recallScenes_places);
    }

    private function recallScenes_telAdre():void {
        menu();
        if (flags[kFLAGS.MADDIE_QUEST_STATE] >= 3 && player.gender > 0)
            addButton(0, "Maddie", SceneLib.telAdre.maddie.talkToMaddie)
                .hint("Meet the cupcake-girl again!");
        if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] > 0 && player.hasCock())
            addButton(1, "Scylla", recallScenes_scylla)
                .hint("In sainted moments of dark, unveil yourself by request...");
        if (flags[kFLAGS.BROOKE_MEDIUM_SCENE] && (player.hasVagina() || player.cockThatFits(SceneLib.telAdre.brooke.brookeCapacity()) >= 0))
            addButton(2, "BrookeUnique", SceneLib.telAdre.brooke.mediumAffectionOneTimeEvent)
                .hint("Unique sex event with your Shepherd girl.");
        if (flags[kFLAGS.COTTON_MET_FUCKED] >= 2)
            addButton(3, "CottonFirst", SceneLib.telAdre.cotton.cottonShowerFunTimes)
                .hint("First shower with Cotton.");
        //4
        if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] > 0)
            addButton(5, "UrtaFirst", SceneLib.urta.urtaFirstEncounter)
                .hint("Your first awkward encounter with Urta.");
        if (flags[kFLAGS.URTA_PC_LOVE_COUNTER] == 1)
            addButton(6, "UrtaFriendSex", SceneLib.urta.goBackToUrtasForLuvinz, true)
                .hint("Friendly sex with Urta before confession.");
        if (flags[kFLAGS.URTA_X_RAPHAEL_HAPPENED])
            addButton(7, "Urta x Raph", SceneLib.urta.urtaAndRaphaelSurprise)
                .hint("Drunk Urta and Raphael surprise.");
        if (SceneLib.telAdre.sexMachine.totalUses() > 0)
            addButton(8, "Sex Machine", SceneLib.telAdre.sexMachine.exploreShowers)
                .hint("Your first time with the 'unique' gym machine");
        addButton(14, "Back", recallScenes_places);
    }

    private function recallScenes_scylla():void {
        if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] >= 1)
            addButton(0, "Round 1", SceneLib.telAdre.scylla.helpScylla);
        if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] >= 2)
            addButton(1, "Round 2", SceneLib.telAdre.scylla.scyllaRoundII);
        if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] >= 3)
            addButton(2, "Round 3", SceneLib.telAdre.scylla.scyllaRoundThreeCUM);
        if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] >= 4)
            addButton(3, "Round 4", SceneLib.telAdre.scylla.scyllaRoundIVGo);
        //5 - repeatable on its own, no need to add it here
        if (flags[kFLAGS.SCYLLA_CATS_RECALL_TRACKER] > 0)
            addButton(4, "CatsAttack", SceneLib.telAdre.scylla.Scylla6);
        addButton(14, "Back", recallScenes_telAdre);

    }

    private function recallScenes_NPCs():void {
        menu();
        //Marble scene
        if (flags[kFLAGS.MARBLE_PURIFIED] == 1)
            addButton(0, "Marble & Clara", SceneLib.marblePurification.defeatClaraCuntInAFight)
                .hint("The punishment for Marble's bitchy sister.");
        //Excellia slave first scene
        if (flags[kFLAGS.EXCELLIA_RECRUITED] == 2 && (player.hasCock() || player.hasVagina()))
            addButton(1, "Excellia Slv", SceneLib.excelliaFollower.ExcelliaPathChoiceMakeSlave)
                .hint("Excellia acknowledges herself as your slave.");
        //Phylla demon fuck
        if (flags[kFLAGS.ANT_COLONY_KEPT_HIDDEN] || flags[kFLAGS.PHYLLA_SAVED] && sceneHunter.other) {
            if (player.cor >= 66 - player.corruptionTolerance && player.gender > 0)
                addButton(2, "PhyllaCart", SceneLib.desert.antsScene.demonsFuckAntgirl)
                    .hint("Maybe you should have left Phylla to demons and watch them having fun?");
            else addButtonDisabled(2, "PhyllaCart", "You must be corrupted and not genderless to recall this.");
        }
        //Phylla keks
        if (flags[kFLAGS.ANT_WAIFU] || flags[kFLAGS.PHYLLA_STAY_HOME])
            addButton(3, "PhyFirstTime", SceneLib.desert.antsScene.antGirlGoodEnd)
                .hint("Your first time with Phylla.");
        //Belisa
        if (BelisaFollower.BelisaConfessed)
            addButton(4, "BelisaConf", SceneLib.belisa.BelisaConfession)
                .hint("Remember the cute spooder's confession.")
        if (flags[kFLAGS.ETNA_TALKED_ABOUT_HER] >= 2)
            addButton(5, "EtnaYandere", SceneLib.etnaScene.etnaRapeYandere)
                .hint("You might have never seen it, but here it is - yandere rape!");
        if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] >= 2)
            addButton(6, "Hel&Minotaur", SceneLib.helScene.helMinotaurThreesome)
                .hint("Maybe minotaurs aren't so bad, huh?");
        if (flags[kFLAGS.HELIA_ANAL_TRAINING] >= 1 && player.hasCock())
            addButton(7, "HelAnal-1", SceneLib.helFollower.giveHeliaAnalTraining)
                .hint("Hel's first attempt in real anal.");
        if (flags[kFLAGS.HELIA_ANAL_TRAINING] >= 2 && player.hasCock())
            addButton(8, "HelAnal-2", SceneLib.helFollower.heliaAnalTrainingPartTwo)
                .hint("Hel becomes a good anal slut.");
        if (SceneLib.helScene.pregnancy.isPregnant || flags[kFLAGS.HELSPAWN_AGE] > 1)
            addButton(9, "HelImpreg", SceneLib.helSpawnScene.heliaBonusPointsAward)
                .hint("Hel - impregnation & NTR scenes");
        if (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 2)
            addButton(10, "HolliFlower", SceneLib.holliScene.flowerStage2Menu)
                .hint("Use the fuck-flower before she's fully grown (stage 2)!");
        if (flags[kFLAGS.FUCK_FLOWER_LEVEL] >= 3)
            addButton(11, "HolliTree", SceneLib.holliScene.flowerStage3Menu)
                .hint("Use the tree-girl before she's fully grown (stage 3)!");
        if (flags[kFLAGS.ANEMONE_KID] >= 3 && player.hasCock())
            addButton(12, "KidAVirgin", SceneLib.kidAScene.sexVirgin)
                .hint("Kid A's attempt to fuck you with her vagina.");
        if (LilyFollower.LilyFollowerState)
            addButton(13, "LilySubCamp", SceneLib.lily.LilySubComeCamp)
                .hint("Ask Lily to come to your camp.. in a dominant way.")
        addButton(14, "Back", recallScenes);
    }

    private function recallScenes_NPCs_2():void {
        menu();
        if (JojoScene.monk >= JojoScene.JOJO_CORRUPT_1 && player.gender > 0)
            addButton(0, "JojoRape-1", SceneLib.jojoScene.jojosFirstRape)
                .hint("Jojo's corruption - first rape.");
        if (JojoScene.monk >= JojoScene.JOJO_CORRUPT_2 && player.gender > 0)
            addButton(1, "JojoRape-2", SceneLib.jojoScene.jojosSecondRape)
                .hint("Jojo corruption - second rape.");
        if (JojoScene.monk >= JojoScene.JOJO_CORRUPT_3 && player.gender > 0)
            addButton(2, "JojoRape-3", SceneLib.jojoScene.jojosThirdRape)
                .hint("Jojo's corruption - third rape.");
        if (JojoScene.monk == JojoScene.JOJO_CORRUPT_FULL && player.gender > 0) {
            addButton(3, "JojoRape-4", SceneLib.jojoScene.jojosFourthRape)
                .hint("Jojo's corruption - fourth rape.");
            addButton(4, "JojoLoss", SceneLib.jojoScene.loseToJojo)
                .hint("What happens if you lose to already corrupted monk?");
        }
        if (player.hasStatusEffect(StatusEffects.TentacleJojo) && player.gender > 0)
            addButton(5, "JojoMutate", SceneLib.jojoScene.jojoMutationOfferYes)
                .hint("The sweet moment when your mouse-slut got his tentacles.");
        if (flags[kFLAGS.JOJO_TIMES_MILKED] > 0)
            addButton(6, "Jojo1stMilk", SceneLib.jojoScene.milkJojoFirst)
                .hint("First milking of the mouse-slut!");
        if (flags[kFLAGS.KIHA_AND_HEL_WHOOPIE] && player.hasCock())
            addButton(7, "Kiha X Hel", SceneLib.kihaFollower.kihaXSalamander)
                .hint("Repeat the swamp encounter!");
        if (flags[kFLAGS.KIHA_AFFECTION_LEVEL] >= 2 && player.gender > 0)
            addButton(8, "KihaLovinHug", SceneLib.kihaFollower.kihaXSalamander)
                .hint("Repeat the swamp encounter!");
        if (flags[kFLAGS.PATCHOULI_FOLLOWER] >= PatchouliScene.TIEDINCAMP && player.gender > 0)
            addButton(9, "PatchRape", SceneLib.patchouliScene.patchouliRapeHim)
                .hint("Take your revenge on the deceiving cat.");
        if (flags[kFLAGS.RAPHAEL_MET])
            addButton(10, "Raph-Meeting", SceneLib.raphael.meetRaphael)
                .hint("Your first encounter.");
        if (player.hasPerk(PerkLib.RapierTraining) && player.hasVagina())
            addButton(11, "Raph-Fencing", SceneLib.raphael.RaphaelPicnicSkill)
                .hint("The last test of your skill.");
        if (player.hasPerk(PerkLib.Misdirection) && player.hasVagina())
            addButton(12, "Raph-Thievin", SceneLib.raphael.RaphaelPicnicChooseThieving)
                .hint("Your last discussion about thievery.");
        if (flags[kFLAGS.SHEILA_XP] >= 4 || sceneHunter.other && flags[kFLAGS.SHEILA_DEMON] && flags[kFLAGS.SHEILA_CITE] == 1)
            addButton(13, "SheilaEvening", SceneLib.sheilaScene.sheilaXPThreeSexyTime)
                .hint("The unusual evening encounter with Sheila.");
        addButton(14, "Back", recallScenes);
    }

    private function recallScenes_NPCs_3():void {
        menu();
        if (flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] == 4 && player.hasCock())
            addButton(0, "ExgartuDrama", SceneLib.shouldraFollower.exgartuMonAndShouldraShowdown)
                .hint("The finish of Shouldra's quarrel with Exgartuan, your dick-demon.");
        if (flags[kFLAGS.AMILY_CORRUPTION] >= 1 && player.gender > 0)
            addButton(1, "AmilyRape-1", SceneLib.amilyScene.stalkingZeAmiliez);
        if (flags[kFLAGS.AMILY_CORRUPTION] >= 2 && player.gender > 0)
            addButton(2, "AmilyRape-2", SceneLib.amilyScene.stalkingZeAmiliez2);
        if (flags[kFLAGS.AMILY_CORRUPTION] >= 3 && player.gender > 0)
            addButton(3, "AmilyRape-3", SceneLib.amilyScene.stalkingZeAmiliez3);
        if (flags[kFLAGS.AMILY_CORRUPTION] >= 4 && player.gender > 0)
            addButton(4, "AmilyRape-4", SceneLib.amilyScene.rapeCorruptAmily4Meeting);
        if (camp.vapulaSlave())
            addButton(5, "VapulaRape", SceneLib.owca.rapeZeVapula);
        if (flags[kFLAGS.ZENJI_PROGRESS] >= 12)
            addButton(6, "ZenjiMarry", SceneLib.zenjiScene.ZenjiMarriageSceneCinco)
                .hint("Zenji marriage sex.");
        addButton(14, "Back", recallScenes);
    }

    private function recallScenes_dungeons():void {
        menu();
        if (flags[kFLAGS.SANDWITCH_MOB_DEFEATED])
            addButton(0, "SandWitchMob", SceneLib.dungeons.desertcave.yoYouBeatUpSomeSandWitchesYOUMONSTER)
                .hint("Punish some sand witches for attacking you.");
        if (flags[kFLAGS.FACTORY_FOUND]) addButton(1, "Factory", recallScenes_factory);
        if (flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0) addButton(2, "Deep Cave", recallScenes_deepCave);
        if (flags[kFLAGS.D3_DISCOVERED] > 0) addButton(3, "Stronghold", recallScenes_d3);
        if (flags[kFLAGS.D3_DISCOVERED] > 0) addButton(3, "Stronghold", recallScenes_d3);
        if (flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED]) addButton(4, "PhoenixTower", recallScenes_phoenixTower);
        if (DemonLab.MainAreaComplete >= 3) addButton(5, "Lab Succubus", SceneLib.dungeons.demonLab.succubusDecision);
        addButton(14, "Back", recallScenes);
    }

    private function recallScenes_factory():void {
        menu();
        if (flags[kFLAGS.FACTORY_SUCCUBUS_DEFEATED])
            addButton(0, "Sec.Succubus", SceneLib.dungeons.factory.secretarialSuccubusDefeated)
                .hint("Do you have a fetish for sharply-dressed demon girls?");
        if (flags[kFLAGS.FACTORY_INCUBUS_DEFEATED])
            addButton(1, "Inc.Mechanic", SceneLib.dungeons.factory.incubusMechanicDefeated)
                .hint("What, again?");
        addButton(14, "Back", recallScenes_dungeons);
    }

    private function recallScenes_deepCave():void {
        menu();
        //Doppel
        if (flags[kFLAGS.ZETAZ_IMP_HORDE_DEFEATED])
            addButton(0, "Imp Horde", SceneLib.dungeons.deepcave.impGangVICTORY)
                .hint("I'll never stop at one. YOU'LL TAKE THEM ALL ON!");
        if (flags[kFLAGS.TIMES_PC_DEFEATED_VALA] > 0 || flags[kFLAGS.TIMES_FUCKED_VALA_IN_DUNGEON] > 0)
            addButton(1, "Vala (Freed)", SceneLib.vala.freeValazLooseCoochie)
                .hint("Vala tries to enjoy her freedom and fuck the first person she sees.");
        if (flags[kFLAGS.DEFEATED_ZETAZ])
            addButton(2, "Zetaz", SceneLib.dungeons.deepcave.defeatZetaz)
                .hint("Maybe the little asshole should have been tortured a bit more?");
        if (flags[kFLAGS.INVESTIGATED_VALA_AFTER_ZETAZ_DEFEATED])
            addButton(3, "Vala (Later)", SceneLib.vala.leftValaAlone)
                .hint("Vala has spent some time alone and is VERY bored..");
        addButton(14, "Back", recallScenes_dungeons);
    }

    private function recallScenes_d3():void {
        menu();
        if (flags[kFLAGS.D3_MIRRORS_SHATTERED])
            addButton(0, "Doppelganger", SceneLib.d3.doppleganger.punchYourselfInTheBalls)
                .hint("Go fuck yourself!");
        if (flags[kFLAGS.DRIDERINCUBUS_DEFEATED])
            addButton(1, "DriderI & M", SceneLib.d3.driderIncubus.beatTheSpooderbutt)
                .hint("Recall the glorious defeat of the drider-incubus and maybe take your 'reward'.");
        if (flags[kFLAGS.D3_CENTAUR_DEFEATED] > 0)
            addButton(2, "HermCentaur", SceneLib.d3.hermCentaur.beatThePony)
                .hint("Get your 'reward' for beating the herm centaur in the stronghold.");
        if (flags[kFLAGS.MINOTAURKING_DEFEATED] > 0)
            addButton(3, "M.King & Exc", SceneLib.d3.minotaurKing.theKingIsDeadLongLiveTheKing)
                .hint("If you didn't have time or the mood for using 2 cowsluts before fighting Lethice, you can do it in your imagination!");
        if (flags[kFLAGS.LETHICE_DEFEATED] > 0)
            addButton(4, "Lethice", SceneLib.d3.lethice.defeated)
                .hint("While you can't make her your eternal slave, you can punish her for her arrogance in your memories as much as you want.");
        if (flags[kFLAGS.D3_MECHANIC_LAST_GREET] == IncubusMechanicScenes.MECHANIC_FOUGHT)
            addButton(5, "Inc.Mechanic", SceneLib.d3.incubusMechanic.beatDaMechanic)
                .hint("What, again?");
        addButton(14, "Back", recallScenes_dungeons);
    }

    private function recallScenes_phoenixTower():void {
        menu();
        //Harpy defeat is checked earlier. Kiri disappears after it too.
        addButton(0, "Kiri", SceneLib.dungeons.heltower.kiriInteraction)
            .hint("If you were too busy slaughtering phoenixes and didn't have time to properly 'interact' with Kiri, here's your new chance.");
        addButton(1, "HarpyQueen", SceneLib.dungeons.heltower.fuckHarpyQueen)
            .hint("Oops. Harpy queen is dead already. But she'll live forever in your memories. For <i>any</i> purposes.");
        addButton(14, "Back", recallScenes_dungeons);
    }

    private var urtaSwapped:Boolean = false;

    private function recallScenes_quest():void {
        //Run Urta quest init sequence to swap her with PC
        SceneLib.urtaQuest.startUrtaQuest();
        urtaSwapped = true;
        //no clearOutput - handled by init sequence
        menu();
        addButton(0, "Beginning", SceneLib.urtaQuest.towerOfTheCovanant);
        addButton(1, "Goblin", SceneLib.urtaQuest.runIntoAGoblin);
        addButton(2, "Naga", SceneLib.urtaQuest.nagaPleaseNagaStoleMyDick);
        addButton(3, "Gnoll", SceneLib.urtaQuest.gnollAlphaBitchIntro);
        addButton(4, "Night", SceneLib.urtaQuest.urtaNightSleep);
        addButton(5, "Minotaur", SceneLib.urtaQuest.introSuccubiAndMinotaur);
        addButton(6, "Succubus", SceneLib.urtaQuest.beatMinoLordOnToSuccubi);
        addButton(10, "Camp End", campEnd);
        addButton(14, "Back", recallScenes);

        function campEnd():void {
            restoreFromQuest(); //requires some more effort to reset PC and remove the bool
            SceneLib.urtaQuest.urtaArrivesAtCampForFukks();
        }
    }

    private function restoreFromQuest():void {
        CoC.instance.inCombat = false;
        SceneLib.urtaQuest.resetToPC();
        statScreenRefresh();
        CoC.instance.mainViewManager.updateCharviewIfNeeded();
        urtaSwapped = false;
    }

    public function recallWakeUpImpl():void {
        //Swap Urta back if recalled her quest
        if (urtaSwapped) restoreFromQuest();
        clearOutput();
        outputText("You wake up from your dreams, satisfied. Well, this was a fun ride. But you still a lot ahead, so daydreaming is not the best way to waste your time. So... time to experience a few fresh adventures, so you'll have more to recall later?");
        recalling = false; //EVERY recall scene must return here to clear the flag.
        doNext(camp.returnToCampUseOneHour);
    }
}
}