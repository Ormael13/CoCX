package classes {
import classes.CoC;
import classes.Items.*;
import classes.Scenes.Camp;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Dungeons.D3.D3;
import classes.Scenes.Dungeons.DungeonAbstractContent;
import classes.Scenes.Holidays;
import classes.Scenes.Inventory;
import classes.Scenes.Places.Ingnam;
import classes.Scenes.Places.Prison;
import classes.Scenes.SceneLib;
import classes.Transformations.TransformationLib;
import classes.internals.Utils;

import coc.model.GameModel;
import coc.model.TimeModel;
import coc.view.ButtonData;
import coc.view.ButtonDataList;
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
        public function BaseContent()
		{

		}

		protected function cheatTime(time:Number, needNext:Boolean = false):void
		{
			EventParser.cheatTime(time, needNext);
		}
		protected function cheatTime2(time:Number, needNext:Boolean = false):void
		{
			EventParser.cheatTime2(time, needNext);
		}
		/*protected function incrementDay(time:Number):void
		{
			CoC.instance.incrementDay(time);
		}*/
		protected function get timeQ():Number
		{
			return CoC.instance.timeQ;
		}

		protected function get isNightTime():Boolean {
			return (model.time.hours <= 5 || model.time.hours >= 22);
		}

		/*protected function get measurements():Class
		{
			return Measurements;
		}*/

		protected function get camp():Camp {
			return SceneLib.camp;
		}

		protected function get ingnam():Ingnam {
			return SceneLib.ingnam;
		}

		protected function get prison():Prison {
			return SceneLib.prison;
		}

		protected function get d3():D3 {
			return SceneLib.d3;
		}

		public function goNext(time:Number,defNext:Boolean):Boolean
		{
			return EventParser.goNext(time,defNext);
		}

		protected function awardAchievement(title:String, achievement:*, display:Boolean = true, nl:Boolean = false, nl2:Boolean = true):void
		{
			return EngineCore.awardAchievement(title, achievement, display, nl, nl2);
		}

		protected function isLunarNewYear():Boolean
		{
			return Holidays.isLunarNewYear();
		}

		protected function isHalloween():Boolean
		{
			return Holidays.isHalloween();
		}

		protected function isValentine():Boolean
		{
			return Holidays.isValentine();
		}

		protected function isHolidays():Boolean
		{
			return Holidays.isHolidays();
		}

		public function isEaster():Boolean
		{
			return Holidays.isEaster();
		}

		protected function isThanksgiving():Boolean
		{
			return Holidays.isThanksgiving();
		}

		protected function isAprilFools():Boolean
		{
			return Holidays.isAprilFools();
		}

		protected function get date():Date
		{
			return CoC.instance.date;
		}

/*
		protected function inCombat():Boolean
		{
			return CoC.instance.inCombat();
		}
*/
		//Curse you, CoC updates!
		protected function get inDungeon():Boolean
		{
			return DungeonAbstractContent.inDungeon;
		}
/* inDungeon is now read only
		protected function set inDungeon(v:Boolean):void
		{
			CoC.instance.inDungeon = v;
		}
*/

		protected function get inRoomedDungeon():Boolean
		{
			return DungeonAbstractContent.inRoomedDungeon;
		}
		protected function set inRoomedDungeon(v:Boolean):void
		{
			DungeonAbstractContent.inRoomedDungeon = v;
		}

		protected function get inRoomedDungeonResume():Function
		{
			return DungeonAbstractContent.inRoomedDungeonResume;
		}
		protected function set inRoomedDungeonResume(v:Function):void
		{
			DungeonAbstractContent.inRoomedDungeonResume = v;
		}

/*
		protected function get itemSubMenu():Boolean
		{
			return CoC.instance.itemSubMenu;
		}
		protected function set itemSubMenu(value:Boolean):void
		{
			CoC.instance.itemSubMenu = value;
		}
*/

		protected function showStats():void
		{
			EngineCore.showStats();
		}

		protected function statScreenRefresh():void
		{
			EngineCore.statScreenRefresh();
		}

		protected function get combat():Combat {
			return SceneLib.combat;
		}

		protected function cleanupAfterCombat(nextFunc:Function = null):void
		{
			SceneLib.combat.cleanupAfterCombatImpl(nextFunc);
		}

		protected function enemyAI():void
		{
			SceneLib.combat.enemyAIImpl();
		}

		protected function clearStatuses(visibility: Boolean):void
		{
			player.clearStatuses(visibility);
		}

		protected function spriteSelect(choice:Object = 0):void
		{
			CoC.instance.spriteSelect(choice);
		}

		protected function hideStats():void
		{
			EngineCore.hideStats();
		}
		protected function hideUpDown():void
		{
			EngineCore.hideUpDown();
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
			return EngineCore.createCallBackFunction(func,arg);
		}

		protected function createCallBackFunction2(func:Function, ...args):Function
		{
			return EngineCore.createCallBackFunction2.apply(null,[func].concat(args));
		}

		protected function startCombat(monster_:Monster,plotFight_:Boolean=false):void{
			SceneLib.combat.startCombatImpl(monster_,plotFight_);
		}

		protected function doSFWloss():Boolean {
			return EngineCore.doSFWloss();
		}


		protected function startCombatImmediate(monster:Monster, _plotFight:Boolean = false):void
		{
			SceneLib.combat.startCombatImmediateImpl(monster, _plotFight);
		}

		// Needed in a few rare cases for dumping text coming from a source that can't properly escape it's brackets
		// (Mostly traceback printing, etc...)
		protected static function rawOutputText(output:String, purgeText:Boolean = false):void
		{
			EngineCore.rawOutputText(output, purgeText);
		}

		protected static function outputText(output:String):void
		{
			EngineCore.outputText(output);
		}

		protected static function clearOutput():void
		{
			EngineCore.clearOutputTextOnly();
		}
		protected function displayHeader(string:String):void
		{
			EngineCore.displayHeader(string);
		}

		protected function flushOutputTextToGUI():void {
			CoC.instance.flushOutputTextToGUI();
		}

		protected function doNext(eventNo:Function):void //Now typesafe
		{
			EngineCore.doNext(eventNo);
		}

		protected function menu():void
		{
			EngineCore.menu();
		}

		protected function hideMenus():void
		{
			EngineCore.hideMenus();
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
			EngineCore.choices(
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
			EngineCore.simpleChoices(text1, butt1,
					text2, butt2,
					text3, butt3,
					text4, butt4,
					text5, butt5);
		}

		protected function doYesNo(eventYes:Function, eventNo:Function):void { //Now typesafe
			EngineCore.doYesNo(eventYes, eventNo);
		}

		protected function addButton(pos:int, text:String = "", func1:Function = null, arg1:* = -9000, arg2:* = -9000, arg3:* = -9000, toolTipText:String = "", toolTipHeader:String = ""):CoCButton
		{
			return EngineCore.addButton(pos, text, func1, arg1, arg2, arg3, toolTipText, toolTipHeader);
		}

		protected function addButtonDisabled(pos:int, text:String = "", toolTipText:String = "", toolTipHeader:String = ""):CoCButton
		{
			return EngineCore.addButtonDisabled(pos, text, toolTipText, toolTipHeader);
		}
		protected function button(pos:int):CoCButton
		{
			return EngineCore.button(pos);
		}

		protected function removeButton(arg:*):void
		{
			EngineCore.removeButton(arg);
		}

		protected function hasButton(arg:*):Boolean
		{
			return EngineCore.hasButton(arg);
		}

/* Replaced by Utils.formatStringArray, which does almost the same thing in one function
		protected function clearList():void{
			CoC.instance.clearList();
		}

		protected function addToList(arg:*):void{
			CoC.instance.addToList(arg);
		}

		protected function outputList():String{
			return CoC.instance.outputList();
		}
*/

		protected function openURL(url:String):void{
			return EngineCore.openURL(url);
		}

		protected function sackDescript():String
		{
			return Appearance.sackDescript(player);
		}

		protected function cockClit(value:int = 0):String
		{
			if(player.hasCock() && value >= 0 && value < player.cockTotal()) return player.cockDescript(value);
			else return clitDescript();
		}

/* Was only used in Scylla's code. Replaced with conditionals
		protected function balls(balls:*, noBalls:*):String
		{
			return CoC.instance.balls(balls, noBalls);
		}
*/

		protected function sheathDesc():String
		{
			return CoC.instance.player.sheathDescription();
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
			return Appearance.allBreastsDescript(player);
		}

		protected function sMultiCockDesc():String
		{
			return CoC.instance.player.sMultiCockDesc();
		}

		protected function SMultiCockDesc():String
		{
			return CoC.instance.player.SMultiCockDesc();
		}

		protected function oMultiCockDesc():String
		{
			return CoC.instance.player.oMultiCockDesc();
		}

		protected function OMultiCockDesc():String
		{
			return CoC.instance.player.OMultiCockDesc();
		}

		protected function tongueDescript():String
		{
            return Appearance.tongueDescription(player);
		}

		protected function ballsDescriptLight(forcedSize:Boolean = true):String {
            return Appearance.ballsDescription(forcedSize, true, player);
		}

		protected function ballDescript():String {
            return Appearance.ballsDescription(false, false, player);
		}

		/* All calls changed to monster.ballsDescriptLight
		protected function eBallsDescriptLight():String {
			return CoC.instance.eBallsDescriptLight();
		}
		*/

		/* Was never called
		protected function eBallsDescript():String {
			return CoC.instance.eBallsDescript();
		}
		*/

		protected function ballsDescript():String {
            return Appearance.ballsDescription(false, true, player, true);
		}

		protected function simpleBallsDescript():String {
            return Appearance.ballsDescription(false, true, player);
		}

		protected function assholeDescript():String {
			return Appearance.assholeDescript(player)
		}

		protected function eAssholeDescript():String {
			return Appearance.assholeDescript(monster);
		}

		protected function hipDescript():String {
			return Appearance.hipDescription(player);
		}

		protected function assDescript():String {
			return Appearance.buttDescription(player);
		}

		protected  function buttDescript():String {
			return Appearance.buttDescription(player);
		}

		protected function assholeOrPussy():String {
			return Appearance.assholeOrPussy(player);
		}

/* Replaced by calls to Appearance.breastDescript
		protected function npcBreastDescript(size:Number):String {
			return CoC.instance.npcBreastDescript(size);
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
			return CoC.instance.num2TextBest(number, capitalised, positional);
		}

		protected function num2Text(number:int):String
		{
			return CoC.instance.num2Text(number);
		}
		protected function Num2Text(number:int):String
		{
			return CoC.instance.Num2Text(number);
		}
		protected  function num2Text2(number:int):String
		{
			return CoC.instance.num2Text2(number);
		}
*/

		protected function nippleDescript(rowNum:Number):String
		{
			return Appearance.nippleDescription(player, rowNum)
		}

		protected function cockDescript(cockNum:int = 0):String
		{
			return CoC.instance.player.cockDescript(cockNum);
		}

/*
		protected function cockAdjective(cockNum:Number = -1):String
		{
			return CoC.instance.cockAdjective(cockNum);
		}
*/

		protected function multiCockDescript():String
		{
			return CoC.instance.player.multiCockDescript();
		}

		protected function multiCockDescriptLight():String
		{
			return CoC.instance.player.multiCockDescriptLight();
		}

/*
		protected function eMultiCockDescriptLight():String
		{
			return CoC.instance.eMultiCockDescriptLight();
		}

		protected function eCockHead(cockNum:Number = 0):String
		{
			return CoC.instance.eCockHead(cockNum);
		}

		protected function eCockDescript(cockIndex:Number = 0):String
		{
			return CoC.instance.eCockDescript(cockIndex);
		}
*/

		protected function breastDescript(rowNum:Number):String
		{
			return player.breastDescript(rowNum);
		}

/*
		protected function cockHead(cockNum:Number = 0):String
		{
			return CoC.instance.cockHead(cockNum);
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

		protected function hairDescript(longDesc:Boolean = false):String
		{
			return Appearance.hairDescription(player, longDesc);
		}

		protected function beardDescript():String
		{
			return Appearance.beardDescription(player);
		}

		protected function hairOrFur():String
		{
            return Appearance.hairOrFur(player);
		}

		protected function clitDescript():String
		{
            return Appearance.clitDescription(player);
		}

		protected function vaginaDescript(vaginaNum:Number = 0):String
		{
            return Appearance.vaginaDescript(player, vaginaNum);
		}

		protected function allVaginaDescript():String
		{
            if (player.vaginas.length == 1) return vaginaDescript(rand(player.vaginas.length - 1));
            if (player.vaginas.length > 1) return (vaginaDescript(rand(player.vaginas.length - 1)) + "s");

            CoC_Settings.error("ERROR: allVaginaDescript called with no vaginas.");
            return "ERROR: allVaginaDescript called with no vaginas.";
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
			return CoC.instance.NPCCockDescript(cockType,cockLength,lust);
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
			player.dynStats.apply(player, args);
		}

		protected function MutagenBonus(statName: String, bonus: Number):void
		{
			player.MutagenBonus(statName,bonus);
		}

		protected function AlchemyBonus(statName: String, bonus: Number):void
		{
			player.AlchemyBonus(statName,bonus);
		}

		protected function KnowledgeBonus(statName: String, bonus: Number):void
		{
			player.KnowledgeBonus(statName,bonus);
		}

		protected function silly():Boolean
		{
			return EngineCore.silly();
		}

		protected function HPChange(changeNum:Number,display:Boolean):void
		{
			EngineCore.HPChange(changeNum,display);
		}

		// For fatigue(mod,type) calls
		public static const USEFATG_NORMAL:int = 0;
		public static const USEFATG_MAGIC:int = 1;
		public static const USEFATG_PHYSICAL:int = 2;
		public static const USEFATG_MAGIC_NOBM:int = 3;
		public static const USEFATG_BOW:int = 4;
		public static const USEFATG_WHITE:int = 5;
		public static const USEFATG_BLACK:int = 6;
		public static const USEFATG_WHITE_NOBM:int = 7;
		public static const USEFATG_BLACK_NOBM:int = 8;
		protected function fatigue(mod:Number,type:Number=0):void {
			EngineCore.fatigue(mod, type);
		}

		protected function useMana(mod:Number,type:Number=0):void
		{
			SceneLib.combat.useManaImpl(mod,type);
		}


/*
		protected function get eventParser():Function
		{
			return CoC.instance.eventParser;
		}
*/

		protected function playerMenu():void { EventParser.playerMenu(); }

		protected static function get player():Player
		{
			return CoC.instance.player;
		}

		protected function set player(val:Player):void
		{
			CoC.instance.player = val;
		}

		protected function get player2():Player
		{
			return CoC.instance.player2;
		}

		protected function set player2(val:Player):void
		{
			CoC.instance.player2 = val;
		}

		protected function get debug():Boolean
		{
			return CoC.instance.debug;
		}

		protected function set debug(val:Boolean):void
		{
			CoC.instance.debug = val;
		}

		protected function get ver():String
		{
			return CoC.instance.ver;
		}

		protected function set ver(val:String):void
		{
			CoC.instance.ver = val;
		}

		protected function get images():ImageManager
		{
			return CoC.instance.images;
		}

		protected function set images(val:ImageManager):void
		{
			CoC.instance.images = val;
		}

		protected function get monster():Monster
		{
			return CoC.instance.monster;
		}

		protected function set monster(val:Monster):void
		{
			CoC.instance.monster = val;
		}

		protected function get transformations():TransformationLib {
			return CoC.instance.transformations;
		}
		protected function get consumables():ConsumableLib{
			return CoC.instance.consumables;
		}
		protected function get useables():UseableLib{
			return CoC.instance.useables;
		}
		protected function get weapons():WeaponLib{
			return CoC.instance.weapons;
		}
		protected function get weaponsrange():WeaponRangeLib{
			return CoC.instance.weaponsrange;
		}
		protected function get armors():ArmorLib{
			return CoC.instance.armors;
		}
		protected function get headjewelries():HeadJewelryLib{
			return CoC.instance.headjewelries;
		}
		protected function get necklaces():NecklaceLib{
			return CoC.instance.necklaces;
		}
		protected function get jewelries():JewelryLib{
			return CoC.instance.jewelries;
		}
		protected function get shields():ShieldLib{
			return CoC.instance.shields;
		}
		protected function get undergarments():UndergarmentLib{
			return CoC.instance.undergarments;
		}
		protected function get vehicles():VehiclesLib{
			return CoC.instance.vehicles;
		}
		protected function get inventory():Inventory{
			return SceneLib.inventory;
		}

/* No longer used
		protected function get itemSwapping():Boolean
		{
			return CoC.instance.itemSwapping;
		}

		protected function set itemSwapping(val:Boolean):void
		{
			CoC.instance.itemSwapping = val;
		}
*/

		protected function get time():TimeModel
		{
			return CoC.instance.time;
		}

		protected function set time(val:TimeModel):void
		{
			CoC.instance.time = val;
		}

/* Finally got rid of this var
		protected function get menuLoc():Number
		{
			return CoC.instance.menuLoc;
		}

		protected function set menuLoc(val:Number):void
		{
			CoC.instance.menuLoc = val;
		}
*/

/*
		protected function get itemSlots():Array
		{
			return CoC.instance.player.itemSlots;
		}
*/

/*
		protected function get itemStorage():Array
		{
			return CoC.instance.itemStorage;
		}

		protected function set itemStorage(val:Array):void
		{
			CoC.instance.itemStorage = val;
		}

		protected function get gearStorage():Array
		{
			return CoC.instance.gearStorage;
		}

		protected function set gearStorage(val:Array):void
		{
			CoC.instance.gearStorage = val;
		}
*/

		protected function get mainView():MainView
		{
			return CoC.instance.mainView;
		}

		protected function get mainViewManager():MainViewManager
		{
			return CoC.instance.mainViewManager;
		}

		protected function get model():GameModel
		{
			return CoC.instance.model;
		}

		protected function set model(val:GameModel):void
		{
			CoC.instance.model = val;
		}

		protected function get flags():DefaultDict
		{
			return CoC.instance.flags;
		}

		protected function set flags(val:DefaultDict):void
		{
			CoC.instance.flags = val;
		}

		protected function get achievements():DefaultDict
		{
			return CoC.instance.achievements;
		}

		protected function set achievements(val:DefaultDict):void
		{
			CoC.instance.achievements = val;
		}

		protected function showStatDown(arg:String):void
		{
			CoC.instance.mainView.statsView.showStatDown(arg);
		}

		protected function showStatUp(arg:String):void
		{
			CoC.instance.mainView.statsView.showStatUp(arg);
		}

		protected function buttonTextIsOneOf(index:int, possibleLabels:Array):Boolean {
			return EngineCore.buttonTextIsOneOf(index, possibleLabels);
		}

		protected function getButtonText(index:int):String {
			return EngineCore.getButtonText(index);
		}

		protected function buttonIsVisible(index:int):Boolean {
			return EngineCore.buttonIsVisible(index);
		}

		protected function darkTheme():Boolean {
			return CoC.instance.mainViewManager.darkThemeImpl();
		}
		protected static function onGameInit(f:Function):void {
			CoC.onGameInit(f);
		}
		protected function get context():StoryContext {
			return CoC.instance.context;
		}
		protected function submenu(buttons:ButtonDataList,back:Function=null,page:int=0,IsSorted:Boolean = true):void {
			var list:/*ButtonData*/Array = buttons.list.filter(function(e:ButtonData, i:int, a:Array):Boolean{
				return e.visible;
			});
			if (IsSorted){
				list.sortOn('text');
			}
			menu();
			var total:int = list.length;
			var n:int = Math.min(total,(page+1)*12);
			for (var bi:int = 0,li:int=page*12; li<n; li++,bi++) {
				list[li].applyTo(button(bi%12));
			}
			if (page!=0 || total>12) {
				button(12).show("Prev Page", curry(submenu, buttons, back, page - 1, IsSorted)).disableIf(page == 0);
				button(13).show("Next Page", curry(submenu, buttons, back, page + 1, IsSorted)).disableIf(n >= total);
			}
			if (back != null) button(14).show("Back",back);
		}
	}

}
