//const SALON_PAID:int = 441;
function hairDresser():void {
	outputText("While exploring the mountain, you find a cleverly concealed doorway.  From inside you can hear the sound of blades being sharpened.  Do you enter the doorway?", true);
	doYesNo(2169,13);
}

function salonPaymentMenu():void {
	var blow:Number = 0;
	if(player.hasCock()) blow = 2154;
	var minoCum:Number = 0;
	if(flags[UNKNOWN_FLAG_NUMBER_00142] > 0) minoCum = 2696;
	choices("Goblin Blow",blow,"Canine",gloryholeDoggie,"Imp",gloryholeImp,"Minotaur",gloryholeMinotaur,"Incubus",gloryholeIncubus,"",0,"",0,"",0,"Buy MinoCum",minoCum,"Leave",13);
}
function salonPurchaseMenu():void {
	flags[SALON_PAID] = 1;
	spriteSelect(38);
	var cutShort:Number = 0;
	var cutMedium:Number = 0;
	var cutLong:Number = 0;
	var lengthening:Number = 0;
	var minoCum:Number = 0;
	var mudFacial:Number = 0;
	var sandFacial:Number = 0;
	if(flags[UNKNOWN_FLAG_NUMBER_00142] > 0) minoCum = 2696;
	if(player.hairLength > 2) cutShort = 2159;
	if(player.hairLength > 13) cutMedium = 2160;
	if(player.hairLength >= 26) cutLong = 2161;
	if(player.hairLength < player.tallness) lengthening = 2162;
	if(player.femininity < 100 && player.gender == 2) mudFacial = 2838;
	else if(player.femininity < 85 && (player.gender == 0 || player.gender == 3)) mudFacial = 2838;
	else if(player.femininity < 70 && player.gender == 1) mudFacial = 2838;
	else if(player.femininity < 100 && player.hasPerk("Androgyny") >= 0) mudFacial = 2838;
	if(player.femininity > 0 && player.gender == 1) sandFacial = 2837;
	else if(player.femininity > 30 && player.gender == 2) sandFacial = 2837;
	else if(player.femininity > 20 && (player.gender == 0 || player.gender == 3))  sandFacial = 2837;
	else if(player.femininity > 0 && player.hasPerk("Androgyny") >= 0) sandFacial = 2837;
	
	choices("Cut Short",cutShort,"Cut Med.",cutMedium,"Cut Long",cutLong,"Lengthen",lengthening,"Buy Products",2163,"Buy MinoCum",minoCum,"",0,"Mud Facial",mudFacial,"Sand Facial",sandFacial,"Leave",13);
}

