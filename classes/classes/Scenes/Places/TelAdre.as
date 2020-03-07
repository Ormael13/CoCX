package classes.Scenes.Places {
import classes.*;
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armor;
import classes.Scenes.Dungeons.DeepCave.ValaScene;
import classes.Scenes.Holidays;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.Places.TelAdre.*;
import classes.Scenes.SceneLib;

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



public function discoverTelAdre():void {
	clearOutput();
	if(!player.hasStatusEffect(StatusEffects.TelAdre)) {
		outputText("The merciless desert sands grind uncomfortably under your [feet] as you walk the dunes, searching the trackless sands to uncover their mysteries.  All of a sudden, you can see the outline of a small city in the distance, ringed in sandstone walls.  Strangely it wasn't there a few moments before.  It's probably just a mirage brought on by the heat.  Then again, you don't have any specific direction you're heading, what could it hurt to go that way?");
		outputText("\n\nDo you investigate the city in the distance?");
	}
	else {
		outputText("While out prowling the desert dunes you manage to spy the desert city of Tel'Adre again.  You could hike over to it again, but some part of you fears being rejected for being 'impure' once again.  Do you try?");
	}
	doYesNo(encounterTelAdre,camp.returnToCampUseOneHour);
}

//player chose to approach the city in the distance
private function encounterTelAdre():void {
	clearOutput();
	if(!player.hasStatusEffect(StatusEffects.TelAdre)) {
		outputText("You slog through the shifting sands for a long time, not really seeming to get that close.  Just when you're about to give up, you crest a large dune and come upon the walls of the city you saw before.  It's definitely NOT a mirage.  There are sandstone walls at least fifty feet tall ringing the entire settlement, and the only entrance you can see is a huge gate with thick wooden doors.  The entrance appears to be guarded by a female gray fox who's more busy sipping on something from a bottle than watching the desert.\n\n");
		outputText("As if detecting your thoughts, she drops the bottle and pulls out a halberd much longer than she is tall.\n\n");
		outputText("\"<i>Hold it!</i>\" barks the fox, her dark gray fur bristling in suspicion at your sudden appearance, \"<i>What's your business in the city of Tel'Adre?</i>\"\n\n");
		outputText("You shrug and explain that you know nothing about this town, and just found it while exploring the desert.  The girl stares at you skeptically for a moment and then blows a shrill whistle.  She orders, \"<i>No sudden moves.</i>\"\n\n");
		outputText("Deciding you've nothing to lose by complying, you stand there, awaiting whatever reinforcements this cute vulpine-girl has summoned.  Within the minute, a relatively large-chested centauress emerges from a smaller door cut into the gate, holding a massive bow with an arrow already nocked.\n\n");
		outputText("\"<i>What's the problem, Urta?  A demon make it through the barrier?</i>\" asks the imposing horse-woman.\n\nUrta the fox shakes her head, replying, \"<i>I don't think so, Edryn.  " + player.mf("He's","She's") + " something else.  We should use the crystal and see if " + player.mf("he","she") + "'s fit to be allowed entry to Tel'Adre.</i>\"\n\n");
		outputText("You watch the big centaur cautiously as she pulls out a pendant, and approaches you.  \"<i>Hold still,</i>\" she says, \"<i>this will do you no harm.</i>\"\n\n");
		outputText("She places one hand on your shoulder and holds the crystal in the other.  Her eyes close, but her brow knits as she focuses on something.  ");
		telAdreCrystal();
	}
	else {
		outputText("Once again you find the gray fox, Urta, guarding the gates.  She nods at you and whistles for her companion, Edryn once again.  The centauress advances cautiously, and you submit herself to her inspection as she once again produces her magical amulet.  ");
		telAdreCrystal();
	}
}

//Alignment crystal goooooo
private function telAdreCrystal():void {
	if(!player.hasStatusEffect(StatusEffects.TelAdre)) player.createStatusEffect(StatusEffects.TelAdre,0,0,0,0);
	//-70+ corruption, or possessed by exgartuan
	if (player.hasStatusEffect(StatusEffects.Exgartuan) || player.cor >= 70 + player.corruptionTolerance()) {
		outputText("The crystal pendant begins to vibrate in the air, swirling around and glowing dangerously black.  Edryn snatches her hand back and says, \"<i>I'm sorry, but you're too far gone to step foot into our city.  If by some miracle you can shake the corruption within you, return to us.</i>\"\n\n");
		outputText("You shrug and step back.  You could probably defeat these two, but you know you'd have no hope against however many friends they had beyond the walls.  You turn around and leave, a bit disgruntled at their hospitality.  After walking partway down the dune you spare a glance over your shoulder and discover the city has vanished!  Surprised, you dash back up the dune, flinging sand everywhere, but when you crest the apex, the city is gone.");
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	//-50+ corruption or corrupted Jojo
	else if(player.cor >= 50 || JojoScene.monk >= 5) {
		outputText("The crystal pendant shimmers, vibrating in place and glowing a purple hue.  Edryn steps back, watching you warily, \"<i>You've been deeply touched by corruption.  You balance on a razor's edge between falling completely and returning to sanity.  You may enter, but we will watch you closely.</i>\"\n\n");
	}
	//-25+ corruption or corrupted Marae
	else if(player.cor >= 25 || flags[kFLAGS.FACTORY_SHUTDOWN] == 2) {
		outputText("The crystal pendant twirls in place, glowing a dull red.  Edryn takes a small step back and murmers, \"<i>You've seen the darkness of this land first hand, but its hold on you is not deep.  You'll find sanctuary here.  The demons cannot find this place yet, and we promise you safe passage within the walls.</i>\"\n\n");
	}
	//-Low corruption/pure characters
	else {
		outputText("The crystal shines a pale white light.  Edryn steps back and smiles broadly at you and says, \"<i>You've yet to be ruined by the demonic taint that suffuses the land of Mareth.  Come, you may enter our city walls and find safety here, though only so long as the covenant's white magic protects us from the demons' lapdogs.</i>\"\n\n");
	}
	outputText("The vixen Urta gestures towards the smaller door and asks, \"<i>Would you like a tour of Tel'Adre, newcomer?</i>\"\n\n");
	outputText("You remember your etiquette and nod, thankful to have a quick introduction to such a new place.  Urta leaves Edryn to watch the gate and leads you inside.  You do notice her gait is a bit odd, and her fluffy fox-tail seems to be permanently wrapped around her right leg.  The door closes behind you easily as you step into the city of Tel'Adre...");
	doNext(telAdreTour);
}

private function telAdreTour():void {
	player.changeStatusValue(StatusEffects.TelAdre,1,1);
	clearOutput();
	SceneLib.urta.urtaSprite();
	outputText("Urta leads you into the streets of Tel'Adre, giving you a brief run-down of her and her city, \"<i>You see, about two decades back, the demons were chewing their way through every settlement and civilization in Mareth.  The covenant, a group of powerful magic-users, realized direct confrontation was doomed to fail.  They hid us in the desert with their magic, and the demons can't corrupt what they can't find.  So we're safe, for now.</i>\"\n\n");
	outputText("The two of you find yourselves in the center of a busy intersection.  Urta explains that this is the main square of the city, and that, although the city is large, a goodly portion of it remains empty.  Much of the population left to assist other settlements in resisting the demons and was lost.  She brushes a lock of stray hair from her eye and guides you down the road, making sure to point out her favorite pub - \"The Wet Bitch\".  You ");
	if(player.cor < 25) outputText("blush");
	else outputText("chuckle");
	outputText(" at the rather suggestive name as Urta turns around and says, \"<i>With how things are, we've all gotten a lot more comfortable with our sexuality.  I hope it doesn't bother you.</i>\"\n\n");
	outputText("A bit further on, you're shown a piercing parlor, apparently another favorite of Urta's.  A cute human girl with cat-like ears peeks out the front and gives you both a friendly wave.  It's so strange to see so many people together in one place, doing things OTHER than fucking.  The whole thing makes you miss your hometown more than ever.  Tears come to your eyes unbidden, and you wipe them away, glad to at least have this one reminder of normalcy.  Urta politely pretends not to notice, though the tail she keeps wrapped around her leg twitches as she wraps up the tour.\n\n");
	outputText("She gives you a friendly punch on the shoulder and says, \"<i>Okay, gotta go!  Be good and stay out of trouble, alright?</i>\"\n\n");
	outputText("Before you can answer, she's taken off back down the street, probably stopping off at 'The Wet Bitch' for a drink.  Strange, her departure was rather sudden...");
	doNext(telAdreMenu);
}

public function telAdreMenu():void {
	if(flags[kFLAGS.VALENTINES_EVENT_YEAR] < date.fullYear && player.balls > 0 && player.hasCock() && flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] >= 4 && flags[kFLAGS.TIMES_MET_SCYLLA_IN_ADDICTION_GROUP] > 0 && isValentine()) {
		Holidays.crazyVDayShenanigansByVenithil();
		return;
	}
	if(!SceneLib.urtaQuest.urtaBusy() && flags[kFLAGS.PC_SEEN_URTA_BADASS_FIGHT] == 0 && rand(15) == 0 && model.time.hours > 15) {
		urtaIsABadass();
		return;
	}
	if (!SceneLib.urtaQuest.urtaBusy() && SceneLib.urta.pregnancy.event > 5 && rand(30) == 0) {
		SceneLib.urtaPregs.urtaIsAPregnantCopScene();
	   return;
	}
	switch (flags[kFLAGS.KATHERINE_UNLOCKED]) {
		case -1:
		case  0: //Still potentially recruitable
			if (flags[kFLAGS.KATHERINE_RANDOM_RECRUITMENT_DISABLED] == 0 && player.gems > 34 && rand(25) == 0) {
				if (flags[kFLAGS.KATHERINE_UNLOCKED] == 0)
					katherine.ambushByVagrantKittyKats();
				else katherine.repeatAmbushKatherineRecruitMent();
				return;
			} break;
		case  1: //In alley behind Oswald's
		case  2: //You are training her
		case  3: //You and Urta are training her
			break;
		case  4: //Employed
			if (!katherine.isAt(Katherine.KLOC_KATHS_APT) && flags[kFLAGS.KATHERINE_TRAINING] >= 100) {
				katherineEmployment.katherineGetsEmployed();
				return;
			} break;
		default: //Has given you a spare key to her apartment
			if (model.time.hours < 10 && rand(12) == 0) { //If employed or housed she can sometimes be encountered while on duty
				katherine.katherineOnDuty();
				return;
			}
	}
	if(flags[kFLAGS.ARIAN_PARK] == 0 && rand(10) == 0 && flags[kFLAGS.NOT_HELPED_ARIAN_TODAY] == 0) {
		SceneLib.arianScene.meetArian();
		return;
	}
	//Display Tel'adre menu options//
	//Special Delivery☼☼☼
	//Has a small-ish chance of playing when the PC enters Tel'Adre.
	//Must have Urta's Key.
	//Urta must be pregnant to trigger this scene.
	//Play this scene upon entering Tel'Adre.
	if (SceneLib.urta.pregnancy.event > 2 && rand(4) == 0 && flags[kFLAGS.URTA_PREGNANT_DELIVERY_SCENE] == 0 && player.hasKeyItem("Spare Key to Urta's House") >= 0) {
		SceneLib.urtaPregs.urtaSpecialDeliveries();
		return;
	}
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00242] == -1) {
		maddie.runAwayMaddieFollowup();
		return;
	}
	if (flags[kFLAGS.LUNA_FOLLOWER] < 2 && !player.hasStatusEffect(StatusEffects.LunaOff) && rand(10) == 0) {
		if (flags[kFLAGS.LUNA_FOLLOWER] == 1) meetingLunaRepated();
		else meetingLunaFirstTime();
		return;
	}
	spriteSelect(-1);
	outputText(images.showImage("location-teladre"));
	clearOutput();
	outputText("Tel'Adre is a massive city, though most of its inhabitants tend to hang around the front few city blocks.  It seems the fall of Mareth did not leave the city of Tel'Adre totally unscathed.  A massive tower rises up in the center of the city, shimmering oddly.  From what you overhear in the streets, the covenant's magic-users slave away in that tower, working to keep the city veiled from outside dangers.  There does not seem to be a way to get into the unused portions of the city, but you'll keep your eyes open.\n\n");
	outputText("A sign depicting a hermaphroditic centaur covered in piercings hangs in front of one of the sandstone buildings, and bright pink lettering declares it to be the 'Piercing Studio'.  You glance over and see the wooden facade of Urta's favorite bar, 'The Wet Bitch'.  How strange that those would be what she talks about during a tour.  In any event you can also spot some kind of wolf-man banging away on an anvil in a blacksmith's stand, and a foppishly-dressed dog-man with large floppy ears seems to be running some kind of pawnshop in his stand.  ");
	outputText("Steam boils from the top of a dome-shaped structure near the far end of the street, and simple lettering painted on the dome proclaims it to be a bakery.  Perhaps those shops will be interesting as well.  One shop named Kaiba cosmetic emporium specialises in magical trinkets and other oddities.");
	if (flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == -2 && !SceneLib.raphael.RaphaelLikes()) {
		outputText("\n\nYou remember Raphael's offer about the Orphanage, but you might want to see about shaping yourself more to his tastes first.  He is a picky fox, after all, and you doubt he would take well to seeing you in your current state.");
	}
	telAdreMenuShow();
}

