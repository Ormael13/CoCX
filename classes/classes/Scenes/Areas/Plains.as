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
import classes.Scenes.Holidays;
import classes.Scenes.NPCs.SidonieFollower;
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
		public function isDiscovered():Boolean {
			return flags[kFLAGS.TIMES_EXPLORED_PLAINS] > 0;
		}
		public function discover():void {
			flags[kFLAGS.TIMES_EXPLORED_PLAINS] = 1;
			outputText(images.showImage("area-plain"));
			outputText("You find yourself standing in knee-high grass, surrounded by flat plains on all sides.  Though the mountain, forest, and lake are all visible from here, they seem quite distant.\n\n<b>You've discovered the plains!</b>");
			doNext(camp.returnToCampUseOneHour);
		}

		private var explorationEncounter:GroupEncounter = null;

		private function init():void {
			const game:CoC     = CoC.instance;
			const fn:FnHelpers = Encounters.fn;
			explorationEncounter = Encounters.group(/*SceneLib.commonEncounters,*/ {
				//General Golems, Goblin and Imp Encounters
				name: "common",
				call: SceneLib.exploration.genericGolGobImpEncounters
			}, {
				//Helia monogamy fucks
				name  : "helcommon",
				call  : SceneLib.helScene.helSexualAmbush,
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
				call: SceneLib.etnaScene.repeatYandereEnc
			}, {
				name: "electra",
				when: function():Boolean {
					return flags[kFLAGS.ELECTRA_FOLLOWER] < 2 && flags[kFLAGS.ELECTRA_AFFECTION] >= 2 && !player.hasStatusEffect(StatusEffects.ElectraOff) && (player.level >= 20);
				},
				chance: 0.5,
				call: function ():void {
					if (flags[kFLAGS.ELECTRA_AFFECTION] == 100) {
						if (flags[kFLAGS.ELECTRA_FOLLOWER] == 1) SceneLib.electraScene.ElectraRecruitingAgain();
						else SceneLib.electraScene.ElectraRecruiting();
					}
					else SceneLib.electraScene.repeatPlainsEnc();
				}
			}, {
				name: "sidonie",
				when: function ():Boolean {
					return flags[kFLAGS.SIDONIE_FOLLOWER] < 1
						   && flags[kFLAGS.SIDONIE_RECOLLECTION] < 1;
				},
				call: SceneLib.sidonieFollower.meetingSidonieAtPlains
			}, {
				name: "diana",
				when: function():Boolean {
					return flags[kFLAGS.DIANA_FOLLOWER] < 6 && !player.hasStatusEffect(StatusEffects.DianaOff) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1;
				},
				call: SceneLib.dianaScene.repeatPlainsEnc
			}, {
				//Dem Kangasluts!  Force Sheila relationship phase!
				name  : "sheila_xp3",
				chance: Encounters.ALWAYS,
				when  : function ():Boolean {
					return flags[kFLAGS.SHEILA_DEMON] == 0
						   && flags[kFLAGS.SHEILA_XP] == 3
						   && model.time.hours == 20
						   && flags[kFLAGS.SHEILA_CLOCK] >= 0;
				},
				call  : SceneLib.sheilaScene.sheilaXPThreeSexyTime
			}, {
				//Add some holiday cheer
				name: "candy_cane",
				when: function ():Boolean {
					return isHolidays() && date.fullYear > flags[kFLAGS.CANDY_CANE_YEAR_MET];
				},
				call: Holidays.candyCaneTrapDiscovery
			}, {
				name: "polar_pete",
				when: function ():Boolean {
					return isHolidays() && date.fullYear > flags[kFLAGS.POLAR_PETE_YEAR_MET];
				},
				call: Holidays.polarPete
			}, {
				//Find Niamh
				name: "niamh",
				when: function ():Boolean {
					return flags[kFLAGS.NIAMH_MOVED_OUT_COUNTER] == 1
				},
				call: SceneLib.telAdre.niamh.niamhPostTelAdreMoveOut
			}, {
				name  : "owca",
				chance: 0.3,
				when  : function ():Boolean {
					return flags[kFLAGS.OWCA_UNLOCKED] == 0;
				},
				mods  : [fn.ifLevelMin(24)],
				call  : SceneLib.owca.gangbangVillageStuff
			}, {
				name: "bazaar",
				when: function ():Boolean {
					return flags[kFLAGS.BAZAAR_ENTERED] == 0;
				},
				call: SceneLib.bazaar.findBazaar
			}, {
				name  : "helXizzy",
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
				chance: 0.7,
				call  : gnollSpearThrowerScene.gnoll2Encounter
			}, {
				name  : "gnoll2",
				chance: 0.7,
				call  : gnollScene.gnollEncounter
			}, {
				name: "bunny",
				chance: 0.3,
				call: bunnyGirl.bunnbunbunMeet
			}, {
				name: "isabella",
				when: function ():Boolean {
					return flags[kFLAGS.ISABELLA_PLAINS_DISABLED] == 0
				},
				call: SceneLib.isabellaScene.isabellaGreeting
			}, {
				name  : "helia",
				chance: function ():Number {
					return flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE] ? 0.75 : 1.5;
				},
				when  : function ():Boolean {
					return !SceneLib.helScene.followerHel();
				},
				call  : SceneLib.helScene.encounterAJerkInThePlains
			}, {
				name: "ted",
				when: function():Boolean {
					return flags[kFLAGS.TED_LVL_UP] >= 1 && flags[kFLAGS.TED_LVL_UP] < 4 && !player.hasStatusEffect(StatusEffects.TedOff) && player.statusEffectv1(StatusEffects.CampSparingNpcsTimers4) < 1;
				},
				call: SceneLib.tedScene.introPostHiddenCave
			},{
				name: "satyr",
				chance: 0.7,
				call: satyrScene.satyrEncounter
			}, {
				name: "sheila",
				when: function ():Boolean {
					return flags[kFLAGS.SHEILA_DISABLED] == 0 && flags[kFLAGS.SHEILA_CLOCK] >= 0
				},
				chance: 0.5,
				call: SceneLib.sheilaScene.sheilaEncounterRouter
			});
		}
		public function explorePlains():void {
			clearOutput();
			flags[kFLAGS.TIMES_EXPLORED_PLAINS]++;
			explorationEncounter.execEncounter();
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
