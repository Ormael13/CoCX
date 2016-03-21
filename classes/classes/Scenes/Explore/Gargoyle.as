package classes.Scenes.Explore{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class Gargoyle extends BaseContent{

	public function Gargoyle()
	{
	}

//const GAR_NAME:int = 825;
//const GAR_CONFIDENCE:int = 826;
//const RITUAL_INTRO:int = 827;
//const KINKY_RITUALS_SPOKEN:int = 828;
//const GAR_HISTORY:int = 829;
//const GAR_CATHEDRAL:int = 830;
//const GAR_NAME_TALKS:int = 831;

private function gargoyleConfidence(arg:Number = 0):Number {
	if (arg != 0) {
		flags[kFLAGS.GAR_CONFIDENCE] += arg;
		if (flags[kFLAGS.GAR_CONFIDENCE] > 100) flags[kFLAGS.GAR_CONFIDENCE] = 100;
		else if (flags[kFLAGS.GAR_CONFIDENCE] < 0) flags[kFLAGS.GAR_CONFIDENCE] = 0;
	}
	return flags[kFLAGS.GAR_CONFIDENCE];
}

//[b]Introduction, 1st Time:[/b]
public function gargoylesTheShowNowOnWBNetwork():void {
	clearOutput();
	//(When using the “Explore” option; perhaps a 15-25% chance of discovery per go)
	outputText("You set off in search of new horizons, setting off from camp in a completely new direction than you've ever tried before.  Away from the parts of Mareth you have thus far discovered, much of the world seems to be a barren wasteland");
	//if Desert is discovered:
	if (player.exploredDesert > 0) outputText(", making even the desert seem healthy and full of life");
	outputText(".  Your trip soon begins to seem unproductive, having found no new areas of Mareth or any contact with its inhabitants.  You sigh and turn back towards camp.");
	
	outputText("\n\nHowever, soon you catch the faintest glimpse of <b>something</b> in the distance!  Squinting, you shield your eyes from the sun and try to discern the strange glint on the horizon, but it's simply too far away.  Well, whatever it is, it certainly merits a check – it could be anything, perhaps a city, ");
	//if Tel'Adre has been discovered:
	if (player.statusEffectv1(StatusEffects.TelAdre) >= 1) outputText("or the ruins of one of Tel'Adre's more distant neighbors, ");
	outputText("or (even) some demon enclave that needs destroying.  With a quick check of your [weapon], you begin the long trek towards the shimmer in the distance.");
	
	//[Next]
	menu();
	addButton(0,"Next",gargoyleMeeting2);
	model.time.hours++;
}

//(Advance time by 1 hour) 
private function gargoyleMeeting2():void {
	clearOutput();
	outputText("You finally close the distance between yourself and the strange structure, which begins to take shape ahead.  Though it's half-buried under what must be years of built-up sand and debris, you can clearly make out high stone walls supported by vaulted arches, broken every so often by the shattered remains of stained-glass windows and a pair of utterly destroyed oaken doors nearly hidden behind a row of tall marble pillars, many of which have long since crumbled.  High above the ground, you can see a pair of tall, slender towers reaching up to the heavens, one of which has been nearly obliterated by some unimaginably powerful impact, leaving it a stump compared to its twin.  From the rooftops, strange shapes look down upon you – stone statues made in the image of demons, dragons, and other monsters.");
	
	//[b]You have discovered The Cathedral[/b] (If Fen wants to make this a Place; otherwise it can be encountered in the future via the Explore –> Explore function. Whichever works better. )
	
	outputText("\n\nYou arrive at the grounds around the ruins, cordoned off by a waist-high wrought-iron fence that surrounds the building and what once might have been a beautiful, pastoral garden, now rotting and wilted, its trees chopped down or burned, twig-like bushes a mere gale's difference from being tumbleweeds.  A few dozen tombstones outline the path to a gaping maw that was once the great wooden doors.  Seeing no obvious signs of danger, you make your way inside, stepping cautiously over the rubble and rotting debris that litters the courtyard.");
	
	outputText("\n\nIt's quite dark inside, illuminated only by thin shafts of light streaming in from the shattered windows and sundered doors.  You can make out a few dozen wooden pews, all either thrown aside and rotting or long-since crushed, leading up to a stone altar and an effigy of a great green tree, now covered in graffiti and filth.  Stairs beside the altar lead up to the towers, and down to what must be catacombs or dungeons deep underground.");
	
	outputText("\n\nHowever, what most catches your eye upon entering the sanctuary are the statues that line the walls.  Beautifully carved gray stone idols of creatures, chimeras, and nearer to the altar, god-like beings, are each set into their own little alcove.  Unfortunately most have been destroyed along with the cathedral, each lying in a pile of its own shattered debris; some having whole limbs or other extremities broken off and carried away by looters, leaving them mere shadows of their former glory.");
	
	outputText("\n\nAll of them but one.  In the farthest, darkest alcove you see a single statue that still seems intact. It is of a woman – well, more like a succubus than a human woman.  Though posed in a low, predatory crouch, she would normally stand nearly six feet tall, hair sculpted to fall playfully about her shoulders.  A pair of bat-like wings protruding from her back curl back to expose the lush, smooth orbs of her breasts, easily DD's on a human.  A spiked, mace-like tail curls about her legs that are attached to the pedestal upon which she's placed.  As you stand marveling at the statue's beauty, you cannot help but notice the slit of her pussy nearly hidden beneath her.  Oddly, it seems to have been carved hollow so that you could easily stick a few fingers inside if you so choose.");
	if (player.lib >= 40) outputText("  Maybe you could take this with you as a life-sized sex toy?");
	
	outputText("\n\nHowever, your attention is soon drawn from her body to the pedestal upon which she stands.  A pair of solid gold chains extend from the pedestal to her wrists, binding the statue.  You notice a plaque has been bolted to the pedestal, a feature not present on any of the other statues here.  Leaning down, you blow a sizable amount of dust from the plaque, revealing the following short inscription:");
	
	outputText("\n\n\"<i>Break my bonds to make me tame.</i>\"");
	
	outputText("\n\nYou suppose you could break the chains on the statue.  But who knows what will happen if you do?");
	
	flags[kFLAGS.FOUND_CATHEDRAL] = 1;
	outputText("\n\n<b>You have discovered the cathedral. You can return here in the future by selecting it from the 'Places' menu in your camp.</b>\n");
	//(Display [Break Chains] and [Don't Break] options)
	menu();
	addButton(1,"Don't Break",dontBreakThatShit);
	addButton(0,"Break Chains",breakZeChains);
}

//[b]Don't Break[/b]
private function dontBreakThatShit():void {
	clearOutput();
	outputText("Oh, no.  Nope.  Nuh-uh.  Not going to happen.  You're not falling for that trick!  No, siree.  As soon as you chop those chains, it'll probably just come to life and try to kill - or rape - you.  Feeling rather smart, you turn on a heel and exit the cathedral – there's nothing else to see right now.");

	outputText("\n\nIf you change your mind, you can always come back.  The statue's been here for decades, it can wait a while longer.");
	//(Return player to Camp, advance time an hour)
	doNext(camp.returnToCampUseOneHour);
}

//[b]Break Chains[/b]
private function breakZeChains():void {
	clearOutput();
	//Introduces two new values: " + flags[kFLAGS.GAR_NAME] + ", the gargoyle's name, given by the Champion, and Confidence, a value that has a base score of 0 (submissive/slave) rising to 100 (equal). Negatives are possible.
	outputText("You swing your [weapon] up over your head and strike the chains.");
	//if using your hands:
	if (player.weaponName == "fists") outputText("  \"<i>OW! Dammit, that hurt!</i>\"  What the hell were you thinking!?  Still, looks like you got results...");
	outputText("  An ear-splitting <i>SCHING!</i> echoes through the cathedral as shards of gold go flying.  You recoil, shielding your face from the surprisingly explosive force of the chains' shattering.  When the dust settles you cautiously lower your arms, giving you a good view of what lies – or rather, kneels – before you:");
	
	outputText("\n\nThe gargoyle has stepped down from her pedestal, and now kneels as a supplicant before a king, forehead near the ground and weight rested upon her stone knuckles even as her massive wingspan unfolds behind her and her mace-like tail swishes rapidly behind her.  Slowly, the gargoyle raises her head to gaze upon you, her now ruby-red eyes staring into yours. Her smooth, nippleless breasts heave, once-stone hair falling forward in strands, fringing her smooth, angular face.  Her thin, gray lips slowly curl into a small, sultry smile as she says, just on the edge of hearing...");
	
	outputText("\n\n\"<i>Master. My... Master.</i>\"");
	
	outputText("\n\nYou glance over your shoulder, but there's no one else here.  She must be referring to you!");
	
	outputText("\n\n\"<i>What would you have of this one, Master?</i>\" she asks, looking up at you expectantly.");
	
	outputText("\n\nStill cautious, you ask her what she is exactly.  Clearly she's no ordinary statue!");
	
	outputText("\n\n\"<i>I am your humble servant, Master.  Your tool.  Your plaything.  Your toy.  Ask, and I shall obey.</i>\"  She seems to pause for a moment, and adds in an emotionless whisper, \"<i>this one would be honored to pleasure Master, if " + player.mf("he","she") + " desires.</i>\"");
	
	outputText("\n\nThat raised more questions than it answered.  Taking things slow for now, you ask her name.\n\n\"<i>I... I am... I simply am.  What would Master call me?</i>\"");
	
	//[Display a textbox, into which the player can type in a name. This new value will be called " + flags[kFLAGS.GAR_NAME] + ", henceforth. ] (Confidence +10)
	mainView.nameBox.text = "";
	menu();
	addButton(0,"Next",nameZeGargoyle);
}

private function nameZeGargoyle():void {
	if (mainView.nameBox.text == "" || mainView.nameBox.text == "0") {
		// Name flag is used to track access into Gargoyles content. Default is "0" so somewhere the "0" string is coalescing to integer 0.
		// Solution? Fuck you for naming your Gargoyle "0".
		clearOutput();
		outputText("<b>You must name her.</b>", false);
		mainView.nameBox.text = "";
		mainView.nameBox.visible = true;
		mainView.nameBox.width = 165;
		menu();
		mainView.nameBox.x = mainView.mainText.x + 5;
		
		mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		
		addButton(0,"Next",nameZeGargoyle);
		return;
	}
	flags[kFLAGS.GAR_NAME] = mainView.nameBox.text;
	mainView.nameBox.text = "";
	mainView.nameBox.visible = false;
	clearOutput();
	outputText("\"<i>" + flags[kFLAGS.GAR_NAME] + ",</i>\" she purrs, \"<i>" + flags[kFLAGS.GAR_NAME] + ", " + flags[kFLAGS.GAR_NAME] + ".  Master has interesting taste.</i>\"");
	
	outputText("\n\nShe continues to kneel before you expectantly.  You suppose you could give her an order – perhaps something humorous, or perhaps something carnal – or maybe just talk to her, though as yet she seems a bit... odd.");
	
	gargoyleStarterMenu();	
}

private function gargoyleStarterMenu():void {
	//(Display options [Funny Order], [Carnal Order]. and [Talk])
	menu();
	addButton(0,"Funny Order",giveGargoyleAFunnyOrder);
	addButton(1,"Carnal Order",carnalOrder);
	addButton(2,"Talk",firstGargoyleTalk);
}

//[b]Funny Order[/b]
private function giveGargoyleAFunnyOrder():void {
	clearOutput();
	outputText("If she's so intent on playing the servant, you suppose you can play along.  Summoning up your most commanding voice, you snap, \"<i>ROLL OVER!</i>\"");
	outputText("\n\nTo her credit, " + flags[kFLAGS.GAR_NAME] + " hesitates only for a moment before dropping to the floor and rolling belly-up, limbs upraised like a puppy in training.  Stifling a chuckle, you lean down and do just that, giving her a quick belly rub.  Her skin is cool to the touch, and impeccably smooth, as you might expect from a marble statue.  Seemingly pleased, " + flags[kFLAGS.GAR_NAME] + " scrambles back to a low crouch before you, awaiting your next command.");
	gargoyleStarterMenu();
}

//[b]Carnal Order[/b]
private function carnalOrder():void {
	clearOutput();
	outputText("Well, well. " + flags[kFLAGS.GAR_NAME] + " seems willing to follow any order you give, no matter how carnal, and you could not help but notice her rather <i>arousing</i> attributes earlier.  Smirking wickedly, you command your new gargoyle to finger herself.");
	
	outputText("\n\n\"<i>Master reminds me of the last master,</i>\" she says quietly, almost coldly, but does not hesitate to flop onto her taut butt and spread her legs wide for you.  Easily, she slips three fingers into her slit, which stretches slightly to accommodate the insertion.  Watching you intently, she begins to rapidly piston her fingers in and out, masturbating to a rhythm near that to your ");
	if (player.cor < 40) outputText("flustered");
	else outputText("excited");
	outputText(" heartbeat.  The way she watches you, unblinking, as she fingers herself is rather unnerving, and you soon command her to stop.  She does so immediately, though with what you think might have been a sigh, and assumes a low crouch to await your next command.");
	gargoyleStarterMenu();
}

//[b]Talk (First Time)[/b]
private function firstGargoyleTalk():void {
	clearOutput();
	outputText("You decide against giving " + flags[kFLAGS.GAR_NAME] + " an order for now.  Instead, you right a nearby toppled pew and seat yourself across from the crouching gargoyle, returning her intense stare with one of your own.");
	outputText("\n\n\"<i>Why were you chained up?</i>\" you finally ask, glancing at the shattered bonds on the ground.");
	outputText("\n\n\"<i>Master found a new toy and soon grew tired of me.  Still, she did not want me stolen.</i>\"");
	outputText("\n\n\"<i>Your last master?</i>\"");
	outputText("\n\n\"<i>That is correct.</i>\"");
	outputText("\n\n\"<i>Who was. . . she?</i>\"");
	outputText("\n\n\"<i>She was. . . Master.</i>\"");
	//(Silly mode)
	if (silly()) outputText("\n\n\"<i>You know 'master' is masculine, right?</i>\"\n\n\"<i>Indeed.  Master was male, too.</i>\"\n\n\"<i>But you just. . . Nevermind.</i>\"");
	outputText("\n\n\"<i>Fine,</i>\" you sigh.  Apparently she doesn't want to tell you, and you don't feel like pressing the issue just yet.  \"<i>In that case, what happened here?</i>\"");
	
	outputText("\n\nSuddenly, " + flags[kFLAGS.GAR_NAME] + " breaks the stare and looks away, as if in shame.  \"<i>The demons' doom that even now blights Mareth took its toll here, too.  The people of a town no longer here believed they were safe under Marae's roof.  Protected.  Their faith was. . . Misplaced.</i>\"");
	
	outputText("\n\nIt seems the events that led to the cathedral's destruction weigh heavily on " + flags[kFLAGS.GAR_NAME] + "'s heart.  What do you do?");
	//(Display options: [Berate] and [Reassure])
	menu();
	addButton(0,"Berate",berateTheGargoyle);
	addButton(1,"Reassure",reassureTheGargoyle);
}

//[b]Berate[/b]
private function berateTheGargoyle():void {
	clearOutput();
	//(Confidence - 10)
	gargoyleConfidence(-10);
	outputText("A pillar of rage boils up inside you.  You are [name], Champion of Ingnam, you tell her, rising to your feet, fists clenched.  Your duty is the same as hers was, to protect your home.  And she failed.  She let all those people down.  You tell her that she's worthless, disgusting, a failure.");
	outputText("\n\n" + flags[kFLAGS.GAR_NAME] + " recoils, flinching from you in expectation of assault. Instead, you spit on the ground and start for the exit.  You shout over your shoulder for her to stay here and wallow in her failure until you deign to use her.");
	outputText("\n\nYou storm out of the cathedral with a knot of disdain in your gut.  From behind you, you're not quite sure, but perhaps you heard \"<i>I couldn't leave here if I wanted to.</i>\"");
	//(Player is returned to camp; advance time 1 hour)
	doNext(camp.returnToCampUseOneHour);
}

//[b]Reassure[/b]
private function reassureTheGargoyle():void {
	clearOutput();
	//(Confidence +10)
	outputText("You can't help but feel sorry for the poor gargoyle.  It isn't hard to figure out what happened, and in truth, she reminds you a bit of yourself – and of the consequences if you ever fail.  You reach over and put a hand on her smooth, cold shoulder.  As reassuringly as you can, you tell her that you are [name], the Champion of Ingnam.  Your duty isn't entirely dissimilar to what hers was, while you hope you'll never know what she's gone through, you can certainly sympathize.");
	
	outputText("\n\n" + flags[kFLAGS.GAR_NAME] + " looks up at you, her ruby-red eyes shining in the dim hit of light in the cathedral.  You cup her cheek and give her a smile.  \"<i>Come on, now,</i>\" you reply, offering her a hand up.  \"<i>Let's get out of here.</i>\"");
	
	outputText("\n\n\"<i>Master. . . I cannot.</i>\" she says, again looking away from you.  \"<i>Please, do not ask that of me.  I. . . I am still bound to this place.  Please, Master.  I shall never ask anything of you again.  Please.</i>\"");
	
	outputText("\n\nSlowly, you nod, and ask her if she'll be all right here all by herself.  She gives you a little smile and says, \"<i>Of course, Master.  Especially if... if you return.  You will return, Master?  Won't you?</i>\"  She looks deeply into your eyes and huskily purrs, \"<i>I can make it... pleasurable... if you do...</i>\"");

	outputText("\n\nYou rustle " + flags[kFLAGS.GAR_NAME] + "'s hair and assure her you will before you take your leave and return to camp.");
	//(Return to camp, advance time 1 hour)
	doNext(camp.returnToCampUseOneHour);
}

//[i](Whenever the player returns to the Cathedral, play one of the following introductions, then the “Cathedral Interior” scenes. )[/i]
//[b]Player Returns to the Cathedral A[/b]
public function returnToCathedral(woken:Boolean = false):void {
	flags[kFLAGS.FOUND_CATHEDRAL] = 1;
	if (!woken) {
		clearOutput();
		if (rand(3) == 0) outputText("You make your way back to the ruined Cathedral in the wastelands.  You notice some of the debris has been cleared away from the courtyard, and some of the windows have been boarded up.  " + flags[kFLAGS.GAR_NAME] + "'s obviously been working since you last left, trying to make the building more habitable.  With your path less obstructed than before, you enter.");
		//[b]Player Returns to the Cathedral B[/b]
		else if (rand(2) == 0) outputText("You spot the Cathedral in the distance, and see plumes of smoke rising. Alarmed, you ready your [weaponName] and rush over.  To your relief, however, you discover the burning objects are just a few dead imps that were looking for easy pillage, but found the Cathedral's newly-awoken protector instead.  Stepping around their charred corpses, you enter.");
		//[b]Player Returns to the Cathedral C[/b]
		else outputText("You wander into the Cathedral grounds, and are rather alarmed to see a pair of little green goblin sluts poking around outside, trying to cart off some of the stone tombstones for their nefarious schemes.  They see you approaching, however, and quickly flee – more interested in salvage than fighting or fucking today.  Chuckling to yourself, you enter.");
	}
	menu();
	//[b]Cathedral Interior – 06:00 –> 09:00 & 18:00 –> 21:00[/b]
	if (model.time.hours <= 9 || model.time.hours >= 18 || woken) {
		if (!woken) {
			outputText("\n\nIn the dim ");
			if (model.time.hours <= 9) outputText("early morning");
			else outputText("late evening");
			outputText(" light streaming in from the broken windows, you see " + flags[kFLAGS.GAR_NAME] + " poking around some of the rubble, slowly but surely making efforts to repair the damage done to the Cathedral.  Seeing you, however, she immediately drops what she was doing and ");
			if (gargoyleConfidence() < 70) outputText("kneels before you, head bowed low.");
			else if (gargoyleConfidence() < 99) outputText("bows low before you, a small smile on her stone lips.");
			else outputText("with a sexy sway of her hips, approaches you and lays a small but tender kiss upon your cheek before bowing her head to you.");
			
			outputText("\n\n\"<i>Master has returned,</i>\" " + flags[kFLAGS.GAR_NAME] + " says ");
			if (gargoyleConfidence() > 50) outputText("happily.");
			else outputText("solemnly.");
			outputText("  \"<i>What would you have of me?</i>\"");
		}
		//(Display options: [Sex] [Rituals] [Talk] [Appearance] and [Leave]. If Confidence is 70+, also display the option for [Kinky Rituals])
		if (player.lust >= 33) addButton(0,"Sex",gargoyleSexMenu);
		addButton(1,"Rituals",ritualGargoyle);
		if (flags[kFLAGS.GAR_HISTORY] < 3 || flags[kFLAGS.GAR_CATHEDRAL] < 3 || flags[kFLAGS.GAR_NAME_TALKS] < 3) addButton(2,"Talk",talkToGargoyle);
		addButton(3,"Appearance",gargoyleAppearance);
		if (gargoyleConfidence() >= 70 && flags[kFLAGS.RITUAL_INTRO] > 0) addButton(4,"Kinky Rituals",gargoyleKinkyRituals);
	}
	//[b]Cathedral Interior: 10:00 –> 17:00[/b]
	else {
		if (!woken) {
			outputText("\n\nWithin the ruins, you can see " + flags[kFLAGS.GAR_NAME] + " perched atop her pedestal in a low, predatory crouch, much as you found her.  Waving a hand in front of her eyes, you confirm she's in some sort of dormant mode.  A simple touch from her Master could revive her");
			if (player.lust >= 33) outputText(", or you could use her to satisfy your own urges, not unlike a life-size sex toy");
			outputText("."); 
		}
		//(Display options: [Wake Her] [Use Her (if Lust >= 30)] [Appearance] and [Leave])
		addButton(0,"Wake Her",returnToCathedral,true);
		if (player.lust >= 33) {
			if (player.hasCock()) addButton(1,"Use Her",useGargoyleMaleHerm);
			else if (player.hasVagina()) addButton(1,"Use Her",useHerGargoyleFemale);
		}
		addButton(3,"Appearance",gargoyleAppearance);
	}
	addButton(14,"Leave",camp.returnToCampUseOneHour);
}

//[b]Sex[/b]
private function gargoyleSexMenu():void {
	clearOutput();
	outputText("You approach " + flags[kFLAGS.GAR_NAME] + " and tell her you have some... pressure that needs relieving.");
	//(if Confidence =< 69:
	if (gargoyleConfidence() <= 69) outputText("  The gargoyle bows low before you, her face expressionless.  \"<i>By your command, Master.  How would you have me?</i>\"");
	else outputText("  Her ruby-red eyes lock with yours and a sultry grin plays across her gray marble features.  She slides an arm around your waist and presses her sizable, surprisingly soft breasts against your chest.  \"<i>How would Master have me?</i>\"");
	menu();
	//(If Male, display options: [Vaginal] [Anal] [Titfuck] [Strap-on] [Leave])
	if (player.gender == 1) {
		addButton(1,"Anal",gargoyleAnal);
		addButton(0,"Vaginal",gargoyleCoochiiGetsPlowed);
		addButton(2,"Titfuck",titFuckTheGargoyle);
		addButton(3,"Strap-On",strapOnGargoyle);
		addButton(4,"Leave",returnToCathedral);
	}	
	//(If Female, display options: [Tail Fuck] and [Ride Strap-on] [Leave])
	if (player.gender == 2) {
		addButton(0,"Tail Fuck",tailFuckGargoyleScene);
		addButton(1,"Strap-On",strapOnGargoyle);
		addButton(4,"Leave",returnToCathedral);
	}
	//(If Herm, display all above options)
	if (player.gender == 3) {
		addButton(1,"Anal",gargoyleAnal);
		addButton(0,"Vaginal",gargoyleCoochiiGetsPlowed);
		addButton(2,"Titfuck",titFuckTheGargoyle);
		addButton(3,"Strap-On",strapOnGargoyle);
		addButton(4,"Tail Fuck",tailFuckGargoyleScene);
		addButton(14,"Leave",returnToCathedral);
	}
	//(If Genderless, display [Strap-on] [Leave])
	if (player.gender == 0) {
		addButton(3,"Strap-On",strapOnGargoyle);
		addButton(14,"Leave",returnToCathedral);
	}
}

//[b]Anal[/b]
private function gargoyleAnal():void {
	clearOutput();
	outputText("You tell her to get on all fours as you shed your [armor], unleashing your already-hardening cock.  Nervously, the gargoyle does as you command, quickly finding a clear bit of floor and getting on her hands and knees.  You kneel down behind her, peeling her taut ass-cheeks apart to reveal her tight slit and the marble ring of her tiny asshole.  Grinning, you slather up your forefinger with your tongue, lubing it up as best you can before pressing it to her backdoor.");
	
	outputText("\n\n" + flags[kFLAGS.GAR_NAME] + " makes a sharp little gasp as you push your finger into her.  You slide into her with surprising ease, reveling in how <i>cold</i> her interior is.  She's like ice inside!  You start thrusting your finger faster, trying to get her warmed up a little as your prepare her anus.  " + flags[kFLAGS.GAR_NAME] + " squirms and moans softly as you finger-fuck her bum, slowly changing from moans of discomfort to little gasps of pleasure.");
	
	outputText("\n\nDeciding you've gotten her more than ready, you grasp your [cock biggest] and push the head against her still-tight ass.  Her mouth forms a sharp “O” of pleasure as you grab her hips and push into her.  Though you've lubed her up plenty, her passage is still incredibly tight, and so cool inside it takes a force of will to keep your cock from wilting.  But all it takes is one look at her face over her shoulder, eyes rolled back in pleasure, to keep you thrusting in at full mast.");
	
	//(if PC's first cock is 50 inches or bigger; Silly Mode only:)
	if (player.cocks[player.biggestCockIndex()].cockLength >= 50) {
		outputText("\n\nKnowing full well the living statue doesn't have much in the way of anatomy, you continue to push more and more of monstrous manhood into " + flags[kFLAGS.GAR_NAME] + "'s asshole, watching with glee as her stomach begins to distend with the massive size of your prick.  Then her chest bulges, making her gasp in pain and clutch at her breast; that doesn't stop you, though.  With one mighty, massive thrust, you slam yourself up to the hilt in " + flags[kFLAGS.GAR_NAME] + "'s ass, and watch with glee as the head bursts out of her mouth, squirting pre and drool all over the floor.  The poor gargoyle makes a muffled scream and starts flailing around helplessly, trying to do <i>something</i> about the massive member now protruding from her mouth.");
		
		outputText("\n\nWith gusto, you start hammering away at your living cock-sleeve, using her entire body as one great big ona-hole to take your gargantuan girth.  Resigned to her fate, " + flags[kFLAGS.GAR_NAME] + " slumps forward and grasps the head of your [cock biggest], giving you a handy through her mouth as her innards milk the rest of your shaft.");
		
		outputText("\n\nThe sensation of fucking straight through the gargoyle proves to be too much, however, and you give yourself up to orgasm with one last, mighty thrust.  You cry out as your cum jets through her body and out her mouth, blasting across the floor just in front of her and leaving huge globs splattered across her face and chest.");
		outputText("\n\nNow sated, you put your hands on her butt and push her off your giant cock, causing her to go face-first into the sprawling pool of your cum on the floor.  With a chuckle, you pat the insensate gargoyle on the head and head back to camp.");
	}
	//(if PC doesn't qualify for the above:)
	else {
		outputText("\n\nYou spend a few minutes making short, slow thrusts into the gargoyle's ass, slowly working your way further and further inside her until you bottom out");
		//if Balls:
		if (player.balls > 0) outputText(", your balls slapping against her butt");
		outputText(".  \"<i>M-Master,</i>\" she pants, chest heaving after the experience.  You give her a playful push, leaving her face on the cold stone floor as you withdraw your cock to the tip from her cold stone insides.  She clenches up tight as you slam yourself back in, nearly making you cum on the spot.  Now you're the one moaning, and so decide to reward her with a sharp slap on the ass.  She makes a little squeak when you strike her, but she tightens up wonderfully, her anal passage trying to milk you as you withdraw.  You give her another swat as you push back in, and are treated to the same results.  Grinning, you pick up your pace, alternating between pounding her tight asshole and slapping her taut butt cheeks.");
		
		outputText("\n\nSoon, she's moaning again, this time all in pleasure, utterly enthralled in the assault you're laying onto her behind.  Her spiked tail and wings spasm and twitch wildly around you, a sure sign of her having given over to the pleasure of your rough buttfucking.  She's only able to keep up for a few minutes, however, before you feel her ass contracting hard upon your shaft, her muscles clamping down as her body prepares for a massive anal orgasm.  Pleased that your ministrations are close to bringing her to orgasm, you let yourself go, and quickly feel the tell-tale rush of seed up your shaft.  You hold out for just a moment more, until " + flags[kFLAGS.GAR_NAME] + " cries out with pleasure, letting loose a scream that echoes to the rafters.  You cum, too, shooting your jism up her ass in thick spurts that only serve to provide you further lubrication, letting you pound her hard until you've shot off every last bit of cum.");
		
		outputText("\n\nUtterly sated, you gently push " + flags[kFLAGS.GAR_NAME] + " off your cock.  She collapses on the floor, insensate, and soon is surrounded by a pool of your spooge leaking from her ass.  With a grin, you pat her on the head and collect your [armor] before heading back to camp.");
	}
	player.orgasm();
	dynStats("sen", -1);
	doNext(camp.returnToCampUseOneHour);
}

//[b]Vaginal[/b]
//no limits
private function gargoyleCoochiiGetsPlowed():void {
	clearOutput();
	var x:int = player.cockThatFits(60);
	if (x < 0) x = player.smallestCockIndex();
	
	outputText("You gently push " + flags[kFLAGS.GAR_NAME] + " onto her back and spread her long, marble legs, giving you a clear view of her tight little pussy.  You brush your hand along her thighs, making her gasp with the sensation as your knuckles run along her smooth, cool flesh.  Your fingers come to her small clit, and you caress her tiny pleasure buzzer, eliciting a tiny moan from the gargoyle.  Grinning, you give it another flick; " + flags[kFLAGS.GAR_NAME] + " squirms, trying to either enhance or end the sensation, you can't be sure.  You start to finger her clitty harder, creating little circles around it as you slip another finger into her tight passage.");
	
	outputText("\n\nYou're rewarded for your efforts by " + flags[kFLAGS.GAR_NAME] + " bucking her hips into your hands, moaning, \"<i>M-Master... please...</i>\"  Not done teasing her yet, you put your other hand on her flat belly and start to crawl it up, tickling her as you make your way toward her sizable breasts.  You glomp onto one of them, giving it a rough squeeze as you drive your finger into her a little further than before.  \"<i>Masterrrrr...</i>\" " + flags[kFLAGS.GAR_NAME] + " whines, reaching up to stroke your cheek.  Deciding you've teased the poor girl enough, you prepare for the main course.");
	
	outputText("\n\nYou pull your " + player.cockDescript(x) + " from your [armor], letting it flop down atop her crotch.  Embarrassed, " + flags[kFLAGS.GAR_NAME] + " looks away as you rub the underside of your cock across her mons, spitting on it for a bit of extra lubricant.  You lean back, lining the tip of your cockhead with the gargoyle's tight slit, and press forward.  She lets out a sharp gasp as your cock presses against her, pushing it past her lips and finally slipping into her depths.");
	
	outputText("\n\nThough her opening was painfully tight, her inner passage expands easily around your cock, letting you slip in more and more of your dickmeat until you're buried ");
	if (player.cockArea(x) > 60) outputText("as far as she can take you.");
	else outputText("up to the hilt inside her.");
	outputText("  Now that you're so deep in the gargoyle, you can see her visibly trembling, panting with pleasure.  Leaning down, you cup her cheek and plant a kiss on her thin lips.  She returns it eagerly, letting your probing tongue in to play with hers.  Mid-kiss, she wraps her arms and legs around you, holding you close against her heaving chest.");
	outputText("\n\nYou start to thrust against her, making short, fast strokes in and out of her cool passage.  Soon, you're both moaning with pleasure as you change the tempo, switching to long and hard pumps that make the Cathedral echo with the sound of your hips slapping into " + flags[kFLAGS.GAR_NAME] + "'s raised asscheeks.  She can only hold on to you tighter, biting her lower lip, eyes closed, as you start to well and truly pound her.");
	
	outputText("\n\nTo your dismay, you feel the tell-tale clenching in your gut, signaling your impending orgasm.  You clutch at " + flags[kFLAGS.GAR_NAME] + "'s shoulders as you slam into her one last time, as far as you'll go, and shoot out the first of your load.  The sensation of your thick, hot jizz exploding into her sets the gargoyle off as well: she rolls her head back and lets out a soft scream, crunching down on your cock until you're afraid it's going to burst.  You bury your face in her neck and let her milk your cock for all it's worth, until your spooge threatens to overflow and pool on the ground.");
	
	outputText("\n\nThe two of you lay there for a while after, until your " + player.cockDescript(x) + " has deflated and you've both stopped panting from exertion and pleasure.  Giving her another kiss, you pull out of her cold depths – now significantly warmer thanks to your passion – and stuff your dick back into your armor.");
	if (gargoyleConfidence() >= 70) outputText("  Before you can stand, though, " + flags[kFLAGS.GAR_NAME] + " hugs her arms tightly around you pulling you down on top of her and mashing your face between her soft tits.");
	
	outputText("\n\n\"<i>Thank you, Master,</i>\" she says, running a hand through your " + player.hairDescript() + ".  \"<i>That was wonderful.</i>\"");
	
	outputText("\n\nYou give her a pat on the head and head on back to camp.");
	player.orgasm();
	dynStats("sen", -1);
	doNext(camp.returnToCampUseOneHour);
}

//[b]Tit-Fuck[/b]
private function titFuckTheGargoyle():void {
	clearOutput();
	outputText("You situate yourself on a pew and spread your legs.  You pat your thighs, telling " + flags[kFLAGS.GAR_NAME] + " to sit between your legs as you fish out your [cock biggest].  She approaches, hesitantly placing herself on the floor between your legs as you recline and stroke your shaft to full hardness.  You let the gargoyle sit there, watching you wide-eyed as you continue to masturbate.  Though you're only preparing for the main act, you can't help but enjoy the sensation of such a basic sexual act, made all the more pleasurable by the creature at your feet, her face barely an inch from your cock's head as you stroke yourself.");
	
	outputText("\n\nOnce you're satisfied at your cock's rigid hardness, you tell " + flags[kFLAGS.GAR_NAME] + " to put those big, soft tits of hers to work.  \"<i>M-Master?</i>\" she gasps, making a cute little “o” with her mouth just an inch from your shaft.  You repeat the order, and giver her a thump on the nose with your cock for emphasis.  Shyly, she cups her D-cups and leans into you, squeezing your [cock biggest] between them.");
	
	outputText("\n\nWith a little encouragement, " + flags[kFLAGS.GAR_NAME] + " starts to rise and fall on her knees, dragging your shaft through her soft, cool mounds.  With a pleasured sigh, you reach down and stroke her hair, petting the girl as she begins to slowly but steadily titfuck you.  Still mumbling encouragements, you sit back and let the pleasure run over you, reveling in the incredible softness of her sizable chest massaging your cock, making steady progress toward stroking the cum out of you.");
	
	outputText("\n\nSuddenly, you feel an overwhelming wetness on your cock.  You look down, expecting to see pre flowing freely from you, but are instead greeted with the sight of " + flags[kFLAGS.GAR_NAME] + " sliding the tip of your cock into her mouth, starting to fellate you on top of the tittyfuck.  You give her a few more words of encouragement and press her head down further onto your shaft, forcing her to take all that's left over from her breasts.  Despite her marble nature, her mouth is moist and surprisingly warm, and her long tongue is quick to wrap around your [cock biggest], wringing it in time with her chest-thrusts.");
	
	outputText("\n\nSeeing no reason to hold back, you relax as much as possible and lose your mind in the pleasure of dual stimulation.  You soon find yourself gasping softly as she works her soft tits around your cock and teases your now-dilating urethra with her tongue.  You soon feel your guts churning and your dick stiffening even more – here it comes!");
	
	outputText("\n\nYou grab " + flags[kFLAGS.GAR_NAME] + " and push her down hard, slamming your cock down her throat as you cum.  A human would surely have choked with this maneuver – instead, " + flags[kFLAGS.GAR_NAME] + " squirms and flails, but you can see and feel her swallow your cum as it pours into her mouth, her throat massaging your flaring head, milking it harder than any tit-job ever could have.  Once her face has been ground into your pubes, you buck your hips sharply, thrusting into her throat as the last of your jizz spurts out and down her gizzard.");
	
	outputText("\n\nBy the time you're done, " + flags[kFLAGS.GAR_NAME] + "'s face is an utter mess, with white lines trickling down her cheeks.  You drag your [cock biggest] out of her with a wet POP, unleashing a dam of jizz that quickly leaks out of her agape mouth to stain her breasts and belly.  You chuckle at the sight");
	if (gargoyleConfidence() >= 70) outputText(", and to your surprise, so does " + flags[kFLAGS.GAR_NAME] + "");
	outputText(".");
	
	outputText("\n\n\"<i>Was that... pleasing, Master?</i>\" she asks innocently.");
	
	outputText("\n\nYou give her a little pat on the head and tell her it was more than pleasing.  Gratified, the little gargoyle sets to slurping up your cum as your clean yourself up and head back to camp.");
	player.orgasm();
	dynStats("sen", -1);
	doNext(camp.returnToCampUseOneHour);
}

//[b]Strap-On[/b]
//(Coding this one may be a *little* complex)
private function strapOnGargoyle():void {
	clearOutput();
	outputText("Giving a quick look around the ruins, you tell " + flags[kFLAGS.GAR_NAME] + " to go find something that can bring you two a little <i>closer</i>.");
	
	outputText("\n\n\"<i>Closer?</i>\" she asks, confused.  You roll your eyes and tell her to grab the holy rod sitting on the altar and put it through a leather strap.  She hesitates for a moment, but dutifully does as you ask, returning a moment later with the smooth, silver cylinder and a leather thong.  With a bit of work, you've created a simple strap-on out of the holy rod, and instruct " + flags[kFLAGS.GAR_NAME] + " to put it on.  Now she's getting it!  The gargoyle slips into the leather, giving a cute little shiver as one end of the rod slips inside her.  Before she has a chance to recompose herself, you grab her rod-cock in one hand and give her a gentle push with the other.");
	
	outputText("\n\nShe lays down with you atop her, straddling her waist as you stroke her rod, rewarded with sharp pleasure-gasps from the statue-girl.  You're hardly stimulating her pussy with these actions – she must be able to feel <i>through</i> the rod, as if it were a real cock.  Amused, you start to jerk the rod off, sliding it through your clenched fist with slow, measured strokes.  " + flags[kFLAGS.GAR_NAME] + " squirms under the pleasurable attention, and is soon groping her big breasts and bucking her hips into your fists, shoving more of her rod-cock into your hand with each of your jerks.");
	
	outputText("\n\n\"<i>Well, someone's enjoying herself,</i>\" you tease, and immediately " + flags[kFLAGS.GAR_NAME] + " freezes, her mouth agape with embarrassment.  With a little laugh, you give her a pat on the thigh and start to strip out of your [armor].  But you can't just leave " + flags[kFLAGS.GAR_NAME] + " without SOME stimulation: ");
	//(If Human Legs/Feet [ie, needs toes], as new paragraph): 
	if (!player.isTaur() && !player.isGoo() && !player.isDrider() && !player.isNaga()) outputText("you reveal your leg first, moving slowly and sensually, giving her a tantalizing look at your nethers before hiding them again.  With a wide grin, you creep your foot up to her thighs and gently run your heel along her smooth, tender flesh.  You come to the base of her rod, standing stark straight in the air like a flag-pole.  As you strip, you grasp her cock between your big and second toe, sliding them up the smooth shaft to the tip.  " + flags[kFLAGS.GAR_NAME] + " moans, rolling her head back as you start to foot-fuck her cock, slowly putting more and more pressure on the steel member until it's pressed against her belly.  Your heel takes over, running quickly along the underside of her cock as you finally rid yourself of your [armor].");
	//Else, continued from above paragraph:
	else outputText("you giver her a good show, putting on a brief striptease for the gargoyle.  You strip your [armor] slowly, sensually, showing only the barest hints of your privates until the last moment, when the last piece of your clothing falls to the floor.");
	//(From Both, if has Vagina:) 
	if (player.hasVagina()) {
		outputText("\n\n" + flags[kFLAGS.GAR_NAME] + " is panting with lust by the time you're done teasing and stripping for her. Now nude, you drop back to your knees over her holy rod-cock, straddling her hips and lining her up with your [vagina]. You lower yourself until the tip of the rod is pressing against your lower lips – you're pleasantly surprised by the warm tingling sensation that quickly spreads out around the point of contact, and your cunny responds immediately by letting loose a little trickle of moisture that beads down on the gargoyle's shaft.");
		
		outputText("\n\nWithout further ado, you drop down on the strap-on, lowering yourself onto the tingling metal rod until your groin is pressed against " + flags[kFLAGS.GAR_NAME] + "'s.  She, all the while, is biting her lower lip and whimpering with pleasure as your [vagina] swallows her length. Once you've taken all she has to offer, you begin grinding your hips against her, rocking back and forth atop the gargoyle.  To your surprise, " + flags[kFLAGS.GAR_NAME] + " grabs you, squeezing her long fingers into your [hips] and pulling you up, almost off her rod. You decide to go with it; you grab her tits for support and start to bounce on her cock.");
		player.cuntChange(15,true,true,false);
		outputText("\n\nSoon, you're both moaning with pleasure, bucking and thrusting your hips to meet each other as you continue to ride " + flags[kFLAGS.GAR_NAME] + "'s strap-on.  However, you can feel the clenching sensation of a coming orgasm building in your gut, and if the strained panting of your partner is any indication, she isn't far behind.  You start bouncing faster, increasing to a wild pace as your cunt contracts on the metal rod inside it, trying to milk the fake cock as waves of pleasure roll over you.  You don't let up throughout the orgasm, quite literally riding it out until " + flags[kFLAGS.GAR_NAME] + " lets out a high-pitched shriek and grabs your back, smashing your face into her tits and holding you tight as she, too cums.  Suddenly she's the one pounding you, thrusting her hips into your [vagina].");
		
		outputText("\n\nBy the time she's done, both your hips and thighs are spattered with your sweat and girlcum. Still panting from the ordeal, you slowly drag yourself off of " + flags[kFLAGS.GAR_NAME] + "'s cock and roll onto your back, exhausted. By the time you've recovered enough to stumble to your feet, " + flags[kFLAGS.GAR_NAME] + " is fast asleep beside you, snoring cutely, her metal cock still standing straight up in the air.  You give her a gentle pat on the thigh and get dressed, leaving the gargoyle snoozing peacefully as you head back to camp.");
	}
	//(ELSE, PC has no vagina:)
	else {
		outputText("\n\n" + flags[kFLAGS.GAR_NAME] + " is panting with lust by the time you're done teasing and stripping for her. Now nude, you drop back to your knees over her holy rod-cock, straddling her hips and lining her up with your [asshole].  You lower yourself until the tip of the rod is pressing against your clenched backdoor – and you're pleasantly surprised by the warm tingling sensation that quickly spreads out around the point of contact. Your anus responds immediately by utterly relaxing, letting just the tip of " + flags[kFLAGS.GAR_NAME] + "'s strap-on slide inside you.");
		
		outputText("\n\nWithout further ado, you drop down on the strap-on, lowering yourself onto the tingling metal rod until your ass is pressed against " + flags[kFLAGS.GAR_NAME] + "'s thighs.  She, all the while, is biting her lower lip and whimpering with pleasure as your ass swallows her length.  Once you've taken all she has to offer, you begin grinding your hips against her, rocking back and forth atop the gargoyle.  To your surprise, " + flags[kFLAGS.GAR_NAME] + " grabs you, squeezing her long fingers into your [hips] and pulling you up, almost off her rod.  You decide to go with it; you grab her tits for support and start to bounce on her cock.");
		player.buttChange(15,true,true,false);
		outputText("\n\nSoon, you're both moaning with pleasure, bucking and thrusting your hips to meet each other as you continue to ride " + flags[kFLAGS.GAR_NAME] + "'s strap-on.  However, you can feel the clenching sensation of a coming anal orgasm building in your gut, and if the strained panting of your partner is any indication, she isn't far behind.  You start bouncing faster, increasing to a wild pace as your hole contracts on the metal rod inside it, instinctively trying to force out the intruder, but only serving to let waves of pleasure roll over you.  You don't let up throughout the orgasm, quite literally riding it out until " + flags[kFLAGS.GAR_NAME] + " lets out a high-pitched shriek and grabs your back, smashing your face into her tits and holding you tight as she, too cums.  Suddenly she's the one pounding you, thrusting her hips into your [asshole] until you've both cum, hard, clutching each other as orgasmic pleasure slams through you.");
		
		outputText("\n\nStill panting from the ordeal, you slowly drag yourself off of " + flags[kFLAGS.GAR_NAME] + "'s cock and roll onto your back, exhausted. By the time you've recovered enough to stumble to your feet, " + flags[kFLAGS.GAR_NAME] + " is fast asleep beside you, snoring cutely, her metal cock still standing straight up in the air.  You give her a gentle pat on the thigh and get dressed, leaving the gargoyle snoozing peacefully as you head back to camp.");
	}
	player.orgasm();
	dynStats("sen", -1);
	doNext(camp.returnToCampUseOneHour);
}

//[b]Tail Fuck[/b]
//Requires Vag
private function tailFuckGargoyleScene():void {
	clearOutput();
	outputText("Without warning, you grab " + flags[kFLAGS.GAR_NAME] + "'s thick, spiked tail and give it a playful yank.  She lets out a surprised \"<i>EEP,</i>\" but settles down after you tell her to cop a squat and stiffen it up.  Obediently, she assumes a low crouch and stiffens her tail into a “U” shape between her legs, its tip pointed straight up between your belly and her face.  You ruffle her hair and strip out of your [armor], soon standing nude before the gargoyle.  At a command from you, the brutal stone spikes protruding from her tail's tip retract, leaving the appendage a smooth, cool surface.");
	
	outputText("\n\nWith a little balancing help from a nearby pew, you balance yourself over the narrow tip of her tail and slowly lower yourself down upon it.  The tip slips through your lower lips easily, its stone cold surface sending a chill up your spine as you slide down the gargoyle's shaft.");
	player.cuntChange(15, true, true, true); 
	outputText("You shudder as you finally bottom out on her tail, taking it until your cunt is almost painfully stretched by her ever - thickening tail and you can feel the tip pressing against the entrance to your womb.");
	
	
	outputText("\n\nNow firmly inside your depths, " + flags[kFLAGS.GAR_NAME] + " begins to wiggle her tail inside you, slithering a few inches in and out of your [vagina].  Encouraging her, you grasp her shoulders for support and push your cunt a little closer to her face.  Taking the hint, she snakes out her long tongue and gives your clitty a little flick, eliciting an immediate gasp of pleasure from you.  She's soon engaging in a double-assault on you, suckling on your [clit] one moment, and ramming her tail into your [vagina] the next.");
	
	outputText("\n\nJust as you feel your body begin to tense up in preparation for orgasm, the gargoyle slips her hands around your waist.  You're about to ask what she's doing when you feel a finger pressing up against your [asshole].  With her oral ministrations, it's hard to relax your sphincter to allow her entrance, but when she does finally get in, the feeling of her cold, smooth finger traveling up your rectal passage is incredible.");
	
	outputText("\n\nBefore you can get used to the anal intruder, your eyes have rolled back in your head with pleasure.  Girlcum spurts from your cunt, splattering " + flags[kFLAGS.GAR_NAME] + "'s face with your juices as you cum.  Your holes squeeze down on her appendages, trapping them inside you as your ride out the orgasm, bouncing on her rigid, rapidly-moistening tail until your body settles down.");
	
	outputText("\n\nWhen you've finished, you carefully extricate yourself from the gargoyle's tail and, a bit bow-legged, gather up your [armor].  By the time you're dressed, " + flags[kFLAGS.GAR_NAME] + "'s cleaned herself off and is eagerly awaiting some token of your approval.");
	
	outputText("\n\n\"<i>Was Master satisfied?</i>\" she asks");
	if (gargoyleConfidence() > 70) outputText(" with just a hint of a smile");
	outputText(".");
	
	outputText("\n\nYou rub her head and tell her that oh, yes you were. You leave her with a gratified smile on her thin lips.");
	player.orgasm();
	dynStats("sen", -1);
	doNext(camp.returnToCampUseOneHour);
}

//[b]Use Her – Male/Herm[/b]
private function useGargoyleMaleHerm():void {
	clearOutput();
	outputText("You approach the motionless statue with a lustful look in your eye. Quickly, you strip out of your [armor] and circle around the frozen girl.  With some effort, you're able to lift her heavy, spiked tail out of the way, revealing the tight cunt hidden between her legs.  You drop to your knees behind the gargoyle and bury your face in her crack, slurping at her vag, getting it nice and moist in preparation for your cock.");
	outputText("\n\nTo your surprise, the gargoyle does not even respond to your tongue as you slide it inside her.  She's completely motionless – even the walls of her love canal are still as you spread your saliva around inside her.  After a few minutes of preparation, you grab your [cock biggest] and slide on home.  Despite her natural tightness, it's relatively easy going thanks to the liberal lubrication you applied moments ago, and soon you're buried up to the hilt inside the gargoyle.  You give a few quick thrusts into her tight, smooth hole that quickly build up to a fast, hard fucking.");
	outputText("\n\nBut you aren't quite satisfied just pounding an insensate hole.  Knowing that you have the power to \"revive\" " + flags[kFLAGS.GAR_NAME] + " through touch, you decide to put this to rather devious use.  You reach around her body and grab one of her breasts, giving it a few hard squeezes until you hear the faintest gasp from the little gargoyle.  You release it immediately.  Your hand switches down to her taut ass and gives it a loud swat.  You repeat the action twice, and finally feel her cunt contract – just a bit – around your shaft.  You switch your attentions down to her thighs, gently running your hands along both expanses of gray skin beneath your thrusting [cock biggest].  You feel her shudder, ever so slightly, but just as she's on the verge of reviving, you pull back your hands.");
	
	outputText("\n\nYou return to thrusting into her, going fast and furious as your pleasure climbs steadily towards climax.  Only when you're bursting over the threshold of orgasm do you lay your hands on " + flags[kFLAGS.GAR_NAME] + " again, grabbing her ass and giving one last massive thrust into her, shoving your [cock biggest] in to the hilt.  You cum inside her just as she awakens, moaning lustily into her ear as spunk drizzles out around your member.");
	
	outputText("\n\n\"<i>M-Master?</i>\" " + flags[kFLAGS.GAR_NAME] + " gasps, giving a full-body shudder as you slowly pull out from inside her.  Your cum drools out of her snatch and pools beneath her.  Playfully, you jam your fingers up between her legs, damming your sperm inside her.  To your glee, this simple act sends " + flags[kFLAGS.GAR_NAME] + " right over the edge: convulsing, she collapses on the floor with a heavy THUNK!");
	
	outputText("\n\nYou give the gargoyle a little pat on the head for a job well done before heading on out.");
	player.orgasm();
	dynStats("sen", -1);
	doNext(camp.returnToCampUseOneHour);
}

//[b]Use Her (Female)[/b]
private function useHerGargoyleFemale():void {
	clearOutput();
	outputText("You casually strip out of your [armor] and start to tease your cunt as you circle around the crouching gargoyle.  You lament her lack of male genitalia, but that will by no means stop you from sating your lust on the gargoyle.  You grab her tail, itself only just flexible enough to reposition thanks to her rigor-mortis-like state, and bend its tip to face straight up.");
	
	outputText("\n\nWith a harsh squeeze, the heavy stone spikes on the tip of her tail retract, leaving her tail as unnaturally smooth as the rest of her.  You adjust her tail to just the right height for you, and slide down onto her.  It's easy going, thanks to her tail's sculpted smoothness, and soon you're bottomed out deep enough to feel the pointed tip trying to force its way into your womb.  You moan lewdly as you buck your hips on her appendage, starting to ride it like a big, fat cock.");
	
	outputText("\n\nCompletely insensate, " + flags[kFLAGS.GAR_NAME] + " remains in her low crouch ahead of you, not so much as breathing.  Still, she stretches you nice and wide as your bounce on her tail, spearing yourself over and over again on her smooth appendage.  By way of reward, you reach forward and slip a few fingers into her cool, tight cunny.  She can't respond as such, but you're confident she can still feel you sliding your fingers inside her, pushing in for each bounce you make atop her meaty tail.");
	
	outputText("\n\nYou're pleased to note that the gargoyle's tail is now dark and wet thanks to the liberal streams of lubricant pouring from your [vagina].  Now you're practically sliding on " + flags[kFLAGS.GAR_NAME] + "'s tail, riding toward inevitable orgasm.  You cum at the apex of a bounce, slamming yourself down hard upon " + flags[kFLAGS.GAR_NAME] + "'s tail until her tip breaches the entrance to your womb.  You scream in ecstasy, squirting your girl-cum freely onto the gargoyle's tail, back, and legs until you're completely and utterly spent.");
	
	outputText("\n\nContented, you spend a few minutes recovering before slowly dressing back up into your [armor]. You head on out, making sure to give " + flags[kFLAGS.GAR_NAME] + " a little pat on the head on your way out.");
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}

//[b]Ritual (First Time)[/b]
private function ritualGargoyle():void {
	clearOutput();
	if (flags[kFLAGS.RITUAL_INTRO] == 0) {
		flags[kFLAGS.RITUAL_INTRO] = 1;
		outputText("You note that the sanctuary's altar has been cleared of rubble, and a number of candles have been lit upon it. Resting atop the flat stone surface is a simple iron bowl filled with what appears to be water. Curious, you ask " + flags[kFLAGS.GAR_NAME] + " what she's been up to.");
		outputText("\n\n\"<i>Long before Master came, I watched over the parishioners and their faith. They performed strange sacraments and rituals to purify the body and dispel evils. ");
		if (gargoyleConfidence() < 50) outputText(" Forgive my impertinence, but");
		outputText(" I thought perhaps Master might someday have need of these rites, and prepared them for you.  I know a ritual to purify the body, another to purify the mind, and a third that banishes evil creatures and spirits, though I warn you: cleansing the body can best be done through pain, and banishment may be as... invasive... as the possession itself.  Does Master have need of these?</i>\"");
	}
	//[b]Ritual (Any after First)[/b]
	else {
		outputText("You walk to the church's alter, shortly followed by " + flags[kFLAGS.GAR_NAME] + ".  You ask her if she's still able to perform the church's Rituals, to which she replies \"<i>Of course, Master.  Do you have need of one?</i>\"");
		
	}
	//(Display Options: [Body] [Mind] [Banish (only with Exgartuan or Worms)] and [Leave])
	menu();
	addButton(0,"Body",bodyRitual);
	addButton(1,"Mind",mindGargoyleRitual);
	if (player.findStatusEffect(StatusEffects.Infested) >= 0 || player.findStatusEffect(StatusEffects.Exgartuan) >= 0) addButton(2,"Banish",banishmentGargoyleRitual);
	addButton(4,"Leave",returnToCathedral);
}

//[b]Body[/b]
//(PC decreases Libido and Sensitivity. Suffers 20% Max HP damage, to a minimum of 1 pt. remaining)
private function bodyRitual():void {
	clearOutput();
	outputText("You tell " + flags[kFLAGS.GAR_NAME] + " that you could stand to reverse some of the corruption that has affected your body.  With an solemn nod, she takes you to a side alcove near the altar and instructs you to spread your arms and legs.  Hesitantly, you do so, and from the floor and ceiling " + flags[kFLAGS.GAR_NAME] + " produces leather straps with rough looped straps.  Before you can react, she binds your arms and legs, spreading you eagle against the cold stone wall.");
	
	outputText("\n\n\"<i>With pain comes purity,</i>\" " + flags[kFLAGS.GAR_NAME] + " says, so quietly you can barely hear her.  \"<i>Prepare yourself, Master,</i>\" she adds, and your heart nearly skips a beat when you hear the crack of a whip behind you.  Oh, shit, this is going to hu-CRACK!  You see stars as white-hot pain arcs through your body, making you scream into the wall.  You can feel the burning streak left across your back by the bullwhip, throbbing mercilessly in the moments before CRACK!  She hits you again, throwing you forward against your bonds with the force of the blow.");
	
	outputText("\n\nOver your ragged, pained breathing, you can just hear " + flags[kFLAGS.GAR_NAME] + " chanting: \"<i>With pain comes purity... CRACK!  With agony comes enlightenment... CRACK!  Through torment comes holiness... CRACK!</i>\"  The last crack of the whip leaves you groaning, breathless, sagging in your bonds. Somehow, though, you do feel... cleaner?  Like a weight was just lifted from your heart.  And you know you're going to be thicker-skinned after that!  Quietly, reservedly, " + flags[kFLAGS.GAR_NAME] + " releases you from your bonds, and you stagger into her waiting arms.  She helps you over to the altar and lays you down, letting you rest after your ordeal.  She stands over you, watching you pant and gasp.  You suppose you could get some vengeance for her brutality – or you could be kind.  What do you do?");
	dynStats("lib", -.5, "sen", -2);
	player.takeDamage(Math.round(player.maxHP()/2));
	//(Display options: [Nothing] [Revenge] and [Cuddle])
	menu();
	addButton(0,"Nothing",noReactionToBodyRitual);
	addButton(1,"Cuddle",gargoyleCuddleAfterBodyRitual);
	addButton(2,"Revenge",gargoyleRevengeAfterBodyRitual);
}

//[b]Nothing[/b]
private function noReactionToBodyRitual():void {
	clearOutput();
	outputText("You simply lie still and try to recover from " + flags[kFLAGS.GAR_NAME] + "'s \"gentle ministrations.\"  After a few minutes, you've caught your breath and, gathering your possessions, make your way out of the Cathedral without another word.  Damn, you're sore.");
	doNext(camp.returnToCampUseOneHour);
	//(Return PC to camp, advance time 1 hour)
}

//[b]Revenge[/b]
//(Confidence -5)
private function gargoyleRevengeAfterBodyRitual():void {
	clearOutput();
	outputText("Seeing " + flags[kFLAGS.GAR_NAME] + " just standing over you, gloating, causes you to sneer and lash out.  You strike her dead-center in the chest, throwing her back against the tree-idol at the church's head.  She slumps to the floor, looking meekly away from you.  While she's stunned, you gather your [armor] and stagger out of the Cathedral.");
	//(Return PC to camp, advance time 1 hour)
	gargoyleConfidence(-5);
	doNext(camp.returnToCampUseOneHour);
}

//[b]Cuddle[/b]
//(Confidence +5)
private function gargoyleCuddleAfterBodyRitual():void {
	clearOutput();
	outputText("Despite the pain she's caused you, you know " + flags[kFLAGS.GAR_NAME] + " did it at your command – and hell, it could only have helped you.  Before she can react, you reach up and pull the gray gargoyle down into a kiss, pressing firmly against her soft, cold lips.  She makes a cute little gasp, but soon relaxes into your hold, allowing you to shift her weight so that she's nearly lying atop you.  You sigh contentedly and wrap your gargoyle in a tight hug, holding her close for the few minutes it takes you to recover.  When you're feeling up to it, you rustle her hair and thank her for her... gentle ministrations.  If she could blush, you're sure she would be as she looks upon you with gleaming fiery eyes.  You gather your belongings and exit the Cathedral.");
	//(Return PC to camp, advance time 1 hour)
	gargoyleConfidence(5);
	doNext(camp.returnToCampUseOneHour);
}

//[b]“Mind”[/b]
//(PC Decreases Corruption and Lust, increases Intelligence)
private function mindGargoyleRitual():void {
	clearOutput();
	outputText("You tell " + flags[kFLAGS.GAR_NAME] + " that you've been plagued with dirty thoughts, and would like to undo some of the corruption that's spread to your mind.  " + flags[kFLAGS.GAR_NAME] + " nods respectfully and tells you to kneel before the altar. You do so, assuming a low, supplicating stance before the tree-idol at the Cathedral's head as the gargoyle picks up the bowl of water and raises it on high.");
	outputText("\n\n\"<i>Blessed is " + player.mf("he","she") + " who seeks purity,</i>\" she says, closing her eyes and bowing her head, \"<i>Blessed is " + player.mf("he","she") + " who seeks wisdom; and blessed is " + player.mf("he","she") + " who lusts after holiness and virtue before pleasures of the flesh.</i>\"");
	outputText("  " + flags[kFLAGS.GAR_NAME] + " brings the invocation to a quiet close, and rests the bowl back upon the altar. \"<i>Drink of this, Master,</i>\" she says, offering you the bowl, \"<i>and be healed of mind.</i>\"");
	
	outputText("\n\nYou do so, taking a long draught of the holy water.  By the time you've set the bowl down, you feel light-headed, as if a fog has receded from your mind.  You gasp happily, able to think more clearly than you have in days.  You thank " + flags[kFLAGS.GAR_NAME] + ", give her a pat on the head, and head back to camp with a skip in your step.");
	dynStats("lus", -10, "cor", -.5);
	//player.takeDamage(Math.round(player.maxHP()/2));
	player.changeFatigue(50);
	doNext(camp.returnToCampUseOneHour);
}

//[b]Banishment[/b]
//(PC is cleared of Worms and/or Exgartuan)
private function banishmentGargoyleRitual():void {
	clearOutput();
	outputText("Talking about " + flags[kFLAGS.GAR_NAME] + "'s rituals, you explain that you seem to have picked up ");
	if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0) outputText("a hitchhiker");
	else outputText("some hitchhikerss");
	outputText(" in your travels, and would like to rid yourself of them.  She tells you to strip and brace yourself against the altar.  \"<i>Unfortunately, as you have been invaded, so too is this a very... invasive ritual.</i>\"  You nod your assent – you really want to get ");
	if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0) outputText("this bastard");
	else outputText("these bastards");
	outputText(" out of your system.");
	
	outputText("\n\nFrom beneath the altar, " + flags[kFLAGS.GAR_NAME] + " withdraws what looks like a perfectly cylindrical dildo, covered with dozens of dark, dimly-glowing blue runes.  Slowly, she makes her way around you and kneels behind your [butt].  \"<i>Take a deep breath, Master, and relax yourself.  It will be better this way.</i>\"");
	
	outputText("\n\nYou try your best to relax yourself, though as soon as you make any headway, you feel an intense, invasive pressure against your [asshole].  You take a deep breath, grit your teeth, and force yourself to relax.  The smooth holy rod slips in, forcing its way inexorably into your anus.  You feel a burning sensation begin to spread throughout your body, creeping outward from your asshole like little tendrils of fire.");
	
	outputText("\n\n\"<i>Do not worry, Master,</i>\" " + flags[kFLAGS.GAR_NAME] + " says");
	if (gargoyleConfidence() >= 50) outputText(" soothingly, using her free hand to stroke your thighs");
	outputText(".  \"<i>The pain is necessary.  Everything will be all right.</i>\"");
	
	outputText("\n\nStill, you can't help but hiss in agony as the holy burn spreads through you, seeping into your vulnerable gentials and sensitive chest.");
	//with Exgartuan:
	if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0) outputText("  Booming from within you, you hear the demon's voice: \"<i>Hey!  What the shit is this!?  What're you doing? Fucking stop, you ingrate!</i>\"");
	//with Worms: 
	else outputText("  Gratifyingly, however, you can feel the infestation within you squirming and writhing, desperately seeking escape.");
	
	outputText("\n\nSuddenly, the holy rod jammed up your [asshole] makes a loud hissing sound, and withdraws.  Panting, you collapse to the ground, gripping your gut.  It's over, and you feel... alone.  The ");
	if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0) outputText("creature within you has");
	else outputText("creatures within you have");
	outputText(" been absorbed and purged by the rod, which " + flags[kFLAGS.GAR_NAME] + " proceeds to chuck out a window.  Hopefully she has more, in case you ever get ");
	if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0) outputText("possessed");
	else outputText("infested");
	outputText(" again.");
	
	outputText("\n\nStill panting and gasping from your ordeal, you notice " + flags[kFLAGS.GAR_NAME] + " looming over you, smiling.  You could be a dick for all that pain she caused you, or thank her for helping you.");
	if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0) player.removeStatusEffect(StatusEffects.Exgartuan);
	else player.removeStatusEffect(StatusEffects.Infested);
	player.takeDamage(Math.round(player.maxHP()/3));
	player.changeFatigue(10);
	//(Display options: [Nothing] [Revenge] and [Cuddle])
	addButton(0,"Nothing",dontFreakOutAfterBanishment);
	addButton(1,"Cuddle",cuddleForBanishments);
	addButton(2,"Revenge",getRevengeForBanishments);
}