public function telAdreMenuShow():void { //Just displays the normal Tel'Adre menu options, no special events, no description. Useful if a special event has already played
	var homes:Boolean = false;
	if (flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == -2 && SceneLib.raphael.RaphaelLikes())
		homes = true;
	else if (player.hasKeyItem("Spare Key to Urta's House") >= 0)
		homes = true;
	else if (flags[kFLAGS.KATHERINE_UNLOCKED] >= 5)
		homes = true;
	else if (flags[kFLAGS.ARIAN_PARK] >= 4 && !SceneLib.arianScene.arianFollower())
		homes = true;
	menu();
	addButton(0, "Shops", armorShops);
	addButton(1, "Bakery", bakeryScene.bakeryuuuuuu);
	addButton(2, "Bar", enterBarTelAdre);
	addButton(3, "Gym", gymDesc);
	if (homes) addButton(4, "Homes", houses);
	if (flags[kFLAGS.ARIAN_PARK] > 0 && flags[kFLAGS.ARIAN_PARK] < 4) addButton(5, "Park", SceneLib.arianScene.visitThePark);
	addButton(6, "Pawn", oswaldPawn);
	addButton(8, "Tower", library.visitZeMagesTower);
	addButton(14, "Leave", camp.returnToCampUseOneHour);
}

private function armorShops():void {
	clearOutput();
	outputText("The shopping district of Tel’adre happens to be contained in a large dead end street, with a large set of doors at the entrance to protect it from thieves at night, you’d assume from a higher elevation it would look like a giant square courtyard. Due to the cities shopping area being condensed into one spot, most if not every visible wall has been converted into a store front, in the center of the area are some small stands, guess not everyone can afford a real store.");
	outputText("\n\nRight off the bat you see the ‘Piercing Studio’, its piercing covered centaur sign is a real eye catcher. You can also spot some kind of wolf-man banging away on an anvil in a blacksmith's stand. As well as other shops lining the walls, perhaps those shops will be interesting as well. One shop named Kaiba cosmetic emporium specialises in magical trinkets and other oddities.");
	menu();
	addButton(0, "Blacksmith", new YvonneArmorShop().enter);
	addButton(1, "Piercing", new YaraPiercingStudio().piercingStudio);
	addButton(2, "Tailor", new VictoriaTailorShop().enter);
	addButton(3, "Weapons", new WeaponShop().enter);
	addButton(4, "Jewelry", new JewelryShop().enter);
	addButton(5, "Carpenter", carpentryShopEntry);
	addButton(6, "Kaiba", kaibaShopMainMenu);
	addButton(7, "Tripxi", tripxiShopMainMenu);
	if (flags[kFLAGS.LOPPE_PC_MET_UMA] == 1)
	{
		addButton(10, "Clinic", umasShop.enterClinic);
	}
	addButton(14,"Back",telAdreMenu);
}

public function houses():void {
	clearOutput();
	outputText("Whose home will you visit?");
	var orphanage:Function = null;
	if(flags[kFLAGS.RAPHEAL_COUNTDOWN_TIMER] == -2) {
		if(SceneLib.raphael.RaphaelLikes())
		{
			orphanage = SceneLib.raphael.orphanageIntro;
		}
		else {
			outputText("\n\nYou remember Raphael's offer about the Orphanage, but you might want to see about shaping yourself more to his tastes first.  He is a picky fox, after all, and you doubt he would take well to seeing you in your current state.");
		}
	}
	menu();
	if (flags[kFLAGS.KATHERINE_UNLOCKED] >= 5) addButton(0, "Kath's Apt", katherine.visitAtHome);
	if (SceneLib.urtaPregs.urtaKids() > 0 && player.hasKeyItem("Spare Key to Urta's House") >= 0)
		addButton(1, "Urta's House", (katherine.isAt(Katherine.KLOC_URTAS_HOME) ? katherine.katherineAtUrtas : SceneLib.urtaPregs.visitTheHouse));
	if(flags[kFLAGS.ARIAN_PARK] >= 4 && !SceneLib.arianScene.arianFollower()) addButton(2,"Arian's",SceneLib.arianScene.visitAriansHouse);
	addButton(3,"Orphanage",orphanage);
	addButton(14,"Back",telAdreMenu);
}



public function oswaldPawn():void {
	spriteSelect(47);
	clearOutput();
	if(!player.hasStatusEffect(StatusEffects.Oswald)) {
		outputText("Upon closer inspection, you realize the pawnbroker appears to be some kind of golden retriever.  He doesn't look entirely comfortable and he slouches, but he manages to smile the entire time.  His appearance is otherwise immaculate, including his classy suit-jacket and tie, though he doesn't appear to be wearing any pants.  Surprisingly, his man-bits are retracted.  ");
		if(player.cor < 75) outputText("Who would've thought that seeing someone NOT aroused would ever shock you?");
		else outputText("What a shame, but maybe you can give him a reason to stand up straight?");
		outputText("  His stand is a disheveled mess, in stark contrast to its well-groomed owner.  He doesn't appear to be selling anything at all right now.\n\n");
		outputText("The dog introduces himself as Oswald and gives his pitch, \"<i>Do you have anything you'd be interested in selling?  The name's Oswald, and I'm the best trader in Tel'Adre.</i>\"\n\n");
		outputText("(You can sell an item here, but Oswald will not let you buy them back, so be sure of your sales.)");
		player.createStatusEffect(StatusEffects.Oswald,0,0,0,0);
	}
	else {
		outputText("You see Oswald fiddling with a top hat as you approach his stand again.  He looks up and smiles, padding up to you and rubbing his furry hands together.  He asks, \"<i>Have any merchandise for me " + player.mf("sir","dear") + "?</i>\"\n\n");
		outputText("(You can sell an item here, but Oswald will not let you buy them back, so be sure of your sales.  You can shift-click to sell all items in a selected stack.)");
	}
	if(player.hasKeyItem("Carrot") < 0 && flags[kFLAGS.NIEVE_STAGE] == 3)
	{
		outputText("\n\nIn passing, you mention that you're looking for a carrot.\n\nOswald's tophat tips precariously as his ears perk up, and he gladly announces, \"<i>I happen to have come across one recently - something of a rarity in these dark times, you see.  I could let it go for 500 gems, if you're interested.</i>\"");
		if (player.gems < 500) {
			outputText("\n\n<b>You can't afford that!</b>");
			oswaldPawnMenu(); //eventParser(1065);
		}
		else {
			menu();
			addButton(0, "Sell", oswaldPawnMenu);
			addButton(1, "BuyCarrot", buyCarrotFromOswald);
		}
	}
	else oswaldPawnMenu(); //eventParser(1065);
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

private function oswaldPawnMenu(page:int = 1):void { //Moved here from Inventory.as
	var slot:int;
	spriteSelect(47);
	outputText("\n\n<b><u>Oswald's Estimates</u></b>");
	menu();
	var totalItems:int = 0;
	if (page == 1) {
		for (slot = 0; slot < 10; slot++) {
			if (player.itemSlots[slot].quantity > 0 && player.itemSlots[slot].itype.value >= 1) {
				outputText("\n" + int(player.itemSlots[slot].itype.value / 2) + " gems for " + player.itemSlots[slot].itype.longName + ".");
				addButton(slot, (player.itemSlots[slot].itype.shortName + " x" + player.itemSlots[slot].quantity), oswaldPawnSell, slot);
				totalItems += player.itemSlots[slot].quantity;
			}
		}
		if (inventory.getMaxSlots() > 10) addButton(13, "Next", oswaldPawnMenu, page + 1);
	}
	if (page == 2) {
		for (slot = 10; slot < 20; slot++) {
			if (player.itemSlots[slot].quantity > 0 && player.itemSlots[slot].itype.value >= 1) {
				outputText("\n" + int(player.itemSlots[slot].itype.value / 2) + " gems for " + player.itemSlots[slot].itype.longName + ".");
				addButton(slot-10, (player.itemSlots[slot].itype.shortName + " x" + player.itemSlots[slot].quantity), oswaldPawnSell, slot);
				totalItems += player.itemSlots[slot].quantity;
			}
		}
		addButton(13, "Prev", oswaldPawnMenu, page - 1);
	}
	if (totalItems > 1) addButton(12, "Sell All", oswaldPawnSellAll);
	switch (flags[kFLAGS.KATHERINE_UNLOCKED]) {
		case 1:
		case 2: addButton(10, "Kath's Alley", katherine.visitKatherine); break;
		case 3: addButton(10, "Safehouse", katherineEmployment.katherineTrainingWithUrta); break;
		case 4: addButton(10, "Kath's Alley", katherineEmployment.postTrainingAlleyDescription); //Appears until Kath gives you her housekeys
	}
	addButton(14, "Back", telAdreMenu);
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
	doNext(oswaldPawn);
}

private function oswaldPawnSellAll():void {
	spriteSelect(47);
	var itemValue:int = 0;
	clearOutput();
	for (var slot:int = 0; slot < 20; slot++) {
		if (player.itemSlots[slot].quantity > 0 && player.itemSlots[slot].itype.value >= 1) {
			itemValue += player.itemSlots[slot].quantity * int(player.itemSlots[slot].itype.value / 2);
			player.itemSlots[slot].quantity = 0;
		}
	}
	outputText("You lay out all the items you're carrying on the counter in front of Oswald.  He examines them all and nods.  Nervously, he pulls out " + num2Text(itemValue) + " gems and drops them into your waiting hand.");
	player.gems += itemValue;
	statScreenRefresh();
	doNext(oswaldPawn);
}

private function anotherButton(button:int, nam:String, func:Function, arg:* = -9000):int {
	if (button > 8) return 9;
	addButton(button, nam, func, arg);
	button++;
	return button;
}
private function enterBarTelAdre():void {
	if(isThanksgiving() && flags[kFLAGS.PIG_SLUT_DISABLED] == 0) Holidays.pigSlutRoastingGreet();
	else barTelAdre();
}

public function barTelAdre():void {
	// Dominka & Edryn both persist their sprites if you back out of doing anything with them -- I
	// I guess this is good a place as any to catch-all the sprite, because I don't think theres ever a case you get a sprite from just entering the bar?
	spriteSelect( -1);

	hideUpDown();
	var button:int = 0;
	clearOutput();
	if(flags[kFLAGS.LOPPE_DISABLED] == 0 && flags[kFLAGS.LOPPE_MET] == 0 && rand(10) == 0) {
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
	if(flags[kFLAGS.AMILY_VISITING_URTA] == 1) {
		button = anotherButton(button,"Ask4Amily",SceneLib.followerInteractions.askAboutAmily);
	}
	//DOMINIKA
	if(model.time.hours > 17 && model.time.hours < 20 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150] != -1) {
		button = anotherButton(button,"Dominika",dominika.fellatrixBarApproach);
	}
	//EDRYN!
	if (edryn.pregnancy.type != PregnancyStore.PREGNANCY_TAOTH) { //Edryn is unavailable while pregnant with Taoth
		if (edryn.edrynBar()) {
			if (edryn.pregnancy.isPregnant) {
				if (flags[kFLAGS.EDRYN_PREGNANT_AND_NOT_TOLD_PC_YET] == 0) {
					flags[kFLAGS.EDRYN_PREGNANT_AND_NOT_TOLD_PC_YET] = 1;
					if (flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] == 0) { //Edryn panic appearance! (First time mom)
						outputText("\n\nEdryn smiles when she sees you and beckons you towards her.  Fear and some kind of frantic need are painted across her face, imploring you to come immediately.  Whatever the problem is, it doesn't look like it can wait.");
						doNext(edryn.findOutEdrynIsPregnant);
						return;
					}
					else { //Edryn re-preggers appearance!
						outputText("\n\nEdryn smiles at you and yells, \"<i>Guess what [name]?  I'm pregnant again!</i>\"  There are some hoots and catcalls but things quickly die down.  You wonder if her scent will be as potent as before?");
					}
				}
				else { //Mid-pregnancy appearance
					outputText("\n\nEdryn is seated at her usual table, and chowing down with wild abandon.  A stack of plates is piled up next to her.  Clearly she has been doing her best to feed her unborn child.  She notices you and waves, blushing heavily.");
				}
			}
			//Edryn just had a kid and hasn't talked about it!
			else if (flags[kFLAGS.EDRYN_NEEDS_TO_TALK_ABOUT_KID] == 1) {
				outputText("\n\nEdryn the centaur isn't pregnant anymore!  She waves excitedly at you, beckoning you over to see her.  It looks like she's already given birth to your child!");
			}
			//Appearance changes if has had kids
			else if(flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] > 0) {
				outputText("\n\nEdryn is seated at her usual place, picking at a plate of greens and sipping a mug of the local mead.  She looks bored until she sees you.  Her expression brightens immediately, and Edryn fiddles with her hair and changes her posture slightly.  You aren't sure if she means to, but her cleavage is prominently displayed in an enticing manner.");
			}
			else if(player.statusEffectv1(StatusEffects.Edryn) < 3) {
				outputText("\n\nEdryn, the centauress you met at the gate, is here, sitting down at her table alone and sipping on a glass of wine.  You suppose you could go talk to her a bit.");
			}
			else outputText("\n\nEdryn the centauress is here, sipping wine at a table by herself.  She looks up and spots you, her eyes lighting up with happiness.  She gives you a wink and asks if you'll join her.");
			button = anotherButton(button,"Edryn",edryn.edrynBarTalk);
		}
	}
	if (flags[kFLAGS.KATHERINE_LOCATION] == Katherine.KLOC_BAR) {
		if (flags[kFLAGS.KATHERINE_UNLOCKED] == 4) { 
			katherine.barFirstEncounter();
			return;
		}
		if (flags[kFLAGS.KATHERINE_URTA_AFFECTION] == 31 && SceneLib.urta.urtaAtBar() && !SceneLib.urta.urtaDrunk() && flags[kFLAGS.URTA_ANGRY_AT_PC_COUNTDOWN] == 0) {
			katherine.barKathUrtaLoveAnnounce();
			return;
		}
		katherine.barDescription();
		button = anotherButton(button, "Katherine", katherine.barApproach);
    }
	//trace("HEL FOLLOWER LEVEL: " + flags[kFLAGS.HEL_FOLLOWER_LEVEL] + " HEL FUCKBUDDY: " + flags[kFLAGS.HEL_FUCKBUDDY] + " HARPY QUEEN DEFEATED: " + flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED]);
	//trace("REDUCED ENCOUNTER RATE (DISPLINED): " + flags[kFLAGS.HEL_REDUCED_ENCOUNTER_RATE]);
	//HELIA
