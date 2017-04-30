package classes.Scenes.Places {
	import classes.*;
	import classes.GlobalFlags.*;
	import classes.Items.Armor;
	import classes.Scenes.Dungeons.DeepCave.ValaScene;
	import classes.Scenes.Places.TelAdre.*;

	/**
 * The lovely town of Tel Adre
 * @author:
 */
	public class TelAdre extends BaseContent
	{
		public var auntNancy:AuntNancy = new AuntNancy();
		public var bakeryScene:BakeryScene = new BakeryScene();
		public var brooke:Brooke = new Brooke();
		public var cotton:Cotton = new Cotton();
		public var dominika:Dominika = new Dominika();
		public var edryn:Edryn = new Edryn();
		public var frosty:Frosty = new Frosty();
		public var heckel:Heckel = new Heckel();
		public var ifris:Ifris = new Ifris();
		public var jasun:Jasun = new Jasun();
		public var katherine:Katherine = new Katherine();
		public var katherineEmployment:KatherineEmployment = new KatherineEmployment();
		public var katherineThreesome:KatherineThreesome = new KatherineThreesome();
		public var library:Library = new Library();
		public var loppe:Loppe = new Loppe();
		public var lottie:Lottie = new Lottie();
		public var maddie:Maddie = new Maddie();
		public var niamh:Niamh = new Niamh();
		public var pablo:PabloScene = new PabloScene();
		public var rubi:Rubi = new Rubi();
		public var scylla:Scylla = new Scylla();
		public var sexMachine:SexMachine = new SexMachine();
		public var umasShop:UmasShop = new UmasShop();
		
		public var vala:ValaScene = new ValaScene();
		
		public var nails:Number = 0;
		public var wood:Number = 0;
		public var stone:Number = 0;
		
		public function TelAdre()
		{
			
		}

//const YVONNE_FUCK_COUNTER:int = 437;

/**
 * 3 variables that define bonuses for piercing.
 */
//{region PiercingVariables

//0) **Clit (+2 sens)
//1) **Dick (+2 lib) adds the word 'pierced' sometimes to the description
//2) **Ears
//3) **Eyebrow (-.5 def)
//4) **Lip (-.5 def)
//5) **Nipples (+1 sens, +1 lib)
//6) **Nose (+.5 attack)
//7) **Tongue (+1 sens)
//8) **Vulva (+1 sens)
public var piercingLoc:Number = 0;

//1. Amethyst (+1 int, +1 lib)
//2. Diamond (+2 int, -1 cor)
//3. Gold (+1 int, +1 sens)
//4. Emerald (+1 spe)
//5. Jade (+1 spe, -.5 tou)
//6. Onyx (+1 tou, -1 spe)
//7. Ruby (+1 lib, +1 sens)
//8. Steel (+2 str, -2 int)
public var piercingMat:Number = 0;

//1. Stud
//2. Ring (Called prince albert on dick)
//3. Jacobs Ladder (dick only)
//4. Hoop (ears/nipples/clit)
//5. Chain (nipples only)
public var piercingType:Number = 0;
//}endregion

public function discoverTelAdre():void {
	clearOutput();
	if (!player.hasStatusEffect(StatusEffects.TelAdre)) {
		outputText("The merciless desert sands grind uncomfortably under your " + player.feet() + " as you walk the dunes, searching the trackless sands to uncover their mysteries.  All of a sudden, you can see the outline of a small city in the distance, ringed in sandstone walls.  Strangely it wasn't there a few moments before.  It's probably just a mirage brought on by the heat.  Then again, you don't have any specific direction you're heading, what could it hurt to go that way?", false);
		outputText("\n\nDo you investigate the city in the distance?", false);
	}
	else {
		outputText("While out prowling the desert dunes you manage to spy the desert city of Tel'Adre again.  You could hike over to it again, but some part of you fears being rejected for being 'impure' once again.  Do you try?", false);
	}
	doYesNo(encounterTelAdre,camp.returnToCampUseOneHour);
}

//player chose to approach the city in the distance
private function encounterTelAdre():void {
	clearOutput();
	if (!player.hasStatusEffect(StatusEffects.TelAdre)) {
		outputText("You slog through the shifting sands for a long time, not really seeming to get that close.  Just when you're about to give up, you crest a large dune and come upon the walls of the city you saw before.  It's definitely NOT a mirage.  There are sandstone walls at least fifty feet tall ringing the entire settlement, and the only entrance you can see is a huge gate with thick wooden doors.  The entrance appears to be guarded by a female gray fox who's more busy sipping on something from a bottle than watching the desert.\n\n", false);
		outputText("As if detecting your thoughts, she drops the bottle and pulls out a halberd much longer than she is tall.\n\n", false);
		outputText("\"<i>Hold it!</i>\" barks the fox, her dark gray fur bristling in suspicion at your sudden appearance, \"<i>What's your business in the city of Tel'Adre?</i>\"\n\n", false);
		outputText("You shrug and explain that you know nothing about this town, and just found it while exploring the desert.  The girl stares at you skeptically for a moment and then blows a shrill whistle.  She orders, \"<i>No sudden moves.</i>\"\n\n", false);
		outputText("Deciding you've nothing to lose by complying, you stand there, awaiting whatever reinforcements this cute vulpine-girl has summoned.  Within the minute, a relatively large-chested centauress emerges from a smaller door cut into the gate, holding a massive bow with an arrow already nocked.\n\n", false);
		outputText("\"<i>What's the problem, Urta?  A demon make it through the barrier?</i>\" asks the imposing horse-woman.\n\nUrta the fox shakes her head, replying, \"<i>I don't think so, Edryn.  " + player.mf("He's","She's") + " something else.  We should use the crystal and see if " + player.mf("he","she") + "'s fit to be allowed entry to Tel'Adre.</i>\"\n\n", false);
		outputText("You watch the big centaur cautiously as she pulls out a pendant, and approaches you.  \"<i>Hold still,</i>\" she says, \"<i>this will do you no harm.</i>\"\n\n", false);
		outputText("She places one hand on your shoulder and holds the crystal in the other.  Her eyes close, but her brow knits as she focuses on something.  ", false);
		telAdreCrystal();
	}
	else {
		outputText("Once again you find the gray fox, Urta, guarding the gates.  She nods at you and whistles for her companion, Edryn once again.  The centauress advances cautiously, and you submit herself to her inspection as she once again produces her magical amulet.  ", false);
		telAdreCrystal();
	}
}

//Alignment crystal goooooo
private function telAdreCrystal():void {
	if (!player.hasStatusEffect(StatusEffects.TelAdre)) player.createStatusEffect(StatusEffects.TelAdre,0,0,0,0);
	//-70+ corruption, or possessed by exgartuan
	if (player.hasStatusEffect(StatusEffects.Exgartuan) || player.cor >= 70 + player.corruptionTolerance()) {
		outputText("The crystal pendant begins to vibrate in the air, swirling around and glowing dangerously black.  Edryn snatches her hand back and says, \"<i>I'm sorry, but you're too far gone to step foot into our city.  If by some miracle you can shake the corruption within you, return to us.</i>\"\n\n", false);
		outputText("You shrug and step back.  You could probably defeat these two, but you know you'd have no hope against however many friends they had beyond the walls.  You turn around and leave, a bit disgruntled at their hospitality.  After walking partway down the dune you spare a glance over your shoulder and discover the city has vanished!  Surprised, you dash back up the dune, flinging sand everywhere, but when you crest the apex, the city is gone.", false);
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	//-50+ corruption or corrupted Jojo
	else if (player.cor >= 50 || flags[kFLAGS.JOJO_STATUS] >= 5) {
		outputText("The crystal pendant shimmers, vibrating in place and glowing a purple hue.  Edryn steps back, watching you warily, \"<i>You've been deeply touched by corruption.  You balance on a razor's edge between falling completely and returning to sanity.  You may enter, but we will watch you closely.</i>\"\n\n", false);
	}
	//-25+ corruption or corrupted Marae
	else if (player.cor >= 25 || flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
		outputText("The crystal pendant twirls in place, glowing a dull red.  Edryn takes a small step back and murmurs, \"<i>You've seen the darkness of this land first hand, but its hold on you is not deep.  You'll find sanctuary here.  The demons cannot find this place yet, and we promise you safe passage within the walls.</i>\"\n\n", false);
	}
	//-Low corruption/pure characters
	else {
		outputText("The crystal shines a pale white light.  Edryn steps back and smiles broadly at you and says, \"<i>You've yet to be ruined by the demonic taint that suffuses the land of Mareth.  Come, you may enter our city walls and find safety here, though only so long as the covenant's white magic protects us from the demons' lapdogs.</i>\"\n\n", false);
	}
	outputText("The vixen Urta gestures towards the smaller door and asks, \"<i>Would you like a tour of Tel'Adre, newcomer?</i>\"\n\n", false);
	outputText("You remember your etiquette and nod, thankful to have a quick introduction to such a new place.  Urta leaves Edryn to watch the gate and leads you inside.  You do notice her gait is a bit odd, and her fluffy fox-tail seems to be permanently wrapped around her right leg.  The door closes behind you easily as you step into the city of Tel'Adre...", false);
	doNext(telAdreTour);
}

private function telAdreTour():void {
	player.changeStatusValue(StatusEffects.TelAdre,1,1);
	clearOutput();
	kGAMECLASS.urta.urtaSprite();
	outputText("Urta leads you into the streets of Tel'Adre, giving you a brief run-down of her and her city, \"<i>You see, about two decades back, the demons were chewing their way through every settlement and civilization in Mareth.  The covenant, a group of powerful magic-users, realized direct confrontation was doomed to fail.  They hid us in the desert with their magic, and the demons can't corrupt what they can't find.  So we're safe, for now.</i>\"\n\n", false);
	outputText("The two of you find yourselves in the center of a busy intersection.  Urta explains that this is the main square of the city, and that, although the city is large, a goodly portion of it remains empty.  Much of the population left to assist other settlements in resisting the demons and was lost.  She brushes a lock of stray hair from her eye and guides you down the road, making sure to point out her favorite pub - \"The Wet Bitch\".  You ", false);
	if (player.cor < 25) outputText("blush", false);
	else outputText("chuckle", false);
	outputText(" at the rather suggestive name as Urta turns around and says, \"<i>With how things are, we've all gotten a lot more comfortable with our sexuality.  I hope it doesn't bother you.</i>\"\n\n", false);
	outputText("A bit further on, you're shown a piercing parlor, apparently another favorite of Urta's.  A cute human girl with cat-like ears peeks out the front and gives you both a friendly wave.  It's so strange to see so many people together in one place, doing things OTHER than fucking.  The whole thing makes you miss your hometown more than ever.  Tears come to your eyes unbidden, and you wipe them away, glad to at least have this one reminder of normalcy.  Urta politely pretends not to notice, though the tail she keeps wrapped around her leg twitches as she wraps up the tour.\n\n", false);
	outputText("She gives you a friendly punch on the shoulder and says, \"<i>Okay, gotta go!  Be good and stay out of trouble, alright?</i>\"\n\n", false);
	outputText("Before you can answer, she's taken off back down the street, probably stopping off at 'The Wet Bitch' for a drink.  Strange, her departure was rather sudden...", false);
	doNext(telAdreMenu);
}

public function telAdreMenu():void {
	if (flags[kFLAGS.VALENTINES_EVENT_YEAR] < date.fullYear && player.balls > 0 && player.hasCock() && flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] >= 4 && flags[kFLAGS.TIMES_MET_SCYLLA_IN_ADDICTION_GROUP] > 0 && isValentine()) {
		kGAMECLASS.valentines.crazyVDayShenanigansByVenithil();
		return;
	}
	if (!kGAMECLASS.urtaQuest.urtaBusy() && flags[kFLAGS.PC_SEEN_URTA_BADASS_FIGHT] == 0 && rand(15) == 0 && model.time.hours > 15) {
		urtaIsABadass();
		return;
	}
	if (!kGAMECLASS.urtaQuest.urtaBusy() && kGAMECLASS.urta.pregnancy.event > 5 && rand(30) == 0) {
		kGAMECLASS.urtaPregs.urtaIsAPregnantCopScene();
	   return;
	}
	switch (flags[kFLAGS.KATHERINE_UNLOCKED]) {
		case -1:
		case  0: //Still potentially recruitable
			if (flags[kFLAGS.KATHERINE_RANDOM_RECRUITMENT_DISABLED] == 0 && player.gems > 34 && rand(25) == 0) {
				if (flags[kFLAGS.KATHERINE_UNLOCKED] == 0)
					katherine.ambushByVagrantKittyKats()
				else katherine.repeatAmbushKatherineRecruitMent();
				return;
			}
		case  1: //In alley behind Oswald's
		case  2: //You are training her
		case  3: //You and Urta are training her
			break;
		case  4: //Employed
			if (!katherine.isAt(Katherine.KLOC_KATHS_APT) && flags[kFLAGS.KATHERINE_TRAINING] >= 100) {
				katherineEmployment.katherineGetsEmployed();
				return;
			}
		default: //Has given you a spare key to her apartment
			if (model.time.hours < 10 && rand(12) == 0) { //If employed or housed she can sometimes be encountered while on duty
				katherine.katherineOnDuty();
				return;
			}
	}
	if (flags[kFLAGS.ARIAN_PARK] == 0 && rand(10) == 0 && flags[kFLAGS.NOT_HELPED_ARIAN_TODAY] == 0) {
		kGAMECLASS.arianScene.meetArian();
		return;
	}
	//Display Tel'adre menu options//
	//Special Delivery☼☼☼
	//Has a small-ish chance of playing when the PC enters Tel'Adre.
	//Must have Urta's Key.
	//Urta must be pregnant to trigger this scene.
	//Play this scene upon entering Tel'Adre.
	if (kGAMECLASS.urta.pregnancy.event > 2 && rand(4) == 0 && flags[kFLAGS.URTA_PREGNANT_DELIVERY_SCENE] == 0 && player.hasKeyItem("Spare Key to Urta's House") >= 0) {
		kGAMECLASS.urtaPregs.urtaSpecialDeliveries();
		return;
	}
	if (flags[kFLAGS.MADDIE_STATUS] == -1) {
		maddie.runAwayMaddieFollowup();
		return;
	}
	spriteSelect(-1);
	outputText(images.showImage("location-teladre"));
	outputText("Tel'Adre is a massive city, though most of its inhabitants tend to hang around the front few city blocks.  It seems the fall of Mareth did not leave the city of Tel'Adre totally unscathed.  A massive tower rises up in the center of the city, shimmering oddly.  From what you overhear in the streets, the covenant's magic-users slave away in that tower, working to keep the city veiled from outside dangers.  There does not seem to be a way to get into the unused portions of the city, but you'll keep your eyes open.\n\n", true);
	outputText("A sign depicting a hermaphroditic centaur covered in piercings hangs in front of one of the sandstone buildings, and bright pink lettering declares it to be the 'Piercing Studio'.  You glance over and see the wooden facade of Urta's favorite bar, 'The Wet Bitch'.  How strange that those would be what she talks about during a tour.  In any event you can also spot some kind of wolf-man banging away on an anvil in a blacksmith's stand, and a foppishly-dressed dog-man with large floppy ears seems to be running some kind of pawnshop in his stand.  Steam boils from the top of a dome-shaped structure near the far end of the street, and simple lettering painted on the dome proclaims it to be a bakery.  Perhaps those shops will be interesting as well.", false);
	if (flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == -2 && !kGAMECLASS.raphael.RaphaelLikes()) {
		outputText("\n\nYou remember Raphael's offer about the Orphanage, but you might want to see about shaping yourself more to his tastes first.  He is a picky fox, after all, and you doubt he would take well to seeing you in your current state.");
	}
	telAdreMenuShow();
}

public function telAdreMenuShow():void { //Just displays the normal Tel'Adre menu options, no special events, no description. Useful if a special event has already played
	var homes:Boolean = false;
	if (flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == -2 && kGAMECLASS.raphael.RaphaelLikes())
		homes = true;
	else if (player.hasKeyItem("Spare Key to Urta's House") >= 0)
		homes = true;
	else if (flags[kFLAGS.KATHERINE_UNLOCKED] >= 5)
		homes = true;
	else if (flags[kFLAGS.ARIAN_PARK] >= 4 && !kGAMECLASS.arianScene.arianFollower())
		homes = true;
	menu();
	addButton(0, "Shops", armorShops);
	addButton(1, "Bakery", bakeryScene.bakeryuuuuuu);
	addButton(2, "Bar", enterBarTelAdre);
	addButton(3, "Gym", gymDesc);
	if (homes) addButton(4, "Homes", houses);
	if (flags[kFLAGS.ARIAN_PARK] > 0 && flags[kFLAGS.ARIAN_PARK] < 4) addButton(5, "Park", kGAMECLASS.arianScene.visitThePark);
	addButton(6, "Pawn", oswaldPawn);
	addButton(7, "Tower", library.visitZeMagesTower);
	addButton(14, "Leave", camp.returnToCampUseOneHour);
	if (flags[kFLAGS.GRIMDARK_MODE] > 0) addButton(14, "Leave", leaveTelAdreGrimdark);
}

		public function leaveTelAdreGrimdark():void {
			inRoomedDungeonResume = getGame().dungeons.resumeFromFight;
			getGame().dungeons._currentRoom = "desert";
			getGame().dungeons.move(getGame().dungeons._currentRoom);
		}

private function armorShops():void {
	clearOutput();
	outputText("The shopping district of Tel’adre happens to be contained in a large dead end street, with a large set of doors at the entrance to protect it from thieves at night, you’d assume from a higher elevation it would look like a giant square courtyard. Due to the cities shopping area being condensed into one spot, most if not every visible wall has been converted into a store front, in the center of the area are some small stands, guess not everyone can afford a real store.");
	outputText("\n\nRight off the bat you see the ‘Piercing Studio’, its piercing covered centaur sign is a real eye catcher. You can also spot some kind of wolf-man banging away on an anvil in a blacksmith's stand. As well as other shops lining the walls, perhaps those shops will be interesting as well.");
	menu();
	addButton(0, "Blacksmith", armorShop);
	addButton(1, "Piercing", piercingStudio);
	addButton(2, "Tailor", tailorShoppe);
	addButton(3, "Weapons", weaponShop);
	addButton(4, "Jewelry", jewelShopEntry);
	addButton(5, "Clinic", umasShop.enterClinic);
	if (flags[kFLAGS.CAMP_CABIN_PROGRESS] >= 4)
	{
		addButton(6, "Carpenter", carpentryShopEntry);
	}
	addButton(14,"Back",telAdreMenu);
}

public function houses():void {
	clearOutput();
	outputText("Whose home will you visit?");
	var orphanage:Function = null;
	if (flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == -2) {
		if (kGAMECLASS.raphael.RaphaelLikes())
		{
			orphanage = kGAMECLASS.raphael.orphanageIntro;
		}
		else {
			outputText("\n\nYou remember Raphael's offer about the Orphanage, but you might want to see about shaping yourself more to his tastes first.  He is a picky fox, after all, and you doubt he would take well to seeing you in your current state.");
		}
	}
	menu();
	if (flags[kFLAGS.KATHERINE_UNLOCKED] >= 5) addButton(0, "Kath's Apt", katherine.visitAtHome);
	if (kGAMECLASS.urtaPregs.urtaKids() > 0 && player.hasKeyItem("Spare Key to Urta's House") >= 0)
		addButton(1, "Urta's House", (katherine.isAt(Katherine.KLOC_URTAS_HOME) ? katherine.katherineAtUrtas : kGAMECLASS.urtaPregs.visitTheHouse));
	if (flags[kFLAGS.ARIAN_PARK] >= 4 && !kGAMECLASS.arianScene.arianFollower()) addButton(2,"Arian's",kGAMECLASS.arianScene.visitAriansHouse);
	addButton(3,"Orphanage",orphanage);
	addButton(14,"Back",telAdreMenu);
}

private function piercingStudio():void {
	spriteSelect(63);
	clearOutput();
	outputText("The interior of the piercing studio is earthy, leaving the stone floors and walls uncovered, though the windows are covered with woven blankets, sewn from multicolored threads.  There are a number of cushy chairs facing a wall of mirrors, along with a shelf covered in needles, piercings, and strong alcohols.  A brunette prowls about the place, tidying it up during a lull in business.  You dully notice that unlike everyone else in this town, she's mostly human.  Perhaps she came through a portal as well?  She approaches you, and you see a cat tail waving behind her, and a pair of fuzzy feline ears, both covered in piercings, perched atop her head.  Clearly she's been here long enough to pick up some of the local flavor.\n\n", false);
	outputText("She introduces herself, \"<i>Hello there " + player.mf("sir","cutie") + ", my name is Yara.  Would you like to get a piercing?</i>\"", false);
	menu();
	addButton(0, "Pierce", pierceMenu);
	addButton(1, "Remove", piercingRemove);
	if (!player.hasStatusEffect(StatusEffects.Yara)) {
		addButton(2, "About Her", aboutYara);
	}
	addButton(14, "Leave", telAdreMenu);
}
private function aboutYara():void {
	spriteSelect(63);
	player.createStatusEffect(StatusEffects.Yara,0,0,0,0);
	outputText("You introduce yourself and ask Yara about her past, noting that ", true);
	if (player.humanScore() <= 2) outputText("you were once a human too.", false);
	else outputText("you haven't seen many other humans about.", false);
	outputText("\n\nShe blushes a little when she answers, her tail curling about her protectively, \"<i>My home city was built around a portal, and the Baron that ruled it insisted that we send a sacrifice through every year.  We were raised believing that if we didn't sacrifice SOMEONE, the gods would become angry and bring our city to ruin.  Of course the whole thing was a sham, but the families of those sacrificed get compensation.  My father tried to whore me out first, but when that didn't work, the bastard had me drugged and sacrificed.  I woke up next to a lake, ate some weird fruit when I got hungry, and I... well, I changed.  Thankfully I found my way here before I ran into any demons, or who knows what would have happened to me!  Tel'Adre has been good to me, and I'm sure it'll be good to you.  Now, how about getting a piercing?</i>\"", false);
	dynStats("int", 2, "lus", -5, "cor", -1);
	doNext(piercingStudio);
}
private function pierceMenu():void {
	spriteSelect(63);
	hideUpDown();
	outputText("Yara asks, \"<i>Ok then, what would you like pierced " + player.mf("sir", "cutie") + "?  Just keep in mind my piercings are special - they're permanent and CAN'T be removed.</i>\"", true);
	menu();
	if (player.hasVagina())
	{
		if (player.vaginas[0].clitPierced == 0) {
			addButton(0, "Clit", clitPierce);
		}
	}
	if (player.totalCocks() > 0)
	{
		if (player.cocks[0].pierced == 0) {
			addButton(1, "Dick", dickPierce);
		}
	}
	if (player.earsPierced == 0) {
		addButton(2, "Ears", earPierce);
	}
	if (player.eyebrowPierced == 0) {
		addButton(3, "Eyebrow", eyebrowPierce);
	}
	if (player.lipPierced == 0) {
		addButton(4, "Lip", lipPierce);
	}
	if (player.nipplesPierced == 0) {
		addButton(5, "Nipples", nipplePierce);
	}
	if (player.nosePierced == 0) {
		addButton(6, "Nose", nosePierce);
	}
	if (player.tonguePierced == 0) {
		addButton(7, "Tongue", tonguePierce);
	}
	if (player.hasVagina())
	{
		if (player.vaginas[0].labiaPierced == 0) {
			addButton(8, "Labia", vulvaPierce);
		}
	}
	addButton(14, "Back", piercingStudio);
}

private function dickPierce():void {
	spriteSelect(63);
	if (player.totalCocks() > 0) outputText("\"<i>Ok, this is gonna hurt a LOT, but I've heard good things about it.  What kind of piercing do you want done?</i>\" Yara asks.", true);
	else {
		outputText("You realize you don't have a dick to pierce.  Whoops!  Better pick something else...", true);
		doNext(pierceMenu);
		return;
	}
	piercingLoc = 1;
	menu();
	addButton(0, "Stud", chooseStud);
	addButton(1, "Ring", chooseRing);
	addButton(2, "Ladder", chooseLadder);
	addButton(3, "Back", pierceMenu);
	addButton(4, "Nevermind", piercingStudio);
}

private function clitPierce():void {
	spriteSelect(63);
	if (player.hasVagina()) outputText("\"<i>Ohhh, that's going to be suckably cute!</i>\" exclaims Yara, blushing more than a little. \"<i>What kind of piercing would you like?</i>", true);
	else {
		outputText("You realize you don't have a clit to pierce.  Whoops!  Better pick something else...", true);
		doNext(pierceMenu);
		return;
	}
	piercingLoc = 0;
	menu();
	addButton(0, "Stud", chooseStud);
	addButton(1, "Ring", chooseRing);
	addButton(3, "Back", pierceMenu);
	addButton(4, "Nevermind", piercingStudio);
}

private function earPierce():void {
	spriteSelect(63);
	piercingLoc = 2;
	outputText("\"<i>Okay, just let me get my supplies and we can get started.  What kind of jewelry do you want in them?</i>\" asks Yara.", true);
	menu();
	addButton(0, "Stud", chooseStud);
	addButton(1, "Ring", chooseRing);
	addButton(2, "Hoop", chooseHoop);
	addButton(3, "Back", pierceMenu);
	addButton(4, "Nevermind", piercingStudio);
}

private function eyebrowPierce():void {
	spriteSelect(63);
	piercingLoc = 3;
	outputText("\"<i>Ah, that's a good look!  What do you want there?</i>\" asks Yara.", true);
	menu();
	addButton(0, "Stud", chooseStud);
	addButton(1, "Ring", chooseRing);
	addButton(3, "Back", pierceMenu);
	addButton(4, "Nevermind", piercingStudio);
}

private function lipPierce():void {
	spriteSelect(63);
	piercingLoc = 4;
	outputText("\"<i>Oh my, that'll be HAWT!  What kind of jewelry do you want there?</i>\" asks Yara.", true);
	menu();
	addButton(0, "Stud", chooseStud);
	addButton(1, "Ring", chooseRing);
	addButton(3, "Back", pierceMenu);
	addButton(4, "Nevermind", piercingStudio);
}

private function nipplePierce():void {
	spriteSelect(63);
	piercingLoc = 5;
	outputText("\"<i>Yeah, sure I can do those!  What kind of jewelry do you want there?  I'm partial to nipple-chains myself,</i>\" admits Yara, blushing bright red.", true);
	menu();
	addButton(0, "Stud", chooseStud);
	addButton(1, "Ring", chooseRing);
	addButton(2, "Chain", chooseChain);
	addButton(3, "Back", pierceMenu);
	addButton(4, "Nevermind", piercingStudio);
}

private function nosePierce():void {
	spriteSelect(63);
	piercingLoc = 6;
	outputText("Yara wrinkles her nose in distaste, \"<i>Really?  Well ok, what do you want there?</i>\"", true);
	menu();
	addButton(0, "Stud", chooseStud);
	addButton(1, "Ring", chooseRing);
	addButton(3, "Back", pierceMenu);
	addButton(4, "Nevermind", piercingStudio);
}

private function tonguePierce():void {
	spriteSelect(63);
	piercingLoc = 7;
	outputText("Yara happily purrs, \"<i>Oh my, I bet that'll be fun!  I'm afraid I can only put a stud there though, ok?</i>\"", true);
	menu();
	addButton(0, "Stud", chooseStud);
	addButton(3, "Back", pierceMenu);
	addButton(4, "Nevermind", piercingStudio);
}
private function vulvaPierce():void {
	spriteSelect(63);
	piercingLoc = 8;
	if (player.hasVagina()) outputText("Yara explains, \"<i>This is gonna hurt a lot, but I think you'll love how it feels after.  I know I do!  Now what kind of jewelry do you want down-town?</i>\"", true);
	else {
		outputText("You realize you don't have a pussy to pierce.  Whoops!  Better pick something else...", true);
		doNext(pierceMenu);
		return;
	}
	menu();
	addButton(0, "Stud", chooseStud);
	addButton(1, "Ring", chooseRing);
	addButton(3, "Back", pierceMenu);
	addButton(4, "Nevermind", piercingStudio);
}
private function chooseStud():void {
	piercingType = 1;
	chooseMaterials();
}
private function chooseRing():void {
	piercingType = 2;
	chooseMaterials();
}
private function chooseLadder():void {
	piercingType = 3;
	chooseMaterials();
}
private function chooseHoop():void {
	piercingType = 4;
	chooseMaterials();
}
private function chooseChain():void {
	piercingType = 5;
	chooseMaterials();
}

private function chooseMaterials():void {
	spriteSelect(63);
	outputText("Yara gathers up her materials and says, \"<i>Ok, now what type of material do you want it made from?  Don't worry about price, none of these are that rare, so the piercing will only be 100 gems.  Though I do have some rarer materials; you'll need 1,000 gems to spend if you want to check them out.</i>\"", true);
	if (player.gems < 100) {
		outputText("\n\nYou realize you don't have enough gems to get a piercing.", false);
		doNext(piercingStudio);
		return;
	}
	menu();
	addButton(0, "Amethyst", chooseAmethyst);
	addButton(1, "Diamond", chooseDiamond);
	addButton(2, "Gold", chooseGold);
	addButton(3, "Emerald", chooseEmerald);
	addButton(4, "Jade", chooseJade);
	addButton(5, "Onyx", chooseOnyx);
	addButton(6, "Ruby", chooseRuby);
	addButton(7, "Steel", chooseSteel);
	if (player.gems >= 1000) {
		addButton(8, "Rare Menu", chooseAdvancedMaterials);
	} else {
		addDisabledButton(8, "Rare Menu", "You can't afford this!");
	}
	
	addButton(14, "Back", piercingStudio);
}
private function chooseAmethyst():void {
	piercingMat = 1;
	areYouSure();
}
private function chooseDiamond():void {
	piercingMat = 2;
	areYouSure();
}
private function chooseGold():void {
	piercingMat = 3;
	areYouSure();
}
private function chooseEmerald():void {
	piercingMat = 4;
	areYouSure();
}
private function chooseJade():void {
	piercingMat = 5;
	areYouSure();
}
private function chooseOnyx():void {
	piercingMat = 6;
	areYouSure();
}
private function chooseRuby(): void {
	piercingMat = 7;
	areYouSure();
}
private function chooseSteel():void {
	piercingMat = 8;
	areYouSure();
}
private function chooseLethite():void {
	piercingMat = 9;
	areYouSure();
}
private function chooseFertite():void {
	piercingMat = 10;
	areYouSure();
}
private function chooseFurrite():void {
	piercingMat = 11;
	areYouSure();
}
private function chooseCrimstone():void {
	piercingMat = 12;
	areYouSure();
}
private function chooseIcestone():void {
	piercingMat = 13;
	areYouSure();
}

private function areYouSure():void {
	spriteSelect(63);
	outputText("Yara says, \"<i>Ok, last chance to back out, are you sure you want to go ahead with this?  Remember, once I put it in, it's permanent.</i>\"", true);
	doYesNo(normalPierceAssemble,piercingStudio);
}
	//9. Lethite (Demon Lure)
	//10. Fertite (Fertility Booster)
	//11. Furrite (Attracts Furries)
	//12. Crimstone - + min lust
private function chooseAdvancedMaterials():void {
	spriteSelect(63);
	outputText("Yara goes back into the back and comes out with a gilded tray full of exotic materials.  She hands you a brochure and asks, \"<i>Ok, now what am I going to be working with?</i>\"", true);
	outputText("\n\nThere's a number of materials listed here:", false);
	outputText("\n1. Lethite - Fake lethicite.  While beautiful, it's known to attract demons.", false);
	outputText("\n2. Fertite - A green gem sometimes fished up from the bottom of Mareth's great lake, it is said to enhance the fertility of both genders.", false);
	outputText("\n3. Furrite - This beautiful purple gem is actually crystalized from materials used in hunting lures.  It is said to enhance the wearer's appeal to beast-people.", false);
	outputText("\n4. Crimstone - Crimstone is said to be formed from volcanic fires, and to keep the fires of one's desires burning brightly.", false);
	outputText("\n5. Icestone - Found from the Glacial Rift, this rare gem is said to counter the effects of Crimstone and quell ever-burning desires. This will annihilate some of crimstone magic. Due to its rarity, this costs 2000 gems instead.", false);
	outputText("\n\n<b>DISCLAIMER</b>: Yara's Piercing Studio is not responsible if the piercee's body absorbs any residual magic of these stones, and is not required to resolve any issues if the effects persist beyond removal.</b>", false);
	menu();
	addButton(0, "Lethite", chooseLethite);
	addButton(1, "Fertite", chooseFertite);
	addButton(2, "Furrite", chooseFurrite);
	addButton(3, "Crimstone", chooseCrimstone);
	if (player.gems >= 2000) {
		addButton(4, "Icestone", chooseIcestone);
	} else {
		addDisabledButton(4, "Icestone", "You can't afford this!");
	}
	addButton(14, "Back", chooseMaterials);
}

private function normalPierceAssemble():void {
	spriteSelect(63);
	outputText("Yara makes you comfortable and has you look away while she uses her piercing tools.  It hurts, but she's skilled and before you know it, your piercing is done!", true);
	//1. Amethyst (+1 int, +1 lib)
	//2. Diamond (+2 int, -1 cor)
	//3. Gold (+1 int, +1 sens)
	//4. Emerald (+1 spe)
	//5. Jade (+1 spe, -.5 tou)
	//6. Onyx (+1 tou, -1 spe)
	//7. Ruby (+1 lib, +1 sens)
	//8. Steel (+2 str, -2 int)
	//9. Lethite (Demon Lure)
	//10. Fertite (Fertility Booster)
	//11. Furrite (Attracts Furries)
	//12. Crimsonite (+Min Lust)
	//13. Icestone (-Min Lust)
	//var piercingMat:Number = 0;
	var shortP:String = "";
	var longP:String = "";
	player.gems -= 100;
	if (piercingMat > 8) player.gems -= 900;
	if (piercingMat == 13) player.gems -= 1000;
	statScreenRefresh();
	//set up material description
	switch(piercingMat) {
		case 1:
			shortP += "amethyst ";
			dynStats("int", 1, "lib", 1);
			longP += "Amethyst ";
			break;
		case 2:
			shortP += "diamond ";
			dynStats("int", 2, "cor", -1);
			longP += "Diamond ";
			break;
		case 3:
			shortP += "gold ";
			dynStats("int", 1, "sen", 1);
			longP += "Gold ";
			break;
		case 4:
			shortP += "emerald ";
			dynStats("spe", 1);
			longP += "Emerald ";
			break;
		case 5:
			shortP += "jade ";
			dynStats("tou", -.5, "int", 1, "cor", -1);
			longP += "Jade ";
			break;
		case 6:
			shortP += "onyx ";
			dynStats("tou", 1, "spe", -1);
			longP += "Onyx ";
			break;
		case 7:
			shortP += "ruby ";
			dynStats("lib", 1, "sen", 1);
			longP += "Ruby ";
			break;
		case 8:
			shortP += "steel ";
			dynStats("str", 2,"int", -2);
			longP += "Steel ";
			break;
		case 9:
			shortP += "lethite ";
			if (player.findPerk(PerkLib.PiercedLethite) < 0) player.createPerk(PerkLib.PiercedLethite,0,0,0,0);
			longP += "Lethite ";
			break;
		case 10:
			shortP += "fertite ";
			if (player.findPerk(PerkLib.PiercedFertite) < 0) player.createPerk(PerkLib.PiercedFertite,5,0,0,0);
			else player.addPerkValue(PerkLib.PiercedFertite,1,5);
			longP += "Fertite ";
			break;
		case 11:
			shortP += "furrite ";
			if (player.findPerk(PerkLib.PiercedFurrite) < 0) player.createPerk(PerkLib.PiercedFurrite,0,0,0,0);
			longP += "Furrite ";
			break;
		case 12:
			shortP += "crimstone ";
			if (player.findPerk(PerkLib.PiercedIcestone) >= 0) {
				player.addPerkValue(PerkLib.PiercedIcestone, 1, -5);
				if (player.perkv1(PerkLib.PiercedIcestone) <= 0) player.removePerk(PerkLib.PiercedIcestone);
			}
			else {
				if (player.findPerk(PerkLib.PiercedCrimstone) <= 0) player.createPerk(PerkLib.PiercedCrimstone, 5, 0, 0, 0);
				else player.addPerkValue(PerkLib.PiercedCrimstone, 1, 5);
			}
			longP += "Crimstone ";
			break;
		case 13:
			shortP += "icestone ";
			if (player.findPerk(PerkLib.PiercedCrimstone) >= 0) {
				player.addPerkValue(PerkLib.PiercedCrimstone, 1, -5);
				if (player.perkv1(PerkLib.PiercedCrimstone) <= 0) player.removePerk(PerkLib.PiercedCrimstone);
			}
			else {
				if (player.findPerk(PerkLib.PiercedIcestone) <= 0) player.createPerk(PerkLib.PiercedIcestone, 5, 0, 0, 0);
				else player.addPerkValue(PerkLib.PiercedIcestone, 1, 5);
			}
			longP += "Icestone ";
			break;
	}
	switch(piercingLoc) {
		/*
		0) **Clit (+2 sens)
		1) **Dick (+2 lib) adds the word 'pierced' sometimes to the description
		2) **Ears
		3) **Eyebrow (-.5 def)
		4) **Lip (-.5 def)
		5) **Nipples (+1 sens, +1 lib)
		6) **Nose (+.5 attack)
		7) **Tongue (+1 sens)
		8) **Vulva (+1 sens)*/
		//var piercingLoc:Number = 0;
		case 0:
			shortP += "clit-";
			longP += "clit-";
			dynStats("sen", 2);
			break;
		case 1:
			if (piercingType == 3) break;
			shortP += "cock-";
			longP += "cock-";
			dynStats("lib", 2);
			break;
		case 2:
			shortP += "ear";
			longP += "ear";
			break;
		case 3:
			dynStats("tou", -.5);
			shortP += "eyebrow-";
			longP += "eyebrow-";
			break;
		case 4:
			dynStats("tou", -.5);
			shortP += "lip-";
			longP += "lip-";
			break;
		case 5:
			dynStats("lib", 1, "sen", 1);
			shortP += "nipple-";
			longP += "nipple-";
			break;
		case 6:
			dynStats("str", .5);
			shortP += "nose-";
			longP += "nose-";
			break;
		case 7:
			dynStats("sen", 1);
			shortP += "tongue-";
			longP += "tongue-";
			break;
		case 8:
			dynStats("sen", 1);
			shortP += "labia-";
			longP += "labia-";
			break
	}
	switch(piercingType) {
		//studs
		case 1:
			//multiples
			if (piercingLoc == 2 || piercingLoc == 5 || piercingLoc == 8) {
				shortP += "studs";
				longP += "studs";
			}
			else {
				shortP += "stud";
				longP += "stud";
			}
			break;
		//2. Ring (Called prince albert on dick)
		case 2:
			//multiples
			if (piercingLoc == 2 || piercingLoc == 5 || piercingLoc == 8) {
				shortP += "rings";
				longP += "rings";
			}
			else {
				shortP += "ring";
				longP += "ring";
			}
			break;
		//3. Jacobs Ladder (dick only)
		case 3:
			shortP += "jacob's ladder";
			longP += "jacob's ladder";
			break;
		//4. Hoop (ears/nipples/clit)
		case 4:
			//multiples
			if (piercingLoc == 2 || piercingLoc == 5 || piercingLoc == 8) {
				shortP += "hoops";
				longP += "hoops";
			}
			else {
				shortP += "hoop";
				longP += "hoop";
			}
			break;
		//5. Chain (nipples only)
		case 5:
			shortP += "chain";
			longP += "chain";
			break;
	}
	//Actually assign values to their real storage locations
	switch(piercingLoc) {
		/*
		0) **Clit (+2 sens)
		1) **Dick (+2 lib) adds the word 'pierced' sometimes to the description
		2) **Ears
		3) **Eyebrow (-.5 def)
		4) **Lip (-.5 def)
		5) **Nipples (+1 sens, +1 lib)
		6) **Nose (+.5 attack)
		7) **Tongue (+1 sens)
		8) **Vulva (+1 sens)*/
		//var piercingLoc:Number = 0;
		case 0:
			player.vaginas[0].clitPierced = piercingType;
			player.vaginas[0].clitPShort = shortP;
			player.vaginas[0].clitPLong = longP;
			break;
		case 1:
			player.cocks[0].pierced = piercingType;
			player.cocks[0].pShortDesc = shortP;
			player.cocks[0].pLongDesc = longP;
			break;
		case 2:
			player.earsPierced = piercingType;
			player.earsPShort = shortP;
			player.earsPLong = longP;
			break;
		case 3:
			player.eyebrowPierced = piercingType;
			player.eyebrowPShort = shortP;
			player.eyebrowPLong = longP;
			break;
		case 4:
			player.lipPierced = piercingType;
			player.lipPShort = shortP;
			player.lipPLong = longP;
			break;
		case 5:
			player.nipplesPierced = piercingType;
			player.nipplesPShort = shortP;
			player.nipplesPLong = longP;
			break;
		case 6:
			player.nosePierced = piercingType;
			player.nosePShort = shortP;
			player.nosePLong = longP;
			break;
		case 7:
			player.tonguePierced = piercingType;
			player.tonguePShort = shortP;
			player.tonguePLong = longP;
			break;
		case 8:
			player.vaginas[0].labiaPierced = piercingType;
			player.vaginas[0].labiaPShort = shortP;
			player.vaginas[0].labiaPLong = longP;
			break;
	}
	//Girls
	if (piercingLoc == 8 || piercingLoc == 0) {
		yaraSex();
		return;
	}
	//Dudes
	else if (piercingLoc == 1 && (player.cockThatFits(36) >= 0 || flags[kFLAGS.HYPER_HAPPY])) {
		yaraSex(false);
		return;
	}
	//Piercing shop main menu
	doNext(piercingStudio);
}


private function piercingRemove():void {
	spriteSelect(63);
	hideUpDown();
	menu();
	
	if (player.hasVagina()) {
		if (player.vaginas[0].clitPierced > 0) {
			addButton(0, "Clit", removeClitPierce);
		}
	}
	if (player.totalCocks() > 0) {
		if (player.cocks[0].pierced > 0) {
			addButton(1, "Dick", removeCockPierce);
		}
	}
	if (player.earsPierced > 0) {
		addButton(2, "Ears", removeEarsPierce);
	}
	if (player.eyebrowPierced > 0) {
		addButton(3, "Eyebrow", removeEyebrowPierce);
	}
	var lip:Function = null;
	if (player.lipPierced > 0) {
		addButton(4, "Lip", removeLipPierce);
	}
	if (player.nipplesPierced > 0) {
		addButton(5, "Nipples", removeNipplesPierce);
	}
	if (player.nosePierced > 0) {
		addButton(6, "Nose", removeNosePierce);
	}
	if (player.tonguePierced > 0) {
		addButton(7, "Tongue", removeTonguePierce);
	}
	if (player.hasVagina()) {
		if (player.vaginas[0].labiaPierced > 0) {
			addButton(8, "Labia", removeVulvaPierce);
		}
	}
	outputText("\"<i>Really?</i>\" asks Yara, \"<i>I told you those piercings are permanent!  Well, I suppose they CAN be removed, but you're gonna hurt like hell afterwards.  If you really want me to, I can remove something, but it'll cost you 100 gems for the painkillers and labor.</i>\"", true);
	if (player.gems < 100) {
		outputText("\n\n<b>You do not have enough gems.</b>", false);
		doNext(piercingStudio);
		return;
	}
	if (player.tou < 6) {
		outputText("Yara looks you up and down before refusing you outright, \"<i>You don't look so good " + player.short + ".  I don't think your body could handle it right now.</i>\"", true);
		doNext(piercingStudio);
		return;
	}
	addButton(14, "Back", piercingStudio);
}

private function removeClitPierce():void {
	spriteSelect(63);
	outputText("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	player.vaginas[0].clitPierced = 0;
	player.vaginas[0].clitPShort = "";
	player.vaginas[0].clitPLong = "";
	dynStats("tou", -5);
	player.gems -= 100;
	statScreenRefresh();
	doNext(piercingStudio);
}

private function removeCockPierce():void {
	spriteSelect(63);
	outputText("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	player.cocks[0].pierced = 0;
	player.cocks[0].pShortDesc = "";
	player.cocks[0].pLongDesc = "";
	dynStats("tou", -5);
	player.gems -= 100;
	statScreenRefresh();
	doNext(piercingStudio);
}

private function removeEarsPierce():void {
	spriteSelect(63);
	outputText("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	player.earsPierced = 0;
	player.earsPShort = "";
	player.earsPLong = "";
	dynStats("tou", -5);
	player.gems -= 100;
	statScreenRefresh();
	doNext(piercingStudio);
}

private function removeEyebrowPierce():void {
	spriteSelect(63);
	outputText("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	player.eyebrowPierced = 0;
	player.eyebrowPShort = "";
	player.eyebrowPLong = "";
	dynStats("tou", -5);
	player.gems -= 100;
	statScreenRefresh();
	doNext(piercingStudio);
}

private function removeLipPierce():void {
	spriteSelect(63);
	outputText("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	player.lipPierced = 0;
	player.lipPShort = "";
	player.lipPLong = "";
	dynStats("tou", -5);
	player.gems -= 100;
	statScreenRefresh();
	doNext(piercingStudio);
}

private function removeNipplesPierce():void {
	spriteSelect(63);
	outputText("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	player.nipplesPierced = 0;
	player.nipplesPShort = "";
	player.nipplesPLong = "";
	dynStats("tou", -5);
	player.gems -= 100;
	statScreenRefresh();
	doNext(piercingStudio);
}

private function removeNosePierce():void {
	spriteSelect(63);
	outputText("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	player.nosePierced = 0;
	player.nosePShort = "";
	player.nosePLong = "";
	dynStats("tou", -5);
	player.gems -= 100;
	statScreenRefresh();
	doNext(piercingStudio);
}

private function removeTonguePierce():void {
	spriteSelect(63);
	outputText("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	player.tonguePierced = 0;
	player.tonguePShort = "";
	player.tonguePLong = "";
	dynStats("tou", -5);
	player.gems -= 100;
	statScreenRefresh();
	doNext(piercingStudio);
}

private function removeVulvaPierce():void {
	spriteSelect(63);
	outputText("Yara gives you something to drink and you swiftly black out.  You awake about an hour later, sore and weak, though thankfully not bleeding.", true);
	player.vaginas[0].labiaPierced = 0;
	player.vaginas[0].labiaPShort = "";
	player.vaginas[0].labiaPLong = "";
	dynStats("tou", -5);
	player.gems -= 100;
	statScreenRefresh();
	doNext(piercingStudio);
}

public function oswaldPawn():void {
	spriteSelect(47);
	clearOutput();
	if (!player.hasStatusEffect(StatusEffects.Oswald)) {
		outputText("Upon closer inspection, you realize the pawnbroker appears to be some kind of golden retriever.  He doesn't look entirely comfortable and he slouches, but he manages to smile the entire time.  His appearance is otherwise immaculate, including his classy suit-jacket and tie, though he doesn't appear to be wearing any pants.  Surprisingly, his man-bits are retracted.  ", false);
		if (player.cor < 75) outputText("Who would've thought that seeing someone NOT aroused would ever shock you?", false);
		else outputText("What a shame, but maybe you can give him a reason to stand up straight?", false);
		outputText("  His stand is a disheveled mess, in stark contrast to its well-groomed owner.  He doesn't appear to be selling anything at all right now.\n\n", false);
		outputText("The dog introduces himself as Oswald and gives his pitch, \"<i>Do you have anything you'd be interested in selling?  The name's Oswald, and I'm the best trader in Tel'Adre.</i>\"\n\n", false);
		outputText("(You can sell an item here, but Oswald will not let you buy them back, so be sure of your sales.)", false);
		player.createStatusEffect(StatusEffects.Oswald,0,0,0,0);
	}
	else {
		outputText("You see Oswald fiddling with a top hat as you approach his stand again.  He looks up and smiles, padding up to you and rubbing his furry hands together.  He asks, \"<i>Have any merchandise for me " + player.mf("sir","dear") + "?</i>\"\n\n", false);
	}
	menu();
	addButton(0, "Buy", oswaldBuyMenu);
	addButton(1, "Sell", oswaldPawnMenu);
	switch (flags[kFLAGS.KATHERINE_UNLOCKED]) {
		case 1:
		case 2: addButton(2, "Kath's Alley", katherine.visitKatherine); break;
		case 3: addButton(2, "Safehouse", katherineEmployment.katherineTrainingWithUrta); break;
		case 4: addButton(2, "Kath's Alley", katherineEmployment.postTrainingAlleyDescription); //Appears until Kath gives you her housekeys
		default:
	}
	if (player.hasKeyItem("Carrot") < 0 && flags[kFLAGS.NIEVE_STAGE] == 3) {
		outputText("\n\nIn passing, you mention that you're looking for a carrot.\n\nOswald's tophat tips precariously as his ears perk up, and he gladly announces, \"<i>I happen to have come across one recently - something of a rarity in these dark times, you see.  I could let it go for 500 gems, if you're interested.</i>\"");
		if (player.gems < 500)
			outputText("\n\n<b>You can't afford that!</b>");
		else
			addButton(3, "Buy Carrot", buyCarrotFromOswald);
	}
	addButton(4, "Leave", telAdreMenu);
}

private function buyCarrotFromOswald():void {
	player.gems -= 500;
	statScreenRefresh();
	player.createKeyItem("Carrot",0,0,0,0);
	clearOutput();
	outputText("Gems change hands in a flash, and you're now the proud owner of a bright orange carrot!\n\n(<b>Acquired Key Item: Carrot</b>)");
	menu();
	addButton(0,"Next",oswaldPawn);
}

private function oswaldBuyMenu():void {
	clearOutput();
	var buyMod:Number = 2;
	outputText("You ask if Oswald has anything to sell. He nods and says, \"<i>Certainly. If you don't see anything that interests you, come back tomorrow. We get new stocks of merchandise all the time.</i>\"");
	outputText("\n\n<b><u>Oswald's Prices</u></b>");
	outputText("\n" + ItemType.lookupItem(flags[kFLAGS.BENOIT_1]).longName + ": " + Math.round(buyMod * ItemType.lookupItem(flags[kFLAGS.BENOIT_1]).value));
	outputText("\n" + ItemType.lookupItem(flags[kFLAGS.BENOIT_2]).longName + ": " + Math.round(buyMod * ItemType.lookupItem(flags[kFLAGS.BENOIT_2]).value));
	outputText("\n" + ItemType.lookupItem(flags[kFLAGS.BENOIT_3]).longName + ": " + Math.round(buyMod * ItemType.lookupItem(flags[kFLAGS.BENOIT_3]).value));
	menu();
	addButton(0, flags[kFLAGS.BENOIT_1], oswaldTransactBuy, 1);
	addButton(1, flags[kFLAGS.BENOIT_2], oswaldTransactBuy, 2);
	addButton(2, flags[kFLAGS.BENOIT_3], oswaldTransactBuy, 3);
	addButton(4, "Back", oswaldPawn);
}

private function oswaldTransactBuy(slot:int = 1):void {
	clearOutput();
	var itype:ItemType;
	var buyMod:Number = 2;	
	if (slot == 1) itype = ItemType.lookupItem(flags[kFLAGS.BENOIT_1]);
	else if (slot == 2) itype = ItemType.lookupItem(flags[kFLAGS.BENOIT_2]);
	else itype = ItemType.lookupItem(flags[kFLAGS.BENOIT_3]);
	if (player.gems < int(buyMod * itype.value)) {
		outputText("You consider making a purchase, but you lack the gems to go through with it.");
		doNext(oswaldBuyMenu);
		return;
	}
	outputText("After examining what you've picked out with his fingers, Oswald hands it over, names the price and accepts your gems with a curt nod.\n\n");
	player.gems -= int(buyMod * itype.value);
	statScreenRefresh();
	inventory.takeItem(itype, oswaldBuyMenu);
}
	
private function oswaldPawnMenu(returnFromSelling:Boolean = false):void { //Moved here from Inventory.as
	clearOutput();
	spriteSelect(47);
	outputText("You see Oswald fiddling with a top hat as you approach his stand again.  He looks up and smiles, padding up to you and rubbing his furry hands together.  He asks, \"<i>Have any merchandise for me " + player.mf("sir","dear") + "?</i>\"\n\n");
	outputText("(You can sell an item here, but Oswald will not let you buy them back, so be sure of your sales.  You can shift-click to sell all items in a selected stack.)", false);
	outputText("\n\n<b><u>Oswald's Estimates</u></b>");
	menu();
	var totalItems:int = 0;
	for (var slot:int = 0; slot < 10; slot++) {
		if (player.itemSlots[slot].quantity > 0 && player.itemSlots[slot].itype.value >= 1) {
			outputText("\n" + int(player.itemSlots[slot].itype.value / 2) + " gems for " + player.itemSlots[slot].itype.longName + ".");
			addButton(slot, (player.itemSlots[slot].itype.shortName + " x" + player.itemSlots[slot].quantity), oswaldPawnSell, slot);
			totalItems += player.itemSlots[slot].quantity;
		}
	}
	if (totalItems > 1) addButton(12, "Sell All", oswaldPawnSellAll);
	addButton(14, "Back", oswaldPawn);
}

private function oswaldPawnSell(slot:int):void { //Moved here from Inventory.as
	spriteSelect(47);
	var itemValue:int = int(player.itemSlots[slot].itype.value / 2);
	clearOutput();
	if (flags[kFLAGS.SHIFT_KEY_DOWN] == 1) {
		if (itemValue == 0)
			outputText("You hand over " + num2Text(player.itemSlots[slot].quantity) + " " +  player.itemSlots[slot].itype.shortName + " to Oswald.  He shrugs and says, “<i>Well ok, it isn't worth anything, but I'll take it.</i>”");
		else outputText("You hand over " + num2Text(player.itemSlots[slot].quantity) + " " +  player.itemSlots[slot].itype.shortName + " to Oswald.  He nervously pulls out " + num2Text(itemValue * player.itemSlots[slot].quantity)  + " gems and drops them into your waiting hand.");
		while (player.itemSlots[slot].quantity > 0){
			player.itemSlots[slot].removeOneItem();
			player.gems += itemValue;
		}
	}
	else {
		if (itemValue == 0)
			outputText("You hand over " + player.itemSlots[slot].itype.longName + " to Oswald.  He shrugs and says, “<i>Well ok, it isn't worth anything, but I'll take it.</i>”");
		else outputText("You hand over " + player.itemSlots[slot].itype.longName + " to Oswald.  He nervously pulls out " + num2Text(itemValue) + " gems and drops them into your waiting hand.");
		player.itemSlots[slot].removeOneItem();
		player.gems += itemValue;
	}
	statScreenRefresh();
	doNext(createCallBackFunction(oswaldPawnMenu, true));
}

private function oswaldPawnSellAll():void {
	spriteSelect(47);
	var itemValue:int = 0;
	clearOutput();
	for (var slot:int = 0; slot < 10; slot++) {
		if (player.itemSlots[slot].quantity > 0 && player.itemSlots[slot].itype.value >= 1) {
			itemValue += player.itemSlots[slot].quantity * int(player.itemSlots[slot].itype.value / 2);
			player.itemSlots[slot].quantity = 0;
		}
	}
	outputText("You lay out all the items you're carrying on the counter in front of Oswald.  He examines them all and nods.  Nervously, he pulls out " + num2Text(itemValue) + " gems and drops them into your waiting hand.");
	player.gems += itemValue;
	statScreenRefresh();
	doNext(createCallBackFunction(oswaldPawnMenu, true));
}

private function anotherButton(button:int, nam:String, func:Function, arg:* = -9000):int {
	if (button > 8) return 9;
	addButton(button, nam, func, arg);
	button++;
	return button;
}
private function enterBarTelAdre():void {
	if (isThanksgiving() && flags[kFLAGS.PIG_SLUT_DISABLED] == 0) kGAMECLASS.thanksgiving.pigSlutRoastingGreet();
	else barTelAdre();
}

public function barTelAdre():void {
	// Dominka & Edryn both persist their sprites if you back out of doing anything with them -- I
	// I guess this is good a place as any to catch-all the sprite, because I don't think theres ever a case you get a sprite from just entering the bar?
	spriteSelect( -1);

	hideUpDown();
	var button:int = 0;
	clearOutput();
	if (flags[kFLAGS.LOPPE_DISABLED] == 0 && flags[kFLAGS.LOPPE_MET] == 0 && rand(10) == 0) {
		loppe.loppeFirstMeeting();
		return;
	}
	outputText(images.showImage("location-teladre-thewetbitch"));
	outputText("The interior of The Wet Bitch is far different than the mental picture its name implied.  It looks like a normal tavern, complete with a large central hearth, numerous tables and chairs, and a polished dark wood bar.  The patrons all seem to be dressed and interacting like normal people, that is if normal people were mostly centaurs and dog-morphs of various sub-species.  The atmosphere is warm and friendly, and ");
	if (player.humanScore() <= 3) outputText("despite your altered appearance, ");
	outputText("you hardly get any odd stares.  There are a number of rooms towards the back, as well as a stairway leading up to an upper level.");
	
	scylla.scyllaBarSelectAction(); //Done before anything else so that other NPCs can check scylla.action to see what she's doing
		//Thanks to this function and edryn.edrynHeliaThreesomePossible() the bar menu will always display the same possible options until the game time advances.
		//So it's safe to return to this menu, Helia or Urta can't suddenly disappear or appear just from leaving and re-entering the bar.

	menu();
	//AMILY!
	if (flags[kFLAGS.AMILY_VISITING_URTA] == 1) {
		button = anotherButton(button,"Ask4Amily",kGAMECLASS.followerInteractions.askAboutAmily);
	}
	//DOMINIKA
	if (model.time.hours > 17 && model.time.hours < 20 && flags[kFLAGS.DOMINIKA_STAGE] != -1) {
		button = anotherButton(button,"Dominika",dominika.fellatrixBarApproach);
	}
	//EDRYN!
	if (edryn.pregnancy.type != PregnancyStore.PREGNANCY_TAOTH) { //Edryn is unavailable while pregnant with Taoth
		if (edryn.edrynBar()) {
			if (edryn.pregnancy.isPregnant) {
				if (flags[kFLAGS.EDRYN_PREGNANT_AND_NOT_TOLD_PC_YET] == 0) {
					flags[kFLAGS.EDRYN_PREGNANT_AND_NOT_TOLD_PC_YET] = 1;
					if (flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] == 0) { //Edryn panic appearance! (First time mom)
						outputText("\n\nEdryn smiles when she sees you and beckons you towards her.  Fear and some kind of frantic need are painted across her face, imploring you to come immediately.  Whatever the problem is, it doesn't look like it can wait.", false);
						doNext(edryn.findOutEdrynIsPregnant);
						return;
					}
					else { //Edryn re-preggers appearance!
						outputText("\n\nEdryn smiles at you and yells, \"<i>Guess what " + player.short + "?  I'm pregnant again!</i>\"  There are some hoots and catcalls but things quickly die down.  You wonder if her scent will be as potent as before?", false);				
					}
				}
				else { //Mid-pregnancy appearance
					outputText("\n\nEdryn is seated at her usual table, and chowing down with wild abandon.  A stack of plates is piled up next to her.  Clearly she has been doing her best to feed her unborn child.  She notices you and waves, blushing heavily.", false);
				}
			}
			//Edryn just had a kid and hasn't talked about it!
			else if (flags[kFLAGS.EDRYN_NEEDS_TO_TALK_ABOUT_KID] == 1) {
				outputText("\n\nEdryn the centaur isn't pregnant anymore!  She waves excitedly at you, beckoning you over to see her.  It looks like she's already given birth to your child!", false);
			}
			//Appearance changes if has had kids
			else if (flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] > 0) {
				outputText("\n\nEdryn is seated at her usual place, picking at a plate of greens and sipping a mug of the local mead.  She looks bored until she sees you.  Her expression brightens immediately, and Edryn fiddles with her hair and changes her posture slightly.  You aren't sure if she means to, but her cleavage is prominently displayed in an enticing manner.", false);
			}
			else if (player.statusEffectv1(StatusEffects.Edryn) < 3) {
				outputText("\n\nEdryn, the centauress you met at the gate, is here, sitting down at her table alone and sipping on a glass of wine.  You suppose you could go talk to her a bit.", false);
			}
			else outputText("\n\nEdryn the centauress is here, sipping wine at a table by herself.  She looks up and spots you, her eyes lighting up with happiness.  She gives you a wink and asks if you'll join her.", false);
			button = anotherButton(button,"Edryn",edryn.edrynBarTalk);
		}
	}
	if (flags[kFLAGS.KATHERINE_LOCATION] == Katherine.KLOC_BAR) {
		if (flags[kFLAGS.KATHERINE_UNLOCKED] == 4) { 
			katherine.barFirstEncounter();
			return;
		}
		if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] == 31 && kGAMECLASS.urta.urtaAtBar() && !kGAMECLASS.urta.urtaDrunk() && flags[kFLAGS.URTA_ANGRY_AT_PC_COUNTDOWN] == 0) {
			katherine.barKathUrtaLoveAnnounce();
			return;
		}
		katherine.barDescription();
		button = anotherButton(button, "Katherine", katherine.barApproach);
    }
	//trace("HEL FOLLOWER LEVEL: " + flags[kFLAGS.HEL_FOLLOWER_LEVEL] + " HEL FUCKBUDDY: " + flags[kFLAGS.HEL_FUCKBUDDY] + " HARPY QUEEN DEFEATED: " + flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED]);
	//trace("REDUCED ENCOUNTER RATE (DISPLINED): " + flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE]);
	//HELIA
//	if (player.gender > 0 && model.time.hours >= 14 && rand(2) == 0 && model.time.hours < 20 && (flags[kFLAGS.HEL_FUCKBUDDY] != 0 || kGAMECLASS.helFollower.followerHel()) && !(flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 1 && flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED]== 0)) {
	if (edryn.edrynHeliaThreesomePossible()) {
		edryn.helAppearance();
		button = anotherButton(button,"Helia",edryn.approachHelAtZeBitch);
	}
	//NANCY
	if (auntNancy.auntNancy(false)) {
		auntNancy.auntNancy(true);
		if (flags[kFLAGS.NANCY_MET] > 0) button = anotherButton(button,"Nancy",auntNancy.interactWithAuntNancy);
		else button = anotherButton(button,"Barkeep",auntNancy.interactWithAuntNancy);
	}
	else outputText("\n\nIt doesn't look like there's a bartender working at the moment.", false);

	//NIAMH
	if (model.time.hours >= 8 && model.time.hours <= 16 && flags[kFLAGS.NIAMH_STATUS] == 0) {
		niamh.telAdreNiamh();
		if (flags[kFLAGS.MET_NIAMH] == 0) button = anotherButton(button,"Beer Cat",niamh.approachNiamh);
		else button = anotherButton(button,"Niamh",niamh.approachNiamh);
	}
	//ROGAR #1
	if (flags[kFLAGS.ROGAR_PHASE] == 3 && flags[kFLAGS.ROGAR_DISABLED] == 0 && flags[kFLAGS.ROGAR_FUCKED_TODAY] == 0) {
		button = anotherButton(button,"HoodedFig",kGAMECLASS.swamp.rogar.rogarThirdPhase);
		//Wet Bitch screen text when Ro'gar phase = 3:
		outputText("\n\nYou notice a cloaked figure at the bar, though you're quite unable to discern anything else as its back is turned to you.", false);
	}
	//ROGAR #2
	else if (flags[kFLAGS.ROGAR_PHASE] >= 4 && flags[kFLAGS.ROGAR_DISABLED] == 0 && flags[kFLAGS.ROGAR_FUCKED_TODAY] == 0) {
		button = anotherButton(button,"Rogar",kGAMECLASS.swamp.rogar.rogarPhaseFour);
		//Wet Bitch bar text when Ro'gar phase = 4:
		outputText("\n\nRo'gar is here with his back turned to the door, wearing his usual obscuring cloak.", false);
	}

	switch (scylla.action) { //Scylla - requires dungeon shut down
		case Scylla.SCYLLA_ACTION_FIRST_TALK:
			outputText("\n\nThere is one nun sitting in a corner booth who catches your eye.  She sits straight-backed against the dark, wood chair, her thin waist accentuating the supple curve of her breasts. She's dressed in a black robe that looks a few sizes too small for her hips and wears a black and white cloth over her head.");
			button = anotherButton(button, "Nun", scylla.talkToScylla);
			break;
		case Scylla.SCYLLA_ACTION_ROUND_TWO:
			scylla.scyllaRoundII();
			return;
		case Scylla.SCYLLA_ACTION_ROUND_THREE:
			scylla.scyllaRoundThreeCUM();
			return;
		case Scylla.SCYLLA_ACTION_ROUND_FOUR:
			scylla.scyllaRoundIVGo();
			return;
		case Scylla.SCYLLA_ACTION_MEET_CATS:
			outputText("\n\nIt looks like Scylla is here but getting ready to leave.  You could check and see what the misguided nun is up to.");
			button = anotherButton(button, "Scylla", scylla.Scylla6);
			break;
		case Scylla.SCYLLA_ACTION_ADICTS_ANON:
			outputText("\n\nYou see Scylla's white and black nun's habit poking above the heads of the other patrons.  The tall woman seems unaware of her effect on those around her, but it's clear by the way people are crowding she's acquired a reputation by now.  You're not sure what she's doing, but you could push your way through to find out.");
			button = anotherButton(button, "Scylla", scylla.scyllaAdictsAnonV);
			break;
		case Scylla.SCYLLA_ACTION_FLYING_SOLO:
			outputText("\n\nIt looks like Scylla is milling around here this morning, praying as she keeps an eye out for someone to 'help'.");
			button = anotherButton(button, "Scylla", scylla.scyllasFlyingSolo);
			break;
		default:
	}
	//Nun cat stuff!
	if (katherine.needIntroductionFromScylla()) {
		katherine.catMorphIntr();
		button = anotherButton(button,"ScyllaCats",katherine.katherineGreeting);
	}
	//URTA
	if (kGAMECLASS.urta.urtaAtBar()) {
		//Scylla & The Furries Foursome
		if (scylla.action == Scylla.SCYLLA_ACTION_FURRY_FOURSOME)
		{
			trace("SCYLLA ACTION: " + scylla.action);
			outputText("\n\nScylla’s spot in the bar is noticeably empty. She’s usually around at this time of day, isn’t she? Urta grabs your attention with a whistle and points to a back room with an accompanying wink. Oh... that makes sense. Surely the nun won’t mind a little help with her feeding...");
			button = anotherButton(button,"Back Room",scylla.openTheDoorToFoursomeWivScyllaAndFurries);
		}
		//Urta X Scylla threesome
		if (scylla.action == Scylla.SCYLLA_ACTION_FUCKING_URTA) {
			if (flags[kFLAGS.TIMES_CAUGHT_URTA_WITH_SCYLLA] == 0)
				outputText("\n\n<b>Though Urta would normally be here getting sloshed, her usual spot is completely vacant.  You ask around but all you get are shrugs and giggles.  Something isn't quite right here.  You see an empty bottle of one of her favorite brands of whiskey still rolling on her table, so she can't have been gone long.  Maybe she had guard business, or had to head to the back rooms for something?</b>");
			else
				outputText("\n\nUrta's usual place is vacant, though her table still holds a half-drank mug of something potent and alcoholic.  If it's anything like the last time this happened, she's snuck into a back room with Scylla to relieve some pressure.  It might not hurt to join in...");
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 4;
			button = anotherButton(button, "Back Room", kGAMECLASS.urta.scyllaAndUrtaSittingInATree);
		}
		else if (kGAMECLASS.urta.urtaBarDescript()) {
			if (auntNancy.auntNancy(false) && flags[kFLAGS.URTA_INCUBATION_CELEBRATION] == 0 && kGAMECLASS.urta.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) {
				kGAMECLASS.urtaPregs.urtaIsHappyAboutPregnancyAtTheBar();
				return;
			}
			button = anotherButton(button,"Urta",kGAMECLASS.urta.urtaBarApproach);
		}
	}
	//VALA
	if (vala.purifiedFaerieBitchBar()) button = anotherButton(button,"Vala",vala.chooseValaInBar);

	addButton(14,"Leave",telAdreMenu);
}

/*
private function oldbarTelAdre():void {
	hideUpDown();
	var edryn2:Number = 0;
	var urta2:Function = null;
	var misc1:Function = null;
	var misc1Name:String = "";
	clearOutput();
	if (flags[kFLAGS.LOPPE_DISABLED] == 0 && flags[kFLAGS.LOPPE_MET] == 0 && rand(10) == 0) {
		loppe.loppeFirstMeeting();
		return;
	}
	outputText("The interior of The Wet Bitch is far different than the mental picture its name implied.  It looks like a normal tavern, complete with a large central hearth, numerous tables and chairs, and a polished dark wood bar.  The patrons all seem to be dressed and interacting like normal people, that is if normal people were mostly centaurs and dog-morphs of various sub-species.  The atmosphere is warm and friendly, and ", false);
	if (player.humanScore() <= 3) outputText("despite your altered appearance, ", false);
	outputText("you hardly get any odd stares.  There are a number of rooms towards the back, as well as a stairway leading up to an upper level.", false);
	//Hours of operation decrease after birth
	if (!kGAMECLASS.urtaQuest.urtaBusy()) {
		if (edryn.edrynBar()) {
			//Edryn panic appearance!
			if (flags[kFLAGS.EDRYN_PREGNAT_AND_NOT_TOLD_PC_YET] == 0 && flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] > 0 && flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] == 0) {
				outputText("\n\nEdryn smiles when she sees you and beckons you towards her.  Fear and some kind of frantic need are painted across her face, imploring you to come immediately.  Whatever the problem is, it doesn't look like it can wait.", false);
				doNext(edryn.findOutEdrynIsPregnant);
				flags[kFLAGS.EDRYN_PREGNAT_AND_NOT_TOLD_PC_YET]++;
				return;
			}
			//Edryn re-preggers appearance!
			if (flags[kFLAGS.EDRYN_PREGNAT_AND_NOT_TOLD_PC_YET] == 0 && flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] > 0) {
				flags[kFLAGS.EDRYN_PREGNAT_AND_NOT_TOLD_PC_YET]++;
				outputText("\n\nEdryn smiles at you and yells, \"<i>Guess what " + player.short + "?  I'm pregnant again!</i>\"  There are some hoots and catcalls but things quickly die down.  You wonder if her scent will be as potent as before?", false);
			}
			//Edryn just had a kid and hasn't talked about it!
			else if (flags[kFLAGS.EDRYN_NEEDS_TO_TALK_ABOUT_KID] == 1) {
				outputText("\n\nEdryn the centaur isn't pregnant anymore!  She waves excitedly at you, beckoning you over to see her.  It looks like she's already given birth to your child!", false);
			}
			//Mid-pregnancy appearance
			else if (flags[kFLAGS.EDRYN_PREGNANCY_INCUBATION] > 0) {
				outputText("\n\nEdryn is seated at her usual table, and chowing down with wild abandon.  A stack of plates is piled up next to her.  Clearly she has been doing her best to feed her unborn child.  She notices you and waves, blushing heavily.", false);
			}
			//Appearance changes if has had kids
			else if (flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] > 0) {
				outputText("\n\nEdryn is seated at her usual place, picking at a plate of greens and sipping a mug of the local mead.  She looks bored until she sees you.  Her expression brightens immediately, and Edryn fiddles with her hair and changes her posture slightly.  You aren't sure if she means to, but her cleavage is prominently displayed in an enticing manner.", false);
			}
			else if (player.statusEffectv1(StatusEffects.Edryn) < 3) {
				outputText("\n\nEdryn, the centauress you met at the gate, is here, sitting down at her table alone and sipping on a glass of wine.  You suppose you could go talk to her a bit.", false);
			}
			else outputText("\n\nEdryn the centauress is here, sipping wine at a table by herself.  She looks up and spots you, her eyes lighting up with happiness.  She gives you a wink and asks if you'll join her.", false);
			if (edryn2 == 0) edryn2 = 2257;
		}
	}
	//Nun cat stuff!
	if ((model.time.hours > 8 || model.time.hours < 18) && player.hasKeyItem("Silver Kitty-Bell") >= 0) {
		misc1Name = "ScyllaCats";
		misc1 = katherine.katherineGreeting;
		katherine.catMorphIntr();
	}
	//Scylla - requires dungeon shut down
	if (player.totalCocks() > 0 && flags[kFLAGS.FACTORY_SHUTDOWN] > 0) {
		//Scylla repeat
		//big dick!
		if (player.longestCockLength() >= 12) {
			if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] == 0) {
				outputText("\n\nThere is one nun sitting in a corner booth who catches your eye.  She sits straight-backed against the dark, wood chair, her thin waist accentuating the supple curve of her breasts. She's dressed in a black robe that looks a few sizes too small for her hips and wears a black and white cloth over her head.", false);
				misc1 = scylla.talkToScylla;
				misc1Name = "Nun";
			}
			else if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] == 1 && rand(5) == 0) {
				clearOutput();
				scylla.scyllaRoundII();
				return;
			}
			else if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] == 2 && rand(5) == 0) {
				clearOutput();
				scylla.scyllaRoundThreeCUM();
				return;
			}
			//Round 4 goes here
			else if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] == 3 && rand(5) == 0) {
				scylla.scyllaRoundIVGo();
				return;
			}
			//Round 6 - catscratch!
			else if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] == 5 && rand(5) == 0) {
				outputText("\n\nIt looks like Scylla is here but getting ready to leave.  You could check and see what the misguided nun is up to.", false);
				misc1Name = "Scylla";
				misc1 = scylla.Scylla6;
			}
			//Round 5 - repeatable!
			else if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] >= 4 && (model.time.hours == 18 || model.time.hours == 19)) {
				outputText("\n\nYou see Scylla's white and black nun's habit poking above the heads of the other patrons. The tall woman seems unaware of her effect on those around her, but it's clear by the way people are crowding she's acquired a reputation by now. You're not sure what she's doing, but you could push your way through to find out.", false);
				misc1Name = "Scylla";
				misc1 = scylla.scyllaAdictsAnonV;
			}
			//Round 2.5 Repeatable
			else if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] >= 2 && flags[kFLAGS.FED_SCYLLA_TODAY] == 0 && model.time.hours >= 7 && model.time.hours <= 11) {
				outputText("\n\nIt looks like Scylla is milling around here this morning, praying as she keeps an eye out for someone to 'help'.");
				misc1Name = "Scylla";
				misc1 = scylla.scyllasFlyingSolo;
			}
		}
	}
	if (model.time.hours >= 8 && model.time.hours <= 16 && (misc1 == null || (rand(2) == 0 && misc1 != scylla.Scylla6)) && flags[kFLAGS.NIAMH_STATUS] == 0) {
		niamh.telAdreNiamh();
		if (flags[kFLAGS.MET_NIAMH] == 0) misc1Name = "Beer Cat";
		else misc1Name = "Niamh";
		misc1 = niamh.approachNiamh;
	}
	var hel:Function = null;
	if (player.gender > 0 && model.time.hours >= 14 && rand(2) == 0 && model.time.hours < 20 && flags[kFLAGS.HEL_FUCKBUDDY] == 1 && (!kGAMECLASS.helFollower.followerHel() || flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED] == 1)) {
		edryn.helAppearance();
		hel = edryn.approachHelAtZeBitch;
	}
	//Everyone's favorite Vala!
	var valaChoose:Function = null;
	//Backroom urta
	var backroom:* = 0;
	var backroomT:String = "Backrooms";
	if (vala.purifiedFaerieBitchBar()) valaChoose = vala.chooseValaInBar;
	if (!kGAMECLASS.urtaQuest.urtaBusy() && flags[kFLAGS.AMILY_VISITING_URTA] != 1 && model.time.hours < 15) {
		//Scylla + Urta sitting in a tree
		// SOME COMFORT     FUCKED URTA      NOT PISSED      DRUNK TIME    SCYLLA TO LV4    RANDOM CHANCE  HAS THIS HAPPENED BEFORE? SCYLLA REQS ->
		if (flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] == 0 && flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] > 2 && flags[kFLAGS.TIMES_FUCKED_URTA] > 0 && flags[kFLAGS.URTA_ANGRY_AT_PC_COUNTDOWN] < 1 && (kGAMECLASS.urta.urtaDrunk() || flags[kFLAGS.TIMES_CAUGHT_URTA_WITH_SCYLLA] > 0) && flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] >= 3 && rand(3) == 0 && (flags[kFLAGS.TIMES_CAUGHT_URTA_WITH_SCYLLA] == 0 || (flags[kFLAGS.URTA_BANNED_FROM_SCYLLA] == 0 && flags[kFLAGS.URTA_CONFRONTED_SCYLLA] > 0)) && ((flags[kFLAGS.TIMES_CAUGHT_URTA_WITH_SCYLLA] > 0 && !kGAMECLASS.urta.urtaDrunk()) || player.balls > 0) && player.totalCocks() > 0 && misc1Name != "Scylla") {
			if (flags[kFLAGS.TIMES_CAUGHT_URTA_WITH_SCYLLA] > 0) {
				outputText("\n\nUrta's usual place is vacant, though her table still holds a half-drank glass of water.  If it's anything like the last time this happened, she's snuck into a back room with Scylla to relieve some pressure.  It might not hurt to join in...", false);
			}
			else {
				if (flags[kFLAGS.TIMES_CAUGHT_URTA_WITH_SCYLLA] == 0) {
					outputText("\n\n<b>Though Urta would normally be here getting sloshed, her usual spot is completely vacant.  You ask around but all you get are shrugs and giggles.  Something isn't quite right here.  You see an empty bottle of one of her favorite brands of whiskey still rolling on her table, so she can't have been gone long.  Maybe she had guard business, or had to head to the back rooms for something?</b>", false);
				}
				else {
					outputText("\n\nUrta's usual place is vacant, though her table still holds a half-drank mug of something potent and alcoholic.  If it's anything like the last time this happened, she's snuck into a back room with Scylla to relieve some pressure.  It might not hurt to join in...", false);
				}
			}
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 4;
			if (misc1Name == "Scylla") misc1 = null;
			urta2 = null;
			backroom = kGAMECLASS.urta.scyllaAndUrtaSittingInATree;
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 4;
		}
		else if (kGAMECLASS.urta.urtaBarDescript()) {
			if (flags[kFLAGS.URTA_INCUBATION_CELEBRATION] == 0 && flags[kFLAGS.URTA_INCUBATION] > 0) {
				kGAMECLASS.urtaPregs.urtaIsHappyAboutPregnancyAtTheBar();
				return;
			}
			urta2 = kGAMECLASS.urta.urtaBarApproach;
		}
		else urta2 = null;
	}
	//Ask about Amily!
	if (flags[kFLAGS.AMILY_VISITING_URTA] == 1) {
		backroom = 3187;
		backroomT = "Ask4Amily";
	}
	var dominika2:Number = 0;
	if (model.time.hours > 17 && model.time.hours < 20 && flags[kFLAGS.DOMINIKA_STAGE] != -1) {
		dominika2 = 2739;
		dominika.fellatrixBarAppearance();
	}

	var nancy:Function = null;
	var nancyText:String = "Barkeep";
	if (auntNancy.auntNancy(false)) {
		auntNancy.auntNancy(true);
		if (flags[kFLAGS.NANCY_MET] > 0) nancyText = "Nancy";
		nancy = auntNancy.interactWithAuntNancy;
	}
	else outputText("\n\nIt doesn't look like there's a bartender working at the moment.", false);

	var rogarB:Function = null;
	var rogarT:String = "HoodedFig";
	if (flags[kFLAGS.ROGAR_PHASE] == 3 && flags[kFLAGS.ROGAR_DISABLED] == 0 && flags[kFLAGS.ROGAR_FUCKED_TODAY] == 0) {
		rogarB = kGAMECLASS.swamp.rogar.rogarThirdPhase;
		//Wet Bitch screen text when Ro'gar phase = 3:
		outputText("\n\nYou notice a cloaked figure at the bar, though you're quite unable to discern anything else as its back is turned to you.", false);
	}
	else if (flags[kFLAGS.ROGAR_PHASE] >= 4 && flags[kFLAGS.ROGAR_DISABLED] == 0 && flags[kFLAGS.ROGAR_FUCKED_TODAY] == 0) {
		rogarB = kGAMECLASS.swamp.rogar.rogarPhaseFour;
		rogarT = "Rogar";
		//Wet Bitch bar text when Ro'gar phase = 4:
		outputText("\n\nRo'gar is here with his back turned to the door, wearing his usual obscuring cloak.", false);
	}
	var kath:Number = 0;
	choices("Dominika",dominika2,"Edryn",edryn2,"Hel",hel,misc1Name,misc1,nancyText,nancy,rogarT,rogarB,"Urta",urta2,"Vala",vala,"Backroom",backroom,"Leave",telAdreMenu);
}
*/

//-----------------
//-- TAILOR SHOPPE
//-----------------
public function tailorShoppe():void {
	clearOutput();
	spriteSelect(61);
	outputText("The inside of the tailor's shop is far cleaner than anything else you've seen in the city.  The walls are painted muted gray, and the floor is carpeted with a sprawling, royal blue rug.  After glancing around, you realize WHY the walls and floor are so muted – the quiet backdrop makes the merchandise look even more amazing.  There are racks and racks of clothing, but much of it is plain comfortable clothing, and not worth spending much time investigating.  A high-pitched voice pipes up, \"<i>Can I help you?</i>\"\n\n", false);
	if (!player.hasStatusEffect(StatusEffects.Victoria)) {
		outputText("You turn around, ", false);
		if (player.tallness > 60) outputText("looking for the source, eventually looking down and at a short but busty Corgi dog-girl.  ", false);
		else outputText("coming face to face with a busty Corgi dog-girl.  ", false);
		outputText("She's clearly the tailor judging by her stylish, low-cut clothing and poofy hat.  A monocle perches on her nose, giving her a rather distinguished appearance.  The fashionable wench arches her back, showing off what she's got as she introduces herself, \"<i>Ello love, welcome to my shop.  My name's Victoria, though if you like, you can call me Vicky.  You'll find my clothing to be a cut above the rubbish sold elsewhere.</i>\"", false);
		//Flag as meeting her
		player.createStatusEffect(StatusEffects.Victoria,0,0,0,0);
	}
	else {
		outputText("You turn around to look ", false);
		if (player.tallness > 60) outputText("down ", false);
		outputText("at Victoria the Corgi Tailor.  As usual, she's dressed in a stylish low-cut dress and sporting her feathery hat.", false);
	}
	outputText("\n\n(What do you want to buy?)", false);
	menu();
	addButton(0, armors.CLSSYCL.shortName, buyClothes, armors.CLSSYCL);
	addButton(1, armors.RBBRCLT.shortName, buyClothes, armors.RBBRCLT);
	addButton(2, armors.ADVCLTH.shortName, buyClothes, armors.ADVCLTH);
	addButton(3, armors.TUBETOP.shortName, buyClothes, armors.TUBETOP);

	addButton(5, armors.OVERALL.shortName, buyClothes, armors.OVERALL);
	addButton(6, armors.B_DRESS.shortName, buyClothes, armors.B_DRESS);
	addButton(7, armors.T_BSUIT.shortName, buyClothes, armors.T_BSUIT);
	addButton(8, armors.M_ROBES.shortName, buyClothes, armors.M_ROBES);
	
	addButton(10, armors.LTHRPNT.shortName, buyClothes, armors.LTHRPNT);
	addButton(11, armors.BIMBOSK.shortName, buyClothes, armors.BIMBOSK);
	addButton(12, armors.KIMONO.shortName, buyClothes, armors.KIMONO);
	
	addButton(4, "Next", undergarmentSection);
	addButton(14, "Leave", telAdreMenu);
}
private function undergarmentSection():void {
	menu();
	addButton(0, undergarments.C_BRA.shortName, buyClothes, undergarments.C_BRA);
	addButton(1, undergarments.C_PANTY.shortName, buyClothes, undergarments.C_PANTY);
	addButton(2, undergarments.C_LOIN.shortName, buyClothes, undergarments.C_LOIN);
	addButton(3, undergarments.FUNDOSH.shortName, buyClothes, undergarments.FUNDOSH);
	
	addButton(5, undergarments.FURLOIN.shortName, buyClothes, undergarments.FURLOIN);
	addButton(6, undergarments.GARTERS.shortName, buyClothes, undergarments.GARTERS);
	addButton(7, undergarments.LTX_BRA.shortName, buyClothes, undergarments.LTX_BRA);
	addButton(8, undergarments.LTXSHRT.shortName, buyClothes, undergarments.LTXSHRT);
	
	addButton(10, undergarments.LTXTHNG.shortName, buyClothes, undergarments.LTXTHNG);
	
	addButton(9, "Previous", tailorShoppe);
	addButton(14, "Leave", telAdreMenu);
}

private function buyClothes(itype:ItemType):void {
	clearOutput();
	spriteSelect(61);
	outputText("Victoria nods and pulls a measuring tape off her shoulder.  She moves around you with practiced ease, taking measurements from every conceivable angle.  Thanks to her small stature, it's quite easy for her to take your inseam measurement, though Vicky manages to ", false);
	if (player.biggestCockArea() > 30 || player.totalCocks() > 1) outputText("fondle your bulging package", false);
	else if (player.hasVagina()) outputText("rub against your outer lips", false);
	else outputText("slip a finger along your crotch", false);
	outputText(" more than a few times.  You could swear you catch her licking her lips when she stands up, but she quickly turns away, saying, \"<i>I've got one in the back that should fit perfectly!  Be right with you!</i>\"\n\n", false);
	outputText("She disappears in the back for a few moments, then returns with " + itype.longName + " that looks as if it were tailor-made for you.\n\n", false);
	outputText("\"<i>" + itype.value + " gems and it can be yours,</i>\" she says.  ", false);
	if (player.gems < itype.value) {
		outputText("You count out your gems and realize it's beyond your price range.", false);
		//Goto shop main menu
		doNext(tailorShoppe);
		return;
	}
	//Go to debit/update function or back to shop window
	menu();
	addButton(0, "Yes", debitClothes, itype);
	addButton(1, "No", tailorShoppe);
	if (player.hasCock() && player.lust >= 33) {
		addButton(4, "Flirt", flirtWithVictoria, itype);
	} else {
		addDisabledButton(4, "Flirt");
	}
}

private function debitClothes(itype:ItemType):void {
	spriteSelect(61);
	player.gems -= itype.value;
	statScreenRefresh();
	inventory.takeItem(itype, tailorShoppe);
}

//-----------------
//-- ARMOUR SHOP
//-----------------
public function armorShop():void {
	clearOutput();
	spriteSelect(64);
	outputText("The interior of the armory is blisteringly hot, filled with intense heat from the massive forge dominating the far side of the shop.  The bellows are blowing hard as a tall german-shepherd woman works the forge.  Incredibly, she's wearing nothing aside from a ragged leather apron.  It bulges from the front, barely containing her obscene proportions as it protects them from the heat of her forge.  She pulls a piece of metal from the forge and strikes it a few times with a hammer bigger than your head, then tosses it in a bucket filled with water, steam boiling out of it from the hot metal.  At last, the sweating forgemistress notices you and turns around, her breasts jiggling wildly.\n\n", true);
	//outputText("\"<i>Vat can Yvonne make for you?  Ze platemail?  Or someting a bit lighter?</i>\" she asks you.", false);
	outputText("\"<i>What can I make for you?  Platemail?  Or something that breathes a little easier?</i>\" Yvonne asks, fanning herself.");
	
	menu();
	addButton(0, armors.CHBIKNI.shortName, armorBuy, armors.CHBIKNI);
	addButton(1, armors.FULLCHN.shortName, armorBuy, armors.FULLCHN);
	addButton(2, armors.FULLPLT.shortName, armorBuy, armors.FULLPLT);
	addButton(3, armors.INDECST.shortName, armorBuy, armors.INDECST);
	addButton(4, armors.LTHRROB.shortName, armorBuy, armors.LTHRROB);
	addButton(5, armors.SCALEML.shortName, armorBuy, armors.SCALEML);
	addButton(6, armors.SAMUARM.shortName, armorBuy, armors.SAMUARM);
	addButton(7, shields.BUCKLER.shortName, armorBuy, shields.BUCKLER);
	addButton(8, shields.KITE_SH.shortName, armorBuy, shields.KITE_SH);
	addButton(9, shields.GREATSH.shortName, armorBuy, shields.GREATSH);
	addButton(10, shields.TOWERSH.shortName, armorBuy, shields.TOWERSH);

	if (player.hasKeyItem("Dragon Eggshell") >= 0) {
		outputText("\n\nThough the pieces on display have their arguable attractions, none of them really interest you.  Yvonne taps her foot impatiently.  \"<i>Well, I could make you something to order... if you have any decent materials, cutie.  200 gems.</i>\"");
		if (player.gems < 200) {
			outputText("\n\nYou can't afford that!");
		}
		else addButton(12, "Eggshell", kGAMECLASS.emberScene.getSomeStuff);
	}
	addButton(13, "Flirt", yvonneFlirt);
	addButton(14, "Leave", telAdreMenu);
}
private function armorBuy(itype:ItemType):void {
	spriteSelect(64);
	clearOutput();
	if (itype is Armor) { 
		outputText("Yvonne gives you a serious look, then nods.  She pulls the armor off a rack and makes a few adjustments, banging away with her massive hammer to ensure a perfect fit.  The entire time, she's oblivious to the movements of her massive breasts, accidentally exposing her impressive nipples multiple times.\n\n", false);
		outputText("She finishes and turns to you, smiling broadly, \"<i>Now, that will be " + itype.value + " gems, unless you want to change your mind?</i>\"", false);
	}
	else {
		outputText("Yvonne gives you a serious look, then nods.  She pulls the shield off a rack and shows it to you.\n\n", false);
		outputText("She smiles broadly, \"<i>Now, that will be " + itype.value + " gems, unless you want to change your mind?</i>\"", false);

	}
	if (player.gems < itype.value) {
		outputText("\n\nYou count out your gems and realize it's beyond your price range.", false);
		//Goto shop main menu
		doNext(armorShop);
		return;
	}
	else outputText("\n\nDo you buy it?", false);
	//Go to debit/update function or back to shop window
	doYesNo(curry(debitArmor,itype),armorShop);
}

private function debitArmor(itype:ItemType):void {
	spriteSelect(64);
	clearOutput();
	player.gems -= itype.value;
	statScreenRefresh();
	inventory.takeItem(itype, armorShop);
}

//-----------------
//-- WEAPON SHOP
//-----------------
public function weaponShop():void {
	clearOutput();
	spriteSelect(80);
	outputText("The high pitched ring of a steel hammer slamming into hot metal assaults your ears as you walk up to the stand.  Sparks are flying with every blow the stand's owner strikes on his current work.  The metal is glowing red hot, and the hammer falls with the relentless, practiced precision of an experienced blacksmith's guiding hand.  Thick gray and white fur ruffles as the blacksmith stands up, revealing the details of his form to you.  He's one of the dog-people that inhabits this city, though his fur and ears remind you of a dog one of your friends had growing up called a husky.  The blacksmith is anything but husky.  He's fairly short, but lean and whip-cord tough.  His right arm is far more thickly muscled than his left thanks to his trade, and he walks with a self-assured gait that can only come with age and experience.\n\n", false);

	outputText("His piercing blue eyes meet yours as he notices you, and he barks, \"<i>Buy something or fuck off.</i>\"\n\nWhat do you buy?", false);
	
	menu();
	addButton(0, consumables.W_STICK.shortName, weaponBuy, consumables.W_STICK);
	addButton(0, weapons.CLAYMOR.shortName, weaponBuy, weapons.CLAYMOR);
	addButton(0, weapons.WARHAMR.shortName, weaponBuy, weapons.WARHAMR);
	addButton(0, weapons.KATANA.shortName, weaponBuy, weapons.KATANA);
	addButton(0, weapons.SPEAR.shortName, weaponBuy, weapons.SPEAR);
	addButton(0, weapons.WHIP.shortName, weaponBuy, weapons.WHIP);
	addButton(0, weapons.W_STAFF.shortName, weaponBuy, weapons.W_STAFF);
	addButton(0, weapons.S_GAUNT.shortName, weaponBuy, weapons.S_GAUNT);
	addButton(0, weapons.DAGGER.shortName, weaponBuy, weapons.DAGGER);
	addButton(0, weapons.SCIMITR.shortName, weaponBuy, weapons.SCIMITR);
	addButton(10, weapons.MACE.shortName, weaponBuy, weapons.MACE);
	addButton(11, weapons.FLAIL.shortName, weaponBuy, weapons.FLAIL);
	if (player.hasKeyItem("Sheila's Lethicite") >= 0 || flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] > 0) {
		addButton(13, "ScarBlade", forgeScarredBlade);
	}
	addButton(14, "Leave", telAdreMenu);
}
private function weaponBuy(itype:ItemType):void {
	clearOutput();
	spriteSelect(80);
	outputText("The gruff metal-working husky gives you a slight nod and slams the weapon down on the edge of his stand.  He grunts, \"<i>That'll be " + itype.value + " gems.</i>\"", false);
	if (player.gems < itype.value) {
		outputText("\n\nYou count out your gems and realize it's beyond your price range.", false);
		//Goto shop main menu
		doNext(weaponShop);
		return;
	}
	else outputText("\n\nDo you buy it?\n\n", false);
	//Go to debit/update function or back to shop window
	doYesNo(curry(debitWeapon,itype), weaponShop);
}
private function debitWeapon(itype:ItemType):void {
	spriteSelect(80);
	player.gems -= itype.value;
	statScreenRefresh();
	inventory.takeItem(itype, weaponShop);
}
private function forgeScarredBlade():void {
	if (player.hasKeyItem("Sheila's Lethicite") >= 0) forgeScarredBladeStart();
	//remove Sheila's Lethicite key item, set sheilacite = 3, start sheilaforge timer, increment once per day at 0:00
	else if (model.time.days - flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] < 14) forgeScarredBladeMiddle();
	else if (model.time.days - flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] >= 14) forgeScarredBladeEnd();
}

private function forgeScarredBladeStart():void {
	outputText("The blacksmith turns an appraising eye on you as you approach him without looking at any of the weapons on display.\n\n", true)
	outputText("\"<i>What do you want?</i>\" he says, with characteristic gruffness.\n\n")
	outputText("You pull out the dark purple crystal you received from Sheila and ask if it would be possible to alloy a blade from it.  He doesn't move to take it from your outstretched hand just yet, but you can see a hint of interest in the softening of his features.  \"<i>That's a lethicite.  Where'd you get it?</i>\" asks the smith.\n\n")
	outputText("\"<i>Stole it from a demon,</i>\" you lie.\n\n")
	outputText("He considers for a moment more before responding.  \"<i>Well done, then.</i>\"  At that, he takes the crystal gingerly from your hand.  \"<i>Never worked with this before.  I promise nothing, but come back in two weeks.  I should have an update for you.</i>\"\n\n")
	flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] = model.time.days;
	player.removeKeyItem("Sheila's Lethicite");	
	doNext(weaponShop);
}
private function forgeScarredBladeMiddle():void {
	outputText("The weaponsmith looks up from the forge as you enter.  \"<i>Oh, it's you.  I'm not done yet.</i>\"  With a gesture, he dismisses you.  You can only content yourself with looking at the finished products.\n\n", true);
	doNext(weaponShop);
}
private function forgeScarredBladeEnd():void {
	outputText("The smith looks up as you enter, and you could swear the already-thin, no-nonsense line of his mouth becomes even tighter.  \"<i>It's you.  Come here.</i>\"\n\n", true)
	outputText("Obligingly, you approach him, though the forge's heat is stifling.  \"<i>I finished.  The crystal impregnated the metal easily, but the blade itself... just have a look.</i>\"  He picks up a tatty scabbard from a pile of half-finished weapons and holds it to you - as he does, you notice for the first time the numerous bandages on his hands.  A bit wary, you unsheathe the blade halfway; it hisses against the oiled leather as you draw it.  The revealed form of the weapon is slim, curved rakishly, and glows with an umbral light against the backdrop of the lit forge, but its broad side is covered in deep lines.\n\n")
	outputText("\"<i>Damnedest thing.  I couldn't straighten the blade for the life of me - with every hammer blow it would leap, vibrating, from the anvil, and warp somewhere else, adding a new twist for each one I took out.  After a few failures, I settled for a backsword design and channeled the bending toward the flat edge.  That's not the uncanny bit though.  You can see how sharp it is; the edge fairly shaped itself with just a touch of the grinder.  I haven't honed it - didn't need to.  But when I tried to etch a design just above the hilt, it would slide under the stencil, leaving a gouge on the blade.</i>\"\n\n")
	outputText("Closer examination reveals the veracity of his claim: all the numerous scratches and flaws on the blade have their origins right above the tang, from the smith's abortive attempts at decoration.  Yet though several ugly gashes stop just short of the edge, none of them actually break the perfect arc, as if cutting were all the blade cared about.\n\n")
	outputText("\"<i>Damnedest thing,</i>\" he repeats, breaking your train of thought.  \"<i>Every time the blade slipped, it would twist toward my hands.  It's as if it's alive and eager to find flesh.  Truth be told... I was debating whether to turn it over to the Covenant and tell you the crystal couldn't be used.  But you're here, so take it and go.\"  Giving you barely enough time to sheathe the blade again, he places a strong hand against your back and all-but-pushes you out to the street.\n\n")
	inventory.takeItem(weapons.SCARBLD, finishTakingScarredBlade, weaponShop);
}
private function finishTakingScarredBlade():void {
	flags[kFLAGS.SHEILA_LETHICITE_FORGE_DAY] = -1;
	weaponShop();
}

//-----------------
//-- JEWELRY STORE
//-----------------
public function jewelShopEntry():void {
	clearOutput();
	outputText("You enter the jewelry store. There are large array of rings and necklaces, all stored in thick glass cases. A male lizan sits behind the counter, watching you as you look around the store. He is nude save for his gilded silken loincloth and a gold necklace. His chin is pierced with several gold ring piercings. He also wears a diamond ring on one of his fingers.\n\n", false);
	outputText("<i>\"Welcome to my jewelry store. Here, I sell rings and necklaces. They can make you look great but not only that, I also have special jewelry that may have magical effect on you. The effect stays on until you take them off,\"</i> the lizan says.", false);

	doNext(jewelShopInside);
}

public function jewelShopInside():void {
	clearOutput();
	outputText("<i>So what will it be?</i>", false);
	menu();
	addButton(0, "Normal rings", jewelShopPageI);
	addButton(1, "Special rings", jewelShopPageII);
	addButton(2, "Tier 1 rings", jewelShopPageTier1);
	if (player.level >= 10 || model.time.days >= 100) addButton(3, "Tier 2 rings", jewelShopPageTier2);
	if (player.level >= 20 || model.time.days >= 200) addButton(4, "Tier 3 rings", jewelShopPageTier3);
	addButton(5, "Jewelry box", jewelShopBuyBox);
	addButton(14, "Leave", telAdreMenu);
}

public function jewelShopPageI():void {
	menu();
	var button:int = 0;
	addButton(button++, jewelries.SILVRNG.shortName, jewelBuy, jewelries.SILVRNG);
	addButton(button++, jewelries.GOLDRNG.shortName, jewelBuy, jewelries.GOLDRNG);
	addButton(button++, jewelries.PLATRNG.shortName, jewelBuy, jewelries.PLATRNG);
	addButton(button++, jewelries.DIAMRNG.shortName, jewelBuy, jewelries.DIAMRNG);
	addButton(14, "Back", jewelShopInside);
}
public function jewelShopPageII():void {
	menu();
	var button:int = 0;
	addButton(button++, jewelries.LTHCRNG.shortName, jewelBuy, jewelries.LTHCRNG);
	addButton(button++, jewelries.PURERNG.shortName, jewelBuy, jewelries.PURERNG);
	addButton(14, "Back", jewelShopInside);
}
public function jewelShopPageTier1():void {
	menu();
	var button:int = 0;
	addButton(button++, jewelries.CRIMRN1.shortName, jewelBuy, jewelries.CRIMRN1);
	addButton(button++, jewelries.FERTRN1.shortName, jewelBuy, jewelries.FERTRN1);
	addButton(button++, jewelries.ICE_RN1.shortName, jewelBuy, jewelries.ICE_RN1);
	addButton(button++, jewelries.CRITRN1.shortName, jewelBuy, jewelries.CRITRN1);
	addButton(button++, jewelries.REGNRN1.shortName, jewelBuy, jewelries.REGNRN1);
	addButton(button++, jewelries.LIFERN1.shortName, jewelBuy, jewelries.LIFERN1);
	addButton(button++, jewelries.MYSTRN1.shortName, jewelBuy, jewelries.MYSTRN1);
	addButton(button++, jewelries.POWRRN1.shortName, jewelBuy, jewelries.POWRRN1);
	addButton(14, "Back", jewelShopInside);
}
public function jewelShopPageTier2():void {
	menu();
	var button:int = 0;
	addButton(button++, jewelries.CRIMRN2.shortName, jewelBuy, jewelries.CRIMRN2);
	addButton(button++, jewelries.FERTRN2.shortName, jewelBuy, jewelries.FERTRN2);
	addButton(button++, jewelries.ICE_RN2.shortName, jewelBuy, jewelries.ICE_RN2);
	addButton(button++, jewelries.CRITRN2.shortName, jewelBuy, jewelries.CRITRN2);
	addButton(button++, jewelries.REGNRN2.shortName, jewelBuy, jewelries.REGNRN2);
	addButton(button++, jewelries.LIFERN2.shortName, jewelBuy, jewelries.LIFERN2);
	addButton(button++, jewelries.MYSTRN2.shortName, jewelBuy, jewelries.MYSTRN2);
	addButton(button++, jewelries.POWRRN2.shortName, jewelBuy, jewelries.POWRRN2);
	addButton(14, "Back", jewelShopInside);
}
public function jewelShopPageTier3():void {
	menu();
	var button:int = 0;
	addButton(button++, jewelries.CRIMRN3.shortName, jewelBuy, jewelries.CRIMRN3);
	addButton(button++, jewelries.FERTRN3.shortName, jewelBuy, jewelries.FERTRN3);
	addButton(button++, jewelries.ICE_RN3.shortName, jewelBuy, jewelries.ICE_RN3);
	addButton(button++, jewelries.CRITRN3.shortName, jewelBuy, jewelries.CRITRN3);
	addButton(button++, jewelries.REGNRN3.shortName, jewelBuy, jewelries.REGNRN3);
	addButton(button++, jewelries.LIFERN3.shortName, jewelBuy, jewelries.LIFERN3);
	addButton(button++, jewelries.MYSTRN3.shortName, jewelBuy, jewelries.MYSTRN3);
	addButton(button++, jewelries.POWRRN3.shortName, jewelBuy, jewelries.POWRRN3);
	addButton(14, "Back", jewelShopInside);
}
public function jewelShopBuyBox():void {
	clearOutput();
	if (player.hasKeyItem("Equipment Storage - Jewelry Box") >= 0)
	{
		outputText("<b>You already own a jewelry box!</b>", true)
		doNext(jewelShopInside);
		return;
	}
	outputText("You look around for a while until you see something that catches your eyes. A finely-polished jewelry box sits on table.  You approach the jewelry box and examine it.  The box comes complete with a hinged lid and several small drawers.  The price tag says that it costs 500 gems.\n\n", false);
	outputText("The lizan then walks over to you and asks \"<i>See something you'd like to buy?</i>\" You then ask him about the jewelry box. \n\n", false);
	outputText("\"<i>We have plenty of them. This is a finely crafted box. It's designed to hold nine different rings and amulets. Of course, it's secure! It has combination lock. With the right code, you can unlock it. And it can be yours for only 500 gems!</i>\"\n\n", false);
	outputText("Do you buy it?", false);
	if (player.gems >= 500)
	{
		doYesNo(jewelShopBuyBoxYes, jewelShopBuyBoxNo);
	}
	else
	{
		outputText("\n\nYou count out your gems and realize it's beyond your price range.", false);
		doNext(jewelShopInside);
	}
}	

public function jewelShopBuyBoxYes():void {
	player.gems -= 500;
	statScreenRefresh();
	outputText("You hand over five hundred gems to the lizan. ", true);
	outputText("He then exclaims\"<i>Sold!</i>\" as he hands over the jewelry box to you. You take your time to set the combination and memorize it should you need to access your jewelry box.\n\n", false);
	outputText("<b>Gained Key Item: Jewelry Box!</b>", false)
	player.createKeyItem("Equipment Storage - Jewelry Box", 0, 0, 0, 0);
	doNext(jewelShopInside);
}	
public function jewelShopBuyBoxNo():void {
	outputText("\"<i>No thanks,</i>\" you tell him. \n\n", true);
	outputText("\"<i>Very well. Let me know if you've changed your mind,</i>\" he says.", false);
	doNext(jewelShopInside);
}	

private function jewelBuy(itype:ItemType):void {
	clearOutput();
	outputText("The lizan escorts you and opens the case to retrieve the ring. He shows you the ring. He says \"<i>That will be... uh... " + itype.value + " gems.</i>\"", false);
	if (player.gems < itype.value) {
		outputText("\n\nYou count out your gems and realize it's beyond your price range.", false);
		//Goto shop main menu
		doNext(jewelShopInside);
		return;
	}
	else outputText("\n\nDo you buy it?\n\n", false);
	//Go to debit/update function or back to shop window
	doYesNo(curry(debitJewel, itype), jewelShopInside);
}
private function debitJewel(itype:ItemType):void {
	player.gems -= itype.value;
	statScreenRefresh();
	inventory.takeItem(itype, jewelShopInside);
}

//-----------------
//-- CARPENTRY SHOP
//-----------------
public function carpentryShopEntry():void {
	clearOutput();
	outputText("You enter the shop marked by a sign with hammer and saw symbol painted on it. There are array of tools all hung neatly. A six feet tall zebra-morph stallion stands behind the counter. He appears to be wearing typical lumberjack outfit.\n\n");
	outputText("\"<i>Welcome to my hardware shop dear customer. Feel free to look around,</i>\" he says. \n\n");
	if (flags[kFLAGS.CODEX_ENTRY_ZEBRAS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_ZEBRAS] = 1; //Unlocks codex entry for Zebra. :)
		outputText("<b>New codex entry unlocked: Zebras!</b>")
	}
	doNext(carpentryShopInside);
}

public function carpentryShopInside():void {
	clearOutput();
	outputText("<i>So what will it be?</i>\n\n");
	if (player.hasKeyItem("Carpenter's Toolbox") >= 0) camp.cabinProgress.checkMaterials();
	menu();
	addButton(0, "Buy Nails", carpentryShopBuyNails);
	addButton(1, "Buy Wood", carpentryShopBuyWood);
	addButton(2, "Buy Stones", carpentryShopBuyStone);
	addButton(5, "Sell Nails", carpentryShopSellNails);	
	addButton(6, "Sell Wood", carpentryShopSellWood);
	addButton(7, "Sell Stones", carpentryShopSellStone);
	addButton(10, "Toolbox", carpentryShopBuySet);
	addButton(11, "Nail box", carpentryShopBuyNailbox);
	//addButton(12, "StoneBuildingsGuide", carpentryShopBuySet3);
	addButton(14, "Leave", telAdreMenu);
}
//Buy nails
public function carpentryShopBuyNails():void {
	clearOutput();
	if (player.hasKeyItem("Carpenter's Toolbox") >= 0) {
		outputText("You ask him if he has nails for sale. He replies \"<i>Certainly! I've got nails. Your toolbox can hold up to two hundred nails. I'll be selling nails at a price of two gems per nail.</i>\" \n\n");
		camp.cabinProgress.checkMaterials(1);
		menu();
		addButton(0, "Buy 10", carpentryShopBuyNailsAmount, 10);
		addButton(1, "Buy 25", carpentryShopBuyNailsAmount, 25);
		addButton(2, "Buy 50", carpentryShopBuyNailsAmount, 50);
		addButton(3, "Buy 75", carpentryShopBuyNailsAmount, 75);
		addButton(4, "Buy 100", carpentryShopBuyNailsAmount, 100);
		addButton(14, "Back", carpentryShopInside)
	}
	else {
		outputText("You ask him if he has nails for sale. He replies \"<i>I do. But I'm sorry, my friend. You don't have a toolbox. How are you going to carry nails safely?</i>\" ");
		doNext(carpentryShopInside);
	}
}

private function carpentryShopBuyNailsAmount(amount:int):void {
	clearOutput();
	nails = amount;
	outputText("You ask him for " + amount + " nails. He replies \"<i>That'll be " + (amount * 2) + " gems, please.</i>\" \n\nDo you buy the nails?");
	doYesNo(carpentryShopBuyNailsYes, carpentryShopBuyNails);
}

private function carpentryShopBuyNailsYes():void {
	clearOutput();
	if (player.gems >= (nails * 2)) {
		player.gems -= (nails * 2);
		flags[kFLAGS.ACHIEVEMENT_PROGRESS_HAMMER_TIME] += nails;
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_HAMMER_TIME] >= 300) awardAchievement("Hammer Time", kACHIEVEMENTS.GENERAL_HAMMER_TIME);
		player.addKeyValue("Carpenter's Toolbox", 1, nails);
		outputText("You hand over " + (nails * 2) + " gems. \"<i>Done,</i>\" he says as he hands over bundle of " + nails +" nails to you.\n\n");
		//If over the limit
		if (player.keyItemv1("Carpenter's Toolbox") > camp.cabinProgress.maxNailSupply()) {
			outputText("Unfortunately, your toolbox can't hold anymore nails. You notify him and he refunds you the gems.\n\n");
			player.gems += ((player.keyItemv1("Carpenter's Toolbox") - camp.cabinProgress.maxNailSupply()) * 2);
			player.addKeyValue("Carpenter's Toolbox", 1, -(player.keyItemv1("Carpenter's Toolbox") - camp.cabinProgress.maxNailSupply()));
		}
		camp.cabinProgress.checkMaterials(1);
	}
	else {
		outputText("\"<i>I'm sorry, my friend. You do not have enough gems.</i>\"");
	}
	statScreenRefresh();
	doNext(carpentryShopBuyNails);
}

