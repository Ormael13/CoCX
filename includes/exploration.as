//const MET_OTTERGIRL:int = 777;
//const HAS_SEEN_MINO_AND_COWGIRL:int = 892;
//const EXPLORATION_PAGE:int = 1015;
//const BOG_EXPLORED:int = 1016;
function doExplore():void {
	//vars for menu building
	var forest:Number = 0;
	var lake:Number = 0;
	var swamp:Number = 0;
	var mountain:Number = 0;
	var desert:Number = 0;
	var deepwoods:Number = 0;
	var plains:Number = 0;
	if(flags[UNKNOWN_FLAG_NUMBER_00272] > 0) swamp = 111;
	if(player.hasStatusAffect("exploredDeepwoods") >= 0) deepwoods = 80
	if(player.exploredMountain > 0) mountain = 6;
	if(player.exploredForest > 0) forest = 4;
	
	if(player.exploredLake > 0) lake = 5;
	if(player.exploredDesert > 0) desert = 3;
	if(flags[UNKNOWN_FLAG_NUMBER_00131] > 0) plains = 97;
	if(player.explored == 0) {
		outputText("You tentatively step away from your campsite, alert and scanning the ground and sky for danger.  You walk for the better part of an hour, marking the rocks you pass for a return trip to your camp.  It worries you that the portal has an opening on this side, and it was totally unguarded...\n\n...Wait a second, why is your campsite in front of you? The portal's glow is clearly visible from inside the tall rock formation.   Looking carefully you see your footprints leaving the opposite side of your camp, then disappearing.  You look back the way you came and see your markings vanish before your eyes.  The implications boggle your mind as you do your best to mull over them.  Distance, direction, and geography seem to have little meaning here, yet your campsite remains exactly as you left it.  A few things click into place as you realize you found your way back just as you were mentally picturing the portal!  Perhaps memory influences travel here, just like time, distance, and speed would in the real world!\n\nThis won't help at all with finding new places, but at least you can get back to camp quickly.  You are determined to stay focused the next time you explore and learn how to traverse this gods-forsaken realm.", true);
		tryDiscover();
		return;
	}
	if(player.explored == 1) {
		outputText("You walk for quite some time, roaming the hard-packed and pink-tinged earth of the demon-realm.  Rust-red rocks speckle the wasteland, as barren and lifeless as anywhere else you've been.  A cool breeze suddenly brushes against your face, as if gracing you with its presence.  You turn towards it and are confronted by the lush foliage of a very old looking forest.  You smile as the plants look fairly familiar and non-threatening.  Unbidden, you remember your decision to test the properties of this place, and think of your campsite as you walk forward.  Reality seems to shift and blur, making you dizzy, but after a few minutes you're back, and sure you'll be able to return to the forest with similar speed.\n\n<b>You have discovered the Forest!</b>", true);
		tryDiscover();
		player.exploredForest++;
		return;
	}
	if(player.explored > 1) outputText("You can continue to search for new locations, or explore your previously discovered locations.", true);
	
	if(flags[EXPLORATION_PAGE] == 2) {
		explorePageII();
		return;
	}
	menu();
	addButton(0,"Explore",eventParser,12);
	if(desert > 0) addButton(1,"Desert",eventParser,desert);
	if(forest > 0) addButton(2,"Forest",eventParser,forest);
	if(lake > 0) addButton(3,"Lake",eventParser,lake);
	addButton(4,"Next",explorePageII);
	if(plains > 0) addButton(5,"Plains",eventParser,plains);
	if(swamp > 0) addButton(6,"Swamp",eventParser,swamp);
	if(deepwoods > 0) addButton(7,"Deepwoods",eventParser,deepwoods);
	if(mountain > 0) addButton(8,"Mountain",eventParser,mountain);
	addButton(9,"Back",eventParser,1);
	//choices("Explore", 12, "Desert", desert, "Forest", forest, "Lake", lake, "Mountain", mountain, "Plains", plains, "Swamp", swamp, "Deepwoods", deepwoods, "H. Mountain", highMountain, "Back", 1);
}
function explorePageII():void {
	flags[EXPLORATION_PAGE] = 2;
	var highMountain:Number = 0;
	if(flags[UNKNOWN_FLAG_NUMBER_00088] > 0) highMountain = 95;
	menu();
	if(highMountain > 0) addButton(0,"High Mountain",eventParser,highMountain);
	if(flags[BOG_EXPLORED] > 0) addButton(1,"Bog",exploreBog);
	addButton(4,"Previous",goBackToPageI);
	addButton(9,"Back",eventParser,1);
}
function goBackToPageI():void {
	flags[EXPLORATION_PAGE] = 1;
	doExplore();
}


