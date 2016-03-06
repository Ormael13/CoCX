package classes.Scenes.NPCs {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class MilkWaifu extends NPCAwareContent{

	public function MilkWaifu()
	{
	}
//New Variables
//" + flags[kFLAGS.MILK_NAME] + ": This slut's name. Can't call her Bath Slut forever. Unless you do.
//[MilkySize]: Does Milky have GIANT HUGE BOOBS that she can't fucking walk with, does she have a big plump set of HHH cups you can smother yourself and your big fat cock with, or a more reasonable DD bust, the perfect size to drink from, titfuck, and play with all day long.

//const MILK_NAME:int = 869;
//const MILK_SIZE:int = 870;
//const MET_MILK_SLAVE:int = 871;

override public function milkSlave():Boolean {
	return flags[kFLAGS.MILK_NAME] is String;
}


//Arriving at Camp
public function arriveWithLacticWaifuAtCamp():void {
	clearOutput();
	outputText("It's slow going, having to support your milky friend all the way back to camp, but after a few hours, you manage to make it home.  By the time you arrive, you see that the Sand Mother has kept her word, and a small part of the camp's perimeter has been cleared away, your belongings moved aside to make room for a large pool, its radius easily ten feet, buried in the hard-packed dirt of the wasteland.  A metallic brim surrounds the pool, just wide enough to sit or lie on with your [legs] dangling into the milky waters that will soon be filling it.");
	
	outputText("\n\nSeeing the pool, the milk girl gasps with glee, stumbling over to it before collapsing onto all fours, chest resting on her massive tits and ass up in the air, bare for all to see.  \"<i>Bath Slut milk time?</i>\" she asks, her bright brown eyes looking up at yours pleadingly.");
	
	outputText("\n\nSpeaking of which, you don't really have anything to call this dusky beauty.  You suppose you could just keep calling her \"Bath Slut,\" but that's hardly a fitting name for a free girl...");
	
	//[Name Field.  If left empty, defaults to "Bath Slut"]
	menu();
	addButton(0, "Next", nameZeMilkBath);
	mainView.nameBox.text = "";
}


private function nameZeMilkBath():void 
{
	if (mainView.nameBox.text == "" || mainView.nameBox.text is Number) 
	{
		clearOutput();
		outputText("<b>You must give her a name.</b>", false);
		menu();
		addButton(0,"Next",nameZeMilkBath);
		mainView.nameBox.visible = true;
		mainView.nameBox.text = "Bath Slut";
		mainView.nameBox.x = mainView.mainText.x + 5;
		mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		return;
	}
	clearOutput();
	flags[kFLAGS.MILK_NAME] = mainView.nameBox.text;
	mainView.nameBox.text = "";
	mainView.nameBox.visible = false;
	//Call her Bath Slut (You Asshole)
	if (mainView.nameBox.text == "Bath Slut") outputText("Fuck it, Bath Slut it is.  At least she won't get confused.");
	else if (mainView.nameBox.text == "Biscuit") outputText("Fuck it, you may as well butter her buns!");
	//Variable: " + flags[kFLAGS.MILK_NAME] + "
	//Having Named the Girl (Didn't name her Bath Slut)
	else {
		outputText("You crouch down beside the newly-named girl, brushing a few stray strands of her dark hair from her cheeks.  \"<i>No more Bath Slut.  You're " + flags[kFLAGS.MILK_NAME] + " now.  " + flags[kFLAGS.MILK_NAME] + "'s your name.</i>\"");
	
		outputText("\n\n\"<i>" + flags[kFLAGS.MILK_NAME] + "</i>\" she hesitantly repeats.  Looks like she gets it!  \"<i>" + flags[kFLAGS.MILK_NAME] + "!</i>\" she says, more confidently as you encourage her.");
	}
	//Arrival: Part 2 (PC has Rath in camp)
	if (player.findStatusEffect(StatusEffects.CampRathazul) >= 0 && player.statusEffectv2(StatusEffects.MetRathazul) >= 4) {
		outputText("\n\nAs you finish deciding on what to call " + flags[kFLAGS.MILK_NAME] + ", you hear footsteps shuffling over to the two of you.  Looking up, you see the old rat alchemist Rathazul approaching, nose buried in an ancient-looking tome.  \"<i>Good news, [name]!</i>\" he calls, just before tripping over the prone milkmaid, going sprawling across the ground.");
		
		outputText("\n\n\"<i>Gah!  Help, I can't get up!</i>\" he shouts, flailing around until you rush over and pull him to his feet.");
		
		outputText("\n\n\"<i>Ah, thank you, youngling.  But...  egad, [name], what have you dragged in this time?</i>\" he mumbles, fishing a pair of spectacles out of his pocket to examine " + flags[kFLAGS.MILK_NAME] + ".  \"<i>Why, it's a girl...  a very, um, busty girl at that.  Gods be good, how the devil does she stand with all that...  those...  those things on her chest?</i>\"");
		
		outputText("\n\n\"<i>Milk time?</i>\" " + flags[kFLAGS.MILK_NAME] + " mewls, reaching back to rub her full, round ass where Rath bumped into her.  Sheepishly, you explain that she doesn't stand, per se.  You're not sure what the Sand Witches did to her, but she's not quite capable of taking care of herself.");
		
		outputText("\n\n\"<i>I see.  Poor dear,</i>\" Rath says, shakily kneeling down beside " + flags[kFLAGS.MILK_NAME] + ".  He brushes her cheek sympathetically, a sorrowful smile playing across his aged features.  \"<i>She's hardly the first to be changed so drastically by these awful times, my friend.  Aside from counseling and lessons, I do not know what I can do to help a mind that's been subjected to the horrors this girl has doubtless seen, but at the very least, my Reducto concoction may be able to help her live with some semblance of normality.</i>\"");
		
		outputText("\n\nRath reaches into his robes, and produces a huge vial of the stuff - easily a few dozen normal doses worth.  \"<i>I'd been saving this up for the next time Canine Peppers got into the food supply, but I think she needs it more.  Here, [name],</i>\" he says, handing the vial to you.  \"<i>You have more, uh, experience in applying it than I do.  And she'll want a gentle touch, I'm sure.</i>\"");
		
		outputText("\n\nWith that, Rath hobbles off back to his little laboratory, leaving you with " + flags[kFLAGS.MILK_NAME] + ".");
		
		outputText("\n\n\"<i>Rat nice,</i>\" she mumbles, shifting her giant teats around beneath her.");
		//{Plot Item gained: "Super Reducto"}
		player.createKeyItem("Super Reducto",0,0,0,0);
		outputText("\n\n(<b>Key Item Acquired: Super Reducto</b>)");
	}
	//Arrival: Part 2 (No Rath)
	else {
		outputText("\n\nAs you finish deciding on what to call your new companion, your eyes wander down to her massive, milk-laden bosoms.  She can barely move around with such udders weighing her down, and while she's always eager to be milked, the weight of her lactic burden can't be the most pleasant thing.  Can it?");
		outputText("\n\nEither way, you figure that a good alchemist might be able to help the poor girl, if that's what you want to do.  But where to find an alchemist in this hell-hole...?");
		
		//[Next time Rath's at camp and PC accesses Milky's meny, play the Arrival w/ Rath scene, sans first sentence]
	}
	//Set before this function is called:	kGAMECLASS.inDungeon = false;
	doNext(camp.returnToCampUseOneHour);
}

public function ratducto():void {
	clearOutput();
	outputText("Looking up, you see the old rat alchemist Rathazul approaching, nose buried in an ancient-looking tome.  \"<i>Good news, [name]!</i>\" he calls, just before tripping over the prone milkmaid, going sprawling across the ground.");
	
	outputText("\n\n\"<i>Gah!  Help, I can't get up!</i>\" he shouts, flailing around until you rush over and pull him to his feet.");
		
	outputText("\n\n\"<i>Ah, thank you, youngling.  But...  egad, [name], what have you dragged in this time?</i>\" he mumbles, fishing a pair of spectacles out of his pocket to examine " + flags[kFLAGS.MILK_NAME] + ".  \"<i>Why, it's a girl...  a very, um, busty girl at that.  Gods be good, how the devil does she stand with all that...  those...  those things on her chest?</i>\"");
		
	outputText("\n\n\"<i>Milk time?</i>\" " + flags[kFLAGS.MILK_NAME] + " mewls, reaching back to rub her full, round ass where Rath bumped into her.  Sheepishly, you explain that she doesn't stand, per se.  You're not sure what the Sand Witches did to her, but she's not quite capable of taking care of herself.");
		
	outputText("\n\n\"<i>I see.  Poor dear,</i>\" Rath says, shakily kneeling down beside " + flags[kFLAGS.MILK_NAME] + ".  He brushes her cheek sympathetically, a sorrowful smile playing across her aged features.  \"<i>She's hardly the first to be changed so drastically by these awful times, my friend.  Aside from counseling and lessons, I do not know what I can do to help a mind that's been subjected to the horrors this girl has doubtless seen, but at the very least, my Reducto concoction may be able to help her live with some semblance of normality.</i>\"");
		
	outputText("\n\nRath reaches into his robes, and produces a huge vial of the stuff - easily a few dozen normal doses worth.  \"<i>I'd been saving this up for the next time Canine Peppers got into the food supply, but I think she needs it more.  Here, [name],</i>\" he says, handing the vial to you.  \"<i>You have more, uh, experience in applying it than I do.  And she'll want a gentle touch, I'm sure.</i>\"");
	
	outputText("\n\nWith that, Rath hobbles off back to his little laboratory, leaving you with " + flags[kFLAGS.MILK_NAME] + ".");
	
	outputText("\n\n\"<i>Rat nice,</i>\" she mumbles, shifting her giant teats around beneath her.");
	//{Plot Item gained: "Super Reducto"}
	player.createKeyItem("Super Reducto",0,0,0,0);
	outputText("\n\n(<b>Key Item Acquired: Super Reducto</b>)");
	doNext(playerMenu);
}



//Milky's Menu (Accessed from the FOLLOWERS tab)
public function milkyMenu():void {
	clearOutput();
	if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 0)
	{
		outputText("You wander over to " + flags[kFLAGS.MILK_NAME] + "'s pool, and find the dusky girl sitting at its rim, ");
		if (flags[kFLAGS.MILK_SIZE] == 0) outputText("lying face-down on her massive rack, her plump little ass sticking up in the air for all to see.  Seeing you approach, she brightens up and shifts her titanic bust around to face you, all bright-eyes and smiles.  \"<i>Milk time?</i>\"");
		else if (flags[kFLAGS.MILK_SIZE] == 1) outputText("arms crossed under her hefty, milky bust to support their still-sizable weight.  She smiles as you approach, able to stand up under her own power to give you a hug, milky tits pressed tight against you.  \"<i>I-is it milk time?</i>\" she asks, cupping her tits for you.");
		else outputText("her long, tanned legs dangling into the tub.  She jumps up when you approach, and though still a bit unsteady with such easy movements, she's quick to leap into your arms, nuzzling into your neck and pressing her firm, perky DD-cup breasts against you, little trickles of milk staining your chest through the little shirt she's wearing.  \"<i>[name],</i>\" she purrs happily.");
	}
	else
	{
		if (flags[kFLAGS.MILK_SIZE] == 0)
		{
			outputText("[bathgirlname] shakes vaguely out of her boob daze as you pick your way over to her.");

			outputText("\n\n“<i>Bath time?</i>”");
		}
		else
		{
			outputText("[bathgirlname] smiles at you as you pick your way over to her.");

			outputText("\n\n“<i>Hello [name]. Is there something you need?</i>”");
		}
	}

	if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 0 && flags[kFLAGS.FARM_CORRUPTION_STARTED] == 1)
	{
		if (flags[kFLAGS.MILK_SIZE] == 0)
		{
			// Bath Girl cannot walk
			outputText("\n\nAlthough her massive lactation would no doubt be a boon to your farm, there’s no way you can install [bathgirlname] there in her current state. Maybe you could talk to Whitney about building a new tank there, though.");
		}
	}
	
	if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1 && flags[kFLAGS.MILK_SIZE] == 0)
	{
		outputText("\n\n<b>(You'd have to find some way to reduce the size [bathgirlname]'s massive tits before you could send her back to camp.)</b>");
	}
	
	//Options:
	//Milk Time!  (HHH or DD boobs)
	//Milk Bath (Giant or HHH boobs)
	//Appearance
	//{Reducto} (GIANT or HHH boobs)
	menu();
	addButton(0,"Appearance",milkWriteFuAppearance);
	if (flags[kFLAGS.MILK_SIZE] > 0) addButton(1,"Milk Time!",nyanCatMilkTime);
	if (flags[kFLAGS.MILK_SIZE] < 2) addButton(2,"Milk Bath",milkBathTime);
	if (flags[kFLAGS.MILK_SIZE] < 2 && player.hasKeyItem("Super Reducto") >= 0) addButton(3,"Reducto",superReductoUsage);
	if (flags[kFLAGS.MILK_SIZE] > 0 && player.lust >= 33 && player.hasCock()) addButton(4,"Titfuck",titFuckDatMilkSlut);
	
	if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 0 && flags[kFLAGS.MILK_SIZE] > 0 && flags[kFLAGS.FARM_CORRUPTION_STARTED] == 1) addButton(5, "Farm Work", sendToFarm);
	if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1 && flags[kFLAGS.MILK_SIZE] > 0) addButton(5, "Go Camp", backToCamp);
	
	if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 0) addButton(14, "Back", camp.campSlavesMenu);
	if (flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] == 1) addButton(14, "Back", kGAMECLASS.farm.farmCorruption.rootScene);
}

