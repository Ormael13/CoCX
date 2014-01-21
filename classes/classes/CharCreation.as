package classes{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.WeaponLib;

	import coc.view.MainView;

	import flash.events.MouseEvent;

	public class CharCreation extends BaseContent{

public function newGameGo(e:MouseEvent = null):void {
	funcs = [];
	args = [];
	mainView.eventTestInput.x = -10207.5;
	mainView.eventTestInput.y = -1055.1;
	hideStats();
	hideUpDown();
	mainView.nameBox.visible = true;
	mainView.nameBox.width = 165;
	mainView.hideMenuButton( MainView.MENU_NEW_MAIN );
	mainView.hideMenuButton( MainView.MENU_DATA );
	mainView.hideMenuButton( MainView.MENU_LEVEL );
	mainView.hideMenuButton( MainView.MENU_PERKS );
	//Hide perk boxes
	mainView.aCb.visible = false;
	//If first PC, track status of EZ mode and other such nonsense.
	var silly:Boolean = false;
	var easy:Boolean = false;
	var sprite:Boolean = false;
	//If at initial title
	if(flags[kFLAGS.SHOW_SPRITES_FLAG])
		sprite = true;
	if(flags[kFLAGS.EASY_MODE_ENABLE_FLAG])
		easy = true;
	if(flags[kFLAGS.SILLY_MODE_ENABLE_FLAG])
		silly = true;
	mainView.setButtonText( 0, "Newgame" ); // b1Text.text = "Newgame";
	flags[kFLAGS.CUSTOM_PC_ENABLED] = 0;

	outputText("You grew up in the small village of Ingnam, a remote village with rich traditions, buried deep in the wilds.  Every year for as long as you can remember, your village has chosen a champion to send to the cursed Demon Realm.  Legend has it that in years Ingnam has failed to produce a champion, chaos has reigned over the countryside.  Children disappear, crops wilt, and disease spreads like wildfire.  This year, <b>you</b> have been selected to be the champion.\n\nWhat is your name?", true);

	/*CODE FROM CMACLOAD HERE
	Multiple line case. A text field GeneralTextField, positioning a movieclip AskQuestions below it
	GeneralTextField.wordWrap = true;
	GeneralTextField.autoSize = true;
	GeneralTextField.htmlText = &quot;whatevevr.......&quot;;
	AskQuestions._x = GeneralTextField._x;
	AskQuestions._y = GeneralTextField._y + 3 + GeneralTextField._height;
	again replace _x, _y, _width with x, y, width*/
	//mainView.mainText.autoSize = true;

	//mainView.mainText.autoSize = TextFieldAutoSize.LEFT;
	simpleChoices("OK",10034,"",0,"",0,"",0,"",0);
	mainView.nameBox.x = mainView.mainText.x + 5;
	mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;

	//OLD
	//mainView.nameBox.x = 510;
	//mainView.nameBox.y = 265;
	mainView.nameBox.text = "";

	//Reset autosave
	player.slotName = "VOID";
	player.autoSave = false;
	//RESET DUNGEOn
	kGAMECLASS.inDungeon = false;
	kGAMECLASS.dungeonLoc = 0;
	//Hold onto old data for NG+
	var oldPlayer:Player = player;
	//Reset all standard stats
	player = new Player();
	model.player = player;
	player.str = 15;
	player.tou = 15;
	player.spe = 15;
	player.inte = 15;
	player.sens = 15;
	player.lib = 15;
	player.cor = 0;
	kGAMECLASS.notes = "No Notes Available.";
	player.lust = 15;
	player.XP = flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP];
	player.level = 1;
	player.HP = player.maxHP();
	player.gems = flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS];
	player.hairLength = 5;
	player.skinType = SKIN_TYPE_PLAIN;
	player.faceType = FACE_HUMAN;
	player.tailType = TAIL_TYPE_NONE;
	player.tongueType = TONUGE_HUMAN;
	player.femininity = 50;
	player.beardLength = 0;
	player.beardStyle = 0;
	player.tone = 50;
	player.thickness = 50;
	player.skinDesc = "skin";
	player.balls = 0;
	player.cumMultiplier = 1;
	player.ballSize = 0;
	player.hoursSinceCum = 0;
	player.clitLength = 0;
	player.ass.analLooseness = 0;
	player.ass.analWetness = 0;
	player.ass.fullness = 0;
	player.fertility = 5;
	player.fatigue = 0;
	player.horns = 0;
	player.tallness = 0;
	player.tailVenom = 0;
	player.tailRecharge = 0;
	player.wingType = WING_TYPE_NONE;
	player.wingDesc = "non-existant";
	//Exploration
	player.explored = 0;
	player.exploredForest = 0;
	player.exploredDesert = 0;
	player.exploredMountain = 0;
	player.exploredLake = 0;
	//Inventory clear
	player.itemSlot1.unlocked = true;
	player.itemSlot1.emptySlot();
	player.itemSlot2.unlocked = true;
	player.itemSlot2.emptySlot();
	player.itemSlot3.unlocked = true;
	player.itemSlot3.emptySlot();
	player.itemSlot4.unlocked = false;
	player.itemSlot4.emptySlot();
	player.itemSlot5.unlocked = false;
	player.itemSlot5.emptySlot();
	//PIERCINGS
	player.nipplesPierced = 0;
	player.nipplesPShort = "";
	player.nipplesPLong = "";
	player.lipPierced = 0;
	player.lipPShort = "";
	player.lipPLong = "";
	player.tonguePierced = 0;
	player.tonguePShort = "";
	player.tonguePLong = "";
	player.eyebrowPierced = 0;
	player.eyebrowPShort = "";
	player.eyebrowPLong = "";
	player.earsPierced = 0;
	player.earsPShort = "";
	player.earsPLong = "";
	player.nosePierced = 0;
	player.nosePShort = "";
	player.nosePLong = "";
	//PLOTZ
	kGAMECLASS.monk = 0;
	kGAMECLASS.whitney = 0;
	kGAMECLASS.sand = 0;
	kGAMECLASS.beeProgress = 0;
	kGAMECLASS.giacomo = 0;
	//Lets get this bitch started
	gameState = 0;
	//NG+ Clothes reset
	if(flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] + flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS] > 0) {
		//Clear Raphael's training variable so it does not effect
		//Weapon strength post-newgame.
		flags[kFLAGS.RAPHAEL_RAPIER_TRANING] = 0;
		player.armor= oldPlayer.armor;
		player.weapon= oldPlayer.weapon;
	}
	//Clothes clear
	else {
		player.setArmorHiddenField(armors.C_CLOTH);
		player.setWeaponHiddenField(WeaponLib.FISTS);
	}
	//Clear plot storage array!
	flags = new DefaultDict();

	//Remember silly/sprite/etc
	if(sprite) flags[kFLAGS.SHOW_SPRITES_FLAG] = 1;
	if(easy) flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 1;
	if(silly) flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = 1;
	//Set that jojo debug doesn't need to run
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00102] = 1;
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_02999] = 3;
	//Time reset
	model.time.days = 0;
	model.time.hours = 0;
	//Clear cocks
	while(player.cocks.length > 0)
	{
		player.removeCock(0,1);
		trace("1 cock purged.");
	}
	//Clear vaginas
	while(player.vaginas.length > 0)
	{
		player.removeVagina(0,1);
		trace("1 vagina purged.");
	}
	//Clear breasts
	while(player.breastRows.length > 0)
	{
		player.removeBreastRow(0,1);
		trace("1 row of breasts purged.");
	}
	//Clear Statuses
	while(player.statusAffects.length > 0) {
		player.removeStatuses();
	}
	//Clear old camp slots
	inventory.clearStorage();
	inventory.clearGearStorage();
	//Initialize gearStorage
	inventory.initializeGearStorage();
}


