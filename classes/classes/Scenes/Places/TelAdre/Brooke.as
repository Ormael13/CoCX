package classes.Scenes.Places.TelAdre {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

//  BROOKE_AFFECTION:int = 915;
//  BROOKE_SHOWERED_WITH:int = 916;
//  BROOKE_AND_HELIA_3SOME:int = 917;
//  TIMES_IN_BROOKES_BUTT:int = 918;
//  BROOKE_MEDIUM_SCENE:int = 919;
//  BROOKE_MET:int = 920;
//  BROOKE_MET_TODAY:int = 921;
//  BROOKE_GRUMPS_ABOUT_TA:int = 922;

public class Brooke extends TelAdreAbstractContent {
//Introduction
//Go to the showers; no Brooke
//Second scene
//Go to the showers; Brooke is there, but affection is too low
//Third scene
//Go to the showers; Brooke is there, and is affectionate
//	Working out
//	Gym Members
//	Her Rockin’ Bod
//	Grope
//		Penetrate Her
//		Anal
//		Tribadism
//		Down On Her
//		Get Laid
//		Double-Dicked
//Fourth Scene
//	Male Only
//	Female Only
//	Herm Only
//Talk to Heckel
//	Leave
//	Butterfly
//		Aftermath
//	Leg Press
//		Males/Herms Only
//		Females Only
//		Aftermath

public function brookeAffection(arg:Number = 0):Number {
	flags[kFLAGS.BROOKE_AFFECTION] += arg;
	if (flags[kFLAGS.BROOKE_AFFECTION] > 100) flags[kFLAGS.BROOKE_AFFECTION] = 100;
	else if (flags[kFLAGS.BROOKE_AFFECTION] < 0) flags[kFLAGS.BROOKE_AFFECTION] = 0;
	if ((player.isTaur() || flags[kFLAGS.BROOKE_SHOWERED_WITH] == 0) && flags[kFLAGS.BROOKE_AFFECTION] > 20) flags[kFLAGS.BROOKE_AFFECTION] = 20;
	return flags[kFLAGS.BROOKE_AFFECTION];
}
public function brookeCapacity():Number {
	return 60;
}

//Occurs automatically after the second time you choose to hit the showers after a workout.  From then, the choice to ‘hit the showers’ then becomes either visit the machine or to actually go to the shower.
public function meetBrookeFirstTime():void {
	clearOutput();
	outputText(images.showImage("brooke-first-meeting"));
	outputText("After yet another successful, and rewarding, workout, you begin your way down the hallways of the gym back to your favorite machine in the building.  Even after putting in so much effort, you’ve yet to finish – you still have to work <i>every</i> muscle, after all.  However, as you walk down the halls, breath still heavy and feeling the sweat drip off your brow, you pause, taking a few sniffs.  Once you’re out of the gym and into somewhat fresher air, you smell something, and it smells <i>rank</i>.  Smelling around a bit, you lift an arm and whiff your pit – it’s you!  Maybe, for once, you should actually have a wash; as you are now, the monsters would smell you long before they’d see you.");

	outputText("\n\nYou're familiar enough with the layout of the building to know that the showers are connected with the locker room.  You make your way there easily – the gym is surprisingly empty for this hour, with only a handful of other people around using some of the machines.  You make your way to the lockers first, to remove your [armor], stripping down to nothing, and grabbing a towel to wrap around your body.  You don't really expect anyone to be there in the showers before you, but the sound of running water as you approach tells you otherwise.");

	outputText("\n\nThe closest shower stall is occupied as you enter the room, but the running nozzle shuts off just as you approach, and from it emerges a canine morph, choosing to leave the stall as it scrubs its fur gently with its towel.  As you approach, it pauses its soft drying, cocking its head up, having heard your footsteps.");

	outputText("\n\nIt’s a female, going by the curves of her hips and the swell of her breasts, and she's maybe around six feet tall or so.  Her coloration makes her look like one of the Shepherd breeds you had back at Ingnam: mostly tan and black, with a thin streak of white going straight down her front.  She has light brown hair – or is it more fur? – starting between her ears and going back down to her shoulders.  She has deep, enrapturing brown eyes and the fur on her muzzle is totally black.  Her form is very curvaceous, and although it’s difficult to gauge underneath her heavy, wet fur, you ballpark her breasts to be roughly C-cup.  She has a long, bushy tail, going down to her calves.  Most impressively about her is her definition: while she's not a mountain of muscle, you can make out each flex and tense of her arms and shoulders.  Every muscle is tight and firm; not bulging, but proudly displayed.  She could probably grate cheese with her abs, too.");

	outputText("\n\nYou stare, admiring her body, for far longer than you mean to.  She stares back, not bothering to conceal her form, noting the sweat still pouring off you, and eventually, she breaks into a well-meaning smile.  \"<i>New to the gym, honey?</i>\" she asks, her voice feminine but a little gruff.  It breaks you out of your stare, and you hope she doesn’t mind your, uh, ‘admiration’ too much.");

	outputText("\n\nYou blink, processing that she asked you a question and is expecting an answer.  You reply that you’ve been here a few times before, and try to mask your abject staring by saying you don't remember if you've ever seen her before, and you were just trying to remember if you ever had.  It's a terrible lie and her knowing grin just spreads wider.  You clear your throat, ");
	if (player.isNaga()) outputText("coil your tail nervously under yourself");
	else outputText("shuffle your [feet]");
	outputText(", and say that you're just about to shower yourself.  She steps aside, dropping the towel off her head and wrapping it around her body (almost teasingly), allowing you to pass.  \"<i>Plenty of stalls to pick from,</i>\" she laughs, and you thank her, walking on and avoiding eye contact.");

	outputText("\n\n\"<i>Hey,</i>\" she says, and you turn to face her.  \"<i>Now that you mention it, I don't think I've ever seen you here before either.  My name's Brooke.  Got a name, sweet thing?</i>\"  She extends her right hand as she says her name, and you accept her handshake and reply with your own name.  It was weird – for looking so physically strong, her grip felt oddly limp.  \"<i>Well, it's nice to meet you too, [name],</i>\" she says, withdrawing her hand before you can think any more about it.  \"<i>You know, it's not often I get such a nice compliment on my body.  I put a lot of work into it; is it too much to ask for a little ogle now and again?</i>\"  She laughs, patting you on the shoulder.  You relax, thankful that she didn't take your staring too badly.");

	outputText("\n\nShe stands back, running her eyes up and down your body, checking you out, getting a good read on what's not covered by your towel.  ");
	if (player.tone <= 20) outputText("She twists her mouth a bit, while otherwise trying to keep a straight face.  You suddenly feel awfully self-conscious – maybe you should watch what you eat a bit more closely, and come to the gym more often.  \"<i>Well, uh, enjoy your shower,</i>\" she says haltingly, before walking past you without another glance.");
	//if {Tone >= 21} {Tone <= 50}
	else if (player.tone <= 50) outputText("She looks a bit, nodding approvingly after a while.  For some reason, you feel slightly relieved that she considers you, if nothing else, adequate.  \"<i>Nice,</i>\" she compliments.  \"<i>Keep it up, hot stuff.  It's hard, believe me, but it pays off.</i>\"  She walks past you, towards the lockers, giving up a single glance on her way by.");
	else if (player.tone <= 80) outputText("She smiles, more to herself than to you, and bites her lower lip, drinking in every detail she can pick out.  You see her grin and you tense, but not because you're nervous.  \"<i>Awesome stuff, sexy,</i>\" she says, maybe a little huskily.  \"<i>That is one hot model you got yourself, if you don't mind me saying.</i>\" You assure her that no, you really don't.  She keeps chewing her lip as she walks past, admiring everything she sees.  Boldly, she reaches out and squeezes your bicep, giggling to herself before she turns and walks away.");
	else outputText("At first she smiles, her eyes constantly roving, but the longer she looks, the more her smile melts away.  By the end of her 'evaluation', her face is mostly straight – maybe even a little disapproving.  \"<i>Rock hard all over, are you?</i>\" she asks rhetorically, and starts walking by you.  \"<i>Hey, whatever you like.  You got a sweet body and you should be proud.</i>\" She continues walking on, eventually leaving the shower room entirely. This was far from the reaction you were expecting, after you put so much effort into your body.");

	outputText("\n\nYou watch her walk down the hallway, her features hidden behind the towel as she turns into one of the locker rooms.  You remove the towel and take a stall, turning the dials to start the nozzle and feeling the water rush over you.  Your idle thoughts occasionally drift to Brooke and you imagine the amount of work she must have done to get such an amazing body.  The water is cold, keeping you from wanting to stay and soak, but by the time you’re dry and your [armor] is back on, you feel like a new Champion.");


	//Brooke can now be encountered.  After each workout, the player has the option to either go to the sex machine, or to actually hit the showers.  Brooke sticks to a somewhat realistic schedule and isn't available all hours of the day – she can be encountered in the showers between 16:00 and 18:00.  She can only be met once a day.
	//Brooke has an affection meter after the first meeting, and will rise with every additional encounter.  For males and herms, the meter rises by 4 per encounter – for females, it rises by 3.  It caps at 70.
	brookeAffection(5);
	flags[kFLAGS.BROOKE_MET_TODAY] = 1;
	flags[kFLAGS.BROOKE_MET] = 1;
	doNext(camp.returnToCampUseOneHour);
}

public function repeatChooseShower():void {
	clearOutput();
	if (model.time.hours < 16 || model.time.hours > 18 || player.tone < 30) {
		//Before 16:00/after 18:00, affection <= 19
		if (brookeAffection() <= 19) {
			outputText("You head your way back to the showers, feeling the sweet ache of your muscles as you easily find your way there.  The showers are completely empty when you arrive.  On the one hand, you enjoy having the place to yourself and taking your time, but on the other, you can’t help but feel a little disappointed that the Shepherd girl Brooke wasn't there to greet you.");
			outputText("\n\nYour shower proceeds uneventfully, and just a short while later, you're clean as a whistle and out the door.");
			outputText("\n\nFor some reason, you have a hunch that you might bump into her again in the later afternoon or early evening hours...");
		}
		// Before 16:00/after 18:00, Affection >= 20, <= 39
		else if (flags[kFLAGS.BROOKE_MEDIUM_SCENE] == 0) {
			outputText("You head your way back to the showers, feeling the sweet ache of your muscles as you easily find your way there.  The showers are completely empty when you arrive.  You've met with Brooke enough times to know her schedule, and while you enjoy her company, sometimes you feel like you don't actually get enough done while you're together.  You have some stains and smells you'd like to wash out.");
			outputText("\n\nYour shower proceeds uneventfully, and just a short while later, you're clean as a whistle and out the door.");
		}
		// Before 16:00/after 18:00, Affection >= 40, <= 70
 		else {
			outputText("You head your way back to the showers, feeling the sweet ache of your muscles as you easily find your way there.  The showers are completely empty when you arrive.  You know exactly when Brooke will and won't be in the shower, and you've specifically chosen to avoid her this time.  As fond as you are of her and as fun as the sex is, you've been leaving the shower dirtier than when you've gone in!  It'd be nice to actually get clean this time.");
			outputText("\n\nYour shower proceeds uneventfully.  While the cleanliness is nice, occasionally a rogue wish wants her to show up and 'ruin' your shower time.  Brooke is nowhere to be found, though, and just a short while later, you're clean as a whistle and out the door.");
		}
		doNext(camp.returnToCampUseOneHour);
		player.changeFatigue(-5);
	}
	//Between 16:00 and 18:00
	//Third encounter; body tone 30 minimum
	else if (flags[kFLAGS.BROOKE_GRUMPS_ABOUT_TA] == 0 && player.tone >= 30) {
		brookeThirdEncounter();
	}
	//Affection <= 19
	else if (brookeAffection() <= 19) {
		lowAffectionBrookeMeeting();
	}
	else if (brookeAffection() <= 39 && flags[kFLAGS.BROOKE_SHOWERED_WITH] == 0) {
		mediumLowBrookeAffectionOneTime();
	}
	//Affection >=40, after first-time sex
	else if (brookeAffection() >= 40 && flags[kFLAGS.BROOKE_MEDIUM_SCENE] > 0) {
		mediumBrookeAffectionMeetingAfterSex();
	}
	else if (brookeAffection() >= 40 && flags[kFLAGS.BROOKE_MEDIUM_SCENE] == 0 && player.tone >= 50 && (player.hasVagina() || player.cockThatFits(brookeCapacity()) >= 0)) {
		mediumAffectionOneTimeEvent();
	}
	//Haven't fucked brooke yet.
	else if (brookeAffection()) {
		mediumLowBrookeAffection();
	}
}

//Third encounter; body tone 30 minimum
public function brookeThirdEncounter():void {
	clearOutput();
	outputText("You head your way back to the showers after stopping at the lockers to store your [armor].  You wonder to yourself if you'll see Brooke there again.  She seems like the fond, friendly type, and you both have at least one mutual interest, after all.  If nothing else, she's certainly not hard on the eyes.");
	outputText("\n\nYou walk into the showers, hearing one of the stalls going.  As you enter, you see Brooke, her head just poking over the walls of the stall, busy gently scrubbing at her fur.  You can't tell from your distance if she uses a shampoo or anything.  Again, you're both alone, and one of her ears perks up as she hears you approach.  She whips her shoulder-length hair back, swiping the water from her eyes, as she turns to your direction.  <i>\"Oh, hey [name],\"</i> she says, giving you a warm smile.  <i>\"How's it hanging today?\"</i> You answer that, so far, it's been more of the same, and she nods affirmatively.  She resumes her shower wordlessly while you take your own stall – you choose to take the third one down, leaving one between you in case she'd prefer the privacy.  You remove your towel and start the nozzle.");
	outputText("\n\n<i>\"So, [name],\"</i> she says casually, going back to gently rubbing the water underneath her fur.  <i>\"Where ya from?  How'd you get to Tel'Adre?\"</i>  You decide to give her the short version: you're from a faraway place called Ingnam.  You found your way to Tel'Adre from wandering aimlessly in the desert for a bit, and were lucky enough to come across the city before a naga's den or something.  You consciously choose to leave out the whole 'Champion' business.  <i>\"Ingnam, huh?  Never heard of it. Must have been quite the journey from there to here.\"</i>");

	outputText("\n\n<i>\"Oh, it wasn't so bad,\"</i> you say.  You ask her about herself: where she's from, what she does for a living, and how long she's been working out.");

	outputText("\n\n<i>\"Little ole' me?\"</i> she asks, trying to seem playful about it, smiling at you wryly.  <i>\"Born and raised here in Tel'Adre.  My ma's a Shepherd, like me, and my pa's a horse, like that Cotton gal you might have seen in the gym sometimes.  Put 'em together and you get a fiercely loyal guard dog that wants to be as strong as a horse.  Been working out since I was just a pup, once they said I was allowed.  Got a dumbbell for my sixth birthday.  Strong enough to lift ten of them now, but I still have it at home.\"</i>");

	outputText("\n\nPutting two and two together, you venture to ask if Brooke's part of the Tel'Adre Watch.");

	outputText("\n\nShe responds by starting to scrub a little harder.  <i>\"I was.\"</i>  'Was'? Before you ask her about that, she grunts in frustration – or maybe in pain? – then shuts off the nozzle to her shower.  Was she trying to avoid that question from the beginning?  <i>\"Good talking to ya, [name], but I don't want to burn any more of the gym's water.\"</i>  She's already hard at working towelling off and is busy heading towards the door, spinning around to face you as she leaves, hiding her features underneath her towel.  <i>\"I'll see you some other time, all right?\"</i>  And just like that, she's gone.");

	outputText("\n\nThe rest of your shower is cold and uneasy.  Have you done something wrong?");
	brookeAffection(5);
	flags[kFLAGS.BROOKE_GRUMPS_ABOUT_TA] = 1;
	doNext(camp.returnToCampUseOneHour);
}

// Between 16:00 and 18:00, Affection <= 19
public function lowAffectionBrookeMeeting():void {
	clearOutput();
	outputText("You head your way back to the showers, feeling the sweet ache of your muscles as you easily find your way there.  Brooke is there, already rinsing the day's work out of her muscles.  She hears you coming in, and turns to give you a warm greeting, which you happily return.");

	outputText("\n\nThe shower goes by smoothly, the both of you talking idly about whatever happens to come to mind.  Learning from your previous encounter, you try to keep the topics away from Tel'Adre while still asking her about herself, and answer her own questions about yourself whenever she asks.  All in all, things go by rather well, and once again she leaves the showers before you, giving you a wave before she leaves.");
	outputText("\n\nYour shower proceeds uneventfully, and just a short while later, you're clean as a whistle and out the door.");
	doNext(camp.returnToCampUseOneHour);
	brookeAffection(5);
}

// Between 16:00 and 18:00, Affection >= 20, <= 39, body tone 40 minimum, one-time event
public function mediumLowBrookeAffectionOneTime():void {
	clearOutput();
	outputText("Another good workout and another fine sheen of sweat to wash off.  The day hasn't been so bad so far, and you start to whistle to yourself as you head to the showers, dropping your [armor] off in a locker beforehand.  Glancing out one of the windows, you guess that Brooke ought to be there around this time of day; and as you approach, you hear the sounds of rushing water.  Sure, it could actually be someone else, but you have a feeling it's the Shepherd girl.");

	outputText("\n\nSure enough, there she is, although she's looking a little... melancholy.  She's staring down at her feet, letting the water rush over her body, not really moving or anything.  One of her ears perks as she hears you coming, and she turns to face you.  <i>\"Oh,\"</i> she sighs, <i>\"hey, [name].\"</i>");

	//[if (isTaur = true)]
	if (player.isTaur()) {
		outputText("\n\nYou ask her if everything's all right – she's usually much more upbeat and relaxed than this. She's usually the one who starts the conversation. She looks back down, not immediately answering, before drawing her head back and taking a deep breath through her nose.  <i>\"I have a favor to ask,\"</i> she says.  You wait patiently for her to ask it, when, face clouding, she seems to reconsider.  <i>\"Never mind,\"</i> she says eventually, resuming her wash.  <i>\"It's not a big deal.  I'm a big girl; I can handle it myself.  So, how has your day been so far?\"</i>");
	outputText("\n\nThe shower proceeds as it normally would, although you can't really get what she was about to ask you out of your head.  As usual, she leaves before you, leaving you curious and somewhat unfulfilled.");
	outputText("\n\nMaybe it was something personal, and you're just not her type?");
		// (Brooke's affection now caps at 20 until the PC is no longer a centaur.  This scene will re-proc until this condition is met, and then will proceed normally)
		doNext(camp.returnToCampUseOneHour);
	}
	//[if (isTaur = false)
	else {
		outputText("\n\nYou ask her if everything's all right – she's usually much more upbeat and relaxed than this.  She's usually the one who starts the conversation.  She looks back down, not immediately answering, before drawing her head back and taking a deep breath through her nose.  <i>\"I have a favor to ask,\"</i> she says.  <i>\"We don't really know each other out of the gym, so this is going to seem really forward, okay?\"</i>  You nod, patiently waiting for what she's going to ask you.  <i>\"I... well, could you... wash my back?\"</i>");

		outputText("\n\nThat's all?  That's not so bad.  Just a friend innocently washing another friend's back.  Still, you could refuse her request, if you'd rather.  What do you do?");
 		//[=Help=][=Don't help=]
		menu();
		addButton(0,"Help",helpBrookeOut);
		addButton(1,"Don't Help",dontHelpBrookeShower);
	}
}
// [=Don't help=]
public function dontHelpBrookeShower():void {
	clearOutput();
	outputText("You say that she's right, and that you don't really know each other well enough to share a shower together, even if it's as innocent as just washing each other's hard-to-reach places.  <i>\"Yeah, okay,\"</i> she sighs again, going back to scrubbing hard at her fur.  You take your usual place two stalls down, and while you try to make conversation with Brooke, she's just not that into it.  The rest of the shower is mostly awkward silence, and as usual, she leaves before you do.");
	outputText("\n\nYour shower proceeds uneventfully, and just a short while later, you're clean as a whistle and out the door.");
	//(Brooke's affection resets to zero)
	flags[kFLAGS.BROOKE_AFFECTION] = 0;
	doNext(camp.returnToCampUseOneHour);
}

// [=Help=]
public function helpBrookeOut():void {
	clearOutput();
	outputText("You assure her that asking for help washing her back isn't such a big deal at all, and is in fact kind of refreshing.  In a world where rape is as common as a 'hello', just a friendly wash is a breath of fresh air.  She smiles and thanks you, as you drop the towel and enter into her stall, picking up a small bar of soap and start running it over the moist fur of her back as you both stand under the running water.");

	outputText("\n\nIt's tempting to go slowly with Brooke's fur – this is the first time you've got a 'hands-on' experience with her and you just want to admire the body she's put so much effort into.  You try to go at a steady pace, though: she only asked for a wash, and you don't want her to get the wrong idea...");
	if (player.hasCock()) outputText(" and being so close to such a woman, you find it difficult to keep [eachCock] from getting too excited");
	outputText(".");

	outputText("\n\nThe wash is silent at first, almost uncomfortably so, as you get to work getting your fingers underneath her fur.  It's not very long, but it's not very short either; it takes some work getting the soap in underneath her fur, but not nearly as hard as she frequently made it out to be.");

	outputText("\n\nEventually, Brooke, as she usually does, is the first to start the conversation.  <i>\"Hey, [name],\"</i> she starts.  <i>\"You asked me once before if I was in the Tel'Adre watch, right?\"</i>  You confirm, but you remind her that she seemed rather evasive of the subject and assure her that she doesn't need to talk about it if she doesn't want to.  <i>\"Oh, no, that wasn't because of... well, it wasn't <b>entirely</b> because of the watch.  I don't have any bad blood with them or anything.\"</i>  You remain silent.");

	outputText("\n\n<i>\"I used to be a guardswoman for the watch.  I had the nightshift.  Stood on the walls, looking out over the desert, every other night.  Kinda boring, in hindsight,\"</i> she chuckles.  <i>\"But it was what I wanted to do, ever since I was a little girl.  Tel'Adre was my home, my territory.  Had to keep out the undesirables, eh?");

	outputText("\n\nWell, a few months ago now, we had made a standard arrest.  Some fox-morph fella thought he could get clever by cheating the local pawn shop outta some gems.  Whatever, 'nother day and all that.  Turned out he had some buddies already in the jail, though, and they were trying to make a jailbreak while we were busy with this other guy.  In broad daylight!  They were some wily little shits, I'll say.\"</i>");

	outputText("\n\nYou continue gently working the soap into her fur as she speaks, not saying a word.  <i>\"That feels good,\"</i> she compliments.  <i>\"Way better having someone else do it.  Scrubbing gets tiring pretty quick.\"</i>  You thank her for the kind words and ask her to continue.");

	outputText("\n\n<i>\"Yeah, well, like I said, it was daylight.  I was just wearing my civvy clothes; no gear, no weapons or anything.  I just happened to be nearby when I saw them half a block from the jailhouse.  I rang the bell, called for help, and tried to hold each of them off.  I was doing pretty well at it, too, as a matter of fact.\"</i> She sounded awfully prideful at that last part, and she flexed her shoulders in showmanship.  You 'mm-hmm' appreciatively.");

	outputText("\n\n<i>\"Well, it didn't last long.  One of them got a lucky hit; knocked me off my feet.  I scrambled up and got both my hands on the hem of the tunic on one of the runners.  Wouldn't let go, no matter how much he struggled.  Just as the other guards were comin', he pulled out a pair of daggers and...\"</i>");

	outputText("\n\nHer back still to you, she lifts up both her hands for you to see.  Across the back of each is a huge scar, going from her thumb to the knuckle on her little finger.  It looks awful, even though it's fully healed.  You try not to wince.");

	outputText("\n\n<i>\"They all wound up getting away.  Couldn't use my hands for weeks after that.  Doctors told me I wouldn't be able to grip much – definitely not a sword or a shield.  Need both hands to even grip a goblet of beer.  A goblet, not a mug.  It takes quite a bit of doing to turn the shower on and off.  The watch let me go; said they couldn't risk my well-being if I couldn't properly defend myself.\"</i>");

	outputText("\n\nYou've finished washing her back and her shoulders a while ago, but you didn't want to interrupt her.  You're nearly halfway done with the second go when she finishes her story, taking a bit of a pause before saying anything more.  <i>\"I don't hold it against 'em,\"</i> she eventually says.  <i>\"Woulda done the same if I was in Captain Urta's shoes.  My only regret is not being in a position to defend my home anymore.  Well, that, and, I just wish that one fox guy didn't get away.  So I didn't lose my hands for nothin'.\"</i>");

	outputText("\n\nIt's only another moment later when Brooke stretches her arms, spinning on the spot to face you.  Her arms wrap around your neck as her dark muzzle leans in close, and her breasts press softly onto your [chest].  <i>\"Thanks, sweetheart,\"</i> she says quietly, her deep brown eyes looking almost longingly into your own.  <i>\"Best wash I've had in a long while.  And... for listening.  Don't get to let that story out too often.\"</i>  Before you have a chance to respond, she closes the gap, planting a kiss on your lips.  No tongue, and not for long, but there was undeniably some passion in the quick motion.  <i>\"Might ask for some more help some other time.  Your fingers are magic.\"</i>");

	outputText("\n\nShe spins you both around, grabbing her towel on the stall's wall and wrapping it around her upper body, swaying her hips as she leaves, knowing you're watching.  You stand there, staring at the doorway for a bit, ");
	if (player.gender == 1) outputText("not caring about the stirring in [eachCock] in the privacy of the stall");
	//[if {PC is female}]
	if (player.gender == 2) outputText("feeling a fire stoke in your [vagina] even under the constant water");
	if (player.gender == 3) outputText("your loins beginning to stir, each and every part of you enticed");
	outputText(" as you replay the memory of the Shepherd girl's taut, firm ass swaying, just for you.");

	outputText("\n\nBy the time she's long gone, the water is beginning to cool.  You've spent far too long in the shower as it is.  You quickly wash what you can before leaving the showers and fetching your gear, leaving the gym for now.");
	// (Lust increased by 15)
	dynStats("lus", 15 + player.lib/20, "resisted", false);
	flags[kFLAGS.BROOKE_SHOWERED_WITH] = 1;
	brookeAffection(4);
	doNext(camp.returnToCampUseOneHour);
}

// Between 16:00 and 18:00, Affection >= 20, <= 39
public function mediumLowBrookeAffection():void {
	clearOutput();
	outputText("After another workout session, you head back to the showers, stopping at the lockers to set down your [armor] and to grab a towel.  You hear the sound of rushing water as you approach and, as usual, you find Brooke in her usual stall.  She's busy lightly scrubbing at her fur, but she easily picks out the sound of your footsteps over the water.  <i>\"Hey, [name]!\"</i> she says, turning to face you with a smile.  <i>\"Right on time, sweetheart.  I could use some company to talk to.  Care to hear a gal pal out?\"</i>");

	outputText("\n\nYou tell her that you'd be glad to.  You step into the stall next to her, lathering up your hands and begin to rub the suds into your [hair].  She finishes doing the same to her own, before crossing her arms over the wall of the stall between you, facing you with a smile.  She waits patiently while you lather yourself – you could take this opportunity to start the conversation yourself, for once.");

	outputText("\n\nWhat do you talk about?");
	//talk menu here
	menu();
	addButton(0,"Working Out",talkWithBrookeAboutWorkingOut);
	addButton(1,"GymMembers",talkToBrookeAboutGymFolks);
	addButton(2,"Her Bod",brookesRockinBod);
	if (brookeAffection() >= 40 && brookeAffection() <= 70 && flags[kFLAGS.BROOKE_MEDIUM_SCENE] > 0) addButton(3,"Grope",gropeDatBrooke);
}
//Between 16:00 and 18:00, Affection >=40, after first-time sex
public function mediumBrookeAffectionMeetingAfterSex():void {
	clearOutput();
	outputText("After another workout session, you head back to the showers, stopping at the lockers to set down your [armor] and to grab a towel.  You hear the sound of rushing water as you approach and, as usual, you find Brooke in her usual stall.  She's busy lightly scrubbing at her fur, but she easily picks out the sound of your footsteps over the water.  <i>\"Hey there, sexy!\"</i> she calls, turning to face you with a smile.  <i>\"You're just in time.  The water's plenty warm, but my stall is getting cold.  Care to help warm it up?\"</i>");

	outputText("\n\nYou tell her that you'd be glad to.  You step into her stall, lathering up your hands and getting to work rubbing the suds into her sore shoulders.  She moans and leans into your touch, letting your now-practiced hands work their magic on her.");
	outputText("\n\nShe remains quiet while you continue to massage her shoulders, letting the warm water wash over you both.  You're no stranger to taking this opportunity to start the conversation yourself, and you begin to think of a topic to talk about.");
	outputText("\n\nWhat do you talk about?");
	//talk menu here!
	//[=Working Out=] [=Gym Members=] [=Her Rockin Bod=] [=Grope=]
	menu();
	addButton(0,"Working Out",talkWithBrookeAboutWorkingOut);
	addButton(1,"Gym Members",talkToBrookeAboutGymFolks);
	addButton(2,"Her Bod",brookesRockinBod);
	if (brookeAffection() >= 40 && flags[kFLAGS.BROOKE_MEDIUM_SCENE] > 0) addButton(3,"Grope",gropeDatBrooke);
}

//[=Working Out=]
public function talkWithBrookeAboutWorkingOut():void {
	clearOutput();
	outputText("You ask Brooke how she manages to work out, given her condition.  You can understand the legs and the washboard abs, but she's still packing more heat in her arms and shoulders than most people do in their bodies.");

	outputText("\n\n<i>\"Well, thanks for that compliment!\"</i> she says jovially.  <i>\"It's nice to hear someone finally recognize all my hard work.  But anyway, your question.  Yeah, working my stomach, ass and legs are the easy part.  Working arms, though, that's where the, uh...\"</i> she pauses, looking at her hands and flexing her fingers.  She must not like thinking about it too much.  <i>\"That's where the challenge is.\"</i>");

	outputText("\n\nShe turns her face to the showerhead while she explains.  <i>\"First, nothing involving hands.  Dumbbells, barbells, bench-presses, squats, deadlifts – all out, even with a spotter.  If it weighs more than just a few pounds or so, I can't lift it with one hand.  Working biceps and forearms was a bit of a hurdle, but with some experimentation, I found a way around my... 'condition.'");

	outputText("\n\nSee, they all have the same basic principle as a 'Sled Drag'.\"</i>  She sounds very enthusiastic about explaining her methods.  You just smile and let her carry on, legitimately interested in what she has to say.  <i>\"In a Sled Drag, you tie a few straps around your body and you pull something really heavy across the ground.  What I do instead is tie those straps around the part of my arms I want to work out.\"</i>  She makes circling motions around her tough biceps, demonstrating the results of her hard work.  <i>\"It's not as effective as some good ole' fashioned lifting, but it does work.  And if I get creative, I can do most workouts, too: bent-over rows; shoulder-fly's and chest-fly's...and things like the butterfly machines are still fine for me to use.\"</i>");

	outputText("\n\nShe goes on for a while, listing all the ways she's managed to keep to her regime even without her hands, with you soaking it all in.  She has some impressive ideas and some interesting methods – you're even tempted to try some of them out yourself some time.  When she's done, you take the chance to ask her another question.  Why does she work out?");

	outputText("\n\n<i>\"Does anybody really need a reason?\"</i> she asks rhetorically.  <i>\"I do it because it makes me feel good; it gives me energy...  hell, it just makes me feel alive, all in all.  Sure, I won't be winning any arm-wrestling competitions or any fistfights, but, well, that's why this canine is learning K-1.\"</i> She smiles at you expectantly, proud of her apparent pun and hoping you ask her what K-1 is.  So you do.  <i>\"It's a form of kickboxing.  It originated in some far away land – not positive where – and the biggest difference between K-1 and Tel'Adre kickboxing is the legal use of knees.\"</i>");

	outputText("\n\nYou ask her one more question.  What does she do for a living?  <i>\"Well, like I said, I used to be a guardswoman for the city.  But after my injury, I had to take up a couple of odd-jobs to get by.  I tried working at the bakery, but that flopped when I couldn't knead the dough.  Blacksmith?  Out.  Retailer?  Nope.  Working with dresses wasn't really my 'thing' either.  I was on the track, thinking about it, when I realized: hell, why not a fitness instructor?  Pulled some strings, talked to some people... and now here I am, teaching other people how to be fit.\"</i>");

	outputText("\n\nEventually, the water begins to run cold, both of your bodies having been thoroughly cleaned but enjoying each other's company.  <i>\"Oh, darn,\"</i> she says suddenly, noticing how cold it's gotten.  She turns to look you in the eye.  <i>\"That's my fault, [name], I got a little too excited and we've wasted all the hot water.\"</i>");

	outputText("\n\nYou assure her that it's fine – you're both clean, at the very least.  You say she should apologize to whoever comes in after you two.  You both shut off your water and leave the stalls, going to your towels.  <i>\"You're a great listener,\"</i> she tells you, walking in close, draping her towel over her shoulder, and then over yours, pulling you in for a tender, lingering kiss on your cheek.  She lingers just for a moment before leaving, tracing one hand over your [hips], teasingly close to ");
	if (player.gender == 1) outputText("[eachCock]");
	else if (player.gender == 2) outputText("your [vagina]");
	else outputText("[eachCock]");
	outputText(".");

	outputText("\n\n<i>\"I'll see you when I see you, hot stuff,\"</i> she says, glancing back to you as she wraps her towel around her upper body.  She leaves the room, wagging her tight, toned ass, just for you, as she leaves.");

	//[if {Brooke's Affection <= 39}
	if (brookeAffection() <= 39) outputText("\n\nSharing a shower with a naked girl just a few feet away is an unusual experience.  Of course, though, you're certainly not complaining – Brooke's an interesting girl, and she takes very good care of herself physically.  You enjoy her company.");
	else outputText("\n\nThat damn Shepherd knows all of your buttons and all your weaknesses.  Every shower, she teases you in just the right ways, and it gets harder and harder to not just fuck her there in the stall.  Not that she'd mind, you're sure... but, it's a game you two play.  She likes pushing your limits, knowing that, when that limit breaks, it'll be a much harder workout than anything the gym could give her.  Which is something you both wouldn't mind.");
	// (Lust increases by 10, Int increases by 1 with a cap of 50)
	dynStats("lus", 10, "resisted", false);
	if (player.inte < 50) dynStats("int", .5);
	brookeAffection(4);
	doNext(camp.returnToCampUseOneHour);
}

//[=Gym Members=]
public function talkToBrookeAboutGymFolks():void {
	clearOutput();
	outputText("You ask about what she thinks of the other gym members.  Surely she's seen them as often as you have, given how frequently she visits the place.");
	outputText("\n\n<i>\"What, you mean, like, personality wise?  If they're my type?  Hot-or-not?  What do you mean?\"</i>  You chuckle, saying you probably could have been more specific, but now that she mentions it, why not all three?  <i>\"Well, hey, why not?  You invite a girl to talk, and she'll talk.");

	outputText("\n\nThat centaur lady who owns the place is an all right sort, I guess.  Never really paid much attention to her.  I pay for my lifetime membership and she leaves me be.  Got a nice rack on her, but truth be told, I'm not the biggest fan of centaurs.  I know how racist that sounds and everything, and I even hate myself for admitting it, but...  I don't know; I think it has to do with my pa being a horse-morph.  It just looks unsettling to me.");

	//[if {met Cotton}]
	if (flags[kFLAGS.COTTON_MET_FUCKED] > 0) outputText("\n\nSpeaking of: Cotton, that horse-morph gal?  Cute as a button, sexy as a... well, as a big-titted ten-outta-ten.  Not really into that flowery yoga stuff, though, that's just not my style, and she's not into lifting the heavy stuff, so we don't really cross paths much.  I'd jump her bones if I didn't know that her horsecock of hers would split me in half.");

	//[if {met Heckel}]
	if (flags[kFLAGS.MET_HECKEL] > 0) outputText("\n\nHeckel's way too competitive and dominant.  I just wanna lift some weights, and she takes that as a personal challenge or something, and tries to outlift me.  Well, us Shepherds aren't too taken with being submissive, so I gotta outlift her right back.  Occasionally, we make it into competitions: whoever wins is the dom for the day, and whoever loses is the sub.  In the end, really, we both win – she's a damn good fuck either way – but it's more the principle of the thing.  We go more-or-less even, although she'd probably tell you otherwise.");

	//[if {had Heckel/Brooke threeway between one and three times}
	if (flags[kFLAGS.BROOKE_AND_HELIA_3SOME] > 0 && flags[kFLAGS.BROOKE_AND_HELIA_3SOME] < 4) outputText("\n\nHeckel's still just as competitive as always.  I walk into the gym and do my warmups, and there's the bitch, challenging me to something right off the bat.  Lately our 'games' have been going on a bit longer, and the 'aftermath' has been getting a lot more energetic and intense.  Don't tell her I said this, but that stuff we say, about one of us just wanting to fuck the other?  Usually that's just dirty, dominant talk, and I can't really speak for her, but, sometimes...");
	//[if {had Heckel/Brooke threeway between four and six times}
	else if (flags[kFLAGS.BROOKE_AND_HELIA_3SOME] > 3 && flags[kFLAGS.BROOKE_AND_HELIA_3SOME] < 7) outputText("\n\nHeckel takes some getting used to, but she's actually an all right gal if you can prove you're on her level.  She takes working out very seriously and is quick to prove her superiority and dominance against anyone she thinks might threaten her status as 'alpha', but you can just fuck her a couple times and she'll calm right down.  Lately, she's actually been flirting with me – don't tell anyone I said this, but Heckel is the cutest thing ever when she's flustered.  I think she might be into me... you know, romantically.  And you know what?  I think I might be into her, too.  As long as she's into open relationships, of course.");
	//[if {had Heckel/Brooke threeway seven times or more}
	else if (flags[kFLAGS.BROOKE_AND_HELIA_3SOME] > 6) outputText("\n\nHeckel's actually a pretty sweet girl if you take the time to get to know her out of the gym.  I mean, sure, <b>in</b> the gym, she's a huge control freak and an asshole to work with, but if you can get her out of it, you'd be surprised how relatable of a person she could be.  I should know; we're dating, so I've had the chance to see her softer side.  Sex with her is a marathon, as always, and we're both as aggressive as you've seen us, but mutual satisfaction is a priority with us both, so it's always its own reward.  Our relationship is very open, but we always wind up coming back to each other at the end of the day.");

	//[if {met Ifris}]
	if (flags[kFLAGS.MET_IFRIS] > 0) outputText("\n\nIfris is a creeper.  Just hangs around the gym, watching everyone lift some weights or doing some laps or whatever.  She finds a cutie hard at work, then she makes 'em feel real good with all her sweet-talk, and then <b>bam!</b>  Getting laid on the benchpress.  I love when people notice my body, but the way she stalks like a predator around the gym just kind of gives me the creeps.");
	//[if {met Jasun}
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00179] > 0) outputText("\n\nYou know Jasun, the shark guy?  Hard as a rock, in every place, if you know what I mean.  Huge narcissist, if you ask me, which puts me off.  Big difference between admiring yourself and others admiring you.  I'm not a big fan of zero-percent-body-fat types, either – being fit and healthy and solid is great and a big turn-on, but being all muscle and all business is no fun, you know?  Kind of tough cuddling with a rock.  Besides, not a big fan of the taste of fish anyway.");
	//[if {met Loppe}]
	if (flags[kFLAGS.LOPPE_MET] > 0) {
		outputText("\n\nI've seen that bunny-girl show up a whole lot lately.  She's a pretty nice gal, all in all – lives and looks after her mom and wants to take up the family business, or something.  Whatever; she's got a smoking hot body and a face cute enough to give me cavities.  She fucks like a truck and cums like a geyser, too, which is always fun.");
	}
	//[if {met Lottie}]
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00281] > 0) {
		outputText("\n\nAs for Lottie, that little piglet chick... not the first of her 'body-type' to wander into the gym, and won't be the last.  Love seeing guys and gals like her – success stories in motion.  If you got the drive, you got the will, then you'll get the results.  She works for it, she works hard, but she's really indecisive and easy to put-off in front of company.  With the right push I can see a girl like her being the hottest thing on the block.");
	}
	outputText("\n\nAnd, uh... that's all the members, off the top of my head.\"</i>  She thinks to herself for a moment, humming, before her eyes light up.  <i>\"Oh wait,\"</i> she says softly, smiling, crooking her right index finger at you, gesturing you to approach the stall wall.  You oblige. <i>\"I forgot one.\"</i>  With deliberate slowness, she hooks her arm around your neck and pulls you to her.  She plants a long, lasting kiss on your lips, leaning into you, pressing herself against the wall.  She doesn't open her mouth, but her lips are nonetheless very active as she gets into it, letting her hands roam around your shoulders and upper back.  You lovingly reciprocate her every action.  Too soon, she pulls away, saying <i>\"there's my opinion of you, sweet thing.\"</i>");

	outputText("\n\nJust as the water begins to run cold, she grabs her towel off the opposite wall of her stall with one hand, and turns the showerhead off with the other.  She wraps the towel over her upper body as she leaves the room, wagging her firm, incredible ass, just for you, as she leaves, leaving alone in the showers to finish up.");

	//[if {Brooke's Affection <= 39}]
	if (brookeAffection() <= 39) outputText("\n\nSharing a shower with a naked girl just a few feet away is a little unusual.  Of course, though, you're certainly not complaining – Brooke's an interesting girl, and she takes very good care of herself physically.  You enjoy her company.");
	//[if {Brooke's Affection >= 40}]
	else outputText("\n\nThat damn Shepherd knows all of your buttons and all your weaknesses.  Every shower, she teases you in just the right ways, and it gets harder and harder to not just fuck her there in the stall.  Not that she'd mind, you're sure... but, it's a game you two play.  She likes pushing your limits, knowing that, when that limit breaks, it'll be a much harder workout than anything the gym could give her.  Which is something you both wouldn't mind.");
	// (Lust increases by 15)
	dynStats("lus", 15, "resisted", false);
	brookeAffection(4);
	doNext(camp.returnToCampUseOneHour);
}