function hairDresserGreeting():void {
	spriteSelect(38);
	outputText("You step inside the cave, and are greeted by a sight you did not expect.  The cave's floor is covered with smooth wood panelling and the walls are nearly entirely covered with hanging mirrors.  The few stalactites have hooks drilled into them, from which hang hundreds of scissors, shears, razors, combs, and other hairstyling impliments.  It reminds you of the hair-cutter's shop in your hometown.", true);
	outputText("\n\nThere are a few chairs along the wall and goblins with latex dresses and gloves looking bored.  At the sight of you they perk up and clamor around you excitedly, until one with a gravity-defying chest pushes them apart and greets you.", false);
	outputText("   \"<i>I apologize for my daughters,</i>\" she says as she presses herself against you.  \"<i>They're a bunch of brainless hussies for the most part.  My name is Lynnette, and welcome to my salon!  You want your hair cut or lengthened?  We've got you covered, and we don't ask for much - just a shot of cum.", false);
	if(player.cockTotal() == 0) {
		outputText("  You look like you don't got any of your own, but we've got glory holes in the back if you need to get some.  Just don't swallow too much ok?</i>\"\n\nShe shows you to the back of the cave, which is boarded-up.  There are about 20 holes in boards, and most are empty.  While you watch, a few new dicks slide in, and just as quickly the goblin's daughters commence sucking and fucking them.  There are only a few you could take a crack at - do you blow one (and if so which one)?", false);
	}
	else {
		outputText("  I'll even do you the favor of letting you blow it in my mouth, I've already got a bun in the oven.  So what do you say?  Want a spooge and a haircut?  Or would you rather go get your payment from one of the gloryholes in the back, you " + player.mf("kinky boy","naughty girl") + "?</i>\"\n\n", false);
		outputText("In the very back of the salon you can see a boarded-up wall with holes cut in it, some of which are currently plugged by various monstrous penises.  Do you let the goblin blow you, or do you go suck your payment from one of them?", false);
	}
	salonPaymentMenu();
	outputText("\n\n<b>(Salon unlocked in 'places' menu from camp)</b>", false);
}
function hairDresserRepeatGreeting():void {
	spriteSelect(38);
	var minoCum:Number = 0;
	//Chance for mino craziness here
	if(rand(5) == 0 && (player.hasPerk("Minotaur Cum Addict") >= 0 || flags[MINOTAUR_CUM_ADDICTION_STATE] > 0)) {
		minotaurCumBukkakeInSalon();	
		return;
	}
	outputText("Lynnette the goblin answers the door and lets you in, waving you deeper into her shop.  Her shining black dress barely contains her fertile-hips and jiggling chest as she greets you, \"<i>Welcome back honey!  ", true);
	if(player.cockTotal() == 0) {
		outputText("I see you still can't make payment for our services on your own.  No worries, the glory holes in the back are pretty popular with the demons and monsters, just go back there and catch some spooge and we'll see about helping with your hair, ok?</i>\"\n\n(There are a number of dicks in the glory hole, which do you want to deal with (if you're willing at all)?", false);
	}
	else {
		outputText("Will you be getting our normal services?  Just one BJ per hair treatment!  Or would you rather get it from the gloryholes in back?</i>\"", false);
	}
	salonPaymentMenu();
}
function gloryholeImp():void {
	slimeFeed();
	outputText("", true);
	outputText("You walk over to the hole in the wall, looking at the erect demon-member you'll have to service.  Judging by the height and constant bobbling up it down it does, the imp must be hovering on the other side, trying pretty damn hard to stay in the hole.\n\n", true);
	if(player.cor < 33) {
		outputText("You struggle to force your mouth onto the abomination in front of you, wondering why you chose to do such a thing.  Your head bobs up and down, trying to match the motions of the thick demonic tool as you grab hold and guide it into your mouth.  It's hot, hotter than you'd expect, and dripping with sickly sweet pre-cum that makes you tingle.  You throw yourself into the wretched task, intent on finishing it as quickly as possible.  You circle your tongue over the nodules, holding on as it swells in your mouth, unloading a sticky batch of spooge into your throat.  You cough and sputter, swallowing most of it, but you manage to hang on to enough for your pay.\n\n", false);
		stats(0,0,0,0,0,0,15,.5);
	}
	else if(player.cor < 66) {
		outputText("You open wide, bobbing up and down in an effort to match the strange dick that wobbles in front of you.  In the end you wrap both hands around its bumpy base, steadying it as you engulf the throbbing demon dick, taking as much as you can into your mouth.  You squeeze and caress it, licking the ridge of nodules that surround the crown as sticky spoo begins to erupt from it.  The little guy didn't have much endurance, but he must have been pretty backed up, as he's flooding your mouth and throat with his seed.  You struggle to swallow enough to keep up, but when he finishes, you're panting and covered in white.\n\n", false);
		stats(0,0,0,0,0,0,35,1);
	}
	else {
		outputText("You immediately dive forwards, relishing the idea of taking in another load of demonic cum.  Your groin tingles as your lips make their way down the oddly textured shaft, engulphing nearly 10 inches of demon-cock, feeling it press down your throat.  You curl your tongue around and begin sliding back and forth, immediately rewarded with a thick dribble of pre-cum.  The imp on the other end loses it immediately, blasting waves of cum directly into your belly as you shove forwards, taking him into the hilt.  You feel him pulsing and pull back in time to take the last few loads in your mouth, saving your payment for the goblins.\n\n", false);
		stats(0,0,0,0,0,0,45,2);
	}
	outputText("Abruptly, the demon-dong slips through your grasp and out the hole.  You hear a loud thump as something lands on the ground. Poor thing.\n\n", false);
	doNext(2168);
}



