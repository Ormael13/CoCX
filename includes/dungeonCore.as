public function dungeonRoom(roomNo:Number):void {
	//Dungeon Choices!
	var choice1:Number = 0;
	var text1:String = "";
	var choice2:Number = 0;
	var text2:String = "";
	var choice3:* = 0;
	var text3:String = "";
	var choice4:Number = 0;
	var text4:String = "";
	var choice5:* = 0;
	var text5:String = "";
	var choice6:Number = 0;
	var text6:String = "";
	var choice7:Number = 0;
	var text7:String = "";
	var choice8:Number = 0;
	var text8:String = "";
	//Always have choices for items or masturbation. 
	var itemMenu:Number = 1000;
	var masturbateMenu:Number = 10;
		
	//Display Proper Buttons
	mainView.showMenuButton( MainView.MENU_APPEARANCE );
	mainView.showMenuButton( MainView.MENU_PERKS );
	mainView.hideMenuButton( MainView.MENU_DATA );

	
	//clear up/down arrows
	hideUpDown();
	//Level junk
	if(player.XP >= (player.level) * 100) {
		mainView.showMenuButton( MainView.MENU_LEVEL );
		mainView.statsView.showLevelUp();
	}
	//Entry Room
	if(roomNo == 0) {
		outputText("<b><u>The Factory Foyer</u></b>\nThe door swings shut behind you with an ominous 'creeeeeaaaaaaak' followed by a loud 'SLAM'.  Glancing around, you find yourself in some kind of stylish foyer, complete with works of art and a receptionist's desk.  Looking closer at the paintings on the wall quickly reveals their tainted and demonic nature: One appears at first to be a painting of a beautiful smiling woman, except you notice dripping tentacles coiling around the hem of her dress.  Behind the receptionist's desk, the second painting is even less discreet, openly depicting a number of imps gang-raping a vaguely familiar-looking woman.  Luckily, whatever demon is employed as the receptionist is away at the moment.  Behind the desk on the northern wall stands a secure-looking iron door.  On the eastern wall is a simple wooden door, though the color of the wood itself is far darker and redder than any of the hard woods from your homeland.  Behind you to the south is the rusty iron entry door.", true);
		choice1 = 11001;
		text1 = "North";
		choice2 = 11002;
		text2 = "East";
		choice7 = 11010;
		text7 = "South";
	}
	//Pump Room
	if(roomNo == 1) {
		if(player.hasStatusAffect("DungeonShutDown") < 0) {
			outputText("<u><b>Pump Room</b></u>\nAs you step through the iron door, a cacophony of thrumming mechanical noise assaults your ears.  Coppery pipes arch overhead, riveted into spiked iron brackets that hang from the ceiling in twisted pairs.  The constant thrum-thrum-thrum of concealed pumps and mechanisms makes it difficult to hear anything, but you swear you can make out the faint sounds of sexual pleasure emanating from the northwest side of the room.  Investigating further, you spot a door along the west wall of the room that appears to be the source of the licentious sounds.  The vibrations of all the machinery are strongest along the east walls, indicating the possible site of this hellish place's power-plant. There is a door on the east wall and a door on the north.  To the south is a solid iron door that leads back to the lobby.", true);
		}
		else outputText("<u><b>Pump Room</b></u>\nAs you step through the iron door, silence is the only noise you hear.  Coppery pipes arch overhead, riveted into spiked iron brackets that hang from the ceiling in twisted pairs.  The near-complete silence of the place unnerves you, but allows you to make out the faint sounds of sexual pleasure emanating from northwest side of the room.  Investigating further, you spot a door along the west wall of the room that appears to be the source of the licentious sounds.  There are two other doors, one along the east wall and one on the north.  To the south is a solid iron door that leads back to the lobby.", true);
		choice1 = 11004;
		text1 = "North";
		choice2 = 11003;
		text2 = "East";
		choice7 = 11000;
		text7 = "South";
		choice6 = 11005;
		text6 = "West";
	}
	//Break Room
	if(roomNo == 2) {
		spriteSelect(96);
		outputText("Stepping through the dark red doorway, you wander into an expansive break room. Tables surrounded by crude wooden chairs fill most of the floor space. Along the far eastern wall sits a small counter, complete with a strange ebony sculpture of a busty woman with 'Mrs. Coffee' printed on the side. Below the sculpture is a pot of steaming hot coffee, giving off an invigoratingly rich smell.", true);
		//Hooks for succubi encounter
		//(if succubus gone/defeated)
		if(player.hasStatusAffect("FactorySuccubusDefeated") >= 0) {
			choice7 = 0;
			text6 = "West";
			if(player.hasKeyItem("Iron Key") < 0) {
				outputText("  It seems your opponent dropped a small iron key as she fled.", false);
				choice3 = 11028;
				text3 = "Iron Key";
			}
			choice6 = 11000;
			text5 = "Coffee";
			choice5 = 11011;
		}
		else {
			spriteSelect(55);
			outputText("\n\nStanding next to the coffeemaker is a blue-skinned woman holding a mug of coffee.  As she takes a sip, oblivious to your presence, you see the mug has '#1 Dad' written on it.  Dressed in a tiny vest, short skirt, and sheer stockings, she looks every bit an air-headed secretarial ditz.  Her two horns are little more than nubs, mostly covered by her flowing blond hair, and if it wasn't for her blue skin and the tip of a spaded tail peeking out from under her skirt, you'd never know what she was.\n\n", false);			
			// demon bad end available
			if(player.demonScore() >= 4 && player.cor > 75) {
				outputText("The busty succubus turns, her barely contained breasts jiggling obscenely as she notices you, \"<i>Oh, like hi there ", false);
				if(player.gender == 1) outputText("stud", false);
				else outputText("sexy", false);
				outputText("!</i>\"  She stops, sniffing the air, a curious expression on her face as she slowly circles you, her heals clicking loudly on the floor.  A knowing grin blooms across her face as understanding hits her.\n\n", false); 
				outputText("She exclaims, \"<i>Omigawsh!  You're the champion!  Your, like, soul is still there and everything!  But, you're like, completely corrupt an' stuff!  Ya know what'd be fun?  I could fuck you till you cum so hard your soul melts out an' you turn into a demon.  Wouldn't that be great?</i>\"\n\n", false);
				outputText("The secretarial demoness pulls out a file and fiddles with her nails, murmuring, \"<i>I guess if you don't wanna, we could just hook you up in the factory.  What's it gonna be?</i>\"", false);
				text1 = "Fight";
				choice1 = 11016;
				text2 = "Go Demon";
				choice2 = 2191;
				text3 = "Hook Up";
				choice3 = 11015;
				masturbateMenu = 0;
				itemMenu = 0;
			}
			//Not recognized
			else if(player.humanScore() <= 3) {
				outputText("The busty succubus turns, her barely contained breasts jiggling obscenely as she notices you, \"<i>Oh, like hi there ", false);
				if(player.gender == 1) outputText("stud", false);
				else outputText("sexy", false);
				outputText("!  You haven't seen a confused human about calling itself a champion have you?</i>\"\n\nShe shakes her more-than-ample bosom from side to side as she licks her lips and offers, \"<i>If you do, be sure and bring them back here ok?  We've got their spot all ready for them, but that little prick Zetaz fucked up the pickup.  Tell you what – if you bring me the 'champion' I'll ", false);
				if(player.totalCocks() > 0) outputText("give you the blowjob of a lifetime", false);
				else if(player.hasVagina()) outputText("lick your honeypot till you soak my face", false);
				else outputText("give you a new addition and show you how to use it", false);
				outputText(".</i>\"\n\nThe succubus turns away from you and makes a show of tweaking her make-up, ignoring you for the moment.", false);
				text1 = "Fight";
				choice1 = 11016;
				text2 = "It's Me!";
				choice2 = 11065;
				text3 = "Leave";
				choice3 = 11000;
				masturbateMenu = 0;
				itemMenu = 0;
			}
			else {
				outputText("The busty succubus turns, her barely contained breasts jiggling obscenely as she notices you, \"<i>Oh, like hi there ", false);
				if(player.gender == 1) outputText("stud", false);
				else outputText("sexy", false);
				outputText("!  What's a cute little morsel like you doing by yourself out here?</i>\"", false);
				text1 = "Fight";
				choice1 = 11016;
				text2 = "Talk";
				choice2 = 11013;
				text3 = "Run";
				choice3 = 11000;
				masturbateMenu = 0;
				itemMenu = 0;
			}
		}
	}
	//Furnace Room
	if(roomNo == 3) {
		if(player.hasStatusAffect("DungeonShutDown") < 0) {
			outputText("<b><u>Furnace Room</u></b>\nThe air inside this room is hot enough to coat your " + player.skinTone + " " + player.skinDesc + " in a fine sheen of sweat.  The eastern side of the chamber is more machine than wall, a solid mass of iron piping covered in small metal blast-doors through which fuel is to be fed.  A small transparent plate is riveted into the wall, allowing you to see some kind of pink crystalline fuel being burned by purple-white fire.  The few visible controls and gauges don't seem to be linked into anything important, and the machinery looks far too durable to damage with what you have.  The only exit is a heavy iron door on the west wall.  ", true);
		}
		else {
			outputText("<b><u>Furnace Room</u></b>\nDespite the machinery being shut down, the air in this room is still hot enough to coat your " + player.skinTone + " " + player.skinDesc + " in a fine sheen of sweat.  The eastern side of the chamber is more machine than wall, a solid mass of iron piping covered in small metal blast-doors through which fuel is to be fed.  A small transparent plate is riveted into the wall, allowing you to see some the ashes of a previous fuel source.  The few visible controls and gauges don't seem to be linked into anything important, and the machinery looks far to durable to damage with what you have.  The only exit is a heavy iron door on the west wall.  ", true);			
		}

		if(player.hasStatusAffect("FactoryIncubusDefeated") >= 0) {
			text6 = "West";
			choice6 = 11001;
		}
		//Incubus is ALLLLIVE
		else {
			spriteSelect(30);
			if(player.hasStatusAffect("IncubusBribed") >= 0) {
				outputText("\n\nThe incubus mechanic is here, thumbing through a hentai comic and laughing to himself at the absurdity of it.  That doesn't stop him from stroking his half-hard member the whole time...", false);
				choice2 = 11031;
				text2 = "Fight";
				text6 = "West";
				choice6 = 11001;
			}
			else {
				outputText("\n\nA demonic mechanic lounges against the hot machinery, unperturbed by the high temperatures of the room.  He wears cut-off denim overalls, stained with grease in a few places.  They don't seem to be in good repair, and have a fair-sized hole at his groin, where a floppy foot-long member hangs free.  His skin is light purple and unblemished, as you would expect from a sexual demon.  He has a rugged handsome face and black hair tied back in a simple ponytail.  Two large curving horns protrude from his forehead, curving back along his skull and giving him a dangerous appearance.  A narrow goatee grows from his chin, about 3 inches long and braided skillfully.  He looks up and smiles, amused at your appearance.", false);
				choice1 = 11031;
				text1 = "Fight";
				text2 = "Talk";
				choice2 = 11032;				
			}
		}
	}
	//Repair Closet
	if(roomNo == 4) {
		outputText("<b><u>Repair Closet</u></b>\nAs you carefully slip inside the room, you note with some relief that it seems to be an empty storage closet. The room is tiny, barely 6' by 8' and almost entirely empty.  The one piece of furniture inside the closet is a simple wooden cabinet, placed against the far wall.  ", true);
		if(player.hasStatusAffect("BUILT: Milker") >= 0) outputText("The shelves are empty.  ", false);
		else {
			outputText("The shelves of the cabinet hold various pieces of pump machinery, probably used to repair complete machines further into the factory.  ", false);
			if(player.inte >= 40) {
				outputText("You realize there are enough pieces here to put together a breast-milking pump or a cock-milker.  ", false);
				if(player.hasKeyItem("Cock Milker") >= 0) outputText("\nYou already have a cock milker.\n", false);
				else {
					choice4 = 11029;
					text4 = "C. Milker";
				}
				if(player.hasKeyItem("Breast Milker") >= 0) outputText("\nYou already have a breast milker.\n", false);
				else {
					choice3 = 11030;
					text3 = "B. Milker";
				}
			}
		}
		text7 = "South";
		choice7 = 11001;
		outputText("The only exit is back to the south.", false);
	}
	//Main Chamber
	if(roomNo == 5) {
		//Dungeon still operational
		if(player.hasStatusAffect("DungeonShutDown") < 0) {
			outputText("<b><u>Main Chamber</u></b>\nThis cavernous chamber is filled with a cacophony of sexual moans.  Rows of harnesses are spaced evenly throughout this room, nearly all of them filled with delirious-looking humans.  Each is over-endowed with huge breasts and a penis of elephantine proportions.  The source of their delirium hangs down from the ceiling - groups of hoses that end with needles buried deep into the poor 'girls' flesh, pumping them full of demonic chemicals.  Constant sucking and slurping noises emanate from nipple and cock pumps as they keep the victims in a state of near-constant orgasm.  ", true);
			if(player.cor < 50) outputText("You wish you could free them, but it would take the better part of a day to get them all free.  It'd be better to find the control room and shut down the infernal machinery.  ", false);
			else outputText("You wish you had some machinery like this for yourself.  It looks so fun!  Still, you suppose you should find the control panel to shut this down and free these people.  ", false);
			outputText("There is a doorway to the east marked with an 'exit' sign above it.  Along the southern wall is a stairwell that leads up to some kind of foreman's office.  Perhaps the controls are in there?", false);
		}
		//Dungeon shut down.
		else {
			outputText("The chamber is significantly emptier since you've shut down this factory.  Roughly half the girls appear to have left.  The rest seem to be pre-occupied by fucking each other in a massive orgy.  A few enterprising ladies have found leather outfits and appear to be helping to manually administer the chemical cocktails to those engaged in rampant sexual exploits.  It seems some of them preferred a life of near-constant orgasm to their freedom.  There is a door to the east marked as 'EXIT', and a stairwell along the south wall that leads to an overseer's office.", true);
			outputText("\n\nOne of the leather-clad ladies steps over and offers, 'Would you like a dose?  You look like you need to relieve some tension...", false);
			choice3 = 11040;
			text3 = "Tension";
		}
		text2 = "East";
		choice2 = 11001;
		text7 = "South(Up)";
		choice7 = 11006;
	}
	//Foreman's Office
	if(roomNo == 6) {
		outputText("<b><u>Foreman's Office</u></b>\nThis office provides an excellent view of the 'factory floor' through a glass wall along the north side.  Towards the south side of the room is a simple desk with an even simpler chair behind it.  The desk's surface is clear of any paperwork, and only has a small inkwell and quill on top of it.  There are a few statues of women and men posted at the corners of the room.  All are nude and appear to be trapped in mid-orgasm.  You wonder if they're statues or perhaps some kind of perverted petrified art.  The north has a glass door leading back to the factory.  There are two other doors, both made of very solid looking metal.  One is on the east wall and another is on the south, behind the desk.  The one behind the desk is marked 'Premium Storage' (though it appears to be locked).", true);
		if(player.hasStatusAffect("FactoryOmnibusDefeated") < 0) {
			spriteSelect(16);
			outputText("\n\nA nearly nude demonic woman is standing behind the desk, appraising you.  She is gorgeous in the classical sense, with a curvy hourglass figure that radiates pure sexuality untamed by any desire for proper appearance.  Shiny black lip-gloss encapsulates her bubbly lips, while dark eyeshadow highlights her bright red eyes.  The closest thing she has to clothing is a narrow band of fabric that wraps around her significant chest, doing little to hide the pointed nubs of her erect nipples.  Her crotch is totally uncovered, revealing the hairless lips of her glistening womanhood.\n\n", false);
			outputText("She paces around the edge of the desk, licking her lips and speaking, \"<i>So you've made it all the way here have you, 'champion'?  Too bad you've wasted your time.  Have you figured it out yet?  Have you discovered why you were sent here with no weapons or blessed items?  Have you found out why there are more humans here than anywhere else in this realm?  I'll tell you why.  You weren't a champion.  You were a sacrificial cow, meant to be added to our herd.  You just got lucky enough to get free.</i>\"\n\n", false);
			outputText("A part of you wants to deny her, to scream that she is wrong.  But it makes too much sense to be a lie...and the evidence is right behind you, on the factory floor.  All those women must be the previous champions, kept alive and cumming for years in order to feed these insatiable demons.  The demoness watches your reaction with something approaching sexual bliss, as if the monstrous betrayal of it all is turning her on.\n\n", false);
			outputText("\"<i>Yes,</i>\" she coos, \"<i>you belong here.  The question is do you accept your fate, or do you fight it?</i>\"", false);
			choice1 = 11042;
			text1 = "Fight";   
			choice2 = 11041;
			text2 = "Accept";
		}
		else {
			choice1 = 11005;
			text1 = "North(Down)";
			choice2 = 11007;
			text2 = "East";
			choice7 = 11008;
			text7 = "South";
			if(player.hasKeyItem("Supervisor's Key") < 0) {
				choice3 = 11060;
				text3 = "Desk";
			}
		}
	}
	//Pump controll room...
	if(roomNo == 7) {
		//PUMP CONTROL ROOM
		outputText("<b><u>Pump Control Room</u></b>\n", true);
		if(player.hasStatusAffect("DungeonShutDown") < 0) {
			outputText("This room is little more than a closet in reality.  There is a simple set of mechanical controls on a finely crafted terminal against the far wall.  You spend a moment looking over them, and realize you have three options to deal with this place.\n\n", true);
			outputText("-You could close the storage vent valves and overload the fluid storage systems.  The storage tanks along the back portion of the building would rupture, releasing thousands of gallons of tainted fluids into the surrounding area, but the facility's systems would suffer catastrophic failures and shut down forever.\n", false);
			//(Consequences - lake goddess becomes tainted!)
			outputText("-You could perform a system shutdown and then smash the controls.  It'd let the girls go and keep the factory shut down in the short term.  However most of the equipment would be undamaged and the place could be re-opened without too much work on the demons' part.\n", false);
			//(Consequences - If Marcus is a demon he takes over running the factory forever.  If not, nothing bad happens)
			outputText("-You could leave the equipment to continue running.  After all, the girls downstairs did seem to be enjoying themselves...\n", false);
			//(Consequences - Marcus takes over if demonic choice taken, if not he shuts down the equipment & things continue as per #3).
			text4 = "Valves";
			choice4 = 11059
			text5 = "Shutdown";
			choice5 = 11058;
		}
		else {
			outputText("This room is little more than a closet in reality.  There is a simple set of mechanical controls on the a finely crafted terminal against the far wall.  The controls are now inoperable, due to the damage your actions have caused.", false);
		}
		choice6 = 11006;
		text6 = "West";
	}
	//Premium Products
	if(roomNo == 8) {
		outputText("<b><u>Premium Products</u></b>\nThis store room is filled with a few opened crates, meant to store the various substances in the factory.  It looks as if the current overseer has allowed supplies to run low, as there is not much to be gleaned from this meager stash.\n\n", true);
		text1 = "North";
		choice1 = 11006;
		if(player.hasStatusAffect("TakenLactaid") >= 0) {
			if(player.statusAffects[player.hasStatusAffect("TakenLactaid")].value1 > 0) {
				outputText("There is a crate with " + num2Text(player.statusAffects[player.hasStatusAffect("TakenLactaid")].value1) + " bottles of something called 'Lactaid' inside.\n\n", false);
				text3 = "Lactaid";
				choice3 = 11062;
			}
		}
		else {
			outputText("There is a crate with five bottles of something called 'Lactaid' inside.\n\n", false);
			text3 = "Lactaid";
			choice3 = 11062;
		}
		if(player.hasStatusAffect("TakenGro+") >= 0) {
			if(player.statusAffects[player.hasStatusAffect("TakenGro+")].value1 > 0) {
				outputText("There is a crate with " + num2Text(player.statusAffects[player.hasStatusAffect("TakenGro+")].value1) + " bottles of something called 'Gro+' inside.\n\n", false);
				text4 = "GroPlus";
				choice4 = 11061;
			}
		}
		else {
			outputText("There is a crate with five bottles of something called 'Gro+' inside.\n\n", false);
			text4 = "GroPlus";
			choice4 = 11061;
		}
	}
	//UNUSED room 9
	//DUNGEON 2 START: ROOM 10
	if(roomNo == 10) {
		outputText("<b><u>The Cave Entrance</u></b>\n", true);
		outputText("The entrance to this cave is far bigger than the cave itself.  It looks to be a totally natural formation.  Outside, to the south, is a veritable jungle of plant-life.  There are massive trees, vines, and ferns everywhere.  The cave grows narrower the further north you go, until it's little more than a claustrophobic tunnel burrowing deep into the earth.", false);
		
		choice1 = 11067;
		text1 = "North";
		choice6 = 11075;
		text6 = "Leave";
		//Zetaz gone?  Alchemist shits!
		if(flags[kFLAGS.DEFEATED_ZETAZ] > 0) {
			if(flags[kFLAGS.ZETAZ_LAIR_DEMON_VENDOR_PRESENT] == 0) {
				outputText("\n\nThere's a demon lazing around outside the cave entrance.  Judging by his size and apparent gender, he must be an incubus.  You try to stay hidden for now, but all he's doing is throwing darts at a dartboard he's set up across the way from himself.  What kind of demon sits around playing darts?", false);
				text1 = "Investigate";
				choice1 = 2639;
			}
			else if(flags[kFLAGS.ZETAZ_LAIR_DEMON_VENDOR_PRESENT] > 0) {
				outputText("\n\nThe incubus known as Sean has set up a small stall around the cave entrance, and is busy tending to his shelves and wares.  He's dressed in an incredibly modest, three-piece suit, and nods to you as you approach, \"<i>Let me know if you want to buy anything.  I haven't done much with the cave, so feel free to poke around if you missed anything on your first pass.  I barely use the first room.</i>\"", false);
				text3 = "Shop";
				choice3 = 2642;
			}
		}
	}
	//D2: Tunnel
	if(roomNo == 11) {
		outputText("<b><u>Cave Tunnel</u></b>\n", true);
		outputText("This cave tunnel slants downwards to the north, and upwards to the south.  You can see sunlight and feel a fresh breeze from the latter direction, though the walls and air around you are damp with moisture.  You realize that the floor of this cave is fairly smooth and even, as if some attempt had been made to level it out.  You can see a bricked up wall along the north end of the tunnel.  It has a crudely fashioned wooden door in the center of it.", false);
		text7 = "South";
		choice7 = 11066;
		text1 = "North";
		choice1 = 11068;
	}
	//D2: [GATHERING HALL]
	if(roomNo == 12) {
		outputText("<b><u>Gathering Hall</u></b>\n", true);
		outputText("This room is clearly some kind of dining or gathering hall.  The chamber's shape has been hewn from the surrounding stone, and judging by the visible tool-marks, it wasn't done with a great deal of care.  Two long wooden tables fill out the room.  They're surprisingly well made, though it appears that part of their legs were hacked off with axes to lower their overall height.  You can't help but wonder where they were stolen from.  The tables haven't been cleaned in ages, as evidenced by their many stains and a number of half-rotten bones that still rest on their battered surfaces.  Two rows of crudely crafted chairs flank their better-made brethren, made to accommodate very short beings.", false);
		//[Imp Mob Fight]
		if(flags[kFLAGS.ZETAZ_IMP_HORDE_DEFEATED] == 0) {
			outputText("\n\nThe place is swarming with two dozen imps, and none of them look happy to see you.  A number of them take flight while the rest form a ring around you, trapping you!  It looks like you'll have to fight your way out!", false);
			text1 = "FIGHT!";
			choice1 = 11074;
		}
		else {
			text1 = "North";
			choice1 = 11077;
			text2 = "East";
			choice2 = 11070;
			text6 = "West";
			choice6 = 11069;
			text7 = "South";
			choice7 = 11067;
		}
	}
	if(roomNo == 13) {
		outputText("<b><u>Fungus Cavern</u></b>\n", true);
		if(flags[kFLAGS.ZETAZ_FUNGUS_ROOM_DEFEATED] == 0) {
			outputText("This cavern is huge!  Though you can see the edge of a large stalactite to the west, the rest of the cave disappears into darkness beyond twenty or thirty feet away.  The floor is covered in spongy, leaf-shaped fungus.  They're huge, shiny, and purple, and they cover the cavern floor for as far as the illumination will reach.  A strange, sweet smell hangs in the cavern's humid air, probably coming from the copious fungal flora.  At the edge of your vision you can see a humanoid skeleton propped up against a stalagmite.  There's a rapier laying a few feet in front of it, and it still looks as good as new.  What do you do?", false);
			//[Get It] [Fly-Get It]
			text2 = "East";
			choice2 = 11068;
			text3 = "Get Sword";
			choice3 = 11081;
			if(player.canFly()) {
				text4 = "Fly to Sword";
				choice4 = 11082;
			}
		}
		//Fungus creature dealt with!
		else {
			text2 = "East";
			choice2 = 11068;
			outputText("This cavern is huge!  Though you can see the edge of a large stalactite to the west, the rest of the cave disappears into darkness beyond twenty or thirty feet away.  The floor is covered in spongy, leaf-shaped fungus.  They're huge, shiny, and purple, and they cover the cavern floor for as far as the illumination will reach.  The familiar, sweet smell of them hangs in the cavern's humid air, but you're fairly certain they won't trouble you again.", false);
		}
	}
	//Vala's bitch room
	if(roomNo == 14) {
		outputText("<b><u>Filthy Torture Room</u></b>\n", true);
		outputText("You step into a dank room, outfitted somewhere between a prison cell and a torture chamber. The ceiling of the sulfur-lined room is hung with an inventive variety of shackles, chains, and devices whose intent are not clear to you. Against the north wall, there appears to be an alchemy lab, laden with a dizzying collection of vials, flasks, and beakers. Against the south, there is a long, sinister-looking wooden rack bearing a sequence of progressively larger and thicker devices, carved to resemble monstrous cocks.  ", false);
		//Vala here?
		if(flags[kFLAGS.FREED_VALA] == 0) {
			spriteSelect(85);
			//Not yet defeated zetaz
			if(flags[kFLAGS.DEFEATED_ZETAZ] == 0) {
				//Intro:
				outputText("", true);
				outputText("In the far corner, there is a small woman, her back to you, hanging limply by manacles that keep her suspended in a half-kneel. Rich purple hair hangs in long, clumped strands that sparkle occasionally with a pink glitter. Above her, there is a tarnished bronze nameplate that you think reads 'Vala,' but it's impossible to tell for sure under all the imp graffiti. She does not seem to be conscious.\n\n", false);
				
				outputText("It isn't until you get closer that you notice the large, dragon-fly wings attached to her back and the ephemeral glow of sunlight faintly radiating from her pale skin. If the girl wasn't almost 4' tall, you'd swear she was a fairy, like the ones you've met in the forest. If the cum-clogged drain in the center of the room is any indication, the imps must be using her for their perverted desires. You begin to get an appreciation for what she's endured when you get near enough to see the small, black marks staining her luminance. On her right shoulder blade, the imps have tattooed \"pussy\" and on the left, \"ass.\" All along her back, the imps have tattooed two columns of hash marks, from her shoulders all the way down her ribs, over her ass, down her legs, and even onto the soles of her feet.\n\n", false);
				
				outputText("You step around her and are startled to see that while the fey girl is whip-thin, her breasts are disproportionately huge. They'd be at least a DD-cup on a normal human, but for her height and body type, they're practically as large as her head. They jiggle at her slow, uneven breathing, tiny drops of milk bubbling at her nipples with every heartbeat. If she weren't chained to the ceiling, you suspect she wouldn't even be able to stand under her own power. Her eyes are open, but she's staring blankly ahead, unaware of the world around her, pupils constricted to pinpricks amid the ocean of her dulled pink irises. Like this, she's no threat to anybody. You suppose you could let her go, though it's unclear if she's self-aware enough to even move. Alternately, you could blow off a little steam.", false);
				//[Free] [Use] [Leave]
				text3 = "Free";
				choice3 = 2594;
				if(player.gender > 0) {
					text4 = "Use";
					choice4 = 2595;
				}
				if(player.lust >= 33 && shouldraFollower.followerShouldra()) {
					text5 = "ShouldraVala";
					choice5 = shouldraFollower.shouldraMeetsCorruptVala;
				}
			}
			//Zetaz defeated 
			else {
				outputText("In the far corner, there is a small woman, her back to you, hanging limply by manacles that keep her suspended in a half-kneel. Rich purple hair hangs in long, clumped strands that sparkle occasionally with a pink glitter. Above her, there is a tarnished bronze nameplate that you think reads 'Vala,' but it's impossible to tell for sure under all the imp graffiti. She does not seem to be conscious.\n\n", false);
				//Option to investigate her
				//leftValaAlone()
				text3 = "Faerie";
				choice3 = 2614;
			}
		}
		//Not here
		else outputText("In the far corner, there are a set of empty manacles, originally set up to contain Vala, who you've long since freed.", false);
		//Movements
		text1 = "North";
		choice1 = 11071;
		text6 = "West";
		choice6 = 11068;
	}
	//Backdoor Banditos!
	if(roomNo == 15) {
		outputText("<b><u>Secret Tunnel</u></b>\n", true);
		outputText("This passage is the least livable area that you've seen out of the entire cave.  The walls and floor are little more than dirt and rocks, and explosions of dust burst from the ceiling with each tentative movement you make.  For a moment, a wave of claustrophobia threatens to rob you of your nerve, but you blink the pervasive particles from your eyes and focus on why you're here.  ", false);
		//If zetaz not yet defeated
		if(flags[kFLAGS.DEFEATED_ZETAZ] == 0) outputText("You're going to find Zetaz and pay him back for drugging you on your first day here.  ", false);
		outputText("A crude door on the southern edge of the tunnel leads back to imp's sleeping chambers, but the tunnel continues away, curving sharply to the west where a far more lavish door marks the far side of the subterranean passage.", false);
	
		if(flags[kFLAGS.ZETAZ_LAIR_TOOK_BONDAGE_STRAPS] == 0) {
			outputText("\n\nA pair of fetishy, discarded straps lies on the floor, half obscured by dust.  It looks like something a goblin would wear.  Sexy!", false);
			text3 = "B.Straps";
			choice3 = 2638;
		}
		//(Item: sexy bondage straps/a set of sexy bondage straps/B.Straps? - Seduce ability?)
		//(Possible effect: +lust every round in combat if afflicted with Ceraph's bondage!)
		text6 = "West";
		choice6 = 11072;
		text7 = "South";
		choice7 = 11070;
	}
	//Zetaz' Lair!
	if(roomNo == 16) {
		outputText("<b><u>Zetaz's Chambers</u></b>\n", true);
		outputText("You've stepped into the most lavish room in the entire cave system, and marvel at the difference between this magnificent abode and your own crudely constructed campsite.  The stone walls are covered in stolen tapestries that each look to have been liberated from a unique source.  Judging by the variety of depictions and art styles in this one room, you've barely met a fraction of the races that once inhabited the lands of Mareth.  A pair of bright, smokeless lanterns hang from each wall, lit from within by obviously magical spheres of luminescence.  Various pieces of stolen furniture decorate the room, surrounding a four-post bed decorated with masterfully done carvings of various carnal acts.", false);
		if(flags[kFLAGS.ZETAZ_DOOR_UNLOCKED] == 0) {
			outputText("  <b>There's a bolt holding a door to the south closed, but you give it a gentle tug and it comes unlocked.</b>", false);
			flags[kFLAGS.ZETAZ_DOOR_UNLOCKED] = 1;
		}
		outputText("\n\n", false);
		
		if(flags[kFLAGS.DEFEATED_ZETAZ] == 0) {
			outputText("A familiar imp is looking at you with a bewildered expression painted across his face.  You recognize his face immediately – this is Zetaz!  Oddly, he seems to have grown much larger in the time since your previous meeting.  He's over four feet tall and much more solidly built!\n\n", false);
			outputText("Zetaz whines, \"<i>Seriously?  You show up here!?  First you make me lose my job, and now you beat up my friends and track dirt in my bedroom!?  I've had enough!</i>\"", false);
			startCombat(new Zetaz(),true);
			return;
		}
		else {
			text7 = "South";
			choice7 = 11068;
			text2 = "East";
			choice2 = 11071;
		}
	}
	//HELIA DUNGEONNNNNOOOO 1
	if(roomNo == 17) {
		//ROOM 1: Guard Hall
		outputText("<b><u>Guard Hall</u></b>\n", true);
		//Room Description:
		outputText("You stand in what might have been a guard room once upon a time.  Now it is a ruined, ransacked mess.  It seems not to have been used in years, and the table, chairs, and spears lined up against the wall have all rotted away to almost nothing.");
		//[If Armor has not been taken/fought with: 
		if(flags[kFLAGS.WON_GOO_ARMOR_FIGHT] + flags[kFLAGS.LOST_GOO_ARMOR_FIGHT] == 0) {
			outputText("  However, a suit of half-plate armor has been left up against the eastern wall, hanging loosely on a rack; it seems to be in usable shape.");
			text4 = "Armor";
			choice4 = 11096;
		}
		outputText("  You see a pair of heavy iron doors leading northward, though they seem so rusty and heavy that opening them is sure to alert anyone nearby, and a small trapdoor leading down.");
		//(Display Options: [North Door] [Trapdoor] [Armor])
		text1 = "North Door";
		choice1 = 11086;
		text3 = "Trapdoor";
		choice3 = 11085;
	}
	if(roomNo == 18) {
		outputText("<b><u>Wine Cellar</u></b>\n", true);
		//(Accessed from the Trapdoor button)
		outputText("You've dropped down into a small underground hidey-hole, with ");
		if(player.tallness < 60) outputText("just enough room to stand up in");
		else outputText("a ceiling so low you have to crouch");
		outputText(".  To your surprise, nothing horrifying jumps out and tries to rape you.  You see a few horns of mead slung up in a wine rack - they smell a bit pungent, but alcohol improves with age they say...");
		if(flags[kFLAGS.HEL_DUNGEON_MEAD_LOOTED] < 5) {
			outputText("(There are " + (5-flags[kFLAGS.HEL_DUNGEON_MEAD_LOOTED]) + "x God's Mead horns here to take.)\n\n");
			text4 = "God'sMead";
			choice4 = 11097;
		}
		//Display Options: [GodsMead] [Climb Up]
		text3 = "Climb Up";
		choice3 = 11084;
	}
	if(roomNo == 19) {
		clearOutput();
		//Room 3: Stair Well
		outputText("<b><u>Stair Well</u></b>\n", true);
		//(Upon clicking in:)
		if(flags[kFLAGS.HEL_HARPIES_DEFEATED] == 0) {
			outputText("You open the heavy double doors and cringe as a loud \"<i>SCREECH!</i>\" echoes out and up the next room - a wide open stairwell, it seems, with minimal cover.  The perfect place for a harpy to fight... Oh, shit!");
			outputText("\n\nYou ready your [weapon] as a wing of harpies looks up from eating at a small table in the center of the stone stairwell, all staring at you with wide, astonished eyes.  Another few harpies peer down from above, poking their heads down the stairs to get a look at the intruder.  Almost in unison, they jump to their feet and bare their claws.");
			outputText("\n\nIt's a fight!");
			startCombat(new HarpyMob());
			doNext(1);
			return;
		}
		else {
			if(flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED] == 0) {
				outputText("There's a pile of drugged, unconscious harpies you've already defeated on the floor, as well as Kiri, the only one that didn't attack you.  You recall that she knows Hel and is here to help the both of you.");
				//(Display Options: [Talk] [Sex] [Valeria](If Encountered) [Go Upstairs] [Go Downstairs])
				var valeria:Number = 0;
				if(player.armorName == "goo armor") valeria = 11106;
				text6 = "South Door";
				choice6 = 11084;
				text4 = "Talk";
				choice4 = 11098;
				text1 = "Sex";
				choice1 = 11103;
				text5 = "Valeria";
				choice5 = valeria;
				text3 = "Go Upstairs";
				choice3 = 11088;
				text8 = "Go Downstairs";
				choice8 = 11087;
			}
			else {
				outputText("There's a pile of drugged, unconscious harpies you've already defeated on the floor.  Kiri appears to have left.");
				text6 = "South Door";
				choice6 = 11084;
				text3 = "Go Upstairs";
				choice3 = 11088;
				text8 = "Go Downstairs";
				choice8 = 11087;
			}
		}
	}
	if(roomNo == 20) {
		clearOutput();
		outputText("<b><u>Dungeon</u></b>\n", true);
		//(Intro -- Before Fight)
		if(flags[kFLAGS.HEL_BRIGID_DEFEATED] == 0) {
			outputText("You make your way downstairs into a small, smoky stone room.  A thick smell of steam and burnt meat hangs over the room, making you cough as you descend the stairs.  As you make your way into the tower's little dungeon, you quickly notice the salamander chained to a table.  He's a great big man, nearly eight feet tall and covered in scars.  He has short, spiky red hair, the same color as his tail and limb scales, and a black eyepatch covers his left socket.  He looks like hell, emaciated and exhausted, covered in thick cum-stains from being used an untold number of times by the harpies of the tower.");
			outputText("\n\nBeside him, though, is the tallest harpy you've ever seen.  A foot over most of her sisters, she stands stark naked save for a red-hot iron poker in her hand and a heavy iron shield in the other.  Her pink hair is shaved down to a mohawk, and her face is covered with a dozen iron studs and rings.");
			outputText("\n\n\"<i>Bout time you made it down here, you " + player.mf("bastard","bitch") + ".  Mama Brigid's been waiting a loooong time for someone to try and break out one of her toys.</i>\"  She pats the hefty keyring on the underside of her shield and leers at you.");
			outputText("\n\nYou ready your [weapon] and prepare to take the keys from her!");
			startCombat(new Brigid());
			doNext(1);
			return;
		}
		else {
			outputText("You're standing in a small dungeon room, nearly gagging on the smells of burnt meat and smoke.  A number of nasty torture devices hang on the walls, and a table sits in the middle of the room, ");
			if(flags[kFLAGS.HEL_PC_TALKED_WITH_HAKON] == 0) {
				outputText("on which the salamander prisoner lies");
				text4 = "Prisoner";
			}
			else {
				outputText("on which Hakon lies");
				text4 = "Hakon";
			}
			outputText(".");
			if(player.hasKeyItem("Harpy Key A") >= 0 && player.hasKeyItem("Harpy Key B") >= 0) outputText("\n\n<b>You have the keys to release the prisoner, but you may want to make sure you have everything from this place that you want before you make your escape.  You doubt you'll be able to return in the future.</b>");
			//(Display Options: [Go Upstairs](Back to Stairwell & Kiri) [Prisoner] [Torture Gear]
			text3 = "Upstairs";
			choice3 = 11086;
			
			choice4 = 11111;
			text5 = "Torture Gear";
			choice5 = 11110;
		}
	}
	if(roomNo == 21) {
		clearOutput();
		outputText("<b><u>Mezzanine</u></b>\n", true);
		//(Intro; Before Battle)
		if(flags[kFLAGS.HEL_PHOENIXES_DEFEATED] == 0) {
			outputText("You ascend the heavy stone steps, circling the tower's walls as you ascend.  You are stopped perhaps half-way to the second main floor on a small terrace level with a wide open view overlooking the vale beneath the high mountains.  As you step onto the mezzanine, you watch with a scowl as a number of tall, muscular hermaphrodites step out from the shadows.  Each is clad in heavy chainmail and wields a scimitar and a blood-red shield, but is otherwise nude, revealing their reptilian pricks and slick pussies.  The soldiers standing before you look like harpies, but they have scaled, humanoid legs, long, fiery tails and their wings are the darkest crimson.  These are phoenixes - the dread half-breed warriors you and Hel are here to stop!");
			startCombat(new PhoenixPlatoon());
			doNext(1);
			return;
		}
		else {
			outputText("You're standing in the Mezzanine of the tower, a small terrace with a magnificent view of the High Mountains and the valleys below.  There are stairs leading up and down from here, as well as a pile of defeated phoenixes that don't look like they'll be recovering for a bit.");
			//(Display Options: [Go Upstairs] [Go Downstairs] [Phoenixes])
			text8 = "Downstairs";
			choice8 = 11086;
			text3 = "Upstairs";
			choice3 = 11089;
			text4 = "Phoenixes";
			choice4 = 11116;
			//(Go Downstairs returns you to the Stairwell; Go Up takes you to the throne room)
		}
	}
	if(roomNo == 22) {
		clearOutput();
		outputText("<b><u>Throne Room</u></b>\n");
		//Throne Room Descript (Before Combat!)
		if(flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED] == 0) {
			outputText("Ascending the stairs, you are stopped by a pair of heavy double doors.  They're covered with rotting, chipped purple paint and laurels that look years old.  The sharp, screeching sounds of metal on metal ring out in the next room - the sounds of a fight!  You kick the door open, and charge into what must be some kind of throne room; a large carpet dominates your view, leading up to a towering throne surrounded by pillows and cushions, currently vacant.");

			outputText("\n\nIn the center of the throne room stand Helia the Salamander and a harpy that could only be described as a broodmother.  She isn't particularly tall or menacing looking, but her hips are truly inhuman, thrice as wide as she is at the least, and her pillowy ass seems canyon-like in her nudity, the type of butt you could lose yourself in forever.  The harpy matron, wielding a staff, is currently locked in a fierce battle against Hel's red-hot scimitar.");

			outputText("\n\nSeeing you in the corner of her eye, Hel spins out of the contest and comes to stand beside you, blade raised toward the harpy broodmother.");

			outputText("\n\n\"<i>[name]!</i>\" she says, giving you a teasing slap on the ass with her tail.  \"<i>Took your sweet time, didn't you? Here I was starting to think I'd get this bitch all to myself!</i>\"");

			outputText("\n\nYou give Hel a reassuring nod and start to circle toward the Harpy Queen, taking the left flank while Hel heads right.  The queen looks from one of you to the other, a ball of white-hot magic fire conjured in her hand.");

			outputText("\n\n\"<i>You fools!</i>\" the queen hisses, backing away from you as best she can.  \"<i>You know not what you do!  My children... Their sole purpose was for the good of Mareth! You have ruined everything! Now the demons will have us all.</i>\"");

			outputText("\n\nYou ignore her, focusing on getting into position for a quick take-down with the help of your salamander lover.  However, before you can back the Harpy Queen into a corner, you hear an explosive BOOM from above.  You look up in time to see a hole erupt in the tower's ceiling, and a great brood of harpies pour in, dozens of them at the least.");

			outputText("\n\n\"<i>Oh well, fuck me!</i>\" Hel screams, dodging a hail of blows as the harpies swarm the throne room.  You can only just hear the broodmother laughing, bidding her children onwards over the sound of screeching and beating wings.");
			outputText("\n\n\"<i>FUCK! [name]!</i>\" Hel yells, cleaving a harpy in two with her scimitar, \"<i>Take a piece of the action; get the queen.  I've got these bitches!</i>\"");

			outputText("\n\nBefore you can say a word, Hel grabs a pair of harpies and, using them like human battering rams, dives into the swirling maelstrom of talons and claws.  You turn, [weapon] raised, to face down the queen.");

			outputText("\n\nShe now sits upon her throne, her staff laid across her bird-like legs.  \"<i>Idiot,</i>\" she sneers, just loud enough to be heard over the din of battle.  \"<i>You've doomed us all.  So many of my daughters dead or beaten or fled... No, I will not allow you to go unpunished, even if it means my life.</i>\"");
			outputText("\n\nShe stands, grabbing her great whitewood staff.  A ball of magical whitefire forms in her hand, ready to sear you alive.");
			startCombat(new HarpyQueen());
			doNext(1);
			return;
		}
		else {
			//Room Description:
			outputText("You stand in the harpy throne room - a long, circular room dominated by a high throne surrounded by cushions and drapes.  A single long carpet flows from the heavy double doors to the throne, reminding you of a castle's great hall in days gone by.  A number of harpies cower in the shadows, afraid to oppose you further now that their mighty leader is defeated.");
			//[if PC hasn't executed the queen: 
			if(flags[kFLAGS.HARPY_QUEEN_EXECUTED] == 0) {
				text5 = "Harpy Queen";
				choice5 = 11118;
				outputText("  The Harpy Queen slumps in her throne, insensate.");
			}
			//(Display Options: [Helia] [Harpy Queen] [Go Downstairs])
			text8 = "Downstairs";
			choice8 = 11088;
			if(flags[kFLAGS.HARPY_QUEEN_EXECUTED] == 0) {
				text4 = "Helia";
				choice4 = 11119;
			}
			if(flags[kFLAGS.HARPY_QUEEN_EXECUTED] == 1 && flags[kFLAGS.TOOK_QUEEN_STAFF] == 0) {
				text5 = "Take Staff";
				choice5 = 11132;
			}
		}
	}
	if(roomNo == 23) {
		clearOutput();
		outputText("<b><u>Strange Gateway in the Sands</u></b>\n");
		if(flags[kFLAGS.SANURA_DISABLED] > 0) {
			outputText("Just ahead, in one of the larger dunes, is a square stone doorway, built into the side of a large, sparkling mountain of sand.  You never would have noticed it if the sun hadn't been at the perfect angle to trace a rectangular shadow down the side of the incline.  As you approach, you notice a familiar obsidian orb embedded into the side of it.  It's obviously the mechanism to open it.");
			text1 = "North";
			choice1 = 11151;
			text5 = "Leave";
			choice5 = 11150;
		}
		else if(flags[kFLAGS.MET_SANURA] == 0) {
			flags[kFLAGS.MET_SANURA] = 1;
			outputText("Just ahead, in one of the larger dunes, is a square stone doorway, built into the side of a large, sparkling mountain of sand.  You never would have noticed it if the sun hadn't been at the perfect angle to trace a rectangular shadow down the side of the incline.  As you approach, you notice a smooth obsidian orb embedded into the side of it.  Perhaps that's the mechanism to open it?");
			outputText("\n\nSuddenly, a huge shadow looms over you, and the sound of beating wings echo from on high. You spin around in time to see a huge creature leap from the dune tops and slam into the ground a few feet away.  At first glance, the creature looks like a tall, tanned woman with flowing black hair, adorned in a great wealth of gold and jewels.  A moment later, though, you're able to take in the full view of her form: from the waist down, her shapely human form morphs into the lower body of a great, golden-haired lion, padding on a quartet of powerful legs ending in sharp claws.  From her leonine sides grow a pair of massive wings, easily over a dozen feet across, which quickly furl up against her body.  She's a sphinx!");
			outputText("\n\nThe sphinx-girl pads over towards you, her arms crossed under her small, palmable breasts. Chestnut-colored eyes examine you, looking you over from your [hair] to your [feet], a playful grin playing across her feminine features.  \"<i>O-ho!  What's this we have here?  A poor, lost " + player.race() + " wandering the desert; or are you something more?  Indeed, I should think so, with your [weapon] so eager for battle, and your [armor] that looks to have seen a thousand blows.  My, my.  Could it be you've come to brave my Mistress's lair?  Ah, if so... you must answer my riddles three, lest I keep from you the key!</i>\" she says, a little tune springing into her voice as she stalks towards you.");
			outputText("\n\n\"<i>We could even make it interesting...  If you can't guess my riddles, you must surrender your body to my pleasure.  If you win, your pleasure shall be my wish.</i>\"");
			if(flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] == 0) {
				outputText("\n\n(<b>You've discovered a new dungeon, available in the places menu in the future!  Make sure you save before delving too deeply...</b>)");
				flags[kFLAGS.DISCOVERED_WITCH_DUNGEON] = 1;
			}
			//(Display Options: [Riddle Game] [Fight] [Leave])
			text3 = "Riddle Game";
			choice3 = 11153;
			text4 = "Uh, FIGHT!";
			choice4 = 11154;
			text5 = "Leave";
			choice5 = 11150;
		}
		else {
			if(flags[kFLAGS.TIMES_SUBMITTED_TO_SANURA] + flags[kFLAGS.TIMES_WINFUCKED_SANURA] > 0) {
				outputText("You approach Sanura the sphinx as she pads around the great stone doorframe.  A playful grin spreads across her thin lips as you approach.  \"<i>O-ho!  Back again, I see.  Mmm, it's been so dull since last you <i>came</i>.  There's no one more fun to play out here in the wastes.  So... care to try your hand at my game once more?");
				if(flags[kFLAGS.BEATEN_SANURA_COUNT] > 0) outputText("  Or would you rather skip the formalities?  We both know who's got the sharper wit, I should think.");
				outputText("</i>\"");
				//(Display Options: [Riddle Game] [Fight] [Leave])
				text3 = "Riddle Game";
				choice3 = 11153;
				if(flags[kFLAGS.BEATEN_SANURA_COUNT] > 0) {
					text1 = "North";
					choice1 = 11151;
					text4 = "Fuck";
					choice4 = 11163;
				}
				text5 = "Leave";
				choice5 = 11150;
			}
			else {
				outputText("The sphinx, Sanura, is padding around the stone doorframe.  Occasionally she beats her leonine wings or gives a mighty yawn, obviously bored by a present lack of stimulation.  Seeing you standing about, however, Sanura gives you a sultry come-hither look and a seductive wink.  You're not sure if she wants to tempt your mind or your body.");
				text3 = "Riddle Game";
				choice3 = 11153;
				if(flags[kFLAGS.BEATEN_SANURA_COUNT] > 0) {
					text1 = "North";
					choice1 = 11151;
					text4 = "Fuck";
					choice4 = 11163;
				}
				text5 = "Leave";
				choice5 = 11150;
			}
		}
	}
	if(roomNo == 24) {
		clearOutput();
		outputText("<b><u>Cavernous Commons</u></b>\n");
		outputText("Dancing lights swirl around the roof of the cavern, twirling around each other in patterns too intricate to follow.  Whatever they are, they're clearly magical, and they lend this place an otherworldly ambience unmatched by anything you've seen.  This huge room reminds you of your village commons in a way - it's clearly a communal area.  There's a water-pump in the northwest corner and a blazing purple bonfire in the center of the chamber, heating the cool underground air.  The ground is dirt, rather than sand, and hard-packed as any road.  Various chairs and benches are set up for witches to relax in.  ");
		if(flags[kFLAGS.SANDWITCH_MOB_DEFEATED] == 0) {
			outputText("Worst of all, a huge assortment of spellcasters is assembling into a mob, obviously hostile.");
			startCombat(new SandWitchMob(),true);
			doNext(1);
			return;
		}
		else outputText("The women you defeated before have returned to their tasks, casting wary glances your way from time to time but no longer threatening.");
		outputText("  Cave tunnels lead in to the east and west into more underground chambers.  A path leads south towards the exit.");
		if(flags[kFLAGS.SANDWITCH_THRONE_UNLOCKED] == 0) {
			outputText("\n\nA huge stone doorway blocks the path north.  You cannot see a way to open it.");
		
		}
		else {
			outputText("\n\nAn open doorway opens up to the north.  You can faintly see some kind of altar beyond it.");
			text1 = "North";
			choice1 = 11147;
		}
		text7 = "South";
		choice7 = 11133;
		text2 = "East";
		choice2 = 11141;
		text6 = "West";
		choice6 = 11135;
	}
	if(roomNo == 25) {
		clearOutput();
		outputText("<b><u>West Warrens Main Hall</u></b>\n");
		outputText("The supernatural illumination so prevalent to the east is present here as well, though in smaller quantity and vastly diminished brightness.  Swirls of bluish-white hue slide along the ceiling in slow, measured motions, a stark contrast to the jubilant dancing of the preceding cavern.  The ceiling is almost twelve feet high in places, with the sides of the east-west passage dipping down the lowest.  The floor is sandstone here, as you would expect in a desert cave, though it is liberally obfuscated with an array of woven rugs.  Sand Witches march by on errands, only pausing to give you disinterested glances.  Most of them bear the signs of pregnancy or have young girls in tow.  Whatever the case, there doesn't seem to be any fight in these women.  Along the north and south walls are small, door-sized openings, draped with heavy curtains that easily muffle any noise.  To the west, the tunnel bores on unimpeded.  However, to the east the cave opens up into a much, much larger chamber.");
		text1 = "North";
		choice1 = 11136;
		text7 = "South";
		choice7 = 11137;
		text2 = "East";
		choice2 = 11134;
		text6 = "West";
		choice6 = 11138;
	}
	if(roomNo == 26) {
		clearOutput();
		outputText("<b><u>West Warrens Eastern Portion North Side (Children's Play Room)</u></b>\n");
		outputText("Behind the thick curtain is the last thing you would expect to see.  There's nearly a dozen children and three busty, pregnant sand witches watching them.  Toys have been scattered everywhere by the young blonde children.  Their wardens were busy knitting when you intruded, but they glare at you balefully and make shooing gestures.  Unless you had planned to rob children of their toys and beat up pregnant women, there's nothing to be had here.");
		text7 = "South";
		choice7 = 11135;
	}
	if(roomNo == 27) {
		clearOutput();
		outputText("<b><u>West Warrens Eastern Portion South Side (Lust Room)</u></b>\n");
		outputText("This room is surprisingly large - big enough to hold the " + num2Text(rand(6) + 5) + " heavily pregnant women inside plus perhaps a dozen more.  Like the outer tunnel, this room is lit by magic, though its contents are equally mundane, if a great deal more... interesting.  There's female sex-toys of every variety on almost every surface.  They sit in piles on the floor, they hang from the walls, and there are even some mounted on the wall, to be fucked in place.  Many such toys have multiple shafts and come in shapes from standard to canine to obscenely equine.  All of the witches are presently engaged in coitus with each other or their 'marital aids', but once you enter, they glance at you with hungry, lust-filled eyes.");
		if(silly()) outputText("  Clearly, if you wanted to, you could put some extra meat in a sand witch.");
		text1 = "North";
		choice1 = 11135;
		if(player.hasCock() && player.lust >= 33) {
			text3 = "FuckWitches";
			choice3 = 11157;
		}
	}
	if(roomNo == 28) {
		clearOutput();
		outputText("<b><u>West Warrens Main Hall (Western Portion)</u></b>\n");
		outputText("The smooth tunnel comes to an end here, blocked by the omnipresent sandstone.  The sapphire light plays beautifully across the rough-hewn stone as you watch, but you don't take the time to give it much thought.  To the east, the arching hallway leads back towards a large common area of a cave.  Along the north and south walls are door-sized openings, blocked with rugs of fine make and thick fabric.  They don't leave enough of a gap for any light or sound to bleed into the hall.  You'll have to take a peek if you want to see what's going on.");
		if(flags[kFLAGS.ESSRAYLE_ESCAPED_DUNGEON] == 0 && flags[kFLAGS.MET_ESSY] > 0) {
			flags[kFLAGS.ESSY_MET_IN_DUNGEON] = 1;
			if(flags[kFLAGS.TOLD_MOTHER_TO_RELEASE_ESSY] > 0) {
				outputText("\n\n<b>Your attention is immediately drawn to Essrayle...</b>");
				menu();
				addButton(0,"Next",forest.essrayle.essyWitchVictory);
				flags[kFLAGS.ESSRAYLE_ESCAPED_DUNGEON] = 1;
				return;
			}
			outputText("\n\nQuite an unusual sight awaits you in this chamber.  Sitting in an oversized pot is what looks to be the overly busty, plant girl you encountered earlier, Essrayle.  She's changed quite a bit since you last saw her, however.  While her inhumanly smooth, elfin face seems to be unchanged, the rest of her verdant body seems to have been warped into a hyper-sexual parody of a fertility idol, with features that echo the nomadic sand witch tribe.");
			text3 = "Essrayle";
			choice3 = forest.essrayle.approachTrappedEssy;
		}
		text1 = "North";
		choice1 = 11139;
		text7 = "South";
		choice7 = 11140;
		text2 = "East";
		choice2 = 11135;
	}
	if(roomNo == 29) {
		clearOutput();
		outputText("<b><u>West Warrens Western Portion North Side (Nursery)</u></b>\n");
		outputText("As soon as you clear the curtain, you realize there's nothing of interest to you here.  The room is lit with rose pink globes, and the furniture in the room is filled with sleeping mothers, nursing infants, or older children taking naps.  The room is packed with bodies, and while it smells strongly of femininity, there's nothing worth looking into present here.");
		text7 = "South";
		choice7 = 11138;
	}
	if(roomNo == 30) {
		clearOutput();
		outputText("<b><u>West Warrens Western Portion South Side (Pharmacy)</u></b>\n");
		outputText("This room is so tiny it can barely get away with being called that.  If anything, it's more of a small, cozy nook.  There isn't anyone else here, though the room is illuminated by the same omnipresent magics found elsewhere in this little cave of wonders.  Standing silent vigil on the southern wall, a large chest looms over you, stretching most of the way to the ceiling.  It is completely, almost impossibly neat, with every drawer fully and completely closed.  Spurred on by this strangeness, you pop a few of them open.  One drawer has pink pills, another brown.  Searching drawer by drawer until you discover that every single compartment houses the same dual medicines.  You glance about the room and spy a faded parchment on the wall.  It reads \"<i>Tnangerp rof knip, nerrab rof nworb.</i>\"  There is an opening in the wall to the north.");
		if(flags[kFLAGS.SANDWITCH_THRONE_UNLOCKED] == 0) {
			outputText("\n\nThere is also a lever on the floor.  Looking closely at it, it appears that it connects with machinery that leads to the east...");
			text2 = "Pull Lever";
			choice2 = 11156;
		}
		text3 = "Brown Pill";
		choice3 = 11159;
		text4 = "Pink Pill";
		choice4 = 11160;
		text1 = "North";
		choice1 = 11138;
	}
	if(roomNo == 31) {
		clearOutput();
		outputText("<b><u>Eastern Warrens Main Hall (Western Portion)</u></b>\n");
		outputText("This smooth, sandstone tunnel proceeds in a perfectly straight line from east to west, as if aligned to some titanic, invisible compass buried below the floor.  Flickering white plumes of illumination undulate through the air along the arched ceiling, trailing streamers of pearl incandescence that light the entire chamber with ghostly brightness.  You are at the entrance to the eastern warrens - the commons are still clearly visible to the west, and the pathway to the east goes on a-ways.  Hand woven tapestries adorn the walls, telling the history of this enclave in pictographic form, from it's inception to present day.  Further east, you can see a few empty places, ready to be covered with more cloth, once the next chapter of history is ready to be told.  To the north, there is a small opening in the wall, blocked off by plain white curtains.");
		text1 = "North";
		choice1 = 11142;
		//text7 = "South";
		//choice7 = 11137;
		text2 = "East";
		choice2 = 11144;
		text6 = "West";
		choice6 = 11134;
	}
	if(roomNo == 32) {
		clearOutput();
		outputText("<b><u>Eastern Warrens West Portion North Side (Sleeping Chamber)</u></b>\n");
		outputText("Inside this expansive but cosy chamber are a few dozen beds, arranged in neat patterns marred only by a few cots that dare to be positioned adjacent to one another.  Clearly this is the tribe's primary sleeping area.  The floor is obscured by heavy, hand-woven rugs that ruffle oh so softly against your [feet].  Instead of the usual ghostly lights you've grown to expect, the interior of this dwelling is lit by glass-paneled constructs resembling lanterns.  There is no fuel or wick of course, only flicking phantasmal illumination trapped as if it were a flame.  Shutters allow the lanterns to be dimmed, but as you are alone in here for now, there's no reason to make it harder to see.  There is a door to the east and a curtained off opening to the south.");
		text2 = "East";
		choice2 = 11143;
		text7 = "South";
		choice7 = 11141;
		
	}
	if(roomNo == 33) {
		clearOutput();
		outputText("<b><u>Eastern Warrens East Portion North Side (Bath Room)</u></b>\n");
		outputText("As soon as you step in, you can smell a sweet, dairy-like scent in the air, but as your eyes adjust to the dimmer lighting, you realize you've stumbled into the sand witches' bathroom!  Fluffy towels hang from the wall, ready for use.  There's one giant tub in the center of the room, recessed deep into the floor.  It has a number of seats carved into the side with a small, open hole in the bottom.  Hanging from the ceiling, a long chain dangles down, topped with a plug.");
		flags[kFLAGS.MET_MILK_SLAVE] = 1;
		if(flags[kFLAGS.MILK_NAME] is Number) {
			outputText("  There are no faucets or water sources that you can see, but your unasked questions are answered when a heavy, liquid sloshing sound emanates from the corner.  The source of the noise reveals itself to be a tit-encumbered, black-skinned human girl.  She drags her milk-swollen mammaries up to the edge of the tub and asks in a breathy, excited voice, \"<i>Bath time?</i>\"  Whoever she was, the witches seem to have broken her utterly - she's interested in nothing but being milked or lounging in her corner.  The way out lies west.");
			text3 = "Bath Time";
			choice3 = 11158;
		}
		text6 = "West";
		choice6 = 11142;
	}
	if(roomNo == 34) {
		clearOutput();
		outputText("<b><u>Eastern Warrens Main Hall (Eastern Portion)</u></b>\n");
		outputText("Coming to an end here, the eastern warrens' main hall ends in little more than a bare, flat stone wall.  The area is well illuminated by the familiar magical lights, giving you a good view of the historical tapestries and blank spaces yet to be filled in.  You can't help but wonder if the Witches will simply stop recording their history once this area is full, or if they will expand in order to give themselves more room.  Looking over the events depicted here, it's clear that this enclave is one of the oldest, roughly two decades old.  There are pictures of a blond haired woman in fluttering, golden robes leaving a town of demons behind and journeying towards the desert.  Could that be how the sand witches began?  You shake your head and look over the rest of the room.  There's a curtained off doorway to the south, and of course, the tunnel leads back to the west.");
		//text1 = "North";
		//choice1 = 11136;
		text7 = "South";
		choice7 = 11145;
		//text2 = "East";
		//choice2 = 11142;
		text6 = "West";
		choice6 = 11141;
	}
	if(roomNo == 35) {
		clearOutput();
		outputText("<b><u>Eastern Warrens East Portion South Side (Cum Witch's Bedroom)</u></b>\n");
		outputText("As soon as you brush back the curtain, you're assaulted by a pungent, salty smell.  It almost reminds you of tepid ocean water... or cum.  Regardless, you force your way in and take a look around.  This area has all the furnishings of a small domicile and comes complete with a solid oak bed and mattress.  The mattress and sheets seem to be cared for with immaculate precision, perhaps magically aided.  There is a simple dresser here, and though it looks to have been fashioned by crude tools, the wood looks sturdy and serviceable.  All of the drawers are closed, of course.  A few books sit on a nearby table, but it's obvious they're written in a language beyond your comprehension.  Whoever wrote them either did so in a different tongue or a magical language that would take years to decipher.  A thick curtain walls this chamber off from the eastern warrens' main hall, to the north.  To the west, there is a thinner, gauzy sheet hanging from an opening in the rock - likely leading to a similar room.");
		text1 = "North";
		choice1 = 11144;
		text6 = "West";
		choice6 = 11146;
	}
	if(roomNo == 36) {
		clearOutput();
		outputText("<b><u>Eastern Warrens West Portion South Side (Cum Witch's Office)</u></b>\n");
		if(flags[kFLAGS.SAND_WITCHES_FRIENDLY] > 0) {
			//{SAND WITCHES NOW FRIENDLY}
			outputText("The cum witch is here, pounding away at one of her sister's cunts, like usual.  She seems to CONSTANTLY excrete her jism into her partner's many cunt-folds, but as her passion and speed rises, the flow thickens, eventually filling the poor milk-witch's wombs entirely.  They go at it like animals for a few seconds more, then separate after a climactic orgasm that leaves a puddle of spooge inches deep on part of the uneven floor.  The cum-witch moves her insensate sister to rest on a nearby bench before putting on her hat and robes.  She winks at you and offers, \"<i>Well, I hope you enjoyed the show, interloper.  Did you come here for some of my gift, or something else?</i>\"");
			//{VOLUNTEER FOR SERVICE: BAD-END, BLESSING: +CUM PRODUCTION}
			if(flags[kFLAGS.BEEN_BLESSED_BY_CUM_WITCH] == 0) {
				text3 = "Blessing";
				choice3 = 11161;
			}
		}
		else {
			//{CUM WITCH UNDEFEATED}
			if(flags[kFLAGS.CUM_WITCH_DEFEATED] == 0) {
				outputText("The curtain pulls to the side easily, and as soon as you enter, you're greeted by the sound of flesh slapping on flesh from somewhere to your left.  Briefly, you note a number of desks as you turn towards the sexual audio, but what really catches your eyes are the two girls locked in coitus.  One, a normal-looking sand witch, is bent over a bench and taking quite the fucking.  Milk drips in huge beads from her four fat teats while fresh rivulets of cum run down past the dried-cum on her thighs.  Above her is something else entirely, a taller woman with a single pair of obscenely large breasts.  She's so dark skinned that at first you have difficulty picking out her features in the dim lighting.  Glittering sweat runs down her form, dripping from her pendulous breasts as she throws back her head and moans, \"<i>Gonna... just... take it!  Take my gift!</i>\"");
				outputText("\n\nBeneath the ebony woman, you see the sand witch begin to quiver and moan, thick gouts of semen back-flooding from her packed cunny as her belly rounds with delicious fecundity.  Her muscles lock, then twitch feebly for a few seconds before she slides off into the new-born cum-puddle, slipping along the floor in an insensate pile of orgasmic bliss.  You're so enraptured by the sight, that you don't even try to hide when the ebony futanari turns to face you, putting on a pointed, wide-brimmed hat and black robe.  For the slightest second you see a pair of orange-sized balls and one thick, cum-lubed member, but those quickly disappear into the voluminous robes.");
				outputText("\n\n\"<i>Well now, surely you aren't one of the witches here to receive my seed,</i>\" the odd witch muses, \"<i>I'm afraid you must be an interloper then.  Pity, ");
				if(player.hasVagina()) outputText("but then, maybe you can come to serve us as a mother.  Our tribe is not wasteful.");
				else if(player.hasCock()) outputText("but perhaps, once you have been disabused of your notions of freedom, you could serve as my loyal cum-pump.  It does get so tiring inseminating all these girls alone.");
				else outputText("but then, perhaps you could be made to serve in other ways.");
				outputText("</i>\"");
				
				outputText("\n\nThe soot-skinned futanari delicately opens one of her palms and murmurs an unintelligible word. Before your eyes, flickers of light flash into existence and align themselves vertically, slowly sliding together like pieces of a flawless crystal jigsaw puzzle.  The glimmering phantasmal luminance slowly fades as all the pieces come together, leaving a flawless ivory staff in the woman's hand.  She slams the base into the ground, sending ripples of magical force through the many pools of cum scattered around the room.  <b>It looks like you'll have to fight her!</b>");
				//{START CUM WITCH FIGHT}
				startCombat(new CumWitch());
				doNext(1);
				return;
			}
			//{CUM WITCH BEATEN}
			else {
				outputText("This room is absolutely, unequivocally inundated with the scent of spunk.  Sure, you note there's a few grates built into the floor to drain off most of it, but it hasn't stopped a number of huge puddles from building up all over this room, likely the result of the two semi-conscious women in this room.  One, a recently-bred sand witch got the fucking of her life from the other, a cum witch.  Both are front-down in jizz, their abused bodies quivering and weak.  The cum witch had tried to fight you, but she was no match for your superior technique.");
				//Lust:
				if(player.lust >= 33) {
					outputText("\n\nYou could probably pull the cum witch up and sate yourself on her, if you wanted.  She doesn't seem in any shape to resist.");
					//lust win menu.
					text3 = "Sex";
					choice3 = 11152;
				}
			}
		}
		text2 = "East";
		choice2 = 11145;
	}
	if(roomNo == 37) {
		clearOutput();
		outputText("<b><u>Sacrificial Altar</u></b>\n");
		outputText("This chamber clearly holds some kind of important significance to the witch coven.  The floor and walls are covered in shining white, reflective tiles, and a large number of carved jugs ring the outer edge of the room.  The entire place smells faintly of milk.  Sniffing, you close in on the source of the aroma.  It's emanating from what looks like a golden well, positioned dead-center before you.  The various containers also smell faintly of the alabaster treat, and oddly, you can't catch even a single whiff of spoilage; it all smells fresh.  There must be some magic at work.  Peeping over the edge of the well, you can barely make out what seems like a sea of milk stored below: white-capped ivory waves sloshing around in a chamber so large you can't see the walls of it.  It must be preserved through magic.\n\nThere is a doorway to the south and one on the north wall.");
		text1 = "North";
		choice1 = 11148;
		text7 = "South";
		choice7 = 11134;
	}
	if(roomNo == 38) {
		clearOutput();
		outputText("<b><u>Sand Mother's Throne</u></b>\n");
		outputText("This chamber is lit by swirling vortexes of magical colors, each hue dancing around another in coordinated motions.  The walls are made of hewn sandstone inlaid with ivory engravings that appear to depict what must be flowing milk.  Ahead there is a huge, white throne, also made from ivory.  It is a magnificent piece of craftsmanship.  Clearly, you have found the leader's throne room.  There is a robed figure atop it.");
		text3 = "Approach";
		choice3 = 11155;
		text7 = "South";
		choice7 = 11147;
	}
	
	
	
	
	//Display menu
	choices(text1,choice1,text2,choice2,text3,choice3,text4,choice4,text5,choice5,text6,choice6,text7,choice7,text8,choice8,"Items",itemMenu,"Masturbate",masturbateMenu);
}

