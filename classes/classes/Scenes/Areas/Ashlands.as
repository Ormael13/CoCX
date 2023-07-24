/**
 * @author Ormael
 * Area with lvl 40-55 enemies.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Ashlands.*;
import classes.Scenes.Areas.Forest.AlrauneScene;
import classes.Scenes.Areas.HighMountains.PhoenixScene;
import classes.Scenes.NPCs.Forgefather;
import classes.Scenes.SceneLib;

use namespace CoC;

public class Ashlands extends BaseContent
{
	public var phoenixScene:PhoenixScene = new PhoenixScene();
	public var alrauneScene:AlrauneScene = new AlrauneScene();
	public var hellcatScene:HellCatScene = new HellCatScene();

	public function Ashlands() {
		onGameInit(init);
	}

	private var _ashlandsEncounter:GroupEncounter = null;
	public function get ashlandsEncounter():GroupEncounter {
		return _ashlandsEncounter;
	}

	private function init():void {
		_ashlandsEncounter = Encounters.group("ashlands", {
			name: "derpnade launcher",
			label : "Gun Parts",
			kind  : 'item',
			unique: true,
			when: function ():Boolean {
				return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns1) && player.statusEffectv3(StatusEffects.TelAdreTripxiGuns1) == 0 && player.hasKeyItem("Double barreled dragon gun") < 0;
			},
			chance: 30,
			call: partsofTripxiDoubleBarreledDragonGun
		}, {
			name: "crags",
			label : "New Area",
			kind  : 'place',
			unique: true,
			when: SceneLib.volcanicCrag.canDiscover,
			call: discoverCrags
		}, {
			name: "phoenix",
			label : "Quasi-Phoenix",
			kind : 'monster',
			night : false,
			when: SceneLib.dungeons.checkPhoenixTowerClear,
			call: phoenixScene.encounterPhoenix
		}, {/*
			//	wendigoScene.encounterWendigo();
		}, {*/
			name: "hellCatSabath",
			label : "HellCat Sabath",
			kind  : 'event',
			unique: true,
			when: function ():Boolean {
				return (flags[kFLAGS.WITCHES_SABBATH] > 3 && player.isRace(Races.HELLCAT, 1, false) && player.gender == 3) ||
						(flags[kFLAGS.WITCHES_SABBATH] > 0 && player.isRace(Races.CAT) && player.inte >= 40 && player.hasStatusEffect(StatusEffects.KnowsWhitefire))
			},
			call: SceneLib.ashlands.hellcatScene.WitchesSabbath
		}, {
			name: "hellcat",
			label : "Hellcat",
			kind : 'monster',
			call: SceneLib.ashlands.hellcatScene.HellCatIntro
		}, {
			name: "alraune",
			label : "Alraune",
			kind : 'monster',
			night : false,
			call: alrauneEncounterFn
		}, {
			name: "golem",
			label : "Fire Golem",
			kind : 'monster',
			call: fireGolemEncounterFn
		}, {
			name: "granite",
			label : "Mine",
			kind  : 'place',
			when: function():Boolean {
					return player.hasKeyItem("Old Pickaxe") > 0 && Forgefather.materialsExplained
				},
			call: findGranite
		}, {
			name: "nothing",
			call: findNothing,
			label:'Walk',
			kind:'walk'
		}/*, {
			name: "demonProjects",
			chance: 0.2,
			when: function ():Boolean {
				return DemonLab.MainAreaComplete >= 4;
			},
			call: SceneLib.exploration.demonLabProjectEncounters
		}*/);
	}
	
	public const areaLevel:int = 35;
	public function isDiscovered():Boolean {
		return SceneLib.exploration.counters.ashlands > 0;
	}
	public function canDiscover():Boolean {
		return !isDiscovered() && adjustedPlayerLevel() >= areaLevel;
	}
	public function timesExplored():int {
		return SceneLib.exploration.counters.ashlands;
	}
	
	public function exploreAshlands():void {
		clearOutput();
		SceneLib.exploration.counters.ashlands++;
		doNext(camp.returnToCampUseOneHour);
		ashlandsEncounter.execEncounter();
		flushOutputTextToGUI();
	}

	private function discoverCrags():void {
		SceneLib.exploration.counters.volcanicCragOuter = 1;
		clearOutput();
		outputText("You walk for some time, roaming the ashlands. As you progress, you can feel the air getting warm. It gets hotter as you progress until you finally stumble across a blackened landscape. You reward yourself with a sight of the endless series of a volcanic landscape. Crags dot the landscape.\n\n");
		outputText("<b>You've discovered the Volcanic Crag!</b>");
		doNext(camp.returnToCampUseTwoHours);
	}

	private function findNothing():void {
		clearOutput();
		outputText("You spend one hour exploring ashlands but you don't manage to find anything interesting.");
		if (player.trainStat("tou", +1, player.trainStatCap("tou",50))) {
			outputText("But on your way back you feel you're a little more used to traveling through this harsh area.");
		}
		dynStats("tou", .5);
		doNext(camp.returnToCampUseOneHour);
	}

	private function findGranite():void {
		clearOutput();
		outputText("You stumble across a vein of Granite, this looks like suitable material for your gargoyle form.\n");
		outputText("Do you wish to mine it?");
		menu();
		addButton(0, "Yes", ahslandsSiteMine);
		addButton(1, "No", camp.returnToCampUseOneHour);
	}

	private function fireGolemEncounterFn():void {
		clearOutput();
		outputText("As you take a stroll, from behind nearby ash pile emerge huge golem. Looks like you have encountered 'true fire golem'! You ready your [weapon] for a fight!");
		startCombat(new GolemTrueFire());
	}

	public function partsofTripxiDoubleBarreledDragonGun():void {
		clearOutput();
		outputText("As you explore the ashlands you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
		outputText("You carefully put the pieces of the Double barreled dragon gun in your back and head back to your camp.\n\n");
		player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
		player.createKeyItem("Double barreled dragon gun", 0, 0, 0, 0);
		doNext(camp.returnToCampUseOneHour);
	}

	private function alrauneEncounterFn():void {
		clearOutput();
		//Alraune avoidance chance due to dangerous plants
		if (player.hasKeyItem("Dangerous Plants") >= 0 && player.inte / 2 > rand(50)) {
			outputText("You can smell the thick scent of particularly strong pollen in the air. The book mentioned something about this but you don’t recall exactly what. Do you turn back to camp?\n\n");
			menu();
			addButton(0, "Yes", camp.returnToCampUseOneHour);
			addButton(1, "No", alrauneScene.alrauneVolcanicCrag);
		} else {
			alrauneScene.alrauneVolcanicCrag();
		}
	}

	private function ahslandsSiteMine():void {
		if (Forgefather.materialsExplained != 1) doNext(camp.returnToCampUseOneHour);
		else {
			clearOutput();
			if (player.fatigue > player.maxFatigue() - 50) {
				outputText("\n\n<b>You are too tired to consider mining. Perhaps some rest will suffice?</b>");
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			outputText("\n\nYou begin slamming your pickaxe against the granite, spending the better part of the next two hours mining. This done, you bring back your prize to camp. ");
			var minedStones:Number = 13 + Math.floor(player.str / 20);
			minedStones = Math.round(minedStones);
			fatigue(50, USEFATG_PHYSICAL);
			SceneLib.forgefatherScene.incrementGraniteSupply(minedStones);
			player.mineXP(player.MiningMulti());
			findGem();
			doNext(camp.returnToCampUseTwoHours);
		}
	}
	private function findGem():void {
		if (player.miningLevel > 4) {
			if (rand(4) == 0) {
				inventory.takeItem(useables.RBYGEM, camp.returnToCampUseTwoHours);
				player.mineXP(player.MiningMulti() * 2);
			}
			else {
				outputText("After attempt to mine Rubies you ended with unusable piece.");
				doNext(camp.returnToCampUseTwoHours);
			}
		}
		else {
			outputText(" Your mining skill is too low to find any Rubies.");
			doNext(camp.returnToCampUseTwoHours);
		}
	}
}
}