function gloryholeDoggie():void {
	slimeFeed();
	outputText("", true);
	outputText("You sigh and kneel down to bring yourself level with the dog-dick hanging out of the wall.  It's pointed at the tip with a swollen circular bulb at the base.  As a matter of fact, the dog-dick's owner must be pretty excited to be here - it's dripping cum and the knot has swollen so large that it can't fit back through the hole.\n\n", true);
	if(player.cor < 33) {
		outputText("It's a struggle to force your lips apart and take the strange thing in your mouth.  You feel like a freak, but make yourself get to work servicing the male who'll be covering your hair treatment today.  It tastes salty and sweaty and has a potent musky scent that excites you in spite of your better judgement.  You find yourself starting to get into it as you lick and slurp, humming with pleasure.  You reach up to touch the knot and the dog-cock jumps in your mouth, spurting a wad of thick cum into your throat.  You pull back most of the way and pump the cock, collecting the jism in your mouth.\n\n", false);
		stats(0,0,0,0,0,0,15,.25);
	}
	else if (player.cor < 66) {
		outputText("You open wide and take as much of the pointed dick as you can into your mouth.  A few times you nearly gag yourself, but you manage to get most of the way down to the thick swollen knot.  You start sliding back and forth, breathing in the musky animalistic scent of your 'client' and become aroused by the situation more and more.  You reach up and caress the knot, squeezing gently and stroking the dick until it unloads a thick wad of cum into your mouth.  You pull back and catch the fruits of your labor in your mouth, milking the dick with your hands until it's finished and the dick pops back through the hole.\n\n", false);
		stats(0,0,0,0,0,0,25,.25);
	}
	else {
		outputText("You throw yourself onto the swollen dog-cock and easily engulf the whole thing, spreading your lips wide around the thick knot.  You can feel it bouncing the uvula in your throat around but you manage to supress your gag reflex like a good slut while you work the sweaty dick, giving it a thorough tongue bath.  You wrap your lips around the base of the knot, feeling it start to stretch your jaws apart.  You pull back before it can lock you like that, and squeeze the knot in your hands.  It cums, unloading thick wads of gooey cum into your mouth.\n\n", false);
		stats(0,0,0,0,0,0,30,.3);
	}
	outputText("A young goblin comes by with a bowl for you to make your payment into.  You spit out the gunk and wipe your mouth, as the goblin carries the seed away.  You notice a trail of clear drops on the ground behind her.  She must be anticipating something...", false);
	doNext(2168);
}
function gloryholeIncubus():void {
	slimeFeed();
	outputText("", true);
	outputText("You kneel down in front of the throbbing demonic dick, ready to earn your pay.\n\n", false);
	if(player.cor < 33) {
		outputText("You picked this dick hoping that a male lust demon would be the most pleasurable to service, and judging by the pleasant spicy scent the member gives off, you're right.  You open wide and take it inside your mouth, feeling the ridges around the crown pressing back against your lips. A drop of pre-cum hits your tongue and it tastes divine, spurring you on to please the tainted member.  You grab it with both hands and pump it, feeling the corrupted nodules under your fingers as you lick and suck on the head, eager for more.  You get your reward soon enough, and you eagerly start drinking down the copious waves of fluid.  Thankfully, the incubus' orgasm seems to last forever, and when he finishes, you have a full belly and a mouth full of cream.  You manage to resist this last swallow, as you still need to pay.\n\n", false);
		stats(0,0,0,0,0,0,1,1.5);
		player.lust = 99;
	}
	else {
		outputText("You take the corrupted cock in your hands and guide it into your waiting mouth, eager to try a walk on the wild side.  The incubus-cock does not disappoint, quickly dripping a steady flow of wonderful tasting pre-cum that only whets your appetite for the demon's cum.  You lean forwards, taking most of the bumpy purple dick inside your mouth and running your tongue all over it, paying special attention to the ring of nodules around the bottom edge of his crown.  You're quickly rewarded with a blast of heavenly demonic seed.  You gulp it down, craving more of it, and thankfully the incubus has plenty for you.  You're shivering and horny by the time he finishes, but thankfully you have enough willpower to keep a mouthful of cum for payment.\n\n", false);
		stats(0,0,0,0,0,0,1,1);
		player.lust = 99;
		
	}
	statScreenRefresh();
	doNext(2168);
}

function gloryholeMinotaur(): void {
	slimeFeed();
	outputText("Your eyes are drawn to the huge minotaur cock, and you instinctively kneel down in front of it.\n\n", true );
	outputText("It's the largest available member in the room by a considerable margin, and from your position on your knees, it looks even more massive; it's over two feet long, and has three rings of prepuce spaced around its length. You can just barely span your entire hand around its thickness. You open your mouth wide and lean forward, taking the thick, spongy head into your mouth. The taste is incredibly strong, and its musk is as thick as the minotaur's dick itself. You moan in pleasure, and start bobbing your head back and forth, taking more and more of the dick into your mouth. You stroke the rest of the cock in time with your sucking. You can hear muffled grunting and snorting coming from the other side of the wall, obvious sounds of approval from your partner.\n\n", false);
	outputText("Driven on by the minotaur's reactions, you take more and more of the minotaur cock into your mouth. As you work your mouth around the first ring, you open up the top section of your " + player.armorName + ", freeing up your " + allBreastsDescript() + ". With each pass, you're able to take more and more of the bull dick down your throat. You caress your " + biggestBreastSizeDescript() + " while moaning around the dick. When you get your mouth around the second ring, the minotaur's cock throbs sharply, and his cum explodes in your mouth. Your eyes bulge in shock, and you pull off the cock as quickly as you can. You swallow the first several shots of thick, rich minotaur cum, while the rest shoots all over your face and tits. You ");
	if(player.biggestTitSize() > 1) outputText("hold up ");
	else outputText("arch your back to expose ");
	outputText("your [chest] as cum rains down upon you. By the time his orgasm stops and his dick goes limp, your face and [chest] are covered in a thick layer of spooge.\n\n", false);
	outputText("Your head spins from the minotaur's musk, and you idly mop up and swallow the cum on your " + player.face() + ". A goblin aide comes in with a bowl, and gently scrapes the cum off your tits with a smooth, flat rock. Once you're cleaned up and you're dressed, the aide leads you back to Lynnette.\n\n", false);
	stats(0,0,0,0,0,0,33,1);
	minoCumAddiction(10);
	doNext(2168);
}

