//Quest Dungeon: The Ebon Labyrinth (for Alvina Black Rose Quest)
/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Dungeons 
{
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;

	public class EbonLabyrinth extends DungeonAbstractContent
	{
		
		public function EbonLabyrinth() 
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