package classes.Scenes.NPCs 
{
	import classes.BaseContent;
	import classes.CoC;
	import classes.GlobalFlags.kGAMECLASS;
import classes.Scenes.Camp;

import coc.xxc.Story;
	
	/**
	 * ...
	 * @author Oxdeception
	 */
	public class XXCNPC extends BaseContent
	{
		public static const COMPANION:int = -1;
		public static const FOLLOWER:int = 0;
		public static const LOVER:int = 1;
		public static const SLAVE:int = 2;
		
		protected var story:Story;
		protected var _storyName:String;
		
		public function XXCNPC(storyName:String) 
		{
			_storyName = storyName;
			if(!kGAMECLASS||kGAMECLASS.rootStory == null){
				CoC.onGameInit(init);
			}
			else {init();}
		}
		private function init():void{
			story = kGAMECLASS.rootStory.locate(_storyName);
		}
		public function display(toDisplay:String):void
		{
			story.display(context, toDisplay);
		}
		protected function displaySimple(path:String):void{
			clearOutput();
			display(path);
			menu();
			doNext(camp.returnToCampUseOneHour);
		}
		public function save(saveto:*):void{
			
		}
		public function load(loadfrom:*):void{
			
		}
		public function campInteraction():void{
			
		}
		public function campDescription(menuType:int = -1, descOnly:Boolean = false ):Boolean
		{
			return false;
		}
		public function checkCampEvent():Boolean{
			return false;
		}
		public function isCompanion(type:int = -1):Boolean{
			return false;
		}
		public function get Name():String{
			return _storyName;
		}
	}
}