public function factoryFinisher():void {
	outputText("", true);
	outputText("You crack your sleep-fuzzed eyes, blinking at the sudden light as you try to get your bearings and remember where you are.  A nearby voice is moaning like a bitch in heat, or a drunk slut.  You giggle a bit at the thought as you work at focusing your eyes.  You feel warm and happy, particularly in your chest and groin.  The cobwebs of sleep clear from your mind with agonizing slowness, but you find it hard to worry about with how warm and wonderful you feel.  It's almost like hot wet mouths are latched onto your crotch and breasts, licking and sucking in perfect rhythm.  ", false);
	if(player.cocks.length == 0 || player.biggestTitSize() <= 1) {
		outputText("A small inner voice pipes up to remind you that you don't have ", false);
		if(player.cocks.length == 0) {
			outputText("anything in your groin to suck on", false);
			if(player.biggestTitSize() <= 1) outputText(" or ", false);
		}
		if(player.biggestTitSize() <= 1) outputText("any adornments on your chest", false);
		outputText(".  That voice trails off as that feeling of perfect pleasure and rightness sweeps it away with the last remnants of sleep.\n\n", false);
	}
	else outputText("A small inner voice tries to warn you of something, only to be swept away in the feelings of perfect pleasure and rightness that wash away the last remnants of your sleep.\n\n", false);
	outputText("You realize that the moaning voice is your own, and find that the thought just turns you on more.\n\n", false);
	outputText("'<i>You're such a horny slut!</i>' echoes a voice in your head.  You want to nod and smile, but are prevented by something.  You realize you're strapped into some kind of chair and harness so securely that you can't even move.  Tiny soothing fingers massage your temples, rubbing away the fears that moments ago threatened to interrupt your pleasure.  You can see a ", false);
	if(player.totalBreasts() == 2) outputText("pair of ", false);
	else outputText("multitude of ", false);
	outputText(" clear hoses coming away from your cow-like chest udders.  ", false);
	if(player.biggestLactation() <= 1.5) outputText("Creamy white milk is flowing in a steady stream up the tubes and away from you.  ", false);
	else outputText("The hoses bulge obscenely as they struggle to keep up with the torrents of creamy-white milk you're producing.  ", false);  
	outputText("Even more wanton moans erupt from your disobedient lips now that you know what's going on.  You're not just a horny slut.  You're a horny cow-slut who's getting off on having her tits pumped.  The massage you're getting feels so good once you realize that.\n\n", false); 
	outputText("A snap echoes through the pumping room, nearly drowned out by the moans of the other milk-sluts around you.  You look around as you realize the band to restrain your head has been unlatched.  You take advantage of your newfound freedom and look around.  Rows and rows of other girls are there, just like you.  Almost all of them have bigger tits and fuller milk-tubes.  In addition, they all have enormous members that would drag on the floor were it not for the gigantic tubes encapsulating each and every one.  ", false);
	outputText("The girl next to you squirms and cums, wriggling inside her harness as waves of sticky goop are pumped down her cock-tube into a floor-socket.  She just keeps going and going, making you wonder how she can make so much of the stuff.  As the sight excites you, the pleasure in your own crotch redoubles.  Looking down thanks to your newfound freedom, you see your own giant encapsulated member; though not as large as your neighbor's, it still looks and feels wonderful.\n\n", false); 
	outputText("The lining of the tube squeezes and massages your trapped prick expertly, even as those hands continue to work on your mind.  Some part of you suspects that your thoughts are being manipulated, but the carnal pleasure you are experiencing is so amazing that you have no intention of resisting. If being a cumslut for your sexy demonic masters is what it takes, so be it. Cramming a massive demon-cock in your throat, getting a few others up your holes to keep you pregnant all the time, and being their busty hermaphrodite breeding tool would be your joy and privilege.  ", false);
	if(player.hasStatusAffect("Camp Marble") >= 0) {
		outputText("As if reading your thoughts, the hands stop massaging, and their owner snaps their fingers. You see Marble step in front of you, wearing an odd set of pink panties with a dick-like protrusion sticking out the front of them.  At the command of the figure behind you, she presents the panty-cock to you.  Happy to be of service, you spread your jaws and engulf as much of the great penis-like thing as you can, while the figure behind you moves around and takes Marble in the ass.  You continue to suck on the pink flesh till you feel it pour some kind of unholy load into your stomach.  Gurgling in pleasure, you start cumming yourself, all the while appeasing your demonic masters by servicing your once lover.\n\n", false);
	}
	else outputText("As if reading your thoughts, the hands stop massaging, and their owner comes in front of you, presenting you with a meaty, throbbing cock.  Happy to be of service, you spread your jaws and engulf as much of the great penis as you can, till you feel it pouring his unholy load into your stomach.  Gurgling in pleasure, you start cumming yourself, all the while attending to one or more of your demonic masters.\n\n", false);
	
	
	outputText("<b>This kind of treatment continues for a few days, till sucking, fucking and getting fucked is the only thing you desire. As your mind is now broken, injections are no longer necessary to keep you in a perfect pleasure state. After a month, they even untie you, since you are now their complete cum-puppet, eager only to please and obey.</b>", false);
	//The style on this part wasn't up to par with the rest, so I rewrote some of it, while keeping the meaning
	eventParser(5035);
}

