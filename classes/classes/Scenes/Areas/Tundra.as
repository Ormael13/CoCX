/**
 * @author Ormael
 * Area with lvl 40-55 enemies.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Forest.AlrauneScene;
import classes.Scenes.Areas.Tundra.*;
import classes.Scenes.NPCs.Forgefather;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class Tundra extends BaseContent
	{
		public var valkyrieScene:ValkyrieScene = new ValkyrieScene();
		public var alrauneScene:AlrauneScene = new AlrauneScene();

		public const areaLevel:int = 35;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.tundra > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= areaLevel;
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.tundra;
		}

		public function Tundra()
		{
			onGameInit(init);
		}
		public var tundraEncounter:GroupEncounter;
		private function init():void {
			tundraEncounter = Encounters.group("tundra", {
				name: "discover rift",
				label : "New Area",
				kind  : 'place',
				unique: true,
				when: SceneLib.glacialRift.canDiscover,
				chance: Encounters.ALWAYS,
				call: SceneLib.glacialRift.discover
			},{
				// choice[choice.length] = 0; //Valkyrie (lvl 44)
				name: "valkyrie",
				label : "Valkyrie",
				kind : 'monster',
				night : false,
				call: valkyrieEncounter
			}, /*{
				// ?? (lvl 52)
				// wendigoScene.encounterWendigo();
				name: "wendigo"
			}, */{
				// choice[choice.length] = 2; //Young Frost Giant (lvl 47)
				name: "frostgiant",
				label : "Young Frost Giant",
				kind : 'monster',
				night : false,
				call: frostGiantEncounter
			}, {
				// choice[choice.length] = 3; //Snow Lily (lvl 40)
				name: "snow lily",
				label : "Snow Lily",
				kind : 'monster',
				night : false,
				call: snowLilyEncounter
			}, {
				name: "fafnir tear",
				label : "Fafnir Tear",
				kind  : 'item',
				call: findATear,
				chance: 0.25
			}, {
				// Werewolf huntress
				name: "werewolf huntress",
				label : "Werewolf Huntress",
				kind : 'monster',
				day : false,
				call: SceneLib.werewolfFemaleScene.introWerewolfHuntress,
				chance: 0.50
			}, {
				// choice[choice.length] = 4; //Ice Golem (lvl 64)
				name: "ice golem",
				label : "Ice Golem",
				kind : 'monster',
				call: golemEncounters
			}, {
				// choice[choice.length] = 5; Find Alabaster
				name: "alabaster",
				label : "Mine",
				kind  : 'place',
				when: function():Boolean {
					return player.hasKeyItem("Old Pickaxe") > 0 && Forgefather.materialsExplained;
				},
				call: alabasterEncounter
			}, {
				//Find nothing!
				// choice[choice.length] = 6;
				chance: 0.25,
				name: "nothing",
				call: nothingEncounter,
				label:'Walk',
				kind:'walk'
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

		public function exploreTundra():void {
			explorer.prepareArea(tundraEncounter);
			explorer.setTags("tundra");
			explorer.prompt = "You explore the tundra.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.tundra++;
			}
			explorer.leave.hint("Leave the tundra");
			explorer.skillBasedReveal(areaLevel, timesExplored());
			explorer.doExplore();
		}

		public function nothingEncounter():void {
			clearOutput();
			outputText("You spend one hour exploring tundra but you don't manage to find anything interesting.");
			if (player.canTrain('tou', player.trainStatCap("tou",50))) {
				outputText("But on your way back you feel you're a little more used to traveling through this harsh area.");
				player.trainStat("tou", +1, player.trainStatCap("tou",50));
			}
			dynStats("tou", .5);
			endEncounter();
		}

		public function alabasterEncounter():void {
			clearOutput();
			outputText("You stumble across a vein of Alabaster, this looks like suitable material for your gargoyle form.\n");
			outputText("Do you wish to mine it?");
			menu();
			addButton(0, "Yes", tundraSiteMine);
			addButton(1, "No", explorer.done);
		}

		public function golemEncounters():void {
			clearOutput();
			outputText("As you take a stroll, from nearby trees emerge huge golem. Looks like you have encountered 'true ice golem'! You ready your [weapon] for a fight!");
			startCombat(new GolemTrueIce());
		}

		public function snowLilyEncounter():void {
			clearOutput();
			if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
				outputText("You can smell the thick scent of particularly strong pollen in the air. The book mentioned something about this but you don’t recall exactly what. Do you turn back to camp?\n\n");
				menu();
				addButton(0, "Yes", explorer.done);
				addButton(1, "No", alrauneScene.alrauneGlacialRift);
			} else {
				alrauneScene.alrauneGlacialRift();
			}
		}

		public function frostGiantEncounter():void {
			clearOutput();
			outputText("You wander the chilling landscape of the Tundra. As you cross the peak of a rather large, lightly forested hill, you come face to gigantic face with a Young Frost Giant! He belches fiercely at you and you tumble back down the hill. He mostly steps over it as you come to your senses. You quickly draw your [weapon] and withdraw from the hill to prepare for battle.\n\n");
			startCombat(new YoungFrostGiant());
		}

		public function valkyrieEncounter():void {
			clearOutput();
			outputText("Making your way across the tundra, you’re surprised to see the thick gray clouds part overhead.  You see a beautiful woman descend from on high, her snow-white wings flapping powerfully behind her back.  Armed with a long spear and shield, and clad in a bronze cuirass and a winged helm, she looks every bit the part of a mighty warrior.\n\n");
			outputText("She touches down gently a few feet before you, her shield and spear raised.  \"<i>You seem a worthy sort to test my skills against, wanderer.  Prepare yourself!</i>\" she shouts, bearing down on you.  She doesn’t look like she’s going to back down -- you ready your [weapon] for a fight!");
			startCombat(new Valkyrie());
		}


		private function tundraSiteMine():void {
			if (Forgefather.materialsExplained != 1) endEncounter();
			else {
				clearOutput();
				if (player.fatigue > player.maxOverFatigue() - 50) {
					outputText("\n\n<b>You are too tired to consider mining. Perhaps some rest will suffice?</b>");
					endEncounter();
					return;
				}
				outputText("\n\nYou begin slamming your pickaxe against the alabaster, spending the better part of the next two hours mining. This done, you bring back your prize to camp. ");
				var minedStones:Number = 13 + Math.floor(player.str / 20);
				minedStones = Math.round(minedStones);
				fatigue(50, USEFATG_PHYSICAL);
				SceneLib.forgefatherScene.incrementAlabasterSupply(minedStones);
				player.mineXP(player.MiningMulti());
				findGem();
			}
		}

		private function findATear():void {
			outputText("While exploring the tundra you spot a peculiar white flower. It glows feintly as if from some magical residue.");
			inventory.takeItem(consumables.F_TEAR, explorer.done);
		}

		private function findGem():void {
			if (player.miningLevel > 4) {
				if (rand(4) == 0) {
					inventory.takeItem(useables.SAPPGEM, curry(explorer.done,120));
					player.mineXP(player.MiningMulti() * 2);
				}
				else {
					outputText("After attempting to mine Sapphires, you ended with only unusable pieces.");
					endEncounter(120);
				}
			}
			else {
				outputText(" Your mining skill is too low to find any Sapphires.");
				endEncounter(120);
			}
		}
	}
}
