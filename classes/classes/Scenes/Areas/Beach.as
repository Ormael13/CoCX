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
import classes.Scenes.Areas.Beach.*;
import classes.Scenes.NPCs.CeaniScene;
import classes.Scenes.SceneLib;

//import classes.Scenes.NPCs.CaiLin;

	use namespace CoC;
	
	public class Beach extends BaseContent 
	{
		public var ceaniScene:CeaniScene = new CeaniScene();
		public var demonsPack:DemonPackBeachScene = new DemonPackBeachScene();
		public var pinchoushop:PinchousWaterwearAndTools = new PinchousWaterwearAndTools();
		//public var gorgonScene:GorgonScene = new GorgonScene();przenieść do deep desert potem

		public function Beach() 
		{
		}
		
		public function exploreBeach():void {
			flags[kFLAGS.DISCOVERED_BEACH]++;
			
			//Harpoon gun
			if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns3) && player.statusEffectv2(StatusEffects.TelAdreTripxiGuns3) == 0 && player.statusEffectv2(StatusEffects.TelAdreTripxi) == 1 && rand(2) == 0) {
				partsofHarpoonGun();
				return;
			}
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !SceneLib.helScene.followerHel()) {
				SceneLib.helScene.helSexualAmbush();
				return;
			}
			//Etna
			if (flags[kFLAGS.ETNA_FOLLOWER] < 1 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && rand(5) == 0 && (player.level >= 20)) {
				player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
				SceneLib.etnaScene.repeatYandereEnc();
				return;
			}
			
			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0;	//Stronger than oasis demons pack
			if (rand(2) == 0) choice[choice.length] = 1;	//Pichou shop
			if (rand(2) == 0) choice[choice.length] = 2;	//Orca TF
			if (rand(4) == 0) choice[choice.length] = 3;	//Find nothing! The rand will be removed from this once the Beach is populated with more encounters.
			
			//Finding Sea Boat
			if ((flags[kFLAGS.DISCOVERED_BEACH] >= 10) && flags[kFLAGS.DISCOVERED_OCEAN] <= 0 && rand(3) == 0) {
				discoverSeaBoat();
				return;
			}
			
			//Cai'Lin
		//	if (flags[kFLAGS.CAILIN_FOLLOWER] == 1 && rand(5) == 0) {
		//		outputText("Suprise! Another new enocunter ;) Get ready to brambleeeeeeeee!!!!\n\n", true);
		//		startCombat(new CaiLin());
		//		return;
		//	}
			
			//Ceani
			if (flags[kFLAGS.CEANI_FOLLOWER] < 1 && flags[kFLAGS.CEANI_DAILY_TRAINING] < 1 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] < 4 && player.gems >= 50 && rand(3) == 0) {
				if (flags[kFLAGS.CEANI_AFFECTION] >= 2 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] < 4) {
					ceaniScene.basicarcherytraining();
					return;
				}
				else {
					ceaniScene.firstmeetingCeani();
					return;
				}
			}
			if ((model.time.hours >= 6 && model.time.hours <= 11) && flags[kFLAGS.CEANI_FOLLOWER] < 1 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 4) {
				ceaniScene.beachInteractionsAfterArcheryTraining();
				return;
			}
			
			select = choice[rand(choice.length)];
			switch(select) {
				case 0:
					player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
					demonsPack.demonspackEncounter();
					break;
			//	case 1:
			//		if (flags[kFLAGS.CAILIN_FOLLOWER] <= 0) {
			//			flags[kFLAGS.CAILIN_FOLLOWER] = 1;
			//			flags[kFLAGS.CAILIN_LVL_UP] = 0;
			//		}
			//		gorgonScene.gorgonEncounter();
			//		break;
				case 1:
					if (flags[kFLAGS.PINCHOU_SHOP] >= 1) pinchoushop.encounteringPinchouRepeat();
					else pinchoushop.encounteringPinchouFirst();
					break;
				case 2:
					clearOutput();
					outputText("As you walk on the beach you find a weird black bottle with a white line and a cap. You pick it up and read the tag. It claims to be 'Orca sunscreen'. ");
					inventory.takeItem(consumables.ORCASUN, camp.returnToCampUseOneHour);
					break;
				default:
					clearOutput();
					outputText("You walk through the sunny beach for an hour, finding nothing.\n\n");
					if (rand(2) == 0) {
						//50/50 strength/toughness
						if (rand(2) == 0 && player.str < 100) {
							outputText("The effort of struggling with the sand has made you stronger.");
							dynStats("str", .5);
						}
						//Toughness
						else if (player.tou < 100) {
							outputText("The effort of struggling with the sand has made you tougher.");
							dynStats("tou", .5);
						}
					}
					doNext(camp.returnToCampUseOneHour);
			}
		}
		
		public function discoverSeaBoat():void {
			flags[kFLAGS.DISCOVERED_OCEAN] = 1;
			clearOutput();
			outputText("You journey around the beach, seeking demons to fight");
			if(player.cor > 60) outputText(" or fuck");
			outputText(".  The air is fresh, and the sand is cool under your feet.   Soft waves lap against the muddy sand of the sea-shore.   You pass around a few dunes carefully, being wary of hidden 'surprises', and come upon a small dock.  The dock is crafted from old growth trees lashed together with some crude rope.  Judging by the appearance of the rope, it is very old and has not been seen to in quite some time.  Tied to the dock is a small rowboat, only about seven feet long and three feet wide.   The boat appears in much better condition than the dock, and appears to be brand new.\n\n");
			outputText("<b>You have discovered the sea boat!</b>");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function partsofHarpoonGun():void {
			clearOutput();
			outputText("As you explore the beach you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Harpoon gun in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns3, 2, 1);
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Harpoon gun", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}
	}
}