/**
 * @author Stadler (mostly) and Ormael (choice of enemies encounters and other events)
 * Area with lvl 30-45 enemies.
 * Currently a Work in Progress.
 */

package classes.Scenes.Areas 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.Areas.Ocean.*;
import classes.Scenes.NPCs.CeaniScene;
import classes.Scenes.Places.Boat.SharkGirlScene;
import classes.Scenes.SceneLib;

use namespace CoC;
	
	public class Ocean extends BaseContent
	{
		public var ceaniScene:CeaniScene = new CeaniScene();
		public var sharkGirlScene:SharkGirlScene = new SharkGirlScene();
		public var scyllaScene:ScyllaScene = new ScyllaScene();
		
		public function Ocean() 
		{
		}
		
		public function exploreOcean():void {
			flags[kFLAGS.DISCOVERED_OCEAN]++;
			
			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0;	//SeaAnemone
		//	choice[choice.length] = 1;	//Scylla
			choice[choice.length] = 1;	//Shark girl
			choice[choice.length] = 2;	//Tiger Shark girl
			if (player.hasKeyItem("Fishing Pole") >= 0) choice[choice.length] = 3;	//Fishing
			if (rand(4) == 0) choice[choice.length] = 4;	 //Find nothing! The rand will be removed from this once the Ocean is populated with more encounters.
			
			//Ceani
			if ((model.time.hours >= 12 && model.time.hours <= 22) && flags[kFLAGS.CEANI_FOLLOWER] < 1 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 4) {
				ceaniScene.oceanInteractionsAfterArcheryTraining();
				return;
			}
			
			select = choice[rand(choice.length)];
			switch(select) {
				case 0:
					flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] = 2;
					player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
					SceneLib.anemoneScene.mortalAnemoneeeeee();
					break;
			/*	case 1:
					scyllaScene.oceanScyllaEncounter();
					break;
			*/	case 1:
					flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] = 1;
					player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
					sharkGirlScene.oceanSharkGirlEncounter();
					break;
				case 2:
					flags[kFLAGS.SHARK_OR_TIGERSHARK_GIRL] = 2;
					player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
					sharkGirlScene.oceanTigersharkGirlEncounter();
					break;
				case 3:
					outputText("This is a calm day on the ocean, you managed to hold your boat just a mile or two away from the brewing storm that constantly rage over the area and, while you found nothing of note, couldn’t help yourself but to enjoy a few hour using your newly acquired fishing pole.\n\n");
					outputText("<b>You got a fish!</b>");
					inventory.takeItem(consumables.FREFISH, camp.returnToCampUseOneHour);
					break;
				default:
					clearOutput();
					outputText("You row for over an hour, until your arms practically burn with exhaustion from all the rowing.\n\n");
					if (rand(2) == 0) {
						//50/50 strength/speed
						if (rand(2) == 0 && player.str < 150) {
							outputText("Despite tiredness you feel that you became stronger.");
							dynStats("str", .5);
						}
						//Toughness
						else if (player.spe < 150) {
							outputText("Despite tiredness you feel that you became faster.");
							dynStats("spe", .5);
						}
					}
					doNext(camp.returnToCampUseTwoHours);
			}
			
		}
		
	}

}