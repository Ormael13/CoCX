package classes.Scenes.Dungeons 
{
	import classes.*;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Dungeons.DungeonCore;
	
	/**
	 * ...
	 * @author Kitteh6660
	 */
	public class DungeonAbstractContent extends BaseContent
	{
		protected function get dungeons():DungeonCore {
			return kGAMECLASS.dungeons;
		}
		public function DungeonAbstractContent() 
		{	
		}
		
	}

}