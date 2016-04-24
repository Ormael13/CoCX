/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Areas.Lake.*;

	use namespace kGAMECLASS;

	public class Lake extends BaseContent
	{
		
		public var fetishCultistScene:FetishCultistScene = new FetishCultistScene();
		public var fetishZealotScene:FetishZealotScene = new FetishZealotScene();
		public var gooGirlScene:GooGirlScene = new GooGirlScene();
		public var greenSlimeScene:GreenSlimeScene = new GreenSlimeScene();
		public var kaiju:Kaiju = new Kaiju();
		public var calluScene:CalluScene = new CalluScene();
		public var swordInStone:SwordInStone = new SwordInStone();
		public function Lake()
		{
		}
		//Explore Lake
		public function exploreLake():void
		{
			//Increment exploration count
			player.exploredLake++;
			if (kGAMECLASS.aprilFools.poniesYN()) return;

			//Helia monogamy fucks
			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !kGAMECLASS.helScene.followerHel()) {
				kGAMECLASS.helScene.helSexualAmbush();
				return;
			}
			if (player.exploredLake % 20 == 0 || (flags[kFLAGS.HUNGER_ENABLED] > 0 && player.hunger < 10 && rand(5) == 0)) {
				calluScene.ottahGirl();
				return;
			}
			//Egg chooser
			if (rand(100) < 25 && player.pregnancyIncubation > 1 && player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) {
				clearOutput();
				outputText("While wandering along the lakeshore, you spy beautiful colored lights swirling under the surface.  You lean over cautiously, and leap back as they flash free of the lake's liquid without making a splash.  The colored lights spin in a circle, surrounding you.  You wonder how you are to fight light, but they stop moving and hover in place around you.  There are numerous colors: Blue, Pink, White, Black, Purple, and Brown.  They appear to be waiting for something; perhaps you could touch one of them?");
				menu();
				addButton(0, "Blue", eggChoose, 2);
				addButton(1, "Pink", eggChoose, 3);
				addButton(2, "White", eggChoose, 4);
				addButton(3, "Black", eggChoose, 5);
				addButton(4, "Purple", eggChoose, 1);
				addButton(5, "Brown", eggChoose, 0);
				addButton(14, "Escape", eggChooseEscape);
				return;
			}
			//Did it already output something?
			var displayed:Boolean = false;
			var choice:Array = [];
			var select:int;

			//Build choice list.
			//==================================================
			//COMMON EVENTS
			if (player.level < 2 || player.spe < 50) choice[choice.length] = 0;
			choice[choice.length] = 1;
			choice[choice.length] = 2;
			//Fetish cultist not encountered till level 2
			if (player.level >= 2 && flags[kFLAGS.FACTORY_SHUTDOWN] > 0)
				choice[choice.length] = 3;
			//Slimes/Ooze = level >= 2
			if (player.level >= 2)
				choice[choice.length] = 4;
			//Izma
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00230] > 0 && (player.exploredLake >= 10) && (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00233] == 0 || player.findStatusEffect(StatusEffects.Infested) < 0) && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] <= 0)
				choice[choice.length] = 5;
			//Rathazul
			if (player.findStatusEffect(StatusEffects.CampRathazul) < 0)
				choice[choice.length] = 6;

			//UNCOMMON EVENTS
			//Goo finding!
			if (rand(30) == 0 && flags[kFLAGS.GOO_TFED_MEAN] + flags[kFLAGS.GOO_TFED_NICE] > 0 && flags[kFLAGS.GOO_SLAVE_RECRUITED] == 0) {
				kGAMECLASS.latexGirl.encounterLeftBehindGooSlave();
				return;
			}
			//Chance of dick-dragging! OLD:10% + 10% per two foot up to 30%
			temp = 10 + (player.longestCockLength() - player.tallness) / 24 * 10;
			if (temp > 0 && player.longestCockLength() >= player.tallness - 10 && player.totalCockThickness() >= 8)
				choice[choice.length] = 8;

			//Encounter goblins and imps in NG+
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0)
				choice[choice.length] = 12;
				
			//ONE TIME EVENTS
			//Amily Village discovery
			if (flags[kFLAGS.AMILY_VILLAGE_ACCESSIBLE] == 0)
				choice[choice.length] = 9;
			//Sword Discovery
			if (player.findStatusEffect(StatusEffects.TookBlessedSword) < 0 && player.findStatusEffect(StatusEffects.BSwordBroken) < 0)
				choice[choice.length] = 10;
			//Pre-emptive chance of finding the boat
			if (player.findStatusEffect(StatusEffects.BoatDiscovery) < 0)
				choice[choice.length] = 11;
				
			//CHOOSE YOUR POISON!
			select = choice[rand(choice.length)];

			//==============================
			//EVENTS GO HERE!
			//==============================
			//Pre-emptive chance of discovering Amily the stupidshit mouse
			if (select == 9) {
				kGAMECLASS.amilyScene.discoverAmilyVillage();
			}
			//Pre-emptive chance of discovering the Beautiful Sword
			else if (select == 10) {
				swordInStone.findSwordInStone();
			}
			//Pre-emptive chance of finding the boat
			else if (select == 11) {
				kGAMECLASS.boat.discoverBoat();
			}
			//Meet Izma every 8 attempts
			else if (select == 5) {
				kGAMECLASS.izmaScene.meetIzmaAtLake();
			}
			//Chance of dick-dragging! 10% + 10% per two foot up to 30%
			else if (select == 8) {
				//True sets to use lake scene!
				kGAMECLASS.forest.bigJunkForestScene(true);
			}
			else if (select == 4) {
				//Chance of seeing ooze convert goo!
				//More common if factory blew up
				if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2 && rand(10) == 0) {
					gooGirlScene.spyOnGooAndOozeSex();
					return;
				}
				//Else pretty rare.
				else if (rand(25) == 0) {
					gooGirlScene.spyOnGooAndOozeSex();
					return;
				}
				var girlOdds:Number = 50;
				//50% odds of slime-girl, 75% if shutdown factory
				if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1)
					girlOdds += 25;
				if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2)
					girlOdds -= 25;
				//Slimegirl!
				if (rand(100) <= girlOdds) {
					gooGirlScene.encounterGooGirl();
				}
				//OOZE!
				else {
					flags[kFLAGS.TIMES_MET_OOZE]++;
					spriteSelect(25);
					//High int starts on even footing.
					if (player.inte >= 25) {
						outputText("A soft shuffling sound catches your attention and you turn around, spotting an amorphous green mass sliding towards you!  Realizing it's been spotted, the ooze's mass surges upwards into a humanoid form with thick arms and wide shoulders.  The beast surges forward to attack!", true);
						startCombat(new GreenSlime());
						if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>", false);
						return;
					}
					//High speed starts on even footing.
					if (player.spe >= 30) {
						outputText("You feel something moist brush the back of your ankle and instinctively jump forward and roll, coming up to face whatever it is behind you.  The nearly silent, amorphous green slime that was at your feet surges vertically, its upper body taking the form of a humanoid with thick arms and wide shoulders, which attacks!", true);
						startCombat(new GreenSlime());
						if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>", false);
						return;
					}
					//High strength gets stunned first round.
					if (player.str >= 40) {
						outputText("Without warning, you feel something moist and spongy wrap around your ankle, nearly pulling you off balance.  With a ferocious tug, you pull yourself free and turn to face your assailant.  It is a large green ooze that surges upwards to take the form of humanoid with wide shoulders and massive arms.  It shudders for a moment, and its featureless face shifts into a green version of your own! The sight gives you pause for a moment, and the creature strikes!", true);
						if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>", false);
						startCombat(new GreenSlime());
						outputText("\n\n", false);
						monster.eAttack();
						return;
					}
					//Player's stats suck and you should feel bad.
					outputText("Without warning, you feel something moist and spongy wrap around your ankle, pulling you off balance!  You turn and try to pull your leg away, struggling against a large green ooze for a moment before your foot comes away with a *schlorp* and a thin coating of green fluid.  The rest of the ooze rises to tower over you, forming a massive green humanoid torso with hugely muscled arms and wide shoulders.  Adrenaline rushes into your body as you prepare for combat, and you feel your heart skip a beat as your libido begins to kick up as well!", true);
					if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>", false);
					dynStats("lib", 1, "lus", 10);
					startCombat(new GreenSlime());
				}
			}
			else if (select == 0) {
				outputText("Your quick walk along the lakeshore feels good.", true);
				if (player.spe >= 50) {

				}
				else {
					outputText("  You bet you could cover the same distance even faster next time.\n", false);
					dynStats("spe", .75);
				}
				doNext(camp.returnToCampUseOneHour);
			}
			else if (select == 1) {
				//No boat, no kaiju
				if (player.level >= 5 && flags[kFLAGS.KAIJU_DISABLED] == 0 && player.findStatusEffect(StatusEffects.BoatDiscovery) >= 0) {
					kaiju.kaijuMeeting();
					return;
				}
				outputText("Your stroll around the lake increasingly bores you, leaving your mind to wander.  ", true);
				if (player.cor > 30 || player.lust > 60 || player.lib > 40) outputText("Your imaginings increasingly seem to turn ", false);
				else dynStats("int", 1);
				if ((player.cor > 30 && player.cor < 60) || (player.lust > 60 && player.lust < 90) || (player.lib > 40 && player.lib < 75)) {
					outputText("to thoughts of sex.", false);
					dynStats("lus", (5 + player.lib / 10));
					displayed = true;
				}
				if (((player.cor >= 60) || (player.lust >= 90) || (player.lib >= 75)) && !displayed) {
					outputText("into daydreams of raunchy perverted sex, flooding your groin with warmth.", false);
					dynStats("lus", (player.cor / 10 + player.lib / 10));
				}
				doNext(camp.returnToCampUseOneHour);

			}
			//Find whitney or equinum
			else if (select == 2) {
				//40% chance of item, 60 of whitney.
				if (rand(10) < 4) {
					findLakeLoot();
				}
				//Find Whitney
				else {
					//Have you met whitney?
					if (player.findStatusEffect(StatusEffects.MetWhitney) >= 0) {
						//Is the farm in your places menu?
						if (player.statusEffectv1(StatusEffects.MetWhitney) > 1) {
							//If so, find equinum or whisker fruit
							findLakeLoot();
						}
						//If you havent met whitney enough to know the farm....
						else kGAMECLASS.farm.farmExploreEncounter();
					}
					//If you havent met whitney, you can find the farm....
					else kGAMECLASS.farm.farmExploreEncounter();
				}
			}
			else if (select == 3) {
				if (player.findStatusEffect(StatusEffects.FetishOn) < 0) {
					player.createStatusEffect(StatusEffects.FetishOn, 0, 0, 0, 0);
					outputText("While exploring, you notice something unusual on the lake.  This something is quickly moving towards you at a surprising rate, much faster than anything you've ever seen before.  Wary of meeting new things in this world after your previous experiences, you decide to slip behind a nearby hill and watch it while hidden.  Soon the object comes into view and you can see that it is a boat of some kind.  It looks almost like a large open box on the water with some kind of gazebo on it.  Despite how fast it is moving, you can't see any oars or means of moving the boat.  It slows somewhat when it gets close to the shore, but is still going about as fast as you can run when it hits the shore and extends some kind of gangplank onto the lake shore.  With a close up view, you estimate that it is six feet across, ten feet long, and doesn't actually seem to have very much of it underwater.  You guess that it must be magic in some way.  There are several robe-clad figures on board.\n\n", true);
					outputText("After a moment, a number of the figures disembark down the gangplank and immediately go off in different directions.  You count half a dozen of them, and guess that they are female when one of them passes by close to you and you see the hole in her outfit over her naughty bits.  You look back at the boat to see it close the gangplank, and move back onto the lake, with only one of the figures still on board.  Surprised to hear a sudden yell, you look to the side and see the clothing of the one who passed you earlier shift and twist before becoming some pink outfit that clings to her backside.  You are stunned for a moment as she disappears from sight before you shake your head and move on.  It seems there are new residents to the lake.\n\n<b>(Fetish Cultists can now be encountered!)</b>", false);
					//(increase player lust from the sights they saw)
					dynStats("lus", 5);
					doNext(camp.returnToCampUseOneHour);
					return;
				}
				fetishCultistScene.fetishCultistEncounter();
			}
			else if (select == 6) {
				kGAMECLASS.rathazul.encounterRathazul();
			}
			else if (select == 12) {
				kGAMECLASS.exploration.genericGobImpEncounters();
			}
			else {
				outputText("OH SHIT! LAKE EXPLORE BE BROKED.  SELECT: " + select + ".  You should probably go to fenoxo.com and click the link to report a bug and tell Fen (or Kitteh6660 since he makes the mod) about it.");
			}
		}
		
		private function findLakeLoot():void {
			clearOutput();
			if (rand(2) == 0) {
				outputText("You find a long and oddly flared vial half-buried in the sand.  Written across the middle band of the vial is a single word: 'Equinum'.\n");
				inventory.takeItem(consumables.EQUINUM, camp.returnToCampUseOneHour);
			}
			else {
				outputText("You find an odd, fruit-bearing tree growing near the lake shore.  One of the fruits has fallen on the ground in front of you.  You pick it up.\n");
				inventory.takeItem(consumables.W_FRUIT, camp.returnToCampUseOneHour);
			}
		}
		
		private function eggChoose(eggType:int):void {
			clearOutput();
			outputText("You reach out and touch the ");
			switch (eggType) {
				case  0: outputText("brown"); break;
				case  1: outputText("purple"); break;
				case  2: outputText("blue"); break;
				case  3: outputText("pink"); break;
				case  4: outputText("white"); break;
				default: outputText("black"); break;
			}
			outputText(" light.  Immediately it flows into your skin, glowing through your arm as if it were translucent.  It rushes through your shoulder and torso, down into your pregnant womb.  The other lights vanish.");
			player.statusEffect(player.findStatusEffect(StatusEffects.Eggs)).value1 = eggType; //Value 1 is the egg type. If pregnant with OviElixir then StatusEffects.Eggs must exist
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function eggChooseEscape():void {
			clearOutput();
			outputText("You throw yourself into a roll and take off, leaving the ring of lights hovering in the distance behind you.");
			doNext(camp.returnToCampUseOneHour);
		}
		

	}
}