private function sendToFarm():void
{
	clearOutput();
	
	outputText("You describe to [bathgirlname] the lake, and the farm which is situated close to it. Gently you tell her you want her to go there, present herself to the dog woman who owns it, and do as she says.");

	outputText("“<i>Ok,</i>” says [bathgirlname], cautiously testing the idea out. “<i>You’ll come and visit sometimes, right?</i>” Of course. Mollified, the former sand witch slave gets to her feet and cautiously picks her way towards the lake. She won’t be much use protection-wise but she’ll give your milk production a boost.");

	if (player.cor >= 90)
	{
		outputText("\n\nIt darkly but deliciously occurs to you that once she’s at the farm, it would be fairly easy to re-boobify her, build her a new tank and massively increase the amount of milk your farm produces.");
	}

	flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] = 1;
	
	doNext(camp.returnToCampUseOneHour);
}

private function backToCamp():void
{
	clearOutput();
	
	//TODO
	outputText("“<i>I want you to head on back to camp,</i>” you tell her. “<i>You’ll be more useful to me there.</i>” [bathgirlName]’s brow crinkles but she seems to accept your instruction.");

	outputText("“<i>As you wish.</i>” She wipes her hands before walking slowly down and out of the farm’s gate.");
	
	flags[kFLAGS.FOLLOWER_AT_FARM_BATH_GIRL] = 0;
	
	doNext(kGAMECLASS.farm.farmCorruption.rootScene);
}

//Appearance
private function milkWriteFuAppearance():void {
	clearOutput();
	outputText("" + flags[kFLAGS.MILK_NAME] + " is a five-foot-five human female, with darkly tanned skin and ebony hair.  ");
	if (flags[kFLAGS.MILK_SIZE] >= 2) outputText("Over her supple body, she wears a simple cloth shirt which cuts off just above her knees, hiding her newly-gained modesty, with a pair of silk painties and a simple bra beneath it.  ");
	outputText("She has a human face with rich, smooth skin dotted with the faintest trace of freckles.  Her hair is long and full, hanging down her back to her waist.  She's got a curvaceous body, bust aside, with supple hips and thighs, and a big butt you can just sink your fingers into.");
	
	//{If GIANT boobs: 
	if (flags[kFLAGS.MILK_SIZE] == 0) outputText("\n\nHer most distinguishing feature, though, is her massive bust.  Enough to drag her down onto all fours without support, " + flags[kFLAGS.MILK_NAME] + "'s rack is absolutely gigantic.  Her areola are the size of plates, constantly dribbling motherly fluids with every breath she takes.  The slightest touch is enough to get a stream flowing from " + flags[kFLAGS.MILK_NAME] + "'s titanic teats, enough to fill her entire pool with more to spare.  Those can't be too comfortable, you reckon, even if they are almost mesmerizing in their beauty and potential for sexual pleasure.");
	else if (flags[kFLAGS.MILK_SIZE] == 1) outputText("\n\nThough you've reduced them <i>considerably</i>, " + flags[kFLAGS.MILK_NAME] + "'s most eye-catching feature is still her tremendous bosom.  Those huge tits of hers would look more normal on a cowgirl than a human girl, and a rather petite one at that.  Her areola are palm-sized and tipped with a pair of prominent nipples, always eager to release their motherly fluids.  She can easily fill a tub with those things, and she alone could provide enough to feed a small village, producing more than the all the cows of Ingnam combined every day.");
	else {
		outputText("\n\nThanks to your intervention, " + flags[kFLAGS.MILK_NAME] + "'s breasts aren't so cripplingly large.  Reduced to a DD-cup, you've even managed to scrape together some clothes that actually fit her.  In her current state, you might even call her bust perky, her milk-laden breasts both firm and yet so delightfully soft; you can easily sink your fingers into them, or bury your face");
		if (player.hasCock()) outputText(" or cock");
		outputText(" between her pillowy bosoms.  Despite the reduction in size, " + flags[kFLAGS.MILK_NAME] + " is happy to tell you that she's still got plenty of milk inside her, though perhaps not quite as much as before: she can't quite fill the pool all by herself, but now even short milkings leave her blissfully empty for hours afterwards.  She's not an entire farm unto herself now and she seems fairly pleased by this, all things considered.");
	}
	
	outputText("\n\nBetween her lithe legs and childbearing hips is her cunt, a short stripe of dark, downy hair drawing your attention just above it.  And, hidden between her pert cheeks is her tight little backdoor, right where it belongs.");

	if (kGAMECLASS.farm.farmCorruption.hasTattoo("milky"))
	{
		outputText("\n\n");
		if (kGAMECLASS.farm.farmCorruption.milkyFullTribalTats())
		{
			outputText("She is covered from head to tail in tribal tattoos, erotic lines snaking all over her naked frame, giving her the look of a barely tamed savage.")
		}
		else if (kGAMECLASS.farm.farmCorruption.numMilkyButterflyTats() == 4)
		{
			outputText("She is covered from head to tail in tattooed butterflies, as if the pretty insects are attracted to her chocolate skin. When she moves she does it with an extra bounce and flick of the head, admiring how she looks as she goes.");
		}
		else
		{
			if (kGAMECLASS.farm.farmCorruption.numTattoos("milky") > 1) outputText("She has the following tattoos emblazoned across her body:\n");
			else outputText("She has ");

			if (flags[kFLAGS.MILKY_TATTOO_COLLARBONE] != 0) outputText(flags[kFLAGS.MILKY_TATTOO_COLLARBONE] + "\n");
			if (flags[kFLAGS.MILKY_TATTOO_SHOULDERS] != 0) outputText(flags[kFLAGS.MILKY_TATTOO_SHOULDERS] + "\n");
			if (flags[kFLAGS.MILKY_TATTOO_LOWERBACK] != 0) outputText(flags[kFLAGS.MILKY_TATTOO_LOWERBACK] + "\n");
			if (flags[kFLAGS.MILKY_TATTOO_BUTT] != 0) outputText(flags[kFLAGS.MILKY_TATTOO_BUTT] + "\n");
		}
	}

	menu();
	addButton(0,"Next",milkyMenu);
}