//[b]Nothing[/b]
private function dontFreakOutAfterBanishment():void {
	clearOutput();
	outputText("You simply lie still and try to recover from " + flags[kFLAGS.GAR_NAME] + "'s “gentle ministrations. ” After a few minutes, you've caught your breath and, gathering your possessions, make your way out of the Cathedral without another word. Damn, you're sore.");
	//(Return PC to camp, advance time 1 hour)
	doNext(camp.returnToCampUseOneHour);
}

//[b]Revenge[/b]
//(Confidence -5)
private function getRevengeForBanishments():void {
	clearOutput();
	outputText("Seeing " + flags[kFLAGS.GAR_NAME] + " just standing over you, gloating, causes you to sneer and lash out.  You strike her dead-center in the chest, throwing her back against the tree-idol at the church's head.  She slumps to the floor, looking meekly away from you.  While she's stunned, you gather your [armor] and stagger out of the Cathedral.");
	//(Return PC to camp, advance time 1 hour)
	gargoyleConfidence(-5);
	doNext(camp.returnToCampUseOneHour);
}

//[b]Cuddle[/b]
//(Confidence +5)
private function cuddleForBanishments():void {
	clearOutput();
	outputText("Despite the pain she's caused you, you know " + flags[kFLAGS.GAR_NAME] + " did it at your command – and hell, it could only have helped you.  Before she can react, you reach up and pull the gray gargoyle down into your lap, hugging her around the waist and putting a quick kiss into the nape of her neck.  Giggling, she wraps her tail around you, giving you a gentle squeeze as she nuzzles into your chest.  You stay like that for a few minutes, cuddling the cute gargoyle, but eventually you know you need to check on things back at camp.  When you're feeling up to it, you rustle her hair and thank her for her... gentle ministrations.  If she could blush, you're sure she would be as she looks upon you with gleaming fiery eyes.  You gather your belongings and exit the Cathedral.");
	//(Return PC to camp, advance time 1 hour)
	gargoyleConfidence(5);
	doNext(camp.returnToCampUseOneHour);
}
//[b]Kinky Rituals (First Time)[/b]
//(While Confidence 70+)
private function gargoyleKinkyRituals():void {
	clearOutput();
	if (flags[kFLAGS.KINKY_RITUALS_SPOKEN] == 0) {
		outputText("You broach the subject of rituals to your gargoyle and are met with a surprisingly coy smile from her.  You ask her what's on her mind, to which " + flags[kFLAGS.GAR_NAME] + " chuckles and says, \"<i>I've been thinking, Master. If you so desire, it may be possible to... enhance... the rituals that I've been using.</i>\"");
		outputText("\n\nYou ask her exactly what she has in mind.");
		outputText("\n\n\"<i>The last Master was obsessed with pleasures of the flesh, and when she learned I was able to perform spiritual rituals, designed corrupted versions of them to fit her tastes.  If you'll allow it, I believe I can strike a middle-ground – making the rituals more pleasurable to us both, without the corrupting influence.  Would Master be interested in attempting one with me?</i>\"");
		//(Display Options: [Body] [Mind] [Banish (only with Exgartuan or Worms)] and [Leave])
	}
	//[b]Kinky Rituals (Any after First)[/b]
	//(While Confidence 70+)
	else {
		outputText("You walk to the church's alter, shortly followed by " + flags[kFLAGS.GAR_NAME] + ".  You tell her you need one of her holy rituals, but that you'd prefer to have some fun as well.  Grinning, she says, \"<i>It would be my pleasure, my Master. What shall we do?</i>\"");
	}
	//(Display Options: [Body] [Mind] [Banish (only with Exgartuan or Worms)] and [Leave])
	menu();
	addButton(0,"Body",kinkyBodyRitual);
	addButton(1,"Mind",mindRitualPervy);
	if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0 || player.findStatusEffect(StatusEffects.Infested) >= 0) addButton(2,"Banish",banishPervRitual);
	addButton(4,"Leave",returnToCathedral);
}

