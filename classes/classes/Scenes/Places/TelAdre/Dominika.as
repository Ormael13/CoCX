package classes.Scenes.Places.TelAdre {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class Dominika extends TelAdreAbstractContent {
public function Dominika(){

}
//const DOMINIKA_TIMES_MULTICOCK_SLOBBERED:int = 386;
//const DOMINIKA_TIMES_HYPNO_BJ:int = 387;
//const DOMINIKA_LAST_HYPNO_SUCK_COUNT:int = 388;
//const DOMINIKAS_SWORD_GIVEN:int = 416;

public function fellatrixBarAppearance():void {
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150] == 0) outputText("\n\nYou spot a face you haven't seen before – or rather, eyes you haven't seen before. A woman sits at a table in the back, most of her features hidden beneath a white cloth wrapped around her head to form a turban and veil. The rest of her dress seems equally modest but loose, efficient for desert travel. She idly runs her finger and its accompanying black-painted fingernail over the top of an empty cup, staring off into the distance and thinking about some unknown detail. What skin you can see is pale but perhaps most notably for Tel'Adre, human. Blue eyes glance over and meet your own, and you are reminded of your village back home. Her reaction to your look is unreadable thanks to her veil, but she watches you for a few moments longer before turning away again.", false);
	else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00151] != -1) outputText("\n\nYou notice Dominika speaking to a city guard at one of the tables. You can't hear the conversation, but the guard leaves shortly after you arrive, and Dominika rests her chin on her hand, staring into the distance.", false);
}
public function fellatrixSucked():Boolean {
	return timesFellatrixSucked() > 0;
}
private function timesFellatrixSucked():Number {
	return (flags[kFLAGS.DOMINIKA_TIMES_HYPNO_BJ] + flags[kFLAGS.DOMINIKA_TIMES_MULTICOCK_SLOBBERED] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00156] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00151] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00152] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00153] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00174]);
}
public function fellatrixBarApproach():void {
	spriteSelect(10);
	clearOutput();
	outputText(images.showImage("dominika-first-meeting-at-bar"));
	//Get the emporerors new groove (sword)
	//Req's d2 finished
	if (fellatrixSucked() && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150] > 0 && player.hasKeyItem("Zetaz's Map") >= 0 && flags[kFLAGS.DOMINIKAS_SWORD_GIVEN] == 0) {
		dominikaSpellblade();
		return;
	}
	//[First encounter, player is minotaur (If you lose minotaur characteristics and come back, Dominika will not recognize you and do a regular first encounter)]
	if (player.minoScore() >= 3 && player.faceType == FACE_COW_MINOTAUR && player.gender == 1) {
		outputText("You approach the woman, delivering what you consider a polite greeting. Icily she turns to you, raises an eyebrow, and in a low husky voice snarls \"<i>Don't bother. I'm not interested in being your bimbo.</i>\" She turns away from you, and ignores any further attempts to start a conversation.\n\n", false);

		outputText("A tavern maid with shaggy dreadlocks and a long tongue she can barely fit in her mouth waves you over. \"<i>Don't wowwy 'bout Dominika,</i>\" she says through her lisp, \"<i>The's a liddle wacist against, you know, your type. Thays you're only interethted in wape. Motht of uth aren't like dat.</i>\"\n\n", false);

		outputText("You nod slightly, glancing back at Dominika, then shrug.", false);
		//TO THE BAR
		cheatTime(1);
		doNext(telAdre.barTelAdre);
		return;
	}
	//[First encounter]
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150] == 0) {
		outputText("You approach the woman, delivering a polite greeting. She glances back at you and you think she might be smirking beneath the veil, but can't tell. \"<i>Hello to you as well,</i>\" she replies, with a low and husky voice, gesturing to a seat across from her. \"<i>You're a new face, no?</i>\"\n\n", false);

		outputText("You accept the seat and begin to make small talk with her. \"<i>I'm Dominika,</i>\" she adds after a chuckle at a joke. \"<i>Just Dominika now, I'm afraid.</i>\" You introduce yourself as well. \"<i>If I'm not mistaken, you'd be from... Ingnam, yes?</i>\" You nod, and ask if she's familiar with your homeland. \"<i>I'm afraid not,</i>\" she replies, \"<i>But I do my best to learn about the world. Ingnam has sent a champion every year for about... oh goodness, longer than I know. I've spoken with another during my time here, and you've both got a very distinctive accent.</i>\"  She can't help but chuckle again when she sees your reaction. \"<i>Oh, don't worry, it's not that thick.</i>\"\n\n", false);

		outputText("Blushing slightly, you ask her about her own home. She leans back in her chair and gazes off for a moment before responding. \"<i>I come from... far away. Farther than most the people here know. Far enough that it's unlikely I'll be returning.</i>\" You hear a familiar longing in her voice, one that you have known on some dark nights, and feel a certain solidarity with her. She looks back at you and shrugs. You suspect that beneath the cloth she is giving you a half-smile. \"<i>Perhaps, if circumstances work in my favor, one day... I make the best of my situation here.</i>\"\n\n", false);

		outputText("The two of you chat for a while longer, making small talk about the things you've seen in the Demon Realm. Eventually you can't help but observe that she doesn't seem to be sporting massive breasts, or thirty cocks, or be mad with lust, and you ask why. She looks you up and down once and laughs. \"<i>You don't have to put everything you find in your mouth, you know,</i>\" she finally answers.\n\n", false);

		outputText("After a bit more conversation she glances outside and says she should go. \"<i>It has been nice, though,</i>\" she adds, \"<i>I would enjoy speaking with you again.</i>\" She rests a hand on your shoulder as she leaves. Her eyes tell you she's smiling at you before she goes.", false);
		doNext(camp.returnToCampUseOneHour);
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150]++;
		return;
	}
	//[Second encounter, player has naga tail/centaur body/slime body]
	else if (!player.isBiped()) {
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150] == 1) {
			outputText("You make your way over to Dominika's table again, saying hello once more. The two of you talk about your exploits for a time, before you ask her what she has been up to. \"<i>Research, mostly,</i>\" she explains. \"<i>I try to document what this land has, in the hopes that it may be useful to someone one day. I do consider myself somewhat of a learned woman which... seems to be something of a rarity here, so there are few qualified to do the job.</i>\"\n\n", false);

			outputText("Intrigued, you ask her to elaborate on what she's learned. \"<i>Well, goodness, that could take a while,</i>\" she laughs. \"<i>Mm. Free tip though. Stay away from minotaur cum. That stuff will get you. There's a merchant out there who has some of my work, if you can find him. Other than that I mean, teaching requires a more intimate setting than 'the Wet Bitch'.</i>\" She rolls her eyes slightly at the name. \"<i>I'd be surprised if there's a single college on this entire continent though. Ah well.</i>\"\n\n", false);

			outputText("\"<i>Although...</i>\" she seems to think about something, glancing over at you for a few seconds, then waves her hand dismissively. \"<i>No, no. That wouldn't work. Don't worry about it.</i>\" She seems to sigh slightly, and though you continue talking, you can tell she's become less invested in the conversation. After a few minutes you excuse yourself.", false);
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150]++;
		}//[Follow-up encounters, player has naga tail/centaur body/slime body]
		else {
			outputText("You make your way over to Dominika's table and start up a conversation with the modestly dressed woman. You share exploits and knowledge, but can't help but feel like she's being somewhat distant. She glances out to the distance more than once, and drums her fingers on the table. You make conversation for a little while longer, but realize that it's not really going to go anywhere, and excuse yourself.", false);
		}
		cheatTime(1);
		doNext(telAdre.barTelAdre);
		return;
	}
	//Second encounter]
	else if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150] == 1) {
		outputText("You make your way over to Dominika's table again, saying hello once more. The two of you talk about your exploits for a time, before you ask her what she has been up to. \"<i>Research, mostly,</i>\" she explains. \"<i>I try to document what this land has, in the hopes that it may be useful to someone one day. I do consider myself somewhat of a learned woman which... seems to be something of a rarity here, so there are few qualified to do the job.</i>\"\n\n", false);

		outputText("Intrigued, you ask her to elaborate on what she's learned. \"<i>Well, goodness, that could take a while,</i>\" she laughs. \"<i>Mm. Free tip though. Stay away from minotaur cum. That stuff will get you. There's a merchant out there who has some of my work, if you can find him. Other than that I mean, teaching requires a more intimate setting than 'the Wet Bitch'.</i>\" She rolls her eyes slightly at the name. \"<i>I'd be surprised if there's a single college on this entire continent though. Ah well.</i>\"\n\n", false);

		outputText("\"<i>Although...</i>\" she seems to think about something, glancing over at you for a few seconds. After a pause, she adds \"<i>If you'd like, my place is just a few blocks down, I could... impart some knowledge on you there.</i>\"\n\n", false);

		simpleChoices("Sure", acceptDominikasKnowledge, "No Thanks", turnDownDominikasKnowledge, "", null, "", null, "", null);
		return;
	}
	//[Follow-up Introduction]
	else {
		outputText("You make your way over to Dominika's table and strike up conversation with the modestly dressed woman. Her eyes give away her smile and the two of you discuss your exploits. She doesn't attempt to hide the casual way she ogles you during the conversation, and after a brief while, she invites you back to her place.", false);
		simpleChoices("Sure", acceptDominikasKnowledge, "No Thanks", turnDownDominikasKnowledge, "", null, "", null, "", null);
		return;
	}
	outputText("ERROR, ERROR, ALERT THE FENFEN!", true);
	doNext(camp.returnToCampUseOneHour);
}
//[\"<i>No thanks</i>\"]
private function turnDownDominikasKnowledge():void {
	spriteSelect(10);
	clearOutput();
	outputText("\"<i>Fair enough,</i>\" Dominika nods. \"<i>Let me know if you change your mind.</i>\" The two of you make small talk for a while longer, before you decide to get back to work and excuse yourself.\n\n", false);
	cheatTime(1);
	doNext(telAdre.barTelAdre);
}
//[\"<i>Sure</i>\"]
private function acceptDominikasKnowledge():void {
	spriteSelect(58);
	clearOutput();
	//Set that PC has received oral offer (its coming further down for sure)
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150]++;
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150] == 2) {
		outputText("Dominika smiles with her eyes again. She leaves some payment on the table, then escorts you out into the desert city. \"<i>It's not far,</i>\" she says, \"<i>We'll be there in just a few minutes.</i>\"\n\n", false);

		outputText("True to her word, she ducks into an alley just a few blocks down, climbing a ladder leading up to a balcony. \"<i>This city has been co-opted a bit haphazardly,</i>\" she observes as she leads you up, \"<i>So apologies for the irregular front door.</i>\" Glancing up as you climb, you see her pale bare legs, and a glint of metal between them. She helps you onto the balcony, turning and opening the door to her home.\n\n", false);

		outputText("Inside you see a number of books left piled on desks and shelves, as well as maps and diagrams of such a variety you don't even recognize most of them. Dominika lights some oil lamps and briefly reorganizes some fallen books before beginning to disrobe. She unwinds the turban around her head and from the back you see brilliant blonde hair reveal itself, most of it tied into a compact bun. Her top lowers from her shoulders – the skirt around her legs appears to be a separate piece - revealing the pale skin you expected and a surprise beyond that. Her back is covered in tattoos, eccentric circles marked with unknown runes and symbols. Though you do not recognize them you can sense that their placement is intentional even though little space remains. The tattoo runs down her arms to the elbow and over her shoulders, and as she turns you see that it runs over her collarbone and completely covers one half of her front, breast and all. The other half is curiously uncovered.\n\n", false);

		outputText("Despite the revelation of her multiple intricate tattoos, your eyes find themselves drawn elsewhere. Nearly pitch black, her lips shine with moisture and sit plump and full on her face. It says a great deal about their prominence that between them and the fact that she stands topless before you, you stare at her face!\n\n", false);
	}
	else {
		outputText("Dominika smiles with her eyes again. She leaves some payment on the table, then escorts you out into the desert city. The familiar sights along the journey to her abode rush by, nearly forgotten as you ply her with questions and eagerly anticipate ", false);
		if (!fellatrixSucked()) outputText("learning more arcane lore.", false);
		else outputText("getting to feel those black lips on your skin once again.", false);
		outputText("  You let her lead the way inside, and oogle her pale bare legs as she climbs up before you follow.\n\n", false);

		outputText("The inside of her place is unchanged; it's full of books, tomes, and parchments scattered over numerous desks and shelves.  With her tutelage you're able to recognize some of them, but you doubt you'll ever have her encyclopedic knowledge.  ", false);
		if (player.inte >= 80) outputText("Not due to lack of intellect, but due to lack of time.  You're all too aware of your mental skill.  ", false);
		outputText("Dominika unwinds her turban and lets her hair fall free.  She even undoes her top, revealing the curves of her breasts and her strange tattoos.  Despite the revelation of her multiple intricate tattoos, your eyes find themselves drawn elsewhere once again. Nearly pitch black, her lips shine with moisture and sit plump and full on her face. It says a great deal about their prominence that between them and the fact that she stands topless before you, you stare at her face!\n\n", false);
	}

	//If no dominika cooldown up
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00155] == 0) {
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00155] = 7 + rand(3);
		outputText("\"<i>Now then,</i>\" she says. Her hands glow with a brief sense of power, and many of the tattoos shine with equal illumination. She gestures with her hand and the lamps all acquire an unearthly light, as green glowing circles appear interlinked on the floor. \"<i>How much do you know about magic?</i>\"\n\n", false);

		//[If player knows all spells]
		if (player.spellCount() == 6) {
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00154] == 0) {
				flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00154]++;
				outputText("You blink, then casually mention that you actually know quite a bit about magic. Dominika listens to you explain your skill in white and black magic, then coughs awkwardly and glances to the side. \"<i>O-oh,</i>\" she says, \"<i>Well. Uhm. I guess we can talk about magical theory, maybe?</i>\"\n\n", false);
			}
			else outputText("You blink, then casually mention that you actually know quite a bit about magic. Dominika smiles, curling those glistening black lips into an even more erotic shape as she replies, \"<i>Oh I know sweety.  Why don't we discuss the theory behind it all?</i>\"\n\n", false);
			outputText("Magical theory is not very interesting, but you do feel smarter for discussing it.", false);
				//(Player receives Intelligence.)
			dynStats("int", 1+rand(4));
		}
		//[If player knows some spells]
		else if (player.spellCount() > 0) {
			outputText("You take a step backwards in surprise, but your experience with magic makes you realize that she's not doing anything dangerous. You explain that you've learned a bit of sorcery from books, and she nods thoughtfully. \"<i>I see,</i>\" she muses, stroking her chin. \"<i>I think I may be able to show you a thing or two. Let's see here...</i>\"\n\n", false);

			outputText("Dominika seems to be quite good at magic, and you find yourself picking up the spell she demonstrates fairly quickly.", false);
			//(Player receives random unlearned spell.)
			if (player.findStatusEffect(StatusEffects.KnowsMight) < 0) {
				player.createStatusEffect(StatusEffects.KnowsMight,0,0,0,0);
				outputText("\n\n<b>New Black Magic Spell Learned: Might</b>", false);
			}
			else if (player.findStatusEffect(StatusEffects.KnowsHeal) < 0) {
				player.createStatusEffect(StatusEffects.KnowsHeal,0,0,0,0);
				outputText("\n\n<b>New Black Magic Spell Learned: Heal</b>", false);
			}
			else if (player.findStatusEffect(StatusEffects.KnowsArouse) < 0) {
				player.createStatusEffect(StatusEffects.KnowsArouse,0,0,0,0);
				outputText("\n\n<b>New Black Magic Spell Learned: Arouse</b>", false);
			}
			else if (player.findStatusEffect(StatusEffects.KnowsCharge) < 0) {
				player.createStatusEffect(StatusEffects.KnowsCharge,0,0,0,0);
				outputText("\n\n<b>New White Magic Spell Learned: Charge</b>", false);
			}
			else if (player.findStatusEffect(StatusEffects.KnowsBlind) < 0) {
				player.createStatusEffect(StatusEffects.KnowsBlind,0,0,0,0);
				outputText("\n\n<b>New White Magic Spell Learned: Blind</b>", false);
			}
			else if (player.findStatusEffect(StatusEffects.KnowsWhitefire) < 0) {
				player.createStatusEffect(StatusEffects.KnowsWhitefire,0,0,0,0);
				outputText("\n\n<b>New White Magic Spell Learned: Whitefire</b>", false);
			}
			else outputText("==SOMETHING FUCKED UP.  TELL FEN VIA EMAIL (fenoxo@gmail.com) OR POST ON THE BUG FORUMS==", false);
			dynStats("int", 2);
		}
		//[If player knows no spells]
		else {
			outputText("You nearly fall on your " + player.buttDescript() + " in surprise, fumbling to defend yourself from an attack, but Dominika laughs helplessly and tries to collect herself. \"<i>Oh goodness, oh I'm sorry, I'm sorry, this isn't anything. This is just flashy lights and constellation circles. This isn't going to hurt you, I'm sorry.</i>\" She walks over to you and extends a hand, helping you get to your feet and hugging you.\n\n", false);

			outputText("\"<i>So sorry, again,</i>\" she says, those black lips curving into a big smile. \"<i>I guess I'll take that to mean 'not much', so, here. Let me show you some things.</i>\"\n\n", false);

			outputText("Even with your inexperience, you find Dominika to be a good teacher. She helps you focus and train your mind, and you quickly find your first spell to be easy to perform.", false);
			//(Player receives random unlearned spell.)
			if (player.findStatusEffect(StatusEffects.KnowsMight) < 0) {
				player.createStatusEffect(StatusEffects.KnowsMight,0,0,0,0);
				outputText("\n\n<b>New Black Magic Spell Learned: Might</b>", false);
			}
			else if (player.findStatusEffect(StatusEffects.KnowsHeal) < 0) {
				player.createStatusEffect(StatusEffects.KnowsHeal,0,0,0,0);
				outputText("\n\n<b>New Black Magic Spell Learned: Heal</b>", false);
			}
			else if (player.findStatusEffect(StatusEffects.KnowsArouse) < 0) {
				player.createStatusEffect(StatusEffects.KnowsArouse,0,0,0,0);
				outputText("\n\n<b>New Black Magic Spell Learned: Arouse</b>", false);
			}
			else if (player.findStatusEffect(StatusEffects.KnowsCharge) < 0) {
				player.createStatusEffect(StatusEffects.KnowsCharge,0,0,0,0);
				outputText("\n\n<b>New White Magic Spell Learned: Charge</b>", false);
			}
			else if (player.findStatusEffect(StatusEffects.KnowsBlind) < 0) {
				player.createStatusEffect(StatusEffects.KnowsBlind,0,0,0,0);
				outputText("\n\n<b>New White Magic Spell Learned: Blind</b>", false);
			}
			else if (player.findStatusEffect(StatusEffects.KnowsWhitefire) < 0) {
				player.createStatusEffect(StatusEffects.KnowsWhitefire,0,0,0,0);
				outputText("\n\n<b>New White Magic Spell Learned: Whitefire</b>", false);
			}
			else outputText("==SOMETHING FUCKED UP.  TELL FEN VIA EMAIL (fenoxo@gmail.com) OR POST ON THE BUG FORUMS==", false);
			dynStats("int", 2);
		}
	}
	doNext(fellatrixSexWarmup);
}
//[All scenes lead to:]
private function fellatrixSexWarmup():void {
	spriteSelect(58);
	clearOutput();
	//Cooldown ongoing!
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00155] > 0) {
		outputText("Dominika glances out the window nervously and says, \"<i>I don't think you're ready to learn more yet – your mind still needs time to absorb the knowledge from our last meeting.</i>\"  Her tongue slowly slides over the glistening black surface of her lower lip and her voice becomes a little more husky as she offers, \"<i>Why don't we talk about something else?</i>\"\n\n", false);
	}
	//No cooldown, knowledge get epilogue
	else {
		outputText("Dominika glances out the window. \"<i>That, I think, is more than enough for now.</i>\" She rubs her hands together, letting the room return to more normal lighting. Looking back at you she pauses, thinking to herself, then speaks again. \"<i>Now, there is something that you could do for me.</i>\"\n\n", false);
	}

	outputText("She walks towards you, resting her hands on your collarbone.  ", false);
	//(If breasts)
	if (player.biggestTitSize() >= 1) outputText("They briefly run down to the top of your " + player.breastDescript(0) + " before returning to your collar.  ", false);
	//First time
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150] == 2)	outputText("\"<i>I have not been unaffected by this land. I have certain... dietary needs.</i>\" She coughs slightly, glancing aside and looking as though she's doing her very best not to blush.\n\n", false);
	//Repeat
	else outputText("\"<i>You know what I need,</i>\" She coughs slightly, glancing aside and looking as though she's doing her very best not to blush.\n\n", false);

	outputText("Breathing in, she turns back to you and smiles. \"<i>Would it be all right with you if I put my mouth on your genitals", false);
	if (fellatrixSucked()) outputText(" again", false);
	outputText("?</i>\"\n\n", false);

	//[If genderless]
	if (player.gender == 0) {
		outputText("You politely explain that you don't actually have any genitals. Dominika blinks, looks at you, then grabs your crotch. \"<i>Oh. Oh. My uh, my apologies.</i>\" She coughs awkwardly and backs up, rubbing the back of her neck. \"<i>That... that is unfortunate.</i>\" She lowers her skirt slightly, letting you see the top of a chastity belt. \"<i>I can understand to a certain degree but uh... Yikes. At least I can get this taken off if I want.</i>\"\n\n", false);

		outputText("She walks up to you and kisses your cheek. Her full dark lips are devilishly soft and perfectly moist, and you think of the sensation for longer than you expected.  Patting your shoulder, she gives you a half-smile. \"<i>If you solve that, come back some time, eh?</i>\" She helps you out the door and waves goodbye, but you can't help but feel particularly awkward.\n\n", false);
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	simpleChoices("Yes", acceptFellatrixOral, "No", declineFellatrixOral, "", null, "", null, "", null);
}

