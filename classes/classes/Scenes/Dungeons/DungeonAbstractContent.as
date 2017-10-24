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
		protected function get dungeons():DungeonEngine {
			return SceneLib.dungeons;
		}
		public function DungeonAbstractContent() 
		{	
		}
		
	}

}