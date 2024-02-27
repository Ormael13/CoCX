package classes {
import classes.GlobalFlags.kFLAGS;
import classes.Items.*;
import classes.Parser.Parser;
import classes.Scenes.API.ExplorationEngine;
import classes.Scenes.Camp;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Dungeons.D3.D3;
import classes.Scenes.Dungeons.DungeonAbstractContent;
import classes.Scenes.Holidays;
import classes.Scenes.Inventory;
import classes.Scenes.Places.Ingnam;
import classes.Scenes.QuestLib;
import classes.Scenes.SceneLib;
import classes.Transformations.TransformationLib;
import classes.internals.Utils;

import coc.model.GameModel;
import coc.model.TimeModel;
import coc.view.Block;
import coc.view.ButtonData;
import coc.view.ButtonDataList;
import coc.view.CoCButton;
import coc.view.MainView;
import coc.view.NotificationView;
import coc.view.charview.DragButton;
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
		protected function cheatTime(time:Number, needNext:Boolean = false):void
		{
			EventParser.cheatTime(time, needNext);
		}

		/**
		 * Advance time by `time` minutes. If overflows into next hour, delay this until next EngineCode.goNext call
		 * @param time
		 */
		protected function advanceMinutes(time:Number):void
		{
			EventParser.advanceMinutes(time);
		}
		protected static function get timeQ():Number
		{
			return CoC.instance.timeQ + Math.floor(CoC.instance.timeQmin/60);
		}

		/**
		 * Time advancement is planned
		 */
		protected static function get timeQueued():Boolean {
			return CoC.instance.timeQ > 0 || CoC.instance.timeQmin > 0;
		}

		public static function get isNightTime():Boolean {
			return (model.time.hours + timeQ <= 5 || model.time.hours + timeQ >= 22);
		}

		/**
		 * Examples:
		 * - isTimeBetween(12, 16) - 12:00..15:59
		 * - isTimeBetween(0, 6) - 0:00..5:59
		 * - isTimeBetween(18, 24) - 18:00..23:59
		 * */
		public static function isTimeBetween(startHour:Number, endHour:Number):Boolean {
			return (model.time.hours +timeQ >= startHour && model.time.hours +timeQ < endHour)
		}

		protected function get camp():Camp {
			return SceneLib.camp;
		}

		protected function get ingnam():Ingnam {
			return SceneLib.ingnam;
		}

		protected function get d3():D3 {
			return SceneLib.d3;
		}

		/**
		 * Advance queued time and execute scheduled events. Then go to playerMenu (camp/Ingnam)
		 * @param defNext Require [Next] button, otherwise can display the playerMenu right away
		 * @return {Boolean} true if some menu was displayed, false if no display or text only
		 */
		public function goNext(defNext:Boolean):Boolean
		{
			return EventParser.goNext(defNext);
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

		protected function isChristmas():Boolean
		{
			return Holidays.isChristmas();
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

		protected static function get date():Date
		{
			return CoC.instance.model.time.date;
		}

		protected function get inDungeon():Boolean
		{
			return DungeonAbstractContent.inDungeon;
		}

		protected function set inDungeon(v:Boolean):void
		{
			DungeonAbstractContent.inDungeon = v;
		}

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

		protected function cleanupAfterCombatTFEvent(nextFunc:Function = null, ThisIsNotATFScene:Boolean = false):void
		{
			SceneLib.combat.cleanupAfterCombatImpl(nextFunc,ThisIsNotATFScene);
		}

		protected function recoveryOfResources():void
		{
			SceneLib.combat.recoveryOfResourcesImpl();
		}

		protected function enemyAI():void
		{
			SceneLib.combat.enemyAIImpl();
		}

		protected function clearStatuses(visibility: Boolean):void
		{
			player.clearStatuses(visibility);
		}

		protected function spriteSelect(choice:Class = null):void
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

		protected function createCallBackFunction(func:Function, arg:*):Function
		{
			return EngineCore.createCallBackFunction(func,arg);
		}

		protected function createCallBackFunction2(func:Function, ...args):Function
		{
			return EngineCore.createCallBackFunction2.apply(null,[func].concat(args));
		}

		protected function startCombat(monster_:Monster,plotFight_:Boolean=false):void{
			if (player.hasStatusEffect(StatusEffects.HumanForm) && player.statusEffectv1(StatusEffects.HumanForm) >= 1){
				player.addStatusValue(StatusEffects.HumanForm, 1, -1);
			}
			SceneLib.combat.startCombatImpl(monster_,plotFight_);
		}


		protected function startCombatImmediate(monster:Monster, _plotFight:Boolean = false):void
		{
			if (player.hasStatusEffect(StatusEffects.HumanForm) && player.statusEffectv1(StatusEffects.HumanForm) >= 1){
				player.addStatusValue(StatusEffects.HumanForm, 1, -1);
			}
			SceneLib.combat.startCombatImmediateImpl(monster, _plotFight);
		}

		// Needed in a few rare cases for dumping text coming from a source that can't properly escape it's brackets
		// (Mostly traceback printing, etc...)
		protected static function rawOutputText(output:String, purgeText:Boolean = false):void
		{
			EngineCore.rawOutputText(output, purgeText);
		}

		protected static function printLink(linkText:String, eventArgument:String):void {
			outputText(mkLink(linkText, eventArgument));
		}
		protected static function mkLink(linkText:String, eventArgument:String):String {
			return '<u><a href="event:'+encodeURI(eventArgument)+'">'+linkText+"</a></u>";
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

		protected static function flushOutputTextToGUI():void {
			CoC.instance.flushOutputTextToGUI();
		}

		protected function doNext(func:Function, ...args):void //Now typesafe
		{
			EngineCore.doNext.apply(null, [func].concat(args));
		}

		protected static function menu():void
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
		protected function addFiveArgButton(pos:int, text:String = "", func1:Function = null, arg1:* = -9000, arg2:* = -9000, arg3:* = -9000, arg4:* = -9000, arg5:* = -9000, toolTipText:String = "", toolTipHeader:String = ""):CoCButton
		{
			return EngineCore.fiveArgButton(pos, text, func1, arg1, arg2, arg3, arg4, arg5, toolTipText, toolTipHeader);
		}

		protected function addButtonDisabled(pos:int, text:String = "", toolTipText:String = "", toolTipHeader:String = ""):CoCButton
		{
			return EngineCore.addButtonDisabled(pos, text, toolTipText, toolTipHeader);
		}
		//This function is completely useless, but I'm too lazy to properly replace all its mentions. - SH
		protected function addButtonIfTrue(pos:int, text:String, func1:Function, toolTipDisabled:String, condition:Boolean, tooltipText:String = "", toolTipHeader:String = ""):CoCButton {
			return EngineCore.addButton(pos, text, func1, null, null, null, tooltipText, toolTipHeader)
				.disableIf(!condition, toolTipDisabled);
        }
		protected static function button(pos:int):CoCButton
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

		protected function sheathDesc():String
		{
			return CoC.instance.player.sheathDescription();
		}

		protected function chestDesc():String
		{
			return player.chestDesc();
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

		protected function nippleDescript(rowNum:Number):String
		{
			return Appearance.nippleDescription(player, rowNum)
		}

		protected function cockDescript(cockNum:int = 0):String
		{
			return CoC.instance.player.cockDescript(cockNum);
		}

		protected function multiCockDescript():String
		{
			return CoC.instance.player.multiCockDescript();
		}

		protected function multiCockDescriptLight():String
		{
			return CoC.instance.player.multiCockDescriptLight();
		}

		protected function breastDescript(rowNum:Number):String
		{
			return player.breastDescript(rowNum);
		}

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
			return Appearance.hairDescription(player);
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

		//useless until multivaginas are added
		/*
		protected function allVaginaDescript():String
		{
            if (player.vaginas.length == 1) return vaginaDescript(rand(player.vaginas.length - 1));
            if (player.vaginas.length > 1) return (vaginaDescript(rand(player.vaginas.length - 1)) + "s");

            CoC_Settings.error("ERROR: allVaginaDescript called with no vaginas.");
            return "ERROR: allVaginaDescript called with no vaginas.";
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

		protected function MutagenBonus(statName: String, bonus: Number, applyEffect: Boolean = true):Boolean
		{
			return player.MutagenBonus(statName,bonus, applyEffect);
		}

		protected function alchemyBonus(statName: String, bonus: Number):void
		{
			return player.alchemyBonus(statName,bonus);
		}

		protected function KnowledgeBonus(statName: String, bonus: Number):void
		{
			return player.KnowledgeBonus(statName,bonus);
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

		protected function fatigue(mod:Number, type:Number = USEFATG_NORMAL):void {
			EngineCore.fatigue(mod, type);
		}

		public static const USEMANA_NORMAL:int = 0;
		protected function useMana(mod:Number, type:Number = USEMANA_NORMAL):void {
			SceneLib.combat.useManaImpl(mod, type);
		}

		protected static function playerMenu():void { EventParser.playerMenu(); }
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
		protected function get itemTemplates():ItemTemplateLib{
			return ItemTemplateLib.instance;
		}
		protected static function get consumables():ConsumableLib{
			return CoC.instance.consumables;
		}
		protected static function get useables():UseableLib{
			return CoC.instance.useables;
		}
		protected function get weapons():WeaponLib{
			return CoC.instance.weapons;
		}
		protected function get weaponsrange():WeaponRangeLib{
			return CoC.instance.weaponsrange;
		}
		protected function get weaponsflyingswords():FlyingSwordsLib{
			return CoC.instance.weaponsflyingswords;
		}
		protected static function get armors():ArmorLib{
			return CoC.instance.armors;
		}
		protected function get miscjewelries():MiscJewelryLib{
			return CoC.instance.miscjewelries;
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

		protected static function get questLib():QuestLib {
			return CoC.instance.questLib;
		}
		protected function get inventory():Inventory{
			return SceneLib.inventory;
		}

		protected function get time():TimeModel
		{
			return CoC.instance.time;
		}

		protected function set time(val:TimeModel):void
		{
			CoC.instance.time = val;
		}

		protected static function get mainView():MainView
		{
			return CoC.instance.mainView;
		}

		protected function get mainViewManager():MainViewManager
		{
			return CoC.instance.mainViewManager;
		}

		protected static function get notificationView():NotificationView {
			return CoC.instance.mainView.notificationView;
		}

		protected static function get model():GameModel
		{
			return CoC.instance.model;
		}

		protected function set model(val:GameModel):void
		{
			CoC.instance.model = val;
		}

		protected static function get flags():DefaultDict
		{
			return CoC.instance.flags;
		}

		protected function get achievements():DefaultDict
		{
			return CoC.instance.achievements;
		}

		protected function set achievements(val:DefaultDict):void
		{
			CoC.instance.achievements = val;
		}

		//==========================
		//SceneHunter shortcuts
        protected function get sceneHunter():SceneHunter {
            return CoC.instance.gameSettings.sceneHunter_inst;
        }
		protected function get recalling():Boolean {
			return CoC.instance.gameSettings.sceneHunter_inst._recalling;
		}
		protected function set recalling(val:Boolean):void {
			CoC.instance.gameSettings.sceneHunter_inst._recalling = val;
		}
		protected function recallWakeUp():void {
			CoC.instance.gameSettings.sceneHunter_inst.recallWakeUpImpl();
		}
		protected function get mocking():Boolean {
			return CoC.instance.gameSettings.sceneHunter_inst._mocking;
		}
		protected function set mocking(val:Boolean):void {
			CoC.instance.gameSettings.sceneHunter_inst._mocking = val;
		}
		//============================

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

		protected static function get shiftKeyDown():Boolean {
			return flags[kFLAGS.SHIFT_KEY_DOWN];
		}
		protected static function set shiftKeyDown(value:Boolean):void {
			flags[kFLAGS.SHIFT_KEY_DOWN] = value;
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
		protected static function get explorer():ExplorationEngine {
			return SceneLib.explorationEngine;
		}
		/**
		 * [Next] to camp or exploration map
		 * @param timePassedMinutes Advance time, -1 for default value
		 * */
		protected function endEncounter(timePassedMinutes:int = -1):void {
			doNext(curry(explorer.done,timePassedMinutes));
		}

		protected function adjustedPlayerLevel():int {
			return player.level + combat.playerLevelAdjustment();
		}

		public static var submenuPage:int = 0;
		/**
		 * Print a submenu from the provided buttons
		 * @param buttons List of buttons for the menu
		 * @param back Function for the "Back" button (14)
		 * @param page Currently displayed page
		 * @param IsSorted If true, the buttons will be sorted by their names
		 * @param constButtons Adds constant buttons, aside from Prev/Next page. Arrays ["Name", Function]
		 */
		public static function submenu(buttons:ButtonDataList, back:Function=null, page:int=0, IsSorted:Boolean = true, constButtons:Array = null):void {
			if (!constButtons) constButtons = [];
			var list:/*ButtonData*/Array = buttons.list.filter(function(e:ButtonData, i:int, a:Array):Boolean{
				return e.visible;
			});
			if (IsSorted){
				list.sortOn('text');
			}
			// find out how much buttons we can place on each page
			var total:int = list.length; // total number of menu buttons
			var totalConst:int = constButtons.length + (back != null ? 1 : 0); // const buttons on each page
			if (total + totalConst > 15) //can't fit on 1 page!
				totalConst += 2; // prev/nex
			var buttonsPerPage:int = 15 - totalConst; // including back, prev/next, other shit
			var pageCount:int = Math.ceil(total / buttonsPerPage);
			page = boundInt(0, page, pageCount);
			submenuPage = page;
			menu();
			// menu buttons
			var n:int = Math.min(total,(page+1)*buttonsPerPage); // max index for this page
			var bi:int = 0; // button index
			for (var li:int=page*buttonsPerPage; li<n; li++,bi++) {
				list[li].applyTo(button(bi%buttonsPerPage));
			}
			// const buttons
			bi = 15 - totalConst;
			for (var cbi:int = 0; cbi < constButtons.length; ++cbi, ++bi)
				if (constButtons[cbi][0] && constButtons[cbi][1])
					button(bi).show(constButtons[cbi][0], constButtons[cbi][1])
						.hint(constButtons[cbi].length > 2 ? constButtons[cbi][2] : "");
			if (page!=0 || total>buttonsPerPage) {
				button(bi++).show("Prev Page", curry(submenu, buttons, back, page - 1, IsSorted, constButtons)).disableIf(page == 0).icon("Left");
				button(bi++).show("Next Page", curry(submenu, buttons, back, page + 1, IsSorted, constButtons)).disableIf(n >= total).icon("Right");
			}
			if (back != null) button(bi++).show("Back",back);
		}

		/**
		 * Display a 5xN button grid after the current text.
		 * @param bd Button data, row-by-row.
		 * If label is an empty string, it's an empty cell.
		 * If bd.extraData is "text", a text field is added instead of button (to add text between button rows)
		 * @example
		 * var bd:ButtonDataList = new ButtonDataList();
		 * // Row 1
		 * bd.add("");
		 * bd.add("North", goNorth);
		 * bd.add("");
		 * bd.add("");
		 * bd.add("Climb Up", climbUp).disableIf(!canClimbUp);
		 * // Row 2
		 * bd.add("West", goWest);
		 * bd.add("South", goSouth);
		 * bd.add("East", goEast);
		 * bd.add("");
		 * bd.add("Climb Down", climbDown);
		 *
		 * bigButtonGrid(bd);
		 */
		protected static function bigButtonGrid(bd:ButtonDataList):void {
			DragButton.cleanUp();
			flushOutputTextToGUI();
			var grid:Block = new Block({
				layoutConfig: {
					type: "grid",
					cols: 5
				}
			});
			for (var i:int = 0; i<bd.list.length; i++) {
				var b:ButtonData = bd.list[i];
				if (b.extraData == "text") {
					grid.addTextField({
						width: MainView.BTN_W,
						height: MainView.BTN_H,
						htmlText: Parser.recursiveParser(b.text),
						defaultTextFormat: mainView.mainText.defaultTextFormat
					});
				} else if (b.text == "") {
					// add spacer
					grid.addElement(new Block({width: MainView.BTN_W, height: MainView.BTN_H}));
				} else {
					// add button
					var btn:CoCButton = new CoCButton();
					b.applyTo(btn);
					grid.addElement(btn);
					if (b.draggable)
						new DragButton(b.slot, btn, b.slotType);
				}
			}
			mainView.setCustomElement(grid, true, true);
			grid.doLayout();
		}

        /**
		 * Displays a selection to call the function with a number
		 * @param fun Function to call
		 * @param from Minimum number (inclusive)
		 * @param to Maximum number (inclusive)
		 * @param back "Back" button function (optional)
		 */
		public static function pickANumber(fun:Function, from:int, to:int, back:Function = null):void {
			var bd:ButtonDataList = new ButtonDataList();
			for (var i:int = from; i <= to; ++i) bd.add(i.toString(), curry(fun, i))
			BaseContent.submenu(bd, back, 0, false);
		}


	}

}