//If \"<i>No.</i>\"]
private function declineFellatrixOral():void {
	spriteSelect(58);
	clearOutput();
	//No BJs yet.
	if (!fellatrixSucked()) {
		outputText("She raises her eyebrow and looks around. \"<i>...Really?</i>\" she asks after a few seconds. \"<i>Like, I mean... you're going to turn down a free blowjob?</i>\"\n\n", false);

		outputText("She pauses. \"<i>Or cunnilingus, I mean, I haven't looked between your legs yet. You know what this place is like.</i>\"\n\nYou suppose it might not hurt.  Do you want to receive some oral?", false);
		dynStats("lus", 10);
		doYesNo(acceptFellatrixOral,declineFellatrixOralHARDCORE);
	}
	else {
		//[Say \"<i>No</i>\" to oral AFTER having said \"<i>Yes</i>\" first encounter]
		outputText("A twinge of annoyance flicks across Dominika's features. She takes in a calming breath. In that action you find your feet abruptly feeling unsteady, as though the world is slowly being pulled out from beneath you. Catching yourself you glance up at her lips, seeming to entropy with an infinite yawning darkness that engulfs the world. Through that gaze you find yourself stable, but find it difficult to look away.\n\n", false);

		outputText("\"<i>Don't you think you'd like some?</i>\" she asks, each word carefully enunciated and punctuated. You stare at the curve of her lips for every second of the sentence.\n\n", false);

		outputText("What were you thinking?  A little oral sounds great.", false);

		//(Only \"<i>Yes</i>\" is available)
		simpleChoices("Yes", acceptFellatrixOral, "", null, "", null, "", null, "", null);
	}
}
//[If \"<i>No.</i>\" twice]
private function declineFellatrixOralHARDCORE():void {
	spriteSelect(58);
	clearOutput();
	outputText("\"<i>Really?</i>\" she asks again. \"<i>But, I mean... fucking look at these!</i>\" She purses her dark lips, running her tongue over them to emphasize how they glisten in the light. \"<i>Don't tell me you don't think these would feel fucking rad on you.</i>\"\n\nIt's VERY tempting.  Maybe one little round of fellatio?", false);
	dynStats("lus", (10 + player.lib/10));
	doYesNo(acceptFellatrixOral,declineFellatrixOralSUPERHARDCORE);
}

//[If \"<i>No.</i>\" three times]
private function declineFellatrixOralSUPERHARDCORE():void {
	spriteSelect(58);
	clearOutput();
	outputText("Dominika stares at you incredulously, then turns away. \"<i>Fine. Just go then. You know where the door is.</i>\" She walks away into another room, closing the door behind her.\n\n", false);

	outputText("You let yourself out.", false);
	//(Dominika does not appear again.)
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00150] = -1;
	cheatTime(1);
	doNext(telAdre.barTelAdre);
}


