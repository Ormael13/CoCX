/**
 * @author Ormael
 * Area with lvl 15-25 enemies.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas 
{
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;

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

		public function isDiscovered():Boolean {
			return flags[kFLAGS.DISCOVERED_CAVES] > 0;
		}
		public function timesExplored():int {
			return flags[kFLAGS.DISCOVERED_CAVES];
		}

		public function exploreDeepDesert():void {
			clearOutput();
			flags[kFLAGS.DISCOVERED_CAVES]++;
			doNext(camp.returnToCampUseOneHour);
			deepDesertEncounter.execEncounter();
			flushOutputTextToGUI();
		}
	}
}