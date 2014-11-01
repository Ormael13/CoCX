package classes.Scenes.Dungeons.D3 
{
	import classes.BaseContent;
	import classes.room;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Dungeons.Factory.IncubusMechanic;
	import classes.StatusAffects;
	import classes.PerkLib;
	import classes.CockTypesEnum;
	import classes.PregnancyStore;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class D3 extends BaseContent
	{
		public var rooms:Object = { };
		private var _currentRoom:String; // I don't think we'll need to save/load this, as we're not gonna allow saving in the dungeon, and it'll be overwritten by calling enterD3();
		
		public var jeanClaude:JeanClaudeScenes = new JeanClaudeScenes();
		public var doppleganger:DopplegangerScenes = new DopplegangerScenes();
		public var incubusMechanic:IncubusMechanicScenes = new IncubusMechanicScenes();
		public var livingStatue:LivingStatueScenes = new LivingStatueScenes();
		public var succubusGardener:SuccubusGardenerScenes = new SuccubusGardenerScenes();
		public var hermCentaur:HermCentaurScenes = new HermCentaurScenes();
		
		public function D3() 
		{
			configureRooms();
		}
		
		private function configureRooms():void
		{
			var tRoom:room;
			
			// Entrance
			tRoom = new room();
			tRoom.RoomName = "entrance";
			tRoom.EastExit = "tunnel1";
			tRoom.RoomFunction = entranceRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// Tunnel 1
			tRoom = new room();
			tRoom.RoomName = "tunnel1";
			tRoom.NorthExit = "antechamber";
			tRoom.WestExit = "entrance";
			tRoom.RoomFunction = tunnel1RoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// Antechamber
			tRoom = new room();
			tRoom.RoomName = "antechamber";
			tRoom.NorthExit = "magpiehalls";
			tRoom.EastExit = "roomofmirrors";
			tRoom.SouthExit = "tunnel1";
			tRoom.RoomFunction = antechamberRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// Room of Mirrors
			tRoom = new room();
			tRoom.RoomName = "roomofmirrors";
			tRoom.WestExit = "antechamber";
			tRoom.RoomFunction = roomofmirrorsRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// Magpie Hall S
			tRoom = new room();
			tRoom.RoomName = "magpiehalls";
			tRoom.NorthExit = "magpiehalln";
			tRoom.SouthExit = "antechamber";
			tRoom.RoomFunction = magpiehallsRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// Magpie Hall N
			tRoom = new room();
			tRoom.RoomName = "magpiehalln";
			tRoom.NorthExit = "tunnel2";
			tRoom.SouthExit = "magpiehalls";
			tRoom.RoomFunction = magpiehallnRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// Tunnel 2
			tRoom = new room();
			tRoom.RoomName = "tunnel2";
			tRoom.EastExit = "edgeofkeep";
			tRoom.SouthExit = "magpiehalln";
			tRoom.RoomFunction = tunnel2RoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// Edge of Keep
			tRoom = new room();
			tRoom.RoomName = "edgeofkeep";
			tRoom.NorthExit = "northentry";
			tRoom.WestExit = "tunnel2";
			tRoom.RoomFunction = edgeofkeepRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// North Entry
			tRoom = new room();
			tRoom.RoomName = "northentry";
			tRoom.NorthExit = "southcourtyard";
			tRoom.SouthExit = "edgeofkeep";
			tRoom.RoomFunction = northentryRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// South Courtyard
			tRoom = new room();
			tRoom.RoomName = "southcourtyard";
			tRoom.SouthExit = "northentry";
			tRoom.EastExit = "southeastcourtyard";
			tRoom.WestExit = "southwestcourtyard";
			tRoom.RoomFunction = southcourtyardRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// South West Courtyard
			tRoom = new room();
			tRoom.RoomName = "southwestcourtyard";
			tRoom.EastExit = "southcourtyard";
			tRoom.NorthExit = "southwestwalk";
			tRoom.RoomFunction = southwestcourtyardRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// South West Walk
			tRoom = new room();
			tRoom.RoomName = "southwestwalk";
			tRoom.NorthExit = "westwalk";
			tRoom.SouthExit = "southwestcourtyard";
			tRoom.RoomFunction = southwestwalkRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// West Walk
			tRoom = new room();
			tRoom.RoomName = "westwalk";
			tRoom.NorthExit = "northwestwalk";
			tRoom.EastExit = "courtyardsquare";
			tRoom.SouthExit = "southwestwalk";
			tRoom.RoomFunction = westwalkRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// North West Walk
			tRoom = new room();
			tRoom.RoomName = "northwestwalk";
			tRoom.NorthExit = "northwestcourtyard";
			tRoom.SouthExit = "westwalk";
			tRoom.RoomFunction = northwestwalkRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// North West Courtyard
			tRoom = new room();
			tRoom.RoomName = "northwestcourtyard";
			tRoom.EastExit = "northcourtyard";
			tRoom.SouthExit = "northwestwalk";
			tRoom.RoomFunction = northwestcourtyardRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// North Courtyard
			tRoom = new room();
			tRoom.RoomName = "northcourtyard";
			tRoom.EastExit = "northeastcourtyard";
			tRoom.WestExit = "northwestcourtyard";
			tRoom.RoomFunction = northcourtyardRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// North East Courtyard
			tRoom = new room();
			tRoom.RoomName = "northeastcourtyard";
			tRoom.SouthExit = "northeastwalk";
			tRoom.WestExit = "northcourtyard";
			tRoom.RoomFunction = northeastcourtyardRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// North East Walk
			tRoom = new room();
			tRoom.RoomName = "norteastwalk";
			tRoom.NorthExit = "northeastcourtyard";
			tRoom.SouthExit = "eastwalk";
			tRoom.RoomFunction = norteastwalkRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// East Walk
			tRoom = new room();
			tRoom.RoomName = "eastwalk";
			tRoom.NorthExit = "northeastwalk";
			tRoom.SouthExit = "southeastwalk";
			tRoom.WestExit = "courtyardsquare";
			tRoom.RoomFunction = eastwalkRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// South East Walk
			tRoom = new room();
			tRoom.RoomName = "southeastwalk";
			tRoom.NorthExit = "eastwalk";
			tRoom.SouthExit = "southeastcourtyard";
			tRoom.RoomFunction = southeastwalkRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// South East Courtyard
			tRoom = new room();
			tRoom.RoomName = "southeastcourtyard";
			tRoom.NorthExit = "southeastwalk";
			tRoom.SouthExit = "greatlift";
			tRoom.WestExit = "southcourtyard";
			tRoom.RoomFunction = southeastcourtyardRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// Courtyard Square
			tRoom = new room();
			tRoom.RoomName = "courtyardsquare";
			tRoom.EastExit = "eastwalk";
			tRoom.WestExit = "westwalk";
			tRoom.RoomFunction = courtyardsquareRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
			
			// Great Lift
			tRoom = new room();
			tRoom.RoomName = "greatlift";
			tRoom.NorthExit = "southeastcourtyard";
			tRoom.RoomFunction = greatliftRoomFunc;
			rooms[tRoom.RoomName] = tRoom;
		}
		
		// Entrance/Exit
		
		public function discoverD3():Boolean
		{
			if (flags[kFLAGS.D3_DISCOVERED] == 0 && player.hasKeyItem("Zetaz's Map") && player.level > 10 && rand(10) == 0)
			{
				flags[kFLAGS.D3_DISCOVERED] = 1;
				
				clearOutput();
				outputText("During your exploration, you come across a familiar looking patch of ground. In fact... you pull out Zetaz’s map, your eyes widening as they realize what you’ve just found: Lethice’s Keep. You follow a concealed trail past several harpy nests directly to an almost invisible cave entrance. You never would’ve found it without the map.");
				outputText("\n\n<b>You’ve discovered a hidden entrance to Lethice’s lair. It can be accessed from the Dungeons submenu in the future.</b>");
				outputText("\n\nDo you step inside, or wait until you’re better prepared?");
				
				menu();
				addButton(0, "Enter", enterD3);
				addButton(1, "Leave", eventParser, 13);
				
				return true;
			}
			return false;
		}
		
		public function enterD3():void
		{
			inRoomedDungeon = true;
			inRoomedDungeonResume = resumeFromFight;
			move("entrance");
		}
		
		public function exitD3():void
		{
			inRoomedDungeon = false;
			inRoomedDungeonResume = null;
			eventParser(13);
		}

		public function resumeFromFight():void
		{
			move(_currentRoom);
		}
		
		private function generateRoomMenu(tRoom:room):void
		{
			if (tRoom.NorthExit != null && tRoom.NorthExit.length > 0)
			{
				if (tRoom.NorthExitCondition == null || tRoom.NorthExitCondition())
				{
					addButton(0, "North", move, tRoom.NorthExit);
				}
			}
			
			if (tRoom.EastExit != null && tRoom.EastExit.length > 0)
			{
				if (tRoom.EastExitCondition == null || tRoom.EastExitCondition())
				{
					addButton(1, "East", move, tRoom.EastExit);
				}
			}
			
			if (tRoom.SouthExit != null && tRoom.SouthExit.length > 0)
			{
				if (tRoom.SouthExitCondition == null || tRoom.SouthExitCondition())
				{
					addButton(6, "South", move, tRoom.SouthExit);
				}
			}
			
			if (tRoom.WestExit != null && tRoom.WestExit.length > 0)
			{
				if (tRoom.WestExitCondition == null || tRoom.WestExitCondition())
				{
					addButton(5, "West", move, tRoom.WestExit);
				}
			}
			
			if (tRoom.RoomName == "entrance")
			{
				addButton(5, "Exit", exitD3);
			}
			
			addButton(8, "Items", eventParser, 1000);
			addButton(9, "Masturbate", eventParser, 10);
		}
		
		private function move(roomName:String):void
		{
			clearOutput();
			
			if (rooms[roomName] == undefined)
			{
				outputText("Error: Couldn't find the room indexed as: " + roomName);
				return;
			}
			
			var tRoom:room = rooms[roomName];
			
			if (tRoom.RoomFunction == null)
			{
				outputText("Error: Room entry function for room indexed as '" + roomName + "' was not set.");
				return;
			}
			
			menu();
			
			if (!tRoom.RoomFunction())
			{
				generateRoomMenu(tRoom);
			}
			
			_currentRoom = roomName;
		}
		
		private function entranceRoomFunc():Boolean
		{
			outputText("The inside of this cave is damp and dark, but it bears signs of frequent use. The map you got from Zetaz matches the curves of this winding passage exactly. There can be no doubt that this is the place, even though his map ends a short distance into the tunnel. Either he knew it would be a linear path or was so familiar with the territory that he didn’t think it was worth writing down. You can go east, deeper into the mountain towards Lethice’s fortress, or leave to the west.");
			return false;
		}
		
		private function tunnel1RoomFunc():Boolean
		{
			outputText("Winding back and forth, the tunnel gradually arcs west and north from here, sloping steeply upward in the latter direction. The upward sloping side must lead to Lethice’s fortress, supposedly at the top of the mountain. You’ll have to be careful down here. You doubt that such an entrance would be completely unguarded. As a matter of fact... you think you can see signs of worked stone to the north. You’re getting close to something.");
			return false;
		}
		
		private function antechamberRoomFunc():Boolean
		{
			outputText("You are standing in a large, gloomy lobby, lit by the drear yellow pulse of gas lamps. The walls, floor and distant ceiling are uniformly built from a dark, aged stone which serves to make the vault-like space shadowy and oppressive, despite its size. The floor has been polished a dull bronze by years of use and the distant sound of activity permeates the air; it has the atmosphere of a place which is thronged with people during rush hour but is for now as deserted as a school corridor during class hours. Something to be grateful for perhaps, but you should get a move on.");

			outputText("\n\nAhead is a large archway. Through it you can see some sort of dark screen set into a wall. On the right is a much smaller metal door, which looks like it might be a storage room.");
			return false;
		}
		
		private function roomofmirrorsRoomFunc():Boolean
		{
			outputText("The metal door opens soundlessly onto a fairly large, unlit room, shabby and grey with disuse. It is cluttered with a great quantity of mirrors. Round hand mirrors are stacked on shelves, square wall mirrors are leant against walls, a large,"); 
			if (flags[kFLAGS.D3_MIRRORS_SHATTERED] == 1) outputText(" now shattered,");
			outputText(" ornate standing mirror dominates the centre of the room, and a number of broken, jagged specimens are stacked near the back. They reflect the dull trappings of this place back at you emptily. You guess as self - centred a race as the demons probably has quite a large use for these.");
			
			if (player.hasKeyItem("Laybans") >= 0)
			{
				outputText("\n\nThe place feels hollow and creepy, even after the ad hoc exorcism you performed here. There is no reason to linger.");
			}
			else
			{
				outputText("\n\nNear the back, next to the broken stack is a white stand, displaying what appear to be a number of dark shades.");
				if (flags[kFLAGS.D3_ENTERED_MAGPIEHALL] == 1) outputText("  Your spirits rise. They look like they may very well be made of the same material as the screen in the basilisk hall.");
				if (player.inte >= 70 || player.sens >= 70) outputText("  Disquiet edges down your spine. Something about this place doesn’t feel right. The room seems faded at the corners, as if it’s not quite there.");
				
				addButton(2, "Glasses", doppleganger.getDemGlasses);
			}
			
			return false;
		}
		
		private function magpiehallsRoomFunc():Boolean
		{
			if (flags[kFLAGS.D3_JEAN_CLAUDE_DEFEATED] == 0)
			{
				if (flags[kFLAGS.D3_ENTERED_MAGPIEHALL] == 0)
				{
					flags[kFLAGS.D3_ENTERED_MAGPIEHALL] = 1;
					outputText("You creep through the archway. The sound of movement and bustle is closer here; it seems to be coming from directly below you. Ahead is the screen, a large window made from tinted glass. Cautiously you peer through it. You have entered a vast hall, near the very top of it; this seems to be some sort of observation booth set high in the stone wall. It’s designed in the grand, classical tradition, fluted balustrades flanking the walls, each decorated at the top by a carved magpie in flight. Below is - well. You blink, trying to take it all in.");

					outputText("\n\nMany feet below the hall swarms with activity: tall, thin, grey-green reptiles sliding sinuously around each other and the long tables that run the length of the room. There must be hundreds, no, at least a thousand basilisks down there, carrying, analyzing, sorting the vast amount of junk the tables are heaped with.");
					if (flags[kFLAGS.BENOIT_AFFECTION] == 100) outputText("  This can only be the hall that Benoit once worked in."); 
					outputText("  You get the fright of your life when you think you see a number of depthless pools of grey revolve up to meet yours- but they don’t freeze you, you note as you reflexively turn away. The tinted glass must carry some sort of anti-petrifying charm, and further it must be reflective on the other side, because no one below seems to realize you’re standing there. Relaxing a bit, you continue to absorb the massive room. At the end furthest away from you two huge piles have been created- one of eggs, a massed assortment of every colour and size imaginable, and one of pure junk, presumably everything the basilisks have found whilst scavenging and considered worth keeping. The detritus of a dozen collapsed civilizations must be down there, collected for the demons’ perusal by their scaly custodians. Directly below you, you can see archways like the one you just passed under, through which the basilisks ebb and flow.");

					outputText("\n\nYour heartbeat quickens as you consider. There is a grid gantry running from where you are right around the room to the other side, where you can see a matching observation booth, presumably containing another exit. But it’s quite a distance, there are stairs leading down to the ground level, and outside the protective glass you would surely be spotted and apprehended");
					if (player.canFly()) outputText(", even if you tried to fly it"); 
					outputText(". Wouldn’t you? You can’t outrun the gaze of a thousand basilisks... could you?"); 
					if (player.hasKeyItem("Laybans")) outputText("  You take the Laybans out of your pouch and hold them up against the glass. It’s exactly as you hoped - they are made of the same material, and are almost certainly what the demons wear when they themselves interact with the basilisks. They would surely help you get across the hall, if you were crazy enough to try.");
				}
				else
				{
					outputText("Again you creep up to the tinted glass, again you take in the vast hall with the army of basilisks below hard at work, and again you stare out at the metal gantry, with the exit tantalizingly visible on the other side."); 
					if (!player.hasKeyItem("Laybans")) outputText("  Are you going to try this?");
					else outputText("  You take the Laybans out of your pocket, turning them around in your hands as you consider. Are you going to try this?");
				}
				
				menu();
				addButton(0, "Go!", gogoFuckTheseBasilisks);
				addButton(1, "Fall Back", fallbackFromMagpieHallS);
					
				return true;
			}
			
			outputText("You are back in the Magpie Hall.  Without the bustle of activity below it is a gapingly empty and quiet place, the only sound the murmur of activity from elsewhere. There is a vast amount of collected junk below but it would take, well, an army of basilisks to sort through it to find anything worthwhile. You could check out the massive pile of eggs, though.");
			
			if (9999 == 0)
			{
				// Eggstuff
			}
			
			return false;
		}
		
		private function fallbackFromMagpieHallS():void
		{
			clearOutput();
			outputText("No, there has to be a better way.");
			if (!player.hasKeyItem("Laybans") && player.inte >= 50) outputText("  Surely the demons themselves are not immune to the basilisks’ glares - the darkened screen is proof of that. How do they interact with the creatures, then? Maybe if you keep poking around, you might find an answer.");
			outputText("\n\nYou head back through the archway into the gloomy antechamber.");
			
			menu();
			addButton(1, "Next", move, "antechamber");
		}
		
		private function gogoFuckTheseBasilisks():void
		{
			clearOutput();
			
			if (!player.hasKeyItem("Laybans"))
			{
				outputText("You breathe deep, steel yourself, and stride out onto the gantry. The plan is simple. You’ll keep your eyes up and march across as if you belong there, as if you are on official business.");
				if (player.demonScore() > 4) outputText("  You can’t be mistaken for anything but a demon, after all.");
				outputText("  If or when the lizards realize who you are, you’ll make a break for it, and hopefully by then you’ll be in reach of the exit. It’s straight-forward, it’s elegant, it will work, whatever your hammering pulse has to say on the matter.");

				outputText("\n\nYou try and not look down as you proceed, back straight and as aloof as you can.");
				if (player.isNaga()) outputText("  You’re probably imagining things but the passage of your sinuous form over the wire surface seems absurdly loud, an endless rubbing of sandpaper which seems to fill the hall.");
				else if (player.isGoo()) outputText("  Godsdamn this form... you try not to think as you slide across the wire surface, intensely aware of the slimy sound you make as you go, of the steady drip of your fluids through the mesh, trying not to think of it splashing down on curious, blunt heads.");
				else outputText("  Clack, clack, clack. You are intensely aware of the sound of your [feet] on the wire surface. You close your eyes and tell yourself you’re only imagining that it’s loud, that it echoes around the hall, that the basilisks would have to be deaf not to hear you.");

				outputText("\n\nYou are almost half of the way there when the hush descends. You keep your eyes fixed determinedly upon the exit, trying to wish away the spreading silence, the meadow of deathly grey flowers which has gradually blossomed below you.");

				outputText("\n\n<i>“C’est l’intrus!”</i>");

				outputText("\n\n<i>“Attrapez-les!”</i>");

				outputText("\n\nImmediately you break into a run, pelting for the other side, as below you there’s a general rush for the stairs. Your heart feels like it’s going to burst out of your chest as the gantry bounces to your frantic motion, and to the beat of many feet climbing it. The booth is in reach... a sickle claw catches you in the thigh, and you stagger. Growling, you frantically right yourself- only to find yourself staring directly into the face of a basilisk. You punch that one in the nose, wildly tearing your eyes away... to another. And another. They surround you as horrible leaden weights settle on your bones, your body turning into rapidly solidifying cement. You reach for your [weapon], but it’s as if it were a continent away, and the basilisks press into you, grabbing your hands and [thighs], forcing you to stare deeper and deeper into the ocean of depthless grey which surrounds you on all sides, and encompasses you, and where you were and what you were doing no longer matters, because the grey permeates your body and soul, and you are just an atom in a sky of peaceful, dove coloured submission, and whether you’re up or down or sideways or down doesn’t matter....");

				// [go to Captured]
				menu();
				addButton(0, "Next", capturedByBasilisks);
				
				return;
			}
			else
			{
				outputText("You breathe deep, steel yourself, put your shades on and stride out onto the gantry. The plan is simple- you’ll keep your eyes up and march across as if you belong there, as if you are on official business.");
				if (player.demonScore() > 4) outputText("  You can’t be mistaken for anything but a demon, after all.");
				outputText("  If or when the lizards realise who you are, you’ll make a break for it, and hopefully by then you’ll be in reach of the exit. It’s straight-forward, it’s elegant, it will work, whatever your hammering pulse has to say on the matter.");

				outputText("\n\nYou try and not look down as you proceed, back straight and as aloof as you can.");
				if (player.isNaga()) outputText("  You’re probably imagining things but the passage of your sinuous form over the wire surface seems absurdly loud, an endless rubbing of sandpaper which seems to fill the hall.");
				else if (player.isGoo()) outputText("  Godsdamn this form... you try not to think as you slide across the wire surface, intensely aware of the slimy sound you make as you go, of the steady drip of your fluids through the mesh, trying not to think of it splashing down on curious, blunt heads.");
				else outputText("  Clack, clack, clack. You are intensely aware of the sound of your [feet] on the wire surface. You close your eyes and tell yourself you’re only imagining that it’s loud, that it echoes around the hall, that the basilisks would have to be deaf not to hear you.");

				outputText("\n\nYou are almost half of the way there when the hush descends. You keep your eyes fixed determinedly upon the exit, trying to wish away the spreading silence, the meadow of deathly grey flowers which has gradually blossomed below you.");

				outputText("\n\n“<i>C’est l’intrus!</i>”");

				outputText("\n\n“<i>Attrapez-les!</i>” Immediately you break into a run, pelting for the other side, as below you there’s a general rush for the stairs. Your heart feels like it’s going to burst out of your chest as the gantry bounces to your frantic motion, and to the beat of many feet climbing it.");
 
				if (player.spe < 90)
				{
					outputText("\n\nThe booth is in reach... a sickle claw catches you in the thigh, and you stagger. Growling, you frantically right yourself- only to find yourself staring directly into the face of a basilisk. You punch that one in the nose, wildly tearing your eyes away... to another. And another. They surround you and though you wheel around, desperately pushing and elbowing them away from you, you cannot stop one deftly hooking your Laybans off with his sickle claw. A horrible leaden weight settles itself upon your bones as your naked gaze is trapped by a dozen basilisk eyes, your body turning into rapidly solidifying cement. You reach for your [weapon], but it’s as if it were a continent away, and the lizards press into you, grabbing your hands and [thighs], forcing you to stare deeper and deeper into the ocean of depthless grey which surrounds you on all sides, and encompasses you, and where you were and what you were doing no longer matters, because the grey permeates your body and soul, and you are just an atom in a sky of peaceful, dove coloured submission, and whether you’re up or down or sideways or down doesn’t matter...");

					//[go to Captured]
					menu();
					addButton(0, "Next", capturedByBasilisks);	
					
					return;
				}
				else
				{
					outputText("\n\nThe booth is in reach... your panic unlocks a final reserve in your straining muscles and you");
					if (!player.canFly()) outputText(" almost");
					else outputText(" literally");
					outputText(" fly towards the door. A solitary basilisk manages to clamber onto the catwalk ahead of you- and you simply bull-rush straight through him, his deathly eyes useless against your screened vision. You think you feel the passage of sickle claws scything fruitlessly through the air inches away from your back as you bundle through the exit and into the empty observation booth. In an ecstasy of terror you fumble with the door and manage to slam it shut, just as several heavy bodies thud into the other side. You breathe a huge sigh of relief as your hands find a deadbolt and slide it across, sealing the basilisks off from you. They hammer at it for a while longer, shouting and hissing angrily, but eventually, whilst you’re still gathering your breath, they get fed up with it and leave.");
					
					outputText("\n\nYou’re free to continue- but you will have to find an alternative route if you want to go back, unless you’re crazy enough to unlock the door and try the catwalk dash again.");
					
					menu();
					addButton(0, "Next", move, "magpiehalln");
				}
			}
		}
		
		private function capturedByBasilisks():void
		{
			clearOutput();
			outputText("Down. You’re staring up at the ceiling of the magpie hall, from your position upon your back. Your limbs are seized up, are not responding to any of your brain’s frantic demands, and you can only see what is in the corner of your frozen gaze, which is lots and lots of basilisks standing over you staring back.");

			outputText("\n\n“<i>Que devrions-nous faire?</i>” says one.");

			outputText("\n\n“<i>Chercher le Roi Grossier,</i>” says another, after a heavy pause. A murmur ripples through the hall at that. You have no idea what they’re saying in their raspy, fluid tongue, but you can’t imagine it’s anything good. One in the corner of your vision darts out of sight, and you are left to wait, a statue frozen in the stance of a running struggle. You feel dense apprehension weigh steadily more and more upon you as a heavy footstep thuds towards you.");

			outputText("\n\n“<i>J'espère que vous m'avez dérangé pour une bonne raison, soldat, ou je vais vous la peau vivante et baise ta cadavre tremblement. Mes dieux! C'est vrai!</i>” Dry, smooth hands grip you and winch you up so you may see the owner of the thick, rich voice. It’s a basilisk- but bigger, at least a foot taller than those that surround him, heavier built, and obviously simmering deep in corruption. Purple scales slather his shoulders and back like an imperial cloak, and he is clad in a military tunic and ornate brass cuirass. The former does absolutely nothing to disguise his two thick, purple pricks, which unlike those of his brethren swing freely and imposingly between his muscled legs. His long, tapering face gives him a toothy sneer of epic proportions, and his proud head is crowned with a helmet, resplendent with a long, black ponytail. His eyes... you renew your frantic efforts to look away. Leering, the basilisk rex steps closer to you, bathing you in their hungry glare. They are a seething yellow, pupil-less, two eternal, burning suns of depthless corruption.");

			outputText("\n\n“<i>Pouvez-vous me comprendre, intrus? Non? Sprechen de Gnollen? How about now? Ah, yes. Human. The language of masters... and slaves.</i>” His widening sneer leaves you in no doubt which camp he considers you as belonging to. “<i>I am Jean-Claude, the Rude King, if you please. You are the interloper, if you please. Ah, yes! Yes you are! Do not try to deny it!</i>” He laughs richly, his slow, velvety voice rolling around you as he goes on. “<i>You have beat up enough of my scouts that you have left, eh, an impression, shall we say? We do not need orders from the demons to watch out for such a rough player as you!</i>” He moves as fast as a snake, belying his size and frame, to grab you tight around the jaw. His claws dig into your skin as he stares deep into your eyes, encompassing you in their rich, bottomless glow. It glows like your blood glows, rising to the surface of your skin, coursing inexorably to your groin,");
			if (player.hasCock()) outputText(" [eachCock] stiffening");
			if (player.hasCock() && player.hasVagina()) outputText(" and");
			if (player.hasVagina()) outputText(" your [vagina] beading with excitement");
			if (!player.hasCock() && !player.hasVagina()) outputText(" your loins aflame with excitement");
			outputText(" as you sink further into the yellow warmth, immersing yourself in it, so small and pliant and willing to be shaped by that fathomless, over-arching will, this huge masculine creature with a body of carved strength, with his feral, demanding smell surrounding you, with his big, luscious cocks....  The other basilisk’s spell is fading from your limbs, allowing you to move, but it is no respite at all- the more you stare into the eyes in front of you now, the weaker you feel, the more you want to puddle onto the floor and supplicate yourself before their power.");

			outputText("\n\n“<i>But now the ball is in the basilisk court, is it not, interloper?</i>” Jean-Claude growls softly, holding your face close, pulling you deeper and deeper into his glow, bathing you in heat. “<i>And the only question now is how I am going to serve you.</i>”");

			if (player.inte >= 80)
			{
				outputText("\n\nThe last of the petrifying curse slips from your limbs and a thought leaps lightning fast through your mind, cutting through the warm haze for a moment. It tells you that you have to act now - with your body free of the grey and your mind still resisting the gold. What do you do in this one, free, desperate moment?");
				
				menu();
				addButton(0, "Taunt", capturedbyBasilisksTaunt);
				addButton(1, "Run", capturedByBasilisksRun);
			}
			else
			{
				menu();
				addButton(0, "Next", jeanClaude.basiliskBadEnds);
			}
		}
		
		private function capturedByBasilisksRun():void
		{
			clearOutput();
			outputText("With all your willpower you tear away from the monster’s lidless gaze. His sharp claws graze your cheeks as you throw yourself backwards, turn and charge with a defiant cry into the ranks of reptiles which surround you. You have your [weapon] loose, and you swing it this way and that, adrenaline and desperation lending you strength as you send basilisks flying... but there are hundreds of them, and one of you, and too many places not to look. You strike, you punch, you scratch, you bite, but eventually your limbs tire; they seize up as you tear yourself away from one grey gaze only to find another, and the basilisks simply have to surround you, pack you tight with their bodies while one of them stares deep into your eyes, flooding your mind with a blaring, hypnotic wash. There’s a sound coming from somewhere: a strange, staccato bark. It’s only when the lizards return you frozen to the feet of their king that you realize what it is. The Rude King is laughing, sat on a table and doubled up with gulping mirth.");

			outputText("\n\n“<i>You’re fast, interloper! And you fight good! But not so bright, eh? I think you think fast, but a stupid thought is a stupid thought, whether it takes a second or an hour to arrive.</i>” He reaches forward and almost tenderly takes you by the cheek again, rubbing the lines he left there with his smooth thumb, forcing you to look back into his eyes. “<i>See? All you managed was to damage yourself. That’s no good to anyone, is it?</i>” It occurs to you that since you were captured none of the basilisks have used their claws or teeth against you, and you realize why that is- they want you whole. You groan deep in your still throat as the hot, yellow glow of Jean-Claude’s eyes encompasses you.");

			// [go to bad ends]
			menu();
			addButton(0, "Next", jeanClaude.basiliskBadEnds);
		}
		
		private function capturedbyBasilisksTaunt():void
		{
			clearOutput();
			outputText("You stare into the yellow, hypnotic eyes and for a moment see beyond them, see them as part of this being rather than the whole, see the arrogance that sits behind them, see, perhaps, a way out of this. With all your willpower you force your mouth to open, work your vocal chords- and make a 'pfft' noise.");

			outputText("\n\n“<i>Some king you are,</i>” you manage. Jean-Claude draws back, looking slightly surprised, and emboldened you press on. “<i>Your servants did all the hard work- you just came out to claim all the credit at the end. Is that how it works for basilisks? You get the day-glo eyes for sucking demon dick, and then sit on your ass whilst everybody else does the thinking and fighting for you?</i>”");

			outputText("\n\n“<i>You dare...</i>” the rex whispers, deep in his throat. His eyes have turned a yellowish white. You raise your voice, so every basilisk in the hall can hear.");

			outputText("\n\n“<i>I haven’t been here five minutes and I can already tell what kind of ruler you are. Doesn’t matter how many extra inches you’ve given yourself by kissing imp ass- you’re the smallest lizard in this room. Your kind will fight and die for you whilst you, with your fancy armour, will cower in the corner and wait for it to be over. You think you frighten me, that you impress me? You wouldn’t dare fight me, and everybody here knows it!</i>” A deathly silence ensues. Jean-Claude stares at you, fury clenching his long face, and for a moment you think he might just bite your head off. Then he looks up, blinks, and roars with laughter.");

			outputText("\n\n“<i>Ahahaha! I like it interloper, I like it a lot. Being rude to the Rude King! You think to make me angry so I make a mistake, yes? Even when it is all over for you, you are being clever, you are fighting.</i>” He turns away, snorting. The monstrous basilisk might be affecting bonhomie, but in the fractious swish of his tail and the whiteness of his eyes, you see that you have succeeded- you’ve pissed him off. He barks something to one of his brethren. The others murmur, and there’s a hushed sound as they fall back, forming a ring around the two of you. Something is thrown to Jean-Claude; he catches it and swishes it thoughtfully, before turning back to you.");

			outputText("\n\n<i>“Here’s the problem, interloper,”</i> he says, sneering at you as he points the huge, bronze cutlass down. <i>“I don’t make mistakes. You can. By the end, you will appreciate just how serious a mistake it was to fight me. How much better it would have been to simply accept your fate.”</i>");

			outputText("\n\nYou scramble to your feet, draw your weapon and set your jaw. You’ve gotten your one shot, and you can’t waste it.");
			
			startCombat(new JeanClaude());
		}
		
		private function magpiehallnRoomFunc():Boolean
		{
			if (flags[kFLAGS.D3_JEAN_CLAUDE_DEFEATED] == 0)
			{
				outputText("You find yourself back in the small booth, with the locked door leading out into the Magpie Hall. Just like the one on the opposite side, there is a darkened screen here through which you can see hundreds of basilisks milling down below, sorting through the vast amount of junk and eggs they have collected from the mountainside. They don’t seem to have taken any extra precautions following your narrow escape of them- the gantry remains free of any guards, and the door on the other side looks open.");
				
				menu();
				
				addButton(0, "Go!", gogoFuckTheseBasilisksNorth);
				addButton(1, "Stronghold", move, "tunnel2");
				
				return true;
			}
			
			outputText("You are back in the Magpie Hall. Without the bustle of activity below it is a gapingly empty and quiet place, the only sound the murmur of activity from elsewhere. There is a vast amount of collected junk below but it would take, well, an army of basilisks to sort through it to find anything worthwhile. You could check out the massive pile of eggs, though.");
			return false;
		}
		
		private function gogoFuckTheseBasilisksNorth():void
		{
			clearOutput();
			outputText("You put your Laybans back on, carefully unlock the door and then, as quietly as you can, creep back out onto the wire gantry. The throng of greyish green below seems oblivious. It’s only when you get halfway across that you realise that you’ve been had. As soon as you are as far away from one exit as the other, two big groups of the lizards near the stairs immediately jump up and climb upwards determinedly. You speed as fast as you can to the door ahead, but the team of basilisks are ready and plough into you, grabbing your body as they reach for your shades. You desperately push and elbow them away from you but you cannot stop one from deftly hooking your Laybans off with his sickle claw. A horrible leaden weight settles upon your bones as your naked eyes gaze into a dozen basilisk eyes, your body turning into rapidly solidifying cement. You reach for your [weapon], but it’s as if it were a continent away, and the lizards press into you, grabbing your hands and [thighs], forcing you to stare deeper and deeper into the ocean of depthless grey which surrounds you on all sides, and encompasses you, and where you were and what you were doing no longer matters, because the grey permeates your body and soul, and you are just an atom in a sky of peaceful, dove coloured submission, and whether you’re up or down or sideways or down doesn’t matter...");
			
			menu();
			addButton(0, "Next", capturedByBasilisks);
		}
		
		private function tunnel2RoomFunc():Boolean
		{
			outputText("Light trickles in from the east. After all the trekking through these subterranean holes, you’ve got to be close to the mountain’s summit. You know that down the steeply sloped passage will take you back through the basilisks’ chamber if you want to leave the way you came, but a second trip through that crowded hall might be ill-advised. It’d be best to move forward into the sun.");
			return false;
		}
		
		private function edgeofkeepRoomFunc():Boolean
		{
			outputText("Standing on the edge of the mountain's summit, you can see Mareth for miles in all direction. It's fairly disconcerting to focus on long with the constant shifting and twisting of the wasted areas, but here and there you can pick out islands of stability in the ephemeral terrain. You blink your eyes to clear the nauseating landscape from your view and turn back to the way ahead. Lethice's fortress lies a short distance to the north, its walls tall and stout. The gates themselves hang open. Likely she didn't expect anyone to make it this far.");
			return false;
		}
		
		private function northentryRoomFunc():Boolean
		{
			outputText("You now stand in the archway that is the southern entrance to Lethice's headquarters. The place is built like a castle. You can't see too much from your shaded position, but the bricks that surround you are individual as big as horses. The gates themselves are crafted of wood that looks at least a century old, reinforced with bands of gleaming metal that you doubt will ever rust. A barren cliffside can be seen to the south, the demon queen's lair to the north.");
			return false;
		}
		
		private function southcourtyardRoomFunc():Boolean
		{
			outputText("Lethice's courtyard is surprisingly well-groomed for a place that's supposedly home to neverending debauchery and depravity. The paths are laid with interconnecting sandstone bricks that reflect the sun to give the place a gentle, amber glow, and lush, green grass lines the sides along with well-trimmed hedges. You could almost mistake this place for a churchyard if it wasn't for the faint sound of moans on the wind. The courtyard paths lead away east and west, while the gateway out hangs open to the south.");
			return false;			
		}
		
		private function southwestcourtyardRoomFunc():Boolean
		{
			outputText("Some of the nearby bushes are blooming, filling the air with their sweet scent, unlike any flowers you’ve encounter before. Their petals are a multitude of colors, and their scents, though laced with corruption, are as sweet and pleasant as anything you've had the pleasure of smelling. The path you're treading upon curves north and east from here along the thick, red walls. Vines seem to crowd the way to the north. There are no signs of any ramps or ladders to get to the battlements, but there is a doorway to the west marked as 'Forge Wing'. A notice declares it closed for repairs.");
			return false;
		}
		
		private function southwestwalkRoomFunc():Boolean
		{
			outputText("The bushes surrounding the path have given way here to a mass of tentacles, some still bedecked in the flowers that surround the air. They twist and writhe but seem content to stay in their place for now. Besides, if you hang back along the edge of the walk, you should be out of their reach. The path heads north and south... if the wall of oily-looking tendrils leaves you alone.");
			
			if (flags[kFLAGS.D3_GARDNER_DEFEATED] == 0)
			{
				outputText("\n\nThe slick foilage parts just ahead, revealing a lissom leg clad in green hosiery that resembles the spiderwork patterns of leafy veins more than any garment. It's owner follows but a moment later, so perfectly, wonderfully shapely that you freeze in place, compelled by biology to take notice. Her expansive bosom, womanly hips, and gentle, soft curves invite you to fall into her embrace. Her lips, full and pouting, beckon for you to taste them. Her hair's lustrous shine glitters like an angler fish's lure, just out of reach and oh so foolish to pursue. The smooth, twists of her ram-like horns keep her coiffure stylish while simultaneously jolting you out of your reverie.");
				
				outputText("\n\nYou shake your head to regain your focus. This is a demon, and you won't fall for her tricks this easily");
				
				if (9999 == 0) // I'm not sure what this variation was supposed to point at specifically.
				{
					outputText("!");
				}
				else
				{
					outputText(".... You grope yourself absentmindedly as you consider just how long you'll hold out before submitting. It won't be long.");
				}
	
				outputText("\n\n<i>\"Why hello there,\"</i> the corrupt temptress says with a tone that's the auditory equivalent to a pat on the head. <i>\"You must be [name]. Did you come all this way just to join my garden?\"</i> The corner of the succubus' mouth curls ever so slightly, her lips gleaming invitingly. <i>\"Or perhaps you could be my first non-floral pet. Would you like that?\"</i> She arches her back to present her breasts to you, held aloft by their own incredible, perfect shape and framed by a skimpy underbust covering that only serves to highlight her hard, perky nipples. They gleam with moisture - milk you suppose.");
				
				outputText("\n\nShe smiles encouragingly. <i>\"What'll it be?\"</i>");
				
				//[Surrender] [Fight]
				menu();
				addButton(0, "Surrender", succubusGardener.surrenderToTheGardener);
				addButton(1, "Fight", startCombatImmediate, new SuccubusGardener());
	
				return true;
			}
			
			return false;
		}
		
		private function westwalkRoomFunc():Boolean
		{
			outputText("Pollen clings to you, released by the many flowering bushes in the area. They only grow thicker to the south, too. To the east, you can");
			if (flags[kFLAGS.D3_STATUE_DEFEATED] == 0) outputText(" see a massive statue with an immense hammer");
			else outputText(" a mound of rubble, the scattered remains of the animated statue that you slew");
			outputText(". The warm, sandstone bricks underfoot fork in a T-intersection, leading north, east, and south. The thick castle walls prevent passage to the west.");
			
			return false;
		}
		
		private function northwestwalkRoomFunc():Boolean
		{
			outputText("A narrow path splits from the sandstone thoroughfare towards a pair of double doors to the west. The craftsmanship of the carpenter who made them is on full display; intricate designs of dragons engaged in sexual positions of all kinds are carved around the outer edges of the frame while more mundane, eye-pleasing patterns decorate the center panels. Above, a sign designates this area as the library. Unfortunately the doors are sealed closed. Perhaps the library is not yet written. You smirk at your own joke.");
			outputText("\n\nThe courtyard itself continues much as it has elsewhere. The bushes to the south appear more unruly than elsewhere, but to the north there appears to be nothing but pleasant walking through this botanical paradise.");
			return false;
		}
		
		private function northwestcourtyardRoomFunc():Boolean
		{
			outputText("The courtyard comes to an abrupt end here, hemmed in by a impressively high stone wall to the north, high enough to shame the walls in the other cardinal directions. The path is also bounded in by stonework to the west, forcing it to curve to the east and south around a bush that has been tastelessly shaped to resemble a turgid prick. The demons even went so far as to trim ivory flowers into a contiguous path along one side, very much looking like a stream of arboreal spunk.");
			return false;
		}
		
		private function northcourtyardRoomFunc():Boolean
		{
			outputText("You stand before what can only be the entrance to Lethice’s throne room. It is unlabelled, but the immense door is unlike any you’ve seen in this world or the last. Constructed from some kind of pink-tinged metal and polished to a mirror sheen, this portal has had a lifetime of care poured into it. What’s more, intricate locking mechanisms overlap the edges of it, each one culminating in an intricately worked seal. Fortunately, each of the seals has been left over. Security must not be much of a concern for the demon queen at this point in time. If only the door would open. For some reason, it’s still sealed closed. You can still move east and west through the courtyard, if you like.");
			return false;
		}
		
		private function northeastcourtyardRoomFunc():Boolean
		{
			outputText("This particular corner of the courtyard feels remarkably cramped, even a little claustrophobic. To the north, a stone wall rises, dwarfing the smaller one to the east, and to make matters worse, the hedges to the southwest are high and square, virtually a wall in their own right. The only avenues of travel available are to the south or west, following the red sandstone bricks as they bend around the corner.");
			return false;
		}
		
		private function norteastwalkRoomFunc():Boolean
		{
			outputText("The air is pleasant and free here. Not even the corrupt nature of this place can stop you from enjoying this moment in the demon queen’s garden. Still, there is an aura of lingering danger here. The flowers smell pleasant but somehow off, and every now and again the breezes carry the sounds of whorish moans. An entryway in the east wall leads towards the barracks and mess, identified by a simple sign to the left of the imposing iron door frame. Fortunately, the door is barred and sealed. It seems you’ve come at a time when Lethice’s fortress is near empy. How fortunate for you.");
			return false;
		}
		
		private function eastwalkRoomFunc():Boolean
		{
			outputText("The smooth, almost flawlessly laid stones split into a T-intersection here, heading north, south, and west. The bushes that hem in the paths are likewise split, though they have been maintained with the same sense of care you’ve seen elsewhere in the garden. One particularly interesting shrub has been trimmed into the shape of a large bust, complete with erect nipples. You shake your head and glance west, where you can spot {a massive statue with an immense hammer/a mound of rubble, the scattered remains of the animated statue that you slew}.");
			return false;
		}
		
		private function southeastwalkRoomFunc():Boolean
		{
			outputText("Swarms of butterflies congregate on the flowering bushes here. At first, the sight seems beautiful, almost pristine. Then, you spot the endemic corruption that Lethice has spread through the lands. They aren’t just swarms of butterflies - they’re swarms of mating butterflies, crawling all over each other in a swarm of sweet-smelling pollen and fluttering wings. You had best move on. The path leads north and south.");
			return false;
		}
		
		private function southeastcourtyardRoomFunc():Boolean
		{
			outputText("Walking along the sandstone path, you're treated to a remarkably peaceful view. Up here, above the clouds the ring the mountain, it's almost too easy to let your guard down. A small hole in the southern wall of Lethice's fortress appears to the south. Peeking through, you can see machinery and some kind of lift suspended over the cliffside. That must be how the demons can come and go safely. You can continue to walk among the bushes to the north and west. An iron door to the east bears lettering denoting it as 'recreation'. A small placard explains that it's currently off limits due to renovations. Graffiti below complains about some contractor named Fenoxo delivering on his promised work schedule.");
			return false;
		}
		
		// 9999 - Check this
		private function courtyardsquareRoomFunc():Boolean
		{
			//Statue not exploded - mossy - 30’ high
			outputText("A circle of polished stone wraps around a colossus here in the center of the courtyard, ringed by cushioned benches that would be a delight to sit on were they not stained with bodily fluids of all colors and sexes. You didn’t think pink cum was possible, but the demons’ endless sexual creativity doesn’t seem to be bound by such notions. You can leave east and west from here.");

			if (flags[kFLAGS.D3_STATUE_DEFEATED] == 0)
			{
				outputText("\n\nWait... what’s that?");

				menu();
				addButton(0, "Next", livingStatue.encounter);
				return true;
			}

			outputText("Two disembodied, marble feet and a field of rubble are all that remains of the once proud statue that stood in the center of the courtyard. You dealt with the animated monstrosity but can’t help but feel a little shame at the destruction you’ve so openly wrought. Many of the bushes are torn in half by two ton slabs, and the path is scarred in a dozen places by chips and smashed divots. You can go east and west from here, if you move carefully around the more jagged pieces of stone.");
			
			return false;
		}

		private function greatliftRoomFunc():Boolean
		{
			outputText("Intricate stonework supports this precarious platform as it juts from the side of Lethice's fortress, hanging over a sheer cliff that must go down for hundreds of feet. The harpies appear to have moved away from the area immediately below, whether by choice or by demonic action, though you can still spot a few of their nests in other places on the mountainside. A complicated looking machine sits on the side of the platform, attached to a cage that dangles over the edge, supported by a lowly metal cable. It must be some kind of mechanical lift - a way to come and go as one would please.");
			
			incubusMechanic.meetAtElevator();
			
			return false;
		}
	}
}