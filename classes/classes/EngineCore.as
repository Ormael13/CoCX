package classes {
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Parser.Parser;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

import coc.view.CoCButton;
import coc.view.MainView;
import coc.view.charview.DragButton;

import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.describeType;
import flash.utils.setTimeout;

public class EngineCore {
    private static var funcLookups:Dictionary = null;
    private static var allStats:Array = ["str", "tou", "spe", "inte", "wis", "lib", "sens", "cor", "HP", "lust", "wrath", "fatigue", "mana", "soulforce", "hunger"];
    private static var allStatsOld:Array = [];
    public function EngineCore() {
        GenerateCodeBits();
    }
    private static function _oldStatNameFor(statName:String):String {
        return 'old' + statName.charAt(0).toUpperCase() + statName.substr(1);
    }
    private static function GenerateCodeBits():void {
        for each(var statstr:String in allStats) {
            allStatsOld.push(_oldStatNameFor(statstr))
        }
    }

    public static function maxHP():Number {
        return CoC.instance.player.maxHP();
    }

    public static function maxOverHP():Number {
        return CoC.instance.player.maxOverHP();
    }
	
	public static function maxOverHPCW():Number {
		var mOHPCW:Number = maxOverHP();
		if (CoC.instance.player.hasStatusEffect(StatusEffects.CombatWounds)) {
			mOHPCW *= (1 - CoC.instance.player.statusEffectv1(StatusEffects.CombatWounds));
			mOHPCW = Math.round(mOHPCW);
		}
		return mOHPCW;
	}

    public static function minHP():Number {
        return CoC.instance.player.minHP();
    }

    public static function maxSoulforce():Number {
        return CoC.instance.player.maxSoulforce();
    }

    public static function maxOverSoulforce():Number {
        return CoC.instance.player.maxOverSoulforce();
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

    public static function maxOverMana():Number {
        return CoC.instance.player.maxOverMana();
    }

    public static function maxVenom():Number {
        return CoC.instance.player.maxVenom();
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
                changeNum = Math.min(changeNum, int.MAX_VALUE)
			}
            if (Math.min(CoC.instance.player.HP + changeNum, int.MAX_VALUE) > maxOverHPCW()) {
                if (CoC.instance.player.HP >= maxOverHPCW()) {
                    if (display) HPChangeNotify(changeNum);
                    return CoC.instance.player.HP - before;
                }
                if (display) HPChangeNotify(changeNum);
                CoC.instance.player.HP = maxOverHPCW();
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
                outputText("You gain <b><font color=\"#008000\">" + Utils.formatNumber(int(changeNum)) + "</font></b> HP.\n");
        }
        else {
            if (CoC.instance.player.HP <= minHP())
                outputText("You take <b><font color=\"#800000\">" + Utils.formatNumber(int(changeNum * -1)) + "</font></b> damage, dropping your HP to "+minHP()+".\n");
            else
                outputText("You take <b><font color=\"#800000\">" + Utils.formatNumber(int(changeNum * -1)) + "</font></b> damage.\n");
        }
    }

    public static function SoulforceChange(changeNum:Number):Number {
        var before:Number = CoC.instance.player.soulforce;
        if (changeNum == 0) return 0;
        if (changeNum > 0) {
            if (CoC.instance.player.soulforce + int(changeNum) > maxOverSoulforce()) CoC.instance.player.soulforce = maxOverSoulforce();
            else CoC.instance.player.soulforce += changeNum;
        } else {
            if (CoC.instance.player.soulforce + changeNum <= 0) CoC.instance.player.soulforce = 0;
            else CoC.instance.player.soulforce += changeNum;
        }
        CoC.instance.player.dynStats("lust", 0, "scale", false);
        statScreenRefresh();
        return CoC.instance.player.soulforce - before;
    }

    public static function ManaChange(changeNum:Number):Number {
        var before:Number = CoC.instance.player.mana;
        if (changeNum == 0) return 0;
        if (changeNum > 0) {
            if (CoC.instance.player.mana + int(changeNum) > maxOverMana()) CoC.instance.player.mana = maxOverMana();
            else CoC.instance.player.mana += changeNum;
        } else {
            if (CoC.instance.player.mana + changeNum <= 0) CoC.instance.player.mana = 0;
            else CoC.instance.player.mana += changeNum;
            if (CoC.instance.player.perkv1(IMutationsLib.ElvishPeripheralNervSysIM) >= 3) HPChange(-changeNum, false);
        }
        CoC.instance.player.dynStats("lust", 0, "scale", false) //Workaround to showing the arrow.
        statScreenRefresh();
        return CoC.instance.player.mana - before;
    }

    public static function WrathChange(changeNum:Number):Number {
        var before:Number = CoC.instance.player.wrath;
        if (changeNum == 0) return 0;
        if (changeNum > 0) {
            if (CoC.instance.player.wrath + int(changeNum) > maxOverWrath()) CoC.instance.player.wrath = maxOverWrath();
            else CoC.instance.player.wrath += changeNum;
        } else {
            if (CoC.instance.player.wrath + changeNum <= 0) CoC.instance.player.wrath = 0;
            else CoC.instance.player.wrath += changeNum;
        }
        CoC.instance.player.dynStats("lust", 0, "scale", false) //Workaround to showing the arrow.
        statScreenRefresh();
        return CoC.instance.player.wrath - before;
    }

    public static function VenomWebChange(changeNum:Number):Number {
        var before:Number = CoC.instance.player.tailVenom;
        if (changeNum == 0) return 0;
        if (changeNum > 0) {
            if (CoC.instance.player.tailVenom + int(changeNum) > maxVenom()) CoC.instance.player.tailVenom = maxVenom();
            else CoC.instance.player.tailVenom += changeNum;
        } else {
            if (CoC.instance.player.tailVenom + changeNum <= 0) CoC.instance.player.tailVenom = 0;
            else CoC.instance.player.tailVenom += changeNum;
        }
        CoC.instance.player.dynStats("lust", 0, "scale", false) //Workaround to showing the arrow.
        statScreenRefresh();
        return CoC.instance.player.tailVenom - before;
    }

    public static function clone(source:Object):* {
        var copier:ByteArray = new ByteArray();
        copier.writeObject(source);
        copier.position = 0;
        return (copier.readObject());
    }

    public static function clearOutputTextOnly(forget:Boolean = false):void {
        DragButton.cleanUp();
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

    public static function buttonTextIsOneOf(index:int, possibleLabels:Array):Boolean {
        var buttonText:String = getButtonText(index);
        return (possibleLabels.indexOf(buttonText) != -1);
    }

    public static function getButtonText(index:int):String {
        if (index < 0 || index > 14) return '';
        else return button(index).labelText;
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
        var somagicnumber:Number = -9000;
        
        if (arg == somagicnumber || arg == null) {
            return function ():* {
                if (CoC_Settings.haltOnErrors)
                    logFunctionInfo(func, arg);
                return func();
            };
        }
        else {
            if (arg2 == somagicnumber || arg2 == null) {
                return function ():* {
                    if (CoC_Settings.haltOnErrors)
                        logFunctionInfo(func, arg);
                    return func(arg);
                };
            }
            else {
                if (arg3 == somagicnumber || arg3 == null) {
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
        //Removes sex-related button in SFW mode.
        callback = createCallBackFunction(func1, arg1, arg2, arg3);

        if (toolTipText == "") toolTipText = getButtonToolTipText(text);
        if (toolTipHeader == "") toolTipHeader = getButtonToolTipHeader(text);
        btn.show(text, callback, toolTipText, toolTipHeader);
        //CoC.instance.mainView.setOutputText( CoC.instance.currentText );
        CoC.instance.flushOutputTextToGUI();
        return btn;
    }

    public static function fiveArgButton(pos:int, text:String = "", func1:Function = null, arg1:* = -9000, arg2:* = -9000, arg3:* = -9000, arg4:* = -9000, arg5:* = -9000, toolTipText:String = "", toolTipHeader:String = ""):CoCButton{
        var btn:CoCButton = button(pos);
        if (func1 == null) {
            return btn.hide();
        }
        var callback:Function;

        callback = createCallBackFunction2(func1, arg1, arg2, arg3, arg4, arg5);

        if (toolTipText == "") toolTipText = getButtonToolTipText(text);
        if (toolTipHeader == "") toolTipHeader = getButtonToolTipHeader(text);
        btn.show(text, callback, toolTipText, toolTipHeader);
        //CoC.instance.mainView.setOutputText( CoC.instance.currentText );
        CoC.instance.flushOutputTextToGUI();
        return btn;
    }

    public static function addButtonDisabled(pos:int, text:String = "", toolTipText:String = "", toolTipHeader:String = ""):CoCButton {
        var btn:CoCButton = button(pos);
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
        statScreenRefresh();
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
     * @param    func The event function to call if the button is pressed.
     */
    public static function doNext(func:Function, ...args):void { //Now typesafe
        //Prevent new events in combat from automatically overwriting a game over.
        if (CoC.instance.mainView.getButtonText(0).indexOf("Game Over") != -1) {
            trace("Do next setup cancelled by game over");
            return;
        }
        menu();
        addButton.apply(null, [0, "Next", func].concat(args));
    }

    /**
     * Used to update the display of statistics
     */
    private static var statScreenRefreshScheduled:Boolean = false;
    public static function doStatScreenRefresh():void {
        statScreenRefreshScheduled = false;
        if (!CoC.instance || !CoC.instance.player) return;
        Utils.Begin("engineCore", "statScreenRefresh");
        CoC.instance.mainViewManager.refreshStats();
        CoC.instance.mainView.statsView.show();
        if (CoC.instance.inCombat) {
            CoC.instance.mainView.monsterStatsView.refreshStats(CoC.instance);
            CoC.instance.mainView.monsterStatsView.show();
        } else {
            CoC.instance.mainView.monsterStatsView.hide();
        }
        Utils.End("engineCore", "statScreenRefresh");
    }
    public static function statScreenRefresh():void {
        if (statScreenRefreshScheduled) return;
        statScreenRefreshScheduled = true;
        // call doStatScreenRefresh ASAP after all other code is executed
        setTimeout(doStatScreenRefresh, 0);
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
        CoC.instance.mainView.notificationView.clearNotifications();
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

        for each (var stat:String in allStatsOld) {
            CoC.instance.oldStats[stat] = 0;
        }
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

    public static function showUpDown():void { //Moved from StatsView.
        Utils.Begin("engineCore", "showUpDown");

        for(var i:Number = 0; i< allStats.length; i++) {
            if (CoC.instance.player[allStats[i]] > CoC.instance.oldStats[allStatsOld[i]]) {
                CoC.instance.mainView.statsView.showStatUp(allStats[i]);
            }
            if (CoC.instance.player[allStats[i]] < CoC.instance.oldStats[allStatsOld[i]]) {
                CoC.instance.mainView.statsView.showStatDown(allStats[i]);
            }
        }
        Utils.End("engineCore", "showUpDown");
    }

    public static function range(min:Number, max:Number, round:Boolean = false):Number {
        var num:Number = (min + Math.random() * (max - min));

        if (round) return Math.round(num);
        return num;
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
