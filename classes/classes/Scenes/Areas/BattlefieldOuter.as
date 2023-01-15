/**
 * @author Ormael
 * Area with lvl 24-53 group enemies. Good for PC focused on group fights.
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
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.SceneLib;
import classes.Items.Vehicles;

use namespace CoC;
	
public class BattlefieldOuter extends BaseContent
{
	public var battlefieldEnemiesScene:BattlefieldEnemiesScenes = new BattlefieldEnemiesScenes();

	public function BattlefieldOuter()
	{
		onGameInit(init);
	}

	private var _battlefieldOuterEncounter:GroupEncounter = null;
	public function get battlefieldOuterEncounter():GroupEncounter {
		return _battlefieldOuterEncounter;
	}

	private function init():void {
		_battlefieldOuterEncounter = Encounters.group(/*{
			//Discover Inner Battlefield
			name: "discoverInner",
			chance: 30,
			when: function ():Boolean {
				return flags[kFLAGS.DISCOVERED_INNER_BATTLEFIELD] <= 0 && (player.level + combat.playerLevelAdjustment()) >= 19
			},
			call: discoverInner
		},*/ /*{
			//
			name: "",
			when: function ():Boolean {
				return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns6) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns6) == 0 && player.hasKeyItem("Twin Grakaturd") < 0 && rand(2) == 0
			},
            call: partsofTwinGrakaturd
        },*/ /*{
			//Iridesian
			name: "iridesian",
			when: function ():Boolean {
				return player.level >= 45
			},
			call:SceneLib.iridesianFollower.firstMeetingIridesian
		},*/ {
			name: "tyrantia",
			when: function ():Boolean {
				return player.level >= 45 && TyrantiaFollower.TyrantiaFollowerStage < 4 && !TyrantiaFollower.TyraniaIsRemovedFromThewGame && !player.hasStatusEffect(StatusEffects.SpoodersOff)
			},
			call: tyrantiaEncounterFn
		}, {
			//Giant slayer mech
			name: "giantmech",
			when: function ():Boolean {
				return flags[kFLAGS.WRATH_GIANT_SLAYER_GOBLIN_MECH] == 0
			},
			chance: 0.1,
			call: takeWrathMech
		}, {
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
		return flags[kFLAGS.DISCOVERED_OUTER_BATTLEFIELD] > 0;
	}
	public function timesExplored():int {
		return flags[kFLAGS.DISCOVERED_OUTER_BATTLEFIELD];
	}


	public function exploreOuterBattlefield():void {
		clearOutput();
		flags[kFLAGS.DISCOVERED_OUTER_BATTLEFIELD]++;
		doNext(camp.returnToCampUseOneHour);
		battlefieldOuterEncounter.execEncounter();
		flushOutputTextToGUI();
	}


	private function findItems():void {
		clearOutput();
		if (rand(2) == 0) {
			outputText("You spot something on the ground among various items remains. Taking a closer look, it's ");
			if (rand(2) == 0) {
				if (player.level >= 24 && rand(3) == 0) {
					outputText("a mid-grade Soulforce Recovery Pill. ");
					inventory.takeItem(consumables.MG_SFRP, camp.returnToCampUseOneHour);
				} else {
					outputText("a low-grade Soulforce Recovery Pill. ");
					inventory.takeItem(consumables.LG_SFRP, camp.returnToCampUseOneHour);
				}
			} else {
				if (player.level >= 24 && rand(3) == 0) {
					outputText("a diluted Arcane Regen Concotion. ");
					inventory.takeItem(consumables.D_ARCON, camp.returnToCampUseOneHour);
				} else {
					outputText("a very diluted Arcane Regen Concotion. ");
					inventory.takeItem(consumables.VDARCON, camp.returnToCampUseOneHour);
				}
			}
		} else {
			if (player.level >= 24 && rand(5) == 0) {
				outputText("You spot something on the ground among various items remains. Taking a closer look, it's a Heavy Spiked Shield. ");
				inventory.takeItem(shields.SPIH_SH, camp.returnToCampUseOneHour);
			} else {
				outputText("While exploring the battlefield you find the remains of some metal scraps. At first you think you won't find anything useful there but a metal plate draws your attention, it could be useful later. You put the item in your backpack and head back to camp.\n\n");
				outputText("<b>You found a metal plate.</b>");
				flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES]++;
				doNext(camp.returnToCampUseOneHour);
			}
		}
	}

	private function findNothing():void {
		clearOutput();
		if (rand(4) == 0) {
			outputText("You spend almost an hour exploring this deserted battlefield but you don't manage to find anything interesting. After checking another pile of weapons you hear some noise coming from nearby. Intrigued you cautiously approach source of it, which turns to be... " + (rand(2) == 0 ? "demons" : "imps") + ". Whole group of them running straight at you. ");
			outputText("As they approach you ready your [weapon] but... the first ones after reaching you jsut give you a short glance and just pass by. Then another one and one more pass you by almost looking like they just seen you as merely obstacle to avoid during their run. Then you hear some fragments of the words they seems to talks form time to time.\n\n");
			outputText("\"<i>...ster or the fog will catch up to u...</i>\", \"<i>...ut there is <b>SOMETHING</b> insid...</i>\", \"<i>...us..t reeee....port b...</i>\"\n\n");
			outputText("After last one of them pass you by they soon vanish into distance behind you. What just happened? Usualy laidback and horny " + (rand(2) == 0 ? "demons" : "imps") + " was actualy running away? From fog? As you thinking over it you notice something moving slightly in the direction they came. ");
			outputText("Some grey, maybe black colored shape seemly wiggling as it like moving in your direction." + (silly() ? " Oh are you approaching me?" : "") + " Bit tired and on the edge due to meeting potential enemies moments ago you decide to return this time. Maybe next time you will check out closer that 'fog' or whatever it's.");
		} else outputText("You spend an hour exploring this deserted battlefield but you don't manage to find anything interesting, yet this trip had made you a little wiser.");
		dynStats("wis", .5);
		doNext(camp.returnToCampUseOneHour);
	}

	private function tyrantiaEncounterFn():void {
		if (TyrantiaFollower.TyrantiaFollowerStage > 2) SceneLib.tyrantia.repeatEncounterBattlefield();
		else if (TyrantiaFollower.TyrantiaAffectionMeter > 40 && TyrantiaFollower.TyrantiaFollowerStage > 1) SceneLib.tyrantia.encounterBattlefieldAfter40Affection();
		else if (TyrantiaFollower.TyrantiaFollowerStage > 0) SceneLib.tyrantia.repeatEncounterBattlefield();
		else SceneLib.tyrantia.firstEncounter();
	}

	private function discoverInner():void {
		flags[kFLAGS.DISCOVERED_INNER_BATTLEFIELD] = 1;
		player.explored++;
		clearOutput();
		outputText("As you explore the boundary of the endless field, you cautiously step over countless remains of fallen and golem husks littered across the ground. Treading further, you reach a part of the battlefield you haven't seen yet. The air is thick, and it constantly feels like you're being watched by something. Perhaps the war isn't quite finished yet...\n\n<b>You've discovered the (Outer) Battlefield!</b>");
		doNext(camp.returnToCampUseOneHour);
	}

	public function takeWrathMech():void {
		clearOutput();
		outputText("As you explore the battlefield, you come up on what appears to be the wreckage of several gigantic metal armors. At least it would seem so initially. Further inspection reveals that the armor is of mechanical origin. Thanks to your goblin knowledge, you quickly identify this as a a mech model, but not one you're typically used to. ");
		outputText("A notable difference is that this suit is bipedal. It's highly damaged but with some material from the scrapyard, and a little work, you could put it back into working shape! ");
		if (player.hasStatusEffect(StatusEffects.PCDaughtersWorkshop)) {
			var item:Vehicles;
			item = vehicles.GS_MECH;
			outputText("You grab a walkie-talkie and contact your Eldest to borrow, and call her out for backup. Soon all of your kids are there with machinery and retrieval equipment, assisting in moving the large mech back to the workshop. You can't wait to get started on this project!");
			flags[kFLAGS.WRATH_GIANT_SLAYER_GOBLIN_MECH] = 1;
			inventory.takeItem(item, playerMenu);
		}
		else {
			outputText("Sadly, there's no way you could bring this back to camp by yourself without dismantling it. It's far too clunky, and without care, you could easily cause irreparable damage. You leave it be for the time being, perhaps there'll be an opportunity in the future.");
			doNext(playerMenu);
		}
	}

	/*
	public function partsofTwinGrakaturd():void {
		clearOutput();
		outputText("As you explore the (outer) battlefield, you run into what appears to be the half buried remains of an old contraption. This might just be what that gun vendor was talking about! You proceed to dig up the items realizing this to indeed be the remains of a broken firearm.\n\n");
		outputText("You carefully put the pieces of the (new firearms) in your back and head back to your camp.\n\n");
		player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
		player.createKeyItem("Twin Grakaturd", 0, 0, 0, 0);
		doNext(camp.returnToCampUseOneHour);
	}*/
}
}