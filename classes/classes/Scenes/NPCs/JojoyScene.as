//This is just for me to store the Jojoy scenes for now, until a Coder comes in and can implement them.
/*
public function joJoyCampMenu():void {
		clearOutput();
		switch (rand(3)) {
		case 0:	if ((BelisaFollower.BelisaInCamp) == false) {
		outputText("You see your Drider lover, Belisa, standing next to Joy. The two seem to be discussing something in earnest, while Belisa's working on patching one of Joy's robes.\n\n"); 
		outputText("I know where you're coming from, even if I don't understand everything.\" Belisa says warmly. \"I personally wouldn't go to such extremes, Marae above, I understand your reluctance to tell them at all.\" She chuckles. \"But it seems to have worked for you. You're happier than I've ever seen you before.\" \n\n");
		outputText("Joy seems a little bashful at that. \"Well...It was an accident the first time. It wasn't...Planned.\" \n\n");
		outputText("\"Well, nobody sane would drink that...Beverage...Willingly, if they knew what it was.\" Belisa chides. \"Just consider yourself lucky that someone like" +[name] +"was there to get it removed. \n\n");
		outputText("\"Oh, I consider myself *very* lucky\" Joy teases. Belisa gently slaps the monk on the shoulder. \n\n");
		outputText("\"That's what I get for being nice to you!\" Belisa fires back, but you can tell it's just friendly teasing. You step closer, and the two turn their heads, Belisa waving at you happily.\n\n");
		outputText("\"Hello!\" Belisa says happily. \"We were just discussing-\" Joy lunges, cheeks bright red, to put her hands over the Drider's mouth, but Belisa laughs, ducking. \"Never mind!\" Joy 'chases' Belisa away, but you can tell both ladies are laughing, Joy, a bit embarassed, Belisa, amused to no end.  \n\n");
		outputText("\"Joy comes back, breathing slightly heavily, her cheeks red. \"Hello, "+[name]+", what can I do for you?\" \n\n");
		}
		else if ((BelisaFollower.BelisaInCamp) == false) {
		switch (rand(3)) {
				case 0: outputText("You walk toward the boulder where Joy usually sits, and see her cross-legged with her eyes closed.  At first, she seems to be deep in meditation, but when you approach, her mouth curls into a smile; she gets up and opens her eyes, regarding you with a warm smile.  \"<i>Hello there, [name], is there anything I can help you with?</i>\"\n\n");
						break;
				case 1: outputText("You walk up to the boulder where Joy usually sits and find her a few paces behind it. She is standing and practicing her form, gracefully moving from one pose to the next. Occasionally, her prodigous breasts get in the way, but she seems to have adapted to her new form well. As you approach her, you see her ears visibly perk up. She turns her head towards you without breaking her stance, breathing evenly as she balances on her toes. \"<i>Hello [name], is there anything I can assist you with?</i>\"\n\n");
						break;
				default: outputText("You find Joy sitting cross-legged on a flat rock, her staff leaning against her shoulder. She appears deep in thought, chewing idly on a fingernail. As you approach, she flinches, seemingly taken by surprise. She looks to you and chuckles a little, putting one hand on her hip. \"<i>Greetings, [name].  Is there something I can do for you?</i>\"\n\n");
			}
		}
		break;
		case 1: if (flags[kFLAGS.LUNA_AFFECTION] == 100) {
		outputText(" To your surprise, you see your maid, Luna's on a table, lying on her stomach, eyes closed in bliss. Joy's standing beside her, hands softly caressing Luna's slender neck. As she kneads Luna's muscles, you maid seems content, for once, to just relax.\n\n"); 
		outputText("\<i>She was complaining about muscle pain.\"</i> Joy explains. <i>\"And one of the things I learned at the monastary was how to relax muscles. Luna's been very helpful lately, so I figured she deserved some time for herself. Poor girl never relaxes.\"</i>  \n\n");
		outputText("Joy takes her hands away, and you can hear Luna's breathing slow. Within moments, she's sound asleep, and Joy carries a pillow in, gently placing it under her head and leaving your maid to rest. \n\n"); 
		outputText("<i>\"She'll only be out for an hour, knowing her.\"</i> Joy says, bemused. <i>\"She's obsessed with you, you know. Works herself silly because of it\".</i> You tell Joy that you know, and she gives you a stern glance.  <i>\"As long as you're not taking advantage of her love.\"</i> You reassure Joy that you'd never, and she smiles.  \n\n");
		outputText("<i>\"Anyways, what brings you to me today? Need a little Joy?\"</i> She winks, and you groan internally. \n\n"); 
		}
		else if (flags[kFLAGS.LUNA_AFFECTION] != 100) {
		switch (rand(3)) {
				case 0: outputText("You walk toward the boulder where Joy usually sits, and see her cross-legged with her eyes closed.  At first, she seems to be deep in meditation, but when you approach, her mouth curls into a smile; she gets up and opens her eyes, regarding you with a warm smile.  \"<i>Hello there, [name], is there anything I can help you with?</i>\"\n\n");
						break;
				case 1: outputText("You walk up to the boulder where Joy usually sits and find her a few paces behind it. She is standing and practicing her form, gracefully moving from one pose to the next. Occasionally, her prodigous breasts get in the way, but she seems to have adapted to her new form well. As you approach her, you see her ears visibly perk up. She turns her head towards you without breaking her stance, breathing evenly as she balances on her toes. \"<i>Hello [name], is there anything I can assist you with?</i>\"\n\n");
						break;
				default: outputText("You find Joy sitting cross-legged on a flat rock, her staff leaning against her shoulder. She appears deep in thought, chewing idly on a fingernail. As you approach, she flinches, seemingly taken by surprise. She looks to you and chuckles a little, putting one hand on her hip. \"<i>Greetings, [name].  Is there something I can do for you?</i>\"\n\n");
			}
		}
		break;
		case 2: if (flags[kFLAGS.NADIA_FOLLOWER] == 5) {
		outputText("You find Joy and Nadia sitting side by side, meditating. Nadia's horn is glowing, and the grass around her seems to be growing faster. Joy opens her eyes, and claps her hands once. Nadia opens hers, looking around her in surprise.\n\n");
		outputText("<i>\"Well done!\"</i> Joy exclaims. <i>\"Channeling your intentions through your horn might be basic to a born unicorn, but you've learned it quite quickly.\"</i> \n\n");
		outputText("Nadia seems a little embarassed by the praise, but she gives Joy a thumbs-up. <i>\"I'm just hoping I can focus it on my herbs. If I can do that, growing them will be much easier.\"</i> \n\n");
		outputText("<i>\"Well, you're on your way to accomplishing that. You just need some more focus, and meditation will help there.\"</i> Nadia thanks Joy for the help, and heads back to her part of camp. Joy stands, stretching her neck, before seeing you. <i>\"Oh, is there something you need?\"</i> She asks happily. <i>\"Your unicorn friend over there is delightful!\"</i> \n\n");	
		}
		else if (flags[kFLAGS.NADIA_FOLLOWER] != 5) {
		switch (rand(3)) {
				case 0: outputText("You walk toward the boulder where Joy usually sits, and see her cross-legged with her eyes closed.  At first, she seems to be deep in meditation, but when you approach, her mouth curls into a smile; she gets up and opens her eyes, regarding you with a warm smile.  \"<i>Hello there, [name], is there anything I can help you with?</i>\"\n\n");
						break;
				case 1: outputText("You walk up to the boulder where Joy usually sits and find her a few paces behind it. She is standing and practicing her form, gracefully moving from one pose to the next. Occasionally, her prodigous breasts get in the way, but she seems to have adapted to her new form well. As you approach her, you see her ears visibly perk up. She turns her head towards you without breaking her stance, breathing evenly as she balances on her toes. \"<i>Hello [name], is there anything I can assist you with?</i>\"\n\n");
						break;
				default: outputText("You find Joy sitting cross-legged on a flat rock, her staff leaning against her shoulder. She appears deep in thought, chewing idly on a fingernail. As you approach, she flinches, seemingly taken by surprise. She looks to you and chuckles a little, putting one hand on her hip. \"<i>Greetings, [name].  Is there something I can do for you?</i>\"\n\n");
				break;
			}
		
		}
		var jojoDefense:String = "N.Watch:";
		if (player.hasStatusEffect(StatusEffects.JojoNightWatch)) {
		outputText("(Joy is currently watching for enemies at night.)\n\n");
		jojoDefense += "On";
		}
		else jojoDefense += "Off";
		menu();
		addButton(0, "Appearance", joJoyAppearance).hint("Examine Joy's appearance.");
		addButton(1, "Talk", joJoytalkMenu).hint("Chat with Joy.");
		if (flags[kFLAGS.UNLOCKED_JOJO_TRAINING] == 1) addButton(2, "Train", joJoyTraining).hint("Join her in a training session.");
		addButton(3, "Meditate", joJoyMeditate);
		addButton(4, jojoDefense, jojoDefenseToggle).hint((player.hasStatusEffect(StatusEffects.JojoNightWatch) ? "Request her to stop guarding the camp.": "Request her to guard the camp at night."));
		if (player.hasStatusEffect(StatusEffects.Infested)) addButton(5, "Purge", joJoywormRemoval).hint("Request her to purge the worms from your body.");
        addButton(8, "Sex", joJoySexMenu).hint("Have some sexy time with your mousey monk.");
		addButton(14, "Leave", camp.campFollowers);
		public function joJoyAppearance():void {
		clearOutput();
			outputText(images.showImage("joy-appearance"));
			outputText("Joy shakes her head as you look her up and down, putting a hand on her hip and leaning on her staff. Her face is curvy and feminine, with thin lips and long eyelashes. Her eyes are a deep blue, equal parts wise and patient. ");
			outputText("\n\nShe's wearing monk's robes, with a thin black bikini underneath holding her - " + Appearance.breastCup(flags[kFLAGS.JOY_BREAST_SIZE]) + "s breasts in place. With every movement, you can see the soft orbs moving, but they seem to be firmly held in place. She wears her prayer beads as a belt, with athletic-looking black shorts underneath her robe. She notices you staring, and Joy giggles a little, giving you a slow twirl. As she turns, your gaze drifts lower. You see a nice handful of ass, with supportive hips that give her a very sexy hourglass figure. She's wearing knee-length leggings that shows off every muscle in her slender legs, and she walks barefoot on her mousy footpaws.");
			outputText("\n\nHer weapon of choice is an unremarkable wooden staff, which she practices with fairly regularly. You also notice her occasionally rest it between her breasts, or between her luscious cheeks, when not using it. She notices your gaze, and pulls it up slowly, trying to be sexy with it.");
			if (joyHasCock() && joySexCounter() > 0) outputText("\n\nFrom previous experience you can estimate she has a " + joyCockLength() + " inches long and " + joyCockGirth() + " inches thick dick. It looks surprisingly human, right underneath that, she has a pair of gonads that are about " + joyBallSize() + " " + (joyBallSize() == 1 ? "inch" : "inches") + " in diameter each.");
			outputText("\n\nBetween her legs sits a " + joyPussyDescript() + ". Beads of lubricant occasionally form on her pink nether lips.");
			outputText("\n\nBetween her squeezable jiggly asscheeks she has " + joyAssDescript() + ", right where it belongs.");
		doNext(genericMenu);
		}
		public function joJoyTraining():void {
		clearOutput();
		if (!player.hasPerk(PerkLib.ControlledBreath) && !player.hasPerk(PerkLib.CleansingPalm) && !player.hasPerk(PerkLib.Enlightened)) {
		outputText("Joy gives you a bright cheerful smile, \"<i>Alright [name]... let’s begin.</i>\"\n\n");
		outputText("Joy’s teaching style periodically switches between lecture and sparring.  When she explains a concept or a strike, she guides you through it, stopping you occasionally to correct a flaw in your stance, before asking you to try it on her. She is patient but firm.  She doesn’t punish you when you make a mistake, instead, corrects you and asks you to try again.  She doesn’t allow you to give up, and her teaching style, coupled with the pleasant appearance of your teacher, stops you from feeling frustrated.\n\n");
		outputText("The entire session is intense, and each brief lecture or demonstration serves as a quick break to stop your body from giving out, and help you build endurance.\n\n");
		outputText("By the end of the training session you are covered in sweat, your lungs heaving for breath.\n\n");
		outputText("As you bow to Joy, she bows back and says, \"<i>Go get some rest [name], you’ve earned it.</i>\"\n\n");
		if (player.canTrain('str', player.trainStatCap("str",80))) {
		dynStats("str", 2); //Str boost to 80
		player.trainStat("str", 1, player.trainStatCap("str",80));
		}
		if (player.canTrain('int', player.trainStatCap("int",80))){
		dynStats("int", 2); //Int boost to 80
		player.trainStat("int", 1, player.trainStatCap("int",80));
		}
		if (player.canTrain('wis', player.trainStatCap("wis",100))){
		dynStats("wis", 6); //Wisdom boost to 100
		player.trainStat("wis", 3, player.trainStatCap("wis",100));
		}
		fatigue(150);
		if (flags[kFLAGS.TIMES_TRAINED_WITH_JOJO] == 5)
		{
			trace("ADDING FIRST PERK");
			outputText("\"<i>Breathing is key.</i>\"\n\n");
			outputText("Joy’s constantly repeated words resonate within you as you realize you’ve learned to control your breathing. It takes you less time to rest than normal and you feel as though you are bursting with energy because of it.  Your [fullChest]");
			if (player.biggestTitSize() == 0) outputText(" rises and falls");
			else outputText(" rise and fall");
			outputText(" smoothly even in the heat of battle.  From now on you know you’ll recover more quickly.\n\n");
			outputText("<b>(Perk Gained: Controlled Breath -</b> Increases rate of fatigue/mana/soulforce regeneration by 20%<b>)</b>");
			player.createPerk(PerkLib.ControlledBreath, 0, 0, 0, 0);
		}
		endEncounter();
	}
	//{after the PC has gained the controlled breath perk}
	else if (player.hasPerk(PerkLib.ControlledBreath) && !player.hasPerk(PerkLib.CleansingPalm) && !player.hasPerk		(PerkLib.Enlightened))
		{
		outputText("Joy gives you a big toothy grin, \"<i>Alright [name]... let’s begin.</i>\"\n\n");
		outputText("Joy switches up the way she is instructing you.  Largely due to your increased endurance, the two of you spend more time moving through forms together and practicing strikes and maneuvers.  When it comes time for a brief lecture, she breaks out one of the few scrolls she has from her order and tells you what she knows about the contents.\n\n");
		outputText("Before too long, the two of you are up again and practicing forms and mock strikes, even sparring briefly from time to time.  By the end of the intense training session you are covered in sweat... but so is Joy, and neither of you are out of breath. As you bow to Joy she returns the gesture, her ears twitching. \"<i>Go get some rest [name], you’ve earned it.</i>\"\n\n");
		fatigue(150);
		if (player.canTrain('str', player.trainStatCap("str",80))) {
		dynStats("str", 2); //Str boost to 80
		player.trainStat("str", 1, player.trainStatCap("str",80));
	}
	if (player.canTrain('int', player.trainStatCap("int",80))){
		dynStats("int", 2); //Int boost to 80
		player.trainStat("int", 1, player.trainStatCap("int",80));
	}
	if (player.canTrain('wis', player.trainStatCap("wis",100))){
		dynStats("wis", 6); //Wisdom boost to 100
		player.trainStat("wis", 3, player.trainStatCap("wis",100));
	}
		if (flags[kFLAGS.TIMES_TRAINED_WITH_JOJO] == 10)
		{
			trace("ADDING SECOND PERK");
			outputText("The repeated movements are slowly starting to sink in, your muscles becoming accustomed to Joy’s training.\n\n");
			outputText("By the end of the training session with the mouse, you think that you may have picked up something that might help against the denizens of  her world. You tell Joy, and her eyes brighten. \"Well, let's see it!\" You plant your feet, cupping your hands together. A small ball of energy forms, passing between your hands, and as you bring your hands forward, the ball of light blue energy fires off. Joy claps in appreciation, then runs through the technique with you a few more times.\n\n");
			outputText("<b>(Ability Gained: Cleansing Palm -</b> A ranged fighting technique of Jojo’s order, allows you to blast your enemies with waves of pure spiritual energy, weakening them and hurting the corrupt.<b>)</b>");
			player.createPerk(PerkLib.CleansingPalm, 0, 0, 0, 0);
		}
		endEncounter();
	}
	//{after the PC has gained the Cleansing Palm attack}
	else if (player.hasPerk(PerkLib.ControlledBreath) && player.hasPerk(PerkLib.CleansingPalm) && !player.hasPerk(PerkLib.Enlightened))
	{
		outputText("Joy gives you a big smile brimming with pride, \"<i>Alright [Name]... let’s begin.</i>\"\n\n");
		outputText("Largely due to your increased endurance and improved technique the two of you spend more time sparring and dancing through the forms Joy knows.  When it comes time for a brief lecture, Joy pants as he sits with you, taking a minute to regain her breath.  Joy’s lectures, instead of dealing with how to strike and defend oneself, deal with the nature of the soul.  You learn much about individuality, willpower and determination and after the lecture the two of you meditate on what you’ve learned for a few silent moments.\n\n");
		outputText("Then the two of you are back up, sweeping gracefully through forms and striking invisible enemies with fierce blows.  By the end of the intense training session both you and Joy are tired, having trained to both of your limits.\n\n");
		outputText("As the two of you give each other decidedly shaky bows, Joy staggers, and you instinctively step in, catching your exhausted mentor. She leans on you for a few seconds, before shaking herself and standing back up. \"<i>Great effort [name], you are... wow... I need a rest. I’ve earned it.</i>\" The two of you share a laugh and end your training.\n\n");
		if (player.canTrain('str', player.trainStatCap("str",80))) {
		dynStats("str", 2); //Str boost to 80
		player.trainStat("str", 1, player.trainStatCap("str",80));
	}
	if (player.canTrain('int', player.trainStatCap("int",80))){
		dynStats("int", 2); //Int boost to 80
		player.trainStat("int", 1, player.trainStatCap("int",80));
	}
	if (player.canTrain('wis', player.trainStatCap("wis",100))){
		dynStats("wis", 6); //Wisdom boost to 100
		player.trainStat("wis", 3, player.trainStatCap("wis",100));
	}
		fatigue(150);
		if (flags[kFLAGS.TIMES_TRAINED_WITH_JOJO] >= 15 && player.inte >= 70)
		{
			trace("ADDING THIRD PERK");
			//{text shows after generic 16th technique training session}
			outputText("As you finish training you decide to meditate alone; returning to your " + camp.bedDesc() + ", you close your eyes and begin to breathe.  Then the world around you begins to sing.\n\n");
			outputText("The camp is alive with the sounds of voices on the wind, of the ominous sizzling of the great scar between worlds that is the portal that brought you here.  You feel open to the universe as if it were a lady in a dress sitting next to you, that you could easily reach out and touch.  You feel liberated and free despite the fact that you are not moving a muscle.  You are ready for anything but expecting nothing.  You are neither thinking nor dreaming, you simply are.\n\n");
			outputText("<b>(Perk Gained: Enlightened -</b> White magic threshold reduced. Meditation restores health. Grants the ability to meditate alone.<b>)</b>");
			player.createPerk(PerkLib.Enlightened, 0, 0, 0, 0);
		}
		endEncounter();
	}
	//{after PC has gained the Enlightened Perk}
	else
	{
		outputText("You ask Joy if she’d be willing to train you more in the ways of the Lotus. She chuckles. \"Really? You know just as much as me, [name]\". You tell her that practice is key, and she nods, as if considering your words, although you know you don't need to twist her arm to get Joy to spend time with you. She leads you back to the forest. As you follow, you notice her hips swaying more than usual. You reach a small glade with a creek running through it, and Joy stops.  \n\n"); 
		var choice0:Number = rand(2);
			switch (choice0) {
				case 0:
				outputText("“We’re here.” Joy says simply, taking a wide-legged stance. “The creek here is both fresh to drink, and creates enough ambient sound for relaxing meditation.” She has a serious look on her face. “Let’s begin.”  \n\n");
				outputText("You spend two hours with Joy, going through the forms of the lotus. Occasionally, she’ll stop, showing a form in more detail, or firing a cleansing palm into a nearby tree.  \n\n");
				outputText("After you’ve both worked up a sweat, she holds up a hand. “I think that’s enough for now”, she gasps, planting her ass on the grass. “We should head back to camp.” \n\n");
				doNext(playerMenu);
					break;
				case 1:
				outputText("“One moment”, she says simply, walking over to the water. She leans way over, her too-small robe hiking up, giving you a clear view of her bubble-butt and juicy snatch as she drinks. She seems to be taking longer than necessary, and occasionally, you notice her sneaking a peak back at you. \n\n");
		outputText(" \n\n");
					menu();
		addButton (1, "Wait", joJoyWaitforTraining);
		addButton (2, "SlapAss", joJoySlapDat);
		addButton (3, "HotDog", joJoyHotDog);
		addButton (4, "Finger", joJoyFingering);
					break;
	}
	
	}
}
public function joJoyWaitforTraining():void {
		clearOutput();
		outputText("You wait politely for Joy to finish, and she finishes her drink. She’s clearly let some of the water drip onto her breasts, and she looks mildly disappointed. \n\n"); 
		outputText("“Sorry, [Name], I was a little…Thirsty.” She plants her feet, taking a martial artist’s stance. 
“Alright, so the first form…” Joy walks you through the forms of the Lotus, occasionally stopping to ‘correct’ your posture, or telling you to hold your form so she can study it. For an hour, you go through the forms, until Joy, breathing heavily, stops for a moment. \n\n");
		outputText("“Sorry, [Name]. I…Am having a bit of trouble focusing right now. If you would excuse me for a moment…?” \n\n");
menu();
addButton (1, "Wait", joJoyJillsOff);
addButton (1, "Advance", joJoyGetSome);
}
public function joJoyJillsOff():void {
		clearOutput();
		outputText("You tell Joy to take what time she needs, and that you’ll be here when she gets back. She sighs slightly, heading off into the woods.  \n\n"); 
		outputText("You decide to meditate while Joy attends to herself, but you can hear an occasional grunt, and a moist schluck from where Joy had gone. Is she…? \n\n");
		outputText("Your suspicions are confirmed when you hear a faint, girlish cry, cut off suddenly. A few moments later, Joy strides back, a slight blush in her cheeks. You decide to ignore the very obvious fact that Joy had jilled herself off in the woods, and return to the forms \n\n");
		outputText("After another hour, you and Joy return to camp, and head your separate ways. As you leave her, Joy sighs, leaning in, and kisses you on the cheek. “I should start charging for lessons”, she jokes, before heading back to her rock. \n\n");
		if (player.canTrain('str', player.trainStatCap("str",80))) {
		dynStats("str", 2); //Str boost to 80
		player.trainStat("str", 1, player.trainStatCap("str",80));
	}
	if (player.canTrain('int', player.trainStatCap("int",80))){
		dynStats("int", 2); //Int boost to 80
		player.trainStat("int", 1, player.trainStatCap("int",80));
	}
	if (player.canTrain('wis', player.trainStatCap("wis",100))){
		dynStats("wis", 6); //Wisdom boost to 100
		player.trainStat("wis", 3, player.trainStatCap("wis",100));
	}
doNext(playerMenu);
}
public function joJoyGetSome():void {
		clearOutput();
		outputText("You give Joy a knowing grin, making her blush. Walking towards Joy, you tell her that you’ve been in Mareth long enough to know when someone’s horny. Teasingly, you tell Joy that if she wanted some, she just had to ask.  her makes your mousey lover blush even more.  \n\n"); 
		outputText("“I know that…But you asked me to train you, and here I am, acting like…some sort of demon!”  \n\n");
		outputText("You reassure Joy, telling her that she’s not acting like a demon. After all, she’s just been dropping hints…a real demon would have jumped on you already to sate their needs.  \n\n");
		outputText("Joy bites her lip, looking down at your groin. “I-I suppose so.” Her knees wobble a bit, and she puts one hand in front of her womanhood. “Would you please…Help me with that?”  \n\n");
		outputText("You ask if she wants to make love to you, and Joy, a little annoyed now, steps in, as close as she can. “No, I want you to fuck me.” \n\n");
		outputText(" \n\n");
menu();
addButton (1, "SexTime", joJoySexMenu);
}
public function joJoySlapDat():void {
		clearOutput();
		outputText("You sneakily make your way behind Joy, and before your mousey lover can react, you bring one hand back, slapping her ass with a sound that echoes through the forest. Almost as loud as the startled “Eep!” that comes out of Joy’s mouth, as she straightens up, water from her furry snout splashing onto her front. Her arms are rigid, at her side, and as she straightens up, you step in, wrapping your free arm around her waist.  \n\n"); 
		outputText("Joy turns her head, catching sight of you, and she stammers a little, face beet-red. “Wh-what was that for?” She asks, and you chuckle a little. You tell Joy that she was putting that ass of hers out a little too far for it to be a coincidence. Rubbing her asscheek, you ask Joy if that was her plan. To lure you out here and seduce you.  \n\n");
		outputText("Maybe.” Joy says slyly. “You don’t seem to be able to focus on anything else.” You tell Joy that you’d never have expected her to be  her forward, especially considering how you met \n\n");
		outputText("“Meeting you changed me, [Name]. I would have thought that was obvious.” Joy says, giving you a smouldering look. “I love you, you know.” \n\n");
menu();
addButton (1, "Next",joJoySexMenu);
}
public function joJoyHotDog():void {
		clearOutput();
		outputText("You know that Joy’s just asking for it at  her point, and you see no point in denying her. Slowly making your way towards Joy, you (if clothes) reach into your (clothing), pulling it down and revealing your [cock]. (If naked) take your own rapidly hardening [cock] in one hand.  \n\n"); 
		outputText("As you get closer to Joy, you can see that she’s already dripping wet, raring to go. You put one hand on the small of Joy’s back, gently pushing her upper body down as you run your [cock] into the crack of Joy’s bubble-butt. She gasps, looking back, and gives you a slightly shy smile, reaching her arms back towards you.  \n\n");
		outputText("“Well…You seem to have your mind set on something other than training.” Joy giggles, moving her hips slightly.  her allows her bubble butt to run up and down your shaft, sending a warm shock through you. “And you already know I want you.” You take Joy’s outstretched hands, pulling her in towards you. Your thighs hit Joy’s cheeks, and her tail swings happily, wrapping around your hips. \n\n");
		outputText("“Well…What now, love?” Joy asks whimsically. “It’s up to you.” \n\n");
		
menu();
addButton (1, "Next",joJoySexMenu);
}
public function joJoyFingering():void {
		clearOutput();
		outputText("At  her point, it’s obvious that the formerly chaste monk isn’t interested in martial arts right now. As you stealthily approach Joy’s backside, you get a mischievous idea. You lick one of your fingers, and as you close in, you wrap one of your arms around Joy’s waist, flicking her clit before you sink a finger into her sopping wet quim. \n\n"); 
		outputText("Joy gasps, leaning back into you, but you cover her mouth gently with your other hand, shushing your mousey lover as you nibble the side of her neck. You add a finger, slowly, gently teasing her with one hand, fingers dipping in and out of her folds. With each movement, you feel Joy gasp, hands grasping at you as her breathing gets heavy. After a few minutes of gentle foreplay, your own lust building, you remove your hand from Joy’s mouth, turning her around and stopping her lips again with your own. \n\n");
		outputText("Joy, eyes half-lidded, practically purrs as you pull back. “Mmm…” She looks down at your groin, your mixed saliva on her snout. “Now that you’ve got me all warmed up, now what?”\n\n");
menu();
addButton (1, "Next", joJoySexMenu);
}
public function joJoySexMenu():void {
		clearOutput();
		outputText("How do you want to sex your mousey companion? \n\n"); 
menu();
addButton (1, "Sex", joJoyRegularMenu);
addButton (2, "BimboRP", joJoyBimboMenu); //only if you've talked with her about Roleplaying
addButton (3, "Nvm", camp.returnToCamp);
}
public function joJoyBimboMenu():void {
			menu();
			outputText("\n");
			addButton(0, "Vaginal Fuck", penetrateJoysPussy).hint("Penetrate Joy vaginally with your cock.")
				.disableIf(player.cockThatFits(joyVagCapacity()) < 0, "Req. a cock fitting "+joyVagCapacity()+" area!");
			addButton(1, "Anal Fuck", fuckJoyInTheAss).hint("Take Joy from behind and make sure she gets it good!")
				.disableIf(player.cockThatFits(joyAnalCapacity()) < 0, "Req. a cock fitting "+joyAnalCapacity()+" area!");
			addButton(1, "Anal Fuck", fuckJoyInTheAss).hint("Take Joy from behind and make sure she gets it good!")
				.disableIf(player.cockThatFits(joyAnalCapacity()) < 0, "Req. a cock fitting "+joyAnalCapacity()+" area!");
			addButton(4, "Frottage", frotWithJoy).hint("Do some cock play with Joy.")
				.disableIf(!player.hasCock(), "Req. a cock!")
				.disableIf(!joyHasCock(), "She doesn't have a cock for that...");
			addButton(5, "Get Blown", haveJoySuckYouOff).hint("Have Joy suck your off and give her a taste of your cum.")
				.disableIf(!player.hasCock(), "Req. a cock!");
			addButton(6, "Get Licked", haveJoyLickYourGinas).hint("Have Joy lick your pussy.")
				.disableIf(!player.hasVagina(), "Req. a vagina!");
			addButton(7, "Get Penetrated", haveJoyStuffYourPussy).hint("Have Joy penetrate you vaginally with her cock.")
				.disableIf(!player.hasVagina(), "Req. a vagina!")
				.disableIf(!joyHasCock(), "She doesn't have a cock for that...");
			addButton(2, "Lick Joy", lickJoysGina).hint("Get a taste of Joy's pussy but you're sure she has a lot of pussy juice in store for you!");
			addButton(3, "Blow Joy", suckJoysCock).hint("Suck Joy's cock and get some taste of her cum!")
				.disableIf(!joyHasCock(), "She doesn't have a cock for that...");
			addButton(8, "Get Anal", haveJoyStuffYourButthole).hint("Have Joy take you from behind and put her cock to a good use.")
				.disableIf(!joyHasCock(), "She doesn't have a cock for that...");
			addButton(14, "Back", joJoySexMenu);
		}
public function joJoyRegularMenu():void {
		clearOutput();
		outputText("TBI \n\n");
		menu();
		addButton(14, "Back", joJoySexMenu);
}
//Village Convo
public function joJoyTalkVillage():void
{
	clearOutput();
	jojoSprite();
	flags[kFLAGS.TIMES_TALKED_WITH_JOJO]++;
	outputText("You decide to ask Joy about her village.\n\n");
	outputText("She speaks softly with a smile on her face and in her voice, \"<i>It was a small village near a large beautiful lake. We were peaceful people who laughed and trusted one another, just good simple folk you know?\"\n\n");
	outputText("\"Most of the people of Belridge were either fishers or farmers with huge families that stayed near the village. There were a few hunters and a few craftsmen. We made enemies of no one and sought to do no harm to others,</i>\" Joy says, her smile fading.\n\n");
	outputText("Before you can muster a reaction to her sadness, her fuzzy cheeks spread again as he looks up at you with bright eyes.\n\n");
	outputText("\"<i>My father was a fisherman.  He was her calm, strong man with a lot of silver  herkers that always smelled like fish. I remember I used to go out on the boat with him and a few of my brothers and he’d always make sure to pick me up and put me on her shoulders... that is until I got too big. He always made everything look so easy, like the world was just there to shake his hand and make him smile. No one could cook seafood like he did, no one.</i>\"\n\n");
	outputText("\"<i>Then there was my mother who was a little high strung, but no one could hug you more fiercely or love you more dearly.  She was a small woman with a big soul who loved her family more than anything.  She was a seamstress before she met my dad and was always the brightest one in the room, which is hard when you have seventeen loud children clamoring for your attention.</i>\"\n\n");
	outputText("\"<i>Even with 19 people living under one roof my family wasn’t the biggest family in town, but there was always plenty of work and plenty of food.  It was a nice simple existence and I am thankful for the time I had with everyone in that village,</i>\" she finishes with a serene smile.\n\n");
	if (player.cor < 40)
	{
		outputText("Looks like Joy's childhood wasn't so bad... you thank the mouse morph monk for sharing her treasured memories with you now that the conversation is over.\n\n");
	}
	else
	{
		outputText("Looks like Joy’s childhood wasn’t so bad. A little sickly sweet and void of wet pussies and drooling dicks but not bad. You tell her you’re happy to have her near you and she smiles from ear to ear, ignorant of your thoughts.\n\n");
	}
	doNext(joJoytalkMenu); // Dunno where exactly to kick back to, fuck it, back to camp yo!
	advanceMinutes(5);
}
//Joining the Monks convo
public function joJoyTalkJoiningTheMonks():void
{
	clearOutput();
	jojoSprite();
	flags[kFLAGS.TIMES_TALKED_WITH_JOJO]++;
	outputText("You decide to ask Joy why she decided to become a monk in the first place.\n\n");
	outputText("She gives you a warm smile as she speaks, \"<i>Well I grew up in a big family of 19 so when I was younger, I was always the quiet one.  I guess I was just introverted but being quiet meant that I didn’t always get a lot of attention.  It didn’t bother me, quite the opposite actually, I enjoyed quiet introspection but with so many brothers and sisters it was next to impossible to get a quiet moment at home.</i>\"\n\n");
	outputText("\"<i>So I would sneak out. My father understood but it drove my mother crazy.  Whenever she noticed I had slipped away she would stop everything in the house and take my two oldest brothers to come find me.  I never understood why it was such a big deal.  We were in a small village near a prestigious monastery, we were safe.  Parents let their kids go out and play and run and explore because everyone knew everyone but not my mom.  She had to know where you were going, what you were doing and how long until you got back. I would’ve told her but saying I wanted to explore wasn’t a satisfactory answer.</i>\"\n\n");
	outputText("\"<i>Whenever she found me she would yell for a bit and then hold me close like she’d just watched me dodge a charging rhinoceros.  Whenever she asked why I did it I just told her the truth, it was too loud and crowded at home.  After a few weeks of  her she suggested a compromise.  She said I could leave if I had one of my older brothers walk me to the temple, and I stayed there, where the clergy could see me and keep me safe and fed.  Honestly I think my dad came up with the idea, he was always good at compromising and keeping the peace.</i>\"\n\n");
	outputText("\"<i>The temple became very important to me.  I read about the world, I spoke to the clergy and I sat and thought.  I was enraptured with learning but I didn’t want to be a priest, I don’t know why... I guess it just didn’t appeal to me.  When I first saw the monks visiting the temple, it was like dawn breaking.  After that I waited until I was old enough to join and made the short pilgrimage to the Monastery of the Celestial Lotus.</i>\"\n\n");
	outputText("Joy wears her quiet little smile as she finishes.  Then she chuckles and says, \"<i>Thank you for the memories, [name]. I enjoy our talks.</i>\"\n\n");
	doNext(joJoytalkMenu);
	advanceMinutes(5);
}
//Fall of the Monks convo
public function joJoyTalkFallOfTheMonks():void
{
	clearOutput();
	jojoSprite();
	flags[kFLAGS.TIMES_TALKED_WITH_JOJO]++;
	outputText("You decide to ask Joy if she'd be willing to tell you exactly what happened to the monks of her order.\n\n");
	outputText("Joy speaks with eyes downcast and a voice soft as feathers landing on fallen soldiers, \"<i>Truthfully?...  I don’t know exactly how it happened... or why... but my order was wiped out.  Though I've looked for my brothers and sisters of the Celestial Lotus ever since then, I'm the only survivor, as far as I can tell.  You see, the demons attacked the monastery while I was away with one of the senior brothers.  I was a mere novice and he was one of the most fun teachers so we lost track of time.  The sun was setting and we were halfway back to the monastery when we saw what we thought was a huge column of smoke rising from the central building.  When we got closer we saw the cloud for what it truly was, a billowing tower of those imps.  We were spotted and several of them came flying at us - they crossed the distance far faster than we could have.</i>\"\n\n");
	outputText("\"<i>Senior Brother Logray didn't hesitate - he leapt in front of me, staff twirling, shattering skulls and breaking limbs with each sweep.  As he barred their path, he cried out to me to flee, to run for the safety of the village... and I did.  Overwhelmed by the bitter-sweet stink of corruption wafting off the demons, I ran like a frightened little field mouse.  I was a coward and I left my masters and all my friends to face the horde one mouse short.</i>\"\n\n");
	outputText("You watch as Joy bows her head in shame for a moment. Yet when she looks back up there’s fire in her eyes.\n\n");
	outputText("\"<i>Never again....</i>\"\n\n");
	outputText("You try to comfort Joy, telling him she couldn’t have made a difference being but a single mouse, but she waves you off.  She tells you she is fine and thanks you for your concern.\n\n");
	outputText("You can tell the story has affected her, but you’re surprised to hear the resolve in her voice and see the defiant strength in her eyes. Excusing yourself, you rise and leave her to do as she will.\n\n");
	doNext(joJoytalkMenu);
	advanceMinutes(5);
}
//Forest Convo
public function joJoyTalkForestConvo():void
{
	clearOutput();
	jojoSprite();
	flags[kFLAGS.TIMES_TALKED_WITH_JOJO]++;
	outputText("You think for a while and decide to ask Joy how she ended up in the forest.\n\n");
	outputText("She looks at you with suddenly tired eyes as she says, \"<i>Well, I was training in the fields with one of the senior brothers when we saw the monastery was under attack.  He sent me to the village to save me since I was a novice.  I decided to rally the people there.  I figured that I had ran like a coward, I wasn’t going to hide like one.  It was the village where I was born and a home to many of my brothers and sisters, both figuratively and literally.  I ran towards the village with everything I had, hoping to redeem my cowardice by returning with a militia of mice to aid the members of my order.</i>\"  her voice catches and she looks away, obviously struggling to form words.\n\n");
	outputText("When you open your mouth to speak she raises her hand, asking for a moment with a single furry finger.\n\n");
	outputText("\"<i>I was too late.  The demons had struck there first, then moved on to my monastery once they were finished. I spent hours searching the streets; every basement, every alley, every attic, every place I could think of where somebody might have hidden.  Nothing but ruined buildings, smears of assorted tainted bodily fluids, and the occasional corpse - some demons, many more mice.</i>\"\n\n");
	if (player.cor < 35)
	{
		outputText("That's terrible... you can only imagine what you'd feel like if you returned to Ignam and saw it destroyed... your family, your friends... You put a hand on the monk's shoulder, intent on comforting her for the moment.\n\n");
	}
	else if (player.cor >= 35 && player.cor <= 75)
	{
		outputText("Tough luck... thankfully your village still stands and you doubt any demons would dare attack on your watch...  You feel like you should do something for the monk though, so you put a hand on her shoulder, comforting her for the moment.\n\n");
	}
	else
	{
		outputText("Mice... must've been a village of wimps if a few demons could take them out... The monk is obviously distressed... maybe you should comfort her for the moment, if only to make her stop.  You put a hand on her silent shoulder...\n\n");
	}
	outputText("\"<i>Thank you [name].  I was born there and seeing that...</i>\"  The monk falls silent again.\n\n");
	if (player.cor < 35)
	{
		outputText("You slide an arm around Joy’s shoulders in an attempt to reassure the monk.  She manages a smile in response as she looks up at you.  A single tear manages to slide down her muzzle as she says, \"<i>Thank you, my friend.</i>\"\n\n");
	}
	else if (player.cor >= 35 && player.cor <= 75)
	{
		outputText("You try to further console the distressed monk by moving your hand to her back and giving her a few friendly taps.  Jojo visibly pulls himself together. \"Thank you, I’m alright now,\" she tells you as she looks up and gives you a weak smile.\n\n");
	}
	else
	{
		outputText("Seeing an opportunity, you wrap your arms around the monk as she silently tries to reign in her emotions.  Holding her close you can feel the mouse morph’s soft breasts on your chest, and lean muscles as you rub her back. You ‘accidentally’ go too low, feeling the base of her tail and the top of her generous, hand-filling ass.  As you ‘hug’ the mouse you make sure she doesn’t notice your true intentions. When you release her, she actually thanks you.\n\n");
		dynStats("lus+", 10);
	}
	outputText("After you’ve comforted the monk you ask him what she did next.\n\n");
	outputText("When she answers you her shoulders are squared and her voice has regained some of its former volume, \"<i>I did what anyone looking at the shattered remains of their life would.  I buried them.  For the next few hours I took the time to lay each and every villager to rest before praying over them all.  Then I went back to my monastery, praying with all my heart that they had managed to hold out, at least long enough to escape rather than to be captured and twisted into perverse shells of their former selves.  Yet the monastery was another graveyard.  I found many bodies there.  Some were of the order but there were also countless imps and more than a few demons.  The place was defiled with semen and milk reeking of corruption.</i>\"\n\n");
	outputText("You see anger in the monk’s eyes as she clenches her fists, \"<i>They had utterly defiled the monastery and there was nothing I could do about it but honor its memory.  I labored for what felt like days; burying the fallen; seeking out survivors; gathering what few items of my faith had escaped demonic desecration.</i>\"  He touches the large beads around her neck meaningfully.\n\n");
	outputText("\"<i>Then, I burned the monastery to the ground and set fire to all the fields...  Since that day, I have eked out a meager existence in the wilderness; I study the texts I can, train my body as best I can, and seek to fortify my soul against demonic blandishments.  Though I have technically progressed far along my path, with no master and only a pale echo of a fraction of my order’s texts at my disposal, I may never be a true master in my own right.</i>\"\n\n");
	outputText("She gives you an appraising look before looking away, \"<i>Until I met you, [name], my only purpose had been to find the demons who destroyed my order and make them pay for the lives they took.  That is why I was in the forest, I was in the middle of a harsh training regimen to increase my power and skill so that I may seek out those evil brutes who took everything I loved away from me... but vengeance is not the way of the Celestial Lotus.  The Celestial doesn’t train bullies or assassins.  Finding you and aiding in your quest to protect your village from these demonic creatures of perversion gave me new purpose and would make my departed brothers and sisters proud.  I can’t honestly say I’ve given up on having my vengeance but... I will aid you in your quest first if for nothing more than to honor our friendship and honor the memory of the order and its teachings.</i>\n\n");
	outputText("Looking renewed and at peace despite the emotional storm you know must be raging within her tiny frame Joy returns to what she was doing after thanking you for giving her new purpose.\n\n");
	doNext(talkMenu);
	advanceMinutes(5);
}
//Yourself
//Origin
public function jojoTalkYourOrigin():void // Prob tack on some interaction count or something to unlock this
{
	clearOutput();
	jojoSprite();
	flags[kFLAGS.TIMES_TALKED_WITH_JOJO]++;
	outputText("As you start up a conversation with Joy, the two of you speak at length about nothing really important or noteworthy, just small talk.  That is until the monk brings up the subject of your background.  You tell her about Ingnam and your family there, and the tradition of sending a champion through the portal.  When he asks why anyone would choose to come here, you tell him how legends say that in years a champion wasn’t sent through the portal, terrible things happened to the village.\n\n");
	outputText("\"<i>That portal?</i>\" Joy asks, pointing to the very portal you stumbled through. You nod and she asks, \"<i>So... what were you like in Ingnam?</i>\"\n\n");
	if (player.hasPerk(PerkLib historyAlchemist)) {
		outputText("You tell Joy that you were the assistant to Riku, an alchemist residing in your village.  He asks questions about your time with the alchemist and how your family felt about you taking up alchemy.  You tell him that you were just about to go into advanced studies when it was announced that you were the next champion and all you really learned was how to increase the potency of certain types of items.\n\n");
	}
	else if (player.hasPerk(PerkLib.historyCultivator)) {
		outputText("You tell Joy about how you spent your time training to become a soul cultivator.  Hearing  her little monk get slight more interested and asked you to say more about  her cultivator and her chosen path, on which you gladly reply telling all you remembered.\n\n");
	}
	else if (player.hasPerk(PerkLib.historyFighter)) {
		outputText("You tell Joy about how, growing up, you got into fights a lot.  You name names and tell her why and how each of those little brats had got what was coming to them. You tell him how you had planned to join the village guard, but that became a pipe dream when it was announced that you were the next champion.\n\n");
	}
	else if (player.hasPerk(PerkLib.historyFortune)) {
		outputText("You tell Joy about how you're lucky and you've made quite a bit of money.  When the monk asks how, you shrug and tell her it's just plain luck.\n\n");
	}
	else if (player.hasPerk(PerkLib.historyHealer)) {
		outputText("You tell Joy about how you spent a lot of your time at the side of Dende, the village healer. You talk about why you wanted to spend time with the older man as he looked after the sick and infirm and the skills you learned there. You let her know how you had just decided to train to become an official healer when you were announced to be the next champion.\n\n");
	}
	else if (player.hasPerk(PerkLib.historyReligious)) {
		outputText("You tell Joy about how you spent most of your time in the temple. He seems to really like hearing about the differences in religious practices between the Celestial Lotus and your village. You tell him about the various clergy of your hometown and how Sister Esther took time to teach you about meditation.\n\n");
	}
	else if (player.hasPerk(PerkLib.historyScholar)) {
		outputText("You tell Joy about your insatiable thirst for knowledge and how you spent a lot of time in school. You tell him the story about how you ‘convinced’ Mr. ");
		if (EngineCore.silly()) outputText("Savin");
		else outputText("Sellet");
		outputText(" to let you read some of the rare books in his collection, skipping over how much begging and pleading was actually involved.\n\n");
	}
	else if (player.hasPerk(PerkLib.historyScout)) {
		outputText("You tell Joy about how you spent your time training with any bow you could find.  You tell her how you had planned to join the village hunters squad, but that became a pipe dream when it was announced that you were the next champion.\n\n");
	}
	else if (player.hasPerk(PerkLib.historySlacker)) {
		outputText("You tell Joy about how you spent your time basically relaxing with your fiends.  You gloss over how big of a lazy bum you were with stories of the times you generally made a nuisance of yourself.  You don’t tell her that you’re pretty sure you were chosen as the next champion in order to be gotten rid of.\n\n");
	}
	else if (player.hasPerk(PerkLib.historySlut)) {
		outputText("You tell Joy about how you spent time... making friends.  She looks at you weirdly and when you tell him you had a lot of friends....\n\n");
		outputText("\"<i>That’s nice I guess [name] but didn’t you have aspirations beyond being, erm... popular?</i>\" he questions.\n\n");
		outputText("You laugh and tell her that you were just really good at making friends, instead of the truth about how much of a slut you actually were.\n\n");
	}
	else if (player.hasPerk(PerkLib.historySmith)) {
		outputText("You tell Joy about how you spent your time training to become a blacksmith.  Not knowing much about smithing, she asks questions about the things you learned and you answer them to the best of your ability.  To finish you describe the process of fitting armor in great detail and how you were going to start learning advanced techniques but were announced to be the next champion.\n\n");
	}
	else if (player.hasPerk(PerkLib.historyTactician)) {
		outputText("You tell Joy about how you spent your time learning many different war tactics from a retired commander that lived in your village. Especially on making anyone under your following put more than 100% of their effort.\n\n Joy seems disinterested in the many violent tactics you have learned. Eventually, she changes the subject, looking a little nauseated.\n\n");
	}
	else if (player.hasPerk(PerkLib.historyWhore)) {
		outputText("You tell Joy about how you spent a lot of your time... making money.  When the boxum former monk asks how, you just smile as you fondly remember the older whore, Poison, showing you the ropes and teaching the tricks of the trade.  Regardless of how it made people think of you, it was certainly good money.  In an attempt to hide some of the messier details of your past from Joy, you explain how you accepted... odd jobs for people, important work that not many others in the village would be willing to accept. She blinks, realizing what you're talking about. <i>\"I knew you were more experienced than me...I never really knew how much.\"</i> Despite yourself, you blush, actually caring about what Joy thinks, but she leans in, kissing you on the lips. She shushes you with a finger, bringing a hand to nuzzle your cheek. <i>\"You did what you had to...Just know that I'd do anything to stop you from needing to do it again.\"</i> Joy blushes at this sudden admission. <i>\"I-I mean...If you wanted to do it, than...But...\"</i> You smile a little at the lovely mouse in front of you, still naive despite everything. You tell her that you'll keep that in mind. \n\n");
	}
	else if (player.hasPerk(PerkLib.historyFeral)) {
		outputText("You tell Joy about how you spent a lot of your time in the wild. You tell her that before arriving in Mareth, you were living your life among a pack of wild wolves.  \n\n");  // I am not a writer, feel free to amend.
	}
	else {
		outputText("You're not sure where to start. You have been doing countless activities before arriving in Mareth that it'd be virtually impossible to list all of them. It's almost impossible to choose where to start or what to even begin talking about. It comes to the point where you're not sure if there's anything you HAVEN'T done.\n\n");
	}
	outputText("Joy smiles now that she has gotten to know you a little better. After a little bit more small talk, the two of you decide the conversation is over and part ways.\n\n");
	doNext(joJoytalkMenu);
	advanceMinutes(5);
}
//Dungeon Convo: Factory
//Requirements: Completed Demon Factory -- flags[kFLAGS.FACTORY_SHUTDOWN] > 0
public function joJoyTalkFactory():void
{
	clearOutput();
	jojoSprite();
	flags[kFLAGS.TIMES_TALKED_WITH_JOJO]++;
	outputText("You tell Joy about your having successfully found and stopped the demonic factory.  You tell her how you found out the factory was there and how you defeated the demons inside. She seems impressed.\n\n");
	if (flags[kFLAGS.FACTORY_SHUTDOWN] == 2)
	{
		outputText("Her ears perk at the news as you continue, telling her that you destroyed the factory controls, which permanently shut down the factory - but released an enormous quantity of corrupted fluids into the environment.\n\n");
		outputText("Joy cocks her head to the side as she considers her words carefully before speaking, \"<i>I guess it seems like the right move. Permanently disabling the factory would not only deal a heavy blow to the demons, but also give the rest of us time to reclaim the forest... but I don’t know.  If the release of fluids was as much as you say it was then there’s a chance that it’ll do more harm than good.  I’ve seen what corruption does to our world and that much corrupted fluid flooding out all at once could really hurt our cause. I’m not saying it was the wrong thing to do, or lessening your accomplishment, but you have to be careful.  The demons aren’t just powerful, they’re deceptive.</i>\"\n\n");
		outputText("You listen to the monk’s council and despite her concerns, she seems genuinely happy to hear you’ve struck a blow against the demonic regime.\n\n");
	}
	else
	{
		outputText("Her ears perk at the news as you continue, telling him that you shut down the factory and destroyed the controls, for the sake of the surrounding environment.\n\n");
		outputText("Joy’s chest swells with pride as she looks at you with new eyes before saying, \"<i>Wow [name], I don’t know what to say.  I know it uprooted your life and took you away from the ones you love, but I sincerely believe that the day you came through that portal was a good day for all of Mareth.  I am proud of you and humbled by the fact that I can call you my friend.</i>\"  She rises and gives you a fierce hug, resting her head on your shoulder, before pulling away and saying, \"<i>We’ll have to watch the factory though... the demons can’t be allowed to reopen that evil place.</i>\"\n\n");
	}
	outputText("Once the two of you are done discussing the demonic factory Joy excuses herself to think on what you’ve told her.\n\n");
	doNext(joJoytalkMenu);
	advanceMinutes(5);
}
//Dungeon Convo: Sand Cave
//Requirements: Completed Sand Witch Dungeon
public function JojoyTalkSandCave():void
{
	clearOutput();
	jojoSprite();
	flags[kFLAGS.TIMES_TALKED_WITH_JOJO]++;
	outputText("You tell Joy about your discovery of a cave that served as a base for the sand witches of the desert. You tell her about the whole ordeal, and she listens with wide eyes and jaw agape. When you tell her about meeting the Sand Mother, Joy gasps.\n\n");
	outputText("\"<i>Wait... so you mean to tell me that these sand witches a-are... allies of Marae?  But...Typically sexual attributes are more aligned with demons, than the pure.</i>\" You gently remind Joy that she's pretty damn sexy herself, and that even while Bimboed, she was an ally of Marae.  her stops Joy mid-rant, and she brings one hand to her chin.\n\n");
	outputText("\"<i>I suppose you've got a point there.\"</i> Joy admits. \"<i>Still, the way they inflict their lust and way of life on others, to grow their numbers? In many ways, they're the same as the demons.\"</i> \n\n");
	//if PC raped Sand Mother
	if (flags[kFLAGS.SAND_WITCHES_COWED] == 1)
	{
		outputText("You describe your battle with the Sand Mother in an animated blow-by-blow fashion, and when you get to the end where you raped the Sand Mother you look at Joy and...Admit what you did. You've been through too much with Jojo, and then Joy, to lie to her. You tell Joy that you did it to try and stop them from attacking you, without having to kill them...Although a part of you did get a thrill from putting her in her place. You remind Joy that they would have raped you as well, and they seemed to view it as more of a defeat than combat.\n\n");
		outputText("\"<i>I will admit, I'm...Disappointed to hear that you resorted to such methods...But I'm not going to judge you...Not after everything you've done. You're a good person, and I trust you.\"</i> You thank Joy for understanding, and she bows her head respectfully. <i>\"If becoming Joy has taught me anything, it's that questionable methods can sometimes lead to great results, if applied by a trustworthy person.\"</i>")
	}
	//if PC spoke to Sand Mother after Fighting her
	// FRIENDLY is the overall victory flag (theres a separate flag used to indicate you dun wanna be attacked by sandbitches in the desert anymore)
	else if (flags[kFLAGS.SAND_WITCHES_FRIENDLY] == 1 && flags[kFLAGS.SAND_MOTHER_DEFEATED] == 1)
	{
		 outputText("You describe your battle with the Sand Mother in an animated blow by blow. When you get to the end you tell her about how reasonable the Sand Mother actually was after you beat her.\n\n");
		 outputText("Joy’s head tils to the side as she speaks, in a soft, stern tone. \"<i>Maybe the whole thing didn’t need to come to an altercation in the first place, a little diplomacy on both sides....</i>\"  She gives you a pointed look, \"<i>Might have gone a long way.</i>\"\n\n");
	}
	//if PC just spoke to the Sand Mother
	else if (flags[kFLAGS.SAND_WITCHES_FRIENDLY] == 1 && flags[kFLAGS.SAND_MOTHER_DEFEATED] == 0)
	{
		outputText("You tell Joy about how the Sand Mother spoke with you once you had battled your way to her.  You tell her she was reasonable and how the whole thing was, in the end, a simple misunderstanding.\n\n");
		outputText("She marvels at the way you handled the situation, \"<i>Many would have expected her trying to talk to them to be a trap [name] and hurried to attack her but not you... that is... wow [name], you are truly a great individual.</i>\"\n\n");
	}
	//[if {PC met bath slut}
	if (flags[kFLAGS.MET_MILK_SLAVE] == 1)
	{
		outputText("You tell Joy about the poor mind addled thing you found sitting in a tub of milk acting as a slave to the sand witch coven.\n\n");
		outputText("She shudders like a child being told a scary story, bringing her hands to her own breasts. After a few moments of horrified silence, she asks, \"<i>What did you do?</i>\"\n\n");
		//[if {PC hasn’t spoken to Sand Mother about Bath Slut yet}
		// Can't differentiate  her
		// All I have is HAS_MET and HAS_RECRUITED effectively
		if (flags[kFLAGS.MILK_NAME] is Number)
		{
			outputText("You tell Joy about how the Sand Mother told you the bath girl was unfit to be free and how they care for her because she can’t care for herself.\n\n");
			outputText("Joy reacts by putting her chin in her hands and thinking, \"<i>Well... I guess that’s the human thing to do, especially since she doesn’t seem to be corrupted.  Maybe these sand witch covens aren’t all bad, still hard to believe that they’re on our side though....</i>\"  She looks up and shrugs, \"<i>Any act of charity though is a good thing. I do hope the poor girl will be alright.</i>\"\n\n");
		}
		// [if {PC has bath slut in camp}
		else if (flags[kFLAGS.MILK_NAME] is String)
		{
			outputText("As the question leaves her lips you give Joy a confused look and, with a glance, direct her gaze toward " + flags[kFLAGS.MILK_NAME] + ".\n\n");
			outputText("She slaps her own forehead and says, \"<i>Oh... yeah... right.</i>\" Obviously embarrassed by not putting two and two together. She smiles good naturedly though, \"<i>I don’t know I guess I just assumed you found some poor mind addled soul and decided to save her.</i>\" Joy says as he looks over at " + flags[kFLAGS.MILK_NAME] + ".\n\n");
			outputText("<i>Maybe not all of that cursed liquor made it out of my system after all. </i>\" You tell Joy not to joke like that...Ralthazul is a master of his craft, don't belittle him.\n\n");
			outputText("This gets both you and Joy laughing, and she promises, between giggles, to go apologize to him later. You stop laughing, and Joy looks over at the poor girl.\n\n");
			//[if (bathSlutStage1 - unaltered)
			if (flags[kFLAGS.MILK_SIZE] == 0)
			{
				outputText("\"<i>She’ll fare much better in our care than in the coven’s,</i>\" she states with conviction.\n\n");
			}
			//[if (bathSlutStage2 - HHH)
			else if (flags[kFLAGS.MILK_SIZE] == 1)
			{
				outputText("\"<i>She’s already much better than she was when she got here,</i>\" She says with a grin.\n\n");
			}
			//[if (bathSlutStage3 - DD)
			else
			{
				outputText("\"<i>The coven wouldn’t have done what you’ve done for her.  You’ve given her a much, much better life and even aided in fixing her condition, you truly are a champion, [name],</i>\" She says, giving you a fond smile and a pat on the back.\n\n");
			}
		}
	}
	// There's an untracked gap here, where the player doesn't accept a blessing from the Cum Witch, but there's no other existing tracking for  her shit.
	//[if {PC met Cum Witch}
	if (flags[kFLAGS.CUM_WITCH_DEFEATED] == 1 || flags[kFLAGS.BEEN_BLESSED_BY_CUM_WITCH] == 1)
	{
		outputText("You tell Joy about the cum witch, the herm witch responsible for inseminating the witches there, acting as a father to the others.  When you do she scratches her ear, \"<i>I assumed such creatures were needed, but...Calling them cum witches? Like their only purpose is...That? It's...Oh, I'm sorry, please continue.</i>\"\n\n");
		//[if {PC allowed Cum Witches to increase their numbers}
		if (flags[kFLAGS.MORE_CUM_WITCHES] == 1)
		{
			outputText("You tell her how you tried to remedy the current cum witch’s situation by asking the Sand Mother to make more cum witches.\n\n");
			outputText("She  hertles low, \"<i>That’s a bold move [name].  It seems like they would want that though, it’d allow them to, er, you know... more often, and make more sand witches in the long run wouldn’t it?</i>\" As the question sounds rhetorical you plow on ahead.\n\n");
		}
		//[if {PC allowed Cum Witches to rome}
		else if (flags[kFLAGS.CUM_WITCHES_FIGHTABLE] == 1)
		{
			outputText("You describe to her how you convinced the Sand Mother to allow her cum witches to rome the desert along with the sand witches and she looks at you with astonishment, \"<i>You are a generous spirit [name], and  her Sand Mother doesn’t seem entirely unreasonable either.</i>\"\n\n");
		}
		//[if {PC did nothing to help Cum Witch}
		else
		{
			outputText("\"You tell Joy that you’re actually done. She says, \"<i>Oh... well that’s weird.</i>\" and after an awkward silence, the two of you burst out laughing.\n\n");
		}
	}
	outputText("Having concluded the conversation the two of you stand, Joy giving you a brief, but very cozy hug before walking back to her rock.\n\n");
	doNext(JojoytalkMenu);
	advanceMinutes(5);
        }
    }