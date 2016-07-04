/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.Desert.*;

	use namespace kGAMECLASS;

	public class Desert extends BaseContent
	{
		public var antsScene:AntsScene = new AntsScene();
		public var nagaScene:NagaScene = new NagaScene();
		public var oasis:Oasis = new Oasis();
		public var sandTrapScene:SandTrapScene = new SandTrapScene();
		public var sandWitchScene:SandWitchScene = new SandWitchScene();
		public var wanderer:Wanderer = new Wanderer();
		public function Desert()
		{
		}
		//Explore desert
		public function exploreDesert():void
		{
			player.exploredDesert++;
			if ((player.level >= 4 || player.exploredDesert > 45) && player.exploredDesert % 15 == 0 && flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] == 0) {
				kGAMECLASS.dungeons.desertcave.enterDungeon();
//				kGAMECLASS.inDungeon = true;
//				kGAMECLASS.dungeonLoc = 23;
//				playerMenu();
				return;
			}
			if (rand(40) == 0) {
				kGAMECLASS.exgartuan.fountainEncounter();
				return;
			}
			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !kGAMECLASS.helScene.followerHel()) {
				kGAMECLASS.helScene.helSexualAmbush();
				return;
			}
			if ((player.exploredDesert == 20 && player.findStatusEffect(StatusEffects.TelAdre) < 0) || (rand(20) == 0 && player.statusEffectv1(StatusEffects.TelAdre) == 0)) {
				kGAMECLASS.telAdre.discoverTelAdre();
				return;
			}
			if (sandWitchScene.pregnancy.event == 2 && rand(4) == 0) {
				if (flags[kFLAGS.EGG_WITCH_TYPE] == PregnancyStore.PREGNANCY_DRIDER_EGGS) sandWitchScene.sammitchBirthsDriders();
				else sandWitchScene.witchBirfsSomeBees();
				return;
			}
			//Ant colony debug chances
			if (player.level >= 5 && flags[kFLAGS.ANT_WAIFU] == 0 && (player.exploredDesert % 8 == 0) && flags[kFLAGS.ANTS_PC_FAILED_PHYLLA] == 0 && flags[kFLAGS.ANT_COLONY_KEPT_HIDDEN] == 0) {
				antsScene.antColonyEncounter();
				return;
			}
			//int over 50?  Chance of alice encounter!
			if (rand(4) == 0 && player.inte > 50) {
				if (flags[kFLAGS.FOUND_WIZARD_STAFF] == 0) {
					clearOutput();
					outputText("While exploring the desert, you see a plume of smoke rising in the distance.  You change direction and approach the soot-cloud carefully.  It takes a few moments, but after cresting your fourth dune, you locate the source.  You lie low, so as not to be seen, and crawl closer for a better look.\n\n", false);
					outputText("A library is burning up, sending flames dozens of feet into the air.  It doesn't look like any of the books will survive, and most of the structure has already been consumed by the hungry flames.  The source of the inferno is curled up next to it.  It's a naga!  She's tall for a naga, at least seven feet if she stands at her full height.  Her purplish-blue skin looks quite exotic, and she wears a flower in her hair.  The naga is holding a stick with a potato on the end, trying to roast the spud on the library-fire.  It doesn't seem to be going well, and the potato quickly lights up from the intense heat.\n\n", false);
					outputText("The snake-woman tosses the burnt potato away and cries, \"<i>Hora hora.</i>\"  She suddenly turns and looks directly at you.  Her gaze is piercing and intent, but she vanishes before you can react.  The only reminder she was ever there is a burning potato in the sand.   Your curiosity overcomes your caution, and you approach the fiery inferno.  There isn't even a trail in the sand, and the library is going to be an unsalvageable wreck in short order.   Perhaps the only item worth considering is the stick with the burning potato.  It's quite oddly shaped, and when you reach down to touch it you can feel a resonant tingle.  Perhaps it was some kind of wizard's staff?\n\n", false);
					flags[kFLAGS.FOUND_WIZARD_STAFF]++;
					inventory.takeItem(weapons.W_STAFF, camp.returnToCampUseOneHour);
					return;
				}
				else if (player.hasKeyItem("Carpenter's Toolbox") >= 0 && player.keyItemv1("Carpenter's Toolbox") < camp.cabinProgress.maxNailSupply() && rand(2) == 0) {
					clearOutput();
					outputText("While exploring the desert, you find the wreckage of a building. Judging from the debris, it's the remains of the library that was destroyed by the fire.\n\n", false);
					outputText("You circle the wreckage for a good while and you can't seem to find anything to salvage.  Until something shiny catches your eye.  There are exposed nails that look like they can be scavenged.\n\n", false)
					outputText("You take your hammer out of your toolbox and you spend time extracting straight nails.  Some of the nails you've pulled out are bent but some are incredibly in good condition.  You could use these nails for construction.\n\n");
					var extractedNail:int = 5 + rand(player.inte / 5) + rand(player.str / 10) + rand(player.tou / 10) + rand(player.spe / 20) + 5;
					flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCAVENGER] += extractedNail;
					player.addKeyValue("Carpenter's Toolbox", 1, extractedNail);
					outputText("After spending nearly an hour scavenging, you've managed to extract " + extractedNail + " nails.\n\n");
					if (player.keyItemv1("Carpenter's Toolbox") > camp.cabinProgress.maxNailSupply()) player.addKeyValue("Carpenter's Toolbox", 1, -(player.keyItemv1("Carpenter's Toolbox") - camp.cabinProgress.maxNailSupply()));
					outputText("Nails: " + player.keyItemv1("Carpenter's Toolbox") + "/" + camp.cabinProgress.maxNailSupply());
					doNext(camp.returnToCampUseOneHour);
					return;
				}
			}
			//Possible chance of boosting camp space!
			if (player.hasKeyItem("Camp - Chest") < 0 && (rand(100) < 10)) {
				outputText("While wandering the trackless sands of the desert, you break the silent monotony with a loud 'thunk'.  You look down and realize you're standing on the lid of an old chest, somehow intact and buried in the sand.  Overcome with curiosity, you dig it out, only to discover that it's empty.  It would make a nice addition to your campsite.\n\nYou decide to bring it back to your campsite.  ", true);
				for (var i:int = 0; i < 6; i++) {
					inventory.createStorage();
				}
				player.createKeyItem("Camp - Chest", 0, 0, 0, 0);
				outputText("<b>You now have " + num2Text(inventory.itemStorageDirectGet().length) + " storage item slots at camp.</b>");
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			//Chance of dick-dragging! 10% + 10% per two foot up to 30%
			temp = 10 + (player.longestCockLength() - player.tallness) / 24 * 10;
			if (temp > 30) temp = 30;
			if (temp > rand(100) && player.longestCockLength() >= player.tallness && player.totalCockThickness() >= 12) {
				kGAMECLASS.exploration.bigJunkDesertScene();
				return;
			}
			var choices:Array = [];
			//-8008 is cheating for "no arg"
			var args:Array = [];

			//Encounter Sandwitch
			if (flags[kFLAGS.SAND_WITCH_LEAVE_ME_ALONE] == 0) {
				choices[choices.length] = sandWitchScene.encounter;
				args[args.length] = -8008;
			}
			if (flags[kFLAGS.CUM_WITCHES_FIGHTABLE] > 0) {
				choices[choices.length] = kGAMECLASS.dungeons.desertcave.fightCumWitch;
				args[args.length] = -8008;
			}
			//Encounter Mimic
			if (player.level >= 3 || model.time.days >= 20) {
				choices[choices.length] = getGame().mimicScene.mimicTentacleStart;
				args[args.length] = 1;
			}
			//Encounter Marcus
			choices[choices.length] = wanderer.wandererRouter;
			args[args.length] = -8008;
			choices[choices.length] = walkingDesertStatBoost;
			args[args.length] = -8008;
			if (rand(2) == 0 && player.level >= 2) {
				if (rand(2) == 0) {
					choices[choices.length] = mirageDesert;
					args[args.length] = -8008;
				}
				else {
					choices[choices.length] = oasis.oasisEncounter;
					args[args.length] = -8008;
				}
			}
			choices[choices.length] = nagaScene.nagaEncounter;
			args[args.length] = -8008;
			if (rand(2) == 0) {
				choices[choices.length] = sandTrapScene.encounterASandTarp;
				args[args.length] = -8008;
			}
			var select:int = rand(choices.length);
			if (args[select] == -8008) {
				choices[select]();
			}
			else choices[select](args[select]);
		}

		private function mirageDesert():void
		{
			clearOutput();
			outputText("While exploring the desert, you see a shimmering tower in the distance.  As you rush towards it, it vanishes completely.  It was a mirage!   You sigh, depressed at wasting your time.", true);
			dynStats("lus", -15);
			doNext(camp.returnToCampUseOneHour);
		}

		private function walkingDesertStatBoost():void
		{
			clearOutput();
			outputText("You walk through the shifting sands for an hour, finding nothing.\n\n", true);
			//Chance of boost == 50%
			if (rand(2) == 0) {
				//50/50 strength/toughness
				if (rand(2) == 0 && player.str < 50) {
					outputText("The effort of struggling with the uncertain footing has made you stronger.", false);
					dynStats("str", .5);
				}
				//Toughness
				else if (player.tou < 50) {
					outputText("The effort of struggling with the uncertain footing has made you tougher.", false);
					dynStats("tou", .5);
				}
			}
			doNext(camp.returnToCampUseOneHour);
		}
	}
}
