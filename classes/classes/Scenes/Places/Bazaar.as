﻿package classes.Scenes.Places{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Plains.BazaarGatekeeper;
import classes.Scenes.Places.Bazaar.*;
import classes.Scenes.SceneLib;

import coc.view.ButtonDataList;

public class Bazaar extends BaseContent {
// JOEY_OFFERED_MILKER:int = 466;
// OWN_MAIDEN_BIKINI:int = 770;
// COUNTDOWN_TO_NIGHT_RAPE:int = 872;
// SOCK_COUNTER:int = 895;
// SOCK_HOLDING:int = 896;
// FOUND_SOCKS:int = 897;
// SOCKS_BOUGHT:int = 898;
// GILDED_JERKED:int = 899;
//Set Up With The Travelling, Tainted Bazaar
public function Bazaar(){
}
		public var blackCock:BlackCock = new BlackCock();
		public var benoit:Benoit = new Benoit();
		public var cinnabar:Cinnabar = new Cinnabar();
		public var fapArena:FapArena = new FapArena();
		public var lilium:Lilium = new Lilium();
		public var roxanne:Roxanne = new Roxanne();

//[Find Travelling Bazaar]
public function findBazaar():void {
	clearOutput();
	if(flags[kFLAGS.BAZAAR_ENCOUNTERED] == 0) {
		flags[kFLAGS.BAZAAR_ENCOUNTERED]++;
		outputText("Warm, earthy breezes drift by as you explore the wind-blown grasses of the plains.  Though it seems you can see for miles, with the grasses subtly shifting between a few feet and over a dozen feet tall, it's impossible to tell what you'll stumble into next.  You trust your ears and your nose as much as your oft-blocked vision at this point, and before long you catch a whiff of blackened meat and aromatic spices.  There's some kind of camp not far away!\n\n");
		outputText("You raise your [weapon] and cautiously creep through the towering vegetation, trying not to give your position away until you've ascertained just what type of people inhabit this camp.  Bright light flickers through the grass in front of you, and you part it to peek from between the blowing stalks.  There's a ring of brightly colored wagons set up here, with a tall, picketed fence erected around them.  Smoke curls up from the camp's center, twisting in the air like a viper in the grass.  Each of the wagons appears to be expanded, deployed into a small, self-contained structure.  Clearly this is some kind of traveling caravan or bazaar.\n\n");
		outputText("There's only one gap in the fence – a narrow gate watched by a ten-foot tall man with red skin and a pale, almost sky-blue turban.  He has a pair of scimitars that hang from a simple, leather belt.  The crimson-skinned man's clothing is a simple tunic and loose-fitting pants, but neither can conceal his obviously well-muscled frame.  He looks alert and attentive – a good sign since demons would have little need to post guards.");
	}
	else outputText("Once again you smell a campfire through the tall grass, and as you close the distance you hear the familiar sounds of the traveling bazaar.  You peek through the weeds and behold the caravan's gate-keeper - a red-skinned, muscular giant of a man.");
	outputText("\n\nDo you approach?");
	//[YES] [NOOOO]
	doYesNo(approachBazaarGuard,explorer.done);
}

//[FUCK YES I WILL PUT IT IN YOUR BIZARRE ANUS]
private function approachBazaarGuard():void {
	clearOutput();
	outputText("You step from concealment and walk up to the strange man, calling out in greeting.  He folds his arms across his chest and looks you up and down, peering at you with intense, black eyes.  They aren't solid onyx, but his irises are just as dark as the seemingly bottomless depths of his pupils.  His appraising gaze watches you, unblinking as second after second ticks by.  Just when you start to wonder if he speaks your language, he interrupts you by saying, \"<i>");
	if(player.cor < 33 - player.corruptionTolerance) outputText("Leave at once.  You are not yet ready for the wonders of the Bazaar.");
	else outputText("Welcome to the Bizarre Bazaar.  Enter, but be mindful of your actions within.");
	outputText("</i>\"");
	menu();
	if (player.cor < 33 - player.corruptionTolerance) addButton(1, "FIGHT!",initiateFightGuard);
	else addButton(1, "Enter", enterTheBazaar);
	addButton(3, "Leave", explorer.done);
}

public function enterTheBazaar():void {
	explorer.stopExploring();
	if (model.time.hours == 19 || model.time.hours == 20) {
		flags[kFLAGS.COUNTDOWN_TO_NIGHT_RAPE]++;
		if (flags[kFLAGS.COUNTDOWN_TO_NIGHT_RAPE] % 4 == 0 && (player.gender == 1 || (player.gender == 3 && player.mf("m", "f") == "m")) || flags[kFLAGS.LOW_STANDARDS_FOR_ALL]) {
			nightBazaarButtfuck();
			return;
		}
	}
	enterTheBazaarAndMenu();
}

//Pure? You'll have to fight!
public function initiateFightGuard():void {
	clearOutput();
	outputText("You ready your [weapon] and assume a combat stance! He grabs his dual scimitars! It's a fight!");
	startCombat(new BazaarGatekeeper());
}

public function winAgainstGuard():void {
	explorer.stopExploring();
	clearOutput();
	outputText("With the gatekeeper defeated, you walk right past the unconscious guard and enter...");
	cleanupAfterCombat(enterTheBazaarAndMenu);
}

//[Enter]
public function enterTheBazaarAndMenu(demons:Boolean = true):void {
	clearOutput();
	spriteSelect(null);
	outputText(images.showImage("location-bazaar"));
	//Make sure flags to allow entrance is set.
	if (flags[kFLAGS.BAZAAR_ENTERED] == 0) flags[kFLAGS.BAZAAR_ENTERED] = 1;
	if (flags[kFLAGS.THE_TRENCH_ENTERED] == 13) eventLiquidDiamond();
	else {
		outputText("You breeze past the crimson guard and enter the interior of the Bizarre Bazaar.  The ground is hard-packed, trampled as if walked over by hundreds of hooves, paws, and feet.  A massive bonfire rages in the center of the clearing, crackling and popping as it consumes its fuel gluttonously.  Surrounding the blazing behemoth are tiny, wheeled food-carts with vendors hawking everything from sausage to something called a 'marshmallow'.  Huge wagons ring the clearing, many set up to display exotic wares or services.  You can see everything from dancing centaurs to demons browsing the wares, but it seems an uneasy truce of sorts reigns here.  Then again, maybe the demons have just not had the chance to openly attack this place yet.");
		outputText("\n\nOne of the wagons proudly proclaims itself to be \"Greta's Garments,\" though both 'G's are emphasized with cute, stylized devil horns, and the 'S' is shaped in the form of a spaded, demonic tail.  Obviously it must some kind of clothing shop.");
		roxanne.RoxanneAppearance();
		benoit.setBenoitShop();
		fapArena.fapAppearance();
		blackCock.blackCockDescription();
		menu();//Set menu. The top row is always available.
		addButton(0, "Shops", shopMenu);
		addButton(1, (flags[kFLAGS.FAP_ARENA_RULES_EXPLAINED] > 0 ? "Fap Arena" : "Tent"), fapArena.fapArenaGOOOO);
		addButton(2, "Food Tent", blackCock.enterTheBlackCock).hint("The incredible smell seems to come from that tent.", "The Black Cock");
	//	addButton(4, "Back Alley", investigateBackAlley).hint("That back alley looks suspicious. Do you dare investigate?");
		//Cinnabar
		if (model.time.hours >= 15 && model.time.hours <= 20) addButton(5, (flags[kFLAGS.CINNABAR_NUMBER_ENCOUNTERS] > 0 ? "Cinnabar" : "Rat"), cinnabar.cinnabarAppearance(false));
		//Griping Demons
		if(flags[kFLAGS.BAZAAR_DEMONS_CONVERSATION] == 0 && rand(4) == 0 && demons) {
			overHearDemonsAboutSyrena();
			return;
		}
		if((flags[kFLAGS.BAZAAR_DEMONS_CONVERSATION] == 1 || flags[kFLAGS.BAZAAR_DEMONS_CONVERSATION] == 2) && demons && rand(10) == 0) {
			//[Repeat Variant]
			outputText("\n\n<b>The familiar sounds of the two griping demons can be heard nearby.  Do you listen in again?</b>");
			addButton(6, "GripingDemons", overHearDemonsAboutSyrena).hint("Overhear the conversation of the two griping demons.", "Griping Demons");
		}
		//Lilium
		if (lilium.LiliumText(false) != null) {
			addButton(7, (flags[kFLAGS.TIMES_FUCKED_LILIUM] > 0 ? "Lilium" : "Demon"), lilium.LiliumText(false));
		}
		//Roxanne
		addButton(8, (flags[kFLAGS.ROXANNE_MET] > 0 ? "Roxanne" : "Lizans"), (flags[kFLAGS.ROXANNE_MET] > 0 ? roxanne.RoxanneChooseApproachOrRepeat : roxanne.Roxanne1stApproach));
		//Bimbo Niamh
		if (flags[kFLAGS.NIAMH_STATUS] == 2 && flags[kFLAGS.NIAMH_MOVED_OUT_COUNTER] == -1) {
			outputText("\n\nThe sounds of voices raised in song and girlish laughter makes it obvious where Niamh is holding a perpetual party.");
			addButton(9, "Niamh", SceneLib.telAdre.niamh.bazaarNiamh);
		}
		if (flags[kFLAGS.JINX_LVL_UP] < 1) {
			if (flags[kFLAGS.JINX_LVL_UP] > 0) addButton(10, "Minx", SceneLib.jinxFollower.bazaarEncounters);
			else addButton(10, "???", SceneLib.jinxFollower.bazaarEncounters);
		}
		addButton(14, "Leave", camp.returnToCampUseOneHour);
	}
}

private function eventLiquidDiamond():void {
	outputText("A man seems to be standing on a series of crates in front of a small crowd, holding what looks like a large glass bottle with some sort of sparkly liquid. Is this the ‘Liquid Diamond’ Grayda mentioned? It could be worth an investigation.\n\n");
	outputText("\"<i>That’s right folks, a potion of eternal youth! Guaranteed to put you back in your prime for the low, low cost of 5000 gems!</i>\" At that mention, the crowd seems to disperse. Leaving only you and the man.\n\n");
	outputText("\"<i>You there! Are you interested in buying this miracle drink?</i>\"\n\n");
	outputText("It seems this con artist isn’t very convincing, but you need that bottle regardless of the snake oil salesman’s intentions, so you’ll play along for now. And you give the sleazy man "+(silly() ? "who is obviously voiced by Danny Devito ":"")+"a nice smile and \"<i>yes sir!</i>\"\n\n");
	outputText("The odd man hops down from the stack of crates, several of his features showing severe taint. \"<i>Excellent! Why don’t you take a sample sniff.</i>\" The man quickly uncorks the bottle before putting it underneath your nose as he tries to hold back a gag from the presumably foul smell.\n\n");
	outputText("Or at least that’s what you think he’s smelling, but to you, it smells like cherry trees baked into a nice citrus cake. Your daydreaming is interrupted however by another onset of itching assaults your eyes.\n\n");
	outputText("\"<i>It could be yours! For only 7000 gems.</i>\"\n\n");
	outputText("7000 gems? That’s 2000 more than he originally offered!\n\n");
	outputText("\"<i>It’s very obvious this is something you want, and you react uniquely to it, so it’s 7000 gems or nothing.</i>\"\n\n");
	outputText("Well, it seems like you have a choice to make here; you could either pay him the required amount or tell him you don’t have that many gems on you. However, he doesn’t look particularly strong, and you could easily overpower him and flee the scene with the bottle, but you feel like this may come to bite you back later.\n\n");
	menu();
	addButtonIfTrue(1, "Pay", eventLiquidDiamondPay, "You need 7,000 gems!", player.gems >= 7000);
	addButton(2, "Don’t Pay", eventLiquidDiamondDontPay);
	addButton(3, "Steal", eventLiquidDiamondSteal);
}
private function eventLiquidDiamondPay():void {
	outputText("You begrudgingly hand over the required amount of gems, which the man swiftly takes while handing you the bottle quickly muttering something about no refunds before scampering off somewhere else. Hopefully, you never see the scalper again.\n\n");
	outputText("<b>(Obtained ‘Liquid Diamond’ key item)</b>\n\n");
	player.gems -= 7000;
	player.createKeyItem("Liquid Diamond", 0, 0, 0, 0);
	flags[kFLAGS.THE_TRENCH_ENTERED] = 14;
	doNext(enterTheBazaarAndMenu);
}
private function eventLiquidDiamondDontPay():void {
	outputText("You tell him that you currently don’t have the right amount of gems for purchase.\n\n");
	outputText("\"<i>Shame. Come back when you can pay.</i>\"\n\n");
	flags[kFLAGS.THE_TRENCH_ENTERED] = 13.5;
	doNext(enterTheBazaarAndMenu);
}
private function eventLiquidDiamondSteal():void {
	outputText("Dropping the friendly act. You viscously growl as you slam your fist into his stomach, and snag the bottle from his now loose hand before turning tail and running as he cries out. Luckily for you it seems no one paid attention to the scene or they simply don’t care, allowing you to get away without incident. You can’t help but feel a little bad about the whole ordeal, but it got you what you desperately needed, and to be fair he was a con artist.\n\n");
	outputText("<b>(Obtained ‘Liquid Diamond’ key item)</b>\n\n");
	player.createKeyItem("Liquid Diamond", 0, 0, 0, 0);
	flags[kFLAGS.THE_TRENCH_ENTERED] = 14;
	doNext(enterTheBazaarAndMenu);
}

private function shopMenu():void {
	menu();
	benoit.setBenoitShop(true);
	addButton(1, "G. Garments", gretasGarments);
	addButton(2, "S. Squeeze", theSlipperySqueeze);
	addButton(4, "Back", enterTheBazaarAndMenu);
}

//Semen Bukkake and Massage Parlor
//-Femboi Bunny owner - Joey
//-Catboi (10%) assistants.  Some equipped with tentacles.
//-Optional Female Masseuse.
//--Bunnygal (10%) with horns and a similar addiction to Scylla.
//--Named Sara.
//(find/replace curly quotes/apo for straights -Z)
//[The Slippery Squeeze!]
private function theSlipperySqueeze():void {
	clearOutput();
	outputText("You walk into one wagon whose sign clearly denotes it as 'The Slippery Squeeze'.  It's one of the largest contraptions in the bazaar, and with your first step inside you can see why.  It's built like a regular business, with a lobby in the front and numerous oak doors that lead to back rooms.  The walls are painted a soothing salmon color and a purple, fringed rug covers the wood floor.  It feels soft under your [feet] after so much walking, letting you loosen up and relax.  Incense burns on the counter, filling the air with strange, fragrant aromas that tickle at your nose.\n\n");
	var androgyny:Function = null;
	var milker:Function = null;
	//(First time desc:
	if(flags[kFLAGS.BAZAAR_SLIPPERY_SQUEEZE_VISITED] == 0) {
		flags[kFLAGS.BAZAAR_SLIPPERY_SQUEEZE_VISITED]++;
		outputText("A short, bunny-eared clerk leans on the counter, batting long eyelashes at you as you approach.  The rabbit is wearing a gauzy, sheer pink top and lots of make-up that accentuates her plump, red lips and curvy, cute features.  She doesn't have much in the chest department, but she's unmistakably cute.  You ask the little miss what kind of services this place offers, and she responds by covering her mouth with her hand and giggling girlishly.\n\n");
		outputText("It takes her a few moments for her to get over her humor, but she brushes a hand through her silken hair and replies, \"<i>Oh, I'm sorry if I gave the wrong impression " + player.mf("mister","miss") + ", but I'm not a girl at all.  I'm definitely a male - I just love looking cute and fuckable!  You've got to admit I'm a pretty hot little package!</i>\"  To emphasize 'his' point, the bunny-boy twirls in place, and you notice that all he wears below the waist is a tight, package-hugging thong.  His tail twitches happily from exhibiting himself so, but he doesn't seem to be too aroused yet.\n\n");
		outputText("Before you can comment on his odd mannerisms, he titters, \"<i>You're in 'The Slippery Squeeze', though some have called us 'The Happiest Ending' after a nice, HARD massage.</i>\"  The long-eared bunny-trap licks his gloss-coated lips enticingly before continuing. \"<i>We specialize in salty oil rubs and the complete release of all your tensions.  It's very therapeutic, both for the customer and the masseuse.  We specialize in creating our own, in-house massage lotions that are sure to make the tension ooze from your pores.</i>\"\n\n");
		outputText("Is he implying what you think?  It sounds like the gist of his entire speech is that they use cum for massage oil and specialize in getting everyone involved to orgasm.  The bunny hops and demurely introduces himself. \"<i>My name is Joey; just ask for me or my lovely assistant Sara if you ever want a rub-down.</i>\"");
		outputText("\n\n\"<i>I told you I'm not working until you give me a raise!  Do the damned massages yourself!</i>\" echoes a voice from the back.\n\nJoey blushes and apologies.  \"<i>I guess I'm the only one available for now.</i>\"\n\n");
	}
	//Big balls variant
	else if(rand(10) == 0) {
		joeyBigBalls();
		return;
	}
	//Cock Milker
	else if(player.hasKeyItem("Cock Milker") < 0 && flags[kFLAGS.JOEY_OFFERED_MILKER] == 0 && player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") < 0) {
		outputText("You notice Joey leaning on the counter, lost in thought.  The bunny boy frowns, troubled by something.  He jolts upright when he notices you approaching, his expression lifting into a polite grin.  \"<i>Hey, welcome!  Always nice to see a familiar face.  So, do you have some 'tension' that needs relieving?</i>\"  His eyes travel down to your crotch.  Shameless as ever but with a hesitant offer buried in his eyes...\n\n");
		flags[kFLAGS.JOEY_OFFERED_MILKER] = 1;
	}
	//(Repeat visit:
	else {
		outputText("Joey purses his glossed lips when you enter and coyly cocks one of his ears as he says, \"<i>Welcome back to 'The Slippery Squeeze', [name].  Would you like me to give you a nice, salty rub-down?  Or would you prefer Sara do it?  Just remember, she can't make her own 'oil' like I can.</i>\"\n\n");
		//No scenes for Sara yet!
		outputText("\"<i>I told you I'm not working until you give me a raise!  Do the damned massages yourself!</i>\"\n\nJoey blushes and apologies.  \"<i>I guess I'm the only one available for now.</i>\"\n\n");
		outputText("The price list indicate it's 10 gems for a massage, though the gleefully illustrated 'oil' reminds you just what they plan to use on you.\n\n");
		if(!player.hasPerk(PerkLib.Androgyny)) {
			outputText("There also appears to be an option for a special 'Androgyny Treatment' that costs 500 gems.  Joey catches you looking at it and mutters, \"<i>That treatment isn't fun like our massages.  It would unlock the full potential of your visage, allowing it to be as masculine or feminine as possible.</i>\"\n\n");
			androgyny = joeyAndrogyny;
		}
		//You could have Joey or Sara give you one, though it's obvious they plan to use spooge as massage oil. (Sara needs an introduction before she gets a mention and a menu entry -Z)
	}
	if(flags[kFLAGS.JOEY_OFFERED_MILKER] > 0 && player.hasKeyItem("Cock Milker") < 0 && player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") < 0)
		milker = askJoeyAboutOffer;
	//	[Joey] [Sara] [][] [Leave]
	if (player.hasKeyItem("Cock Milker - Installed At Whitney's Farm") && !player.hasKeyItem("Cock Milker: Anal Attachment"))
			milker = askJoeyAboutAttachment;

	//simpleChoices("JoeyMassage",joeyMassage,"Androgyny",androgyny,"Joey'sOffer",milker,"",0,"Leave",2855);
	menu();
	addButton(0,"JoeyMassage",joeyMassage);
	addButton(1,"Adrogyny",androgyny);
	addButton(2,"Joey'sOffer",milker);
	if(isEaster()) {
		outputText("There's another option on the list, cheerfully presented with a pastel border and a little painted egg next to it.  'Sweet Massage' it says.  \"<i>That's our spring special,</i>\" Joey explains, \"<i>using our new chocolate-flavored massage oil.  It comes with a complimentary 'dessert.'</i>\"  He gives you a little wink at that last word, so you can be certain that it's no normal dessert.  <b>The price is 20 gems.</b>");
		if(player.gems < 20) outputText("  You can't afford it.");
		else addButton(3,"SweetMassage",joeySweetMassage);
	}
	addButton(4, "Leave", enterTheBazaar);
}




//[Ask]
private function askJoeyAboutOffer():void {
	clearOutput();
	outputText("You ask the effeminate masseuse what had him so concerned a moment ago.  He grimaces.  \"<i>Well, I recently came in possession of a cock milker, one of the old magic-powered ones.  The trouble is, I obviously don't need one, and neither does anyone else.  Worse still, the thing takes up a fair bit of my room.  I guess they've already got 'alternatives',</i>\" he sighs.  \"<i>So now it's just collecting dust in the back room, and I hate seeing a nice piece of craftsmanship like that go to waste.  Even if my talents have rendered it defunct,</i>\" he murmurs with a trace of pride.");
	outputText("\n\nHe stares at you momentarily.  \"<i>Say, you wouldn't happen to want it, would you?  Maybe something for those long, lonely nights?  Heck, you could probably jury-rig it to collect lots of semen.  Good quality cum fetches a decent price,</i>\" he says a little too knowingly.  \"<i>A sound investment, yeah?  I'll let it go for, oh, say, five hundred gems.</i>\"  What?  The cocky little f-  \"<i>Hah, just pulling your leg!</i>\" he laughs.  \"<i>It's yours for two hundred gems.  Because I'm such a nice guy.</i>\"");
	outputText("\n\nWhat do you think? Will you take the cock massager for 200 gems?");
	if(player.gems < 200) {
		outputText("\n\n<b>You don't have enough money.</b>");
		doNext(noMilkerPlzJoey);
		return;
	}
	//[Yes] [No]
	doYesNo(buyCockMilker,noMilkerPlzJoey);
}
//[No]
private function noMilkerPlzJoey():void {
	clearOutput();
	outputText("You decline; it's not really the sort of thing you need in your camp.  \"<i>Ah well,</i>\" Joey shrugs, \"<i>I'll just have to hang onto it for now I guess.  Shame.  Anyway,</i>\" he resumes his usual grin, \"<i>is there something else you need?  A massage, perhaps?</i>\"");
	//return to normal options, scene is never brought up again
	doNext(enterTheBazaar);
}
//[Yes]
private function buyCockMilker():void {
	clearOutput();
	outputText("\"<i>Fantastic, fantastic!  Let me get it from the back.</i>\"  Joey rushes behind a curtain, audibly rummaging through the storeroom.  Soon he comes back, carrying a bunch of tubes and nozzles.  \"<i>Here you go!</i>\"  He dumps the collection of junk in your arms, taking the gems from you in the same motion.  You hastily begin stuffing the contraption in your pack.  \"<i>Now, don't get too attached.  A machine's never gonna beat the real thing.</i>\"  He flexes his delicate fingers.  \"<i>Speaking of which, need something?</i>\"");
	outputText("\n\n(<b>Key Item Acquired: Cock Milker</b>)");
	player.gems -= 200;
	statScreenRefresh();
	player.createKeyItem("Cock Milker",0,0,0,0);
	simpleChoices("JoeyMassage", joeyMassage, "Androgyny", null, "Joey'sOffer", null, "", null, "Leave", enterTheBazaar);
}
private function askJoeyAboutAttachment():void {
	clearOutput();
	outputText("You ask the effeminate masseuse if he happens to know where you could find an attachment for a Cock Milker, since you now have one installed at the farm.\n\n");
	outputText("\"<i>Oh hey, I might just have one of those in the back! Let me go check for you.</i>\"\n\n");
	outputText("He comes back a few minutes later with an anal stimulant attachment for the Cock Milker. \"<i>Is this what you are looking for? I can sell it to you for 200 gems if you want it?</i>\"");
	if(player.gems < 200) {
		outputText("\n\n<b>You don't have enough money.</b>");
		doNext(noMilkerPlzJoey);
		return;
	}
	//[Yes] [No]
	doYesNo(buyCockMilkerAttachment,noMilkerPlzJoey);
}
	private function buyCockMilkerAttachment():void {
		clearOutput();
		outputText("\"<i>Fantastic, fantastic!  Here you go!</i>\"  He dumps the atatchment in your arms, taking the gems from you in the same motion.  You hastily begin stuffing the contraption in your pack.  \"<i>Now, don't get too attached.  A machine's never gonna beat the real thing.</i>\"  He flexes his delicate fingers.  \"<i>Speaking of which, need something?</i>\"");
		outputText("\n\n(<b>Key Item Acquired: Cock Milker: Anal Attachment</b>)");
		player.gems -= 200;
		statScreenRefresh();
		player.createKeyItem("Cock Milker: Anal Attachment",0,0,0,0);
		simpleChoices("JoeyMassage", joeyMassage, "Androgyny", null, "Joey'sOffer", null, "", null, "Leave", enterTheBazaar);
	}

private function joeyAndrogyny():void {
	clearOutput();
	if(player.gems < 500) {
		outputText("You haven't got enough gems for that treatment!");
		doNext(theSlipperySqueeze);
		return;
	}
	player.gems -= 500;
	statScreenRefresh();
	outputText("Joey takes your hand in his and insistently pulls towards the back rooms.  \"<i>Once we have this all done ");
	if(player.gender == 1) outputText("you'll be able to be as cute as me!");
	else if(player.gender == 2) outputText("you'll be able to be as masculine as you want!");
	else outputText("you'll be able to be as cute as me or as masculine as you want!");
	outputText("</i>\" explains the bunny-eared fem-boy.   You allow yourself to be lead into a small back room, where you're guided into a soft, padded chair.  Joey turns about in the cramped interior, his shapely ass mere inches from your face, tail tickling your nose.  You struggle not to sneeze or stare too deeply at the curvy fem-boy's butt-cheeks, but it's hard to focus with that delicious target waggling in front of you.\n\n");

	outputText("At last he turns back around, holding a cork-stoppered vial of pink-hued liquid in his manicured finger-tips.  \"<i>This is the stuff!  Now just close your eyes, we gotta get this worked into your skin and it stings worse than an angry wasp-girl if it gets in your eyes,</i>\" says Joey.  You blink your eyelids closed, as instructed, and you feel the soft skin of the feminine bunny rubbing over your [face], working something wet and tingly into your [skin.type].  The delicate facial massage takes roughly an hour, but you feel fresh and relaxed once it's finished.\n\n");

	outputText("You ask for a mirror, but Joey just titters with a knowing smile on his succulent lips as he replies, \"<i>Oh, you haven't changed at all " + player.mf("handsome","dear") + ".  This will let you change it to whatever extreme you like, but those kinds of facials aren't a service we currently offer.  I do hear that there's a goblin salon in the mountains that might be able to help you finish up your look though!</i>\"\n\n");

	outputText("Thanking the cute bunny-boy for his help, you hand over the payment and head back to check on camp.");
	player.createPerk(PerkLib.Androgyny,0,0,0,0);
	dynStats("lus", 5, "scale", false);
	doNext(camp.returnToCampUseOneHour);
}
//[Joey]
private function joeyMassage():void {
	clearOutput();
	if(player.gems < 10) {
		outputText("Joey frowns when you realize you don't have the 10 gems.  He apologizes, \"<i>I'm sorry, [name] but I can't give freebies - our special potions cost us plenty.</i>");
		doNext(enterTheBazaar);
		return;
	}
	player.slimeFeed();
	player.gems -= 10;
	statScreenRefresh();
	outputText("Joey bounces on his feet excitedly, the little poof-ball above his exposed, heart-shaped ass twitching happily.  His soft hand takes yours and leads you towards one of the back rooms, dragging you inside just before the door is silently closed.  The small wooden chamber houses a single, padded bed that's clearly meant for you, and at Joey's insistence you disrobe to lie down on it.  You put your face through a rounded oval and lie down, taking the idle moment to glance around.  A small coal-fired steam-oven isn't far past the bed, and you can make out Joey's small, human feet as he stokes it.\n\n");
	outputText("One of your chosen masseuse's soft, demure hands rests on your shoulder while the oven starts and begins to vent warm steam through the room.  Joey starts by leaping atop you in a single bound to  straddle your back and rub your shoulders.  His small, skilled fingers work wonders, working out the constant tension this strange land has inspired in you since your arrival.  Each insistent, languid touch dissolves a knot of worry, sending shivers of contentment through you that make you feel as if you're melting into the bed.\n\n");
	outputText("Once he feels the tension from your upper body has been released, the girly bunny-boy slides himself lower, placing his taut, barely-covered rear atop your [butt].  Joey's hands slide down along your spine, smoothing out every knotted muscle in your back as he goes.  You could swear his fingers are magic; you feel like a lump of clay being worked by a master sculptor.  Sighing dreamily, you lie there and groan while he finishes the small of your back, muscles rendered into goo-like softness.\n\n");
	outputText("Your masseuse moves up to your arms, squeezing and rubbing with practiced skill.  You're so tranquil that you barely react when he begins to grind his thong-covered bulge on your utterly-relaxed back.  Each slow, measured drag of his body is done to the tempo his fingertips set on your now-limp arms.  You sigh contentedly, letting the bunny dry-hump your lax muscles as if it were all part of the massage.  Even though he stops the massage, his hips keep pumping until you can feel his six inches of hardness threatening to escape his sweat-slicked thong.\n\n");
	outputText("Joey dismounts and gives your [butt] a rough squeeze as he prances towards a nearby table with a large number of bottles.  You hear him drop a cork on the floor and watch it rolls by your face.  The masseuse noisily gulps down whatever concoction he's just opened up, sighing contentedly and giving a cute, girlish burp once he's finished.  He leans down and breathes huskily into your ear, his hand roaming your body while he explains, \"<i>I just drank one of our house specials.  It's a nice little concoction that'll kick my prostate and balls into overdrive.  In a minute I'll start leaking my favorite lotion, and I won't stop for at least twenty minutes.  Just enough time to finish your massage.");
	if(player.hasCock()) outputText("  Would you like one?");
	outputText("</i>\"");
	if(player.hasCock()) {
		outputText("\n\nDo you accept Joey's potion?");
		doYesNo(joeysMassageWithEXTRASpooge,joeysMassageWifNoExtraJizz);
	}
	else doNext(joeysMassageWifNoExtraJizz);
}

private function joeysMassageWifNoExtraJizz():void {
	sceneHunter.selectGender(
		curry(joeysMassageWifNoExtraJizzScene, true), null,
		curry(joeysMassageWifNoExtraJizzScene, false)
	);
}

private function joeysMassageWifNoExtraJizzScene(useCock:Boolean):void {
	clearOutput();
	//(Continue as NoWang)
	outputText("The rabbit-eared fem-boy climbs back onto the table and strokes himself a few times over your [ass]; the first drops of his 'special oil' feel hot as they land on the curves of your butt cheeks.  He climbs over you, touching himself just enough to stay hard while his cum-drooling cock stops dripping and starts genuinely leaking.  A long trail of bunny-spunk is dripped onto your [ass] until you're glazed with thick ropes of it.  You spot his discarded thong on the floor and giggle as you feel him flip around to put his cute bunny-butt on your shoulders.  His spunk immediately runs down your spine, even as his hands smear it all over your [skin.type].\n\n");
	outputText("The massage heads back towards your [butt]; Joey's hands fill with your flesh as he fondles and strokes, spreading the jism into every nook and cranny, even your " + assholeDescript());
	if(player.hasVagina()) outputText(" and " + vaginaDescript(0));
	outputText(".  The strange, slippery feeling would've made you jump if you weren't so thoroughly relaxed, but the warmth of the room and sureness of your masseuse's touch only serve to stoke your lust as effectively as he had the oven's fire.  You mewl happily when he slides his cum-soaked fingers up your back, spreading the sloppy mess over you like icing on a cake.\n\n");

	outputText("Joey stands and turns, his cum drooling into your " + hairDescript() + " as he asks, \"<i>Would you roll over for me?</i>\"  Eager for more of his skilled massage and impelled by your own growing arousal, you roll over, letting his jism drip onto your face.  He sits down gently, resting his barely-felt weight atop your bellybutton, and in no time, his fingers are smearing more of his fragrant, constantly-leaking goo over your " + chestDesc() + ".  The long-eared fem-boy rubs around your " + nippleDescript(0) + "s, trailing delicate circles that make the perky, pink flesh harden and glisten.\n\n");
	outputText("A soft, slippery hand takes your own and guides it to one of your " + nippleDescript(0) + "s, bidding you to play with it.  You do enthusiastically, even while Joey's same hand gathers more of the salty white lotion to smear over the front of your shoulders and arms, working it into your pores as effectively as he works the tension from you.  Unable to deny your growing need, you lift your head to watch with perverse fascination.  Joey is blushing hard, but he holds himself immobile while the whitish goop continually pours from him.  While his dick would've been considered average back home, here, in this place, he's tiny.  He really does remind you of a lotion dispenser, pumping out globs of sticky whiteness to be rubbed into one's skin.\n\n");
	outputText("You catch a view of your hand as it ");
	if(!player.hasFuckableNipples()) outputText("tweaks and teases");
	else outputText("sinks a finger deep inside");
	outputText(" your " + nippleDescript(0) + ", and you raise your other to match it.  Joey smiles and pants, \"<i>Yes, we need to get out allll your tension, even that... uh... naughty... ah... sexual tension.  Mmmmm, now just lie your head back.  I'm almost done, and we always give our clients a facial treatment while we ease their worries.</i>\"\n\n");

	outputText("The bed cradles you as you close your eyes and lie back, noting the slight change in darkness beyond your eyelids from Joey's new position.  Spunk begins to rain over your [face], puddling seed around your eyes and forehead before it drips down your cheeks and bubbles on your lips.  You're quickly distracted from the salty, cummy facial when your personal leporid lotion-dispenser ");
	//(fork to male or genderless, no new PG)
	//(MALE)
	if(useCock) {
		outputText("slides his warm, ruby lips over your [cock], licking and slurping the [cockhead] like a treasured candy.  That hot, breathy embrace hugs tight to your urethral bulge, slobbering up the cock-tip.  The flexible, thin rabbit tongue swirls over your cum-slit to lap at the bubbling pre-cum, even as his quaking balls continue to bury your face in bunny-semen.");
		if(player.cockTotal() > 1) {
			outputText("  He takes your " + cockDescript(1) + " with his free hand and pulls it over, giving it an affectionate, loving smooch.");
			if(player.cockTotal() > 2) {
				outputText("  The process is repeated");
				if(player.cockTotal() > 3) outputText(" as necessary until " + sMultiCockDesc() + " is coated with dick-drenching bunny spit.");
				else outputText(", coating your " + cockDescript(2) + " with dick-drenching bunny spit.");
			}
		}
		outputText("  A moment later, ");
		if(player.hasBalls()) outputText("his hand firmly rubs your " + sackDescript() + ", and ");
		outputText("gentle fingertips are probing between your cheeks, rubbing his dripping seed against the pucker of your " + assholeDescript() + ".\n\n");
	}
	//(FEM/GENDERLESS)
	else {
		if(player.hasVagina()) outputText("presses his ruby lips into the glistening delta of your mons");
		else outputText("presses a finger against the semen-soaked ring of your " + assholeDescript());
		outputText(".  He skillfully works a free hand over your slippery butt-cheek, squeezing the supple flesh while he expertly rubs your interior, stroking it with semen-lubed touches.\n\n");
	}
	//Fems/Genderless cum+epilogue
	if(!useCock) {
		//(Genderless orgasm)
		if(player.gender == 0) outputText("Though his single finger makes you burn with passion, Joey's second slides effortlessly after it, filling your " + assholeDescript() + " with another of his cum-soaked digits.  His warm jism slides down the crack between the fingers, slowly pooling in your backdoor.  Once you've adjusted, he continues to the massage, stroking and bumping your interior with the confident, practiced strokes of a professional. You pull hard on your tortured " + nippleDescript(0) + "s, egging up the gradual upwelling of pleasure while you lick the bunny-cream from your lips.  A moment later, the no-longer-offending digits press hard on a sensitive spot, and you're arching your back, screaming with pleasure.\n\n");
		//(Female orgasm)
		else {
			outputText("Though his spit and cum-lubed tongue is quite skilled, deftly tasting your labia and channel, the bunny adds a pair of fingers to the mix, pulling the musky tunnel wide and letting more of his slippery seed inside you.  He uses it like lube, sliding his digits around while he sucks your " + clitDescript() + " ");
			if(player.clitLength >= 4) outputText("like a practiced whore fellating a john.");
			else outputText("like a professional pussy-licker.");
			outputText("  You give your " + nippleDescript(0) + "s a hard tweak, torturing them as the building pleasure grows.  Aware of this, Joey curls a finger to press directly on a sensitive spot, deep inside you, and then you're arching your back and howling with unleashed release.\n\n");
		}
		//(continuing)
		outputText("You tremble and moan for some time, until you realize there's no more cum dripping onto your face and your pleasantly tingly hole is empty.   Joey pads around you, rubbing your neck sensually as you blink the spunk from your eyes and lick his flavorful spooge from your lips.  A towel is placed into your hand by the breathy masseuse.  He says, \"<i>There's a shower and more towels in the back if you want to clean up.</i>\"  You note that he's already got his thong back on, but the front is dark and nearly spherical from what he's leaking into it.  He turns to leave you, and you're given a better view – his thong is bulging from between his legs all the way around to his ass.  The feminine bunny-boy is still cumming, and his special thong seems to be directing it all into his back door.  Kinky.");
	}
	//(Dickgasms
	else {
		outputText("Though Joey's mouth is making you burn with passion, it's the feeling of a single, intruding fingertip against your " + assholeDescript() + " that puts you on edge.  His warm jism slides down his finger, dripping into your violated backside with each slow pump.  Once you've adjusted, he continues the rectal massage, gently caressing the sides of your prostate while his mouth stays busy with your [cock].  The bunny's tongue thrashes, twisting like a slippery eel over your length, his cheeks hollowing from the suction he's applying.  A moment later, Joey curls the digit inside you to press firmly against your prostate, squeezing the sensitive organ tightly enough to make your hips pump into the air.\n\n");
		outputText("Globules of spooge squirt in time to your motions, feeding those ruby lips the treat them seem to ache for.  The rain of slick, syrupy cum on your face intensifies, spurting heavier ropes of bunny-cream each time you make the poof-tailed fem-boy swallow.  He gasps hard in between each semen-sucking gulp, all while giving you an impressive facial.  If you could see yourself, you would probably look like you're wearing enough boy-sludge to knock up an entire village.  The perverse mental image sets off a whole new set of contractions, releasing a few more waves of bliss and 'tension'.\n\n");
		outputText("Joey climbs off once you've wound down and laps at the cum over your eyes, nose, and mouth, cleaning you enough to see properly.  The first thing you see is a girlish, cum-stained face.  He makes a show of cleaning the spunk from himself, but throws you a towel as he does so. You lick the last of his flavorful cum from your mouth, noting that while he's already put his thong back on, it's bulging obscenely and he's still squirting inside!");
		if(player.cumQ() >= 700) {
			outputText("  A smile widens your [face] when you see the ");
			if(player.cumQ() >= 2000) outputText("massive, jiggling belly you've given him.");
			else outputText("little paunch on his belly jiggle.");
			outputText("  He won't be hungry for some time.");
		}
		outputText("  Joey turns and prances away, saying, \"<i>There's a shower if you need to clean up, and be sure and visit me the next time you need help to squeeze out all that tension!</i>\"  You barely hear his words, so focused are you on his cum-darkened, distended thong.  You can see it bulging between his legs, and while his pert butt sways out the door, you can see that his cum-filled thong is designed to redirect all that fluid over his taint and into his backdoor. Kinky.");
	}
	//(reduces libido significantly if very high, reduces lust, and reduces sensitivity to 40)
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}

//[CONTINUE – DRANK JOEY'S SPECIAL POTION]
private function joeysMassageWithEXTRASpooge():void {
	clearOutput();
	outputText("The rabbit-eared fem-boy pulls the cork on another bottle and helps you to roll to your side to drink it.  He holds the lip of the bottle to your lips and raises the bottom slowly, giving you just enough time to guzzle it without drowning.  It's sweet and syrupy, though there's an undertone of spicy strangeness that you can't quite place.  Whatever the secret ingredients are, you'll never figure them out from taste alone.  You feel warmth once you've finished, and a tightness settles ");
	if(player.balls == 0) outputText("inside you");
	else outputText("in your " + ballsDescriptLight());
	outputText(" that reminds you of the sensation just before orgasm.");
	if(player.hasBalls()) outputText("  They even feel a little bigger.");
	outputText("\n\n");

	outputText("Joey's fingertips brush along your shaft, squeezing it with tender touches that make it stiffen and thicken.  He starts slowly jacking you off while his other hand traces one of your nipples.  \"<i>We've got to get you nice and hard now so that you can let out all that nice, creamy lotion,</i>\" explains the fem-boy.  You nod in understanding, blushing hard while he fondles " + sMultiCockDesc() + " with soft caresses.  He plays your manhood");
	if(player.cockTotal() > 1) outputText("s like fiddles");
	else outputText(" like a fiddle");
	outputText(", expertly running his fingertip around the sensitive [cockhead] before tracing down along your rapidly filling urethra.  It feels good – better than it should, and the warmth inside you begins to leak into the bunny-boy's waiting hand in moments.\n\n");

	outputText("You're rolled back on to your front, crushing " + sMultiCockDesc() + " between you and the sheets.  Joey leaps back atop you, straddling your back and facing your [ass], his hands locking onto the steam-moistened cheeks.   He slides forward slightly, placing his hardness between them, and it's then that you notice his discarded thong on the floor.  A moment later the first drops of Joey's own hot seed are dripping over your exposed derrière.  He slides himself through your buns, hotdogging the rapidly-slickening surface of your ass while his hands massage the tense flesh a little more enthusiastically than they ought to.\n\n");

	outputText("Of course you don't complain, not with the growing puddle forming between you and the cum-soaked sheets.  Every time your masseuse shifts, the movement makes you slide in your sticky mess, the cum-lubed friction of the sheets helping the constant jizz-flow to thicken into a steady river of seed.  ");
	if(player.hasBalls()) outputText("Your balls pull and relax and pull tight, bouncing below you over and over, all while working hard to produce more juice for you to gush.  ");
	outputText("Even though you're draining spunk at an alarming rate, it doesn't feel like a normal orgasm.  There's no wave of pressure and subsequent release, just a constant, pulsing contraction that makes you melt with ever-increasing feelings of satisfaction.\n\n");

	outputText("Joey giggles, turning about to put his lotion-dispenser on the small of your back, and you feel the hot bunny-spoo pour onto you in a wave.   It's gathered up and pushed up your back.  Globs of it roll down your side, sliding over the semi-waterproofed sheets to mix with your growing spunk-lake.  With the slippery-seed aiding Joey's massage, he somehow manages to work out even more of your tension.  By this point your muscles feel like jello melting in the afternoon sun.  You feel like you could melt into your cum, and you sigh in bliss");
	if(player.cumQ() >= 1500) outputText(".  The sound of your rivers of spooge splattering against the floor barely registers, but a part of you is proud to be so incredibly fertile");
	outputText(".\n\n");

	outputText("You're prodded insistently, the masseuse saying, \"<i>Come on, we've got so much more of your body to work on before you're completely emptied of all that nasty stress.  Now roll over, don't be shy about the mess.  I'll be making it messier.</i>\"  True to his word, Joey is still drooling his 'special lotion' over your [legs].  You oblige and gingerly roll over, the cummy sheets squishing lewdly under you as your slime-slicked belly and cum-drooling crotch are revealed.");
	if(player.cumQ() >= 1500) outputText("  Joey's jaw drops from the unexpectedly large volume you're producing, and he watches in awe as each huge globule of cum rolls off you towards the floor.");
	outputText("\n\n");

	outputText("The bunny-boy springs back atop you, landing hard just below your hips.  His dripping seed washes over " + sMultiCockDesc() + ", and the sudden onslaught of fresh, liquid warmth on your groin sets off a small explosion of jism that splatters into your chin, leaving a long trail of slime behind like a snail.  The long-eared girly-boy smiles and shifts to rub his small cock against your [cock], frotting you aggressively while you both spray cum like faucets with the knobs torn off.  You don't mind that he seems to have forgotten the massage, and you run your hands up and down your " + chestDesc() + " to smear the heavy loads ");
	if (player.isFurCovered()) outputText("through your fur");
	else outputText("over your [skin]");
	outputText(".\n\n");

	outputText("The special potion makes it so your orgasm is long and languid, oozing out for minutes instead of seconds, and the small chamber is filled with breathy, exultant cries of passion.  Joey leans forward and grabs hold of your " + nippleDescript(0) + "s, ");
	if(!player.hasFuckableNipples()) outputText("squeezing and tugging on them");
	else outputText("sliding cum-coated fingers into their slippery depths");
	outputText(" while he grinds and cums on your [cock].  \"<i>Ungg... yes... gotta... squeeze... allofitooooouuuuut!</i>\" he pants.  He lets go of one tender nipple to reach underneath you, and before you can react, his cum-soaked finger is inside your " + assholeDescript() + ", pressing on your prostate.\n\n");
	outputText("Your eyes cross and you black out, twitching weakly as a regular orgasm bursts on top of your already-protracted potion-gasm.  A pleasant, heavily sexualized dream is interrupted by a finger poking your lotion-lubricated cheek and the best you can manage is an utterly contented \"<i>mmmm.</i>\"  A warm, moist towel is rubbed over your [face], wiping away the spooge you blasted over it, and now that you can see him, Joey says, \"<i>You had me worried for a minute there!  Keep the towel, it's on the house, and if you need to clean up, there's a shower in the back!");
	if(player.cumQ() >= 1500) outputText("  You really flooded the room though, so you'd best walk on your tip-toes until we can get a succubi or a goblin in here to clean up.");
	outputText("  Come back ANY time, [name].  I'd love to help you release again.</i>\"\n\n");

	outputText("Joey leaves, his poofy tail bobbing back and forth.  You can see his thong is distended, virtually packed with his own still-pumping spooge, and you marvel at his perverse ingenuity when you realize his thong is waterproofed and shaped to guide all the jizz between his thighs and into his back-door.  Kinky.");
	player.cumMultiplier += 2;
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}
private function joeyBigBalls():void {
	clearOutput();
	//(FIRST TIME)
	if(flags[kFLAGS.JOEY_BIG_BALLS_COUNT] == 0) {
		outputText("Before you can even clear the door-frame, Joey the bunny-boy masseuse launches himself into you, his hands clutching wildly at your [armor].  You look down at him, and his wide, open eyes stare back with panic; namely, the look of someone in over their head with no idea how to save themselves.  Worse still, his trademark thong is bulging out obscenely, cum spilling down the sides while his immensely swollen gonads threaten to burst free of the garment's fraying threads.  Joey babbles, \"<i>Help!  I was testing the potions, and-and-and... I dunno what went wrong, b-b-but my balls are backing up faster than it dribbles out.  They feel like they're going to burst!!  Help meeeeee!</i>\"\n\n");
		outputText("You push the panicked lagomorph back a pace so that you can breathe and appraise the situation.  Joey's legs are drenched, soaked with sloppy spooge.  His thong is on the verge of bursting.  Most notable, his bloated balls look more like cantaloupes than testicles, and these melons are ripening to an unseen Demeter's power, swelling ever-so-slightly larger with each passing second.  You estimate that there's precious little time.\n\n");

		outputText("Why is it that no one ever desperately requires your assistance with a mundane task?  Sighing, you judge");
		if(player.cor > 60) outputText(", with no more than a bit of wishful thinking,");
		outputText(" that if someone were to apply suction to his member, it might help to vent the thick-flowing jism fast enough to help out Joey.  There doesn't seem to be anyone else around, so it would have to be you, but with how the parlor's potions work, you might be sucking for a long time...  Then again, if you made have him masturbate, it would probably stimulate his muscles to force all that fluid out.  Of course, if you tell him that, he'll probably run into a back room to try it and leave you be");
		if(player.cor > 70) outputText("; you won't get to watch him fountaining all that pearly spunk like a perverted statue");
		outputText(".  What do you decide?");
	}
	//(Sucked Joey once)
	else {
		outputText("As soon as you enter The Slippery Squeeze, you know somehow that something is amiss.  Joey staggers out from a back-room, his balls once again swollen huge and round.  He looks at you and admits, \"<i>Someone's <b>got</b> to be sabotaging me... gods, this hurts!  Could you help me, or should I go in the back and jerk it out myself?</i>\"\n\n");
	}
	flags[kFLAGS.JOEY_BIG_BALLS_COUNT]++;
	simpleChoices("SuckCumOut", suckOffJoeysGardenHose, "MasturbateOut", joeyWanksItOut, "", null, "", null, "", null);
}

//Masturbate It Out (work it out on the floor)
private function joeyWanksItOut():void {
	clearOutput();
	if(flags[kFLAGS.JOEY_BIG_BALLS_MASTURBATED] == 0) {
		outputText("You tell Joey that if he masturbates to erectness, his body should be able to shoot it out faster.  He smacks his forehead and runs into a back room, his thong disintegrating around his growing testes as he runs. The door slams, leaving you in peace.  A little freaked out, you head back to camp for now.");
		doNext(camp.returnToCampUseOneHour);
	}
	else camp.returnToCampUseOneHour();
	flags[kFLAGS.JOEY_BIG_BALLS_MASTURBATED]++;
}
//Suck Cum Out (not your garden-variety hoes)
private function suckOffJoeysGardenHose():void {
	clearOutput();
	outputText("Smiling impishly, you say \"<i>I'll just have to suck all that cum out then, won't I?</i>\"  Joey blushes, cheeks reddening to match his plump lips as you yank his rapidly disintegrating thong down to the ground.  Popping free, his half-hard member bobs before your eyes, trailing a thick trail of man-slime the whole way to the ground.  The semi-turgid mass starts at only about four and a half inches long, but as your hot breath washes over it, the twitching, slimy cock grows to its full six-inch size.  Joey moans as the flow from his cock thickens.  His balls keep right on growing, and you realize that they're at least as big as basketballs now.\n\n");
	outputText("You grab the bunny-boy's pert ass-cheeks and pull your mouth onto his cock, his member easily sliding along your tongue, lubricated by the unholy flow of dick-juice it drips.   Sealing your lips down on his base into a vacuum-tight O-ring, you start to suck, ever-so-slightly ratcheting up the pressure on Joey's poor, backed up penis.  Thanks to your oral cock-pump, he quickly swells beyond his normal max.   Seven inches of dick push towards your throat, and like a valve suddenly becoming unstuck, that cock's cumslit suddenly dilates wide, stretched out to handle the heavy flow.\n\n");
	outputText("Gurgling in surprise, you nearly choke from the deluge of spooge flooding your throat.  Your tongue tingles from the salty aftertaste while you gulp down the rest of the bunny-cream.  Joey pants and pleads, \"<i>Oooh... it's... it's... so good.  Feels so amazing... don't stop!  Please don't stop!</i>\"\n\n");
	outputText("You cup the fem-boy's heavy, swollen sack in your hands and keep up the pressure, and he rewards you with another languid eruption of goo.  His balls shrink ever-so-slightly in your hands with every pulsating pump.  You look up while your throat works, meeting Joey's dazed, relieved expression with your own sultry gaze.  He shivers, delivering the next creamy deluge to you on the spot, nearly making you gag.  It's even more voluminous than the pulse before, and if this keeps up, you won't be able to swallow it down.\n\n");
	outputText("Joey's rouged lips silently mouth, \"<i>Oh gods,</i>\" as he delivers the next, even bigger rope to your eager maw, stuffing your mouth so quickly that his jism squirts from the corners before you can react.  You shiver from the semen overload");
	if(player.minotaurAddicted() || player.hasPerk(PerkLib.LactaBovineImmunity)) outputText(" and find yourself wishing you had one of these potions to use on a minotaur.  It would be divine!");
	else outputText(" and keep at it.  The knowledge that you're helping a friend is almost as filling as his delicious cum.");
	outputText("  White goo drips down your chin towards the floor, but you note that his balls are now back down to the size of grapefruits.  You're making progress!\n\n");

	outputText("Giving the girly-boy a semen-leaking smile, you milk his cock with determination and enthusiasm, only letting dribbles escape from your mouth when you do too good a job.  Your belly gurgles unhappily as if you've just eaten a huge meal, but you've got to press on!  Lick and swallow, suck and slurp - you fall into a practiced rhythm as you accommodate the bunny's chemically-induced virility.  Soon, your bulging midsection forces you to abandon swallowing and alternate between sucking at Joey's shaft and spitting out his ungodly eruptions of cum.  It runs down your " + allChestDesc() + ", makes a mess of your belly, glazes your [legs], and eventually comes to rest in the growing, three foot wide spunk-puddle on the floor.\n\n");

	outputText("Joey moans, \"<i>You're so good at this!  B-but I still feel so pent-up... so full.  I don't think it's slowing down yet!</i>\"\n\n");
	outputText("You pull back and gasp for air, ignoring the ropes of spooge splattering across your face and into your " + hairDescript() + ".  Determined not to lose your progress, you take his none-too-impressive cock in your hand and jack it, spurring his body to take over and propel even more eruptions of slick seed onto your [face].  It's so messy, so decadent, but it's ");
	if(player.cor < 33) outputText("all for a good cause, right?");
	else if(player.cor < 66) outputText("also kind of fun, in a naughty way.");
	else outputText("exactly the kind of nasty stuff that gets your blood pumping.");
	outputText(" Still, his balls feel even heavier in your hands by the time you return to your post on his post.  You work him dutifully while your mind races, trying to think up a solution.\n\n");

	outputText("An idea bubbles up to your semen-sludged mind, and you act on it without thinking in your desperation.  You slowly squeeze Joey's balls in your hands and smile when his white goo pours from his cum-slit in a high-pressure wave, eventually leaking out your nose.  It takes a moment for you to cough out the salty seed.  You don't deviate from your task in the slightest while you see to your breathing - Joey's balls are kept compressed in your hands.  He wriggles and gasps, but his now-freed member flails around, squirting trails of white across you, the floor, the walls, and the ceiling.\n\n");
	outputText("Miraculously, his nuts shrink smaller, just a hair bigger than his original size as his seemingly-endless spray winds down.  You wipe his cum from your eyes and lap the stuff from your lips.  Joey sighs and futilely pumps his hips, ejaculating large ropes of seed all over your body, but his condition seems to have stabilized.  If you remember correctly, the potion probably has a few more minutes before it stops.  Time for some fun.\n\n");
	outputText("You pull Joey down into the puddle he made, instantly soaking his pink top into a salmon-tinged jizz-mess.  \"<i>What's going on?</i>\" he cries, flailing his arms through his rippling spunk-mess before he calms.  You aim his cock up towards his face and smile lewdly as his jizz starts to rain down across his body.  It doesn't have quite enough force to hit his ruby-painted lips, however.\n\n");
	outputText("\"<i>I'm just having a little fun with the situation,</i>\" you answer while gently pumping the bunny-boy's dick.  He moans beneath your touches, electric shivers of pleasure racing through him as his spurts shoot further and further, finally reaching his face.  In no time, his lips are as pink as his top, with a nice, salty shine.  Joey moans and lands a glob on his forehead.  The next creams his hair.  You gently swat his balls and watch the next shot go past his head to splatter on the side of the counter.  Purring, you muse, \"<i>Oooh, you're getting better at this.</i>\"\n\n");
	outputText("\"<i>I'm so sorry!</i>\" cries Joey as his hips grind against your hands, \"<i>Something was - ah - wrong wi... with this batch.  I didn't mean for any of this to happen!  I t-think the demons are trying to sabotage my business!</i>\"\n\n");
	outputText("You sigh at that, but it would make sense.  Even here, under a watchful eye, the demons can't seem to stop their scheming.  You rub Joey's balls as the last of his cum drains from his twitching, unused fuck-stick and stand up, the added weight of his jizz in your belly making it a little difficult.  The bunny-boy keeps moaning and wriggling on the floor, still coming down from his orgasmic high.\n\n");
	outputText("Pulling him up, you drag both of you deeper into the trailer to find a shower, where you both clean up with a touch of good-natured teasing.  Once the cute 'trap' and you are free of his goo, you head back to the entrance.\n\n");
	outputText("\"<i>I cleaned out your balls; you can clean up the floor,</i>\" you joke as you leave, kissing him one last time on the mouth before you go.\n\n");
	outputText("Joey blushes again and begins looking for a mop.");
	player.sexReward("cum", "Lips", false);
	dynStats("lus", 70, "scale", false);
	doNext(camp.returnToCampUseOneHour);
}

private function overHearDemonsAboutSyrena():void {
	clearOutput();
	if(flags[kFLAGS.BAZAAR_DEMONS_CONVERSATION] == 0) {
		outputText("A whisper of conversation catches your ear while you're wandering the bazaar, and overcome by curiosity, you veer towards it.\n\n");
		outputText("As you're closing in on the voices, the dialogue grows clear enough to understand.\n\n");
		outputText("\"<i>-old him if he doesn't finish this week's experiments, she's going to drop him into a submission tank instead of the champion!</i>\" exclaims the first voice, sounding quite feminine.\n\n");
		outputText("A baritone response rings out, \"<i>You're shitting me!  Syrena's off her fucking rocker if she thinks Lethice will let her turn another of our researchers into a gibbering slut.  We've got enough of those.</i>\"\n\n");
		outputText("\"<i>Well, what do you expect?  She's more shark than demon... I'm amazed she gets anything done at all, with as much time as she spends fucking me.  Don't get me wrong, that double-thick dick makes my cunny fuckin' drool, ya know?  But, at the same time, if I could just get some more information on her research, I could have her job.  Then she'd be serving MY desires... yum,</i>\" trails off the sultry, seductive tone.\n\n");
		outputText("The male laughs and says, \"<i>You belong underneath a fat dick, bitch.  Look at you, you've got strings of lube trailing on the ground behind you.  You're too busy slutting it up to accomplish anything.  I'm thinking I had better head back to the lab, though.  I don't want to wind up looking like one of the escaped factory rejects - gotta keep this perfect bod, ya know?</i>\"\n\n");
		outputText("You get a good look at the two when the crowd parts, and wow, that incubus is right.  He's a curly-haired, chiseled Adonis of a man, with a bulge as over-the-top of the rest of him straining at his fashionable pants.  The demon fiddles with his collar, popping it up, and he turns to leave.  The other commiserating devil is a busty succubus in a lab coat... nothing else.  She's even wetter than her companion's words would indicate, painting a thick trail of slippery girl-slime in her wake as she moves.  The succubus' nipples are like two hard bullets, soaking two glorious wet patches into her coat as she argues back.\n\n");
		outputText("\"<i>S-shut up.  That cunt tested some of her prototype compounds on me, remember?  That stuff turned my pussy into an insatiable furnace.  If I can get some free time... I'll... I'll... oh screw it, let's go rent a room and fuck a few times before we go back.  I'll want to be thinking clearly when I face her.  Syrena won't get to gloat about me jumping on her fat... juicy... mmm... cock... this time!</i>\"  The succubus takes the incubus' hand and drags him away in a hurry.\n\n");
		outputText("Well, that explains a lot.  The demons seem to have an active research department, though the one called Syrena does not seem to please her underlings very much.  Then again, you doubt any demonic servants are pleased with their bosses.  You can't wait to put a stop to their labors, but for now, there's nothing to do but use the bazaar or go home.\n\n");
	}
	//[Listen in repeat]
	else if(flags[kFLAGS.BAZAAR_DEMONS_CONVERSATION] == 1) {
		outputText("Just as before, you spot the collar-popping incubus and his lab coat-clad lover complaining about their boss.\n\n");
		outputText("\"<i>-still sore!  I can't believe she did that to me!</i>\" groans the male.\n\n");
		outputText("Smiling cruelly, the slick-pussied succubus says, \"<i>You deserved it.  Honestly, you turned in cum-stained reports to your boss, and you're surprised that she took your ass for a ride as punishment?  If you ask me, you planned all this.  Who do you think had to clean up the huge mess you left on the floor?</i>\"\n\n");
		outputText("For once, the incubus seems speechless.  He mutters, \"<i>Well, I didn't plan it.  I-I was just having fun with one of the new slaves - for inspiration - while I finished up the paperwork.</i>\"  He looks over and punches the leering female's arm.  \"<i>Besides, I thought you liked cleaning up my cum?  I've never seen you complain before.</i>\"\n\n");
		outputText("The succubus laughs and slaps his ass as she answers, \"<i>Don't worry, you taste great... just not as good as the boss.  I dunno what concoction she made that did it, but her spunk is heavenly.  I could just... mmm... swallow that delicious cream all day long.  Do ya think she's part minotaur?</i>\"\n\n");
		outputText("\"<i>Babe, you're sliming everywhere again.  Why don't we go blow off some steam?</i>\"  The two horny demons run off and disappear.\n\n");
	}
	//[Listen in Repeat 2]
	else if(flags[kFLAGS.BAZAAR_DEMONS_CONVERSATION] >= 2) {
		outputText("This time, the two chatty demons are seated near the fire, and the reason for their altered location seems clear.  The succubus' belly is gravid to an unusual degree, utterly packed with some kind of corrupted offspring.  She's rubbing both her hands over the stretched skin-dome and moaning in discomfort, the packed womb squirming beneath her touches.\n\n");
		outputText("Meanwhile, the male incubus is knocking back a beer, grumbling, \"<i>Could you take it down a notch?  It isn't like this is the first time you've had to lug around a load of imps - don't be so melodramatic.</i>\"\n\n");
		outputText("His pregnant companion growls and tugs at her undersized labcoat, failing to conceal the blueberry-colored bulge of her belly from him as she retorts, \"<i>You didn't have to get all these fucked into you, now did you?  Hell, she even shot me up with fertility-plus first!  It feels like there's two dozen of the little bastards packed in there!  I figure in another day or two I won't even be able to walk.</i>\"\n\n");
		outputText("\"<i>So does that mean you won't mind if I stop by whilst you're laid up?  I mean you can't get any more pregnant with imps, and it might pass the time,</i>\" suggests the well-muscled male.\n\n");
		outputText("Smirking, the demoness retorts, \"<i>Sure, but next time you fuck up, I'm loaning Syrena some of my girly stuff to make you suffer just like this.</i>\"  Her hands both point at the imp-engorged skin of her midsection for emphasis.\n\n");
		outputText("The incubus rises and taunts, \"<i>If I fucked up as often as you did, I'd be feeding the furnace in a factory somewhere or fed to the hellhounds.  Come on, let's get you home before I have to roll you back.</i>\"\n\n");
		outputText("Unwilling to allow herself to be helped, the succubus staggers up and begins waddling away.  The incubus keeps his distance, wearing a predatory grin.\n\n");
	}
	//enterTheBazaarAndMenu(false);
	doNext(enterTheBazaar);
	flags[kFLAGS.BAZAAR_DEMONS_CONVERSATION]++;
}

//"Greta's Garments" - Interior
private function gretasGarments():void {
	clearOutput();
	if(flags[kFLAGS.FOUND_SOCKS] == 1 && flags[kFLAGS.SOCK_COUNTER] == 0) {
		outputText("As you enter the store, you're surprised to see that a variety of products line the shelves.  Clothing of various materials, sizes and shapes lay folded on shelves and tables around the little shop.  A lone, surprisingly anatomically correct mannequin stands by the counter nude except for a thin lacy piece of fabric held taut over its wooden penis.");
		outputText("\n\nThe demoness, Greta, spies you looking at the strange piece of clothing.  \"<i>Aha, you're back!</i>\" she says, throwing her arms wide, which has the unintentional but not unappreciated effect of making her enormous boobs jiggle.  \"<i>As you can see, I'm back in full production.  I finally got that pesky backlog taken care of... although this one shy customer, a quiet browser, if you will, keeps me on my toes with new orders.  I swear he and his partner will be the death of me!</i>\"");
		outputText("\n\nThe pink-skinned succubus clicks her tongue disapprovingly for a moment before turning her gaze back to you.  \"<i>Anyway, I've now got a full stock of delicious cock-socks for purchase.  Please, do look around and let me know if you find anything... suitable,</i>\" she giggles and turns her attention back to knitting.");
		camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_SUCCUBUS);
		menu();
		addButton(0,"Next",gretasGarments);
		flags[kFLAGS.FOUND_SOCKS] = 2;
		return;
	}
	if(flags[kFLAGS.FOUND_SOCKS] < 2) {
		outputText("The interior of Greta's Garments is surprisingly bare.  It's literally an empty wagon with a crude bench, a strongbox, a few looms of cloth, and some sewing tools.  However, that's not to say that the shop is empty.  Reclining behind the counter is a pink-skinned succubus, busy knitting what looks like a sock. Even with her slouching posture, you can see that her breasts are truly tremendous - mountainous mammaries that she actually rests her arms on while she knits.  She's completely nude, save for two thin black squares that stretch over her taut nipples (concealing absolutely nothing) and a soaked triangle that's even now threatening to disappear into her gushing crevice forever.");
		outputText("\n\nNoticing your gaze, she sits up a little straighter and swivels on some kind of rotating chair to face you more directly.  Her jiggling breasts slowly bounce to a stop on the counter before her as she asks, \"<i>Can I interest you in something, honey?</i>\"");
		camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_SUCCUBUS);
		outputText("\n\nThere doesn't seem to be anything for sale that you can see");
		if(flags[kFLAGS.OWN_MAIDEN_BIKINI] == 0) outputText(", except maybe a super-skimpy chain bikini that's chased with white and gold highlights");
	}
	else {
		outputText("The interior of Greta's Garments is surprisingly colorful.  Though it started off as an empty wagon filled with loose bolts of cloth and sewing tools, vivid fabrics now cover all the shelves.  Curtains hang from the walls in every color of the rainbow, and a single wooden mannequin stands near the counter, its surprisingly anatomically correct cock covered in a thin, lacey cock-sock.  Sitting nearby, behind the counter, is a pink-skinned succubus, busy knitting what looks like another such sock. Even with her slouching posture, you can see that her breasts are truly tremendous - mountainous mammaries that she actually rests her arms on while she knits.  She's completely nude, save for two thin black squares that stretch over her taut nipples (concealing absolutely nothing) and a soaked triangle that's even now threatening to disappear into her gushing crevice forever.");
		outputText("\n\nNoticing your gaze, she sits up a little straighter and swivels on some kind of rotating chair to face you more directly.  Her jiggling breasts slowly bounce to a stop on the counter before her as she asks, \"<i>Can I interest you in something, honey?</i>\"");
		camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_SUCCUBUS);
		outputText("\n\nThere doesn't seem to be anything aside from cock-socks here");
		if(flags[kFLAGS.OWN_MAIDEN_BIKINI] == 0) outputText(", except maybe a super-skimpy chain bikini that's chased with white and gold highlights");
	}
	outputText(".");
	dynStats("lus", 2, "scale", false);
	menu();
	if(flags[kFLAGS.FOUND_SOCKS] == 0) addButton(4,"Low Stock",askGretaAboutInventory);
	else {
		if(flags[kFLAGS.FOUND_SOCKS] == 2 && player.cocks.length > 0 && player.hasSockRoom()) addButton(1,"Browse Socks",browseDemSocksSon);
		if(player.hasSock()) addButton(2,"Remove Sock",takeOffDatSock);
	}
	if(flags[kFLAGS.OWN_MAIDEN_BIKINI] == 0) addButton(0,"Bikini",askGretaAboutZeBikini);
	addButton(14,"Back",enterTheBazaarAndMenu);

}
//Ask About Inventory
private function askGretaAboutInventory():void {
	clearOutput();
	outputText("Curious about the lack of selection, you broach the topic with the slutty shopkeeper, asking just where the items she has for sale are at.");
	outputText("\n\nThe demoness, who must be Greta, laughs, \"<i>Oh, it's sweet of you to ask, but I just got set up here.  You wouldn't know how hard it is not to go around taming every sweet little boner on display out there, but there's something to be said for earning profit with your own sweat, effort, and charm.</i>\"  She presses her hands against the sides of her chest and turns her tremendous cleavage into a canyon of mammary delight.");
	outputText("\n\n\"<i>See something you like?</i>\" Greta asks, drawing your dazed eyes back up to her face.  \"<i>Well it isn't on the menu today, though you do look like a scrumptious little morsel if I do say so myself.  I've got a lot of work to do if I'm going to keep up with all the demand for my products!</i>\"");
	outputText("\n\nYou look around the store and inquire about what products she could possibly mean.  Greta holds up the sock she was knitting and says, \"<i>These!  I can't make them fast enough!  Every time I get one done, some cute hermaphrodite or wide-hipped femboy is in here buying it up.</i>\"");
	outputText("\n\nYou ask, \"<i>Socks?</i>\" with confusion showing on your face.  What use do herms and girly-boys have for weird socks?  This shop seemed like it would specialize in sexy, not everyday garb!");
	outputText("\n\nGreta laughs so hard that her tits quake, scattering her knitting needles away.  Her tail deftly catches one that rolls off the crude counter's edge, twirling it about before stuffing it into the tight bob she has atop her head.  \"<i>You think this is a sock!?  Ahahahahah!  No, dear " + player.mf("boy","girl") + ", this isn't an ordinary sock.  It's a cock-sock.  See the pattern here?  And the specially sewn gaps?  They let the wearer accentuate every sweet curve and throbbing vein on their erection, all while exposing the most sensitive bits for busy hands and hungry tongues, like mine.</i>\"  She lets her tongue slowly extend out from her mouth, inch after inch of the wiggling, slick organ slowly disappearing into the valley between her tits.  She slowly retracts it with a giggle.");
	outputText("\n\n\"<i>I've got back-orders on these things for miles, so you'll have to wait for me to get caught up before I consider crafting any for you.</i>\"");
	//[Back]
	if(flags[kFLAGS.FOUND_SOCKS] == 0) flags[kFLAGS.FOUND_SOCKS] = 1;
	if(flags[kFLAGS.SOCK_COUNTER] == 0) flags[kFLAGS.SOCK_COUNTER] = 24;
	menu();
	addButton(4,"Back",gretasGarments);
}

