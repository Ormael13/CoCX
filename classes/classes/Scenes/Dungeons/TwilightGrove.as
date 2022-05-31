/**
 * Side Dungeon: Twilight Grove (Corrupted Alraune grove)
 * @author Liadri
 */
package classes.Scenes.Dungeons 
{
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;

	public class TwilightGrove extends DungeonAbstractContent
	{
		
		public function TwilightGrove() 
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