//[b]Body[/b]
private function kinkyBodyRitual():void {
	clearOutput();
	//(Confidence +2)
	//(PC decreases Libido and Sensitivity. Suffers 20% Max HP damage, to a minimum of 1 pt. remaining)
	outputText("You tell " + flags[kFLAGS.GAR_NAME] + " that you could stand to reverse some of the corruption that has affected your body.  With an eager nod, she strips you down, takes you to a side alcove near the altar and instructs you to spread your arms and legs.  Putting your trust in your little gargoyle, you do so, allowing her to bind you spread-eagle with long leather straps.");
	
	outputText("\n\nYou watch over your shoulder as she retrieves a small riding crop from her altar and, giving it an experimental crack in her palm, saunters back over to you.  Still grinning, she presses herself up against your bare back");
	if (player.biggestTitSize() >= 1) outputText(", cupping your [chest] in her cold stone hands");
	outputText(".  Your [nipples] go rock hard from her cold touch, and you shudder as she gently nips your ear and drags the length of the crop along your thighs.");
	
	outputText("\n\n\"<i>You've been a very naughty " + player.mf("boy","girl") + ", to have a body so warped,</i>\" she says, again running the crop along your incredibly sensitive inner thighs, making you tremble with the sensation.  You're acutely aware of her large, soft breasts pressing into your sweat-slicked back.  Huskily, " + flags[kFLAGS.GAR_NAME] + " whispers, \"<i>Don't worry, Master. I'll take good care of you...</i>\"  CRACK!  She lays on with the crop, a short, stinging stoke across your thigh.  You gasp, as much in pleasure as in pain, still reveling in the sensation of her embrace.");
	
	outputText("\n\nAs if reading your thoughts, she releases you and steps back, giving herself room for another CRACK!  She leaves a mark on your back this time, and you gasp at the sting of her crop.  But not a second later, she's up against you, her long, cool tongue running across the red streak she's left upon you.  She leans back and makes a tsk sound, patting your [butt].  \"<i>With pain comes purity,</i>\" she whispers, rising to nestle her chin in your neck.  \"<i>With agony comes enlightenment.</i>\"  CRACK!  She gives you a swat right on the ass, making you gasp – before you can close your mouth, she locks you in a deep kiss, easily slipping her long, slender tongue into your mouth.");
	
	outputText("\n\nShe plays easily within you, running her cool appendage over your own tongue, letting it slide across your teeth and cheeks as she slides a hand down to your ");
	//if Male/Herm: 
	if (player.hasCock()) outputText(player.cockDescript(0));
	else if (player.hasVagina()) outputText(player.vaginaDescript());
	else outputText("barren crotch");
	outputText(".  She breaks the kiss and steps back, laying on one last time – CRACK! with the crop, stinging you again with an intense mix of pain and pleasure.  Gasping and panting from stimulation, you nearly collapse when " + flags[kFLAGS.GAR_NAME] + " unbinds you, though she's quick to catch you before you fall.");
	
	outputText("\n\nShe guides you over to the altar and helps you lie atop it to rest.  Once you're comfortably situated, " + flags[kFLAGS.GAR_NAME] + " slips up beside you, resting her cheek ");
	if (player.biggestTitSize() < 1) outputText("on your chest");
	else outputText("between your [chest]");
	outputText(".  Already, you feel more thick-skinned and less lusty, and so give an appreciative grin to your cute little gargoyle.  In response, she nuzzles against you and wraps her bat-like wings protectively around the two of you.");
	
	outputText("\n\nYou spend a few minutes cuddling with " + flags[kFLAGS.GAR_NAME] + ", but sadly, you know you can't leave your camp unattended for too long.  Giving her a pat on the head and a kiss on the brow, you gather up your clothes and head on back to camp.");
	dynStats("tou", .5, "lib", -.5, "sen", -2);
	gargoyleConfidence(2);
	player.takeDamage(Math.round(player.maxHP()/2));
	doNext(camp.returnToCampUseOneHour);
}
	