private function acceptFellatrixOral():void {
	spriteSelect(58);
	clearOutput();
	outputText(images.showImage("dominika-oral-sex"));
	var x:Number = player.cockThatFits(36);
	//[Random one-shot after Player has done a Scylla scene]
	//Mind control at 6th suck
	if (timesFellatrixSucked() >= 6 && timesFellatrixSucked() - 4 >= flags[kFLAGS.DOMINIKA_LAST_HYPNO_SUCK_COUNT]) {
		dominikaBlowjobs();
		return;
	}
	//After 3+ blowjobs
	if (timesFellatrixSucked() >= 3 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] == 0) {
		if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] > 0) {
			outputText("The familiar slick and slurping brutality is enacted by Dominika's mouth upon you. Those lips engulf you, devour you, inhale you, and in the haze of pleasure you love every single moment. They shine in your mind, glamorized, an immaculate altar to which you can only cum, and cum, and cum, and...\n\n", false);

			outputText("As you regain your composure, gasping on her bed, your mind wanders. The idle conversation that passes between you two is casual – Dominika is noncommittal for much of it, busy wiping off her chest. Glancing over you see her tongue slip over her lips in a final cleansing and shiver. As you stare at the pillows you have grown intimate with, a thought occurs to you. Dominika is not the first traveller you have met with such a hunger, but she seems more than any other to be in control of it. It's possible that she could know something that would be helpful to Scylla. You ask her if she's ever met the nun.\n\n", false);

			outputText("\"<i>Pardon?</i>\" Dominika asks, having not really been paying attention. You repeat yourself, trying to explain the spunk-hungry canoness in ways that clearly communicate her identity. It seems to work, as Dominika's bored confusion turns gradually to neutral indifference. \"<i>Ah, her.</i>\" She speaks dismissively at first, resting cloth over her shoulders to drape over her chest and searching through a drawer. \"<i>I am aware of her, yes.</i>\" Pulling out a mirror she starts to adjust her hair. In the past this dismissal might have meant it was time for you to leave, but after a few moments she pauses and turns.\n\n", false);

			outputText("\"<i>You know, you should be careful who you associate with,</i>\" she says. \"<i>Tel'Adre is... a city of many cowards. Weaklings and malleable fools abound within these walls.</i>\" This particular reaction is not what you expected, and you can only blink in surprise. \"<i>They hide from the world around them, hoping that indolence and apathy will allow them to survive the encroaching demons,</i>\" she continues, \"<i>Hoping that someone will step up and help them when they have done nothing to earn it. They long for their problems to be solved with the push of a button.</i>\"\n\n", false);

			outputText("The sorceress crosses back over to the bed, sitting down beside you. \"<i>Someone like you, though, presses on regardless of hardship, no? You are ill content to lay down and take what this land would force upon you.</i>\" She regards you for a few seconds, before glancing back out the window. \"<i>I long to escape from these naive walls, but the Covenant keeps me chained here, hiding my tools from me. They wish to weaken me to be like any other slave of the city, content to lie down and take the pricks of the world.</i>\"\n\n", false);

			outputText("She takes a deep breath, turning back towards you. \"<i>I would burn this city to the ground if it would result in my freedom from this land, able to return to the spires of my home at last. But surely, as a champion of Ingnam, you understand? To see your family, your friends once again?</i>\"\n\n", false);

			outputText("She seems to be looking at you for affirmation.", false);
			simpleChoices("Agree", agreeWithDominika, "Ehhh", ehhhhDominika, "Disagree", disagreeDominika, "", null, "", null);
		}
		else {
			outputText("You arrive at Dominika's apartment and are led into the familiar adjacent room, where the familiar slick and slurping brutality is enacted by Dominika's mouth upon you.  Those lips engulf you, devour you, caress you, and in the haze of pleasure you love every single moment.  They shine in your mind glamorized, an immaculate altar to which you can only cum, and cum, and cum, and...\n\n", false);

			outputText("The conversation as you recover is casual at best.  She seems more interested in cleaning up and adjusting her hair than the actual words she's saying, and you get ready to go.  As you stretch your eye is drawn to a piece of parchment left on one of the room's tables.  A series of dots is eventually interrupted by splatters of ink and large frustrated gashes through the paper.  With your curiousity piqued you move to get a closer look, and wind up surprised when Dominika's hand comes down on the paper.  \"<i>A project I had to abandon,</i>\" she smiles after a brief pause, though the expression seems born more out of politeness than genuine emotion.  She gathers up the parchment and puts it in a drawer, slamming it shut just a little too loudly.\n\n", false);

			outputText("You glance around a little at the rest of the room, wondering how much more there is to Dominika that you haven't seen.  With little pondering you broach the subject of the parchment, curious to learn more.  Dominika glances at you guardedly before sighing slightly.  \"<i>I've mentioned that this is not my home, yes?</i>\" she asks, answering it dryly before you have a chance to.  \"<i>I suppose that much is obvious given I don't have a fifty foot prick or wings.</i>\"  The cabalist paces to the window to watch the declining sun.  \"<i>It has been a long time since I was home, and I far preferred it to this tainted land.</i>\"  Her hand wrings over itself in the air as she carefully considers her words.\n\n", false);

			outputText("Turning back to you, she sits on the windowsill.  The sunlight frames her golden hair and hides most of her face in shadow, but you can still see her dark lips as she speaks.  \"<i>You must be aware that there is far more to magic than these simple cantrips of the white and black schools?  Your people surely had rituals, curses, blessings that didn't require chastity or the onset of lust.  Mine did.  In the darkness of the night sky, we found power.  Incredible rituals could be performed with the proper rotation of the stars.  Even now my strength waxes and wanes with the season.</i>\"\n\n", false);

			outputText("Dominika turns back to the window, a hiss of distaste in her voice.  \"<i>But the tools I need to map the stars of this land and truly unlock my power – to give me such strength that I could free myself from this prison... I was not permitted to keep them.  The Covenant confiscated them from me.  The sky clouds itself and hides the movement of the constellations and I am forced to lay here in this city of cowards, imprisoned by the status quo!</i>\"  Her voice finds more passion as she continues.  The grip she has on the frame of the window tightens.  \"<i>No one fights this.  No one dares to try to free themselves!  They remain locked in these hovels, scurrying out of sight like a roach in the light.  The demons feast upon the land because Tel'Adre has already surrendered it, and they delude themselves into thinking they have not surrendered themselves.  But time and magic march on.  They will drink, and fuck, and fall, because this is not a game of survival.  The demons move forward, the demons hunt, and Tel'Adre hides.  They play a game that only ends when they are found.</i>\"\n\n", false);

			outputText("The aggressiveness of her speech has had a clear effect on Dominika.  Her tattooes have a subtle fading light to them, vanishing as she regains her composure.  When she turns back to you her expression is solemn, and cold.  \"<i>I am ready to leave this city to the fate it has resigned itself to.</i>\"  The words come quietly, but hold more weight than all the dialogue you two have shared.  \"<i>But with it actively choosing to oppress me rather than fight, I cannot do it alone. You, champion – you are strong. Regardless of what this land has done to you, you fight.</i>\"\n\n", false);

			outputText("She crosses the room to return to you, resting a hand on your chest.  \"<i>I want my freedom back, and I do not care anymore what I have to destroy to get it.  Help me.</i>\"", false);
			simpleChoices("Agree", agreeWithDominika, "Ehhh", ehhhhDominika, "Disagree", disagreeDominika, "", null, "", null);
		}
		player.orgasm();
		dynStats("lib", -1, "sen", 1);
		return;
	}
	if (x < 0) x = 0;
	//[If \"<i>Yes</i>\" and vagina]
	if (player.hasVagina() && (player.gender == 2 || rand(2) == 0)) {
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00153] == 0) {
			outputText("Dominika's dark lips curve up in a wicked grin and she leads you by the hand to another room. Within is a bed that looks to be more comfortable than any piece of furniture you've seen since leaving your village. You are more than happy to sit upon it when she gestures. The pale mage removes the bottom of your " + player.armorName + " and claps her hands together in a giggling laugh when she sees your vagina. \"<i>Oh my goodness!</i>\" she grins, \"<i>You actually have a cute little vagina! That's SO HARD TO FIND here!</i>\" Climbing onto the bed with you she gives a surprising embrace, planting her ebony lips on your cheek. \"<i>Here, lay back,</i>\" she insists, leaning on your shoulders to have you lay down.\n\n", false);
			outputText("She straddles your belly, looking down at you with a mischievous grin. Curiously you feel metal rubbing against your bare skin, much like you saw between her legs earlier. Is she wearing a chastity belt? The tattooed teacher leans down and drags her darkened lips sensually over your own, sucking on your lower lip. The connection of flesh is almost electric in its stimulation – you quickly have to admit to yourself that her lips feel pretty damn good. Her tongue flicks out over the curves on your face and though you try to catch it her body is already sliding down your own. Her bare breasts tease your flesh as her nipples bump and catch against your skin.\n\n", false);
			outputText("Those succulent soft lips slip along your belly, teasing you with their moisture. Her hands run along your thighs and guide them further apart as she goes. Your bare slit feels her breasts slide along it as she comes ever closer to the promised cunnilingus. One last push on both your thighs spreads your legs yet further, and as she lifts her head to look at your body you cannot help but feel prostrated before her on display. Your eyes wander down to the lips that have traced her path down your body. It was not intentional – they were simply the first thing to catch your eye, even though she was gazing back at you. Their fullness arouses you even more now that you have felt their touch.\n\n", false);
			outputText("\"<i>Now then,</i>\" she purrs, and then descends. You feel her tongue first. There is a gentility in the touch, as it slips slowly over you. A groan forces its way out of you, more from relaxation than pleasure. The tensions from the endless combat and always encroaching lust of the realm slip away beneath her talented touch. Your hands reach down to stroke through her hair, but Dominika bats them away. \"<i>Now now,</i>\" she purrs, her breath and voice hot over you. \"<i>Just relax. Let me.</i>\" The way her lips curve when she speaks excites you again, even as you blush at the realization you focused on them once more.\n\n", false);
			outputText("Her lower lip brushes against your " + player.clitDescript() + ", and another groan leaves your throat. You hadn't expected a touch there so soon, but it sends pleasure all through your body and your breath immediately starts to come quicker. That lip slips down as she opens her mouth, and her topmost pillow remains pressed to your " + player.clitDescript() + ", continuing to offer more stimulation. She grinds her plump puckers slowly along the outer folds of your " + player.vaginaDescript(0) + ", letting you feel the obsidian flesh press to and stimulate you, filling you with the sensation of a succulent sex organ on your own.\n\n", false);
			outputText("Nails dig into your thighs abruptly as she tightens her grip. Hungrily she opens her mouth wider and pushes her tongue into your " + player.vaginaDescript(0) + ", wriggling it about. She pushes against your walls curiously and experimentally, aggressively seeking out your pleasure. With a strangled gasp you cannot help but rock your hips forward, pressing closer to her warm and seductive mouth.  A familiar lustful heat rises through your body as her tongue brings out the same reaction in you as the thickest phalluses. You gasp out praise for her oral ministrations, whimpering while she swallows down your nectar. Once more you reach down to stroke through Dominika's hair, but once more she pushes your hands away.\n\n", false);
			outputText("She rises from your " + player.vaginaDescript(0) + ", irritation on her face. \"<i>Lay. Down.</i>\" Her words come out firmly, the ebony lips enunciating each word. You find it impossible not to look at them as she speaks now, staring at their slow movement to form each sound. \"<i>Let me feed.</i>\" Echoing in your mind, you groan happily. The way those dark lips curve as she speaks, the way they curl and press together... You want them on you. You want them pressing over every inch of your sensitive flesh, pulling at the skin on your neck, rubbing along your own lips. Their dark beauty is intoxicating. Your fingers rub along the bed, gripping the covers tightly as you moan and press your hips forward, offering up your " + player.vaginaDescript(0) + ".\n\n", false);
			outputText("Her mouth and those lips descend on you again, pulling lightly at your labia and scandalizing your flesh with their contact. She opens wide and practically swallows your " + player.vaginaDescript(0) + ", covering all of it with her maw and breathing hotly into it. Her tongue pushes in and rapidly returns to its ministrations, grinding spit and your juices in a circle. Practically lapping at you like a cat drinking from a bowl she can be heard slurping on you and your pussy. Indeed, she seems to purr into you, vibrating her tongue within. Those lips quiver slightly against you in the motion.\n\n", false);
			outputText("The slippery warm appendage presses up, beginning to search for your spot. When you give a stifled, excited gasp and raise your hips she knows why. With a passion bordering on possessive aggression her tongue works you over, forcing you to buck and writhe against those immaculate black pillows. You want to shout out and cry in pleasure, but it is too pleasurable to do even that. Your breath comes out faster and higher as you are unable to contain yourself. The dam breaks and you nearly gush in orgasm.\n\n", false);
			outputText("You lose track of how long you ride out the wave of maddening pleasure. You can feel her lips on your crotch, feel yourself coming into her engulfing mouth, but this seems as though an eternity is passing. Sheer bliss swallows you and you feel wildly happy cumming into her mouth again and again, rocking your hips in joy.  Simply knowing that those dark lips are pressed up against your " + player.vaginaDescript(0) + " is enough to make your pleasure exceed what you imagined, lost in the deepest haze of orgasm. You might stay like this against her mouth forever if it feels this good.\n\n", false);
			outputText("Finally you feel her slide up along your body, and those warm, wet lips kiss your own. You relax slowly, gasping and opening your eyes. Dominika smiles at you, gently running a hand over your belly and then brushing your cheek. \"<i>Ssh, easy. That was delicious, darling.</i>\" She kisses your cheek. \"<i>Everything I could have hoped for.</i>\" You voice your appreciation, but can't help but ask why she wanted to eat you out. \"<i>Oh I told you, dear,</i>\" she laughs slightly, licking her lips, \"<i>I need sustenance. Still though, even if I wanted to...</i>\"\n\n", false);
			outputText("She takes your hand and presses it to her crotch where you feel the unyielding strength of metal. She lowers her skirt slightly and you see the beginnings of a carefully crafted chastity belt. \"<i>It's alright though,</i>\" she smiles, kissing your cheek, \"<i>I enjoyed myself plenty.</i>\" She then gives an almost wicked grin, a fake expression of innocence dancing across her eyes. \"<i>Just take an hour before you try sitting on anyone else, is my advice.</i>\"\n\n", false);
			outputText("After a bit of small talk, she glances out the window, and suggests you get back to your adventuring. She kisses you once more as you go, and you taste those sinful lips on your own as you return to your camp.\n\n", false);
		}
		//Repeat
		else {
			outputText("Once you arrive at the second-story apartment, Dominika practically pulls you into the other room, eager to descend upon your " + player.vaginaDescript(0) + ". She lays you on the bed again, removing the bottom of your " + player.armorName + " and laying beneath you. Gliding her hands over your thighs she aggressively begins lapping at your " + player.vaginaDescript(0) + " with her tongue, coating it in spit. \"<i>Mmm, I hope you squirt a river,</i>\" she purrs, giving your " + player.clitDescript() + " a kiss as intimate as a lover's. The way her lips move is intoxicating, sliding their slippery glossy surface over every inch of your " + player.vaginaDescript(0) + " before engulfing the delicate flesh.\n\n", false);
			outputText("She forces your legs open and holds your hands at your side so that she can have free reign over your exposed cunt, hardly submissive even as she takes you in her mouth. Her lips twist from side to side as she rubs her mouth lewdly over your flesh. Spit drips between your legs, and deep satisfied slurping noises arise from the bobbing blonde hair before you. Her mouth is warm and breathy against you, but her plump lips press to your skin like a seal, letting you know that you can only leave her mouth when she is ready. The friction is electric, and you drool nectar into her mouth. All of it is slurped down into her waiting throat.\n\n", false);
			outputText("Her tongue aggressively shoves itself into you once more, slapping against the walls of your " + player.vaginaDescript(0) + " as though trying to break them down. You can practically feel your juices splattering across your cunt and then slurped up by her in the frenzy she approaches you with. Your world becomes consumed by raw sensation as effortlessly as your own " + player.vaginaDescript(0) + " is consumed by her ravenous maw, losing yourself in the pleasure granted you by those plump fuckable puckers. ", false);
			if (player.totalCocks() == 0) outputText("A part of you even wishes that you had a cock so you could shove through them!\n\n", false);
			else outputText("A part of you even wishes that she had chosen your cock so you could shove it through them!\n\n", false);
			outputText("You don't speak, cannot speak as she sucks and gulps at your flesh. You can only offer up strangled gasps and shuddered squeals to her actions, prostrated like a servant before her, gripping the covers and mattress beneath you. Your " + player.vaginaDescript(0) + " is hers, to impose whatever demands she wishes, and the insatiable suckling upon you makes her demands clear. Her tongue twists about in you and against you, mocking your fingers with how much better it seems to know your pleasure.\n\n", false);
			outputText("You cannot resist for long after she takes over your spot once again, grinding against it and forcing you to arc your back. Pleasure surrounds you as effortlessly as her lips surround your " + player.clitDescript() + ", and you find yourself cumming hard against her. She drinks everything you give her, sucking on your " + player.vaginaDescript(0) + " to ensure as little as possible escapes. You feel as though the orgasm could last forever, but settle slowly as she gently kisses your lips, stroking along your belly.\n\n", false);
			outputText("\"<i>As always, delicious,</i>\" she smiles, cuddling with you in the afterglow of her meal. She caresses you until you regain your strength, and then politely helps you re-dress and sends you on your way, giving you a kiss to remember her. Those black lips linger in your mind as you walk the streets of Tel'Adre on your way back to camp.", false);
		}
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00153]++;
	}
	//MULTICAWWWWK
	else if (player.cockTotal() >= 2 && rand(2) == 0) {
		//[If \"<i>Yes</i>\" and multi-cock]
		if (flags[kFLAGS.DOMINIKA_TIMES_MULTICOCK_SLOBBERED] == 0) {
			outputText("She licks her teeth rather than her lips, reminding you in some ways of a predator observing prey.  You scarcely have time to contemplate this before she tugs you into the next room.  If the exceedingly comfortable-looking bed is any indication this would be where she sleeps.  Dominika insists upon you sitting on it and you find it to be exactly as comfortable as it looks, if not more so.  \"<i>I knew it was an offer you'd accept,</i>\" she coos.  \"<i>So few are worth my attentions, but you... you caught my eye, champion.</i>\"  She approaches you with a seductive slink in her step, grabbing hold of your " + player.armorName + " and tugging away the bottom.  Her eyes light up with mischievous anticipation as she sees what waits beneath it.\n\n", false);

			outputText("\"<i>My my my, you must have been looking forward to this, you brought me a bouquet,</i>\" she teases.  Curling her palm around your " + player.cockDescript(0) + ", Dominika tosses you a smug smile.  \"<i>Although I hope I'm not disappointing you if I call it more of a buffet.</i>\"  While continuing to tease your " + player.cockDescript(0) + " with gentle friction, her other hand roams along your crotch.  The gentle fingers tease between your " + player.multiCockDescriptLight() + ", taking the time to familiarize themselves with the texture of your flesh.  The grin spread across her deep lips does not lessen as her skin tastes yours.  \"<i>I'm always curious about the circumstances that lead to this point,</i>\" Dominika admits as her fingertips play about your head.  \"<i>Was it an addiction to Incubus Draft? A spell gone wrong? You certainly didn't come here equipped like this. But then...</i>\"  She leans in, flicking her tongue across the tip of your " + player.cockDescript(0) + ". \"<i>It's not particularly important, is it?</i>\"\n\n", false);

			outputText("She leans in close to continue, her breasts rubbing across your " + player.multiCockDescriptLight() + " as a result.  \"<i>We're not after life stories, or deep introspection here,</i>\" she whispers slowly, her breath flowing heatedly over your " + player.cockDescript(0) + ".  \"<i>You want me to do things to your body. It's that simple. And I...</i>\" Her black lower lip drags itself over your head, its full curve teasing your cumslit as it passes by.  \"<i>I want this.</i>\"  Fingernails trail over your skin as she runs the verbal foreplay across your " + player.cockDescript(0) + ", carried in her breath.  Her tongue flicks across your slit, taunting it while her hands roam freely over you.  In the relaxation her pleasure provides, you reach forward to rest your hand on her head, only to be abruptly reprimanded by a slap to your wrist.  \"<i>No,</i>\" she hisses smugly, letting her lips drag against the side of your " + player.cockDescript(0) + " as she speaks.  Their softness quickens your breath, and you focus on the words she speaks to keep your head.  \"<i>I'm not interested in letting you set the pace, dear.  This is mine to play with.</i>\"\n\n", false);

			outputText("She shifts in deeper, slurping lightly on the side of your base.  Her chin rubs against your " + player.cockDescript(1) + " as she teases your primary wang, letting her skin taunt everything in your lap from your thighs to your pricks with her proximity.  The plumpness of her breasts makes for a suitable cockrest as her ebony puckers glide over the straining flesh of your " + player.cockDescript(0) + ".  They shift and move with her, pressing into your thigh as she swaps sides and sucks on the meat of your shaft.  Her dark lips feel better than you had imagined.  Their fullness belied a delicate touch that now, in the moment of finally experiencing them, borders on ecstasy.  You let your hands fall to the side to support yourself as Dominika works over your lap, accepting her terms if it means she labors over you like this.  The continued teasing over the side of your " + player.cockDescript(0) + " makes you eager to actually enter her mouth, but the casual way she claims dominion over your lap so that she can blow you is too enjoyable to interrupt.\n\n", false);

			outputText("Fortunately, you don't have to wait long. As her midnight cocksuckers drag up your " + player.cockDescript(0) + " once more, they curl around your head.  Finally your dick finds the warmth and clinging flesh of a hole. A groan forces itself past your lips and you can feel Dominika's dark puckers smirk.  They twist from side to side around your shaft, her breasts shifting and knocking against your " + player.multiCockDescriptLight() + " and catching some of the sweat from your crotch on them. Her fingers play wantonly where they please, at times squeezing and rubbing into your thighs, at others caressing randomly across your flesh.  Your " + player.cockDescript(1) + " soon comes to know their touch quite intimately.  Despite all this – despite much of your " + player.multiCockDescriptLight() + " simply sitting out in the air, pressing against the tattooed woman for warmth – your mind is drawn to the sensations of her mouth, and the sensations of those  deep, dark lips.  You only lust for them more as they drag along you.  Every little twist, every gulp that pushes them in another direction sends a tensing shiver down your " + player.cockDescript(0) + ".  Your breath catches in your throat, gasping when you feel the inside of her cheek grind against your prick.\n\n", false);

			outputText("The tensing, slurping pleasure forces you to pull your gaze away eventually, closing your eyes as everything unfocuses in favor of experiencing raw sensation.  The thought of those dark suckers is more than enough to fixate on.  Their succulent fullness is perfectly imagined in your mind, and thinking about them only gets you hotter and harder.  This in turn only spreads the black, flawless cocksuckers around your " + player.cockDescript(0) + " wider, the thought of which is nearly too much just by itself.  Imagining Dominika's pitch dark lips forced into a wide O by your prick feels so natural, and so right.  You spread your legs further apart to thrust your " + player.multiCockDescriptLight() + " out even more, prostrating yourself before those delicious and devilish dickslurpers.  The eagerness with which they grip, twist, and spread the thick saliva that clings to every inch that her mouth has descended upon provides you some of the strongest pleasure you've felt since... really, with your mind so absorbed in the lewd and loud cocksucking, you can't remember feeling better.\n\n", false);

			outputText("Dominika only goes further on you, letting your " + player.cockDescript(1) + " push over her shoulder and past her hair.  It sits out in the air but the obscene warmth wrapping around your " + player.cockDescript(0) + " keeps you from caring.  Even having just one of your dicks in her dripping maw, attended to by her covetous tongue, is enough.  You think just having her work your head would satisfy you – though you hardly object to those dark lips pulling you further in!  Half your prick sits inside her hungry mouth, your cockhead grinding at the back of her throat.  The dominance she claims over your lap ensures you need not ask her to keep going – her gulping throat keeps pulling, taking all of your " + player.cockDescript(0) + " into it.  Deep swallowing slurps drag along the length of your " + player.cockDescript(0) + " as though it was being milked for those black puckers.  Perhaps it was.\n\n", false);

			outputText("The cabalist seems ill content to simply rest in your lap, and resumes her ravenous and whorish bobbing.  She does not shy from taking great big gulps of your prick, sliding so far up your shaft that her depraved 'O' lips stop right beneath your head, and then diving back down to impale her face and clutch you within her throat once more.  Again and again she performs this lewd facefucking upon you, coating your " + player.cockDescript(0) + " and her chin in spit yet remaining fully in control.  The urge to cum continues to rise in you, eager to feed and please those perfect fat cocksuckers and show them that your prick is worth it.  As she continues to repeat the dominant suction it becomes harder to resist this urge, and as the pleasure continues to rise, your cock straining and bursting to release, you ask yourself why you are resisting it at all.  The first blast of cum splatters into Dominika's throat, and nearly whimpering in pleasure you thrust forward.  Nothing is important but cumming, dumping the thick loads that have yearned to escape out into whatever is before your " + player.multiCockDescriptLight() + ".  You feel the cabalist gather them up to press against her warm body, not out into space.  Some of your jizz runs down your " + player.cockDescript(1) + ", dripping off her chin. It's hard to focus.  You just want to ride this wave of pleasure further, continue to jerk and spasm as your lap releases its load.  More and more you cum as those dark lips squeeze you, those fat flawless cocksuckers that so desperately need your cum.  You give everything, and you just keep thrusting.\n\n", false);

			outputText("Softly her lips press against yours, and you start to relax.  Glancing down your " + player.multiCockDescriptLight() + " has long since finished, and Dominika stands before you smirking.  She collects some of the spunk splattered across her chest on a finger and sucks it clean between those deep lips.  It's hard to recall all of what you just went through, but you feel incredible.  Just the sensation of the air on your sensitive prick makes you whimper a little.  \"<i>Healthy, hearty,</i>\" she teases, \"<i>You pass expectations, I'd say. A shame I could not get to every inch of you before you blew, but... well, I'm used to it.</i>\"  You voice your appreciation, but can't help but ask why she wanted to blow you.  \"<i>Oh I told you, dear,</i>\" she laughs slightly, licking her lips, \"<i>I need to eat.  Still though, even if I wanted to...</i>\"\n\n", false);

			outputText("She takes your hand and presses it to her crotch where you feel the unyielding strength of metal.  She lowers her skirt slightly and you see the beginnings of a carefully crafted chastity belt.  \"<i>It's alright though,</i>\" she smiles, kissing your cheek, \"<i>I enjoyed myself plenty.</i>\"  She then gives an almost wicked grin, a fake expression of innocence dancing across her eyes.  \"<i>Just take an hour before you try putting that in anyone else, is my advice.</i>\"\n\n", false);

			outputText("After a bit of small talk – and some cleaning of her chest and shoulders -  she glances out the window, and suggests you get back to your adventuring.  She kisses you once more as you go, and you taste the ebony curves on your lips as you return to the streets of Tel'Adre.", false);
		}
		//[Follow up Multi]
		else {
			outputText("You barely have time to nod your assent before Dominika drags you into the other room with a grin, nearly throwing you to the bed and licking her lips.  \"<i>C'mon then you cumfactory,</i>\" she smirks, tossing aside the bottom of your " + player.armorName + " carelessly.  Her fingers trail at your thighs as she looks down at your " + player.multiCockDescriptLight() + " with an unsubtle hunger.  \"<i>Show me just how much you like what I do.</i>\"  Her hand curls around your " + player.cockDescript(1) + ", jerking it recklessly and lewdly.  You're hardly about to not get erect at her half-naked form and the administrations to your crotch – much less the sight of those deep, delicious lips – so the command feels a little silly.  You really stop caring about how silly it is as soon as her mouth slides over your " + player.cockDescript(1) + ".  She sucks casually on the prick, roaming over the base with one hand while the other taunts the head of your " + player.cockDescript(0) + ".  Though you try to relax, a small amount of tension still sits in you, brought about by the knowledge of just how recklessly Dominika can assault your prick with her succulent full puckers.\n\n", false);

			outputText("It's clear that it won't take long for her to reach that point.  Though she soon squeezes your cocks together and lashes her tongue across them, you can see her eyes settling on your " + player.cockDescript(0) + ", hungry for the fattest one.  Those dark cocksuckers kiss every cumslit wetly in turn, but wrap around the foremost of your pricks soon after.  They slide and shift messily around, the cabalist unafraid to spit and drool over your " + player.cockDescript(0) + " as she works it over.  Every movement the soft flesh makes excites you.  Your prick presses into the roof of her mouth, into her cheeks, pressing down her tongue.  It roams about the wet maw not freely, but where she demands it go.  The wet warmth pulling at your prick ensures you don't mind at all.  Her tongue nearly flays your prick in her ravenous domination, grinding so intimately into you they might have been joined as one.  Saliva drips down your prick from her squeezing ebony kiss, only allowing her to move slicker and quicker about you.  The plump 'O'-shaped puckers dominate your thoughts as easily as they dominate your lap, nearly sealing around your " + player.cockDescript(0) + " and ensuring that you will not leave her mouth until she is ready for you to.  The control she exhibits is wildly arousing and you happily drool pre-cum into her gulping mouth.  She swallows it up at the same time as she pulls you into her throat, claiming your prick even more.\n\n", false);

			outputText("All the while the rest of your " + player.multiCockDescriptLight() + " find themselves in the grip of her delicate hands. Their softness speaks to the life of a magic-user. It seems as though the hardest she may have worked in her life was the rough pumping she gave your " + player.cockDescript(1) + ".  She is unrelenting in her treatment, ensuring you stay constantly stimulated even at the risk of overdoing it.  Dominika doesn't seem to care how much you groan, or gasp, or whimper at the pleasure and wet friction she gives you.  She cares only about making you cum.  Without those full black lips to focus on it feels as though she might make you pass out, but you can cling to the thought of them as tightly as they cling to you.  They engulf you, swallowing and sucking messily eternally.\n\n", false);

			outputText("She drags you recklessly to the edge.  You know you will fall over it, and when you do you will pump load after load of sticky spunk out of your " + player.multiCockDescriptLight() + " drenching whatever has a grip on you or sits in front of you.  Dominika dominates this position, and her dripping maw's constant assault on your lap demands so much of your attention it becomes easy to forget that anything else exists.  You twitch and clench, pushing up and forwards until her face is hilted on you.  In that moment of slutty unity you can no longer resist her throat's demands.  Bulging out her swallowing hole, even your sense of self becomes momentarily replaced by nothing more than the need to cum and dump your jizm.  Maybe the two of you are a single entity, devouring and producing cum eternally.  You don't know. You just cum.  You don't stop cumming.  You pump and you thrust and you moan in unbroken pleasure.  The sensation seems eternal until a kiss on your cheek breaks the reverie, leaving you to fall backwards gasping.\n\n", false);

			outputText("\"<i>As always, delicious,</i>\" Dominika smiles, relaxing with you in the afterglow of her meal.  She caresses you until you regain your strength, and then politely helps you re-dress and sends you on your way, giving you a kiss to remember her.  Those black lips linger in your mind as you walk the streets of Tel'Adre.", false);
		}
		flags[kFLAGS.DOMINIKA_TIMES_MULTICOCK_SLOBBERED]++;
	}
	//[If \"<i>Yes</i>\" and penis small enough to suck]
	else if (player.cockArea(x) <= 36) {
		//Dogcock suck
		if (player.hasKnot(x)) {
			// - first time dogsuck
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00156] == 0) {
				outputText("A confident chuckle comes from Dominika's throat as she takes your hand and leads you to another room. \"<i>Come then, sit down,</i>\" she smiles, patting the surprisingly luxurious bed within. \"<i>Make yourself comfortable, dear, as you'll not be standing up.</i>\" You quirk her head, but the nearly carnivorous way she licks those dark lips suggests that her 'certain dietary needs' are ones she pursues with some passion, and sitting down seems like a good idea. She in turn paces calmly around to face you, resting her hand on your shoulder as she does. A single, appraising glance is given you before she kneels and removes the bottom portion of your " + player.armorName + ".\n\n", false);

				outputText("You were not prepared for the brief laugh that escapes her inky lips. \"<i>Ah, sorry, sorry,</i>\" she quickly explains, though she still smirks, \"<i>Just... mmm, fan of spicy food, I take it?</i>\" She brushes her hands over your " + player.cockDescript(x) + " and briefly rubs your knot with two fingers. \"<i>As long as you give me my food we shouldn't have any problems.</i>\" Those dark lips turn once more into a grin both confident and wicked. Leaning forward, her plump lower lip rests against the shaft of your " + player.cockDescript(x) + " before dragging slowly upwards, leaving behind a trail of subtle saliva. Her top lip curls over your tip as she arrives, giving the first small suck of your meat – one that feels incredible. The heat and warmth of her mouth is only teased at but you desire far more, to say little of the soft sensation from her curving pillows. The single action is capped off by her tongue flicking across your very tip, leaving behind the warm trail of her spit.\n\n", false);

				outputText("A sense of strange regret comes as she lifts her mouth from you, but you know she's not going anywhere. Her fingers curl around you, almost undulating slowly as she makes them crawl down your " + player.cockDescript(x) + ". She watches your pleasured grunting with amusement, though her eyes continually flicker back down to the shaft in hand. \"<i>I hope you're not used to company licking your crotch,</i>\" she teases, leaning in and dragging her slippery tongue over the meeting of crotch and shaft. The side of her lips rub against your knot in turn, the contact as electric as it was before. Already you can feel yourself ready to swell up fuller and fuller, to lock yourself in her and flood her with the thick spunk waiting to be free, but your resolve restrains you for now. You are eager to see what else she – and those ebony pillows of hers – enacts upon you. Her tongue swirls around you, your " + player.cockDescript(x) + " gliding about her forehead and her cheeks as a result of the motion. The contact of the flesh helps soothe the lust you feel looking at the plump curves upon her face.\n\n", false);

				outputText("Eager to see those lusts slaked, you reach forward, moving to at the very least caress her hair and encourage what she's doing, but her hands come firmly to your wrists. \"<i>Down, boy,</i>\" she smirks up at you, \"<i>Do you think you're going to be setting this pace? No, no no no.</i>\" With a grip firm enough to inform you that she will not accept no for an answer she sets your hands to your side. You like the way her lips smile when you acquiesce to her insistence. \"<i>This is my toy to play with, not yours. I'm in control here.</i>\" The slow way she punctuates each word and the shapes her lips make as she does so tantalize you. The moment her lips make those shapes around your " + player.cockDescript(x) + " and start to grind, you realize that the feeling of those ebony curves forming around you is not nearly enough. Still, the heated breath emanating from between them and the brief brushes they give as they pass on by keep the blood stiff within your shaft, eager and awaiting what more she desires.\n\n", false);
				outputText("Her tongue returns to the base of your " + player.cockDescript(x) + ", this time circling around your knot. Coming eventually to the bottom of it, her tongue begins another slow ascent, smearing the warmth of her mouth all along the already slick underside of your prick. A little torment plays out within you, wondering whether this was even better than the first lick, but the thought of those lips about to act upon you overwhelms all other frivolous imaginings. Every little bit that the tongue travels up you is one step closer to their ebony grip engulfing you.\n\n", false);

				outputText("Saliva flicks across your tip as she finishes the slow lick. The lewd schlorp that follows makes you spasm, thighs twitching as you jerk forward. A strangled gasp is ripped from your throat, the abrupt penetration of the sorceress' mouth catching you unprepared even in your obsession with her maw in your mind.  She fills her mouth with you, wetly slipping around your " + player.cockDescript(x) + ", shoving your tip into her cheeks. It grinds against the soft and heated flesh within until she can no longer fit the swelling shaft between teeth and cheek. Her tongue then becomes the focus of the slow grind, rubbing itself from side to side along the underbelly of your " + player.cockDescript(x) + " as Dominika's warm mouth begins to bob about your length. The movement of those sinful lips is palpable, your prick able to track each movement of the full flesh as they slide along it. Never did you expect so much pleasant friction from so slick a substance! Though her mouth seems to effortlessly slip along you the drag of her flesh feels almost as though those plump lips could pull you off the bed.\n\n", false);

				outputText("The ache of your desire feels so palpable you want to strangle it. You long to reach forward and take the occultist's head, to shove her down and let your knot lock her to your crotch and to dump endless depravity into her stomach. Every time you think of it you are reminded of the firm instructions she gave you not to, and the thought of disregarding those lips stresses you to uncomfortable levels. Your " + player.cockDescript(x) + " feels as though it is straining against the bondage of its very flesh as she grows more frenzied, wanting to burst out in infinite size and overwhelming jizz. You want more, and you want it from Dominika.\n\n", false);

				outputText("Almost as though she was teasing your desire, her fingers close around your knot. Though the soft skin is pleasurable to the touch, they clench tightly, rubbing the spit dripping down your " + player.cockDescript(x) + " against the engorged skin. Above the knot, her face bounces harder and harder, the act more akin to a juicy cunt bouncing in your lap than the mouth shoving itself onto your dick. You're fucking her – or rather, she's fucking you, mounting you with her mouth the way a more traditional slut might have straddled your lap. Your knot swells into her fingers, the lust and the passion of the moment causing it to give up on pushing past those flawless ebony pillows that slip faster and faster over your " + player.cockDescript(x) + ". Lost in the passionate throes of animal rutting with a sloppy drooling maw, you close your eyes as your orgasm approaches.\n\n", false);

				outputText("Darkness fills your vision when you do – the darkness of those deep, sinful lips. You can focus on nothing else, imagining the lewd O they make around you. You picture her face, her jaw stretched out, those black pouty curves bidding you enter. Bidding you feed them. Hips twitching and rocking of their own accord you can no longer hold back. As though a dam had burst, spunk floods the passage of your " + player.cockDescript(x) + " and shoots into the swallowing throat of the tattooed magistrix. You slam your hips forward as though shoving yourself into the biggest-bootied bitch-whore you've met, and it feels like those plump plush pillows are providing even more cushioning. The spasms that rock your body threaten to give you whiplash, the raw unadulterated pleasure you feel here in this mouth, mind-blowing. Nothing exists in your mind but cum, and those lips, those perfect, immaculate, godly, dripping...\n\n", false);

				outputText("Softly her lips press against yours, and you start to relax. Glancing down, your " + player.cockDescript(x) + " has long since finished (though the knot remains thick), and Dominika sits beside you smirking. She gently massages your head as you recover from the fellatio, groaning slightly. It's hard to remember those last few moments, though you feel incredible. Just the sensation of the air on your sensitive prick makes you whimper a little. \"<i>I think I gave him a bit of a workout,</i>\" she teases, \"<i>It's always good to remind a dick that a good mouth can do oh so much to it.</i>\" You voice your appreciation, but can't help but ask why she wanted to blow you. \"<i>Oh I told you, dear,</i>\" she laughs slightly, licking her lips, \"<i>I need to eat. Still though, even if I wanted to...</i>\"\n\n", false);

				outputText("She takes your hand and presses it to her crotch where you feel the unyielding strength of metal. She lowers her skirt slightly and you see the beginnings of a carefully crafted chastity belt. \"<i>It's alright though,</i>\" she smiles, kissing your cheek, \"<i>I enjoyed myself plenty.</i>\" She then gives an almost wicked grin, a fake expression of innocence dancing across her eyes. \"<i>Just take an hour before you try putting that in anyone else, is my advice.</i>\"\n\n", false);

				outputText("After a bit of small talk, she glances out the window, and suggests you get back to your adventuring. She kisses you once more as you go, and you taste the ebony curves on your lips as you return to the streets of Tel'Adre.", false);
			}
			else {
				outputText("You arrive at the second-story apartment and Dominika unceremoniously drags you into the other room. \"<i>C'mon, bitch,</i>\" she says playfully, licking those deep lips.  She sits you on the bed and pulls your " + player.armorName + " away from you, kneeling down. \"<i>I trust you've built up a good meal?</i>\" She rapidly starts pumping your " + player.cockDescript(x) + " with her hands, spitting on it for lube. Her fingertips shift down and start pressing tauntingly into your knot while her mouth comes down, bringing with it those gorgeous fat lips. The way they move is intoxicating, slipping about your shaft before sliding over the tip of your prick. Seeing the lewd O begin to form and grow larger only helps you get harder.\n\n", false);

				outputText("Her hands are rough with you, forcing you to spread your legs so that your " + player.cockDescript(x) + " stands upright and exposed. You know she doesn't want your hands in the way, and you obey her desires. She's in control here, and with the way she makes your meat feel, you wouldn't want it any other way. If she wants you to be her blown bitch, so be it. Her lips twist from side to side as she pushes your tip into her mouth, making her cheeks bulge and dragging you against the roof of her mouth. Spit drips down your " + player.cockDescript(x) + ", and deep satisfied gulping noises arise from between your legs. Every inch of her mouth is warm and soft, but her plump lips close around you like a seal, letting you know that you can leave her mouth only when she is ready. The friction elicits full-body trembling, and you drool pre-cum into her mouth. All of it is slurped down into her waiting throat, and soon your prick follows as she begins to deepthroat you.\n\n", false);

				outputText("Like your last visit, she facefucks herself on you, treating her mouth the way you've come to expect – acting as her only and favorite sex organ. Ravenous and depraved noises arise from your lap, the fellatrix finding intense pleasure in sucking on your " + player.cockDescript(x) + ". You can barely focus on it however, as your world increasingly consists of the raw sensation. Thinking on those plump, gorgeous lips helps keep your mind from floating away into bliss too soon. Her throat squeezes you possessively, tighter than a cunt and hotter than a forge. That wonderful tongue contorts itself around you, more worshipper than body part. Those fat black cocksuckers cling to you as though you'd run away without them. Even without looking, you can imagine them forming a succulent, seductive O, a single trail of saliva between them in the waiting cunt...\n\n", false);

				outputText("Your knot presses past her lips, the ravenous maw feeding on your lap demanding all you can give her. You are all too happy to give it up. Even now you remember the ache from not pushing your swollen knot into her mouth the first time you met her. Her fingers dig into your thighs as she rapidly bounces on just this small portion of your " + player.cockDescript(x) + ", her throat gulping deeply around everything inserted in it. Her hair bounces so wildly it threatens to burst out of her bun. The swelling of your knot tells you what you already know – it will not be long before you paint Dominika's throat in your sticky fucksludge. Eventually your bucking hips seize and tremble as the first sticky load flings itself into her waiting maw. Her mouth buries itself into your lap as she drinks of your spunk, swallowing everything you give her and not letting a single drop through her plump, moist lips. Your knot feels like it might be as large as your head, so blissful and overwhelming the sensations below are. You cum until you can't cum anymore, and even then your orgasm persists until she delicately kisses your lips.\n\n", false);

				outputText("\"<i>As always, delicious,</i>\" she smiles, relaxing with you in the afterglow of her meal. She caresses you until you regain your strength, and then politely helps you re-dress and sends you on your way, giving you a kiss to remember her. Those black lips linger in your mind as you walk the streets of Tel'Adre.", false);
			}
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00156]++;
		}
		//Horsecock suck
		else if (player.cocks[x].cockType == CockTypesEnum.HORSE) {
			// - first time horsesuck
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00174] == 0) {
				outputText("The smile that spreads across her face might have looked sinister on someone else. She takes your hand and guides you to the other room, licking her lips. Within rests an extraordinarily comfortable-looking bed, featuring a level of finery you had nearly forgotten existed. The cabalist leads you to it, and helps you sit down. \"<i>Yeah,</i>\" she smirks, \"<i>I figured you might say yes.</i>\" She reaches down to remove the bottom of your " + player.armorName + ", before chuckling lightly at the sight of your " + player.cockDescript(x) + ". \"<i>Oh yeah?</i>\" she says, \"<i>Do they call you the Icathian Stallion?</i>\"\n\n", false);

				outputText("You blink in confusion at her. \"<i>...You know, like... it's a nickname from... you know what, never mind.</i>\" She waves her hand dismissively and smiles. \"<i>I'm sure no matter how uninformed you are, you still blow a load.</i>\" Her hands reach down to slowly rub against the stiffening " + player.cockDescript(x) + ", eager to have its fun with the topless arcanist standing before it. There's a comfortable softness to her thumb as it plays over your flared tip. She settles down to kneel before you, continuing to stroke your " + player.cockDescript(x) + " and entice it into a much fuller form. Even just this close you can begin to feel her breath emanating from between those luscious, deeply-coloured lips. The warmth of the sensation is seductive, carrying promises of what is yet to come. Your " + player.cockDescript(x) + " practically leans towards her in anticipation.\n\n", false);

				outputText("A single finger traces along the rim of the excited " + player.cockDescript(x) + ". Pulsing and hungry you grunt a little as a portion of pre-cum begins to form, slipping down from the cumslit. Your tattooed companion leans forward, catching it with her tongue before it slides down your shaft, and snapping it back into her mouth. A light smile tugs at the edge of her dark lips in turn. \"<i>Glad to see you're of some use,</i>\" she muses. Her fingers slip away from your head and stroke along the length of your prick instead, not wanting to get in the way of her intent. Once more her tongue touches the flat head of your " + player.cockDescript(x) + ", dragging up from the bottom and across your cumhole before flicking calmly off the top.  Then her lips touch you.\n\n", false);

				outputText("You nearly melt. You've had blowjobs before. You've kissed lips, put your fingers on them, had them brush across your cheek. You know what lips feel like. The ones resting on the top of your " + player.cockDescript(x) + " have a softness, a plumpness, and a fullness to them you can barely process. Immediately you take a breath and then let out a groan. You feel rather than hear her chuckle against your dick, each motion of those dark pillows rubbing across you as they pull in a slight smile. Stammering out some degree of praise (though with how distracted you have abruptly grown you're not sure that you even formed a coherent sentence) you grind your " + player.cockDescript(x) + " forward in hopes of pushing past the simple kiss that graces your top. Those pursed lips remain steadfast in their act and press lightly to your cumslit, before widening slightly and flicking her tongue against it.\n\n", false);

				outputText("Moaning once again, your hands come forward to stroke through her hair and encourage her, but you are abruptly surprised by the slapping of your wrists. \"<i>Down,</i>\" Dominika says to you, her fingers returning to stroking your base once your hands return to the bed. \"<i>This is mine to play with, not yours.</i>\" You respond the most well-spoken way you can at the moment, namely by panting slightly. Still, the thought of letting those dark lips act upon you is appealing. You can't come up with any compelling reasons to disobey her desires. Apparently satisfied with your passive inaction, Dominika returns her attentions to your " + player.cockDescript(x) + ", dragging those lush, gorgeous lips over your head and letting all of the sensitive flesh feel and grow enamored with them.\n\n", false);

				outputText("To your regret, they soon slip away. To your delight, they move to the side of your " + player.cockDescript(x) + ", dragging her mouth up and down the side of your prick while her palm curls around your flattened crown. She opens up her warm maw enough that her tongue can press against your engorged shaft but not so much that it covers the fat bottom lip that slides deliciously along you. You think of all the times you've had to jerk yourself off at camp and wish that you had at least had just this much more to aid you. Even without entering her, the glossy slide of her inky, pillowy cocksuckers elicits uncontrollable and desperate throbbing from your " + player.cockDescript(x) + ", alive with a need it only just developed. More pre-cum rises out of your prick, practically bubbling in its eagerness to be devoured.\n\n", false);

				outputText("Dominika fulfills its desire. Her flawless lips slide back up along the shaft, dragging themselves with a tauntingly slow speed up to the perverse summit of the " + player.cockDescript(x) + " she climbs. Her lower lip stops at the bottom of your flared head but the top presses onwards. She takes the leaked pre-cum into her awaiting mouth and more, her lip rising until she engulfs the tip of your prick. You enter her mouth  with a wet, messy noise. Spit drips down your shaft. Those lush, flawless midnight lips that you had so adored grinding against your side close around you, and it is better than you hoped. The wet warmth, the pinching suction, and the overwhelming softness make you shudder, and all the while her tongue lashes dominantly across your " + player.cockDescript(x) + ".\n\n", false);

				outputText("You find yourself obsessing over those lips, picturing them in your mind when you are forced to lean back and blur your vision in your pleasure. You stare at nothing in particular – at the walls, the ceilings, the shifting blonde bun – and as you do you imagine them, pulling at your dick and sucking it into her mouth, their ebony flawless fatness curved in an obscene O. You can imagine them engulfing and pulling on your " + player.cockDescript(x) + " so vividly, and their image is so perfectly formed and dominant in your mind that it is hard to think about anything else. It is as though those gorgeous dark lips are sucking directly on your mind – but then, given how much the needs of your " + player.cockDescript(x) + " dominate your every action, perhaps they are.\n\n", false);

				outputText("She bobs deeper, moving her head rougher. You enter her throat a few times before it becomes a far more frequent and rapid occurrence. It's difficult to remember that you're simply sitting down on the cabalist's bed, as the aggressive facefuck greatly resembles an uncontrolled rut. The act is all hers, assertively controlling your crotch with her mouth and using you for her own needs, recklessly slurping and coating your " + player.cockDescript(x) + " in her spit. She less fellates your prick than mounts it, treating her mouth as a slut's hungry cunt and aggressively claiming your crotch as a dildo for her needs. In the back of your mind you remember, though. It's not the sex she wants from you. It's your cum.\n\n", false);

				outputText("This thought proves catalyst enough for the last vestiges of control over your " + player.cockDescript(x) + " to vanish. Your mouth gapes in a deep and struggling moan, your body shaking as you lean back and let loose. The heat of your cum surges up the length of your " + player.cockDescript(x) + " and into Dominika's sucking, swallowing maw. Your prick becomes a delivery device for your thick spooge squeezed into submission by her fat, gorgeous, black, full, plush... you can barely process them. They're formed in your mind with such impossible perfection and desire. You long for them, ache for them, your entire body bucking and twisting with a desire to please the lips that curl around your base, engulfing your " + player.cockDescript(x) + " and using you, feasting on you. More, you have to cum more, you have to keep giving her everything you have. You're not even certain if you are cumming anymore, your mind locked in the brain-wiping haze of orgasm...\n\n", false);

				outputText("Softly her lips press against yours, and you start to relax. Glancing down, your " + player.cockDescript(x) + " has long since finished, and Dominika sits beside you smirking. She gently massages your sensitive shaft as you recover from the fellatio, groaning slightly. It's hard to remember those last few moments, though you feel incredible. Just the sensation of the air on your sensitive prick makes you whimper a little. \"<i>That's a good stallion,</i>\" she teases, \"<i>It's always good to remind a dick that a good mouth can do oh so much to it.</i>\" You voice your appreciation, but can't help but ask why she wanted to blow you. \"<i>Oh I told you, dear,</i>\" she laughs slightly, licking her lips, \"<i>I need to eat. Still though, even if I wanted to...</i>\"\n\n", false);

				outputText("She takes your hand and presses it to her crotch where you feel the unyielding strength of metal. She lowers her skirt slightly and you see the beginnings of a carefully crafted chastity belt. \"<i>It's alright though,</i>\" she smiles, kissing your cheek, \"<i>I enjoyed myself plenty.</i>\" She then gives an almost wicked grin, a fake expression of innocence dancing across her eyes. \"<i>Just take an hour before you try putting that in anyone else, is my advice.</i>\"\n\n", false);

				outputText("After a bit of small talk, she glances out the window, and suggests you get back to your adventuring. She kisses you once more as you go, and you taste the ebony curves on your lips as you return to the streets of Tel'Adre.", false);
			}
			//Reppppppeat
			else {
				outputText("Nearly dragged into Dominika's bedroom, she pushes you to the bed so unceremoniously you fall onto your back. \"<i>Come on then,</i>\" she purrs aggressively as she moves towards you, licking those darkly-painted lips, \"<i>Show me you're more than an infertile mule.</i>\" She climbs up on the bed and puts a foot to your chest as you try to sit up, giggling and grinning at the controlling position before shifting down to her side. She tugs the bottom portion of your " + player.armorName + " away to reveal your " + player.cockDescript(x) + ", jerking her hand along it as she glances back at you. \"<i>Keep producing the sticky glue I need and I won't have to turn you into it,</i>\" she sneers smugly. Her thumb grinds against your cumslit before pulling down and squeezing your base, replaced by her tongue and those fat, dark lips. They grind messily along the sides of your flared tip, accompanied by a casual spitting before wrapping around your meat, pulling it into her mouth.\n\n", false);

				outputText("One hand slides along your belly, gripping lightly onto your skin while casually applying some force down to your body. She clearly enjoys holding you down as she fellates you. Her dominant assertiveness is an omnipresent reminder of how she views the sexual exchange, and you obey her wishes by simply laying back and pushing your " + player.cockDescript(x) + " out, offering it to her. She takes it. Her plump and luscious cockpillows grind into various portions of your prick in twisting and changing ways, shifting your head messily around inside of her mouth. Her tongue grinds against near every inch of it while pushing it into the roof of her mouth as well as her saliva-coated cheeks. The spit spilling from her mouth drips from your shaft to her bed, and in a moment of rare and silly clarity you wonder how often she has to change her sheets. The thought passes quickly, engulfed by the familiar desire of her fat, O-spread lips. They dominate your thoughts as easily as they dominate your lap, nearly sealing around your " + player.cockDescript(x) + " and ensuring that you will not leave her mouth until she is ready for you to. The control she exhibits is wildly arousing and you happily drool pre-cum into her gulping mouth. She swallows it up at the same time as she pulls you into her throat, claiming your prick even more.\n\n", false);

				outputText("As is her way she face-fucks herself upon you, aggressively using her face as a simulacrum of the sex organ locked in chastity. Ravenous and depraved sounds rise up from your lap, the hallmarks of her lewd cock inhalations. You're not sure you have the focus to look down and watch her act, as the sensations grow more and more overwhelming. The thought of those full, gorgeous lips keeps you as grounded as you can be. Their image keeps you from breaking as her throat squeezes you tighter than a fleshlight and burns warmer than the most heated cunt. As though a supplicant before its god, her tongue bathes you in worship. All the while those lips close around you, locked tighter than her belt, keeping you with her until you give her her desires. The image of them opening up into a wide O, saliva strings dangling in that heated mouthcunt... it intoxicates you, leaving you melting for more.\n\n", false);

				outputText("Those fat full lips bounce into your base and you practically yell your moan, so delighted are you at being fully trapped within her suckling maw. Your hips buck greedily and her head meets them, sliding over you and vibrating you in her throat. The shuddering ache inside your cock – to an extent inside your being – warns you what you already knew: you will dump your load in Dominika's throat. Eventually your bucking hips seize and tremble as the first sticky load flings itself into her waiting maw. Her mouth buries itself into your lap as she drinks of your spunk, swallowing everything you give her and not letting a single drop through her plump, moist lips. Your cock feels like it has no end, a consumed part of her throat, a single entity of orgasm and feeding united in singular purpose. You cum until you can't cum anymore, and even then your orgasm persists until she delicately kisses your lips.\n\n", false);

				outputText("\"<i>As always, delicious,</i>\" she smiles, relaxing with you in the afterglow of her meal. She caresses you until you regain your strength, and then politely helps you re-dress and sends you on your way, giving you a kiss to remember her. Those black lips linger in your mind as you walk the streets of Tel'Adre.", false);
			}
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00174]++;
		}
		//Human/fallback wang
		else {
			// - first time wangsuck
			if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00151] == 0) {
				outputText("Dominika smiles, taking your hand and leading you to another room. Within is a surprisingly rich-looking bed, and she encourages you to sit down. \"<i>Thank you,</i>\" she says, and immediately follows it up with a truly wicked grin. \"<i>Now to make you realize you should be thanking me.</i>\"\n\n", false);
				outputText("She removes the bottom of your " + player.armorName + " and kneels in front of you. Taking your " + player.cockDescript(x) + " into her hands, her fingers begin a slow and steady massage along the length. She leans down and brings her lips to a soft kiss right on the tip of your " + player.cockDescript(x) + ". The glistening moisture you saw on them before feels almost unnatural, as though her lips are oiled up – but given what you've experienced in this land, such an idea does not startle you in the slightest. Her equally slick tongue slips out to press against the underside of your head and then flicks up, leaving saliva behind. The gentle touch of her palm presses against the spit and begins to spread it around. She swirls it slowly around your sensitive tip, enticing your erection further.  The ball of her thumb in particular works into the curve of your head, sliding against where it meets your shaft.\n\n", false);
				//(if player has balls)
				if (player.balls > 0) outputText("Meanwhile her mouth slips down your dick, planting a few kisses along the way before reaching your " + player.sackDescript() + ". Her dark lips press against each of your " + player.ballsDescriptLight() + " in turn, granting each her moist smooch. She exhales warmly over them, teasing the cumfactories with a grin. Her mouth slips partially over one, her tongue slipping around the soft flesh. She is gentle and delicate in her administrations, and you feel comfortable about your " + player.sackDescript() + " sitting in her warm mouth – though you would prefer she wrap those plump lips around something else. Your head continues to be stimulated by her soft palm, and now adds pre-cum to the saliva she slowly spreads. A grunt makes her smirk, lifting from your " + player.sackDescript() + " and sliding her lips slowly up your dick.\n\n", false);
				outputText("\"<i>You like this, mm?</i>\" she asks, emphasizing her question with a gentle squeeze of her hand. \"<i>To think of the path I've walked,</i>\" she muses, \"<i>Once a capable cabalist, and now I'm a better fellatrix.  Still – as long as you enjoy your work.</i>\" She leans forward and quickly slurps up a drop of pre, gulping it down visibly. The trail of spit on your shaft hides any evidence that it was ever there, leaving only her smug grin as a tribute to its existence. Still holding your prick in her hand she ducks lower, using her tongue to take long deep slurps of your " + player.cockDescript(x) + ". Teasing swirls flick across your base and her jaw rubs into the space between your thighs.  Dripping dragged paths of saliva are tracked along either side of your length, before she returns to your head.\n\n", false);
				outputText("The rush of pleasure could have staggered you if you were standing. One moment your " + player.cockDescript(x) + " was pressing into those soft black lips and moments later they had slipped around your head. She squeezes firmly with them and her tongue twists and contorts around your bulb, prostrating itself like an adherent before a god. Entering her mouth had been almost effortless. Her lips slipped apart like they were made to, while clinging to your girth like life support. A wet gulping noise accompanied a tight squeeze, her head beginning to shift around your " + player.cockDescript(x) + " in a careful and deliberate polishing.\n\n", false);
				outputText("Her hands travel along your length and roam along your thighs, squeezing them and slipping over your flesh. She seems to revel in the sensations of sucking on you, her eyes closed and her head bobbing rhythmically. The warm heat of her mouth slips along your " + player.cockDescript(x) + ", her slick lips managing to generate more than enough friction, and more than you expected. Her flesh hugs to your " + player.cockDescript(x) + " as tight as any cunt you've encountered so far, and as she begins to move her head more and more excitedly it becomes easy to forget. Only the wriggling tongue constantly rubbing and slipping along your meat and the palpable pucker of her perfect lips inform you of the fuckhole she's using to get you off.  It's difficult for your mind to not fixate on the black curves working you over. They seem as though they could truly be more comfortable, more soft and slick and smooth to slide into than anything else you've ever entered.\n\n", false);
				outputText("Her hands press to your thighs and push them apart slightly, and the reason why becomes quickly clear. She knocks your " + player.cockDescript(x) + " against the back of her  throat a few times before jamming you in, beginning to throatfuck herself on you. You gasp eagerly and move your hands up to her hair, but almost brutally she comes up and grabs your wrists, forcing you to place them on either side as she brutalizes her face on you. Spit practically flies off her chin and your shaft, dripping onto the bed and the floor. She fucks her mouth on you recklessly, acting like she was jamming a dildo into her cunt in a desperate frenzy to get off, but instead you feel her nose slamming into your crotch.  Those ebony slick suckers taunt you with how frictionless they seem to move, but they simultaneously push tightly against your skin with every inch they pass. You adore them.\n\n", false);
				outputText("The friction, the mess, and the obscenity of it all prove too much for you. Giving a strangled noise your " + player.cockDescript(x) + " throbs and starts to fire its load. She shoves herself into your lap, her lips wrapping tight around your base and her cheeks hollowing in as she sucks your load out. Her hunger for your spunk feels ravenous, and it's almost as though she's tugging it directly out of you. If she had sucked this hard to begin with, perhaps she would have! Still, you can't object to her need, and you moan helplessly as your " + player.cockDescript(x) + " blasts its creamy load directly down her throat and into her belly, aching to just keep cumming. Your hips press forward, trying to insert more of your dick into those perfect black lips, almost flawlessly imagined in your mind. You want to cum, you want to keep splattering your thick spunk between those fat puckers, those immaculate dark cockpillows.  Their image dominates your mind, the thought of them curving into that wet O ripping more cum from you. Your orgasm is only enhanced by the knowledge that you can spread them into that obscene shape, helping to demonstrate every nuance of their gorgeous form.\n\n", false);
				outputText("A wet pop signals her lips slipping over your tip. \"<i>Mmm...</i>\" she purrs softly. Your hips thrust forward slightly still, your " + player.cockDescript(x) + " tense and barely even relaxing, but your orgasm still rides out, pleasure overwhelming you. Gasping and weakly thrusting to the air, you shudder with tormented delight. Did the blowjob stop? It's hard to say. Your mind still fixates on those flawless lips, imagining their plush grip on your base. It was so good. It is so good, did it stop? You have to give them more cum, their plushness, their fullness needs to be helped.  She glides her hands up your body and rises. A soft kiss to your lips and you find your body willing to stop at last, falling back against her bed and gasping. \"<i>I appreciate it, love,</i>\" she smiles, climbing up and leaning against you, running a hand along your " + player.hairDescript() + ". \"<i>You were delicious.</i>\"\n\n", false);
				outputText("She gently massages your head as you recover from the fellatio, groaning slightly. You look back down at your " + player.cockDescript(x) + ", watching it drip with saliva. \"<i>I think I gave him a bit of a workout,</i>\" she teases, \"<i>It's always good to remind a dick that a good mouth can do oh so much to it.</i>\" You voice your appreciation, but can't help but ask why she wanted to blow you. \"<i>Oh I told you, dear,</i>\" she laughs slightly, licking her lips, \"<i>I need to eat. Still though, even if I wanted to...</i>\"\n\n", false);
				outputText("She takes your hand and presses it to her crotch where you feel the unyielding strength of metal. She lowers her skirt slightly and you see the beginnings of a carefully crafted chastity belt. \"<i>It's alright though,</i>\" she smiles, kissing your cheek, \"<i>I enjoyed myself plenty.</i>\" She then gives an almost wicked grin, a fake expression of innocence dancing across her eyes. You know the insincerity in that purity now. \"<i>Just take an hour before you try putting that in anyone else, is my advice.</i>\"\n\n", false);
				outputText("After a bit of small talk, she glances out the window, and suggests you get back to your adventuring. She kisses you once more as you go, and you taste those dark curves on your lips as you return to camp.", false);
			}
			//[Follow-up Sex, player has penis]
			else {
				outputText("Once you arrive at the second-story apartment, Dominika practically pulls you into the other room, eager to suck your " + player.cockDescript(x) + ". She removes the bottom of your " + player.armorName + " and kneels in front of you. Taking your " + player.cockDescript(x) + " into her hands, she aggressively begins lapping at it with her tongue, coating it in spit. \"<i>Mmm, give me all your cum,</i>\" she purrs, giving the top of your " + player.cockDescript(x) + " a kiss as intimate as a lover's. The way her lips move is intoxicating, sliding their slippery glossy surface over every inch of your " + player.cockDescript(x) + " before engulfing the sweaty meat.\n\n", false);
				outputText("She forces your legs open and holds your hands at your side so that she can have free reign over your thrust-out shaft, hardly submissive even as she takes you in her mouth. Her lips twist from side to side as she pushes your head into every bit of her mouth, bulging out her cheeks and rubbing the roof of her mouth. Spit drips down your " + player.cockDescript(x) + ", and deep satisfied gulping noises arise from between your legs. Every inch of her mouth is warm and soft, but her plump lips close around you like a seal, letting you know that you can only leave her mouth when she is ready. The friction is electric, and you drool pre-cum into her mouth. All of it is slurped down into her waiting throat, and soon your prick follows as she begins to deepthroat you.\n\n", false);
				outputText("Like before she facefucks herself on you, treating her mouth the same way an alley whore would treat her cunt. Ravenous and depraved noises arise from your lap, the fellatrix finding intense pleasure in sucking on your " + player.cockDescript(x) + ". You can barely focus on it however, as your world increasingly consists of the raw sensation. Her throat squeezes you possessively, tighter than a fleshlight and hotter than a forge. Her tongue contorts itself around you, more worshipper than body part. Those fat black cocksuckers cling to you as though you'd run away without them. Even without looking you can imagine them forming a succulent, seductive O, a single trail of saliva between them in the waiting cunt...\n\n", false);
				outputText("You don't speak as it continues, merely grunting and gasping in the rapture that at that moment it seems only her mouth can bring. You try to push your " + player.cockDescript(x) + " deeper and deeper into her throat, trying to fuck as much of her face as humanly possible. Eventually your bucking hips seize and tremble as the first sticky load flings itself into her waiting maw. As before her mouth buries itself into your lap as she drinks of your spunk, swallowing everything you give her and not letting a single drop through her plump, moist lips. You cum until you can't cum anymore, and even then your orgasm persists until she delicately kisses your lips.\n\n", false);
				outputText("\"<i>As always, delicious,</i>\" she smiles, cuddling with you in the afterglow of her meal. She caresses you until you regain your strength, and then politely helps you re-dress and sends you on your way, giving you a kiss to remember her. Those black lips linger in your mind as you walk the streets of Tel'dre on your way back to camp.", false);
			}
			flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00151]++;
		}
	}
	//[If \"<i>Yes</i>\" and penis too big to suck]
	else {
		// - first time wangsuck
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00152] == 0) {
			outputText("A surprisingly big grin spreads across Dominika's face and she takes your hand, leading you to a side room. Within is a very comfortable looking bed, and she encourages you to sit down upon the covers. \"<i>Excellent,</i>\" she says, before grinning just a little wickedly, \"<i>Now to break you upon my knee and leave you gasping for more.</i>\" You don't have words for that one. At least she's confident.\n\n", false);
			outputText("She removes the bottom of your " + player.armorName + ", then blinks in surprise. Curiously she leans forward, running her hand over your head, then lifting your " + player.cockDescript(x) + " to look closer at it. Almost adorably she opens her mouth and leans forward, apparently comparing the two, before looking back up at you. \"<i>So in retrospect I probably should have noticed that you were barely keeping this contained, but uhm...</i>\" She lets out an awkward light cough, then glances back at your dick. There's an intake of breath as she figures out how precisely she wants to say whatever she's about to say. \"<i>I don't think I can fit this in my mouth...</i>\" Tilting her head in thought as she strokes slowly along you, she eventually smirks and shrugs. \"<i>Well I mean, not that I need to.</i>\"\n\n", false);
			outputText("Her dark lips press forward, wetly moving against your cumslit in a slow kiss. That first contact is electric – their ebony curves are exactly as soft and slick as you could have wished for. Her tongue teases the hole briefly as she flicks across it. \"<i>Mm, the taste is not... undesirable,</i>\" she muses, winking at you. The slippery appendage slips out beneath your head to run along your glans, slipping between your foreskin and your flesh. You can't help but give an appreciative groan as her mouth begins its work. Her devilishly black pillows glide down the underside of your head to curl around your foreskin, pulling on it slightly before gently tugging it back. They circle slowly around the loose flesh, her chin and cheeks sliding against your " + player.cockDescript(x) + " in the process. Every last inch of foreskin finds itself gently lifted from your head, pulled away by a full, soft lip – clinging to the dark surface as it is almost adoringly. The fullness of your erection soon makes such play impossible, standing tall and proud before the tattooed acolyte.\n\n", false);
			outputText("Once more her mouth shifts, moving its attention to the curve just beneath your head. Her tongue slips and grinds along the flare of your rod. \"<i>You don't get to bathe much as an adventurer, do you?</i>\" she muses as she does so. You're not sure how to take the comment.  Her lips occasionally close against your skin, sucking and kissing briefly. \"<i>I can taste all the grime and musk on you.</i>\" She purrs briefly, letting you know that she was not insulting you – this too then, was not undesirable to her. She takes long drags of her tongue along your flesh, before moving in close and grinding her dark, perfect lips from side to side across your " + player.cockDescript(x) + ". You can't help but watch them, entranced. The way those curving pillows of flesh tease you is incredible. More blood than ever seems to rush into your " + player.cockDescript(0) + ", or perhaps your lust for them makes it more palpable.\n\n", false);
			//(if balls)
			if (player.balls > 0) outputText("While her mouth performs its work, you can't help but become aware of sensation elsewhere. One hand presses to your " + player.ballsDescriptLight() + ", rolling in slow circles across them. The touch is slow, gentle – but at the same time firm. You get the sense she's inquiring about them, handling them like a customer examining fruit. Well, let her handle you how she wants, as long as it feels this good. Her slender fingers slip along the wrinkles as if massaging them out, while her thumb presses at the front of your sac just firmly enough to ensure you don't slip away. The touch is taunting, even more so when the delicate and barely felt slip of her fingernails crosses your sac, but she thankfully makes no attempts to harm you. You know you can trust those dark lips.\n\n", false);
			outputText("She shifts slightly, arcing her back a bit more to bring her breasts into greater visibility. Pressing forward she begins to rub the soft flesh over your shaft. Occasionally her nipple brushes across your veiny girth, sending a brief but agreeable little blush of pleasure. Your prick's sweat serves as suitable lubrication for the slow glide of her breasts, slipping against but not around your meat. Her back rocks repeatedly to grind her tits along you, in turn letting your " + player.cockDescript(x) + " rub against her collarbone. The delicate fingers of her hand coil around your rod to rub her palm over your head, and after giving you another wet lick Dominika looks up at you.\n\n", false);
			outputText("\"<i>You'll give me a nice, big load with this big dick, right?</i>\" she purrs, licking those fat black cockpillows. They glisten teasingly in the light, and you can feel blood surging through your dick in excitement. She talks near your prick, ensuring that they brush against you as she slowly enunciates each word. The passage of her throat's warm air accompanies each syllable as well. \"<i>Give me all the cum I could ever want. Just dump all that sticky, thick load between these big, dark, perfect lips.</i>\" It's difficult not to stare at her lips as she speaks, hauntingly attractive as they are. The way they drag across your skin, the glistening pleasure they offer – you can't think of any reason not to give her what she wants.\n\n", false);
			outputText("Your hips start to rock forward involuntarily, eager to rut even if you can't. A low purr comes from the back of Dominika's throat and she places those immaculate ebony puckers at your cumslit. Once again her tongue presses up against it, this time in a lewd motion that feels almost as though she were prying it open. Grinding yourself into those abundant cocksuckers feels amazing, and there is a tinge of actual regret in your mind that your " + player.cockDescript(x) + " is as big as it is. It takes little for the pleasure to override such emotions, however, and grunting you find yourself starting to pant like an animal as your release draws closer.\n\n", false);
			outputText("Her hands roaming over the girth of your " + player.cockDescript(x) + " and her tits rubbing along the base only further excite you. Though her blonde hair hides them in your mind you can perfectly picture her dark lips in their lewd O, wrapped around you and waiting for the thick ropes of your dirty spunk. You find it impossible to keep it from her any longer. Pleasure racks through your body and you hump into her mouth as you fire your load, the sensation of heavy deep slurping tugging at your head and sucking the cum as it flings into her throat. You cum, and you cum, and you cum, your mind paralyzed with rapture as you deliver your cock's sole purpose. Hips heaving and body sweating you feel as though you could go forever. Your hips press forward, trying to insert more of your dick into those perfect black lips, almost flawlessly imagined in your mind. You want to cum, you want to keep splattering your thick spunk between those fat puckers, those immaculate dark cock-pillows. Their image dominates your mind, the thought of them curving into that wet O ripping more cum from you. Some frustration grips your orgasm by the knowledge that you cannot spread them further into that obscene shape and help to demonstrate every nuance of their gorgeous form, but the incredible sensation keeps your attention even with this subdued anger.\n\n", false);
			outputText("Softly her lips press against yours, and you start to relax. Glancing down your " + player.cockDescript(x) + " has long since finished, and Dominika sits beside you smirking. She gently massages your head as you recover from the fellatio, groaning slightly. You shiver at the sensation on your over-sensitive prick. \"<i>I think I gave him a bit of a workout,</i>\" she teases, \"<i>It's always good to remind a dick that a good mouth can do oh so much to it.</i>\" You voice your appreciation, but can't help but ask why she wanted to blow you. \"<i>Oh I told you, dear,</i>\" she laughs slightly, licking her lips, \"<i>I need to eat. Still though, even if I wanted to...</i>\"\n\n", false);
			outputText("She takes your hand and presses it to her crotch where you feel the unyielding strength of metal. She lowers her skirt slightly and you see the beginnings of a carefully crafted chastity belt. \"<i>It's alright though,</i>\" she smiles, kissing your cheek, \"<i>I enjoyed myself plenty.</i>\" She then gives an almost wicked grin, a fake expression of innocence dancing across her eyes. \"<i>Just take an hour before you try putting that in anyone else, is my advice.</i>\"\n\n", false);
			outputText("After a bit of small talk, she glances out the window, and suggests you get back to your adventuring. She kisses you once more as you go, and you taste the ebony curves on your lips as you return to your camp.", false);
		}
		else {
			//[Follow-up Sex, player has Too Big penis]
			outputText("Once you arrive at the second-story apartment, Dominika practically pulls you into the other room, eager to suck on your " + player.cockDescript(x) + ". She removes the bottom of your " + player.armorName + " and kneels in front of you. Taking your " + player.cockDescript(x) + " into her hands, she aggressively begins lapping at it with her tongue, coating it in spit. \"<i>Mmm, give me all your cum,</i>\" she purrs, giving the top of your " + player.cockDescript(x) + " a kiss as intimate as a lover's. The way her lips move is intoxicating, sliding their slippery glossy surface over every inch of your " + player.cockDescript(x) + " before messily pressing to the top in a wide O.\n\n", false);
			outputText("She pushes your legs open and forces your " + player.cockDescript(x) + " to stand prominent, as though offering it up to her. Any attempt to hold on to her or guide her is quickly rebuffed, slapped away with her own hands. There is nothing submissive about her position. Her lips twist from side to side around your head, messily spilling warm drool down your prick. Your cumslit rubs against the roof of her mouth, against the inside of her cheek, tantalized and tormented by the wet flesh within. She gulps and sucks on your " + player.cockDescript(x) + " even with your limited entry, pulling on the flesh in a ravenous, sensual hunger. She fucks her mouth the best she can on your tremendous girth, only causing an increasingly wet mess.\n\n", false);
			outputText("Soon her hands and her tits comes to bear against your flesh, grinding up and around your veiny and oversized " + player.cockDescript(x) + ". They make use of the dripping spit along your shaft to slip and rub faster against your phallus, relying on soft aggressive friction to get you gasping. It succeeds, your mouth hanging open as you moan in pleasure, rocking your hips forward as though you could descend further into those darkly vibrant and beautifully plump cocksuckers, but even through your bliss you can feel them stretched to their limit. You can imagine them perfectly in your mind, in an ebony immaculate O, and the imagery is too much for you.\n\n", false);
			outputText("Your bucking hips seize and tremble as the first sticky load flings itself into her waiting maw. Her hands grip you with a possessive tightness, stroking along your " + player.cockDescript(x) + " as though coaxing every last drop out – and indeed, you give her every last drop you can, cumming until you can't anymore. Even then the orgasmic pleasure lingers in your mind, and you can't stop rocking your hips forward in a desire to let it continue. She slips away from your prick, finally rising up to kiss you on the lips. The touch of those dark puckers relaxes you, and you come down from the pleasure with a low, happy groan.\n\n", false);
			outputText("\"<i>As always, delicious,</i>\" she smiles, cuddling with you in the afterglow of her meal. She caresses you until you regain your strength, and then politely helps you re-dress and sends you on your way, giving you a kiss to remember her. Those black lips linger in your mind as you walk the streets of Tel'Adre on your way back to camp.", false);
		}
		flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00152]++;
	}
	player.orgasm();
	dynStats("lib", -1, "sen", 1);

	if (timesFellatrixSucked() >= 4 && flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00175] == 0) doNext(dominidrama);
	else doNext(camp.returnToCampUseTwoHours);
}







