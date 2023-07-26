/**
 * @author Ormael
 * Area with lvl 15-25 enemies.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas
{
import classes.BaseContent;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.SceneLib;

public class DeepDesert extends BaseContent
	{
		//public var gorgonScene:GorgonScene = new GorgonScene();przenieść do deep desert potem
		
		public function DeepDesert() {
			onGameInit(init);
		}

		private var _deepDesertEncounter: GroupEncounter = null;
		public function get deepDesertEncounter():GroupEncounter {
			return _deepDesertEncounter;
		}

		private function init():void {
			_deepDesertEncounter = Encounters.group("deepdesert", {

			})
		}
		
		public const areaLevel:int = 65;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.desertDeep > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= areaLevel;
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.desertDeep;
		}

		public function exploreDeepDesert():void {
			clearOutput();
			SceneLib.exploration.counters.desertDeep++;
			doNext(camp.returnToCampUseOneHour);
			deepDesertEncounter.execEncounter();
			flushOutputTextToGUI();
		}
	}
}
