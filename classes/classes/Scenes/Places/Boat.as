/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Places
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Lake.*;
import classes.Scenes.NPCs.BelisaFollower;
import classes.Scenes.NPCs.EtnaFollower;
import classes.Scenes.Places.Boat.*;
import classes.Scenes.SceneLib;

public class Boat extends AbstractLakeContent
	{
		public var sharkGirlScene:SharkGirlScene = new SharkGirlScene();
		public var marae:MaraeScene = new MaraeScene();
		public var kaiju:Kaiju = new Kaiju();
		public var anemoneScene:AnemoneScene = new AnemoneScene();
		public function Boat() {
			onGameInit(init);
		}

		public const discoverLevel:int = 0;
		public const areaLevel:int = 1;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.boat > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= discoverLevel;
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.boat;
		}

		public function discoverBoat():void {
			SceneLib.exploration.counters.boat = 1;
			clearOutput();
			outputText("You journey around the lake, seeking demons to fight");
			if(player.cor > 60) outputText(" or fuck");
			outputText(".  The air is fresh, and the grass is cool and soft under your feet.   Soft waves lap against the muddy sand of the lake-shore, as if radiating outward from the lake.   You pass around a few bushes carefully, being wary of hidden 'surprises', and come upon a small dock.  The dock is crafted from old growth trees lashed together with some crude rope.  Judging by the appearance of the rope, it is very old and has not been seen to in quite some time.  Tied to the dock is a small rowboat, only about seven feet long and three feet wide.   The boat appears in much better condition than the dock, and appears to be brand new.\n\n");
			outputText("<b>You have discovered the lake boat!</b>\n(You may return and use the boat to explore the lake's interior by using the 'places' menu.)");
			explorer.stopExploring();
			doNext(camp.returnToCampUseOneHour);
		}
		private var _boatEncounter:GroupEncounter = null;
		public function get boatEncounter():GroupEncounter {
			return _boatEncounter;
		}
		private function init():void {
			_boatEncounter = Encounters.group("boat", {
				name: "Belisa",
				label: "Belisa",
				kind: 'npc',
				unique: true,
				when: function ():Boolean {
					return BelisaFollower.BelisaInGame && BelisaFollower.BelisaEncounternum == 1;
				},
				call: SceneLib.belisa.secondEncounter,
				chance: 20
			}, {
				name: "Etna",
				label: "Etna",
				kind: 'npc',
				unique: true,
				when: function():Boolean {
					return (flags[kFLAGS.ETNA_FOLLOWER] < 1 || EtnaFollower.EtnaInfidelity == 2) && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && !player.hasStatusEffect(StatusEffects.EtnaOff) && (player.level >= 20);
				},
				call: SceneLib.etnaScene.repeatYandereEnc
			}, {
				name: "izmaKids",
				label: "Lost daughter",
				kind: 'event',
				unique: true,
				chance: 0.3,
				when: function():Boolean {
					return flags[kFLAGS.IZMA_KIDS_IN_THE_WILD] > 0 && SceneLib.izmaScene.izmaFollower();
				},
				call: SceneLib.izmaScene.findLostIzmaKids
			}, {
				name: "Marae",
				label: "Marae",
				kind: 'npc',
				unique: true,
				chance: 3,
				when: function():Boolean {
					return flags[kFLAGS.MARAE_ISLAND];
				},
				night: false,
				call: marae.encounterMarae
			}, {
				name: "Walk",
				label: "Row",
				kind: 'walk',
				chance: 0.25,
				call: rowBoat
			}, {
				name: "sharkgirl",
				label : "Shark girl",
				kind  : 'monster',
				call: sharkGirlScene.sharkGirlEncounter
			}, {
				name: 'anemone',
				label : "Anemone",
				kind  : 'monster',
				call: function():void {
					flags[kFLAGS.ANEMONE_OR_SEA_ANEMONE] = 1;
					anemoneScene.mortalAnemoneeeeee();
				}
			}, {
				name: 'zealot',
				label: "Fetish Zealot",
				kind: 'monster',
				night: false,
				when: function():Boolean {
					return flags[kFLAGS.FACTORY_SHUTDOWN] > 0 && player.level > 2 && player.hasStatusEffect(StatusEffects.FetishOn)
				},
				call: lake.fetishZealotScene.zealotBoat
			}, {
				name : "Fishing",
				label : "Fishing",
				kind  : 'event',
				unique: true,
				when: function():Boolean {
					return player.hasKeyItem("Fishing Pole") >= 0;
				},
				call: fishing
			}, {
				name: "Venus",
				label : "Venus",
				kind  : 'npc',
				unique: true,
				when: function():Boolean {
					return player.level >= 5 && flags[kFLAGS.KAIJU_DISABLED] == 0 && !player.hasStatusEffect(StatusEffects.VenusOff);
				},
				call: kaiju.kaijuMeeting
			})
		}

		public function boatExplore():void
		{
			explorer.prepareArea(boatEncounter);
			explorer.setTags("boat", "lakeBoat", "water");
			explorer.prompt = "You explore the lake.";
			if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
				explorer.prompt += "The water appears somewhat muddy and has a faint pungent odor.  ";
				if (player.inte > 40) explorer.prompt += "You realize what it smells like – sex.  ";
			}
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.boat++;
			}
			explorer.leave.hint("Return to the shore");
			explorer.skillBasedReveal(areaLevel, timesExplored());
			explorer.doExplore();
		}

		private function fishing():void {
			outputText("This is a calm day at the lake, you managed to hold your boat in place and, while you found nothing of note, couldn’t help yourself but to enjoy a few hour using your newly acquired fishing pole. You even spotted Calu in the distance doing the same thing from her usual sitting spot.\n\n");
			outputText("<b>You got a fish!</b>");
			inventory.takeItem(consumables.FREFISH, explorer.done);
		}

		private function rowBoat():void {
			if (rand(2) == 0) outputText("You row for nearly an hour, until your arms practically burn with exhaustion from all the rowing.");
			else outputText("You give up on finding anything interesting, and decide to go check up on your camp.");
			endEncounter(60);
		}
	}
}
