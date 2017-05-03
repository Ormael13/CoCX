import classes.*;
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
			outputText("You're as healthy as you can be.\n", false);
	}
	else if (changeNum > 0) {
		if(player.HP >= maxHP())
			outputText("Your HP maxes out at " + maxHP() + ".\n", false);
		else
			outputText("You gain <b><font color=\"#008000\">" + int(changeNum) + "</font></b> HP.\n", false);
	}
	else {
		if(player.HP <= 0)
			outputText("You take <b><font color=\"#800000\">" + int(changeNum*-1) + "</font></b> damage, dropping your HP to 0.\n", false);
		else
			outputText("You take <b><font color=\"#800000\">" + int(changeNum*-1) + "</font></b> damage.\n", false);
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
	outputText(speech, false);
}
*/

/**
 * Clear the text on screen.
 */
public function clearOutput():void {
	forceUpdate();
	currentText = "";
	mainView.clearOutputText();
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
public function outputText(output:String, 
						purgeText:Boolean = false, 
						parseAsMarkdown:Boolean = false):void
{
	// we have to purge the output text BEFORE calling parseText, because if there are scene commands in 
	// the parsed text, parseText() will write directly to the output


	// This is cleaup in case someone hits the Data or new-game button when the event-test window is shown. 
	// It's needed since those buttons are available even when in the event-tester
	mainView.hideTestInputPanel();

	if (purgeText)
	{
		clearOutput();
	}

	output = this.parser.recursiveParser(output, parseAsMarkdown);

	//OUTPUT!
	if(purgeText) {
		//if(!debug) mainText.htmlText = output;
		currentText = output;
	}
	else {
		currentText += output;
		//if(!debug) mainText.htmlText = currentText;
	}
	if(debug) 
	{
		mainView.setOutputText( currentText );
	}

}

public function flushOutputTextToGUI():void
{
	var fmt:TextFormat = mainView.mainText.getTextFormat();
	
	if (flags[kFLAGS.CUSTOM_FONT_SIZE] != 0) fmt.size = flags[kFLAGS.CUSTOM_FONT_SIZE];
	
	mainView.setOutputText(currentText);
	
	if (flags[kFLAGS.CUSTOM_FONT_SIZE] != 0)
	{
		mainView.mainText.setTextFormat(fmt);
	}
	if (mainViewManager.mainColorArray[flags[kFLAGS.BACKGROUND_STYLE]] != null) mainView.mainText.textColor = mainViewManager.mainColorArray[flags[kFLAGS.BACKGROUND_STYLE]];
}

public function displayHeader(string:String):void {
	outputText("<font size=\"36\" face=\"Georgia\"><u>" + string + "</u></font>\n");
}

public function displayPerks(e:MouseEvent = null):void {
	var temp:int = 0;
	clearOutput();
	displayHeader("Perks");
	while(temp < player.perks.length) {
		outputText("<b>" + player.perk(temp).perkName + "</b> - " + player.perk(temp).perkDesc + "\n", false);
		temp++;
	}
	menu();
	var button:int = 0;
	addButton(button++, "Next", playerMenu);
	if(player.perkPoints > 0) {
		outputText("\n<b>You have " + num2Text(player.perkPoints) + " perk point", false);
		if(player.perkPoints > 1) outputText("s", false);
		outputText(" to spend.</b>", false);
		addButton(button++, "Perk Up", perkBuyMenu);
	}
	if(player.findPerk(PerkLib.DoubleAttack) >= 0 || player.findPerk(PerkLib.DoubleAttackLarge) >= 0 || player.findPerk(PerkLib.Combo) >= 0) {
		outputText("\n<b>You can adjust your melee attack settings.</b>");
		addButton(button++,"Melee Opt",doubleAttackOptions);
	}
	if(player.findPerk(PerkLib.DoubleStrike) >= 0 || player.findPerk(PerkLib.ElementalArrows) >= 0 || player.findPerk(PerkLib.Cupid) >= 0 || player.findPerk(PerkLib.EnvenomedBolt) >= 0) {
		outputText("\n<b>You can adjust your range strike settings.</b>");
		addButton(button++,"Range Opt",doubleStrikeOptions);
	}
	if(player.findPerk(PerkLib.Spellsword) >= 0 || player.findPerk(PerkLib.Spellarmor) >= 0 || player.findPerk(PerkLib.Battleflash) >= 0 || player.findPerk(PerkLib.Battlemage) >= 0) {
		outputText("\n<b>You can adjust your spell autocast settings.</b>");
		addButton(button++,"Spells Opt",spellautocastOptions);
	}
	addButton(10, "Number of", kGAMECLASS.doNothing);
	addButton(11, "perks: " + player.perks.length, kGAMECLASS.doNothing);
}

public function doubleAttackOptions():void {
	clearOutput();
	menu();
	outputText("You will always attack ");
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 5) outputText("six times");
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 4) outputText("five times");
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 3) outputText("four times");
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 2) outputText("three times");
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) outputText("twice");
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] < 1) outputText("once");
	outputText(" in combat turn");
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 5) outputText(" using 75% of your current strength");
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 4) outputText(" using 80% of your current strength");
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 3) outputText(" using 85% of your current strength");
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 2) outputText(" using 90% of your current strength");
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) outputText(" using 95% of your current strength");
	outputText(".");
	outputText("\n\nYou can change it to different amount of attacks.");
	if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 0) addButton(0, "All Single", singleAttack);
	if ((player.findPerk(PerkLib.DoubleAttack) >= 0 || player.findPerk(PerkLib.DoubleAttackLarge) >= 0) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 1) {
		if ((player.weaponPerk != "Large" || (player.weaponPerk == "Large" && player.findPerk(PerkLib.DoubleAttackLarge) < 0)) && player.weaponPerk != "Dual Large" && player.weaponPerk != "Dual" && player.weaponPerk != "Staff" && (!player.isFistOrFistWeapon() || (player.isFistOrFistWeapon() && player.findPerk(PerkLib.Combo) < 0))) addButton(1, "All Double", doubleAttack);
		else addButtonDisabled(1, "All Double", "You current melee weapon not allow to use this option");	//player.weaponName != "fists"
	}
	if ((player.findPerk(PerkLib.TripleAttack) >= 0 || player.findPerk(PerkLib.TripleAttackLarge) >= 0) && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 2) {
		if ((player.weaponPerk != "Large" || (player.weaponPerk == "Large" && player.findPerk(PerkLib.TripleAttackLarge) < 0)) && player.weaponPerk != "Dual Large" && player.weaponPerk != "Dual" && player.weaponPerk != "Staff" && (!player.isFistOrFistWeapon() || (player.isFistOrFistWeapon() && player.findPerk(PerkLib.ComboMaster) < 0))) addButton(5, "All Triple", tripleAttack);
		else addButtonDisabled(5, "All Triple", "You current melee weapon not allow to use this option");	//player.weaponName != "fists"
	}
	if (player.findPerk(PerkLib.QuadrupleAttack) >= 0 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 3) {
		if (player.weaponPerk != "Large" && player.weaponPerk != "Dual Large" && player.weaponPerk != "Dual" && player.weaponPerk != "Staff" && !player.isFistOrFistWeapon()) addButton(6, "All Quadruple", quadrupleAttack);
		else addButtonDisabled(6, "All Quadruple", "You current melee weapon not allow to use this option");
	}// && player.weaponName != "hooked gauntlets" && player.weaponName != "spiked gauntlet"
	if (player.findPerk(PerkLib.PentaAttack) >= 0 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 4) {
		if (player.weaponPerk != "Large" && player.weaponPerk != "Dual Large" && player.weaponPerk != "Dual" && player.weaponPerk != "Staff" && !player.isFistOrFistWeapon()) addButton(10, "All Penta", pentaAttack);
		else addButtonDisabled(10, "All Penta", "You current melee weapon not allow to use this option");
	}// && player.weaponName != "hooked gauntlets" && player.weaponName != "spiked gauntlet"
	if (player.findPerk(PerkLib.HexaAttack) >= 0 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 5) {
		if (player.weaponPerk != "Large" && player.weaponPerk != "Dual Large" && player.weaponPerk != "Dual" && player.weaponPerk != "Staff" && !player.isFistOrFistWeapon()) addButton(11, "All Hexe", hexaAttack);
		else addButtonDisabled(11, "All Hexe", "You current melee weapon not allow to use this option");
	}// && player.weaponName != "hooked gauntlets" && player.weaponName != "spiked gauntlet"
	
	var e:MouseEvent;
	if (inCombat) addButton(14, "Back", combatMenu);
	else addButton(14, "Back", displayPerks);
}

public function hexaAttack():void {
	flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 5;
	doubleAttackOptions();
}
public function pentaAttack():void {
	flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 4;
	doubleAttackOptions();
}
public function quadrupleAttack():void {
	flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 3;
	doubleAttackOptions();
}
public function tripleAttack():void {
	flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 2;
	doubleAttackOptions();
}
public function doubleAttack():void {
	flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 1;
	doubleAttackOptions();
}
public function singleAttack():void {
	flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 0;
	doubleAttackOptions();
}

public function doubleStrikeOptions():void {
	clearOutput();
	menu();
	outputText("You will always shoot ");
	if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 4) outputText("five");
	if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 3) outputText("four");
	if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 2) outputText("three");
	if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 1) outputText("two");
	if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] < 1) outputText("single");
	outputText(" projectile");
	if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] > 0) outputText("s");
	outputText(" in combat.");
	outputText("\n\nYou can change it to different amount of projectiles.");
	if (player.findPerk(PerkLib.ElementalArrows) >= 0) {
		outputText("\n\nIf you learned specific techniques you could even add some magical effects to the projectiles. (Working only with bows and crosbows)");
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 0) outputText("\n\nElemental effect added: <b>None</b>");
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) outputText("\n\nElemental effect added: <b>Fire</b>");
		if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) outputText("\n\nElemental effect added: <b>Ice</b>");
	}
	if (player.findPerk(PerkLib.Cupid) >= 0) {
		outputText("\n\nIf you learned specific black magical you could add it effects to the projectiles. (Working only with bows and crosbows)");
		if (flags[kFLAGS.CUPID_ARROWS] == 0) outputText("\n\nBlack Magic effect added: <b>None</b>");
		if (flags[kFLAGS.CUPID_ARROWS] == 1) outputText("\n\nBlack Magic effect added: <b>Arouse</b>");
	}
	if (player.findPerk(PerkLib.EnvenomedBolt) >= 0) {
		outputText("\n\nIf you can naturaly produce venom then you could add it effects to the projectiles. (Working only with bows and crosbows)");
		if (flags[kFLAGS.ENVENOMED_BOLTS] == 0) outputText("\n\nVenom effect added: <b>No</b>");
		if (flags[kFLAGS.ENVENOMED_BOLTS] == 1) outputText("\n\nVenom effect added: <b>Yes</b>");
	}
	if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 0) addButton(0, "All Single", singleStrike);
	if (player.findPerk(PerkLib.DoubleStrike) >= 0 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 1) {
		if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow") addButton(1, "All Double", doubleStrike);
		else addButtonDisabled(1, "All Double", "You current range weapon not allow to use this option");
	}
	if (player.findPerk(PerkLib.TripleStrike) >= 0 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 2) {
		if (player.weaponRangePerk == "Bow" || player.weaponRangePerk == "Crossbow") addButton(2, "All Triple", tripleStrike);
		else addButtonDisabled(2, "All Triple", "You current range weapon not allow to use this option");
	}
	if (player.findPerk(PerkLib.Manyshot) >= 0 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 3) {
		if (player.weaponRangePerk == "Bow") addButton(5, "All Quad", quadrupleStrike);
		else addButtonDisabled(5, "All Quad", "You current range weapon not allow to use this option");
	}
	if (player.findPerk(PerkLib.WildQuiver) >= 0 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 4) {
		if (player.weaponRangePerk == "Bow") addButton(6, "All Penta", pentaStrike);
		else addButtonDisabled(6, "All Penta", "You current range weapon not allow to use this option");
	}
	if (player.findPerk(PerkLib.Multishot) >= 0 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 5) {
		if (player.weaponRangePerk == "Bow") addButton(7, "All Hexa", hexaStrike);
		else addButtonDisabled(7, "All Hexa", "You current range weapon not allow to use this option");
	}
	if (player.findPerk(PerkLib.ElementalArrows) >= 0 && flags[kFLAGS.ELEMENTAL_ARROWS] != 0) addButton(3, "None", normalArrows);
	if (player.findPerk(PerkLib.ElementalArrows) >= 0 && player.findStatusAffect(StatusAffects.KnowsWhitefire) >= 0 && flags[kFLAGS.ELEMENTAL_ARROWS] != 1) addButton(8, "Fire", fireArrows);
	if (player.findPerk(PerkLib.ElementalArrows) >= 0 && player.findStatusAffect(StatusAffects.KnowsIceSpike) >= 0 && flags[kFLAGS.ELEMENTAL_ARROWS] != 2) addButton(9, "Ice", iceArrows);
	if (player.findPerk(PerkLib.Cupid) >= 0 && flags[kFLAGS.CUPID_ARROWS] != 0) addButton(10, "None", normalArrows2);
	if (player.findPerk(PerkLib.Cupid) >= 0 && player.findStatusAffect(StatusAffects.KnowsArouse) >= 0 && flags[kFLAGS.CUPID_ARROWS] != 1) addButton(11, "Arouse", arouseArrows);
	if (player.findPerk(PerkLib.EnvenomedBolt) >= 0 && flags[kFLAGS.ENVENOMED_BOLTS] != 0) addButton(12, "None", normalArrows3);
	if (player.findPerk(PerkLib.EnvenomedBolt) >= 0 && (player.tailType == TAIL_TYPE_BEE_ABDOMEN || player.tailType == TAIL_TYPE_SCORPION || player.tailType == TAIL_TYPE_MANTICORE_PUSSYTAIL || player.faceType == FACE_SNAKE_FANGS || player.faceType == FACE_SPIDER_FANGS) && flags[kFLAGS.ENVENOMED_BOLTS] != 1) addButton(13, "Venom", venomArrows);
	
	var e:MouseEvent;
	if (inCombat) addButton(14, "Back", combatMenu);
	else addButton(14, "Back", displayPerks);
}

public function iceArrows():void {
	flags[kFLAGS.ELEMENTAL_ARROWS] = 2;
	doubleStrikeOptions();
}
public function fireArrows():void {
	flags[kFLAGS.ELEMENTAL_ARROWS] = 1;
	doubleStrikeOptions();
}
public function normalArrows():void {
	flags[kFLAGS.ELEMENTAL_ARROWS] = 0;
	doubleStrikeOptions();
}
public function arouseArrows():void {
	flags[kFLAGS.CUPID_ARROWS] = 1;
	doubleStrikeOptions();
}
public function normalArrows2():void {
	flags[kFLAGS.CUPID_ARROWS] = 0;
	doubleStrikeOptions();
}
public function venomArrows():void {
	flags[kFLAGS.ENVENOMED_BOLTS] = 1;
	doubleStrikeOptions();
}
public function normalArrows3():void {
	flags[kFLAGS.ENVENOMED_BOLTS] = 0;
	doubleStrikeOptions();
}
public function hexaStrike():void {
	flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 5;
	doubleStrikeOptions();
}
public function pentaStrike():void {
	flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 4;
	doubleStrikeOptions();
}
public function quadrupleStrike():void {
	flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 3;
	doubleStrikeOptions();
}
public function tripleStrike():void {
	flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 2;
	doubleStrikeOptions();
}
public function doubleStrike():void {
	flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 1;
	doubleStrikeOptions();
}
public function singleStrike():void {
	flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 0;
	doubleStrikeOptions();
}

public function spellautocastOptions():void {
	clearOutput();
	menu();
	outputText("You can choose to autocast or not specific buff spells at the start of each combat.\n");
	if (player.findPerk(PerkLib.Spellsword) >= 0) {
		outputText("\n<b>Charge Weapon:</b> ");
		if (flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] == 1) outputText("Manual");
		else outputText("Autocast");
	}
	if (player.findPerk(PerkLib.Spellarmor) >= 0) {
		outputText("\n<b>Charge Armor:</b> ");
		if (flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] == 1) outputText("Manual");
		else outputText("Autocast");
	}
	if (player.findPerk(PerkLib.Battlemage) >= 0) {
		outputText("\n<b>Might:</b> ");
		if (flags[kFLAGS.AUTO_CAST_MIGHT] == 1) outputText("Manual");
		else outputText("Autocast");
	}
	if (player.findPerk(PerkLib.Battleflash) >= 0) {
		outputText("\n<b>Blink:</b> ");
		if (flags[kFLAGS.AUTO_CAST_BLINK] == 1) outputText("Manual");
		else outputText("Autocast");
	}
	if (flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] != 0) addButton(0, "Autocast", autoChargeWeapon);
	if (player.findPerk(PerkLib.Spellsword) >= 0 && flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] != 1) addButton(5, "Manual", manualChargeWeapon);
	if (flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] != 0) addButton(1, "Autocast", autoChargeArmor);
	if (player.findPerk(PerkLib.Spellarmor) >= 0 && flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] != 1) addButton(6, "Manual", manualChargeArmor);
	if (flags[kFLAGS.AUTO_CAST_MIGHT] != 0) addButton(2, "Autocast", autoMight);
	if (player.findPerk(PerkLib.Battlemage) >= 0 && flags[kFLAGS.AUTO_CAST_MIGHT] != 1) addButton(7, "Manual", manualMight);
	if (flags[kFLAGS.AUTO_CAST_BLINK] != 0) addButton(3, "Autocast", autoBlink);
	if (player.findPerk(PerkLib.Battleflash) >= 0 && flags[kFLAGS.AUTO_CAST_BLINK] != 1) addButton(8, "Manual", manualBlink);
	
	var e:MouseEvent;
	addButton(14, "Back", displayPerks);
}

public function manualBlink():void {
	flags[kFLAGS.AUTO_CAST_BLINK] = 1;
	spellautocastOptions();
}
public function autoBlink():void {
	flags[kFLAGS.AUTO_CAST_BLINK] = 0;
	spellautocastOptions();
}
public function manualMight():void {
	flags[kFLAGS.AUTO_CAST_MIGHT] = 1;
	spellautocastOptions();
}
public function autoMight():void {
	flags[kFLAGS.AUTO_CAST_MIGHT] = 0;
	spellautocastOptions();
}
public function manualChargeArmor():void {
	flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] = 1;
	spellautocastOptions();
}
public function autoChargeArmor():void {
	flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] = 0;
	spellautocastOptions();
}
public function manualChargeWeapon():void {
	flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] = 1;
	spellautocastOptions();
}
public function autoChargeWeapon():void {
	flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] = 0;
	spellautocastOptions();
}

