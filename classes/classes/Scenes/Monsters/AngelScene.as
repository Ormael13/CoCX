package classes.Scenes.Monsters 
{
import classes.*;
//import classes.GlobalFlags.kACHIEVEMENTS;
//import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
//import classes.display.SpriteDb;

use namespace CoC;

	public class AngelScene extends BaseContent
	{
		
		public function AngelScene() 
		{
		}
		
		public function angelGroupEncounter():void {
			clearOutput();
			outputText("During your searching thou current location you suddenly hear sound of many wings flapping.  Turning around you notice a large group of angels flying toward you.  In no time they catch up to you and surrounds whispering. \"<i>Don't be afraid!!!</i>\"  No way around it, you ready your [weapon] for the fight.");
			startCombat(new AngelGroup());
			//camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_IMPS);
			doNext(playerMenu);
		}
		
	}
}