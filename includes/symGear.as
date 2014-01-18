//const GOTTEN_INQUISITOR_ARMOR:int = 415;
//const DOMINIKAS_SWORD_GIVEN:int = 416;

//[INTRO]
public function inquisitorRobesDiscovery():void {
	outputText("", true);
	outputText("Cutting your way through the swamps in the hopes of finding something that isn't a spider, you are pleasantly surprised when you actually succeed.  You discover what seems to be a mossy stone door in a low hillside, adorned with some sort of complex puzzle lock composed of multiple stone circles decorated with animal symbols.  You don't know what lurks beyond the door, but if adventuring has taught you nothing else it is that something cool is always behind a puzzle.\n\n", false);

	//[Intelligence less than 60]
	if(player.inte < 60) {
		outputText("Unfortunately, try as you might, you cannot seem to figure the lock out.  You spin the stone circles around multiple times to try and discern the pattern to them, but find yourself continually disappointed.  Eventually you resort to trying to listen for the sound of tumblers behind the door indicating a shifting lock.  It is not as successful as you hope.  Disappointed but not undeterred, you resolve to return to the mysterious lock at a later point, when you are more capable of handling its clever riddle.", false);
		//[Player leaves, room can be re-encountered]
		doNext(13);
		return;
	}
	//[Intelligence greater than 60] 
	outputText("While spinning the puzzle locks to try and determine the solution, you notice something curious about the repeated symbols adorning them.  Though initially you thought them to mean something in regards to where the locks were meant to sit, you begin to suspect that there is another trick to them.  Slowly working your way through the possibilities, your suspicions are confirmed: the symbols are a cipher, hiding the true answer to getting through the door.  Their rotation is a red herring, meant to obscure their nature.  If your translation is correct, the door is in fact magically sealed, and waiting for a spoken command to open: one that would never be casually spoken in its presence.\n\n", false);

	outputText("\"<i>Chastity,</i>\" you say.\n\n", false);

	outputText("The tumblers of the door spin, locking into a meaningless position.  Stone hinges scrape and rumble across the ground as the sealed entrance opens.  Stale air rushes out of the cavern.  Before you stone steps descend into the ground, and torches along the wall blaze into life.  This room may not have been touched in decades.\n\n", false);

	outputText("You descend, alert.  Dust along the floor makes it difficult to discern if there are traps within the room, but the caution is possibly unwarranted, for you reach the bottom of the stairs without incident.  A single table and a chest are the only adornments of the interior.  Upon the table a rolled piece of parchment sits.  Though you are curious about the chest, the question of what this place is remains in your mind.  You unroll the parchment and read.\n\n", false);

	outputText("<i>I have failed.\n\nI could have prevented all of the tragedy that will befall this land, if I were less arrogant.  It was my duty to root out corruption in the kingdom, and to ensure that no force could sully our name, or blaspheme against our queen.  But I was too certain of myself, too certain of what I thought to be true.  I believed that it was my duty to protect my queen from the dangerous and reckless thoughts of impure commoners and power-hungry mages.\n\n", false);

	outputText("Instead, I should have protected them from my queen.\n\n", false);

	outputText("When at last I reckoned the truth of Lethice's doings, the wheels turned too quickly to stop them.  The corruption spread through the kingdom like a famished beast.  Commoner and mage alike were swallowed by its depravity, and remade.  The demons were born, and had I possessed the foresight to watch my queen more carefully I could have stopped it.\n\n", false);

	outputText("Do not mistake me for a coward, merely a fool.  I stood against my queen when at last I opened my eyes.  I dared to raise arms against her, and call upon the brightest of white fires, blazing with the desperation of a man determined to save his nation.  I failed.  She had feasted on so many souls, gained so much disgraceful power.  Before I could even gain a foothold I had already expended my energy.\n\n", false);

	outputText("She mocked me.  Perhaps she was right to do so.  An infernal mark was seared into my body as punishment for my hubris.  \"<i>The Inedible Soul,</i>\" she declared me.  Stripped naked I was made to crawl through the city, spat and ejaculated upon, jeered at by the hedonists that now populated it.  None dared to try and change me, not with Lethice's mark upon me.  Such was my punishment.  Powerless, I watched as the land fell to the taint that it was once my duty to keep in check.\n\n", false);

	outputText("I failed to stop the demons, and Lethice.  But I am one man, and there are many more who will come after me.  Many - too many - will fall, their souls and very nature devoured by the land, and for them I will suffer.  It is not their fault that my inaction created a force greater than they.\n\n", false);

	outputText("But the demons - my former queen - are greedy.  They will expand, and conquer, and one day they will extend themselves too far.  One day a champion will challenge them.  Perhaps from another land, a stronger tribe, standing tall against the force that threatens it.  Perhaps from within our own kingdom, a hold-out, a child raised in hiding.  I do not know.\n\n", false);

	outputText("If you have found this chamber, then you are wise.  Wiser and cleverer than most.  Perhaps you have the ability to be that champion.  Though I have failed, I have taken steps to ensure that my mistakes will not be repeated.  My magic found itself limited.  Yours will not.\n\n", false);

	outputText("I have spent the last of my abilities to fashion attire suitable for a champion.  It is locked within the chest.  I am no fool - I know that it may be necessary to adapt this armor for  a body warped by corrupt powers.  It may also be necessary to deprave it, somewhat, to draw less attention to oneself in a society similarly changed.\n\n", false);

	outputText("Stand before the chest, and ask for 'Retribution' or 'Carnality'.  The last of my magic, imbued therein, will do the rest.\n\n", false);

	outputText("I dearly, sincerely hope with all my being that you are successful.  I name you the last Inquisitor of a defeated kingdom, and shed my power here.  If I am fortunate, I will live to see this land restored.  If not, it is worthy punishment for my hubris.\n\n", false);

	outputText("Marae bless.\n\n", false);

	outputText("-Inquisitor Zathul</i>\n\n", false);

	outputText("You replace the scroll and look to the chest.   Will you say one of the key words?\n\n", false);

	//if implying that Rathazul used to be an advisor to the queen before the fall, start by spelling his name correctly; else, proceed as normal
	//[Retribution] [Carnality] [No]
	simpleChoices("Retribution",retributionArmorIsCoolShit,"Carnality",carnalityArmorIsCoolShitToo,"",0,"",0,"NOPE!",noThankYouSirIDontWantAwesomeArmors);
}

