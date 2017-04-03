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
		public function isDiscovered():Boolean {
			return flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0;
		}
		public function discover():void {
			flags[kFLAGS.TIMES_EXPLORED_SWAMP] = 1;
			outputText("All things considered, you decide you wouldn't mind a change of scenery.  Gathering up your belongings, you begin a journey into the wasteland.  The journey begins in high spirits, and you whistle a little traveling tune to pass the time.  After an hour of wandering, however, your wanderlust begins to whittle away.  Another half-hour ticks by.  Fed up with the fruitless exploration, you're nearly about to head back to camp when a faint light flits across your vision.  Startled, you whirl about to take in three luminous will-o'-the-wisps, swirling around each other whimsically.  As you watch, the three ghostly lights begin to move off, and though the thought of a trap crosses your mind, you decide to follow.\n\n");
			outputText("Before long, you start to detect traces of change in the environment.  The most immediate difference is the increasingly sweltering heat.  A few minutes pass, then the will-o'-the-wisps plunge into the boundaries of a dark, murky, stagnant swamp; after a steadying breath you follow them into the bog.  Once within, however, the gaseous balls float off in different directions, causing you to lose track of them.  You sigh resignedly and retrace your steps, satisfied with your discovery.  Further exploration can wait.  For now, your camp is waiting.\n\n");
			outputText("<b>You've discovered the Swamp!</b>");
			doNext(camp.returnToCampUseTwoHours);
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