function goblinHairDresserFacefuck():void {
	spriteSelect(38);
	outputText("Lynnette licks her lips and practically tears her way into your " + player.armorName + ", having your crotch exposed in seconds.  Your " + cockDescript(0) + " flops out immediately, slapping her on the nose as it grows hard.  She wraps both hands around you and begins pumping with practiced ease, flicking her tongue over your crown and wrapping her lips ", true);
	if(player.cocks[0].cockThickness >= 4) outputText("around as much of you as she can", false);
	else outputText("around your first few inches", false);
	outputText(".  She slips her tongue down your urethra, and arches her back, popping the straps on her dress and letting her oversized tits engulf your shaft.  Milk sputters and dribbles from the lactating goblin, lubricating her breasts and hands as she pleasures every inch of you.\n\n", false);
	outputText("It's impossible to hold back while receiving such expertly given stimulation, and you blow your load, bulging her cheeks out like a squirrel's.", false);
	if(player.cumQ() >= 250) outputText(" She can't hold it all and suddenly starts swallowing as runnels of it escape her nose and a wave of it rolls down her lips.", false);
	outputText("  In time it ends, and she pops back, spitting most of the cum into a funnel.  It washes down a pipe and you have to wonder if there's some horny goblin girl at the other end with her cunt spread wide.", false);
	outputText("\n\nThe hair-dressing goblin matron sputters a bit before licking her lips clean and beaming a happy smile at you.\n\n", false);
	stats(0,0,0,0,0,0,-100,0);
	hairDressingMainMenu();
}
function hairDressingMainMenu():void {
	spriteSelect(38);
	outputText("Lynnette offers and explains their options, \"<i>So what'll it be hun?  We could cut it down or give you a lengthening treatment. Or you can get a hair-dye to use on your own.  Just remember to come back in a few days for a touchup.</i>\"", false);
	if(flags[UNKNOWN_FLAG_NUMBER_00142] > 0) {
		outputText("\n\nOf course you could always spend some gems and buy some minotaur cum instead...", false);
	}
	salonPurchaseMenu();
}