//	if(player.gender > 0 && model.time.hours >= 14 && rand(2) == 0 && model.time.hours < 20 && (flags[kFLAGS.HEL_FUCKBUDDY] != 0 || CoC.instance.helFollower.followerHel()) && !(flags[kFLAGS.HEL_FOLLOWER_LEVEL] == 1 && flags[kFLAGS.HEL_HARPY_QUEEN_DEFEATED]== 0)) {
	if (edryn.edrynHeliaThreesomePossible()) {
		edryn.helAppearance();
		button = anotherButton(button,"Helia",edryn.approachHelAtZeBitch);
	}
	//NANCY
	if (auntNancy.auntNancy(false)) {
		auntNancy.auntNancy(true);
		if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00263] > 0) button = anotherButton(button,"Nancy",auntNancy.interactWithAuntNancy);
		else button = anotherButton(button,"Barkeep",auntNancy.interactWithAuntNancy);
	}
	else outputText("\n\nIt doesn't look like there's a bartender working at the moment.");

	//NIAMH
	if (model.time.hours >= 8 && model.time.hours <= 16 && flags[kFLAGS.NIAMH_STATUS] == 0) {
		niamh.telAdreNiamh();
		if (flags[kFLAGS.MET_NIAMH] == 0) button = anotherButton(button,"Beer Cat",niamh.approachNiamh);
		else button = anotherButton(button,"Niamh",niamh.approachNiamh);
	}
	//ROGAR #1
	if(flags[kFLAGS.ROGAR_PHASE] == 3 && flags[kFLAGS.ROGAR_DISABLED] == 0 && flags[kFLAGS.ROGAR_FUCKED_TODAY] == 0) {
		button = anotherButton(button,"HoodedFig",SceneLib.swamp.rogar.rogarThirdPhase);
		//Wet Bitch screen text when Ro'gar phase = 3:
		outputText("\n\nYou notice a cloaked figure at the bar, though you're quite unable to discern anything else as its back is turned to you.");
	}
	//ROGAR #2
	else if(flags[kFLAGS.ROGAR_PHASE] >= 4 && flags[kFLAGS.ROGAR_DISABLED] == 0 && flags[kFLAGS.ROGAR_FUCKED_TODAY] == 0) {
		button = anotherButton(button,"Rogar",SceneLib.swamp.rogar.rogarPhaseFour);
		//Wet Bitch bar text when Ro'gar phase = 4:
		outputText("\n\nRo'gar is here with his back turned to the door, wearing his usual obscuring cloak.");
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
	if (SceneLib.urta.urtaAtBar()) {
		//Scylla & The Furries Foursome
		if (scylla.action == Scylla.SCYLLA_ACTION_FURRY_FOURSOME)
		{
			trace("SCYLLA ACTION: " + scylla.action);
			outputText("\n\nScylla’s spot in the bar is noticeably empty. She’s usually around at this time of day, isn’t she? Urta grabs your attention with a whistle and points to a back room with an accompanying wink. Oh... that makes sense. Surely the nun won’t mind a little help with her feeding...");
			button = anotherButton(button,"Back Room",scylla.openTheDoorToFoursomeWivScyllaAndFurries);
		}
		//Urta X Scylla threesome
		if (scylla.action == Scylla.SCYLLA_ACTION_FUCKING_URTA) {
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00143] == 0)
				outputText("\n\n<b>Though Urta would normally be here getting sloshed, her usual spot is completely vacant.  You ask around but all you get are shrugs and giggles.  Something isn't quite right here.  You see an empty bottle of one of her favorite brands of whiskey still rolling on her table, so she can't have been gone long.  Maybe she had guard business, or had to head to the back rooms for something?</b>");
			else
				outputText("\n\nUrta's usual place is vacant, though her table still holds a half-drank mug of something potent and alcoholic.  If it's anything like the last time this happened, she's snuck into a back room with Scylla to relieve some pressure.  It might not hurt to join in...");
			flags[kFLAGS.URTA_TIME_SINCE_LAST_CAME] = 4;
			button = anotherButton(button, "Back Room", SceneLib.urta.scyllaAndUrtaSittingInATree);
		}
		else if (SceneLib.urta.urtaBarDescript()) {
			if (auntNancy.auntNancy(false) && flags[kFLAGS.URTA_INCUBATION_CELEBRATION] == 0 && SceneLib.urta.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) {
				SceneLib.urtaPregs.urtaIsHappyAboutPregnancyAtTheBar();
				return;
			}
			button = anotherButton(button,"Urta",SceneLib.urta.urtaBarApproach);
		}
	}
	//VALA
	if(vala.purifiedFaerieBitchBar()) button = anotherButton(button,"Vala",vala.chooseValaInBar);

	addButton(14,"Leave",telAdreMenu);
}


//-----------------
//-- CARPENTRY SHOP
//-----------------
public function carpentryShopEntry():void {
	clearOutput();
	outputText("You enter the shop marked by a sign with hammer and saw symbol painted on it. There are array of tools all hung neatly. A six feet tall zebra-morph stallion stands behind the counter. He appears to be wearing typical lumberjack outfit.\n\n");
	outputText("\"<i>Welcome to my hardware shop dear customer. Feel free to look around,</i>\" he says. \n\n");
	if (flags[kFLAGS.CODEX_ENTRY_ZEBRAS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_ZEBRAS] = 1;
		outputText("<b>New codex entry unlocked: Zebras!</b>")
	}
	doNext(carpentryShopInside);
}

public function carpentryShopInside():void {
	clearOutput();
	outputText("<i>So what will it be?</i>");
	menu();
	addButton(0, "Buy Nails", carpentryShopBuyNails);
	addButton(1, "Buy Wood", carpentryShopBuyWood);
	addButton(2, "Buy Stones", carpentryShopBuyStone);
	addButton(5, "Sell Nails", carpentryShopSellNails);	
	addButton(6, "Sell Wood", carpentryShopSellWood);
	addButton(7, "Sell Stones", carpentryShopSellStone);
	addButton(10, "Toolbox", carpentryShopBuySet);
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 1) addButton(11, "Nails Box", carpentryShopBuySet2);
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4) addButton(12, "Stone Building", carpentryShopBuySet3);
	addButton(14, "Leave", telAdreMenu);
}
//Buy nails
public function carpentryShopBuyNails():void {
	clearOutput();
	if (player.hasKeyItem("Carpenter's Toolbox") >= 0) {
		//Popracować aby wspominal wlasciciel w rozmowie 200-600 gwozdzi
		outputText("You ask him if he has nails for sale. He replies \"<i>Certainly! I've got nails. Your toolbox can hold up to two hundred nails. I'll be selling nails at a price of two gems per nail.</i>\" \n\n");
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2) {
			outputText("Nails: " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/600")
		}
		else if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 2) {
			outputText("Nails: " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/200")
		}
		menu();
		addButton(0, "Buy 10", carpentryShopBuyNailsAmount, 10);
		addButton(1, "Buy 25", carpentryShopBuyNailsAmount, 25);
		addButton(2, "Buy 50", carpentryShopBuyNailsAmount, 50);
		addButton(3, "Buy 75", carpentryShopBuyNailsAmount, 75);
		addButton(4, "Buy 100", carpentryShopBuyNailsAmount, 100);
		addButton(5, "Buy 150", carpentryShopBuyNailsAmount, 150);
		addButton(6, "Buy 200", carpentryShopBuyNailsAmount, 200);
		addButton(7, "Buy 300", carpentryShopBuyNailsAmount, 300);
		addButton(14, "Back", carpentryShopInside);
	}
	else {
		outputText("You ask him if he has nails for sale. He replies \"<i>I do. But I'm sorry, my friend. You don't have a toolbox. How are you going to carry nails safely?</i>\" ");
		doNext(carpentryShopInside);
	}
}

private function carpentryShopBuyNailsAmount(amount:int):void {
	nails = amount;
	clearOutput();
	outputText("You ask him for " + amount + " nails. He replies \"<i>That'll be " + (amount * 2) + " gems, please.</i>\" \n\nDo you buy the nails?");
	doYesNo(carpentryShopBuyNailsYes, carpentryShopBuyNails);
}