//Ask About Bikini:
private function askGretaAboutZeBikini():void {
	clearOutput();
	outputText("\"<i>Oh, that?</i>\" Greta asks.  \"<i>That's an old project of mine.  Some slutty bitch that called herself a pure maiden used to wear it, right up until I got her to forsake her vows, grow a dick, and fuck me until she was addicted to the taste of my cunt and the flavor of my milk.  From what I heard, she came from a place where similarly attired warriors battled to become Queen of some silly country.  Anyway, that gear had some powerful magics on it that pain my kind to handle.  I've been trying to corrupt it into something more fun in my spare time, but it just hasn't been going well.</i>\"");
	outputText("\n\nThe succubi sets down a half-sewn sock and grumbles, \"<i>Do you have any idea how hard it is to unweave a ward while simultaneously infusing it with corruption?</i>\"");
	outputText("\n\nYou shrug.");
	outputText("\n\nGreta blows a lock of inky black hair out of her face and muses, \"<i>I guess not, huh?  Well, I got about halfway done with it - it won't burn you if you've got a lot of corruption in you, but I can't quite easily handle it yet.  From what my pet tells me, it's actually stronger when worn by a virgin, but it may, umm... induce some baser urges thanks to my meddling.  I suppose if you want it, you can have it for 500 gems.  Rent on this heap is coming up, after all.</i>\"");
	//[Buy It] [Back]
	menu();
	if(player.gems < 500) outputText("\n\n<b>You can't afford it.</b>");
	else addButton(0,"Buy Bikini",buyGretasBikini);
	addButton(4,"Back",gretasGarments);
}