function cutShort():void {
	spriteSelect(38);
	//-trying to get a goblin to cut tentacle hair:
	if(player.hairType == 4) {
		outputText("Lynnette stares at you when you ask for a cut.  \"<i>Nothing doing, hon; that stuff looks alive and I don't want blood all over my nice floor.  Thanks for contributing to the white file, though; maybe we can do something else?</i>\"\n\n", false);
		salonPurchaseMenu();
		return;
	}
	outputText("Lynnette and her daughters crowd around you with razor-sharp scissors, effortlessly paring down your " + hairDescript() + ".  When they've finished, you're left with ", true);
	player.hairLength = 1;
	outputText(hairDescript() + ".", false);
	doNext(13);
}
function cutMedium():void {
	spriteSelect(38);
	//-trying to get a goblin to cut tentacle hair:
	if(player.hairType == 4) {
		outputText("Lynnette stares at you when you ask for a cut.  \"<i>Nothing doing, hon; that stuff looks alive and I don't want blood all over my nice floor.  Thanks for contributing to the white file, though; maybe we can do something else?</i>\"\n\n", false);
		salonPurchaseMenu();
		return;
	}
	outputText("Lynnette and her daughters crowd around you with razor-sharp scissors, effortlessly paring down your " + hairDescript() + ".  When they've finished, you're left with ", true);
	player.hairLength = 10;
	outputText(hairDescript() + ".", false);
	doNext(13);
}
function cutLong():void {
	spriteSelect(38);
	//-trying to get a goblin to cut tentacle hair:
	if(player.hairType == 4) {
		outputText("Lynnette stares at you when you ask for a cut.  \"<i>Nothing doing, hon; that stuff looks alive and I don't want blood all over my nice floor.  Thanks for the contributing to the white file, though; maybe we can do something else?</i>\"\n\n", false);
		salonPurchaseMenu();
		return;
	}
	outputText("Lynnette and her daughters crowd around you with razor-sharp scissors, effortlessly paring down your " + hairDescript() + ".  When they've finished, you're left with ", true);
	player.hairLength = 25;
	outputText(hairDescript() + ".", false);
	doNext(13);
}
function hairGrow():void {
	spriteSelect(38);
	//-asking for a lengthening treatment with tentacle hair:
	if(player.hairType == 4) {
		outputText("Lynnette looks dubiously at you when you ask for a lengthening treatment.  \"<i>No offense hon, but that stuff is basically like an arm or an organ, not hair.  I'm not a goblin chirurgeon, and I wouldn't try to lengthen it even if one of my disobedient daughters were here to donate some parts.  Sorry to make you shoot and scoot, but I can't help you.  Maybe we could do something else?</i>\"\n\n", false);
		salonPurchaseMenu();
		return;
	}
	outputText("Lynnette grabs a bottle and squirts a white fluid into your hair.  You really hope it isn't your payment.  But it must not be, as within short order you feel the added weight of ", true);
	temp = rand(3) + 3;
	flags[UNKNOWN_FLAG_NUMBER_00066] = 0;
	player.hairLength += temp;
	outputText(num2Text(temp) + " more inches of " + player.hairColor + " hair.", false);
	doNext(13);
}
function dyeMenu():void {
	spriteSelect(38);
	outputText("", true);
	outputText("Lynnette pulls open a cabinet in the corner, displaying a wide array of exotic hair-dyes.  Which kind do you want?", false);
	menuLoc = 2;
	choices("Blue",2164,"Orange",2165,"Pink",2166,"Purple",2167,"Back",2168,"Ext.Serum",2337,"",0,"",0,"",0,"",0);
  	/*if(shortName1 == "PinkDye") return "a vial of bright pink hair dye";
	if(shortName1 == "PurpDye") return "a vial of purple hair dye";
	if(shortName1 == "BlueDye") return "a vial of blue hair dye";
	if(shortName1 == "OrangDy") return "a vial of brilliant orange hair dye";*/
}

function giveGoblinAMilkMustache():void {
	outputText("", true);
	outputText("You slowly walk up to the downed goblin, gently telling her that everything will be all right now. She looks at you a bit incredulously and spreads her legs, obviously hoping that you will satisfy the urges that she has. You shake your head at her and instead cup your hands under your " + biggestBreastSizeDescript() + " and tell her that it's feeding time. The goblin looks at you annoyed and says, \"<i>I don't want your breasts! I want your naughty bits!</i>\" You laugh at her and grab her arms, pulling them behind her head.\n\n", false);
	
	outputText("She struggles against your grip, trying to get something, anything inside her needy pussy while yelling \"<i>Come on " + player.mf("slut","stud") + ", you know you want to - mmph!</i>\"  You cut her off by shoving her mouth onto your " + nippleDescript(0) + ". She gasps involuntarily, filling her mouth with your milk. In an instant she freezes, then slowly swallows the milk in her mouth. She relaxes in your arms a moment later, gently suckling at  your nipple. Her old lust-filled self is gone, replaced with a pliant girl who now wants nothing but your milk. You slowly lower your hand and start rubbing at her still-slick pussy. In response, she puts her hand on your other " + nippleDescript(0) + ", playing with it and teasing you.\n\n", false);

	outputText("After a while, you feel the goblin fall asleep in your arms. Even then, she still continues suckling gently on your " + nippleDescript(0) + ". You smile, satisfied, and gently lift the goblin off your chest. You pat her shoulder softly, and she stirs awake again. She gives you a bit of a dazed look before you give her a gentle push, and she starts walking away with a vacant, drooling stare.", false);
	//set lust to 0, increase sensitivity slightly
	stats(0,0,0,0,.2,0,-50,0);
	//You've now been milked, reset the timer for that
	player.addStatusValue("Feeder",1,1);
	player.changeStatusValue("Feeder",2,0);
	eventParser(5007);
}

