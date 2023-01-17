/**
 * @author Ormael
 * Area with lvl ?60-90? enemies.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas 
{
import classes.BaseContent;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;

public class Jungle extends BaseContent
	{
		
		public function Jungle() {
			onGameInit(init);
		}

		private var _jungleEncounter:GroupEncounter = null;
		public function get jungleEncounter():GroupEncounter {
			return _jungleEncounter;
		}

		private function init():void {
			_jungleEncounter = Encounters.group("jungle", {

			});
		}

		public function isDiscovered():Boolean {
			return false;//flags[kFLAGS.DISCOVERED_INNER_BATTLEFIELD] > 0;
		}
		public function timesExplored():int {
			return 0; //flags[kFLAGS.DISCOVERED_INNER_BATTLEFIELD];
		}

		public function exploreJungle():void {
			clearOutput();
			//flags[kFLAGS.DISCOVERED_INNER_BATTLEFIELD]++;
			doNext(camp.returnToCampUseOneHour);
			jungleEncounter.execEncounter();
			flushOutputTextToGUI();
		}
	}

}