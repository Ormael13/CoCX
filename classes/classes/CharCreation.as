package classes{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Armors.GooArmor;
	import classes.Items.WeaponLib;
	import classes.Saves;

	import coc.view.MainView;

	import flash.events.MouseEvent;

	public class CharCreation extends BaseContent{

	//Hacky solution
	public var unlockedHerm:Boolean = false;
	
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
	var oldUI:Boolean = false;
	//If at initial title
	if(flags[kFLAGS.SHOW_SPRITES_FLAG])
		sprite = true;
	if(flags[kFLAGS.EASY_MODE_ENABLE_FLAG])
		easy = true;
	if(flags[kFLAGS.SILLY_MODE_ENABLE_FLAG])
		silly = true;
	if(flags[kFLAGS.USE_OLD_INTERFACE])
		oldUI = true;
	if(flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM])
		unlockedHerm = true;
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
	simpleChoices("OK",confirmName,"",0,"",0,"",0,"",0);
	mainView.nameBox.x = mainView.mainText.x + 5;
	mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;

	//OLD
	//mainView.nameBox.x = 510;
	//mainView.nameBox.y = 265;
	mainView.nameBox.text = "";
	mainView.nameBox.maxChars = 16;
	//Reset autosave
	player.slotName = "VOID";
	player.autoSave = false;
	//RESET DUNGEON
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
	player.cor = 15; 
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
	//Default
	player.skinTone = "light";
	player.hairColor = "brown";
	player.beardLength = 0;
	player.beardStyle = 0;
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
	if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS] != 0) 
	{
		//Clear Raphael's training variable so it does not effect
		//Weapon strength post-newgame.
		flags[kFLAGS.RAPHAEL_RAPIER_TRANING] = 0;
		
		if (!(oldPlayer.armor is GooArmor))
		{
			player.armor = oldPlayer.armor;
		}
		else
		{
			player.setArmorHiddenField(armors.C_CLOTH);
		}
			
		player.setWeaponHiddenField(oldPlayer.weapon);
	}
	//Clothes clear
	else {
		player.setArmorHiddenField(armors.C_CLOTH);
		player.setWeaponHiddenField(WeaponLib.FISTS);
	}
	if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] == 1)
	{
		unlockedHerm = true;
	}
	else
	{
		unlockedHerm = false;
	}
	//Clear plot storage array!
	flags = new DefaultDict();

	//Remember silly/sprite/etc
	if(sprite) flags[kFLAGS.SHOW_SPRITES_FLAG] = 1;
	if(easy) flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 1;
	if(silly) flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = 1;
	if(oldUI) flags[kFLAGS.USE_OLD_INTERFACE] = 1;
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
	player.breastRows = [];
	
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

//Choose Hardcore slot.
private function chooseSlotHardcore(num:int):void {
	flags[kFLAGS.HARDCORE_SLOT] = "CoC_" + num;
	startTheGame();
}	

//-----------------
//-- GAME MODES
//-----------------
private function chooseModeNormal():void {
	outputText("You have chosen Normal Mode. This is a classic gameplay mode.", true)
	flags[kFLAGS.HARDCORE_MODE] = 0;
	flags[kFLAGS.HUNGER_ENABLED] = 0;
	doNext(startTheGame);
}	

private function chooseModeSurvival():void {
	outputText("You have chosen Survival Mode. This is similar to the normal mode but with hunger enabled.", true)
	flags[kFLAGS.HARDCORE_MODE] = 0;
	flags[kFLAGS.HUNGER_ENABLED] = 0.5;
	player.hunger = 80;
	doNext(startTheGame);
}	

private function chooseModeRealistic():void {
	outputText("You have chosen Realistic Mode. In this mode, hunger is enabled so you have to eat periodically. Also, your cum production is capped and having oversized parts will weigh you down.", true)
	flags[kFLAGS.HARDCORE_MODE] = 0;
	flags[kFLAGS.HUNGER_ENABLED] = 1;
	player.hunger = 80;
	doNext(startTheGame);
}	

private function chooseModeHardcore():void {
	outputText("You have chosen Hardcore Mode. In this mode, hunger is enabled so you have to eat periodically. In addition, the game forces autosave and if you encounter a Bad End, your save file is <b>DELETED</b>! \n\nDebug Mode and Easy Mode are disabled in this game mode. \n\nPlease choose a slot to save in. You may not make multiple copies of saves. ", true)
	flags[kFLAGS.HARDCORE_MODE] = 1;
	flags[kFLAGS.HUNGER_ENABLED] = 1;
	player.hunger = 80;
	menu()
	addButton(0, "Slot 1", chooseSlotHardcore, 1);
	addButton(1, "Slot 2", chooseSlotHardcore, 2);
	addButton(2, "Slot 3", chooseSlotHardcore, 3);
	addButton(3, "Slot 4", chooseSlotHardcore, 4);
	addButton(4, "Slot 5", chooseSlotHardcore, 5);
	addButton(5, "Slot 6", chooseSlotHardcore, 6);
	addButton(6, "Slot 7", chooseSlotHardcore, 7);
	addButton(7, "Slot 8", chooseSlotHardcore, 8);
	addButton(8, "Slot 9", chooseSlotHardcore, 9);
	addButton(9, "Back", chooseGameModes);
}	