//Buy Bikini
private function buyGretasBikini():void {
	clearOutput();
	flags[kFLAGS.OWN_MAIDEN_BIKINI] = 1;
	player.gems -= 500;
	statScreenRefresh();
	outputText("Greta's eyes widen in surprise.  \"<i>Really?</i>\"");
	outputText("\n\nYou nod and pull out your gems, counting out the exact amount for her.  As soon as you finish, Greta pulls you over the counter and kisses you on the lips, her tongue sensually assaulting your surprised palate. Before you can react, she pulls back with a hum of pleasure.");
	outputText("\n\n\"<i>Thanks, sugar!  Have fun and be safe, and if you don't want to be safe, come visit me sometime!</i>\"");
	outputText("\n\nYou'll have to keep that in mind...  ");
	inventory.takeItem(armors.LMARMOR, camp.returnToCampUseOneHour);
}

//Cock-socks Available - First Time
private function browseDemSocksSon():void {
	clearOutput();
	outputText("What type of cock-sock do you want to look at?");
	//Cock-sock Menu
	menu();
	var bd:ButtonDataList = new ButtonDataList();
	var cockSocksVariant:Array = ["wool", "alabaster", "viridian", "scarlet", "cobalt", "gilded", "amaranthine", "green", "red", "blue", "cockring"];
	bd.add("Wool",curry(cockSockType, 0));
	bd.add("Alabaster",curry(cockSockType, 1));
	bd.add("Viridian",curry(cockSockType, 2));
	bd.add("Scarlet",curry(cockSockType, 3));
	bd.add("Cobalt",curry(cockSockType, 4));
	bd.add("Gilded",curry(cockSockType, 5));
	bd.add("Purple",curry(cockSockType, 6));
	bd.add("Green", curry(cockSockType, 7));
	bd.add("Red", curry(cockSockType, 8));
	bd.add("Blue", curry(cockSockType, 9));
	bd.add("Cockring",curry(cockSockType, 10));
	submenu(bd, gretasGarments, 0, false);

	function cockSockType(cocksock_type:int):void{
		var cost:int = 0;
		clearOutput();
		switch (cocksock_type) {
			case 0:
				outputText("You spy a thick, woolen sock sitting on a counter and take it up to Greta.  \"<i>Ah, yes.  That's our basic sock.  Warm and cozy, great for those chilly nights.  That one's a mere 10 gems.  A steal, of course.</i>\"");
				cost = 10;
				break;
			case 1:
				outputText("You pick up a one sock and inspect it.  It's a pure white cock sock, edged with delicate lace.  It almost appears to be some kind of bridal wear... although you don't know of any kind of bride that would wear something like this.  \"<i>Ah yeah, that's a popular one.  Some folks like the purity that it suggests... though I can't guess why.  It's 25 gems, though.</i>\"");
				cost = 25;
				break;
			case 2:
				outputText("You pick up one sock and inspect it.  The whole thing is a rich, natural green color and completely lace, accentuated with vivid red roses.  Just touching it makes you feel healthier and more alive.  \"<i>Ahh, that's a fun one right there.  It hastens your natural healing.  Very useful, and pretty, too, if I say so myself.  It's 1,000 gems.</i>\"  You pale at the price, but Greta waves a hand, \"<i>Trust me, honey, it's worth it.</i>\"");
				cost = 1000;
				break;
			case 3:
				outputText("You pick up one sock and inspect it.  It's an incredible plush red, and made of soft satin and detailed with red lace.  It seems smaller than the other socks you've seen, and you can't help but wonder how tight it will feel on your dick.  \"<i>Mmm, that one's special.  It increases the blood flow to your little dick, enabling it to grow a lot faster.  This one goes quick.  Everyone wants to be a minotaur!  It's 250 gems.</i>\"");
				cost = 250;
				break;
			case 4:
				outputText("You pick up one sock and inspect it.  It's a cool, soft blue color, made from satin and detailed in light blue lace.  It seems extremely small, compared to the other socks in the shop, and you can't help but think it must be extremely uncomfortable to wear.  \"<i>Oho, that's a fun one right there.  The cute little femboys go crazy for it.  As you can see, it's a bit small, and it will actually inhibit your cock from growing too big.  It's 250 gems.</i>\"");
				cost = 250;
				break;
			case 5:
				outputText("You pick up one sock and inspect it, surprised to see how rigid and heavy it is.  Unlike the others in the shop, this one seems to be made of a cool golden metallic material.  Glittering gems are embedded into the top side, while the bottom is cinched closed with leather cords.  \"<i>You've got a good eye,</i>\" Greta says, her eyes twinkling greedily.  \"<i>With that bad boy, you can actually convert some of your... sweet cum into even sweeter gems.  Of course, with that kind of awesome power, you've got to understand that it'll cost you 3,000 gems.</i>\"");
				cost = 3000;
				break;
			case 6:
				outputText("You pick up one sock and inspect it.  It's a silky smooth lavish purple color, with fine lace depicting some kind of six-legged wolf-like creature.  Overall, though, the sock is an odd shape, seemingly intended for someone with a knot AND some kind of equine-like flare.  Greta's eyebrows raise as she sees the item you're holding,  \"<i>Ohh, that one.  That, honey, was an experiment.  I took some magic channeled down from the stars themselves and infused it into a new sock, and that was the result.  Truth be told, I'm not entirely sure what it does, but I'll sell it to you for 1,000 gems.</i>\"");
				cost = 1000;
				break;
			case 7:
				outputText("You pick up one sock and inspect it.  It's dark green in color and interlaced with brighter green highlights.  Greta's eyebrows raise as she sees the item you're holding,  \"<i>Ohh, that one.   It's one of my newest lineup of cock-socks.  If you're unsure of your endurance, this might help.  I'll sell it to you for 500 gems.</i>\"");
				cost = 500;
				break;
			case 8:
				outputText("You pick up one sock and inspect it.  It's dark red in color and interlaced with brighter red highlights.  Overall, it looks a bit menacing.  Greta's eyebrows raise as she sees the item you're holding,  \"<i>Ohh, that one.  It's one of my newest lineup of cock-socks.  This cock-sock will enhance your power so you can physically beat tougher opponents.  I'll sell it to you for 500 gems.</i>\"");
				cost = 500;
				break;
			case 9:
				outputText("You pick up one sock and inspect it.  It's dark blue in color and interlaced with brighter blue highlights that seems to glow in the dark.  Greta's eyebrows raise as she sees the item you're holding,  \"<i>Ohh, that one.   It's one of my newest lineup of cock-socks.  This cock-sock will enhance your spellpower.  I'll sell it to you for 500 gems.</i>\"");
				cost = 500;
				break;
			case 10:
				outputText("You pick up one sock, surprised to find how heavy it is.  Large metal rings encircle the base of the smooth cock-sock, with one loose ring dangling down, no doubt intending to wrap around the base of your ball sack.  \"<i>Oh yes, that's a fun one. Those rings will constantly constrict your manhood, so you'll always be hard and ready to go.</i>\" She giggles and waves a hand, \"<i>That's actually a very popular sock... so many demons come in to get these for their harems.  It's 100 gems.</i>\"");
				cost = 100;
				break;
		}
		prePurchase(cocksock_type, cost);
	}

	function prePurchase(cocksock_type:int, cost:int):void{
		menu();
		if (player.gems >= cost) addButton(0, "Buy it!", pickACockForSock, cocksock_type, cost);
		else addButtonDisabled(0, "Buy It!", "You can't afford it!");
		addButton(4,"Back",browseDemSocksSon);

	}

	function pickACockForSock(cocksock_type:int, cost:int):void {
		//Buy Cock-sock
		clearOutput();
		outputText("You take the cock-sock over to the counter where Greta sits, knitting even more garments and place down the gems required.  \"<i>Aha, good choice, honey!</i>\" the succubus says, snatching up the money and stashing it away.  \"<i>Now let's get that bad boy fitted on you.</i>\"");

		//[If PC only has one cock, jump immediately to Putting It On, else:
		if(player.cockTotal() == 1) {
			menu();
			addButton(0,"Next",lastchance2backout,cocksock_type, cost);
		}
		else {
			outputText("\n\nWhich cock would you like to put it on?");
			var button:int = 0;
			menu();
			while(button < player.cockTotal()) {
				if(player.cocks[button].sock == "") addButton(button,String(button+1),lastchance2backout, cocksock_type, cost, button);
				button++;
			}
		}
	}

	function lastchance2backout(cocksock_type:int, cost:int, cockChosen:int = 0):void{
		flags[kFLAGS.SOCKS_BOUGHT]++;
		//Putting it On - First Time
		if(flags[kFLAGS.SOCKS_BOUGHT] == 1) {
			outputText("The gravity-defying succubus gestures towards your crotch.  \"<i>Well, come on then, let's see the tasty cock getting all dressed up,</i>\" she says, her voice becoming a deep purr.  You raise your eyebrow, questioning why she needs to see that.");
			outputText("\n\n\"<i>Oh, don't you know?  These aren't your ordinary garments,</i>\" she cackles lightly.  \"<i>These are quite special cock-socks.  They won't slip or slide.  No matter what, they'll remain in place until you want me to take it off.</i>\"");
			outputText("\n\nYou balk a little.  These things are going to be permanently attached to you?");
			outputText("\n\nSeeing your reaction, Greta calmly explains, \"<i>Don't worry, it's just a simple little spell.  You can still use your dick, cum and all that delicious fun stuff.  This spell will just prevent it from slipping off no matter if you're limp or hard, and it will keep the material clean and repaired.  Before I learned this spell, you wouldn't <b>believe</b> how many socks I had to wash and stitch back together. I had no time to make new ones!</i>\"");
			outputText("\n\nYou gulp.  Do you want this cock-sock attached to your penis semi-permanently?");
		}
		//Putting It On - Additional Times
		else {
			outputText("Greta motions with her hand, a movement that causes her mountainous cleavage to jiggle hypnotically.  \"<i>Well, come on then, let's see the tasty cock getting all dressed up,</i>\" she says, her voice becoming a deep purr.");
			outputText("\n\nWell?  Do you want this cock-sock attached to your penis semi-permanently?");
		}
		menu();
		addButton(0,"Yes",cockSockInstall, cocksock_type, cost, cockChosen);
		addButton(1,"No",noCockSock);
	}

	function cockSockInstall(cocksock_type:int, cost:int, cockChosen:int = 0):void{
		var conflict:Boolean = false;
		if(cockSocksVariant[cocksock_type] == "viridian") {
			if(!player.hasPerk(PerkLib.LustyRegeneration)) {
				player.createPerk(PerkLib.LustyRegeneration,0,0,0,0);
			}
			else {
				conflict = true;
			}
		}
		if(cockSocksVariant[cocksock_type] == "cockring") {
			if(!player.hasPerk(PerkLib.PentUp)) player.createPerk(PerkLib.PentUp,10,0,0,0);
			else player.addPerkValue(PerkLib.PentUp,1,5);
			player.buff("PentUp").setStat("minlustx", player.perkv1(PerkLib.PentUp)*0.01).withText("Pent up");
		}
		outputText("You nod to the busty succubus and strip off your [armor], revealing your naked body.  Greta's eyes light up as she looks over your body with barely-contained lust.  Finally her eyes settle onto your " + cockDescript(cockChosen) + ", and she licks her lips.  ");
		player.gems -= cost;
		if (!conflict) { // There's no conflict. DO IT!!!
			player.cocks[cockChosen].sock = cockSocksVariant[cocksock_type];
			statScreenRefresh();
			outputText("With one hand she lifts your limp cock up, giving it a pleasant little stroke.");
			outputText("\n\nHer other hand approaches, her thumb, fore- and middle-fingers holding the sock open as she slips it over your " + player.cockHead(cockChosen) + ".  She pulls it snugly into place and then gives your penis a little kiss.  The second her lips make contact with your flesh, a chill runs across your body, followed by a flood of warmth.");
			outputText("\n\nGreta smiles knowingly and returns to her chair behind the counter.");
			//(Cock-sock get! +2 Corruption, +5 Arousal)
			dynStats("lus", 5, "cor", 2);
		}
		else { // Conflict! NOOOOO! Pull up! Pull up!
			outputText("Then she suddenly stops, staring at your groin.\n\n\"<i>Oh, dear...</i>\" she says, \"<i>As much as I would love to take your money honey, I can't be mixing magics like that.</i>\"");
		}
		menu();
		addButton(0,"Next",gretasGarments);
	}

	function noCockSock():void {
		clearOutput();
		outputText("You shake your head.  Greta sighs, \"<i>Figures. Come back when you change your mind.</i>\"");
		menu();
		addButton(0,"Next",gretasGarments);
	}

}

