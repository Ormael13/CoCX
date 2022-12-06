/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Plains.*;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class Plains extends BaseContent
	{
		public var bunnyGirl:BunnyGirl = new BunnyGirl();
		public var gnollScene:GnollScene = new GnollScene();
		public var gnollSpearThrowerScene:GnollSpearThrowerScene = new GnollSpearThrowerScene();
		public var satyrScene:SatyrScene = new SatyrScene();

		public function Plains()
		{
			onGameInit(init);
		}
		public function discover():void {
			flags[kFLAGS.TIMES_EXPLORED_PLAINS] = 1;
			outputText(images.showImage("area-plain"));
			outputText("You find yourself standing in knee-high grass, surrounded by flat plains on all sides.  Though the mountain, forest, and lake are all visible from here, they seem quite distant.\n\n<b>You've discovered the plains!</b>");
			doNext(camp.returnToCampUseOneHour);
		}

		private var explorationEncounter:GroupEncounter = null;

		private function init():void {
			const fn:FnHelpers = Encounters.fn;
			explorationEncounter = Encounters.group(/*SceneLib.commonEncounters,*/ {
				//General Golems, Goblin and Imp Encounters
				name: "common",
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.exploration.genericGolGobImpEncounters();
				}
			}, {/*
				//General Angels Encounters
				name: "common",
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.exploration.genericAngelsEncounters();
				}
			}, {*/
				//Helia monogamy fucks
				name  : "helcommon",
				night : false,
				call  : function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.helScene.helSexualAmbush();
				},
				chance: 0.2,
				when  : SceneLib.helScene.helSexualAmbushCondition
			}, {
				name: "etna",
				when: function ():Boolean {
					return flags[kFLAGS.ETNA_FOLLOWER] < 1
						   && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2
						   && !player.hasStatusEffect(StatusEffects.EtnaOff)
						   && (player.level >= 20);
				},
				chance: 0.5,
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.etnaScene.repeatYandereEnc();
				}
			}, {
				name: "electra",
				night : false,
				when: function():Boolean {
					return flags[kFLAGS.ELECTRA_FOLLOWER] < 2 && flags[kFLAGS.ELECTRA_AFFECTION] >= 2 && !player.hasStatusEffect(StatusEffects.ElectraOff) && (player.level >= 20);
				},
				chance: 0.5,
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					if (flags[kFLAGS.ELECTRA_AFFECTION] == 100) {
						if (flags[kFLAGS.ELECTRA_FOLLOWER] == 1) SceneLib.electraScene.ElectraRecruitingAgain();
						else SceneLib.electraScene.ElectraRecruiting();
					}
					else SceneLib.electraScene.repeatPlainsEnc();
				}
			}, {
				name  : "werewolfFemale",
				day : false,
				call  : function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.werewolfFemaleScene.introWerewolfFemale();
				},
				chance: 0.50
			}, {
				name: "sidonie",
				night : false,
				when: function ():Boolean {
					return flags[kFLAGS.SIDONIE_FOLLOWER] < 1
						   && flags[kFLAGS.SIDONIE_RECOLLECTION] < 1;
				},
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.sidonieFollower.meetingSidonieAtPlains();
				}
			}, {
				name: "diana",
				night : false,
				when: function():Boolean {
					return flags[kFLAGS.DIANA_FOLLOWER] < 6 && !(flags[kFLAGS.DIANA_FOLLOWER] != 3 && flags[kFLAGS.DIANA_LVL_UP] >= 8) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1 && !player.hasStatusEffect(StatusEffects.DianaOff);
				},
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.dianaScene.repeatEnc();
				}
			}, {
				name: "dianaName",
				night : false,
				when: function():Boolean {
					return ((flags[kFLAGS.DIANA_FOLLOWER] < 3 || flags[kFLAGS.DIANA_FOLLOWER] == 5) && flags[kFLAGS.DIANA_LVL_UP] >= 8) && !player.hasStatusEffect(StatusEffects.DianaOff) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1;
				},
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.dianaScene.postNameEnc();
				}
			}, {
				//Dem Kangasluts!  Force Sheila relationship phase!
				name  : "sheila_xp3",
				night : false,
				chance: Encounters.ALWAYS,
				when  : function ():Boolean {
					return flags[kFLAGS.SHEILA_DEMON] == 0
						   && flags[kFLAGS.SHEILA_XP] == 3
						   && model.time.hours == 20
						   && flags[kFLAGS.SHEILA_CLOCK] >= 0;
				},
				call  : function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.sheilaScene.sheilaXPThreeSexyTime();
				}
			}, {
				//Add some holiday cheer
				name: "candy_cane",
				when: function ():Boolean {
					return isChristmas() && date.fullYear > flags[kFLAGS.CANDY_CANE_YEAR_MET];
				},
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.holidays.candyCaneTrapDiscovery();
				}
			}, {
				name: "polar_pete",
				when: function ():Boolean {
					return isChristmas() && date.fullYear > flags[kFLAGS.POLAR_PETE_YEAR_MET];
				},
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.holidays.polarPete();
				}
			}, {
				//Find Niamh
				name: "niamh",
				night : false,
				when: function ():Boolean {
					return flags[kFLAGS.NIAMH_MOVED_OUT_COUNTER] == 1
				},
				call: SceneLib.telAdre.niamh.niamhPostTelAdreMoveOut
			}, {
				name  : "owca",
				night : false,
				chance: 0.3,
				when  : function ():Boolean {
					return flags[kFLAGS.OWCA_UNLOCKED] == 0;
				},
				mods  : [fn.ifLevelMin(24)],
				call  : function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.owca.gangbangVillageStuff();
				}
			}, {
				name: "bazaar",
				when: function ():Boolean {
					return flags[kFLAGS.BAZAAR_ENTERED] == 0;
				},
				call: SceneLib.bazaar.findBazaar
			}, {
				name  : "helXizzy",
				night : false,
				chance: 0.2,
				when  : function ():Boolean {
					return flags[kFLAGS.ISABELLA_CAMP_APPROACHED] != 0
						   && flags[kFLAGS.ISABELLA_MET] != 0
						   && flags[kFLAGS.HEL_FUCKBUDDY] == 1
						   && flags[kFLAGS.ISABELLA_ANGRY_AT_PC_COUNTER] == 0
						   && !SceneLib.isabellaFollowerScene.isabellaFollower()
						   && (player.tallness <= 78 || flags[kFLAGS.ISABELLA_OKAY_WITH_TALL_FOLKS])
				},
				call  : SceneLib.helScene.helXIzzy
			}, {
				name  : "ovielix",
				call  : findOviElix,
				chance: 0.5
			}, {
				name  : "kangaft",
				call  : findKangaFruit,
				chance: 0.5
			}, {
				name  : "gnoll",
				night : false,
				chance: 0.7,
				call  : function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					gnollSpearThrowerScene.gnoll2Encounter();
				}
			}, {
				name  : "gnoll2",
				night : false,
				chance: 0.7,
				call  : function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					gnollScene.gnollEncounter();
				}
			}, {
				name: "bunny",
				night : false,
				chance: 0.3,
				call: bunnyGirl.bunnbunbunMeet
			}, {
				name: "isabella",
				night : false,
				when: function ():Boolean {
					return flags[kFLAGS.ISABELLA_PLAINS_DISABLED] == 0
				},
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.isabellaScene.isabellaGreeting();
				}
			}, {
				name  : "helia",
				night : false,
				chance: function ():Number {
					return flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE] ? 0.75 : 1.5;
				},
				when  : function ():Boolean {
					return !SceneLib.helScene.followerHel();
				},
				call  : function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.helScene.encounterAJerkInThePlains();
				}
			}, {
				name: "ted",
				when: function():Boolean {
					return flags[kFLAGS.TED_LVL_UP] >= 1 && flags[kFLAGS.TED_LVL_UP] < 2 && !player.hasStatusEffect(StatusEffects.TedOff) && player.statusEffectv1(StatusEffects.CampSparingNpcsTimers4) < 1;
				},
				call: SceneLib.tedScene.introPostHiddenCave
			}, {
				name: "snippler",
				when: function ():Boolean {
					return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns4) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns4) == 0 && player.hasKeyItem("Snippler") < 0;
				},
				chance: 30,
				call: partsofSnippler
			},{
				name: "satyr",
				night : false,
				chance: 0.7,
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					satyrScene.satyrEncounter();
				}
			}, {
				name: "sheila",
				night : false,
				when: function ():Boolean {
					return flags[kFLAGS.SHEILA_DISABLED] == 0 && flags[kFLAGS.SHEILA_CLOCK] >= 0
				},
				chance: 0.5,
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearbyPlants, 0, 0, 0, 0);
					SceneLib.sheilaScene.sheilaEncounterRouter();
				}
			});
		}
		public function explorePlains():void {
			clearOutput();
			flags[kFLAGS.TIMES_EXPLORED_PLAINS]++;
			explorationEncounter.execEncounter();
		}
		public function partsofSnippler():void {
			clearOutput();
			outputText("As you explore the plains you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Snippler in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Snippler", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}
		private function findKangaFruit():void {
			outputText(images.showImage("item-kFruit"));
			outputText("While exploring the plains you come across a strange-looking plant.  As you peer at it, you realize it has some fruit you can get at.  ");
			inventory.takeItem(consumables.KANGAFT, camp.returnToCampUseOneHour);
		}
		private function findOviElix():void {
			outputText(images.showImage("item-oElixir"));
			outputText("While exploring the plains you nearly trip over a discarded, hexagonal bottle.  ");
			inventory.takeItem(consumables.OVIELIX, camp.returnToCampUseOneHour);
		}
	}
}