//[=Her Rockin Bod=]
public function brookesRockinBod():void {
	clearOutput();
	outputText("You say that you recall her talking about wanting to get buff since a young age.  She even got a dumbbell for one of her birthdays, you recall.  What pushed her to want to become such a pinnacle of modern-day fitness?");

	outputText("\n\n<i>\"Ooh, keep talking sweet things, sweet thing,\"</i> she moans, her eyes drifting dreamily closed.  <i>\"I love it when a " + player.mf("guy","girl") + " notices all my hard work.\"</i>  She stops, expecting you to keep admiring her body, when you remind her that you asked her a question first.  <i>\"You did?  Oh, right!  Why I... yeah, why I work out.");
	outputText("\n\nWell, if you remember that I got a dumbbell for my birthday, then you probably remember that my pa was a horse.  I really looked up to my pa; sweetest pa that ever lived, I'll have you know.  I always loved how he could lift my whole bed all by himself, or how he could lift me onto his shoulders with just one hand.  Always wanted to be able to do those things myself, to lift like no other Shepherd could lift, to one day give my own kids that sort of thrill.\"</i>");

	outputText("\n\nShe stops, looking sadly down at her hands, and you wonder if you should tell her that it'd be okay if she stopped now.  She continues before you can.  <i>\"Being part horse, even if it doesn't really show on the outside, kinda helped, I guess.  Always had this urge to be as strong as one, and being a dog wasn't about to stop me.");

	outputText("\n\nThen, puberty happened.  I started looking at friends, old and new ones, in a different light.  Guys and gals.  Kept judging them by their appearance – even stopped hanging around some good people just because they didn't meet my physical standards.  We were all young and dumb once.  Eventually, I came to realize that if I started looking at people by their physical appearance, than they were probably doing the same to me.  So I doubled up my efforts; tried to make myself as sexy as I could.  Wanted people to want me; to be with me.");

	outputText("\n\nJust before adulthood, I realized too late that not everybody wants a girl who could crush them with her thighs, so I dialled it back a bit.  Be fit, be sexy, be healthy – but don't be a mountain.  Don't be intimidating.  I could easily be twice as big as I am now, but, well, I want to be as strong as I am sexy; too much of one and I'm not enough of the other.  It's a bit of a balance, and I'm very happy with what I am now.\"</i>");

	outputText("\n\nThat was quite the answer, but she mentioned something interesting.  'Guys and gals', you ask?  <i>\"Yeah.  I swing both ways, but I have a preference for men.  Being fit is the biggest turn-on: monster dicks and tits out to the mountains don't really do it for me.  How deep a guy can go before bottoming out is less impressive than how long he can last, since having a tool as long as your arm is either what you're born with, or you cheated by eating some peppers or something, but being able to fuck for hours – all night, even – is an <b>achievement</b>, something that <b>deserves</b> praise and attention.  And having a tight bod is indiscriminate to genders, so I don't care what you're packing as long as you're hot stuff.\"</i>");

	outputText("\n\nAt that, Brooke's deep brown eyes lock onto yours, and she gestures for you to approach her.  You comply, never breaking eye-contact – she stares deeply, intently, as she leans in, wrapping both her arms around your neck, pulling you towards her own stall.  Her hands lock onto your shoulders.  <i>\"And you,\"</i> she says, her face dangerously close to yours, her hands gliding seamlessly down to your shoulder-blades, <i>\"you have one hot bod.  You work for it; you want it.  And that,\"</i> she says, her hands travelling all over what body she can reach and cooing at all the muscles she feels, <i>\"makes me want you.\"</i>  She plants a kiss on your lips – brief, mouth closed, passionate.");

	outputText("\n\nShe lingers for just a bit, before pulling away.  The water was beginning to turn cold after running for so long.  <i>\"Thanks for the compliment, sweet thing,\"</i> she says, reaching for her towel on the opposite stall wall.  <i>\"Can't wait until next time.\"</i>  With that, she turns off the water and wraps the towel over her upper body as she leaves the room, wagging her tight, firm ass, just for you, as she leaves you alone in the room.");

	//[if {Brooke's Affection <= 39}
	if (brookeAffection() <= 39) outputText("\n\nSharing a shower with a naked girl just a few feet away is a little unusual.  Of course, though, you're certainly not complaining – Brooke's an interesting girl, and she takes very good care of herself physically.  You enjoy her company.");
	//[if {Brooke's Affection >= 40}
	else outputText("\n\nThat damn Shepherd knows all of your buttons and all your weaknesses.  Every shower, she teases you in just the right ways, and it gets harder and harder to not just fuck her there in the stall.  Not that she'd mind, you're sure... but, it's a game you two play.  She likes pushing your limits, knowing that, when that limit breaks, it'll be a much harder workout than anything the gym could give her.  Which is something you both wouldn't mind.");
	//(Lust increases by 15)
	dynStats("lus", 15, "resisted", false);
	brookeAffection(15);
	doNext(camp.returnToCampUseOneHour);
}

//[=Grope=]
// Affection >= 40, <= 70, after first-time sex, raises lust by 30
public function gropeDatBrooke():void {
	clearOutput();
	outputText(images.showImage("brooke-grope-her"));
	outputText("Brooke has an amazing body and she knows it.  She consciously chose to flaunt it in front of you by asking you to 'wash her back'.  The tightness of her muscles; the upright perkiness of her breasts; the taut, flawless features of her thighs... you bet if you smacked her ass, it'd be like slapping clay.");
	//[if (hasCock = true)]
	if (player.hasCock()) outputText("  You can only imagine what it could feel like to drive your [cock] between those cheeks, just inches away from you.  The thought makes [eachCock] rouse.");
	outputText("  The tension is beginning to get a little unbearable and your resolve wavers.");

	outputText("\n\nDutifully, you start with her shoulders, easing your way across and down to her lower back.  Slowly but surely you work your way outward, wrapping around to her ribs.  She freezes, but doesn't object.  You press your luck, resuming forward, to the top of her belly, then pressing upward, working your way onto the swell of her C-cups.");

	outputText("\n\nJust as you begin to feel the plushness of her tits, she leans back into you, forcing your hands to wrap around her tits suddenly.  <i>\"Feeling a bit frisky, love?\"</i> she asks, reaching up with both her arms and wrapping them around your neck.  She begins grinding her toned, firm ass against ");
	if (player.hasCock()) outputText("[eachCock]");
	else {
		outputText("your pelvis");
		if (player.hasVagina()) outputText(" and dragging her wet tail enticingly through the vulva of your [vagina]");
	}
	outputText(".  <i>\"I'm game.  Hope you're ready, though; you're gonna need more than a few laps around the track to keep up with me.\"</i>");

	outputText("\n\nYou narrow your eyes determinedly and, with a grin, you accept her challenge.");
	dynStats("lus", 33, "resisted", false);
	outputText("\n\nWhat is your weapon of choice?");
	//[=Penetrate her=] [=Anal=] [=Tribadism=] [=Down on her=] [=Get laid=] [=Double-dicked=]
	menu();
	if (player.hasCock() && player.cockThatFits(brookeCapacity()) >= 0) addButton(0,"Penetrate",penetrateBrooke);
	if (player.hasCock()) addButton(1,"Anal",brookeAnal);
	if (player.hasVagina()) addButton(2,"Tribadism",tribadism);
	addButton(3,"Go Down On",goDownOnBrooke);
	if (player.hasCock() && player.cockThatFits(brookeCapacity()) >= 0) addButton(4,"Get Laid",getLaidByBrooke);
	if (player.cockTotal() >= 2) addButton(5,"Double-Dick",doubleDicked);
}

//[=Penetrate her=]
//Requires at least one penis
public function penetrateBrooke():void {
	clearOutput();
	var x:int = player.cockThatFits(brookeCapacity());
	if (x < 0) x = player.smallestCockIndex();
	var y:int = player.cockThatFits2(brookeCapacity());
	outputText(images.showImage("brooke-gym-male-penetratebrooke"));
	outputText("You rub your " + player.cockDescript(x) + " in the cleft of her toned ass, the water from the shower lubing you both up.  Brooke coos, pressing her butt into you, enjoying the feel of you hot-dogging her, grinding and humping along with each of your teasing thrusts.  You press and grip her tits, loving how the water in her fur makes them feel squishy and plush with each ministration.  She loves the feeling just as much, and turns her head to the side, silently asking for a kiss.");

	outputText("\n\nYou oblige, pressing your lips to hers, running your tongue through her lips and over her own.  It's difficult to multitask between frotting her luscious asscheeks, playing with her pert C-cups, and lovingly making out with the hot Shepherd girl, but you get by, with some help: Brooke moves with you, humping, pressing, and kissing, making sure you never miss a beat.");

	outputText("\n\n[EachCock] rises, engorging with your lust, and it doesn't take long at all until you're ready to fuck Brooke properly.  You release one of her breasts, tickling your fingers down her stomach and her abdomen, over her pelvis and ultimately sliding one into her tunnel, feeling the eager heat and hearing the pleasured woofs of the dog before you.  Your other hand releases her other breast, and she whines pleadingly, feeling your other fingers slide down her side and grip onto her ass, squeezing hard and pressing the one cheek against your still-humping phallus.");

	outputText("\n\nHaving enough, you pull your mouth away from hers and lean your crotch back, repositioning your cock against her mons.  She tenses, remaining perfectly still, her tail standing straight up her back in preparation for your penetration, which you teasingly hold back on for the moment.  You instead start frotting her once more, dragging your hard, ready cock against the fire of her pussy, and the sound of her whimpering just makes you harder.  <i>\"Please,\"</i> she eventually whispers, her body shivering in anticipation.  You comply, lining yourself up once more, and push forward, penetrating into her tight, welcoming pussy.");

	outputText("\n\nBrooke leans forward and rests her arms on the stall, sighing in pleasure and backing her ass into your crotch.  You thrust into her gently, getting yourself reacquainted with the unique feel of her tight pussy – she has such control over every one of her muscles, and she's really using that to her advantage here.  You grope along her shapely thighs, getting a good feel for her body once more, and tighten your fingers over whatever flesh yields to them.  You start to rut her properly, fucking her at a casual pace, both of you still a little burnt from your workouts.");

	outputText("\n\n<i>\"Oh yeah,\"</i> she moans, wrapping as much of her tail around your torso as possible, matching your steady pace and humping back up against you.  <i>\"Nice and slow, baby, mmm... just like that.\"</i>  You reply by leaning into her, pressing your [chest] against her back and kissing at her neck while you keep up your fucking");
	//[if (cocks >= 2)]
	if (y >= 2) outputText(".  Your " + player.cockDescript(y) + " rubs up and down the crack of her ass lamely, though the way she clenches against you with every inward thrust makes every sensation worth the effort");
	//[if (isHerm = true)
	if (player.gender == 3) outputText(".  Your [vagina] pulses longingly, jealous of the attention you're giving to Brooke's own, and hungers for something to suffocate the fire built inside it");
	outputText(".  She moans appreciatively with you some more, loving the feel of your " + player.cockDescript(x) + " in her.");

	outputText("\n\n<i>\"Grab my boobs again,\"</i> she requests; far be it from you to turn her down.  Your hands raise, sliding through her wet fur, past her strong lats and up to her breasts, spreading your fingers and clamping down on them as she asked.  She coos in response, and you begin to knead and play with her tits, every little action getting a different response.  With your left hand, you flick her nipple between each of your fingers, while you pinch and pull the other with your right, massaging her chest sensually.  She lets go of the stall wall and leans fully into you, pressing her back into your [chest], and giving you more room to play with.");

	outputText("\n\n<i>\"That's it,\"</i> she says lowly, loving the way you treat her body.  She seems to get off as much on you touching and feeling her muscles that she's worked so hard on as she does the actual sex.  The more you feel her, the tighter she pulls you in, rocking her hips into you and taking her time letting you go.  The water from the shower slowly grows colder, but you can tell from the heat not only at your crotch but also");
	if (player.balls > 0) outputText(" across your [sack] and");
	outputText(" down your thighs that she's getting wet enough for the both of you all the while.");

	outputText("\n\nHer body jerks with everything you do to it: out, into your hands while you play with her tits, and onto your " + player.cockDescript(x) + " with every thrust into her tight tunnel you make.  Her whines and sighs quickly begin to rise and quicken, and with a few louder grunts, she cums onto you, clamping her cunt on you like a vice and doing her very best to coax everything out of you");
	if (player.balls > 0) outputText("r [balls]");
	outputText(".  You're not too far behind her, and with just a few more pumps, you're shooting your load deep into her, pumping and fucking the whole time, making sure to get it in deep.");
	if (y >= 0) outputText("  Your " + player.cockDescript(y) + " shoots its own load up and onto her lower back and the base of her tail, snug between the cheeks of her ass");
	//[if (cocks >= 3)
	if (player.cockTotal() > 1 && y >= 0) outputText(" while [eachCock] sprays your jizz all over the place: the floor and the walls of the small stall in particular, but also on her ass, onto her tail, and down her legs.  Most of it washes into the drain beneath you, but it'll definitely take a bit of scrubbing for her to get really clean after this.");
	//[if (cocks = 2)
	if (player.cockTotal() == 2 && y >= 0) outputText(".");
	if (player.gender == 3) outputText("  Your [vagina] cums along with the rest of you, spurting your femcum down your legs, washing the inside of your thighs in your juices.  The combined pleasure between your genitals makes your knees buckle – if only you had something, or someone, fucking you too!");

	outputText("\n\nYou two stay there, standing under the cold shower nozzle, basking in the glow of each other post-coitus.  You begin to slide out when she clenches hard onto your " + player.cockDescript(x) + ".  <i>\"Just a minute longer,\"</i> she says, and you don't fight her.  You simply enjoy each other for a while, your stiff tool resting in her, and her just relaxing in your embrace.  Eventually, you soften and slip out, and she relents.  <i>\"Good as ever, sweet thing,\"</i> she says, and you return the compliment, giving her a loving, lingering kiss on her neck.");

	outputText("\n\nYou two spend the next few minutes keeping each other warm in the frozen cold shower water while you finish cleaning up.  You get to drying each other off, flirting and groping some more, but it doesn't progress any farther than that.  She kisses you one last time after you slip on your [armor], and you both leave the gym, looking forward to next time.");
	//Lust reduced to zero.
	player.orgasm();
	dynStats("sen", -2);
 	brookeAffection(10);
	doNext(camp.returnToCampUseOneHour);
}