public function levelUpGo(e:MouseEvent = null):void {
	clearOutput();
	hideMenus();
	mainView.hideMenuButton( MainView.MENU_NEW_MAIN );
	//Level up
	if (player.XP >= player.requiredXP() && player.level < levelCap) {
		player.XP -= player.requiredXP();
		player.level++;
		player.perkPoints++;
		player.statPoints += 5;
		//if (player.level % 2 == 0) player.ascensionPerkPoints++;
		//przerobić aby z asc perk co ?6/3/1? lvl dostawać another perk point?
		//może też dodać ascension perk aby móc dostawać 6 lub nawet wiecej stat points na lvl up?
		outputText("<b>You are now level " + num2Text(player.level) + "!</b>\n\nYou have gained five attribute points and one perk point!", true);
		doNext(attributeMenu);
	}
	//Spend attribute points
	else if(player.statPoints > 0) {
		attributeMenu();
	}
	//Spend perk points
	else if (player.perkPoints > 0) {
		perkBuyMenu();
	}
	else {
		outputText("<b>ERROR.  LEVEL UP PUSHED WHEN PC CANNOT LEVEL OR GAIN PERKS.  PLEASE REPORT THE STEPS TO REPRODUCE THIS BUG TO FENOXO@GMAIL.COM OR THE FENOXO.COM BUG REPORT FORUM.</b>");
		doNext(playerMenu);
	}
}

//Attribute menu
private function attributeMenu():void {
	clearOutput();
	outputText("You have <b>" + (player.statPoints) + "</b> left to spend.\n\n");
	
	outputText("Strength: ");
	if (player.str < player.getMaxStats("str")) outputText("" + Math.floor(player.str) + " + <b>" + player.tempStr + "</b> → " + Math.floor(player.str + player.tempStr) + "\n");
	else outputText("" + Math.floor(player.str) + " (Maximum)\n");
	
	outputText("Toughness: ");
	if (player.tou < player.getMaxStats("tou")) outputText("" + Math.floor(player.tou) + " + <b>" + player.tempTou + "</b> → " + Math.floor(player.tou + player.tempTou) + "\n");
	else outputText("" + Math.floor(player.tou) + " (Maximum)\n");
	
	outputText("Speed: ");
	if (player.spe < player.getMaxStats("spe")) outputText("" + Math.floor(player.spe) + " + <b>" + player.tempSpe + "</b> → " + Math.floor(player.spe + player.tempSpe) + "\n");
	else outputText("" + Math.floor(player.spe) + " (Maximum)\n");
	
	outputText("Intelligence: ");
	if (player.inte < player.getMaxStats("int")) outputText("" + Math.floor(player.inte) + " + <b>" + player.tempInt + "</b> → " + Math.floor(player.inte + player.tempInt) + "\n");
	else outputText("" + Math.floor(player.inte) + " (Maximum)\n");
	
	outputText("Wisdom: ");
	if (player.wis < player.getMaxStats("wis")) outputText("" + Math.floor(player.wis) + " + <b>" + player.tempWis + "</b> → " + Math.floor(player.wis + player.tempWis) + "\n");
	else outputText("" + Math.floor(player.wis) + " (Maximum)\n");
	
	outputText("Libido: ");
	if (player.lib < player.getMaxStats("lib")) outputText("" + Math.floor(player.lib) + " + <b>" + player.tempLib + "</b> → " + Math.floor(player.lib + player.tempLib) + "\n");
	else outputText("" + Math.floor(player.lib) + " (Maximum)\n");

	menu();
	//Add
	if (player.statPoints > 0) {
		if ((player.str + player.tempStr) < player.getMaxStats("str")) addButton(0, "Add STR", addAttribute, "str", null, null, "Add 1 point to Strength.", "Add Strength");
		if ((player.tou + player.tempTou) < player.getMaxStats("tou")) addButton(1, "Add TOU", addAttribute, "tou", null, null, "Add 1 point to Toughness.", "Add Toughness");
		if ((player.spe + player.tempSpe) < player.getMaxStats("spe")) addButton(2, "Add SPE", addAttribute, "spe", null, null, "Add 1 point to Speed.", "Add Speed");
		if ((player.inte + player.tempInt) < player.getMaxStats("int")) addButton(3, "Add INT", addAttribute, "int", null, null, "Add 1 point to Intelligence.", "Add Intelligence");
		if ((player.wis + player.tempWis) < player.getMaxStats("wis")) addButton(4, "Add WIS", addAttribute, "wis", null, null, "Add 1 point to Wisdom.", "Add Wisdom");
		if ((player.lib + player.tempLib) < player.getMaxStats("lib")) addButton(10, "Add LIB", addAttribute, "lib", null, null, "Add 1 point to Libido.", "Add Libido");
	}
	//Subtract
	if (player.tempStr > 0) addButton(5, "Sub STR", subtractAttribute, "str", null, null, "Subtract 1 point from Strength.", "Subtract Strength");
	if (player.tempTou > 0) addButton(6, "Sub TOU", subtractAttribute, "tou", null, null, "Subtract 1 point from Toughness.", "Subtract Toughness");
	if (player.tempSpe > 0) addButton(7, "Sub SPE", subtractAttribute, "spe", null, null, "Subtract 1 point from Speed.", "Subtract Speed");
	if (player.tempInt > 0) addButton(8, "Sub INT", subtractAttribute, "int", null, null, "Subtract 1 point from Intelligence.", "Subtract Intelligence");
	if (player.tempWis > 0) addButton(9, "Sub WIS", subtractAttribute, "wis", null, null, "Subtract 1 point from Wisdom.", "Subtract Wisdom");
	if (player.tempLib > 0) addButton(11, "Sub LIB", subtractAttribute, "lib", null, null, "Subtract 1 point from Libido.", "Subtract Libido");
	
	addButton(13, "Reset", resetAttributes);
	addButton(14, "Done", finishAttributes);
}

private function addAttribute(attribute:String):void {
	switch(attribute) {
		case "str":
			player.tempStr++;
			break;
		case "tou":
			player.tempTou++;
			break;
		case "spe":
			player.tempSpe++;
			break;
		case "int":
			player.tempInt++;
			break;
		case "wis":
			player.tempWis++;
			break;
		case "lib":
			player.tempLib++;
			break;
		default:
			player.statPoints++; //Failsafe
	}
	player.statPoints--;
	attributeMenu();
}
private function subtractAttribute(attribute:String):void {
	switch(attribute) {
		case "str":
			player.tempStr--;
			break;
		case "tou":
			player.tempTou--;
			break;
		case "spe":
			player.tempSpe--;
			break;
		case "int":
			player.tempInt--;
			break;
		case "wis":
			player.tempWis--;
			break;
		case "lib":
			player.tempLib--;
			break;
		default:
			player.statPoints--; //Failsafe
	}
	player.statPoints++;
	attributeMenu();
}
private function resetAttributes():void {
	//Increment unspent attribute points.
	player.statPoints += player.tempStr;
	player.statPoints += player.tempTou;
	player.statPoints += player.tempSpe;
	player.statPoints += player.tempInt;
	player.statPoints += player.tempWis;
	player.statPoints += player.tempLib;
	//Reset temporary attributes to 0.
	player.tempStr = 0;
	player.tempTou = 0;
	player.tempSpe = 0;
	player.tempInt = 0;
	player.tempWis = 0;
	player.tempLib = 0;
	//DONE!
	attributeMenu();
}
private function finishAttributes():void {
	clearOutput()
	if (player.tempStr > 0)
	{
		if (player.tempStr >= 3) outputText("Your muscles feel significantly stronger from your time adventuring.\n");
		else outputText("Your muscles feel slightly stronger from your time adventuring.\n");
	}
	if (player.tempTou > 0)
	{
		if (player.tempTou >= 3) outputText("You feel tougher from all the fights you have endured.\n");
		else outputText("You feel slightly tougher from all the fights you have endured.\n");
	}
	if (player.tempSpe > 0)
	{
		if (player.tempSpe >= 3) outputText("Your time in combat has driven you to move faster.\n");
		else outputText("Your time in combat has driven you to move slightly faster.\n");
	}
	if (player.tempInt > 0)
	{
		if (player.tempInt >= 3) outputText("Your time spent fighting the creatures of this realm has sharpened your wit.\n");
		else outputText("Your time spent fighting the creatures of this realm has sharpened your wit slightly.\n");
	}
	if (player.tempWis > 0)
	{
		if (player.tempWis >= 3) outputText("Your time spent fighting the creatures of this realm has improved your insight.\n");
		else outputText("Your time spent fighting the creatures of this realm has improved your insight slightly.\n");
	}
	if (player.tempLib > 0)
	{
		if (player.tempLib >= 3) outputText("Your time spent in this realm has made you more lustful.\n");
		else outputText("Your time spent in this realm has made you slightly more lustful.\n");
	}
	if (player.tempStr + player.tempTou + player.tempSpe + player.tempInt + player.tempWis + player.tempLib <= 0 || player.statPoints > 0)
	{
		outputText("\nYou may allocate your remaining stat points later.", false);
	}
	player.str += player.tempStr;
	player.tou += player.tempTou;
	player.spe += player.tempSpe;
	player.inte += player.tempInt;
	player.wis += player.tempWis;
	player.lib += player.tempLib;
	player.tempStr = 0;
	player.tempTou = 0;
	player.tempSpe = 0;
	player.tempInt = 0;
	player.tempWis = 0;
	player.tempLib = 0;
	statScreenRefresh();
	if (player.perkPoints > 0) doNext(perkBuyMenu);
	else doNext(playerMenu);
}

private function perkBuyMenu():void {
	clearOutput();
	var perkList:Array = buildPerkList();
	
	if (perkList.length == 0) {
		outputText("<b>You do not qualify for any perks at present.  </b>In case you qualify for any in the future, you will keep your " + num2Text(player.perkPoints) + " perk point");
		if(player.perkPoints > 1) outputText("s");
		outputText(".");
		doNext(playerMenu);
		return;
	}
	if (testingBlockExiting) {
		menu();
		addButton(0, "Next", perkSelect, perkList[rand(perkList.length)].perk);
	}
	else {
		outputText("Please select a perk from the drop-down list, then click 'Okay'.  You can press 'Skip' to save your perk point for later.\n\n");
		mainView.aCb.x = 210;
		mainView.aCb.y = 112;
		mainView.aCb.rowCount = 15;
		
		if (mainView.aCb.parent == null) {
			mainView.addChild(mainView.aCb);
			mainView.aCb.visible = true;
		}
		
		mainView.hideMenuButton( MainView.MENU_NEW_MAIN );
		menu();
		addButton(1, "Skip", perkSkip);
	}
}

private function perkSelect(selected:PerkClass):void {
	stage.focus = null;
	if (mainView.aCb.parent != null) {
		mainView.removeChild(mainView.aCb);
		applyPerk(selected);
	}
}

private function perkSkip():void {
	stage.focus = null;
	if (mainView.aCb.parent != null) {
		mainView.removeChild(mainView.aCb);
		playerMenu();
	}
}

private function changeHandler(event:Event):void {
 	//Store perk name for later addition
	clearOutput();
 	var selected:PerkClass = ComboBox(event.target).selectedItem.perk;
	mainView.aCb.move(210, 85);
	outputText("You have selected the following perk:\n\n");
	outputText("<b>" + selected.perkName + ":</b> " + selected.perkLongDesc + "\n\nIf you would like to select this perk, click <b>Okay</b>.  Otherwise, select a new perk, or press <b>Skip</b> to make a decision later.");
	menu();
	addButton(0, "Okay", perkSelect, selected);
	addButton(1, "Skip", perkSkip);
}