public function succubusLossRape():void {
	outputText("", true);
	if(player.cocks.length > 0) {
		if(player.lust > 99) outputText("Driven half mad with lust, you drop to your knees. Your fingers fly over your body as you pry off every last piece of your " + player.armorName + ", displaying just how hard your alluring opponent has gotten you.  The succubus saunters over, every sinuous step radiating the inhuman sexuality that pours off her skin like heat from a bonfire.\n\n", false);
		else outputText("Exhausted, you collapse before the succubus.  She effortlessly slices away your " + player.armorName + ", peeling your possessions away with practiced ease.  In moments you are stark naked and wholly exposed to your captor.  In spite of yourself, your body begins to respond to her sultry aura, displaying the hardness of your desire and shame immediately.\n\n", false);
		outputText("\"<i>Awww, did I get you all <b>HOT</b> and bothered?</i>\" She croons, poising a stocking clad foot above you as her high-heels seem to fade away.  Warm silk begins to press against your groin as slender toes curl around the head of your throbbing maleness, your foe having her way with your desire-saturated form.  You mewl pitifully at the sensation, your hips twitching involuntarily against her demonic sole. The slippery surface of her foot squeezes as she expertly strokes you with her foot, delighting in her complete dominance over your easily controlled member.\n\n", false);  
		//balls or pussy play
		if(player.balls > 0) {
			//[[balls]]
			if(player.ballSize < 6) outputText("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses your " + ballsDescriptLight() + " with soft touches.  Almost immediately you feel them clench with boiling heat, growing heavy and churning with a load big enough to satisfy a thirsty succubus.", false); 
			//[[huge balls]]
			else outputText("Your sultry captor leans low, marveling at the size of your " + ballsDescriptLight() + " as she reaches down to caress them.  Her tits swing lewdly above you, bouncing in hypnotic motions. Her hands work gently, taking each one of your " + ballsDescriptLight() + " and hefting it gently.  Almost immediately you feel them fill with an unnatural heat that spreads everywhere her slender fingers touch.  They begin to feel full and heavy, practically sloshing as the pent up need inside you is channeled into liquid form.  \"So ripe... and full,\" she whispers to herself as she caresses them, her silken foot still sliding all over your " + cockDescript(0) + ", pumping stroke after stroke of pleasure into your lust-weakened form.", false);
		}
		else {
			//[[no balls no pussy]]
			if(player.vaginas.length == 0) outputText("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses the skin between your " + cockDescript(0) + " and " + assholeDescript() + " with a slender finger.  Almost immediately you feel your groin clench with the boiling heat of a growing orgasm, thick cum churning out from your prostate as your body readies a load large enough to satisfy a thirsty succubus.", false);
			//[[no balls + pussy]]
			else outputText("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses the slick skin of your slit with a single digit.  Other fingers circle your " + clitDescript() + ", teasing it from between the folds as it grows hard, peeking out from the hood and turning cherry-red.  Almost immediately you feel your groin clench with the boiling heat of a growing orgasm, thick cum churning in your prostate as your body readies a load large enough to satisfy a thirsty succubus.", false);
		}
		outputText("\n\n", false);
		//[[Cum]]
		outputText("The succubus licks her lips in anticipation as she curls her silk-clad toes tighter around you, making you bulge and twitch in obscene pleasure.  With a naughty smile, she caresses your ass with her bulbous demonic tail.  Before you can react, it plunges inside you, easily slipping through your " + assholeDescript() + " and pressing tightly against your prostate.  The suddenness pushes you over the edge, but she immediately wraps her fingers around you, pinching tightly, bottling your cum inside you.  You cry out in pain and surprise as your entire thick load is trapped inside you.  After nearly a full minute, your groin aches with the discomfort of it all.\n\n", false);
		//More cum paragraph.  HAHA! TINY BABY CUM! 
		outputText("She wastes no time, and caresses you again.  You instantly feel another surge of heat and desire as a fresh load of cum brews behind your first strangled orgasm.  You need to cum so bad, her foot still stroking and squeezing you full of perverted desire.  She slaps your ", false);
		if(player.balls > 0) outputText("balls", false);
		else outputText("ass", false);
		outputText(" as she releases your " + cockDescript(0) + ", shouting, \"<i>CUM!  Feed me!</i>\"  You are all too happy to oblige.  ", false);
		//[[normal volume]]
		if(player.cumQ() < 50) outputText("Freed at last, your body clenches tightly as it squirts the first jet of cum from your " + cockDescript(0) + ".  She smears her foot over the head, catching the cum and using it to lubricate her silken foot as it massages your member with merciless strokes, alternatively catching your spooge and milking more from your obedient maleness.  Your orgasm lasts many times longer than normal as your dual loads feed her demonic hunger.", false); 
		//[[big volume]]
		if(player.cumQ() >= 50 && player.cumQ() < 400) outputText("Freed at last, your body clenches tightly as it spurts a big glob of cum onto her waiting sole, soaking the bottom of her foot with slippery male-milk.  She smears her cum-covered foot over every inch of your " + cockDescript(0) + ", making each successive spurt bigger and messier than the last. Somehow she manages to catch more and more of your jizm over her foot, bathing you in cummy silkiness.  You groan helplessly as she milks more and more of from you till her foot is dripping steadily, your own groin and belly soaked with the stuff.  You give a few final exhausted squirts as she languidly rubs it into you.", false);
		//[[huge volume]]
		if(player.cumQ() > 400) outputText("Freed at last, your body clenches powerfully as a massive eruption of cum launches from your " + cockDescript(0) + " onto her waiting foot.  The succubus looks on incredulously as her entire foot is soaked with your sticky whiteness, forgetting to move as the second wave of cum drenches her to the ankle and rains down over your stomach.  She giggles and moves it back to your cock, massaging your slick spooge into your cock with her foot, wringing an even bigger explosion of cum from your tortured body.  Flopping back, she gets her other foot in on the action, milking you between her feet as you soak yourself completely with bigger and bigger eruptions until at last your orgasm begins to wane.  She slides forwards, rubbing against you and smearing the mess over herself with a blissful expression.", false);
		outputText("\n\n\"<i>Good boy,</i>\" she croons, mopping the cum up as it seems to wick into her stockings, \"<i>You'll do well once we get you on the line.</i>\"  You don't have time to ponder the significance of that as you lose consciousness.", false);
		//ONWARD TO BAD-END-IA!
		dynStats("lus=", 0);
		doNext(11025);
	}
	else {
		if(player.lust > 99) {
			outputText("Driven half mad with lust, you shake yourself free from the trappings of your " + player.armorName + ", first revealing your " + allBreastsDescript() + ", then " + hipDescript() + " and finally your ", false);
			if(player.vaginas.length > 0) outputText(vaginaDescript(0) + " as the last pieces fall away.\n\n", false);
			else outputText("bare groin as the last pieces fall away.\n\n", false);
		}
		//(HP loss)
		else outputText("You realize you're wobbling unsteadily, either from a blow to the head or blood loss, you can't be sure which.  In a display of sublime defiance, you manage to stay on your feet.  Though your tenacity does little good as your lightning-fast foe effortlessly undresses you, easily avoiding your clumsy and pain-addled movements.\n\n", false);  
		//START ZE RAPE
		outputText("The succubus steps away from you, withdrawing a tiny vial from a pocket in her vest.  She uncaps it with practiced ease, her outfit shifting into latex parody of a nurse's uniform as she attaches a small needle, completing the assembly of her injector.  \"<i>Like, don't worry about a thing hun, this will only hurt for a second,</i>\" she coos as she prances forwards, easily sinking the entire needle into your shoulder.\n\n\"<i>W-what did you do to me?</i>\" you manage to stammer.\n\n", false);
		outputText("She merely smiles and slips a delicately manicured finger under a rapidly disappearing skirt.  You ignore her crude display of wanton sexuality for the moment and try to focus on figuring out what the drugs did you, and what her needy slit smells like.  No, that wasn't it… you wanted to taste her nipples!  You shake your head and try to focus, but fail completely as the succubus lifts her sticky latex skirt, exposing dripping snatch to you.  Your eyes lock on to the wondrous slut's fuckhole as her fingers tease you with glimpses between her folds every few seconds while she continues pleasuring herself.  With a flash of intuition, you realize what you were trying to think about:  finding something hard to penetrate that perfect hole with.  That little hungry snatch deserves to be filled with something throbbing and hard...\n\n", false);
		outputText("\"<i>OoooooOOOOH!  ...you're feeling it now are-AH AH YES-you dear?  Mmmmm yes, I bet this pussy is all you can think about.  I wonder if you can feel it-aaahhhhhhmmmm-yet?  This is always, like, the best part...</i>\" gasps out the succubus as she pleasures herself.  You wonder what she could be talking about as ", false);
		if(player.vaginas.length > 0) outputText("your " + clitDescript() + " parts your folds, growing harder.", false);
		else outputText("a fleshy growth erupts from your pale flesh, growing harder.", false);
		outputText("  In seconds you're playing with it, tugging the sensitive button as it fills up with more and more blood, growing bigger and harder than ever before.  Your legs give out as you begin stroking it with feverish intensity, barely registering as it grows to nearly eighteen inches in length, not noticing the increasingly veiny surface or different texture at the tip.  You force yourself to stop as a sudden truth asserts itself upon your consciousness - you need to shove your clit-like cock into a pussy.  You need to cum inside that hungry slut's blue spunk-receptacle.\n\n", false);
		outputText("You stand on shaky legs and lunge forwards, impaling the slutty nurse on your new tool with a violent animalistic passion.  Fucking her roughly, you lick her nipples to finally get the taste you've ached for.  Girl-cum squirts from the sloppy fuck-hole of the latex-nurse underneath you as you fuck her like a desperate animal.  She squeals with pleasure, splitting her legs wide apart to encourage your new maleness.  Your eyes roll back from the drug-enhanced pleasure of her dripping cunt as a male orgasm rocks your mind.  Mixed fluids splatter your pistoning hips as you do what you were always meant to do - feed and pleasure succubi.  Somehow your tool remains rigid and your hips continue plunging your new cum-spigot deeper and deeper into your mistress as the next orgasm begins to build inside your drug-addled mind, even as you black out.", false);
		player.createCock();
		player.cocks[0].cockLength = 16;
		player.cocks[0].cockThickness = 1.5;
		//[[[[To bad end!]]]
		dynStats("lus=", 0);
		doNext(11025);
	}
}
public function succubusVictoryRape():void {
	player.slimeFeed();
	outputText("", true);
	//MALE
	if(player.cocks.length > 0 && (player.gender != 3 || rand(2))) {
		//(LUSTY) 
		if(monster.lust > 99) outputText("Panting hotly, the succubus staggers towards you, her eyes fixated on the bulge in your crotch.  Dark viscous liquid drips from her dusky folds as her hips undulate hypnotically.  Blue fingers smear the corrupted lubricants over the smooth outer folds of her sex as she lies back enticingly, giving up on anything but bedding you.  In moments your " + player.armorName + " are on the floor and you approach your prize.\n\n", false); 
		//(HP) 
		else outputText("The succubus collapses on the floor, groaning in pain.  Most of her clothes have been destroyed by the combat and her blue skin is marked with deep purple bruises and bloody lacerations.  You undress, straddling your conquest and gazing down on her helpless, curvaceous form.  She looks up at you and forces a smile, licking the blood from a cracked lip and beginning to masturbate for you.\n\n", false);
		//START ZE RAEP CANNONZ
		outputText("While pondering the best way to take your horny prize, her complexion begins to change, the marks of combat disappearing from her toned body.  The demonic horns crowning her perfect visage begin withdrawing into her head, and her hair ", false);
		if(player.hairLength > monster.hairLength) outputText("lengthens", false);
		else outputText("shortens", false);
		outputText(", shifting to " + player.hairColor + ".  The bone structures of her cheeks, nose, and face shift ever so slightly, and you suddenly realize you are looking down at a slutty version of yourself!  You aren't sure if it's the growing pool of succubus fluid below you or how hot your female twin is, but your " + cockDescript(0) + " is as hard as a rock.\n\n", false);
		outputText("Well, you DID decide to rape her, and now you know that you ARE smoking hot.  You shrug and shove your fem-double's legs apart, exposing her glistening fuck-target.  You bend down and bite her nipple as you position yourself at her entrance, allowing her to grasp your " + cockDescript(0) + " and coat it with her slick dark fluids.  It tingles as the tainted cunt-juices wick up into your dick like the oil from a lantern back home. At first it burns painfully, as if badly sunburned, but you adjust to the discomfort and marvel as your skin turns blackish-purple. Midnight-colored nodules sprout along the upper and lower portions of your " + cockDescript(0) + ", perfectly shaped to tease clits.  Just under its head, a ring of larger growths emerge, somewhat pointy, but flexible, rubbery and incredibly sensitive.  Your " + cockDescript(0) + " gets harder and harder as it grows slightly beyond it's normal size.  It tugs your groin forwards, practically leaping towards its demonic mate on its own volition.  You cave in and press forwards, parting her folds and submerging your crown in corruptive bliss.\n\n", false); 
		//((TOO BIG))
		if(player.cockArea(0) > monster.vaginalCapacity()) {
			outputText("But the pleasure is short-lived, as even her altered physiology can't accommodate your massive tool. With a grunt of frustration you yank your hungry demonic cock away from your goal.  She smiles knowingly and massages her breasts, releasing streams of the same black fluid from her tumescent nipples. It coats the valley of her pornstar-sized breasts, allowing the fluid to flow down and pool in her tight little belly button.\n\n", false);
			outputText("\"<i>This will, like, be even better anyways stud!</i>\" coos a higher pitched you, smashing her tits together wetly for emphasis.  Viscous strings of lubricants form a mesmerizing lattice between her mountainous tits as she puts on a show for you.  Entirely of its own accord, your " + cockDescript(0) + " drags you into her web of corruption, plopping itself firmly into the river of desire that fountains from the peaks on either side. With a steady rhythm, you rock your " + hipDescript() + " back and forwards, plunging into her delicious fuckpillows without abandon. With an inhuman strength, she pushes them together, forcing them to completely encircle your over-sized pole with a tight ring of corruption-dripping tit-flesh.\n\n", false);
			player.cocks[0].cockType = CockTypesEnum.DEMON;
			//[normal]
			if(player.cumQ() < 50) outputText("Droplets of pre begin to escape your cock-slit every time your sensitive nodules pass between your fem-clone's wondrous pleasure-tits.  You fuck harder, no longer caring if it's your choice or your cock's, mashing your purplish head against her lips with every stroke.  The flash-fire of an orgasm sweeps over you, over-engorging the nodules all over your cock and doubling their size.  Your hips resort to tiny rocking motions as you rub your cock-slit into your fem-self's open mouth, blasting thick ropes of tainted black cum into her mouth. Though you quickly empty of cum and collapse onto her, your " + hipDescript() + " continue to fuck like a machine.  All you can do is hang on to your meat and try to stay conscious as your demonic prick feasts on your double.\n\n", false); 
			//[high]
			if(player.cumQ() >= 50 && player.cumQ() < 500) {
				outputText("A steady stream of pre begins to escape your cock-slit, drooling over your double's face and tits as you pound away at her bouncing ring of titflesh.  Every new bump and nodule seems as sensitive as your entire maleness used to be.  Every thrust into the dark wet prison only makes your pre-cum drool faster and your " + cockDescript(0) + "'s new adornments grow fuller and even more tender.  In a flash, the fire of orgasm overwhelms your body's new taint-saturated cock.  Like a kinky 'wave', each nodule from the base to the pointy ring at your crown grows larger as your muscles clench.  ", false);
				if(player.balls > 0) outputText("Your " + ballsDescriptLight() + " practically glow with relief as they begin contracting.  Their entire surface is covered with black veins that radiate from your demonic prick, sharing the corruption with your sperm factories.  ", false);  
				outputText("You throw back your head as the first wave of release pours from your tip, splattering your female clone with inky black cum!  The color startles you for a moment before the next blast moves down your shaft, visibly distending your urethra until it bursts free to coat her hair.  Your hips keep moving of their own accord, massaging the crown-ring with tits during each thrust forwards and accompanying cumshot.  By the fourth load, your double is opening her soaked lips wide and guzzling it down.  By the sixth she's sputtering and coughing as the black sex juice sloughs off her.  By the ninth she's managed to clamp her lips over your cock-tip, and her throat bulges ludicrously with the effort of taking each load.  Thankfully, your orgasm finally winds down.  As the last few globs of inky jism escape from you, you realize your hips are still moving, plunging your massive possessed tool into its new favorite place.  Sighing, you hang onto your endowment and try to stay conscious in spite of your exhaustion and the overwhelming feelings coming from your groin.\n\n", false);
			}
			//[ultrahigh]
			if(player.cumQ() >= 500) {
				outputText("A river of pre-cum begins pouring from your cock-tip's slit, soaking your slutty double's face and tits as it mixes with the corruptive fluids already smeared about.  The alien bumps and nodules upon your " + cockDescript(0) + " flex and twitch at every pass through the fuck-able foe's soft tits, slowly growing as they absorb more of your slut-self's taint.  The tight squeeze around your newly retextured " + cockDescript(0) + " overwhelms any sense of control you may have had as your arousal-soaked groin takes over completely.  You begin pounding the tit-pussy as if your life depended on it, jack-hammering  your " + cockDescript(0) + " forward and back hard enough to make the mountains of breast ripple and shake like jello during an earthquake.  The ring of pointed nodules around your crown continues to swell and grow with every pass through the inky passage, soaking up more and more of the corruption until they are each nearly two inches long.  Overwhelmed by the pleasure, your eyes roll back and a mighty orgasm comes to boil in your groin.  ", false);
				if(player.balls > 0) outputText("Your " + ballsDescript() + " twitch and shake, the veiny surface of your sack darkening as the corruption begins to fill them.  ", false);
				outputText("\n\nLike a perverted version of the wave, the nodules along your length fill with blood, doubling in size along your length as a massive bulge of cum rushes out your urethra.  Black cream drizzles from the tiny growths as the first blast of cum passes into your dick's crown moments before erupting like a volcano.  One second the sexy female version of you is moaning like a whore and licking her lips. The next she is sputtering and gasping as a half-gallon of inky black cum soaks her from head to tits.  Heedless of her discomfort, your legs keep sawing your " + cockDescript(0) + " deeper into this perfect titfuck as more thick bulges of tainted spunk begin to stretch your urethra on their way out.  You babble incoherently as your cock's tip plants itself against her open lips, blasting even more spunk directly into her waiting gullet.  Her cheeks bulge comically as the stuff drips from her nose, but somehow she manages to swallow the bulk of it, her hands vigorously milking your " + cockDescript(0) + " with her fuck-bags.  By the time the third jet of cum erupts, she's unhinged her jaw and somehow taken the head into her mouth, giving unfettered access to pump her belly full of your black jism.  You groan with uncontrollable pleasure as her belly fills with spunk.  Her eyes roll back as the next blasts expand her belly further, at first making her look slightly pregnant and then gradually stretching her belly until she looks like she could have minotaur twins.  You lose count of how much cum you put into her, but eventually she can take no more and your cock is pushed free by the pressure, splattering her face again.  Far from finished, you blast cum over her face as you realize she's lost consciousness, her eyes are totally rolled back and her tongue lolls from her mouth like that of a sleeping bitch.  Eventually your orgasm winds down, but not before leaving her in a 4 inch deep puddle of spunk, looking like more like a blue balloon full of dark water than woman.\n\n", false); 
			}
			outputText("Still, your possessed maleness is far from finished as it continues to slide along her belly and between her still-dripping tits, and before long you feel another orgasm building.  You hang on for dear life, hoping just to stay conscious through the ordeal...\n\n\nHours later you pull away, sated.  For now.", false);
		}
		//((IT FITS))
		else {
			outputText("You plunge in to her velvety depths and feel her rippling cunt-muscles contract tightly around you for a perfect fit.  She gasps as each cock-distorting nodule bounces her two-inch clitty, making your mirror image moan like a bitch in heat.  The corrupted fluids dripping from her snatch squelch loudly, making your groin burn with pleasure.  ", false);
			if(player.balls > 0) outputText("Looking down, you even see the veins on your sack darkening to solid black as the corruption begins tainting your sperm-factories.  ", false);
			outputText("You pull back, letting the ring of pointed fleshy barbs spring free before plunging them back in. The pleasure makes you swoon, nearly forcing you to orgasm on the spot.  ", false);
			if(player.biggestTitSize() > 0) outputText("Your female double reaches down to pinch your nipple, spurring you on, \"<i>Please, could you like, cum for me?</i>\"", false);
			//New PG
			outputText("\n\n", false);
			player.cocks[0].cockType = CockTypesEnum.DEMON;
			outputText("The succubus bucks her hips weakly, still clearly defeated, but egging on your orgasm as dark fluids squelch free from her quim.  \"<i>Please... can't you see how hot you're making me?  I've made your cock perfect, so please make me cum!</i>\" she begs as she quivers with delight.  ", false);  
			outputText("You pause to think about it, not noticing that your groin is pounding away with furious energy, splattering cum and pre over her thighs as your new cock's instincts take control from your waist down.  Gasping with sudden pleasure, you feel a flash of heat pass through your tainted meatstick as an orgasm builds.", false);
			//New PG
			outputText("Each of the new bumps and rounded spines of your " + cockDescript(0) + " flood with blood, doubling in size as orgasm overtakes you.  ", false);
			outputText("Your hips bury your entire length inside her, acting on their own as your " + cockDescript(0) + " clenches, pouring more and more spunk inside her", false);
			if(player.balls > 0) outputText(" as your balls empty their load queue", false);
			outputText(".  ", false);
			//Big cum
			if(player.cumQ() >= 50 && player.cumQ() < 400) outputText("You inhale as black cum spatters from her entrance, her belly distending slightly as you empty what feels like a gallon inside her.  ", false);
			//((Ginormohuge)) 
			if(player.cumQ() >= 400) outputText("Gasping in pleasure and surprise, you marvel as her belly visibly expands with each eruption of your dark load.  At first it looks like a tiny belly, but by the time the orgasm finishes, your girlish double looks like a woman in her ninth month of pregnancy – with twins.", false);
			outputText("\n\nYou pant with exertion and pull back, only to have your " + cockDescript(0) + " plunge right back in. Beginning another rough fucking session, your hips force-fuck her beyond your control.  Exhausted, you lean over her, figuring you may as well enjoy your double's wondrous breasts until your demonic cock has finally sated itself.  You just hope you don't black out from the waves of pleasure each of your new nubs radiates.\n\n\nHours later you pull away, sated.  For now.", false); 
		}
		outputText("\n\nThe succubus licks her fingers clean, looking totally recovered.  In the blink of an eye, she dashes out the door, disappearing.", false);
		dynStats("lus=", 0, "cor", 5);
		cleanupAfterCombat();
	}
	//FEMSAUCE
	else {
		if(monster.HP < 1) outputText("Your foe staggers and falls hard on her ass, utterly defeated.  Her bruises and lacerations slowly fade and heal, regenerating with the aid of her demonic powers.  You easily tear through her clothes, leaving only the damaged stockings that gird her legs. It doesn't take much to force her down on her back and straddle her as you disrobe, ready to take your pleasure.\n\n", false);
		else outputText("Your foe drops to her knees, stuffing three digits into her greedy snatch as arousal overcomes her desire to subdue you.  With great care, you approach your insensible enemy and tear off her clothes, leaving her wearing only the remains of her stockings as you force her down on her back.  As if possessing a will of their own, her legs lewdly spread as you disrobe.\n\n", false);
		outputText("Her budding clit rises from between her folds, hardening like a tiny three inch dick.\n\n", false);
		if(player.biggestLactation() > 1) {
			outputText("<b>You could scissor with her, or maybe force-feed her some of the milk you've backed up.  Which will it be?</b>", false);
			simpleChoices("Scissor",11026,"ForceFeed",11027,"",0,"",0,"",0);
		}
		//No choices if not lactating...
		else {
			dungeonSuccubusForceScissor();
		}
	}
}
public function dungeonSuccubusForceScissor():void {
	outputText("You shiver with anticipation as you hook your leg under her thick thighs, lining up your " + vaginaDescript(0) + " as you press forwards.  The anticipation builds as your matched honeypots grow ever closer.  Making contact, your folds part as her purplish-red clit slips betwixt your nether-lips, vibrating slightly in tune with the succubus' heartbeats.  You gasp, feeling your own " + clitDescript() + " erecting and rubbing against her smooth mound.\n\n", false);
	if(player.clitLength >= 3) outputText("You groan with wanton desire as your " + clitDescript() + " continues to grow and grow until reaching full size and slipping inside the defeated slut's sloppy pleasure-hole.  ", false);
	outputText("It takes only a few seconds to get the succubus' juices really flowing, the sounds of your grinding hips dissolving into a cacophony of liquid squelches.  The gooey corrupt fem-cum tingles, spreading warmth through every patch of skin it touches.  Your locked hips writhe and twist with her's, eliciting pants and squeals from the both of you.  In no time flat, you find yourself cumming and feel your " + vaginaDescript(0) + "'s muscles clench hungrily with an unquenchable desire to be filled.  The succubus shivers in pleasure, probably feeding off your orgasm.  You back off, fingering your " + vaginaDescript(0) + " languidly and denying her a full meal.  Pouting, the succubus dips her fingers back in, determined to cum.", false);
	outputText("\n\nYou turn away with a bemused sigh.  When you glance back, she has vanished!", false);
	dynStats("lus=", 0, "cor", 1);
	cleanupAfterCombat();
}