//[=Anal=]
//Requires at least one penis
public function brookeAnal():void {
	clearOutput();
	var x:int = player.cockThatFits(brookeCapacity());
	if (x < 0) x = player.smallestCockIndex();
	var y:int = player.cockThatFits2(brookeCapacity());

	//[if {cockFit >= 61}
	if (player.cockArea(x) >= 61) {
		outputText("Bluntly, you ask Brooke what her opinion is on anal.  <i>\"What, with you?\"</i> she asks, leaning her ass back and trapping your " + player.cockDescript(x) + " between her asscheeks expertly.  You moan with pleasure, but before you get the wrong idea, she hums disapprovingly.  She was actually using her ass to measure your " + player.cockDescript(x) + "!  <i>\"Sorry, sweet thing, but maybe not this time.  I just got in from the gym, and working a beast like that into my ass would be a workout in of itself.  I'm up for anything else, though.\"</i>");
		//Go back to 'grope' menu
 		menu();
		addButton(4,"Back",gropeDatBrooke);
		return;
	}
	//[if {first time}]
	if (flags[kFLAGS.TIMES_IN_BROOKES_BUTT] == 0) {
		outputText("\n\nBluntly, you ask Brooke what her opinion is on anal.  <i>\"What, with you?\"</i> she asks playfully");
	}
	//[if {not first time}]
	else outputText("\n\nRemembering how hard on you she was last time, you're almost hesitant to ask, but the allure of her sweet, toned ass is too strong.  You ask her if she's up for some anal.  She doesn't answer – instead, she smiles greedily");
	outputText(", leaning her ass back and trapping your " + player.cockDescript(x) + " between her asscheeks expertly.  You moan with pleasure while she glides her globes up and down, feeling your manhood rise and swell with each bob.  Your hands are already on her butt, clenching the skin hard together while you thrust in the space between her buttocks.  <i>\"Well... all right.  But only because I like you so much.\"</i>");

	outputText("\n\nYou grip onto her hips, dragging your " + player.cockDescript(x) + " through the crack of her ass, working yourself up further before you jump right in.  Thanks to the shower, you're both lubed up well enough - just what you were both waiting on.  Brooke leans into the wall of the shower stall, bracing herself while trying to keep herself relaxed, waiting for you to make your move although it's difficult; the thought of taking you up her ass is making her a little short of breath.");
	//[if {first time}]
	if (flags[kFLAGS.TIMES_IN_BROOKES_BUTT] == 0) outputText("  You wonder – is this the first time she's ever had anal before?");
	else outputText("  She's tight as a vice, but you know she can take you.  She's just getting herself ready.");

	outputText("\n\nThe " + player.cockHead(x) + " of your " + player.cockDescript(x) + " rubs against her rosebud in anticipation");
	if (player.cockTotal() > 1) outputText(" while your other member entertains itself between her thighs, bumping and sliding pleasurably across her vulva");
	outputText(".  She instinctively clenches her ass, and you give her a moment to relax before you stroke her there again.  She loosens, and, almost teasingly now, you prod gently at her hole, implying but not acting just yet.  She takes deep breaths, working to steady herself.  <i>\"Okay,\"</i> she says, looking over her shoulder to you with a smile.");

	outputText(images.showImage("brooke-gym-male-analbrooke"));

	outputText("\n\nYou plan to take it easy on her.  You realign yourself, pointing your " + player.cockHead(x) + " right at her hole, and slowly begin to push yourself in.  On reflex, she inhales sharply, pressing her upper body into the wall some more.  You reassure her and push in a little deeper, sliding a quarter of your " + player.cockDescript(x) + " into her anus.  She gasps, but doesn't object.  Another push, sliding in to halfway.  A grunt, and she shuffles her feet slightly, getting more stability.  Another push, nearly to the base.  She gives out a whorish moan, and you wonder if she's at her comfort limit.  You push forward anyway, to your [sheath], and gasp in pleasure and sigh with relief when she doesn't object.");

	outputText("\n\nYou stay still for a moment, basking in the heat of her ass as she completely takes your " + player.cockDescript(x) + ".  The ring of her sphincter pulls and tightens around you, dragging the skin of your cock with each movement, and her inner muscles clench and massage every fiber of your hard meat.  You shuffle a bit, when Brooke interrupts you.  <i>\"Just a sec,\"</i> she says, rocking her hips some more, this way and that, trying to get a good feel for your dick in her ass.  You let her take her time – it's her ass you're fucking.  She eventually shuffles into a comfortable standing position, and with a nod, gives you the go ahead.");

	outputText("\n\nYou pull out to halfway, the water making the fuck tantalizingly tight without making it painful.  When you push back in, Brooke moans with the thrust, allowing herself to get pushed forward with your force.  Out, back to halfway, and back in, feeling every one of her muscles ripple and shudder with your hump.  Out, to three quarters, and back in: Brooke gasps out, lowering her head, focusing on the feeling.");

	outputText("\n\nYou begin to fuck her right, thrusting into her at a nice and easy pace.  Brooke doesn't make many noises, but eventually, her plain, unreadable grunts of exertion turn into feminine gasps of pleasure.  You take that as your cue to speed up your thrusts a little, and before long, she's bucking back against you, enjoying the ride herself.");

	outputText("\n\nEvery pleasured gasp from her is an invitation to fuck her harder, one you take gladly.  Soon enough, you're fucking her well, thrusting into her like a piston, loving the feel of her toned, strong booty in your hands and around your dick with the water refreshing your lube with every outward swing.  Brooke presses her body forward into the stall wall, her cheek pressed flat against it, her eye locking onto you.  She 'huhs' with every shove you make into her, and she matches your every blow, fucking you right back.");

	outputText("\n\n<i>\"Little harder,\"</i> she asks, when you're already going about as hard as you can.  You sacrifice a bit of speed for power as you plunge harder into her, spearing her anus apart with your " + player.cockDescript(x) + ", driving yourself harder into her.  She relents more space, practically crawling herself up the wall, and you continue to go up to your ");
	if (player.balls > 0) outputText("[balls]");
	else outputText("[sheath]");
	outputText(", burying yourself into her voracious ass.  With her body climbs her voice: a few pumps more and her moans become wails, loud enough that you're sure someone else must have heard.");
	if (player.cor >= 45) outputText("  With any luck, that someone will come to investigate – you're sure it wouldn't take much convincing to start a party.");

	outputText("\n\n<i>\"Harder!\"</i> she demands, thrusting her ass back onto you.  You're not sure how much harder you can go");
	if (player.cockTotal() >= 2) outputText(".  Any one of your dicks that's not inside her is battering painfully around her ass as she continues to hit you with it, making it harder to focus on fucking her this way");
	outputText(".  <i>\"<b>Harder!</b>\"</i> she yells, almost viciously.  You just keep going, hoping that she won't notice you can't fuck her ass any harder; your orgasm isn't much farther off as it is, and you hope that Brooke's isn't either.  Her voice continues to rise even as she continues to make unreasonable demands, until finally, her words taper off into simple screams, and she orgasms, the wall, her inner thighs, and her lower stomach splattering with her cum.  Her anus squeezes down on your member, making it all the more difficult to keep up brutalizing her ass.");

	outputText("\n\nThe muscles in her ass ripple and tighten, snapping around your cock, seemingly wanting to keep you there.  It's a fight to keep fucking her, but from how she keeps gasping with every thrust, she's thankful you are.  Your cum boils");
	if (player.balls > 0) outputText(" in your [balls]");
	outputText("; your cock stiffens");
	if (player.gender == 3) outputText("; your lonely pussy clenches at nothing");
	outputText("; and you cum into her, blasting rope after rope of your jism inside her.");
	if (player.cockTotal() > 1) outputText("  Your second dick flails and erupts with your " + player.cockDescript(x) + ", spraying onto the wall in front of Brooke and across the lips of her sex.");
	//[if (cocks >= 3)]
	if (player.cockTotal() > 2) outputText("  [EachCock] blasts in time with your " + player.cockDescript(x) + ", each of your dicks pointing in a different direction.  Your cum gets on everything: Brooke, yourself, the stall – some even reaches as high as the shower nozzle.");

	outputText("\n\nYou both pant from the rigorous sex, and when you're both finished, you collapse onto Brooke's back, exhausted.  You weren't expecting her to take so much out of you.  <i>\"Wow,\"</i> she finally manages to say, catching her own breath.  ");
	//[if {first time}]
	if (flags[kFLAGS.TIMES_IN_BROOKES_BUTT] == 0) outputText("<i>\"I never knew anal could be such a thrill!  We'll have to do that again sometime!\"</i>  You chuckle politely but deep down you're almost dreading your next anal session with her.  You'll have to build up your stamina some more to keep up with her.");
	else outputText("<i>\"Thanks for putting up with me being such a bossy bitch, [name].  But it's your fault, you know.  You're the one who awakened the anal-hungry monster within me.\"</i>  You're aware of the beast you've created, you tell her, but truth be told, since your first session, it's been a bit easier to keep up with her.  She's just that good of a workout partner.");

	outputText("\n\nWith some reluctance, she eventually lets go of your spent, flaccid cock, conceding momentary defeat.  The water's long-since turned cold, and you spend the remainder of your time together washing and drying each other off.  She does all she can to entice you some more – she fondles your " + player.cockDescript(x) + " and kisses your neck sensually, eager for some more anal-play, but you're just too worn from her earlier energy.  She pouts, but gives in, finally allowing you to slip on your [armor] and leave the gym in peace.");
	//Lust reduced to 0, fatigue increased by 15
	player.orgasm();
	player.changeFatigue(15);
	flags[kFLAGS.TIMES_IN_BROOKES_BUTT]++;
	brookeAffection(10);
	doNext(camp.returnToCampUseOneHour);
}

//[=Tribadism=]
//Requires a vagina
public function tribadism():void {
	clearOutput();
	outputText(images.showImage("brooke-gym-female-tribadism"));
	outputText("You fondle her full breasts, wet and heavy from the shower water beating down on them.  She moans and leans into your touch as you squish and fondle her flesh, flicking and pinching at her nipples.  You bend your head down and start kissing at her neck – trying to avoid getting any fur sticking to your tongue.  She loves it, and drags her ass over your pelvis some more, humping against");
	//[if (isHerm = true)
	if (player.gender == 3) outputText(" your [cock], impishly wishing it were put to use.  You have some other plans this time, though.");
	else outputText(" your " + player.skinFurScales() + ".  The tone of her ass almost makes you wish you had a dick to fuck her with, but you're sure she'll give you a hell of a ride all the same.");

	outputText("\n\nOne hand leaves her breast, going down her stomach and tracing every one of her abs, and you sigh longingly, for effect – you know how she loves it when people notice her body.  It has an effect on her, and you can feel her press harder into you, and tighten the hold she has around your neck while you continue to kiss her.  Your hand travels lower, to her lower stomach, then to her waist, and, unceremoniously, you shove a finger into her pussy.  She moans gently and bucks her hips just a little, rocking them on your finger, wanting you to go just a little deeper for her.");

	outputText("\n\nYou don't, though.  You thrust only up to your second knuckle, and you sporadically use your thumb to diddle her clit, making her jump and 'ah!' whenever she doesn't expect it.  You take your mouth off her neck and your other hand off her breast, to guide her face towards yours, and you kiss.  Your tongues meet and play in each other's open, ravenous mouths; you both curl and wrap around each other, feeling each other tense and squirm in the other's mouth.");

	outputText("\n\nYour fingers continue to tease her: your index thrusts gently and shallowly into her pulling cunt, and you start to use the others to stroke and caress her vulva, pinching her lower lips between the lengths of your digits.  She groans into your mouth at your treatment, and her tongue spazzes and tenses over and over again.  She eventually breaks the kiss and looks you in the eye, her own eyes seductively narrowing and her mouth curled into a sexy grin.  <i>\"Just some foreplay today, [name]?\"</i> she asks, roiling her hips into your touch.  <i>\"You're sure you're not up for anything a bit more adventurous?\"</i>");

	outputText("\n\nYou respond by removing your hand from her pussy.  She almost looks hurt, longing for your fingers to come back.  You surprise her by spinning her around by the shoulders and pressing her back up against the wall of the stall.  Your left hand travels down her lats and her stomach, coming to a rest on her ass, while your right simply slaps down hard on her other cheek.  You step into her, lifting her left leg up, and she gets your idea, wrapping it around your waist and pulling you in closer.");

	outputText("\n\nYou close the gap between your bodies, pressing your [chest] into Brooke's own set of tits; pushing your stomach against her tight six-pack; and sliding your [legs] between her thighs until your [vagina] comes into delicious contact with hers.  You both gasp slightly and you keep mostly still for a moment, only jostling a little to draw out the stimulation.  Brooke takes the initiative, and, with a long, sensuous drag, slides the lips of her tight pussy up and across yours, over your [clit]");
	if (player.gender == 3) outputText(" and all the way to the base of your now-straining, pre-leaking cock");
	outputText(".");

	outputText("\n\nThe electrifying feel snaps you out of it.  You hump her right back, drawing your genitals up and across hers, loving the way she bites her bottom lip from the feel.  Her arms slide down to your own [butt], gripping your cheeks for some leverage");
	if (player.tone >= 50) outputText(", and she coos sexily, gripping and pulling at each of your toned, chiseled asscheeks, even giving one as hard a slap as her hand can manage");
	outputText(".  You start to fuck against her in earnest, pressing and pumping, sliding and bucking against her, loving and living for the sounds and expressions she makes as you love her the way only another " + player.mf("woman","'woman'") + " can.");

	outputText("\n\n<i>\"Fuck yeah!\"</i> she enthuses, spurring you harder into action.  You lift her by her ass, speeding up your fucking, rutting against her vulva with your own [vagina] as quick and as hard as you can.  There's nothing gentle about it: the way your two clits kiss against each other with each upswing sends waves and demands from your [clit] to your head, and you eagerly obey them");
	if (!player.hasCock()) outputText(".  Brooke moves her hands up to your tits, her hands groping onto your [chest], her palms pressing onto your [nipples] mindlessly, and her tongue lolls and flags with each buck up against her you make");
	//[if {is not a herm and is lactating}
	if (!player.hasCock() && player.lactationQ() >= 200) outputText(".  Your milk streams from your [chest] as Brooke puts more of her weak pressure on them: it sprays from between her fingers and drips down the back of her hands on across her wrists");
	if (!player.hasCock() && player.hasFuckableNipples()) outputText(".  Feeling the texture of your [nipples] under her hands snaps her out of her reverie enough to think to stimulate you further by pressing into each with a thumb, fucking into and against you with each of your excited thrusts");
	outputText(".");
	if (player.hasCock()) outputText("  Brooke moves one hand to your [chest] and wraps her other around your stiff [cock], pumping it in time with your thrusts against her.");

	outputText("\n\nWith your whole body heaving into each of your thrusts, it's not long before you're brought to your peak.  Your moan with an animalistic abandon, pressing forward, letting your [vagina] kiss with hers one final time as your juices gush forth, coating and soaking into hers");
	if (player.gender == 3) outputText(".  Your [cock] explodes along with its sister, spurting your cum high between your pressed bodies, coating the underside of your breasts and your stomachs, but mostly onto Brooke, who keeps your flow pointed towards her as she pumps you");
	else outputText(".  Brooke continues to drive against you as she mauls your breasts, using whatever strength is in her fingers to grope what she can, eager to reach her own peak not far off");
	outputText(".  Brooke's moans rise and climb in her own ecstasy, until she climaxes along with you, returning the favor and spraying your crotch with her fluids, coating your [vagina] with her own gift.");

	outputText("\n\nYou continue to thrust against each other for a bit, but eventually you wind down");
	//[if (isHerm = true)]
	if (player.gender == 3) outputText(" and [eachCock] goes limp");
	outputText(" from all the excitement.  Brooke's body shudders several times, feeling several miniature orgasms rip through her, until finally, she opens her eyes and meets yours.  Without a sound, she pulls forward, making out with you once more, shamelessly gliding her tongue over yours.  <i>\"Leave it to a girl to know how to fuck another so well,\"</i> she smiles, rubbing against you some more for emphasis");
	if (player.gender == 3) outputText(".  <i>\"Lucky for me, we won't always have to choose.\"</i>  She gently strokes your waning erection some more, releasing you when the [cockHead] touches down on her skin limply");
	outputText(".");

	outputText("\n\nYou use what's left of the shower water to clean yourselves of your lovemaking, and then you take turns playfully drying each other off.  You start to feel the familiar heat rise in your loins from the way she works your towel on you, and from the way she acts, you don't doubt she's getting randy again herself.  Sighing, you cut her off – you have other things to do today, unfortunately.  She understands, and before you know it, you have your [armor] back on and you're out the door.");
	//Lust reduced to 0, fatigue increased by 15
	player.orgasm();
	dynStats("sen", -2);
	player.changeFatigue(15);
	brookeAffection(10);
	doNext(camp.returnToCampUseOneHour);
}

//[=Down on her=]
public function goDownOnBrooke():void {
	clearOutput();
	outputText(images.showImage("brooke-gym-goDown"));
	outputText("With your right hand, you fondle at her breast, kneading it gently and enticingly, squashing the nipple in the palm of your hand, while with your left, you scratch and rake your fingers across her abs, feeling every crest of every muscle.  She giggles at your tickling and moans at your groping, leaning more of herself into you with each passing moment.  Impishly, you ask her in a dull whisper if she's got anything to eat.");

	outputText("\n\nBrooke's eyes open, and, after a confused moment, turns her head and says <i>\"what?\"</i> with a dumb expression.  Hoping to be a bit clearer without making it obvious, you narrow your eyes and you lick your lips lavishly.  It takes her another second before she catches your meaning.  <i>\"Oh!\"</i> she nearly yelps, <i>\"uh... yeah, I... yeah.\"</i>  Although you can't tell, you're sure she's blushing, unable to come up with anything witty on the spot, and you laugh, kissing her lovingly on the cheek.");

	outputText("\n\nYou slide your left hand down to her pelvis, quickly coming to her vagina.  You stroke her gently and rub the butt of your palm across her clit, playing with your food.  Her breath catches and she jerks just slightly into your open hand, her body begging for more but you're not quite ready to give it to her.  Instead, you reach across her chest with your right hand, groping her other tit and using your forearm to press into her chest.");

	outputText("\n\nShe sighs and practically melts into your body, loving every touch and every twitch your fingers make to her delicate folds.");
	//[if (hasCock = true)
	if (player.hasCock()) outputText("  [EachCock] begins to fill with your desire, desperate to replace your fingers, and it takes no small amount of willpower to deny yourself.");
	outputText("  You tease her entrance by barely slipping your finger in, just a centimeter or so; she responds by tensing when you enter and groaning when you leave.  Your other hand lowers, dropping to her stomach and kneading at her muscles there instead, knowing how much she loves it when her 'hard work' gets appreciated.");

	outputText("\n\n<i>\"Quit it,\"</i> she moans, one of her own hands going down to her crotch.  You expect her to push you in; to end your teasing with her satisfaction, but to your surprise, she actually pushes you away.  <i>\"I'm horny enough as it is.  Fuck me with your face if you're gonna already.\"</i>  You're a bit surprised, but not really, at her forwardness, and you smile.  With a rough twist, you spin Brooke around, and shove her against the wall of the stall.");

	outputText("\n\nDespite what she just said, you don't immediately drop to your knees: you instead dive into her and kiss her passionately, sending her tongue and yours on a parade with each other, while you use your fingers to caress the muscles on her hamstrings and her glutes.  She sighs into your mouth, and you feel her exhale more deeply the more you stroke her powerful muscles.  You could probably make her cum just by making out with her abs, but you hunger for something tastier.");

	outputText("\n\nYou release her mouth and pull your tongue down her collarbone, tasting her (and her wet fur) with each motion you make.  You bend at the legs rather than your back as you're brought level to her nipple, flicking and suckling on it for just a moment before you're drawn farther down.  Your pass by her belly – your earlier idea flickering for a moment longer – and down to her bellybutton, pursing your lips on it for a moment.  Down you continue, passing her waistline, and you make one more drawn out lick, going from just above her clit to the bottom of her stomach.  She arches her back and thrusts out her hips in response, wanting you to get started already.");

	outputText("\n\nYou comply, and you drop to your knees with a thud, pressing the flat of your tongue tightly against her button.  She hisses and arches some more, and her knees buckle, while you don't even move.  You wait until she's calmed down a bit before you lick upwards slowly, dragging your tastebuds across her clit, being careful not to overstimulate her too quickly.  From the sound of her voice, your efforts pay off, and she just groans and shudders above you ferociously.  <i>\"Fuck,\"</i> she breathes, and she places her hands in your [hair], weakly trying to pull you into her crotch.");

	outputText("\n\nYou lower yourself and plant your lips on her vulva, looking up to her eyes, finally beginning to deliver your promised lay.  You give your tongue a bit of a break, kissing and suckling on her vulva, reaching as deeply into her slit as you can go with just your face.  She yips appreciatively: you move without much direction, opening your lips to cover as much of her quim as you can, giving her the most lewd kiss you can manage without your tongue.  While you can't tell how wet she is because of the water, the heat from her sex and the scent of her heady, thick musk is totally undeniable, ");
	if (player.hasCock()) outputText("and [eachCock] pulls forward, pointing towards her like a compass to magnetic north, leaking your pre at her scent and ready to fuck her, or something, anything.");
	else outputText("and you find yourself salivating – such a viable, powerful specimen like herself has you wishing you had a dick to fuck her with.");

	outputText("\n\nShe moans and rocks her body to her own rhythm, and you go with her, gripping onto her rock-hard calves and quadriceps.  Your upper lip brushes up and across her clit while your lower simply stimulates her.  Her hands grip onto your ears and drag through your [hair] while she moans like a whore and grooves like an actress, and you're part co-star and part prop.");

	outputText("\n\nYour tongue has had enough of a break.  It darts forward, splitting into her quickly, and you're suddenly assaulted with her taste, coating every inch and nuance of your tongue.  Her pussy clenches on your invading muscle, imprinting itself and its taste on your tongue, while Brooke gasps above you and her fingers tighten on your scalp.  It takes some effort to free yourself from her cunt, but you manage.");

	outputText("\n\nYou start down low, reaching as far between her legs as you can, the tip of your tongue just barely slipping across her taint.  Her powerful thighs clench around you as you draw in and up, pushing in deep between her lips once more, and ending at her clit, giving it a long flick.  Brooke removes one of her hands, instead using it to play with her tit while she looks down at you lustfully.  You've never turned your eyes away, though she sometimes tosses her head to the side in her ecstasy while you continue to go down on her.");

	outputText("\n\nTwisting your tongue, you drill back into her, wiggling and swishing your tongue in her honeypot, loving how her face contorts and her body wriggles with your every motion.  She humps and fucks into your face, and your hands clench hard onto her quads for stability, while her other hand tries to keep your face in place while she abuses it.  Her hips roil and thrash; you tilt your face up some more, trying to get more space for your tongue to work, and your nose brushes hard against her clit with every forward thrust she makes.  It drives her crazier.");

	outputText("\n\nHer tongue flops out of her mouth while she gasps with lust, lost in her little sex-consumed world while you work her like an expert.  Her juices leak down your face unabated, over your upper lip and down your chin.  Every time your nose crashes against her button, she 'ah!'s, pauses a moment, and continues, drawing herself ever closer.");

	outputText("\n\nIt's not too much longer before she drops her tit-feeling hand back down to your skull and her voice begins its telltale crescendo as her thrusts get more forced and erratic against your face.  What starts as a few yips, becomes gasps, becomes grunts, becomes yells and shouts before she hits forward one last time, gushing her fluids out of her hole and straight into your thirsty maw.  She cums and cums, her pussy tightening hard enough on your tongue to keep you from pulling away while she relentlessly pumps her fluid down your throat.  What doesn't flow into your mouth drenches your neck and your upper [chest]; some of it even flows high enough to reach your forehead before dripping back down.");

	outputText("\n\nHer hands clench and unclench over and over, and she chews on her bottom lip nearly hard enough to draw blood.  Since you're clearly not going anywhere, you continue to service her even through her torrent.  She hisses through clenched teeth hard as another orgasm eventually overcomes her, restarting her flood, albeit a bit drier this time.  The process between you two continues for minutes, with her cumming half a dozen times, each time depositing more of her femcum into your stomach and across your body.");

	outputText("\n\nShe finally has enough, and her body goes slack against the wall of the stall.  Your fingers release their death grip on her legs while she releases hers on your tongue, allowing you to finally withdraw it.  You probably won't be able to taste anything else for the rest of the day.  She looks starry-eyed and a thousand miles away, and barely even notices when you climb off your tired knees.  <i>\"Fuck,\"</i> is all she says, before she weakly reaches forward and hooks an arm behind your neck, pulling you in for another fierce kiss.");

	outputText("\n\nShe gives you all the tongue you could ask for, while you just sort of flap yours in various directions.  She doesn't seem to mind, though, and eventually pulls away from you with a smile.  <i>\"Still hungry?\"</i> she asks with a smile.  You feel across your stomach – she probably just fed you for the day.  You just look at her, figuring her question was rhetorical, and she giggles.");

	outputText("\n\nThe shower's water went cold some time ago.  Brooke, for the most part, just needed to clean her crotch, while you have most of your front to vigorously scrub.  Like a sweetheart, though, she sticks around, innocently helping you wash herself off of you.  With her help, you're clean before you know it, and then you're drying each other off.");
	//[if (hasCock = true)]
	if (player.hasCock()) outputText("  [EachCock] has hardly gone unnoticed this whole while, still standing at attention and begging, absolutely pleading for some action.");
	else outputText("  Your own [vagina] stands out, puffy and needy against the cold air, and it's certainly not gone unnoticed.");
	outputText("  Brooke offers to return the favor, more than once, but you decline each time, knowing that if she did, it'd be a cycle between you two that would last for hours.  She understands, but promises you that she owes you one.");

	outputText("\n\nYour drying goes by without incident, and before the end of the hour, your gear is back on and you're out of the gym.");
	// Lust increased by 30.
	dynStats("lus", 30);
	brookeAffection(10);
	doNext(camp.returnToCampUseOneHour);
}

