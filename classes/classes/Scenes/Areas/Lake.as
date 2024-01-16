/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Lake.*;
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
		
		public const discoverLevel:int = 0;
		public const areaLevel:int = 0;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.lake > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= discoverLevel && flags[kFLAGS.ALVINA_FOLLOWER] == 1;
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.lake;
		}
		public function discover():void {
			clearOutput();
			outputText("Your wanderings take you far and wide across the barren wasteland that surrounds the portal, until the smell of humidity and fresh water alerts you to the nearby lake.  With a few quick strides, you find a lake so massive that the distant shore cannot be seen.  Grass and a few sparse trees grow all around it.\n\n<b>You've discovered the Lake!</b>");
			SceneLib.exploration.counters.lake = 1;
			endEncounter(60);
		}
		
		
		public function Lake() {
			onGameInit(init);
		}

		private var _lakeEncounter:GroupEncounter = null;
		public function get lakeEncounter():GroupEncounter {
			return _lakeEncounter;
		}

		private function init():void {
			const fn:FnHelpers = Encounters.fn;
			_lakeEncounter = Encounters.group("lake", {
				name: "villagepath",
				label : "Village",
				kind  : 'place',
				unique: true,
				when: function ():Boolean {
					return flags[kFLAGS.AMILY_VILLAGE_ACCESSIBLE] == 0
				},
				chance: 0.2,
				call: SceneLib.amilyScene.discoverAmilyVillage
			}, {
				name: "boat",
				label : "Boat",
				kind  : 'place',
				unique: true,
				when: SceneLib.boat.canDiscover,
				call: SceneLib.boat.discoverBoat
			}, {
				name: "farm",
				label : "Farm",
				kind  : 'place',
				unique: true,
				when: function ():Boolean {
					return !player.hasStatusEffect(StatusEffects.MetWhitney)  || player.statusEffectv1(StatusEffects.MetWhitney) <= 1
				},
				call: SceneLib.farm.farmExploreEncounter
			}, {
				name: "eggchoose",
				label : "Eggs",
				kind  : 'item',
				when: function ():Boolean {
					return player.isPregnant() && (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS || player.pregnancy2Type == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS)
				},
				chance: 0.25,
				call: eggChooseFn
			}, {
				name: "dickdrag",
				label : "Dragging",
				kind  : 'event',
				when: function ():Boolean {
					return (10 + (player.longestCockLength() - player.tallness) / 24 * 10) > 0 &&
							player.longestCockLength() >= player.tallness - 10 && player.totalCockThickness() >= 8
				},
				call: function ():void {
					SceneLib.forest.bigJunkForestScene(true);
				}
			}, {
				name: "walk",
				kind: "walk",
				when: function ():Boolean {
					return player.level < 3 || player.canTrain('spe',player.trainStatCap("spe",50))
				},
				call: walkAroundLake
			}, {
				name: "EQUINUM",
				label : "Equinum",
				kind  : 'item',
				call: findEquinum
			}, {
				name: "W_FRUIT",
				label : "W.Fruit",
				kind  : 'item',
				call: findWFruit
			}, {
				name  : "nothing",
				label : "walk",
				kind  : "walk",
				chance: 0.4,
				call  : findNothing
			}, {
				name: "holysword",
				label : "Holy Sword",
				kind  : 'item',
				chance: 0.2,
				unique: 'holyitem', // only one enc with unique:holyitem can appear
				when: function():Boolean {
					return !player.hasStatusEffect(StatusEffects.TookBlessedSword) && !player.hasStatusEffect(StatusEffects.BSwordBroken) && player.hasPerk(PerkLib.JobWarrior);
				},
				call: swordInStone.findSwordInStone
			}, {
				name: "holybow",
				label : "Holy Bow",
				kind  : 'item',
				chance: 0.2,
				unique: 'holyitem', // only one enc with unique:holyitem can appear
				when: function():Boolean {
					return !player.hasStatusEffect(StatusEffects.TookBlessedBow) && !player.hasStatusEffect(StatusEffects.BBowBroken) && player.hasPerk(PerkLib.JobRanger);
				},
				call: swordInStone.findBowInStone
			}, {
				name: "holystaff",
				label : "Holy Staff",
				kind  : 'item',
				chance: 0.2,
				unique: 'holyitem', // only one enc with unique:holyitem can appear
				when: function():Boolean {
					return !player.hasStatusEffect(StatusEffects.TookBlessedStaff) && !player.hasStatusEffect(StatusEffects.BStaffBroken) && player.hasPerk(PerkLib.JobSorcerer);
				},
				call: swordInStone.findStaffInStone
			}, {
				name: "holyshield",
				label : "Holy Shield",
				kind  : 'item',
				chance: 0.2,
				unique: 'holyitem', // only one enc with unique:holyitem can appear
				when: function():Boolean {
					return !player.hasStatusEffect(StatusEffects.TookBlessedShield) && !player.hasStatusEffect(StatusEffects.BShieldBroken) && player.hasPerk(PerkLib.JobGuardian);
				},
				call: swordInStone.findShieldInStone
			}, {
				name: "holywhip",
				label : "Holy Whip",
				kind  : 'item',
				chance: 0.2,
				unique: 'holyitem', // only one enc with unique:holyitem can appear
				when: function():Boolean {
					return !player.hasStatusEffect(StatusEffects.TookBlessedWhip) && !player.hasStatusEffect(StatusEffects.BWhipBroken) && player.hasPerk(PerkLib.JobSeducer);
				},
				call: swordInStone.findWhipInStone
			}, {
				name: "holyflywhisk",
				label : "Holy Fly-Whisk",
				kind  : 'item',
				chance: 0.2,
				unique: 'holyitem', // only one enc with unique:holyitem can appear
				when: function():Boolean {
					return !player.hasStatusEffect(StatusEffects.TookBlessedFlyWhisk) && !player.hasStatusEffect(StatusEffects.BFlyWhiskBroken) && player.hasPerk(PerkLib.JobSoulCultivator);
				},
				call: swordInStone.findFlyWhiskInStone
			}, {
				name: "ponies",
				label : "Ponies",
				kind  : 'event',
				when: function ():Boolean {
					return player.isTaur() && Holidays.isAprilFools() && flags[kFLAGS.PONY_APRIL_FOOLS] == 0
				},
				call: function ():void {
					if (!SceneLib.holidays.poniesYN())
						findNothing();
				}
			}, {
				name: "cultist",
				label : "Fetish Cultist",
				kind : 'monster',
				chance: 0.2,
				mods: [fn.ifLevelMin(3)],
				night: false,
				call: fetishCultist
			}, {
				name: "izma",
				label : "Izma",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return player.level >= 3 && flags[kFLAGS.IZMA_ENCOUNTER_COUNTER] > 0 && timesExplored() >= 10 && (flags[kFLAGS.IZMA_WORMS_SCARED] == 0 || !player.hasStatusEffect(StatusEffects.Infested)) && flags[kFLAGS.IZMA_FOLLOWER_STATUS] <= 0
				},
				chance: lakeChance,
				call: SceneLib.izmaScene.meetIzmaAtLake
			}, {
				name: "belisa",
				label : "Belisa",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return BelisaFollower.BelisaInGame && BelisaFollower.BelisaFollowerStage < 3 && BelisaFollower.BelisaEncounternum >= 2
				},
				chance: lakeChance,
				call: SceneLib.belisa.subsequentEncounters
			}, {
				name: "callu",
				label : "Callu",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return !player.hasStatusEffect(StatusEffects.CalluOff)
				},
				night: false,
				chance: 1/8,
				call: calluScene.ottahGirl
			}, {
				name: "latexgirl",
				label : "Latex Girl",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return flags[kFLAGS.GOO_TFED_MEAN] + flags[kFLAGS.GOO_TFED_NICE] > 0 && flags[kFLAGS.GOO_SLAVE_RECRUITED] == 0
				},
				chance: lakeChance,
				call: SceneLib.latexGirl.encounterLeftBehindGooSlave
			}, {
				name: "rathazul",
				label : "Rathazul",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return !player.hasStatusEffect(StatusEffects.CampRathazul)
				},
				chance: lakeChance,
				night: false,
				call: SceneLib.rathazul.encounterRathazul
			}, {
				name: "slime",
				label : "Green Slime",
				kind : 'monster',
				chance: function():Number {
					return 1 - gooGirlChance()
				},
				mods: [fn.ifLevelMin(3)],
				call: greenSlime
			}, {
				name: "googirl",
				label : "Goo-Girl",
				kind : 'monster',
				chance: gooGirlChance,
				mods: [fn.ifLevelMin(3)],
				call: gooGirlScene.encounterGooGirl
			}, {
				name: "slimeoozesex",
				label : "Goo x Ooze",
				kind : 'event',
				chance: function():Number {
					//Chance of seeing ooze convert goo!
					//More common if factory blew up
					//Else pretty rare.
					return flags[kFLAGS.FACTORY_SHUTDOWN] == 2 ? 0.1 : 0.04
				},
				when: function ():Boolean {
					return player.level >= 3
				},
				call: gooGirlScene.spyOnGooAndOozeSex
			}, SceneLib.exploration.commonEncounters.wrap(function ():Boolean {
				return player.level >= 3 && flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0
			}, [0.1]), {
				//Helia monogamy fucks
				name: "helcommon",
				label : "Helia",
				kind  : 'npc',
				unique: true,
				night : false,
				call: SceneLib.helScene.helSexualAmbush,
				chance: lakeChance,
				when: SceneLib.helScene.helSexualAmbushCondition
			}, {
				name: "etna",
				label : "Etna",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return (flags[kFLAGS.ETNA_FOLLOWER] < 1 || EtnaFollower.EtnaInfidelity == 2)
							&& flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2
							&& !player.hasStatusEffect(StatusEffects.EtnaOff)
							&& (player.level >= 20);
				},
				chance: lakeChance,
				call: SceneLib.etnaScene.repeatYandereEnc
			},  {
				name: "nadia",
				label : "Nadia",
				kind  : 'npc',
				unique: true,
				night : false,
				when: function():Boolean {
					return player.level >= 3 && flags[kFLAGS.NADIA_FOLLOWER] < 6 && !(flags[kFLAGS.NADIA_FOLLOWER] != 3 && flags[kFLAGS.NADIA_LVL_UP] >= 8) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1 && !player.hasStatusEffect(StatusEffects.NadiaOff);
				},
				chance: lakeChance,
				call: SceneLib.nadiaScene.repeatEnc
			}, {
				name: "nadiaName",
				label : "Nadia",
				kind  : 'npc',
				unique: true,
				night : false,
				when: function():Boolean {
					return ((flags[kFLAGS.NADIA_FOLLOWER] < 3 || flags[kFLAGS.NADIA_FOLLOWER] == 5) && flags[kFLAGS.NADIA_LVL_UP] >= 8) && !player.hasStatusEffect(StatusEffects.NadiaOff) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1;
				},
				chance: lakeChance,
				call: SceneLib.nadiaScene.postNameEnc
			}, {
				name: "demonProjects",
				label : "DemLab Subject",
				kind  : 'monster',
				chance: 0.2,
				when: function ():Boolean {
					return SceneLib.exploration.demonLabProjectEncountersEnabled();
				},
				call: SceneLib.exploration.demonLabProjectEncounters
			});
		}

		//Explore Lake
		public function exploreLake():void
		{
			explorer.prepareArea(lakeEncounter);
			explorer.setTags("lake", "lakeBeach", "water");
			explorer.prompt = "You explore the lake beach.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.lake++;
			}
			explorer.leave.hint("Leave the lake");
			explorer.skillBasedReveal(areaLevel, timesExplored());
			explorer.doExplore();
		}

		public function lakeChance():Number {
			var temp:Number = 0.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}

		private function gooGirlChance():Number {
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) return 0.75
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) return 0.25;
			return 0.5;
		}
		
		private function greenSlime():void {
			flags[kFLAGS.TIMES_MET_OOZE]++;
			spriteSelect(SpriteDb.s_green_slime);
			//High int starts on even footing.
			if (player.inte >= 25) {
				clearOutput();
				outputText("A soft shuffling sound catches your attention and you turn around, spotting an amorphous green mass sliding towards you!  Realizing it's been spotted, the ooze's mass surges upwards into a humanoid form with thick arms and wide shoulders.  The beast surges forward to attack!");
				startCombat(new GreenSlime());
				if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>");
				return;
			}
			//High speed starts on even footing.
			if (player.spe >= 30) {
				clearOutput();
				outputText("You feel something moist brush the back of your ankle and instinctively jump forward and roll, coming up to face whatever it is behind you.  The nearly silent, amorphous green slime that was at your feet surges vertically, its upper body taking the form of a humanoid with thick arms and wide shoulders, which attacks!");
				startCombat(new GreenSlime());
				if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>");
				return;
			}
			//High strength gets stunned first round.
			if (player.str >= 40) {
				clearOutput();
				outputText("Without warning, you feel something moist and spongy wrap around your ankle, nearly pulling you off balance.  With a ferocious tug, you pull yourself free and turn to face your assailant.  It is a large green ooze that surges upwards to take the form of humanoid with wide shoulders and massive arms.  It shudders for a moment, and its featureless face shifts into a green version of your own! The sight gives you pause for a moment, and the creature strikes!");
				if (flags[kFLAGS.FACTORY_SHUTDOWN] == 1) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>");
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
		private function fetishCultist():void {
			if (!player.hasStatusEffect(StatusEffects.FetishOn)) {
				player.createStatusEffect(StatusEffects.FetishOn, 0, 0, 0, 0);
				clearOutput();
				outputText("While exploring, you notice something unusual on the lake.  This something is quickly moving towards you at a surprising rate, much faster than anything you've ever seen before.  Wary of meeting new things in this world after your previous experiences, you decide to slip behind a nearby hill and watch it while hidden.  Soon the object comes into view and you can see that it is a boat of some kind.  It looks almost like a large open box on the water with some kind of gazebo on it.  Despite how fast it is moving, you can't see any oars or means of moving the boat.  It slows somewhat when it gets close to the shore, but is still going about as fast as you can run when it hits the shore and extends some kind of gangplank onto the lake shore.  With a close up view, you estimate that it is six feet across, ten feet long, and doesn't actually seem to have very much of it underwater.  You guess that it must be magic in some way.  There are several robe-clad figures on board.\n\n");
				outputText("After a moment, a number of the figures disembark down the gangplank and immediately go off in different directions.  You count half a dozen of them, and guess that they are female when one of them passes by close to you and you see the hole in her outfit over her naughty bits.  You look back at the boat to see it close the gangplank, and move back onto the lake, with only one of the figures still on board.  Surprised to hear a sudden yell, you look to the side and see the clothing of the one who passed you earlier shift and twist before becoming some pink outfit that clings to her backside.  You are stunned for a moment as she disappears from sight before you shake your head and move on.  It seems there are new residents to the lake.\n\n<b>(Fetish Cultists can now be encountered!)</b>");
				//(increase player lust from the sights they saw)
				dynStats("lus", 5, "scale", false);
				endEncounter();
				return;
			}
			fetishCultistScene.fetishCultistEncounter();
		}

		private function walkAroundLake():void {
			clearOutput();
			outputText("Your quick walk along the lakeshore feels good.");
			if (player.canTrain('spe', player.trainStatCap("spe",50))) {
				outputText("  You bet you could cover the same distance even faster next time.\n");
				player.trainStat("spe", +1, player.trainStatCap("spe",50));
			}
			dynStats("spe", .75);
			endEncounter();
		}

		private function findEquinum():void {
			outputText("You find a long and oddly flared vial half-buried in the sand.  Written across the middle band of the vial is a single word: 'Equinum'.\n");
			inventory.takeItem(consumables.EQUINUM, explorer.done);
		}
		private function findWFruit():void {
			outputText("You find an odd, fruit-bearing tree growing near the lake shore.  One of the fruits has fallen on the ground in front of you.  You pick it up.\n");
			inventory.takeItem(consumables.W_FRUIT, explorer.done);
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
			endEncounter();
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
			endEncounter();
		}
		
		private function eggChooseEscape():void {
			clearOutput();
			outputText("You throw yourself into a roll and take off, leaving the ring of lights hovering in the distance behind you.");
			endEncounter();
		}

	}
}