//Reducto
private function superReductoUsage():void {
	clearOutput();
	outputText("You tell " + flags[kFLAGS.MILK_NAME] + " that it's about time she got rid of those massive tits of hers.  She cocks her head to the side, looking at you without comprehension.  You fish the giant vial of Reducto Rath gave you from your pack and hold it up for her to examine.  She hesitantly takes it from your hand and rolls it around, sniffing at the foul-smelling stuff.  She turns up her nose at it.");
	
	outputText("\n\n\"<i>Come on, you'll feel a lot better afterwards, I promise,</i>\" you say, crouching down beside her, locking onto " + flags[kFLAGS.MILK_NAME] + "'s big brown eyes.");
	
	outputText("\n\nIf by nothing else than your soothing tone, " + flags[kFLAGS.MILK_NAME] + " stops fussing about the Reducto and does her best to curl up in your lap, giving you free access to her big ol' rack.  You tussle her hair and start thinking about how to go about this.");
	
	//If GIANT BOOBS:
	if (flags[kFLAGS.MILK_SIZE] == 0) {
		outputText("\n\nHer tits are huge.  No hiding that.  Reducto could bring them down to a more modest level, but then...  she does have amazing tits.  You're sure it wouldn't hurt her to keep them pretty big; any reduction is a favor at this point.  Then again, you could go all the way and drop her down to a \"normal\" cup size, something like some nice DDs: leave her enough to be considered a busty beauty, but little enough that she doesn't have back problems, though you don't know if she'll still lactate enough to bathe in with that small of a bust.");
		outputText("\n\nYou shift " + flags[kFLAGS.MILK_NAME] + " around in your lap, giving yourself the best angle on her giant tits.  That done, you lather up with Reducto, covering your hands with the stuff before reaching around and grabbing your friend's tits, smearing the first dollops around her leaky nipples.  She winces, shivering as the cool substance smears onto her teats, but almost immediately you can see it going to work: her breasts shudder, flesh quivering as they begin to shrink like balloons.");
		outputText("\n\n\"<i>[name]!</i>\" " + flags[kFLAGS.MILK_NAME] + " cries out, whimpering and moaning as you massage her tits, rubbing a good amount of reducto all around her bust.  Milk pours out of her like a pair of hoses, spraying her motherly fluids everywhere as her carrying capacity shrinks and shrinks.  Down and down she goes, breasts shrinking and leaking until they're about HHH-cups - big enough for a cowgirl, but a lot smaller than they were.");
		outputText("\n\n\"<i>That's enough,</i>\" you say, leaning around to put your hands into the spray of milk " + flags[kFLAGS.MILK_NAME] + "'s making, washing the reducto from your hands.  When you're done, you wipe her teats off with spare milk, rubbing off the reducto until her dusky skin is as bare as can be, nice and shiny.");
		outputText("\n\nExperimentally, " + flags[kFLAGS.MILK_NAME] + " tries to stand.  She nearly falls forward, leaden down by her still-prodigious bosoms, but you catch her, steadying the lightened girl until she's standing on her own power, swaying slightly, but standing.");
		
		outputText("\n\n\"<i>I...  I can...</i>\" she groans, suddenly clutching her head.  You jump up, steadying her again as " + flags[kFLAGS.MILK_NAME] + " moans in pain, tugging at her dark hair until suddenly, she's silent.  A long moment passes before she turns to you, all smiles.  \"<i>I can...  walk,</i>\" she says, struggling to form the words.  Before you can react, " + flags[kFLAGS.MILK_NAME] + " grabs you, hugging you into her hefty bosom as hard as she can, nearly crying with joy.  Laughing, you hug her back, holding her milk-soaked body tight until she's ready to stand.  Giving you a long, loving kiss, the girl stumbles off, trying to get her land legs back after being on all fours for so long.");
	}
	else {
		outputText("\n\n" + flags[kFLAGS.MILK_NAME] + "'s got cowgirl-sized tits right now");
		if (isabellaFollowerScene.isabellaFollower()) {
			outputText(", enough to give Isabella");
			if (player.findStatusEffect(StatusEffects.CampMarble) >= 0) outputText(" and Marble");
			outputText(" pause");
		}
		else if (player.findStatusEffect(StatusEffects.CampMarble) >= 0) outputText(", enough to give Marble pause");
		outputText(".  She seems much happier now, and is still able to produce enough milk to drown you; it's a happy balance.  Still, she still has to support them everywhere, and you can't find any clothes that fit her particular shape, thanks to her human stature.  That said, you've got enough Reducto left to bring her down to a pair of nice, firm DDs.  She'll still be nice and milky, though perhaps not enough to bathe in, and with a more reasonable bust size, you might actually be able to find a bra somewhere that will fit her.");
		//Down to DD Cups
		outputText("\n\nYou shift " + flags[kFLAGS.MILK_NAME] + " around in your lap, giving yourself the best angle on her giant tits.  That done, you lather up with Reducto, covering your hands with the stuff before reaching around and grabbing your friend's tits, smearing the first dollops around her leaky nipples.  She winces, shivering as the cool substance smears onto her teats, but almost immediately you can see it going to work: her breasts shudder, flesh quivering as they begin to shrink like balloons.");
		
		outputText("\n\n\"<i>[name]!</i>\" " + flags[kFLAGS.MILK_NAME] + " cries out, whimpering and moaning as you massage her tits, rubbing a goodly amount of reducto all around her bust.  Milk pours out of her like a pair of hoses, spraying her motherly fluids everywhere as her carrying capacity shrinks and shrinks.  Down and down she goes, breasts shrinking and leaking more and more.  You smear more Reducto on her, using every last drop you've got to help the poor milky slave girl.  She cries out again as her bust seems to explode with milk, a white tidal wave pouring from her shrinking nipples, nearly blinding you.");
		
		outputText("\n\nBy the time you can see again, you and " + flags[kFLAGS.MILK_NAME] + " are whiter than snow, completely covered in milk.  You look down, and see that your hands are cupping a beautiful, firm pair of DD breasts.  She's stopped shrinking right where you predicted, leaving her with a shapely bust that any girl could be proud of.  And more importantly, one that she could easily move around with.  Wiping the milk from your eyes, you stroke " + flags[kFLAGS.MILK_NAME] + "'s hair, gently urging her to try and stand.  Shakily, she allows herself to be stood up, and you let her go.");
		
		outputText("\n\n" + flags[kFLAGS.MILK_NAME] + " nearly falls, but catches herself at the last moment, waving her arms like a bird's to steady herself as she adjusts to her new center of gravity.  She takes a few experimental steps, and finds herself relatively unburdened.  Smiling from ear to ear, the girl turns to you and shouts out, \"<i>I...  I can WALK!</i>\" before leaping into your arms, crying tears of joy as she holds you tight against herself, perky tits dribbling milk onto your chest.  It seems no matter how flat she gets, " + flags[kFLAGS.MILK_NAME] + " can't stop producing milk; but now she doesn't have those massive tits to deal with, and for now, that's enough.  The poor slave girl nuzzles her cheek into your neck, shivering as she sobs, fingers clutching at your [armor].");
		
		outputText("\n\nYou let her cry it out for a good long while, stroking her hair and whispering soothing words until finally, she steps back, drying her eyes.  " + flags[kFLAGS.MILK_NAME] + " rubs her temples, groaning with a brief moment of pain before looking up at you with bright brown eyes and whispering, \"<i>Thank you...  so very much, [name].</i>\"");
		outputText("\n\nThat was...  surprisingly eloquent, given her normally limited speech.  Perhaps all that milk and cripplingly vast titflesh was doing something to her mind?  You ask her as much, still talking slowly and using simple words.");
		
		outputText("\n\n\"<i>Everything's foggy,</i>\" she groans, \"<i>But clearer, now.  So much clearer,</i>\" she breathes, smiling at you.  \"<i>Thank you, [name].</i>\"");
		
		outputText("\n\nYou tell her it was your pleasure.  ");
		//{If Rath is at camp: 
		outputText("Rathazul approaches, clearly having seen the preceeding events.  He smiles warmly at the two of you, clearly happy to have helped.  Wordlessly, the old rat produces a folded set of garments: a cloth shirt with intricate embroidery, and a pair of expensive-looking women's underthings, handing them over to " + flags[kFLAGS.MILK_NAME] + ".  She looks from the gift of clothing to the alchemist, and taking them, plants an affectionate kiss on his old brow.  He chuckles, blushing.  \"<i>I'm sorry I don't have more to give you, poor dear,</i>\" Rath says, starting to shuffle away.  \"<i>Still, I think I've held onto those long enough.</i>\"");
		
		outputText("\n\nYou help " + flags[kFLAGS.MILK_NAME] + " into her new clothes, probably the first she's been able to wear in years, and leave her to get used to her new body - though not before she draws you into a long kiss, holding you tight once again and whispering her heartfelt thanks.");
		//If no Rath: "You tell " + flags[kFLAGS.MILK_NAME] + " to wait a moment, and go digging through your possessions.  It takes a few minutes, but eventually you find some comfortable-looking clothing.  She takes them eagerly, saying she'll trim them down to her size as soon as she's got herself settled down: it's a lot to take in all at once, and she seems eager to experiment with her new, slender body, walking all over camp with a gay smile.  You leave her to exercise, but not before she draws you into a long kiss, holding you tight once again and whispering her heartfelt thanks."}
	}
	flags[kFLAGS.MILK_SIZE]++;
	doNext(camp.returnToCampUseOneHour);
}
	
//Milk Bath (HHH or Giant boobs only)
private function milkBathTime():void {
	player.slimeFeed();
	clearOutput();
	outputText("Tussling " + flags[kFLAGS.MILK_NAME] + "'s hair, you tell her her breasts look a bit full.  She smiles up at you eagerly as you disrobe.  Once nude, you hop down inside and say, \"<i>Bath Time.</i>\"");
	outputText("\n\nWith trembling anticipation, " + flags[kFLAGS.MILK_NAME] + " reaches down for her ");
	if (flags[kFLAGS.MILK_SIZE] == 0) outputText("teat-like");
	else outputText("prominent");
	outputText(" nipples.  Her areola bead with white perspiration in anticipation, and the woman's hands eagerly set to work on them, starting to draw out the first hints of lactation, pouring them into the pool around you.  You drop the plug into the drain and look up.  Cooing in delight, the huge-breasted girl finally manages to get her shivering fingertips around each of her aching milk-spouts.  She massages her nipple-flesh for a moment, her eyes lidded and heavy from pleasure, and she releases the first heavy torrent of white into the tub.  As she milks herself, " + flags[kFLAGS.MILK_NAME] + "'s eyes seem to go vacant, overwhelmed by pleasure, and her mouth is too busy making sighs of relief to speak.");
	outputText("\n\nPearly fluid quickly fills the first few inches of the tub, pouring as it is in numerous forking streams from its mocha spouts.  Deft hands massage the soft female flesh with smooth, unbroken motions, squeezing each teat from base to tip before retreating back to the bottom.  The steady back-and-forth motions cause the streams to rise and fall to the tempo, but the flow stays thick and steady enough to splatter your [hips] with white.  You relax against one of the benches at the side of the pool and idly trace your hands through the \"water,\" enjoying the feeling of the milk on your " + player.skinFurScales() + " as it rises higher and higher.  " + flags[kFLAGS.MILK_NAME] + ", your only companion, continues to knead her ");
	if (flags[kFLAGS.MILK_SIZE] == 0) outputText("gigantic");
	else outputText("cow-like");
	outputText(" breasts as you watch, and you have to admit, you feel a sexual thrill sliding down your spine as you watch her heafty bosoms work to fill your tub.");
	
	outputText("\n\nYou close your eyes and massage the stuff into your skin, feeling oddly serene and clean in spite of the heating of your loins.  Even as the cream flows over your ");
	if (player.gender == 1) outputText(player.multiCockDescriptLight());
	else if (player.gender == 2) outputText("[vagina]");
	else if (player.gender == 3) outputText(player.multiCockDescriptLight() + " and [vagina]");
	else outputText("[butt]");
	outputText(", you resist the urge to touch yourself in a sexual way and focus on what you wanted to do - bathe.  " + flags[kFLAGS.MILK_NAME] + " lets out a satisfied groan, her breasts finally seeming to wind down somewhat as the milk reaches your [chest], though by now she's positively quivering with pleasure, mindlessly working her nipples with eyes rolled back in her head.");
	//{If GIANT boobs:
	if (flags[kFLAGS.MILK_SIZE] == 0) outputText("\n\nStill, the mammoth milkers are more than large enough to keep her pinned beside the tub.  At this rate she'll likely remain immobile, even after you're neck-deep in her delightful fluids.");
	
	outputText("\n\nParting slightly, the dusky woman's full lips let her tongue loll out to dangle obscenely.  She looks... more than just pleased - almost orgasmically so.  Her hands, once steadily pumping, are now stroking her nipples with feverish intensity, stopping from time to time to caress the great mass of her chest and squeeze even more milk out.  She shivers and shudders, filling the tub for you, happily giving her all for her friend.  Her blissful expression grows more and more pleased with every passing second, and then with a shudder, she squeals and moans in ecstatic, body-shaking bliss, her muscles writhing, sending a titanic tremor through her now-jiggling jugs.  A huge spray of milk is released at the same time, powerful enough to rock you back against the tub's wall and soak your hair.  By the time it's over, the tub is full, and the delirious girl is panting happily.");
	
	outputText("\n\n" + flags[kFLAGS.MILK_NAME] + " pulls back, licking her puffy lips and smelling strongly of female arousal, though obviously satisfied.  She whimpers, \"<i>I love bath time,</i>\" before ");
	if (flags[kFLAGS.MILK_SIZE] == 0) outputText("starting to shift her breasts' bulk toward a comfortable spot for a nap");
	else outputText("struggling to her feet, legs shaky with the afterglow of a might boobgasm");
	outputText(".");
	if (player.lust >= 33) outputText("  You could probably masturbate in the tub if you wanted to, or maybe pull the dusky milk-maid in for company.");
	//If PC has Sophie, Hel, Isabella, Izma, Ember, or Amily:
	
	outputText("  What do you do?");
	//{If can masturbate [Drink & Masturbate] [Milk Girl] [Communal Bath] [Relax]}
	menu();
	addButton(1,"Milk Girl",pullInZeMilkGirl);
	if (player.gender > 0 && player.lust >= 33) addButton(0,"DrinkNFap",drinkAndFapturbate);
	var count:int = 0;
	if (sophieFollowerScene.sophieFollower()) count++;
	if (player.findStatusEffect(StatusEffects.PureCampJojo) >= 0) count++;
	if (latexGirl.latexGooFollower()) count++;
	if (flags[kFLAGS.VALARIA_AT_CAMP] == 1 || player.armor == armors.GOOARMR) count++;
	if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) count++;
	if (helScene.followerHel()) count++;
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1) count++;
	if (emberScene.followerEmber()) count++;
	if (kihaFollower.followerKiha()) count++;
	if (count >= 3) {
		outputText("  Then again, if you're getting a bath, maybe the rest of your friends might like to join you?");
		addButton(2,"Comm.Bath",communalBath);
	}
	addButton(4,"Relax",relaxWithMilkWaifu);
}