//Remove Cock-sock
private function takeOffDatSock():void {
	clearOutput();
	outputText("Which cock-sock would you like to get removed?");
	//(display list of socked cocks)
	var button:int = 0;
	menu();
	while(button < player.cockTotal()) {
		if(player.cocks[button].sock != "") addButton(button,String(button+1),removeTargettedSock,button);
		button++;
	}
	addButton(14, "Cancel", gretasGarments);

}

private function removeTargettedSock(index:int):void {
	clearOutput();
	//Select-A-Cock!
	outputText("You walk up to the counter top.  Greta the succubus looks up at you over her latest creation, and you explain you'd like to remove a cocksock.");
	outputText("\n\n\"<i>Ah, all right then,</i>\" she says smoothly, setting aside her knitting needles.  \"<i>Making room for a new sock, or just looking to get rid of this one?  No matter, it's a simple counterspell.</i>\"  Greta stands up from her chair, though she's only on her feet for a moment before she kneels down in front of you, placing one hand under your " + cockDescript(index) + ".  With her free hand, she runs a little circle around your " + player.cockHead(index) + ", muttering something under her breath.");

	outputText("\n\nSuddenly your cock feels white-hot, burning with passionate arousal.  It jumps to attention immediately");
	if(player.cockArea(index) >= 100) outputText(", almost knocking Greta over in the process");
	outputText(", the cock-sock suddenly feeling unforgivingly tight.  With a light giggle, Greta gives your dick a soft kiss, and the burning arousal seems to dissipate, replaced with a cool, relaxing sensation that spreads throughout your body.");
	outputText("\n\nYour dick rapidly deflates, and as it does so, the sock covering it falls off naturally.  The busty succubus gathers up the now-mundane sock and returns to her seat behind the counter.");

	var storage:String = player.cocks[index].sock;
	var extra:Boolean = false;
	player.cocks[index].sock = "";
	var i:int = player.cockTotal();
	while(i > 0) {
		i--;
		//If the PC has another cock with the same effect.
		if(player.cocks[i].sock == storage) {
			extra = true;
		}
	}
	if(extra && storage == "cockring") {
		if(player.perkv1(PerkLib.PentUp) >= 10) player.addPerkValue(PerkLib.PentUp,1,-5);
		else player.setPerkValue(PerkLib.PentUp,1,10);
		player.minLustXStat.addOrReplaceBuff("Pent up", player.perkv1(PerkLib.PentUp)*0.01);
	}
	else {
		if(storage == "gilded") {
			player.removePerk(PerkLib.MidasCock);
		}
		if(storage == "cobalt") {
			player.removePerk(PerkLib.PhallicRestraint);
		}
		if(storage == "scarlet") {
			player.removePerk(PerkLib.PhallicPotential);
		}
		if(storage == "viridian") {
			player.removePerk(PerkLib.LustyRegeneration);
		}
		if(storage == "cockring") {
			player.removePerk(PerkLib.PentUp);
			player.minLustXStat.removeBuff("PentUp");
		}
	}
	outputText("\n\n\"<i>If you need another one, we've got plenty more for sale.</i>\"");
	//(Cock-sock lost! +5 Corruption, -10 Arousal)
	dynStats("lus", -10, "cor", 1);
	menu();
	addButton(0,"Next",gretasGarments);
}