//Buy wood
public function carpentryShopBuyWood():void {
	clearOutput();
	outputText("You ask him if he has wood for sale. He replies \"<i>Certainly! I've got extra supply of wood. I'll be selling wood at a price of 10 gems per wood plank.</i>\" \n\n");
	camp.cabinProgress.checkMaterials(2);
	menu();
	addButton(0, "Buy 10", carpentryShopBuyWoodAmount, 10);
	addButton(1, "Buy 20", carpentryShopBuyWoodAmount, 20);
	addButton(2, "Buy 30", carpentryShopBuyWoodAmount, 30);
	addButton(3, "Buy 40", carpentryShopBuyWoodAmount, 40);
	addButton(4, "Buy 50", carpentryShopBuyWoodAmount, 50);
	addButton(14, "Back", carpentryShopInside)
}	

private function carpentryShopBuyWoodAmount(amount:int):void {
	clearOutput();
	wood = amount;
	outputText("You ask him for " + amount + " wood planks. He replies \"<i>That'll be " + (amount * 10) + " gems, please.</i>\" \n\nDo you buy the wood?");
	doYesNo(carpentryShopBuyWoodYes, carpentryShopBuyWood);
}

private function carpentryShopBuyWoodYes():void {
	if (player.gems >= (wood * 10)) {
		player.gems -= (wood * 10);
		flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] += wood;
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] >= 100) awardAchievement("I'm No Lumberjack", kACHIEVEMENTS.GENERAL_IM_NO_LUMBERJACK);
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += wood;
		outputText("You hand over " + (wood * 10) + " gems. \"<i>I'll have the caravan deliver the wood to your camp as soon as you leave my shop,</i>\" he says.\n\n");
		//If over the limit
		if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > camp.cabinProgress.maxWoodSupply()) {
			outputText("Unfortunately, your wood supply seem to be full. You inform him. He refunds you the gems.\n\n");
			player.gems += ((flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] - camp.cabinProgress.maxWoodSupply()) * 10);
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] - camp.cabinProgress.maxWoodSupply());
		}
		camp.cabinProgress.checkMaterials(2);
	}
	else {
		outputText("\"<i>I'm sorry, my friend. You do not have enough gems.</i>\"", true);
	}
	statScreenRefresh();
	doNext(carpentryShopBuyWood);
}

