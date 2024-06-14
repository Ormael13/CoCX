/**
 * @author Ormael
 * Area with lvl 35-60 enemies.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Caves.*;
import classes.Scenes.Monsters.DarkElfScene;
import classes.Scenes.NPCs.Forgefather;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class Caves extends BaseContent
	{
		public var darkelfScene:DarkElfScene = new DarkElfScene();
		public var cavewyrmScene:CaveWyrmScene = new CaveWyrmScene();
		public var displacerbeastScene:DisplacerBeastScene = new DisplacerBeastScene();
		public var darkslimeScene:DarkSlimeScene = new DarkSlimeScene();

		public function Caves() {
			onGameInit(init);
		}

		private var _cavesEncounter:GroupEncounter = null;
		public function get cavesEncounter():GroupEncounter {
			return _cavesEncounter;
		}

		private function init():void {
			_cavesEncounter = Encounters.group("caves", {
				name: "discoverashlands",
				label : "New Area",
				kind  : 'place',
				unique: true,
				when: SceneLib.ashlands.canDiscover,
				chance: 30,
				call: discoverAshlands
			}, {
				name: "discovertundra",
				label : "New Area",
				kind  : 'place',
				unique: true,
				when: SceneLib.tundra.canDiscover,
				chance: 30,
				call: discoverTundra
			}, {
				name: "discoverebonlab",
				label : "Ebon Labyrinth",
				kind  : 'place',
				unique: true,
				when: function ():Boolean {
					return flags[kFLAGS.EBON_LABYRINTH] < 1
				},
				chance: 30,
				call: SceneLib.dungeons.ebonlabyrinth.ebonlabyrinthdiscovery
			}, {
				name: "gunparts",
				label : "Gun Parts",
				kind  : 'item',
				unique: true,
				when: function ():Boolean {
					return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns5) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns5) == 0 && player.hasKeyItem("Touhouna M3") < 0
				},
				call: partsofTouhounaM3
			}, {
				name: "etna",
				label : "Etna",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return flags[kFLAGS.ETNA_AFFECTION] >= 5
				},
				chance: cavesChance,
				call: manticoreEncounterFn
			}/*, {
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					//antworker.();
					clearOutput();
					//outputText("You spend one hour exploring the caves but you don't manage to find anything interesting, unless feeling like you are becoming slightly tougher counts.");
					break;
			}*/, {
				name: "mine",
				label : "Mine",
				kind  : 'place',
				when: function ():Boolean {
					return player.hasKeyItem("Old Pickaxe") > 0 && Forgefather.materialsExplained
				},
				call: cavesMine
			}, {
				name: "cavewyrn",
				label : "Cave Wyrm",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					cavewyrmScene.berserkingCaveWyrmEncounter();
				}
			}, {
				name: "darkelf",
				label : "Dark Elf",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					darkelfScene.introDarkELfRangerCaves();
				}
			}, {
				name: "darkslime",
				label : "Dark Slime",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					darkslimeScene.cavesDarkSlimeEncounter();
				}
			}, {
				name: "displacerbeast",
				label : "Displacer Beast",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.InsideSmallSpace,0,0,0,0);
					displacerbeastScene.displacerBeastEncounter();
				}
			}, {
				name: "",
				label : 'Walk',
				kind : 'walk',
				when: function ():Boolean {
					return true
				},
				call: findNothing
			}, {
				name: "findebon",
				label : "Ebonbloom",
				kind  : 'item',
				call: findEbonBloom
			}, {
				name: "findcrystal",
				label : "M. Crystal",
				kind  : 'item',
				call: findCrystal
			}, {
				name: "findeyedrops",
				label : "Eyedrops",
				kind  : 'item',
				call: findEyeDrops
			}, {
				name: "findnothing",
				label : "Walk",
				kind  : 'walk',
				call: findNothing
			}, {
				name: "demonProjects",
				label : "DemLab Subject",
				kind  : 'monster',
				chance: 0.2,
				when: function ():Boolean {
					return SceneLib.exploration.demonLabProjectEncountersEnabled();
				},
				call: curry(SceneLib.exploration.demonLabProjectEncounters, 1)
			})
		}

		public const areaLevel:int = 30;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.caves > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= areaLevel && SceneLib.beach.isDiscovered();
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.caves;
		}
		public function discover():void {
			SceneLib.exploration.counters.caves = 1;
			clearOutput();
			outputText("As you explore the area you run into a somewhat big hole in the landscape. You look inside unsure as it seems to lead into the depths of Mareth. Resolving yourself to chase the demons wherever they go you decide to still enter the hole discovering a full world of linked tunnels beneath Mareth ground.\n\n");
			outputText("<b>You've discovered the Caves!</b>");
			endEncounter(120);
		}


		public function exploreCaves():void {
			explorer.prepareArea(cavesEncounter);
			explorer.setTags("caves");
			explorer.prompt = "You explore the gloomy caves.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.caves++;
			}
			explorer.leave.hint("Leave the gloomy caves");
			explorer.skillBasedReveal(areaLevel, timesExplored());
			explorer.doExplore();
		}

		public function cavesChance():Number {
			var temp:Number = 0.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}

		private function discoverTundra():void {
			clearOutput();
			outputText("While exploring one of the many tunnels you begin to see a bluish light, curious as to where this opens you take it all the way to the surface and begin to feel chilly, it's definitely cold out there. What awaits you beyond the exit is the sight of endless tundra and icebound mountains.\n\n");
			outputText("<b>You've discovered the Tundra!</b>");
			SceneLib.exploration.counters.tundra = 1;
			explorer.stopExploring();
			doNext(camp.returnToCampUseTwoHours);
		}

		private function discoverAshlands():void {
			clearOutput();
			outputText("While exploring one of the many tunnels you begin to see a red light, curious as to where this opens you take it all the way to the surface as the heat starts to increase dramatically the cool fresh air of the tunnel replaced by a warm and smoky air, it's definitely very hot out there. ");
			outputText("What awaits you beyond the exit is the sight of a field of ashes and lava with volcanoes in the backside.\n\n");
			outputText("<b>You've discovered the Ashlands!</b>");
			SceneLib.exploration.counters.ashlands = 1;
			explorer.stopExploring();
			doNext(camp.returnToCampUseTwoHours);
		}

		private function findEbonBloom():void {
			clearOutput();
			outputText("You're exploring the vast cave system when you come across a small cavern. As you head further into the cavern you spot something glinting just up ahead. A small crack in the ceiling lets a sliver of light shine down on a dark metallic looking flower growing on top of a stone pillar. ");
			outputText("Your eyes widen in surprise when you recognize it to be a rare Ebonbloom. Seeing that nothing else is around, you make your way over to the flower then try to pluck it. It doesn't budge at first but with a little more effort you manage to pull the flower free. ");
			if (silly()) outputText("You suddenly hear dramatic music play as the cavern around you begins to cave in. You don your brown explorer's hat and whip as you make your way out of the collapsing cavern, dodging falling rocks in the process. By the skin of your teeth you escape from the cavern with your treasure in hand. ");
			inventory.takeItem(useables.EBONBLO, explorer.done);
		}

		private function findCrystal():void {
			clearOutput();
			outputText("As you explore the cave, you run into a weird neon blue crystal that glow in the dark. You pack it in your backpack in case it could be sold for a decent amount" + (silly() ? ", perhaps to a drug dealer" : "") + ". ");
			inventory.takeItem(consumables.METHIRC, explorer.done);
		}

		private function findEyeDrops():void {
			clearOutput();
			outputText("As you explore the cave, you run into a bottle of eye drops. You pack it in your backpack in case it could be sold for a decent amount. ");
			inventory.takeItem(consumables.EYEDROP, explorer.done);
		}

		private function findNothing():void {
			clearOutput();
			outputText("You spend one hour exploring the caves but you don't manage to find anything interesting, unless feeling like you are becoming slightly tougher counts.");
			dynStats("tou", .5);
			endEncounter();
		}

		private function manticoreEncounterFn():void {
			player.createStatusEffect(StatusEffects.InsideSmallSpace, 0, 0, 0, 0);
			if (rand(2) == 0) {
				player.createStatusEffect(StatusEffects.WildManticore, 0, 0, 0, 0);
				SceneLib.etnaScene.repeatEnc();
			} else {
				SceneLib.bashemathScene.repeatEncWM();
			}
		}

		public function partsofTouhounaM3():void {
			clearOutput();
			outputText("As you explore the caves you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Touhouna M3 in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Touhouna M3", 0, 0, 0, 0);
			endEncounter();
		}

		private function cavesMine():void {
			clearOutput();
			outputText("You stumble across a vein of Ebony, this looks like suitable material for your gargoyle form.\n");
			outputText("Do you wish to mine it?");
			menu();
			addButton(0, "Yes", cavesSiteMine);
			addButton(1, "No", explorer.done);
		}

		private function cavesSiteMine():void {
			if (Forgefather.materialsExplained != 1) endEncounter();
			else {
				if (player.fatigue > player.maxOverFatigue() - 50) {
					outputText("\n\n<b>You are too tired to consider mining. Perhaps some rest will suffice?</b>");
					endEncounter();
					return;
				}
				outputText("\n\nYou begin slamming your pickaxe against the ebony, spending the better part of the next two hours mining. This done, you bring back your prize to camp. ");
				var minedStones:Number = 13 + Math.floor(player.str / 20);
				minedStones = Math.round(minedStones);
				fatigue(50, USEFATG_PHYSICAL);
				SceneLib.forgefatherScene.incrementEbonySupply(minedStones);
				player.mineXP(player.MiningMulti());
				findGem();
			}
		}

		private function findGem():void {
			if (player.miningLevel > 4) {
				if (rand(4) == 0) {
					inventory.takeItem(useables.AMEGEM, curry(explorer.done,120));
					player.mineXP(player.MiningMulti() * 2);
				}
				else {
					outputText("After attempting to mine Amethysts, you ended up with only unusable pieces.");
					endEncounter(120);
				}
			}
			else {
				outputText(" Your mining skill is too low to find any Amethysts.");
				endEncounter(120);
			}
		}

	}
}
