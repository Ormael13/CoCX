﻿/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Forest.*;
import classes.Scenes.Monsters.DarkElfScene;
import classes.Scenes.NPCs.AikoScene;
import classes.Scenes.NPCs.CelessScene;
import classes.Scenes.NPCs.EtnaFollower;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.Places.WoodElves;
import classes.Scenes.SceneLib;
import classes.lists.Gender;

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
			if (player.gender > 0) flags[kFLAGS.TENTABEAST_CENT_GLESS_MET] = 0;
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
		private var _forestOutskirtsEncounter:GroupEncounter = null;
		private var _forestEncounter:GroupEncounter = null;
		private var _deepwoodsEncounter:GroupEncounter = null;
		public function get forestOutskirtsEncounter():GroupEncounter {
			return _forestOutskirtsEncounter;
		}
		public function get forestEncounter():GroupEncounter {
			return _forestEncounter;
		}
		public function get deepwoodsEncounter():GroupEncounter {
			return _deepwoodsEncounter;
		}
		private function init():void {
            const fn:FnHelpers = Encounters.fn;
			_forestOutskirtsEncounter = Encounters.group("outskirtsforest", {
						//General Golems, Goblin, Angels and Imp Encounters
						name: "common",
						chance: 0.8,
						call: function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							if (rand(4) == 0) SceneLib.exploration.genericAngelsEncounters();
							else SceneLib.exploration.genericGolGobImpEncounters();
						}
					}, {
						//Helia monogamy fucks
						name  : "helcommon",
						night : false,
						call  : SceneLib.helScene.helSexualAmbush,
						chance: 0.2,
						when  : SceneLib.helScene.helSexualAmbushCondition
					}, {
						name  : "Tamani",
						night : false,
						chance: 0.6,
						call  : function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							if (flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN] == 0
								&& flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16 && flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] < 3) {
								tamaniDaughtersScene.encounterTamanisDaughters();
							} else {
								tamaniScene.encounterTamani();
							}
						},
						when  : function ():Boolean {
							return flags[kFLAGS.TAMANI_TIME_OUT] == 0
								   && player.gender > 0
								   && (player.hasCock() || player.hasKeyItem("Deluxe Dildo") < 0)
								   && flags[kFLAGS.SOUL_SENSE_TAMANI] < 3;
						}
					}, {
						name  : "Tamani_Daughters",
						night : false,
						call  : function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							encounterTamanisDaughtersFn();
						},
						when  : function ():Boolean {
							return player.gender > 0
								&& player.hasCock()
								&& flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16
								&& flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] < 3;
						}
					}, {
						name  : "corrGlade",
						call  : corruptedGlade.encounter,
						when  : function():Boolean {
							return flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] < 100;
						},
						chance: function():Number {
							return (100 - 0.75*(flags[kFLAGS.CORRUPTED_GLADES_DESTROYED]||0))/100;
						}
					}, {
						name: "trip",
						call: tripOnARoot
					}, {
						name  : "beegirl",
						night : false,
						call  : function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							beeGirlScene.beeEncounter();
						},
						chance: 0.20
					}, {
						name  : "werewolfFemale",
						day : false,
						call  : function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							SceneLib.werewolfFemaleScene.introWerewolfFemale();
						},
						chance: 0.50
					}, {
						name  : "truffle",
						call  : findTruffle,
						chance: 0.20
					}, {
						name  : "chitin",
						call  : findChitin,
						chance: 0.20
					}, {
						name  : "healpill",
						call  : findHPill,
						chance: 0.20
					}, {
						name  : "woods",
						call  : camp.cabinProgress.gatherWoods,
						when  : camp.cabinProgress.canGatherWoods,
						chance: 4
					}, {
						name  : "marble",
						night : false,
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
						name: "walk",
						call: forestWalkFn
					}, {
						name  : "essrayle",
						night : false,
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
						name  : "konstantin",
						call  : SceneLib.konstantin.meetKonstantinAtForest,
						when  : function():Boolean {
							return (flags[kFLAGS.KONSTANTIN_FOLLOWER] < 2);
						},
						chance: 1.5
					}, {
						name  : "luna",
						call  : SceneLib.lunaFollower.fullMoonEventResistWinFireHerForest,
						when  : function():Boolean {
							return (flags[kFLAGS.LUNA_FOLLOWER] == 2);
						},
						chance: 2
					});
			_forestEncounter = Encounters.group("forest", {
						//General Golems, Goblin and Imp Encounters
						name: "common",
						chance: 0.4,
						call: function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							SceneLib.exploration.genericGolGobImpEncounters();
						}
					}, {
						//Helia monogamy fucks
						name  : "helcommon",
						night : false,
						call  : function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							SceneLib.helScene.helSexualAmbush();
						},
						chance: 0.2,
						when  : SceneLib.helScene.helSexualAmbushCondition
					}, {
						name  : "deepwoods",
						call  : discoverDeepwoods,
						when  : function ():Boolean {
							return ((player.level + combat.playerLevelAdjustment()) >= 7) && !deepwoodsDiscovered();
						},
						chance: Encounters.ALWAYS
					},  {
						name  : "Tamani",
						night : false,
						chance: 0.6,
						call  : function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							if (flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN] == 0
								&& flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16 && flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] < 3) {
								tamaniDaughtersScene.encounterTamanisDaughters();
							} else {
								tamaniScene.encounterTamani();
							}
						},
						when  : function ():Boolean {
							return flags[kFLAGS.TAMANI_TIME_OUT] == 0
								   && player.gender > 0
								   && (player.hasCock() || player.hasKeyItem("Deluxe Dildo") < 0)
								   && flags[kFLAGS.SOUL_SENSE_TAMANI] < 3;
						}
					}, {
						name  : "Tamani_Daughters",
						night : false,
						call  : function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							encounterTamanisDaughtersFn();
						},
						when  : function ():Boolean {
							return player.gender > 0
								&& player.hasCock()
								&& flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16
								&& flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] < 3;
						}
					}, {
						name  : "Jojo",
						night : false,
						when  : function ():Boolean {
							return (!player.hasStatusEffect(StatusEffects.PureCampJojo)
								   && !camp.campCorruptJojo()
								   && flags[kFLAGS.JOJO_DEAD_OR_GONE] <= 0
								   && (JojoScene.monk < 2 || rand(2) == 0))
								   || SceneLib.alvinaFollower.JojoDevilPurification == 1;
						},
						mods  : [fn.ifLevelMin(4)],
						chance: function ():Number {
							//Extra chance of Jojo encounter.
							return (player.hasPerk(PerkLib.PiercedFurrite)
									&& rand(5) == 0
									&& (player.cor > 25 || JojoScene.monk > 0)) ? 2.4 : 2;
						},
						call  : jojoEncounter
					}, {
						name  : "tentaBeast",
						call  : function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							tentacleBeastEncounterFn();
						},
						when  : fn.ifLevelMin(3),
						chance: 0.80
					}, {
						name  : "corrGlade",
						call  : corruptedGlade.encounter,
						when  : function():Boolean {
							return flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] < 100;
						},
						chance: function():Number {
							return (100 - 0.75*(flags[kFLAGS.CORRUPTED_GLADES_DESTROYED]||0))/100;
						}
					}, {
						name  : "beegirl",
						night : false,
						call  : function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							beeGirlScene.beeEncounter();
						},
						chance: 1.0
					}, {
						name  : "WoodElf",
						night : false,
						call  : function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							SceneLib.woodElves.findElves();
						},
						chance: 0.5,
						when  : function ():Boolean {
							return WoodElves.WoodElvesQuest == WoodElves.QUEST_STAGE_NOT_STARTED && player.level >= 10 && !player.blockingBodyTransformations()
						}
					}, {
						name  : "WoodElfRematch",
						night : false,
						call  : function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							SceneLib.woodElves.findElvesRematch();
						},
						chance: 0.75,
						when  : function ():Boolean {
							return WoodElves.WoodElvesQuest == WoodElves.QUEST_STAGE_METELFSANDEVENBEATSTHEM && player.level >= 10 && !player.blockingBodyTransformations()
						}
					}, {
						name  : "chitin",
						call  : findChitin,
						chance: 0.10
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
						night : false,
						call  : marbleVsImp,
						when  : function ():Boolean {
							//can be triggered one time after Marble has been met, but before the addiction quest starts.
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
						night : false,
						when: function():Boolean {
							return flags[kFLAGS.DIANA_FOLLOWER] < 6 && !(flags[kFLAGS.DIANA_FOLLOWER] != 3 && flags[kFLAGS.DIANA_LVL_UP] >= 8) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1 && !player.hasStatusEffect(StatusEffects.DianaOff);
						},
						chance: 0.5,
						call: function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							SceneLib.dianaScene.repeatEnc();
						}
					}, {
						name: "dianaName",
						night : false,
						when: function():Boolean {
							return ((flags[kFLAGS.DIANA_FOLLOWER] < 3 || flags[kFLAGS.DIANA_FOLLOWER] == 5) && flags[kFLAGS.DIANA_LVL_UP] >= 8) && !player.hasStatusEffect(StatusEffects.DianaOff) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1;
						},
						chance: 0.5,
						call: function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							SceneLib.dianaScene.postNameEnc();
						}
					}, {
						name: "walk",
						call: forestWalkFn
					}, {
						name  : "essrayle",
						night : false,
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
						name  : "luna",
						call  : SceneLib.lunaFollower.fullMoonEventResistWinFireHerForest,
						when  : function():Boolean {
							return (flags[kFLAGS.LUNA_FOLLOWER] == 2);
						},
						chance: 2
					}, {
						name: "mimic",
						when: fn.ifLevelMin(3),
						call: function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							SceneLib.mimicScene.mimicTentacleStart(3);
						},
						chance: 0.25
					}, {
						name  : "succubus",
						call  : SceneLib.ivorySuccubusScene.encounterSuccubus,
						when  : fn.ifLevelMin(3),
						chance: 0.25
					}, {
						name  : "werewolfFemale",
						day : false,
						call  : function ():void {
							player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
							SceneLib.werewolfFemaleScene.introWerewolfFemale();
						},
						chance: 0.50
					});
			_deepwoodsEncounter = Encounters.group("deepwoods", /*CoC.instance.commonEncounters,*/ {
				name: "shrine",
				when: function():Boolean {
					return flags[kFLAGS.KITSUNE_SHRINE_UNLOCKED] < 1;
				},
				call: kitsuneScene.kitsuneShrine
			}, {
				name: "ayane",
				when: function():Boolean {
					return flags[kFLAGS.AYANE_FOLLOWER] < 2 && player.level >= 20 && !player.isRace(Races.KITSUNE) && !player.isRace(Races.KITSHOO);
				},
				call: SceneLib.ayaneFollower.randomEncounter
			}, {
				//Helia monogamy fucks
				name  : "helcommon",
				night : false,
				call  : function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.helScene.helSexualAmbush();
				},
				chance: 0.2,
				when  : SceneLib.helScene.helSexualAmbushCondition
			}, {
				name  : "etna",
				when  : function():Boolean {
					return (flags[kFLAGS.ETNA_FOLLOWER] < 1 || EtnaFollower.EtnaInfidelity == 2)
						   && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2
						   && !player.hasStatusEffect(StatusEffects.EtnaOff)
						   && (player.level >= 20);
				},
				call  : function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.etnaScene.repeatYandereEnc();
				}
			}, {
				name  : "electra",
				night : false,
				when  : function():Boolean {
					return flags[kFLAGS.ELECTRA_FOLLOWER] < 2
						   && flags[kFLAGS.ELECTRA_AFFECTION] >= 2
						   && !player.hasStatusEffect(StatusEffects.ElectraOff)
						   && (player.level >= 20);
				},
				chance: 0.5,
				call  : function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
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
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					kitsuneScene.enterTheTrickster();
				}
			}, {
				name: "celess-nightmare",
				night : false,
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					nightmareScene.nightmareIntro();
				},
				when: function():Boolean {
					return player.hasStatusEffect(StatusEffects.CanMeetNightmare) && player.statusEffectv1(StatusEffects.CanMeetNightmare) < 1 && player.pregnancyIncubation == 0;
				}
			},/*{ // [INTERMOD:8chan]
			 name: "dullahan",
			 call: dullahanScene
			 }, */{
				name: "akbal",
				night : false,
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					akbalScene.supahAkabalEdition();
				}
			}, {
				name  : "Tamani",
				night : false,
				chance: 0.6,
				call  : function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					if (flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN] == 0
						&& flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16 && flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] < 3 && rand(5) == 0) {
						tamaniDaughtersScene.encounterTamanisDaughters();
					} else {
						tamaniScene.encounterTamani();
					}
				},
				when  : function ():Boolean {
					return flags[kFLAGS.TAMANI_TIME_OUT] == 0
						   && player.gender > 0
						   && (player.hasCock() || player.hasKeyItem("Deluxe Dildo") < 0)
						   && flags[kFLAGS.SOUL_SENSE_TAMANI] < 3;
				}
			}, {
				name  : "Tamani_Daughters",
				night : false,
				call  : function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					encounterTamanisDaughtersFn();
				},
				when  : function ():Boolean {
					return player.gender > 0
						   && player.hasCock()
						   && flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16
						   && flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] < 3;
				}
			}, {
				name	: "Tyrania_and_Flitzy",
				night : false,
				chance	: 0.6,
				call	: SceneLib.tyrantia.TyraniaAndFlitzyScene,
				when	: function():Boolean {
					return TyrantiaFollower.TyrantiaFollowerStage > 0;
				}
			}, {
				name: "faerie",
				when: faerie.isEnabled,
				call: faerie.encounterFaerie
			}, {
				name: "faerie dragon",
				call: faerie.encounterFaerieDragon,
				when: function():Boolean {
					return (player.wings.type == Wings.DRACONIC_SMALL
							|| player.wings.type == Wings.DRACONIC_LARGE
							|| player.wings.type == Wings.DRACONIC_HUGE)
							&& player.wings.type != Wings.FEY_DRAGON && player.isRaceCached(Races.DRAGON);
				}
			}, {
				name: "erlking",
				when: function():Boolean {
					return flags[kFLAGS.ERLKING_DISABLED] == 0;
				},
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					erlkingScene.encounterWildHunt();
				}
			}, {
				name: "fera_1",
				when: function():Boolean {
					return isHalloween()
						   && (!player.hasPerk(PerkLib.FerasBoonBreedingBitch) || (player.hasPerk(PerkLib.FerasBoonBreedingBitch) && player.perkv4(PerkLib.FerasBoonBreedingBitch) > 0))
						   && (!player.hasPerk(PerkLib.FerasBoonAlpha) || (player.hasPerk(PerkLib.FerasBoonAlpha) && player.perkv4(PerkLib.FerasBoonAlpha) > 0))
						   && date.fullYear > flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE];
				},
				call: SceneLib.holidays.pumpkinFuckEncounter
			}, {
				name: "fera_2",
				when: function():Boolean {
					return isHalloween()
						   && flags[kFLAGS.FERAS_TRAP_SPRUNG_YEAR] == 0
						   && (date.fullYear > flags[kFLAGS.FERAS_GLADE_EXPLORED_YEAR] || flags[kFLAGS.ITS_EVERY_DAY] >= 1);
				},
				call: SceneLib.holidays.feraSceneTwoIntroduction
			},{
				name  : "woods",
				call  : camp.cabinProgress.gatherWoods,
				when  : camp.cabinProgress.canGatherWoods,
				chance: 4
			}, {
				name  : "corrGlade",
				call  : corruptedGlade.encounter,
				when  : function():Boolean {
					return flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] < 100;
				},
				chance: function():Number {
					return (100 - 0.75*(flags[kFLAGS.CORRUPTED_GLADES_DESTROYED]||0))/100;
				}
			}, {
				name: "tentabeast",
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					tentacleBeastDeepwoodsEncounterFn();
				}
			}, {
				name: "alraune",
				night : false,
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					alrauneEncounterFn();
				}
			}, {
				name: "lilirauneIngrediant",
				call  : lilirauneIngrediantEvent,
				when: function():Boolean {
					return player.isAlraune();
				}
			}, {
				name  : "dark_elf_scout",
				call  : function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					darkelfScene.introDarkELfScout();
				},
				chance: 0.8
			}, {
				name: "aiko",
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					aikoScene.encounterAiko();
				},
				when: function ():Boolean {
					return (player.level > 35
						&& flags[kFLAGS.AIKO_TIMES_MET] < 4
						&& flags[kFLAGS.AIKO_BALL_RETURNED] != 2);
				}
			}, {
				name: "ted",
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.tedScene.introPostHiddenCave();
				},
				when: SceneLib.tedScene.canEncounterTed
			},{
				name: "dungeon",
				call: SceneLib.dungeons.deepcave.enterDungeon,
				when: SceneLib.dungeons.canFindDeepCave
			}, {
				name  : "walk",
				call  : deepwoodsWalkFn,
				chance: 0.01
			}, {
				name  : "werewolfFemale",
				day : false,
				call  : function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.werewolfFemaleScene.introWerewolfFemale();
				},
				chance: 0.50
			}, {
				name  : "truffle",
				call  : findTruffle,
				chance: 0.20
			}, {
				name  : "chitin",
				call  : findChitin,
				chance: 0.20
			}, {
				name  : "healpill",
				call  : findHPill,
				chance: 0.20
			});
		}

		public function exploreDeepwoods():void {
			clearOutput();
			player.addStatusValue(StatusEffects.ExploredDeepwoods, 1, 1);
			//player.createStatusEffect(StatusEffects.GnomeHomeBuff,1,0,0,0);
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
		public function exploreForestOutskirts():void
		{
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			//Increment forest exploration counter.
			player.exploredForest++;
//			forestStory.execute();
			forestOutskirtsEncounter.execEncounter();
			flushOutputTextToGUI();
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
				if (player.hasBalls()) {
					outputText("  Your [color] " + sackDescript() + " rests beneath your raised [butt].  Your [balls] pulse with the need to release their sperm through your [cocks] and ");
					if (lake) outputText("into the waters of the nearby lake.");
					else outputText("onto the fertile soil of the forest.");
				}
				//IF CHARACTER HAS A VAGINA ADD SENTENCE
				if (player.vaginas.length >= 1) {
					outputText("  Your " + vaginaDescript() + " and " + clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the [butt] above.");
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
				if (player.hasBalls()) {
					outputText("  Your " + player.bodyColor + sackDescript() + " rests beneath your raised [butt].  Your [balls] pulse with the need to release their sperm through your [cocks] and ");
					if (lake) outputText("into the waters of the nearby lake.");
					else outputText("onto the fertile soil of the forest floor.");
				}
				//IF CHARACTER HAS A VAGINA ADD SENTENCE
				if (player.vaginas.length >= 1) {
					outputText("  Your " + vaginaDescript() + " and " + clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the [butt] above.");
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

		private function jojoEncounter():void {
			clearOutput();
			if (SceneLib.alvinaFollower.JojoDevilPurification == 1) {
				SceneLib.jojoScene.jojoForestPurifyMeFromDevilry();
			} else if (JojoScene.monk == JojoScene.JOJO_NOT_MET && !player.hasStatusEffect(StatusEffects.PureCampJojo)) {
				if (player.cor < 25) SceneLib.jojoScene.lowCorruptionJojoEncounter();
				else SceneLib.jojoScene.highCorruptionJojoEncounter();
			} else if (JojoScene.monk == JojoScene.JOJO_MET || JojoScene.monk < 0) { //Negative monk value indicates rape is disabled.
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
	}
}
