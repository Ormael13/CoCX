
//Keyboard listener!
stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboard);

function hideThisButton(e:MouseEvent):void{
	e.target.visible=false;
}
// Create a new instance of the Font1 symbol from the document's library.


/* Create a new TextFormat object, and set the font property to the myFont
   object's fontName property. 
var myFormat:TextFormat = new TextFormat();
myFormat.font = new buttonFont().fontName
myFormat.bold = true;
if(mobile) myFormat.size = 22;
else myFormat.size = 18;

	Create a new TextField object, assign the text format using the 
   defaultTextFormat property, and set the embedFonts property to true.
newGameText.defaultTextFormat = myFormat;
newGameText.embedFonts = true;
newGameText.text = "New Game";
b1Text.defaultTextFormat = myFormat;
b1Text.embedFonts = true;
b1Text.text = "New Game";
//b2Text.defaultTextFormat = myFormat;
b2Text.embedFonts = true;
b2Text.text = "New Game";
b3Text.defaultTextFormat = myFormat;
b3Text.embedFonts = true;
b3Text.text = "New Game";
b4Text.defaultTextFormat = myFormat;
b4Text.embedFonts = true;
b4Text.text = "New Game";
b5Text.defaultTextFormat = myFormat;
b5Text.embedFonts = true;
b5Text.text = "New Game";
b6Text.defaultTextFormat = myFormat;
b6Text.embedFonts = true;
b6Text.text = "New Game";
b7Text.defaultTextFormat = myFormat;
b7Text.embedFonts = true;
b7Text.text = "New Game";
b8Text.defaultTextFormat = myFormat;
b8Text.embedFonts = true;
b8Text.text = "New Game";
b9Text.defaultTextFormat = myFormat;
b9Text.embedFonts = true;
b9Text.text = "New Game";
b0Text.defaultTextFormat = myFormat;
b0Text.embedFonts = true;
b0Text.text = "New Game";
dataText.defaultTextFormat = myFormat;
dataText.embedFonts = true;
dataText.text = "Data";
levelText2.defaultTextFormat = myFormat;
levelText2.embedFonts = true;
levelText2.text = "Level Up";
perksText.defaultTextFormat = myFormat;
perksText.embedFonts = true;
perksText.text = "Perks";
appearanceText.defaultTextFormat = myFormat;
appearanceText.embedFonts = true;
appearanceText.text = "Appearance";
statsText.defaultTextFormat = myFormat;
statsText.embedFonts = true;
statsText.text = "More Stats";
mouseOverText.defaultTextFormat = myFormat;
mouseOverText.embedFonts = true;*/
mouseOverText.type = TextFieldType.DYNAMIC;
textBGWhite.visible = false;
textBGTan.visible = false;

//Not exactly sure what the purpose of this is. I'm pretty sure there is no Serializing going on anywhere.
registerClassAlias("creature", creature);
registerClassAlias("itemSlotClass", itemSlotClass);
//registerClassAlias("cockClass", cockClass);
registerClassAlias("Cock", Cock);



//Invert shit
invertGo();
//Hide sprites
sprite.visible = false;
//Hide second text window
imageText.visible = false;
//Hide stats
hideStats();
//Hide level up button and associate level up stuff
levelBG.visible = false;
levelText2.visible = false;
//Hide up/down arrows
hideUpDown();
//Hide choice buttons
//choices("one", 0, "two", 0, "three", 0, "four", 0, "five", 0, "six", 0, "seven", 0, "eight", 0, "nine", 0, "ten", 0);
//Hide mouseovertext
mouseOverText.visible = false;
//Hide sidebar and time backgrounds
sideBarBG.visible = false;
popUpBG.visible = false;
timeBG.visible = false;
nameBox.visible = false;
//Call up the title screen
mainMenu();