//[Next] (Relax)
private function relaxWithMilkWaifu():void {
	clearOutput();
	outputText("You sit in the tub for a while, letting the fragrant fluids soak into your " + player.skinFurScales() + ".  You spend the better part of an hour lounging, letting your cares float away in " + flags[kFLAGS.MILK_NAME] + "'s endless white bounty.  Finally though, you pull out the tub's plug and climb out, finding a towel nearby.  Thankfully, the milk doesn't seem to leave behind any residue, and you feel clean and refreshed, if a bit horny.");
	//(+Lust, -Fatigue)
	dynStats("lus", 10+player.sens/10, "resisted", false);
	player.changeFatigue(-34);
	doNext(camp.returnToCampUseOneHour);
}

//[Communal Bath] (PC must have 3+ of the following followers)
private function communalBath():void {
	clearOutput();
	outputText(images.showImage("communal-bath"));
	outputText("As you relax in the tub, you decide it's hardly fair to have all this milk and just hog it to yourself.  You sit up and give a sharp whistle, getting the attention of the rest of camp.  \"<i>Jump on in, everyone!</i>\" you shout, quickly grabbing " + flags[kFLAGS.MILK_NAME] + " by the waist and dragging her in.  She tumbles into her own lactation with a sharp cry of surprise, breaching a moment later with a splutter.");
	//If PC has Isabella: 
	if (isabellaFollowerScene.isabellaFollower()) {
		outputText("\n\nA moment later, the towering form of Isabella saunters over, already tossing aside her skirts.  \"<i>");
		if (isabellaFollowerScene.isabellaAccent()) outputText("Vhat, ist Isabella's milk not gut enough fur you, [name].  Still, I could be using with a bath.");
		else outputText("What, is my milk not good enough for you, [name]?  Still, I could use a bath.");
		outputText("</i>\"");
	}
	//If PC has Sophie:
	if (sophieFollowerScene.sophieFollower()) outputText("\n\n\"<i>Oh, fresh milk!</i>\" Sophie exclaims cheerily.  She drops down by the edge of the pool and scoops up a handful, bringing the thick, creamy milk up to her lips.  Her wings flutter happily as she laps it up, rubbing more into her fair skin between clumps of downy feathers.");
	
	//If PC has Pure!Jojo:
	if (player.findStatusEffect(StatusEffects.PureCampJojo) >= 0) outputText("\n\nThe white-furred monk Jojo approaches the pool with some hesitation, eyeing the tub full of cream.  \"<i>How...  lewd.  Though it would be a shame for such a bounty to go to waste.</i>\"  Slowly, the monk disrobes down to his undergarments, and lowers himself into the pool nearby.");
	
	//{If PC has Latexy:
	if (latexGirl.latexGooFollower()) outputText("\n\nYou wave over your ebony-skinned latex goo, telling her to drink up.  \"<i>M-[master]?</i>\" she says, pausing at the poolside.  You repeat your command, patting the surface of the milky waves.  It looks like her primal hunger takes over a moment later as she slips into the vast sea of lactation, soaking it up.");
	
	//{If PC has Valeria:
	if (flags[kFLAGS.VALARIA_AT_CAMP] == 1 || player.armor == armors.GOOARMR) {
		outputText("\n\nThe gooey mass of Valeria materializes a few feet away, assuming her human shape as she surveys the milkbath awaiting her.  \"<i>Damn, [name].  This girl's got some faucets on her.  Ought to get some of the girls from the lake on up here to finish the job when we're done.</i>\"  Chuckling, Val slips into the pool, turning a brighter shade of blue as cream rushes through her porous body.");
		valeria.feedValeria(100);
	}
	
	//If PC has Pure!Amily:
	if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) outputText("\n\nThe mouse-girl, Amily, is quick to respond to your call.  Happy for the luxury of a simple bath, even a milky one, she quickly tosses her clothes aside and dives in beside you, laughing and splashing playfully even as her brown hair is soaked.");
	
	//If PC has Helia:
	if (helScene.followerHel()) outputText("\n\nWith a gleeful shout, Hel rushes the pool.  In one swift motion, she tosses her scale bikini aside and cannon-balls in, splashing everyone with a creamy tidal wave.  Chuckling, you clear your eyes - just in time for her bikini bottom to land on your face.");
	
	//If PC has Izma: 
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00238] == 1) outputText("\n\nYou didn't even notice Izma getting into the pool.  The first sign of her is the sudden appearance of a bright red fin sticking above the water, closing in on you.  She breaches at the last moment, laughing gaily as she gives her alpha a kiss.");
	
	//{If PC has Ember:
	if (emberScene.followerEmber()) outputText("\n\nEmber approaches the pool, reptilian tail swishing eagerly.  " + emberScene.emberMF("He","She") + " lowers " + emberScene.emberMF("himself","herself") + " in with ease, sighing contentedly as milk washes over " + emberScene.emberMF("his","her") + " scaled body.  \"<i>Is this how you humans bathe normally?</i>\"  " + emberScene.emberMF("He","She") + " muses.  \"<i>How bizarre.</i>\"");
	
	//{If PC has Kiha:
	if (kihaFollower.followerKiha()) {
		outputText("\n\nKiha, your dear dusky dragoness, wanders over to see what the commotion is, but turns her nose up at the sight of you bathing in breastmilk.  \"<i>Ew.  How the hell can you just...  wallow in that?  Disgusting!</i>\"");
		if (silly() && player.str > 80 && player.spe > 80) outputText("  Without warning Kiha, you grab her. \"<i>HEY, what are you doing, doofus?</i>\" she yells as you finally pull her into the milky bath. \"<i>What have you done, idiot!? Fine, I'll bathe. Are you happy? Baka!</i>\" she grumbles.")
	}
	//[Combine]
	outputText("\n\nSurrounded by friends and lovers, you relax in the pool, leaning your arms back over the rim and closing your eyes, sighing contentedly.  Your friends splash and play with each other, happy to enjoy a few blissful, normal moments away from the cares of the world, away from the demons, and the monsters, and the horror their world has become.  The waves displace beside you, milk parting as a pair of giant jugs move over to you; you look down to see " + flags[kFLAGS.MILK_NAME] + " curling up in your arm.  Her giant teats float atop the waters, boyantly swaying with a strange grace atop the sea of their own making.");
	
	outputText("\n\nWithout prompting, " + flags[kFLAGS.MILK_NAME] + " shifts around to rub a little milk into your skin, gently bathing you.  Her dark fingers run through your hair, washing it thoroughly before moving down to your arms, [chest], and legs, cleansing every inch of your " + player.skinFurScales() + ".  You relax to " + flags[kFLAGS.MILK_NAME] + "'s touch, letting her massage the cares out of your weary muscles.  Around you, your followers begin to do much the same, taking turns bathing each other, scrubbing backs and extremities with the soothing milk of " + flags[kFLAGS.MILK_NAME] + "'s bounty.");
	
	outputText("\n\nThe lot of you carry on like this for nearly an hour, enjoying what little relaxation you're able to get in these dark times.  Eventually, though, you know you must return to your duties.  You and your companions one by one pull yourselves out of the pool, stopping to help " + flags[kFLAGS.MILK_NAME] + " and her bloated breasts; towels are passed around between joking and flirting hands, a few are even cracked over bare skin, making girls scream and yelp.  The camp is soon a mess of laughing and playing, with you in the center of it, teasing your lovers between shameless gropes and playful caresses.");
	player.refillHunger(50);
	player.changeFatigue(-40);
	HPChange(player.maxHP()*.33,false);
	doNext(camp.returnToCampUseOneHour);
}

