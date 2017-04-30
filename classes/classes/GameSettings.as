package classes 
{
	import classes.GlobalFlags.*;
	import coc.view.MainView;
	import flash.display.StageQuality;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author ...
	 */
	public class GameSettings extends BaseContent
	{
		
		public function GameSettings() {}
		
		public function settingsScreenMain():void
		{
			kGAMECLASS.saves.savePermObject(false);
			mainView.showMenuButton(MainView.MENU_NEW_MAIN);
			mainView.showMenuButton(MainView.MENU_DATA);
			clearOutput();
			displayHeader("Settings");
			outputText("Here, you can adjust the gameplay and interface settings. Setting flags are saved in a special file so you don't have to re-adjust it each time you load a save file.");
			menu();
			addButton(0, "Gameplay", settingsScreenGameSettings);
			addButton(1, "Interface", settingsScreenInterfaceSettings);
			addButton(3, "Font Size", fontSettingsMenu);
			addButton(4, "Controls", kGAMECLASS.displayControls);

			addButton(14, "Back", kGAMECLASS.mainMenu.mainMenu);

			if (flags[kFLAGS.HARDCORE_MODE] > 0)
			{
				debug = false;
				flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
				flags[kFLAGS.HYPER_HAPPY] = 0;
				flags[kFLAGS.LOW_STANDARDS_FOR_ALL] = 0;
			}
		}

		//------------
		// GAMEPLAY
		//------------
		public function settingsScreenGameSettings():void {
			clearOutput();
			displayHeader("Gameplay Settings");
			
			if (flags[kFLAGS.HARDCORE_MODE] > 0) outputText("<font color=\"#ff0000\">Hardcore mode is enabled. Cheats are disabled.</font>\n\n");

			if (debug) outputText("Debug Mode: <font color=\"#008000\"><b>ON</b></font>\n Items will not be consumed by use, fleeing always succeeds, and bad-ends can be ignored.");
			else outputText("Debug Mode: <font color=\"#800000\"><b>OFF</b></font>\n Items consumption will occur as normal.");
			
			outputText("\n\n");
			switch(flags[kFLAGS.GAME_DIFFICULTY]) {
				case 0:
					if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG]) outputText("Difficulty: <font color=\"#008000\"><b>Easy</b></font>\n Combat is easier and bad-ends can be ignored.");
					else outputText("Difficulty: <font color=\"#808000\"><b>Normal</b></font>\n No opponent stats modifiers. You can resume from bad-ends with penalties.");
					break;
				case 1:
					outputText("Difficulty: <b><font color=\"#800000\">Hard</font></b>\n Opponent has 25% more HP and does 15% more damage. Bad-ends can ruin your game.");
					break;
				case 2:
					outputText("Difficulty: <b><font color=\"#C00000\">Nightmare</font></b>\n Opponent has 50% more HP and does 30% more damage.");
					break;
				case 3:
					outputText("Difficulty: <b><font color=\"#FF0000\">Extreme</font></b>\n Opponent has 100% more HP and does more 50% damage.");
					break;
			}


			/*if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG]) outputText("Easy Mode: <font color=\"#008000\"><b>ON</b></font>\n Bad-ends can be ignored and combat is easier.");
			else outputText("Easy Mode: <font color=\"#800000\"><b>OFF</b></font>\n Bad-ends can ruin your game and combat is challenging.");

			outputText("\n\n");*/
			
			outputText("\n\n");
			
			if (flags[kFLAGS.SILLY_MODE_ENABLE_FLAG]) outputText("Silly Mode: <font color=\"#008000\"><b>ON</b></font>\n Crazy, nonsensical, and possibly hilarious things may occur.");
			else outputText("Silly Mode: <font color=\"#800000\"><b>OFF</b></font>\n You're an incorrigible stick-in-the-mud with no sense of humor.");

			outputText("\n\n");
			
			outputText("<b>The following flags are not fully implemented yet (e.g. they don't apply in <i>all</i> cases where they could be relevant).</b>\n");
			outputText("Additional note: You <b>must</b> be <i>in a game session</i> (e.g. load your save, hit \"Main Menu\", change the flag settings, and then hit \"Resume\") to change these flags. They're saved into the saveGame file, so if you load a save, it will clear them to the state in that save.");
			
			outputText("\n\n");

			if (flags[kFLAGS.LOW_STANDARDS_FOR_ALL]) outputText("Low standards Mode: <font color=\"#008000\"><b>ON</b></font>\n NPCs ignore body type preferences. \n (Not gender preferences though. You still need the right hole.)");
			else outputText("Low standards Mode: <font color=\"#800000\"><b>OFF</b></font>\n NPCs have body-type preferences.");

			outputText("\n\n");

			if (flags[kFLAGS.HYPER_HAPPY]) outputText("Hyper Happy Mode: <font color=\"#008000\"><b>ON</b></font>\n Only reducto and humus shrink endowments. \n Incubus draft doesn't affect breasts, and succubi milk doesn't affect cocks.");
			else outputText("Hyper Happy Mode: <font color=\"#800000\"><b>OFF</b></font>\n Male enhancement potions shrink female endowments, and vice versa.");
				
			outputText("\n\n");		
				
			if (flags[kFLAGS.SFW_MODE] >= 1) outputText("SFW Mode: <font color=\"#008000\"><b>ON</b></font>\n Sex scenes are disabled and adult materials are hidden.");
			else outputText("SFW Mode: <font color=\"#800000\"><b>OFF</b></font>\n Sex scenes are enabled.");
				
			outputText("\n\n");
				
			if (flags[kFLAGS.WATERSPORTS_ENABLED] >= 1 && flags[kFLAGS.SFW_MODE] <= 0) outputText("Watersports: <font color=\"#008000\"><b>Enabled</b></font>\n Watersports scenes are enabled. (You kinky person)");
			else outputText("Watersports: <font color=\"#800000\"><b>Disabled</b></font>\n Watersports scenes are disabled.");
				
			outputText("\n\n");
			
			if (flags[kFLAGS.AUTO_LEVEL] >= 1) outputText("Automatic Leveling: <font color=\"#008000\"><b>ON</b></font>\n Leveling up is done automatically once you accumulate enough experience.");
			else outputText("Automatic Leveling: <font color=\"#800000\"><b>OFF</b></font>\n Leveling up is done manually.");

			menu();
			addButton(0, "Toggle Debug", toggleDebug, null, null, null, "Turn on debug mode. Debug mode is intended for testing purposes but can be thought of as a cheat mode.  Items are infinite and combat is easy to escape from.  Weirdness and bugs are to be expected.");
			if (player.str > 0)
				addButton(1, "Difficulty", difficultySelectionMenu, null, null, null, "Adjust the game difficulty to make it easier or harder.");
			else
				addButtonDisabled(1, "Difficulty", "Please start a game session before you can use this.");
			addButton(2, "Silly Toggle", toggleSillyFlag, null, null, null, "Toggles silly mode. Funny, crazy and nonsensical scenes may occur if enabled.");
			addButton(3, "Low Standards", toggleStandards);
			addButton(4, "Hyper Happy", toggleHyperHappy);
			
			addButton(5, "SFW Toggle", toggleSFW, null, null, null, "Toggles SFW Mode. If enabled, sex scenes are hidden and all adult materials are censored. \n\nCurrently under development, only disables most sex scenes. Soon, it'll disable rape scenes."); //Softcore Mode
			addButton(6, "Auto level", toggleAutoLevel, null, null, null, "Toggles automatic leveling when you accumulate sufficient experience.");
			if (player.str > 0) addButton(8, "Enable Surv", enableSurvivalPrompt, null, null, null, "Enable Survival mode. This will enable hunger. \n\n<font color=\"#080000\">Note: This is permanent and cannot be turned off!</font>", "Enable Survival Mode");	
			if (player.str > 0) addButton(9, "Enable Real", enableRealisticPrompt, null, null, null, "Enable Realistic mode. This will make the game a bit realistic. \n\n<font color=\"#080000\">Note: This is permanent and cannot be turned off! Do not turn this on if you have hyper endowments.</font>", "Enable Realistic Mode");	
			addButton(10, "Fetishes", fetishSubMenu, null, null, null, "Toggle some of the weird fetishes such as watersports and worms.");

			if (flags[kFLAGS.HUNGER_ENABLED] >= 0.5)
			{
				addButtonDisabled(8, "Enable Surv", "This is already enabled.", "Enable Survival Mode");
			}
			if (flags[kFLAGS.HUNGER_ENABLED] >= 1)
			{
				addButtonDisabled(9, "Enable Real", "This is already enabled.", "Enable Realistic Mode");
			}
			if (flags[kFLAGS.HARDCORE_MODE] > 0) {
				addButtonDisabled(0, "Debug", "You cannot enable debug in Hardcore Mode. No cheating!");
				addButtonDisabled(1, "Difficulty", "You cannot change difficulty in Hardcore Mode.");
				addButtonDisabled(3, "Low Standards", "You cannot enable Low Standards in Hardcore Mode.");
				addButtonDisabled(4, "Hyper Happy", "You cannot enable Hyper Happy in Hardcore Mode.");
				debug = false;
				flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
				flags[kFLAGS.HYPER_HAPPY] = 0;
				flags[kFLAGS.LOW_STANDARDS_FOR_ALL] = 0;
			}
			if (flags[kFLAGS.GRIMDARK_MODE] > 0) {
				addButtonDisabled(0, "Debug", "Nuh-uh. No cheating in Grimdark Mode!");
				addButtonDisabled(1, "Difficulty", "You cannot change difficulty in Grimdark Mode. It's meant to be the hardest game mode ever.");
				debug = false;
				flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
				flags[kFLAGS.GAME_DIFFICULTY] = 3;
			}
			addButton(14, "Back", settingsScreenMain);
		}

		public function toggleDebug():void
		{
			//toggle debug
			if (debug)
				debug = false;
			else
				debug = true;
				
			mainView.showMenuButton(MainView.MENU_DATA);
			settingsScreenGameSettings();
			return;
		}

		public function difficultySelectionMenu():void {
			clearOutput();
			outputText("You can choose a difficulty to set how hard battles will be.\n");
			//outputText("\n<b>Peaceful:</b> Same as Easy but encounters can be avoided or skipped.");
			outputText("\n<b>Easy:</b> -50% damage, can ignore bad-ends.");
			outputText("\n<b>Normal:</b> No stats changes.");
			outputText("\n<b>Hard:</b> +25% HP, +15% damage.");
			outputText("\n<b>Nightmare:</b> +50% HP, +30% damage.");
			outputText("\n<b>Extreme:</b> +100% HP, +50% damage.");
			//outputText("\n<b>Up to Eleven:</b> +150% HP, +75% damage. This is the most cruel difficulty of all.");
			menu();
			//addButton(0, "Peaceful", chooseDifficulty, -2);
			addButton(1, "Easy", chooseDifficulty, -1);
			addButton(2, "Normal", chooseDifficulty, 0);
			addButton(5, "Hard", chooseDifficulty, 1);
			addButton(6, "Nightmare", chooseDifficulty, 2);
			addButton(7, "EXTREME", chooseDifficulty, 3);
			//addButton(8, "Up to Eleven", chooseDifficulty, 4);
			addButton(14, "Back", settingsScreenGameSettings);
		}

		public function chooseDifficulty(difficulty:int = 0):void {
			if (difficulty <= -1) {
				flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = -difficulty;
				flags[kFLAGS.GAME_DIFFICULTY] = 0;
			}
			else {
				flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
				flags[kFLAGS.GAME_DIFFICULTY] = difficulty;
			}
			settingsScreenGameSettings();
		}

		//Not used anymore as there's difficulty settings.
		/*public function toggleEasyModeFlag():void
		{
			//toggle easy mode
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 0)
				flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 1;
			else
				flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
			mainView.showMenuButton(MainView.MENU_DATA);
			settingsScreenGameSettings();
			return;
		}*/

		public function toggleSillyFlag():void
		{
			//toggle silly mode
			if (flags[kFLAGS.SILLY_MODE_ENABLE_FLAG])
				flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = false;
			else
				flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = true;
			settingsScreenGameSettings();
			return;

		}

		public function toggleStandards():void
		{
			//toggle low standards
			if (flags[kFLAGS.LOW_STANDARDS_FOR_ALL])
				flags[kFLAGS.LOW_STANDARDS_FOR_ALL] = false;
			else
				flags[kFLAGS.LOW_STANDARDS_FOR_ALL] = true;
			settingsScreenGameSettings();
			return;
		}

		public function toggleHyperHappy():void
		{
			//toggle hyper happy
			if (flags[kFLAGS.HYPER_HAPPY])
				flags[kFLAGS.HYPER_HAPPY] = false;
			else
				flags[kFLAGS.HYPER_HAPPY] = true;
			settingsScreenGameSettings();
			return;
		}

		public function toggleSFW():void {
			flags[kFLAGS.SFW_MODE] ^= 1;
			settingsScreenGameSettings();
		}

		public function toggleWatersports():void {
			flags[kFLAGS.WATERSPORTS_ENABLED] ^= 1;
			settingsScreenGameSettings();
		}

		public function toggleAutoLevel():void {
			flags[kFLAGS.AUTO_LEVEL] ^= 1;
			settingsScreenGameSettings();	
		}

		public function fetishSubMenu():void {
			menu();
			addButton(0, "Watersports", toggleWatersports, null, null, null, "Toggles watersports scenes. (Scenes related to urine fetish)"); //Enables watersports.
			//addButton(1, "Rimjob", toggleRimjob, null, null, null, "Toggles rimjob scenes."); //Enables rimjob.
			if (player.hasStatusEffect(StatusEffects.WormsOn) || player.hasStatusEffect(StatusEffects.WormsOff)) addButton(2, "Worms", toggleWormsMenu, null, null, null, "Enable or disable worms. This will NOT cure infestation, if you have any.");
			else addButtonDisabled(2, "Worms", "Find the sign depicting the worms in the mountains to unlock this.");
			addButton(4, "Back", settingsScreenGameSettings);
		}

		private function toggleWormsMenu():void {
			clearOutput();
			if (player.hasStatusEffect(StatusEffects.WormsOn)) {
				outputText("You have chosen to encounter worms as you find the mountains");
				if (player.hasStatusEffect(StatusEffects.WormsHalf)) outputText(" albeit at reduced encounter rate");
				outputText(". You can get infested.");
			}
			if (player.hasStatusEffect(StatusEffects.WormsOff)) {
				outputText("You have chosen to avoid worms. You won't be able to get infested.");
			}
			menu();
			addButton(0, "Enable", setWorms, true, false);
			addButton(1, "Enable (Half)", setWorms, true, true);
			addButton(2, "Disable", setWorms, false, false);
			addButton(4, "Back", fetishSubMenu);
		}

		private function setWorms(enabled:Boolean, half:Boolean):void {
			//Clear status effects
			if (player.hasStatusEffect(StatusEffects.WormsOn)) player.removeStatusEffect(StatusEffects.WormsOn);
			if (player.hasStatusEffect(StatusEffects.WormsHalf)) player.removeStatusEffect(StatusEffects.WormsHalf);
			if (player.hasStatusEffect(StatusEffects.WormsOff)) player.removeStatusEffect(StatusEffects.WormsOff);
			//Set status effects
			if (enabled) {
				player.createStatusEffect(StatusEffects.WormsOn, 0, 0, 0, 0);
				if (half) player.createStatusEffect(StatusEffects.WormsHalf, 0, 0, 0, 0);
			}
			else {
				player.createStatusEffect(StatusEffects.WormsOff, 0, 0, 0, 0);
			}
			toggleWormsMenu();
		}

		//Survival Mode
		public function enableSurvivalPrompt():void {
			outputText("Are you sure you want to enable Survival Mode?\n\n", true)
			outputText("You will NOT be able to turn it off! (Unless you reload immediately.)")
			doYesNo(enableSurvivalForReal, settingsScreenGameSettings);
		}

		public function enableSurvivalForReal():void {
			outputText("Survival mode is now enabled.", true)
			player.hunger = 80;
			flags[kFLAGS.HUNGER_ENABLED] = 0.5;
			doNext(settingsScreenGameSettings);
		}

		//Realistic Mode
		public function enableRealisticPrompt():void {
			outputText("Are you sure you want to enable Realistic Mode?\n\n", true)
			outputText("You will NOT be able to turn it off! (Unless you reload immediately.)")
			doYesNo(enableRealisticForReal, settingsScreenGameSettings);
		}

		public function enableRealisticForReal():void {
			outputText("Realistic mode is now enabled.", true)
			flags[kFLAGS.HUNGER_ENABLED] = 1;
			doNext(settingsScreenGameSettings);
		}

		//------------
		// INTERFACE
		//------------
		public function settingsScreenInterfaceSettings():void {
			clearOutput();
			displayHeader("Interface Settings");
			
			/*if (flags[kFLAGS.USE_OLD_INTERFACE] >= 1) outputText("Stats Pane Style: <b>Old</b>\n Old stats panel will be used.");
			else  outputText("Stats Pane Style: <b>New</b>\n New stats panel will be used.");
				
			outputText("\n\n");*/
			
			if (flags[kFLAGS.USE_OLD_FONT] >= 1) outputText("Font: <b>Lucida Sans Typewriter</b>\n");
			else outputText("Font: <b>Palatino Linotype</b>\n");
				
			outputText("\n\n");
			
			if (flags[kFLAGS.IMAGEPACK_OFF] == 0) outputText("Image Pack: <font color=\"#008000\"><b>ON</b></font>\n Image pack is enabled.");
			else outputText("Image Pack: <font color=\"#800000\"><b>OFF</b></font>\n Image pack is disabled.");
				
			outputText("\n\n");
			
			if (flags[kFLAGS.SHOW_SPRITES_FLAG] == 0) {
				outputText("Sprites: <font color=\"#008000\"><b>ON</b></font>\n You like to look at pretty pictures.");
				outputText("\n\n");
				if (flags[kFLAGS.SPRITE_STYLE] == 0)
					outputText("Sprite Type: <b>New</b>\n 16-bit sprites will be used.");
				else
					outputText("Sprite Type: <b>Old</b>\n 8-bit sprites will be used.");
			}
			else {
				outputText("Sprites: <font color=\"#800000\"><b>OFF</b></font>\n There are only words. Nothing else.");
				outputText("\n\n\n");
			}
			
			outputText("\n\n");
			
			if (flags[kFLAGS.USE_12_HOURS] > 0) outputText("Time Format: <b>12 hours</b>\n Time will display in 12 hours format (AM/PM)");
			else outputText("Time Format: <b>24 hours</b>\n Time will display in 24 hours format.");
				
			outputText("\n\n");
			
			if (flags[kFLAGS.USE_METRICS] > 0) outputText("Measurement: <b>Metric</b>\n Height and cock size will be measured in metres and centimetres.");
			else outputText("Measurement: <b>Imperial</b>\n Height and cock size will be measured in feet and inches.");

			outputText("\n\n");

			if (flags[kFLAGS.DISABLE_QUICKLOAD_CONFIRM] == 0) outputText("Confirm Quickload: <font color=\"#008000\"><b>ON</b></font>\n Quickload confirmation dialog is enabled.");
			else outputText("Confirm Quickload: <font color=\"#800000\"><b>OFF</b></font>\n Quickload confirmation dialog is disabled.");

			outputText("\n\n");

			if (flags[kFLAGS.DISABLE_QUICKSAVE_CONFIRM] == 0) outputText("Confirm Quicksave: <font color=\"#008000\"><b>ON</b></font> (Quicksave confirmation dialog is enabled).");
			else outputText("Confirm Quicksave: <font color=\"#800000\"><b>OFF</b></font> (Quicksave confirmation dialog is disabled).");

			menu();
			addButton(0, "Side Bar Font", toggleFont, null, null, null, "Toggle between old and new font for side bar.");
			addButton(1, "Main BG", menuMainBackground, null, null, null, "Choose a background for main game interface.");
			addButton(2, "Text BG", menuTextBackground, null, null, null, "Choose a background for text.");
			addButton(3, "Sprites", menuSpriteSelect, null, null, null, "Turn sprites on/off and change sprite style preference.");

			addButton(5, "Toggle Images", toggleImages, null, null, null, "Enable or disable image pack.");
			addButton(6, "Time Format", toggleTimeFormat, null, null, null, "Toggles between 12-hour and 24-hour format.");
			addButton(7, "Measurements", toggleMeasurements, null, null, null, "Switch between imperial and metric measurements.  \n\nNOTE: Only applies to your appearance screen.");

			addButton(10, "Confirm Load", toggleQuickLoadConfirm, null, null, null, "Toggles the confirmation dialog for Quickload.", "Confirm Quickload");
			addButton(11, "Confirm Save", toggleQuickSaveConfirm, null, null, null, "Toggles the confirmation dialog for Quicksave.", "Confirm Quicksave");
			addButton(14, "Back", settingsScreenMain);
		}

		public function menuMainBackground():void {
			menu();
			addButton(0, "Map (Default)", setMainBackground, 0);
			addButton(1, "Parchment", setMainBackground, 1);
			addButton(2, "Marble", setMainBackground, 2);
			addButton(3, "Obsidian", setMainBackground, 3);
			addButton(4, "Night Mode", setMainBackground, 4, null, null, "Good if you're playing at night to make the game easier on your eyes.");
			if (flags[kFLAGS.GRIMDARK_BACKGROUND_UNLOCKED] > 0) addButton(5, "Grimdark", setMainBackground, 9);
			else addButtonDisabled(5, "Grimdark", "Defeat Lethice once in Grimdark mode to unlock this background!");
			addButton(14, "Back", settingsScreenInterfaceSettings);
		}

		public function menuTextBackground():void {
			menu();
			addButton(0, "Normal", setTextBackground, 0);
			addButton(1, "White", setTextBackground, 1);
			addButton(2, "Tan", setTextBackground, 2);
			
			addButton(14, "Back", settingsScreenInterfaceSettings);
		}

		public function menuSpriteSelect():void {
			menu();
			addButton(0, "Off", toggleSpritesFlag, true, 0, null, "Turn off the sprites completely");
			addButton(1, "Old", toggleSpritesFlag, false, 1, null, "Use the 8-bit sprites from older versions of CoC.");
			addButton(2, "New", toggleSpritesFlag, false, 0, null, "Use the 16-bit sprites in current versions of CoC.");
			
			addButton(14, "Back", settingsScreenInterfaceSettings);
		}

		public function toggleInterface():void {
			flags[kFLAGS.USE_OLD_INTERFACE] ^= 1;
			settingsScreenInterfaceSettings();
		}

		public function toggleFont():void {
			flags[kFLAGS.USE_OLD_FONT] ^= 1;
			settingsScreenInterfaceSettings();
		}

		public function setMainBackground(type:int):void {
			flags[kFLAGS.BACKGROUND_STYLE] = type;
			mainView.background.gotoAndStop(flags[kFLAGS.BACKGROUND_STYLE] + 1);
			mainView.sideBarBG.gotoAndStop(flags[kFLAGS.BACKGROUND_STYLE] + 1);
			settingsScreenInterfaceSettings();
		}

		public function setTextBackground(type:int):void {
			mainView.textBGWhite.visible = false;
			mainView.textBGTan.visible = false;
			if (type == 1) mainView.textBGWhite.visible = true;
			if (type == 2) mainView.textBGTan.visible = true;
			settingsScreenInterfaceSettings();
		}

		public function toggleSpritesFlag(enabled:Boolean, style:int):void
		{
			flags[kFLAGS.SHOW_SPRITES_FLAG] = enabled;
			flags[kFLAGS.SPRITE_STYLE] = style;
			settingsScreenInterfaceSettings();
			return;
		}

		//Needed for keys
		public function cycleBackground():void {
			if (!mainView.textBGWhite.visible)
			{
				mainView.textBGWhite.visible = true;
			}
			else if (!mainView.textBGTan.visible)
			{
				mainView.textBGTan.visible = true;
			}
			else
			{
				mainView.textBGWhite.visible = false;
				mainView.textBGTan.visible = false;
			}		
		}

		public function cycleQuality():void {
			if (mainView.stage.quality == StageQuality.LOW) mainView.stage.quality = StageQuality.MEDIUM;
			else if (mainView.stage.quality == StageQuality.MEDIUM) mainView.stage.quality = StageQuality.HIGH;
			else if (mainView.stage.quality == StageQuality.HIGH) mainView.stage.quality = StageQuality.LOW;
			settingsScreenInterfaceSettings();
		}

		public function toggleImages():void {
			flags[kFLAGS.IMAGEPACK_OFF] ^= 1;
			settingsScreenInterfaceSettings();
		}

		public function toggleTimeFormat():void {
			flags[kFLAGS.USE_12_HOURS] ^= 1;
			settingsScreenInterfaceSettings();
		}

		public function toggleQuickLoadConfirm():void {
			flags[kFLAGS.DISABLE_QUICKLOAD_CONFIRM] ^= 1; // Bitwise XOR. Neat trick to toggle between 0 and 1
			settingsScreenInterfaceSettings();
		}

		public function toggleQuickSaveConfirm():void {
			flags[kFLAGS.DISABLE_QUICKSAVE_CONFIRM] ^= 1; // Bitwise XOR. Neat trick to toggle between 0 and 1
			settingsScreenInterfaceSettings();
		}
		public function toggleMeasurements():void {
			flags[kFLAGS.USE_METRICS] ^= 1;
			settingsScreenInterfaceSettings();
		}

		//------------
		// FONT SETTINGS
		//------------
		public function fontSettingsMenu():void {
			menu();
			addButton(0, "Smaller Font", decFontSize);
			addButton(1, "Larger Font", incFontSize);
			addButton(2, "Reset Size", resetFontSize);
			addButton(4, "Back", settingsScreenMain);
		}

		public function incFontSize():void
		{
			var fmt:TextFormat = mainView.mainText.getTextFormat();
			
			if (fmt.size == null) fmt.size = 20;
			
			fmt.size = (fmt.size as Number) + 1;
			
			if ((fmt.size as Number) > 32) fmt.size = 32;
			
			trace("Font size set to: " + (fmt.size as Number));
			mainView.mainText.setTextFormat(fmt);
			flags[kFLAGS.CUSTOM_FONT_SIZE] = fmt.size;
		}

		public function decFontSize():void
		{
			var fmt:TextFormat = mainView.mainText.getTextFormat();
			
			if (fmt.size == null) fmt.size = 20;
			
			fmt.size = (fmt.size as Number) - 1;
			
			if ((fmt.size as Number) < 14) fmt.size = 14;
			
			trace("Font size set to: " + (fmt.size as Number));
			mainView.mainText.setTextFormat(fmt);
			flags[kFLAGS.CUSTOM_FONT_SIZE] = fmt.size;
		}

		public function resetFontSize():void {
			var fmt:TextFormat = mainView.mainText.getTextFormat();
			if (fmt.size == null) fmt.size = 20;
			fmt.size = 20;
			mainView.mainText.setTextFormat(fmt);
			flags[kFLAGS.CUSTOM_FONT_SIZE] = 0;
		}
		
	}

}