//Choose the game mode when called!
private function chooseGameModes():void {
	outputText("Choose a game mode.\n\n", true);
	outputText("<b>Normal mode:</b> Classic Corruption of Champions gameplay.\n", false);
	outputText("<b>Survival mode:</b> Like normal but with hunger enabled.\n", false);
	outputText("<b>Realistic mode:</b> You get hungry from time to time and cum production is capped. In addition, it's a bad idea to have oversized parts. \n", false);
	outputText("<b>Hardcore mode:</b> In addition to Realistic mode, the game forces save and if you get a Bad End, your save file is deleted. For the veteran CoC players only.\n", false);
	
	simpleChoices("Normal", chooseModeNormal, "Survival", chooseModeSurvival, "Realistic", chooseModeRealistic, "Hardcore", chooseModeHardcore, "", 0);
}	

//-----------------
//-- GENDER CHOICES
//-----------------
private function chooseMale():void {
	player.gender = 1;
	//Attributes
	player.str += 3;
	player.tou += 2;
	//Body attributes
	player.tallness = 71;
	player.tone = 60;
	player.hairLength = 1;
	player.beardLength = 0.2;
	//Genetalia
	player.balls = 2;
	player.ballSize = 1;
	player.createCock();
	player.cocks[0].cockLength = 5.5;
	player.cocks[0].cockThickness = 1;
	player.cocks[0].cockType = CockTypesEnum.HUMAN;
	player.cocks[0].knotMultiplier = 1;
	//Breasts
	player.createBreastRow();	
	player.breastRows[0].breastRating = 0;
	//Choices
	outputText("\n\nYou are a man.  Your upbringing has provided you an advantage in strength and toughness.\n\nWhat type of build do you have?", true);
	simpleChoices("Lean", chooseBodyTypeLean, "Average", chooseBodyTypeAverage, "Thick", chooseBodyTypeThick, "Girly", chooseBodyTypeGirlyOrTomboyish, "Dickgirl", chooseBodyTypeDickgirlOrCuntboy);
}
private function chooseFemale():void {
	player.gender = 2;
	//Attributes
	player.spe+=3;
	player.inte+= 2;
	//Body attributes
	player.tallness = 67;
	player.tone = 30;
	player.hairLength = 10;
	player.fertility = 10;
	//Genetalia
	player.createVagina();
	player.clitLength = .5;
	//Breasts
	player.createBreastRow();
	player.breastRows[0].breastRating = 3;
	//Choices
	outputText("\n\nYou are a woman.  Your upbringing has provided you an advantage in speed and intellect.\n\nWhat type of build do you have?", true);
	simpleChoices("Slender", chooseBodyTypeLean, "Average", chooseBodyTypeAverage, "Curvy", chooseBodyTypeThick, "Tomboyish", chooseBodyTypeGirlyOrTomboyish, "Cuntboi", chooseBodyTypeDickgirlOrCuntboy);
}
private function chooseHerm():void {
	player.gender = 3;
	//Attributes
	player.str+=1;
	player.tou+=1;
	player.spe+=1;
	player.inte+= 1;
	//Body attributes
	player.tallness = 69;
	player.tone = 45;
	player.hairLength = 10;
	player.fertility = 10;
	//Genetalia
	player.createVagina();
	player.clitLength = .5;
	player.createCock();
	player.cocks[0].cockLength = 5.5;
	player.cocks[0].cockThickness = 1;
	player.cocks[0].cockType = CockTypesEnum.HUMAN;
	player.cocks[0].knotMultiplier = 1;
	//Breasts
	player.createBreastRow();
	player.breastRows[0].breastRating = 2;
	//Choices
	outputText("\n\nYou are a hermaphrodite.  Your upbringing has provided you an average in stats.\n\nWhat type of build do you have?", true);
	simpleChoices("Slender", chooseBodyTypeLean, "Average", chooseBodyTypeAverage, "Curvy", chooseBodyTypeThick, "Masculine", chooseMasculineHerm, "Feminine", chooseFeminineHerm);
}

