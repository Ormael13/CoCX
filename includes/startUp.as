import classes.Scenes.Achievements;
import coc.view.CoCButton;
import coc.view.MainView;
import flash.display.Stage;
import flash.display.StageQuality;
import flash.text.TextField;
import flash.text.TextFormat;



//MainMenu - kicks player out to the main menu
public function mainMenu(e:MouseEvent = undefined):void 
{
	stage.focus = (mainView as MainView).mainText;
	
	if(CONFIG::debug)
	{
		CoC_Settings.debugBuild = true;
	}
	else
	{
		CoC_Settings.debugBuild = false;
	}

	if (mainView.aCb.parent != null)
	{
		mainView.removeChild(mainView.aCb);
	}
	mainViewHack.registerShiftKeys();
	mainView.eventTestInput.x = -10207.5;
	mainView.eventTestInput.y = -1055.1;
	hideStats();
	mainViewHack.startUpButtons();
	kGAMECLASS.saves.loadPermObject();
	mainViewHack.setDarkTheme();
	//Reset newgame buttons
	mainView.setMenuButton( MainView.MENU_NEW_MAIN, "New Game", charCreation.newGameFromScratch );
	mainView.hideAllMenuButtons();
	mainView.showMenuButton( MainView.MENU_NEW_MAIN );
	mainView.showMenuButton( MainView.MENU_DATA );
	
	mainView.newGameButton.toolTipText = "Start a new game.";
	mainView.dataButton.toolTipHeader = "New Game";
	mainView.dataButton.toolTipText = "Save or load your files.";
	mainView.dataButton.toolTipHeader = "Data";
	mainView.statsButton.toolTipText = "View your stats.";
	mainView.statsButton.toolTipHeader = "Stats";
	mainView.perksButton.toolTipText = "View your perks.";
	mainView.perksButton.toolTipHeader = "Perks";
	mainView.appearanceButton.toolTipText = "View your appearance.";
	mainView.appearanceButton.toolTipHeader = "Appearance";
	//Sets game state to 3, used for determining back functionality of save/load menu.
	gameState = 3;
	clearOutput();
	outputText(images.showImage("coc-logo"), false);
	outputText("<b>Corruption of Champions (" + version + ")</b>", false);
	
	if (CoC_Settings.debugBuild)
		outputText(" Debug Build");
	else
		outputText(" Release Build");
	if (CONFIG::AIR)
		outputText(" (AIR)");
	//doThatTestingThang();

	startupScreenBody();

	var resume:Function = null;
	if (player.str > 0)  //we're in a game, allow resume.
		resume = playerMenu;

	var achievements:Achievements = new Achievements();

	// I really wanted to only have the "imageCreditsScreen" button if images were found, but it turns out
	// that if you check if any images were found immediately when this screen is shown, you get 0
	// since the images haven't loaded yet.
	// Therefore, the imageCreditScreen will just have to say "No image pack" if you don't have any images

	menu();
	addButton(0, "Resume", resume);
	addButton(1, "Settings", settingsScreenMain);
	addButton(2, "Instructions", howToPlay);
	addButton(3, "Achievements", achievements.achievementsScreen);
		
	addButton(5, "Credits", creditsScreen);
	addButton(6, "Image Credits", imageCreditsScreen);
	addButton(7, "Debug Info", debugPane);
	addButton(8, "Mod Thread", openURL, "http://forum.fenoxo.com/thread-10915.html");
	if (false)  // Conditionally jump into chaosmonkey IMMEDIATELY
	{
		this.monkey.throwOnSyntaxError = true;
		this.monkey.excludeMenuKeys = true;			// Syntax checking monkey should ignore the menu keys (they're irrelevant to it's functions)
		this.initiateTheMonkey()
	}
}

public function startupScreenBody():void
{

	// NO FUCKING DECENT MULTI-LINE STRING LITERALS BECAUSE FUCKING STUPID
	// WTF ACTIONSCRIPT YOUR DEV'S ARE ON CRACK

	outputText(<![CDATA[
<br>(Formerly Unnamed Text Game)  
<u>Created by: Fenoxo</u>

Edited By:<br>
&nbsp; &nbsp; &nbsp; Ashi, SoS, Prisoner416, Zeikfried, et al

Open-source contributions by:<br>
&nbsp; &nbsp; &nbsp; aimozg, Amygdala, Cmacleod42, Enterprise2001, Fake-Name, Gedan, Yoffy, et al

Game Mod by: Kitteh6660

Source Code: <u><a href='https://github.com/herp-a-derp/Corruption-of-Champions'>https://github.com/herp-a-derp/Corruption-of-Champions</a></u>

Bug Tracker: <u><a href='https://github.com/herp-a-derp/Corruption-of-Champions/issues'>https://github.com/herp-a-derp/Corruption-of-Champions/issues</a></u>  
(requires an account, unfortunately)

**<u>DISCLAIMER</u>**
<br>- **There are many strange and odd fetishes contained in this flash.  Peruse at own risk.**
<br>- **Please be 18 or the legal age to view porn before playing. If not, enable SFW Mode.**
<br>- **Try to keep your keyboard clean.  Think of the children!**

For more information see Fenoxo's Blog at <b><u><a href='http://www.fenoxo.com/'>fenoxo.com</a></u></b>. 
Check out Trials in Tainted Space as well!
	
Also go play <u><a href='http://www.furaffinity.net/view/9830293/'>Nimin</a></u> by Xadera on furaffinity.

	]]>, false, true);

	if(debug)
		outputText("\n\n<b>DEBUG MODE ENABLED:  ITEMS WILL NOT BE CONSUMED BY USE.</b>");
	if(flags[kFLAGS.SHOW_SPRITES_FLAG])
		outputText("\n\n<b>Sprites disabled.</b>");
	if(flags[kFLAGS.EASY_MODE_ENABLE_FLAG])
		outputText("\n\n<b>Easy Mode On:  Bad-ends can be ignored.</b>");
	if(flags[kFLAGS.SILLY_MODE_ENABLE_FLAG])
		outputText("\n\n<b>SILLY MODE ENGAGED: Crazy, nonsensical, and possibly hilarious things may occur.</b>");
	if (flags[kFLAGS.ITS_EVERY_DAY])
		outputText("\n\n<b>Eternal holiday enabled.</b>");
	if(isEaster())
		outputText("\n\n<b>It's Easter!  Enjoy the eggs!</b>");
	if(isValentine())
		outputText("\n\n<b>It's Valentine's!</b>");
	if(helFollower.isHeliaBirthday())
		outputText("\n\n<b>It's Helia's Birthday Month!</b>");

}