private function carpentryShopBuyNailsYes():void {
	clearOutput();
	if (player.gems >= (nails * 2))
	{
		player.gems -= (nails * 2);
		flags[kFLAGS.ACHIEVEMENT_PROGRESS_HAMMER_TIME] += nails;
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_HAMMER_TIME] >= 300) awardAchievement("Hammer Time", kACHIEVEMENTS.GENERAL_HAMMER_TIME);
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] += nails;
		outputText("You hand over " + (nails * 2) + " gems. \"<i>Done,</i>\" he says as he hands over bundle of " + nails +" nails to you.\n\n");
		if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 600 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2) {
			outputText("Unfortunately, your toolbox can't hold anymore nails. You notify him and he refunds you the gems.\n\n");
			player.gems += ((flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] - 600) * 2);
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 600;
			outputText("Nails: " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/600");
		}
		else if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 200 && flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 2) {
			outputText("Unfortunately, your toolbox can't hold anymore nails. You notify him and he refunds you the gems.\n\n");
			player.gems += ((flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] - 200) * 2);
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] = 200;
			outputText("Nails: " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/200");
		}
	}
	else outputText("\"<i>I'm sorry, my friend. You do not have enough gems.</i>\"");
	statScreenRefresh();
	doNext(carpentryShopBuyNails);
}

//Buy wood
public function carpentryShopBuyWood():void {
	clearOutput();
	outputText("You ask him if he has wood for sale. He replies \"<i>Certainly! I've got extra supply of wood. I'll be selling wood at a price of 10 gems per wood plank.</i>\" \n\n");
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) {
		outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/900")
	}
	else if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) {
		outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/300")
	}
	menu();
	addButton(0, "Buy 10", carpentryShopBuyWoodAmount, 10);
	addButton(1, "Buy 25", carpentryShopBuyWoodAmount, 25);
	addButton(2, "Buy 50", carpentryShopBuyWoodAmount, 50);
	addButton(3, "Buy 75", carpentryShopBuyWoodAmount, 75);
	addButton(4, "Buy 100", carpentryShopBuyWoodAmount, 100);
	addButton(5, "Buy 150", carpentryShopBuyWoodAmount, 150);
	addButton(6, "Buy 200", carpentryShopBuyWoodAmount, 200);
	addButton(7, "Buy 300", carpentryShopBuyWoodAmount, 300);
	addButton(14, "Back", carpentryShopInside);
}	

private function carpentryShopBuyWoodAmount(amount:int):void {
	wood = amount;
	clearOutput();
	outputText("You ask him for " + amount + " wood planks. He replies \"<i>That'll be " + (amount * 10) + " gems, please.</i>\" \n\nDo you buy the wood?");
	doYesNo(carpentryShopBuyWoodYes, carpentryShopBuyWood);
}

private function carpentryShopBuyWoodYes():void {
	clearOutput();
	if (player.gems >= (wood * 10))
	{
		player.gems -= (wood * 10);
		flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] += wood;
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_IM_NO_LUMBERJACK] >= 100) awardAchievement("I'm No Lumberjack", kACHIEVEMENTS.GENERAL_IM_NO_LUMBERJACK);
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += wood;
		outputText("You hand over " + (wood * 10) + " gems. \"<i>I'll have the caravan deliver the wood to your camp as soon as you leave my shop,</i>\" he says.\n\n");
		if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 900 && (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3)) {
			outputText("Unfortunately, your wood supply seem to be full. You inform him. He refunds you the gems.\n\n");
			player.gems += ((flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] - 900) * 10);
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] - 900);
			outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/900");
		}
		else if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 300 && (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3)) {
			outputText("Unfortunately, your wood supply seem to be full. You inform him. He refunds you the gems.\n\n");
			player.gems += ((flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] - 300) * 10);
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] - 300);
			outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/300");
		}
	}
	else outputText("\"<i>I'm sorry, my friend. You do not have enough gems.</i>\"");
	statScreenRefresh();
	doNext(carpentryShopBuyWood);
}

//Buy Stones
public function carpentryShopBuyStone():void {
	clearOutput();
	outputText("You ask him if he has stones for sale. He replies \"<i>Certainly! I've got extra supply of stones. I'll be selling stones at a price of 20 gems per stone.</i>\" \n\n");
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4) {
		outputText("Stone: " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/900")
	}
	else if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 4) {
		outputText("Stone: " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/300")
	}
	menu();
	addButton(0, "Buy 10", carpentryShopBuyStoneAmount, 10);
	addButton(1, "Buy 25", carpentryShopBuyStoneAmount, 25);
	addButton(2, "Buy 50", carpentryShopBuyStoneAmount, 50);
	addButton(3, "Buy 75", carpentryShopBuyStoneAmount, 75);
	addButton(4, "Buy 100", carpentryShopBuyStoneAmount, 100);
	addButton(5, "Buy 150", carpentryShopBuyStoneAmount, 150);
	addButton(6, "Buy 200", carpentryShopBuyStoneAmount, 200);
	addButton(7, "Buy 300", carpentryShopBuyStoneAmount, 300);
	addButton(14, "Back", carpentryShopInside);
}

private function carpentryShopBuyStoneAmount(amount:int):void {
	stone = amount;
	clearOutput();
	outputText("You ask him for " + amount + " stones. He replies \"<i>That'll be " + (amount * 20) + " gems, please.</i>\" \n\nDo you buy the stones?");
	doYesNo(carpentryShopBuyStoneYes, carpentryShopBuyStone);
}

private function carpentryShopBuyStoneYes():void {
	clearOutput();
	if (player.gems >= (stone * 20))
	{
		player.gems -= (stone * 20);
		flags[kFLAGS.ACHIEVEMENT_PROGRESS_YABBA_DABBA_DOO] += stone;
		if (flags[kFLAGS.ACHIEVEMENT_PROGRESS_YABBA_DABBA_DOO] >= 100) awardAchievement("Yabba Dabba Doo", kACHIEVEMENTS.GENERAL_YABBA_DABBA_DOO);
		flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += stone;
		outputText("You hand over " + (stone * 20) + " gems. \"<i>I'll have the caravan deliver the stones to your camp as soon as you leave my shop,</i>\" he says.\n\n");
		if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > 900 && (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4)) {
			outputText("Unfortunately, your stone supply seem to be full. You inform him. He refunds you the gems.\n\n");
			player.gems += ((flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] - 900) * 20);
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] - 900);
			outputText("Stone: " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/900");
		}
		else if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > 300 && (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 4)) {
			outputText("Unfortunately, your stone supply seem to be full. You inform him. He refunds you the gems.\n\n");
			player.gems += ((flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] - 300) * 20);
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] - 300);
			outputText("Stone: " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/300");
		}
	}
	else outputText("\"<i>I'm sorry, my friend. You do not have enough gems.</i>\"");
	statScreenRefresh();
	doNext(carpentryShopBuyStone);
}

//Sell Nails
public function carpentryShopSellNails():void {
	clearOutput();
	outputText("You ask him if he's willing to buy nails from you. He says, \"<i>Certainly! I'll be buying nails at a rate of one gem per nail.</i>\" \n\n");
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2) {
		outputText("Nails: " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/600")
	}
	else if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 2) {
		outputText("Nails: " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/200")
	}
	menu();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 1) addButton(0, "Sell 1", carpentryShopSellNailsAmount, 1);
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 5) addButton(1, "Sell 5", carpentryShopSellNailsAmount, 5);
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 10) addButton(2, "Sell 10", carpentryShopSellNailsAmount, 10);
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 25) addButton(3, "Sell 25", carpentryShopSellNailsAmount, 25);
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 50) addButton(4, "Sell 50", carpentryShopSellNailsAmount, 50);
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 100) addButton(5, "Sell 100", carpentryShopSellNailsAmount, 100);
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 200) addButton(6, "Sell 200", carpentryShopSellNailsAmount, 200);
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= 300) addButton(7, "Sell 300", carpentryShopSellNailsAmount, 300);
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] > 0) addButton(8, "Sell All", carpentryShopSellNailsAmount, flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES]);
	addButton(14, "Back", carpentryShopInside);
}

private function carpentryShopSellNailsAmount(amount:int):void {
	nails = amount;
	clearOutput();
	outputText("You're willing to offer " + num2Text(amount) + " " + (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] == 1 ? "piece" : "pieces") + " of nails. He replies \"<i>I'll buy that for " + amount + " gems.</i>\" \n\nDo you sell the nails?");
	doYesNo(carpentryShopSellNailsYes, carpentryShopSellNails);
}

private function carpentryShopSellNailsYes():void {
	clearOutput();
	if (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] >= nails)
	{
		player.gems += nails;
		flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] -= nails;
		outputText("You sign the permission form for " + num2Text(nails) + " " + (flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] ? "piece" : "pieces") + " of nails to be taken from your camp. \"<i>Deal. Here are " + nails + " gems,</i>\" he says.\n\n");
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2) {
		outputText("Nails: " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/600");
		}
		else {
 		outputText("Nails: " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/200");
		}
	}
	else outputText("\"<i>I'm sorry, my friend. You do not have enough nails.</i>\"");
	statScreenRefresh();
	doNext(carpentryShopSellNails);
}

//Sell wood
public function carpentryShopSellWood():void {
	clearOutput();
	outputText("You ask him if he's willing to buy wood from you. He says, \"<i>Certainly! I'll be buying wood at a rate of five gems per piece.</i>\" \n\n");
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) {
		outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/900")
	}
	else if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 3) {
		outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/300")
	}
	menu();
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 1) addButton(0, "Sell 1", carpentryShopSellWoodAmount, 1);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 5) addButton(1, "Sell 5", carpentryShopSellWoodAmount, 5);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 10) addButton(2, "Sell 10", carpentryShopSellWoodAmount, 10);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 25) addButton(3, "Sell 25", carpentryShopSellWoodAmount, 25);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 50) addButton(4, "Sell 50", carpentryShopSellWoodAmount, 50);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 100) addButton(5, "Sell 100", carpentryShopSellWoodAmount, 100);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 200) addButton(6, "Sell 200", carpentryShopSellWoodAmount, 200);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= 300) addButton(7, "Sell 300", carpentryShopSellWoodAmount, 300);
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] > 0) addButton(8, "Sell All", carpentryShopSellWoodAmount, flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES]);
	addButton(14, "Back", carpentryShopInside);
}	

private function carpentryShopSellWoodAmount(amount:int):void {
	wood = amount;
	clearOutput();
	outputText("You're willing to offer " + num2Text(amount) + " " + (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] == 1 ? "piece" : "pieces") + " of wood. He replies \"<i>I'll buy that for " + (amount * 5) + " gems.</i>\" \n\nDo you sell the wood?");
	doYesNo(carpentryShopSellWoodYes, carpentryShopSellWood);
}

private function carpentryShopSellWoodYes():void {
	clearOutput();
	if (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] >= wood)
	{
		player.gems += (wood * 5);
		flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] -= wood;
		outputText("You sign the permission form for " + num2Text(wood) + " " + (flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] == 1 ? "piece" : "pieces") + " of wood to be unloaded from your camp. \"<i>Deal. Here are " + (wood * 5) + " gems,</i>\" he says.\n\n");
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3) {
		outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/900");
		}
		else {
		outputText("Wood: " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/300");
		}
	}
	else outputText("\"<i>I'm sorry, my friend. You do not have enough wood.</i>\"");
	statScreenRefresh();
	doNext(carpentryShopSellWood);
}

//Sell Stones
public function carpentryShopSellStone():void {
	clearOutput();
	outputText("You ask him if he's willing to buy stones from you. He says, \"<i>Certainly! I'll be buying stones at a rate of ten gems per piece.</i>\" \n\n");
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4) {
		outputText("Stone: " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/900")
	}
	else if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 4) {
		outputText("Stone: " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/300")
	}
	menu();
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 1) addButton(0, "Sell 1", carpentryShopSellStoneAmount, 1);
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 5) addButton(1, "Sell 5", carpentryShopSellStoneAmount, 5);
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 10) addButton(2, "Sell 10", carpentryShopSellStoneAmount, 10);
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 25) addButton(3, "Sell 25", carpentryShopSellStoneAmount, 25);
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 50) addButton(4, "Sell 50", carpentryShopSellStoneAmount, 50);
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 100) addButton(5, "Sell 100", carpentryShopSellStoneAmount, 100);
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 200) addButton(6, "Sell 200", carpentryShopSellStoneAmount, 200);
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= 300) addButton(7, "Sell 300", carpentryShopSellStoneAmount, 300);
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] > 0) addButton(8, "Sell All", carpentryShopSellStoneAmount, flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES]);
	addButton(14, "Back", carpentryShopInside);
}