//[Agree with her]
private function agreeWithDominika():void {
	spriteSelect(58);
	clearOutput();
	//(Corruption increases)
	dynStats("cor", 2);
	if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] > 0) {
		outputText("You pause for a moment, then nod. Dominika's lips curl in a grin that manages to be both sinister and playful at the same time, running a hand over your shoulder before suddenly and aggressively straddling your lap. She bends down to you, biting your lip just barely lightly enough to not draw blood. Her hand caresses down the side of your head and your neck almost possessively.  The action turns into a kiss of some small passion, the smell of your crotch still fresh on her breath as those slippery ebon pillows graze over your own inferior display. She breathes heavily over you, looking in your eyes and filling your vision with her own blue eyes.\n\n", false);

		outputText("\"<i>I knew you were strong when I saw you,</i>\" she purrs softly. Though the folds of her skirt cover the belt you can feel its steel firmness pressing into your lap. \"<i>And through you, I can recover the strength stolen from me.</i>\" Her hand runs along your " + player.hairDescript() + " before she climbs off you, glancing out the window. \"<i>You should go though,</i>\" she says, \"<i>It's late.</i>\" There's a pause, before she says something she's never said before. \"<i>I look forward to seeing you again.</i>\"\n\n", false);

		outputText("You think about her lips on the streets of Tel'Adre.", false);
	}
	else {
		outputText("You look at her for a moment, then nod.  Dominika's lips curl in a grin that manages to be both sinister and playful at the same time, running a hand over your shoulder before suddenly and aggressively stepping forward.  She presses you against the wall and ", false);
		if (player.tallness < 64) outputText("leans down", false);
		else outputText("pushes herself up", false);
		outputText(", biting your lip just barely lightly enough to not draw blood.  Her hand caresses down the side of your head and your neck almost possessively.  You can feel her knee pressing in between your legs, grinding into your ", false);
		if (player.hasCock()) outputText(player.multiCockDescriptLight(), false);
		else if (player.hasVagina()) outputText(player.vaginaDescript(0), false);
		else outputText("groin", false);
		outputText(".  The action turns into a kiss of some small passion, the smell of your crotch still fresh on her breath as those slippery ebon pillows graze over your own inferior display.  She breathes heavily against you, looking in your eyes and filling your vision with her own blue eyes.\n\n", false);

		outputText("\"<i>I knew you were strong when I saw you,</i>\" she purrs softly.  Though the folds of her skirt cover the belt she is close enough that you can feel the firmness of its steel pressing against you.  \"<i>And through you, I can recover the strength stolen from me.</i>\"  Her hand runs along your " + player.hairDescript() + " before she relaxes off you, glancing out the window.  \"<i>You should go though,</i>\" she says, \"<i>It's late.</i>\"  There's a pause, before she says something she's never said before.  \"<i>I look forward to seeing you again.</i>\"\n\n", false);

		outputText("You think about her lips on the streets of Tel'adre.", false);
	}
	dynStats("lus", 25);
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//[Non-committal]
private function ehhhhDominika():void {
	spriteSelect(58);
	clearOutput();
	outputText("You make a small grunt, not even sitting up. Dominika's eyebrows lower after a time, and a bored but amused expression comes to her features. \"<i>I suppose I shouldn't bother asking you anything after we're done, mm?</i>\" She seems content to amuse herself with this telling of events, and you don't question it. \"<i>Well, you should get going soon,</i>\" she says, turning back to her mirror and adjusting her hair. \"<i>You don't want to walk through the desert too late at night. Do visit again.</i>\"\n\n", false);

	outputText("On the streets of Tel'Adre, you think on what she said. It was not exactly what you had expected to come from that inky pout. You had shown up for a blowjob, not... whatever that was. Was that how Dominika felt? Was she hiding this from people? What did she mean by the Covenant keeping her chained? You have trouble deciding if these are questions worth answering, or if you should simply wash your hands of the entire business.\n\n", false);

	outputText("Still, that was some magnificent oral. You idly recall the sensations of those dark lips as you walk through Tel'Adre.\n\n", false);
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] = 2;
	doNext(camp.returnToCampUseOneHour);
}
//[Disagree with her]
private function disagreeDominika():void {
	spriteSelect(58);
	clearOutput();
	//(Corruption decrease)
	dynStats("cor", -2);
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] = 3;
	if (flags[kFLAGS.NUMBER_OF_TIMES_MET_SCYLLA] > 0) {
		outputText("That seems like a ridiculous thing to say, and you tell her so. Her nose wrinkles slightly and she seems to hold herself a little higher. \"<i>Well, it's the sort of thing you ponder,</i>\" she says after a short wait. \"<i>The city has... many who don't pull their weight.</i>\" She offers a half-smile, then turns back to her mirror, fixing her hair once more. You get the sense that she's not interested in pursuing the conversation.\n\n", false);

		outputText("On the streets of Tel'Adre, you wonder about what she said. Should you tell someone about that? You're not certain how much of it was bluster and how much was genuine malice. There seems to be far more to the sorceress-fellatrix than you first thought, but you're not sure you want to learn the rest. You don't want to push an issue without justification, though...\n\n", false);

		outputText("Conflicted, you find yourself walking away from Dominika's apartment without ever thinking about her lips for the first time.", false);
	}
	else {
		outputText("That seems like a ridiculous thing to say, and you tell her so.  Her nose wrinkles slightly and she seems to hold herself a little higher.  \"<i>Hmm. I suppose I may have had the wrong idea about you,</i>\" she says after a short wait.  \"<i>You seemed... It's not important, I suppose.  These are just the idle thoughts of frustration one has in this realm.  I'm sure you've felt similar.</i>\"  She offers a half-smile, then turns back to her mirror, fixing her hair once more.  You get the sense that she's not interested in pursuing the conversation.\n\n", false);
		outputText("On the streets of Tel'adre, you wonder about what she said.  Should you tell someone about that?  You're not certain how much of it was bluster and how much was genuine malice.  There seems to be far more to the sorceress-fellatrix than you first thought, but you're not sure you want to learn the rest.  You don't want to push an issue without justification, though...\n\n", false);
		outputText("Conflicted, you find yourself walking away from Dominika's apartment without ever thinking about her lips for the first time.", false);
	}
	doNext(camp.returnToCampUseOneHour);
}