//-----------------
//-- BODY BUILDS
//-----------------
private function chooseBodyTypeLean():void {
	//lean b-type
	if (player.gender == 1) {
		//Body modifiers
		player.hipRating = 2;
		player.buttRating = 2;
		player.femininity = 34;
		player.thickness = 30;
	}
	if (player.gender == 2) {
		//Body modifiers
		player.hipRating = 6;
		player.buttRating = 2;
		player.femininity = 66;
		player.thickness = 30;
		player.tone += 5;
	}
	//Attribute modifiers
	player.str -= 1;
	player.spe += 1;
	genericStyleCustomizeMenu();
}
private function chooseBodyTypeAverage():void {
	//Average b-type
	if (player.gender == 1) {
		//Body modifiers
		player.hipRating = 4;
		player.buttRating = 4;
		player.femininity = 30;
	}
	if (player.gender == 2) {
		//Body modifiers
		player.hipRating = 6;
		player.buttRating = 6;
		player.femininity = 70;
	}
	genericStyleCustomizeMenu();
}
private function chooseBodyTypeThick():void {
	if (player.gender == 1) {
		//Body modifiers
		player.hipRating = 4;
		player.buttRating = 6;
		player.femininity = 29;
		player.thickness = 70;
		player.tone -= 5;
		//Attribute modifiers
		player.spe -= 4;
		player.str += 2;
		player.tou += 2;
	}
	if (player.gender == 2) {
		//Body modifiers
		player.hipRating = 8;
		player.buttRating = 8;
		player.femininity = 71;
		player.thickness = 70;
		player.breastRows[0].breastRating++;
		//Attribute modifiers
		player.spe -= 2;
		player.str += 1;
		player.tou += 1;
	}
	genericStyleCustomizeMenu();
}
private function chooseBodyTypeGirlyOrTomboyish():void {
	if (player.gender == 1) {
		//Body modifiers
		player.hipRating = 2;
		player.buttRating = 6;
		player.femininity = 50;
		player.tone = 26;
		player.breastRows[0].breastRating = 1;
		//Attribute modifiers
		player.str -= 2;
		player.spe += 2;
	}
	if (player.gender == 2) {
		//Body modifiers
		player.hipRating = 2;
		player.buttRating = 0;
		player.femininity = 56;
		player.tone = 50;
		player.breastRows[0].breastRating = 2;
	}
	genericStyleCustomizeMenu();
}
private function chooseBodyTypeDickgirlOrCuntboy():void {
	if (player.gender == 1) {
		//Body modifiers
		player.hipRating = 6;
		player.buttRating = 6;
		player.femininity = 70;
		player.thickness = 40;
		player.hairLength = 10;	
		player.breastRows[0].breastRating = 3;
		//Attribute modifiers
		player.str -= 1;
	}
	if (player.gender == 2) {
		//Body modifiers
		player.hipRating = 2;
		player.buttRating = 0;
		player.femininity = 35;
		player.thickness = 30;
		player.hairLength = 2;
		player.breastRows[0].breastRating = 0;
		player.nippleLength = 0.2
		player.tone += 5;
		//Attribute modifiers
		player.str += 1;
	}
	genericStyleCustomizeMenu();
}
private function chooseAndrogynousHerm():void {
		player.femininity = 50;
		player.hipRating = 4;
		player.buttRating = 2;
		player.hairLength = 5;
		player.tone = 50;
		player.breastRows[0].breastRating = 1;
	genericStyleCustomizeMenu();
}
private function chooseMasculineHerm():void {
		player.femininity = 30;
		player.hipRating = 2;
		player.buttRating = 0;
		player.hairLength = 1;
		player.tone = 50;
		player.breastRows[0].breastRating = 0;
		player.balls = 2;
		player.ballSize = 1;
	genericStyleCustomizeMenu();
}
private function chooseFeminineHerm():void {
		player.femininity = 70;
		player.hipRating = 4;
		player.buttRating = 6;
		player.hairLength = 10;
		player.tone = 50;
		player.breastRows[0].breastRating = 3;
	genericStyleCustomizeMenu();
}

//-----------------
//-- GENERAL STYLE
//-----------------
private function genericStyleCustomizeMenu():void {
	clearOutput();
	mainView.nameBox.visible = false;
	outputText("Choose a skin complexion, hair color, and set your height before you proceed.\n\n");
	outputText("Height: " + Math.floor(player.tallness / 12) + "'" + player.tallness % 12 + "\"\n");
	outputText("Skin tone: " + player.skinTone + "\n");
	outputText("Hair color: " + player.hairColor + "\n");
	menu();
	addButton(0, "Complexion", menuSkinComplexion);
	addButton(1, "Hair Color", menuHairColor);
	if (player.mf("m", "f") == "m") {
		if (player.hasBeard()) {
			outputText("Beard: " + player.beardDescript() + "\n");
		}
		addButton(2, "Beard Style", menuBeardSettings);
	}
	addButton(3, "Set Height", setHeight);
	addButton(9, "Done", menuPerk);
}