public function buildPerkList():Array {
	var perkList:Array = [];
	function _add(p:PerkClass):void{
		perkList.push({label: p.perkName,perk:p});
	}
	//------------
	// STRENGTH
	//------------
	if(player.str >= 10) {
		_add(new PerkClass(PerkLib.JobWarrior));
	}
	if(player.str >= 25) {
		_add(new PerkClass(PerkLib.StrongBack));
	}
	if(player.findPerk(PerkLib.StrongBack) >= 0 && player.str >= 50) {
		_add(new PerkClass(PerkLib.StrongBack2));
	}
	//Tier 1 Strength Perks
	if(player.level >= 6) {
		//Thunderous Strikes - +20% basic attack damage while str > 80.
		if(player.findPerk(PerkLib.JobWarrior) >= 0 && player.str >= 80) {
			_add(new PerkClass(PerkLib.ThunderousStrikes));
		}
		if(player.findPerk(PerkLib.JobWarrior) >= 0 && player.str >= 75)
			_add(new PerkClass(PerkLib.BrutalBlows));
		if(player.str >= 60) {
			_add(new PerkClass(PerkLib.JobBrawler));
			_add(new PerkClass(PerkLib.JobBarbarian));
		}
		if(player.findPerk(PerkLib.JobBrawler) >= 0 && player.str >= 60) {
			_add(new PerkClass(PerkLib.IronFistsI));
		}
		if(player.str >= 75 && player.findPerk(PerkLib.IronFistsI) >= 0 && player.level >= 8 && player.newGamePlusMod() >= 1) {
			_add(new PerkClass(PerkLib.IronFistsII));
		}
		if(player.str >= 90 && player.findPerk(PerkLib.IronFistsII) >= 0 && player.level >= 10 && player.newGamePlusMod() >= 2) {
			_add(new PerkClass(PerkLib.IronFistsIII));
		}
		if(player.str >= 50 && player.spe >= 50)
			_add(new PerkClass(PerkLib.Parry));
	}
	//Tier 2 Strength Perks
	if(player.level >= 12) {
		if(player.str >= 105 && player.findPerk(PerkLib.IronFistsIII) >= 0 && player.newGamePlusMod() >= 3) {
			_add(new PerkClass(PerkLib.IronFistsIV));
		}
		if(player.str >= 120 && player.findPerk(PerkLib.IronFistsIV) >= 0 && player.level >= 14 && player.newGamePlusMod() >= 4) {
			_add(new PerkClass(PerkLib.IronFistsV));
		}
		if(player.str >= 75) {
			_add(new PerkClass(PerkLib.Berzerker));
		}
		if(player.findPerk(PerkLib.JobWarrior) >= 0 && player.str >= 80) {	
			_add(new PerkClass(PerkLib.HoldWithBothHands));
		}
		if(player.str >= 80 && player.tou >= 60) {
			_add(new PerkClass(PerkLib.ShieldSlam));
		}
		//Weapon Mastery - Doubles weapon damage bonus of 'large' type weapons. (Minotaur Axe, M. Hammer, etc) and max str cap inc
		if(player.findPerk(PerkLib.JobBarbarian) >= 0 && player.str >= 100) {
			_add(new PerkClass(PerkLib.WeaponMastery));
		}
		if(player.findPerk(PerkLib.JobBarbarian) >= 0 && player.str >= 75 && player.spe >= 50) {
			_add(new PerkClass(PerkLib.DoubleAttackLarge));
		}
	}
	//Tier 3 Strength Perks
	if(player.level >= 18) {
		if(player.findPerk(PerkLib.Berzerker) >= 0 && player.findPerk(PerkLib.ImprovedSelfControl) >= 0 && player.str >= 75) {	
			_add(new PerkClass(PerkLib.ColdFury));
		}
		if(player.findPerk(PerkLib.WeaponMastery) >= 0 && player.str >= 100) {
			_add(new PerkClass(PerkLib.TitanGrip));
		}
		if(player.findPerk(PerkLib.JobBarbarian) >= 0 && player.str >= 75 && player.spe >= 50) {
			_add(new PerkClass(PerkLib.HiddenMomentum));
		}
	}
	//Tier 4 Strength Perks
	if (player.level >= 24) {
		if(player.findPerk(PerkLib.WeaponMastery) >= 0 && player.str >= 140) {
			_add(new PerkClass(PerkLib.WeaponGrandMastery));
		}
		if(player.findPerk(PerkLib.DualWield) >= 0 && player.findPerk(PerkLib.TitanGrip) >= 0 && player.str >= 125) {
			_add(new PerkClass(PerkLib.DualWieldLarge));
		}
		if(player.findPerk(PerkLib.DoubleAttackLarge) >= 0 && player.str >= 125 && player.spe >= 100) {
			_add(new PerkClass(PerkLib.TripleAttackLarge));
		}
	}
	//Tier 5 Strength Perks
//	if (player.level >= 30) {
//		if(player.findPerk(PerkLib.HiddenMomentum) >= 0 && player.str >= 150 && player.spe >= 100) {
//			_add(new PerkClass(PerkLib.HiddenDualMomentum));
//		}
//	}
	//Tier 6 Strength Perks
//	if (player.level >= 30) {
//		if (player.findPerk(PerkLib.HiddenMomentum) >= 0 && player.str >= 200 && player.spe >= 100) {
//			_add(new PerkClass(PerkLib.HiddenDualMomentum));	//herculanmight - perk dodający limit do str cap (i może do max tone też)
//		}		//a może właśnie perk dodający do max str cap tyle ile wynosi obecnie PC tone?
//	}
	//Tier 7 Strength Perks
	if (player.level >= 42) {
		if (player.maxPrestigeJobs() > 0 && player.findPerk(PerkLib.JobBarbarian) >= 0 && player.findPerk(PerkLib.JobGuardian) >= 0 && (player.findPerk(PerkLib.Berzerker) >= 0 || player.findPerk(PerkLib.Lustzerker) >= 0) && player.str >= 200) {
			_add(new PerkClass(PerkLib.PrestigeJobBerserker));
		}
	}
	//------------
	// TOUGHNESS
	//------------
	if(player.tou >= 10) {
		_add(new PerkClass(PerkLib.JobGuardian));
	}
	//slot 2 - toughness perk 1
	if(player.findPerk(PerkLib.RefinedBodyI) < 0 && player.findPerk(PerkLib.JobGuardian) >= 0 && player.tou >= 25) {
		_add(new PerkClass(PerkLib.RefinedBodyI));
	}
	if(player.findPerk(PerkLib.RefinedBodyI) >= 0 && player.tou >= 40 && player.level >= 2 && player.newGamePlusMod() >= 1) {
		_add(new PerkClass(PerkLib.RefinedBodyII));
	}
	if(player.findPerk(PerkLib.RefinedBodyII) >= 0 && player.tou >= 55 && player.level >= 4 && player.newGamePlusMod() >= 2) {
		_add(new PerkClass(PerkLib.RefinedBodyIII));
	}
	//slot 2 - regeneration perk
	if(player.findPerk(PerkLib.Regeneration) < 0 && player.tou >= 50) {
		_add(new PerkClass(PerkLib.Regeneration));
	}
	if(player.findPerk(PerkLib.Regeneration) >= 0 && player.tou >= 70 && player.level >= 2 && player.newGamePlusMod() >= 1) {
		_add(new PerkClass(PerkLib.Regeneration2));
	}
	if(player.findPerk(PerkLib.Regeneration2) >= 0 && player.tou >= 90 && player.level >= 4 && player.newGamePlusMod() >= 2) {
		_add(new PerkClass(PerkLib.Regeneration3));
	}
	if(player.tou >= 30 && player.str >= 20) {
		_add(new PerkClass(PerkLib.BasicEndurance));
	}
	if(player.tou >= 20) {
		_add(new PerkClass(PerkLib.UnlockBody));
	}
	//Tier 1 Toughness Perks
	if(player.level >= 6) {
		if(player.findPerk(PerkLib.RefinedBodyIII) >= 0 && player.tou >= 70 && player.newGamePlusMod() >= 3) {
			_add(new PerkClass(PerkLib.RefinedBodyIV));
		}
		if(player.findPerk(PerkLib.RefinedBodyIV) >= 0 && player.tou >= 85 && player.level >= 8 && player.newGamePlusMod() >= 4) {
			_add(new PerkClass(PerkLib.RefinedBodyV));
		}
		if(player.findPerk(PerkLib.Regeneration3) >= 0 && player.tou >= 110 && player.newGamePlusMod() >= 3) {
			_add(new PerkClass(PerkLib.Regeneration4));
		}
		if(player.findPerk(PerkLib.Regeneration4) >= 0 && player.tou >= 130 && player.level >= 8 && player.newGamePlusMod() >= 4) {
			_add(new PerkClass(PerkLib.Regeneration5));
		}
		if(player.findPerk(PerkLib.RefinedBodyI) >= 0 && player.tou >= 60) {
			_add(new PerkClass(PerkLib.TankI));
		}
		if(player.findPerk(PerkLib.TankI) >= 0 && player.tou >= 80 && player.level >= 8 && player.newGamePlusMod() >= 1) {
			_add(new PerkClass(PerkLib.TankII));
		}
		if(player.findPerk(PerkLib.TankII) >= 0 && player.tou >= 100 && player.level >= 10 && player.newGamePlusMod() >= 2) {
			_add(new PerkClass(PerkLib.TankIII));
		}
		if(player.findPerk(PerkLib.JobGuardian) >= 0 && player.tou >= 50) {
			_add(new PerkClass(PerkLib.JobKnight));
		}
		if(player.findPerk(PerkLib.JobKnight) >= 0 && player.tou >= 50) {
			_add(new PerkClass(PerkLib.ShieldMastery));
		}
		if(player.tou >= 60 && player.str >= 40 && player.findPerk(PerkLib.BasicEndurance) >= 0) {
			_add(new PerkClass(PerkLib.HalfStepToImprovedEndurance));
		}
	}
	//Tier 2 Toughness Perks
	if(player.level >= 12) {
		if(player.findPerk(PerkLib.JobGuardian) >= 0 && player.tou >= 75) {
			_add(new PerkClass(PerkLib.JobDefender));
		}
		if(player.findPerk(PerkLib.JobDefender) >= 0 && player.tou >= 75) {
			_add(new PerkClass(PerkLib.ImmovableObject));
			_add(new PerkClass(PerkLib.Resolute));
			_add(new PerkClass(PerkLib.HeavyArmorProficiency));
		}
		if(player.tou >= 60) {
			_add(new PerkClass(PerkLib.IronMan));
		}
		if(player.findPerk(PerkLib.TankIII) >= 0 && player.tou >= 120 && player.newGamePlusMod() >= 3) {
			_add(new PerkClass(PerkLib.TankIV));
		}
		if(player.findPerk(PerkLib.TankIV) >= 0 && player.tou >= 140 && player.level >= 14 && player.newGamePlusMod() >= 4) {
			_add(new PerkClass(PerkLib.TankV));
		}
		if(player.tou >= 90 && player.str >= 60 && player.findPerk(PerkLib.HalfStepToImprovedEndurance) >= 0) {
			_add(new PerkClass(PerkLib.ImprovedEndurance));
		}
	}
	//Tier 3 Toughness Perks
	if(player.level >= 18) {
		if (player.tou >= 100 && player.findPerk(PerkLib.HeavyArmorProficiency) >= 0) {
			_add(new PerkClass(PerkLib.Juggernaut));
		}
	//	if (player.tou >= 80 && player.findPerk(PerkLib.HeavyArmorProficiency) >= 0) {
	//		_add(new PerkClass(PerkLib.AyoArmorProficiency));
	//	}
		if(player.tou >= 120 && player.str >= 80 && player.findPerk(PerkLib.ImprovedEndurance) >= 0) {
			_add(new PerkClass(PerkLib.HalfStepToAdvancedEndurance));
		}
	}
	//Tier 4 Toughness Perks
	if (player.level >= 24) {
		if(player.tou >= 150 && player.str >= 100 && player.findPerk(PerkLib.HalfStepToAdvancedEndurance) >= 0) {
			_add(new PerkClass(PerkLib.AdvancedEndurance));
		}
//perk związany z ayotech armors na pewno tu umieścić coś podobnego do juggernaut pewnie a moze właśnie wersja juggernaut dla ayo tech armors może?		
	}
	//Tier 5 Toughness Perks
	if (player.level >= 30) {
		if(player.tou >= 180 && player.str >= 120 && player.findPerk(PerkLib.AdvancedEndurance) >= 0) {
			_add(new PerkClass(PerkLib.HalfStepToSuperiorEndurance));
		}
	}
	//Tier 6 Toughness Perks
	if (player.level >= 36) {
		if(player.tou >= 210 && player.str >= 140 && player.findPerk(PerkLib.HalfStepToSuperiorEndurance) >= 0) {
			_add(new PerkClass(PerkLib.SuperiorEndurance));
		}
	}
	//Tier 7 Toughness Perks
	if(player.level >= 42) {
		if(player.tou >= 240 && player.str >= 160 && player.findPerk(PerkLib.SuperiorEndurance) >= 0) {
			_add(new PerkClass(PerkLib.HalfStepToPeerlessEndurance));
		}
	}
	//Tier 8 Toughness Perks
	if(player.level >= 48) {
		if(player.tou >= 270 && player.str >= 180 && player.findPerk(PerkLib.HalfStepToPeerlessEndurance) >= 0) {
			_add(new PerkClass(PerkLib.PeerlessEndurance));
		}
	}
	//------------
	// SPEED
	//------------
	if(player.spe >= 10) {
		_add(new PerkClass(PerkLib.JobRanger));
	}
	//slot 3 - run perk
	if(player.spe >= 25) {
		_add(new PerkClass(PerkLib.Runner));
	}
	//slot 3 - speed perk
	if(player.findPerk(PerkLib.JobRanger) >= 0 && player.spe >= 25) {
		_add(new PerkClass(PerkLib.Evade));
	}
	if(player.findPerk(PerkLib.JobRanger) >= 0 && player.spe >= 25) {
		_add(new PerkClass(PerkLib.ArchersStaminaI));
 	}
	if(player.findPerk(PerkLib.ArchersStaminaI) >= 0 && player.spe >= 45 && player.level >= 2 && player.newGamePlusMod() >= 1) {
		_add(new PerkClass(PerkLib.ArchersStaminaII));
	}
	if(player.findPerk(PerkLib.ArchersStaminaII) >= 0 && player.spe >= 65 && player.level >= 4 && player.newGamePlusMod() >= 2) {
		_add(new PerkClass(PerkLib.ArchersStaminaIII));
	}
	if(player.findPerk(PerkLib.JobRanger) >= 0 && player.spe >= 30) {
		_add(new PerkClass(PerkLib.CarefulButRecklessAimAndShooting));
 	}
	if(player.findPerk(PerkLib.JobRanger) >= 0) {
		_add(new PerkClass(PerkLib.Sharpshooter));
 	}
	if(player.findPerk(PerkLib.ArchersStaminaI) >= 0 && player.spe >= 30) {
		_add(new PerkClass(PerkLib.NaturesSpringI));
 	}
	if(player.findPerk(PerkLib.NaturesSpringI) >= 0 && player.spe >= 50 && player.level >= 2 && player.newGamePlusMod() >= 1) {
		_add(new PerkClass(PerkLib.NaturesSpringII));
 	}
	if(player.findPerk(PerkLib.NaturesSpringII) >= 0 && player.spe >= 70 && player.level >= 4 && player.newGamePlusMod() >= 2) {
		_add(new PerkClass(PerkLib.NaturesSpringIII));
 	}
	//Tier 1 Speed Perks
	if(player.level >= 6) {
		//Speedy Recovery - Regain Fatigue 50% faster speed.
		if(player.findPerk(PerkLib.Evade) >= 0 && player.spe >= 60) {
			_add(new PerkClass(PerkLib.SpeedyRecovery));
		}
		//Agility - A small portion of your speed is applied to your defense rating when wearing light armors.
		if(player.spe > 75 && player.findPerk(PerkLib.Runner) >= 0) {
			_add(new PerkClass(PerkLib.Agility));
		}
		//slot 3 - Double Attack perk
		if(player.findPerk(PerkLib.JobDervish) >= 0 && player.spe >= 50) {
			_add(new PerkClass(PerkLib.DoubleAttack));
		}
		if(player.findPerk(PerkLib.Evade) >= 0 && player.findPerk(PerkLib.Runner) >= 0 && player.spe >= 50) {
			_add(new PerkClass(PerkLib.DoubleStrike));
		}
		if(player.spe >= 75 && player.findPerk(PerkLib.Evade) >= 0 && player.findPerk(PerkLib.Agility) >= 0) {
			_add(new PerkClass(PerkLib.Unhindered));
		}
		if(player.spe >= 60) {
			_add(new PerkClass(PerkLib.LightningStrikes));
			_add(new PerkClass(PerkLib.Naturaljouster));
		}
		if(player.spe >= 60 && player.findPerk(PerkLib.JobRanger) >= 0 && player.findPerk(PerkLib.Tactician) >= 0) {
			_add(new PerkClass(PerkLib.VitalShot));
		}
		if(player.spe >= 60 && player.findPerk(PerkLib.JobRanger) >= 0 && player.findPerk(PerkLib.Precision) >= 0) {
			_add(new PerkClass(PerkLib.DeadlyAim));
		}
		if(player.findPerk(PerkLib.ArchersStaminaIII) >= 0 && player.spe >= 85 && player.newGamePlusMod() >= 3) {
			_add(new PerkClass(PerkLib.ArchersStaminaIV));
		}
		if(player.findPerk(PerkLib.ArchersStaminaIV) >= 0 && player.spe >= 105 && player.level >= 8 && player.newGamePlusMod() >= 4) {
			_add(new PerkClass(PerkLib.ArchersStaminaV));
		}
		if (player.findPerk(PerkLib.JobRanger) > 0 && player.spe >= 40) {
			_add(new PerkClass(PerkLib.JobDervish));
		}
		if(player.findPerk(PerkLib.NaturesSpringIII) >= 0 && player.spe >= 90 && player.newGamePlusMod() >= 3) {
			_add(new PerkClass(PerkLib.NaturesSpringIV));
		}
		if(player.findPerk(PerkLib.NaturesSpringIV) >= 0 && player.spe >= 110 && player.level >= 8 && player.newGamePlusMod() >= 4) {
			_add(new PerkClass(PerkLib.NaturesSpringV));
		}
		/*if(player.spe >= 60 && player.str >= 60) {
			_add(new PerkClass(PerkLib.Brawler));
		}*/ //Would it be fitting to have Urta teach you?
	}
	//Tier 2 Speed Perks
	if(player.level >= 12) {
		if(player.findPerk(PerkLib.JobRanger) >= 0 && player.spe >= 75) {
			_add(new PerkClass(PerkLib.LungingAttacks));
		}
		if(player.findPerk(PerkLib.JobRanger) >= 0 && player.spe >= 80 && player.str >= 60) {
			_add(new PerkClass(PerkLib.Blademaster));
		}
		if(player.findPerk(PerkLib.DoubleAttack) >= 0 && player.spe >= 75) {
			_add(new PerkClass(PerkLib.TripleAttack));
		}
		if (player.spe >= 80 && player.lib >= 50 && player.findPerk(PerkLib.Unhindered) >= 0) {
			_add(new PerkClass(PerkLib.SluttySimplicity));
		}
		if (player.spe >= 80 && player.lib >= 50 && player.findPerk(PerkLib.Unhindered) >= 0 && player.findPerk(PerkLib.JobEromancer) >= 0) {
			_add(new PerkClass(PerkLib.NakedTruth));
		}
		if(player.findPerk(PerkLib.DoubleStrike) >= 0 && player.spe >= 75) {
			_add(new PerkClass(PerkLib.TripleStrike));
		}
		if(player.findPerk(PerkLib.JobRanger) >= 0 && player.findPerk(PerkLib.ArchersStaminaI) >= 0 && player.spe >= 80) {
			_add(new PerkClass(PerkLib.JobHunter));
		}
		if(player.findPerk(PerkLib.CarefulButRecklessAimAndShooting) >= 0 && player.spe >= 50) {
			_add(new PerkClass(PerkLib.ColdAim));
		}
		if(player.findPerk(PerkLib.JobDervish) >= 0 && player.spe >= 60) {
			_add(new PerkClass(PerkLib.DancersVitalityI));
		}
		if(player.findPerk(PerkLib.DancersVitalityI) >= 0 && player.spe >= 75 && player.level >= 14 && player.newGamePlusMod() >= 1) {
			_add(new PerkClass(PerkLib.DancersVitalityII));
		}
		if(player.findPerk(PerkLib.DancersVitalityII) >= 0 && player.spe >= 90 && player.level >= 16 && player.newGamePlusMod() >= 2) {
			_add(new PerkClass(PerkLib.DancersVitalityIII));
		}
		if(player.findPerk(PerkLib.JobHunter) >= 0) {
			_add(new PerkClass(PerkLib.DeadlyThrow));
		}
		//if (player.findPerk(PerkLib.JobMonk) >= 0 && player.spe >= 50) {
			//_add(new PerkClass(PerkLib.	//perk dajacy 2 ataki kiedy uzywa sie tylko fists - 
		//}		// - cos jak double attack ale bez limitu sily ^^ (ale dodac nowy status aby byl niezalezny od double strike)
	}
	//Tier 3 Speed Perks
	if (player.level >= 18) {
		if(player.findPerk(PerkLib.JobHunter) >= 0 && player.findPerk(PerkLib.TripleStrike) >= 0 && player.spe >= 100) {
			_add(new PerkClass(PerkLib.Manyshot));
		}
		if(player.findPerk(PerkLib.TripleAttack) >= 0 && player.spe >= 100) {
			_add(new PerkClass(PerkLib.QuadrupleAttack));
		}
		if(player.findPerk(PerkLib.JobHunter) >= 0 && (player.tailType == TAIL_TYPE_BEE_ABDOMEN || player.tailType == TAIL_TYPE_SCORPION || player.tailType == TAIL_TYPE_MANTICORE_PUSSYTAIL || player.faceType == FACE_SNAKE_FANGS || player.faceType == FACE_SPIDER_FANGS)) {
			_add(new PerkClass(PerkLib.EnvenomedBolt));
		}
		if(player.findPerk(PerkLib.DancersVitalityIII) >= 0 && player.spe >= 105 && player.newGamePlusMod() >= 3) {
			_add(new PerkClass(PerkLib.DancersVitalityIV));
		}
		if(player.findPerk(PerkLib.DancersVitalityIV) >= 0 && player.spe >= 120 && player.level >= 20 && player.newGamePlusMod() >= 4) {
			_add(new PerkClass(PerkLib.DancersVitalityV));
		}
	}
	//Tier 4 Speed Perks
	if (player.level >= 24) {
		if (player.findPerk(PerkLib.Manyshot) >= 0 && player.spe >= 125) {
			_add(new PerkClass(PerkLib.WildQuiver));
		}
		if (player.findPerk(PerkLib.QuadrupleAttack) >= 0 && player.spe >= 125) {
			_add(new PerkClass(PerkLib.PentaAttack));
		}
	}
	//Tier 5 Speed Perks
	if (player.level >= 30) {
		if (player.findPerk(PerkLib.PentaAttack) >= 0 && player.spe >= 150) {
			_add(new PerkClass(PerkLib.HexaAttack));
		}
		if (player.findPerk(PerkLib.WildQuiver) >= 0 && player.spe >= 150) {
			_add(new PerkClass(PerkLib.Multishot));
		}
	}
	//Tier 6 Speed Perks
//	if (player.level >= 36) {
//		if(player.findPerk(PerkLib.) >= 0 && player.spe >= 175) {
//			_add(new PerkClass(PerkLib.));
//		}
//	}
	//Tier 7 Speed Perks
	if (player.level >= 42) {
		if (player.maxPrestigeJobs() > 0 && player.findPerk(PerkLib.JobHunter) >= 0 && player.spe >= 200) {
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) {
				_add(new PerkClass(PerkLib.PrestigeJobSoulArcher));
			}
			if (player.findPerk(PerkLib.JobSorcerer) >= 0 && player.inte >= 150) {
				_add(new PerkClass(PerkLib.PrestigeJobArcaneArcher));
			}
		}
		if(player.findPerk(PerkLib.PrestigeJobArcaneArcher) >= 0 && (player.findStatusAffect(StatusAffects.KnowsWhitefire) >= 0 || player.findStatusAffect(StatusAffects.KnowsIceSpike) >= 0)) {
			_add(new PerkClass(PerkLib.ElementalArrows));
		}
	}
	//Tier 8 Speed Perks
	if (player.level >= 48) {
		if(player.findPerk(PerkLib.PrestigeJobArcaneArcher) >= 0 && player.findStatusAffect(StatusAffects.KnowsArouse) >= 0) {
			_add(new PerkClass(PerkLib.Cupid));
		}
	}
	//------------
	// INTELLIGENCE
	//------------
	if(player.inte >= 10) {
		_add(new PerkClass(PerkLib.JobSorcerer));
	}
	//Slot 4 - precision - -10 enemy toughness for damage calc
	if(player.inte >= 25) {
			_add(new PerkClass(PerkLib.Precision));
	}
	//Spellpower - boosts spell power
	if(player.findPerk(PerkLib.JobSorcerer) >= 0 && player.inte >= 50) {
			_add(new PerkClass(PerkLib.Spellpower));
	}
	if(player.inte >= 20) {
		_add(new PerkClass(PerkLib.UnlockMind));
	}
	if(player.findPerk(PerkLib.JobSorcerer) >= 0 && player.inte >= 25) {
		_add(new PerkClass(PerkLib.ManaAffinityI));
 	}
	if(player.findPerk(PerkLib.ManaAffinityI) >= 0 && player.inte >= 45 && player.level >= 2 && player.newGamePlusMod() >= 1) {
			_add(new PerkClass(PerkLib.ManaAffinityII));
	}
	if(player.findPerk(PerkLib.ManaAffinityII) >= 0 && player.inte >= 65 && player.level >= 4 && player.newGamePlusMod() >= 2) {
			_add(new PerkClass(PerkLib.ManaAffinityIII));
	}
	//Tier 1 Intelligence Perks
	if (player.level >= 6) {
		if(player.findPerk(PerkLib.Spellpower) >= 0 && player.inte >= 50) {
			_add(new PerkClass(PerkLib.Mage));
		}
		if(player.inte >= 50)
			_add(new PerkClass(PerkLib.Tactician));
		if(spellCount() > 0 && player.findPerk(PerkLib.Spellpower) >= 0 && player.findPerk(PerkLib.Mage) >= 0 && player.inte >= 60) {
			_add(new PerkClass(PerkLib.Channeling));
		}
		if(player.inte >= 60) {
			_add(new PerkClass(PerkLib.Medicine));
		}
		if(player.findPerk(PerkLib.Channeling) >= 0 && player.inte >= 60) {
			_add(new PerkClass(PerkLib.StaffChanneling));
		}
		if(player.findPerk(PerkLib.ManaAffinityIII) >= 0 && player.inte >= 85 && player.newGamePlusMod() >= 3) {
			_add(new PerkClass(PerkLib.ManaAffinityIV));
		}
		if(player.findPerk(PerkLib.ManaAffinityIV) >= 0 && player.inte >= 105 && player.level >= 8 && player.newGamePlusMod() >= 4) {
			_add(new PerkClass(PerkLib.ManaAffinityV));
		}
		if(player.findPerk(PerkLib.ManaAffinityI) >= 0 && player.inte >= 50) {
			_add(new PerkClass(PerkLib.MindOverBodyI));
		}
		if(player.findPerk(PerkLib.MindOverBodyI) >= 0 && player.inte >= 70 && player.level >= 8 && player.newGamePlusMod() >= 1) {
			_add(new PerkClass(PerkLib.MindOverBodyII));
		}
		if(player.findPerk(PerkLib.MindOverBodyII) >= 0 && player.inte >= 90 && player.level >= 10 && player.newGamePlusMod() >= 2) {
			_add(new PerkClass(PerkLib.MindOverBodyIII));
		}
	}
	//Tier 2 Intelligence perks
	if(player.level >= 12) {
		if(player.findPerk(PerkLib.Mage) >= 0 && player.inte >= 75) {
			_add(new PerkClass(PerkLib.Archmage));
			_add(new PerkClass(PerkLib.JobEnchanter));
			_add(new PerkClass(PerkLib.FocusedMind));
		}
		if(player.inte >= 75) {
				if (player.findPerk(PerkLib.Archmage) >= 0 && player.findPerk(PerkLib.Channeling) >= 0 &&
				(player.findStatusAffect(StatusAffects.KnowsWhitefire) >= 0
				|| player.findPerk(PerkLib.DragonFireBreath) >= 0
				|| player.findPerk(PerkLib.FireLord) >= 0 
				|| player.findPerk(PerkLib.Hellfire) >= 0 
				|| player.findPerk(PerkLib.EnlightenedNinetails) >= 0
				|| player.findPerk(PerkLib.CorruptedNinetails) >= 0))
					_add(new PerkClass(PerkLib.RagingInferno));
				
				if (player.findPerk(PerkLib.Archmage) >= 0 && player.findPerk(PerkLib.Channeling) >= 0 &&
				(player.findStatusAffect(StatusAffects.KnowsIceSpike) >= 0
				|| player.findStatusAffect(StatusAffects.KnowsIceRain) >= 0
				|| player.findPerk(PerkLib.DragonIceBreath) >= 0))
					_add(new PerkClass(PerkLib.GlacialStorm));
		}
		// Spell-boosting perks
		// Battlemage: auto-use Might
		if(player.findPerk(PerkLib.JobEnchanter) >= 0 && player.findPerk(PerkLib.Channeling) >= 0 && player.findStatusAffect(StatusAffects.KnowsMight) >= 0 && player.inte >= 80) {
				_add(new PerkClass(PerkLib.Battlemage));
		}
		// Spellsword: auto-use Charge Weapon
		if(player.findPerk(PerkLib.JobEnchanter) >= 0 && player.findPerk(PerkLib.Channeling) >= 0 && player.findStatusAffect(StatusAffects.KnowsCharge) >= 0 && player.inte >= 80) {
				_add(new PerkClass(PerkLib.Spellsword));
		}
		if(player.findPerk(PerkLib.MindOverBodyIII) >= 0 && player.inte >= 110 && player.newGamePlusMod() >= 3) {
			_add(new PerkClass(PerkLib.MindOverBodyIV));
		}
		if(player.findPerk(PerkLib.MindOverBodyIV) >= 0 && player.inte >= 130 && player.level >= 14 && player.newGamePlusMod() >= 4) {
			_add(new PerkClass(PerkLib.MindOverBodyV));
		}
	}
	//Tier 3 Intelligence perks
	if(player.level >= 18) {
		if(player.findPerk(PerkLib.Archmage) >= 0 && player.inte >= 100) {
			_add(new PerkClass(PerkLib.GrandArchmage));
		}
		
		// Battleflash: auto-use Blink
		if(player.findPerk(PerkLib.Battlemage) >= 0 && player.findStatusAffect(StatusAffects.KnowsBlink) >= 0 && player.inte >= 90) {
				_add(new PerkClass(PerkLib.Battleflash));
		}
		// Spellarmor: auto-use Charge Armor
		if(player.findPerk(PerkLib.Spellsword) >= 0 && player.findStatusAffect(StatusAffects.KnowsChargeA) >= 0 && player.inte >= 90) {
				_add(new PerkClass(PerkLib.Spellarmor));
		}
	}
	//Tier 4 Intelligence perks
	if(player.level >= 24) {
		if(player.findPerk(PerkLib.GrandArchmage) >= 0 && player.findPerk(PerkLib.FocusedMind) >= 0 && player.inte >= 125) {
			_add(new PerkClass(PerkLib.GreyMage));
		}
	}
	//Tier 5 Intelligence perks
	if (player.level >= 30) {
		if (player.findPerk(PerkLib.GreyMage) >= 0 && player.inte >= 150) {
			_add(new PerkClass(PerkLib.GreyArchmage));
		}
	}
	//Tier 6 Intelligence perks
	
	//Tier 7 Intelligence perks
	if (player.level >= 42) {
		if (player.maxPrestigeJobs() > 0 && player.findPerk(PerkLib.GreyArchmage) >= 0 && player.findPerk(PerkLib.SoulOverlord) >= 0 && player.inte >= 200) {
			_add(new PerkClass(PerkLib.PrestigeJobSeer));
		}
	}
	//------------
	// WISDOM
	//------------
	//Tier 1 Wisdom perks
	//Tier 2 Wisdom perks
	if (player.level >= 12) {
		if (player.wis >= 60) {
			_add(new PerkClass(PerkLib.JobMonk));
		}
		if (player.findPerk(PerkLib.JobMonk) >= 0 && player.wis >= 75 && player.str >= 50) {
			_add(new PerkClass(PerkLib.Combo));	//DoubleAttackLarge
		}
	}
	//Tier 3 Wisdom perks
	
	//Tier 4 Wisdom perks
	if (player.level >= 24) {
		if (player.findPerk(PerkLib.Combo) >= 0 && player.wis >= 125 && player.str >= 100) {
			_add(new PerkClass(PerkLib.ComboMaster));	//TripleAttackLarge
		}
	}
	//------------
	// LIBIDO
	//------------
	//slot 5 - libido perks

	//Slot 5 - Fertile+ increases cum production and fertility (+15%)
	if(player.lib >= 10) {
		_add(new PerkClass(PerkLib.JobSeducer));
	}
	if(player.lib >= 20) {
		_add(new PerkClass(PerkLib.UnlockId));
	}
	if(player.lib >= 25) {
			_add(new PerkClass(PerkLib.FertilityPlus,15,1.75,0,0));
	}
	if(player.lib >= 20 && player.inte >= 30) {
		_add(new PerkClass(PerkLib.BasicSelfControl));
	}
	//Slot 5 - minimum libido
	if(player.minLust() >= 20) {
			_add(new PerkClass(PerkLib.ColdBlooded,20,0,0,0));
	}
	if(player.lib >= 50) {
			_add(new PerkClass(PerkLib.HotBlooded,20,0,0,0));
	}
	//Tier 1 Libido Perks
	if(player.level >= 6) {
		//Slot 5 - minimum libido
		//Slot 5 - Fertility- decreases cum production and fertility.
		if (player.lib < 25) {
				_add(new PerkClass(PerkLib.FertilityMinus, 15, 0.7, 0, 0));
		}
		if(player.lib >= 60) {
			_add(new PerkClass(PerkLib.WellAdjusted));
		}
		//Slot 5 - minimum libido
		if(player.lib >= 60 && player.cor >= 50) {
			_add(new PerkClass(PerkLib.Masochist));
		}
		if (player.findPerk(PerkLib.JobSeducer) > 0 && player.lib >= 30 && player.inte >= 60) {
			_add(new PerkClass(PerkLib.JobEromancer));
		}
		if (player.findPerk(PerkLib.JobEromancer) > 0) {
			_add(new PerkClass(PerkLib.ArcaneLash));
		}
		if(player.lib >= 40 && player.inte >= 60 && player.findPerk(PerkLib.BasicSelfControl) >= 0) {
			_add(new PerkClass(PerkLib.HalfStepToImprovedSelfControl));
		}
		if(player.findPerk(PerkLib.JobSeducer) >= 0 && player.lib >= 50) {
			_add(new PerkClass(PerkLib.InhumanDesireI));
		}
		if(player.findPerk(PerkLib.InhumanDesireI) >= 0 && player.lib >= 70 && player.level >= 8 && player.newGamePlusMod() >= 1) {
			_add(new PerkClass(PerkLib.InhumanDesireII));
		}
		if(player.findPerk(PerkLib.InhumanDesireII) >= 0 && player.lib >= 90 && player.level >= 10 && player.newGamePlusMod() >= 2) {
			_add(new PerkClass(PerkLib.InhumanDesireIII));
		}
	}
	//Tier 2 Libido Perks
	if(player.level >= 12) {
		if(player.findPerk(PerkLib.InhumanDesireIII) >= 0 && player.lib >= 110 && player.newGamePlusMod() >= 3) {
			_add(new PerkClass(PerkLib.InhumanDesireIV));
		}
		if(player.findPerk(PerkLib.InhumanDesireIV) >= 0 && player.lib >= 130 && player.level >= 14 && player.newGamePlusMod() >= 4) {
			_add(new PerkClass(PerkLib.InhumanDesireV));
		}
		if(player.findPerk(PerkLib.InhumanDesireI) >= 0 && player.lib >= 75) {
			_add(new PerkClass(PerkLib.DemonicDesireI));
		}
		if(player.findPerk(PerkLib.DemonicDesireI) >= 0 && player.lib >= 95 && player.level >= 14 && player.newGamePlusMod() >= 1) {
			_add(new PerkClass(PerkLib.DemonicDesireII));
		}
		if(player.findPerk(PerkLib.DemonicDesireII) >= 0 && player.lib >= 115 && player.level >= 16 && player.newGamePlusMod() >= 2) {
			_add(new PerkClass(PerkLib.DemonicDesireIII));
		}
		if(player.lib >= 60 && player.inte >= 90 && player.findPerk(PerkLib.HalfStepToImprovedSelfControl) >= 0) {
			_add(new PerkClass(PerkLib.ImprovedSelfControl));
		}
		if(player.findPerk(PerkLib.JobEromancer) >= 0 && player.findStatusAffect(StatusAffects.KnowsArouse) >= 0 && player.lib >= 50) {
			_add(new PerkClass(PerkLib.Transference));
		}
	}
	//Tier 3 Libido Perks
	if(player.level >= 18) {
		if(player.findPerk(PerkLib.DemonicDesireIII) >= 0 && player.lib >= 135 && player.newGamePlusMod() >= 3) {
			_add(new PerkClass(PerkLib.DemonicDesireIV));
		}
		if(player.findPerk(PerkLib.DemonicDesireIV) >= 0 && player.lib >= 155 && player.level >= 20 && player.newGamePlusMod() >= 4) {
			_add(new PerkClass(PerkLib.DemonicDesireV));
		}
		if(player.lib >= 80 && player.inte >= 120 && player.findPerk(PerkLib.ImprovedSelfControl) >= 0) {
			_add(new PerkClass(PerkLib.HalfStepToAdvancedSelfControl));
		}
		if(player.findPerk(PerkLib.Lustzerker) >= 0 && player.findPerk(PerkLib.ImprovedSelfControl) >= 0 && player.lib >= 75) {	
			_add(new PerkClass(PerkLib.ColdLust));
		}
	}
	//Tier 4 Libido Perks
	if(player.level >= 24) {
		if(player.lib >= 100 && player.inte >= 150 && player.findPerk(PerkLib.HalfStepToAdvancedSelfControl) >= 0) {
			_add(new PerkClass(PerkLib.AdvancedSelfControl));
		}
	}
	//Tier 5 Libido Perks
	if(player.level >= 30) {
		if(player.lib >= 120 && player.inte >= 180 && player.findPerk(PerkLib.AdvancedSelfControl) >= 0) {
			_add(new PerkClass(PerkLib.HalfStepToSuperiorSelfControl));
		}
	}
	//Tier 6 Libido Perks
	if(player.level >= 36) {
		if(player.lib >= 140 && player.inte >= 210 && player.findPerk(PerkLib.HalfStepToSuperiorSelfControl) >= 0) {
			_add(new PerkClass(PerkLib.SuperiorSelfControl));
		}
	}
	//Tier 7 Libido Perks
	if(player.level >= 42) {
		if(player.lib >= 160 && player.inte >= 240 && player.findPerk(PerkLib.SuperiorSelfControl) >= 0) {
			_add(new PerkClass(PerkLib.HalfStepToPeerlessSelfControl));
		}
	}
	//Tier 8 Libido Perks
	if(player.level >= 48) {
		if(player.lib >= 180 && player.inte >= 270 && player.findPerk(PerkLib.HalfStepToPeerlessSelfControl) >= 0) {
			_add(new PerkClass(PerkLib.PeerlessSelfControl));
		}
	}
	//------------
	// SENSITIVITY
	//------------
	//Nope.avi
	//------------
	// CORRUPTION
	//------------
	//Slot 7 - Corrupted Libido - lust raises 10% slower.
	if(player.cor >= 25) {
			_add(new PerkClass(PerkLib.CorruptedLibido,20,0,0,0));
	}
	//Slot 7 - Seduction (Must have seduced Jojo)
	if(player.cor >= 50) {
			_add(new PerkClass(PerkLib.Seduction));
	}
	//Slot 7 - Nymphomania
	if(player.cor >= 75 && player.findPerk(PerkLib.CorruptedLibido) >= 0) {
			_add(new PerkClass(PerkLib.Nymphomania));
	}
	//Slot 7 - UNFINISHED :3
	if(player.cor >= 50 && player.findPerk(PerkLib.CorruptedLibido) >= 0 && minLust() >= 20) {
			_add(new PerkClass(PerkLib.Acclimation));
	}
	//Tier 1 Corruption Perks - acclimation over-rides
	if(player.level >= 6)
	{
		if(player.cor >= 60 && player.findPerk(PerkLib.CorruptedLibido) >= 0) {
			_add(new PerkClass(PerkLib.Sadist));
		}
		if(player.cor >= 70 && player.findPerk(PerkLib.CorruptedLibido) >= 0) {
			_add(new PerkClass(PerkLib.ArousingAura));
		}
	}
	//Tier 2
	/*if (player.level >= 12)
	{
		if (player.findPerk(PerkLib.JobSeducer) >= 0 && player.cor >= 50) {
			_add(new PerkClass(PerkLib				job:corrupter czy jakoś tak - daje efekt iż wszyscy reaguja jakby pc miał 10/15/20/25 mniej corruption, nie wiem czy jeszcze jakiś efekt dodać
		}
	}*/
	//------------
	// SOULFORCE
	//------------
	//Tier 0
	if(player.findPerk(PerkLib.JobSoulCultivator) < 0) {
		_add(new PerkClass(PerkLib.JobSoulCultivator));
	}
	if(player.maxSoulforce() >= 100 && player.findPerk(PerkLib.JobSoulCultivator) >= 0) {
		_add(new PerkClass(PerkLib.Dantain));
	}
	if(player.findPerk(PerkLib.JobSoulCultivator) >= 0) {
		_add(new PerkClass(PerkLib.BodyCultivator));
		_add(new PerkClass(PerkLib.DaoistCultivator));
	}
