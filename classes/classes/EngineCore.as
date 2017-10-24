package classes {
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

import coc.view.CoCButton;
import coc.view.MainView;

import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.describeType;

public class EngineCore {
    private static var funcLookups:Dictionary = null;

    public function EngineCore() {
    }

    public static function maxHP():Number {
        return kGAMECLASS.player.maxHP();
    }

    public static function maxSoulforce():Number {
        return kGAMECLASS.player.maxSoulforce();
    }

    public static function maxWrath():Number {
        return kGAMECLASS.player.maxWrath();
    }

    public static function maxMana():Number {
        return kGAMECLASS.player.maxMana();
    }

    public static function silly():Boolean {
        return kGAMECLASS.flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] == 1;
    }

    /**
     * Alters player's HP.
     * @param    changeNum The amount to damage (negative) or heal (positive).
     * @param    display Show the damage or heal taken.
     * @return  effective delta
     */
    public static function HPChange(changeNum:Number, display:Boolean):Number {
        var before:Number = kGAMECLASS.player.HP;
        if (changeNum == 0) return 0;
        if (changeNum > 0) {
            //Increase by 20%!
            if (kGAMECLASS.player.findPerk(PerkLib.HistoryHealer) >= 0 || kGAMECLASS.player.findPerk(PerkLib.PastLifeHealer) >= 0) changeNum *= 1.2;
            if (kGAMECLASS.player.HP + int(changeNum) > maxHP()) {
                if (kGAMECLASS.player.HP >= maxHP()) {
                    if (display) HPChangeNotify(changeNum);
                    return kGAMECLASS.player.HP - before;
                }
                if (display) HPChangeNotify(changeNum);
                kGAMECLASS.player.HP = maxHP();
            }
            else {
                if (display) HPChangeNotify(changeNum);
                kGAMECLASS.player.HP += int(changeNum);
                kGAMECLASS.mainView.statsView.showStatUp('hp');
                // hpUp.visible = true;
            }
        }
        //Negative HP
        else {
            if (kGAMECLASS.player.HP + changeNum <= 0) {
                if (display) HPChangeNotify(changeNum);
                kGAMECLASS.player.HP = 0;
                kGAMECLASS.mainView.statsView.showStatDown('hp');
            }
            else {
                if (display) HPChangeNotify(changeNum);
                kGAMECLASS.player.HP += changeNum;
                kGAMECLASS.mainView.statsView.showStatDown('hp');
            }
        }
        kGAMECLASS.player.dynStats("lust", 0, "scale", false); //Workaround to showing the arrow.
        statScreenRefresh();
        return kGAMECLASS.player.HP - before;
    }

    public static function HPChangeNotify(changeNum:Number):void {
        if (changeNum == 0) {
            if (kGAMECLASS.player.HP >= maxHP())
                outputText("You're as healthy as you can be.\n");
        }
        else if (changeNum > 0) {
            if (kGAMECLASS.player.HP >= maxHP())
                outputText("Your HP maxes out at " + maxHP() + ".\n");
            else
                outputText("You gain <b><font color=\"#008000\">" + int(changeNum) + "</font></b> HP.\n");
        }
        else {
            if (kGAMECLASS.player.HP <= 0)
                outputText("You take <b><font color=\"#800000\">" + int(changeNum * -1) + "</font></b> damage, dropping your HP to 0.\n");
            else
                outputText("You take <b><font color=\"#800000\">" + int(changeNum * -1) + "</font></b> damage.\n");
        }
    }

    public static function SoulforceChange(changeNum:Number, display:Boolean):Number {
        var before:Number = kGAMECLASS.player.soulforce;
        if (changeNum == 0) return 0;
        if (changeNum > 0) {
            if (kGAMECLASS.player.soulforce + int(changeNum) > maxSoulforce()) {
                //	if(kGAMECLASS.player.HP >= maxHP()) {
                //	if (display) HPChangeNotify(changeNum);
                //		return kGAMECLASS.player.HP - before;
                //	}
                //	if (display) HPChangeNotify(changeNum);
                kGAMECLASS.player.soulforce = maxSoulforce();
            }
            else {
                //	if (display) HPChangeNotify(changeNum);
                kGAMECLASS.player.soulforce += int(changeNum);
                //	kGAMECLASS.mainView.statsView.showStatUp( 'hp' );
                // hpUp.visible = true;
            }
        }
        //Negative Soulforce
        /*	else
            {
                if(kGAMECLASS.player.HP + changeNum <= 0) {
                    if (display) HPChangeNotify(changeNum);
                    kGAMECLASS.player.HP = 0;
                    kGAMECLASS.mainView.statsView.showStatDown( 'hp' );
                }
                else {
                    if (display) HPChangeNotify(changeNum);
                    kGAMECLASS.player.HP += changeNum;
                    kGAMECLASS.mainView.statsView.showStatDown( 'hp' );
                }
            }
            dynStats("lust", 0, "scale", false) //Workaround to showing the arrow.
        */
        statScreenRefresh();
        return kGAMECLASS.player.soulforce - before;
    }

    public static function ManaChange(changeNum:Number, display:Boolean):Number {
        var before:Number = kGAMECLASS.player.mana;
        if (changeNum == 0) return 0;
        if (changeNum > 0) {
            if (kGAMECLASS.player.mana + int(changeNum) > maxMana()) {
                //	if(kGAMECLASS.player.HP >= maxHP()) {
                //	if (display) HPChangeNotify(changeNum);
                //		return kGAMECLASS.player.HP - before;
                //	}
                //	if (display) HPChangeNotify(changeNum);
                kGAMECLASS.player.mana = maxMana();
            }
            else {
                //	if (display) HPChangeNotify(changeNum);
                kGAMECLASS.player.mana += int(changeNum);
                //	kGAMECLASS.mainView.statsView.showStatUp( 'hp' );
                // hpUp.visible = true;
            }
        }
        //Negative Mana
        /*	else
            {
                if(kGAMECLASS.player.HP + changeNum <= 0) {
                    if (display) HPChangeNotify(changeNum);
                    kGAMECLASS.player.HP = 0;
                    kGAMECLASS.mainView.statsView.showStatDown( 'hp' );
                }
                else {
                    if (display) HPChangeNotify(changeNum);
                    kGAMECLASS.player.HP += changeNum;
                    kGAMECLASS.mainView.statsView.showStatDown( 'hp' );
                }
            }
            dynStats("lust", 0, "scale", false) //Workaround to showing the arrow.
        */
        statScreenRefresh();
        return kGAMECLASS.player.mana - before;
    }

    public static function WrathChange(changeNum:Number, display:Boolean):Number {
        var before:Number = kGAMECLASS.player.wrath;
        if (changeNum == 0) return 0;
        if (changeNum > 0) {
            if (kGAMECLASS.player.wrath + int(changeNum) > maxWrath()) {
                //	if(kGAMECLASS.player.HP >= maxHP()) {
                //	if (display) HPChangeNotify(changeNum);
                //		return kGAMECLASS.player.HP - before;
                //	}
                //	if (display) HPChangeNotify(changeNum);
                kGAMECLASS.player.wrath = maxWrath();
            }
            else {
                //	if (display) HPChangeNotify(changeNum);
                kGAMECLASS.player.wrath += int(changeNum);
                //	kGAMECLASS.mainView.statsView.showStatUp( 'hp' );
                // hpUp.visible = true;
            }
        }
        //Negative Wrath
        /*	else
            {
                if(kGAMECLASS.player.HP + changeNum <= 0) {
                    if (display) HPChangeNotify(changeNum);
                    kGAMECLASS.player.HP = 0;
                    kGAMECLASS.mainView.statsView.showStatDown( 'hp' );
                }
                else {
                    if (display) HPChangeNotify(changeNum);
                    kGAMECLASS.player.HP += changeNum;
                    kGAMECLASS.mainView.statsView.showStatDown( 'hp' );
                }
            }
            dynStats("lust", 0, "scale", false) //Workaround to showing the arrow.
        */
        statScreenRefresh();
        return kGAMECLASS.player.wrath - before;
    }

    public static function clone(source:Object):* {
        var copier:ByteArray = new ByteArray();
        copier.writeObject(source);
        copier.position = 0;
        return (copier.readObject());
    }

    public static function clearOutputTextOnly(forget:Boolean = false):void {
        if (!forget && kGAMECLASS.currentText.length > 0) {
            kGAMECLASS.textHistory.push(kGAMECLASS.currentText);
            while (kGAMECLASS.textHistory.length > 20) kGAMECLASS.textHistory.shift();
        }
        kGAMECLASS.currentText = "";
        kGAMECLASS.mainView.clearOutputText();
    }

    /**
     * Clear the text on screen.
     */
    public static function clearOutput():void {
        kGAMECLASS.forceUpdate();
        clearOutputTextOnly();
        if (kGAMECLASS.gameState != 3) kGAMECLASS.mainView.hideMenuButton(MainView.MENU_DATA);
        kGAMECLASS.mainView.hideMenuButton(MainView.MENU_APPEARANCE);
        kGAMECLASS.mainView.hideMenuButton(MainView.MENU_LEVEL);
        kGAMECLASS.mainView.hideMenuButton(MainView.MENU_PERKS);
        kGAMECLASS.mainView.hideMenuButton(MainView.MENU_STATS);
    }

    /**
     * Basically the same as outputText() but without the parser tags. Great for displaying square brackets on text.
     * @param    output The text to show. It can be formatted such as bold, italics, and underline tags.
     * @param    purgeText Clear the old text.
     */
    public static function rawOutputText(output:String, purgeText:Boolean = false):void {

        //OUTPUT!
        if (purgeText) {
            //if(!debug) mainText.htmlText = output;
            //trace("Purging and writing Text", output);
            clearOutput();
            kGAMECLASS.currentText = output;
            kGAMECLASS.mainView.setOutputText(output);
            // mainText.htmlText = output;
        }
        else {
            //trace("Adding Text");
            kGAMECLASS.currentText += output;
            kGAMECLASS.mainView.appendOutputText(output);
            // mainText.htmlText += output;
        }
        // trace(getCurrentStackTrace())
        // scrollBar.update();

    }

    /**
     * Output the text on main text interface.
     * @param    output The text to show. It can be formatted such as bold, italics, and underline tags.
     * @param    purgeText Clear the old text.
     * @param    parseAsMarkdown Parses the text using Markdown.
     */
    public static function outputText(output:String):void {
        // we have to purge the output text BEFORE calling parseText, because if there are scene commands in
        // the parsed text, parseText() will write directly to the output


        // This is cleaup in case someone hits the Data or new-game button when the event-test window is shown.
        // It's needed since those buttons are available even when in the event-tester
        kGAMECLASS.mainView.hideTestInputPanel();


        output = kGAMECLASS.parser.recursiveParser(output, false);

        //OUTPUT!
        kGAMECLASS.currentText += output;
        //if(!debug) mainText.htmlText = kGAMECLASS.currentText;
        /*if(debug)
        {
            kGAMECLASS.mainView.setOutputText( kGAMECLASS.currentText );
        }*/

    }

    public static function displayHeader(string:String):void {
        outputText("<font size=\"36\" face=\"Georgia\"><u>" + string + "</u></font>\n");
    }

    public static function buttonIsVisible(index:int):Boolean {
        if (index < 0 || index > 14) {
            return undefined;
        }
        else {
            return button(index).visible;
        }
    }

    public static function buttonText(buttonName:String):String {
        var matches:*,
                buttonIndex:int;

        if (buttonName is String) {
            if (/^buttons\[[0-9]]/.test(buttonName)) {
                matches = /^buttons\[([0-9])]/.exec(buttonName);
                buttonIndex = parseInt(matches[1], 10);
            }
            else if (/^b[0-9]Text$/.test(buttonName)) {
                matches = /^b([0-9])Text$/.exec(buttonName);
                buttonIndex = parseInt(matches[1], 10);

                buttonIndex = buttonIndex === 0 ? 9 : buttonIndex - 1;
            }
        }

        return (getButtonText(buttonIndex) || "NULL");
    }

    public static function buttonTextIsOneOf(index:int, possibleLabels:Array):Boolean {
        var label:String,
                buttonText:String;

        buttonText = getButtonText(index);

        return (possibleLabels.indexOf(buttonText) != -1);
    }

    public static function getButtonText(index:int):String {
        var matches:*;

        if (index < 0 || index > 14) {
            return '';
        }
        else {
            return button(index).labelText;
        }
    }

    public static function getButtonToolTipHeader(buttonText:String):String {
        var toolTipHeader:String;

        if (buttonText.indexOf(" x") != -1) {
            buttonText = buttonText.split(" x")[0];
        }

        //Get items
        var itype:ItemType = ItemType.lookupItem(buttonText);
        var temp:String = "";
        if (itype != null) temp = itype.longName;
        itype = ItemType.lookupItemByShort(buttonText);
        if (itype != null) temp = itype.longName;
        if (temp != "") {
            temp = Utils.capitalizeFirstLetter(temp);
            toolTipHeader = temp;
        }

        //Set tooltip header to button.
        if (toolTipHeader == null) {
            toolTipHeader = buttonText;
        }

        return toolTipHeader;
    }

    public static function getButtonToolTipText(buttonText:String):String {
        var toolTipText:String;

        buttonText = buttonText || '';

        //Items
        //if (/^....... x\d+$/.test(buttonText)){
        //	buttonText = buttonText.substring(0,7);
        //}

        // Fuck your regex
        if (buttonText.indexOf(" x") != -1) {
            buttonText = buttonText.split(" x")[0];
        }

        var itype:ItemType = ItemType.lookupItem(buttonText);
        if (itype != null) toolTipText = itype.description;
        itype = ItemType.lookupItemByShort(buttonText);
        if (itype != null) toolTipText = itype.description;

        //------------
        // COMBAT
        //------------
        if (buttonText.indexOf("Defend") != -1) { //Not used at the moment.
            toolTipText = "Selecting defend will reduce the damage you take by 66 percent, but will not affect any lust incurred by your enemy's actions.";
        }
        //Urta's specials - MOVED
        //P. Special attacks - MOVED
        //M. Special attacks - MOVED

        //------------
        // MASTURBATION
        //------------
        //Masturbation Toys
        if (buttonText == "Masturbate") {
            toolTipText = "Selecting this option will make you attempt to manually masturbate in order to relieve your lust buildup.";
        }
        if (buttonText == "Meditate") {
            toolTipText = "Selecting this option will make you attempt to meditate in order to reduce lust and corruption.";
        }
        if (buttonText.indexOf("AN Stim-Belt") != -1) {
            toolTipText = "This is an all-natural self-stimulation belt.  The methods used to create such a pleasure device are unknown.  It seems to be organic in nature.";
        }
        if (buttonText.indexOf("Stim-Belt") != -1) {
            toolTipText = "This is a self-stimulation belt.  Commonly referred to as stim-belts, these are clockwork devices designed to pleasure the female anatomy.";
        }
        if (buttonText.indexOf("AN Onahole") != -1) {
            toolTipText = "An all-natural onahole, this device looks more like a bulbous creature than a sex-toy.  Nevertheless, the slick orifice it presents looks very inviting.";
        }
        if (buttonText.indexOf("D Onahole") != -1) {
            toolTipText = "This is a deluxe onahole, made of exceptional materials and with the finest craftsmanship in order to bring its user to the height of pleasure.";
        }
        if (buttonText.indexOf("Onahole") != -1) {
            toolTipText = "This is what is called an 'onahole'.  This device is a simple textured sleeve designed to fit around the male anatomy in a pleasurable way.";
        }
        if (buttonText.indexOf("Dual Belt") != -1) {
            toolTipText = "This is a strange masturbation device, meant to work every available avenue of stimulation.";
        }
        if (buttonText.indexOf("C. Pole") != -1) {
            toolTipText = "This 'centaur pole' as it's called appears to be a sex-toy designed for females of the equine persuasion.  Oddly, it's been sculpted to look like a giant imp, with an even bigger horse-cock.";
        }
        if (buttonText.indexOf("Fake Mare") != -1) {
            toolTipText = "This fake mare is made of metal and wood, but the anatomically correct vagina looks as soft and wet as any female centaur's.";
        }
        //Books
        if (buttonText.indexOf("Dangerous Plants") != -1) {
            toolTipText = "This is a book titled 'Dangerous Plants'.  As explained by the title, this tome is filled with information on all manner of dangerous plants from this realm.";
        }
        if (buttonText.indexOf("Traveler's Guide") != -1) {
            toolTipText = "This traveler's guide is more of a pamphlet than an actual book, but it still contains some useful information on avoiding local pitfalls.";
        }
        if (buttonText.indexOf("Yoga Guide") != -1) {
            toolTipText = "This leather-bound book is titled 'Yoga for Non-Humanoids.' It contains numerous illustrations of centaurs, nagas and various other oddly-shaped beings in a variety of poses.";
        }
        if (buttonText.indexOf("Hentai Comic") != -1) {
            toolTipText = "This oddly drawn comic book is filled with images of fornication, sex, and overly large eyeballs.";
        }
        //------------
        // TITLE SCREEN
        //------------
        if (buttonText.indexOf("ASPLODE") != -1) {
            toolTipText = "MAKE SHIT ASPLODE";
        }
        return toolTipText;
    }

    public static function getFunctionName(f:Function):String {
        // trace("Getting function name")
        // get the object that contains the function (this of f)
        //var t:Object = flash.sampler.getSavedThis(f);
        if (funcLookups == null) {
            trace("Rebuilding lookup object");
            funcLookups = new Dictionary();
            buildFuncLookupDict();
        }


        if (f in funcLookups)
            return (funcLookups[f]);

        // if we arrive here, we haven't found anything...
        // maybe the function is declared in the private namespace?
        return null;
    }

    public static function createCallBackFunction(func:Function, arg:*, arg2:* = null, arg3:* = null):Function {
        if (func == null) {
            CoC_Settings.error("createCallBackFunction(null," + arg + ")");
        }
        if (arg == -9000 || arg == null) {
            /*		if (func == eventParser){
                        CoC_Settings.error("createCallBackFunction(eventParser,"+arg+")");
                    } */
            return function ():* {
                if (CoC_Settings.haltOnErrors)
                    logFunctionInfo(func, arg);
                return func();
            };
        }
        else {
            if (arg2 == -9000 || arg2 == null) {
                return function ():* {
                    if (CoC_Settings.haltOnErrors)
                        logFunctionInfo(func, arg);
                    return func(arg);
                };
            }
            else {
                if (arg3 == -9000 || arg3 == null) {
                    return function ():* {
                        if (CoC_Settings.haltOnErrors)
                            logFunctionInfo(func, arg, arg2);
                        return func(arg, arg2);
                    };
                }
                else {
                    return function ():* {
                        if (CoC_Settings.haltOnErrors)
                            logFunctionInfo(func, arg, arg2, arg3);
                        return func(arg, arg2, arg3);
                    };
                }
            }
        }
    }

    public static function createCallBackFunction2(func:Function, ...args):Function {
        if (func == null) {
            CoC_Settings.error("createCallBackFunction(null," + args + ")");
        }
        return function ():* {
            if (CoC_Settings.haltOnErrors) logFunctionInfo(func, args);
            return func.apply(null, args);
        }
    }

    /**
     * Adds a button.
     * @param    pos Determines the position. Starts at 0. (First row is 0-4, second row is 5-9, third row is 10-14.)
     * @param    text Determines the text that will appear on button.
     * @param    func1 Determines what function to trigger.
     * @param    arg1 Pass argument #1 to func1 parameter.
     * @param    arg2 Pass argument #1 to func1 parameter.
     * @param    arg3 Pass argument #1 to func1 parameter.
     * @param    toolTipText The text that will appear on tooltip when the mouse goes over the button.
     * @param    toolTipHeader The text that will appear on the tooltip header. If not specified, it defaults to button text.
     */
    public static function addButton(pos:int, text:String = "", func1:Function = null, arg1:* = -9000, arg2:* = -9000, arg3:* = -9000, toolTipText:String = "", toolTipHeader:String = ""):CoCButton {
        var btn:CoCButton = button(pos);
        if (func1 == null) {
            return btn.hide();
        }
        var callback:Function;
        /*
            Let the mainView decide if index is valid
            if(pos > 14) {
                trace("INVALID BUTTON");
                return;
            }
        */
        //Removes sex-related button in SFW mode.
        if (kGAMECLASS.flags[kFLAGS.SFW_MODE] > 0) {
            if (text.indexOf("Sex") != -1 || text.indexOf("Threesome") != -1 || text.indexOf("Foursome") != -1 || text == "Watersports" || text == "Make Love" || text == "Use Penis" || text == "Use Vagina" || text.indexOf("Fuck") != -1 || text.indexOf("Ride") != -1 || (text.indexOf("Mount") != -1 && text.indexOf("Mountain") == -1) || text.indexOf("Vagina") != -1) {
                trace("Button removed due to SFW mode.");
                return btn.hide();
            }
        }
        callback = createCallBackFunction(func1, arg1, arg2, arg3);

        if (toolTipText == "") toolTipText = getButtonToolTipText(text);
        if (toolTipHeader == "") toolTipHeader = getButtonToolTipHeader(text);
        btn.show(text, callback, toolTipText, toolTipHeader);
        //kGAMECLASS.mainView.setOutputText( kGAMECLASS.currentText );
        kGAMECLASS.flushOutputTextToGUI();
        return btn;
    }

    public static function addButtonDisabled(pos:int, text:String = "", toolTipText:String = "", toolTipHeader:String = ""):CoCButton {
        var btn:CoCButton = button(pos);
        //Removes sex-related button in SFW mode.
        if (kGAMECLASS.flags[kFLAGS.SFW_MODE] > 0) {
            if (text.indexOf("Sex") != -1 || text.indexOf("Threesome") != -1 || text.indexOf("Foursome") != -1 || text == "Watersports" || text == "Make Love" || text == "Use Penis" || text == "Use Vagina" || text.indexOf("Fuck") != -1 || text.indexOf("Ride") != -1 || (text.indexOf("Mount") != -1 && text.indexOf("Mountain") == -1) || text.indexOf("Vagina") != -1) {
                trace("Button removed due to SFW mode.");
                return btn.hide();
            }
        }

        if (toolTipText == "") toolTipText = getButtonToolTipText(text);
        if (toolTipHeader == "") toolTipHeader = getButtonToolTipHeader(text);
        btn.showDisabled(text, toolTipText, toolTipHeader);
        kGAMECLASS.flushOutputTextToGUI();
        return btn;
    }

    public static function button(pos:int):CoCButton {
        return kGAMECLASS.mainView.bottomButtons[pos];
    }

    public static function setButtonTooltip(index:int, toolTipHeader:String = "", toolTipText:String = ""):void {
        button(index).hint(toolTipText, toolTipHeader);
    }

    public static function hasButton(arg:*):Boolean {
        if (arg is String)
            return kGAMECLASS.mainView.hasButton(arg as String);
        else
            return false;
    }

    /**
     * Removes a button.
     * @param    arg The position to remove a button. (First row is 0-4, second row is 5-9, third row is 10-14.)
     */
    public static function removeButton(arg:*):void {
        var buttonToRemove:int = 0;
        if (arg is String) {
            buttonToRemove = kGAMECLASS.mainView.indexOfButtonWithLabel(arg as String);
        }
        if (arg is Number) {
            if (arg < 0 || arg > 14) return;
            buttonToRemove = int(arg);
        }
        kGAMECLASS.mainView.hideBottomButton(buttonToRemove);
    }

    /**
     * Hides all bottom buttons.
     */
    public static function menu():void { //The newer, simpler menu - blanks all buttons so addButton can be used
        for (var i:int = 0; i <= 14; i++) {
            kGAMECLASS.mainView.hideBottomButton(i);
        }
        kGAMECLASS.flushOutputTextToGUI();
    }

    /**
     * Adds buttons that can be chosen.
     *
     * I highly recommend you <b>DO NOT</b> use this for new content. Use addButton() instead.
     */
    public static function choices(text1:String, butt1:Function,
                                   text2:String, butt2:Function,
                                   text3:String, butt3:Function,
                                   text4:String, butt4:Function,
                                   text5:String, butt5:Function,
                                   text6:String, butt6:Function,
                                   text7:String, butt7:Function,
                                   text8:String, butt8:Function,
                                   text9:String, butt9:Function,
                                   text0:String, butt0:Function):void { //New typesafe version

        menu();
        addButton(0, text1, butt1);
        addButton(1, text2, butt2);
        addButton(2, text3, butt3);
        addButton(3, text4, butt4);
        addButton(4, text5, butt5);
        addButton(5, text6, butt6);
        addButton(6, text7, butt7);
        addButton(7, text8, butt8);
        addButton(8, text9, butt9);
        addButton(9, text0, butt0);
    }

    /****
     This function is made for multipage menus of unpredictable length,
     say a collection of items or places or people that can change
     depending on certain events, past choices, the time of day, or whatever.

     This is not the best for general menu use.  Use choices() for that.

     This is a bit confusing, so here's usage instructions.
     Pay attention to all the braces.

     This is made to be used with an array that you create before calling it,
     so that you can push as many items on to that array as you like
     before passing that array off to this function.

     So you can do something like this:
     var itemsInStorage :Array = new Array();

     // The extra square braces are important.
     itemsInStorage.push( [ "Doohicky", useDoohickyFunc ] );
     itemsInStorage.push( [ "Whatsit", useWhatsitFunc ] );
     itemsInStorage.push( [ "BagOfDicks", eatBagOfDicks ] );
     ...

     // see notes about cancelFunc
     multipageChoices( cancelFunc, itemsInStorage );

     cancelfunc is a function (A button event function, specifically)
     that exits the menu.  Provide this if you want a Back button to appear
     in the bottom right.

     If you do not need a cancel function, perhaps because some or all
     of the choices will exit the menu, then you can
     pass null or 0 for the cancelFunction.

     // This menu shows no Back button.
     multipageChoices( null, itemsInStorage );

     You can call it directly if you want, but that's ridiculous.
     multipageChoices( justGoToCamp, [
     [ "Do this", doThisEvent ],
     [ "Do that", doThatEvent ],
     [ "Do something", doSomethingEvent ],
     [ "Fap", goFapEvent ],
     [ "Rape Jojo", jojoRape ],
     // ... more items here...
     [ "What", goWhat ],
     [ "Margle", gurgleFluidsInMouthEvent ] // no comma on last item.
     ]);
     ****/
    public static function multipageChoices(cancelFunction:*, menuItems:Array):void {
        const itemsPerPage:int = 8;

        var currentPageIndex:int;
        var pageCount:int;

        function getPageOfItems(pageIndex:int):Array {
            var startItemIndex:int = pageIndex * itemsPerPage;

            return menuItems.slice(startItemIndex, startItemIndex + itemsPerPage);
        }

        function flatten(pageItems:Array):Array {
            var i:int, l:int;
            var flattenedItems:Array = [];

            for (i = 0, l = pageItems.length; i < l; ++i) {
                flattenedItems = flattenedItems.concat(pageItems[i]);
            }

            return flattenedItems;
        }

        function showNextPage():void {
            showPage((currentPageIndex + 1) % pageCount);
        }

        function showPage(pageIndex:int):void {
            var currentPageItems:Array; // holds the current page of items.

            if (pageIndex < 0)
                pageIndex = 0;
            if (pageIndex >= pageCount)
                pageIndex = pageCount - 1;

            currentPageIndex = pageIndex;
            currentPageItems = getPageOfItems(pageIndex);

            // I did it this way so as to use only one actual menu setting function.
            // I figured it was safer until the menu functions stabilize.

            // insert page functions.
            // First pad out the items so it's always in a predictable state.
            while (currentPageItems.length < 8) {
                currentPageItems.push(["", 0]);
            }

            // Insert next button.
            currentPageItems.splice(4, 0, [
                "See page " +
                String(((currentPageIndex + 1) % pageCount) + 1) + // A compelling argument for 1-indexing?
                '/' +
                String(pageCount),
                pageCount > 1 ? showNextPage : 0
                // "Next Page", pageCount > 1 ? showNextPage : 0
            ]);

            // Cancel/Back button always appears in bottom right, like in the inventory.
            currentPageItems.push([
                "Back", cancelFunction || 0
            ]);

            choices.apply(null, flatten(currentPageItems));
        }

        pageCount = Math.ceil(menuItems.length / itemsPerPage);

        if (typeof cancelFunction != 'function')
            cancelFunction = 0;

        showPage(0);
    }

    /**
     * Adds five button that can be chosen.
     *
     * I highly recommend you <b>DO NOT</b> use this for new content. Use addButton() instead.
     */
    public static function simpleChoices(text1:String, butt1:Function,
                                         text2:String, butt2:Function,
                                         text3:String, butt3:Function,
                                         text4:String, butt4:Function,
                                         text5:String, butt5:Function):void {
        menu();
        addButton(0, text1, butt1);
        addButton(1, text2, butt2);
        addButton(2, text3, butt3);
        addButton(3, text4, butt4);
        addButton(4, text5, butt5);
    }

    /**
     * Clears all button and adds a 'Yes' and a 'No' button.
     * @param    eventYes The event parser or function to call if 'Yes' button is pressed.
     * @param    eventNo The event parser or function to call if 'No' button is pressed.
     */
    public static function doYesNo(eventYes:Function, eventNo:Function):void {
        menu();
        addButton(0, "Yes", eventYes);
        addButton(1, "No", eventNo);
    }

    /**
     * Clears all button and adds a 'Next' button.
     * @param    event The event function to call if the button is pressed.
     */
    public static function doNext(event:Function):void { //Now typesafe
        //Prevent new events in combat from automatically overwriting a game over.
        if (kGAMECLASS.mainView.getButtonText(0).indexOf("Game Over") != -1) {
            trace("Do next setup cancelled by game over");
            return;
        }

        //trace("DoNext have item:", eventNo);
        //choices("Next", event, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0);
        menu();
        addButton(0, "Next", event);
    }

    public static function invertGo():void {
        kGAMECLASS.mainView.invert();
    }

    /**
     * Used to update the display of statistics
     */
    public static function statScreenRefresh():void {
        Utils.Begin("engineCore", "statScreenRefresh");
        kGAMECLASS.mainView.statsView.show(); // show() method refreshes.
        kGAMECLASS.mainViewManager.refreshStats();
        Utils.End("engineCore", "statScreenRefresh");
    }

    /**
     * Show the stats pane. (Name, stats and attributes)
     */
    public static function showStats():void {
        kGAMECLASS.mainView.statsView.show();
        kGAMECLASS.mainViewManager.refreshStats();
        kGAMECLASS.mainViewManager.tweenInStats();
    }

    /**
     * Hide the stats pane. (Name, stats and attributes)
     */
    public static function hideStats():void {
        if (!kGAMECLASS.mainViewManager.buttonsTweened) kGAMECLASS.mainView.statsView.hide();
        kGAMECLASS.mainViewManager.tweenOutStats();
    }

    /**
     * Hide the top buttons.
     */
    public static function hideMenus():void {
        kGAMECLASS.mainView.hideAllMenuButtons();
    }

    /**
     * Hides the up/down arrow on stats pane.
     */
    public static function hideUpDown():void {
        kGAMECLASS.mainView.statsView.hideUpDown();
        //Clear storage values so up/down arrows can be properly displayed
        kGAMECLASS.oldStats.oldStr = 0;
        kGAMECLASS.oldStats.oldTou = 0;
        kGAMECLASS.oldStats.oldSpe = 0;
        kGAMECLASS.oldStats.oldInte = 0;
        kGAMECLASS.oldStats.oldWis = 0;
        kGAMECLASS.oldStats.oldLib = 0;
        kGAMECLASS.oldStats.oldSens = 0;
        kGAMECLASS.oldStats.oldCor = 0;
        kGAMECLASS.oldStats.oldHP = 0;
        kGAMECLASS.oldStats.oldLust = 0;
        kGAMECLASS.oldStats.oldWrath = 0;
        kGAMECLASS.oldStats.oldFatigue = 0;
        kGAMECLASS.oldStats.oldMana = 0;
        kGAMECLASS.oldStats.oldSoulforce = 0;
        kGAMECLASS.oldStats.oldHunger = 0;
    }

    public static function fatigue(mod:Number, type:Number = 0):void {
        SceneLib.combat.fatigueImpl(mod, type);
    }

    public static function changeFatigue(changeF:Number):void {
        fatigue(changeF);
    }

    public static function minLust():Number {
        return kGAMECLASS.player.minLust();
    }

    public static function openURL(url:String):void {
        navigateToURL(new URLRequest(url), "_blank");
    }

    /**
     * Awards the achievement. Will display a blue text if achievement hasn't been earned.
     * @param    title The name of the achievement.
     * @param    achievement The achievement to be awarded.
     * @param    display Determines if achievement earned should be displayed.
     * @param    nl Inserts a new line before the achievement text.
     * @param    nl2 Inserts a new line after the achievement text.
     */
    public static function awardAchievement(title:String, achievement:*, display:Boolean = true, nl:Boolean = false, nl2:Boolean = true):void {
        if (kGAMECLASS.achievements[achievement] != null) {
            if (kGAMECLASS.achievements[achievement] <= 0) {
                kGAMECLASS.achievements[achievement] = 1;
                if (nl && display) outputText("\n");
                if (display) outputText("<b><font color=\"#000080\">Achievement unlocked: " + title + "</font></b>");
                if (nl2 && display) outputText("\n");
                kGAMECLASS.saves.savePermObject(false); //Only save if the achievement hasn't been previously awarded.
            }
        }
        else outputText("\n<b>ERROR: Invalid achievement!</b>");
    }

    public static function lustPercent():Number {
        return kGAMECLASS.player.lustPercent();
    }

    public static function applyOperator(old:Number, op:String, val:Number):Number {
        switch (op) {
            case "=":
                return val;
            case "+":
                return old + val;
            case "-":
                return old - val;
            case "*":
                return old * val;
            case "/":
                return old / val;
            default:
                trace("applyOperator(" + old + ",'" + op + "'," + val + ") unknown op");
                return old;
        }
    }

    public static function testDynStatsEvent():void {
        clearOutput();
        outputText("Old: " + kGAMECLASS.player.str + " " + kGAMECLASS.player.tou + " " + kGAMECLASS.player.spe + " " + kGAMECLASS.player.inte + " " + kGAMECLASS.player.lib + " " + kGAMECLASS.player.sens + " " + kGAMECLASS.player.lust + "\n");
        kGAMECLASS.player.dynStats("tou", 1, "spe+", 2, "int-", 3, "lib*", 2, "sen=", 25, "lust/", 2);
        outputText("Mod: 0 1 +2 -3 *2 =25 /2\n");
        outputText("New: " + kGAMECLASS.player.str + " " + kGAMECLASS.player.tou + " " + kGAMECLASS.player.spe + " " + kGAMECLASS.player.inte + " " + kGAMECLASS.player.lib + " " + kGAMECLASS.player.sens + " " + kGAMECLASS.player.lust + "\n");
        doNext(EventParser.playerMenu);
    }

    public static function showUpDown():void { //Moved from StatsView.
        Utils.Begin("engineCore", "showUpDown");

        function _oldStatNameFor(statName:String):String {
            return 'old' + statName.charAt(0).toUpperCase() + statName.substr(1);
        }

        var statName:String,
                oldStatName:String,
                allStats:Array;

//	kGAMECLASS.mainView.statsView.upDownsContainer.visible = true;

        allStats = ["str", "tou", "spe", "inte", "wis", "lib", "sens", "cor", "HP", "lust", "wrath", "fatigue", "mana", "soulforce", "hunger"];

        for each(statName in allStats) {
            oldStatName = _oldStatNameFor(statName);

            if (kGAMECLASS.player[statName] > kGAMECLASS.oldStats[oldStatName]) {
                kGAMECLASS.mainView.statsView.showStatUp(statName);
            }
            if (kGAMECLASS.player[statName] < kGAMECLASS.oldStats[oldStatName]) {
                kGAMECLASS.mainView.statsView.showStatDown(statName);
            }
        }
        Utils.End("engineCore", "showUpDown");
    }

    public static function range(min:Number, max:Number, round:Boolean = false):Number {
        var num:Number = (min + Math.random() * (max - min));

        if (round) return Math.round(num);
        return num;
    }

    public static function cuntChangeOld(cIndex:Number, vIndex:Number, display:Boolean):void {
        //Virginity check
        if (kGAMECLASS.player.vaginas[vIndex].virgin) {
            if (display) outputText("\nYour " + Appearance.vaginaDescript(kGAMECLASS.player,vIndex) + " loses its virginity!");
            kGAMECLASS.player.vaginas[vIndex].virgin = false;
        }
        //If cock is bigger than unmodified vagina can hold - 100% stretch!
        if (kGAMECLASS.player.vaginas[vIndex].capacity() <= kGAMECLASS.monster.cocks[cIndex].cArea()) {
            if (kGAMECLASS.player.vaginas[vIndex].vaginalLooseness < 5) {
                trace("CUNT STRETCHED: By cock larger than it's total capacity.");
                if (display) {
                    if (kGAMECLASS.player.vaginas[vIndex].vaginalLooseness == AppearanceDefs.VAGINA_LOOSENESS_GAPING_WIDE) outputText("<b>Your " + Appearance.vaginaDescript(kGAMECLASS.player,0) + " is stretched even further, capable of taking even the largest of demons and beasts.</b>  ");
                    if (kGAMECLASS.player.vaginas[vIndex].vaginalLooseness == AppearanceDefs.VAGINA_LOOSENESS_GAPING) outputText("<b>Your " + Appearance.vaginaDescript(kGAMECLASS.player,0) + " painfully stretches, gaping wide-open.</b>  ");
                    if (kGAMECLASS.player.vaginas[vIndex].vaginalLooseness == AppearanceDefs.VAGINA_LOOSENESS_LOOSE) outputText("<b>Your " + Appearance.vaginaDescript(kGAMECLASS.player,0) + " is now very loose.</b>  ");
                    if (kGAMECLASS.player.vaginas[vIndex].vaginalLooseness == AppearanceDefs.VAGINA_LOOSENESS_NORMAL) outputText("<b>Your " + Appearance.vaginaDescript(kGAMECLASS.player,0) + " is now loose.</b>  ");
                    if (kGAMECLASS.player.vaginas[vIndex].vaginalLooseness == AppearanceDefs.VAGINA_LOOSENESS_TIGHT) outputText("<b>Your " + Appearance.vaginaDescript(kGAMECLASS.player,0) + " loses its virgin-like tightness.</b>  ");
                }
                kGAMECLASS.player.vaginas[vIndex].vaginalLooseness++;
            }
        }
        //If cock is within 75% of max, streeeeetch 33% of the time
        if (kGAMECLASS.player.vaginas[vIndex].capacity() * .75 <= kGAMECLASS.monster.cocks[cIndex].cArea()) {
            if (kGAMECLASS.player.vaginas[vIndex].vaginalLooseness < 5) {
                trace("CUNT STRETCHED: By cock @ 75% of capacity.");
                if (display) {
                    if (kGAMECLASS.player.vaginas[vIndex].vaginalLooseness == AppearanceDefs.VAGINA_LOOSENESS_GAPING_WIDE) outputText("<b>Your " + Appearance.vaginaDescript(kGAMECLASS.player,0) + " is stretched even further, capable of taking even the largest of demons and beasts.</b>  ");
                    if (kGAMECLASS.player.vaginas[vIndex].vaginalLooseness == AppearanceDefs.VAGINA_LOOSENESS_GAPING) outputText("<b>Your " + Appearance.vaginaDescript(kGAMECLASS.player,0) + " painfully stretches, gaping wide-open.</b>  ");
                    if (kGAMECLASS.player.vaginas[vIndex].vaginalLooseness == AppearanceDefs.VAGINA_LOOSENESS_LOOSE) outputText("<b>Your " + Appearance.vaginaDescript(kGAMECLASS.player,0) + " is now very loose.</b>  ");
                    if (kGAMECLASS.player.vaginas[vIndex].vaginalLooseness == AppearanceDefs.VAGINA_LOOSENESS_NORMAL) outputText("<b>Your " + Appearance.vaginaDescript(kGAMECLASS.player,0) + " is now loose.</b>  ");
                    if (kGAMECLASS.player.vaginas[vIndex].vaginalLooseness == AppearanceDefs.VAGINA_LOOSENESS_TIGHT) outputText("<b>Your " + Appearance.vaginaDescript(kGAMECLASS.player,0) + " loses its virgin-like tightness.</b>  ");
                }
                kGAMECLASS.player.vaginas[vIndex].vaginalLooseness++;
            }
        }
    }

    /**
     * Returns true if you're on SFW mode.
     */
    public static function doSFWloss():Boolean {
        clearOutput();
        if (kGAMECLASS.flags[kFLAGS.SFW_MODE] > 0) {
            if (kGAMECLASS.player.HP <= 0) outputText("You collapse from your injuries.");
            else outputText("You collapse from your overwhelming desires.");
            if (kGAMECLASS.inCombat) kGAMECLASS.cleanupAfterCombat();
            else doNext(SceneLib.camp.returnToCampUseOneHour);
            return true;
        }
        else return false;
    }

    public static function doNothing():void {
        //This literally does nothing.
    }

    private static function buildFuncLookupDict(object:* = null, prefix:String = ""):void {
        trace("Building function <-> function name mapping table for " + ((object == null) ? "CoC." : prefix));
        // get all methods contained
        if (object == null) object = new EngineCore();
        var typeDesc:XML = describeType(object);
        //trace("TypeDesc - ", typeDesc)

        for each (var node:XML in typeDesc..method) {
            // return the method name if the thisObject of f (t)
            // has a property by that name
            // that is not null (null = doesn't exist) and
            // is strictly equal to the function we search the name of
            //trace("this[node.@name] = ", this[node.@name], " node.@name = ", node.@name)
            if (object[node.@name] != null)
                funcLookups[object[node.@name]] = prefix + node.@name;
        }
        for each (node in typeDesc..variable) {
            if (node.@type.toString().indexOf("classes.Scenes.") == 0 ||
                    node.metadata.@name.contains("Scene")) {
                if (object[node.@name] != null) {
                    buildFuncLookupDict(object[node.@name], node.@name + ".");
                }
            }
        }
    }

    private static function logFunctionInfo(func:Function, arg:* = null, arg2:* = null, arg3:* = null):void {
        var logStr:String = "";
        if (arg is Function) {
            logStr += "Calling = " + getFunctionName(func) + " Param = " + getFunctionName(arg);
        }
        else {
            logStr += "Calling = " + getFunctionName(func) + " Param = " + arg;
        }
        CoC_Settings.appendButtonEvent(logStr);
        trace(logStr)
    }
}
}