//[Dream after above scene]
public function fellatrixDream():void {
	spriteSelect(58);
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] += 3;
	outputText("Breathing heavily, you cut through foliage so dark it seems as though you're splitting the night itself. Only the blinking of stars above betrays that you have not stepped directly into the sky. You feel cold, nude, and alone. There is no one for you this far into the woods, no parent to lift you up and carry you to safety, no lover to hold you within her embrace when you are scared. There is only you and the darkness, your enemy and your only companion.\n\n", false);

	outputText("Dominika inhales, and parts the bushes between you. Though blindfolded, she extends her hand to you, bidding you across the new path. Your eyes wander to the space between her legs, dripping the night and hiding her crotch in treacherous wisps. \"<i>Cum to me</i>,\" she says with lips blacker than the sky. Part of your body rebels, says you have needed no one so far, but the flesh insists. You take a staggering, heavy step towards her.\n\n", false);

	outputText("She is the sky and the sorceress, suns burning in her eyes but stolen of all light. Stars blink out within her lips. Each staggering step brings you closer, until you trip and fall up into their awaiting darkness. You try to lift and reach out but the tar clings to you, drags your limbs back in as you fight. Surrender would be easier. Looking up into the planet, antediluvian tentacles break from the crust and curve slowly towards you, sucked into the tar pit like yourself. It climbs higher, or you sink lower, or both, and you wonder if you will suffocate when it swallows you.\n\n", false);

	outputText("As the weight of the tar covers your eyes the stars above blink into sight. Panting, you realize you have returned to your campsite, sweaty and uncomfortable with the fire burnt out. The dream is over, memories of it already fading. You remember lips, and stars, and the crushing weight of the darkness.\n\n", false);

	outputText("You think you preferred the dreams about the factory.", false);
	doNext(playerMenu);
}