//	if(player.findPerk(PerkLib.JobSoulCultivator) >= 0) {
//		_add(new PerkClass(PerkLib.HeartCultivator));		//psionic/min powers cultivation/psion class from D&D?
//	}
//	if(player.findPerk(PerkLib.JobSoulCultivator) >= 0) {
//		_add(new PerkClass(PerkLib.));		//allowing to use soulforce options more times per day - 1/2/3 time more?
//	}
//	if(player.findPerk(PerkLib.JobSoulCultivator) >= 0) {
//		_add(new PerkClass(PerkLib.));		//allowing to use soul artifacts - new slot?
//	}
	//Tier 1
	if(player.level >= 6) {
		if(player.findPerk(PerkLib.JobSoulCultivator) >= 0) {
			if (player.wis >= 20) {
				_add(new PerkClass(PerkLib.SoulApprentice));
			}
			if (player.wis >= 50) {
				_add(new PerkClass(PerkLib.InsightfulResourcesI));
			}
		}
		if(player.findPerk(PerkLib.BodyCultivator) >= 0) {
			_add(new PerkClass(PerkLib.FleshBodyApprenticeStage));
		}
		if(player.findPerk(PerkLib.DaoistCultivator) >= 0) {
			_add(new PerkClass(PerkLib.DaoistApprenticeStage));
		}
		if(player.findPerk(PerkLib.InsightfulResourcesI) >= 0 && player.wis >= 70 && player.level >= 8 && player.newGamePlusMod() >= 1) {
			_add(new PerkClass(PerkLib.InsightfulResourcesII));
		}
		if(player.findPerk(PerkLib.InsightfulResourcesII) >= 0 && player.wis >= 90 && player.level >= 10 && player.newGamePlusMod() >= 2) {
			_add(new PerkClass(PerkLib.InsightfulResourcesIII));
		}
	}
	//Tier 2
	if(player.level >= 12) {
		if(player.findPerk(PerkLib.SoulApprentice) >= 0 && player.wis >= 40) {
			_add(new PerkClass(PerkLib.SoulPersonage));
		}
		if(player.findPerk(PerkLib.InsightfulResourcesIII) >= 0 && player.wis >= 110 && player.newGamePlusMod() >= 3) {
			_add(new PerkClass(PerkLib.InsightfulResourcesIV));
		}
		if(player.findPerk(PerkLib.InsightfulResourcesIV) >= 0 && player.wis >= 130 && player.level >= 20 && player.newGamePlusMod() >= 4) {
			_add(new PerkClass(PerkLib.InsightfulResourcesV));
		}
	}
	//Tier 3
	if(player.level >= 18) {
		if(player.findPerk(PerkLib.SoulPersonage) >= 0 && player.wis >= 60)
			_add(new PerkClass(PerkLib.SoulWarrior));
	}
	//Tier 4
	if(player.level >= 24) {
		if(player.findPerk(PerkLib.SoulWarrior) >= 0 && player.wis >= 80) {		// && player.findPerk(PerkLib.HclassHeavenTribulationSurvivor) >= 0
			_add(new PerkClass(PerkLib.SoulSprite));
		}
		if(player.findPerk(PerkLib.FleshBodyApprenticeStage) >= 0) {
			_add(new PerkClass(PerkLib.FleshBodyWarriorStage));
		}
		if(player.findPerk(PerkLib.DaoistApprenticeStage) >= 0) {
			_add(new PerkClass(PerkLib.DaoistWarriorStage));
		}
	}
	//Tier 5
	if(player.level >= 30) {
		if(player.findPerk(PerkLib.SoulSprite) >= 0 && player.wis >= 100)
			_add(new PerkClass(PerkLib.SoulExalt));
	}
	//Tier 6
	if(player.level >= 36) {
		if(player.findPerk(PerkLib.SoulExalt) >= 0 && player.wis >= 120)
			_add(new PerkClass(PerkLib.SoulOverlord));
	}
	//Tier 7
	if(player.level >= 42) {
		if(player.findPerk(PerkLib.SoulOverlord) >= 0 && player.wis >= 140) {	// && player.findPerk(PerkLib.GclassHeavenTribulationSurvivor) >= 0
			_add(new PerkClass(PerkLib.SoulTyrant));
		}
		if(player.findPerk(PerkLib.FleshBodyWarriorStage) >= 0) {
			_add(new PerkClass(PerkLib.FleshBodyOverlordStage));
		}
		if(player.findPerk(PerkLib.DaoistWarriorStage) >= 0) {
			_add(new PerkClass(PerkLib.DaoistOverlordStage));
		}
	}		//zablokować wszystkie trzy perki w momnencie robienia live version
	//Tier 8
	if(player.level >= 48) {
		if(player.findPerk(PerkLib.SoulTyrant) >= 0 && player.wis >= 160)
			_add(new PerkClass(PerkLib.SoulKing));
	}
	//Tier 9
	if(player.level >= 54) {
		if(player.findPerk(PerkLib.SoulKing) >= 0 && player.wis >= 180)
			_add(new PerkClass(PerkLib.SoulEmperor));
	}
	//------------
	// MISCELLANEOUS
	//------------
	//Tier 0
	if (player.demonScore() >= 6 && player.findPerk(PerkLib.DarkCharm) > 0 && player.cor >= 90) {
		_add(new PerkClass(PerkLib.BlackHeart));
	}
	if (player.catScore() >= 4 && player.findPerk(PerkLib.Flexibility) > 0) {
		_add(new PerkClass(PerkLib.CatlikeNimbleness));
	}
	if (player.dragonScore() >= 6 && player.findPerk(PerkLib.DragonFireBreath) > 0 && player.findPerk(PerkLib.DragonIceBreath) > 0) {
		_add(new PerkClass(PerkLib.DraconicLungs));
	}
	if (player.gorgonScore() >= 5 && player.eyeType == 4) {
		_add(new PerkClass(PerkLib.GorgonsEyes));
	}
	if (player.kitsuneScore() >= 5 && (player.findPerk(PerkLib.EnlightenedKitsune) > 0 || player.findPerk(PerkLib.CorruptedKitsune) > 0)) {
		_add(new PerkClass(PerkLib.KitsuneThyroidGland));
	}
	if (player.lizardScore() >= 4 && player.findPerk(PerkLib.LizanRegeneration) > 0) {
		_add(new PerkClass(PerkLib.LizanMarrow));
	}
	if (player.manticoreScore() >= 10 && player.tailType == 28) {
		_add(new PerkClass(PerkLib.ManticoreMetabolism));
	}
	if (player.mantisScore() >= 5 && player.findPerk(PerkLib.TrachealSystem) > 0) {
		_add(new PerkClass(PerkLib.MantislikeAgility));
	}
	if (player.salamanderScore() >= 4 && player.findPerk(PerkLib.Lustzerker) > 0) {
		_add(new PerkClass(PerkLib.SalamanderAdrenalGlands));
	}
	if (player.scyllaScore() >= 5 && player.findPerk(PerkLib.InkSpray) > 0) {
		_add(new PerkClass(PerkLib.ScyllaInkGlands));
	}
	if (player.beeScore() >= 4 || player.mantisScore() >= 5 || player.scorpionScore() >= 4 || player.spiderScore() >= 4) {
		_add(new PerkClass(PerkLib.TrachealSystem));
	}/*
	if (player.beeScore() >= 8 && player.mantisScore() >= 8 && player.scorpionScore() >= 8 && player.spiderScore() >= 8 && player.findPerk(PerkLib.TrachealSystem) > 0) {
		_add(new PerkClass(PerkLib.TrachealSystemEvolved));
	}
	if (player.() >=  && ) {
		_add(new PerkClass(PerkLib.));
	}
	if (player.() >=  && ) {
		_add(new PerkClass(PerkLib.));
	}
	Phoenix Thorax czy jakiś inny związany z morphami perk ub coś związane z gardłem - dla ras mogących używać ultradźwieki jako atak lub kogoś typu banshee atak wyciem
	
	Perk związany z mieśniami
	
	Perk związany ze skórą
	
	Perk związany z układem nerwowym
	
	Perk związany z koścmi
	
	if (flags[kFLAGS.HUNGER_ENABLED] > 0 && game.player.humanScore() < 5) {
		_add(new PerkClass(PerkLib.)); - zelazny zoladek czy cos w tym stylu
	}
	*/
	if (player.findPerk(PerkLib.GeneticMemory) >= 0) {
		_add(new PerkClass(PerkLib.Metamorph));
	}
	
	//Tier 1
	if (player.level >= 6) {
		_add(new PerkClass(PerkLib.ResistanceI));
		_add(new PerkClass(PerkLib.Heroism));
	//	_add(new PerkClass(PerkLib.DualWield));
		if (flags[kFLAGS.HUNGER_ENABLED] > 0)
			_add(new PerkClass(PerkLib.Survivalist));
		if (player.findPerk(PerkLib.ResistanceI) >= 0 && player.level >= 8 && player.newGamePlusMod() >= 1) {
			_add(new PerkClass(PerkLib.ResistanceII));
		}
		if (player.findPerk(PerkLib.ResistanceII) >= 0 && player.level >= 10 && player.newGamePlusMod() >= 2) {
			_add(new PerkClass(PerkLib.ResistanceIII));
		}
		if (player.internalChimeraScore() >= 1) {
			_add(new PerkClass(PerkLib.ChimericalBodyInitialStage));
		}
	}
	//Tier 2
	if (player.level >= 12) {
		if (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.findPerk(PerkLib.Survivalist) > 0) {
			_add(new PerkClass(PerkLib.Survivalist2));
		}
		if (player.findPerk(PerkLib.ResistanceIII) >= 0 && player.newGamePlusMod() >= 3) {
			_add(new PerkClass(PerkLib.ResistanceIV));
		}
		if (player.findPerk(PerkLib.ResistanceIV) >= 0 && player.level >= 14 && player.newGamePlusMod() >= 4) {
			_add(new PerkClass(PerkLib.ResistanceV));
		}
		if (player.internalChimeraScore() >= 2 && player.findPerk(PerkLib.ChimericalBodyInitialStage) >= 0) {
			_add(new PerkClass(PerkLib.ChimericalBodyBasicStage));
		}
		if (player.findPerk(PerkLib.JobBarbarian) > 0)
			_add(new PerkClass(PerkLib.Whirlwind));
		if (player.findPerk(PerkLib.JobEromancer) > 0)
			_add(new PerkClass(PerkLib.Whipping));
	}
	//Tier 3
