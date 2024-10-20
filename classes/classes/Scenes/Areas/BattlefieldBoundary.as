/**
 * @author Ormael
 * Area with lvl 6-29 group enemies. Good for PC focused on group fights.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Battlefield.*;
import classes.Scenes.Camp.CampStatsAndResources;
import classes.Scenes.NPCs.EtnaFollower;
import classes.Scenes.SceneLib;

use namespace CoC;
	
	public class BattlefieldBoundary extends BaseContent
	{
		public var battlefieldEnemiesScene:BattlefieldEnemiesScenes = new BattlefieldEnemiesScenes();

		public function BattlefieldBoundary() {
			onGameInit(init);
		}

		private var _battlefieldBoundaryEncounter:GroupEncounter = null;
		private var _battlefieldLoot:GroupEncounter = null;
		public function get battlefieldBoundaryEncounter():GroupEncounter {
			return _battlefieldBoundaryEncounter;
		}
		public function get battlefieldLoot():GroupEncounter {
			return _battlefieldLoot;
		}

		private function init():void {
			const fn:FnHelpers = Encounters.fn;
			_battlefieldLoot = Encounters.group("battlefieldLoot", {
				name: "MG_SFRP",
				label: "MGSFRPill",
				kind  : 'item',
				chance: 0.08,
				when: fn.ifLevelMin(24,0),
				call: curry(findItem, consumables.MG_SFRP)
			}, {
				name: "D_ARCON",
				label: "Dil.ARC",
				kind  : 'item',
				chance: 0.08,
				when: fn.ifLevelMin(24,0),
				call: curry(findItem, consumables.D_ARCON)
			}, {
				name: "SPIL_SH",
				label: "SpikeLShield",
				kind  : 'item',
				chance: 0.10,
				when: fn.ifLevelMin(16,0),
				call: curry(findItem, shields.SPIL_SH)
			}, {
				name: "LG_SFRP",
				label: "LGSFRPill",
				kind  : 'item',
				chance: 0.17,
				call: curry(findItem, consumables.LG_SFRP)
			}, {
				name: "VDARCON",
				label: "V.D.ARC",
				kind  : 'item',
				chance: 0.17,
				call: curry(findItem, consumables.VDARCON)
			});
			_battlefieldBoundaryEncounter = Encounters.group("batllefieldboundary", {
				//Discover Outer Battlefield
				name: "discoverOuter",
				label : "New Area",
				kind  : 'place',
				unique: true,
				chance: 30,
				when: SceneLib.battlefiledouter.canDiscover,
				call: SceneLib.battlefiledouter.discover
			}, {
				name: "metal",
				label : "Scrap",
				kind  : 'item',
				chance: 0.4,
				call: findMetalScrapBoundary
			}, {
				//Find Tripxi gun parts
				name: "gunPart",
				label : "Gun Parts",
				kind  : 'item',
				unique: true,
				chance:30,
				when: function ():Boolean {
					return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns6) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns6) == 0 && player.hasKeyItem("Twin Grakaturd") < 0
				},
				call: partsofTwinGrakaturd
			}, {
				//Dilapidated Shrine
				name: "dilapidatedShrine",
				label : "Dilapidated Shrine",
				shortLabel: "D.Shrine",
				kind  : 'place',
				unique: true,
				call: SceneLib.dilapidatedShrine.firstvisitshrineintro,
				when: function ():Boolean {
					return flags[kFLAGS.DILAPIDATED_SHRINE_UNLOCKED] == 1
				},
				chance: 0.2
			}, battlefieldLoot, {
				name: "nothing",
				label : "Walk",
				kind  : "walk",
				call: findNothing
			}, {
				//Helia monogamy fucks
				name: "helcommon",
				label : "Helia",
				kind  : 'npc',
				unique: true,
				night : false,
				call: SceneLib.helScene.helSexualAmbush,
				chance: battlefieldBoundaryChance,
				when: SceneLib.helScene.helSexualAmbushCondition
			}, {
				name: "etna",
				label : "Etna",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return (flags[kFLAGS.ETNA_FOLLOWER] < 1 || EtnaFollower.EtnaInfidelity == 2)
							&& flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2
							&& !player.hasStatusEffect(StatusEffects.EtnaOff);
				},
				chance: battlefieldBoundaryChance,
				call: SceneLib.etnaScene.repeatYandereEnc
			},  {
				name: "nadia",
				label : "Nadia",
				kind  : 'npc',
				unique: true,
				night : false,
				when: function():Boolean {
					return flags[kFLAGS.NADIA_FOLLOWER] < 6 && !(flags[kFLAGS.NADIA_FOLLOWER] != 3 && flags[kFLAGS.NADIA_LVL_UP] >= 8) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1 && !player.hasStatusEffect(StatusEffects.NadiaOff);
				},
				chance: battlefieldBoundaryChance,
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
				chance: battlefieldBoundaryChance,
				call: SceneLib.nadiaScene.postNameEnc
			}, {
				name: "ted",
				label : "Dragon-Boy",
				kind  : 'npc',
				unique: true,
				call: SceneLib.tedScene.introPostHiddenCave,
				when: SceneLib.tedScene.canEncounterTed
			}, SceneLib.exploration.commonGroupEncounters.withChanceFactor(0.1), {
				name: "zombies",
				label : "Zombies",
				kind : 'monster',
				chance: 0.4,
				call: battlefieldEnemiesScene.encounterZombies,
				when: battlefieldEnemiesScene.canEncounterZombies
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
		
		public const discoverLevel:int = 15;
		public const areaLevel:int = 16;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.battlefieldBoundary > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= discoverLevel && SceneLib.desert.isDiscoveredOuter();
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.battlefieldBoundary;
		}
		public function discover():void {
			SceneLib.exploration.counters.battlefieldBoundary = 1;
			clearOutput();
			outputText("While exploring you run into the sight of endless field, littered with the remains of fallen soldiers from what appears to have been the demon war, this much do the horned skeletons tells. You can see some golem husk on the ground as well. It’s very plausible the war is still ongoing.\n\n<b>You've discovered the Battlefield (Boundary)!</b>");
			endEncounter(60);
		}
		
		
		public function exploreBattlefieldBoundary():void {
			explorer.prepareArea(battlefieldBoundaryEncounter);
			explorer.setTags("battlefield", "battlefieldBoundary");
			explorer.prompt = "You explore the battlefield boundary.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.battlefieldBoundary++;
			}
			explorer.leave.hint("Leave the battlefield boundary");
			explorer.skillBasedReveal(areaLevel, timesExplored());
			explorer.doExplore();
		}
		
		public function battlefieldBoundaryChance():Number {
			var temp:Number = 0.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}

		private function findItem(item:ItemType):void {
			clearOutput();
			outputText("You spot something on the ground among various items remains. Taking a closer look, it's ");
			outputText(item.longName);
			outputText(". ");
			inventory.takeItem(item, explorer.done);
		}
		private function findMetalScrapBoundary():void {
			clearOutput();
			var mpa:Number = 2 + rand(2);
			outputText("While exploring the battlefield you find the remains of some metal scraps. At first you think you won't find anything useful there but a metal plates draws your attention, it could be useful later. You put the item in your backpack and head back to camp.\n\n");
			outputText("<b>You found "+mpa+" metal plates.</b>");
			CampStatsAndResources.MetalPieces += mpa;
			outputText("<b>(Metal plates: "+CampStatsAndResources.MetalPieces+"/200 total)</b>");//"+SceneLib.campUpgrades.checkMaterialsCapStones()+"
			endEncounter();
		}

		private function findNothing():void {
			clearOutput();
			if (rand(4) == 0) {
				outputText("You spend almost hour exploring this deserted battlefield but you don't manage to find anything interesting. After checking another pile of weapons you hear some noise coming from nearby. Intrigued you cautiously approach source of it, which turns to be... " + (rand(2) == 0 ? "demons" : "imps") + ". Whole group of them running straight at you. ");
				outputText("As they approach you ready your [weapon] but... the first ones after reaching you jsut give you a short glance and just pass by. Then another one and one more pass you by almost looking like they just seen you as merely obstacle to avoid during their run. Then you hear some fragments of the words they seems to talks form time to time.\n\n");
				outputText("\"<i>...ster or the fog will catch up to u...</i>\", \"<i>...ut there is <b>SOMETHING</b> insid...</i>\", \"<i>...us..t reeee....port b...</i>\"\n\n");
				outputText("After the last one of them passes you by, they soon vanish into the distance behind you. What just happened? Usually laid-back and horny " + (rand(2) == 0 ? "demons" : "imps") + " were actually running away? From fog? As you think over it, you notice something moving slightly in the direction they came. ");
				outputText("Some grey, maybe black colored shape seemly wiggling as it like moving in your direction." + (silly() ? " Oh are you approaching me?" : "") + " Bit tired and on the edge due to meeting potential enemies moments ago you decide to return this time. Maybe next time you will check out closer that 'fog' or whatever it's.");
			} else outputText("You spend an hour exploring this deserted battlefield but you don't manage to find anything interesting, yet this trip had made you a little wiser.");
			dynStats("wis", .5);
			endEncounter();
		}

		public function partsofTwinGrakaturd():void {
			clearOutput();
			outputText("As you explore the battlefield (boundary), you run into what appears to be the half buried remains of an old contraption. This might just be what that gun vendor was talking about! You proceed to dig up the items realizing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Twin Grakaturd in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Twin Grakaturd", 0, 0, 0, 0);
			endEncounter();
		}
	}
}