//MainMenu - kicks player out to the main menu
function mainMenu(e:MouseEvent = undefined):void {
	eventTestInput.x = -10207.5;
	eventTestInput.y = -1055.1;
	hideStats();
	//Reset newgame buttons
	newGameText.removeEventListener(MouseEvent.CLICK, mainMenu);
	newGameBG.removeEventListener(MouseEvent.CLICK, mainMenu);
	newGameText.addEventListener(MouseEvent.CLICK, newGameGo);
	newGameBG.addEventListener(MouseEvent.CLICK, newGameGo);
	newGameText.text = "New Game";
	//statBox.visible = false;
	//statBox2.visible = false;
	perksText.visible = false;
	perksBG.visible = false;
	appearanceText.visible = false;
	appearanceBG.visible = false;
	dataText.visible = true;
	dataBG.visible = true;
	levelText2.visible = false;
	levelBG.visible = false;
	levelUp.visible = false;
	statsBG.visible = false;
	statsText.visible = false;
	//Sets game state to 3, used for determining back functionality of save/load menu.
	gameState = 3;
	outputText("<b>Corruption of Champions (" + version + ")</b>\n(Formerly Unnamed Text Game)\n\nCreated by: Fenoxo\nEdited By: Ashi, SoS, Zeikfried, and Others\n\n<b><u>DISCLAIMER</u>\n\n-There are many strange and odd fetishes contained in this flash.  Peruse at own risk.\n-Please be 18 or the legal age to view porn before playing.\n-Try to keep your keyboard clean.  Think of the children!</b>\n\nFor more information see Fenoxo's Blog at <b>fenoxo.com</b>.\n\nAlso go play Nimin by Xadera on furaffinity.", true);
	if(debug) 
		outputText("\n\n<b>DEBUG MODE ENABLED:  ITEMS WILL NOT BE CONSUMED BY USE.</b>", false);
	if(flags[SHOW_SPRITES_FLAG]) 
		outputText("\n\n<b>Sprites disabled.</b>", false);
	if(flags[EASY_MODE_ENABLE_FLAG]) 
		outputText("\n\n<b>Easy Mode On:  Bad-ends can be ignored.</b>", false);
	if(flags[SILLY_MODE_ENABLE_FLAG]) 
		outputText("\n\n<b>SILLY MODE ENGAGED: Crazy, nonsensical, and possibly hilarious things may occur.</b>", false);
	if(isEaster()) 
		outputText("\n\n<b>It's Easter!  Enjoy the eggs!</b>");
	if(isValentine()) 
		outputText("\n\n<b>It's Valentine's!</b>");
	if(isHeliaBirthday()) 
		outputText("\n\n<b>It's Helia's Birthday Month!</b>");

	var resume:Number = 0;
	if(player.str > 0)  //we're in a game, allow resume.
		resume = 1;
	
	choices("",  0, "Credits", creditsScreen, "Instructions", howToPlay, "", 0, "", 0, "ASPLODE", 9000000000, "", 0, "", 0, "Settings", settingsScreen, "Resume", resume);
		
}


function settingsScreen():void {
	outputText("<b>Settings toggles:</b>\n", true);

	if(debug) 
		outputText("Debug mode enabled: <b>Yes</b>\n	Items will not be consumed by use.", false);
	else
		outputText("Debug mode enabled: <b>No</b>\n	Items consumption will occur as normal.", false);

	outputText("\n\n", false);

	if(flags[SHOW_SPRITES_FLAG]) 
		outputText("Sprites enabled: <b>Yes</b>.\n	You like to look at pretty pictures.", false);
	else
		outputText("Sprites enabled: <b>No</b>.\n	There are only words. Nothing else.", false);

	outputText("\n\n", false);

	if(flags[EASY_MODE_ENABLE_FLAG]) 
		outputText("Easy Mode <b>On</b>\n	Bad-ends can be ignored.", false);
	else
		outputText("Easy Mode <b>Off</b>\n	You die, you're dead.", false);
		
	outputText("\n\n", false);

	if(flags[SILLY_MODE_ENABLE_FLAG]) 
		outputText("Silly Mode <b>On</b>\n	Crazy, nonsensical, and possibly hilarious things may occur.", false);
	else
		outputText("Silly Mode <b>Off</b>\n	You're an incorrigable stick-in-the-mud with no sense of humor.", false);

	outputText("\n\n", false);
	outputText("<b>The following flags are not fully implemeneted yet.</b>", false);
	outputText("\n\n", false);

	if(flags[LOW_STANDARDS_FOR_ALL]) 
	{
		outputText("Low standards Mode <b>On</b>\n	NPCs ignore body type preferences.", false);
		outputText("\n	(Not gender preferences though. You still need the right hole.)", false);
	}
	else
		outputText("Low standards Mode <b>Off</b>\n	NPCs have body-type preferences.", false);


	outputText("\n\n", false);

	if(flags[HYPER_HAPPY]) 
	{
		outputText("Hyper Happy mode <b>On</b>\n	Only reducto and humus shrink endowments.", false);
		outputText("\n	Incubus draft doesn't affect breasts, and succubi milk doesn't affect cocks.")
	}
	else
		outputText("Hyper Happy mode <b>Off</b>\n	Male enhancement potions shrink female endowments, and vice versa.", false);




	choices("Toggle Debug", toggleDebug, 
			"Sprite Toggle", toggleSpritesFlag, 
			"EZ Mode", toggleEasyModeFlag, 
			"Silly Toggle", toggleSillyFlag, 
			"Null", 0, 
			"Hyper Happy", toggleHyperHappy, 
			"Low Standards", toggleStandards, 
			"Null", 0, 
			"Null", 0, 
			"Back", mainMenu);
}