//Buy Stones
public function carpentryShopBuyStone():void {
	clearOutput();
	outputText("You ask him if he has stones for sale. He replies \"<i>Certainly! I've got extra supply of stones. I'll be selling stones at a price of 20 gems per stone.</i>\" \n\n");
	camp.cabinProgress.checkMaterials(3);
	menu();
	addButton(0, "Buy 10", carpentryShopBuyStoneAmount, 10);
	addButton(1, "Buy 20", carpentryShopBuyStoneAmount, 20);
	addButton(2, "Buy 30", carpentryShopBuyStoneAmount, 30);
	addButton(3, "Buy 40", carpentryShopBuyStoneAmount, 40);
	addButton(4, "Buy 50", carpentryShopBuyStoneAmount, 50);
	addButton(14, "Back", carpentryShopInside)
}

private function carpentryShopBuyStoneAmount(amount:int):void {
	clearOutput();
	stone = amount;
	outputText("You ask him for " + amount + " stones. He replies \"<i>That'll be " + (amount * 20) + " gems, please.</i>\" \n\nDo you buy the stones?");
	doYesNo(carpentryShopBuyStoneYes, carpentryShopBuyStone);
}

private function carpentryShopBuyStoneYes():void {
	if (player.gems >= (stone * 20)) {
		player.gems -= (stone * 20);
		flags[kFLAGS.ACHIEVEMENT_PROGRESS_YABBA_DABBA_DOO] += stone;
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_YABBA_DABBA_DOO] >= 100) awardAchievement("Yabba Dabba Doo", kACHIEVEMENTS.GENERAL_YABBA_DABBA_DOO);
		flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += stone;
		outputText("You hand over " + (stone * 20) + " gems. \"<i>I'll have the caravan deliver the stones to your camp as soon as you leave my shop,</i>\" he says.\n\n");
		//If over the limit
		if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > camp.cabinProgress.maxStoneSupply()) {
			outputText("Unfortunately, your stone seem to be full. You inform him. He refunds you the gems.\n\n");
			player.gems += ((flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] - camp.cabinProgress.maxStoneSupply()) * 20);
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] - camp.cabinProgress.maxStoneSupply());
		}
		camp.cabinProgress.checkMaterials(3);
	}
	else {
		outputText("\"<i>I'm sorry, my friend. You do not have enough gems.</i>\"");
	}
	statScreenRefresh();
	doNext(carpentryShopBuyStone);
}

