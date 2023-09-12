/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Bog.*;
import classes.Scenes.NPCs.EtnaFollower;
import classes.Scenes.SceneLib;

public class Bog extends BaseContent
	{
		public var frogGirlScene:FrogGirlScene = new FrogGirlScene();
		public var chameleonGirlScene:ChameleonGirlScene = new ChameleonGirlScene();
		public var phoukaScene:PhoukaScene = new PhoukaScene();
		public var lizanScene:LizanRogueScene = new LizanRogueScene();
		
		public function Bog() {
			onGameInit(init);
		}

		private var _bogEncounter:GroupEncounter = null;
		public function get bogEncounter():GroupEncounter {
			return _bogEncounter;
		}

		private function init():void {
			_bogEncounter = Encounters.group("bogs", {
				name: "halloweenphouka",
				label : "(Hallow) Phouka",
				kind  : 'event',
				unique: true,
				chance: 0.25,
				when: function ():Boolean {
					return (isHalloween() && (date.fullYear > flags[kFLAGS.TREACLE_MINE_YEAR_DONE])) && (flags[kFLAGS.PHOUKA_LORE] > 0)
				},
				call: phoukaScene.phoukaHalloween
			}, {
				name: "murkychest",
				label : "M. Chest",
				kind  : 'item',
				unique: true,
				when: function ():Boolean {
					return player.hasKeyItem("Camp - Murky Chest") < 0
				},
				chance: 0.1,
				call: findChest
			}, {
				name: "froggirl",
				label : "Frog girl",
				kind  : 'event',
				when: function ():Boolean {
					return flags[kFLAGS.TIMES_ENCOUNTERED_FROG] != -1 && player.buttPregnancyIncubation != 0
				},
				call: frogGirlScene.findTheFrogGirl
			}, {
				name: "phouka",
				label : "Phouka",
				kind  : 'monster',
				call: phoukaScene.phoukaEncounter
			}, {
				name: "chameleon",
				label : "Chameleon",
				kind  : 'monster',
				call: chameleonGirlScene.encounterChameleon
			}, {
				name: "lizan",
				label : "Lizan",
				kind  : 'monster',
				call: lizanScene.lizanIntro
			}, {
				name: "trollfemale",
				label : "Troll (F)",
				kind  : 'monster',
				call: SceneLib.trollScene.encounterAdultFemaleTroll,
				chance: 0.5
			}, {
				name: "trollmale",
				label : "Troll (M)",
				kind  : 'monster',
				call: SceneLib.trollScene.encounterAdultMaleTroll,
				chance: 0.5
			}, {
				name: "findnothing",
				label : "Walk",
				kind:'walk',
				call: findNothing
			}, {
				//Helia monogamy fucks
				name: "helcommon",
				label : "Helia",
				kind  : 'npc',
				unique: true,
				night : false,
				call: SceneLib.helScene.helSexualAmbush,
				chance: 0.2,
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
				chance: bogChance,
				call: SceneLib.etnaScene.repeatYandereEnc
			}, {
				name: "zenji",
				label : "Zenji",
				kind  : 'npc',
				unique: true,
				night: false,
				when: function ():Boolean {
					return flags[kFLAGS.ZENJI_PROGRESS] != -1 && (flags[kFLAGS.ZENJI_PROGRESS] < 8 || flags[kFLAGS.ZENJI_PROGRESS] == 10)
				},
				chance: bogChance,
				call: zenjiEncounterFn
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
		
		public const areaLevel:int = 23;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.bog > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= areaLevel;
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.bog;
		}
		public function discover():void {
			clearOutput();
			outputText("While exploring the swamps, you find yourself into a particularly dark, humid area of this already fetid biome.  You judge that you could find your way back here pretty easily in the future, if you wanted to.  With your newfound discovery fresh in your mind, you return to camp.\n\n(<b>Bog exploration location unlocked!</b>)");
			SceneLib.exploration.counters.bog++;
			explorer.done(60);
		}
		
		
		public function exploreBog():void
		{
			explorer.prepareArea(bogEncounter);
			explorer.setTags("bog");
			explorer.prompt = "You explore the dark bog.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.bog++;
			}
			explorer.leave.hint("Leave the dark bog");
			explorer.skillBasedReveal(areaLevel, timesExplored());
			explorer.doExplore();
		}
	
		public function bogChance():Number {
			var temp:Number = 0.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}

		private function findNothing():void {
			outputText("You wander around through the humid muck, but you don't run into anything interesting.");
			endEncounter();
		}

		private function findChest():void {
			var gemsFound:int = 350 + rand(150);
			outputText("While you're minding your own business, you spot a waterlogged chest. You wade in the murky waters until you finally reach the chest. As you open the chest, you find " + String(gemsFound) + " gems inside the chest! You pocket the gems and haul the chest home. It would make a good storage once you clean the inside of the chest.");
			player.createKeyItem("Camp - Murky Chest", 0, 0, 0, 0);
			for (var i:int = 0; i < 4; i++) {
				inventory.createStorage();
			}
			player.gems += gemsFound;
			statScreenRefresh();
			outputText("\n\n<b>You now have " + num2Text(inventory.itemStorageDirectGet().length) + " storage item slots at camp.</b>");
			endEncounter();
		}

		private function zenjiEncounterFn():void {
			if (flags[kFLAGS.ZENJI_PROGRESS] >= 4) {
				if (flags[kFLAGS.ZENJI_PROGRESS] == 6) {
					if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] == 100) {
						if (flags[kFLAGS.ZENJI_PROGRESS] == 7) SceneLib.zenjiScene.followerZenjiRepeatOffer();
						else SceneLib.zenjiScene.followerZenjiFirstTimeOffer();
					} else if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] == 0) {
						if (flags[kFLAGS.ZENJI_PROGRESS] == 10) SceneLib.zenjiScene.loverZenjiRepeatOffer();
						else SceneLib.zenjiScene.loverZenjiFirstTimeOffer();
					} else SceneLib.zenjiScene.part2TrollEncounterRepeat();
				} else SceneLib.zenjiScene.part2TrollEncounterFirst();
			} else if (flags[kFLAGS.ZENJI_PROGRESS] > 0 && flags[kFLAGS.ZENJI_PROGRESS] < 4) SceneLib.zenjiScene.part1TrollEncounterRepeat();
			else if (flags[kFLAGS.ZENJI_PROGRESS] == 0) SceneLib.zenjiScene.part1TrollEncounter();
		}
	}
}
