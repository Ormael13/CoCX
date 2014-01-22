package classes 
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.*;
	import classes.Scenes.Camp;
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

		protected function cheatTime(time:Number):void
		{
			kGAMECLASS.cheatTime(time);
		}
		protected function get timeQ():Number
		{
			return kGAMECLASS.timeQ;
		}

		protected function Num2Text(number:int):String
		{
			return kGAMECLASS.Num2Text(number);
		}
		protected  function num2Text2(number:int):String
		{
			return kGAMECLASS.num2Text2(number);
		}

		protected function get camp():Camp {
			return kGAMECLASS.camp;
		}

		public function goNext(time:Number,defNext:Boolean):Boolean
		{
			return kGAMECLASS.goNext(time,defNext);
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

		protected function get date():Date
		{
			return kGAMECLASS.date;
		}

		protected function inCombat():Boolean
		{
			return kGAMECLASS.inCombat();
		}

		protected function get inDungeon():Boolean
		{
			return kGAMECLASS.inDungeon;
		}
		protected function get itemSubMenu():Boolean
		{
			return kGAMECLASS.itemSubMenu;
		}
		protected function set itemSubMenu(value:Boolean):void
		{
			kGAMECLASS.itemSubMenu = value;
		}
		protected function showStats():void
		{
			kGAMECLASS.showStats();
		}

		protected function statScreenRefresh():void
		{
			kGAMECLASS.statScreenRefresh();
		}

		protected function cleanupAfterCombat():void
		{
			kGAMECLASS.cleanupAfterCombat();
		}

		protected function combatRoundOver():void
		{
			kGAMECLASS.combatRoundOver();
		}

		protected function enemyAI():void
		{
			kGAMECLASS.enemyAI();
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

		protected function curry(func:Function,...args):Function
		{
			return Utils.curry.apply(null,[func].concat(args));
		}
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

		protected function createCallBackFunction(func:Function, arg:*):Function
		{
			return kGAMECLASS.createCallBackFunction(func,arg);
		}

		protected function createCallBackFunction2(func:Function, ...args):Function
		{
			return kGAMECLASS.createCallBackFunction2.apply(null,[func].concat(args));
		}

		protected function startCombat(monster_:Monster,plotFight_:Boolean=false):void{
			kGAMECLASS.startCombat(monster_,plotFight_);
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
		
		protected function doNext(eventNo:*):void
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
		protected function choices(text1:String, butt1:*,
								text2:String, butt2:*,
								text3:String, butt3:*,
								text4:String, butt4:*,
								text5:String, butt5:*,
								text6:String, butt6:*,
								text7:String, butt7:*,
								text8:String, butt8:*,
								text9:String, butt9:*,
								text0:String, butt0:*):void
		{
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

		protected function simpleChoices(text1:String, butt1:*,
								text2:String, butt2:*,
								text3:String, butt3:*,
								text4:String, butt4:*,
								text5:String, butt5:*):void
		{
			kGAMECLASS.simpleChoices(text1, butt1,
					text2, butt2,
					text3, butt3,
					text4, butt4,
					text5, butt5);
		}

		protected function doYesNo(eventYes:*, eventNo:*):void {
			kGAMECLASS.doYesNo(eventYes,eventNo);
		}

		protected function addButton(pos:int, text:String = "", func1:Function = null, arg1:* = -9000):void
		{
			kGAMECLASS.addButton(pos, text, func1, arg1);
		}

		protected function hasButton(arg:*):Boolean
		{
			return kGAMECLASS.hasButton(arg);
		}

		protected function clearList():void{
			kGAMECLASS.clearList();
		}

		protected function addToList(arg:*):void{
			kGAMECLASS.addToList(arg);
		}

		protected function outputList():String{
			return kGAMECLASS.outputList();
		}
		
		protected function sackDescript():String
		{
			return kGAMECLASS.sackDescript();
		}
		
		protected function cockClit(value:int = 0):String
		{
			return kGAMECLASS.cockClit(value);
		}
		
		protected function balls(balls:*, noBalls:*):String
		{
			return kGAMECLASS.balls(balls, noBalls);
		}
		
		protected function sheathDesc():String
		{
			return kGAMECLASS.sheathDesc();
		}
		
		protected function chestDesc():String
		{
			return kGAMECLASS.chestDesc();
		}
		
		protected function allChestDesc():String
		{
			return kGAMECLASS.allChestDesc();
		}
		protected function allBreastsDescript():String
		{
			return kGAMECLASS.allBreastsDescript();
		}
		
		protected function sMultiCockDesc():String
		{
			return kGAMECLASS.sMultiCockDesc();
		}
		
		protected function SMultiCockDesc():String
		{
			return kGAMECLASS.SMultiCockDesc();
		}
		
		protected function oMultiCockDesc():String
		{
			return kGAMECLASS.oMultiCockDesc();
		}
		
		protected function OMultiCockDesc():String
		{
			return kGAMECLASS.OMultiCockDesc();
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

		protected function eBallsDescriptLight():String {
			return kGAMECLASS.eBallsDescriptLight();
		}
		protected function eBallsDescript():String {
			return kGAMECLASS.eBallsDescript();
		}

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
			return kGAMECLASS.eAssholeDescript();
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

		protected function npcBreastDescript(size:Number):String {
			return kGAMECLASS.npcBreastDescript(size);
		}
		
		protected  function eButtDescript():String {
			return kGAMECLASS.eButtDescript();
		}

		protected function num2TextBest(number:int, capitalised:Boolean = false, positional:Boolean = false):String
		{
			return kGAMECLASS.num2TextBest(number, capitalised, positional);
		}
		
		protected function num2Text(number:int):String
		{
			return kGAMECLASS.num2Text(number);
		}
		
		protected function nippleDescript(rowNum:Number):String
		{
			return kGAMECLASS.nippleDescript(rowNum);
		}
		
		protected function cockDescript(cockNum:Number = 0):String
		{
			return kGAMECLASS.cockDescript(cockNum);
		}
		
		protected function cockAdjective(cockNum:Number = -1):String
		{
			return kGAMECLASS.cockAdjective(cockNum);
		}
		
		protected function multiCockDescript():String
		{
			return kGAMECLASS.multiCockDescript();
		}
		
		protected function multiCockDescriptLight():String
		{
			return kGAMECLASS.multiCockDescriptLight();
		}
		
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
		
		protected function breastDescript(rowNum:Number):String
		{
			return kGAMECLASS.breastDescript(rowNum);
		}
		
		protected function cockHead(cockNum:Number = 0):String
		{
			return kGAMECLASS.cockHead(cockNum);
		}
		
		protected function breastSize(val:Number):String
		{
			return kGAMECLASS.breastSize(val);
		}
		
		protected function biggestBreastSizeDescript():String
		{
			return kGAMECLASS.biggestBreastSizeDescript();
		}
		
		protected function hairDescript():String
		{
			return kGAMECLASS.hairDescript();
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
		
		protected function breastCup(val:Number):String
		{
			return kGAMECLASS.breastCup(val);
		}

		protected function NPCCockDescript(cockType:*,cockLength:Number=0,lust:Number=50):String
		{
			return kGAMECLASS.NPCCockDescript(cockType,cockLength,lust);
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

		protected function fatigue(mod:Number,type:Number=0):void
		{
			kGAMECLASS.fatigue(mod,type);
		}


		protected function get eventParser():Function
		{
			return kGAMECLASS.eventParser;
		}
		
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
		
		protected function get tempPerk():String
		{
			return kGAMECLASS.tempPerk;
		}
		
		protected function set tempPerk(val:String):void
		{
			kGAMECLASS.tempPerk = val;
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
		protected function get inventory():Inventory{
			return kGAMECLASS.inventory;
		}

		protected function get itemSwapping():Boolean
		{
			return kGAMECLASS.itemSwapping;
		}
		
		protected function set itemSwapping(val:Boolean):void
		{
			kGAMECLASS.itemSwapping = val;
		}
		
		protected function get time():TimeModel
		{
			return kGAMECLASS.time;
		}
		
		protected function set time(val:TimeModel):void
		{
			kGAMECLASS.time = val;
		}
		
		protected function get menuLoc():Number
		{
			return kGAMECLASS.menuLoc;
		}
		
		protected function set menuLoc(val:Number):void
		{
			kGAMECLASS.menuLoc = val;
		}
		
		protected function get gameState():Number
		{
			return kGAMECLASS.gameState;
		}
		
		protected function set gameState(val:Number):void
		{
			kGAMECLASS.gameState = val;
		}

		protected function get itemSlots():Array
		{
			return kGAMECLASS.player.itemSlots;
		}
		
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
		
		protected function set mainView(val:MainView):void
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

		/* @aimozg commented this out because telAdre
		protected function get armorShops():Function
		{
			return kGAMECLASS.armorShops;
		}

		protected function get telAdreMenu():Function
		{
			return kGAMECLASS.telAdreMenu;
		}*/

	}

}