public function settingsScreen():void 
{
	mainView.showMenuButton( MainView.MENU_NEW_MAIN );
	mainView.showMenuButton( MainView.MENU_DATA );
	clearOutput()
	displayHeader("Settings");
	if (flags[kFLAGS.HARDCORE_MODE] > 0) outputText("<font color=\"#ff0000\">Hardcore mode is enabled. Cheats are disabled.</font>\n\n");

	outputText("<b><u>Gameplay Settings</u></b>\n");
	if(debug)
		outputText("Debug Mode: <font color=\"#008000\"><b>ON</b></font>\n Items will not be consumed by use, fleeing always succeeds, and bad-ends can be ignored.");
	else
		outputText("Debug Mode: <font color=\"#800000\"><b>OFF</b></font>\n Items consumption will occur as normal.");
	
	outputText("\n\n");
	if (flags[kFLAGS.GAME_DIFFICULTY] <= 0)
	{
		if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG]) outputText("Difficulty: <font color=\"#008000\"><b>Easy</b></font>\n Combat is easier and bad-ends can be ignored.");
		else outputText("Difficulty: <font color=\"#808000\"><b>Normal</b></font>\n No opponent stats modifiers. You can resume from bad-ends with penalties.");
	}
	else if (flags[kFLAGS.GAME_DIFFICULTY] == 1)
	{
		outputText("Difficulty: <b><font color=\"#800000\">Hard</font></b>\n Opponent has 25% more HP and does 15% more damage. Bad-ends can ruin your game.");
	}
	else if (flags[kFLAGS.GAME_DIFFICULTY] == 2)
	{
		outputText("Difficulty: <b><font color=\"#C00000\">Nightmare</font></b>\n Opponent has 50% more HP and does 30% more damage.");
	}
	else if (flags[kFLAGS.GAME_DIFFICULTY] >= 3)
	{
		outputText("Difficulty: <b><font color=\"#FF0000\">Extreme</font></b>\n Opponent has 100% more HP and does more 50% damage.");
	}

	/*if(flags[kFLAGS.EASY_MODE_ENABLE_FLAG])
		outputText("Easy Mode: <font color=\"#008000\"><b>ON</b></font>\n Bad-ends can be ignored and combat is easier.");
	else
		outputText("Easy Mode: <font color=\"#800000\"><b>OFF</b></font>\n Bad-ends can ruin your game and combat is challenging.");

	outputText("\n\n");*/
	outputText("\n\n");
	if(flags[kFLAGS.SILLY_MODE_ENABLE_FLAG])
		outputText("Silly Mode: <font color=\"#008000\"><b>ON</b></font>\n Crazy, nonsensical, and possibly hilarious things may occur.");
	else
		outputText("Silly Mode: <font color=\"#800000\"><b>OFF</b></font>\n You're an incorrigable stick-in-the-mud with no sense of humor.");

	outputText("\n\n");
	outputText("<b>The following flags are not fully implemented yet (e.g. they don't apply in <i>all</i> cases where they could be relevant).</b>\n");
	outputText("Additional note: You <b>must</b> be <i>in a game session</i> (e.g. load your save, hit \"Main Menu\", change the flag settings, and then hit \"Resume\") to change these flags. They're saved into the saveGame file, so if you load a save, it will clear them to the state in that save.");
	outputText("\n\n");

	if(flags[kFLAGS.LOW_STANDARDS_FOR_ALL])
	{
		outputText("Low standards Mode: <font color=\"#008000\"><b>ON</b></font>\n NPCs ignore body type preferences.");
		outputText("\n (Not gender preferences though. You still need the right hole.)");
	}
	else
		outputText("Low standards Mode: <font color=\"#800000\"><b>OFF</b></font>\n NPCs have body-type preferences.");

	outputText("\n\n");

	if(flags[kFLAGS.HYPER_HAPPY])
	{
		outputText("Hyper Happy Mode: <font color=\"#008000\"><b>ON</b></font>\n Only reducto and humus shrink endowments.");
		outputText("\n Incubus draft doesn't affect breasts, and succubi milk doesn't affect cocks.")
	}
	else
		outputText("Hyper Happy Mode: <font color=\"#800000\"><b>OFF</b></font>\n Male enhancement potions shrink female endowments, and vice versa.");
		
	outputText("\n\n");		
		
	if (flags[kFLAGS.SFW_MODE] >= 1)
	{
		outputText("SFW Mode: <font color=\"#008000\"><b>ON</b></font>\n Sex scenes are disabled and adult materials are hidden.");
	}
	else 
		outputText("SFW Mode: <font color=\"#800000\"><b>OFF</b></font>\n Sex scenes are enabled.");
		
	outputText("\n\n");
		
	if (flags[kFLAGS.WATERSPORTS_ENABLED] >= 1 && flags[kFLAGS.SFW_MODE] <= 0)
	{
		outputText("Watersports: <font color=\"#008000\"><b>Enabled</b></font>\n Watersports scenes are enabled. (You kinky person)");
	}
	else 
		outputText("Watersports: <font color=\"#800000\"><b>Disabled</b></font>\n Watersports scenes are disabled.");
		
	outputText("\n\n");
	
	if (flags[kFLAGS.AUTO_LEVEL] >= 1)
	{
		outputText("Automatic Leveling: <font color=\"#008000\"><b>ON</b></font>\n Leveling up is done automatically once you accumulate enough experience.");
	}
	else 
		outputText("Automatic Leveling: <font color=\"#800000\"><b>OFF</b></font>\n Leveling up is done manually.");

		
	outputText("\n\n");
	outputText("<b><u>Interface Settings</u></b>\n");
	outputText("<b>The following flags are saved in a special savefile so you don't have to set it again each time you start up CoC.</b>");
	outputText("\n\n");
	if (flags[kFLAGS.USE_OLD_INTERFACE] >= 1)
	{
		outputText("Stats Pane Style: <b>Old</b>\n Old stats panel will be used.");
	}
	else 
		outputText("Stats Pane Style: <b>New</b>\n New stats panel will be used.");
		
	outputText("\n\n");
	
	if (flags[kFLAGS.IMAGEPACK_OFF] == 0)
	{
		outputText("Image Pack: <font color=\"#008000\"><b>ON</b></font>\n Image pack is enabled.");
	}
	else
		outputText("Image Pack: <font color=\"#800000\"><b>OFF</b></font>\n Image pack is disabled.");
		
	outputText("\n\n");
	
	if(flags[kFLAGS.SHOW_SPRITES_FLAG] == 0)
		outputText("Sprites: <font color=\"#008000\"><b>ON</b></font>\n You like to look at pretty pictures.");
	else
		outputText("Sprites: <font color=\"#800000\"><b>OFF</b></font>\n There are only words. Nothing else.");

	outputText("\n\n");
	
	if(flags[kFLAGS.USE_OLD_SPRITES] == 0)
		outputText("Sprite Type: <b>New</b>\n 16-bit sprites will be used.");
	else
		outputText("Sprite Type: <b>Old</b>\n 8-bit sprites will be used.");

	outputText("\n\n");
	
	if(flags[kFLAGS.USE_12_HOURS] > 0)
		outputText("Time Format: <b>12 hours</b>\n Time will display in 12 hours format (AM/PM)");
	else
		outputText("Time Format: <b>24 hours</b>\n Time will display in 24 hours format.");
		
	outputText("\n\n");
	
	if(flags[kFLAGS.USE_METRICS] > 0)
		outputText("Measurement: <b>Metric</b>\n Height and cock size will be measured in metres and centimetres.");
	else
		outputText("Measurement: <b>Imperial</b>\n Height and cock size will be measured in feet and inches.");
		
	outputText("\n\n");
}