//[b]Mind[/b]
//(Confidence +2)
//(PC Decreases Corruption and Lust, increases Intelligence)
private function mindRitualPervy():void {
	clearOutput();
	gargoyleConfidence(2);
	outputText("You tell " + flags[kFLAGS.GAR_NAME] + " that you've been plagued with dirty thoughts, and would like to undo some of the corruption that's spread to your mind.  With a deep nod conveying both a respect for your choice and an eagerness to engage in the ritual, " + flags[kFLAGS.GAR_NAME] + " tells you to kneel before the altar.  You do so, assuming a low, supplicating stance before the tree-idol at the Cathedral's head as the gargoyle clears off the altar save for the humble bowl of water.");
	
	outputText("\n\n" + flags[kFLAGS.GAR_NAME] + " lifts herself to perch atop the alter with a single beat of her wings, coming to rest cross-legged before you.  Grinning a sexy grin, she picks up the small waterbasin and lifts it up to her lips, taking a small drink of it.  \"<i>Blessed is " + player.mf("he","she") + " who seeks the pure,</i>\" she begins to chant, lowering the bowl from her thin lips. As she does so, she slowly raises her left leg, resting her toes upon your chin.  Locking eyes with you, " + flags[kFLAGS.GAR_NAME] + " lowers the basin to her thigh and begins to pour, letting the water trickle sensually down her stone-smooth leg.  \"<i>Blessed is " + player.mf("he","she") + " who seeks wisdom,</i>\" she purrs as you instinctively open your mouth, allowing the holy water to trickle in from her foot.");
	
	outputText("\n\n" + flags[kFLAGS.GAR_NAME] + " quickly slips her small toes into your mouth, letting you suckle the holy water from them like an infant.  She lets you remain like that for nearly a minute, nursing from the rivulets that come your way, before pulling her leg back and taking your head with it.  She leans backwards as you approach, balancing upon her bat-like wings as she finishes the chant: \"<i>And blessed is " + player.mf("he","she") + " who lusts after holiness and virtue before pleasures of the flesh.</i>\"  She pours from the basin once again, releasing the holy water directly onto the large, shapely mounds of her breasts.  The water runs down her chest and belly, creating a tiny waterfall over the nub of her clitoris to which she guides you.");
	
	outputText("\n\nYou do as she so obviously wishes, and spread her legs to get a good look at her now-sopping wet slit. Her vagina seems small, but an experimental touch proves it to be quite malleable – and your single touch causes " + flags[kFLAGS.GAR_NAME] + " to arch her back, gasping with the sudden pleasure.  Smiling at the adorable, enraptured look on her face, you start lapping with a vengeance, grasping her thighs and burying your face between her legs.  You flick your tongue into her smooth, cool slit, lapping up a few drops of water with each flick of your dexterous tongue, and eliciting a gasp or moan each time.");
	
	outputText("\n\nSoon, " + flags[kFLAGS.GAR_NAME] + " is clutching at her breasts and quickly fingering her cherry-nub clit as you lick her out, trying her best to keep an even rhythm with you, even as the waterfall comes to an end and you begin to feel light-headed, as if a fog has lifted from your mind.  By way of thanks, you redouble your efforts to pleasure her, ramming your tongue into her depths and fucking her mercilessly.  Quickly, she begins to tense, stopping her own actions to grasp at your " + player.hairDescript() + " and shove your face further into her crotch, locking her legs and tail around your back as she approaches orgasm.");
	
	outputText("\n\nScreaming, " + flags[kFLAGS.GAR_NAME] + " arches her back and thrusts out her bat-wings to their full expanse, clamping down on your tongue as she cums.  You slow your pace, giving her a last few licks as she pants, gasps, and moans, slowly coming down from an orgasmic high.  She collapses backwards, clutching her chest and staring into the rafters.  Chuckling, you stand and give her a pleased pat on the inner thigh, letting her know she did a good job for you.  You leave her smiling atop the altar, slowly getting her breath under control.");
	//(Return PC to camp, advance time 1 hour)
	dynStats("int", .5, "lus", -10, "cor", -.5);
	player.changeFatigue(50);
	doNext(camp.returnToCampUseOneHour);
}