public function dungeonSuccubusForceFeed():void {
	outputText("", true);
	outputText("You chuckle as you decide to release some of the pent up pressure in your " + allBreastsDescript() + ".  Laying down over your conquest, you grasp her wrists and pin them to the floor as you shove your tits in her face", false);
	if(player.biggestTitSize() > 6) outputText(", nearly smothering the succubus with the swell of tit-flesh", false);
	outputText(".  You jiggle back and forth, lining up a " + nippleDescript(0) + " with the demon's parted lips.  You press your weight down threateningly, making it clear you could suffocate her with a boob.\n\n", false);  
	outputText("\"<i>Drink up bitch, these tits are full!</i>\" you command.\n\n", false);
	outputText("The succubus tentatively takes a " + nippleDescript(0) + " into her mouth, sighing at the tangy taste of your sweat-drenched skin.  Her lips gently suckle, wrapping around the perky hardening nub as it fills with arousal and milk.  You feel something let go inside your " + breastDescript(0) + " and the succubus smiles, now working to free more of your trapped cream.\n\n", false);
	if(player.biggestLactation() < 2) outputText("Her flexible tongue easily curls around one of your " + nippleDescript(0) + "'s, letting her pull and tug on it as she increases the suction from her lips.  Your body rewards her efforts with a faster flow of milk that she sucks down as if she were starving.\n\n", false); 
	if(player.biggestLactation() >= 2 && player.biggestLactation() < 3) {
		outputText("Her flexible tongue wraps around your milk-engorged nipple, pulling it tightly as she increases the suction of her lips.  Your body wastes no time rewarding her and she begins gulping down a steady supply of your breastmilk with a pleased expression on her face. You muse to yourself that perhaps succubi are masochists as breast-milk runs freely from your un-milked ", false);
		if(player.totalBreasts() > 2) outputText("tits.\n\n", false);
		else outputText("tit.\n\n", false);
	}
	if(player.biggestLactation() >= 3 && player.biggestLactation() < 4) {
		outputText("Her flexible tongue wraps around a milk-swollen nipple, immediately squeezing out a jet of thick breast-milk.  The tongue squeezes and tugs while the succubus ramps up the suction between her thick bee-stung lips.  Your body rewards her with fountains of milk, forcing her to visibly gulp and struggle to keep up with the heavy flow.  Milk runs freely down the " + player.skinDesc + " on your chest, pooling around the succubus' groin and your own as the unattended nipple", false);
		if(player.totalBreasts() > 2) outputText("s", false);
		outputText(" can't help but dribble in sympathy.\n\n", false);
	}
	if(player.biggestLactation() >= 4) {
		outputText("Her flexible tongue wraps around a milk-bloated nipple, immediately releasing a massive spray of cream that pours into her gullet, nearly choking her.  You stifle a giggle and pull her closer.  Thankfully, her determined tongue manages to stay in place and start tugging your nipple about, releasing even more of your over-large milk production.  She struggles, her throat and cheeks bulging from your explosive output milk, until it overwhelms her and begin to pour out of her nose.  More milk pours from your unoccupied nipple", false);
		if(player.totalBreasts() > 2) outputText("s", false);
		outputText(" in sympathy, drenching your " + player.skinDesc + " with creamy goodness until it puddles on your captive demon.\n\n", false);
	}
	if(player.totalNipples() == 2) outputText("As your first nipple drains, you move her to your other breast, being sure to motivate her cunt by grinding it with your " + player.foot() + ".  She squeals and sucks harder, emptying the last of your milk with a cute burp.  ", false);
	if(player.totalNipples() > 2 && player.totalNipples() < 6) outputText("As your first " + nippleDescript(0) + " drains, you forcibly move her to the next, unleashing a fresh batch of milk for her to feast upon.  Eventually, it too dries up, so you migrate her onwards to your next " + nippleDescript(0) + ".  After she drains each of your " + num2Text(player.totalNipples()) + ", you smile happily at your now emptied breasts.  ", false);
	if(player.totalNipples() >= 6) outputText("As your first " + nippleDescript(0) + " drains, you force her over to the next, unleashing even more milk for her to feast upon.  In time, that " + nippleDescript(0) + " also empties and you rotate her on to the next.  The cycle repeats seemingly endlessly as you work her from nipple to nipple, relieving the insistent pressure of your breasts and slowly filling her with your milk.  ", false);
	if(player.averageLactation() * player.totalBreasts() < 6) outputText("Her belly bulges slightly from all the breast-milk she's consumed.\n\n", false);
	else outputText("The succubus looks bloated and pregnant from all the milk you've forced into her.  She sloshes and moans incoherently from the strain of it all.\n\n", false);
	outputText("Despite the relief your " + allBreastsDescript() + " now feel, your " + vaginaDescript(0), false);
	if(player.cocks.length > 0) outputText(" and " + multiCockDescriptLight() + " feel hungrier than ever.  ", false);
	else outputText(" feels hungrier than ever.  ", false);
	outputText("You shove your crotch into your milk-dazed foe's white-stained visage, grinding your " + vaginaDescript(0) + " into her mouth until you cum all over her", false);
	if(player.cocks.length == 0) {
		temp = rand(3);
		if(player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLAVERING) outputText(", soaking her with girl-cum.", false);
		else {
			if(player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_WET) outputText(", slicking her face with girlish cum.", false);
			else outputText(", drenching her with a deluge of girlcum.", false);
		}
	}
	else outputText(", and unloading a wave of hot spunk into her hair.", false);
	outputText("\n\nYou push her over, noting that her freed fingers immediately bury themselves in her demonic snatch, loudly squelching as she tends to her own arousal.  Her perfect visage is a mess, coated with musky girlcum", false);
	if(player.cocks.length > 0) outputText(" and a thick layer of spunk", false);
	outputText(".", false);
	outputText("\n\nYou turn away with a bemused sigh.  When you glance back, she has vanished!", false);
	dynStats("lus", -50);
	cleanupAfterCombat();
}
public function incubusLossRape():void {
	player.slimeFeed();
	outputText("", true);
	//Nipplefuck city
	if(player.hasFuckableNipples() && player.lust >= 100) {
		outputText("Molten arousal pumps through your veins, burning away your reason with an unquenchable desire to mate.  You drop your top, exposing your " + allBreastsDescript() + " to your foe in a submissive display. Lowering your eyes, you hope you can tempt him to plug your " + nippleDescript(0) + " with his demonic prick.  You roughly squeeze each sensitive tit, trailing your fingers down the sensitive breast-flesh towards your rapidly dampening fuck-holes.\n\n", false);
		outputText("Your eyes relax as pure sensation overwhelms your already over-excited body.  Your fingers find your nipple-holes, locking around them while tugging and squeezing, stretching them tight with pleasure and pain.  You cast a seductive glance to the incubus' groin, noting that he's been taken in by your wanton display.  He takes a step, his cock rippling and twisting as it shifts and changes before your eyes. It divides it half, splitting into two full-sized pricks.", false);
		if(player.totalNipples() > 2) outputText("  Each of those divides again, splitting into four prehensile penises.", false);
		if(player.totalNipples() > 4) outputText("  They continue dividing until his wriggling mass is sufficient to penetrate every single nipple and then some.", false); 
		outputText("\n\n", false);
		outputText("A pleading moan escapes your lips and your captor obliges you, the cocks wriggling forward under their own power and sliding into your slippery " + nippleDescript(0) + "s with ease.  Each member is perfectly sized to stimulate you without over-stretching your tender breast-flesh.  You barely stifle a giggle, drunk on enough pleasure to shatter a lesser mind.  Your giggling is rudely interrupted by something hard and slick forcing itself between your lips.  You smile and slurp on it like a pacifier, swallowing droplets of pre-cum as his tentacle-like pricks fuck your breasts hard and fast, ", false);
		if(player.biggestLactation() > 1) outputText("splattering milk and pre everywhere.\n\n", false);
		else outputText("splattering your tits with escaped sexual fluids.\n\n", false);
		outputText("The demon tenses, pulling your head forwards and burying your nose against his belly.  The dick in your mouth slides down your throat, hanging just above your belly as it begins to fill your gut with bursts of demonic warmth.  Black cum erupts from your nipples as his orgasm overwhelms their meager storage capacity, soaking your tits in his corruptive essence as the pleasure finally breaks your mind.  Your eyes roll back into your head as you begin cumming... and cumming... and cumming. The orgasm drags on and on as more and more cum pours into your body.  Like a passenger in a car you see what's happening but have no control.  Your body is used and abused for hours before you finally drift off to sleep.", false);
		dynStats("lus=", 0, "cor", 20);
		if(player.hasStatusAffect("DungeonShutDown") < 0) doNext(11025);
		else cleanupAfterCombat();
		return;
	}
	//Tentacle gangbang
	else {
		if(player.lust > 99) outputText("Molten arousal pumps through your veins, burning away your reason with an unquenchable desire to mate. You drop your top, exposing your " + allBreastsDescript() + " to your foe in a submissive display, ", false);
		else outputText("You lower your top, exposing your nubile form to your foe in a submissive display, ", false);
		outputText("lowering your eyes and fixating on his now-rigid demonic member.  Right before your eyes, it begins splitting and dividing into thinner prehensile penises that squirm about in the air, each one reminding you of a snake on the prowl.  ", false);
		if(player.cor < 80) outputText("In a disgusting display", false);
		else outputText("As you grope yourself noisily with your hand into your undergarments, a salacious smile on your lips", false);
		outputText(", you watch as his pricks pulse and thicken out until their masses are as wide as his original dick.\n\n", false);
		if(player.cor >= 80) outputText("As you realize their size and number, you open your eyes wide and smile broadly, reflexively spreading your legs wide, practically begging him to fuck you.  ", false);
		outputText("In a flash, each fat tentacle-cock whips out and surrounds your body in slick demon-flesh.  The tentacles constrict, working in pairs to take off every piece of your " + player.armorName + ".  ", false);
		if(player.biggestTitSize() >= 2) outputText("They make sure to rub each of your breasts, spending a few seconds smearing slick pre-cum into your " + nippleDescript(0) + ".  ", false);
		outputText("A pair of them slides into your undergarments, pressing against your needy crotch and teasing your " + assholeDescript() + " with more slick demonic cum.  ", false);
		if(player.cor < 80) outputText("You wriggle and whine,", false);
		else outputText("You grab the thick tentacle-cock working on your cunt with both hands, as you can barely grab it with one. Then,  while letting out moans fit for a bitch in heat, which you are, you begin", false);
		if(player.vaginas.length > 0) outputText("squeezing your legs around them and grinding your " + clitDescript() + " against the oddly textured demon-cock.", false);
		else {
			if(player.balls > 0) outputText("grinding down against the ribbed and textured demonic cock as it slides between your " + ballsDescriptLight() + ".", false);
			else if(player.cocks.length > 0) outputText("squeezing your legs around the thick demonic flesh as a steady dribble of pre-cum drips from your " + cockDescript(0) + ".", false);
			if(player.gender == 0) outputText("grinding suggestively on your captor's rods, barely noticing as the last of your " + player.armorName + " falls away.", false);
		}
		outputText("\n\n", false);
		//FUCKKKING
		//Female paragraph
		if(player.vaginas.length > 0 && (player.cocks.length == 0 || rand(2))) {
			outputText("The incubus at last decides to tend to your over-aroused body and pulls you off the ground with his tentacles, suspending you in mid-air.  ", false);
			if(player.cor < 80) outputText("You feel your " + player.legs() + " lifted and pulled tight as countless demonic cocks encircle your body, binding and constraining you further.  You whimper as a demonic tentacle probes your back door while a thicker one lines itself up just below your " + clitDescript() + ".  ", false);
			else outputText("As he lifts you, you spread your legs, showing him your cunt which is dripping wet from anticipation, and grabbing your ass to give him a perfect view of your " + assholeDescript() + ".  You then beg him, between lecherous moans, to use his three biggest tentacles, as you want to have the most sensations.  With a sadistic smile, he lines up two tentacle cocks about as big as your arm over your " + vaginaDescript(0) + " and your " + assholeDescript() + ".  ", false);
			outputText("You then giggle and try to wiggle your " + hipDescript() + " forward, begging for him to take you and quench the fire burning in your " + vaginaDescript(0) + ".  The incubus obliges, pressing forth with both drooling members and simultaneously plugging your front and back doors.  ", false);
			if(player.cor < 80) outputText("You gasp from pleasure and surprise, ", false);
			else outputText("You open your mouth wide, as the enormous tentacle-cocks force their way in, dripping demonic pre-cum all over. Quickly, it acts as additional lubricant, and the pain largely subsides.  You find that these massive demonic cocks' size is perfect to stimulate, in an incredibly pleasurable way, all sides of your cunt at once, and to stretch your ass just a bit over your preferred size.  As the incubus starts moving his appendages in rhythm, you're lost in heavenly pleasure, eyes closed, letting out deafening moans of lust, your legs and arms dangling without any thought for dignity.  You are deeply ", false);
			outputText("enjoying the knobbed texture of his shafts as you're double-penetrated by a single demon. The incubus smirks as another cock-tentacle wraps itself up around your neck like a shiny student collar and plugs your noisy little mouth.  You groan into his member as you're ", false); 
			if(player.cor < 80) outputText("squeezed and caressed by the writhing tentacle-pricks in and around your body, lost in the pleasure and taste of demonic pre-cum.\n\n", false);
			else outputText("getting roughly fucked by the two tentacle-cocks at the same time.  Taking the tentacle-cock in your mouth with both hands, you eagerly swallow every bit of demonic pre-cum, then suckle on the huge cock-slit. \n\n", false);	
			
			//FemCum
			if(player.clitLength > 3) outputText("You nearly cum on the spot when the cock fucking your pussy loops its length around your " + clitDescript() + ", the cum-slickened coils driving you mad with pleasure as they coil, slide, and jerk around your clit as if it was a cock.  ", false);
			else outputText("You nearly cum on the spot when the cock fucking your pussy curves up to rub its textured nodules against your " + clitDescript() + ".  ", false);
			player.cuntChange(player.vaginalCapacity()*.8, true);
			if(player.cor >= 80) outputText("You cum more times than you are able to count, each time causing a tightening of your fuckholes, which increases the rubbing against the demonic nodules and sends another wave of pleasure to your dazed brain.  You begin to drool freely, revelling in this most unholy mating.  ", false);
			outputText("The prick in your mouth surges forward, sliding deep into your throat.  The coils around your neck tighten in response, choking your neck into a tight cock-sleeve as you feel bulges of cum moving along its length.  In moments you feel your belly starting to grow full, sloshing with cum as you become desperate to breathe.  The tentacles lodged in your " + assholeDescript() + " and " + vaginaDescript(0) + " react in similar fashion, stretching you wide as they begin pumping your body full of vast quantities of spunk.  A few free tentacles begin spurting gobs of the white stuff onto your " + player.skinDesc + ", soaking you in the stuff as you black out from a combination of oxygen deprivation and pleasure.", false);
			dynStats("lus=", 0, "cor", 25);
			player.buttChange(monster.cockArea(0), true);
			if(player.hasStatusAffect("DungeonShutDown") < 0) doNext(11025);
			else cleanupAfterCombat();
			return;
		}
		//Male/Genderless
		else {
			outputText("The incubus at last decides to tend to your over-aroused body and pulls you off the ground with his tentacles, suspending you in mid-air.  You feel your " + player.legs() + " lifted and pulled tight as countless demonic cocks encircle your body, binding and constraining you further.  You whimper as a demonic tentacle probes your back door, slathering your " + assholeDescript() + " with a nubby cock-head as it slowly presses forward and fills you with incredible tainted warmth.  Each nub and ridge that grinds past your sphincter bumps against the organs in your backdoor and fills you with pleasure that only increases as more of the demonic pre-cum is wicked into your body.  The gasp you started fades into a soft croon of pleasure before being muffled entirely by another thick prick.  The shaft belonging to the dick in your mouth curls around your neck like the collar a pet or submissive slut would wear.", false);
			if(player.cocks.length > 0) outputText("  As your body's orifices fill with more and more dripping demonic dick-flesh, your " + cockDescript(0) + " becomes painfully hard.  Another tentacle wastes no time in wrapping itself tightly around the base like a cock-ring.  The rest of the demon's prehensile tool slides along your shaft, curling around to squeeze and jerk you off.", false);
			if(player.balls > 0) outputText("  You groan around the dick plugging your throat as another tentacle-like appendage wraps around your " + sackDescript() + ", pulling your " + ballsDescriptLight() + " down and gently squeezing them.", false);
			outputText("\n\n", false);
			//Genderless Orgasm
			if(player.gender == 0) outputText("The tainted cum mixed with the sensation of fullness provide you with pleasures beyond what your genderless body could accomplish on its own.  You writhe as the demon face-fucks you with one tendril while another continues to bury itself ever-deeper into your abused " + assholeDescript() + ".  ", false);
			if(player.cocks.length > 0) outputText("The cock-tentacle around your " + cockDescript(0) + "  increases the pace of its stimulation as it begins to spurt hot wet cum over you, giving it lubrication as it jacks you off while staying tight around your base to prevent you from an orgasming.  ", false);
			outputText("You feel cum pulse through the tentacles encircling you as the incubus loses control of his tentacles.  Cum pumps into your belly, suffusing you with drug-like warmth as the tentacle around your neck pulls tight enough to squeeze the cock inside your throat.  You squirm and gasp for oxygen as spooge begins unloading into and around your body to the point where you aren't sure where your body begins and the demonic-spunk ends.  You twitch in what you assume is orgasm as you fight to breathe, all the while more cum is squeezed into your stuffed belly and ruined anus. The tentacle in your ass backs out slowly, having filled every inch of your intestines with cum, until it pops free with a splatter.", false);
			outputText("\n\n", false);
			if(player.cocks.length > 0) {
				outputText("Being so thoroughly used and stimulated pushes you over the edge of orgasm, and your ", false);
				if(player.balls > 0) outputText("balls", false);
				else outputText("prostate", false);
				outputText(" unloads with enough force to squeeze past the constrictor clutching at your groin.\n\n", false);  
				//Small cum
				if(player.cumQ() < 50) outputText("You groan and orgasm with enough force to splatter a few ropes of cum into the sea of demon-spunk that soaks you from head to toe.  ", false);
				//Big cum
				if(player.cumQ() >= 50 && player.cumQ() < 400) outputText("Your orgasm goes off like a shotgun blast, splattering the incubus with a huge wad of cum.  It's but the first of many, and though each load of jizz is of comparable size, the force behind them diminishes until the last few blasts drip down your body and soak your " + player.legs() + " and " + player.feet() + ".  ", false);
				//Huge cum
				if(player.cumQ() >= 400) outputText("Your orgasm goes off like a volcano, visibly distending your " + cockDescript(0) + " as a huge wave of cum erupts from your groin, painting the incubus and floor with your spoo.  You cry from the sheer pleasure as the next wave builds and erupts, nearly as large as the last.  The demon-cock controlling your prick aims this blast up, forcing you to soak your " + hairDescript() + " and face with slick goo. The orgasming drags on and on while you slowly turn blue from oxygen deprivation. Before long, both you and the incubus are buried under a wave of white.  ", false);
			}
			outputText("The feeling is so intense that your " + hipDescript() + " twitch and move of their own volition while your eyes roll back in pleasure.\n\n", false);
			outputText("You black out just as you feel the cock-tentacle in your throat retracting. You dully feel your body drop to the ground, your pregnant-looking belly sloshing with demon jizz.", false);
			player.buttChange(monster.cockArea(0), true);
			dynStats("lus=", 0, "cor", 25);
			if(player.hasStatusAffect("DungeonShutDown") < 0) doNext(11025);
			else cleanupAfterCombat();
		}
	}
}