//	if (player.level >= 18) {
//		if (player.internalChimeraScore() >= 4 && player.findPerk(PerkLib.ChimericalBodyBasicStage) >= 0) {
//			_add(new PerkClass(PerkLib.ChimericalBodyAdvancedStage));
//		}
//	}
	//Tier 4
	if (player.level >= 24) {
		if (player.findPerk(PerkLib.JobGuardian) > 0 && player.findPerk(PerkLib.JobRanger) > 0 && player.findPerk(PerkLib.JobSeducer) > 0 && player.findPerk(PerkLib.JobSorcerer) > 0 && player.findPerk(PerkLib.JobSoulCultivator) >= 0 && player.findPerk(PerkLib.JobWarrior) > 0 && player.str >= 75 && player.tou >= 75 && player.spe >= 75 && player.inte >= 75 && player.wis >= 75 && player.lib >= 45) {
			_add(new PerkClass(PerkLib.JobAllRounder));
		}
//		if(player.internalChimeraScore() >= 8 && player.findPerk(PerkLib.ChimericalBodyAdvancedStage) >= 0) {
//			_add(new PerkClass(PerkLib.ChimericalBodyPerfectStage));
//		}
	}
	//Tier 5
//	if (player.level >= 30) {
//		if (player.internalChimeraScore() >= 16 && player.findPerk(PerkLib.ChimericalBodyPerfectStage) >= 0) {
//			_add(new PerkClass(PerkLib.ChimericalBodyUltimateStage));
//		}
		if (player.findPerk(PerkLib.JobMonk) > 0 && player.findPerk(PerkLib.JobHunter) > 0 && player.findPerk(PerkLib.JobEromancer) > 0 && player.findPerk(PerkLib.JobEnchanter) > 0 && player.findPerk(PerkLib.JobDervish) > 0 && player.findPerk(PerkLib.JobBarbarian) > 0 && player.findPerk(PerkLib.JobAllRounder) > 0 && player.str >= 150 && player.tou >= 150 && player.spe >= 150 &&
		player.inte >= 150 && player.wis >= 150 && player.lib >= 90) {	//player.findPerk(PerkLib.JobEromancer) > 0 && 
			_add(new PerkClass(PerkLib.JobMunchkin));
		}	//(Still need some other related stuff added to make PC true Munchkin
//	}		//na razie jest perk GreyMage, potrzeba jeszcze pare innych perków tak z 3-5 innych jeszcze)
	//Tier 6
	//if (player.level >= 36) {
		//if
			//_add(new PerkClass(PerkLib.
	//}
	//Tier 7
	//if (player.level >= 42) {
		//if
			//_add(new PerkClass(PerkLib.
	//}
	
	// FILTER PERKS
	perkList = perkList.filter(
			function(perk:*,idx:int,array:Array):Boolean{
				return player.findPerk(perk.perk.ptype) < 0;
			});
	mainView.aCb.dataProvider = new DataProvider(perkList);
	return perkList;
}

