/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Forest.*;
import classes.Scenes.Monsters.LightElfScene;
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
		public var lightelfScene:LightElfScene = new LightElfScene();
		public var aikoScene:AikoScene = new AikoScene();
		public var nightmareScene:NightmareScene = new NightmareScene();
		// public var dullahanScene:DullahanScene = new DullahanScene(); // [INTERMOD:8chan]

		public function Forest() {
			onGameInit(init);
		}
		public const areaLevelOuter:int = 0;
		public const discoverLevelOuter:int = 0;
		public function isDiscoveredOuter():Boolean {
			return SceneLib.exploration.counters.forestOuter > 0;
		}
		public function canDiscoverOuter():Boolean {
			return !isDiscoveredOuter() && adjustedPlayerLevel() >= discoverLevelOuter && flags[kFLAGS.ALVINA_FOLLOWER] >= 1;
		}
		public function timesExploredOuter():int {
			return SceneLib.exploration.counters.forestOuter;
		}
		public function discoverOuter():void {
			clearOutput();
			outputText("You walk for quite some time, roaming the hard-packed and pink-tinged earth of the demon-realm.  Rust-red rocks speckle the wasteland, as barren and lifeless as anywhere else you've been.  A cool breeze suddenly brushes against your face, as if gracing you with its presence.  You turn towards it and are confronted by the lush foliage of a very old-looking forest.  You smile as the plants look fairly familiar and non-threatening.  Unbidden, you remember your decision to test the properties of this place, and think of your campsite as you walk forward.  Reality seems to shift and blur, making you dizzy, but after a few minutes you're back, and sure you'll be able to return to the forest with similar speed.\n\n<b>You've discovered the Forest!</b>");
			SceneLib.exploration.counters.forestOuter = 1;
			endEncounter(60);
		}
		
		
		public const areaLevelInner:int = 3;
		public function isDiscoveredInner():Boolean {
			return /*SceneLib.exploration.counters.forestInner > 0 */ SceneLib.exploration.counters.forestOuter > 0;
		}
		public function canDiscoverInner():Boolean {
			return !isDiscoveredInner() && adjustedPlayerLevel() >= areaLevelInner;
		}
		public function timesExploredInner():int {
			return SceneLib.exploration.counters.forestInner;
		}
		
		public const areaLevelDeepwoods:int = 7;
		public function isDiscoveredDeepwoods():Boolean {
			return SceneLib.exploration.counters.deepwoods > 0;
		}
		public function canDiscoverDeepwoods():Boolean {
			return !isDiscoveredDeepwoods() && adjustedPlayerLevel() >= areaLevelDeepwoods;
		}
		public function timesExploredDeepwoods():int {
			return SceneLib.exploration.counters.deepwoods;
		}

		private function deepwoodsWalkFn():void {
			clearOutput();
			outputText("You enjoy a peaceful walk in the deepwoods.  It gives you time to think over the recent, disturbing events.");
			dynStats("tou", 0.5, "int", 1);
			endEncounter();
		}
		public function tentacleBeastDeepwoodsEncounterFn():void {
			if (player.gender > 0) flags[kFLAGS.TENTABEAST_CENT_GLESS_MET] = 0;
			//Tentacle avoidance chance due to dangerous plants
			if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
				clearOutput();
				outputText("Using the knowledge contained in your 'Dangerous Plants' book, you determine a tentacle beast's lair is nearby, do you continue?  If not you could return to camp.\n\n");
				menu();
				addButton(0, "Continue", tentacleBeastScene.encounter);
				addButton(1, "Leave", explorer.done);
			} else {
				tentacleBeastScene.encounter();
			}
		}
		private var _forestOutskirtsEncounter:GroupEncounter = null;
		private var _forestInnerEncounter:GroupEncounter     = null;
		private var _deepwoodsEncounter:GroupEncounter       = null;
		public function get forestOutskirtsEncounter():GroupEncounter {
			return _forestOutskirtsEncounter;
		}
		public function get forestInnerEncounter():GroupEncounter {
			return _forestInnerEncounter;
		}
		public function get deepwoodsEncounter():GroupEncounter {
			return _deepwoodsEncounter;
		}
		private function init():void {
            const fn:FnHelpers = Encounters.fn;
			_forestOutskirtsEncounter = Encounters.group("outskirtsforest",
					SceneLib.exploration.commonEncounters.withChanceFactor(0.1),
					SceneLib.exploration.angelEncounters.wrap(fn.ifLevelMin(5), [0.05]),
					{
						//Helia monogamy fucks
						name  : "helcommon",
						label : "Helia",
						kind  : 'npc',
						unique: true,
						night : false,
						call  : SceneLib.helScene.helSexualAmbush,
						chance: forestChance2,
						when  : SceneLib.helScene.helSexualAmbushCondition
					}, {
						name  : "Tamani",
						kind  : 'npc',
						unique: true,
						night : false,
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
								   && (player.hasCock() || player.hasKeyItem("Deluxe Dildo") < 0);
						}
					}, {
						name  : "Tamani_Daughters",
						label : "Tamain Daughters",
						kind  : 'npc',
						unique: true,
						night : false,
						call  : encounterTamanisDaughtersFn,
						when  : function ():Boolean {
							return player.gender > 0
								&& player.hasCock()
								&& flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16;
						}
					}, corruptedGlade.encounter, {
						name: "trip",
						label:"Root",
						kind: 'trap',
						call: tripOnARoot
					}, {
						name  : "beegirl",
						label : "Bee-girl",
						kind  : 'monster',
						night : false,
						call  : beeGirlScene.beeEncounter,
						chance: 0.20
					}, {
						name  : "werewolfFemale",
						label : "Werewolf (F)",
						kind : 'monster',
						day : false,
						when: fn.ifLevelMin(12),
						call  : SceneLib.werewolfFemaleScene.introWerewolfFemale,
						chance: 0.50
					}, {
						name  : "healingherb",
						label : "HealingHerb",
						kind : 'item',
						call  : findHealingherb,
						chance: 0.20
					}, {
						name  : "snakebane",
						label : "Snakebane",
						kind : 'item',
						call  : findSnakebaneflower,
						chance: 0.20
					}, {
						name  : "ginseng",
						label : "Ginseng",
						kind : 'item',
						call  : findGinseng,
						chance: 0.10
					}, {
						name  : "truffle",
						label : "Truffle",
						kind : 'item',
						call  : findTruffle,
						chance: 0.20
					}, {
						name  : "chitin",
						label : "Chitin",
						kind : 'item',
						call  : findChitin,
						chance: 0.20
					}, {
						name  : "healpill",
						label : "Heal Pill",
						kind : 'item',
						call  : findHPill,
						chance: 0.20
					}, {
						name  : "woods",
						label : "Woods",
						kind : 'item',
						call  : camp.cabinProgress.gatherWoods,
						when  : camp.cabinProgress.canGatherWoods,
						chance: 4
					}, {
						name  : "marble",
						label : "Marble",
						kind : 'npc',
						unique:true,
						night : false,
						call  : marbleVsImp,
						when  : function ():Boolean {
							//can be triggered one time after Marble has been met, but before the addiction quest starts.
							return !player.hasStatusEffect(StatusEffects.MarbleRapeAttempted)
								   && !player.hasStatusEffect(StatusEffects.NoMoreMarble)
								   && player.hasStatusEffect(StatusEffects.Marble)
								   && flags[kFLAGS.MARBLE_WARNING] == 0;
						},
						chance: forestChance3
					}, {
						name: "walk",
						call: forestWalkFn,
						kind:'walk'
					}, {
						name  : "essrayle",
						label : "Essrayle",
						kind:'npc',
						unique:true,
						reenter:true,
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
						kind  : 'event',
						call  : bigJunkForestScene,
						chance: bigJunkChance
					}, {
						name  : "konstantin",
						label : "Konstantin",
						kind  : 'npc',
						unique: true,
						call  : SceneLib.konstantin.meetKonstantinAtForest,
						when  : function():Boolean {
							return (flags[kFLAGS.KONSTANTIN_FOLLOWER] < 2 && !player.hasStatusEffect(StatusEffects.KonstantinOff));
						},
						chance: forestChance4
					}, {
						name  : "luna",
						label : "Luna",
						kind  : 'npc',
						unique: true,
						call  : SceneLib.lunaFollower.fullMoonEventResistWinFireHerForest,
						when  : function():Boolean {
							return (flags[kFLAGS.LUNA_FOLLOWER] == 2);
						},
						chance: forestChance4
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
			_forestInnerEncounter = Encounters.group("forest",
					SceneLib.exploration.commonEncounters.withChanceFactor(0.1),
					{
						//Helia monogamy fucks
						name  : "helcommon",
						label : "Helia",
						kind  : 'npc',
						unique: true,
						night : false,
						call  : SceneLib.helScene.helSexualAmbush,
						chance: forestChance2,
						when  : SceneLib.helScene.helSexualAmbushCondition
					}, {
						name  : "deepwoods",
						label : "New Area",
						kind  : 'event',
						unique: true,
						call  : discoverDeepwoods,
						when  : function ():Boolean {
							return ((player.level + combat.playerLevelAdjustment()) >= 7) && !isDiscoveredDeepwoods();
						},
						chance: Encounters.ALWAYS
					}, {
						name: "gunparts",
						label : "Gun Parts",
						kind  : 'event',
						unique: true,
						when: function ():Boolean {
							return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns4) && player.statusEffectv3(StatusEffects.TelAdreTripxiGuns4) == 0 && player.hasKeyItem("Alakablam") < 0
						},
						call: partsofAlakablam
					},  {
						name  : "Tamani",
						kind  : 'npc',
						unique: true,
						night : false,
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
								   && (player.hasCock() || player.hasKeyItem("Deluxe Dildo") < 0);
						}
					}, {
						name  : "Tamani_Daughters",
						label : "Tamain Daughters",
						kind  : 'npc',
						unique: true,
						night : false,
						call  : encounterTamanisDaughtersFn,
						when  : function ():Boolean {
							return player.gender > 0
								&& player.hasCock()
								&& flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16;
						}
					}, {
						name  : "Jojo",
						label : function():String {
							return silly() ? "JoJo" : "Jojo"
						},
						kind  : 'npc',
						unique: true,
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
									&& (player.cor > 25 || JojoScene.monk > 0)) ? (2.4 * player.npcChanceToEncounter()) : (2 * player.npcChanceToEncounter());
						},
						call  : jojoEncounter
					}, {
						name  : "tentaBeast",
						label : "Tentacle Beast",
						kind  : 'monster',
						call  : tentacleBeastEncounterFn,
						when  : fn.ifLevelMin(3),
						chance: 0.80
					}, corruptedGlade.encounter, {
						name  : "beegirl",
						label : "Bee-girl",
						kind  : 'monster',
						night : false,
						call  : beeGirlScene.beeEncounter,
						chance: 1.0
					}, {
						name  : "WoodElf",
						label : "Wood Elfs",
						kind  : 'event',
						unique: true,
						night : false,
						call  : SceneLib.woodElves.findElves,
						chance: 0.5,
						when  : function ():Boolean {
							return WoodElves.WoodElvesQuest == WoodElves.QUEST_STAGE_NOT_STARTED && player.level >= 10 && !player.blockingBodyTransformations()
						}
					}, {
						name  : "WoodElfRematch",
						label : "Wood Elfs",
						kind  : 'event',
						unique: true,
						night : false,
						call  : SceneLib.woodElves.findElvesRematch,
						chance: 0.75,
						when  : function ():Boolean {
							return WoodElves.WoodElvesQuest == WoodElves.QUEST_STAGE_METELFSANDEVENBEATSTHEM && player.level >= 10 && !player.blockingBodyTransformations()
						}
					}, {
						name  : "chitin",
						label : "Chitin",
						kind : 'item',
						call  : findChitin,
						chance: 0.10
					}, {
						name  : "healpill",
						label : "Heal Pill",
						kind : 'item',
						call  : findHPill,
						chance: 0.10
					}, {
						name  : "woods",
						label : "Woods",
						kind : 'item',
						call  : camp.cabinProgress.gatherWoods,
						when  : camp.cabinProgress.canGatherWoods,
						chance: 4
					}, {
						name  : "marble",
						label : "Marble",
						kind  : 'npc',
						unique: true,
						night : false,
						call  : marbleVsImp,
						when  : function ():Boolean {
							//can be triggered one time after Marble has been met, but before the addiction quest starts.
							//can be triggered one time after Marble has been met, but before the addiction quest starts.
							return !player.hasStatusEffect(StatusEffects.MarbleRapeAttempted)
								   && !player.hasStatusEffect(StatusEffects.NoMoreMarble)
								   && player.hasStatusEffect(StatusEffects.Marble)
								   && flags[kFLAGS.MARBLE_WARNING] == 0;
						},
						chance: forestChance3
					}, {
						name: "nadia",
						label : "Nadia",
						kind  : 'npc',
						unique: true,
						night : false,
						when: function():Boolean {
							return flags[kFLAGS.NADIA_FOLLOWER] < 6 && !(flags[kFLAGS.NADIA_FOLLOWER] != 3 && flags[kFLAGS.NADIA_LVL_UP] >= 8) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1 && !player.hasStatusEffect(StatusEffects.NadiaOff);
						},
						chance: forestChance,
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
						chance: forestChance,
						call: SceneLib.nadiaScene.postNameEnc
					}, {
						name: "walk",
						call: forestWalkFn,
						kind:'walk'
					}, {
						name  : "essrayle",
						label : "Essrayle",
						kind:'npc',
						unique:true,
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
						kind  : 'event',
						call  : bigJunkForestScene,
						chance: bigJunkChance
					}, {
						name: "celess-unicorn",
						label : "Celess Sr",
						kind  : 'event',
						unique: true,
						call: function():*{return CelessScene.instance.celessUnicornIntro(); },
						chance: forestChance,
						when: CelessScene.canMeetUnicorn
					}, {
						name: "celess-armor",
						label : "Taur Armor",
						kind  : 'event',
						unique: true,
						call: function():*{return CelessScene.instance.celessArmor();},
						when: CelessScene.canGetArmour
					}, {
						name  : "patchouli",
						label : "Patchouli",
						kind  : 'npc',
						unique: true,
						call  : SceneLib.patchouliScene.meetThePatchouli,
						when  : function():Boolean {
							return (flags[kFLAGS.PATCHOULI_FOLLOWER] < 3 || flags[kFLAGS.PATCHOULI_FOLLOWER] == 4);
						},
						chance: forestChance4
					}, {
						name  : "luna",
						label : "Luna",
						kind  : 'event',
						unique: true,
						call  : SceneLib.lunaFollower.fullMoonEventResistWinFireHerForest,
						when  : function():Boolean {
							return (flags[kFLAGS.LUNA_FOLLOWER] == 2);
						},
						chance: forestChance4
					}, {
						name: "mimic",
						label : "Mimic",
						kind : 'monster',
						when: fn.ifLevelMin(3),
						// TODO @aimozg use area tags instead
						call: curry(SceneLib.mimicScene.mimicTentacleStart, 3),
						chance: 0.25
					}, {
						name  : "succubus",
						label : "Ivory Succubus",
						kind : 'monster',
						call  : SceneLib.ivorySuccubusScene.encounterSuccubus,
						when  : fn.ifLevelMin(3),
						chance: 0.25
					}, {
						name  : "werewolfFemale",
						label : "Werewolf (F)",
						kind : 'monster',
						day : false,
						when: fn.ifLevelMin(12),
						call  : SceneLib.werewolfFemaleScene.introWerewolfFemale,
						chance: 0.50
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
			_deepwoodsEncounter = Encounters.group("deepwoods", /*CoC.instance.commonEncounters,*/ {
				name: "shrine",
				label : "Shrine",
				kind  : 'event',
				unique: true,
				when: function():Boolean {
					return flags[kFLAGS.KITSUNE_SHRINE_UNLOCKED] < 1;
				},
				call: kitsuneScene.kitsuneShrine
			}, {
				name: "ayane",
				label : "Ayane",
				kind  : 'npc',
				unique: true,
				when: function():Boolean {
					return flags[kFLAGS.AYANE_FOLLOWER] < 2 && player.level >= 20 && !player.isRace(Races.KITSUNE) && !player.isRace(Races.KITSHOO);
				},
				chance: forestChance,
				call: SceneLib.ayaneFollower.randomEncounter
			}, {
				//Helia monogamy fucks
				name  : "helcommon",
				label : "Helia",
				kind  : 'npc',
				unique: true,
				night : false,
				call  : SceneLib.helScene.helSexualAmbush,
				chance: forestChance2,
				when  : SceneLib.helScene.helSexualAmbushCondition
			}, {
				name  : "etna",
				label : "Etna",
				kind  : 'npc',
				unique: true,
				when  : function():Boolean {
					return (flags[kFLAGS.ETNA_FOLLOWER] < 1 || EtnaFollower.EtnaInfidelity == 2)
						   && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2
						   && !player.hasStatusEffect(StatusEffects.EtnaOff)
						   && (player.level >= 20);
				},
				call  : SceneLib.etnaScene.repeatYandereEnc
			}, {
				name  : "electra",
				label : "Electra",
				kind  : 'npc',
				unique: true,
				night : false,
				when  : function():Boolean {
					return flags[kFLAGS.ELECTRA_FOLLOWER] < 2
						   && flags[kFLAGS.ELECTRA_AFFECTION] >= 2
						   && !player.hasStatusEffect(StatusEffects.ElectraOff)
						   && (player.level >= 20);
				},
				chance: forestChance,
				call  : function ():void {
					if (flags[kFLAGS.ELECTRA_AFFECTION] == 100) {
						if (flags[kFLAGS.ELECTRA_FOLLOWER] == 1) SceneLib.electraScene.ElectraRecruitingAgain();
						else SceneLib.electraScene.ElectraRecruiting();
					}
					else SceneLib.electraScene.repeatDeepwoodsEnc();
				}
			}, {
				name: "kitsune",
				label : "Kitsune",
				kind  : 'monster',
				call: kitsuneScene.enterTheTrickster
			}, {
				name: "celess-nightmare",
				label : "Nightmare",
				kind  : 'monster',
				unique: true,
				night : false,
				call: nightmareScene.nightmareIntro,
				chance: forestChance,
				when: function():Boolean {
					return player.hasStatusEffect(StatusEffects.CanMeetNightmare) && player.statusEffectv1(StatusEffects.CanMeetNightmare) < 1 && !player.isPregnant();
				}
			}, {
				name: "akbal",
				label : "Akbal",
				kind  : 'monster',
				unique: true,
				night : false,
				call: akbalScene.supahAkabalEdition
			}, {
				name  : "Tamani",
				kind  : 'npc',
				unique: true,
				night : false,
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
						   && (player.hasCock() || player.hasKeyItem("Deluxe Dildo") < 0);
				}
			}, {
				name  : "Tamani_Daughters",
				label : "Tamain Daughters",
				kind  : 'npc',
				unique: true,
				night : false,
				call  : encounterTamanisDaughtersFn,
				when  : function ():Boolean {
					return player.gender > 0
						   && player.hasCock()
						   && flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16;
				}
			}, {
				name	: "Tyrania_and_Flitzy",
				label : "Tyrania & Flitzy",
				kind  : 'event',
				unique: true,
				night : false,
				chance	: 0.6,
				call	: SceneLib.tyrantia.TyraniaAndFlitzyScene,
				when	: function():Boolean {
					return TyrantiaFollower.TyrantiaFollowerStage > 0;
				}
			}, {
				name: "faerie",
				label : "Faerie",
				kind  : 'event',
				when: faerie.isEnabled,
				call: faerie.encounterFaerie
			}, {
				name: "faerie dragon",
				label : "Faerie Dragon",
				kind  : 'event',
				unique: true,
				call: faerie.encounterFaerieDragon,
				when: function():Boolean {
					return (player.wings.type == Wings.DRACONIC_SMALL
							|| player.wings.type == Wings.DRACONIC_LARGE
							|| player.wings.type == Wings.DRACONIC_HUGE)
							&& player.wings.type != Wings.FEY_DRAGON && player.isRaceCached(Races.DRAGON);
				}
			}, {
				name: "erlking",
				label : "Erlking",
				kind  : 'event',
				unique: true,
				when: function():Boolean {
					return flags[kFLAGS.ERLKING_DISABLED] == 0;
				},
				call: erlkingScene.encounterWildHunt
			}, {
				name: "fera_1",
				label : "Fera",
				kind  : 'event',
				unique: true,
				when: function():Boolean {
					return isHalloween()
						   && (!player.hasPerk(PerkLib.FerasBoonBreedingBitch) || (player.hasPerk(PerkLib.FerasBoonBreedingBitch) && player.perkv4(PerkLib.FerasBoonBreedingBitch) > 0))
						   && (!player.hasPerk(PerkLib.FerasBoonAlpha) || (player.hasPerk(PerkLib.FerasBoonAlpha) && player.perkv4(PerkLib.FerasBoonAlpha) > 0))
						   && date.fullYear > flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE];
				},
				call: SceneLib.holidays.pumpkinFuckEncounter
			}, {
				name: "fera_2",
				label : "Fera",
				kind  : 'event',
				unique: true,
				when: function():Boolean {
					return isHalloween()
						   && flags[kFLAGS.FERAS_TRAP_SPRUNG_YEAR] == 0
						   && (date.fullYear > flags[kFLAGS.FERAS_GLADE_EXPLORED_YEAR] || flags[kFLAGS.ITS_EVERY_DAY] >= 1);
				},
				call: SceneLib.holidays.feraSceneTwoIntroduction
			},{
				name  : "woods",
				label : "Woods",
				kind : 'item',
				call  : camp.cabinProgress.gatherWoods,
				when  : camp.cabinProgress.canGatherWoods,
				chance: 4
			}, corruptedGlade.encounter, {
				name: "tentabeast",
				label: "Tentacle Beast",
				kind: "monster",
				call: tentacleBeastDeepwoodsEncounterFn
			}, {
				name: "alraune",
				label : "Alraune",
				kind  : 'monster',
				night : false,
				call: alrauneEncounterFn
			}, {
				name: "lilirauneIngrediant",
				label : "Strange Flower",
				kind  : 'event',
				unique: true,
				call  : lilirauneIngrediantEvent,
				when: function():Boolean {
					return player.isAlraune();
				}
			}, {
				name  : "light_elf_scout",
				label : "Light Elf Scout",
				kind  : 'monster',
				call  : lightelfScene.introLightELfScout,
				chance: 0.8
			}, {
				name: "aiko",
				label : "Aiko",
				kind  : 'npc',
				unique: true,
				call: aikoScene.encounterAiko,
				when: function ():Boolean {
					return (player.level > 35
						&& flags[kFLAGS.AIKO_TIMES_MET] < 4
						&& flags[kFLAGS.AIKO_BALL_RETURNED] != 2);
				}
			}, {
				name: "ted",
				label : "Dragon-Boy",
				kind  : 'npc',
				unique: true,
				call: SceneLib.tedScene.introPostHiddenCave,
				when: SceneLib.tedScene.canEncounterTed
			},{
				name: "dungeon",
				label : "Deep Cave",
				kind  : 'event',
				unique: true,
				call: SceneLib.dungeons.deepcave.enterDungeon,
				when: SceneLib.dungeons.canFindDeepCave
			}, {
				name  : "walk",
				call  : deepwoodsWalkFn,
				kind:'walk',
				chance: 0.01
			}, {
				name  : "werewolfFemale",
				label : "Werewolf (F)",
				kind : 'monster',
				day : false,
				call  : SceneLib.werewolfFemaleScene.introWerewolfFemale,
				chance: 0.50
			}, {
				name  : "healingherb",
				label : "HealingHerb",
				kind : 'item',
				call  : findHealingherb,
				chance: 0.20
			}, {
				name  : "snakebane",
				label : "Snakebane",
				kind : 'item',
				call  : findSnakebaneflower,
				chance: 0.20
			}, {
				name  : "ginseng",
				label : "Ginseng",
				kind : 'item',
				call  : findGinseng,
				chance: 0.10
			}, {
				name  : "truffle",
				label : "Truffle",
				kind : 'item',
				call  : findTruffle,
				chance: 0.20
			}, {
				name  : "chitin",
				label : "Chitin",
				kind : 'item',
				call  : findChitin,
				chance: 0.20
			}, {
				name  : "healpill",
				label : "Heal Pill",
				kind : 'item',
				call  : findHPill,
				chance: 0.20
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

		public function forestChance():Number {
			var temp:Number = 0.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}
		public function forestChance2():Number {
			var temp:Number = 0.2;
			temp *= player.npcChanceToEncounter();
			return temp;
		}
		public function forestChance3():Number {
			var temp:Number = 0.05;
			temp *= player.npcChanceToEncounter();
			return temp;
		}
		public function forestChance4():Number {
			var temp:Number = 1.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}

		public function tripOnARoot():void {
			if (explorer.inEncounter && explorer.getCurrentEntry().isFullyRevealed) {
				outputText("You carefully step over an exposed root.");
			} else {
				outputText("You trip on an exposed root, scraping yourself somewhat, but otherwise the hour is uneventful.");
				player.takePhysDamage(10);
			}
			endEncounter();
		}
		public function findHealingherb():void {
			outputText("You spot something unusual. Taking a closer look, it's definitely a healing herb.");
			inventory.takeItem(consumables.HEALHERB, explorer.done);
		}
		public function findSnakebaneflower():void {
			outputText("You spot something unusual. Taking a closer look, it's definitely a snakebane flower.");
			inventory.takeItem(consumables.SNAKEBANE, explorer.done);
		}
		public function findGinseng():void {
			outputText("You spot something unusual. Taking a closer look, it's definitely a ginseng.");
			inventory.takeItem(consumables.GINSENG, explorer.done);
		}
		public function findTruffle():void {
			outputText("You spot something unusual. Taking a closer look, it's definitely a truffle of some sort.");
			inventory.takeItem(consumables.PIGTRUF, explorer.done);
		}
		public function findHPill():void {
			outputText("You find a pill stamped with the letter 'H' discarded on the ground.");
			inventory.takeItem(consumables.H_PILL, explorer.done);
		}
		public function findChitin():void {
			clearOutput();
			outputText("You find a large piece of insectile carapace obscured in the ferns to your left. It's mostly black with a thin border of bright yellow along the outer edge. There's still a fair portion of yellow fuzz clinging to the chitinous shard. It feels strong and flexible - maybe someone can make something of it.");
			inventory.takeItem(useables.B_CHITN, explorer.done);
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
			endEncounter();
		}
		public function marbleVsImp():void {
			clearOutput();
			outputText("While you're moving through the trees, you suddenly hear yelling ahead, followed by a crash and a scream as an imp comes flying at high speed through the foliage and impacts a nearby tree.  The small demon slowly slides down the tree before landing at the base, still.  A moment later, a familiar-looking cow-girl steps through the bushes brandishing a huge two-handed hammer with an angry look on her face.");
			outputText(images.showImage("monster-marble"));
			outputText("\n\nShe goes up to the imp and kicks it once.  Satisfied that the creature isn't moving, she turns around to face you and gives you a smile.  \"<i>Sorry about that, but I prefer to take care of these buggers quickly.  If they get the chance to call on their friends, they can actually become a nuisance.</i>\"  She disappears back into the foliage briefly before reappearing holding two large bundles of logs under her arms, with a fire axe and her hammer strapped to her back.  \"<i>I'm gathering firewood for the farm, as you can see; what brings you to the forest, sweetie?</i>\"  You inform her that you're just exploring.");
			outputText("\n\nShe gives a wistful sigh. \"<i>I haven't really explored much since getting to the farm.  Between the jobs Whitney gives me, keeping in practice with my hammer, milking to make sure I don't get too full, cooking, and beauty sleep, I don't get a lot of free time to do much else.</i>\"  She sighs again.  \"<i>Well, I need to get this back, so I'll see you later!</i>\"");
			//end event
			endEncounter();
		}
		public function exploreForestOutskirts():void
		{
			explorer.prepareArea(forestOutskirtsEncounter);
			explorer.setTags("forest","forestOutskirts","plants");
			explorer.prompt = "You explore the forest outskirts.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.forestOuter++;
			}
			explorer.leave.hint("Leave the forest outskirts");
			explorer.skillBasedReveal(areaLevelOuter, timesExploredOuter());
			explorer.doExplore();
		}
		public function exploreInnerForest():void
		{
			explorer.prepareArea(forestInnerEncounter);
			explorer.setTags("forest","forestInner","plants");
			explorer.prompt = "You explore the forest.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.forestInner++;
			}
			explorer.leave.hint("Leave the forest");
			explorer.skillBasedReveal(areaLevelInner, timesExploredInner());
			explorer.doExplore();
		}
		public function exploreDeepwoods():void {
			explorer.prepareArea(deepwoodsEncounter);
			explorer.setTags("forest","deepwoods","plants");
			explorer.prompt = "You explore the deepwoods.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.deepwoods++;
			}
			explorer.leave.hint("Leave the deepwoods");
			explorer.skillBasedReveal(areaLevelDeepwoods, timesExploredDeepwoods());
			explorer.doExplore();
		}
		
		//[FOREST]