function toggleStandards():void
{
	//toggle debug
	if(flags[LOW_STANDARDS_FOR_ALL]) 
		flags[LOW_STANDARDS_FOR_ALL] = false;
	else 
		flags[LOW_STANDARDS_FOR_ALL] = true;
	settingsScreen();
	return;
}

function toggleHyperHappy():void
{
	//toggle debug
	if(flags[HYPER_HAPPY]) 
		flags[HYPER_HAPPY] = false;
	else 
		flags[HYPER_HAPPY] = true;
	settingsScreen();
	return;
}

function toggleDebug():void
{
	//toggle debug
	if(debug) 
		debug = false;
	else 
		debug = true;
	dataBG.visible = true;
	dataText.visible = true;
	settingsScreen();
	return;
}

function toggleEasyModeFlag():void
{
	if(flags[EASY_MODE_ENABLE_FLAG] == 0) 
		flags[EASY_MODE_ENABLE_FLAG] = 1;
	else 
		flags[EASY_MODE_ENABLE_FLAG] = 0;
	settingsScreen();
	dataBG.visible = true;
	dataText.visible = true;
	settingsScreen();
	return;	
}

function toggleSpritesFlag():void
{
	if(flags[SHOW_SPRITES_FLAG]) 
		flags[SHOW_SPRITES_FLAG] = false;
	else 
		flags[SHOW_SPRITES_FLAG] = true;
	settingsScreen();
	return;
}

function toggleSillyFlag():void
{

	if(flags[SILLY_MODE_ENABLE_FLAG])
		flags[SILLY_MODE_ENABLE_FLAG] = false;
	else 
		flags[SILLY_MODE_ENABLE_FLAG] = true;
	settingsScreen();
	return;
	
}

