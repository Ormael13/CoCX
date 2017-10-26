package classes.Scenes.Dungeons 
{
import classes.*;
import classes.Scenes.SceneLib;

/**
	 * ...
	 * @author Kitteh6660
	 */
	public class DungeonAbstractContent extends BaseContent
	{
        public static var inDungeon:Boolean = false;

        public static var dungeonLoc:int = 0;

        public static var inRoomedDungeon:Boolean = false;

        public static var inRoomedDungeonResume:Function = null;

        protected function get dungeons():DungeonEngine {
			return SceneLib.dungeons;
		}
		public function DungeonAbstractContent() 
		{	
		}
		
	}

}