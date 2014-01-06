/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.HighMountains.*;

	use namespace kGAMECLASS;

	public class HighMountains extends BaseContent
	{
		public var basiliskScene:BasiliskScene = new BasiliskScene();
		public var harpyScene:HarpyScene = new HarpyScene();
		public function HighMountains()
		{
		}
		//Explore High Mountain
		public function exploreHighMountain():void
		{
			flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN]++;
			doNext(1);
			var chooser:Number = rand(3);
			//Boosts mino and hellhound rates!
			if (player.hasPerk("Pierced: Furrite") >= 0 && rand(3) == 0) {
				chooser = 1;
			}
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !kGAMECLASS.followerHel()) {
				kGAMECLASS.helSexualAmbush();
				return;
			}
			//Gats xmas adventure!
			if (rand(5) == 0 && player.gender > 0 && isHolidays() && flags[kFLAGS.GATS_ANGEL_DISABLED] == 0 && flags[kFLAGS.GATS_ANGEL_GOOD_ENDED] == 0 && (flags[kFLAGS.GATS_ANGEL_QUEST_BEGAN] == 0 || player.hasKeyItem("North Star Key") >= 0)) {
				kGAMECLASS.gatsSpectacularRouter();
				return;
			}
			//Minerva
			if (flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] % 8 == 0) {
				kGAMECLASS.encounterMinerva();
				return;
			}
			//25% minotaur sons!
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] >= 3 && rand(4) == 0 && player.hasVagina()) {
				spriteSelect(44);
				kGAMECLASS.meetMinotaurSons();
				return;
			}
			//Harpy odds!
			if (hasItem("OviElix", 1)) {
				if (hasItem("OviElix", 2)) {
					if (rand(4) == 0) {
						kGAMECLASS.chickenHarpy();
						return;
					}
				}
				else {
					if (rand(10) == 0) {
						kGAMECLASS.chickenHarpy();
						return;
					}
				}
			}
			//10% chance to mino encounter rate if addicted
			if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 0 && rand(10) == 0) {
				spriteSelect(44);
				//Cum addictus interruptus!  LOL HARRY POTTERFAG
				//Withdrawl auto-fuck!
				if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) {
					kGAMECLASS.mountain.minotaurScene.minoAddictionFuck();
					return;
				}
				eventParser(2008);
				spriteSelect(44);
				return;
			}
			//Generic harpy
			if (chooser == 0) {
				outputText("A harpy wings out of the sky and attacks!", true);
				startCombat(new Harpy());
				spriteSelect(26);
				return;
			}
			//Basilisk!
			if (chooser == 1) {
				basiliskScene.basiliskGreeting();
				return;
			}
			//Sophie
			if (chooser == 2) {
				if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00282] > 0 || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00283] > 0 || kGAMECLASS.sophieFollower()) {
					outputText("A harpy wings out of the sky and attacks!", true);
					startCombat(new Harpy());
					spriteSelect(26);
				}
				else {
					if (flags[kFLAGS.MET_SOPHIE_COUNTER] == 0) kGAMECLASS.meetSophie();
					else kGAMECLASS.meetSophieRepeat();
				}
			}
		}
	}
}