//[=Get laid=]
// Requires a gender
public function getLaidByBrooke():void {
	clearOutput();
	var x:int = player.cockThatFits(brookeCapacity());
	if (x < 0) x = player.smallestCockIndex();
	var y:int = player.cockThatFits2(brookeCapacity());

	outputText("You step closer into her, wrapping your left arm around her torso diagonally, so that your hand rests on her right hip, and you reach over her chest with your right hand, grasping her left boob.  You pull her into you, and she coos at the affection, enjoying your loving embrace, but doesn't say anything, allowing you to have your way with her for now.");

	outputText("\n\nYou roll your hips into her tight, toned ass, ");
	if (player.hasCock()) outputText("spearing your " + player.cockDescript(x) + " between her cheeks wickedly, feeling it rise effortlessly against her soft fur and the smooth, strong muscles of her glutes");
	//[if (hasCock = false)]
	else outputText("and with some clever maneuvering, you manage to wiggle her tail between your legs, and you feel the soft fur and the smooth, powerful muscles of her tail brush against your [vagina], stimulating you easily");
	outputText(".  You kiss and nip at her neck, knowing just what she likes, and she moans, knowing that you like hearing her.");

	outputText("\n\nYour hands work their magic on her taut body, touching her in all the right places, and paying some of her more defined muscles more attention in particular.  While she gasps and lurches whenever you pull at a nipple or play with her button, she groans gutturally whenever you comb your fingers over her stomach muscles, or when you grasp her biceps with your whole hand.  Whenever you lift your lips away from her neck for a breath or for better positioning, she drags her tongue across your face, half in thanks for your unspoken compliments and half in total lust.");

	outputText("\n\nWhile you love making her feel special, ");
	if (player.hasCock()) outputText("your " + player.cockDescript(x) + " continues to thrust and spear between her luscious ass, demanding attention be paid to it.  Brooke notices, and rocks her hips against you, squeezing your meat teasingly with each downstroke her ass makes on your " + player.cockDescript(x));
	else outputText("your [vagina] stokes with each swish her wet, heavy tail makes against you, hungering for something in it, and getting humped against by something as phallic as her tail just makes you hornier.  Brooke can tell from the way you keep dragging your [hips] across her tail, and teases you however she can, by stiffening her tail and whipping it against your [leg]");
	outputText(".  <i>\"Excited?\"</i> she asks, grinning back at you.  You let your actions speak for themselves, and you hump against her butt some more, dragging out your pleasure.");

	outputText("\n\nYou're on the verge of just asking her to go down on you, when she reads your mind and breaches the topic herself.  <i>\"You're a sexy little ");
	if (player.hasCock()) outputText("horndog");
	else outputText("whore");
	outputText(" sometimes, [name],\"</i> she says, turning herself around in your arms.  She reaches down between you, ");
	if (player.hasCock()) outputText("stroking along [eachCock], hissing inwardly at what she finds, loving the way her fingers, hurt as they are, just manage to glide across your skin");
	else outputText("stroking along your [vagina], grinning at how your lower lips just manage to wrap around her fingers like they were made for each other.  Her thumb drags across your [clit] intentionally, several times, and she smiles wider at every feminine grunt you make");
	outputText(".  <i>\"Feeling a little pent up, sweet thing?\"</i> she asks innocently, her fingers working harder on your genitals.  <i>\"It's okay.  Brooke's in a giving mood.\"</i>");

	outputText("\n\nShe leans in and gives you a quick, but fierce, kiss on the lips, sliding her tongue along your teeth just once before pulling away and lowering herself, sliding her eager tongue across your own neck, down your [chest], across a [nipple], and over your stomach.  She comes to a rest on her knees, bringing herself level with your [hips]; she eyes");
	if (player.hasCock()) outputText(" [eachCock], now fully erect and at attention, just for her");
	else outputText(" your [vagina], loving how you can hardly resist fucking your hips at nothing in anticipation");
	outputText(", and, licking her drooling lips, leans in.");

	//{male/herm scene}[if (cocks = 1)
	if (player.hasCock()) {
		outputText(images.showImage("brooke-gym-male-getLaid"));
		outputText("\n\nBrooke opens her mouth and breaths hotly on your " + player.cockDescript(x) + ", hesitating just a moment to feel you jump in her hands, before taking you in.  She only wraps her lips around the crown, suckling gently on you, lapping at any precum that flows out.  Her tongue, though, runs out of her mouth unabated, lathering the underside of your " + player.cockDescript(x) + " with her saliva, preparing it for the journey it's about to take.");
		if (player.cockTotal() == 2) outputText("  Brooke grips onto [eachCock] gently, keeping them sturdy and pointing them right at her lips.  She pumps them alternately, watching how the skin glides with her fingers, while she ponders how precisely to pleasure you.  Throwing caution to the wind, she opens her mouth as wide as she can, and shoves both of [eachCock] into her mouth at once, suckling and laving at your rods gently, preparing both themselves and herself for the journey they're about to take.");
		if (player.cockTotal() >= 3) outputText("  Brooke isn't quite sure where to begin, staring at [eachCock].  She grabs ahold of your " + player.cockDescript(x) + " with one hand, before grasping at your other phallus with another, and seeing your last cock hanging loose and alone, she bends down and leans in, using just her face to lift it and shuck it into her mouth – only by the tip, and very gently, but nonetheless eagerly, spurred on by your jungle of a crotch for her to explore and conquer.");
		if (player.cockTotal() >= 4) outputText("  Still, she can't quite tear her eyes from the rest of your cold, wet, and alone penises, and she sighs, almost out of frustration, completely unsure how she's going to accomplish this.");
		if (player.hasVagina()) outputText("\n\nDespite her task, she's fully aware of your feminine side, and gently leads one of her hands down the shaft of your " + player.cockDescript(x) + ", reaching back and between your legs for your other half.  You gasp and buck as she finds your [clit] first, and then thrusts her fingers in, up to the first set of knuckles.  She pumps them in time with the dick in her mouth, trying to build up a rhythm with you.");

		outputText("\n\nYou groan and rest your hands on her head while she expertly goes down on you: she pays special attention to every noise and movement you make, and when you make a particularly sharp inhale or twitch in a particular way, she knows exactly why and how to make you do it again.  She's some kind of magician, the way she works her body to almost perfect synchronicity with yours – all for the end result of cumming in her mouth");
		if (player.cockTotal() >= 3) outputText(" and all over the rest of her");
		outputText(".");

		outputText("\n\nShe moans and pushes herself deeper, swallowing more of your " + player.cockDescript(x) + " into her tight, slurping maw: her head bobs and her tongue tastes, sucking more of your meat into her, eager to please.  You pump your hips with her sucking, your fingers twirling and playing with her hair affectionately, ");
		if (player.cockTotal() <= 2) outputText("enjoying the lips of your canine lover as they slide over [eachCock] and how she seems to enjoy herself so thoroughly");
		else if (player.cockTotal() >= 3) outputText("enjoying how she tries her damndest to make sure every little bit of you has enough attention and is pleased to the best of her ability, no matter how much effort she requires");
		outputText(".");
		if (player.gender != 3) outputText("\n\n");
		else {
			outputText("\n\nSuddenly, she pulls away, leaving [eachCock] out in the cold air and the beating of the shower water.  You look at her questioningly, when she leans forward, ");
			if (player.balls > 0) outputText("burying her muzzle underneath your [sack] to push your [balls] out of her way, ");
			outputText("and gets her tongue to work on your [vagina].  You gasp, unintentionally squatting just a bit to get more of her.  Ever the multi-tasker, she keeps her left hand busy, stroking your " + player.cockDescript(x) + ", making sure no part of you is ever left alone for long.\n\nShe pushes her nose up, rubbing the bridge of her long dog-nose against your [clit], knowing how much that'd get to you.  From her position, she can't reach very deep into your tunnel with her tongue, but she certainly does what she can: she licks and digs at your vulva, tasting every drop of juice you drip, and allows you to fuck against the fine fur on her face as she services you.  With the work she does in your [vagina] and with the way her expert hand continues to masturbate your " + player.cockDescript(x) + ", your body is horribly confused in which way to thrust against, but the sensations lighting up your mind nonetheless make it worthwhile.\n\nEventually, Brooke pulls back, releasing your cock from her hand and stepping out from between your legs.  She rolls her head on her neck a bit – staying in such a way for so long must have been a strain – and gets right back to work, sucking your " + player.cockDescript(x) + " back into her mouth, deeper and faster this time.  ");
		}
		outputText("Brooke moans out loud, pressing herself farther in, loving the feel of your dick in her mouth as much as you do.  Your " + player.cockDescript(x) + " pulses and bounces with each of your heartbeats, and she can feel the jump in her mouth and across her tongue.  She does everything she can to enhance your pleasure, from pressing your " + player.cockDescript(x) + " against the roof of her mouth, to using the base of her tongue on your " + player.cockHead(x) + " while she toys with your shaft with the tip, to leaning in and taking all of you in her mouth at once and staying there for a moment.  You let her know that her efforts are paying off with a wordless grunt and jerking your hips: you're close, and she can tell.");

		outputText("\n\nShe picks up her pace, bobbing up and down on you faster and harder.  You're not fucking her face so much as she's fucking you with her mouth");
		//[if (cocks >= 3)]
		if (player.cockTotal() >= 3) outputText(".  Her hands are practically a blur, up and down on [eachCock] – she's pulled them each down and towards her, aiming them towards their proper target");
		//[if (isHerm = true)]
		if (player.hasVagina()) outputText(".  Her fingers are straight as can be, pistoning into you roughly while her thumb frigs against your [clit], and the feel of her enthusiastic fingers inside your [vagina], massaging and caressing your walls, has you seeing stars");
		outputText(".  You're not entirely positive if she's giving you pleasure because she wants to, or if you're just some perverse toy for her to suck on.  Whatever the case, you're not complaining, that's for sure.  Your hands grip hard onto her head, harder than you intend to, but that seems only to spur her on.  It's not much longer until you cum from her expertise.");

		//[if (cumQuantity <= 349)]
		if (player.cumQ() <= 349) outputText("\n\nYou blow your load into her sucking mouth, and she licks and laps at every drop.  Your " + player.cockDescript(x) + " shakes and explodes with your jizz, coating her hot mouth, but it's never quite enough for her: she doesn't stop her sucking, milking you of every drop of cum you can make.  You fill her mouth once, and she audibly swallows hard, and you fill it once more before you're depleted.  She only calms down with her sucking once she's beyond doubt that you gave her everything.");
		//[if (cumQuantity <= 999)]
		else if (player.cumQ() <= 999) outputText("\n\nYou cum into her hungry mouth, and you do not disappoint the cum-hungry canine beneath you.  You coat her tongue with your seed, blowing out her cheeks with your sperm, and she swallows quickly before your next blast fills her mouth to the brim again.  You're a faucet, and she's your sink, taking every drop, clamping her lips securely on your " + player.cockDescript(x) + " to keep anything from spilling out.  Her throat works hard to keep up, but she manages, and by the time you're finally depleted, she's satisfied – if a little stuffed.");
		else outputText("\n\nBrooke worked so very hard for your seed, and you're not about to disappoint the cute canine sucking you off.  Your eruption knocks her off guard: your jizz shoots all over her mouth and straight down her throat.  When she's halfway done with one load, you deposit another, not giving her a hope to keep up with your output.  She clamps down on your " + player.cockDescript(x) + " hard, trying to not let anything escape, but it's hardly effective: seconds later, cum is leaking out from her mouth and out of her nose, before she relents and lets go, letting your [cock] spray her in the face instead.  You cum and you cum, coating her face and her neck with your offering; she groans gutturally, half in love with the scenario and half disappointed she lost the competition between your dick and her throat.");
		//if (cocks >= 3)
		if (player.cockTotal() >= 3) outputText("  She strokes along [eachCock] while you orgasm, and the rest of you sprays with the one in her throat.  She does her best to keep [eachCock] pointed somewhere at herself, letting you spray her with your sperm over and over, from different angles.  You're barely able to pay attention with the ecstasy flowing from your groin, but you could swear she was smiling the whole while, moaning along with your every blast.");
		if (player.gender == 3) outputText("\n\nThe hand in your pussy is finally rewarded for its diligence, and gets a heaping blast of femcum all over Brooke's hand, flowing down her wrist and dripping off at her forearm.  Your [vagina] pulls hard at her, milking her fingers for all the sperm it wishes it could get.  Brooke doesn't stop her thrusting, even while she tries to focus on [eachCock], sympathetic to your feminine requirements.  You thank her by coming for her some more, soaking her arm even more than it was.");
	}
	//{female scene}
	else {
		outputText(images.showImage("brooke-gym-female-getLaid"));
		outputText("\n\nShe doesn't waste any time and gets to work right away on your [vagina].  She leans in and pulls her face up a bit, drawing her long nose across your [clit] while her tongue goes to work piercing into your tunnel.  You gasp and buckle, one hand on her head and keeping her in place with the other reaching up and grabbing onto the wall of the stall for stability.  Brooke works quickly and deeply into you, and you can feel every twitch and turn of her muscle inside of you, and every bump and movement her nose makes against your stiff button.");

		outputText("\n\nJust as you pull her face into your crotch, she reaches up to grasp onto your [butt] and pull you into her, as well as she can.  She alternates from fucking you hard with her face – moving quickly and harshly, side to side, front and back, thrusting her long, fat tongue and thrashing it every which way – and taking it a bit slowly, pursing her lips and sensually digging herself as deep into you as she can reach, kissing and loving you, making you squirm with carnal delight.");
		outputText("\n\nShe withdraws her tongue, making you whimper just a little, before she puts it back to work licking up between the lips of your sex and tapering it off by stroking your [clit] with the tip of her tongue.  She presses and laps at it, ever so gently, and gradually puts more of her tongue onto it, pressing the flat of it onto your button.  She rises on her knees, sliding her tongue down your sensitive [clit] until it's resting on the back of her long doggy-tongue.  From there, she takes long and laborious licks, angling her tongue to work between the folds of your [vagina].  It's a creative trick and it makes you moan like a slut.");

		outputText("\n\nYou close your eyes and bask in the feel of the warm water washing you both while the toned Shepherd girl works your horny cunt between your legs.  Her tongue works wonders on you, touching and licking you in just the right ways, sending your mind off and letting your body do all the work.  You don't even notice when Brooke removes one of her hands from your [butt], and it's not until her body starts rocking a bit harder against you that you look down, seeing her masturbate herself while she works to bring you to orgasm.");
		if (player.hasFuckableNipples()) outputText("\n\nSeeing her frig herself along with you reminds you of your own 'alternative outlets'.  You keep your hand on her head, gently and reassuringly keeping her in place, while you use the other to toy with your [nipple].  The tag-team of sensations between your sensitive [vagina] getting expertly worked and the unusual penetration your fingers provide your [chest] nearly sends you heaving, but stopping isn't even an option to you.  Your pump your fingers, feeling your [nipple] clench and pull at them, and your breath nearly escapes you.");

		outputText("\n\nBrooke moans, the sound muffled by her own tongue, which vibrates against your sex.  With every deep, long lick she makes, you buck against her face, trying to fuck it like it were a cock.  Eventually, her tongue gets tired of the double-play, and she sits back down to angle her tongue more directly into your [vagina].  The feel of having it back into you so suddenly, coupled with how it thrashes and pounds against every nerve you have while it thrusts and tastes, puts you very close, and you pull on her hair, perhaps a little roughly, to tell her.  She replies by working harder.");
		outputText("\n\nShe opens her mouth wider and bends down before spearing forward, penetrating you deeply than she has yet.  You nearly cry out, managing to bite back your jubilation just in time – you don't want any curious onlooker investigating the sound of a womanly scream.");
		if (player.cor <= 49) outputText("  That would almost be embarrassing enough to turn you off.");
		else outputText("  You want this sexy bitch all for yourself, and you'll be damned if you're sharing.  At least not until you're done.");
		outputText("  Brooke, though, giggles through her mouthful of quim and thrusts again, enjoying the strained efforts you're making to not cry out.  Her hand jills hard and fast against her own neglected pussy, and from her actions, she's maybe as close as you are.");

		outputText("\n\nYour [hips] rock in time with her mouth, and through just a little more stimulation, the welcoming waves of your orgasm crash through you and into Brooke's mouth.  You moan heatedly and your muscles tense while your [vagina] pulls and squeezes on Brooke's tongue, and your cum floods from you and into her open mouth.  What she doesn't catch sprays all over her face and down her neck, and you fuck against her muzzle a bit more with each contraction, riding out your orgasm as long as you can.  From the feminine gasps you can make out from her between blasts of your girl-cum, it sounds like Brooke's getting off herself.");
	}
	outputText("\n\nYou calm down from the explosive orgasm, your eyes crossed from the oral sex Brooke just gave you.  You see shapes and colors, barely able to see, as you slump against the wall of the stall.  Brooke barely moves beneath you, soaking in your cum");
	if (player.cockTotal() >= 3) outputText(", and letting the excess wash from her fur half-heartedly");
	outputText(".  Moments pass in a completely undecipherable blur to you, and when you can finally make sense of your surroundings, Brooke's standing up and has her tongue in your mouth.");

	outputText("\n\nYou finally start to kiss her back, trying to convince her that you've got more life in you than a mannequin.  She coos when she finally feels movement, and you groan, tasting yourself on her tongue");
	if (player.hasCock()) outputText(", snowballing what she hasn't swallowed quite yet");
	outputText(".  She cradles you in her strong arms until she's done, and you pull away from the wall, still a bit wobbly.  <i>\"Was it good for you too, sweet thing?\"</i> she asks.  You barely nod.");

	outputText("\n\nThe shower's water is fairly cold against you.  When Brooke finally lets you go, she offers to finish up her wash alone.  You decline, of course – you went to the showers to get clean in the first place, and you're both dirtier than when you started!  You help each other wash off, completely innocently, and make your way to the lockers.");

	outputText("\n\nYou can't help but keep stealing glances at her naked, powerful form, and before you're done drying, you offer her to return the favor.  It's the least you can do, after all.  Brooke looks you over, smiling and biting her lower lip as she imagines it, but, with a frown, declines.  <i>\"Thanks, sweet thing,\"</i> she says, <i>\"but we'd probably just keep fuckin' and suckin' all day if I let you.\"</i>  You ask her what the harm in that is, and she playfully whips you with her towel.  <i>\"You owe me one, though, and don't you forget it.\"</i>");

 	outputText("\n\nClean as a whistle and with your [armor] back on you, you wave farewell to your canine lover and leave the gym.");
	//Lust reduced to 0
	brookeAffection(10);
	player.orgasm();
	dynStats("sen", -2);
 	doNext(camp.returnToCampUseOneHour);
}
//[=Double-dicked=]
//Requires at least two penises
public function doubleDicked():void {
	clearOutput();
	var x:int = player.cockThatFits(brookeCapacity());
	if (x < 0) x = player.smallestCockIndex();
	var y:int = player.cockThatFits2(brookeCapacity());

	//if {all cockFits  >= 61}
	if (y < 0 || player.cockThatFits(x) >= brookeCapacity()) {
		outputText("You hump against her, enjoying the warm, wet feel of her fur against your sensitive monsters.  Brooke moans out, enjoying the way you're using her body, but freezes slightly when one of them begins to press and ply against her butthole.  <i>\"Sorry, sweet thing, but maybe not this time.  Much as I'd love me some double-dickings, one of those things in my butt would be one too many.  I'm down for something else, though.\"</i>");
		menu();
		addButton(0,"Next",gropeDatBrooke);
		return;
	}
	outputText(images.showImage("brooke-gym-male-doubledicked"));
	outputText("\n\nYou don't bother saying much and choose to just rub yourself against the wet, matted fur of her ass for a bit.  [EachCock] begins to rise and stiffen, thawed by the heat of her body and the friction between you two: your " + player.cockDescript(x) + " drives itself sensually between her thighs and across her sex, while your " + player.cockDescript(y) + " enjoys the warmth and coziness of her ass, rubbing across her taint and teasing her anal ring.  You don't make any attempts at either hole – that comes later.");

	outputText("\n\nBrooke giggles to herself, letting you jerk yourself off with her lower body.  The " + player.cockDescript(x) + " between her legs caresses and tickles against her pussy while another, " + player.cockDescript(y) + " crawls devilishly up her butt and between her cheeks.  She squeezes down on both, forcing you to rub a bit harder, which was just the reaction she was aiming for.");

	if (player.isNaga()) outputText("\n\n\"<i>Dunno if you reptiles got it better or worse,");
	else outputText("\n\n\"<i>Got yourself an exotic set, sweet thing,");
	outputText("\"</i> she mentions, almost casually, while you continue to masturbate yourself on her.  <i>\"");
	if (player.isNaga()) outputText("Twice the dick means twice the fun... but twice the work, too.  I'm up to the challenge, though, if you are.");
	else outputText("Haven't actually seen anyone that's not half-snake sporting more than one.  Mind if I put 'em to the test?");
	outputText("\"</i>  She rocks her hips a little higher, brushing the ring of her anus across your " + player.cockDescript(y) + " while driving your " + player.cockDescript(x) + " further across her labia.");
	//[if {not first time anal}
	if (flags[kFLAGS.TIMES_IN_BROOKES_BUTT] > 0) outputText("  <i>\"Let's just hope this doesn't turn me any more into a buttfucking freak, huh?\"</i>");
	else outputText("  Brooke hesitates just a bit as she feels the heat of your dick against her asshole.  <i>\"Well, first time for everything,\"</i> she says to herself.");

	outputText("\n\nShe teases your dual penises, rubbing her wet holes against your " + player.cockDescript(x) + " and your " + player.cockDescript(y) + ", intent on bringing you to full mast before taking any sort of plunge.  Your hands travel down to her toned, trim hips, and you grasp onto them sharply, helping her rock against you.  She 'mmm's at the feel of your rough hands on her muscles, and the way you continue to drive [eachCock] against her.");
	if (player.cockTotal() >= 3) outputText("  Your other dicks rise as well, though not as quickly as the first two, jealous that they were chosen instead.");

	outputText("\n\nYou slide your hands up, sliding your palms over every well-defined muscle and sinew, before they come to rest on her pert breasts, each of them filling your squeezing hands just right.  She sighs with delight while you press and massage against her wet chest, and leans back, resting her hips on [eachCock] and her back onto your own [chest].  She reaches back with her hands, stroking your face, and you kiss her cheek, prompting her to turn so you can kiss her properly.");

	outputText("\n\nYour tongues work together, arousing you both, preparing [eachCock] for the plunge and preparing herself, sexually and mentally, for the strain she's volunteering to take for your pleasure.  You were both well along before you had started, though: you're not going to get much harder and she's not going to get much wetter (all things considered).  She disengages from you so she can turn herself around, straddling you once more, face-to-face.  Her hips rise along with your " + player.cockDescript(x) + " and your " + player.cockDescript(y) + ", until one head is pushing against her impatient cunt while the other rests against her butthole.");

	outputText("\n\nAs ready as you are, you don't rush her.  You hold her by the ass once again, keeping her steady against your body, while she leans into your [chest], using one hand to stabilize herself and the other to align your tools.  When they're both in position, she takes a deep breath, and starts to slide down.");

 	outputText("\n\nThe " + player.cockDescript(x) + " in her quim slides in tightly, but easily.  The " + player.cockDescript(y) + " pressing against her rim, though, takes a bit more convincing.  She grits her teeth and closes her eyes in concentration, grinding her hips just slightly, back and forth, working the meat into her butt.  Once the " + player.cockDescript(y) + " pops in, she lets out a gasp, opening her eyes a bit, before focusing once again to work more of it into her.  Her muscles relax and tense sporadically – ");
	//[if {first time anal}
	if (flags[kFLAGS.TIMES_IN_BROOKES_BUTT] == 0) outputText("it's certainly not a workout she's accustomed to,");
	else outputText("no matter how much she loves getting fucked in the butt, it's still not a usual thing for her,");
	outputText(" and for every inch her ass takes, another simultaneously slides into her pussy, stuffing her fuller than she's ever felt.");

	outputText("\n\nYou can feel her glutes become rigid in your palms whenever she moves, the muscles practically turning to stone.  The pressure on your " + player.cockDescript(y) + " is both stimulating and a bit painful; you whisper encouraging nothings to her while your hands work on her cheeks, trying to get them to ease whenever she slides down a bit more.  It takes some patience, but eventually, she gets you all into her, in both ends.");

	outputText("\n\nYou look down to her abdomen.  Her abs are plainly visible, as she flexes again and again, making tiny adjustments to her resting on your crotch, and you delightedly feel each one.  ");
	if (player.cockTotal() >= 3) outputText("The rest of you lamentably stands between you, leaking their pre uselessly between your bodies, pleading for some attention themselves.  ");
	if (player.gender == 3) outputText("Your [vagina] clenches in time with its neighbor – you can easily imagine what it might feel like to have two dicks in you at once.  You almost wish for it while you're waiting for Brooke's go-ahead.  ");
	outputText("Brooke's face contorts, not in pain but in concentration, while she fidgets with her ass and lower body, adjusting to both of her holes being so totally full.  After minutes of her positioning and repositioning herself, her eyes finally meet yours.  <i>\"Okay,\"</i> she whispers, <i>\"but... a bit gentler than what we're used to, okay?\"</i>");

	outputText("\n\nYou accede; it's the least you can do in return.  After all the effort she went through to right herself on you, you pull out from her, ruining all her hard work, and then thrust back in, slowly.  Her breath catches in her throat, but she doesn't object – you repeat yourself, pulling out just as far, and she shucks in some air once you thrust in.  Her pussy squelches and squeezes, but not anything like her anal ring: it's like she's both trying to keep you in and trying to keep you from entering her body, all at once.  Her muscles move and form around your " + player.cockDescript(x) + " and your " + player.cockDescript(y) + " with each movement you make, doing their best to shape themselves around both of your intruders.");

	outputText("\n\nYour fucking keeps steady and slow.  ");
	if (flags[kFLAGS.TIMES_IN_BROOKES_BUTT] == 0) outputText("Brooke's breathing slowly starts to even out, and she starts to moan enjoyably.  Maybe she's starting to like it?");
	else outputText("Brooke rocks her hips onto both of your cocks, alternating from taking one deeper than the other.  As much as she just loves sex in general, it's the alien feeling of being so full that keeps her from going any harder.");
	outputText("  She gasps and jerks with your every thrust, and you grunt, shoving yourself");
	if (player.balls > 0) outputText(" down to your [balls]");
	outputText(" deep into her.  You can practically feel your two dicks rubbing against each other inside her with each thrust.");

	outputText("\n\nHer strained grunts slowly turn into pleasured moans with each thrust, and you take that as your cue to pick up the pace just a bit.  It's still by no means an easy task, with the way she's putting so much pressure on you, but the ease of her muscles and the lubrication of the water make your thrusting somewhat smoother.  She buries her face into your [chest] while you continue to brutalize her pelvis, muffling her pleasured noises with your body.");

	outputText("\n\nHer hands go from the wall for her balance, down to your [butt], grabbing a pair of handfuls for herself.  For more leverage, she lifts her right leg and wraps it around your [hips].");
	if (player.cockTotal() >= 3) outputText("  Your extra equipment, painfully erect, squashes between your bodies, pointing right at the underside of her boobs and your own [chest].");
	outputText("  You fuck her a bit more forcefully, but not any faster, for both your sakes.  She moans into you: her body's adjusted to the feel, and she's more receptive of your actions.");

	outputText("\n\nBrooke's breathing slowly turns ragged, and her sighs and shudders become more forceful over time.  She meets your every pump with her own, fucking along with you, her body learning to love the feel of having both of her holes filled.  Her voice rises with each pound: just a few more later, and she orgasms, her body going taut and tense, making it all the harder to keep fucking her.");

	outputText("\n\nThe intense pressure makes it just a little harder-going, but the feel of having her entire body trap all of you, milking you for the cum it craves, spurs you into your own throes of orgasm.  You grunt and lean forward, resting your head on her shoulder, as [eachCock] sprays forth, blasting into her from every angle.  ");
	//[if (cumQuantity <= 349)]
	if (player.cumQ() <= 349) outputText("Your jizz blasts into her, filling into her womb nice and comfortably and shooting deep into her bowels.  Your both shake: her from the feeling of getting two doses of your cum at once and you from having your " + player.cockDescript(x) + " and your " + player.cockDescript(y) + " pleased so uniquely.  Your orgasm goes for two, three, and four blasts, before tapering off to nothing inside of her.");
	//[if (cumQuantity <= 999)
	else if (player.cumQ() <= 999) outputText("You cum hard, shooting your potent spunk into her thirsty cunt and her slurping asshole.  Her orifices fill out quickly, stuffed full, but you don't relent, shooting more and more into her.  She groans out, feeling so much sperm pool inside her, and her breathing shortens while she tries to focus on the feeling.  By the time you've finally finished inside her, your creamy jizz leaks from each of her holes.");
	else outputText("Once your orgasm finally, powerfully overtakes you, a glimmer of a thought questions that maybe finishing inside her wasn't the best idea.  Your cum rockets into both her pockets and then some: the " + player.cockDescript(x) + " in her vagina fills it to the brim in just a few spurts, and the " + player.cockDescript(y) + " in her ass shoots and shoots into the rest of her, distending even her tight stomach and ruining her form.  She grunts hard, gripping onto you while you fill her out, but the tightness from both your cocks makes keeping herself composed a harder task than she anticipated.  Your orgasm goes for what seems like minutes, and when you're finally done, she looks primed to pop like a balloon.");
	if (player.cockTotal() >= 3) outputText("  Your [eachCock] sprays from between you, launching its own jizz up and uselessly between you, forming a warm, sticky blanket between your stomachs.  Some of it even crawls up between her cleavage, sticking them together from the inside, and with her pressed against you like this, it can't wash off right away.");
	if (player.gender == 3) outputText("\n\nYour [vagina] pulses and cums, spraying its juices down your legs and splashing onto the floor.  With every thrust you make into her while your fairer sex orgasms, you try to imagine something in it, to stimulate it and draw yourself out longer – with both your hands occupied and Brooke focused on herself, your imagination is all you have.  It works well enough, and with every clench, your [vagina] rocks just a little more.");

	outputText("\n\nThe two of you stay like that for just a moment, basking in your afterglow with each other.  Brooke's face is still lodged firmly in your [chest], and, while you can still feel the errant twitch and squeeze from either part of her, her breathing calms and evens.  Her arms are wobbly and her legs are shaky from the unreal session between you");
	//[if (cumQuantity >= 1000)
	if (player.cumQ() >= 10000) outputText(" – she's probably going to have trouble doing much of anything for a day or two until she 'digests' her load");
	outputText(".  Wearily, she pulls herself away, just enough to look you in the eye, and, without a moment, leans in to kiss you, tongue and all.");

	outputText("\n\nYou both stay like that in the shower, long after [eachCock] has deflated and fallen limp.  It's not until the shower turns frigid that you decide to finish cleaning yourselves and get a move on out of the gym.  Despite how cold the water is, you keep each other warm; she gets to your hard-to-reach places and you reciprocate, getting at all the hard spots under her fur.");

	outputText("\n\nClean as a whistle, you both go to the lockers, pulling out your towels to dry yourselves.  You're both rather quiet and subdued through the whole thing – there isn't really much to say, ");
	//[if {first time anal}
	if (flags[kFLAGS.TIMES_IN_BROOKES_BUTT] == 0) outputText("but Brooke eventually breaks the silence.  <i>\"Hot damn,\"</i> she finally says, rubbing her hands over her sore ass.  <i>\"Never knew anal sex could be such a trial.  And getting it in the cooch at the same time?  Man, out of this world.\"</i>  She drags her index finger down your [chest] playfully, giving you a sultry smile.  <i>\"I hope you didn't think it was a one-time thing, sweet thing.  We're going to have to try it again sometime.\"</i>  You smile back at her and tell her you're looking forward to it – but in the back of your mind, you wonder if you might have just awakened some sort of beast.");
	else outputText("not that you need words.  Brooke tells you everything you need to hear by wrapping her towel around you both, under the pretense that she's helping you dry, but from the lewd way she's rubbing her body against you, and from the way her eyes narrow and curl, pursed lips coming within inches of your own, or your [nipples], she's more than ready for a repeat performance.  From the stirring in [eachCock], you're almost ready to take her up on that.  But, dredging up all the willpower you have, you manage to rebuff her – and her pleading dog eyes once you do.  You have other things to do today.");

	outputText("\n\nThe rest of your drying continues without much incident, and before long, you have your [armor] back on you and you're out of the gym, heading back towards camp.");
	//Lust reduced to 0
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
	brookeAffection(10);
}

