//Side Dungeon: Bee Hive
/**
 * ...
 * @author Liadri and others
 */
package classes.Scenes.Dungeons 
{
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;

	public class BeeHive extends DungeonAbstractContent
	{
		
		public function BeeHive() 
		{
			
		}
		
		public function exitDungeon():void {
			inDungeon = false;
			clearOutput();
			outputText("You leave the river dungeon behind and take off through the He'Xin'Dao back towards camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		
	}

}