//[After UNKNOWN CRITERIA, CAN TRIGGER AFTER POST-SCYLLA SCENE, ONE-SHOT, HAPPENS AFTER DOMI SCENE]
private function dominidrama():void {
	clearOutput();
	outputText("You yawn a little as you walk through Tel'Adre, heading back to the gate. It's been a little while, you should check on your campsite. For a little bit you're self-conscious about walking as funnily as you are (a part of you imagines you are hanging lower than ever after how hard Dominika sucked you), but you remind yourself of the reality of the city, and presume no one will really notice or care. The night is beginning, the stars blinking slowly into sight. Glancing up at the darkening sky you're briefly reminded of the cabalist's dark lips, though you're not entirely sure why. Or perhaps you were thinking of them anyway.\n\n", false);

	outputText("\"<i>Pardon me,</i>\" an unfamiliar voice says, interrupting your thoughts. \"<i>Might I have a word?</i>\" You look over at the speaker, and find that once again the demon realm can surprise you with new sights.\n\n", false);

	outputText("The woman before you (presuming it's a woman, of course – you have learned by now to never be certain until you see their naked body) has a face unlike any you've seen before. Immediately you think to yourself, \"<i>she is a plant</i>\", and as you take in her appearance you don't see any contrary evidence. Her skin shifts between browns and muted greens, and branches grow crooked and straight from the back of her head, dying leaves dangling from them. You realize as you look at her that indeed, she looks as though she is grown from various points on her body, plantlife twisting and forming out from it. You recognize quickly that her shoulder has grown her arm, which in turn has grown leaves to make form and shape around it. Her face has multiple such points, meeting imperfectly in her features – her nose slightly squished, her lips split into two sections that touch at the middle. Still though, she has an ethereal beauty to her. Abnormally plush and full moss wraps around the back of her neck and down her chest like a coat's fur lining, hiding her large breast's nipple. Or perhaps the leaves covering her arms and chest are clothing and not skin? It's impossible to tell. You are certain that the flowing skirt growing from her hips is clothing at least, for you can see the hint of a leg. She shifts her weight onto it and clears her throat, and you realize how much you've been staring and taking her body in.\n\n", false);

	outputText("\"<i>Yes, hello,</i>\" she says once she's regained your attention, smiling politely. \"<i>Apologies for interrupting but there's a matter of some concern among us and any help is appreciated.</i>\" You blink and ask her who 'us' is. \"<i>Us. Tel'Adre. The Covenant.</i>\" She smiles again, glancing up at the sky. There's a slight glow to her eyes, almost reflecting the growing night.\n\n", false);

	outputText("\"<i>We think that there may be someone in Tel'Adre who... is not supposed to be,</i>\" she continues. \"<i>She looks rather human, blonde, dark lips. As far as I'm aware, she goes by 'Dominika'.</i>\" Hearing the name brings her to mind, her pale body covered in tattooes, and those dark lips, leaning towards you. You can almost imagine them pursing in a gentle shush.\n\n", false);

	outputText("\"<i>Have you heard of anyone fitting that description?</i>\"\n\n", false);

	doYesNo(dominidramaYes,dominidramaNo);
}

//[Yes]
private function dominidramaYes():void {
	spriteSelect(58);
	clearOutput();
	outputText("You have a few guesses as to why the Covenant might be looking for Dominika, and you want to help them. You look back up the road to explain where she's living but as you look at the streets you have an odd feeling in the back of your head. Try as hard as you might, every time you try to picture the path you took to her home all that appears in your mind is her smirking lips. They are gorgeous, but this is not the time you want to be thinking about them.\n\n", false);

	outputText("Voicing these problems, the plant woman gives a sympathetic nod. \"<i>Yes, that's... in line with what we've seen.</i>\" She raises a hand to her chin in thought, glancing you over. \"<i>If you should remember or learn anything that may help, I would ask that you come to the tower. You will not be refused if you say that Asa Mali sent you.</i>\" She pauses for a moment, then says, \"<i>That would be me, by the way.</i>\"\n\n", false);

	outputText("She sighs lightly. \"<i>And as an aside, it would probably be for the best that you not visit this woman again.</i>\" Asa looks down the street and then smiles, pats your shoulder, and leaves. You feel a strange tension in your body, as though something upsetting has happened but you cannot name what it is. Glancing up you notice a dark-feathered crow seeming to watch you from a nearby roof, but you cannot decide whether you are being paranoid in thinking it is watching you or not. You then ask yourself what a crow would possibly be doing in a desert.\n\n", false);

	outputText("Weary, you continue on your way out of Tel'Adre.", false);
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00175] = 1;
	doNext(camp.returnToCampUseOneHour);
}
//[No]
private function dominidramaNo():void {
	clearOutput();
	outputText("You think about the woman you have laid with, about her soft form, her laughter, and most of all those deep, curving lips. There's only one action you feel you could take, and you calmly say that no, you have not heard of anything or anyone fitting the description given. \"<i>I see,</i>\" the plant woman says, though her glowing eyes seem to linger on you with an uncertain meaning. She shouldn't have any reason to disbelieve you, should she?\n\n", false);

	outputText("\"<i>Well,</i>\" she says finally, \"<i>Should you acquire any information on this subject, I would appreciate it if you brought it to my attention.</i>\" She gestures to the tower that dominates the view of Tel'Adre. \"<i>I can, of course, be found at the tower. Ask to see Asa Mali and you may be let in.</i>\" She takes a moment, then elaborates. \"<i>That would be me, of course. Be well.</i>\"\n\n", false);

	outputText("She turns to leave down the street, then pauses and turns back to you. \"<i>Where are you from, anyway?</i>\" she asks, \"<i>I don't recognize your accent.</i>\" You mention your home. \"<i>Ingnam? Hmm. Never heard of it.</i>\" She shrugs lightly, then leaves.\n\n", false);

	outputText("You feel warm inside, filled with a confidence that seemed to come out of nowhere. You can imagine Dominika's dark lips in your mind smiling, opening and curving as if to say \"<i>Good work.</i>\" The thought empowers you. It feels good to protect her, you think to yourself. You stride confidently out of the city.", false);
	dynStats("lus", 10, "cor", 1);
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00175] = 2;
	doNext(camp.returnToCampUseOneHour);
}