//Try to find a new location - called from doExplore once the first location is found
function tryDiscover():void {
	if(flags[PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !followerHel()) {
		helSexualAmbush();
		return;
	}
	if(player.explored > 1) {
		if(player.exploredLake == 0) {
			outputText("Your wanderings take you far and wide across the barren wasteland that surrounds the portal, until the smell of humidity and fresh water alerts you to the nearby lake.  With a few quick strides you find a lake so massive the distant shore cannot be seen.  Grass and a few sparse trees grow all around it.\n\n<b>You have discovered the Lake!</b>", true);
			player.exploredLake = 1;
			player.explored++;
			doNext(13);
			return;
		}
		if(player.exploredLake >= 1 && rand(3) == 0 && player.exploredDesert == 0) {
			outputText("You stumble as the ground shifts a bit underneath you.  Groaning in frustration, you straighten up and discover the rough feeling of sand ", true);
			if(player.lowerBody == 0) outputText("inside your footwear, between your toes", false);
			if(player.lowerBody == 1) outputText("in your hooves", false);
			if(player.lowerBody == 2) outputText("in your paws", false);
			if(player.lowerBody == 3) outputText("in your scales", false);
			outputText(".\n\n<b>You've discovered the Desert!</b>", false);
			player.exploredDesert = 1;
			player.explored++;
			doNext(13);
			return;
		}
		if(player.exploredDesert >= 1 && rand(3) == 0 && player.exploredMountain == 0) {
			outputText("Thunder booms overhead, shaking you out of your thoughts.  High above, dark clouds encircle a distant mountain peak.  You get an ominous feeling in your gut as you gaze up at it.\n\n<b>You have discovered the mountain!</b>", true);
			player.explored++;
			player.exploredMountain = 1;
			doNext(13);
			return;
		}
		if(player.exploredMountain >= 1 && rand(3) == 0 && flags[UNKNOWN_FLAG_NUMBER_00131] == 0) {
			flags[UNKNOWN_FLAG_NUMBER_00131] = 1;
			player.explored++;
			outputText("You find yourself standing in knee-high grass, surrounded by flat plains on all sides.  Though the mountain, forest, and lake are all visible from here, they seem quite distant.\n\n<b>You've discovered the plains!</b>", true);
			doNext(13);
			return;
		}
		//EXPLOOOOOOORE
		if(flags[UNKNOWN_FLAG_NUMBER_00272] == 0 && flags[UNKNOWN_FLAG_NUMBER_00131] > 0 && rand(3) == 0) {
			flags[UNKNOWN_FLAG_NUMBER_00272] = 1;
			player.explored++;
			outputText("", true);
			outputText("All things considered, you decide you wouldn't mind a change of scenery.  Gathering up your belongings, you begin a journey into the wasteland.  The journey begins in high spirits, and you whistle a little traveling tune to pass the time.  After an hour of wandering, however, your wanderlust begins to whittle away.  Another half-hour ticks by.  Fed up with the fruitless exploration, you're nearly about to head back to camp when a faint light flits across your vision.  Startled, you whirl about to take in three luminous will-o'-the-wisps, swirling around each other whimsically.  As you watch, the three ghostly lights begin to move off, and though the thought of a trap crosses your mind, you decide to follow.\n\n", false);
			outputText("Before long, you start to detect traces of change in the environment.  The most immediate difference is the increasingly sweltering heat.  A few minutes pass, then the will-o'-the-wisps plunge into the boundaries of a dark, murky, stagnant swamp; after a steadying breath you follow them into the bog.  Once within, however, the gaseous balls float off in different directions, causing you to lose track of them.  You sigh resignedly and retrace your steps, satisfied with your discovery.  Further exploration can wait.  For now, your camp is waiting.\n\n", false);
			outputText("<b>You've discovered the swamp!</b>", false);
			doNext(14);
			return;
		}
		//Used for chosing 'repeat' encounters.
		var choosey:Number = rand(6);
		//Chance of encountering Giacomo!
		if(choosey == 0) {
			player.explored++;
			eventParser(2015);
			return;
		}
		else if(choosey == 1) {
			player.explored++;
			lumiEncounter();
			return;
		}
		else if(choosey == 2 || debug) {
			player.explored++;
			if(flags[GAR_NAME] == 0) gargoylesTheShowNowOnWBNetwork();
			else returnToCathedral();
			return;
		}
		//Monster - 50/50 imp/gob split.
		else {
			player.explored++;
			var impGob:Number = 5;
			//Imptacular Encounter
			if(rand(10) < impGob) {
				if(player.level >= 8 && rand(2) == 0) {
					impLordEncounter();
					spriteSelect(29);
					return;
				}
				else {
					outputText("An imp wings out of the sky and attacks!", true);
					startCombat(1);
					spriteSelect(29);
				}
				return;
			}
			//Encounter Gobbalin!
			else {
				if(player.gender > 0) {
					outputText("A goblin saunters out of the bushes with a dangerous glint in her eyes.\n\nShe says, \"<i>Time to get fucked, " + player.mf("stud","slut"), true);
					outputText(".</i>\"", false);
					startCombat(15);
					spriteSelect(24);
					return;
				}
				else {
					outputText("A goblin saunters out of the bushes with a dangerous glint in her eyes.\n\nShe says, \"<i>Time to get fuc-oh shit, you don't even have anything to play with!  This is for wasting my time!", true);
					outputText("</i>\"", false);
					startCombat(15);
					spriteSelect(24);
					return;
				}
			}

		}
		outputText("You wander around, fruitlessly searching for new places.", true);
	}
	player.explored++;
	doNext(13);
}
function exploreDeepwoods():void {
	player.addStatusValue("exploredDeepwoods",1,1);
	var chooser:Number = rand(5);
	var temp2:Number = 0;
	//Every tenth exploration finds a pumpkin if eligible!
	if(player.statusAffectv1("exploredDeepwoods")% 10 == 0 && isHalloween()) {
		//If Fera isn't free yet...
		if(player.hasPerk("Fera's Boon - Breeding Bitch") < 0 && player.hasPerk("Fera's Boon - Alpha") < 0) {
			if(date.fullYear > flags[PUMPKIN_FUCK_YEAR_DONE]) {
		pumpkinFuckEncounter();
		return;
	}
		}
		//Fera is free!
		else {
			if(flags[FERAS_TRAP_SPRUNG_YEAR] == 0) {
				if(date.fullYear > flags[FERAS_GLADE_EXPLORED_YEAR]) {
					feraSceneTwoIntroduction();
					return;
				}
			}
		}
	}
	//Hel jumps you for sex.
	if(flags[PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !followerHel()) {
		helSexualAmbush();
		return;
	}
	//Every 5th exploration encounters d2 if hasnt been met yet and factory done
	if(flags[UNKNOWN_FLAG_NUMBER_00113] == 0 && player.statusAffectv1("exploredDeepwoods") % 5 == 0 && player.hasStatusAffect("DungeonShutDown") >= 0) {
		outputText("While you explore the deepwoods, you do your best to forge into new, unexplored locations.  While you're pushing away vegetation and slapping at plant-life, you spot a half-overgrown orifice buried in the side of a ravine.  There's a large number of imp-tracks around the cavern's darkened entryway.  Perhaps this is where the imp, Zetaz, makes his lair?  In any event, it's past time you checked back on the portal.  You make a mental note of the cave's location so that you can return when you're ready.", true);
		outputText("\n\n<b>You've discovered the location of Zetaz's lair!</b>", false);
		simpleChoices("Enter",11076,"",0,"",0,"",0,"Leave",13);
		flags[UNKNOWN_FLAG_NUMBER_00113]++;
		return;
	}
	//Tamani 20% encounter rate
	if(flags[TAMANI_TIME_OUT] == 0 && rand(5) == 0 && player.gender > 0 && (player.totalCocks() > 0 || player.hasKeyItem("Deluxe Dildo") < 0)) {
		if(player.totalCocks() > 0 && flags[UNKNOWN_FLAG_NUMBER_00057] == 0 && int(player.statusAffectv2("Tamani")/2) >= 12) {
			encounterTamanisDaughters();
		}
		else
			encounterTamani();
		return;		
	}
	//Faerie
	if(chooser == 0) {
		encounterFaerie();
		return;
	}
	//Tentacle monster
	if(chooser == 1) {
		//Reset hilarious shit
		if(player.gender > 0) flags[UNKNOWN_FLAG_NUMBER_00247] = 0;
		//Tentacle avoidance chance due to dangerous plants
		if(player.hasKeyItem("Dangerous Plants") >= 0 && player.inte/2 > rand(50)) {
			temp == rand(3) + 1;
			trace("TENTACLE'S AVOIDED DUE TO BOOK!");
			outputText("Using the knowledge contained in your 'Dangerous Plants' book, you determine a tentacle beast's lair is nearby, do you continue?  If not you could return to camp.\n\n", true);
			simpleChoices("Continue",2009,"",0,"",0,"",0,"Leave", 13);
			return;
		}
		else {
			eventParser(2009);
			return;
		}
	}
	//Corrupted Glade
	if(chooser == 2) {
		if(rand(4) == 0) {
			trappedSatyr();
			return;
		}
		outputText("Walking through the woods, you find a damp patch overgrown with corrupted plant-life.  Every flower seems warped into a colorful imitation of female genitals, each vine appears throbbing and veiny, and every knot on the nearby trees is capped with a nipple-like protrusion, leaking dark sap.", true);
		//disgusted reaction
		if(player.cor <= 33) {
			//Get plant-cum dripped on you if not fast and unlucky!
			if(player.spe < 60 && rand(player.spe + 50) < 50) {
				outputText("  Disgusted by this perversion of nature, you turn to leave, catching a faceful of the white goop that's spurting down from the vines above!  It's slimy, gross, and difficult to clear from your eyes, nose, and mouth.  The musky smell and delicious salty flavor are undoubtedly a result of the plant's corruption.  You escape the tainted glade, but feel warmer and warmer as time passes...", false);
				stats(0,0,0,0,0,0,20 + player.lib/5,0);
			}
			else {
				outputText("  Disgusted by this perversion of nature, you turn away to leave, narrowly avoiding a sudden dripping of thick white fluid from the vines overhead.", false);
				stats(0,0,0,0,0,0,2,0);
			}
			doNext(13);
			return;
		}
		//intrigued reaction
		if(player.cor > 33 && player.cor <= 66) {
			outputText("  You explore the glade with equal parts caution and curiosity.  ", false);
			temp2 = rand(3);
			//flowers...
			if(temp2 == 0) {
				outputText("A group of perverted looking flowers catch your eye, and leading you to bend closer for a better look at the intricately folded petals, noting the beads of slick moisture that seems to perspire from inside the plant.  Awed by the corrupt yet beautiful flower, you take a deep breath, inhaling a lungful of it's pungent yet sweet scents.  It matches the flower somehow, lingering in your nose even after you pull away.  The smell makes you wonder just how functional the pussy flowers are, as they do have fairly large stalks.\n\nYou sigh and take one last sniff from the flower's honeypot before moving on.  Your body flushes happily with desire as your blood pools in your groin.  You giggle, wishing you could feel like this more often.", false);
				stats(0,0,0,0,0,0,20 + player.lib/5,.5);
			}
			//vines...
			if(temp2 == 1) {
				outputText("A few vines dangling from the trees catch your eye due to their rather 'unique' tips.  Every single one of them ends in a flared mushroom-like head, each twice as wide as the already thick vine.  You touch a vine gently, musing at its slippery texture and how similar it would be to a penis if the 'head' were smaller.  You encircle the vine with your hand, stroking it and giggling at the absurdity of this place.  The vine suddenly flexes in your grasp, pulsating and contracting as its head grows bigger, turning shiny and red.  Pulling away in shock, you gasp as the vine begins spurting out huge ropes of thick viscous fluid, splattering everywhere.  The plant-gasm ends as suddenly as it started, the 'head' retaining the size it gained and dripping the last of its strange load.  Overcome with curiosity, you sniff at the dripping spunk and swoon at the overpoweringly musky scent.  Gathering your wits, you decide to leave before you end up with one of those inside you.  You escape the corrupted glade, but stay flush with arousal.", false);
				stats(0,0,0,0,0,0,20 + player.lib/5,.5);
			}
			//trees...
			if(temp2 == 2) {
				outputText("A cluster of huge breast-like knots on a nearby tree draws your attention.  Unable to resist, you poke one, and burst into giggles as it jiggles like a real breast!  You cautiously begin groping the tree-tit, and smile as it begins leaking sweet-smelling sap.  The scent conjures memories of helping to make maple syrup back home, and before you realize it, you've gathered a drop of the sap on your finger and tasted it.  It's powerfully sweet, making your tongue tingle and heart beat faster.  Unbidden, the thought of suckling the teat dry of its sweet treat comes to mind, but you manage to reject it and stumble away from the corrupted glade.  You have trouble with your tongue for the next hour: it won't stay in your mouth, and keeps licking your lips, seeking any leftover sweetness.  It almost distracts you from the palpable heat gathering between your thighs.", false);
				stats(0,0,0,0,0,0,20 + player.lib/5,.5);
			}
			doNext(13);
			return;
		}
		//drink sap/lick flower reaction
		if(player.cor > 66 && player.cor <= 100) {
			outputText("  You smile as you enter the glade, wondering which of the forbidden fruits you should try...\n\nThere are flowers that bear more than a passing resemblance to pussies,\nvines with absurdly large penis-like tips,\nand trees covered in breast-like knots, leaking sap.", false);
			simpleChoices("Flowers", 2012, "Vines", 2013, "Trees", 2084, "", 0, "Leave", 13);
			return;
		}
		//Wallow in decadence reaction - UNFINISHED
	}
	if(chooser == 3) {
		supahAkabalEdition();
		return;
	}
	else if(chooser == 4) {
		if(rand(3) == 0) kitsuneShrine();
		else enterTheTrickster();
		return;
	}
}


//Explore forest
function exploreForest():void {
	player.exploredForest++;
	
	trace("FOREST EVENT CALLED");
	var chooser:Number = rand(4);
	var temp2:Number = 0;
	//Cut bee encounter rate 50%
	if(chooser == 3 && rand(2)) chooser = rand(3);
	//Quick changes:
	//If monk is fully corrupted, encounter him less (unless haz ferriiite).
	if(chooser == 1 && monk >= 2) {
		temp = rand(4);
		if(temp == 0) chooser = 0;
		if(temp == 1) chooser = 2;
		if(temp == 2) chooser = 3;
	}
	//Helia monogamy fucks
	if(flags[PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !followerHel()) {
		helSexualAmbush();
		return;
	}
	//Raise Jojo chances for furrite
	if(player.hasPerk("Pierced: Furrite") >= 0 && rand(5) == 0 && (player.cor > 25 || monk > 0)) {
		chooser = 1;
	}
	//If Jojo lives in camp, never encounter him
	if(player.hasStatusAffect("PureCampJojo") >= 0 || flags[UNKNOWN_FLAG_NUMBER_00080] == 1) {
		chooser = rand(3);
		if(chooser >= 1) chooser++;
	}
	//Chance to discover deepwoods
	if((player.exploredForest >= 20) && player.hasStatusAffect("exploredDeepwoods") < 0) {
		player.createStatusAffect("exploredDeepwoods",0,0,0,0);
		outputText("After exploring the forest so many times, you decide to really push it, and plunge deeper and deeper into the woods.  The further you go the darker it gets, but you courageously press on.  The plant-life changes too, and you spot more and more lichens and fungi, many of which are luminescent.  Finally, a wall of tree-trunks as wide as houses blocks your progress.  There is a knot-hole like opening in the center, and a small sign marking it as the entrance to the 'Deepwoods'.  You don't press on for now, but you could easily find your way back to explore the Deepwoods.\n\n<b>Deepwoods exploration unlocked!</b>", true);
		doNext(13);
		return;
	}
	//Essy every 20 explores or so
	if((rand(100) <= 3) && player.gender > 0 && (flags[ESSY_MET_IN_DUNGEON] == 0 || flags[TOLD_MOTHER_TO_RELEASE_ESSY] == 1)) {
		essrayleMeetingI();
		return;
	}
	//Chance of dick-dragging! 10% + 10% per two foot up to 30%
	temp = 10 + (player.longestCockLength() - player.tallness)/24*10;
	if(temp > 30) temp = 30;
	if(temp > rand(100) && player.longestCockLength() >= player.tallness && player.totalCockThickness() >= 12) {
		bigJunkForestScene();
		return;
	}
	//Marble randomness
	if(player.exploredForest % 50 == 0 && player.exploredForest > 0 && player.hasStatusAffect("Marble Rape Attempted") < 0 && player.hasStatusAffect("No More Marble") < 0 && player.hasStatusAffect("Marble") >= 0 && flags[MARBLE_WARNING] == 0) {
		//can be triggered one time after Marble has been met, but before the addiction quest starts.
		clearOutput();
		outputText("While you're moving through the trees, you suddenly hear yelling ahead, followed by a crash and a scream as an imp comes flying at high speed through the foliage and impacts a nearby tree.  The small demon slowly slides down the tree before landing at the base, still.  A moment later, a familiar-looking cow-girl steps through the bushes brandishing a huge two-handed hammer with an angry look on her face.");
		outputText("\n\nShe goes up to the imp, and kicks it once.  Satisfied that the creature isn't moving, she turns around to face you and gives you a smile.  \"<i>Sorry about that, but I prefer to take care of these buggers quickly.  If they get the chance to call on their friends, they can actually become a nuisance.</i>\"  She disappears back into the foliage briefly before reappearing holding two large pile of logs under her arms, with a fire axe and her hammer strapped to her back.  \"<i>I'm gathering firewood for the farm, as you can see; what brings you to the forest, sweetie?</i>\"  You inform her that you're just exploring.");
		outputText("\n\nShe gives a wistful sigh. \"<i>I haven't really explored much since getting to the farm.  Between the jobs Whitney gives me, keeping in practice with my hammer, milking to make sure I don't get too full, cooking, and beauty sleep, I don't get a lot of free time to do much else.</i>\"  She sighs again.  \"<i>Well, I need to get this back, so I'll see you later!</i>\"");
		//end event
		doNext(13);
		return;
	}
	if(chooser == 0) {
		//Determines likelyhood of imp/goblins
		//Below - goblin, Equal and up - imp
		var impGob:Number = 5;
		trace("IMP/Gobb");
		
		//Dicks + lots of cum boosts goblin probability
		//Vags + Fertility boosts imp probability
		if(player.totalCocks() > 0) impGob--;
		if(player.hasVagina()) impGob++;
		if(player.fertility + player.bonusFertility() >= 30) impGob++;
		if(player.cumQ() >= 200) impGob--;
		if(player.hasPerk("Pierced: Lethite") >= 0) {
			if(impGob <= 3) impGob += 2;
			else if(impGob < 7) impGob = 7;
		}
		//Imptacular Encounter
		if(rand(10) < impGob) {
			if(player.level >= 8 && rand(2) == 0) {
				impLordEncounter();
			}
			else {
				outputText("An imp leaps out of the bushes and attacks!", true);
				startCombat(1);
			}
			spriteSelect(29);
			return;
		}
		//Encounter Gobbalin!
		else {
			//Tamani 25% of all goblin encounters encounter rate
			if(rand(4) <= 0 && flags[TAMANI_TIME_OUT] == 0 && player.gender > 0 && (player.totalCocks() > 0 || player.hasKeyItem("Deluxe Dildo") < 0)) {
				if(player.totalCocks() > 0 && flags[UNKNOWN_FLAG_NUMBER_00057] == 0 && int(player.statusAffectv2("Tamani")/2) >= 12) {
					encounterTamanisDaughters();
				}
				else
					encounterTamani();
				return;	
			}
			if(player.gender > 0) {
				outputText("A goblin saunters out of the bushes with a dangerous glint in her eyes.\n\nShe says, \"<i>Time to get fucked, " + player.mf("stud","slut"), true);
				outputText(".</i>\"", false);
				startCombat(15);
				spriteSelect(24);
				return;
			}
			else {
				outputText("A goblin saunters out of the bushes with a dangerous glint in her eyes.\n\nShe says, \"<i>Time to get fuc-oh shit, you don't even have anything to play with!  This is for wasting my time!", true);
				outputText("</i>\"", false);
				startCombat(15);
				spriteSelect(24);
				return;
			}
		}
	}
	if(chooser == 1) {
		trace("MOJO JOJO!");
		doNext(13);
		outputText("", true);
		if(monk == 0) {
			if(player.cor < 25) {
				outputText("You enjoy a peaceful walk in the woods.  It gives you time to think over the recent, disturbing events.", true);
				stats(0,.5,0,1,0,0,0,0);
				doNext(13);
				return;
			}			
			monk = 1;
			spriteSelect(34);
			outputText("While marvelling at the strange trees and vegetation of the forest, the bushes ruffle ominously.  A bush seems to explode into a flurry of swirling leaves and movement.  Before you can react you feel your " + player.feet() + " swept out from under you, and land hard on your back.\n\n", false);
			outputText("The angry visage of a lithe white mouse gazes down on your prone form with a look of confusion.", false);
			outputText("\n\n\"<i>I'm sorry, I sensed a great deal of corruption, and thought a demon or monster had come to my woods,</i>\" says the mouse, \"<i>Oh, where are my manners!</i>\"\n\nHe helps you to your feet and introduces himself as Jojo.  Now that you have a good look at him, it is obvious this mouse is some kind of monk, dressed in robes, holy symbols, and draped with prayer beads.\n\nHe smiles knowingly, \"<i>Yes I am a monk, and yes this is a strange place for one such as I... this world was not always this way.  Long ago this world was home to many villages, including my own.  But then the demons came.  I'm not sure if they were summoned, created, or simply a perversion of magic or breeding, but they came swarming out of the mountains to destroy everything in their path.</i>\"", false);
			outputText("\n\nJojo sighs sadly, \"<i>Enough of my woes.  You are very corrupted.  If you cannot be sufficiently purified you WILL become one of them in time.  Will you let me help you?", false);
			if(player.gender > 0) simpleChoices("Accept", 2003, "Rape Him", 2004, "BWUH?", 0, "Decline", 13, "", 0);
			else simpleChoices("Accept", 2003, "Rape Him", 0, "BWUH?", 0, "Decline", 13, "", 0);
			return;
		}
		if(monk == 1) {
			if(player.cor < 10) {
				outputText("You enjoy a peaceful walk in the woods, it gives you time to think.", true);
				stats(0,.5,0,1,0,0,0,0);
				doNext(13);
				return;
			}
			if(player.hasStatusAffect("infested") >= 0) {
				spriteSelect(34);
				outputText("As you approach the serene monk, you see his nose twitch, disturbing his meditation.\n\n", true);
				outputText("\"<i>It seems that the agents of corruption have taken residence within the temple that is your body.</i>\", Jojo says flatly. \"<i>This is a most unfortunate development. There is no reason to despair as there are always ways to fight the corruption. However, great effort will be needed to combat this form of corruption and may leave lasting impressions upon you. If you are ready, we can purge your being of the rogue creatures of lust.</i>\"\n\n", false);
				if(player.gender > 0) simpleChoices("Purge",2083,"Meditate",2003,"Rape",2004,"",0,"Leave",13);
				else simpleChoices("Purge",2083,"Meditate",2003,"Rape",0,"",0,"Leave",13);
				return;
			}
			spriteSelect(34);
			outputText("Jojo the monk appears before you, robes and soft white fur fluttering in the breeze.  He asks, \"<i>Are you ready for a meditation session?</i>\"", false);
			if(player.gender > 0) simpleChoices("Yes", 2003, "No", 13, "BWUH", 0, "Rape Him", 2004, "", 0);
			else simpleChoices("Yes", 2003, "No", 13, "BWUH", 0, "Rape Him", 0, "", 0);
		}
		if(monk >= 2) {
			spriteSelect(34);
			outputText("You are enjoying a peaceful walk through the woods when Jojo drops out of the trees ahead, ", true);
			if(monk == 2) outputText("his mousey visage twisted into a ferocious snarl.  \"YOU!\" he screams, launching himself towards you, claws extended.", false);
			if(monk == 3) outputText("unsteady on his feet, but looking for a fight!", false);
			if(monk == 4) outputText("visibly tenting his robes, but intent on fighting you.", false);
			if(monk == 5) outputText("panting and nude, his fur rustling in the breeze, a twitching behemoth of a cock pulsing between his legs.", false);
			startCombat(3);
		}
	}
	//Tentacles 25% of the time...
	if(chooser == 2) {
		trace("TRACE TENTACRUELS");
		outputText("", true);
		temp = rand(5);
		//Oh noes, tentacles!
		if(temp == 0) {
			//Tentacle avoidance chance due to dangerous plants
			if(player.hasKeyItem("Dangerous Plants") >= 0 && player.inte/2 > rand(50)) {
				temp == rand(3) + 1;
				trace("TENTACLE'S AVOIDED DUE TO BOOK!");
				outputText("Using the knowledge contained in your 'Dangerous Plants' book, you determine a tentacle beast's lair is nearby, do you continue?  If not you could return to camp.\n\n", false);
				simpleChoices("Continue",2009,"",0,"",0,"",0,"Leave", 13);
				return;
			}
			else {
				eventParser(2009);
				return;
			}
		}
		if(temp == 1) {
			if(player.cor < 80) {
				outputText("You enjoy a peaceful walk in the woods, it gives you time to think.", false);
				stats(0,.5,0,1,0,0,0,0);
			}
			else {
				outputText("As you wander in the forest, you keep ", false);
				if(player.gender == 1) outputText("stroking your half-erect " + multiCockDescriptLight() + " as you daydream about fucking all kinds of women, from weeping tight virgins to lustful succubi with gaping, drooling fuck-holes.", false);
				if(player.gender == 2) outputText("idly toying with your " + vaginaDescript(0) + " as you daydream about getting fucked by all kinds of monstrous cocks, from minotaurs' thick, smelly dongs to demons' towering, bumpy pleasure-rods.", false);
				if(player.gender == 3) outputText("stroking alternatively your " + multiCockDescriptLight() + " and your " + vaginaDescript(0) + " as you daydream about fucking all kinds of women, from weeping tight virgins to lustful succubi with gaping, drooling fuck-holes, before, or while, getting fucked by various monstrous cocks, from minotaurs' thick, smelly dongs to demons' towering, bumpy pleasure-rods.", false);
				if(player.gender == 0) outputText("daydreaming about sex-demons with huge sexual attributes, and how you could please them.", false);
				outputText("", false);
				stats(0,.5,0,0,.25,0,player.lib/5,0);
			}
			doNext(13);
			return;
		}
		//CORRUPTED GLADE
		if(temp == 2 || temp >= 4) {
			if(rand(4) == 0) {
				trappedSatyr();
				return;
			}
			outputText("Walking through the woods, you find a damp patch overgrown with corrupted plant-life.  Every flower seems warped into a colorful imitation of a female's genitals, each vine appears throbbing and veiny, and every knot on the nearby trees is capped with a nipple-like protrusion, leaking dark sap.", false);
			//disgusted reaction
			if(player.cor <= 33) {
				//Get plant-cum dripped on you if not fast and unlucky!
				if(player.spe < 60 && rand(player.spe + 50) < 50) {
					outputText("  Disgusted by this perversion of nature, you turn to leave, catching a faceful of the white goop that's spurting down from the vines above!  It's slimy, gross, and difficult to clear from your eyes, nose, and mouth.  The musky smell and delicious salty flavor are undoubtedly a result of the plant's corruption.  You escape the tainted glade, but feel warmer and warmer as time passes...", false);
					stats(0,0,0,0,0,0,20 + player.lib/5,0);
				}
				else {
					outputText("  Disgusted by this perversion of nature, you turn away to leave, narrowly avoiding a sudden dripping of thick white fluid from the vines overhead.", false);
					stats(0,0,0,0,0,0,2,0);
				}
				doNext(13);
				return;
			}
			//intrigued reaction
			if(player.cor > 33 && player.cor <= 66) {
				outputText("  You explore the glade with equal parts caution and curiosity.  ", false);
				temp2 = rand(3);
				//flowers...
				if(temp2 == 0) {
					outputText("A group of perverted looking flowers catch your eye, leading you to bend closer for a better look at the intricately folded petals, noting the beads of slick moisture that seems to perspire from inside the plant.  Awed by the corrupt yet beautiful flower, you take a deep breath, inhaling a lungful of its pungent yet sweet scents.  It matches the flower somehow, lingering in your nose even after you pull away.  The smell makes you wonder just how functional the pussy flowers are, they do have fairly large stalks.\n\nYou sigh and take one last sniff from the flower's honeypot before moving on.  Your body flushes happily with desire as your blood pools in your groin.  You giggle, wishing you could feel like this more often.", false);
					stats(0,0,0,0,0,0,20 + player.lib/5,.5);
				}
				//vines...
				if(temp2 == 1) {
					outputText("A few vines dangling from the trees catch your eye due to their rather 'unique' tips.  Every single one of them ends in a flared mushroom-like head, each twice as wide as the already thick vine.  You touch a vine gently, musing at its slippery texture and how similar it would be to a penis if the 'head' were smaller.  You encircle the vine with your hand, stroking it and giggling at the absurdity of this place.  The vine suddenly flexes in your grasp, pulsating and contracting as the it's head grows bigger, turning shiny and red.  Pulling away in shock, you gasp as the vine begins spurting out huge ropes of thick viscous fluid, splattering everywhere.  The plant-gasm ends as suddenly as it started, the 'head' retaining the size it gained and dripping the last of its strange load.  Overcome with curiosity, you sniff at the dripping spunk and swoon at the overpoweringly musky scent.  Gathering your wits, you decide to leave before you end up with one of those inside you.  You escape the corrupted glade, but stay flush with arousal.", false);
					stats(0,0,0,0,0,0,20 + player.lib/5,.5);
				}
				//trees...
				if(temp2 == 2) {
					outputText("A cluster of huge breast-like knots on a nearby tree draws your attention.  Unable to resist, you poke one, and burst into giggles as it jiggles like a real breast!  You cautiously begin groping the tree-tit, and smile as it begins leaking sweet-smelling sap.  The scent conjures memories of helping to make maple syrup back home, and before you realize it, you've gathered a drop of the sap on your finger and tasted it.  It's powerfully sweet, making your tongue tingle and heart beat faster.  Unbidden, the thought of suckling the teat dry of its sweet treat comes to mind, but you manage to reject it and stumble away from the corrupted glade.  You have trouble with your tongue for the next hour: it won't stay in your mouth, and keeps licking your lips, seeking any leftover sweetness.  It almost distracts you from the palpable heat gathering between your thighs.", false);
					stats(0,0,0,0,0,0,20 + player.lib/5,.5);
				}
				doNext(13);
				return;
			}
			//drink sap/lick flower reaction
			if(player.cor > 66 && player.cor <= 100) {
				outputText("  You smile as you enter the glade, wondering which of the forbidden fruits you should try...\n\nThere are flowers that bear more than a passing resemblance to pussies,\nvines with absurdly large penis-like tips,\nand trees covered in breast-like knots, leaking sap.", false);
				simpleChoices("Flowers", 2012, "Vines", 2013, "Trees", 2084, "", 0, "Leave", 13);
				return;
			}
			//Wallow in decadence reaction - UNFINISHED
		}
		//Trip on a root!
		if(temp == 3) {
			outputText("You trip on an exposed root, scraping yourself somewhat, but otherwise the hour is uneventful.", false);
			takeDamage(10);
			doNext(13);
			trace("FIX MEEEEE");
			return;
		}
	}
	//Bee-girl encounter
	if(chooser == 3) {
		if(rand(10) == 0) {
			menuLoc = 2;
			carapaceFind();
			return;
		}
		eventParser(2051);
		return;
	}
}
//Explore desert
function exploreDesert():void {
	player.exploredDesert++;
	if(player.level >= 4 && player.exploredDesert % 15 == 0 && flags[DISCOVERED_WITCH_DUNGEON] == 0) {
		inDungeon = true;
		dungeonLoc = 23;
		eventParser(1);
		return;
	}
	if(rand(40) == 0) {
		fountainEncounter();
		return;
	}
	//Helia monogamy fucks
	if(flags[PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !followerHel()) {
		helSexualAmbush();
		return;
	}
	if((player.exploredDesert == 20 && player.hasStatusAffect("Tel'Adre") < 0) || (rand(20) == 0 && player.statusAffectv1("Tel'Adre") == 0)) {
		discoverTelAdre();
		return;
	}
	if(flags[EGG_WITCH_COUNTER] >= 4 && flags[EGG_WITCH_TYPE] > 0 && rand(4) == 0) {
		if(flags[EGG_WITCH_TYPE] == 2) sammitchBirthsDriders();
		else witchBirfsSomeBees();
		return;
	}
	//Ant colony debug chances
	if(player.level >= 5 && flags[ANT_WAIFU] == 0 && (player.exploredDesert % 8 == 0) && flags[ANTS_PC_FAILED_PHYLLA] == 0 && flags[ANT_COLONY_KEPT_HIDDEN] == 0) {
		antColonyEncounter();
		return;
	}
	//int over 50?  Chance of alice encounter!
	if(rand(4)==0 && player.inte > 50 && flags[UNKNOWN_FLAG_NUMBER_00101] == 0) {
		outputText("", true);
		outputText("While exploring the desert, you see a plume of smoke rising in the distance.  You change direction and approach the soot-cloud carefully.  It takes a few moments, but after cresting your fourth dune, you locate the source.  You lie low, so as not to be seen, and crawl closer for a better look.\n\n", false);
		outputText("A library is burning up, sending flames dozens of feet into the air.  It doesn't look like any of the books will survive, and most of the structure has already been consumed by the hungry flames.  The source of the inferno is curled up next to it.  It's a naga!  She's tall for a naga, at least seven feet if she stands at her full height.  Her purplish-blue skin looks quite exotic, and she wears a flower in her hair.  The naga is holding a stick with a potato on the end, trying to roast the spud on the library-fire.  It doesn't seem to be going well, and the potato quickly lights up from the intense heat.\n\n", false);
		outputText("The snake-woman tosses the burnt potato away and cries, \"<i>Hora hora.</i>\"  She suddenly turns and looks directly at you.  Her gaze is piercing and intent, but she vanishes before you can react.  The only reminder she was ever there is a burning potato in the sand.   Your curiosity overcomes your caution, and you approach the fiery inferno.  There isn't even a trail in the sand, and the library is going to be an unsalvageable wreck in short order.   Perhaps the only item worth considering is the stick with the burning potato.  It's quite oddly shaped, and when you reach down to touch it you can feel a resonant tingle.  Perhaps it was some kind of wizard's staff?\n\n", false);
		shortName = "W.Staff";
		flags[UNKNOWN_FLAG_NUMBER_00101]++;
		menuLoc = 2;
		takeItem();
		return;
	}
	//Possible chance of boosting camp space!
	if(player.hasKeyItem("Camp - Chest") < 0 && (rand(100) < 10)) {
		outputText("While wandering the trackless sands of the desert, you break the silent monotony with a loud 'thunk'.  You look down and realize you're standing on the lid of an old chest, somehow intact and buried in the sand.  Overcome with curiosity, you dig it out, only to discover that it's empty.  It would make a nice addition to your campsite.\n\nYou decide to bring it back to your campsite.  <b>You now have six storage item slots at camp.</b>", true);
		createStorage();
		createStorage();
		createStorage();
		createStorage();
		createStorage();
		createStorage();
		player.createKeyItem("Camp - Chest",0,0,0,0);
		doNext(13);
		return;
	}
	//Chance of dick-dragging! 10% + 10% per two foot up to 30%
	temp = 10 + (player.longestCockLength() - player.tallness)/24*10;
	if(temp > 30) temp = 30;
	if(temp > rand(100) && player.longestCockLength() >= player.tallness && player.totalCockThickness() >= 12) {
		bigJunkDesertScene();
		return;
	}
	var choices:Array = new Array();
	//-8008 is cheating for "no arg"
	var args:Array = new Array();

	//Encounter Sandwitch
	if(flags[SAND_WITCH_LEAVE_ME_ALONE] == 0) {
		choices[choices.length] = eventParser;
		args[args.length] = 2005;
	}
	if(flags[CUM_WITCHES_FIGHTABLE] > 0 ) {
		choices[choices.length] = fightCumWitch;
		args[args.length] = -8008;
	}		
	//Encounter Marcus
	choices[choices.length] = wandererRouter;
	args[args.length] = -8008;
	choices[choices.length] = walkingDesertStatBoost;
	args[args.length] = -8008;
	if(rand(2) == 0 && player.level >= 2) {
		if(rand(2) == 0) {
			choices[choices.length] = mirageDesert;
			args[args.length] = -8008;
		}
		else {
			choices[choices.length] = oasisEncounter;
			args[args.length] = -8008;
		}
	}
	choices[choices.length] = nagaEncounter;
	args[args.length] = -8008;
	if(rand(2) == 0) {
		choices[choices.length] = encounterASandTarp;
		args[args.length] = -8008;
	}
	var select:int = rand(choices.length);
	if(args[select] == -8008) {
		choices[select]();
	}
	else choices[select](args[select]);
}
function mirageDesert():void {
	clearOutput();
	outputText("While exploring the desert, you see a shimmering tower in the distance.  As you rush towards it, it vanishes completely.  It was a mirage!   You sigh, depressed at wasting your time.", true);
	stats(0,0,0,0,0,0,-15,0);
	doNext(13);
	return;
}
function walkingDesertStatBoost():void {
	clearOutput();
	outputText("You walk through the shifting sands for an hour, finding nothing.\n\n", true);
	//Chance of boost == 50%
	if(rand(2) == 0) {
		//50/50 strength/toughness
		if(rand(2) == 0 && player.str < 50) {
			outputText("The effort of struggling with the uncertain footing has made you stronger.", false);
			stats(.5,0,0,0,0,0,0,0);
		}
		//Toughness
		else if(player.tou < 50) {
			outputText("The effort of struggling with the uncertain footing has made you tougher.", false);
			stats(0,.5,0,0,0,0,0,0);
		}
	}
	doNext(13);
}
//Explore High Mountain
function exploreHighMountain():void {
	flags[UNKNOWN_FLAG_NUMBER_00088]++;
	doNext(1);
	var chooser:Number = rand(3);
	//Boosts mino and hellhound rates!
	if(player.hasPerk("Pierced: Furrite") >= 0 && rand(3) == 0) {
		chooser = 1;
	}
	//Helia monogamy fucks
	if(flags[PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !followerHel()) {
		helSexualAmbush();
		return;
	}
	//Gats xmas adventure!
	if(rand(5) == 0 && player.gender > 0 && isHolidays() && flags[GATS_ANGEL_DISABLED] == 0 && flags[GATS_ANGEL_GOOD_ENDED] == 0 && (flags[GATS_ANGEL_QUEST_BEGAN] == 0 || player.hasKeyItem("North Star Key") >= 0)) {
		gatsSpectacularRouter();
		return;
	}
	//Minerva
	if(flags[UNKNOWN_FLAG_NUMBER_00088] % 8 == 0) {
		encounterMinerva();
		return;
	}
	//25% minotaur sons!
	if(flags[UNKNOWN_FLAG_NUMBER_00326] >= 3 && rand(4) == 0 && player.hasVagina()) {
		spriteSelect(44);
		meetMinotaurSons();
		return;		
	}
	//Harpy odds!
	if(hasItem("OviElix",1)) {
		if(hasItem("OviElix",2)) {
			if(rand(4) == 0) {
				chickenHarpy();
				return;
			}
		}
		else {
			if(rand(10) == 0) {
				chickenHarpy();
				return;
			}
		}
	}
	//10% chance to mino encounter rate if addicted
	if(flags[MINOTAUR_CUM_ADDICTION_STATE] > 0 && rand(10) == 0) {
		spriteSelect(44);
		//Cum addictus interruptus!  LOL HARRY POTTERFAG
		//Withdrawl auto-fuck!
		if(flags[MINOTAUR_CUM_ADDICTION_STATE] == 3) {
			minoAddictionFuck();
			return;
		}
		eventParser(2008);
		spriteSelect(44);
		return;
	}
	//Generic harpy
	if(chooser == 0) {
		outputText("A harpy wings out of the sky and attacks!", true);
		startCombat(25);
		spriteSelect(26);
		return;
	}
	//Basilisk!
	if(chooser == 1) {
		basiliskGreeting();
		return;
	}
	//Sophie
	if(chooser == 2) {
		if(flags[UNKNOWN_FLAG_NUMBER_00282] > 0 || flags[UNKNOWN_FLAG_NUMBER_00283] > 0 || sophieFollower()) {
			outputText("A harpy wings out of the sky and attacks!", true);
			startCombat(25);
			spriteSelect(26);
			return;
		}
		else {
			if(flags[UNKNOWN_FLAG_NUMBER_00090] == 0) meetSophie();
			else meetSophieRepeat();
		}
	}
}
//Explore Mountain
function exploreMountain():void {
	player.exploredMountain++;
	var chooser:Number = rand(4);
	//Helia monogamy fucks
	if(flags[PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !followerHel()) {
		helSexualAmbush();
		return;
	}
	//Discover 'high mountain' at level 5 or 40 explores of mountain
	if((player.level >= 5 || player.exploredMountain >= 40) && flags[UNKNOWN_FLAG_NUMBER_00088] == 0) {
		outputText("While exploring the mountain, you come across a relatively safe way to get at its higher reaches.  You judge that with this route you'll be able to get about two thirds of the way up the mountain.  With your newfound discovery fresh in your mind, you return to camp.\n\n(<b>High Mountain exploration location unlocked!</b>)", true);
		flags[UNKNOWN_FLAG_NUMBER_00088]++;
		doNext(13);
		return;
	}
	if(isHolidays()) {
		//Gats xmas adventure!
		if(rand(5) == 0 && player.gender > 0 && isHolidays() && flags[GATS_ANGEL_DISABLED] == 0 && flags[GATS_ANGEL_GOOD_ENDED] == 0 && (flags[GATS_ANGEL_QUEST_BEGAN] > 0 && player.hasKeyItem("North Star Key") < 0)) {
			gatsSpectacularRouter();
			return;
		}
		if(rand(6) == 0 && flags[JACK_FROST_YEAR] < date.fullYear) {
			meetJackFrostInTheMountains();
			return;
		}
	}
	//8% chance of hellhoundsplosions if appropriate
	if(rand(100) <= 77) {
		if(flags[UNKNOWN_FLAG_NUMBER_00141] < 3) {
			trace("CHANCE AT HELLHOUND GAO");
			//Requires canine face, [either two dog dicks, or a vag and pregnant with a hellhound], at least two other hellhound features (black fur, dog legs, dog tail), and corruption >=60.
			if(player.faceType == 2 && (player.dogCocks() >= 2 || (player.hasVagina() && player.pregnancyType == 6 && player.pregnancyIncubation > 0)) && player.cor >= 60 && player.tailType == 2 && (player.lowerBody == 2 || player.hairColor == "midnight black")) {
				trace("PASS BODYCHECK");
				if(flags[UNKNOWN_FLAG_NUMBER_00141] == 0) {
					HellHoundMasterEncounter();
					return;
				}
				//Level 2 requires lethecite
				else if(flags[UNKNOWN_FLAG_NUMBER_00141] == 1 && player.hasKeyItem("Marae's Lethicite") >= 0 && player.keyItemv2("Marae's Lethicite") < 3) {
					HellHoundMasterEncounter();
					return;
				}
			}
		}
	}
	//Rarer 'nice' Ceraph encounter
	//Overlaps half the old encounters once pierced.
	if(!ceraphIsFollower() && player.level > 2 && (player.exploredMountain % 30 == 0) && flags[PC_FETISH] > 0) {
		friendlyNeighborhoodSpiderManCeraph();
		return;
	}
	//15% chance of Ceraph
	if(!ceraphIsFollower() && player.level > 2 && (player.exploredMountain % 15 == 0) && flags[PC_FETISH] != 1) {
		encounterCeraph();
		return;
	}
	//10% chance of hairdresser encounter if not found yet
	if(rand(10) == 0 && player.hasStatusAffect("hairdresser meeting") < 0) chooser  = 4;
	if((rand(8) == 0 && player.hasStatusAffect("Met Marae") >= 0) 
		&& player.hasStatusAffect("Found Factory") < 0) {
		eventParser(11057);
		return;
	}
	//Boosts mino and hellhound rates!
	if(player.hasPerk("Pierced: Furrite") >= 0 && rand(3) == 0) {
		if(rand(2) == 0) chooser = 1;
		else chooser = 3;		
	}
	//10% chance to mino encounter rate if addicted
	if(flags[MINOTAUR_CUM_ADDICTION_STATE] > 0 && rand(10) == 0) {
		chooser = 1;
	}
	//10% MORE chance for minos if uber-addicted
	if(player.hasPerk("Minotaur Cum Addict") >= 0 && rand(10) == 0) {		
		chooser = 1;
	}
	//Every 15 explorations chance at mino bad-end!
	if(player.exploredMountain % 16 == 0 && player.hasPerk("Minotaur Cum Addict") >= 0) {
		spriteSelect(44);
		minoAddictionBadEndEncounter();
		return;
	}
	if(chooser == 0) {
		//Determines likelyhood of imp/goblins
		//Below - goblin, Equal and up - imp
		var impGob:Number = 5;
		if(player.hasPerk("Pierced: Lethite") >= 0) {
			if(impGob <= 3) impGob += 2;
			else if(impGob < 7) impGob = 7;
		}
		trace("IMP/Gobb");
		//Dicks + lots of cum boosts goblin probability
		//Vags + Fertility boosts imp probability
		if(player.totalCocks() > 0) impGob--;
		if(player.hasVagina()) impGob++;
		if(player.fertility + player.bonusFertility() >= 30) impGob++;
		if(player.cumQ() >= 200) impGob--;
		//Imptacular Encounter
		if(rand(10) < impGob) {
			if(player.level >= 8 && rand(2) == 0) {
				impLordEncounter();
			}
			else {
				outputText("An imp leaps out from behind a rock and attacks!", true);
				startCombat(1);
			}
			spriteSelect(29);
			return;
		}
		//Encounter Gobbalin!
		else {
			if(player.gender > 0) {
				outputText("A goblin saunters out of the bushes with a dangerous glint in her eyes.\n\nShe says, \"<i>Time to get fucked, " + player.mf("stud","slut"), true);
				outputText(".</i>\"", false);
				startCombat(15);
				spriteSelect(24);
				return;
			}
			else {
				outputText("A goblin saunters out of the bushes with a dangerous glint in her eyes.\n\nShe says, \"<i>Time to get fuc-oh shit, you don't even have anything to play with!  This is for wasting my time!", true);
				outputText("</i>\"", false);
				startCombat(15);
				spriteSelect(24);
				return;
			}
		}
	}
	//Minotauuuuur
	if(chooser == 1) {
		spriteSelect(44);
		if(player.hasStatusAffect("TF2") < 0 && player.level <= 1 && player.str <= 40) {
			if(silly()) {
				//(Ideally, this should occur the first time the player would normally get an auto-rape encounter with the minotaur. The idea is to give a breather encounter to serve as a warning of how dangerous the mountain is)
				outputText("Crossing over the treacherous mountain paths, you walk past an ominous cave.  The bones and the smell of death convince you to hasten your pace.  However, as you walk by, you hear a deep bellow and a snort as a monstrous man with a bull's head steps out.  With hell in his eyes and a giant ax in his hand, he begins to approach you in clear rage.  As he comes out into the light, you see that he is completely naked and sports a monstrous erection as angry as the minotaur himself, freely leaking a steady stream of pre-cum as he stalks you.\n\n", true);
				outputText("You stumble in your attempt to escape and realize that you are completely helpless.  The minotaur towers over you and heaves his ax for a <i>coup de grace</i>.  As he readies the blow, a monstrous explosion rocks the entire mountainside, causing the bull-man to stumble before he can finish you off. You look around, bewildered, trying to understand this strange new turn of events, and notice a group of maybe half a dozen people approaching from further up the path.  They appear to be a motley crew clad in blue and carrying monstrous weapons.  The tallest man holds a weapon made of multiple rotating tubes, and begins spinning the barrels.  A second later, while screaming in a language you do not understand, a rain of lead begins shredding the minotaur into a cloud of blood and flesh.\n\n", false);
				outputText("An equally imposing black man with a patch over one eye begins firing canisters at the beast, which explode violently.  \"<i>Ya ragged-arsed beast man!</i>\" he taunts.  \"<i>Ye should pick on someone yer own size, BOY-O! HEHEHE!</i>\"\n\n", false);
				outputText("Coming up the path next is a freak of a person clad in a contained shiny suit with weapon that burns with flame.  He freely walks into the explosions and gunfire and begins igniting the beast.\n\n", false);
				outputText("\"<i>MRPHHUMFHRUFH!!!!! HUMFHUFMMRUF!</i>\" the freak mumbles through his mask.\n\n", false);
				outputText("\"<i>I like me steak well done, ye crazy bugger!</i>\" yells the black man.\n\n", false);
				outputText("The beast collapses in a charred and bloody heap.   As you stand back up, you hear a strange noise behind you.  You turn around to find a well-dressed man wearing a ski mask and smoking a cigarette.  \"<i>Don't you know ze mountains are dangereuse,</i>\" the man says with a thick accent.  \"<i>You will get FUCKED up here if you are not careful.</i>\"\n\n", false);
				outputText("You thank the man and his team, but they brush off your gratitude.  \"<i>Non, non!</i>\" the man with the accent says.  \"<i>As zey say, everyone gets ONE.</i>\" With that, he touches the watch on his wrist and disappears.  The rest of the group continues on their way.\n\n", false);
				outputText("As they leave, the giant with the chain gun yells in a horribly accented manner, \"<i>YOU LEAVE SANDVICH ALONE! SANDVICH IS MINE!</i>\"\n\n", false);
				outputText("With that, another hail of bullets break the scene as they walk away, leaving you safe from the minotaur, but utterly baffled as to what in hell just happened.", false);
			}
			else {
				outputText("Crossing over the treacherous mountain paths, you walk past an ominous cave.  The bones and the smell of death convince you to hasten your pace.  However, as you walk by, you hear a deep bellow and a snort as a monstrous man with a bull's head steps out.  With hell in his eyes and a giant ax in his hand, he begins to approach you in clear rage.  As he comes out into the light, you see that he is completely naked and sports a monstrous erection as angry as the minotaur himself, freely leaking a steady stream of pre-cum as he stalks you.\n\n", true);
				outputText("You stumble in your attempt to escape and realize that you are completely helpless.  The minotaur towers over you and heaves his ax for a <i>coup de grace</i>.  As he readies the blow, another beast-man slams into him from the side.  The two of them begin to fight for the honor of raping you, giving you the opening you need to escape.  You quietly sneak away while they fight – perhaps you should avoid the mountains for now?\n\n", false);
			}
			player.createStatusAffect("TF2",0,0,0,0);
			doNext(13);
			return;
		}
		//Mino gangbang
		if(player.hasStatusAffect("Mino + Cowgirl") < 0 || rand(10) == 0) {
			if(flags[HAS_SEEN_MINO_AND_COWGIRL] == 1 && player.horns > 0 && player.hornType == 2 && player.earType == 3 && player.tailType == 4 && player.lactationQ() >= 200 && player.biggestTitSize() >= 3 && minotaurAddicted()) {
				//PC must be a cowmorph (horns, legs, ears, tail, lactating, breasts at least C-cup)
				//Must be addicted to minocum
				outputText("As you pass a shadowy cleft in the mountainside, you hear the now-familiar call of a cowgirl echoing from within.  Knowing what's in store, you carefully inch closer and peek around the corner.");
				outputText("\n\nTwo humanoid shapes come into view, both with pronounced bovine features - tails, horns and hooves instead of feet.  Their genders are immediately apparent due to their stark nudity.  The first is the epitome of primal femininity, with a pair of massive, udder-like breasts and wide child-bearing hips. The other is the pinnacle of masculinity, with a broad, muscular chest, a huge horse-like penis and a heavy set of balls more appropriate on a breeding stud than a person.  You have once again stumbled upon a cow-girl engaging in a not-so-secret rendezvous with her minotaur lover.");
				outputText("\n\nYou settle in behind an outcropping, predicting what comes next.  You see the stark silhouettes of imps and goblins take up similar positions around this makeshift theatre, this circular clearing surrounded on the edge by boulders and nooks where all manner of creatures might hide. You wonder if they're as  eager for the upcoming show as you are.  The heady scent of impending sex rises in the air... and with it comes something masculine, something that makes your stomach rumble in anticipation.  The mouth-watering aroma of fresh minotaur cum wafts up to your nose, making your whole body quiver in need.  Your [vagOrAss] immediately ");
				if(player.hasVagina()) outputText("dampens");
				else outputText("twinges");
				outputText(", aching to be filled");
				if(player.hasCock()) outputText(", while [eachCock] rises to attention, straining at your [armor]");
				outputText(".");
				
				outputText("\n\nYou can barely see it from your vantage point, but you can imagine it: the semi-transparent pre-cum dribbling from the minotaur's cumslit, oozing down onto your tongue.  Your entire body shivers at the thought, whether from disgust or desire you aren't sure.  You imagine your lips wrapping around that large equine cock, milking it for all of its delicious cum.  Your body burns hot like the noonday sun at the thought, hot with need, with envy at the cow-girl, but most of all with arousal.");
				
				outputText("\n\nSnapping out of your imaginative reverie, you turn your attention back to the show you wonder if you could make your way over there and join them, or if you should simply remain here and watch, as you have in the past.");
				menu();
				//[Join] [Watch]
				addButton(0,"Join",joinBeingAMinoCumSlut);
				addButton(1,"Watch",watchAMinoCumSlut);
				return;
			}
			flags[HAS_SEEN_MINO_AND_COWGIRL] = 1;
			if(player.hasStatusAffect("Mino + Cowgirl") < 0) player.createStatusAffect("Mino + Cowgirl",0,0,0,0);
			else player.addStatusValue("Mino + Cowgirl",1,1);
			outputText("As you pass a shadowy cleft in the mountainside, you hear the sounds of a cow coming out from it. Wondering how a cow got up here, but mindful of this land's dangers, you cautiously sneak closer and peek around the corner.\n\n", true);
			outputText("What you see is not a cow, but two large human-shaped creatures with pronounced bovine features -- tails, horns, muzzles, and hooves instead of feet. They're still biped, however, and their genders are obvious due to their stark nudity. One has massive, udder-like breasts and wide hips, the other a gigantic, horse-like dong and a heavy set of balls more appropriate to a breeding stud than a person. You've stumbled upon a cow-girl and a minotaur.\n\n", false);
			outputText("A part of your mind registers bits of clothing tossed aside and the heady scent of impending sex in the air, but your attention is riveted on the actions of the pair. The cow-girl turns and places her hands on a low ledge, causing her to bend over, her ample ass facing the minotaur. The minotaur closes the distance between them in a single step.\n\n", false);
			outputText("She bellows, almost moaning, as the minotaur grabs her cushiony ass-cheeks with both massive hands. Her tail raises to expose a glistening wet snatch, its lips already parted with desire. She moos again as his rapidly hardening bull-cock brushes her crotch. You can't tear your eyes away as he positions himself, his flaring, mushroom-like cock-head eliciting another moan as it pushes against her nether lips.\n\n", false);
			outputText("With a hearty thrust, the minotaur plunges into the cow-girl's eager fuck-hole, burying himself past one -- two of his oversized cock's three ridge rings. She screams in half pain, half ecstasy and pushes back, hungry for his full length. After pulling back only slightly, he pushes deeper, driving every inch of his gigantic dick into his willing partner who writhes in pleasure, impaled exactly as she wanted.\n\n", false);
			outputText("The pair quickly settles into a rhythm, punctuated with numerous grunts, groans, and moans of sexual excess. To you it's almost a violent assault sure to leave both of them bruised and sore, but the cow-girl's lolling tongue and expression of overwhelming desire tells you otherwise. She's enjoying every thrust as well as the strokes, gropes, and seemingly painful squeezes the minotaur's powerful hands deliver to her jiggling ass and ponderous tits. He's little better, his eyes glazed over with lust as he continues banging the fuck-hole he found and all but mauling its owner.", false);
			doNext(2190);
			return;
		}
		//Cum addictus interruptus!  LOL HARRY POTTERFAG
		//Withdrawl auto-fuck!
		if(flags[MINOTAUR_CUM_ADDICTION_STATE] == 3) {
			minoAddictionFuck();
			return;
		}
		eventParser(2008);
		spriteSelect(44);
	}
	//Worms
	if(chooser == 2) {
		//If worms are on and not infested.
		if(player.hasStatusAffect("wormsOn") >= 0 && player.hasStatusAffect("infested") < 0) {
			if(player.hasStatusAffect("wormsHalf") >= 0 && rand(2) == 0) {
				if(player.cor < 90) {
					outputText("Your hike in the mountains, while fruitless, reveals pleasant vistas and provides you with good exercise and relaxation.", true);
					stats(0,.25,.5,0,0,0,player.lib/10-15,0);
				}
				else {
				 	outputText("During your hike into the mountains, your depraved mind keeps replaying your most obcenely warped sexual encounters, always imagining new perverse ways of causing pleasure.\n\nIt is a miracle no predator picked up on the strong sexual scent you are emitting.", true);
					stats(0,.25,.5,0,.25,0,player.lib/10,0);
				}
				doNext(13);
				return;
			}
			eventParser(5052);
		}
		else {
			//If worms are off or the PC is infested, no worms.
			if(player.hasStatusAffect("wormsOff") >= 0 || player.hasStatusAffect("infested") >= 0 || (rand(2) == 0 && player.hasStatusAffect("wormsHalf") >= 0)) {
				if(player.cor < 90) {
					outputText("Your hike in the mountains, while fruitless, reveals pleasant vistas and provides you with good exercise and relaxation.", true);
					stats(0,.25,.5,0,0,0,player.lib/10-15,0);
				}
				else {
				 	outputText("During your hike into the mountains, your depraved mind keeps replaying your most obcenely warped sexual encounters, always imagining new perverse ways of causing pleasure.\n\nIt is a miracle no predator picked up on the strong sexual scent you are emitting.", true);
					stats(0,.25,.5,0,.25,0,player.lib/10,0);
				}
				doNext(13);
			}
			else {
				wormToggle();
			}
		}
	}
	//Hellhound
	if(chooser == 3) {
		spriteSelect(27);
		if(player.hasStatusAffect("wormsOn") >= 0 && rand(2) == 0) {
			//If lowered encounter rate, 25% chance, otherwise 50%.
			if(player.hasStatusAffect("wormsHalf") >= 0 && rand(2) == 0) {
				hellhoundEncounter();
				return;
			}
			infestedHellhoundEncounter();
			return;
		}
		hellhoundEncounter();
	}
	//Hairdresser
	if(chooser == 4) {
		hairDresser();
		return;
	}
}
//Explore Lake
function exploreLake():void {
	//Increment exploration count
	player.exploredLake++;
	if(poniesYN()) return;
	
	//Helia monogamy fucks
	if(flags[PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !followerHel()) {
		helSexualAmbush();
		return;
	}
	if(player.exploredLake % 20 == 0) {
		ottahGirl();
		return;
	}
	//Egg chooser
	if(rand(100) < 25 && player.pregnancyIncubation > 1 && player.pregnancyType == 5) {
		outputText("While wandering along the lakeshore, you spy beautiful colored lights swirling under the surface.  You lean over cautiously, and leap back as they flash free of the lake's liquid without making a splash.  The colored lights spin in a circle, surrounding you.  You wonder how you are to fight light, but they stop moving and hover in place around you.  There are numerous colors: Blue, Pink, White, Black, Purple, and Brown.  They appear to be waiting for something; perhaps you could touch one of them?", true);
		//Blue, Pink, White, Black, Purple, and Brown
		choices("Blue", 1045, "Pink", 1046, "White", 1051, "Black", 1047, "Purple", 1048, "Brown", 1049, "",0,"",0,"",0,"Escape",1050);
		return;
	}
	//Did it already output something?
	var displayed:Boolean = false;
	var choice:Array = new Array();
	var select:int = 0;
	
	//Build choice list.
	//==================================================
	//COMMON EVENTS
	if(player.level < 2 || player.spe < 50) choice[choice.length] = 0;
	choice[choice.length] = 1;
	choice[choice.length] = 2;
	//Fetish cultist not encountered till level 2
	if(player.level >= 2 && player.hasStatusAffect("DungeonShutDown") >= 0)
		choice[choice.length] = 3;
	//Slimes/Ooze = level >= 2
	if(player.level >= 2) 
		choice[choice.length] = 4;
	//Izma
	if(flags[UNKNOWN_FLAG_NUMBER_00230] > 0 && (player.exploredLake >= 10) && (flags[UNKNOWN_FLAG_NUMBER_00233] == 0 || player.hasStatusAffect("infested") < 0) && flags[UNKNOWN_FLAG_NUMBER_00238] <= 0) 
		choice[choice.length] = 5;
	//Rathazul
	if(player.hasStatusAffect("Camp Rathazul") < 0) 
		choice[choice.length] = 6;
	
	//UNCOMMON EVENTS
	//Goo finding!
	if(rand(30) == 0 && flags[GOO_TFED_MEAN] + flags[GOO_TFED_NICE] > 0 && flags[GOO_SLAVE_RECRUITED] == 0) {
		encounterLeftBehindGooSlave();
		return;
	}
	//Chance of dick-dragging! OLD:10% + 10% per two foot up to 30%
	temp = 10 + (player.longestCockLength() - player.tallness)/24*10;
	if(temp > 0 && player.longestCockLength() >= player.tallness - 10 && player.totalCockThickness() >= 8) 
	choice[choice.length] = 8;
	
	//ONE TIME EVENTS
	//Amily Village discovery
	if(flags[AMILY_VILLAGE_ACCESSIBLE] == 0) 
		choice[choice.length] = 9;
	//Sword Discovery
	if(player.hasStatusAffect("Took Blessed Sword") < 0 && player.hasStatusAffect("BSwordBroken") < 0) 
		choice[choice.length] = 10;
	//Pre-emptive chance of finding the boat
	if(player.hasStatusAffect("Boat Discovery") < 0)
		choice[choice.length] = 11;
	
	//CHOOSE YOUR POISON!
	select = choice[rand(choice.length)];
	
	//==============================
	//EVENTS GO HERE!
	//==============================
	//Pre-emptive chance of discovering Amily the stupidshit mouse
	if(select == 9) {
		discoverAmilyVillage();
		return;
	}
	//Pre-emptive chance of discovering the Beautiful Sword
	else if(select == 10) {
		findSwordInStone();		
		return;
	}
	//Pre-emptive chance of finding the boat
	else if(select == 11) {
		discoverBoat();
		return;
	}
	//Meet Izma every 8 attempts
	else if(select == 5) {
		meetIzmaAtLake();
		return;
	}
	//Chance of dick-dragging! 10% + 10% per two foot up to 30%
	else if(select == 8) {
		//True sets to use lake scene!
		bigJunkForestScene(true);
		return;
	}
	else if(select == 4){
		//Chance of seeing ooze convert goo!
		//More common if factory blew up
		if(player.hasStatusAffect("FactoryOverload") >= 0 && rand(10) == 0) {
			spyOnGooAndOozeSex();
			return;
		}
		//Else pretty rare.
		else if(rand(25) == 0) {
			spyOnGooAndOozeSex();
			return;
		}
		var girlOdds:Number = 50;
		//50% odds of slime-girl, 75% if shutdown factory
		if(player.hasStatusAffect("DungeonShutDown") >= 0 && player.hasStatusAffect("FactoryOverload") < 0) 
			girlOdds += 25;
		if(player.hasStatusAffect("FactoryOverload") >= 0)
			girlOdds -= 25;
		//Slimegirl!
		if(rand(100) <= girlOdds) {
			encounterGooGirl();
			return;
		}
		//OOZE!
		else {
			flags[TIMES_MET_OOZE]++;
			spriteSelect(25);
			//High int starts on even footing.
			if(player.inte >= 25) {
				outputText("A soft shuffling sound catches your attention and you turn around, spotting an amorphous green mass sliding towards you!  Realizing it's been spotted, the ooze's mass surges upwards into a humanoid form with thick arms and wide shoulders.  The beast surges forward to attack!", true);
				startCombat(6);	
				if(player.hasStatusAffect("DungeonShutDown") >= 0 && player.hasStatusAffect("FactoryOverload") < 0) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>", false);
				return;
			}
			//High speed starts on even footing.
			if(player.spe >= 30) {
				outputText("You feel something moist brush the back of your ankle and instinctively jump forward and roll, coming up to face whatever it is behind you.  The nearly silent, amorphous green slime that was at your feet surges vertically, its upper body taking the form of a humanoid with thick arms and wide shoulders, which attacks!", true);
				startCombat(6);		
				if(player.hasStatusAffect("DungeonShutDown") >= 0 && player.hasStatusAffect("FactoryOverload") < 0) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>", false);
				return;
			}
			//High strength gets stunned first round.
			if(player.str >= 40) {
				outputText("Without warning, you feel something moist and spongy wrap around your ankle, nearly pulling you off balance.  With a ferocious tug, you pull yourself free and turn to face your assailant.  It is a large green ooze that surges upwards to take the form of humanoid with wide shoulders and massive arms.  It shudders for a moment, and its featureless face shifts into a green version of your own! The sight gives you pause for a moment, and the creature strikes!", true);
				if(player.hasStatusAffect("DungeonShutDown") >= 0 && player.hasStatusAffect("FactoryOverload") < 0) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>", false);
				startCombat(6);
				outputText("\n\n", false);
				eAttack();
				return;
			}
			//Player's stats suck and you should feel bad.
			outputText("Without warning, you feel something moist and spongy wrap around your ankle, pulling you off balance!  You turn and try to pull your leg away, struggling against a large green ooze for a moment before your foot comes away with a *schlorp* and a thin coating of green fluid.  The rest of the ooze rises to tower over you, forming a massive green humanoid torso with hugely muscled arms and wide shoulders.  Adrenaline rushes into your body as you prepare for combat, and you feel your heart skip a beat as your libido begins to kick up as well!", true);
			if(player.hasStatusAffect("DungeonShutDown") >= 0 && player.hasStatusAffect("FactoryOverload") < 0) outputText("\n\n<b>You are amazed to encounter a slime creature with the factory shut down - most of them have disappeared.</b>", false);
			stats(0,0,0,0,1,0,10,0);
			startCombat(6);
			return;
		}
	}
	else if(select == 0) {
		outputText("Your quick walk along the lakeshore feels good.", true);
		if(player.spe >= 50) {
			
		}
		else{
			outputText("  You bet you could cover the same distance even faster next time.\n", false);
			stats(0,0,.75,0,0,0,0,0);
		}
		doNext(13);
	}
	else if(select == 1) {
		if(player.level >= 5 && flags[KAIJU_DISABLED] == 0) {
			kaijuMeeting();
			return;
		}
		outputText("Your stroll around the lake increasingly bores you, leaving your mind to wander.  ", true);
		if(player.cor > 30 || player.lust > 60 || player.lib > 40) outputText("Your imaginings increasingly seem to turn ", false);
		else stats(0,0,0,1,0,0,0,0);
		if((player.cor > 30 && player.cor < 60) || (player.lust > 60 && player.lust < 90) || (player.lib > 40 && player.lib < 75)) {
			outputText("to thoughts of sex.", false);
			stats(0,0,0,0,0,0,(5+player.lib/10),0);
			displayed = true;
		}
		if(((player.cor >= 60) || (player.lust >= 90) || (player.lib >= 75)) && !displayed) {
			outputText("into daydreams of raunchy perverted sex, flooding your groin with warmth.", false);
			stats(0,0,0,0,0,0,(player.cor/10+player.lib/10),0);
		}
		doNext(13);
		
	}
	//Find whitney or equinum
	else if(select == 2) {
		//40% chance of item, 60 of whitney.
		if(rand(10) < 4)
		{
			if(rand(2) == 0) {
				outputText("You find a long and oddly flared vial half-buried in the sand.  Written across the middle band of the vial is a single word: 'Equinum'.\n", true);
				shortName = "Equinum"
				menuLoc = 2;
				eventParser(1001);
			}
			else {
				outputText("You find an odd, fruit-bearing tree growing near the lake shore.  One of the fruits has fallen on the ground in front of you.  You pick it up.\n", true);
				shortName = "W.Fruit"
				menuLoc = 2;
				eventParser(1001);
			}
			return;
		}
		//Find Whitney
		else {
			//Have you met whitney?
			if(player.hasStatusAffect("Met Whitney") >= 0) {
				//Is the farm in your places menu?
				if(player.statusAffects[player.hasStatusAffect("Met Whitney")].value1 > 1) {
					//If so, find equinum or whisker fruit
					if(rand(2) == 0) {
						outputText("You find a long and oddly flared vial half-buried in the sand.   Written across the middle band of the vial is a single word, 'Equinum'.\n", true);
						shortName = "Equinum"
						menuLoc = 2;
						eventParser(1001);
					}
					else {
						outputText("You find an odd, fruit-bearing tree growing near the lake shore.  One of the fruits has fallen on the ground in front of you.  You pick it up.\n", true);
						shortName = "W.Fruit"
						menuLoc = 2;
						eventParser(1001);
					}
					return;
				}
				//If you havent met whitney enough to know the farm....
				else farmExploreEncounter();
			}
			//If you havent met whitney, you can find the farm....
			else farmExploreEncounter();
		}
	}
	else if(select == 3) {
		if(player.hasStatusAffect("fetishON") < 0) {
			player.createStatusAffect("fetishON",0,0,0,0);
			outputText("While exploring, you notice something unusual on the lake.  This something is quickly moving towards you at a surprising rate, much faster than anything you've ever seen before.  Wary of meeting new things in this world after your previous experiences, you decide to slip behind a nearby hill and watch it while hidden.  Soon the object comes into view and you can see that it is a boat of some kind.  It looks almost like a large open box on the water with some kind of gazebo on it.  Despite how fast it is moving, you can't see any oars or means of moving the boat.  It slows somewhat when it gets close to the shore, but is still going about as fast as you can run when it hits the shore and extends some kind of gangplank onto the lake shore.  With a close up view, you estimate that it is six feet across, ten feet long, and doesn't actually seem to have very much of it underwater.  You guess that it must be magic in some way.  There are several robe-clad figures on board.\n\n", true);
			outputText("After a moment, a number of the figures disembark down the gangplank and immediately go off in different directions.  You count half a dozen of them, and guess that they are female when one of them passes by close to you and you see the hole in her outfit over her naughty bits.  You look back at the boat to see it close the gangplank, and move back onto the lake, with only one of the figures still on board.  Surprised to hear a sudden yell, you look to the side and see the clothing of the one who passed you earlier shifts and twists before becoming some pink outfit that clings to her backside.  You are stunned for a moment as she disappears from sight before you shake your head and move on.  It seems there are new residents to the lake.\n\n<b>(Fetish Cultists can now be encountered!)</b>", false); 

			//(increase player lust from the sights they saw)
			stats(0,0,0,0,0,0,5,0);
			doNext(13);
			return;
		}
		fetishCultistEncounter();		
	}
	else if(select == 6) {
		encounterRathazul();
		return;
	}
	else {
		outputText("OH SHIT! LAKE EXPLORE BE BROKED.  SELECT: " + select + ".  You should probably go to fenoxo.com and click the link to report a bug and tell Fen about it.");
	}
}

function boatExplore():void {
	//Helia monogamy fucks
	if(flags[PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !followerHel()) {
		helSexualAmbush();
		return;
	}
	outputText("You reach the dock without any incident and board the small rowboat.  The water is calm and placid, perfect for rowing.  ", true);
	if(player.hasStatusAffect("FactoryOverload") >= 0) {
		outputText("The water appears somewhat muddy and has a faint pungeant odor.  ", false);
		if(player.inte > 40) outputText("You realize what it smells like – sex.  ", false);
	}
	//3% chance of finding lost daughters
	if(rand(100) <= 3 && flags[UNKNOWN_FLAG_NUMBER_00412] > 0 && izmaFollower()) {
		findLostIzmaKids();
		return;
	}
	outputText("You set out, wondering if you'll find any strange islands or creatures in the lake.\n\n", false);
	//20% chance if not done with marae of meeting her.
	if(rand(10) <= 2 && player.hasStatusAffect("Marae Complete") < 0 && player.hasStatusAffect("Met Corrupt Marae") < 0) {
		encounterMarae();
		return;
	}
	//10% chance of corrupt Marae followups
	if((debug || rand(10) == 0) && flags[UNKNOWN_FLAG_NUMBER_00100] == 0 && player.hasStatusAffect("Met Corrupt Marae") >= 0 && player.gender > 0) {
		level2MaraeEncounter();
		return;
	}
	//BUILD LIST OF CHOICES
	var choice:Array = new Array();
	choice[choice.length] = 0;
	choice[choice.length] = 1;
	choice[choice.length] = 2;
	choice[choice.length] = 3;
	if(player.hasStatusAffect("DungeonShutDown") >= 0 && player.level > 2) 
		choice[choice.length] = 4;
	choice[choice.length] = 5;
	//MAKE YOUR CHOICE
	var selector:Number = choice[rand(choice.length)];
	//RUN CHOSEN EVENT
	switch (selector) {
		case 0:
			outputText("You row for nearly an hour, until your arms practically burn with exhaustion from all the rowing.", false);
			doNext(13);
			return;
		case 1:
			outputText("You give up on finding anything interesting, and decide to go check up on your camp.", false);
			doNext(13);
			return;
		case 2:
			sharkGirlEncounter(1);
			return;
		case 3:
			sharkGirlEncounter(1);
			return;
		case 4:
			zealotBoat();
			return;
		case 5: 
			mortalAnemoneeeeee();
			return;
	}

}

function exploreBog():void {
	flags[BOG_EXPLORED]++;
	//Helia monogamy fucks
	if(flags[PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !followerHel()) {
		helSexualAmbush();
		return;
	}
	if(player.buttPregnancyIncubation == 0 && rand(3) == 0) findTheFrogGirl();
	else if(rand(2) == 0) encounterChameleon();
	else {
		clearOutput();
		outputText("You wander around through the humid muck, but you don't run into anything interesting.");
		doNext(13);
	}
}
function exploreSwamp():void {
	//Discover 'Bog' at after 25 explores of swamp
	if((flags[UNKNOWN_FLAG_NUMBER_00272] >= 25) && flags[BOG_EXPLORED] == 0) {
		outputText("While exploring the swamps, you find yourself into a particularly dark, humid area of this already fetid biome.  You judge that you could find your way back here pretty easily in the future, if you wanted to.  With your newfound discovery fresh in your mind, you return to camp.\n\n(<b>Bog exploration location unlocked! (Page 2)</b>)", true);
		flags[BOG_EXPLORED]++;
		doNext(13);
		return;
	}
	flags[UNKNOWN_FLAG_NUMBER_00272]++;
	/*  SPECIAL SCENE OVERWRITES */
	//KIHA X HEL THREESOME!
	if(!followerKiha() && player.cor < 60 && flags[KIHA_AFFECTION_LEVEL] >= 1 && flags[HEL_FUCKBUDDY] > 0 && player.hasCock() && flags[KIHA_AND_HEL_WHOOPIE] == 0) {
		kihaXSalamander();
		return;
	}
	//Helia monogamy fucks
	if(flags[PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !followerHel()) {
		helSexualAmbush();
		return;
	}
	if(flags[TOOK_EMBER_EGG] == 0 && flags[EGG_BROKEN] == 0 && flags[UNKNOWN_FLAG_NUMBER_00272] > 0 && (flags[UNKNOWN_FLAG_NUMBER_00272] % 40 == 0)) {
		findEmbersEgg();
		return;
	}
	/*  STANDARD SCENE SELECTION  */
	var choices:Array = new Array();
	//Build the choice array
	//M & F spidermorphs
	choices[choices.length] = 0;
	choices[choices.length] = 1;
	//Drider
	choices[choices.length] = 2;
	//ROGAR
	if(flags[ROGAR_DISABLED] == 0 && flags[ROGAR_PHASE] < 3)
		choices[choices.length] = 3;
	//Kiha
	choices[choices.length] = 4;
	
	//Pick from the choices and pull the encounter.
	var choice:Number = choices[rand(choices.length)];
	switch(choice) {
		case 0:
			fSpiderMorphGreeting();
			break
		case 1:
			greetMaleSpiderMorph();
			break;
		case 2:
			driderEncounter();
			break;
		case 3:
			encounterRogarSwamp();
			break;
		case 4:
			//Kiha follower gets to explore her territory!
			if(followerKiha()) kihaExplore();
			else encounterKiha();
			break;
		default:
			outputText("New explore code fucked up.  YOU BONED (TELL FEN)");
			doNext(1);
			break;
	}
}
function explorePlains():void {
	outputText("", true);
	flags[UNKNOWN_FLAG_NUMBER_00131]++;
	var select:Number = rand(6);
	//Dem Kangasluts!  Force Sheila relationship phase!
	if(flags[SHEILA_DEMON] == 0 && flags[SHEILA_XP] == 3 && hours == 20 && flags[SHEILA_CLOCK] >= 0) {
		sheilaXPThreeSexyTime();
		return;
	}
	//Add some holiday cheer
	if(isHolidays() && date.fullYear > flags[CANDY_CANE_YEAR_MET] && rand(5) == 0) {
		candyCaneTrapDiscovery();
		return;
	}
	if(isHolidays() && date.fullYear > flags[POLAR_PETE_YEAR_MET] && rand(4) == 0) {
		polarPete();
		flags[POLAR_PETE_YEAR_MET] = date.fullYear;
		return;
	}
	//Helia monogamy fucks
	if(flags[PC_PROMISED_HEL_MONOGAMY_FUCKS] == 1 && flags[HEL_RAPED_TODAY] == 0 && rand(10) == 0 && player.gender > 0 && !followerHel()) {
		helSexualAmbush();
		return;
	}
	//Find Niamh
	if(flags[NIAMH_MOVED_OUT_COUNTER] == 1) {
		niamhPostTelAdreMoveOut();
		return;
	}
	//Find Owca
	if(player.level >= 8 && flags[UNKNOWN_FLAG_NUMBER_00131] % 25 == 0 && flags[OWCA_UNLOCKED] == 0) {
		gangbangVillageStuff();
		return;
	}
	//Bazaar!
	if(flags[UNKNOWN_FLAG_NUMBER_00131] % 10 == 0 && flags[BAZAAR_ENTERED] == 0) {
		findBazaar();
		return;
	}
	//Chance of threesomes!
	if(flags[UNKNOWN_FLAG_NUMBER_00256] != 0 && flags[UNKNOWN_FLAG_NUMBER_00257] != 0 && flags[HEL_FUCKBUDDY] == 1 && flags[UNKNOWN_FLAG_NUMBER_00260] == 0 && !isabellaFollower() && flags[UNKNOWN_FLAG_NUMBER_00131] % 21 == 0 && !(player.tallness > 78 && flags[UNKNOWN_FLAG_NUMBER_00258] == 0)) {
		//Hell/Izzy threesome intro
		if(flags[HEL_ISABELLA_THREESOME_ENABLED] == 0) {
			salamanderXIsabellaPlainsIntro();
			return;
		}
		//Propah threesomes here!
		else if(flags[HEL_ISABELLA_THREESOME_ENABLED] == 1) {
			isabellaXHelThreeSomePlainsStart();
			return;
		}
	}
	
	var choices:Array = new Array();
	choices[choices.length] = plainsLoot;
	choices[choices.length] = plainsLoot;
	choices[choices.length] = gnoll2Encounter;
	choices[choices.length] = gnollEncounter;
	choices[choices.length] = bunnbunbunMeet;
	choices[choices.length] = bunnbunbunMeet;
	
	if(flags[ISABELLA_PLAINS_DISABLED] == 0) {
		choices[choices.length] = isabellaGreeting;
		choices[choices.length] = isabellaGreeting;
	}
	if(!followerHel()) {
		choices[choices.length] = encounterAJerkInThePlains;
		choices[choices.length] = encounterAJerkInThePlains;
	}
	choices[choices.length] = satyrEncounter;
	choices[choices.length] = satyrEncounter;
	if(flags[SHEILA_CLOCK] >= 0) {
		choices[choices.length] = sheilaEncounterRouter;
		choices[choices.length] = sheilaEncounterRouter;
	}
	//Pick one
	choices[rand(choices.length)]();
	return;
}
function plainsLoot():void {
	//OVI
	if(rand(2) == 0) {
		outputText("While exploring the plains you nearly trip over a discarded, hexagonal bottle.  ", false);
		shortName = "OviElix";
		menuLoc = 2;
		takeItem();
		return;
	}
	// FIND KANGAAA
	else {
		outputText("While exploring the plains you come across a strange-looking plant.  As you peer at it, you realize it has some fruit you can get at.  ", false);
		shortName = "KangaFt";
		menuLoc = 2;
		takeItem();
		return;
	}
}

function debugOptions():void {
	shortName = "W.Fruit";
	takeItem();
}

//Massive bodyparts scene
//[DESERT]
//[RANDOM SCENE IF CHARACTER HAS AT LEAST ONE COCK LARGER THAN THEIR HEIGHT, 
//AND THE TOTAL COMBINED WIDTH OF ALL THEIR COCKS IS TWELVE INCHES OR GREATER]
function bigJunkDesertScene():void {
	outputText("", true);
	var x:Number = player.longestCock();
	//PARAGRAPH 1
	outputText("Walking along the sandy dunes of the desert you find yourself increasingly impeded by the bulk of your " + cockDescript(x) + " dragging along the sandscape behind you.  The incredibly hot surface of the desert causes your loins to sweat heavily and fills them with relentless heat.", false);
	
	if(player.cocks.length == 1) outputText("  As it drags along the dunes, the sensation forces you to imagine the rough textured tongue of a monstrous animal sliding along the head of your " + Appearance.cockNoun(player.cocks[x].cockType) + ".", false);
	else if (player.cocks.length >= 2) outputText("  With all of your " + multiCockDescriptLight() + " dragging through the sands they begin feeling as if the rough textured tongues of " + num2Text(player.cockTotal()) + " different monstrous animals were slobbering over each one.", false);
	outputText("\n\n", false);

	//PARAGRAPH 2
	
	//FOR NON-CENTAURS]
	if(!player.isTaur())
	{
        outputText("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your " + multiCockDescriptLight() + ", which forces your torso to the ground.  Normally your erection would merely raise itself skyward but your genitals have grown too large and heavy for your " + hipDescript() + " to hold them aloft.  Instead you feel your body forcibly pivoting at the hips until your torso is compelled to rest face down on top of your obscene " + multiCockDescriptLight() + ".", false);

        //IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
        if(player.biggestTitSize() >= 35)  outputText("  Your " + allBreastsDescript() + " hang lewdly off your torso to rest on the desert sands, seeming to bury the dunes on either side of you.  Their immense weight anchors your body, further preventing your torso from lifting itself up.  The burning heat of the desert teases your " + nippleDescript(0) + "s mercilessly as they grind in the sand.", false);
        //IF CHARACTER HAS A BALLS ADD SENTENCE
        if(player.balls > 0) outputText("  Your " + player.skinTone + sackDescript() + " rests beneath your raised " + buttDescript() + ".  The fiery warmth of the desert caresses it, causing your " + ballsDescriptLight() + " to pulse with the need to release their sperm through your " + multiCockDescriptLight() + ".", false);
        //IF CHARACTER HAS A VAGINA ADD SENTENCE
        if(player.vaginas.length >= 1)
        {
			outputText("  Your " + vaginaDescript() + " and " + clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + buttDescript() + " above.", false);
			//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
			if(player.vaginas[0].vaginalWetness >= 4) outputText("  Juices stream from your womanhood and begin pooling on the hot sand beneath you.  Wisps of steam rise up into the air only to tease your genitals further.  ", false);
		}
	}
	//FOR CENTAURS
	else
	{
		outputText("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your " + multiCockDescriptLight() + ", which forces the barrel of your horse-like torso to the ground.  Normally your erection would merely hover above the ground in between your centaurian legs, but your genitals have grown too large and heavy for your " + hipDescript() + " to hold them aloft.  Instead, you feel your body forcibly pulled down at your hindquarters until you rest atop your " + multiCockDescriptLight() + ".", false);
		//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
		if(player.biggestTitSize() >= 35)  outputText("  Your " + allBreastsDescript() + " pull your human torso forward until it also is forced to rest facedown, just like your horse half.  Your tits rest, pinned on the desert sand to either side of you.  Their immense weight anchors you, further preventing any part of your equine body from lifting itself up.  The burning heat of the desert teases your " + nippleDescript(0) + "s incessantly.", false);
		//IF CHARACTER HAS A BALLS ADD SENTENCE
		if(player.balls > 0) outputText("  Your " + player.skinTone + sackDescript() + " rests beneath your raised " + buttDescript() + ".  The airy warmth of the desert teases it, causing your " + ballsDescriptLight() + " pulse with the need to release their sperm through your " + multiCockDescriptLight() + ".", false);
		//IF CHARACTER HAS A VAGINA ADD SENTENCE
		if(player.vaginas.length >= 1)
		{
				outputText("  Your " + vaginaDescript() + " and " + clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + buttDescript() + " above.", false);
				//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
				if(player.vaginas[0].vaginalWetness >= 4) outputText("  The desert sun beats down on your body, its fiery heat inflaming the senses of your vaginal lips.  Juices stream from your womanhood and begin pooling on the hot sand beneath you.", false);
		}
	}
	outputText("\n\n", false);
	//PARAGRAPH 3
	outputText("You realize you are effectively trapped here by your own body.", false);
	//CORRUPTION BASED CHARACTER'S VIEW OF SITUATION
	if(player.cor < 33) outputText("  Panic slips into your heart as you realize that if any dangerous predator were to find you in this state, you'd be completely defenseless.  You must find a way to regain your mobility immediately!", false); 
	else if(player.cor < 66) outputText("  You realize that if any dangerous predator were to find you in this state you'd be completely defenseless.  You must find a way to regain your mobility... yet there is a certain appeal to imagining how pleasurable it would be for a sexual predator to take advantage of your obscene body.", false); 
	else outputText("  Your endowments have rendered you completely helpless should any predators find you.  Somewhere in your heart, your exhilarated at the prospect.  The idea of being a helpless fucktoy for a wandering beast is unusually inviting to you.  Were it not for the thought that you might die of thirst in the desert, you'd be incredibly tempted to remain right where you are.", false);

	//SCENE END = IF CHARACTER HAS FULL WINGS ADD SENTENCE
	if(player.canFly()) outputText("  You extend your wings and flap as hard as you can, until at last you manage to lighten the bulk of your body somewhat - enough to allow yourself to drag your genitals across the hot sands and back to camp.  The ordeal takes nearly an hour.", false);
	//SCENE END IF CHARACTER HAS CENTAUR BODY
	else if(player.isTaur()) outputText("  You struggle and work your equine legs against the surface of the dune you are trapped on.  Your " + player.feet() + " have consistent trouble finding footing, the soft sand failing to provide enough leverage to lift your bulk.  You breath in deeply and lean from side to side, trying to find some easier vertical leverage.  Eventually, with a crude crawl, your legs manage to push the bulk of your body onto more solid ground.  With great difficulty, you spend the next hour shuffling your genitals across the sandscape and back to camp.", false);
	//SCENE END = FOR ALL OTHER CHARACTERS
	else outputText("  You struggle and push with your " + player.legs() + " as hard as you can, but it's no use.  You do the only thing you can and begin stroking your " + multiCockDescriptLight() + " with as much vigor as you can muster.  Eventually your body tenses and a light load of jizz erupts from your body, but the orgasm is truly mild compared to what you need.  You're simply too weary from struggling to give yourself the masturbation you truly need, but you continue to try.  Nearly an hour later " + sMultiCockDesc() + " softens enough to allow you to stand again, and you make your way back to camp, still dragging your genitals across the warm sand.", false);
	stats(0,0,0,0,0,0,25+rand(player.cor/5),0,false);
	fatigue(5);
	doNext(13);
}

//[FOREST]
//[RANDOM SCENE IF CHARACTER HAS AT LEAST ONE COCK LARGER THAN THEIR HEIGHT, AND THE TOTAL COMBINED WIDTH OF ALL THEIR COCKS IS TWELVE INCHES OR GREATER]
function bigJunkForestScene(lake:Boolean = false):void {
	outputText("", true);
	var x:Number = player.longestCock();

	//PARAGRAPH 1
	outputText("Walking along the ", false);
	if(lake) outputText("grassy and muddy shores of the lake", false);
	else outputText("various paths of the forest", false);
	outputText(", you find yourself increasingly impeded by the bulk of your " + cockDescript(x) + " dragging along the ", false);
	if(lake) outputText("wet ground behind you.", false);
	else outputText("earth behind you.", false);
	if(player.cocks.length == 1) {
		if(lake) outputText("  As it drags through the lakeside mud, the sensation forces you to imagine the velvety folds of a monstrous pussy sliding along the head of your " + Appearance.cockNoun(player.cocks[x].cockType) + ", gently attempting to suck it off.", false);
		else outputText("  As it drags across the grass, twigs, and exposed tree roots, the sensation forces you to imagine the fingers of a giant hand sliding along the head of your " + Appearance.cockNoun(player.cocks[x].cockType) +", gently jerking it off.", false);
	}
	else if (player.cocks.length >= 2) {
		if(lake) outputText("  With all of your " + multiCockDescriptLight() + " dragging through the mud, they begin feeling as if the lips of " + num2Text(player.cockTotal()) + " different cunts were slobbering over each one.", false);
		else outputText("  With all of your " + multiCockDescriptLight() + " dragging across the grass, twigs, and exposed tree roots, they begin feeling as if the rough fingers of " + num2Text(player.cockTotal()) + " different monstrous hands were sliding over each shaft, gently jerking them off.", false);
	}
	outputText("\n\n", false);

	//PARAGRAPH 2
	//FOR NON-CENTAURS]
	if(!player.isTaur())
	{
		outputText("The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your " + multiCockDescriptLight() + ", which forces your torso to the ground.  Normally your erection would merely raise itself skyward, but your genitals have grown too large and heavy for your " + hipDescript() + " to hold them aloft.  Instead, you feel your body forcibly pivoting at the hips until your torso is compelled to rest face down atop your " + multiCockDescriptLight() + ".", false);
		//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
		if(player.biggestTitSize() >= 35) {
			if(lake) outputText("  Your " + chestDesc() + " hang lewdly off your torso to rest in the lakeside mud, covering much of the ground to either side of you.  Their immense weight anchors your body, further preventing your torso from lifting itself up.  Mud cakes against their undersides and coats your " + nippleDescript(0) + "s.", false);
			else outputText("  Your " + chestDesc() + " hang lewdly off your torso to rest on the twings and dirt, covering up much of the ground to either side of you.  Their immense weight anchors your body, further preventing your torso from lifting itself up.  The rough texture of the bark on various tree roots teases your " + nippleDescript(0) + "s mercilessly.", false);
		}
		//IF CHARACTER HAS A BALLS ADD SENTENCE
		if(player.balls > 0) {
			outputText("  Your " + player.skinTone + sackDescript() + " rests beneath your raised " + buttDescript() + ".  Your " + ballsDescriptLight() + " pulse with the need to release their sperm through your " + multiCockDescriptLight() + " and ", false);
			if(lake) outputText("into the waters of the nearby lake.", false);
			else outputText("onto the fertile soil of the forest.", false);
		}
		//IF CHARACTER HAS A VAGINA ADD SENTENCE
		if(player.vaginas.length >= 1)
		{
			outputText("  Your " + vaginaDescript() + " and " + clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + buttDescript() + " above.", false);
			//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
			if(player.vaginas[0].vaginalWetness >= 4) {
				outputText("  Juices stream from your womanhood and begin pooling on the dirt and twigs beneath you.  ", false);
				if(lake) outputText("The drooling fem-spunk only makes the ground more muddy.", false);
				else outputText("The sticky fem-spunk immediately soaks down into the rich soil.", false);
			}
		}
	}
	//FOR CENTAURS
	else if(player.lowerBody == 4)
	{
		outputText("  The impending erection can't seem to be stopped.  Your sexual frustration forces stiffness into your " + multiCockDescriptLight() + ", which forces the barrel of your horse-like torso to the ground.  Normally your erection would merely hover above the ground in between your centaurian legs, but your genitals have grown too large and heavy for your " + hipDescript() + " to hold them aloft.  Instead, you feel your body forcibly pulled down at your hind legs until your equine body is resting on top of your " + multiCockDescriptLight() + ".", false);
		//IF CHARACTER HAS GIANT BREASTS ADD SENTENCE
		if(player.biggestTitSize() >= 35) {
			if(lake) outputText("  Your " + chestDesc() + " pull your human torso forward until it also is forced to face the ground, obscured as it is in boob-flesh.  Your tits rest on the wet earth to either side of you.  Their immense weight anchors you, further preventing any part of your equine body from lifting itself up.  Mud cakes their undersides and coats your " + nippleDescript(0) + "s.", false);
			else outputText("  Your " + chestDesc() + " pull your human torso forward until it also is forced to face the ground, obscured as it is in boob-flesh.  Your tits rest on the dirt and twigs to either side of you.  Their immense weight anchors you, further preventing any part of your equine body from lifting itself up.  The rough texture of the bark on various tree roots teases your " + nippleDescript(0) + "s mercilessly.", false);
		}
		//IF CHARACTER HAS A BALLS ADD SENTENCE
		if(player.balls > 0) {
			outputText("  Your " + player.skinTone + sackDescript() + " rests beneath your raised " + buttDescript() + ".  Your " + ballsDescriptLight() + " pulse with the need to release their sperm through your " + multiCockDescriptLight() + " and ", false);
			if(lake) outputText("into the waters of the nearby lake.", false);
			else outputText("onto the fertile soil of the forest floor.", false);
		}
		//IF CHARACTER HAS A VAGINA ADD SENTENCE
		if(player.vaginas.length >= 1)
		{
			outputText("  Your " + vaginaDescript() + " and " + clitDescript() + " are thoroughly squashed between the bulky flesh where your male genitals protrude from between your hips and the " + buttDescript() + " above.", false);
			//IF CHARACTER HAS A DROOLING PUSSY ADD SENTENCE
			if(player.vaginas[0].vaginalWetness >= 4) {
				if(lake) outputText("  A leaf falls from a tree and lands on the wet lips of your cunt, its light touch teasing your sensitive skin.  Like a mare or cow in heat, your juices stream from your womanhood and pool in the mud beneath you.  The sloppy fem-spunk only makes the ground more muddy.", false);
				else outputText("  A leaf falls from a tree and lands on the wet lips of your cunt, its light touch teasing your sensitive skin.  Like a mare or cow in heat, your juices stream from your womanhood and pool in the dirt and twigs beneath you.", false);
			}
		}
	}
	outputText("\n\n", false);
	//PARAGRAPH 3
	outputText("You realize you are effectively trapped here by your own body.", false);
	//CORRUPTION BASED CHARACTER'S VIEW OF SITUATION
	if(player.cor < 33) outputText("  Panic slips into your heart as you realize that if any dangerous predator were to find you in this state, you'd be completely defenseless.  You must find a way to regain your mobility immediately!", false); 
	else if(player.cor < 66) outputText("  You realize that if any dangerous predator were to find you in this state, you'd be completely defenseless!  You must find a way to regain your mobility... yet there is a certain appeal to imagining how pleasurable it would be for a sexual predator to take advantage of your obscene body.", false); 
	else outputText("  Your endowments have rendered you completely helpless should any predators find you.  Somewhere in your heart, you find this prospect almost exhilarating.  The idea of being a helpless fucktoy for a wandering beast is unusually inviting to you.  Were it not for the thought that you might starve to death, you'd be incredibly tempted to remain right where you are.", false);
	
	
	if(lake) {
		//SCENE END = IF CHARACTER HAS FULL WINGS ADD SENTENCE
		if(player.canFly()) outputText("  You extend your wings and flap as hard as you can until at last, you manage to lighten the bulk of your body.  It helps just enough to let you drag your genitals out of the mud and back to camp.  The ordeal takes nearly an hour for you to return and deal with.", false);
		//Taurs
		else if(player.lowerBody == 4) outputText("  You struggle and work your equine legs against the wet ground.  Your " + player.feet() + " have consistent trouble finding footing as the mud fails to provide enough leverage to lift your bulk.  You breath in deeply and lean side to side, trying to find some easier vertical leverage beneath your feet.  Eventually, with a crude crawl, your centaur legs manages to push the bulk of your body onto more solid ground.  With great difficulty, you spend the next hour shuffling your genitals back to camp.", false);
		//SCENE END = FOR ALL OTHER CHARACTERS
		else outputText("  You struggle and push with your " + player.legs() + " as hard as you can, but it's no use.  You do the only thing you can and begin stroking your " + multiCockDescriptLight() + " with as much vigor as you can muster.  Eventually, your body tenses and a light load of jizz erupts from your body, but the orgasm is truly mild compared to what you need.  You're far too weary from struggling to give yourself the masturbation you truly need, but you continue to try.  Nearly an hour later, " + sMultiCockDesc() + " has softened enough to allow you to stand again, and you make your way back to camp, still dragging your genitals through the mud.", false);
	}
	else {
		//SCENE END = IF CHARACTER HAS FULL WINGS ADD SENTENCE
		if(player.canFly()) outputText("  You extend your wings and flap as hard as you can, until at last, you manage to lighten the bulk of your body.  It helps just enough to let you drag your genitals out of the forest and back to camp.  The ordeal takes nearly an hour for you to return and deal with.", false);
		//SCENE END IF CHARACTER HAS CENTAUR BODY
		else if(player.lowerBody == 4) outputText("  You struggle and work your equine legs against the soft dirt.  Your " + player.feet() + " have consistent trouble finding footing as the ground fails to provide enough leverage to lift your bulk.  You breath in deeply and lean side to side, until eventually, your feet brace against the various roots of the trees around you.  With a crude crawl, your centaur legs manage to shuffle your body and genitals out of the forest and back to camp.", false);
		//SCENE END = FOR ALL OTHER CHARACTERS
		else outputText("  You struggle and push with your " + player.legs() + " as hard as you can, but it's no use.  You do the only thing you can and begin stroking your " + multiCockDescriptLight() + " with as much vigor as you can muster.  Eventually, your body tenses and a light load of jizz erupts from your loins, but the orgasm is truly mild compared to what you need.  You're far too weary from struggling to give yourself the masturbation you truly need, but you continue to try.  Nearly an hour later, " + sMultiCockDesc() + " has softened enough to allow you to stand again, and you make your way back to camp, still dragging your genitals across the forest floor.", false);
	}
	stats(0,0,0,0,0,0,25+rand(player.cor/5),0,false);
	fatigue(5);
	doNext(13);
}



//Just want to do a quick Ottergirl event submission after you mentioned it!
function ottahGirl():void {
	clearOutput();
	flags[MET_OTTERGIRL]++;
	//First Time
	if(flags[MET_OTTERGIRL] == 1) {
		outputText("Your exploration of the lakeside take you further than you've gone before.  The water here is almost completely still, its waters ");
		if(player.hasStatusAffect("FactoryOverload") < 0) outputText("crystal clear, giving you a stunning view of the lakebed");
		else outputText("only slightly clouded, giving you an obscured view of the lakebed");
		outputText(".  Fish dart to and fro within the waters, caring little for your explorations above the waves.");
		
		outputText("\n\nYou watch the fish for a few minutes until you notice that you're not alone on the shoreline. Further down the sandy beaches sits a solitary, feminine figure, her legs parted and arched.  A fishing rod is held lazily in her hands.  You trace the fishing line with your eyes, seeing a little piece of flotsam bobbing up and down a fair distance into the water.");
		
		outputText("\n\nYou decide to approach this figure, who notices your advance. You spot her subtly shift her position, as though she's readying her body to bolt if you turn out to be hostile.  But still, she lets you approach.  The closer you get, the more of her features you can make out.  Her skin appears to be covered with damp, brown fur.  A long, thick tail sticks out from behind her, at least as wide-around as her leg, narrowing down into a rounded tip.  A short mop of sun bleached blonde hair, barely reaching down to her chin, frames a human-like face with a cute, upturned button nose. Her body, which is lithe and toned like that of a champion swimmer, is covered only by a two-piece bikini.  Her chest is surprisingly small, perhaps only A-cups, though she looks physically mature.  Identifying this person as an otter-girl, you'd guess larger breasts would make it harder to swim.");
		
		outputText("\n\nYou stop a few feet away from her. She gives you a friendly smile.  \"<i>Well hey there, friend. You don't smell like one of them demon fellers,</i>\" she says with a light accent, reminding you of the farmers' daughters back in Ingnam. Her eyes travel up and down your body.  \"<i>So,</i>\" she says cheerfully, \"<i>you wanna fish'n'fuck?</i>\"");
		
		outputText("\n\nYou can't help your eyebrow from quirking upwards.  What did she say?");
		
		outputText("\n\n\"<i>Fish'n'fuck,</i>\" she replies, simply.  \"<i>I fish, you fuck. Ya ain't dense, are you " + player.mf("boy","girl") + "?</i>\"");
		
		outputText("\n\nThat's it?  She doesn't even know you and she's just offering it up like that?");
		//Silly Mode: 
		if(silly()) outputText("  No tragic backstory to go through? No annoying combat encounter? Just meet and fuck?  My god, what has this world come to?");
		outputText("  You don't even know her name!");
		
		outputText("\n\n\"<i>Name's Callu.  Don't worry darlin', I don't plan on stickin' nothin' where it don't belong,</i>\" her soft voice chimes, \"<i>Unlike damn near everything else around here.</i>\"");
		
		outputText("\n\nWell, how about it?");
		
		//[Facesitting] [Fuck Her] [Skedaddle]
	}
	//Repeats
	else {
		outputText("Your explorations of the lake lead you back to Callu, the otter girl. She sits lazily on the beach; fishing rod in hand, as usual. She gives a friendly wave as you approach, and pats the sandy patch of lakeside next to her.");
		outputText("\n\n\"<i>Well ain't you a sight for sore eyes.</i>\"  You sit down next to her and relax, just sitting and watching the makeshift bobber tip and sway in the water.  \"<i>You up for a fish'n'fuck then?</i>\" she asks suddenly, brushing a strand of her sun bleached blonde hair out of her face.");
		
		outputText("\n\nWell, are you?");
		
		
		//[Facesitting] [Fuck Her] [Fish] [Skedaddle]
	}
	menu();
	if(player.lust < 33) outputText("\n\nYou aren't aroused enough to fuck her.");
	else {
		//(If cocksize above 48") 
		if(player.hasCock()) {
			if(player.shortestCockLength() > 48) outputText("\n\nUnfortunately, you don't think she can quite handle your cock.");
			else addButton(0,"Fuck Her",ottergirlLikesDongs);
		}
		if(player.hasVagina() || !player.hasCock()) addButton(1,"Facesitting",ottersForGals);
	}
	if(flags[MET_OTTERGIRL] > 1) addButton(2,"Get Fish",getSomeFishYaFatty);
	addButton(4,"Leave",avoidZeOtterPussy);
}

//For Dicks
function ottergirlLikesDongs():void {
	clearOutput();
	outputText("The moment you agree, a sly smile spreads across her face.  She jams the end of her fishing pole into the sand like a post, to prevent it from going anywhere, and stands up.  There's no tease, no ceremony as she strips out of her bikini bottoms and tosses them aside.  Her newly revealed mound has only the barest tuft of pubic hair, a little wisp of blonde hair amongst the sparse brown fur.");
	
	outputText("\n\nYou move forward, intent on groping Callu's little breasts still hidden beneath the bikini top, but she holds up a hand and says, \"<i>Whoa there darlin', that ain't how a fish'n'fuck works.  You just lay down, and I'll take care of everything. And make sure you're as naked as a newborn babe.</i>\"");
	
	outputText("\n\nStrange, but you oblige, stripping off your [armor] and gear and tossing them aside. Callu instructs you to lay down on the beach next to her fishing pole, which you likewise oblige.  The otter-girl straddles your stomach, facing away from you, though her thick, heavy tail is thankfully kept away from your face.");
	var x:int = -1;
	var y:int = -1;
	temp = 0;
	while(temp < player.cockTotal()) {
		if(player.cocks[temp].cockLength < 48) {
			if(y < 0) y = temp;
			else if(player.cocks[temp].cockLength > player.cocks[y].cockLength) y = temp;
		}
		temp++;
	}
	if(y < 0) y = player.smallestCockIndex();
	x = y;
	
	//(Under 6")
	if(player.cocks[x].cockLength < 6) outputText("\n\n\"<i>Well butter my buns and call me a biscuit, ain't this a cute little thing,</i>\" she remarks, inspecting your tiny cock.  \"<i>I ain't never seen one this small.  I just wanna wrap it up in a little bow and cuddle with it.  You sure it ain't a clit, darlin'?</i>\"");
	//(6"-10")
	else if(player.cocks[x].cockLength < 10) outputText("\n\n\"<i>Just packin' the average model, eh?  Nothin' wrong with that,</i>\" she remarks while inspecting your cock.");
	//(10"-24")
	else if(player.cocks[x].cockLength < 24) outputText("\n\n\"<i>Oh my, now that's a manly piece of meat right there,</i>\" she remarks, inspecting your oversized cock.  \"<i>I could enjoy that bad boy all day.</i>\"");
	//(24"-48")
	else outputText("\n\n\"<i>Whoa nellie,</i>\" she says, her eyes going wide as they feast upon your giant cock.  \"<i>That.  That right there, darlin', is one grade-A trouser snake.  I've seen centaurs that'd look like geldings next to you.</i>\"");
	outputText("  She leisurely stretches out across your stomach and chest, letting her cunt come to rest right in front of your face.");
	
	outputText("\n\nYou feel slender but powerful fingers wrap around your cock, followed shortly after by a pair of lips. They encircle your " + cockHead(x) + " and suck, creating a delightful tingling sensation that travel down your cock and into your core.");
	
	outputText("\n\n\"<i>Hey darlin', better get to lickin', we want this ");
	//{(lil dicks)
	if(player.cocks[x].cockLength < 6) outputText("little, wanna-be cock");
	else outputText("bad boy");
	outputText(" to slip right in, don't we?</i>\"  Callu murrs back at you.  You most certainly do, so you lean your head forward ever-so-slightly, extending your tongue and lapping at her delicate pussy lips.  In no time at all they become puffy and flushed, blossoming outwards like a perverse flower.  You run your tongue up and down each and every fold, occasionally stopping to flick over her rapidly hardening clitoris.");
	
	outputText("\n\nLikewise, her tongue and lips dance over your " + cockDescript(x) + " like a trio of dancers. They spin, twist, hop and tease, ensuring that no inch is left untouched.");
	outputText("  She pays particularly close attention ");
	
	
	//[equine]
	if(player.cocks[x].cockType == CockTypesEnum.HORSE) outputText("to your flare, sucking, teasing and ");
	//[canine]
	else if(player.hasKnot(x)) outputText("to the base of your cock, planting sloppy kisses on your knot, ");
	//[demonic]
	else if(player.cocks[x].cockType == CockTypesEnum.DEMON) outputText("to the demonic nodules ringing your cock, ");
	//[anemone]
	else if(player.cocks[x].cockType == CockTypesEnum.ANEMONE) outputText("to the little wriggling tentacles ringing the head and base of your cock, ");
	else outputText("to the sensitive little spot on the underside of the head, ");
	outputText("lavishing it with attention.  Precum and saliva practically pour down the length of your shaft, tickling your ");
	if(player.balls > 0 && player.hasVagina()) outputText("balls and cunt");
	else if(player.balls > 0) outputText("balls");
	else if(player.hasVagina()) outputText("cunt");
	else outputText("ass");
	outputText(" as they dribble down and form a small puddle between your [legs].");

	outputText("\n\nAfter several minutes of this, Callu relinquishes her hold on your member and says, \"<i>Mm, I reckon that'll work just fine.</i>\"  She sits up and positions herself over your " + cockDescript(x) + ".  Slowly she lowers herself, first taking your " + cockHead(x) + ".  Her cunt, slick and aroused as it is, offers no resistance despite its tightness.  Its walls pulse and quiver around you, as though the otter has complete control over it.  Inch by inch she sinks down further, ");
	//(dicks 10" or less)
	if(player.cocks[x].cockLength < 10) outputText("until she comes to rest on your lap");
	//(10"-24")
	else if(player.cocks[x].cockLength < 24) outputText("slowly devouring your entire cock, until she finally comes to rest on your lap");
	else outputText("an excruciatingly long process as feet worth of hard cockmeat disappear into her snatch. There's a small moment of resistance, followed by a soft squelch and a sudden \"<i>Oooh</i>\" from Callu.  With no small amount of trepidation, you realize you've just penetrated into her womb.  You can't tell from the way she's facing, but you're certain her stomach has to be bulging outwards at this point");
	outputText(".");
	
	outputText("\n\nWith your entire ");
	if(player.cocks[x].cockThickness >= 3) outputText("impressive ");
	outputText("girth within her she settles down on your lap, stretching her legs out before retrieving her fishing rod.  \"<i>Now don't you go movin' about, darlin',</i>\" Callu says over her shoulder.  \"<i>Don't wanna go scarin' the fish away.  I'll let ya go after I catch a few good ones.</i>\"");
	
	outputText("\n\nSurprisingly, you can still feel a throbbing around your " + cockDescript(x) + ", reaffirming your belief that she can somehow control the muscles buried within her abdomen.  Even as you lay stock-still on the sandy beach, you feel the sensation of thrusting, as though you were actively fucking this little slut sitting atop you.  The feeling is extremely pleasant, not to mention a little hypnotic.  You reach your hands up to grasp Callu's hips lightly.  She doesn't seem to mind, though as you start squeezing her in time with your phantom thrusts a quick swat to your hand lets you know that you're crossing an unspoken boundary.");
	
	outputText("\n\nWith nothing else to do, you close your eyes and relax.  The rhythmic pulsing of this otter-girl's tight pussy seems to deepen your relaxation, though your dick remains as hard as it's ever been. Minutes pass, and the thrusting sensation doesn't appear to be dying down.");
	
	outputText("\n\nA sudden, strange high-pitched sound suddenly rings out and your head bolts upright, only to see Callu reeling in a fish.  She looks it over, nods once to herself and tucks it away in an ice chest cleverly buried under the sand right next to the two of you.  Afterwards she stands up, letting your dick fall out of her.  Your " + cockDescript(x) + " feels strange, and uncomfortably naked somehow, especially as a cool wind blows over its saliva and femcum-covered skin.");
	
	outputText("\n\nIt doesn't have to suffer long, at least, as Callu casts a new line and positions herself over your cock once more. Inch by delicious inch sinks into her, making you shiver all over.  However, this time she doesn't sit all the way down.  Instead she straddles your waist, standing on the balls of her feet.  The now-familiar pulsing returns, but in addition she gyrates her hips, circling them around and around.  With each rotation it feels as though your cock is being squeezed tighter and tighter, but this time you can't simply relax and close your eyes, not with that captivating bubble butt swaying in front of your face.");
	
	outputText("\n\nHer rear swings and swivels, spins and pirouettes, but the entire time her focus on the fishing line remains constant.  It's as if you're a side-note to her day; as though sex like this, with such mind-blowing sensations, was an everyday occurrence.  The movement of her hips intensifies, as does the pulsing within that sweet, hot snatch.  In no time at all your vision begins to go hazy, your body tensing as it's wracked with pleasurable, orgasmic electricity.");
	
	outputText("\n\nYour body arches, thrusting your cock fully inside Callu, your hips meeting with a lewd, wet smack.  Your cock jerks, spurting jet after jet of seed into the otter-girl's greedy cunt.");
	//(Cum quantity high enough)
	if(player.cumQ() >= 250) {
		outputText("  There's so much of it, ");
		if(player.cumQ() < 500) outputText("some of it begins to dribble down your cock, forming a puddle right under your ass cheeks");
		else if(player.cumQ() < 1000) outputText("it begins to spray out of the edges of your cock, like water coming out of a blocked faucet");
		else if(player.cumQ() < 2000) outputText("Callu's stomach begins to visibly inflate, even from your point of view");
		else outputText("Callu's stomach inflates to a huge degree. She suddenly looks to be about eight months pregnant, though she doesn't seem bothered by this in the least");
		outputText(".");
	}
	outputText("  Her womb greedily takes everything it can, until you fall back onto the ground, exhausted.");
	
	outputText("\n\nTo your surprise, Callu simply picks up where she left off");
	if(player.cumQ() >= 2000) outputText(", despite the huge belly she now sports");
	outputText(".  Gyrations, thrusts and the constant cadence of her cunt work together to keep you unbearably hard.  Apparently she's not satisfied.");

	outputText("\n\nIt takes at least three more orgasms and seven caught fish before Callu relaxes; securing her fishing rod and setting it aside.  She lays backwards, pressing her back into your stomach and chest, and swivels her head to kiss you on the lips.  \"<i>Mmmm, you're such a good sport darlin',</i>\" she murrs, still clenching down on your cock.  \"<i>I ain't never had a fish'n'fuck like you before.</i>\"  The fisherwoman moves to stand up, and ");
	if(player.hasKnot(x)) outputText("fails, held fast by the knot tying the two of you together. She looks at you in surprise, but eventually smiles and leans back down. The two of you cuddle for half an hour, until your knot deflates enough to let her *pop* off of it. She stands and ");
	outputText("slips her bikini bottoms into a canvas bag.");
	
	outputText("\n\nFrom the same bag she pulls out a delicious smelling piece of cooked fish, wrapped in a large green leaf.  She hands it to you, saying simply, \"<i>Fish and a fuck, darlin'.  I got mine and you get yours.</i>\"  You nod absently, taking the piece of wrapped fish.  Callu gives your rapidly limpening cock a little pat on the head, before gathering up her things and heading off down the beach, leaving behind a trail of cum and other love juices.");
	
	outputText("\n\nYou take a minute to recover before doing the same.  ");
	stats(0,0,0,0,0,-1,-100,0);
	menuLoc = 2;
	shortName = "FishFil";
	takeItem();
}

//For Chicks
function ottersForGals():void {
	clearOutput();
	outputText("The moment you agree, a sly smile spreads across her face.  She jams the end of her fishing pole into the sand like a post, to prevent it from going anywhere, and stands up.  There's no tease, no ceremony as she strips out of her bikini bottoms and tosses them aside.  Her newly revealed mound has only the barest tuft of pubic hair, a little wisp of blonde hair amongst the sparse brown fur.");
	
	outputText("\n\nYou move forward, intent on groping Callu's little breasts still hidden beneath the bikini top, but she holds up a hand and says, \"<i>Whoa there darlin', that ain't how a fish'n'fuck works.  You just lay down, and I'll take care of everything. And make sure you're as naked as a newborn babe.</i>\"");
	
	outputText("\n\nStrange, but you oblige, stripping off your [armor] and gear and tossing them aside.  Callu instructs you to lay down on the beach next to her fishing pole, which you likewise oblige.  The otter-girl straddles your stomach, facing away from you, though her thick, heavy tail is thankfully kept away from your face.");
	
	outputText("\n\nCallu leans down, laying her body across yours so that her warm, sweet-smelling cunt is positioned just in front of your face.  Meanwhile, you feel delicate, powerful fingers probing at your [vagOrAss].  A long wet tongue licks over your ");
	if(player.hasVagina()) outputText("folds");
	else outputText("pucker");
	outputText(", and you feel compelled to do the same to her.  You let your tongue extend and lap at her delicate pussy lips.  In no time at all, they become puffy and flushed, blossoming outwards like a perverse flower.  You run your tongue up and down each and every fold, occasionally stopping to flick your tongue over her rapidly hardening clitoris.");
	
	outputText("\n\nLikewise, her tongue and lips dance across your flesh like a trio of dancers.  They twirl, spin, hop and tease.  Not one inch is left untouched.  From your ");
	if(player.hasVagina()) outputText("clit");
	else outputText("unnatural bare crotch");
	outputText(" down to your pucker, she leaves a trail of sloppy smooches.  You mirror her movements, attempting to give her the same experience she's giving you.  A low murr escapes her lips, and she squirms above you slightly as your tongue hits the right spots.");
	
	outputText("\n\nAfter several minutes of this tasty sixty-nine Callu gives your mound one last kiss and sits up, practically burying your face in her snatch.  \"<i>Ya'll just sit tight and put that tongue to work, kay?  Key ingredient in a fish'n'fuck, is of course, the fish.</i>\"  You voice your disapproval, though all that comes out is a garbled \"<i>mmmrrrrppphh.</i>\"  Callu ignores your protests, instead retrieving her fishing pole and sitting back further, pressing herself even harder against your face.  With her fantastic behind blocking your view, you can't see anything that's going on, and are only able to hear the quiet \"<i>tick-tick</i>\" of her fishing pole.");
	
	outputText("\n\nYou know full well that you could get out of this if you wanted to, however the scent of the girl's musky mustelid muff is just too powerful, too intoxicating, too heavenly to ignore.  Instead of struggling you go to town, rubbing your face in it as you lick, slurp and suck at the lips pressed against your mouth.  Up and down your tongue goes, in and out, teasing her soft, swollen lips and pressing hard against her hard, aching clit as you gorge yourself on her pussy.");
	
	//(Demonic tongue)
	if(player.tongueType == 2) outputText("\n\nYou extend your abnormal tongue, plunging it deep into Callu's depths. This actually elicits a little squeak from the fisherwoman, who shifts from side to side in shock.  You let your tongue push further in, as if it were a cock.  Spreading her as you delve deep, you taste the otter from the inside out, reveling in the taste of her sweet, tight hole.  Eventually your tongue comes to an obstruction, a tight ring that bars your way forward.  You grin, or at least try as hard as you can to do so, what with the weight of an otter-girl sitting on your face and 12 inches of tongue sticking out of your mouth.  The tip of your tongue whirls around her cervix before finding the center and slowly pushing inside.  Another \"<i>eep</i>\" arises from Callu, though this one turns into a contented sigh.  With the tip of your tongue in her womb, you begin to slather her walls with saliva.  Every tender flick of your tongue makes the girl riding your face shiver with pleasure.  All good things must come to an end, however, and your tongue eventually gets so tired you have no choice but to draw it back in.");
	
	outputText("\n\nThis goes on for the better part of an hour.  You find yourself hunting for the little spots that make your sexy little friend jump and squeal, all while she reels in fish after fish.  Several orgasms, half a dozen fish and one extremely messy face later, you hear Callu reel in her line for the last time before setting it off to the side with a clatter.  She rises from your face, allowing you to breathe the fresh air once more.");
	
	outputText("\n\nGrinning down at you, your face plastered in girlcum, the fisherwoman leans down and gives you a great big kiss.  \"<i>Mmm, ain't that a tasty treat,</i>\" she notes.  \"<i>Now since ya been so good to me, I just wanna return the favor.</i>\"  Callu gets back in the sixty-nine position that started this all off, but grabs hold of you and flips over onto her back.");
	
	outputText("\n\nYou sit up, straddling her face this time, as she dives nose first into your ");
	if(player.hasVagina()) outputText("quivering quim");
	else outputText("rump");
	outputText(".  Her lips are like magic as they go, sucking and lavishing your entire crotch with delightful attention.  You find your entire body shivering with pleasure as she attends to you, your body quickly heating up as her tongue presses all of your buttons.  Everything from your fingertips down to your toes tingles and shudders under Callu's ministrations, leaving you squirming and undulating on her face, a deeply satisfied growl rising in your throat.");
	
	outputText("\n\nGrabbing hold of your [nipples], you start playing with them while Callu does her thing.  Your fingers deftly tweak and tease them, knowing all the right techniques to really get you going.  ");
	if(player.hasFuckableNipples()) outputText("You even slip a finger or two inside, stretching your nipple-cunts out with deliciously pleasurable results.  ");
	outputText("Combined with Callu's tender tongue ");
	if(player.hasVagina()) outputText("paying lip service to your wet cunt");
	else outputText("doing a cave dive in your rear");
	outputText(", you can't hold out much longer.  All the tingling in your body seems to get forced through your veins, coalescing in a single spot within your groin.  The pressure builds and builds as orgasmic energies begin overflowing.  Your legs and arms tremble, your head wobbles uncertainly, and you can't even guess at what your spine is attempting to do.");
	
	outputText("\n\nThe pleasure within you finally bursts outwards, shooting through every nerve, inflaming every fiber of your being.  ");
	if(player.hasVagina()) outputText("Your snatch clenches and clamps down on thin air, flooding Callu's face with your feminine juices in a tasty, refreshing spray.");
	else outputText("Your asshole clenches and spasms randomly, aching to be filled by something, anything in your quest for release.");
	outputText("  The orgasmic bliss makes you collapse forwards, dropping you onto all fours. However, your blonde lover grips your thighs firmly, clearly intent on fully repaying her debt.");
	
	outputText("\n\nSeveral orgasms later, you're little more than a quivering mass of flesh riding atop the fisherwoman's face.  She wriggles out from underneath you and licks her lips, happy to guzzle down the last of your juices.  Callu gives your back a little rub down, saying, \"<i>Well that sure was a refreshing break, darlin'.</i>\"  You can only groan in response, your body too sore from back-to-back orgasms to really form any kind of coherent response.");
	
	outputText("\n\nThe blonde otter sets all her gear up in one pile, and tucks away her bikini bottoms into a canvas bag.  From the same bag she pulls out a delicious smelling piece of cooked fish, wrapped in a large green leaf.  She sets it beside your still-trembling body, saying simply, \"<i>Fish and a fuck, darlin'.  I got mine and you get yours.</i>\"  You nod absently, reaching out to touch the wrapped up piece of fish.  Callu gives your back another quick rub down, before gathering up her things and heading off down the beach, completely naked from the belly down.");
	
	outputText("\n\nYou take several minutes to recover before doing the same.  ");
	
	stats(0,0,0,0,0,-1,-100,0);
	menuLoc = 2;
	shortName = "FishFil";
	takeItem();
}

//For Pansies
function avoidZeOtterPussy():void {
	clearOutput();
	outputText("You shake your head and explain you can't.  She simply shrugs, \"<i>Ain't no skin off my back.</i>\"");
	
	outputText("\n\nThe two of you sit in silence for a little while.  It doesn't feel like an awkward silence, just a serene, relaxing void of noise.  The gentle lapping of the water almost puts you to sleep.  Eventually, you stand, say your goodbyes and leave.  As you're leaving, Callu shouts, \"<i>Come round any time, ya hear?</i>\"  You nod absently, then make your way back to camp.");
	doNext(13);
}

//For Fatties
function getSomeFishYaFatty():void {
	clearOutput();
	outputText("You tell Callu you're a little more interested in the fish than the fuck, at least for today.  She shrugs once before jamming the end of her fishing pole into the sand like a post and turning towards her pack.");
	
	outputText("\n\nShe retrieves a delicious-smelling slab of roasted fish, properly salted and wrapped in a large green leaf.  \"<i>Here ya're, fresh as it comes 'less you want it still walkin' and talkin'.</i>\"");
	
	outputText("\n\nYou thank Callu for the food and take your leave.  ");
	
	//(You have gained Fish Fillet!)
	menuLoc = 2;
	shortName = "FishFil";
	takeItem();
}

//addButton(0,"Join",joinBeingAMinoCumSlut);
function joinBeingAMinoCumSlut():void {
	clearOutput();
	outputText("The prospect of getting a huge dose of that fresh minotaur cum is just too much to bear.  Before you realize what's happening, you're moving out of your rocky hiding spot and making your way down to the two bovine creatures, stripping your [armor] as you go.  By the time you reach the two figures, you're as naked as they are.  You shiver softly, whether due to some chill in the air or desperate anticipation, you can't say.");
	outputText("\n\nThe cow-girl is bent over, her hands on a low ledge with the minotaurs hands on either side of her ample ass.  She moans, more like a moo than a human groan, as the minotaur plunges into her quaking depths.  As you step forward, suddenly unsure of yourself, both the bull and the cow turn their sharp gazes on to you.  You feel very small");
	if(player.tallness <= 96) outputText(" despite your immense height");
	outputText(" as they look you up and down.  The entire area goes silent, even the goblins and the imps that are no doubt watching seem to be holding their breath, wondering what will happen to you.");
	outputText("\n\nThe minotaur grunts, finally, as if he finds you acceptable, and turns back to the plush ass before him, plowing into it once more.  The cow-girl, however, motions for you to move forward, and latches onto a [nipple] when you do.  Her soft lips encircle your areola, while her tongue dances over the rapidly hardening flesh of your teat.  Your breasts tingle with the slightest bit of suction, making you gasp as small droplets of milk escape your nipple and roll over the cow-girl's tongue.  She sucks more and more, eagerly gulping down your refreshing lactic beverage.");
	
	outputText("\n\nAll the while the minotaur continues grunting, thrusting his massive member into the woman's hungry cunt.  The two rock back and forth, pushing her face right into your breast before pulling back again.  The cow-girl's legs tremble and you suddenly find her arm grasping your shoulder for support.  Her other hand drifts down between your own naked legs, ");
	if(player.hasCock()) {
		outputText("ignoring your cock");
		if(player.cockTotal() > 1) outputText("s");
		outputText(" entirely, ");
	}
	outputText("slipping a finger into your moistening ");
	if(player.hasVagina()) outputText("pussy");
	else outputText("asshole");
	outputText(".  A low moan escapes your lips as a second finger slips in while the busty bovine woman's thumb ");
	if(player.hasVagina()) outputText("swirls around your clitoris");
	else outputText("presses against your perineum");
	outputText(".");

	outputText("\n\nThe broad-shouldered minotaur urges his mate onto her knees while he does the same, his dick never leaving its temporary home.  The cow-girl pulls you along, bringing you to your knees and then onto your back.  You have a moment of sudden modesty as you fold your legs, trying to block your crotch from view.  The bovine woman simply chuckles in between moans and lightly presses your knees apart.  Your legs spread wide, lewdly showing off your nether region to the cow-girl, and anyone else that's watching.");
	
	outputText("\n\nWithout wasting any time, the girl leans down and");
	if(player.hasCock()) outputText(", once again ignoring your manhood completely");
	outputText(", dives tongue first into your wet ");
	if(player.hasVagina()) outputText("quim");
	else outputText("back door");
	outputText(".  The movement is so quick that you can't even suppress the sudden, perverted moan that leaves your lips... a moan that sounds shockingly like a cow's moo.  The surprise at your sudden bovine outburst quickly dissipates as the cow-girl's large tongue dips in and out of your ");
	if(player.hasVagina()) outputText("sodden box");
	else outputText("moist butthole");
	outputText(".  Any remaining fears of joining this very public sex show are gone, and you wonder why you didn't join in sooner.");

	outputText("\n\nThe tongue lavishes your hole, paying homage to your crotch in the only way it knows how.  Your breath comes shorter while your arms and legs tingle, fingers and toes curling against your will.  The cow-girl laps and licks, her broad mouth muscle slipping in and out, curving in and around to hit every tender part of your insides.  You run your fingers through the woman's long red hair, forcing her head even deeper into your crotch.  With her head down like this, you have an easy view of her ass high up in the air, getting fucked senseless by the Minotaur.  Every thrust makes the cow-girl moan into your lap, the added vibrations causing you to squirm even more.");
	
	outputText("\n\nThe bull thrusts in to the hilt, letting out one final bellow of pleasure.  The cow-girl brings her head up, her mouth and chin slick and dripping with your juices.  She lets out a moo-like bellow along with the minotaur, whose balls churn, no doubt depositing a heavy load of that delicious cum directly into her waiting womb.  You lick your lips, wishing you could just wrap them around that cock right now, to get your fix and feel the blissful sensations of relief run across your body.");
	
	outputText("\n\nThe girl gibbers incoherently as she slides off the minotaur's still-rigid cock, a small spurt of pearly white spunk running down her thighs.  The minotaur smirks, smacking the cow's ass and casually pushing her to the side.  A goofy grin is plastered on her face, eyes rolled up into their sockets like she's just experienced the most divine fuck imaginable. He then looks you dead in the eyes and says, in a deep, masculine and very dominant voice, \"<i>You get to ride my cock next, cow.</i>\"");

	outputText("\n\nHis rough, strong hands grasp your legs and draw you closer.  You squirm half-heartedly, not really trying to get away.  Though your mind tries to fight it, you know all you really want is that warm, sticky cum inside you one way or another.  You want to be just like the half-unconscious girl beside you, stuffed with cock and turned into this rugged man's breeding bitch.");

	outputText("\n\n\"<i>Eager for a fucking, huh slut?</i>\" he taunts, his turgid member resting along your stomach.  You nod slowly.  You feel a deep burning in your core. You want that cock inside you.  You want to be filled to bursting with this bull's seed, to feel it churn ");
	if(player.hasVagina()) outputText("within your womb, knocked up by this manly beast");
	else outputText("within your bowels");
	outputText(".  \"<i>That's a good slut,</i>\" he grunts, pulling his cock off your belly and rubbing the slick, flat head against your awaiting [vagOrAss].  He teases you with the slight contact until you open your mouth to voice your complaints, then he suddenly thrusts inside.  Any words forming on your tongue fly away, replaced by a whine of relief as your hole gets stretched wide by the invading member.");
	if(player.hasVagina()) cuntChange(36,true,true,false);
	else buttChange(36,true,true,false);
	
	outputText("\n\n\"<i>Ahh, yeah.  That's some good ");
	if(player.hasVagina()) outputText("cow-pussy");
	else outputText("ass");
	outputText(" right there,</i>\" he groans.  More of his bombastic cock slipping deep inside you.  The minotaur hooks an arm under each of your knees, lifting up your lower body, pressing even deeper.  Powerful sensations drift up from your ");
	if(player.hasVagina()) outputText("g-spot");
	else outputText("prostate");
	outputText(" as the minotaur's wide flare strokes it through your ");
	if(player.hasVagina()) outputText("vaginal");
	else outputText("anal");
	outputText(" walls.  Biting your lip with barely contained pleasure, you bring your hands to your breasts, playing with your milk-sodden nipples in between each orgasmic thrust of the bull's hips.");

	outputText("\n\nA giggle comes from your side, as you see the cow-girl is back up onto her knees, having recovered from her exalted orgasm.  She crawls forward, kneeling just over your head and leaning in to kiss her minotaur lover.  The two whisper sweet nothings to each other, too vague and indistinct to hear, but it doesn't matter.  All you can focus on is the dick lodged firmly inside of you... that, and the soaking cunt of the cow-girl just inches from your face.  Alabaster droplets drip down her legs, one even landing on your lips.  Before you can stop yourself, you lick them clean, savoring the taste of the second-hand cum.");
	
	outputText("\n\nSome part of your mind voices a complaint at what comes next, a voice that's quickly squelched inside the addiction-fueled haze of your brain.  You pull your head upwards and extend your tongue, slurping a large glob of cum from the cow-girl's snatch.  There's a surprised yelp from above you, followed by a coo of pleasure.  To your surprise, the cow-girl actually lowers her cunt down onto your face, giggling madly, filling your nostrils with the scent of her muff, with the scent of recent sex.  Not letting this opportunity go to waste, you repay her actions from earlier, slipping your ");
	if(player.tongueType == 1) outputText("serpentine ");
	else if(player.tongueType == 2) outputText("demonic ");
	else if(player.tongueType == 3) outputText("draconic ");
	outputText("tongue inside her, eagerly licking out and guzzling down the remnants of the minotaur's present.");

	outputText("\n\nThe minotaur, for his part, is in no rush to give you a cream pie of your own. His thrusts are slow and deliberate, with a rhythm that has you writhing with pleasure.  The three of you moan together like some kind of erotic pyramid.  The bull's assault on your ");
	if(player.hasVagina()) outputText("womb");
	else outputText("back door");
	outputText(" increases slowly, and you can feel your limbs tingling at the prospect of your mino-cum-induced orgasm.");

	outputText("\n\nIt starts in your fingers, where your nerves seethe, gathering up fistfuls of grass like one might grab a sheet.  The heat continues down your arms and strikes your body like a lightning bolt, your belly suddenly spiking up, back arching as the orgasmic thunderstorm rolls over you.  The flames don't stop there, however.  They travel down into your crotch, suddenly lighting up every nerve in your ");
	if(player.hasVagina()) outputText("[vagina]");
	else outputText("[asshole]");
	outputText(" like a Christmas tree.  You're acutely aware of every single movement, every pulse, every little bit of contact between you and the huge cock living inside you.");
	
	outputText("\n\nYour muscles spasm and clench as the minotaur lets loose a powerful roar.  His own member twitches, suddenly releasing a flood of hot cum into your awaiting ");
	if(player.hasVagina()) outputText("womb");
	else outputText("bowels");
	outputText(".  The moment that long-awaited jism hits your walls, it's like another lightning bolt hits.  It travels up your spine and sets your entire brain aglow.  Ecstasy wrapped in bliss with a side of euphoric rapture consumes your thoughts.  Your vision goes white, pearly white like the seed filling your body, and your lips part as a primal \"<i>moo</i>\" slips out.");
	
	outputText("\n\nFor the longest time, the only thing your cum-addled mind can think about is cocks and cunts, of pregnant bellies and stomachs filled to capacity.  You mind fills itself with visions of yourself on your knees, servicing this minotaur daily, hoping to please him enough that he might grace your ");
	if(!player.hasVagina()) outputText("new ");
	outputText("womb with his divine dick.");
	
	outputText("\n\nIt takes several minutes for you to come down from this orgasmic high, and when you do, you see your minotaur lover has yet to recover from his.  He lays on his back in the midst of this clearing, his still-rock-hard cock jutting upwards, coating in a mixture of various juices.  The cow-girl sits beside him, carefully licking the towering pillar of cock clean.  You sit up, wobbly and clutch your stomach.  Filled with cum in two ends, you can't help but feel oddly unsatisfied.  Perhaps guzzling down some second-hand cum isn't quite enough to sate your hunger.  Perhaps you need it straight from the tap, as it were.");
	
	outputText("\n\nYou gingerly sit up, your body still quaking with pleasure.  Every movement sends another luxurious aftershock rippling through your body.  You crawl over to the splayed out minotaur, opposite your cow-girl partner, and join her in licking the man's cock clean.  It takes some work, but soon it glistens in the light of the red sky above you.");
	
	outputText("\n\nAs if you both possess some kind of bovine telepathy, you both lean forward, wrapping your ");
	if(player.bRows() > 1) outputText("uppermost ");
	outputText("breasts around his monolithic shaft.  Your faces meet and her soft lips press against yours, each of you earnestly pressing your tongues into the other's mouths, swapping the juices you've collected over the past hour or so.  The bull beneath you groans, awakening to the feeling of four breasts surrounding his love muscle.");
	
	outputText("\n\nThe two of your pump your breasts up and down, your lips barely leaving each other long enough to give his member the occasional kiss, lick or slurp.  Up and down you go, and this time it's the minotaur's body that's wracked with bliss, writhing on the ground.  Milk dribbles from your breasts, coating you, the cow-girl and the minotaur in a fine white sheen and creating a sweet-smelling aroma that permeates the air.");
	
	outputText("\n\nThe bull groans, biting his lip as a third, and likely final, orgasm rips through him.  His hips buck upwards, his cock flaring up and out of your mammaries.  Ropes of immaculate silver seed jet from his cumslit, arcing up into the air several feet before splattering down on your heads.  Wasting no time, you slip your lips around the flare, gulping down mouthful after mouthful of the sweet man-milk.  Even though it's his third load of the hour, it's just as big as the others, and soon your find you can't swallow any more, your cum-laden belly just won't allow it.");

	outputText("\n\nSadly, you relinquish your hold on his cock and sit back, watching the cow-girl opposite you pick up where you left off, slurping up whatever you missed with a dedicated fervor.");
	
	outputText("\n\n<b>Now</b> you feel satisfied.  Filled with that precious, precious minotaur spunk in both ends, fresh from the source.  You slump onto your back and drift off into a hazy, bull-filled dream world.");
	
	outputText("...");
	
	outputText("\n\nYou awaken several hours later.  The minotaur and the cow-girl are nowhere to be seen, but your [armor] is left neatly folded next to you, along with a small bottle filled with some white liquid, most likely a gift from your \"bull\".");
	
	outputText("\n\nYou quickly re-dress and head back to camp, spying the occassional goblin or imp scurrying from its hiding spot, no doubt recovering from their own self-inflicted orgasms.");
	stats(0,0,0,0,.5,-3,-100,1);
	if(flags[PC_FETISH] > 0) {
		outputText("  A thrill runs through you.  Even though you were brought to such a satisfying climax, the whole thought that goblins and imps were watching you and getting off on it... it just makes you hornier than you were before.");
		stats(0,0,0,0,0,0,100,0);
	}
	//Chance to impregnate PC, get mino-fix, and maybe relief from feeder perk.
	minoCumAddiction(10);
	player.knockUp(2,432);
	if(player.hasStatusAffect("Feeder") >= 0) {
		//You've now been milked, reset the timer for that
		player.addStatusValue("Feeder",1,1);
		player.changeStatusValue("Feeder",2,0);
	}
	//(Acquired minotaur cum!)
	hours++;
	menuLoc = 2;
	shortName = "MinoCum";
	takeItem();
}

//Watch
//addButton(1,"Watch",watchAMinoCumSlut);
function watchAMinoCumSlut():void {
	clearOutput();
	outputText("Deciding not to risk it, you settle back into your nook in the rocks and watch on eagerly.  The cow-girl turns and places her hands on a low ledge, causing her to bend over, her ample ass facing the minotaur.  The minotaur closes the distance between them in a single step.");
	outputText("\n\nShe bellows, almost moaning, as the minotaur grabs her cushiony ass-cheeks with both massive hands.  Her tail raises to expose a glistening wet snatch, its lips already parted with desire.  She moos again as his rapidly hardening bull-cock brushes her crotch. You can't tear your eyes away as he positions himself, his flaring, mushroom-like cock-head eliciting another moan as it pushes against her nether lips.");
	outputText("\n\nWith a hearty thrust, the minotaur plunges into the cow-girl's eager fuck-hole, burying himself past one -- two of his oversized cock's three ridge rings.  She screams in half pain, half ecstasy and pushes back, hungry for his full length.  After pulling back only slightly, he pushes deeper, driving every inch of his gigantic dick into his willing partner who writhes in pleasure, impaled exactly as she wanted.");
	outputText("\n\nThe pair quickly settles into a rhythm, punctuated with numerous grunts, groans, and moans of sexual excess.  To you it's almost a violent assault sure to leave both of them bruised and sore, but the cow-girl's lolling tongue and expression of overwhelming desire tells you otherwise.  She's enjoying every thrust as well as the strokes, gropes, and seemingly painful squeezes the minotaur's powerful hands deliver to her jiggling ass and ponderous tits.  He's little better, his eyes glazed over with lust as he continues banging the fuck-hole he found and all but mauling its owner.");
	//[Next]
	stats(0,0,0,0,0,0,10,0);
	menu();
	addButton(0,"Next",watchMinoCumSlutII);
}
function watchMinoCumSlutII():void {
	clearOutput();
	outputText("They go at it for nearly an hour, oblivious to you watching them, before their intensity heightens as they near orgasm.  The results are almost explosive, both of them crying out as they begin twitching uncontrollably.  Clinging desperately to the cow-girl's ass, the minotaur pumps so much cum into her depths that it begins spurting out.  This accidental lubrication releases his grip and the pair collapse to the ground.  Yet the minotaur isn't finished, his man-milk spraying into the air almost like his still-erect dick is a hose and splattering down onto both of them.");
	outputText("\n\nAs you look at the two cum-covered creatures laying there in their exhausted sex-induced stupors, the minotaur's thick horse-cock now slowly deflating, you realize that you've been touching yourself.  You make yourself stop in disgust.");
	outputText("\n\nOnly now do you notice other faces peeking over ledges and ridges.  You count at least two goblins and one imp who quickly pull back.  From the sounds, they were busy getting themselves off.  Apparently this isn't an uncommon show, and the locals enjoy it immensely.");
	stats(0,0,0,0,0,0,25,0);
	doNext(13);
}			
