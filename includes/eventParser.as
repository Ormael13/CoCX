import classes.GlobalFlags.kFLAGS;
import classes.Player;
import classes.Items.Consumable;

//Used to jump the fuck out of pregnancy scenarios for menus.
//const EVENT_PARSER_ESCAPE:int = 800;
//const PHYLLA_GEMS_HUNTED_TODAY:int = 893;

public function eventParser(eventNo:*):void {
	//Clear banked buttons

	//trace("EVENT CODE: " + eventNo);
	if (eventNo is Function)
	{
		eventNo();
	}
	else if (eventNo is int)
	{
		//trace("Numeric eventNo "+eventNo+" replace it with function");
		//Clear sprite if not in combat
		if(!inCombat() && eventNo != cleanupAfterCombat) spriteSelect(-1);
		//Clear pic if not in combat
		//if(!inCombat() && eventNo != cleanupAfterCombat) clearImages();
		//Reset newgame buttons till back at camp
		mainView.setMenuButton( MainView.MENU_NEW_MAIN, "New Game", charCreation.newGameGo );
		if(eventNo != 1) {
			hideMenus();
		}
		
		if (eventNo == 9999) // Game over event; overriding whatever the fuck has been done to the UI up to this point to force display of the data and new game buttons
		{
			mainView.showMenuButton( MainView.MENU_NEW_MAIN );
			mainView.showMenuButton( MainView.MENU_DATA );
			mainView.hideMenuButton( MainView.MENU_APPEARANCE );
			mainView.hideMenuButton( MainView.MENU_LEVEL );
			mainView.hideMenuButton( MainView.MENU_PERKS );
		}
		/*if(eventNo == 1000 && gameState == 1 && menuLoc == 1) {
			menuLoc = 0;
			outputText("\n\n", false);
			if(!combatRoundOver()) enemyAI();
			else outputText(monster.capitalA + monster.short + " is defeated!");
			return;
		}*/


		if(eventNo < 1000) doSystem(eventNo);
		if(eventNo >=1000 && eventNo < 2000) inventory.doItems(eventNo);
		if(eventNo >=2000 && eventNo < 5000) doEvent(eventNo);
		if(eventNo >=5000 && eventNo < 7000) doCombat(eventNo);
		if(eventNo >= 10000 && eventNo < 10999) charCreation.doCreation(eventNo);
		if(eventNo >= 11000) doDungeon(eventNo);
	}

	else
	{
		errorPrint(eventNo);		// Dump the system state to the window so the player can file a decent bug-report
	}
}


public function doSystem(eventNo:Number):void {
	//@ camp
	//(clear data/appearance buttons if not at camp
	//trace("System Event", eventNo)

	if(eventNo != 1)
	{
		hideMenus();
	}
	switch (eventNo) {
		case 1:
			mainView.nameBox.visible = false;
			if (gameState == 1 || gameState == 2) {
				menuLoc = 0;
				eventParser(5000);
				return;
			}
			//Clear restriction on item overlaps if not in combat
			plotFight = false;
			if (inDungeon) {
				menuLoc = 0;
				dungeonRoom(dungeonLoc);
				return;
			}
			menuLoc = 0;
			flags[kFLAGS.PLAYER_PREGGO_WITH_WORMS] = 0;
			camp.doCamp();
			return;


		case 2:
			exploration.doExplore();
			return;


		case 3:
			desert.exploreDesert();
			return;


		case 4:
			forest.exploreForest();
			return;


		case 5:
			lake.exploreLake();
			return;


		case 6:
			mountain.exploreMountain();
			return;


		case 10:
			//Masturbate
			if (player.findStatusAffect(StatusAffects.Dysfunction) >= 0) {
				outputText("You'd love to masturbate, but your sexual organs' numbness makes it impossible.  You'll have to find something to fuck to relieve your lust.", true);
				doNext(1);
				return;
			}
			masturbateGo();
			return;


		case 11:
			//Rest
			camp.rest();
			return;


		case 12:
			//Explore new zones
			exploration.tryDiscover();
			return;


		case 13:
			//Pass an hour
			outputText("An hour passes...\n", true);
			timeQ = 1;
			goNext(1, false);
			return;


		case 14:
			outputText("Two hours pass...\n", true);
			timeQ = 2;
			goNext(2, false);
			return;


		case 15:
			outputText("Four hours pass...\n", true);
			timeQ = 4;
			goNext(4, false);
			return;


		case 16:
			outputText("Eight hours pass...\n", true);
			timeQ = 8;
			goNext(8, false);
			return;


		case 17:
			outputText("", true);
			goNext(24, false);
			return;


		case 19:
			//Load menu
			saves.loadScreen();
			return;


		case 20:
			//Save Menu
			saves.saveScreen();
			return;


		case -20:
			saves.saveGameObject(null, true);
			return;


		case -21:
			saves.openSave();
			showStats();
			statScreenRefresh();
			return;


		case 30:
			// I have NO idea what could call this. I don't see anything that passes 30 as an event number anywhere
			var f:MouseEvent;
			saves.saveLoad(f);
			return;


		case 40:
			//Use wait command
			//See camp.as
			camp.doWait();
			return;


		case 41:
			//Use sleep command
			//in camp.as
			camp.doSleep();
			return;


		case 42:
			//Choose masturbate options
			masturbateMenu();
			return;


		case 44:
			//Gain +5 Str due to level
			dynStats("str", 5);
			outputText("Your muscles feel significantly stronger from your time adventuring.", true);
			doNext(116);
			return;


		case 45:
			//Gain +5 Toughness due to level
			dynStats("tou", 5);
			trace("HP: " + player.HP + " MAX HP: " + maxHP());
			statScreenRefresh();
			outputText("You feel tougher from all the fights you have endured.", true);
			doNext(116);
			return;


		case 46:
			//Gain +5 Intelligence due to level
			dynStats("int", 5);
			outputText("Your time spent fighting the creatures of this realm has sharpened your wit.", true);
			doNext(116);
			return;


		case 47:
			//Gain +5 speed due to level
			dynStats("spe", 5);
			outputText("Your time in combat has driven you to move faster.", true);
			doNext(116);
			return;


		case 48:
			//Use Onahole
			onaholeUse();
			return;


		case 49:
			//Use Stimbelt
			stimBeltUse();
			return;


		case 50:
			deluxeOnaholeUse();
			return;


		case 51:
			allNaturalOnaholeUse();
			return;


		case 52:
			allNaturalStimBeltUse();
			return;


		case 65:
			//turn on/off autosave
			var e:MouseEvent;
			player.autoSave = !player.autoSave;
			saves.saveLoad(e);
			return;


		case 71:
			//Places menu
			camp.places(true);
			return;


		case 74:
			//Camp followers screen
			doNext(1);
			camp.campFollowers();
			return;


		case 79:
			deluxeDildo();
			return;


		case 80:
			forest.exploreDeepwoods();
			return;


		case 82:
			saves.deleteScreen();
			return;


		case 94:
			exploration.debugOptions();
			return;


		case 95:
			highMountains.exploreHighMountain();
			return;


		case 97:
			plains.explorePlains();
			return;


		case 111:
			swamp.exploreSwamp();
			return;


		case 114:
			stage.focus = null;
			//mainView.aCb.visible = false;
			if (mainView.aCb.parent != null)
			{
				mainView.removeChild(mainView.aCb);
				applyPerk(tempPerk);
			}
			return;

		case 115:
			stage.focus = null;
			//mainView.aCb.visible = false;
			if (mainView.aCb.parent != null)
			{
				mainView.removeChild(mainView.aCb);
				eventParser(1);
			}
			return;

		case 116:
			perkBuyMenu();
			return;


		case 118:
			if (!monster.hasVagina()) monster.createVagina();
			monster.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_GAPING;
			monster.ass.analLooseness = 3;
			outputText(mainView.eventTestInput.text, true, true);
			simpleChoices("Again", 117, "", 0, "", 0, "", 0, "Quit", mainMenu);
			mainView.eventTestInput.x = -10207.5;
			mainView.eventTestInput.y = -1055.1;
			return;


		case 119:
			mainView.eventTestInput.x = -10207.5;
			mainView.eventTestInput.y = -1055.1;
			mainMenu();
			return;

	}

	errorPrint(eventNo);		// Dump the system state to the window so the player can file a decent bug-report
}

public function getCurrentStackTrace():String		// Fuck, stack-traces only work in the debug player.
{
	var tempError:Error = new Error();
	var stackTrace:String = tempError.getStackTrace();
	return stackTrace;
}

public function errorPrint(details:* = null):void
{
	rawOutputText("<b>Congratulations, you've found a bug!</b>", true);
	rawOutputText("\nError: Unknown event!");
	rawOutputText("\n\nPlease report that you had an issue with code: \"" + details + "\" ");
	rawOutputText("\nGame version: \"" + ver + "\" (<b>THIS IS IMPORTANT! Please be sure you include it!</b>) ");

	var sTrace:String = getCurrentStackTrace();

	if (sTrace)	// Fuck, stack-traces only work in the debug player.
		rawOutputText("and stack-trace: \n <pre>" + sTrace + "</pre>\n"); 	
	rawOutputText("to fake-name on the forums or better yet, file a bug report on github: ");
	rawOutputText("\nhttps://github.com/herp-a-derp/Corruption-of-Champions");

	rawOutputText("\nPlease try to include the details of what you were doing when you encountered this bug ");
	if (sTrace)
		rawOutputText(" (including the above stack trace copy&pasted into the details),");
	rawOutputText(" to make tracking the issue down easier. Thanks!");

	doNext(13);
}

