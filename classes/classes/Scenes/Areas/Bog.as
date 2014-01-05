/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.Bog.*;

	use namespace kGAMECLASS;

	public class Bog extends BaseContent
	{
		public var frogGirlScene:FrogGirlScene = new FrogGirlScene();
		public var chameleonGirlScene:ChameleonGirlScene = new ChameleonGirlScene();
		public function Bog()
		{
		}
		public function exploreBog():void
		{
			flags[kFLAGS.BOG_EXPLORED]++;
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !kGAMECLASS.followerHel()) {
				kGAMECLASS.helSexualAmbush();
				return;
			}
			if (player.buttPregnancyIncubation == 0 && rand(3) == 0) frogGirlScene.findTheFrogGirl();
			else if (rand(2) == 0) chameleonGirlScene.encounterChameleon();
			else {
				clearOutput();
				outputText("You wander around through the humid muck, but you don't run into anything interesting.");
				doNext(13);
			}
		}
	}
}
