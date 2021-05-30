/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Forest.*;
import classes.Scenes.Holidays;
import classes.Scenes.Monsters.DarkElfScene;
import classes.Scenes.NPCs.AikoScene;
import classes.Scenes.NPCs.CelessScene;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.Places.WoodElves;
import classes.Scenes.SceneLib;
import classes.lists.Gender;

import coc.xxc.BoundStory;
import coc.xxc.stmts.ZoneStmt;

use namespace CoC;

	public class Forest extends BaseContent
	{
		public var akbalScene:AkbalScene = new AkbalScene();
		public var beeGirlScene:BeeGirlScene = new BeeGirlScene();
		public var corruptedGlade:CorruptedGlade = new CorruptedGlade();
		public var essrayle:Essrayle = new Essrayle();
		public var faerie:Faerie = new Faerie();
		public var kitsuneScene:KitsuneScene = new KitsuneScene();
		public var tamaniDaughtersScene:TamainsDaughtersScene = new TamainsDaughtersScene();
		public var tamaniScene:TamaniScene = new TamaniScene();
		public var tentacleBeastScene:TentacleBeastScene = new TentacleBeastScene();
		public var erlkingScene:ErlKingScene = new ErlKingScene();
		public var alrauneScene:AlrauneScene = new AlrauneScene();
		public var darkelfScene:DarkElfScene = new DarkElfScene();
		public var aikoScene:AikoScene = new AikoScene();
		public var nightmareScene:NightmareScene = new NightmareScene();
		// public var dullahanScene:DullahanScene = new DullahanScene(); // [INTERMOD:8chan]

		public function Forest() {
			onGameInit(init);
		}
		
		public function isDiscovered():Boolean {
			return player.exploredForest > 0;
		}
		public function timesExplored():int {
			return player.exploredForest;
		}
		public function deepwoodsDiscovered():Boolean {
			return player.hasStatusEffect(StatusEffects.ExploredDeepwoods);
		}
		public function timesExploredDeepwoods():int {
			return player.statusEffectv1(StatusEffects.ExploredDeepwoods);
		}

		private function deepwoodsWalkFn():void {
			clearOutput();
			outputText("You enjoy a peaceful walk in the deepwoods.  It gives you time to think over the recent, disturbing events.");
			dynStats("tou", 0.5, "int", 1);
			doNext(camp.returnToCampUseOneHour);
		}
		public function tentacleBeastDeepwoodsEncounterFn():void {
			if (player.gender > 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00247] = 0;
			//Tentacle avoidance chance due to dangerous plants
			if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
				clearOutput();
				outputText("Using the knowledge contained in your 'Dangerous Plants' book, you determine a tentacle beast's lair is nearby, do you continue?  If not you could return to camp.\n\n");
				menu();
				addButton(0, "Continue", tentacleBeastScene.encounter);
				addButton(1, "Leave", camp.returnToCampUseOneHour);
			} else {
				tentacleBeastScene.encounter();
			}
		}
		private var _forestEncounter:GroupEncounter = null;
		private var _deepwoodsEncounter:GroupEncounter = null;
		public function get forestEncounter():GroupEncounter {
			return _forestEncounter;
		}
		public function get deepwoodsEncounter():GroupEncounter {
			return _deepwoodsEncounter
		}
		private function init():void {
            const game:CoC = CoC.instance;
            const fn:FnHelpers = Encounters.fn;
			_forestEncounter = Encounters.group("forest", {
						//General Golems, Goblin and Imp Encounters
						name: "common",
						call: SceneLib.exploration.genericGolGobImpEncounters
					}, {
						//Helia monogamy fucks
						name  : "helcommon",
						call  : SceneLib.helScene.helSexualAmbush,
						chance: 0.2,
						when  : SceneLib.helScene.helSexualAmbushCondition
					}, {
						name  : "deepwoods",
						call  : discoverDeepwoods,
						when  : function ():Boolean {
							return (player.level >= 7) && !deepwoodsDiscovered();
						},
						chance: Encounters.ALWAYS
					},  {
						name  : "Tamani",
						chance: 0.6,
						call  : function ():void {
							if (flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN] == 0
								&& flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16) {
								tamaniDaughtersScene.encounterTamanisDaughters();
							} else {
								tamaniScene.encounterTamani();
							}
						},
						when  : function ():Boolean {
							return flags[kFLAGS.TAMANI_TIME_OUT] == 0
								   && player.gender > 0
								   && (player.cockTotal() > 0 || player.hasKeyItem("Deluxe Dildo") < 0)
								   && flags[kFLAGS.SOUL_SENSE_TAMANI] < 3;
						}
					}, {
						name  : "Tamani_Daughters",
						call  : encounterTamanisDaughtersFn,
						when  : function ():Boolean {
							return player.gender > 0
								&& player.cockTotal() > 0
								&& flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16
								&& flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] < 3;
						}
					}, {
						name  : "Jojo",
						when  : function ():Boolean {
							return !player.hasStatusEffect(StatusEffects.PureCampJojo)
								   && !camp.campCorruptJojo()
								   && flags[kFLAGS.JOJO_DEAD_OR_GONE] <= 0
								   && (JojoScene.monk < 2 || rand(2) == 0);
						},
						mods  : [fn.ifLevelMin(4)],
						chance: function ():Number {
							//Extra chance of Jojo encounter.
							return (player.findPerk(PerkLib.PiercedFurrite) >= 0
									&& rand(5) == 0
									&& (player.cor > 25 || JojoScene.monk > 0)) ? 1.2 : 1;
						},
						call  : jojoEncounter
					}, {
						name  : "tentaBeast",
						call  : tentacleBeastEncounterFn,
						when  : fn.ifLevelMin(3)
					},{
						name  : "corrGlade",
						call  : corruptedGladeFn,
						when  : function():Boolean {
							return flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] < 100;
						},
						chance: function():Number {
							return (100 - 0.75*(flags[kFLAGS.CORRUPTED_GLADES_DESTROYED]||0))/100;
						}
					},{
						name: "trip",
						call: tripOnARoot
					},{
						name  : "beegirl",
						call  : beeGirlScene.beeEncounter,
						chance: 0.50
					}//,{
					//	name  : "WoodElf",
					//	call  : SceneLib.woodElves.findElves,
					//	chance: 0.50,
					//	when  : function ():Boolean {
					//		return (WoodElves.WoodElvesQuest == WoodElves.QUEST_STAGE_NOT_STARTED
					//				|| WoodElves.WoodElvesQuest == WoodElves.QUEST_STAGE_METELF) && !player.blockingBodyTransformations()
					//	}
					//}
					, {
						name  : "truffle",
						call  : findTruffle,
						chance: 0.35
					}, {
						name  : "chitin",
						call  : findChitin,
						chance: 0.05
					}, {
						name  : "healpill",
						call  : findHPill,
						chance: 0.10
					}, {
						name  : "woods",
						call  : camp.cabinProgress.gatherWoods,
						when  : camp.cabinProgress.canGatherWoods,
						chance: 4
					}, {
						name  : "marble",
						call  : marbleVsImp,
						when  : function ():Boolean {
							//can be triggered one time after Marble has been met, but before the addiction quest starts.
							return player.exploredForest > 0
								   && !player.hasStatusEffect(StatusEffects.MarbleRapeAttempted)
								   && !player.hasStatusEffect(StatusEffects.NoMoreMarble)
								   && player.hasStatusEffect(StatusEffects.Marble)
								   && flags[kFLAGS.MARBLE_WARNING] == 0;
						},
						chance: 0.05
					}, {
						name: "diana",
						when: function():Boolean {
							return flags[kFLAGS.DIANA_FOLLOWER] == 5 && flags[kFLAGS.DIANA_AFFECTION] == 100 && !player.hasStatusEffect(StatusEffects.DianaOff);
						},
						chance: 0.5,
						call: SceneLib.dianaScene.postNameForestEnc
					}, {
						name: "m1 cerberus",
						when: function ():Boolean {
							return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns2) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns2) == 0 && player.hasKeyItem("M1 Cerberus") < 0;
						},
						chance: 50,
						call: partsofM1Cerberus
					}, {
						name: "walk",
						call: forestWalkFn
					}, {
						name  : "essrayle",
						call  : essrayle.essrayleMeetingI,
						when  : function():Boolean {
							return player.gender > 0
								   && (flags[kFLAGS.ESSY_MET_IN_DUNGEON] == 0
									   || flags[kFLAGS.TOLD_MOTHER_TO_RELEASE_ESSY] == 1)
						},
						chance: 0.25
					}, {
						name  : "bigjunk",
						call  : bigJunkForestScene,
						chance: bigJunkChance
					}, {
						name: "celess-unicorn",
						call: function():*{return CelessScene.instance.celessUnicornIntro();},
						when: CelessScene.canMeetUnicorn
					}, {
						name: "celess-armor",
						call: function():*{return CelessScene.instance.celessArmor();},
						when: CelessScene.canGetArmour
					}, {
						name  : "patchouli",
						call  : SceneLib.patchouliScene.meetThePatchouli,
						when  : function():Boolean {
							return (flags[kFLAGS.PATCHOULI_FOLLOWER] < 3 || flags[kFLAGS.PATCHOULI_FOLLOWER] == 4);
						},
						chance: 0.7
					}, {
						name  : "konstantin",
						call  : SceneLib.konstantin.meetKonstantinAtForest,
						when  : function():Boolean {
							return (flags[kFLAGS.KONSTANTIN_FOLLOWER] < 2);
						},
						chance: 0.8
					}, {
						name  : "luna",
						call  : SceneLib.lunaFollower.fullMoonEventResistWinFireHerForest,
						when  : function():Boolean {
							return (flags[kFLAGS.LUNA_FOLLOWER] == 2);
						},
						chance: 2
					});
					/*
					{
						name  : "mimic",
						call  : curry(game.mimicScene.mimicTentacleStart, 3),
						when  : fn.ifLevelMin(3),
						chance: 0.50
					}, {
						name  : "succubus",
						call  : game.succubusScene.encounterSuccubus,
						when  : fn.ifLevelMin(3),
						chance: 0.50
					}, {
						name  : "healpill",
						call  : findHPill,
						chance: 0.10
					}
					*/
			_deepwoodsEncounter = Encounters.group("deepwoods", /*CoC.instance.commonEncounters,*/ {
				name: "shrine",
				when: function():Boolean {
					return flags[kFLAGS.KITSUNE_SHRINE_UNLOCKED] < 1;
				},
				call: kitsuneScene.kitsuneShrine
			}, {
				//Helia monogamy fucks
				name  : "helcommon",
				call  : SceneLib.helScene.helSexualAmbush,
				chance: 0.2,
				when  : SceneLib.helScene.helSexualAmbushCondition
			}, {
				name  : "etna",
				when  : function():Boolean {
					return flags[kFLAGS.ETNA_FOLLOWER] < 1
						   && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2
						   && !player.hasStatusEffect(StatusEffects.EtnaOff)
						   && (player.level >= 20);
				},
				call  : SceneLib.etnaScene.repeatYandereEnc
			}, {
				name  : "electra",
				when  : function():Boolean {
					return flags[kFLAGS.ELECTRA_FOLLOWER] < 2
						   && flags[kFLAGS.ELECTRA_AFFECTION] >= 2
						   && !player.hasStatusEffect(StatusEffects.ElectraOff)
						   && (player.level >= 20);
				},
				chance: 0.5,
				call  : function ():void {
					if (flags[kFLAGS.ELECTRA_AFFECTION] == 100) {
						if (flags[kFLAGS.ELECTRA_FOLLOWER] == 1) SceneLib.electraScene.ElectraRecruitingAgain();
						else SceneLib.electraScene.ElectraRecruiting();
					}
					else SceneLib.electraScene.repeatDeepwoodsEnc();
				}
			}, {
				name: "kitsune",
				when: function():Boolean {
					return flags[kFLAGS.SOUL_SENSE_KITSUNE_MANSION] < 3;
				},
				call: kitsuneScene.enterTheTrickster
			}, {
				name: "celess-nightmare",
				call: nightmareScene.nightmareIntro,
				when: function():Boolean {
					return player.hasStatusEffect(StatusEffects.CanMeetNightmare) && player.statusEffectv1(StatusEffects.CanMeetNightmare) < 1;
				}
			},/*{ // [INTERMOD:8chan]
			 name: "dullahan",
			 call: dullahanScene
			 }, */{
				name: "akbal",
				call: akbalScene.supahAkabalEdition
			}, {
				name  : "Tamani",
				chance: 0.6,
				call  : function ():void {
					if (flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN] == 0
						&& flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16 && rand(5) == 0) {
						tamaniDaughtersScene.encounterTamanisDaughters();
					} else {
						tamaniScene.encounterTamani();
					}
				},
				when  : function ():Boolean {
					return flags[kFLAGS.TAMANI_TIME_OUT] == 0
						   && player.gender > 0
						   && (player.cockTotal() > 0 || player.hasKeyItem("Deluxe Dildo") < 0)
						   && flags[kFLAGS.SOUL_SENSE_TAMANI] < 3;
				}
			}, {
				name  : "Tamani_Daughters",
				call  : encounterTamanisDaughtersFn,
				when  : function ():Boolean {
					return player.gender > 0
						   && player.cockTotal() > 0
						   && flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16
						   && flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] < 3;
				}
			}, {
				name: "faerie",
				when: faerie.isEnabled,
				call: faerie.encounterFaerie
			}, {
				name: "erlking",
				when: function():Boolean {
					return flags[kFLAGS.ERLKING_DISABLED] == 0;
				},
				call: erlkingScene.encounterWildHunt
			}, {
				name: "fera_1",
				when: function():Boolean {
					return isHalloween()
						   && player.findPerk(PerkLib.FerasBoonBreedingBitch) < 0
						   && player.findPerk(PerkLib.FerasBoonAlpha) < 0
						   && date.fullYear > flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE];
				},
				call: Holidays.pumpkinFuckEncounter
			}, {
				name: "fera_2",
				when: function():Boolean {
					return isHalloween()
						   && flags[kFLAGS.FERAS_TRAP_SPRUNG_YEAR] == 0
						   && date.fullYear > flags[kFLAGS.FERAS_GLADE_EXPLORED_YEAR];
				},
				call: Holidays.feraSceneTwoIntroduction
			},{
				name  : "woods",
				call  : camp.cabinProgress.gatherWoods,
				when  : camp.cabinProgress.canGatherWoods,
				chance: 4
			}, {
				name  : "corrGlade",
				call  : corruptedGladeFn,
				when  : function():Boolean {
					return flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] < 100;
				},
				chance: function():Number {
					return (100 - 0.75*(flags[kFLAGS.CORRUPTED_GLADES_DESTROYED]||0))/100;
				}
			}, {
				name: "tentabeast",
				call: tentacleBeastDeepwoodsEncounterFn,
				when: Encounters.fn.ifLevelMin(2)
			}, {
				name: "alraune",
				call: alrauneEncounterFn,
				when: Encounters.fn.ifLevelMin(3)
			}, {
				name: "lilirauneIngrediant",
				call  : lilirauneIngrediantEvent,
				when: function():Boolean {
					return player.isAlraune();
				}
			}, {
				name  : "dark_elf_scout",
				call  : darkelfScene.introDarkELfScout,
				chance: 0.8
			}, {
				name: "aiko",
				call: aikoScene.encounterAiko,
				when: function ():Boolean {
					return (player.level > 35
						&& flags[kFLAGS.AIKO_TIMES_MET] < 4
						&& flags[kFLAGS.AIKO_BALL_RETURNED] != 2);
				}
			}, {
				name: "ted",
				when: function():Boolean {
					return flags[kFLAGS.TED_LVL_UP] >= 1 && flags[kFLAGS.TED_LVL_UP] < 4 && !player.hasStatusEffect(StatusEffects.TedOff) && player.statusEffectv1(StatusEffects.CampSparingNpcsTimers4) < 1;
				},
				call: SceneLib.tedScene.introPostHiddenCave
			},{
				name: "dungeon",
				call: SceneLib.dungeons.enterDeepCave,
				when: SceneLib.dungeons.canFindDeepCave
			}, {
				name: "snippler",
				when: function ():Boolean {
					return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns4) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns4) == 0 && player.hasKeyItem("Snippler") < 0;
				},
				chance: 30,
				call: partsofSnippler
			}, {
				name  : "walk",
				call  : deepwoodsWalkFn,
				chance: 0.01
			});
		}
		public function exploreDeepwoods():void {
			player.addStatusValue(StatusEffects.ExploredDeepwoods,1,1);
			deepwoodsEncounter.execEncounter();
		}

		public function tripOnARoot():void {
			outputText("You trip on an exposed root, scraping yourself somewhat, but otherwise the hour is uneventful.");
			player.takePhysDamage(10);
			doNext(camp.returnToCampUseOneHour);
		}
		public function findTruffle():void {
			outputText("You spot something unusual. Taking a closer look, it's definitely a truffle of some sort.");
			inventory.takeItem(consumables.PIGTRUF, camp.returnToCampUseOneHour);
		}
		public function findHPill():void {
			outputText("You find a pill stamped with the letter 'H' discarded on the ground.");
			inventory.takeItem(consumables.H_PILL, camp.returnToCampUseOneHour);
		}
		public function findChitin():void {
			clearOutput();
			outputText("You find a large piece of insectile carapace obscured in the ferns to your left. It's mostly black with a thin border of bright yellow along the outer edge. There's still a fair portion of yellow fuzz clinging to the chitinous shard. It feels strong and flexible - maybe someone can make something of it.");
			inventory.takeItem(useables.B_CHITN, camp.returnToCampUseOneHour);
		}
		public function forestWalkFn():void {
			if (player.cor < 80) {
				outputText("You enjoy a peaceful walk in the woods, it gives you time to think.");
				dynStats("tou", 0.5, "int", 1);
			} else {
				outputText("As you wander in the forest, you keep");
				switch (player.gender) {
					case Gender.GENDER_NONE:
						outputText("daydreaming about sex-demons with huge sexual attributes, and how you could please them.");
						break;
					case Gender.GENDER_MALE:
						outputText("stroking your half-erect [cocks] as you daydream about fucking all kinds of women, from weeping tight virgins to lustful succubi with gaping, drooling fuck-holes.");
						break;
					case Gender.GENDER_FEMALE:
						outputText("idly toying with your [vagina] as you daydream about getting fucked by all kinds of monstrous cocks, from minotaurs' thick, smelly dongs to demons' towering, bumpy pleasure-rods.");
						break;
					case Gender.GENDER_HERM:
						outputText("stroking alternatively your [cocks] and your [vagina] as you daydream about fucking all kinds of women, from weeping tight virgins to lustful succubi with gaping, drooling fuck-holes, before, or while, getting fucked by various monstrous cocks, from minotaurs' thick, smelly dongs to demons' towering, bumpy pleasure-rods.");
						break;
				}
				dynStats("tou", 0.5, "lib", 0.25, "lus", player.lib / 5);
			}
			doNext(camp.returnToCampUseOneHour);
		}
		public function marbleVsImp():void {
			clearOutput();
			outputText("While you're moving through the trees, you suddenly hear yelling ahead, followed by a crash and a scream as an imp comes flying at high speed through the foliage and impacts a nearby tree.  The small demon slowly slides down the tree before landing at the base, still.  A moment later, a familiar-looking cow-girl steps through the bushes brandishing a huge two-handed hammer with an angry look on her face.");
			outputText(images.showImage("monster-marble"));
			outputText("\n\nShe goes up to the imp, and kicks it once.  Satisfied that the creature isn't moving, she turns around to face you and gives you a smile.  \"<i>Sorry about that, but I prefer to take care of these buggers quickly.  If they get the chance to call on their friends, they can actually become a nuisance.</i>\"  She disappears back into the foliage briefly before reappearing holding two large pile of logs under her arms, with a fire axe and her hammer strapped to her back.  \"<i>I'm gathering firewood for the farm, as you can see; what brings you to the forest, sweetie?</i>\"  You inform her that you're just exploring.");
			outputText("\n\nShe gives a wistful sigh. \"<i>I haven't really explored much since getting to the farm.  Between the jobs Whitney gives me, keeping in practice with my hammer, milking to make sure I don't get too full, cooking, and beauty sleep, I don't get a lot of free time to do much else.</i>\"  She sighs again.  \"<i>Well, I need to get this back, so I'll see you later!</i>\"");
			//end event
			doNext(camp.returnToCampUseOneHour);
		}
		public function exploreForest():void
		{
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			//Increment forest exploration counter.
			player.exploredForest++;
//			forestStory.execute();
			forestEncounter.execEncounter();
			flushOutputTextToGUI();
		}
		//[FOREST]
