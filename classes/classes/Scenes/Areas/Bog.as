/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Bog.*;
import classes.Scenes.Combat.SpellsBlood.LifestealEnchantmentSpell;
import classes.Scenes.Dungeons.DemonLab;
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
				when: function ():Boolean {
					return (isHalloween() && (date.fullYear > flags[kFLAGS.TREACLE_MINE_YEAR_DONE]) && flags[kFLAGS.BOG_EXPLORED] % 4 == 0) && (flags[kFLAGS.PHOUKA_LORE] > 0)
				},
				call: phoukaScene.phoukaHalloween
			}, {
				name: "murkychest",
				when: function ():Boolean {
					return player.hasKeyItem("Camp - Murky Chest") < 0
				},
				chance: 0.1,
				call: findChest
			}, {
				name: "froggirl",
				when: function ():Boolean {
					return flags[kFLAGS.TIMES_ENCOUNTERED_FROG] != -1 && player.buttPregnancyIncubation != 0
				},
				call: frogGirlScene.findTheFrogGirl
			}, {
				name: "phouka",
				call: phoukaScene.phoukaEncounter
			}, {
				name: "chameleon",
				call: chameleonGirlScene.encounterChameleon
			}, {
				name: "lizan",
				call: lizanScene.lizanIntro
			}, {
				name: "trollfemale",
				call: SceneLib.trollScene.encounterAdultFemaleTroll,
				chance: 0.5
			}, {
				name: "trollmale",
				call: SceneLib.trollScene.encounterAdultMaleTroll,
				chance: 0.5
			}, {
				name: "findnothing",
				call: findNothing
			}, {
				//Helia monogamy fucks
				name: "helcommon",
				night : false,
				call: SceneLib.helScene.helSexualAmbush,
				chance: 0.2,
				when: SceneLib.helScene.helSexualAmbushCondition
			}, {
				name: "etna",
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
				night: false,
				when: function ():Boolean {
					return flags[kFLAGS.ZENJI_PROGRESS] != -1 && (flags[kFLAGS.ZENJI_PROGRESS] < 8 || flags[kFLAGS.ZENJI_PROGRESS] == 10)
				},
				chance: bogChance,
				call: zenjiEncounterFn
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
			return flags[kFLAGS.BOG_EXPLORED] > 0;
		}
		public function timesExplored():int {
			return flags[kFLAGS.BOG_EXPLORED];
		}

		public function exploreBog():void
		{
			clearOutput();
			flags[kFLAGS.BOG_EXPLORED]++;
			doNext(camp.returnToCampUseOneHour);
			bogEncounter.execEncounter();
			flushOutputTextToGUI();
		}
	
		public function bogChance():Number {
			var temp:Number = 0.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}

		private function findNothing():void {
			outputText("You wander around through the humid muck, but you don't run into anything interesting.");
			doNext(camp.returnToCampUseOneHour);
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
			doNext(camp.returnToCampUseOneHour);
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