public function settingsScreenMain():void
{
	kGAMECLASS.saves.savePermObject(false);
	settingsScreen();
	menu();
	addButton(0, "Gameplay", settingsScreenGameSettings);
	addButton(1, "Interface", settingsScreenInterfaceSettings);
	addButton(3, "Font Size", fontSettingsMenu);
	addButton(4, "Controls", displayControls);
	
	//addButton(4, "Next", settingsScreenMainI);
	addButton(14, "Back", mainMenu);

	if (flags[kFLAGS.HARDCORE_MODE] > 0) 
	{
		debug = false;
		flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
		flags[kFLAGS.HYPER_HAPPY] = 0;
		flags[kFLAGS.LOW_STANDARDS_FOR_ALL] = 0;
	}
}

public function settingsScreenGameSettings():void {
	settingsScreen();
	menu();
	addButton(0, "Toggle Debug", toggleDebug, null, null, null, "Turn on debug mode. Debug mode is intended for testing purposes but can be thought of as a cheat mode.  Items are infinite and combat is easy to escape from.  Weirdness and bugs are to be expected.");
	if (player.str > 0) addButton(1, "Difficulty", difficultySelectionMenu, null, null, null, "Adjust the game difficulty to make it easier or harder.");
	//addButton(1, "Easy Mode", toggleEasyModeFlag, null, null, null, "Toggles easy mode.  Enemy damage is halved and bad-ends can be ignored.");	
	addButton(2, "Silly Toggle", toggleSillyFlag, null, null, null, "Toggles silly mode. Funny, crazy and nonsensical scenes may occur if enabled.");
	addButton(3, "Low Standards", toggleStandards);
	addButton(4, "Hyper Happy", toggleHyperHappy);
	
	addButton(5, "SFW Toggle", toggleSFW, null, null, null, "Toggles SFW Mode. If enabled, sex scenes are hidden and all adult materials are censored. \n\nCurrently under development, only disables most sex scenes. Soon, it'll disable rape scenes."); //Softcore Mode
	addButton(6, "Watersports", toggleWatersports, null, null, null, "Toggles watersports scenes. (Scenes related to urine fetish)"); //Enables watersports.
	addButton(7, "Auto level", toggleAutoLevel, null, null, null, "Toggles automatic leveling when you accumulate sufficient experience.");
	if (player.str > 0) addButton(10, "Enable Surv", enableSurvivalPrompt, null, null, null, "Enable Survival mode. This will enable hunger. \n\n<font color=\"#080000\">Note: This is permanent and cannot be turned off!</font>");	
	if (player.str > 0) addButton(11, "Enable Real", enableRealisticPrompt, null, null, null, "Enable Realistic mode. This will make the game a bit realistic. \n\n<font color=\"#080000\">Note: This is permanent and cannot be turned off! Do not turn this on if you have hyper endowments.</font>");	
	if (flags[kFLAGS.HUNGER_ENABLED] >= 0.5)
	{
		removeButton(10);
	}
	if (flags[kFLAGS.HUNGER_ENABLED] >= 1)
	{
		removeButton(11);
	}
	if (flags[kFLAGS.HARDCORE_MODE] > 0) 
	{
		removeButton(0);
		removeButton(1);
		removeButton(3);
		removeButton(4);
		debug = false;
		flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
		flags[kFLAGS.HYPER_HAPPY] = 0;
		flags[kFLAGS.LOW_STANDARDS_FOR_ALL] = 0;
	}
	addButton(14, "Back", settingsScreenMain);
}