private function carpentryShopSellStoneAmount(amount:int):void {
	stone = amount;
	clearOutput();
	outputText("You're willing to offer " + num2Text(amount) + " " + (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] == 1 ? "piece" : "pieces") + " of stone. He replies \"<i>I'll buy that for " + (amount * 10) + " gems.</i>\" \n\nDo you sell the stones?");
	doYesNo(carpentryShopSellStoneYes, carpentryShopSellStone);
}

private function carpentryShopSellStoneYes():void {
	clearOutput();
	if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] >= stone)
	{
		player.gems += (stone * 10);
		flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= stone;
		outputText("You sign the permission form for " + num2Text(stone) + " " + (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] == 1 ? "piece" : "pieces") + " of stones to be unloaded from your camp. \"<i>Deal. Here are " + (stone * 10) + " gems,</i>\" he says.\n\n");
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4) {
		outputText("Stone: " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/900");
		}
		else {
		outputText("Stone: " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/300");
		}
	}
	else outputText("\"<i>I'm sorry, my friend. You do not have enough stones.</i>\"");
	statScreenRefresh();
	doNext(carpentryShopSellStone);
}

//Buy toolbox
public function carpentryShopBuySet():void {
	clearOutput();
	if (player.hasKeyItem("Carpenter's Toolbox") >= 0)
	{
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] < 1) flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] = 1;
		outputText("<b>You already own a set of carpentry tools!</b>");
		doNext(carpentryShopInside);
		return;
	}
	outputText("You walk around for a while until you see a wooden toolbox. It's filled with assorted tools. One of them is a hammer. Another one is a saw. Even another is an axe. There is a measuring tape. There's even a book with hundreds of pages, all about how to use tools and it even has project instructions! There's also a compartment in the toolbox for nails. Just what you need to build your cabin. \n\n");
	outputText("\"<i>Two hundred gems and it's all yours,</i>\" the shopkeeper says.\n\n");
	outputText("Do you buy it?");
	if (player.gems >= 200)
	{
		doYesNo(carpentryShopBuySetYes, carpentryShopBuySetNo);
	}
	else
	{
		outputText("\n\nYou count out your gems and realize it's beyond your price range.");
		doNext(carpentryShopInside);
	}
}

public function carpentryShopBuySetYes():void {
	player.gems -= 200;
	clearOutput();
	outputText("You hand over two hundred gems to the shopkeeper. ");
	outputText("\"<i>Here you go,</i>\" he says. You feel so proud to have your own tools for building stuff! \n\n");
	outputText("<b>Gained Key Item: Carpenter's Toolbox!</b>");
	player.createKeyItem("Carpenter's Toolbox", 0, 0, 0, 0);
	flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] = 1;
	statScreenRefresh();
	doNext(carpentryShopInside);
}

public function carpentryShopBuySetNo():void {
	clearOutput();
	outputText("\"<i>No thanks,</i>\" you tell him. \n\n");
	outputText("\"<i>Suit yourself,</i>\" he says as you put the box of tools back where it was.");
	doNext(carpentryShopInside);
}

//Nails Box
public function carpentryShopBuySet2():void {
	clearOutput();
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2)
	{
		outputText("<b>You already own box for nails!</b>");
		doNext(carpentryShopInside);
		return;
	}
	outputText("You walk around for a while until you see a wooden box. It's similar to the one you owns already. Asking zebra owner about it purpose he saying it's to keep nails that couldn't be keep inside toolbox. Exactly what you need in case building something will need more nails than your toolbox can hold. \n\n");
	outputText("\"<i>Fifty gems and it's all yours,</i>\" the shopkeeper says.\n\n");
	outputText("Do you buy it?");
	if (player.gems >= 50)
	{
		doYesNo(carpentryShopBuySet2Yes, carpentryShopBuySet2No);
	}
	else
	{
		outputText("\n\nYou count out your gems and realize it's beyond your price range.");
		doNext(carpentryShopInside);
	}
}

public function carpentryShopBuySet2Yes():void {
	player.gems -= 50;
	clearOutput();
	outputText("You hand over fifty gems to the shopkeeper. ");
	outputText("\"<i>Here you go,</i>\" he says. You feel so proud to been able store much more than two hundred of nails that you can use for building stuff without need of traveling to Tel'Adre in case of nails shortage! \n\n");
	outputText("<b>Gained Key Item: Nail's Box!</b>");
	player.createKeyItem("Nail's Box", 0, 0, 0, 0);
	flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] += 1;
	statScreenRefresh();
	doNext(carpentryShopInside);
}

public function carpentryShopBuySet2No():void {
	clearOutput();
	outputText("\"<i>No thanks,</i>\" you tell him. \n\n");
	outputText("\"<i>Suit yourself,</i>\" he says as you put the nails box back where it was.");
	doNext(carpentryShopInside);
}

//Stone Buildings
public function carpentryShopBuySet3():void {
	clearOutput();
	if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 5)
	{
		outputText("<b>You already own this guide!</b>");
		doNext(carpentryShopInside);
		return;
	}
	outputText("You walk around for a while until you see leather-bound book. It's titled 'Stone Building Guide' and briefly looking over contest you notice is about how to use stone along few other materials to make stronger than wooden structures. What is more interesting it even has project instructions for at lest few things that you think will be good to have constructed in camp! Just what you need to upgrade your steady growning settlment to next 'civilization' level. \n\n");
	outputText("\"<i>One hundred gems and it's all yours,</i>\" as usual the shopkeeper says.\n\n");
	outputText("Do you buy it?");
	if (player.gems >= 100)
	{
		doYesNo(carpentryShopBuySet3Yes, carpentryShopBuySet3No);
	}
	else
	{
		outputText("\n\nYou count out your gems and realize it's beyond your price range.");
		doNext(carpentryShopInside);
	}
}

public function carpentryShopBuySet3Yes():void {
	clearOutput();
	player.gems -= 100;
	outputText("You hand over a hundred gems to the shopkeeper. ");
	outputText("\"<i>Here you go,</i>\" he says. You feel so proud to have guide to building stone structures! \n\n");
	outputText("<b>Gained Key Item: Stone Building Guide!</b>");
	player.createKeyItem("Stone Building Guide", 0, 0, 0, 0);
	flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] += 1;
	statScreenRefresh();
	doNext(carpentryShopInside);
}

public function carpentryShopBuySet3No():void {
	clearOutput();
	outputText("\"<i>No thanks,</i>\" you tell him. \n\n");
	outputText("\"<i>Suit yourself,</i>\" he says as you put the book back where it was.");
	doNext(carpentryShopInside);
}

private function urtaIsABadass():void {
	flags[kFLAGS.PC_SEEN_URTA_BADASS_FIGHT] = 1;
	clearOutput();
	outputText("There's a commotion in the streets of Tel'Adre.  A dense crowd of onlookers has formed around the center of the street, massed together so tightly that you're unable to see much, aside from the backs the other onlookers' heads.  The sound of blows impacting on flesh can be heard over the crowd's murmuring, alerting you of the fight at the gathering's core.");
	simpleChoices("Investigate", watchUrtaBeABadass, "Who cares?", telAdreMenu, "", null, "", null, "", null);
}

//-----------------
//-- KAIBA SHOP
//-----------------
public function kaibaShopMainMenu():void {
	clearOutput();
	outputText("You enter the  shop. Its sign hanging overhead proudly displaying:  <i>'Kaiba odds and ends, the accessory for YOU!’</i> Inside there are many stalls lining the walls in multiple directions. Each stall hosts various strange items put on display. Most of them you can identify as accessory and wondrous items, but others are perplexing.\n\n");
	outputText("While browsing the stalls, the owner almost silently creeps up on you. You turn in time to meet with his greedy gaze. A Tanuki that could only be Kaiba himself, smiles at you like a cat at the mouse. He breaks the awkward silence first.\n\n");
	outputText("\"<i>Welcome to my humble shop, dear and precious customer. What need brings you here today? Are you a connoisseur looking for strange artefacts from world across, or an adventurer in need of… special equipment? I’m sure I can provide you just anything you need, for a reasonable sum of course.</i>\"\n\n");
	outputText("Each word sounds almost like it was repeated endless times as he rub his hands together" + (silly() ? ", he even has the obvious signs of $ in his scammy shopkeeper eyes": "") + ".\n\n");/*
	if (flags[kFLAGS.CODEX_ENTRY_] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_] = 1;
		outputText("<b>New codex entry unlocked: !</b>")
	}*/
	doNext(kaibaShopMainMenu2);
}

public function kaibaShopMainMenu2():void {
	menu();
	addButton(0, "FlameLizR", buyItem, jewelries.FLLIRNG).hint("Flame Lizard ring - Increases maximum Wrath by 75. Generate 2/1 wrath per turn/hour. Allow to use Lustzerker.");
	addButton(1, "InferMouseR", buyItem, jewelries.INMORNG).hint("Infernal Mouse ring - Increases maximum Wrath by 75. Generate 2/1 wrath per turn/hour. Allow to use Blazing battle spirit.");
	addButton(2, "UnDefKingS", buyItem, jewelries.UNDKINS).hint("Undefeated King's Signet - Increase max wrath by 100. When worn on right hand (slot 1 and 3 for rings) would have additional effects: increase max wrath by another 100 (with base bonus it's +200), generate 6/3 wrath per turn/hour, increase multiplied on Power Attack damage by 1.");
	//addButton(3, "Necklace", buyItem, necklaces.CSNECK);
	//addButton(4, "Necklace", buyItem, necklaces.CSNECK);
	addButton(5, "R.DeadeyeAim", buyItem, jewelries.RINGDEA).hint("Ring of deadeye aim - Remove range accuracy penalty when flying and increase range accuracy by 20%.");
	addButton(6, "R.Ambidexty", buyItem, jewelries.RNGAMBI).hint("Ring of Ambidexty - Remove melee accuracy penalty when flying and increase melee accuracy by 15%.");
	addButton(7, "CroUndefKing", buyItem, headjewelries.CUNDKIN).hint("Crown of the Undefeated King - You can't loose by HP until reaching droping into negative health larger than 5% of max HP + 500(scalable). When below 0 HP PC wouldn gain additional 1% of max HP per turn regeneration effect.");
	//addButton(8, "Necklace", buyItem, necklaces.CSNECK);
	addButton(9, "C.S.Necklace", buyItem, necklaces.CSNECK).hint("Crinos Shape necklace - Allow PC to use Crinos Shape even without perk Job: Beast Warrior with wrath costs and boost as the one gained from picking Job: Beast Warrior.");
	addButton(10, "UnDefKingDest", buyItem, weapons.UDKDEST).hint("Undefeated King's Destroyer - Massive mace weapon that will increase PC parry chance by 20%. Have 20% base chance for stun (3 rounds).");
    addButton(11, "Soul Drill", buyItem, weapons.SDRILL).hint("Soul Drill - 1H large weapon that can deal more damage the more soulforce is feed to it each turn.");
	addButton(12, "Hodr's bow", buyItem, weaponsrange.BOWHODR).hint("Hodr's bow - Bow that would apply blindess status or deal increased damage to blinded targets.");
	addButton(13, "Avelynn", buyItem, weaponsrange.AVELYNN).hint("Avelynn - Crossbow that will shoot two additional belts each time.");
	addButton(14, "Leave", telAdreMenu);
}

public function kaibaShopInside():void {
	clearOutput();
	outputText("Kaiba play his finger across the counter.\n\n");
	outputText("\"<i>Now now is there anything else this good merchant could sell to you? I still have plenty of trinkets you have yet to look at.</i>\"\n\n");
	kaibaShopMainMenu2();
}

