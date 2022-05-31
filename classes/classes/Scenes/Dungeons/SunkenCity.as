/**
 * Side Dungeon: The Sunken City (aka CoC-ish eldritch monstrosity from the ages of the gods lair)
 * @author Liadri
 */
package classes.Scenes.Dungeons 
{
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;

	public class SunkenCity extends DungeonAbstractContent
	{
		
		public function SunkenCity() 
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