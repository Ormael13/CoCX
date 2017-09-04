/**
 * Created by aimozg on 06.01.14.
 */
package classes.Scenes.Areas
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.API.Encounter;
	import classes.Scenes.API.Encounters;
	import classes.Scenes.API.FnHelpers;
	import classes.Scenes.Areas.Desert.*;

	use namespace kGAMECLASS;

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
		}
		//Explore desert
		
		
		private var _desertEncounter:Encounter = null;
		public function get desertEncounter():Encounter { // lateinit because it references getGame()
			const game:CoC     = getGame();
			const fn:FnHelpers = Encounters.fn;
			if (_desertEncounter == null) _desertEncounter =
					Encounters.group( //game.commonEncounters, 
					{
						name: "naga",
						call: nagaScene.nagaEncounter
					}, {
						name  : "sandtrap",
						chance: 0.5,
						call  : sandTrapScene.encounterASandTarp
					}, {
						name: "sandwitch",
						when: function ():Boolean {
							return flags[kFLAGS.SAND_WITCH_LEAVE_ME_ALONE] == 0;
						},
						call: sandWitchScene.encounter
					}, {
						name: "cumwitch",
						when: function ():Boolean {
							return flags[kFLAGS.CUM_WITCHES_FIGHTABLE] > 0;
						},
						call: game.dungeons.desertcave.fightCumWitch
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
							return (!player.hasStatusEffect(StatusEffects.TelAdre)) && (player.exploredDesert >= 5);
						},
						chance: 2,
						call: game.telAdre.discoverTelAdre
					}, {
						name: "teladreEncounter",
						when: function ():Boolean
						{
							return player.statusEffectv1(StatusEffects.TelAdre) == 0;
						},
						chance: 0.5,
						call: game.telAdre.discoverTelAdre
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
						call: game.dungeons.desertcave.enterDungeon
					}, {
						name: "wstaff",
						when: function ():Boolean {
							return flags[kFLAGS.FOUND_WIZARD_STAFF] == 0 && player.inte > 50;
						},
						call: wstaffEncounter
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
							temp = 10 + (player.longestCockLength() - player.tallness) / 24 * 10;
							if ( temp > 30){temp = 30; }
							return (temp > rand(100) && player.longestCockLength() >= player.tallness && player.totalCockThickness() >= 12)
						},
						call  : game.exploration.bigJunkDesertScene
					}, {
						name  : "exgartuan",
						chance: 0.25,
						call  : game.exgartuan.fountainEncounter
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
						name: "walk",
						call: walkingDesertStatBoost
					}, {
						name: "Etna",
						chance: 0.2,
						when: function ():Boolean
						{
							return (flags[kFLAGS.ETNA_FOLLOWER] < 1 && flags[kFLAGS.ETNA_TALKED_ABOUT_HER] == 2);
						},
						call: game.etnaScene.repeatYandereEnc
					}, {
						//Helia monogamy fucks
						name  : "helcommon",
						call  : game.helScene.helSexualAmbush,
						chance: 0.2,
						when  : game.helScene.helSexualAmbushCondition
					});
			return _desertEncounter;
		}
		//Explore desert
		public function exploreDesert():void {
			player.exploredDesert++;
			desertEncounter.execEncounter();
		}

		public function sandWitchPregnancyEvent():void {
			if (flags[kFLAGS.EGG_WITCH_TYPE] == PregnancyStore.PREGNANCY_DRIDER_EGGS) sandWitchScene.sammitchBirthsDriders();
			else sandWitchScene.witchBirfsSomeBees();
		}


		public function chestEncounter():void {
			outputText("While wandering the trackless sands of the desert, you break the silent monotony with a loud 'thunk'.  You look down and realize you're standing on the lid of an old chest, somehow intact and buried in the sand.  Overcome with curiosity, you dig it out, only to discover that it's empty.  It would make a nice addition to your campsite.\n\nYou decide to bring it back to your campsite.  ");
			for (var i:int = 0; i < 6; i++) {
				inventory.createStorage();
			}
			player.createKeyItem("Camp - Chest", 0, 0, 0, 0);
			outputText("<b>You now have " + num2Text(inventory.itemStorageDirectGet().length) + " storage item slots at camp.</b>");
			doNext(camp.returnToCampUseOneHour);
			doNext(camp.returnToCampUseOneHour);
		}

		public function nailsEncounter():void {
			clearOutput();
			outputText("While exploring the desert, you find the wreckage of a building. Judging from the debris, it's the remains of the library that was destroyed by the fire.\n\n");
			outputText("You circle the wreckage for a good while and you can't seem to find anything to salvage.  Until something shiny catches your eye.  There are exposed nails that look like they can be scavenged.\n\n");
			outputText("You take your hammer out of your toolbox and you spend time extracting straight nails.  Some of the nails you've pulled out are bent but some are incredibly in good condition.  You could use these nails for construction.\n\n");
			var extractedNail:int = 5 + rand(player.inte / 5) + rand(player.str / 10) + rand(player.tou / 10) + rand(player.spe / 20) + 5;
			flags[kFLAGS.ACHIEVEMENT_PROGRESS_SCAVENGER] += extractedNail;
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] += extractedNail;
			outputText("After spending nearly an hour scavenging, you've managed to extract " + extractedNail + " nails.\n\n");
			if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2) {
				if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 600 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2) flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 600;
				outputText("Nails: " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/600")
			}
			else {
				if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 2) flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 200;
				outputText("Nails: " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/200")
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
