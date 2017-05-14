/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Places
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.Lake.*;
	import classes.Scenes.Places.Boat.*;
	import classes.Player;
	import classes.Scenes.NPCs.Etna;
	import classes.Scenes.NPCs.EtnaFollower;

	public class Boat extends AbstractLakeContent
	{
		public var sharkGirlScene:SharkGirlScene = new SharkGirlScene();
		public var marae:MaraeScene = new MaraeScene();
		public var etnaScene:EtnaFollower = new EtnaFollower();
		public function Boat()
		{
		}
		public function discoverBoat():void {
			player.createStatusAffect(StatusAffects.BoatDiscovery,0,0,0,0);
			outputText("You journey around the lake, seeking demons to fight", true);
			if(player.cor > 60) outputText(" or fuck", false);
			outputText(".  The air is fresh, and the grass is cool and soft under your feet.   Soft waves lap against the muddy sand of the lake-shore, as if radiating outward from the lake.   You pass around a few bushes carefully, being wary of hidden 'surprises', and come upon a small dock.  The dock is crafted from old growth trees lashed together with some crude rope.  Judging by the appearance of the rope, it is very old and has not been seen to in quite some time.  Tied to the dock is a small rowboat, only about seven feet long and three feet wide.   The boat appears in much better condition than the dock, and appears to be brand new.\n\n", false);
			outputText("<b>You have discovered the lake boat!</b>\n(You may return and use the boat to explore the lake's interior by using the 'places' menu.)", false);
			doNext(camp.returnToCampUseOneHour);
		}
		public function boatExplore():void
		{
			player.addStatusValue(StatusAffects.BoatDiscovery, 1, 1);
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !kGAMECLASS.helScene.followerHel()) {
				kGAMECLASS.helScene.helSexualAmbush();
				return;
			}
			//Etna
			if (flags[kFLAGS.ETNA_FOLLOWER] < 1 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && rand(5) == 0) {
				etnaScene.repeatYandereEnc();
				return;
			}
			outputText("You reach the dock without any incident and board the small rowboat.  The water is calm and placid, perfect for rowing.  ", true);
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
				outputText("The water appears somewhat muddy and has a faint pungent odor.  ", false);
				if (player.inte > 40) outputText("You realize what it smells like – sex.  ", false);
			}
			//3% chance of finding lost daughters
			if (rand(100) <= 3 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00412] > 0 && kGAMECLASS.izmaScene.izmaFollower()) {
				kGAMECLASS.izmaScene.findLostIzmaKids();
				return;
			}
			outputText("You set out, wondering if you'll find any strange islands or creatures in the lake.\n\n", false);
			//Alraune
			if (rand(5) <= 2 && player.plantScore() >= 7 && flags[kFLAGS.FACTORY_SHUTDOWN] > 0) {
				marae.alraunezeMe();
				return;
			}
			//40% chance if not done with marae of meeting her.
			if (rand(5) <= 2 && flags[kFLAGS.MARAE_QUEST_COMPLETE] <= 0 && flags[kFLAGS.MET_MARAE_CORRUPTED] <= 0) {
				marae.encounterMarae();
				return;
			}
			if (rand(5) <= 2 && flags[kFLAGS.FACTORY_SHUTDOWN] == 1 && flags[kFLAGS.MARAE_QUEST_COMPLETE] >= 1 && flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] == 1) {
				marae.talkToMaraeAboutMinervaPurification();
				return;
			}
			if (rand(5) <= 2 && flags[kFLAGS.FACTORY_SHUTDOWN] == 1 && flags[kFLAGS.MARAE_QUEST_COMPLETE] >= 1 && flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] != 1 && flags[kFLAGS.LETHICE_DEFEATED] > 0 && flags[kFLAGS.PURE_MARAE_ENDGAME] < 2) {
				marae.encounterPureMaraeEndgame();
				return;
			}
			//20% chance of corrupt Marae followups
			if ((debug || rand(5) == 0) && flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] == 0 && flags[kFLAGS.MET_MARAE_CORRUPTED] > 0 && player.gender > 0 && flags[kFLAGS.CORRUPTED_MARAE_KILLED] <= 0) {
				marae.level2MaraeEncounter();
				return;
			}
			//Done to allow player who has both perks to fight Marae.
			if ((debug || rand(5) == 0) && flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] == 2 && flags[kFLAGS.MET_MARAE_CORRUPTED] > 0 && player.gender > 0 && flags[kFLAGS.CORRUPTED_MARAE_KILLED] <= 0) {
				marae.level3MaraeEncounter();
				return;
			}
			//BUILD LIST OF CHOICES
			var choice:Array = [0, 1, 2, 3];
			if (flags[kFLAGS.FACTORY_SHUTDOWN] > 0 && player.level > 2)
				choice[choice.length] = 4;
			choice[choice.length] = 5;
			//MAKE YOUR CHOICE
			var selector:Number = choice[rand(choice.length)];
			//RUN CHOSEN EVENT
			switch (selector) {
				case 0:
					outputText("You row for nearly an hour, until your arms practically burn with exhaustion from all the rowing.", false);
					doNext(camp.returnToCampUseOneHour);
					return;
				case 1:
					outputText("You give up on finding anything interesting, and decide to go check up on your camp.", false);
					doNext(camp.returnToCampUseOneHour);
					return;
				case 2:
					sharkGirlScene.sharkGirlEncounter(1);
					return;
				case 3:
					sharkGirlScene.sharkGirlEncounter(1);
					return;
				case 4:
					lake.fetishZealotScene.zealotBoat();
					return;
				case 5:
					flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] = 1;
					kGAMECLASS.anemoneScene.mortalAnemoneeeeee();
					return;
			}

		}
	}
}
