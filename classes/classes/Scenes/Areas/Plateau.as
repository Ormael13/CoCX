/**
 * @author Ormael
 * Area with lvl 35-55 enemies.
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

	public class Plateau extends BaseContent
	{
		
		public function Plateau() 
		{
		}
		
		//lvl 35 enemy for sure added
		
		public var darkelfScene:DarkElfScene = new DarkElfScene();
	}
}