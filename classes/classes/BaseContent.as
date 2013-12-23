package classes 
{
	import classes.GlobalFlags.kGAMECLASS;
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
	public class BaseContent 
	{		
		public function BaseContent() 
		{
			
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
		
		protected function doNext(eventNo:int):void
		{
			kGAMECLASS.doNext(eventNo);
		}
		
		protected function menu():void
		{
			kGAMECLASS.menu();
		}
		
		protected function addButton(pos:int, text:String = "", func1:Function = null, arg1:* = -9000):void
		{
			kGAMECLASS.addButton(pos, text, func1, arg1);
		}
		
		protected function rand(maxVal:Number):Number
		{
			return kGAMECLASS.rand(maxVal);
		}
		
		protected function urtaLove(value:Number = 0):Boolean
		{
			return kGAMECLASS.urtaLove(value);
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
		
		protected function cockDescript(cockNum:Number):String
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
		
		protected function eCockDescript(cockIndex:Number):String
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
		
		protected function get itemSlot1():ItemSlotClass
		{
			return kGAMECLASS.itemSlot1;
		}
		
		protected function get itemSlot2():ItemSlotClass
		{
			return kGAMECLASS.itemSlot2;
		}
		
		protected function get itemSlot3():ItemSlotClass
		{
			return kGAMECLASS.itemSlot3;
		}
		
		protected function get itemSlot4():ItemSlotClass
		{
			return kGAMECLASS.itemSlot4;
		}
		
		protected function get itemSlot5():ItemSlotClass
		{
			return kGAMECLASS.itemSlot5;
		}
		
		protected function set itemSlot1(val:ItemSlotClass):void
		{
			kGAMECLASS.itemSlot1 = val;
		}
		
		protected function set itemSlot2(val:ItemSlotClass):void
		{
			kGAMECLASS.itemSlot2 = val;
		}
		
		protected function set itemSlot3(val:ItemSlotClass):void
		{
			kGAMECLASS.itemSlot3 = val;
		}
		
		protected function set itemSlot4(val:ItemSlotClass):void
		{
			kGAMECLASS.itemSlot4 = val;
		}
		
		protected function set itemSlot5(val:ItemSlotClass):void
		{
			kGAMECLASS.itemSlot5 = val;
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
		
		protected function get shortName():String
		{
			return kGAMECLASS.shortName;
		}
		
		protected function set shortName(val:String):void
		{
			kGAMECLASS.shortName = val;
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
		// Clearly this isn't going to fly long term, but it's... functional for now.
		protected function get armorShops():Function
		{
			return kGAMECLASS.armorShops;
		}
		
		protected function get telAdreMenu():Function
		{
			return kGAMECLASS.telAdreMenu;
		}

	}

}