public function incubusVictoryRapeBackdoor():void {
	outputText("Every day you've spent in this corrupted landscape has made you stronger and hornier, the evidence of which now kneels at your feet.\n\n", true);
	outputText("The fight over, your eyes begin to wander. You find you cannot resist staring at the huge swinging cock exposed by the incubus' crotchless overalls. The sight ignites desire that has been building within you ever since you arrived in this corrupted land. With an unnatural hunger, you knock the defeated incubus onto his back. He closes his eyes and groans, lost in his own world of lust and pain and unable to resist as you wantonly straddle him. His tool is hot in your hand as you tease it and his cock begins to grow slick with pre-cum. You lick your lips at the sight of his now glistening member, but not for hunger of food or drink. It is another kind of hunger that longs for satisfaction, a hole that needs to be filled. Eagerly, you position his swollen glans against your " + assholeDescript() + " and begin to ease yourself down over the massive tool. You start slowly, but the pleasure it's giving feels so good you ram the rest of the incubus' cock deep into your " + assholeDescript() + ".  ", false);
	outputText("His eyes flash open as if you'd just sent a jolt of electricity through him and he regains his senses, becoming hyper-aware of what you're doing. The incubus instinctively moves to control your " + hipDescript() + " and " + buttDescript() + " as they grind against him, guiding his cock towards pleasurable areas up your " + assholeDescript() + " that you would never have guessed were there a short while ago.\n\n", false);
	outputText("All too soon, he grunts and shivers as loads of his hot cum begin to squirt into you. He may be cumming, but you're not done yet; each squirt of seed only fans the flames of lust within you, making your increasingly wet and noisy thrusts even harder. Enjoying the ride and still nowhere near satisfied, you start sliding up and down on his slick pole even faster than before. He halfheartedly tries to push you off as you continue draining him of his seed, your lust seemingly unquenchable. But you cannot be stopped; his efforts only add to your pleasure as he struggles and unloads underneath you. With your belly beginning to swell with the cum you're relentlessly drawing from the incubus, you don't know how much longer either of you will last. Each movement of his tool inside you heightens the fire inside you until, with an unholy roar, the pleasure peaks and wave after wave of shuddering orgasm crashes over you. Each one hits hotter and harder than the last until finally, your senses are overcome and you lose consciousness entirely.\n\n", false);
	outputText("You awaken moments later beside a sleeping, limp, and drained incubus. You have definitely come out on top from the encounter. Though you feel stretched, sticky and a little sore, for the moment at least the burning desire to fill your " + assholeDescript() + " is satisfied.", false);
	player.buttChange(monster.cockArea(0), true);
	player.slimeFeed();
	dynStats("lus=", 0, "cor", 2);
	cleanupAfterCombat();
}
public function incubusVictoryRapeSex():void {
	outputText("", true);
	//RAPE THE DEMON -
	//(BUTTRAPE - Requires Penis)
	if(player.cocks.length > 0) {
		outputText("With a few deft motions, you shift your " + player.armorName + " to expose your ", false);
		if(player.gender == 3) {
			if(player.balls > 0) outputText(multiCockDescriptLight() + ", " + ballsDescriptLight() + ", and " + vaginaDescript(0), false);
			else outputText(multiCockDescriptLight() + " and " + vaginaDescript(0), false);
		}
		else {
			if(player.balls > 0) outputText(multiCockDescriptLight() + " and " + ballsDescriptLight(), false);
			else outputText(multiCockDescriptLight(), false);
		}
		outputText(".  Having resolved to take the demon's backdoor, you approach his weakened form with brimming confidence.  He looks up, clearly hoping your plan is to squat on his throbbing member.  You dispel his misguided notion when you grab him by the horns and shove his face against the floor. He struggles weakly until you press down harder, making it clear he is to stay in position - on his knees with his head down and his ass in the air.  Circling your prey, you inspect his flawless body and carefully note that the hole at his crotch actually exposes a fair portion of his very supple and surprisingly feminine-looking backside.\n\n", false);
		outputText("You don't waste any time, gripping your " + cockDescript(0) + " in one hand and ", false);
		if(player.cocks[0].cockType == CockTypesEnum.HORSE) outputText("pressing your thick flare ", false);
		if(player.cocks[0].cockType == CockTypesEnum.DOG) outputText("pressing your pointed tip ", false);
		if(player.cocks[0].cockType == CockTypesEnum.HUMAN || player.cocks[0].cockType.Index > 2) outputText("pressing your head ", false);
		outputText("between the incubus' cheeks towards his inhumanly smooth rear-passage.  You gasp in delight at the tight ribbed texture of his asshole as you slide ", false);
		if(player.cocks[0].cockLength > 10) outputText("deep inside ", false);
		else outputText("inside ", false);
		outputText(".  The demon underneath you grunts in an attempt to sound displeased, but it's plain to see the pre-cum he's dripping all over the floor.  What a slut!  You slap his ass and begin roughly butt-fucking him, panting with each plunge into the depths of his ridged passage, gradually increasing your tempo until your " + hipDescript() + " fill the room with loud slapping noises.", false);
		if(player.balls > 0) outputText("  Your " + ballsDescriptLight() + " swing freely, smacking into the demon's own and making both of you squeal and dribble more pre-cum.", false);
		outputText("\n\n", false);
		//(CUM)  
		if(player.balls > 0) outputText("You feel your " + ballsDescriptLight() + " draw up tight against your body.  ", false);
		outputText("Warm heat begins to build inside your groin, pooling under the base of your " + cockDescript(0) + ".  You realize you're about to paint this demon's gut with white, the thought only turning you on more.  ", false);
		if(player.cumQ() > 200) outputText("You groan as you feel your urethra being stretched by the sheer volume of fluid beginning to shoot through it.  ", false);
		outputText("You throw back your head and cum, slapping the incubus' ass with one hand while you grip and squeeze the jiggling flesh of his other cheek.  ", false);
		if(player.cumQ() < 50) outputText("A few thick spurts later and y", false);
		if(player.cumQ() >= 50 && player.cumQ() < 400) outputText("Thick jets of cum pump into the demon's plump backside, soon building up a wave of pressure that pushes back against you.  Y", false);
		if(player.cumQ() >= 400) outputText("A massive cock-distending bulge of cum works through your shaft, splashing into the demon's rectum in an explosive burst of pleasure. Unfortunately for your victim, it is only the first of many such cum-blasts. In no time flat, jism is spurting from his overfilled rectum while his belly looks a few months pregnant. You feel weak from discharging so much fluid, and y", false);
		outputText("ou fall back, the fluid of your orgasm dripping from your " + cockDescript(0) + " and the gaping asshole of your latest conquest.\n\nYou turn to gather your " + player.armorName + ", and when you look back the demon is gone, leaving only a small puddle of male fluids in his wake.", false);
		dynStats("lus=", 0);
		cleanupAfterCombat();
		return;
	}
	//(VAGINAL - Requires Vagina)
	else {
		player.slimeFeed();
		outputText("With a few deft motions, you shift your " + player.armorName + " to expose your ", false);
		//Herm
		if(player.gender == 3) {
			if(player.balls > 0) outputText(multiCockDescriptLight() + ", " + ballsDescriptLight() + ", and " + vaginaDescript(0), false);
			else if(player.balls > 0) outputText(multiCockDescriptLight() + " and " + vaginaDescript(0), false);
		}
		else {
			outputText(vaginaDescript(0), false);
		}
		outputText(".  Striding forwards with hunger in your eyes, you give your left hand free access to your groin and slip your fingers between the moist folds of your " + vaginaDescript(0) + ".  As you undulate into the incubus' personal space, a swift thrust of your " + hipDescript() + " buries your fingers up to the knuckles and knocks the demon onto his well-muscled back.\n\n", false); 
		outputText("He looks up at you with a practiced eye, adjusting his demon-tool's size to better fill your  " + vaginaDescript(0) + ".  ", false);
		//(set cocksize = to 80% vaginalCapacity).
		
		outputText("Thankful for the gesture, you sink down onto him, letting the nubs of his crown stimulate your lips and the underside of your " + clitDescript() + ".  ", false);
		if(player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLICK) outputText("In no time flat your drooling fluids soak him in slippery wetness.  ", false);
		if(player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLICK && player.vaginas[0].vaginalWetness != VAGINA_WETNESS_DRY) outputText("Before long, you've lubricated a fair portion of his tool with wetness.  ", false);
		if(player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DRY) outputText("Despite your usual light lubrication, you manage to moisten the top-half of his tool with wetness.  ", false);
		outputText("Relaxing the muscles in your " + player.legs() + ", you let a few inches of his length slip inside you, every nub and nodule of his corrupted prick filling the walls of your love-canal with inhuman pleasures that make your knees weak.  A particularly delightful bump brushes your " + clitDescript() + ", causing your " + player.legs() + " to finally give out. The incubus' nubbly cock plunges entirely inside you.\n\n", false);
		outputText("You gasp and moan like a cheap whore, disgusted by yourself and yet so turned on by the total loss of self-control.  The incubus is leering up at you, having regained some of his lost confidence.  Despite the lust, desire and pleasure burning through the hot pole buried in your abdomen, you work up enough rage to grip his neck with your left hand and practically choke him out.  You work your hips quickly as you feel his pre start to drip into your canal, spreading tingling warmth in the deepest parts of your passage and into your cervix.  You tighten your grip as you forcibly take your pleasure, barking in displeasure at the demon, \"<i>Don't look like you're enjoying this too much bitch, or I'll take it out of your hide.</i>\"  Satisfied at the renewed look of fear in his eyes, you return to using his magnificent tool as a masturbation aid.\n\n", false);
		outputText("Unable to contain your body's desires due to either the demon's aura or his wonderful penis, you slam your " + vaginaDescript(0) + " onto his member with impunity, twitching and squeezing involuntarily.  His tainted pre-cum begins seeping deep inside your uterus and you cry out with orgasmic intensity.  Your entire body clenches down, even the hand clamped on the incubus' windpipe. You feel his demon-cock swell up inside you in response to his stress, stretching your cunt taut.  His skin darkens from the lack of oxygen as he begins cumming HARD inside you.  Your womb immediately fills with his demon-seed, leaving ribbons of spunk to drip from your tightly-stretched cunt.  You sigh in delight as your muscles slowly stop quivering.  With a pleasured gasp, you rise off the distended demon-prick, and realize that you've choked your foe into unconsciousness. Still, you did let him cum, so maybe he won't mind too much when he wakes.  Feeling sensual and sated, you redress and prepare to explore the rest of the factory. ", false);
		player.cuntChange(player.vaginalCapacity()*.8, true);
		dynStats("lus=", 0, "cor", 2);
		cleanupAfterCombat();
		return;
	}
}