private function buyItem(odd:ItemType):void{
	clearOutput();
	var cost:int = odd.value;// * 3
	outputText("While you point toward one of the items on the display Kaiba says, \"<i>Oh, this one is quite the find. If you are Interested it is merely " + odd.value + " gems.</i>\"\n\n");
	if (player.gems < cost){
		outputText("You realise you don’t have enough gems for this item. When you tell the shopkeeper so it causes Kaiba to sigh in disappointment.\n\n");
		outputText("\"<i>Fair enough keep looking around I’m sure we have a cheaper product you may need.</i>\"\n\n");
		doNext(kaibaShopInside);
		return;
	}
	else doYesNo(curry(buyItemYes,odd), buyItemNo);
}

private function buyItemYes(odd:ItemType):void {
	player.gems -= odd.value;// * 3
	statScreenRefresh();
	outputText("Kaiba smile wide as you hand the gems to him.\n\n");
	outputText("\"<i>Thanks for your patronage.</i>\"\n\n");
	inventory.takeItem(odd, kaibaShopInside);
}

private function buyItemNo():void {
	outputText("Kaiba sighs in disappointment.\n\n");
	outputText("\"<i>Fair enough keep looking around. I’m sure we have what you need and if you can’t see it just ask. I might have it stored away.</i>\"\n\n");
	doNext(kaibaShopInside);
}

//-----------------
//-- TRIPXI SHOP
//-----------------
public function tripxiShopMainMenu():void {
	clearOutput();
	if (player.statusEffectv2(StatusEffects.TelAdreTripxi) == 2) {
		outputText("You enter the shop and deliver the gun parts to Tripxi who overjoyed begins to rebuild the gun immediately drawing schematics in the process.\n\n");
		outputText("\"<i>Great job with this we are one step closer to restoring what was lost in the demon war all thanks to you! Come back tomorrow and I will have a brand new gun ready for you.</i>\"\n\n");
		player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
		if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns1) == 1) {
			player.removeKeyItem("Desert Eagle");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns1, 1, 1);
		}
		if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns2) == 1) {
			player.removeKeyItem("M1 Cerberus");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns2, 1, 1);
		}
		if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns3) == 1) {
			player.removeKeyItem("Tripxi Fatbilly");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns3, 1, 1);
		}
		if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns4) == 1) {
			player.removeKeyItem("Snippler");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns4, 1, 1);
		}
		if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns5) == 1) {
			player.removeKeyItem("Touhouna M3");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns5, 1, 1);
		}
		if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns6) == 1) {
			player.removeKeyItem("Twin Grakaturd");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns6, 1, 1);
		}
		if (player.statusEffectv2(StatusEffects.TelAdreTripxiGuns1) == 1) {
			player.removeKeyItem("Dart pistol");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns1, 2, 1);
		}
		if (player.statusEffectv2(StatusEffects.TelAdreTripxiGuns2) == 1) {
			player.removeKeyItem("Twin Dart pistol");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns2, 2, 1);
		}
		if (player.statusEffectv2(StatusEffects.TelAdreTripxiGuns3) == 1) {
			player.removeKeyItem("Harpoon gun");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns3, 2, 1);
		}
		if (player.statusEffectv2(StatusEffects.TelAdreTripxiGuns5) == 1) {
			player.removeKeyItem("Derpnade Launcher");
			player.addStatusValue(StatusEffects.TelAdreTripxiGuns5, 2, 1);
		}
	}
	else if (player.hasStatusEffect(StatusEffects.TelAdreTripxi)) {
		outputText("Tripxi move on from whatever weird experiment she was on to greet you at the counter.\n\n");
		outputText("\"<i>Day [name] did you waltz over to buy firearms?</i>\"\n\n");
	}
	else {
		outputText("You approach a weird shop sign that says 'Tripxi's bombs and guns emporium' as you enter you hear something not unlike a kaboom inside.\n\n");
		outputText("\"<i>NO NO NO NO and NO that's not it! Why mom didn't had the brain cells to just keep a sample of this tech when she was still sane!</i>\"\n\n");
		outputText("A goblin is sitting by a workbench her face is darkened somewhat by what appears to be the aftermath of a recent explosion, firearms parts all around the table. She sigh in exasperation and turn toward the counter to handle her customer, namely you.\n\n");
		outputText("\"<i>Welcome to Tripxi's bombs and guns emporium my name is Tripxi, how may I help you?</i>\"\n\n");
		player.createStatusEffect(StatusEffects.TelAdreTripxi, 0, 0, 0, 0);
	}
	if (flags[kFLAGS.CODEX_ENTRY_GOBLINS] <= 0) {
		flags[kFLAGS.CODEX_ENTRY_GOBLINS] = 1;
		outputText("<b>New codex entry unlocked: Goblins!</b>")
	}
	doNext(tripxiShopMainMenu2a);
}

public function tripxiShopMainMenu2a():void {
	menu();
	addButton(0, weaponsrange.FLINTLK.shortName, buyItemT1, weaponsrange.FLINTLK);
	addButton(1, weaponsrange.BLUNDER.shortName, buyItemT1, weaponsrange.BLUNDER);
	addButton(2, weaponsrange.DUEL_P_.shortName, buyItemT1, weaponsrange.DUEL_P_);
	addButton(3, weaponsrange.ADBSHOT.shortName, buyItemT1, weaponsrange.ADBSHOT);
	addButton(4, weaponsrange.ADBSCAT.shortName, buyItemT1, weaponsrange.ADBSCAT);
	addButton(5, weaponsrange.IVIARG_.shortName, buyItemT1, weaponsrange.IVIARG_);
	if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns1) > 2) addButton(6, weaponsrange.DESEAGL.shortName, buyItemT1, weaponsrange.DESEAGL);
	else if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns1) == 2) addButtonDisabled(6, "???", "Wait till tomorrow so Tripxi can restore this firearm.");
	else if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns1)) addButtonDisabled(6, "???", "Search the Desert.");
	if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns2) > 2) addButton(7, weaponsrange.M1CERBE.shortName, buyItemT1, weaponsrange.M1CERBE);
	else if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns2) == 2) addButtonDisabled(7, "???", "Wait till tomorrow so Tripxi can restore this firearm.");
	else if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns2)) addButtonDisabled(7, "???", "Search the Forest.");
	if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns3) > 2) addButton(8, weaponsrange.TRFATBI.shortName, buyItemT1, weaponsrange.TRFATBI);
	else if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns3) == 2) addButtonDisabled(8, "???", "Wait till tomorrow so Tripxi can restore this firearm.");
	else if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns3)) addButtonDisabled(8, "???", "Search the Vulcanic Crag.");
	if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns4) > 2) addButton(9, weaponsrange.SNIPPLE.shortName, buyItemT1, weaponsrange.SNIPPLE);
	else if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns4) == 2) addButtonDisabled(9, "???", "Wait till tomorrow so Tripxi can restore this firearm.");
	else if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns4)) addButtonDisabled(9, "???", "Search the Deepwoods.");
	addButtonDisabled(10, "-1-", "Shelf 1");
	addButton(11, "-2-", tripxiShopMainMenu2b);
	//addButton(12, "-3-", tripxiShopMainMenu2c);
	addButton(13, "Talk", tripxiShopTalk);
	addButton(14, "Leave", telAdreMenu);
}
public function tripxiShopMainMenu2b():void {
	menu();
	if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns5) > 2) addButton(0, weaponsrange.TOUHOM3.shortName, buyItemT2, weaponsrange.TOUHOM3);
	else if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns5) == 2) addButtonDisabled(0, "???", "Wait till tomorrow so Tripxi can restore this firearm.");
	else if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns5)) addButtonDisabled(0, "???", "Search the Caves.");
	if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns6) > 2) addButton(1, weaponsrange.TWINGRA.shortName, buyItemT2, weaponsrange.TWINGRA);
	else if (player.statusEffectv1(StatusEffects.TelAdreTripxiGuns6) == 2) addButtonDisabled(1, "???", "Wait till tomorrow so Tripxi can restore this firearm.");
	else if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns6)) addButtonDisabled(1, "???", "Search the Battlefield(O).");
	if (player.statusEffectv2(StatusEffects.TelAdreTripxiGuns1) > 2) addButton(2, weaponsrange.DPISTOL.shortName, buyItemT2, weaponsrange.DPISTOL);
	else if (player.statusEffectv2(StatusEffects.TelAdreTripxiGuns1) == 2) addButtonDisabled(2, "???", "Wait till tomorrow so Tripxi can restore this firearm.");
	else if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns1)) addButtonDisabled(2, "???", "Search the Blight Ridge.");
	if (player.statusEffectv2(StatusEffects.TelAdreTripxiGuns2) > 2) addButton(3, weaponsrange.TDPISTO.shortName, buyItemT2, weaponsrange.TDPISTO);
	else if (player.statusEffectv2(StatusEffects.TelAdreTripxiGuns2) == 2) addButtonDisabled(3, "???", "Wait till tomorrow so Tripxi can restore this firearm.");
	else if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns2)) addButtonDisabled(3, "???", "Search the Blight Ridge.");
	if (player.statusEffectv2(StatusEffects.TelAdreTripxiGuns3) > 2) addButton(5, weaponsrange.HARPGUN.shortName, buyItemT2, weaponsrange.HARPGUN);
	else if (player.statusEffectv2(StatusEffects.TelAdreTripxiGuns3) == 2) addButtonDisabled(5, "???", "Wait till tomorrow so Tripxi can restore this firearm.");
	else if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns3)) addButtonDisabled(5, "???", "Search the Beach.");
	if (player.statusEffectv2(StatusEffects.TelAdreTripxiGuns5) > 2) addButton(6, weaponsrange.DERPLAU.shortName, buyItemT2, weaponsrange.DERPLAU);
	else if (player.statusEffectv2(StatusEffects.TelAdreTripxiGuns5) == 2) addButtonDisabled(6, "???", "Wait till tomorrow so Tripxi can restore this firearm.");
	else if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns5)) addButtonDisabled(6, "???", "Search the Mountains.");
	addButton(10, "-1-", tripxiShopMainMenu2a);
	addButtonDisabled(11, "-2-", "Shelf 2");
	//addButton(12, "-2-", tripxiShopMainMenu2c);
	addButton(14, "Leave", telAdreMenu);
}
public function tripxiShopMainMenu2c():void {
	menu();
	//addButton(0, weaponsrange.FLINTLK.shortName, buyItemT3, weaponsrange.);
	//addButton(1, weaponsrange.FLINTLK.shortName, buyItemT3, weaponsrange.);
	
	addButton(10, "-1-", tripxiShopMainMenu2a);
	addButton(11, "-2-", tripxiShopMainMenu2b);
	addButtonDisabled(12, "-3-", "Shelf 3");
	addButton(14, "Leave", telAdreMenu);
}

public function tripxiShopInside():void {
	clearOutput();
	outputText("Tripxi move on from whatever weird experiment she was on to greet you at the counter.\n\n");
	outputText("\"<i>Day [name] did you waltz over to buy firearms?</i>\"\n\n");
	tripxiShopMainMenu2a();
}