//[Milk Girl]
private function pullInZeMilkGirl():void {
	clearOutput();
	outputText("You call out to " + flags[kFLAGS.MILK_NAME] + " before she can wander away, and wade over to the side of the tub, leaving your face a few scant inches from her hefty milkers.  She smiles as you reach up, nuzzling her cheek into your hand, purring your name happily.");
	
	outputText("\n\nYou flash her a mischievous grin before grabbing her waist and pulling, yanking her into the tub with you.  The milk-maid lets out a sharp cry of surprise as she tumbles in, a huge splash of cream spraying over the rim of the tub, painting the campground white.  Gasping, her head pops back over the surface of her own milk, long ebony hair dripping onto the tops of her seemingly-buoyant teats, which bob over the milky waves with a strangely serene, regal grace.  \"<i>[name]?</i>\" " + flags[kFLAGS.MILK_NAME] + " yelps as she wades through her own lactation, slowly retreating to the edge of the tub.  Chuckling, you reach out and stroke her cheek, telling her that you thought she might like a bath, too.  She starts to reply, but you cut her off with a playful stroke of her massive mounds, urging her over toward you.  She trusts you implicitly and does as you ask, sliding up under your arm and onto your lap.  Once seated, she looks up to you with saucer-like brown eyes until you cup her cheek and give her a short, tender kiss, pressing your lips to her dusky mounds.  To your delight, she seems to melt at your touch, relaxing in an instant as you hold her as close as you can, seperated only by her prodigious chest");
	if (player.biggestTitSize() >= 7) outputText(", pressing deep into your own huge rack, your nipples flicking across her own leaky tits");
	outputText(".");
	outputText("\n\n\"<i>O-oh,</i>\" she moans, just on the edge of hearing, her cheeks flushing hotly in your hand.  The cute little milkmaid turns aside, moving her udders out of the way so that she can rest her head on your chest, obviously enjoying the simple pleasure of your arm around her shoulders and the odd gentle touch.  You let her enjoy it for a few long, quiet minutes, content in the silent company of the milky girl.  From time to time you gently stroke her cow-like teats, or reach down to rub her thick, rich milk into your loins, enjoying the incredible texture of it on your ");
	if (player.gender == 1) outputText(player.multiCockDescriptLight());
	else if (player.gender == 2) outputText("[vagina]");
	else if (player.gender == 3) outputText(player.multiCockDescriptLight() + " and [vagina]");
	else outputText("sexless crotch");
	outputText(", still burning hotly with your desires");
	outputText(".  After a time, though, you give the girl a gentle little push, having her rest her arms and tits on the edge of the pool.  You shift around behind her, cupping up handfuls of her milk.  You start to pour it down her back and shoulders, getting her nice and soaked in her own sweet cream before you close in, starting to massage her back, rubbing it in nice and slow until she's shivering quietly.  She moans under her breath as your fingers sink into her soft, yielding flesh, gently kneading her shoulders and hips, giving special attention to her full, round ass, tentatively slipping a few fingers around her leg to caress along her slick vulva and the bud of her clit.");
	outputText("\n\nShe gasps when you brush against her, ");
	if (player.cor < 70) outputText("and you're quick to pull back, not wanting to force her, but to your surprise and delight, she reaches back and takes your hand in hers, moving you back to finger her");
	else outputText("and grinning with lusty fervor, you push harder, slipping your fingers into her with ease, her milk providing the perfect lubricant to penetrate her.  The slave girl trembles at your sexual advance, but either does not want to stop you out of well-trained fear, or just doesn't want you to stop");
	outputText(".  Before you can get too far, though, " + flags[kFLAGS.MILK_NAME] + " turns on a heel, her huge rack pushing you back through the milky pool and then against the opposite rim.  You're dazed for only a brief second before her breasts press firmly into your back, so hard that a new streak of milk pours from her teats, wetting your back much as you did hers.  You relax against the rim as she cups up handfuls of milk, rubbing it into your own hair and shoulders, deft fingers massaging every muscle in your back with the skill of the greatest masseuses, and you can feel the tension bleeding from your muscles.  You yawn powerfully, resting your chin on your arms and letting the milky girl massage you, coating your " + player.skinFurScales() + " in her rich, delicious milk.");
	
	//If PC has a dick:
	if (player.hasCock()) {
		outputText("\n\nOne of the milk girl's hands brushes against your thigh, slipping around your [leg]; slender fingers wrap around your [cock], milky lubricant making her soft strokes all the more pleasurable.  You groan in lusty delight as her fingers slide up and down your quickly-hardening length");
		if (player.balls > 0) outputText(", her other hand cupping your [balls], rolling the " + num2Text(player.balls) + " orbs in her palm with delightful dexterity");
		outputText(".  Leaning over the two titanic teats between you, she traces a line of kisses down your back, licking up stray drops of milk between affectionate caresses.");
	}
	//{If PC has cooch: 
	if (player.hasVagina()) {
		outputText("\n\nHer hands shift downwards, delicate fingertips slipping across the slit of your [vagina].  You gasp, shivering as her milk-slick fingers easily slip into your sodden box, her thumb swirling gently around your [clit].  Her other hand traces upwards, carressing your [hips] and [butt] before finally arriving at your [chest], which she massages with well-practiced skill.");
		//If PC has tits:
		if (player.biggestTitSize() >= 1) {
			outputText("  She cups your breasts, having to reach so far around both your rack and hers that she's straining her arms to rub your [nipples], but she does so valiantly, stroking them with her incredibly deft fingers.");
			if (player.lactationQ() >= 100) outputText("  A spurt of milk escapes your own full jugs, joining the pool-full of your friend's.  She gasps with delight, quickly nuzzling herself into your back and going to work.  She milks you just as she would herself, letting the hefty flow of your motherly fluids pour into the pool, odd trickles smearing down your chest, staining your chest as white as her own.");
		}
	}
	//[Fuck Her](PC must have gender; if cooch, also C+ cups) [Don't]
	menu();
	addButton(4,"Don't",dontFuckTheMilkWaifu);
	if (player.hasCock()) addButton(0,"Fuck Her",fuckTheMilkWaifu);
	if (player.hasVagina() && player.biggestTitSize() >= 3) addButton(1,"LesboFuck",beARugMunchingMilkDyke);
	
}
	
//	[Don't]
private function dontFuckTheMilkWaifu():void {
	clearOutput();
	outputText("You allow the girl to continue for a long, long while until your entire body feels deeply refreshed, her milk having soaked thoroughly into your body and making you feel fresh and revitalized.  You start to thank the milk girl for the pleasurable company, but when you open your mouth, she slips into your arms and presses her lips to yours.  Chuckling to yourself, you hold the girl as tight against yourself as her udders will allow, turning her to the side to let her nuzzle her cheek into your [chest], kissing the top of her head before the two of you climb from the pool.  You have to help her out, her massive extra weight nearly dragging her back in except for your quick reflexes.  You gather your [armor] and ruffle the milk slave's hair before grabbing a towel and wandering back to the heart of camp.");
	//[+Lust, +HP, -Fatigue]
	dynStats("lus", 10+player.sens/10, "resisted", false);
	HPChange(player.maxHP()*.33,false);
	player.changeFatigue(-20);
	doNext(camp.returnToCampUseOneHour);
}

//[Fuck Her] (PC has a Dick)
private function fuckTheMilkWaifu():void {
	clearOutput();
	outputText("You turn around and pull the milk-slut against you, her massive teats pressing hard against your [chest] until they spurt.  You stroke her cheeks, bringing her lips up to yours.  Her hand finds your [cock] again, stroking you with mounting speed as your tongue finds its way into her mouth, your hands wandering down to grope her sizable ass and flared, breeder's hips.  Your lover sighs heavily, breath filled with lust as you push her up against the rim of the tub, her legs spreading wide for easy access to her milk-lubed cunt.  She locks her arms around your shoulders, moaning happily as you press into her, your [cock] slipping easily into her sodden box.");
	
	outputText("\n\nSubmerged beneath a sea of creamy milk, it's so very, very easy to slide into " + flags[kFLAGS.MILK_NAME] + ", ");
	if (player.cockArea(0) < 20) outputText("pushing your few inches into her until your hips join, her nice and loose cunt easily taking your length");
	else if (player.cockArea(0) < 50) outputText("hilting her in one long stroke");
	else outputText("your cock gaining as much entrance as your massive member can, the excess dickmeat embraced in cream between you");
	outputText(".  With your prick buried in her, " + flags[kFLAGS.MILK_NAME] + " hooks her legs around your [hips] and starts to gently rock her hips, letting you take the initiative.  Smiling at the meek girl, you sink your fingers into milk-yielding titflesh and start to move your hips, thrusting into her with measured ease, letting milk flood into her channel and coat your dick to lubricate each and every stroke.");
	
	outputText("\n\n\"<i>S-so good, [name],</i>\" she moans, \"<i>Feels soooo good!  Oh gods!</i>\"");
	outputText("\n\nYou pick up the pace, thrusting in harder and harder, sloshing waves of cream into the valley of her cleavage and right over the edge of the pool.  Your lover clings tightly to you, leaking milk and a clear trail of fem-lube from her cunt as you hammer into her.  Punctuating your thrusts, you lean in and press your lips to hers, silencing her ecstatic moaning with a drawn-out kiss.  When you break it, trails of spit and milk still connect her full, dusky lips to yours, her tongue slightly lolled from her mouth with sexual bliss.  Her entire body begins to shudder, massive chest heaving as she approaches the edge.  You let yourself go as she cums, and as her first orgasmic moans echo out, you roar with primal lust and join her, smearing her milk-slick cunt with a thick glob of semen, letting another and another join it, filling her womb with your potent seed.");
	
	outputText("\n\nYou allow the girl to continue for a long, long while, quivering with sexual release as you shudder out the last drops of your cum inside her.  With a heavy sigh, you slump forward, burying your head into her prodigious bust to recover.  You grin as the milk girl wraps her arms around you, holding you tight against herself.");
	
	outputText("\n\nYour entire body feels deeply refreshed, her milk having soaked thoroughly into your body and making you feel fresh and revitalized, and every muscle seems to have relaxed thanks to your blissful coitus.  You start to thank " + flags[kFLAGS.MILK_NAME] + " for the pleasurable company, but when you open your mouth, she presses her lips to yours for a long, tongue-filled kiss.  Chuckling to yourself, you hold the girl as tight as her udders will allow, turning her to the side to let her nuzzle her cheek into your [chest], kissing the top of her head before the two of you climb from the pool.  You have to help her out, her massive extra weight nearly dragging her back in except for your quick reflexes.  You gather your [armor] and ruffle the milk slave's hair before grabbing a towel and wandering back to the heart of camp.");
	//[+Lust, +HP, -Fatigue]
	player.orgasm();
	HPChange(player.maxHP()*.33,false);
	doNext(camp.returnToCampUseOneHour);
}

//[Fuck Her] (PC has Cooch & C+cups)
private function beARugMunchingMilkDyke():void {
	clearOutput();
	outputText("You turn around in the milky pool, pulling the cute little milkmaid tight against you.  She gasps with surprise, but settles as soon as you press your lips to hers, your hands wandering across her huge teats and supple, milky body.  She nuzzles up against you, head resting on your [chest] as you hold her against yourself, stroking her dark hair.  After a few moments of such a simple pleasure, " + flags[kFLAGS.MILK_NAME] + " shifts her cheek along your breast, wrapping her full, dusky lips around your [nipple].  You let out a long moan as she suckles gently, ");
	if (player.lactationQ() >= 200) outputText("drawing out a trickle of milk from your motherly reserves.  She gulps deeply, smiling up at you as a trickle of your milk runs down her chin, dripping into the pool of her own");
	outputText(".  Her hand slips up your body, brushing your vulva and [clit] before cupping your other breast, delicate fingers wrapping around your [nipple].  With deft, practiced motion, she works your teats between her fingers, working your breast like she might her own");
	if (player.lactationQ() >= 200) outputText(", milking you with skill beyond anything you've ever experienced before; and why not, when her entire existence revolved around that self-same skill?");
	else outputText(".");
	outputText("\n\nYou lean back against the rim, putting your arms up against the lip and letting the girl put her skills to use on you, your chest soon heaving and quivering to her every touch.  You barely notice as the girl's other hand vanishes beneath the milky waves, surely going to tend to herself as her tongue and fingers squeeze and caress your ");
	if (player.lactationQ() >= 200) outputText("milky ");
	outputText("teats in the most incredible ways.  You moan and groan as she tweaks and massages, suckles and kisses your rock-hard peaks, sending electric shivers of pleasure through your chest until your entire body quivers.  Almost unconsciously you wrap your [legs] around the milky girl's waist, holding her tighter and tighter against your sodden body, forcing as much of your [nipple] into her so wonderfully skilled mouth as you can.");
	
	outputText("\n\nSoon, you can feel a strange pressure welling up through your tits.  It takes you a moment to recognize the boobgasm, but when it hits, you throw your head back in animalistic pleasure");
	if (player.lactationQ() >= 200) outputText(", spraying milk all over yourself and the milkmaid who caused your explosive pleasure");
	outputText(".  You run your fingers through the girl's hair, urging her sexual skills on as your chest heaves and quavers, riding out the massive boobgasm as femcum spurts from your cunt and into the milky pool below.");
	outputText("\n\nYour entire body feels deeply refreshed, her milk having soaked into your body and making you feel fresh and revitalized, and every muscle seems to have relaxed thanks to your blissful coitus.  You start to thank the milk girl for the pleasurable company, but when you open your mouth, she presses her lips to yours for a long, tongue-filled kiss.  Chuckling to yourself, you hold the girl as tight as her udders will allow, turning her to the side to let her nuzzle her cheek into your [chest], kissing the top of her head before the two of you climb from the pool.  You have to help her out, her massive extra weight nearly dragging her back in except for your quick reflexes.  You gather your [armor] and ruffle the milk slave's hair before grabbing a towel and wandering back to the heart of camp.");
	//[+Lust, +HP, -Fatigue]
	player.orgasm();
	HPChange(player.maxHP()*.33,false);
	doNext(camp.returnToCampUseOneHour);
}
	
