package classes 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.*;
	import classes.Scenes.Camp;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Places.Ingnam;
	import classes.Scenes.Places.Prison;
	import classes.Scenes.Dungeons.D3.D3;
	import classes.Scenes.Inventory;
import classes.internals.RootCounters;
import classes.internals.Utils;

	import coc.model.GameModel;
	import coc.model.TimeModel;
import coc.view.CoCButton;
import coc.view.MainView;
import coc.xxc.StoryContext;

/**
	 * Quick hacky method to wrap new content in a class-based structure
	 * BaseContent acts as an access wrapper around CoC, enabling children of BaseContent to interact with
	 * function instances/properties of CoC in the same manner older content does with the minimal amount
	 * of modification.
	 * Also this means we might start being able to get IDE autocomplete shit working again! Huzzah!
	 * @author Gedan
	 */
	public class BaseContent extends Utils
	{
		// TODO remove when we have proper enums for this
		include "../../includes/appearanceDefs.as";

		public function BaseContent()
		{
			
		}
		protected function getGame():CoC
		{
			return kGAMECLASS;
		}

		protected function cheatTime(time:Number, needNext:Boolean = false):void
		{
			kGAMECLASS.cheatTime(time, needNext);
		}
		/*protected function incrementDay(time:Number):void
		{
			kGAMECLASS.incrementDay(time);
		}*/
		protected function get timeQ():Number
		{
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

		public function goNext(time:Number,defNext:Boolean):Boolean
		{
			return kGAMECLASS.goNext(time,defNext);
		}
		
		protected function awardAchievement(title:String, achievement:*, display:Boolean = true, nl:Boolean = false, nl2:Boolean = true):void
		{
			return kGAMECLASS.awardAchievement(title, achievement, display, nl, nl2);
		}
		
		protected function isHalloween():Boolean
		{
			return kGAMECLASS.isHalloween();
		}

		protected function isValentine():Boolean
		{
			return kGAMECLASS.isValentine();
		}

		protected function isHolidays():Boolean
		{
			return kGAMECLASS.isHolidays();
		}

		public function isEaster():Boolean
		{
			return kGAMECLASS.isEaster();
		}

		protected function isThanksgiving():Boolean
		{
			return kGAMECLASS.isThanksgiving();
		}

		protected function isAprilFools():Boolean
		{
			return kGAMECLASS.isAprilFools();
		}
		
		protected function get date():Date
		{
			return kGAMECLASS.date;
		}

/*
		protected function inCombat():Boolean
		{
			return kGAMECLASS.inCombat();
		}
*/
		//Curse you, CoC updates!
		protected function get inDungeon():Boolean
		{
			return kGAMECLASS.inDungeon;
		}
/* inDungeon is now read only
		protected function set inDungeon(v:Boolean):void
		{
			kGAMECLASS.inDungeon = v;
		}
*/
		
		protected function get inRoomedDungeon():Boolean
		{
			return kGAMECLASS.inRoomedDungeon;
		}
		protected function set inRoomedDungeon(v:Boolean):void
		{
			kGAMECLASS.inRoomedDungeon = v;
		}
		
		protected function get inRoomedDungeonResume():Function
		{
			return kGAMECLASS.inRoomedDungeonResume;
		}
		protected function set inRoomedDungeonResume(v:Function):void
		{
			kGAMECLASS.inRoomedDungeonResume = v;
		}
		
/*
		protected function get itemSubMenu():Boolean
		{
			return kGAMECLASS.itemSubMenu;
		}
		protected function set itemSubMenu(value:Boolean):void
		{
			kGAMECLASS.itemSubMenu = value;
		}
*/
		
		protected function showStats():void
		{
			kGAMECLASS.showStats();
		}

		protected function statScreenRefresh():void
		{
			kGAMECLASS.statScreenRefresh();
		}

		protected function get combat():Combat {
			return kGAMECLASS.combat;
		}

		protected function cleanupAfterCombat(nextFunc:Function = null):void
		{
			kGAMECLASS.combat.cleanupAfterCombatImpl(nextFunc);
		}

		protected function combatRoundOver():Boolean
		{
			return kGAMECLASS.combat.combatRoundOverImpl();
		}

		protected function enemyAI():void
		{
			kGAMECLASS.combat.enemyAIImpl();
		}

		protected function clearStatuses(visibility: Boolean):void
		{
			player.clearStatuses(visibility);
		}

		protected function spriteSelect(choice:Number = 0):void
		{
			kGAMECLASS.spriteSelect(choice);
		}

		protected function hideStats():void
		{
			kGAMECLASS.hideStats();
		}
		protected function hideUpDown():void
		{
			kGAMECLASS.hideUpDown();
		}

		/* This class extends Utils, no need for a non-static version of this function
		protected function curry(func:Function,...args):Function
		{
			return Utils.curry.apply(null,[func].concat(args));
		}
		*/
		
		/* None of these functions are called anymore
		protected function lazyIndex(obj:*,...args):Function
		{
			return Utils.lazyIndex.apply(null,[obj].concat(args));
		}
		protected function lazyCallIndex(func:Function,...args):Function
		{
			return Utils.lazyCallIndex.apply(null,[func].concat(args));
		}
		protected function lazyCallIndexCall(func:Function,...args):Function
		{
			return Utils.lazyCallIndexCall.apply(null,[func].concat(args));
		}
		*/

		protected function createCallBackFunction(func:Function, arg:*):Function
		{
			return kGAMECLASS.createCallBackFunction(func,arg);
		}

		protected function createCallBackFunction2(func:Function, ...args):Function
		{
			return kGAMECLASS.createCallBackFunction2.apply(null,[func].concat(args));
		}

		protected function startCombat(monster_:Monster,plotFight_:Boolean=false):void{
			kGAMECLASS.combat.startCombatImpl(monster_,plotFight_);
		}

		protected function doSFWloss():Boolean {
			return kGAMECLASS.doSFWloss();
		}
		
		
		protected function startCombatImmediate(monster:Monster, _plotFight:Boolean = false):void
		{
			kGAMECLASS.combat.startCombatImmediateImpl(monster, _plotFight);
		}

		// Needed in a few rare cases for dumping text coming from a source that can't properly escape it's brackets
		// (Mostly traceback printing, etc...)
		protected function rawOutputText(output:String, purgeText:Boolean = false):void
		{
			kGAMECLASS.rawOutputText(output, purgeText);
		}

		protected function outputText(output:String):void
		{
			kGAMECLASS.outputText(output);
		}
		
		protected function clearOutput():void
		{
			kGAMECLASS.clearOutputTextOnly();
		}
		protected function displayHeader(string:String):void
		{
			kGAMECLASS.displayHeader(string);
		}
		
		protected function flushOutputTextToGUI():void {
			kGAMECLASS.flushOutputTextToGUI();
		}

		protected function doNext(eventNo:Function):void //Now typesafe
		{
			kGAMECLASS.doNext(eventNo);
		}
		
		protected function menu():void
		{
			kGAMECLASS.menu();
		}

		protected function hideMenus():void
		{
			kGAMECLASS.hideMenus();
		}
		
		//To be phased out
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

		//To be phased out
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

		protected function addButton(pos:int, text:String = "", func1:Function = null, arg1:* = -9000, arg2:* = -9000, arg3:* = -9000, toolTipText:String = "", toolTipHeader:String = ""):CoCButton
		{
			return kGAMECLASS.addButton(pos, text, func1, arg1, arg2, arg3, toolTipText, toolTipHeader);
		}
		
		protected function addButtonDisabled(pos:int, text:String = "", toolTipText:String = "", toolTipHeader:String = ""):CoCButton
		{
			return kGAMECLASS.addButtonDisabled(pos, text, toolTipText, toolTipHeader);
		}
		protected function button(pos:int):CoCButton
		{
			return kGAMECLASS.button(pos);
		}
		
		protected function removeButton(arg:*):void
		{
			kGAMECLASS.removeButton(arg);
		}

		protected function hasButton(arg:*):Boolean
		{
			return kGAMECLASS.hasButton(arg);
		}

/* Replaced by Utils.formatStringArray, which does almost the same thing in one function
		protected function clearList():void{
			kGAMECLASS.clearList();
		}

		protected function addToList(arg:*):void{
			kGAMECLASS.addToList(arg);
		}

		protected function outputList():String{
			return kGAMECLASS.outputList();
		}
*/
		
		protected function openURL(url:String):void{
			return kGAMECLASS.openURL(url);
		}
		
		protected function sackDescript():String
		{
			return Appearance.sackDescript(player);
		}
		
		protected function cockClit(value:int = 0):String
		{
			return kGAMECLASS.cockClit(value);
		}
		
/* Was only used in Scylla's code. Replaced with conditionals
		protected function balls(balls:*, noBalls:*):String
		{
			return kGAMECLASS.balls(balls, noBalls);
		}
*/
		
		protected function sheathDesc():String
		{
			return kGAMECLASS.player.sheathDescription();
		}
		
		protected function chestDesc():String
		{
			return player.chestDesc();
			//return Appearance.chestDesc(player);
		}
		
		protected function allChestDesc():String
		{
			return player.allChestDesc();
		}
		
		protected function allBreastsDescript():String
		{
			return kGAMECLASS.allBreastsDescript();
		}
		
		protected function sMultiCockDesc():String
		{
			return kGAMECLASS.player.sMultiCockDesc();
		}
		
		protected function SMultiCockDesc():String
		{
			return kGAMECLASS.player.SMultiCockDesc();
		}
		
		protected function oMultiCockDesc():String
		{
			return kGAMECLASS.player.oMultiCockDesc();
		}
		
		protected function OMultiCockDesc():String
		{
			return kGAMECLASS.player.OMultiCockDesc();
		}
		
		protected function tongueDescript():String
		{
			return kGAMECLASS.tongueDescript();
		}
		
		protected function ballsDescriptLight(forcedSize:Boolean = true):String {
			return kGAMECLASS.ballsDescriptLight(forcedSize);
		}

		protected function ballDescript():String {
			return kGAMECLASS.ballDescript();
		}

		/* All calls changed to monster.ballsDescriptLight
		protected function eBallsDescriptLight():String {
			return kGAMECLASS.eBallsDescriptLight();
		}
		*/
		
		/* Was never called
		protected function eBallsDescript():String {
			return kGAMECLASS.eBallsDescript();
		}
		*/

		protected function ballsDescript():String {
			return kGAMECLASS.ballsDescript();
		}
		
		protected function simpleBallsDescript():String {
			return kGAMECLASS.simpleBallsDescript();
		}

		protected function assholeDescript():String {
			return kGAMECLASS.assholeDescript();
		}
		
		protected function eAssholeDescript():String {
			return Appearance.assholeDescript(monster);
		}
				
		protected function hipDescript():String {
			return kGAMECLASS.hipDescript();
		}
		
		protected function assDescript():String {
			return kGAMECLASS.assDescript();
		}
		
		protected  function buttDescript():String {
			return kGAMECLASS.buttDescript();
		}

		protected function assholeOrPussy():String {
			return Appearance.assholeOrPussy(player);
		}

/* Replaced by calls to Appearance.breastDescript
		protected function npcBreastDescript(size:Number):String {
			return kGAMECLASS.npcBreastDescript(size);
		}
*/
/* Was never used
		protected  function eButtDescript():String {
			return Appearance.buttDescriptionShort(monster);
		}
*/
/* Now in Utils.as
		protected function num2TextBest(number:int, capitalised:Boolean = false, positional:Boolean = false):String
		{
			return kGAMECLASS.num2TextBest(number, capitalised, positional);
		}
		
		protected function num2Text(number:int):String
		{
			return kGAMECLASS.num2Text(number);
		}
		protected function Num2Text(number:int):String
		{
			return kGAMECLASS.Num2Text(number);
		}
		protected  function num2Text2(number:int):String
		{
			return kGAMECLASS.num2Text2(number);
		}
*/
		
		protected function nippleDescript(rowNum:Number):String
		{
			return kGAMECLASS.nippleDescript(rowNum);
		}
		
		protected function cockDescript(cockNum:int = 0):String
		{
			return kGAMECLASS.player.cockDescript(cockNum);
		}
		
/*
		protected function cockAdjective(cockNum:Number = -1):String
		{
			return kGAMECLASS.cockAdjective(cockNum);
		}
*/
		
		protected function multiCockDescript():String
		{
			return kGAMECLASS.player.multiCockDescript();
		}
		
		protected function multiCockDescriptLight():String
		{
			return kGAMECLASS.player.multiCockDescriptLight();
		}
		
/*
		protected function eMultiCockDescriptLight():String
		{
			return kGAMECLASS.eMultiCockDescriptLight();
		}
		
		protected function eCockHead(cockNum:Number = 0):String
		{
			return kGAMECLASS.eCockHead(cockNum);
		}
		
		protected function eCockDescript(cockIndex:Number = 0):String
		{
			return kGAMECLASS.eCockDescript(cockIndex);
		}
*/
		
		protected function breastDescript(rowNum:Number):String
		{
			return player.breastDescript(rowNum);
		}
		
/*
		protected function cockHead(cockNum:Number = 0):String
		{
			return kGAMECLASS.cockHead(cockNum);
		}
*/
		
		protected function breastSize(val:Number):String
		{
			return Appearance.breastSize(val);
		}
		
		protected function biggestBreastSizeDescript():String
		{
			return Appearance.biggestBreastSizeDescript(player);
		}
		
		protected function hairDescript():String
		{
			return kGAMECLASS.hairDescript();
		}
		
		protected function beardDescript():String
		{
			return kGAMECLASS.beardDescript();
		}
		
		protected function hairOrFur():String
		{
			return kGAMECLASS.hairOrFur();
		}
		
		protected function clitDescript():String
		{
			return kGAMECLASS.clitDescript();
		}
		
		protected function vaginaDescript(vaginaNum:Number = 0):String
		{
			return kGAMECLASS.vaginaDescript(vaginaNum);
		}
		
		protected function allVaginaDescript():String
		{
			return kGAMECLASS.allVaginaDescript();
		}
		
/* Now called directly
		protected function breastCup(val:Number):String
		{
			return Appearance.breastCup(val);
		}
*/
		
/* Replaced with calls to Appearance.cockDescription
		protected function NPCCockDescript(cockType:*,cockLength:Number=0,lust:Number=50):String
		{
			return kGAMECLASS.NPCCockDescript(cockType,cockLength,lust);
		}
*/
		
		/**
		 * Apply statmods to the player. dynStats wraps the regular stats call, but supports "named" arguments of the form:
		 * 		"statname", value.
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
		 * @param	... args
		 */
		protected function dynStats(... args):void
		{
			// Bullshit to unroll the incoming array
			kGAMECLASS.dynStats.apply(null, args);
		}

		protected function silly():Boolean
		{
			return kGAMECLASS.silly();
		}

		protected function HPChange(changeNum:Number,display:Boolean):void
		{
			kGAMECLASS.HPChange(changeNum,display);
		}

		protected function fatigue(mod:Number,type:Number=0):void {
			kGAMECLASS.fatigue(mod, type);
		}

		protected function useMana(mod:Number,type:Number=0):void
		{
			kGAMECLASS.combat.useManaImpl(mod,type);
		}


/*
		protected function get eventParser():Function
		{
			return kGAMECLASS.eventParser;
		}
*/
		
		protected function playerMenu():void { kGAMECLASS.playerMenu(); }
		
		protected function get player():Player
		{
			return kGAMECLASS.player;
		}
		
		protected function set player(val:Player):void
		{
			kGAMECLASS.player = val;
		}
		
		protected function get player2():Player
		{
			return kGAMECLASS.player2;
		}
		
		protected function set player2(val:Player):void
		{
			kGAMECLASS.player2 = val;
		}
		
		protected function get debug():Boolean
		{
			return kGAMECLASS.debug;
		}
		
		protected function set debug(val:Boolean):void
		{
			kGAMECLASS.debug = val;
		}
		
		protected function get ver():String
		{
			return kGAMECLASS.ver;
		}
		
		protected function set ver(val:String):void
		{
			kGAMECLASS.ver = val;
		}
		
		protected function get images():ImageManager
		{
			return kGAMECLASS.images;
		}
		
		protected function set images(val:ImageManager):void
		{
			kGAMECLASS.images = val;
		}
		
		protected function get monster():Monster
		{
			return kGAMECLASS.monster;
		}
		
		protected function set monster(val:Monster):void
		{
			kGAMECLASS.monster = val;
		}

		protected function get consumables():ConsumableLib{
			return kGAMECLASS.consumables;
		}
		protected function get useables():UseableLib{
			return kGAMECLASS.useables;
		}
		protected function get weapons():WeaponLib{
			return kGAMECLASS.weapons;
		}
		protected function get weaponsrange():WeaponRangeLib{
			return kGAMECLASS.weaponsrange;
		}
		protected function get armors():ArmorLib{
			return kGAMECLASS.armors;
		}
		protected function get jewelries():JewelryLib{
			return kGAMECLASS.jewelries;
		}
		protected function get shields():ShieldLib{
			return kGAMECLASS.shields;
		}
		protected function get undergarments():UndergarmentLib{
			return kGAMECLASS.undergarments;
		}
		protected function get inventory():Inventory{
			return kGAMECLASS.inventory;
		}

/* No longer used
		protected function get itemSwapping():Boolean
		{
			return kGAMECLASS.itemSwapping;
		}
		
		protected function set itemSwapping(val:Boolean):void
		{
			kGAMECLASS.itemSwapping = val;
		}
*/
		
		protected function get time():TimeModel
		{
			return kGAMECLASS.time;
		}
		
		protected function set time(val:TimeModel):void
		{
			kGAMECLASS.time = val;
		}
		
/* Finally got rid of this var
		protected function get menuLoc():Number
		{
			return kGAMECLASS.menuLoc;
		}
		
		protected function set menuLoc(val:Number):void
		{
			kGAMECLASS.menuLoc = val;
		}
*/
		
/*
		protected function get itemSlots():Array
		{
			return kGAMECLASS.player.itemSlots;
		}
*/
		
/*
		protected function get itemStorage():Array
		{
			return kGAMECLASS.itemStorage;
		}

		protected function set itemStorage(val:Array):void
		{
			kGAMECLASS.itemStorage = val;
		}
		
		protected function get gearStorage():Array
		{
			return kGAMECLASS.gearStorage;
		}
		
		protected function set gearStorage(val:Array):void
		{
			kGAMECLASS.gearStorage = val;
		}
*/
		
		protected function get temp():int
		{
			return kGAMECLASS.temp;
		}
		
		protected function set temp(val:int):void
		{
			kGAMECLASS.temp = val;
		}
		
		protected function get args():Array
		{
			return kGAMECLASS.args;
		}
		
		protected function set args(val:Array):void
		{
			kGAMECLASS.args = val;
		}
		
		protected function get funcs():Array
		{
			return kGAMECLASS.funcs;
		}
		
		protected function set funcs(val:Array):void
		{
			kGAMECLASS.funcs = val;
		}
		
		protected function get mainView():MainView
		{
			return kGAMECLASS.mainView;
		}

		protected function get mainViewManager():MainViewManager
		{
			return kGAMECLASS.mainViewManager;
		}
		
		protected function get model():GameModel
		{
			return kGAMECLASS.model;
		}
		
		protected function set model(val:GameModel):void
		{
			kGAMECLASS.model = val;
		}
		
		protected function get flags():DefaultDict
		{
			return kGAMECLASS.flags;
		}

		protected function get counters():RootCounters {
			return kGAMECLASS.counters;
		}

		protected function set flags(val:DefaultDict):void
		{
			kGAMECLASS.flags = val;
		}
		
		protected function get achievements():DefaultDict
		{
			return kGAMECLASS.achievements;
		}
		
		protected function set achievements(val:DefaultDict):void
		{
			kGAMECLASS.achievements = val;
		}
		
		protected function showStatDown(arg:String):void
		{
			kGAMECLASS.mainView.statsView.showStatDown(arg);
		}
		
		protected function showStatUp(arg:String):void
		{
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
				
		protected function darkTheme():Boolean {
			return kGAMECLASS.mainViewManager.darkThemeImpl();
		}
		protected static function onGameInit(f:Function):void {
			CoC.onGameInit(f);
		}
		protected function get context():StoryContext {
			return kGAMECLASS.context;
		}
	}

}