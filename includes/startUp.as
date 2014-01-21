


//MainMenu - kicks player out to the main menu
public function mainMenu(e:MouseEvent = undefined):void 
{

	if(CONFIG::debug)
	{
		CoC_Settings.debugBuild = true;
	}
	else
	{
		CoC_Settings.debugBuild = false;
	}


	mainView.eventTestInput.x = -10207.5;
	mainView.eventTestInput.y = -1055.1;
	hideStats();
	//Reset newgame buttons
	mainView.setMenuButton( MainView.MENU_NEW_MAIN, "New Game", charCreation.newGameGo );
	mainView.hideAllMenuButtons();
	mainView.showMenuButton( MainView.MENU_NEW_MAIN );
	mainView.showMenuButton( MainView.MENU_DATA );
	//Sets game state to 3, used for determining back functionality of save/load menu.
	gameState = 3;


	outputText("<b>Corruption of Champions (" + version + ")</b>", true);
	
	if (CoC_Settings.debugBuild)
		outputText(" Debug Build.");
	else
		outputText(" Release Build");

	//doThatTestingThang();

	startupScreenBody();

	var resume:Number = 0;
	if(player.str > 0)  //we're in a game, allow resume.
		resume = 1;


	// I really wanted to only have the "imageCreditsScreen" button if images were found, but it turns out
	// that if you check if any images were found immediately when this screen is shown, you get 0
	// since the images haven't loaded yet.
	// Therefore, the imageCreditScreen will just have to say "No image pack" if you don't have any images

	choices("",  0,
			"Image Credits", imageCreditsScreen,
			"Credits", creditsScreen,
			"", 0,
			"Instructions", howToPlay,
			"Debug Info", debugPane,
			"", 0,
			"", 0,
			"Settings", settingsScreen,
			"Resume", resume);

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

Edited By: SoS, Zeikfried, Prisoner416, Ashi, and Others

Open-source version modifications by:  
Amygdaloidnucleus/Amygdala, Hoffledop/Yoffy, Herp-a-derp/Fake-Name, Cmacleod42, Gedan, aimozg

Source Code: <u><a href='https://github.com/herp-a-derp/Corruption-of-Champions'>https://github.com/herp-a-derp/Corruption-of-Champions</a></u>

Bug Tracker: <u><a href='https://github.com/herp-a-derp/Corruption-of-Champions/issues'>https://github.com/herp-a-derp/Corruption-of-Champions/issues</a></u>  
(requires an account, unfortunately)

**<u>DISCLAIMER</u>**
<br>- **There are many strange and odd fetishes contained in this flash.  Peruse at own risk.**
<br>- **Please be 18 or the legal age to view porn before playing.**
<br>- **Try to keep your keyboard clean.  Think of the children!**


For more information see Fenoxo's Blog at <b><u><a href='http://www.fenoxo.com/'>fenoxo.com</a></u></b>.

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
	
	outputText("<b>Settings toggles:</b>\n", true);

	if(debug)
		outputText("Debug mode enabled: <b>Yes</b>\n	Items will not be consumed by use, fleeing always succeeds, and bad-ends can be ignored.");
	else
		outputText("Debug mode enabled: <b>No</b>\n	Items consumption will occur as normal.");

	outputText("\n\n");

	if(flags[kFLAGS.SHOW_SPRITES_FLAG] == 0)
		outputText("Sprites enabled: <b>Yes</b>.\n	You like to look at pretty pictures.");
	else
		outputText("Sprites enabled: <b>No</b>.\n	There are only words. Nothing else.");

	outputText("\n\n");

	if(flags[kFLAGS.EASY_MODE_ENABLE_FLAG])
		outputText("Easy Mode <b>On</b>\n	Bad-ends can be ignored and combat is easier.");
	else
		outputText("Easy Mode <b>Off</b>\n	Bad-ends can ruin your game and combat is challenging.");

	outputText("\n\n");

	if(flags[kFLAGS.SILLY_MODE_ENABLE_FLAG])
		outputText("Silly Mode <b>On</b>\n	Crazy, nonsensical, and possibly hilarious things may occur.");
	else
		outputText("Silly Mode <b>Off</b>\n	You're an incorrigable stick-in-the-mud with no sense of humor.");

	outputText("\n\n");
	outputText("<b>The following flags are not fully implemented yet (e.g. they don't apply in <i>all</i> cases where they could be relevant).</b>\n");
	outputText("Additional note: You <b>must</b> be <i>in a game session</i> (e.g. load your save, hit \"Main Menu\", change the flag settings, and then hit \"Resume\") to change these flags. They're saved into the saveGame file, so if you load a save, it will clear them to the state in that save.");
	outputText("\n\n");

	if(flags[kFLAGS.LOW_STANDARDS_FOR_ALL])
	{
		outputText("Low standards Mode <b>On</b>\n	NPCs ignore body type preferences.");
		outputText("\n	(Not gender preferences though. You still need the right hole.)");
	}
	else
		outputText("Low standards Mode <b>Off</b>\n	NPCs have body-type preferences.");


	outputText("\n\n");

	if(flags[kFLAGS.HYPER_HAPPY])
	{
		outputText("Hyper Happy mode <b>On</b>\n	Only reducto and humus shrink endowments.");
		outputText("\n	Incubus draft doesn't affect breasts, and succubi milk doesn't affect cocks.")
	}
	else
		outputText("Hyper Happy mode <b>Off</b>\n	Male enhancement potions shrink female endowments, and vice versa.");

	choices("Toggle Debug", toggleDebug,
			"Sprite Toggle", toggleSpritesFlag,
			"EZ Mode", toggleEasyModeFlag,
			"Silly Toggle", toggleSillyFlag,
			"Null", 0,
			"Hyper Happy", toggleHyperHappy,
			"Low Standards", toggleStandards,
			"Null", 0,
			"Controls", displayControls,
			"Back", mainMenu);
}