//[Binding scene]
//Occurs after 8 servicings
private function dominikaBlowjobs():void {
	clearOutput();
	outputText(images.showImage("dominika-gives-you-blowjob"));
	var x:Number = player.cockThatFits(36);
	if (x < 0) x = player.biggestCockIndex();

	outputText("You open your eyes.  Are you lying down?  Why are you lying down?  Attempting to fight off the haze of awakening you look dimly around.  The familiar scenery takes you a moment to place it, but you soon recognize the magical markings that cover Dominika's loft.  Yes, that's right, you had spoken with Dominika at the bar, and she had invited you over, hadn't she?\n\n", false);

	outputText("That really should not have lead to you laying down spread-eagle in her room with no lighting beyond spooky glowing arcane circles.\n\n", false);

	outputText("You try to pull yourself up but an incredible weight seems to keep your limbs down.  Glancing to your hand you see no such weight, but glowing marks illuminate your palm.  The luminescent markings about your limbs would suggest that you lay within one of the room's circles, but without the ability to sit up you cannot say for certain.\n\n", false);

	outputText("Before you can demand an explanation she appears before you, so suddenly it's as though the shadows themselves conjured her.  Dominika steps out of nothingness before you, clothing discarded.  Her tattooes glow in the absence of light, curling about her body in familiar ways.  Previously unseen symbols wrap about one leg, below the uncovered chest.  The abnormal lighting sparks an unusual reflection in her eyes, like the glimmer of stars.  \"<i>Little lamb,</i>\" she says slowly.  You can see her lips move in the darkness.  Despite the light their gloss barely reflects, sitting as a deep void even in shadow.  \"<i>Little lamb of Ingnam, what do you champion now?</i>\"\n\n", false);

	outputText("You respond in the way expected of one who wakes up restrained, attempting to break the mysterious and likely magical bonds that contain you.  Dominika makes a small unreadable noise in the back of her throat.  Taking a breath the world seems to race away from you while she draws nearer, and her lips dominate your vision.  \"<i><b>Relax.</b></i>\"  She speaks the word authoritatively and precisely, carefully forming the word with her dark and full puckers.  This process continues as she speaks, pulling your vision further into the depth of her ebony mouth.  \"<i><b>You trust me. Right?</b></i>\"  ", false);
	//(Corruption less than 50)
	if (player.cor < 50) outputText("Though you still feel ill at ease restrained like this you have to admit that Dominika has never done you wrong, and you should be safe in her home.", false);
	//(OR Corruption greater than 50)
	else outputText("The restraints are somewhat erotic and exciting.  You suppose that laying here is not so bad, particularly with the sexy woman before you.", false);
	outputText("  \"<i>You trust these lips.  You've come for them, no?</i>\"  She smiles slightly at the pun.  \"<i>You would not be here if you did not trust me.  And I have always supported you, always aided you.  You can name no way that I have wronged you.</i>\"  Her toes briefly rest on your chin, shifting your head before returning.\n\n", false);

	outputText("\"<i>You have come so far,</i>\" she muses as she steps over your body.  \"<i>You have survived everything this cursed realm has dared to put in your way, and escaped... not untouched, but without surrender.</i>\"  The cabalist kneels.  Her belt is uncomfortable against your belly, but no more so than the floor to your back.  ", false);
	if (player.canFly()) outputText("Your wings barely have room to avoid being crushed.  ", false);
	outputText("\"<i>You have a strength that is lacking from this world,</i>\" Dominika continues.  Her hand runs along your cheek briefly, in something that resembles affection in name only.  Those eerily star-like eyes flicker back to your own.  \"<i><b>Give it to me.</b></i>\"\n\n", false);

	outputText("Her fingers have grown familiar to you.  They have stroked your chest, squeezed your thighs, and ", false);
	//(if penis)
	if (player.hasCock()) outputText("caressed your dick.", false);
	else outputText("caressed your labia.", false);
	outputText("  Now they curl around your chin, squeezing it and forcing you to look at her.  \"<i>If I am the moon, you will be the stars,</i>\" she hisses, \"<i>If I am the king you are the knight, and if I am the knight you are the sword.  If you are the sword then I am merchant, blacksmith, and miner.  <b>You are mine to mold and refine.</b>  If I am the rose you are the thorn.  If I am the siren, you are the rocks.  Should I be the spider, you are the web.  <b>You are a tool in my service, to defend me, to cut down what I say is to be cut down.</b></i>\"\n\n", false);

	//(if low intelligence)
	if (player.inte < 50) outputText("Her words echo in your head.  Though at first they bothered you there is a bizarre sense to them.  For reasons you cannot quite determine and yet do not care about, the fact that they are coming from those succulent, perfect lips gives them further credence.  Those statements must be true – beyond true, absolute even – if those full, gorgeous cockkissers are saying them.  You find yourself nodding along with what she says, staring and ogling her mouth.  Dominika and Dominika's lips mean the world to you in that moment, and nothing could come between you.\n\n", false);
	//(if high intelligence)
	else outputText("It's magic.  You're positive of it, you can practically feel it in the air.  It was hidden when she first started speaking, when she told you to relax, obfuscated by the twisting circles around the room.  The feeling that twists the most in the gut is the knowledge that you do not care.  You know she is ensnaring your mind – you can practically envision her lips dragging chains around you – but you trust her.  You know that the only reason you trust her right now is further magic and yet you dismiss this as a non-issue.  Worst of all even though you try as hard as you can to keep this knowledge in the forefront of your mind, every word Dominika utters pulls at your attention, demanding you surrender and let her lips engulf your mind – and you don't see a reason to deny her.\n\n", false);

	//(Penis)
	if (player.hasCock()) {
		if (player.cockArea(x) <= 36) {
			outputText("\"<i><b>You are my champion,</b></i>\" Dominika hisses slowly, trailing a finger over your lower lip.  \"<i><b>And it is my will you shall serve.</b></i>\"  With a low exhale the room settles from the warped space that had dominated the background.  You let out a staggering breath, realizing for the first time the edge you had been kept on.  Your " + player.cockDescript(x) + " aches with an uncanny stiffness, as solid as stone and as erect as a spire.  Dominika stands above you, her expression one of confidence.  An arcane circle-constellation forms in the air beneath her hand, her fingers looping through intangible curves.  \"<i>Off,</i>\" she says simply.  Piece by piece your " + player.armorName + " removes itself, at times flinging into a corner of the room.  Soon you lay before her nude and vulnerable, forcibly but willingly exposed.  \"<i><b>You will give me everything.</b></i>\" Her hand closes, the circle dissipating, and she lowers herself once more.  Down she slinks past the limited vision your magical constriction offers.  Unable to see her features you must rely on sensation to know where she lurks – and it is clear that she is lurking in your lap.\n\n", false);

			outputText("Her fingertips trail slowly down the swollen veins of your " + player.cockDescript(x) + " in a manner reminiscent of all the times you have visited her before.  You can trust her, so you must not have anything to worry about.  This will be like any other blowjob Dominika has given you.  When her tongue comes up to the underside of your prick and drags up the sweaty meat all the concerns that might have existed with the magical confinement melt away.  It must be her fetish.  You don't mind indulging her fetish, you're not an asshole.  You trust her.  You trust the dark softness of void given form as they curl around your head.  Her mouth slips fully around you and descends, skipping all foreplay.  Every inch of your " + player.cockDescript(x) + " enters her deep and hungry mouth.  The clenching heat of her throat pulls at your shaft as it slides down, swallowing around you.  Her hands no longer caress you to encourage your erection but instead clench your thighs to hold the cabalist up.\n\n", false);

			outputText("The incredible and oppressive ache that had dominated the thick stiffness of your " + player.cockDescript(x) + " is relieved in the tight fleshy confines that restrain it.  You still burn with the need for the pleasure  but it no longer seems like a darkness without end – or at least, an aid in the form of a different darkness is near.  The portal of her full lips squeezes tighter than you've felt in a long time, as though her mouth was locked as tightly around you as the belt around her waist.  Involuntarily, one of your thighs briefly spasms.  Being pinned in this position with a deep mouth pulling you in should be uncomfortable, but the sensation of flesh around your " + player.cockDescript(x) + " soaks up your focus. Dominika's lips reach your base, her mouth doing a light twist on your prick.  Your hips jerk up in shocked reflex.  Wet and thick breathing comes from between your legs before she rises.  Fingernails press painfully into your skin as she uses your helpless body for her desires.\n\n", false);

			outputText("Dominika's lips come all the way to the top of your head, tucking briefly under the bulb of your knob before she takes another deep descent.  Her ebony puckers clutch to your pole like an addict's grip on their bottle, but you sense no dependency in Dominika.  If anything, right now you need her.  You are drowning in the darkness of the barely-illuminated room and only the deep throat that swallows you can save you.  Only the thick tar of her lips can pull you under.  But if you're drowning, don't you want to...\n\n", false);

			outputText("A loud deep gulp of your " + player.cockDescript(x) + " drowns out the thought.  She dives down the length of your shaft every time, her throat so warm and tight that the air touching your spit-covered skin is almost agonizing in the chill it gives you.  Your " + player.cockDescript(0) + " spits pre-cum into her gut.  An incredible, strong suck of your prick soon accompanies it, as though she was hoping to pull the rest of your cum out right then and there.  She descends down into your lap, her plump fat lips squeezing around you, and then she sucks again.\n\n", false);

			outputText("You cum.  You didn't realize how strong, how good it could feel when she sucked.  The eruption splatters into her throat, and you imagine the strands of your cum clinging and dripping down the delicious throatcunt you're so hungry to fill.  You have to cum for her, you're so fucking horny, so eager to dump everything your balls have into her.  As she pulls off of your softening prick (the very sensation of her lips gliding off of your head fills you with a certain disappointment) and your entire body heaves with your panting, you hear her chuckle.  ", false);
			outputText("\"<i>Good " + player.mf("boy","girl") + ",</i>\" Dominika says. \"<i><b>Again.</b></i>\"\n\n", false);

			outputText("Blood surges into your " + player.cockDescript(x) + ".  Though still riding off the high of your last delicious orgasm an incredible desire engulfs and consumes you.  You want to fuck again.  No, you want to get sucked off by Dominika again.  You want to drown in her mouth, enslaved and consumed.  Your " + player.cockDescript(x) + " is so fucking sore, desperately aching for warmth and comfort.  Dominika touches her lips to your tip and in a single wet motion provides it.  The noise that slips between your lips is downright " + player.mf("emasculating","humiliating") + ", but what do you care?  The comfort that clenches back around you is worth any girlish whimpers that may have come from your throat.  Cumming in her throat will fully make up for it.  Fuck, you want to cum in her.  It would be so easy to just relax, and let your " + player.cockDescript(x) + " relax unabashedly...\n\n", false);

			outputText("You adore the feeling of the 'O' her lips make as your " + player.cockDescript(x) + " surges with cum again. Those lips are so fucking beautiful.  Immaculate.  Even as she grinds them over something as obscene and lewd as your " + player.cockDescript(x) + " they're almost impossibly beautiful.  Occasionally your thighs spasm into the hands holding them down, the raw sensation of that constant dripping wet presence around your prick overwhelming and dominating your mind, making you lose control of your muscles.  The cabalist pulls at your " + player.cockDescript(x) + " with every inch of her throat.  Her lips, tongue, throat, teeth, cheeks all take your prick with singleminded intensity, expressing no concerns other than facilitating the emptying of the cum flooding through it.\n\n", false);

			outputText("The entirety of your body feels the shudder that passes through it when you finish.  It takes a moment for you to figure out why the back of your head is sore, until you realize you let it drop down against the ground.  Or perhaps you're dehydrated? Your vision spins a little, and it's not clear what caused it.\n\n", false);

			outputText("\"<i><b>Again.</b></i>\"\n\n", false);

			outputText("Her mouth descends.\n\n", false);

			outputText("\"<i><b>Again.</b></i>\"\n\n", false);

			outputText("Your " + player.cockDescript(x) + " surges with artificial desire.\n\n", false);

			outputText("\"<i><b>Again.</b></i>\"\n\n", false);

			outputText("Matching the fall of your " + player.cockDescript(x) + " your head falls to the side, staring into space.  Drool trickles over the side of your mouth, sheer exhaustion making you slow to swallow.  Sweat drenches your body.  Dominika lets your limp prick fall to the ground, dripping her spit into a puddle for it to lay in.  You don't even want to think about using it.  You're not sure you can think about using it.  You're spent.  Empty.  Absolutely finished.  Not a drop of cum is in your body.  Dominika has completely drained you.  Your thighs ache.  Your stomach feels as though you've run a marathon while doing situps.  Are the restraints still there?  You don't know.  Moving to check seems impossible.\n\n", false);

			outputText("In most situations Dominika's stiff nipples dragging across your belly would entice you.  Now you simply cannot respond.  She lays on your chest, caressing your cheek, lowering her head to look you in the eyes.  Your vision blurs a little as you do, but she holds your focus.  \"<i>You are drained, little lamb of Ingnam,</i>\" she whispers to you, through you.  \"<i>You have nothing left.  Your body has failed you.  Your people have abandoned you.  You are alone and nothing before the infinite night.  <b>Take this emptiness, this nothingness,</b></i>\" she hisses, and you know that the darkness you see is the pitch of her lips. \"<i><b>And fill it with me.</b></i>\"  She leans in and slowly kisses your lips, letting the dirty scent of her breath rest on your face.  Even after pistoning on you over and over again her lips are intoxicatingly soft.  Her hand rests on your chin, guiding your eyes to meet hers so she knows you see her.\n\n", false);

			outputText("\"<i>Again.</i>\"", false);
		}
		else {
			//(HUGE PENIS)
			outputText("\"<i><b>You are my champion,</b></i>\" Dominika hisses slowly, trailing a finger over your lower lip.  \"<i><b>And it is my will you shall serve.</b></i>\"  With a low exhale the room settles from the warped space that had dominated the background.  You let out a staggering breath, realizing for the first time the edge you had been kept on.  Your " + player.cockDescript(x) + " aches with an uncanny stiffness, as solid as stone and as erect as a spire.  Dominika stands above you, her expression one of confidence.  An arcane circle-constellation forms in the air beneath her hand, her fingers looping through intangible curves.  \"<i>Off,</i>\" she says simply.  Piece by piece your " + player.armorName + " removes itself, at times flinging into a corner of the room.  Soon you lay before her nude and vulnerable, forcibly but willingly exposed.  \"<i>I am going to give you what you always desired, little lamb,</i>\" she says smugly, \"<i>I am going to take you inside my deep, dark, perfect lips.  In exchange, <b>you will give me everything.</b></i>\"  Her hand closes, the circle dissipating, and she lowers herself once more. Down she slinks past the limited vision your magical constriction offers.  Unable to see her features you must rely on sensation to know where she lurks – and it is clear that she is lurking in your lap.\n\n", false);

			outputText("Her fingers trace strange patterns over your " + player.cockDescript(x) + ", ones that seem both sensual and sinister.  The incredible stiffness you feel makes it difficult to focus on their actual shape, only their presence.  You are perceptive enough to realize that their increasing size is not before she drags them further across your prick, however.  It's getting smaller.  Dominika is taking the size of your " + player.cockDescript(x) + " from you.  \"<i>Just relax, little lamb,</i>\" she purrs softly, \"<i>I'll give it back.  I just need you to fit, tonight.  You want that, don't you?</i>\" she breathes hotly over your prick, dragging her fat, luscious lips over it.  \"<i>You want these around you?</i>\"\n\n", false);

			outputText("You do.\n\n", false);

			outputText("Her fingertips trail slowly down the swollen veins of your " + player.cockDescript(x) + " in a manner reminiscent of all the times you have visited her before.  You can trust her, so you must not have anything to worry about.  At last, your patience is being rewarded with the blowjob you have longed for.  When her tongue comes up to the underside of your prick and drags up the sweaty meat all the concerns that might have existed with the magical confinement melt away.  It must be her fetish.  You don't mind indulging her fetish, you're not an asshole.  You trust her.  You trust the dark softness of void given form as they curl around your head.  Her mouth slips fully around you and skipping all foreplay descends.  Every inch of your " + player.cockDescript(x) + " enters her deep and hungry mouth.  The clenching heat of her throat pulls at your shaft as it slides down, swallowing around you.  Her hands no longer caress you to encourage your erection but instead clench your thighs to hold the cabalist up.\n\n", false);

			outputText("The incredible and oppressive ache that had dominated the thick stiffness of your " + player.cockDescript(x) + " is relieved in the tight fleshy confines that restrain it.  You still burn with the need for the pleasure but it no longer seems like a darkness without end – or at least, an aid in the form of a different darkness is near.  The portal of her full lips squeezes tighter than anything you've felt in a long time, as though her mouth was locked as tightly around you as the belt around her waist.  Involuntarily, one of your thighs briefly spasms.  Being pinned in this position with a deep mouth pulling you in should be uncomfortable, but the sensation of flesh around your " + player.cockDescript(x) + " soaks up your focus.  Dominika's lips reach your base, her mouth doing a light twist on your prick.  Your hips jerk up in shocked reflex.  Wet and thick breathing comes from between your legs before she rises.  Fingernails press painfully into your skin as she uses your helpless body for her desires.\n\n", false);

			outputText("Dominika's lips come all the way to the top of your head, tucking briefly under the bulb of your knob before she takes another deep descent.  Her ebony puckers clutch to your pole like an addict's grip on their bottle, but you sense no dependency in Dominika.  If anything, right now you need her.  You are drowning in the darkness of the barely-illuminated room and only the deep throat that swallows you can save you.  Only the thick tar of her lips can pull you under.  But if you're drowning, don't you want to...\n\n", false);

			outputText("A loud deep gulp of your " + player.cockDescript(x) + " drowns out the thought.  She dives down the length of your shaft every time, her throat so warm and tight that the air touching your spit-covered skin is almost agonizing in the chill it gives you.  Your " + player.cockDescript(x) + " spits pre-cum into her gut.  An incredible, strong suck of your prick soon accompanies it, as though she was hoping to pull the rest of your cum out right then and there.  She descends down into your lap, her plump fat lips squeezing around you, and then she sucks again.\n\n", false);

			outputText("You cum. You didn't realize  how strong, how good it could feel when she sucked – you couldn't, until now.  The eruption splatters into her throat, and you imagine the strands of your cum clinging and dripping down the delicious throat-cunt you're so hungry to fill.  You have to cum for her, you're so fucking horny, so eager to dump everything your balls have into her.  As she pulls off of your softening prick (the very sensation of her lips gliding off of your head fills you with a certain disappointment) and your entire body heaves with your panting, you hear her chuckle.  \"<i>Good " + player.mf("boy","girl") + ",</i>\" Dominika says. \"<i><b>Again.</b></i>\"\n\n", false);

			outputText("Blood surges into your " + player.cockDescript(x) + ".  Though still riding off the high of your last delicious orgasm, an incredible desire engulfs and consumes you.  You want to fuck again.  No, you want to get sucked off by Dominika again.  You want to drown in her mouth, enslaved and consumed.  Your " + player.cockDescript(x) + " is so fucking sore, desperately aching for warmth and comfort.  Dominika touches her lips to your tip and in a single wet motion provides it.  The noise that slips between your lips is downright " + player.mf("emasculating","humiliating") + ", but what do you care?  The comfort that clenches back around you is worth any girlish whimpers that may have come from your throat.  Cumming in her throat will fully make up for it.  Fuck, you want to cum in her.  It would be so easy to just relax, and let your " + player.cockDescript(x) + " relax unabashedly...\n\n", false);

			outputText("You adore the feeling of the 'O' her lips make as your " + player.cockDescript(x) + " surges with cum again.  Those lips are so fucking beautiful.  Immaculate.  Even as she grinds them over something as obscene and lewd as your " + player.cockDescript(x) + " they're almost impossibly beautiful.  Occasionally your thighs spasm into the hands holding them down, the raw sensation of that constant dripping wet presence around your prick overwhelming and dominating your mind, making you lose control of your muscles.  The cabalist pulls at your " + player.cockDescript(x) + " with every inch of her throat.  Her lips, tongue, throat, teeth, cheeks all take your prick with singleminded intensity, expressing no concerns other than facilitating the emptying of the cum flooding through it.\n\n", false);

			outputText("The entirety of your body feels the shudder that passes through it when you finish.  It takes a moment for you to figure out why the back of your head is sore, until you realize you let it drop down against the ground.  Or perhaps you're dehydrated?  Your vision spins a little, and it's not clear what caused it.\n\n", false);

			outputText("\"<i><b>Again.</b></i>\"\n\n", false);

			outputText("Her mouth descends.\n\n", false);

			outputText("\"<i><b>Again.</b></i>\"\n\n", false);

			outputText("Your " + player.cockDescript(x) + " surges with artificial desire.\n\n", false);

			outputText("\"<i><b>Again.</b></i>\"\n\n", false);

			outputText("Matching the fall of your " + player.cockDescript(x) + " your head falls to the side, staring into space.  Drool trickles over the side of your mouth, sheer exhaustion making you slow to swallow.  Sweat drenches your body.  Dominika lets your limp prick fall to the ground, dripping her spit into a puddle for it to lay in.  You don't even want to think about using it.  You're not sure you can think about using it.  You're spent.  Empty.  Absolutely finished.  Not a drop of cum is in your body.  Dominika has completely drained you.  Your thighs ache.  Your stomach feels as though you've run a marathon while doing situps.  Are the restraints still there?  You don't know.  Moving to check seems impossible.\n\n", false);

			outputText("In most situations Dominika's stiff nipples dragging across your belly would entice you.  Now you simply cannot respond.  She lays on your chest, caressing your cheek, lowering her head to look you in the eyes.  Your vision blurs a little as you do, but she holds your focus.  \"<i>You are drained, little lamb of Ingnam,</i>\" she whispers to you, through you.  \"<i>You have nothing left.  Your body has failed you.  Your people have abandoned you.  You are alone and nothing before the infinite night.  <b>Take this emptiness, this nothingness,</b></i>\" she hisses, and you know that the darkness you see is the pitch of her lips.  \"<i><b>And fill it with me.</b></i>\"  She leans in and slowly kisses your lips, letting the dirty scent of her breath rest on your face.  Even after pistoning on you over and over again her lips are intoxicatingly soft.  Her hand rests on your chin, guiding your eyes to meet hers so she knows you see her.\n\n", false);

			outputText("\"<i><b>Again.</b></i>\"", false);
		}
	}
	else {
		outputText("\"<i><b>You are my champion,</b></i>\" Dominika hisses slowly, trailing a finger over your lower lip.  \"<i><b>And it is my will you shall serve.</b></i>\"  With a low exhale, the room settles from the warped space that had dominated the background.  You let out a staggering breath, realizing for the first time the edge you had been kept on.  Your " + player.vaginaDescript(0) + " is possessed with an incredible heat, nearly sopping wet and almost flooding you with lusty desire.  Dominika stands above you, her expression one of confidence.  An arcane circle-constellation forms in the air beneath her hand, her fingers looping through intangible curves.  \"<i>Off,</i>\" she says simply.  Piece by piece your " + player.armorName + " removes itself, at times flinging into a corner of the room.  Soon you lay before her nude and vulnerable, forcibly but willingly exposed.  \"<i><b>You will give me everything.</b></i>\"  Her hand closes, the circle dissipating, and she lowers herself once more.  Down she slinks past the limited vision your magical constriction offers.  Unable to see her features, you must rely on sensation to know where she lurks – and it is clear that she is lurking in your lap.\n\n", false);

		outputText("\"<i>Mm, you've kept yourself so pure,</i>\"  Dominika purrs over your crotch.  You can feel the breath coming from her mouth.  Her fingers trail slowly over your labia, quietly tracing the lines of your " + player.vaginaDescript(0) + ".  \"<i>Well, relatively speaking,</i>\" she adds.  You think you can feel her smirk.  \"<i>You don't have some quartet of tentacles writhing about.  Just a nice, polite little pussy.</i>\"  The next sensation she torments you with is her tongue, grinding slowly up the delicate flesh between your legs.  It flicks in a slow pattern, gliding lazily around the needy flesh.  She seems to refuse to plant it inside of you, even with your needy panting begging for deeper penetration, for some penetration.  You're wildly, heatedly horny, and nothing sounds like a better solution for that than Dominika's tongue plunging into your " + player.vaginaDescript(0) + " to slap and grind along the walls of your pussy.  Her fingers slide slowly over your skin, working their way down your legs to massage against your thighs.  They press in tightly, grinding into the stiff and restrained muscles firmly enough that the psuedo-massage forces occasional muscle spasms.  Why can't she just rub those deep full lips closer?  Why does she have to tease you with this delicate touch?\n\n", false);

		outputText("\"<i>Such a pretty little flower,</i>\" Dominika purrs again.  She shifts over to the very top of your " + player.vaginaDescript(0) + " and kisses your clit carefully.  Your " + player.clitDescript() + " is sensitive enough that you can pick up on every motion the fat black flesh makes.  The wrinkles from the pucker pull slowly away as she takes the time to rub your clit over her lips, reminding you of the delicious soft sensations they provide.  Your hips arch subtly, rolling towards her in a desire to have their depths explored.   You whine and plead for more, shuddering in the circle.  As her lips pass over your skin, you feel them smirk.\n\n", false);

		outputText("Despite your desperation, the slow tantalizing whorls of her tongue return.  Your " + player.vaginaDescript(0) + " drools over it, beginning to create a puddle that the very bottom of your bum brushes embarrassingly against.  As she has been since she first placed those sinfully dark lips upon you, Dominika does not care about your needs or your whimpering desire.  Her pace is hers alone, though with the bindings pinning your body tight you could not influence it if you wanted to.  The sorceress has you.  The tip of her tongue drags itself up and down your " + player.vaginaDescript(0) + ", twisting and shifting from side to side and never quite giving you anything beyond that persistent taunting stimulation.  You long for her to give you more with those dark lips, to slip her tongue inside you or truly torment your " + player.clitDescript() + ", but she remains as she is.\n\n", false);

		outputText("Her hands roam up from your thighs, grazing above your crotch.  If her fingers teased your folds with a delicate touch, they are far more ruthless in their manner as they grind into your skin.  It serves as a sharp contrast to the insufferable gentility she continues to apply to your " + player.vaginaDescript(0) + " and a firm reminder that she could do so much more to you.  The compulsion to desire more consumes your thoughts uncontrollably.  Why must she torment you like this? Why can she not overwhelm your constrained form and flood you with the pleasure you hunger for?  Surely she wants to feed on you as much as you want to feed your lusts off her.\n\n", false);

		outputText("\"<i>You want more?</i>\" she taunts you.  Such an asinine fucking question.  She knows you want more.  She made you want more.  Were you not bound and helpless under her you would... no, you know you would whimper helplessly and beg.  Those lips enthrall you.  She barely rubs them against your " + player.vaginaDescript(0) + " just to ensure that you are perpetually reminded of them.  Their form consumes your mind.  You adore Dominika's mouth and any earlier concerns about your position have been banished.  This is what you long for.\n\n", false);

		outputText("There's no ceremony when it finally happens, though in some ways it feels like one.  You don't know how long you laid there tormented by her but you know when the torment stops.  Her tongue plunges into your " + player.vaginaDescript(0) + ", twisting inside and finding the perfect spot in seconds.  The time she's spent with your cunt is fully on display.  Your voice escapes you as your hips buck in equal parts surprise and pleasure.  Perhaps it's the sudden shift that makes you cum, the abrupt transition from tranquil touches to torrid tonguing, but you writhe helplessly in Dominika's oral grip.  Long ago you might have been ashamed of how quickly you start moaning when she shifts, but now you are only relieved that the pleasure can flood you so easily.  You're dimly aware of Dominika's mouth over you, drinking in your nectar, but the touch feels a world away.  Deep and dark pleasure – as full and consuming as the lips that engulf your mind – fills your senses.  The already dim room goes even darker as your vision swims.  Stars flicker into view above you, then blink.  Dominika's eyes gaze into yours with confidence.\n\n", false);

		outputText("\"<i>Does that feel good?</i>\" she teases you again as your orgasm continues to ride out.  Her fingers play over your " + player.vaginaDescript(0) + ", her body laying alongside you.  You couldn't get mad at her for the torment now, not with the seizing pleasure still flickering through your nerves.  The smug self-satisfaction on Dominika's features only grows.  She leans in and relaxes more next to you, resting her nose against your cheek and breathing against you.  \"<i>Such a pleasant face you have, when wracked with pleasure,</i>\" she muses, taking the time to ensure that every word she speaks results in her dark lips grazing along your skin.  The delicate flesh shifts and teases your ear.  \"<i>Let's see it <b>again</b>.</i>\"\n\n", false);

		outputText("Her middle finger presses into your " + player.vaginaDescript(0) + " and grinds firmly into the perfect spot lurking within.  You gag briefly, the pleasure from the act shocking you in its intensity.  No single finger should be able to do that with one gesture.  Your hips buck into her hand, incredible lust devouring all other feelings and leaving you singleminded in its pursuit.  \"<i>Aaand... there,</i>\" Dominika purrs against your ear.  For just a moment you recognize the touch of magic before another orgasm shudders through your body, spreading from that single point where her finger meets your cunt.  It washes over you in ripples from that touch.  Your vision drowns in darkness, your eyes losing control.  Perhaps all of you loses control.  You can't tell.\n\n", false);

		outputText("\"<i><b>Again.</b></i>\" Dominika says it before your current orgasm feels even close to finished.  Another pulse of pleasure overwhelms you, colliding and joining with the existing one.  Your body strains in the binds, muscles twitching.  \"<i><b>Again.</b></i>\"  The individual sensations are impossible to note.  They consume each other and yourself.  Drool twitches out of your mouth.  Nothing is present but the pleasure... and Dominika.  She doesn't shift from her position beside you, continuing to work her finger into your " + player.vaginaDescript(0) + ".  Her lips continue to play over your ear even when she is silent, and you must think of them as you cum.  You cannot stop yourself.\n\n", false);

		outputText("\"<i>Again.</i>\"  This time - rather than strain and yearn for more more more - your body collapses, falling into the puddle of your juices spread across the floor.  It's too much.  The pleasure is too much, too fast, too absolute.  Your " + player.vaginaDescript(0) + " feels nearly numb.  Your head lolls to the side.  Dominika's starry eyes are directly in front of yours, but you do not match her gaze.  You could not look at her if you tried.  \"<i>You are drained, little lamb of Ingnam,</i>\" she whispers to you, through you.  \"<i>You have nothing left.  Your body has failed you.  Your people have abandoned you.  You are alone and nothing before the infinite night.  <b>Take this emptiness, this nothingness,</b></i>\" she hisses, and you know that the darkness you see is the pitch of her lips.  \"<i><b>And fill it with me.</b></i>\"\n\n", false);

		outputText("Her hand trails over your belly, down to your crotch. \"<i><b>Again.</b></i>\"\n\n", false);
	}
	player.orgasm();
	dynStats("lib", 5, "sen", -15);
	//[Next]
	doNext(dominikaBlowjobs2);
}

