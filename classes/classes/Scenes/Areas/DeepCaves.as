/**
 * @author Ormael
 * Area with lvl 65-95 enemies.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.Areas.Caves.*;
import classes.Scenes.Monsters.DarkElfScene;
import classes.Scenes.SceneLib;

use namespace CoC;
	
	public class DeepCaves extends BaseContent
	{
		
		public function DeepCaves() 
		{
		}
		
		public function exploreCaves():void {
			flags[kFLAGS.DISCOVERED_CAVES]++;
			
			
		}//lvl 65 - dark elf sniper caves ver
	}
}