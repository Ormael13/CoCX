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
	var threshhold:Number = 0;
	var temp2:Number = 0;
	
	while(timeQ > threshhold) {
		model.time.hours++;
		if(player.cumMultiplier > 19999) player.cumMultiplier = 19999;
		if(player.ballSize > 400) player.ballSize = 400;
		if(player.findPerk(PerkLib.StrongBack) >= 0 && !player.itemSlot4.unlocked) {
			player.itemSlot4.unlocked = true;
		}
		if(player.findPerk(PerkLib.StrongBack2) >= 0 && !player.itemSlot5.unlocked) {
			player.itemSlot5.unlocked = true;
		}
		if(flags[kFLAGS.SOCK_COUNTER] > 0) {
			flags[kFLAGS.SOCK_COUNTER]--;
			if(flags[kFLAGS.SOCK_COUNTER] < 0) flags[kFLAGS.SOCK_COUNTER] = 0;
			if(flags[kFLAGS.SOCK_COUNTER] > 24) flags[kFLAGS.SOCK_COUNTER] = 24;
		}
		if(flags[kFLAGS.PHYLLA_EGG_LAYING] > 0 && rand(5) == 0 && flags[kFLAGS.ANT_KIDS] < 5000) flags[kFLAGS.ANT_KIDS]++;
		if(flags[kFLAGS.PHYLLA_DRIDER_INCUBATION] > 1) {
			flags[kFLAGS.PHYLLA_DRIDER_INCUBATION]--;
			if(flags[kFLAGS.PHYLLA_DRIDER_INCUBATION] < 1) flags[kFLAGS.PHYLLA_DRIDER_INCUBATION] = 1;
		}
		if(flags[kFLAGS.HEL_PREGNANCY_INCUBATION] > 0) {
			flags[kFLAGS.HEL_PREGNANCY_INCUBATION]--;
			if(flags[kFLAGS.HEL_PREGNANCY_INCUBATION] == 0) flags[kFLAGS.HEL_PREGNANCY_INCUBATION] = 1;
		}
		//Ring of Purity and Corruption
		if (player.jewelryEffectId == 8)
		{
			dynStats("cor", (player.jewelryEffectMagnitude/10));
		}
		//Hunger! No effect if hunger is disabled, even if your hunger is at 0/100.
		if (flags[kFLAGS.HUNGER_ENABLED] > 0) {

			//Hunger drain rate. If above 50, 2 per hour. Between 25 and 50, 1 per hour. Below 25, 0.5 per hour.
			//So it takes 100 hours to fully starve from 100/100 to 0/100 hunger.
			if (flags[kFLAGS.PC_HUNGER] > 50)
			{
				flags[kFLAGS.PC_HUNGER] -= 1;
			}
			if (flags[kFLAGS.PC_HUNGER] > 25)
			{
				flags[kFLAGS.PC_HUNGER] -= 0.5;
			}
			if (flags[kFLAGS.PC_HUNGER] > 0)
			{
				flags[kFLAGS.PC_HUNGER] -= 0.5;
			}
			//Caps hunger at 100. Occurs after hunger tick so you'll be able to see hunger showing 100/100.
			if (flags[kFLAGS.PC_HUNGER] > 100)
			{
				flags[kFLAGS.PC_HUNGER] = 100;
			}
			if (flags[kFLAGS.PC_HUNGER] <= 0)
			{
				//Lose HP and makes fatigue go up. Lose body weight and muscles.
				takeDamage(maxHP() / 50);
				fatigue(2);
				player.modThickness(1, 1);
				player.modTone(1, 1);
				if (rand(3) == 0) player.buttRating--;
				if (rand(3) == 0) player.hipRating--;
				dynStats("str", -0.5);
				dynStats("tou", -0.5);
			}
			//Goo armor prevents starvation completely!
			if (player.armorName == "goo armor")
			{
				if (flags[kFLAGS.PC_HUNGER] < 10)
				{
					flags[kFLAGS.PC_HUNGER] = 10;
				}
			}
		}
		if(izmaScene.izmaFollower() && flags[kFLAGS.IZMA_NO_COCK] == 0 && flags[kFLAGS.TIMES_IZMA_DOMMED_LATEXY] > 0 && latexGirl.latexGooFollower() && flags[kFLAGS.IZMA_X_LATEXY_DISABLED] == 0) flags[kFLAGS.GOO_FLUID_AMOUNT] = 100;
		genderCheck();
		if(player.findStatusAffect(StatusAffects.NoJojo) >= 0) player.removeStatusAffect(StatusAffects.NoJojo);
		
		regeneration(false);
		
		player.hoursSinceCum++;
		//Super cumbuilding activate!
		if(player.findPerk(PerkLib.MaraesGiftProfractory) >= 0) player.hoursSinceCum += 2;
		if(player.findPerk(PerkLib.FerasBoonAlpha) >= 0) player.hoursSinceCum += 2;
		timeQ--;
		//Normal
		if(flags[kFLAGS.ARIAN_EGG_COUNTER] > 0) flags[kFLAGS.ARIAN_EGG_COUNTER]++;
		if(player.findPerk(PerkLib.WellAdjusted) < 0) {
			//Raise lust
			dynStats("lus", player.lib * 0.04, "resisted", false);
			//Double lust rise if lusty.
			if(player.findPerk(PerkLib.Lusty) >= 0) dynStats("lus", player.lib * 0.02, "resisted", false);
		}
		//Well adjusted perk
		else {
			//Raise lust
			dynStats("lus", player.lib * 0.02, "resisted", false);
			//Double lust rise if lusty.
			if(player.findPerk(PerkLib.Lusty) >= 0) dynStats("lus", player.lib * 0.01, "resisted", false);
		}
		//Rathazul crafting countdown
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00274] > 1) {
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00274]--;
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00274] < 1) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00274] = 1;
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00274] > 300) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00274] = 24;
		}
		//Urta Letters
		if(flags[kFLAGS.NEED_URTA_LETTER] == 1 && model.time.hours == 6) urtaPregs.getUrtaLetter();
		//Urta Pregs
		if(flags[kFLAGS.URTA_INCUBATION] > 0) flags[kFLAGS.URTA_INCUBATION]++;
		if(flags[kFLAGS.KELLY_INCUBATION] > 0) {
			flags[kFLAGS.KELLY_INCUBATION]--;
			if(flags[kFLAGS.KELLY_INCUBATION] < 1) {
				flags[kFLAGS.KELLY_INCUBATION] = 0;
				farm.kelly.kellyPopsOutARunt();
				needNext = true;
			}
		}
		//Goo fuck stuff
		if (player.statusAffectv1(StatusAffects.GooStuffed) > 0) {
			player.addStatusValue(StatusAffects.GooStuffed,1,-1);
			if (player.statusAffectv1(StatusAffects.GooStuffed) <= 0)
			{
				valeria.birthOutDatGooSlut();
				needNext = true;
			}
			
		}
		//Ember fuck cooldown
		if(player.statusAffectv1(StatusAffects.EmberFuckCooldown) > 0) {
			player.addStatusValue(StatusAffects.EmberFuckCooldown,1,-1);
			if(player.statusAffectv1(StatusAffects.EmberFuckCooldown) < 1) player.removeStatusAffect(StatusAffects.EmberFuckCooldown);
		}
		//Ember napping
		if(player.findStatusAffect(StatusAffects.EmberNapping) >= 0) {
			player.addStatusValue(StatusAffects.EmberNapping,1,-1);
			if(player.statusAffectv1(StatusAffects.EmberNapping) <= 0) player.removeStatusAffect(StatusAffects.EmberNapping);
		}
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00283] == 0 && sophieFollowerScene.sophieFollower() && flags[kFLAGS.SOPHIES_DAUGHTERS_DEBIMBOED] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
			sophieFollowerScene.sophieDaughterDebimboUpdate();
			needNext = true;
		}
		if((sophieBimbo.bimboSophie() || sophieFollowerScene.sophieFollower()) && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
			if(flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) {
				flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER]--;
				if(flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] < 1) flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] = 1;
				if(flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] == 325) {
					outputText("\nYour cute little harpy is still just a little chick.  Her body is small and childlike, and her feathers are fluffy and poofy, making your little girl look like she has puffballs for arms and legs.  Already looking to be four or five years old, the baby harpy is just as energetic as a human child of that age.  She flutters around and scrambles from one thing to another. Thankfully, the rambunctious little darling runs out of explosive energy quickly, suddenly falling to the ground into a fluffy heap for a quick nap.\n");
					needNext = true;
				}
				if(flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] == 200) {
					outputText("\nYour sweet little harpy is starting to grow up!  Her body is much bigger than it was before, though her baby fat has spread out over her larger form and looks more lean and lanky then the big-butted harpies you're used to seeing.  Her feathers have even started to smooth out, though she is still quite the fluffball.  You're sure that it won't be too long before the curves harpies are known for start to appear.  The energy she exuded as a little chick still drives her to 'terrorize' your camp, scampering around, fluttering from place to place and getting into all kinds of things.  Your fluffy daughter seems to be able to stay active for longer than before, though you still see her curl up for a nap every so often.\n");
					needNext = true;
				}
				if(flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] == 100) {
					outputText("\nLooking around for your developing daughter, you find that she and your ");
					if(sophieBimbo.bimboSophie()) outputText("boisterous bimbo ");
					else outputText("mature harpy ");
					outputText("are spending some quality mother-daughter time together.  Sophie is helping the young girl with her make up, showing her how to use that golden luststick that her people are so fond of.  You're not too sure how appropriate that is for your daughter, but then again, this is what harpies do right?  Aside from the lusty lipstick, your live-in");
					if(sophieBimbo.bimboSophie()) outputText(" bimbo ");
					else outputText(", avian girlfriend ");
					outputText("moves on to her hair and nails, all the while gabbing on and on about you, and about all the daughters she plans to have.");
					outputText("\n\nYour daughter is growing up so fast!  Already, her body is developing, breasts budding into supple bumps on her chest.  Her hips are starting to swell into the trademark birthing hips and round grabbable ass harpies are famous for.\n");
					needNext = true;
				}
			}
			if(flags[kFLAGS.SOPHIE_CAMP_EGG_COUNTDOWN] > 0) {
				flags[kFLAGS.SOPHIE_CAMP_EGG_COUNTDOWN]--;
				if(flags[kFLAGS.SOPHIE_CAMP_EGG_COUNTDOWN] <= 0) {
					sophieBimbo.sophiesEggHatches();
					needNext = true;
				}
			}
			//PREGNANCY COUNTAN
			if(flags[kFLAGS.SOPHIE_INCUBATION] > 0) {
				flags[kFLAGS.SOPHIE_INCUBATION]--;
				//Sophie Pregnancy Stage Alerts
				//Small Bump*
				if(flags[kFLAGS.SOPHIE_INCUBATION] == 150) {
					if(sophieBimbo.bimboSophie()) {
						outputText("\nSophie sits by herself on your comfy bedroll.  The feathery female seems to have taken a liking to your place of rest.  Your bird-brained love-slave clearly desires to be close to you, or at least your fatherly scent, as much as possible.  Lost in her lusty fantasies, she caresses the gentle bump in her belly, the telltale sign that your virile seed has worked its magic on her egg-bearing womb.  One of her hands idly slips between her legs, fingers gently playing with her wet snatch as her other rubs her tummy.");
						outputText("\n\nFinally noticing your gaze on her body, Sophie looks up at you with an amorous smile, her thick, fertile thighs spreading and showing off her tight puffy pussy to you.  The blond bimbo puts her pregnant body on display for you, to show you the result of your virility and to entice you into playing with her hot, lusty form.\n");
					}
					else {
						outputText("\nSophie sits by herself on your comfy bedroll.  The feathery female seems to have taken a liking to your place of rest.  Your well-endowed monster-girl lover clearly desires to be as close to you, or at least your fatherly scent, as much as possible.  Lost in her lusty fantasies, she caresses the gentle bump in her belly, the telltale sign that your virile seed has worked its magic on her egg-bearing womb.  One of her hands idly slips between her legs, fingers gently playing with her wet snatch as her other rubs her tummy.");
						outputText("\n\nFinally noticing your gaze on her body, Sophie looks up at you with an amorous smile, her thick, fertile thighs spreading and showing off her tight puffy pussy to you.  The matron puts her pregnant body on display for you, to show you the result of your virility and to entice you into playing with her hot, lusty form.\n");
					}
					needNext = true;
					dynStats("lus", 3);
				}
				//Medium Bump*
				else if(flags[kFLAGS.SOPHIE_INCUBATION] == 120) {
					if(sophieBimbo.bimboSophie()) {
						outputText("\nAs usual, Sophie is laying on your bedroll.  Each day the fertile swell in her stomach seems to grow bigger with the egg inside.  The positively pregnant woman idly strokes her egg-bearing belly with motherly affection.  She even coos to the growing bump as she caresses her body, clearly loving the fact that she is pregnant with another egg.  It's not long before she catches sight of you; a big silly smile breaking across her puffy lips as she hurriedly gets up from your blankets and bounds over to you.  With each step, her voluptuous body jiggles and bounces, her big bountiful bosom heaving and shaking, her ripe round rump quivering like jelly as she sways her fecund hips for you.");
						outputText("\n\n\"<i>There you are [name]!  Like, look at me!  Your egg is getting <b>soooo</b> big inside me!  Like, just look at how big and sexy I am!</i>\"  the bimbo brained woman tweets as she presses her curvaceous body against you, making sure you can feel her big soft tits and growing baby bump.  From how her body feels, you're sure her already bountiful bimbo-like breasts have only gotten bigger thanks to her pregnancy.  \"<i>Thanks for getting me all pregnant and stuff!</i>\"\n");
					}
					else {
						outputText("\nAs usual, Sophie is laying on your bedroll.  Each day the fertile swell in her stomach seems to grow bigger with the egg inside.  The positively pregnant woman idly strokes her egg-bearing belly with motherly affection.  She even coos to the growing bump as she caresses her body, clearly loving the fact that she is pregnant with another egg.  It's not long before she catches sight of you; a big silly smile breaking across her lips as she hurriedly gets up from your blankets and bounds over to you.  With each step, her voluptuous body jiggles and bounces, her big bountiful bosom heaving and shaking, her ripe round rump quivering like jelly as she sways her fecund hips for you.");
						outputText("\n\n\"<i>Hey there [name].  Look at me!  That egg has gotten so big inside me.  You have no idea how good this feels,</i>\" the confident woman tweets as she presses her curvaceous body against you, making sure you can feel her big soft tits and growing baby bump.  From how her body feels, you're sure her already bountiful breasts have only gotten bigger thanks to her pregnancy.  \"<i>Maybe in a month or so, I'll let you do it all over again...</i>\"\n");
					}
					dynStats("lus", 5);
					needNext = true;
				}
				//Big Belly Bump*
				else if(flags[kFLAGS.SOPHIE_INCUBATION] == 100) {
					if(sophieBimbo.bimboSophie()) {
						outputText("\nOnce again, your pregnant bimbo lounges on your bedroll, her face buried in your pillow and taking deep breaths of your scent.  Even with her in such a - vulnerable... position, face down and ass up, you can clearly see the big, round bulge of her egg-laden belly.  With your feathery slut so gravid, you're sure it won't be long until she lays that womb-straining egg.  As if sensing your gaze, Sophie starts to sway her round spankable ass, her legs seeming to spread a little wider as well.  Your suspicions prove correct when she looks back at you; her plump bimbo lips blowing you a kiss as she looks at you with lusty eyes.");
						outputText("\n\nThe amorous harpy practically leaps out of your bed, her voluptuous body bouncing with each step as she bounds over to you.  Despite her heavily pregnant state, Sophie seems to carry herself well, the milfy harpy well adapted at being heavy with egg.  Taking advantage of your momentary distraction, the excited, happy bimbo flounces at you, tackling you and cuddling you happily.  She presses her egg-heavy belly and massive, perky tits against you and says, \"<i>Ohhh!  It's gonna be soon, momma Sophie's gonna like, lay this nice big egg for you, babe!</i>\"  Leaning in, she plants a big wet kiss on your cheek before sliding her hands down to her round bulging belly.  \"<i>It's going to be a really big egg too!  Don't worry, I'm good at laying eggs, and my pussy's going to stay niiice and tight for you, babe!</i>\"\n");
					}
					else {
						outputText("\nOnce again, your pregnant harpy lounges on your bedroll, her face buried in your pillow and taking deep breaths of your scent.  Even with her in such a - vulnerable... position, face down and ass up, you can clearly see the big, round bulge of her egg-laden belly.  With the feathery slut so gravid, you're sure it won't be long until she lays that womb-straining egg.  As if sensing your gaze, Sophie starts to sway her round spankable ass, her legs seeming to spread a little wider as well.  Your suspicions prove correct when she looks back at you; her pursed lips blowing you a kiss as she looks at you with lusty eyes.");
						outputText("\n\nThe amorous harpy practically leaps out of your bed, her voluptuous body bouncing with each step as she bounds over to you.  Despite her heavily pregnant state, Sophie seems to carry herself well, the milfy harpy well adapted at being heavy with egg.  Taking advantage of your momentary distraction, she flounces at you, tackling you and cuddling you happily.  She presses her egg-heavy belly and massive, perky tits against you and says, \"<i>It's gonna be time soon...  Before you know it, I'll be popping out this big, swollen egg, and you'll be right there to see it!</i>\"  Leaning in, she plants a big wet kiss on your cheek before sliding her hands down to her round bulging belly.  \"<i>It's going to be a really big egg too!  Don't worry, I'm good at laying eggs, and my pussy is going to be ready for you as soon as it comes out!</i>\"\n");
					}
					dynStats("lus", 5);
					needNext = true;
				}
				else if(flags[kFLAGS.SOPHIE_INCUBATION] == 0) {
					sophieBimbo.sophieBirthsEgg();
					needNext = true;
				}
			}
			//Tick over into heat if appropriate
			if(flags[kFLAGS.SOPHIE_HEAT_COUNTER] <= 0) {
				//Not pregnant and PC has dick? INTO SEASON HOOOO
				if(player.hasCock() && flags[kFLAGS.SOPHIE_INCUBATION] <= 0) {
					if(sophieBimbo.bimboSophie()) sophieBimbo.sophieGoesIntoSeason();
					else sophieFollowerScene.sophieFollowerGoesIntoSeas();
					needNext = true;
					flags[kFLAGS.SOPHIE_HEAT_COUNTER] = 720;
				}
				//No dick or pregnant? WAIT.
				else {
					flags[kFLAGS.SOPHIE_HEAT_COUNTER] = 0;
				}
			}
			//COUNT DOWN TOWARDS 0.
			else {
				flags[kFLAGS.SOPHIE_HEAT_COUNTER]--;
				//Expire heat if impregged
				if(flags[kFLAGS.SOPHIE_INCUBATION] > 0 && flags[kFLAGS.SOPHIE_HEAT_COUNTER] >= 552) {
					if(sophieBimbo.bimboSophie()) sophieBimbo.sophieGotKnockedUp();
					else sophieFollowerScene.sophieFertilityKnockedUpExpired();
					flags[kFLAGS.SOPHIE_HEAT_COUNTER] = 551;
					needNext = true;
				}
				//Expire heat if counted down to
				else if(flags[kFLAGS.SOPHIE_HEAT_COUNTER] == 552) {
					if(sophieBimbo.bimboSophie()) sophieBimbo.sophieSeasonExpiration();
					else sophieFollowerScene.sophieFertilityExpired();
					needNext = true;
				}
			}
			//IIF PREGNANT, KEEP HEAT COUNTER AT 551
			if(flags[kFLAGS.SOPHIE_INCUBATION] > 0)
				flags[kFLAGS.SOPHIE_HEAT_COUNTER] = 551;
		}
		if(flags[kFLAGS.ANEMONE_KID] > 0) {
			if(flags[kFLAGS.KID_SITTER] == 0 && flags[kFLAGS.MARBLE_KIDS] >= 5 && model.time.hours > 10 && model.time.hours < 18 && rand(4) == 0) {
				anemoneScene.kidABabysitsCows();
				needNext = true;
			}
			if(flags[kFLAGS.KID_SITTER] == 1 && model.time.hours > 10 && model.time.hours < 18 && rand(4) == 0) {
				flags[kFLAGS.KID_SITTER] = 2;
			}
			else if(flags[kFLAGS.KID_SITTER] == 2) flags[kFLAGS.KID_SITTER] = 1;
		}
		if(flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN] >= 1) flags[kFLAGS.SHOULDRA_MAGIC_COOLDOWN]--;
		if(shouldraFollower.followerShouldra() && player.statusAffectv1(StatusAffects.Exgartuan) == 1 && player.hasCock() && rand(10) == 0) {
			if(flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] == 1) {
				needNext = true;
				shouldraFollower.exgartumonAndShouldraFightPartII();
			}
			else if(flags[kFLAGS.SHOULDRA_EXGARTUDRAMA] == 2) {
				shouldraFollower.exgartumonAndShouldraFightPartIII();
				needNext = true;
			}
		}
		//Amily lays eggs that were oviposited.
		if(flags[kFLAGS.AMILY_OVIPOSITED_COUNTDOWN] > 0 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) {
			flags[kFLAGS.AMILY_OVIPOSITED_COUNTDOWN]--;
			if(flags[kFLAGS.AMILY_OVIPOSITED_COUNTDOWN] <= 0) {
				amilyScene.amilyLaysEggsLikeABitch();
				needNext = true;
			}
		}
		if(flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] > 0) {
			if(flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY] < 500) flags[kFLAGS.GATS_ANGEL_TIME_TO_FIND_KEY]++;
		}
		//Vapula gives a dildo
		if(vapula.vapulaSlave() && player.hasKeyItem("Demonic Strap-On") < 0 && player.gender == 2 && flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 0) {
			vapula.vapulaGivesPCAPresent();
			needNext = true;
		}
		//Niamh counters
		if(flags[kFLAGS.NIAMH_SEAN_BREW_BIMBO_LIQUEUR_COUNTER] > 1) flags[kFLAGS.NIAMH_SEAN_BREW_BIMBO_LIQUEUR_COUNTER]--;
		if(flags[kFLAGS.NIAMH_MOVED_OUT_COUNTER] > 1) flags[kFLAGS.NIAMH_MOVED_OUT_COUNTER]--;
		if(player.findStatusAffect(StatusAffects.BimboChampagne) >= 0) {
			player.addStatusValue(StatusAffects.BimboChampagne,1,-1);
			if(player.statusAffectv1(StatusAffects.BimboChampagne) <= 0) {
				telAdre.niamh.removeBimboChampagne();
				needNext = true;
			}
		}
		if(flags[kFLAGS.FOX_BAD_END_WARNING] == 1) {
			if(player.faceType != FACE_FOX || player.tailType != TAIL_TYPE_FOX || player.earType != EARS_FOX || player.lowerBody != LOWER_BODY_TYPE_FOX || player.skinType != SKIN_TYPE_FUR) {
				flags[kFLAGS.FOX_BAD_END_WARNING] = 0;
			}
		}
		flags[kFLAGS.SALON_PAID] = 0;
		//Izzy milk countdown
		if(flags[kFLAGS.ISABELLA_MILK_COOLDOWN] > 0) {
			flags[kFLAGS.ISABELLA_MILK_COOLDOWN]--;
			if(flags[kFLAGS.ISABELLA_MILK_COOLDOWN] < 0) flags[kFLAGS.ISABELLA_MILK_COOLDOWN] = 0;
		}
		//Isabella accent coaching countdown
		if(flags[kFLAGS.ISABELLA_ACCENT_TRAINING_COOLDOWN] > 1) {
			flags[kFLAGS.ISABELLA_ACCENT_TRAINING_COOLDOWN]--;
		}
		if(flags[kFLAGS.ANEMONE_KID] > 0) {
			if(flags[kFLAGS.KID_ITEM_FIND_HOURS] < 20) flags[kFLAGS.KID_ITEM_FIND_HOURS]++;
		}
		//Wet pussy check!
		if(player.findPerk(PerkLib.WetPussy) >= 0 && player.vaginas.length > 0) {
			if(player.vaginas[0].vaginalWetness < VAGINA_WETNESS_WET) {
				outputText("\n<b>Your " + vaginaDescript(0) + " returns to its normal, wet state.</b>\n", false);
				needNext = true;
				player.vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
			}
		}
		//Fixing Egg Preg Preglocked Glitch
		if(player.pregnancyIncubation <= 0 && player.pregnancyType == 5) {
			player.pregnancyType = 0;
			player.pregnancyIncubation = 0;
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
		//Jojo milking cooldown
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00332] > 0) {
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00332]--;
		}
		//Spider-preg stuff
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00271] > 0) {
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00271]--;
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00271] < 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00271] = 0;
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00271] > 300) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00271] = 0;
		}
		//Increase Roxanne's growing dick size...
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00225]++;
		//Reset if she finds someone to take it (random at high values)
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00225] >= 300 && model.time.hours == 1 && rand(5) == 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00225] = 1;
		//hangover status stuff
		if(player.findStatusAffect(StatusAffects.Hangover) >= 0) {
			//Countdown
			if(player.statusAffectv1(StatusAffects.Hangover) > 0) player.addStatusValue(StatusAffects.Hangover,1,-1);
			else {
				outputText("\n<b>Your head finally clears as your hangover wears off.  Drinking with the shemale lizard was definitely a bad idea.</b>\n", false);
				//Restore stats
				player.str += player.statusAffectv2(StatusAffects.Hangover);
				player.spe += player.statusAffectv3(StatusAffects.Hangover);
				player.inte += player.statusAffectv4(StatusAffects.Hangover);
				dynStats("cor", 0);
				//Clear status
				player.removeStatusAffect(StatusAffects.Hangover);
				needNext = true;
			}
		}
		if(player.statusAffectv1(StatusAffects.BlackCatBeer) > 0) {
			player.addStatusValue(StatusAffects.BlackCatBeer,1,-1);
			if(player.statusAffectv1(StatusAffects.BlackCatBeer) <= 0) {
				telAdre.niamh.blackCatBeerExpires();
				needNext = true;
			}
		}
		if(player.statusAffectv1(StatusAffects.PhoukaWhiskeyAffect) > 0) {
            player.addStatusValue(StatusAffects.PhoukaWhiskeyAffect, 1, -1); //Count down hours until player is not drunk
            if (player.statusAffectv1(StatusAffects.PhoukaWhiskeyAffect) <= 0) {
				consumables.P_WHSKY.phoukaWhiskeyExpires(player);
                needNext = true;
            }
        }
		//EMBER STUFF
		if(emberScene.followerEmber() && player.findStatusAffect(StatusAffects.EmberNapping) < 0) {
			//Mino cum freakout - PC partly addicted!
			if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 1 && player.findPerk(PerkLib.MinotaurCumAddict) < 0 && flags[kFLAGS.EMBER_CURRENTLY_FREAKING_ABOUT_MINOCUM] == 0) {
				emberScene.minotaurJizzFreakout();
				needNext = true;
			}
			//Ember is freaking out about addiction, but PC no longer addicted!
			else if(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 0 && flags[kFLAGS.EMBER_CURRENTLY_FREAKING_ABOUT_MINOCUM] == 1) {
				emberScene.emberGetOverFreakingOutAboutMinoJizz();
				needNext = true;
			}
			//At max lust, count up - if ten hours lusty, ember yells at ya!
			if(player.lust >= 100 && player.gender > 0) {
				flags[kFLAGS.EMBER_LUST_BITCHING_COUNTER]++;
				if (flags[kFLAGS.EMBER_LUST_BITCHING_COUNTER] >= 10) {
					emberScene.emberBitchesAtYouAboutLustiness();
					needNext = true;
				}
			}
			//Reset lust counter if not max lust'ed
			else flags[kFLAGS.EMBER_LUST_BITCHING_COUNTER] = 0;
			
		}
		telAdre.cotton.cottonPregUpdates();
		//Fix femininity ratings if out of whack!
		if(player.findPerk(PerkLib.Androgyny) < 0)
			textHolder = player.fixFemininity();
		if(textHolder != "") {
			outputText(textHolder, false);
			needNext = true;
		}
		//BOOKURYUUUU COUNTAH For IZMA
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00253] > 0) {
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00253]--;
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00253] < 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00253] = 0;
		}
		//Minotaur son tracker
		//326 Number of sons grown
		//327 Number of sons pending
		//328 growup countdown
		//If it gets glitched somehow
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00328] > 30) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00328] = 30;
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00328] < 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00328] = 0;
		//Countdown for son growing up
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00328] > 0) {
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00328]--;
			//Hit zero, move kid to grown up pile!
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00328] <= 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00327] > 0) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00327]--;
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326]++;
			}
		}
		//NEXT KID!
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00327] > 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00328] == 0) {
			trace("MINO KID GROWN");
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00328] = 30;
		}
		if(shouldraFollower.followerShouldra()) {
			flags[kFLAGS.SHOULDRA_SLEEP_TIMER]--;
			if(shouldraFollower.shouldersWarnings()) needNext = true;
			if(flags[kFLAGS.SHOULDRA_SLEEP_TIMER] == 0 || (flags[kFLAGS.SHOULDRA_SLEEP_TIMER] < 0 && flags[kFLAGS.SHOULDRA_SLEEP_TIMER] % 16 == 0)) {
				shouldraFollower.shouldraWakesUpOrPokesPCsForShitsAndGigglesIdunnoHowLongCanIMakeThisFunctionNameQuestionMark();
				needNext = true;
			}
			   
		}
		//Lust stick!
		if(player.findStatusAffect(StatusAffects.LustStickApplied) >= 0) {
			//Decrement!
			player.addStatusValue(StatusAffects.LustStickApplied,1,-1);
			if(player.statusAffectv1(StatusAffects.LustStickApplied) <= 0) {
				player.removeStatusAffect(StatusAffects.LustStickApplied);
				outputText("<b>\nYour drugged lipstick fades away, leaving only the faintest residue on your lips.  You'll have to put on more if you want to be able to kiss your foes into submission!</b>\n", false);
			}
		}
		if(flags[kFLAGS.JOJO_EGGCUBATE_COUNT] > 0 && flags[kFLAGS.FOLLOWER_AT_FARM_JOJO] == 0) {
			flags[kFLAGS.JOJO_EGGCUBATE_COUNT]--;
			if(flags[kFLAGS.JOJO_EGGCUBATE_COUNT] == 1) {
				jojoScene.jojoLaysEggs();
				needNext = true;
			}
		}
		if(flags[kFLAGS.DICK_EGG_INCUBATION] > 0) {
			flags[kFLAGS.DICK_EGG_INCUBATION]--;
			trace("DICK BIRTH TIMER: " + flags[kFLAGS.DICK_EGG_INCUBATION]);
			if(flags[kFLAGS.DICK_EGG_INCUBATION] == 1) {
				birthBeeEggsOutYourWang();
				needNext = true;
			}
		}
		//Izma Pregger counter
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00250] > 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) {
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00250]--;
			//Fix out of bounds
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00250] < 1) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00250] = 1;
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00250] > 300) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00250] = 300;
		}
		//Vala post-rape countdown
		if(flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC] > 0) {
			flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC]--;
			if(flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC] < 0) flags[kFLAGS.TIME_SINCE_VALA_ATTEMPTED_RAPE_PC] = 0;
		}	
		//Sophie PO'ed countdown
		if(flags[kFLAGS.SOPHIE_ANGRY_AT_PC_COUNTER] > 0) {
			flags[kFLAGS.SOPHIE_ANGRY_AT_PC_COUNTER]--;
			if(flags[kFLAGS.SOPHIE_ANGRY_AT_PC_COUNTER] < 0) flags[kFLAGS.SOPHIE_ANGRY_AT_PC_COUNTER] = 0;
		}
		//PO countdown
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00260] > 0) {
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00260]--;
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00260] > 300) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00260] = 300;
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00260] < 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00260] = 0;
		}			
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
		//Egg laying countdown for Sophie
		if(flags[kFLAGS.SOPHIE_WILD_EGG_COUNTDOWN_TIMER] > 0) {
			flags[kFLAGS.SOPHIE_WILD_EGG_COUNTDOWN_TIMER]--;
			if(flags[kFLAGS.SOPHIE_WILD_EGG_COUNTDOWN_TIMER] < 0) flags[kFLAGS.SOPHIE_WILD_EGG_COUNTDOWN_TIMER] = 0;
			//Lay an egg
			if(flags[kFLAGS.SOPHIE_WILD_EGG_COUNTDOWN_TIMER] == 0) flags[kFLAGS.SOPHIE_EGGS_LAID]++;
		}
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
		
		//Count down timer for urta's lust
		if(flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] > 0) {
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME]--;
			if(flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] < 0) flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 0;
		}
		//Update status of Urta eggs
		if(flags[kFLAGS.URTA_EGG_INCUBATION] > 0) {
			flags[kFLAGS.URTA_EGG_INCUBATION]--;
			if(flags[kFLAGS.URTA_EGG_INCUBATION] <= 0) {
				flags[kFLAGS.URTA_EGG_INCUBATION] = 0;
				flags[kFLAGS.URTA_EGGS] = 0;
				flags[kFLAGS.URTA_FERTILE_EGGS] = 0;
			}
		}
		//Countdown to urta freakout
		if(flags[kFLAGS.URTA_EGG_FORCE_EVENT] > 0) flags[kFLAGS.URTA_EGG_FORCE_EVENT]--;
		//Urta egg freak out
		if(model.time.hours > 6 && model.time.hours < 18 && flags[kFLAGS.URTA_EGG_FORCE_EVENT] < 12 && flags[kFLAGS.URTA_EGG_FORCE_EVENT] > 0) {
			outputText("\n<b>You feel like you ought to see how Urta is dealing with your little 'donation', and head in to Tel'Adra for a quick checkup on her...</b>\n");
			urta.urtaChewsOutPC(false);
		}
		//Count down rathazul event timers
		if(flags[kFLAGS.RATHAZUL_CAMP_INTERACTION_COUNTDOWN] > 0) {
			flags[kFLAGS.RATHAZUL_CAMP_INTERACTION_COUNTDOWN]--;
			if(flags[kFLAGS.RATHAZUL_CAMP_INTERACTION_COUNTDOWN] < 0) flags[kFLAGS.RATHAZUL_CAMP_INTERACTION_COUNTDOWN] = 0; 
		}
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
		//more marbles!
		if(player.findStatusAffect(StatusAffects.CampMarble) >= 0) {
			//Marble stuff pt I
			if(flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_1] > 0)
			{
				flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_1]--;
				//Stick it at 1 so I can trigger it off the camp screen.
				if(flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_1] <= 1)
				{
					flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_1] = 1;
				}
			}
			//Counting down to purity!
			if(flags[kFLAGS.MARBLE_PURIFICATION_STAGE] == 0)
			{
				if(flags[kFLAGS.MARBLE_COUNTUP_TO_PURIFYING] < 200)
				{
					flags[kFLAGS.MARBLE_COUNTUP_TO_PURIFYING]++;
				}
			}
			//Counter 2!
			if(flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_2] > 0)
			{
				flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_2]--;
				//Stick it at 1 so I can trigger it off the camp screen.
				if(flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_2] <= 1)
				{
					flags[kFLAGS.MARBLE_RATHAZUL_COUNTER_2] = 1;
				}
			}
			//Post purification nursitude
			if(flags[kFLAGS.MARBLE_PURIFICATION_STAGE] >= 5)
			{
				flags[kFLAGS.MARBLE_TIME_SINCE_NURSED_IN_HOURS]++;
				if(flags[kFLAGS.MARBLE_TIME_SINCE_NURSED_IN_HOURS] > 1000) flags[kFLAGS.MARBLE_TIME_SINCE_NURSED_IN_HOURS] = 1000;
			}
			//Reset Marble corruption warning
			if(flags[kFLAGS.MARBLE_WARNED_ABOUT_CORRUPTION] == 1 && player.cor < 50) flags[kFLAGS.MARBLE_WARNED_ABOUT_CORRUPTION] = 0;
			//Lactation whoopie!
			if(flags[kFLAGS.MARBLE_TIME_SINCE_NURSED_IN_HOURS] < 100) flags[kFLAGS.MARBLE_TIME_SINCE_NURSED_IN_HOURS]++;
			//Increment Marble's Lust
			if(flags[kFLAGS.MARBLE_LUST] < -100) flags[kFLAGS.MARBLE_LUST] = -100;
			if(rand(2) == 0) flags[kFLAGS.MARBLE_LUST] += 1;
			if(player.statusAffectv4(StatusAffects.Marble) > 50) flags[kFLAGS.MARBLE_LUST] += .3;
			if(player.statusAffectv4(StatusAffects.Marble) > 70) flags[kFLAGS.MARBLE_LUST] += .3;
			//If bitch-bin is in construction
			if(flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] > 0 && flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] < 100 && marbleScene.marbleAtCamp()) {
				flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION]++;
				if(flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] >= 100) {
					spriteSelect(41);
					outputText("\n<b>Marble lets you know that she's finished building a rather secure nursery for your coming offspring.</b>\n", false);
					needNext = true;
					flags[kFLAGS.MARBLE_NURSERY_CONSTRUCTION] = 100;
				}
			}
			
			//Marble find items check
			else if(player.findStatusAffect(StatusAffects.MarbleHasItem) < 0 && marbleScene.marbleAtCamp()) {
				// Off cooldown
				if(player.findStatusAffect(StatusAffects.MarbleItemCooldown) < 0) {
					if(rand(10) == 0) {
						spriteSelect(41);
						outputText("\n<b>You find a note from Marble back at camp, letting you know that she has an item for you!</b>\n", false);
						player.createStatusAffect(StatusAffects.MarbleItemCooldown,(24 + rand(24)),0,0,0);
						player.createStatusAffect(StatusAffects.MarbleHasItem,rand(10),0,0,0);
						needNext = true;
					}
				}
			}
		}
		//Decrement marble cooldown
		if(player.findStatusAffect(StatusAffects.MarbleItemCooldown) >= 0) {
			player.addStatusValue(StatusAffects.MarbleItemCooldown,1,-1);
			if(player.statusAffectv1(StatusAffects.MarbleItemCooldown) < 1)
				player.removeStatusAffect(StatusAffects.MarbleItemCooldown);
		}
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
		//Update urta's PO timer
		if(flags[kFLAGS.URTA_ANGRY_AT_PC_COUNTDOWN] > 1) {
			flags[kFLAGS.URTA_ANGRY_AT_PC_COUNTDOWN]--;
			if(flags[kFLAGS.URTA_ANGRY_AT_PC_COUNTDOWN] < 1) flags[kFLAGS.URTA_ANGRY_AT_PC_COUNTDOWN] = 1;
		}
		//Update Amily's preggo counter
		if(flags[kFLAGS.AMILY_INCUBATION] > 1 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) {
			flags[kFLAGS.AMILY_INCUBATION]--;
			if(flags[kFLAGS.AMILY_INCUBATION] < 1) flags[kFLAGS.AMILY_INCUBATION] = 1;
		}
		//if in camp and birthing, display scene!
		if(flags[kFLAGS.AMILY_FOLLOWER] == 1 && flags[kFLAGS.AMILY_INCUBATION] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) {
			outputText("\n", false);
			amilyScene.amilyPopsOutKidsInCamp();
			flags[kFLAGS.AMILY_INCUBATION] = 0;
			outputText("\n", false);
			needNext = true;
		}
		//Update Amily's Jojo fixing counter
		if(flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] > 0) {
			flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO]--;
			if(flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] < 0) flags[kFLAGS.AMILY_BLOCK_COUNTDOWN_BECAUSE_CORRUPTED_JOJO] = 0;
		}
		//Update Edryn's preggo counter
		if(flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] > 0) {
			//Pregnancy only starts counting down once PC discovers it.
			if(flags[kFLAGS.EDRYN_PREGNAT_AND_NOT_TOLD_PC_YET] > 0) flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION]--;
			//BIRF
			if(flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] <= 0) {
				//Clear incubation
				flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] = 0;
				//Add one kid
				flags[kFLAGS.EDRYN_NUMBER_OF_KIDS]++;
				//Set 'needs to talk to edryn about
				//da kid.
				flags[kFLAGS.EDRYN_NEEDS_TO_TALK_ABOUT_KID] = 1;
			}
		}
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
				outputText("\nAnother change in your uterus ripples through your reproductive systems.  Somehow you know you you've lost your ability to spontaneously lay eggs.\n(<b>Perk Lost: Bunny Eggs</b>)\n", false);
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
						player.knockUp(5,50,1,1);
						//v1 = egg type.
						//v2 = size - 0 for normal, 1 for large
						//v3 = quantity
						player.createStatusAffect(StatusAffects.Eggs,rand(6),rand(2),(5+rand(3)),0);
					}
					//every 30 days if high fertility get egg preg
					else if(model.time.days % 30 == 0) {
						outputText("\n<b>Somehow you know that eggs have begun to form inside you.  You wonder how long it will be before they start to show?</b>\n", false);
						needNext = true;
						player.knockUp(5,50,1,1);
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
		//Remove anemone lustiness
		if(player.findStatusAffect(StatusAffects.AnemoneArousal) >= 0) {
			if(player.pregnancyIncubation > 1) {
				player.removeStatusAffect(StatusAffects.AnemoneArousal);
				outputText("\n<b>The nigh-constant arousal forced upon you by the anemone-like creature in your body finally fades.  You stick a finger inside yourself and marvel in wonder - it's gone!  You aren't sure if it slipped out or your body somehow consumed it, but it's nice to have a clearer head.</b>\n", false);
				needNext = true;
			}
			else if(!player.hasVagina()) {
				player.removeStatusAffect(StatusAffects.AnemoneArousal);
				outputText("\n<b>The nigh-constant arousal forced upon you by the anemone-like creature in your body finally fades.  You aren't sure if it was somehow consumed by the removal of your vagina or if it escaped during the process, but it's nice to have a clear head for a change.</b>\n", false);
				needNext = true;
			}
		}
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
		//Remove marble anti-worm sex
		if(player.findStatusAffect(StatusAffects.Infested) < 0)
			flags[kFLAGS.MARBLE_GROSSED_OUT_BECAUSE_WORM_INFESTATION] = 0;
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
					if(player.statusAffectv1(StatusAffects.WormPlugged) <= 0) player.removeStatusAffect(StatusAffects.WormPlugged);
				}
			}
			//Non cunts lose worm plugged
			else player.removeStatusAffect(StatusAffects.WormPlugged);
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
		//Marble's Milk Status!
		if(player.findStatusAffect(StatusAffects.MarblesMilk) >= 0 && player.findPerk(PerkLib.MarblesMilk) < 0) {
			//Decrement time remaining by 1		
			player.addStatusValue(StatusAffects.MarblesMilk,1,-1);
			//Remove the status and stat boosts when time runs out on the milk
			if(player.statusAffectv1(StatusAffects.MarblesMilk) <= 0) {
				needNext = true;
				dynStats("str", (-1 * player.statusAffectv2(StatusAffects.MarblesMilk)),"tou", (-1 * player.statusAffectv3(StatusAffects.MarblesMilk)));
				player.removeStatusAffect(StatusAffects.MarblesMilk);
				//Text for when Marble's Milk effect wears off:
				//[addiction is 10 or less] 
				if(player.statusAffectv2(StatusAffects.Marble) <= 10) outputText("\nYou feel the euphoria from drinking Marble's milk fade from you. Only now that it's gone do you notice that it was actually making you tougher.\n", false);
				//[addiction is 11-30]
				else if(player.statusAffectv2(StatusAffects.Marble) <= 30) outputText("\nYou feel a slight sense of loss as the euphoria from Marble's milk fades.  You kinda want to drink more, but the desire is not overpowering.\n", false);
				//[addiction is 31-50, player is not addicted]
				else if(player.statusAffectv2(StatusAffects.Marble) <= 50) outputText("\nYou shiver slightly as the euphoria from Marble's milk fades.  You really feel like suckling her breasts again.\n", false);
				//IF ADDICTED
				if(player.statusAffectv3(StatusAffects.Marble) > 0) {
					//If player is under bottled milk effects
					if(player.findStatusAffect(StatusAffects.BottledMilk) >= 0) {
						outputText("\nYour hands develop a tiny tremble as the effects of Marble's fresh milk wear off.  Thanks to the bottled milk you drank, you don't go into withdrawal just yet.\n", false);
					}
					else {
						//[addiction is <90, player is addicted]
						if(player.statusAffectv2(StatusAffects.Marble) <= 90) outputText("\nYour hands start to tremble as you lose the only true relief you get to your cravings.  You desperately want to go see Marble again, especially if it means a chance to drink her wonderful milk.\n", false);
						//[addiction is >=90, player is addicted]
						else outputText("\nThe euphoria from Marble's milk has faded, and you need more milk.  It's almost impossible not to run straight back to her and beg her to let you drink from her breasts again.\n", false);
						//If the player is addicted to her milk, they gain the withdrawal effect when it wears off, reducing player's inte and tou by 5
						player.createStatusAffect(StatusAffects.MarbleWithdrawl,0,0,0,0);
						dynStats("tou", -5, "int", -5);
					}
				}
			}			
		}
		//Go into withdrawl if your addicted and don't have a reason not to be withdrawn.
		if(player.statusAffectv3(StatusAffects.Marble) > 0 && player.findPerk(PerkLib.MarbleResistant) < 0 && player.findPerk(PerkLib.MarblesMilk) < 0 && player.statusAffectv2(StatusAffects.Marble) > 25) {
			//If player does not have marble's milk or bottled milk, go into withdrawl
			if(player.findStatusAffect(StatusAffects.MarblesMilk) < 0 && player.findStatusAffect(StatusAffects.BottledMilk) < 0) {
				//If player is not yet in withdrawl
				if(player.findStatusAffect(StatusAffects.MarbleWithdrawl) < 0) {
					outputText("\nYou are overwhelmed with a desire for more of Marble's Milk.\n", false);
					needNext = true;
					player.createStatusAffect(StatusAffects.MarbleWithdrawl,0,0,0,0);
					dynStats("tou", -5, "int", -5);
				}
			}
		}
		//Prevent addiction from passing 60 if not yet revealed that your addicted
		if(player.statusAffectv3(StatusAffects.Marble) <= 0) {
			if (player.statusAffectv2(StatusAffects.Marble) > 60)
			{
				player.changeStatusValue(StatusAffects.Marble, 2, 60);
			}
		}
		//Withdrawl removal if you get unaddicted.
		if(player.findStatusAffect(StatusAffects.MarbleWithdrawl) >= 0) {
			if(player.statusAffectv2(StatusAffects.Marble) <= 25) {
				player.removeStatusAffect(StatusAffects.MarbleWithdrawl);
				dynStats("tou", 5, "int", 5);
				outputText("\nYou no longer feel the symptoms of withdrawal.\n", false);
				needNext = true;
			}
			//Remove withdrawl if you have bottled milk affect
			else if(player.findStatusAffect(StatusAffects.BottledMilk) >= 0) {
				outputText("\nYou no longer feel the symptoms of withdrawal.\n", false);
				needNext = true;
				player.removeStatusAffect(StatusAffects.MarbleWithdrawl);
				dynStats("tou", 5, "int", 5);
			}
		}
		//Bottled Milk Countdown
		if(player.findStatusAffect(StatusAffects.BottledMilk) >= 0) {
			player.addStatusValue(StatusAffects.BottledMilk,1,-1);
			if(player.statusAffectv1(StatusAffects.BottledMilk) <= 0)
				player.removeStatusAffect(StatusAffects.BottledMilk);
		}
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
		if(model.time.hours == 3 && helFollower.followerHel() && flags[kFLAGS.SLEEP_WITH] == "Helia" && rand(10) == 0) {
			helFollower.sleepyNightMareHel();
		}
		//Luststick resistance unlock
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00285] >= 50 && player.findPerk(PerkLib.LuststickAdapted) < 0) {
			sophieBimbo.unlockResistance();
			needNext = true;
			if(player.findStatusAffect(StatusAffects.Luststick) >= 0) player.removeStatusAffect(StatusAffects.Luststick);
		}
		//Sophie's love
		if((player.findPerk(PerkLib.LuststickAdapted) < 0 || rand(3) == 0) && model.time.hours == 10 && sophieBimbo.bimboSophie() && flags[kFLAGS.SOPHIE_INCUBATION] == 0 && !sophieBimbo.sophieIsInSeason() && flags[kFLAGS.SOPHIE_CAMP_EGG_COUNTDOWN] == 0 && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
			sophieBimbo.bimboSophieLustStickSurprise();
			needNext = true;
		}
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
			if(flags[kFLAGS.LYNNETTE_CARRYING_COUNT] == 0 || flags[kFLAGS.LYNNETTE_PREGNANCY_CYCLE] != 4)
			{
				flags[kFLAGS.LYNNETTE_PREGNANCY_CYCLE]++;
			}
			if(flags[kFLAGS.LYNNETTE_PREGNANCY_CYCLE] == 7) {
				flags[kFLAGS.LYNNETTE_PREGNANCY_CYCLE] = 0;				
			}
			if(flags[kFLAGS.KELLY_REWARD_COOLDOWN] > 0 && model.time.days % 3 == 0) flags[kFLAGS.KELLY_REWARD_COOLDOWN] = 0;
			if(flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] > 0) flags[kFLAGS.HELSPAWN_GROWUP_COUNTER]++;
			if(arianScene.arianFollower() && flags[kFLAGS.ARIAN_VAGINA] > 0) flags[kFLAGS.ARIAN_EGG_EVENT]++;
			flags[kFLAGS.ARIAN_LESSONS] = 0;
			flags[kFLAGS.ARIAN_TREATMENT] = 0;
			flags[kFLAGS.BROOKE_MET_TODAY] = 0;
			if(model.time.days % 2 == 0 && flags[kFLAGS.KAIJU_BAD_END_COUNTER] > 0) {
				flags[kFLAGS.KAIJU_BAD_END_COUNTER]--;
				if(flags[kFLAGS.KAIJU_BAD_END_COUNTER] < 0) flags[kFLAGS.KAIJU_BAD_END_COUNTER] = 0;
			}
			if(desert.antsScene.phyllaWaifu() && flags[kFLAGS.PHYLLA_EGG_LAYING] > 0) flags[kFLAGS.DAYS_PHYLLA_HAS_SPENT_BIRTHING]++;
			if(flags[kFLAGS.GILDED_JERKED] > 0) flags[kFLAGS.GILDED_JERKED] = 0;
			if(flags[kFLAGS.PHYLLA_GEMS_HUNTED_TODAY] > 0) flags[kFLAGS.PHYLLA_GEMS_HUNTED_TODAY] = 0;
			if(desert.antsScene.phyllaWaifu()) flags[kFLAGS.DAYS_PHYLLA_IN_CAMP]++;
			if(flags[kFLAGS.SHEILA_CLOCK] < 0) flags[kFLAGS.SHEILA_CLOCK]++;
			if(flags[kFLAGS.SHEILA_PREG] > 0) flags[kFLAGS.SHEILA_PREG]++;
			if(flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] == 0) flags[kFLAGS.URTA_CUM_NO_CUM_DAYS]++;
			else flags[kFLAGS.URTA_CUM_NO_CUM_DAYS] = 0;
			if(flags[kFLAGS.FED_SCYLLA_TODAY] == 1) flags[kFLAGS.FED_SCYLLA_TODAY] = 0;
			//Count Kelt being a bitch
			if(flags[kFLAGS.KELT_BREAK_LEVEL] >= 4) flags[kFLAGS.KELLY_DISOBEYING_COUNTER]++;
			
			if(flags[kFLAGS.EGG_WITCH_COUNTER] > 0) {
				if(flags[kFLAGS.EGG_WITCH_COUNTER] < 8) flags[kFLAGS.EGG_WITCH_COUNTER]++;
				//Birth without PC knowing after 8 days.
				else {
					flags[kFLAGS.EGG_WITCH_COUNTER] = 0;
					flags[kFLAGS.EGG_WITCH_TYPE] = 0;
				}
			}
			if(flags[kFLAGS.HEL_RAPED_TODAY] == 1) flags[kFLAGS.HEL_RAPED_TODAY] = 0;
			if(flags[kFLAGS.FOUND_ISABELLA_AT_FARM_TODAY] == 1) flags[kFLAGS.FOUND_ISABELLA_AT_FARM_TODAY] = 0;
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
			if(player.pregnancyIncubation <= 0) flags[kFLAGS.EMBER_BITCHES_ABOUT_PREGNANT_PC] = 0;
			if(vapula.vapulaSlave() && flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 0) {
				if(flags[kFLAGS.VAPULA_HAREM_FUCK] == 0) flags[kFLAGS.VAPULA_DAYS_SINCE_FED]++;
				else flags[kFLAGS.VAPULA_DAYS_SINCE_FED] = 0;
			}
			if(flags[kFLAGS.VAPULA_FOLLOWER] == .5 || flags[kFLAGS.VAPULA_FOLLOWER] == 1.5) flags[kFLAGS.VAPULA_FOLLOWER]++;
			flags[kFLAGS.DRANK_EMBER_BLOOD_TODAY] = 0;
			flags[kFLAGS.DAYS_SINCE_LAST_DEMON_DEALINGS]++;
			flags[kFLAGS.MARBLE_PLAYED_WITH_KIDS_TODAY] = 0;
			if(flags[kFLAGS.AMILY_X_JOJO_COOLDOWN] > 0) {
				flags[kFLAGS.AMILY_X_JOJO_COOLDOWN]--;
			}
			if(flags[kFLAGS.AMILY_INCEST_COUNTDOWN_TIMER] > 0 && flags[kFLAGS.AMILY_INCEST_COUNTDOWN_TIMER] < 60)
				flags[kFLAGS.AMILY_INCEST_COUNTDOWN_TIMER]++;
			flags[kFLAGS.ROGAR_FUCKED_TODAY] = 0;
			//Isabella milk
			if(isabellaFollowerScene.isabellaFollower() && flags[kFLAGS.ISABELLA_MILKED_YET] >= 0 && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) {
				flags[kFLAGS.ISABELLA_MILKED_YET]++;
			}
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
			//Reset Izma tooth hand outs
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00246] > 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00246] = 0;
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
			//Update Urta's luv counter
			if(flags[kFLAGS.URTA_PC_AFFECTION_COUNTER] > 0) {
				flags[kFLAGS.URTA_PC_AFFECTION_COUNTER] -= .5;
				if(flags[kFLAGS.URTA_PC_AFFECTION_COUNTER] < 0) flags[kFLAGS.URTA_PC_AFFECTION_COUNTER] = 0;
			}
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
			
			//Marble Preggo Counter
			if(flags[kFLAGS.MARBLE_PREGNACY_INCUBATION] > 0) {
				flags[kFLAGS.MARBLE_PREGNACY_INCUBATION] -= 24;
				if(flags[kFLAGS.MARBLE_PREGNACY_INCUBATION] <= 0) flags[kFLAGS.MARBLE_PREGNACY_INCUBATION] = 1;
			}
			//Tamani's Daughters stuff
			//Lower countdown till next event
			if(flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN] > 0) {
				flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN]--;
				trace("DAUGHTER PREGGO COUNTER: " + flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN]);
			}
			//Decrease egg-laying time out.
			if(flags[kFLAGS.TAMANI_TIME_OUT] > 0) {
				flags[kFLAGS.TAMANI_TIME_OUT]--;
				if(flags[kFLAGS.TAMANI_TIME_OUT] < 0) flags[kFLAGS.TAMANI_TIME_OUT] = 0;
			}
			if(flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN] < 0) flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN] = 0;
			//Put a cap on daughters if they havent been met yet.
			if(flags[kFLAGS.TIMES_ENCOUNTED_TAMANIS_DAUGHTERS] == 0) {
				if(player.statusAffectv2(StatusAffects.Tamani) > 30)
					player.changeStatusValue(StatusAffects.Tamani,2,30);
				
			}
			
			//Lower daughter population by 1 every fourth day
			//once population gets high
			if(player.statusAffectv2(StatusAffects.Tamani) > 40 && model.time.days % 4 == 0) {
				player.addStatusValue(StatusAffects.Tamani,2,-1);
			}
			//Tamani pregnancy counting
			if(player.statusAffectv1(StatusAffects.Tamani) > -500) {
				player.addStatusValue(StatusAffects.Tamani,1,-1);
				//Silently give birth if player missed the chance to see it
				if(player.statusAffectv1(StatusAffects.Tamani) <= -2) {
					//Add new daughters to count
					player.addStatusValue(StatusAffects.Tamani,2,player.statusAffectv3(StatusAffects.Tamani));
					//reset incubation
					player.changeStatusValue(StatusAffects.Tamani,1,-500);
					//clear daughters to be born
					player.changeStatusValue(StatusAffects.Tamani,3,0);
					//Increment times made pregnant
					player.addStatusValue(StatusAffects.Tamani,4,1);
				}
			}
			//Remove jojo meditation block
			if(player.statusAffectv1(StatusAffects.Meditated) > 0) {
				player.removeStatusAffect(StatusAffects.Meditated);
				if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00102] == 0) {
					flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00102]++;
					while(player.findStatusAffect(StatusAffects.Meditated) >= 0) {
						player.removeStatusAffect(StatusAffects.Meditated);
					}
				}
			}
			//Lower addiction by 1 every day.
			if(player.findStatusAffect(StatusAffects.Marble) >= 0) {
				if(player.statusAffectv2(StatusAffects.Marble) > 0) marbleScene.marbleStatusChange(0,-1);
			}
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
			//Lower bonus score for drinking contest
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00227] > 0) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00227]--;
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
		//Amily stuff!
		if(model.time.hours == 6) {
			//Pure amily flips her shit and moves out!
			if(flags[kFLAGS.AMILY_FOLLOWER] == 1 && player.cor >= 66 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00173] > 0) {
				amilyScene.farewellNote();
				needNext = true;
			}
			//Amily moves back in once uncorrupt.
			if(flags[kFLAGS.AMILY_TREE_FLIPOUT] == 0 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00173] > 0 && player.cor <= 25 && flags[kFLAGS.AMILY_FOLLOWER] == 0) {
				amilyScene.amilyReturns();
				needNext = true;
			}
		}
		//BIG EVENTS GO IN HERE
		//BIG EVENTS GO IN HERE
		//BIG EVENTS GO IN HERE
		//BIG EVENTS GO IN HERE
		//MARBLE POOPS BAYBEEZ
		if(flags[kFLAGS.MARBLE_PREGNACY_INCUBATION] == 1 && marbleScene.marbleAtCamp()) {
			marbleScene.marblePoopsBaybees();
			return true;
		}		
		//Helia's morning surprise!  TOP PRIORITY!
		if(flags[kFLAGS.EDRYN_BIRF_COUNTDOWN] > 0) {
			flags[kFLAGS.EDRYN_BIRF_COUNTDOWN]--;
			if(flags[kFLAGS.EDRYN_BIRF_COUNTDOWN] <= 0) {
				flags[kFLAGS.EDRYN_BIRF_COUNTDOWN] = 0;
				urtaQuest.urtaAndEdrynGodChildEpilogue();
				return true;
			}
		}
		if(model.time.hours == 6 && flags[kFLAGS.SOPHIE_FOLLOWER_PROGRESS] >= 5 && !sophieBimbo.bimboSophie() && !sophieFollowerScene.sophieFollower() && player.hasCock() && flags[kFLAGS.NO_PURE_SOPHIE_RECRUITMENT] == 0 && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
			sophieFollowerScene.sophieFollowerIntro();
			return true;
		}
		if(model.time.hours == 23 && helFollower.followerHel() && flags[kFLAGS.HEL_BONUS_POINTS] >= 150 && flags[kFLAGS.HELIA_KIDS_CHAT] == 0) {
			helSpawnScene.heliaBonusPointsAward();
			return true;
		}
		if(model.time.hours == 8 && helFollower.followerHel() && flags[kFLAGS.HEL_NTR_TRACKER] == 1) {
			helSpawnScene.helGotKnockedUp();
			return true;
		}
		if(flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 1 && flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED] > 0 && helFollower.helAffection() >= 100 &&
		   flags[kFLAGS.HELIA_FOLLOWER_DISABLED] == 0 && model.time.hours == 2) {
			helFollower.heliaFollowerIntro();
			return true;   
		}
		if(flags[kFLAGS.HEL_FOLLOWER_LEVEL] == -1 && model.time.hours == 6) {
			morningAfterHeliaDungeonAgreements();
			return true;
		}
		//Helspawn night smex!
		if(flags[kFLAGS.HELSPAWN_AGE] == 2 && (model.time.hours == 2 || model.time.hours == 3 || model.time.hours == 4) && flags[kFLAGS.HELSPAWN_GROWUP_COUNTER] == 7 && flags[kFLAGS.HELSPAWN_FUCK_INTERRUPTUS] == 0) {
			helSpawnScene.helspawnIsASlut();
			return true;
		}		
		//Ghostgirl recruitment priority
		if(flags[kFLAGS.SHOULDRA_FOLLOWER_STATE] == .5 && model.time.hours == 6) {
			shouldraFollower.morningShouldraAlert();
			return true;
		}
		//Ghostgirl pissed off dreams
		if(shouldraFollower.followerShouldra() && flags[kFLAGS.SHOULDRA_SLEEP_TIMER] <= -236 && model.time.hours == 3 && player.gender > 0) {
			shouldraFollower.nightTimeShouldraRapesThePC();
			return true;
		}
		//Ghostgirl madness
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00365] > 0) {
			if(player.cockTotal() > 1 || player.faceType != FACE_HUMAN || player.lowerBody != LOWER_BODY_TYPE_HUMAN || player.tailType > TAIL_TYPE_NONE || player.horns > 0 || player.cor > 15 || player.longestCockLength() > 10 || player.tallness < 65 || player.tallness > 78 || player.hasVagina()) flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00365] = 0;
			else {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00365]--;
				if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00365] == 0) {
					shouldraScene.paladinModeFollowup();
					return true;
				}
			}
		}
		if(player.findStatusAffect(StatusAffects.EmberNapping) < 0) {
			//Ember get's a whiff of fuckscent and knocks up PC!
			if(emberScene.followerEmber() && player.hasVagina() && player.inHeat && player.pregnancyIncubation == 0 && player.findStatusAffect(StatusAffects.EmberFuckCooldown) < 0 && rand(10) == 0 && (flags[kFLAGS.EMBER_GENDER] == 1 || flags[kFLAGS.EMBER_GENDER] == 3)) {
				emberScene.emberRapesYourHeatness();
				return true;
			}
			else if(emberScene.followerEmber() && player.hasCock() && player.inRut && flags[kFLAGS.EMBER_INCUBATION] == 0 && player.findStatusAffect(StatusAffects.EmberFuckCooldown) < 0 && rand(10) == 0 && flags[kFLAGS.EMBER_GENDER] >= 2) {
				emberScene.emberRapesYourHeatness();
				return true;
			}
		}
		if(rand(4) == 0 && isHolidays() && player.gender > 0 && model.time.hours == 6 && flags[kFLAGS.XMAS_CHICKEN_YEAR] < date.fullYear) {
			getAChristmasChicken();
			return true;
		}
		//Amily X Urta morning after.
		if(!urtaQuest.urtaBusy() && flags[kFLAGS.AMILY_VISITING_URTA] == 2 && model.time.hours == 6) {
			followerInteractions.amilyUrtaMorningAfter();
			return true;
		}
		if(flags[kFLAGS.VAPULA_FOLLOWER] >= 2.5 && model.time.hours == 6 && flags[kFLAGS.FOLLOWER_AT_FARM_VAPULA] == 0) {
			vapula.femaleVapulaRecruitmentPartII();
			return true;
		}
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
		//Shouldra dreams here
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
			if(model.time.days % 30 == 0 && flags[kFLAGS.ANEMONE_KID] > 0 && player.hasCock() && flags[kFLAGS.ANEMONE_WATCH] > 0 && player.statusAffectv2(StatusAffects.Tamani) >= 40) {
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
		//MORNING FUX
		if(model.time.hours == 6 && sophieBimbo.bimboSophie() && flags[kFLAGS.SLEEP_WITH] == "Sophie" && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0 && rand(2) == 0 && player.hasCock() && player.cockThatFits(sophieBimbo.sophieCapacity()) >= 0) {
			outputText("\n<b><u>Something odd happens that morning...</u></b>");
			if(flags[kFLAGS.SOPHIE_INCUBATION] > 0 && flags[kFLAGS.SOPHIE_INCUBATION] < 120) sophieBimbo.fuckYoPregnantHarpyWaifu(true);
			else sophieBimbo.sophieFenCraftedSex(true);
			return true;
		}
		if(model.time.hours == 6 && sophieFollowerScene.sophieFollower() && flags[kFLAGS.SLEEP_WITH] == "Sophie" && player.lust >= 50 && player.hasCock() && player.smallestCockArea() <= 5 && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0) {
			sophieFollowerScene.sophieSmallDongTeases();
			return true;
		}
		//MARBLE STUFF
		//End addiction (occurs after the player wakes up when their addiction is under 25 && is not permanently addicted)
		if(player.statusAffectv3(StatusAffects.Marble) > 0 && player.statusAffectv2(StatusAffects.Marble) < 25 && player.findPerk(PerkLib.MarblesMilk) < 0 && player.findPerk(PerkLib.MarbleResistant) < 0 && model.time.hours == 6) {
			spriteSelect(41);
			outputText("\nYou wake up feeling strangely at ease, having slept better than you have in a long while.  After a minute, you realize that you don't feel a need to drink Marble's milk anymore!  You are free of your addiction.  You hurry off to the farm to give her the news.\n\n", false);
			outputText("You find Marble in her room.  When you come in she looks up at you and starts.  \"<i>What happened?</i>\" she asks, \"<i>Something about you is completely different from before...</i>\"  You explain to her that you've gotten over your addiction and no longer crave her milk.\n", false);
			//(reduce corr by 5)
			dynStats("cor", -5);
			//(From this point forward, the addiction scores and affection scores are no longer modified.  Additionally, the player can no longer be given the status effect of 'Marble's Milk' or go into withdrawal)
			player.createPerk(PerkLib.MarbleResistant,0,0,0,0);
			//After player ends Addiction:
			//Marble liked you addicted
			if(player.statusAffectv3(StatusAffects.Marble) == 1) {
				//Affection 0-29, version 1
				if(player.statusAffectv1(StatusAffects.Marble) < 30) {
					outputText("\nMarble looks horrified at your words and exclaims, \"<i>You told me you would always want my milk!  How could you do this to me?</i>\"  You try to explain yourself to her, but she will have none of it.  \"<i>That's it, I'm leaving, don't come looking for me.</i>\"  She storms out the door.  Having no further reason to stay here, you leave too.\n", false);
					//(Marble leaves the farm, she is no longer encountered)
					player.createStatusAffect(StatusAffects.NoMoreMarble,0,0,0,0);
				}
				//Affection 30-89, version 1
				if(player.statusAffectv1(StatusAffects.Marble) >= 30 && player.statusAffectv1(StatusAffects.Marble) < 90) {
					outputText("\nMarble looks horrified at your words and exclaims \"<i>You told me you would always want my milk!  How could you do this to me?</i>\"  You try to explain yourself to her, telling her how important your task is and how everyone is counting on you.  As you speak, her expression slowly softens and eventually she calms down.  \"<i>Alright,</i>\" she says, \"<i>I guess I shouldn't have worried about my milk so much.  It's probably best if people don't drink it anyway.</i>\"  You agree with her and she smiles at you.  \"<i>I guess things are back to normal now.</i>\"  You both laugh at this.\n", false);
					//(Marble can be met at the farm)
				}
				//Affection 90+, version 1
				if(player.statusAffectv1(StatusAffects.Marble) >= 90) {
					outputText("\nMarble looks horrified at your words and exclaims \"<i>You told me you would always want my milk!  How could you do this to me?</i>\"  You try to explain yourself to her, telling her how important your task is and how everyone is counting on you.  As you speak, her expression slowly softens and eventually she calms down.  \"<i>Alright,</i>\" she says \"<i>I guess I shouldn't have worried about my milk so much.  It's probably best if people don't drink it anyway.</i>\"  You agree with her and she smiles, suddenly looking down.  \"<i>Without someone like you, I don't think things would have turned out this way.  I..</i>\" she hesitates, \"<i>I'll stay with you at camp from now on!</i>\"\n", false);
					//(Marble now appears at the camp)
					player.createStatusAffect(StatusAffects.CampMarble, 0, 0, 0, 0);
					flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] = 0;
					if(isabellaFollowerScene.isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) flags[kFLAGS.ISABELLA_MURBLE_BLEH] = 1;
					//if amily is there, tag it for freakout
					if(flags[kFLAGS.AMILY_FOLLOWER] > 0 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) {
						flags[kFLAGS.MARBLE_OR_AMILY_FIRST_FOR_FREAKOUT] = 2;
					}
					//if Izma is there, tag for freakout!
					if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) {
						flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00237] = 1;
					}
					else flags[kFLAGS.MARBLE_OR_AMILY_FIRST_FOR_FREAKOUT] = 1;
					player.createStatusAffect(StatusAffects.NoMoreMarble,0,0,0,0);
				}
			}
			//Ashamed Marble
			else {
				//Affection 0-29, version 2
				if(player.statusAffectv1(StatusAffects.Marble) < 30) {
					outputText("\nMarble seems impassive at the news of hearing that you are no longer addicted.  Her eyes have gone cold, her old passion gone.  \"<i>Good,</i>\" she states simply and points at a paper on the table in her room.  \"<i>That's for you. Goodbye.</i>\" With that, she turns and walks out the room.  Since you are unsure how to react, you decide to take a look at the paper.\n\n", false);
					//[This section should be indented and/or italicized] - put the codex entry here
					outputText("The piece of paper looks like a page torn from a book.  It looks like an entry from an encyclopedia of sorts, it reads in formal script:\n", false);
					outputText("<b><u>Codex: Lacta Bovine</u></b>\n", false);
					outputText("Description: <i>A race of all female bovine-morphs, more commonly called cow-girls.  They appear as tall well endowed women, with numerous bovine characteristics.  Generally they have bovine horns, ears, tail, and legs.  Like all minotaurs, they are very strong and resilient, however, they are unusually sensitive compared to their relatives.</i>\n", false);
					outputText("Skin and Fur: <i>The skin tone for these creatures is very close to being human, their fur more closely follows the common minotaur fur colors: brown, black or white with brown spots.</i>\n", false);
					outputText("Behavior: <i>The behavior of Lacta Minotaurs varies greatly between each individual.  The only major unifying piece of behavior is their desire to give milk to almost any living creature, and their high libido, common to all corrupted creatures.</i>\n", false);
					outputText("Special abilities: <i>A lightly corrupted creature, most of the corruption is centered on their breast milk.  It is addictive to those that drink it repeatedly, eventually making them dependent on the one from whom it was drank from.  The milk also strengthens the drinker, makes them better able to find the one who nursed them, and grants limited powers of control over them to the Lacta Minotaur that nursed them.  Finally, the breasts of Lacta Minotaurs are incredibly resilient, healing from almost any damage, even being cut off; they are able to produce milk for their entire life without fail.</i>\n", false);
					outputText("\nUnderneath the entry is a single line, written in a crude and unsteady hand:     <i>No one will ever drink my milk again.  I'm sorry, sweetie.</i>\n", false);
					player.createStatusAffect(StatusAffects.NoMoreMarble,0,0,0,0);
				}
				//Affection 30-69, version 2
				if(player.statusAffectv1(StatusAffects.Marble) >= 30 && player.statusAffectv1(StatusAffects.Marble) < 70) {
					outputText("\nMarble looks relieved, like a great weight has been lifted from her shoulders.  \"<i>I'm glad you won't need me anymore then,</i>\" she says, her face falling, \"<i>Now, no one will mind if I disappear.</i>\"  You look at her in surprise and ask her why she says that.  She explains that the only way to be sure that no one else ever drinks her milk is for her to disappear, forever.  You tell her not to think like that and that the people on the farm still appreciate her help with the chores and duties, insisting that they would all be sorry to see her go. Besides, now that you both know that her milk is addictive, the two of you have a big advantage compared to what happened the first time.  \"<i>Plus, we got through it, didn't we?</i>\" you say with a smile.  At this, her face lights up, \"<i>You're right! Thanks for being such a good friend, sweetie.</i>\"  She smiles at you in return.  \"<i>I guess things are back to normal now.</i>\"  You both laugh at this.\n", false);
					//(Marble can be encountered at the farm)
				}
				//Affection 70+, version 2
				if(player.statusAffectv1(StatusAffects.Marble) >= 70) {
					outputText("\nMarble looks relieved, like a great weight has been lifted from her shoulders.  \"<i>I'm glad you won't need me anymore then,</i>\" she says, her face falling, \"<i>Now, no one will mind if I disappear.</i>\"  You look at her in surprise and quickly grab her arms.  You tell her with no uncertainty that if she disappeared, you would forever miss her.  You don't care about her milk, it doesn't matter; it is her as a person that matters to you.  You wouldn't have done all those things or spent all that time together if you didn't care about her.  She bursts into tears and hugs you tightly to her breasts.\n\n", false);
					marbleScene.marbleAddictionSex(false);
					outputText("\n", false);
					player.createStatusAffect(StatusAffects.CampMarble, 0, 0, 0, 0);
					flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] = 0;
					if(isabellaFollowerScene.isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) flags[kFLAGS.ISABELLA_MURBLE_BLEH] = 1;
					//if amily is there, tag it for freakout
					if(flags[kFLAGS.AMILY_FOLLOWER] > 0 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) {
						flags[kFLAGS.MARBLE_OR_AMILY_FIRST_FOR_FREAKOUT] = 2;
					}
					//if Izma is there, tag for freakout!
					if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) {
						flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00237] = 1;
					}
					else flags[kFLAGS.MARBLE_OR_AMILY_FIRST_FOR_FREAKOUT] = 1;
					player.createStatusAffect(StatusAffects.NoMoreMarble,0,0,0,0);
				}
			}
			outputText("\n<b>You have gained the perk Marble Resistance</b> (You know how to avoid the addictive qualities of her milk!)\n", false);
			doNext(1);
			return true;
		}
		//Become permanently addicted (occurs when the player goes to sleep with addiction 100, before it is reduced by the standard 1):
		if(player.statusAffectv3(StatusAffects.Marble) > 0 && player.statusAffectv2(StatusAffects.Marble) >= 100 && player.findPerk(PerkLib.MarblesMilk) < 0 && player.findPerk(PerkLib.MarbleResistant) < 0 && model.time.hours == 6) {
			spriteSelect(41);
			outputText("\nYou wake up feeling like something has changed.  With slightly chilling clarity, you realize that you have finally become completely and utterly dependent on Marble's milk; you must drink her milk every day, or you will die.  There is nothing that can be done to change that at this point.  You hurry over to the farm; you have to drink Marble's milk, NOW.\n\n", false);
			outputText("You find Marble in her room.  When you come in she looks up at you and smiles deeply.  \"<i>What happened?</i>\" she asks, \"<i>Something about you feels so wonderful and right.</i>\"  You explain to her that you've finally become entirely dependent on her milk.\n", false);
			//(From this point forward, the addiction scores and affection scores are no longer modified.  Additionally, the player can no longer be given the status effect of 'Marble's Milk' or go into withdrawal, they are instead permanently given the stat increases of 5 str, and 10 tou as part of a perk called 'Marble's Milk' and automatically drink Marble's milk every morning if a bad end is not triggered)
			player.createPerk(PerkLib.MarblesMilk,0,0,0,0);
			//Clear withdrawl
			if(player.findStatusAffect(StatusAffects.MarbleWithdrawl) >= 0) {
				player.removeStatusAffect(StatusAffects.MarbleWithdrawl);
				dynStats("tou", 5, "int", 5);
			}
			//Clear marble's milk status
			if(player.findStatusAffect(StatusAffects.MarblesMilk) >= 0) {
				player.removeStatusAffect(StatusAffects.MarblesMilk);
			}
			//Boost stats if not under its affects
			else {
				dynStats("str", 5,"tou", 10);
			}
			//Post-addiction flavors
			//Marble liked you addicted
			if(player.statusAffectv3(StatusAffects.Marble) == 1) {
				//Affection 0-49, type 1:
				if(player.statusAffectv1(StatusAffects.Marble) < 49) {
					//outputText("\nA huge grin passes over Marble's face, \"<i>I'm glad to hear it sweetie,</i>\" she tells you, \"<i>I was hoping you might help me out with my chores. Then I'll see about getting you some milk.</i>\"  The idea of working for her milk seems oddly right, and you put a huge effort into helping Marble with her chores.  Afterwards, Marble gladly agrees to give you her milk. While you are nursing from her, she starts to talk: \"<i>Sweetie, I've been thinking.  I think you should stay here with me from now on, since you need my milk to survive.</i>\"  She starts to stroke your head.  \"<i>You always do such a good job with the chores too; do you really want to do anything else?</i>\"  You try to pull back from her and tell her about your quest, but she keeps your mouth from straying from her breast.  \"<i>No, of course you don't.</i>\"  She says with finality, and you feel your need to do anything else fade....\n\n", false);
					//outputText("\nMarble continues talking for a while, but it doesn't really matter to you anymore, all that matters to you now is earning her milk, and doing anything to please her.  Your mind is still able to wander freely, but it is so fixated on your need that you will remain at Marble's side for the rest of your life.  Your village will just have to rely on the next champion.", false);
					outputText("Marble grabs you and pulls your head into her chest.  \"<i>Mmm, if you need me so much, then I want you to move in with me on the farm,</i>\" she says happily above you.  \"<i>That way, I can take care of you and you can help me, and we'll both be happy.</i>\"  You panic a bit; while you'd certainly be happy to have the source of her delicious milk at your fingertips, leaving the portal unguarded means the demons will be free to set up shop there again!  Marble responds to your squirming by tightening her arms and says, \"<i>Ah, ah, remember, sweetie; you need my milk and I control whether or not you can drink it.  I'm happy to share it, but if I'm being so generous, I think the least you could do is make it easier for me.  I don't think living here and helping me with the farmwork is too much to ask, do you?</i>\"  Her face contorts into an open-mouthed smile and her eyes glitter.  You sigh into her chest, she's right, there isn't much you can do about it now...");
					doNext(marbleScene.marbleBadEndFollowup);
					return true;
				}
				//Affection 50-79, type 1:
				if(player.statusAffectv1(StatusAffects.Marble) >= 50 && player.statusAffectv1(StatusAffects.Marble) < 79) {
	
					outputText("\nA huge grin passes over Marble's face, \"<i>I'm glad to hear it sweetie,</i>\" she tells you, \"<i>Are you thirsty already?</i>\" You give an eager nod and she slips her top off, pushing your mouth to one of her teats.  After you've drunk your fill, Marble sighs and gives you a smile.  \"<i>I was thinking that maybe you should live with me from now on, but I think I like seeing you visit like this too much.  It always makes me so happy to see you come by, so why don't we just leave things the way they are?</i>\"  You agree with her and she says \"<i>I'll see you tomorrow when you're thirsty again.</i>\"  You nod again and return to your camp.\n", false);
					//(Marble can be encountered at the farm)
					//(every morning, the player goes to Marble for milk, it costs them the first hour of the day)
				}
				//High affection
				if(player.statusAffectv1(StatusAffects.Marble) >= 80) {
					outputText("\nA huge grin passes over Marble's face, \"<i>I'm glad to hear it sweetie,</i>\" she tells you, \"<i>Are you thirsty already?</i>\" You give an eager nod and she slips her top off, pushing your mouth to one of her teats.  After you've drunk your fill, you notice Marble staring closely at you. \"<i>Sweetie, do you like me for more than just my milk?</i>\"  You are taken aback by the question, why wouldn't you?  \"<i>I want to know if you like me because I'm me, and not because you like my milk.  Can you show me in a special way?</i>\" she asks you, suggestively.  You agree without having to think about it at all.\n\n", false);
					//(player chose yes) do after addiction sex event
					marbleScene.marbleAddictionSex(false);
					outputText("\n", false);
					//(Marble now appears at the camp)
					player.createStatusAffect(StatusAffects.CampMarble, 0, 0, 0, 0);
					flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] = 0;
					if(isabellaFollowerScene.isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) flags[kFLAGS.ISABELLA_MURBLE_BLEH] = 1;
					player.createStatusAffect(StatusAffects.NoMoreMarble,0,0,0,0);
					//(every morning, the player goes to Marble for milk, since she is at the camp, it does not cost them the first hour of the day)
					//if amily is there, tag it for freakout
					if(flags[kFLAGS.AMILY_FOLLOWER] > 0 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) {
						flags[kFLAGS.MARBLE_OR_AMILY_FIRST_FOR_FREAKOUT] = 2;
					}
					else flags[kFLAGS.MARBLE_OR_AMILY_FIRST_FOR_FREAKOUT] = 1;
					//if Izma is there, tag for freakout!
					if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) {
						flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00237] = 1;
					}
				}
			}
			//Marble didn't like you addicted
			else {
				//Replacement scene for when the player becomes addicted, Marble is ashamed, and her affection is low (<20)
				if(player.statusAffectv1(StatusAffects.Marble) < 30) {
					//outputText("At your words, Marble's face falls completely.  She looks up at you for a moment before saying \"<i>I'm so sorry; it's my fault for not being able to refuse you.</i>\"  You hesitate, not sure how to reply to her.  She sighs and invites you to her chest.\n\n", false);
					//outputText("As you're drinking from Marble's breasts, you hear her say \"<i>Don't you ever leave my side again, sweety.  I'll make it up to you for what happened.</i>\"  As she says this an odd feeling passes through you.  For a brief instant you panic as you realize that any thought not to do as Marble asks is vanishing from your mind.  Then it passes, and without any doubt, you will be staying with Marble for the rest of your life.  There will be no more adventuring for this year's champion.  \n\n", false);
					outputText("Marble grabs you and pulls your head into her chest.  \"<i>I'm so sorry sweetie, I never meant for this to happen,</i>\" she sobs above you.   \"<i>I'll make this right, I'll make sure nothing else ever hurts you, even if I have to make you stay here with me.</i>\"  An alarm rings in your head; how are you supposed to complete your mission like this?  Marble feels you squirm, and speaks again.  \"<i>I'm sorry, [name], but if you need my milk, this is really the best way... for both of us.</i>\"");
					doNext(marbleScene.marbleBadEndFollowup);
					return true;
				}
				//Affection < 80, type 2:
				else if(player.statusAffectv1(StatusAffects.Marble) < 80) {
					outputText("Marble's face falls at your words.  \"<i>I'm so sorry; it's my fault for not being able to refuse you.</i>\"  You shake your head and tell her it wasn't something either of you could stop.  Despite what you said before, what happened happened.  You two will just have to find a way to go on, regardless.  She nods and holds out her arms. You gladly move forward and accept her milk.  Once you've finished drinking, Marble looks at you and says, \"<i>I guess I'll see you tomorrow when you're thirsty again.</i>\"  You nod and return to your camp.\n", false);
					//(Marble can be encountered at the farm)
					//(every morning, the player goes to Marble for milk, it costs them the first hour of the day)
				}
				//Affection 80+, type 2:
				else {
					outputText("Marble's face falls at your words.  \"<i>I'm so sorry; it's my fault for not being able to refuse you.</i>\"  You shake your head and tell her it wasn't something either of you could stop.  Despite what you said before, what happened happened.  You care too much for her to let her feel bad about it, and you tell her you forgive her for the part she played in getting you addicted to her milk.  She bursts into tears and hugs you tightly to her breasts, before letting you drink your morning milk.  Afterwards she looks at you intently. \"<i>Can we do something special?</i>\" she asks you, suggestively.  You agree without having to give it any thought.\n\n", false);
					//(player chose yes) do after addiction sex event
					marbleScene.marbleAddictionSex(false);
					outputText("\n", false);
					//(Marble now appears at the camp)
					player.createStatusAffect(StatusAffects.CampMarble, 0, 0, 0, 0);
					flags[kFLAGS.FOLLOWER_AT_FARM_MARBLE] = 0;
					if(isabellaFollowerScene.isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0) flags[kFLAGS.ISABELLA_MURBLE_BLEH] = 1;
					player.createStatusAffect(StatusAffects.NoMoreMarble,0,0,0,0);
					//(every morning, the player goes to Marble for milk, since she is at the camp, it does not cost them the first hour of the day)
					//if amily is there, tag it for freakout
					if(flags[kFLAGS.AMILY_FOLLOWER] > 0 && flags[kFLAGS.FOLLOWER_AT_FARM_AMILY] == 0) {
						flags[kFLAGS.MARBLE_OR_AMILY_FIRST_FOR_FREAKOUT] = 2;
					}
					//if Izma is there, tag for freakout!
					if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1 && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0) {
						flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00237] = 1;
					}
					else flags[kFLAGS.MARBLE_OR_AMILY_FIRST_FOR_FREAKOUT] = 1;
				}
			}
			outputText("\n(You gain the <b>Marble's Milk</b> perk.  It boosts your strength and toughness, but requires that you drink Marble's Milk every day.)\n", false);
			doNext(1);
			return true;
		}
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
		//Cotton's cereal overlapps marbleliciousness
		if(model.time.hours == 6 && flags[kFLAGS.COTTON_BREAKFAST_CLUB] == 1 && player.biggestLactation() >= 2) {
			flags[kFLAGS.COTTON_BREAKFAST_CLUB] = 0;
			telAdre.cotton.nomSomeTitMilkCereal();
			return true;
		}
		//Isabella's morning suckoffs!
		if(model.time.hours == 6 && isabellaFollowerScene.isabellaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_ISABELLA] == 0 && flags[kFLAGS.ISABELLA_BLOWJOBS_DISABLED] == 0 && player.hasCock() && (model.time.days % 2 == 0 || player.findPerk(PerkLib.MarblesMilk) < 0) && player.shortestCockLength() <= 9) {
			spriteSelect(31);
			isabellaFollowerScene.isabellaMorningWakeupCall();
			return true;
		}
		//Morning Marble Meetings
		if(model.time.hours == 6 && player.findPerk(PerkLib.MarblesMilk) >= 0) {
			//Marble is at camp
			if(player.findStatusAffect(StatusAffects.CampMarble) >= 0) {
				marbleScene.postAddictionCampMornings(false);
				needNext = true;
			}
			//Marble isn't at camp
			else {
				//Marble is still available at farm
				if(player.findStatusAffect(StatusAffects.NoMoreMarble) < 0) {
					marbleScene.postAddictionFarmMornings();
					threshhold--;
					needNext = true;
				}
			}
			doNext(1);
			return true;
		}
		//Sophie Izma 3some
		if(sophieBimbo.bimboSophie() && flags[kFLAGS.FOLLOWER_AT_FARM_SOPHIE] == 0 && izmaScene.izmaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0&& flags[kFLAGS.IZMA_NO_COCK] == 0 && ((flags[kFLAGS.TIMES_SOPHIE_AND_IZMA_FUCKED] == 0 && rand(10) == 0) || flags[kFLAGS.TOLD_SOPHIE_TO_IZMA] == 1)) {
			flags[kFLAGS.TOLD_SOPHIE_TO_IZMA] = 0;
			sophieBimbo.sophieAndIzmaPlay();
			return true;
		}
		if(izmaScene.izmaFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_IZMA] == 0 && flags[kFLAGS.IZMA_NO_COCK] == 0 && latexGirl.latexGooFollower() && flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 0&& flags[kFLAGS.TIMES_IZMA_DOMMED_LATEXY] == 0 && (debug || rand(10) == 0)) {
			izmaScene.izmaDomsLatexy();
			return true;
		}
		//Ember preg updates!
		if(emberScene.emberPregUpdate()) needNext = true;
		if(flags[kFLAGS.EMBER_INCUBATION] == 1) {
			emberScene.emberGivesBirth();
			needNext = true;
		}
		//No diapause?  Normal!
		if(player.findPerk(PerkLib.Diapause) < 0) {
			if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
			if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
			//Make sure pregnancy texts aren't hidden
			if(updatePregnancy()) needNext = true;
			if(flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			//DOUBLE PREGGERS SPEED
			if(player.findPerk(PerkLib.MaraesGiftFertility) >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			//DOUBLE PREGGERS SPEED
			if(player.findPerk(PerkLib.MagicalFertility) >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			if(player.findPerk(PerkLib.FerasBoonBreedingBitch) >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(player.findPerk(PerkLib.FerasBoonWideOpen) >= 0 || player.findPerk(PerkLib.FerasBoonMilkingTwat) >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			//DOUBLE PREGGERS SPEED
			if(player.findPerk(PerkLib.BroodMother) >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
		}
		//Diapause!
		else if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228] > 0 && (player.pregnancyIncubation > 0 || player.buttPregnancyIncubation > 0)) {
			if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] == 1) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00229] = 0;
				outputText("\n\nYour body reacts to the influx of nutrition, accelerating your pregnancy. Your belly bulges outward slightly.", false);
				needNext = true;
			}
			if(flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00228]--;
			if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
			if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
			//Make sure pregnancy texts aren't hidden
			if(updatePregnancy()) needNext = true;
			if(flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
			if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
			if(updatePregnancy()) needNext = true;
			if(flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
			if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
			if(updatePregnancy()) needNext = true;
			if(flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			//DOUBLE PREGGERS SPEED
			if(player.findPerk(PerkLib.MaraesGiftFertility) >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			//DOUBLE PREGGERS SPEED
			if(player.findPerk(PerkLib.MagicalFertility) >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			if(player.findPerk(PerkLib.FerasBoonBreedingBitch) >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(player.findPerk(PerkLib.FerasBoonWideOpen) >= 0 || player.findPerk(PerkLib.FerasBoonMilkingTwat) >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			//DOUBLE PREGGERS SPEED
			if(player.findPerk(PerkLib.BroodMother) >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(flags[kFLAGS.EVENT_PARSER_ESCAPE] == 1) {
				flags[kFLAGS.EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
		}
		//MAKE SURE PREGGERS ISNT NEGATIVE
		if(player.pregnancyIncubation < 0) player.pregnancyIncubation = 0;
		if(player.buttPregnancyIncubation < 0) player.buttPregnancyIncubation = 0;
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