//Between 16:00 and 18:00, Affection >= 40, <= 70, body tone 50 minimum, one-time event, requires a gender
//Dick that fits or cunt.
//flags[kFLAGS.BROOKE_MEDIUM_SCENE] == 1
public function mediumAffectionOneTimeEvent():void {
	clearOutput();
	outputText("You wander your way back into the showers, stopping once again at the lockers to deposit your [armor].  Right on time, you hear the tell-tale sound of rushing water just up ahead, and as usual, you see Brooke washing at her fur lightly in the first shower stall.");

	outputText("\n\nWith your first step, her ears perk, and she turns to you.  She smiles once more; you can't tell at this distance, but her smile looked a little... devious.  Or maybe playful.  You're not sure what the difference is.  <i>\"Hey, [name],\"</i> she says, giving you a wink.  <i>\"The water's warm, but my stall is cold... care to come and warm it up?\"</i>");

	outputText("\n\nAnother invite to wash her back.  She either exhausted herself in the gym and she can barely lift her arms – and you wouldn't be surprised if that were the case – or she's got something on her mind.  You agree, playing along for now, and step into her stall, right behind her.  Lecherously, you find yourself excited at using your hands to see her body again.");

	outputText("\n\nYou remove your towel, placing it on the wall of the stall, and step in close to her.  Once more, you begin to lather up your hands and get to work, when she turns on the spot, looking into your eyes.  <i>\"[name],\"</i> she starts, closing the remainder of the distance, <i>\"I've been thinking about our relationship for the past few days now.  And I don't think I like it.\"</i>  You look at her, confused, a hundred different replies swirling around your head.  You settle for a simple, dumb, 'huh?'  <i>\"Every day, we come here, we work out, and then we shower.  We're not getting to know each other any better.  No invites out to dinner; no sunset walks down at the lakeside; nothing, just the gym.\"</i>");

	outputText("\n\nYou're not positive where she's going with this.  <i>\"That's not very exciting, in my opinion.  We're friends, right?  We should get to know each other better.\"</i>  She wraps her arms around you, pulling you closer.  Her hands massage your shoulders, softly and methodically, working her fingers over your skin.  <i>\"So, today, let's mix it up.  I'll wash your back, if you're still willing to wash mine.\"</i>");

	outputText("\n\nShe gets to work right away, rubbing at your shoulders, soaking the water into your skin.  You don't know if she even has any soap on them, but you don't particularly care.  You return the motions, getting at her usual spots, just from a different perspective.  <i>\"I was on the jogging track earlier today,\"</i> she says, nearly a whisper, leaning in close, letting her breasts squeeze against your [chest], her thighs pressed tightly together and leaning into yours, <i>\"and I thought to myself, 'man, I can't wait to talk to [name] again today.  I should ask [him] for another massage.  [He] really knows how to work a pair of shoulders.'\"</i>");
	//[if (hasCock = true)]
	if (player.hasCock()) outputText("  You feel [eachCock] beginning to wake from her proximity, and in just a few seconds, she'll know it.");

 	outputText("\n\nHer hands trail down to your upper back, and you follow suit.  <i>\"But that's hardly fair.  I ask you – a sexy, sweet thing like yourself – to jump into a shower, ass-naked, with a sexy, sweet thing like myself, and do nothing but listen to me talk and wash my back for me.  And it wouldn't even be the first time!  I still owe you one from before.  What kind of bitch would I be, if I tried to pull that a second time, am I right?\"</i>  You say nothing, frowning slightly, continuing to wash her back while maintaining eye contact.  <i>\"Well,\"</i> she laughs, <i>\"don't be too quick to correct me there.\"</i>");

	outputText("\n\nHer hands begin to travel lower, onto your lower back.  Her body presses forward, her lower stomach connecting with your own.");
	if (player.hasCock()) outputText("  Her thighs brush against your quickly rising [cock], and she's not even pretending it was an accident.");
	outputText("  <i>\"To be honest, [name], it was hard enough for me to tease you the first time, when I first asked you to wash my back.  Seeing you walk in, fresh from the gym, buck-naked except for that towel... god, you looked delicious.  But you know, it's hard to really connect with anyone in this gym.  Everyone's got sex on their mind one way or another – I haven't been able to really hold a conversation with any of them without it ending with come-ons and invites back to their place.  Don't get me wrong, I love me some sex, but sometimes I just want someone to talk to, you know?\"</i>");

	outputText("\n\nFinally, her hands travel down to your [butt], giving each cheek as strong a squeeze as her damaged hands can give.  You take that as an invitation, and you return suit, finally getting your hands on her firm butt.  It has barely any movement or jiggle to it, but given the body tone of the Shepherd you're groping, you're neither surprised nor disappointed.  <i>\"You stepped up to the plate that one time days ago.  I got to know you, and you got to know me.  And... I got to watch you.  Every time I saw you, you were trimmer; buffer; <b>sexier</b>.  Every day it was harder to not throw it all to the wind and fuck you then and there.");

	outputText("\n\nSo hopefully,\"</i> she says, closing the gap between your faces, <i>\"you won't mind if this horny bitch indulges herself.\"</i>  With that, she presses her lips against yours, although this time, there is no resistance or apprehensiveness: her tongue quickly slips out, running unimpeded into your mouth and dancing along with yours.  She turns you to the side, pushing your back up against the stall wall, her mouth never leaving yours as she hungrily, ravenously, explores your mouth with her tongue.  There was nothing teasing or cutesy about it: Brooke wants you, and wants you <b>bad.</b>");
	//[=Next=]
 	menu();
	addButton(0,"Next",brookeSpecialMediumSceneContinued);
}
public function brookeSpecialMediumSceneContinued():void {
	clearOutput();
	var x:int = player.cockThatFits(brookeCapacity());
	if (x < 0 && player.hasCock()) x = player.smallestCockIndex();

	flags[kFLAGS.BROOKE_MEDIUM_SCENE] = 1;

	//{Male only}
	if (x >= 0 && !player.hasVagina()) {
		outputText(images.showImage("brooke-gym-male-specialscene"));
		outputText("Her grip isn't very strong on your shoulders, relying on keeping you pressed against the stall for any traction against your body.  She grinds herself against you, her firm, plush tits dragging over your [chest] and her hot slit running along the skin of your [cock] with each motion.  Her tongue doesn't stop, dancing energetically in your mouth, running and playing with your own with every motion.  You run your hands along the swell of her ass, groping and lifting, humping along with her, building the excitement between you both while avoiding penetration for now.");

		outputText("\n\nEventually, she breaks the kiss, pulling back for air, but she doesn't stop for a moment as she begins kissing your cheek, trailing herself down to her neck, tongue laving and sweeping across your wet skin.  Her hands trail to your sides, under your pits and across your ribs, stroking your skin delicately.  You do the same, moving your hands from her toned ass to her thighs, squeezing what you can as you sensuously rub down her legs.  Your " + player.cockDescript(x) + " continues to saw tantalizingly between her thighs");
		var y:int = player.cockThatFits2(brookeCapacity());
		if (player.cockTotal() == 2) outputText(" while your second phallus brushes higher, rubbing itself through the wet fur on her stomach between the gorge of her abs");
		//[if (cocks >= 3)
		if (y >= 0 && player.cockTotal() >= 3) outputText(" while [eachCock] finds themselves either driving themselves higher, through the wet fur on her stomach and across each of her tensed abs, or joining the first in between her legs, pressing and pulling with her needy humping");
		outputText(", and you can feel the heat, the need, pour from Brooke's pussy as she continues to grind on you.  You can hear her pant as she continues to kiss your neck, whimpering at your denial to penetrate her and moaning with each brush across her vulva.");

		outputText("\n\nShe needs it as badly as you do, and you're not about to deny it.  With your grip on her thighs, you bend your [legs] just slightly, lining your " + player.cockHead(x) + " up with her target.  She stops breathing, tensing slightly, waiting for your thrust, and you oblige.  Straightening your legs and pushing forward, you enter her, pushing in only slightly so you can adjust.");

		outputText("\n\nYou can't really tell how wet she is from the shower, but the heat and the contractions, along with her quiet mewling, tell you all you need to know.  She's tight, remarkably so, but your enthusiasm outweighs any friction burn you might get later, and you slowly continue to push.  She pulls you tighter by her forearms, her face buried in your chest as you ease your way in.  You thrust just a bit first, then pause, then thrust, going deeper and deeper.  She gasps with each pause and moans with each motion.  Too soon, you bottom out, your ");
		if (player.balls > 0) outputText("[sack] resting gently against her crotch");
		else outputText("crotch resting gently against hers");
		outputText(", her fur lightly tingling the skin.");

		outputText("\n\nYou remain there for just a moment, embracing your lover in the shower, enjoying being inside her, especially after putting up with her teasing for so long.  You don't wait long, though, and begin to pull out just a bit before sliding back in.  The water makes it all very smooth, and you continue to gently saw into her this way.  <i>\"[name]\"</i> she says, just barely loud enough over the running water.  You look down, and she looks up, your eyes meeting once again.  <i>\"I'm a big strong gal,\"</i> she says, smiling,<i>\" and you're a big strong guy.  Fuck me, [name].  Don't be gentle.\"</i>");

		outputText("\n\nA part of you was wishing she'd say that.  You reach down, around her thighs once more, and you lift her off the ground.  She gasps in surprise, as, impaled on your " + player.cockDescript(x) + " and lifted off the ground, you walk forward and slam her into the other wall of the stall, rattling the whole setup.  With your new leverage, you pull your hips back and slam them back home, rocking the whole shower room.");

		outputText("\n\nBrooke nearly yelps out, but quickly bites her lip, trying to keep her composure as you pull back and thrust in once more.  You put everything you have into fucking the Shepherd girl: gripping her tightly, you pound into her wet, warm, inviting snatch, feeling every worked muscle lave and caress your " + player.cockDescript(x) + ".");
		if (player.balls > 0) outputText("  Your [balls] swing away with you, slapping onto her pussy with every inward thrust.  You feel no pain, focused only on fucking this girl raw, knowing she's strong enough to take you.");
		if (player.cockTotal() == 2) outputText("  Your other dick swings freely, cold and alone in the shower between you, occasionally spurting pre into the air and onto Brooke's fur.  It's quickly washed away with the water.");
		if (player.cockTotal() >= 3) outputText("  Your other dicks swing freely, cold and alone in the shower between you, occasionally spurting pre into the air and onto Brooke's fur.  They're quickly washed away with the water.");

		outputText("\n\nFrom the chorus of moans and excited grunts above you, Brooke seems to be enjoying herself.  She can't fix her arms on any other thing to grip: she tries the edge of the wall behind her, but her hands aren't strong enough.  She wraps them around your head, pressing your face into her cleavage, and that seems to work for a bit, but she simply can't stay still for too long.  With each thrust, her abs flex and her hips rock, going down to meet you halfway.  <i>\"Yeah, yeah!\"</i> she encourages, leaning forward once more");
		if (player.hairLength >= 1) outputText(", running her fingers through your " + player.hairDescript());
		outputText(".  <i>\"Fuck me, [name]!  Just like that!  Give me that hard dick!  Fuck me!\"</i>");

		outputText("\n\nThe whole gym probably heard.  You might even have visitors by now.  You don't give the littlest damn.  You just grunt along with her, flexing your own stomach to reach up and drive more " + player.cockDescript(x) + " into her.  She grows louder and more active the farther up the wall you drive her, until eventually, she orgasms, holding you in her as she resists the urge to scream out.  She uses her hands to drive your face into her chest as her rocking begins to slow – even with her weak grip, she's still managing to pull you in fairly hard.");

		outputText("\n\nHer orgasm reminds you of your own, coming up very quickly.  She spends only a moment to herself as her world begins to calm down from the shattering orgasm you just gave her, and she resumes her rocking, intent on returning the favor.  <i>\"Come on, [name],\"</i> she practically growls at you.  <i>\"Give it to me.  Fuck me harder.  I want your cum, [name].  I want it all.  Make me your bitch, [name].  Fuck me like a whore.  Fuck me, you sexy fucking beast, <b>fuck me!</b>\"</i>");

		outputText("\n\nYou put everything you have into bringing about your release.  Your muscles begin to ache.");
		if (player.balls > 0) outputText("  Your [balls] begin to churn.");
		outputText("  Your heart races, and your " + player.cockDescript(x) + " pulls and tightens in her pussy.  With some more encouraging, demanding words, and with a little more activity on her part, you finally cum, giving Brooke everything she asked for.");

		//if (cumNormal = true)
		if (player.cumQ() <= 250) outputText("\n\nYou paint her walls with your seed, ejaculating deep into her body, letting it all come out in a heavy force as you cum the hardest you have in quite a while.  Brooke coos with each blast into her tunnel.  She's done thrusting, instead simply grinding tightly against your crotch, squeezing her thighs in time with you to milk out all she can.");
		else if (player.cumQ() <= 750) outputText("\n\nYou blast her hot tunnel with an orgasm more powerful than any you can recall at the moment.  Seed erupts from your " + player.cockDescript(x) + ", driving deeper and deeper into her with each spurt.  She coos and moans with each wave she can feel; she stops her humping and instead takes to grinding, sensuously sliding her crotch with yours, trying to get out every drop you have.");
		else if (player.cumQ() <= 1500) outputText("\n\nYou cum as hard as you ever have yet, punching your seed into her waiting tunnel.  Rope after white rope flies from your " + player.cockDescript(x) + ", slowly filling Brooke up with each successive spasm.  She moans, rocking her hips along with yours, feeling each little drop drip from you and into her.  She shudders a bit, feeling another, milder orgasm rip through her with your own.");
		else if (player.cumQ() <= 4000) outputText("\n\nYour orgasm rushes from you, aggressively blasting her vaginal walls with your thick, potent seed.  You shudder and moan with each pulse, unconsciously rocking your hips forward with each spasm of your dick.  She grunts along with you, grinding her hips greedily on yours, intent on sucking up every drop and keeping it there.  Shortly before you finish, Brooke shudders hard, feeling another, powerful orgasm rack her own body.");
		else outputText("\n\nYou burst inside of her, immediately filling her to capacity with your intense orgasm.  Your cum can't blast through your " + player.cockDescript(x) + " into her fast enough, thickening your dick with each pulse as another glob passes through and into her hungry cunt.  Brooke easily gets what she wants, and then some: she grinds her hips greedily on yours, her pussy voracious for your seed, but despite her best efforts, a small trickle of semen escapes her tight pussy.  She nearly yells out again, feeling your seed sink deeper into her body with every pulse, cumming herself once more – and then once more.");
		if (player.cockTotal() == 2) outputText("  Your other prick tenses along with the first, pointing up and along the tight abs of the Shepherd girl, jizz erupting from the tip and blasting her on the underside of her perky tits.  If she even notices, she certainly doesn't seem to care.");
		if (player.cockTotal() >= 3) outputText("  [EachCock] spurts and flails along with the first, painting the stall white with your warm sperm.  It lands on the walls and the floor mostly, but more than a good deal lands on Brooke and into her fur.  She's so out of it from her own orgasm that she barely even notices.");

		outputText("\n\nYou both pant hard.  Physically spent, you lean forward, letting the stall take most of your combined weight.  She remains in your grip, up against the wall, leaning over your head and pressing her breasts into your face.  Both of your hips keeping moving, just slightly, with each other, but it's clear to you both that you're done for now.  You do, however, take this opportunity to take her left breast into her mouth, your tongue searching under the wet fur for a nipple.  It doesn't take long before you find it and draw out another moan from your canine lover.");

		outputText("\n\n<i>\"Holy fuck, [name],\"</i> Brooke barely manages to say through her heavy breath.  You don't bother responding, keeping at lovingly servicing her breast.  <i>\"Sweet Marae, [name], holy fuck.  You... I mean, yeah, hot damn, you going to the gym was the best idea ever.\"</i>");

		outputText("\n\nEventually, your arms tire and you can't hold your ragged breath for long with the girl's nipple in your mouth, so you disentangle yourself from her.  As soon as you do, though, Brooke wraps her arms around your neck and strongly pulls you back, her lips colliding with yours, her tongue exploding into your mouth.  You're both tired, but still passionate – you return her kiss completely as [eachCock] deflates in the now-cold shower water.");

		outputText("\n\nFinally, enough is enough, and she lets you go.  <i>\"I have <b>never</b> been fucked like that before,\"</i> she says, her smile refusing to leave.  <i>\"I've had some good, rough fucks, but that was incredible.  I'll be walking funny for days.\"</i>");
		if (player.cockTotal() >= 2) outputText("  She looks down at herself, finally noticing the mess you've left all over her with your spare equipment.  <i>\"What a waste,\"</i> she says, so quietly that you don't think you were supposed to hear it.  <i>\"Looks like I still got some washing up to do.  Completely, absolutely worth it, though.\"</i>  She turns back to the shower, resuming her wash, even with the water as frigid as it's becoming.  <i>\"My back is nice and clean, [name], so don't feel like you gotta wait up for me.  You go run some more laps so you can fuck me longer next time.  You know when and where to find me.\"</i>[pg]You smile, reaching around her front and planting a loving kiss on her cheek, promising that it's a date before stepping out of the stall.");
		if (player.cockTotal() == 1) outputText("  She does you both the courtesy of shutting off the water, before you both turn to leave the stall, grabbing your towels on the way.  <i>\"It takes for-EVER to dry out fur after a good wash, [name], so don't wait up for me to finish.  You go run some more laps so you can fuck me longer next time.  You know when and where to find me.\"</i>[pg]You smile, wrapping your arms around her toned waist and planting another, closed-mouth kiss on her lips, promising her that it's a date.");
		outputText("\n\nYou grab your towel just before you leave, and you wrap it around your upper body, knowing that Brooke won't be able to help but watch you as you leave.");
		// Lust reduced to 0, sensitivity decreased by 2, fatigue increased by 10
		player.orgasm();
		dynStats("sen", 0-2);
		player.changeFatigue(10);
	}
	//{Female only}
	else if (player.hasVagina() && x < 0) {
		outputText(images.showImage("brooke-gym-female-specialscene"));
		outputText("You can barely keep up with her sheer, wanton desire as her hands grope your body and her tongue conquers your mouth.  You can tell from her squeezing that she's trying to lift your left leg up and across her hips, but, unable to grip or lift with her hands, all she can do is grunt in frustration as she instead takes to humping into you.  You do her a favor and wrap your leg around her anyway.");

		outputText("\n\nHer right hand strokes up and down your [hips] and [leg] while her other arm wraps around the small of your back, using her powerful forearms to pull you in close to her and press your abdomens together.  All the while she never stops humping, and her tongue doesn't stop fighting your own, forcing you both to breathe through your noses.  Her wet, pert C-cup breasts press against your own [chest] – she mauls your whole body, giving you no quarter or leeway, absolutely <i>intent</i> on having each and every part of you.  You hardly resist, though, instead melting into every action and ministration the needy Shepherd girl makes, rocking back with her, pulling her closer.");

		outputText("\n\nBrooke suddenly pulls her mouth away, leaving you breathless and panting, but she never even slows – her tongue travels from your lips to your neck, and from your neck to your collarbone and down to your [chest].  Her waist closes in, pressing her tight cunt against your lower stomach while her inner thighs clamp onto your right leg.  Her hungry mouth easily finds your left nipple while her hand pinches and plays with your right, and she begins to earnestly hump against your leg, rubbing you both in all the right areas.");

		//if (hasNippleCunts = true)
		if (player.hasFuckableNipples()) outputText("\n\nOnly moments after she begins licking and sucking at your breasts, she slows, then pulls back, looking at your nipples inquisitively.  She runs her thumb over one, pressing in, and gasps in surprise when it sinks in easily.  You moan, thrusting your chest out to her – she catches on quickly and starts rotating her thumb around, teasingly, intentionally.  You rock your body in time with her teasing, and she grins, recognizing the feminine response and the texture of the inside of your nipple.  She doesn't keep you waiting as she lowers her head back down, taking your other nipple back into her maw.");
		//[if (isLactating = true)]
		if (player.lactationQ() >= 200) outputText("\n\nYou feel your milk drip from your breasts as she licks and nurses, flowing easily into her mouth.  She quickly pulls back in surprise, her wide eyes locking onto yours for just a moment, before she smiles and licks her lips.  She experimentally squeezes your breast and pinches your [nipple] once more with her hand, and she barely manages to force out a few more spurts of your milk.  Once she confirms that she didn't imagine that, she dives back to your chest, sucking a tit back into her mouth, this time with a specific goal in mind.");

		outputText("\n\nYou return everything Brooke does to you.  You hump along with her, grind with her, move with her.  One hand cradles her head as she continues to service your [chest] while the other roves and admires every tight, well-defined muscle it finds as it explores her familiar shoulders and back, eventually travelling down to squeeze her powerful rump – decidedly unfamiliar territory so far.  You try to keep somewhat calm and composed, but, realizing that you're in a public shower and you really don't care how much attention you attract right now, you moan loudly as Brooke continues to dominate you.");

		outputText("\n\nBrooke pulls away from your [nipple] suddenly, standing upright and laying her forearms across your shoulders.  She growls at you, fiercely, greedily, and her eyes narrow lustfully, wanton, as she begins to push you down.  <i>\"Lick me, you hot bitch,\"</i> she demands, pressing her body into you even as she pushes you down.  <i>\"Eat my cunt.  Get down there and fucking eat me dry.\"</i>");

		outputText("\n\nIt's a rather sudden demand, but you're not about to argue, and she's not about to take 'no' for an answer.  You quickly drop to your knees, your face level with her abdomen, and you wrap your arms around her powerful, tense thighs, groping once more at her ass.  You lean in, nuzzling at her wet stomach fur and breathing hotly onto her pussy.  The fur around her crotch is thin, and though you can't tell how wet she is from the shower water, you can practically feel her searing heat from here.  She growls once more, thrusting her body towards you when you don't immediately dig in.  You don't waste any more time.");

		outputText("\n\nYour fingers dig into the flesh of her ass, pulling her closer, as your lips readily collide with hers.  All you feel is wet fur and all you smell is wet dog, but neither of these things deter you from your duty.  Your tongue rushes out, working in time with your lips as you lick and caress her vulva, refusing to penetrate for the moment.  Brooke moans appreciatively, thrusting her powerful hips and flexing her impressive stomach, wordlessly praising you for your talents and tending to her need.");

		outputText("\n\nYou rise just a bit, running your upper lip across her hard button, letting your tongue enter into her, but only slightly.  Again, Brooke grunts, her knees wobbling a bit, wrapping her arms around the top of the stall wall for support.  You don't forget to keep your hands busy, mauling at her ass forcefully, pressing, pulling, and stretching, and Brooke 'hahs' and 'ahs' along with every action.  Your fingers reach into the split of her cheeks: your left hand goes lower, running across her perineum, while your right stays higher, under her tail and pressing into her anal ring.  She's receptive of the action and bucks her hips conflictingly, wanting you to go deeper but wanting to keep your face pressed to her cunt.");

		outputText("\n\nYou both keep at it for the next few moments.  You continue to run your tongue in and out, over and under her pussy, reaching into and caressing against all the right spots.  It isn't too long before Brooke demands that you stand back up as she reaches down, hooking her fingers under your arms to drag you up herself.  She grunts, feeling how little of an effect her hands are having, and you pull yourself up largely without her help.  Despite her weakness, she demonstrates her strength by pushing you back against the wall with all her body, quickly going back to attacking your mouth with hers, not caring (or perhaps even wanting) that she tastes herself on you.");

		outputText("\n\nHer hands travel low, grasping and pulling at your [butt].  You lean into her, melting back into her kiss, and she presses her lower stomach forward.  It's a little awkward from your standing positions, but she manages to hook herself around your pelvis, and with a few experimental humps, she finds your [vagina] with her own tight, hot box, and from there, she starts roughly grinding herself against you.");

		outputText("\n\nYou both moan from the onslaught.  At first neither of you want to break the kiss, but as she picks up the speed of her tribadism, that becomes a harder and harder task.  Eventually she breaks away first, gasping for breath, fucking you in the shower, her hips pounding, grinding and sliding into and all over yours, beating you both raw with her undeniable passion.  You fight against her, hands reaching down to her powerful hips, gripping them tightly and matching her every thrust with your own.  Neither of you really speak beyond the occasional <i>\"fuck yes, holy shit,\"</i> and <i>\"fuck me\"</i>, too concentrated on the brutal sex instead.");

		outputText("\n\nBrooke begins to thrash, too excited and heated to keep to any pattern any longer.  You can tell she's close.  She growls and snarls, her eyes closed and her hands gripping onto most parts of you as hard as they can.  Every few seconds your clits bump against each other, and eventually, she reaches her breaking point: she howls, smashing you against the wall, and you can feel a warmness spread over your crotch, up your stomach, and down your legs.  Her humping slows just a bit, and you can feel each contraction she has all the way up her shoulders.  It's only a few seconds before you join her.");

		//[if (isSquirter = false)
		if (player.wetness() < 4) outputText("\n\nYou cum.  Your eyes cross and your mind fuzzes out on you for a moment.  You can't tell if you have one incredible orgasm, or one huge one and several smaller ones; regardless, your euphoria seems to have no end in sight as your canine lover continues to fuck against you.  You become dimly aware of everything your skin feels, from the beating of the chilling shower water to the heavy drag of Brooke's breast fur to the fine, ticklish fur on her pussy as she slowly stops fucking you.");
		//[if (isSquirter = true)
		else outputText("\n\nYou shake and quake yourself, feeling your orgasm overtake you.  You press as much of you as you can into her, feeling your juices burst from you and onto Brooke.  With each contraction you feel, you feel your own liquids squirt from your [vagina] and all over her, just as she's done to you.  Even in the chilling water of the shower, you feel another familiar wave of heat wash against your canine lover and up her own stomach.  Though your actions have slowed a bit, she continues to fuck against you, bringing herself to another, milder orgasm – not to be outdone, you fuck back, having a second one yourself.");

		outputText("\n\nFinally spent, she crashes onto you, leaning against your body as she catches her breath.  You can barely stand, yourself.  You both pant, saying nothing and doing nothing more.  The smell of your combined feminine musk permeates the room, even as your juices wash away in the cold shower water.  You both try to catch your breath – Brooke only makes it harder when she pulls back, giving you another loving, passionate kiss, her tongue not battling with yours this time, but dancing instead.");

		outputText("\n\nYou two share a more calm moment as she continues to make out with you in the shower.  When she pulls back, she looks deeply into your eyes, her brown irises sparkling.  She can't help the huge grin slowly spreading over her muzzle.  <i>\"Holy shit,\"</i> she eventually says – not exactly the most romantic phrase ever.  <i>\"You're amazing, [name].\"</i>");

		outputText("\n\nYou point out that she fucked you harder than you fucked her.  If anything, she's the amazing one.  She laughs a little sheepishly.  <i>\"Yeah, I... I guess I got a little into being the top this time,\"</i> she says.  <i>\"But don't sell yourself short, you hot bitch.  You kept up.  Not a lot of people can say they've fucked me back.\"</i>");

		outputText("\n\nShe leans her face in close, looking at you almost predatorily.  <i>\"I might even take that as competition.  We'll see how long you last next time, [name].\"</i>  You tell her that she's on, and she smiles, planting another, shorter, lovelier kiss on your lips.");

		outputText("\n\nShe pulls back once more, taking a deep breath through her nose.  <i>\"Damn, but don't we stink,\"</i> she laughs, finally disengaging you and turning back to the shower.  <i>\"I can't leave smelling like a bitch in heat.  I won't make it past the front door before getting swarmed by anything with a dick.\"</i>  She turns back to you, smiling playfully.  <i>\"Care to... stick around?  Just another innocent wash.  Promise.\"</i>");

		outputText("\n\nAs tempting as the offer is, you doubt that that's a promise either of you can keep.  You're exhausted, beaten and sore, and you know she is too, but who knows if either of you can restrain yourselves.  <i>\"Yeah, that's probably the better call,\"</i> she laughs, facing back into the water.  You grab onto your towel, still miraculously hanging onto the stall wall, and wrap it around your upper body, knowing that the Shepherd girl's eyes will be glued to you as you leave.");
		// Lust reduced to 0, sensitivity decreased by 2, fatigue increased by 10
		player.orgasm();
		dynStats("sen", -2);
		player.changeFatigue(10);
	}
	//{Herms only}
	else {
		outputText("Your hands waste no time in feeling and groping all over your new canine lover's body, appreciating every nuance of the tight muscles you feel under her short fur.  Her strong shoulders; her thick upper-back; her taut lower-back; and her tight ass.  [EachCock] rises in the excitement, reaching up between your bodies, scratching itself across her fine belly fur.  Your [vagina] likewise quivers in excitement, readying itself, though in Brooke's ravaging passion, you wonder how you'll be able to satisfy all of yourself, if you even can.");

		outputText("\n\nBrooke moves fluidly, her own hands returning the favor, gently gliding over every muscle and admiring everything they find.  Her right hand travels around your back with her left runs and combs through your [hair].  Her body grinds against you, her breasts heaving and pressing against your [chest].  She humps her hips up and against you, letting her tight vagina run and rub against your hard " + player.cockDescript(x) + ".  All the while her mouth hungrily explores yours, her long, fat canine tongue dancing excitedly in your mouth, learning everything there is to know of your own.");

		outputText("\n\nShe's relentless.  You feel her every excited movement – the claws on her hands rake through your [hairOrFur] and the heat of her belly presses into yours, the strength of her six-pack abs making itself known.  Her mouth eventually, almost reluctantly, pulls away from yours, gasping for air, but she doesn't spend much time recovering as she immediately starts laving your neck with her tongue.  Her hands continue to explore, one gripping softly at your love-handles while the other dips lower, approaching the height of your [butt].  She's deliberately avoiding contact with your " + player.cockDescript(x) + ", save for teasing it roughly with her abdomen as she rocks against you.");

		outputText("\n\nYour hands roam in time with hers, and just as she comes to the fat of your ass, you come to hers (as little fat as there is).  You grip, squeezing as much as you can into your palms, and you're simultaneously excited and disappointed when the tightness of her bottom prevents you from gripping much.  Not to be outdone, she pulls her claws against the skin of yours – knowing she unfortunately can't actually grip yours, she does the next best thing.  Wantonly, you slap both her ass-cheeks as hard as you can, making her yelp and jump, then immediately coo.");

		outputText("\n\nShe keeps you pinned against the stall wall as she lowers her body, bringing her head to your [chest].  Eagerly, she begins licking the flesh of your breasts, using her tongue to heft and drag the fat of them with each lick, slowing and moaning every time she hits a [nipple].");
		//[if (hasNippleCunts = true)]
		if (player.hasFuckableNipples()) outputText("\n\nYou shudder and moan each time her tongue caresses your sensitive nipple-cunts.  At first she takes your reaction to just mean you have sensitive nipples, but on her second pass, she notices the odd textures – unfamiliar with any nipple she's ever tasted.  She doesn't lift her mouth off: instead, she keeps still, her tongue tasting and moving, making you squirm and buckle helplessly under her ministrations.  She eventually figures it out, and removes herself, grinning wickedly, not wanting to spoil the fun too quickly.");
		//[if (isLactating = true)]
		if (player.lactationQ() >= 200) outputText("\n\nYou feel your milk slosh in your [chest] and trickle out from Brooke's insistency.  She doesn't realize it immediately, the milk diluting with the shower water, but soon enough, she pulls back, licking her lips inquisitively, her eyes squinted in thought.  She squeezes the nipple again, and her eyes widen when she sees the white fluid drip from you in response.  Grinning, she dives back in, hungry and intent for more.");

		outputText("  She finally drops her hands down, one wrapping and caressing carefully, diligently, around your " + player.cockDescript(x) + " while the other trails the cleft of your [butt], a single claw running between them and towards your taint.  She doesn't waste a moment when she finds your [vagina] instead of plain skin, apparently not unfamiliar with multitasking.");

		outputText("\n\nYou grind your hips on Brooke's hands as one glides easily up and down your lubricated " + player.cockDescript(x) + " while the other begins to gently pump into your [vagina], all the while her tongue continues to bathe your [chest].  You cradle her head in your own hands, unable to do much else with how she's treating your body.  Finally, she gets down to business, dropping to her knees and bringing herself face-to-face with your equipment.");

		//[if (cocks = 1)]
		if (player.cockTotal() == 1) outputText("\n\nShe can hardly contain herself as she sets her tongue to work once again.  She opens wide and sucks you into her, clamping her mouth gently shut around your meat, minding her teeth.  She takes it slowly, in contrast to her apparent eagerness: she eases her head down, slowly taking it more and more, until her nose presses against your pelvis and she slowly begins to rise back up.  However, all the while, her tongue is going a mile a minute, pressing and playing, teasing and tasting, working every nerve you have in your sensitive " + player.cockDescript(x) + ".  The attentions make you melt into her mouth, and the sounds of her 'mmm'ing with every pass just get you that much more excited.");
		//[if (cocks = 2)]
		if (player.cockTotal() == 2) outputText("\n\nShe looks almost ecstatic, seeing [eachCock] up close.  She keeps her left hand busy with your [vagina], and puts her right back to work stroking your " + player.cockDescript(x) + " while she eagerly swallows your other penis.  Her left hand thrusts into you, pressing and searching your pussy, gently trying to find your G-spot.  Her right hand pumps your " + player.cockDescript(x) + " eagerly, sensuously sliding up and down, gripping the base as tight as she can in one motion then rubbing the head carefully and expertly the next.  Her mouth takes its time crawling down the length of your second erection, her head going slowly but her tongue excitedly wrapping and worshipping it on the inside.  Her expertise is impressive, really, and you voice your appreciation with dumb, happy moans as she does everything she can to you.");
		//[if (cocks >= 3)]
		if (player.cockTotal() >= 3) outputText("\n\nShe looks at each of your [eachCock], wide-eyed – she almost looks lost, staring, entranced by the multitude of dicks you're sporting.  She whimpers, nearly pulling her left hand away from your [vagina] so she can use everything she has to pleasure your masculinity, but resolves instead to keep it there, knowing just how important it is to not ignore your femininity.  She gets to work with what she has: her right hand pumps your " + player.cockDescript(x) + " quickly, pleasurably and deliberately, while her mouth takes your second dick, her eagerness apparent, gliding as far down as she can and keeping herself there for but a moment, her tongue lathering and laving, worshipping as much as it can, before she pulls away reluctantly and takes your third prick into her mouth.  She attempts to pleasure as much of you as quickly as she can, her whole upper-body working overtime on your [eachCock].  You're too pleasure-drunk to stop her, and from the look on her face, she's having the grandest time anyway.");
		if (player.balls > 0) outputText("  Every once in a while, her head dips low, suckling on the meat she has, and she slips her tongue out, running across what she can't reach and cupping your [sack] with the tip of her long, heavy dog tongue.  Occasionally, her left hand slips free from your snatch to get a quick fondle of your [balls] before dutifully returning to work.");

		outputText("\n\nYou tremble and whimper, approaching your edge with the things Brooke is doing to you.  She's very skilled, and she uses everything she knows to bring you to your climax – seemingly, anyway.  She recognizes the telltale signs of your approaching orgasm, and she angrily stands up, bringing herself to your eye level.  <i>\"Don't be rude,\"</i> she chastises, reaching around behind you and gripping onto the stall wall you're leaning on.  She lifts one leg and wraps it around your [hips], lining her hot, tight twat with your " + player.cockDescript(x) + " but refusing to make the first move.  <i>\"I know you weren't thinking of finishing without me.\"</i>  You assure her that you wouldn't dream of it.  <i>\"Good.  Get to work.  You have some ground to make up.  Show me what your hot bod can do.\"</i>");

		outputText("\n\nYou grin and take the invitation gladly.  You grip onto her own hips tightly, admiring the feel of her body under your palms, as you thrust into her.  She gasps and stutters, mouth dropping agape once your wet " + player.cockDescript(x) + " is thrust imperiously into her, through no small effort on your part.  Her bravado wavers and her arms buckle as her weak grip tries to keep her steady.  You, though, just stand there for a moment, enjoying the feel of her velvet cunt accepting you as it had.  She's tight, amazingly so – for someone with so much experience pleasuring a herm like yourself, she seems almost virginally tight.");

		outputText("\n\nShe takes a moment to recompose herself.  <i>\"Hot enough for you?\"</i> she asks.  You refuse to let her think you're not up to the task, and begin to rock your hips.  She reciprocates, relaxing and exhaling with every draw out, and tensing and inhaling with every push in.  Her pussy clenches and relaxes with her every movement.  <i>\"Every muscle,\"</i> she emphasises like a braggart.");

		outputText("\n\nHer request not-forgotten, you put everything your body has into fucking the Shepherd girl.  You're determined to fuck her until she regrets doubting you.  Your hands travel down to her ass, gripping hard for leverage, as you pump your " + player.cockDescript(x) + " in and out with everything you have.  Brooke's grin fades underneath her swishing light-brown hair and beneath the sheen of the water still clinging to her face while you ravage her.  Her tongue lolls and spittle sometimes convulsively flings from her slack mouth.  Her hands move from the stall wall to your neck, and she looks down at you – her expression is difficult to read, as focused as she is on the pounding you're giving her.  Nonetheless, her brown eyes never leave yours.");

		outputText("\n\nHer breathing comes out ragged, rising in pitch the longer and harder you go without slowing the littlest bit.  Her breasts bounce with the rest of her, and eventually, she lifts her other leg, forcing you to carry all of her weight in your hands.  You grunt with her, fucking her, feeling her vice down on your " + player.cockDescript(x) + ", her voice ascending the closer she gets.  <i>\"Fuck!\"</i> she says occasionally, not having the energy to say it much louder than her senseless moaning.");

		outputText("\n\n<i>\"Fuck yes, [name],\"</i> she chants every once in a while.  <i>\"Fuck me, you dirty herm bitch.  Show me what you got.  Cum in me, [name], fucking give me all you got.\"</i>  You say nothing in response, and simply keep doing what you're doing.");
		//[if (hasBalls = true)
		if (player.balls > 0)
		{
			if (player.findStatusEffect(StatusEffects.Uniball) < 0)
			{
				outputText("  Your [sack] swings with every pump, slapping onto the firm skin of Brooke\'s vulva every time you bottom out.  You feel no pain, and in fact the smoothness of her fur around her genitals tickles the cum out of your [balls] all the faster.");
			}
			else
			{
				outputText("  Your [sack] is to tight and smooth to swing, but it still slaps against the firm skin of Brooke\'s vulva every time you bottom out.  The smoothness of her fur around her genitals tickles the cum out of your [balls] all the faster.");
			}
		}

		if (player.cockTotal() == 1) outputText("  You drill into that canine pussy, giving Brooke everything you have.  Your body burns and your cum churns the longer you go.  Her voice ascends from pitiful puppy whining to the jubilant cries of a woman well fucked, and the rise of her yells bring with them the rise of your cum.");
		if (player.cockTotal() == 2) outputText("  Your second penis swings, cold and alone, between your body and Brooke's as you continue to saw into her with your " + player.cockDescript(x) + ".  The tip points up to the cleft of her swinging, pounding breasts, ready to erupt and coat the underside of her tits with your offering.  She knows of it, and she does what she can to pleasure it, but even her well-defined six-pack can only do so much.");
		if (player.cockTotal() >= 3) outputText("  Unfortunately, as much as both you and Brooke want to pleasure as much of you as possible, she can only do so much.  [EachCock] thrusts into nothing between you, each of them stiff and pointed right up at her face – if they can't cum inside her, then they'll jealously paint her white on the outside.");

		outputText("\n\nShe howls to the ceiling as her body convulses, unable to contain herself anymore.  She orgasms hard, squeezing your " + player.cockDescript(x) + " hard, making your last few thrusts all the sweeter before you cum yourself.");

		//[if (cumNormal = true)]
		if (player.cumQ() <= 250) outputText("  Your cum erupts into the Shepherd girl, pumping into her hard, and she continues to coax as much as she can with each ripple her orgasm gives her.  It's the grandest orgasm you've had in some time, and it takes a good few moments before you finally calm down.");
		//[if (cumMedium = true)]
		if (player.cumQ() <= 500) outputText("  Your fluid pumps into her hungry cooch with abandon: each of your heartbeats begets a pulse through your " + player.cockDescript(x) + " and into her womb.  She continues to shout with each of her convulsions, her voice slowly and steadily descending as her own orgasm subsides.  It takes you a moment to calm down, yourself.");
		//[if (cumHigh = true)]
		else if (player.cumQ() <= 1000) outputText("  Urgently, your cum floods into her, pumping into her with each heartbeat.  She feels it all and squirms with each new squirt she manages to pull out of you – she continues to rock her hips, her howling from her orgasm keeping up with your own.  She holds you tight with her powerful legs, intent on not letting a drop go.");
		//[if (cumVeryHigh = true)]
		else if (player.cumQ() <= 3000) outputText("  You orgasm powerfully, the cum ripping through your " + player.cockDescript(x) + " and into her with a force she's never experienced before.  Her howling is cut short as she doubles over, pressing her tits into your face, her hips desperately rocking into yours every time you deposit another spurt.  Her stomach begins to lose some definition from the sheer amount of cum of pumping into her, but from how she continues to convulse even long after her initial orgasm, she seems to like it.");
		//[if (cumExtreme = true)]
		else outputText("  Your orgasm is undeniable, the initial blast into her womb barely even a hint of the torrent following behind it.  Her howl is cut short as she feels her womb fill so full, so immediately, and then she howls again, even louder, as you continue to relentlessly pump your semen into her.  Her stomach not only loses its six-pack definition, but it actually begins to balloon slightly, nearly suggesting that she's not all muscle.  Her orgasm either never stops, or she has more than a few – you're not positive.");
		//[if (cocks = 2)]
		if (player.cockTotal() == 2) outputText("  Your second phallus erupts in time with its brother, spraying into the air uselessly, but coating the underside of Brooke's breasts just as it promised it would.  Your cum erupts in equal parts from both dicks, soaking into her fine fur, blending in with the white strip of fur running down her torso.  She'll definitely need a second rinsing after this.");
		//[if (cocks >= 3)]
		if (player.cockTotal() >= 3) outputText("  [EachCock] not inside her sprays out in time with their lucky brother, aimed right at her hunched, humping body and coating it all with your cum.  Her tight thighs, her taught belly, her ribs, her round tits, and even as high as her collarbone and her face each get a hefty blast of your cum, fulfilling their unspoken promise.");
		//if (isSquirter = false)
		if (player.wetness() >= 4) outputText("  Your poor, lonely pussy erupts with the rest of you, coming in a torrent.  It robs whatever energy remains in your body for itself, and you buckle your knees, nearly falling with Brooke still in your arms.  You become aware of every sensation between your legs – from the water dripping down between your legs to the feel of your own heartbeat energizing your vulva.  You simultaneously crave something long and hard to drive into you, and want nothing of the sort, afraid the slightest of stimulation will send you reeling once more.");
		//[if (isSquirter = true)
		else outputText("  Whatever's left of your energy goes into your neglected cunt as it erupts itself, spraying its own juices down your legs and onto the shower floor.  Your pussy quivers and cums long and hard, squirting in time with [eachCock], the warm fluids mingling and contrasting with the cooling shower water.  As it winds down with the rest of you, you're conflicted between reaching down and giving your feminine half some special attention, and simply not touching anything, afraid that the sensations would be too much for your addled body.");

		outputText("\n\nYou both buck against each other for a few moments longer, letting yourselves wind down from the intensity of your lovemaking.  You both occasionally spasm and thrust slightly, drawing it all out, but you both know it's over.  She takes her time to disengage from you, letting you run your fingers lightly across her skin while you both catch your breath.  The shower water's long since turned ice-cold, though it's steamy enough between you two.");

		outputText("\n\nYour head is hung, her tits in your eyesight but you're not really paying attention to anything as you catch your breath.  You feel a gentle thumb and finger wrap around your chin, drawing your eyes up.  Before you know it, your lips are closed with hers as her tongue once again tangles with yours.  While just as passionate as ever, there is considerably less ferocity.");

		outputText("\n\nYou bend your [legs] slightly and move your hands gently up her back, wordlessly telling her to stand on her own.  She moans, disappointed, but complies, and she eventually pulls away from you.  You're both panting hard, feeling as though you've been worked over far harder than any machine in the gym could do.  <i>\"Holy shit,\"</i> she says.  Hardly the most romantic phrase, but succinct and appropriate.");

		//[if (cocks >= 2)]
		if (player.cockTotal() >= 2) outputText("\n\nHer eyes wander, unfocused and dazed but absolutely lit up.  She leans back against the opposite wall of the stall and lets her hands run across her body.  She picks out your cum that came from your unloved dick; most of it washed off, but not all.  Still reeling from the sex, she mindlessly licks what little she found off her fingers.  Only when the taste hits her tongue does she realize what she just did, but from the look of her, she doesn't really care.");
		outputText("  She looks you over, leaning against the opposite wall, draping her arms over the top edge.  You're both tired, but thoroughly sated.  <i>\"Not bad\"</i> she eventually says, teasingly.  You don't really respond; you just grin up at her knowingly.  <i>\"Could be better.  Hit the gym some more, and maybe you'll have the stamina to keep up with me.\"</i>");

		outputText("\n\nYou laugh, approaching Brooke and giving her a slap on her thigh.  Her skin doesn't yield at all and her body barely flinches from the strike.  Still, she plays along, 'ooh'ing after your playful slap.  <i>\"All right, I'll be honest, [name], that was something else.\"</i>  She leans forward, wrapping herself lovingly around you once more.  <i>\"Next time I'll only put half as much effort into working out so I'll have more energy to fuck you with.  You better return the favor, you hot bitch, or I won't play nice next time.\"</i>");

		outputText("\n\nYou ask if that's a promise.  She simply laughs, and kisses you once more, mouth closed.  <i>\"We should probably finish washing up,\"</i> she suggests.  <i>\"We don't want to leave this place dirtier than when we came in.\"</i>  As much as you're enjoying the afterglow, you concede her point.  You share the same stall as you help each other rinse off – taking care not to make it any more intimate as it is.  You wouldn't want to run the gym's water bill any higher than you already have.");

		outputText("\n\nFinally turning the frigidly cold water off, you each make a show of drying yourselves off.  Despite how bow-legged Brooke is moving and despite the wear your " + player.cockDescript(x) + " is feeling after such a workout... well, to put it one way, you can't wait until you meet her again after this.  Miraculously, you both manage to keep your hands to yourselves, and the rest of your drying ends without incident.  She blows you a kiss before she leaves the locker room, and, after a vigorous dry, you put your [armor] back on and leave the gym.");
		// Lust reduced to 0, sensitivity decreased by 2, fatigue increased by 10
		player.orgasm();
		dynStats("sen", -2);
		player.changeFatigue(10);
	}
	brookeAffection(10);
	doNext(camp.returnToCampUseOneHour);
}

