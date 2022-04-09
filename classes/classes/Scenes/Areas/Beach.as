/**
 * @author Liadri and Ormael
 * Area with lvl 30-45 enemies.
 * Currently a Work in Progress.
 */

package classes.Scenes.Areas 
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.CoC;
import classes.Scenes.API.Encounters;
import classes.Scenes.API.GroupEncounter;
import classes.Scenes.Areas.Beach.*;
import classes.Scenes.Areas.Lake.GooGirlScene;
import classes.Scenes.NPCs.CeaniScene;
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

		public function Beach() 
		{
			onGameInit(init);
		}

		private var _beachEncounters:GroupEncounter = null;
		private function init():void {
			const game:CoC = CoC.instance;
			_beachEncounters = Encounters.group("beach",{
				name: "harpoonGun",
				when: function():Boolean {
					return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns3) && player.statusEffectv2(StatusEffects.TelAdreTripxiGuns3) == 0 && player.hasKeyItem("Harpoon gun") < 0;
				},
				chance: 30,
				call: partsofHarpoonGun
			}, {
				//Helia monogamy fucks
				name  : "helcommon",
				call  : SceneLib.helScene.helSexualAmbush,
				chance: 0.2,
				when  : SceneLib.helScene.helSexualAmbushCondition
			}, {
				// Etna
				name  : "etna",
				call  : function():void {
					player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
					SceneLib.etnaScene.repeatYandereEnc();
				},
				chance: 0.2,
				when  : function():Boolean {
					return flags[kFLAGS.ETNA_FOLLOWER] < 1 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && (player.level >= 20);
				}
			}, {
				// Ceani
				name: "ceani",
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					if (flags[kFLAGS.CEANI_AFFECTION] >= 2 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] < 4) {
						ceaniScene.basicarcherytraining();
					}
					else {
						ceaniScene.firstmeetingCeani();
					}
				},
				chance: 1,
				when: function():Boolean {
					return flags[kFLAGS.CEANI_FOLLOWER] < 1 && flags[kFLAGS.CEANI_DAILY_TRAINING] < 1 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] < 4 && player.gems >= 50;
				}
			}, {
				// Ceani post training
				name: "ceani post training",
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					ceaniScene.beachInteractionsAfterArcheryTraining();
				},
				chance: 1,
				when: function ():Boolean {
					return (model.time.hours >= 6 && model.time.hours <= 11) && flags[kFLAGS.CEANI_FOLLOWER] < 1 && flags[kFLAGS.CEANI_ARCHERY_TRAINING] == 4;
				}
			}, {
				// Pinchou swimwear shop
				name: "pinchou shop",
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					if (flags[kFLAGS.PINCHOU_SHOP] >= 1) pinchoushop.encounteringPinchouRepeat();
					else pinchoushop.encounteringPinchouFirst();
				},
				chance: 1
			}, {
				// Beach demons
				name: "beach demons",
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					demonsPack.demonspackEncounter();
				},
				chance: 1
			}, {
				// Cancer ambush
				name: "cancer ambush",
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					cancerScene.encounter();
				},
				chance: 1
			}, {
				// Beach goo girl
				name: "beach goo girl",
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					gooGirlScene.encounterGooGirlBeach();
				},
				chance: 1
			}, {
				// Discover boat
				name: "discover boat",
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					discoverSeaBoat();
				},
				when: function ():Boolean {
					return flags[kFLAGS.DISCOVERED_BEACH] >= 10 && flags[kFLAGS.DISCOVERED_OCEAN] <= 0;
				},
				chance: Encounters.ALWAYS
			}, {
				// Find Orca sunscreen
				name: "orca sunscreen",
				call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					orcaSunscreenFound();
				},
				chance: 1
			}, {
				// Nothing Happens
				name: "nothing Happens",
						call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					NothingHappened();
				},
				chance: 0.25
			}, {
				// Find Sandstone
				name: "find Sandstone",
						call: function ():void {
					player.createStatusEffect(StatusEffects.NearWater, 0, 0, 0, 0);
					findBeachSite();
				},
				when: function ():Boolean {
					return (player.hasKeyItem("Old Pickaxe") > 0 && Forgefather.materialsExplained);
				},
				chance: 1
			});
		}

		public function exploreBeach():void {
			flags[kFLAGS.DISCOVERED_BEACH]++;
			_beachEncounters.execEncounter();
		}

		public function orcaSunscreenFound():void {
			clearOutput();
			outputText("As you walk on the beach you find a weird black bottle with a white line and a cap. You pick it up and read the tag. It claims to be 'Orca sunscreen'. ");
			inventory.takeItem(consumables.ORCASUN, camp.returnToCampUseOneHour);
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
			doNext(camp.returnToCampUseOneHour);
		}

		public function discoverSeaBoat():void {
			flags[kFLAGS.DISCOVERED_OCEAN] = 1;
			clearOutput();
			outputText("You journey around the beach, seeking demons to fight");
			if(player.cor > 60) outputText(" or fuck");
			outputText(".  The air is fresh, and the sand is cool under your feet.   Soft waves lap against the muddy sand of the sea-shore.   You pass around a few dunes carefully, being wary of hidden 'surprises', and come upon a small dock.  The dock is crafted from old growth trees lashed together with some crude rope.  Judging by the appearance of the rope, it is very old and has not been seen to in quite some time.  Tied to the dock is a small rowboat, only about seven feet long and three feet wide.   The boat appears in much better condition than the dock, and appears to be brand new.\n\n");
			outputText("<b>You have discovered the sea boat!</b>");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function partsofHarpoonGun():void {
			clearOutput();
			outputText("As you explore the beach you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Harpoon gun in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Harpoon gun", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function findBeachSite():void {
			clearOutput();
            outputText("You stumble across a vein of Sandstone, this looks like suitable material for your gargoyle form.\n");
            outputText("Do you wish to mine it?");
            menu();
            addButton(0, "Yes", beachSiteMine);
            addButton(1, "No", camp.returnToCampUseOneHour);
		}
		
		private function beachSiteMine():void {
			if (Forgefather.materialsExplained != true) NothingHappened();
			else {
				clearOutput();
				if (player.fatigue > player.maxFatigue() - 50) {
					outputText("\n\n<b>You are too tired to consider mining. Perhaps some rest will suffice?</b>");
					doNext(camp.returnToCampUseOneHour);
					return;
				}
				outputText("\n\nYou begin slamming your pickaxe against the sandstone, spending the better part of the next two hours mining. This done, you bring back your prize to camp. ");
				var minedStones:Number = 13 + Math.floor(player.str / 20);
				minedStones = Math.round(minedStones);
				fatigue(50, USEFATG_PHYSICAL);
				SceneLib.forgefatherScene.incrementSandstoneSupply(minedStones);
				doNext(camp.returnToCampUseTwoHours);
			}
		}
	}
}