/*At the Slippery Squeeze
There's another option on the list, cheerfully presented with a pastel border and a little painted egg next to it.  'Sweet Massage' it says.  \"<i>That's our spring special,</i>\" Joey explains, \"<i>using our new chocolate-flavored massage oil.  It comes with a complimentary 'dessert.'</i>\"  He gives you a little wink at that last word, so you can be certain that it's no normal dessert.
*/

//"Sweet Massage"
private function joeySweetMassage():void {
	clearOutput();
	player.gems -= 20;
	statScreenRefresh();
	outputText("Joey claps excitedly, his little puffy tail bouncing happily.  \"<i>Great!  It's a customer favorite, so I'm sure you'll just love, love, love it!</i>\"  He takes your hand and leads you towards the back rooms, letting the door shut behind the two of you with a soft click.  As usual, in the center of the room is a padded bed meant for you, and at Joey's insistence you disrobe to lie down on it.  You put your face through the rounded oval and relax, taking the moment to watch Joey's bare feet with their cute painted nails prance in and out of sight as he bustles around the room.  He pauses briefly by the coal-fired steam-oven, stoking it for a minute before turning back towards you.");

	outputText("\n\nThe warm, steamy air caresses your " + player.skinFurScales() + " even before Joey does, running down your back, butt and [legs].  In no time at all, the air in the room is thick and warm, making you feel delightfully lazy with every breath, and a bead of sweat forms on your brow.  The bed shifts a bit as Joey leaps up onto it, straddling your waist, while he starts working his fingers over your shoulders.  His petite hands are surprisingly talented, finding every little knot you've accumulated in your journeys and unravelling them with one blissful touch.");

	outputText("\n\nAs usual, he works his way down your body, sliding his hairless body against yours as he goes.  His magic fingers work out a particularly troublesome knot in your lower back in no time, then he moves to your arms and legs.  He doesn't stop until you feel like putty, so relaxed you wonder if you're even capable of movement.  Afterwards he simply rubs you down, checking for any missed tension spots.  The whole while his little cock strains the little white thong he sports, occasionally pressing against your back, butt or leg.");

	outputText("\n\nJoey hops off of you and you notice his cute femboy feet round the table, heading towards a small counter nearby hosting a large number of bottles.  You hear the sounds of a cork being pulled from one such bottle, followed by the bunny-boy gulping down its contents.  Then, surprisingly, he bends over, letting his thong pool around his ankles and revealing his cute, pink asshole.  He retrieves something else from the table and pulls it into view... a large multihued egg!  Joey places the egg at his butthole, which contracts in anticipation.  Slowly he works it inside, a task that you're sure would put the average anal acrobat to the test, but Joey is clearly no amateur.  The egg disappears completely within a couple minutes, swallowed up by that sweet little pucker.  Joey pulls his thong back up and turns towards you, his modest erection raging right in front of your face.");

	outputText("\n\nRather than the usual stream of off-white jism, what starts pouring out the tip of his cock is a rich brown color.  It's viscous, and when it dribbles down onto the floor it forms a velvety pool.  Your masseuse scoops some of it up with two fingers and slips them into his mouth, closing his eyes as if he's enjoying an incredibly tasty treat.  \"<i>Mmm,</i>\" he moans, \"<i>chocolate.  This is what makes the sweet massage so sweet.  It's just as good as my creamy lotion, and twice as tasty.</i>\"  Joey turns away, retrieving another large egg from the table.  You wonder briefly if he has room for two of the two huge eggs in his ass, before he asks, \"<i>Would you like an egg too?  They don't have anything to do with the massage, but I just </i>love<i> feeling so full, don't you?</i>\"");
	dynStats("lus", 25, "scale", false);
	//[Yes (gives the chocolate-egg stuffed ass from the Easter bunny)] [No (This just skips the "If Yes" paragraphs)]
	menu();
	addButton(0,"Yes",eggsInButtStart,true);
	addButton(1,"No",eggsInButtStart,false);
}