function creditsScreen():void {
	outputText("<b>Coding and Main Events:</b>\n", true);
	outputText(" * Fenoxo\n\n", false);
	outputText("<b>Typo Reporting</b>\n", false);
	outputText("* SoS\n", false);
	outputText("* Prisoner416\n");
	outputText("* Chibodee\n");
	outputText("\n");
	outputText("<b>Graphical Prettiness:</b>\n", false);
	outputText("* Dasutin (Background Images)\n", false);
	outputText("* Invader (Button Graphics, Font, and Other Hawtness)\n", false);
	outputText("\n", false);
	outputText("<b>Supplementary Events:</b>\n", false);
	outputText("* Dxasmodeus (Tentacles, Worms, Giacomo)\n", false);
	outputText("* Kirbster (Christmas Bunny Trap)\n");
	outputText("* nRage (Kami the Christmas Roo)\n");
	outputText("* Abraxas (Alternate Naga Scenes w/Various Monsters, Tamani Anal, Female Shouldra Tongue Licking, Chameleon Girl, Christmas Harpy)\n", false);
	outputText("* Astronomy (Fetish Cultist Centaur Footjob Scene)\n", false);
	outputText("* Adjatha (Scylla the Cum Addicted Nun, Vala, Goo-girls, Bimbo Sophie Eggs, Ceraph Urta Roleplay, Gnoll with Balls Scene, Kiha futa scene, Goblin Web Fuck Scene, and 69 Bunny Scene)\n", false);
	outputText("* ComfyCushion (Muff Wrangler)\n");
	outputText("* B (Brooke)\n");
	outputText("* Quiet Browser (Half of Niamh, Ember, Amily The Mouse-girl Breeder, Katherine, Urta's in-bar Dialogue Trees, some of Izma, Loppe)\n", false);
	outputText("* Schpadoinkle (Victoria Sex)\n");
	outputText("* Donto (Ro'gar the Orc, Polar Pete)\n", false);
	outputText("* Angel (Additional Amily Scenes)\n", false);
	outputText("* Firedragon (Additional Amily Scenes)\n", false);
	outputText("* Danaume (Jojo masturbation texts)\n", false);
	outputText("* LimitLax (Sand-Witch Bad-End)\n", false);
	outputText("* KLN (Equinum Bad-End)\n", false);
	outputText("* TheDarkTemplar11111 (Canine Pepper Bad End)\n", false);
	outputText("* Silmarion (Canine Pepper Bad End)\n", false);
	outputText("* Soretu (Original Minotaur Rape)\n", false);
	outputText("* NinjArt (Small Male on Goblin Rape Variant)\n", false);
	outputText("* Nightshade (Additional Minotaur Rape)\n", false);
	outputText("* JCM (Imp Night Gangbang, Addition Minotaur Loss Rape - Oral)\n", false);
	outputText("* Xodin (Nipplefucking paragraph of Imp GangBang, Encumbered by Big Genitals Exploration Scene, Big Bits Run Encumbrance, Player Getting Beer Tits, Sand Witch Dungeon Misc Scenes)\n", false);
	outputText("* Blusox6 (Original Queen Bee Rape)\n", false);
	outputText("* Thrext (Additional Masturbation Code, Faerie, Ivory Succubus)\n", false);
	outputText("* XDumort (Genderless Anal Masturbation)\n", false);
	outputText("* Uldego (Slime Monster)\n", false);
	outputText("* Noogai, Reaper, and Numbers (Nipple-Fucking Victory vs Imp Rape)\n", false);
	outputText("* Verse and IAMurow (Bee-Girl MultiCock Rapes)\n", false);
	outputText("* Sombrero (Additional Imp Lust Loss Scene (Dick insertion ahoy!)\n", false);
	outputText("* The Dark Master (Marble, Fetish Cultist, Fetish Zealot, Hellhound, Lumi, Some Cat Transformations, LaBova, Ceraph's Cat-Slaves, a Cum Witch Scene, Mouse Dreams, Forced Nursing:Imps&Goblins)\n", false);
	outputText("* Mr. Fleshcage (Cat Transformation/Masturbation)\n", false);
	outputText("* Spy (Cat Masturbation, Forced Nursing: Minotaur, Bee, & Cultist)\n", false);
	outputText("* PostNuclearMan (Some Cat TF)\n", false);
	outputText("* MiscChaos (Forced Nursing: Slime Monster)\n", false);
	outputText("* Ourakun (Kelt the Centaur)\n", false);
	outputText("* Rika_star25 (Desert Tribe Bad End)\n", false);
	outputText("* Versesai (Additional Bee Rape)\n", false);
	outputText("* Mallowman (Additional Bee Rape)\n", false);
	outputText("* HypnoKitten (Additional Centaur x Imp Rape)\n", false);
	outputText("* Ari (Minotaur Gloryhole Scene)\n", false);
	outputText("* SpectralTime (Aunt Nancy)\n", false);
	outputText("* Foxxling (Akbal)\n", false);
	outputText("* Elfensyne (Phylla)\n");
	outputText("* Radar (Dominating Sand Witches, Some Phylla)\n");
	outputText("* Jokester (Sharkgirls, Izma, & Additional Amily Scenes)\n", false);	
	outputText("* Lukadoc (Additional Izma, Ceraph Followers Corrupting Gangbang, Satyrs, Ember)\n", false);
	outputText("* Bob (Additional Izma)\n", false);
	outputText("* lh84 (Various Typos and Code-Suggestions)\n", false);
	outputText("* Dextersinister (Gnoll girl in the plains)\n", false);
	outputText("* ElAcechador, Bandichar, TheParanoidOne, Xoeleox (All Things Naga)\n", false);
	outputText("* Symphonie (Dominika the Fellatrix, Ceraph RPing as Dominika, Tel'Adre Library)\n", false);
	outputText("* Soulsemmer (Ifris)\n", false);
	outputText("* WedgeSkyrocket (Zetsuko, Pure Amily Anal, Kitsunes)\n", false);
	outputText("* Zeikfried (Anemone, Male Milker Bad End, Kanga TF, Raccoon TF, Minotaur Chef Dialogues, Sheila, and More)\n", false);
	outputText("* User21 (Additional Centaur/Naga Scenes)\n", false);
	outputText("* ~M~ (Bimbo + Imp loss scene)\n", false);
	outputText("* Grype (Raping Hellhounds)\n", false);
	outputText("* B-Side (Fentendo Entertainment Center Silly-Mode Scene)\n", false);
	outputText("* Not Important (Face-fucking a defeated minotaur)\n", false);
	outputText("* Third (Cotton, Rubi, Nieve, Urta Pet-play)\n", false);
	outputText("* Gurumash (Parts of Nieve)\n");
	outputText("* Kinathis (A Nieve Scene, Sophie Daughter Incest, Minerva)\n");
	outputText("* Jibajabroar (Jasun)\n", false);
	outputText("* Merauder (Raphael)\n", false);
	outputText("* EdgeofReality (Gym fucking machine)\n", false);
	outputText("* Bronycray (Heckel the Hyena)\n", false);
	outputText("* Sablegryphon (Gnoll spear-thrower)\n", false);
	outputText("* Nonesuch (Basilisk, Sandtraps, assisted with Owca/Vapula)\n", false);
	outputText("* Anonymous Individual (Lilium, PC Birthing Driders)\n", false);
	outputText("* PKD (Owca, Vapula, Fap Arena, Isabella Tentacle Sex, Lottie Tentacle Sex)\n", false);
	outputText("* Shamblesworth (Half of Niamh, Shouldra the Ghost-Girl, Ceraph Roleplaying As Marble, Yara Sex, Shouldra Follow Expansion)\n", false);
	outputText("* Kirbu (Exgartuan Expansion, Yara Sex, Shambles's Handler, Shouldra Follow Expansion)\n", false);
	outputText("* 05095 (Shouldra Expansion, Tons of Editing)\n");
	outputText("* Smidgeums (Shouldra + Vala threesome)\n");
	outputText("* FC (Generic Shouldra talk scene)\n");
	outputText("* Oak (Bro + Bimbo TF, Isabella's ProBova Burps)\n", false);
	outputText("* Space (Victory Anal Sex vs Kiha)\n", false);
	outputText("* Venithil (LippleLock w/Scylla & Additional Urta Scenes)\n");
	outputText("* Butts McGee (Minotaur Hot-dogging PC loss, Tamani Lesbo Face-ride, Bimbo Sophie Mean/Nice Fucks)\n");
	outputText("* Savin (Hel the Salamander, Valeria, Spanking Drunk Urta, Tower of the Phoenix, Drider Anal Victory, Hel x Isabella 3Some, Centaur Sextoys, Thanksgiving Turkey, Uncorrupt Latexy Recruitment, Assert Path for Direct Feeding Latexy, Sanura the Sphinx)\n", false);
	outputText("* Gats (Lottie, Spirit & Soldier Xmas Event, Kiha forced masturbation, Goblin Doggystyle, Chicken Harpy Egg Vendor)\n", false);
	outputText("* Aeron the Demoness (Generic Goblin Anal, Disciplining the Eldest Minotaur)\n", false);
	outputText("* Gats, Shamblesworth, Symphonie, and Fenoxo (Corrupted Drider)\n", false);
	outputText("* Bagpuss (Female Thanksgiving Event, Harpy Scissoring, Drider Bondage Fuck)\n", false);
	outputText("* Fenoxo (Everything Else)\n", false);
	outputText("\n<b>Oviposition Update Credits - Names in Order Appearance in Oviposition Document</b>\n");
	outputText("* DCR (Idea, Drider Transformation, and Drider Impreg of: Goblins, Beegirls, Nagas, Harpies, and Basilisks)\n");
	outputText("* Fenoxo (Bee Ovipositor Transformation, Bee Oviposition of Nagas and Jojo, Drider Oviposition of Tamani)\n");
	outputText("* Smokescreen (Bee Oviposition of Basilisks)\n");
	outputText("* Radar (Oviposition of Sand Witches)\n");
	outputText("* OutlawVee (Bee Oviposition of Goo-Girls)\n");
	outputText("* Zeikfried (Editing this mess, Oviposition of Anemones)\n");
	outputText("* Woodrobin (Oviposition of Minotaurs)\n");
	outputText("* Posthuman (Oviposition of Ceraph Follower)\n");
	outputText("* Slywyn (Bee Oviposition of Gigantic PC Dick)\n");
	outputText("* Shaxarok (Drider Oviposition of Large Breasted Nipplecunts)\n");
	outputText("* Quiet Browser (Bee Oviposition of Urta)\n");
	outputText("* Bagpuss (Laying Eggs In Pure Amily)\n");
	outputText("* Eliria (Bee Laying Eggs in Bunny-Girls)\n");
	outputText("\nIf I'm missing anyone, please contact me ASAP!  I have done a terrible job keeping the credits up to date!", false);
	doNext(mainMenu);	
}