//Sell Nails
public function carpentryShopSellNails():void {
	clearOutput();
	outputText("You ask him if he's willing to buy nails from you. He says, \"<i>Certainly! I'll be buying nails at a rate of one gem per nail.</i>\" \n\n");
	camp.cabinProgress.checkMaterials(1);
	menu();
	if (player.keyItemv1("Carpenter's Toolbox") >= 10) addButton(0, "Sell 10", carpentryShopSellNailsAmount, 10);
	if (player.keyItemv1("Carpenter's Toolbox") >= 25) addButton(1, "Sell 25", carpentryShopSellNailsAmount, 25);
	if (player.keyItemv1("Carpenter's Toolbox") >= 50) addButton(2, "Sell 50", carpentryShopSellNailsAmount, 50);
	if (player.keyItemv1("Carpenter's Toolbox") >= 75) addButton(3, "Sell 75", carpentryShopSellNailsAmount, 75);
	if (player.keyItemv1("Carpenter's Toolbox") >= 100) addButton(3, "Sell 100", carpentryShopSellNailsAmount, 100);
	if (player.keyItemv1("Carpenter's Toolbox") > 0) addButton(4, "Sell All", carpentryShopSellNailsAmount, player.keyItemv1("Carpenter's Toolbox"));
	addButton(14, "Back", carpentryShopInside);
}