//[RANDOM SCENE IF CHARACTER HAS AT LEAST ONE COCK LARGER THAN THEIR HEIGHT, AND THE TOTAL COMBINED WIDTH OF ALL THEIR COCKS IS TWELVE INCHES OR GREATER]
		public function bigJunkForestScene(lake:Boolean = false):void
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
			endEncounter();
		}

		public function partsofAlakablam():void {
			clearOutput();
			outputText("As you explore the inner forest you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Alakablam in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Alakablam", 0, 0, 0, 0);
			endEncounter();
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
				addButton(1, "Leave", explorer.done);
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
				addButton(0, "Yes", explorer.done);
				addButton(1, "No", alrauneScene.alrauneDeepwoods);
			} else {
				alrauneScene.alrauneDeepwoods();
			}
		}
		private function lilirauneIngrediantEvent():void {
			clearOutput();
			outputText("You spot a weird looking flower on a patch of grass that is ripe with corruption. It looks pretty normal save for it having two pistils instead of just one. You feel oddly drawn to it, deciding to bag it just in case.\n\n");
			inventory.takeItem(consumables.STRFLOW, explorer.done);
		}
		public function discoverDeepwoods():void {
			SceneLib.exploration.counters.deepwoods = 1;
			clearOutput();
			outputText("After exploring the forest so many times, you decide to really push it, and plunge deeper and deeper into the woods.  The further you go the darker it gets, but you courageously press on.  The plant-life changes too, and you spot more and more lichens and fungi, many of which are luminescent.  Finally, a wall of tree-trunks as wide as houses blocks your progress.  There is a knot-hole like opening in the center, and a small sign marking it as the entrance to the 'Deepwoods'.  You don't press on for now, but you could easily find your way back to explore the Deepwoods.\n\n");
			outputText("<b>Deepwoods exploration unlocked!</b>");
			endEncounter(60);
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
