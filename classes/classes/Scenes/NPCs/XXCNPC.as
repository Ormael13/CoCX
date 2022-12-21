package classes.Scenes.NPCs 
{
import classes.BaseContent;
import classes.CoC;

import coc.view.ButtonDataList;

import coc.xxc.BoundStory;

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

        private static var _savedNPCs:Vector.<XXCNPC> = new Vector.<XXCNPC>();

        /**
		 * The classes added to this list require a static getter for instance
         * @param toAdd
         */
        protected static function addSavedNPC(toAdd:XXCNPC):void{
            _savedNPCs.push(toAdd);
        }
        public static function get SavedNPCs():Vector.<XXCNPC>{
            return _savedNPCs;
        }
		public static function unloadSavedNPCs():void{
			for each(var npc:XXCNPC in _savedNPCs){
				npc.unload();
			}
			_savedNPCs = new Vector.<XXCNPC>();
		}
		protected var _story:BoundStory;
		protected var _storyName:String;
		protected function get story():BoundStory{
			if(!_story){
				_story = CoC.instance.rootStory.locate(_storyName).bind(CoC.instance.context);
			}
			return _story
		}

		public function XXCNPC(storyName:String)
		{
			_storyName = storyName;
		}
		public function display(toDisplay:String,locals:*=null):void
		{
			story.display(toDisplay,locals);
		}
		public function save(saveto:*):void{

		}
		public function load(loadfrom:*):void{

		}
		public function campInteraction():void{

		}
		public function campDescription(buttons:ButtonDataList,menuType:int = -1):void {

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

        /**
		 * Unloads the instance of an XXCNPC
		 * This needs to be overriden by child classes clear their
		 * _instanace variables from any lists they've been addded to
         */
		public function unload():void{
			throw new Error("Must be overloaded by child class");
		}
		public function scene(ref:String,locals:*=null,next:Function=null):void{
			clearOutput();
			display(ref,locals);
			doNext(next!=null?next:camp.returnToCampUseOneHour);
		}
    }
}