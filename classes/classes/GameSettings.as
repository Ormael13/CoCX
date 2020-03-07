package classes {
import classes.GlobalFlags.*;

import coc.view.MainView;
import coc.view.StatsView;

import flash.display.StageQuality;
import flash.text.TextFormat;

/**
 * ...
 * @author ...
 */
public class GameSettings extends BaseContent {

	public function GameSettings() {}

	public function get charviewEnabled():Boolean {
		return flags[kFLAGS.CHARVIEWER_ENABLED];
	}
	public function settingsScreenMain():void {
        CoC.instance.saves.savePermObject(false);
        mainView.showMenuButton(MainView.MENU_NEW_MAIN);
		mainView.showMenuButton(MainView.MENU_DATA);
		clearOutput();
		displayHeader("Settings");
		outputText("Here, you can adjust the gameplay and interface settings. Setting flags are saved in a special file so you don't have to re-adjust it each time you load a save file.");
		menu();
		addButton(0, "Gameplay", settingsScreenGameSettings);
		addButton(1, "Interface", settingsScreenInterfaceSettings);
		addButton(3, "Font Size", fontSettingsMenu);
		addButton(4, "Controls", displayControls);
		addButton(14, "Back", CoC.instance.mainMenu.mainMenu);
        if (flags[kFLAGS.HARDCORE_MODE] > 0) {
			debug                               = false;
			flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
			flags[kFLAGS.HYPER_HAPPY]           = 0;
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

		switch (flags[kFLAGS.STAT_GAIN_MODE]) {
			case CoC.STAT_GAIN_DAILY:
				outputText("Stat Pts Gain: <font color=\"#000080\"><b>DAILY</b></font>\n No stat points on new level, + (level) stat points per day, don't accumulate\n\n");
				break;
			case CoC.STAT_GAIN_CLASSIC:
				outputText("Stat Pts Gain: <font color=\"#000000\"><b>CLASSIC</b></font>\n +5 stat points on new level\n\n");
				break;
		}

		if (debug)
			outputText("Debug Mode: <font color=\"#008000\"><b>ON</b></font>\n Items will not be consumed by use, fleeing always succeeds, and bad-ends can be ignored.");
		else
			outputText("Debug Mode: <font color=\"#800000\"><b>OFF</b></font>\n Items consumption will occur as normal.");

		outputText("\n\n");
		if (flags[kFLAGS.GAME_DIFFICULTY] <= 0) {
			if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG]) outputText("Difficulty: <font color=\"#008000\"><b>Easy</b></font>\n Combat is easier and bad-ends can be ignored.");
			else outputText("Difficulty: <font color=\"#808000\"><b>Normal</b></font>\n No opponent stats modifiers. You can resume from bad-ends with penalties.");
		}
		else if (flags[kFLAGS.GAME_DIFFICULTY] == 1) {
			outputText("Difficulty: <b><font color=\"#800000\">Hard</font></b>\n Opponent has 1,5x more HP/Lust/Wrath/Fatigue/Mana/Soulforce, does 15% more damage and giving ~10% more EXP. Bad-ends can ruin your game.");
		}
		else if (flags[kFLAGS.GAME_DIFFICULTY] == 2) {
			outputText("Difficulty: <b><font color=\"#C00000\">Nightmare</font></b>\n Opponent has 2x more HP/Lust/Wrath/Fatigue/Mana/Soulforce, does 30% more damage and giving ~20% more EXP.");
		}
		else if (flags[kFLAGS.GAME_DIFFICULTY] == 3) {
			outputText("Difficulty: <b><font color=\"#FF0000\">Extreme</font></b>\n Opponent has 3x more HP/Lust/Wrath/Fatigue/Mana/Soulforce, does more 50% damage and giving ~30% more EXP.");
		}
		else if (flags[kFLAGS.GAME_DIFFICULTY] >= 4) {
			outputText("Difficulty: <b><font color=\"#FF0000\">Xianxia</font></b>\n Opponent has 5x more HP/Lust/Wrath/Fatigue/Mana/Soulforce, does more 100% damage and giving ~40% more EXP.");
		}

		outputText("\n\n");
		if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 0) {
			outputText("Secondary Stats Modifier: <font color=\"#808000\"><b>Normal</b></font>\n No opponent secondary stats modifiers.");
		}
		else if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 1) {
			outputText("Secondary Stats Modifier: <b><font color=\"#800000\">Hard</font></b>\n Opponent has 5x more HP/Lust/Wrath/Fatigue/Mana/Soulforce.");
		}
		else if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 2) {
			outputText("Secondary Stats Modifier: <b><font color=\"#C00000\">Nightmare</font></b>\n Opponent has 10x more HP/Lust/Wrath/Fatigue/Mana/Soulforce.");
		}
		else if (flags[kFLAGS.SECONDARY_STATS_SCALING] == 3) {
			outputText("Secondary Stats Modifier: <b><font color=\"#FF0000\">Extreme</font></b>\n Opponent has 25x more HP/Lust/Wrath/Fatigue/Mana/Soulforce.");
		}
		else if (flags[kFLAGS.SECONDARY_STATS_SCALING] >= 4) {
			outputText("Secondary Stats Modifier: <b><font color=\"#FF0000\">Xianxia</font></b>\n Opponent has 100x more HP/Lust/Wrath/Fatigue/Mana/Soulforce.");
		}

		/*if(flags[kFLAGS.EASY_MODE_ENABLE_FLAG])
		 outputText("Easy Mode: <font color=\"#008000\"><b>ON</b></font>\n Bad-ends can be ignored and combat is easier.");
		 else
		 outputText("Easy Mode: <font color=\"#800000\"><b>OFF</b></font>\n Bad-ends can ruin your game and combat is challenging.");

		 outputText("\n\n");*/
		outputText("\n\n");
		if (flags[kFLAGS.SILLY_MODE_ENABLE_FLAG])
			outputText("Silly Mode: <font color=\"#008000\"><b>ON</b></font>\n Crazy, nonsensical, and possibly hilarious things may occur.");
		else
			outputText("Silly Mode: <font color=\"#800000\"><b>OFF</b></font>\n You're an incorrigable stick-in-the-mud with no sense of humor.");

		outputText("\n\n");
		outputText("<b>The following flags are not fully implemented yet (e.g. they don't apply in <i>all</i> cases where they could be relevant).</b>\n");
		outputText("Additional note: You <b>must</b> be <i>in a game session</i> (e.g. load your save, hit \"Main Menu\", change the flag settings, and then hit \"Resume\") to change these flags. They're saved into the saveGame file, so if you load a save, it will clear them to the state in that save.");
		outputText("\n\n");

		if (flags[kFLAGS.LOW_STANDARDS_FOR_ALL]) {
			outputText("Low standards Mode: <font color=\"#008000\"><b>ON</b></font>\n NPCs ignore body type preferences.");
			outputText("\n (Not gender preferences though. You still need the right hole.)");
		}
		else
			outputText("Low standards Mode: <font color=\"#800000\"><b>OFF</b></font>\n NPCs have body-type preferences.");

		outputText("\n\n");

		if (flags[kFLAGS.HYPER_HAPPY]) {
			outputText("Hyper Happy Mode: <font color=\"#008000\"><b>ON</b></font>\n Only reducto and humus shrink endowments.");
			outputText("\n Incubus draft doesn't affect breasts, and succubi milk doesn't affect cocks.")
		}
		else
			outputText("Hyper Happy Mode: <font color=\"#800000\"><b>OFF</b></font>\n Male enhancement potions shrink female endowments, and vice versa.");

		outputText("\n\n");

		if (flags[kFLAGS.SFW_MODE] >= 1) {
			outputText("SFW Mode: <font color=\"#008000\"><b>ON</b></font>\n Sex scenes are disabled and adult materials are hidden.");
		}
		else
			outputText("SFW Mode: <font color=\"#800000\"><b>OFF</b></font>\n Sex scenes are enabled.");

		outputText("\n\n");

		if (flags[kFLAGS.NO_GORE_MODE] >= 1) {
			outputText("No Blood Mode: <font color=\"#008000\"><b>ON</b></font>\n Excesive Bloody or Gore scenes variants are disabled.");
		}
		else
			outputText("No Blood Mode: <font color=\"#800000\"><b>OFF</b></font>\n Excesive Bloody or Gore scenes variants are enabled.");

		outputText("\n\n");

		if (flags[kFLAGS.STRENGTH_SCALLING] >= 1) {
			outputText("Strength Scaling: <font color=\"#008000\"><b>New</b></font>\n Values are less randomn and a bit higher on averange than in old scalling.");
		}
		else
			outputText("Strength Scaling: <font color=\"#800000\"><b>Old</b></font>\n Values are more randomn and a bit lower on averange than in new scalling.");

		outputText("\n\n");

		if (flags[kFLAGS.SPEED_SCALLING] >= 1) {
			outputText("Speed Scaling: <font color=\"#008000\"><b>New</b></font>\n Values are less randomn and a bit higher on averange than in old scalling.");
		}
		else
			outputText("Speed Scaling: <font color=\"#800000\"><b>Old</b></font>\n Values are more randomn and a bit lower on averange than in new scalling.");

		outputText("\n\n");

		if (flags[kFLAGS.WISDOM_SCALLING] >= 1) {
			outputText("Wisdom Scaling: <font color=\"#008000\"><b>New</b></font>\n Values are less randomn and a bit higher on averange than in old scalling.");
		}
		else
			outputText("Wisdom Scaling: <font color=\"#800000\"><b>Old</b></font>\n Values are more randomn and a bit lower on averange than in new scalling.");

		outputText("\n\n");

		if (flags[kFLAGS.INTELLIGENCE_SCALLING] >= 1) {
			outputText("Intelligence Scaling: <font color=\"#008000\"><b>New</b></font>\n Values are less randomn and a bit higher on averange than in old scalling.");
		}
		else
			outputText("Intelligence Scaling: <font color=\"#800000\"><b>Old</b></font>\n Values are more randomn and a bit lower on averange than in new scalling.");

		outputText("\n\n");

		if (flags[kFLAGS.MELEE_DAMAGE_OVERHAUL] >= 1) {
			outputText("Damage Overhaul: <font color=\"#008000\"><b>On</b></font>\n Damage uses new calculation system.");
		}
		else
			outputText("Damage Overhaul: <font color=\"#800000\"><b>Off</b></font>\n Damage uses old calculation system.");

		outputText("\n\n");

		if (flags[kFLAGS.SPELLS_COOLDOWNS] >= 1) {
			outputText("Spells Cooldowns: <font color=\"#008000\"><b>Off</b></font>\n Damage dealing spells not have cooldowns and they keep their default power.");
		}
		else
			outputText("Spells Cooldowns: <font color=\"#800000\"><b>On</b></font>\n Damage dealing spells have cooldowns and they dealing more damage than in default cooldownless variant.");

		outputText("\n\n");

		if (flags[kFLAGS.ITS_EVERY_DAY]) {
			outputText("Eternal Holiday Mode: <font color=\"#008000\"><b>ON</b></font>\n All holiday events like Eastern/X-mas and etc. would happen at any day of the year.");
		}
		else
			outputText("Eternal Holiday Mode: <font color=\"#800000\"><b>OFF</b></font>\n All holiday events happen only when it's respective holiday time.");

		outputText("\n\n");

		if (flags[kFLAGS.WATERSPORTS_ENABLED] >= 1 && flags[kFLAGS.SFW_MODE] <= 0) {
			outputText("Watersports: <font color=\"#008000\"><b>Enabled</b></font>\n Watersports scenes are enabled. (You kinky person)");
		}
		else
			outputText("Watersports: <font color=\"#800000\"><b>Disabled</b></font>\n Watersports scenes are disabled.");

		outputText("\n\n");

		if (flags[kFLAGS.AUTO_LEVEL] >= 1) {
			outputText("Automatic Leveling: <font color=\"#008000\"><b>ON</b></font>\n Leveling up is done automatically once you accumulate enough experience.");
		}
		else
			outputText("Automatic Leveling: <font color=\"#800000\"><b>OFF</b></font>\n Leveling up is done manually.");

		menu();
		addButton(0, "Toggle Debug", toggleDebug).hint("Turn on debug mode. Debug mode is intended for testing purposes but can be thought of as a cheat mode.  Items are infinite and combat is easy to escape from.  Weirdness and bugs are to be expected.");
		if (player) addButton(1, "Difficulty", difficultySelectionMenu).hint("Adjust the game difficulty to make it easier or harder.");
		//addButton(1, "Easy Mode", toggleEasyModeFlag).hint("Toggles easy mode.  Enemy damage is halved and bad-ends can be ignored.");
		addButton(2, "Silly Toggle", toggleSillyFlag).hint("Toggles silly mode. Funny, crazy and nonsensical scenes may occur if enabled.");
		addButton(3, "Low Standards", toggleStandards);
		addButton(4, "Hyper Happy", toggleHyperHappy);

		addButton(5, "SFW Toggle", toggleSFW).hint("Toggles SFW Mode. If enabled, sex scenes are hidden and all adult materials are censored. \n\nCurrently under development, only disables most sex scenes. Soon, it'll disable rape scenes."); //Softcore Mode
		addButton(6, "Auto level", toggleAutoLevel).hint("Toggles automatic leveling when you accumulate sufficient experience.");
		addButton(7, "Stat Pts", toggleStatGain).hint("Toggles stat gain mode");
		if (player) addButton(8, "Enable Surv", enableSurvivalPrompt).hint("Enable Survival mode. This will enable hunger. \n\n<font color=\"#080000\">Note: This is permanent and cannot be turned off!</font>");
		if (player) addButton(9, "Enable Real", enableRealisticPrompt).hint("Enable Realistic mode. This will make the game a bit realistic. \n\n<font color=\"#080000\">Note: This is permanent and cannot be turned off! Do not turn this on if you have hyper endowments.</font>");
		
		addButton(11, "Fetishes", fetishSubMenu).hint("Toggle some of the weird fetishes such as watersports and worms.");
		addButton(12, "Other Settings", settingsScreenGameSettings2);

		if (flags[kFLAGS.HUNGER_ENABLED] >= 0.5) {
			removeButton(8);
		}
		if (flags[kFLAGS.HUNGER_ENABLED] >= 1) {
			removeButton(9);
		}
		if (flags[kFLAGS.HARDCORE_MODE] > 0) {
			removeButton(0);
			removeButton(1);
			removeButton(3);
			removeButton(4);
			debug                               = false;
			flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
			flags[kFLAGS.HYPER_HAPPY]           = 0;
			flags[kFLAGS.LOW_STANDARDS_FOR_ALL] = 0;
		}
		addButton(14, "Back", settingsScreenMain);
	}
	public function settingsScreenGameSettings2():void {
		menu();
		addButton(0, "Eternal Holiday", toggleEternalHoliday).hint("Toggles eternal holiday mode. All holiday events like Eastern/X-mas and etc. would happen at any day of the year.");
		addButton(1, "No Blood Toggle", toggleNOGORE).hint("Toggles No Blood Mode. If enabled, scenes could have more grungesome/bloody variants showed. Not for the weak of heart players.");
		addButton(3, "Wis scalling", toggleWisScaling).hint("Toggles Wisdom scalling for all attacks using it. If enabled, wisdom scaling would be less randomn with big generaly a bit higher values on averange.");
		addButton(4, "Int scalling", toggleIntScaling).hint("Toggles Intelligance scalling for all attacks using it. If enabled, intelligence scaling would be less randomn with big generaly a bit higher values on averange.");
		addButton(5, "Damage Overhaul", toggleDamageOverhaul).hint("Toggles Damage Overhaul. If enabled, melle and range attacks would deal randomn damage between 15% to 115%. Int and Wis could increase both values.");
		addButton(6, "Spells Cooldowns", toggleSpellsCooldowns).hint("Toggles Spells cooldowns. If enabled, spells would have cooldowns and they will be stronger.");
		addButton(8, "Str scalling", toggleStrScaling).hint("Toggles Strength scalling for all attacks using it. If enabled, strength scaling would be less randomn with big generaly a bit higher values on averange.");
		addButton(9, "Spe scalling", toggleSpeScaling).hint("Toggles Speed scalling for all attacks using it. If enabled, speed scaling would be less randomn with big generaly a bit higher values on averange.");
		addButton(10, "Sec.Mon.Stat", difficultySelectionMenu2).hint("Adjust monsters secondary stats multi to make game easier or harder.");
		addButton(14, "Back", settingsScreenGameSettings);
	}

	public function toggleDebug():void {
		//toggle debug
		debug = !debug;

		mainView.showMenuButton(MainView.MENU_DATA);
		settingsScreenGameSettings();

	}

	/* [INTERMOD: Revamp]
	 public function togglePrison():void
	 {
	 //toggle prison
	 if (flags[kFLAGS.PRISON_ENABLED])
	 flags[kFLAGS.PRISON_ENABLED] = false;
	 else
	 flags[kFLAGS.PRISON_ENABLED] = true;

	 mainView.showMenuButton(MainView.MENU_DATA);
	 settingsScreenGameSettings();
	 return;
	 }
	 */

	public function difficultySelectionMenu():void {
		clearOutput();
		outputText("You can choose a difficulty to set how hard battles will be.\n");
		outputText("\n<b>Easy:</b> -50% damage, can ignore bad-ends.");
		outputText("\n<b>Normal:</b> No stats changes.");
		outputText("\n<b>Hard:</b> 1,5x more HP/Lust/Wrath/Fatigue/Mana/Soulforce, +15% damage, ~10% more EXP.");
		outputText("\n<b>Nightmare:</b> 2x more HP/Lust/Wrath/Fatigue/Mana/Soulforce, +30% damage, ~20% more EXP.");
		outputText("\n<b>Extreme:</b> 3x more HP/Lust/Wrath/Fatigue/Mana/Soulforce, +50% damage, ~30% more EXP.");
		outputText("\n<b>Xianxia:</b> 5x more HP/Lust/Wrath/Fatigue/Mana/Soulforce, +100% damage, ~40% more EXP.");
		menu();
		addButton(0, "Easy", chooseDifficulty, -1);
		addButton(1, "Normal", chooseDifficulty, 0);
		addButton(2, "Hard", chooseDifficulty, 1);
		addButton(3, "Nightmare", chooseDifficulty, 2);
		addButton(5, "EXTREME", chooseDifficulty, 3);
		addButton(6, "XIANXIA", chooseDifficulty, 4);
		addButton(14, "Back", settingsScreenGameSettings);
	}

	public function chooseDifficulty(difficulty:int = 0):void {
		if (difficulty <= -1) {
			flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 1;
			flags[kFLAGS.GAME_DIFFICULTY]       = 0;
		}
		else {
			flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
			flags[kFLAGS.GAME_DIFFICULTY]       = difficulty;
		}
		settingsScreenGameSettings();
	}
	
	public function difficultySelectionMenu2():void {
		clearOutput();
		outputText("You can choose a difficulty to set how hard battles will be.\n");
		outputText("\n<b>Normal:</b> No stats changes.");
		outputText("\n<b>Hard:</b> 2x multi for secondary stats for monsters.");
		outputText("\n<b>Nightmare:</b> 5x multi for secondary stats for monsters.");
		outputText("\n<b>Extreme:</b> 10x multi for secondary stats for monsters.");
		outputText("\n<b>Xianxia:</b> 25x multi for secondary stats for monsters.");
		menu();
		addButton(0, "Normal", chooseDifficulty2, 0);
		addButton(1, "Hard", chooseDifficulty2, 1);
		addButton(2, "Nightmare", chooseDifficulty2, 2);
		addButton(3, "EXTREME", chooseDifficulty2, 3);
		addButton(4, "XIANXIA", chooseDifficulty2, 4);
		addButton(14, "Back", settingsScreenGameSettings2);
	}

	public function chooseDifficulty2(difficulty:int = 0):void {
		flags[kFLAGS.SECONDARY_STATS_SCALING] = difficulty;
		settingsScreenGameSettings2();
	}