public function settingsScreenInterfaceSettings():void {
	settingsScreen();
	menu();
	addButton(0, "Side Bar Style", toggleInterface, null, null, null, "Switch between old and new stats bars.");
	addButton(1, "Toggle Images", toggleImages, null, null, null, "Enable or disable image pack.");
	addButton(2, "Toggle Sprites", toggleSpritesFlag, null, null, null, "Toggles the pixelated sprites that appears in lower-left corner of the screen and also toggles the pictures if image-pack is found.");
	addButton(3, "Old Sprites", toggleOldSprites, null, null, null, "Toggle between old and new sprites."); //Implemented at last!
	addButton(4, "Time Format", toggleTimeFormat, null, null, null, "Toggles between 12-hour and 24-hour format.");
	addButton(5, "Background", cycleBackground, null, null, null, "Cycle through background styles and colors.");
	addButton(6, "Dark Mode", toggleDarkBackground, null, null, null, "Toggle between black background, white text and normal background, black text.");
	//addButton(6, "Quality", cycleQuality, null, null, null, "Set the graphical quality. \n\nCurrent quality: " + stage.quality);
	addButton(7, "Measurements", toggleMeasurements, null, null, null, "Switch between imperial and metric measurements.  \n\nNOTE: Only applies to your appearance screen.");
	addButton(14, "Back", settingsScreenMain);
}

public function toggleInterface():void {
	if (flags[kFLAGS.USE_OLD_INTERFACE] < 1) flags[kFLAGS.USE_OLD_INTERFACE] = 1;
	else flags[kFLAGS.USE_OLD_INTERFACE] = 0;
	settingsScreenInterfaceSettings();
}

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

public function toggleDarkBackground():void {
	if (flags[kFLAGS.USE_DARK_BACKGROUND] == 0) {
		flags[kFLAGS.USE_DARK_BACKGROUND] = 1;
	}
	else {
		flags[kFLAGS.USE_DARK_BACKGROUND] = 0;
	}
	statScreenRefresh();
}

public function cycleQuality():void {
	if (stage.quality == StageQuality.LOW) stage.quality = StageQuality.MEDIUM;
	else if (stage.quality == StageQuality.MEDIUM) stage.quality = StageQuality.HIGH;
	else if (stage.quality == StageQuality.HIGH) stage.quality = StageQuality.LOW;
	settingsScreenInterfaceSettings();
}

public function toggleImages():void {
	if (flags[kFLAGS.IMAGEPACK_OFF] < 1) flags[kFLAGS.IMAGEPACK_OFF] = 1;
	else flags[kFLAGS.IMAGEPACK_OFF] = 0;
	settingsScreenInterfaceSettings();
}

public function toggleOldSprites():void {
	if (flags[kFLAGS.USE_OLD_SPRITES] < 1) flags[kFLAGS.USE_OLD_SPRITES] = 1;
	else flags[kFLAGS.USE_OLD_SPRITES] = 0;
	settingsScreenInterfaceSettings();
}

