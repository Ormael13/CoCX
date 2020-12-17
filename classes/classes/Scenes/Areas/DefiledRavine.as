/**
 * @author Ormael
 * Demon area with lvl 41-61 demonic enemies. Each exploration will even slowly corrupt PC unless corruption is above 71.
 * Currently a Work in Progress.
 */

package classes.Scenes.Areas 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.Areas.DefiledRavine.*;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class DefiledRavine extends BaseContent
	{
		
		public function DefiledRavine() 
		{
		}
		
		public function exploreDefiledRavine():void {
			flags[kFLAGS.DISCOVERED_DEFILED_RAVINE]++;
			if (player.cor < 71) dynStats("cor", 1.5);
			
			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			//choice[choice.length] = 0; //Demon Centauress (lvl 41)
			//choice[choice.length] = 0; //Cow Succubus (lvl 45)
			//choice[choice.length] = 0; //Mino Incubus (lvl 46)
			//choice[choice.length] = 0; // (lvl 51)
			//choice[choice.length] = 0; // (lvl 57)
			//choice[choice.length] = 0; //Corrupted Improved Flesh Golem (lvl 59)/Corrupted Improved Flesh Golems(lvl 61)
			choice[choice.length] = 0; //Imp Food
			if (rand(4) == 0) choice[choice.length] = 1; //Find nothing! The rand will be removed from this once the Blight Ridge is populated with more encounters.
			
			select = choice[rand(choice.length)];
			switch(select) {
				/*case 0:
					SceneLib.exploration.genericImpEncounters2();
					break;
				case 1:
					SceneLib.exploration.genericDemonsEncounters1();
					break;*/
				case 0:
					clearOutput();
					outputText("You spot something on the ground. Taking a closer look, it's one of those imps food packages. ");
					inventory.takeItem(consumables.IMPFOOD, camp.returnToCampUseOneHour);
					break;
				default:
					clearOutput();
					outputText("You spend one hour exploring the tainted ravine but you don't manage to find anything interesting, unless feeling of becoming slight more horny counts.");
					dynStats("lib", 1);
					doNext(camp.returnToCampUseOneHour);
			}
		}
	}
}