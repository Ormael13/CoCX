/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Places
{
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.Lake.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.NPCs.AnemoneScene;
	import classes.Scenes.Places.Boat.*;

	use namespace kGAMECLASS;

	public class Boat extends AbstractLakeContent
	{
		public function Boat()
		{
		}
		public function boatExplore():void
		{
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !kGAMECLASS.followerHel()) {
				kGAMECLASS.helSexualAmbush();
				return;
			}
			outputText("You reach the dock without any incident and board the small rowboat.  The water is calm and placid, perfect for rowing.  ", true);
			if (player.hasStatusAffect("FactoryOverload") >= 0) {
				outputText("The water appears somewhat muddy and has a faint pungeant odor.  ", false);
				if (player.inte > 40) outputText("You realize what it smells like – sex.  ", false);
			}
			//3% chance of finding lost daughters
			if (rand(100) <= 3 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00412] > 0 && kGAMECLASS.izmaFollower()) {
				kGAMECLASS.findLostIzmaKids();
				return;
			}
			outputText("You set out, wondering if you'll find any strange islands or creatures in the lake.\n\n", false);
			//20% chance if not done with marae of meeting her.
			if (rand(10) <= 2 && player.hasStatusAffect("Marae Complete") < 0 && player.hasStatusAffect("Met Corrupt Marae") < 0) {
				kGAMECLASS.encounterMarae();
				return;
			}
			//10% chance of corrupt Marae followups
			if ((debug || rand(10) == 0) && flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] == 0 && player.hasStatusAffect("Met Corrupt Marae") >= 0 && player.gender > 0) {
				kGAMECLASS.level2MaraeEncounter();
				return;
			}
			//BUILD LIST OF CHOICES
			var choice:Array = [0, 1, 2, 3];
			if (player.hasStatusAffect("DungeonShutDown") >= 0 && player.level > 2)
				choice[choice.length] = 4;
			choice[choice.length] = 5;
			//MAKE YOUR CHOICE
			var selector:Number = choice[rand(choice.length)];
			//RUN CHOSEN EVENT
			switch (selector) {
				case 0:
					outputText("You row for nearly an hour, until your arms practically burn with exhaustion from all the rowing.", false);
					doNext(13);
					return;
				case 1:
					outputText("You give up on finding anything interesting, and decide to go check up on your camp.", false);
					doNext(13);
					return;
				case 2:
					kGAMECLASS.sharkGirlEncounter(1);
					return;
				case 3:
					kGAMECLASS.sharkGirlEncounter(1);
					return;
				case 4:
					lake.fetishZealotScene.zealotBoat();
					return;
				case 5:
					kGAMECLASS.anemoneScene.mortalAnemoneeeeee();
					return;
			}

		}
	}
}
