package classes.Scenes.Places.TelAdre {
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Races;

//NECESSARY FLAGS:
//263 - Met nancy
//264 - Nancy relationship level
//265 - Talk Nancy
//266 - Times boned
public class AuntNancy extends TelAdreAbstractContent{
//[Introduction Blurb:
//(appears in the Wet Bitch between 6:00 and 14:00)]
public function auntNancy(display:Boolean = true):Boolean {
	if(model.time.hours >= 6 && model.time.hours <= 14) {
		if(display) {
			outputText("\n\nYou see a rather buxom woman with short, white hair in a neck- and sleeve-less black dress cleaning glasses with her bar towel.  She makes the task look simple, moreso because she has two pairs of arms, wrapped in what look like shiny black gloves.");
			//[If MetNancy = 0]
			if(flags[kFLAGS.NANCY_MET] == 0) outputText("  She");
			else outputText("  Aunt Nancy");
			outputText(" glances up at you and smiles as you enter");
			//[(if unmet)
			if(flags[kFLAGS.NANCY_MET] == 0) outputText(", and you see that she has additional red eyes spread across her forehead");
			outputText(".");
		}
		return true;
	}
	else return false;
}

public function interactWithAuntNancy():void {
	clearOutput();
	//[Interaction 2]
	//[If Time = 1400, Relationship with Aunt Nancy >= 30, and PillowTalk= 0]
	if(flags[kFLAGS.NANCY_RELATIONSHIP] >= 30 && model.time.hours == 14 && flags[kFLAGS.NANCY_TIMES_SEXED] == 0) {
		outputText("As you enter the bar, looking forward to spending some time with Aunt Nancy, you see that she is cleaning up and getting ready to leave.  She spots you with one of her eyes and smiles, waving you closer with a single hand as the other three set glasses under the bar.\n\n");

		outputText("\"<i>Afternoon, friend!</i>\" she says, cheerily.  \"<i>You've certainly been coming in a lot, and I can't say I don't appreciate your company.</i>\"  Aunt Nancy looks you over a little, smiling a little more wistfully and melancholically now.  \"<i>You remind me a little of my husband,</i>\" she admits, finishing up and skittering out from behind the bar on her many legs as the afternoon shift bartender takes her place.  \"<i>It's... nothing I can put my finger on.  Just, you have a certain... <b>quality</b> to you.</i>\"\n\n");

		outputText("Aunt Nancy sighs.  \"<i>Sorry. I don't mean to bore you with an old woman's rambling.  I... I just miss him, so much, and I get a little... lonely, sometimes.</i>\"  She looks at you, with a strange, half-hungry, half-desperate look in her eyes.  \"<i>Would you mind... coming home with me?  You seem a little tense, and I'd like to give you a massage.</i>\"\n\n");
		//[Gain 20 Lust.] (I remain steadfastly unaroused; maudlin self-pity isn't sexy.  -Z)
		dynStats("lus", 10, "scale", false);
		simpleChoices("Agree", timeForAuntNancySpiderCooch, "Decline", declineAuntNancyMassage, "", null, "", null, "", null);
	}
	//[If Time >= 1400 - (100*(Relationship with Aunt Nancy/30), Relationship with Aunt Nancy >= 30, and PillowTalk= 1]
	else if(flags[kFLAGS.NANCY_RELATIONSHIP] >= 30 && model.time.hours >= (14 - (flags[kFLAGS.NANCY_RELATIONSHIP]/30)) && flags[kFLAGS.NANCY_TIMES_SEXED] > 0) {
		outputText("Aunt Nancy looks up as you walk over to her, and her eyes light up.  Happily, she greets you with a prim little hand atop yours, a bit of evidence of the intimacy you've shared.\n\n");

		outputText("\"<i>Couldn't stay away, could you friend?</i>\" she asks, quietly, a sexy smile on her lovely face.  \"<i>What'll it be? Do you want a drink...</i>\"  The spider-lady leans her white-haired head next to your ear conspiratorially, and whispers, \"<i>Or, do you want me to get off early and give you a little... massage?</i>\"  You shiver at her words.\n\n");
		//[Choice: Strong, Light, Agree, Decline]
		simpleChoices("Strong", strongStuff, "Light", lightStuff, "Agree", timeForAuntNancySpiderCooch, "", null, "Back", declineAuntNancyMassage);
	}
	//[Interaction 1]
	//If Relationship with Nancy < 30
	else {
		outputText("You decide to talk with the bartender, and walk right up to the bar.  She sees you coming, and folds her towel up with her first pair of hands, while putting the glass she was polishing away with the other.\n\n");

		outputText("\"<i>Welcome to the Wet Bitch.  My name's Aunt Nancy, and I'll be your server this morning.</i>\"  She smiles.  \"<i>Well, what'll it be, friend?</i>\" the bartender asks, her voice rich and velvety rather than cute as she leans on the bar, giving you a good look at her cleavage.  \"<i>Bit early in the day for the strong stuff, I reckon.</i>\"\n\n");
		//[If MetNancy < 1, MetNancy += 1]
		if(flags[kFLAGS.NANCY_MET] < 1) flags[kFLAGS.NANCY_MET] = 1;
		//[Choice: Strong, Light]
		simpleChoices("Strong", strongStuff, "Light", lightStuff, "", null, "", null, "Leave", telAdre.barTelAdre);
	}
	if (flags[kFLAGS.LUNA_TRIED_WORKING_AS_BARMAID] == 1) addButton(8, "Luna", lunaStory);
}

//[Strong:]
private function strongStuff():void {
	clearOutput();
	//[Lose 5 Gems.]
	if(player.gems < 5) {
		outputText("You start to ask for a strong drink and then remember you can't afford it.");
		//Do next
		doNext(interactWithAuntNancy);
		return;
	}
	dynStats("tou", 1, "int", -1, "lus", 15);
	player.gems -= 5;
	statScreenRefresh();
	outputText("You ask for a strong drink anyway, and Aunt Nancy nods.  Easily, she picks up a glass with one hand, reaches out with another two, and fills it with something greenish.\n\n");

	outputText("The bartender sees your gaze and smiles.  \"<i>Heavy mead,</i>\" she explains, hefting it.  \"<i>We make it from honeybee honey.  Have a taste, friend.</i>\"\n\n");

	outputText("You pay a few gems and take a sip.  The alcohol burns a bit, but it tastes deliciously, achingly sweet, and before you know it the glass is empty.\n\n");

	//[(If Toughness is >= 30)]
	if(player.tou >= 30) {
		outputText("It was good, but it seems to have gone straight to your head with surprising speed, giving you a pleasant buzz after only one glass. It might be a prudent idea to walk it off before you get another.  You thank Aunt Nancy for the drink, before climbing to your [feet] and leaving.  She eyes you respectfully as you go.");
		//[+10 Relationship with Aunt Nancy]
		flags[kFLAGS.NANCY_RELATIONSHIP] += 10;
	}
	//[Else]
	else {
		outputText("Wow, that one took it out of you.  You're pretty sure you don't want to try to have another.  Feeling a little wobbly, you thank the bartender for the drink, and unsteadily stagger out of the shop.  As you leave, you hear Aunt Nancy giggling, and out of the corner of your eye, you see her bunched up, one hand over her mouth as she chuckles, amused at your inability to hold your liquor.");
		//[+5 Relationship with Aunt Nancy]
		flags[kFLAGS.NANCY_RELATIONSHIP] += 5;
	}
	doNext(camp.returnToCampUseOneHour);
}
//[Light:]
private function lightStuff():void {
	clearOutput();
	//[Lose 5 Gems.]
	if(player.gems < 5) {
		outputText("You start to ask for a light drink and then remember you can't afford it.");
		//Do next
		doNext(interactWithAuntNancy);
		return;
	}
	player.gems -= 5;
	dynStats("tou", .5, "int", -.5, "lus", 7);
	outputText("You don't feel like throwing back a really heavy drink this early, come to think, and instead ask for something light.  Aunt Nancy nods and pours you something thin and bright yellow from out of a barrel behind her, giving you a good look at her from behind.  Her lower half seems to stick out behind her in a long stretch of black chitin, with several long, thick legs supporting it.");
	//[If Intelligence >= 20]
	if(player.inte >= 20) outputText("  You realize that what look like almost-shoulder-length gloves over her hands must actually be shell-like portions of this exoskeleton.");
	outputText("\n\n");

	outputText("Once she gives you the drink, you take a tentative sip, and find it very sweet and refreshing, without seeming very strong or alcoholic.  It's very good, and you quickly have another.");

	//[If FirstTalkNancy = 0]
	if(flags[kFLAGS.NANCY_TALKS] == 0) {
		flags[kFLAGS.NANCY_TALKS]++;
		outputText("\"<i>So,</i>\" she says, settling one set of arms on the bar and supporting her head with the other, \"<i>what's your story, friend?  You have a certain...</i>\" Aunt Nancy waves with a hand. \"<i>look about you.  Like my late husband, Marae send him to his reward.  You're an... adventurer, I take it?  You live off the land, fighting monsters for gems, scavenging all your equipment off what you can find or put together yourself?</i>\"\n\n");

		outputText("You nod, hesitantly, remembering that here, at least, you're in no danger from demons.\n\n");

		outputText("\"<i>Wonderful!</i>\" she says enthusiastically, spreading her upper set of arms. \"<i>I reckon that means that you've got quite a few stories on you, friend. Feel like sharing?</i>\" The drink, despite its low alcohol content, has still left you feeling a little chatty, and you eagerly tell her about your adventures.\n\n");

		outputText("You tell her of some of your recent exploits in the demon realm.  Like most stories in this strange land, it ends up focusing on the strange, perverted sexuality of the monsters that dwell here, but she doesn't seem to mind.\n\n");

		outputText("The bartender listens, entranced, and reacts on all the right beats, her bosom bouncing on the particularly shocking ones.  When you're done, she smiles at you, and says, \"<i>Well, that was quite a tale.  Let me tell you one...</i>\"\n\n");

		outputText("Aunt Nancy pours herself a glass of the same drink you're having, and gulps down a long pull.\n\n");

		outputText("\"<i>Well,</i>\" she begins, \"<i>I wasn't always a bartender.  I grew up in a cave, after all.  My people used to get prey to wander into our webs so we could eat them, or you know,</i>\" the bartender smiles lustfully, \"<i>indulge ourselves, if they were cute.  That was how I met him.  He was one of the folk from another world, ");
		//[If PC is human:]
		if(player.isRace(Races.HUMAN, 1, false)) outputText("like you,");
		else outputText("like poor little Yara at the earring shop,");
		outputText(" and, well, one thing led to another, and I ended up chasing him out into the wider world.</i>\"\n\n");

		outputText("Aunt Nancy sighs, dreamily.  \"<i>Oh, the adventures we had together, friend!  We'd wrestle over ancient treasures, fight midst old ruins, argue over who actually finished off that omnibus, fuck like rabbits and then insist that the other one came first.</i>\"  She seems to be staring off into midair, a wistful smile on her face.  \"<i>Marae on earth, how I miss him.  It's been almost a decade now, since I last saw him.  Somedays, I still think he'll just... walk in here, with that cocky smile on his face and that shiny old magic sword over his shoulder and make a pun.</i>\"\n\n");

		outputText("She takes another drink, melancholically, before shaking her head to clear it.  \"<i>Well, thank you for sharing some time with an old widow like me.</i>\"  She flutters her still-beautiful eyelashes at you once or twice, then chuckles.  \"<i>Come back some time.</i>\"\n\n");

		//[50% chance to gain 1-2 Intelligence, +20 Relationship with Aunt Nancy, FirstTalkNancy += 1]
		if(rand(2) == 0) dynStats("int", 1+rand(2));
		flags[kFLAGS.NANCY_RELATIONSHIP] += 20;
	}
	//[Else:]
	else {
		outputText("As you sip your drink, you and Nancy swap adventuring stories for a while, enjoying one another's company in the fairly quiet bar.  The older spider-lady is a good conversationalist, and you feel a little closer for having shared some time with her.");
		//[50% chance to gain 1-2 Intelligence, +10 Relationship with Aunt Nancy]
		if(rand(2) == 0) dynStats("int", 1+rand(2));
		flags[kFLAGS.NANCY_RELATIONSHIP] += 20;
	}
	doNext(camp.returnToCampUseOneHour);
}

//[If Decline]
private function declineAuntNancyMassage():void {
	clearOutput();
	outputText("Aunt Nancy listens as you politely turn her down, and nods her head, the hungry look fading from her eyes.  \"<i>I understand completely.  Sorry to have bothered you.</i>\"  She starts to walk out of the bar, stops, and turns back to size you up again.  \"<i>Of course,</i>\" she says, \"<i>if you ever change your mind... just come by whenever my shift's over.</i>\"\n\n");

	outputText("Aunt Nancy raises one of her black-covered hands in front of her mouth, and blows you a kiss before scuttling away.");
	//[Gain 20 Lust.]
	doNext(camp.returnToCampUseOneHour);
}

//[If Agree]
private function timeForAuntNancySpiderCooch():void {
	clearOutput();
	outputText("You look the still-beautiful spider-lady in the eye, and, half-mesmerized, nod in agreement.  She smiles broadly (and, you can't help but notice, quite lewdly) and puts one of her lower arms through one of yours, while putting the upper one on your shoulder.  \"<i>Well then,</i>\" Aunt Nancy says, \"<i>I suppose we should be off.</i>\"\n\n");

	outputText("She leads you through the streets of Tel'Adre, weaving through crowds and back alleys, before you finally end up just outside a modest little adobe building tucked away in a side street.  Slowly, she wraps all four of her arms around you, giving you a gentle hug");
	if(player.biggestTitSize() >= 1) outputText(" and taking the opportunity to grope your [allbreasts] right through your " + player.armorName);
	outputText(".\n\n");

	outputText("\"<i>Come into my parlor,</i>\" she whispers into your ear, licking it gently before sticking the tip of her long tongue into the hole before pressing her soft lips against the lobe of it.\n\n");

	outputText("Then, she lets go of you and skitters easily up to her door, opening it and slipping inside.");
	//[Gain 30 Lust, New Page]
	player.lust += 29;
	dynStats("lus", 1, "scale", false);
	doNext(auntNancyPoonPartII);
}
private function auntNancyPoonPartII():void {
	clearOutput();
	outputText("Slowly, you follow Aunt Nancy into her home. Inside, the building is fairly dark and gloomy, even in the middle of the day, with thick curtains of unidentifiable white matter keeping most of the sun outside. Blinded, your vision still attuned to the bright desert, you can discern little of the house's insides before you hear a sudden skittering sound behind you and, as you turn to face it, are pushed further into the gloom. Your heel is caught by a thick strand of what feels like rope, and you fall flat onto your back, arms and legs splayed out to either side of you, as you land on some sort of taut net.\n\n");

	outputText("You try to climb back up, only to find that your flesh and [armor] alike are caught fast against the adhesive matter of the net, which, you suddenly realize, is actually a thick web, spread across the house's floor. You feel a surge of panic and begin to pull and struggle, when suddenly you feel a smooth, cool hand on your face. Your night vision is beginning to recover, and you make out Aunt Nancy's face, her pale skin seeming to glow in the gloom, as she leans over you, staring into your eyes with hers, one finger trailing across your face before covering your lips in a gesture for quiet.\n\n");

	outputText("With her other three hands, the spider-lady lights a match and ignites a little lantern, which she raises to hang from the wall.  In the little area it illuminates, you can see that Aunt Nancy has removed her neck-less black dress, letting her impressive bosom bounce modestly as she works, and catch a glimpse of her unusual genitals before she turns to face you again.\n\n");

	//[If PillowTalk = 0]
	if(flags[kFLAGS.NANCY_TIMES_SEXED] == 0) outputText("\"<i>It's... been a long, long time,</i>\" murmurs Aunt Nancy, her throaty voice washing over you, as two of her hands rest on your " + chestDesc() + " and the other two wrap carefully around your shoulders and neck, gently rubbing you in the promised massage.  She's crawling along the web, her many feet easily avoiding the sticky parts, and her face is mere inches from yours.  You can smell her sweet, slightly alcohol-scented breath as her many eyes look down at you.  \"<i>I haven't... been with anyone since I lost my husband, and... well... I... I need this.  Will you please be with me, if only for a little while?</i>\"\n\n");
	else outputText("\"<i>Are you ready for me, friend?</i>\" murmurs Aunt Nancy, her throaty voice washing over you, as two of her hands rest on your " + chestDesc() + " and the other two wrap carefully around your neck and shoulders, gently rubbing you in the promised massage. She's crawling along the web, her many feet easily avoiding the sticky parts, and her face is mere inches from yours. You can smell her sweet, slightly alcohol-scented breath as her many eyes look down at you.  \"<i>I certainly am, little fly.</i>\"\n\n");

	outputText("Quietly, mesmerized by her needy red eyes, you nod.  Aunt Nancy smiles demurely.  \"<i>Good,</i>\" she purrs, and lowers her lips to yours.  You weren't quite sure what to expect, but her lips are soft and gentle as she presses them on you.  Her tongue gently snakes into your mouth, wrapping around yours with ease, and her sweet-tasting saliva is soon sliding down your throat.  Instantly, you feel your body loosening up, and ");
	//[Intelligence > 40]
	if(player.inte > 40) outputText("realize that the spit must contain some kind of chemical originally meant to still prey");
	else outputText("question whether or not the spider-lady's kiss is responsible");
	outputText(".\n\n");

	outputText("As you unwind at her touch, her many arms are working to strip away your [armor], gently peeling them away with care until you are naked and needy in the spider-lady's web.\n\n");

	outputText("You are soon hanging in utter relaxation, idly wondering whether the ongoing massage Aunt Nancy's many hands are still performing all over your " + chestDesc() + ", [butt], back, and neck, or the loving, strange kiss of her lips and long, curling tongue is more responsible.  Ultimately, however, she pulls her white-haired head away from yours, and removes her many hands from your trunk.  Smiling at your sudden unhappy look, Aunt Nancy begins to kiss her way down your body, first along the curve of your neck, sliding her long, moist tongue against your chest as you shiver in pleasure at the sensation and pressing her soft lips against your " + nippleDescript(0) + "s and nibbling gently on them to enjoy your moans of delight, before moving her head down your belly");
	if(player.tailType > Tail.NONE) outputText(" to the top of your tail");
	outputText(".\n\n");

	//[If a naga]
	if(player.isNaga()) outputText("Gently, she peels away the fold of skin that disguises your genitals, now moist-and-dripping with anticipation.  ");
	outputText("Aunt Nancy licks her lips, a hungry look in her many eyes as she looks down at you, clearly quite pleased by what she sees.\n\n");

	//[If you have balls:]
	if(player.hasBalls()) {
		outputText("She smiles at the sight of your [balls], gently raising two of her hands to fondle and squeeze them as her soft lips press against them, ");
		//[If BallSize allows]
		if(player.ballSize < 15) {
			if(player.ballSize > 5 && player.ballSize < 15) outputText("taking one");
			else outputText("both of them");
			outputText(" into her mouth to soak in her saliva as she wraps and caresses ");
			if(player.ballSize <= 5) outputText("them");
			else outputText("it");
			outputText(" with her long, dextrous tongue.\n\n");
		}
		else outputText("kissing and licking at them with those moist, relaxing lips.\n\n");
	}

	//[If you have a vagina:]
	if(player.hasVagina()) {
		outputText("The spider lady ");
		if(player.hasBalls() && player.hasCock()) outputText("lifts away your other \"<i>equipment</i>\" and ");
		outputText("examines the folds of your " + vaginaDescript(0) + ".  You shiver at the sensation of one of her smooth, cold hands rubbing against your folds, the tips of her fingers sliding into you.  Aunt Nancy smiles up at you, enjoying your reaction.  \"<i>Did you like that?</i>\" she asks with her deliciously throaty voice, and you nod enthusiastically.  \"<i>Good...</i>\" she purrs, before slipping her long, slippery tongue inside of you.  You cry out in sudden surprise at the sudden feeling of it moving inside of you, exploring your shape, before she pulls it out as you squirm.  \"<i>Mmmmmm...</i>\" Aunt Nancy murmurs.  \"<i>You taste goood, friend.</i>\"\n\n");
	}
	//[If you have a penis:]
	if(player.hasCock()) {
		outputText("Aunt Nancy gently caresses your [cocks] with her smooth black hands, enjoying your moans of delight, before lowering her head to kiss the head of your [cock].  Her tongue snakes around it, and the spider-lady sucks a little, drinking up the little stream of pre-cum now leaking out, before raising her head up to look at you, a gentle smile on her face as her many hands continue to rub and explore your [cocks].  \"<i>Not as good as my husband's,</i>\" she whispers, \"<i>but quite a piece, certainly.</i>\"\n\n");
	}
	//[If you have no genitals at all:]
	if(player.gender == 0) outputText("\"<i>Well, well, well,</i>\" murmurs Aunt Nancy, intrigued by what she sees.  \"<i>Very unorthodox, but we'll see what we can do.</i>\"  She pauses to lick the fleshy expanse where your genitals used to be.\n\n");

	//[All:]
	outputText("Two of her hands suddenly wrap themselves around the cheeks of your [butt], and squeeze gently.  \"<i>Very nice,</i>\" the spider-lady whispers, and then her long tongue spools out to slide over the surface of your [butt].  The tip of it even slips inside, gently, and you feel her saliva coating the inside of your bum.  It feels sensitive, and much more relaxed now than a minute ago.\n\n");
	var x:int = -1;
	var y:int = -1;
	if (player.isGenderless()) glessF();
	else sceneHunter.selectGender(dickF, vagF);

	function dickF():void {
		var titFucked:Boolean = false;
		if (player.cockTotal() >= 2) {
			x = player.findCock(2, -1, -1, "length");
			y = player.longestCock();
		} else {
			sceneHunter.print("Check failed: multicock!");
			x = 0; //y still -1
		}

		outputText("Aunt Nancy rises up above you, still smiling with gentle sensuality, and reaches out.  ");
		outputText("Gently, she picks " + oMultiCockDesc() + ", and brings it up to her pussy. You see its entrance, two parted shell-plates dripping wet fluid, and would almost panic at the unfamiliar sight if you weren't so very relaxed.  With loving guidance, Aunt Nancy slides the full length of your " + cockDescript(x) + " deep inside of her.  Both of you moan in delight as your dick rubs and stimulates her in a way she's clearly been missing for a long, long while; her exotic insides, smooth and silky and deep, squeeze and caress your " + cockDescript(x) + " like a velvet glove.  Little feelers inside of her begin to massage your cock, and the wet, dripping fluids inside of her are just as relaxing as her saliva.\n\n");

		outputText("\"<i>Oooooh,</i>\" she sighs dreamily, her eyes temporarily distant and unfocused.  \"<i>Marae on earth, that hits the spot.</i>\"\n\n");
		//[If your longest dick is of at least auto-titfucking size:]
		if(player.cockTotal() >= 2) {
			if(player.cocks[y].cockLength >= 22) {
				titFucked = true;
				outputText("As Aunt Nancy rides you enthusiastically, the spider-lady lifts ");
				if(player.cockTotal() > 2) outputText("another one of ");
				outputText("your ");
				if(player.cockTotal() == 2) outputText("other cock ");
				else outputText("cocks ");
				outputText("up to her heaving bosom, and slips it between her soft, lovely breasts.  \"<i>Want something else nice?</i>\" asks the spider-lady, eyes twinkling.\n\n");

				outputText("Still rising and falling atop your body as she rides you, Aunt Nancy grips her breasts with two of her black-shelled hands and begins to slide them up and down on either side of your tall, dripping " + cockDescript(y) + ", ");
				if(player.cocks[y].cockLength >= 30) outputText("letting its head slip into her mouth, where she sucks and licks at it hungrily, ");
				else outputText("letting her long, dexterous tongue dangle down from her mouth to wrap around the head of her dick, occasionally licking at her own impressive bosom as well, ");
				outputText("all the while staring down into your eyes.\n\n");

				outputText("The sensation, both of her soft, pillowy bosom wrapped around your " + cockDescript(y) + " and of her skillful tongue");
				//[If CockDescript (Longest Cock) is long enough for auto-fellatio]
				if(player.cocks[y].cockLength >= 30) outputText(" and mouth");
				outputText(", is incredible.  Aunt Nancy coos happily, clearly enjoying the taste.\n\n");
			}
			//[If there are still dicks left over:]
			if(player.cockTotal() > 2) {
				 if(player.cockTotal() == 3) outputText("Another of her hands wraps itself around your other cock");
				 else outputText("Her other hands wrap themselves around more of your cocks");
				 outputText(", milking and stroking the ");
				 outputText("pulsating prick");
				 if(player.cockTotal() > 3) outputText("s");
				 outputText(" for all ");
				 if(player.cockTotal() == 3) outputText("it's");
				 else outputText("they're");
				 outputText(" worth.\n\n");
			}
		}

		//[If PC is lactating, and there are no dicks of autotitfucking size available:]
		if(!titFucked && player.biggestLactation() >= 1) {
			outputText("As milk leaks slowly from your " + nippleDescript(0) + "s, the spider-lady notices.  She lowers her head and wraps her soft, lovely lips around the tip of one of your [allbreasts], sucking gently and frantically flicking her tongue against your " + nippleDescript(0) + ".  You moan and lie back into the web, the multitude of sexual pleasures assaulting your senses almost more than you can bear as Aunt Nancy begins swallowing up your milk.\n\n");
		}
		//[If no cocks are of titfucking size and # Cocks <= 4 or if there are cocks of titfucking size and # Cocks <= 3 (If Nancy still has free hands)]
		if(!titFucked || (titFucked && player.cockTotal() <= 2)) {
			outputText("Her remaining hands gently work their way across your body, alternating between rubbing and squeezing your [butt], even sometimes slipping fingers inside to probe the insides, ");
			//[If the player has balls]
			if(player.hasBalls()) outputText("gently kneading and caressing your [balls] as the cum inside churns and boils and ");
			//[If the player has a vagina]
			else if(player.hasVagina()) outputText("exploring the folds and creases of your " + vaginaDescript(0) + " and ");
			outputText("massaging your " + chestDesc() + ".  Occasionally, they stroke through your " + hairDescript() + ".\n\n");
		}
		menu();
		addButton(0, "Next", auntNancyPoonPartIII, x, y);
	}
	//[If player has vagina but no dicks: (Nancy prefers dicks and will always choose them over lesbian sex)]
	function vagF():void {
		outputText("Gently, Aunt Nancy leans down to stroke your face as two of her other hands reach out and begin caressing your chest, while a fourth explores the outer folds of your " + vaginaDescript(0) + ".  \"<i>Such a pretty little fly,</i>\" the spider-lady whispers as she stares at your face, her bright red eyes full of longing.   She presses her face against the side of your head, and you gently turn it to allow her access to your ear, which she quickly slips her tongue into again, enjoying the feeling as you quiver and yelp beneath her.\n\n");

		outputText("With your face turned, you suddenly spot a once-well-made dildo lying on the floor beneath the web.  You see that it has been worn down as smooth as an apple rind and probably much thinner than it was before, and you suddenly wonder just how pent-up the widow's sexual desires really are.\n\n");

		outputText("Such thoughts are interrupted when you suddenly feel Aunt Nancy's fingers on the lower half of your body again, caressing your ");
		if(player.tailType > Tail.NONE) outputText("tail before rising to your ");
		outputText(vaginaDescript(0) + " and [butt].  Aunt Nancy turns your head to face hers, and rises up onto her legs again as her fingers begin to sink deep into your " + vaginaDescript(0) + " and your " + assholeDescript() + ".  You moan, loudly and long at the sensation, and Aunt Nancy smiles lewdly, her other hands still exploring and squeezing your " + chestDesc() + ", rubbing and kneading them softly and occasionally pinching and pulling at your " + nippleDescript(0) + "s.\n\n");

		outputText("Suddenly, you realize that your left hand is now free, courtesy of one of Aunt Nancy's smooth, gentle arms.  She whispers, quietly, \"<i>A little for me too, please.</i>\"  Realizing exactly what she means, you press the " + player.skinFurScales() + " of your hand against her pussy.  Its entrance, two parted shell-plates dripping wet fluid, would almost be scary if you weren't so very relaxed.  Gently, your press your fingers into her body, and hear her moan, loudly, feel her own hands scrabbling inside of your " + vaginaDescript(0) + " and " + assholeDescript() + ", pawing your chest and [butt], trailing through your " + hairDescript() + ".\n\n");

		outputText("It feels wonderful.  You lie back and moan, enjoying the smooth, silky insides of her pussy, feeling tiny feelers occasionally caress and pull at your fingers inside of her.\n\n");
		//[If PC is lactating:]
		if(player.biggestLactation() >= 1) outputText("As milk leaks slowly from your " + nippleDescript(0) + "s, the spider-lady notices. She lowers her head and wraps her soft, lovely lips around the tip of one of your [allbreasts], sucking gently and frantically flicking her tongue against your " + nippleDescript(0) + ".  You moan and lie back into the web, the multitude of sexual pleasures assaulting your senses almost more than you can bear as Aunt Nancy begins swallowing up your milk.\n\n");
		doNext(auntNancyPoonPartIII);
	}
	//[If the PC has no genitals at all:]
	function glessF():void {
		outputText("Gently, Aunt Nancy leans down to stroke your face as two of her other hands reach out and begin stroking your " + chestDesc() + " while a fourth explores the smooth, fleshless expanse where your genitals once were.  \"<i>Such a pretty little fly,</i>\" the spider-lady whispers as she stares at your face, her bright red eyes full of longing.  She presses her face against the side of your head, and you gently turn it to allow her access to your ear, which she quickly slips her tongue into again, enjoying the feeling as you quiver and yelp beneath her.\n\n");

		outputText("With your face turned, you suddenly spot a once-well-made dildo lying on the floor beneath the web.  You see that it has been worn down as smooth as an apple rind and probably much thinner than it was before, and you suddenly wonder just how pent-up the widow's sexual desires really are.\n\n");

		outputText("Such thoughts are interrupted when you suddenly feel Aunt Nancy's fingers on the lower half of your body, caressing your [butt] before rising again to your lack of genitals.\n\n");

		outputText("Smiling at the puzzle before her, Aunt Nancy gently runs her hands over your " + nippleDescript(0) + "s and " + hairDescript() + " as she thinks over how best to make love to you.  Gently, her white-haired head returns to your [butt], and her long tongue snakes out again, sliding between its lobes.  As you relax, it slips inside of you, just far enough for you to moan at the nigh-sexual pleasure of total relaxation.  The spider-lady removes her tongue from your anus, much to your dissatisfaction, and carefully wipes it off on a nearby bit of cloth before returning it to her mouth, then, smiling up at your petulant expression, slips a few of her fingers into your now-loose and sensitive " + assholeDescript() + ".\n\n");

		outputText("Aunt Nancy climbs back atop you as you moan at the welcome new sensation, licking at your chest as she does.  \"<i>Bet you didn't think I could do it,</i>\" she purrs to you, as you enjoy the many, many sensations working at you.\n\n");

		outputText("Suddenly, you realize that your left hand is now free, courtesy of one of Aunt Nancy's smooth, gentle arm.  She whispers, quietly, \"<i>A little for me too, please.</i>\"  Realizing exactly what she means, you press the " + player.skinFurScales() + " of your hand against her pussy.  Its entrance, two parted shell-plates dripping wet fluid, would almost be scary if you weren't so very relaxed.  Gently, your press your ingers into her body, and hear her moan, loudly, feel her own hands scrabbling inside of your " + assholeDescript() + ", pawing your chest and [butt], trailing through your " + hairDescript() + ".\n\n");

		outputText("It feels wonderful.  You lie back and moan, enjoying the smooth, silky insides of her pussy, feeling tiny feelers occasionally caress and pull at your fingers inside of her.\n\n");

		//[If PC is lactating:]
		if(player.biggestLactation() >= 1) outputText("As milk leaks slowly from your " + nippleDescript(0) + "s, the spider-lady notices. She lowers her head and wraps her soft, lovely lips around the tip of one of your [allbreasts], sucking gently and frantically flicking her tongue against your " + nippleDescript(0) + ".  You moan and lie back into the web, the multitude of sexual pleasures assaulting your senses almost more than you can bear as Aunt Nancy begins swallowing up your milk.\n\n");
		doNext(auntNancyPoonPartIII);
	}
}

private function auntNancyPoonPartIII(x:int = -1, y:int = -1):void {
	var titfuck:Boolean = y >= 0 && player.cocks[y].cockLength >= 22;
	var freeDicks:int = player.cockTotal() - (titfuck ? 2 : 1);
	if (y >= 0 && !titfuck) sceneHunter.print("Check failed - second cock not long enough!");
	clearOutput();
	//[If PC has a cock]
	if(x >= 0) {
		outputText("You can feel it when the spider-lady's pussy begins to quiver in delight. Aunt Nancy soon moans, then cries out in incredible pleasure.  The lower half of her eyes all close, while the others all roll up into her head in ecstasy.  \"<i>Yes!  YEEEEESSSSSSS!</i>\" she hisses with throaty, feminine indulgence.  The tiny feelers in her otherwise silky-smooth vagina suddenly begin to squeeze and pull at your " + cockDescript(x) + ", and you let out a bellow of pleasure of your own as you feel your ");
		//[If PC has balls]
		if(player.hasBalls()) outputText(ballsDescriptLight() + " tense, churning and tightening.");
		//Else:]
		else outputText("body tensing in preparation for letting out your seed.");
		outputText("\n\n");

		outputText("You cum, and cum hard.  Thick wet jets of sticky semen pour into Aunt Nancy's seemingly-bottomless pussy, whose feelers and soft, smooth interior continue to rub at and stroke your " + cockDescript(x) + " even as it vents the immense pressure in your [balls]. If anything, the constant powerful surges seem to be extending and intensifying the spider-lady's orgasm.");
		//[If PC has cum multiplier of at least 2]
		if(player.cumQ() >= 750) outputText("  Sooner or later though, even her marvelous body can simply contain no more of your jizz, and she slips her swollen cunt up off of your organ, letting it continue squirting your thick, plentiful cum all over her as it swings free.");
		outputText("\n\n");

		if(titfuck) {
			outputText("Aunt Nancy unwraps her tongue from your " + cockDescript(y) + " to cry out in delight, even as her hands let go of her lovely breasts to grab at your trunk.  Nonetheless, her big, pillowy boobs are more than firm enough to keep the shaft of your " + cockDescript(y) + " snugly inside as she bucks and shrieks atop you, and they more than contribute to your own sexual pleasure.\n\n");

			outputText("It too spasms, spitting gooey ropes of cum all over both of you");
			//[If PC has cum multiplier of at least 2]
			if(player.cumQ() >= 750) outputText(", some even reaching to the ceiling to fall into her short, pretty white hair and splattering over her trailing abdomen");
			outputText(".\n\n");
		}
		if (freeDicks == 1) outputText("Your other dick fires off too, her smooth, shell-covered hands still wrapped around it, and it makes even more of a mess, splattering over both of you.\n\n");
		else if (freeDicks > 1) outputText("The rest of your [cocks] fire off too, her smooth, shell-covered hands still wrapped around them, and they make even more of a mess, splattering over both of you.\n\n");
		//[If you also have a vagina:]
		if(player.hasVagina()) {
			outputText("Your " + vaginaDescript(0) + " clenches, tightly, ");
			if(player.balls == 0 && (!titfuck || player.cockTotal() <= 2))
				outputText("squeezing the fingers on Aunt Nancy's hand still tickling your insides");
			else outputText("making you long for something inside of it");
			outputText(", as " + sMultiCockDesc() + " spasms in ecstacy.\n\n");
		}
		//[All w/ penis:]
		outputText("Eventually, both your orgasms end.  You feel worn out, like you just ran a long mile, even though Aunt Nancy was doing most of the work.  However, she seems fine, smiling down at you with a big, happy grin.");
		//[If the PC has multiple dicks or a cum multiplier of at least 2]
		if(player.cockTotal() >= 2 && player.cumQ() >= 700) outputText("  Her lower body's a mess of smeary dollops of cum, right up to the bottom halves of her impressive boobs, and her face and upper body haven't fared much better. Behind her, you can see where stray shots that sprayed over her have painted streaks of her abdomen white.");
		outputText("\n\n");

		//[If the PC has multiple dicks or a cum multiplier of at least 2]
		if(player.cockTotal() >= 2 && player.cumQ() >= 700)
			outputText("Aunt Nancy runs one hand up her milky-pale body, digging a wide furrow in the thick layer of gooey cum as it moves up her belly and up the curve of her breast, before she peels it away and lifts it in front of her mouth.");
		else
			outputText("Aunt Nancy puts one hand beneath her dripping pussy and squeezes some powerful internal muscle.  A thick dollop of gooey cum falls onto it from inside of her, and she lifts it in front of her mouth.");
		outputText("  Snaking her long tongue around her fluid-smeared hand, the spider-lady licks up a thick load of the contents of your ");
		if(player.hasBalls()) outputText(ballsDescriptLight());
		else outputText("body");
		outputText(", and throws back her head to let it slide into her mouth.\n\n");

		outputText("\"<i>Mmmmm...</i>\" she purrs.  Aunt Nancy notices the look on your face and smiles sexily.  \"<i>What? A lady needs her protein, friend.  Do you think I can spin my webs out of nothing?</i>\"\n\n");
		player.sexReward("vaginalFluids", "Dick");
	}
	//[Else:]
	else {
		outputText("You can feel it when the spider-lady's pussy begins to quiver in delight.  Aunt Nancy soon moans, then cries out in incredible pleasure.  The lower half of her eyes all close, while the others all roll up into her head in ecstasy.  \"<i>Yes!  YEEEEESSSSSSS!</i>\" she hisses with throaty, feminine indulgence.  The tiny feelers in her otherwise silky-smooth vagina suddenly begin to squeeze and pull at your fingers, and her own fingers are soon touching sensitive places of their own inside of your ");
		//[If PC has a vagina:]
		if(player.hasVagina()) outputText(vaginaDescript(0) + " and ");
		outputText(assholeDescript() + ".\n\n");

		outputText("You howl in pleasure, feeling the orgasm coursing through you like hot metal up and down your spine.  You let out an exclamation of pleasure of your own, as you feel her hands tighten on your " + chestDesc() + ", and soon you too are luxuriating in the feeling of her body against yours, inside of you, pressing all your most vulnerable places.");
		//[If PC has a vagina and is a squirter and/or is lactating:]
		if(player.wetness() >= 5 || player.biggestLactation() >= 1)
			outputText("  Her hands are soon drenched in your body's wonderful secretions, just as your");
		else outputText("  Your");
		outputText(" fingers are soon soaked in the lovely, sweet-smelling juices of her pussy.\n\n");

		outputText("Eventually, the sensation subsides, and she gently slides her fingers from your ");
		//[If PC has a vagina:]
		if(player.hasVagina()) outputText(vaginaDescript(0) + " and ");
		outputText(assholeDescript() + ".  You feel worn out, like you just ran a long mile, even though Aunt Nancy was doing most of the work, and you let your arm fall back down against the sticky surface of her web.  However, she seems fine, smiling down at you with a big, happy grin.");
		//[If PC has a vagina:]
		if(player.hasVagina()) outputText("  Lifting the smooth, soaked hand that has only just been soaked in the juices of your " + vaginaDescript(0) + " in front of her mouth, Aunt Nancy smiles at you.  Snaking her long tongue around her fluid-smeared hand, the spider-lady licks up the fluid with every sign of enjoyment.  \"<i>Mmmmm...</i>\" she purrs.  \"<i>You DO taste good.</i>\"\n\n");
	}
	//[All]
	outputText("Aunt Nancy leans down and presses her soft lips against yours again, wrapping your web-bound body up in a hug with all four of her arms, and again you feel much more relaxed and (now that you think of it) aroused than you had a minute ago.  However, this particular sex session has taken an awful lot out of you, and you look longingly at the door over her shoulder as the kiss ends.  Unfortunately, the spider-lady sees you doing so and smiles wickedly.\n\n");

	outputText("\"<i>Not a chance on Marae's green earth, friend,</i>\" she purrs, her voice like hoarse velvet as she rubs the surface of her still-needy pussy against your belly.  \"<i>I haven't had a lover in my bed in more than ten years, and you're not going anywhere until I say you can.</i>\"  That last part was punctuated with a wicked squeeze of your [butt], and Aunt Nancy presses her lips to yours again, much less gently and more passionately this time.  You moan into her mouth, feeling her aphrodisiacal bodily fluids seeping in, and, as she soon frees your upper body and presses your head into her soft, silky pussy, you know she's right.\n\n");

	outputText("\"<i>And I'll be damned if I do all the work this time,</i>\" Aunt Nancy adds, before letting out a satisfied groan at the touch of your lips.");

	player.sexReward("vaginalFluids", "Lips");
	//[Next Page, Time += 200]
	doNext(auntNancyPoonPartIV);
}
private function auntNancyPoonPartIV():void {
	clearOutput();
	outputText("<b>Two passionate, sticky hours pass...</b>\n\n");

	//[70 % for Toughness, Strength to increase 2-6 points]
	dynStats("str", .3,"tou", .3);
	//[+35 Fatigue]
	fatigue(35);
	//[+20 Relationship with Aunt Nancy, PillowTalk += 1]
	flags[kFLAGS.NANCY_RELATIONSHIP] += 20;

	//[Next Page, If PillowTalk = 0]
	if(flags[kFLAGS.NANCY_TIMES_SEXED] == 0) {
		outputText("You awaken on Aunt Nancy's \"<i>bed,</i>\" an unbelievably comfortable pile of discarded, non-sticky webbing, your head still resting on her comfortable, pillowy bosom.  Slowly, you manage to sit up, tenderly massaging your aching body, especially your ");
		if(player.gender > 0) outputText("genitals");
		else outputText("jaw");
		outputText(".  The last hour or so is just a blur to you at the moment, a haze of sex and passion and stickiness.  You can still taste Aunt Nancy's scent in your mouth and smell it in the air.  The widow had been insatiable, always coming back for more no matter how often you got her off... and skilled enough to make sure you could too.  Privately, you wonder exactly what killed her husband.\n\n");

		outputText("Suddenly, you start at the feeling of Aunt Nancy's soft breasts squishing into your back, and her four arms sleepily embracing you, wrapping around the front of your chest.  You aren't sure whether to shiver in anticipation or tremble in fear, but you feel her lips gently kissing your ear, and hear the spider-lady's deliciously throaty, sexy voice whispering,  \"<i>Don't worry, friend.  You've satisfied me... for now.</i>\"  Gently, you feel her body rocking against your back, humming happily.\n\n");

		outputText("\"<i>Thank you,</i>\" she murmurs into your ear.  \"<i>I... I needed that. I appreciate you being willing to meet this dirty old widow woman's needs.  It was... kind.</i>\"  She pauses, then sighs.  \"<i>I won't ask you to stay any longer.  You have... a great and terrible destiny ahead of you.  No need to try to hide it.  Ol' Aunt Nancy can see these things.  Like my husband did...</i>\"\n\n");

		outputText("You can feel Aunt Nancy's hot tears on your back, and you place a comforting hand onto one of hers.  You can all but feel her smile through her tears, and she presses another kiss into your ear.  \"<i>I know, I know,</i>\" the widow whispers. \"<i>I won't try to stop you.  Just... come back some time, if you please? Every now and again?  I'd... appreciate that.</i>\"\n\n");

		outputText("The spider-lady pulls her head back, releasing your body with her four arms, and says, rather loudly, \"<i>Now, friend, get on out of here!  Go out there and get to the adventuring and world-saving!</i>\"  Suddenly, mischeviously, she pinches you rather hard on the [butt].  You jump, yelping in pain, and turn indignantly to face her as she doubles over, chuckling, tears still streaming down her face.  \"<i>Let these old exoskeletal chitins rest awhile, friend,</i>\" Aunt Nancy laughs, lying back onto the soft mound of webbing.  She smiles lazily up at you.  \"<i>There's water next to the foyer if you want to clean off, and your [armor] in the parlor.  And... please do keep in touch.</i>\"\n\n");

		outputText("Tentatively, you smile back, before getting cleaned up, getting dressed, and walking out into the suddenly-blinding sun of Tel'Adre.\n\n");
	}
	//[Else]
	else {
		outputText("Worn out and sticky, you awaken in the spider-lady's arms in her bed.  You share a kiss and tender moment with the widow, before leaving Aunt Nancy to rest as you go to get cleaned up and leave, tired and worn out but also feeling stronger from your exercise.  As you leave, she tells you to come by when next you can...");
	}
	//Increment times boned!
	flags[kFLAGS.NANCY_TIMES_SEXED] += 1;
	doNext(camp.returnToCampUseTwoHours);
}
private function lunaStory():void {
	clearOutput();
	outputText("You ask Aunt Nancy if she got approached by a young human dressed like a maid looking for work.\n\n");
	outputText("\"<i>Oh...</i>\" She gives you a surprised look. \"<i>Wait a minute, you know her... ohhhh, oh no!</i>\" She puts two of her black-laquered hands over her mouth in a clear gesture of dismay. \"<i>Don't tell me that you're the one who recommended she try here?</i>\"\n\n");
	outputText("With a growing feeling of dread you admit your involvement, and ask Aunt Nancy what happened.\n\n");
	outputText("Noticing your dismay, she waves her other two arms in front of her as if to ward off your worries. \"<i>Ah, I'm sorry dear, I didn't mean to sound quite so... accusatory.</i>\" She sighs, and continues. \"<i>Well, I am a bit short on help right now, and she seemed like a nice enough girl, so I hired her on for a trial period. As you guessed, it didn't work out, but it wasn't because she couldn't do the work. On the contrary, I've never seen someone so naturally suited to customer service!</i>\" Aunt Nancy gazes past you a bit as she recollects.\n\n");
	outputText("\"<i>She was energetic, worked hard, and had a wonderful way with the customers, especially the men. Maybe a bit... too good, actually,</i>\" she continues. \"<i>The trouble came when one of our customers, a regular who gets a bit... feely, when he drinks, mistook her friendliness for a come-on. He grabbed her ass as she turned to walk away, and it was like a switch had flipped.</i>\" She dropped the tray she was carrying clear on the floor, turned around, and told him in the flattest tone I've ever heard \"<i>Did you just touch me, you piece of garbage? Only my master may touch me. I'll have to take that hand of yours to teach you better manners.</i>\" Then she pulled a knife from somewhere, and if Edryn hadn't been here to stop her, I don't care to think what might have happened.");
	outputText("You reply with a quiet 'oh' as Aunt Nancy finishes her story. Seeing your look of dismay, she continues. \"<i>After Edryn wrestled the knife from her hands, she seemed to recover herself and then ran from the bar, crying. Didn't see her again after that. I can't say I'd have wanted her to try staying, but I do feel bad for the poor girl; she may have overreacted, but the customer was out of line too. I hope she finds something to do that she can handle.</i>\" She sighs sadly.");
	if (flags[kFLAGS.LUNA_FOLLOWER] == 0 || flags[kFLAGS.LUNA_FOLLOWER] == 1) outputText("Mentally you make a note not to get handsy with the strange maid");
	if (flags[kFLAGS.LUNA_FOLLOWER] == 0) outputText(".");
	if (flags[kFLAGS.LUNA_FOLLOWER] == 1) outputText(", especially with her staying at your camp now. Still, she's shown no sign of aggression so far...");
	if (flags[kFLAGS.LUNA_FOLLOWER] == 2 || flags[kFLAGS.LUNA_FOLLOWER] == 3) outputText("You find yourself speechless, and decide it will be best if Aunt Nancy doesn't know.");
	if (flags[kFLAGS.LUNA_FOLLOWER] >= 4 && flags[kFLAGS.LUNA_FOLLOWER] <= 6) outputText("You tell Aunt Nancy that she's actually been working for you at your camp, and that she's been a marvelous help with no sign of any such episode.\n\nShe looks surprised, and says \"<i>Well, I'm glad to hear she's doing well. I wouldn't try anything saucy though, if I were you; not unless you get a pretty clear invitation.</i>\" She laughs wryly, and you agree.");
	if (flags[kFLAGS.LUNA_FOLLOWER] > 6) outputText("Knowing what you know about Luna now, it's hardly a surprise something like this happened. You feel badly about sending her here in retrospect, though there's no way you could've known.");
	outputText("\n\nAunt Nancy sees you looking down and chides you. \"<i>Now now, don't you go blaming yourself, dear. I'm sure you were just trying to help the pooor girl, and I'm still the one who gave her a chance in the end. Sometimes you don't know who someone really is until they show you, and that's just how life is.</i>\"\n\n");
	outputText("You reflect on the truth in the barkeep's wise words, and move to another subject.");
	flags[kFLAGS.LUNA_TRIED_WORKING_AS_BARMAID] = 2;
	doNext( interactWithAuntNancy );
}
}
}
