import classes.*;
import classes.display.SpriteDb;

import flash.display.BitmapData;
import flash.text.TextFormat;
// // import flash.events.MouseEvent;
// 
// //const DOUBLE_ATTACK_STYLE:int = 867;
// //const SPELLS_CAST:int = 868;
// 
// //Fenoxo loves his temps
// var temp:int = 0;
// 
// //Used to set what each action buttons displays and does.
// var args:Array = new Array();
// var funcs:Array = new Array();
// 
// //Used for stat tracking to keep up/down arrows correct.
// var oldStats = {};
// model.oldStats = oldStats;
// oldStats.oldStr  = 0;
// oldStats.oldTou  = 0;
// oldStats.oldSpe  = 0;
// oldStats.oldInte = 0;
// oldStats.oldWis 	= 0;
// oldStats.oldSens = 0;
// oldStats.oldLib  = 0;
// oldStats.oldCor  = 0;
// oldStats.oldHP   = 0;
// oldStats.oldLust = 0;
// 
// model.maxHP = maxHP;

public function maxHP():Number {
	return player.maxHP();
}

public function maxSoulforce():Number {
	return player.maxSoulforce();
}

public function maxWrath():Number {
	return player.maxWrath();
}

public function maxMana():Number {
	return player.maxMana();
}

public function silly():Boolean {
	return flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] == 1;

}

/* Replaced by Utils.formatStringArray, which does almost the same thing in one function
public function clearList():void {
	list = [];
}
public var list:Array = [];
public function addToList(arg:*):void {
	list[list.length] = arg;
}
public function outputList():String {
	var stuff:String = "";
	for(var x:int = 0; x < list.length; x++) {
		stuff += list[x];
		if(list.length == 2 && x == 1) {
			stuff += " and ";
		}
		else if(x < list.length-2) {
			stuff += ", ";
		}
		else if(x < list.length-1) {
			stuff += ", and ";
		}
	}
	list = [];
	return stuff;        
}
*/
/**
 * Alters player's HP.
 * @param	changeNum The amount to damage (negative) or heal (positive).
 * @param	display Show the damage or heal taken.
 * @return  effective delta
 */
public function HPChange(changeNum:Number, display:Boolean):Number
{
	var before:Number = player.HP;
	if(changeNum == 0) return 0;
	if(changeNum > 0) {
		//Increase by 20%!
		if(player.findPerk(PerkLib.HistoryHealer) >= 0 || player.findPerk(PerkLib.PastLifeHealer) >= 0) changeNum *= 1.2;
		if(player.HP + int(changeNum) > maxHP()) {
			if(player.HP >= maxHP()) {
			if (display) HPChangeNotify(changeNum);
				return player.HP - before;
			}
			if (display) HPChangeNotify(changeNum);
			player.HP = maxHP();
		}
		else
		{
			if (display) HPChangeNotify(changeNum);
			player.HP += int(changeNum);
			mainView.statsView.showStatUp( 'hp' );
			// hpUp.visible = true;
		}
	}
	//Negative HP
	else
	{
		if(player.HP + changeNum <= 0) {
			if (display) HPChangeNotify(changeNum);
			player.HP = 0;
			mainView.statsView.showStatDown( 'hp' );
		}
		else {
			if (display) HPChangeNotify(changeNum);
			player.HP += changeNum;
			mainView.statsView.showStatDown( 'hp' );
		}
	}
	dynStats("lust", 0, "resisted", false) //Workaround to showing the arrow.
	statScreenRefresh();
	return player.HP - before;
}

public function HPChangeNotify(changeNum:Number):void {
	if (changeNum == 0) {
		if(player.HP >= maxHP())
			outputText("You're as healthy as you can be.\n");
	}
	else if (changeNum > 0) {
		if(player.HP >= maxHP())
			outputText("Your HP maxes out at " + maxHP() + ".\n");
		else
			outputText("You gain <b><font color=\"#008000\">" + int(changeNum) + "</font></b> HP.\n");
	}
	else {
		if(player.HP <= 0)
			outputText("You take <b><font color=\"#800000\">" + int(changeNum*-1) + "</font></b> damage, dropping your HP to 0.\n");
		else
			outputText("You take <b><font color=\"#800000\">" + int(changeNum*-1) + "</font></b> damage.\n");
	}
}

public function SoulforceChange(changeNum:Number, display:Boolean):Number
{
	var before:Number = player.soulforce;
	if(changeNum == 0) return 0;
	if(changeNum > 0) {
		if(player.soulforce + int(changeNum) > maxSoulforce()) {
		//	if(player.HP >= maxHP()) {
		//	if (display) HPChangeNotify(changeNum);
		//		return player.HP - before;
		//	}
		//	if (display) HPChangeNotify(changeNum);
			player.soulforce = maxSoulforce();
		}
		else
		{
		//	if (display) HPChangeNotify(changeNum);
			player.soulforce += int(changeNum);
		//	mainView.statsView.showStatUp( 'hp' );
			// hpUp.visible = true;
		}
	}
	//Negative Soulforce
/*	else
	{
		if(player.HP + changeNum <= 0) {
			if (display) HPChangeNotify(changeNum);
			player.HP = 0;
			mainView.statsView.showStatDown( 'hp' );
		}
		else {
			if (display) HPChangeNotify(changeNum);
			player.HP += changeNum;
			mainView.statsView.showStatDown( 'hp' );
		}
	}
	dynStats("lust", 0, "resisted", false) //Workaround to showing the arrow.
*/	statScreenRefresh();
	return player.soulforce - before;
}

public function ManaChange(changeNum:Number, display:Boolean):Number
{
	var before:Number = player.mana;
	if(changeNum == 0) return 0;
	if(changeNum > 0) {
		if(player.mana + int(changeNum) > maxMana()) {
		//	if(player.HP >= maxHP()) {
		//	if (display) HPChangeNotify(changeNum);
		//		return player.HP - before;
		//	}
		//	if (display) HPChangeNotify(changeNum);
			player.mana = maxMana();
		}
		else
		{
		//	if (display) HPChangeNotify(changeNum);
			player.mana += int(changeNum);
		//	mainView.statsView.showStatUp( 'hp' );
			// hpUp.visible = true;
		}
	}
	//Negative Mana
/*	else
	{
		if(player.HP + changeNum <= 0) {
			if (display) HPChangeNotify(changeNum);
			player.HP = 0;
			mainView.statsView.showStatDown( 'hp' );
		}
		else {
			if (display) HPChangeNotify(changeNum);
			player.HP += changeNum;
			mainView.statsView.showStatDown( 'hp' );
		}
	}
	dynStats("lust", 0, "resisted", false) //Workaround to showing the arrow.
*/	statScreenRefresh();
	return player.mana - before;
}

public function clone(source:Object):* {
	var copier:ByteArray = new ByteArray();
	copier.writeObject(source);
	copier.position = 0;
	return(copier.readObject());
}

/* Was only used in two places at the start of the game
public function speech(output:String, speaker:String):void {
	var speech:String = "";
	speech = speaker + " says, \"<i>" + output + "</i>\"\n";
	outputText(speech);
}
*/

