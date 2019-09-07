//Dungeon 4: Mine
/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Dungeons 
{
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;

	public class Mine extends DungeonAbstractContent
	{
		
		public function Mine() 
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