function howToPlay():void {
	outputText("", true);
	outputText("<b><u>How To Play:</u></b>\nClick the buttons corresponding to the actions you want to take.  Your 'goal' is to obviously put an end to the demonic corruption around you, but do whatever the hell you want.  There is a story but sometimes it's fun to ignore it.\n\n", false);
	outputText("<b>Exploration:</b>\nThe lake is a safe zone when you start the game.  It's a good place to explore, and Whitney's farm can offer some nice stat boosts to help get you on your feet. Once you feel comfortable, the forest is probably the next safest area, but beware of tentacle monsters.  The desert is the next toughest area, and the mountains offer further challenges.  There are more areas beyond that, but that's a good way to get started.  You'll uncover plenty of new 'places' exploring, which can be accessed from the <b>Places</b> menu.  You'll also find some interesting characters when you try to discover new explorable locations by choosing <b>Explore</b> twice.\n\n", false);
	outputText("<b>Combat:</b>\nCombat is won by raising an opponent's lust to 100 or taking their HP to 0.  You lose if your enemy does the same to you.  Loss isn't game over, but some losses will make it harder in the future by lowering your stats.  Beware.  Don't be afraid to spam the <b>Run</b> option when you're in over your head.\n\n", false);
	outputText("<b>Controls:</b>\nThe game features numerous hot-keys to make playing quicker and easier.\nP key - Perks Menu\nD key - Data Menu\nA key - Appearance Screen\n1 Through 5 - The top row of 'choice' buttons.\n6 Through 0 - The bottom row of 'choice' buttons.\nQ through T - Alternative bottom 'choice' hotkeys.\nSpace Bar - Next/Back/Leave\nHome Key - Toggle text field background.\nS key - Stats Screen\n(Save Hotkeys - May not work in all players)\nF1-F5 - Quicksave to slot 1 through 5.  Only works when Data is visible.\nF6-F0 - Quick Load from slots 1-5.\n\n", false);
	outputText("<b>Save often using the Data Menu</b> - you never know when your journey will come to an end!", false);
	doNext(mainMenu);
}

function eventTester():void {
	outputText("", true);
	eventTestInput.x = 207.5;
	eventTestInput.y = 55.1;
	//eventTestInput.text = "Paste test event text here.";
	simpleChoices("Proceed",118,"",0,"",0,"",0,"Back",119);
}
	