// Affection = 70, after first-time sex, talk to Heckel between 13:00 and 15:00, must not be a first-time encounter with Heckel, requires a gender
public function specialHeckelAndBrookeEncounter():void {
	clearOutput();
	outputText("You stroll into the gym, looking for Heckel, but she's not at her usual routine, running laps around the gym.  The gym itself is a little bare; there aren't a lot of people using the machines dotted around the room.  Perfectly good and ready machines, barbells, bench-presses, et al sit ready and waiting for someone to test their mettle on them.");
	outputText("\n\nIn one of the corners of the room, you hear a bit of a commotion.  Despite the size of the room, the echoes of the commotion make it a bit confusing as to just where the noise is coming from.  Do you look to your left, towards the butterfly machines, or do you look to your right, towards the leg press?");
	//[=Butterfly=] [=Leg Press=] [=Leave=]
	menu();
	addButton(0,"Butterfly",butterflyMachinesGooooo);
	addButton(1,"Leg Press",legPressInsteadOfThreesome);
	addButton(4,"Leave",leaveHeckelEncounter);
}

//[=Leave=]
public function leaveHeckelEncounter():void {
	clearOutput();
	outputText("Well, whatever.  You came here looking for Heckel, and she's not here, as far as you can tell.  You turn around and leave the gym, without investigating the cause of the commotion.");
	//Return to Tel'Adre, no time loss
	menu();
	addButton(0,"Next",kGAMECLASS.telAdre.telAdreMenu);
}