private function eggsInButtStart(eggButt:Boolean):void {
    if(eggButt) {
		outputText("You nod your head to the little femboy, who jumps with joy, splattering a little string of chocolate cum across the floor.  He walks around behind you and asks you to raise your butt.  You do so, surprised to find you can move after that initial massage, raising your ass high into the air and positioning your knees under you.  You can't see what he's doing back there, but when you feel a warm splash of liquid against your [asshole], you let your mind's eye go to work.");
		outputText("\n\nJoey gathers up another dollop of the chocolatey cum and smears it across your butthole. Then he takes two fingers and gently prods inwards, sinking in knuckle-by-knuckle.  He works the two fingers in, pumping and sliding them around, coating your walls with his jizz.  When the bunny-boy retracts his fingers, you find yourself aching for his touch, wanting something, anything, inside you.  You don't want for long, of course, as Joey retrieves the giant painted egg and presses it up against your empty asshole.  He pushes it forward, your cum-lubed ass parting to make way.  It stretches you further and further outwards, nearing discomfort levels, but then you round the widest point and your [asshole] devours it with a wet <i>schluck</i>.");
		outputText("\n\nJoey rubs your asshole some more, working his little masseuse fingers all over, helping it to relax once more.  You feel so deliciously full with that egg inside you, like you have a giant cock constantly fucking you.  It gives you a little thrill to know that both of you are packing this monster of an egg inside of you, and that he's feeling the same things you are.  You lower your legs and ass marveling at the sensations of the egg shifting around.\n\n");
	}
    sceneHunter.selectGender(curry(eggsInButt, 0), curry(eggsInButt, 1), curry(eggsInButt, 2));
}

//dick - 0, vag - 1, ass - 2
private function eggsInButt(dickVagAss:int):void {
	clearOutput();
	//(Continue Here)
	outputText("The dainty little femboy hops back up onto the table, straddling your ass.  He gives his cock a few little strokes, pouring the warm chocolatey 'massage oil' right onto the small of your back.  Rivulets of the bunny-spunk cover your back, giving you goosebumps as they roll across you like velvety rivers.  His hands go to work once more, working the rich brown liquid into every pore, coating your back in chocolate.  He repeats his actions from before, his thumbs and knuckles working your flesh as though he were a master sculptor working clay.");
	outputText("\n\nWithout bothering to get off of you, Joey asks, \"<i>You want to turn over for me?</i>\"  You oblige, rotating around while the masseuse remains straddling your lower body.  His little cock presses against your ");
	if(dickVagAss == 0) outputText("own");
	else if(dickVagAss == 1) outputText("cunt");
	else outputText("pitifully empty mound");
	outputText(", its candy-coated flesh slipping enticingly over yours.  To your surprise, Joey seems to be wearing some kind of cock ring for this massage.  It's multicolored, just like the eggs, encircling his small (by Mareth's standards) manhood.  As you watch his balls seem to twitch and inflate ever-so-slightly.  That thing is preventing him from cumming completely, whatever it is, everything coming out must be pre-cum!");

	outputText("\n\nJoey catches your gaze, \"<i>Oh yes.  This would be your dessert, I'm saving all this sweet chocolate just for you.  The ring is candy too.  Melts in your mouth, not on my dick.  But that 'comes' later, now we have to work out all that tension in your body.</i>\" He giggles, letting his cock drool its candy payload all over your groin, stomach and chest before getting to work, his fingers working the goo into your skin.  As he works on your stomach, groin and hips, he actually flips around, so that his dripping package is right over your face.  Chocolate drips onto your face, and you can't help but to lick your lips to sample this confectionary cum.  It's sweet and rich, just like real chocolate, but it still has the salty-sweet tang of semen.  All in all, it's an interesting combination that you're eager to get more of.");

	outputText("\n\nThe rabbit-eared boy's hands find your ");
	if(dickVagAss == 0) outputText(multiCockDescriptLight());
	else if(dickVagAss == 1) outputText("[vagina]");
	else outputText("[asshole]");
	outputText(", spreading his sweet bounty all over.  His fingers to go work, rubbing up and down");
	if(!dickVagAss == 0) outputText(", in and out");
	outputText(", removing all that pent-up tension from inside you.  ");
	if(dickVagAss == 0) outputText("[EachCock] begins leaking pre-cum, mixing with Joey's on your belly to create what looks like a chocolate-white chocolate marbled confection.");
	else if(dickVagAss == 1) outputText("Your cunt grows ever wetter, and not just because of the new chocolate coating.  Despite Joey's femboy appearance, you've got to hand it to him, he does know his way around a pussy.");
	else outputText("Your asshole winks and clenches, aching for release that Joey is kind, and skilled, enough to give.");

	outputText("\n\nIn no time at all, your body is arching on the bed under Joey's ministrations.  You gasp as his fingers twirl around your groin, expertly bringing you to the edge.  More of his chocolate-flavored cum drizzles into your open mouth; you can't help but gulp it down eagerly.  Every mouthful of that rich, sweet cum seems better than the last.  Sadly, Joey switches positions, straddling your waist, leaving your chocolate-smeared mouth empty once more.  He ");
	if(dickVagAss == 0) outputText("takes hold of [oneCock] and strokes gently, rubbing his thumb against the head");
	else if(dickVagAss == 1) outputText("reaches between his legs, slipping two fingers inside you while his thumb gently rubs your clit");
	else outputText("reaches between his legs, slipping two fingers inside your ass while his thumb rubs against your perineum");
	outputText(", and with his free hand he leans forward, tweaking a [nipple] softly.");

	outputText("\n\nUnder his skilled hand, you're soon bucking and twitching, your candy-coated body aching for release.  \"<i>Let's... just... get all of this... naughty... tension... out,</i>\" he pants, emphasizing each word even though his voice barely rises above a whisper.  With one final twist of his fingers, you're sent over the edge.  Your body arches, lifting Joey up into the air with a gleeful shout, while ");
	if(dickVagAss == 0) outputText("[eachCock] pulses and spasms, letting loose rope after rope of white jizz through the air, splattering against the wall and floor messily");
	else if(dickVagAss == 1) outputText("your pussy tightens around his fingers, suddenly releasing a flood of femcum that splatters messily against the table");
	else outputText("your asshole twitches and spasms, unable to do much more than grant you a vague half-orgasm");
	outputText(".  Your entire body tingles as you slowly descend back to the table, practically melting into it as if you were nothing more than the bunny-spunk covering your skin.");

	outputText("\n\nJoey giggles again, slipping off of you, landing on the floor with a wet slap.  The floor must be covered in various liquids by this point.  He raises his hand to his mouth, tasting the mixture of your juices on his fingertips.  You lean back on the bed, completely relaxed.  You try to raise a hand, but fail completely, your body is simply too loose to obey you right now.  Thankfully, you don't have to move for what Joey seems to have in mind.  He flips a lever on the headrest, lowering it down slightly so your head is almost hanging off the edge.  You see him upside down, his chocolate-glazed cock staring right down at you.  His sack, amazingly, has swelled up incredibly during the massage.  While he once sported an average set of balls, these are easily the size of basketballs now, filled with tasty candy goodness.");
	outputText("\n\n\"<i>Mmm, this is my favorite part!</i>\" Joey laughs, stroking his dick, \"<i>dessert!</i>\"  You gladly open your mouth just as Joey pushes forward, taking his entire member into your mouth.  Considering what else lives in Mareth, Joey is practically tiny");
	if(dickVagAss == 0) {
		if(player.biggestCockArea() >= 30) outputText(", especially compared to you.");
		else if(player.smallestCockArea() < 6) outputText(", of course, if he's considered tiny, what does that make you?");
	}
	else outputText(".");
	outputText("  You suck and slurp, slipping your tongue up and down his length until not a trace of chocolate remains.  His penis continues to leak the chocolatey pre-cum, but the deeper you take him, the less it matters, until he's practically pumping the chocolate directly into your stomach.");

	outputText("\n\nYour lips eventually wrap around the cock ring keeping you from your 'dessert.'  You suck and lick at it, tasting the hard candy shell.  It takes several minutes of dedicated licking; all the while Joey continues to directly feed your gullet with his pre-cum.  Finally, the cockring snaps.  It's like a dam bursting: what was once a trickle of chocolate becomes a flood.  Joey's cock bulges unnaturally as what must be a gallon of rich, sweet chocolate is released into your mouth and throat.  You hungrily gulp it all down, not even taking the time to savor its taste, just wanting more and more of the velvety bunny spunk.");

	outputText("\n\nA strange bulge runs over your tongue, through Joey's cock.  You reflexively swallow, amazed to find it's something solid... he just laid a tiny egg in your mouth!  Another bulge presses up his cock, and this time you take it into your mouth, rolling the oblong chocolate around before swallowing that too.  Egg after egg flows into your mouth, leaving your head spinning as you struggle to take them all.  After what seems like hours, when in reality it was more like minutes, of sucking, swallowing and slurping, Joey pulls out of your mouth and leans against the wall, exhausted.  You take even longer to recover.  Your stomach gurgles happily, filled with Joey's jizz and his candy egg bounty.");

	outputText("\n\nJoey sets the headrest back up, pats you on the head and says, \"<i>Take as long as you want to recover, you sweet thing, you.  There's a towel on the table, and a shower in the back!  Come back ANY time, [name].  I'd love to give you another 'dessert.'</i>\"");

	outputText("\n\nJoey leaves, his rabbit tail bobbing to and fro.  You see his thong is distended, practically packed to the brim with more of his still-drooling chocolatey cum.  As usual, the waterproof thong seems to be pumping it all between his soft thighs and right into his already egg-filled asshole.  He really does like feeling full back there.  Kinky.");
	player.sexReward("cum", "Default");
	dynStats("sen", -2);
	doNext(camp.returnToCampUseOneHour);
}

//Visit the Bizarre Bazaar at night.
public function nightBazaarButtfuck():void {
	clearOutput();
	outputText("While wandering the bazaar at night, you feel an unease growing in your stomach. As you walk your dimly lit path, you pause and notice a rather dark pathway that you haven't seen before. Curiosity sparks in your wandering mind and you can't help but wonder how long it has been here and where it leads. Should you wander down this dark path despite the thoughts bubbling in your head that it's a bad idea?");
	outputText("\n\nDismissing that nagging feeling in the back of your mind, you head down the unlit path toward adventures unknown.  You comfort yourself with the prospects of adventure and the excitement of exploration.  Your ever-optimistic mind is lost in wonder when a flap of a large tent to your side suddenly bursts open.  \"<i>Fine! I'm goin', I'm goin'! Put a fuckin' cock in it!</i>\"");

	outputText("\n\nYou turn your head to find the source of the gruff, yelling voice and find a large figure storming from the tent.  As you squint in the darkness to make out the figure, you think you see them fumble with the pockets of their pants.  You realize the figure has noticed you when two glowing, green eyes lock onto you.  \"<i>Why, hello there...</i>\"  The guttural voice utters slowly.  They draw closer, and soon the only sound in the alley that you can focus on is your heartbeat and the figure's shuffling footsteps over the dirty trail.  Your heart pounds as your mind races to figure out what to do.  In this isolated, dark pathway you can't help but feel the figure is going to try and take advantage of you.  Your back presses to the cold trunk of the adjacent tree as the figure drunkenly swaggers toward you.");

	outputText("\n\nThe figure finally comes before you. Now that you're closer you can make him out better.  \"<i>What you doin' here?</i>\"  The large feline asks, a growl to his voice that leaves you wondering if he's annoyed or upset.  You do your best to calm yourself down and explain how you were just exploring the bazaar. To match the glowing eyes, a glinting grin of jagged teeth forms between the figure's black lips.  \"<i>I was just headin' there myself.  We should go together.  It's not safe to wander around at night, even for a big guy like me.</i>\"  A raspy snicker follows as a strong grip wraps around your shoulder.  \"<i>Let me just get some more cash and I'll treat ya.</i>\"  The feline purrs a generous offer as you feel him pulling you towards the tent he just exited from.  Your eyes peer around as the feline starts to drag you.  No one is around to help you.  The trail is completely vacant. An uneasy feeling quickly grows in the pit of your stomach.  Something is wrong.");
	//open options [Escape][Wait][Assault]
	menu();
	addButton(0,"Escape",escapeFromCertainRape);
	addButton(1,"Wait",waitOnStuff);
	addButton(2,"Assault",assaultYoRapistYo);
}

//<Option 1 Escape>
private function escapeFromCertainRape():void {
	clearOutput();
	outputText("You tear yourself away from the feline. Wide, surprised eyes stare at you as you make a break for it.  You run as quickly as your legs can carry you, the echoes of the feline's feet padding behind you urging you to run faster.  You flee through the trees mindlessly, darting down whatever path you see first.  In your panic, though, you quickly wear yourself out.  How far did you run? Where are you now?  You lean against a trunk and pant for breath.  Thankfully no one seems to be around, including your pursuer.  You pat yourself off as you notice the bright lights of the bazaar nearby and retreat back to the well-lit collection of tents.");
	//gtfo
	menu();
	addButton(0,"Next", enterTheBazaarAndMenu);
}

//<Option 2 Wait>
private function waitOnStuff():void {
	clearOutput();
	outputText("Uncertainty plagues you as you wait to see what happens.  The large feline reaches the entrance of the large tent.  His free hand grips the tent and, as you let out a loud yelp, you are shoved forcefully through.");
	//Pass go and collect 200 rape
	menu();
	addButton(0,"Next",collectSomeButtSmex);
}

//<Option 3 Assault>
private function assaultYoRapistYo():void {
	clearOutput();
	//Strength Check
	//[(If strength is less than 50)
	if(player.str + rand(30) < 50) {
		outputText("Intending to turn the tables, you grip the feline man's wrists and pull as hard as you can to wrest yourself away from the strange figure.  Your muscles fail you, though, and the feline quickly pins your arms behind your back.  Though you strain against them, the stronger hands hold you in place.  You spit silent curses at yourself for not spending more time at the gym.  \"<i>Nice try.  It was almost... Cute.</i>\" You hear the figure snicker again behind you before you are promptly shoved through the entrance to the large tent.");
		//Pass go collect 200 rape
		menu();
		addButton(0,"Next",collectSomeButtSmex);
	}
	//<Option 3 Assault>
	//Strength Check
	//[(If strength is 50 or more)
	else {
		outputText("You huff your breath as the weaker figure tries to force you to cooperate.  You shake your head before quickly overpowering the figure. Your strong grip clenches him around the wrists, his fur soft under your fingers.  With a sharp grunt you bend them over and push their face into the dirt.  The feline snarls and attempts to yank his arms from your grasp as you hold both wrists in one hand.  You lean down to look him over, the light peeking through the nearby tent to reveal his orange fur with black stripes.  You have a large, burly tiger man pinned under you.  What do you do with him?");
		//open options [Leave][Abuse ass(70 or more corruption)]
		menu();
		addButton(4,"Leave", assaultWinAndLeave);
		if(player.cor >= 66 - player.corruptionTolerance) addButton(0,"Abuse Ass",abuseHisAss);
	}
}

//<Option 1 Leave>
private function assaultWinAndLeave():void {
	clearOutput();
	outputText("You shove the large tiger man across the dirt.  His annoyed growls are muffled by the dirt his face is sliding across.  You issue a warning about picking fights with those stronger than he is and leave him lying in the dirt, his pride battered and bruised.  The dirt under your heel grinds in the darkness as you turn and casually continue down the path until you find yourself back in the bazaar.");
	//gtfo
	menu();
	addButton(0,"Next", enterTheBazaarAndMenu);
}

