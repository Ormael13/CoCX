/**
 * @author Ormael
 * Area with lvl 65-95 enemies.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;
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
		
		public const areaLevel:int = 65;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.deepCaves > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= areaLevel;
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.deepCaves;
		}


		public function exploreCaves():void {
			clearOutput();
			SceneLib.exploration.counters.deepCaves++;
			doNext(camp.returnToCampUseOneHour);
			deepCavesEncounter.execEncounter();
			flushOutputTextToGUI();
		}//lvl 65 - dark elf sniper caves ver
	}
}