//[b]Banish[/b]
//(Confidence +2)
private function banishPervRitual():void {
	clearOutput();
	//(PC is cleared of Worms and/or Exgartuan)
	outputText("You explain to " + flags[kFLAGS.GAR_NAME] + " that you seem to have picked up ");
	if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0) outputText("a hitchhiker");
	else outputText("some hitchhikers");
	outputText(" in your travels, and you're tired of ");
	if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0) outputText("it");
	else outputText("them");
	outputText(".  She gives you an understanding nod and tells you to strip.  As you do so, she dips beneath the altar, reappearing with a silver, blue-rune covered rod nestled into what looks like a leather thong.  " + flags[kFLAGS.GAR_NAME] + " slips the thong on, letting a slight gasp escape her lips as the inner end of the rod enters her.");
	
	outputText("\n\nShe gives the shaft of the strap-on a few experimental strokes and, satisfied, says, \"<i>I've turned down the power of the runes, so it will not hurt you so much... though it will take longer than normal.  I suggest you lubricate it, Master.</i>\"  Smiling, she sits herself atop the alter and presents her silver “cock” to you.  You kneel and slip your face between her spread legs, giving the rod a quick lick.  It's incredibly smooth and quite cold, much like its wearer, but your tongue comes away with a warm tingle spreading through it – not pain, but more like numbness.  You take the rod into your mouth, running your tongue across its length and thrusting your face against it, blowing it like a cock while getting it sopping wet with your saliva.  You've only been at it for a minute when you notice " + flags[kFLAGS.GAR_NAME] + " is bucking her hips slightly and moaning quietly, obviously getting more than a little enjoyment from the sensation.  Perhaps she can feel through it, like a real dick?  Grinning, you redouble your efforts to suck her off.");
	
	outputText("\n\n\"<i>Enough, Master,</i>\" she gasps, pushing you back.  Breathing heavily, she takes you by the hand and gets you to brace yourself against the altar.  Your entire mouth is numb now, tingling from the strange sensation given off by the holy rod-cock.  " + flags[kFLAGS.GAR_NAME] + " slips behind you, putting a cool, soft hand on your [hips] as she lines up for penetration.  You grip down hard on the edge of the altar, and try your best to relax your sphincter as you begin to feel a tingling pressure against your back door.");
	if (player.ass.analWetness > 0) outputText("  She slips in easily, sliding her tingling holy rod into you until her hips are pressed against your [butt]");
	else outputText("  She slowly but surely coaxes the holy rod into your asshole, making long and slow thrusts into you until she finally bottoms out");
	outputText(".");

	outputText("\n\nWith her rod firmly inside you, " + flags[kFLAGS.GAR_NAME] + " puts her hands on your [hips] for leverage and begins to pull out again, leaving a hot, intense tingling sensation in your rectum.  She thrusts in, this time much more quickly than you were expecting, making you gasp and moan as her hips slam into yours.");
	//If PC has Worms: 
	if (player.findStatusEffect(StatusEffects.Exgartuan) < 0) outputText("  You can feel her cock ram against your prostate, and shudder as the writhing mass of worms begin to panic as her cock pushes against them, obviously causing the creatures great pain.");
	outputText("  " + flags[kFLAGS.GAR_NAME] + " begins to fuck you in earnest, hammering your [asshole] with the strap-on until you're both panting and gasping, nearly overwhelmed by sensation.");
	//(If PC has Exgartuan: 
	if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0) outputText("  You can hear the demonic voice of Exgartuan inside your mind, yelling and cursing as he is rapidly drained from your body and sealed into the holy rod within you.");
	
	//(If PC has a cock:
	if (player.hasCock()) {
		outputText("\n\n" + flags[kFLAGS.GAR_NAME] + " suddenly releases your hips and, pressing her soft breasts into your sweat-slicked back, grabs your [cock biggest] in her cold hand.  You let out a little gasp as she begins to jerk you off, rapidly pistoning your cock as she continues to pound your ass.  Between the dual stimulation, you feel a pressure begin to swell up inside your abused prostate, a tell-tale sign of orgasm.  She gives you a few last thrusts before you cum, splattering the altar with thick ropes of cum as you both yell in ecstasy.");
	}
	else {
		outputText("\n\n" + flags[kFLAGS.GAR_NAME] + " reaches the peak of her speed, utterly reaming you as ");
		if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0) outputText("Exgartuan is");
		else outputText("the worms are");
		outputText(" sucked from your body. Suddenly, she leans in and presses her lips to yours, thrusting her tongue against yours, letting you feel her begin to convulse and shake with release. Cupping her cheek, you return the kiss with gusto, willing yourself toward an anal orgasm. Within moments, the incredible tingling and the rapid ass-fucking combine toward your own climax, and you squeeze down hard upon the rod inside you as you cum, shaking and shuddering in the gargoyle's grasp.");
	}
	
	outputText("\n\nSuddenly, the holy rod jammed up your [asshole] makes a loud hissing sound, and withdraws. Panting, you collapse to the ground, gripping your gut.  It's over, and though a part of you feels suddenly very empty, it's soon forgotten as " + flags[kFLAGS.GAR_NAME] + " slips down beside you, having already tossed the holy rod out the window.  The creature");
	if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0) outputText(" within you has");
	else outputText("s within you have");
	outputText(" been absorbed and purged by the rod; and you can't help but hope she has more... just in case.");
	
	outputText("\n\nStill panting and gasping from your ordeal, you slip an arm around " + flags[kFLAGS.GAR_NAME] + "'s shoulders, bringing her into a tight embrace.  Smiling cutely, she nuzzles her cheek against your chest, and winds her large bat-wings around the two of you, wrapping you together.  You give her a long, tender kiss on the brow, and let her remain like that for a good long while, basking in each others' presence.");
	
	outputText("\n\nEventually, though, you know you need to get back to camp.  You try to tell " + flags[kFLAGS.GAR_NAME] + ", but to your surprise, she's fast asleep, snoring softly.  With a grin, you untangle yourself from her embrace and find something to cover her with before giving her another kiss and making your way home.");
	//(Return PC to camp, advance time 1 hour)
	if (player.findStatusEffect(StatusEffects.Exgartuan) >= 0) player.removeStatusEffect(StatusEffects.Exgartuan);
	else player.removeStatusEffect(StatusEffects.Infested);
	player.takeDamage(Math.round(player.maxHP()/3));
	player.changeFatigue(10);
	gargoyleConfidence(2);
	doNext(camp.returnToCampUseOneHour);
}