public function toggleTimeFormat():void {
	if (flags[kFLAGS.USE_12_HOURS] < 1) flags[kFLAGS.USE_12_HOURS] = 1;
	else flags[kFLAGS.USE_12_HOURS] = 0;
	settingsScreenInterfaceSettings();
}

public function toggleMeasurements():void {
	if (flags[kFLAGS.USE_METRICS] < 1) flags[kFLAGS.USE_METRICS] = 1;
	else flags[kFLAGS.USE_METRICS] = 0;
	settingsScreenInterfaceSettings();
}

public function difficultySelectionMenu():void {
	outputText("You can choose a difficulty to set how hard battles will be.\n", true);
	outputText("\n<b>Easy:</b> -50% damage, can ignore bad-ends.");
	outputText("\n<b>Normal:</b> No stats changes.");
	outputText("\n<b>Hard:</b> +25% HP, +15% damage.");
	outputText("\n<b>Nightmare:</b> +50% HP, +30% damage.");
	outputText("\n<b>Extreme:</b> +100% HP, +50% damage.");
	//outputText("\n<b>Up to Eleven:</b> +150% HP, +75% damage. This is the most cruel difficulty of all.");
	menu();
	addButton(0, "Easy", chooseDifficulty, -1);
	addButton(1, "Normal", chooseDifficulty, 0);
	addButton(2, "Hard", chooseDifficulty, 1);
	addButton(3, "Nightmare", chooseDifficulty, 2);
	addButton(4, "EXTREME", chooseDifficulty, 3);
	//addButton(5, "Up to Eleven", chooseDifficulty, 4);
	addButton(14, "Back", settingsScreenGameSettings);
}


