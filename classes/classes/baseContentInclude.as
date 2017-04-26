import classes.*;
import classes.GlobalFlags.kGAMECLASS;
import classes.Items.*;
import classes.Scenes.*;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Dungeons.D3.D3;
import classes.Scenes.Places.*;
import classes.internals.Utils;

import coc.model.GameModel;
import coc.model.TimeModel;
import coc.view.MainView;

include "../../includes/appearanceDefs.as";

// curryFunction(f,args1)(args2)=f(args1.concat(args2))
// e.g. curryFunction(f,x,y)(z,w) = f(x,y,z,w)
protected function curry(func:Function,...args):Function {
	return Utils.curry.apply(null,[func,args]);
}

protected function formatStringArray(stringList:Array): String {
	return Utils.formatStringArray(stringList);
}

protected function num2Text(number:int): String {
	return Utils.num2Text(number);
}

protected function num2Text2(number:int): String {
	return Utils.num2Text2(number);
}

protected function Num2Text(number:int): String {
	return Utils.Num2Text(number);
}

protected function addComma(num:int): String {
	return Utils.addComma(num);
}

protected function capitalizeFirstLetter(string:String): String {
	return Utils.capitalizeFirstLetter(string);
}

protected function randomChoice(...args): * {
	return Utils.randomChoice.apply(null,[args]);
}

protected function InCollection(tar:*, ... args):Boolean{
	return Utils.InCollection.apply(null,[tar,args]);
}

protected function rand(max:Number): Number {
	return Utils.rand(max);
}

protected function validateNonNegativeNumberFields(o:Object, func:String, nnf:Array): String {
	return Utils.validateNonNegativeNumberFields(o, func, nnf);
}

protected function validateNonEmptyStringFields(o:Object, func:String, nef:Array): String {
	return Utils.validateNonEmptyStringFields(o, func, nef);
}

protected function numberOfThings(n:int, name:String, pluralForm:String = null): String {
	return Utils.numberOfThings(n, name, pluralForm);
}

protected function getGame():CoC {
	return kGAMECLASS;
}

protected function cheatTime(time:Number, needNext:Boolean = false):void {
	kGAMECLASS.cheatTime(time, needNext);
}

protected function get output():Output {
	return kGAMECLASS.output;
}

protected function get measurements():Measurements {
	return kGAMECLASS.measurements;
}

protected function get timeQ():Number {
	return kGAMECLASS.timeQ;
}

protected function get camp():Camp {
	return kGAMECLASS.camp;
}

protected function get ingnam():Ingnam {
	return kGAMECLASS.ingnam;
}

protected function get prison():Prison {
	return kGAMECLASS.prison;
}

protected function get d3():D3 {
	return kGAMECLASS.d3;
}

protected function get combat():Combat {
	return kGAMECLASS.combat;
}

protected function get mutations():Mutations {
	return kGAMECLASS.mutations;
}

public function goNext(time:Number, defNext:Boolean):Boolean {
	return kGAMECLASS.goNext(time, defNext);
}

protected function awardAchievement(title:String, achievement:*, display:Boolean = true, nl:Boolean = false, nl2:Boolean = true):void {
	return kGAMECLASS.awardAchievement(title, achievement, display, nl, nl2);
}

//SEASONAL EVENTS!
protected function isHalloween():Boolean {
	return kGAMECLASS.fera.isItHalloween();
}

protected function isValentine():Boolean {
	return kGAMECLASS.valentines.isItValentine();
}

protected function isHolidays():Boolean {
	return kGAMECLASS.xmas.isItHolidays();
}

protected function isEaster():Boolean {
	return kGAMECLASS.plains.bunnyGirl.isItEaster();
}

protected function isThanksgiving():Boolean {
	return kGAMECLASS.thanksgiving.isItThanksgiving();
}

protected function isAprilFools():Boolean {
	return kGAMECLASS.aprilFools.isItAprilFools();
}

protected function get date():Date {
	return kGAMECLASS.date;
}

//Curse you, CoC updates!
protected function get inDungeon():Boolean {
	return kGAMECLASS.inDungeon;
}