private function carpentryShopSellNailsAmount(amount:int):void {
	clearOutput();
	nails = amount;
	outputText("You're willing to offer " + num2Text(amount) + " " + (player.keyItemv1("Carpenter's Toolbox") == 1 ? "piece" : "pieces") + " of nails. He replies \"<i>I'll buy that for " + amount + " gems.</i>\" \n\nDo you sell the nails?");
	doYesNo(carpentryShopSellNailsYes, carpentryShopSellNails);
}

private function carpentryShopSellNailsYes():void {
	clearOutput();
	if (player.keyItemv1("Carpenter's Toolbox") >= nails) {
		player.gems += nails;
		player.addKeyValue("Carpenter's Toolbox", 1, -nails);
		outputText("You take " + num2Text(nails) + " " + (player.keyItemv1("Carpenter's Toolbox") ? "piece" : "pieces") + " of nails out of your toolbox and hand them over to the carpenter. \"<i>Deal. Here are " + nails + " gems,</i>\" he says.\n\n");
		camp.cabinProgress.checkMaterials(1);
	}
	else {
		outputText("\"<i>I'm sorry, my friend. You do not have enough nails.</i>\"");
	}
	statScreenRefresh();
	doNext(carpentryShopSellNails);
}

//Sell wood
public function carpentryShopSellWood():void {
	clearOutput();
	outputText("You ask him if he's willing to buy wood from you. He says, \"<i>Certainly! I'll be buying wood at a rate of five gems per piece.</i>\" \n\n");
	camp.cabinProgress.checkMaterials(2);
	menu();
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 1) addButton(0, "Sell 1", carpentryShopSellWoodAmount, 1);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 5) addButton(1, "Sell 5", carpentryShopSellWoodAmount, 5);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 10) addButton(2, "Sell 10", carpentryShopSellWoodAmount, 10);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 25) addButton(3, "Sell 25", carpentryShopSellWoodAmount, 25);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 0) addButton(4, "Sell All", carpentryShopSellWoodAmount, flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES]);
	addButton(14, "Back", carpentryShopInside);
}	

