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
import classes.Scenes.SceneLib;

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
			deepwoodsStory.display("strings/walk");
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
		private var forestStory:BoundStory;
		private var deepwoodsStory:BoundStory;
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
					}, {
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
							return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns2) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns2) == 0 && player.statusEffectv2(StatusEffects.TelAdreTripxi) == 1;
						},
						chance: 30,
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
					return flags[kFLAGS.TED_LVL_UP] >= 1 && flags[kFLAGS.TED_LVL_UP] < 4 && player.statusEffectv1(StatusEffects.CampSparingNpcsTimers4) < 1;
				},
				call: SceneLib.tedScene.introPostHiddenCave
			},{
				name: "dungeon",
				call: SceneLib.dungeons.enterDeepCave,
				when: SceneLib.dungeons.canFindDeepCave
			}, {
				name: "snippler",
				when: function ():Boolean {
					return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns4) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns4) == 0 && player.statusEffectv2(StatusEffects.TelAdreTripxi) == 1;
				},
				chance: 30,
				call: partsofSnippler
			}, {
				name  : "walk",
				call  : deepwoodsWalkFn,
				chance: 0.01
			});
			// what we do here: create a Story (ZoneStmt) and register it in game.rootStory
			// so it will be accessible from external files
			forestStory = ZoneStmt.wrap(_forestEncounter,game.rootStory).bind(game.context);
			deepwoodsStory = ZoneStmt.wrap(_deepwoodsEncounter,game.rootStory).bind(game.context);
		}
		public function exploreDeepwoods():void {
			player.addStatusValue(StatusEffects.ExploredDeepwoods,1,1);
			deepwoodsStory.execute();
		}

		public function tripOnARoot():void {
			forestStory.display("strings/trip");
			player.takePhysDamage(10);
			doNext(camp.returnToCampUseOneHour);
		}
		public function findTruffle():void {
			forestStory.display("strings/truffle");
			inventory.takeItem(consumables.PIGTRUF, camp.returnToCampUseOneHour);
		}
		public function findHPill():void {
			forestStory.display("strings/hpill");
			inventory.takeItem(consumables.H_PILL, camp.returnToCampUseOneHour);
		}
		public function findChitin():void {
			clearOutput();
			forestStory.display("strings/chitin");
			inventory.takeItem(useables.B_CHITN, camp.returnToCampUseOneHour);
		}
		public function forestWalkFn():void {
			forestStory.display("strings/walk");
			doNext(camp.returnToCampUseOneHour);
		}
		public function marbleVsImp():void {
			clearOutput();
			forestStory.display("string/marble");
			//end event
			doNext(camp.returnToCampUseOneHour);
		}
		public function exploreForest():void
		{
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			//Increment forest exploration counter.
			player.exploredForest++;
			forestStory.execute();
//			forestEncounter.execEncounter();
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
			forestStory.display("strings/glade-satyr/0-intro");
			if (flags[kFLAGS.CODEX_ENTRY_SATYRS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_SATYRS] = 1;
				outputText("<b>New codex entry unlocked: Satyrs!</b>\n\n")
			}
			//(Player lacks a penis:
			if(!player.hasCock()) {
				forestStory.display("strings/glade-satyr/1-nocock");
				doNext(camp.returnToCampUseOneHour);
			}
			//Player returns to camp)
			//(Player has penis:
			else {
				forestStory.display("strings/glade-satyr/1-prompt");
				//[Yes] [No]
				simpleChoices("Ravage", rapeSatyr, "", null, "", null, "", null, "Leave", ignoreSatyr);
			}
		}

		//[=No=]
		private function ignoreSatyr():void {
			clearOutput();
			spriteSelect(99);
			forestStory.display("strings/glade-satyr/2-leave");
			dynStats("lus", 5+player.lib/20);
			doNext(camp.returnToCampUseOneHour);
		}
		//Player returns to camp
		private function rapeSatyr():void {
			clearOutput();
			spriteSelect(99);
			var x:Number = player.biggestCockIndex();
			forestStory.display("strings/glade-satyr/2-ravage",{$x:x});
			player.orgasm();
			//[Again][Leave]
			simpleChoices("Again", secondSatyrFuck, "", null, "", null, "", null, "Leave", dontRepeatFuckSatyr);
		}

		//[=Leave=]
		private function dontRepeatFuckSatyr():void {
			clearOutput();
			spriteSelect(99);
			forestStory.display("strings/glade-satyr/3-leave");
			doNext(camp.returnToCampUseOneHour);
		}
		//[=Again=]
		private function secondSatyrFuck():void {
			var x:int = player.cockThatFits(monster.analCapacity());
			if(x < 0) x = player.smallestCockIndex();
			clearOutput();
			forestStory.display("strings/glade-satyr/3-again",{$x:x});
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
		public function partsofM1Cerberus():void {
			clearOutput();
			outputText("As you explore the forest you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the M1 Cerberus in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns2, 1, 1);
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("M1 Cerberus", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}
		public function partsofSnippler():void {
			clearOutput();
			outputText("As you explore the deepwoods you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Snippler in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns4, 1, 1);
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Snippler", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}
		public function discoverDeepwoods():void {
			player.createStatusEffect(StatusEffects.ExploredDeepwoods, 0, 0, 0, 0);
			clearOutput();
			forestStory.display("strings/deepwoods");
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