//[Drink & Masturbate]
private function drinkAndFapturbate():void {
	clearOutput();
	outputText("\"<i>Wait,</i>\" you call out to the ebony woman, letting the milk obscure your hands as you begin to masturbate, \"I want a drink.</i>\"  Sheepishly, " + flags[kFLAGS.MILK_NAME] + " obligingly shifts back toward you, presenting her huge teats.");
	outputText("\n\n\"<i>Sorry, [name],</i>\" she whines, still meek as ever, \"<i>Drink more.</i>\"");
	outputText("\n\nShe rolls her shoulders, sending an enticing jiggle through the milk-weighted fluid-factories on the edge of the tub, the sable flesh of her nipples blotted by fresh drops of white.  The milky morsels roll down the undercurve of the dusky slut's tits before dripping into the tub and sending tiny waves of cream through the pool.  Her well-used teat looks almost over-engorged by this point, puffy, swollen, and a little red, even through her darkly-tanned skin.  Thick streams of her alabaster nectar start to run from each of her nipple-tips as you lean closer, the anticipation already too much for the ever-full milk-machine of a woman.");
	outputText("\n\nTaking her nipple in, you give it an experimental lick.  It's sweet from the pearly fluid, but her skin tastes faintly of her body's salts as well, and not unpleasantly.  You look down at the boob before you and realize even with the milk-spout in your mouth, you've only devoured a small portion of her teat.  The majority of her areola spreads out before you, nearly the size of ");
	if (flags[kFLAGS.MILK_SIZE] == 0) outputText("a dinner plate");
	else outputText("an open palm");
	outputText(" but far more exciting.  After taking a few swallows of her body's milky treat, you reach down to your ");
	if (player.hasVagina()) outputText("[vagina] and idly stroke your puffy, lust-engorged vulva");
	else {
		outputText("[cock] and idly stroke the turgid mass");
	}
	outputText(", inadvertently drawing a lewd moan from yourself.  The fat nipple stuffed in your mouth does an adequate job of muffling your pleasurable vocalizations");
	if (player.hasCock()) outputText(", but it does little to hide the swelling of [eachCock] - you have the milk for that");
	outputText(".");
	player.refillHunger(50);
	outputText("\n\nAn excited moan worms out of " + flags[kFLAGS.MILK_NAME] + "'s puffy lips, a testament to the raw sensitivity of her milk-bloated jugs.  As your tongue swirls over the leaky nozzle's pebbly skin, she releases another breathy pant of delight.  The vocal tremors seem to coo all the way down to your loins, joining with your fingers' caresses to stir you to aching, trembling arousal.  ");
	//{Fork, no new PG}
	//(DA HERMS)
	if (player.gender == 3) {
		outputText("Your [cock] throbs painfully in your hand, so hot and hard that you're sure you must have begun to leak precum, but any fluid is swiftly washed away by the ever-present milk.  ");
		if (player.cockTotal() > 1) outputText("You make sure to fondle each of your members equally, caressing, squeezing, and stroking to the tempo of your swelling passion.  ");
		outputText("With your off-hand, you rub your cream-lubricated fingers through your sodden gash, the flesh parting easily to allow a few of your questing fingers inside.  Delicious bliss unfolds from your [clit] as it pushes free of its hood, fully engorging, faintly throbbing from aching need.  You brush the button a few times before going back to fingering your box, yet you make sure to strum your thumb across your clit every few moments to keep yourself as close to peak as possible.  Truly, being a hermaphrodite is bliss.");
	}
	//(DA SCHLICKS)
	else if (player.hasVagina()) outputText("Your pussy juices mix freely with the tub's white-colored 'waters', allowing your cream-lubed fingers to plunge into your [vagina] with ease.  You stroke your lips and caress the interior of your birth canal with the intimate familiarity of a skilled lover, playing with your body until you feel your control slipping, so wound up with lust that you feel like an over-tightened guitar string vibrating out of control.");
	//(DA DUDES)
	else {
		outputText("[OneCock] throbs painfully in your hand, so hot and hard that you're sure you must have begun to leak precum, but any fluid is swiftly washed away by the ever-present milk.");
		if (player.cockTotal() > 1) outputText("  You make sure to fondle each of your members equally, caressing, squeezing, and stroking to the tempo of your swelling passion.");
		if (player.balls > 0) outputText("  With your offhand, you cradle your [sack], hefting your [balls] as you feel your desire churning to new levels.");
	}
	//(TOGETHER)
	outputText("\n\nA spray of warmth impacts off your shoulders, and you turn into it, delighted to see " + flags[kFLAGS.MILK_NAME] + "'s other teat unloading yet another potent blast of silky goodness.  With a little regret, you pull off, earning a hair-drenching facial, and switch to the fountaining tit-tip in a heartbeat.  You work your throat to keep up with the flow, cheeks bulging from the pressure.  Ultimately, between your limited ingurgitating ability and the spiraling waves of pleasure rolling out from your groin, you fail to get all the milk down, and it sprays from the corners of your mouth while runnels of fluid leak down to your chin.");
	
	outputText("\n\nThe tub is dangerously full by this point, milk lapping at the edges like the tide coming in, and as you climax, you briefly wonder if perhaps, it has.  White-hot heat rockets through your middle, lazily climbing your spine to make an assault on your brain.  Your jaw locks, inadvertently biting down on the chocolate-toned nipple to momentarily staunch its flow.  Pistoning seemingly of their own volition, your [hips] sway back and forth, stirring up creamy waves that splash about the room, soaking the floor and your gear with milk.");
	if (player.hasCock()) {
		outputText("  [EachCock] release its own gooey load, sputtering and spurting to add to the pearly deluge.");
		if (player.cumQ() >= 1500) outputText("  With every torrent of seed you release, you can see it lift partway out of the tub, propelled by your incredible virility towards the nearest female specimen.");
		if (player.cumQ() >= 4000) outputText("  Soon, the tub's fluid contents break out of their confines to stain your companion's dusky flesh white, an alabaster glaze that would entice you to further feats of debauchery were it not for the pleased contentment your maleness now radiates.");
	}
	if (player.hasVagina()) outputText("  Meanwhile, your juiced-up cunny feels like it's doing backflips inside you, contorting and squeezing as it gushes with fluid, feminine joy.  One brush on your [clit] knocks your [legs] out from underneath you, but thankfully, you float out the rest of your orgasm.");
	
	outputText("\n\nA drawn out, low coo of contentment emanates from the other girl as you separate from her, and she bashfully whispers, \"<i>Thank you,</i>\" as she ");
	if (flags[kFLAGS.MILK_SIZE] == 0) outputText("drags her gigantic tits over the puddly, milk-slicked floor");
	else outputText("stumbles away, tenderly cupping her bright-red teats");
	outputText(".  Smirking and sexually sated, you pop the drain in the tub and stand there while the sex-scented lactic bathwater runs out the drain.  A quick toweling off later, and you're ready to go, feeling slightly refreshed and fairly sated.  It does take you a little longer to get your [armor] equally dry and back in place, but you manage.");
	player.orgasm();
	player.changeFatigue(-33);
	doNext(camp.returnToCampUseOneHour);
}