public function clearOutputTextOnly(forget:Boolean=false):void {
	if (!forget && currentText.length>0) {
		textHistory.push(currentText);
		while (textHistory.length > 20) textHistory.shift();
	}
	currentText = "";
	mainView.clearOutputText();
}

/**
 * Clear the text on screen.
 */
public function clearOutput():void {
	forceUpdate();
	clearOutputTextOnly();
	if(gameState != 3) mainView.hideMenuButton( MainView.MENU_DATA );
	mainView.hideMenuButton( MainView.MENU_APPEARANCE );
	mainView.hideMenuButton( MainView.MENU_LEVEL );
	mainView.hideMenuButton( MainView.MENU_PERKS );
	mainView.hideMenuButton( MainView.MENU_STATS );
}

/**
 * Basically the same as outputText() but without the parser tags. Great for displaying square brackets on text.
 * @param	output The text to show. It can be formatted such as bold, italics, and underline tags.
 * @param	purgeText Clear the old text.
 */
public function rawOutputText(output:String, purgeText:Boolean = false):void
{
	
	//OUTPUT!
	if(purgeText) {
		//if(!debug) mainText.htmlText = output;
		//trace("Purging and writing Text", output);
		clearOutput();
		currentText = output;
		mainView.setOutputText( output );
		// mainText.htmlText = output;
	}
	else
	{
		//trace("Adding Text");
		currentText += output;
		mainView.appendOutputText( output );
		// mainText.htmlText += output;
	}
	// trace(getCurrentStackTrace())
	// scrollBar.update();

}



/**
 * Output the text on main text interface.
 * @param	output The text to show. It can be formatted such as bold, italics, and underline tags.
 * @param	purgeText Clear the old text.
 * @param	parseAsMarkdown Parses the text using Markdown.
 */
public function outputText(output:String):void
{
	// we have to purge the output text BEFORE calling parseText, because if there are scene commands in 
	// the parsed text, parseText() will write directly to the output


	// This is cleaup in case someone hits the Data or new-game button when the event-test window is shown. 
	// It's needed since those buttons are available even when in the event-tester
	mainView.hideTestInputPanel();


	output = this.parser.recursiveParser(output, false);

	//OUTPUT!
	currentText += output;
	//if(!debug) mainText.htmlText = currentText;
	/*if(debug)
	{
		mainView.setOutputText( currentText );
	}*/

}


public function displayHeader(string:String):void {
	outputText("<font size=\"36\" face=\"Georgia\"><u>" + string + "</u></font>\n");
}



public function buttonIsVisible(index:int):Boolean {
	if( index < 0 || index > 14 ) {
		return undefined;
	}
	else {
		return mainView.bottomButtons[index].visible;
	}
};

public function buttonText(buttonName:String):String {
	var matches:*,
		buttonIndex:int;

	if(buttonName is String) {
		if( /^buttons\[[0-9]\]/.test( buttonName ) ) {
			matches = /^buttons\[([0-9])\]/.exec( buttonName );
			buttonIndex = parseInt( matches[ 1 ], 10 );
		}
		else if( /^b[0-9]Text$/.test( buttonName ) ) {
			matches = /^b([0-9])Text$/.exec( buttonName );
			buttonIndex = parseInt( matches[ 1 ], 10 );

			buttonIndex = buttonIndex === 0 ? 9 : buttonIndex - 1;
		}
	}

	return (getButtonText(buttonIndex) || "NULL");
}

public function buttonTextIsOneOf(index:int, possibleLabels:Array):Boolean {
	var label:String,
	buttonText:String;

	buttonText = this.getButtonText(index);

	return (possibleLabels.indexOf(buttonText) != -1);
}

public function getButtonText(index:int):String {
	var matches:*;

	if(index < 0 || index > 14) {
		return '';
	}
	else {
		return mainView.bottomButtons[index].labelText;
	}
}

/*public function setButtonToolTip(button:int, header:String = "", text:String = ""):void {
	if (header == "") {
		header = mainView.bottomButtons[button].labelText;
	}
	mainView.bottomButtons[button].toolTipHeader = header;
	mainView.bottomButtons[button].toolTipText = text;
}*/

public function getButtonToolTipHeader(buttonText:String):String
{
	var toolTipHeader:String;
	
	if (buttonText.indexOf(" x") != -1)
	{
		buttonText = buttonText.split(" x")[0];
	}
	
	//Get items
	var itype:ItemType = ItemType.lookupItem(buttonText);
	var temp:String = "";
	if (itype != null) temp = itype.longName;
	itype = ItemType.lookupItemByShort(buttonText);
	if (itype != null) temp = itype.longName;
	if (temp != "") {
		temp = capitalizeFirstLetter(temp);
		toolTipHeader = temp;
	}
	
	//Set tooltip header to button.
	if (toolTipHeader == null) {
		toolTipHeader = buttonText;
	}
	
	return toolTipHeader;
}