//-----------------
//-- SKIN COLOURS
//-----------------
private function menuSkinComplexion():void {
	outputText("What is your complexion?", true);
	choices("Light", chooseComplexionLight, "Olive", chooseComplexionOlive, "Dark", chooseComplexionDark, "Ebony", chooseComplexionEbony, "", 0, "", 0, "", 0, "", 0, "", 0, "Back", genericStyleCustomizeMenu);	
}	

private function chooseComplexionLight():void {
	player.skinTone = "light";
	genericStyleCustomizeMenu();
}
private function chooseComplexionOlive():void {
	player.skinTone = "olive";
	genericStyleCustomizeMenu();
}
private function chooseComplexionDark():void {
	player.skinTone = "dark";
	genericStyleCustomizeMenu();
}	
private function chooseComplexionEbony():void {
	player.skinTone = "ebony";
	genericStyleCustomizeMenu();
}	

//-----------------
//-- HAIR COLOURS
//-----------------
private function menuHairColor():void {
	outputText("What is your hair color?", true);
	choices("Blonde", chooseHairBlonde, "Brown", chooseHairBrown, "Black", chooseHairBlack, "Red", chooseHairRed, "Gray", chooseHairGray, "White", chooseHairWhite, "Auburn", chooseHairAuburn, "", 0, "", 0, "Back", genericStyleCustomizeMenu);
}	

private function chooseHairBlonde():void {
	player.hairColor = "blonde";
	genericStyleCustomizeMenu();
}
private function chooseHairBrown():void {
	player.hairColor = "brown";
	genericStyleCustomizeMenu();
}
private function chooseHairBlack():void {
	player.hairColor = "black";
	genericStyleCustomizeMenu();
}
private function chooseHairRed():void {
	player.hairColor = "red";
	genericStyleCustomizeMenu();
}
private function chooseHairGray():void {
	player.hairColor = "gray";
	genericStyleCustomizeMenu();
}
private function chooseHairWhite():void {
	player.hairColor = "white";
	genericStyleCustomizeMenu();
}
private function chooseHairAuburn():void {
	player.hairColor = "auburn";
	genericStyleCustomizeMenu();
}

//-----------------
//-- BEARD STYLE
//-----------------
private function menuBeardSettings():void {
	outputText("You can choose your beard length and style.\n\n", true)
	outputText("Beard: " + player.beardDescript())
	menu()
	addButton(0, "Style", menuBeardStyle);
	addButton(1, "Length", menuBeardLength);
	addButton(4, "Back", genericStyleCustomizeMenu);
}
private function menuBeardStyle():void {
	outputText("What beard style would you like?", true);
	menu();
	addButton(0, "Normal", chooseBeardStyle, 0);
	addButton(1, "Goatee", chooseBeardStyle, 1);
	addButton(2, "Clean-cut", chooseBeardStyle, 2);
	addButton(3, "Mountainman", chooseBeardStyle, 3);
	addButton(9, "Back", menuBeardSettings);
}
private function chooseBeardStyle(choiceStyle:int = 0):void {
	player.beardStyle = choiceStyle;
	menuBeardSettings();
}
private function menuBeardLength():void {
	outputText("How long would you like your beard be? \n\nNote: Beard will slowly grow over time, just like in the real world. Unless you have no beard. You can change your beard style later in th game.", true);
	menu();
	addButton(0, "No Beard", chooseBeardLength, 0);
	addButton(1, "Trim", chooseBeardLength, 0.1);
	addButton(2, "Short", chooseBeardLength, 0.2);
	addButton(3, "Medium", chooseBeardLength, 0.5);
	addButton(4, "Mod. Long", chooseBeardLength, 1.5);
	addButton(5, "Long", chooseBeardLength, 3);
	addButton(6, "Very Long", chooseBeardLength, 6);
	addButton(9, "Back", chooseBeardLength);
}
private function chooseBeardLength(choiceLength:Number = 0):void {
	player.beardLength = choiceLength;
	menuBeardSettings();
}
//-----------------
//-- HEIGHT
//-----------------
private function setHeight():void {
	menu();
	if (kGAMECLASS.testingBlockExiting)
	{
		// We're running under the testing script.
		// Stuff a number in the box and go go go
		mainView.nameBox.text = "69";
	}
	outputText("\n\nSet your height in inches.", false)
	outputText("\nYou can choose any height between 4 feet (48 inches) and 8 feet (96 inches).", false)
	mainView.nameBox.visible = true;
	mainView.nameBox.maxChars = 2;
	mainView.nameBox.restrict = "0-9";
	if (player.gender == 0)
	{
		mainView.nameBox.text = "69";
	}
	if (player.gender == 1)
	{
		mainView.nameBox.text = "71";
	}
	if (player.gender == 2)
	{
		mainView.nameBox.text = "67";
	}	
	if (player.gender == 3)
	{
		mainView.nameBox.text = "69";
	}	
	choices("OK", confirmHeight, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "Back", genericStyleCustomizeMenu);
	mainView.nameBox.x = mainView.mainText.x + 5;
	mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
}
private function confirmHeight():void {
	mainView.nameBox.visible = false;
	if (int(mainView.nameBox.text) < 48)
	{
		outputText("That is below your minimum height choices!", true)
		//Off to the height selection!
		doNext(setHeight);
		return;
	}
	if (int(mainView.nameBox.text) > 96)
	{
		outputText("That is above your maximum height choices!", true)
		//Off to the height selection!
		doNext(setHeight);
		return;
	}
	if (mainView.nameBox.text == "")
	{
		outputText("Please input your height. Off you go to the height selection!", true)
		//Off to the height selection!
		doNext(setHeight);
		return;
	}
	player.tallness = int(mainView.nameBox.text)
	mainView.nameBox.maxChars = 16;
	mainView.nameBox.restrict = null;
	outputText("You'll be " + Math.floor(player.tallness / 12) + " feet and " + player.tallness % 12 + " inches tall. Is this okay with you?", true)
	doYesNo(genericStyleCustomizeMenu, setHeight);
}	