//<Option 2 Abuse Ass(Visible with 70 or more corruption)>
private function abuseHisAss():void {
	clearOutput();
	outputText("Your tongue flicks from your lips at all the possibilities that course through your mind.  \"<i>Lemme go!</i>\"  The feline barks out from under you, though you have better ideas.  You move your free hand back and roughly pull down his pants, exposing his muscled rump to the cool, night air.  Feeling a firm cheek beneath your hand, you rub and squeeze it almost affectionately before swatting the cheek roughly, coaxing a strained grunt from the tiger man's mouth.");

	//[(If player doesn't have cock)
	if(!player.hasCock()) {
		outputText("\n\nDeciding to humiliate the poor fool, you begin to spank your hand against the tiger man's rear.  Your swats grow steadily more forceful and your slaps begin to grow louder and louder, filling the night air with the sound of your hand slapping firm cheeks.  You reduce the defiant growls uttered by the tiger man to soft whimpers and he slowly ceases his struggles and submits.  Your hand grips a cheek firmly, fingers digging into the abused flesh and feeling the warmth of the sting you've inflicted.  Tilting your head over, you can't help but smirk as the tiger's erect manhood juts out between his legs.");

		outputText("\n\n\"<i>What's that racket?</i>\" You turn your head, hearing a low voice shout from inside the nearby tent.  With a snicker you shove the humiliated tiger to the ground and leave him exposed and aroused as the occupants of the tent pour out.  By the time they surround him you are long gone and back to the well-lit collection of tents in the bazaar.");
		//gtfo
		menu();
		addButton(0,"Next", enterTheBazaarAndMenu);
		return;
	}
	//[[[(If player does have cock)
	outputText("\n\nYou decide to have a little fun with the muscular ass in front of you.  You hold the struggling tiger's wrists with one hand and fish out your [cocks] free from your [armor].  Your eyes drink in how the burly tiger man writhes under you.  He's completely at your mercy.");
	//[(If multicock)
	if(player.cockTotal() > 1) outputText("  Your hand strokes along your [cocks] and press them to the warm cheeks exposed before you.");
	else outputText("  You pump your [cocks] and milk a pearl of pre-cum out to drip onto the enticing ass before you.");
	outputText("  \"<i>O-OI!</i>\"  The tiger man shouts out, his head turning to try to see behind him.  With a grin on your lips you grip the hilt of [oneCock] and slap its length over the tiger's rump.  You can see the tint to the tiger man's cheek as he hears and feels your dick smacking his exposed ass.  Pre-cum drips down [oneCock] as you line yourself up, jamming it between the tiger's lovely mounds. He gives a surprised shout as your cockhead presses to his tiny, puckered hole.");

	//Cocksize check
	//(If smallest cock is over 16 inches)
	if(player.smallestCockLength() >= 16) {
		outputText("\n\nYour lips part to let out a grunt of frustration.  Your cockhead is unable to break through the tiger man's tight resistance.  His struggles start to die down as [eachCock] continues to drool over his muscled rear.");
		if(player.cockTotal() == 1) outputText("  You squeeze your [cocks] between his warm ass cheeks, stroking yourself with his exposed bottom.  The tiger whimpers meekly under you.");
		else outputText("  Your fattest cock grinds between the tiger man's rear, dripping spunk over his back and clothing while your other cocks make a sloppy mess of his ass.");
		outputText("  The tiger man's muscled butt is soon glazed with your pre-cum.  Wet, slapping noises echo out into the alley as you grind your hips into his rear.  You can't help but think in the back of your head that the noise is stirring people inside the tent he came out of.");
	}
	//[[(If largest cock is smaller than 16)
	else {
		outputText("\n\nYou jam your cockhead into the tiger man's tight ring.  He groans in displeasure under you as your persistent force pushes past his resistance.");
		//[(If multicock)
		if(player.cockTotal() > 1) outputText("  One of your cocks slips into his hot, constricting confines, the remaining lengths pressed fast to the tiger man's rear and leaving glistening trails of eager fluids like markings on a bitch's ass.");
		else outputText("  Your [cocks] pushes in, your pre-cum-slicked length sliding in with a wet noise.");
		outputText("  The burly man under you whimpers in protest as you begin to rock against his fine ass.  His firm rear dimples and twitches under your hips, each slam");
		if(player.hasBalls()) outputText(" swatting your [balls] against him,");
		outputText(" making him shout out in discomfort.  Your [cocks] stretching him out");
		if(player.cockTotal() > 1) outputText(" while beating his rear");
		outputText(".  All his shouting stirs whoever resides in the tent he came out of.");
	}
	//(combine cock size paths)
	outputText("\n\nAs you continue to use the burly tiger man pinned beneath you, three figures exit from the tent.  Two of the figures are large and bulky and are joined by a third, slender man.  They watch as you abuse the tiger under you.  You glance over at them and can't help but notice smiles on their faces.");

	outputText("\n\n\"<i>Good for you, mate, making friends while getting us booze.</i>\"  One of them calls out.  The three of them laugh out loud at the joke, and as they laugh your senses are assaulted with the aroma of alcohol wafting from them.  From the way the trio sways you can tell they've been hitting the bottle hard.  They make no movement to stop you, though, so you ignore them.  The tiger under you stares in their direction, embarrassment burning crimson in his cheeks while you use and abuse him.  The scene is proving too much for you, though, and soon your [cocks] unloads your pent-up spunk over the tiger and coats him in thick, musky spooge in front of his 'friends'.");

	outputText("\n\n\"<i>He's even enjoying himself!</i>\"  One of the figures bellows out.  You tilt your head to peer between the tiger's spread legs and, sure enough, the barbed cock throbs between his legs with each beat of his heart.  Without further ceremony you roll the abused tiger man on his cum-soaked back and tuck your [cocks] back into your [armor].  The trio is too drunk to stop you as you leave.  Turning your head back to glance at the tiger, you see the three figures surrounding the victim and your lips curl into a pleased smile.  Within moments you return to the lights of the Bazaar.");
	//gtfo
	menu();
	addButton(0,"Next", enterTheBazaarAndMenu);
}

//((If waited, or failed assault  //Pass go collect 200 rape))
private function collectSomeButtSmex():void {
	clearOutput();
	outputText("Your body crashes into a wooden table and you choke, feeling the wind knocked out of you.  You struggle to lift your head and catch your breath, only to find yourself laying in... poker chips?");
	outputText("\n\n\"<i>The fuck ya doin'? This isn't booze!</i>\" A voice shouts.");
 	outputText("\n\n\"<i>Might be better though.</i>\"");
	outputText("\n\n\"<i>Shut yer traps!</i>\"");

	outputText("\n\nVoices surround you as you look around yourself.  A light hangs over you, the heat of the light bearing down on your body from overhead.  You shift and continue to disarray the poker table, moving chips and scattering playing cards across the table and onto the floor.  Your nose is assaulted with the stench of smoke and alcohol as you strain your sight on the figures around you.  A large bear, covered in brown fur from head to toe, barks out.  \"<i>What are you pulling?</i>\"");

	outputText("\n\nYou follow his gaze to see the feline figure walking into the light, revealing his features to be a cross of a man and a tiger.  His face looks humanoid but his body is covered in orange fur with dark stripes.  \"<i>Found it hanging around outside.</i>\" The tiger growls back.");

	outputText("\n\n\"<i>Nice, was getting tired of card games anyway.</i>\"  Behind you, a low tone sounds.  You spin your head to catch the sight of a burly, green male.  A tusked head sits atop muscular, bulky shoulders and torso.  You furrow your brows at all of these strange men.  Upon further inspection, you realize that they all must be regulars at the gym, since each shirtless torso is stacked with bulging and formidable muscles.  There isn't a single shirt in sight.");

	outputText("\n\n\"<i>I said shut yer traps!</i>\"  A commanding voice boomed out, making everyone (including you) fall silent and look in the speaker's direction.  A leanly built creature rises from his seat - another humanoid, with long, furred legs like a goat's.  Large curled horns protrude from his mass of curly brown hair. Beneath them, silver eyes look you over carefully and size you up.");

	outputText("\n\n\"<i>What are you doing?</i>\" the shirtless satyr asked with a demanding tone, his eyes fixed on the tiger man.");

	outputText("\n\n\"<i>He's my payment.  Worth more than a few drinks,</i>\" the tiger growls.  Your head is swamped with confusion as you wonder just what is going on.");

	outputText("\n\n\"<i>Not enough to cover all of it, too.  You'll have to do better than this.</i>\" the satyr says with a sigh.  \"<i>But... it's a start.</i>\"  You glance to the satyr just as he snaps his fingers and raises his hand in the air.  Before you can ask any questions or object, the orc's hands wrap around your wrists while the bear grips your ankles.  You struggle and try to flail your limbs, though the bear and orc are too strong.");

	outputText("\n\n\"<i>I suggest you try and relax, little chip.</i>\"  The satyr speaks while he uncorks a bottle of lust draft.  \"<i>And also to avoid dark pathways, but it's a little late for that.</i>\"  The satyr grins wickedly as his fingers clench around your nose.  Knowing what is coming, you hold your breath futilely.  Soon, you gasp and choke as the pink liquid is forced down your throat.  In moments your body begins to succumb to its effect.  Heat grows under your clothing and soon all four men are looking you over with hungry eyes.");

	outputText("\n\nYour [armor] is quickly disposed of, putting your body on display for the four men.  Every breath is a whimpering pant as the effects of the lust draft take over your body.  Your eyes strain to remain focused.  The warmth and tingling floods your senses and washes down your skin to your loins, causing them to ache.");
	if(player.hasCock()) {
		outputText("  [EachCock] grows stiff as everyone watches.  You wince to try and fight off the draft, but soon you're driping pearls of pre-cum.");
	}
	if(player.hasVagina()) outputText("  Your " + vaginaDescript(0)  + " grows slick in your excitement.");
	if(player.gender == 0) outputText("  Your skin heats and tingles, sweat wetting its surface.");
	outputText("  The satyr runs his hand along your body and sizes you up with a lewd gaze and gentle touch, making you shudder under his fingertips from the effects of the draft.  \"<i>Not bad I suppose.  You could have done better, though.</i>\"  The satyr turns his head to the tiger man as the satyr's words strike at your pride, though the rebuttal on your lips is quickly silenced as his fingers");
	if(player.hasCock()) outputText(" wrap around your [cocks].");
	else outputText(" rub over your " + assholeDescript()  + ".");
	outputText("  His hand teases your body as the pair of muscled men holds you down in place.  You can only gasp out and wiggle your hips at the touch.  You turn your head and look pleadingly at your captors.  The large green man holding your wrists looks like an oversized goblin with yellow eyes.  His olive skin is stretched tight over his bulging muscles.  His bulky frame looks as powerful as he is tall, standing perhaps seven feet tall.  The equally built man holding down your lower body looks much like a bear man with piercing green eyes, shorter and stockier than the green orc by far.  The pair of 'gym bunnies' have matching bulges swelling in their pants as their eyes fix over your nude body");
	if(player.hasCock()) outputText(" and hard shaft");
	if(player.cockTotal() > 1) outputText("s");
	outputText(".");

	//[(If muticock 3 or more)
	if(player.cockTotal() >= 3) outputText("\n\nNot to be left out, each of the two men take a hand off of your limbs and grip one of your [cocks].  Your head swings back onto the table you're laid out on, mouth open wide as you moan and arch your back.  Each hand goes at an individual rhythm as sex overwhelms your thoughts.  The hands pinning you down are gone, though you're unable to focus on escaping.");

	//(if cock(s)
	if(player.hasCock()) outputText("\n\nThe satyr pumps your length in his hand.  Your hips buck madly as the hand spreads your own pre-cum over your shaft with lewd schlicking noises.");
	else outputText("\n\nHis fingers slip past your puckered flesh and dip into your " + assholeDescript()  + " and spread apart, loosening you for what feels like ages.");
	outputText("  Without warning the hand is gone");
	if(player.cockTotal() > 1) outputText(" and your [cocks] wetly slaps your stomach with need");
	outputText(".  A whimper escapes your lips.  \"<i>This should be fine...</i>\"  The cool, collected voice of the satyr murmurs.");

	outputText("\n\n\"<i>I'm going to use the hole.</i>\"  The gruff voice behind you grunts out.  You turn to see the burly orc fumbling with his pants.  The size of his bulge sends a chill down your spine of ");
	if(player.lib < 50) outputText("fear");
	else outputText("excitement");
	outputText(".");

	outputText("\n\n\"<i>No.</i>\"  The satyr slaps his hand against the Orc's pectoral, making the pec jiggle faintly.  \"<i>If you go first you'll ruin it for the rest of us.  I'll go first.</i>\"  The group of captors hesitates for a moment, then all nod in agreement.");
	if(player.isBiped()) outputText("  The bear shifts where he stands, grabbing your ankles and spreading your limbs almost painfully wide.  You wince from the sting of the strain on your leg muscles.");
	outputText("  You hear the clopping of hooves on the floor as the satyr moves over to your " + buttDescript()  + ".  His hands grip over your " + hipDescript()  + " and drags you closer to the edge of the table so that your " + buttDescript()  + " hangs over the side of the table.  You raise your head to watch with a ");
	if(player.lib < 50) outputText("horrified");
	else outputText("excited");
	outputText(" expression as the satyr's hand strokes over his hard length.  It looks at least eight inches long, smooth like a human's cock and protruding from a forest of curly, brown fur.  The satyr lines himself up and rubs his stiff cockhead over your " + assholeDescript()  + ".");

	outputText("\n\nThe effects of the draft still fresh in your system, you moan out as your sensitive " + assholeDescript()  + " is poked and prodded.  The slick, hot satyr spunk clings to your pucker and eases your entrance open with his bulbous cockhead.  The satyr calmly takes his time until your hole is dripping and ready for him.  The seemingly endless torture has erstwhile driven you mad, seeming like the satyr has waited hours before finally deciding to plunge into you.  Once satisfied, the satyr shoves his hips forward and stuffs his cock into you roughly.  You wince at the sting and bite your lower lip, trying to keep from giving them the satisfaction of hearing your whimpers.  You shut your eyes and utter out a groan regardless, the feeling of the member pulsing against your silken walls making you utter a low moan");
	if(player.hasCock()) outputText(" while [eachCock] twitches and leaks generously over your " + player.skinFurScales());
	outputText(".");

	outputText("\n\nYou gasp as something hot and wet presses to your face.  You open your eyes to be greeted with a stiff cock pressed against your cheek, the tiger man from before looming over you and rubbing his barbed, drooling shaft over your face.  \"<i>Should be obvious.</i>\" The tiger rumbles.  \"<i>But no biting, lest you want to be beaten and left outside this tent to lick your wounds.</i>\"  The tiger man growls as he insistently rubs his cock over your face.");

	outputText("\n\n\"<i>Get your dick off'a him. This is your payment to us.</i>\"  The bear bellows in a low tone.  You turn your head to see a thick bear cock dueling for the use of your face.  The orc remains out of sight behind you, though you hear noises of the brute moving around.  The bear and tiger continue to bicker as their cocks press to each side of your face forcefully, the rods sliding against each other and your lips to drool thick pre-cum over your skin.  They wet your lips with a taste of what is to come.");

	outputText("\n\nAll of this transpires as your " + buttDescript()  + " is slapped over and over by the low-hanging satyr balls.  The satyr lets out a pleased groan every now and then as your body shivers and trembles from his length hilting in you over and over and over.  He doesn't look like he'll stop anytime soon, though.  You turn your head to see the tiger's barbed, nine inch cock.  The stubby barbs make your skin tingle with each graze across your cheek.  On the other hand, the bear's cock looks shorter, about seven inches though by far the thickest meat in the bunch.  The massive girth would most likely hurt your jaw if you tried to wrap your mouth around it. What do you do?");
	//open menu of options [Suck tiger] [Suck bear] [Suck none]
	menu();
	addButton(0,"Suck Tiger",suckOffATiger);
	addButton(1,"Suck Bear",suckOffABear);
	addButton(2,"Suck None",suckOffNone);
}

//<option 1 Suck tiger>
private function suckOffATiger():void {
	clearOutput();
	outputText("You go with the barbed length.  You quickly take it into your mouth and suckle on the barbed tip.  The tiger's face melts from argument to pleasure.  \"<i>Looks like he likes mine better than your short sausage.</i>\"  The tiger gloats, the bear growling low and angrily.  Not to invite a fight over your face, you grip the bear's cock with one hand and begin to stroke over the thickness, though your fingers are unable to wrap all the way around it.  The pair give out pleased moans of resignation as you pleasure them.  The satyr still pounds away at your " + buttDescript()  + " as you suck off the tiger, his hands gripping your head as he throatfucks your eager mouth.  You slither your tongue under his shaft and let out a muffled moan as the barbs tingle over your throat, lips, and tongue.  With a rough thrust he buries your face into his furred groin, making his heavy sack slap your cheek.  The tiger man fucks your face furiously as you feel the satyr finishing in your ass.  Thick tiger cock continues to pound down your throat as warmth spreads within your gut, satyr cum flooding your inner walls.");
	//bumpy road
	finalGayFinallee(0);
}