public function applyPerk(perk:PerkClass):void {
	clearOutput();
	player.perkPoints--;
	//Apply perk here.
	outputText("<b>" + perk.perkName + "</b> gained!");
	player.createPerk(perk.ptype, perk.value1, perk.value2, perk.value3, perk.value4);
	if (perk.ptype == PerkLib.StrongBack2) player.itemSlot5.unlocked = true;
	if (perk.ptype == PerkLib.StrongBack) player.itemSlot4.unlocked = true;
	if (perk.ptype == PerkLib.TankI || perk.ptype == PerkLib.TankII || perk.ptype == PerkLib.TankIII || perk.ptype == PerkLib.TankIV || perk.ptype == PerkLib.TankV) {
		HPChange(player.tou, false);
		statScreenRefresh();
	}
	doNext(playerMenu);
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
	mainView.showBottomButton(pos, text, callback, toolTipText, toolTipHeader);
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
	mainView.statsView.show(); // show() method refreshes.
	mainViewManager.refreshStats();
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

public function physicalCost(mod:Number):Number {
	var costPercent:Number = 100;
	if(player.findPerk(PerkLib.IronMan) >= 0) costPercent -= 50;
	mod *= costPercent/100;
	return mod;
}

public function bowCost(mod:Number):Number {
	var costPercent:Number = 100;
	if(player.findPerk(PerkLib.BowShooting) >= 0) costPercent -= player.perkv1(PerkLib.BowShooting);
	//if(player.findPerk(PerkLib.) >= 0) costPercent -= x0; ((tu umieścić perk dający zmniejszenie % kosztu użycia łuku jak IronMan dla fiz specjali ^^))
	mod *= costPercent/100;
	return mod;
}

public function spellCostBlack(mod:Number):Number {
	//Addiditive mods
	var costPercent:Number = 100;
	if (player.findPerk(PerkLib.Obsession) >= 0) costPercent -= (100 * player.perkv2(PerkLib.Obsession));
	if (player.findPerk(PerkLib.SpellcastingAffinity) >= 0) costPercent -= player.perkv1(PerkLib.SpellcastingAffinity);
	if (player.findPerk(PerkLib.WizardsEnduranceAndSluttySeduction) >= 0) costPercent -= player.perkv1(PerkLib.WizardsEnduranceAndSluttySeduction);
	if (player.findPerk(PerkLib.WizardsAndSoulcultivatorsEndurance) >= 0) costPercent -= player.perkv1(PerkLib.WizardsAndSoulcultivatorsEndurance);
	if (player.findPerk(PerkLib.WizardsEndurance) >= 0) costPercent -= player.perkv1(PerkLib.WizardsEndurance);
	if (player.jewelryName == "fox hairpin") costPercent -= 20;
	if (player.jewelryName == "medius signet") costPercent -= 15;
	if (player.weaponName == "Depravatio" || player.weaponName == "Ascensus") costPercent -= 15;
	//Limiting it and multiplicative mods
	if(player.findPerk(PerkLib.BloodMage) >= 0 && costPercent < 50) costPercent = 50;
	mod *= costPercent/100;
	if (player.findPerk(PerkLib.HistoryScholar) >= 0 || player.findPerk(PerkLib.PastLifeScholar) >= 0) {
		if(mod > 2) mod *= .8;
	}
	if (player.findPerk(PerkLib.BloodMage) >= 0 && mod < 5) mod = 5;
	else if(mod < 2) mod = 2;
	mod = Math.round(mod * 100)/100;
	return mod;
}

public function spellCostWhite(mod:Number):Number {
	//Addiditive mods
	var costPercent:Number = 100;
	if (player.findPerk(PerkLib.SpellcastingAffinity) >= 0) costPercent -= player.perkv1(PerkLib.SpellcastingAffinity);
	if (player.findPerk(PerkLib.WizardsEnduranceAndSluttySeduction) >= 0) costPercent -= player.perkv1(PerkLib.WizardsEnduranceAndSluttySeduction);
	if (player.findPerk(PerkLib.WizardsAndSoulcultivatorsEndurance) >= 0) costPercent -= player.perkv1(PerkLib.WizardsAndSoulcultivatorsEndurance);
	if (player.findPerk(PerkLib.WizardsEndurance) >= 0) costPercent -= player.perkv1(PerkLib.WizardsEndurance);
	if (player.jewelryName == "fox hairpin") costPercent -= 20;
	if (player.weaponName == "Puritas" || player.weaponName == "Ascensus") costPercent -= 15;
	//Limiting it and multiplicative mods
	if(player.findPerk(PerkLib.BloodMage) >= 0 && costPercent < 50) costPercent = 50;
	mod *= costPercent/100;
	if (player.findPerk(PerkLib.HistoryScholar) >= 0 || player.findPerk(PerkLib.PastLifeScholar) >= 0) {
		if(mod > 2) mod *= .8;
	}
	if (player.findPerk(PerkLib.BloodMage) >= 0 && mod < 5) mod = 5;
	else if(mod < 2) mod = 2;
	mod = Math.round(mod * 100)/100;
	return mod;
}

public function spellCost(mod:Number):Number {
	//Addiditive mods
	var costPercent:Number = 100;
	if (player.findPerk(PerkLib.SpellcastingAffinity) >= 0) costPercent -= player.perkv1(PerkLib.SpellcastingAffinity);
	if (player.findPerk(PerkLib.WizardsEnduranceAndSluttySeduction) >= 0) costPercent -= player.perkv1(PerkLib.WizardsEnduranceAndSluttySeduction);
	if (player.findPerk(PerkLib.WizardsAndSoulcultivatorsEndurance) >= 0) costPercent -= player.perkv1(PerkLib.WizardsAndSoulcultivatorsEndurance);
	if (player.findPerk(PerkLib.WizardsEndurance) >= 0) costPercent -= player.perkv1(PerkLib.WizardsEndurance);
	if (player.jewelryName == "fox hairpin") costPercent -= 20;
	if (player.weaponName == "Ascensus") costPercent -= 15;
	//Limiting it and multiplicative mods
	if(player.findPerk(PerkLib.BloodMage) >= 0 && costPercent < 50) costPercent = 50;
	mod *= costPercent/100;
	if (player.findPerk(PerkLib.HistoryScholar) >= 0 || player.findPerk(PerkLib.PastLifeScholar) >= 0) {
		if(mod > 2) mod *= .8;
	}
	if (player.findPerk(PerkLib.BloodMage) >= 0 && mod < 5) mod = 5;
	else if(mod < 2) mod = 2;
	mod = Math.round(mod * 100)/100;
	return mod;
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
	//Spell reductions
	if(type == 1) {
		mod = spellCost(mod);
		//Blood mages use HP for spells
		if(player.findPerk(PerkLib.BloodMage) >= 0) {
			takeDamage(mod);
			statScreenRefresh();
			return;
		}                
	}
	//Physical special reductions
	if(type == 2) {
		mod = physicalCost(mod);
	}
	if(type == 3) {
		mod = spellCost(mod);
	}
	if (type == 4) {
		mod = bowCost(mod);
	}
	if (type == 5) {
		mod = spellCostWhite(mod);
		//Blood mages use HP for spells
		if(player.findPerk(PerkLib.BloodMage) >= 0) {
			takeDamage(mod);
			statScreenRefresh();
			return;
		} 
	}
	if (type == 6) {
		mod = spellCostBlack(mod);
		//Blood mages use HP for spells
		if(player.findPerk(PerkLib.BloodMage) >= 0) {
			takeDamage(mod);
			statScreenRefresh();
			return;
		} 
	}
	if (type == 7) {
		mod = spellCostWhite(mod);
	}
	if (type == 8) {
		mod = spellCostBlack(mod);
	}
	if(player.fatigue >= player.maxFatigue() && mod > 0) return;
	if(player.fatigue <= 0 && mod < 0) return;
	//Fatigue restoration buffs!
	if (mod < 0) {
		var multi:Number = 1;
		
		if (player.findPerk(PerkLib.HistorySlacker) >= 0 || player.findPerk(PerkLib.PastLifeSlacker) >= 0) multi += 0.2;
		if (player.findPerk(PerkLib.ControlledBreath) >= 0 && player.cor < (30 + player.corruptionTolerance())) multi += 0.1;
		if (player.findPerk(PerkLib.SpeedyRecovery) >= 0) multi += 0.5;
		if (player.findPerk(PerkLib.GreyArchmage) >= 0) multi += 1;
		if (player.findPerk(PerkLib.ManaAffinityI) >= 0) multi += 0.1;
		if (player.findPerk(PerkLib.ManaAffinityII) >= 0) multi += 0.1;
		if (player.findPerk(PerkLib.ManaAffinityIII) >= 0) multi += 0.1;
		if (player.findPerk(PerkLib.ManaAffinityIV) >= 0) multi += 0.1;
		if (player.findPerk(PerkLib.ManaAffinityV) >= 0) multi += 0.1;
		if (player.findPerk(PerkLib.NaturesSpringI) >= 0) multi += 0.05;
		if (player.findPerk(PerkLib.NaturesSpringII) >= 0) multi += 0.05;
		if (player.findPerk(PerkLib.NaturesSpringIII) >= 0) multi += 0.05;
		if (player.findPerk(PerkLib.NaturesSpringIV) >= 0) multi += 0.05;
		if (player.findPerk(PerkLib.NaturesSpringV) >= 0) multi += 0.05;
		if (player.alicornScore() >= 6) multi += 0.1;
		if (player.kitsuneScore() >= 5) {
			if (player.kitsuneScore() >= 10) multi += 1;
			else multi += 0.5;
		}
		if (player.unicornScore() >= 5) multi += 0.05;
		
		mod *= multi;
	}
	player.fatigue += mod;
	if(mod > 0) {
		mainView.statsView.showStatUp( 'fatigue' );
		// fatigueUp.visible = true;
		// fatigueDown.visible = false;
	}
	if(mod < 0) {
		mainView.statsView.showStatDown( 'fatigue' );
		// fatigueDown.visible = true;
		// fatigueUp.visible = false;
	}
	dynStats("lus", 0, "resisted", false); //Force display fatigue up/down by invoking zero lust change.
	if(player.fatigue > player.maxFatigue()) player.fatigue = player.maxFatigue();
	if(player.fatigue < 0) player.fatigue = 0;
	statScreenRefresh();
}
//function changeFatigue
public function changeFatigue(changeF:Number):void {
	fatigue(changeF);
}

public function minLust():Number {
	return player.minLust();
}

public function displayStats(e:MouseEvent = null):void
{
	spriteSelect(-1);
	clearOutput();
	displayHeader("Stats");
	// Begin Combat Stats
	var combatStats:String = "";
		
	combatStats += "<b>Damage Resistance:</b> " + (100 - Math.round(player.damagePercent(true))) + "-" + (100 - Math.round(player.damagePercent(true) - player.damageToughnessModifier(true))) + "% (Higher is better.)\n";

	combatStats += "<b>Lust Resistance:</b> " + (100 - Math.round(lustPercent())) + "% (Higher is better.)\n";
	
	combatStats += "<b>Spell Effect Multiplier:</b> " + Math.round(100 * spellMod()) + "%\n";
	
	combatStats += "<b>Spell Cost:</b> " + spellCost(100) + "%\n";
	
	combatStats += "<b>White Spell Effect Multiplier:</b> " + Math.round(100 * spellModWhite()) + "%\n";
	
	combatStats += "<b>White Spell Cost:</b> " + spellCostWhite(100) + "%\n";
	
	combatStats += "<b>Black Spell Effect Multiplier:</b> " + Math.round(100 * spellModBlack()) + "%\n";
	
	combatStats += "<b>Black Spell Cost:</b> " + spellCostBlack(100) + "%\n";
	
	combatStats += "<b>Unarmed:</b> +" + unarmedAttack() + "\n";
	
	if (player.statusAffectv1(StatusAffects.Kelt) > 0) {
		if (player.statusAffectv1(StatusAffects.Kindra) < 1)
			combatStats += "<b>Bow Skill:</b> " + Math.round(player.statusAffectv1(StatusAffects.Kelt)) + " / 100\n";
		if (player.statusAffectv1(StatusAffects.Kindra) > 0)
			combatStats += "<b>Bow Skill:</b> " + (Math.round(player.statusAffectv1(StatusAffects.Kelt)) + Math.round(player.statusAffectv1(StatusAffects.Kindra))) + " / 250\n";
	}
	
	combatStats += "<b>Arrow/Bolt Cost:</b> " + bowCost(100) + "%\n";
	
	combatStats += "<b>Accuracy (1st range attack):</b> " + (arrowsAccuracy() / 2) + "%\n";
	
	if (player.findPerk(PerkLib.DoubleStrike) >= 0) combatStats += "<b>Accuracy (2nd range attack):</b> " + ((arrowsAccuracy() / 2) - 15) + "%\n";
	
	if (player.findPerk(PerkLib.Manyshot) >= 0) combatStats += "<b>Accuracy (3rd range attack):</b> " + ((arrowsAccuracy() / 2) - 30) + "%\n";
	
	if (player.findPerk(PerkLib.TripleStrike) >= 0) combatStats += "<b>Accuracy (4th range attack):</b> " + ((arrowsAccuracy() / 2) - 45) + "%\n";
	
	if (player.findPerk(PerkLib.WildQuiver) >= 0) combatStats += "<b>Accuracy (5th range attack):</b> " + ((arrowsAccuracy() / 2) - 60) + "%\n";
	
	if (player.findPerk(PerkLib.Multishot) >= 0) combatStats += "<b>Accuracy (6th range attack):</b> " + ((arrowsAccuracy() / 2) - 75) + "%\n";
	
	combatStats += "<b>Soulskill Effect Multiplier:</b> " + Math.round(100 * soulskillMod()) + "%\n";
	
	combatStats += "<b>Soulskill Cost:</b> " + Math.round(100 * soulskillCost()) + "%\n";
	
	if (flags[kFLAGS.RAPHAEL_RAPIER_TRANING] > 0)
		combatStats += "<b>Rapier Skill:</b> " + flags[kFLAGS.RAPHAEL_RAPIER_TRANING] + " / 4\n";
	
	if (player.teaseLevel < 5)
		combatStats += "<b>Tease Skill:</b>  " + player.teaseLevel + " / 5 (Exp: " + player.teaseXP + " / "+ (10 + (player.teaseLevel + 1) * 5 * (player.teaseLevel + 1))+ ")\n";
	else
		combatStats += "<b>Tease Skill:</b>  " + player.teaseLevel + " / 5 (Exp: MAX)\n";	
	
	combatStats += "<b>Strength Cap:</b> " + player.getMaxStats("str") + "\n";
	combatStats += "<b>Toughness Cap:</b> " + player.getMaxStats("tou") + "\n";
	combatStats += "<b>Speed Cap:</b> " + player.getMaxStats("spe") + "\n";
	combatStats += "<b>Intelligence Cap:</b> " + player.getMaxStats("inte") + "\n";
	combatStats += "<b>Wisdom Cap:</b> " + player.getMaxStats("wis") + "\n";
	combatStats += "<b>Libido Cap:</b> " + player.getMaxStats("lib") + "\n";
	
	if (combatStats != "")
		outputText("<b><u>Combat Stats</u></b>\n" + combatStats, false);
	// End Combat Stats
	
	if (prison.inPrison || flags[kFLAGS.PRISON_CAPTURE_COUNTER] > 0) prison.displayPrisonStats();
	
	// Begin Children Stats
	var childStats:String = "";
	
	if (player.statusAffectv1(StatusAffects.Birthed) > 0)
		childStats += "<b>Times Given Birth:</b> " + player.statusAffectv1(StatusAffects.Birthed) + "\n";
		
	if (flags[kFLAGS.AMILY_MET] > 0)
		childStats += "<b>Litters With Amily:</b> " + (flags[kFLAGS.AMILY_BIRTH_TOTAL] + flags[kFLAGS.PC_TIMES_BIRTHED_AMILYKIDS]) + "\n";

	if (flags[kFLAGS.BEHEMOTH_CHILDREN] > 0)
		childStats += "<b>Children With Behemoth:</b> " + flags[kFLAGS.BEHEMOTH_CHILDREN] + "\n";

	if (flags[kFLAGS.BENOIT_EGGS] > 0)
		childStats += "<b>Benoit Eggs Laid:</b> " + flags[kFLAGS.BENOIT_EGGS] + "\n";
	if (flags[kFLAGS.FEMOIT_EGGS_LAID] > 0)
		childStats += "<b>Benoite Eggs Produced:</b> " + flags[kFLAGS.FEMOIT_EGGS_LAID] + "\n";
		
	if (flags[kFLAGS.COTTON_KID_COUNT] > 0)
		childStats += "<b>Children With Cotton:</b> " + flags[kFLAGS.COTTON_KID_COUNT] + "\n";
	
	if (flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] > 0)
		childStats += "<b>Children With Edryn:</b> " + flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] + "\n";
		
	if (flags[kFLAGS.EMBER_CHILDREN_MALES] > 0)
		childStats += "<b>Ember Offspring (Males):</b> " + flags[kFLAGS.EMBER_CHILDREN_MALES] + "\n";
	if (flags[kFLAGS.EMBER_CHILDREN_FEMALES] > 0)
		childStats += "<b>Ember Offspring (Females):</b> " + flags[kFLAGS.EMBER_CHILDREN_FEMALES] + "\n";
	if (flags[kFLAGS.EMBER_CHILDREN_HERMS] > 0)
		childStats += "<b>Ember Offspring (Herms):</b> " + flags[kFLAGS.EMBER_CHILDREN_HERMS] + "\n";
	if (emberScene.emberChildren() > 0)
		childStats += "<b>Total Children With Ember:</b> " + (emberScene.emberChildren()) + "\n";
	
	if (flags[kFLAGS.EMBER_EGGS] > 0)
		childStats += "<b>Ember Eggs Produced:</b> " + flags[kFLAGS.EMBER_EGGS] + "\n";
		
	if (isabellaScene.totalIsabellaChildren() > 0) {
		if (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_BOYS) > 0)
			childStats += "<b>Children With Isabella (Human, Males):</b> " + isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_BOYS) + "\n";
		if (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_GIRLS) > 0)
			childStats += "<b>Children With Isabella (Human, Females):</b> " + isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_GIRLS) + "\n";
		if (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_HERMS) > 0)
			childStats += "<b>Children With Isabella (Human, Herms):</b> " + isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_HERMS) + "\n";
		if (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWGIRLS) > 0)
			childStats += "<b>Children With Isabella (Cowgirl, Females):</b> " + isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWGIRLS) + "\n";
		if (isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWFUTAS) > 0)
			childStats += "<b>Children With Isabella (Cowgirl, Herms):</b> " + isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWFUTAS) + "\n";
		childStats += "<b>Total Children With Isabella:</b> " + isabellaScene.totalIsabellaChildren() + "\n"
	}
		
		
	if (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] > 0)
		childStats += "<b>Children With Izma (Sharkgirls):</b> " + flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] + "\n";
	if (flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] > 0)
		childStats += "<b>Children With Izma (Tigersharks):</b> " + flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] + "\n";
	if (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] > 0 && flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] > 0)
		childStats += "<b>Total Children with Izma:</b> " + (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] + flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS]) + "\n";
		
	if (joyScene.getTotalLitters() > 0)
		childStats += "<b>Litters With " + (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 ? "Joy" : "Jojo") + ":</b> " + joyScene.getTotalLitters() + "\n";
		
	if (flags[kFLAGS.KELLY_KIDS_MALE] > 0)
		childStats += "<b>Children With Kelly (Males):</b> " + flags[kFLAGS.KELLY_KIDS_MALE] + "\n";
	if (flags[kFLAGS.KELLY_KIDS] - flags[kFLAGS.KELLY_KIDS_MALE] > 0)
		childStats += "<b>Children With Kelly (Females):</b> " + (flags[kFLAGS.KELLY_KIDS] - flags[kFLAGS.KELLY_KIDS_MALE]) + "\n";
	if (flags[kFLAGS.KELLY_KIDS] > 0)
		childStats += "<b>Total Children With Kelly:</b> " + flags[kFLAGS.KELLY_KIDS] + "\n";
	if (kihaFollower.pregnancy.isPregnant)
		childStats += "<b>Kiha's Pregnancy:</b> " + kihaFollower.pregnancy.incubation + "\n";
	if (flags[kFLAGS.KIHA_CHILDREN_BOYS] > 0)
		childStats += "<b>Kiha Offspring (Males):</b> " + flags[kFLAGS.KIHA_CHILDREN_BOYS] + "\n";
	if (flags[kFLAGS.KIHA_CHILDREN_GIRLS] > 0)
		childStats += "<b>Kiha Offspring (Females):</b> " + flags[kFLAGS.KIHA_CHILDREN_GIRLS] + "\n";
	if (flags[kFLAGS.KIHA_CHILDREN_HERMS] > 0)
		childStats += "<b>Kiha Offspring (Herms):</b> " + flags[kFLAGS.KIHA_CHILDREN_HERMS] + "\n";
	if (kihaFollower.totalKihaChildren() > 0)
		childStats += "<b>Total Children With Kiha:</b> " + kihaFollower.totalKihaChildren() + "\n";
		
	if (mountain.salon.lynnetteApproval() != 0)
		childStats += "<b>Lynnette Children:</b> " + flags[kFLAGS.LYNNETTE_BABY_COUNT] + "\n";
		
	if (flags[kFLAGS.MARBLE_KIDS] > 0)
		childStats += "<b>Children With Marble:</b> " + flags[kFLAGS.MARBLE_KIDS] + "\n";
		
	if (flags[kFLAGS.MINERVA_CHILDREN] > 0)
		childStats += "<b>Children With Minerva:</b> " + flags[kFLAGS.MINERVA_CHILDREN] + "\n";
		
	if (flags[kFLAGS.ANT_KIDS] > 0)
		childStats += "<b>Ant Children With Phylla:</b> " + flags[kFLAGS.ANT_KIDS] + "\n";
	if (flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] > 0)
		childStats += "<b>Drider Children With Phylla:</b> " + flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] + "\n";
	if (flags[kFLAGS.ANT_KIDS] > 0 && flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] > 0)
		childStats += "<b>Total Children With Phylla:</b> " + (flags[kFLAGS.ANT_KIDS] + flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT]) + "\n";
		
	if (flags[kFLAGS.SHEILA_JOEYS] > 0)
		childStats += "<b>Children With Sheila (Joeys):</b> " + flags[kFLAGS.SHEILA_JOEYS] + "\n";
	if (flags[kFLAGS.SHEILA_IMPS] > 0)
		childStats += "<b>Children With Sheila (Imps):</b> " + flags[kFLAGS.SHEILA_IMPS] + "\n";
	if (flags[kFLAGS.SHEILA_JOEYS] > 0 && flags[kFLAGS.SHEILA_IMPS] > 0)
		childStats += "<b>Total Children With Sheila:</b> " + (flags[kFLAGS.SHEILA_JOEYS] + flags[kFLAGS.SHEILA_IMPS]) + "\n";
		
	if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] > 0 || flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) 
	{
		childStats += "<b>Children With Sophie:</b> ";
		var sophie:int = 0;
		if (flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) sophie++;
		sophie += flags[kFLAGS.SOPHIE_ADULT_KID_COUNT];
		if (flags[kFLAGS.SOPHIE_CAMP_EGG_COUNTDOWN] > 0) sophie++;
		childStats += sophie + "\n";
	}
	
	if (flags[kFLAGS.SOPHIE_EGGS_LAID] > 0)
		childStats += "<b>Eggs Fertilized For Sophie:</b> " + (flags[kFLAGS.SOPHIE_EGGS_LAID] + sophie) + "\n";
		
	if (flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] > 0)
		childStats += "<b>Children With Tamani:</b> " + flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] + " (after all forms of natural selection)\n";
		
	if (urtaPregs.urtaKids() > 0)
		childStats += "<b>Children With Urta:</b> " + urtaPregs.urtaKids() + "\n";
		
	//Mino sons
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] > 0)
		childStats += "<b>Number of Adult Minotaur Offspring:</b> " + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] + "\n";
	
	if (childStats != "")
		outputText("\n<b><u>Children</u></b>\n" + childStats, false);
	// End Children Stats

	// Begin Body Stats
	var bodyStats:String = "";

	if (flags[kFLAGS.HUNGER_ENABLED] > 0 || flags[kFLAGS.IN_PRISON] > 0)
	{
		bodyStats += "<b>Satiety:</b> " + Math.floor(player.hunger) + " / " + player.maxHunger() + " (";
		if (player.hunger <= 0) bodyStats += "<font color=\"#ff0000\">Dying</font>";
		if (player.hunger > 0 && player.hunger < 10) bodyStats += "<font color=\"#C00000\">Starving</font>";
		if (player.hunger >= 10 && player.hunger < 25) bodyStats += "<font color=\"#800000\">Very hungry</font>";
		if (player.hunger >= 25 && player.hunger < 50) bodyStats += "Hungry";
		if (player.hunger >= 50 && player.hunger < 75) bodyStats += "Not hungry";
		if (player.hunger >= 75 && player.hunger < 90) bodyStats += "<font color=\"#008000\">Satiated</font>";
		if (player.hunger >= 90 && player.hunger < 100) bodyStats += "<font color=\"#00C000\">Full</font>";
		if (player.hunger >= 100) bodyStats += "<font color=\"#0000ff\">Very full</font>";
		bodyStats += ")\n";
	}
	bodyStats += "<b>Times Transformed:</b> " + flags[kFLAGS.TIMES_TRANSFORMED] + "\n";
	if (player.tailType == TAIL_TYPE_BEE_ABDOMEN || player.tailType == TAIL_TYPE_SCORPION || player.tailType == TAIL_TYPE_MANTICORE_PUSSYTAIL || player.tailType == TAIL_TYPE_SPIDER_ADBOMEN || player.faceType == FACE_SNAKE_FANGS || player.faceType == FACE_SPIDER_FANGS) {
		if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN && player.faceType != FACE_SNAKE_FANGS && player.faceType != FACE_SPIDER_FANGS)
			bodyStats += "<b>Web:</b> " + player.tailVenom + "/" + player.maxVenom() + "\n";
		else if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN && (player.faceType == FACE_SNAKE_FANGS || player.faceType == FACE_SPIDER_FANGS))
			bodyStats += "<b>Venom/Web:</b> " + player.tailVenom + "/" + player.maxVenom() + "\n";
		else if (player.tailType != TAIL_TYPE_SPIDER_ADBOMEN)
			bodyStats += "<b>Venom:</b> " + player.tailVenom + "/" + player.maxVenom() + "\n";
	}

	bodyStats += "<b>Anal Capacity:</b> " + Math.round(player.analCapacity()) + "\n";
	bodyStats += "<b>Anal Looseness:</b> " + Math.round(player.ass.analLooseness) + "\n";
	
	bodyStats += "<b>Fertility (Base) Rating:</b> " + Math.round(player.fertility) + "\n";
	bodyStats += "<b>Fertility (With Bonuses) Rating:</b> " + Math.round(player.totalFertility()) + "\n";
	
	if (player.cumQ() > 0)
		bodyStats += "<b>Virility Rating:</b> " + Math.round(player.virilityQ() * 100) + "\n";
		if (flags[kFLAGS.HUNGER_ENABLED] >= 1) bodyStats += "<b>Cum Production:</b> " + addComma(Math.round(player.cumQ())) + " / " + addComma(Math.round(player.cumCapacity())) + "mL (" + Math.round((player.cumQ() / player.cumCapacity()) * 100) + "%) \n";
		else bodyStats += "<b>Cum Production:</b> " + addComma(Math.round(player.cumQ())) + "mL\n";
	if (player.lactationQ() > 0)
		bodyStats += "<b>Milk Production:</b> " + addComma(Math.round(player.lactationQ())) + "mL\n";
	
	if (player.findStatusAffect(StatusAffects.Feeder) >= 0) {
		bodyStats += "<b>Hours Since Last Time Breastfed Someone:</b>  " + player.statusAffectv2(StatusAffects.Feeder);
		if (player.statusAffectv2(StatusAffects.Feeder) >= 72)
			bodyStats += " (Too long! Sensitivity Increasing!)";
		
		bodyStats += "\n";
	}
	
	bodyStats += "<b>Pregnancy Speed Multiplier:</b> ";
	var preg:Number = 1;
	if (player.findPerk(PerkLib.Diapause) >= 0)
		bodyStats += "? (Variable due to Diapause)\n";
	else {
		if (player.findPerk(PerkLib.MaraesGiftFertility) >= 0) preg++;
		if (player.findPerk(PerkLib.BroodMother) >= 0) preg++;
		if (player.findPerk(PerkLib.FerasBoonBreedingBitch) >= 0) preg++;
		if (player.findPerk(PerkLib.MagicalFertility) >= 0) preg++;
		if (player.findPerk(PerkLib.FerasBoonWideOpen) >= 0 || player.findPerk(PerkLib.FerasBoonMilkingTwat) >= 0) preg++;
		bodyStats += preg + "\n";
	}
	
	if (player.cocks.length > 0) {
		bodyStats += "<b>Total Cocks:</b> " + player.cocks.length + "\n";

		var totalCockLength:Number = 0;
		var totalCockGirth:Number = 0;
		
		for (var i:Number = 0; i < player.cocks.length; i++) {
				totalCockLength += player.cocks[i].cockLength;
				totalCockGirth += player.cocks[i].cockThickness
		}
				
		bodyStats += "<b>Total Cock Length:</b> " + Math.round(totalCockLength) + " inches\n";
		bodyStats += "<b>Total Cock Girth:</b> " + Math.round(totalCockGirth) + " inches\n";
		
	}
	
	if (player.vaginas.length > 0)
		bodyStats += "<b>Vaginal Capacity:</b> " + Math.round(player.vaginalCapacity()) + "\n" + "<b>Vaginal Looseness:</b> " + Math.round(player.looseness()) + "\n";

	if (player.findPerk(PerkLib.SpiderOvipositor) >= 0 || player.findPerk(PerkLib.BeeOvipositor) >= 0)
		bodyStats += "<b>Ovipositor Total Egg Count: " + player.eggs() + "\nOvipositor Fertilized Egg Count: " + player.fertilizedEggs() + "</b>\n";
		
	if (player.findStatusAffect(StatusAffects.SlimeCraving) >= 0) {
		if (player.statusAffectv1(StatusAffects.SlimeCraving) >= 18)
			bodyStats += "<b>Slime Craving:</b> Active! You are currently losing strength and speed.  You should find fluids.\n";
		else {
			if (player.findPerk(PerkLib.SlimeCore) >= 0)
				bodyStats += "<b>Slime Stored:</b> " + ((17 - player.statusAffectv1(StatusAffects.SlimeCraving)) * 2) + " hours until you start losing strength.\n";
			else
				bodyStats += "<b>Slime Stored:</b> " + (17 - player.statusAffectv1(StatusAffects.SlimeCraving)) + " hours until you start losing strength.\n";
		}
	}
	
	if (bodyStats != "")
		outputText("\n<b><u>Body Stats</u></b>\n" + bodyStats, false);
	// End Body Stats

	// Begin Misc Stats
	var miscStats:String = "";
	
	if (camp.getCampPopulation() > 0)
		miscStats += "<b>Camp Population:</b> " + camp.getCampPopulation() + "\n";
	
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 1) {	
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2)
			miscStats += "<b>Nails:</b> " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/600" + "\n";
		else
			miscStats += "<b>Nails:</b> " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/200" + "\n";
	}
 	
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 1) {
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3)
			miscStats += "<b>Wood:</b> " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/900" + "\n";
		else
			miscStats += "<b>Wood:</b> " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/300" + "\n";
	}

	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 1) {
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4)
			miscStats += "<b>Stone:</b> " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/900" + "\n";	
		else
			miscStats += "<b>Stone:</b> " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/300" + "\n";
	}
		
	if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] > 0) {
		if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] < 100)
			miscStats += "<b>Corrupted Glades Status:</b> " + (100 - flags[kFLAGS.CORRUPTED_GLADES_DESTROYED]) + "% remaining\n";
		else 
			miscStats += "<b>Corrupted Glades Status:</b> Extinct\n";
	}
		
	if (flags[kFLAGS.EGGS_BOUGHT] > 0)
		miscStats += "<b>Eggs Traded For:</b> " + flags[kFLAGS.EGGS_BOUGHT] + "\n";
	
	if (flags[kFLAGS.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY] > 0)
		miscStats += "<b>Times Had Fun with Feline Flexibility:</b> " + flags[kFLAGS.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY] + "\n";
	
	if (flags[kFLAGS.FAP_ARENA_SESSIONS] > 0)
		miscStats += "<b>Times Circle Jerked in the Arena:</b> " + flags[kFLAGS.FAP_ARENA_SESSIONS] + "\n<b>Victories in the Arena:</b> " + flags[kFLAGS.FAP_ARENA_VICTORIES] + "\n";
	
	if (flags[kFLAGS.SPELLS_CAST] > 0)
		miscStats += "<b>Spells Cast:</b> " + flags[kFLAGS.SPELLS_CAST] + "\n";
	
	if (flags[kFLAGS.ARROWS_SHOT] > 0)
		miscStats += "<b>Arrows Fired:</b> " + flags[kFLAGS.ARROWS_SHOT] + "\n";
	
	if (flags[kFLAGS.TIMES_BAD_ENDED] > 0)
		miscStats += "<b>Times Bad-Ended:</b> " + flags[kFLAGS.TIMES_BAD_ENDED] + "\n";
	
	if (flags[kFLAGS.TIMES_ORGASMED] > 0)
		miscStats += "<b>Times Orgasmed:</b> " + flags[kFLAGS.TIMES_ORGASMED] + "\n";
	
	if (miscStats != "")
		outputText("\n<b><u>Miscellaneous Stats</u></b>\n" + miscStats);
	// End Misc Stats
	
	// Begin Addition Stats
	var addictStats:String = "";
	//Marble Milk Addition
	if (player.statusAffectv3(StatusAffects.Marble) > 0) {
		addictStats += "<b>Marble Milk:</b> ";
		if (player.findPerk(PerkLib.MarbleResistant) < 0 && player.findPerk(PerkLib.MarblesMilk) < 0)
			addictStats += Math.round(player.statusAffectv2(StatusAffects.Marble)) + "%\n";
		else if (player.findPerk(PerkLib.MarbleResistant) >= 0)
			addictStats += "0%\n";
		else
			addictStats += "100%\n";
	}
	
	// Corrupted Minerva's Cum Addiction
	if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] >= 10 && flags[kFLAGS.MINERVA_CORRUPTED_CUM_ADDICTION] > 0) {
		addictStats += "<b>Minerva's Cum:</b> " + (flags[kFLAGS.MINERVA_CORRUPTED_CUM_ADDICTION] * 20) + "%";
	}
	
	// Mino Cum Addiction
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00340] > 0 || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 0 || player.findPerk(PerkLib.MinotaurCumAddict) >= 0 || player.findPerk(PerkLib.MinotaurCumResistance) >= 0 || player.findPerk(PerkLib.ManticoreCumAddict) >= 0) {
		if (player.findPerk(PerkLib.MinotaurCumAddict) < 0)
			addictStats += "<b>Minotaur Cum:</b> " + Math.round(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] * 10)/10 + "%\n";
		else if (player.findPerk(PerkLib.MinotaurCumResistance) >= 0 || player.findPerk(PerkLib.ManticoreCumAddict) >= 0)
			addictStats += "<b>Minotaur Cum:</b> 0% (Immune)\n";
		else
			addictStats += "<b>Minotaur Cum:</b> 100+%\n";
	}
	
	if (player.tailType == 28)
		addictStats += "Manticore Hunger: " + flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] + "%\n";
	
	if (addictStats != "")
		outputText("\n<b><u>Addictions</u></b>\n" + addictStats, false);
	// End Addition Stats
	
	// Begin Interpersonal Stats
	var interpersonStats:String = "";
	
	if (flags[kFLAGS.ARIAN_PARK] > 0)
		interpersonStats += "<b>Arian's Health:</b> " + Math.round(arianScene.arianHealth()) + "\n";
		
	if (flags[kFLAGS.ARIAN_VIRGIN] > 0)
		interpersonStats += "<b>Arian Sex Counter:</b> " + Math.round(flags[kFLAGS.ARIAN_VIRGIN]) + "\n";
	
	if (bazaar.benoit.benoitAffection() > 0)
		interpersonStats += "<b>" + bazaar.benoit.benoitMF("Benoit", "Benoite") + " Affection:</b> " + Math.round(bazaar.benoit.benoitAffection()) + "%\n";
	
	if (flags[kFLAGS.BROOKE_MET] > 0)
		interpersonStats += "<b>Brooke Affection:</b> " + Math.round(telAdre.brooke.brookeAffection()) + "\n";
		
	if (flags[kFLAGS.CEANI_AFFECTION] > 0)
		interpersonStats += "<b>Ceani Affection:</b> " + Math.round(flags[kFLAGS.CEANI_AFFECTION]) + "%\n";
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00218] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00219] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00220] > 0)
		interpersonStats += "<b>Body Parts Taken By Ceraph:</b> " + (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00218] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00219] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00220]) + "\n";
	if (flags[kFLAGS.ETNA_AFFECTION] > 0)
		interpersonStats += "<b>Etna Affection:</b> " + Math.round(flags[kFLAGS.ETNA_AFFECTION]) + "%\n";
	if (emberScene.emberAffection() > 0)
		interpersonStats += "<b>Ember Affection:</b> " + Math.round(emberScene.emberAffection()) + "%\n";
	if (helFollower.helAffection() > 0)
		interpersonStats += "<b>Helia Affection:</b> " + Math.round(helFollower.helAffection()) + "%\n";
	if (helFollower.helAffection() >= 100)
		interpersonStats += "<b>Helia Bonus Points:</b> " + Math.round(flags[kFLAGS.HEL_BONUS_POINTS]) + "\n";
	
	if (flags[kFLAGS.ISABELLA_AFFECTION] > 0) {
		interpersonStats += "<b>Isabella Affection:</b> ";
		
		if (!isabellaFollowerScene.isabellaFollower())
			interpersonStats += Math.round(flags[kFLAGS.ISABELLA_AFFECTION]) + "%\n", false;
		else
			interpersonStats += "100%\n";
	}
	
	if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3) {
		interpersonStats += "<b>Joy's Intelligence:</b> " + flags[kFLAGS.JOY_INTELLIGENCE];
		if (flags[kFLAGS.JOY_INTELLIGENCE] >= 50) interpersonStats += " (MAX)"
		interpersonStats += "\n";
	}
	
	if (flags[kFLAGS.KATHERINE_UNLOCKED] >= 4) {
		interpersonStats += "<b>Katherine Submissiveness:</b> " + telAdre.katherine.submissiveness() + "\n";
	}

	if (player.findStatusAffect(StatusAffects.Kelt) >= 0 && flags[kFLAGS.KELT_BREAK_LEVEL] == 0 && flags[kFLAGS.KELT_KILLED] == 0) {
		if (player.statusAffectv2(StatusAffects.Kelt) >= 130)
			interpersonStats += "<b>Submissiveness To Kelt:</b> " + 100 + "%\n";
		else
			interpersonStats += "<b>Submissiveness To Kelt:</b> " + Math.round(player.statusAffectv2(StatusAffects.Kelt) / 130 * 100) + "%\n";
			
	}
	
	if (flags[kFLAGS.ANEMONE_KID] > 0)
		interpersonStats += "<b>Kid A's Confidence:</b> " + anemoneScene.kidAXP() + "%\n";

	if (flags[kFLAGS.KIHA_AFFECTION_LEVEL] == 2) {
		if (kihaFollower.followerKiha())
			interpersonStats += "<b>Kiha Affection:</b> " + 100 + "%\n";
		else
			interpersonStats += "<b>Kiha Affection:</b> " + Math.round(flags[kFLAGS.KIHA_AFFECTION]) + "%\n";
	}
	
	if (flags[kFLAGS.KINDRA_FOLLOWER] > 0)
		interpersonStats += "<b>Kindra Affection:</b> " + Math.round(flags[kFLAGS.KINDRA_AFFECTION]) + "%\n";
	
	//Lottie stuff
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00281] > 0)
		interpersonStats += "<b>Lottie's Encouragement:</b> " + telAdre.lottie.lottieMorale() + " (higher is better)\n" + "<b>Lottie's Figure:</b> " + telAdre.lottie.lottieTone() + " (higher is better)\n";
	
	if (mountain.salon.lynnetteApproval() != 0)
		interpersonStats += "<b>Lynnette's Approval:</b> " + mountain.salon.lynnetteApproval() + "\n";
		
	if (flags[kFLAGS.OWCAS_ATTITUDE] > 0)
		interpersonStats += "<b>Owca's Attitude:</b> " + flags[kFLAGS.OWCAS_ATTITUDE] + "\n";
		
	if (telAdre.rubi.rubiAffection() > 0)
		interpersonStats += "<b>Rubi's Affection:</b> " + Math.round(telAdre.rubi.rubiAffection()) + "%\n" + "<b>Rubi's Orifice Capacity:</b> " + Math.round(telAdre.rubi.rubiCapacity()) + "%\n";

	if (flags[kFLAGS.SHEILA_XP] != 0) {
		interpersonStats += "<b>Sheila's Corruption:</b> " + sheilaScene.sheilaCorruption();
		if (sheilaScene.sheilaCorruption() > 100)
			interpersonStats += " (Yes, it can go above 100)";
		interpersonStats += "\n";
	}
	
	if (valeria.valeriaFluidsEnabled()) {
		interpersonStats += "<b>Valeria's Fluid:</b> " + flags[kFLAGS.VALERIA_FLUIDS] + "%\n"
	}
	
	if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] != 0) {
		if (urta.urtaLove()) {
			if (flags[kFLAGS.URTA_QUEST_STATUS] == -1) interpersonStats += "<b>Urta Status:</b> <font color=\"#800000\">Gone</font>\n";
			if (flags[kFLAGS.URTA_QUEST_STATUS] == 0) interpersonStats += "<b>Urta Status:</b> Lover\n";
			if (flags[kFLAGS.URTA_QUEST_STATUS] == 1) interpersonStats += "<b>Urta Status:</b> <font color=\"#008000\">Lover+</font>\n";
		}
		else if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] == -1)
			interpersonStats += "<b>Urta Status:</b> Ashamed\n";
		else if (flags[kFLAGS.URTA_PC_AFFECTION_COUNTER] < 30)
			interpersonStats += "<b>Urta's Affection:</b> " + Math.round(flags[kFLAGS.URTA_PC_AFFECTION_COUNTER] * 3.3333) + "%\n";
		else
			interpersonStats += "<b>Urta Status:</b> Ready To Confess Love\n";
	}
	
	if (interpersonStats != "")
		outputText("\n<b><u>Interpersonal Stats</u></b>\n" + interpersonStats, false);
	// End Interpersonal Stats
	
	// Begin Evangeline Stats
	var evangelineStats:String = "";
	
	if (flags[kFLAGS.EVANGELINE_AFFECTION] > 2) {
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 17) evangelineStats += "<b>Evangeline lvl:</b> 42\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 16) evangelineStats += "<b>Evangeline lvl:</b> 40\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 15) evangelineStats += "<b>Evangeline lvl:</b> 36\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 14) evangelineStats += "<b>Evangeline lvl:</b> 34\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 13) evangelineStats += "<b>Evangeline lvl:</b> 30\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 12) evangelineStats += "<b>Evangeline lvl:</b> 28\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 11) evangelineStats += "<b>Evangeline lvl:</b> 24\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 10) evangelineStats += "<b>Evangeline lvl:</b> 22\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 9) evangelineStats += "<b>Evangeline lvl:</b> 18\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 8) evangelineStats += "<b>Evangeline lvl:</b> 16\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 7) evangelineStats += "<b>Evangeline lvl:</b> 14\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 6) evangelineStats += "<b>Evangeline lvl:</b> 12\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 5) evangelineStats += "<b>Evangeline lvl:</b> 10\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 4) evangelineStats += "<b>Evangeline lvl:</b> 8\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 3) evangelineStats += "<b>Evangeline lvl:</b> 6\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] == 2) evangelineStats += "<b>Evangeline lvl:</b> 4\n";
		if (flags[kFLAGS.EVANGELINE_LVL_UP] < 2) evangelineStats += "<b>Evangeline lvl:</b> 2\n";
		evangelineStats += "<b>Evangeline Affection:</b> " + Math.round(flags[kFLAGS.EVANGELINE_AFFECTION]) + "%\n";
	}
	if (flags[kFLAGS.EVANGELINE_AFFECTION] >= 5) {
		evangelineStats += "<b>Gems Purse:</b> " + flags[kFLAGS.EVANGELINE_GEMS_PURSE] + " gems\n";
		evangelineStats += "<b>Spells Casted:</b> " + flags[kFLAGS.EVANGELINE_SPELLS_CASTED] + "\n";
		if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 0) {
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] < 10) evangelineStats += "<b>Spells Cost:</b> 100%\n";
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 10 && flags[kFLAGS.EVANGELINE_SPELLS_CASTED] < 30) evangelineStats += "<b>Spells Cost:</b> 90%\n";
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 30 && flags[kFLAGS.EVANGELINE_SPELLS_CASTED] < 70) evangelineStats += "<b>Spells Cost:</b> 80%\n";
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 70 && flags[kFLAGS.EVANGELINE_SPELLS_CASTED] < 150) evangelineStats += "<b>Spells Cost:</b> 70%\n";
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 150 && flags[kFLAGS.EVANGELINE_SPELLS_CASTED] < 310) evangelineStats += "<b>Spells Cost:</b> 60%\n";
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 310) evangelineStats += "<b>Spells Cost:</b> 50%\n";
		}
	}
	
	if (evangelineStats != "")
		outputText("\n<b><u>Evangeline Stats</u></b>\n" + evangelineStats, false);
	// End Evangeline Stats
	
	// Begin Ongoing Stat Effects
	var statEffects:String = "";
	
	if (player.inHeat)
		statEffects += "Heat - " + Math.round(player.statusAffectv3(StatusAffects.Heat)) + " hours remaining\n";
		
	if (player.inRut)
		statEffects += "Rut - " + Math.round(player.statusAffectv3(StatusAffects.Rut)) + " hours remaining\n";
		
	if (player.statusAffectv1(StatusAffects.Luststick) > 0)
		statEffects += "Luststick - " + Math.round(player.statusAffectv1(StatusAffects.Luststick)) + " hours remaining\n";
		
	if (player.statusAffectv1(StatusAffects.LustStickApplied) > 0)
		statEffects += "Luststick Application - " + Math.round(player.statusAffectv1(StatusAffects.LustStickApplied)) + " hours remaining\n";
		
	if (player.statusAffectv1(StatusAffects.LustyTongue) > 0)
		statEffects += "Lusty Tongue - " + Math.round(player.statusAffectv1(StatusAffects.LustyTongue)) + " hours remaining\n";
		
	if (player.statusAffectv1(StatusAffects.BlackCatBeer) > 0)
		statEffects += "Black Cat Beer - " + player.statusAffectv1(StatusAffects.BlackCatBeer) + " hours remaining (Lust resistance 20% lower, physical resistance 25% higher.)\n";

	if (player.statusAffectv1(StatusAffects.AndysSmoke) > 0)
		statEffects += "Andy's Pipe Smoke - " + player.statusAffectv1(StatusAffects.AndysSmoke) + " hours remaining (Speed temporarily lowered, intelligence temporarily increased.)\n";
		
	if (player.statusAffectv1(StatusAffects.FeedingEuphoria) > 0)
		statEffects += "Feeding Euphoria - " + player.statusAffectv1(StatusAffects.FeedingEuphoria) + " hours remaining (Speed temporarily increased.)\n";
		
	if (player.statusAffectv1(StatusAffects.IzumisPipeSmoke) > 0) 
		statEffects += "Izumi's Pipe Smoke - " + player.statusAffectv1(StatusAffects.IzumisPipeSmoke) + " hours remaining. (Speed temporarily lowered.)\n";

	if (player.statusAffectv1(StatusAffects.UmasMassage) > 0) 
		statEffects += "Uma's Massage - " + player.statusAffectv3(StatusAffects.UmasMassage) + " hours remaining.\n";
		
	if (player.statusAffectv1(StatusAffects.BathedInHotSpring) > 0) 
		statEffects += "Bathed in Hot Spring - " + player.statusAffectv1(StatusAffects.BathedInHotSpring) + " hours remaining. (Fatigue recovery rate 20% higher)\n";
		
	if (player.statusAffectv1(StatusAffects.Dysfunction) > 0) 
		statEffects += "Dysfunction - " + player.statusAffectv1(StatusAffects.Dysfunction) + " hours remaining. (Disables masturbation)\n";

	if (statEffects != "")
		outputText("\n<b><u>Ongoing Status Effects</u></b>\n" + statEffects, false);
	// End Ongoing Stat Effects
	menu();
	if (player.statPoints > 0) {
		outputText("\n\n<b>You have " + num2Text(player.statPoints) + " attribute point" + (player.statPoints == 1 ? "" : "s") + " to distribute.");
		addButton(1, "Stat Up", attributeMenu);
	}
	doNext(playerMenu);
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
	if(player.statusAffectv1(StatusAffects.BlackCatBeer) > 0) {
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
	if((player.findStatusAffect(StatusAffects.BimboChampagne) >= 0 || player.findPerk(PerkLib.BimboBody) >= 0) && lust > 0) lust *= .75;
	if(player.findPerk(PerkLib.BroBody) >= 0 && lust > 0) lust *= .75;
	if(player.findPerk(PerkLib.FutaForm) >= 0 && lust > 0) lust *= .75;
	//Omnibus' Gift reduces lust gain by 15%
	if(player.findPerk(PerkLib.OmnibusGift) >= 0) lust *= .85;
	//Luststick reduces lust gain by 10% to match increased min lust
	if(player.findPerk(PerkLib.LuststickAdapted) >= 0) lust *= 0.9;
	if(player.findStatusAffect(StatusAffects.Berzerking) >= 0) lust *= .6;
	if (player.findPerk(PerkLib.PureAndLoving) >= 0) lust *= 0.95;
	//Berseking reduces lust gains by 10%
	if(player.findStatusAffect(StatusAffects.Berzerking) >= 0) lust *= 0.9;
	
	//Items
	if (player.jewelryEffectId == JewelryLib.PURITY) lust *= 1 - (player.jewelryEffectMagnitude / 100);
	if (player.armor == armors.DBARMOR) lust *= 0.9;
	if (player.weapon == weapons.HNTCANE) lust *= 0.75;
	if ((player.weapon == weapons.PURITAS) || (player.weapon == weapons.ASCENSU)) lust *= 0.9;
	// Lust mods from Uma's content -- Given the short duration and the gem cost, I think them being multiplicative is justified.
	// Changing them to an additive bonus should be pretty simple (check the static values in UmasShop.as)
	var statIndex:int = player.findStatusAffect(StatusAffects.UmasMassage);
	if (statIndex >= 0)
	{
		if (player.statusAffect(statIndex).value1 == UmasShop.MASSAGE_RELIEF || player.statusAffect(statIndex).value1 == UmasShop.MASSAGE_LUST)
		{
			lust *= player.statusAffect(statIndex).value2;
		}
	}
	
	lust = Math.round(lust);
	if (player.findStatusAffect(StatusAffects.Lustzerking) >= 0 && player.findPerk(PerkLib.ColdLust) < 1) lust = 100;
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
	outputText("Old: "+player.str+" "+player.tou+" "+player.spe+" "+player.inte+" "+player.lib+" "+player.sens+" "+player.lust+"\n",true);
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
 * valid stat_names are "str", "tou", "spe", "int", "lib", "sen", "lus", "cor" or their full names; also "resisted"/"res" (apply lust resistance, default true) and "noBimbo"/"bim" (do not apply bimbo int gain reduction, default false)
 */
public function dynStats(... args):void
{
	// Check num of args, we should have a multiple of 2
	if ((args.length % 2) != 0)
	{
		trace("dynStats aborted. Keys->Arguments could not be matched");
		return;
	}
	
	var argNamesFull:Array 	= 	["strength", "toughness", "speed", "intellect", "libido", "sensitivity", "lust", "corruption", "resisted", "noBimbo"]; // In case somebody uses full arg names etc
	var argNamesShort:Array = 	["str", 	"tou", 	"spe", 	"int", 	"lib", 	"sen", 	"lus", 	"cor", 	"res", 	"bim"]; // Arg names
	var argVals:Array = 		[0, 		0,	 	0, 		0, 		0, 		0, 		0, 		0, 		true, 	false]; // Default arg values
	var argOps:Array = 			["+",	"+",    "+",    "+",    "+",    "+",    "+",    "+",    "=",    "="];   // Default operators
	
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
			
			var argIndex:int = -1;
			
			// Figure out which array to search
			var argsi:String = (args[i] as String);
			if (argsi == "lust") argsi = "lus";
			if (argsi == "sens") argsi = "sen";
			if (argsi == "inte") argsi = "int";
			if (argsi.length <= 4) // Short
			{
				argIndex = argNamesShort.indexOf(argsi.slice(0, 3));
				if (argsi.length == 4 && argIndex != -1) argOps[argIndex] = argsi.charAt(3);
			}
			else // Full
			{
				if ("+-*/=".indexOf(argsi.charAt(argsi.length - 1)) != -1) {
					argIndex = argNamesFull.indexOf(argsi.slice(0, argsi.length - 1));
					if (argIndex != -1) argOps[argIndex] = argsi.charAt(argsi.length - 1);
				} else {
					argIndex = argNamesFull.indexOf(argsi);
				}
			}
			
			if (argIndex == -1) // Shit fucked up, welp
			{
				trace("Couldn't find the arg name " + argsi + " in the index arrays. Welp!");
				continue;
			}
			else // Stuff the value into our "values" array
			{
				argVals[argIndex] = args[i + 1];
			}
		}
		else
		{
			trace("dynStats aborted. Expected a key and got SHIT");
			return;
		}
	}
	// Got this far, we have values to statsify
	var newStr:Number = applyOperator(player.str, argOps[0], argVals[0]);
	var newTou:Number = applyOperator(player.tou, argOps[1], argVals[1]);
	var newSpe:Number = applyOperator(player.spe, argOps[2], argVals[2]);
	var newInte:Number = applyOperator(player.inte, argOps[3], argVals[3]);
	var newLib:Number = applyOperator(player.lib, argOps[4], argVals[4]);
	var newSens:Number = applyOperator(player.sens, argOps[5], argVals[5]);
	var newLust:Number = applyOperator(player.lust, argOps[6], argVals[6]);
	var newCor:Number = applyOperator(player.cor, argOps[7], argVals[7]);
	// Because lots of checks and mods are made in the stats(), calculate deltas and pass them. However, this means that the '=' operator could be resisted
	// In future (as I believe) stats() should be replaced with dynStats(), and checks and mods should be made here
	stats(newStr - player.str,
		  newTou - player.tou,
		  newSpe - player.spe,
		  newInte - player.inte,
		  newLib - player.lib,
		  newSens - player.sens,
		  newLust - player.lust,
		  newCor - player.cor,
		  argVals[8],argVals[9]);
	
}