protected function get inRoomedDungeon():Boolean {
	return kGAMECLASS.inRoomedDungeon;
}

protected function get inRoomedDungeonResume():Function {
	return kGAMECLASS.inRoomedDungeonResume;
}

protected function spriteSelect(choice:Number = 0):void {
	kGAMECLASS.spriteSelect(choice);
}

protected function statScreenRefresh():void {
	kGAMECLASS.statScreenRefresh();
}

protected function showStats():void {
	kGAMECLASS.showStats();
}

/** Hide the stats panel. */
protected function hideStats():void {
	kGAMECLASS.hideStats();
}

/** Hide the up/down arrows. */
protected function hideUpDown():void {
	kGAMECLASS.hideUpDown();
}

/** Create a function that will pass one argument. */
protected function createCallBackFunction(func:Function, arg:*):Function {
	return kGAMECLASS.createCallBackFunction(func, arg);
}

protected function doSFWloss():Boolean {
	return kGAMECLASS.doSFWloss();
}

protected function isPeaceful():Boolean {
	return kGAMECLASS.isPeaceful();
}

protected function startCombat(monster_:Monster, plotFight_:Boolean = false):void {
	kGAMECLASS.combat.beginCombat(monster_, plotFight_);
}

protected function startCombatImmediate(monster:Monster, _plotFight:Boolean = false):void {
	kGAMECLASS.combat.beginCombatImmediate(monster, _plotFight);
}

protected function displayHeader(text:String):void {
	kGAMECLASS.displayHeader(text);
}

protected function rawOutputText(output:String, purgeText:Boolean = false):void {
	kGAMECLASS.rawOutputText(output, purgeText);
}

protected function outputText(output:String, purgeText:Boolean = false, parseAsMarkdown:Boolean = false):void {
	kGAMECLASS.outputText(output, purgeText, parseAsMarkdown);
}

protected function clearOutput():void {
	kGAMECLASS.currentText = "";
	kGAMECLASS.mainView.clearOutputText();
}

protected function doNext(eventNo:Function):void //Now typesafe
{
	kGAMECLASS.doNext(eventNo);
}

protected function menu():void {
	kGAMECLASS.menu();
}

protected function hideMenus():void {
	kGAMECLASS.hideMenus();
}

[Deprecated(replacement="Use a series of BaseContent.addButton instead.")]
/**[DEPRECATED] Creates a menu with 10 buttons.
 */
protected function choices(text1:String, butt1:Function,
						   text2:String, butt2:Function,
						   text3:String, butt3:Function,
						   text4:String, butt4:Function,
						   text5:String, butt5:Function,
						   text6:String, butt6:Function,
						   text7:String, butt7:Function,
						   text8:String, butt8:Function,
						   text9:String, butt9:Function,
						   text0:String, butt0:Function):void { //Now typesafe
	kGAMECLASS.choices(
			text1, butt1,
			text2, butt2,
			text3, butt3,
			text4, butt4,
			text5, butt5,
			text6, butt6,
			text7, butt7,
			text8, butt8,
			text9, butt9,
			text0, butt0
	);
}
[Deprecated(replacement="Use menu() + series of addButton instead.")]
/**[DEPRECATED] Creates a menu with 5 buttons.
 */
protected function simpleChoices(text1:String, butt1:Function,
								 text2:String, butt2:Function,
								 text3:String, butt3:Function,
								 text4:String, butt4:Function,
								 text5:String, butt5:Function):void { //Now typesafe
	kGAMECLASS.simpleChoices(text1, butt1,
			text2, butt2,
			text3, butt3,
			text4, butt4,
			text5, butt5);
}

protected function doYesNo(eventYes:Function, eventNo:Function):void { //Now typesafe
	kGAMECLASS.doYesNo(eventYes, eventNo);
}

protected function addButton(pos:int, text:String = "", func1:Function = null, arg1:* = -9000, arg2:* = -9000, arg3:* = -9000, toolTipText:String = "", toolTipHeader:String = ""):void {
	kGAMECLASS.addButton(pos, text, func1, arg1, arg2, arg3, toolTipText, toolTipHeader);
}

