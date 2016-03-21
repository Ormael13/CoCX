package classes.Scenes.Areas.Lake{
	import classes.*;
	import classes.GlobalFlags.*;

	public class GreenSlimeScene extends AbstractLakeContent{
//serviceLowCorruption();
//servuceLowCorruptionHighLust();
//maleRapesOoze();
//femaleRapesOoze();
//oozeButtRapesYou();
//oozeRapesYouOrally();
//oozeRapesYouVaginally();

private function serviceLowCorruption():void
{
	outputText("You seem unable to pull your eyes away from the creature, clearly helpless and distressed in its current state.  Carefully, you step forward, the slime barely registering your presence any longer.  It momentarily grimaces as if in agony, and you decide that you can't simply leave it like this.", true);
	outputText("You sit next to the blob and gently touch its throbbing member.  The surface membrane is moist and almost velvety in texture, not entirely smooth but not truly rough either.  You slowly run a hand along its length, glancing at the creature's face as you do so.  It seems calmer somehow, more in control of its breathing.\n\n", false);
	//Big peoples!
	if (player.tallness >= 82)
	{
		outputText("You try gently wrapping one of your massive hands around its erection, and squeezing.", false);
	}
	//Not so big peoples
	else
	{
		outputText("You try to wrap one of your hands around the erection, but end up having to use both to get a firm grip.", false);
	}
	outputText("  In spite of its appearance the thing is very soft and spongy, although a strong pulse periodically makes it surge in your hand, pushing itself into the cracks between your fingers.  Looking back at the thing's face you slowly begin to pump up and down the massive erection, which grows moist and then a little slick as some of the creature's thin green fluid seeps out onto your hands.  You feel slightly flush and start moving faster, the slime reacting positively to your ministrations.  The rest of its body seems to pulse as well, the definition in its body returning as you continue.  It even begins moving its hips in time with you, its facial features slowly becoming less and less pronounced as its erection gains more definition, clearly forming into a " + monster.cockDescriptShort(0) + ".\n\n", false);
	//Big peoples!
	if (player.tallness >= 82)
	{
		outputText("The throbbing of the slime's " + monster.cockDescriptShort(0) + " continues to grow stronger until the creature surprises you by reforming its arms and reaching up to grab you, holding your hand at the tip of its cock.  A fraction of a moment later the thing visibly arches its back off the ground and erupts into your palm, a thick jet of its green fluid splashing fiercely against your hand and spilling down the length of its penis, soaking both of your hands and even splashing onto your nearby lap.  You watch the creature's face with a mixture of shock and a sudden surge of excitement, its erection and face both turning smooth and featureless, before its cock slowly recedes back into its body.  The slime slowly begins to retreat as you return to your senses, looking down at your hands covered in the creature's green fluids.  When you look up again the creature is gone.\n", false);
	}
	//Not so big peoples!
	else
	{
		outputText("The throbbing of the slime's " + monster.cockDescriptShort(0) + " continues to grow stronger until the creature surprises you by reforming its arms and reaching up to grab you as you grasp him, holding your hands at the tip of its cock.  A fraction of a moment later the thing visibly arches its back off the ground and erupts into your palm, a thick jet of its green fluid splashing fiercely against your hands and spilling down the length of its penis, soaking both of your hands and even splashing onto your nearby lap.  You watch the creature's face with a mixture of shock and a sudden surge of excitement, its erection and face both turning smooth and featureless, before its cock slowly recedes back into its body.  The slime slowly begins to retreat as you return to your senses, looking down at your hands covered in the creature's green fluids.  When you look up again the creature is gone.\n", false);
	}
	player.slimeFeed();
	dynStats("sen", 2);
}
private function serviceLowCorruptionHighLust():void
{
	player.slimeFeed();
	outputText("You find yourself unable to tear your eyes away from the creature as it undulates almost hypnotically in front of you, the heat in your crotch rising.  The rigid protrusion at its middle visibly pulses and throbs, and with a small grin you step closer to the ooze and strip off your clothing.\n\n", true);
	outputText("You straddle the creature's chest and playfully run a hand over the tip of its featureless member, which is moist and soft to the touch.", false);
	//Tall peeps
	if (player.tallness >=82) outputText("  You grip the head of the member firmly with one of your large hands and tease the tip with your thumb for a moment before squeezing and sliding your hand to its base.", false);
	//Short peeps
	else outputText("  You run a finger up and down the creature's member a few times before tightly wrapping your hands around the tip and running them to its base.", false);
	outputText("  The erection is spongy and pliable to the touch, and with every pulse it seems to fill the cracks between your fingers.\n\n", false);
	//If player has a cunny
	if (player.vaginas.length > 0)
	{
		outputText("As you rub the creature's shaft you toy with the idea of inserting the thing into your " + player.vaginaDescript(0) + ", biting your lip slightly and sliding forward a bit to rub yourself against the slime's " + monster.cockDescriptShort(0) + ".  You moan a bit and lose yourself for a moment, caught between desire ", false);
		//Non virgin's are sluts!
		if (!player.vaginas[0].virgin) outputText("for that familiar full feeling ", false);
		outputText("and paranoid about allowing this creature inside of you.", false);
		//If you be hella tight
		if (player.vaginalCapacity() <= 18) outputText("  On top of that, you are unsure if the thick, foot and a half long appendage would even fit inside of you.", false);
		outputText("\n\n", false); //this line present to ensure proper paragraph structure
	}	
	//Penises foreplay
	if (player.cockTotal() > 0) {
		//Multicock folk get in their own way
		if (player.cockTotal() > 1) outputText("Your own erect " + player.multiCockDescriptLight() + " rub against the creature's as you work, getting in the way somewhat.  ", false);
		//Big single cocked folk get in their own way too!
		else if (player.cocks[0].cockThickness >= 36) outputText("Your own erect " + player.cockDescript(0) + " rubs against the creature's as you work, getting in the way somewhat.  ", false);
		//Single dick contemplation
		if (player.cockTotal() == 1) outputText("You feel your " + player.cockDescript(0) + " begin to throb and entertain the idea of trying to penetrate it somehow.  You turn a bit and look around the creature for an orifice, but find nothing.  After a few frustrated moments of searching you give up and decide to handle things yourself.", false);
		//Multidick contemplation
		else outputText("You feel your " + player.multiCockDescriptLight() + " begin to throb and entertain the idea of trying to penetrate it somehow.  You turn a bit and look around the creature for an orifice, but find nothing.  After a few frustrated moments of searching you give up and decide to handle things yourself.", false);
		outputText("\n\n", false);
	}
	//Next PG
	//Get it hard
	outputText("As you continue to work the creature's mass its erection gains more and more definition, slowly but surely turning into an unmistakable human penis.  ", false);
	//And here begins the giant goddamn height split.  Hoo boy.
	//Smaller characters!
	if (player.tallness < 82)
	{
		//Hand gets coated in sensitive slime\n
		outputText("A light green fluid begins to coat your hand as you stroke the slime's cock, making your fingers feel warm and sending shivers of arousal through your entire body.\n\n", false);
		//Male or sometimes herm...
		if (player.gender == 1 || (player.gender == 3 && rand(2) == 0))
		{
			//multiCock - mutual masturbation + cum
			if (player.cocks.length > 1) 
			{
				if (player.cocks.length > 0) outputText("Eventually your own arousal becomes unbearable and you reach down to work your one of your " + player.multiCockDescriptLight() + ", massaging the monster's swollen, throbbing head with your other hand.  You gasp slightly as soon as you wrap your hand around your " + player.cockDescript(1) + ", the creature's fluid making you exceptionally sensitive.  You moan in spite of yourself and start to thrust your hips a bit against your fist, feeling both yourself and the creature begin to throb harder and harder.  Before long you can hold out no longer, and feel your body racked by an orgasmic spasm, squeezing tightly with both hands as you blow your " + player.multiCockDescriptLight() + " cover the creature with cum.  ", false);
				//Herms - vegemita vaga-cum.
				if (player.vaginas.length > 0) outputText("Your " + player.vaginaDescript(0) + " quivers and shares in the sensation as you grind yourself against the slime.  ", false);
				//Create cumz
				outputText("The creature reaches its peak as well, and a thick, powerful gout of more green fluid shoots from the slime's cock and into your waiting palm.  You shudder as your orgasm seems to drag on for longer than usual, and notice that the slime's body regains some of its definition for a moment before its cock quickly recedes back into its body.", false);
			}
			//Single cocks
			else 
			{
				//'Small' cocks
				if (player.cocks[0].cockLength <= 30)
				{
					outputText("Eventually your own arousal becomes unbearable and you reach down to work your own " + player.cockDescript(0) + " as well, massaging the monster's swollen, throbbing head with your other hand.  You gasp slightly as soon as you wrap your hand around your " + player.cockDescript(0) + ", the creature's fluid making you exceptionally sensitive.  You moan in spite of yourself and start to thrust your hips a bit against your fist, feeling both yourself and the creature begin to throb harder and harder.  Before long you can hold out no longer, and feel your body racked by an orgasmic spasm, squeezing tightly with both hands as you blow your load onto the creature.  ", false);
					//Herm orgasm text
					if (player.vaginas.length > 0)
					{
						outputText("Your " + player.vaginaDescript(0) + " quivers and shares in the sensation as you grind yourself against the slime.  ", false);
					}
					outputText("The creature reaches its peak as well, and a thick, powerful gout of more green fluid shoots from the slime's cock and into your waiting palm.  You shudder as your orgasm seems to drag on for longer than usual, and notice that the slime's body regains some of its definition for a moment before its cock quickly recedes back into its body.", false);
				}
				//FUGGIN' 'UGE PRICKS!
				else if (player.cocks[0].cockLength >=31)
				{
					outputText("Eventually your own arousal becomes unbearable and you reach down to grope at yourself as well, working the monster's swollen, throbbing head with one of your hands.  Unable to grip it properly you moan a little and hold yourself down against the creature's skin, moving your hips back and forth to get off.  You begin to moan louder as the same greenish secretion that coats your hands begins to cover your " + player.cockDescript(0) + " as well, making it throb even harder than before.  Before long you gasp and double over as you orgasm, hips shaking as you come all over the creature.  ", false);
					//Herm orgasm text
					if (player.vaginas.length > 0)
					{
						outputText("Your " + player.vaginaDescript(0) + " quivers and shares in the sensation as you grind yourself against the slime.  ", false);
					}
					outputText("Instinctively you hold onto the creature's own shaft for support as you do and with a final mighty pulse it also comes, spraying its thin green fluid in a tall gout into the air.  You feel it splash onto your back and " + player.hairDescript() + " as you gasp for breath, before almost falling over as the beast's erection rapidly recedes into its own body.", false);
				}
			}
			//Newline PG
			outputText("\n\n", false);
		}
		//female or herm version (if the herm didn't trigger male)
		else if (player.gender == 2 || player.gender == 3)
		{
			//Foreplay and smearing goo about
			outputText("Eventually your own arousal becomes unbearable and you let one of your hands slide down the creature's erection and body and up your leg, purring softly as a slight warm sensation spreads everywhere you get the green fluid the creature has been so readily leaking.  You let your hand crawl between your legs and gasp slightly as you run a hand over the lips of your " + player.vaginaDescript(0) + ", savoring the sensation before going to work on yourself.  ", false);
			//Big clitties
			if (player.clitLength >= 2) outputText("You moan and lean back slightly as you grip your " + player.clitDescript() + " between your thumb and forefinger, biting your lip at the intense sensations as you rub your thumb over your " + player.clitDescript() + " and shuddering in anticipation and delight.  ", false);
			//Small clitties
			else outputText("You moan and lean back slightly as you start to flick your " + player.clitDescript() + ", the slime's fluid providing excellent lubrication and a luxurious warming feeling as you make small circles around your nub.  ", false);
			//Jack off slime and make it human shapes
			outputText("At the same time you continue to work the head of the slime beneath you, slowly twisting your hand around the top of its large erection.  Before long the mass starts to slim and bulge, becoming more defined before taking on the distinct image of a human penis.  The sight of it further excites you and you begin to work it harder, feeling it start to throb in earnest beneath your touch.  ", false);
			//Tit stuff
			if (player.breastRows.length > 0 && player.biggestTitSize() > 0)
			{
				outputText("You gasp a little as the slime's massive arms reach up from behind you to cup your " + player.allBreastsDescript() + ", and the soft material ", false);
				//Tig ol' bitties
				if (player.biggestTitSize() > 8) outputText("barely contains them.", false)
				//Middling Boobiliciousness
				else if (player.biggestTitSize() > 3) outputText("gently covers them.", false)
				//Tiny ta-tas.
				else outputText("easily smothers them.", false)
				//Get nips played with and nearly cum
				outputText("  You feel the thing tweak your nipples and you moan a little as the ooze begins a gentle, rhythmic massage, teasing your " + player.nippleDescript(0) + " and rubbing you in all the right ways.  With a bit of surprise you notice that its hands actually appear to be completely still, and that all of the motion comes from the creature altering its shape around you.  Your arousal surges as you imagine what this beast would feel like inside you, and quickly start to peak.  ", false);
			}
			//No titties or too small to bother with
			else outputText("You gasp a little as the slime's massive arms suddenly grab your " + player.hipDescript() + " and press you down against its body, and another bulge pushes out between your legs to force your hand away.  Instead of sprouting a second penis, however, the creature starts to gently rock you back and forth along it, eliciting a moan escaping your mouth as the soft material slides delightfully against your nethers.  This, and the aphrodisiac effects of its natural secretions, quickly bring you to your peak.  ", false);
			//Herms rock out with their cocks out
			if (player.cockTotal() > 0)
			{
				//Multicock
				if (player.cockTotal() > 1)
				{
					outputText("You feel your " + player.multiCockDescriptLight() + " surge to their full size as the slime works you over.  They quickly begin to throb and ache for release, a need made only more pressing by your desire to have it fondled.  ",false);
					//of course, if the creature is working the player's crotch because they don't have breasts, they -can- jerk off!
					if (player.biggestTitSize() == 0) outputText("You delicately grasp the head of one of your cocks, your hand slick with the fluids of yourself and of the creature.  The combination of the creature's movements and your own quickly overwhelms you.", false);
				}
				//Single prick
				else
				{
					outputText("You feel your " + player.cockDescript(0) + " surge to full size as the slime works you over.  It begins to throb and ache for release, a need made only more pressing by your desire to have it fondled.  ",false);
					//Play with it if your boobs aren't being manhandled
					if (player.biggestTitSize() == 0) outputText("You delicately grasp the head of your " + player.cockDescript(0) + ", your hand slick with the fluids of yourself and of the creature.  The combination of the creature's movements and your own quickly overwhelms you.", false);
				}
			}
			//New paragraph for orgazms.
			outputText("\n\n",false);
			//Female cum!
			outputText("Finally, you feel a tsunami of pleasure begin to wash over you as you orgasm, and as your entire body shakes you unconsciously try to squeeze the creature between your legs.  It pulls back slightly and with a final mighty pulse, a green fluid explodes from the tip of its " + monster.cockDescriptShort(0) + ", splashing over your entire body.  Everywhere it touches seems to catch fire with pleasure and your already reeling mind almost collapses, and you let yourself fall back against the slime's body as wave after wave of pleasure flows through you.  ", false);
			//Herm bonus cum!
			if (player.cockTotal() > 0)
			{
				//Multidicked herms
				if (player.cockTotal() > 1)	outputText("You let out a strangled gasp as your body, already straining from exertion, shudders again as your " + player.multiCockDescript() + " explodes into orgasm, showering both you and the creature in jizz.  ", false);
				//Single cocked herms
				else outputText("You let out a strangled gasp as your body, already straining from exertion, shudders again as your " + player.cockDescript(0) + " explodes into orgasm, sending a jet of your warm jizz into the air.  ",false);
			}
			outputText("When you open your eyes you notice that the creature's erection has disappeared and the almost predatory calm it possessed when you first encountered it has returned, though different somehow.", false);
			//New PG
			outputText("\n\n", false);
		}
		//UNFINISHED - Genderless Text goes here - suggested giving monster oral with possible slimecock growth?
		if (player.gender == 0) {}
		//Monster leaves (for both male and female variants)
		outputText("After a few moments the creature slides out from under you, slinking back into the waters of the lake as you recover from the ordeal.  When your wits return, there is nothing to do but stop back by camp.\n",false);
	}
	//PHEW! that was a big one.  now...  we do it all again for large players, whee! and this is why this thing is so goddamn long.
	else if (player.tallness >= 82)
	{
		outputText("A light green fluid begins to coat your hand as you stroke the slime's cock, making your fingers feel warm and sending shivers of arousal through your entire body.  ",false);
		//Males/Herms
		if (player.gender == 1 || (player.gender == 3 && rand(2) == 0))
		{
			//Multicock foreplay
			if (player.cockTotal() > 1) outputText("Eventually your own arousal becomes unbearable and you reach down to work one of the shafts in your " + player.multiCockDescriptLight() + ", as well, continuing to run your other hand up and down the creature's length.  You gasp slightly as soon as you wrap your hand around your " + player.cockDescript(1) + ", the creature's fluid making you exceptionally sensitive.  You moan in spite of yourself and start to thrust your hips a bit against your fist, stroking yourself and the creature from crest to root.  The creature's erection gains definition as it starts pulsing harder and faster, turning into a distinctly human penis.  ", false);
			//SingleCock
			else
			{
				outputText("Eventually your own arousal becomes unbearable and you reach down to work your own " + player.cockDescript(0) + " as well, continuing to run your other hand up and down the creature's length.  You gasp slightly as soon as you wrap your hand around your " + player.cockDescript(0) + ", the creature's fluid making you exceptionally sensitive.  You moan softly in spite of yourself and begin to thrust your hips a bit against your fist, stroking yourself and the creature from crest to root.  The creature's erection gains definition as it starts pulsing harder and faster, turning into ", false);
				//Compare cocks
				if (player.cocks[0].cockType == CockTypesEnum.HUMAN) outputText("a near exact replica of your own " + player.cockDescript(0) + "!  ", false);
				//Cocks are different so it's a 'human' penis
				else outputText("a distinctly human penis.  ", false);
			}
			//vaginal arousal & cum text for herms
			if (player.vaginas.length > 0)
			{
				outputText("The intense sensations ripple through your entire body, and your " + player.vaginaDescript(0) + "grows wet with arousal.  You push against the creature and rhythmically slide back and forth, its soft, moist body conforming to your folds and creating a wonderfully arousing sensation.", false);
				outputText("\n\nIt isn't long before you can no longer hold yourself back and with a groan, you explode, showering the creature with your seed as your " + player.multiCockDescript() + " and " + player.vaginaDescript(0) + " simultaneously explode into orgasm.  The ooze's penis also seems to swell and a torrent of the green fluid gushes from the tip, creating a large, slippery pool that coats your bottom half and forms a small pool on the ground around you before soaking into the earth.  As you catch your breath the creature's cock begins to lose definition and then recedes as the thing pulls itself back into a blob and slides out from under you, quietly escaping into the nearby water as you watch.  As you get up, you notice a still partly solid blob of green gel on the ground, and pick it up.", false);     
			}
			//Pure male orgasm
			else outputText("\n\nIt isn't long before you can no longer hold yourself back and with a groan, you explode, showering the creature with your seed.  The ooze's penis also seems to swell and a torrent of the green fluid gushes from the tip, creating a large, slippery pool that coats your bottom half and forms a small pool on the ground around you before soaking into the earth.  As you catch your breath the creature's cock begins to lose definition and then recedes as the thing pulls itself back into a blob and slides out from under you, quietly escaping into the nearby water as you watch.", false);
		}
		//Female/Herm Masturbation
		else if (player.gender == 2 || player.gender == 3)
		{
			outputText("Eventually your own arousal becomes unbearable and your other hand finds its way to your ", false);
			//TITTY ACTIOOOON
			if (player.breastRows.length > 0 && player.biggestTitSize() > 0)
			{
				outputText(player.allBreastsDescript() + ", and you begin to grope yourself as you grip the creature's shaft and stroke it from crown to root.  As the pulsing of the beast's mass becomes more pronounced so does it's appearance, and it takes on the distinct look of a human penis.  Grinning you pull it towards you a bit and rapidly stroke the shaft with one hand while working the cock's head with the other, making the slime buck slightly, pulsing within your hands.  Without warning, its wide arms reach up, one reaching across your breasts while the other drapes across your thighs, the hand going for your " + player.vaginaDescript(0) + ".  ", false);
				//Cant cover all of tig ol' bitties
				if (player.biggestTitSize() > 8) outputText("Its hand expands, struggling to cover all of your " + player.allBreastsDescript() + ", ", false);
				//Middling ta-tas get covered
				else if (player.biggestTitSize() > 3) outputText("Its hand expands and gently covers your " + player.allBreastsDescript() + ", ", false);
				//Small tits?  Pwned.
				else outputText("Its hand easily smothers your " + player.allBreastsDescript() + ", ", false);
				outputText("and you stop for a moment until the slime tweaks one of your " + player.nippleDescript(0) + ", prompting you to begin rubbing it again.  The hand on your breasts expertly massages them with what feels like dozens of fingers as the other gently runs a finger over your gash.  Looking down, you realize that the slime doesn't appear to be moving at all - it is shifting its own mass to massage you, creating a feeling like nothing you've ever experienced!  ", false);
				outputText("A bead of realization dawns on you just before you feel it hit, the surprise making you squeeze and twist at the head of the slime's cock.  ",false);
			}
			//Non titty foreplay
			else outputText("rapidly moistening " + player.vaginaDescript(0) + ", and you begin to slide a finger along your gash as you grip the creature's shaft and stroke it from crown to root.  As the pulsing of the beast's mass becomes more pronounced so does its appearance, and it takes on the distinct look of a human penis.  Grinning you pull it towards you a bit and rapidly stroke the shaft with one hand while working the cock's head with the other, making the slime buck slightly, pulsing within your hands.  Without warning, one of its wide arms reaches up, draping across your thighs, the hand going straight for your " + player.vaginaDescript(0) + ".\n", false);
			//clitoris play w/ cock text
			if (player.cockTotal() > 0)
			{
				//since players without breasts are wholly surprised here, this needs to be acknowledged.
				if (player.biggestTitSize() == 0 || player.breastRows.length == 0)
				{
					outputText("You begin to moan as the creature rubs the " + player.vaginaDescript(0) + " beneath your " + player.multiCockDescript() + ", working you with incredible skill, but sadly ignoring your needy ", false);
					//multi!
					if (player.cockTotal() > 1) outputText("penii ", false);
					//Single
					else outputText("penis ", false);
					//SURPRIZES!
					outputText("as it does.  What comes next is an utter surprise, making you unconsciously wring the head of the slime's cock.  ", false);
				}
				//Clit engulph'ed!
				outputText("The creature's smooth, gel-like body envelopes your " + player.clitDescript() + " and slowly pulsates, stroking it from multiple angles at once and making you gasp with pleasure.  You're torn with the urges to both thrust your hips towards it to seek more pleasure and to draw away from the sheer intensity of the sensations, and settle for helplessly moaning as your hands unthinkingly tighten and squeeze around the head of the creature's cock, causing it to release a massive stream of green fluid across your chest and body.", false);
			}
			//Just clits, no cocks.
			else
			{
				//since players without breasts are wholly surprised here, this needs to be acknowledged.
				if (player.biggestTitSize() == 0 || player.breastRows.length == 0) outputText("You begin to moan as the creature rubs your " + player.vaginaDescript(0) + ", working you with incredible skill, but what comes next is an utter surprise, making you unconsciously wring the head of the slime's cock.  ", false);
				//Clit engulph'ed!
				outputText("The creature's smooth, gel-like body envelopes your " + player.clitDescript() + " and slowly pulsates, stroking it from multiple angles at once and making you gasp with pleasure.  You're torn with the urges to both thrust your hips towards it to seek more pleasure and to draw away from the sheer intensity of the sensations, and settle for helplessly moaning as your hands unthinkingly tighten and squeeze around the head of the creature's cock, causing it to release a massive stream of green fluid across your chest and body.", false);
			}
			//New PG, CUM!
			outputText("\n\n", false);
			//slime has orgasmed, time for the player.  again, split for cock-appropriateness.
			//Herms
			if (player.cockTotal() > 0) outputText("Even as it does so it continues to masterfully work your body, putting you on edge with its ministrations and keeping you there for several torturous, glorious minutes as you practically lose control over your body.  Eventually the creature seems to pull on everything at once, finally causing you to orgasm as you all but scream in pleasure.  Your " + player.multiCockDescript() + " explodes as well, sending thick ropes of your steaming ejaculate into the air as the monster finishes with you.  ", false);
			//Fems
			else outputText("Even as it does so it continues to masterfully work your body, putting you on edge with its ministrations and keeping you there for several torturous, glorious minutes as you practically lose control over your body.  Eventually the creature seems to pull on everything at once, finally causing you to orgasm as you all but scream in pleasure.  ", false);
			//Creature exits stage left!
			outputText("You barely notice as the creature's erection recedes and it slides out from under you, leaving you utterly satisfied.  When you do finally recover your senses you find no other traces of its presence.", false);
		}
	}
	player.orgasm();
	dynStats("sen", 3);
}

private function maleRapesOoze():void {
	outputText("Noting your own erectness, you decide that the unusual nature of the thing in front of you is of, at best, minor concern, and resolve to fuck it to satisfy your own desires.\n\n", true);
	outputText("You approach the creature and examine it, finding no real orifices to speak of.  ", false);
	// Random check here for oral or anal
	// oral rape text
	if (rand(2) == 0)
	{
		//MULTICAWK
		if (player.cockTotal() > 1) outputText("Shrugging, you decide to go with the closest thing available and walk towards its head.  You spend a moment deciding which of your organs to ravage the creature with, eventually settling on the largest,  ", false);
		else outputText("Shrugging, you decide to go with the closest thing available and walk towards its head, pulling out your " + player.cockDescript(0) + " as you do so.  You kneel over the thing's head and stroke your penis lightly to ensure it is fully ready,  ", false);
		//Balls ftw
		if (player.balls > 1) outputText("anointing the slime's face with your " + player.sackDescript() + " as you do.  ", false);
		//Ball-less bitches
		else outputText("probing at the 'mouth' of the creature with your free hand.  ", false);
		//Continue the setup...
		outputText("You pull back for a moment and aim your penis downward, resting the ", false);
		//!! PENISTYPE
		switch(player.cocks[0].cockType)
		{
			case 0: //human cock
				outputText("tip", false);
				break;
			case 1: //horse cock
				outputText("flared tip", false);
				break;
			case 2: //dog cock
				outputText("pointed tip", false);
				break;
			case 4: //tentacle cock
				outputText("rounded tip", false);
				break;
		   default: //error text
				outputText("tip", false);
				CoC_Settings.error("");
				trace("ERROR: Penis type not supported, defaulting to tip.");
				break;
		}
		outputText(" on the inside of its mouth and pushing.  You feel the material give and push harder, the membrane material that covers the slime's exterior stubbornly refusing to give.  Finally, after some frustration, you grab the creature by what would be its neck and try to pull it back to your pelvis, thrusting forward at the same time.  It finally gives, and you see your " + player.cockDescript(0) + " surge into its mouth", false);
		//This series deliberately not else-if statements.
		if (player.cocks[0].cockLength >= 12) outputText(", down its throat,", false);
		if (player.cocks[0].cockLength >= 24) outputText(" into its torso,", false);
		if (player.cocks[0].cockLength >= 48) outputText(" and all the way through to its hips,", false);
		outputText(" and grunt approvingly.  You begin to slowly pull yourself out and then thrust yourself back in, feeling a moistness as some fluid surrounds your cock.  ", false);
		//player doesn't care about monster's wellbeing
		if (player.cor >= 60) outputText("You wonder for a moment if you've broken the creature's membranous skin, then shrug and decide you don't care.", false);
		//player shows concern for monster
		else outputText("You wonder for a moment if you've broken the creature's membranous skin, but the continuing presence of the creature's throbbing erection implies that it's in relatively little distress.", false);
		//New PG
		outputText("\n\n", false);
		//Start fucking in earnest
		outputText("You start to thrust with more vigor, thrusting until your hips mash against the ooze's skin, feeling yourself build to orgasm even faster than usual as your " + player.cockDescript(0) + " begins to feel warm and incredibly sensitive.  Oddly, as you pump the creature's mouth it seems to regain some of the definition it lost when it collapsed earlier, the protrusion between its legs shaping into a fully defined human dick", false);
		//Balls ftw
		if (player.balls > 1) outputText(" as your " + player.ballsDescriptLight() + " slap against its face", false);
		outputText(".  One of its arms reaches up to meekly rub at its own erection.  You grin as this fuels your own lust, and you start to thrust even harder.", false);
		//vaginal arousal text
		if (player.vaginas.length > 0) outputText("  Your " + player.vaginaDescript(0) + " begins to grow wet as you repeatedly force yourself into the creature's throat.  You take a single deep stroke and bottom out into the creature, grinding your moist femininity against the soft, sensual material of the creature's face.", false);
		//New PG for cumming!
		outputText("\n\n", false);
		outputText("Before long you find yourself shouting as you pump your seed into the creature, watching as the semen is caught by unseen currents and dispersed into its body.", false);
		//vaginal orgasm text
		if (player.vaginas.length > 0) outputText("  This is quickly followed by a quivering between your nether-lips as your " + player.vaginaDescript(0) + " quivers in orgasm shortly afterwards.", false);
		outputText("  You pull your " + player.cockDescript(0) + " out of the thing's face slowly, relishing the sensation, producing an audible *pop* when your tip finally exits the creature.  A satisfied smirk crosses your face as the defeated beast's erection shrinks back into itself before sliding off, back into the nearby water.", false);
	}
	//anal rape text
	else
	{
		//Multipricks
		if (player.cockTotal() > 1)
		{
		   	outputText("You shrug at the lack of obvious orifices and decide to go for the most common one, choosing the ", false);
			if (player.cockTotal() == 2) outputText("larger", false);
			else outputText("largest", false);
			outputText(" of your" + player.multiCockDescriptLight() + " as you grab the slime and roughly try to turn it over.  Surprisingly it maintains its cohesion and flops onto its side, its erection flopping wetly onto the ground.  ", false);
		}
		//Single dicks
		else outputText("You shrug at the lack of obvious orifices and decide to go for the most common one, pulling out your " + player.cockDescript(0) + " as you grab the slime and roughly try to turn it over.  Surprisingly it maintains its cohesion and flops onto its side, its erection flopping wetly onto the ground.  ", false);
		outputText("  You position your member around where you think the asshole would be and push, smiling as the membrane moves aside and you penetrate into a tight, deep hole.  ", false);
		if (player.cocks[0].cockLength >= 24) outputText("By the time you finally bottom out, your " + player.cockDescript(0) + " is nearly halfway through its torso.", false);
		else if (player.cocks[0].cockLength >= 48) outputText("By the time you finally bottom out, your " + player.cockDescript(0) + " reaches nearly into the slime's neck.", false);
		else if (player.cocks[0].cockLength >= 60) outputText("Your penis keeps going deeper and deeper, through the chest, neck, and head, before finally stretching the slime as far as it needs to go to accommodate the full length of your " + player.cockDescript(0) + ".", false);
		outputText("  With a satisfied smile you begin pumping, slowly at first before picking up speed.  The slime's anus feels better than anything you've ever had before, apparently coming with its own lubrication but still being tight, hugging your cock like a custom-fit fuck toy.  ", false);
		//vaginal arousal text
		if (player.vaginas.length > 0) outputText("Your " + player.vaginaDescript(0) + " grows wet as you work the thing's hole, every slap of your hips against the thing's ass sending a pang of pleasure through your nethers.  ", false);
		outputText("After only a few minutes you realize that you can't hold out for much longer, as whatever is inside the creature seems to be making you extra sensitive.  Deciding to make the most of it, you double your speed and grit your teeth, enjoying the slime for all it's worth before ", false);
		if (player.cockTotal() > 1) outputText("your " + player.multiCockDescriptLight() + " explodes into orgasm, your load filling the space inside the creature and spraying in thick streams across its back.", false);
		else outputText("exploding inside it, your load filling the space around your cock with a white, milky fluid.", false);
		//vaginal orgasm text
		if (player.vaginas.length > 0) outputText("  As you pump your jizz into the creature an almost electrical shock runs through your body, starting from your " + player.vaginaDescript(0) + " and radiating outwards.", false);

		outputText("  The thing seems to clamp down on you even tighter as you pull out, and you relish the sensation.  Its tight ass leaves your " + player.cockDescript(0) + " almost perfectly clean afterward, a glob of white still stuck inside the creature as it changes back into its original, amorphous state.  The cloud disperses as the slime slinks off.", false);
	}
	player.orgasm();
	dynStats("sen", 3);
}

private function femaleRapesOoze():void {
	player.slimeFeed();
	outputText("You feel a stirring inside your feminine side as you eye the slime's throbbing erection, and decide to take advantage of its current state to satisfy your own urges.  You strip off your clothes and walk forward, straddling the creature's thighs and running a hand over its member.  You pull it in against your body and stroke the soft, velvety, and just slightly moist shaft,", false);
	if (player.cocks.length > 0)
	{
		outputText(" your " + player.vaginaDescript(0) + " growing wet and your " + player.cockDescript(0) + " growing firm as you imagine it inside you.  ", false);
	}
	else
	{
		outputText(" growing wet as you imagine it inside of you.  ", false);
	}
	// !!NOTE
	// breasts check here. if you want to allow/encourage entirely flat chested loli / cuntboy type stuff, change the bottom else-if to >= 0.
	if (player.biggestTitSize() > 8)
	{
		outputText("You grin and lean forward slightly, letting your " + player.allBreastsDescript() + " rest against its member.  You pull it forward and wedge it between them, wrapping yourself around it and slowly massaging the cock with your chest.  You feel the creature begin to pulse and throb as your chest begins to feel slick, and so you sit up to prevent the slime from finishing early.  As you pull yourself off of it you notice with a bit of delight that its formerly indistinct shaft is now a perfectly sculpted human cock, a full foot and a half long, and your breasts are now covered with a strange green fluid.\n\n", false);
	}
	else if (player.biggestTitSize() > 3)
	{
		outputText("You smile mischievously and lean down, pressing your chest down around the creature's member.  You slowly start to move back and forth and the slime responds positively by slowly moving its hips in time with your bod, all the while throbbing and pulsing magnificently.  You watch with wide eyes as the shaft shifts, changing into a perfectly sculpted human cock, a full foot and a half long.  Sensing the thing getting close you ease yourself off and sit back up, your chest now covered with a green fluid.\n\n", false);
	}
	else if (player.biggestTitSize() >= 0)
	{
		outputText("You pull the member tight against your body and run your hands along its length, rubbing it over your belly as the shaft throbs and pulses beneath your touch.  You lean forward a little and rub the tip of it against your " + player.allBreastsDescript() + ", smiling as it leaves a little bit of greenish fluid behind.  After enduring your ministrations for a short time the creature begins moving its hips in time with you.  You hold in a slight gasp as the ooze's shaft shifts, changing into a perfectly sculpted human cock, a full foot and a half long.\n\n", false);
	}
	/*
	else
	{
		//this line designed to return helpful text if something goes wrong.it should work. i think. maybe. i have no idea, this project is my first experience with as3.
		outputText("<<ERROR: breast size check returned invalid number -" + String(player.biggestTitSize()) + "- at green slime' player win + vagina + high lust;>>", false);
	}*/
	outputText("Before long you cannot take the temptation anymore and lift your hind end into the air, moaning softly as you rub the tip of its cock against your " + player.vaginaDescript(0) + ".", false);
	//defloration text
	if (player.vaginas[0].virgin)
	{	
		//low corruption reveres this loss
		if (player.cor <= 20)
		{
			outputText("  You hesitate for a moment as you hover over the creature, a sudden surge of nervousness comes over you.  This is a moment that only comes once.  You let your weight push the creature into you, slowly at first, then forcing yourself down as far you can go.  You gasp at the initial pain, but it quickly dissipates as the creature's fluids coat your interior with a cool, soothing fluid.  ", false);
		}
		//higher corruption tosses it aside
		else
		{
			outputText("  You smile as you ram yourself onto the creature, finally removing your virginity.  You quickly start moving and give a pleased gasp as the creature's fluids coat your interior with a cool, soothing fluid.  ", false);
		}
	}
	else if (player.vaginalCapacity() >= 18)
	{
		outputText("  You enthusiastically lower yourself onto the slime's cock, letting out a small gasp of surprise as it slides inside of you.  The creature quickly understands your intentions and reaches up with its hands, beginning to pump you furiously.  ", false);
	}
	else
	{
		outputText("  You hesitate at the sheer size of the slime's cock and the creature, sensing your hesitation, reaches up with its strong arms and grips your ass, forcefully pushing you onto itself.  ", false);
	}
	outputText("The thing's cock, though rigid, somehow manages to squish and expand wherever needed to conform perfectly to your insides, adapting to your " + player.vaginaDescript(0) + " with ease as you ride it.", false);
	//penis arousal text
	if (player.cockTotal() > 0)
	{
		if (player.cockTotal() == 1)
		{
			outputText("  Your " + player.cockDescript(0) + " grows hard as you are penetrated, and with the creature handling the movement you reach down to jack yourself off.", false);
		}
		else
		{
			//might be kind of interesting to include text that identifies the cocks you use, but is possibly pointless.
			outputText("  Your cock grows hard as you are penetrated, and with the creature handling the movement you reach down, jerking off a different cock with each hand.", false);
		}
	}
	outputText("\n\n", false);
	outputText("The slime pumps you hard, eliciting moans of arousal as you lean forward, finally giving in to instinct.  You find that it can easily support your weight as you lean on the thing's chest, using it as leverage as you buck your hips against it.  After a while the slime begins to react almost perfectly to your moaning and panting, changing its pace and size to incredible effect.  You feel exceptionally wet through the entire process, the creature's lubricant mixing with your own.  It has an aphrodisiac effect, intensifying your sensation and making your " + player.vaginaDescript(0) + " feel hot as you fuck it.  ", false);
	outputText("Before long you collapse entirely, resting your entire weight on the creature as it pulls your " + player.hipDescript() + " tightly against its own.  You let out a loud gasp as the thing begins to stir itself around inside of you, vigorously massaging your insides with its cock.  Before long this pushes you over the edge, and you clutch at the slime, pressing yourself against it as hard as you can.  ", false);
	//penis orgasm text
	if (player.cockTotal() > 0)
	{
		if (player.cockTotal() > 1)
		{
			outputText("Your " + player.multiCockDescriptLight() + " explode into simultaneous orgasm, releasing ", false);
			outputText(num2Text(player.cocks.length), false);
			outputText(" thick streams of semen onto you and the creature, your mind blanking at the massive relief.  You vaguely notice your ejaculate sinking into the creature's body and getting absorbed as you give yourself to pleasure.  ", false);
		}
		else
		{
			outputText("Your " + player.cockDescript(0) + " explodes into orgasm and releases thick streams of semen onto both you and the creature, your mind blanking at the release.  You vaguely notice your ejaculate sinking into the creature's body and getting absorbed as you give yourself to pleasure.  ", false);
		}
	}
	outputText("You feel a rush of liquid flood your insides, ", false);
	// !! NOTE
	// since this line is centered around previous sexual knowledge, change virginity status at the end of the event rather than beginning so this can fire properly.
	if (!player.vaginas[0].virgin)
	{
		outputText("not as thick as semen, ", false);
	}
	outputText("filling you past full and flowing out along the creature's cock, leaving you with a slight bulge at your belly and a pool of green fluids on the ground beneath you.  You gasp and hold your breath as you lay on the creature, its grip slowly loosening.  Its cock slides out of you and a flood of liquid pours out of your " + player.vaginaDescript(0) + " as it begins to leak out from under you, gently letting you onto the ground.  You tremble on the ground for a few moments as you recover your wits, and once you do you realize that the creature has left.  You find no trace of the creature's presence afterward except a thin trail of green fluid leading to the nearby waters.", false);
	player.orgasm();
	dynStats("sen", 3);
}

private function oozeButtRapesYou():void 
{
	player.slimeFeed();
	outputText("You collapse under the beating from the slime's soft but heavy fists, dazed and disoriented.  You weakly try to resist as the slime rolls you onto your stomach and lifts your " + player.buttDescript() + " into the air as it takes up a position behind you.  It holds your head against the ground with one hand and strips off your clothes with the other, pressing its trunk up against you.  Its skin is soft, velvety, and firm, but it is also easily pliable.  You feel something grow out of its body and almost instantly realize what's going on.  The slime rubs its moist cock between your cheeks for a moment, before pulling back.  You realize with a tiny bit of fear that the creature's tool must be massive – over a foot, at least, and several inches wide!  It runs its tip over your ", false);
	//Girls get fondled. 
	if (player.vaginas.length > 0) outputText(player.vaginaDescript(0) + " and " + player.assholeDescript(), false);
	//No coochie
	else {
		//Ballsy
		if (player.balls >= 2) outputText(player.assholeDescript() + " and " + player.ballsDescript(), false);
		//No balls, no pussy, just butt
		else outputText(player.assholeDescript(), false);
	}
	outputText(" before settling over your rear entrance.  ", false);
	// virgins just assume it wont fit
	if (player.analCapacity() < 18 || player.ass.analLooseness == 0)
	{
		//...but this wont necessarily be a turnoff.  id put in some sort of formula that determines the corruption rating needed for this
		//based on player's current anus size, but that seems excessive and uneccesary.
		if (player.cor <= 50) outputText("You feel a bit of fear as you tremble under the creature's weight, worried about the damage that its massive size might do to your ass.  ", false);
		else if (player.cor < 100) outputText("In spite of your worries about the creature's size, you can't help but feel a little bit excited at the idea of having this beast take you from behind.  ", false);
		//and something special for the total whorebags that have somehow not already wrecked their asses.
		else outputText("You almost lick your lips in anticipation and push your hips back greedily, eager to feel the monster's cock stretch your asshole wide.  ", false);
  	}
	outputText("You grimace slightly and it pushes at your sphincter, then penetrates.  You let out a slight gasp in spite of yourself as its cock warps, deforming to stretch your ass without pushing you beyond your limits.  It pushes itself several inches inside you and stops, pausing as you catch your breath and collect yourself.", false);
	//De-virgin
	player.buttChange(monster.cockArea(0), true);
	outputText("\n\n", false);
	outputText("With a deliberate slowness the slime pulls out of you and then thrusts back inside, this time going deeper than before.  It continues like this and you realize that the penetration is entirely painless, the creature's pliability and moistness allowing it to easily glide inside you.  Before long you feel it bottom out inside you, its soft member curving perfectly through your insides as it trunk presses against your behind.  The slime begins fucking you with short, shallow strokes and you feel a moistness build inside your ass as the creature's fluid begins to accumulate.  It begins to quicken and deepen its strokes as you feel a heat build inside of you, the creature's fluid apparently having an aphrodisiac effect.\n\n", false);
	outputText("Before long you find yourself moaning under the beast's attack, pleasure washing through your nethers in spite of yourself as it pumps your ass.  ", false);
	//cock arousal
	if (player.cockTotal() > 0) outputText("You feel pangs of pleasure run through your body as its member repeatedly strokes your prostate from the inside, stimulating it.  ", false);
	outputText("Its dick shifts slightly, continually growing and shrinking in tiny amounts in a continual, heavy throb.  ", false);
	//masturbation begin 
	//Cawkz!
	if (player.cockTotal() > 0)
	{
		//Single
		if (player.cockTotal() == 1) outputText("You quickly grow erect under the creature's embrace as it pistons into your ass, and before long you stand at full attention.  You weakly rub yourself with one hand as it pumps you, and quickly approach orgasm.  ", false);
		//Multi!
		else outputText("Your " + player.multiCockDescript() + " quickly grows erect under the creature's embrace as it pistons into your ass, and before long you stand at full attention.  You weakly rub at a different cock with each hand as it pumps you, and quickly approach an orgasm.  ", false);
	}
	//Vaginas!
 	if (player.vaginas.length > 0) outputText("Your " + player.vaginaDescript(0) + " grows wet as the creature continues to assault you, and your cleft begins to ache for a soft touch.  As if sensing your thoughts the creature obligingly wraps a hand around and under you and begins alternating between sliding along your gash and stroking your " + player.clitDescript() + ".", false);
 	//New PG
	outputText("\n\n", false);
	outputText("The creature begins to throb more powerfully as its arousal builds, your own arousal growing with it, equally from sexual and fearful excitement.  With a final powerful thrust the creature rams its entire length inside you and you feel a surge of fluid run through its entire member before exploding from the tip.  You open your mouth in a silent shout as you lose your voice for a moment, unable to make a sound as liquid pours into you in an almost endless stream as its cock swells.  ", false);
	//Vaginal Orgasmzzzzzz
	if (player.vaginas.length > 0) 
	{
		//hermaphrodite orgasm
		if (player.cockTotal() > 0) outputText("The creature finally plunges a pair of fingers into your " + player.vaginaDescript(0) + ", and between this and the additional pressure against your prostate you finally come, harder than you ever have before.  Thick ropes of jizm spray onto the ground as the feeling wracks your body.  ", false);
		//vaginal-only orgasm
		else outputText("The creature finally plunges a pair of fingers into your " + player.vaginaDescript(0) + ", the sudden shock finally pushing you to orgasm.  ", false);
	}
	//mangasm
	else if (player.cockTotal() > 0) outputText("The additional pressure against your prostate finally pushes you over the edge and you come hard, spraying your load against the ground.  Thick ropes of jizm spray onto the ground as the feeling wracks your body.  ", false) 
 	outputText("You shudder beneath the creature as it slowly begins to pull out of you, which brings another moan to your lips.  When it finally pops free of your body you feel a deluge of fluid rush from your ass and onto the ground.  You recover yourself as the creature retreats back into the waters, leaving nothing but a trail of slime leading to the water's edge.", false);
	player.orgasm();
	dynStats("sen", 4);
}

private function oozeRapesYouOrally():void
{
	player.slimeFeed();
	outputText("You collapse under the beating from the slime's soft but heavy fists, dazed and disoriented.  The creature surges forward, covering you and forcing you to the ground as it rests on your gut, putting just enough of its apparently enormous weight onto you to keep you pinned.  It leans forward, its massive upper body easily shadowing you, and ", false);
	//Low corrupppppption blush!
	if (player.cor < 20) outputText("you blush as ", false);
	outputText("a large erection shaped like a human's dick forms at the bottom of its torso.  The creature thrusts its hips forward, pushing this new appendage against your face and making its intent very clear.\n", false);
	//slutty
	if (player.cor >= 70)
	{
		outputText("You lick the tip with more than a little bit of delight, noticing that the creature's skin is somewhat velvety, with a hint of a minty taste to it.  The thing obligingly runs its length along your face as you tease it with your tongue, enjoying its mild taste as it leaves traces of greenish fluids on your face.  Eventually the beast pulls back and rests its tip against your lips, nudging you several times to get you to open your mouth wide before pushing inside your mouth.\n", false);
		outputText("It pistons the head of its shaft back and forth in your mouth for a bit as you rock your head back and forth and suck on it.  A pleasant tingle starts in your mouth and the thing pushes itself to the back of your throat and holds it there, making you squirm in anticipation.  It pulls back slowly, then fiercely thrusts forward.  You feel the soft material of its member squeeze into your throat and contort to perfectly fill you, going deeper and deeper until the bulk of its body is just a few inches away from your face.\n", false);
		if (player.cockTotal() > 0)
		{
			if (player.lust > 40) outputText("Your erect " + player.multiCockDescriptLight() + " throbs as you work the creature, a surge of even greater arousal flowing through your body.  You feel almost desperate for release and even thrust your hips impotently against the empty air, wishing for some form of release.  You try to reach for yourself to masturbate, but find yourself unable to reach around the slime's massive bulk.  ", false);
			else outputText("You feel your " + player.multiCockDescriptLight() + " begin to harden just slightly as you work the creature, a surge of arousal flowing through your body.", false);
		}
		if (player.vaginas.length > 0) {
			outputText("Your " + player.vaginaDescript(0) + " ", false)
			if (player.cockTotal() > 0) outputText("also ", false);
			outputText("grows wet as you work the creature, a surge of arousal flowing through your body.  You rub your thighs together and moan into the creatures cock, desperate to be touched by something.", false);
			// this line is here because it makes no sense for the player to try to reach their genitals twice.  i think i got the logic right.
			if (player.cockTotal() < 1 || player.lust <= 40) outputText("You try to reach for yourself to masturbate, but find yourself unable to reach around the slime's massive bulk.", false);
		}
		outputText("The slime lets itself rest in your throat for a moment and you relish the feeling of it pressing against the inside of your throat, and your entire body begins to tingle with arousal.  Before long you find yourself moving with the creature, and before long you're taking its cock all the way into your throat, pressing your nose up against it as you try to coax if further into you.  The slime speeds up and begins to throb inside you, each pulse of its cock making your throat feel even tighter, but never quite enough to be painful.\n", false);
		outputText("With a final strong thrust the thing rams your face against its hips and you feel a surge of fluid flow down its member and explode into your stomach.  It releases several spurts of fluid into your gullet before it begins to draw out, dribbling fluid into your throat.  It pauses as it pulls its cock head into your mouth and releases a final blast of fluid, which you quickly swallow as it pulls out.  It releases a few final spurts onto your face as it begins to withdraw, and you lick your lips and begin to rub the fluid into your skin.  ", false);
		if (player.lust > 40) {
			outputText("The creature withdraws as you begin to masturbate, furiously working yourself to a quick, but powerful, orgasm.  By the time you recover, it is long gone.", false);
			player.orgasm();
		}
		else outputText("The creature withdraws while you're distracted, leaving no traces of its presence save for what it left on your body.", false);
		player.refillHunger(35);
	}
	//standard
	else if (player.cor >= 20)
	{
		outputText("You make only minor attempts to thwart the creature as it forces its way between your lips, not exactly aroused by its decision but certainly glad that it didn't decide to kill you.  Its member squishes, deforms, and expands to conform to the shape of your mouth as it begins to pump your mouth, going deeper with each stroke.  You brace yourself as it pauses at your lips for a moment before slowly pushing deeper and deeper into your mouth, and then your throat.  You almost feel yourself gag, but find that the creature's unique material helps it avoid this reaction.  The creature keeps pushing until your nose presses against its main body and holds there for a moment, its cock filling your mouth and throat entirely.\n", false);
		outputText("It pulls out just as suddenly, leaving you gasping, leaving a thin trail of green fluid across your face as it pulls away.  Shifting its weight slightly it begins to explore your mouth and lips with one of its hands, and you realize that the creature tastes just slightly of mint.  After a moment it returns its cock to your mouth, thrusting quickly and deeply to again fill your throat, and this time begins pumping your face in earnest.  It begins to throb in your throat, slowly expanding and contracting in a steady, and quickening, rhythm.  You can feel its arousal grow with every thrust, and in spite of yourself, get caught up in the creature's desires.\n", false);
		outputText("Without warning the creature leans forward, grabs you head, and pulls forward as it thrusts, forcing your face into its soft body as its cock goes as deep as it can possibly go.  Its cock practically shivers as you steel yourself for what's about to come, but the creature pulls you off, a powerful blast of thin, green fluid catching you in the face as soon as your mouth is empty.  You try to push your head forward to catch the thing's load more out of instinct than conscious thought, only to have it hold you back as it releases several powerful torrents of ejaculate onto your face.\n", false);
		outputText("The beast moves off of you and you roll over onto your hands and knees, coughing and spitting up green fluid as you recover your senses.  When you finish you look around for the creature but find no traces of it except the fluid on the ground and a slight taste of mint in your mouth.", false);
		player.refillHunger(15);
	}
	//resistant
	else
	{
		outputText("You close your mouth tightly as the penis rubs against your face, the soft, moist skin leaving a trace of green fluid around your mouth.  You try to turn away and the thing forms a third arm from its chest, pressing it over your mouth.  ", false);
		if (player.inte > player.tou) outputText("You force yourself to keep your mouth shut in spite of the lack of air, holding out for as long as you can.  Eventually you become light headed, and pass out.  When you wake up there is no trace of the creature, save for the fluid covering your mouth, chest, and the ground around you.", false);
		else {
			outputText("You force yourself to keep your mouth shut in spite of the lack of air, holding out for as long as you can.  Eventually you become light headed, and instinctively open your mouth to gasp for air.  As soon as you do the creature rams its member into your mouth, thankfully releasing its grip on your face as it does.  You choke for a moment as the beast fills your mouth, thankfully pausing while you catch your breath.\n", false);
			outputText("As soon as you've steadied yourself you feel the thing begin to move again, its shaft slowly forcing its way down your throat.  In spite of its apparent size it easily squeezes to fit the size and contour of your mouth and then throat.  Your eyes widen slightly as it slides deeper and deeper, feeling tight in your throat.  You instinctively reach up to your face and throat, but find yourself completely unable to either push it away or keep it from forcing its way deeper.  Feeling at your throat you realize with a little bit of shock that it's bulging ever so slightly from the cock down your throat.  Eventually you take its foot and a half long shaft nearly to the hilt before it stops, then begins to pull back  as it rapes your mouth and throat.", false);
			outputText("You squirm under the slime as it begins to thrust faster and faster, and soon its shaft begins to throb powerfully, pressing even further out against your throat.  Eventually the thing takes a final powerful thrust into your mouth and arches its back, releasing a powerful torrent of fluid directly into your stomach.  After several strong spurts the thing begins to pull out, pausing as the head of its cock reaches your mouth to fill it with another powerful blast.  You try to avoid swallowing, but the suddenness and sheer amount of it forces a bit down your throat.  The thing eventually pulls all the way out and you cough as you eject the remaining juice.\n", false);
			outputText("The beast moves off of you and you roll over onto your hands and knees, coughing and spitting up green fluid as you recover your senses.  When you finish you look around for the creature but find no traces of it except the fluid on the ground and a slight taste of mint in your mouth.", false);
		}
		player.refillHunger(35);
	}
	dynStats("lib", 2, "sen", 2, "lus", 10);
}

private function oozeRapesYouVaginally():void
{
	player.slimeFeed();
	outputText("You collapse under the beating from the slime's soft but heavy fists, dazed and disoriented.  The creature lunges at you with surprising speed, grabbing you by the ankles and pulling you towards it.  You try to pull away as it pulls you up against its trunk, momentarily fearful that it's going to try and absorb you.  ", false);
	//shy result
	if (player.cor <= 20)
	{
		outputText("This fear quickly disappears as a large, human cock grows from the creature's trunk, and is replaced by an entirely different fear as you realize what it is planning.  The slime wraps its arms around your " + player.legs() + " and squeezes them around its cock.  It moves back and forth several times, sliding its member over your " + player.skinDesc + " and along your " + player.vaginaDescript(0) + ".  Its skin is soft and velvety, slightly moist, and leaves a thin trace of green fluid behind.\n\n", false);
		outputText("You begin to feel a tingle in your nethers as your " + player.vaginaDescript(0) + " grows wet.  Without warning the creature pulls your legs apart and draws its member back along your crotch, pausing a moment to rest the tip on your sex.  You watch it with equal parts excitement and anxiety and steel yourself as it holds there for a moment.", false);
		//!!NOTE
		//i was considering, as a twist from the usual pattern with events in CoC and in going with the idea that the lake is a sort of low-corruption zone, that the slime would actually just let virgins be - or possibly divert to the oral/anal events.  regardless, heres the text.
		if (player.vaginas[0].virgin) outputText("The thing slowly presses against you to penetrate and you grab at the grass beneath you, absolutely certain that it won't fit.  You bite your bottom lip as the cock pierces your virginity, arcing your back as a sharp pang of pain runs through you.  You let out a stuttering gasp as it penetrates deeper into your body, filling the contours of your interior perfectly.  As it does it coats your inside with a tingling, soothing fluid that quickly turns whatever pain you may have felt into a wonderful pleasure.  When the creature finally bottoms out inside you, what remains of its length seems to slide back into the creature's body.  ", false);
		//Middle coochie
		else if (player.vaginalCapacity() < 18) outputText("The thing slowly presses against you to penetrate and you grab at the grass beneath you, almost entirely certain that it won't fit.  You bite your bottom lip to hold in a moan as the cock slides into your " + player.vaginaDescript(0) + ", its girth squeezing down to comfortably slide into you.  You let out a pleasant sigh as it penetrates deeper into your body, filling the contours of your interior perfectly until it finally bottoms out.  What remains of its length seems to slide back into the creature's body as it pulls your hips against its trunk.  ", false);
		//Ginormo coochie
		else if (player.vaginalCapacity() <= 30) outputText("The thing slowly presses against you to penetrate and you grab at the grass beneath you.  A soft moan escapes your lips as the cock slides into your " + player.vaginaDescript(0) + ", its girth changing slightly to fit you almost perfectly, stretching you just the right amount.  Your moan grows louder as it penetrates deeper into your body, filling the contours of your interior perfectly until your hips finally touch its trunk.  There's a short pause and you gasp as the slime's member then grows inside you, lengthening to fill your " + player.vaginaDescript(0) + " perfectly.  ", false);
		//MEGA coochie
		else outputText("The thing slowly presses against you to penetrate and you grab at the grass beneath you.  A soft moan escapes your lips as the cock slides into your " + player.vaginaDescript(0) + ", its girth changing slightly to fit you almost perfectly, stretching you just the right amount.  Your moan grows louder as it penetrates deeper into your body, filling the contours of your interior perfectly until your hips finally touch its trunk.  There's a short pause and you gasp as the slime's member then grows inside you, lengthening until it nearly fills your " + player.vaginaDescript(0) + ".  ", false);
		player.cuntChange(monster.cockArea(0),true,false,true);
		outputText("You arch your back slightly as the slime begins moving, slowly pumping your " + player.vaginaDescript(0) + ".  As it picks up speed a small amount of the thing's greenish fluid builds up around your lower mouth, making your skin tingle and filling you with an unusual arousal.\n\n", false);
		//Cocks
		if (player.cockTotal() > 0)
		{
			//Multi biiiiitches
			if (player.cockTotal() > 1)
			{
				outputText("Your " + player.multiCockDescript() + " rapidly grows erect under this assault and begins to throb.  Having now released yourself to instinct you reach to jerk off, ", false);
				if (player.cockTotal() > 2) outputText("switching between cocks as you rapidly stroke yourself in time with the creature's movements.  ", false);
				else outputText("rapidly stroking one cock with each hand, working yourself in time with the creature's movements.  ", false);
			}
			//Single dick
			else outputText("Your " + player.cockDescript(0) + " rapidly grows erect under this assault and begins to throb.  Having now released yourself to instinct you reach to jerk off, rapidly stroking your " + player.cockDescript(0) + " in time with the creature's movements.  ", false);
		}
		outputText("After a short time the creature penetrates you fully again and stops, and you realize that at some point you had begun moving your hips with it.  You gasp in surprise as the slime's cock begins churning inside of you, massaging you from the inside in a uniquely pleasurable fashion.\n\n", false);
		outputText("It doesn't take much of this to bring you to orgasm.  Your entire body shudders and you arch your back as shocks of pleasure run through you.  The creature pulls you tightly against it and swells just slightly as its movement inside you slows and then stops, then swells at the tip for just a second before releasing a flood of thin, cool fluid inside of you.  It forces its way around the creature's cock and spills out of you.  ", false);
		//Dicks again!
		if (player.cockTotal() > 0)
		{
			//Multi
			if (player.cockTotal() > 1) outputText("Your " + player.multiCockDescript() + " climaxes as well, sending rope after rope of hot, thick cum onto your face and chest.", false);
			//Single
			else outputText("Your member climaxes as well, and you pull a hand to cover your eyes and face as your jism explodes onto yourself.  Your other hand slides to the base of your " + player.cockDescript(0) + " and squeezes as you coat your chest in semen.", false);
		}
		player.orgasm();
		dynStats("sen", 4);
	}
	//standard result
	else
	{
		outputText("This fear quickly disappears as a large, human cock grows from the creature's trunk, and is replaced by excitement as you realize what it is planning.  The slime wraps its arms around your legs and squeezes them around its cock.  You moan softly as it moves back and forth several times, sliding its member between your thighs and along your " + player.vaginaDescript(0) + ".  Its skin feels wonderfully soft and velvety, slightly moist, and leaves a thin trace of green fluid behind.\n\n", false);
		outputText("You begin to feel a tingle in your nethers as your " + player.vaginaDescript(0) + " grows wet.  Without warning the creature pulls your legs apart and draws its member back along your nethers, pausing a moment to rest the tip on your sex.  You push yourself up against it impatiently, growing even wetter from the anticipation.  ", false);
		//VIRGIIIIIN
		if (player.vaginas[0].virgin)
		{
			//!!NOTE
			//same as before with the virginity
			outputText("The thing slowly presses against you to penetrate and you grab at the grass beneath you, certain that it won't fit, but excited to finally have sex for the first time.  You bite your bottom lip as the cock pierces your virginity, arcing your back as a sharp pang of pain runs through you.  You let out a stuttering gasp as it penetrates deeper into your body, filling the contours of your interior perfectly.  As it does it coats your inside with a tingling, soothing fluid that quickly turns whatever pain you may have felt into a wonderful pleasure.  When the creature finally bottoms out inside you, what remains of its length seems to slide back into the creature's body.  ", false);
			player.cuntChange(15, true);
		}
		//TIGHT
		else if (player.vaginalCapacity() < 18) outputText("It finally begins to penetrate you and you grab at the grass beneath you, excited and anxious for it to try and squeeze itself into you.  You bite your bottom lip hold in a moan loudly as the cock slides into your " + player.vaginaDescript(0) + ", its girth squeezing down to comfortably slide into you.  You let out a pleasant sigh as it penetrates deeper into your body, filling the contours of your interior perfectly until it finally bottoms out.  What remains of its length seems to slide back into the creatures body as it pulls your hips against it's trunk.  ", false);
		//Loose
		else
		{
			outputText("It finally begins to penetrate and you grab at the grass beneath you, delighted that its cock seems large enough to fill you", false);
			//SLUT!
			if (player.vaginalCapacity() >= 30) outputText(" at least partly", false);
			outputText(".  A deep, throaty moan escapes your lips as the cock slides into your " + player.vaginaDescript(0) + ", its girth changing slightly to fit you perfectly, stretching you just the right amount.  Your moans grow even louder as it penetrates deeper into your body, filling the contours of your interior perfectly until your hips finally touch its trunk.  There's a short pause and you let out a delighted gasp as the slime's member then grows inside you, lengthening to fill your " + player.vaginaDescript(0), false);
			if (player.vaginalCapacity() >= 30) outputText(" almost perfectly.\n", false);
			else outputText(" perfectly.\n", false);
		}
		outputText("You arch your back in pleasure as the slime begins moving, slowly pumping your wet " + player.vaginaDescript(0) + ".  It picks up speed and a small amount of the thing's greenish fluid builds up around your lower mouth, making your skin tingle and filling you with an unusually strong arousal.", false);
		//Herm text goes here
		if (player.cockTotal() > 0)
		{
			//Multi herms
			if (player.cockTotal() > 1)
			{
				outputText("Your " + player.multiCockDescript() + " rapidly grows erect under this assault and begins to throb.  Having now released yourself to instinct you reach to jerk off, ", false);
				//Lotsa dicks
				if (player.cockTotal() > 2) outputText("switching between cocks as you rapidly stroke yourself in time with the creature's movements.  ", false);
				else outputText("rapidly stroking one cock with each hand, working yourself in time with the creature's movements.  ", false);
			}
			//Single herms
			else outputText("Your " + player.cockDescript(0) + " rapidly grows erect under this assault and begins to throb.  Having now released yourself to instinct you reach to jerk off, rapidly stroking your " + player.cockDescript(0) + " in time with the creature's movements.  ", false);
		}
		//CUM
		outputText("After a short time the creature penetrates you fully again and stops, and you continue to buck your hips against it for a few moments more until it grabs your thighs and holds you tightly and motionless against it.  You quiver against it and moan with desire, desperately wishing that it would continue fucking you.  You gasp in surprise as the slime's cock begins churning inside of you, massaging you from the inside in a uniquely pleasurable fashion.\n\n", false);
		outputText("It doesn't take much of this to bring you to orgasm, and you feel your entire body shudder.  You arch your back as shocks of pleasure run through you, your entire body tensing from the force of the orgasm.  The creature pulls you tightly against it and swells just slightly as its movement inside you slows and then stops, then swells at the tip for just a second before releasing a flood of thin, cool fluid inside of you.  This release doubles the strength of your own orgasm as the fluid forces its way around the creature's cock and spills out of you.  ", false);
		//Herms cum
		if (player.cockTotal() > 0)
		{
			//multi
			if (player.cockTotal() > 1) outputText("Your " + player.multiCockDescript() + " climaxes as well, and you open your mouth as you spray rope after rope of hot, thick jism onto your face and chest.  You relish its salty taste, continuing to stroke yourself even as you come.  ", false);
			//single cock
			else outputText("Your own member finally reaches its climax as well, and you open your mouth as jism explodes onto your face and chest.  Your hands slide to the base of your " + player.cockDescript(0) + " and squeeze as you release thick ropes of ejaculate onto yourself, coating your face and chest as you relish its salty taste.  ", false);
		}
		outputText("You pant as the creature holds perfectly still for a minute, then slowly lets you down as its erection slides out of you.  When the last of its dick finally pops out, a rush of its green slime flows out of you and onto the ground.  The creature leaves you to recover your strength, retreating into the nearby water.", false);
		player.orgasm();
		dynStats("sen", 4);
	}
	
}


internal function rapeOozeWithMilk():void {
	clearOutput();
	outputText("You look over the ooze, wondering what to do about your need to nurse now that it has lost cohesion. After a while of puzzling things out, you decide to wing it, " + player.clothedOrNaked("removing the top of your " + player.armorName + " and ") + "pressing the mess of a monster to your " + player.breastDescript(0) + " and giving it a squeeze to get the milk to it. The slime responds almost immediately, applying pressure from the base of your " + player.breastDescript(0) + " to the tip of your " + player.nippleDescript(0) + ", earning it a shot of milk to your immense satisfaction. As it tends to your " + player.nippleDescript(0) + ", it slowly works its way down your body, almost lovingly ", false);

	// [If male- 
	if (player.gender == 1) 
	{ 
		outputText("caressing your " + player.multiCockDescriptLight(), false);
		if (player.balls > 0) 
		{
			outputText(", and slipping slightly further down to engulf your " + player.ballsDescriptLight() + " as well. ", false);
		}
		else outputText(". ", false);
	}
	// [if female-
	else if (player.gender == 2) 
	{ 
		outputText("manipulating your " + player.clitDescript() + ". ", false);
	}
	//[If Herm- 
	else if (player.gender == 3) 
	{ 
		outputText("caressing your " + player.multiCockDescriptLight(), false); 
		if (player.balls > 0) 
			outputText("and slipping slightly further down to engulf your " + player.ballsDescriptLight() + " as well. ", false);
		else outputText("and almost dripping down to coat your " + player.clitDescript() + " to add to your pleasure. ", false); 
	}
	//[If Genderless- 
	else {
		outputText("caressing the blank spot where your genitalia should be" + player.clothedOrNaked(" despite your " + player.armorName + " still being in place") + ". ", false);
		outputText("\n\n", false);
		outputText("The barrage of pleasurable feelings causes you to fall over onto your " + player.buttDescript() + " and just soak in them, your hands ", false);
	}
	//[if male or genderless- 
	if (player.gender < 1) outputText("gripping the ground as the slime has left you nothing to do; adding your hands to the mix feels like it'd be an insult to the creature's expert work.  ", false);
	//if duder
	else if (player.gender == 1) outputText("Your hands grip the ground as the slime has left you nothing to do; adding your fingers to the mix feels like it'd be an insult to the creature's expert work.  ", false);
	//[if female or Herm- 
	else outputText("Your hands fly to your " + player.vaginaDescript(0) + " and frantically plunge your fingers in and out of it.  You wish the slime would engulf it as well.  ", false);
	
	outputText("You cum many times into the mass, but that's not what truly matters to you. It's an extremely welcome, mind-shatteringly satisfying bonus, but not the main event. What does matter is the slow, meticulous draining of milk from both of your " + player.breastDescript(0) + " at once that the ooze is doing for you. Feeling that it's on the last of your milk, you urge the ooze on, trying to get it to crank up its work on your now-overly sensitive ", false);

	//[if male- 
	if (player.gender == 1) {
		outputText(player.multiCockDescriptLight(), false); 
		if (player.balls > 0) outputText(" and " + player.ballsDescript(), false); 
		outputText(" and ", false);
	}
	//[if female- 
	else if (player.gender == 2) outputText(player.clitDescript() + " and ", false);
	//[if Herm- 
	else if (player.gender==3) {
		outputText(player.multiCockDescriptLight(), false);
		if (player.balls > 0) outputText(", " + player.ballsDescriptLight() + "," , false);
		outputText(" and " + player.clitDescript() + " and ", false);
	}
	outputText(player.breastDescript(0) + ".\n\n", false);

	outputText("Unfortunately, you seem to have done a little too much to it in your battle before. The ooze slides off, leaving you hanging on the edge of orgasm. Deciding you just won't stand for this, you scoop up most the mess left by the monster and use it as a masturbation aid, achieving sweet release by ", false);
	if (player.gender == 1) outputText("feverishly jacking yourself off with it.  The cool feel of it contrasts enough to send you over the edge relatively quickly, and you release your cum into it.  You drop most of its bulk ", false);
	//[if female- 
	else if (player.gender == 2) outputText("rapidly entering it in and out of your " + player.vaginaDescript(0) + " by way of your fingers.  The cool feel of it contrasts enough to send you over the edge relatively quickly, and you release your juices into it.  You flick it off your fingers ", false);
	//[if herm- 
	else if (player.gender == 3) outputText("feverishly jacking yourself off with it while rapidly entering it in and out of your " + player.vaginaDescript(0) + " by way of your fingers.  The cool feel of it contrasts enough to send you over the edge relatively quickly.  You release your cum into it while it absorbs the juices from your " + player.vaginaDescript(0) + ".  You drop some of its bulk ", false);
	//[if genderless- 
	else outputText("rubbing it over your " + player.assholeDescript() + ".  The cool feel of it contrasts enough to send you over the edge relatively quickly, and you drop it as you feel your muscles spasm with the phantom orgasm ", false);
	
	outputText("while using the rest of it to coat your " + player.nippleDescript(0) + " in order to give it the last of your milk.\n\n", false);

	outputText("Now empty, you leave the ooze in the pile it's in and walk away, feeling somewhat disappointed by the lackluster ending of it all, but overall satisfied with the fact that you've nursed.\n\n", false);
	
	//set lust to 0, increase sensitivity slightly
	player.orgasm();
	dynStats("lib", .2);
	//You've now been milked, reset the timer for that
	player.addStatusValue(StatusEffects.Feeder,1,1);
	player.changeStatusValue(StatusEffects.Feeder,2,0);
	combat.cleanupAfterCombat();
}

		public function slimeVictoryRape():void
		{
			//Service for lower corruption
			if (player.cor <= 33) {
				clearOutput();
				if (player.lust < 60) serviceLowCorruption();
				else serviceLowCorruptionHighLust();
			}
			//higher corruption raaaaeeeep
			else {
				clearOutput();
				//male or futa
				if (player.gender == 1 || (player.gender == 3 && rand(2) == 0)) maleRapesOoze();
				//female or futa
				else if (player.gender > 0) femaleRapesOoze();
			}
			combat.cleanupAfterCombat();
			return;
		}

		public function slimeLoss():void
		{
			if (doSFWloss()) return; //No rape in SFW mode.
			clearOutput();
			doNext(playerMenu);
			if (player.gender == 2 || (player.gender == 3 && rand(2) == 0)) {
				temp = rand(3);
				if (temp == 0) oozeRapesYouVaginally();
				if (temp == 1) oozeRapesYouOrally();
				if (temp == 2) oozeButtRapesYou();
			}
			//Everybody else
			else {
				temp = rand(2);
				if (temp == 0) oozeRapesYouOrally();
				if (temp == 1) oozeButtRapesYou();
			}
			combat.cleanupAfterCombat();
			return;
		}
	}
}