//Not used anymore as there's difficulty settings.
	/*public function toggleEasyModeFlag():void
	 {
	 //toggle easy mode
	 if(flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 0)
	 flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 1;
	 else
	 flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
	 mainView.showMenuButton(MainView.MENU_DATA);
	 settingsScreenGameSettings();
	 return;
	 }*/

	public function toggleSillyFlag():void {
		//toggle silly mode
		flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = !flags[kFLAGS.SILLY_MODE_ENABLE_FLAG];
		settingsScreenGameSettings();
	}

	public function toggleStandards():void {
		//toggle low standards
		flags[kFLAGS.LOW_STANDARDS_FOR_ALL] = !flags[kFLAGS.LOW_STANDARDS_FOR_ALL];
		settingsScreenGameSettings();
	}

	public function toggleHyperHappy():void {
		//toggle hyper happy
		flags[kFLAGS.HYPER_HAPPY] = !flags[kFLAGS.HYPER_HAPPY];
		settingsScreenGameSettings();
	}

	public function toggleEternalHoliday():void {
		//toggle eternal holiday
		flags[kFLAGS.ITS_EVERY_DAY] = !flags[kFLAGS.ITS_EVERY_DAY];
		settingsScreenGameSettings2();
	}

	public function toggleSFW():void {
		if (flags[kFLAGS.SFW_MODE] < 1) flags[kFLAGS.SFW_MODE] = 1;
		else flags[kFLAGS.SFW_MODE] = 0;
		settingsScreenGameSettings();
	}

	public function toggleNOGORE():void {
		if (flags[kFLAGS.NO_GORE_MODE] < 1) flags[kFLAGS.NO_GORE_MODE] = 1;
		else flags[kFLAGS.NO_GORE_MODE] = 0;
		settingsScreenGameSettings2();
	}

	public function toggleStrScaling():void {
		if (flags[kFLAGS.STRENGTH_SCALLING] < 1) flags[kFLAGS.STRENGTH_SCALLING] = 1;
		else flags[kFLAGS.STRENGTH_SCALLING] = 0;
		settingsScreenGameSettings2();
	}

	public function toggleSpeScaling():void {
		if (flags[kFLAGS.SPEED_SCALLING] < 1) flags[kFLAGS.SPEED_SCALLING] = 1;
		else flags[kFLAGS.SPEED_SCALLING] = 0;
		settingsScreenGameSettings2();
	}

	public function toggleWisScaling():void {
		if (flags[kFLAGS.WISDOM_SCALLING] < 1) flags[kFLAGS.WISDOM_SCALLING] = 1;
		else flags[kFLAGS.WISDOM_SCALLING] = 0;
		settingsScreenGameSettings2();
	}

	public function toggleIntScaling():void {
		if (flags[kFLAGS.INTELLIGENCE_SCALLING] < 1) flags[kFLAGS.INTELLIGENCE_SCALLING] = 1;
		else flags[kFLAGS.INTELLIGENCE_SCALLING] = 0;
		settingsScreenGameSettings2();
	}

	public function toggleDamageOverhaul():void {
		if (flags[kFLAGS.MELEE_DAMAGE_OVERHAUL] < 1) flags[kFLAGS.MELEE_DAMAGE_OVERHAUL] = 1;
		else flags[kFLAGS.MELEE_DAMAGE_OVERHAUL] = 0;
		settingsScreenGameSettings2();
	}

	public function toggleSpellsCooldowns():void {
		if (flags[kFLAGS.SPELLS_COOLDOWNS] < 1) flags[kFLAGS.SPELLS_COOLDOWNS] = 1;
		else flags[kFLAGS.SPELLS_COOLDOWNS] = 0;
		settingsScreenGameSettings2();
	}

	public function toggleWatersports():void {
		if (flags[kFLAGS.WATERSPORTS_ENABLED] < 1) flags[kFLAGS.WATERSPORTS_ENABLED] = 1;
		else flags[kFLAGS.WATERSPORTS_ENABLED] = 0;
		settingsScreenGameSettings();
	}

	public function toggleAutoLevel():void {
		if (flags[kFLAGS.AUTO_LEVEL] < 1) flags[kFLAGS.AUTO_LEVEL] = 1;
		else flags[kFLAGS.AUTO_LEVEL] = 0;
		settingsScreenGameSettings();
	}

	public function toggleStatGain():void {
		if (flags[kFLAGS.STAT_GAIN_MODE] == CoC.STAT_GAIN_CLASSIC) flags[kFLAGS.STAT_GAIN_MODE] = CoC.STAT_GAIN_DAILY;
		else flags[kFLAGS.STAT_GAIN_MODE] = CoC.STAT_GAIN_CLASSIC;
		settingsScreenGameSettings();
	}

	public function fetishSubMenu():void {
		menu();
		addButton(0, "Watersports", toggleWatersports).hint("Toggles watersports scenes. (Scenes related to urine fetish)"); //Enables watersports.
		if (player.hasStatusEffect(StatusEffects.WormsOn) || player.hasStatusEffect(StatusEffects.WormsOff)) addButton(1, "Worms", toggleWormsMenu).hint("Enable or disable worms. This will NOT cure infestation, if you have any.");
		else addButtonDisabled(1, "Worms", "Find the sign depicting the worms in the mountains to unlock this.");
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
		clearOutput();
		outputText("Are you sure you want to enable Survival Mode?\n\n");
		outputText("You will NOT be able to turn it off! (Unless you reload immediately.)");
		doYesNo(enableSurvivalForReal, settingsScreenGameSettings);
	}

	public function enableSurvivalForReal():void {
		clearOutput();
		outputText("Survival mode is now enabled.");
		player.hunger                = 80;
		flags[kFLAGS.HUNGER_ENABLED] = 0.5;
		doNext(settingsScreenGameSettings);
	}