private function carpentryShopSellWoodAmount(amount:int):void {
	clearOutput();
	wood = amount;
	outputText("You're willing to offer " + num2Text(amount) + " " + (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] == 1 ? "piece" : "pieces") + " of wood. He replies \"<i>I'll buy that for " + (amount * 5) + " gems.</i>\" \n\nDo you sell the wood?");
	doYesNo(carpentryShopSellWoodYes, carpentryShopSellWood);
}

private function carpentryShopSellWoodYes():void {
	clearOutput();
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= wood) {
		player.gems += (wood * 5);
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= wood;
		outputText("You sign the permission form for " + num2Text(wood) + " " + (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] == 1 ? "piece" : "pieces") + " of wood to be unloaded from your camp. \"<i>Deal. Here are " + (wood * 5) + " gems,</i>\" he says.\n\n");
		camp.cabinProgress.checkMaterials(2);
	}
	else {
		outputText("\"<i>I'm sorry, my friend. You do not have enough wood.</i>\"");
	}
	statScreenRefresh();
	doNext(carpentryShopSellWood);
}

//Sell Stones
public function carpentryShopSellStone():void {
	clearOutput();
	outputText("You ask him if he's willing to buy stones from you. He says, \"<i>Certainly! I'll be buying stones at a rate of ten gems per piece.</i>\" \n\n");
	camp.cabinProgress.checkMaterials(3);
	menu();
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 1) addButton(0, "Sell 1", carpentryShopSellStoneAmount, 1);
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 5) addButton(1, "Sell 5", carpentryShopSellStoneAmount, 5);
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 10) addButton(2, "Sell 10", carpentryShopSellStoneAmount, 10);
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 25) addButton(3, "Sell 25", carpentryShopSellStoneAmount, 25);
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > 0) addButton(4, "Sell All", carpentryShopSellStoneAmount, flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES]);
	addButton(14, "Back", carpentryShopInside);
}

private function carpentryShopSellStoneAmount(amount:int):void {
	clearOutput();
	stone = amount;
	outputText("You're willing to offer " + num2Text(amount) + " " + (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] == 1 ? "piece" : "pieces") + " of stone. He replies \"<i>I'll buy that for " + (amount * 10) + " gems.</i>\" \n\nDo you sell the stones?");
	doYesNo(carpentryShopSellStoneYes, carpentryShopSellStone);
}

private function carpentryShopSellStoneYes():void {
	clearOutput();
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= stone) {
		player.gems += (stone * 10);
		flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= stone;
		outputText("You sign the permission form for " + num2Text(stone) + " " + (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] == 1 ? "piece" : "pieces") + " of stones to be unloaded from your camp. \"<i>Deal. Here are " + (stone * 10) + " gems,</i>\" he says.\n\n");
		camp.cabinProgress.checkMaterials(3);
	}
	else {
		outputText("\"<i>I'm sorry, my friend. You do not have enough stones.</i>\"");
	}
	statScreenRefresh();
	doNext(carpentryShopSellStone);
}

//Buy toolbox
public function carpentryShopBuySet():void {
	clearOutput();
	if (player.hasKeyItem("Carpenter's Toolbox") >= 0) {
		outputText("<b>You already own a set of carpentry tools!</b>");
		doNext(carpentryShopInside);
		return;
	}
	outputText("You walk around for a while until you see a wooden toolbox. It's filled with assorted tools. One of them is a hammer. Another one is a saw. Even another is an axe. There is a measuring tape. There's even a book with hundreds of pages, all about how to use tools and it even has project instructions! There's also a compartment in the toolbox for nails. Just what you need to build your cabin. \n\n");
	outputText("\"<i>Two hundred gems and it's all yours,</i>\" the shopkeeper says.\n\n");
	if (player.gems >= 200) {
		outputText("Do you buy it?");
		doYesNo(carpentryShopBuySetYes, carpentryShopBuySetNo);
	}
	else {
		outputText("You count out your gems and realize it's beyond your price range.");
		doNext(carpentryShopInside);
	}
}

public function carpentryShopBuySetYes():void {
	player.gems -= 200;
	outputText("You hand over two hundred gems to the shopkeeper. ");
	outputText("\"<i>Here you go,</i>\" he says. You feel so proud to have your own tools for building stuff! \n\n");
	outputText("<b>Gained Key Item: Carpenter's Toolbox!</b>")
	player.createKeyItem("Carpenter's Toolbox", 0, 0, 0, 0);
	statScreenRefresh();
	doNext(carpentryShopInside);
}

public function carpentryShopBuySetNo():void {
	clearOutput();
	outputText("\"<i>No thanks,</i>\" you tell him. \n\n");
	outputText("\"<i>Suit yourself,</i>\" he says as you put the box of tools back where it was.");
	doNext(carpentryShopInside);
}

public function carpentryShopBuyNailbox():void {
	if (player.hasKeyItem("Carpenter's Nail Box") >= 0) {
		outputText("<b>You already own a nail box!</b>");
		doNext(carpentryShopInside);
		return;
	}
	outputText("\n\nYou walk back to where you remember you bought the toolbox. There are nail boxes designed to hold four hundred nails. Certainly, you'll be able to hold more nails and ensure you can keep on building in one trip.");
	outputText("\"<i>Two hundred gems and it's all yours,</i>\" the shopkeeper says.\n\n");
	if (player.gems >= 200) {
		outputText("Do you buy it?");
		doYesNo(carpentryShopBuyNailboxYes, carpentryShopBuyNailboxNo);
	}
	else {
		outputText("You count out your gems and realize it's beyond your price range.");
		doNext(carpentryShopInside);
	}
}

public function carpentryShopBuyNailboxYes():void {
	player.gems -= 200;
	outputText("You hand over two hundred gems to the shopkeeper. ");
	outputText("\"<i>Here you go,</i>\" he says. Now you can hold more nails for your projects! \n\n");
	outputText("<b>Gained Key Item: Carpenter's Nail Box!</b>")
	player.createKeyItem("Carpenter's Nail Box", 400, 0, 0, 0);
	statScreenRefresh();
	doNext(carpentryShopInside);
}

public function carpentryShopBuyNailboxNo():void {
	clearOutput();
	outputText("\"<i>No thanks,</i>\" you tell him. \n\n");
	outputText("\"<i>Suit yourself,</i>\" he says as you put the nail box back where it was.");
	doNext(carpentryShopInside);
}

//StoneBuildingsGuide

private function urtaIsABadass():void {
	flags[kFLAGS.PC_SEEN_URTA_BADASS_FIGHT] = 1;
	clearOutput();
	outputText("There's a commotion in the streets of Tel'Adre.  A dense crowd of onlookers has formed around the center of the street, massed together so tightly that you're unable to see much, aside from the backs the other onlookers' heads.  The sound of blows impacting on flesh can be heard over the crowd's murmuring, alerting you of the fight at the gathering's core.", false);
	menu();
	addButton(0, "Investigate", watchUrtaBeABadass);
	addButton(1, "Who cares?", telAdreMenu);
}

//[Invetigate]
private function watchUrtaBeABadass():void {
	clearOutput();
	kGAMECLASS.urta.urtaSprite();
	outputText("You shoulder past the bulky centaurs, ignore the rough fur of the nearby wolves and hounds as it brushes against you, and press your way through to the center of the crowd.  Eventually the throng parts, revealing the embattled combatants.  A snarling wolf, nearly eight feet tall, towers over Urta.  The comparatively diminutive fox-woman is girded in light leather armor and dripping with sweat.  The larger wolf-man is staggering about, and his dark brown fur is matted with blood.\n\n", false);

	outputText("The bigger canid charges, snarling, with his claws extended.  Urta sidesteps and pivots, her momentum carrying her foot around in a vicious kick.  Her foot hits the side of the beast's knee hard enough to buckle it, and the wolf goes down on his knees with an anguished cry.  Urta slips under his arm and twists, turning his slump into a fall.  A cloud of dust rises from the heavy thud of the beast's body as it slams into the cobblestone street.\n\n", false);

	outputText("Now that it's immobile, you get can get a better look at the defeated combatant, and you're ", false);
	if (player.hasStatusEffect(StatusEffects.Infested)) outputText("aroused", false);
	else if (player.cor < 50) outputText("horrified", false);
	else outputText("confused", false);
	outputText(" by what you see.  A pair of thick, demonic horns curve back over the beast's head, piercing through the bottoms of its wolf-like ears.  Its entire body is covered in rippling muscle, leaving you in no doubt of its strength.  Even with a broken knee, the wolf-man is clearly aroused: protruding from a bloated sheath, his massive dog-dick is fully erect, solid black in color, with an engorged knot.  Small white worms crawl over the surface of his penis, wriggling out of the tip and crawling down the length, leaving trails of slime behind them.\n\n", false);

	outputText("Urta kneels down onto the corrupted wolf's throat, cutting off its air as it foams and struggles under her.  With grim determination, she holds the weakening, demonically-tainted wolf underneath her, leaning all of her body-weight into her knee to keep it down.  It struggles for what seems like ages, but eventually the tainted wolf's eyes roll closed.  Urta nods and rises, watching closely as the beast's breathing resumes.\n\n", false);

	outputText("She barks, \"<i>Get this one outside the walls before he wakes.  I won't have this corrupted filth in our city, and make sure you get the wards updated.  If he manages to find his way back, you sorry excuses for guards will be going out with him.</i>\"\n\n", false);
	outputText("A few dog-morphs in similar armor to Urta approach and lash ropes around the wolf's legs.  They hand a line to a centaur, and together the party begins dragging the unconscious body away.  With the action over, the crowd begins dispersing.  More than a few males nod to Urta respectfully.  She keeps her expression neutral and excuses herself to resume her rounds, wiping her hands off on her armor-studded skirt as she leaves.", false);
	doNext(telAdreMenu);
}

public function gymDesc():void {
	//PREGGO ALERT!
	if (flags[kFLAGS.PC_IS_A_GOOD_COTTON_DAD] + flags[kFLAGS.PC_IS_A_DEADBEAT_COTTON_DAD] == 0 && cotton.pregnancy.isPregnant) {
		cotton.cottonPregnantAlert();
		return;
	}

	clearOutput();
	outputText("Even though Ingnam, your hometown, was a large, prosperous village, you never saw a gym before coming to Tel'Adre.  The structure itself has numerous architectural differences from the surrounding buildings: short, waist-high walls, an arched ceiling supported by simple columns, and a sand-covered floor.  Perhaps the only 'normal' rooms inside are the changing stands and bathrooms, which ", false);
	if (player.cor < 35) outputText("thankfully ", false);
	else if (flags[kFLAGS.PC_FETISH] > 0 || player.cor > 80) outputText("unfortunately ", false);
	outputText("have full sized walls to protect their users' privacy.  A breeze blows by, revealing that the open-air design provides great ventilation.  You note a wall of weights of different sizes and shapes, perfect for building muscle and bulking up.  There are also jogging tracks and even a full-sized, grass-covered track out back for centaurs to run on.  Though some of the equipment seems a bit esoteric in nature, you're sure you can make use of most of this stuff.\n\n", false);

	outputText("Though the gym sees heavy use by the city guard and various citizens, it's not too busy at present.", false);
	//(Add possible character descripts here)
	//(An extraordinarily well-muscled centaur male is by the weights, lifting some huge dumbbells and sweating like crazy.  In true centaur fashion, he's not wearing any clothes, but then again, male centaurs don't have much that regular clothes would hide.)
	//(There's a lizan girl jogging laps on one of the tracks.  She's quite thin, but her muscles have a lean definition to them.  She's wearing a one-piece, spandex leotard that hugs her tight ass and pert, b-cup breasts nicely.)
	outputText("  There's a centauress in a tank-top just inside the doorway with huge, rounded melons and perky nipples, but she merely coughs to get you to look up and says, \"<i>", false);
	if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) outputText("10 gems an hour to use the facilities here, or 500 for a life-time membership.</i>\"  She has her hands on her hips, and it looks you'll have to pay ten gems to actually get to use any of this stuff.", false);
	else outputText("Oh, welcome back " + player.short + ".  Have a nice workout!</i>\"", false);

	if (player.gems < 10 && flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) {
		outputText("\n\n<b>You reach into your pockets for the fee and come up empty.  It looks like you don't have enough money to use the equipment or meet anyone.  Damn!</b>", false);
		//(back to tel'adre streets)
		doNext(telAdreMenu);
		return;
	}
	lottie.lottieAppearance();
	if (flags[kFLAGS.LOPPE_MET] > 0 && flags[kFLAGS.LOPPE_DISABLED] == 0) {
		outputText("\n\nYou spot Loppe the laquine wandering around, towel slung over her shoulder.  When she sees you, she smiles and waves to you and you wave back.");
	}
	if (model.time.hours > 9 && model.time.hours <= 15) heckel.heckelAppearance();
	gymMenu();
}