//-----------------
//-- STARTER PERKS
//-----------------
private function menuPerk():void {
	choices("", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0);
	outputText("\n\nEvery person is born with a gift.  What's yours?", true);
	addButton(0, "Strength", choosePerkStrength);
	addButton(1, "Toughness", choosePerkToughness);
	addButton(2, "Speed", choosePerkSpeed);
	addButton(3, "Smarts", choosePerkIntelligence);
	
	addButton(5, "Libido", choosePerkLibido);
	addButton(6, "Touch", choosePerkSensitivity);
	addButton(7, "Perversion", choosePerkCorruptionYouMonster);

	addButton(4, "Next", menuPerkII);
	addButton(9, "Back", genericStyleCustomizeMenu);
}	

private function menuPerkII():void {
	choices("", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0, "", 0);
	if (player.gender == 1)
	{
		addButton(0, "Big Cock", choosePerkBigCock);
		addButton(1, "Lots of Jizz", choosePerkMessyOrgasms);
	}
	if (player.gender == 2)
	{
		addButton(0, "Big Breasts", choosePerkBigBoobs);
		addButton(1, "Big Clit", choosePerkBigClit);
		addButton(2, "Fertile", choosePerkFertile);
		addButton(3, "Wet Vagina", choosePerkWetgina);
	}
	if (player.gender == 3)
	{
		addButton(0, "Big Cock", choosePerkBigCock);
		addButton(1, "Lots of Jizz", choosePerkMessyOrgasms);
		addButton(2, "Big Breasts", choosePerkBigBoobs);
		addButton(3, "Big Clit", choosePerkBigClit);
		
		addButton(5, "Fertile", choosePerkFertile);
		addButton(6, "Wet Vagina", choosePerkWetgina);
	}
	addButton(4, "Previous", menuPerk);
	addButton(9, "Back", setHeight);
}