//Realistic Mode
	public function enableRealisticPrompt():void {
		clearOutput();
		outputText("Are you sure you want to enable Realistic Mode?\n\n");
		outputText("You will NOT be able to turn it off! (Unless you reload immediately.)");
		doYesNo(enableRealisticForReal, settingsScreenGameSettings);
	}

	public function enableRealisticForReal():void {
		clearOutput();
		outputText("Realistic mode is now enabled.");
		flags[kFLAGS.HUNGER_ENABLED] = 1;
		doNext(settingsScreenGameSettings);
	}


	//------------
	// INTERFACE
	//------------
	public function settingsScreenInterfaceSettings():void {
		clearOutput();
		displayHeader("Interface Settings");

		/*if (flags[kFLAGS.USE_OLD_INTERFACE] >= 1)
		 {
		 outputText("Stats Pane Style: <b>Old</b>\n Old stats panel will be used.");
		 }
		 else
		 outputText("Stats Pane Style: <b>New</b>\n New stats panel will be used.");

		 outputText("\n\n");*/

		if (flags[kFLAGS.USE_OLD_FONT] >= 1) {
			outputText("Font: <b>Lucida Sans Typewriter</b>\n");
		}
		else
			outputText("Font: <b>Georgia</b>\n");

		outputText("\n\n");

		outputText("Char Viewer: ");
		if (flags[kFLAGS.CHARVIEWER_ENABLED] == 1) outputText("<font color=\"#008000\"><b>ON</b></font>\n Player visualiser is available under \\[Appearance\\].");
		else outputText("<font color=\"#800000\"><b>OFF</b></font>\n Player visualiser is disabled.");
		outputText("\nChar View Style: ");
		switch (flags[kFLAGS.CHARVIEW_STYLE]) {
			case 0:
				outputText("<font color=\"#008000\"><b>NEW</b></font>\n Viewer is inline with text");
				break;
			case 1:
				outputText("<font color=\"#800000\"><b>OLD</b></font>\n Viewer is shown at left");
				break;
			case 2:
				outputText("<font color=\"#000080\"><b>ALWAYS</b></font>\n Viewer is shown at left, always visible");
				break;
		}
		outputText("\n\n");

		if (flags[kFLAGS.IMAGEPACK_OFF] == 0) {
			outputText("Image Pack: <font color=\"#008000\"><b>ON</b></font>\n Image pack is enabled.");
		}
		else
			outputText("Image Pack: <font color=\"#800000\"><b>OFF</b></font>\n Image pack is disabled.");

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

		if (flags[kFLAGS.USE_12_HOURS] > 0)
			outputText("Time Format: <b>12 hours</b>\n Time will display in 12 hours format (AM/PM)");
		else
			outputText("Time Format: <b>24 hours</b>\n Time will display in 24 hours format.");

		outputText("\n\n");

		if (flags[kFLAGS.USE_METRICS] > 0)
			outputText("Measurement: <b>Metric</b>\n Height and cock size will be measured in metres and centimetres.");
		else
			outputText("Measurement: <b>Imperial</b>\n Height and cock size will be measured in feet and inches.");

		menu();
		addButton(0, "Side Bar Font", toggleFont).hint("Toggle between old and new font for side bar.");
		addButton(1, "Main BG", menuMainBackground).hint("Choose a background for main game interface.");
		addButton(2, "Text BG", menuTextBackground).hint("Choose a background for text.");
		addButton(3, "Sprites", menuSpriteSelect).hint("Turn sprites on/off and change sprite style preference.");

		addButton(5, "Toggle Images", toggleImages).hint("Enable or disable image pack.");
		addButton(6, "Time Format", toggleTimeFormat).hint("Toggles between 12-hour and 24-hour format.");
		addButton(7, "Measurements", toggleMeasurements).hint("Switch between imperial and metric measurements.  \n\nNOTE: Only applies to your appearance screen.");
		addButton(8, "Toggle CharView", toggleCharViewer).hint("Turn PC visualizer on/off.");
		addButton(9, "Charview Style",toggleCharViewerStyle).hint("Change between in text and sidebar display");
		addButton(14, "Back", settingsScreenMain);
	}
	public function menuMainBackground():void {
		menu();
		addButton(0, "Map (Default)", setMainBackground, 0);
		addButton(1, "Parchment", setMainBackground, 1);
		addButton(2, "Marble", setMainBackground, 2);
		addButton(3, "Obsidian", setMainBackground, 3);
		addButton(4, "Black", setMainBackground, 4);

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

	public function toggleCharViewer(flag:int = kFLAGS.CHARVIEWER_ENABLED):void {
		if (flags[flag] < 1) {
			flags[flag] = 1;
			mainView.charView.reload();
		} else {
			flags[flag] = 0;
		}
		settingsScreenInterfaceSettings();
	}
	public function toggleCharViewerStyle():void {
		flags[kFLAGS.CHARVIEW_STYLE] = (flags[kFLAGS.CHARVIEW_STYLE]+1)%3;
		settingsScreenInterfaceSettings();
	}

	public function toggleInterface():void {
		if (flags[kFLAGS.USE_OLD_INTERFACE] < 1) flags[kFLAGS.USE_OLD_INTERFACE] = 1;
		else flags[kFLAGS.USE_OLD_INTERFACE] = 0;
		settingsScreenInterfaceSettings();
	}

	public function toggleFont():void {
		if (flags[kFLAGS.USE_OLD_FONT] < 1) flags[kFLAGS.USE_OLD_FONT] = 1;
		else flags[kFLAGS.USE_OLD_FONT] = 0;
		settingsScreenInterfaceSettings();
	}

		public function setMainBackground(type:int):void {
			flags[kFLAGS.BACKGROUND_STYLE]     = type;
			mainViewManager.setTheme();
			settingsScreenInterfaceSettings();
		}

	public function setTextBackground(type:int):void {
		mainView.textBGWhite.visible = false;
		mainView.textBGTan.visible   = false;
		if (type == 1) mainView.textBGWhite.visible = true;
		if (type == 2) mainView.textBGTan.visible = true;
		settingsScreenInterfaceSettings();
	}

	public function toggleSpritesFlag(enabled:Boolean, style:int):void {
		flags[kFLAGS.SHOW_SPRITES_FLAG] = enabled;
		flags[kFLAGS.SPRITE_STYLE]      = style;
		settingsScreenInterfaceSettings();

	}


	//Needed for keys
	public function cycleBackground():void {
		if (!mainView.textBGWhite.visible) {
			mainView.textBGWhite.visible = true;
		}
		else if (!mainView.textBGTan.visible) {
			mainView.textBGTan.visible = true;
		}
		else {
			mainView.textBGWhite.visible = false;
			mainView.textBGTan.visible   = false;
		}
	}

	public function cycleQuality():void {
        if (CoC.instance.stage.quality == StageQuality.LOW) CoC.instance.stage.quality = StageQuality.MEDIUM;
        else if (CoC.instance.stage.quality == StageQuality.MEDIUM) CoC.instance.stage.quality = StageQuality.HIGH;
        else if (CoC.instance.stage.quality == StageQuality.HIGH) CoC.instance.stage.quality = StageQuality.LOW;
        settingsScreenInterfaceSettings();
	}

	public function toggleImages():void {
		if (flags[kFLAGS.IMAGEPACK_OFF] < 1) flags[kFLAGS.IMAGEPACK_OFF] = 1;
		else flags[kFLAGS.IMAGEPACK_OFF] = 0;
		settingsScreenInterfaceSettings();
	}

	public function toggleTimeFormat():void {
		if (flags[kFLAGS.USE_12_HOURS] < 1) flags[kFLAGS.USE_12_HOURS] = 1;
		else flags[kFLAGS.USE_12_HOURS] = 0;
		settingsScreenInterfaceSettings();
	}

	/* [INTERMOD: Revamp
	 public function toggleQuickLoadConfirm():void {
	 flags[kFLAGS.DISABLE_QUICKLOAD_CONFIRM] ^= 1; // Bitwise XOR. Neat trick to toggle between 0 and 1
	 settingsScreenInterfaceSettings();
	 }

	 public function toggleQuickSaveConfirm():void {
	 flags[kFLAGS.DISABLE_QUICKSAVE_CONFIRM] ^= 1; // Bitwise XOR. Neat trick to toggle between 0 and 1
	 settingsScreenInterfaceSettings();
	 }
	 */
	public function toggleMeasurements():void {
		if (flags[kFLAGS.USE_METRICS] < 1) flags[kFLAGS.USE_METRICS] = 1;
		else flags[kFLAGS.USE_METRICS] = 0;
		settingsScreenInterfaceSettings();
	}

	//------------
	// FONT SETTINGS
	//------------
	public function fontSettingsMenu():void {
		menu();
		simpleChoices("Smaller Font", decFontSize,
				"Larger Font", incFontSize,
				"Reset Size", resetFontSize,
				"", null,
				"Back", settingsScreenMain);
	}

	public function incFontSize():void {
		var fmt:TextFormat = mainView.mainText.getTextFormat();

		if (fmt.size == null) fmt.size = 20;

		fmt.size = (fmt.size as Number) + 1;

		if ((fmt.size as Number) > 32) fmt.size = 32;

		trace("Font size set to: " + (fmt.size as Number));
		mainView.mainText.setTextFormat(fmt);
		flags[kFLAGS.CUSTOM_FONT_SIZE] = fmt.size;
	}

	public function decFontSize():void {
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

    private function displayControls():void
    {
        mainView.hideAllMenuButtons();
        CoC.instance.inputManager.DisplayBindingPane();
        EngineCore.menu();
        EngineCore.addButton(0, "Reset Ctrls", resetControls);
        EngineCore.addButton(1, "Clear Ctrls", clearControls);
        EngineCore.addButton(4, "Back", hideControls);
    }

    private function hideControls():void
    {
        CoC.instance.inputManager.HideBindingPane();
        CoC.instance.gameSettings.settingsScreenMain();
    }

    private function resetControls():void
    {
        CoC.instance.inputManager.HideBindingPane();
        EngineCore.clearOutput();
        EngineCore.outputText("Are you sure you want to reset all of the currently bound controls to their defaults?");

        EngineCore.doYesNo(resetControlsYes, displayControls);
    }

    private function resetControlsYes():void
    {
        CoC.instance.inputManager.ResetToDefaults();
        EngineCore.clearOutput();
        EngineCore.outputText("Controls have been reset to defaults!\n\n");

        EngineCore.doNext(displayControls);
    }

    private function clearControls():void
    {
        CoC.instance.inputManager.HideBindingPane();
        EngineCore.clearOutput();
        EngineCore.outputText("Are you sure you want to clear all of the currently bound controls?");

        EngineCore.doYesNo(clearControlsYes, displayControls);
    }

    private function clearControlsYes():void
    {
        CoC.instance.inputManager.ClearAllBinds();
        EngineCore.clearOutput();
        EngineCore.outputText("Controls have been cleared!");

        EngineCore.doNext(displayControls);
    }
}

}