private function gymMenu():void {
	menu();
	//Core gym interactions
	addButton(0, "ChangeRoom", jasun.changingRoom);
	addButton(1, "Jog", goJogging);
	addButton(2, "LiftWeights", weightLifting);
	//addButton(3, "Go Swimming", goSwimming);
	if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0 && player.gems >= 500)
		addButton(4, "Life Member", buyGymLifeTimeMembership, null, null, null, "Buy lifetime membership for 500 gems? It could save you gems in the long run.", "Lifetime Membership");
	else if (flags[kFLAGS.LIFETIME_GYM_MEMBER] > 0)
		addButtonDisabled(4, "Life Member", "You already have the lifetime membership. So go ahead and use the facilities.", "Lifetime Membership");
	else
		addButtonDisabled(4, "Life Member", "You cannot afford to purchase the lifetime membership for the gym. You need 500 gems.", "Lifetime Membership");
	//NPCs
	if (flags[kFLAGS.PC_IS_A_DEADBEAT_COTTON_DAD] == 0 && cotton.cottonsIntro()) addButton(5, flags[kFLAGS.COTTON_MET_FUCKED] > 0 ? "Cotton" : "Horsegirl", cotton.cottonGreeting);
	if (model.time.hours > 9 && model.time.hours <= 15) addButton(6, flags[kFLAGS.MET_HECKEL] > 0 ? "Heckel" : "Hyena", heckel.greetHeckel);
	if (ifris.ifrisIntro()) addButton(7, flags[kFLAGS.MET_IFRIS] > 0 ? "Ifris" : "Demon-Girl", ifris.approachIfris);
	addButton(8, flags[kFLAGS.LOTTIE_ENCOUNTER_COUNTER] > 0 ? "Lottie" : "Pig-Girl", lottie.lottieAppearance(false));
	if (flags[kFLAGS.LOPPE_MET] > 0 && flags[kFLAGS.LOPPE_DISABLED] == 0) addButton(9, "Loppe", loppe.loppeGenericMeetings);
	if (pablo.pabloIntro() && flags[kFLAGS.PABLO_FREAKED_OUT_OVER_WORMS] != 1) addButton(10, flags[kFLAGS.PABLO_MET] > 0 ? "Pablo" : "Imp?", pablo.approachPablo);
	addButton(14, "Leave", telAdreMenu);
}

private function buyGymLifeTimeMembership():void {
	clearOutput();
	//[Buy LifeTime Membership]
	if (silly()) outputText("You tell \"<i>Shut up and take my gems!</i>\" as you pull out your gem-pouch. \n\n"); //Shut up and take my gems!
	outputText("You fish into your pouches and pull out 500 gems, dumping them into the centaur's hands.  Her eyes widen as she turns and trots towards a counter in the back.  She leans over as she counts, giving you a generous view down her low-cut top at the cleavage she barely bothers to conceal.", false);
	if (player.hasCock()) {
		outputText("  It brings a flush to your face that has nothing to do with exercise.  Maybe you'll be able to con her into some alone time later?", false);
		dynStats("lus", (10+player.lib/10));
	}
	flags[kFLAGS.LIFETIME_GYM_MEMBER] = 1;
	player.gems -= 500;
	statScreenRefresh();
	//[Bring up gym menu]
	gymMenu();
}

private function weightLifting():void {
	clearOutput();
	//Too tired?  Fuck off.
	if (player.fatigue > player.maxFatigue() - 25) {
		outputText("<b>There's no way you could exercise right now - you're exhausted!</b>  ", false);
		if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) outputText("It'd be better to save your money and come back after you've rested.", false);
		doNext(telAdreMenu);
		return;
	}
	//Deduct gems if not a full member.
	if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) {
		player.gems -= 10;
		statScreenRefresh();
	}
	//[Lift Weights] +25 fatigue!
	player.changeFatigue(25);
	//TEXTS!
	outputText("You walk up to the weights and begin your workout.  ", false);
	//(< 25 str)
	if (player.str < 25) outputText("You have to start out on the smaller weights to the left side of the rack due to your strength, but even so, you manage to work up a good burn and a modest sweat.", false);
	//(< 40 str)
	else if (player.str < 40) outputText("You heft a few of the weights and select some of the ones just to the left of the middle.  It doesn't take you long to work up a sweat, but you push on through a variety of exercises that leave your body feeling sore and exhausted.", false);
	//(< 60 str)
	else if (player.str < 60) outputText("You smile when you grip a few of the heavier weights on the rack and start to do some lifts.  With a start, you realize you're probably stronger now than Ingnam's master blacksmith, Ben.  Wow!  This realization fuels you to push yourself even harder, and you spend nearly an hour doing various strength-building exercises with the weights.", false);
	//(<80 str)
	else if (player.str < 80) outputText("You confidently grab the heaviest dumbbells in the place and heft them.  It doesn't take long for you to work up a lather of sweat and feel the burn thrumming through your slowly tiring form.  The workout takes about an hour, but you feel you made some good progress today.", false);
	//(<90)
	else if (player.str < 90) outputText("You grab the heaviest weights they have and launch into an exercise routine that leaves you panting from exertion.  Setting the weights aside, you flex and marvel at yourself – you could probably arm wrestle a minotaur or two and come out victorious!", false);
	//(else)
	else outputText("This place barely has anything left to challenge you, but you take the heaviest weights you can get your mitts on and get to it.  By the time an hour has passed, you've worked up a good sweat, but without heavier weights you probably won't get any stronger.", false);
	//Stat changes HERE!
	if (player.str < 90) dynStats("str", .5);
	if (player.tou < 40) dynStats("tou", .3);
	//Body changes here
	//Muscleness boost!
	outputText(player.modTone(85,5+rand(5)), false);
	outputText("\n\nDo you want to hit the showers before you head back to camp?", false);
	if (flags[kFLAGS.BROOKE_MET] == 1) {
		menu();
		if (flags[kFLAGS.DISABLED_SEX_MACHINE] == 0) {
			addButton(0,"\"Showers\"",sexMachine.exploreShowers);
			addButton(1,"Showers",brooke.repeatChooseShower);
			addButton(4, "Leave", camp.returnToCampUseOneHour);
		}
		else {
			doYesNo(brooke.repeatChooseShower,camp.returnToCampUseOneHour);
		}
	}
	else doYesNo(sexMachine.exploreShowers,camp.returnToCampUseOneHour);
}

private function goJogging():void {
	clearOutput();
	//Too tired?  Fuck off.
	if (player.fatigue > player.maxFatigue() - 30) {
		outputText("<b>There's no way you could exercise right now - you're exhausted!</b>  ", false);
		if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) outputText("It'd be better to save your money and come back after you've rested.", false);
		doNext(telAdreMenu);
		return;
	}
	//Deduct gems if not a full member.
	if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) {
		player.gems -= 10;
		statScreenRefresh();
	}
	//[Jogging] +30 fatigue!
	player.changeFatigue(30);
	//Text!
	outputText("You hit the jogging track, ", false);
	//(<25 tou)
	if (player.tou < 25) outputText("but you get so winded you have to stop after a few minutes.  Determined to improve, you force yourself to stay at a fast walk until you can run again.", false);
	//(<40 tou)
	else if (player.tou < 40) outputText("but your performance isn't that great.  You nearly stop jogging a few times but manage to push through until you're completely exhausted.", false);
	//(<60 tou)
	else if (player.tou < 60) outputText("and you do quite well.  You jog around for nearly an hour, working up a healthy lather of sweat.  Even your " + player.legs() + " tingle and burn with exhaustion.", false);
	//(<80 tou)
	else if (player.tou < 80) outputText("and it doesn't faze you in the slightest.  You run lap after lap at a decent clip, working yourself until you're soaked with sweat and fairly tired.", false);
	//(<90 tou)
	else if (player.tou < 90) outputText("and you have a terrific time.  You can keep yourself just below your sprinting speed for the entire time, though you work up a huge amount of sweat in the process.", false);
	//else)
	else outputText("and it barely challenges you.  You run at a sprint half the time and still don't feel like you're improving in the slightest.  Still, you do manage to burn a lot of calories.", false);
	//Stat changes HERE!
	if (player.spe < 40) dynStats("spe", .3);
	if (player.tou < 90) dynStats("tou", .5);

	//If butt is over 15 guaranteed reduction
	if (player.buttRating >= 15) {
		outputText("\n\nAll that running must have done some good, because your " + player.buttDescript() + " feels a little less bouncy.", false);
		player.buttRating--;
	}
	else {
		if (player.buttRating >= 10 && rand(3) == 0) {
			outputText("\n\nThe jogging really helped trim up your " + player.buttDescript() + ".", false);
			player.buttRating--;
		}
		else if (player.buttRating >= 5 && rand(3) == 0) {
			outputText("\n\nYour " + player.buttDescript() + " seems to have gotten a little bit more compact from the work out.", false);
			player.buttRating--;
		}
		else if (player.buttRating > 1 && rand(4) == 0) {
			outputText("\n\nYour " + player.buttDescript() + " seems to have gotten a little bit more compact from the work out.", false);
			player.buttRating--;
		}
	}//If hips is over 15 guaranteed reduction
	if (player.hipRating >= 15) {
		outputText("\n\nIt feels like your " + player.hipDescript() + " have shed some pounds and narrowed.", false);
		player.hipRating--;
	}
	else {
		if (player.hipRating >= 10 && rand(3) == 0) {
			outputText("\n\nIt feels like your " + player.hipDescript() + " have shed some pounds and narrowed.", false);
			player.hipRating--;
		}
		else if (player.hipRating >= 5 && rand(3) == 0) {
			outputText("\n\nIt feels like your " + player.hipDescript() + " have shed some pounds and narrowed.", false);
			player.hipRating--;
		}
		else if (player.hipRating > 1 && rand(4) == 0) {
			outputText("\n\nIt feels like your " + player.hipDescript() + " have shed some pounds and narrowed.", false);
			player.hipRating--;
		}
	}

	//Thickness decrease!
	outputText(player.modThickness(1,5+rand(2)), false);
	//Muscleness boost!
	outputText(player.modTone(100,2+rand(4)), false);
	outputText("\n\nDo you want to hit the showers before you head back to camp?", false);
	if (flags[kFLAGS.BROOKE_MET] == 1) {
		menu();
		addButton(0,"\"Showers\"",sexMachine.exploreShowers);
		addButton(1,"Showers",brooke.repeatChooseShower);
		addButton(4,"Leave",camp.returnToCampUseOneHour);
	}
	else doYesNo(sexMachine.exploreShowers, camp.returnToCampUseOneHour);
}

private function yaraSex(girl:Boolean = true):void {
	spriteSelect(63);
	clearOutput();
	outputText("Yara makes you comfortable and has you look away while she uses her piercing tools.  It hurts, but she's skilled. Before you know it, your piercing is done!  You move to rise, retaining a bit of modesty", false);
	if (flags[kFLAGS.PC_FETISH] > 0) outputText(" despite the guilty thrill", false);
	outputText(".  \"<i>Hold it,</i>\" Yara commands softly, pressing her hand against your " + player.chestDesc() + " and pushing you back in your chair.  \"<i>Do you think I'll let you get away without some... field testing?</i>\"\n\n", false);

	outputText("She seems intent on getting some loving - would you like to turn her down, or will you let nature run its course?", false);
	//[not at all] [yeah baby]
	menu();
	addButton(0, "Turn down", piercingStudio);
	addButton(1, "Oh yeah!", letsDoYaraSex, girl);
}

private function letsDoYaraSex(girl:Boolean = true):void {
	spriteSelect(63);
	clearOutput();
	var x:Number = player.cockThatFits(36);
	if (flags[kFLAGS.HYPER_HAPPY])
	{
		x = player.cockThatFits(50000);
	}
	else if ((x == -1) && !girl)  // No cock that fits
	{
		if (player.hasVagina()) // But the PC has a vagoo! Swap over to female mode"
		{
			outputText("\"<i>Oh dear, cutie. There is no way I could take that huge cock of yours!</i>\" she says, looking rather crestfallen at your enormous member. \"<i>Oh well</i>\", she sighs. \"<i>I guess I'll just have to explore your feminine side instead</i>\"\n");
			girl = true;

		}
		else
		{
			outputText("\"<i>I'm sorry, cutie. There is no way I could take that huge cock of yours!</i>\" she says, looking rather crestfallen at your enormous member. Maybe come back after you've shrunk it down to a reasonable size?");
			return;
		}
	}
	outputText("Her eyes widen as you begin to ", false);
	if (player.lust < 50) outputText("protest", false);
	else outputText("speak", false);
	outputText(", neatly silencing you with the lust-filled fires simmering in her eyes.  \"<i>Call it quality testing,</i>\" she purrs.  Her free hand runs up and down your inner thigh, the ticklish teasing nearly making your head spin.  Licking her lips in anticipation, Yara wiggles out of her clothes and clambers onto the chair, kneeling on the armrests.  Due to her awkward posture, you find your gaze drifting to her wide-spread legs.  Nestled there, twinkling with a radiant luster, is a golden ring, looped through her already-throbbing clit.  A blush darkens her cheeks as she notices your stare, but she seems almost empowered by it.\n\n", false);

	outputText("Yara's free hand slides down her belly - past the stud in her navel - down to her box.  Using two fingers, she spreads her lips apart, giving you a great view of both her glistening button-piercing and the fleshy recesses past it.  She bites her bottom lip gently", false);
	if (!girl && player.hasCock()) outputText(" as your " + player.cockDescript(x) + " rises to attention, her eyes fixed upon the stiffened tool.  You resist the urge to grab her thin-yet-girlish hips and power into her right then and there, curious enough to allow her teasing.", false);
	else outputText(" as a growing puddle of love stains the cushioned chair.  It takes most of your power to not drag her down and force her face into your box.", false);
	outputText("\n\n", false);

	outputText("She leans forward, planting you with a wet and lingering kiss.  She moves lower, kissing ", false);
	if (player.biggestTitSize() < 1) outputText("your chest", false);
	else outputText("your nipples, one at a time", false);
	outputText(" and smooching your belly.  Even with her racially characteristic flexibility, however, she's not able to get any lower from that angle.  \"<i>Hold this, dear,</i>\" she says somewhat snarkily, pivoting around and resting her ass against your " + player.chestDesc() + ".  In this new posture, Yara can easily have her way with your junk, and by the way her wagging tail keeps bopping you in the face you can tell she's excited.\n\n", false);

	outputText("Not content with simple penetration, it seems, the cat girl gets to work.", false);
	if (player.balls > 0) outputText("  Her dexterous fingertips brush against your " + player.ballsDescriptLight() + ", light and fluttery strokes that send shivers coursing through you.  The near-lack of contact is at least as titillating as the less-subtle Marethians you've come across.", false);
	outputText("  She scoots forward a bit, dragging her soaking cunt down your chest in an effort to reach your crotch.\n\n", false);

	//male
	if (!girl && player.hasCock()) {
		outputText("Yara's pursed lips touch down upon your cockhead, her head tilting from side to side as she vexingly and repeatedly kisses your " + player.cockDescript(x) + ".  However, she abruptly pauses, glancing sidelong at you expectantly.  When you don't immediately respond, she huffs a sigh - onto your dick - and raises her hips level with your nose.  After momentarily getting lost in the bouncing of her tight-yet-jiggly cheeks, you get the message, leaning forward and giving her puffy sex a long and lingering lick.  You're rewarded with a low-pitched and very satisfied groan.  Though you go in for another taste, the shining ring looped through her joy-buzzer attracts your oral attention like a magnet.  Gently as a newborn kitten, your teeth close down on the clit-embedded trinket.  Yara goes absolutely stiff as you begin to softly tug the piercing around, neatly paralyzed by the sensitivity.  Indistinguishable mewling tumbles from her mouth as she attempts to attune herself to your yanking antics.  Her lithe frame spasms in ecstasy, forcing you to release your grip on her, lest something unfortunate happen to her undercarriage.\n\n", false);

		outputText("As soon as you release her from the mind-numbing grasp, she whips her hips forward - spattering your " + player.armorName + " with her downpour of girlcum in the process - and leaning back, hastily lining herself up with your " + player.cockDescript(x) + ".  Only hesitating for a second to leak a bit of lubricant onto your eager shaft, she plummets downwards, not stopping until her ass slams against your pelvis.\n\n", false);

		outputText("Yara takes total control, her death-grip on the armrests giving her full coital maneuverability.  Despite the easy entry, you can't believe how well her sopping-wet folds squeeze against you.  For a long while the only sounds heard are the slapping of her cheeks and the studded-up cat girl's halting pants of pleasure.  \"<i>I wanna say... your new piercing... works like a charm,</i>\" she mutters between throaty groans.\n\n", false);

		outputText("Before you're even allowed to respond, Yara's pace quickens, her finish line in sight.  More than eager to help spur her on, your hands wrap around her slender waist.  She purrs in appreciation of your assistance.  It's not long before, with a victorious and primal scream, she throws all her weight downwards, splattering the mixture of pre-cum and femspunk and actually stinging you a bit with the force of her descent.\n\n", false);

		outputText("The powerful motion is all the motivation your body needs.  Before either of you can even consider the ramifications of an internal ejaculation, your bodies seize up, caught in the familiar grasp of orgasmic bliss.  ", false);

		//([cum quantity time, normal L/M/H/S quantities {IT'S A MARVEL REFERENCE} <no new paragraph>]
		//light and medium
		if (player.cumQ() < 500) outputText("Yara's entire frame spasms as your load paints her private passage with snowy-white seed.  The cat girl writhes happily, arching her spine so far back your eyes nearly meet.\n\nYara dismounts your dick and hops to the ground in one fluid movement.", false);
		//heavy
		else if (player.cumQ() <= 1500) outputText("Yara's belly visibly plumps with the quantity of cum you pour into her, the extra weight bending her over to rest heavily against your " + player.leg() + ".  She purrs happily, patting her distended gut even while the tremors of her own orgasm run through her.\n\nYara lifts herself off you, pressing a hand against her tummy as she somewhat ungracefully steps off the chair.", false);
		//special (super-big)
		else outputText("Her low-pitched ecstatic moans swiftly escalate to piercing shrieks as her taut belly quickly balloons to roughly beach ball-sized in moments.  With a huge effort, she manages to haul herself off your semen-pumping staff, falling back against you.  Sighing contentedly, Yara nestles herself into your " + player.chestDesc() + ", getting comfortable despite the seed drizzling from her overstuffed nethers.  You just sit there for a few minutes, waiting patiently as your ejaculatory rampage ceases.\n\nYara makes a noble attempt to rise that is ultimately thwarted by her huge fluid-filled belly.  Casting a sidelong sheepish grin at you, she giggles nervously.  \"<i>Mind helping me out here, friend?</i>\" she says after a moment's hesitation.  With your assistance, she rises and stands on wobbling feet.  She tries her best to compose herself with your cum still streaming down her thighs, the flow only intensifying as she impatiently presses against the bloated belly.", false);

		outputText("\n\n\"<i>Works like a charm,</i>\" she concludes as you both redress", false);
		if (player.cumQ() > 1500) outputText(", Yara trying her best to fit her clothes over the bump in her midsection", false);
		outputText(".  \"<i>Come back whenever, okay?  I'm sure we can arrange another... appointment!</i>\"", false);
		//ZA ENDO
	}
	//female
	else {
		outputText("A duo of errant forefingers run along the perimeter of your feminine fortress, your signal to prepare for a siege.  Yara reaches down off the side of your seat, pushing on a lever that sends the back of the chair down to about a 30º angle.  She grasps for the armrests of the chair next, promptly lifting her body up and going into what looks like a forward somersault.  Before you can complement the feat, her legs fly up either side of your head.   The only things to have made contact were her nimble feet, gently stroking their way up from your belly, past your chest, off of your shoulders and soaring beyond the back of the chair.  The feline acrobat calls for you to lay your hands open at the sides of the chair, an order you fulfill with due haste.  She wastes no time in seizing your upper arms, causing her body to slide forward off of you.  You return the favor by clasping onto her as well in the same manner, stopping her descent.\n\n", false);

		outputText("Trying to parse out the scene at play here is a fool's errand.  Yara must have done this before as your two sprawled out bodies have stopped in just the right fashion to make both of your fleshy orifices in plain view of one another's faces.  Air escapes your pursed lips as the \"<i>quality testing</i>\" commences on your " + player.vaginaDescript() + ", your kitty comrade going in tongue first towards your silken fringes.  ", false);
		if (player.wetness() >= 3) outputText("She may as well be licking a melting popsicle with how wet your snatch is.", false);
		else outputText("Your relatively dry perimeter makes for an easy target.", false);
		outputText("  Not to be outdone, your ambitious tongue moves in as if it has everything to prove, mirroring your partner's efforts. Both of your lapping endeavors are periodically interrupted by moaning or slight gasps, your grasps on one another only growing more tense.\n\n", false);

		outputText("Yara looks up - down in her case - at your " + player.clitDescript() + ", your feminine fragrance riling her up as if it were catnip. Your work on her box is interrupted as your pleasure buzzer gets the oral shebang of a lifetime, eliciting a knowing laugh from deep within your teammate's throat.  Yara's lucky you redouble your clamp on her arms rather than sending the poor woman sliding to the ground as your body writhes in satisfaction.  But this is war, and you'll be damned if you're weak enough to go straight for the crown jewel as she has. No, you go to town, redefining what it means to eat out a pussy.  Your laborious toil is rewarded as the kitten's assault on your button eases up.  Her hold begins to waver, however, forcing you to yank your prey towards you.  The movement pierces through her contentment, her armlock strengthening as the air fills with the sound of a duo of muffled moans.\n\n", false);

		outputText("Judging by the contortionist's wobbly embrace, you decide it's the perfect time to go in for the kill.  Yara stands no chance as you pounce for her pierced clit, your tongue lodging itself between the loop and her love-button.  It takes all of her willpower to maintain the offensive on your nub nexus while standing firm in her grasp on your arms.  Your oral tugging and teasing proves to be the victor, however, marked by the femspunk making its way right onto your face.  The cocktail combined with the orgasmic-enhanced last ditch effort by Yara on your nether regions triggers your own satisfying outburst.  The chain reaction ends in both your couplings faltering, sending the feline sliding headfirst for the floor.\n\n", false);

		outputText("Her head stops short, though.  Through your gasping relief, you managed to lock onto her legs.  \"<i>Nice... nice catch,</i>\" is about all Yara manages to share before resuming her purring contentment upside down, limp arms spread across the floor.  After a minute or so, the two of you regain some sort of composure, but the spectacular gymnast from before can only bare to slink around on the ground as she reorients herself.  The most you need to do is fix the back of your chair, lifting it to a more comfortable height.  \"<i>Can you spare one more helping hand here, friend?</i>\" Yara requests, now having at least managed to at least sit up straight.  The two of you exchange a knowing glance as you lift the metal-worker back to her feet.", false);
	}
	player.orgasm();
	doNext(piercingStudio);
}


