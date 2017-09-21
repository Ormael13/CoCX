package classes 
{
import classes.GlobalFlags.kCOUNTERS;
import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kACHIEVEMENTS;
	import classes.Player;
	import classes.Items.Armors.GooArmor;
	import classes.Items.*;
	import classes.Saves;
import classes.internals.CountersStorage;
import classes.internals.RootCounters;

import fl.controls.ComboBox;
	import fl.data.DataProvider;
	import flash.events.Event;
	
	import coc.view.MainView;

	//import flash.events.MouseEvent;

	public class CharCreation extends BaseContent {
		
		public const MAX_TOLERANCE_LEVEL:int = 10;				//40 AP
		public const MAX_MORALSHIFTER_LEVEL:int = 10;			//40 AP
		public const MAX_DESIRES_LEVEL:int = 25;				//90 AP
		public const MAX_ENDURANCE_LEVEL:int = 25;				//90 AP
		public const MAX_HARDINESS_LEVEL:int = 25;				//90 AP
		public const MAX_SOULPURITY_LEVEL:int = 25;				//90 AP
		public const MAX_INNERPOWER_LEVEL:int = 25;				//90 AP
		public const MAX_FURY_LEVEL:int = 25;					//90 AP
		public const MAX_MYSTICALITY_LEVEL:int = 20;			//90 AP
		public const MAX_SPIRITUALENLIGHTENMENT_LEVEL:int = 20;	//90 AP
		public const MAX_WISDOM_LEVEL:int = 5;					//15 AP
		public const MAX_TRANSHUMANISM_LEVEL:int = 25;			//90 AP
		public const MAX_FORTUNE_LEVEL:int = -1;				//No maximum level.(845)
		public const MAX_VIRILITY_LEVEL:int = 10;				//40 AP
		public const MAX_FERTILITY_LEVEL:int = 10;				//40 AP
		
		private var specialCharacters:CharSpecial = new CharSpecial();
		private var customPlayerProfile:Function;
		
//		private var boxNames:ComboBox;
		
		public function CharCreation() {}
		
		public function newGameFromScratch():void {
			flags[kFLAGS.NEW_GAME_PLUS_LEVEL] = 0;
			newGameGo();
		}
		
		public function newGamePlus():void {
			flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = player.XP;
			if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] == 0) flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = 1;
			while (player.level > 1) {
				flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] += player.level * 100;
				player.level--;
			}
			flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS] = player.gems;
			newGameGo();
		}
		
		public function newGameGo():void {
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
			mainView.hideComboBox();
			//If first PC, track status of EZ mode and other such nonsense.
			var silly:Boolean = flags[kFLAGS.SILLY_MODE_ENABLE_FLAG];
			var easy:Boolean = flags[kFLAGS.EASY_MODE_ENABLE_FLAG];
			var sprite:Boolean = flags[kFLAGS.SHOW_SPRITES_FLAG];
			mainView.setButtonText(0, "Newgame"); // b1Text.text = "Newgame";
			//flags[kFLAGS.CUSTOM_PC_ENABLED] = 0;
			
			var showSpecialNames:Boolean = true; // achievements[kACHIEVEMENTS.STORY_FINALBOSS] > 0;			
			
			clearOutput();
			outputText("You grew up in the small village of Ingnam, a remote village with rich traditions, buried deep in the wilds.  Every year for as long as you can remember, your village has chosen a champion to send to the cursed Demon Realm.  Legend has it that in years Ingnam has failed to produce a champion, chaos has reigned over the countryside.  Children disappear, crops wilt, and disease spreads like wildfire.  This year, <b>you</b> have been selected to be the champion.\n\n");
			//if (showSpecialNames) outputText("\n\n\n\n");			
			outputText("What is your name?");
		
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
			menu();
			addButton(0, "OK", chooseName);
		//	simpleChoices("OK",10034,"",0,"",0,"",0,"",0);
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		
			//OLD
			//mainView.nameBox.x = 510;
			//mainView.nameBox.y = 265;
			mainView.nameBox.text = "";
			mainView.nameBox.maxChars = 16;
			mainView.nameBox.restrict = null;
			
			var preList:Array = [];
			//function _add(element:Array):void{preList.push({label: element[0], data:element});}
			//if (CoC_Settings.debugBuild) preList.push( { label: "TestChar", data: [ "TestChar", customTestChar, true, "For debug." ]} );			
			for (var t:int = 0; t < specialCharacters.customs.length; t++) preList.push( { label: specialCharacters.customs[t][0], data:specialCharacters.customs[t] } );

			if (showSpecialNames) {
				kGAMECLASS.showComboBox(preList,"Pre-defined characters",selectName);
				mainView.placeComboBox(mainView.nameBox.x + mainView.nameBox.width + 10,mainView.nameBox.y);
			}
			
			//Reset autosave
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.slotName = "VOID";
				player.autoSave = false;
			}
			//RESET DUNGEON
			kGAMECLASS.inDungeon = false;
			kGAMECLASS.dungeonLoc = 0;
			kGAMECLASS.inRoomedDungeon = false;
			kGAMECLASS.inRoomedDungeonResume = null;
			//Hold onto old data for NG+
			var oldPlayer:Player = player;
			//Reset all standard stats
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) player = new Player();
			model.player = player;
			player.str = 15;
			player.tou = 15;
			player.spe = 15;
			player.inte = 15;
			player.wis = 15;
			player.sens = 15;
			player.lib = 15;
			player.cor = 15;
			player.soulforce = 50;
			player.wrath = 0;
			player.mana = 100;
			player.hunger = 80;
			player.obey = 10;
			player.esteem = 50;
			player.will = 80;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) kGAMECLASS.notes = "No Notes Available.";
			player.lust = 15;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.XP = flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP];
				player.level = 1;
				
				player.gems = flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS];
			}
			player.hairLength = 5;
			player.skin.restore();
			player.faceType = FACE_HUMAN;
			player.tailType = TAIL_TYPE_NONE;
			player.tongueType = TONGUE_HUMAN;
			player.femininity = 50;
			player.beardLength = 0;
			player.beardStyle = 0;
			player.tone = 50;
			player.thickness = 50;
			player.skinDesc = "skin";
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.balls = 0;
				player.ballSize = 0;
				player.clitLength = 0;
			}
			player.hoursSinceCum = 0;
			player.cumMultiplier = 1;
			player.ass.analLooseness = 0;
			player.ass.analWetness = 0;
			player.ass.fullness = 0;
			player.fertility = 5;
			player.fatigue = 0;
			player.horns = 0;
			player.tallness = 60;
			player.tailCount = 0;
			player.tailVenom = 0;
			player.tailRecharge = 0;
			player.gillType = GILLS_NONE;
			player.rearBody = REAR_BODY_NONE;
			player.wingType = WING_TYPE_NONE;
			player.wingDesc = "non-existant";
			//Default
			player.skinTone = "light";
			player.hairColor = "brown";
			player.hairType = HAIR_NORMAL;
			player.beardLength = 0;
			player.beardStyle = 0;
			//Exploration
			player.explored = 0;
			player.exploredForest = 0;
			player.exploredDesert = 0;
			player.exploredMountain = 0;
			player.exploredLake = 0;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
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
			}
			//PLOTZ
			kGAMECLASS.monk = 0;
			kGAMECLASS.whitney = 0;
			kGAMECLASS.sand = 0;
		//Replaced by flag	kGAMECLASS.beeProgress = 0;
			kGAMECLASS.giacomo = 0;
			kGAMECLASS.isabellaScene.isabellaOffspringData = []; //CLEAR!
			//Lets get this bitch started
			kGAMECLASS.inCombat = false;
			kGAMECLASS.inDungeon = false;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				//Clothes clear
				player.setArmor(armors.C_CLOTH);
				player.setWeapon(WeaponLib.FISTS);
				player.setWeaponRange(WeaponRangeLib.NOTHING);
				//Clear camp slots
				inventory.clearStorage();
				inventory.clearGearStorage();
				inventory.clearPearlStorage();
				//Initialize gearStorage
				inventory.initializeGearStorage();
				inventory.initializePearlStorage();
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
			}
			else {
				var hadOldCock:Boolean = player.hasCock();
				var hadOldVagina:Boolean = player.hasVagina();
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
				//Keep gender and normalize genitals.
				if (hadOldCock) player.createCock(5.5, 1, CockTypesEnum.HUMAN);
				if (hadOldVagina) player.createVagina(true);
				if (player.balls > 2) player.balls = 2;
				if (player.ballSize > 2) player.ballSize = 2;
				if (player.clitLength > 1.5) player.clitLength = 1.5;
				while (player.breastRows.length > 1)
				{
					player.removeBreastRow(1, 1);
				}
				if (player.nippleLength > 1) player.nippleLength = 1;
				while (player.biggestTitSize() > 14) player.shrinkTits(true);
				//Sorry but you can't come, Valeria!
			//	if (!(oldPlayer.armor is GooArmor))
			//	player.setArmor(armors.C_CLOTH);
			}
			
			//Clear Statuses
			var statusTemp:Array = [];
			for (var i:int = 0; i < player.statusEffects.length; i++) {
				if (isSpell(player.statusEffects[i].stype)) statusTemp.push(player.statusEffects[i]);
			}
			player.removeStatuses();
			if (statusTemp.length > 0) {
				for (i = 0; i < statusTemp.length; i++) {
					player.createStatusEffect(statusTemp[i].stype, statusTemp[i].value1, statusTemp[i].value2, statusTemp[i].value3, statusTemp[i].value4);
				}
			}
			//Clear perks
			var ascendPerkTemp:Array = [];
			for (i = 0; i < player.perks.length; i++) {
				if (isAscensionPerk(player.perks[i])) ascendPerkTemp.push(player.perks[i]);
			}
			player.removePerks();
			if (ascendPerkTemp.length > 0) {
				for (i = 0; i < ascendPerkTemp.length; i++) {
					player.createPerk(ascendPerkTemp[i].ptype, ascendPerkTemp[i].value1, ascendPerkTemp[i].value2, ascendPerkTemp[i].value3, ascendPerkTemp[i].value4);
				}
			}
			//Clear key items
			var keyItemTemp:Array = [];
			for (i = 0; i < player.keyItems.length; i++) {
				if (isSpecialKeyItem(player.keyItems[i].keyName)) keyItemTemp.push(player.keyItems[i]);
			}
			player.removeKeyItems();
			if (keyItemTemp.length > 0) {
				for (i = 0; i < keyItemTemp.length; i++) {
					player.createKeyItem(keyItemTemp[i].keyName, keyItemTemp[i].value1, keyItemTemp[i].value2, keyItemTemp[i].value3, keyItemTemp[i].value4);
				}
			}
			//player.perkPoints = player.level - 1;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0) {
				var newGamePlusLevel:int = flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
				var gameMode:Number = flags[kFLAGS.HUNGER_ENABLED];
				var hardcoreMode:int = flags[kFLAGS.HARDCORE_MODE];
				var hardcoreSlot:String = flags[kFLAGS.HARDCORE_SLOT];
			}
			//Clear plot storage array!
			kGAMECLASS.flags = new DefaultDict();
			var countersStorage:CountersStorage = kCOUNTERS.create();
			kCOUNTERS.initialize(countersStorage);
			kGAMECLASS.counters = new RootCounters(countersStorage);
			kGAMECLASS.saves.loadPermObject();
			//Carry over data if new game plus.
			if (newGamePlusLevel > 0) {
				flags[kFLAGS.NEW_GAME_PLUS_LEVEL] = newGamePlusLevel;
				flags[kFLAGS.HUNGER_ENABLED] = gameMode;
				flags[kFLAGS.HARDCORE_MODE] = hardcoreMode;
				flags[kFLAGS.HARDCORE_SLOT] = hardcoreSlot;
			}
			//Set that jojo debug doesn't need to run
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_02999] = 3;
			//Time reset
			model.time.days = 0;
			model.time.hours = 0;
			model.time.minutes = 0;

		}
		
		private function chooseName():void {
			if (kGAMECLASS.testingBlockExiting) {
				// We're running under the testing script.
				// Stuff a name in the box and go go go
				mainView.nameBox.text = "Derpy";
				return;
			}
			if (mainView.nameBox.text == "") {
				//If part of newgame+, don't fully wipe.
				if (player.XP > 0 && player.explored == 0) {
					flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = player.XP;
					if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] == 0) flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] = 1;
					while (player.level > 1) {
						flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP] += player.level * 100;
						player.level--;
					}
					flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS] = player.gems;
				}
				if (flags[kFLAGS.LETHICE_DEFEATED] > 0) renamePrompt();
				else newGameGo();
				outputText("\n\n\n<b>You must select a name.</b>");
				return;
			}
			clearOutput();
			mainView.hideComboBox();
			mainView.nameBox.visible = false;
			player.short = mainView.nameBox.text;
			if (flags[kFLAGS.LETHICE_DEFEATED] > 0) { //Dirty checking as the NG+ flag is incremented after reincarnating.
				clearOutput();
				outputText("You shall be known as [name] now.");
				ascensionMenu();
				return;
			}
			customPlayerProfile = customName(mainView.nameBox.text);
			menu();
			if (customPlayerProfile != null) {
				outputText("This name, like you, is special.  Do you live up to your name or continue on, assuming it to be coincidence?");
				addButton(0, "SpecialName", useCustomProfile);
				addButton(1, "Continue On", noCustomProfile);
			}
			else { //Proceed with normal character creation
				genericGenderChoice();
			}
		}
		
		private function genericGenderChoice():void {
			outputText("Are you a man or a woman?");
			menu();
			addButton(0, "Man", isAMan);
			addButton(1, "Woman", isAWoman);
			if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] > 0) {
				outputText("\n\nOr a hermaphrodite as you've unlocked hermaphrodite option!");
				addButton(2, "Herm", isAHerm);
			}
		}
		
		private function useCustomProfile():void {
			clearOutput();
			if (specialName(player.short) != null) {
				outputText("Your name defines everything about you, and as such, it is time to wake...\n\n");
				flags[kFLAGS.HISTORY_PERK_SELECTED] = 1;
				completeCharacterCreation(); //Skip character creation, customPlayerProfile will be called in completeCharacterCreation
			}
			else {
				//After character creation the fact that customPlayerProfile is not null will activate a custom player setup 
				outputText("There is something different about you, but first, what is your basic gender?  An individual such as you may later overcome this, of course...\n\n");
				genericGenderChoice();
			}
		}
		
		private function noCustomProfile():void {
			clearOutput();
			customPlayerProfile = null;
			outputText("Your name carries little significance beyond it being your name.  What is your gender?");
			menu();
			addButton(0, "Man", isAMan);
			addButton(1, "Woman", isAWoman);
			if (flags[kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM] > 0) {
				addButton(2, "Herm", isAHerm);
			}
		}
		
		private function selectName(selectedItem:*):void {
			if (selectedItem.data[0].length > 16) // not a name
				return;
			
			clearOutput();
			
			outputText("<b>" + selectedItem.data[0] + ":</b> " + selectedItem.data[3]);
			if(selectedItem.data[2])
				outputText("\n\nThis character have pre-defined history.");
			else
				outputText("\n\nThis character have no pre-defined history.");
				
			flushOutputTextToGUI();	
			mainView.nameBox.text = selectedItem.data[0];
		}
		
		//Determines if has character creation bonuses
		internal function customName(arg:String):Function {
			for (var i:int = 0; i < specialCharacters.customs.length; i++)
				if (specialCharacters.customs[i][0] == arg && !specialCharacters.customs[i][2])
					return specialCharacters.customs[i][1];
			return specialName(arg); //Must check against the special name list as well
		}
		
		//Does PC skip creation?
		private function specialName(arg:String):Function {
			for (var i:int = 0; i < specialCharacters.customs.length; i++)
				if (specialCharacters.customs[i][0] == arg && specialCharacters.customs[i][2])
					return specialCharacters.customs[i][1];
			return null;
		}
		
		private function isAMan():void {
			//Attributes
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.str += 3;
				player.tou += 2;
			}
			//Body attributes
			player.fertility = 5;
			player.hairLength = 1;
			player.tallness = 71;
			player.tone = 60;
			
			//Genetalia
			player.balls = 2;
			player.ballSize = 1;
			player.clitLength = 0;
			player.createCock();
			player.cocks[0].cockLength = 5.5;
			player.cocks[0].cockThickness = 1;
			player.cocks[0].cockType = CockTypesEnum.HUMAN;
			player.cocks[0].knotMultiplier = 1;
			
			//Breasts
			player.createBreastRow();
			
			//Choices
			clearOutput();
			outputText("You are a man.  Your upbringing has provided you an advantage in strength and toughness.\n\nWhat type of build do you have?");
			simpleChoices("Lean", buildLeanMale, "Average", buildAverageMale, "Thick", buildThickMale, "Girly", buildGirlyMale, "", null);
		}

		private function isAWoman():void {
			//Attributes
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.spe += 3;
				player.inte += 2;
			}
			//Body attributes
			player.fertility = 10;
			player.hairLength = 10;
			player.tallness = 67;
			player.tone = 30;
			
			//Genetalia
			player.balls = 0;
			player.ballSize = 0;
			player.createVagina();
			player.clitLength = 0.5;
			
			//Breasts
			player.createBreastRow();
			
			//Choices
			clearOutput();
			outputText("You are a woman.  Your upbringing has provided you an advantage in speed and intellect.\n\nWhat type of build do you have?");
			simpleChoices("Slender", buildSlenderFemale, "Average", buildAverageFemale, "Curvy", buildCurvyFemale, "Tomboyish", buildTomboyishFemale, "", null);
		}

		private function isAHerm():void {
			//Attributes
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.str+=1;
				player.tou+=1;
				player.spe+=1;
				player.inte+= 1;
			}
			//Body attributes
			player.fertility = 10;
			player.hairLength = 10;
			player.tallness = 69;
			player.tone = 45;
			
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
			
			//Choices
			clearOutput();
			outputText("\n\nYou are a hermaphrodite.  Your upbringing has provided you an average in stats.\n\nWhat type of build do you have?");
			menu();
			addButton(0, "Fem. Slender", buildSlenderFemale).hint("Feminine build. \n\nWill make you a futanari.", "Feminine, Slender");
			addButton(1, "Fem. Average", buildAverageFemale).hint("Feminine build. \n\nWill make you a futanari.", "Feminine, Average");
			addButton(2, "Fem. Curvy", buildCurvyFemale).hint("Feminine build. \n\nWill make you a futanari.", "Feminine, Curvy");
			//addButton(4, "Androgynous", chooseBodyTypeAndrogynous);
			addButton(5, "Mas. Lean", buildLeanMale).hint("Masculine build. \n\nWill make you a maleherm.", "Masculine, Lean");
			addButton(6, "Mas. Average", buildAverageMale).hint("Masculine build. \n\nWill make you a maleherm.", "Masculine, Average");
			addButton(7, "Mas. Thick", buildThickMale).hint("Masculine build. \n\nWill make you a maleherm.", "Masculine, Thick");
		}
		
		
		private function buildLeanMale():void {
			player.str -= 1;
			player.spe += 1;
			
			player.femininity = 34;
			player.thickness = 30;
			player.tone += 5;
			
			player.breastRows[0].breastRating = BREAST_CUP_FLAT;
			player.buttRating = BUTT_RATING_TIGHT;
			player.hipRating = HIP_RATING_SLENDER;
			chooseComplexion();
		}

		private function buildSlenderFemale():void {
			player.str -= 1;
			player.spe += 1;
			
			player.femininity = 66;
			player.thickness = 30;
			player.tone += 5;
			
			player.breastRows[0].breastRating = BREAST_CUP_B;
			player.buttRating = BUTT_RATING_TIGHT;
			player.hipRating = HIP_RATING_AMPLE;
			chooseComplexion();
		}

		private function buildAverageMale():void {
			player.femininity = 30;
			player.thickness = 50;
			
			player.breastRows[0].breastRating = BREAST_CUP_FLAT;
			player.buttRating = BUTT_RATING_AVERAGE;
			player.hipRating = HIP_RATING_AVERAGE;
			chooseComplexion();
		}

		private function buildAverageFemale():void {
			player.femininity = 70;
			player.thickness = 50;
			
			player.breastRows[0].breastRating = BREAST_CUP_C;
			player.buttRating = BUTT_RATING_NOTICEABLE;
			player.hipRating = HIP_RATING_AMPLE;
			chooseComplexion();
		}

		private function buildThickMale():void {
			player.spe -= 4;
			player.str += 2;
			player.tou += 2;
			
			player.femininity = 29;
			player.thickness = 70;
			player.tone -= 5;
			
			player.breastRows[0].breastRating = BREAST_CUP_FLAT;
			player.buttRating = BUTT_RATING_NOTICEABLE;
			player.hipRating = HIP_RATING_AVERAGE;
			chooseComplexion();
		}

		private function buildCurvyFemale():void {
			player.spe -= 2;
			player.str += 1;
			player.tou += 1;
			
			player.femininity = 71;
			player.thickness = 70;
			
			player.breastRows[0].breastRating = BREAST_CUP_D;
			player.buttRating = BUTT_RATING_LARGE;
			player.hipRating = HIP_RATING_CURVY;
			chooseComplexion();
		}

		private function buildGirlyMale():void {
			player.str -= 2;
			player.spe += 2;
			
			player.femininity = 50;
			player.thickness = 50;
			player.tone = 26;
			
			player.breastRows[0].breastRating = BREAST_CUP_A;
			player.buttRating = BUTT_RATING_NOTICEABLE;
			player.hipRating = HIP_RATING_SLENDER;
			chooseComplexion();
		}

		private function buildTomboyishFemale():void {
			player.str += 1;
			player.spe -= 1;
			
			player.femininity = 56;
			player.thickness = 50;
			player.tone = 50;
			
			player.breastRows[0].breastRating = BREAST_CUP_A;
			player.buttRating = BUTT_RATING_TIGHT;
			player.hipRating = HIP_RATING_SLENDER;
			chooseComplexion();
		}

		private function chooseComplexion():void {
			clearOutput();
			outputText("What is your complexion?");
			menu();
			addButton(0, "Light", setComplexion, "light");
			addButton(1, "Fair", setComplexion, "fair");
			addButton(2, "Olive", setComplexion, "olive");
			addButton(3, "Dark", setComplexion, "dark");
			addButton(4, "Ebony", setComplexion, "ebony");
			addButton(5, "Mahogany", setComplexion, "mahogany");
			addButton(6, "Russet", setComplexion, "russet");
		}

		private function setComplexion(choice:String):void { //And choose hair
			player.skinTone = choice;
			clearOutput();
			outputText("You selected a " + choice + " complexion.\n\nWhat color is your hair?");
			menu();
			addButton(0, "Blonde", setHair, "blonde");
			addButton(1, "Brown", setHair, "brown");
			addButton(2, "Black", setHair, "black");
			addButton(3, "Red", setHair, "red");
			addButton(4, "Gray", setHair, "gray");
			addButton(5, "White", setHair, "white");
			addButton(6, "Auburn", setHair, "auburn");
		}

		private function setHair(choice:String):void {
			player.hairColor = choice;
			clearOutput();
			outputText("You have " + hairDescript() + ".\n\nYou will proceed to customization.");
			//chooseEndowment(false);
			chooseEyesColor();
		}
		
		private function chooseEyesColor():void {
			clearOutput();
			outputText("What is your eyes color?");
			menu();
			addButton(0, "Black", setEyesColor, "black");
			addButton(1, "Green", setEyesColor, "green");
			addButton(2, "Blue", setEyesColor, "blue");
			addButton(3, "Red", setEyesColor, "red");
			addButton(4, "White", setEyesColor, "white");
			addButton(5, "Brown", setEyesColor, "brown");
			addButton(6, "Yellow", setEyesColor, "yellow");
			addButton(7, "Grey", setEyesColor, "grey");
			addButton(8, "Purple", setEyesColor, "purple");
			addButton(10, "Silver", setEyesColor, "silver");
			addButton(11, "Golden", setEyesColor, "golden");
		}

		private function setEyesColor(choice:String):void { //And choose hair
			player.eyeColor = choice;
			clearOutput();
			outputText("You selected a " + choice + " eyes color.\n\nYou will proceed to customization.");
			//chooseEndowment(false);
			genericStyleCustomizeMenu();
		}

		//-----------------
		//-- GENERAL STYLE
		//-----------------
		private function genericStyleCustomizeMenu():void {
			clearOutput();
			mainView.nameBox.visible = false;
			mainView.nameBox.maxChars = 16;
			mainView.nameBox.restrict = null;
			
			outputText("You can finalize your appearance customization before you proceed to perk selection. You will be able to alter your appearance through the usage of certain items.\n\n");
			outputText("Height: " + Math.floor(player.tallness / 12) + "'" + player.tallness % 12 + "\"\n");
			outputText("Skin tone: " + player.skinTone + "\n");
			outputText("Hair color: [haircolor]\n");
			if (player.hasCock()) {
				outputText("Cock size: " + player.cocks[0].cockLength + "\" long, " + player.cocks[0].cockThickness + "\" thick\n");
			}
			outputText("Breast size: " + player.breastCup(0) + "\n");
			menu();
			addButton(0, "Complexion", menuSkinComplexion);
			addButton(1, "Hair Color", menuHairColor);
			if (player.mf("m", "f") == "m") {
				if (player.hasBeard()) {
					outputText("Beard: " + player.beardDescript() + "\n");
				}
				addButton(2, "Beard Style", menuBeardSettings);
			}
			addButton(3, "Eyes Color", menuEyesColor);
			addButton(4, "Set Height", setHeight);
			if (player.hasCock()) addButton(5, "Cock Size", menuCockLength);
			addButton(6, "Breast Size", menuBreastSize);
			addButton(9, "Done", chooseEndowment, true);
		}

		//-----------------
		//-- SKIN COLOURS
		//-----------------
		private function menuSkinComplexion():void {
			clearOutput();
			outputText("What is your complexion?");
			menu();
			addButton(0, "Light", confirmComplexion, "light");
			addButton(1, "Fair", confirmComplexion, "fair");
			addButton(2, "Olive", confirmComplexion, "olive");
			addButton(3, "Dark", confirmComplexion, "dark");
			addButton(4, "Ebony", confirmComplexion, "ebony");
			addButton(5, "Mahogany", confirmComplexion, "mahogany");
			addButton(6, "Russet", confirmComplexion, "russet");
			addButton(14, "Back", genericStyleCustomizeMenu);
		}	
		private function confirmComplexion(complexion:String):void {
			player.skinTone = complexion;
			genericStyleCustomizeMenu();
		}

		//-----------------
		//-- HAIR COLOURS
		//-----------------
		private function menuHairColor():void {
			clearOutput();
			outputText("What is your hair color?");
			menu();
			addButton(0, "Blonde", chooseHairColor, "blonde");
			addButton(1, "Brown", chooseHairColor, "brown");
			addButton(2, "Black", chooseHairColor, "black");
			addButton(3, "Red", chooseHairColor, "red");
			addButton(4, "Gray", chooseHairColor, "gray");
			addButton(5, "White", chooseHairColor, "white");
			addButton(6, "Auburn", chooseHairColor, "auburn");
			addButton(14, "Back", genericStyleCustomizeMenu);
		}

		private function chooseHairColor(color:String = ""):void {
			player.hairColor = color;
			genericStyleCustomizeMenu();
		}

		//-----------------
		//-- BEARD STYLE
		//-----------------
		private function menuBeardSettings():void {
			clearOutput();
			outputText("You can choose your beard length and style.\n\n");
			outputText("Beard: " + player.beardDescript());
			menu();
			addButton(0, "Style", menuBeardStyle);
			addButton(1, "Length", menuBeardLength);
			addButton(14, "Back", genericStyleCustomizeMenu);
		}
		private function menuBeardStyle():void {
			clearOutput();
			outputText("What beard style would you like?");
			menu();
			addButton(0, "Normal", chooseBeardStyle, 0);
			addButton(1, "Goatee", chooseBeardStyle, 1);
			addButton(2, "Clean-cut", chooseBeardStyle, 2);
			addButton(3, "Mountainman", chooseBeardStyle, 3);
			addButton(14, "Back", menuBeardSettings);
		}
		private function chooseBeardStyle(choiceStyle:int = 0):void {
			player.beardStyle = choiceStyle;
			menuBeardSettings();
		}
		private function menuBeardLength():void {
			clearOutput();
			outputText("How long would you like your beard be? \n\nNote: Beard will slowly grow over time, just like in the real world. Unless you have no beard. You can change your beard style later in the game.");
			menu();
			addButton(0, "No Beard", chooseBeardLength, 0);
			addButton(1, "Trim", chooseBeardLength, 0.1);
			addButton(2, "Short", chooseBeardLength, 0.2);
			addButton(3, "Medium", chooseBeardLength, 0.5);
			addButton(4, "Mod. Long", chooseBeardLength, 1.5);
			addButton(5, "Long", chooseBeardLength, 3);
			addButton(6, "Very Long", chooseBeardLength, 6);
			addButton(14, "Back", chooseBeardLength);
		}
		private function chooseBeardLength(choiceLength:Number = 0):void {
			player.beardLength = choiceLength;
			menuBeardSettings();
		}
		
		//-----------------
		//-- EYES COLOURS
		//-----------------
		private function menuEyesColor():void {
			clearOutput();
			outputText("What is your eyes color?");
			menu();
			addButton(0, "Black", pickEyesColor, "black");
			addButton(1, "Green", pickEyesColor, "green");
			addButton(2, "Blue", pickEyesColor, "blue");
			addButton(3, "Red", pickEyesColor, "red");
			addButton(4, "White", pickEyesColor, "white");
			addButton(5, "Brown", pickEyesColor, "brown");
			addButton(6, "Yellow", pickEyesColor, "yellow");
			addButton(7, "Grey", pickEyesColor, "grey");
			addButton(10, "Purple", pickEyesColor, "purple");
			addButton(11, "Golden", pickEyesColor, "golden");
			addButton(13, "Silver", pickEyesColor, "silver");
			addButton(14, "Back", genericStyleCustomizeMenu);
		}

		private function pickEyesColor(color:String = ""):void {
			player.eyeColor = color;
			genericStyleCustomizeMenu();
		}

		//-----------------
		//-- HEIGHT
		//-----------------
		private function setHeight():void {
			clearOutput();
			if (kGAMECLASS.testingBlockExiting)
			{
				// We're running under the testing script.
				// Stuff a number in the box and go go go
				mainView.nameBox.text = "69";
			}
			outputText("Set your height in inches.");
			outputText("\nYou can choose any height between 4 feet (48 inches) and 8 feet (96 inches).");
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
			menu();
			addButton(0, "OK", confirmHeight);
			addButton(4, "Back", genericStyleCustomizeMenu);
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		}
		private function confirmHeight():void {
			mainView.nameBox.visible = false;
			if (int(mainView.nameBox.text) < 48)
			{
				clearOutput();
				outputText("That is below your minimum height choices!");
				//Off to the height selection!
				doNext(setHeight);
				return;
			}
			if (int(mainView.nameBox.text) > 96)
			{
				clearOutput();
				outputText("That is above your maximum height choices!");
				//Off to the height selection!
				doNext(setHeight);
				return;
			}
			if (mainView.nameBox.text == "")
			{
				clearOutput();
				outputText("Please input your height. Off you go to the height selection!");
				//Off to the height selection!
				doNext(setHeight);
				return;
			}
			player.tallness = int(mainView.nameBox.text);
			mainView.nameBox.maxChars = 16;
			mainView.nameBox.restrict = null;
			clearOutput();
			outputText("You'll be " + Math.floor(player.tallness / 12) + " feet and " + player.tallness % 12 + " inches tall. Is this okay with you?");
			doYesNo(genericStyleCustomizeMenu, setHeight);
		}

		//-----------------
		//-- COCK LENGTH
		//-----------------
		private function menuCockLength():void {
			clearOutput();
			outputText("You can choose a cock length between 4 and 8 inches. Your starting cock length will also affect starting cock thickness. \n\nCock type and size can be altered later in the game through certain items.");
			menu();
			addButton(0, "4\"", chooseCockLength, 4);
			addButton(1, "4.5\"", chooseCockLength, 4.5);
			addButton(2, "5\"", chooseCockLength, 5);
			addButton(3, "5.5\"", chooseCockLength, 5.5);
			addButton(4, "6\"", chooseCockLength, 6);
			addButton(5, "6.5\"", chooseCockLength, 6.5);
			addButton(6, "7\"", chooseCockLength, 7);
			addButton(7, "7.5\"", chooseCockLength, 7.5);
			addButton(8, "8\"", chooseCockLength, 8);
			addButton(14, "Back", genericStyleCustomizeMenu);
		}
		private function chooseCockLength(length:Number):void {
			player.cocks[0].cockLength = length;
			player.cocks[0].cockThickness = Math.floor(((length / 5) - 0.1) * 10) / 10;
			genericStyleCustomizeMenu();
		}

		//-----------------
		//-- BREAST SIZE
		//-----------------
		private function menuBreastSize():void {
			clearOutput();
			outputText("You can choose a breast size. Breast size may be altered later in the game.");
			menu();
			if (player.femininity < 50) addButton(0, "Flat", chooseBreastSize, 0);
			if (player.femininity < 60) addButton(1, "A-cup", chooseBreastSize, 1);
			if (player.femininity >= 40) addButton(2, "B-cup", chooseBreastSize, 2);
			if (player.femininity >= 50) addButton(3, "C-cup", chooseBreastSize, 3);
			if (player.femininity >= 60) addButton(4, "D-cup", chooseBreastSize, 4);
			if (player.femininity >= 70) addButton(5, "DD-cup", chooseBreastSize, 5);
			addButton(14, "Back", genericStyleCustomizeMenu);
		}
		private function chooseBreastSize(size:int):void {
			player.breastRows[0].breastRating = size;
			genericStyleCustomizeMenu();
		}

		//-----------------
		//-- STARTER PERKS
		//-----------------
		private function chooseEndowment(clear:Boolean):void {
			if (clear) clearOutput();
			outputText("Every person is born with a gift.  What's yours?");
			menu();
			addButton(0, "Strength", confirmEndowmentStrength);
			addButton(1, "Toughness", confirmEndowmentThoughness);
			addButton(2, "Speed", confirmEndowmentSpeed);
			addButton(3, "Smarts", confirmEndowmentSmarts);
			addButton(4, "Libido", confirmEndowmentLibido);
			addButton(5, "Touch", confirmEndowmentTouch);
			addButton(6, "Perversion", confirmEndowmentPerversion);
			if (player.hasCock()) {
				addButton(7, "Big Cock", confirmEndowmentBigCock);
				addButton(8, "Lots of Jizz", confirmEndowmentMessyOrgasms);
			}
			else {
				addButton(7, "Big Breasts", confirmEndowmentBigBreasts);
				addButton(8, "Big Clit", confirmEndowmentBigClit);
				addButton(9, "Fertile", confirmEndowmentFertile);
				addButton(10, "Wet Vagina", confirmEndowmentWetVagina);
			}
			if (player.gender == GENDER_HERM)
			{
				addButton(7, "Big Cock", confirmEndowmentBigCock);
				addButton(8, "Lots of Jizz", confirmEndowmentMessyOrgasms);
				addButton(9, "Big Breasts", confirmEndowmentBigBreasts);
				addButton(10, "Big Clit", confirmEndowmentBigClit);
				addButton(11, "Fertile", confirmEndowmentFertile);
				addButton(12, "Wet Vagina", confirmEndowmentWetVagina);
			}
		}

		private function confirmEndowmentStrength():void {
			clearOutput();
			outputText("Are you stronger than normal? (+5 Strength)\n\nStrength increases your combat damage, and your ability to hold on to an enemy or pull yourself away.");
			menu();
			addButton(0, "Yes", setEndowmentStrength);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentThoughness():void {
			clearOutput();
			outputText("Are you unusually tough? (+5 Toughness)\n\nToughness gives you more HP and increases the chances an attack against you will fail to wound you.");
			menu();
			addButton(0, "Yes", setEndowmentToughness);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentSpeed():void {
			clearOutput();
			outputText("Are you very quick?  (+5 Speed)\n\nSpeed makes it easier to escape combat and grapples.  It also boosts your chances of evading an enemy attack and successfully catching up to enemies who try to run.");
			menu();
			addButton(0, "Yes", setEndowmentSpeed);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentSmarts():void {
			clearOutput();
			outputText("Are you a quick learner?  (+5 Intellect)\n\nIntellect can help you avoid dangerous monsters or work with machinery.  It will also boost the power of any spells you may learn in your travels.");
			menu();
			addButton(0, "Yes", setEndowmentSmarts);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentLibido():void {
			clearOutput();
			outputText("Do you have an unusually high sex-drive?  (+5 Libido)\n\nLibido affects how quickly your lust builds over time.  You may find a high libido to be more trouble than it's worth...");
			menu();
			addButton(0, "Yes", setEndowmentLibido);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentTouch():void {
			clearOutput();
			outputText("Is your skin unusually sensitive?  (+5 Sensitivity)\n\nSensitivity affects how easily touches and certain magics will raise your lust.  Very low sensitivity will make it difficult to orgasm.");
			menu();
			addButton(0, "Yes", setEndowmentTouch);
			addButton(1, "No", chooseEndowment, true);
		}
		
		private function confirmEndowmentPerversion():void {
			clearOutput();
			clearOutput();
			outputText("Are you unusually perverted?  (+5 Corruption)\n\Corruption affects certain scenes and having a higher corruption makes you more prone to Bad Ends.\n");
			menu();
			addButton(0, "Yes", setEndowmentPerversion);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentBigCock():void {
			clearOutput();
			outputText("Do you have a big cock?  (+2\" Cock Length)\n\nA bigger cock will make it easier to get off any sexual partners, but only if they can take your size.");
			menu();
			addButton(0, "Yes", setEndowmentBigCock);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentMessyOrgasms():void {
			clearOutput();
			outputText("Are your orgasms particularly messy?  (+50% Cum Multiplier)\n\nA higher cum multiplier will cause your orgasms to be messier.");
			menu();
			addButton(0, "Yes", setEndowmentMessyOrgasms);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentBigBreasts():void {
			clearOutput();
			outputText("Are your breasts bigger than average? (DD cups)\n\nLarger breasts will allow you to lactate greater amounts, tit-fuck larger cocks, and generally be a sexy bitch.");
			menu();
			addButton(0, "Yes", setEndowmentBigBreasts);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentBigClit():void {
			clearOutput();
			outputText("Do you have a big clit?  (1\" Long)\n\nA large enough clit may eventually become as large as a cock.  It also makes you gain lust much faster during oral or manual stimulation.");
			menu();
			addButton(0, "Yes", setEndowmentBigClit);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentFertile():void {
			clearOutput();
			outputText("Is your family particularly fertile?  (+15% Fertility)\n\nA high fertility will cause you to become pregnant much more easily.  Pregnancy may result in: Strange children, larger bust, larger hips, a bigger ass, and other weirdness.");
			menu();
			addButton(0, "Yes", setEndowmentFertile);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentWetVagina():void {
			clearOutput();
			outputText("Does your pussy get particularly wet?  (+1 Vaginal Wetness)\n\nVaginal wetness will make it easier to take larger cocks, in turn helping you bring the well-endowed to orgasm quicker.");
			menu();
			addButton(0, "Yes", setEndowmentWetVagina);
			addButton(1, "No", chooseEndowment, true);
		}

		private function setEndowmentStrength():void {
			player.str += 5;
			player.tone += 7;
			player.thickness += 3;
			//Add bonus +25% strength gain
			if (player.findPerk(PerkLib.Strong) < 0) player.createPerk(PerkLib.Strong, 0.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentToughness():void {
			player.tou += 5;
			player.tone += 5;
			player.thickness += 5;
			if (player.findPerk(PerkLib.Tough) < 0) player.createPerk(PerkLib.Tough, 0.25, 0, 0, 0);
			player.HP = kGAMECLASS.maxHP();
			chooseHistory();
		}
		
		private function setEndowmentSpeed():void {
			player.spe += 5;
			player.tone += 10;
			if (player.findPerk(PerkLib.Fast) < 0) player.createPerk(PerkLib.Fast, 0.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentSmarts():void {
			player.inte += 5;
			player.thickness -= 5;
			if (player.findPerk(PerkLib.Smart) < 0) player.createPerk(PerkLib.Smart, 0.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentLibido():void {
			player.lib += 5;
			if (player.findPerk(PerkLib.Lusty) < 0) player.createPerk(PerkLib.Lusty, 0.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentTouch():void {
			player.sens += 5;
			if (player.findPerk(PerkLib.Sensitive) < 0) player.createPerk(PerkLib.Sensitive, 0.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentPerversion():void {
			player.sens += 5;
			if (player.findPerk(PerkLib.Pervert) < 0) player.createPerk(PerkLib.Pervert, 0.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentBigCock():void {
			player.femininity -= 5;
			player.cocks[0].cockLength = 8;
			player.cocks[0].cockThickness = 1.5;
			trace("Creation - cock modded to 8inches");
			if (player.findPerk(PerkLib.BigCock) < 0) player.createPerk(PerkLib.BigCock, 1.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentMessyOrgasms():void {
			player.femininity -= 2;
			player.cumMultiplier = 1.5;
			if (player.findPerk(PerkLib.MessyOrgasms) < 0) player.createPerk(PerkLib.MessyOrgasms, 1.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentBigBreasts():void {
			player.femininity += 5;
			player.breastRows[0].breastRating += 2;
			if (player.findPerk(PerkLib.BigTits) < 0) player.createPerk(PerkLib.BigTits, 1.5, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentBigClit():void {
			player.femininity -= 5;
			player.clitLength = 1;
			if (player.findPerk(PerkLib.BigClit) < 0) player.createPerk(PerkLib.BigClit, 1.25, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentFertile():void {
			player.femininity += 5;
			player.fertility += 25;
			player.hipRating += 2;
			if (player.findPerk(PerkLib.Fertile) < 0) player.createPerk(PerkLib.Fertile, 1.5, 0, 0, 0);
			chooseHistory();
		}
		
		private function setEndowmentWetVagina():void {
			player.femininity += 7;
			player.vaginas[0].vaginalWetness = VAGINA_WETNESS_WET;
			if (player.findPerk(PerkLib.WetPussy) < 0) player.createPerk(PerkLib.WetPussy, 2, 0, 0, 0);
			chooseHistory();
		}
		
		//-----------------
		//-- HISTORY PERKS
		//-----------------
		public function chooseHistory():void {
			clearOutput();
			if (flags[kFLAGS.HISTORY_PERK_SELECTED] != 0) { //This flag can only be non-zero if chooseHistory is called from camp.as
				outputText("<b>New history perks are available during creation.  Since this character was created before they were available, you may choose one now!</b>\n\n");
			}
			outputText("Before you became a champion, you had other plans for your life.  What were you doing before?");
			menu();
			if (player.findPerk(PerkLib.PastLifeAlchemist) < 0) addButton(0, "Alchemy", confirmHistory, PerkLib.HistoryAlchemist);
			else addButtonDisabled(0, "Alchemy", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeCultivator) < 0) addButton(1, "Cultivator", confirmHistory, PerkLib.HistoryCultivator);
			else addButtonDisabled(1, "Cultivator", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeFighter) < 0) addButton(2, "Fighting", confirmHistory, PerkLib.HistoryFighter);
			else addButtonDisabled(2, "Fighting", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeFortune) < 0) addButton(3, "Fortune", confirmHistory, PerkLib.HistoryFortune);
			else addButtonDisabled(3, "Fortune", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeHealer) < 0) addButton(4, "Healing", confirmHistory, PerkLib.HistoryHealer);
			else addButtonDisabled(4, "Healing", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeReligious) < 0) addButton(5, "Religion", confirmHistory, PerkLib.HistoryReligious);
			else addButtonDisabled(5, "Religion", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeScholar) < 0) addButton(6, "Schooling", confirmHistory, PerkLib.HistoryScholar);
			else addButtonDisabled(6, "Schooling", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeScout) < 0) addButton(7, "Scout", confirmHistory, PerkLib.HistoryScout);
			else addButtonDisabled(7, "Scout", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeSlacker) < 0) addButton(8, "Slacking", confirmHistory, PerkLib.HistorySlacker);
			else addButtonDisabled(8, "Slacking", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeSlut) < 0) addButton(9, "Slutting", confirmHistory, PerkLib.HistorySlut);
			else addButtonDisabled(9, "Slutting", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeSmith) < 0) addButton(10, "Smithing", confirmHistory, PerkLib.HistorySmith);
			else addButtonDisabled(10, "Smithing", "You already have this History as one of Past Lives!");
			if (player.findPerk(PerkLib.PastLifeWhore) < 0) addButton(11, "Whoring", confirmHistory, PerkLib.HistoryWhore);
			else addButtonDisabled(11, "Whoring", "You already have this History as one of Past Lives!");
			
		}
		
		private function confirmHistory(choice:PerkType):void {
			clearOutput();
			switch (choice) {
				case PerkLib.HistoryAlchemist:
					outputText("You spent some time as an alchemist's assistant, and alchemical items always seem to be more reactive in your hands.  Is this your history?");
					break;
				case PerkLib.HistoryCultivator:
					outputText("You spent much of your time cultivating your soul, reaching the point where you succesful stepped on the first step toward the spiritual enlightment as well attained uncanny purity of your soulforce.  You will start with Job: Soul Cultivator perk.  Also your max soulforce will be roughly 10% higher.  Is this your history?");
					break;
				case PerkLib.HistoryFighter:
					outputText("You spent much of your time fighting other children, and you had plans to find work as a guard when you grew up.  You do 10% more damage with physical melee attacks.  You will also start out with 50 gems and Job: Warrior perk.  Is this your history?");
					break;
				case PerkLib.HistoryFortune:
					outputText("You always feel lucky when it comes to fortune.  Because of that, you have always managed to save up gems until whatever's needed and how to make the most out it (+15% gems on victory).  You will also start out with 250 gems.  Is this your history?");
					break;
				case PerkLib.HistoryHealer:
					outputText("You often spent your free time with the village healer, learning how to tend to wounds.  Healing items and effects are 20% more effective.  Is this your history?");
					break;
				case PerkLib.HistoryReligious:
					outputText("You spent a lot of time at the village temple, and learned how to meditate.  The 'masturbation' option is replaced with 'meditate' when corruption is at or below 66.  Is this your history?");
					break;
				case PerkLib.HistoryScholar:
					outputText("You spent much of your time in school, and even begged the richest man in town, Mr. " + (silly() ? "Savin" : "Sellet") + ", to let you read some of his books.  You are much better at focusing, spellcasting uses 20% less fatigue and will start with Job: Sorcerer perk.  Is this your history?");
					break;
				case PerkLib.HistoryScout:
					outputText("You spent much of your time learning use range weapons, and you had plans to find work as a hunter when you grew up.  You do 10% more damage with physical range attacks and +20% accuracy.  You will also start out with 50 gems and Job: Ranger perk.  Is this your history?");
					break;
				case PerkLib.HistorySlacker:
					outputText("You spent a lot of time slacking, avoiding work, and otherwise making a nuisance of yourself.  Your efforts at slacking have made you quite adept at resting, and your fatigue comes back 20% faster.  Is this your history?");
					break;
				case PerkLib.HistorySlut:
					outputText("You managed to spend most of your time having sex.  Quite simply, when it came to sex, you were the village bicycle - everyone got a ride.  Because of this, your body is a bit more resistant to penetrative stretching, and has a higher upper limit on what exactly can be inserted.  Is this your history?");
					break;
				case PerkLib.HistorySmith:
					outputText("You managed to get an apprenticeship with the local blacksmith.  Because of your time spent at the blacksmith's side, you've learned how to fit armor for maximum protection.  You will start with Job: Guardian perk.  Is this your history?");
					break;
				default:
					outputText("You managed to find work as a whore.  Because of your time spent trading seduction for profit, you're more effective at teasing (+15% tease damage).  You will start with Job: Seducer perk.  Is this your history?");
			}
			menu();
			addButton(0, "Yes", setHistory, choice);
			addButton(1, "No", chooseHistory);
		}

		private function setHistory(choice:PerkType):void {
			player.createPerk(choice, 0, 0, 0, 0);
			if (choice == PerkLib.HistorySlut || choice == PerkLib.HistoryWhore || player.findPerk(PerkLib.PastLifeSlut) >= 0 || player.findPerk(PerkLib.PastLifeWhore) >= 0) {
				if (player.hasVagina()) {
					player.vaginas[0].virgin = false;
					player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
				}
				player.ass.analLooseness = 1;
			}
			if (choice == PerkLib.HistoryFighter || choice == PerkLib.HistoryWhore || choice == PerkLib.HistoryScout) {
				player.gems += 50;
			}
			if (choice == PerkLib.HistoryFortune) {
				player.gems += 250;
			}
			if (flags[kFLAGS.HISTORY_PERK_SELECTED] == 0) {
				flags[kFLAGS.HISTORY_PERK_SELECTED] = 1;
				completeCharacterCreation();
			}
			else { //Special escape clause for very old saves that do not have a history perk. This is used to allow them the chance to select a perk at camp on load.
				flags[kFLAGS.HISTORY_PERK_SELECTED] = 1;
				playerMenu();
			}
			
		}
		
		private function completeCharacterCreation():void {
			clearOutput();
			if (customPlayerProfile != null) {
				customPlayerProfile();
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) doNext(chooseGameModes);
				else doNext(startTheGame);
				return;
			}
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) chooseGameModes();
			else startTheGame();
		}
			
		public function arrival():void {
			statScreenRefresh();
			model.time.hours = 11;
			clearOutput();
			outputText("You are prepared for what is to come.  Most of the last year has been spent honing your body and mind to prepare for the challenges ahead.  You are the Champion of Ingnam.  The one who will journey to the demon realm and guarantee the safety of your friends and family, even though you'll never see them again.  You wipe away a tear as you enter the courtyard and see Elder Nomur waiting for you.  You are ready.\n\n");
			outputText("The walk to the tainted cave is long and silent.  Elder Nomur does not speak.  There is nothing left to say.  The two of you journey in companionable silence.  Slowly the black rock of Mount Ilgast looms closer and closer, and the temperature of the air drops.   You shiver and glance at the Elder, noticing he doesn't betray any sign of the cold.  Despite his age of nearly 80, he maintains the vigor of a man half his age.  You're glad for his strength, as assisting him across this distance would be draining, and you must save your energy for the trials ahead.\n\n");
			outputText("The entrance of the cave gapes open, sharp stalactites hanging over the entrance, giving it the appearance of a monstrous mouth.  Elder Nomur stops and nods to you, gesturing for you to proceed alone.\n\n");
			outputText("The cave is unusually warm and damp, ");
			if (player.gender == GENDER_FEMALE)
				outputText("and your body seems to feel the same way, flushing as you feel a warmth and dampness between your thighs. ");
			else outputText("and your body reacts with a sense of growing warmth focusing in your groin, your manhood hardening for no apparent reason. ");
			outputText("You were warned of this and press forward, ignoring your body's growing needs.  A glowing purple-pink portal swirls and flares with demonic light along the back wall.  Cringing, you press forward, keenly aware that your body seems to be anticipating coming in contact with the tainted magical construct.  Closing your eyes, you gather your resolve and leap forwards.  Vertigo overwhelms you and you black out...");
			showStats();
			dynStats("lus", 15);
			doNext(arrivalPartTwo);
		}
		
		private function arrivalPartTwo():void {
			clearOutput();
			hideUpDown();
			dynStats("lus", 40, "cor", 2);
			model.time.hours = 18;
			outputText("You wake with a splitting headache and a body full of burning desire.  A shadow darkens your view momentarily and your training kicks in.  You roll to the side across the bare ground and leap to your feet.  A surprised looking imp stands a few feet away, holding an empty vial.  He's completely naked, an improbably sized pulsing red cock hanging between his spindly legs.  You flush with desire as a wave of lust washes over you, your mind reeling as you fight ");
			if (player.gender == GENDER_FEMALE)
				outputText("the urge to chase down his rod and impale yourself on it.\n\n");
			else
				outputText("the urge to ram your cock down his throat.  The strangeness of the thought surprises you.\n\n");
			outputText("The imp says, \"<i>I'm amazed you aren't already chasing down my cock, human.  The last Champion was an eager whore for me by the time she woke up.  This lust draft made sure of it.</i>\"");
			doNext(arrivalPartThree);
		}
		
		private function arrivalPartThree():void {
			clearOutput();
			hideUpDown();
			dynStats("lus", -30);
			outputText("The imp shakes the empty vial to emphasize his point.  You reel in shock at this revelation - you've just entered the demon realm and you've already been drugged!  You tremble with the aching need in your groin, but resist, righteous anger lending you strength.\n\nIn desperation you leap towards the imp, watching with glee as his cocky smile changes to an expression of sheer terror.  The smaller creature is no match for your brute strength as you pummel him mercilessly.  You pick up the diminutive demon and punt him into the air, frowning grimly as he spreads his wings and begins speeding into the distance.\n\n");
			outputText("The imp says, \"<i>FOOL!  You could have had pleasure unending... but should we ever cross paths again you will regret humiliating me!  Remember the name Zetaz, as you'll soon face the wrath of my master!</i>\"\n\n");
			outputText("Your pleasure at defeating the demon ebbs as you consider how you've already been defiled.  You swear to yourself you will find the demon responsible for doing this to you and the other Champions, and destroy him AND his pet imp.");
			doNext(arrivalPartFour);
		}
		
		private function arrivalPartFour():void {
			clearOutput();
			hideUpDown();
			outputText("You look around, surveying the hellish landscape as you plot your next move.  The portal is a few yards away, nestled between a formation of rocks.  It does not seem to exude the arousing influence it had on the other side.  The ground and sky are both tinted different shades of red, though the earth beneath your feet feels as normal as any other lifeless patch of dirt.   You settle on the idea of making a camp here and fortifying this side of the portal.  No demons will ravage your beloved hometown on your watch.\n\nIt does not take long to set up your tent and a few simple traps.  You'll need to explore and gather more supplies to fortify it any further.  Perhaps you will even manage to track down the demons who have been abducting the other champions!");
			awardAchievement("Newcomer", kACHIEVEMENTS.STORY_NEWCOMER, true, true);
			doNext(playerMenu);
		}
		
		//-----------------
		//-- GAME MODES
		//-----------------
		private function chooseModeNormal():void {
			clearOutput();
			outputText("You have chosen Normal Mode. This is a classic gameplay mode. \n\n<b>Difficulty can be adjusted at any time.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 0;
			flags[kFLAGS.HUNGER_ENABLED] = 0;
			flags[kFLAGS.GAME_DIFFICULTY] = 0;
			doNext(startTheGame);
		}	

		private function chooseModeSurvival():void {
			clearOutput();
			outputText("You have chosen Survival Mode. This is similar to the normal mode but with hunger enabled. \n\n<b>Difficulty can be adjusted at any time.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 0;
			flags[kFLAGS.HUNGER_ENABLED] = 0.5;
			flags[kFLAGS.GAME_DIFFICULTY] = 0;
			player.hunger = 80;
			doNext(startTheGame);
		}	

		private function chooseModeRealistic():void {
			clearOutput();
			outputText("You have chosen Realistic Mode. In this mode, hunger is enabled so you have to eat periodically. Also, your cum production is capped and having oversized parts will weigh you down. \n\n<b>Difficulty can be adjusted at any time.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 0;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 0;
			player.hunger = 80;
			doNext(startTheGame);
		}	

		private function chooseModeHardcore():void {
			clearOutput();
			outputText("You have chosen Hardcore Mode. In this mode, hunger is enabled so you have to eat periodically. In addition, the game forces autosave and if you encounter a Bad End, your save file is <b>DELETED</b>! \n\nDebug Mode and Easy Mode are disabled in this game mode. \n\nPlease choose a slot to save in. You may not make multiple copies of saves. \n\n<b>Difficulty is locked to hard.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 1;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 1;
			player.hunger = 80;
			menu();
			for (var i:int = 0; i < 14; i++) {
				addButton(i, "Slot " + (i + 1), chooseSlotHardcore, (i + 1));
			}
			addButton(14, "Back", chooseGameModes);
		}

		private function chooseModeBrutalHardcore():void {
			clearOutput();
			outputText("You have chosen Brutal Hardcore Mode. This is the HARDEST mode of all. \n\n<b>Difficulty is locked to <i>EXTREME</i>.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 1;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 3;
			player.hunger = 80;
			menu();
			for (var i:int = 0; i < 14; i++) {
				addButton(i, "Slot " + (i + 1), chooseSlotHardcore, (i + 1));
			}
			addButton(14, "Back", chooseGameModes);
		}	

		private function chooseModeXianxia():void {
			clearOutput();
			outputText("You have chosen Xianxia MC Mode. This is the mode to fell like a true XIANXIA MC. \n\n<b>Difficulty is locked to <i>XIANXIA</i>.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 1;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 4;
			player.hunger = 80;
			menu();
			for (var i:int = 0; i < 14; i++) {
				addButton(i, "Slot " + (i + 1), chooseSlotHardcore, (i + 1));
			}
			addButton(14, "Back", chooseGameModes);
		}

		//Choose Hardcore slot.
		private function chooseSlotHardcore(num:int):void {
			flags[kFLAGS.HARDCORE_SLOT] = "CoC_" + num;
			startTheGame();
		}	

		//Choose the game mode when called!
		private function chooseGameModes():void {
			clearOutput();
			outputText("Choose a game mode.\n\n");
			outputText("<b>Normal mode:</b> Classic Corruption of Champions gameplay.\n");
			outputText("<b>Survival mode:</b> Like normal but with hunger enabled.\n");
			outputText("<b>Realistic mode:</b> You get hungry from time to time and cum production is capped. In addition, it's a bad idea to have oversized parts. \n");
			outputText("<b>Hardcore mode:</b> In addition to Realistic mode, the game forces save and if you get a Bad End, your save file is deleted. For the veteran CoC players only.\n");
			outputText("<b>Brutal Hardcore mode:</b> The hardest game mode ever. Like hardcore mode, but the difficulty is locked to extreme! How long can you survive?\n");
			outputText("<b>Xianxia MC mode:</b> The game mode for everyone that want feel like an every Xianxia MC. Hunger waiting behind a corner and enemies are always stronger than you! How long will take to you to reach top dog position?\n");
			menu();
			addButton(0, "Normal", chooseModeNormal);
			addButton(1, "Survival", chooseModeSurvival);
			addButton(2, "Realistic", chooseModeRealistic);
			addButton(3, "Hardcore", chooseModeHardcore);
			addButton(5, "Brutal HC", chooseModeBrutalHardcore);
			addButton(6, "Xianxia MC", chooseModeXianxia);
		}

		private function startTheGame():void {
			player.startingRace = player.race();
			if (flags[kFLAGS.HARDCORE_MODE] > 0) {
				trace("Hardcore save file " + flags[kFLAGS.HARDCORE_SLOT] + " created.");
				getGame().saves.saveGame(flags[kFLAGS.HARDCORE_SLOT])
			}
			kGAMECLASS.saves.loadPermObject();
			flags[kFLAGS.MOD_SAVE_VERSION] = kGAMECLASS.modSaveVersion;
			statScreenRefresh();
			chooseToPlay();
			return;
		}

		public function chooseToPlay():void {
			if (player.femininity >= 55) player.setUndergarment(undergarments.C_PANTY);
			else player.setUndergarment(undergarments.C_LOIN);
			if (player.biggestTitSize() >= 2) player.setUndergarment(undergarments.C_BRA);
			else player.setUndergarment(undergarments.C_SHIRT);
			if (player.findPerk(PerkLib.HistoryCultivator) >= 0 || player.findPerk(PerkLib.PastLifeCultivator) >= 0) player.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
			if (player.findPerk(PerkLib.HistoryFighter) >= 0 || player.findPerk(PerkLib.PastLifeFighter) >= 0) player.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
			if (player.findPerk(PerkLib.HistoryScout) >= 0 || player.findPerk(PerkLib.PastLifeScout) >= 0) player.createPerk(PerkLib.JobRanger, 0, 0, 0, 0);
			if (player.findPerk(PerkLib.HistoryScholar) >= 0 || player.findPerk(PerkLib.PastLifeScholar) >= 0) player.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			if (player.findPerk(PerkLib.HistorySmith) >= 0 || player.findPerk(PerkLib.PastLifeSmith) >= 0) player.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			if (player.findPerk(PerkLib.HistoryWhore) >= 0 || player.findPerk(PerkLib.PastLifeWhore) >= 0) player.createPerk(PerkLib.JobSeducer, 0, 0, 0, 0);
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0 || player.findPerk(PerkLib.HistoryFortune) >= 0 || player.findPerk(PerkLib.HistoryHealer) >= 0 || player.findPerk(PerkLib.HistoryReligious) >= 0 || player.findPerk(PerkLib.HistorySlacker) >= 0 || player.findPerk(PerkLib.HistorySlut) >= 0) player.perkPoints += 1;
			if (player.findPerk(PerkLib.PastLifeAlchemist) >= 0) player.perkPoints += 1;
			if (player.findPerk(PerkLib.PastLifeFortune) >= 0) player.perkPoints += 1;
			if (player.findPerk(PerkLib.PastLifeHealer) >= 0) player.perkPoints += 1;
			if (player.findPerk(PerkLib.PastLifeReligious) >= 0) player.perkPoints += 1;
			if (player.findPerk(PerkLib.PastLifeSlacker) >= 0) player.perkPoints += 1;
			if (player.findPerk(PerkLib.PastLifeSlut) >= 0) player.perkPoints += 1;
			if (player.findPerk(PerkLib.AscensionHerosHeritage) >= 0) {
				player.perkPoints += 3 * player.newGamePlusMod();
				player.statPoints += 15 * player.newGamePlusMod();
			}
			if (player.findPerk(PerkLib.AscensionHerosLineage) >= 0) {
				player.perkPoints += 2 * player.newGamePlusMod();
				player.statPoints += 10 * player.newGamePlusMod();
			}
			if (player.findPerk(PerkLib.AscensionNaturalMetamorph) >= 0) {
				player.createPerk(PerkLib.GeneticMemory, 0, 0, 0, 0);
				player.createPerk(PerkLib.Metamorph, 0, 0, 0, 0);
			}
			clearOutput();
			statScreenRefresh();
			outputText("Would you like to play through the " + (1 * (1 + player.newGamePlusMod())) + "-day");
			if (player.newGamePlusMod() > 0) outputText("s");
			outputText(" prologue in Ingnam or just skip?");
			player.HP = player.maxHP();
			doYesNo(goToIngnam, arrival);
		}

		public function goToIngnam():void {
			model.time.days = -(1 * (1 + player.newGamePlusMod()));
			model.time.hours = 8;
			flags[kFLAGS.IN_INGNAM] = 1;
			kGAMECLASS.ingnam.menuIngnam();
		}

		//-----------------
		//-- ASCENSION
		//-----------------
		public function ascensionMenu():void {
			hideStats();
			clearOutput();
			hideMenus();
			mainView.nameBox.visible = false;
			kGAMECLASS.displayHeader("Ascension");
			outputText("The world you have departed is irrelevant and you are in an endless black void dotted with tens of thousands of stars. You encompass everything and everything encompasses you.");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			outputText("\n\n(When you're done, select Reincarnate.)");
			menu();
			addButton(0, "Perk Select(1)", ascensionPerkMenu).hint("Spend Ascension Perk Points on special perks!", "Perk Selection");
			addButton(1, "Perk Select(2)", ascensionPerkMenu2).hint("Spend Ascension Perk Points on special perks!", "Perk Selection");
			addButton(2, "Rare Perks(1)", rarePerks).hint("Spend Ascension Points on rare special perks!", "Perk Selection");
			addButton(5, "Perm Perks", ascensionPermeryMenu).hint("Spend Ascension Perk Points to make certain perks permanent (5 per perk).", "Perk Selection");
			if (player.ascensionPerkPoints >= 5) addButton(6, "Past Life", historyTopastlife).hint("Spend Ascension Points to change current possesed History perk into Past Life perk (5 per perk).", "Perk Selection");
			addButton(10, "Rename", renamePrompt).hint("Change your name at no charge?");
			addButton(11, "Reincarnate", reincarnatePrompt).hint("Reincarnate and start an entirely new adventure?");
		}
		private function ascensionPerkMenu():void {
			clearOutput();
			outputText("You can spend your Ascension Perk Points on special perks not available at level-up!");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			addButton(0, "Mysticality", ascensionPerkSelection, PerkLib.AscensionMysticality, MAX_MYSTICALITY_LEVEL, null, PerkLib.AscensionMysticality.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionMysticality) + " / " + MAX_MYSTICALITY_LEVEL);
			addButton(1, "S.Enlight.", ascensionPerkSelection, PerkLib.AscensionSpiritualEnlightenment, MAX_SPIRITUALENLIGHTENMENT_LEVEL, null, PerkLib.AscensionSpiritualEnlightenment.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionSpiritualEnlightenment) + " / " + MAX_SPIRITUALENLIGHTENMENT_LEVEL);
			addButton(2, "Fortune", ascensionPerkSelection, PerkLib.AscensionFortune, MAX_FORTUNE_LEVEL, null, PerkLib.AscensionFortune.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionFortune) + " (No maximum level)");
			addButton(3, "Moral Shifter", ascensionPerkSelection, PerkLib.AscensionMoralShifter, MAX_MORALSHIFTER_LEVEL, null, PerkLib.AscensionMoralShifter.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionMoralShifter) + " / " + MAX_MORALSHIFTER_LEVEL);
			addButton(4, "Tolerance", ascensionPerkSelection, PerkLib.AscensionTolerance, MAX_TOLERANCE_LEVEL, null, PerkLib.AscensionTolerance.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionTolerance) + " / " + MAX_TOLERANCE_LEVEL);
			addButton(5, "Fertility", ascensionPerkSelection, PerkLib.AscensionFertility, MAX_FERTILITY_LEVEL, null, PerkLib.AscensionFertility.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionFertility) + " / " + MAX_FERTILITY_LEVEL);
			addButton(6, "Virility", ascensionPerkSelection, PerkLib.AscensionVirility, MAX_VIRILITY_LEVEL, null, PerkLib.AscensionVirility.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionVirility) + " / " + MAX_VIRILITY_LEVEL);
			addButton(7, "Wisdom", ascensionPerkSelection, PerkLib.AscensionWisdom, MAX_WISDOM_LEVEL, null, PerkLib.AscensionWisdom.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionWisdom) + " / " + MAX_WISDOM_LEVEL);
			addButton(14, "Back", ascensionMenu);
		}
		private function ascensionPerkMenu2():void {
			clearOutput();
			outputText("You can spend your Ascension Perk Points on special perks not available at level-up!");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			addButton(0, "Desires", ascensionPerkSelection2, PerkLib.AscensionDesires, MAX_DESIRES_LEVEL, null, PerkLib.AscensionDesires.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionDesires) + " / " + MAX_DESIRES_LEVEL);
			addButton(1, "Endurance", ascensionPerkSelection2, PerkLib.AscensionEndurance, MAX_ENDURANCE_LEVEL, null, PerkLib.AscensionEndurance.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionEndurance) + " / " + MAX_ENDURANCE_LEVEL);
			addButton(2, "Hardiness", ascensionPerkSelection2, PerkLib.AscensionHardiness, MAX_HARDINESS_LEVEL, null, PerkLib.AscensionHardiness.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionHardiness) + " / " + MAX_HARDINESS_LEVEL);
			addButton(3, "Soul Purity", ascensionPerkSelection2, PerkLib.AscensionSoulPurity, MAX_SOULPURITY_LEVEL, null, PerkLib.AscensionSoulPurity.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionSoulPurity) + " / " + MAX_SOULPURITY_LEVEL);
			addButton(4, "Inner Power", ascensionPerkSelection2, PerkLib.AscensionInnerPower, MAX_INNERPOWER_LEVEL, null, PerkLib.AscensionInnerPower.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionInnerPower) + " / " + MAX_INNERPOWER_LEVEL);
			addButton(5, "Fury", ascensionPerkSelection2, PerkLib.AscensionFury, MAX_FURY_LEVEL, null, PerkLib.AscensionFury.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionFury) + " / " + MAX_FURY_LEVEL);
			addButton(6, "Transhuman.", ascensionPerkSelection2, PerkLib.AscensionTranshumanism, MAX_TRANSHUMANISM_LEVEL, null, PerkLib.AscensionTranshumanism.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionTranshumanism) + " / " + MAX_TRANSHUMANISM_LEVEL);
			addButton(14, "Back", ascensionMenu);
		}
		
		private function ascensionPerkSelection(perk:* = null, maxLevel:int = 10):void {
			clearOutput();
			outputText("Perk Effect: " + perk.longDesc);
			outputText("\nCurrent level: " + player.perkv1(perk) + (maxLevel > 0 ? " / " + maxLevel : " (No maximum level)") + "");
			if (player.perkv1(perk) >= maxLevel && maxLevel > 0) outputText(" <b>(Maximum)</b>");
			var cost:int = player.perkv1(perk) + 1;
			if (cost > 5) cost = 5;
			if (player.perkv1(perk) < maxLevel || maxLevel < 0) outputText("\nCost for next level: " + cost);
			else outputText("\nCost for next level: <b>N/A</b>");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			if (player.ascensionPerkPoints >= cost && (player.perkv1(perk) < maxLevel || maxLevel < 0)) addButton(0, "Add 1 level", addAscensionPerk, perk, maxLevel);
			addButton(4, "Back", ascensionPerkMenu);
		}
		private function addAscensionPerk(perk:* = null, maxLevel:int = 10):void {
			var cost:int = player.perkv1(perk) + 1;
			if (cost > 5) cost = 5;
			player.ascensionPerkPoints -= cost;
			if (player.findPerk(perk) >= 0) player.addPerkValue(perk, 1, 1);
			else player.createPerk(perk, 1, 0, 0, 0);
			ascensionPerkSelection(perk, maxLevel);
		}
		private function ascensionPerkSelection2(perk:* = null, maxRank:int = 10):void {
			clearOutput();
			var maxRank:int = 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) maxRank += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2) maxRank += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3) maxRank += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 4) maxRank += 5;
			//if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 5) maxRank += 5;
			//if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 6) maxRank += 5;
			//if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 7) maxRank += 5;
			//if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 8) maxRank += 5;
			outputText("Perk Effect: " + perk.longDesc);
			outputText("\nCurrent level: " + player.perkv1(perk) + " / " + maxRank + "");
			if (player.perkv1(perk) >= 25) outputText(" <b>(Maximum)</b>");
			var cost:int = player.perkv1(perk) + 1;
			if (cost > 5) cost = 5;
			if (player.perkv1(perk) < 25) outputText("\nCost for next level: " + cost);
			else outputText("\nCost for next level: <b>N/A</b>");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			if (player.ascensionPerkPoints >= cost && player.perkv1(perk) < maxRank) addButton(0, "Add 1 level", addAscensionPerk2, perk, maxRank);
			if (player.ascensionPerkPoints >= cost && player.perkv1(perk) == maxRank && player.perkv1(perk) < 20) addButtonDisabled(0, "Add 1 level", "You've reached max rank for this perk at current tier of ascension. To unlock higher ranks you need to ascend again.");
			addButton(4, "Back", ascensionPerkMenu2);
		}
		private function addAscensionPerk2(perk:* = null, maxRank:int = 10):void {
			var cost:int = player.perkv1(perk) + 1;
			if (cost > 5) cost = 5;
			player.ascensionPerkPoints -= cost;
			if (player.findPerk(perk) >= 0) player.addPerkValue(perk, 1, 1);
			else player.createPerk(perk, 1, 0, 0, 0);
			ascensionPerkSelection2(perk, maxRank);
		}
		
		private function rarePerks():void {
			clearOutput();
			outputText("You can spend your Ascension Perk Points on rare special perks not available at level-up!");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			var btn:int = 0;
			if (player.ascensionPerkPoints >= 5 && player.findPerk(PerkLib.AscensionHerosHeritage) < 0) addButton(btn, "HeroHeritage", perkHerosHeritage).hint("Perk giving additional 3 perk points and 15 stat points at the start of the game (scalling with current NG tier).\n\nCost: 5 points");
			else if (player.ascensionPerkPoints < 5 && player.findPerk(PerkLib.AscensionHerosHeritage) < 0) addButtonDisabled(btn, "HeroHeritage", "You not have enough ascension perk points!");
			else addButtonDisabled(btn, "HeroHeritage", "You already bought this perk.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.findPerk(PerkLib.AscensionHerosHeritage) >= 0) {
				if (player.ascensionPerkPoints >= 5 && player.findPerk(PerkLib.AscensionHerosLineage) < 0) addButton(btn, "HeroLineage", perkHerosLineage).hint("Perk giving additional 2 perk points and 10 stat points at the start of the game (scalling with current NG tier).\n\nCost: 5 points");
				else if (player.ascensionPerkPoints < 5) button(btn).disable("You not have enough ascension perk points!");
				else addButtonDisabled(btn, "HeroLineage", "You already bought this perk.");
			}
			else addButtonDisabled(btn, "HeroLineage", "You need ascend more times to buy this perk.");
			btn++;
			if (player.ascensionPerkPoints >= 10 && player.findPerk(PerkLib.AscensionHybridTheory) < 0) addButton(btn, "HybridTheory", perkHybridTheory).hint("Perk allowing reduce by one req. race points to recive race bonuses (still req. min 3 race points to work and/or other things like specific body part/perk).\n\nCost: 10 points");
			else if (player.ascensionPerkPoints < 10 && player.findPerk(PerkLib.AscensionHybridTheory) < 0) addButtonDisabled(btn, "HybridTheory", "You not have enough ascension perk points!");
			else addButtonDisabled(btn, "HybridTheory", "You already bought this perk.");
			btn++;
			if (player.ascensionPerkPoints >= 30 && player.findPerk(PerkLib.AscensionNaturalMetamorph) < 0) addButton(btn, "N.Metamorph", perkNaturalMetamorph).hint("Perk allowing to start with Genetic Memory and Metamorph perks.\n\nCost: 30 points");
			else if (player.ascensionPerkPoints < 30 && player.findPerk(PerkLib.AscensionNaturalMetamorph) < 0) addButtonDisabled(btn, "N.Metamorph", "You not have enough ascension perk points!");
			else addButtonDisabled(btn, "N.Metamorph", "You already bought this perk.");
			btn++;
			if (player.ascensionPerkPoints >= 5 && player.findPerk(PerkLib.AscensionUnderdog) < 0) addButton(btn, "Underdog", perkUnderdog).hint("Perk allowing to double increase to base exp gains for fighting enemies above PC level, increasing max lvl diff when bonus still increase from 20 to 40 above current PC lvl.\n\nCost: 5 points");// And... to live up to underdog role PC will 'accidentally' find few places to further power-up.
			else if (player.ascensionPerkPoints < 5 && player.findPerk(PerkLib.AscensionUnderdog) < 0) addButtonDisabled(btn, "Underdog", "You not have enough ascension perk points!");
			else addButtonDisabled(btn, "Underdog", "You already bought this perk.");
			btn++;
			if (player.ascensionPerkPoints >= 5 && player.findPerk(PerkLib.AscensionUnlockedPotential) < 0) addButton(btn, "UnlockPotent", perkUnlockedPotential).hint("Perk allowing to have increase passive gains of max hp, fatigue and mana at each lvl-up.\n\nCost: 5 point");
			else if (player.ascensionPerkPoints < 5 && player.findPerk(PerkLib.AscensionUnlockedPotential) < 0) addButtonDisabled(btn, "UnlockPotent", "You not have enough ascension perk points!");
			else addButtonDisabled(btn, "UnlockPotent", "You already bought this perk.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.findPerk(PerkLib.AscensionUnlockedPotential) >= 0) {
				if (player.ascensionPerkPoints >= 5 && player.findPerk(PerkLib.AscensionUnlockedPotential2ndStage) < 0) addButton(btn, "U.Potent2nd", perkUnlockedPotential2ndStage).hint("Perk allowing to have increase passive gains of max wrath, lust and soulforce at each lvl-up.\n\nCost: 5 point");
				else if (player.ascensionPerkPoints < 5) addButtonDisabled(btn, "U.Potent2nd", "You not have enough ascension perk points!");
				else addButtonDisabled(btn, "U.Potent2nd", "You already bought this perk.");
			}
			else addButtonDisabled(btn, "HeroLineage", "You need ascend more times to buy this perk.");
			btn++;
		//	if (player.ascensionPerkPoints >= 10 && player.findPerk(PerkLib.AscensionHybridTheory) < 0) addButton(btn, "HybridTheory", perkHybridTheory).hint("Perk allowing reduce by one req. race points to recive race bonuses (still req. min 3 race points to work).\n\nCost: 10 points");
		//	else if (player.ascensionPerkPoints < 10) addButtonDisabled(btn, "HybridTheory", "You not have enough ascension perk points!");
		//	else addButtonDisabled(btn, "HybridTheory", "You already bought this perk.");
		//	btn++;
		//	if (player.ascensionPerkPoints >= 10 && player.findPerk(PerkLib.AscensionHybridTheory) < 0) addButton(btn, "HybridTheory", perkHybridTheory).hint("Perk allowing reduce by one req. race points to recive race bonuses (still req. min 3 race points to work).\n\nCost: 10 points");
		//	else if (player.ascensionPerkPoints < 10) addButtonDisabled(btn, "HybridTheory", "You not have enough ascension perk points!");
		//	else addButtonDisabled(btn, "HybridTheory", "You already bought this perk.");
		//	btn++;
		//	if (player.ascensionPerkPoints >= 10 && player.findPerk(PerkLib.AscensionHybridTheory) < 0) addButton(btn, "HybridTheory", perkHybridTheory).hint("Perk allowing reduce by one req. race points to recive race bonuses (still req. min 3 race points to work).\n\nCost: 10 points");
		//	else if (player.ascensionPerkPoints < 10) addButtonDisabled(btn, "HybridTheory", "You not have enough ascension perk points!");
		//	else addButtonDisabled(btn, "HybridTheory", "You already bought this perk.");
		//	btn++;
		//	if (player.ascensionPerkPoints >= 10 && player.findPerk(PerkLib.AscensionHybridTheory) < 0) addButton(btn, "HybridTheory", perkHybridTheory).hint("Perk allowing reduce by one req. race points to recive race bonuses (still req. min 3 race points to work).\n\nCost: 10 points");
		//	else if (player.ascensionPerkPoints < 10) addButtonDisabled(btn, "HybridTheory", "You not have enough ascension perk points!");
		//	else addButtonDisabled(btn, "HybridTheory", "You already bought this perk.");
		//	btn++;
			addButton(14, "Back", ascensionMenu);
		}
		private function perkHerosHeritage():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionHerosHeritage,0,0,0,1);
			clearOutput();
			outputText("Your gained Hero's Heritage perk.");
			doNext(rarePerks);
		}
		private function perkHerosLineage():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionHerosLineage,0,0,0,1);
			clearOutput();
			outputText("Your gained Hero's Lineage perk.");
			doNext(rarePerks);
		}
		private function perkHybridTheory():void {
			player.ascensionPerkPoints -= 10;
			player.createPerk(PerkLib.AscensionHybridTheory,0,0,0,1);
			clearOutput();
			outputText("Your gained Hybrid Theory perk.");
			doNext(rarePerks);
		}
		private function perkNaturalMetamorph():void {
			player.ascensionPerkPoints -= 30;
			player.createPerk(PerkLib.AscensionNaturalMetamorph,0,0,0,1);
			clearOutput();
			outputText("Your gained Natural Metamorph perk.");
			doNext(rarePerks);
		}
		private function perkUnderdog():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionUnderdog,0,0,0,1);
			clearOutput();
			outputText("Your gained Underdog perk.");
			doNext(rarePerks);
		}
		private function perkUnlockedPotential():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionUnlockedPotential,0,0,0,1);
			clearOutput();
			outputText("Your gained Unlocked Potential perk.");
			doNext(rarePerks);
		}
		private function perkUnlockedPotential2ndStage():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionUnlockedPotential2ndStage,0,0,0,1);
			clearOutput();
			outputText("Your gained Unlocked Potential (2nd Stage) perk.");
			doNext(rarePerks);
		}

		private function historyTopastlife():void {
			if (player.findPerk(PerkLib.HistoryAlchemist) >= 0) {
				player.removePerk(PerkLib.HistoryAlchemist);
				player.createPerk(PerkLib.PastLifeAlchemist,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryCultivator) >= 0) {
				player.removePerk(PerkLib.HistoryCultivator);
				player.createPerk(PerkLib.PastLifeCultivator,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryFighter) >= 0) {
				player.removePerk(PerkLib.HistoryFighter);
				player.createPerk(PerkLib.PastLifeFighter,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryFortune) >= 0) {
				player.removePerk(PerkLib.HistoryFortune);
				player.createPerk(PerkLib.PastLifeFortune,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryHealer) >= 0) {
				player.removePerk(PerkLib.HistoryHealer);
				player.createPerk(PerkLib.PastLifeHealer,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryReligious) >= 0) {
				player.removePerk(PerkLib.HistoryReligious);
				player.createPerk(PerkLib.PastLifeReligious,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryScholar) >= 0) {
				player.removePerk(PerkLib.HistoryScholar);
				player.createPerk(PerkLib.PastLifeScholar,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryScout) >= 0) {
				player.removePerk(PerkLib.HistoryScout);
				player.createPerk(PerkLib.PastLifeScout,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistorySlacker) >= 0) {
				player.removePerk(PerkLib.HistorySlacker);
				player.createPerk(PerkLib.PastLifeSlacker,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistorySlut) >= 0) {
				player.removePerk(PerkLib.HistorySlut);
				player.createPerk(PerkLib.PastLifeSlut,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistorySmith) >= 0) {
				player.removePerk(PerkLib.HistorySmith);
				player.createPerk(PerkLib.PastLifeSmith,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.findPerk(PerkLib.HistoryWhore) >= 0) {
				player.removePerk(PerkLib.HistoryWhore);
				player.createPerk(PerkLib.PastLifeWhore,0,0,0,1);
				historyTopastlife2();
			}
			else {
				clearOutput();
				outputText("You not have any History perk to change into Past Life perk.");
			}
			doNext(ascensionMenu);
		}
		
		private function historyTopastlife2():void {
			player.ascensionPerkPoints -= 5;
			clearOutput();
			outputText("Your History perk became your Past Life perk.");
		}
		
		private function ascensionPermeryMenu(page:int = 1):void {
			clearOutput();
			outputText("For the price of five points, you can make certain perks permanent and they will carry over in future ascensions. In addition, if the perks come from transformations, they will stay even if you no longer meet the requirements.");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			if (page == 1) {
				if (player.findPerk(PerkLib.CorruptedKitsune) > 0 && player.perkv4(PerkLib.CorruptedKitsune) < 1) addButton(0, "CorruptedKitsune", permanentizePerk, PerkLib.CorruptedKitsune);
				else if (player.findPerk(PerkLib.CorruptedKitsune) > 0 && player.perkv4(PerkLib.CorruptedKitsune) > 0) addButtonDisabled(0, "CorruptedKitsune", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "CorruptedKitsune", "CorruptedKitsune");
				if (player.findPerk(PerkLib.CorruptedNinetails) > 0 && player.perkv4(PerkLib.CorruptedNinetails) < 1) addButton(1, "CorruptedNinetails", permanentizePerk, PerkLib.CorruptedNinetails);
				else if (player.findPerk(PerkLib.CorruptedNinetails) > 0 && player.perkv4(PerkLib.CorruptedNinetails) > 0) addButtonDisabled(1, "CorruptedNinetails", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "CorruptedNinetails", "CorruptedNinetails");
				if (player.findPerk(PerkLib.DarkCharm) > 0 && player.perkv4(PerkLib.DarkCharm) < 1) addButton(2, "DarkCharm", permanentizePerk, PerkLib.DarkCharm);
				else if (player.findPerk(PerkLib.DarkCharm) > 0 && player.perkv4(PerkLib.DarkCharm) > 0) addButtonDisabled(2, "DarkCharm", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "DarkCharm", "DarkCharm");
				if (player.findPerk(PerkLib.DragonFireBreath) > 0 && player.perkv4(PerkLib.DragonFireBreath) < 1) addButton(3, "DragonFireBreath", permanentizePerk, PerkLib.DragonFireBreath);
				else if (player.findPerk(PerkLib.DragonFireBreath) > 0 && player.perkv4(PerkLib.DragonFireBreath) > 0) addButtonDisabled(3, "DragonFireBreath", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "DragonFireBreath", "DragonFireBreath");
				addButton(4, "Next", ascensionPermeryMenu, page + 1);
				if (player.findPerk(PerkLib.DragonIceBreath) > 0 && player.perkv4(PerkLib.DragonIceBreath) < 1) addButton(5, "DragonIceBreath", permanentizePerk, PerkLib.DragonIceBreath);
				else if (player.findPerk(PerkLib.DragonIceBreath) > 0 && player.perkv4(PerkLib.DragonIceBreath) > 0) addButtonDisabled(5, "DragonIceBreath", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "DragonIceBreath", "DragonIceBreath");
				if (player.findPerk(PerkLib.EnlightenedKitsune) > 0 && player.perkv4(PerkLib.EnlightenedKitsune) < 1) addButton(6, "EnlightenedKitsune", permanentizePerk, PerkLib.EnlightenedKitsune);
				else if (player.findPerk(PerkLib.EnlightenedKitsune) > 0 && player.perkv4(PerkLib.EnlightenedKitsune) > 0) addButtonDisabled(6, "EnlightenedKitsune", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "EnlightenedKitsune", "EnlightenedKitsune");
				if (player.findPerk(PerkLib.EnlightenedNinetails) > 0 && player.perkv4(PerkLib.EnlightenedNinetails) < 1) addButton(7, "EnlightenedNinetails", permanentizePerk, PerkLib.EnlightenedNinetails);
				else if (player.findPerk(PerkLib.EnlightenedNinetails) > 0 && player.perkv4(PerkLib.EnlightenedNinetails) > 0) addButtonDisabled(7, "EnlightenedNinetails", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "EnlightenedNinetails", "EnlightenedNinetails");
				if (player.findPerk(PerkLib.FerasBoonAlpha) > 0 && player.perkv4(PerkLib.FerasBoonAlpha) < 1) addButton(8, "FerasBoonAlpha", permanentizePerk, PerkLib.FerasBoonAlpha);
				else if (player.findPerk(PerkLib.FerasBoonAlpha) > 0 && player.perkv4(PerkLib.FerasBoonAlpha) > 0) addButtonDisabled(8, "FerasBoonAlpha", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "FerasBoonAlpha", "FerasBoonAlpha");
				if (player.findPerk(PerkLib.FerasBoonBreedingBitch) > 0 && player.perkv4(PerkLib.FerasBoonBreedingBitch) < 1) addButton(10, "FerasBoonBreedingBitch", permanentizePerk, PerkLib.FerasBoonBreedingBitch);
				else if (player.findPerk(PerkLib.FerasBoonBreedingBitch) > 0 && player.perkv4(PerkLib.FerasBoonBreedingBitch) > 0) addButtonDisabled(10, "FerasBoonBreedingBitch", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "FerasBoonBreedingBitch", "FerasBoonBreedingBitch");
				if (player.findPerk(PerkLib.FerasBoonMilkingTwat) > 0 && player.perkv4(PerkLib.FerasBoonMilkingTwat) < 1) addButton(11, "FerasBoonMilkingTwat", permanentizePerk, PerkLib.FerasBoonMilkingTwat);
				else if (player.findPerk(PerkLib.FerasBoonMilkingTwat) > 0 && player.perkv4(PerkLib.FerasBoonMilkingTwat) > 0) addButtonDisabled(11, "FerasBoonMilkingTwat", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "FerasBoonMilkingTwat", "FerasBoonMilkingTwat");
				if (player.findPerk(PerkLib.FerasBoonSeeder) > 0 && player.perkv4(PerkLib.FerasBoonSeeder) < 1) addButton(12, "FerasBoonSeeder", permanentizePerk, PerkLib.FerasBoonSeeder);
				else if (player.findPerk(PerkLib.FerasBoonSeeder) > 0 && player.perkv4(PerkLib.FerasBoonSeeder) > 0) addButtonDisabled(12, "FerasBoonSeeder", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "FerasBoonSeeder", "FerasBoonSeeder");
				if (player.findPerk(PerkLib.FireLord) > 0 && player.perkv4(PerkLib.FireLord) < 1) addButton(13, "FireLord", permanentizePerk, PerkLib.FireLord);
				else if (player.findPerk(PerkLib.FireLord) > 0 && player.perkv4(PerkLib.FireLord) > 0) addButtonDisabled(13, "FireLord", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "FireLord", "FireLord");
			}
			if (page == 2) {
				if (player.findPerk(PerkLib.Flexibility) > 0 && player.perkv4(PerkLib.Flexibility) < 1) addButton(0, "Flexibility", permanentizePerk, PerkLib.Flexibility);
				else if (player.findPerk(PerkLib.Flexibility) > 0 && player.perkv4(PerkLib.Flexibility) > 0) addButtonDisabled(0, "Flexibility", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "Flexibility", "Flexibility");
				if (player.findPerk(PerkLib.Hellfire) > 0 && player.perkv4(PerkLib.Hellfire) < 1) addButton(1, "Hellfire", permanentizePerk, PerkLib.Hellfire);
				else if (player.findPerk(PerkLib.Hellfire) > 0 && player.perkv4(PerkLib.Hellfire) > 0) addButtonDisabled(1, "Hellfire", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "Hellfire", "Hellfire");
				if (player.findPerk(PerkLib.InkSpray) > 0 && player.perkv4(PerkLib.InkSpray) < 1) addButton(2, "InkSpray", permanentizePerk, PerkLib.InkSpray);
				else if (player.findPerk(PerkLib.InkSpray) > 0 && player.perkv4(PerkLib.InkSpray) > 0) addButtonDisabled(2, "InkSpray", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "InkSpray", "InkSpray");
				if (player.findPerk(PerkLib.LizanRegeneration) > 0 && player.perkv4(PerkLib.LizanRegeneration) < 1) addButton(3, "LizanRegeneration", permanentizePerk, PerkLib.LizanRegeneration);
				else if (player.findPerk(PerkLib.LizanRegeneration) > 0 && player.perkv4(PerkLib.LizanRegeneration) > 0) addButtonDisabled(3, "LizanRegeneration", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "LizanRegeneration", "LizanRegeneration");
				addButton(4, "Next", ascensionPermeryMenu, page + 1);
				if (player.findPerk(PerkLib.Lustzerker) > 0 && player.perkv4(PerkLib.Lustzerker) < 1) addButton(5, "Lustzerker", permanentizePerk, PerkLib.Lustzerker);
				else if (player.findPerk(PerkLib.Lustzerker) > 0 && player.perkv4(PerkLib.Lustzerker) > 0) addButtonDisabled(5, "Lustzerker", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "Lustzerker", "Lustzerker");
				if (player.findPerk(PerkLib.MagicalFertility) > 0 && player.perkv4(PerkLib.MagicalFertility) < 1) addButton(6, "MagicalFertility", permanentizePerk, PerkLib.MagicalFertility);
				else if (player.findPerk(PerkLib.MagicalFertility) > 0 && player.perkv4(PerkLib.MagicalFertility) > 0) addButtonDisabled(6, "MagicalFertility", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "MagicalFertility", "MagicalFertility");
				if (player.findPerk(PerkLib.MagicalVirility) > 0 && player.perkv4(PerkLib.MagicalVirility) < 1) addButton(7, "MagicalVirility", permanentizePerk, PerkLib.MagicalVirility);
				else if (player.findPerk(PerkLib.MagicalVirility) > 0 && player.perkv4(PerkLib.MagicalVirility) > 0) addButtonDisabled(7, "MagicalVirility", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "MagicalVirility", "MagicalVirility");
				if (player.findPerk(PerkLib.MaraesGiftButtslut) > 0 && player.perkv4(PerkLib.MaraesGiftButtslut) < 1) addButton(8, "MaraesGiftButtslut", permanentizePerk, PerkLib.MaraesGiftButtslut);
				else if (player.findPerk(PerkLib.MaraesGiftButtslut) > 0 && player.perkv4(PerkLib.MaraesGiftButtslut) > 0) addButtonDisabled(8, "MaraesGiftButtslut", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "MaraesGiftButtslut", "MaraesGiftButtslut");
				addButton(9, "Previous", ascensionPermeryMenu, page - 1);
				if (player.findPerk(PerkLib.MaraesGiftFertility) > 0 && player.perkv4(PerkLib.MaraesGiftFertility) < 1) addButton(10, "MaraesGiftFertility", permanentizePerk, PerkLib.MaraesGiftFertility);
				else if (player.findPerk(PerkLib.MaraesGiftFertility) > 0 && player.perkv4(PerkLib.MaraesGiftFertility) > 0) addButtonDisabled(10, "MaraesGiftFertility", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "MaraesGiftFertility", "MaraesGiftFertility");
				if (player.findPerk(PerkLib.MaraesGiftProfractory) > 0 && player.perkv4(PerkLib.MaraesGiftProfractory) < 1) addButton(11, "MaraesGiftProfractory", permanentizePerk, PerkLib.MaraesGiftProfractory);
				else if (player.findPerk(PerkLib.MaraesGiftProfractory) > 0 && player.perkv4(PerkLib.MaraesGiftProfractory) > 0) addButtonDisabled(11, "MaraesGiftProfractory", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "MaraesGiftProfractory", "MaraesGiftProfractory");
				if (player.findPerk(PerkLib.MaraesGiftStud) > 0 && player.perkv4(PerkLib.MaraesGiftStud) < 1) addButton(12, "MaraesGiftStud", permanentizePerk, PerkLib.MaraesGiftStud);
				else if (player.findPerk(PerkLib.MaraesGiftStud) > 0 && player.perkv4(PerkLib.MaraesGiftStud) > 0) addButtonDisabled(12, "MaraesGiftStud", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "MaraesGiftStud", "MaraesGiftStud");
				if (player.findPerk(PerkLib.MilkMaid) > 0 && player.perkv4(PerkLib.MilkMaid) < 1) addButton(13, "MilkMaid", permanentizePerk, PerkLib.MilkMaid);
				else if (player.findPerk(PerkLib.MilkMaid) > 0 && player.perkv4(PerkLib.MilkMaid) > 0) addButtonDisabled(13, "MilkMaid", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "MilkMaid", "MilkMaid");
			}
			if (page == 3) {
				if (player.findPerk(PerkLib.NinetailsKitsuneOfBalance) > 0 && player.perkv4(PerkLib.NinetailsKitsuneOfBalance) < 1) addButton(0, "9T KitsuneOfBalance", permanentizePerk, PerkLib.NinetailsKitsuneOfBalance);
				else if (player.findPerk(PerkLib.NinetailsKitsuneOfBalance) > 0 && player.perkv4(PerkLib.NinetailsKitsuneOfBalance) > 0) addButtonDisabled(0, "9T KitsuneOfBalance", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "9T KitsuneOfBalance", "9T KitsuneOfBalance");
				if (player.findPerk(PerkLib.OneTrackMind) > 0 && player.perkv4(PerkLib.OneTrackMind) < 1) addButton(1, "OneTrackMind", permanentizePerk, PerkLib.OneTrackMind);
				else if (player.findPerk(PerkLib.OneTrackMind) > 0 && player.perkv4(PerkLib.OneTrackMind) > 0) addButtonDisabled(1, "OneTrackMind", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "OneTrackMind", "OneTrackMind");
				if (player.findPerk(PerkLib.PureAndLoving) > 0 && player.perkv4(PerkLib.PureAndLoving) < 1) addButton(2, "PureAndLoving", permanentizePerk, PerkLib.PureAndLoving);
				else if (player.findPerk(PerkLib.PureAndLoving) > 0 && player.perkv4(PerkLib.PureAndLoving) > 0) addButtonDisabled(2, "PureAndLoving", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "PureAndLoving", "PureAndLoving");
				if (player.findPerk(PerkLib.PurityBlessing) > 0 && player.perkv4(PerkLib.PurityBlessing) < 1) addButton(3, "PurityBlessing", permanentizePerk, PerkLib.PurityBlessing);
				else if (player.findPerk(PerkLib.PurityBlessing) > 0 && player.perkv4(PerkLib.PurityBlessing) > 0) addButtonDisabled(3, "PurityBlessing", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "PurityBlessing", "PurityBlessing");
				if (player.findPerk(PerkLib.SensualLover) > 0 && player.perkv4(PerkLib.SensualLover) < 1) addButton(4, "SensualLover", permanentizePerk, PerkLib.SensualLover);
				else if (player.findPerk(PerkLib.SensualLover) > 0 && player.perkv4(PerkLib.SensualLover) > 0) addButtonDisabled(4, "SensualLover", "This perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(4, "SensualLover", "SensualLover");
				addButton(9, "Previous", ascensionPermeryMenu, page - 1);
			}
			addButton(14, "Back", ascensionMenu);
		}

		private function permanentizePerk(perk:PerkType):void {
			//Not enough points or perk already permed? Cancel.
			if (player.ascensionPerkPoints < 5) return;
			if (player.perkv4(perk) > 0) return;
			//Deduct points
			player.ascensionPerkPoints -= 5;
			//Permanentize a perk
			player.addPerkValue(perk, 4, 1);
			ascensionPermeryMenu();
		}
		
		private function renamePrompt():void {
			clearOutput();
			outputText("You may choose to change your name.");
			mainView.nameBox.visible = true;
			mainView.nameBox.width = 165;
			mainView.nameBox.text = player.short;
			mainView.nameBox.maxChars = 16;
			mainView.nameBox.restrict = null;
			menu();
			addButton(0, "OK", chooseName);
			addButton(4, "Back", ascensionMenu);
			//Workaround
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		}
		
		private function reincarnatePrompt():void {
			clearOutput();
			outputText("Would you like to reincarnate and start a new life as a Champion?");
			doYesNo(reincarnate, ascensionMenu);
		}
		private function reincarnate():void {
			flags[kFLAGS.NEW_GAME_PLUS_LEVEL]++;
			customPlayerProfile = null;
			newGameGo();
			clearOutput();
			mainView.nameBox.visible = false;
			mainView.hideComboBox();
			outputText("Everything fades to white and finally... black. You can feel yourself being whisked back to reality as you slowly awaken in your room. You survey your surroundings and recognize almost immediately; you are in your room inside the inn in Ingnam! You get up and look around. ");
			if (player.hasKeyItem("Sky Poison Pearl") >= 0) {
				outputText("\n\nYou soon noticing a circular green imprint at the palm of your left hand. When you trying to figure out it meaning something clicks in your mind. It's a strange artifact that fused with your body that allow storing many things inside. Artifact that fused with your body? You are unable to recall when did yo... Wait a second there are few almost fully faded away memory fragments of you been somewhere underwater fearlessly facing some huge monster with tentacles as it legs... Doing you utermost efforts no other memories even slightest fragments apprear in your mind. Resigned you try to concentrate on remembering how to use this thing but those memories are still too blurred. Maybe with time you remember all about this... 'thing'.")
			}
			player.breastRows = [];
			player.cocks = [];
			player.vaginas = new <VaginaClass>[];
			player.horns = 0;
			player.hornType = HORNS_NONE;
			player.antennae = ANTENNAE_NONE;
			player.earType = EARS_HUMAN;
			player.eyeType = EYES_HUMAN;
			player.tongueType = TONGUE_HUMAN;
			player.gillType = GILLS_NONE;
			player.armType = ARM_TYPE_HUMAN;
			player.wingType = WING_TYPE_NONE;
			player.wingDesc = "non-existant";
			player.rearBody = REAR_BODY_NONE;
			player.lowerBody = LOWER_BODY_TYPE_HUMAN;
			player.legCount = 2;
			player.tailType = TAIL_TYPE_NONE;
			player.tailRecharge = 0;
			player.level = 1;
			player.teaseLevel = 0;
			player.teaseXP = 0;
			player.statPoints = 0;
			player.perkPoints = 0;
			player.XP = 0;
			player.setWeapon(WeaponLib.FISTS);
			player.setWeaponRange(WeaponRangeLib.NOTHING);
			player.setShield(ShieldLib.NOTHING);
			player.setJewelry(JewelryLib.NOTHING);
			inventory.clearStorage();
			inventory.clearGearStorage();
			inventory.initializeGearStorage();
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
			doNext(removeLevelPerks);
		}
		
		private function removeLevelPerks():void {
			clearOutput();
			player.perkPoints = player.level - 1;
			var ascendPerkTemp:Array = [];
			for (var i:int = 0; i < player.perks.length; i++) {
				if (isAscensionPerk(player.perks[i], true)) ascendPerkTemp.push(player.perks[i]);
			}
			player.removePerks();
			if (ascendPerkTemp.length > 0) {
				for (i = 0; i < ascendPerkTemp.length; i++) {
					player.createPerk(ascendPerkTemp[i].ptype, ascendPerkTemp[i].value1, ascendPerkTemp[i].value2, ascendPerkTemp[i].value3, ascendPerkTemp[i].value4);
				}
			}
			outputText("After looking around the room for a while, you look into the mirror and begin to recollect who you are...");
			doNext(routeToGenderChoiceReincarnation);
		}
		
		private function routeToGenderChoiceReincarnation():void {
			clearOutput();
			genericGenderChoice();
		}
		
		private function isAscensionPerk(perk:PerkClass, respec:Boolean = false):Boolean {
			return perk.ptype.keepOnAscension(respec) || perk.value4 > 0;
		}

		private function isSpecialKeyItem(keyName:* = null):Boolean {//tylko sky poinson pearl zostawić tutaj
			return (keyName == "Sky Poison Pearl" || keyName == "Nieve's Tear"); 
		}

		private function isSpell(statusEffect:* = null):Boolean {	
			return (statusEffect == StatusEffects.KnowsWereBeast);	//na razie jest tu tylko werebeast
		}	//ale potem zamienić to naspecialne soulskills z każdego z klanów
	}
}
