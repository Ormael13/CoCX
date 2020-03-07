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
import classes.Scenes.Areas.Desert.*;
import classes.Scenes.SceneLib;

import coc.xxc.BoundStory;
import coc.xxc.stmts.ZoneStmt;

use namespace CoC;

	public class Desert extends BaseContent
	{
		public var antsScene:AntsScene = new AntsScene();
		public var nagaScene:NagaScene = new NagaScene();
		public var oasis:Oasis = new Oasis();
		public var sandTrapScene:SandTrapScene = new SandTrapScene();
		public var sandWitchScene:SandWitchScene = new SandWitchScene();
		public var wanderer:Wanderer = new Wanderer();
		public function Desert()
		{
			onGameInit(init);
		}
		private var story:BoundStory;
		
		private var _desertEncounter:GroupEncounter = null;
		public function get desertEncounter():GroupEncounter {
			return _desertEncounter;
		}
		private function init():void {
            const game:CoC = CoC.instance;
            const fn:FnHelpers = Encounters.fn;
			_desertEncounter = Encounters.group("desert",
					//game.commonEncounters,
					{
						name: "naga",
						when: fn.ifLevelMin(4),
						call: nagaScene.nagaEncounter
					}, {
						name  : "sandtrap",
						chance: 0.5,
						when  : fn.ifLevelMin(2),
						call  : sandTrapScene.encounterASandTarp
					}, {
						name: "sandwitch",
						when: function ():Boolean {
							return player.level >= 3 && flags[kFLAGS.SAND_WITCH_LEAVE_ME_ALONE] == 0;
						},
						call: sandWitchScene.encounter
					}, {
						name: "cumwitch",
						when: function ():Boolean {
							return flags[kFLAGS.CUM_WITCHES_FIGHTABLE] > 0;
						},
						call: SceneLib.dungeons.desertcave.fightCumWitch
					}, {
						name  : "wanderer",
						chance: 0.2,
						call  : wanderer.wandererRouter
					}, {
						name: "sw_preg",
						when: function ():Boolean {
							return sandWitchScene.pregnancy.event == 2;
						},
						call: sandWitchPregnancyEvent
					}, {
						name: "teladreDiscover",
						when: function ():Boolean
						{
							return (!player.hasStatusEffect(StatusEffects.TelAdre)) && (player.exploredDesert >= 3);
						},
						chance: 3,
						call: SceneLib.telAdre.discoverTelAdre
					}, {
						name: "teladreEncounter",
						when: function ():Boolean
						{
							return player.statusEffectv1(StatusEffects.TelAdre) == 0;
						},
						chance: 0.5,
						call: SceneLib.telAdre.discoverTelAdre
					}, {
						name  : "ants",
						when  : function ():Boolean {
							return player.level >= 9 && flags[kFLAGS.ANT_WAIFU] == 0 && flags[kFLAGS.ANTS_PC_FAILED_PHYLLA] == 0 && flags[kFLAGS.ANT_COLONY_KEPT_HIDDEN] == 0;
						},
						chance: 0.25,
						call  : antsScene.antColonyEncounter
					}, {
						name: "dungeon",
						when: function ():Boolean {
							return (player.level >= 4 || player.exploredDesert > 45)
								   && flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] == 0;
						},
						call: SceneLib.dungeons.desertcave.enterDungeon
					}, {
						name: "wstaff",
						when: function ():Boolean {
							return flags[kFLAGS.FOUND_WIZARD_STAFF] == 0 && player.inte > 50;
						},
						call: wstaffEncounter
					}, {
						name: "desert eagle",
						when: function ():Boolean {
							return player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns1) && player.statusEffectv1(StatusEffects.TelAdreTripxiGuns1) == 0 && player.statusEffectv2(StatusEffects.TelAdreTripxi) == 1;
						},
						chance: 30,
						call: partsofDesertEagle
					}, {
						name: "nails",
						when: function ():Boolean {
							return player.hasKeyItem("Carpenter's Toolbox") >= 0 && player.keyItemv1("Carpenter's Toolbox") < 200;
						},
						call: nailsEncounter
					}, {
						name: "chest",
						when: function ():Boolean {
							return player.hasKeyItem("Camp - Chest") < 0
						},
						call: chestEncounter
					}, {
						name  : "bigjunk",
						chance: function ():Boolean
						{
							var chance:Number = 10 + (player.longestCockLength() - player.tallness) / 24 * 10;
							if ( chance > 30){chance = 30; }
							return (chance > rand(100) && player.longestCockLength() >= player.tallness && player.totalCockThickness() >= 12)
						},
						call  : SceneLib.exploration.bigJunkDesertScene
					}, {
						name  : "exgartuan",
						chance: 0.25,
						call  : SceneLib.exgartuan.fountainEncounter
					}, {
						name  : "mirage",
						chance: 0.25,
						when  : fn.ifLevelMin(2),
						call  : mirageDesert
					}, {
						name  : "oasis",
						chance: 0.25,
						when  : fn.ifLevelMin(2),
						call  : oasis.oasisEncounter
					}, {
						name: "Etna",
						chance: 0.2,
						when: function ():Boolean
						{
							return (flags[kFLAGS.ETNA_FOLLOWER] < 1 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2 && !player.hasStatusEffect(StatusEffects.EtnaOff)&& (player.level >= 20));
						},
						call: SceneLib.etnaScene.repeatYandereEnc
					}, {
						//Helia monogamy fucks
						name  : "helcommon",
						call  : SceneLib.helScene.helSexualAmbush,
						chance: 0.2,
						when  : SceneLib.helScene.helSexualAmbushCondition
					});
			story = ZoneStmt.wrap(_desertEncounter,game.rootStory).bind(game.context);
		}
		//Explore desert
		public function exploreDesert():void {
			player.exploredDesert++;
			clearOutput();
			doNext(camp.returnToCampUseOneHour); // default button
			story.execute();
			flushOutputTextToGUI();
		}

		public function sandWitchPregnancyEvent():void {
			if (flags[kFLAGS.EGG_WITCH_TYPE] == PregnancyStore.PREGNANCY_DRIDER_EGGS) sandWitchScene.sammitchBirthsDriders();
			else sandWitchScene.witchBirfsSomeBees();
		}

		public function chestEncounter():void {
			story.display("strings/chest/a");
			for (var i:int = 0; i < 6; i++) {
				inventory.createStorage();
			}
			player.createKeyItem("Camp - Chest", 0, 0, 0, 0);
			story.display("strings/chest/b");
			doNext(camp.returnToCampUseOneHour);
		}

		public function nailsEncounter():void {
			clearOutput();
			story.display("strings/nails/a");
			var extractedNail:int = 5 + rand(player.inte / 5) + rand(player.str / 10) + rand(player.tou / 10) + rand(player.spe / 20) + 5;
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCAVENGER] += extractedNail;
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] += extractedNail;
			story.display("strings/nails/b",{$extractedNail:extractedNail});
			outputText("\n\nNails: ");
			if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2) {
				if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 600 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2) flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 600;
				outputText(flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES]+"/600");
			}
			else {
				if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 2) flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 200;
				outputText(flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/200")
			}
			doNext(camp.returnToCampUseOneHour);
		}

		public function wstaffEncounter():void {
			clearOutput();
			outputText("While exploring the desert, you see a plume of smoke rising in the distance.  You change direction and approach the soot-cloud carefully.  It takes a few moments, but after cresting your fourth dune, you locate the source.  You lie low, so as not to be seen, and crawl closer for a better look.\n\n");
			outputText("A library is burning up, sending flames dozens of feet into the air.  It doesn't look like any of the books will survive, and most of the structure has already been consumed by the hungry flames.  The source of the inferno is curled up next to it.  It's a naga!  She's tall for a naga, at least seven feet if she stands at her full height.  Her purplish-blue skin looks quite exotic, and she wears a flower in her hair.  The naga is holding a stick with a potato on the end, trying to roast the spud on the library-fire.  It doesn't seem to be going well, and the potato quickly lights up from the intense heat.\n\n");
			outputText("The snake-woman tosses the burnt potato away and cries, \"<i>Hora hora.</i>\"  She suddenly turns and looks directly at you.  Her gaze is piercing and intent, but she vanishes before you can react.  The only reminder she was ever there is a burning potato in the sand.   Your curiosity overcomes your caution, and you approach the fiery inferno.  There isn't even a trail in the sand, and the library is going to be an unsalvageable wreck in short order.   Perhaps the only item worth considering is the stick with the burning potato.  It's quite oddly shaped, and when you reach down to touch it you can feel a resonant tingle.  Perhaps it was some kind of wizard's staff?\n\n");
			flags[kFLAGS.FOUND_WIZARD_STAFF]++;
			inventory.takeItem(weapons.W_STAFF, camp.returnToCampUseOneHour);
		}
		
		public function partsofDesertEagle():void {
			clearOutput();
			outputText("As you explore the desert you run into what appears to be the half buried remains of some old contraption. Wait this might just be what that gun vendor was talking about! You proceed to dig up the items releasing this to indeed be the remains of a broken firearm.\n\n");
			outputText("You carefully put the pieces of the Desert Eagle in your back and head back to your camp.\n\n");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns1, 1, 1);
			player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
			player.createKeyItem("Desert Eagle", 0, 0, 0, 0);
			doNext(camp.returnToCampUseOneHour);
		}

		private function mirageDesert():void
		{
			clearOutput();
			outputText("While exploring the desert, you see a shimmering tower in the distance.  As you rush towards it, it vanishes completely.  It was a mirage!   You sigh, depressed at wasting your time.");
			dynStats("lus", -15);
			doNext(camp.returnToCampUseOneHour);
		}

		private function walkingDesertStatBoost():void
		{
			clearOutput();
			outputText("You walk through the shifting sands for an hour, finding nothing.\n\n");
			//Chance of boost == 50%
			if (rand(2) == 0) {
				//50/50 strength/toughness
				if (rand(2) == 0 && player.str < 50) {
					outputText("The effort of struggling with the uncertain footing has made you stronger.");
					dynStats("str", .5);
				}
				//Toughness
				else if (player.tou < 50) {
					outputText("The effort of struggling with the uncertain footing has made you tougher.");
					dynStats("tou", .5);
				}
			}
			doNext(camp.returnToCampUseOneHour);
		}
	}
}
