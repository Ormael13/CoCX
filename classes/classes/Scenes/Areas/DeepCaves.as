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
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Caves.*;
import classes.Scenes.Monsters.DarkElfScene;
import classes.Scenes.SceneLib;

use namespace CoC;
	
	public class DeepCaves extends BaseContent
	{
		
		public function DeepCaves() {
			onGameInit(init);
		}

		private var _deepCavesEncounter:GroupEncounter = null;
		public function get deepCavesEncounter():GroupEncounter {
			return _deepCavesEncounter;
		}

		private function init():void {
			_deepCavesEncounter = Encounters.group("deepcaves", {

			})
		}

		public function isDiscovered():Boolean {
			return flags[kFLAGS.DISCOVERED_CAVES] > 0;
		}
		public function timesExplored():int {
			return flags[kFLAGS.DISCOVERED_CAVES];
		}


		public function exploreCaves():void {
			clearOutput();
			flags[kFLAGS.DISCOVERED_CAVES]++;
			doNext(camp.returnToCampUseOneHour);
			deepCavesEncounter.execEncounter();
			flushOutputTextToGUI();
		}//lvl 65 - dark elf sniper caves ver
	}
}