public function toggleStandards():void
{
	//toggle debug
	if(flags[kFLAGS.LOW_STANDARDS_FOR_ALL])
		flags[kFLAGS.LOW_STANDARDS_FOR_ALL] = false;
	else
		flags[kFLAGS.LOW_STANDARDS_FOR_ALL] = true;
	settingsScreen();
	return;
}

public function toggleHyperHappy():void
{
	//toggle debug
	if(flags[kFLAGS.HYPER_HAPPY])
		flags[kFLAGS.HYPER_HAPPY] = false;
	else
		flags[kFLAGS.HYPER_HAPPY] = true;
	settingsScreen();
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
	settingsScreen();
	return;
}

public function toggleEasyModeFlag():void
{
	if(flags[kFLAGS.EASY_MODE_ENABLE_FLAG] == 0)
		flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 1;
	else
		flags[kFLAGS.EASY_MODE_ENABLE_FLAG] = 0;
	settingsScreen();
	mainView.showMenuButton( MainView.MENU_DATA );
	settingsScreen();
	return;
}

public function toggleSpritesFlag():void
{
	if(flags[kFLAGS.SHOW_SPRITES_FLAG])
		flags[kFLAGS.SHOW_SPRITES_FLAG] = false;
	else
		flags[kFLAGS.SHOW_SPRITES_FLAG] = true;
	settingsScreen();
	return;
}

public function toggleSillyFlag():void
{

	if(flags[kFLAGS.SILLY_MODE_ENABLE_FLAG])
		flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = false;
	else
		flags[kFLAGS.SILLY_MODE_ENABLE_FLAG] = true;
	settingsScreen();
	return;

}


public function creditsScreen():void {
	outputText("<b>Coding and Main Events:</b>\n", true);
	outputText("<ul>");
	outputText("<li> Fenoxo</li>\n");
	outputText("</ul>");
	outputText("<b>Typo Reporting</b>\n");
	outputText("<ul>");
	outputText("<li> SoS</li>");
	outputText("<li> Prisoner416</li>");
	outputText("<li> Chibodee</li>");
	outputText("</ul>");
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
	outputText("<li> Quiet Browser (Half of Niamh, Ember, Amily The Mouse-girl Breeder, Katherine, Urta's in-bar Dialogue Trees, some of Izma, Loppe)</li>");
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
	outputText("<li> The Dark Master (Marble, Fetish Cultist, Fetish Zealot, Hellhound, Lumi, Some Cat Transformations, LaBova, Ceraph's Cat-Slaves, a Cum Witch Scene, Mouse Dreams, Forced Nursing:Imps&Goblins)</li>");
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
	outputText("<li> Nonesuch (Basilisk, Sandtraps, assisted with Owca/Vapula)</li>");
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
	outputText("", true);
	outputText("<b><u>How To Play:</u></b>\nClick the buttons corresponding to the actions you want to take.  Your 'goal' is to obviously put an end to the demonic corruption around you, but do whatever the hell you want.  There is a story but sometimes it's fun to ignore it.\n\n", false);
	outputText("<b>Exploration:</b>\nThe lake is a safe zone when you start the game.  It's a good place to explore, and Whitney's farm can offer some nice stat boosts to help get you on your feet. Once you feel comfortable, the forest is probably the next safest area, but beware of tentacle monsters.  The desert is the next toughest area, and the mountains offer further challenges.  There are more areas beyond that, but that's a good way to get started.  You'll uncover plenty of new 'places' exploring, which can be accessed from the <b>Places</b> menu.  You'll also find some interesting characters when you try to discover new explorable locations by choosing <b>Explore</b> twice.\n\n", false);
	outputText("<b>Combat:</b>\nCombat is won by raising an opponent's lust to 100 or taking their HP to 0.  You lose if your enemy does the same to you.  Loss isn't game over, but some losses will make it harder in the future by lowering your stats.  Beware.  Don't be afraid to spam the <b>Run</b> option when you're in over your head.\n\n", false);
	outputText("<b>Controls:</b>\nThe game features numerous hot-keys to make playing quicker and easier.\nP key - Perks Menu\nD key - Data Menu\nA key - Appearance Screen\n1 Through 5 - The top row of 'choice' buttons.\n6 Through 0 - The bottom row of 'choice' buttons.\nQ through T - Alternative bottom 'choice' hotkeys.\nSpace Bar - Next/Back/Leave\nHome Key - Toggle text field background.\nS key - Stats Screen\n(Save Hotkeys - May not work in all players)\nF1-F5 - Quicksave to slot 1 through 5.  Only works when Data is visible.\nF6-F0 - Quick Load from slots 1-5.\n\n", false);
	outputText("<b>Save often using the Data Menu</b> - you never know when your journey will come to an end!", false);
	doNext(mainMenu);
}