// Returns a string or undefined.
public function getButtonToolTipText(buttonText:String):String
{
	var toolTipText :String;

	buttonText = buttonText || '';

	//Items
	//if (/^....... x\d+$/.test(buttonText)){
	//	buttonText = buttonText.substring(0,7);
	//}
	
	// Fuck your regex
	if (buttonText.indexOf(" x") != -1)
	{
		buttonText = buttonText.split(" x")[0];
	}
	
	var itype:ItemType = ItemType.lookupItem(buttonText);
	if (itype != null) toolTipText = itype.description;
	itype = ItemType.lookupItemByShort(buttonText);
	if (itype != null) toolTipText = itype.description;

	//------------
	// COMBAT 
	//------------
	if(buttonText.indexOf("Defend") != -1) { //Not used at the moment.
		toolTipText = "Selecting defend will reduce the damage you take by 66 percent, but will not affect any lust incurred by your enemy's actions.";
	}
	//Urta's specials - MOVED
	//P. Special attacks - MOVED
	//M. Special attacks - MOVED

	//------------
	// MASTURBATION 
	//------------
	//Masturbation Toys
	if(buttonText == "Masturbate") {
		toolTipText = "Selecting this option will make you attempt to manually masturbate in order to relieve your lust buildup.";
	}
	if(buttonText == "Meditate") {
		toolTipText = "Selecting this option will make you attempt to meditate in order to reduce lust and corruption.";
	}
	if(buttonText.indexOf("AN Stim-Belt") != -1) {
		toolTipText = "This is an all-natural self-stimulation belt.  The methods used to create such a pleasure device are unknown.  It seems to be organic in nature.";
	}
	if(buttonText.indexOf("Stim-Belt") != -1) {
		toolTipText = "This is a self-stimulation belt.  Commonly referred to as stim-belts, these are clockwork devices designed to pleasure the female anatomy.";
	}
	if(buttonText.indexOf("AN Onahole") != -1) {
		toolTipText = "An all-natural onahole, this device looks more like a bulbous creature than a sex-toy.  Nevertheless, the slick orifice it presents looks very inviting.";
	}
	if(buttonText.indexOf("D Onahole") != -1) {
		toolTipText = "This is a deluxe onahole, made of exceptional materials and with the finest craftsmanship in order to bring its user to the height of pleasure.";
	}
	if(buttonText.indexOf("Onahole") != -1) {
		toolTipText = "This is what is called an 'onahole'.  This device is a simple textured sleeve designed to fit around the male anatomy in a pleasurable way.";
	}
	if(buttonText.indexOf("Dual Belt") != -1) {
		toolTipText = "This is a strange masturbation device, meant to work every available avenue of stimulation.";
	}
	if(buttonText.indexOf("C. Pole") != -1) {
		toolTipText = "This 'centaur pole' as it's called appears to be a sex-toy designed for females of the equine persuasion.  Oddly, it's been sculpted to look like a giant imp, with an even bigger horse-cock.";
	}
	if(buttonText.indexOf("Fake Mare") != -1) {
		toolTipText = "This fake mare is made of metal and wood, but the anatomically correct vagina looks as soft and wet as any female centaur's.";
	}
	//Books
	if(buttonText.indexOf("Dangerous Plants") != -1) {
		toolTipText = "This is a book titled 'Dangerous Plants'.  As explained by the title, this tome is filled with information on all manner of dangerous plants from this realm.";
	}
	if(buttonText.indexOf("Traveler's Guide") != -1) {
		toolTipText = "This traveler's guide is more of a pamphlet than an actual book, but it still contains some useful information on avoiding local pitfalls.";
	}
	if(buttonText.indexOf("Yoga Guide") != -1) {
		toolTipText = "This leather-bound book is titled 'Yoga for Non-Humanoids.' It contains numerous illustrations of centaurs, nagas and various other oddly-shaped beings in a variety of poses.";
	}
	if(buttonText.indexOf("Hentai Comic") != -1) {
		toolTipText = "This oddly drawn comic book is filled with images of fornication, sex, and overly large eyeballs.";
	}
	//------------
	// TITLE SCREEN 
	//------------
	if(buttonText.indexOf("ASPLODE") != -1) {
		toolTipText = "MAKE SHIT ASPLODE";
	}
	return toolTipText;
}


// Hah, finally a place where a dictionary is actually required!
import flash.utils.Dictionary;
private var funcLookups:Dictionary = null;


private function buildFuncLookupDict(object:*=null,prefix:String=""):void
{
	import flash.utils.*;
	trace("Building function <-> function name mapping table for "+((object==null)?"CoC.":prefix));
	// get all methods contained
	if (object == null) object = this;
	var typeDesc:XML = describeType(object);
	//trace("TypeDesc - ", typeDesc)

	for each (var node:XML in typeDesc..method) 
	{
		// return the method name if the thisObject of f (t) 
		// has a property by that name 
		// that is not null (null = doesn't exist) and 
		// is strictly equal to the function we search the name of
		//trace("this[node.@name] = ", this[node.@name], " node.@name = ", node.@name)
		if (object[node.@name] != null)
			this.funcLookups[object[node.@name]] = prefix+node.@name;
	}
	for each (node in typeDesc..variable)
	{
		if (node.@type.toString().indexOf("classes.Scenes.") == 0 ||
				node.metadata.@name.contains("Scene")){
			if (object[node.@name]!=null){
				buildFuncLookupDict(object[node.@name],node.@name+".");
			}
		}
	}
}

public function getFunctionName(f:Function):String
{
	// trace("Getting function name")
	// get the object that contains the function (this of f)
	//var t:Object = flash.sampler.getSavedThis(f); 
	if (this.funcLookups == null)
	{
		trace("Rebuilding lookup object");
		this.funcLookups = new Dictionary();
		this.buildFuncLookupDict();
	}


	if (f in this.funcLookups)
		return(this.funcLookups[f]);
	
	// if we arrive here, we haven't found anything... 
	// maybe the function is declared in the private namespace?
	return null;
}


private function logFunctionInfo(func:Function, arg:* = null, arg2:* = null, arg3:* = null):void
{
	var logStr:String = "";
	if (arg is Function)
	{
		logStr += "Calling = " + getFunctionName(func) + " Param = " +  getFunctionName(arg);
	}
	else
	{
		logStr += "Calling = " + getFunctionName(func) + " Param = " +  arg;
	}
	CoC_Settings.appendButtonEvent(logStr);
	trace(logStr)
}


// returns a function that takes no arguments, and executes function `func` with argument `arg`
public function createCallBackFunction(func:Function, arg:*, arg2:* = null, arg3:* = null):Function
{
	if (func == null) {
		CoC_Settings.error("createCallBackFunction(null," + arg + ")");
	}
	if( arg == -9000 || arg == null )
	{
/*		if (func == eventParser){
			CoC_Settings.error("createCallBackFunction(eventParser,"+arg+")");
		} */
		return function ():*
		{ 
			if (CoC_Settings.haltOnErrors) 
				logFunctionInfo(func, arg);
			return func(); 
		};
	}
	else
	{
		if (arg2 == -9000 || arg2 == null)
		{
			return function ():*
			{ 
				if (CoC_Settings.haltOnErrors) 
					logFunctionInfo(func, arg);
				return func( arg ); 
			};
		}
		else 
		{
			if (arg3 == -9000 || arg3 == null)
			{
				return function ():*
				{ 
					if (CoC_Settings.haltOnErrors) 
						logFunctionInfo(func, arg, arg2);
					return func(arg, arg2); 
				};
			}
			else 
			{
				return function ():*
				{ 
					if (CoC_Settings.haltOnErrors) 
						logFunctionInfo(func, arg, arg2, arg3);
					return func(arg, arg2, arg3); 
				};
			}
		}
	}
}
public function createCallBackFunction2(func:Function,...args):Function
{
	if (func == null){
		CoC_Settings.error("createCallBackFunction(null,"+args+")");
	}
	return function():*
	{
		if (CoC_Settings.haltOnErrors) logFunctionInfo(func,args);
		return func.apply(null,args);
	}
}

/**
 * Adds a button.
 * @param	pos Determines the position. Starts at 0. (First row is 0-4, second row is 5-9, third row is 10-14.)
 * @param	text Determines the text that will appear on button.
 * @param	func1 Determines what function to trigger.
 * @param	arg1 Pass argument #1 to func1 parameter.
 * @param	arg2 Pass argument #1 to func1 parameter.
 * @param	arg3 Pass argument #1 to func1 parameter.
 * @param	toolTipText The text that will appear on tooltip when the mouse goes over the button.
 * @param	toolTipHeader The text that will appear on the tooltip header. If not specified, it defaults to button text.
 */