//[RANDOM SCENE IF CHARACTER HAS AT LEAST ONE COCK LARGER THAN THEIR HEIGHT, AND THE TOTAL COMBINED WIDTH OF ALL THEIR COCKS IS TWELVE INCHES OR GREATER]
		internal function bigJunkForestScene(lake:Boolean = false):void
		{
			clearOutput();
			var x:Number = player.longestCock();

			//PARAGRAPH 1
			outputText("Walking along the ");
			if (lake) outputText("grassy and muddy shores of the lake");
			else outputText("various paths of the forest");
			outputText(", you find yourself increasingly impeded by the bulk of your " + cockDescript(x) + " dragging along the ");
			if (lake) outputText("wet ground behind you.");
			else outputText("earth behind you.");
			if (player.cocks.length == 1) {
				if (lake) outputText("  As it drags through the lakeside mud, the sensation forces you to imagine the velvety folds of a monstrous pussy sliding along the head of your " + Appearance.cockNoun(player.cocks[x].cockType) + ", gently attempting to suck it off.");
				else outputText("  As it drags across the grass, twigs, and exposed tree roots, the sensation forces you to imagine the fingers of a giant hand sliding along the head of your " + Appearance.cockNoun(player.cocks[x].cockType) + ", gently jerking it off.");
			}
			else if (player.cocks.length >= 2) {
				if (lake) outputText("  With all of your [cocks] dragging through the mud, they begin feeling as if the lips of " + num2Text(player.cockTotal()) + " different cunts were slobbering over each one.");
				else outputText("  With all of your [cocks] dragging across the grass, twigs, and exposed tree roots, they begin feeling as if the rough fingers of " + num2Text(player.cockTotal()) + " different monstrous hands were sliding over each shaft, gently jerking them off.");
			}
			outputText("\n\n");

			//PARAGRAPH 2
			//FOR NON-CENTAURS]
			if (!player.isTaur()) {
				outputText("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your [cocks], which forces your torso to the ground.  Normally your erection would merely raise itself skyward, but your genitals have grown too large and heavy for your " + hipDescript() + " to hold them aloft.  Instead, you feel your body forcibly pivoting at the hips until your torso is compelled to rest face down atop your [cocks].");
				//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
				if (player.biggestTitSize() >= 35) {
					if (lake) outputText("  Your " + chestDesc() + " hang lewdly off your torso to rest in the lakeside mud, covering much of the ground to either side of you.  Their immense weight anchors your body, further preventing your torso from lifting itself up.  Mud cakes against their undersides and coats your " + nippleDescript(0) + "s.");
					else outputText("  Your " + chestDesc() + " hang lewdly off your torso to rest on the twings and dirt, covering up much of the ground to either side of you.  Their immense weight anchors your body, further preventing your torso from lifting itself up.  The rough texture of the bark on various tree roots teases your " + nippleDescript(0) + "s mercilessly.");
				}
				//IF CHARACTER HAS A BALLS ADD SENTENCE
				if (player.balls > 0) {
					outputText("  Your " + player.skinTone + " " + sackDescript() + " rests beneath your raised " + buttDescript() + ".  Your [balls] pulse with the need to release their sperm through your [cocks] and ");
					if (lake) outputText("into the waters of the nearby lake.");
					else outputText("onto the fertile soil of the forest.");
				}
				//IF CHARACTER HAS A VAGINA ADD SENTENCE
				if (player.vaginas.length >= 1) {
					outputText("  Your " + vaginaDescript() + " and " + clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + buttDescript() + " above.");
					//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
					if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_DROOLING) {
						outputText("  Juices stream from your womanhood and begin pooling on the dirt and twigs beneath you.  ");
						if (lake) outputText("The drooling fem-spunk only makes the ground more muddy.");
						else outputText("The sticky fem-spunk immediately soaks down into the rich soil.");
					}
				}
			}
			//FOR CENTAURS
			else if (player.isTaur()) {
				outputText("  The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your [cocks], which forces the barrel of your bestial torso to the ground.  Normally your erection would merely hover above the ground in between your legs, but your genitals have grown too large and heavy for your " + hipDescript() + " to hold them aloft.  Instead, you feel your body being forcibly pulled down at your hind legs until your bestial body is resting on top of your [cocks].");
				//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
				if (player.biggestTitSize() >= 35) {
					if (lake) outputText("  Your " + chestDesc() + " pull your human torso forward until it also is forced to face the ground, obscured as it is in boob-flesh.  Your tits rest on the wet earth to either side of you.  Their immense weight anchors you, further preventing any part of your equine body from lifting itself up.  Mud cakes their undersides and coats your " + nippleDescript(0) + "s.");
					else outputText("  Your " + chestDesc() + " pull your human torso forward until it also is forced to face the ground, obscured as it is in boob-flesh.  Your tits rest on the dirt and twigs to either side of you.  Their immense weight anchors you, further preventing any part of your equine body from lifting itself up.  The rough texture of the bark on various tree roots teases your " + nippleDescript(0) + "s mercilessly.");
				}
				//IF CHARACTER HAS A BALLS ADD SENTENCE
				if (player.balls > 0) {
					outputText("  Your " + player.skinTone + sackDescript() + " rests beneath your raised " + buttDescript() + ".  Your [balls] pulse with the need to release their sperm through your [cocks] and ");
					if (lake) outputText("into the waters of the nearby lake.");
					else outputText("onto the fertile soil of the forest floor.");
				}
				//IF CHARACTER HAS A VAGINA ADD SENTENCE
				if (player.vaginas.length >= 1) {
					outputText("  Your " + vaginaDescript() + " and " + clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + buttDescript() + " above.");
					//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
					if (player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_DROOLING) {
						if (lake) outputText("  A leaf falls from a tree and lands on the wet lips of your cunt, its light touch teasing your sensitive skin.  Like a mare or cow in heat, your juices stream from your womanhood and pool in the mud beneath you.  The sloppy fem-spunk only makes the ground more muddy.");
						else outputText("  A leaf falls from a tree and lands on the wet lips of your cunt, its light touch teasing your sensitive skin.  Like a mare or cow in heat, your juices stream from your womanhood and pool in the dirt and twigs beneath you.");
					}
				}
			}
			outputText("\n\n");
			//PARAGRAPH 3
			outputText("You realize you are effectively trapped here by your own body.");
			//CORRUPTION BASED CHARACTER'S VIEW OF SITUATION
			if (player.cor < 33) outputText("  Panic slips into your heart as you realize that if any dangerous predator were to find you in this state, you'd be completely defenseless.  You must find a way to regain your mobility immediately!");
			else if (player.cor < 66) outputText("  You realize that if any dangerous predator were to find you in this state, you'd be completely defenseless!  You must find a way to regain your mobility... yet there is a certain appeal to imagining how pleasurable it would be for a sexual predator to take advantage of your obscene body.");
			else outputText("  Your endowments have rendered you completely helpless should any predators find you.  Somewhere in your heart, you find this prospect almost exhilarating.  The idea of being a helpless fucktoy for a wandering beast is unusually inviting to you.  Were it not for the thought that you might starve to death, you'd be incredibly tempted to remain right where you are.");


			if (lake) {
				//SCENE END = IF CHARACTER HAS FULL WINGS ADD SENTENCE
				if (player.canFly()) outputText("  You extend your wings and flap as hard as you can until at last, you manage to lighten the bulk of your body.  It helps just enough to let you drag your genitals out of the mud and back to camp.  The ordeal takes nearly an hour for you to return and deal with.");
				//Taurs
				else if (player.isTaur()) outputText("  You struggle and work your multiple legs against the wet ground.  Your [feet] have consistent trouble finding footing as the mud fails to provide enough leverage to lift your bulk.  You breath in deeply and lean side to side, trying to find some easier vertical leverage beneath your feet.  Eventually, with a crude crawl, your legs manages to push the bulk of your body onto more solid ground.  With great difficulty, you spend the next hour shuffling your genitals back to camp.");
				//SCENE END = FOR ALL OTHER CHARACTERS
				else outputText("  You struggle and push with your [legs] as hard as you can, but it's no use.  You do the only thing you can and begin stroking your [cocks] with as much vigor as you can muster.  Eventually, your body tenses and a light load of jizz erupts from your body, but the orgasm is truly mild compared to what you need.  You're far too weary from struggling to give yourself the masturbation you truly need, but you continue to try.  Nearly an hour later, " + sMultiCockDesc() + " has softened enough to allow you to stand again, and you make your way back to camp, still dragging your genitals through the mud.");
			}
			else {
				//SCENE END = IF CHARACTER HAS FULL WINGS ADD SENTENCE
				if (player.canFly()) outputText("  You extend your wings and flap as hard as you can, until at last, you manage to lighten the bulk of your body.  It helps just enough to let you drag your genitals out of the forest and back to camp.  The ordeal takes nearly an hour for you to return and deal with.");
				//SCENE END IF CHARACTER HAS CENTAUR BODY
				else if (player.isTaur()) outputText("  You struggle and work your multiple legs against the soft dirt.  Your [feet] have consistent trouble finding footing as the ground fails to provide enough leverage to lift your bulk.  You breath in deeply and lean side to side, until eventually, your feet brace against the various roots of the trees around you.  With a crude crawl, your legs manage to shuffle your body and genitals out of the forest and back to camp.");
				//SCENE END = FOR ALL OTHER CHARACTERS
				else outputText("  You struggle and push with your [legs] as hard as you can, but it's no use.  You do the only thing you can and begin stroking your [cocks] with as much vigor as you can muster.  Eventually, your body tenses and a light load of jizz erupts from your loins, but the orgasm is truly mild compared to what you need.  You're far too weary from struggling to give yourself the masturbation you truly need, but you continue to try.  Nearly an hour later, " + sMultiCockDesc() + " has softened enough to allow you to stand again, and you make your way back to camp, still dragging your genitals across the forest floor.");
			}
			dynStats("lus", 25 + rand(player.cor / 5), "scale", false);
			fatigue(5);
			doNext(camp.returnToCampUseOneHour);
		}
		//Catch a Satyr using the corrupt glade and either leave or have your way with him.
		//Suggested to Fen as the MaleXMale submission.
		//Will be standalone
		private function trappedSatyr():void {
			clearOutput();
			spriteSelect(99);
			outputText("As you wander through the woods, you find yourself straying into yet another corrupt glade.  However, this time the perverse grove isn't unoccupied; loud bleatings and brayings of pleasure split the air, and as you push past a bush covered in dripping, glans-shaped berries, you spot the source.\n\n");
			outputText("A humanoid figure with a set of goat-like horns and legs - a satyr - is currently buried balls-deep in one of the vagina-flowers that scatter the grove, whooping in delight as he hungrily pounds into its ravenously sucking depths.  He stops on occasion to turn and take a slobbering suckle from a nearby breast-like growth; evidently, he doesn't care that he's stuck there until the flower's done with him.");
			if (flags[kFLAGS.CODEX_ENTRY_SATYRS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_SATYRS] = 1;
				outputText("<b>New codex entry unlocked: Satyrs!</b>\n\n")
			}
			//(Player lacks a penis:
			if(!player.hasCock()) {
				outputText("You can't really see any way to take advantage of this scenario, so you simply turn back and leave the way you came.");
				doNext(camp.returnToCampUseOneHour);
			}
			//Player returns to camp)
			//(Player has penis:
			else {
				outputText("You can see his goat tail flitting happily above his tight, squeezable asscheeks, the loincloth discarded beside him failing to obscure his black cherry, ripe for the picking.  Do you take advantage of his distraction and ravage his ass while he's helpless?");
				//[Yes] [No]
				simpleChoices("Ravage", rapeSatyr, "", null, "", null, "", null, "Leave", ignoreSatyr);
			}
		}

		//[=No=]
		private function ignoreSatyr():void {
			clearOutput();
			spriteSelect(99);
			outputText("You shake your head, " +
					((player.cor < 50)
							? "disgusted by the strange thoughts this place seems to put into your mind"
							: "not feeling inclined to rape some satyr butt right now") +
					", and silently leave him to his pleasures.");
			dynStats("lus", 5+player.lib/20);
			doNext(camp.returnToCampUseOneHour);
		}
		//Player returns to camp
		private function rapeSatyr():void {
			clearOutput();
			spriteSelect(99);
			var x:Number = player.biggestCockIndex();
			if (player.cor < 33) {
				outputText("For a moment you hesitate... taking someone from behind without their consent seems wrong... but then again you doubt a satyr would pass on the opportunity if you were in his position.")
			} else if (player.cor < 66) {
				outputText("You smirk; normally you would have given this some thought, but the idea of free booty is all you need to make a decision.")
			} else {
				outputText("You grin; this is not even a choice!  Passing on free anal is just not something a decent person does, is it?");
			}
			outputText("  You silently strip your [armor] and " +
					(player.isNaga() ? "slither" : "sneak") +
					" towards the distracted satyr; stopping a few feet away, you stroke your [cock biggest], urging it to full erection and coaxing a few beads of pre, which you smear along your [cockhead biggest].  With no warning, you lunge forward, grabbing and pulling his hips towards your [cock biggest] and shoving as much of yourself inside his tight ass as you can.\n\n");
			outputText("The satyr lets out a startled yelp, struggling against you, but between his awkward position and the mutant flower ravenously sucking on his sizable cock, he's helpless.\n\n");
			outputText("You slap his butt with a open palm, leaving a clear mark on his taut behind.  He bleats, bucking wildly, but this serves only to slam his butt into your crotch until the flower hungrily sucks him back, sliding him off your prick.  You smile as a wicked idea hits you; you hit his ass again and again, making him buck into your throbbing "+Appearance.cockNoun(player.cocks[x].cockType)+", while the flower keeps pulling him back inside; effectively making the satyr fuck himself.\n\n");
			outputText("Eventually, his bleating and screaming start to annoy you, so you silence him by grabbing at his horns and shoving his head to the side, into one of the breast-like growths nearby.  The satyr unthinkingly latches onto the floral nipple and starts to suckle, quieting him as you hoped.  You're not sure why, but he starts to voluntarily buck back and forth between you and the flower; maybe he's getting into the spirit of things, or maybe the vegetal teat he's pulling on has introduced an aphrodisiac chemical after so many violent attempts to pull out of the kindred flower.\n\n");
			outputText("You resolve not to think about it right now and just enjoy pounding the satyr's ass.  With his bucking you're able to thrust even farther into his tight puckered cherry, ");
			if (player.cockArea(x) >= 100) outputText("stretching it all out of normal proportion and ruining it for whomever might happen to use it next.");
			else outputText("stretching it to fit your [cock biggest] like a condom.");
			outputText("Your groin throbs, " +
					(player.balls>0 ? "your balls churn, " : "") +
					"and you grunt as you feel the first shots of cum flowing along [eachcock], only to pour out into " +
					(player.cockTotal()>1 ? " and onto" : "") +
					" the satyr's abused ass; you continue pounding him even as you climax, causing rivulets of cum to run down his cheeks and legs.\n\n");
			outputText("Still slurping obscenely on the fake breast, the satyr groans and murmurs; you're not sure how much of a role the sap he's swallowing or the cunt-flower on his cock is playing, but it looks like he's actually enjoying himself now.")
			if (player.cumQ() < 250) {
				outputText("As much as you'd love to fill his belly so full of spunk he'd look pregnant, you just can't muster any more, and pull out with a sigh.");
			} else if (player.cumQ() < 1000) {
				outputText("You cum and cum, filling every crevice of his anal passage with warm jism, the slutty goatman doesn't seem to mind this in the least.  When you're finally spent, you pull out with a sigh, and watch as your cum backflows out of his ass to fall on the grass below.");
			} else {
				outputText("You cum and cum, filling every crevice of his anal passage with warm jism, and the slutty goatman doesn't seem to mind this in the least - yet.  You push him to his limits; cum backflows out of his ass and around your spewing prick, but still you dump more and more of your heavy load inside your now-willing cock-sleeve, inflating his belly like a balloon.  When you're finally spent, you pull out with a sigh and look at your handiwork; cum pours out of his ass like an open tap and his belly is absolutely bulging, making him look pregnant.");
			}
			outputText("\n\n");
			outputText("The satyr is too absorbed in his own fucking of the plant-pussy, and his nursing of the tree boob to bewail your absence");
			if (player.cumQ() >= 1000) outputText(", although his eyes have widened perceptibly along with the stretching of his stomach");
			outputText(".\n\n");
			outputText("You can't help but smile inwardly at the helpless goatman's eagerness, and decide to stick around and watch him a little longer.  It's not everyday you see a creature like him at your mercy.  Every once in awhile you egg him on with a fresh slapping of his butt. The satyr grumbles and huffs, but continues to thrust and rut mindlessly into the vegetative pussy feeding on his cock. You don't think it'll be long before he cums...\n\n");
			outputText("As you watch the lewd display, you feel your arousal building and your [cock biggest] growing back into full mast. Figuring you already have a willing slut readily available, you consider using him to relieve yourself once more... What do you do?");
			player.orgasm();
			//[Again][Leave]
			simpleChoices("Again", secondSatyrFuck, "", null, "", null, "", null, "Leave", dontRepeatFuckSatyr);
		}

		//[=Leave=]
		private function dontRepeatFuckSatyr():void {
			clearOutput();
			spriteSelect(99);
			outputText("You've had your fun, and you don't really want to fool around in the forest all day, so you grab your [armor] and leave the rutting satyr behind.");
			doNext(camp.returnToCampUseOneHour);
		}
		//[=Again=]
		private function secondSatyrFuck():void {
			var x:int = player.cockThatFits(monster.analCapacity());
			if(x < 0) x = player.smallestCockIndex();
			clearOutput();
			outputText("There's no harm in using the helpless goat once more... This time though, you decide you'll use his mouth.  With a yank on his horns, you forcefully dislodge him from the breast-plant and force him to his knees, turning his head towards you; he doesn't put up much resistance and when you present your erect shaft to him, he licks his lips in excitement and latches onto your [cock "+(x+1)+"].\n\n");
			outputText("His mouth is exquisite; it feels slippery and warm and his lips are soft while his tongue wriggles about your shaft, trying to embrace and massage it.  He gloms onto your manhood with eager hunger, desperate to ravish you with his mouth.  Quivers of pleasure ripple and shudder through his body as he slobbers and gulps - and no wonder!  From the remnants of sap still in his mouth, you can feel currents of arousal tingling down your cock; if he's been drinking it straight, his mouth must be as sensitive as a cunt from the effects of this stuff.\n\n");
			outputText("Having had your first orgasm mere minutes ago, you don't last long.  Within a few moments of his beginning you flood his mouth with a second load of cum, pulling out to paint his face with the last couple jets.\n\n");
			outputText("With a great, garbled cry, the satyr cums on his own, gurgling through the sap-tinted cum drooling from his mouth as he spews into the waiting opening of his rapacious plant lover.  It swells and bloats as it gorges itself on his thick, stinking seed, stretching its stem until it is almost spherical, finally releasing him to collapse on his knees, free at last of the plant's grip.  He moans and bleats softly, leaking cummy sap from his chin onto his hairy chest, too overwhelmed by the combined fucking of yourself and the flower and too poisoned by whatever aphrodisiac he's been slurping on to move.\n\n");
			outputText("You give your sensitive member a few trembling, almost-painful strokes... maybe you overdid it a bit.  Shrugging, you gather your [armor] and leave the passed-out satyr behind as you go back to your camp.");
			player.orgasm();
			dynStats("lib", 1, "sen", -5);
			doNext(camp.returnToCampUseOneHour);
		}
		private function jojoEncounter():void {
			clearOutput();
			if (JojoScene.monk == 0 && !player.hasStatusEffect(StatusEffects.PureCampJojo)) {
				if (player.cor < 25) {
					JojoScene.monk = 1;
					SceneLib.jojoScene.lowCorruptionJojoEncounter();
				}
				else SceneLib.jojoScene.highCorruptionJojoEncounter();
			} else if (JojoScene.monk == 1 || JojoScene.monk < 0) { //Negative monk value indicates rape is disabled.
				SceneLib.jojoScene.repeatJojoEncounter();
			} else if (JojoScene.monk >= 2) { //Angry/Horny Jojo
				SceneLib.jojoScene.corruptJojoEncounter();
			}
		}
		private function encounterTamanisDaughtersFn():void {
			clearOutput();
			tamaniDaughtersScene.encounterTamanisDaughters();
		}
		private function tentacleBeastEncounterFn():void {
			clearOutput();
			//Oh noes, tentacles!
			//Tentacle avoidance chance due to dangerous plants
			if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
				trace("TENTACLE'S AVOIDED DUE TO BOOK!");
				outputText("Using the knowledge contained in your 'Dangerous Plants' book, you determine a tentacle beast's lair is nearby, do you continue?  If not you could return to camp.\n\n");
				menu();
				addButton(0, "Continue", tentacleBeastScene.encounter);
				addButton(1, "Leave", camp.returnToCampUseOneHour);
			} else {
				tentacleBeastScene.encounter();
			}
		}
		private function alrauneEncounterFn():void {
			clearOutput();
			//Alraune avoidance chance due to dangerous plants
			if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
			//	trace("TENTACLE'S AVOIDED DUE TO BOOK!");		//should it be comented out for alru?
				outputText("You can smell the thick scent of particularly strong pollen in the air. The book mentioned something about this but you don’t recall exactly what. Do you turn back to camp?\n\n");
				menu();
				addButton(0, "Yes", camp.returnToCampUseOneHour);
				addButton(1, "No", alrauneScene.alrauneDeepwoods);
			} else {
				alrauneScene.alrauneDeepwoods();
			}
		}
		private function lilirauneIngrediantEvent():void {
			clearOutput();
			outputText("You spot a weird looking flower on a patch of grass that is ripe with corruption. It looks pretty normal save for it having two pistils instead of just one. You feel oddly drawn to it, deciding to bag it just in case.\n\n");
			inventory.takeItem(consumables.STRFLOW, camp.returnToCampUseOneHour);
		}
		public function partsofM1Cerberus():void {
			clearOutput();
			outputText("As you explore the forest you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the M1 Cerberus in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("M1 Cerberus", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}
		public function partsofSnippler():void {
			clearOutput();
			outputText("As you explore the deepwoods you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Snippler in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Snippler", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}
		public function discoverDeepwoods():void {
			player.createStatusEffect(StatusEffects.ExploredDeepwoods, 0, 0, 0, 0);
			clearOutput();
			outputText("After exploring the forest so many times, you decide to really push it, and plunge deeper and deeper into the woods.  The further you go the darker it gets, but you courageously press on.  The plant-life changes too, and you spot more and more lichens and fungi, many of which are luminescent.  Finally, a wall of tree-trunks as wide as houses blocks your progress.  There is a knot-hole like opening in the center, and a small sign marking it as the entrance to the 'Deepwoods'.  You don't press on for now, but you could easily find your way back to explore the Deepwoods.\n\n");
			outputText("<b>Deepwoods exploration unlocked!</b>");
			doNext(camp.returnToCampUseOneHour);
		}
		public function bigJunkChance():Number {
			var temp:Number = 10 + (player.longestCockLength() - player.tallness) / 24 * 10;
			if (temp > 30) temp = 30;
			if (player.longestCockLength() >= player.tallness && player.totalCockThickness() >= 12) {
				return temp/100;
			} else return 0;
		}
		public function corruptedGladeFn():void {
			if (rand(4) == 0) trappedSatyr();
			else corruptedGlade.intro();
		}
	}
}