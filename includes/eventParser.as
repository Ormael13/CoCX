//Used to jump the fuck out of pregnancy scenarios for menus.
//const EVENT_PARSER_ESCAPE:int = 800;
//const PHYLLA_GEMS_HUNTED_TODAY:int = 893;

function eventParser(eventNo:*):void {
	//Clear banked buttons

	trace("EVENT CODE: " + eventNo);
	if (eventNo is Function)
	{
		trace("It's a function");

		eventNo();
	}
	else if (eventNo is int)
	{
		//Clear sprite if not in combat
		if(!inCombat() && eventNo != 5007) spriteSelect(-1);
		//Clear pic if not in combat
		//if(!inCombat() && eventNo != 5007) clearImages();
		//Reset newgame buttons till back at camp
		newGameText.removeEventListener(MouseEvent.CLICK, mainMenu);
		newGameBG.removeEventListener(MouseEvent.CLICK, mainMenu);
		newGameText.addEventListener(MouseEvent.CLICK, newGameGo);
		newGameBG.addEventListener(MouseEvent.CLICK, newGameGo);
		newGameText.text = "New Game";
		if(eventNo != 1) {
			hideMenus();
		}
		/*if(eventNo == 1000 && gameState == 1 && menuLoc == 1) {
			menuLoc = 0;
			outputText("\n\n", false);
			if(!combatRoundOver()) enemyAI();
			else outputText(monster.capitalA + monster.short + " is defeated!");
			return;
		}*/


		if(eventNo < 1000) doSystem(eventNo);
		if(eventNo >=1000 && eventNo < 2000) doItems(eventNo);
		if(eventNo >=2000 && eventNo < 5000) doEvent(eventNo);
		if(eventNo >=5000 && eventNo < 7000) doCombat(eventNo);
		if(eventNo >= 10000 && eventNo < 10999) doCreation(eventNo);
		if(eventNo >= 11000) doDungeon(eventNo);
	}

	else
	{
		errorPrint(eventNo);		// Dump the system state to the window so the player can file a decent bug-report
	}
}