//Service the incubus after winning (WHY DO THIS?  BECAUSE ITS HOT!)
public function incubusVictoryService():void {
	player.slimeFeed();
	outputText("", true);
	outputText("You lick your lips, moistening them as you decide that the demon will provide your next 'snack'.  Touching the defeated incubus' soft skin, you grab him by the wrists and yank him to his clawed feet. Leaning him back against the wall as he sways unsteadily, you tenderly slide down his body and take the measure of his monstrous meat with your hands. The smooth skin and tiny bumps slide between each finger as his manhood firms and twitches in response.  You glance up and grab his baseball size nuts, caressing the smooth hairless sack that contains them, watching the demon-man sigh and relax with equal parts desire and relief.\n\n", false);
	outputText("You lean forwards, opening your mouth ", false);
	if(player.hairLength > 10) outputText("and brushing a strand of " + player.hairColor + " out of the way ", false);
	outputText("as his shiny purplish monster-cock fills your view. You kiss the tip, swirling your tongue around the nubbly ridge that surrounds the crown.  After a few moments of your tongue's focused attention, you are rewarded with a dollop of slightly sweet pre-cum.  You pause momentarily to smile at your victim before you wrap your hand around as much of him as you can hold and start to jack him off, slowly cramming more and more of his length inside your mouth.  Your free hand continues to fondle his balls, occasionally sliding a finger along the inside of his thigh.\n\n", false); 
	outputText("You feel his balls begin to grow. Perhaps he can sense your thirst for cum, or maybe he just wants to enjoy it - but you are sure he is going to finish spectacularly. They stop swelling just as they reach the size of grapefruits, tingling and pulsing spectacularly in your hand.  You stroke him faster, letting you guzzle his pre as it pours into your greedy mouth.  A coo of delight escapes from your tightly-stretched lips as you savor his tasty fluids.\n\n", false);
	outputText("The incubus' hips begin humping your face, stuffing a few more inches of his length into your throat and forcing you to struggle against gagging.  His cock swells wider and nearly unhinge your jaw as you feel a gooey warmth wash your throat, flooding your gullet with demon-seed.  Still impaled on his nubby member, your body is rocked back and forth by the strength of his orgasm, the motions making your belly slosh with an increasingly large load.  You moan at the warmth of his corruption seeping through your body as his orgasm diminishes. Yanking back hard, you let his dick slip free of your mouth as the last spurt of cum blasts your face.\n\n", false); 
	outputText("You push the exhausted demon down and idly collect the cum from your face with your fingers, slowly licking each clean.  Feeling rather sensual and sated, you decide to resume exploring the factory.\n\nAfter redressing you turn about, and see the demon is gone, leaving only a small pool of cum in his wake.", false);
	cleanupAfterCombat();
	return;
}
public function omnibusVictoryEvent():void {
	outputText("", true);
	if(monster.lust > 99) {
		outputText("The omnibus trembles where she stands, her proud demonic dick twitching and pulsating as her desires totally overwhelm her.  The tainted nodules covering the purplish hermaphrodite's member ripple and swell from the base towards the tip, culminating with an explosive eruption of sticky, white demon-seed.  She moans with shame and pleasure, pumping larger and larger volumes of cum onto her office's floor.  She drops to her knees, too exhausted and ashamed by her premature orgasm to continue fighting.\n\n", false);
		outputText("\"<i>Ooooh no.  You can't tell the other demons I got off so easily!  I'll never live it down,</i>\" she cries, \"<i>You've beaten me, please if you let me go and promise not to tell the other demons I'll use my magic to give you a gift!  My magic is powerful, I can do nearly ANYTHING with it when the subject desires the changes.</i>\"\n\n", false);
	}
	else {
		outputText("The omnibus trembles and drops to her knees, utterly defeated.\n\n", false);
		outputText("\"<i>Please, if you'll let me go I could use my magics to give you nearly anything you want!  Just please don't tell the other demons what happened here, I'd never live it down,</i>\" she begs.\n\n", false);
	}
	outputText("What do you do?  You could use her boon increase the size of your endowments or maybe regain some of your lost humanity!  Or you could play it safe and turn down her offer.  Although then you'd have to decide to let her go or kill her.", false);
	choices("GrowBreasts",11048,"GrowDick",11049,"Normal-Face",11050,"Normal-Chest",11051,"Normal-Groin",11052,"Normal-Legs",11053,"",0,"",0,"No (Let go)",11054, "No (Kill Her)",11056);
}
public function omnibusLossRape():void {
	outputText("", true);
	if(player.HP < 1) outputText("You stagger into the desk, clutching tightly just to stay upright.  ", false);
	else outputText("Forgetting about the fight, you lean on the desk and slide your free hand under your " + player.armorName + ", seeking any pleasure you can get.  ", false);
	outputText("Sensing victory, the demoness sidles up next to you and pushes you into a chair.  Incapable of resisting, all you can do is watch as she opens your " + player.armorName+ " for easier access.  She steps back and admires her handiwork as she gives you a thorough looking over.\n\n", false);  
	outputText("\"<i>I have just the thing for a ", false);
	if(player.gender <= 1) outputText("man", false);
	else outputText("woman", false);
	outputText(" such as you.  I've been crossbreeding the parasites that developed in the deep jungle, trying to create the PERFECT slave-maker.  You get to be my first test subject,</i>\" she says.\n\n", false);
	outputText(" She sees the look of fear creeping into your eyes and pats you comfortingly, \"<i>Awww don't worry. It'll feel REALLY good.  If anything you should feel honored to be assisting an Omnibus in her experiments.</i>\"\n\n", false);
	outputText(" She opens one of the desk drawers, and searches briefly before her eyes light up with recognition.  \"<i>Here we are,</i>\" she says as she pulls something free...", false);
	doNext(11047);
}
public function omnibusLossRape2():void {
	outputText("", true);
	//(Multi dicks)
	if(player.cocks.length > 1) {
		outputText("In her hand is a mass of shining green material.  She turns to face you, bringing it closer and letting you see the lights shift and change on its luminescent surface.\n\n", false);
		outputText("\"<i>For someone as... different as you, we will have to try this creature.  I've bred it from a mixture of plant-tentacles, dazzle-weed, and what we've taken to calling pussy plants,</i>\" she mentions, her hands working to open the mass on the table.  The interior surface is a mass of slimy undulating protrusions that wriggle feverishly as they are exposed to the air.  She gathers up the thing in her arms while continuing to speak to you, \"<i>You see, my plant will encapsulate your members tightly, wrapping them in sticky wetness.  Its fluids are a perfect blend of aphrodisiacs, lubricants, and will-sapping narcotics.  You'll love it.</i>\"\n\n", false);
		outputText("You make a desperate attempt to escape her chair, but your body fails to do much more than squirm in place.  She drops the creature squarely into your crotch and hops up onto her desk to watch.  Thousands of tiny wet nodules immediately begin massaging your " + multiCockDescriptLight(), false);
		if(player.balls > 0) outputText(" and " + ballsDescript(), false);
		outputText(".  You groan as the pleasure washes over you like a wave.  Your squirming stops as your hips begin twitching into the air, as if begging for even more stimulation.  It's not fair how good this feels...you can't help it, it's just too hard to fight.\n\n", false);
		outputText("You watch with detached fascination as each of your " + multiCockDescript() + " is wrapped tightly in shiny green material.  The shape of each penis is still clearly defined under the pulsating green stuff, though you can see it shifting and rippling over your lengths as it pleasures you.  It almost looks like some kind of kinky bondage-toy.  Aware of your attentions, the green stuff squeezes you tightly and begins flashing beautiful bioluminescent color patterns across its surface that scatter your thoughts as you watch.  You blink a few times as the green mass rolls more of itself out, curling over your ", false);
		if(player.balls > 0) {
			outputText("balls", false);
			if(player.vaginas.length > 0) outputText(" and " + vaginaDescript(0), false);
		}
		else if(player.vaginas.length > 0) outputText(vaginaDescript(0), false);
		else outputText("taint", false);
		outputText(", sliding up your abdomen, and oozing down over your hips.  As it spreads the colors fill more and more of your head, clearing away your thoughts of resistance.\n\n", false);
		outputText("A soothing female voice talks to you from somewhere, \"<i>Did I mention it's specifically tuned to ensnare the conscious mind with it's pretty colors?  I must have forgot.  Well, I see you've discovered it on your own.  The colors are just so perfect for opening your mind to me, aren't they?  They just chase away your thoughts and let my words slip deep into your subconscious.  I bet it feels nice to just focus on the colors and let my pet tease your cocks, doesn't it?</i>\"\n\n", false);
		outputText("You nod without any awareness of the act.\n\nThe voice laughs and continues while the creature reaches around your " + hipDescript() + " and slides a feeler between your cheeks, completing the tight loop around your groin, \"<i>That's good.  You want to let the creature cover as much of you as it wants.  Being sex-food for a symbiotic plant is arousing beyond measure.</i>\"  You feel the creature licking at your " + assholeDescript() + " until it relaxes, and then slides something inside.  A warm wetness spreads through your bowels as something begins caressing your prostate from inside you.\n\n", false);
		outputText("Overloaded with pleasure, you feel your " + multiCockDescriptLight() + " pulse and cum, creating translucent green cum balloons the size of ", false);
		if(player.cumQ() < 50) outputText("apples ", false);
		if(player.cumQ() >= 50 && player.cumQ() < 300) outputText("cantaloupes ", false);
		if(player.cumQ() >= 300) outputText("watermelons ", false);
		outputText("at the end of each of your dicks.  The creature's flashing intensifies while your hips quake uncontrollably, pumping the last of your load feeds into the wonderful plant.  The light-show grows brighter, totally emptying any remaining stray thoughts and leaving you feeling wonderfully open.\n\n", false);
		outputText("\"<i>Being used for your cum is great,</i>\" says the voice and you agree, it is great.\n\n", false);
		outputText("\"<i>Your greatest fetish is allowing demonic creatures to feed on your cum,</i>\" she says, and it feels so right.  Your cum is meant for demons and plants to feast on.  Just the thought makes you want to orgasm again.\n\n", false);
		outputText("\"<i>Since you provide food-source, that must make you livestock.  You like being livestock.  Livestock don't have to think.  Livestock follow orders.  Best of all, as livestock you can live your favorite fetish of being milked of all your cum, every hour of every day,</i>\" the voice says, filling your mind with new thoughts.  Of course it's right, you can just let a demon or tentacle plant milk you and do all the hard stuff, like thinking.  All you have to do is cum.  The thought makes you shiver as the plant-suit absorbs the encapsulated bubbles of jizz.  The dazzling lights grow even brighter as it takes in the nutrients.\n\n", false);
		outputText("*FLASH* \"<i>You want to cum for the plant</i>\"\n\n", false);
		outputText("Tendrils of plant crawl up your belly, coating you in slime as they massage every inch of you.\n\n", false);
		outputText("*FLASH* \"<i>You need to cum for the plant</i>\"\n\n", false);
		if(player.breastRows.length == 1) outputText("They reach the lower curve of your breasts.\n\n", false);
		if(player.breastRows.length > 1) outputText("They slide over your lowest pair of breasts, encapsulating them in wriggling tightness.\n\n", false);
		outputText("*FLASH* \"<i>You love cumming for anything and anyone.</i>\"\n\n", false);
		if(player.breastRows.length == 3) outputText("Your middle breasts tingle with absolute pleasure as they too become engulfed in tightness.\n\n", false);
		if(player.breastRows.length == 2) outputText("You groan as the plant grows up the summit of your top breasts, coating the bottom half of your aureola.\n\n", false);
		if(player.breastRows.length == 1) outputText("Your " + nippleDescript(0) + "s become hard as steel as the wave of slick pleasure washes over them.\n\n", false);  
		outputText("*FLASH* \"<i>You love being told to orgasm.</i>\"\n\n", false);
		if(player.breastRows.length == 1) outputText("The wriggling mass slides up the top-most parts of your breasts, narrowing into two tiny tendrils that loop around your neck.\n\n", false);
		if(player.breastRows.length >= 2) outputText("The wriggling mass climbs your top pair of breasts with ease, wrapping your diamond-hard nipples in slime and sensation.  It continues climbing upward, narrowing into two bands that loop around the back of your neck.\n\n", false);
		outputText("*FLASH* \"<i>To orgasm is to obey.  You love to orgasm.  You love to obey.  You love to obey my voice more than any other.  Obeying my voice gave you these orgasms.  Since you love to obey me, you must be my pet.</i>\"\n\n", false);
		outputText("Your mistress' OTHER pet wraps around your neck, forming a choker comprised of shifting green colors.  You smile as you realize it is done - you've become one of her pet cattle.  Your body is wrapped in an emerald sea of shifting pleasure, just like your mistress wanted.  If it weren't for the obvious bulges of your " + multiCockDescriptLight() + ", you'd look to be wearing an extraordinarily revealing one piece swim-suit.  The constant teasing at your crotch continues, and you stay rock-hard, even though you just came.  The idea of being milked to feed your new clothing just turns you on so much that you bet you're leaking constant streams of pre-cum for your new green master.\n\n", false);
		outputText("The flashing subsides, and your new thoughts rush into the void.  You immediately begin masturbating your encapsulated members as you seek to obey.  To orgasm is to obey.  To obey is to orgasm.  You discover that you can feel every touch through the skin of your 'clothing'.  You increase the tempo, knowing that your orgasm will be feeding the creature that now lives on you, fulfilling your deepest darkest desires.  You cum again, just as hard as before, inflating " + num2Text(player.cocks.length) + " shiny green balloons with the proof of your obedience.\n\n", false);
		
		if(player.hasStatusAffect("Camp Marble") >= 0) {
			outputText("Suddenly, a loud scream is heard down on the factory floor. You and your mistress turn to see Marble dashing up the stairs to the foremen's office.  Your mistress looks over at her and says with some amusement, \"<i>Oh ho!  So another cow has come to join in the fun.</i>\"\n\n\"<i>Sweetie! What has she done to you?</i>\" Marble exclaims, \"<i>What has she put on you?!</i>\"\n\n\"<i>Oh, so you knew this girl?</i>\" your mistress asks you, \"<i>It's a Lacta Bovine from the looks of it, so it seems this time I'll be adding a real cow to the pens.</i>\"  Marble turns to your mistress and brandishes her hammer, but the horror from the thought of your mistress being hurt causes you to spring forward and grab Marble.  The brief distraction gives your mistress a chance to sink a syringe into Marble's shoulder, and within moments she slumps onto the ground unconscious.\"\n\n", false);
			outputText("Your mistress turns back to you and smiles.\n\n\"<i>Well, she should make a fine replacement for you in the pens,</i>\" she says before tapping her chin thoughtfully and looking back at you, \"<i>Really is convenient that I don't have to worry about my new pet dying on me now, hun.</i>\"  Then she pushes you back into the chair and says \"<i>But first...\"\n\n", false);
			
		}
		else outputText("Your mistress looks down with approval and speaks, \"<i>Very good.  ", false);
		outputText("I want you to stay here and cum till morning.  My pet needs lots of nutrition to recharge, and I have plans for new ways to teach you to obey tomorrow.</i>\"\n\n", false);
		outputText("Happy to have such a wonderful task, you spend the next day being bathed in drugged aphrodisiacs, cumming over and over and over.  Every morning the creature flashes you into obedience while the voice teaches you more and more about how to think.  After a week you're the perfect pet.  By the end of your first month of servitude, any memories of your past life are gone.  You spend the rest of your days feeding your mistress and her pet, and helping her refine and breed her pets in order to teach others the way.", false);
		eventParser(5035);
		return;
	}
	//Dick version
	if(player.cocks.length == 1) {
		outputText("In her hand is a squirming purplish mass.  It has a smooth outer surface, spotted with dark shades of iridescent purple. The opposite side is comprised of a smooth mucusy membrane covered with wriggling pink cilia.\n\n", false);
		outputText("She leans over you with a predatory smile, \"<i>This little guy is my favorite.  I've even given him a bit of 'field testing'.</i>\"  She gestures towards a small dripping orifice, explaining, \"<i>You see, once I put this on you, it'll open up niiice and wide.  It'll suck your nice little cock into its mouth and starting squeezing and massaging you with each of its tiny tentacles until you can't help but release all your ", false);
		if(player.cor < 33) outputText("sweet ", false);
		if(player.cor >= 66) outputText("tainted ", false);
		outputText("sexual energies deep into its gullet.  And that's just the start!</i>\"  Her hands let go of the squirming mass, dropping it squarely into your lap.\n\n", false);
		if(player.averageCockLength() < 15) outputText("With one swift motion, the beast engulfs your " + cockDescript(0) + " in its slimy maw.  ", false);
		else outputText("Distending obscenely, the beast starts engulfing your " + cockDescript(0) + " in its slimy maw, progressing along its entire length till you can no longer see your pleasure tool.  ", false);		
		outputText("The slimy tentacles waste no time, massaging you with mechanical precision.  You groan in helpless pleasure, growing to painful hardness within the squirming confines of the creature.  Three protrusions sprout from the creature's core, dripping with slime of their own, and covered on the inside with the same wriggling protrusions that now massage your trapped member.  Two curl around your " + hipDescript() + ", while the last one", false);
		if(player.balls > 0) outputText(" smothers your balls, entrapping them in sticky sensation as it continues across your taint between your butt-cheeks.  ", false);
		else outputText(" journeys over your taint before travelling between your butt-cheeks.  ", false);
		outputText("The three tendrils join together in the back, forming a seemless tiny purple triangle.  It really rides up high, tickling your " + assholeDescript() + " with constant teasing.  You're wearing an organic purple thong!\n\n", false);
		outputText("You try to endure, but the humiliation is too much for you to take.  The pleasure and shame push you past your limit.  You let out a squeal of mixed agony and delight as the proof of your pleasure boils out into the creature.  You pant and twitch, helpless to resist the strength of your orgasm as your jism fills the creature, distorting it visibly around your member.  Sighing, you relax as the assault winds down, the squirming tentacles relaxing noticeably as they work to digest their 'meal'.\n\n", false);
		outputText("\"<i>Enjoy yourself?  The best part is about to start,</i>\" she says with an evil glint in her eye.  You sit bolt upright as your living thong squirms and shifts, pressing something rigid against the ring of your " + assholeDescript() + ".  You reach down, trying to pull the creature off, but its outer covering is surprisingly hard, and seals almost perfectly against your " + player.skinDesc + ".  You look up with terror in your eyes, a pleading look painted across your face.\n\n", false);
		outputText("She cocks her head to the side with an inquisitive look and asks, \"<i>So it's found your back door I take it?</i>\"  You nod sheepishly, squealing as the rigid growth pushes through your sphincter, violating you completely.  She continues with a nonchalant tone, though her eyes seem to be drinking in the scene, \"<i>That thing you feel drilling into your ass?  It's a carefully evolved injection appendage.  Don't worry, once it settles in it won't move much.  It's just going to get nice and cozy with your prostate and a few major blood vessels.  And then it's going to reward you for cumming!</i>\"\n\n", false);
		outputText("You feel it burrow a little deeper, and then curve up.  It presses against something inside of you in a way that makes your " + cockDescript(0) + " twitch uncontrollably.  You're sure that if it weren't for the greedy tentacle-panties around your dick you would've seen a huge dollop of pre-cum squeeze out.  Filled with angst and worry as to what is to come, you ask, \"<i>Ummm, h-h-how is it going to reward me?</i>\"\n\n", false);
		outputText("She winks, petting the mottled surface of your purple-cock-prison as you feel a sensation of warm wetness in your backside.  At the same time you nearly jump as you feel a painful pinch in your prostate.  The demoness licks her lips and answers, \"<i>Well, it rewards you in two ways pet.  One:  It empties a specially designed cocktail of drugs directly into your bowels, where they'll be absorbed slowly into the body.</i>\"  As if on cue a gentle warmth spreads through your torso, radiating out into your limbs, and settling like calming mist in your head.  You relax utterly, enjoying the feeling in spite of your worries.\n\n", false);
		outputText("She coos, petting your still-hard member and the creature around it.  Miraculously you can feel both the touch of her silky fingers and the constant pleasurable squirming of the panties themselves.  You twitch your " + cockDescript(0) + " against her hand, giggling happily.\n\n", false);
		outputText("\"<i>That's right, it's a good reward isn't it?</i>\" she asks as she continues to fondle you, \"<i>those drugs are making you docile and extraordinarily suggestible.  For instance – every time I talk you can feel my hands caressing and fondling your member", false);
		if(player.balls > 0) outputText(" and teasing your balls", false);
		outputText(".  You see?  I'm not even touching you anymore and you're still twitching.  My my, what an obedient slave you're going to be.</i>\"\n\n", false);
		outputText("You pant and groan while she talks to you, still feeling the combined efforts of the panty-creature and your master's wonderful hands, \"<i>And I haven't even told you about the second part of your reward.  If you want me to tell you, you'll need to admit out loud what we both already know – that you're my obedient slave-toy.  Say it toy.</i>\"\n\n", false);
		outputText("\"<i>I-I-I'm your obedia—ahhh-nt s-s-lave toy,</i>\" you moan.  As soon as the words leave your mouth, you know it's true, but that settles in the back of your mind.  You're eager to know how the creature and your mistress will reward you for being such an obedient-toy.  And of course, to get her talking again so you can feel those smooth fingertips caress you once more.\n\n", false);
		outputText("\"<i>You really are my good toy already, aren't you?</i>\" she muses, \"<i>You just love pleasing, me don't you toy?</i>\"  You nod feverishly, eliciting a happy laugh from your mistress as she lectures you, \"<i>The second part of your reward is an injection of its venom directly into your prostate.  You may not have noticed with the constant teasing your cock is enduring, but by now your prostate should have doubled in size.  If I ever separate you and your training-suit, you'll notice you're producing so much pre-cum that it's dribbling out ALL the time.  Your orgasms won't get much bigger, but you'll find yourself pouring out pre as you get more and more turned on.  After all, my baby here needs to feed.</i>\"\n\n", false);
		outputText("Your mistress pats your obscene purple panties tenderly and whispers in your ear, \"<i>Be a good toy and cum for mistress.</i>\"  You smile broadly as your hips piston in the air, as if fucking an imaginary twat.  Cum boils out from your ", false);
		if(player.balls > 0) outputText(ballsDescriptLight() + " and ", false);
		outputText(" over-sized prostate, filling the chamber around your cock with thick blasts of seed.  You smile happily as the tentacle-chamber distorts to hold your load, bulging out into a more spherical appearance.  You slump down as your orgasm finishes and you begin to feel even more 'reward' fill your now greedy-hole.\n\n", false);
		if(player.hasStatusAffect("Camp Marble") >= 0) {
			outputText("Suddenly, a loud scream is heard down on the factory floor. You and your mistress turn to see Marble dashing up the stairs to the foremen's office.  Your mistress looks over at her and says with some amusement, \"<i>Oh ho!  So another cow has come to join in the fun.</i>\"\n\n\"<i>Sweetie! What has she done to you?</i>\" Marble exclaims, \"<i>What has she put on you?!</i>\"\n\n\"<i>Oh, so you knew this girl?</i>\" your mistress asks you, \"<i>It's a Lacta Bovine from the looks of it, so it seems this time I'll be adding a real cow to the pens.</i>\"  Marble turns to your mistress and brandishes her hammer, but the horror from the thought of your mistress being hurt causes you to spring forward and grab Marble.  The brief distraction gives your mistress a chance to sink a syringe into Marble's shoulder, and within moments she slumps onto the ground unconscious.\"\n\n", false);
			outputText("Your mistress turns back to you and smiles.\n\n\"<i>Well, she should make a fine replacement for you in the pens,</i>\" she says before tapping her chin thoughtfully and looking back at you, \"<i>Really is convenient that I don't have to worry about my new pet dying on me now, hun.</i>\"  Then she pushes you back into the chair and says \"<i>But first...</i>\"\n\n", false);
		}
		outputText("Your mistress pats your head and whispers commands in your ear while the now-sated slave-making creature devours your cum, turning it into more 'reward'.  You don't pay attention to her words, what's important is serving mistress and cumming for your panty-toy as often as possible.  You don't need to worry, she will tell you what to think.  She's just so perfect and amazing, you don't know why anyone would want to harm her or her wonderful creations.  'Gods it feels good to obey' is the last thought your mind ever thinks for itself.\n\n", false);
		outputText("In the days to come, you spend your time being teased by your new mistress until you feel as if you'll burst, then being brought to sudden explosive orgasms that fill your panty-prison to capacity.  After every session you black out, but each time you mind less and less.  You wanted to be here, having these wonderful orgasms and obeying your beautiful mistress.\n\n", false);
		outputText("After a month she starts letting you live without your favorite panties.  You beg her to put them back on you, but she often makes you crawl around the factory, pooling pre-cum everywhere from your swollen prick as you beg her to be put back into the pleasure-panties.  Sometimes, if you're lucky, she'll fuck you, or send you out to catch another adventurer.  There is nothing you love more than cumming into your tentacle-panties while another one of your mistress' creations teaches a slut how to embrace her true nature.", false);
		eventParser(5035);
		return;
	}
	//(Female) 
	if(player.vaginas.length == 1 || player.gender == 0) {
		outputText("In her hand is a seamless pair of panties.  Their surface reflects light perfectly, as if its bright pink surface were coated in slippery oil or made from latex.  ", false);
		if(player.gender == 0) {
			outputText("The demoness smiles with wicked intent and yanks the bottoms of your " + player.armorName + " the rest of the way off.  Your lack of genetalia does not faze her, and she responds by swiftly pulling out a needle and injecting your groin.  In seconds your crotch splits open, revealing a fresh virgin vagina.  Licking her perfect lips with anticipation, she inverts the panties and holds them up for you to see.\n\n", false);
			player.createVagina();
		}
		else outputText("The demoness smiles with wicked intent and yanks your " + player.armorName + "'s bottom the rest of the way off.  She leans close, smiling and inhaling the scent of your sex, savoring it like a aroma of a fine wine.  Licking her perfect lips with anticipation, she inverts the panties and holds them up for you to see.\n\n", false);
		outputText("They aren't panties at all, but instead some living creature.  The entire inside surface of the living garment is covered with fleshy pink nodules that wriggle constantly, practically dripping with a pungent lubricant that smells not unlike your own juices.  Horrifyingly, there is a large lump of flesh towards the front.  Its surface is ribbed and pulses, constantly swelling and shrinking.  It's clearly designed to enter the passage of anyone who wears it.  Worse yet is a smaller narrower protrusion on the backside.  This...creature...will certainly do its best to plug both your holes.\n\n", false);
		outputText("Your captor pulls it back and leans closer, letting the scent of her own fragrant puss fill the air.  It smells tangy and sweet and makes you ", false);
		if(player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_WET) outputText("wet ", false);
		else if(player.vaginas[0].vaginalWetness <= VAGINA_WETNESS_DROOLING) outputText("drip on the chair ", false);
		else outputText("soak the chair ", false);
		outputText("from the heady taste that clings to your nostrils.  She speaks with confidence, \"<i>You needn't worry my dear.  I call this little creature my slut-panties.  You see, when you wear them they will stimulate every part of you.  They'll suck on your clit while the two large mounds grow inside you, filling you with wriggling pleasure.  Their slime is a wonderful lubricant and a mild aphrodisiac.  Between the constant touches and its secretions, you'll be horny and on the edge of orgasm in no time.</i>\"\n\n", false);
		outputText("You shake your head in desperate denial and start to cry as you realize she intends to keep you locked in some kind of hellish pleasure-prison.  The panties slide up your legs with ease, and with a swift movement, the demon lifts your ass up and slips them into position with a wet 'SQUELCH'.  You moan as it goes to work, wrapping your " + clitDescript() + " in slippery tightness.  The two 'lumps' you observed elongate, the ridged surfaces making your " + vaginaDescript(0) + " quiver and dance with pleasure.  In mere seconds you're panting hotly and ready to cum.  Your crying devolves into heated moans of pleasure and longing.\n\n", false);
		outputText("Bright red eyes fill your vision as the beautiful visage comes closer.  She whispers hotly in your ear, \"<i>I bet it feels good doesn't it?  Do you feel wet and horny?  I bet you'd love to throw yourself on my cock and get off right now.</i>\"\n\n", false);
		outputText("You blink away the tears and nod frantically, you're so close!  But every time you feel an orgasm start to build the creature eases up just enough to keep you away from your orgasm.\n\n", false);
		outputText("\"<i>You see, these panties are attuned to our kind.  I've worked hard to breed a pair that could be taught to only provide release when a demon cums in or on them.  Fortunately for you, the nodules will actually open to allow a demon's dick in either passage.  And just for our succubi friends, they can grow a protrusion from the front, and transmit the sensations to you,</i>\" she says as she demonstrates by bringing her throbbing purplish prick close to your pink-enclosed groin.  The surface of the panties splits with a line down the front, reshaping to reveal your pink-covered camel-toe.\n\n", false);  
		outputText("She asks, \"<i>I won't be a rapist my dear.  This cock will only enter you if you desire the pleasure it can bring you.  You could say no and just enjoy being on the edge until your will finally crumbles.</i>\"\n\n", false);
		if(player.hasStatusAffect("Camp Marble") >= 0) {
			outputText("Suddenly, a loud scream is heard down on the factory floor. You and your mistress turn to see Marble dashing up the stairs to the foremen's office.  Your mistress looks over at her and says with some amusement, \"<i>Oh ho!  So another cow has come to join in the fun.</i>\"\n\n\"<i>Sweetie! What has she done to you?</i>\" Marble exclaims, \"<i>What has she put on you?!</i>\"\n\n\"<i>Oh, so you knew this girl?</i>\" your mistress asks you, \"<i>It's a Lacta Bovine from the looks of it, so it seems this time I'll be adding a real cow to the pens.</i>\"  Marble turns to your mistress and brandishes her hammer, but the horror from the thought of your mistress being hurt causes you to spring forward and grab Marble.  The brief distraction gives your mistress a chance to sink a syringe into Marble's shoulder, and within moments she slumps onto the ground unconscious.\"\n\n", false);
			outputText("Your mistress turns back to you and smiles.\n\n\"<i>Well, she should make a fine replacement for you in the pens,</i>\" she says before tapping her chin thoughtfully and looking back at you, \"<i>Really is convenient that I don't have to worry about my new pet dying on me now, hun.</i>\"  Then she pushes you back into the chair and says \"<i>But first, didn't you want something from me?</i>\"\n\n", false);
			
		}
		outputText("It takes less than a second for you to moan out, \"<i>Taaaaake meeeee!</i>\"\n\n", false);
		outputText("She smiles and lifts you up from the chair with her strong arms, and sits down on the desk.  She lowers your symbiote-covered lips onto her demon dick and coos with delight as you slide down her length, taking the entire thing in your greedy depths.  If anything, the creature inside you makes sex even better - you feel a combination of her nub-covered cock fucking you and the ridges of the panty-creature as it continues to stimulate you.  It drives you mad with pleasure, and you begin bouncing yourself up and down, spearing your " + vaginaDescript(0) + " with the demon's pole.\n\n", false);
		outputText("She giggles and reaches down.  Too aroused to care, you just keep fucking her and moaning in delight.  Her hands come up and begin to massage and rub your " + allBreastsDescript() + " taking special care to tweak and tug on your nipples.  They become as hard as ", false);
		if(player.nippleLength < .5) outputText("erasers ", false);
		else if(player.nippleLength < 3) outputText("bullets ", false);
		else outputText("tiny cocks ", false);
		outputText("in moments", false);
		if(player.biggestLactation() > 2) outputText(" and start to drip with milk", false);
		outputText(".  You sigh with disappointment when her hands drop away.  You were so close to orgasm.  She reaches back up and places something wet and warm on ", false);
		if(player.breastRows.length <= 1) outputText("your " + nippleDescript(0), false);
		if(player.breastRows.length > 1) outputText("your top " + nippleDescript(0), false);
		outputText(".  You look down and see two star-shaped creatures made of glistening pink (just like your panties!) attached to your " + nippleDescript(0) + "s.  They pulse and ripple as they constantly massage and suck.  ", false);
		if(player.biggestLactation() > 1) outputText("Your milk erupts, spraying out from a tiny hole in the center of the star.  In response the creature increases the force of its sucking action, making you fountain milk constantly.  ", false);
		if(player.breastRows.length > 1) outputText("While you continue to fuck that meat pole and watch the creatures squirming on your nipples, more are affixed to each of your remaining " + nippleDescript(0) + "s, until every single one is covered with its own tiny pleasure-creature.\n\n", false);
		outputText("A flood of hot demonic spunk unloads into your aching " + vaginaDescript(0) + ", filling you with warmth.  The panty-plug in your backside seems to erupt as well, dumping a flood of undiluted aphrodisiacs into your body.  You squeal and cum, your eyes rolling back with pleasure as you sink down on the quivering member of your captor.  You twitch and moan, orgasming for far longer than the dick inside of you.  The pleasure goes on for minute after minute.  Your " + nippleDescript(0) + "s each radiate satisfaction and pleasure as they manage to provide you with miniature orgasms of their own.  You moan, feeling relief at last and losing yourself in the wave of satisfaction that fills your body.\n\n", false);
		outputText("You blink a few times, and sit up, finding yourself back in the chair.  Your pink panty-creature has closed back up, trapping the demon's cum inside you.  The corrupted seed is so potent you can actually feel it tainting your body further as it spreads into your core.  You stretch languidly as you try to recover from the best orgasm of your life.  Perhaps you can escape?  No, you can't leave, the panties are already massaging your aching cunt and toying with your still-hard " + clitDescript() + ".  You squirm as it effects you, ramping your body's desires back up to the max.  Maybe if you take a load in the front AND back at the same time it'll sate the creature long enough for you to escape....\n\n", false);
		outputText("You set off into the factory, looking for the Omnibus and an Incubus to help.\n\n", false);
		outputText("<b>One month later:</b>\nYou lick the demonic jism from your lips and stretch, happy your mistress provided you with your fifth orgasm of the morning.  Normally she only lets her favorite slut get her off three or four times before lunch.  You squirm as your panties go to work, taking you back to that wonderful plateau of pleasure that only your masters and mistresses can bring you down from.  Thinking back, this really is the best way for things to end.  You thank your mistress and ask if you can see if any of the imps want to knock you up again.  She smiles condescendingly and nods, making your cunt squeeze with happiness.  Imps have such great cum!", false);
		eventParser(5035);
		return;
	}
}
//[Turn Demon]
public function demonBadEnd():void {
	outputText("", true);
	outputText("Advancing slowly, the succubus gives you a hungry look.  She extends a hand, allowing her fingers to lengthen into razor-sharp claws.  With a single expert slash, she cuts away everything holding together your " + player.armorName + ".  They fall into a discarded pile, already forgotten as your ", false);
	//[genderless]
	if(player.gender == 0) {
		outputText("entire body blushes read before the sexy seductress.  She looks at you, frowning as she murmers, \"<i>Now this just won't do.  You look more like a " + player.boyGirl() + " to me, so why don't I make the plumbing match the exterior?</i>\"\n\n", false);  
		outputText("Her palm caresses your crotch, stoking the warmth inside you till it blazes white-hot with new sensation.  Your skin ripples and parts, ", false);
		if(player.biggestTitSize() <= 1) {
			outputText("pushed apart the thick flesh of a powerful demonic member, complete with two swollen balls.", false);
			player.gender = 1;
			player.createCock();
			player.cocks[0].cockLength = 10;
			player.cocks[0].cockThickness = 2;
			player.cocks[0].cockType = CockTypesEnum.DEMON;
			player.balls = 2;
			player.ballSize = 3;
		}
		else {
			outputText("gushing with fluids as it shapes itself into a hungry demonic cunt.", false);  
			player.gender = 2;
			player.createVagina();
			player.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
		}
		outputText("\n\n\"<i>Much better,</i>\" the demon coos, licking her lips as your ", false);
	}
	//[male]
	if(player.gender == 1) {
		//Multispoooooo
		if(player.cockTotal() > 1) {
			outputText(multiCockDescriptLight() + " pulsate, straining for just a touch of the succubus' hand.  She paces around you, giggling and toying with you as your " + multiCockDescript() + " seem to follow her, twitching and thickening any time she takes a step closer.\n\n", false);
			outputText("She reaches out, cupping the underside of a shaft, slowly stroking your most sensitive places while she stops the bimbo-like voice and teases, \"<i>Awww so hard and ready.  It looks to me like you're already a slave to your desires.  You're twitching and dripping, just from the soft touches of your enemy's fingers.  Are you truly so in need of release as to willingly offer it to me?  No, don't answer, your " + cockDescript(0) + " already has.</i>\"\n\n", false);
			outputText("You glance down, seeing just how hard her words have made you.  You squirm your " + hipDescript() + "s pathetically, trying to hump her hand and increase the stimulation.  The succubus immediately releases you and draws back, shedding her secretary's clothes like a snake sheds its skin.  Now clad only in a tight leather corset and thigh-high stockings with garters, the succubus tosses you onto a table, surprising you with her raw strength.  Seemingly from nowhere, she produces a whip, winding it tightly around ", false);
			if(player.balls > 0) outputText("your " + ballsDescriptLight() + " and ", false);
			outputText("the bases of your " + multiCockDescriptLight() + ".\n\n", false);
			outputText("\"<i>There, that'll make sure you feel every part squeeze and caress of my velvet walls, and keep you from getting off until you're ready,</i>\" says the succubus as she climbs the table and straddles your eager form.\n\n", false);
			outputText("She lifts herself up with her shapely legs and spreads her thighs, proudly revealing her puffy pierced folds.  They drip with demonic nectar as she wiggles over you, spattering you with demon-honey.  Slowly, nearly imperceptibly, she swivels the lewd opening closer and closer, and your cocks, as if possessed, angle themselves upward towards the juicy target.  The grinning succubus looks over her shoulder and asks, \"<i>Ready are we? Ok, I won't keep you waiting.</i>\"\n\n", false);
			outputText("Marvelous heat and wetness sweeps over you in a fluid motion, wrapping your " + cockDescript(0) + " tightly.  You sigh happily, already lost in the feeling of having a succubus' tight walls wriggling around you.  Were you not already so corrupt, you would probably be coming already, but as it is, you can lie there and enjoy it, reveling in the sensations your unholy lover is spreading through your body.  You shiver, finally approaching your climax, but as it nears you find yourself denied by the whip binding your " + multiCockDescriptLight() + ".  It isn't just the physical tightness either – something else about it keeps your release buried deep, inaccessible.\n\n", false);
			outputText("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days…</i>\"\n\n", false);
			outputText("You moan pitifully, begging for her to remove it and allow you to cum.\n\n", false);
			outputText("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, I don't know, the focused remains of your soul and humanity.  Now you think on that while I melt away any doubts you might have.</i>\"\n\n", false);
			outputText("She resumes fucking you, driving you insane with need, all the while fiddling with her clit and pulling up a nipple to lick.  It feels so good, but you NEED to cum.  She fucks you like that for hours, till the table collapses under the pair of you and dumps you both on the floor. More than anything you crave release, and over time cave in further and further to the need.  In time, you can feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, this need for release.  The block shatters, melting away under the force of your need.\n\n", false);
			outputText("A look of shock and pleasure spreads over the succubus's face as you release into her hot snatch, cumming with a force unlike anything you've felt before.  Her walls squeeze and caress in time with your orgasm, milking you of every drop.  Your body clenches and squeezes, shuddering as the orgasm continues for far longer than normal.  Though you don't feel like you're pushing out as much fluid as normal, somehow it feels even better, like a slow drip of pleasure and release.  When at last your " + cockDescript(0) + " empties, you feel drained and strangely energized at the same time, and your entire torso is spattered with rapidly hardening pink crystals.\n\n", false);
			outputText("The slutty succubus stands up, her puffy vulva coating in a shining pink fluid.  Did that just come out of you?  She grunts, her eyes glowing for a moment as the pink goop disappears into her skin, vanishing entirely.\n\n", false);
			outputText("\"<i>Ahhhhh,</i>\" she sighs, \"<i>nothing like fresh Lethicite.  Mmmm, yours was potent!</i>\"\n\n", false);
			outputText("You stand up, dissatisfied at the sudden lack of sensation you're forced to endure.  The gloating demoness looks rather pleased with herself, and brimming with newfound power.  You resolve to ", false);
			if(player.hasStatusAffect("Marae's Lethicite") < 0) outputText("gather some yourself at the next opportunity…", false);
			else outputText("devour Marae's as soon as you get a chance.", false);
			outputText("You greedily gather up the lethicite splattered on your body and devour it, turning it into raw demonic power.  You really do need to get more of this...but first you know a certain demoness you intend to wrap around your ", false);
			if(player.demonCocks() > 0) outputText("growing", false);
			else outputText("new", false);
			outputText(" demon-cock for a few more orgasms.", false);
		}
		//SINGLEZ NITE
		else {
			outputText(multiCockDescriptLight() + " pulsates, straining for just a touch of the succubus' hand.  She paces around you, giggling and toying with you as your " + multiCockDescript() + " seems to follow her, twitching and thickening anytime she takes a step closer.\n\n", false);
			outputText("She reaches out, cupping the underside of the shaft, slowly stroking your most sensitive places while she stops the bimbo-like voice and teases, \"<i>Awww so hard and ready.  It looks to me like you're already a slave to your desires.  You're twitching and dripping, just from the soft touches of your enemy's fingers.  Are you truly so in need of release as to willingly offer it to me?  No, don't answer, your " + cockDescript(0) + " already has.</i>\"\n\n", false);
			outputText("You glance down, seeing just how hard her words have made you.  You squirm your " + hipDescript() + "s pathetically, trying to hump her hand and increase the stimulation.  The succubus immediately releases you and draws back, shedding her secretary's clothes like a shake sheds its skin.  Now clad only in a tight leather corset and thigh-high stockings with garters, the succubus tosses you onto a table, surprising you with her raw strength.  Seemingly from nowhere, she produces a whip, winding it tightly around ", false);
			if(player.balls > 0) outputText("your " + ballsDescriptLight() + " and ", false);
			outputText("the base of your " + cockDescript(0) + ".\n\n", false);
			outputText("\"<i>There, that'll make sure you feel every part squeeze and caress of my velvet walls, and keep you from getting off until you're ready,</i>\" says the succubus as she climbs the table and straddles your eager form.\n\n", false);
			outputText("She lifts herself up with her shapely legs and spreads her thighs, proudly revealing her puffy pierced folds.  They drip with demonic nectar as she wiggles over you, spattering you with demon-honey.  Slowly, nearly imperceptibly, she swivels the lewd opening closer and closer, and your cock, as if possessed, angles itself upwards towards the juicy target.  The grinning succubus looks over her shoulder and asks, \"<i>Ready are we? Ok, I won't keep you waiting.</i>\"\n\n", false);
			outputText("Marvelous heat and wetness sweeps over you in a fluid motion, wrapping your " + cockDescript(0) + " tightly.  You sigh happily, already lost in the feeling of having a succubus' tight walls wriggling around you.  Were you not already so corrupt, you would probably be coming already, but as it is, you can lie there and enjoy it, reveling in the sensations your unholy lover is spreading through your body.  You shiver, finally approaching your climax, but as it nears you find yourself denied by the whip binding your " + cockDescript(0) + ".  It isn't just the physical tightness either – something else about it keeps your release buried deep, inaccessible.\n\n", false);
			outputText("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days…</i>\"\n\n", false);
			outputText("You moan pitifully, begging for her to remove it and allow you to cum.\n\n", false);
			outputText("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, I don't know, the focused remains of your soul and humanity.  Now you think on that while I melt away any doubts you might have.</i>\"\n\n", false);
			outputText("She resumes fucking you, driving you insane with need, all the while fiddling with her clit and pulling up a nipple to lick.  It feels so good, but you NEED to cum.  She fucks you like that for hours, till the table collapses under the pair of you and dumps you both on the floor. More than anything you crave release, and over time cave in further and further to the need.  In time, you can feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, this need for release.  The block shatters, melting away under the force of your need.\n\n", false);
			outputText("A look of shock and pleasure spreads over the succubus's face as you release into her hot snatch, cumming with a force unlike anything you've felt before.  Her walls squeeze and caress in time with your orgasm, milking you of every drop.  Your body clenches and squeezes, shuddering as the orgasm continues for far longer than normal.  Though you don't feel like you're pushing out as much fluid as normal, somehow it feels even better, like a slow drip of pleasure and release.  When at last your " + cockDescript(0) + " empties, you feel drained and strangely energized at the same time.\n\n", false);
			outputText("The slutty succubus stands up, her puffy vulva coating in a shining pink fluid.  Did that just come out of you?  She grunts, her eyes glowing for a moment as the pink goop disappears into her skin, vanishing entirely.\n\n", false);
			outputText("\"<i>Ahhhhh,</i>\" she sighs, \"<i>nothing like fresh Lethicite.  Mmmm your's was potent!</i>\"\n\n", false);
			outputText("You stand up, dissatisfied at the sudden lack of sensation you're forced to endure.  The gloating demoness looks rather pleased with herself, and brimming with newfound power.  You resolve to ", false);
			if(player.hasStatusAffect("Marae's Lethicite") < 0) outputText("gather some yourself at the next opportunity…", false);
			else outputText("devour Marae's as soon as you get a chance.", false);
			outputText("  But first you know a certain demoness you intend to wrap around your ", false);
			if(player.demonCocks() > 0) outputText("growing", false);
			else outputText("new", false);
			outputText(" demon-cock for a few more orgasms.", false);
		}
	}
	//[female]
	else if(player.gender == 2) {
		outputText(vaginaDescript(0) + " grows wet and ready, practically juicing itself as the demoness' hand caresses your inner thigh.  She teases, \"<i>Oh my! You're so wet and ready and I haven't even touched your moist little cum-receptacle.  You're a slut aren't you?  Who else would be so turned on by the idea of cumming until all your humanity drips out?</i>\"\n\n", false);
		outputText("The words make you blush hard, shaming you and stoking the growing fire between your " + player.legs() + ".  You know two things for certain: she's right and you're more turned on that ever.  You don't resist as the demoness easily lifts you up, setting you down on a table with your " + player.legs() + " spread.  \"<i>There,</i>\" she comments, \"<i>now your juicy snatch is on display, just like you've always wanted.</i>\"\n\n", false);
		outputText("She effortlessly swings her lissom legs onto the table as she pulls herself up, mounting you as a man might.  You can feel waves of heat rolling off her sex, bathing your own slit in her warmth.  ", false);
		if(player.clitLength >= 2) outputText("Your " + clitDescript() + " pushes free, nuzzling against her hairless cunt and slipping inside, as if drawn in by its desire.  She openly moans, and begins rocking on top of you.  You gasp in delight as she rides your " + clitDescript() + ", fucking and grinding against it.  ", false);
		else outputText("She lowers herself down, rubbing smooth hairless netherlips over you, smearing you with her fragrant demon-honey.  You feel her clit grinding on your own, drawing out gasps of delight from both of your mouths as she relentlessly scissors against you.  ", false);
		outputText("In no time flat you feel your climax building.  Your " + vaginaDescript(0) + " quivers and grows wetter in anticipation.  Tugging on your aching " + nippleDescript(0) + "s and aching for release, you squirm under your demonic mistress, smashing your " + vaginaDescript(0) + " against her in a lewd attempt to find your orgasm.  It does not happen, and you moan in disappointment as the pleasure continues to build, oblivious to your desire for orgasm.\n\n", false);
		outputText("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days…</i>\"\n\n", false);
		outputText("You moan pitifully, begging for her to remove it and allow you to cum.\n\n", false);
		outputText("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, oh I don't know, the focused remains of your soul and humanity.  Now you think on that while I grind away any remaining doubts you might have.</i>\"\n\n", false);
		outputText("The beautiful succubus on top of you picks up the pace, grinding harder against your " + vaginaDescript(0) + " and " + clitDescript() + ", pushing you beyond anything you've ever felt before.  She leans down over you, licking her lips to reveal an inhumanly long tongue.  It snakes down, curving around you " + allBreastsDescript() + " before it arches up to flick a " + nippleDescript(0) + ".  ", false);
		if(player.hasFuckableNipples() && player.biggestTitSize() > 2) outputText("You gasp as the tongue slides inside each of your breasts, violating them in turn thanks to your strange anatomy.\n\n", false);
		else outputText("You gasp as it curls around each of your " + nippleDescript(0) + "s in turn, tugging them lewdly.\n\n", false);  
	 	outputText("She fucks you like that for hours, till the table collapses under the pair of you and dumps you both on the floor. More than anything you find yourself craving release, and over time cave in further and further to the need.  You start to feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, and this need for release.  The block shatters, melting away under the force of your need as you explosively orgasm.\n\n", false); 
		outputText("Sparkling pink fluid splatters between the two of you as you cum, squirting hard", false);
		if(player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLAVERING) outputText(" for the first time", false);
		outputText(".  The succubus throws back her head and lets loose a moan of ecstasy, her entire body shivering with your own as both of your heads fill with fireworks of pleasure.  Nervelessly, she rolls off of you, her tail contracting hard around your leg while the two of you share the moment.\n\n", false);
		outputText("The succubus interrupts your delight by recovering far faster than you, rolling up to a standing position and watching something between your legs.  You prop yourself up on your elbows to see what the fuss is about.  Between your legs something curious is happening – a trickle of pinkish fluid is still escaping your nethers, rolling towards a rapidly expanding pool, along with every other drop of the pink goop.  Before your very eyes the pool grows until every drop of pink fluid has collected together, and it grows upwards, solidifying into a sparkling crystalline shape.\n\n", false);
		outputText("Before you can react, she grasps the newly-formed lethicite and noisily begins eating it, her eyes glowing with newfound power.  Watching her makes you more than a little jealous and angry with yourself.  You should've taken the lethicite and gained its power!  No use fretting about it, you can still fuck this succubus for a few hours before you go out in search of your own victims...\n\n", false);
	}
	//[HERM ENDING]
	else {
		//Buh.  Zombie fen need brains.
		outputText(multiCockDescript() + " and " + vaginaDescript(0) + " grow wet and ready, both starting to leak fluids as the succubus' hand traces your inner thigh.  She teases, \"<i>Oh my! You're so wet and ready and I haven't even touched your moist little cum-receptacle.  And that throbbing cock!  How obscene!  You're a slut aren't you?  Who else would be so turned on by the idea of cumming until your humanity is splattered between my legs?</i>\"\n\n", false);
		outputText("The words make you blush hard, shaming you and stoking the growing fire between your legs.  You know two things for certain: she's right and you're more turned on that ever.  You don't resist as the demoness easily lifts you up, setting you down on a table with your legs spread.  \"<i>There,</i>\" she comments, \"<i>now all of your fun-parts are on display.  Maybe I should call in an incubus and a few imps to watch.  I bet you'd like that wouldn't you?</i>\"\n\n", false);
		outputText("She effortlessly swings her lissom legs onto the table as she pulls herself up, mounting you in a single swift motion.  You can feel waves of heat rolling off her sex, bathing your " + cockDescript(0) + " in her warmth.  ", false);
		if(player.clitLength >= 2) outputText("Your " + clitDescript() + " pushes free, nuzzling against her tight asshole and slipping inside, as if drawn in by its desire.  She openly moans, and begins rocking on top of you.  You gasp in delight as she rides your " + clitDescript() + ", fucking her ass and grinding against it.", false);
		else outputText("She lowers herself down, rubbing smooth hairless netherlips over your crotch and vulva, smearing you with her fragrant demon-honey.  You feel her clit grinding on your belly, drawing out gasps of delight from both of your mouths as she relentlessly works her body against your own.", false);
		outputText("\n\nMarvelous heat and wetness wraps your " + cockDescript(0) + " tightly.  You sigh happily, already lost in the feeling of having a succubus' tight walls wriggling around you.  Were you not already so corrupt, you would probably be cumming already, but as it is, you can lie there and enjoy it, reveling in the sensations your unholy lover is spreading through your body.  You shiver, finally approaching your climax, but as it nears you find yourself denied by something deep inside you, pushing away your release and hiding it somewhere inaccessible.\n\n", false);
		outputText("\"<i>Have you hit it yet?</i>\" the succubus asks as she rocks on top of you, \"<i>I've placed a block inside you.  Don't worry, it's temporary, it'll only stop you from orgasming for a few days…</i>\"\n\n", false);
		outputText("You moan pitifully, begging for her to remove it and allow you to cum.\n\n", false);
		outputText("\"<i>Oh I can't remove it,</i>\" she says, \"<i>The only way you'll be rid of it with any sort of certainty is to melt through it with something stronger.  Something, like, I don't know, the focused remains of your soul and humanity.  Now you think on that while I melt away any doubts you might have.</i>\"\n\n", false);
		outputText("She resumes fucking you, driving you insane with need, all the while fiddling with her clit and pulling up a nipple to lick.  It feels so good, but you NEED to cum.  She fucks you like that for hours, till the table collapses under the pair of you and dumps you both on the floor. More than anything you crave release, and over time cave in further and further to the need.  Eventually, you can feel the block weakening, melting, and eroding.  Your life has been distilled down into this one moment, this one desire, this need for release.  The block shatters, melting away under the force of your need.\n\n", false);
		outputText("A look of shock and pleasure spreads over the succubus' face as you release into her hot snatch, cumming with a force unlike anything you've felt before.  Her walls squeeze and caress in time with your orgasm, milking you of every drop.  Your body clenches and squeezes, shuddering as the orgasm continues for far longer than normal.  Though you don't feel like you're pushing out as much fluid as normal, somehow it feels even better, like a slow drip of pleasure and release.  When at last your " + cockDescript(0) + " empties, you feel drained and strangely energized at the same time.\n\n", false);
		outputText("The slutty succubus stands up, her puffy vulva coating in a shining pink fluid.  Did that just come out of you?  She grunts, her eyes glowing for a moment as the pink goop disappears into her skin, vanishing entirely.\n\n", false);
		outputText("\"<i>Ahhhhh,</i>\" she sighs, \"<i>nothing like fresh Lethicite.  Mmmm your's was soooo potent!</i>\"\n\n", false);
		outputText("You stand up, dissatisfied at the sudden lack of sensation you're forced to endure.  The gloating demoness looks rather pleased with herself, and brimming with her new-found power.  You resolve to ", false);
		if(player.hasStatusAffect("Marae's Lethicite") < 0) outputText("gather some yourself at the next opportunity…", false);
		else outputText("devour Marae's as soon as you get a chance.", false);
		outputText("  But first you know a certain demoness you intend to wrap around your ", false);
		if(player.demonCocks() > 0) outputText("growing", false);
		else outputText("new", false);
		outputText(" demon-cock for a few more orgasms.", false);
		outputText("  Before you get into that, you spy a small piece of pink crystal on the floor between your legs.  You snatch it and devour it before the succubus has a chance and eat it, turning part of your soul into new-found demonic strength before you return to a long night of sex...", false);
	}
	dynStats("str", 2,"tou", 2, "spe", 2, "int", 2, "lib", 2, "sen", 2, "lus=", 0, "cor", 100);
	doNext(demonBadEnd2);
}
//epilogues
public function demonBadEnd2():void {
	outputText("", true);
	if(player.gender == 1) outputText("As a demon, you rapidly moved up the ranks, eventually taking command of the factory and its inhabitants.  The previous commander was reduced to a willing cock-sleeve, ever-eager to obey your slightest order.  By the time the next year has come around, you've managed to earn the coveted honor of collecting the next champion.", false);
	else if(player.gender == 2) outputText("Now a full-fledged demon, you leave the factory, setting off on your own.  Over the next year you capture many foolish mortals, and even convince more than a few of them to give up their souls.  With your rapid gain in power, it's easy to rise in the demonic ranks, and in no time flat your power far exceeds that of the succubus that 'turned' you.  You live in luxury, surrounded by a harem of slaves, waiting in your camp for the next victim to step through...", false);
	else outputText("As a demon, you rapidly moved up the ranks, eventually taking command of the factory and its inhabitants.  The previous commander was reduced to a willing cock-sleeve, ever-eager to obey your slightest order.  By the time the next year has come around, you've managed to earn the coveted honor of collecting the next champion. It should be quite satisfying...", false);
	eventParser(5035);
}