public function stats(stre:Number, toug:Number, spee:Number, intel:Number, libi:Number, sens:Number, lust2:Number, corr:Number, resisted:Boolean = true, noBimbo:Boolean = false):void
{
	//Easy mode cuts lust gains!
	if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 1 && lust2 > 0 && resisted) lust2 /= 2;
	
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
			if(intel > 0) intel /= 2;
			if(intel < 0) intel *= 2;
		}
		if(player.findPerk(PerkLib.FutaForm) >= 0 || player.findPerk(PerkLib.BimboBody) >= 0  || player.findPerk(PerkLib.BroBody) >= 0) {
			if(libi > 0) libi *= 2;
			if(libi < 0) libi /= 2;
		}
	}
	
	// Uma's Perkshit
	if (player.findPerk(PerkLib.ChiReflowSpeed)>=0 && spee < 0) spee *= UmasShop.NEEDLEWORK_SPEED_SPEED_MULTI;
	if (player.findPerk(PerkLib.ChiReflowLust)>=0 && libi > 0) libi *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
	if (player.findPerk(PerkLib.ChiReflowLust)>=0 && sens > 0) sens *= UmasShop.NEEDLEWORK_LUST_LIBSENSE_MULTI;
	
	//Apply lust changes in NG+.
	if (resisted) lust2 *= 1 + (player.newGamePlusMod() * 0.2);
	
	//lust resistance
	if(lust2 > 0 && resisted) lust2 *= lustPercent()/100;
	if(libi > 0 && player.findPerk(PerkLib.PurityBlessing) >= 0) libi *= 0.75;
	if(corr > 0 && player.findPerk(PerkLib.PurityBlessing) >= 0) corr *= 0.5;
	if(corr > 0 && player.findPerk(PerkLib.PureAndLoving) >= 0) corr *= 0.75;
	if (corr > 0 && player.weapon == weapons.HNTCANE) corr *= 0.5;
	if (player.findPerk(PerkLib.AscensionMoralShifter) >= 0) corr *= 1 + (player.perkv1(PerkLib.AscensionMoralShifter) * 0.2);
	//Change original stats
	player.str+=stre;
	player.tou+=toug;
	player.spe+=spee;
	player.inte+=intel;
	player.lib+=libi;
	
	if(player.sens > 50 && sens > 0) sens/=2;
	if(player.sens > 75 && sens > 0) sens/=2;
	if(player.sens > 90 && sens > 0) sens/=2;
	if(player.sens > 50 && sens < 0) sens*=2;
	if(player.sens > 75 && sens < 0) sens*=2;
	if(player.sens > 90 && sens < 0) sens*=2;
	
	player.sens+=sens;
	player.lust+=lust2;
	player.cor += corr;
	
	//Bonus gain for perks!
	if(player.findPerk(PerkLib.Strong) >= 0 && stre >= 0) player.str+=stre*player.perk(player.findPerk(PerkLib.Strong)).value1;
	if(player.findPerk(PerkLib.Tough) >= 0 && toug >= 0) player.tou+=toug*player.perk(player.findPerk(PerkLib.Tough)).value1;
	if(player.findPerk(PerkLib.Fast) >= 0 && spee >= 0) player.spe+=spee*player.perk(player.findPerk(PerkLib.Fast)).value1;
	if(player.findPerk(PerkLib.Smart) >= 0 && intel >= 0) player.inte+=intel*player.perk(player.findPerk(PerkLib.Smart)).value1;
	if(player.findPerk(PerkLib.Lusty) >= 0 && libi >= 0) player.lib+=libi*player.perk(player.findPerk(PerkLib.Lusty)).value1;
	if (player.findPerk(PerkLib.Sensitive) >= 0 && sens >= 0) player.sens += sens * player.perk(player.findPerk(PerkLib.Sensitive)).value1;

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
	if(player.str > player.getMaxStats("str")) player.str = player.getMaxStats("str");
	if(player.str < 1) player.str = 1;
	if(player.tou > player.getMaxStats("tou")) player.tou = player.getMaxStats("tou");
	if(player.tou < 1) player.tou = 1;
	if(player.spe > player.getMaxStats("spe")) player.spe = player.getMaxStats("spe");
	if(player.spe < 1) player.spe = 1;
	if(player.inte > player.getMaxStats("inte")) player.inte = player.getMaxStats("inte");
	if(player.inte < 1) player.inte = 1;
	if(player.wis > player.getMaxStats("wis")) player.wis = player.getMaxStats("wis");
	if(player.wis < 1) player.wis = 1;
	if(player.lib > player.getMaxStats("lib")) player.lib = player.getMaxStats("lib");
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
	HPChange(toug*2, false);
	//if (player.tou < 20) HPChange(toug*2, false);
	//else if (player.tou >= 20 && player.tou < 40) HPChange(toug*3, false);
	//else if (player.tou >= 40 && player.tou < 60) HPChange(toug*4, false);
	//else if (player.tou >= 60 && player.tou < 80) HPChange(toug*5, false);
	//else if (player.tou >= 80) HPChange(toug * 6, false);
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
	function _oldStatNameFor(statName:String):String {
		return 'old' + statName.charAt(0).toUpperCase() + statName.substr(1);
	}

	var statName:String,
		oldStatName:String,
		allStats:Array;

	mainView.statsView.upDownsContainer.visible = true;