//[Flirt]
private function yvonneFlirt():void {
	spriteSelect(64);
	clearOutput();
	outputText("You step closer, glancing from her bulging, barely contained tits to her pouting lips and expressive, violet eyes.  A shock of sweat-matted auburn hair obscures part of her face, but the tall, buxom blacksmith nervously brushes it aside as she watches.  Once you're close enough to touch, you quietly and sincerely proclaim, \"<i>You're the most beautiful piece of craftsmanship in this entire store.</i>\"");
	outputText("\n\nYvonne steps back, and you swear you can see a blush blooming through her fur, a fiery glow of embarrassment that spreads to the upper curve of her immense mammaries.  She folds her arms over her apron, unintentionally smushing those gigantic tits closer together and deepening her cleavage into a canyon. An immense sigh causes the plush plateau to sway pendulously as Yvonne answers, \"<i>");
	dynStats("lus", (10 + player.lib / 10));
	
	// Brain no want to work out the boolean logic shit here, broken out to ensure it will work as intended.
	if (player.cockTotal() == 0)
	{
		outputText("Sorry, but you don't look like you'd be much fun.");
		outputText("</i>\"");
		doNext(armorShop);
		return;
	}
	else if (player.tallness > 65 && !flags[kFLAGS.LOW_STANDARDS_FOR_ALL])
	{
		outputText("Sorry, but you don't look like you'd be much fun.");
		outputText("</i>\"");
		doNext(armorShop);
		return;
	}
	else if (player.cockThatFits(75) == -1 && !flags[kFLAGS.LOW_STANDARDS_FOR_ALL])
	{
		outputText("Sorry, but you don't look like you'd be much fun.");
		outputText("</i>\"");
		doNext(armorShop);
		return;
	}
	
	if (flags[kFLAGS.YVONNE_FUCK_COUNTER] == 0) outputText("Well, I could use a quick fuck.  If you meant what you said, go change the sign to say 'out' please.");
	else outputText("You want to go again, huh?  I do love working up a sweat...");
	outputText("</i>\"");
	//[Fuck] [Nevermind]
	menu();
	addButton(0, "Fuck Her", fuckYvonneInZeBlacksmith);
	addButton(1, "Nevermind", backOutOfYvonneFuck);
}
//[Nevermind]
private function backOutOfYvonneFuck():void {
	spriteSelect(64);
	clearOutput();
	outputText("You politely decline, not wanting to interrupt her work.  Yvonne sighs and begins to pump the bellows, muttering, \"<i>Then you'd better be buying something!</i>\"");
	doNext(armorShop);
}
//[Fuck]
private function fuckYvonneInZeBlacksmith():void {
	spriteSelect(64);
	clearOutput();
	//X = cock that fits!
	var x:Number = player.cockThatFits(75);
	if (x < 0) x = 0;
	//Used for the new cock stuff
	var y:Number = x + 1;
	outputText("You walk over to the door and find a sign hanging in front of the window.  The side facing indoors has 'out' on it.  There's also a 'closed' sign hanging to the side of the doorframe.  You take the simple wood plaque in hand and flip it over - can't have anybody walking in on your sexual hijinks, can you?");
	outputText("\n\nA fuzzy, calloused hand grabs you by the scuff of the neck, lifts you off the ground and pushes you against the wall, slamming you into it forcefully enough that some weapons hanging nearby rattle dangerously.  A hot puff of breath hits your cheek, Yvonne's wet, canine nose bumping against your ear as she pants in your face.  She closes, and you feel her bare, sweat-soaked breasts sliding up and down your back, holding you up as firmly as her iron grip.  Yvonne's long, smooth tongue licks you from collarbone to chin, lapping up the sweat that's already starting to bead, the heat of the simmering forge-fires and your companion's well-warmed, powerful frame long since getting to you.");
	outputText("\n\nA distinctly feminine scent wafts up to your nostrils, intermingled with the blacksmith's own pungent body-odor, strong enough to make your head swim.  Yvonne's free hand begins removing your [armor], the blacksmith's confident motions suggesting she's had plenty of experience at this.  The aroma of the super-stacked bitch's estrus increases to the point where it nearly overpowers her salty sweat-smell, her nipples pressing hard into your back.  [EachCock] grows hard from the forceful attention, pinned between the wall and your belly.  Finished with your gear, Yvonne nips your neck and says, \"<i>Nice package, ");
	if (player.cockArea(x) < 20) outputText("runt");
	else if (player.cockArea(x) < 40) outputText(player.mf("boy","girl"));
	else if (player.cockArea(x) < 60) outputText("big " + player.mf("boy","girl"));
	else outputText(player.mf("stud","breeder"));
	outputText(".</i>\"");
	outputText("\n\nThe forge-mistress abruptly releases you and steps away, the supporting cushion of her breasts no longer there to help balance you.  After a moment of confused stumbling, you catch yourself and turn around, curious as to just what the buxom bitch is doing.");
	outputText("\n\nYvonne is on the ground on all fours.  Her tail is sticking nearly straight up, waving back and forth excitedly as she presents her curvy rump to you.  Surprisingly, her ass is much less muscular than her upper body, with a pair of pillowy buttcheeks that nearly conceal her soaked cunny from view.  You aren't sure if it's lubricant from her arousal, or sweat from working the forge all day, but Yvonne's thighs are absolutely drenched with moisture; a veritable slip n' slide of wetness that beckons you to bury your bone in the canine's feminine entrance.  She glances back over her shoulder, a submissive glint in her eyes as she begs, \"<i>Come on, be my alpha.  This bitch needs a hot, wet fuck.  Do it!</i>\"  What an odd dichotomy - one moment she's throwing you around, the next, begging to be mounted.  For all her power, it seems Yvonne still wants to be taken as a meek bitch.");
	outputText("\n\nYou sidle up to the larger woman and begin aligning [oneCock] with her mammoth buns, the sweltering, pheromone-laced stink pouring from her body making it difficult not to fall on top of her and rut.  Her huge tits are squished against the floor, squeezing out obscenely to either side of the blacksmith's lithe, muscular torso.  When you push inside, her slick wet cunt squeezes your [cock " + y + "] powerfully but affectionately.  Her potent vaginal muscles work your [cock " + y + "] over, tightly embracing your turgid dickflesh as you begin to fuck her properly, plowing her sweat and love-juice soaked folds even while you struggle to reach up for her incredible breasts.");
	outputText("\n\nYou get a handhold on the soft chest-flesh and begin to massage at what you can find, releasing appreciative moans from your partner.  Unfortunately, her furiously-wagging tail bludgeons you across the nose over and over, and you're forced to block it with one arm so that you can ream her snatch unimpeded by the woman's canine instincts.  She growls, but doesn't stop you.  You can see the muscles in her arms quivering, shaking, struggling to maintain her posture in spite of the overwhelming pleasure your [cock " + y + "] is inflicting upon her poor womanhood.");
	outputText("\n\nA shiver runs through the dog-morph's entire body, culminating in a cock-wringing contraction that ripples through her cunt, milking you with her slippery twat.  It works, and you lean over her prostrate form as you bottom out inside her, her sweat-matted fur smearing your face with her scent as you cum.  ");
	if (player.hasKnot(x)) outputText("Your knot fills, locking you inside her, securely blocking any escape for the jizz you're now filling her depths with.  Yvonne sighs dreamily, \"<i>Just right...</i>\" while spunk slides into her birth canal to infiltrate her womb.[if (cumQuantity > 500) \"  The pearly goop spatters into her womb with egg-inseminating force, filling her beyond her wildest expectations.\"][if (cumQuantity > 1000) \"  The blacksmith cries out in pain and pleasure, her belly rounding with your liquid, taking on a more pregnant, stuffed-silly look.\"][if (cumQuantity > 2000) \"  Thanks to your knot, not a single drop escapes, and soon Yvonne's belly is as fat as her tits, cum-bloated in the extreme, a sloshing auburn tub packed with ivory sperm.\"]");
	else outputText("Your jizz bubbles out to fill her depths, the spunk surging through her as it moves towards her womb.  Yvone sighs dreamily, \"<i>Ahhhh...</i>\" while you empty your [balls] inside her unprotected womanhood.[if (cumQuantity > 500) \"  The pearly goop spatters into her uterus with egg-inseminating force, filling the bitch beyond her wildest expectations.\"][if (cumQuantity > 1000)   The blacksmith cries out in pain and pleasure, her belly rounding with your liquid, looking positively pregnant.  Her twat begins to dribble sperm, creampied beyond belief.][if (cumQuantity > 2000) \"  Unfortunately, as your virility makes itself known, Yvonne's body hits its limit, and jets of ivory spooge squirt from all sides of her cunny, dribbling into a pearly puddle on the floor.\"]");
	//still no new pg
	outputText("  With a thoroughly cream-stuffed twat beneath you, you ");
	if (player.hasKnot(x)) outputText("pop");
	else outputText("pull");
	outputText(" out, accompanied by a exhalation of female pleasure.");
	outputText("\n\nYvonne staggers up on her footpaws, groaning the whole time, a trail of white dribbling on the floor behind her.  Her tail wags happily, and she grabs you, pulling you into her sweaty bosom as she affectionately squeezes your [butt].  You aren't released until you feel dizzy, half-suffocated by her preponderance of breast-tissues and potent pheromones.");
	outputText("\n\nYvonne tosses you your gear, and you dress in a daze.  Before you've completely finished, she's pushing you out into the street, covered in sex-stink and stumbling over your own [feet].  She calls out after you, \"<i>Thanks babe, I gotta mop this mess up!</i>\"");
	player.orgasm();
	dynStats("sen", -1);
	flags[kFLAGS.YVONNE_FUCK_COUNTER]++;
	doNext(camp.returnToCampUseOneHour);
}

//*Typical buy text goes here. Options are now Yes/No/Flirt*
//[Flirt]
private function flirtWithVictoria(itype:ItemType):void {
	clearOutput();
	var x:Number = player.cockThatFits(70);
	if (x < 0) x = player.smallestCockIndex();
	outputText("You take the clothes from her and give them a look over.  Setting them on the counter, you tell her that they're quite nice, but if she's interested you might have something that could fit her quite nicely as well in the back.");

	if (x < 0) {
		outputText("\n\nVictoria smirks and answers, \"<i>I measured your inseam, and what you're packing in there won't fit anywhere in a girl like me.  Maybe some other time, " + player.mf("studmuffin","sweet thing") + ".  Did you actually want to buy something?</i>\"\n\nDo you still want to buy something?");
		doYesNo(curry(debitClothes,itype),tailorShoppe);
		return;
	}
	outputText("\n\nIt takes her a moment to realize just what it is you're suggesting before her face splits into a wide grin.  <i>\"That right?  Well now, you can't say things like that without backin' 'em up, can you?\"</i>  she says with a low chuckle, pressing her curvy body into you.  <i>\"What do you say I close the shop up quick, and you can show me just 'ow nicely you can fit, mm?\"</i>");

	outputText("\n\nGiving your [butt] a squeeze, she hops off to turn the shop's open sign around and locks the door before closing all of the curtains.  Turning back to you, she pushes her ample cleavage up into ");
	if (player.tallness >= 65)
		outputText("your stomach.");
	else if (player.tallness >= 55)
		outputText("your chest.");
	else
		outputText("your face.");
	outputText("  <i>\"Now then,  let's see what you've got!\"</i>  With practiced ease she works the bottom of your [armor] off, revealing [eachCock].  <i>\"Well, well. Looks like I was right about you from the start,\"</i> she says, licking her lips again.  <i>\"Just a taste first, I think...\"</i> Sticking her tongue out once more, she gives your rapidly stiffening dick a long, slow lick from the base up to the tip.  She closes her mouth just around your " + player.cockDescript(x) + ", giving it a few rapid licks before pulling off with a pop.");

	outputText("\n\n<i>\"Oh yes,  I think you'll do rather nicely.  In fact, I think I'm going to give you a special treat.\"</i>  Smirking up at you, the busty dog-girl unbuttons her top just beneath her ample chest.  Before you can puzzle out what it is she's doing, she takes your [cock] and stuffs it into the hole and up through her cleavage");
	if (player.cocks[x].cockLength >= 5)
		outputText(" until the tip is poking out the top");
	outputText(".");
	if (player.cocks[x].cockThickness > 3)
		outputText("  Her face scrunches up uncomfortably for a moment, your girth straining the seams of her shirt.  With a series of loud pops, her buttons all go flying in different directions, letting her ample, creamy flesh bounce free with a bountiful jiggle.  <i>\"Bloody hell, that was my favorite top...\"</i> she whines for a moment before squeezing her chest back together with her hands.");
	else outputText("  She presses her arms inward to increase the pressure on your cock even further, and gives you another wide smile.  <i>\"Ready for this, love?\"</i>");

	outputText("\n\nShe begins to slowly move her disproportionately massive chest up and down your cock, ");
	if (player.cocks[x].cockLength > 5)
		outputText("making sure to give the " + player.cockHead(x) + " a quick suck every time it breaches her mounds.");
	else
		outputText("pressing her mouth down into her ample cleavage so as to give your hidden tip a quick lick every time it draws near.");

	outputText("\n\n<i>\"Hvvng fnn?\"</i>  she asks, pausing her pillowy assault to lick over the end of your pecker once again.  You can only moan in response from the wonderful wet, squishy feeling washing over your sensitive organ.  <i>\"That's what I thought,\"</i> she says, releasing you with a wet pop.");

	outputText("\n\nVicky continues her marshmallowy assault for what feels like hours, slowing down every time you give even the slightest indication that you're about to cum.  <i>\"You might hate me for this now, love, but trust me.  It'll feel so much better once you finally do cum.\"</i>  She may be right, but it's agony to get so close to orgasm only to back away, and then draw close once more.  She's practically driving you crazy with lust with her tantalizingly slow tit-fuck.  As you feel your cum nearly boiling away in your [balls], only to have her back away once again, something inside of you snaps.");

	outputText("\n\nYou wrench your dick free of the confines of her pillowy mounds, and grab her around her plush middle.  She gives a surprised yelp as you nearly throw her against the counter and lift her butt up into the air.  <i>\"Ooooh, someone's excited!\"</i>  she nearly cheers, looking over her shoulder and wagging her plush rear up at you as her tail swishes back and forth, showing that she's nearly as consumed with lust as you are.  Flipping her long skirt up over her back, you violently pull her panties aside before you force your " + player.cockDescript(x) + " deep within her gushing folds.");

	outputText("\n\nShe squeals in surprise and pleasure as she's penetrated, thrusting her ample hips back at you as you begin to pound into her.  Her ass jiggles violently with every thrust, sending ripples through her creamy flesh.  You grip her around her soft middle as you slam against her hips, barely noticing every squeak she makes as her thick thighs are pounded into the side of the counter.  <i>\"Ah!  Oh, Marae, that feels incredible!\"</i>  she nearly screams as her monocle finally loses its grip on her face and goes flying, thankfully landing safely on a pile of scrap cloth.  If you were more sound of mind, you'd probably have dreaded the cost of repairing the broken eyepiece.");

	outputText("\n\nSomehow, miraculously, you're able to hold back long enough to work your hands up her soft body and grip onto her enormous tits, mashing them in your hands as you find her rock-hard nipples.  She seems to be enjoying the rough treatment - quite a bit in fact - as the moment you give her hard nubs a quick tweak you feel her already rather tight pussy clamp down on your cock HARD.  It becomes nearly impossible to move as she cums explosively, screaming incoherently as she sprays your lower body with her liquid pleasure.");

	outputText("\n\nThe sudden resistance is all it takes to finally bring you over the edge, as with a loud roar of your own, you bury yourself deep inside of her still tightly clutching cunt and release.  [if (cumNormal = true) It would seem that what she said earlier was correct.  Your pent-up need surges up through your dick, firing your fertile seed straight into her unprotected womb.  She lets out a submissive whimper as your spurting dick triggers aftershocks within her exhausted body.  At last, her body relaxes, freeing your softening dick.][if (cumMedium = true) Thick, sticky, ropes of your cream fire deep within her grasping pussy, attempting to extinguish the fire you lit within her with your frantic rutting.  She whimpers beneath you as your ejaculation sends another wave of pleasure through her body, which clamps down even harder onto you than before.  Thankfully, it's not long before she releases you once again, going limp on the counter and breathing raggedly.][if (cumHigh = true) Your urethra distends as it funnels your thick, potent seed into the tightly gripping walls of Victoria's pussy.  She clenches down as the white torrent sends her into yet another orgasm, shuddering beneath you as her already thick stomach begins to distend with its load.  Her pussy continues to milk your dick of its load even as she rides the high of her last orgasm, her body desperate to draw out more of your thick cream.  Finally she releases you, your softening dick forced back out with a thick stream of your jizz, which begins to pool out onto the floor.][if (cumVeryHigh = true) You feel your dick swell as it nearly explodes within her, pouring thick streams of your seed deep into her fertile womb.  She lets out another loud squeal as her body clenches down into yet another orgasm, gripping your dick tighter than you ever thought possible as it tries to milk you for all you have.  Her plush stomach visibly distends with its contents as you dump your load within her, lifting her small body up from the surface of the counter somewhat.  Thankfully, her body soon relaxes, releasing your softening prick, which is followed by a thick, white fountain of jizz that soaks your legs and pools out onto the floor.]");
	if (silly()) outputText("[if (cumExtreme = true) You groan loudly as your cock pours gallon after gallon of jizz deep into her spasming pussy.  She screams as another powerful orgasm wracks her body, triggered by the enormous amount of jizz you're shooting into her.  Her belly audibly sloshes with each of her movements as it continues to expand from the enormous amount of fluid you're pumping into her.  She attempts to clutch down on you as tightly as she can, trying to retain your enormous load; but the moment she releases even a little bit, she shoots forward from the enormous pressure of jizz within her, flopping down face-first onto some clothes on the other side of the counter.  Your thick cream continues to shoot up from between her limp legs, almost like a fountain, before gravity pulls it back down and it splatters all over the interior of the store.]");
	else outputText("[if (cumExtreme = true) You groan loudly as your cock pours gallon after gallon of jizz deep into her spasming pussy.  She screams as another powerful orgasm wracks her body, triggered by the enormous amount of jizz you're shooting into her.  Her belly audibly sloshes with each of her movements as it continues to expand from the enormous amount of fluid you're pumping into her.  Thick streams of your seed shoot out all around your dick as she continues to squeeze down on you, trying to keep as much of it inside her massively pregnant-looking belly as possible before she finally releases, squirting your dick back out of her with a pop, followed by a veritable geyser of white. Your entire lower body is painted white as it gushes out, soaking into your clothes and covering the floor as she visibly deflates.]");

	outputText("\n\nFinally, your strength gives out and you fall backwards onto the floor, exhausted.  A few seconds later, Vicky slips backward off of the counter and lands on top of you.  Like you, she's completely unable to move, however unlike you it's more because she is completely insensate.  Her eyes have rolled back into her head and her tongue hangs out as she occasionally mutters something incoherent.");

	outputText("\n\nA few seconds later your body finally gives out completely and you pass out.  You wake up about an hour later, still on the floor with Vicky on the ground near you, leaning up against the counter with her legs splayed, cum still dripping from her used pussy.  <i>\"I uh... s'pose you wanna leave now?\"</i>  She asks, still sounding a bit loopy.  She climbs unsteadily to her feet, and walks, a bit bowlegged to the door, unlocking it before slumping back down the wall.  <i>\"Do come back for a visit, love!\"</i>  You pull your pants back up and crawl back out into the street.  Climbing back to your feet, you notice a few passersby chuckling at you before you close the door.  Before you leave, you think you can make out Victoria muttering, <i>\"Gonna have to clean this place up...\"</i>");

	player.orgasm();
	dynStats("sen", -1);
	doNext(camp.returnToCampUseOneHour);
}
}
}
