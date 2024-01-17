package classes
{
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Butt;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Hips;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GeneticMemories.*;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Desert.SandWitchScene;
import classes.Scenes.Metamorph;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.NPCs.XXCNPC;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;
import classes.lists.BreastCup;
import classes.lists.Gender;

import coc.view.MainView;
import classes.Scenes.Combat.CombatAbility;


//import flash.events.MouseEvent;

	public class CharCreation extends BaseContent {

		public const MAX_TOLERANCE_LEVEL:int = 10;
		public const MAX_MORALSHIFTER_LEVEL:int = 10;
		public const MAX_DESIRES_LEVEL:int = 35;
		public const MAX_ENDURANCE_LEVEL:int = 35;
		public const MAX_HARDINESS_LEVEL:int = 35;
		public const MAX_SOULPURITY_LEVEL:int = 35;
		public const MAX_INNERPOWER_LEVEL:int = 35;
		public const MAX_FURY_LEVEL:int = 35;
		public const MAX_KILLINGINTENT_LEVEL:int = 30;
		public const MAX_BLOODLUST_LEVEL:int = 30;
		public const MAX_MYSTICALITY_LEVEL:int = 30;
		public const MAX_SPIRITUALENLIGHTENMENT_LEVEL:int = 30;
		public const MAX_WISDOM_LEVEL:int = 50;
		public const MAX_TRANSHUMANISM_LEVEL:int = 35;
		public const MAX_TRANSHUMANISM_STR_LEVEL:int = 35;
		public const MAX_TRANSHUMANISM_TOU_LEVEL:int = 35;
		public const MAX_TRANSHUMANISM_SPE_LEVEL:int = 35;
		public const MAX_TRANSHUMANISM_INT_LEVEL:int = 35;
		public const MAX_TRANSHUMANISM_WIS_LEVEL:int = 35;
		public const MAX_TRANSHUMANISM_LIB_LEVEL:int = 35;
		public const MAX_TRANSHUMANISM_SEN_LEVEL:int = 35;
		public const MAX_FORTUNE_LEVEL:int = 50;
		public const MAX_VIRILITY_LEVEL:int = 10;
		public const MAX_FERTILITY_LEVEL:int = 10;
		public const MAX_MILK_FAUCET_LEVEL:int = 25;
		public const MAX_CUM_HOSE_LEVEL:int = 25;

		private var specialCharacters:CharSpecial = new CharSpecial();
		private var customPlayerProfile:Function;

//		private var boxNames:ComboBox;

		public function CharCreation() {}

		public function newGameFromScratch():void {
			CoC.instance.isLoadingSave = false;
			flags[kFLAGS.NEW_GAME_PLUS_LEVEL] = 0;
			newGameGo();
		}

		/*
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
		*/

		public function newGameGo():void {
			if (EventParser.badEnded) {
				flags[kFLAGS.NEW_GAME_PLUS_LEVEL] = 0;
				EventParser.badEnded = false;
			}
			XXCNPC.unloadSavedNPCs();
			CoC.instance.saves.resetSaveableStates();
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
			mainView.setButtonText(0, "Newgame"); // b1Text.text = "Newgame";
			//flags[kFLAGS.CUSTOM_PC_ENABLED] = 0;

			var showSpecialNames:Boolean = true; // achievements[kACHIEVEMENTS.STORY_FINALBOSS] > 0;

			clearOutput();
			outputText("You grew up in the small village of Ingnam, a remote village with rich traditions, buried deep in the wilds.  Every year for as long as you can remember, your village has chosen a champion to send to the cursed Demon Realm.  Legend has it that in years Ingnam has failed to produce a champion, chaos has reigned over the countryside.  Children disappear, crops wilt, and disease spreads like wildfire.  This year, <b>you</b> have been selected to be the champion.\n\n");
			outputText("What is your name?");
			menu();
			addButton(0, "OK", chooseName);
			mainView.nameBox.x = mainView.mainText.x + 5;
			mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
			mainView.nameBox.text = "";
			mainView.nameBox.maxChars = 16;
			mainView.nameBox.restrict = null;

			var preList:Array = [];
			for (var t:int = 0; t < specialCharacters.customs.length; t++) preList.push( { label: specialCharacters.customs[t][0], data:specialCharacters.customs[t] } );

			if (showSpecialNames) {
				CoC.instance.showComboBox(preList,"Pre-defined characters",selectName);
				mainView.placeComboBox(mainView.nameBox.x + mainView.nameBox.width + 10,mainView.nameBox.y);
			}

			//RESET DUNGEON
			inDungeon = false;
			inRoomedDungeon = false;
			inRoomedDungeonResume = null;
			//Reset all standard stats
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player = new Player();
                player.slotName = "VOID";
                player.autoSave = false;
            }

			model.player = player;
			player.strStat.core.value = 0;
			player.touStat.core.value = 0;
			player.speStat.core.value = 0;
			player.intStat.core.value = 0;
			player.wisStat.core.value = 0;
			player.libStat.core.value = 0;
			player.strStat.train.value = 15;
			player.touStat.train.value = 15;
			player.speStat.train.value = 15;
			player.intStat.train.value = 15;
			player.wisStat.train.value = 15;
			player.libStat.train.value = 15;
			player.sensStat.redefine({base:15});
			player.cor = 15;
			player.soulforce = 50;
			player.wrath = 0;
			player.mana = 100;
			player.hunger = 80;
			player.lust = 15;
			player.gems = 0;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.XP = flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_XP];
				player.level = 0;
				player.gems = flags[kFLAGS.NEW_GAME_PLUS_BONUS_STORED_ITEMS];
			}
			player.hairLength = 5;
			player.skin.restore();
			player.faceType = Face.HUMAN;
			player.tailType = Tail.NONE;
			player.tongue.type = Tongue.HUMAN;
			player.femininity = 50;
			player.beardLength = 0;
			player.beardStyle = 0;
			player.tone = 50;
			player.thickness = 50;
			player.skinDesc = "skin";
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				player.balls = 0;
				player.ballSize = 0;
				if (player.hasVagina()) player.clitLength = 0;
			}
			player.hoursSinceCum = 0;
			player.cumMultiplier = 1;
			player.ass.analLooseness = 0;
			player.ass.analWetness = 0;
			player.ass.fullness = 0;
			player.fertility = 5;
			player.fatigue = 0;
			player.horns.count = 0;
			player.tallness = 60;
			player.tailCount = 0;
			player.tailVenom = 0;
			player.tailRecharge = 0;
			player.gills.type = Gills.NONE;
			player.rearBody.type = RearBody.NONE;
			player.wings.type = Wings.NONE;
			//Default
			player.skinColor = "light";
			player.hairColor = "brown";
			player.hairStyle = 0;
			player.hairType = Hair.NORMAL;
			player.beardLength = 0;
			player.beardStyle = 0;
			//Inventory clear
			player.itemSlot1.unlocked = true;
			player.itemSlot1.emptySlot();
			player.itemSlot2.unlocked = true;
			player.itemSlot2.emptySlot();
			player.itemSlot3.unlocked = true;
			player.itemSlot3.emptySlot();
			player.itemSlot4.unlocked = true;
			player.itemSlot4.emptySlot();
			player.itemSlot5.unlocked = true;
			player.itemSlot5.emptySlot();
			player.itemSlot6.unlocked = true;
			player.itemSlot6.emptySlot();
			player.itemSlot7.unlocked = false;
			player.itemSlot7.emptySlot();
			player.itemSlot8.unlocked = false;
			player.itemSlot8.emptySlot();
			player.itemSlot9.unlocked = false;
			player.itemSlot9.emptySlot();
			player.itemSlot10.unlocked = false;
			player.itemSlot10.emptySlot();
			player.itemSlot11.unlocked = false;
			player.itemSlot11.emptySlot();
			player.itemSlot12.unlocked = false;
			player.itemSlot12.emptySlot();
			player.itemSlot13.unlocked = false;
			player.itemSlot13.emptySlot();
			player.itemSlot14.unlocked = false;
			player.itemSlot14.emptySlot();
			player.itemSlot15.unlocked = false;
			player.itemSlot15.emptySlot();
			player.itemSlot16.unlocked = false;
			player.itemSlot16.emptySlot();
			player.itemSlot17.unlocked = false;
			player.itemSlot17.emptySlot();
			player.itemSlot18.unlocked = false;
			player.itemSlot18.emptySlot();
			player.itemSlot19.unlocked = false;
			player.itemSlot19.emptySlot();
			player.itemSlot20.unlocked = false;
			player.itemSlot20.emptySlot();
			player.itemSlot21.unlocked = false;
			player.itemSlot21.emptySlot();
			player.itemSlot22.unlocked = false;
			player.itemSlot22.emptySlot();
			player.itemSlot23.unlocked = false;
			player.itemSlot23.emptySlot();
			player.itemSlot24.unlocked = false;
			player.itemSlot24.emptySlot();
			player.itemSlot25.unlocked = false;
			player.itemSlot25.emptySlot();
			player.itemSlot26.unlocked = false;
			player.itemSlot26.emptySlot();
			player.itemSlot27.unlocked = false;
			player.itemSlot27.emptySlot();
			player.itemSlot28.unlocked = false;
			player.itemSlot28.emptySlot();
			player.itemSlot29.unlocked = false;
			player.itemSlot29.emptySlot();
			player.itemSlot30.unlocked = false;
			player.itemSlot30.emptySlot();
			player.itemSlot31.unlocked = false;
			player.itemSlot31.emptySlot();
			player.itemSlot32.unlocked = false;
			player.itemSlot32.emptySlot();
			player.itemSlot33.unlocked = false;
			player.itemSlot33.emptySlot();
			player.itemSlot34.unlocked = false;
			player.itemSlot34.emptySlot();
			player.itemSlot35.unlocked = false;
			player.itemSlot35.emptySlot();
			player.itemSlot36.unlocked = false;
			player.itemSlot36.emptySlot();
			player.itemSlot37.unlocked = false;
			player.itemSlot37.emptySlot();
			player.itemSlot38.unlocked = false;
			player.itemSlot38.emptySlot();
			player.itemSlot39.unlocked = false;
			player.itemSlot39.emptySlot();
			player.itemSlot40.unlocked = false;
			player.itemSlot40.emptySlot();
			player.itemSlot41.unlocked = false;
			player.itemSlot41.emptySlot();
			player.itemSlot42.unlocked = false;
			player.itemSlot42.emptySlot();
			player.itemSlot43.unlocked = false;
			player.itemSlot43.emptySlot();
			player.itemSlot44.unlocked = false;
			player.itemSlot44.emptySlot();
			player.itemSlot45.unlocked = false;
			player.itemSlot45.emptySlot();
			player.itemSlot46.unlocked = false;
			player.itemSlot46.emptySlot();
			player.itemSlot47.unlocked = false;
			player.itemSlot47.emptySlot();
			player.itemSlot48.unlocked = false;
			player.itemSlot48.emptySlot();
			player.itemSlot49.unlocked = false;
			player.itemSlot49.emptySlot();
			player.itemSlot50.unlocked = false;
			player.itemSlot50.emptySlot();
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
            for each(var cock:Cock in player.cocks){
				cock.pierced = 0;
				cock.pShortDesc = "";
				cock.pLongDesc = "";
			}
			for each(var vagina:VaginaClass in player.vaginas){
				vagina.labiaPierced = 0;
                vagina.labiaPShort = "";
				vagina.labiaPLong = "";
				vagina.clitPierced = 0;
                vagina.clitPShort = "";
				vagina.clitPLong = "";
			}
			//PLOTZ
			JojoScene.monk                               = JojoScene.JOJO_NOT_MET;
			SandWitchScene.rapedBefore = false;
			//Replaced by flag	CoC.instance.beeProgress = 0;
			SceneLib.isabellaScene.isabellaOffspringData = []; //CLEAR!
			//Lets get this bitch started
			CoC.instance.inCombat = false;
			inDungeon = false;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0) {
				//Clothes clear
				player.setArmor(armors.C_CLOTH,false,true);
				player.unequipWeapon(false,true)
				player.unequipWeaponRange(false,true);
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
				if (hadOldCock) player.createCock();
				if (hadOldVagina) player.createVagina(true);
				if (player.balls > 2) player.balls = 2;
				if (player.ballSize > 2) player.ballSize = 2;
				while (player.breastRows.length > 1)
				{
					player.removeBreastRow(1, 1);
				}
				if (player.nippleLength > 0.25) player.nippleLength = 0.25;
				while (player.biggestTitSize() > 14) player.shrinkTits(true);
			}
			//Clear Statuses
			var statusTemp:Array = [];
			for (var i:int = 0; i < player.statusEffects.length; i++) {
				if (isSpecialStatus(player.statusEffects[i])) statusTemp.push(player.statusEffects[i]);
			}
			player.cleanAllBuffs();
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
			var newFlags:DefaultDict = new DefaultDict();
            //keep settings flags
			if (player.hasKeyItem("Ascension") >= 0) {
				for each(var flag:int in [
					kFLAGS.BACKGROUND_STYLE,
					kFLAGS.CUSTOM_FONT_SIZE,
                    kFLAGS.NEW_GAME_PLUS_LEVEL,
                    kFLAGS.HUNGER_ENABLED,
                    kFLAGS.HARDCORE_MODE,
                    kFLAGS.HARDCORE_SLOT,
                    kFLAGS.GAME_DIFFICULTY,
                    kFLAGS.EASY_MODE_ENABLE_FLAG,
                    kFLAGS.WISDOM_SCALING,
                    kFLAGS.INTELLIGENCE_SCALING,
                    kFLAGS.STRENGTH_SCALING,
                    kFLAGS.SPEED_SCALING,
                    kFLAGS.SECONDARY_STATS_SCALING,
                    kFLAGS.BOSS_CHAMPION_ELITE_SCALING,
                    kFLAGS.WATERSPORTS_ENABLED,
				    kFLAGS.SILLY_MODE_ENABLE_FLAG,
                    kFLAGS.SCENEHUNTER_PRINT_CHECKS,
                    kFLAGS.SCENEHUNTER_OTHER,
                    kFLAGS.SCENEHUNTER_DICK_SELECT,
					kFLAGS.SCENEHUNTER_LOSS_SELECT,
					kFLAGS.SCENEHUNTER_MOCK_FIGHTS,
                    kFLAGS.SCENEHUNTER_UNI_HERMS,
                    kFLAGS.LOW_STANDARDS_FOR_ALL,
                    kFLAGS.HYPER_HAPPY,
                    kFLAGS.NEW_GAME_PLUS_BONUS_UNLOCKED_HERM,
                    kFLAGS.LVL_UP_FAST,
                    kFLAGS.MUTATIONS_SPOILERS,
                    kFLAGS.INVT_MGMT_TYPE,
                    kFLAGS.NEWPERKSDISPLAY,
                    kFLAGS.CHARVIEW_STYLE,
                    kFLAGS.CHARVIEW_ARMOR_HIDDEN,
					kFLAGS.EXPLORE_MENU_STYLE,
                    kFLAGS.SPIRIT_STONES]) {
					    newFlags[flag] = flags[flag];
				}
			}
			//Clear plot storage array!
			CoC.instance.flags = new DefaultDict();
			CoC.instance.saves.loadPermObject();
			//Carry over data if new game plus.
			if (player.hasKeyItem("Ascension") >= 0) CoC.instance.flags = newFlags;
			var aSPPMX:Number = 1;
			if (player.hasPerk(PerkLib.AscensionSkyPoisonPearlMasteryStageX)) aSPPMX += player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX);
			if (flags[kFLAGS.SPIRIT_STONES] > (100 * (1 + player.newGamePlusMod()) * aSPPMX)) flags[kFLAGS.SPIRIT_STONES] = (100 * (1 + player.newGamePlusMod()) * aSPPMX);
			//Time reset
			model.time.days = 0;
			model.time.hours = 0;
			model.time.minutes = 0;
		}

		private function chooseName():void {
			if (CoC.instance.testingBlockExiting) {
				// We're running under the testing script.
				// Stuff a name in the box and go go go
				mainView.nameBox.text = "Derpy";
				return;
			}
			if (mainView.nameBox.text == "") {
				//If part of newgame+, don't fully wipe.
				if (player.XP > 0 && SceneLib.exploration.counters.explore == 0) {
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
				outputText("\n\nOr a hermaphrodite? (Hermaphrodite gender unlocked!)");
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
				outputText("\n\nThis character has a pre-defined history.");
			else
				outputText("\n\nThis character has no pre-defined history.");

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
				player.strStat.train.value += 3;
				player.touStat.train.value += 2;
			}
			//Body attributes
			player.fertility = 5;
			player.hairLength = 1;
			player.tallness = 71;
			player.tone = 60;

			//Genetalia
			player.balls = 2;
			player.ballSize = 1;
			player.createCock();
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
				player.speStat.train.value += 3;
				player.intStat.train.value += 2;
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
				player.strStat.train.value += 1;
				player.touStat.train.value += 1;
				player.speStat.train.value +=1;
				player.intStat.train.value += 1;
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
			player.cocks[0].knotMultiplier = 1;

			//Breasts
			player.createBreastRow();

			//Choices
			clearOutput();
			outputText("\n\nYou are a hermaphrodite.  Your upbringing has provided you average stats.\n\nWhat type of build do you have?");
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
			player.strStat.train.value -= 1;
			player.speStat.train.value += 1;

			player.femininity = 34;
			player.thickness = 30;
			player.tone += 5;

			player.breastRows[0].breastRating = BreastCup.FLAT;
			player.butt.type = Butt.RATING_TIGHT;
			player.hips.type = Hips.RATING_SLENDER;
			chooseComplexion();
		}

		private function buildSlenderFemale():void {
			player.strStat.train.value -= 1;
			player.speStat.train.value += 1;

			player.femininity = 66;
			player.thickness = 30;
			player.tone += 5;

			player.breastRows[0].breastRating = BreastCup.B;
			player.butt.type = Butt.RATING_TIGHT;
			player.hips.type = Hips.RATING_AMPLE;
			chooseComplexion();
		}

		private function buildAverageMale():void {
			player.femininity = 30;
			player.thickness = 50;

			player.breastRows[0].breastRating = BreastCup.FLAT;
			player.butt.type = Butt.RATING_AVERAGE;
			player.hips.type = Hips.RATING_AVERAGE;
			chooseComplexion();
		}

		private function buildAverageFemale():void {
			player.femininity = 70;
			player.thickness = 50;

			player.breastRows[0].breastRating = BreastCup.C;
			player.butt.type = Butt.RATING_NOTICEABLE;
			player.hips.type = Hips.RATING_AMPLE;
			chooseComplexion();
		}

		private function buildThickMale():void {
			player.speStat.train.value -= 4;
			player.strStat.train.value += 2;
			player.touStat.train.value += 2;

			player.femininity = 29;
			player.thickness = 70;
			player.tone -= 5;

			player.breastRows[0].breastRating = BreastCup.FLAT;
			player.butt.type = Butt.RATING_NOTICEABLE;
			player.hips.type = Hips.RATING_AVERAGE;
			chooseComplexion();
		}

		private function buildCurvyFemale():void {
			player.speStat.train.value -= 2;
			player.strStat.train.value += 1;
			player.touStat.train.value += 1;

			player.femininity = 71;
			player.thickness = 70;

			player.breastRows[0].breastRating = BreastCup.D;
			player.butt.type = Butt.RATING_LARGE;
			player.hips.type = Hips.RATING_CURVY;
			chooseComplexion();
		}

		private function buildGirlyMale():void {
			player.strStat.train.value -= 2;
			player.speStat.train.value += 2;

			player.femininity = 50;
			player.thickness = 50;
			player.tone = 26;

			player.breastRows[0].breastRating = BreastCup.A;
			player.butt.type = Butt.RATING_NOTICEABLE;
			player.hips.type = Hips.RATING_SLENDER;
			chooseComplexion();
		}

		private function buildTomboyishFemale():void {
			player.strStat.train.value += 1;
			player.speStat.train.value -= 1;

			player.femininity = 56;
			player.thickness = 50;
			player.tone = 50;

			player.breastRows[0].breastRating = BreastCup.A;
			player.butt.type = Butt.RATING_TIGHT;
			player.hips.type = Hips.RATING_SLENDER;
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
			player.skinColor = choice;
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
			outputText("What is your eye color?");
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
			player.eyes.colour = choice;
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
			outputText("Skin tone: " + player.skinColor + "\n");
			outputText("Hair color: [haircolor]\n");
			outputText("Eye color: [eyecolor]\n");
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
			addButton(3, "Eye Color", menuEyesColor);
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
			player.skinColor = complexion;
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
			outputText("What is your eye color?");
			menu();
			addButton(0, "Black", pickEyesColor, "black");
			addButton(1, "Green", pickEyesColor, "green");
			addButton(2, "Blue", pickEyesColor, "blue");
			addButton(3, "Red", pickEyesColor, "red");
			addButton(4, "White", pickEyesColor, "white");
			addButton(5, "Brown", pickEyesColor, "brown");
			addButton(6, "Yellow", pickEyesColor, "yellow");
			addButton(7, "Grey", pickEyesColor, "grey");
			addButton(8, "Purple", pickEyesColor, "purple");
			addButton(10, "Golden", pickEyesColor, "golden");
			addButton(11, "Silver", pickEyesColor, "silver");
			addButton(14, "Back", genericStyleCustomizeMenu);
		}

		private function pickEyesColor(color:String = ""):void {
			player.eyes.colour = color;
			genericStyleCustomizeMenu();
		}

		//-----------------
		//-- HEIGHT
		//-----------------
		private function setHeight():void {
			clearOutput();
			if (CoC.instance.testingBlockExiting)
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
			addButton(4, "Wise", confirmEndowmentWise);
			addButton(5, "Libido", confirmEndowmentLibido);
			addButton(6, "Sensitive", confirmEndowmentTouch);
			addButton(7, "Perversion", confirmEndowmentPerversion);
			if (player.hasCock()) {
				addButton(8, "Big Cock", confirmEndowmentBigCock);
				addButton(9, "Lots of Jizz", confirmEndowmentMessyOrgasms);
			}
			else {
				addButton(8, "Big Breasts", confirmEndowmentBigBreasts);
				addButton(9, "Big Clit", confirmEndowmentBigClit);
				addButton(10, "Fertile", confirmEndowmentFertile);
				addButton(11, "Wet Vagina", confirmEndowmentWetVagina);
			}
			if (player.gender == Gender.GENDER_HERM)
			{
				addButton(8, "Big Cock", confirmEndowmentBigCock);
				addButton(9, "Lots of Jizz", confirmEndowmentMessyOrgasms);
				addButton(10, "Big Breasts", confirmEndowmentBigBreasts);
				addButton(11, "Big Clit", confirmEndowmentBigClit);
				addButton(12, "Fertile", confirmEndowmentFertile);
				addButton(13, "Wet Vagina", confirmEndowmentWetVagina);
			}
		}

		private function confirmEndowmentStrength():void {
			clearOutput();
			outputText("Are you stronger than normal? (+50% to strength multi)\n\nStrength increases your combat damage, and your ability to hold on to an enemy or pull yourself away.");
			menu();
			addButton(0, "Yes", setEndowmentStrength);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentThoughness():void {
			clearOutput();
			outputText("Are you unusually tough? (+50% to toughness multi)\n\nToughness gives you more HP and increases the chances an attack against you will fail to wound you.");
			menu();
			addButton(0, "Yes", setEndowmentToughness);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentSpeed():void {
			clearOutput();
			outputText("Are you very quick?  (+50% to speed multi)\n\nSpeed makes it easier to escape combat and grapples.  It also boosts your chances of evading an enemy attack and successfully catching up to enemies who try to run.");
			menu();
			addButton(0, "Yes", setEndowmentSpeed);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentSmarts():void {
			clearOutput();
			outputText("Are you a quick learner?  (+50% to intellect multi)\n\nIntellect can help you avoid dangerous monsters or work with machinery.  It will also boost the power of any spells you may learn in your travels.");
			menu();
			addButton(0, "Yes", setEndowmentSmarts);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentWise():void {
			clearOutput();
			outputText("Are you a wise person?  (+50% to wisdom multi)\n\nWisdom can help you understand mysterious objects or work with soulforce.  It will also boost the power of any soulskills you may learn in your travels.");
			menu();
			addButton(0, "Yes", setEndowmentWise);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentLibido():void {
			clearOutput();
			outputText("Do you have an unusually high sex-drive?  (+50% to libido multi)\n\nLibido affects how quickly your lust builds over time.  You may find a high libido to be more trouble than it's worth...");
			menu();
			addButton(0, "Yes", setEndowmentLibido);
			addButton(1, "No", chooseEndowment, true);
		}

		private function confirmEndowmentTouch():void {
			clearOutput();
			outputText("Is your skin unusually sensitive?  (+50 current sensitivity)\n\nSensitivity affects how easily touches and certain magics will raise your lust.  Very low sensitivity will make it difficult to orgasm.");
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
			outputText("Are your orgasms particularly messy?  (+100% Cum Multiplier)\n\nA higher cum multiplier will cause your orgasms to be messier.");
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
			outputText("Is your family particularly fertile?  (+30% Fertility)\n\nA high fertility will cause you to become pregnant much more easily.  Pregnancy may result in: Strange children, larger bust, larger hips, a bigger ass, and other weirdness.");
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
			player.tone += 7;
			player.thickness += 3;
			//Add bonus +100% strength gain
			if (!player.hasPerk(PerkLib.Strong)) player.createPerk(PerkLib.Strong, 1, 0, 0, 0);
			chooseBloodlineorNot();
		}

		private function setEndowmentToughness():void {
			player.tone += 5;
			player.thickness += 5;
			if (!player.hasPerk(PerkLib.Tough)) player.createPerk(PerkLib.Tough, 1, 0, 0, 0);
			player.HP = EngineCore.maxHP();
			chooseBloodlineorNot();
		}

		private function setEndowmentSpeed():void {
			player.tone += 10;
			if (!player.hasPerk(PerkLib.Fast)) player.createPerk(PerkLib.Fast, 1, 0, 0, 0);
			chooseBloodlineorNot();
		}

		private function setEndowmentSmarts():void {
			player.thickness -= 5;
			if (!player.hasPerk(PerkLib.Smart)) player.createPerk(PerkLib.Smart, 1, 0, 0, 0);
			chooseBloodlineorNot();
		}

		private function setEndowmentWise():void {
			player.thickness -= 5;
			if (!player.hasPerk(PerkLib.Wise)) player.createPerk(PerkLib.Wise, 1, 0, 0, 0);
			chooseBloodlineorNot();
		}

		private function setEndowmentLibido():void {
			if (!player.hasPerk(PerkLib.Lusty)) player.createPerk(PerkLib.Lusty, 1, 0, 0, 0);
			chooseBloodlineorNot();
		}

		private function setEndowmentTouch():void {
			if (!player.hasPerk(PerkLib.Sensitive)) player.createPerk(PerkLib.Sensitive, 1, 0, 0, 0);
			chooseBloodlineorNot();
		}

		private function setEndowmentPerversion():void {
			player.cor += 5;
			if (!player.hasPerk(PerkLib.Pervert)) player.createPerk(PerkLib.Pervert, 1, 0, 0, 0);
			chooseBloodlineorNot();
		}

		private function setEndowmentBigCock():void {
			player.femininity -= 10;
			player.cocks[0].cockLength = 8;
			player.cocks[0].cockThickness = 1.5;
			trace("Creation - cock modded to 8inches");
			if (!player.hasPerk(PerkLib.BigCock)) player.createPerk(PerkLib.BigCock, 1.25, 0, 0, 0);
			chooseBloodlineorNot();
		}

		private function setEndowmentMessyOrgasms():void {
			player.femininity -= 5;
			player.cumMultiplier = 2;
			if (!player.hasPerk(PerkLib.MessyOrgasms)) player.createPerk(PerkLib.MessyOrgasms, 1.5, 0, 0, 0);
			chooseBloodlineorNot();
		}

		private function setEndowmentBigBreasts():void {
			player.femininity += 10;
			player.breastRows[0].breastRating += 2;
			if (!player.hasPerk(PerkLib.BigTits)) player.createPerk(PerkLib.BigTits, 1.5, 0, 0, 0);
			chooseBloodlineorNot();
		}

		private function setEndowmentBigClit():void {
			player.femininity -= 10;
			player.clitLength = 1;
			if (!player.hasPerk(PerkLib.BigClit)) player.createPerk(PerkLib.BigClit, 1.25, 0, 0, 0);
			chooseBloodlineorNot();
		}

		private function setEndowmentFertile():void {
			player.femininity += 10;
			player.fertility += 50;
			player.hips.type += 3;
			if (!player.hasPerk(PerkLib.Fertile)) player.createPerk(PerkLib.Fertile, 1.5, 0, 0, 0);
			chooseBloodlineorNot();
		}

		private function setEndowmentWetVagina():void {
			player.femininity += 15;
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_WET;
			if (!player.hasPerk(PerkLib.WetPussy)) player.createPerk(PerkLib.WetPussy, 2, 0, 0, 0);
			chooseBloodlineorNot();
		}

		//-----------------
		//-- BLOODLINE PERKS
		//-----------------
		public function chooseBloodlineorNot():void {
			if (player.hasPerk(PerkLib.AscensionCruelChimerasThesis) && flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3) chooseBloodline();
			else chooseHistory();
		}
		public function chooseBloodline():void {
			clearOutput();
			outputText("There is a possibility that you were descended from non-human blood.  Was one of your ancestors non-human, and if so, what were they?");
			menu();
			if (!player.hasPerk(PerkLib.BloodlineDragon)) addButton(0, "Dragon", confirmBloodline, PerkLib.DragonsDescendant).hint("(+2 to dragon score)");
			else addButtonDisabled(0, "Dragon", "You already have this bloodline!");
			if (!player.hasPerk(PerkLib.BloodlineElf)) addButton(1, "Elf", confirmBloodline, PerkLib.ElfsDescendant).hint("(+2 to elf score)");
			else addButtonDisabled(1, "Elf", "You already have this bloodline!");
			if (!player.hasPerk(PerkLib.BloodlineGoblin)) addButton(2, "Goblin", confirmBloodline, PerkLib.GoblinsDescendant).hint("(+2 to goblin score)");
			else addButtonDisabled(2, "Goblin", "You already have this bloodline!");
			if (!player.hasPerk(PerkLib.BloodlineKitsune)) addButton(3, "Kitsune", confirmBloodline, PerkLib.KitsunesDescendant).hint("(+2 to kitsune score)");
			else addButtonDisabled(3, "Kitsune", "You already have this bloodline!");
			if (!player.hasPerk(PerkLib.BloodlineRaiju)) addButton(4, "Raiju", confirmBloodline, PerkLib.RaijusDescendant).hint("(+2 to raiju score)");
			else addButtonDisabled(4, "Raiju", "You already have this bloodline!");
			if (!player.hasPerk(PerkLib.BloodlineMinotaur)) addButton(5, "Minotaur", confirmBloodline, PerkLib.MinotaursDescendant).hint("(+2 to minotaur score)");
			else addButtonDisabled(5, "Minotaur", "You already have this bloodline!");
			if (!player.hasPerk(PerkLib.BloodlineOni)) addButton(6, "Oni", confirmBloodline, PerkLib.OnisDescendant).hint("(+2 to oni score)");
			else addButtonDisabled(6, "Oni", "You already have this bloodline!");
			if (!player.hasPerk(PerkLib.BloodlineOrc)) addButton(7, "Orc", confirmBloodline, PerkLib.OrcsDescendant).hint("(+2 to orc score)");
			else addButtonDisabled(7, "Orc", "You already have this bloodline!");
			if (!player.hasPerk(PerkLib.BloodlineVampire)) addButton(8, "Vampire", confirmBloodline, PerkLib.VampiresDescendant).hint("(+2 to vampire score)");
			else addButtonDisabled(8, "Vampire", "You already have this bloodline!");
			addButton(14, "None", noBloodlineAtAllCuzYouAscendedTooManyTimesAlready).hint("You either cannot add a new unstable bloodline, or you have a stable bloodline. (It mean you only will get some bonus perk points for start instead of new bloodline.)");
		}

		private function confirmBloodline(choice:PerkType):void {
			clearOutput();
			switch (choice) {
				case PerkLib.DragonsDescendant:
					outputText("Your ancestor was a dragon?");
					break;
				case PerkLib.ElfsDescendant:
					outputText("Your ancestor was an elf?");
					break;
				case PerkLib.GoblinsDescendant:
					outputText("Your ancestor was a goblin?");
					break;
				case PerkLib.KitsunesDescendant:
					outputText("Your ancestor was a kitsune?");
					break;
				case PerkLib.MinotaursDescendant:
					outputText("Your ancestor was a minotaur?");
					break;
				case PerkLib.RaijusDescendant:
					outputText("Your ancestor was a raiju?");
					break;
				case PerkLib.OnisDescendant:
					outputText("Your ancestor was an oni?");
					break;
				case PerkLib.OrcsDescendant:
					outputText("Your ancestor was an orc?");
					break;
				case PerkLib.VampiresDescendant:
					outputText("Your ancestor was a vampire?");
					break;
				default:
					outputText("Your ancestor was a dragon?");
			}
			menu();
			addButton(0, "Yes", setBloodline, choice);
			addButton(1, "No", chooseBloodline);
		}

		private function setBloodline(choice:PerkType):void {
			player.createPerk(choice, 0, 0, 0, 0);
			chooseHistory();
		}
		private function noBloodlineAtAllCuzYouAscendedTooManyTimesAlready():void {
			player.perkPoints += 12;
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
			if (!player.hasPerk(PerkLib.PastLifeAlchemist)) addButton(0, "Alchemy", confirmHistory1, PerkLib.HistoryAlchemist);
			else addButtonDisabled(0, "Alchemy", "You already have this History as one of your Past Lives!");
			if (!player.hasPerk(PerkLib.PastLifeCultivator)) addButton(1, "Cultivator", confirmHistory1, PerkLib.HistoryCultivator);
			else addButtonDisabled(1, "Cultivator", "You already have this History as one of your Past Lives!");
			if (!player.hasPerk(PerkLib.PastLifeFeral)) addButton(2, "Feral", confirmHistory1, PerkLib.HistoryFeral);
			else addButtonDisabled(2, "Feral", "You already have this History as one of your Past Lives!");
			if (!player.hasPerk(PerkLib.PastLifeFighter)) addButton(3, "Fighting", confirmHistory1, PerkLib.HistoryFighter);
			else addButtonDisabled(3, "Fighting", "You already have this History as one of your Past Lives!");
			if (!player.hasPerk(PerkLib.PastLifeFortune)) addButton(4, "Fortune", confirmHistory1, PerkLib.HistoryFortune);
			else addButtonDisabled(4, "Fortune", "You already have this History as one of your Past Lives!");
			if (!player.hasPerk(PerkLib.PastLifeHealer)) addButton(5, "Healing", confirmHistory1, PerkLib.HistoryHealer);
			else addButtonDisabled(5, "Healing", "You already have this History as one of your Past Lives!");
			if (!player.hasPerk(PerkLib.PastLifeReligious)) addButton(6, "Religion", confirmHistory1, PerkLib.HistoryReligious);
			else addButtonDisabled(6, "Religion", "You already have this History as one of your Past Lives!");
			addButton(13, "-2-", chooseHistory1);
			addButton(14, "None", noHistoryAtAllCuzYouAscendedTooManyTimesAlready).hint("Your life hasn't been very specifically focused so far, or you've had so many past lives you can't separate them all. (No history perk, just bonus perk points)");
		}
		public function chooseHistory1():void {
			menu();
			if (!player.hasPerk(PerkLib.PastLifeScholar)) addButton(0, "Schooling", confirmHistory2, PerkLib.HistoryScholar);
			else addButtonDisabled(0, "Schooling", "You already have this History as one of your Past Lives!");
			if (!player.hasPerk(PerkLib.PastLifeScout)) addButton(1, "Scout", confirmHistory2, PerkLib.HistoryScout);
			else addButtonDisabled(1, "Scout", "You already have this History as one of your Past Lives!");
			if (!player.hasPerk(PerkLib.PastLifeSlacker)) addButton(2, "Slacking", confirmHistory2, PerkLib.HistorySlacker);
			else addButtonDisabled(2, "Slacking", "You already have this History as one of your Past Lives!");
			if (!player.hasPerk(PerkLib.PastLifeSlut)) addButton(3, "Slutting", confirmHistory2, PerkLib.HistorySlut);
			else addButtonDisabled(3, "Slutting", "You already have this History as one of your Past Lives!");
			if (!player.hasPerk(PerkLib.PastLifeSmith)) addButton(4, "Smithing", confirmHistory2, PerkLib.HistorySmith);
			else addButtonDisabled(4, "Smithing", "You already have this History as one of your Past Lives!");
			if (!player.hasPerk(PerkLib.PastLifeTactician)) addButton(5, "Tactician", confirmHistory2, PerkLib.HistoryTactician);
			else addButtonDisabled(5, "Tactician", "You already have this History as one of your Past Lives!");
			if (!player.hasPerk(PerkLib.PastLifeThief)) addButton(6, "Thief", confirmHistory2, PerkLib.HistoryThief);
			else addButtonDisabled(6, "Thief", "You already have this History as one of your Past Lives!");
			if (!player.hasPerk(PerkLib.PastLifeWhore)) addButton(7, "Whoring", confirmHistory2, PerkLib.HistoryWhore);
			else addButtonDisabled(7, "Whoring", "You already have this History as one of your Past Lives!");
			addButton(13, "-1-", chooseHistory);
			addButton(14, "None", noHistoryAtAllCuzYouAscendedTooManyTimesAlready).hint("Your life hasn't been very specifically focused so far, or you've had so many past lives you can't separate them all. (No history perk, just bonus perk points)");
		}

		private function confirmHistory1(choice:PerkType):void {
			clearOutput();
			switch (choice) {
				case PerkLib.HistoryAlchemist:
					outputText("You spent some time as an alchemist's assistant, and alchemical items always seem to be more reactive in your hands.  Is this your history?");
					break;
				case PerkLib.HistoryCultivator:
					outputText("You spent much of your time cultivating your soul, reaching the point where you successfully took the first step towards spiritual enlightment, as well as attaining an uncanny purity of soulforce. You will start with Soul Cultivator perk & Cultivation Manual: Duality. Your max soulforce will be roughly 10% higher. Is this your history?");
					break;
				case PerkLib.HistoryFeral:
					outputText("You were abandoned as a child in the wild. Adopted into a pack of wolves, you quickly learned to survive. You will start with Job: Beast Warrior perk.  Is this your history?");
					break;
				case PerkLib.HistoryFighter:
					outputText("You spent much of your time fighting other children, and you had plans to find work as a guard when you grew up.  You do 10% more damage with physical melee attacks.  You will also start out with 50 gems and Job: Warrior perk.  Is this your history?");
					break;
				case PerkLib.HistoryFortune:
					outputText("You always feel lucky when it comes to fortune.  Because of that, you have always managed to save up gems until whatever's needed and made the most out it (+15% gems on victory).  You will also start out with 250 gems and Job: Rogue perk.  Is this your history?");
					break;
				case PerkLib.HistoryHealer:
					outputText("You often spent your free time with the village healer, learning how to tend to wounds.  Healing items and effects are 20% more effective.  Is this your history?");
					break;
				case PerkLib.HistoryReligious:
					outputText("You spent a lot of time at the village temple, and learned how to meditate.  The 'masturbation' option is replaced with 'meditate' when corruption is at or below 66.  Is this your history?");
					break;
				default:
					outputText("You managed to find work as a whore.  Because of your time spent trading seduction for profit, you're more effective at teasing (+15% tease damage).  You will start with Job: Seducer perk.  Is this your history?");
			}
			menu();
			addButton(0, "Yes", setHistory, choice);
			addButton(1, "No", chooseHistory);
		}
		private function confirmHistory2(choice:PerkType):void {
			clearOutput();
			switch (choice) {
				case PerkLib.HistoryScholar:
					outputText("You spent much of your time in school, and even begged the richest man in town, Mr. " + (silly() ? "Savin" : "Sellet") + ", to let you read some of his books.  You are much better at focusing, your mana cap increased by 10%, start out with 150 gems and will start with Job: Sorcerer perk.  Is this your history?");
					break;
				case PerkLib.HistoryScout:
					outputText("You spent much of your time learning how to use ranged weapons, and you had plans to find work as a hunter when you grew up.  You do 10% more damage with physical range attacks and +20% accuracy.  You will also start out with 50 gems and Job: Ranger perk.  Is this your history?");
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
				case PerkLib.HistoryTactician:
					outputText("You were being groomed to take over the elderly chief's position until you were chosen as the Champion.  You will start with Job: Leader perk.  Is this your history?");
					break;
				case PerkLib.HistoryThief:
					outputText("You spent much of your time in the lesser streets of Ignam, learning from your friends and peers how to steal and hide from guards to survive.  You sneak attack is better (+1 to sneak attack dmg multi) and will start with Job: Rogue perk.  Is this your history?");
					break;
				case PerkLib.HistoryWhore:
					outputText("You managed to find work as a whore.  Because of your time spent trading seduction for profit, you're more effective at teasing (+15% tease damage).  You will start with Job: Seducer perk.  Is this your history?");
					break;
				default:
					outputText("You managed to find work as a whore.  Because of your time spent trading seduction for profit, you're more effective at teasing (+15% tease damage).  You will start with Job: Seducer perk.  Is this your history?");
			}
			menu();
			addButton(0, "Yes", setHistory, choice);
			addButton(1, "No", chooseHistory1);
		}

		private function setHistory(choice:PerkType):void {
			player.createPerk(choice, 0, 0, 0, 0);
			if (choice == PerkLib.HistorySlut || choice == PerkLib.HistoryWhore) {
				if (player.hasVagina()) {
					player.vaginas[0].virgin = false;
					player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_LOOSE;
				}
				player.ass.analLooseness = 1;
			}
			if (choice == PerkLib.HistoryFighter) {
				player.gems += 50;
			}
			if (choice == PerkLib.HistoryWhore) {
				player.gems += 50;
			}
			if (choice == PerkLib.HistoryScout) {
				player.gems += 50;
			}
			if (choice == PerkLib.HistoryScholar) {
				player.gems += 150;
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
		private function noHistoryAtAllCuzYouAscendedTooManyTimesAlready():void {
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] < 11) player.perkPoints += (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] + 1);
			else player.perkPoints += 12;
			flags[kFLAGS.HISTORY_PERK_SELECTED] = 1;
			completeCharacterCreation();
		}

		private function completeCharacterCreation():void {
			clearOutput();
			if (customPlayerProfile != null) {
				customPlayerProfile();
				doNext(chooseTimescale);
				return;
			}
			chooseTimescale();
		}

		public function arrival():void {
			statScreenRefresh();
			model.time.hours = 11;
			clearOutput();
			outputText("You are prepared for what is to come.  Most of the last year has been spent honing your body and mind to prepare for the challenges ahead.  You are the Champion of Ingnam.  The one who will journey to the demon realm and guarantee the safety of your friends and family, even though you'll never see them again.  You wipe away a tear as you enter the courtyard and see Elder Nomur waiting for you.  You are ready.\n\n");
			outputText("The walk to the tainted cave is long and silent.  Elder Nomur does not speak.  There is nothing left to say.  The two of you journey in companionable silence.  Slowly the black rock of Mount Ilgast looms closer and closer, and the temperature of the air drops.   You shiver and glance at the Elder, noticing he doesn't betray any sign of the cold.  Despite his age of nearly 80, he maintains the vigor of a man half his age.  You're glad for his strength, as assisting him across this distance would be draining, and you must save your energy for the trials ahead.\n\n");
			outputText("The entrance of the cave gapes open, sharp stalactites hanging over the entrance, giving it the appearance of a monstrous mouth.  Elder Nomur stops and nods to you, gesturing for you to proceed alone.\n\n");
			outputText("The cave is unusually warm and damp, ");
			if (player.gender == Gender.GENDER_FEMALE)
				outputText("and your body seems to feel the same way, flushing as you feel a warmth and dampness between your thighs.");
			else outputText("and your body reacts with a sense of growing warmth focusing in your groin, your manhood hardening for no apparent reason.");
			outputText(" You were warned of this and press forward, ignoring your body's growing needs.  A glowing purple-pink portal swirls and flares with demonic light along the back wall.  Cringing, you press forward, keenly aware that your body seems to be anticipating coming in contact with the tainted magical construct.  Closing your eyes, you gather your resolve and leap forwards.  Vertigo overwhelms you and you black out...");
			showStats();
			dynStats("lus", 15, "scale", false);
			doNext(arrivalPartTwo);
		}

		private function arrivalPartTwo():void {
			clearOutput();
			spriteSelect(SpriteDb.s_zetaz_imp);
			hideUpDown();
			dynStats("lus", 40, "cor", 2);
			model.time.hours = 18;
			outputText("You wake with a splitting headache and a body full of burning desire.  A shadow darkens your view momentarily and your training kicks in.  You roll to the side across the bare ground and leap to your feet.  A surprised-looking imp stands a few feet away, holding an empty vial.  He's completely naked, an improbably sized pulsing red cock hanging between his spindly legs.  You flush with desire as a wave of lust washes over you, your mind reeling as you fight ");
			if (player.gender == Gender.GENDER_FEMALE)
				outputText("the urge to chase down his rod and impale yourself on it.\n\n");
			else
				outputText("the urge to ram your cock down his throat.  The strangeness of the thought surprises you.\n\n");
			outputText("The imp says, \"<i>I'm amazed you aren't already chasing down my cock, human.  The last Champion was an eager whore for me by the time she woke up.  This lust draft made sure of it.</i>\"");
			doNext(arrivalPartThree);
		}

		private function arrivalPartThree():void {
			clearOutput();
			hideUpDown();
			dynStats("lus", -30, "scale", false);
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
			outputText("You have chosen Normal Mode. This is a classic gameplay mode. Accumulated wrath will not affect your ability to spellcast or use magical specials. Internal mutation negative effects will be triggered after accumulating 11 points in internal mutation score.\n\n<b>Difficulty can be adjusted at any time.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 0;
			flags[kFLAGS.HUNGER_ENABLED] = 0;
			flags[kFLAGS.GAME_DIFFICULTY] = 0;
			doNext(startTheGame);
		}

		private function chooseModeSurvival():void {
			clearOutput();
			outputText("You have chosen Survival Mode. This is similar to the normal mode but with hunger enabled. Accumulated wrath will not affect your ability to spellcast or use magical specials. Internal mutation negative effects will be triggered after accumulating 11 points in internal mutation score.\n\n<b>Difficulty can be adjusted at any time.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 0;
			flags[kFLAGS.HUNGER_ENABLED] = 0.5;
			flags[kFLAGS.GAME_DIFFICULTY] = 0;
			player.hunger = 100;
			doNext(startTheGame);
		}

		private function chooseModeRealistic():void {
			clearOutput();
			outputText("You have chosen Realistic Mode. In this mode, hunger is enabled so you have to eat periodically. Accumulated wrath will not affect ability to spellcast or use magical specials. Internal mutation negative effects will be triggered after accumulating 11 points in internal mutation score. Also, your cum production is capped and having oversized parts will weigh you down.\n\n<b>Difficulty can be adjusted at any time.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 0;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 0;
			player.hunger = 100;
			doNext(startTheGame);
		}

		private function chooseModeHard():void {
			clearOutput();
			outputText("You have chosen Hard Mode. In this mode, hunger is enabled so you have to eat periodically. Accumulated wrath will not affect ability to spellcast or use magical specials. Internal mutation negative effects will be triggered after accumulating 6 points in internal mutation score.\n\n<b>Difficulty is locked to hard.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 0;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 1;
			player.hunger = 100;
			doNext(startTheGame);
		}

		private function chooseModeNightmare():void {
			clearOutput();
			outputText("You have chosen Nightmare Mode. Hunger is constantly draining, so go get that food or perish from starvation. If you want to spellcast or use magic specials, you have to pay attention to your accumulated wrath. Additionally, the negative effects of internal mutations begin immediately. You have been warned: this difficulty is not meant for the weak of body and mind.\n\n<b>Difficulty is locked to <i>NIGHTMARE</i>.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 0;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 2;
			player.hunger = 50;
			doNext(startTheGame);
		}

		private function chooseModeExtreme():void {
			clearOutput();
			outputText("You have chosen EXTREME Mode. And so... neither death from starving, accumulated wrath inhibiting spellcasting nor internal mutations will stop you? Now, let's take things to the next level. The game will constantly autosave, and Bad Ends will result in the <b><i>deletion of your file</i></b>.\n\nDebug Mode and Easy mode are disabled here as well.\n\nPlease choose a slot to save in. You cannot make multiple copies of this save.\n\n<b>Difficulty is locked to <i>EXTREME</i></b>");
			flags[kFLAGS.HARDCORE_MODE] = 1;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 3;
			player.hunger = 50;
			menu();
			for (var i:int = 0; i < 14; i++) {
				addButton(i, "Slot " + (i + 1), chooseSlotHardcore, (i + 1));
			}
			addButton(14, "Back", chooseGameModes);
		}

		private function chooseModeXianxia():void {
			clearOutput();
			outputText("You have chosen Xianxia MC Mode. Since all previous difficulty settings were seemingly deemed insufficient, this is the next option. It will be rough, tedious, strenuous... but you came here to suff- Feel like a true XIANXIA MC, correct?\n\n<b>Difficulty is locked to <i>XIANXIA</i>.</b>");
			flags[kFLAGS.HARDCORE_MODE] = 1;
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			flags[kFLAGS.GAME_DIFFICULTY] = 4;
			player.hunger = 50;
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
			outputText("<b>Hard mode:</b> In addition to Realistic mode, the game forces save and if you get a Bad End, your save file is deleted. For not sunday (CoC) players.\n");
			outputText("<b>Hardcore mode:</b> In addition to Realistic mode, the game forces save and if you get a Bad End, your save file is deleted. For the veteran CoC players only.\n");
			outputText("<b>Extreme Hardcore mode:</b> The hardest game mode ever. Like hardcore mode, but the difficulty is locked to extreme! How long can you survive?\n");
			outputText("<b>Xianxia MC mode:</b> The game mode for anyone that wants to feel like an Xianxia MC. Hunger is always waiting behind a corner and enemies are always stronger than you! How long will take to you to reach the top?\n");
			menu();
			addButton(0, "Normal", chooseModeNormal);
			addButton(1, "Survival", chooseModeSurvival);
			addButton(2, "Realistic", chooseModeRealistic);
			addButton(3, "Hard", chooseModeHard);
			addButton(4, "Nightmare", chooseModeNightmare);
			addButton(5, "EXTREME", chooseModeExtreme);
			addButton(6, "Xianxia MC", chooseModeXianxia);
		}

		private function chooseTimescale():void {
			clearOutput();
			outputText("Choose in-game timescale.\n"
				+ "\n"
				+ "The game contains numerous holiday events, some of which can be triggered multiple times with different results. There are two ways how the game can calculate the current date.\n"
				+ "\n"
				+ "<b>REAL</b>: The game uses the system date from your computer.\n"
				+ "<b>DAYS</b>: The current day is calculated using in-game days counter. The length of one in-game year can be selected."
				+ "\n"
				+ "\nThe events/holidays will have day-of-the-month requirements with <b>REAL</b> and <b>DAYS-365</b> settings (e.g. exact days of Easter or Thanksgiving).");
			menu();
			addButton(2, "REAL", setTimescale, 0);
			addButton(5, "DAYS-60", setTimescale, 60);
			addButton(6, "DAYS-120", setTimescale, 120);
			addButton(7, "DAYS-180", setTimescale, 180);
			addButton(8, "DAYS-240", setTimescale, 240);
			addButton(9, "DAYS-365", setTimescale, 365);

			function setTimescale(val:int):void {
				flags[kFLAGS.DAYS_PER_YEAR] = val;
				chooseGameModes();
			}
		}

		private function startTheGame():void {
			player.startingRace = player.race();
			if (flags[kFLAGS.HARDCORE_MODE] > 0) {
				trace("Hardcore save file " + flags[kFLAGS.HARDCORE_SLOT] + " created.");
                CoC.instance.saves.saveGame(flags[kFLAGS.HARDCORE_SLOT])
            }
			CoC.instance.saves.loadPermObject();
			flags[kFLAGS.MOD_SAVE_VERSION] = CoC.instance.modSaveVersion;
			statScreenRefresh();
			if (player.hasPerk(PerkLib.PastLifeCultivator) || player.hasPerk(PerkLib.PastLifeFighter) || player.hasPerk(PerkLib.PastLifeScout) || player.hasPerk(PerkLib.PastLifeScholar) || player.hasPerk(PerkLib.PastLifeSmith) || player.hasPerk(PerkLib.PastLifeTactician) || player.hasPerk(PerkLib.PastLifeWhore)) chooseToPlayHalf();
			else chooseToPlay();
		}

		private function chooseToPlayHalf():void {
			clearOutput();
			outputText("Do you want to gain free Job(s) from all Past Life perks your PC have or just get free perk point(s) instead?\n\n");
			menu();
			addButton(1, "Jobs", chooseToPlay);
			addButton(3, "Perks", choosePerks);
		}
		private function choosePerks():void {
			player.createKeyItem("PerksOverJobs", 0, 0, 0, 0);
			chooseToPlay();
		}

		public function chooseToPlay():void {
			if (player.femininity >= 55) player.setUnderBottom(undergarments.C_PANTY, false);
			else player.setUnderBottom(undergarments.C_LOIN, false);
			if (player.biggestTitSize() >= 2) player.setUnderTop(undergarments.C_BRA, false);
			else player.setUnderTop(undergarments.C_SHIRT, false);
			if (player.hasPerk(PerkLib.HistoryCultivator) || player.hasPerk(PerkLib.PastLifeCultivator)) {
				player.createKeyItem("Cultivation Manual: Duality", 0, 0, 0, 0);
				player.createPerk(PerkLib.JobSoulCultivator, 0, 0, 0, 0);
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.HistoryFeral) || (player.hasPerk(PerkLib.PastLifeFeral) && player.hasKeyItem("PerksOverJobs") < 0)) player.createPerk(PerkLib.JobBeastWarrior, 0, 0, 0, 0);
			if (player.hasPerk(PerkLib.HistoryFighter) || (player.hasPerk(PerkLib.PastLifeFighter) && player.hasKeyItem("PerksOverJobs") < 0)) player.createPerk(PerkLib.JobWarrior, 0, 0, 0, 0);
			if (player.hasPerk(PerkLib.HistoryScout) || (player.hasPerk(PerkLib.PastLifeScout) && player.hasKeyItem("PerksOverJobs") < 0)) player.createPerk(PerkLib.JobRanger, 0, 0, 0, 0);
			if (player.hasPerk(PerkLib.HistoryScholar) || (player.hasPerk(PerkLib.PastLifeScholar) && player.hasKeyItem("PerksOverJobs") < 0)) player.createPerk(PerkLib.JobSorcerer, 0, 0, 0, 0);
			if (player.hasPerk(PerkLib.HistorySmith) || (player.hasPerk(PerkLib.PastLifeSmith) && player.hasKeyItem("PerksOverJobs") < 0)) player.createPerk(PerkLib.JobGuardian, 0, 0, 0, 0);
			if (player.hasPerk(PerkLib.HistoryTactician) || (player.hasPerk(PerkLib.PastLifeTactician) && player.hasKeyItem("PerksOverJobs") < 0)) player.createPerk(PerkLib.JobLeader, 0, 0, 0, 0);
			if (player.hasPerk(PerkLib.HistoryThief) || (player.hasPerk(PerkLib.PastLifeThief) && player.hasKeyItem("PerksOverJobs") < 0)) player.createPerk(PerkLib.JobRogue, 0, 0, 0, 0);
			if (player.hasPerk(PerkLib.HistoryWhore) || (player.hasPerk(PerkLib.PastLifeWhore) && player.hasKeyItem("PerksOverJobs") < 0)) player.createPerk(PerkLib.JobSeducer, 0, 0, 0, 0);
			if (player.hasPerk(PerkLib.HistoryAlchemist) || player.hasPerk(PerkLib.PastLifeAlchemist)) {
				player.alchemySkillStat.level = 5;
				player.perkPoints += 1;
			}
			if (player.hasPerk(PerkLib.HistoryFortune)) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.HistoryHealer)) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.HistoryReligious)) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.HistorySlacker)) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.HistorySlut)) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.PastLifeFeral) && player.hasKeyItem("PerksOverJobs") >= 0) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.PastLifeFighter) && player.hasKeyItem("PerksOverJobs") >= 0) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.PastLifeScout) && player.hasKeyItem("PerksOverJobs") >= 0) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.PastLifeScholar) && player.hasKeyItem("PerksOverJobs") >= 0) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.PastLifeSmith) && player.hasKeyItem("PerksOverJobs") >= 0) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.PastLifeTactician) && player.hasKeyItem("PerksOverJobs") >= 0) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.PastLifeThief) && player.hasKeyItem("PerksOverJobs") >= 0) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.PastLifeWhore) && player.hasKeyItem("PerksOverJobs") >= 0) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.PastLifeFortune)) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.PastLifeHealer)) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.PastLifeReligious)) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.PastLifeSlacker)) player.perkPoints += 1;
			if (player.hasPerk(PerkLib.PastLifeSlut)) player.perkPoints += 1;
			if (player.hasKeyItem("PerksOverJobs") >= 0) player.removeKeyItem("PerksOverJobs");
			if (player.hasPerk(PerkLib.AscensionBloodlineHeritage)) {
				player.perkPoints += 1 * player.newGamePlusMod();
				player.superPerkPoints += 1 * (player.newGamePlusMod() - 3);
				player.statPoints += 5 * player.newGamePlusMod();
			}
			if (player.hasPerk(PerkLib.AscensionHerosHeritage)) {
				player.perkPoints += 3 * player.newGamePlusMod();
				player.statPoints += 15 * player.newGamePlusMod();
			}
			if (player.hasPerk(PerkLib.AscensionHerosLegacy)) {
				player.perkPoints += 1 * player.newGamePlusMod();
				player.superPerkPoints += 1 * (player.newGamePlusMod() - 2);
				player.statPoints += 5 * player.newGamePlusMod();
			}
			if (player.hasPerk(PerkLib.AscensionHerosLineage)) {
				player.perkPoints += 2 * player.newGamePlusMod();
				player.statPoints += 10 * player.newGamePlusMod();
			}
			if (player.hasPerk(PerkLib.AscensionNaturalMetamorph)) {
				player.createPerk(PerkLib.GeneticMemory, 0, 0, 0, 0);
				player.createPerk(PerkLib.Metamorph, 0, 0, 0, 0);
				player.createPerk(PerkLib.MetamorphEx, 0, 0, 0, 0);
				//if(player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryStageX) > 6)
               //     player.createPerk(PerkLib.MetamorphMastery, 0, 0, 0, 0);
			}
			player.perkPoints += 1;
			//setupMutations();
			Metamorph.resetMetamorph();
			if (player.hasCock()) transformations.UnlockCocks();
			if (player.hasBalls()) Metamorph.unlockMetamorphEx(BallsMem.getMemory(BallsMem.DUO));
			if (player.hasVagina()) transformations.UnlockVagina();
			if (player.hasBreasts()) transformations.UnlockBreasts();
			clearOutput();
			statScreenRefresh();
			outputText("Would you like to play through the " + (1 * (1 + player.newGamePlusMod())) + "-day"+(player.newGamePlusMod() > 0 ? "s":"")+" prologue in Ingnam or just skip?");
			player.updateRacialAndPerkBuffs();
			player.HP = player.maxOverHP();
			//doYesNo(goToIngnam, arrival);
			menu();
			addButton(0, "Ingnam", goToIngnam);
			addButton(1,"Skip Ingnam", arrival);
		}

		public function goToIngnam():void {
			model.time.days = -(1 * (1 + player.newGamePlusMod()));
			model.time.hours = 8;
			flags[kFLAGS.IN_INGNAM] = 1;
			playerMenu();
		}

		/*
		public function setupMutations():void{
			for each(var mutation:IMutationPerkType in IMutationsLib.mutationsArray("")){
				if (!player.hasPerk(mutation)){
					player.createPerk(mutation,0,0,0,0);
				}
			}
			player.createPerk(IMutationsLib.MutationsTemplateIM,0,0,0,0);
			trace("Mutations setup charcreation done");
		}*/

		//-----------------
		//-- ASCENSION
		//-----------------
		private var migration: Boolean = false;
		private var migrationMsg: String = "";

		public function updateAscension(msg: String = ""): void {
			migration = true;
			migrationMsg = msg;
			ascensionMenu();
		}

		public function returnFromUpdateAscension(): void {
			migration = false;
			migrationMsg = "";
			Metamorph.registerPermanentMetamorphs();
			SceneLib.camp.campAfterMigration();
		}

		public function ascensionMenuChoice():void {
			outputText("\n\nWould you like to ascend without increasing the New Game+ cycle (difficulty) or not?");
			menu();
			addButton(1, "Yes", ascensionMenu).hint("Ascend with increased difficulty.");
			if (player.ascensionPerkPoints >= 50) addButton(3, "Maybe?", ascensionMenuChoiceMaybe).hint("Ascend without increasing difficulty.");
			else addButtonDisabled(3, "Maybe?", "50 ascension points required.");
		}
		public function ascensionMenuChoiceMaybe():void {
			player.ascensionPerkPoints -= 50;
			player.createPerk(PerkLib.AscensionMenuChoiceMaybe, 0, 0, 0, 0);
			ascensionMenu();
		}
		public function ascensionMenu():void {
			hideStats();
			clearOutput();
			hideMenus();
			mainView.nameBox.visible = false;
			EngineCore.displayHeader("Ascension" + (migration ? " (Update Migration)" : ""));
			if (migrationMsg) outputText(migrationMsg);
			outputText("The world you have departed is irrelevant and you are in an endless black void dotted with tens of thousands of stars. You encompass everything and everything encompasses you.");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			outputText("\n\n(When you're done, select " + (migration ? "Return" : "Reincarnate") + ".)");
			menu();
			addButton(0, "Perk Select(1)", ascensionPerkMenu).hint("Spend Ascension Perk Points on special perks!", "Perk Selection");
			addButton(1, "Perk Select(2)", ascensionPerkMenu2).hint("Spend Ascension Perk Points on special perks!", "Perk Selection");
			addButton(2, "Rare Perks(1)", rarePerks1).hint("Spend Ascension Points on rare special perks!", "Perk Selection");
			addButton(3, "Rare Perks(2)", rarePerks2).hint("Spend Ascension Points on rare special perks!", "Perk Selection");
			addButton(4, "Perm Spells", acensionPermSpellMenu).hint("Spend Ascension Perk Points to make certain spells permanent (10 points)", "Spell Selection");
			addButton(5, "Perm Perks", ascensionPermeryMenu).hint("Spend Ascension Perk Points to make certain perks permanent (5/10 points).", "Perk Selection");
			genMemPatch();
			if (player.hasStatusEffect(StatusEffects.TranscendentalGeneticMemory)) {
				var permMemtext:String = "You have permed <b>"+player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory)+"/"+player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)+"</b> from TranscendentalGeneticMemory tier "+player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryStageX);
				if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) < player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) {
					addButton(6, "Perm Met.", ascensionMetamorphPermMenu).hint("Spend Ascension Perk Points to make certain Metamorphs permanent.\n"+permMemtext, "Permanent Metamorphs");
				} else {
					addButtonDisabled(6, "Perm Met.", "Spend Ascension Perk Points to make certain Metamorphs permanent.\n\n<b>You already bought the maximum amount of Permanent Metamorphs allowed by your stage of Transcedental Genetic Memory!</b>\n"+permMemtext);
				}
			} else addButtonDisabled(6, "Perm Met.", "Spend Ascension Perk Points to make certain Metamorphs permanent.\n\n<b>In order to be able to select Metamorphs to make permanent, you need to buy Transcendental Genetic Memory from Rare Perks 2 first!</b>");
			if (player.ascensionPerkPoints >= 5) addButton(7, "Past Life", historyTopastlife).hint("Spend Ascension Points to change current possessed History perk into Past Life perk (5 points).", "Perk Selection");
			else addButtonDisabled(7, "Past Life", "You don't have enough Ascension Perk Points to use this option.");
			if (player.hasPerk(PerkLib.AscensionCruelChimerasThesis) && flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3) {
				if (player.ascensionPerkPoints >= 10) addButton(8, "Bloodline", bloodlineACQ).hint("Spend Ascension Points to change current possessed Descendant perk into Bloodline perk (10 points).", "Perk Selection");
				else addButtonDisabled(8, "Bloodline", "You don't have enough Ascension Perk Points to use this option.");
			}
			else addButtonDisabled(8, "???", "You don't have Ascended enough times or/and have required ascension perk to use this option.");
			addButton(10, "Rename", renamePrompt).hint("Change your name at no charge.");
			if (!migration) addButton(14, "Reincarnate", reincarnatePrompt).hint("Reincarnate and start an entirely new adventure.");
			else addButton(14, "Return", returnFromUpdateAscension).hint("Go back to your camp after updating your Ascension perks. (Only available during updates that refund points like this)");
		}
		private function genMemPatch():void{	//Cause for some fuckall rason the status gets wiped on ascending.
			if (player.hasStatusEffect(StatusEffects.TranscendentalGeneticMemory))
				player.removeStatusEffect(StatusEffects.TranscendentalGeneticMemory);
			if (player.hasPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX)) {
				var permedMetamorphCount:int = 0;
				for (var k:* in Metamorph.PermanentMemoryStorage) permedMetamorphCount++;
				var tier:int = player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryStageX) + 1;
				player.createStatusEffect(StatusEffects.TranscendentalGeneticMemory, (15*(tier-1)*(tier)/2), permedMetamorphCount, 0, 0);
			}
		}
		private function ascensionPerkMenu():void {
			clearOutput();
			outputText("You can spend your Ascension Perk Points on special perks not available at level-up!");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			var maxRank:int = maxRankValue();
			menu();
			var limitReached:String = "Limit Reached";
			addButton(0, "Killing Intent", ascensionPerkSelection, PerkLib.AscensionKillingIntent, MAX_KILLINGINTENT_LEVEL, null, PerkLib.AscensionKillingIntent.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionKillingIntent) + " / " + MAX_KILLINGINTENT_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionKillingIntent) >= MAX_KILLINGINTENT_LEVEL, limitReached);
			addButton(1, "Bloodlust", ascensionPerkSelection, PerkLib.AscensionBloodlust, MAX_BLOODLUST_LEVEL, null, PerkLib.AscensionBloodlust.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionBloodlust) + " / " + MAX_BLOODLUST_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionBloodlust) >= MAX_BLOODLUST_LEVEL, limitReached);
			addButton(2, "Mysticality", ascensionPerkSelection, PerkLib.AscensionMysticality, MAX_MYSTICALITY_LEVEL, null, PerkLib.AscensionMysticality.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionMysticality) + " / " + MAX_MYSTICALITY_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionMysticality) >= MAX_MYSTICALITY_LEVEL, limitReached);
			addButton(3, "S.Enlight.", ascensionPerkSelection, PerkLib.AscensionSpiritualEnlightenment, MAX_SPIRITUALENLIGHTENMENT_LEVEL, null, PerkLib.AscensionSpiritualEnlightenment.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionSpiritualEnlightenment) + " / " + MAX_SPIRITUALENLIGHTENMENT_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionSpiritualEnlightenment) >= MAX_SPIRITUALENLIGHTENMENT_LEVEL, limitReached);
			addButton(4, "Tolerance", ascensionPerkSelection, PerkLib.AscensionTolerance, MAX_TOLERANCE_LEVEL, null, PerkLib.AscensionTolerance.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionTolerance) + " / " + MAX_TOLERANCE_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionTolerance) >= MAX_TOLERANCE_LEVEL, limitReached);
			addButton(5, "Fertility", ascensionPerkSelection, PerkLib.AscensionFertility, MAX_FERTILITY_LEVEL, null, PerkLib.AscensionFertility.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionFertility) + " / " + MAX_FERTILITY_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionFertility) >= MAX_FERTILITY_LEVEL, limitReached);
			addButton(6, "Virility", ascensionPerkSelection, PerkLib.AscensionVirility, MAX_VIRILITY_LEVEL, null, PerkLib.AscensionVirility.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionVirility) + " / " + MAX_VIRILITY_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionVirility) >= MAX_VIRILITY_LEVEL, limitReached);
			addButton(7, "Wisdom", ascensionPerkSelection, PerkLib.AscensionWisdom, MAX_WISDOM_LEVEL, null, PerkLib.AscensionWisdom.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionWisdom) + " / " + maxRank)
				.disableIf(player.perkv1(PerkLib.AscensionWisdom) >= maxRank, limitReached);
			addButton(8, "Milk Faucet", ascensionPerkSelection, PerkLib.AscensionMilkFaucet, MAX_MILK_FAUCET_LEVEL, null, PerkLib.AscensionMilkFaucet.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionMilkFaucet) + " / " + MAX_MILK_FAUCET_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionMilkFaucet) >= MAX_MILK_FAUCET_LEVEL, limitReached);
			addButton(9, "Cum Hose", ascensionPerkSelection, PerkLib.AscensionCumHose, MAX_CUM_HOSE_LEVEL, null, PerkLib.AscensionCumHose.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionCumHose) + " / " + MAX_CUM_HOSE_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionCumHose) >= MAX_CUM_HOSE_LEVEL, limitReached);
			addButton(10, "Fortune", ascensionPerkSelection, PerkLib.AscensionFortune, MAX_FORTUNE_LEVEL, null, PerkLib.AscensionFortune.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionFortune) + " / " + maxRank)
				.disableIf(player.perkv1(PerkLib.AscensionFortune) >= maxRank, limitReached);
			addButton(11, "Moral Shifter", ascensionPerkSelection, PerkLib.AscensionMoralShifter, MAX_MORALSHIFTER_LEVEL, null, PerkLib.AscensionMoralShifter.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionMoralShifter) + " / " + MAX_MORALSHIFTER_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionMoralShifter) >= MAX_MORALSHIFTER_LEVEL, limitReached);
			addButton(14, "Back", ascensionMenu);
		}
		private function ascensionPerkMenu2():void {
			clearOutput();
			outputText("You can spend your Ascension Perk Points on special perks not available at level-up!");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
            var limitReached:String = "Limit Reached";
			addButton(0, "Desires", ascensionPerkSelection2, PerkLib.AscensionDesires, MAX_DESIRES_LEVEL, null, PerkLib.AscensionDesires.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionDesires) + " / " + MAX_DESIRES_LEVEL)
                    .disableIf(player.perkv1(PerkLib.AscensionDesires) >= MAX_DESIRES_LEVEL, limitReached);
			addButton(1, "Endurance", ascensionPerkSelection2, PerkLib.AscensionEndurance, MAX_ENDURANCE_LEVEL, null, PerkLib.AscensionEndurance.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionEndurance) + " / " + MAX_ENDURANCE_LEVEL)
                    .disableIf(player.perkv1(PerkLib.AscensionEndurance) >= MAX_ENDURANCE_LEVEL, limitReached);
			addButton(2, "Hardiness", ascensionPerkSelection2, PerkLib.AscensionHardiness, MAX_HARDINESS_LEVEL, null, PerkLib.AscensionHardiness.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionHardiness) + " / " + MAX_HARDINESS_LEVEL)
                    .disableIf(player.perkv1(PerkLib.AscensionHardiness) >= MAX_HARDINESS_LEVEL, limitReached);
			addButton(3, "Soul Purity", ascensionPerkSelection2, PerkLib.AscensionSoulPurity, MAX_SOULPURITY_LEVEL, null, PerkLib.AscensionSoulPurity.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionSoulPurity) + " / " + MAX_SOULPURITY_LEVEL)
                    .disableIf(player.perkv1(PerkLib.AscensionSoulPurity) >= MAX_SOULPURITY_LEVEL, limitReached);
			addButton(4, "Inner Power", ascensionPerkSelection2, PerkLib.AscensionInnerPower, MAX_INNERPOWER_LEVEL, null, PerkLib.AscensionInnerPower.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionInnerPower) + " / " + MAX_INNERPOWER_LEVEL)
                    .disableIf(player.perkv1(PerkLib.AscensionInnerPower) >= MAX_INNERPOWER_LEVEL, limitReached);
			addButton(5, "Fury", ascensionPerkSelection2, PerkLib.AscensionFury, MAX_FURY_LEVEL, null, PerkLib.AscensionFury.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionFury) + " / " + MAX_FURY_LEVEL)
                    .disableIf(player.perkv1(PerkLib.AscensionFury) >= MAX_FURY_LEVEL, limitReached);
			addButton(6, "Transhuman.", ascensionPerkSelection2, PerkLib.AscensionTranshumanism, MAX_TRANSHUMANISM_LEVEL, null, PerkLib.AscensionTranshumanism.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionTranshumanism) + " / " + MAX_TRANSHUMANISM_LEVEL)
                    .disableIf(player.perkv1(PerkLib.AscensionTranshumanism) >= MAX_TRANSHUMANISM_LEVEL, limitReached);
			addButton(7, "T-Human.ST", ascensionPerkSelection2, PerkLib.AscensionTranshumanismStr, MAX_TRANSHUMANISM_STR_LEVEL, null, PerkLib.AscensionTranshumanismStr.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionTranshumanismStr) + " / " + MAX_TRANSHUMANISM_STR_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionTranshumanismStr) >= MAX_TRANSHUMANISM_STR_LEVEL, limitReached);
			addButton(8, "T-Human.TO", ascensionPerkSelection2, PerkLib.AscensionTranshumanismTou, MAX_TRANSHUMANISM_TOU_LEVEL, null, PerkLib.AscensionTranshumanismTou.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionTranshumanismTou) + " / " + MAX_TRANSHUMANISM_TOU_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionTranshumanismTou) >= MAX_TRANSHUMANISM_TOU_LEVEL, limitReached);
			addButton(9, "T-Human.SP", ascensionPerkSelection2, PerkLib.AscensionTranshumanismSpe, MAX_TRANSHUMANISM_SPE_LEVEL, null, PerkLib.AscensionTranshumanismSpe.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionTranshumanismSpe) + " / " + MAX_TRANSHUMANISM_SPE_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionTranshumanismSpe) >= MAX_TRANSHUMANISM_SPE_LEVEL, limitReached);
			addButton(10, "T-Human.IN", ascensionPerkSelection2, PerkLib.AscensionTranshumanismInt, MAX_TRANSHUMANISM_INT_LEVEL, null, PerkLib.AscensionTranshumanismInt.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionTranshumanismInt) + " / " + MAX_TRANSHUMANISM_INT_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionTranshumanismInt) >= MAX_TRANSHUMANISM_INT_LEVEL, limitReached);
			addButton(11, "T-Human.WI", ascensionPerkSelection2, PerkLib.AscensionTranshumanismWis, MAX_TRANSHUMANISM_WIS_LEVEL, null, PerkLib.AscensionTranshumanismWis.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionTranshumanismWis) + " / " + MAX_TRANSHUMANISM_WIS_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionTranshumanismWis) >= MAX_TRANSHUMANISM_WIS_LEVEL, limitReached);
			addButton(12, "T-Human.Li", ascensionPerkSelection2, PerkLib.AscensionTranshumanismLib, MAX_TRANSHUMANISM_LIB_LEVEL, null, PerkLib.AscensionTranshumanismLib.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionTranshumanismLib) + " / " + MAX_TRANSHUMANISM_LIB_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionTranshumanismLib) >= MAX_TRANSHUMANISM_LIB_LEVEL, limitReached);
			addButton(13, "T-Human.SE", ascensionPerkSelection2, PerkLib.AscensionTranshumanismSen, MAX_TRANSHUMANISM_SEN_LEVEL, null, PerkLib.AscensionTranshumanismSen.longDesc + "\n\nCurrent level: " + player.perkv1(PerkLib.AscensionTranshumanismSen) + " / " + MAX_TRANSHUMANISM_SEN_LEVEL)
				.disableIf(player.perkv1(PerkLib.AscensionTranshumanismSen) >= MAX_TRANSHUMANISM_SEN_LEVEL, limitReached);
			addButton(14, "Back", ascensionMenu);
		}
		private function maxRankValue():Number {
			var maxV:Number = 0;
			if (!player.hasPerk(PerkLib.AscensionMenuChoiceMaybe)) maxV += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) maxV += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2) maxV += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3) maxV += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 4) maxV += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 5) maxV += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 6) maxV += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 7) maxV += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 8) maxV += 5;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 9) maxV += 5;
			return maxV;
		}

		private function ascensionPerkSelection(perk:* = null, maxRank:int = 10):void {
			clearOutput();
			maxRank = Math.min( maxRankValue(), maxRank );
			outputText("Perk Effect: " + perk.longDesc);
			outputText("\nCurrent level: " + player.perkv1(perk) + " / " + maxRank + "");
			if (player.perkv1(perk) >= maxRank) outputText(" <b>(Maximum)</b>");
			var cost:int = player.perkv1(perk) + 1;
			if (cost > 5) {
				if (cost > 15) {
					if (cost > 30) cost = 15;
					else cost = Math.round((cost + 15) / 3);
				}
				else {
					cost = Math.round((cost + 5) / 2);
				}
			}
			if (player.perkv1(perk) < maxRank) outputText("\nCost for next level: " + cost);
			else outputText("\nCost for next level: <b>N/A</b>");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			if (player.ascensionPerkPoints >= cost && player.perkv1(perk) < maxRank) addButton(0, "Add 1 level", addAscensionPerk, perk, maxRank);
			if (player.ascensionPerkPoints >= cost && player.perkv1(perk) == maxRank) addButtonDisabled(0, "Add 1 level", "You've reached max rank for this perk at current tier of ascension. To unlock higher ranks you need to Ascend again.");
			addButton(4, "Back", ascensionPerkMenu);
		}
		private function addAscensionPerk(perk:* = null, maxRank:int = 10):void {
			var cost:int = player.perkv1(perk) + 1;
			if (cost > 5) {
				if (cost > 15) {
					if (cost > 30) cost = 15;
					else cost = Math.round((cost + 15) / 3);
				}
				else {
					cost = Math.round((cost + 5) / 2);
				}
			}
			player.ascensionPerkPoints -= cost;
			if (player.hasPerk(perk)) player.addPerkValue(perk, 1, 1);
			else player.createPerk(perk, 1, 0, 0, 0);
			ascensionPerkSelection(perk, maxRank);
		}
		private function ascensionPerkSelection2(perk:* = null, maxRank:int = 10):void {
			clearOutput();
			maxRank = Math.min( maxRankValue(), maxRank );
			outputText("Perk Effect: " + perk.longDesc);
			outputText("\nCurrent level: " + player.perkv1(perk) + " / " + maxRank + "");
			if (player.perkv1(perk) >= maxRank) outputText(" <b>(Maximum)</b>");
			var cost:int = player.perkv1(perk) + 1;
			if (cost > 5) {
				if (cost > 15) {
					if (cost > 30) cost = 15;
					else cost = Math.round((cost + 15) / 3);
				}
				else {
					cost = Math.round((cost + 5) / 2);
				}
			}
			if (player.perkv1(perk) < maxRank) outputText("\nCost for next level: " + cost);
			else outputText("\nCost for next level: <b>N/A</b>");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			if (player.ascensionPerkPoints >= cost && player.perkv1(perk) < maxRank) addButton(0, "Add 1 level", addAscensionPerk2, perk, maxRank);
			if (player.ascensionPerkPoints >= cost && player.perkv1(perk) == maxRank) addButtonDisabled(0, "Add 1 level", "You've reached max rank for this perk at current tier of ascension. To unlock higher ranks you need to Ascend again.");
			addButton(4, "Back", ascensionPerkMenu2);
		}
		private function addAscensionPerk2(perk:* = null, maxRank:int = 10):void {
			var cost:int = player.perkv1(perk) + 1;
			if (cost > 5) {
				if (cost > 15) {
					if (cost > 30) cost = 15;
					else cost = Math.round((cost + 15) / 3);
				}
				else {
					cost = Math.round((cost + 5) / 2);
				}
			}
			player.ascensionPerkPoints -= cost;
			if (player.hasPerk(perk)) player.addPerkValue(perk, 1, 1);
			else player.createPerk(perk, 1, 0, 0, 0);
			ascensionPerkSelection2(perk, maxRank);
		}

		private function rarePerks1():void {
			clearOutput();
			outputText("You can spend your Ascension Perk Points on rare special perks not available at level-up!");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			var btn:int = 0;
			if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX)){
				perkAOMXCheck(player.perkv1(PerkLib.AscensionAdditionalOrganMutationX) + 1, btn);
			} else {
				perkAOMXCheck(1, btn);
			}
			btn++
			if (player.hasPerk(PerkLib.AscensionAdvTrainingX)){
				perkAdvancedTrainingCheck(player.perkv1(PerkLib.AscensionAdvTrainingX) + 1, btn);
			} else {
				perkAdvancedTrainingCheck(1, btn);
			}
			btn++
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3 && player.hasPerk(PerkLib.AscensionHerosLegacy)) {
				if (player.ascensionPerkPoints >= 75 && !player.hasPerk(PerkLib.AscensionBloodlineHeritage)) addButton(btn, "BloodHeritage", perkBloodlineHeritage).hint("Perk giving you an additional 1 perk point, 1 super perk point and 5 stat points at the start of the game (scaling with current NG tier, for super perk points amount is reduced by 3). Also would increase any bloodline perk bonus by 1.\n\nCost: 75 points");
				else if (player.ascensionPerkPoints < 75) button(btn).disable("You do not have enough ascension perk points!");
				else addButtonDisabled(btn, "BloodHeritage", "You already bought Bloodline Heritage perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && !player.hasPerk(PerkLib.AscensionHerosLegacy)) addButtonDisabled(btn, "BloodHeritage", "You need to buy Hero's Legacy perk first.");
			else addButtonDisabled(btn, "BloodHeritage", "You need ascend more times to buy this perk.");
			btn++;
			if (player.hasPerk(PerkLib.AscensionBuildingPrestigeX)){
				perkBPCheck(player.perkv1(PerkLib.AscensionBuildingPrestigeX) + 1, btn);
			} else {
				perkBPCheck(1, btn);
			}
			btn++
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.hasPerk(PerkLib.AscensionHybridTheory)) {
				if (player.ascensionPerkPoints >= 20 && !player.hasPerk(PerkLib.AscensionCruelChimerasThesis)) addButton(btn, "C Chimera's T", perkCruelChimerasThesis).hint("Perk allowing you to receive race bonuses for one point less. (still req. min 8 race points to work).\n\nCost: 20 points");
				else if (player.ascensionPerkPoints < 20) addButtonDisabled(btn, "C Chimera's T", "You do not have enough ascension perk points!");
				else addButtonDisabled(btn, "C Chimera's T", "You already bought Cruel Chimera's Thesis perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && !player.hasPerk(PerkLib.AscensionHybridTheory)) addButtonDisabled(btn, "C Chimera's T", "You need to buy Hybrid Theory perk first.");
			else addButtonDisabled(btn, "C Chimera's T", "You need ascend more times to buy this perk.");
			btn++;
			if (player.ascensionPerkPoints >= 5 && !player.hasPerk(PerkLib.AscensionHerosHeritage)) addButton(btn, "HeroHeritage", perkHerosHeritage).hint("Perk giving you an additional 3 perk points and 15 stat points at the start of the game (scaling with current NG tier).\n\nCost: 5 points");
			else if (player.ascensionPerkPoints < 5 && !player.hasPerk(PerkLib.AscensionHerosHeritage)) addButtonDisabled(btn, "HeroHeritage", "You do not have enough ascension perk points!");
			else addButtonDisabled(btn, "HeroHeritage", "You already bought Hero's Heritage perk.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.hasPerk(PerkLib.AscensionHerosHeritage)) {
				if (player.ascensionPerkPoints >= 10 && !player.hasPerk(PerkLib.AscensionHerosLineage)) addButton(btn, "HeroLineage", perkHerosLineage).hint("Perk giving you an additional 2 perk points and 10 stat points at the start of the game (scaling with current NG tier).\n\nCost: 10 points");
				else if (player.ascensionPerkPoints < 10) button(btn).disable("You do not have enough ascension perk points!");
				else addButtonDisabled(btn, "HeroLineage", "You already bought Hero's Lineage perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && !player.hasPerk(PerkLib.AscensionHerosHeritage)) addButtonDisabled(btn, "HeroLineage", "You need to buy Hero's Heritage perk first.");
			else addButtonDisabled(btn, "HeroLineage", "You need ascend more times to buy this perk.");
			btn++;
			if (player.ascensionPerkPoints >= 10 && !player.hasPerk(PerkLib.AscensionHybridTheory)) addButton(btn, "HybridTheory", perkHybridTheory).hint("Perk allowing you to receive race bonuses for one point less. (still req. min 4 race points to work).\n\nCost: 10 points");
			else if (player.ascensionPerkPoints < 10 && !player.hasPerk(PerkLib.AscensionHybridTheory)) addButtonDisabled(btn, "HybridTheory", "You do not have enough ascension perk points!");
			else addButtonDisabled(btn, "HybridTheory", "You already bought Hybrid Theory perk.");
			btn++;
			if (player.hasPerk(PerkLib.AscensionOneRaceToRuleThemAllX)){
				perkOneRaceToRuleThemAllCheck(player.perkv1(PerkLib.AscensionOneRaceToRuleThemAllX) + 1, btn);
			} else {
				perkOneRaceToRuleThemAllCheck(1, btn);
			}
			btn++
			if (player.hasPerk(PerkLib.AscensionHerosBirthrightRankX)){
				perkHerosBirthrightCheck(player.perkv1(PerkLib.AscensionHerosBirthrightRankX) + 1, btn);
			} else {
				perkHerosBirthrightCheck(1, btn);
			}
			btn++
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2 && player.hasPerk(PerkLib.AscensionHerosLineage)) {
				if (player.ascensionPerkPoints >= 25 && !player.hasPerk(PerkLib.AscensionHerosLegacy)) addButton(btn, "HeroLegacy", perkHerosLegacy).hint("Perk giving you an additional 1 perk point, 1 super perk point and 5 stat points at the start of the game (scaling with current NG tier, for super perk points amount is reduced by 2).\n\nCost: 25 points");
				else if (player.ascensionPerkPoints < 25) button(btn).disable("You do not have enough ascension perk points!");
				else addButtonDisabled(btn, "HeroLegacy", "You already bought Hero's Legacy perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2 && !player.hasPerk(PerkLib.AscensionHerosLineage)) addButtonDisabled(btn, "HeroLegacy", "You need to buy Hero's Lineage perk first.");
			else addButtonDisabled(btn, "HeroLegacy", "You need ascend more times to buy this perk.");
			btn++;
			addButton(14, "Back", ascensionMenu);
		}

		private function whichNewGameAreYouOn():Number {
			var wNGAYO:Number = flags[kFLAGS.NEW_GAME_PLUS_LEVEL];
			if (!player.hasPerk(PerkLib.AscensionMenuChoiceMaybe)) wNGAYO += 1;
			return wNGAYO;
		}

		private function perkAOMXCheck(tier:int, btn:int):void {
			var NGPL:Array = [1, 3, 5, 7];
			var pCost:int = 20;
			if (tier > 5) {
				addButtonDisabled(btn, "A.O.M. Rank "+ (tier-1).toString(),"You have the highest tier already.");
			}
			else if (whichNewGameAreYouOn() < NGPL[tier - 1]) {
				addButtonDisabled(btn, "A.O.M. Rank "+ tier.toString(),"You need to ascend a few more times.");
			}
			else if (player.internalChimeraScore() < 10 * tier) {
				addButtonDisabled(btn, "A.O.M. Rank "+ tier.toString(),"You do not have a high enough chimera score.");
			}
			else if (player.ascensionPerkPoints < pCost * tier) {
				addButtonDisabled(btn, "A.O.M. Rank "+ tier.toString(),"You do not have enough points.");
			}
			else {
				addButton(btn, "A.O.M. Tier " + tier.toString(), perkRPConfirm, tier, PerkLib.AscensionAdditionalOrganMutationX, pCost, "Acquire A.O.M. Prestige Rank " + tier.toString());
			}
		}

		private function perkBPCheck(tier:int, btn:int):void {
			var pCost:int = 5;
			if (tier > 6) {
				addButtonDisabled(btn, "B.Prestige. Rank "+ (tier-1).toString(),"You have the highest tier already.");
			}
			else if (whichNewGameAreYouOn() < tier) {
				addButtonDisabled(btn, "B.Prestige. Rank "+ tier.toString(),"You need to ascend once more.");
			}
			else if (player.ascensionPerkPoints < pCost * tier) {
				addButtonDisabled(btn, "B.Prestige. Rank "+ tier.toString(),"You do not have enough points.");
			}
			else {
				addButton(btn, "B. Prestige Rank" + tier.toString(), perkRPConfirm, tier, PerkLib.AscensionBuildingPrestigeX, pCost, "Acquire Building Prestige Rank " + tier.toString());
			}
		}

		private function perkAdvancedTrainingCheck(tier:int, btn:int):void {
			var pCost:int = 25;
			if (tier > 5) {
				addButtonDisabled(btn, "Adv. Training Rank "+ (tier-1).toString(),"You have the highest tier already.");
			}
			else if (whichNewGameAreYouOn() < tier) {
				addButtonDisabled(btn, "Adv. Training  Rank "+ tier.toString(),"You need to ascend once more.");
			}
			else if (player.ascensionPerkPoints < pCost * tier) {
				addButtonDisabled(btn, "Adv. Training  Rank "+ tier.toString(),"You do not have enough points.");
			}
			else {
				addButton(btn, "Adv. Training  Rank" + tier.toString(), perkRPConfirm, tier, PerkLib.AscensionAdvTrainingX, pCost, "Acquire Advanced Training Rank " + tier.toString());
			}
		}

		private function perkOneRaceToRuleThemAllCheck(tier:int, btn:int):void {
			var pCost:int = 10;
			if (tier > 5) {
				addButtonDisabled(btn, "ORTRTA Rank "+ (tier-1).toString(),"You have the highest tier already.");
			}
			else if (whichNewGameAreYouOn() < tier) {
				addButtonDisabled(btn, "ORTRTA Rank "+ tier.toString(),"You need to ascend once more.");
			}
			else if (player.ascensionPerkPoints < pCost * tier) {
				addButtonDisabled(btn, "ORTRTA Rank "+ tier.toString(),"You do not have enough points.");
			}
			else {
				addButton(btn, "ORTRTA Rank" + tier.toString(), perkRPConfirm, tier, PerkLib.AscensionOneRaceToRuleThemAllX, pCost, 
					"Acquire One Race To Rule Them All Rank " + tier.toString() + ".\n\nIncreases the number of stat points earned per level, and racial skill power.\n"
					+ "Cost: " + tier * pCost);
			}
		}
		
		private function perkHerosBirthrightCheck(tier:int, btn:int):void {
			var pCost:int = 10;
			if (tier > 6) {
				addButtonDisabled(btn, "HBirthright R "+ (tier-1).toString(),"You have the highest tier already.");
			}
			else if (whichNewGameAreYouOn() < tier) {
				addButtonDisabled(btn, "HBirthright R "+ tier.toString(),"You need to ascend once more.");
			}
			else if (player.ascensionPerkPoints < pCost * tier) {
				addButtonDisabled(btn, "HBirthright R "+ tier.toString(),"You do not have enough points.");
			}
			else {
				addButton(btn, "HBirthright R " + tier.toString(), perkRPConfirm, tier, PerkLib.AscensionHerosBirthrightRankX, pCost, 
					"Acquire Hero's Birthright Rank " + tier.toString() + ".\n\nReduces the level needed to equip legendary items by 9.\n"
					+ "Cost: " + tier * pCost);
			}
		}

		private function perkRPConfirm(tier:int, perk:PerkType, pCost:int, RPP:int = 1):void{
			player.ascensionPerkPoints -= pCost* tier;
			if (tier == 1) player.createPerk(perk,1,0,0,1);
			else player.setPerkValue(perk,1,player.perkv1(perk) + 1);
			clearOutput();
			outputText("You have acquired " + perk.name() + "!\n\n" + perk.desc());
			if (RPP == 1) doNext(rarePerks1);
			else doNext(rarePerks2);
		}

		private function perkBloodlineHeritage():void {
			player.ascensionPerkPoints -= 75;
			player.createPerk(PerkLib.AscensionBloodlineHeritage,0,0,0,1);
			clearOutput();
			outputText("You gained Bloodline Heritage perk.");
			doNext(rarePerks1);
		}
		private function perkCruelChimerasThesis():void {
			player.ascensionPerkPoints -= 20;
			player.createPerk(PerkLib.AscensionCruelChimerasThesis,0,0,0,1);
			clearOutput();
			outputText("You gained Cruel Chimera's Thesis perk.");
			doNext(rarePerks1);
		}
		private function perkHerosHeritage():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionHerosHeritage,0,0,0,1);
			clearOutput();
			outputText("You gained Hero's Heritage perk.");
			doNext(rarePerks1);
		}
		private function perkHerosLegacy():void {
			player.ascensionPerkPoints -= 25;
			player.createPerk(PerkLib.AscensionHerosLegacy,0,0,0,1);
			clearOutput();
			outputText("You gained Hero's Legacy perk.");
			doNext(rarePerks1);
		}
		private function perkHerosLineage():void {
			player.ascensionPerkPoints -= 10;
			player.createPerk(PerkLib.AscensionHerosLineage,0,0,0,1);
			clearOutput();
			outputText("You gained Hero's Lineage perk.");
			doNext(rarePerks1);
		}
		private function perkHybridTheory():void {
			player.ascensionPerkPoints -= 10;
			player.createPerk(PerkLib.AscensionHybridTheory,0,0,0,1);
			clearOutput();
			outputText("You gained Hybrid Theory perk.");
			doNext(rarePerks1);
		}

		private function rarePerks2():void {
			clearOutput();
			outputText("You can spend your Ascension Perk Points on rare special perks not available at level-up!");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			var btn:int = 0;
			perkMetamorphAscCheck(btn);
			btn++
			if (player.ascensionPerkPoints >= 5 && !player.hasPerk(PerkLib.AscensionUnderdog)) addButton(btn, "Underdog", perkUnderdog).hint("Perk allowing you to double base exp gains for fighting enemies above PC level, increasing max lvl diff when bonus is in effect will still increase from 20 to 40 above current PC lvl.\n\nCost: 5 points");// And... to live up to underdog role PC will 'accidentally' find few places to further power-up.
			else if (player.ascensionPerkPoints < 5 && !player.hasPerk(PerkLib.AscensionUnderdog)) addButtonDisabled(btn, "Underdog", "You do not have enough ascension perk points!");
			else addButtonDisabled(btn, "Underdog", "You already bought Underdog perk.");
			btn++;
			if (player.ascensionPerkPoints >= 5 && !player.hasPerk(PerkLib.AscensionUnlockedPotential)) addButton(btn, "UnlockPotent", perkUnlockedPotential).hint("Perk allowing you to have increased passive gains of max hp, lust and fatigue at each lvl-up.\n\nCost: 5 points");
			else if (player.ascensionPerkPoints < 5 && !player.hasPerk(PerkLib.AscensionUnlockedPotential)) addButtonDisabled(btn, "UnlockPotent", "You do not have enough ascension perk points!");
			else addButtonDisabled(btn, "UnlockPotent", "You already bought Unlocked Potential perk.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && player.hasPerk(PerkLib.AscensionUnlockedPotential)) {
				if (player.ascensionPerkPoints >= 5 && !player.hasPerk(PerkLib.AscensionUnlockedPotential2ndStage)) addButton(btn, "U.Potent2nd", perkUnlockedPotential2ndStage).hint("Perk allowing you to have increased passive gains of max wrath, mana and soulforce at each lvl-up.\n\nCost: 5 points");
				else if (player.ascensionPerkPoints < 5) addButtonDisabled(btn, "U.Potent2nd", "You do not have enough ascension perk points!");
				else addButtonDisabled(btn, "U.Potent2nd", "You already bought Unlocked Potential (2nd Stage) perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1 && !player.hasPerk(PerkLib.AscensionUnlockedPotential)) addButtonDisabled(btn, "U.Potent2nd", "You need to buy Unlocked Potential perk first.");
			else addButtonDisabled(btn, "U.Potent2nd", "You need ascend more times to buy this perk.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2 && player.hasPerk(PerkLib.AscensionUnlockedPotential2ndStage)) {
				if (player.ascensionPerkPoints >= 10 && !player.hasPerk(PerkLib.AscensionUnlockedPotential3rdStage)) addButton(btn, "U.Potent3rd", perkUnlockedPotential3rdStage).hint("Perk allowing you to have increased passive gains of max hp, lust and fatigue at each lvl-up.\n\nCost: 10 points");
				else if (player.ascensionPerkPoints < 10) addButtonDisabled(btn, "U.Potent3rd", "You do not have enough ascension perk points!");
				else addButtonDisabled(btn, "U.Potent3rd", "You already bought Unlocked Potential (3rd Stage) perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2 && !player.hasPerk(PerkLib.AscensionUnlockedPotential3rdStage)) addButtonDisabled(btn, "U.Potent3rd", "You need to buy Unlocked Potential (2nd Stage) perk first.");
			else addButtonDisabled(btn, "U.Potent3rd", "You need ascend more times to buy this perk.");
			btn++;
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3 && player.hasPerk(PerkLib.AscensionUnlockedPotential3rdStage)) {
				if (player.ascensionPerkPoints >= 10 && !player.hasPerk(PerkLib.AscensionUnlockedPotential4thStage)) addButton(btn, "U.Potent4th", perkUnlockedPotential4thStage).hint("Perk allowing you to have increased passive gains of max wrath, mana and soulforce at each lvl-up.\n\nCost: 10 points");
				else if (player.ascensionPerkPoints < 10) addButtonDisabled(btn, "U.Potent4th", "You do not have enough ascension perk points!");
				else addButtonDisabled(btn, "U.Potent4th", "You already bought Unlocked Potential (4th Stage) perk.");
			}
			else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 3 && !player.hasPerk(PerkLib.AscensionUnlockedPotential4thStage)) addButtonDisabled(btn, "U.Potent4th", "You need to buy Unlocked Potential (3rd Stage) perk first.");
			else addButtonDisabled(btn, "U.Potent4th", "You need ascend more times to buy this perk.");
			btn++;
			if (player.ascensionPerkPoints >= 21 && !player.hasPerk(PerkLib.AscensionSkyPoisonPearlMasteryStageX)) addButton(btn, "SPPearlMst1", perkSkyPoisonPearlMasteryStage1).hint("Perk allowing you to have increased venom recharge, max venom, poison resistance, amount of carried over spirit stones and unlock next sections of sky poison pearl 6 levels earlier.\n\nCost: 21 points");
			else if (player.ascensionPerkPoints < 21 && !player.hasPerk(PerkLib.AscensionSkyPoisonPearlMasteryStageX)) addButtonDisabled(btn, "SPPearlMst1", "You do not have enough ascension perk points!");
			else addButtonDisabled(btn, "SPPearlMst1", "You already bought Sky Poison Pearl Mastery 1 perk.");
			btn++;
			if (player.hasPerk(PerkLib.AscensionSkyPoisonPearlMasteryStageX) && player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX) > 0) {
				if (player.ascensionPerkPoints >= 57 && player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX) == 1) addButton(btn, "SPPearlMst2", perkSkyPoisonPearlMasteryStage2).hint("Perk allowing you to have increased venom recharge, max venom, poison resistance, amount of carried over spirit stones and unlock next sections of sky poison pearl 12 levels earlier.\n\nCost: 57 points");
				else if (player.ascensionPerkPoints < 57) addButtonDisabled(btn, "SPPearlMst2", "You do not have enough ascension perk points!");
				else if (player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX) > 1) addButtonDisabled(btn, "SPPearlMst2", "You already bought Sky Poison Pearl Mastery 2 perk.");
			}
			else addButtonDisabled(btn, "SPPearlMst2", "You need to buy Sky Poison Pearl Mastery 1 perk first.");
			btn++;
			if (player.hasPerk(PerkLib.AscensionSkyPoisonPearlMasteryStageX) && player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX) > 1) {
				if (player.ascensionPerkPoints >= 93 && player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX) == 2) addButton(btn, "SPPearlMst3", perkSkyPoisonPearlMasteryStage3).hint("Perk allowing you to have increased venom recharge, max venom, poison resistance, amount of carried over spirit stones and unlock next sections of sky poison pearl 18 levels earlier.\n\nCost: 93 points");
				else if (player.ascensionPerkPoints < 93) addButtonDisabled(btn, "SPPearlMst3", "You do not have enough ascension perk points!");
				else if (player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX) > 2) addButtonDisabled(btn, "SPPearlMst3", "You already bought Sky Poison Pearl Mastery 3 perk.");
			}
			else addButtonDisabled(btn, "SPPearlMst3", "You need to buy Sky Poison Pearl Mastery 2 perk first.");
			btn++;
			if (player.hasPerk(PerkLib.AscensionSkyPoisonPearlMasteryStageX) && player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX) > 2) {
				if (player.ascensionPerkPoints >= 129 && player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX) == 3) addButton(btn, "SPPearlMst4", perkSkyPoisonPearlMasteryStage4).hint("Perk allowing you to have increased venom recharge, max venom, poison resistance, amount of carried over spirit stones and unlock next sections of sky poison pearl 24 levels earlier.\n\nCost: 129 points");
				else if (player.ascensionPerkPoints < 129) addButtonDisabled(btn, "SPPearlMst4", "You do not have enough ascension perk points!");
				else if (player.perkv1(PerkLib.AscensionSkyPoisonPearlMasteryStageX) > 3) addButtonDisabled(btn, "SPPearlMst4", "You already bought Sky Poison Pearl Mastery 4 perk.");
			}
			else addButtonDisabled(btn, "SPPearlMst4", "You need to buy Sky Poison Pearl Mastery 3 perk first.");
			btn++;
		//	if (player.ascensionPerkPoints >= 10 && !player.hasPerk(PerkLib.AscensionHybridTheory)) addButton(btn, "HybridTheory", perkHybridTheory).hint("Perk allowing you to receive race bonuses for one point less. (still req. min 3 race points to work).\n\nCost: 10 points");
		//	else if (player.ascensionPerkPoints < 10) addButtonDisabled(btn, "HybridTheory", "You do not have enough ascension perk points!");
		//	else addButtonDisabled(btn, "HybridTheory", "You already bought this perk.");
		//	btn++;
			addButton(14, "Back", ascensionMenu);
		}

		private function perkMetamorphAscCheck(btn:int):void{
			if (!player.hasPerk(PerkLib.AscensionNaturalMetamorph)){
				if (player.ascensionPerkPoints < 30){
					addButtonDisabled(btn, "Nat.MetaMph", "You do not have enough point to acquire Natural Metamorph.");
				}
				else{
					addButton(btn, "Nat.MetaMph", curry(perkRPConfirm, 1, PerkLib.AscensionNaturalMetamorph, 30, 2))
						.hint("Gain free perks Genetic Memory, Metamorph, MetamorphEx at the start of the game\n\n"
							+ "Cost: 30 points.");
				}
			}
			else{
				var pCost:int = 15;
				if (!player.hasPerk(PerkLib.AscensionTrancendentalGeneticMemoryStageX)){
					if (player.ascensionPerkPoints < pCost){
						addButtonDisabled(btn, "Gen. Memory", "You do not have enough point to acquire Genetic Memory.");
					}
					else{
						addButton(btn, "Gen. Memory", curry(perkRPConfirm, 1, PerkLib.AscensionTrancendentalGeneticMemoryStageX, pCost, 2))
							.hint("Unlocks an ascension menu to make some metamorphs permanent and have them unlocked in your next runs.\n\n"
								+ "Cost: " + pCost * 1 + " points.");
					}
				}
				else {
					var tier:int = player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryStageX) + 1;
					if (player.ascensionPerkPoints < pCost * tier) {
						addButtonDisabled(btn, "Gen. Memory", "You do not have enough point to acquire Genetic Memory.");
					}
					else if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] < tier){
						addButtonDisabled(btn, "Gen. Memory", "You have not ascended enough times yet.");
					}
					else if (tier > 8){
						addButtonDisabled(btn, "Gen. Memory", "You have acquired the highest tier available.");
					}
					else {
						if (tier == 1){
							player.createStatusEffect(StatusEffects.TranscendentalGeneticMemory, 15, 0, 0, 9000);
						}
						else{
							player.changeStatusValue(StatusEffects.TranscendentalGeneticMemory, 1, (15*(tier-1)*(tier)/2));
						}
						addButton(btn, "Gen. Memory", curry(perkRPConfirm, tier, PerkLib.AscensionTrancendentalGeneticMemoryStageX, pCost, 2))
							.hint("Increases the maximum number of permed metamorphs."
								+ "Cost: " + pCost * tier + " points.");
					}
				}
			}
		}
		private function perkUnderdog():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionUnderdog,0,0,0,1);
			clearOutput();
			outputText("You gained Underdog perk.");
			doNext(rarePerks2);
		}
		private function perkUnlockedPotential():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionUnlockedPotential,0,0,0,1);
			clearOutput();
			outputText("You gained Unlocked Potential perk.");
			doNext(rarePerks2);
		}
		private function perkUnlockedPotential2ndStage():void {
			player.ascensionPerkPoints -= 5;
			player.createPerk(PerkLib.AscensionUnlockedPotential2ndStage,0,0,0,1);
			clearOutput();
			outputText("You gained Unlocked Potential (2nd Stage) perk.");
			doNext(rarePerks2);
		}
		private function perkUnlockedPotential3rdStage():void {
			player.ascensionPerkPoints -= 10;
			player.createPerk(PerkLib.AscensionUnlockedPotential3rdStage,0,0,0,1);
			clearOutput();
			outputText("You gained Unlocked Potential (3rd Stage) perk.");
			doNext(rarePerks2);
		}
		private function perkUnlockedPotential4thStage():void {
			player.ascensionPerkPoints -= 10;
			player.createPerk(PerkLib.AscensionUnlockedPotential4thStage,0,0,0,1);
			clearOutput();
			outputText("You gained Unlocked Potential (4th Stage) perk.");
			doNext(rarePerks2);
		}
		private function perkSkyPoisonPearlMasteryStage1():void {
			player.ascensionPerkPoints -= 21;
			player.createPerk(PerkLib.AscensionSkyPoisonPearlMasteryStageX,1,0,0,1);
			clearOutput();
			outputText("You gained Sky Poison Pearl Mastery 1 perk.");
			doNext(rarePerks2);
		}
		private function perkSkyPoisonPearlMasteryStage2():void {
			player.ascensionPerkPoints -= 57;
			player.addPerkValue(PerkLib.AscensionSkyPoisonPearlMasteryStageX,1,1);
			clearOutput();
			outputText("You increased Sky Poison Pearl Mastery from 1 to 2.");
			doNext(rarePerks2);
		}
		private function perkSkyPoisonPearlMasteryStage3():void {
			player.ascensionPerkPoints -= 93;
			player.addPerkValue(PerkLib.AscensionSkyPoisonPearlMasteryStageX,1,1);
			clearOutput();
			outputText("You increased Sky Poison Pearl Mastery from 2 to 3.");
			doNext(rarePerks2);
		}
		private function perkSkyPoisonPearlMasteryStage4():void {
			player.ascensionPerkPoints -= 129;
			player.addPerkValue(PerkLib.AscensionSkyPoisonPearlMasteryStageX,1,1);
			clearOutput();
			outputText("You increased Sky Poison Pearl Mastery from 3 to 4.");
			doNext(rarePerks2);
		}

		private function historyTopastlife():void {
			if (player.hasPerk(PerkLib.HistoryAlchemist)) {
				player.removePerk(PerkLib.HistoryAlchemist);
				player.createPerk(PerkLib.PastLifeAlchemist,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.hasPerk(PerkLib.HistoryCultivator)) {
				player.removePerk(PerkLib.HistoryCultivator);
				player.createPerk(PerkLib.PastLifeCultivator,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.hasPerk(PerkLib.HistoryFeral)) {
				player.removePerk(PerkLib.HistoryFeral);
				player.createPerk(PerkLib.PastLifeFeral,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.hasPerk(PerkLib.HistoryFighter)) {
				player.removePerk(PerkLib.HistoryFighter);
				player.createPerk(PerkLib.PastLifeFighter,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.hasPerk(PerkLib.HistoryFortune)) {
				player.removePerk(PerkLib.HistoryFortune);
				player.createPerk(PerkLib.PastLifeFortune,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.hasPerk(PerkLib.HistoryHealer)) {
				player.removePerk(PerkLib.HistoryHealer);
				player.createPerk(PerkLib.PastLifeHealer,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.hasPerk(PerkLib.HistoryReligious)) {
				player.removePerk(PerkLib.HistoryReligious);
				player.createPerk(PerkLib.PastLifeReligious,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.hasPerk(PerkLib.HistoryScholar)) {
				player.removePerk(PerkLib.HistoryScholar);
				player.createPerk(PerkLib.PastLifeScholar,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.hasPerk(PerkLib.HistoryScout)) {
				player.removePerk(PerkLib.HistoryScout);
				player.createPerk(PerkLib.PastLifeScout,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.hasPerk(PerkLib.HistorySlacker)) {
				player.removePerk(PerkLib.HistorySlacker);
				player.createPerk(PerkLib.PastLifeSlacker,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.hasPerk(PerkLib.HistorySlut)) {
				player.removePerk(PerkLib.HistorySlut);
				player.createPerk(PerkLib.PastLifeSlut,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.hasPerk(PerkLib.HistorySmith)) {
				player.removePerk(PerkLib.HistorySmith);
				player.createPerk(PerkLib.PastLifeSmith,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.hasPerk(PerkLib.HistoryTactician)) {
				player.removePerk(PerkLib.HistoryTactician);
				player.createPerk(PerkLib.PastLifeTactician,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.hasPerk(PerkLib.HistoryThief)) {
				player.removePerk(PerkLib.HistoryThief);
				player.createPerk(PerkLib.PastLifeThief,0,0,0,1);
				historyTopastlife2();
			}
			else if (player.hasPerk(PerkLib.HistoryWhore)) {
				player.removePerk(PerkLib.HistoryWhore);
				player.createPerk(PerkLib.PastLifeWhore,0,0,0,1);
				historyTopastlife2();
			}
			else {
				clearOutput();
				outputText("You don't have any History perk to change into Past Life perk.");
			}
			doNext(ascensionMenu);
		}
		private function historyTopastlife2():void {
			player.ascensionPerkPoints -= 5;
			clearOutput();
			outputText("Your History perk became your Past Life perk.");
		}

		private function bloodlineACQ():void {
			if (player.hasPerk(PerkLib.DragonsDescendant)) {
				player.removePerk(PerkLib.DragonsDescendant);
				player.createPerk(PerkLib.BloodlineDragon,0,0,0,1);
				bloodlineACQ2();
			}
			else if (player.hasPerk(PerkLib.ElfsDescendant)) {
				player.removePerk(PerkLib.ElfsDescendant);
				player.createPerk(PerkLib.BloodlineElf,0,0,0,1);
				bloodlineACQ2();
			}
			else if (player.hasPerk(PerkLib.GoblinsDescendant)) {
				player.removePerk(PerkLib.GoblinsDescendant);
				player.createPerk(PerkLib.BloodlineGoblin,0,0,0,1);
				bloodlineACQ2();
			}
			else if (player.hasPerk(PerkLib.KitsunesDescendant)) {
				player.removePerk(PerkLib.KitsunesDescendant);
				player.createPerk(PerkLib.BloodlineKitsune,0,0,0,1);
				bloodlineACQ2();
			}
			else if (player.hasPerk(PerkLib.RaijusDescendant)) {
				player.removePerk(PerkLib.RaijusDescendant);
				player.createPerk(PerkLib.BloodlineRaiju,0,0,0,1);
				bloodlineACQ2();
			}
			else if (player.hasPerk(PerkLib.MinotaursDescendant)) {
				player.removePerk(PerkLib.MinotaursDescendant);
				player.createPerk(PerkLib.BloodlineMinotaur,0,0,0,1);
				bloodlineACQ2();
			}
			else if (player.hasPerk(PerkLib.OnisDescendant)) {
				player.removePerk(PerkLib.OnisDescendant);
				player.createPerk(PerkLib.BloodlineOni,0,0,0,1);
				bloodlineACQ2();
			}
			else if (player.hasPerk(PerkLib.OrcsDescendant)) {
				player.removePerk(PerkLib.OrcsDescendant);
				player.createPerk(PerkLib.BloodlineOrc,0,0,0,1);
				bloodlineACQ2();
			}
			else if (player.hasPerk(PerkLib.VampiresDescendant)) {
				player.removePerk(PerkLib.VampiresDescendant);
				player.createPerk(PerkLib.BloodlineVampire,0,0,0,1);
				bloodlineACQ2();
			}
			else if (player.hasPerk(PerkLib.MelkiesDescendant)) {
				player.removePerk(PerkLib.MelkiesDescendant);
				player.createPerk(PerkLib.BloodlineMelkie,0,0,0,1);
				bloodlineACQ2();
			}

			else {
				clearOutput();
				outputText("You don't have any Descendant perks to change into Bloodline perks.");
			}
			doNext(ascensionMenu);
		}
		private function bloodlineACQ2():void {
			player.ascensionPerkPoints -= 10;
			clearOutput();
			outputText("Your have gained new Bloodline.");
		}

		private function acensionPermSpellMenu(page:int = 1):void {
			clearOutput();
			outputText("For the price of ten points, you can make certain spells permanent and they will carry over in future ascensions. In addition, they can be used even if you don't have access to the specifc category spells yet.");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			if (page == 1) {
				if (player.hasStatusEffect(StatusEffects.KnowsPolarMidnight) && player.statusEffectv4(StatusEffects.KnowsPolarMidnight) != 9000) addButton(0, "Polar Midnight", permanentizeSpell, StatusEffects.KnowsPolarMidnight, 1);
				else if (player.hasStatusEffect(StatusEffects.KnowsPolarMidnight) && player.statusEffectv4(StatusEffects.KnowsPolarMidnight) == 9000) addButtonDisabled(0, "Polar Midnight", "Polar Midnight spell is already permanent.");
				else addButtonDisabled(0, "???", "You haven't learnt this spell yet!");

				if (player.hasStatusEffect(StatusEffects.KnowsMeteorShower) && player.statusEffectv4(StatusEffects.KnowsMeteorShower) != 9000) addButton(1, "Meteor Shower", permanentizeSpell, StatusEffects.KnowsMeteorShower, 1);
				else if (player.hasStatusEffect(StatusEffects.KnowsMeteorShower) && player.statusEffectv4(StatusEffects.KnowsMeteorShower) == 9000) addButtonDisabled(1, "Meteor Shower", "Meteor Shower spell is already permanent.");
				else addButtonDisabled(1, "???", "You haven't learnt this spell yet!");
			}
			addButton(14, "Back", ascensionMenu);
		}

		private function ascensionPermeryMenu(page:int = 1):void {
			clearOutput();
			outputText("For the price of five points, you can make certain perks permanent and they will carry over in future ascensions. In addition, if the perks come from transformations, they will stay even if you no longer meet the requirements.");
			outputText("\n\nAscension Perk Points: " + player.ascensionPerkPoints);
			menu();
			if (page == 1) {
				if (player.hasPerk(PerkLib.CorruptedKitsune) && player.perkv4(PerkLib.CorruptedKitsune) < 1 && player.hasPerk(PerkLib.CorruptedNinetails) && player.perkv4(PerkLib.CorruptedNinetails) < 1) addButton(0, "CorruptedK", permanentizePerkCorruptedKitsuneAndNinetails);
				else if (player.hasPerk(PerkLib.CorruptedKitsune) && player.perkv4(PerkLib.CorruptedKitsune) > 0 && player.hasPerk(PerkLib.CorruptedNinetails) && player.perkv4(PerkLib.CorruptedNinetails) > 0) addButtonDisabled(0, "CorruptedK", "Corrupted Kitsune and Corrupted Ninetails perks are already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "CorruptedK", "Corrupted Kitsune and Corrupted Ninetails");
				if (player.hasPerk(PerkLib.DarkCharm) && player.perkv4(PerkLib.DarkCharm) < 1) addButton(1, "DarkCharm", permanentizePerk1, PerkLib.DarkCharm);
				else if (player.hasPerk(PerkLib.DarkCharm) && player.perkv4(PerkLib.DarkCharm) > 0) addButtonDisabled(1, "DarkCharm", "Dark Charm perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "DarkCharm", "Dark Charm");
				if (player.hasPerk(PerkLib.DragonDarknessBreath) && player.perkv4(PerkLib.DragonDarknessBreath) < 1) addButton(2, "D.DarknessB.", permanentizePerk1, PerkLib.DragonDarknessBreath);
				else if (player.hasPerk(PerkLib.DragonDarknessBreath) && player.perkv4(PerkLib.DragonDarknessBreath) > 0) addButtonDisabled(2, "D.DarknessB.", "Dragon Darkness Breath perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "D.DarknessB.", "Dragon Darkness Breath");
				//3 DragonEarthBreath
				if (player.hasPerk(PerkLib.DragonFaerieBreath) && player.perkv4(PerkLib.DragonFaerieBreath) < 1) addButton(3, "D.FaerieB.", permanentizePerk1, PerkLib.DragonFaerieBreath);
				else if (player.hasPerk(PerkLib.DragonFaerieBreath) && player.perkv4(PerkLib.DragonFaerieBreath) > 0) addButtonDisabled(3, "D.FaerieB.", "Dragon Faerie Breath perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "D.FaerieB.", "Dragon Faerie Breath");
				addButton(4, "Next", ascensionPermeryMenu, page + 1);
				if (player.hasPerk(PerkLib.DragonFireBreath) && player.perkv4(PerkLib.DragonFireBreath) < 1) addButton(5, "D.FireB.", permanentizePerk1, PerkLib.DragonFireBreath);
				else if (player.hasPerk(PerkLib.DragonFireBreath) && player.perkv4(PerkLib.DragonFireBreath) > 0) addButtonDisabled(5, "D.FireB.", "Dragon Fire Breath perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "D.FireB.", "Dragon Fire Breath");
				if (player.hasPerk(PerkLib.DragonIceBreath) && player.perkv4(PerkLib.DragonIceBreath) < 1) addButton(6, "D.IceB.", permanentizePerk1, PerkLib.DragonIceBreath);
				else if (player.hasPerk(PerkLib.DragonIceBreath) && player.perkv4(PerkLib.DragonIceBreath) > 0) addButtonDisabled(6, "D.IceB.", "Dragon Ice Breath perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "D.IceB.", "Dragon Ice Breath");
				if (player.hasPerk(PerkLib.DragonLightningBreath) && player.perkv4(PerkLib.DragonLightningBreath) < 1) addButton(7, "D.LightningB.", permanentizePerk1, PerkLib.DragonLightningBreath);
				else if (player.hasPerk(PerkLib.DragonLightningBreath) && player.perkv4(PerkLib.DragonLightningBreath) > 0) addButtonDisabled(7, "D.LightningB.", "Dragon Lightning Breath perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "D.LightningB.", "Dragon Lightning Breath");
				if (player.hasPerk(PerkLib.DragonLustPoisonBreath) && player.perkv4(PerkLib.DragonLustPoisonBreath) < 1) addButton(8, "D.LustPoisonB.", permanentizePerk1, PerkLib.DragonLustPoisonBreath);
				else if (player.hasPerk(PerkLib.DragonLustPoisonBreath) && player.perkv4(PerkLib.DragonLustPoisonBreath) > 0) addButtonDisabled(8, "D.LustPoisonB.", "Dragon Lust Poison Breath perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "D.LustPoisonB.", "Dragon Lust Poison Breath");
				if (player.hasPerk(PerkLib.DragonPoisonBreath) && player.perkv4(PerkLib.DragonPoisonBreath) < 1) addButton(10, "D.PoisonB.", permanentizePerk1, PerkLib.DragonPoisonBreath);
				else if (player.hasPerk(PerkLib.DragonPoisonBreath) && player.perkv4(PerkLib.DragonPoisonBreath) > 0) addButtonDisabled(10, "D.PoisonB.", "Dragon Poison Breath perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "D.PoisonB.", "Dragon Poison Breath");
				if (player.hasPerk(PerkLib.DragonRegalBreath) && player.perkv4(PerkLib.DragonRegalBreath) < 1) addButton(11, "D.RegalB.", permanentizePerk1, PerkLib.DragonRegalBreath);
				else if (player.hasPerk(PerkLib.DragonRegalBreath) && player.perkv4(PerkLib.DragonRegalBreath) > 0) addButtonDisabled(11, "D.RegalB.", "Dragon Regal Breath perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "D.RoyalB.", "Dragon Royal Breath");
				if (player.hasPerk(PerkLib.DragonWaterBreath) && player.perkv4(PerkLib.DragonWaterBreath) < 1) addButton(12, "D.WaterB.", permanentizePerk1, PerkLib.DragonWaterBreath);
				else if (player.hasPerk(PerkLib.DragonWaterBreath) && player.perkv4(PerkLib.DragonWaterBreath) > 0) addButtonDisabled(12, "D.WaterB.", "Dragon Water Breath perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "D.WaterB.", "Dragon Water Breath");
				if (player.hasPerk(PerkLib.EnlightenedKitsune) && player.perkv4(PerkLib.EnlightenedKitsune) < 1 && player.hasPerk(PerkLib.EnlightenedNinetails) && player.perkv4(PerkLib.EnlightenedNinetails) < 1) addButton(13, "EnlightenedK", permanentizePerkEnlightenedKitsuneAndNinetails);
				else if (player.hasPerk(PerkLib.EnlightenedKitsune) && player.perkv4(PerkLib.EnlightenedKitsune) > 0 && player.hasPerk(PerkLib.EnlightenedNinetails) && player.perkv4(PerkLib.EnlightenedNinetails) > 0) addButtonDisabled(13, "EnlightenedK", "Enlightened Kitsune and Enlightened Ninetails perks are already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "EnlightenedK", "Enlightened Kitsune and Enlightened Ninetails");
			}
			if (page == 2) {
				if (player.hasPerk(PerkLib.FerasBoonAlpha) && player.perkv4(PerkLib.FerasBoonAlpha) < 1) addButton(0, "FerasB.A.", permanentizePerk2, PerkLib.FerasBoonAlpha);
				else if (player.hasPerk(PerkLib.FerasBoonAlpha) && player.perkv4(PerkLib.FerasBoonAlpha) > 0) addButtonDisabled(0, "FerasB.A.", "Feras Boon Alpha perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "FerasB.A.", "Feras Boon Alpha");
				if (player.hasPerk(PerkLib.FerasBoonBreedingBitch) && player.perkv4(PerkLib.FerasBoonBreedingBitch) < 1) addButton(1, "FerasB.B.B.", permanentizePerk2, PerkLib.FerasBoonBreedingBitch);
				else if (player.hasPerk(PerkLib.FerasBoonBreedingBitch) && player.perkv4(PerkLib.FerasBoonBreedingBitch) > 0) addButtonDisabled(1, "FerasB.B.B.", "Feras Boon Breeding Bitch perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "FerasB.B.B.", "Feras Boon Breeding Bitch");
				if (player.hasPerk(PerkLib.FerasBoonMilkingTwat) && player.perkv4(PerkLib.FerasBoonMilkingTwat) < 1) addButton(2, "FerasB.M.T.", permanentizePerk2, PerkLib.FerasBoonMilkingTwat);
				else if (player.hasPerk(PerkLib.FerasBoonMilkingTwat) && player.perkv4(PerkLib.FerasBoonMilkingTwat) > 0) addButtonDisabled(2, "FerasB.M.T.", "Feras Boon Milking Twat perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "FerasB.M.T.", "Feras Boon Milking Twat");
				if (player.hasPerk(PerkLib.FerasBoonSeeder) && player.perkv4(PerkLib.FerasBoonSeeder) < 1) addButton(3, "FerasB.S.", permanentizePerk2, PerkLib.FerasBoonSeeder);
				else if (player.hasPerk(PerkLib.FerasBoonSeeder) && player.perkv4(PerkLib.FerasBoonSeeder) > 0) addButtonDisabled(3, "FerasB.S.", "Feras Boon Seeder perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "FerasB.S.", "Feras Boon Seeder");
				addButton(4, "Next", ascensionPermeryMenu, page + 1);
				if (player.hasPerk(PerkLib.FerasBoonWideOpen) && player.perkv4(PerkLib.FerasBoonWideOpen) < 1) addButton(5, "FerasB.W.O.", permanentizePerk2, PerkLib.FerasBoonWideOpen);
				else if (player.hasPerk(PerkLib.FerasBoonWideOpen) && player.perkv4(PerkLib.FerasBoonWideOpen) > 0) addButtonDisabled(5, "FerasB.W.O.", "Feras Boon Wide Open perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "FerasB.W.O.", "Feras Boon Wide Open");
				if (player.hasPerk(PerkLib.FireLord) && player.perkv4(PerkLib.FireLord) < 1) addButton(6, "FireLord", permanentizePerk2, PerkLib.FireLord);
				else if (player.hasPerk(PerkLib.FireLord) && player.perkv4(PerkLib.FireLord) > 0) addButtonDisabled(6, "FireLord", "FireLord perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "FireLord", "FireLord");
				if (player.hasPerk(PerkLib.Flexibility) && player.perkv4(PerkLib.Flexibility) < 1) addButton(7, "Flexibility", permanentizePerk2, PerkLib.Flexibility);
				else if (player.hasPerk(PerkLib.Flexibility) && player.perkv4(PerkLib.Flexibility) > 0) addButtonDisabled(7, "Flexibility", "Flexibility perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(7, "Flexibility", "Flexibility");
				if (player.hasPerk(PerkLib.Hellfire) && player.perkv4(PerkLib.Hellfire) < 1) addButton(8, "Hellfire", permanentizePerk2, PerkLib.Hellfire);
				else if (player.hasPerk(PerkLib.Hellfire) && player.perkv4(PerkLib.Hellfire) > 0) addButtonDisabled(8, "Hellfire", "Hellfire perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "Hellfire", "Hellfire");
				addButton(9, "Previous", ascensionPermeryMenu, page - 1);
				if (player.hasPerk(PerkLib.InkSpray) && player.perkv4(PerkLib.InkSpray) < 1) addButton(10, "InkSpray", permanentizePerk2, PerkLib.InkSpray);
				else if (player.hasPerk(PerkLib.InkSpray) && player.perkv4(PerkLib.InkSpray) > 0) addButtonDisabled(10, "InkSpray", "Ink Spray perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "InkSpray", "Ink Spray");
				if (player.hasPerk(PerkLib.LizanRegeneration) && player.perkv4(PerkLib.LizanRegeneration) < 1) addButton(11, "LizanRegen", permanentizePerk2, PerkLib.LizanRegeneration);
				else if (player.hasPerk(PerkLib.LizanRegeneration) && player.perkv4(PerkLib.LizanRegeneration) > 0) addButtonDisabled(11, "LizanRegen", "Lizan Regeneration perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "LizanRegen", "Lizan Regeneration");
				if (player.hasPerk(PerkLib.Lustzerker) && player.perkv4(PerkLib.Lustzerker) < 1) addButton(12, "Lustzerker", permanentizePerk2, PerkLib.Lustzerker);
				else if (player.hasPerk(PerkLib.Lustzerker) && player.perkv4(PerkLib.Lustzerker) > 0) addButtonDisabled(12, "Lustzerker", "Lustzerker perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "Lustzerker", "Lustzerker");
				if (player.hasPerk(PerkLib.MagicalFertility) && player.perkv4(PerkLib.MagicalFertility) < 1) addButton(13, "MagicalF.", permanentizePerk2, PerkLib.MagicalFertility);
				else if (player.hasPerk(PerkLib.MagicalFertility) && player.perkv4(PerkLib.MagicalFertility) > 0) addButtonDisabled(13, "MagicalF.", "Magical Fertility perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(13, "MagicalF.", "Magical Fertility");
			}
			if (page == 3) {
				if (player.hasPerk(PerkLib.MagicalVirility) && player.perkv4(PerkLib.MagicalVirility) < 1) addButton(0, "MagicalV.", permanentizePerk3, PerkLib.MagicalVirility);
				else if (player.hasPerk(PerkLib.MagicalVirility) && player.perkv4(PerkLib.MagicalVirility) > 0) addButtonDisabled(0, "MagicalV.", "Magical Virility perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(0, "MagicalV.", "Magical Virility");
				if (player.hasPerk(PerkLib.MaraesGiftButtslut) && player.perkv4(PerkLib.MaraesGiftButtslut) < 1) addButton(1, "MaraesGiftB.", permanentizePerk3, PerkLib.MaraesGiftButtslut);
				else if (player.hasPerk(PerkLib.MaraesGiftButtslut) && player.perkv4(PerkLib.MaraesGiftButtslut) > 0) addButtonDisabled(1, "MaraesGiftB.", "Maraes Gift Buttslut perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(1, "MaraesGiftB.", "Maraes Gift Buttslut");
				if (player.hasPerk(PerkLib.MaraesGiftFertility) && player.perkv4(PerkLib.MaraesGiftFertility) < 1) addButton(2, "MaraesGiftF.", permanentizePerk3, PerkLib.MaraesGiftFertility);
				else if (player.hasPerk(PerkLib.MaraesGiftFertility) && player.perkv4(PerkLib.MaraesGiftFertility) > 0) addButtonDisabled(2, "MaraesGiftF.", "Maraes Gift Fertility perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(2, "MaraesGiftF.", "Maraes Gift Fertility");
				if (player.hasPerk(PerkLib.MaraesGiftProfractory) && player.perkv4(PerkLib.MaraesGiftProfractory) < 1) addButton(3, "MaraesGiftP.", permanentizePerk3, PerkLib.MaraesGiftProfractory);
				else if (player.hasPerk(PerkLib.MaraesGiftProfractory) && player.perkv4(PerkLib.MaraesGiftProfractory) > 0) addButtonDisabled(3, "MaraesGiftP.", "Maraes Gift Profractory perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(3, "MaraesGiftP.", "Maraes Gift Profractory");
				//addButton(4, "Next", ascensionPermeryMenu, page + 1);
				if (player.hasPerk(PerkLib.MaraesGiftStud) && player.perkv4(PerkLib.MaraesGiftStud) < 1) addButton(5, "MaraesGiftS.", permanentizePerk3, PerkLib.MaraesGiftStud);
				else if (player.hasPerk(PerkLib.MaraesGiftStud) && player.perkv4(PerkLib.MaraesGiftStud) > 0) addButtonDisabled(5, "MaraesGiftS.", "Maraes Gift Stud perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(5, "MaraesGiftS.", "Maraes Gift Stud");
				if (player.hasPerk(PerkLib.MilkMaid) && player.perkv4(PerkLib.MilkMaid) < 1) addButton(6, "MilkMaid", permanentizePerk3, PerkLib.MilkMaid);
				else if (player.hasPerk(PerkLib.MilkMaid) && player.perkv4(PerkLib.MilkMaid) > 0) addButtonDisabled(6, "MilkMaid", "MilkMaid perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(6, "MilkMaid", "MilkMaid");
				if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2) {
					if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance) && player.perkv4(PerkLib.NinetailsKitsuneOfBalance) < 1) addButton(7, "9TKitsOfB", permanentizePerk3, PerkLib.NinetailsKitsuneOfBalance);
					else if (player.hasPerk(PerkLib.NinetailsKitsuneOfBalance) && player.perkv4(PerkLib.NinetailsKitsuneOfBalance) > 0) addButtonDisabled(7, "9TKitsOfB", "9T Kitsune Of Balance perk is already made permanent and will carry over in all subsequent ascensions.");
				}
				else addButtonDisabled(7, "9TKitsOfB", "9T Kitsune Of Balance");
				if (player.hasPerk(PerkLib.OneTrackMind) && player.perkv4(PerkLib.OneTrackMind) < 1) addButton(8, "OneTrackMind", permanentizePerk3, PerkLib.OneTrackMind);
				else if (player.hasPerk(PerkLib.OneTrackMind) && player.perkv4(PerkLib.OneTrackMind) > 0) addButtonDisabled(8, "OneTrackMind", "One Track Mind perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(8, "OneTrackMind", "One Track Mind");
				addButton(9, "Previous", ascensionPermeryMenu, page - 1);
				if (player.hasPerk(PerkLib.PureAndLoving) && player.perkv4(PerkLib.PureAndLoving) < 1) addButton(10, "Pure&Loving", permanentizePerk3, PerkLib.PureAndLoving);
				else if (player.hasPerk(PerkLib.PureAndLoving) && player.perkv4(PerkLib.PureAndLoving) > 0) addButtonDisabled(10, "Pure&Loving", "Pure And Loving perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(10, "Pure&Loving", "Pure And Loving");
				if (player.hasPerk(PerkLib.PurityBlessing) && player.perkv4(PerkLib.PurityBlessing) < 1) addButton(11, "PurityBlessing", permanentizePerk3, PerkLib.PurityBlessing);
				else if (player.hasPerk(PerkLib.PurityBlessing) && player.perkv4(PerkLib.PurityBlessing) > 0) addButtonDisabled(11, "PurityBlessing", "Purity Blessing perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(11, "PurityBlessing", "Purity Blessing");
				if (player.hasPerk(PerkLib.SensualLover) && player.perkv4(PerkLib.SensualLover) < 1) addButton(12, "SensualLover", permanentizePerk3, PerkLib.SensualLover);
				else if (player.hasPerk(PerkLib.SensualLover) && player.perkv4(PerkLib.SensualLover) > 0) addButtonDisabled(12, "SensualLover", "Sensual Lover perk is already made permanent and will carry over in all subsequent ascensions.");
				else addButtonDisabled(12, "SensualLover", "Sensual Lover");
			}
			addButton(14, "Back", ascensionMenu);
		}

		private function permanentizeSpell(statusEffect:StatusEffectType, returnPage:int = 1):void {
			//Not enough points or perk already permed? Cancel.
			if (player.ascensionPerkPoints < 10) return;
			if (player.statusEffectv4(statusEffect) == 9000) return;
			//Deduct points
			player.ascensionPerkPoints -= 10;
			//Permanentize a perk
			player.changeStatusValue(statusEffect, 4, 9000);
			acensionPermSpellMenu(returnPage);
		}
		private function permanentizePerk1(perk:PerkType):void {
			//Not enough points or perk already permed? Cancel.
			if (player.ascensionPerkPoints < 5) return;
			if (player.perkv4(perk) > 0) return;
			//Deduct points
			player.ascensionPerkPoints -= 5;
			//Permanentize a perk
			player.addPerkValue(perk, 4, 1);
			ascensionPermeryMenu(1);
		}
		private function permanentizePerk2(perk:PerkType):void {
			//Not enough points or perk already permed? Cancel.
			if (player.ascensionPerkPoints < 5) return;
			if (player.perkv4(perk) > 0) return;
			//Deduct points
			player.ascensionPerkPoints -= 5;
			//Permanentize a perk
			player.addPerkValue(perk, 4, 1);
			ascensionPermeryMenu(2);
		}
		private function permanentizePerk3(perk:PerkType):void {
			//Not enough points or perk already permed? Cancel.
			if (player.ascensionPerkPoints < 5) return;
			if (player.perkv4(perk) > 0) return;
			//Deduct points
			player.ascensionPerkPoints -= 5;
			//Permanentize a perk
			player.addPerkValue(perk, 4, 1);
			ascensionPermeryMenu(3);
		}
		private function permanentizePerkEnlightenedKitsuneAndNinetails():void {
			//Not enough points or perk already permed? Cancel.
			if (player.ascensionPerkPoints < 10) return;
			if (player.perkv4(PerkLib.EnlightenedKitsune) > 0) return;
			if (player.perkv4(PerkLib.EnlightenedNinetails) > 0) return;
			//Deduct points
			player.ascensionPerkPoints -= 10;
			//Permanentize a perk
			player.addPerkValue(PerkLib.EnlightenedKitsune, 4, 1);
			player.addPerkValue(PerkLib.EnlightenedNinetails, 4, 1);
			ascensionPermeryMenu(1);
		}
		private function permanentizePerkCorruptedKitsuneAndNinetails():void {
			//Not enough points or perk already permed? Cancel.
			if (player.ascensionPerkPoints < 10) return;
			if (player.perkv4(PerkLib.CorruptedKitsune) > 0) return;
			if (player.perkv4(PerkLib.CorruptedNinetails) > 0) return;
			//Deduct points
			player.ascensionPerkPoints -= 10;
			//Permanentize a perk
			player.addPerkValue(PerkLib.CorruptedKitsune, 4, 1);
			player.addPerkValue(PerkLib.CorruptedNinetails, 4, 1);
			ascensionPermeryMenu(1);
		}

		public function ascensionMetamorphPermMenu(currentPage: int = 0):void {
			clearOutput();
			outputText("<font size=\"36\" face=\"Georgia\"><u>Permanentize Metamorphs</u></font>\n");
			outputText("You can spend Ascension points to keep the available Metamorphs indefinitely, regardless of how many times you Ascend.\n\n");
			outputText("<b>Metamorphs Permanentized:</b> " + player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) + "/" + player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory) + "\n\n");
			outputText("Ascension Perk Points: " + player.ascensionPerkPoints + "\n\n");
			outputText("GenMem Tier: " + player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryStageX));

			menu();

			const menusList: Array = [
				{
					name: "Complete",
					func: accessCompleteMenu,
					hint: "Requires 6 tiers of Genetic Memories bought"
				},
				{
					name: "Hair",
					func: accessHairMenu
				},
				{
					name: "Face",
					func: accessFaceMenu
				},
				{
					name: "Eyes",
					func: accessEyesMenu
				},
				{
					name: "Tongue",
					func: accessTongueMenu
				},
				{
					name: "Ears",
					func: accessEarsMenu
				},
				{
					name: "Arms",
					func: accessArmsMenu
				},
				{
					name: "Lower Body",
					func: accessLowerBodyMenu
				},
				{
					name: "Rear Body",
					func: accessRearBodyMenu
				},
				{
					name: "Skin",
					func: accessSkinMenu
				},
				{
					name: "Patterns",
					func: accessSkinPatternsMenu
				},
				{
					name: "Antennae",
					func: accessAntennaeMenu
				},
				{
					name: "Horns",
					func: accessHornsMenu
				},
				{
					name: "Gills",
					func: accessGillsMenu
				},
				{
					name: "Wings",
					func: accessWingsMenu
				},
				{
					name: "Tail",
					func: accessTailMenu
				},
				{
					name: "Breasts",
					func: accessBreastsMenu
				},
				{
					name: "Vagina Unlock",
					func: accessVaginaUnlockMenu
				},
				{
					name: "Vagina",
					func: accessVaginaMenu
				},
				{
					name: "PenisCount",
					func: accessCockCountMenu
				},
				{
					name: "Penis",
					func: accessCockMenu
				},
				{
					name: "Balls",
					func: accessBallsMenu
				},
				{
					name: "Specials",
					func: accessSexSpecialsMenu
				}
			];

			const menusPerPage: int = menusList.length > 14 ? 12 : 14;

			const lastPage: int = Math.ceil(menusList.length/menusPerPage) - 1;

			const pageMenus: Array = menusList.slice(currentPage * menusPerPage, (currentPage * menusPerPage) + menusPerPage);

			var currentButton: int = 0;

			for each (var menuObj: * in pageMenus) {
				if( menuObj.name == "Complete" && player.perkv1(PerkLib.AscensionTrancendentalGeneticMemoryStageX) < 5)
                    addButtonDisabled(currentButton, menuObj.name, menuObj.func).hint(menuObj.hint);
				else {
                    if (menuObj.hint) {
                        addButton(currentButton, menuObj.name, menuObj.func).hint(menuObj.hint);

                    } else {
                        addButton(currentButton, menuObj.name, menuObj.func);
                    }
                }
				currentButton++;
			}

			if (lastPage > 0) {
				if (currentPage > 0) addButton(12, "Prev Page", ascensionMetamorphPermMenu, currentPage - 1);
				else addButtonDisabled (12, "Prev Page");
				if (currentPage < lastPage) addButton(13, "Next Page", ascensionMetamorphPermMenu, currentPage + 1);
				else addButtonDisabled (13, "Next Page");
			}

			addButton(14, "Back", ascensionMenu);
		}

		private function accessCompleteMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Full Body", accessCompleteMenu, currentPage, RaceMem.Memories);
		}

		private function accessHornsMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Horns", accessHornsMenu, currentPage, HornsMem.Memories);
		}

		private function accessHairMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Hair", accessHairMenu, currentPage, HairMem.Memories);
		}

		private function accessFaceMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Face", accessFaceMenu, currentPage, FaceMem.Memories);
		}

		private function accessEyesMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Eyes", accessEyesMenu, currentPage, EyesMem.Memories);
		}

		private function accessTongueMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Tongue", accessTongueMenu, currentPage, TongueMem.Memories);
		}

		private function accessEarsMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Ears", accessEarsMenu, currentPage, EarsMem.Memories);
		}

		private function accessArmsMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Arms", accessArmsMenu, currentPage, ArmsMem.Memories);
		}

		private function accessWingsMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Wings", accessWingsMenu, currentPage, WingsMem.Memories);
		}

		private function accessLowerBodyMenu(currentPage: int = 0): void {
			// Hides Taur variants of pre-existing TFs
			var memArray: Array = LowerBodyMem.Memories.filter(function(element: *, index: int, array: Array): Boolean {
				return element && !element.taurVariant
			});

			memArray.unshift({
		  	id: "Taur Lower Body",
				permCost: 50,
				permInfo: "Enables metamorphosis to Taur variants of several lower body parts.",
		  	title: "Taur Shape"
			});

			openPaginatedMetamorphMenu("Lower Body", accessLowerBodyMenu, currentPage, memArray);
		}

		private function accessSkinMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Skin", accessSkinMenu, currentPage, SkinMem.Memories);
		}

		private function accessRearBodyMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Rear Body", accessRearBodyMenu, currentPage, RearBodyMem.Memories);
		}

		private function accessAntennaeMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Antennae", accessAntennaeMenu, currentPage, AntennaeMem.Memories);
		}

		private function accessSkinPatternsMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Skin Patterns", accessSkinPatternsMenu, currentPage, SkinPatternMem.Memories);
		}

		private function accessGillsMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Gills", accessGillsMenu, currentPage, GillsMem.Memories);
		}

		private function accessTailMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Tail", accessTailMenu, currentPage, TailMem.Memories);
		}

		private function accessBreastsMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Breasts", accessBreastsMenu, currentPage, BreastMem.Memories);
		}

		private function accessVaginaUnlockMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Vagina Unlock", accessVaginaUnlockMenu, currentPage, VaginaCountMem.Memories);
		}

		private function accessVaginaMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Vagina", accessVaginaMenu, currentPage, VaginaMem.Memories);
		}

		private function accessCockMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Cock", accessCockMenu, currentPage, CockMem.Memories);
		}

		private function accessCockCountMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Cock Count", accessCockCountMenu, currentPage, CockCountMem.Memories);
		}

		private function accessBallsMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Balls", accessBallsMenu, currentPage, BallsMem.Memories);
		}

		private function accessSexSpecialsMenu(currentPage: int = 0): void {
			openPaginatedMetamorphMenu("Specials", accessSexSpecialsMenu, currentPage, SpecialsMem.Memories);
		}

		private function openPaginatedMetamorphMenu (title: String, thisMenu: *, currentPage: int, memArray:Array): void {
			clearOutput();
			outputText("<font size=\"36\" face=\"Georgia\"><u>Permanentize Metamorphs - " + title +"</u></font>\n");
			outputText("You can spend Ascension points to keep the available Metamorphs indefinitely, regardless of how many times you Ascend.\n\n");
			outputText("<b>Metamorphs Permanentized:</b> " + player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) + "/" + player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory) + "\n\n");
			outputText("Ascension Perk Points: " + player.ascensionPerkPoints);
			menu();

			const menuInfo: * = {
				title: title,
				thisMenu: thisMenu,
				currentPage: currentPage,
				memArray: memArray
			};

			memArray = memArray.filter(function(element: *, index: int, array: Array): Boolean {
				return element && element.id !== "Unlocked Metamorph"
			});

			const memsPerPage: int = memArray.length > 14 ? 12 : 14;

			const lastPage: int = Math.ceil(memArray.length/memsPerPage) - 1;

			const pageMems: Array = memArray.slice(currentPage * memsPerPage, (currentPage * memsPerPage) + memsPerPage);

			var currentButton: int = 0;

			for each (var genMem: * in pageMems) {
				const buttonStr: String = genMem.title || "";
				const unlocked: Boolean = Metamorph.GeneticMemoryStorage[genMem.id];
				const enoughPP: Boolean = player.ascensionPerkPoints >= (genMem.permCost || 5);
				const obtained: Boolean = Metamorph.PermanentMemoryStorage[genMem.id];
				const hasRequirements: Boolean = (genMem.permReq ? Metamorph.PermanentMemoryStorage[genMem.permReq] || false : true);

				if (unlocked && hasRequirements && enoughPP && !obtained) addButton(currentButton, buttonStr, permanentizeMetamorph, menuInfo, genMem).hint("Cost: " + (genMem.permCost || 5) + " Ascension Perk Points" + (genMem.permInfo ? "\n\n" + genMem.permInfo : ""));
				else if (unlocked && !hasRequirements && !obtained) addButtonDisabled(currentButton, buttonStr, "Cost: " + (genMem.permCost || 5) + " Ascension Perk Points\n\n<b>Requirement</b>: Permanentize " + genMem.permReq);
				else if (unlocked && hasRequirements && !enoughPP && !obtained) addButtonDisabled(currentButton, buttonStr, "Cost: " + (genMem.permCost || 5) + " Ascension Perk Points (You don't have enough Ascension Perk Points to permanentize this metamorphosis!)");
				else if (obtained) addButtonDisabled(currentButton, buttonStr, "You already permanentized this metamorphosis!");
				else if (!unlocked) addButtonDisabled(currentButton, buttonStr, "You can't permanentize a metamorphosis you didn't unlock!");
				currentButton++;
			}

			if (lastPage > 0) {
				if (currentPage > 0) addButton(12, "Prev Page", thisMenu, currentPage - 1);
				else addButtonDisabled (12, "Prev Page");
				if (currentPage < lastPage) addButton(13, "Next Page", thisMenu, currentPage + 1);
				else addButtonDisabled (13, "Next Page");
			}

			addButton(14, "Back", ascensionMetamorphPermMenu);
		}

		private function permanentizeMetamorph (menuInfo: *, genMem: *): void {
			player.ascensionPerkPoints -= (genMem.permCost || 5);
			Metamorph.PermanentMemoryStorage[genMem.id] = true;
			player.addStatusValue(StatusEffects.TranscendentalGeneticMemory, 2, 1);

			if (player.statusEffectv2(StatusEffects.TranscendentalGeneticMemory) < player.statusEffectv1(StatusEffects.TranscendentalGeneticMemory)) {
				openPaginatedMetamorphMenu(menuInfo.title, menuInfo.thisMenu, menuInfo.currentPage, menuInfo.memArray);
			} else {
				clearOutput();
				outputText("<font size=\"36\" face=\"Georgia\"><u>Permanentize Metamorphs</u></font>\n");
				outputText("<b>You've permanentized the maximum amount of metamorphs available for your current stage of Transcedental Genetic Memory!</b>");
				menu();
				doNext(ascensionMenu);
			}

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
			menu();
			if (player.hasPerk(PerkLib.AscensionMenuChoiceMaybe)) addButton(1, "Yes", reincarnate002).hint("Reincarnate");
			else addButton(1, "Yes", reincarnate001).hint("Reincarnate");
			addButton(3, "No", ascensionMenu).hint("Go Back");
		}
		private function reincarnate001():void {
			flags[kFLAGS.NEW_GAME_PLUS_LEVEL]++;
			reincarnate();
		}
		private function reincarnate002():void {
			player.removePerk(PerkLib.AscensionMenuChoiceMaybe);
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0){ //In case ng0, otherwise, player is treated as new char.
				flags[kFLAGS.NEW_GAME_PLUS_LEVEL] = 0.5;
			}
			reincarnate();
		}

		private function removePerksThatShouldntBeFuckingPermanent():void {
			if (player.hasPerk(PerkLib.ELFElvenSpearDancingFlurry1to4))
				player.removePerk(PerkLib.ELFElvenSpearDancingFlurry1to4);
			if (player.hasPerk(PerkLib.MindbreakerBrain1toX))
				player.removePerk(PerkLib.MindbreakerBrain1toX);
			if (player.hasPerk(PerkLib.CorruptedNinetails) && player.perkv4(PerkLib.CorruptedNinetails) == 0 )
				player.removePerk(PerkLib.CorruptedNinetails);
			if (player.hasPerk(PerkLib.CorruptedKitsune) && player.perkv4(PerkLib.CorruptedKitsune) == 0 )
				player.removePerk(PerkLib.CorruptedKitsune);
			if (player.hasPerk(PerkLib.EnlightenedNinetails) && player.perkv4(PerkLib.EnlightenedNinetails) == 0 )
				player.removePerk(PerkLib.EnlightenedNinetails);
			if (player.hasPerk(PerkLib.EnlightenedKitsune) && player.perkv4(PerkLib.EnlightenedKitsune) == 0 )
				player.removePerk(PerkLib.EnlightenedKitsune);
		}

		private function reincarnate():void {
			Metamorph.resetMetamorph();
			player.setArmor(armors.C_CLOTH, false, true);
			player.unequipWeapon(false, true);
			player.unequipWeaponRange(false, true);
			player.unequipShield(false, true);
			player.unequipHeadJewelry(false, true);
			player.unequipNecklace(false, true);
			player.unequipJewelry1(false, true);
			player.unequipJewelry2(false, true);
			player.unequipJewelry3(false, true);
			player.unequipJewelry4(false, true);
			player.unequipVehicle(false, true);
			player.unequipMiscJewelry1(false, true);
			player.unequipMiscJewelry2(false, true);
			player.unequipWeaponFlyingSwords(false, true);
			player.createKeyItem("Ascension", 0, 0, 0, 0);
			customPlayerProfile = null;
			newGameGo();
			removePerksThatShouldntBeFuckingPermanent();
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] == 0.5){
				flags[kFLAGS.NEW_GAME_PLUS_LEVEL] = 0
			}
			player.removeKeyItem("Ascension");
			clearOutput();
			mainView.nameBox.visible = false;
			mainView.hideComboBox();
			outputText("Everything fades to white and finally... black. You can feel yourself being whisked back to reality as you slowly awaken in your room. You survey your surroundings and recognize almost immediately; you are in your room inside the inn in Ingnam! You get up and look around. ");
			if (player.hasKeyItem("Sky Poison Pearl") >= 0) {
				outputText("\n\nYou soon notice a circular green imprint at the palm of your left hand. When you try to figure out its meaning something clicks in your mind. It's a strange artifact that fused with your body that allows the storing of a multitude of objects. ...An artifact that fused with your body? You are unable to recall when th... Wait a second there are a few almost fully faded memory fragments of you being somewhere underwater, ");
				outputText("fearlessly facing some huge monster with tentacles for legs... Doing your uttermost effort to survive and win.. no other memories.. not even the slightest of fragments appear in your mind. Resigned, you try to concentrate on remembering how to use this thing, but those memories are still too blurred out to make sense of. Maybe with time you'll remember all about this... 'thing'.")
			}
			player.breastRows = [];
			player.cocks = [];
			player.vaginas = new <VaginaClass>[];
			player.horns.count = 0;
			player.horns.type = Horns.NONE;
			player.antennae.type = Antennae.NONE;
			player.ears.type = Ears.HUMAN;
			player.eyes.type = Eyes.HUMAN;
			player.tongue.type = Tongue.HUMAN;
			player.gills.type = Gills.NONE;
			player.arms.type = Arms.HUMAN;
			player.wings.type = Wings.NONE;
			player.rearBody.type = RearBody.NONE;
			player.lowerBody = LowerBody.HUMAN;
			player.skin.base.pattern = Skin.PATTERN_NONE;
			player.skin.base.adj = "";
			player.legCount = 2;
			player.tailType = Tail.NONE;
			player.tailRecharge = 0;
			player.level = 0;
			player.initCombatMastery();
			player.teaseLevel = 0;
			player.teaseXP = 0;
			player.miningLevel = 0;
			player.miningXP = 0;
			player.farmingLevel = 0;
			player.farmingXP = 0;
			player.herbalismLevel = 0;
			player.herbalismXP = 0;
			player.statPoints = 0;
			player.perkPoints = 0;
			player.superPerkPoints = 0;
			player.XP = 0;
			inventory.clearStorage();
			inventory.clearGearStorage();
			inventory.initializeGearStorage();
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
			return perk.ptype.keepOnAscension(respec) || (perk.value4 > 0);
		}

		private function isSpecialKeyItem(keyName:* = null):Boolean {//tylko sky poinson pearl zostawić tutaj
			return (keyName == "Ascension" || keyName == "Sky Poison Pearl" || keyName == "Nieve's Tear");
		}

		private function isSpecialStatus(statusEffects:StatusEffectClass, statusEffect:* = null):Boolean {
			return (statusEffect == StatusEffects.KnowsWereBeast || statusEffects.value4 == 9000);	//na razie jest tu tylko werebeast
		}	//ale potem zamienić to na specialne soulskills z każdego z klanów

		public static function hasAscensionSpell(spellCat:int):Boolean {
			var spellsToCheck:/*StatusEffect*/Array;
			switch(spellCat) {
				case CombatAbility.CAT_SPELL_WHITE: spellsToCheck = [StatusEffects.KnowsMeteorShower];
													break;
				case CombatAbility.CAT_SPELL_BLACK: spellsToCheck = [StatusEffects.KnowsPolarMidnight];
													break;
			}
			if (spellsToCheck) {
				return spellsToCheck.some(function (statusEffect:StatusEffectType):Boolean {
					return player.hasStatusEffect(statusEffect) && player.statusEffectv4(statusEffect) == 9000;
				});
			} else
				return false;
		}
	} // what the fuck are those weird comments here? ^
}