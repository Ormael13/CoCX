package classes.Scenes.Dungeons 
{
	import classes.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Dungeons.DungeonEngine;
	
	/**
	 * ...
	 * @author Kitteh6660
	 */
	public class DungeonAbstractContent extends BaseContent
	{
		protected function get dungeons():DungeonEngine {
			return kGAMECLASS.dungeons;
		}
		public function DungeonAbstractContent() 
		{	
		}
		
	}

}