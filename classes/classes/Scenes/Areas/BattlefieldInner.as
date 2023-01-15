/**
 * @author Ormael
 * Area with lvl 24-60 group enemies. Good for PC focused on group fights.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Battlefield.*;
import classes.Scenes.Dungeons.DemonLab;
import classes.Scenes.NPCs.EtnaFollower;
import classes.Scenes.SceneLib;

use namespace CoC;

public class BattlefieldInner extends BaseContent
{
	public var battlefieldEnemiesScene:BattlefieldEnemiesScenes = new BattlefieldEnemiesScenes();

	public function BattlefieldInner()
	{
		onGameInit(init);
	}

	private var _battlefieldInnerEncounter:GroupEncounter = null;
	public function get battlefieldInnerEncounter():GroupEncounter {
		return _battlefieldInnerEncounter;
	}

	private function init():void {
		_battlefieldInnerEncounter = Encounters.group( {
			name: "items",
			call: findItems
		}, {
			name: "nothing",
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
			chance: 0.5,
			call: SceneLib.etnaScene.repeatYandereEnc
		},  {
			name: "diana",
			night : false,
			when: function():Boolean {
				return flags[kFLAGS.DIANA_FOLLOWER] < 6 && !(flags[kFLAGS.DIANA_FOLLOWER] != 3 && flags[kFLAGS.DIANA_LVL_UP] >= 8) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1 && !player.hasStatusEffect(StatusEffects.DianaOff);
			},
			chance: 0.5,
			call: SceneLib.dianaScene.repeatEnc
		}, {
			name: "dianaName",
			night : false,
			when: function():Boolean {
				return ((flags[kFLAGS.DIANA_FOLLOWER] < 3 || flags[kFLAGS.DIANA_FOLLOWER] == 5) && flags[kFLAGS.DIANA_LVL_UP] >= 8) && !player.hasStatusEffect(StatusEffects.DianaOff) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1;
			},
			chance: 0.5,
			call: SceneLib.dianaScene.postNameEnc
		}, {
			name: "ted",
			call: SceneLib.tedScene.introPostHiddenCave,
			when: SceneLib.tedScene.canEncounterTed
		}, {
			//General Golems, Goblin and Imp Encounters
			name: "common",
			chance: 0.4,
			call: SceneLib.exploration.genericGolGobImpEncounters
		}, {
			//General Golems, Goblin and Imp Encounters
			name: "vengefulAparitions",
			chance: 0.4,
			call: battlefieldEnemiesScene.encounterVengefulApparitions
		}, {
			name: "demonProjects",
			chance: 0.2,
			when: function ():Boolean {
				return DemonLab.MainAreaComplete >= 4;
			},
			call: SceneLib.exploration.demonLabProjectEncounters
		});
	}

	public function isDiscovered():Boolean {
		return flags[kFLAGS.DISCOVERED_INNER_BATTLEFIELD] > 0;
	}
	public function timesExplored():int {
		return flags[kFLAGS.DISCOVERED_INNER_BATTLEFIELD];
	}

	public function exploreInnerBattlefield():void {
		clearOutput();
		flags[kFLAGS.DISCOVERED_INNER_BATTLEFIELD]++;
		doNext(camp.returnToCampUseOneHour);
		battlefieldInnerEncounter.execEncounter();
		flushOutputTextToGUI();
	}

	private function findNothing():void {
		clearOutput();
		outputText("You spend one hour exploring this deserted battlefield but you don't manage to find anything interesting. Yet this trip made you become a little bit more wise.");
		dynStats("wis", 1);
		doNext(camp.returnToCampUseOneHour);
	}

	private function findItems():void {
		clearOutput();
		if (rand(2) == 0) {
			outputText("While exploring the battlefield you find the remains of some metal scraps. At first you think you won't find anything useful there but a metal plate draws your attention, it could be useful later. You put the item in your backpack and head back to camp.\n\n");
			outputText("<b>You found a metal plate.</b>");
			flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES]++;
			doNext(camp.returnToCampUseOneHour);
		} else {
			outputText("You spot something on the ground among various items remains. Taking a closer look, it's ");
			if (rand(2) == 0) {
				if (player.level >= 48 && rand(3) == 0) {
					outputText("a high-grade Soulforce Recovery Pill. ");
					inventory.takeItem(consumables.HG_SFRP, camp.returnToCampUseOneHour);
				} else {
					outputText("a mid-grade Soulforce Recovery Pill. ");
					inventory.takeItem(consumables.MG_SFRP, camp.returnToCampUseOneHour);
				}
			} else {
				if (player.level >= 48 && rand(3) == 0) {
					outputText("an Arcane Regen Concotion. ");
					inventory.takeItem(consumables.AREGCON, camp.returnToCampUseOneHour);
				} else {
					outputText("a diluted Arcane Regen Concotion. ");
					inventory.takeItem(consumables.D_ARCON, camp.returnToCampUseOneHour);
				}
			}
		}
	}
}
}