//[b]Talk[/b]
private function talkToGargoyle(output:Boolean = true):void {
	if (output) {
		clearOutput();
		outputText("You take a seat on one of the sanctuary's pews, motioning for " + flags[kFLAGS.GAR_NAME] + " to join you.");
		//If Confidence <50:
		if (gargoyleConfidence() < 50) outputText("  She meekly approaches her Master and kneels before you, head bowed submissively.");
		//if Confidence = 51-69: 
		else if (gargoyleConfidence() < 70) outputText("  She nearly skips to follow you, assuming her low crouch at your feet and looking up at your expectantly.");
		else outputText("  Happily, she takes a seat beside you and slips an arm around your shoulders, locking you in companionable closeness.");
		outputText("  You tell her you'd like to talk for a few minutes, which immediately causes her eyes to brighten excitedly.  \"<i>Master honors me...  What would you like to talk about?</i>\"");
	}
	//(Display Options: [History] [Cathedral] " + flags[kFLAGS.GAR_NAME] + " [Leave])
	//(Whenever the player selects a topic, play one of the following dialogue scenes then return the PC to the main interaction menu and increase Confidence by +10, unless noted otherwise. Once a scene has been played, it will not play again. Once all three in a topic are played, it closes.)
	menu();
	if (flags[kFLAGS.GAR_HISTORY] < 3) addButton(0,"History",historyGo);
	if (flags[kFLAGS.GAR_CATHEDRAL] < 3) addButton(1,"Cathedral",cathedralTalks);
	if (flags[kFLAGS.GAR_NAME_TALKS] < 3) addButton(2,"Her",talkAboutGarName);
	addButton(4,"Back",returnToCathedral);
}

private function historyGo():void {
	if (flags[kFLAGS.GAR_HISTORY] == 0) {
		flags[kFLAGS.GAR_HISTORY] = 1;
		talkToGargoyleHistoryA();
	}
	else if (flags[kFLAGS.GAR_HISTORY] == 1) {
		historyOfGargoylesB();
		flags[kFLAGS.GAR_HISTORY] = 2;
	}
	else {
		flags[kFLAGS.GAR_HISTORY] = 3;
		gargoyleHistoryC();
	}
}

//[b]History A[/b]
private function talkToGargoyleHistoryA():void {
	clearOutput();
	
	outputText("You ask " + flags[kFLAGS.GAR_NAME] + " what she can tell you about the history of Mareth.  She shrugs lightly.  \"<i>I can't tell you much, Master.  I've spent my entire life on these grounds.  Most of what I know was doctrine taught by the church. Is that acceptable?</i>\"");
	
	outputText("\n\nYou tell her that, sure, you'd like to hear it.  \"<i>The church-folk believe – believed – that the goddess Marae created intelligent life here many generations ago, long before the demons came.  She was the highest goddess amongst many, an embodiment of the natural world.  She brought forth the animal-morphs who created this cathedral in her honor.  Using magical knowledge, the priests of this church sought to mirror Marae's power, creating creatures such as myself.  Eventually, though, the demons came, I know not from where, and began to spread their corruption.  The priests... tried to resist... t-to ward against...  I'm sorry, Master,</i>\" she says, sniffling.  You notice that she's turned away from you, trying to hide her shame.  \"<i>I don't want to think about this anymore.  Please,</i>\" she begs.  The memory of her failure to protect the people of the church still weighs heavily upon her.  You suppose you could berate her for her emotionality, or try and comfort her.");
	//(Display Options: [Berate] and [Comfort])
	menu();
	addButton(0,"Berate",berateGargoyleForBeingDumb);
	addButton(1,"Comfort",comfortGargoyleDumbness);
	
}

//[b]Berate[/b]
private function berateGargoyleForBeingDumb():void {
	clearOutput();
	//(Confidence -5)
	gargoyleConfidence(-5);
	outputText("\n\nYou attempt to give " + flags[kFLAGS.GAR_NAME] + " a none-too-gentle swat on the head, and tell her off for presuming to refuse you information.  The harshness of your voice only causes her to sob openly, however, and recoil away from you before you can hit her.  You sigh with frustration, and storm out of the cathedral before you have to listen to a moment more of your servant's cries.");
	//(Return PC to camp, advance time 1 hour.)
	doNext(camp.returnToCampUseOneHour);
}

//[b]Comfort[/b]
private function comfortGargoyleDumbness():void {
	clearOutput();
	//(Confidence +3)
	gargoyleConfidence(10);
	outputText("You sigh and reach over to " + flags[kFLAGS.GAR_NAME] + "; ");
	//if Confidence <50:
	if (gargoyleConfidence() < 50) outputText("she recoils, but ");
	outputText("you cup her cheek, and turn her to face you.  If she could produce tears, you're sure they'd be streaming down her cheeks.  You give her your most reassuring smile and lean in to give her a quick kiss on the brow.  She gasps, but before you know it, she has leapt into your lap and has buried her face into your chest, holding onto you as if for dear life.  You put your arms around her and hold her close while she cries, spending the next few minutes either whispering reassurances to her or stroking her back and hair.  Eventually, she calms down.  Ever so shyly, " + flags[kFLAGS.GAR_NAME] + " returns the kiss you'd given her.  \"<i>I'm sorry, Master,</i>\" she whispers, curling up beside you.  \"<i>I should have been strong enough to protect my people.  I know that.  That it's my fault they've all been dragged off to some unholy carnal pit.  I just...</i>\"  You stop her before she can go on and tell her that no, it wasn't her fault.  She couldn't have done anything to stop it.  She tries to give you a brave smile and says, \"<i>I know. Can we... talk about something else, Master?</i>\"");
	//(Return PC to the Talk menu)
	talkToGargoyle(false);
}

//[b]History B[/b]
private function historyOfGargoylesB():void {
	clearOutput();
	outputText("You ask " + flags[kFLAGS.GAR_NAME] + " to tell you a little bit about the demons coming to Mareth");
	if (gargoyleConfidence() >= 70) outputText(" if she's up to it");
	outputText(".  ");
	outputText("Hesitantly, she nods her assent, though she says, \"<i>I'm sorry, Master, but I must warn you: I was greatly abused by the demons.  They are responsible for everything that is wrong with my world");
	//if Confidence >70: 
	if (gargoyleConfidence() > 70) outputText(", and I despise them with every fiber of my being");
	outputText(".  I may not be the most fair nor most balanced source of information.</i>\"");
	
	outputText("\n\nYou tell her that's fine.  She steels herself, then begins to speak: \"<i>The demons arrived decades ago.  I can't remember how long, exactly; I spent most of that time chained and dormant until you found me, and time blurred.  When they arrived, it was like a tidal wave of corruption...  They swept down from the mountains and stormed through the fields.  They took the world by surprise, capturing... capturing much of it in short order.  There was little the people could do to stop them.  Some people fled, some people died, many more were captured and turned into-into sex toys o-or worse...</i>\" she trails off, shaking visibly.  The memory must be horrible for her.  \"<i>I'm sorry, Master.  It's just... those corrupt monsters came here near the end of the first year.  We'd held off so long... but it wasn't enough.</i>\"  She falls silent, looking shamefully away.  You suppose that's all you'll get out of her for now.");
	gargoyleConfidence(10);
	talkToGargoyle(false);
}
	