private function choosePerkStrength():void {
	outputText("Are you stronger than normal? (+5 Strength)\n\nStrength increases your combat damage, and your ability to hold on to an enemy or pull yourself away.\n", true);
	doYesNo(confirmPerk, menuPerk);
	temp = 1;	
}	
private function choosePerkToughness():void {
	outputText("Are you unusually tough? (+5 Toughness)\n\nToughness gives you more HP and increases the chances an attack against you will fail to wound you.\n", true);
	doYesNo(confirmPerk, menuPerk);
	temp = 2;
}	
private function choosePerkSpeed():void {
	outputText("Are you very quick?  (+5 Speed)\n\nSpeed makes it easier to escape combat and grapples.  It also boosts your chances of evading an enemy attack and successfully catching up to enemies who try to run.\n", true);
	doYesNo(confirmPerk, menuPerk);
	temp = 3;
}	
private function choosePerkIntelligence():void {
	outputText("Are you a quick learner?  (+5 Intellect)\n\nIntellect can help you avoid dangerous monsters or work with machinery.  It will also boost the power of any spells you may learn in your travels.\n", true);
	doYesNo(confirmPerk, menuPerk);
	temp = 4;
}
private function choosePerkLibido():void {
	outputText("Do you have an unusually high sex-drive?  (+5 Libido)\n\nLibido affects how quickly your lust builds over time.  You may find a high libido to be more trouble than it's worth...\n", true);
	temp = 5;
	doYesNo(confirmPerk, menuPerk);
}
private function choosePerkSensitivity():void {
	outputText("Is your skin unusually sensitive?  (+5 Sensitivity)\n\nSensitivity affects how easily touches and certain magics will raise your lust.  Very low sensitivity will make it difficult to orgasm.\n", true);
	temp = 6;
	doYesNo(confirmPerk, menuPerk);
}
private function choosePerkCorruptionYouMonster():void {
	outputText("Are you unusually perverted?  (+5 Corruption)\n\Corruption affects certain scenes and having a higher corruption makes you more prone to Bad Ends.\n", true);
	temp = 13;
	doYesNo(confirmPerk, menuPerk);
}	
private function choosePerkBigCock():void {
	outputText("Do you have a big cock?  (+2\" Cock Length)\n\nA bigger cock will make it easier to get off any sexual partners, but only if they can take your size.\n", true);
	temp = 7;
	doYesNo(confirmPerk, menuPerk);
}
private function choosePerkMessyOrgasms():void {
	outputText("Are your orgasms particularly messy?  (+50% Cum Multiplier)\n\nA higher cum multiplier will cause your orgasms to be messier.\n", true);
	doYesNo(confirmPerk, menuPerk);
	temp = 8;
}
private function choosePerkBigBoobs():void {
	outputText("Are your breasts bigger than average? (DD cups)\n\nLarger breasts will allow you to lactate greater amounts, tit-fuck larger cocks, and generally be a sexy bitch.\n", true);
	doYesNo(confirmPerk, menuPerk);
	temp = 9;
}
private function choosePerkBigClit():void {
	outputText("Do you have a big clit?  (1\" Long)\n\nA large enough clit may eventually become as large as a cock.  It also makes you gain lust much faster during oral or manual stimulation.\n", true);
	doYesNo(confirmPerk, menuPerk);
	temp = 10;
}
private function choosePerkFertile():void {
	outputText("Is your family particularly fertile?  (+15% Fertility)\n\nA high fertility will cause you to become pregnant much more easily.  Pregnancy may result in: Strange children, larger bust, larger hips, a bigger ass, and other weirdness.\n", true);
	temp = 11;
	doYesNo(confirmPerk, menuPerk);
}
private function choosePerkWetgina():void {
	outputText("Does your pussy get particularly wet?  (+1 Vaginal Wetness)\n\nVaginal wetness will make it easier to take larger cocks, in turn helping you bring the well-endowed to orgasm quicker.\n", true);
	doYesNo(confirmPerk, menuPerk);
	temp = 12;
}

private function confirmPerk():void {
	if(temp == 1) {
		player.str += 5;
		player.tone += 7;
		player.thickness += 3;
		//Add bonus +25% strength gain
		player.createPerk(PerkLib.Strong, 0.25, 0, 0, 0);
	}
	if(temp == 2) {
		player.tou += 5;
		player.tone += 5;
		player.thickness += 5;
		player.createPerk(PerkLib.Tough, 0.25, 0, 0, 0);
		player.HP = kGAMECLASS.maxHP();
	}
	if(temp == 3) {
		player.spe += 5;
		player.tone += 10;
		player.createPerk(PerkLib.Fast, 0.25, 0, 0, 0);
	}
	if(temp == 4) {
		player.inte += 5;
		player.thickness -= 5;
		player.createPerk(PerkLib.Smart, 0.25, 0, 0, 0);
	}
	if(temp == 5) {
		player.lib += 5;
		player.createPerk(PerkLib.Lusty, 0.25, 0, 0, 0);
	}
	if(temp == 6) {
		player.sens += 5;
		player.createPerk(PerkLib.Sensitive, 0.25, 0, 0, 0);
	}
	if(temp == 7) {
		player.femininity -= 5;
		player.cocks[0].cockLength = 8;
		player.cocks[0].cockThickness = 1.5;
		player.createPerk(PerkLib.BigCock, 1.25, 0, 0, 0);
	}
	if(temp == 8) {
		player.femininity -= 2;
		player.cumMultiplier = 1.5;
		player.createPerk(PerkLib.MessyOrgasms, 1.25, 0, 0, 0);
	}
	if(temp == 9) {
		player.femininity += 5;
		player.breastRows[0].breastRating += 2;
		player.createPerk(PerkLib.BigTits, 1.5, 0, 0, 0);
	}
	if(temp == 10) {
		player.femininity -= 5;
		player.clitLength = 1;
		player.createPerk(PerkLib.BigClit, 1.25, 0, 0, 0);
	}
	if(temp == 11) {
		player.femininity += 5;
		player.fertility += 25;
		player.hipRating+=2;
		player.createPerk(PerkLib.Fertile, 1.5, 0, 0, 0);
	}
	if(temp == 12) {
		player.femininity += 7;
		player.vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
		player.createPerk(PerkLib.WetPussy,2,0,0,0);
	}	
	if(temp == 13) {
		player.cor += 5;
		player.createPerk(PerkLib.Pervert,0.25,0,0,0);
	}	
	menuHistory();
}

