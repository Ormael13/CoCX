/**
 * Created by aimozg on 05.01.14.
 */
package classes.Scenes
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Scenes.Explore.ExploreDebug;
	import classes.Scenes.Explore.Giacomo;
	import classes.Scenes.Monsters.*;

	public class Exploration extends BaseContent
	{
		public var exploreDebug:ExploreDebug = new ExploreDebug();

		public function Exploration() {}

		//const MET_OTTERGIRL:int = 777;
		//const HAS_SEEN_MINO_AND_COWGIRL:int = 892;
		//const EXPLORATION_PAGE:int = 1015;
		//const BOG_EXPLORED:int = 1016;
		public function doExplore():void
		{
			// Clear 
			clearOutput();
	
			// Introductions to exploration //
			if (flags[kFLAGS.TIMES_EXPLORED] <= 0) {
				outputText("You tentatively step away from your campsite, alert and scanning the ground and sky for danger.  You walk for the better part of an hour, marking the rocks you pass for a return trip to your camp.  It worries you that the portal has an opening on this side, and it was totally unguarded...\n\n...Wait a second, why is your campsite in front of you? The portal's glow is clearly visible from inside the tall rock formation.   Looking carefully you see your footprints leaving the opposite side of your camp, then disappearing.  You look back the way you came and see your markings vanish before your eyes.  The implications boggle your mind as you do your best to mull over them.  Distance, direction, and geography seem to have little meaning here, yet your campsite remains exactly as you left it.  A few things click into place as you realize you found your way back just as you were mentally picturing the portal!  Perhaps memory influences travel here, just like time, distance, and speed would in the real world!\n\nThis won't help at all with finding new places, but at least you can get back to camp quickly.  You are determined to stay focused the next time you explore and learn how to traverse this gods-forsaken realm.", true);
				flags[kFLAGS.TIMES_EXPLORED]++;
				doNext(camp.returnToCampUseOneHour);
				return;
			} else if (flags[kFLAGS.TIMES_EXPLORED_FOREST] <= 0) {
				outputText("You walk for quite some time, roaming the hard-packed and pink-tinged earth of the demon-realm.  Rust-red rocks speckle the wasteland, as barren and lifeless as anywhere else you've been.  A cool breeze suddenly brushes against your face, as if gracing you with its presence.  You turn towards it and are confronted by the lush foliage of a very old looking forest.  You smile as the plants look fairly familiar and non-threatening.  Unbidden, you remember your decision to test the properties of this place, and think of your campsite as you walk forward.  Reality seems to shift and blur, making you dizzy, but after a few minutes you're back, and sure you'll be able to return to the forest with similar speed.\n\n<b>You have discovered the Forest!</b>", true);
				flags[kFLAGS.TIMES_EXPLORED]++;
				flags[kFLAGS.TIMES_EXPLORED_FOREST]++;
				doNext(camp.returnToCampUseOneHour);
				return;
			}

			// Exploration Menu //
			outputText("You can continue to search for new locations, or explore your previously discovered locations.");

			/*if (flags[kFLAGS.EXPLORATION_PAGE] == 2) {
				explorePageII();
				return;
			}*/
			hideMenus();
			menu();
			addButton(0, "Explore", tryDiscover, null, null, null, "Explore to find new regions and visit any discovered regions.");
			if (flags[kFLAGS.TIMES_EXPLORED_FOREST] > 0) addButton(1, "Forest", kGAMECLASS.forest.exploreForest, null, null, null, "Visit the lush forest. \n\nRecommended level: 1" + (player.level < 6 ? "\n\nBeware of Tentacle Beasts!" : "") + (debug ? "\n\nTimes explored: " + flags[kFLAGS.TIMES_EXPLORED_FOREST] : ""));
			if (flags[kFLAGS.TIMES_EXPLORED_LAKE] > 0) addButton(2, "Lake", kGAMECLASS.lake.exploreLake, null, null, null, "Visit the lake and explore the beach. \n\nRecommended level: 1" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.TIMES_EXPLORED_LAKE] : ""));
			if (flags[kFLAGS.TIMES_EXPLORED_DESERT] > 0) addButton(3, "Desert", kGAMECLASS.desert.exploreDesert, null, null, null, "Visit the dry desert. \n\nRecommended level: 2" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.TIMES_EXPLORED_DESERT] : ""));

			if (flags[kFLAGS.TIMES_EXPLORED_MOUNTAIN] > 0) addButton(5, "Mountain", kGAMECLASS.mountain.exploreMountain, null, null, null, "Visit the mountain. \n\nRecommended level: 5" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.TIMES_EXPLORED_MOUNTAIN] : ""));
			if (flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0) addButton(6, "Swamp", kGAMECLASS.swamp.exploreSwamp, null, null, null, "Visit the wet swamplands. \n\nRecommended level: 12" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.TIMES_EXPLORED_SWAMP] : ""));
			if (flags[kFLAGS.TIMES_EXPLORED_PLAINS] > 0) addButton(7, "Plains", kGAMECLASS.plains.explorePlains, null, null, null, "Visit the plains. \n\nRecommended level: 10" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.TIMES_EXPLORED_PLAINS] : ""));
			if (player.findStatusEffect(StatusEffects.ExploredDeepwoods) >= 0) addButton(8, "Deepwoods", kGAMECLASS.forest.exploreDeepwoods, null, null, null, "Visit the dark, bioluminescent deepwoods. \n\nRecommended level: 5" + (debug ? "\n\nTimes explored: " + player.statusEffectv1(StatusEffects.ExploredDeepwoods) : ""));

			if (flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] > 0) addButton(10, "High Mountain", kGAMECLASS.highMountains.exploreHighMountain, null, null, null, "Visit the high mountains where basilisks and harpies are found. \n\nRecommended level: 10" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_HIGH_MOUNTAIN] : ""));
			if (flags[kFLAGS.BOG_EXPLORED] > 0) addButton(11, "Bog", kGAMECLASS.bog.exploreBog, null, null, null, "Visit the dark bog. \n\nRecommended level: 14" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.BOG_EXPLORED] : ""));
			if (flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] > 0) addButton(12, "Glacial Rift", kGAMECLASS.glacialRift.exploreGlacialRift, null, null, null, "Visit the chilly glacial rift. \n\nRecommended level: 16" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] : ""));
			if (flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] > 0) addButton(13, "Volcanic Crag", kGAMECLASS.volcanicCrag.exploreVolcanicCrag, null, null, null, "Visit the infernal volcanic crag. \n\nRecommended level: 20" + (debug ? "\n\nTimes explored: " + flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] : ""));
			if (debug) addButton(9, "Debug", exploreDebug.doExploreDebug);
			//addButton(4, "Next", explorePageII);
			addButton(14, "Back", playerMenu);
		}

		private function explorePageII():void
		{
			flags[kFLAGS.EXPLORATION_PAGE] = 2;
			menu();
			if (debug) addButton(9, "Debug", exploreDebug.doExploreDebug);
			addButton(9, "Previous", goBackToPageI);
			addButton(14, "Back", playerMenu);
		}

		private function goBackToPageI():void
		{
			flags[kFLAGS.EXPLORATION_PAGE] = 1;
			doExplore();
		}
		
		public function genericGobImpEncounters(even:Boolean = false):void {
			var impGob:Number = 5;
			if (!even) {
				if (player.totalCocks() > 0) impGob--;
				if (player.hasVagina()) impGob++;
				if (player.totalFertility() >= 30) impGob++;
				if (player.cumQ() >= 200) impGob--;
				if (player.findPerk(PerkLib.PiercedLethite) >= 0) {
					if (impGob <= 3) impGob += 2;
					else if (impGob < 7) impGob = 7;
				}
			}
			//Imptacular Encounter
			if (rand(10) < impGob) {
				var impChooser:int = rand(100);
				//Level modifier
				if (player.level < 20) impChooser += player.level;
				else impChooser += 20;
				//Limit chooser ranges
				if (impChooser > 100) impChooser = 100;
				if (player.level < 8 && impChooser >= 40) impChooser = 39;
				else if (player.level < 12 && impChooser >= 60) impChooser = 59;
				else if (player.level < 16 && impChooser >= 80) impChooser = 79;
				//Imp Lord
				if (impChooser >= 50 && impChooser < 70) {
					kGAMECLASS.impScene.impLordEncounter();
					spriteSelect(29);
					return;
				}
				//Imp Warlord
				else if (impChooser >= 70 && impChooser < 90) {
					kGAMECLASS.impScene.impWarlordEncounter();
					spriteSelect(125);
					return;
				}
				//Imp Overlord (Rare!)
				else if (impChooser >= 90) {
					kGAMECLASS.impScene.impOverlordEncounter();
					spriteSelect(126);
					return;
				}
				else {
					if (rand(10) == 0) { //Two imps clashing, UTG stuff.
						clearOutput();
						outputText("A small imp bursts from behind a rock and buzzes towards you. You prepare for a fight, but it stays high and simply flies above you. Suddenly another imp appears from nowhere and attacks the first. In the tussle one of them drops an item, which you handily catch, as the scrapping demons fight their way out of sight. ");
						switch(rand(3)) {
							case 0:
								inventory.takeItem(consumables.SUCMILK, camp.returnToCampUseOneHour);
								break;
							case 1:
								inventory.takeItem(consumables.INCUBID, camp.returnToCampUseOneHour);
								break;
							case 2:
								inventory.takeItem(consumables.IMPFOOD, camp.returnToCampUseOneHour);
								break;
							default:
								camp.returnToCampUseOneHour(); //Failsafe
						}
					}
					else {
						outputText("An imp wings out of the sky and attacks!", true);
						startCombat(new Imp());
						spriteSelect(29);
					}
					//Unlock if haven't already.
					if (flags[kFLAGS.CODEX_ENTRY_IMPS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_IMPS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Imps!</b>");
					}
				}
				return;
			}
			//Encounter Gobbalin!
			else {
				var goblinChooser:int = rand(100);
				//Level modifier
				if (player.level < 20) goblinChooser += player.level;
				else goblinChooser += 20;
				//Limit chooser range
				if (goblinChooser > 100) goblinChooser = 100;
				if (player.level < 10 && goblinChooser >= 20) goblinChooser = 29;
				else if (player.level < 12 && goblinChooser >= 60) goblinChooser = 49;
				else if (player.level < 16 && goblinChooser >= 80) goblinChooser = 79;
				//Goblin assassin!
				if (goblinChooser >= 30 && goblinChooser < 50) {
					kGAMECLASS.goblinAssassinScene.goblinAssassinEncounter();
					spriteSelect(24);
					return;
				}
				//Goblin warrior! (Equal chance with Goblin Shaman)
				else if (goblinChooser >= 50 && goblinChooser < 65) {
					kGAMECLASS.goblinWarriorScene.goblinWarriorEncounter();
					spriteSelect(123);
					return;
				}
				//Goblin shaman!
				else if (goblinChooser >= 65 && goblinChooser < 80) {
					kGAMECLASS.goblinShamanScene.goblinShamanEncounter();
					spriteSelect(124);
					return;
				}
				//Goblin elder!
				else if (goblinChooser >= 80) {
					kGAMECLASS.goblinElderScene.goblinElderEncounter();
					spriteSelect(122);
					return;
				}
				if (player.gender > 0) {
					outputText("A goblin saunters out of the bushes with a dangerous glint in her eyes.\n\nShe says, \"<i>Time to get fucked, " + player.mf("stud", "slut") + ".</i>\"", true);
					if (flags[kFLAGS.CODEX_ENTRY_GOBLINS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_GOBLINS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Goblins!</b>");
					}
					startCombat(new Goblin());
					spriteSelect(24);
					return;
				}
				else {
					outputText("A goblin saunters out of the bushes with a dangerous glint in her eyes.\n\nShe says, \"<i>Time to get fuc-oh shit, you don't even have anything to play with!  This is for wasting my time!</i>\"", true);
					if (flags[kFLAGS.CODEX_ENTRY_GOBLINS] <= 0) {
						flags[kFLAGS.CODEX_ENTRY_GOBLINS] = 1;
						outputText("\n\n<b>New codex entry unlocked: Goblins!</b>");
					}
					startCombat(new Goblin());
					spriteSelect(24);
					return;
				}
			}
		}
		
		//Try to find a new location - called from doExplore once the first location is found
		public function tryDiscover():void {

			if (flags[kFLAGS.PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[kFLAGS.HEL_RAPED_TODAY] == 0 && rand(10) == 0 && (player.cocks.length > 0 || player.vaginas.length > 0) && !kGAMECLASS.helFollower.followerHel()) {
				kGAMECLASS.helScene.helSexualAmbush();
				return;
			}
			if (flags[kFLAGS.GRIMDARK_MODE] > 0) {
				randomEncounter();
				return;
			}
			clearOutput();
			flags[kFLAGS.TIMES_EXPLORED]++;
			if (flags[kFLAGS.TIMES_EXPLORED_LAKE] <= 0) {
				// Discover Lake
				flags[kFLAGS.TIMES_EXPLORED_LAKE] = 1;
				outputText("Your wanderings take you far and wide across the barren wasteland that surrounds the portal, until the smell of humidity and fresh water alerts you to the nearby lake.  With a few quick strides you find a lake so massive the distant shore cannot be seen.  Grass and a few sparse trees grow all around it.\n\n<b>You've discovered the Lake!</b>");
				doNext(camp.returnToCampUseOneHour);
			} else if (flags[kFLAGS.TIMES_EXPLORED_LAKE] >= 1 && rand(3) == 0 && flags[kFLAGS.TIMES_EXPLORED_DESERT] <= 0) {
				// Discover Desert
				flags[kFLAGS.TIMES_EXPLORED_DESERT] = 1;
				outputText("You stumble as the ground shifts a bit underneath you.  Groaning in frustration, you straighten up and discover the rough feeling of sand ");
				if      (player.lowerBody == LOWER_BODY_TYPE_HUMAN)   outputText("inside your footwear, between your toes");
				else if (player.lowerBody == LOWER_BODY_TYPE_HOOFED)  outputText("in your hooves");
				else if (player.lowerBody == LOWER_BODY_TYPE_DOG)     outputText("in your paws");
				else if (player.lowerBody == LOWER_BODY_TYPE_NAGA)    outputText("in your scales");
				outputText(".\n\n<b>You've discovered the Desert!</b>");
				doNext(camp.returnToCampUseOneHour);
			} else if (flags[kFLAGS.TIMES_EXPLORED_DESERT] >= 1 && rand(3) == 0 && flags[kFLAGS.TIMES_EXPLORED_MOUNTAIN] <= 0) {
				// Discover Mountain
				flags[kFLAGS.TIMES_EXPLORED_MOUNTAIN] = 1;
				outputText("Thunder booms overhead, shaking you out of your thoughts.  High above, dark clouds encircle a distant mountain peak.  You get an ominous feeling in your gut as you gaze up at it.\n\n<b>You've discovered the Mountain!</b>");
				doNext(camp.returnToCampUseOneHour);
			} else if (flags[kFLAGS.TIMES_EXPLORED_MOUNTAIN] >= 1 && rand(3) == 0 && flags[kFLAGS.TIMES_EXPLORED_PLAINS] <= 0) {
				// Discover Plains
				flags[kFLAGS.TIMES_EXPLORED_PLAINS] = 1;
				outputText("You find yourself standing in knee-high grass, surrounded by flat plains on all sides.  Though the mountain, forest, and lake are all visible from here, they seem quite distant.\n\n<b>You've discovered the plains!</b>");
				doNext(camp.returnToCampUseOneHour);
			} else if (flags[kFLAGS.TIMES_EXPLORED_SWAMP] <= 0 && flags[kFLAGS.TIMES_EXPLORED_PLAINS] > 0 && rand(3) <= 0) {
				// Discover Swamp
				flags[kFLAGS.TIMES_EXPLORED_SWAMP] = 1;
				outputText("All things considered, you decide you wouldn't mind a change of scenery.  Gathering up your belongings, you begin a journey into the wasteland.  The journey begins in high spirits, and you whistle a little traveling tune to pass the time.  After an hour of wandering, however, your wanderlust begins to whittle away.  Another half-hour ticks by.  Fed up with the fruitless exploration, you're nearly about to head back to camp when a faint light flits across your vision.  Startled, you whirl about to take in three luminous will-o'-the-wisps, swirling around each other whimsically.  As you watch, the three ghostly lights begin to move off, and though the thought of a trap crosses your mind, you decide to follow.\n\n");
				outputText("Before long, you start to detect traces of change in the environment.  The most immediate difference is the increasingly sweltering heat.  A few minutes pass, then the will-o'-the-wisps plunge into the boundaries of a dark, murky, stagnant swamp; after a steadying breath you follow them into the bog.  Once within, however, the gaseous balls float off in different directions, causing you to lose track of them.  You sigh resignedly and retrace your steps, satisfied with your discovery.  Further exploration can wait.  For now, your camp is waiting.\n\n");
				outputText("<b>You've discovered the Swamp!</b>");
				doNext(camp.returnToCampUseTwoHours);
			} else if (flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] <= 0 && flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0 && rand(4) <= 0 && (player.level >= 10 || model.time.days >= 60) ) {
				// Discover Glacial Rift!
				flags[kFLAGS.DISCOVERED_GLACIAL_RIFT] = 1;
				outputText("You walk for some time, roaming the hard-packed and pink-tinged earth of the demon-realm of Mareth. As you progress, a cool breeze suddenly brushes your cheek, steadily increasing in intensity and power until your clothes are whipping around your body in a frenzy. Every gust of wind seems to steal away part of your strength, the cool breeze having transformed into a veritable arctic gale. You wrap your arms around yourself tightly, shivering fiercely despite yourself as the hard pink dirt slowly turns to white; soon you’re crunching through actual snow, thick enough to make you stumble with every other step. You come to a stop suddenly as the ground before you gives way to a grand ocean, many parts of it frozen in great crystal islands larger than any city.\n\n");
				outputText("<b>You've discovered the Glacial Rift!</b>");
				doNext(camp.returnToCampUseTwoHours);
			} else if (flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] <= 0 && flags[kFLAGS.TIMES_EXPLORED_SWAMP] > 0 && rand(4) <= 0 && (player.level >= 15 || model.time.days >= 90) ) {
				// Discover Volcanic Crag!
				flags[kFLAGS.DISCOVERED_VOLCANO_CRAG] = 1;
				outputText("You walk for some time, roaming the hard-packed and pink-tinged earth of the demon-realm of Mareth. As you progress, you can feel the air getting warm. It gets hotter as you progress until you finally stumble across a blackened landscape. You reward yourself with a sight of the endless series of a volcanic landscape. Crags dot the landscape.\n\n");
				outputText("<b>You've discovered the Volcanic Crag!</b>");
				doNext(camp.returnToCampUseTwoHours);
			} else {
				// Random Encounter
				randomEncounter();
			}
		}
		
		public function randomEncounter():void {
			var choosey:Number = rand(5);
			if (flags[kFLAGS.FOUND_CATHEDRAL] > 0 && choosey == 3) choosey ++;
			if (flags[kFLAGS.PRISON_CAPTURE_COUNTER] > 0 && choosey == 2 && rand(4) > 0) choosey += 2;
			if (flags[kFLAGS.GRIMDARK_MODE] > 0) choosey = 666;
			
			switch(choosey) {
				case 0:
					kGAMECLASS.giacomoShop.giacomoEncounter();
					break;
				case 1:
					kGAMECLASS.lumi.lumiEncounter();
					break;
				case 2:
					outputText("Your curiosity draws you towards the smoke of a campfire on the edges of the forest. In the gloom ahead you see what appears to be a cage wagon surrounded by several tents, and hear the sounds of guttural voices engaged in boisterous conversation. Inexplicably you find yourself struck by an unwholesome sense of foreboding. <b>Even from here that cage looks like it is designed to carry people off to somewhere very unpleasant, some place where your life could be turned upside down and the rules you have become accustomed to in this world may no longer apply.</b> You take a long moment to consider turning back. Do you throw caution to the wind and investigate further?");
					//outputText("\n\n(<b>NOTE:</b> Prisoner mod is currently under development and not all scenes are available.)");
					doYesNo(kGAMECLASS.prison.goDirectlyToPrisonDoNotPassGoDoNotCollect200Gems, camp.returnToCampUseOneHour);
					break;
				case 3: //5 (gargoyle) is never chosen once cathedral is discovered.
					if (flags[kFLAGS.GAR_NAME] == 0) kGAMECLASS.gargoyle.gargoylesTheShowNowOnWBNetwork();
					else kGAMECLASS.gargoyle.returnToCathedral();
					break;
				default:
					if (rand(100) < 98) {
						genericGobImpEncounters(true); //Monster - 50/50 imp/gob split.
					} else { //Easter egg!
						outputText("You wander around, fruitlessly searching for new places.");
						doNext(camp.returnToCampUseOneHour);
					}
			}
		}
		
		public function configureRooms():void {
			var tRoom:room;
			
			//Wasteland
			tRoom = new room();
			tRoom.RoomName = "wasteland";
			tRoom.NorthExit = "forest";
			tRoom.SouthExit = null;
			tRoom.WestExit = null;
			tRoom.EastExit = null;
			tRoom.RoomFunction = getGame().exploration.wastelandZoneFunc;
			getGame().dungeons.rooms[tRoom.RoomName] = tRoom;
			
			//Forest
			tRoom = new room();
			tRoom.RoomName = "forest";
			tRoom.NorthExit = "deepwoods";
			tRoom.NorthExitCondition = function():Boolean { return player.hasKeyItem("Gate Key - Deepwoods") >= 0 };
			tRoom.SouthExit = "wasteland";
			tRoom.WestExit = "desert";
			tRoom.WestExitCondition = function():Boolean { return player.hasKeyItem("Gate Key - Desert") >= 0 };
			tRoom.EastExit = "lake";
			tRoom.RoomFunction = getGame().exploration.forestZoneFunc;
			getGame().dungeons.rooms[tRoom.RoomName] = tRoom;
			
			//Deepwoods
			tRoom = new room();
			tRoom.RoomName = "deepwoods";
			tRoom.NorthExit = null;
			tRoom.SouthExit = "forest";
			tRoom.WestExit = null;
			tRoom.EastExit = null;
			tRoom.RoomFunction = getGame().exploration.deepwoodsZoneFunc;
			getGame().dungeons.rooms[tRoom.RoomName] = tRoom;
			
			//Lake
			tRoom = new room();
			tRoom.RoomName = "lake";
			tRoom.NorthExit = "mountains";
			tRoom.SouthExit = "swamp";
			tRoom.SouthExitCondition = function():Boolean { return player.hasKeyItem("Gate Key - Swamp") >= 0 };
			tRoom.WestExit = "forest";
			tRoom.EastExit = null;
			tRoom.RoomFunction = getGame().exploration.lakeZoneFunc;
			getGame().dungeons.rooms[tRoom.RoomName] = tRoom;
			
			//Desert
			tRoom = new room();
			tRoom.RoomName = "desert";
			tRoom.NorthExit = null;
			tRoom.SouthExit = "plains";
			tRoom.WestExit = null;
			tRoom.EastExit = "forest";
			tRoom.RoomFunction = getGame().exploration.desertZoneFunc;
			getGame().dungeons.rooms[tRoom.RoomName] = tRoom;
			
			//Mountain
			tRoom = new room();
			tRoom.RoomName = "mountains";
			tRoom.NorthExit = "highmountains";
			tRoom.NorthExitCondition = function():Boolean { return player.hasKeyItem("Gate Key - High Mountains") >= 0 };
			tRoom.SouthExit = "lake";
			tRoom.WestExit = null;
			tRoom.EastExit = "volcaniccrag";
			tRoom.EastExitCondition = function():Boolean { return player.hasKeyItem("Gate Key - Volcanic Crag") >= 0 };
			tRoom.RoomFunction = getGame().exploration.mountainZoneFunc;
			getGame().dungeons.rooms[tRoom.RoomName] = tRoom;
			
			//High Mountains
			tRoom = new room();
			tRoom.RoomName = "highmountains";
			tRoom.NorthExit = null;
			tRoom.SouthExit = "mountains";
			tRoom.WestExit = null;
			tRoom.EastExit = null;
			tRoom.RoomFunction = getGame().exploration.highmountainZoneFunc;
			getGame().dungeons.rooms[tRoom.RoomName] = tRoom;
			
			//Plains
			tRoom = new room();
			tRoom.RoomName = "plains";
			tRoom.NorthExit = "desert";
			tRoom.SouthExit = null;
			tRoom.WestExit = null; //"savannah";
			tRoom.EastExit = null;
			tRoom.RoomFunction = getGame().exploration.plainsZoneFunc;
			getGame().dungeons.rooms[tRoom.RoomName] = tRoom;
			
			//Swamp
			tRoom = new room();
			tRoom.RoomName = "swamp";
			tRoom.NorthExit = "lake";
			tRoom.SouthExit = "bog";
			tRoom.SouthExitCondition = function():Boolean { return player.hasKeyItem("Gate Key - Bog") >= 0 };
			tRoom.WestExit = null;
			tRoom.EastExit = null;
			tRoom.RoomFunction = getGame().exploration.swampZoneFunc;
			getGame().dungeons.rooms[tRoom.RoomName] = tRoom;
			
			//Bog
			tRoom = new room();
			tRoom.RoomName = "bog";
			tRoom.NorthExit = "swamp";
			tRoom.SouthExit = null;
			tRoom.WestExit = null;
			tRoom.EastExit = "glacialrift";
			tRoom.EastExitCondition = function():Boolean { return player.hasKeyItem("Gate Key - Glacial Rift") >= 0 };
			tRoom.RoomFunction = getGame().exploration.bogZoneFunc;
			getGame().dungeons.rooms[tRoom.RoomName] = tRoom;
			
			//Glacial Rift
			tRoom = new room();
			tRoom.RoomName = "glacialrift";
			tRoom.NorthExit = null;
			tRoom.SouthExit = null;
			tRoom.WestExit = "bog";
			tRoom.EastExit = null;
			tRoom.RoomFunction = getGame().exploration.glacialriftZoneFunc;
			getGame().dungeons.rooms[tRoom.RoomName] = tRoom;
			
			//Volcanic Crag
			tRoom = new room();
			tRoom.RoomName = "volcaniccrag";
			tRoom.NorthExit = null;
			tRoom.SouthExit = null;
			tRoom.WestExit = "mountains";
			tRoom.EastExit = null;
			tRoom.RoomFunction = getGame().exploration.volcaniccragZoneFunc;
			getGame().dungeons.rooms[tRoom.RoomName] = tRoom;
		}
		
		//------------
		// GRIMDARK DESC
		//------------
		public function wastelandZoneFunc():Boolean {
			clearOutput();
			outputText("<b><u>Wasteland</u></b>\n");
			outputText("The wasteland is what you would expect. The landscape is marred with remnants from the war, littered with corpses of various creatures and dotted with dried blood and semen puddles.");
			outputText("\n\nTall wrought iron walls separate each of the zones so it looks like the only way to travel between zones is through the gates.");
			outputText("\n\nTo the north is the gateway to forest. Behind you is the village Ingnam, which was mysteriously transported to Mareth.");
			addButton(0, "Explore", tryDiscover);
			addButton(1, "Ingnam", visitIngnam);
			return false;
		}
		
		public function forestZoneFunc():Boolean {
			clearOutput();
			outputText("<b><u>Forest</u></b>\n");
			outputText("In spite of the grim nature of Mareth, the forest retains a portion its lush foliage, with plants and trees and some not even familiar to you. Some of the trees have scratch marks on them and a few are pierced with arrows. A segment of the forest is ruined with burnt and dead plants and trees.");
			outputText("\n\nTo the north is the path to the Deepwoods, separated by a wall of huge tree trunks though the knot-hole like opening had a " + (player.hasKeyItem("Gate Key - Deepwoods") >= 0 ? "gate installed but it's now open. " : "<b>locked gate installed to keep you from entering</b>."));
			outputText("\n\nTo the west is the path to desert " + (player.hasKeyItem("Gate Key - Desert") >= 0 ? "which is now unlocked since you have the key. " : "though <b>there's a locked gate</b>.") + "");
			outputText("\n\nTo the south is the path to the wasteland where Ingnam is located. To the east is the path to the lake.");
			addButton(0, "Explore", kGAMECLASS.forest.exploreForest);
			return false;
		}
		
		public function deepwoodsZoneFunc():Boolean {
			clearOutput();
			outputText("<b><u>Deepwoods</u></b>\n");
			outputText("This zone seems to be relatively untouched by the previous war. The Deepwoods is densely packed with trees, even more than the forest. Glowing moss and fungus dimly light the deepwoods, ensuring that you'll always be able to see even at night.");
			outputText("\n\nTo the south is the way back to the forest.");
			addButton(0, "Explore", kGAMECLASS.forest.exploreDeepwoods);
			if (flags[kFLAGS.DISCOVERED_DUNGEON_2_ZETAZ] > 0) addButton(1, "Deep Cave", getGame().dungeons.deepcave.enterDungeon);
			return false;
		}
		
		public function lakeZoneFunc():Boolean {
			clearOutput();
			outputText("<b><u>Lake</u></b>\n");
			outputText("The lake is so big that you can't see the shoreline at the other side and the water is tinted red with the blood of the casualties from the war. The occasional trees show signs of recent war, with scratch marks from swords, arrow protruding from trunk and blood stains. Mounds of rotting and skeletal corpses dot the landscape.");
			outputText("\n\nTo the north is the path leading to the mountains.");
			outputText("\n\nTo the south is the path leading to the swamp " + (player.hasKeyItem("Gate Key - Swamp") >= 0 ? "which is now unlocked since you have the key. " : "though <b>there's a locked gate in the way</b>.") + "");
			outputText("\n\nTo the west is the path back to the forest.");
			addButton(0, "Explore", kGAMECLASS.lake.exploreLake);
			if (player.findStatusEffect(StatusEffects.BoatDiscovery) >= 0) addButton(1, "Boat", kGAMECLASS.boat.boatExplore);
			return false;
		}
		
		public function desertZoneFunc():Boolean {
			clearOutput();
			outputText("<b><u>Desert</u></b>\n");
			addButton(0, "Explore", kGAMECLASS.desert.exploreDesert);
			if (player.findStatusEffect(StatusEffects.TelAdre) >= 0) addButton(1, "Tel'Adre", visitTelAdre);
			if (flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] > 0) addButton(2, "Desert Cave", kGAMECLASS.dungeons.desertcave.enterDungeon);
			return false;
		}
		
		public function mountainZoneFunc():Boolean {
			clearOutput();
			outputText("<b><u>Mountain</u></b>\n");
			addButton(0, "Explore", kGAMECLASS.mountain.exploreMountain);
			if (flags[kFLAGS.FACTORY_FOUND] > 0) addButton(1, "Factory", getGame().dungeons.factory.enterDungeon);
			return false;
		}
		
		public function highmountainZoneFunc():Boolean {
			clearOutput();
			outputText("<b><u>High Mountain</u></b>\n");
			addButton(0, "Explore", kGAMECLASS.highMountains.exploreHighMountain);
			return false;
		}
		
		public function plainsZoneFunc():Boolean {
			clearOutput();
			outputText("<b><u>Plains</u></b>\n");
			addButton(0, "Explore", kGAMECLASS.plains.explorePlains);
			return false;
		}
		
		public function swampZoneFunc():Boolean {
			clearOutput();
			outputText("<b><u>Swamp</u></b>\n");
			addButton(0, "Explore", kGAMECLASS.swamp.exploreSwamp);
			return false;
		}
		
		public function bogZoneFunc():Boolean {
			clearOutput();
			outputText("<b><u>Bog</u></b>\n");
			addButton(0, "Explore", kGAMECLASS.bog.exploreBog);
			return false;
		}
		
		public function glacialriftZoneFunc():Boolean {
			clearOutput();
			outputText("<b><u>Glacial Rift</u></b>\n");
			addButton(0, "Explore", kGAMECLASS.glacialRift.exploreGlacialRift);
			return false;
		}
		
		public function volcaniccragZoneFunc():Boolean {
			clearOutput();
			outputText("<b><u>Volcanic Crag</u></b>\n");
			addButton(0, "Explore", kGAMECLASS.volcanicCrag.exploreVolcanicCrag);
			return false;
		}
		
		//Enter town/city
		public function visitIngnam():void {
			inRoomedDungeonResume = kGAMECLASS.ingnam.menuIngnam;
			inRoomedDungeonResume();
		}
		
		public function visitTelAdre():void {
			inRoomedDungeonResume = kGAMECLASS.telAdre.telAdreMenu;
			inRoomedDungeonResume();
		}
		
		public function visitBizarreBazaar():void {
			inRoomedDungeonResume = kGAMECLASS.bazaar.enterTheBazaarAndMenu;
			inRoomedDungeonResume();
		}
		
		public function visitOwca():void {
			inRoomedDungeonResume = kGAMECLASS.owca.gangbangVillageStuff;
			inRoomedDungeonResume();
		}
	}
}