//[b]History C[/b]
private function gargoyleHistoryC():void {
	clearOutput();
	//(PC has both Isabella and Izma as followers)
	if (kGAMECLASS.izmaScene.izmaFollower() && kGAMECLASS.isabellaFollowerScene.isabellaFollower()) {
		outputText("You ask " + flags[kFLAGS.GAR_NAME] + " to tell you a little bit about the world of Mareth.  Giving it a few moments of quiet thought, she answers: \"<i>I do not have any experience outside of the church grounds, Master, but I remember the words of the last Master, and the parishioners before her.  There are... the world has a vast expanse of plains and woodlands, broken up by a mountain range and lake.  Those last two are populated by savage beasts, minotaurs, cow-girls, anemone, and shark-people, both of whom will rend your flesh or rape you half to death.</i>\"");
		outputText("\n\nWhoa, there. You stop " + flags[kFLAGS.GAR_NAME] + " and explain to her that some of your lovers – mates, even – are just such beasts.  You tell her a little bit about Izma and Isabella, enforcing the fact that they're both not only quite friendly, but sweet as well.  They're just regular people");
		if (gargoyleConfidence() > 50) outputText(" just like her");
		outputText(".  If she could, you're sure " + flags[kFLAGS.GAR_NAME] + " would be blushing bright crimson as you educate her on a little inter-special tolerance and understanding.  Chastened, she nods her comprehension when you're finished and, after a long pause, asks, \"<i>I-If Master really has many... girlfriends... does... no, it's silly, of course not...</i>\"");
		outputText("\n\nGiving her a pat on the head, you encourage her to speak her mind.  Meekly she whimpers, \"<i>If master has many girlfriends... what am I?</i>\"");
		outputText("\n\nOh shit.  Here we go.  You suppose you could dodge the bullet, or you could tell her what you really think: is she just a slave you wandered into owning, or do you think something more of her?");
		//(Display Options: [Dodge] [Slave] [Girlfriend]
		menu();
		addButton(0,"Dodge",izmaAndIsabellaDodge);
		addButton(1,"Slave",gargoylesAreSlavesYo);
		addButton(2,"Girlfriend",gargoylesAreGirlfriends);
	}
	//(If PC has Marble as a follower)
	else if (player.findStatusEffect(StatusEffects.CampMarble) >= 0) {
		outputText("You ask " + flags[kFLAGS.GAR_NAME] + " to tell you a little bit about the world of Mareth.  Giving it a few moments of quiet thought, she answers: \"<i>I do not have any experience outside of the church grounds, Master, but I remember the words of the last Master, and the parishioners before her.  I believe there is a lake not far from here.  Beyond that, the world has a vast expanse of plains and woodlands, broken up by a great mountain range – strange monsters live there, but worst of all are savage bull-like beasts called Minotaurs.  And the cow-girls... Lacta-Bovines, I think they're called, who're just as nasty.</i>\"");
		outputText("\n\nYou cut " + flags[kFLAGS.GAR_NAME] + " off right there, and explain that one of those 'savage beasts' is your lover, Marble, who's really quite sweet.  The gargoyle makes a horrified gasp and covers her mouth.  \"<i>I'm so sorry, Master! I didn't know...  All I'd heard were stories, years ago.  I didn't mean... but...  I-I didn't know Master had a girlfriend,</i>\" she whines pitifully.  Obviously, knowing that she's not your only lady-friend has upset the poor thing.");
		outputText("\n\nWell.  What do you say to that: that you're not exclusive with Marble, or that " + flags[kFLAGS.GAR_NAME] + " doesn't count, being a statue and all?");
		//(Display Options: [Not Exclusive] [Doesn't Count])
		menu();
		addButton(0,"Not Exclusive",marbleAintExclusiveBiatch);
		addButton(1,"Doesn'tCount",gargoyleDoesntCountAsAWaifu);
	}
	//(If PC has Izma as a follower)
	else if (kGAMECLASS.izmaScene.izmaFollower()) {
		outputText("You ask " + flags[kFLAGS.GAR_NAME] + " to tell you a little bit about the world of Mareth.  Giving it a few moments of quiet thought, she answers: \"<i>I do not have any experience outside of the church grounds, Master, but I remember the words of the last Master, and the parishioners before her.  There are... the world has a vast expanse of plains and woodlands, broken up by a great mountain range.  There is a lake not far from here, if I recall; a race of very dangerous shark-folk live there.</i>\"  With a chuckle, you tell " + flags[kFLAGS.GAR_NAME] + " that you're more than well aware of that; indeed, you consider one such creature to be your mate, your beta.  She makes a slight gasp, and gushes out an apology.  \"<i>I'm so sorry, Master!  I hadn't realized... I thought...</i>\" she falls silent for a moment, then says shyly, \"<i>I wasn't aware Master had a girlfriend.</i>\"  Obviously, knowing that she's not your only lady-friend has upset the poor thing.");
		
		outputText("\n\nWell. What do you say to that: that you're not exclusive with Izma, or that she doesn't count, being a statue and all?");
		//(Display Options: [Not Exclusive] [Doesn't Count])
		menu();
		addButton(0,"Not Exclusive",sharkgirlsArentExclusiveBiatch);
		addButton(1,"Doesn'tCount",gargoylesDontCountAsSharkWaifus);
	}
	else {
		//(If PC has neither Marble nor Izma as a follower)
		outputText("You ask " + flags[kFLAGS.GAR_NAME] + " to tell you a little bit about the world of Mareth.  Giving it a few moments of quiet thought, she answers: \"<i>I do not have any experience outside of the church grounds, Master, but I remember the words of the last Master, and the parishioners before her.  There are... the world has a vast expanse of plains and woodlands, broken up by a great mountain range.  There is a lake not far from here, if I recall...</i>\" she goes on to tell you about some of the more common Marethian monsters, though she's short on details except about those that regularly bother the church – imps and goblins, mostly.  You thank her for the talk and turn toward another subject...");
		gargoyleConfidence(5);
		returnToCathedral(true);
	}
}


//MARBLE
//[b]Not Exclusive[/b]
private function marbleAintExclusiveBiatch():void {
	clearOutput();
	outputText("You run a hand through " + flags[kFLAGS.GAR_NAME] + "'s hair and reassure her that being with Marble won't affect the way you interact with her – you're more than able to be fond of many girls at once.  This doesn't seem to entirely please her, but neither does she throw a tantrum, so you suppose that's good enough.");
	returnToCathedral(true);
}

//[b]Doesn't Count[/b]
//(Confidence -5)
private function gargoyleDoesntCountAsAWaifu():void {
	clearOutput();
	outputText("You scoff and tell her not to worry – it's not like you're cheating on Marble by being around her, after all.  She's just a statue – a toy, really. Her head sinks low, and the little gargoyle lets out a shudder that might just have been a sob.  You shake your head and change the subject.");
	//(Return PC to " + flags[kFLAGS.GAR_NAME] + "'s main menu)
	gargoyleConfidence(-5);
	returnToCathedral(true);
}
//IZMA
//[b]Not Exclusive[/b]
private function sharkgirlsArentExclusiveBiatch():void {
	clearOutput();
	outputText("You run a hand through " + flags[kFLAGS.GAR_NAME] + "'s hair and reassure her that being with Izma won't affect the way you interact with her – you're more than able to be fond of many girls at once.  This doesn't seem to entirely please her, but neither does she throw a tantrum, so you suppose that's good enough.");
	returnToCathedral(true);
}

//[b]Doesn't Count[/b]
private function gargoylesDontCountAsSharkWaifus():void {
	clearOutput();
	//(Confidence -5)
	gargoyleConfidence(-5);
	outputText("You scoff and tell her not to worry – it's not like you're cheating on Izma by being around her, after all.  She's just a statue – a toy, really.  Her head sinks low, and the little gargoyle lets out a shudder that might just have been a sob.  You shake your head and change the subject.");
	//(Return PC to " + flags[kFLAGS.GAR_NAME] + "'s main menu)
	returnToCathedral(true);
}


//IZMA & ISABELLA
//[b]Dodge[/b]
private function izmaAndIsabellaDodge():void {
	clearOutput();
	//(Confidence -5)
	gargoyleConfidence(-5);
	outputText("You make a shitty joke and laugh awkwardly, trying to avoid the topic altogether.  " + flags[kFLAGS.GAR_NAME] + " makes a pitiful little sniffle, but takes the hint and falls silent, allowing you to change the subject.");
	//(Return PC to Talk menu)
	returnToCathedral(true);
}

//[b]Slave[/b]
//(Confidence -15)
private function gargoylesAreSlavesYo():void {
	clearOutput();
	gargoyleConfidence(-15);
	outputText("Well, really, what is she but a slave?  She's just a toy when you want sexual release, a servant to perform rituals at your demand, and a bit of eye-candy besides.  She's not even a real person – not really.  You tell her that, quite bluntly.  She makes no response, verbally at least, but she does give off a sob-like shudder and curls up into a little ball where she sits, hiding her face from you.");
	outputText("\n\nSince you've temporarily broken the gargoyle, you mosey on back to camp.");
	//(Return PC to camp, advance time 1 hour)
	doNext(camp.returnToCampUseOneHour);
}
//[b]Girlfriend[/b]
private function gargoylesAreGirlfriends():void {
	//(Confidence +15)
	clearOutput();
	
	gargoyleConfidence(15);
	outputText("You smile at " + flags[kFLAGS.GAR_NAME] + " and tussle her hair.  Warmly, you tell her that, if she wants, she can be your girlfriend too.  Polyamory is just your thing, you suppose.  With a happy gasp, the little gargoyle leaps into your lap and wraps her arms around you, hugging you so tight you almost can't breathe.  She gives you a flurry of little kisses all along your neck and cheek before planting a long, deep one on your lips.  You kiss her back, soon laughing amicably as you return her embrace.  Once she's calmed down, " + flags[kFLAGS.GAR_NAME] + " settles into your lap, resting her cheek against your chest and wrapping her tail and wings lovingly around you.  You give her a little peck on the forehead and nuzzle your chin into her hair, content to stay like this forever.");
	
	outputText("\n\nYet, you're soon surprised when " + flags[kFLAGS.GAR_NAME] + " withdraws slightly from you, though her arms are still hooked about your neck.  \"<i>Master... if you want me to be your girlfriend, then... we should – if you want, Master, of course – maybe...  Master, will you make love to me?</i>\" she blurts, suddenly taken aback by her own forwardness.");
	//(Male Display Options: [Vaginal] [Leave])
	//(All Other Display Options: [Strap-on] [Leave])
	//(Use normal sex scenes for above options, as well as Leave options.
	menu();
	if (player.hasCock()) addButton(0,"Vaginal",gargoyleCoochiiGetsPlowed);
	else addButton(1,"Strap-on",strapOnGargoyle);
	addButton(4,"Leave",camp.returnToCampUseOneHour);
}

private function cathedralTalks():void {
	if (flags[kFLAGS.GAR_CATHEDRAL] == 0) {
		flags[kFLAGS.GAR_CATHEDRAL]++;
		talkCathedralA();
	}
	else if (flags[kFLAGS.GAR_CATHEDRAL] == 1) {
		cathedralBTalk();
		flags[kFLAGS.GAR_CATHEDRAL] = 2;
	}
	else {
		cathedralC();
		flags[kFLAGS.GAR_CATHEDRAL] = 3;
	}
}


//[b]Cathedral A[/b]
private function talkCathedralA():void {
	clearOutput();
	outputText("You ask " + flags[kFLAGS.GAR_NAME] + " to tell you a little about the Cathedral around you.  She visibly brightens at the idea.  \"<i>This is the greatest structure for miles around,</i>\" she claims proudly, motioning toward the vaulted ceiling and the remaining stained glass windows.  \"<i>Well, it isn't much to look at now, Master, but it was magnificent.  People came from all around to pray here.  It was wonderful...</i>\" she trails off, looking misty-eyed into the distance, remembering.");
	
	outputText("\n\n\"<i>Master?</i>\" she asks, looking you in the eye.  \"<i>I...  I want to rebuild the Cathedral.  I know there... there's no one to return to it, but...  I don't know.  It feels like repairing the damage that's been done would be a victory.  Just a little tiny one, but still a victory.</i>\"  " + flags[kFLAGS.GAR_NAME] + " makes a sudden little gasp and says, \"<i>I-If that's all right with you, Master?</i>\"");
	
	outputText("\n\nYou could tell her it's pointless or encourage her.");
	//(Display Options: [Pointless] [Encourage])
	menu();
	addButton(0,"Pointless",pointlessGargoylesArePointless);
	addButton(1,"Encourage",encourageGargoyleWaifuToDoSomething);
}

//[b]Pointless[/b]
//(Confidence -2)
private function pointlessGargoylesArePointless():void {
	clearOutput();
	gargoyleConfidence(-5);
	outputText("You roll your eyes and try to explain how foolish that is.  It's a building in the middle of nowhere; the demons sure as hell don't care about it, especially when there are no people around to corrupt or enslave.  You command her not to waste her time repairing the building any more than is necessary to make it bearable for you when you're there; anything more than that is effort wasted.");
	
	outputText("\n\n\"<i>I...Of course, Master.  H-How silly of me.</i>\"");
	
	outputText("\n\nYou nod, and change the subject.");
	//(Return PC to Talk menu)
	talkToGargoyle(false);
}

//[b]Encourage[/b]
//(Confidence +2)
private function encourageGargoyleWaifuToDoSomething():void {
	clearOutput();
	gargoyleConfidence(10);
	outputText("You give " + flags[kFLAGS.GAR_NAME] + " a pat on the head and tell her it's a wonderful idea.  She makes a happy squeak and immediately flutters over to a pile of debris and starts cleaning it up.  Before you know it, the little gargoyle's on a roll, whistling a jaunty tune as she starts repairing some of the more obvious damage.  Seeing her so engrossed, you can't help but smile.  You wander over and start to give her a hand.");
	
	outputText("\n\nWithin the hour, the two of you have made a sizable dent in the debris of the Cathedral, and " + flags[kFLAGS.GAR_NAME] + " has even managed to hang one of the candelabras back up in the rafters.  Exhausted, you say goodbye to the happy little gargoyle and head on back to camp.");
	//(Return PC to camp, advance time 1 hour, +10 fatigue.
	player.changeFatigue(10);
	doNext(camp.returnToCampUseOneHour);
}

//[b]Cathedral B[/b]
private function cathedralBTalk():void {
	clearOutput();
	outputText("You ask " + flags[kFLAGS.GAR_NAME] + " to tell you a little bit more about the religion that called the Cathedral its home.  Happily, this seems to be an engaging topic for the little gargoyle, who eagerly explains: \"<i>They worshiped a pantheon of gods – the beings that inhabited this world before the animal-morphs were raised up, and long before the demons came.  Marae was the chief goddess,</i>\" she says, nodding to the tree-shaped icon at the head of the sanctuary.  \"<i>She taught the people rituals to better their lives, rituals to purify their minds and bodies, and even helped them learn the basics of life.  These gods were creators, raising up the animals of the world to intelligence, mirroring that of the humans.  For that, they were worshiped and... in some cases, imitated.</i>\"");
	
	outputText("\n\nYou ask her if she means herself, and she nods.  \"<i>The high priests of the church created me and many others to be their protectors.  We were carved of stone and animated by magic - powerful magic.  We were the perfect servants and guardians... and now I'm the only one left.</i>\"");
	
	outputText("\n\nShe falls into a deep, melancholy silence.  You soon try to change the subject.");
	gargoyleConfidence(10);
	talkToGargoyle(false);
}

//[b]Cathedral C[/b]
private function cathedralC():void {
	clearOutput();
	outputText("As you sit down with " + flags[kFLAGS.GAR_NAME] + " to talk, you remember her words when you first met indicating that she could not – or would not – leave the Cathedral, even if you asked her to.   You ask her about that.");
	outputText("\n\n\"<i>Master,</i>\" " + flags[kFLAGS.GAR_NAME] + " says, now looking you straight in the eye, \"<i>the Cathedral is my home, the only home I've ever known.  Even if I could leave, I would not want to");
	if (gargoyleConfidence() > 69) outputText(" unless it were to be with you, that is");
	outputText(".  But I am bound to this place, Master. I could not leave even if I wanted to.  My makers were wary of their creation, and chose to bind me here; they thought that if I ever rebelled, I would not do much harm if contained within the Cathedral.</i>\"");
	
	outputText("\n\nYou ask her if any of the other gargoyles ever rebelled.  This causes her to look away quickly, hiding her face.  \"<i>Yes,</i>\" she whispers.  \"<i>One.  When the demons came, a single gargoyle saw his chance to escape his fetters and threw open the doors when all the parish was gathered within taking shelter from the attack.  They were helpless to resist the demons, no matter how hard the rest of us fought to protect them....</i>\"");
	
	outputText("\n\n\"<i>And,</i>\" she whimpers, \"<i>I was helpless, too.  This holy place became a carnal pit.  We were raped and raped and raped again until even the demons were sated.  Then they dragged the villagers away and destroyed the gargoyles.</i>\"");
	
	outputText("\n\nAll but her, you're quick to point out.  \"<i>All but me,</i>\" she echoes.  \"<i>One of the demons took a liking to me, and wanted to keep me as a pet.  I suppose I was lucky; the bonds the priests put upon me saved me from being dragged off and abused until the end of days... by him, at least. And without them, I never would have met you,</i>\" she adds sweetly, once again looking up at you expectantly.  You can see the sadness in her eyes, but also hope.");
	
	outputText("\n\nYou could comfort the little gargoyle, or you could remind her of the ramifications of her failure.");
	//(Display Options: [Comfort] and [Berate])
	menu();
	addButton(0,"Berate",berateDatGargoyle4SomeSavin);
	addButton(1,"Comfort",comfortGargoyle);
	
}

