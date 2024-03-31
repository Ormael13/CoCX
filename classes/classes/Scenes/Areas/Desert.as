/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.API.SimpleEncounter;
import classes.Scenes.Areas.Desert.*;
import classes.Scenes.Camp.CampStatsAndResources;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class Desert extends BaseContent
	{
		public var antsScene:AntsScene = new AntsScene();
		public var anubisScene:AnubisScene = new AnubisScene();
		public var nagaScene:NagaScene = new NagaScene();
		public var gorgonScene:GorgonScene = new GorgonScene();
		public var oasis:Oasis = new Oasis();
		public var sandTrapScene:SandTrapScene = new SandTrapScene();
		public var sandWormScene:SandWormScene = new SandWormScene();
		public var sandWitchScene:SandWitchScene = new SandWitchScene();
		public var wanderer:Wanderer = new Wanderer();
		//public var gorgonScene:GorgonScene = new GorgonScene();przenieść do deep desert potem
		
		public const discoverLevelOuter:int = 0;
		public const areaLevelOuter:int = 1;
		public function isDiscoveredOuter():Boolean {
			return SceneLib.exploration.counters.desertOuter > 0;
		}
		public function canDiscoverOuter():Boolean {
			return !isDiscoveredOuter() && adjustedPlayerLevel() >= discoverLevelOuter && SceneLib.lake.isDiscovered();
		}
		public function timesExploredOuter():int {
			return SceneLib.exploration.counters.desertOuter;
		}
		public function discoverOuter():void {
			clearOutput();
			outputText("You stumble as the ground shifts a bit underneath you.  Groaning in frustration, you straighten up and discover the rough feeling of sand ");
			if (player.lowerBody == LowerBody.HOOFED) outputText("in your hooves");
			else if (player.lowerBody == LowerBody.DOG) outputText("in your paws");
			else if (player.isNaga()) outputText("in your scales");
			else outputText("inside your footwear, between your toes");
			outputText(".\n\n<b>You've discovered the Desert (Outer)!</b>");
			SceneLib.exploration.counters.desertOuter = 1;
			endEncounter(60);
		}
		
		
		public const areaLevelInner:int = 10;
		public function isDiscoveredInner():Boolean {
			return SceneLib.exploration.counters.desertInner > 0;
		}
		public function canDiscoverInner():Boolean {
			return !isDiscoveredInner() && adjustedPlayerLevel() >= areaLevelInner;
		}
		public function timesExploredInner():int {
			return SceneLib.exploration.counters.desertInner;
		}
		
		public function Desert()
		{
			onGameInit(init);
		}
		
		private var _desertOuterEncounter:GroupEncounter = null;
		public function get desertOuterEncounter():GroupEncounter {
			return _desertOuterEncounter;
		}
		private var _desertInnerEncounter:GroupEncounter = null;
		public function get desertInnerEncounter():GroupEncounter {
			return _desertInnerEncounter;
		}
		private function init():void {
            const fn:FnHelpers    = Encounters.fn;
			_desertOuterEncounter = Encounters.group("desert",
				{
					name: "discoverinnerdesert",
					label : "New Area",
					kind  : 'place',
					unique: true,
					when: canDiscoverInner,
					chance: 30,
					call: discoverInnerDesert
				}, {
					name: "walk",
					call: walkingDesertStatBoost,
					label:'Walk',
					kind:'walk'
				}, {
					name: "naga",
					label : "Naga",
					kind  : 'monster',
					when: fn.ifLevelMin(4),
					chance: nagaChance,
					call: nagaScene.nagaEncounter
				}, {/*
					name  : "sandtrap",
					label : "Sand Trap",
					kind  : 'monster',
					chance: 0.5,
					when  : fn.ifLevelMin(2),
					call  : sandTrapScene.encounterASandTarp
				}, {*/
					name: "sandwitch",
					label : "Sand Witch",
					kind  : 'monster',
					night : false,
					when: function ():Boolean {
						return player.level >= 3 && flags[kFLAGS.SAND_WITCH_LEAVE_ME_ALONE] == 0;
					},
					call: sandWitchScene.encounter
				}, {
					name: "cumwitch",
					label : "Cum Witch",
					kind  : 'monster',
					night : false,
					when: function ():Boolean {
						return flags[kFLAGS.CUM_WITCHES_FIGHTABLE] > 0;
					},
					call: SceneLib.dungeons.desertcave.fightCumWitch
				}, {
					name  : "wanderer",
					label : "Wanderer",
					kind  : 'event',
					night : false,
					chance: 0.2,
					call  : wanderer.wandererRouter
				}, {
					name: "sw_preg",
					label : "Sand Witch (E)",
					kind  : 'event',
					unique: true,
					night : false,
					when: function ():Boolean {
						return sandWitchScene.pregnancy.event == 2;
					},
					call: sandWitchPregnancyEvent
				}, {
					name  : "ants",
					label : "Ant Colony",
					kind  : 'event',
					unique: true,
					night : false,
					when  : function ():Boolean {
						return player.level >= 9 && flags[kFLAGS.ANT_WAIFU] == 0 && flags[kFLAGS.ANTS_PC_FAILED_PHYLLA] == 0 && flags[kFLAGS.ANT_COLONY_KEPT_HIDDEN] == 0;
					},
					chance: phyllaAnthillChance,
					call  : antsScene.antColonyEncounter
				}, {
					name: "dungeon",
					label : "Desert Cave",
					kind  : 'place',
					unique: true,
					when: function ():Boolean {
						return (player.level >= 4 || timesExploredOuter() > 45)
							   && flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] == 0;
					},
					call: SceneLib.dungeons.desertcave.enterDungeon
				}, {
					name: "wstaff",
					label : "W. Staff",
					kind  : 'item',
					unique: true,
					when: function ():Boolean {
						return flags[kFLAGS.FOUND_WIZARD_STAFF] == 0 && player.inte > 50;
					},
					call: wstaffEncounter
				}, {
					name: "desert eagle",
					label : "Gun Parts",
					kind  : 'item',
					unique: true,
					when: function ():Boolean {
						return player.level >= 6 && player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns1) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns1) == 0 && player.hasKeyItem("Desert Eagle") < 0;
					},
					chance: 30,
					call: partsofDesertEagle
				}, {
					name: "nails",
					label : "Nails",
					kind  : 'item',
					unique: true,
					when: function ():Boolean {
						return player.hasKeyItem("Carpenter's Toolbox") >= 0 && player.keyItemvX("Carpenter's Toolbox", 1) < 200;
					},
					call: nailsEncounter
				}, {
					name: "chest",
					label : "Chest",
					kind  : 'item',
					unique: true,
					when: function ():Boolean {
						return player.hasKeyItem("Camp - Chest") < 0
					},
					call: chestEncounter
				}, {
					name  : "bigjunk",
					kind  : 'event',
					chance: function ():Boolean
					{
						var chance:Number = 10 + (player.longestCockLength() - player.tallness) / 24 * 10;
						if ( chance > 30){chance = 30; }
						return (chance > rand(100) && player.longestCockLength() >= player.tallness && player.totalCockThickness() >= 12)
					},
					call  : SceneLib.exploration.bigJunkDesertScene
				}, {
					name  : "exgartuan",
					label : "Fountain",
					kind  : 'event',
					unique: true,
					chance: 0.25,
					call  : SceneLib.exgartuan.fountainEncounter
				}, {
					name  : "mirage",
					kind  : 'event',
					night : false,
					chance: 0.25,
					when  : fn.ifLevelMin(2),
					call  : mirageDesert
				}, {
					name  : "oasis",
					label : "Oasis",
					kind  : 'event',
					night : false,
					chance: 0.25,
					when  : fn.ifLevelMin(2),
					call  : oasis.oasisEncounter
				}, {
					name: "etna",
					label : "Etna",
					kind  : 'npc',
					unique: true,
					chance: desertChance,
					when: function ():Boolean
					{
						return (flags[kFLAGS.ETNA_FOLLOWER] < 1 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && !player.hasStatusEffect(StatusEffects.EtnaOff) && (player.level >= 20));
					},
					call: SceneLib.etnaScene.repeatYandereEnc
				}, {
					//Helia monogamy fucks
					name  : "helcommon",
					label : "Helia",
					kind  : 'npc',
					unique: true,
					night : false,
					call  : SceneLib.helScene.helSexualAmbush,
					chance: desertChance,
					when  : SceneLib.helScene.helSexualAmbushCondition
				}, {
					name: "mimic",
					label : "Mimic",
					kind : 'monster',
					chance: 0.25,
					when: fn.ifLevelMin(3),
					call: curry(SceneLib.mimicScene.mimicTentacleStart, 1)
				}, {
					name  : "desertloot",
					label : "Cake",
					kind  : 'item',
					chance: 0.3,
					call  : findDesertLoot1
				}, {
					name  : "desertloot2",
					label : "Berry",
					kind  : 'item',
					chance: 0.3,
					call  : findDesertLoot3
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
			_desertInnerEncounter = Encounters.group("inner desert",
				{
					name: "gorgon",
					label : "Gorgon",
					kind  : 'monster',
					when: fn.ifLevelMin(31),
					call: gorgonScene.gorgonEncounter
				}, {
					name  : "werefoxEFemale",
					label : "E.Werefox (F)",
					kind : 'monster',
					day : false,
					when: fn.ifLevelMin(43),
					call  : SceneLib.werefoxScene.werefoxOuterDeepDesertEncounter,
					chance: 0.50
				}, {
					name: "sandworm",
					label : "Sandworm",
					kind  : 'monster',
					night: false,
					call: sandWormScene.SandWormEncounter
				}, {
					name: "anubis",
					label : "Anubis",
					kind  : 'monster',
					night: false,
					call: anubisScene.anubisEncounter
				}, {
					name  : "werefoxFemale",
					label : "Werefox (F)",
					kind : 'monster',
					day : false,
					call  : SceneLib.werefoxScene.werefoxInnerDesertEncounter,
					chance: 0.50
				}, {
					name: "etna",
					label : "Etna",
					kind  : 'npc',
					unique: true,
					chance: desertChance,
					when: function ():Boolean
					{
						return (flags[kFLAGS.ETNA_FOLLOWER] < 1 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && !player.hasStatusEffect(StatusEffects.EtnaOff) && (player.level >= 20));
					},
					call: SceneLib.etnaScene.repeatYandereEnc
				}, {
					//Helia monogamy fucks
					name  : "helcommon",
					label : "Helia",
					kind  : 'npc',
					unique: true,
					night : false,
					call  : SceneLib.helScene.helSexualAmbush,
					chance: desertChance,
					when  : SceneLib.helScene.helSexualAmbushCondition
				},{
					name: "electra",
					label : "Electra",
					kind  : 'npc',
					unique: true,
					night : false,
					when: function():Boolean {
						return flags[kFLAGS.ELECTRA_FOLLOWER] < 2 && flags[kFLAGS.ELECTRA_AFFECTION] >= 2 && !player.hasStatusEffect(StatusEffects.ElectraOff) && (player.level >= 20);
					},
					chance: desertChance,
					call: function ():void {
						if (flags[kFLAGS.ELECTRA_AFFECTION] == 100) {
							if (flags[kFLAGS.ELECTRA_FOLLOWER] == 1) SceneLib.electraScene.ElectraRecruitingAgain();
							else SceneLib.electraScene.ElectraRecruiting();
						}
						else SceneLib.electraScene.repeatDesertEnc();
					}
				}, {/*
					name: "lactoblasters",
					when: function ():Boolean {
						return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns5) && player.statusEffectv3(StatusEffects.TelAdreTripxiGuns2) == 0 && player.hasKeyItem("Lactoblasters") < 0;
					},
					chance: 30,
					call: partsofLactoBlasters
				}, {*/
					name: "ted",
					label : "Dragon-Boy",
					kind  : 'npc',
					unique: true,
					call: SceneLib.tedScene.introPostHiddenCave,
					when: SceneLib.tedScene.canEncounterTed
				}, {
					name  : "desertloot1",
					label : "Cake",
					kind  : 'item',
					chance: 0.3,
					call  : findDesertLoot1
				}, {
					name  : "desertloot2",
					label : "Date",
					kind  : 'item',
					chance: 0.3,
					call  : findDesertLoot2
				}, {
					name  : "desertloot3",
					label : "Berry",
					kind  : 'item',
					chance: 0.3,
					call  : findDesertLoot3
				}, {
					name  : "desertruins",
					label : "Ruins",
					kind  : 'event',
					chance: 0.2,
					call  : findDesertRuins
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
		//Explore desert
		public function exploreOuterDesert():void
		{
			explorer.prepareArea(desertOuterEncounter);
			explorer.soulSenseCheck = function (e:SimpleEncounter):Boolean {
				return e.getKind() == "npc" || e.encounterName() == "ants";
			}
			explorer.setTags("desert", "desertOuter");
			explorer.prompt = "You explore the outer desert.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.desertOuter++;
			}
			explorer.leave.hint("Leave the desert");
			explorer.skillBasedReveal(areaLevelOuter, timesExploredOuter());
			explorer.doExplore();
		}
		
		public function exploreInnerDesert():void
		{
			explorer.prepareArea(desertInnerEncounter);
			explorer.setTags("desert", "desertInner");
			explorer.prompt = "You explore the inner desert.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.desertInner++;
			}
			explorer.leave.hint("Leave the desert");
			explorer.skillBasedReveal(areaLevelInner, timesExploredInner());
			explorer.doExplore();
		}
	
		public function desertChance():Number {
			var temp:Number = 0.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}

		private function discoverInnerDesert():void {
			clearOutput();
			outputText("While exploring the desert you notice that the sandy dunes begins to grow larger and more intimidating. The heat has also ramped up you will have to carry some waterskins on you. ");
			outputText("<b>It would seem you found the inner desert area!</b>");
			SceneLib.exploration.counters.desertInner++;
			endEncounter(120);
		}

		public function sandWitchPregnancyEvent():void {
			if (flags[kFLAGS.EGG_WITCH_TYPE] == PregnancyStore.PREGNANCY_DRIDER_EGGS) sandWitchScene.sammitchBirthsDriders();
			else sandWitchScene.witchBirfsSomeBees();
		}

		public function chestEncounter():void {
			clearOutput();
			outputText("While wandering the trackless sands of the desert, you break the silent monotony with a loud 'thunk'.\n"
				+ "You look down and realize you're standing on the lid of an old chest, somehow intact and buried in the sand. Overcome with curiosity, you dig it out, only to discover that it's empty.\n"
				+ "\n"
				+ "You decide to bring it back to your campsite.");
			for (var i:int = 0; i < 6; i++) {
				inventory.createStorage();
			}
			player.createKeyItem("Camp - Chest", 0, 0, 0, 0);
			outputText("\n\n<b>You now have six storage item slots at camp.</b>");
			explorer.stopExploring();
			endEncounter();
		}
		
		public function nagaChance():Number {
			var temp:Number = 1;
			if (flags[kFLAGS.SAMIRAH_FOLLOWER] < 10) temp *= player.npcChanceToEncounter();
			return temp;
		}
		
		public function phyllaAnthillChance():Number {
			var temp:Number = 1.5;
			if (flags[kFLAGS.PHYLLA_SAVED] == 1) temp += 1.5;
			if (flags[kFLAGS.PC_READY_FOR_ANT_COLONY_CHALLENGE] == 1) temp += 1.5;
			if (flags[kFLAGS.ANT_ARENA_WINS] > 0) temp += flags[kFLAGS.ANT_ARENA_WINS] * 1.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}

		public function nailsEncounter():void {
			clearOutput();
			var extractedNail:int = 5 + rand(player.inte / 5) + rand(player.str / 10) + rand(player.tou / 10) + rand(player.spe / 20) + 5;
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCAVENGER] += extractedNail;
			CampStatsAndResources.NailsResc += extractedNail;
			outputText("While exploring the desert, you find the wreckage of a building. Judging from the debris, it's the remains of the library that was destroyed by the fire.\n"
				+ "\n"
				+ "You circle the wreckage for a good while and you can't seem to find anything to salvage until something shiny catches your eye. There are exposed nails! You take your hammer out of your toolbox and you spend time extracting "+extractedNail+" nails. Some of them are bent but others are in incredibly good condition. You could use these for construction.");
			outputText("\n\nNails: ");
			if (CampStatsAndResources.NailsResc > SceneLib.campUpgrades.checkMaterialsCapNails()) CampStatsAndResources.NailsResc = SceneLib.campUpgrades.checkMaterialsCapNails();
			outputText(CampStatsAndResources.NailsResc+"/" + SceneLib.campUpgrades.checkMaterialsCapNails() + "");
			endEncounter();
		}

		public function wstaffEncounter():void {
			clearOutput();
			outputText("While exploring the desert, you see a plume of smoke rising in the distance.  You change direction and approach the soot-cloud carefully.  It takes a few moments, but after cresting your fourth dune, you locate the source.  You lie low, so as not to be seen, and crawl closer for a better look.\n\n");
			outputText("A library is burning up, sending flames dozens of feet into the air.  It doesn't look like any of the books will survive, and most of the structure has already been consumed by the hungry flames.  The source of the inferno is curled up next to it.  It's a naga!  She's tall for a naga, at least seven feet if she stands at her full height.  Her purplish-blue skin looks quite exotic, and she wears a flower in her hair.  The naga is holding a stick with a potato on the end, trying to roast the spud on the library-fire.  It doesn't seem to be going well, and the potato quickly lights up from the intense heat.\n\n");
			outputText("The snake-woman tosses the burnt potato away and cries, \"<i>Hora hora.</i>\"  She suddenly turns and looks directly at you.  Her gaze is piercing and intent, but she vanishes before you can react.  The only reminder she was ever there is a burning potato in the sand.   Your curiosity overcomes your caution, and you approach the fiery inferno.  There isn't even a trail in the sand, and the library is going to be an unsalvageable wreck in short order.   Perhaps the only item worth considering is the stick with the burning potato.  It's quite oddly shaped, and when you reach down to touch it you can feel a resonant tingle.  Perhaps it was some kind of wizard's staff?\n\n");
			flags[kFLAGS.FOUND_WIZARD_STAFF]++;
			inventory.takeItem(weapons.W_STAFF, explorer.done);
		}
		
		public function partsofDesertEagle():void {
			clearOutput();
			outputText("As you explore the desert you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Desert Eagle in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Desert Eagle", 0, 0, 0, 0);
			endEncounter();
		}

		private function mirageDesert():void
		{
			clearOutput();
			outputText("While exploring the desert, you see a shimmering tower in the distance.  As you rush towards it, it vanishes completely.  It was a mirage!   You sigh, depressed at wasting your time.");
			dynStats("lus", -15, "scale", false);
			endEncounter();
		}

		private function walkingDesertStatBoost():void
		{
			clearOutput();
			outputText("You walk through the shifting sands for an hour, finding nothing.\n\n");
			//Chance of boost == 50%
			if (rand(2) == 0) {
				//50/50 strength/toughness
				if (rand(2) == 0 && player.canTrain('str', player.trainStatCap("str",50))) {
					outputText("The effort of struggling with the uncertain footing has made you stronger.");
					player.trainStat("str", 1, player.trainStatCap("str",50));
					dynStats("str", .5);
				}
				//Toughness
				else if (player.canTrain('tou', player.trainStatCap("tou",50))) {
					outputText("The effort of struggling with the uncertain footing has made you tougher.");
					player.trainStat("tou", 1, player.trainStatCap("tou",50));
					dynStats("tou", .5);
				}
			}
			endEncounter();
		}

		private function findDesertLoot1():void {
			clearOutput();
			outputText("Miraculously, you spot a lone pouch lying in the sand. Opening it, you find a neatly wraped cake!\n");
			inventory.takeItem(consumables.HDEWCAK, explorer.done);
		}
		private function findDesertLoot2():void {
			clearOutput();
			outputText("While exploring the desert you walk into an oasis with clear fresh water and the some date tree. It seems to be your lucky day as this is no mirage.\n");
			inventory.takeItem(consumables.JACKALD, explorer.done);
		}
		private function findDesertLoot3():void {
			clearOutput();
			outputText("While exploring the desert you walk into an oasis with clear fresh water and the some spiny, sprawling shrub plants. It seems to be your lucky day as this is no mirage.\n");
			inventory.takeItem(consumables.DESERTB, explorer.done);
		}
		
		private function findDesertRuins():void {
			clearOutput();
			var gemsFound:int = 150 + rand(50);
			outputText("While exploring the desert you find some old sandy ruins battered by time. Inside is a half buried treasure chest filled with some gems. (" + String(gemsFound) + ")");
			player.gems += gemsFound;
			statScreenRefresh();
			endEncounter();
		}
	}
}