private function nyanCatMilkTime():void {
	clearOutput();
	//Milk Time!  (HHH Boobs ver.)
	if (flags[kFLAGS.MILK_SIZE] == 1)
	{
		outputText("\"<i>Milk time!</i>\" you say, giving " + flags[kFLAGS.MILK_NAME] + " a playful swat on her upturned ass, walking around her to the pool.  You jump in and toss your [armor] back out as the milky witch gets situated, well aware of just how much milk this poor girl's about to blast you with, even with her much reduced bosom.  Still, she's gotta be milked, and you're thirsty.  Milk time indeed.");
		
		outputText("\n\nOnce you've disrobed, and " + flags[kFLAGS.MILK_NAME] + "'s got her giant jugs situated at the edge of the pool, you get to work.  Rubbing your hands together, you place each over top one of her palm-sized areola, gently running your fingers around the bases of her teat-like nipples, though with every motion your hands seem to be engorged into the massive mounds, sucked into a blackhole of titflesh.  With every touch, though, " + flags[kFLAGS.MILK_NAME] + " shudders and moans, biting her lower lip as her arms quiver with pleasure.");
		
		outputText("\n\nIn a matter of moments, you coax out the first explosive spurt of milk from your friend's teats, two hot streams of white cream blasting you in the face and drenching you before you can blink.  \"<i>S-sorryyyyyyyy,</i>\" she whines, voice turning into an ecstatic moan as you grip her nipples and start working vigorously, not letting the milky stream die down for an instant.  " + flags[kFLAGS.MILK_NAME] + " moans and groans as you roughly milk her, rewarded with gallon after gallon of delightful motherly milk.");
		
		//If PC has Smart/Normal Sophie:
		if (sophieFollowerScene.sophieFollower()) outputText("\n\nAs you milk " + flags[kFLAGS.MILK_NAME] + ", you see a shadow flash overhead.  You look up in time to see your harpy broodmother perching at the rim of the pool, just beside " + flags[kFLAGS.MILK_NAME] + "'s quivering body.  \"<i>Fresh milk!</i>\" Sophie laughs, cupping up a handful and bringing it to her mouth.  \"<i>You don't mind if Momma Sophie has a taste, do you honey?</i>\"\n\nThe milky girl shakes her head, barely paying attention as Sophie flops down beside her, avian tongue lapping at the stream pouring down into the pool.");
		
		//If PC has Kiha:
		if (kihaFollower.followerKiha()) outputText("\n\nFeeling like you're being watched, you cast a glance over your shoulder in time to see the dusky form of Kiha standing behind you.  She simply says \"<i>Ew,</i>\" before walking off.");
		
		//If PC has Isabella:
		if (isabellaFollowerScene.isabellaFollower()) {
			if (isabellaFollowerScene.isabellaAccent()) outputText("\n\n\"<i>Tsk, [name].  Vhat are you doing to zhat poor voman?");
			else outputText("\n\n\"<i>Tsk, [name], what're you doing to that poor girl?");
			outputText("</i>\" You look up from your task to see Isabella looming over the pool, hands on her wide hips.  \"<i>You are going MUCH too hard on her, poor ");
			if (isabellaFollowerScene.isabellaAccent()) outputText("zing");
			else outputText("thing");
			outputText(".  Let Isabella show you how ");
			if (isabellaFollowerScene.isabellaAccent()) outputText("es ist");
			else outputText("it's");
			outputText(" done.</i>\"  You find yourself roughly pushed aside as Isabella jumps in with you, tossing her skirt and blouse aside as she grasps " + flags[kFLAGS.MILK_NAME] + "'s teats, massaging them much more gently.  The milk girl's eyes roll back in her head as Isabella sets to work, though it gets harder and harder as the milk flows up to her thighs and chest.");
		}
		
		//If PC has ONLY KIha or if PC dun have Izzy, Sophie, OR Kiha: 
		if (!isabellaFollowerScene.isabellaFollower() || !sophieFollowerScene.sophieFollower()) outputText("\n\nIt takes a good long while to get " + flags[kFLAGS.MILK_NAME] + "'s bloated tits under control, but nearly an hour later you've milked her as well as you can for now.  Sopping wet, you pull yourself out of the pool and grab a towel.  With her tits lightened for the moment, " + flags[kFLAGS.MILK_NAME] + " reaches up and pulls you down to her, just long enough to plant a kiss on your cheek and whisper, \"<i>Thank you, [name].  That felt good.</i>\"");
		
		//If PC has Sophie or Isabella:
		else outputText("\n\nThough you didn't intend for this to turn communal, " + flags[kFLAGS.MILK_NAME] + " certainly has more than enough to share.  You relax as the last trickles of milk pour into the pool, her breasts looking positively deflated.  You decide to leave the plug in for your friends as you clamber out, figuring they'll want to stockpile a little for the day before you drain it.  With her tits lightened for the moment, " + flags[kFLAGS.MILK_NAME] + " reaches up and pulls you down to her, just long enough to plant a kiss on your cheek and whisper, \"<i>Thank you, [name].  That felt good.</i>\"");
		player.changeFatigue(-50);
		dynStats("lus", 10+player.sens/10, "resisted", false);
		doNext(camp.returnToCampUseOneHour);
	}
	//Milk Time!  (DD Boobs Ver.)
	else {
		outputText("You sit yourself down with " + flags[kFLAGS.MILK_NAME] + " and ask if she'd like a good milking.  Her eyes brighten at the suggestion, and she whispers \"<i>Yes please,</i>\" already pulling off her shirt.  You help her get her top and bra off, leaving her full, perky breasts bare in the cool sun.  You slip behind her, running your hands across her sun-kissed skin, tracing your fingers from hips to chest; " + flags[kFLAGS.MILK_NAME] + " shivers at your slightest touch, whining lustily as your hands wrap around her milk-laden mounds.  Her reddened nipples are rock-hard by the time your fingers brush up against them, perspiring clear pearlescent drops as you circle her wide areola.");
		outputText("\n\n" + flags[kFLAGS.MILK_NAME] + " whimpers as you squeeze a tiny trickle from her teats, the white fluid squirting out in a powerful arc, staining the campground for the briefest moment before the hungry earth swallows it up, leaving no trace but a darkened patch at the girl's knees.  Gently, you start to squeeze and knead " + flags[kFLAGS.MILK_NAME] + "'s breasts, holding her back against you as you massage the heavy burden from her seemingly unending reserves.  A steady stream of milk pours from her chest, dribbling down between your fingers and her flat belly.  Soon a pool's formed around your [legs], the barren earth not nearly fast enough to consume the bounty flowing from your friend.");
		
		outputText("\n\nWith each caress and squeeze, " + flags[kFLAGS.MILK_NAME] + " shivers and shakes, her chest soon heaving with her ragged, pleasure-strained breath.  You can see her lustful secretions stain her paintes as her hidden cunt quivers, desperate for attention as you milk her over-sensitive mammaries.  Her breathing becomes more irregular, her long legs quaking and eyes rolling back as you squeeze out gallon after gallon.  Her whimpers of pleasure become outright cries, piercing the quiet of camp with orgasmic moans and shrill screams as your fingers work their magic on her, sending shockwaves of pleasure from hefty teats to sex-addled mind  that make her entire body convulse and writhe at your touch.");
		
		outputText("\n\n\"<i>N-no more.  Can't...  take it...  please.  Ahhhhh,</i>\" " + flags[kFLAGS.MILK_NAME] + " cries, squirming in your embrace, your hands firmly locked on her tits, milking her for every drop.  She's in for a mighty boobgasm in mere moments: you could soothe her through it with a gentle suckle or finish her off normally.");
		//If PC has a cock that fits:
		if (player.cockThatFits(50) >= 0 && player.hasCock()) outputText("  Then again, maybe you could hike her panties down and give her a good fucking to send her over the edge.  In her state, she certainly won't mind!");
		menu();
		addButton(0,"Normal",finishMilkNormall);
		addButton(1,"Suckle",suckleDatMilk);
		if (player.cockThatFits(50) >= 0 && player.hasCock()) addButton(2,"Fuck", fuckDatMilkSlat);
	}
}

//[Finish Normally]
private function finishMilkNormall():void {
	clearOutput();
	outputText("You whisper a few soothing words into " + flags[kFLAGS.MILK_NAME] + "'s ear, but are unrelenting in your task.  With squeezing and kneading fingers, you continue to coax the milk from her tits until she's practically white with flowing cream.  A few minutes later though, you can physically feel her explode over the edge of bliss: the stream of milk from her stiff nipples doubles, blasting an arc several feet long as her voice breaks, a shrill cry to the heavens; " + flags[kFLAGS.MILK_NAME] + "'s entire body shudders, her legs nearly giving out as the boobgasm rocks her slender frame.");
	
	outputText("\n\nAs soon as the explosive boobgasm subsides, she collapses back against you, chest heaving with pleasured exhaustion.  The milky stream trickles down to naught, her breasts momentarily depleted.  " + flags[kFLAGS.MILK_NAME] + " looks up at you and smiles ever so slightly, caressing your cheek before cupping her obviously-sore teats and staggering to her feet, searching for a towel.");
	outputText("\n\n\"<i>Thank you, [name],</i>\" she says simply as you dry yourself off.");
	player.changeFatigue(-50);
	dynStats("lus", 10+player.sens/10, "resisted", false);
	doNext(camp.returnToCampUseOneHour);
}
//[Suckle]
private function suckleDatMilk():void {
	clearOutput();
	outputText("You release " + flags[kFLAGS.MILK_NAME] + "'s breasts, giving her a moment to catch her breath as you pull her up onto your lap, turning her to face you.  She looks at you with lust-marred eyes, breath hot and heavy on your " + player.skinFurScales() + " as you gently caress her heaving bosom.  You wrap your fingers around her left teat, coaxing out the slightest of trickles before bringing it to your waiting lips.  You kiss her reddened peak, tongue rolling across the peak of her teat, rewarded with a strong gush of sweet cream that bulges your cheeks before you can swallow.  It's as if she never runs dry; an ever-flowing stream of milk pours from her breast, forcing you to swallow again and again, barely able to keep up until cream trickles down your cheeks.");
	
	outputText("\n\nIn response to your gentle suckles and the flicking of your tongue across her sensitive buds, " + flags[kFLAGS.MILK_NAME] + " whimpers and shivers, your every touch electric to the ever-lactating girl.  Her slender arms wrap around your shoulders, holding herself to you as you greedily drink from her bountiful reserves.  She gasps as you reach down and sink your fingers into the full orbs of her ass, rubbing and kneading the soft, yielding flesh just as you did her breasts before.  Her cute gasps of pleasure fill the air, and she gives a shrill cry of surprise and ecstasy as you switch from one leaking teat to the other, which explodes a deluge of milk into your waiting mouth at the barest touch, flesh quivering in motherly release as you drink gallon after gallon.");
	
	outputText("\n\nOver a few short minutes, " + flags[kFLAGS.MILK_NAME] + "'s breath becomes increasingly erratic, her chest heaving hard, pushing your face from her with every heavy breath she takes.  The girl's voice soon gives out, giving way to husky moans and whispers of praise to your oral skills, thanking you again and again for the gentle, tender release you're bringing her to.  She runs her fingers through your hair as her body undulates atop you, responding to every suckle and caress with more milk and shudders of pleasure.");
	
	outputText("\n\nHer orgasm is as powerful as it is inevitable.  " + flags[kFLAGS.MILK_NAME] + " throws her head back, a silent cry escaping her lips as her fingers dig into your flesh, gripping you as tight as she can as the stream of milk passing your lips grows and grows and grows in power until you're nearly drowning.  White rivers from your mouth as you struggle to keep up with the unforgiving flow, swallowing fast to keep from drowning in her orgasmic release.  " + flags[kFLAGS.MILK_NAME] + " cries and squeals as her body is rocked by boobgasm, the breast not firmly in your grasp spraying wildly, creating a lake around the two of you.  You can see her thin panties darken with fem-cum, a few of her fingers darting down to rub her hidden nub, masturbating to the rhythm of the cream spurting from her breasts.");
	
	outputText("\n\nEventually, the boobgasm subsides, leaving " + flags[kFLAGS.MILK_NAME] + " a quivering, panting pile of lust in your arms, her fingers absently rubbing through her panties as the last dribbles of milk trickle down her chest and your chin.  Taking the first deep breath you've managed to get in the last few minutes, you grab a towel from nearby and try to dry yourself and the leaky girl off as best you can, brushing off the gallons of milk that have washed over you both.  When you're done, " + flags[kFLAGS.MILK_NAME] + " leans over and plants a long, lusty kiss on your lips, her tongue lapping up little drops of her own milk still inside your mouth.  She breaks the kiss after a long, pleasant moment, whispering \"<i>Thank you, [name].</i>\"");
	player.slimeFeed();
	player.refillHunger(50);
	player.changeFatigue(-50);
	dynStats("lus", 10+player.sens/10, "resisted", false);
	doNext(camp.returnToCampUseOneHour);
}
//[Fuck Her] (Needs a dick what fits)
private function fuckDatMilkSlat():void {
	clearOutput();
	var x:int = player.cockThatFits(50);
	outputText("Sitting behind the milky girl, chest pressed to her back tight enough to feel her every breath, you can't help but feel " + flags[kFLAGS.MILK_NAME] + "'s full, round ass brushing against your " + player.cockDescript(x) + ".  Responding to her touch, your prick begins to stiffen, filling out through your [armor] and into the valley of " + flags[kFLAGS.MILK_NAME] + "'s ass.  She gasps ever so slightly when she feels your prick pushing against her silky undergarments, but you can feel her heart race, her flesh heating as she starts to move her ass more deliberately, rubbing you from stem to head.");
	
	outputText("\n\nOne of your hands drifts down from " + flags[kFLAGS.MILK_NAME] + "'s teats, fingers tracing along her supple skin and ample curves to the hem of her panties.  You pull them down with one smooth motion, baring the full mounds of her dusky ass cheeks.  She pushes back immediately, humping up and down your rod as you work to free yourself from your [armor].  Finally, your " + player.cockDescript(x) + " pops free from its binds, only to be instantly buried in " + flags[kFLAGS.MILK_NAME] + "'s rear cleavage; she gives a happy, girlish giggle when your throbbing rod pushes through her valley, practically bouncing on your cock.  You wrap your arms around her waist, one hand working her still-needy teats as the other dives between her legs, easily slipping a few fingers into her sodden gash.  " + flags[kFLAGS.MILK_NAME] + " moans lustily as your digits enter her, biting her lower lip when your fingertips caress her inner walls and spasming muscles, soon soaked in her feminine fluids.  Your thumb swirls around the bud of her clit, drawing ragged gasps of pleasure from her lips until you silence her with a kiss, driving your tongue into her mouth as your fingers assault her cunt, fingering her until she's nice, wet, and ready.");
	
	outputText("\n\nYou shift forward ever so slightly, dragging your " + player.cockDescript(x) + " from " + flags[kFLAGS.MILK_NAME] + "'s butt-cleavage and into the welcoming embrace of her womanhood.  You both moan with lust as your " + player.cockHead(x) + " presses into her, parting the folds of her cunny to feel the hot touch of her walls kissing your tip.  You slide into her with measured ease, " + player.cockDescript(x) + " spreading her walls wide as your hips move to meet, your groin pushing against her bubble butt, flesh yielding as you try and slide as much cockflesh into her eager channel as you can.");
	outputText("\n\nBy the time you've hilted " + flags[kFLAGS.MILK_NAME] + " she's a mess, cunt drooling obscenely and tongue hanging from her mouth.  Her chest heaves in your hands as your fingers wrap back around her cherry-red nipples, her milk coming in erratic spurts as she undulates on your cock, hips and ass starting to bounce atop you.  You move to match her, hammering your [hips] home to meet her, thrusting your " + player.cockDescript(x) + " into her clinging depths.  " + flags[kFLAGS.MILK_NAME] + " cups her hands to her breasts, pooling up handfuls of milk and splashing them onto your prick and her gash, nearly dousing the heat of your lust with the rush of cool cream; but another jack-hammer thrust shows her milk to be a magnificent lubricant, letting you slip and slide into her with ease.  Soon you're both moaning your lust, pleasured gasps and sighs echoing through the camp as you fuck " + flags[kFLAGS.MILK_NAME] + "'s dripping cunt.");

	outputText("\n\nYou can feel your orgasm mounting, surging on as your " + player.cockDescript(x) + " hammers relentlessly into " + flags[kFLAGS.MILK_NAME] + ".  With an animalistic roar, you push her down onto all fours and grab her ass for leverage.  She squeals when you push her down, but she recovers in an instant, wiggling her ass tantalizingly as your fingers sink into her pliant flesh.  With a vision full of that big, soft ass swaying as your dick pounds " + flags[kFLAGS.MILK_NAME] + "'s, you can't help but cum.  You grint your teeth and give " + flags[kFLAGS.MILK_NAME] + " a hard spank right on the ass, making her shriek with pleasure and pain, her cunt squeezing your " + player.cockDescript(x) + " at just the right moment: you shoot a load of white-hot seed straight into her womb, dick buried to the hilt inside her.  Around your spasming cock, " + flags[kFLAGS.MILK_NAME] + "'s quim quivers and contracts, milking you for every drop; her teats let loose a wild stream of milk which pools around you, nearly hiding the excess spooge that pours from her battered cunny to stain the earth.");
	
	outputText("\n\nWhen your dick's finally depleted its load, you pull out with a contented sigh, wiping the last drops of spunk off on " + flags[kFLAGS.MILK_NAME] + "'s thigh.  She rolls over, a lust-dazed smile on her face, idly fingering her well-stuffed cunt and caressing her ample bosoms.  A momentary come-hither look from her beckons you over, and " + flags[kFLAGS.MILK_NAME] + " pulls you into her arms with a girlish giggle, resting you on your back and nuzzling her cheek on your [chest].  You drift off into pleasant repose, both sexually contented and your lover well-milked.");
	player.orgasm();
	dynStats("sen", -1);
	player.changeFatigue(-10);
	doNext(camp.returnToCampUseOneHour);
}

