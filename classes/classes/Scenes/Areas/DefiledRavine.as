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
import classes.Scenes.Areas.BlightRidge.DemonScene;
import classes.Scenes.Areas.DefiledRavine.*;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class DefiledRavine extends BaseContent
	{
		public var TrueDemons:DemonScene = new DemonScene();
		
		public function DefiledRavine() 
		{
		}
		
		public function exploreDefiledRavine():void {
			flags[kFLAGS.DISCOVERED_DEFILED_RAVINE]++;
			if (player.cor < 71) dynStats("cor", 1.5);
			
			var choice:Array = [];
			var select:int;
			//Dragon Demon, Demon Soldier, Demon Pristress, even stronger imp variants (ayo/flesh golem versions?), Kitsune Demon - Kumiho, Salamander Demon
			//Build choice list!
			//choice[choice.length] = 0; //???Demon Centauress/Demon Pack/super buffed imp variant??? (lvl 41)
			choice[choice.length] = 0; //Cow Succubus (lvl 45)/Mino Incubus (lvl 46)
			//choice[choice.length] = 0; //???Demon Pack/Demon Centauress/Kumiho??? (lvl 52)
			//choice[choice.length] = 0; //???Demon Pack/Demon Centauress??? (lvl 56)
			choice[choice.length] = 1; //Corrupted Improved Flesh Golem (lvl 59)/Corrupted Improved Flesh Golems(lvl 61)
			choice[choice.length] = 2; //Imp Food
			if (rand(4) == 0) choice[choice.length] = 3; //Find nothing! The rand will be removed from this once the Defiled Ravine is populated with more encounters.
			
			select = choice[rand(choice.length)];
			switch(select) {
				/*case 0:
					SceneLib.exploration.genericImpEncounters2();
					break;*/
				case 0:
					if (rand(2) == 0) TrueDemons.CowSuccubusEncounter();
					else TrueDemons.MinoIncubusEncounter();
					break;
				/*case 2:
					SceneLib.exploration.();
					break;
				case 3:
					SceneLib.exploration.();
					break;*/
				case 1:
					SceneLib.fleshGolemScenes.introCorruptedImprovedFleshGolemS();
					return;
				case 2:
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