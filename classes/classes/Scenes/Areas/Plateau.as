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
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Caves.*;
import classes.Scenes.Monsters.DarkElfScene;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class Plateau extends BaseContent
	{
		
		public function Plateau() 
		{
			onGameInit(init);
		}

		private var _plateauEncounter:GroupEncounter = null;
		public function get plateauEncounter():GroupEncounter {
			return _plateauEncounter;
		}

		private function init():void {
			_plateauEncounter = Encounters.group("plateau", {

			})
		}

		public function explorePlateau():void {
			clearOutput();
			//flags[kFLAGS.TIMES_EXPLORED_PLAINS]++;
			doNext(camp.returnToCampUseOneHour);
			plateauEncounter.execEncounter();
			flushOutputTextToGUI();
		}
		
		//lvl 35 enemy for sure added
		
		public var darkelfScene:DarkElfScene = new DarkElfScene();

	}
}