//FONT SETTINGS
public function fontSettingsMenu():void {
	menu();
	simpleChoices("Smaller Font", decFontSize,
		"Larger Font", incFontSize,
		"Reset Size", resetFontSize,
		"", null,
		"Back", settingsScreenMain);
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

//GAMEPLAY SETTINGS
public function toggleStandards():void
{
	//toggle debug
	if(flags[kFLAGS.LOW_STANDARDS_FOR_ALL])
		flags[kFLAGS.LOW_STANDARDS_FOR_ALL] = false;
	else
		flags[kFLAGS.LOW_STANDARDS_FOR_ALL] = true;
	settingsScreenGameSettings();
	return;
}

public function toggleHyperHappy():void
{
	//toggle debug
	if(flags[kFLAGS.HYPER_HAPPY])
		flags[kFLAGS.HYPER_HAPPY] = false;
	else
		flags[kFLAGS.HYPER_HAPPY] = true;
	settingsScreenGameSettings();
	return;
}

public function toggleDebug():void
{
	//toggle debug
	if(debug)
		debug = false;
	else
		debug = true;
		
	mainView.showMenuButton( MainView.MENU_DATA );
	settingsScreenGameSettings();
	return;
}

public function toggleEasyModeFlag():void
{
	if(flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 0)
		flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 1;
	else
		flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
	mainView.showMenuButton( MainView.MENU_DATA );
	settingsScreenGameSettings();
	return;
}

public function toggleSpritesFlag():void
{
	if(flags[kFLAGS.SHOW_SPRITES_FLAG])
		flags[kFLAGS.SHOW_SPRITES_FLAG] = false;
	else
		flags[kFLAGS.SHOW_SPRITES_FLAG] = true;
	settingsScreenInterfaceSettings();
	return;
}

public function toggleSillyFlag():void
{

	if(flags[kFLAGS.SILLY_MODE_ENABLE_FLAG])
		flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = false;
	else
		flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = true;
	settingsScreenGameSettings();
	return;

}

private function chooseDifficulty(difficulty:int = 0):void {
	if (difficulty <= -1) {
		flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 1;
		flags[kFLAGS.GAME_DIFFICULTY] = 0;
	}
	else {
		flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
		flags[kFLAGS.GAME_DIFFICULTY] = difficulty;
	}
	settingsScreenGameSettings();
}

public function toggleSFW():void {
	if (flags[kFLAGS.SFW_MODE] < 1) flags[kFLAGS.SFW_MODE] = 1;
	else flags[kFLAGS.SFW_MODE] = 0;
	settingsScreenGameSettings();
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

public function creditsScreen():void {
	clearOutput();
	displayHeader("Credits");
	outputText("<b>Coding and Main Events:</b>\n");
	outputText("<ul>");
	outputText("<li> Fenoxo</li>\n");
	outputText("</ul>");
	outputText("<b>Game Mod:</b>\n");
	outputText("<ul>");
	outputText("<li> Kitteh6660 (Mod Creator)</li>");
	outputText("</ul>");
	outputText("<b>Game Mod Contributors:</b>\n");
	outputText("<ul>");
	outputText("<li> Parth37955 (Pure Jojo anal pitch scene, Behemoth's vaginal catch scene)</li>");
	outputText("<li> Liadri (Manticore and Dragonne suggestions)</li>");
	outputText("<li> Warbird Zero (Replacement Ingnam descriptions)</li>");
	outputText("</ul>");
	outputText("<b>Game Mod Supplementary Events:</b>\n");
	outputText("<ul>");
	outputText("<li> worldofdrakan (Pigtail Truffles & Pig/Boar TF)</li>");
	outputText("<li> FeiFongWong (Prisoner Mod)</li>");
	outputText("<li> Foxxling (Lizan Rogue)</li>");
	outputText("</ul>");
	outputText("<b>Game Mod Bug Reporting:</b>\n");
	outputText("<ul>");
	outputText("<li> Wastarce</li>");
	outputText("<li> Sorenant</li>");
	outputText("<li> tadams857</li>");
	outputText("<li> SirWolfie</li>");
	outputText("<li> Atlas1965</li>");
	outputText("<li> Elitist</li>");
	outputText("<li> Bsword</li>");
	outputText("<li> stationpass</li>");
	outputText("<li> JDoraime</li>");
	outputText("<li> Ramses</li>");
	outputText("<li> EternalDragon (github)</li>");
	outputText("<li> PowerOfVoid (github)</li>");
	outputText("<li> kalleangka (github)</li>");
	outputText("<li> sworve (github)</li>");
	outputText("<ul>");
	outputText("</ul>");
	outputText("<b>Typo Reporting</b>\n");
	outputText("<ul>");
	outputText("<li> SoS</li>");
	outputText("<li> Prisoner416</li>");
	outputText("<li> Chibodee</li>");
	outputText("");
	outputText("<b>Graphical Prettiness:</b>")
	outputText("<ul>");;
	outputText("<li> Dasutin (Background Images)</li>");
	outputText("<li> Invader (Button Graphics, Font, and Other Hawtness)</li>");
	outputText("</ul>");
	outputText("<b>Supplementary Events:</b>");
	outputText("<ul>");
	outputText("<li> Dxasmodeus (Tentacles, Worms, Giacomo)</li>");
	outputText("<li> Kirbster (Christmas Bunny Trap)</li>");
	outputText("<li> nRage (Kami the Christmas Roo)</li>");
	outputText("<li> Abraxas (Alternate Naga Scenes w/Various Monsters, Tamani Anal, Female Shouldra Tongue Licking, Chameleon Girl, Christmas Harpy)</li>");
	outputText("<li> Astronomy (Fetish Cultist Centaur Footjob Scene)</li>");
	outputText("<li> Adjatha (Scylla the Cum Addicted Nun, Vala, Goo-girls, Bimbo Sophie Eggs, Ceraph Urta Roleplay, Gnoll with Balls Scene, Kiha futa scene, Goblin Web Fuck Scene, and 69 Bunny Scene)</li>");
	outputText("<li> ComfyCushion (Muff Wrangler)</li>");
	outputText("<li> B (Brooke)</li>");
	outputText("<li> Quiet Browser (Half of Niamh, Ember, Amily The Mouse-girl Breeder, Katherine, Part of Katherine Employment Expansion, Urta's in-bar Dialogue Trees, some of Izma, Loppe)</li>");
	outputText("<li> Indirect (Alternate Non-Scylla Katherine Recruitment, Part of Katherine Employment Expansion, Phouka, Coding of Bee Girl Expansion)</li>");
	outputText("<li> Schpadoinkle (Victoria Sex)</li>");
	outputText("<li> Donto (Ro'gar the Orc, Polar Pete)</li>");
	outputText("<li> Angel (Additional Amily Scenes)</li>");
	outputText("<li> Firedragon (Additional Amily Scenes)</li>");
	outputText("<li> Danaume (Jojo masturbation texts)</li>");
	outputText("<li> LimitLax (Sand-Witch Bad-End)</li>");
	outputText("<li> KLN (Equinum Bad-End)</li>");
	outputText("<li> TheDarkTemplar11111 (Canine Pepper Bad End)</li>");
	outputText("<li> Silmarion (Canine Pepper Bad End)</li>");
	outputText("<li> Soretu (Original Minotaur Rape)</li>");
	outputText("<li> NinjArt (Small Male on Goblin Rape Variant)</li>");
	outputText("<li> DoubleRedd (\"Too Big\" Corrupt Goblin Fuck)</li>");
	outputText("<li> Nightshade (Additional Minotaur Rape)</li>");
	outputText("<li> JCM (Imp Night Gangbang, Addition Minotaur Loss Rape - Oral)</li>");
	outputText("<li> Xodin (Nipplefucking paragraph of Imp GangBang, Encumbered by Big Genitals Exploration Scene, Big Bits Run Encumbrance, Player Getting Beer Tits, Sand Witch Dungeon Misc Scenes)</li>");
	outputText("<li> Blusox6 (Original Queen Bee Rape)</li>");
	outputText("<li> Thrext (Additional Masturbation Code, Faerie, Ivory Succubus)</li>");
	outputText("<li> XDumort (Genderless Anal Masturbation)</li>");
	outputText("<li> Uldego (Slime Monster)</li>");
	outputText("<li> Noogai, Reaper, and Numbers (Nipple-Fucking Victory vs Imp Rape)</li>");
	outputText("<li> Verse and IAMurow (Bee-Girl MultiCock Rapes)</li>");
	outputText("<li> Sombrero (Additional Imp Lust Loss Scene (Dick insertion ahoy!)</li>");
	outputText("<li> The Dark Master (Marble, Fetish Cultist, Fetish Zealot, Hellhound, Lumi, Some Cat Transformations, LaBova, Ceraph's Cat-Slaves, a Cum Witch Scene, Mouse Dreams, Forced Nursing:Imps&Goblins, Bee Girl Expansion)</li>");
	outputText("<li> Mr. Fleshcage (Cat Transformation/Masturbation)</li>");
	outputText("<li> Spy (Cat Masturbation, Forced Nursing: Minotaur, Bee, & Cultist)</li>");
	outputText("<li> PostNuclearMan (Some Cat TF)</li>");
	outputText("<li> MiscChaos (Forced Nursing: Slime Monster)</li>");
	outputText("<li> Ourakun (Kelt the Centaur)</li>");
	outputText("<li> Rika_star25 (Desert Tribe Bad End)</li>");
	outputText("<li> Versesai (Additional Bee Rape)</li>");
	outputText("<li> Mallowman (Additional Bee Rape)</li>");
	outputText("<li> HypnoKitten (Additional Centaur x Imp Rape)</li>");
	outputText("<li> Ari (Minotaur Gloryhole Scene)</li>");
	outputText("<li> SpectralTime (Aunt Nancy)</li>");
	outputText("<li> Foxxling (Akbal)</li>");
	outputText("<li> Elfensyne (Phylla)</li>");
	outputText("<li> Radar (Dominating Sand Witches, Some Phylla)</li>");
	outputText("<li> Jokester (Sharkgirls, Izma, & Additional Amily Scenes)</li>");
	outputText("<li> Lukadoc (Additional Izma, Ceraph Followers Corrupting Gangbang, Satyrs, Ember)</li>");
	outputText("<li> IxFa (Dildo Scene, Virgin Scene for Deluxe Dildo, Naga Tail Masturbation)</li>");
	outputText("<li> Bob (Additional Izma)</li>");
	outputText("<li> lh84 (Various Typos and Code-Suggestions)</li>");
	outputText("<li> Dextersinister (Gnoll girl in the plains)</li>");
	outputText("<li> ElAcechador, Bandichar, TheParanoidOne, Xoeleox (All Things Naga)</li>");
	outputText("<li> Symphonie (Dominika the Fellatrix, Ceraph RPing as Dominika, Tel'Adre Library)</li>");
	outputText("<li> Soulsemmer (Ifris)</li>");
	outputText("<li> WedgeSkyrocket (Zetsuko, Pure Amily Anal, Kitsunes)</li>");
	outputText("<li> Zeikfried (Anemone, Male Milker Bad End, Kanga TF, Raccoon TF, Minotaur Chef Dialogues, Sheila, and More)</li>");
	outputText("<li> User21 (Additional Centaur/Naga Scenes)</li>");
	outputText("<li> ~M~ (Bimbo + Imp loss scene)</li>");
	outputText("<li> Grype (Raping Hellhounds)</li>");
	outputText("<li> B-Side (Fentendo Entertainment Center Silly-Mode Scene)</li>");
	outputText("<li> Not Important (Face-fucking a defeated minotaur)</li>");
	outputText("<li> Third (Cotton, Rubi, Nieve, Urta Pet-play)</li>");
	outputText("<li> Gurumash (Parts of Nieve)</li>");
	outputText("<li> Kinathis (A Nieve Scene, Sophie Daughter Incest, Minerva)</li>");
	outputText("<li> Jibajabroar (Jasun)</li>");
	outputText("<li> Merauder (Raphael)</li>");
	outputText("<li> EdgeofReality (Gym fucking machine)</li>");
	outputText("<li> Bronycray (Heckel the Hyena)</li>");
	outputText("<li> Sablegryphon (Gnoll spear-thrower)</li>");
	outputText("<li> Nonesuch (Basilisk, Sandtraps, assisted with Owca/Vapula, Whitney Farm Corruption)</li>");
	outputText("<li> Anonymous Individual (Lilium, PC Birthing Driders)</li>");
	outputText("<li> PKD (Owca, Vapula, Fap Arena, Isabella Tentacle Sex, Lottie Tentacle Sex)</li>");
	outputText("<li> Shamblesworth (Half of Niamh, Shouldra the Ghost-Girl, Ceraph Roleplaying As Marble, Yara Sex, Shouldra Follow Expansion)</li>");
	outputText("<li> Kirbu (Exgartuan Expansion, Yara Sex, Shambles's Handler, Shouldra Follow Expansion)</li>");
	outputText("<li> 05095 (Shouldra Expansion, Tons of Editing)</li>");
	outputText("<li> Smidgeums (Shouldra + Vala threesome)</li>");
	outputText("<li> FC (Generic Shouldra talk scene)</li>");
	outputText("<li> Oak (Bro + Bimbo TF, Isabella's ProBova Burps)</li>");
	outputText("<li> Space (Victory Anal Sex vs Kiha)</li>");
	outputText("<li> Venithil (LippleLock w/Scylla & Additional Urta Scenes)</li>");
	outputText("<li> Butts McGee (Minotaur Hot-dogging PC loss, Tamani Lesbo Face-ride, Bimbo Sophie Mean/Nice Fucks)</li>");
	outputText("<li> Savin (Hel the Salamander, Valeria, Spanking Drunk Urta, Tower of the Phoenix, Drider Anal Victory, Hel x Isabella 3Some, Centaur Sextoys, Thanksgiving Turkey, Uncorrupt Latexy Recruitment, Assert Path for Direct Feeding Latexy, Sanura the Sphinx)</li>");
	outputText("<li> Gats (Lottie, Spirit & Soldier Xmas Event, Kiha forced masturbation, Goblin Doggystyle, Chicken Harpy Egg Vendor)</li>");
	outputText("<li> Aeron the Demoness (Generic Goblin Anal, Disciplining the Eldest Minotaur)</li>");
	outputText("<li> Gats, Shamblesworth, Symphonie, and Fenoxo (Corrupted Drider)</li>");
	outputText("<li> Bagpuss (Female Thanksgiving Event, Harpy Scissoring, Drider Bondage Fuck)</li>");
	outputText("<li> Frogapus (The Wild Hunt)</li>");
	outputText("<li> Fenoxo (Everything Else)</li>");
	outputText("</ul>");
	outputText("<b>Oviposition Update Credits - Names in Order Appearance in Oviposition Document</b>");
	outputText("<ul>");
	outputText("<li> DCR (Idea, Drider Transformation, and Drider Impreg of: Goblins, Beegirls, Nagas, Harpies, and Basilisks)</li>");
	outputText("<li> Fenoxo (Bee Ovipositor Transformation, Bee Oviposition of Nagas and Jojo, Drider Oviposition of Tamani)</li>");
	outputText("<li> Smokescreen (Bee Oviposition of Basilisks)</li>");
	outputText("<li> Radar (Oviposition of Sand Witches)</li>");
	outputText("<li> OutlawVee (Bee Oviposition of Goo-Girls)</li>");
	outputText("<li> Zeikfried (Editing this mess, Oviposition of Anemones)</li>");
	outputText("<li> Woodrobin (Oviposition of Minotaurs)</li>");
	outputText("<li> Posthuman (Oviposition of Ceraph Follower)</li>");
	outputText("<li> Slywyn (Bee Oviposition of Gigantic PC Dick)</li>");
	outputText("<li> Shaxarok (Drider Oviposition of Large Breasted Nipplecunts)</li>");
	outputText("<li> Quiet Browser (Bee Oviposition of Urta)</li>");
	outputText("<li> Bagpuss (Laying Eggs In Pure Amily)</li>");
	outputText("<li> Eliria (Bee Laying Eggs in Bunny-Girls)</li>");
	outputText("<li> Gardeford (Helia x Bimbo Sophie Threesomes)</li>");
	outputText("</ul>");
	outputText("\nIf I'm missing anyone, please contact me ASAP!  I have done a terrible job keeping the credits up to date!");
	doNext(mainMenu);
}

public function imageCreditsScreen():void
{

	if (images.getLoadedImageCount() > 0)
	{
		outputText(<![CDATA[

**Bundled Image Credits:**

**Yoh-SL**

* Bee-Girl Monster Image
* Goo-Girl Monster Image
* Ceraph Monster Image
* Sand-Witch (and sandwich)

		]]>, true, true);
	}
	else
	{
		outputText("<b>No Image-Pack Found!</b>\n", true);
	}
	doNext(mainMenu);
}

public function howToPlay():void {
	clearOutput();
	outputText("<font size=\"36\" face=\"Georgia\">Instructions</font>\n", false)
	outputText("<b><u>How To Play:</u></b>\nClick the buttons corresponding to the actions you want to take.  Your 'goal' is to obviously put an end to the demonic corruption around you, but do whatever the hell you want.  There is a story but sometimes it's fun to ignore it.\n\n", false);
	outputText("<b>Exploration:</b>\nThe lake is a safe zone when you start the game.  It's a good place to explore, and Whitney's farm can offer some nice stat boosts to help get you on your feet. Once you feel comfortable, the forest is probably the next safest area, but beware of tentacle monsters.  The desert is the next toughest area, and the mountains offer further challenges.  There are more areas beyond that, but that's a good way to get started.  You'll uncover plenty of new 'places' exploring, which can be accessed from the <b>Places</b> menu.  You'll also find some interesting characters when you try to discover new explorable locations by choosing <b>Explore</b> twice.\n\n", false);
	outputText("<b>Combat:</b>\nCombat is won by raising an opponent's lust to 100 or taking their HP to 0.  You lose if your enemy does the same to you.  Loss isn't game over, but some losses will make it harder in the future by lowering your stats.  Beware.  Don't be afraid to spam the <b>Run</b> option when you're in over your head.\n\n", false);
	outputText("<b>Controls:</b>\nThe game features numerous hot-keys to make playing quicker and easier.\nP key - Perks Menu\nD key - Data Menu\nA key - Appearance Screen\n1 Through 5 - The top row of 'choice' buttons.\n6 Through 0 - The bottom row of 'choice' buttons.\nQ through T - Alternative bottom 'choice' hotkeys.\nSpace Bar - Next/Back/Leave\nHome Key - Toggle text field background.\nS key - Stats Screen\n(Save Hotkeys - May not work in all players)\nF1-F5 - Quicksave to slot 1 through 5.  Only works when Data is visible.\nF6-F0 - Quick Load from slots 1-5.\n\n", false);
	outputText("<b>Save often using the Data Menu</b> - you never know when your journey will come to an end!", false);
	doNext(mainMenu);
}


