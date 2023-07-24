/**
 * Created by Kitteh6660.
 * Volcanic Crag is a area with level 70-100 (outer) or 105-140 (inner) encounters
 * This zone was mentioned in Glacial Rift doc.
 */

package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.HighMountains.PhoenixScene;
import classes.Scenes.Areas.VolcanicCrag.*;
import classes.Scenes.Dungeons.DemonLab;
import classes.Scenes.Holidays;
import classes.Scenes.NPCs.EtnaFollower;
import classes.Scenes.SceneLib;

public class VolcanicCrag extends BaseContent
	{
		public var behemothScene:BehemothScene = new BehemothScene();
		public var phoenixScene:PhoenixScene = new PhoenixScene();
		
		public function VolcanicCrag() {
			onGameInit(init);
		}

		private var _volcanicCragEncounter:GroupEncounter = null;
		public function get volcanicCragEncounter():GroupEncounter {
			return _volcanicCragEncounter;
		}

		private function init():void {
			_volcanicCragEncounter = Encounters.group("volcaniccrag", {
				name: "gunparts",
				label : "Gun Parts",
				kind  : 'item',
				unique: true,
				when: function ():Boolean {
					return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns3) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns3) == 0 && player.hasKeyItem("Tripxi Fatbilly") < 0
				},
				chance: 30,
				call: partsofTripxiFatbilly
			}, {
				name: "aprilfools",
				label : "Extreme Zones DLC",
				kind  : 'event',
				unique: true,
				when: function ():Boolean {
					return isAprilFools() && flags[kFLAGS.DLC_APRIL_FOOLS] == 0
				},
				call: function ():void {
					SceneLib.holidays.DLCPrompt("Extreme Zones DLC", "Get the Extreme Zones DLC to be able to visit Glacial Rift and Volcanic Crag and discover the realms within!", "$4.99");
				}
			}, {
				name: "forgefather1",
				label : "Forgefather",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return ((player.hasPerk(PerkLib.GargoylePure) || player.hasPerk(PerkLib.GargoyleCorrupted)) && flags[kFLAGS.FORGEFATHER_MOVED_TO_TEMPLE] != 1) && flags[kFLAGS.MET_FORGEFATHER] == 0
				},
				call: function ():void {
					VolcanicCragConditions();
					SceneLib.forgefatherScene.meetForgefather();
				}
			}, {
				name: "forgefather2",
				label : "Forgefather",
				kind  : 'npc',
				unique: true,
				when: function ():Boolean {
					return ((player.hasPerk(PerkLib.GargoylePure) || player.hasPerk(PerkLib.GargoyleCorrupted)) && flags[kFLAGS.FORGEFATHER_MOVED_TO_TEMPLE] != 1) && flags[kFLAGS.MET_FORGEFATHER] > 0
				},
				call: function ():void {
					VolcanicCragConditions();
					SceneLib.forgefatherScene.repeatForgefather();
				}
			}, {
				name: "nothing",
				call: findNothing,
				label:'Walk',
				kind:'walk'
			}, {
				name: "finddrakeheart",
				label : "Drake Heart",
				kind  : 'item',
				call: findDrakeHeart
			}, {
				name: "truefiregolem",
				label : "True Fire Golems",
				kind : 'monster',
				call: fireGolemEncounter
			}, /*{//Magma Slime
				name: "",
				when: function ():Boolean {
					return
				},
				call: function ():void {
					VolcanicCragConditions();

				}
			},*/ {
				name: "phoenix",
				label : "Quasi-Phoenix",
				kind  : 'monster',
				when: function ():Boolean {
					return flags[kFLAGS.HEL_PHOENIXES_DEFEATED] > 0
				},
				night: false,
				call: function ():void {
					VolcanicCragConditions();
					phoenixScene.encounterPhoenix(2);
				}
			}, {
				name: "behemoth",
				label : "Behemoth",
				kind : 'monster',
				call: behemothScene.behemothIntro
			}, {
				//Helia monogamy fucks
				name  : "helcommon",
				label : "Helia",
				kind  : 'npc',
				unique: true,
				night : false,
				call  : function ():void {
					VolcanicCragConditions();
					SceneLib.helScene.helSexualAmbush();
				},
				chance: volcanicCragChance,
				when  : SceneLib.helScene.helSexualAmbushCondition
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
				chance: volcanicCragChance,
				call: function ():void {
					VolcanicCragConditions();
					SceneLib.etnaScene.repeatYandereEnc();
				}
			}/*, {
				name: "demonProjects",
				chance: 0.2,
				when: function ():Boolean {
					return DemonLab.MainAreaComplete >= 4;
				},
				call: function ():void {
					VolcanicCragConditions();
					SceneLib.exploration.demonLabProjectEncounters()
				}
			}*/);
		}
		
		public function exploreVolcanicCrag():void {
			flags[kFLAGS.DISCOVERED_VOLCANO_CRAG]++;
			if (!player.hasPerk(PerkLib.FireAffinity) && !player.hasPerk(PerkLib.AffinityIgnis)) ConstantHeatConditionsTick();
			doNext(camp.returnToCampUseOneHour);
			volcanicCragEncounter.execEncounter();
			flushOutputTextToGUI();
		}

		public function volcanicCragChance():Number {
			var temp:Number = 0.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}

		private function findNothing():void {
			clearOutput();
			outputText("You spend one hour exploring the infernal landscape but you don't manage to find anything interesting.");
			if (player.canTrain('spe', player.trainStatCap("spe",50))) {
				outputText(" Despite this you this time you managed walk a little further inside this place than the last time.");
				player.trainStat("spe", +1, player.trainStatCap("spe",50));
			}
			dynStats("spe", .5);
			doNext(camp.returnToCampUseOneHour);
		}

		private function findDrakeHeart():void {
			clearOutput();
			outputText("While you're minding your own business, you spot a flower. You walk over to it, pick it up and smell it. By Marae, it smells amazing! It looks like Drake's Heart as the legends foretold. ");
			inventory.takeItem(consumables.DRAKHRT, camp.returnToCampUseOneHour);
		}

		private function fireGolemEncounter():void {
			clearOutput();
			outputText("As you take a stroll, from nearby cracks emerge group of golems. Looks like you have encountered some true fire golems! You ready your [weapon] for a fight!");
			VolcanicCragConditions();
			startCombat(new GolemsTrueFire());
		}

		public function VolcanicCragConditions():void {
			if (!player.hasPerk(PerkLib.FireAffinity) && !player.hasPerk(PerkLib.AffinityIgnis)) player.createStatusEffect(StatusEffects.ConstantHeatConditions,0,0,0,0);
		}

		public function ConstantHeatConditionsTick():void {
			var HPD:Number = 0.05;
			if (player.hasPerk(PerkLib.ColdAffinity)) HPD *= 2;
			HPD *= player.maxHP();
			HPD = Math.round(HPD);
			outputText("Hot environment slowly seeps into your body. ");
			player.takeFireDamage(HPD, true);
			outputText("\n\n");
		}
		
		public function partsofTripxiFatbilly():void {
			clearOutput();
			outputText("As you explore the vulcanic crag you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Tripxi Fatbilly in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Tripxi Fatbilly", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}

	}
}