protected function addButtonDisabled(pos:int, text:String = "", toolTipText:String = "", toolTipHeader:String = ""):void {
	kGAMECLASS.addButtonDisabled(pos, text, toolTipText, toolTipHeader);
}

protected function removeButton(arg:*):void {
	kGAMECLASS.removeButton(arg);
}

protected function hasButton(arg:*):Boolean {
	return kGAMECLASS.hasButton(arg);
}

protected function openURL(url:String):void {
	return kGAMECLASS.openURL(url);
}

/**
 * Apply statmods to the player. dynStats wraps the regular stats call, but supports "named" arguments of the form:
 *        "statname", value.
 * Exclusively supports either long or short stat names with a single call.
 * "str", "lib" "lus", "cor" etc
 * "strength, "libido", lust", "corruption"
 * Specify the stat you wish to modify and follow it with the value.
 * Separate each stat and value with a comma, and each stat/value pair, again, with a comma.
 * eg: dynStats("str", 10, "lust" -100); will add 10 to str and subtract 100 from lust
 * Also support operators could be appended with + - * /=
 * eg: dynStats("str+", 1, "tou-", 2, "spe*", 1.1, "int/", 2, "cor=", 0)
 *     will add 1 to str, subtract 2 from tou, increase spe by 10%, decrease int by 50%, and set cor to 0
 *
 * @param    ... args
 */
protected function dynStats(...args):void {
	// Bullshit to unroll the incoming array
	kGAMECLASS.dynStats.apply(null, args);
}

protected function silly():Boolean {
	return kGAMECLASS.silly();
}

protected function HPChange(changeNum:Number, display:Boolean):void {
	kGAMECLASS.HPChange(changeNum, display);
}

protected function playerMenu():void {
	kGAMECLASS.playerMenu();
}

protected function get player():Player {
	return kGAMECLASS.player;
}

protected function get debug():Boolean {
	return kGAMECLASS.debug;
}

protected function get ver():String {
	return kGAMECLASS.ver;
}

protected function get images():ImageManager {
	return kGAMECLASS.images;
}

protected function get monster():Monster {
	return kGAMECLASS.monster;
}

protected function get consumables():ConsumableLib {
	return kGAMECLASS.consumables;
}

protected function get useables():UseableLib {
	return kGAMECLASS.useables;
}

protected function get weapons():WeaponLib {
	return kGAMECLASS.weapons;
}

protected function get armors():ArmorLib {
	return kGAMECLASS.armors;
}

protected function get jewelries():JewelryLib {
	return kGAMECLASS.jewelries;
}

protected function get shields():ShieldLib {
	return kGAMECLASS.shields;
}

protected function get undergarments():UndergarmentLib {
	return kGAMECLASS.undergarments;
}

protected function get inventory():Inventory {
	return kGAMECLASS.inventory;
}

protected function get time():TimeModel {
	return kGAMECLASS.time;
}

protected function get temp():int {
	return kGAMECLASS.temp;
}

protected function get args():Array {
	return kGAMECLASS.args;
}

protected function get funcs():Array {
	return kGAMECLASS.funcs;
}

protected function get mainView():MainView {
	return kGAMECLASS.mainView;
}

protected function get model():GameModel {
	return kGAMECLASS.model;
}

protected function get flags():DefaultDict {
	return kGAMECLASS.flags;
}

protected function get achievements():DefaultDict {
	return kGAMECLASS.achievements;
}

protected function showStatDown(arg:String):void {
	kGAMECLASS.mainView.statsView.showStatDown(arg);
}

protected function showStatUp(arg:String):void {
	kGAMECLASS.mainView.statsView.showStatUp(arg);
}

protected function buttonTextIsOneOf(index:int, possibleLabels:Array):Boolean {
	return kGAMECLASS.buttonTextIsOneOf(index, possibleLabels);
}

protected function getButtonText(index:int):String {
	return kGAMECLASS.getButtonText(index);
}

protected function buttonIsVisible(index:int):Boolean {
	return kGAMECLASS.buttonIsVisible(index);
}