/**
 * @author Liadri and Ormael
 * Area with lvl 30-45 enemies.
 * Currently a Work in Progress.
 */

package classes.Scenes.Areas
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.ExplorationEntry;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Beach.*;
import classes.Scenes.Areas.Lake.GooGirlScene;
import classes.Scenes.NPCs.CeaniScene;
import classes.Scenes.NPCs.EtnaFollower;
import classes.Scenes.NPCs.Forgefather;
import classes.Scenes.SceneLib;

//import classes.Scenes.NPCs.CaiLin;

	use namespace CoC;

	public class Beach extends BaseContent
	{
		public var ceaniScene:CeaniScene = new CeaniScene();
		public var cancerScene:CancerAttackScene = new CancerAttackScene();
		public var demonsPack:DemonPackBeachScene = new DemonPackBeachScene();
		public var pinchoushop:PinchousWaterwearAndTools = new PinchousWaterwearAndTools();
		public var gooGirlScene:GooGirlScene = new GooGirlScene();
		public var arigeanOmnibusAbominationScene:ArigeanOmnibusAbominationScene = new ArigeanOmnibusAbominationScene();

		public const areaLevel:int = 25;
		public function isDiscovered():Boolean {
			return SceneLib.exploration.counters.beach > 0;
		}
		public function canDiscover():Boolean {
			return !isDiscovered() && adjustedPlayerLevel() >= areaLevel && SceneLib.blightridge.isDiscovered();
		}
		public function timesExplored():int {
			return SceneLib.exploration.counters.beach;
		}
		public function discover():void {
			SceneLib.exploration.counters.beach = 1;
			clearOutput();
			outputText("You hear seagulls in the distance and run on the grass to look what is beyond. There is a few dunes of sand with patch of grass that you eagerly cross over as you discover what you hoped to find.");
			outputText("\n\nFinally, after stepping over another dune, in the distance before you a shore of water spreads. Its surely way bigger than the lake you found some time ago. As far as you look to the side you can't see the shores end.  Mesmerized by the view you continue walking towards the ocean until you stand in the shallow water with waves passing by around your waist. Despite the corruption of Mareth this water turns out to be quite clear and who knows, maybe it’s not even that much tainted... yet. But that would probably require submerging deeper to check it out.");
			outputText("\n\n<b>You've discovered the Beach and the Ocean!</b>");
			endEncounter(120);
		}

		public function Beach()
		{
			onGameInit(init);
		}

		private var _beachEncounters:GroupEncounter = null;
		private function init():void {
			_beachEncounters = Encounters.group("beach",{
				name: "harpoonGun",
				label : "Gun Parts",
				kind  : 'item',
				unique: true,
				when: function():Boolean {
					return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns3) && player.statusEffectv2(StatusEffects.TelAdreTripxiGuns3) == 0 && player.hasKeyItem("Harpoon gun") < 0;
				},
				chance: 30,
				call: partsofHarpoonGun
			}, {
				//Helia monogamy fucks
				name  : "helcommon",
				label : "Helia",
				kind  : 'npc',
				unique: true,
				night : false,
				call  : SceneLib.helScene.helSexualAmbush,
				chance: beachChance,
				when  : SceneLib.helScene.helSexualAmbushCondition
			}, {
				// Etna
				name  : "etna",
				label : "Etna",
				kind  : 'npc',
				unique: true,
				call  : function():void {
					player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
					SceneLib.etnaScene.repeatYandereEnc();
				},
				chance: beachChance,
				when  : function():Boolean {
					return (flags[kFLAGS.ETNA_FOLLOWER] < 1 || EtnaFollower.EtnaInfidelity == 2) && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && (player.level >= 20);
				}
			}, {
				// Ceani
				name: "ceani",
				label : "Ceani",
				kind  : 'npc',
				unique: true,
				night : false,
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					if (flags[kFLAGS.CEANI_AFFECTION] >= 2 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] < 4) {
						ceaniScene.basicarcherytraining();
					}
					else {
						ceaniScene.firstmeetingCeani();
					}
				},
				chance: beachChance2,
				when: function():Boolean {
					return flags[kFLAGS.CEANI_FOLLOWER] < 1 && flags[kFLAGS.CEANI_DAILY_TRAINING] < 1 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] < 4 && player.gems >= 50;
				}
			}, {
				// Ceani post training
				name: "ceani post training",
				label : "Ceani",
				kind  : 'npc',
				unique: true,
				night : false,
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					ceaniScene.beachInteractionsAfterArcheryTraining();
				},
				chance: beachChance2,
				when: function ():Boolean {
					return (model.time.hours >= 6 && model.time.hours <= 11) && flags[kFLAGS.CEANI_FOLLOWER] < 1 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] >= 4;
				}
			}, {
				// 
				name  : "charyb",
				label : "Charybdis",
				kind  : 'npc',
				unique: true,
				call  : function():void {
					player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
					if (flags[kFLAGS.CHARYBDIS_FOLLOWER] < 1) SceneLib.charybdisScene.charyFirstEncounter();
					else SceneLib.charybdisScene.charyBeachMeetings();
				},
				chance: beachChance,
				when  : function():Boolean {
					return SceneLib.dungeons.checkDeepCaveClear() && flags[kFLAGS.CHARYBDIS_FOLLOWER] < 2;
				}
			}, {
				// Pinchou swimwear shop
				name: "pinchou shop",
				label : "Pinchou",
				kind  : 'npc',
				unique: true,
				night : false,
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					if (flags[kFLAGS.PINCHOU_SHOP] >= 1) pinchoushop.encounteringPinchouRepeat();
					else pinchoushop.encounteringPinchouFirst();
				},
				chance: 1
			}, {
				// Beach demons
				name: "beach demons",
				label : "Demons",
				kind : 'monster',
				night : false,
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					demonsPack.demonspackEncounter();
				},
				chance: 1
			}, {
				// Cancer ambush
				name: "cancer ambush",
				label : "Cancer",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					cancerScene.encounter();
				},
				chance: 1
			}, {
				// Beach goo girl
				name: "beach goo girl",
				label : "Goo Girl",
				kind : 'monster',
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					gooGirlScene.encounterGooGirlBeach();
				},
				chance: 1
			}, {
				// Discover boat
				name: "discover boat",
				label : "New Area",
				kind  : 'place',
				unique: true,
				call: SceneLib.ocean.discover,
				when: SceneLib.ocean.canDiscover,
				chance: Encounters.ALWAYS
			}, {
				// Find Orca sunscreen
				name: "orca sunscreen",
				label : "Orca Sunscreen",
				kind  : 'item',
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					orcaSunscreenFound();
				},
				chance: 1
			}, {
				// Nothing Happens
				name: "nothing Happens",
				label:'Walk',
				kind:'walk',
						call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					NothingHappened();
				},
				chance: 0.25
			}, {
				// Find Sandstone
				name: "find Sandstone",
				label : "Mine",
				kind  : 'place',
						call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					findBeachSite();
				},
				when: function ():Boolean {
					return (player.hasKeyItem("Old Pickaxe") > 0 && Forgefather.materialsExplained);
				},
				chance: 1
			}, {
				name: "arigeanOmnibusAbomination",
				label : "Arigean Omnibus",
				kind  : 'monster',
				unique: true,
				when: function ():Boolean {
					return flags[kFLAGS.THE_TRENCH_ENTERED] == 9;
				},
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					arigeanOmnibusAbominationScene.arigeanOmnibusAbominationEncounter();
				},
				chance: 1
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

		public function exploreBeach():void {
			explorer.prepareArea(_beachEncounters);
			explorer.setTags("beach", "water");
			explorer.prompt = "You explore the sunny beach.";
			explorer.onEncounter = function(e:ExplorationEntry):void {
				SceneLib.exploration.counters.beach++;
			}
			explorer.leave.hint("Leave the sunny beach");
			explorer.skillBasedReveal(areaLevel, timesExplored());
			explorer.doExplore();
		}

		public function beachChance():Number {
			var temp:Number = 0.2;
			temp *= player.npcChanceToEncounter();
			return temp;
		}
		public function beachChance2():Number {
			var temp:Number = 1;
			temp *= player.npcChanceToEncounter();
			return temp;
		}

		public function orcaSunscreenFound():void {
			clearOutput();
			outputText("As you walk on the beach you find a weird black bottle with a white line and a cap. You pick it up and read the tag. It claims to be 'Orca sunscreen'. ");
			inventory.takeItem(consumables.ORCASUN, explorer.done);
		}

		public function NothingHappened():void {
			clearOutput();
			outputText("You walk through the sunny beach for an hour, finding nothing.\n\n");
			if (rand(2) == 0) {
				//50/50 strength/toughness
				if (rand(2) == 0 && player.str < 100) {
					outputText("The effort of struggling with the sand has made you stronger.");
					dynStats("str", .5);
				}
				//Toughness
				else if (player.tou < 100) {
					outputText("The effort of struggling with the sand has made you tougher.");
					dynStats("tou", .5);
				}
			}
			endEncounter();
		}


		public function partsofHarpoonGun():void {
			clearOutput();
			outputText("As you explore the beach you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Harpoon gun in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Harpoon gun", 0, 0, 0, 0);
			endEncounter();
		}

		public function findBeachSite():void {
			clearOutput();
            outputText("You stumble across a vein of Sandstone, this looks like suitable material for your gargoyle form.\n");
            outputText("Do you wish to mine it?");
            menu();
            addButton(0, "Yes", beachSiteMine);
            addButton(1, "No", explorer.done);
		}

		private function beachSiteMine():void {
			if (Forgefather.materialsExplained != true) NothingHappened();
			else {
				clearOutput();
				if (player.fatigue > player.maxOverFatigue() - 50) {
					outputText("\n\n<b>You are too tired to consider mining. Perhaps some rest will suffice?</b>");
					endEncounter();
					return;
				}
				outputText("\n\nYou begin slamming your pickaxe against the sandstone, spending the better part of the next two hours mining. This done, you bring back your prize to camp. ");
				var minedStones:Number = 13 + Math.floor(player.str / 20);
				minedStones = Math.round(minedStones);
				fatigue(50, USEFATG_PHYSICAL);
				SceneLib.forgefatherScene.incrementSandstoneSupply(minedStones);
				player.mineXP(player.MiningMulti());
				findGem();
			}
		}

		private function findGem():void {
			if (player.miningLevel > 4) {
				if (rand(4) == 0) {
					inventory.takeItem(useables.EMDGEM, curry(explorer.done,120));
					player.mineXP(player.MiningMulti() * 2);
				}
				else {
					outputText("After attempting to mine Emeralds, you ended with only unusable pieces.");
					endEncounter(120);
				}
			}
			else {
				outputText(" Your mining skill is too low to find any Emeralds.");
				endEncounter(120);
			}
		}
	}
}