//Titfuck (ie, an Excuse for Savin to use "Lactic Lust" because Fen just taught him that and he has fallen in love) (Requires DD or HHH tittehs & a dick)
private function titFuckDatMilkSlut():void {
	clearOutput();
	outputText("You sit down beside " + flags[kFLAGS.MILK_NAME] + " and give her a little push onto her back.  A tiny gasp escapes her lips, but is silenced as you move over top her and giver her a long, tongue-filled kiss.  Her surprise turns into a lusty moan as you ");
	if (flags[kFLAGS.MILK_SIZE] == 2) outputText("pull off her shirt and bra");
	else outputText("sink your fingers into her udder-like teats");
	outputText(", caressing her sensitive breasts until a gentle stream of milk runs down her chest.  Her breath catches in anticipation as you back off a moment, freeing your [cock] from your [armor] and letting it flop onto her bare belly.  However, your hips slide forward away from her already-wet cunt and towards the enticing valley of her cleavage.  To your delight, the attention you're about to lavish on her breasts seems to excite " + flags[kFLAGS.MILK_NAME] + " as much as a good fucking, and her breath picks up excitedly as your cock slips between her teats.  With a little urging, she cups her breasts and squeezes them together around your rock-hard member, enveloping it in the warm embrace of her dusky flesh.");
	
	outputText("\n\nBefore you can start to thrust into her chest, you reach down and pinch her nipples, rolling the two prominent peaks between your fingers, coaxing out a bigger and bigger flood of milk from her deep reserves.  White rivers run down from her mounds, a deluge flooding down into the valley around your [cock].  You shudder as the warm, thick cream pours in around your member.  " + flags[kFLAGS.MILK_NAME] + " reaches in and rubs it into your cockflesh with slow, sensuous motions, gently stroking you off as more and more whiteness submerges your wang. Overcome by your lactic lust, you lean in and lap up the run-off from the lake of milk between " + flags[kFLAGS.MILK_NAME] + "'s leaky breasts.  Your senses hum at the of taste sweet cream tinted with lust, and as if on their own accord, your [hips] start to slide forward, your [cock] gliding between her tits like it would a well-lubed cunt.  " + flags[kFLAGS.MILK_NAME] + " giggles at the sensation, squeezing her tits tightly together around your wang.");
	
	outputText("\n\nYou grab her shoulders for support and start to really get going.  Your hips move faster and faster, groin pounding into the undersides of " + flags[kFLAGS.MILK_NAME] + "'s tits as you hammer into her milk-drenched cleavage.  She feels just as good as a warm, wet pussy around your cock, but with an added bonus: as the [cockHead] of your [cock] peaks out between the tops of her breasts, " + flags[kFLAGS.MILK_NAME] + " leans her head up and wraps her full lips around it, her tongue flicking across the slit of your urethra and sending shivers of pleasure down your spine.  A low, husky moan escapes you as " + flags[kFLAGS.MILK_NAME] + " sucks your cock at the crest of every thrust, putting all her suckling skill to work on your brim until your [cock] feels practically afire with pleasure.");
	
	outputText("\n\nCoaxed on by " + flags[kFLAGS.MILK_NAME] + "'s oral ministrations, you abandon her breasts for a moment, ");
	//If not naga:
	if (!player.isNaga()) outputText("straddling her shoulders and shoving");
	else outputText("wrapping yourself around her to shove");
	outputText(" your [cock] deep into her mouth.  " + flags[kFLAGS.MILK_NAME] + " accepts it eagerly, opening wide as you stuff inch after inch of your manhood down her throat.  Now she can really go to work: her lips wrap tight around your base, tongue lapping at your underside like candy as her throat muscles massage the shaft.  You slide in and out, watching her throat bulge and contract with each thrust");
	if (player.balls > 0) outputText(", shivering as her tongue darts out around your cock to flick your nads");
	outputText(".");

	outputText("\n\nJust as soon as you're settling into a rhythm, though, " + flags[kFLAGS.MILK_NAME] + " surprises you with a sudden shift, rolling over onto all fours and taking your with her.  You flop onto your back, yelping in surprise as the busty maid tops you, her cheek resting in your thigh.  You start to protest, but are quickly silenced as her tongue wraps around the base of your cock, sliding up your fuckpole with languid ease.  You shudder and relax, content to let her put her tremendous oral proficiency to good use; and use it she does, soon getting onto all fours over your [cock], dragging her huge tits across the upright length until the sheer weight of her rack weighs your mighty penis down, pinning it to your belly.  Gently, she rocks her body forward, dragging her well-lubed tits up and down your length, only saving the [cockHead] for her mouth.  She leans down until you can feel every hot breath on your sensitive skin.  " + flags[kFLAGS.MILK_NAME] + " takes her time, only slowly rolling her tongue around your crown, flicking her tip across your urethra and lapping up the pre that's now spurting liberally from your [cock].  You groan and clench your fists, trying to bear through the combination titfuck and blowjob, but you just can't withstand her ministrations.");

	outputText("\n\nWith one last surge of sexual energy, you wrap your [legs] around " + flags[kFLAGS.MILK_NAME] + "'s shoulders and roll her over again, putting yourself back on top with cock held firmly between her hefty tits.  You jackhammer your [hips] into her underboobs, digging your fingers into her soft flesh and savaging her nipples until she's breathing hard and moaning, milk sloshing down into her cleavage again to perfectly lubricate your last thrusts until, with a feral roar, the first thick globs of your creamy spunk burst forth, mixing momentarily with the sea of milk around your [cock] before spattering onto " + flags[kFLAGS.MILK_NAME] + "'s neck, giving her an instant pearl necklace.  Your cock spasms again and again, shooting jizz into the lake of milk until her breast-valley is a frothy admixture of cum and cream around your prick.  With a mischievous grin, you reach in and scoop up a double-handful of the solution you've made, and hold it up to " + flags[kFLAGS.MILK_NAME] + "'s lips.  She smiles lustily up at you before suckling it all up, drinking every offered drop of sweet cream and seed.");
	
	outputText("\n\nYou sigh contentedly and give " + flags[kFLAGS.MILK_NAME] + " an affectionate pat on the boob, watching as her flesh quivers at your touch.  She smiles at you with a lusty warmth, blowing you a kiss as you grab a towel to dry yourself off; you look back to see her happily masterbating, finishing the job you started with one hand knuckle-deep inside her as the other idly plays with the frothy cream you've left between her boobs.");
	player.orgasm();
	dynStats("sen", -1);
	player.changeFatigue(-10);
	doNext(camp.returnToCampUseOneHour);
	
}
	}
}