//Argument is time passed.  Pass to event parser if nothing happens.
// The time argument is never actually used atm, everything is done with timeQ instead...
public function goNext(time:Number, defNext:Boolean):Boolean  {
	//Update system time
	//date = new Date();
	//trace ("MONTH: " + date.month + " DATE: " + date.date + " MINUTES: " + date.minutes);
	//outputText("", true);
	var needNext:Boolean = false;
	//used to store if hair needs to display
	var tempNext:Boolean = false;
	var textHolder:String = "";
	//var threshhold:Number = 0; - No longer needed, was only used in one place by Marble
	var temp2:Number = 0;

	while (timeQ > 0) {
		timeQ--;
		model.time.hours++;
		if(player.cumMultiplier > 19999) player.cumMultiplier = 19999;
		if(player.ballSize > 400) player.ballSize = 400;
		if(player.findPerk(PerkLib.StrongBack) >= 0 && !player.itemSlot4.unlocked) {
			player.itemSlot4.unlocked = true;
		}
		if(player.findPerk(PerkLib.StrongBack2) >= 0 && !player.itemSlot5.unlocked) {
			player.itemSlot5.unlocked = true;
		}
		
		//Inform all time aware classes that a new hour has arrived
		for (var tac:int = 0; tac < _timeAwareClassList.length; tac++) if (_timeAwareClassList[tac].timeChange()) needNext = true;
		
		if(flags[kFLAGS.SOCK_COUNTER] > 0) {
			flags[kFLAGS.SOCK_COUNTER]--;
			if(flags[kFLAGS.SOCK_COUNTER] < 0) flags[kFLAGS.SOCK_COUNTER] = 0;
			if(flags[kFLAGS.SOCK_COUNTER] > 24) flags[kFLAGS.SOCK_COUNTER] = 24;
		}
		//Phylla egg laying - Now handled by AntsScene
		//Helia pregnancy - Now handled by HelScene
		genderCheck();
		if(player.findStatusAffect(StatusAffects.NoJojo) >= 0) player.removeStatusAffect(StatusAffects.NoJojo);
		
		regeneration(false);
		
		player.hoursSinceCum++;
		//Super cumbuilding activate!
		if(player.findPerk(PerkLib.MaraesGiftProfractory) >= 0) player.hoursSinceCum += 2;
		if(player.findPerk(PerkLib.FerasBoonAlpha) >= 0) player.hoursSinceCum += 2;
		//Normal
		if(player.findPerk(PerkLib.WellAdjusted) < 0) {
			//Raise lust
			dynStats("lus", player.lib * 0.04, "resisted", false);
			//Double lust rise if lusty.
			if(player.findPerk(PerkLib.Lusty) >= 0) dynStats("lus", player.lib * 0.02, "resisted", false);
		}
		//Well adjusted perk
		else {
			//Raise lust
			dynStats("lus", player.lib * 0.02);
			//Double lust rise if lusty.
			if(player.findPerk(PerkLib.Lusty) >= 0) dynStats("lus", player.lib * 0.01, "resisted", false);
		}
		//Rathazul crafting countdown - Now handled by Rathazul
		//Urta pregnancy - Now handled by Urta
		//Kelly pregnancy - Now handled by Kelly
		//Goo fuck stuff - Now handled by Valeria
		//Ember fuck cooldown and Ember napping - Now handled by EmberScene
		//Sophie and sophie's daughters updates - Now handled by SophieScene
		//Anemone Kid Babysitting - Now handled by AnemoneScene
		//Shouldra Stuff - Now handled in ShouldraScene
		//Amily lays eggs that were oviposited. - Now handled by amilyScene
		if(flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] > 0) {
			if(flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] < 500) flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY]++;
		}
		//Vapula gives a dildo - Now handled in Vapula
		//Niamh counters - Now handled in Niamh
		if(flags[kFLAGS.FOX_BAD_END_WARNING] == 1) {
			if(player.faceType != FACE_FOX || player.tailType != TAIL_TYPE_FOX || player.earType != EARS_FOX || player.lowerBody != LOWER_BODY_TYPE_FOX || player.skinType != SKIN_TYPE_FUR) {
				flags[kFLAGS.FOX_BAD_END_WARNING] = 0;
			}
		}
		//Isabella milk countdown and accent coaching countdown - Now handled in IsabellaScene
		//Anemone kid finds an item - Now handled in AnemoneScene
		//Wet pussy check!
		if(player.findPerk(PerkLib.WetPussy) >= 0 && player.vaginas.length > 0) {
			if(player.vaginas[0].vaginalWetness < VAGINA_WETNESS_WET) {
				outputText("\n<b>Your " + vaginaDescript(0) + " returns to its normal, wet state.</b>\n", false);
				needNext = true;
				player.vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
			}
		}
		//Fixing Egg Preg Preglocked Glitch
		if (player.pregnancyIncubation <= 0 && player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS) {
			player.knockUpForce(); //Clear Pregnancy
		}
		if(player.findStatusAffect(StatusAffects.Uniball) >= 0 && player.ballSize > 1 && player.balls > 0) {
			//Testicles Normalise: 
			outputText("\nYou feel a deep sensation of release around your genitals.  You sigh with relief and contentment as your testicles drop downwards and bloom outwards, heat throbbing within them as they split and form a proper ballsack.\n");
			player.removeStatusAffect(StatusAffects.Uniball);
			needNext = true;
		}		
		//Make eggs big if harpied!
		if(player.lowerBody == LOWER_BODY_TYPE_HARPY && player.tailType == TAIL_TYPE_HARPY && player.findPerk(PerkLib.HarpyWomb) >= 0 && player.findStatusAffect(StatusAffects.Eggs) >= 0) {
			if(player.statusAffectv2(StatusAffects.Eggs) == 0) {
				player.changeStatusValue(StatusAffects.Eggs,2,1);
				outputText("\n<b>A familiar, motherly rumble lets you know that your harpy-like womb is growing your eggs nice and large.</b>\n", false);
				needNext = true;
			}
		}
		//Jojo milking cooldown - Now handled in JojoScene
		//Spider-preg stuff - Now Handled in FemaleSpiderMorphScene
		//Roxanne stuff - Now handled in Roxanne
		//Niamh Black Cat Beer - Now handled in Niamh
		//Phouka Whiskey - Now handled in PhoukaScene
		//EMBER STUFF - Now handled in EmberScene
		//telAdre.cotton.cottonPregUpdates(); - Now handled directly by cotton
		//Fix femininity ratings if out of whack!
		if(player.findPerk(PerkLib.Androgyny) < 0)
			textHolder = player.fixFemininity();
		if(textHolder != "") {
			outputText(textHolder, false);
			needNext = true;
		}
		//BOOKURYUUUU COUNTAH For IZMA - Now handled in IzmaScene
		//Minotaur son tracker - Now handled in MinotaurMobScene
		//Shouldra Follower stuff - Now handled in ShouldraScene
		//Lust stick!
		if(player.findStatusAffect(StatusAffects.LustStickApplied) >= 0) {
			//Decrement!
			player.addStatusValue(StatusAffects.LustStickApplied,1,-1);
			if(player.statusAffectv1(StatusAffects.LustStickApplied) <= 0) {
				player.removeStatusAffect(StatusAffects.LustStickApplied);
				outputText("<b>\nYour drugged lipstick fades away, leaving only the faintest residue on your lips.  You'll have to put on more if you want to be able to kiss your foes into submission!</b>\n", false);
			}
		}
		//Jojo egg counter - Now handled in JojoScene
		if(flags[kFLAGS.DICK_EGG_INCUBATION] > 0) {
			flags[kFLAGS.DICK_EGG_INCUBATION]--;
			trace("DICK BIRTH TIMER: " + flags[kFLAGS.DICK_EGG_INCUBATION]);
			if(flags[kFLAGS.DICK_EGG_INCUBATION] == 1) {
				birthBeeEggsOutYourWang();
				needNext = true;
			}
		}
		//Izma Pregger counter - Now handled in IzmaScene
		//Vala post-rape countdown
		if(flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC] > 0) {
			flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC]--;
			if(flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC] < 0) flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC] = 0;
		}	
		//Sophie PO'ed countdown - Now handled in SophieFollower
		//PO countdown for Isabella - Now handled in IsabellaScene
		//Lusty Tongue Check!
		if(player.findStatusAffect(StatusAffects.LustyTongue) >= 0) {
			if(rand(5) == 0) {
				outputText("\nYou keep licking your lips, blushing with the sexual pleasure it brings you.", false);
				dynStats("lus", 2+rand(15));
				if(player.lust >= 100) {
					outputText("  Your knees lock from the pleasure, and you fall back in pleasure, twisting and moaning like a whore as you somehow orgasm from your mouth.  When it finishes, you realize your mouth feels even more sensitive than before.", false);
					player.orgasm();
					dynStats("sen", 2);
					//Tongue orgasming makes it last longer.
					player.changeStatusValue(StatusAffects.LustyTongue,1,player.statusAffectv1(StatusAffects.LustyTongue)+10);
					
				}
				needNext = true;
				outputText("\n", false);			
			}
			//Decrement
			player.changeStatusValue(StatusAffects.LustyTongue,1,player.statusAffectv1(StatusAffects.LustyTongue)-1);
			if(player.statusAffectv1(StatusAffects.LustyTongue) <= 0) {
				player.removeStatusAffect(StatusAffects.LustyTongue);
				needNext = true;
				outputText("\nYour mouth and tongue return to normal.\n", false);
			}
		}
		//Egg laying countdown for Sophie - Now handled by sophie
		//Luststic countdown
		if(player.findStatusAffect(StatusAffects.Luststick) >= 0) {
			player.addStatusValue(StatusAffects.Luststick,1,-1);
			//50% chance to lust spike
			if(rand(2) == 0 && player.hasCock()) {
				//Display if havent displayed
				if(flags[kFLAGS.PC_CURRENTLY_LUSTSTICK_AFFECTED] == 0) {
					outputText("\nYour body tingles, practically a slave to the effects of harpy lipstick.  Blood surges to " + sMultiCockDesc() + ", making you groan out loud with forced pleasure.  Unasked-for fantasies assault you, and you spend a few moments fantasizing about fucking feathery women before you come to your senses.\n", false);
					flags[kFLAGS.PC_CURRENTLY_LUSTSTICK_AFFECTED]++;
					needNext = true;
				}
				dynStats("lus", .1);
				player.lust += 20;
				if(player.lust > 100) player.lust = 100;
			}
			if(player.statusAffectv1(StatusAffects.Luststick) <= 0) {
				player.removeStatusAffect(StatusAffects.Luststick);
				outputText("\n<b>The lust-increasing effects of harpy lipstick have worn off!\n</b>", false);
				needNext = true;
			}
		}
		//Urta stuff - Now handled in Urta
		//Count down rathazul event timers - Now handled in Rathazul
		//Check for gain of cat agility - requires legs, tail, and ears
		if(player.tailType == TAIL_TYPE_CAT && player.lowerBody == LOWER_BODY_TYPE_CAT && player.earType == EARS_CAT) {
			if(player.findPerk(PerkLib.Flexibility) < 0) {
				outputText("\nWhile stretching, you notice that you're much more flexible than you were before.  Perhaps this will make it a bit easier to dodge attacks in battle?\n\n(<b>Gained Perk: Flexibility</b>)\n", false);
				needNext = true;
				player.createPerk(PerkLib.Flexibility,0,0,0,0);
			}
		}
		//Remove flexibility perk if not meeting requirements
		else if(player.findPerk(PerkLib.Flexibility) >= 0) {
			outputText("\nYou notice that you aren't as flexible as you were when you had a more feline body.  It'll probably be harder to avoid your enemies' attacks now.\n\n(<b>Lost Perk: Flexibility</b>)\n", false);
			needNext = true;
			player.removePerk(PerkLib.Flexibility);
		}
		//more marbles! - Now handled in MarbleScene
		//Kelt Submissiveness check
		if(player.statusAffectv2(StatusAffects.Kelt) > 0) {
			//reduce kelt submissiveness by 1 every 5 hours
			player.addStatusValue(StatusAffects.Kelt,2,-0.15);
		}
		//Mino cum update.
		if(mountain.minotaurScene.minoCumUpdate()) needNext = true;
		//Repeated warnings!
		else if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 2 && model.time.hours % 13 == 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330] == 0) {
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) outputText("\n<b>You shiver, feeling a little cold.  Maybe you ought to get some more minotaur cum?  You just don't feel right without that pleasant buzz in the back of your mind.</b>\n", false);
			else if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3) outputText("\n<b>The steady fire of lust within you burns hot, making you shiver and grab at your head.  You're STILL in withdrawal after having gone so long without a dose of minotaur love.  You just know you're going to be horny and achy until you get some.</b>\n", false);
			needNext = true;
		}
		//Decrement mino withdrawal symptoms display cooldown
		//flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330] prevents PC getting two of the same notices overnite
		else if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330] > 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00330]--;
		//Check for duplicate tails.
		if(player.lowerBody == LOWER_BODY_TYPE_NAGA) {
			if(player.tailType > TAIL_TYPE_NONE) {
				outputText("\nYour tail squirms, wriggling against your larger naga tail as the scales part around it, absorbing it.  <b>Your form is completely scaly and smooth from the waist down.</b>\n", false);
				player.tailType = TAIL_TYPE_NONE;
				needNext = true;
			}
		}
		//Update urta's PO timer - Now handled in Urta
		//Update Amily's preggo counter - Now handled by amilyScene
		//Update Amily's Jojo fixing counter - Now handled by amilyScene
		//Update Edryn's preggo counter - Now handled by edryn
		//Eggs in tits!
		if(player.findStatusAffect(StatusAffects.Eggchest) >= 0) {
			player.addStatusValue(StatusAffects.Eggchest,1,-1);
			if(player.statusAffectv1(StatusAffects.Eggchest) <= 0) {
				outputText("\n<b>You feel the rounded eggs within your [fullChest] vanishing, absorbed into your body.  </b>");
				player.growTits(player.statusAffectv2(StatusAffects.Eggchest), player.bRows(), true, 2);
				outputText("\n");	
				player.removeStatusAffect(StatusAffects.Eggchest);
			}
		}
		//Spider Oviposits!
		if(player.findPerk(PerkLib.SpiderOvipositor) >= 0 || player.findPerk(PerkLib.BeeOvipositor) >= 0) {
			//Remove dat shit!
			if(player.findPerk(PerkLib.SpiderOvipositor) >= 0 && (!player.isDrider() || player.tailType != TAIL_TYPE_SPIDER_ADBOMEN)) {
				outputText("\nYour ovipositor (and eggs) vanish since your body has become less spider-like.</b>\n");
				player.removePerk(PerkLib.SpiderOvipositor);
				needNext = true;
			}
			//Remove dat shit!
			else if(player.findPerk(PerkLib.BeeOvipositor) >= 0 && player.tailType != TAIL_TYPE_BEE_ABDOMEN) {
				outputText("\nYour ovipositor (and eggs) vanish since your body has become less bee-like.</b>\n");
				player.removePerk(PerkLib.BeeOvipositor);
				needNext = true;
			}
			//Update stuff!
			else {
				temp = player.eggs();
				if(player.eggs() < 10) {
					player.addEggs(2);
				}
				else if(player.eggs() < 20 && model.time.hours % 2 == 0) {
					player.addEggs(1);
				}
				else if(model.time.hours % 4 == 0) {
					player.addEggs(1);
				}
				if(player.findPerk(PerkLib.SpiderOvipositor) >= 0) {
					//Egg Build up Texts:
					if(temp < 10 && player.eggs() >= 10) {
						outputText("\nYou feel a certain fullness building in your spider-half's abdomen.  <b>You have enough eggs to lay!</b>\n");
						needNext = true;
					}
					//Stage 2:
					if(temp < 20 && player.eggs() >= 20) {
						//+Minimum Lust
						outputText("\nYour spider body feels like it's stretched taut, and a heavy warmth has spread throughout it.  The sensation of eggs piling up inside you is enough to drive you to distraction.  It would be a good idea to find somewhere to deposit them - but, oh, how great it would feel to get them fertilized by a nice hard cock first!");
						if(!player.hasVagina()) outputText("  Wait, that's not right...");
						outputText("\n\n<b>Minimum Lust raised!</b>\n");
						needNext = true;
					}
					//Stage 3:
					if(temp < 40 && player.eggs() >= 40) {
						//-Speed
						outputText("\nYour lower half has become so heavy that it's difficult to move now, the weight of your eggs bearing down on your lust-addled frame.  Your ovipositor pokes from its hiding place, dripping its slick lubrication in anticipation of filling something, anything with its burden.  You're going to have to find someone to help relieve you of your load, and soon...\n\n<b>Minimum Lust raised!</b>\n");
						dynStats("spe", -1);
						needNext = true;
					}
				}
				//Bee version!
				else {
					//Egg Build up Texts:
					//Stage 1:
					if(temp < 10 && player.eggs() >= 10) {
						outputText("\nYou feel a certain fullness building in your insectile abdomen.  You have some eggs ready... and you feel a strange urge to have them fertilized.");
						if(!player.hasVagina()) outputText("  Wait, how would you even go about that?");
						outputText("  <b>You have enough eggs to lay!</b>\n");
						needNext = true;
					}
					//Stage 2:
					//+Minimum Lust
					if(temp < 20 && player.eggs() >= 20) {
						outputText("\nYour abdomen feels like it's stretched taut, and a heavy warmth has spread throughout it.  It swings pendulously with every movement you make, and the sensation of eggs piling up inside you is enough to drive you to distraction.");
						outputText("\n\n<b>Minimum Lust raised!</b>\n");
						needNext = true;
					}
					//Stage 3:
					//++Minimum Lust
					//-Speed
					if(temp < 40 && player.eggs() >= 40) {
						outputText("\nYour bee half has become so heavy that it's difficult to move now, the weight of your eggs bearing down on your lust-addled frame.  Your ovipositor pokes from its hiding place, dripping its sweet, slick lubrication in anticipation of filling something, anything with its burden.  You're going to have to find someone to help relieve you of your load, and soon...\n");
						dynStats("spe", -1);
						needNext = true;
					}
				}
			}
		}
		//Check ninetails perks!
		if(player.findPerk(PerkLib.EnlightenedNinetails) >= 0 || player.findPerk(PerkLib.CorruptedNinetails) >= 0) {
			if(player.tailType != TAIL_TYPE_FOX || player.tailVenom < 9) {
				needNext = true;
				outputText("\n<b>Without your tails, the magic power they once granted withers and dies, vanishing completely.</b>\n");
				player.removePerk(PerkLib.EnlightenedNinetails);
				player.removePerk(PerkLib.CorruptedNinetails);
			}
		}
		//Lose diapause
		if(!player.hasVagina() && player.findPerk(PerkLib.Diapause) >= 0) {
			outputText("\n<b>With the loss of your womb, you lose your kangaroo-like diapause ability.</b>\n");
			player.removePerk(PerkLib.Diapause);
			needNext = true;
		}
		//Oviposition perk for lizard folks
		if(player.findPerk(PerkLib.Oviposition) >= 0 || player.findPerk(PerkLib.BunnyEggs) >= 0) {
			//If too 'unlizardy', stop it
			//--Lose Oviposition perk if lizard score gets below 3.
			if((player.nagaScore() + player.lizardScore()) < 3 && player.findPerk(PerkLib.Oviposition) >= 0 && player.findPerk(PerkLib.BasiliskWomb) < 0) {
				outputText("\nAnother change in your uterus ripples through your reproductive systems.  Somehow you know you've lost a little bit of reptilian reproductive ability.\n(<b>Perk Lost: Oviposition</b>)\n", false);
				needNext = true;
				player.removePerk(PerkLib.Oviposition);
			}
			else if(player.bunnyScore() < 3 && player.findPerk(PerkLib.BunnyEggs) >= 0) {
				outputText("\nAnother change in your uterus ripples through your reproductive systems.  Somehow you know you've lost your ability to spontaneously lay eggs.\n(<b>Perk Lost: Bunny Eggs</b>)\n", false);
				needNext = true;
				player.removePerk(PerkLib.BunnyEggs);
			}
			//Otherwise pregger check
			else if(player.pregnancyIncubation < 1 && player.hasVagina()) {
				//Check once in the morning.
				if(model.time.hours ==1) {
					//every 15 days if high fertility get egg preg
					if(player.totalFertility() > 50 && model.time.days % 15 == 0) {
						outputText("\n<b>Somehow you know that eggs have begun to form inside you.  You wonder how long it will be before they start to show?</b>\n", false);
						needNext = true;
						player.knockUp(PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, PregnancyStore.INCUBATION_OVIELIXIR_EGGS, 1, 1);
						//v1 = egg type.
						//v2 = size - 0 for normal, 1 for large
						//v3 = quantity
						player.createStatusAffect(StatusAffects.Eggs,rand(6),rand(2),(5+rand(3)),0);
					}
					//every 30 days if high fertility get egg preg
					else if(model.time.days % 30 == 0) {
						outputText("\n<b>Somehow you know that eggs have begun to form inside you.  You wonder how long it will be before they start to show?</b>\n", false);
						needNext = true;
						player.knockUp(PregnancyStore.PREGNANCY_OVIELIXIR_EGGS, PregnancyStore.INCUBATION_OVIELIXIR_EGGS, 1, 1);
						//v1 = egg type.
						//v2 = size - 0 for normal, 1 for large
						//v3 = quantity
						player.createStatusAffect(StatusAffects.Eggs,rand(6),rand(2),(5+rand(3)),0);
						//Count times eggpregged this way in perk.
						player.addPerkValue(PerkLib.Oviposition,1,1);
					}
				}
			}
		}
		//Prevent Buttsluts from getting dry backdoors
		if(player.findPerk(PerkLib.MaraesGiftButtslut) >= 0 && player.ass.analWetness < 2) {
			outputText("\n<b>Your " + assholeDescript() + " quickly re-moistens.  It looks like Marae's 'gift' can't be removed.</b>\n", false);
			needNext = true;
			player.ass.analWetness = 2;
		}
		//Heat-check!
		//Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
		if(player.inHeat)
		{
			if(player.statusAffectv3(StatusAffects.Heat) <= 1 || player.vaginas.length == 0)
			{
				//Remove bonus libido from heat
				dynStats("lib", -player.statusAffect(player.findStatusAffect(StatusAffects.Heat)).value2, "resisted", false, "noBimbo", true);
				//remove heat
				player.removeStatusAffect(StatusAffects.Heat);
				if(player.lib < 1) player.lib = 1;
				statScreenRefresh();
				outputText("\n<b>Your body calms down, at last getting over your heat.</b>\n", false);
				needNext = true;
			}
			else player.addStatusValue(StatusAffects.Heat,3,-1);
		}
		//Remove anemone lustiness - Now handled in AnemoneScene
		//Rut-check!
		//Rut v1 is bonus cum, v2 is bonus libido, v3 is hours till it's gone
		if(player.inRut)
		{
			trace("RUT:" + player.statusAffectv3(StatusAffects.Rut));
			if(player.statusAffectv3(StatusAffects.Rut) <= 1 || player.totalCocks() == 0)
			{
				//Remove bonus libido from rut
				dynStats("lib", -player.statusAffectv2(StatusAffects.Rut), "resisted", false, "noBimbo", true);
				//remove heat
				player.removeStatusAffect(StatusAffects.Rut);
				if(player.lib < 10) player.lib = 10;
				statScreenRefresh();
				outputText("\n<b>Your body calms down, at last getting over your rut.</b>\n", false);
				needNext = true;
			}
			
			else player.addStatusValue(StatusAffects.Rut,3,-1);
		}
		//Remove marble anti-worm sex - Now handled in MarbleScene
		//Futa checks
		if(player.findPerk(PerkLib.FutaForm) >= 0) {
			//(Dick regrowth) 
			if(!player.hasCock()) {
				player.createCock();
				player.cocks[0].cockLength = 10;
				player.cocks[0].cockThickness = 2.75;
				outputText("\n<b>As time passes, your loins grow itchy for a moment.  A split-second later, a column of flesh erupts from your crotch.  Your new, 10-inch cock pulses happily.", false);
				if(player.balls == 0) {
					outputText("  A pair of heavy balls drop into place below it, churning to produce cum.", false);
					player.balls = 2;
					player.ballSize = 3;
				}
				dynStats("int", -1, "sen", 5, "lus", 15);
				outputText("</b>\n", false);
				needNext = true;
			}
			//(Dick rebiggening) 
			if(player.cocks[0].cockLength < 8) {
				outputText("\n<b>As time passes, your cock engorges, flooding with blood and growing until it's at 8 inches long.  ", false);
				outputText("You really have no control over your dick.</b>\n", false);
				player.cocks[0].cockLength = 8;
				if(player.cocks[0].cockThickness < 2) player.cocks[0].cockThickness = 2;
				needNext = true;
			}
			//(Balls regrowth)
			if(player.balls == 0) {
				outputText("\n<b>As time passes, a pressure in your loins intensifies to near painful levels.  The skin beneath " + sMultiCockDesc() + " grows loose and floppy, and then two testicles roll down to fill your scrotum.</b>\n", false);
				needNext = true;
				player.balls = 2;
				player.ballSize = 3;
			}
			//Tits!
			if(player.breastRows[0].breastRating < 5) 
			{
				player.breastRows[0].breastRating = 5;
				if(player.findPerk(PerkLib.FutaFaculties) >= 0) outputText("\n<b>Your tits get nice and full again.  You'll have lots of fun now that your breasts are back to being big, swollen knockers!</b>\n", false);
				else outputText("\n<b>Your " + breastDescript(0) + " have regained their former bimbo-like size.  It looks like you'll be stuck with large, sensitive breasts forever, but at least it'll help you tease your enemies into submission!</b>\n", false);
				needNext = true;
				dynStats("int", -1, "lus", 15);
			}
			//Vagoo
			if(!player.hasVagina()) {
				player.createVagina();
				if(player.findPerk(PerkLib.FutaFaculties) >= 0) outputText("\n<b>Your crotch is like, all itchy an' stuff.  Damn!  There's a wet little slit opening up, and it's all tingly!  It feels so good, why would you have ever gotten rid of it?</b>\n", false);
				else outputText("\n<b>Your crotch tingles for a second, and when you reach down to feel, your " + player.legs() + " fold underneath you, limp.  You've got a vagina - the damned thing won't go away and it feels twice as sensitive this time.  Fucking bimbo liquer.</b>\n", false);
				dynStats("int", -1, "sen", 10, "lus", 15);
				needNext = true;
			}
		}
		//Bimbo checks
		if(player.findPerk(PerkLib.BimboBody) >= 0 || player.findStatusAffect(StatusAffects.BimboChampagne) >= 0) {
			//Tits!
			if(player.breastRows[0].breastRating < 5) 
			{
				player.breastRows[0].breastRating = 5;
				if(player.findPerk(PerkLib.BimboBrains) >= 0 || player.findStatusAffect(StatusAffects.BimboChampagne) >= 0) outputText("\n<b>Your boobies like, get all big an' wobbly again!  You'll have lots of fun now that your tits are back to being big, yummy knockers!</b>\n", false);
				else outputText("\n<b>Your " + breastDescript(0) + " have regained their former bimbo-like size.  It looks like you'll be stuck with large, sensitive breasts forever, but at least it'll help you tease your enemies into submission!</b>\n", false);
				needNext = true;
				dynStats("int", -1, "lus", 15);
			}
			//Vagoo
			if(!player.hasVagina()) {
				player.createVagina();
				if(player.findPerk(PerkLib.BimboBrains) >= 0 || player.findStatusAffect(StatusAffects.BimboChampagne) >= 0) outputText("\n<b>Your crotch is like, all itchy an' stuff.  Omigawsh!  There's a wet little slit opening up, and it's all tingly!  It feels so good, maybe like, someone could put something inside there!</b>\n", false);
				else outputText("\n<b>Your crotch tingles for a second, and when you reach down to feel, your " + player.legs() + " fold underneath you, limp.  You've got a vagina - the damned thing won't go away and it feels twice as sensitive this time.  Fucking bimbo liquer.</b>\n", false);
				needNext = true;
			}
			if(player.hipRating < 12) {
				if(player.findPerk(PerkLib.BimboBrains) >= 0 || player.findPerk(PerkLib.FutaFaculties) >= 0) outputText("\nWhoah!  As you move, your [hips] sway farther and farther to each side, expanding with every step, soft new flesh filling in as your hips spread into something more appropriate on a tittering bimbo.  You giggle when you realize you can't walk any other way.  At least it makes you look, like, super sexy!\n");
				else outputText("\nOh, no!  As you move, your [hips] sway farther and farther to each side, expanding with every step, soft new flesh filling in as your hips spread into something more appropriate for a bimbo.  Once you realize that you can't walk any other way, you sigh heavily, your only consolation the fact that your widened hips can be used to tease more effectively.\n");
				dynStats("int", -1);
				player.hipRating = 12;
				needNext = true;
			}
			if(player.buttRating < 12) {
				if(player.findPerk(PerkLib.BimboBrains) >= 0 || player.findPerk(PerkLib.FutaFaculties) >= 0) outputText("\nGradually warming, you find that your [butt] is practically sizzling with erotic energy.  You smile to yourself, imagining how much you wish you had a nice, plump, bimbo-butt again, your hands finding their way to the flesh on their own.  Like, how did they get down there?  You bite your lip when you realize how good your tush feels in your hands, particularly when it starts to get bigger.  Are butts supposed to do that?  Happy pink thoughts wash that concern away - it feels good, and you want a big, sexy butt!  The growth stops eventually, and you pout disconsolately when the lusty warmth's last lingering touches dissipate.  Still, you smile when you move and feel your new booty jiggling along behind you.  This will be fun!\n");
				else outputText("\nGradually warming, you find that your [butt] is practically sizzling with erotic energy.  Oh, no!  You thought that having a big, bloated bimbo-butt was a thing of the past, but with how it's tingling under your groping fingertips, you have no doubt that you're about to see the second coming of your sexy ass.  Wait, how did your fingers get down there?  You pull your hands away somewhat guiltily as you feel your buttcheeks expanding.  Each time you bounce and shake your new derriere, you moan softly in enjoyment.  Damnit!  You force yourself to stop just as your ass does, but when you set off again, you can feel it bouncing behind you with every step.  At least it'll help you tease your foes a little more effectively...\n");
				dynStats("int", -1, "lus", 10);
				player.buttRating = 12;
				needNext = true;
			}
		}
		//Bro checks
		if(player.findPerk(PerkLib.BroBody) >= 0) {
			player.removeStatusAffect(StatusAffects.Feeder);
			player.removePerk(PerkLib.Feeder);
			//(Dick regrowth) 
			if(!player.hasCock()) {
				player.createCock();
				player.cocks[0].cockLength = 10;
				player.cocks[0].cockThickness = 2.75;
				outputText("\n<b>As time passes, your loins grow itchy for a moment.  A split-second later, a column of flesh erupts from your crotch.  Your new, 10-inch cock pulses happily.", false);
				if(player.balls == 0) {
					outputText("  A pair of heavy balls drop into place below it, churning to produce cum.", false);
					player.balls = 2;
					player.ballSize = 3;
				}
				outputText("</b>\n", false);
				needNext = true;
			}
			//(Dick rebiggening) 
			if(player.cocks[0].cockLength < 10) {
				outputText("\n<b>As time passes, your cock engorges, flooding with blood and growing until it's at 10 inches long.  ", false);
				if(player.findPerk(PerkLib.BroBrains) >= 0) outputText("Goddamn, that thing is almost as tough as you!  ", false);
				outputText("You really have no control over your dick.</b>\n", false);
				player.cocks[0].cockLength = 10;
				if(player.cocks[0].cockThickness < 2) player.cocks[0].cockThickness = 2;
				needNext = true;
			}
			//(Balls regrowth)
			if(player.balls == 0) {
				outputText("\n<b>As time passes, a pressure in your loins intensifies to near painful levels.  The skin beneath " + sMultiCockDesc() + " grows loose and floppy, and then two testicles roll down to fill your scrotum.</b>\n", false);
				needNext = true;
				player.balls = 2;
				player.ballSize = 3;
			}
		}
		//Feeder checks
		if(player.findStatusAffect(StatusAffects.Feeder) >= 0) {
			//Go away if pure
			if(player.cor <= 20) {
				outputText("\nThe desire to breastfeed fades into the background.  It must have been associated with the corruption inside you.\n\n(<b>You have lost the 'Feeder' perk.</b>)\n", false);
				player.removeStatusAffect(StatusAffects.Feeder);
				player.removePerk(PerkLib.Feeder);
				needNext = true;
			}
			else {
				//Bigga titayz
				if(player.breastRows[0].breastRating < 5) {
					outputText("\nYour " + breastDescript(0) + " start to jiggle and wobble as time passes, seeming to refill with your inexhaustible supply of milk.  It doesn't look like you'll be able to keep them below a DD cup so long as you're so focused on breast-feeding.\n", false);
					player.breastRows[0].breastRating = 5;
					needNext = true;
				}
				//Increase 'time since breastfed'
				player.addStatusValue(StatusAffects.Feeder,2,1);
				//trace("Feeder status: " + player.statusAffectv2(StatusAffects.Feeder) + " (modded " + ((player.statusAffectv2(StatusAffects.Feeder)) - 70) + ")");
				//After 3 days without feeding someone sensitivity jumps.
				if(player.statusAffectv2(StatusAffects.Feeder) >= 72 && model.time.hours == 14) {
					outputText("\n<b>After having gone so long without feeding your milk to someone, you're starting to feel strange.  Every inch of your skin practically thrums with sensitivity, particularly your sore, dripping nipples.</b>\n", false);
					temp = (2 + (((player.statusAffectv2(StatusAffects.Feeder)) - 70) / 20));
					dynStats("sen", temp);
					needNext = true;
				}
			}
		}
		//Update worm drippy-cooch
		if(player.findStatusAffect(StatusAffects.WormPlugged) >= 0 && flags[kFLAGS.PLAYER_PREGGO_WITH_WORMS] == 0) {
			if(player.hasVagina()) {
				if(rand(5) == 0) {
					flags[kFLAGS.PLAYER_PREGGO_WITH_WORMS] = 1;
					outputText("\nA sudden gush of semen-coated worms noisily slurps out of your womb.  It runs down your legs as the worms do their damnedest to escape.  The feeling of so many squiggling forms squirting through your cunt-lips turns you on more than you'd like to admit.  You wonder why they stayed as long as they did, and some part of you worries that their stay may have reduced your capacity to bear children, though in a place like this that might be a blessing.\n", false);
					needNext = true;
					dynStats("lus", 2+player.sens/10);
					if(player.fertility > 5) player.fertility -= (1 + Math.round(player.fertility/4));
					//Lower chances
					player.addStatusValue(StatusAffects.WormPlugged,1,-1);
					//Remove if too low
					if (player.statusAffectv1(StatusAffects.WormPlugged) <= 0) {
						player.removeStatusAffect(StatusAffects.WormPlugged);
						player.knockUpForce(); //Clear worm 'pregnancy'
					}
				}
			}
			//Non cunts lose worm plugged
			else {
				player.removeStatusAffect(StatusAffects.WormPlugged);
				player.knockUpForce(); //Clear worm 'pregnancy'
			}
		}				
		//Update Exgartuan stuff
		if(player.findStatusAffect(StatusAffects.Exgartuan) >= 0)
		{
			trace("EXGARTUAN V1: " + player.statusAffectv1(StatusAffects.Exgartuan) + " V2: " + player.statusAffectv2(StatusAffects.Exgartuan));
			//if too small dick, remove him
			if(player.statusAffectv1(StatusAffects.Exgartuan) == 1 && (player.cockArea(0) < 100 || player.cocks.length == 0))
			{
				outputText("\n<b>You suddenly feel the urge to urinate, and stop over by some bushes.  It takes wayyyy longer than normal, and once you've finished, you realize you're alone with yourself for the first time in a long time.  Perhaps you got too small for Exgartuan to handle?</b>\n", false);
				player.removeStatusAffect(StatusAffects.Exgartuan);
				needNext = true;
			}
			//Tit removal
			else if(player.statusAffectv1(StatusAffects.Exgartuan) == 2 && player.biggestTitSize() < 12)
			{
				outputText("\n<b>Black milk dribbles from your " + nippleDescript(0) + ".  It immediately dissipates into the air, leaving you feeling alone.  It looks like you became too small for Exgartuan!\n</b>", false);
				player.removeStatusAffect(StatusAffects.Exgartuan);
				needNext = true;
			}		
			else 
			{
				//if sleeping, decrement sleep timer.
				if(player.statusAffectv2(StatusAffects.Exgartuan) > 0)
				{
					player.addStatusValue(StatusAffects.Exgartuan,2,-1);
					//The demon awakens!
					if(player.statusAffectv2(StatusAffects.Exgartuan) == 0)
					{
						outputText("\n<b>", false);
						exgartuan.exgartuanBored();
						needNext = true;
						outputText("</b>\n", false);
					}
				}
				//If not sleeping, stuff happens!
				else 
				{
					//Dude stuff
					if(player.statusAffectv1(StatusAffects.Exgartuan) == 1 && player.cockArea(0) > 100)
					{	
						if(player.findStatusAffect(StatusAffects.Infested) >= 0 ) {
							outputText("\n<b>", false);
							exgartuan.exgartuanWormCure();
							needNext = true;
							outputText("</b>\n", false);	
						}
						else if(rand(10) == 0 && (player.armorName == "sexy black chitin armor-plating" || player.armorName == "glistening gel-armor plates" || player.armorName == "leather armor segments" || player.armorName == "comfortable clothes" || player.armorName == "bondage patient clothes" || player.armorName == "crotch-revealing clothes" || player.armorName == "cute servant's clothes" || player.armorName == "maid's clothes" || player.armorName == "servant's clothes" || player.armorName == "maid's clothes" || player.armorName == "practically indecent steel armor" || player.armorName == "red, high-society bodysuit" || player.armorName == "spider-silk armor" || player.armorName == "slutty swimwear" || player.armorName == "full-body chainmail" || player.armorName == "revealing chainmail bikini" || player.armorName == "full platemail" || player.armorName == "scale-mail armor" || player.armorName == "black leather armor surrounded by voluminous robes" || player.armorName == "rubber fetish clothes" || player.armorName == "green adventurer's clothes" || player.armorName == "white shirt and overalls")) {
							outputText("\n<b>", false);
							exgartuan.exgartuanArmorShift();
							needNext = true;
							outputText("</b>\n", false);	
						}
						else dynStats("lus", 1+rand(2));
					}
					//Chick stuff
					if(player.statusAffectv1(StatusAffects.Exgartuan) == 2 && player.biggestTitSize() >= 12) {
						//Only once every 9 hours or so.
						if(model.time.hours % 9 == 0) {
							// lactation messing with!
							if(rand(3) == 0) {
								outputText("\n<b>", false);
								exgartuan.exgartuanLactationAdjustment();
								outputText("</b>\n", false);	
								needNext = true;
							}
							else if(rand(3) == 0) {
								outputText("\n<b>", false);
								if(rand(2) == 0) outputText("You feel warm and tingly, good all over.  Wait a second, your hands are playing with your " + breastDescript(0) + ".  You yank your hands away, but it only makes Exgartuan laugh with demonic pleasure!", false);
								else {
									outputText("Your hands knead and caress your " + breastDescript(0) + ", eagerly touching every inch of soft flesh.  You gasp when you realize what you're doing and pull them away", false);
									if(player.cor < 50) outputText(", angry at yourself for falling prey to the demon's directions", false);
									outputText(".", false);
									dynStats("lus", 5+player.sens/10);
								}
								needNext = true;
								outputText("</b>\n", false);	
							}
							else dynStats("lus", 1+rand(2));
						}
					}
				}
			}
		}
		//"Milked"
		if(player.findStatusAffect(StatusAffects.Milked) >= 0) {
			player.addStatusValue(StatusAffects.Milked,1,-1);
			if(player.statusAffectv1(StatusAffects.Milked) <= 0) {
				outputText("\n<b>Your " + nippleDescript(0) + "s are no longer sore from the milking.</b>\n", false);
				player.removeStatusAffect(StatusAffects.Milked);
				needNext = true;
			}
		}
		if(player.findStatusAffect(StatusAffects.Jizzpants) >= 0) {
			outputText("\nYour " + player.armorName + " squishes wetly with all the semen you unloaded into them, arousing you more and more with every movement.\n", false);
			needNext = true;
			dynStats("lus", 10 + player.sens/5);
			player.removeStatusAffect(StatusAffects.Jizzpants);
		}
		//Marble's Milk Status! - Now handled by MarbleScene
		//Minotaur dysfunction status countdown (v1 = hours till gone)
		if(player.findStatusAffect(StatusAffects.Dysfunction) >= 0) {
			if(player.statusAffectv1(StatusAffects.Dysfunction) <= 1) {
				player.removeStatusAffect(StatusAffects.Dysfunction);
				outputText("\nYou feel a tingling in your nethers... at last full sensation has returned to your groin.  <b>You can masturbate again!</b>\n", false);
				needNext = true;
			}
			else player.addStatusValue(StatusAffects.Dysfunction,1,-1);
		}
		//Lactation reduction
		if(player.findStatusAffect(StatusAffects.LactationReduction) < 0) {
			if(player.biggestLactation() > 0) {
				player.createStatusAffect(StatusAffects.LactationReduction,0,0,0,0);
			}
		}
		else if(player.biggestLactation() > 0 && player.findStatusAffect(StatusAffects.Feeder) < 0 && player.pregnancyIncubation == 0) {
			player.addStatusValue(StatusAffects.LactationReduction,1,1);
			if(player.statusAffectv1(StatusAffects.LactationReduction) >= 48) {
				if(player.findStatusAffect(StatusAffects.LactationReduc0) < 0) {
					player.createStatusAffect(StatusAffects.LactationReduc0,0,0,0,0);
					if(player.biggestLactation() >= 1) outputText("\n<b>Your " + nippleDescript(0) + "s feel swollen and bloated, needing to be milked.</b>\n", false);
					if(player.biggestLactation() <= 2) player.createStatusAffect(StatusAffects.LactationReduc1,0,0,0,0);
					if(player.biggestLactation() <= 1) player.createStatusAffect(StatusAffects.LactationReduc2,0,0,0,0);
					needNext = true;
				}
				player.boostLactation(-(.5*player.breastRows.length)/24);
				if(player.biggestLactation() <= 2.5 && player.findStatusAffect(StatusAffects.LactationReduc1) < 0) {
					outputText("\n<b>Your breasts feel lighter as your body's milk production winds down.</b>\n", false);
					player.createStatusAffect(StatusAffects.LactationReduc1,0,0,0,0);
					needNext = true;
				}
				else if(player.biggestLactation() <= 1.5 && player.findStatusAffect(StatusAffects.LactationReduc2) < 0) {
					outputText("\n<b>Your body's milk output drops down to what would be considered 'normal' for a pregnant woman.</b>\n", false);
					player.createStatusAffect(StatusAffects.LactationReduc2,0,0,0,0);
					needNext = true;
				}
				if(player.biggestLactation() < 1 && player.findStatusAffect(StatusAffects.LactationReduc3) < 0) {
					player.createStatusAffect(StatusAffects.LactationReduc3,0,0,0,0);
					outputText("\n<b>Your body no longer produces any milk.</b>\n", false);
					player.removeStatusAffect(StatusAffects.LactationReduction);
					needNext = true;
				}
			}
		}
		//Cunt stretching stuff
		if(player.findStatusAffect(StatusAffects.CuntStretched) >= 0) {
			player.addStatusValue(StatusAffects.CuntStretched,1,1);
			if(player.vaginas.length > 0) {
				if(player.findPerk(PerkLib.FerasBoonWideOpen) < 0) {
				if(player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LOOSE && player.statusAffectv1(StatusAffects.CuntStretched) >= 200) {
					outputText("\nYour " + vaginaDescript(0) + " recovers from your ordeals, tightening up a bit.\n", false);
					player.vaginas[0].vaginalLooseness--;
					player.changeStatusValue(StatusAffects.CuntStretched,1,0);
					needNext = true;
				}
				if(player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING && player.statusAffectv1(StatusAffects.CuntStretched) >= 100) {
					outputText("\nYour " + vaginaDescript(0) + " recovers from your ordeals, tightening up a bit.\n", false);
					player.vaginas[0].vaginalLooseness--;
					player.changeStatusValue(StatusAffects.CuntStretched,1,0);
					needNext = true;
				}
				if(player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_GAPING_WIDE && player.statusAffectv1(StatusAffects.CuntStretched) >= 70) {
					outputText("\nYour " + vaginaDescript(0) + " recovers from your ordeals and becomes tighter.\n", false);
					player.vaginas[0].vaginalLooseness--;
					player.changeStatusValue(StatusAffects.CuntStretched,1,0);
					needNext = true;
				}
				}
				if(player.vaginas[0].vaginalLooseness == VAGINA_LOOSENESS_LEVEL_CLOWN_CAR && player.statusAffectv1(StatusAffects.CuntStretched) >= 50) {
					outputText("\nYour " + vaginaDescript(0) + " recovers from the brutal stretching it has received and tightens up a little bit, but not much.\n", false);
					player.vaginas[0].vaginalLooseness--;
					player.changeStatusValue(StatusAffects.CuntStretched,1,0);
					needNext = true;
				}
			}
		}
		//Butt stretching stuff
		if(player.findStatusAffect(StatusAffects.ButtStretched) >= 0) {
			player.addStatusValue(StatusAffects.ButtStretched,1,1);
			if(player.ass.analLooseness == 2 && player.statusAffectv1(StatusAffects.ButtStretched) >= 72) {
				outputText("\n<b>Your " + assholeDescript() + " recovers from your ordeals, tightening up a bit.</b>\n", false);
				player.ass.analLooseness--;
				player.changeStatusValue(StatusAffects.ButtStretched,1,0);
				needNext = true;
			}
			if(player.ass.analLooseness == 3 && player.statusAffectv1(StatusAffects.ButtStretched) >= 48) {
				outputText("\n<b>Your " + assholeDescript() + " recovers from your ordeals, tightening up a bit.</b>\n", false);
				player.ass.analLooseness--;
				player.changeStatusValue(StatusAffects.ButtStretched,1,0);
				needNext = true;
			}
			if(player.ass.analLooseness == 4 && player.statusAffectv1(StatusAffects.ButtStretched) >= 24) {
				outputText("\n<b>Your " + assholeDescript() + " recovers from your ordeals and becomes tighter.</b>\n", false);
				player.ass.analLooseness--;
				player.changeStatusValue(StatusAffects.ButtStretched,1,0);
				needNext = true;
			}
			if(player.ass.analLooseness == 5 && player.statusAffectv1(StatusAffects.ButtStretched) >= 12) {
				outputText("\n<b>Your " + assholeDescript() + " recovers from the brutal stretching it has received and tightens up.</b>\n", false);
				player.ass.analLooseness--;
				player.changeStatusValue(StatusAffects.ButtStretched,1,0);
				needNext = true;
			}
		}
		//Lose slime core perk
		if(player.findPerk(PerkLib.SlimeCore) >= 0) {
			if(player.vaginalCapacity() < 9000 || player.skinAdj != "slimy" || player.skinDesc != "skin" || player.lowerBody != LOWER_BODY_TYPE_GOO) {
				//outputText("\n<b>Your slime core fades away inside of you, now lost forever.</b>\n", false);
				outputText("\nYour form ripples, as if uncertain at the changes your body is undergoing.  The goo of your flesh cools, its sensitive, responsive membrane thickening into " + player.skin() + " while bones and muscles knit themselves into a cohesive torso, chest and hips gaining definition.  Translucent ooze clouds and the gushing puddle at your feet melts together, splitting into solid trunks as you regain your legs.  Before long, you can no longer see through your own body and, with an unsteady shiver, you pat yourself down, readjusting to solidity.  A lurching heat in your chest suddenly reminds you of the slime core that used to float inside you.  Gingerly touching your " + chestDesc() + ", you can feel a small, second heartbeat under your ribs that gradually seems to be sinking, past your belly. A lurching wave of warmth sparks through you, knocking you off your fresh legs and onto your " + buttDescript() + ".  A delicious pressure pulses in your abdomen and you loosen your " + player.armorName + " as sweat beads down your neck.  You clench your eyes, tongue lolling in your mouth, and the pressure builds and builds until, in ecstatic release, your body arches in an orgasmic release.\n\n", false);
 
				outputText("\nPanting, you open your eyes and see that, for once, the source of your climax wasn't your loins.  Feeling a warm, wetness on your abs, you investigate and find the small, heart-shaped nucleus that used to be inside your body has somehow managed to pass through your belly button. Exposed to the open air, the crimson organ slowly crystallizes, shrinking and hardening into a tiny ruby.  Rubbing the stone with your thumb, you're surprised to find that you can still feel a pulse within its glittering facets.  You stow the ruby heart, in case you need it again.\n", false);
				//[Add 'Ruby Heart' to key items. Player regains slime core if returning to goo body]
				player.createKeyItem("Ruby Heart",0,0,0,0);
				needNext = true;
				player.removePerk(PerkLib.SlimeCore);
			}
		}
		//Regain slime core
		if(player.hasKeyItem("Ruby Heart") >= 0) {
			if(player.findStatusAffect(StatusAffects.SlimeCraving) >= 0 && player.findPerk(PerkLib.SlimeCore) < 0 && player.isGoo() && player.gooScore() >= 4 && player.vaginalCapacity() >= 9000 && player.skinAdj == "slimy" && player.skinDesc == "skin" && player.lowerBody == LOWER_BODY_TYPE_GOO) {
				outputText("\nAs you adjust to your new, goo-like body, you remember the ruby heart you expelled so long ago.  As you reach to pick it up, it quivers and pulses with a warm, cheerful light.  Your fingers close on it and the nucleus slides through your palm, into your body!\n\n", false);
				
				outputText("There is a momentary pressure in your chest and a few memories that are not your own flicker before your eyes.  The dizzying sight passes and the slime core settles within your body, imprinted with your personality and experiences.  There is a comforting calmness from your new nucleus and you feel as though, with your new memories, you will be better able to manage your body's fluid requirements.\n", false);
				//(Reduces Fluid Addiction to a 24 hour intake requirement).
				outputText("(<b>Gained New Perk: Slime Core - Moisture craving builds at a greatly reduced rate.</b>\n)", false);
				player.createPerk(PerkLib.SlimeCore,0,0,0,0);
				player.removeKeyItem("Ruby Heart");
			}
		}
		//Slime craving stuff
		if(player.findStatusAffect(StatusAffects.SlimeCraving) >= 0) {
			if(player.vaginalCapacity() < 9000 || player.skinAdj != "slimy" || player.skinDesc != "skin" || player.lowerBody != LOWER_BODY_TYPE_GOO) {
				outputText("\n<b>You realize you no longer crave fluids like you once did.</b>\n", false);
				needNext = true;
				player.removeStatusAffect(StatusAffects.SlimeCraving);
				player.removeStatusAffect(StatusAffects.SlimeCravingFeed);
			}
			else {
				//Slime core reduces fluid need rate
				if(player.findPerk(PerkLib.SlimeCore) >= 0) player.addStatusValue(StatusAffects.SlimeCraving,1,.5);
				else player.addStatusValue(StatusAffects.SlimeCraving,1,1);
				if(player.statusAffectv1(StatusAffects.SlimeCraving) >= 18) {
					if(player.findStatusAffect(StatusAffects.SlimeCravingOutput) < 0) {
						player.createStatusAffect(StatusAffects.SlimeCravingOutput,0,0,0,0);
						outputText("\n<b>Your craving for the 'fluids' of others grows strong, and you feel yourself getting weaker and slower with every passing hour.</b>\n", false);
						needNext = true;
					}
					dynStats("str", -.1,"spe", -.1, "lus", 2);
					//Keep track of how much has been taken from speed/strength
					player.addStatusValue(StatusAffects.SlimeCraving,2,.1);
					//Bad end!
					if(player.str <= 1) {
						outputText("Your entire body wobbles as your strength fails, collapsing into itself.  You struggle to rise, but your form loses more and more rigidity, melting into an amorphous blob.  Without the strength to rise, you've no hope of getting the fluids you need.  The aching craving for moisture drives you to roll to the lake, which you slip into.  With the constant runoff of bodily fluids that enter the lake, you're able to subsist for a time, forgetting about your mission as the all-consuming need devours your personality.", false);
						doNext(1063);
						return true;
					}
				}
			}
		}
		if(model.time.hours == 6 && player.armorName == "bimbo skirt" && rand(10) == 0) {
			outputText("\n<b>As you wake up, you feel a strange tingling starting in your nipples that extends down into your breasts.  After a minute, the tingling dissipates in a soothing wave.  As you cup your tits, you realize they've gotten larger!</b>");
			player.growTits(1,player.bRows(),false,2);
			needNext = true;
			dynStats("lus", 10);
		}
		//Slime feeding stuff
		if(player.findStatusAffect(StatusAffects.SlimeCravingFeed) >= 0) {
			outputText("\n<b>You feel revitalized from your recent intake, but soon you'll need more...</b>\n", false);
			//Boost speed and restore hp/toughness
			dynStats("str", player.statusAffectv2(StatusAffects.SlimeCraving) * .5,"spe", player.statusAffectv2(StatusAffects.SlimeCraving));
			//Remove feed succuss status so it can be reset
			player.removeStatusAffect(StatusAffects.SlimeCravingFeed);
			//Reset stored hp/toughness values
			player.changeStatusValue(StatusAffects.SlimeCraving,2,0);
			needNext = true;
		}
		//Bee Sting Recharge
		if(player.tailType == TAIL_TYPE_BEE_ABDOMEN || player.tailType == TAIL_TYPE_SPIDER_ADBOMEN) {
			if(player.tailRecharge < 5) player.tailRecharge = 5;
			player.tailVenom += player.tailRecharge;
			if(player.tailVenom > 100) player.tailVenom = 100;
		}
		//Helia nightmare - Now handled in HelScene
		//Luststick resistance unlock
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00285] >= 50 && player.findPerk(PerkLib.LuststickAdapted) < 0) {
			sophieBimbo.unlockResistance();
			needNext = true;
			if(player.findStatusAffect(StatusAffects.Luststick) >= 0) player.removeStatusAffect(StatusAffects.Luststick);
		}
		//Sophie's love - Now handled in SophieScene
		if(flags[kFLAGS.BIKINI_ARMOR_BONUS] > 0) {
			if(player.armorName == "lusty maiden's armor") {
				//Adjust for inflation
				if(model.time.hours > 23) flags[kFLAGS.BIKINI_ARMOR_BONUS]--;
				//Keep in bounds.
				if(flags[kFLAGS.BIKINI_ARMOR_BONUS] < 0) flags[kFLAGS.BIKINI_ARMOR_BONUS] = 0;
				if(flags[kFLAGS.BIKINI_ARMOR_BONUS] > 8) flags[kFLAGS.BIKINI_ARMOR_BONUS] = 8;
			}
			else flags[kFLAGS.BIKINI_ARMOR_BONUS] = 0;
		}
		if(model.time.hours > 23) {
			model.time.hours = 0;
			model.time.days++;
			//Lynette pregnancy - Now handled in Salon
			//Kelly reward cooldown - Now handled in Kelly
			//HelSpawn counter - Now handled in HelScene
			//Per day Arian stuff - Now handled in ArianScene
			flags[kFLAGS.BROOKE_MET_TODAY] = 0;
			if(model.time.days % 2 == 0 && flags[kFLAGS.KAIJU_BAD_END_COUNTER] > 0) {
				flags[kFLAGS.KAIJU_BAD_END_COUNTER]--;
				if(flags[kFLAGS.KAIJU_BAD_END_COUNTER] < 0) flags[kFLAGS.KAIJU_BAD_END_COUNTER] = 0;
			}
			//Phylla egg laying, gem hunting - Now handled in AntsScene
			if(flags[kFLAGS.GILDED_JERKED] > 0) flags[kFLAGS.GILDED_JERKED] = 0;
			//Sheila stuff - Now handled in SheilaScene
			//Urta cum stuff - Now handled in Urta
			if(flags[kFLAGS.FED_SCYLLA_TODAY] == 1) flags[kFLAGS.FED_SCYLLA_TODAY] = 0;
			//Count Kelt being a bitch - Now handled in Kelly
			//Sand Witch egg pregnancy - Now handled by SandWitchScene
			//Marae met 2nd time?
			if(flags[kFLAGS.CORRUPT_MARAE_FOLLOWUP_ENCOUNTER_STATE] > 0) {
				//If flower hasn't been burned down yet
				if(flags[kFLAGS.FUCK_FLOWER_KILLED] == 0) {
					//Grow flower if it isn't fully grown.
					if(flags[kFLAGS.FUCK_FLOWER_LEVEL] < 4 && flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER] < 1000) {
						flags[kFLAGS.FUCK_FLOWER_GROWTH_COUNTER]++;
					}
				}
			}
			//if(flags[kFLAGS.RUBI_ORGASM_DENIAL] > 0) flags[kFLAGS.RUBI_BLU_BALLS]++;
			if(flags[kFLAGS.RUBI_PROSTITUTION] > 0) flags[kFLAGS.RUBI_PROFIT] += 2 + rand(4);
			flags[kFLAGS.BENOIT_TALKED_TODAY] = 0;
			bazaar.benoit.updateBenoitInventory();
			//Vapula stuff - Now handled in Vapula
			//Amily Jojo and incest countdown - Now handled in AmilyScene
			flags[kFLAGS.ROGAR_FUCKED_TODAY] = 0;
			//Isabella milk - Now handled in IsabellaScene
			//Reduce lust-stick resistance building
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00285] > 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00285]--;
			//Dominika fellatrix countdown
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00155] > 0) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00155]--;
				if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00155] < 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00155] = 0;
			}
			//Loppe denial counter
			if(flags[kFLAGS.LOPPE_DENIAL_COUNTER] > 0) {
				flags[kFLAGS.LOPPE_DENIAL_COUNTER]--;
				if(flags[kFLAGS.LOPPE_DENIAL_COUNTER] < 0) flags[kFLAGS.LOPPE_DENIAL_COUNTER] = 0;
			}
			//Reset Izma tooth hand outs - Now handled in IzmaScene
			//Move Raphael Countdowns
			if(flags[kFLAGS.RAPHAEL_DRESS_TIMER] > 1 && player.gems >= 5) flags[kFLAGS.RAPHAEL_DRESS_TIMER]--;
			if(flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] > 1 && player.gems >= 5) flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER]--;
			//Fix 'hangs' - PC is at the bottom of the dress countdown
			if(flags[kFLAGS.RAPHAEL_DRESS_TIMER] == 1 && flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == 0 && raphael.RaphaelLikes()) flags[kFLAGS.RAPHAEL_DRESS_TIMER] = 4;
			//Countdown to next faerie orgy
			if(flags[kFLAGS.WEEKLY_FAIRY_ORGY_COUNTDOWN] > 0) {
				flags[kFLAGS.WEEKLY_FAIRY_ORGY_COUNTDOWN]--;
				if(flags[kFLAGS.WEEKLY_FAIRY_ORGY_COUNTDOWN] < 0) flags[kFLAGS.WEEKLY_FAIRY_ORGY_COUNTDOWN] = 0;
			}
			//Clear Whitney's Weekly limit
			if(model.time.days % 7 == 0) flags[kFLAGS.WHITNEY_GEMS_PAID_THIS_WEEK] = 0;
			//Clear 'has fucked milker today'
			if(flags[kFLAGS.USED_MILKER_TODAY] > 0) flags[kFLAGS.USED_MILKER_TODAY] = 0;
			//Reduce bad-end for cerulean herms number
			if(flags[kFLAGS.CERULEAN_POTION_BAD_END_FUTA_COUNTER] > 0) flags[kFLAGS.CERULEAN_POTION_BAD_END_FUTA_COUNTER] -= 0.5;
			//Update Urta's luv counter - Now handled in Urta
			//Latex goo follower daily updates
			if(latexGirl.latexGooFollower()) {
				latexGirl.gooFluid(-2, false);
				if(latexGirl.gooFluid() < 50) latexGirl.gooHappiness(-1,false);
				if(latexGirl.gooFluid() < 25) latexGirl.gooHappiness(-1,false);
				if(latexGirl.gooHappiness() < 75) latexGirl.gooObedience(-1,false);
				if(latexGirl.gooHappiness() >= 90) latexGirl.gooObedience(1,false);
			}
			
			// Holli Fuck Tracking
			if (flags[kFLAGS.HOLLI_FUCKED_TODAY] == 1) flags[kFLAGS.HOLLI_FUCKED_TODAY] = 0;
			
			// Farm Corruption updating
			farm.farmCorruption.updateFarmCorruption();
			
			// Herbal contraceptives countdown
			if (player.findStatusAffect(StatusAffects.Contraceptives) >= 0)
			{
				if ((player as Player).statusAffectv1(StatusAffects.Contraceptives) == 1)
				{
					(player as Player).addStatusValue(StatusAffects.Contraceptives, 2, -1);
					
					if (player.statusAffectv1(StatusAffects.Contraceptives) < 0)
					{
						(player as Player).removeStatusAffect(StatusAffects.Contraceptives);
					}
				}
			}
			
			//Tamani's Daughters stuff - Now handled by TamaniDaughtersScene
			//Tamani pregnancy counting - Now handled by TamaniScene
			//Remove jojo meditation block - Now handled by JojoScene
			//Lower addiction by 1 every day. - Now handled in MarbleScene
			//Lower shark girl counter
			if(player.statusAffectv1(StatusAffects.SharkGirl) > 0) player.addStatusValue(StatusAffects.SharkGirl,1,-1);
			if(flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] > 0) {
				switch (flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED]) {
					case 1:
						if(!needNext) needNext = growHair(.2);
						else growHair(.2);
						break;
					case 2:
						if(!needNext) needNext = growHair(.5);
						else growHair(.5);
						break;
					case 3:
						if(!needNext) needNext = growHair(1.1);
						else growHair(1.1);
						break;
					default:
						break;
				}
				flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING]--;
				//reset hair growth multiplier and timer when 
				//expired.
				if(flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] <= 0) {
					flags[kFLAGS.INCREASED_HAIR_GROWTH_TIME_REMAINING] = 0;
					flags[kFLAGS.INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] = 0;
					needNext = true;
					outputText("<b>\nThe tingling on your scalp slowly fades away as the hair extension serum wears off.  Maybe it's time to go back to the salon for more?</b>", false);
					//Restart hair growth if wuz lizard-stopped
					if(flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] > 0) {
						flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] = 0;
						outputText("  <b>You hair is now growing normally again.</b>", false);
					}
					outputText("\n", false);
				}
			}
			//Hair grows if not disabled by lizardness
			if(flags[kFLAGS.HAIR_GROWTH_STOPPED_BECAUSE_LIZARD] == 0) {
				if(!needNext) needNext = growHair(.1);
				else growHair(.1);
			}
			//Lower bonus score for drinking contest - Now handled in Roxanne
			//Clear dragon breath cooldown!
			if(player.findStatusAffect(StatusAffects.DragonBreathCooldown) >= 0) player.removeStatusAffect(StatusAffects.DragonBreathCooldown);
		}
		if(model.time.hours > 20 && model.time.hours - 1 <= 20) {
			outputText("\nThe sky darkens as a starless night falls.  The blood-red moon slowly rises up over the horizon.\n", false);
			needNext = true;
		}
		if(model.time.hours >= 6 && model.time.hours-1 < 6) {
			outputText("\nThe sky begins to grow brighter as the moon descends over distant mountains, casting a few last ominous shadows before they burn away in the light.\n", false);
			needNext = true;
		}
		//Amily stuff! - Now handled in AmilyScene
		//BIG EVENTS GO IN HERE
		//BIG EVENTS GO IN HERE
		//BIG EVENTS GO IN HERE
		//BIG EVENTS GO IN HERE

		//Helia's morning surprise!  TOP PRIORITY! - Left this here just in case
		if(model.time.hours == 23 && helFollower.followerHel() && flags[kFLAGS.HEL_BONUS_POINTS] >= 150 && flags[kFLAGS.HELIA_KIDS_CHAT] == 0) {
			helSpawnScene.heliaBonusPointsAward();
			return true;
		}
		/* Inform all time aware classes that it's time for large events to trigger. Note that timeChangeLarge could be called multiple times in a single tick
		   of the clock, so any updates should happen in timeChange and any timeChangeLarge events need to make sure they cannot repeat within the same hour.
		   In effect these are the same rules the existing code acted under. */
		for (var tacLarge:int = 0; tacLarge < _timeAwareClassList.length; tacLarge++) if (_timeAwareClassList[tacLarge].timeChangeLarge()) return true;

		//Edryn carrying Taoth - Now handled by Edryn
		//Sophie pure recruitment - Now handled by SophieScene
		//Big events for Helia and Helspawn - Now handled by HelScene
		//Shouldra events - Now handled in ShouldraScene
		//Ember rapes player due to heat - Now handled in EmberScene
		if(rand(4) == 0 && isHolidays() && player.gender > 0 && model.time.hours == 6 && flags[kFLAGS.XMAS_CHICKEN_YEAR] < date.fullYear) {
			getAChristmasChicken();
			return true;
		}
		//Amily X Urta morning after. - Now handled in AmilyScene
		//Vapula recruitment - Now handled in Vapula
		var ceraph:Number = 0;
		//Ceraph's dreams - overlaps normal night-time dreams.
		//Once every 10 days if 1, once every 7 days if 2, once every 5 days if 3
		temp = flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00218] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00219] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00220];
		if(temp == 1) ceraph = 10;
		else if(temp == 2) ceraph = 7;
		else if(temp == 3) ceraph = 5;
		else if(temp == 4) ceraph = 4;
		else if(temp >= 5) ceraph = 3;
		//DREAMS
		//Shouldra dreams here - Now handled in ShouldraScene
		if(shouldraFollower.followerShouldra() && flags[kFLAGS.SHOULDRA_PLOT_COUNTDOWN] > 0 && model.time.hours == 3) {
			flags[kFLAGS.SHOULDRA_PLOT_COUNTDOWN]--;
			if(flags[kFLAGS.SHOULDRA_PLOT_COUNTDOWN] <= 0) {
				shouldraFollower.shouldraDream1();
				return true;
			}
		}
		//Bee dreams proc
		if(player.hasCock() && player.findPerk(PerkLib.BeeOvipositor) >= 0 && model.time.hours == 3 && (player.eggs() >= 20 && rand(6) == 0)) {
			//happens at first sleep after hitting stage 3 unfertilized
			//To Wong Foo, Thanks for Everything, Julie Newmar
			outputText("\nYou sit atop your favorite flower, enjoying the smell of verdure and the sounds of the forest.  The sun is shining brightly and it feels wonderful on your chitin.  Your wings twitch happily in the soft breeze, and it feels good to be alive and doing the colony's work... the only sour note is your heavy, bloated abdomen, so full of unfertilized eggs that it droops, so full it strains your back and pinches your nerves.  Still, it's too nice a day to let that depress you, and you take up your customary song, humming tunelessly but mellifluously as you wait for passers-by.");
			
			outputText("\n\nYour antennae bob - was that someone?  Peering between the trees from the corner of your eye, you can see the figure of another person, and you intensify your hypnotic buzz, trying to draw it closer.  The figure steps into your clearing and out of the shadow; clad in " + player.armorName + ", " + player.mf("he","she") + " is yourself!  Confused, you stop humming and stare into your own face, and the other you takes the opportunity to open " + player.mf("his","her") + " garments, exposing " + player.mf("his","her") + " [cock]!");
			
			outputText("\n\nStartled, you slip down from your seat and try to run, but the other you has already crossed the clearing and seizes you by the fuzz on your hefty, swollen abdomen; your leg slips, propelling you face-first to the ground.  " + player.mf("He","She") + " pulls you back toward " + player.mf("his","her") + "self and, grabbing one of your chitinous legs, turns you over.  The other you spreads your fuzzed thighs, revealing your soft, wet pussy, and the sweet smell of honey hits your noses.  " + player.mf("His","Her") + " prick hardens intensely and immediately at the aroma of your pheromone-laden nectar, and " + player.mf("he","she") + " pushes it into you without so much as a word of apology, groaning as " + player.mf("he","she") + " begins to rut you mercilessly.  You can feel the sensations of " + player.mf("his","her") + " burning cock as if it were your own, and your legs wrap around your other self instinctively even as your mind recoils in confusion.");
			
			outputText("\n\nThe other you grunts and locks up as " + player.mf("his","her") + "... your [cock] begins to spurt inside your honey-drooling cunt, and " + player.mf("he","she") + " falls onto you, bottoming out inside; your vagina likewise clenches and squirts your sweet juices.  As " + player.mf("he","she") + " ejaculates, thrusting weakly, you can feel something shifting in you, filling you with pins and needles... it feels like the warm cum " + player.mf("he","she") + "'s filling you with is permeating your entire groin, working its way back toward your abdomen.  It edges up to your massive buildup of eggs, and your body tightens in a second climax at the thought of having your children fertilized-");
			
			outputText("\n\nYou snap awake, sitting bolt upright.  What in the name of... your " + multiCockDescriptLight() + " is softening rapidly, and as you shift, you can feel your cum sloshing in your [armor].  For fuck's sake.");
			if(player.cumQ() >= 1000) outputText("  It's completely soaked your bedroll, too... you won't be sleeping on this again until you wash it out.  Grumbling, you roll the soggy, white-stained fabric up and stow it.");
			outputText("  The sensation of wetness inside your own clothes torments you as you try to return to sleep, driving up your lust and making you half-hard once again... the rumbling of eggs in your abdomen, as if they're ready to be laid, doesn't help either.");
			//convert eggs to fertilized based on player cum output, reduce lust by 100 and then add 20 lust
			if(player.hasCock()) player.fertilizeEggs();
			//reduce lust by 100 and add 20, convert eggs to fertilized depending on cum output
			player.orgasm();
			dynStats("lus", 20);
			doNext(1);
			//Hey Fenoxo - maybe the unsexed characters get a few \"cock up the ovipositor\" scenes for fertilization with some characters (probably only willing ones)?
			//Hey whoever, maybe you write them? -Z
			return true;
		}
		//Drider dreams proc
		if(player.hasCock() && player.findPerk(PerkLib.SpiderOvipositor) >= 0 && model.time.hours == 3 && (player.eggs() >= 20 && rand(6) == 0)) {
			//parser calls go to the player's attributes here
			outputText("\nIn a moonlit forest, you hang upside down from a thick tree branch suspended by only a string of webbing.  You watch with rising lust as a hapless traveler strolls along below, utterly unaware of the trap you've set.  Your breath catches as " + player.mf("he","she") + " finally encounters your web, flailing against the sticky strands in a futile attempt to free " + player.mf("him","her") + "self.  Once the traveller's struggles slow in fatigue, you descend easily to the forest floor, wrapping " + player.mf("him","her") + " in an elegant silk cocoon before pulling " + player.mf("him","her") + " up into the canopy.  Positioning your catch against the tree's trunk, you sink your fangs through the web and into flesh, feeling " + player.mf("his","her") + " body heat with every drop of venom.  Cutting " + player.mf("his","her") + " crotch free of your webbing, you open " + player.mf("his","her") + " [armor] and release the ");
			if(player.gender == 3) outputText(vaginaDescript(0) + " and ");
			outputText(cockDescript(0) + " therein; you lower yourself onto " + player.mf("him","her") + " over and over again, spearing your eager pussy with " + player.mf("him","her") + " prick");
			if(player.gender == 3) outputText(" while you bend and force your own into her cunt");
			outputText(".  It's not long until you feel ");
			if(player.gender == 3) outputText("her pussy clenching around you as you orgasm explosively inside, followed by ");
			outputText("the sensation of warm wetness in your own vagina.  Your prisoner groans as " + player.mf("his","her") + " cock twitches and spasms inside you, spraying your insides with seed; warm, delicious, sticky seed for your eggs.  You can feel it drawing closer to your unfertilized clutch, and as the gooey heat pushes toward them, your head swims, and you finally look into your prey's [face]...");
			
			outputText("\n\nYour eyes flutter open.  What a strange dream... aw, dammit.  You can feel your [armor] rubbing against your crotch, sodden with cum.  ");
			if(player.cumQ() > 1000) outputText("It's all over your bedroll, too...");
			outputText("  Turning over and trying to find a dry spot, you attempt to return to sleep... the wet pressure against your crotch doesn't make it easy, nor do the rumbles in your abdomen, and you're already partway erect by the time you drift off into another erotic dream.  Another traveler passes under you, and you prepare to snare her with your web; your ovipositor peeks out eagerly and a bead of slime drips from it, running just ahead of the first fertilized egg you'll push into your poor victim...");
			if(player.hasCock()) player.fertilizeEggs();
			//reduce lust by 100 and add 20, convert eggs to fertilized depending on cum output
			player.orgasm();
			dynStats("lus", 20);
			doNext(1);
			//Hey Fenoxo - maybe the unsexed characters get a few \"cock up the ovipositor\" scenes for fertilization with some characters (probably only willing ones)?
			//Hey whoever, maybe you write them? -Z
			return true;
		}
		if(model.time.hours == 3) {
			//Plot dreams here
			if(ceraph > 0 && model.time.days % ceraph == 0) {
				ceraphScene.ceraphBodyPartDreams();
				doNext(1);
				return true;
			}
			//Dominika Dream
			else if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] > 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] < 4) {
				outputText("\n<b>Your rest is somewhat troubled with odd dreams...</b>\n", false);
				telAdre.dominika.fellatrixDream();
				doNext(1);
				return true;
			}
			//Day 10 dream forcing
			else if(player.gender > 0 && model.time.days == 10) {
				dayTenDreams();
				doNext(1);
				return true;
			}
			else if(anemoneScene.kidAXP() >= 40 && flags[kFLAGS.HAD_KID_A_DREAM] == 0 && player.gender > 0) {
				anemoneScene.kidADreams();
				doNext(1);
				flags[kFLAGS.HAD_KID_A_DREAM] = 1;
				return true;
			}
			else if(player.viridianChange()) {
				fuckedUpCockDreamChange();
				return true;
			}
			//Randomly generated dreams here
			else if((player.lib > 50 || player.lust > 40) && model.time.hours == 3) 
			{
				if(dreamSelect()) return true;
			}	
		}
		//XMAS ELF
		if(model.time.hours == 1 && isHolidays() && date.fullYear > flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE]) {
			//Set it to remember the last year encountered
			xmasBitchEncounter();
			return true;
		}
		//TURKEY SURPRISE
		if((rand(5) == 0 && (model.time.hours == 18 || model.time.hours == 19)) && (date.fullYear > flags[kFLAGS.TURKEY_FUCK_YEAR_DONE] || flags[kFLAGS.MORE_TURKEY] > 0) && isThanksgiving() && player.gender > 0) {
			datTurkeyRumpMeeting();
			return true;
		}
		//IMP GANGBAAAAANGA
		//The more imps you create, the more often you get gangraped. 
		temp = player.statusAffectv1(StatusAffects.BirthedImps) * 2;
		if(temp > 7) temp = 7;
		if(player.findPerk(PerkLib.PiercedLethite) >= 0) temp += 4;
		if(player.inHeat) temp += 2;
		if(vapula.vapulaSlave()) temp += 7;
		if(model.time.hours == 2) {
			if(model.time.days % 30 == 0 && flags[kFLAGS.ANEMONE_KID] > 0 && player.hasCock() && flags[kFLAGS.ANEMONE_WATCH] > 0 && flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 40) {
				anemoneScene.goblinNightAnemone();
				needNext = true;
			}
			else if(temp > rand(100) && player.findStatusAffect(StatusAffects.DefenseCanopy) < 0) {
				if(player.gender > 0 && (player.findStatusAffect(StatusAffects.JojoNightWatch) < 0 || player.findStatusAffect(StatusAffects.PureCampJojo) < 0) && (flags[kFLAGS.HEL_GUARDING] == 0 || !helFollower.followerHel()) && flags[kFLAGS.ANEMONE_WATCH] == 0 && (flags[kFLAGS.HOLLI_DEFENSE_ON] == 0 || flags[kFLAGS.FUCK_FLOWER_KILLED] > 0) && (flags[kFLAGS.KIHA_CAMP_WATCH] == 0 || !kihaFollower.followerKiha())) {
					impScene.impGangabangaEXPLOSIONS();
					doNext(1);
					return true;
				}
				else if(flags[kFLAGS.KIHA_CAMP_WATCH] > 0 && kihaFollower.followerKiha()) {
					outputText("\n<b>You find charred imp carcasses all around the camp once you wake.  It looks like Kiha repelled a swarm of the little bastards.</b>\n");
					needNext = true;
				}
				else if(flags[kFLAGS.HEL_GUARDING] > 0 && helFollower.followerHel()) {
					outputText("\n<b>Helia informs you over a mug of beer that she whupped some major imp asshole last night.  She wiggles her tail for emphasis.</b>\n");
					needNext = true;
				}
				else if(player.gender > 0 && player.findStatusAffect(StatusAffects.JojoNightWatch) >= 0 && player.findStatusAffect(StatusAffects.PureCampJojo) >= 0) {
					outputText("\n<b>Jojo informs you that he dispatched a crowd of imps as they tried to sneak into camp in the night.</b>\n", false);
					needNext = true;
				}
				else if(flags[kFLAGS.HOLLI_DEFENSE_ON] > 0) {
					outputText("\n<b>During the night, you hear distant screeches of surprise, followed by orgasmic moans.  It seems some imps found their way into Holli's canopy...</b>\n");
					needNext = true;
				}
				else if(flags[kFLAGS.ANEMONE_WATCH] > 0) {
					outputText("\n<b>Your sleep is momentarily disturbed by the sound of tiny clawed feet skittering away in all directions.  When you sit up, you can make out Kid A holding a struggling, concussed imp in a headlock and wearing a famished expression.  You catch her eye and she sheepishly retreats to a more urbane distance before beginning her noisy meal.</b>\n");
					needNext = true;
				}
			}
			//wormgasms
			else if(flags[kFLAGS.EVER_INFESTED] == 1 && rand(100) <= 4 && player.hasCock() && player.findStatusAffect(StatusAffects.Infested) < 0) {
				if(player.hasCock() && (player.findStatusAffect(StatusAffects.JojoNightWatch) < 0 || player.findStatusAffect(StatusAffects.PureCampJojo) < 0) && (flags[kFLAGS.HEL_GUARDING] == 0 || !helFollower.followerHel()) && flags[kFLAGS.ANEMONE_WATCH] == 0) {
					nightTimeInfestation();
					return true;
				}
				else if(flags[kFLAGS.HEL_GUARDING] > 0 && helFollower.followerHel()) {
					outputText("\n<b>Helia informs you over a mug of beer that she stomped a horde of gross worms into paste.  She shudders after at the memory.</b>\n");
					needNext = true;
				}
				else if(player.gender > 0 && player.findStatusAffect(StatusAffects.JojoNightWatch) >= 0 && player.findStatusAffect(StatusAffects.PureCampJojo) >= 0) {
					outputText("\n<b>Jojo informs you that he dispatched a horde of tiny, white worms as they tried to sneak into camp in the night.</b>\n", false);
					needNext = true;
				}
				else if(flags[kFLAGS.ANEMONE_WATCH] > 0) {
					outputText("\n<b>Kid A seems fairly well fed in the morning, and you note a trail of slime leading off in the direction of the lake.</b>\n"); // Yeah, blah blah travel weirdness. Quickfix so it seems logically correct.
					needNext = true;
				}
			}
		}
		//Chance of threesomes!
		if(flags[kFLAGS.HEL_FUCKBUDDY] == 1 && isabellaFollowerScene.isabellaFollower() && model.time.hours == 2 && model.time.days % 11 == 0 && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) {
			trace("ISABELLA/HELL TEST");
			//Hell/Izzy threesome intro
			if(flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] == 0) {
				spriteSelect(31);
				helScene.followrIzzyxSallyThreesomePretext();
				return true;
			}
			//Propah threesomes here!
			else if(flags[kFLAGS.HEL_ISABELLA_THREESOME_ENABLED] == 1) {
				spriteSelect(31);
				helScene.isabellaXHelThreeSomeCampStart();
				return true;
			}
		}
		if(model.time.hours == 2 && vapula.vapulaSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 0 && flags[kFLAGS.VAPULA_DAYS_SINCE_FED] >= 5 && (player.hasCock() || (player.hasKeyItem("Demonic Strap-On") >= 0 && player.hasVagina()))) {
			vapula.vapulaForceFeeds();
			return true;
		}
		//Dreams on hour 3.
		if(model.time.hours == 4) {
			if(player.findStatusAffect(StatusAffects.SuccubiNight) >= 0 && (player.totalCocks() >= 1 || (player.gender == 0))) {
				//Call secksins!
				if(player.findStatusAffect(StatusAffects.RepeatSuccubi) >= 0) {
					//VapulaSurprise
					if(vapula.vapulaSlave() && player.hasCock() && flags[kFLAGS.VAPULA_THREESOMES] > 0 && flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 0)
						vapula.vapulaAssistsCeruleanSuccubus();
					//Normal night succubi shit
					else {
						doNext(1);
						camp.nightSuccubiRepeat();
					}
				}
				else {
					player.createStatusAffect(StatusAffects.SuccubiFirst,0,0,0,0);
					eventParser(2025);
					player.createStatusAffect(StatusAffects.RepeatSuccubi,0,0,0,0);
				}
				//Lower count if multiples stacked up.
				if(player.statusAffectv1(StatusAffects.SuccubiNight) > 1) {
					player.addStatusValue(StatusAffects.SuccubiNight,1,-1);
				}
				else player.removeStatusAffect(StatusAffects.SuccubiNight);
				if(player.findStatusAffect(StatusAffects.SuccubiFirst) >= 0) {
					if(player.gender > 0) doNext(2026);
					player.removeStatusAffect(StatusAffects.SuccubiFirst);
				}
				return true;
			}
			//Exgartuan night time surprise!
			else if(player.totalCocks() > 0 && player.statusAffectv1(StatusAffects.Exgartuan) == 1 && rand(3) == 0 && player.hoursSinceCum >= 24) {
				outputText("\n", false);
				exgartuan.exgartuanSleepSurprise();
				return true;
			}
			//Boobgartuan night time surprise!
			if(player.statusAffectv1(StatusAffects.Exgartuan) == 2 && rand(3) == 0 && player.statusAffectv2(StatusAffects.Exgartuan) == 0) {
				outputText("\n", false);
				exgartuan.boobGartuanSURPRISE();
				return true;
			}
		}
		//MORNING FUX (with Sophie) - Now handled by SophieScene
		//MARBLE STUFF - Now handled by MarbleScene
		//END STUFF MOVED FROM doRest() & doSleep()
		//Raphae, the Russet Rogue!
		if(model.time.hours == 6 && flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] >= 0 && player.hasKeyItem("Camp - Chest") >= 0 && player.gems >= 5 && player.statusAffectv1(StatusAffects.TelAdre) >= 1) {
			/*trace("RAPHAEL FINAL COUNTDOWN: " + flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER]);
			trace("RAPHAEL MET: " + flags[kFLAGS.RAPHAEL_MET]);
			trace("RAPHAEL DRESS TIMER: " + flags[kFLAGS.RAPHAEL_DRESS_TIMER]);
			trace("RAPHAEL DISGUSTED: " + flags[kFLAGS.RAPHAEL_DISGUSTED_BY_PC_APPEARANCE]);*/
			
			//Countdown to finale not currently engaged!
			if(flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == 0) {
				//If the PC meets his criteria!
				if(raphael.RaphaelLikes()) {
					//Not yet met!  MEETING TIEM!
					if(flags[kFLAGS.RAPHAEL_MET] == 0) {
						outputText("<b>\nSomething unusual happens that morning...</b>\n", false);
						doNext(raphael.meetRaphael);
						return true;
					}
					//Already met!
					else {
						//Not given dress yet
						if(flags[kFLAGS.RAPHAEL_DRESS_TIMER] == 0 && flags[kFLAGS.RAPHAEL_SECOND_DATE] == 0) {
							outputText("<b>\nSomething unusual happens that morning...</b>\n", false);
							doNext(raphael.RaphaelDress);
							return true;
						}
						//Dress followup - Call picnic date prologue!
						if(player.armorName == "red, high-society bodysuit"  && (flags[kFLAGS.RAPHAEL_DRESS_TIMER] > 1 && flags[kFLAGS.RAPHAEL_DRESS_TIMER] <= 4)) {
							outputText("<b>\nSomething unusual happens that morning...</b>\n", false);
							doNext(raphael.RaphaelEncounterIIDressFollowup);
							return true;
						}
					}
				}
				//If the PC does not currently meet his criteria
				else {
					//Dress countdown - if pc isn't wearing it yet, kick out to
					//Finale!
					if(flags[kFLAGS.RAPHAEL_DRESS_TIMER] == 1) {
						flags[kFLAGS.RAPHAEL_DRESS_TIMER] = -1;
						flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] = 7;
					}
					//PC get ready for the 2nd encounter and hasn't been
					//shot down yet?
					if(flags[kFLAGS.RAPHAEL_DISGUSTED_BY_PC_APPEARANCE] == 0 && player.armorName == "red, high-society bodysuit") {
						outputText("<b>\nSomething unusual happens that morning...</b>\n", false);
						doNext(raphael.RaphaelEncounterIIDressFollowup);
						return true;
					}
					
				}
			}
			//FINALE
			else if(flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == 1) {
				outputText("<b>\nSomething unusual happens that morning...</b>\n", false);
				doNext(raphael.quiksilverFawkesEndGame);
				return true;
			}
		}
		//Cotton's cereal overlapps marbleliciousness - Now handled in Cotton
		//Isabella's morning suckoffs! - Now handled in IsabellaScene
		//Morning Marble Meetings - Now handled in MarbleScene
		//Sophie Izma 3some - Now handled in IzmaScene
		//Izma dominates Latexy - Now handled in IzmaScene
		//Ember preg updates! - Now handled in EmberScene
		//No diapause?  Normal!
		if (player.findPerk(PerkLib.Diapause) < 0) {
			if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
			if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			//DOUBLE PREGGERS SPEED
			if (player.findPerk(PerkLib.MaraesGiftFertility) >= 0) {
				if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
			}
			//DOUBLE PREGGERS SPEED
			if (player.findPerk(PerkLib.MagicalFertility) >= 0) {
				if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
			}
			if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			if (player.findPerk(PerkLib.FerasBoonBreedingBitch) >= 0) {
				if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
			}
			if (player.findPerk(PerkLib.FerasBoonWideOpen) >= 0 || player.findPerk(PerkLib.FerasBoonMilkingTwat) >= 0) {
				if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
			}
			if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			//DOUBLE PREGGERS SPEED
			if (player.findPerk(PerkLib.BroodMother) >= 0) {
				if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
			}
			if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
		}
		//Diapause!
		else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228] > 0 && (player.pregnancyIncubation > 0 || player.buttPregnancyIncubation > 0)) {
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] == 1) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] = 0;
				outputText("\n\nYour body reacts to the influx of nutrition, accelerating your pregnancy. Your belly bulges outward slightly.", false);
				needNext = true;
			}
			if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228]--;
			if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
			if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
			if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
			if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			//DOUBLE PREGGERS SPEED
			if (player.findPerk(PerkLib.MaraesGiftFertility) >= 0) {
				if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
			}
			//DOUBLE PREGGERS SPEED
			if (player.findPerk(PerkLib.MagicalFertility) >= 0) {
				if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
			}
			if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			if (player.findPerk(PerkLib.FerasBoonBreedingBitch) >= 0) {
				if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
			}
			if (player.findPerk(PerkLib.FerasBoonWideOpen) >= 0 || player.findPerk(PerkLib.FerasBoonMilkingTwat) >= 0) {
				if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
			}
			if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			//DOUBLE PREGGERS SPEED
			if (player.findPerk(PerkLib.BroodMother) >= 0) {
				if (player.pregnancyAdvance()) needNext = true; //Make sure pregnancy texts aren't hidden
			}
			if (flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
		}
		//Egg loot!
		if(player.findStatusAffect(StatusAffects.LootEgg) >= 0) {
			trace("EGG LOOT HAS");
			//default
			var itype:ItemType =
					[
						[consumables.BROWNEG,consumables.PURPLEG,consumables.BLUEEGG,consumables.PINKEGG,consumables.WHITEEG,consumables.BLACKEG],
						[consumables.L_BRNEG,consumables.L_PRPEG,consumables.L_BLUEG,consumables.L_PNKEG,consumables.L_WHTEG,consumables.L_BLKEG]]
							[player.statusAffect(player.findStatusAffect(StatusAffects.Eggs)).value2 || 0][player.statusAffect(player.findStatusAffect(StatusAffects.Eggs)).value1 || 0] ||
							consumables.BROWNEG;
			player.removeStatusAffect(StatusAffects.LootEgg);
			player.removeStatusAffect(StatusAffects.Eggs);
			trace("TAKEY NAU");
			inventory.takeItem(itype);
			return true;
		}
		// Benoit preggers update
		if (flags[kFLAGS.FEMOIT_EGGS] > 0) flags[kFLAGS.FEMOIT_INCUBATION]--; // We're not capping it, we're going to use negative values to figure out diff events
	}
	
	// Hanging the Uma massage update here, I think it should work...
	telAdre.umasShop.updateBonusDuration(time);
	if (player.findStatusAffect(StatusAffects.UmasMassage) >= 0)
	{
		trace("Uma's massage bonus time remaining: " + player.statusAffectv3(StatusAffects.UmasMassage));
	}
	
	highMountains.izumiScenes.updateSmokeDuration(time);
	if (player.findStatusAffect(StatusAffects.IzumisPipeSmoke) >= 0)
	{
		trace("Izumis pipe smoke time remaining: " + player.statusAffectv1(StatusAffects.IzumisPipeSmoke));
	}
	
	//Drop axe if too short!
	if(player.tallness < 78 && player.weapon == weapons.L__AXE) {
		outputText("<b>\nThis axe is too large for someone of your stature to use, though you can keep it in your inventory until you are big enough.</b>\n", false);
		player.weapon.unequip(player,true,true);
		return true;
	}
	if(player.weapon == weapons.L_HAMMR && player.tallness < 60) {
		outputText("<b>\nYou've become too short to use this hammer anymore.  You can still keep it in your inventory, but you'll need to be taller to effectively wield it.</b>\n", true);
		player.weapon.unequip(player,true,true);
		return true;
	}		
	if(player.weapon == weapons.CLAYMOR && player.str < 40) {
		outputText("\n<b>You aren't strong enough to handle the weight of your weapon any longer, and you're forced to stop using it.</b>\n", true);
		player.weapon.unequip(player,true,true);
		return true;
	}
	if(player.weapon == weapons.WARHAMR && player.str < 80) {
		outputText("\n<b>You aren't strong enough to handle the weight of your weapon any longer!</b>\n", true);
		player.weapon.unequip(player,true,true);
		return true;
	}
	//Drop beautiful sword if corrupted!
	if(player.weaponPerk == "holySword") {
		if(player.cor >= 35) {
			outputText("<b>\nThe <u>" + player.weaponName + "</u> grows hot in your hand, until you are forced to drop it.  Whatever power inhabits this blade appears to be unhappy with you.  Touching it gingerly, you realize it is no longer hot, but as soon as you go to grab the hilt, it nearly burns you.\n\nYou realize you won't be able to use it right now, but you could probably keep it in your inventory.</b>\n\n", false);
			var oldWeapon:Weapon = player.weapon;
			player.weapon.unequip(player,false,true);
			inventory.takeItem(oldWeapon);
			return true;
		}
	}
	//Unequip Lusty maiden armor
	if(player.armorName == "lusty maiden's armor") {
		//Removal due to no longer fitting:
		//Grew Cock or Balls
		if(player.hasCock() || player.balls > 0) {
			outputText("\nYou fidget uncomfortably in the g-string of your lewd bikini - there simply isn't enough room for your ");
			if(player.hasCock()) outputText("maleness");
			else outputText("bulgy balls");
			outputText(" within the imprisoning leather, and it actually hurts to wear it.  <b>You'll have to find some other form of protection!</b>\n\n");
			player.armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			inventory.takeItem(armors.LMARMOR);
			return true;
		}
		//Lost pussy
		else if(!player.hasVagina()) {
			outputText("\nYou fidget uncomfortably as the crease in the gusset of your lewd bikini digs into your sensitive, featureless loins.  There's simply no way you can continue to wear this outfit in comfort - it was expressly designed to press in on the female mons, and without a vagina, <b>you simply can't wear this exotic armor.</b>\n\n");
			player.armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			inventory.takeItem(armors.LMARMOR);
			return true;
		}
		//Tits gone or too small
		else if(player.biggestTitSize() < 4) {
			outputText("\nThe fine chain that makes up your lewd bikini-top is dangling slack against your flattened chest.  Every movement and step sends it jangling noisily, slapping up against your [nipples], uncomfortably cold after being separated from your " + player.skinFurScales() + " for so long.  <b>There's no two ways about it - you'll need to find something else to wear.</b>\n\n");
			player.armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			inventory.takeItem(armors.LMARMOR);
			return true;
		}
	}
	// update cock type as dog/fox depending on whether the player resembles one more then the other.
	// Previously used to be computed directly in cockNoun, but refactoring prevents access to the Player class when in cockNoun now.
	if (player.totalCocks() != 0)
	{
		var counter:Number = player.totalCocks() - 1;
		while (counter >= 0)
		{
			if (player.cocks[counter].cockType == CockTypesEnum.DOG || player.cocks[counter].cockType == CockTypesEnum.FOX)
			{
				if (player.dogScore() >= player.foxScore())
					player.cocks[counter].cockType = CockTypesEnum.DOG;
				else
					player.cocks[counter].cockType = CockTypesEnum.FOX;
			}
			counter--;
			// trace("IMA LOOPIN", counter);
		}
		
	}	
	statScreenRefresh();
	if(needNext || defNext) {
		doNext(1);
		return true;
	}
	eventParser(1);
	return false;
}