//[=Butterfly=]
public function butterflyMachinesGooooo():void {
	clearOutput();
	outputText("You look to your left, seeing a group of people standing around a pair of the butterfly machines in the distance.  Anthromorphic animals of all shapes and sizes stand shoulder-to-shoulder, 'ooh'ing at whatever spectacle it is they're keeping you from seeing.  You approach, and you manage to worm your way between a pair of buff matrons, intent on getting a better look at what the fuss is.");

	outputText("\n\nThere, one on each machine, is Heckel and Brooke, each gliding through their reps.  The muscles on their arms bulge and their tits press out into their tank-tops with each press, and, going from the movement in the back of the machines, they've both got an absurd amount of weight on, far too much for you to guess just by eyeballing them.  You turn to the dog on your right and ask how long they've been going at it; he answers, 'for too long'.");

	outputText("\n\nHeckel has a confident grin on her face, exhaling with each press and inhaling with each ease.  She's going quickly and easily, and if it weren't for the sweat on her brow, you'd think she'd just stepped in with how much energy she had.  Brooke, meanwhile, looks determined but unfocused, and her reps are decidedly slower – she takes a while going in and she eases off too quickly.  Her eyes fall on yours, and she feels a burst of energy for but a moment, but after only a few more reps, she collapses in the chair, her arms immediately going limp.");

	outputText("\n\n<i>\"Done?\"</i> Heckel asks, looking to Brooke, her arms never stopping their constant movement.  Brooke doesn't answer, looking up to the hyena disdainfully, but eventually she hangs her head, defeated.  Her arms are so tired, she can't even hide her face behind her hands.  <i>\"Fine, I guess I am too,\"</i> says Heckel, easing the weights back down and stepping off the machine.  She moves fluidly and gracefully, even stretching her arms and her back a bit, showing off her muscles to the crowd.  She moves like she had only just woke up.");

	outputText("\n\n<i>\"Top dog once again,\"</i> she laughs, high-fiving some of the people in the crowd.  <i>\"I even did you a favor and let you take me to the butterfly machines when I could have taken you to the bench-press.  It just didn't feel right, picking on your weakness, you know?  I had to beat you at your strength.\"</i>  Brooke continues to not respond, and she shakily hoists herself out of the machine.  As soon as she does, Heckel grabs her by the collar of her tank top, pulling her face in close.  She mouths a few words, whispering too low for you to hear, but you can make out an expletive or two.  Brooke's face goes a bit pale.");

	outputText("\n\nHeckel practically drags Brooke behind her, making her way through the crowd, and she just happens to pass by you.  She pauses slightly, before realizing who you are.  <i>\"Oh, [name],\"</i> Heckel says casually.  <i>\"Enjoy the show?\"</i>  She grins proudly, and rather than answer, you ask her what she plans to do with Brooke.  <i>\"Well... \"</i> she hums, looking back to her victim.  Brooke's still a bit shaky, weak from all the exercise, but at least meets Heckel eye-to-eye.  <i>\"I could tell you, but you know what?  Fuck that.  You're coming too.\"</i>");

	outputText("\n\nHeckel uses her other hand to grab you by the collar of your [armor], and, before you have a chance to object, presses her lips to yours, aggressively slipping her tongue in for a brief moment.  Some of the matrons from the crowd behind you whistle and cat-call, but you're too stunned from the reaction to reply, and before you know it, you and Brooke are pulled into the locker rooms.");

	//[=Next=]
	menu();
	addButton(0,"Next",brookeAndHeckelStuffPartTwo);
}

public function brookeAndHeckelStuffPartTwo():void {
	clearOutput();
	outputText("She kicks open the door to the locker room, and promptly tosses you both in.  Brooke flops onto the closest bench, exhausted, but you merely stagger, still alert and with your wits about you.  <i>\"Strip,\"</i> Heckel commands, eyeing you dominantly, before she moves to Brooke and, gripping onto her tank top with both hands, easily rips it open, revealing Brooke's braless breasts underneath.  Heckel, with surprising eagerness, grips her own shirt with one hand and her shorts with the other, tugging them apart and wiggling out of them simultaneously with practiced speed.");

	outputText("\n\nHeckel pushes Brooke down so the Shepherd girl is lying flat on her back, and quickly straddles her by the waist.  Naked from top to bottom, Heckel grips Brooke around the ribs and begins roughly grinding her bare cock against her belly.  Brooke moans a bit, her arms hanging limply at her sides while the hyena has her way with her.  Heckel's black dog dick remains semi-limp, only straight enough to not drag through Brooke's fur, but that changes with each wanton thrust.");

	outputText("\n\n<i>\"Hurry it up,\"</i> Heckel says gruffly at you, noticing that you've taken to watching her rough dominance instead of stripping down like she's told you to.");
	outputText("\n\nDo you comply?");
	menu();
	addButton(0,"Yes",submitHeckelXBrookeThreesome);
	addButton(1,"No",nopeOutofBroke);
}

public function nopeOutofBroke():void {
	clearOutput();
	outputText("You shake your head at Heckel, not feeling like playing second fiddle today.");
	outputText("\n\nThe muscled hermaphrodite shrugs and chortles, \"<i>Suit yourself.  This bitch...</i>\"  She grope's Brooke's tit.  \"<i>...knew the rules of our little wager.</i>\"");
	outputText("\n\nYou aren't exactly pleased with the situation, but what these two get into in their free time is their business. Before you go, you ask Brooke if she's okay with this.</i>\"");
	outputText("\n\n\"<i>Save yourself while you still can; I'll catch up in a bit.\"</i>  You ask if she's sure, and in response, she lovingly kisses the inside of your thigh.  <i>\"Sure I'm sure, sweet thing.  You have things to do, I bet.  Just get going.\"</i>");
	outputText("\n\nYou leave, chased out by lewd, lusty slurps.");
	brookeAffection(1);
	doNext(camp.returnToCampUseOneHour);
}

public function submitHeckelXBrookeThreesome():void {
	clearOutput();
	outputText(images.showImage("brooke-gym-heckelbrooke3some"));
	outputText("Once you snap out of it, you comply, hastily removing your [armor] and leaving you just as naked as her.  Although you never really agreed to something like this in the first place, you <b>did</b> come here to see Heckel for a reason, and seeing the two of them like they are <b>is</b> really hot...");

	outputText("\n\nHeckel smiles when she sees you've finally complied.  Her ten-inch dog dick, now fully erect, stands just a bit away from Brooke's taut belly, pointing right at the Shepherd girl's face.  She stands up, pulling herself away from Brooke, and roughly grabs her by the wrist, pulling her onto the floor so she can have the bench to herself.  Heckel sits, splaying her legs, letting her fist-size testicles hang low and her proud, hard dick standing tall.  Brooke pulls herself to her knees, understanding what Heckel intends, but the hyena keeps her at bay with her knee for the moment.  Instead, Heckel looks at you and crooks her finger, telling you to approach.  You do.");

	outputText("\n\nOnce you're in arm's length, she grabs you by the wrist and, with an unsurprising amount of strength, pulls you to your knees too, next to Brooke.  <i>\"[name], dick,\"</i> she says simply, grabbing you by the back of your [hair] and pulling your mouth halfway onto her cock in one swift motion.  She places her other hand behind Brooke's hair.  <i>\"Brooke, balls,\"</i> she says, and pulls Brooke's face against her testicles, thrusting them onto her lips and, by extension, her cock into your mouth.");

	outputText("\n\nThe swiftness and the ferocity of the actions take you aback for a brief moment, but, with the familiar taste and feeling of Heckel's dick in your mouth, you begin your task of sucking her off.  You close your lips around her dog-dick, laving the underside of the tool with your tongue gently, drawing it up and around the hard meat that's been thrust into your mouth.  You move your head slowly in a circular motion, mindful to not bump into Brooke below you, as you let the cock in your mouth cover the inside of your cheeks alternately.  Heckel doesn't make a sound, but she removes her hands, letting you both work at your own pace.");

	outputText("\n\nBrooke takes a bit longer than you to start up, and a bit longer still to pick up the pace, but she gets to work eventually.  You can't really see much from your angle, but judging from the movements she's making and from the sound of her tongue sloppily licking, rubbing, and covering Heckel's testicles, you hazard a guess she's probably been in this position before.  It's difficult to coordinate with her with both of your mouths occupied, but eventually you two settle into a rhythm of you slowly and reverently sucking and kissing Heckel's rock-solid cock and Brooke pleasingly and worshipfully bathing the pair of testicles presented to her, one after the other and back again.");

	outputText("\n\nYou trail your eyes up the hyena's face, across her perfect six-pack abs and her perky B-cup breasts, up to her eyes.  She's leaned back into the locker behind her, with both hands resting behind her head.  Her eyes are locked onto yours as she grins, still on the huge rush of being proven undoubtedly that she was the top dog once more, and reaping the benefits of it.  You feel her heartbeat through the hard dick in your mouth, and with each pulse, it stands just a little taller, a little prouder, and a little longer.  The knot at the base of her cock inflates steadily, about the size of a small ball, but growing quickly.");

	outputText("\n\n<i>\"Switch\"</i>, Heckel says simply, and you and Brooke comply, both of you a little eager yourselves.  With some reluctance you pull your mouth from Heckel's dog-dick, only for Brooke's mouth to take over, while you slide down to Heckel's impressive fist-size pair of testicles, slick and shiny from Brooke's work.  You don't waste any time in pressing your own face into her sack, doing Brooke's old job, licking, kissing, and loving those huge nuts with your mouth.");

	outputText("\n\nYou have a much better smell of Heckel's familiar musk from this new vantage point – the smell of the savannah; a smell you've grown somewhat acquainted to.  You do your duty with gusto, opening your mouth wide and doing your best to suck in a whole ball gently, while still coating it in a layer of your own spittle.  The black of her skin bends and yields with each of your insistent licks and nuzzles, leading you around the surface of her scrotum before you find yourself comfortably within the crevice of her two bloated balls.  You lick and suck, your tongue covering top to bottom.  You find yourself almost dejected that Heckel refuses to give you the command to suck her pussy, but nonetheless, you continue.");

	outputText("\n\nAbove you, Brooke is just as busy as before, though she doesn't have your approach.  She goes at Heckel's cock hungrily, devouring as much as she can in one swing repeatedly.  She practically throws herself down, impaling her throat on Heckel's penis, using her tongue to cover whatever she can't reach with her lips.  Often, she stays down, deep-throating Heckel's cock as long as she can while she bathes the knot with her tongue before pulling up for air.  The whole time, Heckel barely makes a move – she doesn't thrust, or keep her hands on your heads, perfectly content with letting you both do all the work.");

	outputText("\n\n<i>\"Stop,\"</i> Heckel commands, and you both comply, out of breath and panting from your services to the top-dog of the day.  <i>\"Brooke, you stand.  [name], stay down.\"</i>  You obey, curious as to what she has in mind, while Brooke stands, still a little wobbly from the workout before.  She's still wearing her workout shorts, and you can easily tell from your viewpoint that they've been soaked through with her arousal.  Whether or not Brooke has a submissive side, she's definitely getting off on the treatment.");

	outputText("\n\n<i>\"Take off her shorts for me, [name].  Slowly.\"</i>  You do so, gripping onto the hem of Brooke's shorts and slowly pulling them down from her waist.  The juices from her puffed cunt drip down with the cloth, and immediately the heady smell of her arousal assaults your nostrils.  Heckel takes a long drag of the smell herself, even from where she's sitting.  <i>\"That's what I like,\"</i> she says lowly, and you can see Heckel's cock bulge even longer and thicker, with the pole reaching a good foot and a half and the knot billowing to the size of a melon.  <i>\"On all fours, bitch,\"</i> she commands, pointing to the floor, <i>\"and [name], you sit on the bench.\"</i>");

	outputText("\n\nYou both go along with her commands; with Brooke on all fours on the floor, tail held high in the air while Heckel circles around, awaiting the final punishment for challenging the alpha-dog.  <i>\"I love it when you try to assert that you're better than me, Brooke,\"</i> Heckel says lowly, stepping forward and hot-dogging her cock between Brooke's firm ass.  Brooke only whimpers in response, too aroused to try and fight back.  <i>\"Putting you back where you belong is just the best feeling.  And we even have some company this time.\"</i>  She reaches forward and roughly tugs on Brooke's hair, pulling her head back and lifting her face level with your crotch.  <i>\"You're the bottom bitch today, Brooke.  The very bottom.  Get to work.\"</i>");

	outputText("\n\nAt that, Heckel pulls back, and, with lightning reflexes, lines her shot up with Brooke's waiting, hungry hole and thrusts forward.  No warning, no foreplay.  Brooke cries out in surprise, paralyzed with the sudden force and pleasure at finally being fucked by the alpha of the day.  She ignores your ");
	if (player.hasCock()) outputText("hard cock");
	if (player.cockTotal() > 1) outputText("s");
	if (player.gender == 2) outputText("wet, waiting vagina");
	outputText(", too out of it from the sudden penetration to do as Heckel said.  In response, Heckel thrusts forward much harder, roughly shoving a good third of her dick into Brooke's cunt.  <i>\"<b>Now!</b>\"</i> she demands, pushing her skull forward into your crotch, and finally, Brooke gets the sense to obey.");

	outputText("\n\nResting her forearms on the bench for support, Brooke lunges forward, ");
	if (player.hasCock()) outputText("engulfing your " + player.cockDescript(0) + " into her warm, busy mouth");
	if (player.cockTotal() == 2) outputText(" while she strokes your second dick with a free hand, wobbly balancing herself on her other, tired arm");
	if (player.cockTotal() >= 3) outputText(" while she does her best to please your [eachCock], massaging one with her fingers and shoving the others in her mouth, sometimes at once");
	if (player.hasCock()) outputText(".  Brooke and Heckel move at the same pace: the Shepherd girl, eager to please, does all she can with her mouth, sucking, bathing, and worshiping your tool, ");
	if (!player.hasCock() && player.hasVagina()) outputText("burying her muzzle into your [vagina] and immediately gets to work digging and searching your tunnel with her warm, moist, energetic tongue.  She licks, kisses, and worships everything from your vulva to your [clit] and when she gets bored of that, she thrusts her whole face into you once more, finding some new depth neither of you thought she could reach.  All the ");
	outputText("while the hyena behind her pounds into her cunt with an unusual ferocity, atypical of how you know her.  Whether Heckel is just unusually aroused or she's taking the whole 'dominant' role more personally with Brooke, you're unsure and uncaring, if it means getting this sort of action.");
	if (player.gender == 3) outputText("  Brooke, knowing of your duality, releases your cock from her mouth and dips lower, snaking her tongue below you and running it deliciously over your feminine sex.  Despite her weak hands, she does absolutely everything she can with what reach she's given, and you lean back, sliding your ass forward a bit to give her better reach to everything you have.");

	outputText("\n\nHeckel's really pounding into Brooke, giving her absolutely everything she has in her tense, powerful frame.  Seeing Heckel's muscles move and flex with each thrust into another chiseled, powerful frame underneath her is quite the sight.  The hyena's cock has still about a third or so to go, including the knot, but Heckel's working hard to rectify that.  Brooke tries to keep her focus on you while she works, and, with her effort and the sight of Heckel and her amazing body absolutely going to town on Brooke and her own amazing body, you won't be able to hold back for long.");

	outputText("\n\n<i>\"Sometimes I wonder about you, Brooke,\"</i> Heckel says calmly, her thrusts never slowing but her voice smooth and casual.  <i>\"Sometimes I have to wonder if you're not throwing these little matches between you and I.  Granted, you're pretty built.\"</i>  She slaps down on Brooke's ass <b>hard</b>, making the girl beneath her jump and squeal from the sudden pain, but she doesn't relent on servicing you.  <i>\"You can lift with the best of them, even with your fucked up hands.  But more often than not, here you are, getting fucked raw by your alpha.\"</i>  If Brooke is even paying attention, she's not showing it.  <i>\"Maybe you just want some good, hard, hyena dick and you're too proud of yourself to ask for it.  Or maybe it's not the dick; maybe it's Heckel you can't get enough of.  Maybe you keep on crawling back to Heckel because you get off on being fucked by the top dog and the second-bests just aren't cutting it.\"</i>");
	if (player.hasCock()) outputText("  You might have taken offense to the idea you're not as good a fuck if you weren't too focused on the amazing blowjob Brooke's giving you.");

	outputText("\n\n<i>\"Well, whatever the case,\"</i> she says, slowing her humping just a bit so she can lean forward.  Her pert B-cup tits rest on Brooke's toned back while her hands wrap around her torso, gripping onto the Shepherd's own C-cups, <i>\"you're here now.  You're getting the dick.  And believe me,\"</i> she says, her thrusts speeding up, her ferocity increasing, her show of dominance being utterly clear to the girl beneath her as she's fucked so raw and her tits are groped and manhandled, <i>\"you are getting,\"</i> thrust, <i>\"<b>every</b>\"</i>, thrust, <i>\"<b>iiiiiiiiiIIIIIIIIIINCH!</b>\"</i>");

	outputText("\n\nWith a roar and one last push, Heckel lunges forward, burying her cock into Brooke's pussy, knot and all.  Heckel's movements don't stop, but they're hugely limited as she thrusts only centimeters at a time, pumping her cum deep into Brooke relentlessly.  Brooke, for her part, tries to maintain her focus on your genitals, but the feeling of Heckel's jism pumping so hard into her causes her to be practically paralysed, and she stops her dutiful work.  Not a moment too soon, though: with Heckel's loud proclamation and the sight of her knotting into the Shepherd girl beneath you both, ");
	if (player.hasCock()) outputText("you erupt, spraying your cum directly into Brooke's thirsty throat.  Despite her own ecstasy, she knows to swallow to avoid choking, taking hurried breaths through her nostrils when she can while you coat her mouth white several times over.  Her mouth and her tongue are mostly still, barely conscious enough to move much less pleasure you farther.  You don't mind, and you cum and cum into her mouth regardless.");
	if (player.gender == 2) outputText("you cum into her mouth, spraying your feminine juices onto her tongue and wherever else Brooke didn't have the sense to cover.  It gets into her mouth; onto her muzzle; and down her face.  You coat her from your end as your pleased cunny quivers and cums again and again.  Brooke, for her part, swallows whatever happens to land into her maw, but she barely even seems to notice whenever your happen to get her anywhere else.");

	outputText("\n\nHeckel continues to cum again and again, her hips doing tiny thrusts with each pump, her heavy balls gurgling and swaying with each spasm.  Thanks to her obscene knot, not a drop escapes from Brooke's cunt, and it all just keeps building into her womb.  ");
	//[if (hasCock = true)]
	if (player.hasCock()) outputText("Based on how you know Brooke to be such a cum-hungry bitch when she's really into it, you doubt she'd rather have it any other way.  ");
	outputText("Heckel's orgasm begins to wind down, but her feminine moans and gasps don't stop even as she's finished.  It takes her a bit longer to finally stop, and, exhausted from this workout on top of the one from before, she finally collapses onto Brooke, letting her weight rest entirely on the Shepherd girl beneath her.");
	player.orgasm();
	dynStats("sen", 1);
 	menu();
	addButton(0,"Next",brookeAndHeckelStuffPartThree);
}

public function brookeAndHeckelStuffPartThree():void {
	clearOutput();
	outputText("You gasp for breath yourself, your eyes still seeing stars from the fantastic oral Brooke gave you.  You look towards Brooke, but not really <i>at</i> her, your mind a bit of a blank slate after such an ordeal.  Brooke doesn't seem much better off herself: her own orgasm finally easing off a bit, she eventually remembers that she's supposed to be going down on you, completely forgetting that you've already finished.  It takes until you feel your genitals being a little overstimulated to finally realize what's happening, and you tell Brooke to stop.");

	outputText("\n\n<i>\"Huh, wha... ?\"</i> she asks, a bit startled by your command.  She looks up at you, then around the locker room you're both in, then to Heckel, motionless on her back.  <i>\"Sorry,\"</i> she says, <i>\"I kind of phased out for a minute there.  That was pretty intense, even for Heckel.\"</i>  You ask her what she means by that.  <i>\"Well, Heckel and I, this isn't the first time we've had this little 'competition' of ours.  I win some and she wins some, but no matter what, at the end of the day, someone's getting fucked.  But <b>that</b> was something else.  If I had to guess, she was probably trying to show off to you, [name].  Showing how she's all super-strong and dominant and can go for hours and hours, you know, typical alpha bullshit.\"</i>");

	outputText("\n\nYou're surprised Heckel doesn't immediately reply with some snarky, indignant response.  Instead, what you hear is a heavy snore from the hyena atop the Shepherd girl.  Brooke chuckles a bit at the sound.  <i>\"Well, maybe not hours,\"</i> she says, and you laugh at the remark yourself.  <i>\"It'll be a while before her knot deflates, and a bit longer than that for her to wake up, so don't feel like you have to wait up for me.  Getting fucked by her is great and all, but I made the mistake of sticking around for a bit too long once and we wound up not leaving until closing time.  Save yourself while you still can; I'll catch up in a bit.\"</i>  You ask if she's sure, and in response, she lovingly kisses the inside of your thigh.  <i>\"Sure I'm sure, sweet thing.  You have things to do, I bet.  Just get going.\"</i>");

	outputText("\n\nReassured, you plant a kiss on her forehead, and shakily stand up from the bench.  Bow-legged, you make your way to your [armor] and slip it back on.  You turn back to Brooke and Heckel, to see that Brooke's laid herself flat on the floor, waiting for Heckel's knot to shrink so she can make a break for it.  Based on what you can see from your new angle, that won't be for some time yet.");

	outputText("\n\nYou take her advice and leave the gym before Heckel wakes up and decides to run on her dominance rush some more.");
	//Lust reduced to 0, sensitivity increased by 1
	brookeAffection(5);
	doNext(camp.returnToCampUseOneHour);
}

//[=Leg Press=]
public function legPressInsteadOfThreesome():void {
	clearOutput();
	outputText("You look to your right, seeing a group of people standing around a pair of the leg press machines in the distance.  Anthromorphic animals and centaurs of all shapes and sizes stand shoulder-to-shoulder, 'ooh'ing at whatever spectacle it is they're keeping you from seeing.  You approach, and you manage to worm your way between a pair of buff matrons, intent on getting a better look at what the fuss is.");

	outputText("\n\nThere, one on each machine, is Brooke and Heckel, each gliding through their reps.  The muscles on their legs bulge and their asses pull tight into their shorts with each press, and, going from the movement in the back of the machines, they've both got an absurd amount of weight on, far too much for you to guess just by eyeballing them.  You turn to the horse on your left and ask how long they've been going at it; he answers, 'for too long'.");

	outputText("\n\nBrooke has a cocksure grin on her face, exhaling with each press and inhaling with each ease.  She's going steadily and casually, and if it weren't for the sweat on her legs, you'd think she'd just stepped in with how much energy she had.  Heckel, meanwhile, looks focused but strained, and her reps are decidedly slower – her muscles quake pressing out and she eases off too quickly.  Her eyes fall on yours, and she feels a burst of determination for but a moment, but after only a few more reps, she collapses in the chair, her legs limply falling to the floor.");

	outputText("\n\n<i>\"All done?\"</i> Brooke asks, looking towards Heckel, her legs never stopping their impressive display of physique.  Heckel doesn't answer; she instead glowers towards Brooke, using her hands to massage and sooth the aching in her tired legs.  <i>\"All right, then, I guess that's good enough for me too.\"</i>  Brooke eases the weights back down and practically glides off the machine, taking a few running steps in place and stretching her strong, taut legs for the appreciation of the crowd.  Some matrons offer congratulatory handshakes, and she gladly accepts each.");

	outputText("\n\n<i>\"That was pretty fun, Heckel,\"</i> she said.  <i>\"And that was awfully brave of you to challenge me on the leg press.  I'd help you up, but, you know.\"</i>  She raises her palms to Heckel and flexes her fingers, wordlessly reminding the hyena of her disability.  Some others offer to help Heckel stand, but she angrily shoos them away, fighting to stand under her own strength despite the harsh burn in her legs.  She gets herself up eventually, but as soon as she's standing, Brooke steps forward, wrapping Heckel's left arm around her shoulders.  <i>\"Come on, 'top dog',\"</i> Brooke laughs, just a little mockingly.  She turns away from the crowd and whispers something into Heckel's ear, too quiet for you to make out.  Whatever she said, Heckel's earlier bravado evaporates, and her features begin to droop.  Brooke walks forward, strongly and confidently, while Heckel drags her feet, barely able to put one in front of the other.");

	outputText("\n\nBrooke hoists Heckel behind her, making her way through the crowd, when she just happens to pass by you.  She hesitates for only a moment before she recognizes you.  <i>\"Hey, [name], good timing!  You enjoy the show?\"</i>  She bounces Heckel on her shoulder easily, and Heckel just kind of flops about, too tired to retaliate.  Rather than answer, you ask Brooke what she plans to do with her.  <i>\"Well... \"</i> she hums, looking to Heckel's exhausted shell, <i>\"I could tell you, but you know what?  That's no fun.  Grab her other shoulder and I'll show you what I have in mind.\"</i>  To solidify her implication, she gives you a sultry wink and deliberately licks her lips, begging you with her eyes to say yes.");

	outputText("\n\nYou accept, and wrap Heckel's right arm around your own shoulders.  You don't <i>really</i> know what to expect, but judging from the lecherous leers and callous cat-calls that follow behind you, Heckel and Brooke with every step out of the gym and into the locker rooms, you have a pretty solid idea.");

	//[=Next=]
	menu();
	addButton(0,"Next",brookeVHeckelBrookeWins2);
}

