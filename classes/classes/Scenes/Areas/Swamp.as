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
import classes.Scenes.Areas.Swamp.*;
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

		public const areaLevel:int = 13;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.swamp > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= areaLevel && SceneLib.plains.isDiscovered();
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.swamp;
		}
		public function discover():void {
			SceneLib.exploration.counters.swamp = 1;
			clearOutput();
			outputText("All things considered, you decide you wouldn't mind a change of scenery.  Gathering up your belongings, you begin a journey into the wasteland.  The journey begins in high spirits, and you whistle a little traveling tune to pass the time.  After an hour of wandering, however, your wanderlust begins to whittle away.  Another half-hour ticks by.  Fed up with the fruitless exploration, you're nearly about to head back to camp when a faint light flits across your vision.  Startled, you whirl about to take in three luminous will-o'-the-wisps, swirling around each other whimsically.  As you watch, the three ghostly lights begin to move off, and though the thought of a trap crosses your mind, you decide to follow.\n\n");
			outputText("Before long, you start to detect traces of change in the environment.  The most immediate difference is the increasingly sweltering heat.  A few minutes pass, then the will-o'-the-wisps plunge into the boundaries of a dark, murky, stagnant swamp; after a steadying breath you follow them into the bog.  Once within, however, the gaseous balls float off in different directions, causing you to lose track of them.  You sigh resignedly and retrace your steps, satisfied with your discovery.  Further exploration can wait.  For now, your camp is waiting.\n\n");
			outputText("<b>You've discovered the Swamp!</b>");
			endEncounter(120);
		}


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
				when: SceneLib.bog.canDiscover,
				chance: 30,
				call: SceneLib.bog.discover
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
				label : "Egg",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return flags[kFLAGS.TOOK_EMBER_EGG] == 0 && flags[kFLAGS.EGG_BROKEN] == 0 && SceneLib.exploration.counters.swamp > 0
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
				name: "fetishinquisitor",
				label : "F.Inquisitor",
				kind  : 'monster',
				call: SceneLib.lake.fetishZealotScene.zealotSwamp
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
			}, SceneLib.kihaScene.kihaTerrirotyEncounters.withCondition(function():Boolean {
				return SceneLib.kihaFollower.followerKiha()
			}), {
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

		public function exploreSwamp():void
		{
			explorer.prepareArea(swampEncounter);
			explorer.setTags("swamp");
			explorer.prompt = "You explore the wet swamplands.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.swamp++;
			}
			explorer.leave.hint("Leave the wet swamplands");
			explorer.skillBasedReveal(areaLevel, timesExplored());
			explorer.doExplore();
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


		public function partsofM1Cerberus():void {
			clearOutput();
			outputText("As you explore the swamp you run into what appears to be the half sunken remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to pull up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the M1 Cerberus in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("M1 Cerberus", 0, 0, 0, 0);
			endEncounter();
		}

	}
}