public function cheatTime(time:Number):void {
	while(time > 0) {
		time--;
		model.time.hours++;
		if(model.time.hours > 23) {
			model.time.days++;
			model.time.hours = 0;
		}
	}
	statScreenRefresh();
}

public function growHair(amount:Number = .1):Boolean {
	//Grow hair!
	temp = player.hairLength;
	player.hairLength += amount;
	if(player.hairLength > 0 && temp == 0) {
		outputText("\n<b>You are no longer bald.  You now have " + hairDescript() + " coating your head.\n</b>", false);
		return true;
	}
	else if(player.hairLength >= 1 && temp < 1) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>", false);
		return true;
	}
	else if(player.hairLength >= 3 && temp < 3) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>", false);
		return true;
	}
	else if(player.hairLength >= 6 && temp < 6) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>", false);
		return true;
	}
	else if(player.hairLength >= 10 && temp < 10) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>", false);
		return true;
	}
	else if(player.hairLength >= 16 && temp < 16) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>", false);
		return true;
	}
	else if(player.hairLength >= 26 && temp < 26) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>", false);
		return true;
	}
	else if(player.hairLength >= 40 && temp < 40) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>", false);
		return true;
	}
	else if(player.hairLength >= 40 && player.hairLength >= player.tallness && temp < player.tallness) {
		outputText("\n<b>Your hair's growth has reached a new threshhold, giving you " + hairDescript() + ".\n</b>", false);
		return true;
	}
	return false;
}