//<option 2 Suck bear>
private function suckOffABear():void {
	clearOutput();
	outputText("You turn your head and open wide, slowly squeezing the hefty bear cock past your lips.  Your jaw stretches to its limit around it and you suckle with wet, slurping noises.  You lavish all the attention you can on the fat rod in your mouth, using your tongue to lick and slurp the constant drool of pre-cum.  You flick your nimble tongue over the swollen cockhead and hear a low, pleased grunt from the bear.  Overhead, the tiger stares jealously.");

	outputText("\n\n\"<i>Bitches know the better cock when they see it.</i>\"  The bear lords over the tiger, making the angry feline snarl. Thinking quickly, you reach up a hand and begin to stroke along the barbed member while pushing the massive bear girth further past your lips, suppressing gags while the fat cockhead blunts against the back of your throat.  A hand grips the back of your head as the bear's hips begin to rock in and out of your wet mouth.  Soon, your lips are wet with the combination of saliva and copious bearspunk.  The hand on your head pushes you against the bear's groin, nestling your face in his furred, musky crotch while burying every inch of his fat cock down your mouth and plugging your throat.  Your eyes begin to water from the strain on your jaw and throat as the fat bear cock pulses, filling your mouth and pouring pre-cum straight down your gullet.  The bear begins to fuck your face, giving you a chance to gasp for breath every now and then.  This goes on for some time before you feel the satyr's cock pulse in your ass, spooge quickly filling you up.  Thick bear-cock pounds down your throat and distracts you from the satyr, though you can't help but feel the warmth of cum spreading deep within your gut and flooding your inner walls.");

	//crazy steel jaw
	finalGayFinallee(1);
}

//<Option 3 Suck none>
private function suckOffNone():void {
	clearOutput();
	outputText("Unwilling to wrap your lips around either of their lengths, you reach up with your hands and start to stroke the pair of arguing men off.  Each ceases their bickering to look down at you in confusion.  Their dazed expressions don't last long, quickly melting into pleasured, half-lidded gazes and moans.  Their drooling cockheads glaze your cheeks white with their pre-cum, making you reek of their strong, salty musk.  They seem eager for more and press their hard dicks over your face, prodding your closed lips with hot, pre-slicked cockheads.  You shut your eyes, one hand from each of them pressing the back of your head more into their needy cocks.  Your lips part just enough to taste their copious pre-cum, moans escaping your parted lips quietly as the satyr begins ramming his hips against you hard while his pent-up balls unload in your ass and paint your lower body with cum.");
	//no furry plx
	finalGayFinallee(2);
}

//all options lead to here for now
private function finalGayFinallee(road:int = 0):void {
	outputText("\n\nWith a wet pop, the satyr pulls his spent manhood from your " + assholeDescript()  + ".  He smears his softening cock over your " + buttDescript()  + " and leaves a white streak of cum across your cheeks.  He huffs a content breath and moves over to the side.  \"<i>I'm good, you guys decide who gets to fuck the slut next.</i>\"  You look up at the tiger and bear men.  Their eyes light up a moment before turning to look at your " + buttDescript()  + " with hungry lust.  Your spine shivers under their gaze, but before they can move a green blur runs past them.");
	outputText("\n\n\"<i>Zug want hole!</i>\" The large green orc runs to your behind, slapping his massive foot-long against your " + buttDescript()  + " as if to call 'dibs!'.  You bite your lips at the sight of the throbbing twelve inches sawing your ass cheeks apart, the dark olive flesh glistening with a thick layer of prespunk and slick, cool lubricant.  The orc's bulky muscles twitch menacingly as he stares the tiger and bear down.  The two of them stay where they are and, after a few moments, the orc grunts.  He looks down and lines himself up with your hole.  His thick, orcish girth presses against your " + assholeDescript()  + ", pushing in forcefully as the satyr's cum and rough pounding opened you just wide enough for the orc to slide in with little pain.");
	outputText("\n\nYou give a muffled groan as the giant orc cock impales you, the stiff erection grinding over your stretched-out, silken walls.  His fat orc sack swats your upturned " + buttDescript()  + ".  It coaxes whimpers from your lips as the green cock pulls out and slams back in, the brute of an orc focusing on getting further into you as his massive phallus plunges deeper and deeper with each thrust.  The colossal girth rides on the satyr's cum trails and pushes past it, stuffing you full to bursting with his orc meat.  His hands grip your hips and he roughly yanks you into a good angle as he begins to abuse your " + buttDescript()  + " with long, pummeling lunges.  He lets out guttural groans as his hefty cock drools orc cream, mixing it with the satyr's spooge as your hole begins to resemble a used condom.");
	player.buttChange(30,true,true,false);
	outputText("\n\nYou can barely focus on pleasuring the two cocks in your hands as your lower body receives a slut's treatment.  \"<i>Ragh! Hole so tight around orc cock!  Make good orc bitch!</i>\"  The large green man groans and you feel his heavy sack clench against your cheeks.  Your eyes go wide as you're suddenly flooded with orc spunk, the sensation and sound of the cum overflowing from your hole to splatter against the Orc's balls and thighs overwhelming your senses.  The Orc lets out a \"<i>Wrahhg!</i>\" as he pins your hips, hilting his orc cock as he continues to unload his thick, fertile seed into you.  Your belly soon distends and bulges from the amount of cum shooting up your ass.  The orc man pants over you as you feel your " + assholeDescript()  + " dripping orc spunk like a leaking dam.");
	//now it's time for the choice before to matter, we got three endings here, one for each choice.
	//((Ending 1 , suck tiger, //bumpy road))
	if(road == 0) {
		outputText("\n\nYou are hardly able to focus on the barbed cock in your mouth, moaning around the hard cock as you look at the small bump on your belly.  With your hands servicing the bear as the tiger fills your mouth, the two men haven't left either side of your head.  With a wet pop, the tiger man pulls his saliva-coated prick from your mouth and he moves to the orc, shoving him aside with a grunt.  \"<i>My turn now.</i>\"  He grins impishly as he lines himself up with your hole, your " + assholeDescript()  + " looking like a well-used cum dump.  He rams in with ease and begins to pound away inside of you, making you moan with your mouth open wide.");
		outputText("\n\nThe bear takes advantage of this, shoving his impossibly thick cock between your open lips.  Your lips vibrate around his shaft as you moan.  The bear climbs onto the table and begins to fuck your face while your " + assholeDescript()  + " is used for the third time in a row.  Your jaw stretches painfully around the girth of the bear's pride, your hands gripping at his legs as you look up at him with pleading eyes.  He only grins down at you as he watches his fat length slipping past your lips and bulging inside your throat.  Your throat constricts with gags and vibrates with moans as you involuntarily milk the bear's cock.  Each time the feline cock drills into you, the barbs leave you whimpering and gagging around the bearcock throatfucking you.  The barbs in your ass seem to bring a new sensation to the abuse as wet slapping noises echo in the tent.  Your " + buttDescript()  + " is wet with the combined cum of three males in a row, their cum and pre-cum dripping from your upturned " + buttDescript()  + " to form a growing puddle of lust on the floor and table.");
		outputText("\n\nThe bear and tiger don't last long.  The bear finishes first as he pins your head between his hips and the table.  Your fingers clench over his furred legs as a deep groan rumbles from his belly.  You can feel his load shooting directly down your throat to fill your stomach.  The bear pulls out as the last lurch of his cock spits a rope of cum over your face, causing you to shut your eyes and wince as the hot liquid oozes down your cheeks.  With an amused grunt, the bear gets off the table to leave you with the tiger man.  With a raspy hiss the tiger is last, his flared barbs quivering over your cum soaked walls as he grows closer to adding his own spunk to your collection. He leans down over your laying form and gives you a wink.  ");
		if(player.hasCock()) outputText("His hand dips down to play with your [cocks], stroking you off as he gives a few more brutal pounds of his hips.  ");
		else if(player.hasVagina()) outputText("Fingers ram into your " + vaginaDescript(0)  + ", thrusting into you as he fucks your other hole.  ");
		outputText("His face near yours, he licks your cheek and plants a brief kiss on your lips. You give him a confused look at the affection and he meets it with a wide grin.  \"<i>You're cute for a cocksucker.  Knew I had it made when I found you.</i>\" he snickers, causing you to blush.");
		if(player.gender > 0) outputText("  Your lips part as you moan, feeling your climax building before coating the tiger's hand and your lower body in your sex.  The tiger man just brings his hand up to his lips to taste your juices before hilting into you one last time.");
		outputText("  A third wave  of warmth floods you, the pressure growing even higher as you resemble an overstuffed, breeding bitch.  Exhaustion catches up with you and you begin to feel your eyes grow heavy.  The last thing you see is the feline's face contorted in pleasurable orgasm before you nod off.");

		outputText("\n\nYou wake up with a start, the sound of morning birds echoing in the abandoned tent is all that greets you.  You try to get up quickly but immediately regret it.  Your body is sore from all the abuse you took last night.  You slide off the table and look around for your gear.  Shockingly enough, you find it folded up in a neat bundle");
		if(player.gems > 1) {
			outputText(" with only a few gems missing");
			player.gems -= 3 + rand(4);
			if(player.gems < 0) player.gems = 0;
		}
		outputText(".  You redress yourself before realizing something.  You have acquired something extra: a lust draft potion with an orange ribbon tied to it.  A note at the end reads: \"<i>Thanks for bailing me out of buying booze.  Your ass was amazing even after that orc had it.</i>\"  There's no name on the note but you have a good idea who left it for you, judging by the drawn tiger paw print in the corner.  You pocket the lust draft and leave the tent to head back to the bazaar in the morning light.\n\n");
		player.sexReward("cum");
		player.orgasm();
		dynStats("sen", 5);
		model.time.days++;
		model.time.hours = 6;
		//Lust sated
		//Gained 1 lust draft, lost a few gems(9 or so?)
		inventory.takeItem(consumables.L_DRAFT, camp.returnToCampUseOneHour);
		//Time set to morning
		statScreenRefresh();
	}
	//((Ending 2 , suck bear, //crazy steel jaw))
	else if(road == 1) {
		outputText("\n\nYou are hardly able to focus on the girthy bear-cock in your mouth, moaning around the fat cock as you look at the small bump on your belly.  With your hands servicing the tiger as the bear fills your mouth, the two men haven't left either side of your head.  With a wet pop the bear pulls his saliva-coated prick from your mouth and he moves to the orc, shoving him aside with a grunt.  \"<i>My turn now.</i>\"  He grins impishly as he lines himself up with your hole, your " + assholeDescript()  + " looking like a well-used cum dump.  He rams in with ease and begins to pound away inside of you, making you moan with your mouth open wide.");
		outputText("\n\nThe tiger takes advantage of this, shoving his barbed cock between your open lips.  Your lips vibrate around his shaft as you moan.  The tiger climbs onto the table and begins to fuck your face while your " + assholeDescript()  + " is used for the third time in a row.  The barbs scrape and tickle at your mouth and throat while your hands grip at the tiger's legs.  You look up at him with pleading eyes though he only grins down at you as he watches his barbed length slipping past your lips and bulging inside your throat.  Your throat constricts with gags and vibrates with moans as you involuntarily milk the tiger's cock.  Each time the bear cock drills into you, the thickness leave you whimpering and gagging around the tigercock throatfucking you.  Your throat vibrates around the tigercock with muffled moans as the thick bearcock makes your pucker ache from the strain.");
		player.buttChange(45,true,true,false);
		outputText("\n\nHis hefty girth spreads you further than the orc, painfully spreading you apart while simultaneously driving you wild with the fuck.  Your " + buttDescript()  + " is wet with the combined cum of three males in a row, their cum and pre-cum dripping from your upturned " + buttDescript()  + " to form a growing puddle of lust on the floor and table.  The bear and tiger don't last long.  The tiger finishes first as he pins your head between his hips and the table.  Your fingers clench over his furred legs as a deep purr rumbles from his chest.  You can feel his load shooting directly down your throat to fill your stomach.  The tiger pulls out as the last lurch of his cock spits a rope of cum over your face, causing you to shut your eyes and wince as the hot liquid oozes down your cheeks.  With an amused grunt, the tiger gets off the table to leave you with the bear's cock in your ass.");

		outputText("\n\nWith a raspy growl the bear is last, his thick dick spasming as he grinds his fat cock over your cum soaked walls while he grows closer and closer to adding his own spunk to your collection.  He leans down over your laying form and gives you a wink.  ");
		//[(If cock(s))
		if(player.hasCock()) outputText("His hand dips down to play with your [cocks], stroking you off as he gives a few more brutal pounds of his hips.");
		else if(player.hasVagina()) outputText("Fingers ram into your " + vaginaDescript(0)  + ", thrusting into you as he fucks your other hole.");
		outputText("  His face near yours, he licks your cheek and plants a brief kiss on your lips.  You give him a confused look at the affection and he meets it with a wide grin.  \"<i>You're cute for a cocksucker.  Loved the way you went right for my dick.</i>\"  He snickers, causing you to blush.");
		if(player.gender > 0) outputText("  Your lips part as you moan, feeling your climax building before coating the bear's hand and your lower body in your sex.  The bear just brings his hand up to his lips to taste your honey before hilting into you one last time.");
		outputText("  A third wave of warmth floods you, the pressure growing even higher as you resemble an overstuffed, breeding bitch.  Exhaustion catches up with you and you begin to feel your eyes grow heavy.  The last thing you see is the bear's face contorted in pleasurable orgasm before you nod off.");

		outputText("\n\nYou wake up with a start, the sound of morning birds echoing in the abandoned tent is all that greets you.  You try to get up quickly but immediately regret it.  Your body is sore from all the abuse you took last night.  You slide off the table and look around for your gear.  Shockingly enough, you find it folded up in a neat bundle");
		if(player.gems > 1) {
			outputText(" with only a few gems missing");
			player.gems -= 3 + rand(4);
			if(player.gems < 0) player.gems = 0;
		}
		outputText(".  You redress yourself before realizing something.  You have acquired something extra: A lust draft potion with a brown ribbon tied to it.  A note at the end reads: \"<i>I'll always remember the face you made trying to wrap your cute lips around my giant dick.</i>\"  There's no name on the note but you have a good idea who left it for you, judging by the drawn bear paw print in the corner.  You pocket the lust draft and leave the tent to head back to the bazaar in the morning light.\n\n");
		player.orgasm();
		dynStats("sen", 5);
		model.time.days++;
		model.time.hours = 6;
		//Lust sated
		//Gained 1 lust draft, lost a few gems(9 or so?)
		inventory.takeItem(consumables.L_DRAFT, camp.returnToCampUseOneHour);
		//Time set to morning
		statScreenRefresh();
	}
	//((Ending 3 , suck none, //No furry plx))
	else {
		outputText("\n\nYou pant labored breaths as your skin tingles from the orc's flood of thick spunk.  Shakily, your hands continue to stroke off the bear and tiger's cocks and they continue to press to your cheeks and glaze your skin with pre-cum.  You feel the bear make a move towards the orc, but the green muscleman snarls and leans forward possessively.  \"<i>This Zug's hole!  Zug not done!</i>\"  The orc growls out as he protects his territory.  The bear backs away carefully and returns his dick to your face, pressing his cock back against your lips in determination to at least get some action.  The orc's fat cock stiffens as it revs back up for round two (Or in your case, round 3).  He pounds into your spunk-filled confines and you cry out in pleasure.  The two cocks in front of your face immediately thrust past your open lips, their cockheads rubbing together and filling your mouth with gushes of pre-cum.  Your tongue flicks over them to push them from your mouth but it only encourages them.");
		outputText("\n\nYour hands frantically work over their shafts, squeezing and tugging at their hard erections while your nimble fingers dance over the stiff flesh.  Your efforts bear fruit as the two men groan out, one cumming and the other soon after, shooting into your mouth with twin streams of cum.  They shoot into your mouth and sloppily coat your lips and chin, pulling out to let a few ropes coat your face.  Your eyes shut as the two continue to give you a sperm facial.  Each new, hot rope of cum clings over your cheeks and warms your skin.  The tiger and bear move away as you reach up to clean the mess from your eyes and, as soon as you open them you're greeted with the sight of the large orc looming over you.  He grins oddly at you as his head leans down to lick the cum from your face, instead covering you in his saliva.  \"<i>Zug like you.  Zug know you love big orc cock.</i>\" His speech is simple and grunted, though the words make you feel a hot blush rise in your cheeks.");

		outputText("\n\nHe shouts out a war cry and starts brutally fucking you senseless.");
		if(player.hasCock()) outputText("  His hand drips down to clumsily play with your [cocks], stroking you off as he gives you a few more brutal pounds of his hips.");
		else if(player.hasVagina()) outputText("  Fingers dip into your " + vaginaDescript(0)  + ", ramming into you as he fucks your other hole.");
		if(player.gender > 0) outputText("  Your lips part as you feel your climax building, and soon you coat the orc's hand and your lower body in your lust.  The orc just brings his hand up to taste your juices before hilting into you one last time.");
		outputText("  A third wave of warmth floods you and the pressure grows even higher as you resemble an overstuffed breeding bitch.  Exhaustion catches up with you and your eyes begin to grow heavy.  The last thing you see is the orc's face twisted in orgasmic pleasure before you pass out.");

		outputText("\n\nYou wake up with a start.  The sound of morning birds echoing in the abandoned tent is all that greets you.  You try to get up quickly but immediately regret it. Your entire body is sore from all the abuse you took last night.  Sliding off the table carefully, you look around for your gear.  ");
		if(player.gems > 1) {
			outputText("The only thing missing is a few gems.  ");
			player.gems -= 3 + rand(4);
			if(player.gems < 0) player.gems = 0;
		}
		outputText("You re-dress yourself quickly before realizing that you have something extra:  A bimbo potion with a green ribbon tied to it.  A note at the end of the ribbon reads: \"<i>Zug think you make good orc bitch. Drink this and Zug fuck all your holes!</i>\"  The writing is a childish scrawl, and you can barely make out the rest of the words.  By the stains on the paper, it's obvious the orc got too excited to properly finish his note, broken English or otherwise.  You pocket the bimbo potion and leave the tent to head back to the bazaar in the morning light.\n\n");
		//Lust sated
		//Gained 1 Bimbo brew, lost a few gems(9 or so?)
		//Time set to morning
		player.orgasm();
		dynStats("sen", 5);
		model.time.days++;
		model.time.hours = 6;
		//Lust sated
		//Gained 1 lust draft, lost a few gems(9 or so?)
		inventory.takeItem(consumables.BIMBOLQ, camp.returnToCampUseOneHour);
		statScreenRefresh();
		//Time set to morning
	}
}
}
}
