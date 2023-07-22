/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Swamp.*;
import classes.Scenes.Dungeons.DemonLab;
import classes.Scenes.NPCs.BelisaFollower;
import classes.Scenes.NPCs.EtnaFollower;
import classes.Scenes.NPCs.LilyFollower;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class Swamp extends BaseContent
	{
		public var corruptedDriderScene:CorruptedDriderScene = new CorruptedDriderScene();
		public var femaleSpiderMorphScene:FemaleSpiderMorphScene = new FemaleSpiderMorphScene();
		public var maleSpiderMorphScene:MaleSpiderMorphScene = new MaleSpiderMorphScene();
		public var rogar:Rogar = new Rogar();

		public function Swamp() {
			onGameInit(init);
		}

		private var _swampEncounter:GroupEncounter = null;
		public function get swampEncounter():GroupEncounter {
			return _swampEncounter;
		}

		private function init():void {
			_swampEncounter = Encounters.group("swamp", {
				name: "discoverbog",
				label : "New Area",
				kind  : 'place',
				unique: true,
				when: function ():Boolean {
					return (player.level + combat.playerLevelAdjustment()) >= 23 && flags[kFLAGS.BOG_EXPLORED] == 0
				},
				chance: 30,
				call: discoverBog
			}, {
				name: "gunparts",
				label : "Gun Parts",
				kind  : 'item',
				unique: true,
				when: function ():Boolean {
					return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns2) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns2) == 0 && player.hasKeyItem("M1 Cerberus") < 0
				},
				chance: 5,
				call: partsofM1Cerberus
			}, {
				name: "belisa",
				label : "Belisa",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return !player.hasStatusEffect(StatusEffects.SpoodersOff) && BelisaFollower.BelisaEncounternum == 0
				},
				chance: swampChance2,
				call: SceneLib.belisa.firstEncounter
			}, {
				name: "lily",
				label : "Lily",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return !player.hasStatusEffect(StatusEffects.SpoodersOff) && !LilyFollower.LilyFollowerState
				},
				chance: swampChance2,
				call: SceneLib.lily.lilyEncounter
			}, {
				name: "kihaxhel",
				label : "Kiha x Helia",
				kind  : 'event',
				unique: true,
				when: function ():Boolean {
					return !SceneLib.kihaFollower.followerKiha() && player.cor < 60 + player.corruptionTolerance && flags[kFLAGS.KIHA_AFFECTION_LEVEL] >= 1 && flags[kFLAGS.HEL_FUCKBUDDY] > 0 && player.hasCock() && flags[kFLAGS.KIHA_AND_HEL_WHOOPIE] == 0
				},
				chance: swampChance2,
				call: SceneLib.kihaFollower.kihaXSalamander
			}, {
				name: "emberegg",
				label : "Ember (E)",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return flags[kFLAGS.TOOK_EMBER_EGG] == 0 && flags[kFLAGS.EGG_BROKEN] == 0 && flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0
				},
				chance: swampChance,
				call: SceneLib.emberScene.findEmbersEgg
			}, {
				name: "spidermale",
				label : "Spider (M)",
				kind  : 'monster',
				call: maleSpiderMorphScene.greetMaleSpiderMorph
			}, {
				name: "spiderfemale",
				label : "Spider (F)",
				kind  : 'monster',
				call: femaleSpiderMorphScene.fSpiderMorphGreeting
			}, {
				name: "drider",
				label : "Drider",
				kind  : 'monster',
				call: corruptedDriderScene.driderEncounter
			}, {
				name: "rogar",
				label : "Ro'gar",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return flags[kFLAGS.ROGAR_DISABLED] == 0 && flags[kFLAGS.ROGAR_PHASE] < 3
				},
				night: false,
				call: rogar.encounterRogarSwamp
			}, {
				name: "kiha1",
				label : "Kiha",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return SceneLib.kihaFollower.followerKiha()
				},
				chance: swampChance,
				night: false,
				call: SceneLib.kihaScene.kihaExplore
			}, {
				name: "kiha2",
				label : "Kiha",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return !SceneLib.kihaFollower.followerKiha()
				},
				chance: swampChance,
				night: false,
				call: SceneLib.kihaScene.encounterKiha
			}, {
				//Helia monogamy fucks
				name: "helcommon",
				label : "Helia",
				kind  : 'npc',
				unique: true,
				night : false,
				call: SceneLib.helScene.helSexualAmbush,
				chance: swampChance,
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
				chance: swampChance,
				call: SceneLib.etnaScene.repeatYandereEnc
			}/*, {
				name: "demonProjects",
				chance: 0.2,
				when: function ():Boolean {
					return DemonLab.MainAreaComplete >= 4;
				},
				call: SceneLib.exploration.demonLabProjectEncounters
			}*/);
		}

		public function exploreSwamp():void
		{
			clearOutput();
			flags[kFLAGS.TIMES_EXPLORED_SWAMP]++;
			doNext(camp.returnToCampUseOneHour);
			swampEncounter.execEncounter();
			flushOutputTextToGUI();
		}

		public function swampChance():Number {
			var temp:Number = 0.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}
		public function swampChance2():Number {
			var temp:Number = 5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}

		private function discoverBog():void {
			clearOutput();
			outputText("While exploring the swamps, you find yourself into a particularly dark, humid area of this already fetid biome.  You judge that you could find your way back here pretty easily in the future, if you wanted to.  With your newfound discovery fresh in your mind, you return to camp.\n\n(<b>Bog exploration location unlocked!</b>)");
			flags[kFLAGS.BOG_EXPLORED]++;
			doNext(camp.returnToCampUseOneHour);
		}

		public function partsofM1Cerberus():void {
			clearOutput();
			outputText("As you explore the swamp you run into what appears to be the half sunken remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to pull up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the M1 Cerberus in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("M1 Cerberus", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}

	}
}