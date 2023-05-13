/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Lake.*;
import classes.Scenes.Dungeons.DemonLab;
import classes.Scenes.Holidays;
import classes.Scenes.NPCs.BelisaFollower;
import classes.Scenes.NPCs.EtnaFollower;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;

use namespace CoC;

	public class Lake extends BaseContent
	{
		
		public var fetishCultistScene:FetishCultistScene = new FetishCultistScene();
		public var fetishZealotScene:FetishZealotScene = new FetishZealotScene();
		public var gooGirlScene:GooGirlScene = new GooGirlScene();
		public var greenSlimeScene:GreenSlimeScene = new GreenSlimeScene();
		public var calluScene:CalluScene = new CalluScene();
		public var swordInStone:SwordInStone = new SwordInStone();

		public function Lake() {
			onGameInit(init);
		}

		private var _lakeEncounter:GroupEncounter = null;
		public function get lakeEncounter():GroupEncounter {
			return _lakeEncounter;
		}

		private function init():void {
			_lakeEncounter = Encounters.group("lake", {
				name: "villagepath",
				when: function ():Boolean {
					return flags[kFLAGS.AMILY_VILLAGE_ACCESSIBLE] == 0
				},
				chance: 0.2,
				call: SceneLib.amilyScene.discoverAmilyVillage
			}, {
				name: "boat",
				when: function ():Boolean {
					return !player.hasStatusEffect(StatusEffects.BoatDiscovery)
				},
				call: SceneLib.boat.discoverBoat
			}, {
				name: "farm",
				when: function ():Boolean {
					return !player.hasStatusEffect(StatusEffects.MetWhitney)  || player.statusEffectv1(StatusEffects.MetWhitney) <= 1
				},
				call: SceneLib.farm.farmExploreEncounter
			}, {
				name: "eggchoose",
				when: function ():Boolean {
					return player.isPregnant() && (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS || player.pregnancy2Type == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS)
				},
				chance: 0.25,
				call: eggChooseFn
			}, {
				name: "dickdrag",
				when: function ():Boolean {
					return (10 + (player.longestCockLength() - player.tallness) / 24 * 10) > 0 &&
							player.longestCockLength() >= player.tallness - 10 && player.totalCockThickness() >= 8
				},
				call: function ():void {
					SceneLib.forest.bigJunkForestScene(true);
				}
			}, {
				name: "walk",
				when: function ():Boolean {
					return player.level < 3 || player.canTrain('spe',player.trainStatCap("spe",50))
				},
				call: walkAroundLake
			}, {
				name: "finditems",
				call: findLakeLoot
			}, {
				name: "nothing",
				chance: 0.4,
				call: findNothing
			}, {
				name: "holystuff",
				when: function ():Boolean {
					return !player.hasStatusEffect(StatusEffects.BlessedItemAtTheLake) && (
							!player.hasStatusEffect(StatusEffects.TookBlessedSword) && !player.hasStatusEffect(StatusEffects.BSwordBroken) ||
							!player.hasStatusEffect(StatusEffects.TookBlessedBow) && !player.hasStatusEffect(StatusEffects.BBowBroken) && player.hasPerk(PerkLib.JobRanger) ||
							!player.hasStatusEffect(StatusEffects.TookBlessedStaff) && !player.hasStatusEffect(StatusEffects.BStaffBroken) && player.hasPerk(PerkLib.JobSorcerer) ||
							!player.hasStatusEffect(StatusEffects.TookBlessedShield) && !player.hasStatusEffect(StatusEffects.BShieldBroken) && player.hasPerk(PerkLib.JobGuardian)
					)
				},
				chance: 0.2,
				call: findBlesedItemEncounterFn
			}, {
				name: "ponies",
				when: function ():Boolean {
					return player.isTaur() && Holidays.isAprilFools() && flags[kFLAGS.PONY_APRIL_FOOLS] == 0
				},
				call: function ():void {
					if (!SceneLib.holidays.poniesYN())
						findNothing();
				}
			}, {
				name: "cultist",
				when: function ():Boolean {
					return player.level >= 3 && flags[kFLAGS.FACTORY_SHUTDOWN] > 0
				},
				chance: 0.2,
				night: false,
				call: fetishCultist
			}, {
				name: "izma",
				when: function ():Boolean {
					return player.level >= 3 && flags[kFLAGS.IZMA_ENCOUNTER_COUNTER] > 0 && player.exploredLake >= 10 && (flags[kFLAGS.IZMA_WORMS_SCARED] == 0 || !player.hasStatusEffect(StatusEffects.Infested)) && flags[kFLAGS.IZMA_FOLLOWER_STATUS] <= 0
				},
				chance: lakeChance,
				call: SceneLib.izmaScene.meetIzmaAtLake
			}, {
				name: "belisa",
				when: function ():Boolean {
					return BelisaFollower.BelisaInGame && BelisaFollower.BelisaFollowerStage < 3 && BelisaFollower.BelisaEncounternum >= 2
				},
				chance: lakeChance,
				call: SceneLib.belisa.subsequentEncounters
			}, {
				name: "callu",
				when: function ():Boolean {
					return !player.hasStatusEffect(StatusEffects.CalluOff)
				},
				night: false,
				chance: 1/8,
				call: calluScene.ottahGirl
			}, {
				name: "latexgirl",
				when: function ():Boolean {
					return flags[kFLAGS.GOO_TFED_MEAN] + flags[kFLAGS.GOO_TFED_NICE] > 0 && flags[kFLAGS.GOO_SLAVE_RECRUITED] == 0
				},
				chance: lakeChance,
				call: SceneLib.latexGirl.encounterLeftBehindGooSlave
			}, {
				name: "rathazul",
				when: function ():Boolean {
					return !player.hasStatusEffect(StatusEffects.CampRathazul)
				},
				chance: lakeChance,
				night: false,
				call: SceneLib.rathazul.encounterRathazul
			}, {
				name: "slimeooze",
				when: function ():Boolean {
					return player.level >= 3
				},
				call: slimeOozeEncounterFn
			}, {
				name: "common",
				when: function ():Boolean {
					return player.level >= 3 && flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0
				},
				night: false,
				call: SceneLib.exploration.genericGolGobImpEncounters
			}, {
				//Helia monogamy fucks
				name: "helcommon",
				night : false,
				call: SceneLib.helScene.helSexualAmbush,
				chance: lakeChance,
				when: SceneLib.helScene.helSexualAmbushCondition
			}, {
				name: "etna",
				when: function ():Boolean {
					return (flags[kFLAGS.ETNA_FOLLOWER] < 1 || EtnaFollower.EtnaInfidelity == 2)
							&& flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2
							&& !player.hasStatusEffect(StatusEffects.EtnaOff)
							&& (player.level >= 20);
				},
				chance: lakeChance,
				call: SceneLib.etnaScene.repeatYandereEnc
			},  {
				name: "diana",
				night : false,
				when: function():Boolean {
					return player.level >= 3 && flags[kFLAGS.DIANA_FOLLOWER] < 6 && !(flags[kFLAGS.DIANA_FOLLOWER] != 3 && flags[kFLAGS.DIANA_LVL_UP] >= 8) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1 && !player.hasStatusEffect(StatusEffects.DianaOff);
				},
				chance: lakeChance,
				call: SceneLib.dianaScene.repeatEnc
			}, {
				name: "dianaName",
				night : false,
				when: function():Boolean {
					return ((flags[kFLAGS.DIANA_FOLLOWER] < 3 || flags[kFLAGS.DIANA_FOLLOWER] == 5) && flags[kFLAGS.DIANA_LVL_UP] >= 8) && !player.hasStatusEffect(StatusEffects.DianaOff) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1;
				},
				chance: lakeChance,
				call: SceneLib.dianaScene.postNameEnc
			}/*, {
				name: "demonProjects",
				chance: 0.2,
				when: function ():Boolean {
					return DemonLab.MainAreaComplete >= 4;
				},
				call: SceneLib.exploration.demonLabProjectEncounters
			}*/);
		}

		public function isDiscovered():Boolean {
			return player.exploredLake > 0;
		}
		public function timesExplored():int {
			return player.exploredLake;
		}

		//Explore Lake
		public function exploreLake():void
		{
			clearOutput();
			player.exploredLake++;
			player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
			doNext(camp.returnToCampUseOneHour);
			lakeEncounter.execEncounter();
			flushOutputTextToGUI();
		}

		public function lakeChance():Number {
			var temp:Number = 0.5;
			if (flags[kFLAGS.SAMIRAH_FOLLOWER] < 10) temp *= player.npcChanceToEncounter();
			return temp;
		}

		private function slimeOozeEncounterFn():void {
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
				player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
				gooGirlScene.encounterGooGirl();
			}
			//OOZE!
			else {
				flags[kFLAGS.TIMES_MET_OOZE]++;
				spriteSelect(SpriteDb.s_green_slime);
				//High int starts on even footing.
				if (player.inte >= 25) {
					clearOutput();
					outputText("A soft shuffling sound catches your attention and you turn around, spotting an amorphous green mass sliding towards you!  Realizing it's been spotted, the ooze's mass surges upwards into a humanoid form with thick arms and wide shoulders.  The beast surges forward to attack!");
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					startCombat(new GreenSlime());
					if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>");
					return;
				}
				//High speed starts on even footing.
				if (player.spe >= 30) {
					clearOutput();
					outputText("You feel something moist brush the back of your ankle and instinctively jump forward and roll, coming up to face whatever it is behind you.  The nearly silent, amorphous green slime that was at your feet surges vertically, its upper body taking the form of a humanoid with thick arms and wide shoulders, which attacks!");
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					startCombat(new GreenSlime());
					if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>");
					return;
				}
				//High strength gets stunned first round.
				if (player.str >= 40) {
					clearOutput();
					outputText("Without warning, you feel something moist and spongy wrap around your ankle, nearly pulling you off balance.  With a ferocious tug, you pull yourself free and turn to face your assailant.  It is a large green ooze that surges upwards to take the form of humanoid with wide shoulders and massive arms.  It shudders for a moment, and its featureless face shifts into a green version of your own! The sight gives you pause for a moment, and the creature strikes!");
					if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>");
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					startCombat(new GreenSlime());
					outputText("\n\n");
					monster.eAttack();
					return;
				}
				//Player's stats suck and you should feel bad.
				clearOutput();
				outputText("Without warning, you feel something moist and spongy wrap around your ankle, pulling you off balance!  You turn and try to pull your leg away, struggling against a large green ooze for a moment before your foot comes away with a *schlorp* and a thin coating of green fluid.  The rest of the ooze rises to tower over you, forming a massive green humanoid torso with hugely muscled arms and wide shoulders.  Adrenaline rushes into your body as you prepare for combat, and you feel your heart skip a beat as your libido begins to kick up as well!");
				if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>");
				dynStats("lib", 1, "lus", 10);
				startCombat(new GreenSlime());
			}
		}

		private function fetishCultist():void {
			if (!player.hasStatusEffect(StatusEffects.FetishOn)) {
				player.createStatusEffect(StatusEffects.FetishOn, 0, 0, 0, 0);
				clearOutput();
				outputText("While exploring, you notice something unusual on the lake.  This something is quickly moving towards you at a surprising rate, much faster than anything you've ever seen before.  Wary of meeting new things in this world after your previous experiences, you decide to slip behind a nearby hill and watch it while hidden.  Soon the object comes into view and you can see that it is a boat of some kind.  It looks almost like a large open box on the water with some kind of gazebo on it.  Despite how fast it is moving, you can't see any oars or means of moving the boat.  It slows somewhat when it gets close to the shore, but is still going about as fast as you can run when it hits the shore and extends some kind of gangplank onto the lake shore.  With a close up view, you estimate that it is six feet across, ten feet long, and doesn't actually seem to have very much of it underwater.  You guess that it must be magic in some way.  There are several robe-clad figures on board.\n\n");
				outputText("After a moment, a number of the figures disembark down the gangplank and immediately go off in different directions.  You count half a dozen of them, and guess that they are female when one of them passes by close to you and you see the hole in her outfit over her naughty bits.  You look back at the boat to see it close the gangplank, and move back onto the lake, with only one of the figures still on board.  Surprised to hear a sudden yell, you look to the side and see the clothing of the one who passed you earlier shift and twist before becoming some pink outfit that clings to her backside.  You are stunned for a moment as she disappears from sight before you shake your head and move on.  It seems there are new residents to the lake.\n\n<b>(Fetish Cultists can now be encountered!)</b>");
				//(increase player lust from the sights they saw)
				dynStats("lus", 5, "scale", false);
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			fetishCultistScene.fetishCultistEncounter();
		}

		private function findBlesedItemEncounterFn():void {
			if (!player.hasStatusEffect(StatusEffects.TookBlessedSword) && !player.hasStatusEffect(StatusEffects.BSwordBroken) && rand(5) == 0) {// && player.hasPerk(PerkLib.JobWarrior)
				player.createStatusEffect(StatusEffects.BlessedItemAtTheLake, 0, 0, 0, 0);
				swordInStone.findSwordInStone();
				return;
			}
			if (!player.hasStatusEffect(StatusEffects.TookBlessedBow) && !player.hasStatusEffect(StatusEffects.BBowBroken) && player.hasPerk(PerkLib.JobRanger) && rand(3) == 0) {
				player.createStatusEffect(StatusEffects.BlessedItemAtTheLake, 0, 0, 0, 0);
				swordInStone.findBowInStone();
				return;
			}
			if (!player.hasStatusEffect(StatusEffects.TookBlessedStaff) && !player.hasStatusEffect(StatusEffects.BStaffBroken) && player.hasPerk(PerkLib.JobSorcerer) && rand(3) == 0) {
				player.createStatusEffect(StatusEffects.BlessedItemAtTheLake, 0, 0, 0, 0);
				swordInStone.findStaffInStone();
				return;
			}
			if (!player.hasStatusEffect(StatusEffects.TookBlessedShield) && !player.hasStatusEffect(StatusEffects.BShieldBroken) && player.hasPerk(PerkLib.JobGuardian) && rand(3) == 0) {
				player.createStatusEffect(StatusEffects.BlessedItemAtTheLake, 0, 0, 0, 0);
				swordInStone.findShieldInStone();
				return;
			}
			findNothing();
		}

		private function walkAroundLake():void {
			clearOutput();
			outputText("Your quick walk along the lakeshore feels good.");
			if (player.canTrain('spe', player.trainStatCap("spe",50))) {
				outputText("  You bet you could cover the same distance even faster next time.\n");
				player.trainStat("spe", +1, player.trainStatCap("spe",50));
			}
			dynStats("spe", .75);
			doNext(camp.returnToCampUseOneHour);
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

		private function findNothing():void {
			//No boat, no kaiju
			clearOutput();
			outputText("Your stroll around the lake increasingly bores you, leaving your mind to wander.  ");
			if (player.cor > 30 || player.lust100 > 60 || player.lib100 > 40) {
				outputText("Your imaginings increasingly seem to turn ");
				if ((player.cor < 60) || (player.lust100 > 60 && player.lust100 < 90) || (player.lib100 > 40 && player.lib100 < 75)) {
					outputText("to thoughts of sex.");
					dynStats("lus", (5 + player.lib / 10), "scale", false);
				} else {
					outputText("into daydreams of raunchy perverted sex, flooding your groin with warmth.");
					dynStats("lus", (player.cor / 10 + player.lib / 10), "scale", false);
				}
			}
			else dynStats("int", 1);
			doNext(camp.returnToCampUseOneHour);
		}

		private function eggChooseFn():void {
			clearOutput();
			outputText("While wandering along the lakeshore, you spy beautiful colored lights swirling under the surface.  You lean over cautiously, and leap back as they flash free of the lake's liquid without making a splash.  The colored lights spin in a circle, surrounding you.  You wonder how you are to fight light, but they stop moving and hover in place around you.  There are numerous colors: Blue, Pink, White, Black, Purple, and Brown.  They appear to be waiting for something; perhaps you could touch one of them?");
			menu();
			addButton(0, "Blue", eggChoose, 2);
			addButton(1, "Pink", eggChoose, 3);
			addButton(2, "White", eggChoose, 4);
			addButton(3, "Black", eggChoose, 5);
			addButton(4, "Purple", eggChoose, 1);
			addButton(5, "Brown", eggChoose, 0);
			addButton(9, "Escape", eggChooseEscape);
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
			player.statusEffectByType(StatusEffects.Eggs).value1 = eggType; //Value 1 is the egg type. If pregnant with OviElixir then StatusEffects.Eggs must exist
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function eggChooseEscape():void {
			clearOutput();
			outputText("You throw yourself into a roll and take off, leaving the ring of lights hovering in the distance behind you.");
			doNext(camp.returnToCampUseOneHour);
		}

	}
}