private function buyItemT1(odd:ItemType, page:int = 1):void{
	clearOutput();
	var cost:int = odd.value;
	outputText("You point at the " + odd.longName + " and Tripxi put it on the counter.\n\n\"<i>Yea sure this thing will only be " + odd.value + " gems. hope you got the money on you.</i>\"\n\n");
	if (player.gems < cost){
		outputText("Sadly no you don't and Tripxi put back the thing in its display case.\n\n");
		outputText("\"<i>Anything else I can do for you then?</i>\"\n\n");
		doNext(tripxiShopMainMenu2a);
		return;
	}
	else doYesNo(curry(buyItemT1Yes,odd), buyItemT1No);
}
private function buyItemT1Yes(odd:ItemType):void {
	player.gems -= odd.value;
	statScreenRefresh();
	outputText("You pass on the gems to Tripxi who hands you the weapon over.\n\n");
	outputText("\"<i>Kill some demons with this baby will you. I'd like to think that my tools help clean the place some of my peers are busy dirtying with stupid sex toys.</i>\"\n\n");
	inventory.takeItem(odd, tripxiShopMainMenu2a);
}
private function buyItemT1No():void {
	outputText("After thinking no you will think it through first.\n\n");
	outputText("\"<i>Fine no skin of my back it's not like the city has me paying a rent for this shop anyway since I provide them with weapons.</i>\"\n\n");
	doNext(tripxiShopMainMenu2a);
}
private function buyItemT2(odd:ItemType):void{
	clearOutput();
	var cost:int = odd.value;
	outputText("You point at the " + odd.longName + " and Tripxi put it on the counter.\n\n\"<i>Yea sure this thing will only be " + odd.value + " gems. hope you got the money on you.</i>\"\n\n");
	if (player.gems < cost){
		outputText("Sadly no you don't and Tripxi put back the thing in its display case.\n\n");
		outputText("\"<i>Anything else I can do for you then?</i>\"\n\n");
		doNext(tripxiShopMainMenu2b);
		return;
	}
	else doYesNo(curry(buyItemT2Yes,odd), buyItemT2No);
}
private function buyItemT2Yes(odd:ItemType):void {
	player.gems -= odd.value;
	statScreenRefresh();
	outputText("You pass on the gems to Tripxi who hands you the weapon over.\n\n");
	outputText("\"<i>Kill some demons with this baby will you. I'd like to think that my tools help clean the place some of my peers are busy dirtying with stupid sex toys.</i>\"\n\n");
	inventory.takeItem(odd, tripxiShopMainMenu2b);
}
private function buyItemT2No():void {
	outputText("After thinking no you will think it through first.\n\n");
	outputText("\"<i>Fine no skin of my back it's not like the city has me paying a rent for this shop anyway since I provide them with weapons.</i>\"\n\n");
	doNext(tripxiShopMainMenu2b);
}
private function buyItemT3(odd:ItemType):void{
	clearOutput();
	var cost:int = odd.value;
	outputText("You point at the " + odd.longName + " and Tripxi put it on the counter.\n\n\"<i>Yea sure this thing will only be " + odd.value + " gems. hope you got the money on you.</i>\"\n\n");
	if (player.gems < cost){
		outputText("Sadly no you don't and Tripxi put back the thing in its display case.\n\n");
		outputText("\"<i>Anything else I can do for you then?</i>\"\n\n");
		doNext(tripxiShopMainMenu2c);
		return;
	}
	else doYesNo(curry(buyItemT3Yes,odd), buyItemT3No);
}
private function buyItemT3Yes(odd:ItemType):void {
	player.gems -= odd.value;
	statScreenRefresh();
	outputText("You pass on the gems to Tripxi who hands you the weapon over.\n\n");
	outputText("\"<i>Kill some demons with this baby will you. I'd like to think that my tools help clean the place some of my peers are busy dirtying with stupid sex toys.</i>\"\n\n");
	inventory.takeItem(odd, tripxiShopMainMenu2c);
}
private function buyItemT3No():void {
	outputText("After thinking no you will think it through first.\n\n");
	outputText("\"<i>Fine no skin of my back it's not like the city has me paying a rent for this shop anyway since I provide them with weapons.</i>\"\n\n");
	doNext(tripxiShopMainMenu2c);
}

private function tripxiShopTalk():void {
	menu();
	if (player.statusEffectv1(StatusEffects.TelAdreTripxi) > 0) addButtonDisabled(5, "Small Selection", "You already talked about this subject.");
	else addButton(5, "SmallSelection", tripxiShopTalkSmallSelection);
	addButton(14, "Leave", tripxiShopInside);
}

private function tripxiShopTalkSmallSelection():void {
	clearOutput();
	outputText("You look up her inventory and note that she only sell basic firearms.\n\n");
	outputText("\"<i>Well yes I do? That's because the tech was lost when our civilisation fell. No one makes guns anymore and I barely got the base knowledge to assemble these pieces of junk, primitive isn't it? We had stuff ranging from bomb launchers to gatling guns and all of it is now lost god knows were in the waste of Mareth. This said you're an adventurer, aren't you?</i>\"\n\n");
	outputText("You nod to that, you are indeed an adventuring hero, the champion of Ingnam to be exact.\n\n");
	outputText("\"<i>Yea sure whatever this just means you could help me with something. Fact is goblin technology is lost but not gone. There are good odds that while traveling around Mareth you may run into old gun parts. Gather them and bring them back here. I will study them and create brand new firearms for you.</i>\"\n\n");
	player.createStatusEffect(StatusEffects.TelAdreTripxiGuns1, 0, 0, 0, 0);
	player.createStatusEffect(StatusEffects.TelAdreTripxiGuns2, 0, 0, 0, 0);
	player.createStatusEffect(StatusEffects.TelAdreTripxiGuns3, 0, 0, 0, 0);
	player.createStatusEffect(StatusEffects.TelAdreTripxiGuns4, 0, 0, 0, 0);
	player.createStatusEffect(StatusEffects.TelAdreTripxiGuns5, 0, 0, 0, 0);
	player.createStatusEffect(StatusEffects.TelAdreTripxiGuns6, 0, 0, 0, 0);
	player.addStatusValue(StatusEffects.TelAdreTripxi, 2, 1);
	doNext(tripxiShopTalk)
}

//[Invetigate]
private function watchUrtaBeABadass():void {
	clearOutput();
	SceneLib.urta.urtaSprite();
	outputText("You shoulder past the bulky centaurs, ignore the rough fur of the nearby wolves and hounds as it brushes against you, and press your way through to the center of the crowd.  Eventually the throng parts, revealing the embattled combatants.  A snarling wolf, nearly eight feet tall, towers over Urta.  The comparatively diminutive fox-woman is girded in light leather armor and dripping with sweat.  The larger wolf-man is staggering about, and his dark brown fur is matted with blood.\n\n");

	outputText("The bigger canid charges, snarling, with his claws extended.  Urta sidesteps and pivots, her momentum carrying her foot around in a vicious kick.  Her foot hits the side of the beast's knee hard enough to buckle it, and the wolf goes down on his knees with an anguished cry.  Urta slips under his arm and twists, turning his slump into a fall.  A cloud of dust rises from the heavy thud of the beast's body as it slams into the cobblestone street.\n\n");

	outputText("Now that it's immobile, you get can get a better look at the defeated combatant, and you're ");
	if(player.hasStatusEffect(StatusEffects.Infested)) outputText("aroused");
	else if(player.cor < 50) outputText("horrified");
	else outputText("confused");
	outputText(" by what you see.  A pair of thick, demonic horns curve back over the beast's head, piercing through the bottoms of its wolf-like ears.  Its entire body is covered in rippling muscle, leaving you in no doubt of its strength.  Even with a broken knee, the wolf-man is clearly aroused: protruding from a bloated sheath, his massive dog-dick is fully erect, solid black in color, with an engorged knot.  Small white worms crawl over the surface of his penis, wriggling out of the tip and crawling down the length, leaving trails of slime behind them.\n\n");

	outputText("Urta kneels down onto the corrupted wolf's throat, cutting off its air as it foams and struggles under her.  With grim determination, she holds the weakening, demonically-tainted wolf underneath her, leaning all of her body-weight into her knee to keep it down.  It struggles for what seems like ages, but eventually the tainted wolf's eyes roll closed.  Urta nods and rises, watching closely as the beast's breathing resumes.\n\n");

	outputText("She barks, \"<i>Get this one outside the walls before he wakes.  I won't have this corrupted filth in our city, and make sure you get the wards updated.  If he manages to find his way back, you sorry excuses for guards will be going out with him.</i>\"\n\n");
	outputText("A few dog-morphs in similar armor to Urta approach and lash ropes around the wolf's legs.  They hand a line to a centaur, and together the party begins dragging the unconscious body away.  With the action over, the crowd begins dispersing.  More than a few males nod to Urta respectfully.  She keeps her expression neutral and excuses herself to resume her rounds, wiping her hands off on her armor-studded skirt as she leaves.");
	doNext(telAdreMenu);
}

public function gymDesc():void {
	//PREGGO ALERT!
	if (flags[kFLAGS.PC_IS_A_GOOD_COTTON_DAD] + flags[kFLAGS.PC_IS_A_DEADBEAT_COTTON_DAD] == 0 && cotton.pregnancy.isPregnant) {
		cotton.cottonPregnantAlert();
		return;
	}

	clearOutput();
	outputText("Even though Ingnam, your hometown, was a large, prosperous village, you never saw a gym before coming to Tel'Adre.  The structure itself has numerous architectural differences from the surrounding buildings: short, waist-high walls, an arched ceiling supported by simple columns, and a sand-covered floor.  Perhaps the only 'normal' rooms inside are the changing stands and bathrooms, which ");
	if(player.cor < 35) outputText("thankfully ");
	else if(flags[kFLAGS.PC_FETISH] > 0 || player.cor > 80) outputText("unfortunately ");
	outputText("have full sized walls to protect their users' privacy.  A breeze blows by, revealing that the open-air design provides great ventilation.  You note a wall of weights of different sizes and shapes, perfect for building muscle and bulking up.  There are also jogging tracks and even a full-sized, grass-covered track out back for centaurs to run on.  Though some of the equipment seems a bit esoteric in nature, you're sure you can make use of most of this stuff.\n\n");

	outputText("Though the gym sees heavy use by the city guard and various citizens, it's not too busy at present.");
	//(Add possible character descripts here)
	//(An extraordinarily well-muscled centaur male is by the weights, lifting some huge dumbbells and sweating like crazy.  In true centaur fashion, he's not wearing any clothes, but then again, male centaurs don't have much that regular clothes would hide.)
	//(There's a lizan girl jogging laps on one of the tracks.  She's quite thin, but her muscles have a lean definition to them.  She's wearing a one-piece, spandex leotard that hugs her tight ass and pert, b-cup breasts nicely.)
	outputText("  There's a centauress in a tank-top just inside the doorway with huge, rounded melons and perky nipples, but she merely coughs to get you to look up and says, \"<i>");
	if(flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) outputText("10 gems an hour to use the facilities here, or 500 for a life-time membership.</i>\"  She has her hands on her hips, and it looks you'll have to pay ten gems to actually get to use any of this stuff.");
	else outputText("Oh, welcome back [name].  Have a nice workout!</i>\"");

	if(player.gems < 10 && flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) {
		outputText("\n\n<b>You reach into your pockets for the fee and come up empty.  It looks like you don't have enough money to use the equipment or meet anyone.  Damn!</b>");
		//(back to tel'adre streets)
		doNext(telAdreMenu);
		return;
	}
	lottie.lottieAppearance();
	if(flags[kFLAGS.LOPPE_MET] > 0 && flags[kFLAGS.LOPPE_DISABLED] == 0) {
		outputText("\n\nYou spot Loppe the laquine wandering around, towel slung over her shoulder.  When she sees you, she smiles and waves to you and you wave back.");
	}
	if(model.time.hours > 9 && model.time.hours < 14) heckel.heckelAppearance();
	gymMenu();
}

private function gymMenu():void {

	var membership:Function =null;
	var cotton2:Function =null;
	var cottonB:String = "Horsegirl";
	var hyena:Function =null;
	var hyenaB:String = "Hyena";
	var ifris2:Function =null;
	var ifrisB:String = "Girl";
	var lottie2:Function = lottie.lottieAppearance(false);
	var lottieB:String = "Pig-Lady";
	var loppe2:Function =null;
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00281] > 0)
		lottieB = "Lottie";
	if(ifris.ifrisIntro())
		ifris2 = ifris.approachIfris;
	if(flags[kFLAGS.MET_IFRIS] > 0)
		ifrisB = "Ifris";
	if(model.time.hours > 9 && model.time.hours <= 15) {
		hyena = heckel.greetHeckel;
		if(flags[kFLAGS.MET_HECKEL] > 0)
			hyenaB = "Heckel";
	}
	if(flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0 && player.gems >= 500)
		membership = buyGymLifeTimeMembership;
	if(flags[kFLAGS.PC_IS_A_DEADBEAT_COTTON_DAD] == 0) {
		if(cotton.cottonsIntro())
			cotton2 = cotton.cottonGreeting;
	}
	if(flags[kFLAGS.COTTON_MET_FUCKED] > 0)
		cottonB = "Cotton";
	if(flags[kFLAGS.LOPPE_MET] > 0 && flags[kFLAGS.LOPPE_DISABLED] == 0)
		loppe2 = loppe.loppeGenericMeetings;

	choices("ChangeRoom",jasun.changingRoom,
			cottonB,cotton2,
			hyenaB,hyena,
			ifrisB,ifris2,
			"Jog",goJogging,
			"LiftWeights",weightLifting,
			"Life Member",membership,
			lottieB,lottie2,
			"Loppe",loppe2,
			"Leave",telAdreMenu);
}

