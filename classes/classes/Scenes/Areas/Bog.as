/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Bog.*;
import classes.Scenes.Dungeons.DemonLab;
import classes.Scenes.NPCs.EtnaFollower;
import classes.Scenes.SceneLib;

public class Bog extends BaseContent
	{
		public var frogGirlScene:FrogGirlScene = new FrogGirlScene();
		public var chameleonGirlScene:ChameleonGirlScene = new ChameleonGirlScene();
		public var phoukaScene:PhoukaScene = new PhoukaScene();
		public var lizanScene:LizanRogueScene = new LizanRogueScene();
		
		public function Bog()
		{
		}
		public function exploreBog():void
		{
			var chooser:int = rand(6);
			if (chooser == 0) {
				if (player.buttPregnancyIncubation != 0) chooser++;
			}


			var choice:Array = [];
			var select:int;

			//Build choice list!
			if (flags[kFLAGS.TIMES_ENCOUNTERED_FROG] != -1) choice[choice.length] = 0; //Frog girl encounter
			choice[choice.length] = 1; //Phouka
			choice[choice.length] = 2; //Chameleon
			choice[choice.length] = 3; //Lizan
			choice[choice.length] = 4; //Troll
			if (DemonLab.MainAreaComplete >= 4)
				choice[choice.length] = 5;

			if (rand(4) == 0)
				choice[choice.length] = 10; //Find nothing!

			flags[kFLAGS.BOG_EXPLORED]++;
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !SceneLib.helFollower.followerHel() && !isNightTime) {
				SceneLib.helScene.helSexualAmbush();
				return;
			}
			//Etna
			if ((flags[kFLAGS.ETNA_FOLLOWER] < 1 || EtnaFollower.EtnaInfidelity == 2) && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && !player.hasStatusEffect(StatusEffects.EtnaOff) && rand(5) == 0 && (player.level >= 20)) {
				SceneLib.etnaScene.repeatYandereEnc();
				return;
			}
			//Zenji
			if (rand(5) == 0 && flags[kFLAGS.ZENJI_PROGRESS] != -1 && (flags[kFLAGS.ZENJI_PROGRESS] < 8 || flags[kFLAGS.ZENJI_PROGRESS] == 10) && !isNightTime) {
				if (flags[kFLAGS.ZENJI_PROGRESS] >= 4) {
					if (flags[kFLAGS.ZENJI_PROGRESS] == 6) {
						if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] == 100) {
							if (flags[kFLAGS.ZENJI_PROGRESS] == 7) SceneLib.zenjiScene.followerZenjiRepeatOffer();
							else SceneLib.zenjiScene.followerZenjiFirstTimeOffer();
						}
						else if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] == 0) {
							if (flags[kFLAGS.ZENJI_PROGRESS] == 10) SceneLib.zenjiScene.loverZenjiRepeatOffer();
							else SceneLib.zenjiScene.loverZenjiFirstTimeOffer();
						}
						else SceneLib.zenjiScene.part2TrollEncounterRepeat();
					}
					else SceneLib.zenjiScene.part2TrollEncounterFirst();
				}
				else if (flags[kFLAGS.ZENJI_PROGRESS] > 0 && flags[kFLAGS.ZENJI_PROGRESS] < 4) SceneLib.zenjiScene.part1TrollEncounterRepeat();
				else if (flags[kFLAGS.ZENJI_PROGRESS] == 0) SceneLib.zenjiScene.part1TrollEncounter();
				return;
			}
			if ((isHalloween() && (date.fullYear > flags[kFLAGS.TREACLE_MINE_YEAR_DONE]) && flags[kFLAGS.BOG_EXPLORED] % 4 == 0) && (flags[kFLAGS.PHOUKA_LORE] > 0)) {
				phoukaScene.phoukaHalloween(); //Must have met them enough times to know what they're called, have some idea of their normal behaviour
				return;
			}
			//Find chest if lucky!
			if (rand(15) == 0 && player.hasKeyItem("Camp - Murky Chest") < 0) {
				var gemsFound:int = 350 + rand(150);
				outputText("While you're minding your own business, you spot a waterlogged chest. You wade in the murky waters until you finally reach the chest. As you open the chest, you find " + String(gemsFound) + " gems inside the chest! You pocket the gems and haul the chest home. It would make a good storage once you clean the inside of the chest.");
				player.createKeyItem("Camp - Murky Chest", 0, 0, 0, 0);
				for (var i:int = 0; i < 4; i++) {
					inventory.createStorage();
				}
				player.gems += gemsFound;
				statScreenRefresh();
				outputText("\n\n<b>You now have " + num2Text(inventory.itemStorageDirectGet().length) + " storage item slots at camp.</b>");
				doNext(camp.returnToCampUseOneHour);
				return;
			}

			select = choice[rand(choice.length)];
			switch(select) {
				case 0: frogGirlScene.findTheFrogGirl();
						break;
				case 1: phoukaScene.phoukaEncounter();
						break;
				case 2: chameleonGirlScene.encounterChameleon();
						break;
				case 3: lizanScene.lizanIntro();
						break;
				case 4: if (rand(2) == 0) SceneLib.trollScene.encounterAdultFemaleTroll();
						else SceneLib.trollScene.encounterAdultMaleTroll();
						break;
				case 5:
					SceneLib.exploration.demonLabProjectEncounters();
					break;
				default: clearOutput();
					outputText("You wander around through the humid muck, but you don't run into anything interesting.");
					doNext(camp.returnToCampUseOneHour);
			}
		}
	}
}