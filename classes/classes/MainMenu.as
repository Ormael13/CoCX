package classes {

import classes.GlobalFlags.*;
import classes.Scenes.Achievements;
import classes.Scenes.Changelog;
import classes.Scenes.SceneLib;

import coc.view.MainView;

public class MainMenu extends BaseContent {

	public function MainMenu() {}

	//------------
	// MAIN MENU
	//------------
	//MainMenu - kicks player out to the main menu
	public function mainMenu():void {
        CoC.instance.stage.focus = (mainView as MainView).mainText;
        CoC_Settings.debugBuild = CONFIG::debug;

		mainView.hideComboBox();
        CoC.instance.mainViewManager.registerShiftKeys();
        mainView.eventTestInput.x = -10207.5;
		mainView.eventTestInput.y = -1055.1;
		hideStats();
        CoC.instance.mainViewManager.startUpButtons();
        CoC.instance.saves.loadPermObject();
        if (CoC.instance.gameSettings.charviewEnabled) mainView.charView.reload();
        CoC.instance.mainViewManager.setTheme();
        //Reset newgame buttons
        mainView.setMenuButton(MainView.MENU_NEW_MAIN, "New Game", CoC.instance.charCreation.newGameFromScratch);
        mainView.hideAllMenuButtons();
		mainView.showMenuButton(MainView.MENU_NEW_MAIN);
		mainView.showMenuButton(MainView.MENU_DATA);

		mainView.newGameButton.toolTipText      = "Start a new game.";
		mainView.dataButton.toolTipHeader       = "New Game";
		mainView.dataButton.toolTipText         = "Save or load your files.";
		mainView.dataButton.toolTipHeader       = "Data";
		mainView.statsButton.toolTipText        = "View your stats.";
		mainView.statsButton.toolTipHeader      = "Stats";
		mainView.perksButton.toolTipText        = "View your perks.";
		mainView.perksButton.toolTipHeader      = "Perks";
		mainView.appearanceButton.toolTipText   = "View your appearance.";
		mainView.appearanceButton.toolTipHeader = "Appearance";
		//Sets game state to 3, used for determining back functionality of save/load menu.
        CoC.instance.resetGameState();
        clearOutput();
		//outputText("<img src=\"logo\" id=\"coc-logo\" height=\"300\" width=\"400\" />\n");
        outputText("<b>Corruption of Champions (" + CoC.instance.version + ")</b>");
        if (CoC_Settings.debugBuild)
			outputText(" Debug Build");
		else
			outputText(" Release Build");

		startupScreenBody();

		var resume:Function = null;
		if (player)  //we're in a game, allow resume.
			resume = playerMenu;

		var achievements:Achievements = new Achievements();
		var changelog:Changelog = new Changelog();

		// I really wanted to only have the "imageCreditsScreen" button if images were found, but it turns out
		// that if you check if any images were found immediately when this screen is shown, you get 0
		// since the images haven't loaded yet.
		// Therefore, the imageCreditScreen will just have to say "No image pack" if you don't have any images

		menu();
		if (resume != null) addButton(0, "Resume", resume).hint("Get back to gameplay?");
		else addButtonDisabled(0, "Resume", "Please start or load a game first.");
		if (resume != null) addButton(1, "Achievements", achievements.achievementsScreen).hint("View all achievements you have unlocked so far.");
		else addButtonDisabled(1, "Achievements", "Please start or load a game first.");
        addButton(2, "Settings", CoC.instance.gameSettings.settingsScreenMain).hint("Configure game settings and enable cheats.");
		addButton(3, "Mod Thread", openURL, "https://forum.fenoxo.com/threads/coc-xianxia-mod-0-8g2-for-coc-1-0-2.2346", null, null, "Check the official mod thread on Fenoxo's forum.");
        addButton(4, "Instructions", howToPlay).hint("How to play.  Starting tips.  And hotkeys for easy left-handed play...");

		addButton(5, "Credits", creditsScreen).hint("See a list of all the cool people who have contributed to content for this game!");
		addButton(6, "Image Credits", imageCreditsScreen).hint("Check out who contributed to the image pack.");
		addButton(7, "Changelog", changelog.accessChangelogMenu).hint("View full changelog for each version of Xianxia since v0.1 <i>Warning: It have many pages already.</i>");
        if (CoC_Settings.debugBuild) addButton(8, "Debug Info", CoC.instance.debugInfoMenu.debugPane).hint("View debug information.");
    }

	public function startupScreenBody():void {
		// NO FUCKING DECENT MULTI-LINE STRING LITERALS BECAUSE FUCKING STUPID
		// WTF ACTIONSCRIPT YOUR DEV'S ARE ON CRACK
		// Fixed. No more markdown. :)
		outputText("\n(Formerly Unnamed Text Game)");
		//Brief credits
		outputText("\n\n<b>Game Mod by:</b> Ormael"); //Mod Creator
		outputText("\n\n<b>Open-source contributions by:</b> \n"); //Mod Creator
		outputText("aimozg, Amygdala, Cmacleod42, Enterprise2001, Fake-Name, Gedan, Yoffy, Kitteh6660, et al"); //Contributions
		outputText("\n\n<b>Edited by:</b> Ashi, SoS, Prisoner416, Zeikfried, et al"); //Edited By
		outputText("\n\n<b>Created by:</b> Fenoxo\n"); //The Original Creator
		//Github for Mod
		outputText("\n<b>Modded Game Source Code:</b> <u><a href='https://github.com/Ormael7/Corruption-of-Champions'>https://github.com/Ormael7/Corruption-of-Champions</a></u>");
		outputText("\n<b>Modded Game Bug Tracker:</b> <u><a href='https://github.com/Ormael7/Corruption-of-Champions/issues'>https://github.com/Ormael7/Corruption-of-Champions/issues</a></u>");
		//Github for Original
		outputText("\n\n<b>Original Game Source Code:</b> <u><a href='https://github.com/OXOIndustries/Corruption-of-Champions'>https://github.com/OXOIndustries/Corruption-of-Champions</a></u>");
		//Disclaimer
		outputText("\n\n<b><u>DISCLAIMER</u></b>");
		outputText("<li>There are many strange and odd fetishes contained in this flash.  Peruse at own risk.</li>");
		outputText("<li>Please be 18 or the legal age to view porn before playing. If not, enable SFW Mode.</li>");
		outputText("<li>Try to keep your keyboard clean.  Think of the children!</li>");
		//Other Info
		outputText("\n<b>Fall of Eden</b> is worth a try too ^^");

		if (debug)
			outputText("\n\n<b>DEBUG MODE ENABLED:  ITEMS WILL NOT BE CONSUMED BY USE.</b>");
		if (flags[kFLAGS.SHOW_SPRITES_FLAG])
			outputText("\n\n<b>Sprites disabled.</b>");
		if (flags[kFLAGS.EASY_MODE_ENABLE_FLAG])
			outputText("\n\n<b>Easy Mode On:  Bad-ends can be ignored.</b>");
		if (flags[kFLAGS.SILLY_MODE_ENABLE_FLAG])
			outputText("\n\n<b>SILLY MODE ENGAGED: Crazy, nonsensical, and possibly hilarious things may occur.</b>");
		if (flags[kFLAGS.ITS_EVERY_DAY])
			outputText("\n\n<b>Eternal holiday enabled.</b>");
		if (isEaster())
			outputText("\n\n<b>It's Easter!  Enjoy the eggs!</b>");
		if (isValentine())
			outputText("\n\n<b>It's Valentine's!</b>");
		if (isHalloween())
			outputText("\n\n<b>It's Halloween!</b>");
		if (SceneLib.alvinaFollower.isAlvinaBirthday())
			outputText("\n\n<b>It's our lady and saviour Alvina Shadowmantle Birthday Month!</b>");
		if (SceneLib.helFollower.isHeliaBirthday())
			outputText("\n\n<b>It's Helia's Birthday Month!</b>");

	}

	//------------
// CREDITS
//------------
	public function creditsScreen():void {
		clearOutput();
		displayHeader("Credits");
		outputText("<b>Coding and Main Events:</b>\n");
		outputText("<ul>");
		outputText("<li> Fenoxo</li>\n");
		outputText("</ul>");
		outputText("<b>Game Mod:</b>\n");
		outputText("<ul>");
		outputText("<li> Ormael (Mod Creator)</li>");
		outputText("</ul>");
		outputText("<b>Game Mod Angels:</b>\n");
		outputText("<ul>");
		outputText("<li> Aimong</li>\n");
		outputText("<li> Liadri</li>");
		outputText("<li> Zavos/Zevos</li>");
		outputText("<li> Xana</li>\n");
		outputText("<li> MissBlackThorne</li>\n");
		outputText("<li> 'Secret Collaborant'</li>\n");
		outputText("</ul>");
		outputText("<b>Game Mod Contributors:</b>\n");
		outputText("<ul>");
		outputText("<li> Kitteh6660 (Creating mod that was base for the mod ^^ (Modception... xD))</li>");
		outputText("</ul>");
		outputText("<b>Game Mod Supplementary Events:</b>\n");
		outputText("<ul>");
		outputText("<li> worldofdrakan (Pigtail Truffles & Pig/Boar TF)</li>");
		outputText("<li> FeiFongWong (Prisoner Mod)</li>");
		outputText("<li> Foxxling (Lizan Rogue, Skin Oils & Body Lotions, Black Cock)</li>");
		outputText("<li> LukaDoc (Bimbo Jojo)</li>");
		outputText("<li> Kitteh6660 (Behemoth, Cabin, Ingnam, Pure Jojo sex scenes)</li>");
		outputText("</ul>");
		/*outputText("<b>Game Mod Bug Reporting:</b>\n");
		 outputText("<ul>");
		 outputText("<li> Netys (github)</li>");
		 outputText("<ul>");
		 outputText("</ul>");
		 outputText("<b>Typo Reporting</b>\n");
		 outputText("<ul>");
		 outputText("<li> SoS</li>");
		 outputText("<li> Prisoner416</li>");
		 outputText("<li> Chibodee</li>");
		 outputText("");*/
		outputText("<b>Graphical Prettiness:</b>");
		outputText("<ul>");
        outputText("<li> Dasutin (Background Images)</li>");
		outputText("<li> Invader (Button Graphics, Font, and Other Hawtness)</li>");
		outputText("</ul>");
		outputText("<b>Supplementary Events:</b>");
		outputText("<ul>");
		outputText("<li> Liadri (Etna, Manticore Venom (TF item), Black Ink - female scylla TF item, female scylla exclusive masturbation scene, texts and name for Mantis TF - Blade Grass, Kindra (writing part and some of ideas for few secenes), Archery Overhaul (main designer for it), various TF's: Yeti, Orca, Raiju, Manticore, Hinezumi, Alraune, Werewolf, Winter Wolf, Fenrir, Gargoyle, Cheshire Cat, Hellcat, Jabberwock, Cave Wyrm, Devil, Bicorn, Nightmare, Elf; Ceani the Orca girl, Electra the Raiju, Chi Chi the fire mouse, Luna the werewolf maid, Patchouli, Celess, Electra, Winter Wolf enemy, Sabbat event, Pinchou merchant and all items in her shop, Adventure Guild, ");
		outputText("underwater sharkgirls sex scenes, Kaiba the tanuki merchant, Den of Desire dungeon, most of writing for 1st floor of River Dungeon, Erma archery training, Gaunlet 1 and 2, Jiangshi TF, part of Michiko)</li>");
		outputText("<li> Zevos (Spider-silk shirt, Dragonscale vest, Eldritch Ribbon, Ascensus, Depravation, Puritas items, Ebonbloom crafting material and all items made from it, Ignis)</li>");
		outputText("<li> Coalsack (Anzu the Avian Deity, Arian App desc, option to change his/her scales color)</li>");
		outputText("<li> Lord Snakebite (part of Ghost TF rework)</li>");
		outputText("<li> T0uchMe (part of Ghost TF rework)</li>");
		outputText("<li> Apex (part of Michiko)</li>");
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
		outputText("<li> Lukadoc (Additional Izma, Ceraph Followers Corrupting Gangbang, Satyrs, Ember, Arian)</li>");
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
		doNext(mainMenu);
	}

//------------
// IMAGE CREDITS
//------------
	public function imageCreditsScreen():void {
		clearOutput();
		displayHeader("Image Credits");
		if (images.getLoadedImageCount() > 0) {
			outputText("<b>Bundled Image Credits:</b>\n\n");
			outputText("<b>Yoh-SL</b>");
			outputText("<li>Bee-Girl Monster Image</li>");
			outputText("<li>Goo-Girl Monster Image</li>");
			outputText("<li>Ceraph Monster Image</li>");
			outputText("<li>Sand-Witch (and sandwich)</li>");
		}
		else {
			outputText("<b>No Image-Pack Found!</b>\n");
		}
		doNext(mainMenu);
	}

//------------
// INSTRUCTIONS
//------------
	public function howToPlay():void {
		clearOutput();
		displayHeader("Instructions");
		outputText("<b><u>How To Play:</u></b>\nClick the buttons corresponding to the actions you want to take.  Your 'goal' is to obviously put an end to the demonic corruption around you, but do whatever the hell you want.  There is a story but sometimes it's fun to ignore it.\n\n");
		outputText("<b>Exploration:</b>\nThe lake is a safe zone (until you're level 3) when you start the game.  It's a good place to explore, and Whitney's farm can offer some nice stat boosts to help get you on your feet. Once you feel comfortable, the forest is probably the next safest area, but beware of tentacle monsters.  The desert is the next toughest area, and the mountains offer further challenges.  There are more areas beyond that, but that's a good way to get started.  You'll uncover plenty of new 'places' exploring, which can be accessed from the <b>Places</b> menu.  You'll also find some interesting characters when you try to discover new explorable locations by choosing <b>Explore</b> twice.\n\n");
		outputText("<b>Combat:</b>\nCombat is won by raising an opponent's lust to maximum lust or taking their HP to 0 (later on some of them wouldn't loose till brought to specific negative HP value).  You lose if your enemy does the same to you.  Loss isn't game over, but some losses will make it harder in the future by lowering your stats.  Beware.  Don't be afraid to spam the <b>Run</b> option when you're in over your head.\n\n");
		outputText("<b>Controls:</b>\nThe game features numerous hot-keys to make playing quicker and easier.\nP key - Perks Menu\nD key - Data Menu\nA key - Appearance Screen\n1 Through 5 - The top row of 'choice' buttons.\n6 Through 0 - The bottom row of 'choice' buttons.\nQ through T - Alternative bottom 'choice' hotkeys.\nSpace Bar - Next/Back/Leave\nHome Key - Toggle text field background.\nS key - Stats Screen\n(Save Hotkeys - May not work in all players)\nF1-F5 - Quicksave to slot 1 through 5.  Only works when Data is visible.\nF6-F0 - Quick Load from slots 1-5.\n\n");
		outputText("<b>Save often using the Data Menu</b> - you never know when your journey will come to an end!");
		doNext(mainMenu);
	}


}

}
