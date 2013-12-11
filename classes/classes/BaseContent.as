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
		
		protected function get itemSlot1():itemSlotClass
		{
			return kGAMECLASS.itemSlot1;
		}
		
		protected function get itemSlot2():itemSlotClass
		{
			return kGAMECLASS.itemSlot2;
		}
		
		protected function get itemSlot3():itemSlotClass
		{
			return kGAMECLASS.itemSlot3;
		}
		
		protected function get itemSlot4():itemSlotClass
		{
			return kGAMECLASS.itemSlot4;
		}
		
		protected function get itemSlot5():itemSlotClass
		{
			return kGAMECLASS.itemSlot5;
		}
		
		protected function set itemSlot1(val:itemSlotClass):void
		{
			kGAMECLASS.itemSlot1 = val;
		}
		
		protected function set itemSlot2(val:itemSlotClass):void
		{
			kGAMECLASS.itemSlot2 = val;
		}
		
		protected function set itemSlot3(val:itemSlotClass):void
		{
			kGAMECLASS.itemSlot3 = val;
		}
		
		protected function set itemSlot4(val:itemSlotClass):void
		{
			kGAMECLASS.itemSlot4 = val;
		}
		
		protected function set itemSlot5(val:itemSlotClass):void
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