//	allStats = ["str", "tou", "spe", "inte", "wis" "lib", "sens", "cor", "HP", "lust", "wraith", "fatigue", "soulforce", "hunger"];
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
		if(display) outputText("\nYour " + vaginaDescript(vIndex) + " loses its virginity!", false);
		player.vaginas[vIndex].virgin = false;
	}        
	//If cock is bigger than unmodified vagina can hold - 100% stretch!
	if(player.vaginas[vIndex].capacity() <= monster.cocks[cIndex].cArea()) {
		if(player.vaginas[vIndex] < 5) {
			trace("CUNT STRETCHED: By cock larger than it's total capacity.");
			if(display) {
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE) outputText("<b>Your " + vaginaDescript(0) + " is stretched even further, capable of taking even the largest of demons and beasts.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_GAPING) outputText("<b>Your " + vaginaDescript(0) + " painfully stretches, gaping wide-open.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_LOOSE) outputText("<b>Your " + vaginaDescript(0) + " is now very loose.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_NORMAL) outputText("<b>Your " + vaginaDescript(0) + " is now loose.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_TIGHT) outputText("<b>Your " + vaginaDescript(0) + " loses its virgin-like tightness.</b>  ", false);
			}
			player.vaginas[vIndex].vaginalLooseness++;
		}
	}
	//If cock is within 75% of max, streeeeetch 33% of the time
	if(player.vaginas[vIndex].capacity() * .75 <= monster.cocks[cIndex].cArea()) {
		if(player.vaginas[vIndex] < 5) {
			trace("CUNT STRETCHED: By cock @ 75% of capacity.");
			if(display) {
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE) outputText("<b>Your " + vaginaDescript(0) + " is stretched even further, capable of taking even the largest of demons and beasts.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_GAPING) outputText("<b>Your " + vaginaDescript(0) + " painfully stretches, gaping wide-open.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_LOOSE) outputText("<b>Your " + vaginaDescript(0) + " is now very loose.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_NORMAL) outputText("<b>Your " + vaginaDescript(0) + " is now loose.</b>  ", false);
				if(player.vaginas[vIndex].vaginalLooseness == VAGINA_LOOSENESS_TIGHT) outputText("<b>Your " + vaginaDescript(0) + " loses its virgin-like tightness.</b>  ", false);
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

public function spriteSelect(choice:Number = 0):void {
	var type:int = flags[kFLAGS.SPRITE_STYLE]; //0 for new, 1 for old.
	if (flags[kFLAGS.SHOW_SPRITES_FLAG] == 0)
	{
		mainView.selectSprite(choice, type);
	}
	else
	{
		if (choice >= 0)
		{
			trace ("hiding sprite because flags");
			mainView.selectSprite(-1);
		}
	}
}
