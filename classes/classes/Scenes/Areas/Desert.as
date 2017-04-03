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
		public function isDiscovered():Boolean {
			return flags[kFLAGS.TIMES_EXPLORED_DESERT] > 0;
		}
		public function discover():void {
			flags[kFLAGS.TIMES_EXPLORED_DESERT] = 1;
			outputText("You stumble as the ground shifts a bit underneath you.  Groaning in frustration, you straighten up and discover the rough feeling of sand ");
			if (player.lowerBody == LOWER_BODY_TYPE_HUMAN) outputText("inside your footwear, between your toes");
			else if (player.lowerBody == LOWER_BODY_TYPE_HOOFED) outputText("in your hooves");
			else if (player.lowerBody == LOWER_BODY_TYPE_DOG) outputText("in your paws");
			else if (player.lowerBody == LOWER_BODY_TYPE_NAGA) outputText("in your scales");
			outputText(".\n\n<b>You've discovered the Desert!</b>");
			doNext(camp.returnToCampUseOneHour);
		}
		//Explore desert
		public function exploreDesert():void
		{
			flags[kFLAGS.TIMES_EXPLORED_DESERT]++;
			if ((player.level >= 4 || flags[kFLAGS.TIMES_EXPLORED_DESERT] > 45) && flags[kFLAGS.TIMES_EXPLORED_DESERT] % 15 == 0 && flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] == 0) {
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
			if ((flags[kFLAGS.TIMES_EXPLORED_DESERT] == 20 && player.findStatusEffect(StatusEffects.TelAdre) < 0) || (rand(20) == 0 && player.statusEffectv1(StatusEffects.TelAdre) == 0)) {
				kGAMECLASS.telAdre.discoverTelAdre();
				return;
			}
			if (sandWitchScene.pregnancy.event == 2 && rand(4) == 0) {
				if (flags[kFLAGS.EGG_WITCH_TYPE] == PregnancyStore.PREGNANCY_DRIDER_EGGS) sandWitchScene.sammitchBirthsDriders();
				else sandWitchScene.witchBirfsSomeBees();
				return;
			}
			//Ant colony debug chances
			if (player.level >= 5 && flags[kFLAGS.ANT_WAIFU] == 0 && (flags[kFLAGS.TIMES_EXPLORED_DESERT] % 8 == 0) && flags[kFLAGS.ANTS_PC_FAILED_PHYLLA] == 0 && flags[kFLAGS.ANT_COLONY_KEPT_HIDDEN] == 0) {
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
				bigJunkDesertScene();
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
		
		//Massive bodyparts scene
		//[DESERT]
		//[RANDOM SCENE IF CHARACTER HAS AT LEAST ONE COCK LARGER THAN THEIR HEIGHT,
		//AND THE TOTAL COMBINED WIDTH OF ALL THEIR COCKS IS TWELVE INCHES OR GREATER]
		public function bigJunkDesertScene():void
		{
			clearOutput();
			var x:Number = player.longestCock();
			//PARAGRAPH 1
			outputText("Walking along the sandy dunes of the desert you find yourself increasingly impeded by the bulk of your " + player.cockDescript(x) + " dragging along the sandscape behind you.  The incredibly hot surface of the desert causes your loins to sweat heavily and fills them with relentless heat.", false);

			if (player.cocks.length == 1) outputText("  As it drags along the dunes, the sensation forces you to imagine the rough textured tongue of a monstrous animal sliding along the head of your " + Appearance.cockNoun(player.cocks[x].cockType) + ".", false);
			else if (player.cocks.length >= 2) outputText("  With all of your " + player.multiCockDescriptLight() + " dragging through the sands they begin feeling as if the rough textured tongues of " + num2Text(player.cockTotal()) + " different monstrous animals were slobbering over each one.", false);
			outputText("\n\n", false);

			//PARAGRAPH 2

			//FOR NON-CENTAURS]
			if (!player.isTaur()) {
				outputText("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your " + player.multiCockDescriptLight() + ", which forces your torso to the ground.  Normally your erection would merely raise itself skyward but your genitals have grown too large and heavy for your " + player.hipDescript() + " to hold them aloft.  Instead you feel your body forcibly pivoting at the hips until your torso is compelled to rest face down on top of your obscene " + player.multiCockDescriptLight() + ".", false);

				//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
				if (player.biggestTitSize() >= 35)  outputText("  Your " + player.allBreastsDescript() + " hang lewdly off your torso to rest on the desert sands, seeming to bury the dunes on either side of you.  Their immense weight anchors your body, further preventing your torso from lifting itself up.  The burning heat of the desert teases your " + player.nippleDescript(0) + "s mercilessly as they grind in the sand.", false);
				//IF CHARACTER HAS A BALLS ADD SENTENCE
				if (player.balls > 0) outputText("  Your " + player.skinTone + player.sackDescript() + " rests beneath your raised " + player.buttDescript() + ".  The fiery warmth of the desert caresses it, causing your " + player.ballsDescriptLight() + " to pulse with the need to release their sperm through your " + player.multiCockDescriptLight() + ".", false);
				//IF CHARACTER HAS A VAGINA ADD SENTENCE
				if (player.vaginas.length >= 1) {
					outputText("  Your " + player.vaginaDescript() + " and " + player.clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + player.buttDescript() + " above.", false);
					//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
					if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) outputText("  Juices stream from your womanhood and begin pooling on the hot sand beneath you.  Wisps of steam rise up into the air only to tease your genitals further.  ", false);
				}
			}
			//FOR CENTAURS
			else {
				outputText("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your " + player.multiCockDescriptLight() + ", which forces the barrel of your horse-like torso to the ground.  Normally your erection would merely hover above the ground in between your centaurian legs, but your genitals have grown too large and heavy for your " + player.hipDescript() + " to hold them aloft.  Instead, you feel your body being forcibly pulled down at your hindquarters until you rest atop your " + player.multiCockDescriptLight() + ".", false);
				//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
				if (player.biggestTitSize() >= 35)  outputText("  Your " + player.allBreastsDescript() + " pull your human torso forward until it also is forced to rest facedown, just like your horse half.  Your tits rest, pinned on the desert sand to either side of you.  Their immense weight anchors you, further preventing any part of your equine body from lifting itself up.  The burning heat of the desert teases your " + player.nippleDescript(0) + "s incessantly.", false);
				//IF CHARACTER HAS A BALLS ADD SENTENCE
				if (player.balls > 0) outputText("  Your " + player.skinTone + player.sackDescript() + " rests beneath your raised " + player.buttDescript() + ".  The airy warmth of the desert teases it, causing your " + player.ballsDescriptLight() + " pulse with the need to release their sperm through your " + player.multiCockDescriptLight() + ".", false);
				//IF CHARACTER HAS A VAGINA ADD SENTENCE
				if (player.vaginas.length >= 1) {
					outputText("  Your " + player.vaginaDescript() + " and " + player.clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + player.buttDescript() + " above.", false);
					//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
					if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) outputText("  The desert sun beats down on your body, its fiery heat inflaming the senses of your vaginal lips.  Juices stream from your womanhood and begin pooling on the hot sand beneath you.", false);
				}
			}
			outputText("\n\n", false);
			//PARAGRAPH 3
			outputText("You realize you are effectively trapped here by your own body.", false);
			//CORRUPTION BASED CHARACTER'S VIEW OF SITUATION
			if (player.cor < 33) outputText("  Panic slips into your heart as you realize that if any dangerous predator were to find you in this state, you'd be completely defenseless.  You must find a way to regain your mobility immediately!", false);
			else if (player.cor < 66) outputText("  You realize that if any dangerous predator were to find you in this state you'd be completely defenseless.  You must find a way to regain your mobility... yet there is a certain appeal to imagining how pleasurable it would be for a sexual predator to take advantage of your obscene body.", false);
			else outputText("  Your endowments have rendered you completely helpless should any predators find you.  Somewhere in your heart, you're exhilarated at the prospect.  The idea of being a helpless fucktoy for a wandering beast is unusually inviting to you.  Were it not for the thought that you might die of thirst in the desert, you'd be incredibly tempted to remain right where you are.", false);

			//SCENE END = IF CHARACTER HAS FULL WINGS ADD SENTENCE
			if (player.canFly()) outputText("  You extend your wings and flap as hard as you can, until at last you manage to lighten the bulk of your body somewhat - enough to allow yourself to drag your genitals across the hot sands and back to camp.  The ordeal takes nearly an hour.", false);
			//SCENE END IF CHARACTER HAS CENTAUR BODY
			else if (player.isTaur()) outputText("  You struggle and work your equine legs against the surface of the dune you are trapped on.  Your " + player.feet() + " have consistent trouble finding footing, the soft sand failing to provide enough leverage to lift your bulk.  You breath in deeply and lean from side to side, trying to find some easier vertical leverage.  Eventually, with a crude crawl, your legs manage to push the bulk of your body onto more solid ground.  With great difficulty, you spend the next hour shuffling your genitals across the sandscape and back to camp.", false);
			//SCENE END = FOR ALL OTHER CHARACTERS
			else outputText("  You struggle and push with your " + player.legs() + " as hard as you can, but it's no use.  You do the only thing you can and begin stroking your " + player.multiCockDescriptLight() + " with as much vigor as you can muster.  Eventually your body tenses and a light load of jizz erupts from your body, but the orgasm is truly mild compared to what you need.  You're simply too weary from struggling to give yourself the masturbation you truly need, but you continue to try.  Nearly an hour later " + player.sMultiCockDesc() + " softens enough to allow you to stand again, and you make your way back to camp, still dragging your genitals across the warm sand.", false);
			dynStats("lus", 25 + rand(player.cor / 5), "resisted", false);
			player.changeFatigue(5);
			doNext(camp.returnToCampUseOneHour);
		}
	}
}
