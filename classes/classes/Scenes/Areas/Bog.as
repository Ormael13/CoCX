/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Bog.*;
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
			var chooser:int = rand(5);
			if (chooser == 0) {
				if (player.buttPregnancyIncubation != 0) chooser++;
			}
			flags[kFLAGS.BOG_EXPLORED]++;
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !SceneLib.helFollower.followerHel()) {
				SceneLib.helScene.helSexualAmbush();
				return;
			}
			//Etna
			if (flags[kFLAGS.ETNA_FOLLOWER] < 1 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && !player.hasStatusEffect(StatusEffects.EtnaOff) && rand(5) == 0 && (player.level >= 20)) {
				SceneLib.etnaScene.repeatYandereEnc();
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
			if (chooser == 0) {
				frogGirlScene.findTheFrogGirl();
			}
			else if (chooser == 1) {
				phoukaScene.phoukaEncounter();
			}
			else if (chooser == 2) {
				chameleonGirlScene.encounterChameleon();
			}
			else if (chooser == 3) {
				lizanScene.lizanIntro();
			}
			else {
				clearOutput();
				outputText("You wander around through the humid muck, but you don't run into anything interesting.");
				doNext(camp.returnToCampUseOneHour);
			}
		}
	}
}