//[No]
public function noThankYouSirIDontWantAwesomeArmors():void {
	outputText("", true);
	outputText("Uninterested in the proffered reward, you turn and leave the way you came.  At the entrance, you replace the moss, doing your best to conceal the portal in the event you wish to return, or at least to keep any items of power inside from the hands of hostile swamp denizens.  You may as well not have spent the effort, for as you're walking away, you hear the stones grinding and shifting behind you.  Sure enough, an inspection affirms that the door has sealed itself again.\n\n", false);
	//allows player to find again later, like the B.Sword
	doNext(13);
}

//[Retribution]
public function retributionArmorIsCoolShit():void {
	outputText("", true);
	outputText("With your word, the chest clicks.  Moving to lift the lid, you start when it does so of its own will.  Gleaming, brilliant light floods the room.  You had expected there to be a bit of showiness from the magic, yes, but having the robes actually rise up out of the chest seems excessive.  Dark red fabric stretches up as though on a mannequin - or a ghost.  Golden trim runs along its edges.  The back of the gloves feature clearly embroidered sigils that you do not recognize, but which you suspect meant something to a culture long forgotten.  It seems to be constructed primarily of two main portions - a sleeveless high-collared undershirt and skirt, and a hooded overcoat and mantle.  You gather the robes and place them in your pack to inspect further at camp.\n\n", false);

	outputText("Turning to leave, you're startled by apparitions standing between you and the stairwell.  Faceless, translucent figures wearing the same robes you just discovered watch you carefully.  You brace yourself for a fight, but one by one they step to the side.  Carefully, you continue forward.  Each one bows as you pass them.\n\n", false);

	outputText("The display makes you feel righteous.\n\n", false);
	//[Player receives: 1x Inquisitor's Robes]
	menuLoc = 2;
	shortName = "I.Robes";
	flags[kFLAGS.GOTTEN_INQUISITOR_ARMOR] = 1;
	takeItem();
}

//[Carnality]
public function carnalityArmorIsCoolShitToo():void {
	outputText("", true);
	outputText("With your word, the chest clicks.  Moving to lift the lid, you start when it does so of its own will.  Gleaming, brilliant light floods the room.  You had expected there to be a bit of showiness from the magic, yes, but having the robes actually rise up out of the chest seems excessive.  A dark red posture collar attached to sleeves floats above it as though on a mannequin - or a ghost.  The corset that rises beneath it looks perfectly fitted to you", false);
	if(player.biggestTitSize() < 1) outputText(", which strikes you as unusual given your flat chest", false);
	outputText(".  Red like dried blood, it looks devilishly tight.  A golden trim runs over the... well, the trim.  Similarly colored laces run down the back.  It connects naturally to a belt with a symbol you don't recognize emblazoned on the front, which in turn is affixed to a wavy skirt aligned to the side.  There don't actually seem to be any bottoms, and the skirt looks as though it will cover approximately nothing between your legs - but given your choice, that's probably to be expected.  A high pair of heeled boots completes the outfit, echoing a similar dark red lace along the side. You gather the ensemble and place them in your pack to inspect further at camp.\n\n", false);

	outputText("Turning to leave you're startled by the apparitions standing between you and the stairwell.  Faceless, translucent figures wearing red and gold hooded robes, similar to the outfit just discovered, watch you carefully.  You brace yourself for a fight, but one by one they step to the side.  Carefully, you continue forward.  Each one bows as you pass them.\n\n", false);

	outputText("The display makes you feel like a badass.\n\n", false);
	//[Player receives 1x Inquisitor's Corset]
	menuLoc = 2;
	shortName = "I.Corst";
	flags[kFLAGS.GOTTEN_INQUISITOR_ARMOR] = 1;
	takeItem();
}


//Item details:
//Spellblade [Spellblade or S. Blade]: Sword with Wizard's Staff fatigue bonus, but higher attack (7-10? idk). ALTERNATIVELY you could put some crazy additional magic effect on there but idc
//Mouseover description: Forged not by a swordsmith but a sorceress, this arcane-infused blade amplifies your magic.  Unlike the wizard staves it is based on, this weapon also has a sharp edge, a technological innovation which has proven historically useful in battle.

//[Approach Dominika post-D2 in bar, requires having used her at least once before?]
public function dominikaSpellblade():void {
	outputText("", true);
	//[Approach Dominika post-D2 in bar, on Dominika's \"<i>I'm a racist bitch</i>\" list]
	if((player.minoScore() >= 3 && player.faceType == FACE_COW_MINOTAUR && player.gender == 1) || !player.isBiped()) {
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
	menuLoc = 2;
	shortName = "S.Blade";
	takeItem();
	flags[kFLAGS.DOMINIKAS_SWORD_GIVEN] = 1;
}


