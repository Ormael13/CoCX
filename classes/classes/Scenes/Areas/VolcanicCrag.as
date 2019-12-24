/**
 * Created by Kitteh6660. Volcanic Crag is a area with level 30 encounters.	(outer lvl 60-80, inner lvl 85-110)
 * Currently a Work in Progress.
 * 
 * This zone was mentioned in Glacial Rift doc.
 */

package classes.Scenes.Areas 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Forest.AlrauneScene;
import classes.Scenes.Areas.HighMountains.PhoenixScene;
import classes.Scenes.Areas.VolcanicCrag.*;
import classes.Scenes.Holidays;
import classes.Scenes.SceneLib;

public class VolcanicCrag extends BaseContent
	{
		public var behemothScene:BehemothScene = new BehemothScene();
		public var phoenixScene:PhoenixScene = new PhoenixScene();
		public var alrauneScene:AlrauneScene = new AlrauneScene();
		public var hellcatScene:HellCatScene = new HellCatScene();
		
		public function VolcanicCrag() 
		{
		}
		
		public function exploreVolcanicCrag():void {
			flags[kFLAGS.DISCOVERED_VOLCANO_CRAG]++;
			doNext(playerMenu);

			var choice:Array = [];
			var select:int;
			
			//Build choice list!
			choice[choice.length] = 0; //Behemoth
			if (flags[kFLAGS.HEL_PHOENIXES_DEFEATED] > 0) choice[choice.length] = 1; //Phoenix
			if (rand(3) == 0) choice[choice.length] = 2; //Find Drake's Heart
			choice[choice.length] = 3; //Fire True Golems
			choice[choice.length] = 4; //Cinderbloom
			if (rand(3) == 0) choice[choice.length] = 5; //Find nothing! The rand will be removed from this once the Volcanic Crag is populated with more encounters.
			
			//DLC april fools
			if (isAprilFools() && flags[kFLAGS.DLC_APRIL_FOOLS] == 0) {
                Holidays.DLCPrompt("Extreme Zones DLC", "Get the Extreme Zones DLC to be able to visit Glacial Rift and Volcanic Crag and discover the realms within!", "$4.99");
                return;
			}
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !SceneLib.helScene.followerHel()) {
				SceneLib.helScene.helSexualAmbush();
				return;
			}
			//Etna
			if (flags[kFLAGS.ETNA_FOLLOWER] < 1 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && !player.hasStatusEffect(StatusEffects.EtnaOff) && rand(5) == 0) {
				SceneLib.etnaScene.repeatYandereEnc();
				return;
			}
			//Tripxi Fatbilly
			if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns3) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns3) == 0 && player.statusEffectv2(StatusEffects.TelAdreTripxi) == 1 && rand(2) == 0) {
				partsofTripxiFatbilly();
				return;
			}
			select = choice[rand(choice.length)];
			switch(select) {
				case 0:
					behemothScene.behemothIntro();
					break;
				case 1:
					if (flags[kFLAGS.HEL_PHOENIXES_DEFEATED] > 0) phoenixScene.encounterPhoenix2();
					else behemothScene.behemothIntro();
					break;
				case 2:
					clearOutput();
					outputText("While you're minding your own business, you spot a flower. You walk over to it, pick it up and smell it. By Marae, it smells amazing! It looks like Drake's Heart as the legends foretold. ");
					inventory.takeItem(consumables.DRAKHRT, camp.returnToCampUseOneHour);
					break;
				case 3: //True Fire Golems
					clearOutput();
					outputText("As you take a stroll, from nearby cracks emerge group of golems. Looks like you have encountered some true fire golems! You ready your [weapon] for a fight!");
					startCombat(new GolemsTrueFire());
					break;
				case 4:	//Cinderbloom
					clearOutput();
					if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
						outputText("You can smell the thick scent of particularly strong pollen in the air. The book mentioned something about this but you don’t recall exactly what. Do you turn back to camp?\n\n");
						menu();
						addButton(0, "Yes", camp.returnToCampUseOneHour);
						addButton(1, "No", alrauneScene.alrauneVolcanicCrag);
					} else {
						alrauneScene.alrauneVolcanicCrag();
					}
					break;
				case 5:	//Hellcat/Witches Sabbath
					if ((flags[kFLAGS.WITCHES_SABBATH] > 3 && player.hellcatScore() > 9 && player.gender == 3) || (flags[kFLAGS.WITCHES_SABBATH] > 0 && player.catScore() >= 8 && player.inte >= 40 && player.hasStatusEffect(StatusEffects.KnowsWhitefire))) SceneLib.volcanicCrag.hellcatScene.WitchesSabbath();
					else SceneLib.volcanicCrag.hellcatScene.HellCatIntro();
					break;
				default:
					clearOutput();
					outputText("You spend one hour exploring the infernal landscape but you don't manage to find anything interesting, yet you this time you managed walk a little further inside this place than the last time.");
					dynStats("spe", .5);
					doNext(camp.returnToCampUseOneHour);
			}
		}
		
		public function partsofTripxiFatbilly():void {
			clearOutput();
			outputText("As you explore the beach you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Tripxi Fatbilly in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns3, 1, 1);
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Tripxi Fatbilly", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}
	}
}