private function buyGymLifeTimeMembership():void {
	clearOutput();
	//[Buy LifeTime Membership]
	if (silly()) outputText("You tell \"<i>Shut up and take my gems!</i>\" as you pull out your gem-pouch. \n\n"); //Shut up and take my gems!
	outputText("You fish into your pouches and pull out 500 gems, dumping them into the centaur's hands.  Her eyes widen as she turns and trots towards a counter in the back.  She leans over as she counts, giving you a generous view down her low-cut top at the cleavage she barely bothers to conceal.");
	if(player.hasCock()) {
		outputText("  It brings a flush to your face that has nothing to do with exercise.  Maybe you'll be able to con her into some alone time later?");
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
	if(player.fatigue > player.maxFatigue() - 25) {
		outputText("<b>There's no way you could exercise right now - you're exhausted!</b>  ");
		if(flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) outputText("It'd be better to save your money and come back after you've rested.");
		doNext(telAdreMenu);
		return;
	}
	//Deduct gems if not a full member.
	if(flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) {
		player.gems -= 10;
		statScreenRefresh();
	}
	//[Lift Weights] +25 fatigue!
	fatigue(25);
	//TEXTS!
	outputText("You walk up to the weights and begin your workout.  ");
	//(< 25 str)
	if(player.str < 25) outputText("You have to start out on the smaller weights to the left side of the rack due to your strength, but even so, you manage to work up a good burn and a modest sweat.");
	//(< 40 str)
	else if(player.str < 40) outputText("You heft a few of the weights and select some of the ones just to the left of the middle.  It doesn't take you long to work up a sweat, but you push on through a variety of exercises that leave your body feeling sore and exhausted.");
	//(< 60 str)
	else if(player.str < 60) outputText("You smile when you grip a few of the heavier weights on the rack and start to do some lifts.  With a start, you realize you're probably stronger now than Ingnam's master blacksmith, Ben.  Wow!  This realization fuels you to push yourself even harder, and you spend nearly an hour doing various strength-building exercises with the weights.");
	//(<80 str)
	else if(player.str < 80) outputText("You confidently grab the heaviest dumbbells in the place and heft them.  It doesn't take long for you to work up a lather of sweat and feel the burn thrumming through your slowly tiring form.  The workout takes about an hour, but you feel you made some good progress today.");
	//(<90)
	else if(player.str < 90) outputText("You grab the heaviest weights they have and launch into an exercise routine that leaves you panting from exertion.  Setting the weights aside, you flex and marvel at yourself – you could probably arm wrestle a minotaur or two and come out victorious!");
	//(else)
	else outputText("This place barely has anything left to challenge you, but you take the heaviest weights you can get your mitts on and get to it.  By the time an hour has passed, you've worked up a good sweat, but without heavier weights you probably won't get any stronger.");
	//Stat changes HERE!
	if(player.str < 90) dynStats("str", .5);
	if(player.tou < 40) dynStats("tou", .3);
	//Body changes here
	//Muscleness boost!
	outputText(player.modTone(85,5+rand(5)));
	outputText("\n\nDo you want to hit the showers before you head back to camp?");
	if(flags[kFLAGS.BROOKE_MET] == 1) {
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
	if(player.fatigue > player.maxFatigue() - 30) {
		outputText("<b>There's no way you could exercise right now - you're exhausted!</b>  ");
		if(flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) outputText("It'd be better to save your money and come back after you've rested.");
		doNext(telAdreMenu);
		return;
	}
	//Deduct gems if not a full member.
	if(flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) {
		player.gems -= 10;
		statScreenRefresh();
	}
	//[Jogging] +30 fatigue!
	fatigue(30);
	//Text!
	outputText("You hit the jogging track, ");
	//(<25 tou)
	if(player.tou < 25) outputText("but you get so winded you have to stop after a few minutes.  Determined to improve, you force yourself to stay at a fast walk until you can run again.");
	//(<40 tou)
	else if(player.tou < 40) outputText("but your performance isn't that great.  You nearly stop jogging a few times but manage to push through until you're completely exhausted.");
	//(<60 tou)
	else if(player.tou < 60) outputText("and you do quite well.  You jog around for nearly an hour, working up a healthy lather of sweat.  Even your [legs] tingle and burn with exhaustion.");
	//(<80 tou)
	else if(player.tou < 80) outputText("and it doesn't faze you in the slightest.  You run lap after lap at a decent clip, working yourself until you're soaked with sweat and fairly tired.");
	//(<90 tou)
	else if(player.tou < 90) outputText("and you have a terrific time.  You can keep yourself just below your sprinting speed for the entire time, though you work up a huge amount of sweat in the process.");
	//else)
	else outputText("and it barely challenges you.  You run at a sprint half the time and still don't feel like you're improving in the slightest.  Still, you do manage to burn a lot of calories.");
	//Stat changes HERE!
	if(player.spe < 40) dynStats("spe", .3);
	if(player.tou < 90) dynStats("tou", .5);

	//If butt is over 15 guaranteed reduction
	if(player.butt.type >= 15) {
		outputText("\n\nAll that running must have done some good, because your " + buttDescript() + " feels a little less bouncy.");
		player.butt.type--;
	}
	else {
		if(player.butt.type >= 10 && rand(3) == 0) {
			outputText("\n\nThe jogging really helped trim up your " + buttDescript() + ".");
			player.butt.type--;
		}
		else if(player.butt.type >= 5 && rand(3) == 0) {
			outputText("\n\nYour " + buttDescript() + " seems to have gotten a little bit more compact from the work out.");
			player.butt.type--;
		}
		else if(player.butt.type > 1 && rand(4) == 0) {
			outputText("\n\nYour " + buttDescript() + " seems to have gotten a little bit more compact from the work out.");
			player.butt.type--;
		}
	}//If hips is over 15 guaranteed reduction
	if(player.hips.type >= 15) {
		outputText("\n\nIt feels like your " + hipDescript() + " have shed some pounds and narrowed.");
		player.hips.type--;
	}
	else {
		if(player.hips.type >= 10 && rand(3) == 0) {
			outputText("\n\nIt feels like your " + hipDescript() + " have shed some pounds and narrowed.");
			player.hips.type--;
		}
		else if(player.hips.type >= 5 && rand(3) == 0) {
			outputText("\n\nIt feels like your " + hipDescript() + " have shed some pounds and narrowed.");
			player.hips.type--;
		}
		else if(player.hips.type > 1 && rand(4) == 0) {
			outputText("\n\nIt feels like your " + hipDescript() + " have shed some pounds and narrowed.");
			player.hips.type--;
		}
	}

	//Thickness decrease!
	outputText(player.modThickness(1,5+rand(2)));
	//Muscleness boost!
	outputText(player.modTone(player.maxToneCap(),2+rand(4)));
	outputText("\n\nDo you want to hit the showers before you head back to camp?");
	if(flags[kFLAGS.BROOKE_MET] == 1) {
		menu();
		addButton(0,"\"Showers\"",sexMachine.exploreShowers);
		addButton(1,"Showers",brooke.repeatChooseShower);
		addButton(4,"Leave",camp.returnToCampUseOneHour);
	}
	else doYesNo(sexMachine.exploreShowers, camp.returnToCampUseOneHour);
}
		
public function meetingLunaFirstTime():void {
	clearOutput();
	outputText("As you wander the streets of Tel'Adre, you see a woman being brutally thrown out of a house along with her belongings. The crowd seems to be ignoring her.  Curious, you walk up to her just in time to see her start to cry. She wears what looks like a formal maid dress. Under her white bonnet, the maid sports short, ashen hair. You decide to break the ice and ask her what's going on. By all means she looks human, which is a surprise to you.\n\n");
	outputText("\"<i>Why, this is terrible... I’m masterless, and out of a job! What am I going to do?</i>\"\n\n");
	outputText("What did she do to be fired to begin with?\n\n");
	outputText("\"<i>Master William’s wife is a liar. She didn’t like me around her husband, so she broke his favorite vase and framed me for it.</i>\"\n\n");
	outputText("Well... Talk about unfair treatment. Aren’t there any other people she could work for in town?\n\n");
	outputText("\"<i>Once a servant is cast out, everyone in town is going to learn about it. My life as a servant is ruined. What am I going to do? Work as a whore at the penthouse? I could never do such a thing.</i>\"\n\n");
	outputText("You could help her or leave her be. What will you do?\n\n");
	menu();
	addButton(0, "Help", meetingLunaFirstTimeHelp);
	addButton(1, "Leave", meetingLunaFirstTimeLeave);
}
public function meetingLunaFirstTimeLeave():void {
	outputText("Sadly you see no way you could help her out. You leave, wishing her the best of luck.\n\n");
	flags[kFLAGS.LUNA_FOLLOWER] = 1;
	doNext(telAdreMenu);
}
public function meetingLunaFirstTimeHelp():void {
	clearOutput();
	outputText("Now that you think about it, life at camp would be infinitely easier if you had a person like her helping around. How about she comes over to live with you at your camp?\n\n");
	outputText("\"<i>You.. you would hire me? Even after I’ve been kicked out? Oh this is wonderful! Thank you so much!!</i>\"\n\n");
	doNext(meetingLunaCamp);
}
public function meetingLunaRepated():void {
	clearOutput();
	outputText("As you walk the streets of Tel’Adre, you spot the human maid from before. She's holding an empty can and using it to beg for money as she sits on the side of the street. Seeing the former servant girl reduced to this state makes you feel terribly sorry for her. It is not too late to revise your decision, will you help her out?\n\n");
	menu();
	addButton(0, "Yes", meetingLunaRepatedYes);
	addButton(1, "No", meetingLunaRepatedNo);
}
public function meetingLunaRepatedNo():void {
	outputText("There is nothing you can do for her. You leave her be, for now.\n\n");
	doNext(telAdreMenu);
}
public function meetingLunaRepatedYes():void {
	clearOutput();
	outputText("Now that you think about it, life at camp would be infinitely easier if you had a person like her helping. How about she comes over to live with you at your camp? You walk to her and tell her that while you don’t own much but you would gladly take her.\n\n");
	outputText("The maid, now beggar, looks at you with tears in her eyes, as if snapping out of a bad dream, then stands up as she replies.\n\n");
	outputText("\"<i>You.. you would hire me? Even after I’ve been kicked out? Oh this is wonderful, thank you so much!!</i>\"\n\n");
	doNext(meetingLunaCamp);
}
public function meetingLunaCamp():void {
	outputText("The two of you head back to camp. The maid doesn’t comment on the fact you only have a cabin for a house");
	if (camp.companionsCount() > 2) outputText(", let alone the many people camping next to you");
	outputText(". In fact, she is practically overjoyed.\n\n");
	outputText("As the two of you reach the middle of the camp, you finally introduce yourself as [name] champion of Ingnam. She swiftly realises she hasn’t presented herself yet and does so with reverence.\n\n");
	outputText("\"<i>I’ve forgotten to introduce myself, please forgive me. My name is Luna. As you have probably figured out, I am a maid. Please allow me to call you " + player.mf("Master","Mistress") + " [name] from now on, I will serve you to the best of my abilities.</i>\"\n\n");
	outputText("(<b>Luna has been added to the Followers menu!</b>)\n\n");
	flags[kFLAGS.LUNA_FOLLOWER] = 4;
	flags[kFLAGS.LUNA_LVL_UP] = 0;
	flags[kFLAGS.LUNA_DEFEATS_COUNTER] = 0;
	doNext(camp.returnToCampUseOneHour);
}
}
}
