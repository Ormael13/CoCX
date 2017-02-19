package classes.Scenes.Places.TelAdre {
	import classes.GlobalFlags.kFLAGS;
	import classes.CockTypesEnum;

	public class Ifris extends TelAdreAbstractContent {
public function Ifris(){

}
//Hours - 15+

public function ifrisIntro():Boolean {
	if (model.time.hours >= 15) {
		if (flags[kFLAGS.MET_IFRIS] > 0) outputText("\n\nIfris is standing in the corner of the room, wearing her usual black bikini and eyeing you as soon as you walk in.", false);
		else outputText("\n\nIn the corner of the room stands a lone figure, her bright cherry-red skin making her stand out.  A long, spaded tail swishes behind her slowly, the length much thicker than most demon tails you've seen.  She couldn't be more than five feet tall, her slender, lithe form looking more athletic than muscular.  A black bikini covers just enough to be modest, her supple C-cup breasts more perky than they have a right to be.  She slowly rolls a lock of springy, curly hair around one index finger, her glowing crimson gaze set on a nearby weight-lifting machine incredulously.  Feeling your eyes on her glistening, oiled skin, she slowly turns them to you instead.", false);
		return true;
	}
	return false;
	
}

//2-Approach and Greeting-
public function approachIfris():void {
	spriteSelect(28);
	clearOutput();
	if (flags[kFLAGS.MET_IFRIS] == 0) {
		flags[kFLAGS.MET_IFRIS] = 1;
		outputText("The curious, appraising gaze on her pretty face turns into a pleased smile as you walk over, and her clawed toes click gently on the floor as she takes the last few steps to meet you. As you open your mouth to speak she preempts you, those pretty, black-painted lips parting, a voice too husky and smooth to be up to any good greeting you.\n\n", false);
	
		outputText("\"<i>Hello, darling. I'm so glad you decided to join me... You can call me Ifris.</i>\" She tilts her head to the side cutely, gazing up at you through her lashes.\n\n", false);
	
		outputText("You give her your name, mouth suddenly feeling a little too dry for some reason as she gives you that sultry smile and lingering gaze.\n\n", false);
	
		outputText("\"<i>It's nice to meet you. Are you here to use the machines, or were you just hoping to watch the pretty bodies working up a sweat?</i>\" she giggles cutely, two of her clawed fingers covering her mouth demurely.\n\n", false);
	}
	//2a-Repeat approach, no sex-
	else if (flags[kFLAGS.TIMES_FUCKED_IFRIS_BLOWJOB] + flags[kFLAGS.TIMES_FUCKED_IFRIS_LICKED] == 0) {
		outputText("Ifris grins as you walk over again, the devil girl's dark tongue dabbing at her even darker lips as she all but coos up at you.\n\n", false);

		if (flags[kFLAGS.IFRIS_SHOWED_OFF] == 0) outputText("\"<i>Hello darling... here to actually give me a show?</i>\"\n\n", false);
		else outputText("\"<i>Hello darling... here to give another show? I did so enjoy your last performance.</i>\"\n\n", false);
	}
	//2b-Repeat approach, had oral-
	else {
		outputText("Ifris grins as you walk over again, the devil girl's dark tongue dabbing at her even darker lips. A small shudder runs through you as you imagine her remembering your flavor...\n\n", false);

		outputText("\"<i>Hello darling... so lovely to see you. Are you here to give me a show this time? Or do you think you want to try to beat your last record?</i>\"\n\n", false);

		outputText("A bit confused, you ask her what record she's talking about, only to evoke a small, cute laugh from her.\n\n", false);

		outputText("\"<i>How long you can lift that much before my attentions are too distracting, of course.</i>\"\n\n", false);
	}
	outputText("(You could go ahead and work out while she watches, ask her to join you, or leave.)", false);
	//Work out || Ask Her To Join || Leave?
	simpleChoices("Work Out", workOutForIfris, "Join Me?", askIfrisToJoinYou, "", null, "", null, "Leave", telAdre.gymDesc);
}
//3a-PC responds they want to work out-
private function workOutForIfris():void {
	spriteSelect(28);
	clearOutput();
	if (player.fatigue > 70) {
		outputText("There's no way you could work out as tired as you are.  Maybe you could come back to flirt with the demonic-looking girl during your next workout.", false);
		doNext(telAdre.gymDesc);
		return;
	}
	outputText("You smile to the devil-looking-girl and tell her you're just here to get your work-out on.\n\n", false);

	outputText("\"<i>Oh, don't mind me, then. Please, by all means.</i>\" She gestures to the bench-press, stepping back and watching you with a smile.\n\n", false);

	outputText("\"<i>I hope you don't mind if I keep you company. I'd love to... see you in action.</i>\"\n\n", false);
	//WORK OUT or SHOW OFF?
	simpleChoices("Work Out", liftWhileIfrisWatches, "Show Off", showOffForIfris, "", null, "", null, "", null);
}
//3b-PC asks if she'd like to join them-
private function askIfrisToJoinYou():void {
	spriteSelect(28);
	clearOutput();
	if (player.fatigue > 70) {
		outputText("There's no way you could work out as tired as you are.  Maybe you could come back to flirt with the demonic-looking girl during your next workout.", false);
		doNext(telAdre.gymDesc);
		return;
	}
	outputText("You ask Ifris if she'd like to join you in some exercises. Her eyes glint mischievously, obviously finding unintended meaning in your words, and you can't help but blush.\n\n", false);

	outputText("\"<i>That's sweet of you, darling... but I don't want to get in the way. I'll just wait my turn. Don't worry about me at all.</i>\"\n\n", false);

	outputText("You shrug at her response, but there's something about the way she eyes you now...", false);
	//WORK OUT or SHOW OFF?
	simpleChoices("Work Out", liftWhileIfrisWatches, "Show Off", showOffForIfris, "", null, "", null, "", null);
}

//4a-PC does a modest work out-
private function liftWhileIfrisWatches():void {
	spriteSelect(28);
	flags[kFLAGS.IFRIS_SHOWED_OFF]++;
	clearOutput();
	if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) {
		outputText("The centauress working the door walks up to collect her fee, and you drop 10 gems for an hour workout into her hand.\n\n", false);
		player.gems -= 10;
		statScreenRefresh();
	}
	outputText("You set the machine to a weight that you know won't be too much for you and lay back on the bench. You feel her eyes on your form, a little shiver running down your spine as she openly admires you as you take a grip on the handlebars and push. It's not long before you've worked up a nice sweat, your muscles burning, but you can't shake that distracted feeling as she gazes at you so appreciatively.\n\n", false);

	outputText("As you finish your sets, she smiles a little wider at you, reaching over and tracing one fingertip teasingly along your jawline.\n\n", false);

	outputText("\"<i>Mmm... lovely. Maybe next time I'll get to see a little more.</i>\" She grins a little then, exposing her fanged teeth to you briefly before she turns and slinks from the gym, her posh little bottom swaying more than it has any real right to. You can't help but stare until she's gone, and you shake your head, trying to clear it to go about your business...", false);
	//Stat changes HERE!
	if (player.str < 90) dynStats("str", .5);
	if (player.tou < 40) dynStats("tou", .3);
	dynStats("lus", 5);
	//Body changes here
	//Muscleness boost!
	outputText(player.modTone(85,5+rand(5)), false);
	player.changeFatigue(30);
	doNext(camp.returnToCampUseOneHour);
}
//4b-PC decides to show off, possible strength requirement?-
private function showOffForIfris():void {
	spriteSelect(28);
	flags[kFLAGS.IFRIS_SHOWED_OFF]++;
	player.changeFatigue(30);
	clearOutput();
	if (flags[kFLAGS.LIFETIME_GYM_MEMBER] == 0) {
		outputText("The centauress working the door walks up to collect her fee, and you drop 10 gems for an hour workout into her hand.\n\n", false);
		player.gems -= 10;
		statScreenRefresh();
	}
	outputText("You look at the settings on the machine for a moment before deciding to give the red cutie something to really remember. You set the bar on the bottom rung, rubbing your hands together a few times in preparation as you lay on the bench. Her red eyes go a little wide, slender black eyebrows lifting on her smooth forehead as she watches you. You can't help but feel as though she's almost rooting for you, the way she does a cute little hop and clasps her hands together...\n\n", false);
	
	//4b2-PC fails strength requirement considerably!-
	if (player.str < 40) {
		outputText("Gripping the bars tightly, you grit your teeth and give a mighty push upwards! Or not so much, though you struggle valiantly against the weight. You just can't seem to budge it however, and a sharp pain in your arms tells you just what a bad idea this was! You give a cry of pain, releasing the bar and rubbing your biceps.\n\n", false);

		outputText("Ifris only rolls her eyes, flipping a hand at you dismissively as she walks away, murmuring.\n\n", false);

		outputText("\"<i>I've no time for show-offs who can't back it up, darling.</i>\"\n\n", false);

		outputText("Humiliated, you stand and leave, nursing your sore body and ego.", false);
		//Reset 'shown off for ifris'
		flags[kFLAGS.IFRIS_SHOWED_OFF] = 0;
		player.takeDamage(10);
		doNext(camp.returnToCampUseOneHour);
		return;
	}	
	//4b1-PC fails strength requirement!-
	if (player.str < 75) {
		outputText("Gripping the bars tightly, you grit your teeth and give a mighty push upwards! Your muscles strain and you grunt with effort, but the considerable weight barely budges. You hear her make a little disappointed, \"<i>awww...</i>\" as she watches you for a few long moments, but no matter how much the humiliation motivates you, you just can't seem to do it.\n\n", false);

		outputText("\"<i>Oh well...</i>\" She sighs, clearly crestfallen. Cocking one fist on her hip, she gives your " + player.leg() + " a light pat as she leaves your presence, vanishing out the door within moments.\n\n", false);

		outputText("Well, at least you had the good sense to stop before you hurt yourself...\n\n", false);
		doNext(camp.returnToCampUseOneHour);
		flags[kFLAGS.IFRIS_SHOWED_OFF] = 0;
		return;
	}
	//4b5-PC masculinity > 60, corruption > 75, has cow features-
	if (player.gender == 0 || (player.femininity < 40 && player.cor > 75 && player.faceType == FACE_COW_MINOTAUR)) {
		outputText("Ifris watches you for a moment as you move down to the bench, but her eyes clearly wander elsewhere now and then. The pleasant smile never leaves her pretty face, but it's clear she's distracted or even disinterested for some reason. Soon enough she turns to leave, a bored little sigh leaving her. Her hips sway with a sexy gait as though it were natural, though nothing about her seems particularly excited at the moment...", false);
		//Stat changes HERE!
		if (player.str < 90) dynStats("str", .5);
		if (player.tou < 40) dynStats("tou", .3);
		//Body changes here
		//Muscleness boost!
		outputText(player.modTone(85,5+rand(5)), false);
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	//4b3-PC succeeds! Is male/herm-
	if (player.hasCock()) {
		//Double dickings!
		if (player.cockTotal() > 1 && rand(2) == 0 && player.cockThatFits(70) != -1 && player.cockThatFits2(70) != -1) {
			ifrisDP();
			return;
		}
		//First time
		if (flags[kFLAGS.TIMES_FUCKED_IFRIS_BLOWJOB] == 0) {
			outputText("Gripping the bars tightly, you grit your teeth and give a mighty push upwards! Your muscles strain and you grunt with effort, a little amazed gasp leaving the red beauty's lips as the weights lift slowly but surely. You can't help but grin proudly as your elbows lock, the weight completely lifted, and you bring it back down, only to push again.\n\n", false); 
	
			outputText("Ifris moves closer, her oiled skin glistening as she watches your muscles straining, bending in to get a closer look. As you look down you notice her bend forward, the weight momentarily forgotten as those luscious, perfect mounds of tit-flesh almost spill out of her bikini top. She grins slowly at you, following your gaze, and even giving a teasing little shake, making the orbs jiggle.\n\n", false); 
	
			outputText("\"<i>Mmm, keep going, darling... I like what I see,</i>\" she all but purrs out.\n\n", false);
	
			outputText("Spurred on by your ego, you lift the huge weight with seeming effortlessness.  The devil-girl seems to move closer as your muscles burn and strain. Suddenly you feel one of her slender hands sliding up your " + player.leg() + ", the smooth palm stroking your thigh, and then cupping your crotch. A surge of arousal ripples through your cock, making the length twitch and immediately begin to swell as she squeezes, making you pause in your efforts.\n\n", false);
	
			outputText("\"<i>Mmmm, don't stop now,</i>\" she teases in that husky voice, even as she grips the waistband of your bottoms, tugging them down suddenly and exposing your member then and there. Those lithe, soft fingers wrap around the base of the shaft, squeezing gently in soft, pulsing grips as she watches it harden completely. Her eyes stay fixated on your dick, a dark, nearly-black tongue dabbing her lips as she gives a slow, almost languid stroke up the shaft.\n\n", false);
	
			outputText("You groan under her ministrations - the way she grips your cock so teasing, but so effective. Within moments you're so distracted by her fleeting caresses and squeezes that you almost slip, and decide to rest, letting the weights settle. Ifris gives a cute little giggle, her grip finally tightening on your sweaty, throbbing member as she bends in, letting her dark, plush lips meet the head in a sensual kiss. Your body felt so sore and tired, but the kiss to your swollen glans is like a lightning bolt through you, and a little groan leaves you.\n\n", false);
	
			outputText("Pleased with her effect on you thus far, her gaze shifts to your face while her lovely mouth parts, the heat of her breath much greater than a normal human by several degrees.  It washes over your cock in heavy, moist puffs. With a little teasing flick of her wet tongue over the tip of your shaft, she takes it into her mouth, suckling gently. The devil's mouth is so wet, so delightfully hot, her cheeks hollowing out almost instantly as she sucks hard on that pulsing tip. Slowly she descends, thick cock-pillows smoothly gliding down your shaft as she takes more and more into her mouth. There isn't even a pause as you hit the back of her throat and she keeps going, eyes narrowing in lust as she gazes at your expression when her lips meet your crotch in the most intimate kiss you can imagine.\n\n", false);
	
			outputText("Suddenly it seems she loses her patience for teasing, much to your delight, and the hard, long pull on your cock as she pulls back is like heaven, her cheeks caved inward. She descends quickly, all but face-fucking herself on your rod again and again, lewd, wet squelching rising up from her stuffed throat. It isn't long before you're groaning in ecstasy, wishing you had the strength to grip her head, make her slow down so you can draw it out and enjoy it, but all too soon the pleasure is rushing up to meet you, your " + player.ballsDescriptLight() + " tightening, even as she cups ", false);
			if (player.balls > 0) outputText("them and gently squeezes the sack.\n\n", false);
			else if (player.hasVagina()) outputText("your lower lips and gently squeezes.\n\n", false);
			else outputText("your taint and gently squeezes.\n\n", false);

			outputText("Just as you can take no more, the pretty devil buries her face in your crotch, swallowing around your dick desperately. You give a shout of pleasure as your length swells and twitches, the hot bursts of your seed pumping down into her belly. She waits patiently, almost looking like she's smiling around the base of your dick, even as her eyes flutter, almost rolling back in her head. Finally the bursts of your cum subside and she slowly pulls up off your shaft, giving the oversensitive tip one last hard, almost painful suckle before parting from your flesh with a lewd plop. She licks her lips slowly, leaving you panting and feeling light-headed as she rises, only giving your cock a gentle pat as she passes by, leaving with a spring in her step and a trail of glistening wetness down her thighs...", false);
		}
		//5a-Repeat oral scene, male/herm-
		else {
			outputText("Ifris all but squeals in delight as you tell her you're totally up for smashing that record, a wide grin spreading her thick lips, briefly worrying you when you see those sharp teeth of hers... but then you remind yourself how good she is with them, as you lay back onto the bench, gripping the bars above you. The devil girl doesn't even wait this time, tugging your bottoms down right away to get at your " + player.cockDescript(0) + ". She sits upon your " + player.legs() + ", her posh butt so nice and soft against you as she waits for you to begin.\n\n", false);

			outputText("The moment you lift the weight for the first time, she bends down, rubbing her smooth cheek against your half-turgid member", false);
			if (player.balls > 0) outputText(", her hand cupping your " + player.ballsDescriptLight(), false);
			outputText(". Smiling, she watches you carefully, her tongue sliding out of her lips, laving up the underside of the shaft, urging it on its final steps to full hardness. She groans in desire as she takes your " + player.cockHead() + " into her mouth once again, pulling a moan from you with her first, hard suckle upon your sensitive tip; it seems she doesn't want to tease anymore.\n\n", false);

			outputText("The sexy little dark-haired devil takes your dick to the ", false);
			if (player.hasSheath()) outputText("sheath", false);
			else outputText("base", false);
			outputText(" in her throat once again, holding there until you push the weight up, sliding up the length with your movement, and then back down as you lower, encouraging your exercise with the pleasure of her sweet mouth. Knowing you can't keep it up forever though, she merely urges you to do better before giving in, her hand gripping the base of your " + player.cockDescript(0) + " tightly as her head starts to bob purposefully up and down your massive length.\n\n", false);

			outputText("With your strength spent, your lips dry from your constant moans, and your " + player.cockDescript(0) + " throbbing so wonderfully, Ifris smiles around your shaft as she feels your orgasm closing in. She doesn't stop this time, still bobbing along your shaft, tongue mercilessly undulating against the underside, as your peak rushes to meet you. She swallows those spurts of cum expertly, pulling back between each one to catch a burst in her mouth and taste it, and then shoving you back down her throat to swallow the next, alternating in an erotic rhythm until you're spent.\n\n", false);

			outputText("With that slow, almost painfully-hard suckle, she pops from the " + player.cockHead() + " of your " + player.cockDescript(0) + " out and sucks in a deep breath, giggling and leaning down to kiss you.  She murmurs, \"<i>You do better each time, darling. I'll see you again I hope.</i>\"  With that, she's leaving you again, all but skipping out the door, that wetness trickling down her long, red legs...", false);
		}
		flags[kFLAGS.TIMES_FUCKED_IFRIS_BLOWJOB]++;
	}
	//4b4-PC succeeds! Is female!-
	else if (player.hasVagina()) {
		if (flags[kFLAGS.TIMES_FUCKED_IFRIS_LICKED] == 0) {
			outputText("Gripping the bars tightly, you grit your teeth and give a mighty push upwards! Your muscles strain and you grunt with effort, a little amazed gasp leaving the red beauty's lips as the weights lift slowly but surely. You can't help but grin proudly as your elbows lock, the weight completely lifted, and you bring it back down, only to push again.\n\n", false);
	
			outputText("Ifris moves closer, her oiled skin glistening as she watches your muscles straining, bending in to get a closer look. As you look down you notice her bend forward, the weight momentarily forgotten as those luscious, perfect mounds of tit-flesh almost spill out of her bikini top. She grins slowly at you, following your gaze, and even giving a teasing little shake, making the orbs jiggle.\n\n", false);
	
			outputText("\"<i>Mmm, keep going, darling... I like what I see,</i>\" she all but purrs out.\n\n", false);
	
			outputText("Spurred on by your ego, this huge weight seems effortless. Suddenly one of the beauty's hands reaches out, smoothing over your toned belly as she grins rather devilishly at you.  Her fingers hook in your bottoms and you give a little jump as her plush, dark lips meet your belly, kissing your skin and even flicking her unnaturally-warm tongue against it to taste your sweat. One of her slender hands slips beneath your waistband, her fingers sliding over your pussy-lips teasingly, making a soft moan fall from your throat. Expertly she teases your folds, making you pause in your lifting to gaze down at the luscious beauty as she gazes right back up at you. Finding your sex wet and inviting, she curls her digits, sliding them deep within you in a sudden, quick push, making you cry out as you grip her fingers so nice and tightly.\n\n", false);
	
			outputText("You let the weights rest, all but forgotten as your fingers bury in her soft, curly hair, moans of pleasure and desire leaving your lips. She pushes your top open, exposing your nipples to her exploring mouth, suckling upon one eagerly as she finger-fucks your pussy as deep as her slender fingers can go. Every time her hand curls against you, those fingers scissoring nice and deep within your soaked tunnel, you feel her palm rubbing over your clit again and again.\n\n", false); 
	
			outputText("The warmth in your belly grows and spreads as the sensual, intense sex grows more urgent, and soon enough the black-haired beauty pulls from your nipples, her fingers sliding from your dripping slit just long enough to push your bottoms down completely. She bends in, those thick dick-sucking lips put to a much different use as they press to your pussy and suckle upon it, her heated tongue sliding deep within you, lashing against your sensitive walls, much to your delight. Her tail sways quicker behind her as she suckles on your pussy like her life depends on it... and that's more than you could ever ask for right then and there.\n\n", false);
	
			outputText("Your back arches, ", false);
			if (player.isNaga()) outputText("your powerful tail flexing to and fro while your belly clenches", false);
			else outputText("toes curling while your belly clenches", false);
			outputText(", and your muscles contract as your orgasm hits. A muffled moan leaves Ifris, invading your cunt as you clutch her head to you, riding her pretty face, lost in your tide of ecstasy. When you finally come down, she pulls free of your pussy with a cute little gasp, followed by a giggle. Looking down through your hazy eyes, you see her lovely face glistening with your own juices, and she gives your thigh a little kiss. Standing up, she turns and leaves you laying there panting, a spring in her step, and a trail of clear wetness leaking down her inner thighs...", false);
		}
		//5b-Repeat oral scene, female-
		else {
			outputText("Ifris all but squeals in delight as you tell her you're totally up for smashing that record, a wide grin spreading her thick lips, briefly worrying you when you see those sharp teeth of hers... but then you remind yourself how good she is with them, as you lay back onto the bench, gripping the bars above you. The devil girl doesn't even wait this time, leaning up to give your cheek a little peck as she pulls your " + player.chestDesc() + " free of your top.\n\n", false);

			outputText("She leans in before you've started, peppering your " + player.nippleDescript(0) + "s and ", false);
			if (player.biggestTitSize() >= 1) outputText("breasts", false);
			else outputText("chest", false);
			outputText(" with soft kisses, teasing the nubs to hardness with flicks of her tongue. You eagerly lift your " + player.legs() + " as she slides down, pulling your bottoms away to expose your moistening cunt to her hungry gaze.  Urging your " + player.legs() + " apart, she crawls between them, tail swaying behind her as she waits for you to begin. You comply with her wishes, eager to feel the pleasure of her mouth more than the burn of your exercise, and you're not left wanting.\n\n", false);

			outputText("With the first push, that long devil-tongue slides up along your " + player.vaginaDescript() + ", not teasing, but firmly lapping between the lips, spreading them slightly as she tastes you. With a pretty little moan, Ifris laves her tongue up your pussy over and over again as you pump your iron, enjoying your flavor, but knowing you'll need more to really get you going. Two fingers spread your " + player.vaginaDescript() + " open as her lips seal over your " + player.clitDescript() + ", suckling it gingerly, tongue swirling over it. Her fingers pump into you nice and quickly, your pleasureful reward for... well, you don't quite understand why this gets her excited, nor do you care.\n\n", false);

			outputText("That tongue joins her fingers in spreading your cunt, making you cry out in pleasure and surprise, leaving the weights unattended as you arch hard. Your orgasm rips through you, making your body shudder under the intensity as she laps up and suckles down your release eagerly, her ministrations softening, slowing to draw out your orgasm and let you enjoy it. As you come down, she slowly rises up, giving you another of those lecherous, devious grins before climbing off you.\n\n", false);

			outputText("\"<i>Always a pleasure, darling. I can't wait to see you again soon...</i>\" And she's leaving you once more, her butt swaying more than usual, moisture leaking down her long, slender legs...", false);
		}
		flags[kFLAGS.TIMES_FUCKED_IFRIS_LICKED]++;
	}
	//Stat changes HERE!
	if (player.str < 90) dynStats("str", .5);
	if (player.tou < 40) dynStats("tou", .3);
	player.orgasm();
	//Body changes here
	//Muscleness boost!
	outputText(player.modTone(85,5+rand(5)), false);
	doNext(camp.returnToCampUseOneHour);
}

//Ifrs double-penetrates herself on you while you work out.
private function ifrisDP():void {
	outputText("You set the machine to an impressive weight that you're sure you can handle and set to work, your muscles rippling and tightening as they repeatedly raise and lower the weight for the demonic-looking woman's amusement.  Feeling Ifris' glowing, crimson visage devouring in your workout, you push yourself harder, working up a sheen of sweat that drips from your body.  Your arms haven't yet begun to burn, but deep inside your chest, your heart is beating faster, either from the oiled gym-junky's gaze or the constant, heavy lifting - perhaps both.\n\n", false);
	outputText("With the first set finished, you lower the bar until the weight is released from your well-developed musculature.  The demonic beauty is leaning down, over your " + player.chestDesc() + ", drinking in every sweat-slicked part of you.  With her breasts wobbling dangerously, her glossy, dark lips slowly part to blow you a kiss.  Then, the onyx pillows open to purr, \"<i>Mmmm... marvelous work darling.</i>\"  She leans a little lower, letting her slick breasts rub over the crotch of your " + player.armorName + " as she asks, \"<i>Do you think... you could lift more?  Enough to truly handle anything the world might throw at you?</i>\"  Ifris trails her fingers over your " + player.armorName + ", slowly undoing the equipment with each enunciated syllable.\n\n", false);
	
	outputText("Spurred on by the crimson cutie's urgings, you set the machine a bit higher and set your mind to lifting, trusting her to follow through on her teases.  You flex and strain, hefting the heavier weight higher and higher, until you've completely raised it.  As soon as you reach that glorious apex, your coverings fall away to expose your " + player.multiCockDescriptLight() + " to the musky gym air.  They pulsate, slowly filling with blood while you hold the bulky weights aloft.  You gradually bring the machine back down, exhaling a moan of relief once Ifris takes two of your half-swollen shafts in her hands, feeling the flesh filling out between her hot, oiled fingers.\n\n", false);
	
	outputText("\"<i>Mmmm... don't stop darling.  You're... more than a handful.  Just keep lifting, and I'll take care of everything down here,</i>\" promises the sultry voice of your companion.  Nodding in understanding, you return to the task you've been given - putting on a show in exchange for sexual pleasure.  " + player.SMultiCockDesc() + " fill, to the muscle-focused demon's delight, getting coos of pleased surprise as they fully engorge.  She strokes them slowly, letting the tightening dick-flesh slide through her oily grip a few times to make sure you're absolutely ready, always stopping the moment you start to hesitate in your assigned workout.\n\n", false);

	outputText("After five big pushes, the hands disappear, but only long enough for her light, toned body to climb atop your own, the oiled thighs sliding up your sweat-glazed form towards your groin.  Ifris coos, \"<i>Mmm... keep at it, my darling.  Fitness is its own reward...</i>\"\n\n", false);
	
	outputText("You gasp at the pleasant sensation of her moist swimsuit against " + player.oMultiCockDesc() + " and start to push yourself, straining harder, grunting as you begin to feel the onset of fatigue.  Just before the next lift, Ifris squeezes two of your " + player.multiCockDescriptLight() + ", angling them straight up.  You pause in confusion a moment, until you feel wet lips on one and tight, oiled skin squeezing the other.  Like you've been charged by lightning, energy fills your body, and you push yourself to keep going.  As the bar rises, Ifris' pussy and asshole lower, squeezing the two lucky dicks in her hot, clenching innards.  Holding that position, you struggle to control your muscles and adjust to the exquisite pleasure.  The bar lowers slowly, but Ifris' holes levitate in the same motion, coming just up off your sensitive, hungry shafts.\n\n", false);

	outputText("The demonic-looking woman's tortuous orifices keep you hard, battling through the tide of pleasure so that you can keep lifting, and in return receive even more sensation.  Your arms are starting to feel sore, and lifting such enormous quantities of mass is getting harder and harder.  Ifris still seems pleased with your progress, and she murmurs words of encouragement.  \"<i>So... strong... mmmhmmm, go on.  You can do it.</i>\"  Her pussy squeezes and ripples around the main dick while her sphincter clamps tight on the other, massaging you to compensate for the slower speeds.  Droplets of sweat drip onto you, mingling with your own exhausted beads and falling to the floor, both of you soaked with the stink of exercise and sex.\n\n", false);

	outputText("Ifris leans down and twines her arms around your shoulders, resting her head in the nape of your neck, her dark tongue licking the salt from you " + player.skin() + ".  Your whole body is shaking, trapped between the desire to cave in to the crimson beauty's body and the need to support the machine's tremendous load.  Hot and trembling, your arms feel like they're melting into weak, burning rubber.  Ifris senses this, and she says, \"<i>Set it down and release... release for me, darling.</i>\"\n\n", false);

	outputText("You set the machine's bar back in place, letting your worn-out limbs go slack across Ifris's body, your hands coming to rest on her tight, squeezable butt.  The two slick holes start a whole new wave of contractations, and without the distraction of the weights, you're unable to resist.  ", false);
	//(Knotting - req's 2 dogdicks!)
	if (player.dogCocks() >= 2) {
		outputText("Both your canine cocks bloat with seed, the knot's distending and stretching so wide that Ifris couldn't pull off if she wanted.  A moment later, the twin dog-dicks explode pillars of alabaster cream, painting the truly knotted woman's innards white.  ", false);
		if (player.cumQ() >= 1000) outputText("She groans and moans as she's filled, her body distending to deal with the unholy amount of seed your cocks can spew.  ", false);
		outputText("Throughout the massive release, you're softly grunting, held immobile by your animalistic body's instincts as your peckers try their damnedest to impregnate your overly fit mate.  You're still cumming, but your knots are starting to deflate at last.  ", false);
	}
	//(Nodule growing, unholy demonocity)
	else if (player.countCocksOfType(CockTypesEnum.DEMON) >= 2) {
		outputText("Both your demonic cocks explode inside Ifris, the nodules along each shaft swelling out, thickening to stroke and caress your oily lover's inner walls.  A moment later, the tainted tips explode out, spurting demon-spunk into both silky tunnels.  ", false);
		if (player.cumQ() >= 1000) outputText("She groans and moans as she's filled, her body distending to deal with the unholy amount of seed your cocks can spew.  ", false);
		outputText("At the same time, your hands squeeze hard on her butt-cheeks and your hips start to jack-hammer against her, slamming into her as if she was a worthless piece of meat for you to impregnate.  You shiver, feeling not entirely in control of yourself, the demonic influence of your tainted members robbing you of control.  ", false);
	}
	//Flaring - req's 2 horsecocks!)
	else if (player.countCocksOfType(CockTypesEnum.HORSE) >= 2) {
		outputText("Both your equine cocks explode inside Ifris, their tips swelling outward into thick flares that plug her stuffed channels.  A moment later, the swollen tips unleash pillars of alabaster cream, painting everything above the flares white.  ", false);
		if (player.cumQ() >= 1000) outputText("She groans and moans as she's filled, her body distending to deal with the unholy amount of seed your cocks can spew.  ", false);
		outputText("Your hips begin to rock and thrust, and no matter what you try to do, you cannot seem to still your body, your animal instincts owning your waist as you inseminate your seductive, teasing lover's body.  ", false);
	}
	//(Tentacle pistoning + head-mushrooming)
	else if (player.countCocksOfType(CockTypesEnum.TENTACLE) >= 2) {
		outputText("Both your plant-like pricks explode inside Ifris, the purplish tips swelling up inside her to disproportionate sizes.  A moment later, the vine-dicks explode out twin pillars of ropey seed, painting her inner walls with spunk.  ", false);
		if (player.cumQ() >= 1000) outputText("She groans and moans as she's filled, her body distending to deal with the unholy amount of seed your cocks can spew.  ", false);
		outputText("At the same time, both tentacle-shafts curl and piston, winding around in other in the space between your bodies, curling and thrusting to rub every inch of your sensitive, prehensile shafts against Ifris' pussy-walls.  You shake and shudder, feeling more like a tentacle beast than a " + player.mf("man","woman") + ".  ", false);
	}
	//(Anemone - stinging funtimes)
	else if (player.countCocksOfType(CockTypesEnum.ANEMONE) >= 2) {
		outputText("Both your unusual, aquatic cocks explode inside Ifris, their shafts thickening as the prepare for release.  A moment later, they explode out twin pillars of alabaster cum, painting her inner walls with gooey spunk.  ", false);
		if (player.cumQ() >= 1000) outputText("She groans and moans as she's filled, her body distending to deal with the unholy amount of seed your cocks can spew.  ", false);
		outputText("At the same time, your stinging cilia go wild, pricking her inside and out, uncontrollably forcing aphrodisiacs into your partner's shuddering, orgasmic body.  The drugs force her to climb to whole new plateaus of pleasure, making her squeal with unrepentant pleasure.  You convulse and get off even more forcefully from using your strange members in such a way.  ", false);
	}
	//(Standard)
	else {
		outputText("Both your cocks explode inside Ifris, submitting alabaster pillars to her request for your release.  The red-hued sexpot exhales a happy hum and rocks her hips back and forth, her oily, lubricated holes squeezing your dicks for every drop of delectable seed.  ", false);
		if (player.cockTotal() > 2) {
			outputText("The ", false);
			if (player.cockTotal() == 1) outputText("one unbound prick remaining paints the muscular woman's lower back with goo, but she doesn't seem to mind.", false);
			else outputText("other, unbound pricks paint the muscular woman's lower back in goo, but she doesn't seem to mind.", false);
			outputText("  ", false);
		}
	}
	//(ALL GO HERE - NOT NEW PG) 
	outputText("She purrs, \"<i>Delightful,</i>\" into your ear and plants a wet kiss on you, surely leaving a dusky, black lip-print on your neck.\n\n", false);
	
	outputText("The last few contractions work through you, emptying the last of your load inside Ifris and allowing you to feel utterly, completely at peace.  Sliding up, she lets your slowly-deflating cocks ", false);
	if (player.dogCocks() >= 2) outputText("noisily pop free", false);
	else outputText("slide", false);
	outputText(" from her sperm-glazed snatch and anus.  Her body's warmth vanishes as she stands, and with a wink, she reattaches her bikini bottom, the tight garment moulding to her soaked camel-toe and holding in all of your leavings.  She walks away without another word, ", false);
	if (player.cumQ() >= 1000) outputText("her body bloated with cum and sloshing audibly with every step", false);
	else if (player.cumQ() >= 500) outputText("her belly bloated and gurgling with every step", false);
	else outputText("her body double-stuffed with seed", false);
	outputText(".  You slump back and breathe heavy, feeling like you've just run a marathon.\n\n", false);
	
	outputText("It is some time until you gain the energy to rise.", false);
	player.changeFatigue(10);
	//Stat changes HERE!
	if (player.str < 90) dynStats("str", .75);
	if (player.tou < 40) dynStats("tou", .5);
	player.orgasm();
	//Body changes here
	//Muscleness boost!
	outputText(player.modTone(85,5+rand(5)), false);
	doNext(camp.returnToCampUseOneHour);
}
}
}