public function addButton(pos:int, text:String = "", func1:Function = null, arg1:* = -9000, arg2:* = -9000, arg3:* = -9000, toolTipText:String = "", toolTipHeader:String = ""):void {
	if (func1==null) return;
	var callback:Function;
/*
	Let the mainView decide if index is valid
	if(pos > 14) {
		trace("INVALID BUTTON");
		return;
	}
*/
	//Removes sex-related button in SFW mode.
	if (flags[kFLAGS.SFW_MODE] > 0) {
		if (text.indexOf("Sex") != -1 || text.indexOf("Threesome") != -1 ||  text.indexOf("Foursome") != -1 || text == "Watersports" || text == "Make Love" || text == "Use Penis" || text == "Use Vagina" || text.indexOf("Fuck") != -1 || text.indexOf("Ride") != -1 || (text.indexOf("Mount") != -1 && text.indexOf("Mountain") == -1) || text.indexOf("Vagina") != -1) {
			trace("Button removed due to SFW mode.");
			return;
		}
	}
	callback = createCallBackFunction(func1, arg1, arg2, arg3);

	if (toolTipText == "") toolTipText = getButtonToolTipText(text);
	if (toolTipHeader == "") toolTipHeader = getButtonToolTipHeader(text);
	mainView.bottomButtons[pos].alpha = 1; // failsafe to avoid possible problems with dirty hack
	mainView.showBottomButton(pos, text,
			function():void {
				textHistory.push("<br>["+text+"]<br>");
				callback();
			}, toolTipText, toolTipHeader);
	//mainView.setOutputText( currentText );
	flushOutputTextToGUI();
}

public function addButtonDisabled(pos:int, text:String = "", toolTipText:String = "", toolTipHeader:String = ""):void {
	//Removes sex-related button in SFW mode.
	if (flags[kFLAGS.SFW_MODE] > 0) {
		if (text.indexOf("Sex") != -1 || text.indexOf("Threesome") != -1 ||  text.indexOf("Foursome") != -1 || text == "Watersports" || text == "Make Love" || text == "Use Penis" || text == "Use Vagina" || text.indexOf("Fuck") != -1 || text.indexOf("Ride") != -1 || (text.indexOf("Mount") != -1 && text.indexOf("Mountain") == -1) || text.indexOf("Vagina") != -1) {
			trace("Button removed due to SFW mode.");
			return;
		}
	}

	if (toolTipText == "") toolTipText = getButtonToolTipText(text);
	if (toolTipHeader == "") toolTipHeader = getButtonToolTipHeader(text);
	mainView.showBottomButtonDisabled(pos, text, toolTipText, toolTipHeader);
	flushOutputTextToGUI();
}

public function setButtonTooltip(index:int, toolTipHeader:String = "", toolTipText:String = ""):void {
	mainView.showBottomButton(index, mainView.bottomButtons[index].labelText, mainView.bottomButtons[index].callback, toolTipText, toolTipHeader);
}

public function hasButton(arg:*):Boolean {
	if( arg is String )
		return mainView.hasButton( arg as String );
	else
		return false;
}

/**
 * Removes a button.
 * @param	arg The position to remove a button. (First row is 0-4, second row is 5-9, third row is 10-14.)
 */
public function removeButton(arg:*):void {
	var buttonToRemove:int = 0;
	if(arg is String) {
		buttonToRemove = mainView.indexOfButtonWithLabel( arg as String );
	}
	if(arg is Number) {
		if(arg < 0 || arg > 14) return;
		buttonToRemove = Math.round(arg);
	}
	mainView.hideBottomButton( buttonToRemove );
}

/**
 * Hides all bottom buttons.
 */
public function menu():void { //The newer, simpler menu - blanks all buttons so addButton can be used
	for (var i:int = 0; i <= 14; i++) {
		mainView.hideBottomButton(i);
		mainView.bottomButtons[i].alpha = 1; // Dirty hack.
	}
	flushOutputTextToGUI();
}

/**
 * Adds buttons that can be chosen. 
 * 
 * I highly recommend you <b>DO NOT</b> use this for new content. Use addButton() instead.
 */