//-----------------
//-- HISTORY PERKS
//-----------------
private function menuHistory():void {
	outputText("Before you became a champion, you had other plans for your life.  What were you doing before?", true);
	choices("Alchemy",chooseHistoryAlchemy,"Fighting",chooseHistoryFighting,"Healing",chooseHistoryHealing,"Religion",chooseHistoryReligion,"Schooling",chooseHistorySchooling,"Slacking",chooseHistorySlacking,"Smithing",chooseHistorySmithing,"Slutting",chooseHistorySlutting,"Whoring",chooseHistoryWhoring,"Fortune",chooseHistoryFortune);
}

private function chooseHistoryAlchemy():void {
	outputText("You spent some time as an alchemist's assistant, and alchemical items always seem to be more reactive in your hands.  Is this your history?", true);
	temp = 11;
	doYesNo(confirmHistory, menuHistory);
}
private function chooseHistoryFighting():void {
	outputText("You spent much of your time fighting other children, and you had plans to find work as a guard when you grew up.  You do 10% more damage with physical attacks.  Is this your history?", true);
	temp = 12;
	doYesNo(confirmHistory, menuHistory);
}
private function chooseHistoryHealing():void {
	outputText("You often spent your free time with the village healer, learning how to tend to wounds.  Healing items and effects are 20% more effective.  Is this your history?", true);
	temp = 13;
	doYesNo(confirmHistory,menuHistory);
}
private function chooseHistoryReligion():void {
	outputText("You spent a lot of time at the village temple, and learned how to meditate.  The 'masturbation' option is replaced with 'meditate' when corruption is at or below 66.  Is this your history?", true);
	temp = 14;
	doYesNo(confirmHistory,menuHistory);
}
private function chooseHistorySchooling():void {
	outputText("You spent much of your time in school, and even begged the richest man in town, Mr. Savin, to let you read some of his books.  You are much better at focusing, and spellcasting uses 20% less fatigue.  Is this your history?", true);
	temp = 15;
	doYesNo(confirmHistory,menuHistory);
}
private function chooseHistorySlacking():void {
	outputText("You spent a lot of time slacking, avoiding work, and otherwise making a nuisance of yourself.  Your efforts at slacking have made you quite adept at resting, and your fatigue comes back 20% faster.  Is this your history?", true);
	temp = 16;
	doYesNo(confirmHistory,menuHistory);
}
private function chooseHistorySmithing():void {
	outputText("You managed to get an apprenticeship with the local blacksmith.  Because of your time spent at the blacksmith's side, you've learned how to fit armor for maximum protection.  Is this your history?", true);
	temp = 17;
	doYesNo(confirmHistory,menuHistory);
}
private function chooseHistorySlutting():void {
	outputText("You managed to spend most of your time having sex.  Quite simply, when it came to sex, you were the village bicycle - everyone got a ride.  Because of this, your body is a bit more resistant to penetrative stretching, and has a higher upper limit on what exactly can be inserted.  Is this your history?", true);
	temp = 18;
	doYesNo(confirmHistory,menuHistory);
}
private function chooseHistoryWhoring():void {
	outputText("You managed to find work as a whore.  Because of your time spent trading seduction for profit, you're more effective at teasing (+15% tease damage).  Is this your history?", true);
	temp = 19;
	doYesNo(confirmHistory, menuHistory);
}
private function chooseHistoryFortune():void {
	outputText("You always feel lucky when it comes to fortune.  Because of that, you have always managed to save up gems until whatever's needed and how to make the most out it (+15% gems on victory).  Is this your history?", true);
	temp = 20;
	doYesNo(confirmHistory, menuHistory);
}