function minotaurCumBukkakeInSalon():void {
	outputText("", true);
	minoCumAddiction(10);
	slimeFeed();
	outputText("As the salon door swings closed behind you, a familiar, heavenly scent catches your nose and wicks into your brain, flooding you with need and molten-hot lust.  Lynnette saunters over with her lips slightly pursed and her body jiggling, but you brush her aside.  She's completely forgotten as you close in on the source of your olfactory bliss.  Your sigh dreamily while your pupils slowly dilate from the familiar chemicals pounding through your bloodstream", false);
	if(player.hasVagina()) outputText(" and puffing up your twat with liquid arousal.\n\n", false);
	else if(player.hasCock()) outputText(" and turning " + sMultiCockDesc() + " into a turgid, pulsating mass.\n\n", false);
	else outputText("\n\n", false);
	
	outputText("You push your way past a few more staring goblin sluts, tearing off your " + player.armorName + " as you go.  The animal part of your brain recognizes that such needless trapping would just get in the way of all the thick, dripping, minotaur spunk just waiting to pump inside you.  Another door swings closed behind you while the scent drags you heedlessly deeper into the salon, closing in on the secluded glory-holes the goblins keep hidden away in the back.  You drool spittle down your neck while you lose yourself in the memory of that taste on your tongue, letting your body seek it out on autopilot.", false);
	if(player.hasVagina() || player.hasCock()) {
		outputText("  A trail of ", false);
		if(player.hasVagina()) {
			outputText("female slime ", false);
			if(player.hasCock()) outputText("and ", false);
		}
		if(player.hasCock()) {
			if(player.cumQ() < 100) outputText("pre-cum ", false);
			else if(player.cumQ() < 500) outputText("pre-cum a few inches wide ", false);
			else outputText("pre-cum over a foot wide ", false);
		}
		outputText("winds over the rough-hewn floor behind you, clearly marking your passage to the overpowering musk.", false);
	}
	outputText("\n\n", false);
	
	outputText("Time passes in a slow, torturous manner, but you turn the corner and sigh.  Salvation is at hand – you've reached the glory-holes, and to your delight there's nearly a dozen hard, dripping, delicious… mmmm… minotaur cocks crammed through the holes, some bulging out around the seams and leaking with need.  You saunter forwards, hips swaying sensually as the drug-like desire of potent minotaur musk pulls you ever closer.  Mewling happily, you take one of them in hand and stroke along its length, giggling as it pulses and leaks a stream of heavenly goo down your arm.   You lick it from your arm in one long, languid motion before pursing your lips around the minotaur's flared tip and sucking it hard as you quest for more of its heady ambrosia.\n\n", false); 
	
	outputText("You hear a deep, strangled sigh as more and more delicious pre floods your mouth, lighting your senses up with a fireworks show of pleasure", false);
	if(player.gender > 0) outputText(" and increasing the size of the puddle you're leaving on the floor", false);
	outputText(".  In between gulps of the fragrant fluid, you suck the swollen rod deeper and deeper into your mouth, gleefully suppressing your gag reflex as it pushes aside your uvula.  You work your throat, feverishly swallowing to suck it down.  A flare briefly distends your neck as it's taken deeper and deeper inside your form until your lips are puckered through the hole and you're sniffing the minotaur's pheromone-laced crotch.\n\n", false);
	
	outputText("The beast pulls back and starts pounding the hole, letting out deep, rumbling sighs of pleasure with each throat abusing glory-hole fuck.  If it weren't for his constant, bubbling preseed turning your throat to a slippery rut-hole you'd be rubbed raw, but instead you continue to lean forward, sniffing at his matted pubes every time he crushes them against your dick-stretched lips.  The other horny studs grunt with displeasure, but you reach out with your hands and grab hold two eager brutes' throbbing horsecocks.  Three out-of-sync heartbeats hammer through your hands and throat while you do your best to get them all off.\n\n", false); 
	
	outputText("You let your eyes drift closed and lash your tongue back and forth across the minotaur's lowest medial ring, feeling his flare bulge larger inside you in response.  The beast-man batters at the wall, grunting in equal measures of passion and pent-up desire as his cock's tip stretches wide and locks itself inside you.  His urethra bulges in rhythmic contractions, stretching your lips around the already swollen shaft and signaling to your musk-addled mind that you're about to get what you desire.  You hum with blissful delight as your belly begins to gurgle, accepting long bursts of sticky minotaur drug.\n\n", false);
	
	outputText("Tied down by the cum-spurting flare locked in your gullet, you pump on the other two dicks with feverish speed and sway on your " + player.feet() + " as the narcotic spooge intoxicates your already-addled mind.  You can feel each muscular contraction pulsing through the bestial shaft while it finishes depositing the heavy, sticky load, and your eyes cross from the viscous inebriation that's pooling in your belly.  Drizzles of pre-cum soak into your arms and palms, drawn out from the frenzied pumping of your fists.  They won't come from just a hand though.  They need something... tighter.\n\n", false);
	
	outputText("You start moaning in drug-induced bliss, but your vocalized pleasure is interrupted by the squelching slurp of the softening shaft being pulled from your dick-puckered lips.  It drips a rope of cum over your mouth and chin as it pulls free from the wall, leaving behind one vacancy among the swarm of ready minotaur dicks.  You lick up your stud's leavings and purr in bliss, reaching through the hole to cup the departing minotaur's balls teasingly.  He grunts and walks out of your grip – sated for now.  You curl your fingers into a come-hither gesture, retract your arm through the sweat-lubricated glory-hole, and wait for one of the other minotaurs to come over.\n\n", false);
	
	outputText("The beast who kept your left hand so busy repositions himself at the now-vacant opening, and you decide to reward him for moving so quickly.  You lick the last of the salty crème from your lips and muse that he isn't the only one getting a reward, but the monstrous cow-man doesn't need to know that.", false);
	if(player.biggestTitSize() >= 2) {
		outputText("  You wrap the pillowy flesh of your " + allBreastsDescript() + " around the new member, pleasantly surprised by its girth and wide, already-flared tip.  Maybe you could have gotten him off with your hands after all?  ", false);
		if(player.biggestTitSize() < 6) outputText("Even so, you can't quite get your breasts the entire way around him, so you make up for it by pressing it harder into you with your busy hands.  ", false);
		outputText("Runnels of pre cover the shaft and squish wetly between your tits, turning your body into a slip-n-slide that reeks of hot, sticky minotaur sex.", false);
	}
	else {
		outputText("You crush the member tightly against your chest, smearing your torso with the copious pre until you're like a hot, wet slip-n-slide of minotaur sex.  You make up for it by wrapping your arms around his prodigious thickness and squeeze him tightly with your hands, stroking him off with your whole body with enough tightness to make the poor mino' think he's in some poor adventurer's asshole.", false);
	}
	outputText("\n\n", false);
	
	outputText("You lower and raise yourself, bouncing up and down on your " + player.legs() + " to enhance the ", false);
	if(player.biggestTitSize() >= 2) outputText("tit-fucking ", false);
	else outputText("full-body handjob ", false);
	outputText("you're giving out.  In such a position, you're given the perfect view to watch as your strokes draw forth large bubbles of pre, and before you can lose your high, you latch onto the minotaur's vulnerable urethra and suck, tonguing in wide circles around it since you can't open wide enough to accommodate his flare.  Of course, all the attention just makes him flare wider, not just at the tip, but through the whole shaft.  ", false);
	if(player.biggestTitSize() >= 2) outputText("The sudden girth change sends an enticing ripple through your " + allBreastsDescript() + " that's pleasurable enough to make you moan into his steadily-widening urethra.  ", false);
	outputText("You pull off and bounce faster, lost to your lust and the haze of sex-musk permeating the air, intent on seeing just how much this huge stud can spray onto you.\n\n", false);

	outputText("The minotaur does not disappoint.  His hole dilates from the size of the approaching cum-blast, and you sink down his shaft slowly until it's aimed directly at your face.  You close your eyes and feel the first explosion splatter over your " + hairDescript() + " and forehead.  The next takes you full in the face, making it difficult to breathe through the mask of drug-like goo, but a few quick licks gives you a fix and makes it easy to breathe again.  On and on, the minotaur pumps fat ropes of spooge over your body until you're a syrupy, sticky mess that reeks of minotaur pheromones so strongly that dizziness overwhelms you and you fall free of the still-orgasming mino-cock, taking a few final blasts of seed on your " + chestDesc() + " and crotch.  Your hands instinctively shovel a few loads into your " + assholeOrPussy(), false);
	if(player.hasVagina()) outputText(" while the animal part of your brain hopes it makes you pregnant with an equally girthy son", false);
	outputText(".\n\n", false);
	//ADD PREG CHECK
	//Preggers chance!
	player.knockUp(2,432,70);

	outputText("Giggling, you stagger over to the next cock in line and turn around, possessed with the idea of taking its spooge in the most direct way possible – anally.   You pull your butt-cheeks apart and lean back, surprising one of the horny beasts with the warmth of your " + assholeDescript() + " as you slowly relax, spreading over his flare.  He actually squirts ropes of something inside of you, but you've been around minotaurs enough to know that it can't be cum, at least not yet.  The slippery gouts of preseed make it nice and easy to rock back and spear yourself on the first few inches, ", false);
	if(player.analCapacity() < 80) {
		outputText("delighting in the drug-numbed pain of stretching yourself beyond your normal capacity.", false);
	}
	else if(player.analCapacity() < 140) outputText("delighting in the feeling of perfect fullness.", false);
	else outputText("delighting in realizing that you could take far larger than even this virile specimen!", false);
	//(buttchange here: 90)
	buttChange(90,true,false);
																																																																		  
	outputText("\n\nYou slide down the twitching bull-shaft until your " + buttDescript() + " slaps the wall, and you draw slowly away, but you push back harder, turned into a lewd, wanting whore by the massive quantity of minotaur seed in your belly, on your skin, and fogging up the air.  The beast pulls out and you whine plaintively, feeling empty and useless until he plunges back inside and reminds you of your purpose.  He starts to fuck you hard, not caring for your pleasure at all, slamming his horse-cock deep and fast.  Each of his three rings of prepuce ", false);
	if(!player.hasCock()) outputText("drags through your body, touching sensitive nerves you didn't even know you had until you cum, shuddering and shaking like a wanton whore.", false);
	else outputText("presses on your prostate as it squeezes by, making " + sMultiCockDesc() + " drip and spurt freely until you can bear it no longer and cum, shaking and shuddering like a wanton whore.  Jizz drips and pours from " + sMultiCockDesc() + " in a steady stream that pools on the floor, slowly rolling towards a drain that doubtless empties into a tank or greedy goblin cunt.", false);
	outputText("\n\n", false);
	
	outputText("The strength goes completely out of your " + player.legs() + ", but you manage to hold yourself up long enough for your stud to flex his cock inside you and fill up your backdoor with more potent addiction.  You slide off, nerveless and still orgasming as jizz rains on your back from the abandoned cock, rolling off you to add to the ever-widening puddle of fluids on the floor.  Smiling vacantly and addled on more minotaur-cum than any one person has reason to handle, you stumble up on all fours and crawl to the next one.  More...", false);
	//[NEXT]
	stats(0,0,0,0,2,2,-100,2);
	doNext(minotaurSalonFollowUp);
}
function minotaurSalonFollowUp():void {
	spriteSelect(38);
	outputText("", true);
	if(flags[UNKNOWN_FLAG_NUMBER_00142] == 0) {
		//Unlock mino cum purchase
		flags[UNKNOWN_FLAG_NUMBER_00142]++;
		//text goez here
		outputText("Lynnette slaps your face, waking you from your stupor.  What?  Where are you?  You look around and realize you're strapped into a barber's chair and caked with white goop, but why?\n\n", false);
		outputText("The goblin answers before you can vocalize your query, \"<i>Baby, you're so cum-hungry you make my daughters look like chaste virgins!  I haven't seen anyone go to town on minotaurs like that since my mother passed away, Marae guide her soul.  Normally we don't have that much use for the minotaurs outside of a bit of recreational drug-play, but you milked out so much cum that we can start selling it!  Isn't that great!?</i>\"\n\n", false);
		outputText("You nod, a little shocked by your behavior, but already licking your lips in anticipation.  Lynnette smiles and says, \"<i>You can buy some for the usual price, plus 60 gems, but for right now, how about some hair service?  It's on the house!</i>\"", false);
	}
	else outputText("You're woken up with a slap to the face, and still muzzy from your cum-induced glory-hole orgy, you stagger up to your " + player.feet() + ".  Lynnette shakes her stinging palm and apologizes, \"<i>Sorry I have to keep doing that, but you're damned hard to wake after you go on these binges!  Anyways, you've earned some hair treatment if you want it.  Of course you could always buy more of your favorite fluid...</i>\"\n\n", false);
	//Menu
	outputText("Lynnette offers and explains their options, \"<i>So what'll it be hun?  We could cut it down or give you a lengthening treatment. Or you can get a hair-dye to use on your own.  Just remember to come back in a few days for a touchup.</i>\"", false);
	salonPurchaseMenu();
}