private function dominikaBlowjobs2():void {
	spriteSelect(58);
	clearOutput();
	outputText("Groaning, you roll over, sitting up in your bedroll.  The rays of the sun hitting your face feel particularly unwelcome.  You're not sure what you drank last night, but given your hangover you must have done so.\n\n", false);
	outputText("After a lot of water, you feel a little better.  Something nags at the back of your mind, an itch you can't quite scratch but persistently remains.  You feel as though you've forgotten something important, and perhaps even essential, but cannot think of any clues as to what.  ", false);
	//[Agreed with Dominika]
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] == 1 || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00157] == 4) outputText("At the same time, you get the sense that perhaps it's for the best you did so.", false);
	//[Disagreed/Neutral with Dominika]
	else outputText("It deeply bothers you, leaving a sense of anxiety behind that you don't know how to deal with. You'll have to just hope something comes along that reminds you.", false);
	outputText("\n\nEither way, it's another day.", false);
	player.changeFatigue(-20);
	flags[kFLAGS.DOMINIKA_LAST_HYPNO_SUCK_COUNT] = timesFellatrixSucked();
	flags[kFLAGS.DOMINIKA_TIMES_HYPNO_BJ]++;
	model.time.days++;
	model.time.hours = 7;
	statScreenRefresh();
	doNext(camp.returnToCampUseOneHour);
}

//Item details:
//Spellblade [Spellblade or S. Blade]: Sword with Wizard's Staff fatigue bonus, but higher attack (7-10? idk). ALTERNATIVELY you could put some crazy additional magic effect on there but idc
//Mouseover description: Forged not by a swordsmith but a sorceress, this arcane-infused blade amplifies your magic.  Unlike the wizard staves it is based on, this weapon also has a sharp edge, a technological innovation which has proven historically useful in battle.

//[Approach Dominika post-D2 in bar, requires having used her at least once before?]
public function dominikaSpellblade():void {
	clearOutput();
	//[Approach Dominika post-D2 in bar, on Dominika's \"<i>I'm a racist bitch</i>\" list]
	if ((player.minoScore() >= 3 && player.faceType == FACE_COW_MINOTAUR && player.gender == 1) || !player.isBiped()) {
		outputText("You greet Dominika and make small talk, but as usual she seems distracted and the conversation is strained at best.  Drumming her fingers on the table and glancing outside her attention is constantly drawn away from you, and eventually she outright cuts the conversation off.  \"<i>I need to go, I'm afraid,</i>\" she says quickly, and half-heartedly adds, \"<i>It was nice talking to you.</i>\"\n\n", false);

		outputText("She exits, leaving you at the table alone.  You shrug a little and finish your drink, before noticing that she left something behind.  It looks like a wrapped sword and, while you don't know why she'd have such a thing, you figure you might as well give it back to her.  Hell, maybe she'll actually be worth a goddamn conversation afterwards.\n\n", false);

		outputText("You take the blade and head back out into the streets.  Off in the distance you can see her walking, and it takes a while to catch up with her.  Tapping her on the shoulder, you're preparing an explanation for yourself when she interrupts you with a surprisingly harsh \"<i>What?</i>\"\n\n", false);

		outputText("Holding up the sword, you mention that she left it behind and offer it back to her.  She glances at it before telling you to keep it and turning away.  Surprised, you offer again to be sure.\n\n", false);

		outputText("\"<i>I said fucking KEEP IT!</i>\" she snaps suddenly, turning again.  \"<i>Isn't it fucking CLEAR that I don't want to talk to you right now?</i>\" She draws breath sharply from the sudden outburst, then closes her eyes, rubbing the bridge of her nose.  After a few seconds she more calmly states, \"<i>While I apologize for snapping at you I am under a great deal of stress right now and would firmly prefer not to be bothered.  Thank you and good day.</i>\"\n\n", false);

		outputText("She turns back around. You're not entirely certain, but you think you hear her speak again as she leaves.  \"<i>And I don't want any help from you.</i>\"\n\n", false);

		outputText("Well, whatever.  You unwrap the sword to look at it.  It's inscribed with strange symbols and patterns which you don't entirely recognize, but which seem to be familiar.  Something in the design suggests they are magical in nature.\n\n", false);

		outputText("You wrap it again.  A free sword is a free sword.  Or a free coin, as the case may be.", false);
		//(Player receives Spellblade)
	}
	else {
		outputText("\"<i>Ah, lovely.</i>\"  The way Dominika's eyes curve makes it clear she's smiling as you approach.  \"<i>I was hoping you'd be here today.</i>\"\n\n", false);
	
		outputText("She gestures to the bartender as you sit.  She's happy to see you and she's buying you alcohol? Today is a good day.  \"<i>Been well, I trust?</i>\" she opens casually.  \"<i>Protecting your camp and your bottom?</i>\"  You're fairly confident she's smirking at that line.  \"<i>I wanted to thank you for your company of late,</i>\" the occultist says, once your drink arrives and the small talk concludes.  \"<i>It's been refreshing to talk with someone who's been interested in some degree of intellectualism.  And of course, it helps that you're able to... supply me with my unfortunate needs.</i>\"  A light chuckle comes from behind her veil.\n\n", false);
	
		outputText("\"<i>It's somewhat of a Marethian custom to give gifts once you get to know someone enough, or are interested in courting them,</i>\" Dominika continues.  \"<i>I'm sure by now you've encountered someone who feels so fondly of you.</i>\"  A thought interrupts her, and she gives another little laugh.  \"<i>Some time ago a rather broadly built man became enamored of me and presented me with - of all things - a revealing swimsuit.  As you may imagine from our talks I was not particularly smitten with the notion of diving into the water with but a single line vanishing into my buttocks and calmly rebuffed him.  Last I heard, he was still so wounded from this slight that he swore off all those who don't 'understand the need to swim'.</i>\"  She chuckles a few times, tracing a finger over the rim of her empty glass.  \"<i>Such is the social importance of the gift in this land.</i>\"\n\n", false);
	
		outputText("Reaching below the table, she pulls out something wrapped in cloth and twine.  Based on the shape you presume it to be a blade of some kind, but you're in no hurry to make assumptions - mostly because your drink isn't empty yet.  \"<i>While I have not grown up in such a culture and will hardly be so offended as to forever curse the name of all foreigners, I have endeavoured to make something that you will find useful.</i>\"\n\n", false);
	
		outputText("Holding the package in the palms of both hands, she extends it to you.  You take the offered gift and open it on the table.  Much as you anticipated it is indeed a sword, though one with strangely familiar lines and patterns engraved along its pommel and blade.  \"<i>My people found that it was best to perform magic with something that could - if necessary - also serve as a weapon on its own.  A crystal orb or stick tends to simply leave an opponent lightly bruised if employed as a weapon, rather than drawing blood.</i>\"  She reaches across the table and traces the lines on the blade with her finger.  \"<i>These inscriptions are based on the movement of the stars, and will draw power from them to enhance your magic - though admittedly given the difficulty of seeing the skies in this land, it's not as powerful as it would have been in my homeland.</i>\"  The connection to the night sky triggers the memory of where you've seen similar runes: Dominika's tattoos draw on the same iconography.\n\n", false);
	
		outputText("You grip the sword by its handle and lift it experimentally.  It's balanced well and seems functional.  \"<i>I'll admit that the blade may not be as sharp as one tempered by a blacksmith's hammer,</i>\" Dominika continues, \"<i>but it should serve your needs in sorcery no less than any other weapon.</i>\"  The magical power you can feel while wielding the weapon supports her claim.\n\n", false);
	
		outputText("Thanking her, you make a bit more small talk and idly bring up the possibility of returning to her apartment.  She chuckles a little and rests her chin on her hands. \"<i>Oh, I'm afraid I'm not hungry, and either way I need to do a little preparation for our next lesson.  Perhaps a bit later?</i>\"\n\n", false);
	
		outputText("Well, getting beer and a sword in one night is good enough you suppose, though you sure would've liked a triple combo of head in there too.  A good evening nonetheless.  You bid farewell to Dominika, thanking her once more for the drink and the blade before heading on your way.  She watches you go with an unreadable expression on her face.\n\n", false);
	}
	//(Player receives Spellblade)
	inventory.takeItem(weapons.S_BLADE, camp.returnToCampUseOneHour);
	flags[kFLAGS.DOMINIKAS_SWORD_GIVEN] = 1;
}
}
}