//[b]Comfort[/b]
//(Comfort +10)
private function comfortGargoyle():void {
	clearOutput();
	outputText("You pick " + flags[kFLAGS.GAR_NAME] + " up and wrap her in a tight hug, telling her that's everything's going to be all right and that you're here for her.  She makes a happy, girlish squeal and hugs you back, quickly wrapping her legs around your waist and planting a kiss on your cheek.  You sit back down, resting her on your lap, and ruffle her hair.  She grins and hugs you tighter until you're almost struggling to breathe.");
	outputText("\n\n\"<i>Thank you, Master,</i>\" she whispers into your ear, giving it a little kiss.  \"<i>I'll always be here for you, too.  I swear it.</i>\"");
	
	outputText("\n\nYou spend a few more minutes with your little gargoyle, patting her head and hugging on her.  But, eventually, you know it's time to head back to camp.  You say your goodbyes and head for the door.");
	
	outputText("\n\nTo your surprise, " + flags[kFLAGS.GAR_NAME] + " follows you, running to catch up with you.  She takes your hand in hers and wraps one of her wings around you as you walk, holding you close as you make your way out the doors and onto the grounds.  Soon, though, you see " + flags[kFLAGS.GAR_NAME] + " slowing and grimacing – approaching the edge of her boundary.  The two of you stop at the wrought-iron fence surrounding the Cathedral, and face each other.");
	
	outputText("\n\nYou realize this is the first time you've ever seen her outside the sanctuary, and proudly give her a kiss on the lips at the gate.  When you part, she shyly tells you to take care on the way back, and that she'll be here waiting for you when you return.");
	//(Return PC to camp, advance time 1 hour)
	gargoyleConfidence(10);
	doNext(camp.returnToCampUseOneHour);
}

//[b]Berate[/b]
//(Confidence -10)
private function berateDatGargoyle4SomeSavin():void {
	clearOutput();
	outputText("Right.  Because becoming a living footstool for you was TOTALLY worth everyone she ever knew being raped out of their minds.  You give " + flags[kFLAGS.GAR_NAME] + " a hard swat and remind her exactly how moronic she's being.  She recoils, shying away from you as you stand up and head for the door.  Over your shoulder, you tell her you're glad she's bound here – that way she can't fuck up and get you killed, too.");
	//(Return PC to camp, advance time 1 hour)
	gargoyleConfidence(-10);
	doNext(camp.returnToCampUseOneHour);
}

private function talkAboutGarName():void {
	if (flags[kFLAGS.GAR_NAME_TALKS] == 0) {
		flags[kFLAGS.GAR_NAME_TALKS] = 1;
		garNameA();
	}
	else if (flags[kFLAGS.GAR_NAME_TALKS] == 1) {
		flags[kFLAGS.GAR_NAME_TALKS] = 2;
		garNameB();
	}
	else {
		flags[kFLAGS.GAR_NAME_TALKS] = 3;
		garNameC();
	}
}


//[b]" + flags[kFLAGS.GAR_NAME] + " A[/b]
//(Confidence +3)
private function garNameA():void {
	clearOutput();
	outputText("Curious about your gargoyle, you ask " + flags[kFLAGS.GAR_NAME] + " to tell you a little bit about her life before you arrived.  She makes a nervous chuckle at the request, and shyly says, \"<i>Master is too kind...  I am no one special...</i>\"");
	
	outputText("\n\nYou urge her on, adding that you can make it a command if you have to.  She fidgets awkwardly for a moment, but finally says, \"<i>If Master insists.  I was sculpted in a village not far from here.  The high priest ordered me and a dozen others from the finest sculptor in the land.  We were perfect, in a way.  Each of us was unique, complete, made to be as human as you ");
	if (player.race() == "human") outputText("are");
	else outputText("once were");
	outputText(", Master, and more.  We were to be their guardians, protectors – their perfect servants.</i>\"");
	
	outputText("\n\n\"<i>When the demons came...I survived, the others didn't.  I was here alone for a while after that.  Then, perhaps ten years ago, the last Master came.  She came here seeking shelter from a great horde of demons; what she found was me, all alone.</i>\"");
	
	outputText("\n\nYou ask her to tell you a little about the \"<i>last Master.</i>\"  Hesitantly, she agrees: \"<i>Master came here seeking refuge.  Bound as I was, I could not help but to protect the Cathedral – and her – from the imps that pursued her.  She was a sorceress of some skill, however, and when I told her of my bonds, she manipulated the magics that control me so that I was forced to serve her.  Those same magics are why I am bound to serve you, Master.</i>\"");
	if (gargoyleConfidence() > 69) outputText("  She continues, \"<i>though even were I not compelled to, I would still serve you,</i>\" she says with a playful wink.");

	outputText("\n\n\"<i>When the last Master found me, I was not myself, however.  The coming of the demons was still vivid in my mind; the scars of their abuse weigh heavily upon me even now, yet they were crippling when she bound me.  I suppose it could have been worse – I could have been taken by a demon or a true sadist, but my time with her nearly destroyed my mind.");
	//If Confidence =<69:
	if (gargoyleConfidence() <= 69) outputText("\n\nAfter what she did to me, I cannot enjoy sex; just the thought of it makes me shudder.</i>\"");
	else outputText("After what she did to me, I never thought I'd enjoy sex again.</i>\"  With a loving smile, " + flags[kFLAGS.GAR_NAME] + " takes your hand in hers and brushes it against her cheek.  \"<i>But for you, Master, I think I could make an exception.</i>\"");
	
	outputText("\n\nYou can't help but ask... what is it that her last Master did that was so awful, that made her fear you when you first met her, and now makes her terrified of the most intimate of contact?");
	//If Confidence =<69:
	if (gargoyleConfidence() <= 69) outputText("  \"<i>I'm sorry, Master, I can't... it hurts too much to think about it.</i>\"");
	else outputText("  \"<i>Sorry, Master. I just....Don't want to talk about it right now.  Ask me again some time.</i>\"");
	
	outputText("\n\nYou consider pressing the issue, but remember that you've been away from camp a bit too long.  You resolve to ask her next time, and take your leave of the gargoyle.");
	//(Return PC to camp, advance time 1 hour)
	gargoyleConfidence(10);
	doNext(camp.returnToCampUseOneHour);
}

//[b]" + flags[kFLAGS.GAR_NAME] + " B[/b]
private function garNameB():void {
	clearOutput();
	//(Confidence +3)
	outputText("Settling in for what could be a long talk, you ask " + flags[kFLAGS.GAR_NAME] + " if she's finally ready to tell you about her last Master.  She sighs heavily, but with a bit of encouragement, she begins to speak: \"<i>Master was... an unusual specimen, I should think.  She was so very beautiful, so very gentle,</i>\" the gargoyle says, almost wistfully.");
	
	outputText("\n\nBut her voice changes, hardening into a cold whisper, \"<i>And so very cruel.  To her, I was a living toy, nothing more than a way to sate her lusts when she desired.  And she was sadistic, using some sort of shock magic on me if I so much as hesitated at her commands.  I came to dread her every word, especially her demands for pleasure – she got off on pain, I think, and thoroughly enjoyed inflicting it on me.</i>\"");
	
	outputText("\n\nYou gently shift the conversation as she trails off, asking her for, say, her master's name, or appearance.  \"<i>Ah. Master was a woman, perhaps a hair beneath six feet tall.  She was beautiful, in a dark sort of way.  It was as if she always had a kind of storm-cloud around her.  I remember... I remember she had the softest skin.  Thick, golden hair that was so smooth, so...</i>\"");
	outputText("\n\nConfused, you have to ask if she's still talking about the same person.  \"<i>Oh.  Yes, I suppose I am.  I'm sorry, Master.  I just... looking back, I get confused. I remember the pain so well, but there was so much pleasure, too.  I hated her, with every fiber of my being.  But I loved her too.  I don't miss her, and I don't dwell on the years I was her toy, but some part of me did love her, I think.  Yet I do not regret her leaving.</i>\"");
	
	outputText("\n\nYou don't need to prompt " + flags[kFLAGS.GAR_NAME] + " this time.  \"<i>She left, perhaps ten years ago.  One day I was following orders to Master's pleasure, and the next I was bound to my pedestal, wearing the chains that Master broke to set me free.</i>\"");
	
	outputText("\n\nWhile she still hasn't answered the whole of your question, you nod and move on.");
	gargoyleConfidence(5);
	talkToGargoyle(false);
}

//[b]" + flags[kFLAGS.GAR_NAME] + " C[/b]
private function garNameC():void {
	//(Confidence +3)
	gargoyleConfidence(5);
	clearOutput();
	outputText("You ask " + flags[kFLAGS.GAR_NAME] + " if she's finally ready to talk to you about what happened to her previous Master, and what happened to her since.  Hesitantly, she agrees to your request.  \"<i>Master was a dark sorceress, gifted with the skill of manipulating the bodies of others, though it caused them incredible pain.  I think... perhaps her fascination with me came from my immutability, that she couldn't change my body to her whims through her magic.  So she sought to change my mind, breaking my will and shaping me to her desires.</i>\"  With a rueful smile, she adds, \"<i>You could say that she made me the creature I am today.</i>\"");
	
	outputText("\n\nShe continues, \"<i>After Master had lived here two, maybe three years – all the while experimenting on and manipulating the monsters that came near – we were eventually visited by a demon.  Not an imp or minor monster, but a true demon of great power.  An omnibus who fancied herself a master of magic, who'd heard of Master's skill through the mangled imps that managed to crawl away after Master had had her fun.  He challenged her to a duel for her magic and her body.  Fueled by hubris, she accepted.</i>\"");
	
	outputText("\n\n" + flags[kFLAGS.GAR_NAME] + " pauses in her story, sniffling and wiping the back of her hand across her eye, even though she can produce no tears.  \"<i>I knew what would happen.  I tried to tell her.  I'd seen what demons can do, experienced their cruelty firsthand.  But I'm not even a person; my opinions don't matter.  We both knew that.  She even chained me, left me, so that I would not interfere.  And so out she went, all arrogance and bravado.</i>\"");
	outputText("\n\nShe continues, \"<i>She never stood a chance.  Master was obliterated, utterly and completely beaten.  The last I saw of her, she was being dragged away by the hair, kicking and screaming, begging for my help.  But I could do nothing.  I was helpless, I was powerless.  As always.</i>\"");
	
	outputText("\n\nShe falls silent, heaving a heavy, hopeless sigh.  You could reassure her that she isn't a helpless non-person, or perhaps you'd be better served by berating her about her emotional weakness?");
	//(Display Options: [Comfort] [Berate])
	menu();
	addButton(0,"Comfort",comfortGarNameC);
	addButton(1,"Berate",berateGargoyleC);
}

//[b]Comfort[/b]
//(Confidence +15)
private function comfortGarNameC():void {
	clearOutput();
	outputText("You pull " + flags[kFLAGS.GAR_NAME] + " onto your lap and run your hand through her hair.  You tell her that she's wrong – dead wrong.  She is a person, and she is not helpless.  She's anything but.");
	
	outputText("\n\nThe little gargoyle curls up on your lap and gives you a shy little smile.  \"<i>Thank you, Master.  I-I-I...</i>\" she stutters off, visibly trembling.  \"<i>I wish you were right, Master.  I really do.  But, I'm not.  I'm not a person, and I don't have free will.  It's a nice dream, but...</i>\"");
	
	outputText("\n\nYou cut her off right there.  You COMMAND her to stop thinking like that, telling her that you've never met anyone more human than she is.  She does have free will – and someday, perhaps she can get it back.  Until then, you promise that you would never give her an order that she didn't want to go through with, and that you would never abandon her like her last Master did.");
	
	outputText("\n\nShe smiles weakly, and rests her head on your chest.  \"<i>As you command, Master,</i>\" she says, and falls silent.  You sit there for a long while, stroking the gargoyle's soft hair and hoping you have made an impression on her.  But, eventually, you know you have to part.  You give " + flags[kFLAGS.GAR_NAME] + " a little kiss on the forehead and tell her to do whatever she wants while you're gone.");
	
	outputText("\n\n\"<i>Wha—Whatever I w-want?</i>\" she stammers, confused.  You affirm yourself, but she is slow in responding.  \"<i>I just... I only want to be with Master. I... Master, please don't go!  Just, just for a little while.  Please?  That's what I want, more than anything.</i>\"");
	
	outputText("\n\nSighing, you pat " + flags[kFLAGS.GAR_NAME] + " on the head and tell her you'd be happy to stay for a while longer.  Beaming, she asks you what you'd like to do.");
	//(Return to normal interaction menu)
	gargoyleConfidence(15);
	returnToCathedral(true);
	
}

//[b]Berate[/b]
//(Confidence -10)
private function berateGargoyleC():void {
	clearOutput();
	outputText("You laugh, and tell " + flags[kFLAGS.GAR_NAME] + " exactly what you think about her – that for a talking lump of rock, she's too damn talkative and way the hell too emotional about everything.  She sits there, very quietly, listening to your every word.  She even nods, from time to time, agreeing with you!  You're not sure if that makes you angrier or not.");
	
	outputText("\n\nWhen you're done explaining exactly what the fuck is wrong with her, you lean back and ask her what she's going to do about it.");
	
	outputText("\n\n\"<i>Be less emotional, Master,</i>\" she says, as evenly as she can.  \"<i>I won't dwell on the past anymore, Master.  I live only to serve you, of course.  What else could I do?  Please, Master, give me any command you desire.  I await them eagerly, without hesitation, my Master.</i>\"");
	
	outputText("\n\nNodding appreciatively, you think of what to tell her to do.");
	gargoyleConfidence(-10);
	//(Return to normal interaction menu)
	returnToCathedral(true);
	
}

//[b]Appearance[/b]
private function gargoyleAppearance():void {
	clearOutput();
	outputText("" + flags[kFLAGS.GAR_NAME] + " is a gray marble statue that, through magics you can't quite grasp, has been animated.");
	outputText("\n\nShe stands roughly six feet tall, with a slender, girly frame.  She wears no clothes, seemingly possessing no modesty at all, and uses her brutally spiked tail as a weapon.  She has a cute, somewhat angular face that is very feminine.  Her skin and hair are a light shade of gray, though she has solid, ruby-red eyes which ");
	if (gargoyleConfidence() < 70) outputText("glow timidly, reflecting a submissive and servile nature in the gargoyle.");
	else outputText("have a cool fire in them, showing her steadily-growing confidence and warmth toward you.");
	outputText("  Her skin is cold and smooth to the touch, a consequence of her marble material, yet she is quite soft, almost squishy.  " + flags[kFLAGS.GAR_NAME] + " has a pair of cute little horns upon her brow, and has bat-like wings sprouting from her back which give a gentle flap every few seconds, an unconscious gesture on her part as you stare at her.  She has a long, spiked tail that curls ");
	if (gargoyleConfidence() < 70) outputText("timidly");
	else outputText("playfully");
	outputText(" about her thighs.  She has two normal human legs sculpted to end in normal human feet.");
	
	outputText("\n\nShe has a pair of big, pleasingly soft D-cup breasts.  They are without nipples.");
	
	outputText("\n\nShe has a small yet easily stretched pussy between her legs, with a .2 inch clitoris.");

	outputText("\n\nShe has a tight asshole between her soft butt cheeks, right where it belongs.");
	returnToCathedral(true);
}
}
}