public function doCreation(eventNo:Number):void {
	var e:MouseEvent;
	var historyPerk:String = "";
	//MAN
	if(eventNo == 10000) {
		player.str+=3;
		player.tou+=2;
		player.balls = 2;
		player.ballSize = 1;
		player.createCock();
		player.tallness = 71;
		player.tone = 60;
		player.cocks[0].cockLength = 5.5;
		player.cocks[0].cockThickness = 1;
		player.cocks[0].cockType = CockTypesEnum.HUMAN;
		player.cocks[0].knotMultiplier = 1;
		player.createBreastRow();
		player.breastRows[0].breastRating = 0;
		outputText("\n\n\n\n\nYou are a man.  Your upbringing has provided you an advantage in strength and toughness.\n\nWhat type of build do you have?", true);
		simpleChoices("Lean", 10003, "Average", 10002, "Thick", 10005, "Girly", 10004, "", 0);
		player.gender = 1;
		player.hairLength=1;
	}
	//WOMAN
	if(eventNo == 10001) {
		player.spe+=3;
		player.inte+=2;
		player.clitLength = .5;
		player.tone = 30;
		player.fertility = 10;
		player.hairLength=10;
		player.createBreastRow();
		player.createVagina();
		player.tallness = 67;
		player.breastRows[0].breastRating = 3;
		outputText("\n\n\n\n\nYou are a woman.  Your upbringing has provided you an advantage in speed and intellect.\n\nWhat type of build do you have?", true);
		simpleChoices("Slender", 10003, "Average", 10002, "Curvy", 10005, "Tomboyish", 10006, "", 0);
		player.gender = 2;
	}
	//Average b-type
	if(eventNo == 10002) {
		if(player.gender == 1) {
			player.hipRating = 4;
			player.buttRating = 4;
			player.femininity = 30;
		}
		if(player.gender == 2) {
			player.hipRating = 6;
			player.buttRating = 6;
			player.femininity = 70;
		}
		eventParser(10007);
	}
	//lean b-type
	if(eventNo == 10003) {
		if(player.gender == 1) {
			player.hipRating = 2;
			player.buttRating = 2;
			player.femininity = 34;
			player.thickness = 30;
		}
		if(player.gender == 2) {
			player.hipRating = 6;
			player.buttRating = 2;
			player.femininity = 66;
			player.thickness = 30;
			player.tone += 5;
		}
		player.str -= 1;
		player.spe += 1;
		eventParser(10007);
	}
	//girly b-type
	if(eventNo == 10004) {
		player.hipRating = 2;
		player.buttRating = 6;
		player.breastRows[0].breastRating = 1;
		player.femininity = 50;
		eventParser(10007);
		player.str -= 2;
		player.spe += 2;
		player.tone = 26;
	}
	//thick b-type
	if(eventNo == 10005) {
		if(player.gender == 1) {
			player.hipRating = 4;
			player.buttRating = 6;
			player.spe -= 4;
			player.str += 2;
			player.tou += 2;
			player.femininity = 29;
			player.thickness = 70;
			player.tone -= 5;
		}
		if(player.gender == 2) {
			player.spe -= 2;
			player.str += 1;
			player.tou += 1;
			player.femininity = 71;
			player.hipRating = 8;
			player.buttRating = 8;
			player.thickness = 70;
			player.breastRows[0].breastRating++;
		}
		eventParser(10007);
	}
	//tomboy b-type
	if(eventNo == 10006) {
		player.femininity = 56;
		player.hipRating = 2;
		player.buttRating = 0;
		player.breastRows[0].breastRating = 2;
		player.tone = 50;
		eventParser(10007);
	}
	//Choose complexion
	if(eventNo == 10007) {
		outputText("\n\n\n\n\nWhat is your complexion?", true);
		simpleChoices("Light", 10008, "Olive", 10009, "Dark", 10010, "Ebony", 10011, "", 0);
	}
	if(eventNo == 10008) {
		player.skinTone = "light";
		eventParser(10012);
	}
	if(eventNo == 10009) {
		player.skinTone = "olive";
		eventParser(10012);
	}
	if(eventNo == 10010) {
		player.skinTone = "dark";
		eventParser(10012);
	}
	if(eventNo == 10011) {
		player.skinTone = "ebony";
		eventParser(10012);
	}
	if(eventNo == 10012) {
		outputText("\n\n\nYou selected a " + player.skinTone + " complexion.\n\nWhat color is your hair?", true);
		choices("Blonde", 10013, "Brown", 10014, "Black", 10015, "Red", 10016, "Gray", 10017, "White", 10018, "Auburn", 10019, "", 0, "", 0, "", 0);
	}
	//Set blonde hair
	if(eventNo == 10013) {
		player.hairColor = "blonde";
		eventParser(10020);
	}
	//set brown hair
	if(eventNo == 10014) {
		player.hairColor = "brown";
		eventParser(10020);
	}
	//set black hair
	if(eventNo == 10015) {
		player.hairColor = "black";
		eventParser(10020);
	}
	//set red hair
	if(eventNo == 10016) {
		player.hairColor = "red";
		eventParser(10020);
	}
	//set gray hair
	if(eventNo == 10017) {
		player.hairColor = "gray";
		eventParser(10020);
	}
	//set white hair
	if(eventNo == 10018) {
		player.hairColor = "white";
		eventParser(10020);
	}
	//set auburn hair
	if(eventNo == 10019) {
		player.hairColor = "auburn";
		eventParser(10020);
	}
	//Gender endowment choices
	if(eventNo == 10020) {
		outputText("You have " + hairDescript() + ".", true);
		outputText("\n\nEvery person is born with a gift.  What's yours?", true);
		if(player.gender == 1) choices("Strength", 10021, "Toughness", 10022, "Speed", 10023, "Smarts", 10024, "Libido", 10025, "Touch", 10026, "Big Cock", 10027, "Lots of Jizz", 10028, "", 0, "", 0);
		if(player.gender == 2) choices("Strength", 10021, "Toughness", 10022, "Speed", 10023, "Smarts", 10024, "Libido", 10025, "Touch", 10026, "Big Breasts", 10029, "Big Clit", 10030, "Fertile", 10031, "Wet Vagina", 10032);
	}
	//Strong
	if(eventNo == 10021) {
		outputText("Are you stronger than normal? (+5 Strength)\n\nStrength increases your combat damage, and your ability to hold on to an enemy or pull yourself away.\n", true);
		doYesNo(10033, 10020);
		temp = 1;
	}
	//Tough
	if(eventNo == 10022) {
		outputText("Are you unusually tough? (+5 Toughness)\n\nToughness gives you more HP and increases the chances an attack against you will fail to wound you.\n", true);
		doYesNo(10033, 10020);
		temp = 2;
	}
	//Fast
	if(eventNo == 10023) {
		outputText("Are you very quick?  (+5 Speed)\n\nSpeed makes it easier to escape combat and grapples.  It also boosts your chances of evading an enemy attack and successfully catching up to enemies who try to run.\n", true);
		doYesNo(10033, 10020);
		temp = 3;
	}
	//Smart
	if(eventNo == 10024) {
		outputText("Are you a quick learner?  (+5 Intellect)\n\nIntellect can help you avoid dangerous monsters or work with machinery.  It will also boost the power of any spells you may learn in your travels.\n", true);
		doYesNo(10033, 10020);
		temp = 4;
	}
	//Libido
	if(eventNo == 10025) {
		outputText("Do you have an unusually high sex-drive?  (+5 Libido)\n\nLibido affects how quickly your lust builds over time.  You may find a high libido to be more trouble than it's worth...\n", true);
		temp = 5;
		doYesNo(10033, 10020);
	}
	//Light Touch
	if(eventNo == 10026) {
		outputText("Is your skin unusually sensitive?  (+5 Sensitivity)\n\nSensitivity affects how easily touches and certain magics will raise your lust.  Very low sensitivity will make it difficult to orgasm.\n", true);
		temp = 6;
		doYesNo(10033, 10020);
	}
	//Big Cock
	if(eventNo == 10027) {
		outputText("Do you have a big cock?  (+2\" Cock Length)\n\nA bigger cock will make it easier to get off any sexual partners, but only if they can take your size.\n", true);
		temp = 7;
		doYesNo(10033, 10020);
	}
	//Messy Orgasms
	if(eventNo == 10028) {
		outputText("Are your orgasms particularly messy?  (+50% Cum Multiplier)\n\nA higher cum multiplier will cause your orgasms to be messier.\n", true);
		doYesNo(10033, 10020);
		temp = 8;
	}
	//Big Tits
	if(eventNo == 10029) {
		outputText("Are your breasts bigger than average? (DD cups)\n\nLarger breasts will allow you to lactate greater amounts, tit-fuck larger cocks, and generally be a sexy bitch.\n", true);
		doYesNo(10033, 10020);
		temp = 9;
	}
	//Big clit
	if(eventNo == 10030) {
		outputText("Do you have a big clit?  (1\" Long)\n\nA large enough clit may eventually become as large as a cock.  It also makes you gain lust much faster during oral or manual stimulation.\n", true);
		doYesNo(10033, 10020);
		temp = 10;
	}
	//Fertility
	if(eventNo == 10031) {
		outputText("Is your family particularly fertile?  (+15% Fertility)\n\nA high fertility will cause you to become pregnant much more easily.  Pregnancy may result in: Strange children, larger bust, larger hips, a bigger ass, and other weirdness.\n", true);
		temp = 11;
		doYesNo(10033, 10020);
	}
	//Wet pussy
	if(eventNo == 10032) {
		outputText("Does your pussy get particularly wet?  (+1 Vaginal Wetness)\n\nVaginal wetness will make it easier to take larger cocks, in turn helping you bring the well-endowed to orgasm quicker.\n", true);
		doYesNo(10033, 10020);
		temp = 12;
	}
	if(eventNo == 10033)
	{


		if(temp == 1) {
			player.str += 5;
			player.tone += 7;
			player.thickness += 3;
			//Add bonus +25% strength gain
			player.createPerk("Strong", 0.25, 0, 0, 0,"Gain strength 25% faster.");
		}
		if(temp == 2) {
			player.tou += 5;
			player.tone += 5;
			player.thickness += 5;
			player.createPerk("Tough", 0.25, 0, 0, 0,"Gain toughness 25% faster.");
			player.HP = kGAMECLASS.maxHP();
		}
		if(temp == 3) {
			player.spe += 5;
			player.tone += 10;
			player.createPerk("Fast", 0.25, 0, 0, 0,"Gain speed 25% faster.");
		}
		if(temp == 4) {
			player.inte += 5;
			player.thickness -= 5;
			player.createPerk("Smart", 0.25, 0, 0, 0,"Gain intelligence 25% faster.");
		}
		if(temp == 5) {
			player.lib += 5;
			player.createPerk("Lusty", 0.25, 0, 0, 0,"Gain lust 25% faster.");
		}
		if(temp == 6) {
			player.sens += 5;
			player.createPerk("Sensitive", 0.25, 0, 0, 0,"Gain sensitivity 25% faster.");
		}
		if(temp == 7) {
			player.femininity -= 5;
			player.cocks[0].cockLength = 8;
			player.cocks[0].cockThickness = 1.5;
			trace("Creation - cock modded to 8inches");
			player.createPerk("Big Cock", 1.25, 0, 0, 0,"Gain cock size 25% faster and grow larger easier.");
		}
		if(temp == 8) {
			player.femininity -= 2;
			player.cumMultiplier = 1.5;
			player.createPerk("Messy Orgasms", 1.25, 0, 0, 0,"Produces 50% more cum volume.");
		}
		if(temp == 9) {
			player.femininity += 5;
			player.breastRows[0].breastRating += 2;
			player.createPerk("Big Tits", 1.5, 0, 0, 0,"Makes your tits grow larger more easily.");
		}
		if(temp == 10) {
			player.femininity -= 5;
			player.clitLength = 1;
			player.createPerk("Big Clit", 1.25, 0, 0, 0,"Allows your clit to grow larger faster.");
		}
		if(temp == 11) {
			player.femininity += 5;
			player.fertility += 25;
			player.hipRating+=2;
			player.createPerk("Fertile", 1.5, 0, 0, 0,"Makes you 15% more likely to become pregnant.");
		}
		if(temp == 12) {
			player.femininity += 7;
			player.vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
			player.createPerk("Wet Pussy",2,0,0,0,"Keeps your pussy from ever being anything less than wet.");
		}
		eventParser(10036);
	}
	//Choose name
	if(eventNo == 10034)
	{
		if (kGAMECLASS.testingBlockExiting)
		{
			// We're running under the testing script.
			// Stuff a name in the box and go go go
			mainView.nameBox.text = "Derpy"
		}
		else if(mainView.nameBox.text == "")
		{

			//If part of newgame+, don't fully wipe.
			if(player.XP > 0 && player.explored == 0) {
				flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = player.XP;
				if(flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] == 0) flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = 1;
				while(player.level > 1) {
					flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] += player.level * 100;
					player.level--;
				}
				flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS] = player.gems;
			}

			newGameGo(e);
			outputText("\n\n\n<b>You must select a name.</b>", false);
			return;
		}
		else if(customName(mainView.nameBox.text)) {
			clearOutput();
			outputText("This name, like you, is special.  Do you live up to your name or continue on, assuming it to be coincidence?");
			mainView.nameBox.visible = false;
			menu();
			addButton(0,"SpecialName",useCustomProfile);
			addButton(1,"Continue On",noCustomProfile);
			return;
		}
		player.short = mainView.nameBox.text;
		mainView.nameBox.visible = false;
		outputText("\n\n\n\nAre you a man or a woman?", true);
		simpleChoices("Man", 10000, "Woman", 10001, "", 0, "", 0, "", 0);
	}
	//New Game+
	if(eventNo == 10035) {
		flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = player.XP;
		if(flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] == 0) flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = 1;
		while(player.level > 1) {
			flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] += player.level * 100;
			player.level--;
		}
		flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS] = player.gems;
		newGameGo(e);
		return;
	}
	//======================
	//  HISTORIEZ
	//======================
	if(eventNo == 10036) {
		outputText("Before you became a champion, you had other plans for your life.  What were you doing before?", true);
		choices("Alchemy",10037,"Fighting",10038,"Healing",10039,"Religion",10040,"Schooling",10041,"Slacking",10042,"Slutting",10046,"Smithing",10043,"Whoring",10047,"",0);
		return;
	}
	//Alchemy
	if(eventNo == 10037) {
		outputText("You spent some time as an alchemist's assistant, and alchemical items always seem to be more reactive in your hands.  Is this your history?", true);
		temp = 10037;
		doYesNo(10044,10036);
		return;
	}
	//Fightan'
	if(eventNo == 10038) {
		outputText("You spent much of your time fighting other children, and you had plans to find work as a guard when you grew up.  You do 10% more damage with physical attacks.  Is this your history?", true);
		temp = 10038;
		doYesNo(10044,10036);
		return;
	}
	//Healin'
	if(eventNo == 10039) {
		outputText("You often spent your free time with the village healer, learning how to tend to wounds.  Healing items and effects are 20% more effective.  Is this your history?", true);
		temp = 10039;
		doYesNo(10044,10036);
		return;
	}
	//Religions
	if(eventNo == 10040) {
		outputText("You spent a lot of time at the village temple, and learned how to meditate.  The 'masturbation' option is replaced with 'meditate' when corruption is at or below 66.  Is this your history?", true);
		temp = 10040;
		doYesNo(10044,10036);
		return;
	}
	//Scholar
	if(eventNo == 10041) {
		outputText("You spent much of your time in school, and even begged the richest man in town, Mr. Savin, to let you read some of his books.  You are much better at focusing, and spellcasting uses 20% less fatigue.  Is this your history?", true);
		temp = 10041;
		doYesNo(10044,10036);
		return;
	}
	//Slacker
	if(eventNo == 10042) {
		outputText("You spent a lot of time slacking, avoiding work, and otherwise making a nuisance of yourself.  Your efforts at slacking have made you quite adept at resting, and your fatigue comes back 20% faster.  Is this your history?", true);
		temp = 10042;
		doYesNo(10044,10036);
		return;
	}
	//Smith
	if(eventNo == 10043) {
		outputText("You managed to get an apprenticeship with the local blacksmith.  Because of your time spent at the blacksmith's side, you've learned how to fit armor for maximum protection.  Is this your history?", true);
		temp = 10043;
		doYesNo(10044,10036);
		return;
	}
	if(eventNo == 10044) {
		//Alchemist
		if(temp == 10037) historyPerk = "History: Alchemist";
		else if(temp == 10038) historyPerk = "History: Fighter";
		else if(temp == 10039) historyPerk = "History: Healer";
		else if(temp == 10040) historyPerk = "History: Religious";
		else if(temp == 10041) historyPerk = "History: Scholar";
		else if(temp == 10042) historyPerk = "History: Slacker";
		else if(temp == 10046) {
			historyPerk = "History: Slut";
			if(player.hasVagina()) {
				player.vaginas[0].virgin = false;
				player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
			}
			player.ass.analLooseness = 1;
		}
		else if(temp == 10047) {
			historyPerk = "History: Whore";
			if(player.hasVagina()) {
				player.vaginas[0].virgin = false;
				player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
			}
			player.ass.analLooseness = 1;
		}
		else historyPerk = "History: Smith";
		player.createPerk(historyPerk,0,0,0,0,"YOU GOT HISTORY BRO!");
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00418] == 0) {
			eventParser(10045);
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00418] = 1;
		}
		else {
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00418] = 1;
			eventParser(1);
		}
		return;
	}
	if(eventNo == 10045) {
		if(flags[kFLAGS.CUSTOM_PC_ENABLED] == 1) {
			clearOutput();
			flags[kFLAGS.CUSTOM_PC_ENABLED] = 0;
			kGAMECLASS.customPCSetup();
			doNext(10045);
			return;
		}
		statScreenRefresh();
		model.time.hours = 11;
		outputText("You are prepared for what is to come.  Most of the last year has been spent honing your body and mind to prepare for the challenges ahead.  You are the Champion of Ingnam.  The one who will journey to the demon realm and guarantee the safety of your friends and family, even though you'll never see them again.  You wipe away a tear as you enter the courtyard and see Elder Nomur waiting for you.  You are ready.\n\n", true);
		outputText("The walk to the tainted cave is long and silent.  Elder Nomur does not speak.  There is nothing left to say.  The two of you journey in companionable silence.  Slowly the black rock of Mount Ilgast looms closer and closer, and the temperature of the air drops.   You shiver and glance at the Elder, noticing he doesn't betray any sign of the cold.  Despite his age of nearly 80, he maintains the vigor of a man half his age.  You're glad for his strength, as assisting him across this distance would be draining, and you must save your energy for the trials ahead.\n\n", false);
		outputText("The entrance of the cave gapes open, sharp stalactites hanging over the entrance, giving it the appearance of a monstrous mouth.  Elder Nomur stops and nods to you, gesturing for you to proceed alone.\n\n", false);
		outputText("The cave is unusually warm and damp, ", false);
		if(player.gender == 2) outputText("and your body seems to feel the same way, flushing as you feel a warmth and dampness between your thighs. ", false);
		else outputText("and your body reacts with a sense of growing warmth focusing in your groin, your manhood hardening for no apparent reason. ", false);
		outputText("You were warned of this and press forward, ignoring your body's growing needs.  A glowing purple-pink portal swirls and flares with demonic light along the back wall.  Cringing, you press forward, keenly aware that your body seems to be anticipating coming in contact with the tainted magical construct.  Closing your eyes, you gather your resolve and leap forwards.  Vertigo overwhelms you and you black out...", false);
		showStats();
		dynStats("lus", +15);
		doNext(2000);
		return;
	}
	//Slut
	if(eventNo == 10046) {
		outputText("You managed to spend most of your time having sex.  Quite simply, when it came to sex, you were the village bicycle - everyone got a ride.  Because of this, your body is a bit more resistant to penetrative stretching, and has a higher upper limit on what exactly can be inserted.  Is this your history?", true);
		temp = 10046;
		doYesNo(10044,10036);
		return;
	}
	//Whore
	if(eventNo == 10047) {
		outputText("You managed to find work as a whore.  Because of your time spent trading seduction for profit, you're more effective at teasing (+15% tease damage).  Is this your history?", true);
		temp = 10047;
		doYesNo(10044,10036);
		return;
	}
	if(eventNo == 10048) {

		return;
	}
	if(eventNo == 10049) {

		return;
	}
	if(eventNo == 10050) {

		return;
	}

}

