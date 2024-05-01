/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.FnHelpers;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Plains.*;
import classes.Scenes.NPCs.EtnaFollower;
import classes.Scenes.SceneLib;

use namespace CoC;

	public class Plains extends BaseContent
	{
		public var bunnyGirl:BunnyGirl = new BunnyGirl();
		public var gnollScene:GnollScene = new GnollScene();
		public var gnollSpearThrowerScene:GnollSpearThrowerScene = new GnollSpearThrowerScene();
		public var satyrScene:SatyrScene = new SatyrScene();
		
		public const areaLevel:int = 9;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.plains > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= areaLevel && SceneLib.mountain.isDiscoveredHills();
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.plains;
		}
		public function discover():void {
			clearOutput();
			SceneLib.exploration.counters.plains = 1;
			outputText("You find yourself standing in knee-high grass, surrounded by flat plains on all sides.  Though the mountain, forest, and lake are all visible from here, they seem quite distant.\n\n<b>You've discovered the plains!</b>");
			endEncounter(60);
		}
		
		
		public function Plains()
		{
			onGameInit(init);
		}

		private var explorationEncounter:GroupEncounter = null;

		private function init():void {
			const fn:FnHelpers = Encounters.fn;
			explorationEncounter = Encounters.group(/*SceneLib.commonEncounters,*/
					SceneLib.exploration.commonEncounters.withChanceFactor(0.1),
					SceneLib.exploration.angelEncounters.withChanceFactor(0.05),
			{
				//Helia monogamy fucks
				name  : "helcommon",
				label : "Helia",
				kind  : 'npc',
				unique: true,
				night : false,
				call  : SceneLib.helScene.helSexualAmbush,
				chance: plainsChance,
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
				chance: plainsChance,
				call: SceneLib.etnaScene.repeatYandereEnc
			}, {
				name: "electra",
				label : "Electra",
				kind  : 'npc',
				unique: true,
				night : false,
				when: function():Boolean {
					return flags[kFLAGS.ELECTRA_FOLLOWER] < 2 && flags[kFLAGS.ELECTRA_AFFECTION] >= 2 && !player.hasStatusEffect(StatusEffects.ElectraOff) && (player.level >= 20);
				},
				chance: plainsChance,
				call: function ():void {
					if (flags[kFLAGS.ELECTRA_AFFECTION] == 100) {
						if (flags[kFLAGS.ELECTRA_FOLLOWER] == 1) SceneLib.electraScene.ElectraRecruitingAgain();
						else SceneLib.electraScene.ElectraRecruiting();
					}
					else SceneLib.electraScene.repeatPlainsEnc();
				}
			}, {
				name  : "werewolfFemale",
				label : "Werewolf (F)",
				kind : 'monster',
				day : false,
				call  : SceneLib.werewolfFemaleScene.introWerewolfFemale,
				chance: 0.50
			}, {
				name: "sidonie",
				label : "Sidonie",
				kind  : 'npc',
				unique: true,
				night : false,
				when: function ():Boolean {
					return flags[kFLAGS.SIDONIE_FOLLOWER] < 1
						   && flags[kFLAGS.SIDONIE_RECOLLECTION] < 1;
				},
				chance: plainsChance,
				call: SceneLib.sidonieFollower.meetingSidonieAtPlains
			}, {
				name: "nadia",
				label : "Nadia",
				kind  : 'npc',
				unique: true,
				night : false,
				when: function():Boolean {
					return flags[kFLAGS.NADIA_FOLLOWER] < 6 && !(flags[kFLAGS.NADIA_FOLLOWER] != 3 && flags[kFLAGS.NADIA_LVL_UP] >= 8) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1 && !player.hasStatusEffect(StatusEffects.NadiaOff);
				},
				chance: plainsChance,
				call: SceneLib.nadiaScene.repeatEnc
			}, {
				name: "nadiaName",
				label : "Nadia",
				kind  : 'npc',
				unique: true,
				night : false,
				when: function():Boolean {
					return ((flags[kFLAGS.NADIA_FOLLOWER] < 3 || flags[kFLAGS.NADIA_FOLLOWER] == 5) && flags[kFLAGS.NADIA_LVL_UP] >= 8) && !player.hasStatusEffect(StatusEffects.NadiaOff) && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1;
				},
				chance: plainsChance,
				call: SceneLib.nadiaScene.postNameEnc
			}, {
				//Dem Kangasluts!  Force Sheila relationship phase!
				name  : "sheila_xp3",
				label : "Sheila",
				kind  : 'npc',
				unique: true,
				night : false,
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
				label : "Candy Cane",
				kind  : 'event',
				unique: true,
				when: function ():Boolean {
					return isChristmas() && date.fullYear > flags[kFLAGS.CANDY_CANE_YEAR_MET];
				},
				call: SceneLib.holidays.candyCaneTrapDiscovery
			}, {
				name: "polar_pete",
				label : "Polar Pete",
				kind  : 'event',
				unique: true,
				when: function ():Boolean {
					return isChristmas() && date.fullYear > flags[kFLAGS.POLAR_PETE_YEAR_MET];
				},
				call: SceneLib.holidays.polarPete
			}, {
				//Find Niamh
				name: "niamh",
				label : "Niamh",
				kind  : 'npc',
				unique: true,
				night : false,
				when: function ():Boolean {
					return flags[kFLAGS.NIAMH_MOVED_OUT_COUNTER] == 1
				},
				call: SceneLib.telAdre.niamh.niamhPostTelAdreMoveOut
			}, {
				name  : "owca",
				label : "Owca",
				kind  : 'place',
				unique: true,
				night : false,
				chance: 0.3,
				when  : function ():Boolean {
					return flags[kFLAGS.OWCA_UNLOCKED] == 0;
				},
				mods  : [fn.ifLevelMin(24)],
				call  : SceneLib.owca.gangbangVillageStuff
			}, {
				name  : "helXizzy",
				label : "Hel x Izzy",
				kind  : 'event',
				unique: true,
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
				label : "Items",
				kind  : 'item',
				call  : findOviElix,
				chance: 0.5
			}, {
				name  : "kangaft",
				label : "Items",
				kind  : 'item',
				call  : findKangaFruit,
				chance: 0.5
			}, {
				name  : "gnoll",
				label : "Gnoll",
				kind : 'monster',
				night : false,
				chance: 0.7,
				call  : gnollSpearThrowerScene.gnoll2Encounter
			}, {
				name  : "gnoll2",
				label : "Gnoll",
				kind : 'monster',
				night : false,
				chance: 0.7,
				call  : gnollScene.gnollEncounter
			}, {
				name: "bunny",
				label : "Bunny",
				kind : 'event',
				night : false,
				chance: 0.3,
				call: bunnyGirl.bunnbunbunMeet
			}, {
				name: "usagi",
				label : "Usagi",
				kind : 'npc',
				unique: true,
				night : false,
				when: function ():Boolean { return SceneLib.loppe.canEncounterUsagi() },
				chance: 0.3,
				call: SceneLib.loppe.encounterUsagi
			}, {
				name: "isabella",
				label : "Isabella",
				kind  : 'npc',
				unique: true,
				night : false,
				when: function ():Boolean {
					return flags[kFLAGS.ISABELLA_PLAINS_DISABLED] == 0
				},
				chance: plainsChance,
				call: SceneLib.isabellaScene.isabellaGreeting
			}, {
				name  : "helia",
				label : "Helia",
				kind  : 'npc',
				unique: true,
				night : false,
				chance: function ():Number {
					return flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE] ? (0.75 * player.npcChanceToEncounter()) : (1.5 * player.npcChanceToEncounter());
				},
				when  : function ():Boolean {
					return !SceneLib.helScene.followerHel() && !player.hasStatusEffect(StatusEffects.HeliaOff);
				},
				call  : SceneLib.helScene.encounterAJerkInThePlains
			}, {
				name: "ted",
				label : "Dragon-Boy",
				kind  : 'npc',
				unique: true,
				when: function():Boolean {
					return flags[kFLAGS.TED_LVL_UP] >= 1 && flags[kFLAGS.TED_LVL_UP] < 2 && !player.hasStatusEffect(StatusEffects.TedOff) && player.statusEffectv1(StatusEffects.CampSparingNpcsTimers4) < 1;
				},
				call: SceneLib.tedScene.introPostHiddenCave
			}, {
				name: "snippler",
				label : "Gun Parts",
				kind  : 'item',
				unique: true,
				when: function ():Boolean {
					return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns4) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns4) == 0 && player.hasKeyItem("Snippler") < 0;
				},
				chance: 30,
				call: partsofSnippler
			}, {
				name: "LWoodenBow",
				label : "L.Wooden Bow",
				kind  : 'item',
				chance: 0.2,
				unique: true,
				when: function():Boolean {
					return !player.hasStatusEffect(StatusEffects.TookSagittariusBanefulGreatBow);
				},
				call: findSagittariusBanefulGreatBow
			},{
				name: "satyr",
				label : "Satyr",
				kind : 'event',
				night : false,
				chance: 0.7,
				call: satyrScene.satyrEncounter
			}, {
				name: "sheila",
				label : "Sheila",
				kind  : 'npc',
				unique: true,
				night : false,
				when: function ():Boolean {
					return flags[kFLAGS.SHEILA_DISABLED] == 0 && flags[kFLAGS.SHEILA_CLOCK] >= 0
				},
				chance: 0.5,
				call: SceneLib.sheilaScene.sheilaEncounterRouter
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
		public function explorePlains():void {
			explorer.prepareArea(explorationEncounter);
			explorer.setTags("plains", "plants");
			explorer.prompt = "You explore the plains.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.plains++;
			}
			explorer.leave.hint("Leave the plains");
			explorer.skillBasedReveal(areaLevel, timesExplored());
			explorer.doExplore();
		}
		public function plainsChance():Number {
			var temp:Number = 0.5;
			temp *= player.npcChanceToEncounter();
			return temp;
		}
		public function partsofSnippler():void {
			clearOutput();
			outputText("As you explore the plains you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Snippler in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Snippler", 0, 0, 0, 0);
			endEncounter();
		}
		private function findKangaFruit():void {
			outputText(images.showImage("item-kFruit"));
			outputText("While exploring the plains you come across a strange-looking plant.  As you peer at it, you realize it has some fruit you can get at.  ");
			inventory.takeItem(consumables.KANGAFT, explorer.done);
		}
		private function findOviElix():void {
			outputText(images.showImage("item-oElixir"));
			outputText("While exploring the plains you nearly trip over a discarded, hexagonal bottle.  ");
			inventory.takeItem(consumables.OVIELIX, explorer.done);
		}
		private function findSagittariusBanefulGreatBow():void {
			clearOutput();
			outputText("While exploring the plain you stumble upon what appears to have been the site of a battle. Quite a few bodies, those of centaurs and gnolls litter the floor. Amongst said bodies is a large wooden bow that looks beautifully crafted, more so than the average weapon. ");
			outputText("It may have belonged to the centaur chieftain so why is it laying here? You think the centaur either forgot it or has been wiped out.\n\n");
			menu();
			addButton(1, "Bow", findSagittariusBanefulGreatBowTake);
			addButton(3, "Leave", endEncounter);
		}
		private function findSagittariusBanefulGreatBowTake():void {
			clearOutput();
			outputText("As you pick up the amazing looking weapon you feel like a static run through your arm. What just happened? As you try to throw the weapon away by reflex you discover that you can't. ");
			outputText("No way that weapon was actually a cursed item that's why the centaurs left it here! <b>You were cursed by Sagittarius Baneful Great Bow!</b>\n\n");
			player.setWeaponRange(weaponsrange.SAGITTB);
			endEncounter();
		}
	}
}