function doSystem(eventNo:Number):void {
	//@ camp
	//(clear data/appearance buttons if not at camp
	trace("System Event", eventNo)
	if(eventNo != 1) 
	{
		hideMenus();
	}
	if(eventNo == 1) {
		nameBox.visible = false;
		if(gameState == 1) {
			menuLoc = 0;
			eventParser(5000);
			return;
		}
		//Clear restriction on item overlaps if not in combat
		plotFight =false;
		if(inDungeon) {
			menuLoc = 0;
			dungeonRoom(dungeonLoc);
			return;
		}
		menuLoc = 0;
		flags[PLAYER_PREGGO_WITH_WORMS] = 0;
		camp();
		return;
	}
	if(eventNo == 2) 
	{
		doExplore();
		return;
	}
	if(eventNo == 3) 
	{
		exploreDesert();
		return;
	}
	if(eventNo == 4) 
	{
		exploreForest();
		return;
	}
	if(eventNo == 5) 
	{
		exploreLake();
		return;
	}
	if(eventNo == 6) 
	{
		exploreMountain();
		return;
	}
	//Farm
	if(eventNo == 7) 
	{
		return;
	}
	//Jojo
	if(eventNo == 8) 
	{
		return;
	}
	//Key locations menu
	if(eventNo == 9) 
	{
		return;
	}
	//Masturbate
	if(eventNo == 10) {
		if(player.hasStatusAffect("dysfunction") >= 0) {
			outputText("You'd love to masturbate, but your sexual organs' numbness makes it impossible.  You'll have to find something to fuck to relieve your lust.", true); 
			doNext(1);
			return;
		}
		masturbateGo();
		return;
	}
	//Rest
	if(eventNo == 11) { 
		rest();
		return;
	}
	//Explore new zones
	if(eventNo == 12)
	{
		tryDiscover();	
		return;
	}
	//Pass an hour
	if(eventNo == 13) {
		outputText("An hour passes...\n", true);
		timeQ = 1;
		goNext(1, false);
		return;
	}
	if(eventNo == 14) {
		outputText("Two hours pass...\n", true);
		timeQ = 2;
		goNext(2, false);
		return;
	}
	if(eventNo == 15) {
		outputText("Four hours pass...\n", true);
		timeQ = 4;
		goNext(4, false);
		return;
	}
	if(eventNo == 16) {
		outputText("Eight hours pass...\n", true);
		timeQ = 8;
		goNext(8, false);
		return;
	}
	if(eventNo == 17) {
		outputText("", true);
		goNext(24, false);
		return;
	}
	//Load menu
	if(eventNo == 19 ) {
		loadScreen();
		return;
	}
	//Save Menu
	if(eventNo == 20) {
		saveScreen();
		return;
	}
	if(eventNo == -20)
	{
		saveGameObject(null, true);
		return;
	}
	if(eventNo == -21)
	{
		openSave();
		showStats();
		statScreenRefresh();
		return;
	}
	if(eventNo == 30) 	// I have NO idea what could call this. I don't see anything that passes 30 as an event number anywhere
	{
		var f:MouseEvent;
		saveLoad(f);
		return;
	}
	//Use wait command
	if(eventNo == 40) {
		//See camp.as
		doWait();
		return;
	}
	//Use sleep command
	if(eventNo == 41) {
		//in camp.as
		doSleep();
		return;
	}
	//Choose masturbate options
	if(eventNo == 42) {
		masturbateMenu();
		return;
	}
	//Jojo as a cumsleeve
	if(eventNo == 43) {
		corruptCampJojo();
		return;
	}
	//Gain +5 Str due to level
	if(eventNo == 44) {
		stats(5,0,0,0,0,0,0,0);
		outputText("Your muscles feel significantly stronger from your time adventuring.", true);
		doNext(116);
		return;
	}
	//Gain +5 Toughness due to level
	if(eventNo == 45) {
		stats(0,5,0,0,0,0,0,0);
		trace("HP: " + player.HP + " MAX HP: " + maxHP());
		statScreenRefresh();
		outputText("You feel tougher from all the fights you have endured.", true);
		doNext(116);
		return;
	}
	//Gain +5 Intelligence due to level
	if(eventNo == 46) {
		stats(0,0,0,5,0,0,0,0);
		outputText("Your time spent fighting the creatures of this realm has sharpened your wit.", true);
		doNext(116);
		return;
	}
	//Gain +5 speed due to level
	if(eventNo == 47) {
		stats(0,0,5,0,0,0,0,0);
		outputText("Your time in combat has driven you to move faster.", true);
		doNext(116);
		return;
	}
	//Use Onahole
	if(eventNo == 48) {
		onaholeUse();
		return;
	}
	//Use Stimbelt
	if(eventNo == 49) 
	{
		stimBeltUse();
		return;
	}
	if(eventNo == 50) {
		deluxeOnaholeUse();
		return;
	}
	if(eventNo == 51) {
		allNaturalOnaholeUse();
		return;
	}
	if(eventNo == 52) {
		allNaturalStimBeltUse();
		return;
	}
	//Strong Back Chosen (25 Str perk)
	if(eventNo == 53) {
		if(player.hasPerk("Strong Back") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Strong Back",0,0,0,0,"Enables fourth item slot.");
		outputText("You choose the 'Strong Back' perk, enabling a fourth item slot.", true);
		itemSlot4.unlocked = true;
		doNext(1);
		return;
	}
	//Perk Strong Back 2 Chosen (50 Str Perk)
	if(eventNo == 54) {
		if(player.hasPerk("Strong Back 2: Strong Harder") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Strong Back 2: Strong Harder",0,0,0,0, "Enables fifth item slot.");
		outputText("You choose the 'Strong Back 2: Strong Harder' perk, enabling a fifth item slot.", true);
		itemSlot5.unlocked = true;
		doNext(1);
		return;
	}
	//Perk Tank Chosen
	if(eventNo == 55) {
		if(player.hasPerk("Tank") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Tank",0,0,0,0,"Raises max HP by 50.");
		outputText("You choose the 'Tank' perk, giving you an additional 50 hp!", true);
		doNext(1);
		stats(0,0,0,0,0,0,0,0);
		return;
	}
	//Perk Regeneration
	if(eventNo == 56) {
		if(player.hasPerk("Regeneration") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Regeneration",0,0,0,0,"Regenerates 2 HP/hour and 1 HP/round.");
		outputText("You choose the 'Regeneration' perk, allowing you to heal 2 HP every hour and 1 HP every round of combat!", true);
		doNext(1);
		return;
	}
	//Perk Evade CHosen
	if(eventNo == 57) {
		if(player.hasPerk("Evade") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Evade",0,0,0,0,"Increases avoidance chances.");
		outputText("You choose the 'Evade' perk, allowing you to avoid enemy attacks more often!", true);
		doNext(1);
		return;
	}
	//Perk Runner Chosen
	if(eventNo == 58) {
		if(player.hasPerk("Runner") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Runner",0,0,0,0,"Increases chances of escaping combat.");
		outputText("You choose the 'Runner' perk, allowing you to run away much faster!", true);
		doNext(1);
		return;
	}		
	//Fertility Perk Chosen
	if(eventNo == 59) {
		if(player.hasPerk("Fertility+") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Fertility+",15,1.75,0,0,"Increases pregnancy chance by 15% and cum volume by up to 50%.");
		outputText("You choose the 'Fertility+' perk, making it easier to get pregnant by 15% and increase your cum volume by up to 50%(if appropriate)!", true);
		doNext(1);
	}
	//Hot Blooded Perk Chosen
	if(eventNo == 60) {
		if(player.hasPerk("Hot Blooded") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Hot Blooded",20,0,0,0, "Raises minimum lust by up to 20.");
		outputText("You choose the 'Hot Blooded' perk.  As a result of your enhanced libido, your lust no longer drops below 20!", true);
		doNext(1);
		return;
	}
	//Corrupted Libido Perk Chosen
	if(eventNo == 61) {
		if(player.hasPerk("Corrupted Libido") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Corrupted Libido",20,0,0,0, "Reduces lust gain by 10%.");
		outputText("You choose the 'Corrupted Libido' perk.  As a result of your body's corruption, you've become a bit harder to turn on. (Lust gain reduced by 10%!)", true);
		doNext(1);
		return;
	}
	//Seduction perk Chosen
	if(eventNo == 62) {
		if(player.hasPerk("Seduction") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Seduction",0,0,0,0,"Upgrades your tease attack, making it more effective.");
		outputText("You choose the 'Seduction' perk, replacing the 'tease' attack with a more powerful 'seduction' variant.", true);
		doNext(1);
		return;
	}
	//turn on/off autosave
	if(eventNo == 65) {
		var e:MouseEvent;
		if(player.autoSave) player.autoSave = false;
		else player.autoSave = true;
		saveLoad(e);
		return;
	}
	if(eventNo == 70) 
	{
		//perkPicking();
		return;
	}
	//Places menu
	if(eventNo == 71) 
	{
		places(true);
		return;
	}
	//Precision perk Chosen
	if(eventNo == 72) {
		if(player.hasPerk("Precision") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Precision",0,0,0,0,"Reduces enemy damage resistance by 10.");
		outputText("You've chosen the 'Precision' perk.  Thanks to your intelligence, you're now more adept at finding and striking an enemy's weak points, reducing their damage resistance by 10.  If your intelligence ever drops below 25 you'll no longer be smart enough to benefit from this perk.", true);
		doNext(1);
		return;
	}
	//Nymphomania Chosen
	if(eventNo == 73) {
		if(player.hasPerk("Nymphomania") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Nymphomania",0,0,0,0,"Raises minimum lust by up to 30.");
		outputText("You've chosen the 'Nymphomania' perk.  Due to the incredible amount of corruption you've been exposed to, you've begun to live in a state of minor constant arousal.  Your lust will never drop below 30.", true);
		doNext(1);
		return;
	}
	//Camp followers screen
	if(eventNo == 74) {
		doNext(1);
		campFollowers();
		return;
	}
	//Spellpower Chosen
	if(eventNo == 75) {
		if(player.hasPerk("Spellpower") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Spellpower",0,0,0,0,"Increases the effects of your spells by up to 50%.");
		outputText("You've chosen the 'Spellpower' perk.  Thanks to your sizeable intellect and willpower, you are able to more effectively use magic.", true);
		doNext(1);
		return;
	}
	//Mage Chosen
	if(eventNo == 76) {
		if(player.hasPerk("Mage") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Mage",0,0,0,0,"Increases the strength of your spells even more than 'Spellpower', up to 100%.");
		outputText("Thanks in part to your incredible willpower and intellect, you are able to focus your magical abilities even more keenly, boosting your spells effects by up to 100%.", true);
		doNext(1);
		return;
	}
	if(eventNo == 77) {
		if(player.hasPerk("Double Attack") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Double Attack",0,0,0,0,"Allows you to perform two melee attacks per round.");
		outputText("Thanks to your incredible speed, you can land two regular attacks in one round!", true);
		doNext(1);
		return;
	}
	if(eventNo == 78) {
		if(player.hasPerk("Acclimation") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Acclimation",0,0,0,0,"Reduces the rate at which your lust increases.");
		outputText("Your body is now more acclimated to its heightened lusts!", true);
		doNext(1);
	}
	if(eventNo == 79) {
		deluxeDildo();
		return;
	}
	if(eventNo == 80) {
		exploreDeepwoods();
		return;		
	}
	if(eventNo == 82) {
		deleteScreen();
		return;
	}
	if(eventNo == 94) {
		//located in exploration.as
		debugOptions();
		return;
	}
	if(eventNo == 95) {
		//located in exploration.as
		exploreHighMountain();
		return;
	}

	//located in exploration.as
	if(eventNo == 97) {
		explorePlains();
		return;
	}
	//Perk: Thunderous Strikes
	if(eventNo == 98) {
		if(player.hasPerk("Thunderous Strikes") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Thunderous Strikes",0,0,0,0,"+20% 'Attack' damage while strength is at or above 80.");
		outputText("You choose the 'Thunderous Strikes' perk, increasing normal damage by 20% while your strength is over 80.", true);
		doNext(1);
		return;
	}
	//Perk: "Weapon Mastery"
	if(eventNo == 99) {
		if(player.hasPerk("Weapon Mastery") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Weapon Mastery",0,0,0,0,"After getting so good at carrying large objects, you find large weapons much easier to handle (Double 'Large' weapon bonuses when equipped).");
		outputText("You choose the 'Weapon Mastery' perk, doubling the effectiveness of large weapons.", true);
		if(player.weaponPerk == "Large") player.weaponAttack *= 2;
		doNext(1);
		return;
	}
	//Perk: Tank 2
	if(eventNo == 100) {
		if(player.hasPerk("Tank 2") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Tank 2",0,0,0,0,"Your maximum HP is raised by an extra 1 point per point of toughness!");
		outputText("You choose the 'Tank 2' perk, granting an extra maximum HP for each point of toughness.", true);
		statScreenRefresh();
		HPChange(player.tou, false);
		doNext(1);
		return;
	}
	//Perk: Regeneration 2
	if(eventNo == 101) {
		if(player.hasPerk("Regeneration 2") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Regeneration 2",0,0,0,0,"You regenerate an additional 3HP per round and heal faster out of combat");
		outputText("You choose the 'Regeneration 2' perk, quadrupling the effectiveness of your regeneration abilities.", true);
		doNext(1);
		return;
	}
	//Speedy Recovery
	if(eventNo == 102) {
		if(player.hasPerk("Speedy Recovery") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Speedy Recovery",0,0,0,0,"Thanks to your impressive metabolism you regain fatigue 50% faster.");
		outputText("You choose the 'Speedy Recovery' perk, boosting your fatigue recovery rate!", true);
		doNext(1);
		return;
	}
	//Perk: Agility
	if(eventNo == 103) {
		if(player.hasPerk("Agility") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Agility",0,0,0,0,"When wearing light or medium armor its effectiveness is increased by a portion of your speed.");
		outputText("You choose the 'Agility' perk, increasing the effectiveness of Light/Medium armors by a portion of your speed.", true);
		if(player.armorPerk == "Light") player.armorDef += Math.round(player.spe/10);
		else if(player.armorPerk == "Medium") player.armorDef += Math.round(player.spe/15);
		doNext(1);
		return;
	}
	//Channeling
	if(eventNo == 104) {
		if(player.hasPerk("Channeling") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Channeling",0,0,0,0,"You've gotten even better at spellcasting, gaining up to 50% more effectiveness!");
		outputText("You choose the 'Channeling' perk, boosting the strength of your spellcasting!", true);
		doNext(1);
		return;
	}
	//Medicine
	if(eventNo == 105) {
		if(player.hasPerk("Medicine") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Medicine",0,0,0,0,"You now have a 15% chance per round of cleansing poisons/drugs from your body.");
		outputText("You choose the 'Medicine' perk, giving you a chance to remove debilitating poisons automatically!", true);
		doNext(1);
		return;
	}
	//Well Adjusted
	if(eventNo == 106) {
		if(player.hasPerk("Well Adjusted") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Well Adjusted",0,0,0,0,"You gain half as much lust as time passes in Mareth.");
		outputText("You choose the 'Well Adjusted' perk, reducing the amount of lust you naturally gain over time while in this strange land!", true);
		doNext(1);
		return;
	}
	//Masochism
	if(eventNo == 107) {
		if(player.hasPerk("Masochist") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Masochist",0,0,0,0,"You have a masochism fetish and take 30 percent less damage, but you're lust goes up when struck (Requires 60+ Libido).");
		outputText("You choose the 'Masochist' perk, reducing the damage you take but raising your lust each time!  This perk only functions while your libido is at or above 60!", true);
		doNext(1);
		return;
	}
	//Sadism
	if(eventNo == 108) {
		if(player.hasPerk("Sadist") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Sadist",0,0,0,0,"You have a sadism fetish and strike harder, but become aroused by the act of dealing damage.");
		outputText("You choose the 'Sadist' perk, increasing damage by 20 percent but causing you to gain lust from dealing damage.", true);
		doNext(1);
		return;
	}
	//Arousing Aura
	if(eventNo == 109) {
		if(player.hasPerk("Arousing Aura") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Arousing Aura",0,0,0,0,"While your corruption is at or above 70, you exude an aura of lust.");
		outputText("You choose the 'Arousing Aura' perk, causing you to radiate an aura of lust when your corruption is over 70.", true);
		doNext(1);
		return;
	}
	//Resistance
	if(eventNo == 110) {
		if(player.hasPerk("Resistance") >= 0) {
			outputText("You already have that perk!", true);
			doNext(70);
			return;
		}
		player.createPerk("Resistance",0,0,0,0,"You've become resistant to the myriad ways your lust can be increased.");
		outputText("You choose the 'Resistance' perk, reducing the rate at which your lust increases by 10%.", true);
		doNext(1);
		return;
	}
	if(eventNo == 111) {
		exploreSwamp();
		return;
	}
	if(eventNo == 114) {
		aCb.visible = false;
		applyPerk(tempPerk);
		return;
	}
	if(eventNo == 115) {
		aCb.visible = false;
		eventParser(1);
		return;
	}
	if(eventNo == 116) {
		perkBuyMenu();
		return;
	}
	if(eventNo == 118) {
		if(!monster.hasVagina()) monster.createVagina();
		monster.vaginas[0].vaginalLooseness = 3;
		monster.ass.analLooseness = 3;
		outputText(eventTestInput.text, true, true);
		simpleChoices("Again",117,"",0,"",0,"",0,"Quit",mainMenu);
		eventTestInput.x = -10207.5;
		eventTestInput.y = -1055.1;
		return;
	}
	if(eventNo == 119) {
		eventTestInput.x = -10207.5;
		eventTestInput.y = -1055.1;
		eventParser(mainMenu);
		return;
	}

	errorPrint(eventNo);		// Dump the system state to the window so the player can file a decent bug-report
}
function getCurrentStackTrace():String		// Fuck, stack-traces only work in the debug player.
{
	var tempError:Error = new Error();
	var stackTrace:String = tempError.getStackTrace();
	return stackTrace;
}
function errorPrint(details:* = null)
{
	outputText("<b>Congratulations, you've found a bug!</b>", true);
	outputText("\nError: Unknown event!", false);
	outputText("\n\nPlease report that you had an issue with code: \"" + details + "\" ", false);

	var sTrace = getCurrentStackTrace();

	if (sTrace)	// Fuck, stack-traces only work in the debug player.
		outputText("and stack-trace: \n <pre>" + sTrace + "</pre>\n", false); 	
	outputText("to fake-name on the forums or better yet, file a bug report on github: ", false);
	outputText("\nhttps://github.com/herp-a-derp/Corruption-of-Champions", false);

	outputText("\nPlease try to include the details of what you were doing when you encountered this bug ", false);
	if (sTrace)
		outputText(" (including the above stack trace copy&pasted into the details),", false);
	outputText(" to make tracking the issue down easier. Thanks!", false);

	doNext(13);
}



//Argument is time passed.  Pass to event parser if nothing happens.
function goNext(time:Number, defNext:Boolean):Boolean  {
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
		hours++;
		if(player.cumMultiplier > 19999) player.cumMultiplier = 19999;
		if(player.ballSize > 400) player.ballSize = 400;
		if(player.hasPerk("Strong Back") >= 0 && !itemSlot4.unlocked) {
			itemSlot4.unlocked = true;
		}
		if(player.hasPerk("Strong Back 2: Strong Harder") >= 0 && !itemSlot5.unlocked) {
			itemSlot5.unlocked = true;
		}
		if(flags[SOCK_COUNTER] > 0) {
			flags[SOCK_COUNTER]--;
			if(flags[SOCK_COUNTER] < 0) flags[SOCK_COUNTER] = 0;
			if(flags[SOCK_COUNTER] > 24) flags[SOCK_COUNTER] = 24;
		}
		if(flags[PHYLLA_EGG_LAYING] > 0 && rand(5) == 0 && flags[ANT_KIDS] < 5000) flags[ANT_KIDS]++;
		if(flags[PHYLLA_DRIDER_INCUBATION] > 1) {
			flags[PHYLLA_DRIDER_INCUBATION]--;
			if(flags[PHYLLA_DRIDER_INCUBATION] < 1) flags[PHYLLA_DRIDER_INCUBATION] = 1;
		}
		if(flags[HEL_PREGNANCY_INCUBATION] > 0) {
			flags[HEL_PREGNANCY_INCUBATION]--;
			if(flags[HEL_PREGNANCY_INCUBATION] == 0) flags[HEL_PREGNANCY_INCUBATION] = 1;
		}
		if(izmaFollower() && flags[IZMA_NO_COCK] == 0 && flags[TIMES_IZMA_DOMMED_LATEXY] > 0 && latexGooFollower() && flags[IZMA_X_LATEXY_DISABLED] == 0) flags[GOO_FLUID_AMOUNT] = 100;
		genderCheck();
		player.weaponAttack = fixedDamage(player.weaponName);
		applyArmorStats(player.armorName,false);
		if(player.hasStatusAffect("noJojo") >= 0) player.removeStatusAffect("noJojo");
		
		regeneration(false);
		
		player.hoursSinceCum++;
		//Super cumbuilding activate!
		if(player.hasPerk("Marae's Gift - Profractory") >= 0) player.hoursSinceCum += 2;
		if(player.hasPerk("Fera's Boon - Alpha") >= 0) player.hoursSinceCum += 2;
		timeQ--;
		//Normal
		if(flags[ARIAN_EGG_COUNTER] > 0) flags[ARIAN_EGG_COUNTER]++;
		if(player.hasPerk("Well Adjusted") < 0) {
			//Raise lust
			stats(0,0,0,0,0,0,player.lib * 0.04,0, false);
			//Double lust rise if lusty.
			if(player.hasPerk("Lusty") >= 0) stats(0,0,0,0,0,0,player.lib * 0.02,0, false);
		}
		//Well adjusted perk
		else {
			//Raise lust
			stats(0,0,0,0,0,0,player.lib * 0.02,0);
			//Double lust rise if lusty.
			if(player.hasPerk("Lusty") >= 0) stats(0,0,0,0,0,0,player.lib * 0.01,0, false);
		}
		//Rathazul crafting countdown
		if(flags[UNKNOWN_FLAG_NUMBER_00274] > 1) {
			flags[UNKNOWN_FLAG_NUMBER_00274]--;
			if(flags[UNKNOWN_FLAG_NUMBER_00274] < 1) flags[UNKNOWN_FLAG_NUMBER_00274] = 1;
			if(flags[UNKNOWN_FLAG_NUMBER_00274] > 300) flags[UNKNOWN_FLAG_NUMBER_00274] = 24;
		}
		//Urta Letters
		if(flags[NEED_URTA_LETTER] == 1 && hours == 6) getUrtaLetter();
		//Urta Pregs
		if(flags[URTA_INCUBATION] > 0) flags[URTA_INCUBATION]++;
		if(flags[KELLY_INCUBATION] > 0) {
			flags[KELLY_INCUBATION]--;
			if(flags[KELLY_INCUBATION] < 1) {
				flags[KELLY_INCUBATION] = 0;
				kellyPopsOutARunt();
				needNext = true;
			}
		}
		//Ember fuck cooldown
		if(player.statusAffectv1("ember fuck cooldown") > 0) {
			player.addStatusValue("ember fuck cooldown",1,-1);
			if(player.statusAffectv1("ember fuck cooldown") < 1) player.removeStatusAffect("ember fuck cooldown");
		}
		//Ember napping
		if(player.hasStatusAffect("Ember Napping") >= 0) {
			player.addStatusValue("Ember Napping",1,-1);
			if(player.statusAffectv1("Ember Napping") <= 0) player.removeStatusAffect("Ember Napping");
		}
		if(flags[UNKNOWN_FLAG_NUMBER_00283] == 0 && sophieFollower() && flags[SOPHIES_DAUGHTERS_DEBIMBOED] == 1) {
			sophieDaughterDebimboUpdate();
			needNext = true;
		}
		if(bimboSophie() || sophieFollower()) {
			if(flags[SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) {
				flags[SOPHIE_DAUGHTER_MATURITY_COUNTER]--;
				if(flags[SOPHIE_DAUGHTER_MATURITY_COUNTER] < 1) flags[SOPHIE_DAUGHTER_MATURITY_COUNTER] = 1;
				if(flags[SOPHIE_DAUGHTER_MATURITY_COUNTER] == 325) {
					outputText("\nYour cute little harpy is still just a little chick.  Her body is small and childlike, and her feathers are fluffy and poofy, making your little girl look like she has puffballs for arms and legs.  Already looking to be four or five years old, the baby harpy is just as energetic as a human child of that age.  She flutters around and scrambles from one thing to another. Thankfully, the rambunctious little darling runs out of explosive energy quickly, suddenly falling to the ground into a fluffy heap for a quick nap.\n");
					needNext = true;
				}
				if(flags[SOPHIE_DAUGHTER_MATURITY_COUNTER] == 200) {
					outputText("\nYour sweet little harpy is starting to grow up!  Her body is much bigger than it was before, though her baby fat has spread out over her larger form and looks more lean and lanky then the big-butted harpies you're used to seeing.  Her feathers have even started to smooth out, though she is still quite the fluffball.  You're sure that it won't be too long before the curves harpies are known for start to appear.  The energy she exuded as a little chick still drives her to 'terrorize' your camp, scampering around, fluttering from place to place and getting into all kinds of things.  Your fluffy daughter seems to be able to stay active for longer than before, though you still see her curl up for a nap every so often.\n");
					needNext = true;
				}
				if(flags[SOPHIE_DAUGHTER_MATURITY_COUNTER] == 100) {
					outputText("\nLooking around for your developing daughter, you find that she and your ");
					if(bimboSophie()) outputText("boisterous bimbo ");
					else outputText("mature harpy ");
					outputText("are spending some quality mother-daughter time together.  Sophie is helping the young girl with her make up, showing her how to use that golden luststick that her people are so fond of.  You're not too sure how appropriate that is for your daughter, but then again, this is what harpies do right?  Aside from the lusty lipstick, your live-in");
					if(bimboSophie()) outputText(" bimbo ");
					else outputText(", avian girlfriend ");
					outputText("moves on to her hair and nails, all the while gabbing on and on about you, and about all the daughters she plans to have.");
					outputText("\n\nYour daughter is growing up so fast!  Already, her body is developing, breasts budding into supple bumps on her chest.  Her hips are starting to swell into the trademark birthing hips and round grabbable ass harpies are famous for.\n");
					needNext = true;
				}
			}
			if(flags[SOPHIE_EGG_COUNTER] > 0) {
				flags[SOPHIE_EGG_COUNTER]--;
				if(flags[SOPHIE_EGG_COUNTER] <= 0) {
					sophiesEggHatches();
					needNext = true;
				}
			}
			//PREGNANCY COUNTAN
			if(flags[SOPHIE_INCUBATION] > 0) {
				flags[SOPHIE_INCUBATION]--;
				//Sophie Pregnancy Stage Alerts
				//Small Bump*
				if(flags[SOPHIE_INCUBATION] == 150) {
					if(bimboSophie()) {
						outputText("\nSophie sits by herself on your comfy bedroll.  The feathery female seems to have taken a liking to your place of rest.  Your bird-brained love-slave clearly desires to be as close to you, or at least your fatherly scent, as much as possible.  Lost in her lusty fantasies, she caresses the gentle bump in her belly, the telltale sign that your virile seed has worked its magic on her egg-bearing womb.  One of her hands idly slips between her legs, fingers gently playing with her wet snatch as her other rubs her tummy.");
						outputText("\n\nFinally noticing your gaze on her body, Sophie looks up at you with an amorous smile, her thick, fertile thighs spreading and showing off her tight puffy pussy to you.  The blond bimbo puts her pregnant body on display for you, to show you the result of your virility and to entice you into playing with her hot, lusty form.\n");
					}
					else {
						outputText("\nSophie sits by herself on your comfy bedroll.  The feathery female seems to have taken a liking to your place of rest.  Your well-endowed monster-girl lover clearly desires to be as close to you, or at least your fatherly scent, as much as possible.  Lost in her lusty fantasies, she caresses the gentle bump in her belly, the telltale sign that your virile seed has worked its magic on her egg-bearing womb.  One of her hands idly slips between her legs, fingers gently playing with her wet snatch as her other rubs her tummy.");
						outputText("\n\nFinally noticing your gaze on her body, Sophie looks up at you with an amorous smile, her thick, fertile thighs spreading and showing off her tight puffy pussy to you.  The matron puts her pregnant body on display for you, to show you the result of your virility and to entice you into playing with her hot, lusty form.\n");
					}
					needNext = true;
					stats(0,0,0,0,0,0,3,0);
				}
				//Medium Bump*
				else if(flags[SOPHIE_INCUBATION] == 120) {
					if(bimboSophie()) {
						outputText("\nAs usual, Sophie is laying on your bedroll.  Each day the fertile swell in her stomach seems to grow bigger with the egg inside.  The positively pregnant woman idly strokes her egg-bearing belly with motherly affection.  She even coos to the growing bump as she caresses her body, clearly loving the fact that she is pregnant with another egg.  It's not long before she catches sight of you; a big silly smile breaking across her puffy lips as she hurriedly gets up from your blankets and bounds over to you.  With each step, her voluptuous body jiggles, and bounces, her big bountiful bosom heaving and shaking, her ripe round rump quivering like jelly as she sways her fecund hips for you.");
						outputText("\n\n\"<i>There you are [name]!  Like, look at me!  Your egg is getting <b>soooo</b> big inside me!  Like, just look at how big and sexy I am!</i>\"  the bimbo brained woman tweets as she presses her curvaceous body against you, making sure you can feel her big soft tits and growing baby bump.  From how her body feels, you're sure her already bountiful bimbo-like breasts have only gotten bigger thanks to her pregnancy.  \"<i>Thanks for getting me all pregnant and stuff!</i>\"\n");
					}
					else {
						outputText("\nAs usual, Sophie is laying on your bedroll.  Each day the fertile swell in her stomach seems to grow bigger with the egg inside.  The positively pregnant woman idly strokes her egg-bearing belly with motherly affection.  She even coos to the growing bump as she caresses her body, clearly loving the fact that she is pregnant with another egg.  It's not long before she catches sight of you; a big silly smile breaking across her lips as she hurriedly gets up from your blankets and bounds over to you.  With each step, her voluptuous body jiggles, and bounces, her big bountiful bosom heaving and shaking, her ripe round rump quivering like jelly as she sways her fecund hips for you.");
						outputText("\n\n\"<i>Hey there [name].  Look at me!  That egg has gotten so big inside me.  You have no idea how good this feels,</i>\" the confident woman tweets as she presses her curvaceous body against you, making sure you can feel her big soft tits and growing baby bump.  From how her body feels, you're sure her already bountiful breasts have only gotten bigger thanks to her pregnancy.  \"<i>Maybe in a month or so, I'll let you do it all over again...</i>\"\n");
					}
					stats(0,0,0,0,0,0,5,0);
					needNext = true;
				}
				//Big Belly Bump*
				else if(flags[SOPHIE_INCUBATION] == 100) {
					if(bimboSophie()) {
						outputText("\nOnce again, your pregnant bimbo lounges on your bedroll, her face buried in your pillow and taking deep breaths of your scent.  Even with her in such a - vulnerable... position, face down and ass up, you can clearly see the big, round bulge of her egg-laden belly.  With your feathery slut so gravid, you're sure it won't be long until she lays that womb-straining egg.  As if sensing your gaze, Sophie starts to sway her round spankable ass, her legs seeming to spread a little wider as well.  Your suspicions prove correct when she looks back at you; her plump bimbo lips blowing you a kiss as she looks at you with lusty eyes.");
						outputText("\n\nThe amorous harpy practically leaps out of your bed, her voluptuous body bouncing with each step as she bounds over to you.  Despite her heavily pregnant state, Sophie seems to carry herself well, the milfy harpy well adapted at being heavy with egg.  Taking advantage of your momentary distraction, the excited, happy bimbo flounces at you, tackling you and cuddling you happily.  She presses her egg-heavy belly and massive, perky tits against you and says, \"<i>Ohhh!  It's gonna be soon, momma Sophie's gonna like, lay this nice big egg for you, babe!</i>\"  Leaning in, she plants a big wet kiss on your cheek before sliding her hands down to her round bulging belly.  \"<i>It's going to be a really big egg too!  Don't worry, I'm good at laying eggs, and my pussy's going to stay niiice and tight for you, babe!</i>\"\n");
					}
					else {
						outputText("\nOnce again, your pregnant harpy lounges on your bedroll, her face buried in your pillow and taking deep breaths of your scent.  Even with her in such a - vulnerable... position, face down and ass up, you can clearly see the big, round bulge of her egg-laden belly.  With the feathery slut so gravid, you're sure it won't be long until she lays that womb-straining egg.  As if sensing your gaze, Sophie starts to sway her round spankable ass, her legs seeming to spread a little wider as well.  Your suspicions prove correct when she looks back at you; her pursed lips blowing you a kiss as she looks at you with lusty eyes.");
						outputText("\n\nThe amorous harpy practically leaps out of your bed, her voluptuous body bouncing with each step as she bounds over to you.  Despite her heavily pregnant state, Sophie seems to carry herself well, the milfy harpy well adapted at being heavy with egg.  Taking advantage of your momentary distraction, she flounces at you, tackling you and cuddling you happily.  She presses her egg-heavy belly and massive, perky tits against you and says, \"<i>It's gonna be time soon...  Before you know it, I'll be popping out this big, swollen egg, and you'll be right there to see it!</i>\"  Leaning in, she plants a big wet kiss on your cheek before sliding her hands down to her round bulging belly.  \"<i>It's going to be a really big egg too!  Don't worry, I'm good at laying eggs, and my pussy is going to be ready for you as soon as it comes out!</i>\"\n");
					}
					stats(0,0,0,0,0,0,5,0);
					needNext = true;
				}
				else if(flags[SOPHIE_INCUBATION] == 0) {
					sophieBirthsEgg();
					needNext = true;
				}
			}
			//Tick over into heat if appropriate
			if(flags[SOPHIE_HEAT_COUNTER] <= 0) {
				//Not pregnant and PC has dick? INTO SEASON HOOOO
				if(player.hasCock() && flags[SOPHIE_INCUBATION] <= 0) {
					if(bimboSophie()) sophieGoesIntoSeason();
					else sophieFollowerGoesIntoSeas();
					needNext = true;
					flags[SOPHIE_HEAT_COUNTER] = 720;
				}
				//No dick or pregnant? WAIT.
				else {
					flags[SOPHIE_HEAT_COUNTER] = 0;
				}
			}
			//COUNT DOWN TOWARDS 0.
			else {
				flags[SOPHIE_HEAT_COUNTER]--;
				//Expire heat if impregged
				if(flags[SOPHIE_INCUBATION] > 0 && flags[SOPHIE_HEAT_COUNTER] >= 552) {
					if(bimboSophie()) sophieGotKnockedUp();
					else sophieFertilityKnockedUpExpired()
					flags[SOPHIE_HEAT_COUNTER] = 551;
					needNext = true;
				}
				//Expire heat if counted down to
				else if(flags[SOPHIE_HEAT_COUNTER] == 552) {
					if(bimboSophie()) sophieSeasonExpiration();
					else sophieFertilityExpired();
					needNext = true;
				}
			}
			//IIF PREGNANT, KEEP HEAT COUNTER AT 551
			if(flags[SOPHIE_INCUBATION] > 0)
				flags[SOPHIE_HEAT_COUNTER] = 551;
		}
		if(flags[ANEMONE_KID] > 0) {
			if(flags[KID_SITTER] == 0 && flags[MARBLE_KIDS] >= 5 && hours > 10 && hours < 18 && rand(4) == 0) {
				kidABabysitsCows();
				needNext = true;
			}
			if(flags[KID_SITTER] == 1 && hours > 10 && hours < 18 && rand(4) == 0) {
				flags[KID_SITTER] = 2;
			}
			else if(flags[KID_SITTER] == 2) flags[KID_SITTER] = 1;
		}
		if(flags[SHOULDRA_MAGIC_COOLDOWN] >= 1) flags[SHOULDRA_MAGIC_COOLDOWN]--;
		if(followerShouldra() && player.statusAffectv1("Exgartuan") == 1 && player.hasCock() && rand(10) == 0) {
			if(flags[SHOULDRA_EXGARTUDRAMA] == 1) {
				needNext = true;
				exgartumonAndShouldraFightPartII();
			}
			else if(flags[SHOULDRA_EXGARTUDRAMA] == 2) {
				exgartumonAndShouldraFightPartIII();
				needNext = true;
			}
		}
		//Amily lays eggs that were oviposited.
		if(flags[AMILY_OVIPOSITED_COUNTDOWN] > 0) {
			flags[AMILY_OVIPOSITED_COUNTDOWN]--;
			if(flags[AMILY_OVIPOSITED_COUNTDOWN] <= 0) {
				amilyLaysEggsLikeABitch();
				needNext = true;
			}
		}
		if(flags[GATS_ANGEL_TIME_TO_FIND_KEY] > 0) {
			if(flags[GATS_ANGEL_TIME_TO_FIND_KEY] < 500) flags[GATS_ANGEL_TIME_TO_FIND_KEY]++;
		}
		//Vapula gives a dildo
		if(vapulaSlave() && player.hasKeyItem("Demonic Strap-On") < 0 && player.gender == 2) {
			vapulaGivesPCAPresent();
			needNext = true;
		}
		//Niamh counters
		if(flags[NIAMH_SEAN_BREW_BIMBO_LIQUEUR_COUNTER] > 1) flags[NIAMH_SEAN_BREW_BIMBO_LIQUEUR_COUNTER]--;
		if(flags[NIAMH_MOVED_OUT_COUNTER] > 1) flags[NIAMH_MOVED_OUT_COUNTER]--;
		if(player.hasStatusAffect("Bimbo Champagne") >= 0) {
			player.addStatusValue("Bimbo Champagne",1,-1);
			if(player.statusAffectv1("Bimbo Champagne") <= 0) {
				removeBimboChampagne();
				needNext = true;
			}
		}
		if(flags[FOX_BAD_END_WARNING] == 1) {
			if(player.faceType != 11 || player.tailType != 13 || player.earType != 9 || player.lowerBody != 17 || player.skinType != 1) {
				flags[FOX_BAD_END_WARNING] = 0;
			}
		}
		flags[SALON_PAID] = 0;
		//Izzy milk countdown
		if(flags[ISABELLA_MILK_COOLDOWN] > 0) {
			flags[ISABELLA_MILK_COOLDOWN]--;
			if(flags[ISABELLA_MILK_COOLDOWN] < 0) flags[ISABELLA_MILK_COOLDOWN] = 0;
		}
		//Isabella accent coaching countdown
		if(flags[ISABELLA_ACCENT_TRAINING_COOLDOWN] > 1) {
			flags[ISABELLA_ACCENT_TRAINING_COOLDOWN]--;
		}
		if(flags[ANEMONE_KID] > 0) {
			if(flags[KID_ITEM_FIND_HOURS] < 20) flags[KID_ITEM_FIND_HOURS]++;
		}
		//Wet pussy check!
		if(player.hasPerk("Wet Pussy") >= 0 && player.vaginas.length > 0) {
			if(player.vaginas[0].vaginalWetness < 2) {
				outputText("\n<b>Your " + vaginaDescript(0) + " returns to its normal, wet state.</b>\n", false);
				needNext = true;
				player.vaginas[0].vaginalWetness = 2;
			}
		}
		//Fixing Egg Preg Preglocked Glitch
		if(player.pregnancyIncubation <= 0 && player.pregnancyType == 5) {
			player.pregnancyType = 0;
			player.pregnancyIncubation = 0;
		}
		if(player.hasStatusAffect("Uniball") >= 0 && player.ballSize > 1 && player.balls > 0) {
			//Testicles Normalise: 
			outputText("\nYou feel a deep sensation of release around your genitals.  You sigh with relief and contentment as your testicles drop downwards and bloom outwards, heat throbbing within them as they split and form a proper ballsack.\n");
			player.removeStatusAffect("Uniball");
			needNext = true;
		}		
		//Make eggs big if harpied!
		if(player.lowerBody == 13 && player.tailType == 11 && player.hasPerk("Harpy Womb") >= 0 && player.hasStatusAffect("eggs") >= 0) {
			if(player.statusAffectv2("eggs") == 0) {
				player.changeStatusValue("eggs",2,1);
				outputText("\n<b>A familiar, motherly rumble lets you know that your harpy-like womb is growing your eggs nice and large.</b>\n", false);
				needNext = true;
			}
		}
		//Jojo milking cooldown
		if(flags[UNKNOWN_FLAG_NUMBER_00332] > 0) {
			flags[UNKNOWN_FLAG_NUMBER_00332]--;
		}
		//Spider-preg stuff
		if(flags[UNKNOWN_FLAG_NUMBER_00271] > 0) {
			flags[UNKNOWN_FLAG_NUMBER_00271]--;
			if(flags[UNKNOWN_FLAG_NUMBER_00271] < 0) flags[UNKNOWN_FLAG_NUMBER_00271] = 0;
			if(flags[UNKNOWN_FLAG_NUMBER_00271] > 300) flags[UNKNOWN_FLAG_NUMBER_00271] = 0;
		}
		//Increase Roxanne's growing dick size...
		flags[UNKNOWN_FLAG_NUMBER_00225]++;
		//Reset if she finds someone to take it (random at high values)
		if(flags[UNKNOWN_FLAG_NUMBER_00225] >= 300 && hours == 1 && rand(5) == 0) flags[UNKNOWN_FLAG_NUMBER_00225] = 1;
		//hangover status stuff
		if(player.hasStatusAffect("Hangover") >= 0) {
			//Countdown
			if(player.statusAffectv1("Hangover") > 0) player.addStatusValue("Hangover",1,-1);
			else {
				outputText("\n<b>Your head finally clears as your hangover wears off.  Drinking with the shemale lizard was definitely a bad idea.</b>\n", false);
				//Restore stats
				player.str += player.statusAffectv2("Hangover");
				player.spe += player.statusAffectv3("Hangover");
				player.inte += player.statusAffectv4("Hangover");
				stats(0,0,0,0,0,0,0,0);
				//Clear status
				player.removeStatusAffect("Hangover");
				needNext = true;
			}
		}
		if(player.statusAffectv1("Black Cat Beer") > 0) {
			player.addStatusValue("Black Cat Beer",1,-1);
			if(player.statusAffectv1("Black Cat Beer") <= 0) {
				blackCatBeerExpires();
				needNext = true;
			}
		}
		//EMBER STUFF
		if(followerEmber() && player.hasStatusAffect("Ember Napping") < 0) {
			//Mino cum freakout - PC partly addicted!
			if(flags[MINOTAUR_CUM_ADDICTION_STATE] == 1 && player.hasPerk("Minotaur Cum Addict") < 0 && flags[EMBER_CURRENTLY_FREAKING_ABOUT_MINOCUM] == 0) {
				minotaurJizzFreakout();
				needNext = true;
			}
			//Ember is freaking out about addiction, but PC no longer addicted!
			else if(flags[MINOTAUR_CUM_ADDICTION_STATE] == 0 && flags[EMBER_CURRENTLY_FREAKING_ABOUT_MINOCUM] == 1) {
				emberGetOverFreakingOutAboutMinoJizz();
				needNext = true;
			}
			//At max lust, count up - if ten hours lusty, ember yells at ya!
			if(player.lust >= 100 && player.gender > 0) {
				flags[EMBER_LUST_BITCHING_COUNTER]++;
				if (flags[EMBER_LUST_BITCHING_COUNTER] >= 10) {
					emberBitchesAtYouAboutLustiness();
					needNext = true;
				}
			}
			//Reset lust counter if not max lust'ed
			else flags[EMBER_LUST_BITCHING_COUNTER] = 0;
			
		}
		cottonPregUpdates();
		//Fix femininity ratings if out of whack!
		if(player.hasPerk("Androgyny") < 0) 
			textHolder = player.fixFemininity();
		if(textHolder != "") {
			outputText(textHolder, false);
			needNext = true;
		}
		//BOOKURYUUUU COUNTAH For IZMA
		if(flags[UNKNOWN_FLAG_NUMBER_00253] > 0) {
			flags[UNKNOWN_FLAG_NUMBER_00253]--;
			if(flags[UNKNOWN_FLAG_NUMBER_00253] < 0) flags[UNKNOWN_FLAG_NUMBER_00253] = 0;
		}
		//Minotaur son tracker
		//326 Number of sons grown
		//327 Number of sons pending
		//328 growup countdown
		//If it gets glitched somehow
		if(flags[UNKNOWN_FLAG_NUMBER_00328] > 30) flags[UNKNOWN_FLAG_NUMBER_00328] = 30;
		if(flags[UNKNOWN_FLAG_NUMBER_00328] < 0) flags[UNKNOWN_FLAG_NUMBER_00328] = 0;
		//Countdown for son growing up
		if(flags[UNKNOWN_FLAG_NUMBER_00328] > 0) {
			flags[UNKNOWN_FLAG_NUMBER_00328]--;
			//Hit zero, move kid to grown up pile!
			if(flags[UNKNOWN_FLAG_NUMBER_00328] <= 0 && flags[UNKNOWN_FLAG_NUMBER_00327] > 0) {
				flags[UNKNOWN_FLAG_NUMBER_00327]--;
				flags[UNKNOWN_FLAG_NUMBER_00326]++;
			}
		}
		//NEXT KID!
		if(flags[UNKNOWN_FLAG_NUMBER_00327] > 0 && flags[UNKNOWN_FLAG_NUMBER_00328] == 0) {
			trace("MINO KID GROWN");
			flags[UNKNOWN_FLAG_NUMBER_00328] = 30;
		}
		if(followerShouldra()) {
			flags[SHOULDRA_SLEEP_TIMER]--;
			if(shouldersWarnings()) needNext = true;
			if(flags[SHOULDRA_SLEEP_TIMER] == 0 || (flags[SHOULDRA_SLEEP_TIMER] < 0 && flags[SHOULDRA_SLEEP_TIMER] % 16 == 0)) {
				shouldraWakesUpOrPokesPCsForShitsAndGigglesIdunnoHowLongCanIMakeThisFunctionNameQuestionMark();
				needNext = true;
			}
			   
		}
		//Lust stick!
		if(player.hasStatusAffect("Lust Stick Applied") >= 0) {
			//Decrement!
			player.addStatusValue("Lust Stick Applied",1,-1);
			if(player.statusAffectv1("Lust Stick Applied") <= 0) {
				player.removeStatusAffect("Lust Stick Applied");
				outputText("<b>\nYour drugged lipstick fades away, leaving only the faintest residue on your lips.  You'll have to put on more if you want to be able to kiss your foes into submission!</b>\n", false);
			}
		}
		if(flags[JOJO_EGGCUBATE_COUNT] > 0) {
			flags[JOJO_EGGCUBATE_COUNT]--;
			if(flags[JOJO_EGGCUBATE_COUNT] == 1) {
				jojoLaysEggs();
				needNext = true;
			}
		}
		if(flags[DICK_EGG_INCUBATION] > 0) {
			flags[DICK_EGG_INCUBATION]--;
			trace("DICK BIRTH TIMER: " + flags[DICK_EGG_INCUBATION]);
			if(flags[DICK_EGG_INCUBATION] == 1) {
				birthBeeEggsOutYourWang();
				needNext = true;
			}
		}
		//Izma Pregger counter
		if(flags[UNKNOWN_FLAG_NUMBER_00250] > 1) {
			flags[UNKNOWN_FLAG_NUMBER_00250]--;
			//Fix out of bounds
			if(flags[UNKNOWN_FLAG_NUMBER_00250] < 1) flags[UNKNOWN_FLAG_NUMBER_00250] = 1;
			if(flags[UNKNOWN_FLAG_NUMBER_00250] > 300) flags[UNKNOWN_FLAG_NUMBER_00250] = 300;
		}
		//Vala post-rape countdown
		if(flags[UNKNOWN_FLAG_NUMBER_00125] > 0) {
			flags[UNKNOWN_FLAG_NUMBER_00125]--;
			if(flags[UNKNOWN_FLAG_NUMBER_00125] < 0) flags[UNKNOWN_FLAG_NUMBER_00125] = 0;
		}	
		//Sophie PO'ed countdown
		if(flags[UNKNOWN_FLAG_NUMBER_00096] > 0) {
			flags[UNKNOWN_FLAG_NUMBER_00096]--;
			if(flags[UNKNOWN_FLAG_NUMBER_00096] < 0) flags[UNKNOWN_FLAG_NUMBER_00096] = 0;
		}
		//PO countdown
		if(flags[UNKNOWN_FLAG_NUMBER_00260] > 0) {
			flags[UNKNOWN_FLAG_NUMBER_00260]--;
			if(flags[UNKNOWN_FLAG_NUMBER_00260] > 300) flags[UNKNOWN_FLAG_NUMBER_00260] = 300;
			if(flags[UNKNOWN_FLAG_NUMBER_00260] < 0) flags[UNKNOWN_FLAG_NUMBER_00260] = 0;
		}			
		//Lusty Tongue Check!
		if(player.hasStatusAffect("LustyTongue") >= 0) {
			if(rand(5) == 0) {
				outputText("\nYou keep licking your lips, blushing with the sexual pleasure it brings you.", false);
				stats(0,0,0,0,0,0,2+rand(15),0);
				if(player.lust >= 100) {
					outputText("  Your knees lock from the pleasure, and you fall back in pleasure, twisting and moaning like a whore as you somehow orgasm from your mouth.  When it finishes, you realize your mouth feels even more sensitive than before.", false);
					stats(0,0,0,0,0,2,-100,0);
					//Tongue orgasming makes it last longer.
					player.changeStatusValue("LustyTongue",1,player.statusAffectv1("LustyTongue")+10);
					
				}
				needNext = true;
				outputText("\n", false);			
			}
			//Decrement
			player.changeStatusValue("LustyTongue",1,player.statusAffectv1("LustyTongue")-1);
			if(player.statusAffectv1("LustyTongue") <= 0) {
				player.removeStatusAffect("LustyTongue");
				needNext = true;
				outputText("\nYour mouth and tongue return to normal.\n", false);
			}
		}
		//Egg laying countdown for Sophie
		if(flags[UNKNOWN_FLAG_NUMBER_00093] > 0) {
			flags[UNKNOWN_FLAG_NUMBER_00093]--;
			if(flags[UNKNOWN_FLAG_NUMBER_00093] < 0) flags[UNKNOWN_FLAG_NUMBER_00093] = 0;
			//Lay an egg
			if(flags[UNKNOWN_FLAG_NUMBER_00093] == 0) flags[UNKNOWN_FLAG_NUMBER_00094]++;
		}
		//Luststic countdown
		if(player.hasStatusAffect("Luststick") >= 0) {
			player.addStatusValue("Luststick",1,-1);
			//50% chance to lust spike
			if(rand(2) == 0 && player.hasCock()) {
				//Display if havent displayed
				if(flags[UNKNOWN_FLAG_NUMBER_00095] == 0) {
					outputText("\nYour body tingles, practically a slave to the effects of harpy lipstick.  Blood surges to " + sMultiCockDesc() + ", making you groan out loud with forced pleasure.  Unasked-for fantasies assault you, and you spend a few moments fantasizing about fucking feathery women before you come to your senses.\n", false);
					flags[UNKNOWN_FLAG_NUMBER_00095]++;
					needNext = true;
				}
				stats(0,0,0,0,0,0,.1,0);
				player.lust += 20;
				if(player.lust > 100) player.lust = 100;
			}
			if(player.statusAffectv1("Luststick") <= 0) {
				player.removeStatusAffect("Luststick");
				outputText("\n<b>The lust-increasing effects of harpy lipstick have worn off!\n</b>", false);
				needNext = true;
			}
		}
		
		//Count down timer for urta's lust
		if(flags[URTA_TIME_SINCE_LAST_CAME] > 0) {
			flags[URTA_TIME_SINCE_LAST_CAME]--;
			if(flags[URTA_TIME_SINCE_LAST_CAME] < 0) flags[URTA_TIME_SINCE_LAST_CAME] = 0;
		}
		//Update status of Urta eggs
		if(flags[URTA_EGG_INCUBATION] > 0) {
			flags[URTA_EGG_INCUBATION]--;
			if(flags[URTA_EGG_INCUBATION] <= 0) {
				flags[URTA_EGG_INCUBATION] = 0;
				flags[URTA_EGGS] = 0;
				flags[URTA_FERTILE_EGGS] = 0;
			}
		}
		//Countdown to urta freakout
		if(flags[URTA_EGG_FORCE_EVENT] > 0) flags[URTA_EGG_FORCE_EVENT]--;
		//Urta egg freak out
		if(hours > 6 && hours < 18 && flags[URTA_EGG_FORCE_EVENT] < 12 && flags[URTA_EGG_FORCE_EVENT] > 0) {
			outputText("\n<b>You feel like you ought to see how Urta is dealing with your little 'donation', and head in to Tel'Adra for a quick checkup on her...</b>\n");
			urtaChewsOutPC(false);
		}
		//Count down rathazul event timers
		if(flags[UNKNOWN_FLAG_NUMBER_00087] > 0) {
			flags[UNKNOWN_FLAG_NUMBER_00087]--;
			if(flags[UNKNOWN_FLAG_NUMBER_00087] < 0) flags[UNKNOWN_FLAG_NUMBER_00087] = 0; 
		}
		//Check for gain of cat agility - requires legs, tail, and ears
		if(player.tailType == 8 && player.lowerBody == 9 && player.earType == 5) {
			if(player.hasPerk("Flexibility") < 0) {
				outputText("\nWhile stretching, you notice that you're much more flexible than you were before.  Perhaps this will make it a bit easier to dodge attacks in battle?\n\n(<b>Gained Perk: Flexibility</b>)\n", false);
				needNext = true;
				player.createPerk("Flexibility",0,0,0,0,"Due to your cat-like body, you're able to dodge attacks more often.");
			}
		}
		//Remove flexibility perk if not meeting requirements
		else if(player.hasPerk("Flexibility") >= 0) {
			outputText("\nYou notice that you aren't as flexible as you were when you had a more feline body.  It'll probably be harder to avoid your enemies' attacks now.\n\n(<b>Lost Perk: Flexibility</b>)\n", false);
			needNext = true;
			player.removePerk("Flexibility");
		}
		if(player.hasStatusAffect("Camp Marble") >= 0) {
			//Increment Marble's Lust
			if(flags[MARBLE_LUST] < -100) flags[MARBLE_LUST] = -100;
			if(rand(2) == 0) flags[MARBLE_LUST] += 1;
			if(player.statusAffectv4("Marble") > 50) flags[MARBLE_LUST] += .3;
			if(player.statusAffectv4("Marble") > 70) flags[MARBLE_LUST] += .3;
			//If bitch-bin is in construction
			if(flags[MARBLE_NURSERY_CONSTRUCTION] > 0 && flags[MARBLE_NURSERY_CONSTRUCTION] < 100) {
				flags[MARBLE_NURSERY_CONSTRUCTION]++;
				if(flags[MARBLE_NURSERY_CONSTRUCTION] >= 100) {
					spriteSelect(41);
					outputText("\n<b>Marble lets you know that she's finished building a rather secure nursery for your coming offspring.</b>\n", false);
					needNext = true;
					flags[MARBLE_NURSERY_CONSTRUCTION] = 100;
				}
			}
			
			//Marble find items check
			else if(player.hasStatusAffect("MarbleHasItem") < 0) {
				// Off cooldown
				if(player.hasStatusAffect("MarbleItemCooldown") < 0) {
					if(rand(10) == 0) {
						spriteSelect(41);
						outputText("\n<b>You find a note from Marble back at camp, letting you know that she has an item for you!</b>\n", false);
						player.createStatusAffect("MarbleItemCooldown",(24 + rand(24)),0,0,0);
						player.createStatusAffect("MarbleHasItem",rand(10),0,0,0);
						needNext = true;
					}
				}
			}
		}
		//Decrement marble cooldown
		if(player.hasStatusAffect("MarbleItemCooldown") >= 0) {
			player.addStatusValue("MarbleItemCooldown",1,-1);
			if(player.statusAffectv1("MarbleItemCooldown") < 1) 
				player.removeStatusAffect("MarbleItemCooldown");
		}
		//Kelt Submissiveness check
		if(player.statusAffectv2("Kelt") > 0) {
			//reduce kelt submissiveness by 1 every 5 hours
			player.addStatusValue("Kelt",2,-0.15);
		}
		//Mino cum update.
		if(minoCumUpdate()) needNext = true;
		//Repeated warnings!
		else if(flags[MINOTAUR_CUM_ADDICTION_STATE] >= 2 && hours % 13 == 0 && flags[UNKNOWN_FLAG_NUMBER_00330] == 0) {
			if(flags[MINOTAUR_CUM_ADDICTION_STATE] == 2) outputText("\n<b>You shiver, feeling a little cold.  Maybe you ought to get some more minotaur cum?  You just don't feel right without that pleasant buzz in the back of your mind.</b>\n", false);
			else if(flags[MINOTAUR_CUM_ADDICTION_STATE] == 3) outputText("\n<b>The steady fire of lust within you burns hot, making you shiver and grab at your head.  You're STILL in withdrawal after having gone so long without a dose of minotaur love.  You just know you're going to be horny and achy until you get some.</b>\n", false);
			needNext = true;
		}
		//Decrement mino withdrawal symptoms display cooldown
		//flags[UNKNOWN_FLAG_NUMBER_00330] prevents PC getting two of the same notices overnite
		else if(flags[UNKNOWN_FLAG_NUMBER_00330] > 0) flags[UNKNOWN_FLAG_NUMBER_00330]--;
		//Check for duplicate tails.
		if(player.lowerBody == 3) {
			if(player.tailType > 0) {
				outputText("\nYour tail squirms, wriggling against your larger naga tail as the scales part around it, absorbing it.  <b>Your form is completely scaly and smooth from the waist down.</b>\n", false);
				player.tailType = 0;
				needNext = true;
			}
		}
		//Update urta's PO timer
		if(flags[URTA_ANGRY_AT_PC_COUNTDOWN] > 1) {
			flags[URTA_ANGRY_AT_PC_COUNTDOWN]--;
			if(flags[URTA_ANGRY_AT_PC_COUNTDOWN] < 1) flags[URTA_ANGRY_AT_PC_COUNTDOWN] = 1;
		}
		//Update Amily's preggo counter
		if(flags[AMILY_INCUBATION] > 1) {
			flags[AMILY_INCUBATION]--;
			if(flags[AMILY_INCUBATION] < 1) flags[AMILY_INCUBATION] = 1;
		}
		//if in camp and birthing, display scene!
		if(flags[AMILY_FOLLOWER] == 1 && flags[AMILY_INCUBATION] == 1) {
			outputText("\n", false);
			amilyPopsOutKidsInCamp();
			flags[AMILY_INCUBATION] = 0;
			outputText("\n", false);
			needNext = true;
		}
		//Update Amily's Jojo fixing counter
		if(flags[UNKNOWN_FLAG_NUMBER_00078] > 0) {
			flags[UNKNOWN_FLAG_NUMBER_00078]--;
			if(flags[UNKNOWN_FLAG_NUMBER_00078] < 0) flags[UNKNOWN_FLAG_NUMBER_00078] = 0;
		}
		//Update Edryn's preggo counter
		if(flags[EDRYN_PREGNANCY_INCUBATION] > 0) {
			//Pregnancy only starts counting down once PC discovers it.
			if(flags[UNKNOWN_FLAG_NUMBER_00071] > 0) flags[EDRYN_PREGNANCY_INCUBATION]--;
			//BIRF
			if(flags[EDRYN_PREGNANCY_INCUBATION] <= 0) {
				//Clear incubation
				flags[EDRYN_PREGNANCY_INCUBATION] = 0;
				//Add one kid
				flags[UNKNOWN_FLAG_NUMBER_00069]++;
				//Set 'needs to talk to edryn about
				//da kid.
				flags[UNKNOWN_FLAG_NUMBER_00072] = 1;
			}
		}
		//Eggs in tits!
		if(player.hasStatusAffect("eggchest") >= 0) {
			player.addStatusValue("eggchest",1,-1);
			if(player.statusAffectv1("eggchest") <= 0) {
				outputText("\n<b>You feel the rounded eggs within your [fullChest] vanishing, absorbed into your body.  </b>");
				growTits(player.statusAffectv2("eggchest"), player.bRows(), true, 2);
				outputText("\n");	
				player.removeStatusAffect("eggchest");
			}
		}
		//Spider Oviposits!
		if(player.hasPerk("Spider Ovipositor") >= 0 || player.hasPerk("Bee Ovipositor") >= 0) {
			//Remove dat shit!
			if(player.hasPerk("Spider Ovipositor") >= 0 && (!player.isDrider() || player.tailType != 5)) {
				outputText("\nYour ovipositor (and eggs) vanish since your body has become less spider-like.</b>\n");
				player.removePerk("Spider Ovipositor");
				needNext = true;
			}
			//Remove dat shit!
			else if(player.hasPerk("Bee Ovipositor") >= 0 && player.tailType != 6) {
				outputText("\nYour ovipositor (and eggs) vanish since your body has become less bee-like.</b>\n");
				player.removePerk("Bee Ovipositor");
				needNext = true;
			}
			//Update stuff!
			else {
				temp = player.eggs();
				if(player.eggs() < 10) {
					player.addEggs(2);
				}
				else if(player.eggs() < 20 && hours % 2 == 0) {
					player.addEggs(1);
				}
				else if(hours % 4 == 0) {
					player.addEggs(1);
				}
				if(player.hasPerk("Spider Ovipositor") >= 0) {
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
						stats(0,0,-1,0,0,0,0,0);
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
						stats(0,0,-1,0,0,0,0,0);
						needNext = true;
					}
				}
			}
		}
		//Check ninetails perks!
		if(player.hasPerk("Enlightened Nine-tails") >= 0 || player.hasPerk("Corrupted Nine-tails") >= 0) {
			if(player.tailType != 13 || player.tailVenom < 9) {
				needNext = true;
				outputText("\n<b>Without your tails, the magic power they once granted withers and dies, vanishing completely.</b>\n");
				player.removePerk("Enlightened Nine-tails");
				player.removePerk("Corrupted Nine-tails");
			}
		}
		//Lose diapause
		if(!player.hasVagina() && player.hasPerk("Diapause") >= 0) {
			outputText("\n<b>With the loss of your womb, you lose your kangaroo-like diapause ability.</b>\n");
			player.removePerk("Diapause");
			needNext = true;
		}
		//Oviposition perk for lizard folks
		if(player.hasPerk("Oviposition") >= 0 || player.hasPerk("Bunny Eggs") >= 0) {
			//If too 'unlizardy', stop it
			//--Lose Oviposition perk if lizard score gets below 3.
			if((player.nagaScore() + player.lizardScore()) < 3 && player.hasPerk("Oviposition") >= 0 && player.hasPerk("Basilisk Womb") < 0) {
				outputText("\nAnother change in your uterus ripples through your reproductive systems.  Somehow you know you've lost a little bit of reptilian reproductive ability.\n(<b>Perk Lost: Oviposition</b>)\n", false);
				needNext = true;
				player.removePerk("Oviposition");
			}
			else if(player.bunnyScore() < 3 && player.hasPerk("Bunny Eggs") >= 0) {
				outputText("\nAnother change in your uterus ripples through your reproductive systems.  Somehow you know you you've lost your ability to spontaneously lay eggs.\n(<b>Perk Lost: Bunny Eggs</b>)\n", false);
				needNext = true;
				player.removePerk("Bunny Eggs");
			}
			//Otherwise pregger check
			else if(player.pregnancyIncubation < 1 && player.hasVagina()) {
				//Check once in the morning.
				if(hours ==1) {
					//every 15 days if high fertility get egg preg
					if(player.totalFertility() > 50 && days % 15 == 0) {
						outputText("\n<b>Somehow you know that eggs have begun to form inside you.  You wonder how long it will be before they start to show?</b>\n", false);
						needNext = true;
						player.knockUp(5,50,1,1);
						//v1 = egg type.
						//v2 = size - 0 for normal, 1 for large
						//v3 = quantity
						player.createStatusAffect("eggs",rand(6),rand(2),(5+rand(3)),0);
					}
					//every 30 days if high fertility get egg preg
					else if(days % 30 == 0) {
						outputText("\n<b>Somehow you know that eggs have begun to form inside you.  You wonder how long it will be before they start to show?</b>\n", false);
						needNext = true;
						player.knockUp(5,50,1,1);
						//v1 = egg type.
						//v2 = size - 0 for normal, 1 for large
						//v3 = quantity
						player.createStatusAffect("eggs",rand(6),rand(2),(5+rand(3)),0);
						//Count times eggpregged this way in perk.
						player.addPerkValue("Oviposition",1,1);
					}
				}
			}
		}
		//Prevent Buttsluts from getting dry backdoors
		if(player.hasPerk("Marae's Gift - Buttslut") >= 0 && player.ass.analWetness < 2) {
			outputText("\n<b>Your " + assholeDescript() + " quickly re-moistens.  It looks like Marae's 'gift' can't be removed.</b>\n", false);
			needNext = true;
			player.ass.analWetness = 2;
		}
		//Heat-check!
		//Heats v1 is bonus fertility, v2 is bonus libido, v3 is hours till it's gone
		if(player.hasStatusAffect("heat") >= 0) 
		{
			if(player.statusAffects[player.hasStatusAffect("heat")].value3 <= 1 || player.vaginas.length == 0) 
			{
				//Remove bonus libido from heat
				stats(0,0,0,0,-player.statusAffects[player.hasStatusAffect("heat")].value2,0,0,0);
				//remove heat
				player.removeStatusAffect("heat");
				if(player.lib < 1) player.lib = 1;
				statScreenRefresh();
				outputText("\n<b>Your body calms down, at last getting over your heat.</b>\n", false);
				needNext = true;
			}
			else player.statusAffects[player.hasStatusAffect("heat")].value3--;
		}
		//Remove anemone lustiness
		if(player.hasStatusAffect("Anemone Arousal") >= 0) {
			if(player.pregnancyIncubation > 1) {
				player.removeStatusAffect("Anemone Arousal");
				outputText("\n<b>The nigh-constant arousal forced upon you by the anemone-like creature in your body finally fades.  You stick a finger inside yourself and marvel in wonder - it's gone!  You aren't sure if it slipped out or your body somehow consumed it, but it's nice to have a clearer head.</b>\n", false);
				needNext = true;
			}
			else if(!player.hasVagina()) {
				player.removeStatusAffect("Anemone Arousal");
				outputText("\n<b>The nigh-constant arousal forced upon you by the anemone-like creature in your body finally fades.  You aren't sure if it was somehow consumed by the removal of your vagina or if it escaped during the process, but it's nice to have a clear head for a change.</b>\n", false);
				needNext = true;
			}
		}
		//Rut-check!
		//Rut v1 is bonus cum, v2 is bonus libido, v3 is hours till it's gone
		if(player.hasStatusAffect("rut") >= 0) 
		{
			trace("RUT:" + player.statusAffectv3("rut"));
			if(player.statusAffectv3("rut") <= 1 || player.totalCocks() == 0) 
			{
				//Remove bonus libido from rut
				stats(0,0,0,0,-player.statusAffectv2("rut"),0,0,0);
				//remove heat
				player.removeStatusAffect("rut");
				if(player.lib < 10) player.lib = 10;
				statScreenRefresh();
				outputText("\n<b>Your body calms down, at last getting over your rut.</b>\n", false);
				needNext = true;
			}
			
			else player.addStatusValue("rut",3,-1);
		}
		//Remove marble anti-worm sex
		if(player.hasStatusAffect("infested") < 0)
			flags[UNKNOWN_FLAG_NUMBER_00064] = 0;
		//Futa checks
		if(player.hasPerk("Futa Form") >= 0) {
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
				stats(0,0,0,-1,0,5,15,0);
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
				if(player.hasPerk("Futa Faculties") >= 0) outputText("\n<b>Your tits get nice and full again.  You'll have lots of fun now that your breasts are back to being big, swollen knockers!</b>\n", false);
				else outputText("\n<b>Your " + breastDescript(0) + " have regained their former bimbo-like size.  It looks like you'll be stuck with large, sensitive breasts forever, but at least it'll help you tease your enemies into submission!</b>\n", false);
				needNext = true;
				stats(0,0,0,-1,0,0,15,0);
			}
			//Vagoo
			if(!player.hasVagina()) {
				player.createVagina();
				if(player.hasPerk("Futa Faculties") >= 0) outputText("\n<b>Your crotch is like, all itchy an' stuff.  Damn!  There's a wet little slit opening up, and it's all tingly!  It feels so good, why would you have ever gotten rid of it?</b>\n", false);
				else outputText("\n<b>Your crotch tingles for a second, and when you reach down to feel, your " + player.legs() + " fold underneath you, limp.  You've got a vagina - the damned thing won't go away and it feels twice as sensitive this time.  Fucking bimbo liquer.</b>\n", false);
				stats(0,0,0,-1,0,10,15,0);
				needNext = true;
			}
		}
		//Bimbo checks
		if(player.hasPerk("Bimbo Body") >= 0 || player.hasStatusAffect("Bimbo Champagne") >= 0) {
			//Tits!
			if(player.breastRows[0].breastRating < 5) 
			{
				player.breastRows[0].breastRating = 5;
				if(player.hasPerk("Bimbo Brains") >= 0 || player.hasStatusAffect("Bimbo Champagne") >= 0) outputText("\n<b>Your boobies like, get all big an' wobbly again!  You'll have lots of fun now that your tits are back to being big, yummy knockers!</b>\n", false);
				else outputText("\n<b>Your " + breastDescript(0) + " have regained their former bimbo-like size.  It looks like you'll be stuck with large, sensitive breasts forever, but at least it'll help you tease your enemies into submission!</b>\n", false);
				needNext = true;
				stats(0,0,0,-1,0,0,15,0);
			}
			//Vagoo
			if(!player.hasVagina()) {
				player.createVagina();
				if(player.hasPerk("Bimbo Brains") >= 0 || player.hasStatusAffect("Bimbo Champagne") >= 0) outputText("\n<b>Your crotch is like, all itchy an' stuff.  Omigawsh!  There's a wet little slit opening up, and it's all tingly!  It feels so good, maybe like, someone could put something inside there!</b>\n", false);
				else outputText("\n<b>Your crotch tingles for a second, and when you reach down to feel, your " + player.legs() + " fold underneath you, limp.  You've got a vagina - the damned thing won't go away and it feels twice as sensitive this time.  Fucking bimbo liquer.</b>\n", false);
				needNext = true;
			}
			if(player.hipRating < 12) {
				if(player.hasPerk("Bimbo Brains") >= 0) outputText("\nWhoah!  As you move, your [hips] sway farther and farther to each side, expanding with every step, soft new flesh filling in as your hips spread into something more appropriate on a tittering bimbo.  You giggle when you realize you can't walk any other way.  At least it makes you look, like, super sexy!\n");
				else outputText("\nOh, no!  As you move, your [hips] sway farther and farther to each side, expanding with every step, soft new flesh filling in as your hips spread into something more appropriate for a bimbo.  Once you realize that you can't walk any other way, you sigh heavily, your only consolation the fact that your widened hips can be used to tease more effectively.\n");
				stats(0,0,0,-1,0,0,0,0);
				player.hipRating = 12;
				needNext = true;
			}
			if(player.buttRating < 12) {
				if(player.hasPerk("Bimbo Brains") >= 0) outputText("\nGradually warming, you find that your [butt] is practically sizzling with erotic energy.  You smile to yourself, imagining how much you wish you had a nice, plump, bimbo-butt again, your hands finding their way to the flesh on their own.  Like, how did they get down there?  You bite your lip when you realize how good your tush feels in your hands, particularly when it starts to get bigger.  Are butts supposed to do that?  Happy pink thoughts wash that concern away - it feels good, and you want a big, sexy butt!  The growth stops eventually, and you pout disconsolately when the lusty warmth's last lingering touches dissipate.  Still, you smile when you move and feel your new booty jiggling along behind you.  This will be fun!\n");
				else outputText("\nGradually warming, you find that your [butt] is practically sizzling with erotic energy.  Oh, no!  You thought that having a big, bloated bimbo-butt was a thing of the past, but with how it's tingling under your groping fingertips, you have no doubt that you're about to see the second coming of your sexy ass.  Wait, how did your fingers get down there?  You pull your hands away somewhat guiltily as you feel your buttcheeks expanding.  Each time you bounce and shake your new derriere, you moan softly in enjoyment.  Damnit!  You force yourself to stop just as your ass does, but when you set off again, you can feel it bouncing behind you with every step.  At least it'll help you tease your foes a little more effectively...\n");
				stats(0,0,0,-1,0,0,10,0);
				player.buttRating = 12;
				needNext = true;
			}
		}
		//Bro checks
		if(player.hasPerk("Bro Body") >= 0) {
			player.removeStatusAffect("Feeder");
			player.removePerk("Feeder");
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
				if(player.hasPerk("Bro Brains") >= 0) outputText("Goddamn, that thing is almost as tough as you!  ", false);
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
		if(player.hasStatusAffect("Feeder") >= 0) {
			//Go away if pure
			if(player.cor <= 20) {
				outputText("\nThe desire to breastfeed fades into the background.  It must have been associated with the corruption inside you.\n\n(<b>You have lost the 'Feeder' perk.</b>)\n", false);
				player.removeStatusAffect("Feeder");
				player.removePerk("Feeder");
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
				player.addStatusValue("Feeder",2,1);
				trace("Feeder status: " + player.statusAffectv2("Feeder") + " (modded " + ((player.statusAffectv2("Feeder")) - 70) + ")");
				//After 3 days without feeding someone sensitivity jumps.
				if(player.statusAffectv2("Feeder") >= 72 && hours == 14) {
					outputText("\n<b>After having gone so long without feeding your milk to someone, you're starting to feel strange.  Every inch of your skin practically thrums with sensitivity, particularly your sore, dripping nipples.</b>\n", false);
					temp = (2 + (((player.statusAffectv2("Feeder")) - 70) / 20));
					stats(0,0,0,0,0,temp,0,0);
					needNext = true;
				}
			}
		}
		//Update worm drippy-cooch
		if(player.hasStatusAffect("worm plugged") >= 0 && flags[PLAYER_PREGGO_WITH_WORMS] == 0) {
			if(player.hasVagina()) {
				if(rand(5) == 0) {
					flags[PLAYER_PREGGO_WITH_WORMS] = 1;
					outputText("\nA sudden gush of semen-coated worms noisily slurps out of your womb.  It runs down your legs as the worms do their damnedest to escape.  The feeling of so many squiggling forms squirting through your cunt-lips turns you on more than you'd like to admit.  You wonder why they stayed as long as they did, and some part of you worries that their stay may have reduced your capacity to bear children, though in a place like this that might be a blessing.\n", false);
					needNext = true;
					stats(0,0,0,0,0,0,2+player.sens/10,0);
					if(player.fertility > 5) player.fertility -= (1 + Math.round(player.fertility * 1/4));
					//Lower chances
					player.addStatusValue("worm plugged",1,-1);
					//Remove if too low
					if(player.statusAffectv1("worm plugged") <= 0) player.removeStatusAffect("worm plugged");
				}
			}
			//Non cunts lose worm plugged
			else player.removeStatusAffect("worm plugged");
		}				
		//Update Exgartuan stuff
		if(player.hasStatusAffect("Exgartuan") >= 0) 
		{
			trace("EXGARTUAN V1: " + player.statusAffectv1("Exgartuan") + " V2: " + player.statusAffectv2("Exgartuan"));
			//if too small dick, remove him
			if(player.statusAffectv1("Exgartuan") == 1 && (player.cockArea(0) < 100 || player.cocks.length == 0)) 
			{
				outputText("\n<b>You suddenly feel the urge to urinate, and stop over by some bushes.  It takes wayyyy longer than normal, and once you've finished, you realize you're alone with yourself for the first time in a long time.  Perhaps you got too small for Exgartuan to handle?</b>\n", false);
				player.removeStatusAffect("Exgartuan");
				needNext = true;
			}
			//Tit removal
			else if(player.statusAffectv1("Exgartuan") == 2 && player.biggestTitSize() < 12) 
			{
				outputText("\n<b>Black milk dribbles from your " + nippleDescript(0) + ".  It immediately dissipates into the air, leaving you feeling alone.  It looks like you became too small for Exgartuan!\n</b>", false);
				player.removeStatusAffect("Exgartuan");
				needNext = true;
			}		
			else 
			{
				//if sleeping, decrement sleep timer.
				if(player.statusAffectv2("Exgartuan") > 0) 
				{
					player.addStatusValue("Exgartuan",2,-1);
					//The demon awakens!
					if(player.statusAffectv2("Exgartuan") == 0) 
					{
						outputText("\n<b>", false);
						exgartuanBored();
						needNext = true;
						outputText("</b>\n", false);
					}
				}
				//If not sleeping, stuff happens!
				else 
				{
					//Dude stuff
					if(player.statusAffectv1("Exgartuan") == 1 && player.cockArea(0) > 100)
					{	
						if(player.hasStatusAffect("infested") >= 0 ) {
							outputText("\n<b>", false);
							exgartuanWormCure();
							needNext = true;
							outputText("</b>\n", false);	
						}
						else if(rand(10) == 0 && (player.armorName == "sexy black chitin armor-plating" || player.armorName == "glistening gel-armor plates" || player.armorName == "leather armor segments" || player.armorName == "comfortable clothes" || player.armorName == "bondage patient clothes" || player.armorName == "crotch-revealing clothes" || player.armorName == "cute servant's clothes" || player.armorName == "maid's clothes" || player.armorName == "servant's clothes" || player.armorName == "maid's clothes" || player.armorName == "practically indecent steel armor" || player.armorName == "red, high-society bodysuit" || player.armorName == "spider-silk armor" || player.armorName == "slutty swimwear" || player.armorName == "full-body chainmail" || player.armorName == "revealing chainmail bikini" || player.armorName == "full platemail" || player.armorName == "scale-mail armor" || player.armorName == "black leather armor surrounded by voluminous robes" || player.armorName == "rubber fetish clothes" || player.armorName == "green adventurer's clothes" || player.armorName == "white shirt and overalls")) {
							outputText("\n<b>", false);
							exgartuanArmorShift();
							needNext = true;
							outputText("</b>\n", false);	
						}
						else stats(0,0,0,0,0,0,1+rand(2),0);
					}
					//Chick stuff
					if(player.statusAffectv1("Exgartuan") == 2 && player.biggestTitSize() >= 12) {
						//Only once every 9 hours or so.
						if(hours % 9 == 0) {
							// lactation messing with!
							if(rand(3) == 0) {
								outputText("\n<b>", false);
								exgartuanLactationAdjustment();
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
									stats(0,0,0,0,0,0,5+player.sens/10,0);
								}
								needNext = true;
								outputText("</b>\n", false);	
							}
							else stats(0,0,0,0,0,0,1+rand(2),0);
						}
					}
				}
			}
		}
		//"Milked"
		if(player.hasStatusAffect("Milked") >= 0) {
			player.addStatusValue("Milked",1,-1);
			if(player.statusAffectv1("Milked") <= 0) {
				outputText("\n<b>Your " + nippleDescript(0) + "s are no longer sore from the milking.</b>\n", false);
				player.removeStatusAffect("Milked");
				needNext = true;
			}
		}
		if(player.hasStatusAffect("Jizzpants") >= 0) {
			outputText("\nYour " + player.armorName + " squishes wetly with all the semen you unloaded into them, arousing you more and more with every movement.\n", false);
			needNext = true;
			stats(0,0,0,0,0,0,10 + player.sens/5,0);
			player.removeStatusAffect("Jizzpants");
		}
		//Marble's Milk Status!
		if(player.hasStatusAffect("Marbles Milk") >= 0 && player.hasPerk("Marble's Milk") < 0) {
			//Decrement time remaining by 1		
			player.addStatusValue("Marbles Milk",1,-1);
			//Remove the status and stat boosts when time runs out on the milk
			if(player.statusAffectv1("Marbles Milk") <= 0) {
				needNext = true;
				stats((-1 * player.statusAffectv2("Marbles Milk")),(-1 * player.statusAffectv3("Marbles Milk")),0,0,0,0,0,0);
				player.removeStatusAffect("Marbles Milk");
				//Text for when Marble's Milk effect wears off:
				//[addiction is 10 or less] 
				if(player.statusAffectv2("Marble") <= 10) outputText("\nYou feel the euphoria from drinking Marble's milk fade from you. Only now that it's gone do you notice that it was actually making you tougher.\n", false);
				//[addiction is 11-30]
				else if(player.statusAffectv2("Marble") <= 30) outputText("\nYou feel a slight sense of loss as the euphoria from Marble's milk fades.  You kinda want to drink more, but the desire is not overpowering.\n", false);
				//[addiction is 31-50, player is not addicted]
				else if(player.statusAffectv2("Marble") <= 50) outputText("\nYou shiver slightly as the euphoria from Marble's milk fades.  You really feel like suckling her breasts again.\n", false);
				//IF ADDICTED
				if(player.statusAffectv3("Marble") > 0) {
					//If player is under bottled milk effects
					if(player.hasStatusAffect("Bottled Milk") >= 0) {
						outputText("\nYour hands develop a tiny tremble as the effects of Marble's fresh milk wear off.  Thanks to the bottled milk you drank, you don't go into withdrawal just yet.\n", false);
					}
					else {
						//[addiction is <90, player is addicted]
						if(player.statusAffectv2("Marble") <= 90) outputText("\nYour hands start to tremble as you lose the only true relief you get to your cravings.  You desperately want to go see Marble again, especially if it means a chance to drink her wonderful milk.\n", false);
						//[addiction is >=90, player is addicted]
						else outputText("\nThe euphoria from Marble's milk has faded, and you need more milk.  It's almost impossible not to run straight back to her and beg her to let you drink from her breasts again.\n", false);
						//If the player is addicted to her milk, they gain the withdrawal effect when it wears off, reducing player's inte and tou by 5
						player.createStatusAffect("MarbleWithdrawl",0,0,0,0);
						stats(0,-5,0,-5,0,0,0,0);
					}
				}
			}			
		}
		//Go into withdrawl if your addicted and don't have a reason not to be withdrawn.
		if(player.statusAffectv3("Marble") > 0 && player.hasPerk("Marble Resistant") < 0 && player.hasPerk("Marble's Milk") < 0 && player.statusAffectv2("Marble") > 25) {
			//If player does not have marble's milk or bottled milk, go into withdrawl
			if(player.hasStatusAffect("Marbles Milk") < 0 && player.hasStatusAffect("Bottled Milk") < 0) {
				//If player is not yet in withdrawl
				if(player.hasStatusAffect("MarbleWithdrawl") < 0) {
					outputText("\nYou are overwhelmed with a desire for more of Marble's Milk.\n", false);
					needNext = true;
					player.createStatusAffect("MarbleWithdrawl",0,0,0,0);
					stats(0,-5,0,-5,0,0,0,0);
				}
			}
		}
		//Prevent addiction from passing 60 if not yet revealed that your addicted
		if(player.statusAffectv3("Marble") <= 0) {
			if(player.statusAffectv2("Marble") > 60) player.changeStatusValue("Marble",2,60);
		}
		//Withdrawl removal if you get unaddicted.
		if(player.hasStatusAffect("MarbleWithdrawl") >= 0) {
			if(player.statusAffectv2("Marble") <= 25) {
				player.removeStatusAffect("MarbleWithdrawl");
				stats(0,5,0,5,0,0,0,0);
				outputText("\nYou no longer feel the symptoms of withdrawal.\n", false);
				needNext = true;
			}
			//Remove withdrawl if you have bottled milk affect
			else if(player.hasStatusAffect("Bottled Milk") >= 0) {
				outputText("\nYou no longer feel the symptoms of withdrawal.\n", false);
				needNext = true;
				player.removeStatusAffect("MarbleWithdrawl");
				stats(0,5,0,5,0,0,0,0);
			}
		}
		//Bottled Milk Countdown
		if(player.hasStatusAffect("Bottled Milk") >= 0) {
			player.addStatusValue("Bottled Milk",1,-1);
			if(player.statusAffectv1("Bottled Milk") <= 0)
				player.removeStatusAffect("Bottled Milk");
		}
		//Minotaur dysfunction status countdown (v1 = hours till gone)
		if(player.hasStatusAffect("dysfunction") >= 0) {
			if(player.statusAffects[player.hasStatusAffect("dysfunction")].value1 <= 1) {
				player.removeStatusAffect("dysfunction");
				outputText("\nYou feel a tingling in your nethers... at last full sensation has returned to your groin.  <b>You can masturbate again!</b>\n", false);
				needNext = true;
			}
			else player.statusAffects[player.hasStatusAffect("dysfunction")].value1--;			
		}
		//Lactation reduction
		if(player.hasStatusAffect("Lactation Reduction") < 0) {
			if(player.biggestLactation() > 0) {
				player.createStatusAffect("Lactation Reduction",0,0,0,0);
			}
		}
		else if(player.biggestLactation() > 0 && player.hasStatusAffect("Feeder") < 0 && player.pregnancyIncubation == 0) {
			player.addStatusValue("Lactation Reduction",1,1);
			trace("LACTATION REDUCTION" + player.statusAffectv1("Lactation Reduction") + " Biggest Lactation: " + player.biggestLactation() + ".");
			if(player.statusAffectv1("Lactation Reduction") >= 48) {
				if(player.hasStatusAffect("Lactation Reduc0") < 0) {
					player.createStatusAffect("Lactation Reduc0",0,0,0,0);
					if(player.biggestLactation() >= 1) outputText("\n<b>Your " + nippleDescript(0) + "s feel swollen and bloated, needing to be milked.</b>\n", false);
					if(player.biggestLactation() <= 2) player.createStatusAffect("Lactation Reduc1",0,0,0,0);
					if(player.biggestLactation() <= 1) player.createStatusAffect("Lactation Reduc2",0,0,0,0);
					needNext = true;
				}
				player.boostLactation(-(.5*player.breastRows.length)/24);
				trace(player.biggestLactation());
				if(player.biggestLactation() <= 2.5 && player.hasStatusAffect("Lactation Reduc1") < 0) {
					outputText("\n<b>Your breasts feel lighter as your body's milk production winds down.</b>\n", false);
					player.createStatusAffect("Lactation Reduc1",0,0,0,0);
					needNext = true;
				}
				else if(player.biggestLactation() <= 1.5 && player.hasStatusAffect("Lactation Reduc2") < 0) {
					outputText("\n<b>Your body's milk output drops down to what would be considered 'normal' for a pregnant woman.</b>\n", false);
					player.createStatusAffect("Lactation Reduc2",0,0,0,0);
					needNext = true;
				}
				if(player.biggestLactation() < 1 && player.hasStatusAffect("Lactation Reduc3") < 0) {
					player.createStatusAffect("Lactation Reduc3",0,0,0,0);
					outputText("\n<b>Your body no longer produces any milk.</b>\n", false);
					player.removeStatusAffect("Lactation Reduction");
					needNext = true;
				}
			}
		}
		//Cunt stretching stuff
		if(player.hasStatusAffect("CuntStretched") >= 0) {
			player.addStatusValue("CuntStretched",1,1);
			if(player.vaginas.length > 0) {
				if(player.hasPerk("Fera's Boon - Wide Open") < 0) {
				if(player.vaginas[0].vaginalLooseness == 2 && player.statusAffectv1("CuntStretched") >= 200) {
					outputText("\nYour " + vaginaDescript(0) + " recovers from your ordeals, tightening up a bit.\n", false);
					player.vaginas[0].vaginalLooseness--;
					player.changeStatusValue("CuntStretched",1,0);
					needNext = true;
				}
				if(player.vaginas[0].vaginalLooseness == 3 && player.statusAffectv1("CuntStretched") >= 100) {
					outputText("\nYour " + vaginaDescript(0) + " recovers from your ordeals, tightening up a bit.\n", false);
					player.vaginas[0].vaginalLooseness--;
					player.changeStatusValue("CuntStretched",1,0);
					needNext = true;
				}
				if(player.vaginas[0].vaginalLooseness == 4 && player.statusAffectv1("CuntStretched") >= 70) {
					outputText("\nYour " + vaginaDescript(0) + " recovers from your ordeals and becomes tighter.\n", false);
					player.vaginas[0].vaginalLooseness--;
					player.changeStatusValue("CuntStretched",1,0);
					needNext = true;
				}
				}
				if(player.vaginas[0].vaginalLooseness == 5 && player.statusAffectv1("CuntStretched") >= 50) {
					outputText("\nYour " + vaginaDescript(0) + " recovers from the brutal stretching it has received and tightens up a little bit, but not much.\n", false);
					player.vaginas[0].vaginalLooseness--;
					player.changeStatusValue("CuntStretched",1,0);
					needNext = true;
				}
			}
		}
		//Butt stretching stuff
		if(player.hasStatusAffect("ButtStretched") >= 0) {
			player.addStatusValue("ButtStretched",1,1);
			if(player.ass.analLooseness == 2 && player.statusAffectv1("ButtStretched") >= 72) {
				outputText("\n<b>Your " + assholeDescript() + " recovers from your ordeals, tightening up a bit.</b>\n", false);
				player.ass.analLooseness--;
				player.changeStatusValue("ButtStretched",1,0);
				needNext = true;
			}
			if(player.ass.analLooseness == 3 && player.statusAffectv1("ButtStretched") >= 48) {
				outputText("\n<b>Your " + assholeDescript() + " recovers from your ordeals, tightening up a bit.</b>\n", false);
				player.ass.analLooseness--;
				player.changeStatusValue("ButtStretched",1,0);
				needNext = true;
			}
			if(player.ass.analLooseness == 4 && player.statusAffectv1("ButtStretched") >= 24) {
				outputText("\n<b>Your " + assholeDescript() + " recovers from your ordeals and becomes tighter.</b>\n", false);
				player.ass.analLooseness--;
				player.changeStatusValue("ButtStretched",1,0);
				needNext = true;
			}
			if(player.ass.analLooseness == 5 && player.statusAffectv1("ButtStretched") >= 12) {
				outputText("\n<b>Your " + assholeDescript() + " recovers from the brutal stretching it has received and tightens up.</b>\n", false);
				player.ass.analLooseness--;
				player.changeStatusValue("ButtStretched",1,0);
				needNext = true;
			}
		}
		//Lose slime core perk
		if(player.hasPerk("Slime Core") >= 0) {
			if(player.vaginalCapacity() < 9000 || player.skinAdj != "slimy" || player.skinDesc != "skin" || player.lowerBody != 8) {
				//outputText("\n<b>Your slime core fades away inside of you, now lost forever.</b>\n", false);
				outputText("\nYour form ripples, as if uncertain at the changes your body is undergoing.  The goo of your flesh cools, its sensitive, responsive membrane thickening into " + player.skin() + " while bones and muscles knit themselves into a cohesive torso, chest and hips gaining definition.  Translucent ooze clouds and the gushing puddle at your feet melts together, splitting into solid trunks as you regain your legs.  Before long, you can no longer see through your own body and, with an unsteady shiver, you pat yourself down, readjusting to solidity.  A lurching heat in your chest suddenly reminds you of the slime core that used to float inside you.  Gingerly touching your " + chestDesc() + ", you can feel a small, second heartbeat under your ribs that gradually seems to be sinking, past your belly. A lurching wave of warmth sparks through you, knocking you off your fresh legs and onto your " + buttDescript() + ".  A delicious pressure pulses in your abdomen and you loosen your " + player.armorName + " as sweat beads down your neck.  You clench your eyes, tongue lolling in your mouth, and the pressure builds and builds until, in ecstatic release, your body arches in an orgasmic release.\n\n", false);
 
				outputText("\nPanting, you open your eyes and see that, for once, the source of your climax wasn't your loins.  Feeling a warm, wetness on your abs, you investigate and find the small, heart-shaped nucleus that used to be inside your body has somehow managed to pass through your belly button. Exposed to the open air, the crimson organ slowly crystallizes, shrinking and hardening into a tiny ruby.  Rubbing the stone with your thumb, you're surprised to find that you can still feel a pulse within its glittering facets.  You stow the ruby heart, in case you need it again.\n", false);
				//[Add 'Ruby Heart' to key items. Player regains slime core if returning to goo body]
				player.createKeyItem("Ruby Heart",0,0,0,0);
				needNext = true;
				player.removePerk("Slime Core");
			}
		}
		//Regain slime core
		if(player.hasKeyItem("Ruby Heart") >= 0) {
			if(player.hasStatusAffect("Slime Craving") >= 0 && player.hasPerk("Slime Core") < 0 && player.isGoo() && player.gooScore() >= 4 && player.vaginalCapacity() >= 9000) {
				outputText("\nAs you adjust to your new, goo-like body, you remember the ruby heart you expelled so long ago.  As you reach to pick it up, it quivers and pulses with a warm, cheerful light.  Your fingers close on it and the nucleus slides through your palm, into your body!\n\n", false);
				
				outputText("There is a momentary pressure in your chest and a few memories that are not your own flicker before your eyes.  The dizzying sight passes and the slime core settles within your body, imprinted with your personality and experiences.  There is a comforting calmness from your new nucleus and you feel as though, with your new memories, you will be better able to manage your body's fluid requirements.\n", false);
				//(Reduces Fluid Addiction to a 24 hour intake requirement).
				outputText("(<b>Gained New Perk: Slime Core - Moisture craving builds at a greatly reduced rate.</b>\n)", false);
				player.createPerk("Slime Core",0,0,0,0,"Moisture craving builds at a greatly reduced rate.");
				player.removeKeyItem("Ruby Heart");
			}
		}
		//Slime craving stuff
		if(player.hasStatusAffect("Slime Craving") >= 0) {
			if(player.vaginalCapacity() < 9000 || player.skinAdj != "slimy" || player.skinDesc != "skin" || player.lowerBody != 8) {
				outputText("\n<b>You realize you no longer crave fluids like you once did.</b>\n", false);
				needNext = true;
				player.removeStatusAffect("Slime Craving");
				player.removeStatusAffect("Slime Craving Feed");
			}
			else {
				//Slime core reduces fluid need rate
				if(player.hasPerk("Slime Core") >= 0) player.addStatusValue("Slime Craving",1,.5);
				else player.addStatusValue("Slime Craving",1,1);
				if(player.statusAffectv1("Slime Craving") >= 18) {
					if(player.hasStatusAffect("Slime Craving Output") < 0) {
						player.createStatusAffect("Slime Craving Output",0,0,0,0);
						outputText("\n<b>Your craving for the 'fluids' of others grows strong, and you feel yourself getting weaker and slower with every passing hour.</b>\n", false);
						needNext = true;
					}
					stats(-.1,0,-.1,0,0,0,2,0);
					//Keep track of how much has been taken from speed/strength
					player.addStatusValue("Slime Craving",2,.1);
					//Bad end!
					if(player.str <= 1) {
						outputText("Your entire body wobbles as your strength fails, collapsing into itself.  You struggle to rise, but your form loses more and more rigidity, melting into an amorphous blob.  Without the strength to rise, you've no hope of getting the fluids you need.  The aching craving for moisture drives you to roll to the lake, which you slip into.  With the constant runoff of bodily fluids that enter the lake, you're able to subsist for a time, forgetting about your mission as the all-consuming need devours your personality.", false);
						doNext(1063);
						return true;
					}
				}
			}
		}
		if(hours == 6 && player.armorName == "bimbo skirt" && rand(10) == 0) {
			outputText("\n<b>As you wake up, you feel a strange tingling starting in your nipples that extends down into your breasts.  After a minute, the tingling dissipates in a soothing wave.  As you cup your tits, you realize they've gotten larger!</b>");
			growTits(1,player.bRows(),false,2);
			needNext = true;
			stats(0,0,0,0,0,0,10,0);
		}
		//Slime feeding stuff
		if(player.hasStatusAffect("Slime Craving Feed") >= 0) {
			outputText("\n<b>You feel revitalized from your recent intake, but soon you'll need more...</b>\n", false);
			//Boost speed and restore hp/toughness
			stats(player.statusAffectv2("Slime Craving") * .5,0,player.statusAffectv2("Slime Craving"),0,0,0,0,0);
			//Remove feed succuss status so it can be reset
			player.removeStatusAffect("Slime Craving Feed");
			//Reset stored hp/toughness values
			player.changeStatusValue("Slime Craving",2,0);
			needNext = true;
		}
		//Bee Sting Recharge
		if(player.tailType == 6 || player.tailType == 5) {
			if(player.tailRecharge < 5) player.tailRecharge = 5;
			player.tailVenom += player.tailRecharge;
			if(player.tailVenom > 100) player.tailVenom = 100;
		}
		if(hours == 3 && followerHel() && flags[SLEEP_WITH] == "Helia" && rand(10) == 0) {
			sleepyNightMareHel();
		}
		//Luststick resistance unlock
		if(flags[UNKNOWN_FLAG_NUMBER_00285] >= 50 && player.hasPerk("Luststick Adapted") < 0) {
			unlockResistance();
			needNext = true;
			if(player.hasStatusAffect("Luststick") >= 0) player.removeStatusAffect("Luststick");
		}
		//Sophie's love
		if((player.hasPerk("Luststick Adapted") < 0 || rand(3) == 0) && hours == 10 && bimboSophie() && flags[SOPHIE_INCUBATION] == 0 && !sophieIsInSeason() && flags[SOPHIE_EGG_COUNTER] == 0) {
			bimboSophieLustStickSurprise();
			needNext = true;
		}
		if(flags[BIKINI_ARMOR_BONUS] > 0) {
			if(player.armorName == "lusty maiden's armor") {
				//Adjust for inflation
				if(hours > 23) flags[BIKINI_ARMOR_BONUS]--;
				//Keep in bounds.
				if(flags[BIKINI_ARMOR_BONUS] < 0) flags[BIKINI_ARMOR_BONUS] = 0;
				if(flags[BIKINI_ARMOR_BONUS] > 8) flags[BIKINI_ARMOR_BONUS] = 8;
			}
			else flags[BIKINI_ARMOR_BONUS] = 0;
		}
		if(hours > 23) {
			hours = 0;
			days++;
			if(flags[KELLY_REWARD_COOLDOWN] > 0 && days % 3 == 0) flags[KELLY_REWARD_COOLDOWN] = 0;
			if(flags[HELSPAWN_GROWUP_COUNTER] > 0) flags[HELSPAWN_GROWUP_COUNTER]++;
			if(arianFollower() && flags[ARIAN_VAGINA] > 0) flags[ARIAN_EGG_EVENT]++;
			flags[ARIAN_LESSONS] = 0;
			flags[ARIAN_TREATMENT] = 0;
			flags[BROOKE_MET_TODAY] = 0;
			if(days % 2 == 0 && flags[KAIJU_BAD_END_COUNTER] > 0) {
				flags[KAIJU_BAD_END_COUNTER]--;
				if(flags[KAIJU_BAD_END_COUNTER] < 0) flags[KAIJU_BAD_END_COUNTER] = 0;
			}
			if(phyllaWaifu() && flags[PHYLLA_EGG_LAYING] > 0) flags[DAYS_PHYLLA_HAS_SPENT_BIRTHING]++;
			if(flags[MIDAS_JERKED] > 0) flags[MIDAS_JERKED] = 0;
			if(flags[PHYLLA_GEMS_HUNTED_TODAY] > 0) flags[PHYLLA_GEMS_HUNTED_TODAY] = 0;
			if(phyllaWaifu()) flags[DAYS_PHYLLA_IN_CAMP]++;
			if(flags[SHEILA_CLOCK] < 0) flags[SHEILA_CLOCK]++;
			if(flags[SHEILA_PREG] > 0) flags[SHEILA_PREG]++;
			if(flags[URTA_TIME_SINCE_LAST_CAME] == 0) flags[URTA_CUM_NO_CUM_DAYS]++;
			else flags[URTA_CUM_NO_CUM_DAYS] = 0;
			if(flags[FED_SCYLLA_TODAY] == 1) flags[FED_SCYLLA_TODAY] = 0;
			//Count Kelt being a bitch
			if(flags[KELT_BREAK_LEVEL] >= 4) flags[KELLY_DISOBEYING_COUNTER]++;
			
			if(flags[EGG_WITCH_COUNTER] > 0) {
				if(flags[EGG_WITCH_COUNTER] < 8) flags[EGG_WITCH_COUNTER]++;
				//Birth without PC knowing after 8 days.
				else {
					flags[EGG_WITCH_COUNTER] = 0;
					flags[EGG_WITCH_TYPE] = 0;
				}
			}
			if(flags[HEL_RAPED_TODAY] == 1) flags[HEL_RAPED_TODAY] = 0;
			if(flags[FOUND_ISABELLA_AT_FARM_TODAY] == 1) flags[FOUND_ISABELLA_AT_FARM_TODAY] = 0;
			//Marae met 2nd time?
			if(flags[UNKNOWN_FLAG_NUMBER_00100] > 0) {
				//If flower hasn't been burned down yet
				if(flags[FUCK_FLOWER_KILLED] == 0) {
					//Grow flower if it isn't fully grown.
					if(flags[FUCK_FLOWER_LEVEL] < 4 && flags[FUCK_FLOWER_GROWTH_COUNTER] < 1000) {
						flags[FUCK_FLOWER_GROWTH_COUNTER]++;
					}
				}
			}
			//if(flags[RUBI_ORGASM_DENIAL] > 0) flags[RUBI_BLU_BALLS]++;
			if(flags[RUBI_PROSTITUTION] > 0) flags[RUBI_PROFIT] += 2 + rand(4);
			flags[BENOIT_TALKED_TODAY] = 0;
			updateBenoitInventory();
			if(player.pregnancyIncubation <= 0) flags[EMBER_BITCHES_ABOUT_PREGNANT_PC] = 0;
			if(vapulaSlave()) {
				if(flags[VAPULA_HAREM_FUCK] == 0) flags[VAPULA_DAYS_SINCE_FED]++;
				else flags[VAPULA_DAYS_SINCE_FED] = 0;
			}
			if(flags[VAPULA_FOLLOWER] == .5 || flags[VAPULA_FOLLOWER] == 1.5) flags[VAPULA_FOLLOWER]++;
			flags[DRANK_EMBER_BLOOD_TODAY] = 0;
			flags[DAYS_SINCE_LAST_DEMON_DEALINGS]++;
			flags[MARBLE_PLAYED_WITH_KIDS_TODAY] = 0;
			if(flags[AMILY_X_JOJO_COOLDOWN] > 0) {
				flags[AMILY_X_JOJO_COOLDOWN]--;
			}
			if(flags[AMILY_INCEST_COUNTDOWN_TIMER] > 0 && flags[AMILY_INCEST_COUNTDOWN_TIMER] < 60)
				flags[AMILY_INCEST_COUNTDOWN_TIMER]++;
			flags[ROGAR_FUCKED_TODAY] = 0;
			//Isabella milk
			if(isabellaFollower() && flags[ISABELLA_MILKED_YET] >= 0) {
				flags[ISABELLA_MILKED_YET]++;
			}
			//Reduce lust-stick resistance building
			if(flags[UNKNOWN_FLAG_NUMBER_00285] > 0) flags[UNKNOWN_FLAG_NUMBER_00285]--;
			//Dominika fellatrix countdown
			if(flags[UNKNOWN_FLAG_NUMBER_00155] > 0) {
				flags[UNKNOWN_FLAG_NUMBER_00155]--;
				if(flags[UNKNOWN_FLAG_NUMBER_00155] < 0) flags[UNKNOWN_FLAG_NUMBER_00155] = 0;
			}
			//Loppe denial counter
			if(flags[LOPPE_DENIAL_COUNTER] > 0) {
				flags[LOPPE_DENIAL_COUNTER]--;
				if(flags[LOPPE_DENIAL_COUNTER] < 0) flags[LOPPE_DENIAL_COUNTER] = 0;
			}
			//Reset Izma tooth hand outs
			if(flags[UNKNOWN_FLAG_NUMBER_00246] > 0) flags[UNKNOWN_FLAG_NUMBER_00246] = 0;
			//Move Raphael Countdowns
			if(flags[UNKNOWN_FLAG_NUMBER_00135] > 1 && player.gems >= 5) flags[UNKNOWN_FLAG_NUMBER_00135]--;
			if(flags[UNKNOWN_FLAG_NUMBER_00133] > 1 && player.gems >= 5) flags[UNKNOWN_FLAG_NUMBER_00133]--;
			//Fix 'hangs' - PC is at the bottom of the dress countdown
			if(flags[UNKNOWN_FLAG_NUMBER_00135] == 1 && flags[UNKNOWN_FLAG_NUMBER_00133] == 0 && RaphaelLikes()) flags[UNKNOWN_FLAG_NUMBER_00135] = 4;
			//Countdown to next faerie orgy
			if(flags[UNKNOWN_FLAG_NUMBER_00120] > 0) {
				flags[UNKNOWN_FLAG_NUMBER_00120]--;
				if(flags[UNKNOWN_FLAG_NUMBER_00120] < 0) flags[UNKNOWN_FLAG_NUMBER_00120] = 0;
			}
			//Clear Whitney's Weekly limit
			if(days % 7 == 0) flags[UNKNOWN_FLAG_NUMBER_00104] = 0;
			//Clear 'has fucked milker today'
			if(flags[UNKNOWN_FLAG_NUMBER_00112] > 0) flags[UNKNOWN_FLAG_NUMBER_00112] = 0;
			//Reduce bad-end for cerulean herms number
			if(flags[UNKNOWN_FLAG_NUMBER_00061] > 0) flags[UNKNOWN_FLAG_NUMBER_00061] -= 0.5;
			//Update Urta's luv counter
			if(flags[URTA_PC_AFFECTION_COUNTER] > 0) {
				flags[URTA_PC_AFFECTION_COUNTER] -= .5;
				if(flags[URTA_PC_AFFECTION_COUNTER] < 0) flags[URTA_PC_AFFECTION_COUNTER] = 0;
			}
			//Latex goo follower daily updates
			if(latexGooFollower()) {
				gooFluid(-2, false);
				if(gooFluid() < 50) gooHappiness(-1,false);
				if(gooFluid() < 25) gooHappiness(-1,false);
				if(gooHappiness() < 75) gooObedience(-1,false);
				if(gooHappiness() >= 90) gooObedience(1,false);
			}
			//Marble Preggo Counter
			if(flags[MARBLE_PREGNACY_INCUBATION] > 0) {
				flags[MARBLE_PREGNACY_INCUBATION] -= 24;
				if(flags[MARBLE_PREGNACY_INCUBATION] <= 0) flags[MARBLE_PREGNACY_INCUBATION] = 1;
			}
			//Tamani's Daughters stuff
			//Lower countdown till next event
			if(flags[UNKNOWN_FLAG_NUMBER_00057] > 0) {
				flags[UNKNOWN_FLAG_NUMBER_00057]--;
				trace("DAUGHTER PREGGO COUNTER: " + flags[UNKNOWN_FLAG_NUMBER_00057]);
			}
			//Decrease egg-laying time out.
			if(flags[TAMANI_TIME_OUT] > 0) {
				flags[TAMANI_TIME_OUT]--;
				if(flags[TAMANI_TIME_OUT] < 0) flags[TAMANI_TIME_OUT] = 0;
			}
			if(flags[UNKNOWN_FLAG_NUMBER_00057] < 0) flags[UNKNOWN_FLAG_NUMBER_00057] = 0;
			//Put a cap on daughters if they havent been met yet.
			if(flags[UNKNOWN_FLAG_NUMBER_00055] == 0) {
				if(player.statusAffectv2("Tamani") > 30)
					player.changeStatusValue("Tamani",2,30);
				
			}
			
			//Lower daughter population by 1 every fourth day
			//once population gets high
			if(player.statusAffectv2("Tamani") > 40 && days % 4 == 0) {
				player.addStatusValue("Tamani",2,-1);
			}
			//Tamani pregnancy counting
			if(player.statusAffectv1("Tamani") > -500) {
				player.addStatusValue("Tamani",1,-1);
				//Silently give birth if player missed the chance to see it
				if(player.statusAffectv1("Tamani") <= -2) {
					//Add new daughters to count
					player.addStatusValue("Tamani",2,player.statusAffectv3("Tamani"));
					//reset incubation
					player.changeStatusValue("Tamani",1,-500);
					//clear daughters to be born
					player.changeStatusValue("Tamani",3,0);
					//Increment times made pregnant
					player.addStatusValue("Tamani",4,1);
				}
			}
			//Remove jojo meditation block
			if(player.statusAffectv1("Meditated") > 0) {
				player.removeStatusAffect("Meditated");
				if(flags[UNKNOWN_FLAG_NUMBER_00102] == 0) {
					flags[UNKNOWN_FLAG_NUMBER_00102]++;
					while(player.hasStatusAffect("Meditated") >= 0) {
						player.removeStatusAffect("Meditated");
					}
				}
			}
			//Lower addiction by 1 every day.
			if(player.hasStatusAffect("Marble") >= 0) {
				if(player.statusAffectv2("Marble") > 0) marbleStatusChange(0,-1);
			}
			//Lower shark girl counter
			if(player.statusAffectv1("Shark-Girl") > 0) player.addStatusValue("Shark-Girl",1,-1);
			if(flags[INCREASED_HAIR_GROWTH_TIME_REMAINING] > 0) {
				switch (flags[INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED]) {
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
				flags[INCREASED_HAIR_GROWTH_TIME_REMAINING]--;
				//reset hair growth multiplier and timer when 
				//expired.
				if(flags[INCREASED_HAIR_GROWTH_TIME_REMAINING] <= 0) {
					flags[INCREASED_HAIR_GROWTH_TIME_REMAINING] = 0;
					flags[INCREASED_HAIR_GROWTH_SERUM_TIMES_APPLIED] = 0;
					needNext = true;
					outputText("<b>\nThe tingling on your scalp slowly fades away as the hair extension serum wears off.  Maybe it's time to go back to the salon for more?</b>", false);
					//Restart hair growth if wuz lizard-stopped
					if(flags[UNKNOWN_FLAG_NUMBER_00066] > 0) {
						flags[UNKNOWN_FLAG_NUMBER_00066] = 0;
						outputText("  <b>You hair is now growing normally again.</b>", false);
					}
					outputText("\n", false);
				}
			}
			//Hair grows if not disabled by lizardness
			if(flags[UNKNOWN_FLAG_NUMBER_00066] == 0) {
				if(!needNext) needNext = growHair(.1);
				else growHair(.1);
			}
			//Lower bonus score for drinking contest
			if(flags[UNKNOWN_FLAG_NUMBER_00227] > 0) flags[UNKNOWN_FLAG_NUMBER_00227]--;
			//Clear dragon breath cooldown!
			if(player.hasStatusAffect("Dragon Breath Cooldown") >= 0) player.removeStatusAffect("Dragon Breath Cooldown");
		}
		if(hours > 20 && hours - 1 <= 20) {
			outputText("\nThe sky darkens as a starless night falls.  The blood-red moon slowly rises up over the horizon.\n", false);
			needNext = true;
		}
		if(hours >= 6 && hours-1 < 6) {
			outputText("\nThe sky begins to grow brighter as the moon descends over distant mountains, casting a few last ominous shadows before they burn away in the light.\n", false);
			needNext = true;
		}
		//Amily stuff!
		if(hours == 6) {
			//Pure amily flips her shit and moves out!
			if(flags[AMILY_FOLLOWER] == 1 && player.cor >= 66 && flags[UNKNOWN_FLAG_NUMBER_00173] > 0) {
				farewellNote();
				needNext = true;
			}
			//Amily moves back in once uncorrupt.
			if(flags[AMILY_TREE_FLIPOUT] == 0 && flags[UNKNOWN_FLAG_NUMBER_00173] > 0 && player.cor <= 25 && flags[AMILY_FOLLOWER] == 0) {
				amilyReturns();
				needNext = true;
			}
		}
		//BIG EVENTS GO IN HERE
		//BIG EVENTS GO IN HERE
		//BIG EVENTS GO IN HERE
		//BIG EVENTS GO IN HERE
		//MARBLE POOPS BAYBEEZ
		if(flags[MARBLE_PREGNACY_INCUBATION] == 1) {
			marblePoopsBaybees();
			return true;
		}		
		//Helia's morning surprise!  TOP PRIORITY!
		if(flags[EDRYN_BIRF_COUNTDOWN] > 0) {
			flags[EDRYN_BIRF_COUNTDOWN]--;
			if(flags[EDRYN_BIRF_COUNTDOWN] <= 0) {
				flags[EDRYN_BIRF_COUNTDOWN] = 0;
				urtaAndEdrynGodChildEpilogue();
				return true;
			}
		}
		if(hours == 6 && flags[SOPHIE_FOLLOWER_PROGRESS] >= 5 && !bimboSophie() && !sophieFollower() && player.hasCock() && flags[NO_PURE_SOPHIE_RECRUITMENT] == 0) {
			sophieFollowerIntro();
			return true;
		}
		if(hours == 23 && followerHel() && flags[HEL_BONUS_POINTS] >= 150 && flags[HELIA_KIDS_CHAT] == 0) {
			heliaBonusPointsAward();
			return true;
		}
		if(hours == 8 && followerHel() && flags[HEL_NTR_TRACKER] == 1) {
			helGotKnockedUp();
			return true;
		}
		if(flags[HEL_FOLLOWER_LEVEL] == 1 && flags[HEL_HARPY_QUEEN_DEFEATED] > 0 && helAffection() >= 100 &&
		   flags[HELIA_FOLLOWER_DISABLED] == 0 && hours == 2) {
			heliaFollowerIntro();
			return true;   
		}
		if(flags[HEL_FOLLOWER_LEVEL] == -1 && hours == 6) {
			morningAfterHeliaDungeonAgreements();
			return true;
		}
		//Helspawn night smex!
		if(flags[HELSPAWN_AGE] == 2 && (hours == 2 || hours == 3 || hours == 4) && flags[HELSPAWN_GROWUP_COUNTER] == 7 && flags[HELSPAWN_FUCK_INTERRUPTUS] == 0) {
			helspawnIsASlut();
			return true;
		}		
		//Ghostgirl recruitment priority
		if(flags[SHOULDRA_FOLLOWER_STATE] == .5 && hours == 6) {
			morningShouldraAlert();
			return true;
		}
		//Ghostgirl pissed off dreams
		if(followerShouldra() && flags[SHOULDRA_SLEEP_TIMER] <= -236 && hours == 3 && player.gender > 0) {
			nightTimeShouldraRapesThePC();
			return true;
		}
		//Ghostgirl madness
		if(flags[UNKNOWN_FLAG_NUMBER_00365] > 0) {
			if(player.cockTotal() > 1 || player.faceType != 0 || player.lowerBody != 0 || player.tailType > 0 || player.horns > 0 || player.cor > 15 || player.longestCockLength() > 10 || player.tallness < 65 || player.tallness > 78 || player.hasVagina()) flags[UNKNOWN_FLAG_NUMBER_00365] = 0;
			else {
				flags[UNKNOWN_FLAG_NUMBER_00365]--;
				if(flags[UNKNOWN_FLAG_NUMBER_00365] == 0) {
					paladinModeFollowup();
					return true;
				}
			}
		}
		if(player.hasStatusAffect("Ember Napping") < 0) {
			//Ember get's a whiff of fuckscent and knocks up PC!
			if(followerEmber() && player.hasVagina() && player.hasStatusAffect("heat") >= 0 && player.pregnancyIncubation == 0 && player.hasStatusAffect("ember fuck cooldown") < 0 && rand(10) == 0 && (flags[EMBER_GENDER] == 1 || flags[EMBER_GENDER] == 3)) {
				emberRapesYourHeatness();
				return true;
			}
			else if(followerEmber() && player.hasCock() && player.hasStatusAffect("rut") >= 0 && flags[EMBER_INCUBATION] == 0 && player.hasStatusAffect("ember fuck cooldown") < 0 && rand(10) == 0 && flags[EMBER_GENDER] >= 2) {
				emberRapesYourHeatness();
				return true;
			}
		}
		if(rand(4) == 0 && isHolidays() && player.gender > 0 && hours == 6 && flags[XMAS_CHICKEN_YEAR] < date.fullYear) {
			getAChristmasChicken();
			return true;
		}
		//Amily X Urta morning after.
		if(!urtaBusy() && flags[AMILY_VISITING_URTA] == 2 && hours == 6) {
			amilyUrtaMorningAfter();
			return true;
		}
		if(flags[VAPULA_FOLLOWER] >= 2.5 && hours == 6) {
			femaleVapulaRecruitmentPartII();
			return true;
		}
		var ceraph:Number = 0;
		//Ceraph's dreams - overlaps normal night-time dreams.
		//Once every 10 days if 1, once every 7 days if 2, once every 5 days if 3
		temp = flags[UNKNOWN_FLAG_NUMBER_00218] + flags[UNKNOWN_FLAG_NUMBER_00219];
		if(temp == 1) ceraph = 10;
		else if(temp == 2) ceraph = 7;
		else if(temp == 3) ceraph = 5;
		else if(temp == 4) ceraph = 4;
		else if(temp >= 5) ceraph = 3;
		//DREAMS
		//Shouldra dreams here
		if(followerShouldra() && flags[SHOULDRA_PLOT_COUNTDOWN] > 0 && hours == 3) {
			flags[SHOULDRA_PLOT_COUNTDOWN]--;
			if(flags[SHOULDRA_PLOT_COUNTDOWN] <= 0) {
				shouldraDream1();
				return true;
			}
		}
		//Bee dreams proc
		if(player.hasCock() && player.hasPerk("Bee Ovipositor") >= 0 && hours == 3 && (player.eggs() >= 20 && rand(6) == 0)) {
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
			stats(0,0,0,0,0,0,-100,0);
			stats(0,0,0,0,0,0,20,0);
			doNext(1);
			//Hey Fenoxo - maybe the unsexed characters get a few \"cock up the ovipositor\" scenes for fertilization with some characters (probably only willing ones)?
			//Hey whoever, maybe you write them? -Z
			return true;
		}
		//Drider dreams proc
		if(player.hasCock() && player.hasPerk("Spider Ovipositor") >= 0 && hours == 3 && (player.eggs() >= 20 && rand(6) == 0)) {
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
			stats(0,0,0,0,0,0,-100,0);
			stats(0,0,0,0,0,0,20,0);
			doNext(1);
			//Hey Fenoxo - maybe the unsexed characters get a few \"cock up the ovipositor\" scenes for fertilization with some characters (probably only willing ones)?
			//Hey whoever, maybe you write them? -Z
			return true;
		}
		if(hours == 3) {
			//Plot dreams here
			if(ceraph > 0 && days % ceraph == 0) {
				ceraphBodyPartDreams();
				doNext(1);
				return true;
			}
			//Dominika Dream
			else if(flags[UNKNOWN_FLAG_NUMBER_00157] > 0 && flags[UNKNOWN_FLAG_NUMBER_00157] < 4) {
				outputText("\n<b>Your rest is somewhat troubled with odd dreams...</b>\n", false);
				fellatrixDream();
				doNext(1);
				return true;
			}
			//Day 10 dream forcing
			else if(player.gender > 0 && days == 10) {
				dayTenDreams();
				doNext(1);
				return true;
			}
			else if(kidAXP() >= 40 && flags[HAD_KID_A_DREAM] == 0 && player.gender > 0) {
				kidADreams();
				doNext(1);
				flags[HAD_KID_A_DREAM] = 1;
				return true;
			}
			else if(player.viridianChange()) {
				fuckedUpCockDreamChange();
				return true;
			}
			//Randomly generated dreams here
			else if((player.lib > 50 || player.lust > 40) && hours == 3) 
			{
				if(dreamSelect()) return true;
			}	
		}
		//XMAS ELF
		if(hours == 1 && isHolidays() && date.fullYear > flags[PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE]) {
			//Set it to remember the last year encountered
			xmasBitchEncounter();
			return true;
		}
		//TURKEY SURPRISE
		if((hours == 18 || hours == 19) && date.fullYear > flags[TURKEY_FUCK_YEAR_DONE] && isThanksgiving() && player.gender > 0) {
			datTurkeyRumpMeeting();
			return true;
		}
		//IMP GANGBAAAAANGA
		//The more imps you create, the more often you get gangraped. 
		temp = player.statusAffectv1("Birthed Imps") * 2;
		if(temp > 7) temp = 7;
		if(player.hasPerk("Pierced: Lethite") >= 0) temp += 4;
		if(player.hasStatusAffect("heat") >= 0) temp += 2;
		if(vapulaSlave()) temp += 7;
		if(hours == 2) {
			if(days % 30 == 0 && flags[ANEMONE_KID] > 0 && player.hasCock() && flags[ANEMONE_WATCH] > 0 && player.statusAffectv2("Tamani") >= 40) {
				goblinNightAnemone();
				needNext = true;
			}
			else if(temp > rand(100) && player.hasStatusAffect("Defense: Canopy") < 0) {
				if(player.gender > 0 && (player.hasStatusAffect("JojoNightWatch") < 0 || player.hasStatusAffect("PureCampJojo") < 0) && (flags[HEL_GUARDING] == 0 || !followerHel()) && flags[ANEMONE_WATCH] == 0 && (flags[HOLLI_DEFENSE_ON] == 0 || flags[FUCK_FLOWER_KILLED] > 0) && (flags[KIHA_CAMP_WATCH] == 0 || !followerKiha())) {
					impGangabangaEXPLOSIONS();
					doNext(1);
					return true;
				}
				else if(flags[KIHA_CAMP_WATCH] > 0 && followerKiha()) {
					outputText("\n<b>You find charred imp carcasses all around the camp once you wake.  It looks like Kiha repelled a swarm of the little bastards.</b>\n");
					needNext = true;
				}
				else if(flags[HEL_GUARDING] > 0 && followerHel()) {
					outputText("\n<b>Helia informs you over a mug of beer that she whupped some major imp asshole last night.  She wiggles her tail for emphasis.</b>\n");
					needNext = true;
				}
				else if(player.gender > 0 && player.hasStatusAffect("JojoNightWatch") >= 0 && player.hasStatusAffect("PureCampJojo") >= 0) {
					outputText("\n<b>Jojo informs you that he dispatched a crowd of imps as they tried to sneak into camp in the night.</b>\n", false);
					needNext = true;
				}
				else if(flags[HOLLI_DEFENSE_ON] > 0) {
					outputText("\n<b>During the night, you hear distant screeches of surprise, followed by orgasmic moans.  It seems some imps found their way into Holli's canopy...</b>\n");
					needNext = true;
				}
				else if(flags[ANEMONE_WATCH] > 0) {
					outputText("\n<b>Your sleep is momentarily disturbed by the sound of tiny clawed feet skittering away in all directions.  When you sit up, you can make out Kid A holding a struggling, concussed imp in a headlock and wearing a famished expression.  You catch her eye and she sheepishly retreats to a more urbane distance before beginning her noisy meal.</b>\n");
					needNext = true;
				}
			}
			//wormgasms
			else if(flags[EVER_INFESTED] == 1 && rand(100) <= 4 && player.hasCock() && player.hasStatusAffect("Infested") < 0) {
				if(player.hasCock() && (player.hasStatusAffect("JojoNightWatch") < 0 || player.hasStatusAffect("PureCampJojo") < 0) && (flags[HEL_GUARDING] == 0 || !followerHel()) && flags[ANEMONE_WATCH] == 0) {
					nightTimeInfestation();
					return true;
				}
				else if(flags[HEL_GUARDING] > 0 && followerHel()) {
					outputText("\n<b>Helia informs you over a mug of beer that she stomped a horde of gross worms into paste.  She shudders after at the memory.</b>\n");
					needNext = true;
				}
				else if(player.gender > 0 && player.hasStatusAffect("JojoNightWatch") >= 0 && player.hasStatusAffect("PureCampJojo") >= 0) {
					outputText("\n<b>Jojo informs you that he dispatched a horde of tiny, white worms as they tried to sneak into camp in the night.</b>\n", false);
					needNext = true;
				}
				else if(flags[ANEMONE_WATCH] > 0) {
					outputText("\n<b>Kid A seems fairly well fed in the morning, and you note trail of slim</b>\n");
					needNext = true;
				}
			}
		}
		//Chance of threesomes!
		if(flags[HEL_FUCKBUDDY] == 1 && isabellaFollower() && hours == 2 && days % 11 == 0) {
			trace("ISABELLA/HELL TEST");
			//Hell/Izzy threesome intro
			if(flags[HEL_ISABELLA_THREESOME_ENABLED] == 0) {
				spriteSelect(31);
				followrIzzyxSallyThreesomePretext();
				return true;
			}
			//Propah threesomes here!
			else if(flags[HEL_ISABELLA_THREESOME_ENABLED] == 1) {
				spriteSelect(31);
				isabellaXHelThreeSomeCampStart();
				return true;
			}
		}
		if(hours == 2 && vapulaSlave() && flags[VAPULA_DAYS_SINCE_FED] >= 5 && (player.hasCock() || (player.hasKeyItem("Demonic Strap-On") >= 0 && player.hasVagina()))) {
			vapulaForceFeeds();
			return true;
		}
		//Dreams on hour 3.
		if(hours == 4) {
			if(player.hasStatusAffect("succubiNight") >= 0 && (player.totalCocks() >= 1 || (player.gender == 0))) {
				//Call secksins!
				if(player.hasStatusAffect("repeatSuccubi") >= 0) {
					//VapulaSurprise
					if(vapulaSlave() && player.hasCock() && flags[VAPULA_THREESOMES] > 0)
						vapulaAssistsCeruleanSuccubus();
					//Normal night succubi shit
					else {
						doNext(1);
						nightSuccubiRepeat();
					}
				}
				else {
					player.createStatusAffect("SuccubiFirst",0,0,0,0);
					eventParser(2025);
					player.createStatusAffect("repeatSuccubi",0,0,0,0);
				}
				//Lower count if multiples stacked up.
				if(player.statusAffects[player.hasStatusAffect("succubiNight")].value1 > 1) {
					player.statusAffects[player.hasStatusAffect("succubiNight")].value1--;
				}
				else player.removeStatusAffect("succubiNight");
				if(player.hasStatusAffect("SuccubiFirst") >= 0) {
					if(player.gender > 0) doNext(2026);
					player.removeStatusAffect("SuccubiFirst");
				}
				return true;
			}
			//Exgartuan night time surprise!
			else if(player.totalCocks() > 0 && player.statusAffectv1("Exgartuan") == 1 && rand(3) == 0 && player.hoursSinceCum >= 24) {
				outputText("\n", false);
				exgartuanSleepSurprise();;
				return true;
			}
			//Boobgartuan night time surprise!
			if(player.statusAffectv1("Exgartuan") == 2 && rand(3) == 0 && player.statusAffectv2("Exgartuan") == 0) {
				outputText("\n", false);
				boobGartuanSURPRISE();
				return true;
			}
		}
		//MORNING FUX
		if(hours == 6 && bimboSophie() && flags[SLEEP_WITH] == "Sophie" && rand(2) == 0 && player.hasCock() && player.cockThatFits(sophieCapacity()) >= 0) {
			outputText("\n<b><u>Something odd happens that morning...</u></b>");
			if(flags[SOPHIE_INCUBATION] > 0 && flags[SOPHIE_INCUBATION] < 120) fuckYoPregnantHarpyWaifu(true);
			else sophieFenCraftedSex(true);
			return true;
		}
		if(hours == 6 && sophieFollower() && flags[SLEEP_WITH] == "Sophie" && player.lust >= 50 && player.hasCock() && player.smallestCockArea() <= 5) {
			sophieSmallDongTeases();
			return true;
		}
		//MARBLE STUFF
		//End addiction (occurs after the player wakes up when their addiction is under 25 && is not permanently addicted)
		if(player.statusAffectv3("Marble") > 0 && player.statusAffectv2("Marble") < 25 && player.hasPerk("Marble's Milk") < 0 && player.hasPerk("Marble Resistant") < 0 && hours == 6) {
			spriteSelect(41);
			outputText("\nYou wake up feeling strangely at ease, having slept better than you have in a long while.  After a minute, you realize that you don't feel a need to drink Marble's milk anymore!  You are free of your addiction.  You hurry off to the farm to give her the news.\n\n", false);
			outputText("You find Marble in her room.  When you come in she looks up at you and starts.  \"<i>What happened?</i>\" she asks, \"<i>Something about you is completely different from before...</i>\"  You explain to her that you've gotten over your addiction and no longer crave her milk.\n", false);
			//(reduce corr by 5)
			stats(0,0,0,0,0,0,0,-5);
			//(From this point forward, the addiction scores and affection scores are no longer modified.  Additionally, the player can no longer be given the status effect of 'Marble's Milk' or go into withdrawal)
			player.createPerk("Marble Resistant",0,0,0,0,"You know how to avoid the addictive qualities of Marble's milk.");
			//After player ends Addiction:
			//Marble liked you addicted
			if(player.statusAffectv3("Marble") == 1) {
				//Affection 0-29, version 1
				if(player.statusAffectv1("Marble") < 30) {
					outputText("\nMarble looks horrified at your words and exclaims, \"<i>You told me you would always want my milk!  How could you do this to me?</i>\"  You try to explain yourself to her, but she will have none of it.  \"<i>That's it, I'm leaving, don't come looking for me.</i>\"  She storms out the door.  Having no further reason to stay here, you leave too.\n", false);
					//(Marble leaves the farm, she is no longer encountered)
					player.createStatusAffect("No More Marble",0,0,0,0);
				}
				//Affection 30-89, version 1
				if(player.statusAffectv1("Marble") >= 30 && player.statusAffectv1("Marble") < 90) {
					outputText("\nMarble looks horrified at your words and exclaims \"<i>You told me you would always want my milk!  How could you do this to me?</i>\"  You try to explain yourself to her, telling her how important your task is and how everyone is counting on you.  As you speak, her expression slowly softens and eventually she calms down.  \"<i>Alright,</i>\" she says, \"<i>I guess I shouldn't have worried about my milk so much.  It's probably best if people don't drink it anyway.</i>\"  You agree with her and she smiles at you.  \"<i>I guess things are back to normal now.</i>\"  You both laugh at this.\n", false);
					//(Marble can be met at the farm)
				}
				//Affection 90+, version 1
				if(player.statusAffectv1("Marble") >= 90) {
					outputText("\nMarble looks horrified at your words and exclaims \"<i>You told me you would always want my milk!  How could you do this to me?</i>\"  You try to explain yourself to her, telling her how important your task is and how everyone is counting on you.  As you speak, her expression slowly softens and eventually she calms down.  \"<i>Alright,</i>\" she says \"<i>I guess I shouldn't have worried about my milk so much.  It's probably best if people don't drink it anyway.</i>\"  You agree with her and she smiles, suddenly looking down.  \"<i>Without someone like you, I don't think things would have turned out this way.  I..</i>\" she hesitates, \"<i>I'll stay with you at camp from now on!</i>\"\n", false);
					//(Marble now appears at the camp)
					player.createStatusAffect("Camp Marble",0,0,0,0);
					if(isabellaFollower()) flags[ISABELLA_MURBLE_BLEH] = 1;
					//if amily is there, tag it for freakout
					if(flags[AMILY_FOLLOWER] > 0) {
						flags[UNKNOWN_FLAG_NUMBER_00085] = 2;
					}
					//if Izma is there, tag for freakout!
					if(flags[UNKNOWN_FLAG_NUMBER_00238] == 1) {
						flags[UNKNOWN_FLAG_NUMBER_00237] = 1;
					}
					else flags[UNKNOWN_FLAG_NUMBER_00085] = 1;
					player.createStatusAffect("No More Marble",0,0,0,0);
				}
			}
			//Ashamed Marble
			else {
				//Affection 0-29, version 2
				if(player.statusAffectv1("Marble") < 30) {
					outputText("\nMarble seems impassive at the news of hearing that you are no longer addicted.  Her eyes have gone cold, her old passion gone.  \"<i>Good,</i>\" she states simply and points at a paper on the table in her room.  \"<i>That's for you. Goodbye.</i>\" With that, she turns and walks out the room.  Since you are unsure how to react, you decide to take a look at the paper.\n\n", false);
					//[This section should be indented and/or italicized] - put the codex entry here
					outputText("The piece of paper looks like a page torn from a book.  It looks like an entry from an encyclopedia of sorts, it reads in formal script:\n", false);
					outputText("<b><u>Codex: Lacta Bovine</u></b>\n", false);
					outputText("Description: <i>A race of all female bovine-morphs, more commonly called cow-girls.  They appear as tall well endowed women, with numerous bovine characteristics.  Generally they have bovine horns, ears, tail, and legs.  Like all minotaurs, they are very strong and resilient, however, they are unusually sensitive compared to their relatives.</i>\n", false);
					outputText("Skin and Fur: <i>The skin tone for these creatures is very close to being human, their fur more closely follows the common minotaur fur colors: brown, black or white with brown spots.</i>\n", false);
					outputText("Behaviour: <i>The behaviour of Lacta Minotaurs varies greatly between each individual.  The only major unifying piece of behaviour is their desire to give milk to almost any living creature, and their high libido, common to all corrupted creatures.</i>\n", false);
					outputText("Special abilities: <i>A lightly corrupted creature, most of the corruption is centered on their breast milk.  It is addictive to those that drink it repeatedly, eventually making them dependent on the one from whom is was drank from.  The milk also strengthens the drinker, makes them better able to find the one who nursed them, and granting limited powers of control over them to the Lacta Minotaur that nursed them.  Finally, the breasts of Lacta Minotaurs are incredibly resilient, healing from almost any damage, even being cut off; they are able to produce milk for their entire life without fail.</i>\n", false);
					outputText("\nUnderneath the entry is a single line, written in a crude and unsteady hand:     <i>No one will ever drink my milk again.  I'm sorry, sweetie.</i>\n", false);
					player.createStatusAffect("No More Marble",0,0,0,0);
				}
				//Affection 30-69, version 2
				if(player.statusAffectv1("Marble") >= 30 && player.statusAffectv1("Marble") < 70) {
					outputText("\nMarble looks relieved, like a great weight has been lifted from her shoulders.  \"<i>I'm glad you won't need me anymore then,</i>\" she says, her face falling, \"<i>now, no one will mind if I disappear.</i>\"  You look at her in surprise and ask her why she says that.  She explains that the only way to be sure that no one else ever drinks her milk is for her to disappear, forever.  You tell her not to think like that and that the people on the farm still appreciate her help with the chores and duties, insisting that they would all be sorry to see her go. Besides, now that you both know that her milk is addictive, the two of you have a big advantage compared to what happened the first time.  \"<i>Plus, we got through it, didn't we?</i>\" you say with a smile.  At this, her face lights up, \"<i>You're right! Thanks for being such a good friend, sweetie.</i>\"  She smiles at you in return.  \"<i>I guess things are back to normal now.</i>\"  You both laugh at this.\n", false);
					//(Marble can be encountered at the farm)
				}
				//Affection 70+, version 2
				if(player.statusAffectv1("Marble") >= 70) {
					outputText("\nMarble looks relieved, like a great weight has been lifted from her shoulders.  \"<i>I'm glad you won't need me anymore then,</i>\" she says, her face falling, \"<i>now, no one will mind if I disappear.</i>\"  You look at her in surprise and quickly grab her arms.  You tell her with no uncertainty that if she disappeared, you would forever miss her.  You don't care about her milk, it doesn't matter; it is her as a person that matters to you.  You wouldn't have done all those things or spent all that time together if you didn't care about her.  She bursts into tears and hugs you tightly to her breasts.\n\n", false);
					marbleAddictionSex(false);
					outputText("\n", false);
					player.createStatusAffect("Camp Marble",0,0,0,0);
					if(isabellaFollower()) flags[ISABELLA_MURBLE_BLEH] = 1;
					//if amily is there, tag it for freakout
					if(flags[AMILY_FOLLOWER] > 0) {
						flags[UNKNOWN_FLAG_NUMBER_00085] = 2;
					}
					//if Izma is there, tag for freakout!
					if(flags[UNKNOWN_FLAG_NUMBER_00238] == 1) {
						flags[UNKNOWN_FLAG_NUMBER_00237] = 1;
					}
					else flags[UNKNOWN_FLAG_NUMBER_00085] = 1;
					player.createStatusAffect("No More Marble",0,0,0,0);
				}
			}
			outputText("\n<b>You have gained the perk Marble Resistance</b> (You know how to avoid the addictive qualities of her milk!)\n", false);
			doNext(1);
			return true;
		}
		//Become permanently addicted (occurs when the player goes to sleep with addiction 100, before it is reduced by the standard 1):
		if(player.statusAffectv3("Marble") > 0 && player.statusAffectv2("Marble") >= 100 && player.hasPerk("Marble's Milk") < 0 && player.hasPerk("Marble Resistant") < 0 && hours == 6) {
			spriteSelect(41);
			outputText("\nYou wake up feeling like something has changed.  With slightly chilling clarity, you realize that you have finally become completely and utterly dependent on Marble's milk; you must drink her milk every day, or you will die.  There is nothing that can be done to change that at this point.  You hurry over to the farm; you have to drink Marble's milk, NOW.\n\n", false);
			outputText("You find Marble in her room.  When you come in she looks up at you and smiles deeply.  \"<i>What happened?</i>\" she asks, \"<i>Something about you feels so wonderful and right.</i>\"  You explain to her that you've finally become entirely dependent on her milk.\n", false);
			//(From this point forward, the addiction scores and affection scores are no longer modified.  Additionally, the player can no longer be given the status effect of 'Marble's Milk' or go into withdrawal, they are instead permanently given the stat increases of 5 str, and 10 tou as part of a perk called 'Marble's Milk' and automatically drink Marble's milk every morning if a bad end is not triggered)
			player.createPerk("Marble's Milk",0,0,0,0,"You're totally addicted to Marble's milk and can't live without it.");
			//Clear withdrawl
			if(player.hasStatusAffect("MarbleWithdrawl") >= 0) {
				player.removeStatusAffect("MarbleWithdrawl");
				stats(0,5,0,5,0,0,0,0);
			}
			//Clear marble's milk status
			if(player.hasStatusAffect("Marbles Milk") >= 0) {
				player.removeStatusAffect("Marbles Milk");
			}
			//Boost stats if not under its affects
			else {
				stats(5,10,0,0,0,0,0,0);
			}
			//Post-addiction flavors
			//Marble liked you addicted
			if(player.statusAffectv3("Marble") == 1) {
				//Affection 0-49, type 1:
				if(player.statusAffectv1("Marble") < 49) {
					//outputText("\nA huge grin passes over Marble's face, \"<i>I'm glad to hear it sweetie,</i>\" she tells you, \"<i>I was hoping you might help me out with my chores. Then I'll see about getting you some milk.</i>\"  The idea of working for her milk seems oddly right, and you put a huge effort into helping Marble with her chores.  Afterwards, Marble gladly agrees to give you her milk. While you are nursing from her, she starts to talk: \"<i>Sweetie, I've been thinking.  I think you should stay here with me from now on, since you need my milk to survive.</i>\"  She starts to stroke your head.  \"<i>You always do such a good job with the chores too; do you really want to do anything else?</i>\"  You try to pull back from her and tell her about your quest, but she keeps your mouth from straying from her breast.  \"<i>No, of course you don't.</i>\"  She says with finality, and you feel your need to do anything else fade....\n\n", false);
					//outputText("\nMarble continues talking for a while, but it doesn't really matter to you anymore, all that matters to you now is earning her milk, and doing anything to please her.  Your mind is still able to wander freely, but it is so fixated on your need that you will remain at Marble's side for the rest of your life.  Your village will just have to rely on the next champion.", false);
					outputText("Marble grabs you and pulls your head into her chest.  \"<i>Mmm, if you need me so much, then I want you to move in with me on the farm,</i>\" she says happily above you.  \"<i>That way, I can take care of you and you can help me, and we'll both be happy.</i>\"  You panic a bit; while you'd certainly be happy to have the source of her delicious milk at your fingertips, leaving the portal unguarded means the demons will be free to set up shop there again!  Marble responds to your squirming by tightening her arms and says, \"<i>Ah, ah, remember, sweetie; you need my milk and I control whether or not you can drink it.  I'm happy to share it, but if I'm being so generous, I think the least you could do is make it easier for me.  I don't think living here and helping me with the farmwork is too much to ask, do you?</i>\"  Her face contorts into an open-mouthed smile and her eyes glitter.  You sigh into her chest, she's right, there isn't much you can do about it now...");
					doNext(marbleBadEndFollowup);
					return true;
				}
				//Affection 50-79, type 1:
				if(player.statusAffectv1("Marble") >= 50 && player.statusAffectv1("Marble") < 79) {
	
					outputText("\nA huge grin passes over Marble's face, \"<i>I'm glad to hear it sweetie,</i>\" she tells you, \"<i>Are you thirsty already?</i>\" You give an eager nod and she slips her top off, pushing your mouth to one of her teats.  After you've drunk your fill, Marble sighs and gives you a smile.  \"<i>I was thinking that maybe you should live with me from now on, but I think I like seeing you visit like this too much.  It always makes me so happy to see you come by, so why don't we just leave things they way they are?</i>\"  You agree with her and she says \"<i>I'll see you tomorrow when you're thirsty again.</i>\"  You nod again and return to your camp.\n", false);
					//(Marble can be encountered at the farm)
					//(every morning, the player goes to Marble for milk, it costs them the first hour of the day)
				}
				//High affection
				if(player.statusAffectv1("Marble") >= 80) {
					outputText("\nA huge grin passes over Marble's face, \"<i>I'm glad to hear it sweetie,</i>\" she tells you, \"<i>Are you thirsty already?</i>\" You give an eager nod and she slips her top off, pushing your mouth to one of her teats.  After you've drunk your fill, you notice Marble staring closely at you. \"<i>Sweetie, do you like me for more than just my milk?</i>\"  You are taken aback by the question, why wouldn't you?  \"<i>I want to know if you like me because I'm me, and not because you like my milk.  Can you show me in a special way?</i>\" she asks you, suggestively.  You agree without having to think about it at all.\n\n", false);
					//(player chose yes) do after addiction sex event
					marbleAddictionSex(false);
					outputText("\n", false);
					//(Marble now appears at the camp)
					player.createStatusAffect("Camp Marble",0,0,0,0);
					if(isabellaFollower()) flags[ISABELLA_MURBLE_BLEH] = 1;
					player.createStatusAffect("No More Marble",0,0,0,0);
					//(every morning, the player goes to Marble for milk, since she is at the camp, it does not cost them the first hour of the day)
					//if amily is there, tag it for freakout
					if(flags[AMILY_FOLLOWER] > 0) {
						flags[UNKNOWN_FLAG_NUMBER_00085] = 2;
					}
					else flags[UNKNOWN_FLAG_NUMBER_00085] = 1;
					//if Izma is there, tag for freakout!
					if(flags[UNKNOWN_FLAG_NUMBER_00238] == 1) {
						flags[UNKNOWN_FLAG_NUMBER_00237] = 1;
					}
				}
			}
			//Marble didn't like you addicted
			else {
				//Replacement scene for when the player becomes addicted, Marble is ashamed, and her affection is low (<20)
				if(player.statusAffectv1("Marble") < 30) {
					//outputText("At your words, Marble's face falls completely.  She looks up at you for a moment before saying \"<i>I'm so sorry; it's my fault for not being able to refuse you.</i>\"  You hesitate, not sure how to reply to her.  She sighs and invites you to her chest.\n\n", false);
					//outputText("As you're drinking from Marble's breasts, you hear her say \"<i>Don't you ever leave my side again, sweety.  I'll make it up to you for what happened.</i>\"  As she says this an odd feeling passes through you.  For a brief instant you panic as you realize that any thought not to do as Marble asks is vanishing from your mind.  Then it passes, and without any doubt, you will be staying with Marble for the rest of your life.  There will be no more adventuring for this year's champion.  \n\n", false);
					outputText("Marble grabs you and pulls your head into her chest.  \"<i>I'm so sorry sweetie, I never meant for this to happen,</i>\" she sobs above you.   \"<i>I'll make this right, I'll make sure nothing else ever hurts you, even if I have to make you stay here with me.</i>\"  An alarm rings in your head; how are you supposed to complete your mission like this?  Marble feels you squirm, and speaks again.  \"<i>I'm sorry, [name], but if you need my milk, this is really the best way... for both of us.</i>\"");
					doNext(marbleBadEndFollowup);
					return true;
				}
				//Affection < 80, type 2:
				else if(player.statusAffectv1("Marble") < 80) {
					outputText("Marble's face falls at your words.  \"<i>I'm so sorry; it's my fault for not being able to refuse you.</i>\"  You shake your head and tell her it wasn't something either of you could stop.  Despite what you said before, what happened happened.  You two will just have to find a way to go on, regardless.  She nods and holds out her arms. You gladly move forward and accept her milk.  Once you've finished drinking, Marble looks at you and says, \"<i>I guess I'll see you tomorrow when you're thirsty again.</i>\"  You nod and return to your camp.\n", false);
					//(Marble can be encountered at the farm)
					//(every morning, the player goes to Marble for milk, it costs them the first hour of the day)
				}
				//Affection 80+, type 2:
				else {
					outputText("Marble's face falls at your words.  \"<i>I'm so sorry; it's my fault for not being able to refuse you.</i>\"  You shake your head and tell her it wasn't something either of you could stop.  Despite what you said before, what happened happened.  You care too much for her to let her feel bad about it, and you tell her you forgive her for the part she played in getting you addicted to her milk.  She bursts into tears and hugs you tightly to her breasts, before letting you drink your morning milk.  Afterwards she looks at you intently. \"<i>Can we do something special?</i>\" she asks you, suggestively.  You agree without having to give it any thought.\n\n", false);
					//(player chose yes) do after addiction sex event
					marbleAddictionSex(false);
					outputText("\n", false);
					//(Marble now appears at the camp)
					player.createStatusAffect("Camp Marble",0,0,0,0);
					if(isabellaFollower()) flags[ISABELLA_MURBLE_BLEH] = 1;
					player.createStatusAffect("No More Marble",0,0,0,0);
					//(every morning, the player goes to Marble for milk, since she is at the camp, it does not cost them the first hour of the day)
					//if amily is there, tag it for freakout
					if(flags[AMILY_FOLLOWER] > 0) {
						flags[UNKNOWN_FLAG_NUMBER_00085] = 2;
					}
					//if Izma is there, tag for freakout!
					if(flags[UNKNOWN_FLAG_NUMBER_00238] == 1) {
						flags[UNKNOWN_FLAG_NUMBER_00237] = 1;
					}
					else flags[UNKNOWN_FLAG_NUMBER_00085] = 1;
				}
			}
			outputText("\n(You gain the <b>Marble's Milk</b> perk.  It boosts your strength and toughness, but requires that you drink Marble's Milk every day.)\n", false);
			doNext(1);
			return true;
		}
		//END STUFF MOVED FROM doRest() & doSleep()
		//Raphae, the Russet Rogue!
		if(hours == 6 && flags[UNKNOWN_FLAG_NUMBER_00133] >= 0 && player.hasKeyItem("Camp - Chest") >= 0 && player.gems >= 5 && player.statusAffectv1("Tel'Adre") >= 1) {
			/*trace("RAPHAEL FINAL COUNTDOWN: " + flags[UNKNOWN_FLAG_NUMBER_00133]);
			trace("RAPHAEL MET: " + flags[UNKNOWN_FLAG_NUMBER_00134]);
			trace("RAPHAEL DRESS TIMER: " + flags[UNKNOWN_FLAG_NUMBER_00135]);
			trace("RAPHAEL DISGUSTED: " + flags[UNKNOWN_FLAG_NUMBER_00139]);*/
			
			//Countdown to finale not currently engaged!
			if(flags[UNKNOWN_FLAG_NUMBER_00133] == 0) {
				//If the PC meets his criteria!
				if(RaphaelLikes()) {
					//Not yet met!  MEETING TIEM!
					if(flags[UNKNOWN_FLAG_NUMBER_00134] == 0) {
						outputText("<b>\nSomething unusual happens that morning...</b>\n", false);
						doNext(meetRaphael);
						return true;
					}
					//Already met!
					else {
						//Not given dress yet
						if(flags[UNKNOWN_FLAG_NUMBER_00135] == 0 && flags[UNKNOWN_FLAG_NUMBER_00140] == 0) {
							outputText("<b>\nSomething unusual happens that morning...</b>\n", false);
							doNext(RaphaelDress);
							return true;
						}
						//Dress followup - Call picnic date prologue!
						if(player.armorName == "red, high-society bodysuit"  && (flags[UNKNOWN_FLAG_NUMBER_00135] > 1 && flags[UNKNOWN_FLAG_NUMBER_00135] <= 4)) {
							outputText("<b>\nSomething unusual happens that morning...</b>\n", false);
							doNext(RaphaelEncounterIIDressFollowup);
							return true;
						}
					}
				}
				//If the PC does not currently meet his criteria
				else {
					//Dress countdown - if pc isn't wearing it yet, kick out to
					//Finale!
					if(flags[UNKNOWN_FLAG_NUMBER_00135] == 1) {
						flags[UNKNOWN_FLAG_NUMBER_00135] = -1;
						flags[UNKNOWN_FLAG_NUMBER_00133] = 7;
					}
					//PC get ready for the 2nd encounter and hasn't been
					//shot down yet?
					if(flags[UNKNOWN_FLAG_NUMBER_00139] == 0 && player.armorName == "red, high-society bodysuit") {
						outputText("<b>\nSomething unusual happens that morning...</b>\n", false);
						doNext(RaphaelEncounterIIDressFollowup);
						return true;
					}
					
				}
			}
			//FINALE
			else if(flags[UNKNOWN_FLAG_NUMBER_00133] == 1) {
				outputText("<b>\nSomething unusual happens that morning...</b>\n", false);
				doNext(quiksilverFawkesEndGame);
				return true;
			}
		}
		//Cotton's cereal overlapps marbleliciousness
		if(hours == 6 && flags[UNKNOWN_FLAG_NUMBER_00245] == 1 && player.biggestLactation() >= 2) {
			flags[UNKNOWN_FLAG_NUMBER_00245] = 0;
			nomSomeTitMilkCereal();
			return true;
		}
		//Isabella's morning suckoffs!
		if(hours == 6 && isabellaFollower() && flags[ISABELLA_BLOWJOBS_DISABLED] == 0 && player.hasCock() && (days % 2 == 0 || player.hasPerk("Marble's Milk") < 0) && player.shortestCockLength() <= 9) {
			spriteSelect(31);
			isabellaMorningWakeupCall();
			return true;
		}
		//Morning Marble Meetings
		if(hours == 6 && player.hasPerk("Marble's Milk") >= 0) {
			//Marble is at camp
			if(player.hasStatusAffect("Camp Marble") >= 0) {
				postAddictionCampMornings(false);
				needNext = true;
			}
			//Marble isn't at camp
			else {
				//Marble is still available at farm
				if(player.hasStatusAffect("No More Marble") < 0) {
					postAddictionFarmMornings();
					threshhold--;
					needNext = true;
				}
			}
			doNext(1);
			return true;
		}
		//Sophie Izma 3some
		if(bimboSophie() && izmaFollower() && flags[IZMA_NO_COCK] == 0 && ((flags[TIMES_SOPHIE_AND_IZMA_FUCKED] == 0 && rand(10) == 0) || flags[TOLD_SOPHIE_TO_IZMA] == 1)) {
			flags[TOLD_SOPHIE_TO_IZMA] = 0;
			sophieAndIzmaPlay();
			return true;
		}
		if(izmaFollower() && flags[IZMA_NO_COCK] == 0 && latexGooFollower() && flags[TIMES_IZMA_DOMMED_LATEXY] == 0 && (debug || rand(10) == 0)) {
			izmaDomsLatexy();
			return true;
		}
		//Ember preg updates!
		if(emberPregUpdate()) needNext = true;
		if(flags[EMBER_INCUBATION] == 1) {
			emberGivesBirth();
			needNext = true;
		}
		//No diapause?  Normal!
		if(player.hasPerk("Diapause") < 0) {
			if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
			if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
			//Make sure pregnancy texts aren't hidden
			if(updatePregnancy()) needNext = true;
			if(flags[EVENT_PARSER_ESCAPE] == 1) {
				flags[EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			//DOUBLE PREGGERS SPEED
			if(player.hasPerk("Marae's Gift - Fertility") >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			//DOUBLE PREGGERS SPEED
			if(player.hasPerk("Magical Fertility") >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(flags[EVENT_PARSER_ESCAPE] == 1) {
				flags[EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			if(player.hasPerk("Fera's Boon - Breeding Bitch") >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(player.hasPerk("Fera's Boon - Wide Open") >= 0 || player.hasPerk("Fera's Boon - Milking Twat") >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(flags[EVENT_PARSER_ESCAPE] == 1) {
				flags[EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			//DOUBLE PREGGERS SPEED
			if(player.hasPerk("Brood Mother") >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(flags[EVENT_PARSER_ESCAPE] == 1) {
				flags[EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
		}
		//Diapause!
		else if(flags[UNKNOWN_FLAG_NUMBER_00228] > 0 && (player.pregnancyIncubation > 0 || player.buttPregnancyIncubation > 0)) {
			if(flags[UNKNOWN_FLAG_NUMBER_00229] == 1) {
				flags[UNKNOWN_FLAG_NUMBER_00229] = 0;
				outputText("\n\nYour body reacts to the influx of nutrition, accelerating your pregnancy. Your belly bulges outward slightly.", false);
				needNext = true;
			}
			if(flags[EVENT_PARSER_ESCAPE] == 1) {
				flags[EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			flags[UNKNOWN_FLAG_NUMBER_00228]--;
			if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
			if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
			//Make sure pregnancy texts aren't hidden
			if(updatePregnancy()) needNext = true;
			if(flags[EVENT_PARSER_ESCAPE] == 1) {
				flags[EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
			if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
			if(updatePregnancy()) needNext = true;
			if(flags[EVENT_PARSER_ESCAPE] == 1) {
				flags[EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
			if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
			if(updatePregnancy()) needNext = true;
			if(flags[EVENT_PARSER_ESCAPE] == 1) {
				flags[EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			//DOUBLE PREGGERS SPEED
			if(player.hasPerk("Marae's Gift - Fertility") >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			//DOUBLE PREGGERS SPEED
			if(player.hasPerk("Magical Fertility") >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(flags[EVENT_PARSER_ESCAPE] == 1) {
				flags[EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			if(player.hasPerk("Fera's Boon - Breeding Bitch") >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(player.hasPerk("Fera's Boon - Wide Open") >= 0 || player.hasPerk("Fera's Boon - Milking Twat") >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(flags[EVENT_PARSER_ESCAPE] == 1) {
				flags[EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
			//DOUBLE PREGGERS SPEED
			if(player.hasPerk("Brood Mother") >= 0) {
				if(player.pregnancyIncubation > 0) player.pregnancyIncubation--;
				if(player.buttPregnancyIncubation > 0) player.buttPregnancyIncubation--;
				//Make sure pregnancy texts aren't hidden
				if(updatePregnancy()) needNext = true;
			}
			if(flags[EVENT_PARSER_ESCAPE] == 1) {
				flags[EVENT_PARSER_ESCAPE] = 0;
				return true;
			}
		}
		//MAKE SURE PREGGERS ISNT NEGATIVE
		if(player.pregnancyIncubation < 0) player.pregnancyIncubation = 0;
		if(player.buttPregnancyIncubation < 0) player.buttPregnancyIncubation = 0;
		//Egg loot!
		if(player.hasStatusAffect("lootEgg") >= 0) {
			trace("EGG LOOT HAS");
			//default
			shortName = "BrownEg";
			//Large eggs
			if(player.statusAffects[player.hasStatusAffect("eggs")].value2 == 1) {
				if(player.statusAffects[player.hasStatusAffect("eggs")].value1 == 0) shortName = "L.BrnEg";
				if(player.statusAffects[player.hasStatusAffect("eggs")].value1 == 1) shortName = "L.PrpEg";
				if(player.statusAffects[player.hasStatusAffect("eggs")].value1 == 2) shortName = "L.BluEg";
				if(player.statusAffects[player.hasStatusAffect("eggs")].value1 == 3) shortName = "L.PnkEg";
				if(player.statusAffects[player.hasStatusAffect("eggs")].value1 == 4) shortName = "L.WhtEg";
				if(player.statusAffects[player.hasStatusAffect("eggs")].value1 == 5) shortName = "L.BlkEg";
			}
			//Small eggs
			else {
				if(player.statusAffects[player.hasStatusAffect("eggs")].value1 == 0) shortName = "BrownEg";
				if(player.statusAffects[player.hasStatusAffect("eggs")].value1 == 1) shortName = "PurplEg";
				if(player.statusAffects[player.hasStatusAffect("eggs")].value1 == 2) shortName = "BlueEgg";
				if(player.statusAffects[player.hasStatusAffect("eggs")].value1 == 3) shortName = "PinkEgg";
				if(player.statusAffects[player.hasStatusAffect("eggs")].value1 == 4) shortName = "WhiteEg";
				if(player.statusAffects[player.hasStatusAffect("eggs")].value1 == 5) shortName = "BlackEg";
			}
			player.removeStatusAffect("lootEgg");			
			player.removeStatusAffect("eggs");
			trace("TAKEY NAU");
			takeItem();
			return true;
		}
	}
	//Drop axe if too short!
	if(player.tallness < 78 && player.weaponName == "large axe") {
		outputText("<b>\nThis axe is too large for someone of your stature to use, though you can keep it in your inventory until you are big enough.</b>\n", false);
		shortName = "L. Axe ";
		player.weaponName = "fists";
		player.weaponVerb = "punch";
		player.weaponAttack = 0;
		player.weaponPerk = "";
		player.weaponValue = 0;
		takeItem();
		return true;
	}
	if(player.weaponName == "large hammer" && player.tallness < 60) {
		outputText("<b>\nYou've become too short to use this hammer anymore.  You can still keep it in your inventory, but you'll need to be taller to effectively wield it.</b>\n", true);
		shortName = "L.Hammr";
		player.weaponName = "fists";
		player.weaponVerb = "punch";
		player.weaponAttack = 0;
		player.weaponPerk = "";
		player.weaponValue = 0;
		takeItem();
		return true;
	}		
	if(player.weaponName == "large claymore" && player.str < 40) {
		outputText("\n<b>You aren't strong enough to handle the weight of your weapon any longer, and you're forced to stop using it.</b>\n", true);
		shortName = "Claymor";
		player.weaponName = "fists";
		player.weaponVerb = "punch";
		player.weaponAttack = 0;
		player.weaponPerk = "";
		player.weaponValue = 0;
		takeItem();
		return true;
	}
	if(player.weaponName == "huge warhammer" && player.str < 80) {
		outputText("\n<b>You aren't strong enough to handle the weight of your weapon any longer!</b>\n", true);
		shortName = "Warhamr";
		player.weaponName = "fists";
		player.weaponVerb = "punch";
		player.weaponAttack = 0;
		player.weaponPerk = "";
		player.weaponValue = 0;
		takeItem();
		return true;
	}
	//Drop beautiful sword if corrupted!
	if(player.weaponPerk == "holySword") {
		if(player.cor >= 35) {
			outputText("<b>\nThe <u>" + player.weaponName + "</u> grows hot in your hand, until you are forced to drop it.  Whatever power inhabits this blade appears to be unhappy with you.  Touching it gingerly, you realize it is no longer hot, but as soon as you go to grab the hilt, it nearly burns you.\n\nYou realize you won't be able to use it right now, but could probably keep it in your inventory.</b>\n\n", false);
			shortName = "B.Sword";
			player.weaponName = "fists";
			player.weaponVerb = "punch";
			player.weaponAttack = 0;
			player.weaponPerk = "";
			player.weaponValue = 0;
			takeItem();
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
			player.armorName = "comfortable underclothes";
			player.armorDef = 0;
			player.armorPerk = "";
			player.armorValue = 0;
			player.removePerk("Slutty Seduction");
			flags[BIKINI_ARMOR_BONUS] = 0;
			shortName = "LMArmor";
			takeItem();
			return true;
		}
		//Lost pussy
		else if(!player.hasVagina()) {
			outputText("\nYou fidget uncomfortably as the crease in the gusset of your lewd bikini digs into your sensitive, featureless loins.  There's simply no way you can continue to wear this outfit in comfort - it was expressly designed to press in on the female mons, and without a vagina, <b>you simply can't wear this exotic armor.</b>\n\n");
			player.armorName = "comfortable underclothes";
			player.armorDef = 0;
			player.armorPerk = "";
			player.armorValue = 0;
			player.removePerk("Slutty Seduction");
			flags[BIKINI_ARMOR_BONUS] = 0;
			shortName = "LMArmor";
			takeItem();
			return true;
		}
		//Tits gone or too small
		else if(player.biggestTitSize() < 4) {
			outputText("\nThe fine chain that makes up your lewd bikini-top is dangling slack against your flattened chest.  Every movement and step sends it jangling noisily, slapping up against your [nipples], uncomfortably cold after being separated from your " + player.skinFurScales() + " for so long.  <b>There's no two ways about it - you'll need to find something else to wear.</b>\n\n");
			player.armorName = "comfortable underclothes";
			player.armorDef = 0;
			player.armorPerk = "";
			player.armorValue = 0;
			player.removePerk("Slutty Seduction");
			flags[BIKINI_ARMOR_BONUS] = 0;
			shortName = "LMArmor";
			takeItem();
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
			trace("IMA LOOPIN", counter);
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

function cheatTime(time:Number):void {
	while(time > 0) {
		time--;
		hours++;
		if(hours > 23) {
			days++;
			hours = 0;
		}
	}
	statScreenRefresh();
}

function growHair(amount:Number = .1):Boolean {
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