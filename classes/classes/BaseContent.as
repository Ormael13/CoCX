package classes 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.*;
	import classes.Scenes.Camp;
	import classes.Scenes.Combat.Combat;
	import classes.Scenes.Places.Ingnam;
	import classes.Scenes.Places.Prison;
	import classes.Scenes.Dungeons.D3.D3;
	import classes.Scenes.Inventory;
	import classes.internals.Utils;

	import coc.model.GameModel;
	import coc.model.TimeModel;
	import coc.view.MainView;
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

		protected function get combat():Combat
		{
			return kGAMECLASS.combat;
		}
		
		public function goNext(time:Number,defNext:Boolean):Boolean
		{
			return kGAMECLASS.goNext(time,defNext);
		}
		
		protected function awardAchievement(title:String, achievement:*, display:Boolean = true, nl:Boolean = false, nl2:Boolean = true):void
		{
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
		
		protected function get date():Date
		{
			return kGAMECLASS.date;
		}

		//Curse you, CoC updates!
		protected function get inDungeon():Boolean
		{
			return kGAMECLASS.inDungeon;
		}
		protected function set inDungeon(v:Boolean):void
		{
			kGAMECLASS.inDungeon = v;
		}
		
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

		/** Displays the sprite on the lower-left corner. */
		protected function spriteSelect(choice:Number = 0):void
		{
			kGAMECLASS.spriteSelect(choice);
		}
		
		/** Refreshes the stats panel. */
		protected function statScreenRefresh():void
		{
			kGAMECLASS.statScreenRefresh();
		}
		
		/** Displays the stats panel. */
		protected function showStats():void
		{
			kGAMECLASS.showStats();
		}

		/** Hide the stats panel. */
		protected function hideStats():void
		{
			kGAMECLASS.hideStats();
		}
		
		/** Hide the up/down arrows. */
		protected function hideUpDown():void
		{
			kGAMECLASS.hideUpDown();
		}

		/** Create a function that will pass one argument. */
		protected function createCallBackFunction(func:Function, arg:*):Function
		{
			return kGAMECLASS.createCallBackFunction(func,arg);
		}

		/** Create a function that will pass multiple arguments. 
		 * @deprecated	This function is deprecated.
		 */
		protected function createCallBackFunction2(func:Function, ...args):Function
		{
			return kGAMECLASS.createCallBackFunction2.apply(null,[func].concat(args));
		}

		protected function doSFWloss():Boolean {
			return kGAMECLASS.doSFWloss();
		}
		
		protected function showCredits():void {
			kGAMECLASS.creditsScreen();
		}
		
		/**
		 * Start a new combat.
		 * @param	monster_ The new monster to be initialized.
		 * @param	plotFight_ Determines if the fight is important. Also prevents randoms from overriding uniques.
		 */
		protected function startCombat(monster_:Monster,plotFight_:Boolean=false):void{
			kGAMECLASS.combat.beginCombat(monster_, plotFight_);
		}
		
		protected function startCombatImmediate(monster:Monster, _plotFight:Boolean = false):void
		{
			kGAMECLASS.combat.beginCombatImmediate(monster, _plotFight);
		}

		protected function displayHeader(text:String):void
		{
			kGAMECLASS.displayHeader(text);
		}
		
		// Needed in a few rare cases for dumping text coming from a source that can't properly escape it's brackets
		// (Mostly traceback printing, etc...)
		protected function rawOutputText(output:String, purgeText:Boolean = false):void
		{
			kGAMECLASS.rawOutputText(output, purgeText);
		}

		protected function outputText(output:String, purgeText:Boolean = false, parseAsMarkdown:Boolean = false):void
		{
			kGAMECLASS.outputText(output, purgeText, parseAsMarkdown);
		}
		
		protected function clearOutput():void
		{
			kGAMECLASS.currentText = "";
			kGAMECLASS.mainView.clearOutputText();
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
		
		/** Creates a menu with 10 buttons. 
		 * @deprecated	This is deprecated. Use a series of addButton instead.
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

		/** Creates a menu with 5 buttons. 
		 * @deprecated	This is deprecated. Use a series of addButton instead.
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

		protected function addButton(pos:int, text:String = "", func1:Function = null, arg1:* = -9000, arg2:* = -9000, arg3:* = -9000, toolTipText:String = "", toolTipHeader:String = ""):void
		{
			kGAMECLASS.addButton(pos, text, func1, arg1, arg2, arg3, toolTipText, toolTipHeader);
		}
		
		protected function addButtonDisabled(pos:int, text:String = "", toolTipText:String = "", toolTipHeader:String = ""):void
		{
			kGAMECLASS.addButtonDisabled(pos, text, toolTipText, toolTipHeader);
		}
		
		protected function removeButton(arg:*):void
		{
			kGAMECLASS.removeButton(arg);
		}

		protected function hasButton(arg:*):Boolean
		{
			return kGAMECLASS.hasButton(arg);
		}
		
		protected function openURL(url:String):void{
			return kGAMECLASS.openURL(url);
		}
		
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
		
		protected function get time():TimeModel
		{
			return kGAMECLASS.time;
		}
		
		protected function set time(val:TimeModel):void
		{
			kGAMECLASS.time = val;
		}
		
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
		
		protected function set mainView(val:*):void
		{
			kGAMECLASS.mainView = val;
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
				
		/**
		 * PRIMO BULLSHIT FUNCTION ACCESS
		 */
		// Need to work out a better way of doing this -- I THINK maybe treating external functions as a string and calling
		// addButton like "addButton(0, "thing", "thisFunc");" might be a way to do it -- check if Func var is a Func type in this.addbutton args
		// if it is, pass it into kGAMECLASS, if it isn't, check if string. If it is, use the string to pull the func from kGAMECLASS
		// before passing it into addbutton etc.
		// Going the string route also makes it... not awful to call into other content classes too - split string on . and chain
		// lookups into objects ie "umasShop.firstVisitPart1" -> kGAMECLASS["umasShop"].["firstVisitPart1"]()
		// @aimozg: but kGAMECLASS.umasShop.firstVisistPart1 instead of String is compile-time safe.
		// Clearly this isn't going to fly long term, but it's... functional for now.

	}

}