public function brookeVHeckelBrookeWins2():void {
	clearOutput();
	outputText(images.showImage("brooke-gym-heckelbrookedominance"));
	outputText("You and Brooke help Heckel into the locker room.  <i>\"[name], close the door and strip down,\"</i> Brooke says, shouldering the rest of Heckel's weight as they lumber towards the bench.  Brooke whispers some sexy nothings into Heckel's ear while you do as you're asked, making sure there's some semblance of privacy in the wide-open locker room while you go about stripping off your [armor] until you're in the nude.");

	outputText("\n\nYou look back to the two bodybuilders just in time to see Brooke roughly throw Heckel onto her ass on the bench.  With surprising quickness and dexterity, Brooke leans forward, gripping onto the neck of Heckel's tank-top, and plants the fabric in her mouth.  With a huge yank, the Shepherd girl rips off Heckel's shirt, leaving the hyena naked from the waist up.  Brooke bends farther down, doing the same to her shorts while she squirms and wiggles out of her own.  Heckel does nothing to resist, despite her arms still having more than enough strength to shove Brooke off if she wanted.  In fact, judging from the half-mast of her erection, you'd be willing to guess Heckel is enjoying the fact that she lost as much as Brooke was.");

	outputText("\n\n<i>\"Get over here,\"</i> Brooke says to you huskily, standing up and onto the bench, presenting her moist, ready cunt to Heckel's face but refusing to close the gap.  You approach them both.  <i>\"You know that I'm a gracious winner, Heckel,\"</i> she says, tauntingly.  <i>\"I wouldn't do anything to you that you wouldn't do to me if you had won.\"</i>  At that, Heckel whines, quivering a bit at the implication.  It's really quite impressive how Brooke has the self-purported 'top dog' under her thumb so thoroughly.  <i>\"She's ours for the day, [name].  Do what you like.\"</i>  Brooke gives in to temptation, and thrusts her hips forward, smacking Heckel in the face with her pussy, wordlessly demanding her cooperation.");

	outputText("\n\nYou look over the hyena's body.  She wasn't 'built', she was sculpted.  You can make out every tight muscle, every hard sinew, every definition, from underneath her short fur.  Looking up, you can see Brooke's own hard body, flexing and melding with every movement and thrust her shapely ass and powerful back make as she humps into Heckel's mouth.  Brooke's entertaining herself with the hyena's tongue – you look down, to her crotch, and decide to busy yourself with her rising black dog-cock.  You're sure Brooke has plans for it later.");

	outputText("\n\nYou kneel down between Heckel's still-shaking legs, and you have to fight to get her to separate them, tired as they are.  Once you're in, you reach forward, giving her plump, hot cock a few pumps.  You feel every pulse and every bulge as it inflates, acquainted with it enough to know it's not anywhere near full size yet.  With your other hand, you reach down to her fist-size testicles, smoothly running your palm across her scrotum, feeling how they bend and move with your hand and jumble with your fingers when you play with them.  A bead of precum peeks from the tip of her cock, followed by another, and they both drip down, over and under your fingers, lubing your hand as you continue your handjob.");

	outputText("\n\nThe familiar smell of her musk, amplified now that she hasn't had a chance to shower, draws you in, and before you really realize it, you've taken her dick into your mouth and you've gone about four inches down her ten inches already.  You take it slowly, sucking in only a little bit at a time, and you keep your tongue still – you don't want to overstimulate her too quickly.");

	outputText("\n\nAbove you, Brooke grips the lockers behind Heckel as she continues to abuse the hyena's mouth, rocking and rubbing her mound across her rival's face.  <i>\"That's it,\"</i> she sighs, rotating her hips and pressing in, making sure Heckel doesn't leave a spot untouched.  You look up, across her hard body, and what isn't obscured by Brooke's swishing tail is a hot sight: Heckel, embracing her position, has reached up with both her hands to grip Brooke's ass, molding and kneading each firm cheek, while her tongue works in, out, and all around the Shepherd girl's hungry quim, sometimes using its impressive length and flexibility to try and get a lick at her asshole.  Brooke, determined to appear superior, barely makes a noise, while Heckel's full mouth moans and whimpers with every sensation given to her.");

	outputText("\n\nYou return to your own task, sucking the cock in your mouth, readying it for Brooke.  Pre continues to drip from her leaky tip, while the mast continues to lengthen and its trunk begins to balloon with her knot.  With one hand, you rub and jack off what your mouth doesn't cover – gently and slowly, of course – while your other continues to play with her balls.  Your fingers curl all the way around her scrotum, gripping the entirety of one nut in your palm, when you feel a familiar heat just at your fingertips.");

	outputText("\n\nKnowing that Heckel's not in a position to argue, you reach forward, just barely stroking the lips of her vagina.  She yips, takes a deep breath, and practically freezes on the spot, her abs tightening and her thighs going tense around you, despite their lack of energy.  After a still moment, Brooke grunts, shoving her hips forward, slamming into Heckel and shoving the hyena girl's skull into the metal of the locker, snapping her out of it and reminding her of her task.  She dutifully does, kissing, licking, and exploring the dog's damp tunnel with her mouth, knowing she can't exactly deny you permission to continue.  You do so: you press forward with two fingers, slipping them into the soaking heat of her cunt, exploring it with the same gentle slowness as your blowjob.");

	outputText("\n\nYou feel a bit remiss that Heckel has a pair of testicles, because they make getting to her vagina with your mouth a chore.  With their size, it'd be too awkward to just lift them up and out of the way.  You sigh to yourself in disappointment – you'd like to get a taste, less for her pleasure and more for your own, if only because Heckel rejects every other attempt you make and you know that now would be your best opportunity.  A sort of 'forbidden fruit' thing she has going over you.  Whatever – you go back to your blowjob, gliding your mouth slowly up and down her still-growing cock while pressing deeper and bolder into her feminine sex.");

	outputText("\n\nYou can tell from Heckel's jerky movements and whining noises that she wants more: for you to go faster, to suck more into you, to go deeper with your fingers, but you deny her at every pass.  Her arms become more animate, never leaving Brooke's body but exploring her strong calves and thighs, gripping and holding onto whatever she can as she keeps servicing her superior, trying to keep her mind off the denial you're doing to her.  Keeping up the strong, stoic appearance, Brooke continues to not make any noise, although you can tell from your vantage point that she's enjoying herself quite a bit.");

	outputText("\n\nA few more humps later, and she finally lets go of the lockers, leaning back and releasing the lock her cooch had on Heckel's face.  <i>\"Stop, [name],\"</i> she says with finality, and you acquiesce, withdrawing your fingers and removing your mouth, leaving a very horny and wanting hyena panting on the bench, looking to you both, begging you wordlessly to do <b>something</b>.  You're aroused from the whole display, yourself: this powerful figure, all muscle, and with a confident, cocky attitude to match, fully aroused with a footlong cock and a knot the size of a squash is brought to her whimpering edge, begging her alpha to let her get off.  Brooke just looks at her, smirking, with her arms crossed, but judging from the slight buckling in her knees, it's taking everything she has to not fuck Heckel dry right there.");

	outputText("\n\nBrooke looks to you, your partner in crime, snickering at the low you've both brought Heckel to.  <i>\"Look at you, Heckel,\"</i> she says, stepping forward and dragging her fingers lightly across the hyena's frame: from her shoulder, down her breast, down her abs, and stopping just before the knot of her cock.  <i>\"So strong.  So damn proud of yourself.  'Alpha-dog' this; 'top-dog' that.  So used to being in charge.  And look what you're reduced to when you're not.\"</i>  Brooke teasingly flicks at the pole of Heckel's member, watching it bob and sway from the motion.  Heckel inhales sharply, easily betraying whatever semblance of control over herself she might have had.  <i>\"Well, you lost today, girl, and you know what happens when someone loses.  They're the bottom-dog.  And today, we have a guest.  You're the very bottom rung today.\"</i>");

	outputText("\n\nTo demonstrate her dominance, Brooke grips onto the base of Heckel's cock as tightly as she can, and shucks the whole thing into her mouth in one go.  Heckel jerks, barks, and desperately tries to pump into the Shepherd's mouth, but Brooke holds her still with her one commanding hand while she suckles on the meat for just a second, before pulling back, leaving Heckel confused and even more frustrated.");

	//{Males/herms only}
	var x:int = player.cockThatFits(brookeCapacity());
	if (x >= 0) {
		outputText("\n\n<i>\"Stand,\"</i> she commands, stepping back.  <i>\"[name], stand behind her, and get ready to catch her.\"</i>  Heckel hesitates a bit, leaning forward and trying to pull herself to her weary, exhausted legs.  She stands eventually, wobbly and limp, and begins to tumble.  Thankfully, you're there to catch her before she falls too far, much to her degradation.  You stand front-to-back, letting your " + player.cockDescript(x) + " rest between Heckel's ass-cheeks, waiting for Brooke's okay before continuing.  <i>\"Don't lie, Heckel,\"</i> Brooke says to her, stepping in close, pressing their faces, their breasts, and their bodies together.  <i>\"You love losing just as much as you love winning.  Being the bottom is just as thrilling as being the top to you.  Why else would you risk challenging me at the leg press?  As solid as you are,\"</i> she says, running her fingers across Heckel's abs, chewing her lower-lip as she does so, <i>\"you know you can't beat me there.  Maybe you just want someone you know can match you blow for every delicious blow, but you're too proud to just ask for it or something.  Or maybe it's me.  Maybe it's Brooke you want – you don't care about tops or bottoms; you just want to fuck this sexy Shepherd lady until she screams your name.");

		outputText("\n\nWell, whatever the case,\"</i> she says, draping her legs around Heckel's waist, straddling her, keeping the head of her dog dick just lightly scratching against her eager entrance.  <i>\"You're getting Brooke.  Every inch, every little bit, of her.\"</i>  She leans in close, their noses touching, their lips just centimetres apart.  <i>\"But you're getting every inch of [name], too, you bottom bitch.\"</i>  Deviously, she flutters her eyes to yours, grinning.  <i>\"Fuck her hard.\"</i>  With that, you thrust forward, driving your " + player.cockDescript(x) + " into Heckel's tight hot tunnel while Brooke simultaneously slams down, shoving every inch of Heckel's cock before her knot into her pussy.");

		outputText("\n\nHeckel cries out, partly in jubilation at finally getting some proper sex, and partly from you suddenly thrusting wantonly into her tunnel.  Her shouts are silenced when Brooke corks her mouth with her tongue, keeping the hyena's face occupied as they kiss and fight each other with their mouths.  The arrangement the three of you have is a little awkward to get used to at first: you and Heckel have no rhythm, randomly bucking against and away from each other, and Heckel has no strength in her legs, forcing you to take a good deal of her weight.  At least Brooke can stand on her own legs.  Despite all that, you three eventually get something going: you thrust your " + player.cockDescript(x) + " into Heckel, who thrusts into Brooke, who bucks against Heckel, as you withdraw from Heckel and she withdraws from Brooke.  It's a delightfully punishing threeway, with one tortured hyena caught between a cock and a hard place.");
		if (player.gender == 3) outputText("  With every thrust into Heckel, you're reminded of your own empty pussy and you idly wish there was a spare cock around to fill you up too.");

		outputText("\n\nHeckel does her part, trailing her hands down to Brooke's sides and gripping onto her hamstrings, pulling the dog into her with every thrust forward.  But it's no mistake that Brooke is the top between the two of them: she stnds tall over the weak-legged hyena, covering as much of Heckel's body as she can with her own, pumping her hips powerfully into the herm's own.  Every one of Brooke's humps are met with one of your own, and all too quickly the two of you are battering the poor hyena around with your genitals; the locker room echoing a cacophony of wet thrusts, hard fleshy slaps, and perverse moans and sexual grunts.");

		outputText("\n\nYou, for one, don't take the chance to fuck Heckel properly for granted.");
		if (flags[kFLAGS.TIMES_FUCKED_HECKEL_BLOWJOB] > 0 || flags[kFLAGS.TIMES_FUCKED_HECKEL_ANAL] > 0)
		{
			var bj:Boolean = flags[kFLAGS.TIMES_FUCKED_HECKEL_BLOWJOB] > 0;
			var anal:Boolean = flags[kFLAGS.TIMES_FUCKED_HECKEL_ANAL] > 0;
			
			if (bj && anal)	outputText("  Every time you met Heckel, you either went down on her, or had to take her dick up your ass – now, with the rare opportunity to return the favor, y"); 
			else if (bj && !anal) outputText("  Every time you met Heckel, you went down on her - now, with the rare opportunity to return the favour, y");
			else outputText("  Every time you met Heckel, you had to take her dick up your ass - now, with the rare opportunity to return the favour, y");
		}
		else outputText("Y");
		outputText("ou savor every thrust into her tight velvet tunnel.  She's tight, far tighter than you had expected, but she's definitely no virgin either.  You draw your hands down to her hips, gripping and pulling delightedly at her tight muscles as you work her cunt, whetting your " + player.cockDescript(x) + " with the fruit you've been forbidden all this time.");
		//[if (cocks >= 2)
		if (player.cockTotal() >= 2) outputText("  Your extra dick flops lamely up the crack of her ass, hotdogging between her cheeks with every thrust.  You consider the possibility of maybe double-dicking the cocky hyena, but you opt against it, not willing to break the good flow you've got between the three of you.");
		outputText("\n\nFor her part, Heckel gasps more often when you thrust into her than when Brooke thrusts onto her own cock, although you take that more to mean she's not used to getting fucked than you're outdoing Brooke.");

		outputText("\n\nHeckel keeps up her part of the threesome, fucking and getting fucked, her moans and gasps among the most feminine things you've ever heard her make.  She leans more into you for support, unable to stay standing for long periods with the burn in her legs, but Brooke is more than happy to compensate, draping her body over the hyena as she takes her hard cock.  The Shepherd girl leans in, shutting up Heckel's moaning with another passionate, dominate kiss, as her tongue uncontestably glides in and claims the hyena's mouth for her own.");

		outputText("\n\nYou slide your hands up, feeling every ridge of her muscles and her ribs until you reach Heckel's B-cup breasts, roughly gripping and groping them.  Brooke gets the same idea, searching her hands across Heckel's well-defined biceps and shoulders before reaching down to the hyena's breasts.  You and her take turns, each covering half a breast, mauling and rubbing the supple flesh, you both enjoying passing and pinching over her nipples and hearing the delighted yips she tries to make around Brooke's still-kissing mouth.  You look down, watching the herm girl fuck hard and deep into Brooke before you, seeing her massive knot collide greedily against the dog's snatch in a bid to break in and unload her warm, waiting seed into her womb.");

		outputText("\n\nYour arms and your back begin to strain a bit from having to balance both of the horny bitches as they bounce on you and on each other, but the rising pleasure in your " + player.cockDescript(x) + " overrides them both: you're not too far off, and from the rising grunts from Brooke, neither is she.  She finally lets go of Heckel's face, smiling playfully down on the hyena, not caring to wipe the sweat from her brow as she continues her ride.");

		outputText("\n\n<i>\"You're a bit of a bitch, Heckel,\"</i> she says, keeping eye contact.  <i>\"You walk and you talk like you own the damn place.  You're a selfish lover; you shove your wrecking-ball of a knot into a lady and you don't even give her the time of day.\"</i>  Her bounces begin to slow, but they elongate, and become much more forceful.  Heckel grunts out with every slam Brooke makes onto her.  Brooke's obviously getting ready to take Heckel's knot, and you get the idea to thrust in time with Brooke, pushing the hyena forward to match.  <i>\"You want a hole to fuck, Heckel?  You want to bust a nut into someone?\"</i>  Brooke pants from both exertion and from anticipation, just as impatient to take in Heckel's knot as she is.  <i>\"You,\"</i> thrust, <i>\"<b>got,</b>\"</i> thrust, <i>\"<b>iiiiiiiiIIIIIIITTTTTTT!</b>\"</i>");

		outputText("\n\nWith one particularly forceful push, Brooke lands on Heckel one last time, managing to take in her whole knot at once, finally engulfing the whole of her dog dick.  Brooke works herself into a frenzy, humping and fucking, griping and humping against Heckel, pressing their tits together, running coarse short fur against thick dog fur, loudly woofing and panting for her sexual release.  Heckel just sort of takes all the abuse, perhaps a bit dazed from the sudden roughness.  They both fuck in short, quick bursts, not really able to move much thanks to the connection between them, but in no time at all, Brooke howls that familiar howl as she finally orgasms, cumming and cumming hard onto Heckel's cock.");

		outputText("\n\nHeckel cries out shortly after Brooke and begins flooding the eager Shepherd girl's cunt with her cum, blasting her womb with her potent spunk again and again, her whole body shaking and shivering uselessly, a collective slave to her cock taking all the energy out of her.  Her pussy spasms and clamps down on your " + player.cockDescript(x) + " simultaneously, milking you for every drop you have, and with a few barbaric thrusts and a wordless cry, you oblige, shooting your own load into her hungry vagina.");
		if (player.hasKnot(x)) outputText("  Likewise with Brooke, you pound your knot against Heckel's quim again and again, refusing to be denied entry, and with your orgasm, her pussy relents, taking in every inch of your " + player.cockDescript(x) + " with you.");
		outputText("  You cum and you cum, thrusting hard, making sure to drench every possible nook and cranny within Heckel's needy tunnel, seeding her deeply with your every thrust, and from how she coos and rocks in time with each of your pulses rather than her own as she does the same to Brooke, it's safe to say she enjoys it");
		//[if (isHerm = true)]
		if (player.gender == 3) outputText(".  Your [vagina] pulses in time with your " + player.cockDescript(x) + ", spraying your feminine juices down the inside of your tired legs uselessly, lonely and longing for a cock of its own to take");
		if (player.cockTotal() == 2) outputText(".  Your second dick flails and pulses, ejaculating in time with its lucky brother, shooting up and coating Heckel's back with your jism");
		if (player.cockTotal() >= 3) outputText(" while [eachCock] pumps yet more of your virile jism every which way, staining the tile floor and tagging the lockers surrounding you with your cum");
		outputText(".");
	}
	//{Females only}
	else {
		outputText("\n\n<i>\"On the floor,\"</i> Brooke demands.  Heckel looks at the dog with an expression bordering on pleading – she's already proven her point.  Is Brooke really going to make her lie on the dirty floor like a feral mutt?  Brooke doesn't say again, simply looking at Heckel expectantly, and finally, she relents, slipping off the bench and lying across the cold tile of the floor, face- and dick-up.  Brooke, hips swaying sultrily, steps over Heckel's mast, shifting onto her knees, keeping her pussy just inches from the head of her dog-cock.  She looks up at you and, winking, invites you to take your own position over the hyena's face.  You eagerly oblige.");

		outputText("\n\n<i>\"Don't lie, Heckel,\"</i> Brooke says to her, leaning in close, pressing her left cheek onto Heckel's breast and looking up at the panting herm.  <i>\"You love losing just as much as you love winning.  Being the bottom is just as thrilling as being the top to you.  Why else would you risk challenging me at the leg press?  As solid as you are,\"</i> she says, running her fingers across Heckel's abs, chewing her lower-lip as she does so, <i>\"you know you can't beat me there.  Maybe you just want someone you know can match you blow for every delicious blow, but you're too proud to just ask for it or something.  Or maybe it's me.  Maybe it's Brooke you want – you don't care about tops or bottoms; you just want to fuck this sexy Shepherd lady until she screams your name.");

		outputText("\n\nWell, whatever the case,\"</i> she says, dragging her tongue over Heckel's nipple once, eliciting a sharp whine.  Brooke lowers her hips just a little, just touching the lips of her vagina on Heckel's hard meat.  <i>\"You're getting Brooke.  Every inch, every little bit of her.\"</i>  She sits back up, smiling deviously down at her submissive conquest.  <i>\"But you're getting every inch of [name], too, you bottom bitch.  You've got a tongue – you damn well better put it to some use.\"</i>  At that, Brooke slams down, shoving every inch of Heckel's cock before her knot into her pussy, and you take that as your cue to do the same to her face, pressing your [vagina] onto her waiting lips.");

		outputText("\n\nHeckel lets out a sharp whine, overwhelmed from the sensations coming from all over her all at once.  She flops her hips pathetically on the ground, trying to meet Brooke with the dog girl's every down-thrust, and it isn't until you press your own genitals a bit more insistently that she remembers she has more work to do.  All at once, she thrusts her tongue into your snatch, licking and slurping everywhere she can, while she reaches up with her hands to grip onto your [hips], to keep you steady while she works.");

		outputText("\n\nBrooke's easily the most active, doing most of the work on her end, bouncing up and down on Heckel's cock, smashing the top of her knot against the lips of her quim.  She's leaned forward, resting her hands and some of her weight on Heckel's abs, getting a good grope and feel while she's at it.  Her tongue lolls out as she pants and moans with every thrust, loving both the feel of control she has over her long-time rival and the general feel of having Heckel's most impressive muscle spear into her over and over.");

		outputText("\n\nOn your end, you find your experience with Heckel's tongue somewhat wanting.  You certainly can't fault her eagerness, but the amount of times she's put another woman's needs before her own is apparent in her amateurishness.  She licks and laps every which way, and while it's definitely pleasurable, she doesn't really know what to do and just sloppily goes at it.  You're not about to complain, though – for her faults, she's not a bad lay, and she certainly seems willing.  You continue to fuck her mouth with your [vagina], cooing in encouragement whenever she does something right.");

		outputText("\n\nSlowing, Brooke falls forward, laying herself flat across Heckel's body, resting her breasts on Heckel's washboard abs.  She rewards her pet-for-the-day for her good work and servitude by licking and sucking on Heckel's breasts and nipples through her short fur.  The hyena shudders, slowing her own work on you as she registers the rough treatment on her delicate nipples, whimpering into your muff a bit before she continues.  Brooke never stops pounding her ass onto Heckel, shoving the hard, tapered cock into her all the while.");

		outputText("\n\nYou get the idea to follow suit with Brooke, leaning over both the fuckers and lunging your hands forward, grabbing fistfuls of Shepherd girl ass.  Brooke yelps at first, but soon moans instead and pushes her butt back into your hands, letting your fingers run and roam over the fur of her butt.  She becomes a bit more active, loving the feel of having a cock in her quim and your hands on her ass, and you oblige, pulling and pushing playfully to get her to fuck that hyena all the more thoroughly.  Heckel tries to play along, trailing her hands down Brooke's ribs, but you slap them away – this is your ass to play with, not hers.  Disappointed, she brings them back up, playing and groping at your [butt] instead as she thrusts and fucks her tongue ever deeper into your [vagina].");

		outputText("\n\nFeeling she's delighted her pet enough, Brooke rises back up, flexing her own powerful abs as she sits back on her knees properly.  Drool is hanging from her slack mouth, and she licks her lips, relishing the lingering taste and texture of Heckel's breasts.  She eyes you hungrily – you, her partner in conquering the wicked herm-witch of the gym – and again leans over Heckel, this time aiming for you.  You return the motion, drawing into Brooke, and your lips and tongues meet, sharing a wicked, powerful kiss over the writhing mass of muscle pleasuring you both.  Heckel is little more than a toy between the both of you, if only to put some humility into the bitch, but Heckel certainly hasn't had an objection of you two objectifying her.  Maybe she's more of a sub than she lets on.");

		outputText("\n\nBrooke breaks the kiss with you after some time, leaning back and gasping delightedly from all the sensations.  You look down to the dick buried in her slit – Heckel's knot has inflated by quite some bit, and if Brooke intends to take it, she should probably do it soon.  The Shepherd girl is certainly aware of it, but before she takes the plunge, she bends down one more time, resting her face on Heckel's collarbone, getting up-close and personal with the Heckel and her dutiful tongue working in you.");

		outputText("\n\n<i>\"You're a bit of a bitch, Heckel,\"</i> she says, knowing Heckel is listening.  <i>\"You walk and you talk like you own the damn place.  You're a selfish lover; you shove your wrecking-ball of a knot into a lady and you don't even give her the time of day.\"</i>  Her bounces begin to slow, but they elongate, and become much more forceful.  Heckel grunts out with every slam Brooke makes onto her.  Brooke's nearly ready to take Heckel's knot, and you grind and rub harder against Heckel's face, close to orgasm yourself and looking to cum with Brooke.  <i>\"You want a hole to fuck, Heckel?  You want to bust a nut into someone?\"</i>  Brooke pants from both exertion and from anticipation, just as impatient to take in Heckel's knot as she is.  <i>\"You,\"</i> thrust, <i>\"<b>got,</b>\"</i> thrust, <i>\"<b>iiiiiiiiIIIIIIITTTTTTT!</b>\"</i>");

		outputText("\n\nWith one particularly forceful push, Brooke lands on Heckel one last time, managing to take in her whole knot at once, finally engulfing the whole of her dog dick.  Brooke works herself into a frenzy, humping and fucking, griping and humping against Heckel, her orgasm just moments away after being stuffed so thoroughly.  You look down to her abdomen, and you see the outline of Heckel's enormous cock through Brooke's straining abs as she struggles to deal with the whole of the hyena's dick inside her.  The sight spurs you forward, stimulating yourself with Heckel's face while she does what she can, licking and digging frantically, hitting every spot she can think of, to hopefully make you cum before you give her a concussion.");

		outputText("\n\nBrooke can take no more, and she howls, cumming and cumming on Heckel's cock.  She makes small, jerky motions, unable to really move too much with being filled so definitively.  Heckel follows suit, her own rising moans turning into muffled wails as she cums herself, billowing and blowing into Brooke, her hips rising with each gush and resting in between before firing another heady load into her.  She's too out of it to keep going on you, and not a moment too soon: the sights, sounds, smells, and stimulations all rocket you over the edge, and you join them both, grunting savagely as your [vagina] quivers and cums, shooting gushes of femcum directly down Heckel's throat.");
		if (player.wetness() >= 4) outputText("  Your excretions are easily too much for the hyena to take, and your cum splashes out between her lips, running down her face and her neck, soaking her head almost completely.  Heckel swallows what she can, but for the most part she's more concerned with not passing out from the deluge you're subjecting her to.");
		//{End female scene}
	}
	outputText("\n\nYour orgasm slowly winds down, with you panting with pleasure and exertion from the whole ordeal, but Brooke continues to fuck against Heckel, determined to squeeze out every last drop from the abused hyena.  Heckel whines and moans, unable to give any more or take any more, wordlessly begging Brooke to stop, but she doesn't: either determined to run her dominance-fueled lust to the last stop or just a bit of a whore for cum, you're not sure, but it's some time before Brooke feels satisfied and gives Heckel's abused, oversensitive dick a rest.");
	//Lust reduced to 0, sensitivity increased by 1
	player.orgasm();
	dynStats("sen", 1);
	//[=Next=]
	menu();
	addButton(0,"Next",brookeVHeckelBrookeWins3);
}
public function brookeVHeckelBrookeWins3():void {
	clearOutput();
	outputText("You look forward, not really at anything, dazed and winding down from the amazing sex with the two fighters.  Your legs burn and your heart pounds, winded from such an energetic session, and you rub against Heckel just a little, enjoying the afterglow against the hyena's body.  Brooke looks distant; her tongue hangs from her mouth as she looks to the ceiling, barely cognizant, twitching her hips idly as she relishes in the feel of having Heckel's submissive prick and the load upon load of cum so deep inside her.  You ask her if she's okay, and when she doesn't respond, you reach over Heckel and give her a shake.");

	outputText("\n\n<i>\"Huh, wha... ?\"</i> she asks, a bit startled by the motion.  She looks in your eyes, then around the locker room you're both in, then to Heckel, motionless between you both.  <i>\"Sorry,\"</i> she says, <i>\"I kind of phased out for a minute there.  That was pretty intense, even for me.\"</i>  You ask her what she means by that.  <i>\"Well, Heckel and I, this isn't the first time we've had this little 'competition' of ours.  I win some and she wins some, but no matter what, at the end of the day, someone's getting fucked.  But <b>that</b> was something else.  I guess I got a little carried away because you were here with me, [name]; I had an audience to prove once and for all that I was better than Heckel – better at the gym, and better at fuckin'.\"</i>");

	outputText("\n\nYou're surprised Heckel doesn't immediately reply with some snarky, indignant response.  Instead, what you hear is a heavy snore from the hyena");
	if (!player.hasCock()) outputText(", muffled from your [vagina] still plugging her lips");
	outputText(".  Brooke chuckles a bit at the sound.  <i>\"I don't think I can blame her.  We fucked her pretty hard,\"</i> she says, and you laugh a little yourself – you'll still be feeling this later.  <i>\"It'll be a while before her knot deflates, and a bit longer than that for her to wake up, so don't feel like you have to wait up for me.  Fucking her is great and all, but I still have plans for my submissive puppy for the day – you probably have other things to do.  Save yourself while you still can.\"</i>  You answer that, well... maybe you don't, and you're down for more if she is.  Brooke grins at you devilishly, daring you to reaffirm that – thinking on it, you back down.  As fun as that sounds, you're not certain how long you'll be able to keep up with the two athletes.");

	outputText("\n\nYou disengage yourself from Heckel");
	if (player.hasCock()) outputText(", and gently lay her down on her back, with Brooke awkwardly laying herself down with her");
	outputText(".  Bow-legged, you make your way to your gear and slip it back on.  You turn back to Brooke and Heckel, to see that Brooke's laid herself flat on Heckel, kissing and sucking gently on the hyena's tits, already working herself back up for a second round.");

	outputText("\n\nYou take her advice and leave the gym before Brooke changes her mind decides to make you stay to play on her dominance rush some more.");
	doNext(camp.returnToCampUseOneHour);
	brookeAffection(5);
}
}
}