public function useCustomProfile():void {
	flags[kFLAGS.CUSTOM_PC_ENABLED] = 1;
	clearOutput();
	player.short = mainView.nameBox.text;
	mainView.nameBox.visible = false;
	if(specialName(mainView.nameBox.text)) {
		outputText("Your name defines everything about you, and as such, it is time to wake...\n\n");
		flags[kFLAGS.CUSTOM_PC_ENABLED] = 0;
		kGAMECLASS.customPCSetup();
		doNext(10045);
	}
	else {
		outputText("There is something different about you, but first, what is your basic gender?  An individual such as you may later overcome this, of course...");
		outputText("\n\n\n\nAre you a man or a woman?", true);
		simpleChoices("Man", 10000, "Woman", 10001, "", 0, "", 0, "", 0);
	}
}

public function noCustomProfile():void {
	clearOutput();
	flags[kFLAGS.CUSTOM_PC_ENABLED] = -1;
	player.short = mainView.nameBox.text;
	mainView.nameBox.visible = false;
	outputText("Your name carries little significance beyond it being your name.  What is your gender?");
	simpleChoices("Male", 10000, "Female", 10001, "", 0, "", 0, "", 0);
}

//Determines if has character creation bonuses
public function customName(arg:String):Boolean {
	switch(arg) {
		case "Mara":
		case "Mirvanna":
		case "Sera":
		case "Gundam":
		case "Tyriana":
		case "Katti":
		case "Annetta":
		case "Cody":
		case "Charlie":
		case "Rope":
		case "Isaac":
		case "Hikari":
		case "Navorn":
		case "Charaun":
		case "Rann Rayla":
		case "Lucina":
		case "Aria":
		case "Mihari":
		case "Prismere":
		case "Ceveo":
		case "Nami":
		case "Betram":
		case "Siveen":
		case "Galatea":
		case "Nixi":
		case "Sora":
		case "Lukaz":
		case "Leah":
		case "Vahdunbrii":
			return true;
		default:
			return false;
	}
	return false;
}
//Does PC skip creation?
public function specialName(arg:String):Boolean {
	switch(arg) {
		case "Ceveo":
		case "Mara":
		case "Mirvanna":
		case "Sera":
		case "Tyriana":
		case "Annetta":
		case "Charlie":
		case "Isaac":
		case "Rann Rayla":
		case "Mihari":
		case "Prismere":
		case "Nami":
		case "Siveen":
		case "Nixi":
		case "Lukaz":
		case "Leah":
		case "Vahdunbrii":
			return true;
		default:
			return false;
	}
	return false;
}





}
}