function mudFacial():void {
	spriteSelect(38);
	outputText("", true);
	outputText("You sit back in a comfortable chair and pull on a lever to recline it.  The goblins buzz around you, gathering up 'special mud'.  You close your eyes, letting them plaster your " + player.face() + " with the stuff in hopes that it will improve your complexion as much as you've been promised.  A pair of cucumber slices are laid out on your eyes, obscuring your view.\n\n", false);

	outputText("With that finished, the crowd of busty, green-skinned women disperses to leave you in peace.  Time drags on, but eventually the mud hardens and cracks.  As if on cue, tiny hands emerge with wet rags to scrub your face clean.  Once they've finished, you feel like a whole new you! (+10 femininity)", false);
	player.modFem(100,10);
	doNext(13);
}

function sandFacial():void {
	spriteSelect(38);
	outputText("", true);
	outputText("You sit back in a comfortable chair and pull on a lever to recline it.  The goblins buzz around you, gathering up 'special sand'.  You close your eyes, letting them splatter your " + player.face() + " with the rough, textured goop.  It doesn't feel very good, but that won't matter if it makes you as handsome as it's supposed to.\n\n", false);

	outputText("After a while the goblin girls come back and clean the stuff from your face. (+10 masculinity)", false);
	player.modFem(0,10);
	doNext(13);
}