public function choices(text1:String, butt1:Function,
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
/*
	var callback :Function;
	var toolTipText :String;

	var textLabels :Array;
	var j :int;

	textLabels = [
		text1,
		text2,
		text3,
		text4,
		text5,
		text6,
		text7,
		text8,
		text9,
		text0
	];

	//Transfer event code to storage
	buttonEvents[0] = butt1;
	buttonEvents[1] = butt2;
	buttonEvents[2] = butt3;
	buttonEvents[3] = butt4;
	buttonEvents[4] = butt5;
	buttonEvents[5] = butt6;
	buttonEvents[6] = butt7;
	buttonEvents[7] = butt8;
	buttonEvents[8] = butt9;
	buttonEvents[9] = butt0;

	var tmpJ:int;

	// iterate over the button options, and only enable the ones which have a corresponding event number
	menu();
	for (tmpJ = 0; tmpJ < 10; tmpJ += 1)
	{
		if(buttonEvents[tmpJ] == -9000 || buttonEvents[tmpJ] == 0 || buttonEvents[tmpJ] == null) {
			mainView.hideBottomButton( tmpJ );
		}
		else {
			if (buttonEvents[tmpJ] is Number) {
				addButton(tmpJ, textLabels[tmpJ], eventParser, buttonEvents[tmpJ]);
				//callback = createCallBackFunction(eventParser, buttonEvents[tmpJ] );
			} else {
				addButton(tmpJ, textLabels[tmpJ], buttonEvents[tmpJ]);
				//callback = createCallBackFunction(buttonEvents[tmpJ], null);
			}
			toolTipText = getButtonToolTipText( textLabels[ tmpJ ] );

			//mainView.showBottomButton( tmpJ, textLabels[ tmpJ ], callback, toolTipText );
		}

	}
	// funcs = new Array();
	// args = new Array();
	//mainView.setOutputText( currentText );
	flushOutputTextToGUI();
*/
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
public function multipageChoices( cancelFunction :*, menuItems :Array ) :void {
	const itemsPerPage :int = 8;

	var currentPageIndex :int;
	var pageCount :int;

	function getPageOfItems( pageIndex :int ) :Array {
		var startItemIndex:int = pageIndex * itemsPerPage;

		return menuItems.slice( startItemIndex, startItemIndex + itemsPerPage );
	}

	function flatten( pageItems :Array ) :Array {
		var i:int, l:int;
		var flattenedItems:Array = [];

		for( i = 0, l = pageItems.length; i < l; ++i ) {
			flattenedItems = flattenedItems.concat( pageItems[ i ] );
		}

		return flattenedItems;
	}

	function showNextPage() :void {
		showPage( (currentPageIndex + 1) % pageCount );
	}

	function showPage( pageIndex :int ) :void {
		var currentPageItems :Array; // holds the current page of items.

		if( pageIndex < 0 )
			pageIndex = 0;
		if( pageIndex >= pageCount )
			pageIndex = pageCount - 1;

		currentPageIndex = pageIndex;
		currentPageItems = getPageOfItems( pageIndex );

		// I did it this way so as to use only one actual menu setting function.
		// I figured it was safer until the menu functions stabilize.

		// insert page functions.
		// First pad out the items so it's always in a predictable state.
		while( currentPageItems.length < 8 ) {
			currentPageItems.push( [ "", 0 ] );
		}

		// Insert next button.
		currentPageItems.splice( 4, 0, [
			"See page " +
				String( ((currentPageIndex + 1) % pageCount) + 1 ) + // A compelling argument for 1-indexing?
				'/' +
				String( pageCount ),
			pageCount > 1 ? showNextPage : 0
			// "Next Page", pageCount > 1 ? showNextPage : 0
			]);

		// Cancel/Back button always appears in bottom right, like in the inventory.
		currentPageItems.push([
			"Back", cancelFunction || 0
			]);

		choices.apply( null, flatten( currentPageItems ) );
	}

	pageCount = Math.ceil( menuItems.length / itemsPerPage );

	if( typeof cancelFunction != 'function' )
		cancelFunction = 0;

	showPage( 0 );
}

// simpleChoices and doYesNo are convenience functions. They shouldn't re-implement code from choices()
/**
 * Adds five button that can be chosen. 
 * 
 * I highly recommend you <b>DO NOT</b> use this for new content. Use addButton() instead.
 */
public function simpleChoices(text1:String, butt1:Function, 
						text2:String, butt2:Function, 
						text3:String, butt3:Function, 
						text4:String, butt4:Function, 
						text5:String, butt5:Function):void { //New typesafe version

	//trace("SimpleChoices");
/*	choices(text1,butt1,
			text2,butt2,
			text3,butt3,
			text4,butt4,
			text5,butt5,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0);*/
	menu();
	addButton(0, text1, butt1);
	addButton(1, text2, butt2);
	addButton(2, text3, butt3);
	addButton(3, text4, butt4);
	addButton(4, text5, butt5);
}

/**
 * Clears all button and adds a 'Yes' and a 'No' button.
 * @param	eventYes The event parser or function to call if 'Yes' button is pressed.
 * @param	eventNo The event parser or function to call if 'No' button is pressed.
 */
public function doYesNo(eventYes:Function, eventNo:Function):void { //New typesafe version
	menu();
	addButton(0, "Yes", eventYes);
	addButton(1, "No", eventNo);
/*
	//Make buttons 1-2 visible and hide the rest.

	//trace("doYesNo");
	choices("Yes",eventYes,
			"No",eventNo,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0,
			"",0);

}
*/
}

/**
 * Clears all button and adds a 'Next' button.
 * @param	event The event function to call if the button is pressed.
 */
public function doNext(event:Function):void { //Now typesafe
	//Prevent new events in combat from automatically overwriting a game over. 
	if (mainView.getButtonText(0).indexOf("Game Over") != -1) {
		trace("Do next setup cancelled by game over");
		return;
	}
	
	//trace("DoNext have item:", eventNo);
	//choices("Next", event, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0); 
	menu();
	addButton(0, "Next", event);
}

/* Was never called
public function doNextClear(eventNo:*):void 
{
	outputText("", true, true);
	//trace("DoNext Clearing display");
	//trace("DoNext have item:", eventNo);
	choices("Next", eventNo, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0);
}
*/

public function invertGo():void{ 
	mainView.invert();
}

/**
 * Used to update the display of statistics
 */
public function statScreenRefresh():void {
	Utils.Begin("engineCore","statScreenRefresh");
	mainView.statsView.show(); // show() method refreshes.
	mainViewManager.refreshStats();
	Utils.End("engineCore","statScreenRefresh");
}
/**
 * Show the stats pane. (Name, stats and attributes)
 */
public function showStats():void {
	mainView.statsView.show();
	mainViewManager.refreshStats();
	mainViewManager.tweenInStats();
}
/**
 * Hide the stats pane. (Name, stats and attributes)
 */
public function hideStats():void {
	if (!mainViewManager.buttonsTweened) mainView.statsView.hide();
	mainViewManager.tweenOutStats();
}

/**
 * Hide the top buttons.
 */
public function hideMenus():void {
	mainView.hideAllMenuButtons();
}

/**
 * Hides the up/down arrow on stats pane.
 */
public function hideUpDown():void {
	mainView.statsView.hideUpDown();
	//Clear storage values so up/down arrows can be properly displayed
	oldStats.oldStr = 0;
	oldStats.oldTou = 0;
	oldStats.oldSpe = 0;
	oldStats.oldInte = 0;
	oldStats.oldWis = 0;
	oldStats.oldLib = 0;
	oldStats.oldSens = 0;
	oldStats.oldCor = 0;  
	oldStats.oldHP = 0;
	oldStats.oldLust = 0;
	oldStats.oldFatigue = 0;
	oldStats.oldSoulforce = 0;
	oldStats.oldHunger = 0;
}

//Modify fatigue
//types:
//  0 - normal
//	1 - magic
//	2 - physical
//	3 - non-bloodmage magic
//  4 - bow usage
//	5 - white magic
//	6 - black magic
//	7 - non-bloodmage white magic
//	8 - non-bloodmage black magic
public function fatigue(mod:Number,type:Number  = 0):void {
	combat.fatigueImpl(mod,type);
}
//function changeFatigue
public function changeFatigue(changeF:Number):void {
	fatigue(changeF);
}

public function minLust():Number {
	return player.minLust();
}

public function openURL(url:String):void
{
    navigateToURL(new URLRequest(url), "_blank");
}

/**
 * Awards the achievement. Will display a blue text if achievement hasn't been earned.
 * @param	title The name of the achievement.
 * @param	achievement The achievement to be awarded.
 * @param	display Determines if achievement earned should be displayed.
 * @param	nl Inserts a new line before the achievement text.
 * @param	nl2 Inserts a new line after the achievement text.
 */
public function awardAchievement(title:String, achievement:*, display:Boolean = true, nl:Boolean = false, nl2:Boolean = true):void {
	if (achievements[achievement] != null) {
		if (achievements[achievement] <= 0) {
			achievements[achievement] = 1;
			if (nl && display) outputText("\n");
			if (display) outputText("<b><font color=\"#000080\">Achievement unlocked: " + title + "</font></b>");
			if (nl2 && display) outputText("\n");
			kGAMECLASS.saves.savePermObject(false); //Only save if the achievement hasn't been previously awarded.
		}
	}
	else outputText("\n<b>ERROR: Invalid achievement!</b>");
}

public function lustPercent():Number {
	var lust:Number = 100;
	var minLustCap:Number = 25;
	
	//++++++++++++++++++++++++++++++++++++++++++++++++++
	//ADDITIVE REDUCTIONS
	//THESE ARE FLAT BONUSES WITH LITTLE TO NO DOWNSIDE
	//TOTAL IS LIMITED TO 75%!
	//++++++++++++++++++++++++++++++++++++++++++++++++++
	//Corrupted Libido reduces lust gain by 10%!
	if(player.findPerk(PerkLib.CorruptedLibido) >= 0) lust -= 10;
	//Acclimation reduces by 15%
	if(player.findPerk(PerkLib.Acclimation) >= 0) lust -= 15;
	//Purity blessing reduces lust gain
	if(player.findPerk(PerkLib.PurityBlessing) >= 0) lust -= 5;
	//Resistance = 10%
	if(player.findPerk(PerkLib.ResistanceI) >= 0) lust -= 5;
	if(player.findPerk(PerkLib.ResistanceII) >= 0) lust -= 5;
	if(player.findPerk(PerkLib.ResistanceIII) >= 0) lust -= 5;
	if(player.findPerk(PerkLib.ResistanceIV) >= 0) lust -= 5;
	if(player.findPerk(PerkLib.ResistanceV) >= 0) lust -= 5;
	if(player.findPerk(PerkLib.ChiReflowLust) >= 0) lust -= UmasShop.NEEDLEWORK_LUST_LUST_RESIST;
	if(lust < minLustCap) lust = minLustCap;
	if(player.statusEffectv1(StatusEffects.BlackCatBeer) > 0) {
		if(lust >= 80) lust = 100;
		else lust += 20;
	}
	lust += Math.round(player.perkv1(PerkLib.PentUp)/2);
	//++++++++++++++++++++++++++++++++++++++++++++++++++
	//MULTIPLICATIVE REDUCTIONS
	//THESE PERKS ALSO RAISE MINIMUM LUST OR HAVE OTHER
	//DRAWBACKS TO JUSTIFY IT.
	//++++++++++++++++++++++++++++++++++++++++++++++++++
	//Bimbo body slows lust gains!
	if((player.hasStatusEffect(StatusEffects.BimboChampagne) || player.findPerk(PerkLib.BimboBody) >= 0) && lust > 0) lust *= .75;
	if(player.findPerk(PerkLib.BroBody) >= 0 && lust > 0) lust *= .75;
	if(player.findPerk(PerkLib.FutaForm) >= 0 && lust > 0) lust *= .75;
	//Omnibus' Gift reduces lust gain by 15%
	if(player.findPerk(PerkLib.OmnibusGift) >= 0) lust *= .85;
	//Luststick reduces lust gain by 10% to match increased min lust
	if(player.findPerk(PerkLib.LuststickAdapted) >= 0) lust *= 0.9;
	if(player.hasStatusEffect(StatusEffects.Berzerking)) lust *= .6;
	if (player.findPerk(PerkLib.PureAndLoving) >= 0) lust *= 0.95;
	//Berseking reduces lust gains by 10%
	if(player.hasStatusEffect(StatusEffects.Berzerking)) lust *= 0.9;
	
	//Items
	if (player.jewelryEffectId == JewelryLib.PURITY) lust *= 1 - (player.jewelryEffectMagnitude / 100);
	if (player.armor == armors.DBARMOR) lust *= 0.9;
	if (player.weapon == weapons.HNTCANE) lust *= 0.75;
	if ((player.weapon == weapons.PURITAS) || (player.weapon == weapons.ASCENSU)) lust *= 0.9;
	// Lust mods from Uma's content -- Given the short duration and the gem cost, I think them being multiplicative is justified.
	// Changing them to an additive bonus should be pretty simple (check the static values in UmasShop.as)
	var sac:StatusEffectClass = player.statusEffectByType(StatusEffects.UmasMassage);
	if (sac)
	{
		if (sac.value1 == UmasShop.MASSAGE_RELIEF || sac.value1 == UmasShop.MASSAGE_LUST)
		{
			lust *= sac.value2;
		}
	}
	
	lust = Math.round(lust);
	if (player.hasStatusEffect(StatusEffects.Lustzerking) && player.findPerk(PerkLib.ColdLust) < 1) lust = 100;
	return lust;
}

// returns OLD OP VAL
public function applyOperator(old:Number, op:String, val:Number):Number {
	switch(op) {
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

public function testDynStatsEvent():void {
	clearOutput();
	outputText("Old: "+player.str+" "+player.tou+" "+player.spe+" "+player.inte+" "+player.lib+" "+player.sens+" "+player.lust+"\n");
	dynStats("tou", 1, "spe+", 2, "int-", 3, "lib*", 2, "sen=", 25,"lust/",2);
	outputText("Mod: 0 1 +2 -3 *2 =25 /2\n");
	outputText("New: "+player.str+" "+player.tou+" "+player.spe+" "+player.inte+" "+player.lib+" "+player.sens+" "+player.lust+"\n");
	doNext(playerMenu);
}

/**
 * Modify stats.
 *
 * Arguments should come in pairs nameOp:String, value:Number/Boolean <br/>
 * where nameOp is ( stat_name + [operator] ) and value is operator argument<br/>
 * valid operators are "=" (set), "+", "-", "*", "/", add is default.<br/>
 * valid stat_names are "str", "tou", "spe", "int", "lib", "wis", "sen", "lus", "cor" or their full names; also "resisted"/"res" (apply lust resistance, default true) and "noBimbo"/"bim" (do not apply bimbo int gain reduction, default false)
 */
public function dynStats(... args):void
{
	// Check num of args, we should have a multiple of 2
	if ((args.length % 2) != 0)
	{
		trace("dynStats aborted. Keys->Arguments could not be matched");
		return;
	}

	var argDefs:Object = { //[value, operator]
		str: [ 0, "+"],
		tou: [ 0, "+"],
		spe: [ 0, "+"],
		int: [ 0, "+"],
		lib: [ 0, "+"],
		sen: [ 0, "+"],
		lus: [ 0, "+"],
		cor: [ 0, "+"],
		res: [ true, "="],
		bim: [ false, "="],
		wis: [ 0, "+"]
	};
	var aliases:Object = {
		"strength":"str",
		"toughness": "tou",
		"speed": "spe",
		"intellect": "int",
		"inte": "int",
		"libido": "lib",
		"sensitivity": "sen",
		"sens": "sen",
		"lust": "lus",
		"corruption": "cor",
		"resisted": "res",
		"noBimbo": "bim",
		"wisdom": "wis"
	};

	for (var i:int = 0; i < args.length; i += 2)
	{
		if (typeof(args[i]) == "string")
		{
			// Make sure the next arg has the POSSIBILITY of being correct
			if ((typeof(args[i + 1]) != "number") && (typeof(args[i + 1]) != "boolean"))
			{
				trace("dynStats aborted. Next argument after argName is invalid! arg is type " + typeof(args[i + 1]));
				continue;
			}
			var argOp:String = "";
			// Figure out which array to search
			var argsi:String = (args[i] as String);
			if ("+-*/=".indexOf(argsi.charAt(argsi.length - 1)) != -1) {
				argOp = argsi.charAt(argsi.length - 1);
				argsi = argsi.slice(0, argsi.length - 1);
			}
			if (argsi in aliases) argsi = aliases[argsi];

			if (argsi in argDefs) {
				argDefs[argsi][0] = args[i + 1];
				if (argOp) argDefs[argsi][1] = argOp;
			} else {
				trace("Couldn't find the arg name " + argsi + " in the index arrays. Welp!");
			}
		}
		else
		{
			trace("dynStats aborted. Expected a key and got SHIT");
			return;
		}
	}
	// Got this far, we have values to statsify
	var newStr:Number = applyOperator(player.str, argDefs.str[1], argDefs.str[0]);
	var newTou:Number = applyOperator(player.tou, argDefs.tou[1], argDefs.tou[0]);
	var newSpe:Number = applyOperator(player.spe, argDefs.spe[1], argDefs.spe[0]);
	var newInte:Number = applyOperator(player.inte, argDefs.int[1], argDefs.int[0]);
	var newWis:Number = applyOperator(player.wis, argDefs.wis[1], argDefs.wis[0]);
	var newLib:Number = applyOperator(player.lib, argDefs.lib[1], argDefs.lib[0]);
	var newSens:Number = applyOperator(player.sens, argDefs.sen[1], argDefs.sen[0]);
	var newLust:Number = applyOperator(player.lust, argDefs.lus[1], argDefs.lus[0]);
	var newCor:Number = applyOperator(player.cor, argDefs.cor[1], argDefs.cor[0]);
	var modStr:Number = newStr - player.str;
	var modTou:Number = newTou - player.tou;
	var modSpe:Number = newSpe - player.spe;
	var modInte:Number = newInte - player.inte;
	var modWis:Number = newWis - player.wis;
	var modLib:Number = newLib - player.lib;
	var modSens:Number = newSens - player.sens;
	var modLust:Number = newLust - player.lust;
	var modCorr:Number = newCor - player.cor;
	var resisted:Boolean= argDefs.res;
	var noBimbo:Boolean = argDefs.noBimbo;
	//Easy mode cuts lust gains!
	if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1 && modLust > 0 && resisted) modLust /= 2;

	//Set original values to begin tracking for up/down values if
	//they aren't set yet.
	//These are reset when up/down arrows are hidden with 
	//hideUpDown();
	//Just check str because they are either all 0 or real values
	if(oldStats.oldStr == 0) {
		oldStats.oldStr = player.str;
		oldStats.oldTou = player.tou;
		oldStats.oldSpe = player.spe;
		oldStats.oldInte = player.inte;
		oldStats.oldWis = player.wis;
		oldStats.oldLib = player.lib;
		oldStats.oldSens = player.sens;
		oldStats.oldCor = player.cor;
		oldStats.oldHP = player.HP;
		oldStats.oldLust = player.lust;
		oldStats.oldFatigue = player.fatigue;
		oldStats.oldSoulforce = player.soulforce;
		oldStats.oldHunger = player.hunger;
	}
	//MOD CHANGES FOR PERKS
	//Bimbos learn slower
	if(!noBimbo)
	{
		if(player.findPerk(PerkLib.FutaFaculties) >= 0 || player.findPerk(PerkLib.BimboBrains) >= 0  || player.findPerk(PerkLib.BroBrains) >= 0) {
			if(modInte > 0) modInte /= 2;
			if(modInte < 0) modInte *= 2;
		}
		if(player.findPerk(PerkLib.FutaForm) >= 0 || player.findPerk(PerkLib.BimboBody) >= 0  || player.findPerk(PerkLib.BroBody) >= 0) {
			if(modLib > 0) modLib *= 2;
			if(modLib < 0) modLib /= 2;
		}
	}

	// Uma's Perkshit
	if (player.findPerk(PerkLib.ChiReflowSpeed)>=0 && modSpe < 0) modSpe *= UmasShop.NEEDLEWORK_SPEED_SPEED_MULTI;
	if (player.findPerk(PerkLib.ChiReflowLust)>=0 && modLib > 0) modLib *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
	if (player.findPerk(PerkLib.ChiReflowLust)>=0 && modSens > 0) modSens *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;

	//Apply lust changes in NG+.
	if (resisted) modLust *= 1 + (player.newGamePlusMod() * 0.2);

	//lust resistance
	if(modLust > 0 && resisted) modLust *= lustPercent()/100;
	if(modLib > 0 && player.findPerk(PerkLib.PurityBlessing) >= 0) modLib *= 0.75;
	if(modCorr > 0 && player.findPerk(PerkLib.PurityBlessing) >= 0) modCorr *= 0.5;
	if(modCorr > 0 && player.findPerk(PerkLib.PureAndLoving) >= 0) modCorr *= 0.75;
	if (modCorr > 0 && player.weapon == weapons.HNTCANE) modCorr *= 0.5;
	if (player.findPerk(PerkLib.AscensionMoralShifter) >= 0) modCorr *= 1 + (player.perkv1(PerkLib.AscensionMoralShifter) * 0.2);
	//Change original stats
	player.str+=modStr;
	player.tou+=modTou;
	player.spe+=modSpe;
	player.inte+=modInte;
	player.lib+=modLib;
	player.wis+=modWis;

	if(player.sens > 50 && modSens > 0) modSens/=2;
	if(player.sens > 75 && modSens > 0) modSens/=2;
	if(player.sens > 90 && modSens > 0) modSens/=2;
	if(player.sens > 50 && modSens < 0) modSens*=2;
	if(player.sens > 75 && modSens < 0) modSens*=2;
	if(player.sens > 90 && modSens < 0) modSens*=2;

	player.sens+=modSens;
	player.lust+=modLust;
	player.cor += modCorr;

	//Bonus gain for perks!
	if(player.findPerk(PerkLib.Strong) >= 0 && modStr >= 0) player.str+=modStr*player.perk(player.findPerk(PerkLib.Strong)).value1;
	if(player.findPerk(PerkLib.Tough) >= 0 && modTou >= 0) player.tou+=modTou*player.perk(player.findPerk(PerkLib.Tough)).value1;
	if(player.findPerk(PerkLib.Fast) >= 0 && modSpe >= 0) player.spe+=modSpe*player.perk(player.findPerk(PerkLib.Fast)).value1;
	if(player.findPerk(PerkLib.Smart) >= 0 && modInte >= 0) player.inte+=modInte*player.perk(player.findPerk(PerkLib.Smart)).value1;
	if(player.findPerk(PerkLib.Lusty) >= 0 && modLib >= 0) player.lib+=modLib*player.perk(player.findPerk(PerkLib.Lusty)).value1;
	if (player.findPerk(PerkLib.Sensitive) >= 0 && modSens >= 0) player.sens += modSens * player.perk(player.findPerk(PerkLib.Sensitive)).value1;

	// Uma's Str Cap from Perks (Moved to max stats)
	/*if (player.findPerk(PerkLib.ChiReflowSpeed) >= 0)
	{
		if (player.str > UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP)
		{
			player.str = UmasShop.NEEDLEWORK_SPEED_STRENGTH_CAP;
		}
	}
	if (player.findPerk(PerkLib.ChiReflowDefense) >= 0)
	{
		if (player.spe > UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP)
		{
			player.spe = UmasShop.NEEDLEWORK_DEFENSE_SPEED_CAP;
		}
	}*/
	
	//Keep stats in bounds
	if(player.cor < 0) player.cor = 0;
	if(player.cor > 100) player.cor= 100;
	var maxes:Object = player.getAllMaxStats();
	if(player.str > maxes.str) player.str = maxes.str;
	if(player.str < 1) player.str = 1;
	if(player.tou > maxes.tou) player.tou = maxes.tou;
	if(player.tou < 1) player.tou = 1;
	if(player.spe > maxes.spe) player.spe = maxes.spe;
	if(player.spe < 1) player.spe = 1;
	if(player.inte > maxes.inte) player.inte = maxes.inte;
	if(player.inte < 1) player.inte = 1;
	if(player.wis > maxes.wis) player.wis = maxes.wis;
	if(player.wis < 1) player.wis = 1;
	if(player.lib > maxes.lib) player.lib = maxes.lib;
	if(player.lib < 0) player.lib = 0;
	//Minimum libido. Rewritten.
	var minLib:Number = 0;
	
	if (player.gender > 0) minLib = 15;
	else minLib = 10;
	
	if (player.armorName == "lusty maiden's armor") {
		if (minLib < 50)
		{
			minLib = 50;
		}
	}
	if (minLib < (minLust() * 2 / 3))
	{
		minLib = (minLust() * 2 / 3);
	}
	if (player.jewelryEffectId == JewelryLib.PURITY)
	{
		minLib -= player.jewelryEffectMagnitude;
	}
	if (player.findPerk(PerkLib.PurityBlessing) >= 0) {
		minLib -= 2;
	}
	if (player.findPerk(PerkLib.HistoryReligious) >= 0 || player.findPerk(PerkLib.PastLifeReligious) >= 0) {
		minLib -= 2;
	}
	//Applies minimum libido.
	if (player.lib < minLib)
	{
		player.lib = minLib;
	}
	
	//Minimum sensitivity.
	if(player.sens > 100) player.sens = 100;
	if(player.sens < 10) player.sens = 10;
	
	//Add HP for toughness change.
	HPChange(modTou*2, false);
	//if (player.tou < 20) HPChange(modTou*2, false);
	//else if (player.tou >= 20 && player.tou < 40) HPChange(modTou*3, false);
	//else if (player.tou >= 40 && player.tou < 60) HPChange(modTou*4, false);
	//else if (player.tou >= 60 && player.tou < 80) HPChange(modTou*5, false);
	//else if (player.tou >= 80) HPChange(modTou * 6, false);
	//else outputText("Something screw up -_-'");
	//Reduce hp if over max
	if(player.HP > maxHP()) player.HP = maxHP();
	
	//Combat bounds
	if(player.lust > player.maxLust()) player.lust = player.maxLust();
	//if(player.lust < player.lib) {
	//        player.lust=player.lib;
	//
	//Update to minimum lust if lust falls below it.
	if(player.lust < minLust()) player.lust = minLust();
	//worms moved to minLust() in Player.as.
	if(player.lust > player.maxLust()) player.lust = player.maxLust();
	if(player.lust < 0) player.lust = 0;
	
	//Reduce soulforce if over max
	if(player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
	
	//Refresh the stat pane with updated values
	//mainView.statsView.showUpDown();
	showUpDown();
	statScreenRefresh();
}
	
public function showUpDown():void { //Moved from StatsView.
	Utils.Begin("engineCore","showUpDown");
	function _oldStatNameFor(statName:String):String {
		return 'old' + statName.charAt(0).toUpperCase() + statName.substr(1);
	}

	var statName:String,
		oldStatName:String,
		allStats:Array;

//	mainView.statsView.upDownsContainer.visible = true;

//	allStats = ["str", "tou", "spe", "inte", "wis" "lib", "sens", "cor", "HP", "lust", "wrath", "fatigue", "mana", "soulforce", "hunger"];
	allStats = ["str", "tou", "spe", "inte", "lib", "sens", "cor", "HP", "lust", "fatigue", "hunger"];

	for each(statName in allStats) {
		oldStatName = _oldStatNameFor(statName);

		if(player[statName] > oldStats[oldStatName]) {
			mainView.statsView.showStatUp(statName);
		}
		if(player[statName] < oldStats[oldStatName]) {
			mainView.statsView.showStatDown(statName);
		}
	}
	Utils.End("engineCore","showUpDown");
}

public function range(min:Number, max:Number, round:Boolean = false):Number 
{
	var num:Number = (min + Math.random() * (max - min));

	if (round) return Math.round(num);
	return num;
}

public function cuntChangeOld(cIndex:Number, vIndex:Number, display:Boolean):void {
	//Virginity check
	if(player.vaginas[vIndex].virgin) {
		if(display) outputText("\nYour " + vaginaDescript(vIndex) + " loses its virginity!");
		player.vaginas[vIndex].virgin = false;
	}        
	//If cock is bigger than unmodified vagina can hold - 100% stretch!
	if(player.vaginas[vIndex].capacity() <= monster.cocks[cIndex].cArea()) {
		if(player.vaginas[vIndex].vaginalLooseness < 5) {
			trace("CUNT STRETCHED: By cock larger than it's total capacity.");
			if(display) {
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE) outputText("<b>Your " + vaginaDescript(0) + " is stretched even further, capable of taking even the largest of demons and beasts.</b>  ");
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_GAPING) outputText("<b>Your " + vaginaDescript(0) + " painfully stretches, gaping wide-open.</b>  ");
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_LOOSE) outputText("<b>Your " + vaginaDescript(0) + " is now very loose.</b>  ");
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_NORMAL) outputText("<b>Your " + vaginaDescript(0) + " is now loose.</b>  ");
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_TIGHT) outputText("<b>Your " + vaginaDescript(0) + " loses its virgin-like tightness.</b>  ");
			}
			player.vaginas[vIndex].vaginalLooseness++;
		}
	}
	//If cock is within 75% of max, streeeeetch 33% of the time
	if(player.vaginas[vIndex].capacity() * .75 <= monster.cocks[cIndex].cArea()) {
		if(player.vaginas[vIndex].vaginalLooseness < 5) {
			trace("CUNT STRETCHED: By cock @ 75% of capacity.");
			if(display) {
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE) outputText("<b>Your " + vaginaDescript(0) + " is stretched even further, capable of taking even the largest of demons and beasts.</b>  ");
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_GAPING) outputText("<b>Your " + vaginaDescript(0) + " painfully stretches, gaping wide-open.</b>  ");
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_LOOSE) outputText("<b>Your " + vaginaDescript(0) + " is now very loose.</b>  ");
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_NORMAL) outputText("<b>Your " + vaginaDescript(0) + " is now loose.</b>  ");
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_TIGHT) outputText("<b>Your " + vaginaDescript(0) + " loses its virgin-like tightness.</b>  ");
			}
			player.vaginas[vIndex].vaginalLooseness++;
		}
	}
}

/**
 * Returns true if you're on SFW mode.
 */
public function doSFWloss():Boolean {
	clearOutput();
	if (flags[kFLAGS.SFW_MODE] > 0) {
		if (player.HP <= 0) outputText("You collapse from your injuries.");
		else outputText("You collapse from your overwhelming desires.");
		if (inCombat) cleanupAfterCombat();
		else doNext(camp.returnToCampUseOneHour)
		return true;
	}
	else return false;
}

public function doNothing():void {
	//This literally does nothing.
}

