/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.Swamp.*;

	use namespace kGAMECLASS;

	public class Swamp extends BaseContent
	{
		public var corruptedDriderScene:CorruptedDriderScene = new CorruptedDriderScene();
		public var femaleSpiderMorphScene:FemaleSpiderMorphScene = new FemaleSpiderMorphScene();
		public var maleSpiderMorphScene:MaleSpiderMorphScene = new MaleSpiderMorphScene();
		public var rogar:Rogar = new Rogar();
		public function Swamp()
		{
		}
		public function exploreSwamp():void
		{
			//Discover 'Bog' at after 25 explores of swamp
			if ((flags[kFLAGS.TIMES_EXPLORED_SWAMP] >= 25) && flags[kFLAGS.BOG_EXPLORED] == 0) {
				outputText("While exploring the swamps, you find yourself into a particularly dark, humid area of this already fetid biome.  You judge that you could find your way back here pretty easily in the future, if you wanted to.  With your newfound discovery fresh in your mind, you return to camp.\n\n(<b>Bog exploration location unlocked!</b>)", true);
				flags[kFLAGS.BOG_EXPLORED]++;
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			flags[kFLAGS.TIMES_EXPLORED_SWAMP]++;
			/*  SPECIAL SCENE OVERWRITES */
			//KIHA X HEL THREESOME!
			if (!kGAMECLASS.kihaFollower.followerKiha() && player.cor < 60 && flags[kFLAGS.KIHA_AFFECTION_LEVEL] >= 1 && flags[kFLAGS.HEL_FUCKBUDDY] > 0 && player.hasCock() && flags[kFLAGS.KIHA_AND_HEL_WHOOPIE] == 0) {
				kGAMECLASS.kihaFollower.kihaXSalamander();
				return;
			}
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !kGAMECLASS.helFollower.followerHel()) {
				kGAMECLASS.helScene.helSexualAmbush();
				return;
			}
			if (flags[kFLAGS.TOOK_EMBER_EGG] == 0 && flags[kFLAGS.EGG_BROKEN] == 0 && flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0 && (flags[kFLAGS.TIMES_EXPLORED_SWAMP] % 40 == 0)) {
				kGAMECLASS.emberScene.findEmbersEgg();
				return;
			}
			/*  STANDARD SCENE SELECTION  */
			var choices:Array = [];
			//Build the choice array
			//M & F spidermorphs
			choices[choices.length] = 0;
			choices[choices.length] = 1;
			//Drider
			choices[choices.length] = 2;
			//ROGAR
			if (flags[kFLAGS.ROGAR_DISABLED] == 0 && flags[kFLAGS.ROGAR_PHASE] < 3)
				choices[choices.length] = 3;
			//Kiha
			choices[choices.length] = 4;

			//Pick from the choices and pull the encounter.
			var choice:Number = choices[rand(choices.length)];
			switch (choice) {
				case 0:
					femaleSpiderMorphScene.fSpiderMorphGreeting();
					break;
				case 1:
					maleSpiderMorphScene.greetMaleSpiderMorph();
					break;
				case 2:
					corruptedDriderScene.driderEncounter();
					break;
				case 3:
					rogar.encounterRogarSwamp();
					break;
				case 4:
					//Kiha follower gets to explore her territory!
					if (kGAMECLASS.kihaFollower.followerKiha()) kGAMECLASS.kihaScene.kihaExplore();
					else kGAMECLASS.kihaScene.encounterKiha();
					break;
				default:
					outputText("New explore code fucked up.  YOU BONED (TELL FEN)");
					doNext(playerMenu);
					break;
			}
		}
	}
}
