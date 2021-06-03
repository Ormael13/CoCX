package classes {
import classes.GlobalFlags.kFLAGS;
import classes.Parser.Parser;
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
        return CoC.instance.player.maxHP();
    }

    public static function maxOverHP():Number {
        return CoC.instance.player.maxOverHP();
    }

    public static function minHP():Number {
        return CoC.instance.player.minHP();
    }

    public static function maxSoulforce():Number {
        return CoC.instance.player.maxSoulforce();
    }

    public static function maxWrath():Number {
        return CoC.instance.player.maxWrath();
    }

    public static function maxOverWrath():Number {
        return CoC.instance.player.maxOverWrath();
    }

    public static function maxMana():Number {
        return CoC.instance.player.maxMana();
    }

    public static function silly():Boolean {
        return CoC.instance.flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] == 1;
    }

    /**
     * Alters player's HP.
     * @param    changeNum The amount to damage (negative) or heal (positive).
     * @param    display Show the damage or heal taken.
     * @return  effective delta
     */
    public static function HPChange(changeNum:Number, display:Boolean):Number {
        var before:Number = CoC.instance.player.HP;
		var healingFromHealer:Number = 1;
        if (changeNum == 0) return 0;
        if (changeNum > 0) {
            //Increase by 20%!
            if (CoC.instance.player.hasPerk(PerkLib.HistoryHealer) || CoC.instance.player.hasPerk(PerkLib.PastLifeHealer)) {
				healingFromHealer += 0.2;
				if (CoC.instance.player.hasPerk(PerkLib.Nurse)) healingFromHealer += 0.2;
				if (CoC.instance.player.hasPerk(PerkLib.Doctor)) healingFromHealer += 0.2;
				if (CoC.instance.player.hasPerk(PerkLib.FirstResponse)) healingFromHealer += 0.2;
				if (CoC.instance.player.hasPerk(PerkLib.Paramedic)) healingFromHealer += 0.2;
				if (CoC.instance.player.hasPerk(PerkLib.SurgeonsAide)) healingFromHealer += 0.2;
				if (CoC.instance.player.hasPerk(PerkLib.Surgeon)) healingFromHealer += 0.2;
				if (CoC.instance.player.hasPerk(PerkLib.Medic)) healingFromHealer += 0.2;
				changeNum *= healingFromHealer;
			}
            if (CoC.instance.player.HP + int(changeNum) > maxOverHP()) {
                if (CoC.instance.player.HP >= maxOverHP()) {
                    if (display) HPChangeNotify(changeNum);
                    return CoC.instance.player.HP - before;
                }
                if (display) HPChangeNotify(changeNum);
                CoC.instance.player.HP = maxOverHP();
            }
            else {
                if (display) HPChangeNotify(changeNum);
                CoC.instance.player.HP += int(changeNum);
                CoC.instance.mainView.statsView.showStatUp('hp');
                // hpUp.visible = true;
            }
        }
        //Negative HP
        else {
            if (CoC.instance.player.HP + changeNum <= minHP()) {
                if (display) HPChangeNotify(changeNum);
                CoC.instance.player.HP = minHP();
                CoC.instance.mainView.statsView.showStatDown('hp');
            }
            else {
                if (display) HPChangeNotify(changeNum);
                CoC.instance.player.HP += changeNum;
                CoC.instance.mainView.statsView.showStatDown('hp');
            }
        }
        CoC.instance.player.dynStats("lust", 0, "scale", false); //Workaround to showing the arrow.
        statScreenRefresh();
        return CoC.instance.player.HP - before;
    }

    public static function HPChangeNotify(changeNum:Number):void {
        if (changeNum == 0) {
            if (CoC.instance.player.HP >= maxOverHP())
                outputText("You're as healthy as you can be.\n");
        }
        else if (changeNum > 0) {
            if (CoC.instance.player.HP >= maxOverHP())
                outputText("Your HP maxes out at " + maxOverHP() + ".\n");
            else
                outputText("You gain <b><font color=\"#008000\">" + int(changeNum) + "</font></b> HP.\n");
        }
        else {
            if (CoC.instance.player.HP <= minHP())
                outputText("You take <b><font color=\"#800000\">" + int(changeNum * -1) + "</font></b> damage, dropping your HP to "+minHP()+".\n");
            else
                outputText("You take <b><font color=\"#800000\">" + int(changeNum * -1) + "</font></b> damage.\n");
        }
    }

    public static function SoulforceChange(changeNum:Number, display:Boolean):Number {
        var before:Number = CoC.instance.player.soulforce;
        if (changeNum == 0) return 0;
        if (changeNum > 0) {
            if (CoC.instance.player.soulforce + int(changeNum) > maxSoulforce()) {
                //	if(CoC.instance.player.HP >= maxHP()) {
                //	if (display) HPChangeNotify(changeNum);
                //		return CoC.instance.player.HP - before;
                //	}
                //	if (display) HPChangeNotify(changeNum);
                CoC.instance.player.soulforce = maxSoulforce();
            }
            else {
                //	if (display) HPChangeNotify(changeNum);
                CoC.instance.player.soulforce += int(changeNum);
                //	CoC.instance.mainView.statsView.showStatUp( 'hp' );
                // hpUp.visible = true;
            }
        }
        //Negative Soulforce
        /*	else
            {
                if(CoC.instance.player.HP + changeNum <= 0) {
                    if (display) HPChangeNotify(changeNum);
                    CoC.instance.player.HP = 0;
                    CoC.instance.mainView.statsView.showStatDown( 'hp' );
                }
                else {
                    if (display) HPChangeNotify(changeNum);
                    CoC.instance.player.HP += changeNum;
                    CoC.instance.mainView.statsView.showStatDown( 'hp' );
                }
            }
            dynStats("lust", 0, "scale", false) //Workaround to showing the arrow.
        */
        statScreenRefresh();
        return CoC.instance.player.soulforce - before;
    }

    public static function ManaChange(changeNum:Number, display:Boolean):Number {
        var before:Number = CoC.instance.player.mana;
        if (changeNum == 0) return 0;
        if (changeNum > 0) {
            if (CoC.instance.player.mana + int(changeNum) > maxMana()) {
                //	if(CoC.instance.player.HP >= maxHP()) {
                //	if (display) HPChangeNotify(changeNum);
                //		return CoC.instance.player.HP - before;
                //	}
                //	if (display) HPChangeNotify(changeNum);
                CoC.instance.player.mana = maxMana();
            }
            else {
                //	if (display) HPChangeNotify(changeNum);
                CoC.instance.player.mana += int(changeNum);
                //	CoC.instance.mainView.statsView.showStatUp( 'hp' );
                // hpUp.visible = true;
            }
        }
        //Negative Mana
        /*	else
            {
                if(CoC.instance.player.HP + changeNum <= 0) {
                    if (display) HPChangeNotify(changeNum);
                    CoC.instance.player.HP = 0;
                    CoC.instance.mainView.statsView.showStatDown( 'hp' );
                }
                else {
                    if (display) HPChangeNotify(changeNum);
                    CoC.instance.player.HP += changeNum;
                    CoC.instance.mainView.statsView.showStatDown( 'hp' );
                }
            }
            dynStats("lust", 0, "scale", false) //Workaround to showing the arrow.
        */
        statScreenRefresh();
        return CoC.instance.player.mana - before;
    }

    public static function WrathChange(changeNum:Number, display:Boolean):Number {
        var before:Number = CoC.instance.player.wrath;
        if (changeNum == 0) return 0;
        if (changeNum > 0) {
            if (CoC.instance.player.wrath + int(changeNum) > maxOverWrath()) {
                //	if(CoC.instance.player.HP >= maxHP()) {
                //	if (display) HPChangeNotify(changeNum);
                //		return CoC.instance.player.HP - before;
                //	}
                //	if (display) HPChangeNotify(changeNum);
                CoC.instance.player.wrath = maxOverWrath();
            }
            else {
                //	if (display) HPChangeNotify(changeNum);
                CoC.instance.player.wrath += int(changeNum);
                //	CoC.instance.mainView.statsView.showStatUp( 'hp' );
                // hpUp.visible = true;
            }
        }
        //Negative Wrath
        else {
            if (CoC.instance.player.wrath + changeNum <= 0) {
                //if (display) HPChangeNotify(changeNum);
                CoC.instance.player.wrath = 0;
                //CoC.instance.mainView.statsView.showStatDown('hp');
            }
            else {
                //if (display) HPChangeNotify(changeNum);
                CoC.instance.player.wrath += changeNum;
               // CoC.instance.mainView.statsView.showStatDown('hp');
            }
        }
        CoC.instance.player.dynStats("lust", 0, "scale", false); //Workaround to showing the arrow.
        statScreenRefresh();
        return CoC.instance.player.wrath - before;
    }

    public static function clone(source:Object):* {
        var copier:ByteArray = new ByteArray();
        copier.writeObject(source);
        copier.position = 0;
        return (copier.readObject());
    }

    public static function clearOutputTextOnly(forget:Boolean = false):void {
        if (!forget && CoC.instance.currentText.length > 0) {
            CoC.instance.textHistory.push(CoC.instance.currentText);
            while (CoC.instance.textHistory.length > 20) CoC.instance.textHistory.shift();
        }
        CoC.instance.currentText = "";
        CoC.instance.mainView.clearOutputText();
    }

    /**
     * Clear the text on screen.
     */
    public static function clearOutput():void {
        CoC.instance.forceUpdate();
        clearOutputTextOnly();
        if (CoC.instance.gameState != 3) CoC.instance.mainView.hideMenuButton(MainView.MENU_DATA);
        CoC.instance.mainView.hideMenuButton(MainView.MENU_APPEARANCE);
        CoC.instance.mainView.hideMenuButton(MainView.MENU_LEVEL);
        CoC.instance.mainView.hideMenuButton(MainView.MENU_PERKS);
        CoC.instance.mainView.hideMenuButton(MainView.MENU_STATS);
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
            CoC.instance.currentText = output;
            CoC.instance.mainView.setOutputText(output);
            // mainText.htmlText = output;
        }
        else {
            //trace("Adding Text");
            CoC.instance.currentText += output;
            CoC.instance.mainView.appendOutputText(output);
            // mainText.htmlText += output;
        }
        // trace(getCurrentStackTrace())
        // scrollBar.update();

    }

    /**
     * Output the text on main text interface.
     * @param    output The text to show. It can be formatted such as bold, italics, and underline tags.
     */
    public static function outputText(output:String):void {
        // This is cleaup in case someone hits the Data or new-game button when the event-test window is shown.
        // It's needed since those buttons are available even when in the event-tester
        CoC.instance.mainView.hideTestInputPanel();


        output = Parser.recursiveParser(output);

        //OUTPUT!
        CoC.instance.currentText += output;
        //if(!debug) mainText.htmlText = CoC.instance.currentText;
        /*if(debug)
        {
            CoC.instance.mainView.setOutputText( CoC.instance.currentText );
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
     * @param    arg2 Pass argument #2 to func1 parameter.
     * @param    arg3 Pass argument #3 to func1 parameter.
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
        if (CoC.instance.flags[kFLAGS.SFW_MODE] > 0) {
            if (text.indexOf("Sex") != -1 || text.indexOf("Threesome") != -1 || text.indexOf("Foursome") != -1 || text == "Watersports" || text == "Make Love" || text == "Use Penis" || text == "Use Vagina" || text.indexOf("Fuck") != -1 || text.indexOf("Ride") != -1 || (text.indexOf("Mount") != -1 && text.indexOf("Mountain") == -1) || text.indexOf("Vagina") != -1) {
                trace("Button removed due to SFW mode.");
                return btn.hide();
            }
        }
        callback = createCallBackFunction(func1, arg1, arg2, arg3);

        if (toolTipText == "") toolTipText = getButtonToolTipText(text);
        if (toolTipHeader == "") toolTipHeader = getButtonToolTipHeader(text);
        btn.show(text, callback, toolTipText, toolTipHeader);
        //CoC.instance.mainView.setOutputText( CoC.instance.currentText );
        CoC.instance.flushOutputTextToGUI();
        return btn;
    }

    public static function addButtonDisabled(pos:int, text:String = "", toolTipText:String = "", toolTipHeader:String = ""):CoCButton {
        var btn:CoCButton = button(pos);
        //Removes sex-related button in SFW mode.
        if (CoC.instance.flags[kFLAGS.SFW_MODE] > 0) {
            if (text.indexOf("Sex") != -1 || text.indexOf("Threesome") != -1 || text.indexOf("Foursome") != -1 || text == "Watersports" || text == "Make Love" || text == "Use Penis" || text == "Use Vagina" || text.indexOf("Fuck") != -1 || text.indexOf("Ride") != -1 || (text.indexOf("Mount") != -1 && text.indexOf("Mountain") == -1) || text.indexOf("Vagina") != -1) {
                trace("Button removed due to SFW mode.");
                return btn.hide();
            }
        }

        if (toolTipText == "") toolTipText = getButtonToolTipText(text);
        if (toolTipHeader == "") toolTipHeader = getButtonToolTipHeader(text);
        btn.showDisabled(text, toolTipText, toolTipHeader);
        CoC.instance.flushOutputTextToGUI();
        return btn;
    }

    public static function button(pos:int):CoCButton {
        return CoC.instance.mainView.bottomButtons[pos];
    }

    public static function setButtonTooltip(index:int, toolTipHeader:String = "", toolTipText:String = ""):void {
        button(index).hint(toolTipText, toolTipHeader);
    }

    public static function hasButton(arg:*):Boolean {
        if (arg is String)
            return CoC.instance.mainView.hasButton(arg as String);
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
            buttonToRemove = CoC.instance.mainView.indexOfButtonWithLabel(arg as String);
        }
        if (arg is Number) {
            if (arg < 0 || arg > 14) return;
            buttonToRemove = int(arg);
        }
        CoC.instance.mainView.hideBottomButton(buttonToRemove);
    }

    /**
     * Hides all bottom buttons.
     */
    public static function menu():void { //The newer, simpler menu - blanks all buttons so addButton can be used
        for (var i:int = 0; i <= 14; i++) {
            CoC.instance.mainView.hideBottomButton(i);
        }
        CoC.instance.flushOutputTextToGUI();
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
        if (CoC.instance.mainView.getButtonText(0).indexOf("Game Over") != -1) {
            trace("Do next setup cancelled by game over");
            return;
        }
        //trace("DoNext have item:", eventNo);
        //choices("Next", event, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0);
        menu();
        addButton(0, "Next", event);
    }

    public static function invertGo():void {
        CoC.instance.mainView.invert();
    }

    /**
     * Used to update the display of statistics
     */
    public static function statScreenRefresh():void {
        Utils.Begin("engineCore", "statScreenRefresh");
        CoC.instance.mainView.statsView.show(); // show() method refreshes.
        CoC.instance.mainViewManager.refreshStats();
        if (CoC.instance.inCombat) {
            CoC.instance.mainView.monsterStatsView.show();
            CoC.instance.mainView.monsterStatsView.refreshStats(CoC.instance);
        } else {
            CoC.instance.mainView.monsterStatsView.hide();
        }
        Utils.End("engineCore", "statScreenRefresh");
    }

    /**
     * Show the stats pane. (Name, stats and attributes)
     */
    public static function showStats():void {
        CoC.instance.mainView.statsView.show();
        CoC.instance.mainViewManager.refreshStats();
        CoC.instance.mainViewManager.tweenInStats();
    }

    /**
     * Hide the stats pane. (Name, stats and attributes)
     */
    public static function hideStats():void {
        if (!CoC.instance.mainViewManager.buttonsTweened) CoC.instance.mainView.statsView.hide();
        CoC.instance.mainViewManager.tweenOutStats();
        CoC.instance.mainView.monsterStatsView.hide();
    }

    /**
     * Hide the top buttons.
     */
    public static function hideMenus():void {
        CoC.instance.mainView.hideAllMenuButtons();
    }

    /**
     * Hides the up/down arrow on stats pane.
     */
    public static function hideUpDown():void {
        CoC.instance.mainView.statsView.hideUpDown();
        //Clear storage values so up/down arrows can be properly displayed
        CoC.instance.oldStats.oldStr = 0;
        CoC.instance.oldStats.oldTou = 0;
        CoC.instance.oldStats.oldSpe = 0;
        CoC.instance.oldStats.oldInte = 0;
        CoC.instance.oldStats.oldWis = 0;
        CoC.instance.oldStats.oldLib = 0;
        CoC.instance.oldStats.oldSens = 0;
        CoC.instance.oldStats.oldCor = 0;
        CoC.instance.oldStats.oldHP = 0;
        CoC.instance.oldStats.oldLust = 0;
        CoC.instance.oldStats.oldWrath = 0;
        CoC.instance.oldStats.oldFatigue = 0;
        CoC.instance.oldStats.oldMana = 0;
        CoC.instance.oldStats.oldSoulforce = 0;
        CoC.instance.oldStats.oldHunger = 0;
    }

    public static function fatigue(mod:Number, type:Number = 0):void {
        SceneLib.combat.fatigueImpl(mod, type);
    }

    public static function changeFatigue(changeF:Number):void {
        fatigue(changeF);
    }

    public static function minLust():Number {
        return CoC.instance.player.minLust();
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
        if (CoC.instance.achievements[achievement] != null) {
            if (CoC.instance.achievements[achievement] <= 0) {
                CoC.instance.achievements[achievement] = 1;
                if (nl && display) outputText("\n");
                if (display) outputText("<b><font color=\"#000080\">Achievement unlocked: " + title + "</font></b>");
                if (nl2 && display) outputText("\n");
                CoC.instance.saves.savePermObject(false); //Only save if the achievement hasn't been previously awarded.
            }
        }
        else outputText("\n<b>ERROR: Invalid achievement!</b>");
    }

    public static function lustPercent():Number {
        return CoC.instance.player.lustPercent();
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
        outputText("Old: " + CoC.instance.player.str + " " + CoC.instance.player.tou + " " + CoC.instance.player.spe + " " + CoC.instance.player.inte + " " + CoC.instance.player.lib + " " + CoC.instance.player.sens + " " + CoC.instance.player.lust + "\n");
        CoC.instance.player.dynStats("tou", 1, "spe+", 2, "int-", 3, "lib*", 2, "sen=", 25, "lust/", 2);
        outputText("Mod: 0 1 +2 -3 *2 =25 /2\n");
        outputText("New: " + CoC.instance.player.str + " " + CoC.instance.player.tou + " " + CoC.instance.player.spe + " " + CoC.instance.player.inte + " " + CoC.instance.player.lib + " " + CoC.instance.player.sens + " " + CoC.instance.player.lust + "\n");
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

//	CoC.instance.mainView.statsView.upDownsContainer.visible = true;

        allStats = ["str", "tou", "spe", "inte", "wis", "lib", "sens", "cor", "HP", "lust", "wrath", "fatigue", "mana", "soulforce", "hunger"];

        for each(statName in allStats) {
            oldStatName = _oldStatNameFor(statName);

            if (CoC.instance.player[statName] > CoC.instance.oldStats[oldStatName]) {
                CoC.instance.mainView.statsView.showStatUp(statName);
            }
            if (CoC.instance.player[statName] < CoC.instance.oldStats[oldStatName]) {
                CoC.instance.mainView.statsView.showStatDown(statName);
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
        if (CoC.instance.player.vaginas[vIndex].virgin) {
            if (display) outputText("\nYour " + Appearance.vaginaDescript(CoC.instance.player,vIndex) + " loses its virginity!");
            CoC.instance.player.vaginas[vIndex].virgin = false;
        }
        //If cock is bigger than unmodified vagina can hold - 100% stretch!
        if (CoC.instance.player.vaginas[vIndex].capacity() <= CoC.instance.monster.cocks[cIndex].cArea()) {
            if (CoC.instance.player.vaginas[vIndex].vaginalLooseness < 5) {
                trace("CUNT STRETCHED: By cock larger than it's total capacity.");
                if (display) {
                    if (CoC.instance.player.vaginas[vIndex].vaginalLooseness == VaginaClass.LOOSENESS_GAPING_WIDE) outputText("<b>Your " + Appearance.vaginaDescript(CoC.instance.player,0) + " is stretched even further, capable of taking even the largest of demons and beasts.</b>  ");
                    if (CoC.instance.player.vaginas[vIndex].vaginalLooseness == VaginaClass.LOOSENESS_GAPING) outputText("<b>Your " + Appearance.vaginaDescript(CoC.instance.player,0) + " painfully stretches, gaping wide-open.</b>  ");
                    if (CoC.instance.player.vaginas[vIndex].vaginalLooseness == VaginaClass.LOOSENESS_LOOSE) outputText("<b>Your " + Appearance.vaginaDescript(CoC.instance.player,0) + " is now very loose.</b>  ");
                    if (CoC.instance.player.vaginas[vIndex].vaginalLooseness == VaginaClass.LOOSENESS_NORMAL) outputText("<b>Your " + Appearance.vaginaDescript(CoC.instance.player,0) + " is now loose.</b>  ");
                    if (CoC.instance.player.vaginas[vIndex].vaginalLooseness == VaginaClass.LOOSENESS_TIGHT) outputText("<b>Your " + Appearance.vaginaDescript(CoC.instance.player,0) + " loses its virgin-like tightness.</b>  ");
                }
                CoC.instance.player.vaginas[vIndex].vaginalLooseness++;
            }
        }
        //If cock is within 75% of max, streeeeetch 33% of the time
        if (CoC.instance.player.vaginas[vIndex].capacity() * .75 <= CoC.instance.monster.cocks[cIndex].cArea()) {
            if (CoC.instance.player.vaginas[vIndex].vaginalLooseness < 5) {
                trace("CUNT STRETCHED: By cock @ 75% of capacity.");
                if (display) {
                    if (CoC.instance.player.vaginas[vIndex].vaginalLooseness == VaginaClass.LOOSENESS_GAPING_WIDE) outputText("<b>Your " + Appearance.vaginaDescript(CoC.instance.player,0) + " is stretched even further, capable of taking even the largest of demons and beasts.</b>  ");
                    if (CoC.instance.player.vaginas[vIndex].vaginalLooseness == VaginaClass.LOOSENESS_GAPING) outputText("<b>Your " + Appearance.vaginaDescript(CoC.instance.player,0) + " painfully stretches, gaping wide-open.</b>  ");
                    if (CoC.instance.player.vaginas[vIndex].vaginalLooseness == VaginaClass.LOOSENESS_LOOSE) outputText("<b>Your " + Appearance.vaginaDescript(CoC.instance.player,0) + " is now very loose.</b>  ");
                    if (CoC.instance.player.vaginas[vIndex].vaginalLooseness == VaginaClass.LOOSENESS_NORMAL) outputText("<b>Your " + Appearance.vaginaDescript(CoC.instance.player,0) + " is now loose.</b>  ");
                    if (CoC.instance.player.vaginas[vIndex].vaginalLooseness == VaginaClass.LOOSENESS_TIGHT) outputText("<b>Your " + Appearance.vaginaDescript(CoC.instance.player,0) + " loses its virgin-like tightness.</b>  ");
                }
                CoC.instance.player.vaginas[vIndex].vaginalLooseness++;
            }
        }
    }

    /**
     * Returns true if you're on SFW mode.
     */
    public static function doSFWloss():Boolean {
        clearOutput();
        if (CoC.instance.flags[kFLAGS.SFW_MODE] > 0) {
            if (CoC.instance.player.HP <= 0) outputText("You collapse from your injuries.");
            else outputText("You collapse from your overwhelming desires.");
            if (CoC.instance.inCombat) SceneLib.combat.cleanupAfterCombatImpl();
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