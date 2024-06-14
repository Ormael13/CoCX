/**
 * @author Ormael
 * Area with lvl 24-60 group enemies. Good for PC focused on group fights.
 * Currently a Work in Progress
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Battlefield.*;
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
		_battlefieldInnerEncounter = Encounters.group("batllefieldinner",  {
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
			chance: battlefieldInnerChance,
			when: SceneLib.helScene.helSexualAmbushCondition
		}, {
			name: "etna",
			when: function ():Boolean {
				return (flags[kFLAGS.ETNA_FOLLOWER] < 1 || EtnaFollower.EtnaInfidelity == 2)
						&& flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2
						&& !player.hasStatusEffect(StatusEffects.EtnaOff)
						&& (player.level >= 20);
			},
			chance: battlefieldInnerChance,
			call: SceneLib.etnaScene.repeatYandereEnc
		},  {
			name: "nadia",
			night : false,
			when: function():Boolean {
				return flags[kFLAGS.NADIA_FOLLOWER] < 6 && !(flags[kFLAGS.NADIA_FOLLOWER] != 3 && flags[kFLAGS.NADIA_LVL_UP] >= 8) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1 && !player.hasStatusEffect(StatusEffects.NadiaOff);
			},
			chance: battlefieldInnerChance,
			call: SceneLib.nadiaScene.repeatEnc
		}, {
			name: "nadiaName",
			night : false,
			when: function():Boolean {
				return ((flags[kFLAGS.NADIA_FOLLOWER] < 3 || flags[kFLAGS.NADIA_FOLLOWER] == 5) && flags[kFLAGS.NADIA_LVL_UP] >= 8) && !player.hasStatusEffect(StatusEffects.NadiaOff) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1;
			},
			chance: battlefieldInnerChance,
			call: SceneLib.nadiaScene.postNameEnc
		}, {
			name: "ted",
			call: SceneLib.tedScene.introPostHiddenCave,
			when: SceneLib.tedScene.canEncounterTed
		}, SceneLib.exploration.commonEncounters.withChanceFactor(0.1), {
			//General Golems, Goblin and Imp Encounters
			name: "vengefulAparitions",
			chance: 0.4,
			call: battlefieldEnemiesScene.encounterVengefulApparitions
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
	
	public function battlefieldInnerChance():Number {
		var temp:Number = 0.5;
		temp *= player.npcChanceToEncounter();
		return temp;
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
			CampStatsAndResources.MetalPieces++;
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