private function confirmHistory():void {
	outputText("", true)
	var historyPerk:*
	if(temp == 11) historyPerk = PerkLib.HistoryAlchemist;
	else if (temp == 12) historyPerk = PerkLib.HistoryFighter;
	else if (temp == 13) historyPerk = PerkLib.HistoryHealer;
	else if (temp == 14) {
		historyPerk = PerkLib.HistoryReligious;
		player.cor = 0;
	}
	else if (temp == 15) historyPerk = PerkLib.HistoryScholar;
	else if (temp == 16) historyPerk = PerkLib.HistorySlacker;
	else if (temp == 17) historyPerk = PerkLib.HistorySmith;
	//Slut or whore? Start as non-virgin!
	else if (temp == 18) {
		outputText("Because of your history perk, you will start out as a non-virgin. \n\n", true);
		historyPerk = PerkLib.HistorySlut;
		if (player.hasVagina()) {
			player.vaginas[0].virgin = false;
			player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
		}
		player.ass.analLooseness = 1;
	}
	else if (temp == 19) {
		outputText("Because of your history perk, you will start out as a non-virgin. At least you'll start with some gems.\n\n", true);
		historyPerk = PerkLib.HistoryWhore;
		player.gems += 50;
		if (player.hasVagina()) {
			player.vaginas[0].virgin = false;
			player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
		}
		player.ass.analLooseness = 1;
	}
	else if (temp == 20) {
		outputText("Because of your history perk, you will start out with some gems.\n\n", true);
		historyPerk = PerkLib.HistoryFortune;
		player.gems += 250;
	}
	player.createPerk(historyPerk,0,0,0,0);
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00418] == 0) {
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00418] = 1;
	}
	else {
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00418] = 1;
		eventParser(1);
	}
	chooseGameModes();
}

//-----------------
//-- CONFIRM NAME
//-----------------
private function confirmName():void {
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
		newGameGo();
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
	if(unlockedHerm == true){
		outputText("\n\n\n\nAre you a man or a woman? \n\nOr a hermaphrodite as you've unlocked hermaphrodite option!", true);
		simpleChoices("Man", chooseMale, "Woman", chooseFemale, "Herm", chooseHerm, "", 0, "", 0);
	}
	else{
		outputText("\n\n\n\nAre you a man or a woman?", true);
		simpleChoices("Man", chooseMale, "Woman", chooseFemale, "", 0, "", 0, "", 0);			
	}
}

public function newGamePlus():void {
	flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = player.XP;
	if(flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] == 0) flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = 1;
	while (player.level > 1) {
		player.level--;
		flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] += player.level * 100;
	}
	flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS] = player.gems;
	newGameGo();
}

//No longer used.
public function doCreation(eventNo:Number):void {
	var e:MouseEvent;
	var historyPerk:PerkType;
}

private function startTheGame():void {
	if(flags[kFLAGS.CUSTOM_PC_ENABLED] == 1) {
		clearOutput();
		flags[kFLAGS.CUSTOM_PC_ENABLED] = 0;
		kGAMECLASS.customPCSetup();
		doNext(startTheGame);
		return;
	}
	if (flags[kFLAGS.HARDCORE_MODE] > 0) {
		trace("Hardcore save file " + flags[kFLAGS.HARDCORE_SLOT] + " created.")
		getGame().saves.saveGame(flags[kFLAGS.HARDCORE_SLOT])
	}
	//Ensures it's permanently unlocked.
	if (unlockedHerm == true)
	{
		flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] = 1;
	}
	flags[kFLAGS.MOD_SAVE_VERSION] = kGAMECLASS.modSaveVersion;
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

public function useCustomProfile():void {
	flags[kFLAGS.CUSTOM_PC_ENABLED] = 1;
	clearOutput();
	player.short = mainView.nameBox.text;
	mainView.nameBox.visible = false;
	if(specialName(mainView.nameBox.text)) {
		outputText("Your name defines everything about you, and as such, it is time to wake...\n\n");
		flags[kFLAGS.CUSTOM_PC_ENABLED] = 0;
		kGAMECLASS.customPCSetup();
		doNext(chooseGameModes);
	}
	else {
		outputText("There is something different about you, but first, what is your basic gender?  An individual such as you may later overcome this, of course...");
		outputText("\n\n\n\nAre you a man or a woman?", true);
		simpleChoices("Man", chooseMale, "Woman", chooseFemale, "", 0, "", 0, "", 0);
	}
}

public function noCustomProfile():void {
	clearOutput();
	flags[kFLAGS.CUSTOM_PC_ENABLED] = -1;
	player.short = mainView.nameBox.text;
	mainView.nameBox.visible = false;
	outputText("Your name carries little significance beyond it being your name.  What is your gender?");
	if(unlockedHerm == true){
		outputText("\n\nHermaphrodite option is already unlocked.");
		simpleChoices("Male", chooseMale, "Woman", chooseFemale, "Herm", chooseHerm, "", 0, "", 0);
	}
	else{
		simpleChoices("Male", chooseMale, "Female", chooseFemale, "", 0, "", 0, "", 0);			
	}
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
		case "TestChar":
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
		case "TestChar":
			return true;
		default:
			return false;
	}
	return false;
}





}
}