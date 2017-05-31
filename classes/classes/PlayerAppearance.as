package classes {
import classes.BodyParts.Skin;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;

public class PlayerAppearance extends BaseContent {

	public function appearance():void {
		//Temp vars
		var temp:Number  = 0;
		var rando:Number = 0;
		//Determine race type:

		outputText("<font size=\"36\" face=\"Georgia\"><u>Appearance</u></font>\n",true);
		describeRace();
		describeGear();
		describeFaceShape();
		outputText("  It has " + player.faceDesc() + ".", false); //M/F stuff!
		describeEyes();
		describeHairAndEars();
		describeBeard();
		describeTongue();
		describeHorns();
		outputText("[pg]");
		describeBodyShape();
		describeWings();
		describeRearBody();
		describeArms();
		describeLowerBody();

		outputText("\n", false);
	if (player.hasStatusAffect(StatusAffects.GooStuffed))

	{
		outputText("\n<b>Your gravid-looking belly is absolutely stuffed full of goo. There's no way you can get pregnant like this, but at the same time, you look like some fat-bellied breeder.</b>\n");
	}
	//Pregnancy Shiiiiiitz
	if((player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) || (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR) || player.isPregnant())
	{
		if (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS)
		{
			outputText("<b>", false);
			//Compute size
			temp = player.statusAffectv3(StatusAffects.Eggs) + player.statusAffectv2(StatusAffects.Eggs) * 10;
			if(player.pregnancyIncubation <= 50 && player.pregnancyIncubation > 20)
			{
				outputText("Your swollen pregnant belly is as large as a ", false);
				if(temp < 10)
					outputText("basketball.", false);
				if(temp >= 10 && temp < 20)
					outputText("watermelon.", false);
				if(temp >= 20)
					outputText("beach ball.", false);
			}
			if(player.pregnancyIncubation <= 20)
			{
				outputText("Your swollen pregnant belly is as large as a ", false);
				if(temp < 10)
					outputText("watermelon.", false);
				if(temp >= 10 && temp < 20)
					outputText("beach ball.", false);
				if(temp >= 20)
					outputText("large medicine ball.", false);
			}
			outputText("</b>", false);
			temp = 0;
		}
		//Satur preggos - only shows if bigger than regular pregnancy or not pregnancy
		else if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR && player.buttPregnancyIncubation > player.pregnancyIncubation)
		{
			if(player.buttPregnancyIncubation < 125 && player.buttPregnancyIncubation >= 75)
			{
				outputText("<b>You've got the beginnings of a small pot-belly.</b>", false);
			}
			else if(player.buttPregnancyIncubation >= 50)
			{
				outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy, yet it feels odd inside you - wrong somehow.</b>", false);
			}
			else if(player.buttPregnancyIncubation >= 30)
			{
				outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>", false);
			}
			else
			{ //Surely Benoit and Cotton deserve their place in this list
				if (player.pregnancyType == PregnancyStore.PREGNANCY_IZMA || player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_AMILY || (player.pregnancyType == PregnancyStore.PREGNANCY_JOJO && (kGAMECLASS.monk <= 0 || flags[kFLAGS.JOJO_BIMBO_STATE] >= 3)) || player.pregnancyType == PregnancyStore.PREGNANCY_EMBER || player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT || player.pregnancyType == PregnancyStore.PREGNANCY_COTTON || player.pregnancyType == PregnancyStore.PREGNANCY_URTA || player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH)
					outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>", false);
				else if(player.pregnancyType != PregnancyStore.PREGNANCY_MARBLE)
					outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>", false);
				else outputText("\n<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>", false);
			}
		}
		//URTA PREG
		else if (player.pregnancyType == PregnancyStore.PREGNANCY_URTA)
		{
			if(player.pregnancyIncubation <= 432 && player.pregnancyIncubation > 360)
			{
				outputText("<b>Your belly is larger than it used to be.</b>\n", false);
			}
			if(player.pregnancyIncubation <= 360 && player.pregnancyIncubation > 288)
			{
				outputText("<b>Your belly is more noticeably distended.   You're pretty sure it's Urta's.</b>", false);
			}
			if(player.pregnancyIncubation <= 288 && player.pregnancyIncubation > 216)
			{
				outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy, and the baby within is kicking nowadays.</b>", false);
			}
			if(player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 144)
			{
				outputText("<b>Your belly is large and very obviously pregnant to anyone who looks at you.  It's gotten heavy enough to be a pain to carry around all the time.</b>", false);
			}
			if(player.pregnancyIncubation <= 144 && player.pregnancyIncubation > 72)
			{
				outputText("<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way.  It's large and round, frequently moving.</b>", false);
			}
			if(player.pregnancyIncubation <= 72 && player.pregnancyIncubation > 48)
			{
				outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>", false);
			}
			if(player.pregnancyIncubation <= 48)
			{
				outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>", false);
			}
		}
		else if (player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL)
		{
			if(player.buttPregnancyIncubation >= 8)
				outputText("<b>Your stomach is so full of frog eggs that you look about to birth at any moment, your belly wobbling and shaking with every step you take, packed with frog ovum.</b>");
			else outputText("<b>You're stuffed so full with eggs that your belly looks obscenely distended, huge and weighted with the gargantuan eggs crowding your gut. They make your gait a waddle and your gravid tummy wobble obscenely.</b>");
		}
		else if (player.pregnancyType == PregnancyStore.PREGNANCY_FAERIE) { //Belly size remains constant throughout the pregnancy
			outputText("<b>Your belly remains swollen like a watermelon. ");
			if (player.pregnancyIncubation <= 100)
				outputText("It's full of liquid, though unlike a normal pregnancy the passenger you’re carrying is tiny.</b>");
			else if (player.pregnancyIncubation <= 140)
				outputText("It feels like it’s full of thick syrup or jelly.</b>");
			else outputText("It still feels like there’s a solid ball inside your womb.</b>");
		}
		else
		{
			if(player.pregnancyIncubation <= 336 && player.pregnancyIncubation > 280)
			{
				outputText("<b>Your belly is larger than it used to be.</b>", false);
			}
			if(player.pregnancyIncubation <= 280 && player.pregnancyIncubation > 216)
			{
				outputText("<b>Your belly is more noticeably distended.   You are probably pregnant.</b>", false);
			}
			if(player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 180)
			{
				outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy.</b>", false);
			}
			if(player.pregnancyIncubation <= 180 && player.pregnancyIncubation > 120)
			{
				outputText("<b>Your belly is very obviously pregnant to anyone who looks at you.</b>", false);
			}
			if(player.pregnancyIncubation <= 120 && player.pregnancyIncubation > 72)
			{
				outputText("<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way.</b>", false);
			}
			if(player.pregnancyIncubation <= 72 && player.pregnancyIncubation > 48)
			{
				outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>", false);
			}
			if (player.pregnancyIncubation <= 48)
			{ //Surely Benoit and Cotton deserve their place in this list
				if(player.pregnancyType == PregnancyStore.PREGNANCY_IZMA || player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_AMILY || (player.pregnancyType == PregnancyStore.PREGNANCY_JOJO && kGAMECLASS.monk <= 0) || player.pregnancyType == PregnancyStore.PREGNANCY_EMBER || player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT || player.pregnancyType == PregnancyStore.PREGNANCY_COTTON || player.pregnancyType == PregnancyStore.PREGNANCY_URTA || player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA || player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH)
					outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>", false);
				else if (player.pregnancyType != PregnancyStore.PREGNANCY_MARBLE)
					outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>", false);
				else outputText("\n<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>", false);
			}
		}
		outputText("\n", false);
	}
	outputText("\n", false);
	if(player.gillType == GILLS_ANEMONE)
		outputText("A pair of feathery gills are growing out just below your neck, spreading out horizontally and draping down your chest.  They allow you to stay in the water for quite a long time.  ", false);
	//Chesticles..I mean bewbz.
	if(player.breastRows.length == 1)
	{
		outputText("You have " + num2Text(player.breastRows[temp].breasts) + " " + breastDescript(temp) + ", each supporting ", false);
		outputText(num2Text(player.breastRows[temp].nipplesPerBreast) + " "); //Number of nipples.
		if (flags[kFLAGS.USE_METRICS] > 0 ) outputText(int(player.nippleLength * 2.54 * 10) / 10 + "-cm "); //Centimeter display
		else outputText(int(player.nippleLength * 10) / 10 + "-inch "); //Inches display
		outputText(nippleDescript(temp) + (player.breastRows[0].nipplesPerBreast == 1 ? "." : "s."), false); //Nipple description and plural
		if(player.breastRows[0].milkFullness > 75)
			outputText("  Your " + breastDescript(temp) + " are painful and sensitive from being so stuffed with milk.  You should release the pressure soon.", false);
		if(player.breastRows[0].breastRating >= 1)
			outputText("  You could easily fill a " + player.breastCup(temp) + " bra.", false);
		//Done with tits.  Move on.
		outputText("\n", false);
	}
	//many rows
	else
	{
		outputText("You have " + num2Text(player.breastRows.length) + " rows of breasts, the topmost pair starting at your chest.\n", false);
		while (temp < player.breastRows.length)
		{
			if(temp == 0)
				outputText("--Your uppermost rack houses ", false);
			if(temp == 1)
				outputText("\n--The second row holds ", false);
			if(temp == 2)
				outputText("\n--Your third row of breasts contains ", false);
			if(temp == 3)
				outputText("\n--Your fourth set of tits cradles ", false);
			if(temp == 4)
				outputText("\n--Your fifth and final mammary grouping swells with ", false);
			outputText(num2Text(player.breastRows[temp].breasts) + " " + breastDescript(temp) + " with ", false);
			outputText(num2Text(player.breastRows[temp].nipplesPerBreast) + " "); //Number of nipples per breast
			if (flags[kFLAGS.USE_METRICS] > 0 ) outputText(int(player.nippleLength * 2.54 * 10) / 10 + "-cm "); //Centimeter
			else outputText(int(player.nippleLength * 10) / 10 + "-inch "); //Inches
			outputText(nippleDescript(temp) + (player.breastRows[0].nipplesPerBreast == 1 ? " each." : "s each."), false); //Description and Plural
			if(player.breastRows[temp].breastRating >= 1)
				outputText("  They could easily fill a " + player.breastCup(temp) + " bra.", false);
			if(player.breastRows[temp].milkFullness > 75)
				outputText("  Your " + breastDescript(temp) + " are painful and sensitive from being so stuffed with milk.  You should release the pressure soon.", false);
			temp++;
		}
		//Done with tits.  Move on.
		outputText("\n", false);
	}
	//Crotchial stuff - mention snake
	if(player.lowerBody == LOWER_BODY_TYPE_NAGA && player.gender > 0)
	{
		outputText("\nYour sex", false);
		if(player.gender == 3 || player.totalCocks() > 1)
			outputText("es are ", false);
		else outputText(" is ", false);
		outputText("concealed within a cavity in your tail when not in use, though when the need arises, you can part your concealing slit and reveal your true self.\n", false);
	}
	//Crotchial stuff - mention scylla
	if(player.lowerBody == LOWER_BODY_TYPE_SCYLLA)
	{
		if(player.gender == 1)
		{
			outputText("\nYour sex is concealed between your front octopus tentacle legs dangling freely when not in use.\n", false);
		}
		if(player.gender == 2)
		{
			outputText("\nYour sex is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal your true self.\n", false);
		}
		if(player.gender == 3)
		{
			outputText("\nYour sex", false);
			if(player.totalCocks() > 1)
				outputText("es are ", false);
			else outputText(" is ", false);
			outputText("concealed between your front octopus tentacle legs dangling freely. Other set is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal it.\n", false);
		}
	}
	//Cock stuff!
	temp = 0;
	if(player.cocks.length == 1)
	{
		if(player.isTaur())
			outputText("\nYour equipment has shifted to lie between your hind legs, like a feral animal.", false);
		if (flags[kFLAGS.USE_METRICS] > 0) outputText("\nYour " + player.cockDescript(temp) + " is " + int(10 * player.cocks[temp].cockLength * 2.54) / 10 + " cm long and ", false);
		else if (player.isScylla())
			outputText("\nYour equipment has shifted to lie between your front tentacles.", false);
		else outputText("\nYour " + cockDescript(temp) + " is " + int(10*player.cocks[temp].cockLength)/10 + " inches long and ", false);
		if(Math.round(10*player.cocks[temp].cockThickness)/10 < 10)
		{
			if (flags[kFLAGS.USE_METRICS] > 0) {
				if(Math.round(10*player.cocks[temp].cockThickness*2.54)/10 == 1)
					outputText(int(10*player.cocks[temp].cockThickness*2.54)/10 + " centimetre thick.", false);
				else outputText(Math.round(10 * player.cocks[temp].cockThickness*2.54) / 10 + " centimetres thick.", false);
			}
			else {
				if(Math.round(10*player.cocks[temp].cockThickness)/10 == 1)
					outputText(int(10*player.cocks[temp].cockThickness)/10 + " inch thick.", false);
				else outputText(Math.round(10 * player.cocks[temp].cockThickness) / 10 + " inches thick.", false);
			}
		}
		else outputText (num2Text(Math.round(10*player.cocks[temp].cockThickness)/10) + " inches wide.", false);
		//Horsecock flavor
		if(player.cocks[temp].cockType == CockTypesEnum.HORSE)
		{
			outputText("  It's mottled black and brown in a very animalistic pattern.  The 'head' of your shaft flares proudly, just like a horse's.", false);
		}
		//dog cock flavor
		if((player.cocks[temp].cockType == CockTypesEnum.DOG) || (player.cocks[temp].cockType == CockTypesEnum.FOX) || (player.cocks[temp].cockType == CockTypesEnum.WOLF))
		{
			if(player.cocks[temp].knotMultiplier >= 1.8)
				outputText("  The obscenely swollen lump of flesh near the base of your " + player.cockDescript(temp) + " looks almost too big for your cock.", false);
			else if(player.cocks[temp].knotMultiplier >= 1.4)
				outputText("  A large bulge of flesh nestles just above the bottom of your " + player.cockDescript(temp) + ", to ensure it stays where it belongs during mating.", false);
			else if(player.cocks[temp].knotMultiplier > 1)
				outputText("  A small knot of thicker flesh is near the base of your " + player.cockDescript(temp) + ", ready to expand to help you lodge it inside a female.", false);
			//List thickness
			outputText("  The knot is " + Math.round(player.cocks[temp].cockThickness * player.cocks[temp].knotMultiplier * 10)/10 + " inches wide when at full size.", false);
		}
		//
		//Demon cock flavor
		if(player.cocks[temp].cockType == CockTypesEnum.DEMON)
		{
			outputText("  The crown is ringed with a circle of rubbery protrusions that grow larger as you get more aroused.  The entire thing is shiny and covered with tiny, sensitive nodules that leave no doubt about its demonic origins.", false);
		}
		//Tentacle cock flavor
		if(player.cocks[temp].cockType == CockTypesEnum.TENTACLE)
		{
			outputText("  The entirety of its green surface is covered in perspiring beads of slick moisture.  It frequently shifts and moves of its own volition, the slightly oversized and mushroom-like head shifting in coloration to purplish-red whenever you become aroused.", false);
		}
		//Stamen cock flavor
		if(player.cocks[temp].cockType == CockTypesEnum.STAMEN)
		{
			outputText("  It is dark green, tampered, and crowned by several colorful balls near the tip that secrete pollen when aroused.", false);
		}
		//Cat cock flavor
		if(player.cocks[temp].cockType == CockTypesEnum.CAT)
		{
			outputText("  It ends in a single point, much like a spike, and is covered in small, fleshy barbs. The barbs are larger at the base and shrink in size as they get closer to the tip.  Each of the spines is soft and flexible, and shouldn't be painful for any of your partners.", false);
		}
		//Snake cock flavor
		if(player.cocks[temp].cockType == CockTypesEnum.LIZARD)
		{
			outputText("  It's a deep, iridescent purple in color.  Unlike a human penis, the shaft is not smooth, and is instead patterned with multiple bulbous bumps.", false);
		}
		//Anemone cock flavor
		if(player.cocks[temp].cockType == CockTypesEnum.ANEMONE)
		{
			outputText("  The crown is surrounded by tiny tentacles with a venomous, aphrodisiac payload.  At its base a number of similar, longer tentacles have formed, guaranteeing that pleasure will be forced upon your partners.", false);
		}
		//Kangawang flavor
		if(player.cocks[temp].cockType == CockTypesEnum.KANGAROO)
		{
			outputText("  It usually lies coiled inside a sheath, but undulates gently and tapers to a point when erect, somewhat like a taproot.", false);
		}
		//Draconic Cawk Flava flav
		if(player.cocks[temp].cockType == CockTypesEnum.DRAGON)
		{
			outputText("  With its tapered tip, there are few holes you wouldn't be able to get into.  It has a strange, knot-like bulb at its base, but doesn't usually flare during arousal as a dog's knot would.");
		}
		//Bee flavor
		if (player.cocks[temp].cockType == CockTypesEnum.BEE) {
			outputText("  It's a long, smooth black shaft that's rigid to the touch.  Its base is ringed with a layer of four inch long soft bee hair.  The tip has a much finer layer of short yellow hairs.  The tip is very sensitive, and it hurts constantly if you don’t have bee honey on it.");
		}
		//Pig flavor
		if (player.cocks[temp].cockType == CockTypesEnum.PIG) {
			outputText("  It's bright pinkish red, ending in a prominent corkscrew shape at the tip.");
		}
		//Avian flavor
		if (player.cocks[temp].cockType == CockTypesEnum.AVIAN) {
			outputText("  It's a red, tapered cock that ends in a tip.  It rests nicely in a sheath.");
		}
		//Rhino flavor
		if (player.cocks[temp].cockType == CockTypesEnum.RHINO) {
			outputText("  It's a smooth, tough pink colored and takes on a long and narrow shape with an oval shaped bulge along the center.");
		}
		//Echidna flavor
		if (player.cocks[temp].cockType == CockTypesEnum.ECHIDNA) {
			outputText("  It is quite a sight to behold, coming well-equiped with four heads.");
		}
		//Worm flavor
		if(player.hasStatusAffect(StatusAffects.Infested))
			outputText("  Every now and again a slimy worm coated in spunk slips partway out of your " + player.cockDescript(0) + ", tasting the air like a snake's tongue.", false);
		if(player.cocks[temp].sock)
			sockDescript(temp);
		//DONE WITH COCKS, moving on!
		outputText("\n", false);
	}
	if(player.cocks.length > 1)
	{
		temp = 0;
		rando = rand(4);
		if(player.isTaur())
			outputText("\nBetween hind legs of your bestial body you have grown " + player.multiCockDescript() + "!\n", false);
		else if (player.isScylla())
			outputText("\nBetween front tentacles of your bestial body you have grown " + player.multiCockDescript() + "!\n", false);
		else outputText("\nWhere a penis would normally be located, you have instead grown " + player.multiCockDescript() + "!\n", false);
		while(temp < player.cocks.length)

		{

			//middle cock description
			if(rando == 0)
			{
				if(temp == 0)outputText("--Your first ", false);
				else outputText("--Your next ", false);
				outputText(player.cockDescript(temp), false);
				outputText(" is ", false);
				outputText(int(10*player.cocks[temp].cockLength)/10 + " inches long and ", false);
				if(Math.floor(player.cocks[temp].cockThickness) >= 2)
					outputText(num2Text(Math.round(player.cocks[temp].cockThickness * 10)/10) + " inches wide.", false);
				else
				{
					if(player.cocks[temp].cockThickness == 1)
						outputText("one inch wide.", false);
					else outputText(Math.round(player.cocks[temp].cockThickness*10)/10 + " inches wide.", false);
				}
			}
			if(rando == 1)
			{
				outputText("--One of your ", false);
				outputText(player.cockDescript(temp) + "s is " + Math.round(10*player.cocks[temp].cockLength)/10 + " inches long and ", false);
				if(Math.floor(player.cocks[temp].cockThickness) >= 2)
					outputText(num2Text(Math.round(player.cocks[temp].cockThickness * 10)/10) + " inches thick.", false);
				else
				{
					if(player.cocks[temp].cockThickness == 1)
						outputText("one inch thick.", false);
					else outputText(Math.round(player.cocks[temp].cockThickness*10)/10 + " inches thick.", false);
				}
			}
			if(rando == 2)
			{
				if(temp > 0)
					outputText("--Another of your ", false);
				else outputText("--One of your ", false);
				outputText(player.cockDescript(temp) + "s is " + Math.round(10*player.cocks[temp].cockLength)/10 + " inches long and ", false);
				if(Math.floor(player.cocks[temp].cockThickness) >= 2)
					outputText(num2Text(Math.round(player.cocks[temp].cockThickness * 10)/10) + " inches thick.", false);
				else
				{
					if(player.cocks[temp].cockThickness == 1)
						outputText("one inch thick.", false);
					else outputText(Math.round(player.cocks[temp].cockThickness*10)/10 + " inches thick.", false);
				}
			}
			if(rando == 3)
			{
				if(temp > 0)
					outputText("--Your next ", false);
				else outputText("--Your first ", false);
				outputText(player.cockDescript(temp) + " is " + Math.round(10*player.cocks[temp].cockLength)/10 + " inches long and ", false);
				if(Math.floor(player.cocks[temp].cockThickness) >= 2)
					outputText(num2Text(Math.round(player.cocks[temp].cockThickness * 10)/10) + " inches in diameter.", false);
				else
				{
					if(Math.round(player.cocks[temp].cockThickness*10)/10 == 1)
						outputText("one inch in diameter.", false);
					else outputText(Math.round(player.cocks[temp].cockThickness*10)/10 + " inches in diameter.", false);
				}
			}
			//horse cock flavor
			if(player.cocks[temp].cockType == CockTypesEnum.HORSE)
			{
				outputText("  It's mottled black and brown in a very animalistic pattern.  The 'head' of your " + player.cockDescript(temp) + " flares proudly, just like a horse's.", false);
			}
			//dog cock flavor
			if((player.cocks[temp].cockType == CockTypesEnum.DOG) || (player.cocks[temp].cockType == CockTypesEnum.WOLF) || (player.cocks[temp].cockType == CockTypesEnum.FOX))
			{
				outputText("  It is shiny, pointed, and covered in veins, just like a large ");
				if (player.cocks[temp].cockType == CockTypesEnum.DOG)
					outputText("dog's cock.");
				else if (player.cocks[temp].cockType == CockTypesEnum.WOLF)
					outputText("wolf's cock.");
				else
					outputText("fox's cock.");
			}
			//Demon cock flavor
			if(player.cocks[temp].cockType == CockTypesEnum.DEMON)
			{
				outputText("  The crown is ringed with a circle of rubbery protrusions that grow larger as you get more aroused.  The entire thing is shiny and covered with tiny, sensitive nodules that leave no doubt about its demonic origins.", false);
			}
			//Tentacle cock flavor
			if(player.cocks[temp].cockType == CockTypesEnum.TENTACLE)
			{
				outputText("  The entirety of its green surface is covered in perspiring beads of slick moisture.  It frequently shifts and moves of its own volition, the slightly oversized and mushroom-like head shifting in coloration to purplish-red whenever you become aroused.", false);
			}
			//Stamen cock flavor
			if(player.cocks[temp].cockType == CockTypesEnum.STAMEN)
			{
				outputText("  It is dark green, tampered, and crowned by several colorful balls near the tip that secrete pollen when aroused.", false);
			}
			//Cat cock flavor
			if(player.cocks[temp].cockType == CockTypesEnum.CAT)
			{
				outputText("  It ends in a single point, much like a spike, and is covered in small, fleshy barbs. The barbs are larger at the base and shrink in size as they get closer to the tip.  Each of the spines is soft and flexible, and shouldn't be painful for any of your partners.", false);
			}
			//Snake cock flavor
			if(player.cocks[temp].cockType == CockTypesEnum.LIZARD)
			{
				outputText("  It's a deep, iridescent purple in color.  Unlike a human penis, the shaft is not smooth, and is instead patterned with multiple bulbous bumps.", false);
			}
			//Anemone cock flavor
			if(player.cocks[temp].cockType == CockTypesEnum.ANEMONE)
			{
				outputText("  The crown is surrounded by tiny tentacles with a venomous, aphrodisiac payload.  At its base a number of similar, longer tentacles have formed, guaranteeing that pleasure will be forced upon your partners.", false);
			}
			//Kangwang flavor
			if(player.cocks[temp].cockType == CockTypesEnum.KANGAROO)
			{
				outputText("  It usually lies coiled inside a sheath, but undulates gently and tapers to a point when erect, somewhat like a taproot.", false);
			}
			//Draconic Cawk Flava flav
			if(player.cocks[temp].cockType == CockTypesEnum.DRAGON)
			{
				outputText("  With its tapered tip, there are few holes you wouldn't be able to get into.  It has a strange, knot-like bulb at its base, but doesn't usually flare during arousal as a dog's knot would.");
			}
			//Bee flavor
			if (player.cocks[temp].cockType == CockTypesEnum.BEE) {
				outputText("  It's a long, smooth black shaft that's rigid to the touch.  Its base is ringed with a layer of four inch long soft bee hair.  The tip has a much finer layer of short yellow hairs.  The tip is very sensitive, and it hurts constantly if you don’t have bee honey on it.");
			}
			//Pig flavor
			if (player.cocks[temp].cockType == CockTypesEnum.PIG) {
				outputText("  It's bright pinkish red, ending in a prominent corkscrew shape at the tip.");
			}
			//Avian flavor
			if (player.cocks[temp].cockType == CockTypesEnum.AVIAN) {
				outputText("  It's a red, tapered cock that ends in a tip.  It rests nicely in a sheath.");
			}

			if(player.cocks[temp].knotMultiplier > 1) {
				if(player.cocks[temp].knotMultiplier >= 1.8)
					outputText("  The obscenely swollen lump of flesh near the base of your " + player.cockDescript(temp) + " looks almost comically mismatched for your " + player.cockDescript(temp) + ".", false);
				else if(player.cocks[temp].knotMultiplier >= 1.4)
					outputText("  A large bulge of flesh nestles just above the bottom of your " + player.cockDescript(temp) + ", to ensure it stays where it belongs during mating.", false);
				else
					outputText("  A small knot of thicker flesh is near the base of your " + player.cockDescript(temp) + ", ready to expand to help you lodge your " + player.cockDescript(temp) + " inside a female.", false);
				//List knot thickness
				outputText("  The knot is " + Math.floor(player.cocks[temp].cockThickness * player.cocks[temp].knotMultiplier * 10) / 10 + " inches thick when at full size.", false);
			}

			if(player.cocks[temp].sock != "" && player.cocks[temp].sock != null)	// I dunno what was happening, but it looks like .sock is null, as it doesn't exist. I guess this is probably more left over from some of the restucturing.
			{																		// Anyways, check against null values, and stuff works again.
				trace("Found a sock description (WTF even is a sock?)", player.cocks[temp].sock);
				sockDescript(temp);
			}
			temp++;
			rando++;
			outputText("\n", false);
			if(rando > 3) rando = 0;
		}
		//Worm flavor
		if(player.hasStatusAffect(StatusAffects.Infested))
			outputText("Every now and again slimy worms coated in spunk slip partway out of your " + player.multiCockDescriptLight() + ", tasting the air like tongues of snakes.\n", false);
		//DONE WITH COCKS, moving on!
	}
	//Of Balls and Sacks!
	if(player.balls > 0)
	{
		if(player.hasStatusAffect(StatusAffects.Uniball))
		{
			if(player.skinType != SKIN_TYPE_GOO)
				outputText("Your [sack] clings tightly to your groin, holding " + ballsDescript() + " snugly against you.");
			else if(player.skinType == SKIN_TYPE_GOO)
				outputText("Your [sack] clings tightly to your groin, dripping and holding " + ballsDescript() + " snugly against you.");
		}
		else if(player.cockTotal() == 0)
		{
			if(player.skin.hasMagicalTattoo())
				outputText("A " + sackDescript() + " covered by magical tattoo with " + ballsDescript() + " swings heavily under where a penis would normally grow.", false);
			else if(player.skinType == SKIN_TYPE_PLAIN)
				outputText("A " + sackDescript() + " with " + ballsDescript() + " swings heavily under where a penis would normally grow.", false);
			else if(player.hasFur())
				outputText("A fuzzy " + sackDescript() + " filled with " + ballsDescript() + " swings low under where a penis would normally grow.", false);
			else if(player.hasCoatOfType(SKIN_COAT_CHITIN))
				outputText("A chitin " + sackDescript() + " hugs your " + ballsDescript() + " tightly against your body.", false);
			else if(player.hasScales())
				outputText("A scaley " + sackDescript() + " hugs your " + ballsDescript() + " tightly against your body.", false);
			else if(player.skinType == SKIN_TYPE_STONE)
				outputText("A stone-solid sack with " + ballsDescript() + " swings heavily under where a penis would normally grow.", false);
			else if(player.skinType == SKIN_TYPE_GOO)
				outputText("An oozing, semi-solid sack with " + ballsDescript() + " swings heavily under where a penis would normally grow.", false);
		}
		else
		{
			if(player.skin.hasMagicalTattoo())
				outputText("A " + sackDescript() + " covered by magical tattoo with " + ballsDescript() + " swings heavily beneath your " + player.multiCockDescriptLight() + ".", false);
			else if(player.skinType == SKIN_TYPE_PLAIN)
				outputText("A " + sackDescript() + " with " + ballsDescript() + " swings heavily beneath your " + player.multiCockDescriptLight() + ".", false);
			else if(player.hasFur())
				outputText("A fuzzy " + sackDescript() + " filled with " + ballsDescript() + " swings low under your " + player.multiCockDescriptLight() + ".", false);
			else if(player.hasCoatOfType(SKIN_COAT_CHITIN))
				outputText("A chitin " + sackDescript() + " hugs your " + ballsDescript() + " tightly against your body.", false);
			else if(player.hasScales())
				outputText("A scaley " + sackDescript() + " hugs your " + ballsDescript() + " tightly against your body.", false);
			else if(player.skinType == SKIN_TYPE_STONE)
				outputText("A stone-solid sack with " + ballsDescript() + " swings heavily beneath your " + player.multiCockDescriptLight() + ".", false);
			else if(player.skinType == SKIN_TYPE_GOO)
				outputText("An oozing, semi-solid sack with " + ballsDescript() + " swings heavily beneath your " + player.multiCockDescriptLight() + ".", false);
		}
		outputText("  You estimate each of them to be about " + num2Text(Math.round(player.ballSize)) + " ", false);
		if(Math.round(player.ballSize) == 1)
			outputText("inch", false);
		else outputText("inches", false);
		outputText(" across.\n", false);
	}
	//VAGOOZ
	if(player.vaginas.length > 0)
	{
		if(player.gender == 2 && player.isTaur() && player.lowerBody != 26)
			outputText("\nYour womanly parts have shifted to lie between your hind legs, in a rather feral fashion.", false);
		if(player.gender == 2 && player.isScylla())
			outputText("\nYour womanly parts have shifted to lie underneath your tentacle legs.", false);
		outputText("\n", false);
		if (player.vaginas.length == 1)
			if (flags[kFLAGS.USE_METRICS] > 0) outputText("You have a " + vaginaDescript(0) + ", with a " + int(player.clitLength*10*2.54)/10 + "-centimetre clit", false);
			else outputText("You have a " + vaginaDescript(0) + ", with a " + int(player.clitLength*10)/10 + "-inch clit", false);
		if(player.vaginas[0].virgin)
			outputText(" and an intact hymen", false);
		outputText(".  ", false);
		if (player.vaginas.length > 1)
			if (flags[kFLAGS.USE_METRICS] > 0) outputText("You have " + player.vaginas.length+ " " + vaginaDescript(0) + "s, with " + int(player.clitLength*10*2.54)/10 + "-centimetre clits each.  ", false);
			else outputText("You have " + player.vaginas.length+ " " + vaginaDescript(0) + "s, with " + int(player.clitLength*10)/10 + "-inch clits each.  ", false);
		if(player.lib < 50 && player.lust < 50) //not particularly horny

		{
			//Wetness
			if(player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_WET && player.vaginas[0].vaginalWetness< VAGINA_WETNESS_DROOLING)
				outputText("Moisture gleams in ", false);
			if(player.vaginas[0].vaginalWetness>= VAGINA_WETNESS_DROOLING)
			{
				outputText("Occasional beads of ", false);
				outputText("lubricant drip from ", false);
			}
			//Different description based on vag looseness
			if(player.vaginas[0].vaginalWetness>= VAGINA_WETNESS_WET)
			{
				if(player.vaginas[0].vaginalLooseness< VAGINA_LOOSENESS_LOOSE)
					outputText("your " + vaginaDescript(0) + ". ", false);
				if(player.vaginas[0].vaginalLooseness>= VAGINA_LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness< VAGINA_LOOSENESS_GAPING_WIDE)
					outputText("your " + vaginaDescript(0) + ", its lips slightly parted. ", false);
				if(player.vaginas[0].vaginalLooseness>= VAGINA_LOOSENESS_GAPING_WIDE)
					outputText("the massive hole that is your " + vaginaDescript(0) + ".  ", false);
			}
		}
		if((player.lib>=50 || player.lust >=50) && (player.lib< 80 && player.lust < 80)) //kinda horny

		{
			//Wetness
			if(player.vaginas[0].vaginalWetness< VAGINA_WETNESS_WET)
				outputText("Moisture gleams in ", false);
			if(player.vaginas[0].vaginalWetness>= VAGINA_WETNESS_WET && player.vaginas[0].vaginalWetness< VAGINA_WETNESS_DROOLING)
			{
				outputText("Occasional beads of ", false);
				outputText("lubricant drip from ", false);
			}
			if(player.vaginas[0].vaginalWetness>= VAGINA_WETNESS_DROOLING)
			{
				outputText("Thin streams of ", false);
				outputText("lubricant occasionally dribble from ", false);
			}
			//Different description based on vag looseness
			if(player.vaginas[0].vaginalLooseness< VAGINA_LOOSENESS_LOOSE)
				outputText("your " + vaginaDescript(0) + ". ", false);
			if(player.vaginas[0].vaginalLooseness>= VAGINA_LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness< VAGINA_LOOSENESS_GAPING_WIDE)
				outputText("your " + vaginaDescript(0) + ", its lips slightly parted. ", false);
			if(player.vaginas[0].vaginalLooseness>= VAGINA_LOOSENESS_GAPING_WIDE)
				outputText("the massive hole that is your " + vaginaDescript(0) + ".  ", false);
		}
		if((player.lib> 80 || player.lust > 80)) //WTF horny!

		{
			//Wetness
			if(player.vaginas[0].vaginalWetness< VAGINA_WETNESS_WET)

			{
				outputText("Occasional beads of ", false);
				outputText("lubricant drip from ", false);
			}
			if(player.vaginas[0].vaginalWetness>= VAGINA_WETNESS_WET && player.vaginas[0].vaginalWetness< VAGINA_WETNESS_DROOLING)

			{
				outputText("Thin streams of ", false);
				outputText("lubricant occasionally dribble from ", false);
			}
			if(player.vaginas[0].vaginalWetness>= VAGINA_WETNESS_DROOLING)

			{
				outputText("Thick streams of ", false);
				outputText("lubricant drool constantly from ", false);
			}
			//Different description based on vag looseness
			if(player.vaginas[0].vaginalLooseness< VAGINA_LOOSENESS_LOOSE)
				outputText("your " + vaginaDescript(0) + ". ", false);
			if(player.vaginas[0].vaginalLooseness>= VAGINA_LOOSENESS_LOOSE && player.vaginas[0].vaginalLooseness< VAGINA_LOOSENESS_GAPING_WIDE)
				outputText("your " + vaginaDescript(0) + ", its lips slightly parted. ", false);
			if(player.vaginas[0].vaginalLooseness>= VAGINA_LOOSENESS_GAPING_WIDE)
				outputText("the massive hole that is your cunt.  ", false);
		}
		//Line Drop for next descript!
		outputText("\n", false);
	}
	//Genderless lovun'
	if(player.cockTotal() == 0 && player.vaginas.length == 0)
		outputText("\nYou have a curious lack of any sexual endowments.\n", false);


	//BUNGHOLIO
	if(player.ass)
	{
		outputText("\n", false);
		outputText("You have one " + assholeDescript() + ", placed between your butt-cheeks where it belongs.\n", false);
	}
	//Piercings!
	if(player.eyebrowPierced > 0)
		outputText("\nA solitary " + player.eyebrowPShort + " adorns your eyebrow, looking very stylish.", false);
	if(player.earsPierced > 0)
		outputText("\nYour ears are pierced with " + player.earsPShort + ".", false);
	if(player.nosePierced > 0)
		outputText("\nA " + player.nosePShort + " dangles from your nose.", false);
	if(player.lipPierced > 0)
		outputText("\nShining on your lip, a " + player.lipPShort + " is plainly visible.", false);
	if(player.tonguePierced > 0)
		outputText("\nThough not visible, you can plainly feel your " + player.tonguePShort + " secured in your tongue.", false);
	if(player.nipplesPierced == 3)
		outputText("\nYour " + nippleDescript(0) + "s ache and tingle with every step, as your heavy " + player.nipplesPShort + " swings back and forth.", false);
	else if(player.nipplesPierced > 0)
		outputText("\nYour " + nippleDescript(0) + "s are pierced with " + player.nipplesPShort + ".", false);
	if(player.totalCocks() > 0)
	{
		if(player.cocks[0].pierced > 0)
		{
			outputText("\nLooking positively perverse, a " + player.cocks[0].pShortDesc + " adorns your " + player.cockDescript(0) + ".", false);
		}
	}
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00286] == 1)
		outputText("\nA magical, ruby-studded bar pierces your belly button, allowing you to summon Ceraph on a whim.", false);
	if(player.hasVagina())
	{
		if(player.vaginas[0].labiaPierced > 0)
			outputText("\nYour " + vaginaDescript(0) + " glitters with the " + player.vaginas[0].labiaPShort + " hanging from your lips.", false);
		if(player.vaginas[0].clitPierced > 0)
			outputText("\nImpossible to ignore, your " + clitDescript() + " glitters with its " + player.vaginas[0].clitPShort + ".", false);
	}
	//MONEY!
	if(player.gems == 0)
		outputText("\n\n<b>Your money-purse is devoid of any currency.", false);
	if(player.gems > 1)
		outputText("\n\n<b>You have " + addComma(Math.floor(player.gems)) + " shining gems, collected in your travels.", false);
	if(player.gems == 1)
		outputText("\n\n<b>You have " + addComma(Math.floor(player.gems)) + " shining gem, collected in your travels.", false);
	menu();
	addButton(0, "Next", playerMenu);
	addButton(10, "RacialScores", RacialScores);
	flushOutputTextToGUI();
}
	public function describeBodyShape():void {
		outputText("You have a humanoid shape with the usual body", false);
		if (player.skin.coverage == Skin.COVERAGE_LOW) {
			outputText(" partialy covered with [skin coat]");
		} else if (player.skin.coverage >= Skin.COVERAGE_MEDIUM) {
			outputText(" covered with [skin coat]");
		}
		outputText(", arms, hands and fingers.", false);
		if (player.skinType == SKIN_TYPE_PLAIN && player.skinAdj == "glossy" && player.skinTone == "white and black") outputText(" However your skin is pitch black with a white underbelly that runs on the underside of your limbs and has a glossy shine, similar to that of an orca.", false);
	}
	public function describeGear():void {
		outputText("  <b>You are currently " + (player.armorDescript() != "gear" ? "wearing your " + player.armorDescript() : "naked") + "" + " and using your " + player.weaponName + " as a melee weapon", false);
		if (player.weaponRangeName != "nothing")
			outputText(",  " + player.weaponRangeName + " as range weapon");
		if (player.shieldName != "nothing")
			outputText("  and " + player.shieldName + " as your shield");
		outputText(".");
		if (player.jewelryName != "nothing" && player.jewelryName != "fox hairpin")
			outputText("  Girding one of your fingers is " + player.jewelryName + ".");
		if (player.jewelryName == "fox hairpin")
			outputText("  In your hair is " + player.jewelryName + ".");
		if (player.hasKeyItem("Fenrir Collar") >= 0) outputText("  On your neck is Fenrir spiked Collar its chain still hanging down from it and clinking with an ominous metallic sound as you walk around.", false);
		outputText("</b>");
	}
	public function describeRace():void {
//Discuss race
		if (player.race() != player.startingRace) outputText("You began your journey as a " + player.startingRace + ", but gave that up as you explored the dangers of this realm.  ", false);
		//Height and race.
		outputText("You are a ");
		if (flags[kFLAGS.USE_METRICS] > 0) outputText(Math.round(100 * (player.tallness * 2.54) / 100) + " centimetre");
		else outputText(Math.floor(player.tallness / 12) + " foot " + player.tallness % 12 + " inch");
		outputText(" tall [malefemaleherm] [race], with [bodytype].", false);
	}
	public function describeLowerBody():void {
		if (player.isTaur() || player.lowerBody == LOWER_BODY_TYPE_DRIDER_LOWER_BODY || player.lowerBody == LOWER_BODY_TYPE_SCYLLA || player.lowerBody == LOWER_BODY_TYPE_PLANT_FLOWER) {
			if (player.lowerBody == LOWER_BODY_TYPE_HOOFED)
				outputText("  From the waist down you have the body of a horse, with all " + num2Text(player.legCount) + " legs capped by hooves.", false);
			else if (player.lowerBody == LOWER_BODY_TYPE_PONY)
				outputText("  From the waist down you have an incredibly cute and cartoonish parody of a horse's body, with all " + num2Text(player.legCount) + " legs ending in flat, rounded feet.", false);
			else if (player.lowerBody == LOWER_BODY_TYPE_DRIDER_LOWER_BODY)
				outputText("  Where your legs would normally start you have grown the body of a spider, with " + num2Text(player.legCount) + " spindly legs that sprout from its sides.", false);
			else if (player.lowerBody == LOWER_BODY_TYPE_SCYLLA)
				outputText("  Where your legs would normally start you have grown the body of an octopus, with " + num2Text(player.legCount) + " tentacle legs that sprout from your [hips].", false);
			else if (player.lowerBody == LOWER_BODY_TYPE_PLANT_FLOWER)
				outputText("  Around your waist, the petals of a large pink orchid expand, big enough to engulf you entirely on their own, coupled with a pitcher-like structure in the centre, which is filled with syrupy nectar straight from your loins. When you wish to rest, these petals draw up around you, encapsulating you in a beautiful bud.  While you don't technically have legs anymore, you can still move around on your " + num2Text(player.legCount) + " vine-like stamens.", false);
			else
				outputText("  Where your legs would normally start you have grown the body of a feral animal, with all " + num2Text(player.legCount) + " legs.", false);
		}
		//Hip info only displays if you aren't a centaur.
		if (player.isBiped() || player.lowerBody == LOWER_BODY_TYPE_NAGA) {
			if (player.thickness > 70) {
				outputText("  You have " + hipDescript(), false);
				if (player.hipRating < 6) {
					if (player.tone < 65)
						outputText(" buried under a noticeable muffin-top, and", false);
					else outputText(" that blend into your pillar-like waist, and", false);
				}
				if (player.hipRating >= 6 && player.hipRating < 10)
					outputText(" that blend into the rest of your thick form, and", false);
				if (player.hipRating >= 10 && player.hipRating < 15)
					outputText(" that would be much more noticeable if you weren't so wide-bodied, and", false);
				if (player.hipRating >= 15 && player.hipRating < 20)
					outputText(" that sway and emphasize your thick, curvy shape, and", false);
				if (player.hipRating >= 20)
					outputText(" that sway hypnotically on your extra-curvy frame, and", false);
			}
			else if (player.thickness < 30) {
				outputText("  You have " + hipDescript(), false);
				if (player.hipRating < 6)
					outputText(" that match your trim, lithe body, and", false);
				if (player.hipRating >= 6 && player.hipRating < 10)
					outputText(" that sway to and fro, emphasized by your trim body, and", false);
				if (player.hipRating >= 10 && player.hipRating < 15)
					outputText(" that swell out under your trim waistline, and", false);
				if (player.hipRating >= 15 && player.hipRating < 20)
					outputText(", emphasized by your narrow waist, and", false);
				if (player.hipRating >= 20)
					outputText(" that swell disproportionately wide on your lithe frame, and", false);
			}
			//STANDARD
			else {
				outputText("  You have " + hipDescript(), false);
				if (player.hipRating < 6)
					outputText(", and", false);
				if (player.femininity > 50) {
					if (player.hipRating >= 6 && player.hipRating < 10)
						outputText(" that draw the attention of those around you, and", false);
					if (player.hipRating >= 10 && player.hipRating < 15)
						outputText(" that make you walk with a sexy, swinging gait, and", false);
					if (player.hipRating >= 15 && player.hipRating < 20)
						outputText(" that make it look like you've birthed many children, and", false);
					if (player.hipRating >= 20)
						outputText(" that make you look more like an animal waiting to be bred than any kind of human, and", false);
				}
				else {
					if (player.hipRating >= 6 && player.hipRating < 10)
						outputText(" that give you a graceful stride, and", false);
					if (player.hipRating >= 10 && player.hipRating < 15)
						outputText(" that add a little feminine swing to your gait, and", false);
					if (player.hipRating >= 15 && player.hipRating < 20)
						outputText(" that force you to sway and wiggle as you move, and", false);
					if (player.hipRating >= 20) {
						outputText(" that give your ", false);
						if (player.balls > 0)
							outputText("balls plenty of room to breathe", false);
						else if (player.hasCock())
							outputText(player.multiCockDescript() + " plenty of room to swing", false);
						else if (player.hasVagina())
							outputText(vaginaDescript() + " a nice, wide berth", false);
						else outputText("vacant groin plenty of room", false);
						outputText(", and", false);
					}
				}
			}
		}
		//ASS
		//Horse version
		if (player.isTaur()) {
			//FATBUTT
			if (player.tone < 65) {
				outputText("  Your " + buttDescript(), false);
				if (player.buttRating < 4)
					outputText(" is lean, from what you can see of it.", false);
				if (player.buttRating >= 4 && player.buttRating < 6)
					outputText(" looks fairly average.", false);
				if (player.buttRating >= 6 && player.buttRating < 10)
					outputText(" is fairly plump and healthy.", false);
				if (player.buttRating >= 10 && player.buttRating < 15)
					outputText(" jiggles a bit as you trot around.", false);
				if (player.buttRating >= 15 && player.buttRating < 20)
					outputText(" jiggles and wobbles as you trot about.", false);
				if (player.buttRating >= 20)
					outputText(" is obscenely large, bordering freakish, even for a horse.", false);
			}
			//GIRL LOOK AT DAT BOOTY
			else {
				outputText("  Your " + buttDescript(), false);
				if (player.buttRating < 4)
					outputText(" is barely noticeably, showing off the muscles of your haunches.", false);
				if (player.buttRating >= 4 && player.buttRating < 6)
					outputText(" matches your toned equine frame quite well.", false);
				if (player.buttRating >= 6 && player.buttRating < 10)
					outputText(" gives hints of just how much muscle you could put into a kick.", false);
				if (player.buttRating >= 10 && player.buttRating < 15)
					outputText(" surges with muscle whenever you trot about.", false);
				if (player.buttRating >= 15 && player.buttRating < 20)
					outputText(" flexes its considerable mass as you move.", false);
				if (player.buttRating >= 20)
					outputText(" is stacked with layers of muscle, huge even for a horse.", false);
			}
		}
		//Non-horse PCs
		else if (player.isBiped() || player.lowerBody == LOWER_BODY_TYPE_NAGA) {
			//TUBBY ASS
			if (player.tone < 60) {
				outputText(" your " + buttDescript(), false);
				if (player.buttRating < 4)
					outputText(" looks great under your gear.", false);
				if (player.buttRating >= 4 && player.buttRating < 6)
					outputText(" has the barest amount of sexy jiggle.", false);
				if (player.buttRating >= 6 && player.buttRating < 10)
					outputText(" fills out your clothing nicely.", false);
				if (player.buttRating >= 10 && player.buttRating < 15)
					outputText(" wobbles enticingly with every step.", false);
				if (player.buttRating >= 15 && player.buttRating < 20)
					outputText(" wobbles like a bowl full of jello as you walk.", false);
				if (player.buttRating >= 20)
					outputText(" is obscenely large, bordering freakish, and makes it difficult to run.", false);
			}
			//FITBUTT
			else {
				outputText(" your " + buttDescript(), false);
				if (player.buttRating < 4)
					outputText(" molds closely against your form.", false);
				if (player.buttRating >= 4 && player.buttRating < 6)
					outputText(" contracts with every motion, displaying the detailed curves of its lean musculature.", false);
				if (player.buttRating >= 6 && player.buttRating < 10)
					outputText(" fills out your clothing nicely.", false);
				if (player.buttRating >= 10 && player.buttRating < 15)
					outputText(" stretches your gear, flexing it with each step.", false);
				if (player.buttRating >= 15 && player.buttRating < 20)
					outputText(" threatens to bust out from under your kit each time you clench it.", false);
				if (player.buttRating >= 20)
					outputText(" is marvelously large, but completely stacked with muscle.", false);
			}
		}
		//TAILS
		describeTail();
		//</mod>
		//LOWERBODY SPECIAL
		if (player.lowerBody == LOWER_BODY_TYPE_HUMAN)
			outputText("  " + Num2Text(player.legCount) + " normal human legs grow down from your waist, ending in normal human feet.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_FERRET)
			outputText("  " + Num2Text(player.legCount) + " furry, digitigrade legs form below your [hips].  The fur is thinner on the feet, and your toes are tipped with claws.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_HOOFED)
			outputText("  Your " + num2Text(player.legCount) + " legs are muscled and jointed oddly, covered in [skin coat.color] fur, and end in a bestial hooves.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_DOG)
			outputText("  " + Num2Text(player.legCount) + " digitigrade legs grow downwards from your waist, ending in dog-like hind-paws.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_WOLF)
			outputText("  " + Num2Text(player.legCount) + " digitigrade legs grow downwards from your waist, ending in clawed wolf-like hind-paws.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_NAGA)
			outputText("  Below your waist your flesh is fused together into a very long snake-like tail.", false);
		//Horse body is placed higher for readability purposes
		else if (player.lowerBody == LOWER_BODY_TYPE_DEMONIC_HIGH_HEELS)
			outputText("  Your " + num2Text(player.legCount) + " perfect lissome legs end in mostly human feet, apart from the horn protruding straight down from the heel that forces you to walk with a sexy, swaying gait.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_DEMONIC_CLAWS)
			outputText("  Your " + num2Text(player.legCount) + " lithe legs are capped with flexible clawed feet.  Sharp black nails grow where once you had toe-nails, giving you fantastic grip.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_BEE)
			outputText("  Your " + num2Text(player.legCount) + " legs are covered in a shimmering insectile carapace up to mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.  A bit of downy yellow and black fur fuzzes your upper thighs, just like a bee.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_GOO)
			outputText("  In place of legs you have a shifting amorphous blob.  Thankfully it's quite easy to propel yourself around on.  The lowest portions of your " + player.armorName + " float around inside you, bringing you no discomfort.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_CAT)
			outputText("  " + Num2Text(player.legCount) + " digitigrade legs grow downwards from your waist, ending in soft, padded cat-paws.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_LIZARD)
			outputText("  " + Num2Text(player.legCount) + " digitigrade legs grow down from your " + hipDescript() + ", ending in clawed feet.  There are three long toes on the front, and a small hind-claw on the back.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_SALAMANDER)
			outputText("  " + Num2Text(player.legCount) + " digitigrade legs covered in thick, leathery red scales up to the mid-thigh grow down from your " + hipDescript() + ", ending in clawed feet.  There are three long toes on the front, and a small hind-claw on the back.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_BUNNY)
			outputText("  Your " + num2Text(player.legCount) + " legs thicken below the waist as they turn into soft-furred rabbit-like legs.  You even have large bunny feet that make hopping around a little easier than walking.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_HARPY)
			outputText("  Your " + num2Text(player.legCount) + " legs are covered with [haircolor] plumage.  Thankfully the thick, powerful thighs are perfect for launching you into the air, and your feet remain mostly human, even if they are two-toed and tipped with talons.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_KANGAROO)
			outputText("  Your " + num2Text(player.legCount) + " furry legs have short thighs and long calves, with even longer feet ending in prominently-nailed toes.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_CHITINOUS_SPIDER_LEGS)
			outputText("  Your " + num2Text(player.legCount) + " legs are covered in a reflective black, insectile carapace up to your mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_FOX)
			outputText("  Your " + num2Text(player.legCount) + " legs are crooked into high knees with hocks and long feet, like those of a fox; cute bulbous toes decorate the ends.");
		else if (player.lowerBody == LOWER_BODY_TYPE_DRAGON)
			outputText("  " + Num2Text(player.legCount) + " human-like legs grow down from your " + hipDescript() + ", sheathed in scales and ending in clawed feet.  There are three long toes on the front, and a small hind-claw on the back.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_RACCOON)
			outputText("  Your " + num2Text(player.legCount) + " legs, though covered in fur, are humanlike.  Long feet on the ends bear equally long toes, and the pads on the bottoms are quite sensitive to the touch.");
		else if (player.lowerBody == LOWER_BODY_TYPE_CLOVEN_HOOFED)
			outputText("  " + Num2Text(player.legCount) + " digitigrade legs form below your [hips], ending in cloven hooves.");
		else if (player.lowerBody == LOWER_BODY_TYPE_MANTIS)
			outputText("  Your " + num2Text(player.legCount) + " legs are covered in a shimmering green, insectile carapace up to mid-thigh, looking more like a set of 'fuck-me-boots' than exoskeleton.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_SHARK)
			outputText("  Your " + num2Text(player.legCount) + " legs are mostly human save for the webing between your toes.");
		else if (player.lowerBody == LOWER_BODY_TYPE_GARGOYLE) {
			outputText("  Your " + num2Text(player.legCount) + " digitigrade ");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) outputText("marble");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) outputText("alabaster");
			outputText(" legs ends up with stone sharp clawed feet. There are three long toes on the front, and a small hind claw on the back.");
		}
		else if (player.lowerBody == LOWER_BODY_TYPE_PLANT_HIGH_HEELS)
			outputText("  Your " + num2Text(player.legCount) + " perfect lissome legs end in human feet, apart from delicate vines covered in spade-like leaves crawling around them on the whole length.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_PLANT_ROOT_CLAWS)
			outputText("  Your " + num2Text(player.legCount) + " legs looks quite normal aside feet.  They turned literally into roots only vaguely retaining the shape of the feet.", false);
//	else if(player.lowerBody == LOWER_BODY_TYPE_PLANT_FLOWER)
//		outputText("  Around your waist just under your nectar coated pussy expends the petals of a large orchid big enough to engulf you entirely. While you don't technically have legs you can walk around on your " + num2Text(player.legCount)+ " vines which pretty much look like tentacle cocks.", false);
		else if (player.lowerBody == LOWER_BODY_TYPE_LION)
			outputText("  Your " + num2Text(player.legCount) + " legs, covered in dark fur up to the thigh where it turns white, end up with digitigrade lion paws. You can dash on all fours as gracefully as you would on two legs.");
		else if (player.lowerBody == LOWER_BODY_TYPE_YETI)
			outputText("  Your " + num2Text(player.legCount) + " fur covered legs end with a pair of very large yeti feet, leaving large tracks and granting you easy mobility in the snow.");
		else if (player.lowerBody == LOWER_BODY_TYPE_ORCA)
			outputText("  Your " + num2Text(player.legCount) + " legs are mostly human save for the webbing between your toes that assists you in swimming.");
		else if (player.lowerBody == LOWER_BODY_TYPE_YGG_ROOT_CLAWS)
			outputText("  Your " + num2Text(player.legCount) + " legs looks quite normal until your feet. Your roots have condensed into a self-contained shape of three clawed toes on the front, and a small hind-claw in the back. You doubt they can gather moisture very well like this, but at least you have an excellent grip.");
		if (player.findPerk(PerkLib.Incorporeality) >= 0)
			outputText("  Of course, your " + player.legs() + " are partially transparent due to their ghostly nature.", false); // isn't goo transparent anyway?
	}
	public function describeTail():void {
		if (player.tailType == TAIL_TYPE_HORSE)
			outputText("  A long [skin coat.color] horsetail hangs from your " + buttDescript() + ", smooth and shiny.", false);
		if (player.tailType == TAIL_TYPE_FERRET)
			outputText("  A long ferret tail sprouts from above your [butt].  It is thin, tapered, and covered in shaggy [skin coat.color] fur.", false);
		if (player.tailType == TAIL_TYPE_DOG)
			outputText("  A fuzzy [skin coat.color] dogtail sprouts just above your " + buttDescript() + ", wagging to and fro whenever you are happy.", false);
		if (player.tailType == TAIL_TYPE_DEMONIC)
			outputText("  A narrow tail ending in a spaded tip curls down from your " + buttDescript() + ", wrapping around your " + player.leg() + " sensually at every opportunity.", false);
		if (player.tailType == TAIL_TYPE_COW)
			outputText("  A long cowtail with a puffy tip swishes back and forth as if swatting at flies.", false);
		if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN) {
			outputText("  A large, spherical spider-abdomen has grown out from your backside, covered in shiny black chitin.  Though it's heavy and bobs with every motion, it doesn't seem to slow you down.", false);
			if (player.tailVenom > 50 && player.tailVenom < 80)
				outputText("  Your bulging arachnid posterior feels fairly full of webbing.", false);
			if (player.tailVenom >= 80 && player.tailVenom < 100)
				outputText("  Your arachnid rear bulges and feels very full of webbing.", false);
			if (player.tailVenom == 100)
				outputText("  Your swollen spider-butt is distended with the sheer amount of webbing it's holding.", false);
		}
		if (player.tailType == TAIL_TYPE_BEE_ABDOMEN) {
			outputText("  A large insectile bee-abdomen dangles from just above your backside, bobbing with its own weight as you shift.  It is covered in hard chitin with black and yellow stripes, and tipped with a dagger-like stinger.", false);
			if (player.tailVenom > 50 && player.tailVenom < 80)
				outputText("  A single drop of poison hangs from your exposed stinger.", false);
			if (player.tailVenom >= 80 && player.tailVenom < 100)
				outputText("  Poisonous bee venom coats your stinger completely.", false);
			if (player.tailVenom == 100)
				outputText("  Venom drips from your poisoned stinger regularly.", false);
		}
		if (player.tailType == TAIL_TYPE_SCORPION) {
			outputText("  A large insectile scorpion-like tail dangles from just above your backside, bobbing with its own weight as you shift.  It is covered in hard chitin and tipped with a stinger.", false);
			if (player.tailVenom > 75 && player.tailVenom < 120)
				outputText("  A single drop of poison hangs from your exposed stinger.", false);
			if (player.tailVenom >= 120 && player.tailVenom < 150)
				outputText("  Poisonous bee venom coats your stinger completely.", false);
			if (player.tailVenom == 150)
				outputText("  Venom drips from your poisoned stinger regularly.", false);
		}
		if (player.tailType == TAIL_TYPE_MANTICORE_PUSSYTAIL) {
			outputText("  Your tail is covered in armored chitin from the base to the tip, it ends in a flower-like bulb. You can open and close your tail tip at will and it’s pussy-like interior can be used to milk male organs. ", false);
			outputText("The deadly set of spikes covering the tip regularly drips with your potent venom. When impaling your tail spikes in a prey isn’t enough you can fling them at a target on a whim like the most talented archer.", false);
		}
		if (player.tailType == TAIL_TYPE_MANTIS_ABDOMEN)
			outputText("  A large insectile mantis-abdomen dangles from just above your backside, bobbing with its own weight as you shift.  It is covered in hard greenish chitinous material.", false);
		if (player.tailType == TAIL_TYPE_SHARK) {
			outputText("  A long shark-tail trails down from your backside, swaying to and fro while giving you a dangerous air.", false);
		}
		if (player.tailType == TAIL_TYPE_CAT) {
			outputText("  A soft [skin coat.color] cat-tail sprouts just above your " + buttDescript() + ", curling and twisting with every step to maintain perfect balance.", false);
		}
		if (player.tailType == TAIL_TYPE_LIZARD) {
			outputText("  A tapered tail hangs down from just above your " + assDescript() + ".  It sways back and forth, assisting you with keeping your balance.", false);
		}
		if (player.tailType == TAIL_TYPE_SALAMANDER) {
			outputText("  A tapered, covered in red scales tail hangs down from just above your " + assDescript() + ".  It sways back and forth, assisting you with keeping your balance. When you are in battle or when you want could set ablaze whole tail in red-hot fire.", false);
		}
		if (player.tailType == TAIL_TYPE_RABBIT)
			outputText("  A short, soft bunny tail sprouts just above your " + assDescript() + ", twitching constantly whenever you don't think about it.", false);
		else if (player.tailType == TAIL_TYPE_HARPY)
			outputText("  A tail of feathers fans out from just above your " + assDescript() + ", twitching instinctively to help guide you if you were to take flight.", false);
		else if (player.tailType == TAIL_TYPE_KANGAROO) {
			outputText("  A conical, ", false);
			if (player.hasFur()) outputText("furry, " + player.coatColor, false);
			else outputText("gooey, " + player.skinTone, false);
			outputText(", tail extends from your " + assDescript() + ", bouncing up and down as you move and helping to counterbalance you.", false);
		}
		else if (player.tailType == TAIL_TYPE_FOX) {
			if (player.tailCount <= 1)
				outputText("  A swishing [skin coat.color] fox's brush extends from your " + assDescript() + ", curling around your body - the soft fur feels lovely.");
			else outputText("  " + Num2Text(player.tailCount) + " swishing [skin coat.color] fox's tails extend from your " + assDescript() + ", curling around your body - the soft fur feels lovely.");
		}
		else if (player.tailType == TAIL_TYPE_DRACONIC) {
			outputText("  A thin, scaly, prehensile reptilian tail, almost as long as you are tall, swings behind you like a living bullwhip.  Its tip menaces with spikes of bone, meant to deliver painful blows.");
		}
		//appearance
		else if (player.tailType == TAIL_TYPE_RACCOON) {
			outputText("  A black-and-[skin coat.color]-ringed raccoon tail waves behind you.");
		}
		else if (player.tailType == TAIL_TYPE_MOUSE) {
			//appearance
			outputText("  A naked, " + player.skinTone + " mouse tail pokes from your butt, dragging on the ground and twitching occasionally.");
		}
		//<mod>
		else if (player.tailType == TAIL_TYPE_BEHEMOTH) {
			outputText("  A long seemingly-tapering tail pokes from your butt, ending in spikes just like behemoth's.");
		}
		else if (player.tailType == TAIL_TYPE_PIG) {
			outputText("  A short, curly pig tail sprouts from just above your butt.");
		}
		else if (player.tailType == TAIL_TYPE_GOAT) {
			outputText("  A very short, stubby goat tail sprouts from just above your butt.");
		}
		else if (player.tailType == TAIL_TYPE_RHINO) {
			outputText("  A ropey rhino tail sprouts from just above your butt, swishing from time to time.");
		}
		else if (player.tailType == TAIL_TYPE_ECHIDNA) {
			outputText("  A stumpy echidna tail forms just about your [ass].");
		}
		else if (player.tailType == TAIL_TYPE_DEER) {
			outputText("  A very short, stubby deer tail sprouts from just above your butt.");
		}
		else if (player.tailType == TAIL_TYPE_WOLF) {
			outputText("  A bushy [skin coat.color] wolf tail sprouts just above your " + assDescript() + ", wagging to and fro whenever you are happy.");
		}
		else if (player.tailType == TAIL_TYPE_GARGOYLE) {
			outputText("  A long spiked tail hang down from just above your " + assDescript() + ". It sways back and forth assisting in keeping your balance.");
		}
		else if (player.tailType == TAIL_TYPE_ORCA) {
			outputText("  A long, powerful Orca tail trails down from your backside, swaying to and fro, always ready to propulse you through the water or smack an opponent on the head. It has a huge fin at the end and a smaller one not so far from your ass.");
		}
		else if (player.tailType == TAIL_TYPE_YGGDRASIL) {
			outputText("  A thin prehensile reptilian tail swings behind, covered by [skin coat]");
			outputText(".  Adorning the tip of your tail is a leaf, bobbing with each of your tail’s movements.");
		}
	}
	public function describeArms():void {
//Wing arms
		if (player.armType == ARM_TYPE_HARPY)
			outputText("  Feathers hang off your arms from shoulder to wrist, giving them a slightly wing-like look.", false);
		if (player.armType == ARM_TYPE_PHOENIX)
			outputText("  Crimson feathers hang off your arms from shoulder to wrist, giving them a slightly wing-like look.", false);
		else if (player.armType == ARM_TYPE_SPIDER)
			outputText("  Shining black exoskeleton covers your arms from the biceps down, resembling a pair of long black gloves from a distance.", false);
		else if (player.armType == ARM_TYPE_MANTIS)
			outputText("  Shining green exoskeleton covers your arms from the biceps down with a long and sharp scythes extending from the wrists.", false);
		else if (player.armType == ARM_TYPE_BEE)
			outputText("  Shining black exoskeleton covers your arms from the biceps down, resembling a pair of long black gloves ended with a yellow fuzz from a distance.", false);
		else if (player.armType == ARM_TYPE_SALAMANDER)
			outputText("  Shining thick, leathery red scales covers your arms from the biceps down and your fingernails are now a short curved claws.", false);
		else if (player.armType == ARM_TYPE_PLANT)
			outputText("  Delicate vines crawl down from the upper parts of your arms to your wrists covered in spade-like leaves, that bob whenever you move.", false);
		else if (player.armType == ARM_TYPE_PLANT2)
			outputText("  Vines crawl down from your shoulders to your wrists, tipped with slits that drool precum. They look like innocent decorations from a distance.", false);
		else if (player.armType == ARM_TYPE_SHARK)
			outputText("  A middle sized shark-like fin has sprouted on each of your forearms near the elbow.  Additionaly skin between your fingers forming a small webbings helpful when swimming.", false);
		else if (player.armType == ARM_TYPE_GARGOYLE) {
			outputText("  Your ");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) outputText("marble");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) outputText("alabaster");
			outputText(" arms end up with a pair of stone sharp clawed hand.", false);
		}
		else if (player.armType == ARM_TYPE_WOLF || player.armType == ARM_TYPE_FOX)
			outputText("  Your arms are covered in thick fur ending up with clawed hands with animal like paw pads.", false);
		else if (player.armType == ARM_TYPE_LION)
			outputText("  Your arms are covered in dark-fur up to your shoulder where it turns to white. They end with a pair of five-toed lion paws armed with lethal claws.", false);
		else if (player.armType == ARM_TYPE_KITSUNE)
			outputText("  Your arms are somewhat human save for your sharp nails.", false);
		else if (player.armType == ARM_TYPE_LIZARD || player.armType == ARM_TYPE_DRAGON)
			outputText("  Shining thick, leathery scales covers your arms from the biceps down and your fingernails are now a short curved claws.", false);
		else if (player.armType == ARM_TYPE_YETI)
			outputText("  Your two arms covered with thick fur end with large, powerful yeti hands. You can use them to smash or punch things when you're angry.", false);
		else if (player.armType == ARM_TYPE_ORCA)
			outputText("  A middle sized orca-like fin has sprouted on each of your forearms near the elbow. Additionally, the skin between your fingers forms a small webbing that is helpful when swimming.", false);
	}
	public function describeRearBody():void {
		if (player.rearBody == REAR_BODY_FENRIR_ICE_SPIKES) {
			outputText("  Jagged ice shards grows out of your back providing both excellent defence and giving you a menacing look.");
		}
		else if (player.rearBody == REAR_BODY_LION_MANE) {
			outputText("  Around your neck there is a thick mane of fur. It looks great on you.");
		}
		else if (player.rearBody == REAR_BODY_SHARK_FIN) {
			outputText("  A large shark-like fin has sprouted between your shoulder blades.  With it you have far more control over swimming underwater.");
		}
		else if (player.rearBody == REAR_BODY_ORCA_BLOWHOLE) {
			outputText("  Between your shoulder blades is a blowhole that allows to breath in air from your back while swimming, just like an orca.");
		}
	}
	public function describeWings():void {
//WINGS!
		if (player.wingType == WING_TYPE_BEE_LIKE_SMALL)
			outputText("  A pair of tiny-yet-beautiful bee-wings sprout from your back, too small to allow you to fly.", false);
		if (player.wingType == WING_TYPE_BEE_LIKE_LARGE)
			outputText("  A pair of large bee-wings sprout from your back, reflecting the light through their clear membranes beautifully.  They flap quickly, allowing you to easily hover in place or fly.", false);
		if (player.wingType == WING_TYPE_MANTIS_LIKE_SMALL)
			outputText("  A pair of tiny mantis-wings sprout from your back, too small to allow you to fly.", false);
		if (player.wingType == WING_TYPE_MANTIS_LIKE_LARGE)
			outputText("  A pair of large mantis-wings sprout from your back, reflecting the light through their clear membranes beautifully.  They flap quickly, allowing you to easily hover in place or fly.", false);
		if (player.wingType == WING_TYPE_BAT_LIKE_TINY)
			outputText("  A pair of tiny bat-like demon-wings sprout from your back, flapping cutely, but otherwise being of little use.", false);
		if (player.wingType == WING_TYPE_BAT_LIKE_LARGE)
			outputText("  A pair of large bat-like demon-wings fold behind your shoulders.  With a muscle-twitch, you can extend them, and use them to soar gracefully through the air.", false);
		if (player.wingType == WING_TYPE_BAT_LIKE_LARGE_2)
			outputText("  Two pairs of large bat-like demon-wings fold behind your shoulders.  With a muscle-twitch, you can extend them, and use them to soar gracefully through the air.", false);
		if (player.wingType == WING_TYPE_MANTICORE_LIKE_SMALL)
			outputText("  A pair of small leathery wings covered with fur rest on your back. Despite being too small to allow flight they at least look cute on you.", false);
		if (player.wingType == WING_TYPE_MANTICORE_LIKE_LARGE)
			outputText("  A pair of large ominous leathery wings covered with fur expand from your back. You can open them wide to soar high in search of your next prey.", false);
		if (player.wingType == WING_TYPE_FEATHERED_LARGE)
			outputText("  A pair of large, feathery wings sprout from your back.  Though you usually keep the [haircolor]-colored wings folded close, they can unfurl to allow you to soar as gracefully as a harpy.", false);
		if (player.wingType == WING_TYPE_FEATHERED_ALICORN)
			outputText("  A pair of large, feathery wings sprout from your back.  Though you usually keep the [haircolor]-colored wings folded close, they can unfurl to allow you to soar as gracefully as an alicorn.", false);
		if (player.wingType == WING_TYPE_FEATHERED_PHOENIX)
			outputText("  A pair of large, feathery wings sprout from your back.  Though you usually keep the crimson-colored wings folded close, they can unfurl to allow you to soar as gracefully as a phoenix.", false);
		if (player.wingType == WING_TYPE_DRACONIC_SMALL)
			outputText("  Small, vestigial wings sprout from your shoulders.  They might look like bat's wings, but the membranes are covered in fine, delicate scales.");
		else if (player.wingType == WING_TYPE_DRACONIC_LARGE)
			outputText("  Large wings sprout from your shoulders.  When unfurled they stretch further than your arm span, and a single beat of them is all you need to set out toward the sky.  They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone.");
		else if (player.wingType == WING_TYPE_DRACONIC_HUGE)
			outputText("  Magnificent huge wings sprout from your shoulders.  When unfurled they stretch over twice further than your arm span, and a single beat of them is all you need to set out toward the sky.  They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone.");
		else if (player.wingType == WING_TYPE_GIANT_DRAGONFLY)
			outputText("  Giant dragonfly wings hang from your shoulders.  At a whim, you could twist them into a whirring rhythm fast enough to lift you off the ground and allow you to fly.");
		else if (player.wingType == WING_TYPE_GARGOYLE_LIKE_LARGE) {
			outputText("  Large stony wings sprout from your shoulders. When unfurled they stretch longer than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like ");
			if (flags[kFLAGS.GARGOYLE_WINGS_TYPE] == 1) outputText("bird");
			if (flags[kFLAGS.GARGOYLE_WINGS_TYPE] == 2) outputText("bat’s");
			outputText(" wings and although they are clearly made of stone they allow you to fly around with excellent aerial agility.");
		}
		else if (player.wingType == WING_TYPE_PLANT) {
			outputText("  Three pairs of oily, prehensile phalluses sprout from your shoulders and back. From afar, they may look like innocent vines, but up close, each tentacle contain a bulbous head with a leaking cum-slit, perfect for mass breeding.");
		}
	}
	public function describeHorns():void {
//Horns
		//Demonic horns
		if (player.hornType == HORNS_DEMON) {
			if (player.horns == 2)
				outputText("  A small pair of pointed horns has broken through the " + player.skinDesc + " on your forehead, proclaiming some demonic taint to any who see them.", false);
			if (player.horns == 4)
				outputText("  A quartet of prominent horns has broken through your " + player.skinDesc + ".  The back pair are longer, and curve back along your head.  The front pair protrude forward demonically.", false);
			if (player.horns == 6)
				outputText("  Six horns have sprouted through your " + player.skinDesc + ", the back two pairs curve backwards over your head and down towards your neck, while the front two horns stand almost eight inches long upwards and a little forward.", false);
			if (player.horns >= 8)
				outputText("  A large number of thick demonic horns sprout through your " + player.skinDesc + ", each pair sprouting behind the ones before.  The front jut forwards nearly ten inches while the rest curve back over your head, some of the points ending just below your ears.  You estimate you have a total of " + num2Text(player.horns) + " horns.", false);
		}
		//Minotaur horns
		if (player.hornType == HORNS_COW_MINOTAUR) {
			if (player.horns < 3)
				outputText("  Two tiny horn-like nubs protrude from your forehead, resembling the horns of the young livestock kept by your village.", false);
			if (player.horns >= 3 && player.horns < 6)
				outputText("  Two moderately sized horns grow from your forehead, similar in size to those on a young bovine.", false);
			if (player.horns >= 6 && player.horns < 12)
				outputText("  Two large horns sprout from your forehead, curving forwards like those of a bull.", false);
			if (player.horns >= 12 && player.horns < 20)
				outputText("  Two very large and dangerous looking horns sprout from your head, curving forward and over a foot long.  They have dangerous looking points.", false);
			if (player.horns >= 20)
				outputText("  Two huge horns erupt from your forehead, curving outward at first, then forwards.  The weight of them is heavy, and they end in dangerous looking points.", false);
		}
		//Lizard horns
		if (player.hornType == HORNS_DRACONIC_X2) {
			if (flags[kFLAGS.USE_METRICS] > 0) outputText("  A pair of " + num2Text(int(player.horns * 2.54)) + " centimetre horns grow from the sides of your head, sweeping backwards and adding to your imposing visage.", false);
			else outputText("  A pair of " + num2Text(int(player.horns)) + " inch horns grow from the sides of your head, sweeping backwards and adding to your imposing visage.", false);
		}
		//Super lizard horns
		if (player.hornType == HORNS_DRACONIC_X4_12_INCH_LONG)
			outputText("  Two pairs of horns, roughly a foot long, sprout from the sides of your head.  They sweep back and give you a fearsome look, almost like the dragons from your village's legends.", false);
		//Antlers!
		if (player.hornType == HORNS_ANTLERS) {
			if (player.horns > 0)
				outputText("  Two antlers, forking into " + num2Text(player.horns) + " points, have sprouted from the top of your head, forming a spiky, regal crown of bone.");
		}
		if (player.hornType == HORNS_GOAT) {
			if (player.horns == 1)
				outputText("  A pair of stubby goat horns sprout from the sides of your head.");
			else
				outputText("  A pair of tall-standing goat horns sprout from the sides of your head.  They are curved and patterned with ridges.");
		}
		if (player.hornType == HORNS_RHINO) {
			if (player.horns >= 2) {
				if (player.faceType == FACE_RHINO)
					outputText("  A second horn sprouts from your forehead just above the horn on your nose.");
				else
					outputText("  A single horn sprouts from your forehead.  It is conical and resembles a rhino's horn.");
				outputText("  You estimate it to be about seven inches long.");
			}
			else {
				outputText("  A single horn sprouts from your forehead.  It is conical and resembles a rhino's horn.  You estimate it to be about six inches long.");
			}

		}
		if (player.hornType == HORNS_UNICORN) {
			if (player.horns < 3)
				outputText("  Tiny horn-like nub protrude from your forehead, resembling the horn of the young unicorn.", false);
			if (player.horns >= 3 && player.horns < 6)
				outputText("  One moderately sized horn grow from your forehead, similar in size to those on a young unicorn.", false);
			if (player.horns >= 6 && player.horns < 12)
				outputText("  One large horn sprout from your forehead, spiraling and pointing forwards like those of an unicorn.", false);
			if (player.horns >= 12 && player.horns < 20)
				outputText("  One very large and dangerous looking spiraling horn sprout from your forehead, pointing forward and over a foot long.  It have dangerous looking tip.", false);
			if (player.horns >= 20)
				outputText("  One huge and long spiraling horn erupt from your forehead, pointing forward.  The weight of it is heavy and ends with dangerous and sharp looking tip.", false);
		}
		if (player.hornType == HORNS_OAK) {
			if (player.horns > 0)
				outputText("  Two branches, forking into " + num2Text(player.horns) + " points, have sprouted from the top of your head, forming a spiky, regal crown made of oak wood.");
		}
		if (player.hornType == HORNS_GARGOYLE) {
			if (player.horns > 0)
				outputText("  A large pair of thick demonic looking horns sprout through the side of your head giving you a fiendish appearance.");
		}
		if (player.hornType == HORNS_ORCHID) {
			if (player.horns > 0)
				outputText("  A huge pair of orchids grows on each side of your head, their big long petals flopping gaily when you move.");
		}
	}
	public function describeTongue():void {
//Tongue
		if (player.tongueType == TONUGE_SNAKE)
			outputText("  A snake-like tongue occasionally flits between your lips, tasting the air.", false);
		else if (player.tongueType == TONUGE_DEMONIC)
			outputText("  A slowly undulating tongue occasionally slips from between your lips.  It hangs nearly two feet long when you let the whole thing slide out, though you can retract it to appear normal.", false);
		else if (player.tongueType == TONUGE_DRACONIC)
			outputText("  Your mouth contains a thick, fleshy tongue that, if you so desire, can telescope to a distance of about four feet.  It has sufficient manual dexterity that you can use it almost like a third arm.");
		else if (player.tongueType == TONUGE_ECHIDNA)
			outputText("  A thin echidna tongue, at least a foot long, occasionally flits out from between your lips.");
		else if (player.tongueType == TONUGE_CAT)
			outputText("  Your tongue is rough like that of a cat. You sometime groom yourself with it.");
	}
	public function describeBeard():void {
//Beards!
		if (player.beardLength > 0) {
			outputText("  You have a " + beardDescript() + " ");
			if (player.beardStyle != BEARD_GOATEE) {
				outputText("covering your ");
				if (rand(2) == 0) outputText("jaw");
				else outputText("chin and cheeks")
			}
			else {
				outputText("protruding from your chin");
			}
			outputText(".");
		}
	}
	public function describeEyes():void {
		if(player.eyeType == EYES_FOUR_SPIDER_EYES)
			outputText("  In addition to your primary two eyes, you have a second, smaller pair on your forehead.", false);
		else if(player.eyeType == EYES_BLACK_EYES_SAND_TRAP)
			outputText("  Your eyes are solid spheres of inky, alien darkness.", false);
		else if(player.eyeType == EYES_CAT_SLITS)
			outputText("  Your eyes have vertically slit like those of cat.", false);
		else if(player.eyeType == EYES_GORGON)
			outputText("  Your eyes are similar to those of snake-like gorgons with ability to temporally petrify.");
		else if(player.eyeType == EYES_FENRIR)
			outputText("  Your eyes glows with a freezing blue light icy smoke rising in the air around it.");
		else if(player.eyeType == EYES_MANTICORE)
			outputText("  Your eyes are similar to those of a cat but the red pupils dismiss any links to the regular felines in favor of something way more ominous.");
		else if(player.eyeType == EYES_FOX)
			outputText("  Your pupils looks like those of a fox with a slit in the middle.");
		else if(player.eyeType == EYES_REPTILIAN)
			outputText("  Your eyes looks like those of a reptile with yellow pupils and a slit.");
		else if(player.eyeType == EYES_SNAKE)
			outputText("  Your eyes have slitted pupils like that of a snake.");
		else if(player.eyeType == EYES_DRAGON)
			outputText("  Your eyes have slitted pupils like that of a dragon.");
	}
	public function describeHairAndEars():void {
		//if bald
		if(player.hairLength == 0)
		{
			if(player.skinType == SKIN_TYPE_FUR)
				outputText("  You have no hair, only a thin layer of fur atop of your head.  ", false);
			else {
				outputText("  You are totally bald, showing only shiny " + player.skinTone + " " + player.skinDesc + "");
				if(player.skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				outputText(" where your hair should be.", false);
			}
			if(player.earType == EARS_HORSE)
				outputText("  A pair of horse-like ears rise up from the top of your head.", false);
			else if(player.earType == EARS_FERRET)
				outputText("  A pair of small, rounded ferret ears sit on top of your head.", false);
			else if(player.earType == EARS_DOG)
				outputText("  A pair of dog ears protrude from your skull, flopping down adorably.", false);
			else if(player.earType == EARS_COW)
				outputText("  A pair of round, floppy cow ears protrude from the sides of your skull.", false);
			else if(player.earType == EARS_ELFIN)
				outputText("  A pair of large pointy ears stick out from your skull.", false);
			else if(player.earType == EARS_CAT)
				outputText("  A pair of cute, fuzzy cat ears have sprouted from the top of your head.", false);
			else if(player.earType == EARS_PIG)
				outputText("  A pair of pointy, floppy pig ears have sprouted from the top of your head.", false);
			else if(player.earType == EARS_LIZARD)
				outputText("  A pair of rounded protrusions with small holes on the sides of your head serve as your ears.", false);
			else if(player.earType == EARS_BUNNY)
				outputText("  A pair of floppy rabbit ears stick up from the top of your head, flopping around as you walk.", false);
			else if(player.earType == EARS_FOX)
				outputText("  A pair of large, adept fox ears sit high on your head, always listening.");
			else if(player.earType == EARS_DRAGON)
				outputText("  A pair of rounded protrusions with small holes on the sides of your head serve as your ears.  Bony fins sprout behind them.", false);
			else if(player.earType == EARS_RACCOON)
				outputText("  A pair of vaguely egg-shaped, furry raccoon ears adorns your head.");
			else if(player.earType == EARS_MOUSE)
				outputText("  A pair of large, dish-shaped mouse ears tops your head.");
			else if (player.earType == EARS_PIG)
				outputText("  A pair of pointy, floppy pig ears have sprouted from the top of your head.");
			else if (player.earType == EARS_RHINO)
				outputText("  A pair of open tubular rhino ears protrude from your head.");
			else if (player.earType == EARS_ECHIDNA)
				outputText("  A pair of small rounded openings appear on your head that are your ears.");
			else if (player.earType == EARS_DEER)
				outputText("  A pair of deer-like ears rise up from the top of your head.", false);
			else if(player.earType == EARS_WOLF)
				outputText("  A pair of pointed wolf ears rise up from the top of your head.", false);
			else if(player.earType == EARS_LION)
				outputText("  A pair of lion ears have sprouted from the top of your head.", false);
			else if(player.earType == EARS_YETI)
				outputText("  A pair of yeti ears, bigger than your old human ones have sprouted from the top of your head.", false);
			else if(player.earType == EARS_ORCA)
				outputText("  A pair of very large fin at least twice as large as your head which help you orient yourself underwater have sprouted from the top of your head. Their underside is white while the top is black.", false);
			else if(player.earType == EARS_SNAKE)
				outputText("  A pair of large pointy ears covered in small scales stick out from your skull.", false);
			//</mod>
			if (player.gillType == GILLS_FISH)
			{
				outputText("  A set of fish like gills reside on your neck, several small slits that can close flat against your skin."
						   +" They allow you to stay in the water for quite a long time.");
			}
			// GILLS_ANEMONE are handled below
			if(player.antennae == ANTENNAE_MANTIS)
				outputText("  Long prehensile antennae also appear on your skull, bouncing and swaying in the breeze.", false);
			if(player.antennae == ANTENNAE_BEE)
				outputText("  Floppy antennae also appear on your skull, bouncing and swaying in the breeze.", false);
		}
		//not bald
		else
		{
			if(player.earType == EARS_HUMAN)
				outputText("  Your [hair] looks good on you, accentuating your features well.", false);
			else if(player.earType == EARS_FERRET)
				outputText("  A pair of small, rounded ferret ears burst through the top of your [hair].", false);
			else if(player.earType == EARS_HORSE)
				outputText("  The [hair] on your head parts around a pair of very horse-like ears that grow up from your head.", false);
			else if(player.earType == EARS_DOG)
				outputText("  The [hair] on your head is overlapped by a pair of pointed dog ears.", false);
			else if(player.earType == EARS_COW)
				outputText("  The [hair] on your head is parted by a pair of rounded cow ears that stick out sideways.", false);
			else if(player.earType == EARS_ELFIN)
				outputText("  The [hair] on your head is parted by a pair of cute pointed ears, bigger than your old human ones.", false);
			else if(player.earType == EARS_CAT)
				outputText("  The [hair] on your head is parted by a pair of cute, fuzzy cat ears, sprouting from atop your head and pivoting towards any sudden noises.", false);
			else if(player.earType == EARS_LIZARD)
				outputText("  The [hair] atop your head makes it nigh-impossible to notice the two small rounded openings that are your ears.", false);
			else if(player.earType == EARS_BUNNY)
				outputText("  A pair of floppy rabbit ears stick up out of your [hair], bouncing around as you walk.", false);
			else if(player.earType == EARS_KANGAROO)
				outputText("  The [hair] atop your head is parted by a pair of long, furred kangaroo ears that stick out at an angle.", false);
			else if(player.earType == EARS_FOX)
				outputText("  The [hair] atop your head is parted by a pair of large, adept fox ears that always seem to be listening.");
			else if(player.earType == EARS_DRAGON)
				outputText("  The [hair] atop your head is parted by a pair of rounded protrusions with small holes on the sides of your head serve as your ears.  Bony fins sprout behind them.", false);
			else if(player.earType == EARS_RACCOON)
				outputText("  The [hair] on your head parts around a pair of egg-shaped, furry raccoon ears.");
			else if(player.earType == EARS_MOUSE)
				outputText("  The [hair] atop your head is funneled between and around a pair of large, dish-shaped mouse ears that stick up prominently.");
			else if(player.earType == EARS_PIG)
				outputText("  The [hair] on your head is parted by a pair of pointy, floppy pig ears. They often flick about when you’re not thinking about it.");
			else if(player.earType == EARS_RHINO)
				outputText("  The [hair] on your head is parted by a pair of tubular rhino ears.");
			else if(player.earType == EARS_ECHIDNA)
				outputText("  Your [hair] makes it near-impossible to see the small, rounded openings that are your ears.");
			else if(player.earType == EARS_DEER)
				outputText("  The [hair] on your head parts around a pair of deer-like ears that grow up from your head.", false);
			else if(player.earType == EARS_WOLF)
				outputText("  The [hair] on your head is overlapped by a pair of pointed wolf ears.", false);
			else if(player.earType == EARS_LION)
				outputText("  The [hair] is parted by a pair of lion ears that listen to every sound.", false);
			else if(player.earType == EARS_YETI)
				outputText("  The [hair] is parted by a pair of yeti ears, bigger than your old human ones.", false);
			else if(player.earType == EARS_ORCA)
				outputText("  The [hair] on your head is parted by a pair of very large fin at least twice as large as your head which help you orient yourself underwater. Their underside is white while the top is black.", false);
			else if(player.earType == EARS_SNAKE)
				outputText("  The [hair] on your head is parted by a pair of cute pointed ears covered in small scales, bigger than your old human ones.", false);
			//</mod>
			if(player.antennae == ANTENNAE_MANTIS)
			{
				if(player.earType == EARS_BUNNY)
					outputText("  Long prehensile antennae also grow from just behind your hairline, waving and swaying in the breeze with your ears.", false);
				else outputText("  Long prehensile antennae also grow from just behind your hairline, bouncing and swaying in the breeze.", false);
			}
			if(player.antennae == ANTENNAE_BEE)
			{
				if(player.earType == EARS_BUNNY)
					outputText("  Limp antennae also grow from just behind your hairline, waving and swaying in the breeze with your ears.", false);
				else outputText("  Floppy antennae also grow from just behind your hairline, bouncing and swaying in the breeze.", false);
			}
		}
	}
	public function describeFaceShape():void {
		if (player.facePart.isHumanShaped()) {
			var odd:int = 0;
			var skinAndSomething:String = "";
			if (player.facePart.type == FACE_BUCKTEETH) {
				skinAndSomething = " and mousey buckteeth";
				odd++;
			}
			if (player.skin.coverage<Skin.COVERAGE_COMPLETE) {
				outputText("  Your face is human in shape and structure, with [skin]"+skinAndSomething);
				if (player.skin.hasMagicalTattoo()) {
					outputText(" covered with magical tattoo");
					odd++;
				}
				if (player.skin.isCoverLowMid()) {
					outputText(".");
					outputText("  On your cheek you have [skin coat]");
					odd++;
				}
			} else if (player.skin.hasCoatOfType(SKIN_TYPE_FUR)) {
				odd++;
				outputText("  Under your [skin coat] you have a human-shaped head with [skin base]"+skinAndSomething);
			} else if (player.skin.hasCoat() && !skinAndSomething) {
				odd++;
				outputText("  Your face is fairly human in shape, but is covered in [skin coat]");
			} else outputText("  Your face is human in shape and structure, with [skin full]"+skinAndSomething);
			outputText(".");

			if (player.faceType == FACE_SHARK_TEETH)
				outputText("  A set of razor-sharp, retractable shark-teeth fill your mouth and gives your visage a slightly angular appearance.", false);
			else if (player.faceType == FACE_BUNNY)
				outputText("  The constant twitches of your nose and the length of your incisors gives your visage a hint of bunny-like cuteness.", false);
			else if (player.faceType == FACE_SPIDER_FANGS)
				outputText("  A set of retractable, needle-like fangs sit in place of your canines and are ready to dispense their venom.", false);
			else if (player.faceType == FACE_FERRET_MASK)
				outputText("  The [skinFurScales] around your eyes is significantly darker than the rest of your face, giving you a cute little ferret mask.", false);
			else if (player.faceType == FACE_MANTICORE)
				outputText("  You have a set of sharp cat-like teeth in your mouth.", false);
			else if (player.faceType == FACE_SNAKE_FANGS) {
				if (odd==0) {
					outputText("  The only oddity is your pair of dripping fangs which often hang over your lower lip.", false);
				} else {
					outputText("  In addition, a pair of fangs hang over your lower lip, dripping with venom.", false);
		}
			} else if (player.faceType == FACE_SALAMANDER_FANGS) {
				if (odd == 0) {
					outputText(".  The only oddity is your salamander fangs giving you a menacing smile.", false);
				} else {
					outputText("  In addition, a pair of salamander fangs grows out of your mouth giving you a menacing smile.", false);
				}
			} else if (player.faceType == FACE_YETI_FANGS) {
				if (odd == 0){
					outputText(".  Your mouth, while human looking, has sharp yeti fangs not unlike those of a monkey.", false);
				} else {
					outputText("  In addition, your mouth, while human looking, has sharp yeti fangs not unlike those of a monkey.", false);
				}
			}
		} else if (player.faceType == FACE_FERRET) {
			if (player.hasFullCoatOfType(SKIN_TYPE_FUR)) outputText("  Your face is coated in [skin coat] with [skin base] underneath, an adorable cross between human and ferret features.  It is complete with a wet nose and whiskers.");
			else if (player.hasCoat()) outputText("  Your face is an adorable cross between human and ferret features, complete with a wet nose and whiskers.  The only oddity is [skin base] covered with [skin coat].", false);
			else outputText("  Your face is an adorable cross between human and ferret features, complete with a wet nose and whiskers.  The only oddity is your lack of fur, leaving only [skin] visible on your ferret-like face.", false);
		}
		else if (player.faceType == FACE_RACCOON_MASK) {
			if (!player.hasCoat()) { //appearance for skinheads
				outputText("  Your face is human in shape and structure, with [skin bases");
				if (InCollection(player.skin.base.color, "ebony", "black"))
					outputText(", though with your dusky hue, the black raccoon mask you sport isn't properly visible.");
				else if (player.skin.hasMagicalTattoo()) outputText(" covered with magical tattoo, though it is decorated with a sly-looking raccoon mask over your eyes.");
				else outputText(", though it is decorated with a sly-looking raccoon mask over your eyes.");
			} else { //appearance furscales
				//(black/midnight furscales)
				if (InCollection(player.skin.base.color, "black", "midnight", "black", "midnight", "black", "midnight"))
					outputText("  Under your [skin coat] hides a black raccoon mask, barely visible due to your inky hue, and");
				else outputText("  Your [skin coat] are decorated with a sly-looking raccoon mask, and under them");
				outputText(" you have a human-shaped head with [skin base].");
			}
		}
		else if (player.faceType == FACE_RACCOON) {
			outputText("  You have a triangular raccoon face, replete with sensitive whiskers and a little black nose; a mask shades the space around your eyes, set apart from your [skin coat] by a band of white.");
			//(if skin)
			if (player.hasPlainSkinOnly()) {
				outputText("  It looks a bit strange with only the skin and no fur.");
			} else if (player.skin.hasMagicalTattoo()) {
				outputText("  It looks a bit strange with only the skin covered with magical tattoo and no fur.");
			} else if (player.hasScales()) {
				outputText("  The presence of said scales gives your visage an eerie look, more reptile than mammal.");
			} else if (player.skin.hasChitin()) {
				outputText("  The presence of said chitin gives your visage an eerie look, more insect than mammal.");
			}
		}
		else if (player.faceType == FACE_FOX) {
			outputText("  You have a tapered, shrewd-looking vulpine face with a speckling of downward-curved whiskers just behind the nose.");
			if (!player.hasCoat()) {
				outputText("  Oddly enough, there's no fur on your animalistic muzzle, just [skin coat].");
			} else if (player.skin.hasMagicalTattoo()) {
				outputText("  Oddly enough, there's no fur on your animalistic muzzle, just [skin coat] covered with magical tattoo.");
			} else if (player.hasFullCoatOfType(SKIN_COAT_FUR)) {
				outputText("  A coat of [skin coat] decorates your muzzle.");
			} else if (player.skin.isCoverLowMid()) {
				outputText("  Strangely, [skin coat] adorn your animalistic visage.");
			} else {
				outputText("  Strangely, [skin coat] adorn every inch of your animalistic visage.");
			}
		} else if (player.faceType == FACE_MOUSE) {
			//appearance
			outputText("  You have a snubby, tapered mouse's face, with whiskers, a little pink nose, and [skin full]");
			outputText(".  Two large incisors complete it.");
		}
		//horse-face
		if (player.faceType == FACE_HORSE) {
			if (!player.hasCoat()) {
				outputText("  Your face is equine in shape and structure.  The odd visage is hairless and covered with [skin base].");
			} else if (player.hasFullCoatOfType(SKIN_COAT_FUR)) {
				outputText("  Your face is almost entirely equine in appearance, even having [skin coat].  Underneath the fur, you believe you have [skin base].", false);
			} else {
				outputText("  You have the face and head structure of a horse, overlaid with glittering [skin coat].", false);
			}
		}
		//dog-face
		if (player.faceType == FACE_DOG) {
			if (!player.hasCoat()) {
				outputText("  You have a dog-like face, complete with a wet nose.  The odd visage is hairless and covered with [skin base].");
			} else if (player.hasFullCoatOfType(SKIN_COAT_FUR)) {
				outputText("  You have a dog's face, complete with wet nose and panting tongue.  You've got [skin coat], hiding your [skin base] underneath your furry visage.", false);
			} else {
				outputText("  You have the facial structure of a dog, wet nose and all, but overlaid with glittering [skin coat]", false);
			}
		}
		//wolf-face
		if (player.faceType == FACE_WOLF) {
			if (!player.hasCoat()) {
				outputText("  You have a wolf-like face, complete with a wet nose.  ", false);
				if (player.hasKeyItem("Fenrir Collar") >= 0) outputText("Cold blue mist seems to periodically escape from your mouth.   ", false);
				outputText("The odd visage is hairless and covered with [skin coat]");
				if (player.skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				outputText(".", false);
			} else if (player.hasFullCoatOfType(SKIN_COAT_FUR)) {
				outputText("  You have a wolf’s face, complete with wet nose a panting tongue and threatening teeth.  ", false);
				if (player.hasKeyItem("Fenrir Collar") >= 0) outputText("Cold blue mist seems to periodically escape from your mouth.   ", false);
				outputText("You've got [skin coat], hiding your [skin noadj] underneath your furry visage.", false);
			} else {
				outputText("  You have the facial structure of a wolf, wet nose and all, but overlaid with glittering [skin coat].", false);
				if (player.hasKeyItem("Fenrir Collar") >= 0) outputText("  Cold blue mist seems to periodically escape from your mouth.", false);
			}
		}
		//cat-face
		if (player.faceType == FACE_CAT) {
			if (!player.hasCoat()) {
				outputText("  You have a cat-like face, complete with a cute, moist nose and whiskers.  The [skin] that is revealed by your lack of fur looks quite unusual on so feline a face");
				if (player.skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				outputText(".", false);
			} else if (player.hasFullCoatOfType(SKIN_COAT_FUR)) {
				outputText("  You have a cat-like face, complete with moist nose and whiskers.  Your [skin coat.nocolor] is [skin coat.color], hiding your [skin base] underneath.", false);
			} else {
				outputText("  Your facial structure blends humanoid features with those of a cat.  A moist nose and whiskers are included, but overlaid with glittering [skin coat].");
			}
		}
		//Minotaaaauuuur-face
		if (player.faceType == FACE_COW_MINOTAUR) {
			if (!player.hasCoat()) {
				outputText("  You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose.  Despite your lack of fur elsewhere, your visage does have a short layer of [haircolor] fuzz.");
			} else if (player.hasFullCoatOfType(SKIN_COAT_FUR)) {
				outputText("  You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose.  Your [skin coat] thickens noticeably on your head, looking shaggy and more than a little monstrous once laid over your visage.");
			} else if (player.hasFullCoat()) {
				outputText("  Your face resembles a minotaur's, though strangely it is covered in shimmering [skin coat], right up to the flat cow-like nose that protrudes from your face.");
			} else {
				outputText("  Your face resembles a minotaur's, though strangely it is covered small patches of shimmering [skin coat], right up to the flat cow-like nose that protrudes from your face.");
			}
		}
		//Lizard-face
		if (player.faceType == FACE_LIZARD) {
			if (!player.hasCoat()) {
				outputText("  You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage.  The reptilian visage does look a little odd with just [skin].", false);
			} else if (player.hasFullCoatOfType(SKIN_COAT_FUR)) {
				outputText("  You have a face resembling that of a lizard.  Between the toothy maw, pointed snout, and the layer of [skin coat] covering your face, you have quite the fearsome visage.", false);
			} else if (player.hasFullCoat()) {
				outputText("  Your face is that of a lizard, complete with a toothy maw and pointed snout.  Reflective [skin coat] complete the look, making you look quite fearsome.", false);
			} else {
				outputText("  You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage.  The reptilian visage does look a little odd with just [skin coat].", false);
			}
		}
		if (player.faceType == FACE_DRAGON) {
			outputText("  Your face is a narrow, reptilian muzzle.  It looks like a predatory lizard's, at first glance, but with an unusual array of spikes along the under-jaw.  It gives you a regal but fierce visage.  Opening your mouth reveals several rows of dagger-like sharp teeth.  The fearsome visage is decorated by [skin coat].");
		}
		if (player.faceType == FACE_PLANT_DRAGON) {
			outputText("  Your face is a narrow, reptilian and regal, reminiscent of a dragon.  A [skin coat] decorates your visage.");
		}
		if (player.faceType == FACE_KANGAROO) {
			outputText("  Your face is ", false);
			if (!player.hasCoat()) {
				outputText("bald");
				if (player.skin.base.adj == "tattooed") outputText(" covered with magical tattoo");
			} else outputText("covered with [skin coat]");
			outputText(" and shaped like that of a kangaroo, somewhat rabbit-like except for the extreme length of your odd visage.", false);
		}
		//<mod>
		if (player.faceType == FACE_PIG) {
			outputText("  Your face is like that of a pig, with " + player.skinTone + " skin, complete with a snout that is always wiggling.");
		}
		if (player.faceType == FACE_BOAR) {
			outputText("  Your face is like that of a boar, ");
			if (player.skinType == SKIN_TYPE_FUR)
				outputText("with " + player.skinTone + " skin underneath your [skin coat.color] fur");
			outputText(", complete with tusks and a snout that is always wiggling.");
		}
		if (player.faceType == FACE_RHINO) {
			outputText("  Your face is like that of a rhino");
			if (!player.hasCoat()) {
				outputText(", with [skin], complete with a long muzzle and a horn on your nose");
				if (player.skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				outputText(".");
			}
			else
				outputText(" with a long muzzle and a horn on your nose.  Oddly, your face is also covered in [skin coat].");
		}
		if (player.faceType == FACE_ECHIDNA) {
			outputText("  Your odd visage consists of a long, thin echidna snout.");
			if (!player.hasCoat()) {
				outputText("  The [skin base]");
				if (player.skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				outputText(" that is revealed by your lack of fur looks quite unusual.");
			} else if (player.hasFullCoatOfType(SKIN_COAT_FUR)) {
				outputText("  It's covered in [skin coat].");
			} else {
				outputText("  It's covered in [skin coat], making your face even more unusual.");
			}
		}
		if (player.faceType == FACE_DEER) {
			outputText("  Your face is like that of a deer, with a nose at the end of your muzzle.");
			if (!player.hasCoat()) {
				outputText("  The [skin]");
				if (player.skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				outputText(" that is revealed by your lack of fur looks quite unusual.");
			} else if (player.hasFullCoatOfType(SKIN_COAT_FUR)) {
				outputText("  It's covered in [skin coat] that covers your " + player.skinTone + " skin underneath.");
			} else {
				outputText("  It's covered in [skin coat], making your face looks more unusual.");
			}
		}
		if (player.faceType == FACE_ORCA) {
			if (player.skin.hasPlainSkinOnly() && player.skinAdj == "glossy" && player.skinTone == "white and black")
				outputText("  Your face is fairly human in shape save for a wider yet adorable nose. Your skin is pitch black with a white underbelly. From your neck up to your mouth and lower cheeks your face is white with two extra white circles right under and above your eyes. While at first one could mistake it for human skin, it has a glossy shine only found on sea animals.", false);
			else if (!player.hasFullCoat()) {
				if (player.skin.hasCoatOfType(SKIN_COAT_SCALES, SKIN_COAT_FUR)) {
					outputText("  You have a fairly normal face, with [skin base]. On your cheek you have [skin coat]");
				} else {
					outputText("  You have a fairly normal face, with [skin base]");
					if (player.skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
				}
				outputText(".  In addition you have a wide nose similar to that of an orca, which goes well with your sharp toothed mouth, giving you a cute look.", false);
			} else if (player.hasFullCoatOfType(SKIN_COAT_FUR)) {
				outputText("  Under your [skin coat] you have a human-shaped head with [skin base].  In addition you have a wide nose similar to that of an orca, which goes well with your sharp toothed mouth, giving you a cute look.", false);
			} else {
				outputText("  Your face is fairly human in shape, but is covered in [skin coat].  In addition you have a wide nose similar to that of an orca, which goes well with your sharp toothed mouth, giving you a cute look.", false);
			}
		}
		//</mod>
	}
public function RacialScores():void {
	clearOutput();
	outputText("<b>Current racial scores (and bonuses to stats if applicable):</b>\n", false);
	if (player.alicornScore() >= 6) outputText("\n<font color=\"#0000a0\">Alicorn: " + player.alicornScore() + " (+" + (5 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Fatigue, +" + (150 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Soulforce)</font>", false);
	else if (player.alicornScore() >= 1 && player.alicornScore() < 6) outputText("\n<font color=\"#008000\">Alicorn: " + player.alicornScore() + "</font>", false);
	else if (player.alicornScore() < 1) outputText("\n<font color=\"#ff0000\">Alicorn: 0</font>", false);
	if (player.alrauneScore() >= 10) outputText("\n<font color=\"#0000a0\">Alraune: " + player.alrauneScore() + " (+" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, -" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib)</font>", false);
	else if (player.alrauneScore() >= 1 && player.alrauneScore() < 10) outputText("\n<font color=\"#008000\">Alraune: " + player.alrauneScore() + "</font>", false);
	else if (player.alrauneScore() < 1) outputText("\n<font color=\"#ff0000\">Alraune: 0</font>", false);
	if (player.beeScore() >= 9) outputText("\n<font color=\"#0000a0\">Bee-morph: " + player.beeScore() + " (+" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int)</font>", false);
	else if (player.beeScore() >= 5 && player.beeScore() < 9) outputText("\n<font color=\"#0000a0\">Half Bee-morph: " + player.beeScore() + " (+" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int)</font>", false);
	else if (player.beeScore() >= 1 && player.beeScore() < 5) outputText("\n<font color=\"#008000\">Half Bee-morph: " + player.beeScore() + "</font>", false);
	else if (player.beeScore() < 1) outputText("\n<font color=\"#ff0000\">Half Bee-morph: 0</font>", false);
	if (player.bunnyScore() >= 4) outputText("\n<font color=\"#0000a0\">Bunny-morph: " + player.bunnyScore() + " (+" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe)</font>", false);
	else if (player.bunnyScore() >= 1 && player.bunnyScore() < 4) outputText("\n<font color=\"#008000\">Bunny-morph: " + player.bunnyScore() + "</font>", false);
	else if (player.bunnyScore() < 1) outputText("\n<font color=\"#ff0000\">Bunny-morph: 0</font>", false);
	if (player.catScore() >= 4) {
		outputText("\n<font color=\"#0000a0\">Cat-morph: " + player.catScore() + " (", false);
		if (player.findPerk(PerkLib.Flexibility) > 0) outputText("+" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		else outputText("+" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		outputText("max Spe)</font>", false);
	}
	else if (player.catScore() >= 1 && player.catScore() < 4) outputText("\n<font color=\"#008000\">Cat-morph: " + player.catScore() + "</font>", false);
	else if (player.catScore() < 1) outputText("\n<font color=\"#ff0000\">Cat-morph: 0</font>", false);
	if (player.centaurScore() >= 5) outputText("\n<font color=\"#0000a0\">Centaur: " + player.centaurScore() + " (+" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP)</font>", false);
	else if (player.centaurScore() >= 1 && player.centaurScore() < 5) outputText("\n<font color=\"#008000\">Centaur: " + player.centaurScore() + "</font>", false);
	else if (player.centaurScore() < 1) outputText("\n<font color=\"#ff0000\">Centaur: 0</font>", false);
	outputText("\nCHIMERA: " + player.chimeraScore(), false);
	if (player.couatlScore() >= 11) {
		outputText("\n<font color=\"#0000a0\">Couatl: " + player.couatlScore() + " (", false);
		if (player.isNaga()) outputText("+" + (55 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		else outputText("+" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		outputText("max Str, +" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, ", false);
		if (player.isNaga()) outputText("+" + (115 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		else outputText("+" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		outputText("max Spe)</font>", false);//, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP
	}
	else if (player.couatlScore() >= 1 && player.couatlScore() < 11) outputText("\n<font color=\"#008000\">Couatl: " + player.couatlScore() + "</font>", false);
	else if (player.couatlScore() < 1) outputText("\n<font color=\"#ff0000\">Couatl: 0</font>", false);
	if (player.cowScore() > 5) outputText("\n<font color=\"#0000a0\">Cow-morph: " + player.cowScore() + " (+" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (5 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lust)</font>", false);
	else if (player.cowScore() >= 1 && player.cowScore() < 6) outputText("\n<font color=\"#008000\">Cow-morph: " + player.cowScore() + "</font>", false);
	else if (player.cowScore() < 1) outputText("\n<font color=\"#ff0000\">Cow-morph: 0</font>", false);
	if (player.deerScore() >= 4) outputText("\n<font color=\"#0000a0\">Deer-morph: " + player.deerScore() + " (+" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe)</font>", false);
	else if (player.deerScore() >= 1 && player.deerScore() < 4) outputText("\n<font color=\"#008000\">Deer-morph: " + player.deerScore() + "</font>", false);
	else if (player.deerScore() < 1) outputText("\n<font color=\"#ff0000\">Deer-morph: 0</font>", false);
	if (player.demonScore() >= 11) outputText("\n<font color=\"#0000a0\">Succubi-kin/Incubi-kin: " + player.demonScore() + " (+" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib, +" + (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lust)</font>", false);
	else if (player.demonScore() >= 5 && player.demonScore() < 11) outputText("\n<font color=\"#0000a0\">Half Succubus/Incubus: " + player.demonScore() + " (+" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (45 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib, +" + (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lust)</font>", false);
	else if (player.demonScore() >= 1 && player.demonScore() < 5) outputText("\n<font color=\"#008000\">Half Succubus/Incubus: " + player.demonScore() + "</font>", false);
	else if (player.demonScore() < 1) outputText("\n<font color=\"#ff0000\">Half Succubus/Incubus: 0</font>", false);
	if (player.dogScore() >= 4) outputText("\n<font color=\"#0000a0\">Dog-morph: " + player.dogScore() + " (+" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, -" + (5 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int)</font>", false);
	else if (player.dogScore() >= 1 && player.dogScore() < 4) outputText("\n<font color=\"#008000\">Dog-morph: " + player.dogScore() + "</font>", false);
	else if (player.dogScore() < 1) outputText("\n<font color=\"#ff0000\">Dog-morph: 0</font>", false);
	if (player.dragonScore() >= 16) {
		outputText("\n<font color=\"#0000a0\">Dragon: " + player.dragonScore() + " (+" + (80 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (80 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Wis, ", false);
		outputText("+" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib, +" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP)</font>", false);
	}
	else if (player.dragonScore() >= 12 && player.dragonScore() < 16) {
		outputText("\n<font color=\"#0000a0\">Dragon: " + player.dragonScore() + " (+" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Wis, ", false);
		outputText("+" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib, +" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP)</font>", false);
	}
	else if (player.dragonScore() >= 8 && player.dragonScore() < 12) {
		outputText("\n<font color=\"#0000a0\">Dragon: " + player.dragonScore() + " (+" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Wis, ", false);
		outputText("+" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP)</font>", false);
	}
	else if (player.dragonScore() >= 4 && player.dragonScore() < 8) outputText("\n<font color=\"#0000a0\">Half-Dragon: " + player.dragonScore() + " (+" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Wis, +" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP)</font>", false);
	else if (player.dragonScore() >= 1 && player.dragonScore() < 4) outputText("\n<font color=\"#008000\">Half-Dragon: " + player.dragonScore() + "</font>", false);
	else if (player.dragonScore() < 1) outputText("\n<font color=\"#ff0000\">Half-Dragon: 0</font>", false);
	outputText("\nDragonne: " + player.dragonneScore(), false);
	outputText("\nEchidna: " + player.echidnaScore(), false);
	outputText("\nFerret-morph: " + player.ferretScore(), false);
	if (player.foxScore() >= 7) outputText("\n<font color=\"#0000a0\">Fox-morph: " + player.foxScore() + " (-" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (80 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (55 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Fatigue)</font>", false);
	else if (player.foxScore() >= 4 && player.foxScore() < 7) outputText("\n<font color=\"#0000a0\">Half Fox: " + player.foxScore() + " (-" + (5 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int)</font>", false);
	else if (player.foxScore() >= 1 && player.foxScore() < 4) outputText("\n<font color=\"#008000\">Half Fox: " + player.foxScore() + "</font>", false);
	else if (player.foxScore() < 1) outputText("\n<font color=\"#ff0000\">Half Fox: 0</font>", false);
	outputText("\nGARGOYLE: " + player.gargoyleScore(), false);
	if (player.goblinScore() >= 4) outputText("\n<font color=\"#0000a0\">Goblin: " + player.goblinScore() + " (+" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int)</font>", false);
	else if (player.goblinScore() >= 1 && player.goblinScore() < 4) outputText("\n<font color=\"#008000\">Goblin: " + player.goblinScore() + "</font>", false);
	else if (player.goblinScore() < 1) outputText("\n<font color=\"#ff0000\">Goblin: 0</font>", false);
	if (player.gooScore() >= 8) outputText("\n<font color=\"#0000a0\">Goo: " + player.gooScore() + " (+" + (80 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, -" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib)</font>", false);
	else if (player.gooScore() >= 4 && player.gooScore() < 8) outputText("\n<font color=\"#0000a0\">Half Goo: " + player.gooScore() + " (+" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, -" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib)</font>", false);
	else if (player.gooScore() >= 1 && player.gooScore() < 4) outputText("\n<font color=\"#008000\">Half Goo: " + player.gooScore() + "</font>", false);
	else if (player.gooScore() < 1) outputText("\n<font color=\"#ff0000\">Half Goo: 0</font>", false);
	if (player.gorgonScore() >= 11) {
		outputText("\n<font color=\"#0000a0\">Gorgon: " + player.gorgonScore() + " (", false);
		if (player.isNaga()) outputText("+" + (65 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		else outputText("+" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		outputText("max Str, +" + (45 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, ", false);
		if (player.isNaga()) outputText("+" + (85 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		else outputText("+" + (70 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		outputText("max Spe, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP)</font>", false);
	}
	else if (player.gorgonScore() >= 1 && player.gorgonScore() < 11) outputText("\n<font color=\"#008000\">Gorgon: " + player.gorgonScore() + "</font>", false);
	else if (player.gorgonScore() < 1) outputText("\n<font color=\"#ff0000\">Gorgon: 0</font>", false);
	outputText("\nGRAND CHIMERA: " + player.grandchimeraScore(), false);
	if (player.harpyScore() >= 8) outputText("\n<font color=\"#0000a0\">Harpy: " + player.harpyScore() + " (-" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (80 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib)</font>", false);
	else if (player.harpyScore() >= 4 && player.harpyScore() < 8) outputText("\n<font color=\"#0000a0\">Half Harpy: " + player.harpyScore() + " (-" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib)</font>", false);
	else if (player.harpyScore() >= 1 && player.harpyScore() < 4) outputText("\n<font color=\"#008000\">Half Harpy: " + player.harpyScore() + "</font>", false);
	else if (player.harpyScore() < 1) outputText("\n<font color=\"#ff0000\">Half Harpy: 0</font>", false);
	if (player.horseScore() >= 4) outputText("\n<font color=\"#0000a0\">Horse-morph: " + player.horseScore() + " (+" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, -" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (70 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP)</font>", false);
	else if (player.horseScore() >= 1 && player.horseScore() < 4) outputText("\n<font color=\"#008000\">Horse-morph: " + player.horseScore() + "</font>", false);
	else if (player.horseScore() < 1) outputText("\n<font color=\"#ff0000\">Horse-morph: 0</font>", false);
	if (player.humanScore() == 25) outputText("\n<font color=\"#0000a0\">HUMANITY: 25 (+" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str / Tou / Spe, +" + (65 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int / Wis / Lib)</font>", false);
	else if (player.humanScore() == 24) outputText("\n<font color=\"#0000a0\">HUMANITY: 24 (+" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str / Tou / Spe, +" + (55 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int / Wis / Lib)</font>", false);
	else if (player.humanScore() == 23) outputText("\n<font color=\"#0000a0\">HUMANITY: 23 (+" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str / Tou / Spe, +" + (45 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int / Wis / Lib)</font>", false);
	else if (player.humanScore() == 22) outputText("\n<font color=\"#0000a0\">HUMANITY: 22 (+" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str / Tou / Spe, +" + (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int / Wis / Lib)</font>", false);
	else if (player.humanScore() == 21) outputText("\n<font color=\"#0000a0\">HUMANITY: 21 (+" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str / Tou / Spe, +" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int / Wis / Lib)</font>", false);
	else if (player.humanScore() == 20) outputText("\n<font color=\"#0000a0\">HUMANITY: 20 (+" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str / Tou / Spe, +" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int / Wis / Lib)</font>", false);
	else if (player.humanScore() == 19) outputText("\n<font color=\"#0000a0\">HUMANITY: 19 (+" + (5 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int / Wis / Lib)</font>", false);	//+" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str / Tou / Spe,
//	else if (player.humanScore() == 18) outputText("\n<font color=\"#0000a0\">HUMANITY: 18 (+" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str / Tou / Spe, +" + (65 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int / Wis / Lib)</font>", false);
	else if (player.humanScore() < 19) outputText("\n<font color=\"#008000\">HUMANITY: " + player.humanScore() + "</font>", false);
	if (player.internalChimeraScore() >= 1) {
		outputText("\n<font color=\"#0000a0\">INTERNAL CHIMERICAL DISPOSITION: " + player.internalChimeraScore() + " (+" + (5 * player.internalChimeraScore() * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str / Tou / Spe / Int / Wis / Lib)</font>", false);
	}
	else if (player.internalChimeraScore() < 1) outputText("\nINTERNAL CHIMERICAL DISPOSITION: 0</font>", false);
	if (player.kangaScore() >= 4) outputText("\n<font color=\"#0000a0\">Kangaroo-morph: " + player.kangaScore() + " (+" + (5 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe)</font>", false);
	else if (player.kangaScore() >= 1 && player.kangaScore() < 4) outputText("\n<font color=\"#008000\">Kangaroo-morph: " + player.kangaScore() + "</font>", false);
	else if (player.kangaScore() < 1) outputText("\n<font color=\"#ff0000\">Kangaroo-morph: 0</font>", false);
	//if (player.kitshooScore() >= 6) outputText("\n<font color=\"#0000a0\">Kitshoo: " + player.kitshooScore() + "</font>", false);
	//else if (player.kitshooScore() >= 1 && player.kitshooScore() < 6) outputText("\n<font color=\"#008000\">Kitshoo: " + player.kitshooScore() + "</font>", false);
	//else if (player.kitshooScore() < 1) outputText("\n<font color=\"#ff0000\">Kitshoo: 0</font>", false);
	if (player.kitsuneScore() >= 6) {
		if (player.tailType == 13 && player.tailCount >= 2 && player.kitsuneScore() >= 12) {
			if (player.tailCount < 9) outputText("\n<font color=\"#0000a0\">Kitsune:", false);
			else if (player.tailCount == 9) outputText("\n<font color=\"#0000a0\">Nine Tails Kitsune:", false);
			outputText(" " + player.kitsuneScore() + " (-" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (70 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Wis, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib, ", false);
			if (player.tailCount < 9) {
				outputText("+" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Fatigue, +20% max Soulforce)</font>", false);
			}
			else if (player.tailCount == 9) {
				outputText("+" + (300 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Fatigue, +40% max Soulforce)</font>", false);
			}
		}
		else {
			outputText("\n<font color=\"#0000a0\">Kitsune: " + player.kitsuneScore() + " (-" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib, ", false);
			outputText("+" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Fatigue, +20% max Soulforce)</font>", false);
		}
	}
	else if (player.kitsuneScore() >= 5) {
		outputText("\n<font color=\"#0000a0\">Half Kitsune: " + player.kitsuneScore() + " (-" + (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib, ", false);
		outputText("+" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Fatigue, +20% max Soulforce)</font>", false);
	}
	else if (player.kitsuneScore() >= 1 && player.kitsuneScore() < 5) outputText("\n<font color=\"#008000\">Half Kitsune: " + player.kitsuneScore() + "</font>", false);
	else if (player.kitsuneScore() < 1) outputText("\n<font color=\"#ff0000\">Half Kitsune: 0</font>", false);
	if (player.lizardScore() >= 8) outputText("\n<font color=\"#0000a0\">Lizard-morph: " + player.lizardScore() + " (+" + (70 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Fatigue)</font>", false);
	else if (player.lizardScore() >= 4 && player.lizardScore() < 8) outputText("\n<font color=\"#0000a0\">Half Lizard-morph: " + player.lizardScore() + " (+" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Fatigue)</font>", false);
	else if (player.lizardScore() >= 1 && player.lizardScore() < 4) outputText("\n<font color=\"#008000\">Half Lizard-morph: " + player.lizardScore() + "</font>", false);
	else if (player.lizardScore() < 1) outputText("\n<font color=\"#ff0000\">Half Lizard-morph: 0</font>", false);
	if (player.manticoreScore() >= 10) outputText("\n<font color=\"#0000a0\">Manticore: " + player.manticoreScore() + " (+" + (80 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP)</font>", false);
	else if (player.manticoreScore() >= 5 && player.manticoreScore() < 10) outputText("\n<font color=\"#0000a0\">Half Manticore: " + player.manticoreScore() + " (+" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP)</font>", false);
	else if (player.manticoreScore() >= 1 && player.manticoreScore() < 5) outputText("\n<font color=\"#008000\">Half Manticore: " + player.manticoreScore() + "</font>", false);
	else if (player.manticoreScore() < 1) outputText("\n<font color=\"#ff0000\">Half Manticore: 0</font>", false);
	if (player.minoScore() >= 4) outputText("\n<font color=\"#0000a0\">Minotaur: " + player.minoScore() + " (+" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, -" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lust)</font>", false);
	else if (player.minoScore() >= 1 && player.manticoreScore() < 4) outputText("\n<font color=\"#008000\">Minotaur: " + player.minoScore() + "</font>", false);
	else if (player.minoScore() < 1) outputText("\n<font color=\"#ff0000\">Minotaur: 0</font>", false);
	if (player.mantisScore() >= 5) {
		outputText("\n<font color=\"#0000a0\">Mantis-morph: " + player.mantisScore() + " (-" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, ", false);
		if (player.findPerk(PerkLib.MantislikeAgility) >= 0) {
			if (player.hasCoatOfType(SKIN_COAT_CHITIN) && player.findPerk(PerkLib.ThickSkin) >= 0) outputText("+" + (70 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
			else if (player.skinType == SKIN_TYPE_SCALES && player.findPerk(PerkLib.ThickSkin) >= 0) outputText("+" + (65 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
			else if (player.hasCoatOfType(SKIN_COAT_CHITIN)) outputText("+" + (65 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
			else if (player.skinType == SKIN_TYPE_SCALES) outputText("+" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
			else if (player.findPerk(PerkLib.ThickSkin) >= 0) outputText("+" + (55 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
			else outputText("+" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		}
		else outputText("+" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		outputText("max Spe, +" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int)</font>", false);
	}
	else if (player.mantisScore() >= 1 && player.mantisScore() < 5) outputText("\n<font color=\"#008000\">Mantis-morph: " + player.mantisScore() + "</font>", false);
	else if (player.mantisScore() < 1) outputText("\n<font color=\"#ff0000\">Mantis-morph: 0</font>", false);
	outputText("\nMouse-morph: " + player.mouseScore(), false);
	if (player.nagaScore() >= 8) {
		outputText("\n<font color=\"#0000a0\">Naga: " + player.nagaScore() + " (", false);
		if (player.isNaga()) outputText("+" + (55 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		else outputText("+" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		outputText("max Str, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, ", false);
		if (player.isNaga()) outputText("+" + (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		else outputText("+" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		outputText("max Spe)</font>", false);
	}
	else if (player.nagaScore() >= 4 && player.nagaScore() < 8) {
		outputText("\n<font color=\"#0000a0\">Half-Naga: " + player.nagaScore() + " (", false);
		if (player.isNaga()) outputText("+" + (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (55 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		else outputText("+" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		outputText("max Spe)</font>", false);
	}
	else if (player.nagaScore() >= 1 && player.nagaScore() < 4) outputText("\n<font color=\"#008000\">Half-Naga: " + player.nagaScore() + "</font>", false);
	else if (player.nagaScore() < 1) outputText("\n<font color=\"#ff0000\">Half-Naga: 0</font>", false);
	if (player.orcaScore() >= 12) outputText("\n<font color=\"#0000a0\">Orca-morph: " + player.orcaScore() + " (+" + (70 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (70 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe)</font>", false);
	else if (player.orcaScore() >= 6 && player.orcaScore() < 12) outputText("\n<font color=\"#0000a0\">Half Orca-boy/girl: " + player.orcaScore() + " (+" + (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe)</font>", false);
	else if (player.orcaScore() >= 1 && player.orcaScore() < 6) outputText("\n<font color=\"#008000\">Half Orca-boy/girl: " + player.orcaScore() + "</font>", false);
	else if (player.orcaScore() < 1) outputText("\n<font color=\"#ff0000\">Half Orca-boy/girl: 0</font>", false);
	if (player.phoenixScore() >= 10) outputText("\n<font color=\"#0000a0\">Phoenix: " + player.phoenixScore() + " (+" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (70 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib, +" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lust)</font>", false);
	else if (player.phoenixScore() >= 1 && player.phoenixScore() < 10) outputText("\n<font color=\"#008000\">Phoenix: " + player.phoenixScore() + "</font>", false);
	else if (player.phoenixScore() < 1) outputText("\n<font color=\"#ff0000\">Phoenix: 0</font>", false);
	outputText("\nPig-morph: " + player.pigScore(), false);
	if (player.plantScore() >= 7) outputText("\n<font color=\"#0000a0\">Treant/Dryad: " + player.plantScore() + " (+" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, -" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " Armor)</font>", false);
	else if (player.plantScore() == 6) outputText("\n<font color=\"#0000a0\">Treant/Dryad: " + player.plantScore() + " (+" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (80 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, -" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (8 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " Armor)</font>", false);
	else if (player.plantScore() == 5) outputText("\n<font color=\"#0000a0\">Plant-morph: " + player.plantScore() + " (+" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, -" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (4 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " Armor)</font>", false);
	else if (player.plantScore() == 4) outputText("\n<font color=\"#0000a0\">Plant-morph: " + player.plantScore() + " (+" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, -" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (2 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " Armor)</font>", false);
	else if (player.plantScore() >= 1 && player.plantScore() < 4) outputText("\n<font color=\"#008000\">Plant-morph: " + player.plantScore() + "</font>", false);
	else if (player.plantScore() < 1) outputText("\n<font color=\"#ff0000\">Plant-morph: 0</font>", false);
	if (player.raccoonScore() >= 4) outputText("\n<font color=\"#0000a0\">Raccoon-morph: " + player.raccoonScore() + " (+" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe)</font>", false);
	else if (player.raccoonScore() >= 1 && player.raccoonScore() < 4) outputText("\n<font color=\"#008000\">Raccoon-morph: " + player.raccoonScore() + "</font>", false);
	else if (player.raccoonScore() < 1) outputText("\n<font color=\"#ff0000\">Raccoon-morph: 0</font>", false);
	if (player.rhinoScore() >= 4) outputText("\n<font color=\"#0000a0\">Rhino-morph: " + player.rhinoScore() + " (+" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, -" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, -" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (100 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP)</font>", false);
	else if (player.rhinoScore() >= 1 && player.rhinoScore() < 4) outputText("\n<font color=\"#008000\">Rhino-morph: " + player.rhinoScore() + "</font>", false);
	else if (player.rhinoScore() < 1) outputText("\n<font color=\"#ff0000\">Rhino-morph: 0</font>", false);
	if (player.salamanderScore() >= 7) {
		outputText("\n<font color=\"#0000a0\">Salamander: " + player.salamanderScore() + " (+" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, ", false);
		if (player.findPerk(PerkLib.SalamanderAdrenalGlands) > 0) outputText("+" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (45 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		else outputText("+" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		outputText("max Lib, +" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lust)</font>", false);
	}
	else if (player.salamanderScore() >= 4 && player.salamanderScore() < 7) {
		outputText("\n<font color=\"#0000a0\">Half Salamander: " + player.salamanderScore() + " (+" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, ", false);
		if (player.findPerk(PerkLib.SalamanderAdrenalGlands) > 0) outputText("+" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		else outputText("+" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		outputText("max Lib, +" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lust)</font>", false);
	}
	else if (player.salamanderScore() >= 1 && player.salamanderScore() < 4) outputText("\n<font color=\"#008000\">Half Salamander: " + player.salamanderScore() + "</font>", false);
	else if (player.salamanderScore() < 1) outputText("\n<font color=\"#ff0000\">Half Salamander: 0</font>", false);
	if (player.satyrScore() >= 4) outputText("\n<font color=\"#0000a0\">Satyr: " + player.satyrScore() + " (+" + (5 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (5 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe)</font>", false);
	else if (player.satyrScore() >= 1 && player.satyrScore() < 4) outputText("\n<font color=\"#008000\">Satyr: " + player.satyrScore() + "</font>", false);
	else if (player.satyrScore() < 1) outputText("\n<font color=\"#ff0000\">Satyr: 0</font>", false);/*
	if (player.scorpionScore() >= ) outputText("\n<font color=\"#0000a0\">Scorpion-morph: " + player.scorpionScore() + "</font>", false);
	else if (player.scorpionScore() >= 1 && player.scorpionScore() < ) outputText("\n<font color=\"#008000\">Scorpion-morph: " + player.scorpionScore() + "</font>", false);
	else if (player.scorpionScore() < 1) outputText("\n<font color=\"#ff0000\">Scorpion-morph: 0</font>", false);*/
	outputText("\nScorpion-morph: " + player.scorpionScore(), false);
	if (player.scyllaScore() >= 5) {
		outputText("\n<font color=\"#0000a0\">Scylla: " + player.scyllaScore() + " ", false);
		if (player.findPerk(PerkLib.ScyllaInkGlands) > 0) outputText("(+" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		else outputText("(+" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		outputText("max Str, +" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP)</font>", false);
	}
	else if (player.scyllaScore() >= 1 && player.scyllaScore() < 5) outputText("\n<font color=\"#008000\">Scylla: " + player.scyllaScore() + "</font>", false);
	else if (player.scyllaScore() < 1) outputText("\n<font color=\"#ff0000\">Scylla: 0</font>", false);
	if (player.sharkScore() >= 9 && player.vaginas.length > 0 && player.cocks.length > 0) outputText("\n<font color=\"#0000a0\">Tigershark-morph: " + player.sharkScore() + " (+" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (70 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lust)</font>", false);
	else if (player.sharkScore() >= 8) outputText("\n<font color=\"#0000a0\">Shark-morph: " + player.sharkScore() + " (+" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (70 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib)</font>", false);
	else if (player.sharkScore() >= 4 && player.sharkScore() < 8) outputText("\n<font color=\"#0000a0\">Half Shark-morph: " + player.sharkScore() + " (+" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe)</font>", false);
	else if (player.sharkScore() >= 1 && player.sharkScore() < 4) outputText("\n<font color=\"#008000\">Half Shark-morph: " + player.sharkScore() + "</font>", false);
	else if (player.sharkScore() < 1) outputText("\n<font color=\"#ff0000\">Half Shark-morph: 0</font>", false);
	if (player.sirenScore() >= 10) outputText("\n<font color=\"#0000a0\">Siren: " + player.sirenScore() + " (+" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (70 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int)</font>", false);
	else if (player.sirenScore() >= 1 && player.sirenScore() < 10) outputText("\n<font color=\"#008000\">Siren: " + player.sirenScore() + "</font>", false);
	else if (player.sirenScore() < 1) outputText("\n<font color=\"#ff0000\">Siren: 0</font>", false);
	if (player.spiderScore() >= 7) outputText("\n<font color=\"#0000a0\">Spider-morph: " + player.spiderScore() + " (-" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (75 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int)</font>", false);
	else if (player.spiderScore() >= 4 && player.spiderScore() < 7) outputText("\n<font color=\"#0000a0\">Half Spider-morph: " + player.spiderScore() + " (-" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int)</font>", false);
	else if (player.spiderScore() >= 1 && player.spiderScore() < 4) outputText("\n<font color=\"#008000\">Half Spider-morph: " + player.spiderScore() + "</font>", false);
	else if (player.spiderScore() < 1) outputText("\n<font color=\"#ff0000\">Half Spider-morph: 0</font>", false);
	if (player.wolfScore() >= 10) outputText("\n<font color=\"#0000a0\">Fenrir: " + player.wolfScore() + " (+" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " maxTou, +" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " maxSpe, -" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int)</font>", false);
	else if (player.wolfScore() >= 7 && player.coatColor == "glacial white") outputText("\n<font color=\"#0000a0\">Winter wolf: " + player.wolfScore() + " (+" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " maxTou, +" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " maxSpe, -" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int)</font>", false);
	else if (player.wolfScore() >= 6) outputText("\n<font color=\"#0000a0\">Wolf-morph: " + player.wolfScore() + " (+" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " maxTou, +" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " maxSpe, -" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int)</font>", false);
	else if (player.wolfScore() >= 4 && player.wolfScore() < 6) outputText("\n<font color=\"#0000a0\">Wolf girl/boy: " + player.wolfScore() + " (+" + (15 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " maxSpe, -" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int)</font>", false);
	else if (player.wolfScore() >= 1 && player.wolfScore() < 4) outputText("\n<font color=\"#008000\">Wolf girl/boy: " + player.wolfScore() + "</font>", false);
	else if (player.wolfScore() < 1) outputText("\n<font color=\"#ff0000\">Wolf girl/boy: 0</font>", false);
	if (player.unicornScore() >= 5) outputText("\n<font color=\"#0000a0\">Unicorn: " + player.unicornScore() + " (+" + (5 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, +" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP, +" + (20 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Fatigue, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Soulforce)</font>", false);
	else if (player.unicornScore() >= 1 && player.unicornScore() < 5) outputText("\n<font color=\"#008000\">Unicorn: " + player.unicornScore() + "</font>", false);
	else if (player.unicornScore() < 1) outputText("\n<font color=\"#ff0000\">Unicorn: 0</font>", false);
	if (player.vouivreScore() >= 11) {
		outputText("\n<font color=\"#0000a0\">Vouivre: " + player.vouivreScore() + " (", false);
		if (player.isNaga()) outputText("+" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		else outputText("+" + (10 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (35 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " ", false);
		outputText("max Spe)</font>", false);//, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max HP
	}
	else if (player.vouivreScore() >= 1 && player.vouivreScore() < 11) outputText("\n<font color=\"#008000\">Vouivre: " + player.vouivreScore() + "</font>", false);
	else if (player.vouivreScore() < 1) outputText("\n<font color=\"#ff0000\">Vouivre: 0</font>", false);
	if (player.yetiScore() >= 12) outputText("\n<font color=\"#0000a0\">Yeti: " + player.yetiScore() + " (+" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (80 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, -" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib)</font>", false);
	else if (player.yetiScore() >= 6 && player.yetiScore() < 12) outputText("\n<font color=\"#0000a0\">Half Yeti: " + player.yetiScore() + " (+" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (40 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, -" + (30 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (25 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib)</font>", false);
	else if (player.yetiScore() >= 1 && player.yetiScore() < 6) outputText("\n<font color=\"#008000\">Half Yeti: " + player.yetiScore() + "</font>", false);
	else if (player.yetiScore() < 1) outputText("\n<font color=\"#ff0000\">Half Yeti: 0</font>", false);
	if (player.yggdrasilScore() >= 10) outputText("\n<font color=\"#0000a0\">Yggdrasil: " + player.yggdrasilScore() + " (+" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (80 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, -" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib)</font>", false);
//	else if (player.yggdrasilScore() == 9) outputText("\n<font color=\"#0000a0\">Yggdrasil: " + player.yggdrasilScore() + " (+" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (80 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, -" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib)</font>", false);
//	else if (player.yggdrasilScore() == 8) outputText("\n<font color=\"#0000a0\">Yggdrasil: " + player.yggdrasilScore() + " (+" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (80 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, -" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib)</font>", false);
//	else if (player.yggdrasilScore() == 7) outputText("\n<font color=\"#0000a0\">Yggdrasil: " + player.yggdrasilScore() + " (+" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Str, +" + (80 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Tou, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Spe, -" + (60 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Int, +" + (50 * (1 + flags[kFLAGS.NEW_GAME_PLUS_LEVEL])) + " max Lib)</font>", false);
	else if (player.yggdrasilScore() >= 1 && player.yggdrasilScore() < 10) outputText("\n<font color=\"#008000\">Yggdrasil: " + player.yggdrasilScore() + "</font>", false);
	else if (player.yggdrasilScore() < 1) outputText("\n<font color=\"#ff0000\">Yggdrasil: 0</font>", false);
	menu();
	addButton(0, "Next", playerMenu);
}

	public function sockDescript(index:int):void {
		outputText("  ");
		if (player.cocks[index].sock == "wool")
			outputText("It's covered by a wooly white cock-sock, keeping it snug and warm despite how cold it might get.");
		else if (player.cocks[index].sock == "alabaster")
			outputText("It's covered by a white, lacey cock-sock, snugly wrapping around it like a bridal dress around a bride.");
		else if (player.cocks[index].sock == "cockring")
			outputText("It's covered by a black latex cock-sock with two attached metal rings, keeping your cock just a little harder and [balls] aching for release.");
		else if (player.cocks[index].sock == "viridian")
			outputText("It's covered by a lacey dark green cock-sock accented with red rose-like patterns.  Just wearing it makes your body, especially your cock, tingle.");
		else if (player.cocks[index].sock == "scarlet")
			outputText("It's covered by a lacey red cock-sock that clings tightly to your member.  Just wearing it makes your cock throb, as if it yearns to be larger...");
		else if (player.cocks[index].sock == "cobalt")
			outputText("It's covered by a lacey blue cock-sock that clings tightly to your member... really tightly.  It's so tight it's almost uncomfortable, and you wonder if any growth might be inhibited.");
		else if (player.cocks[index].sock == "gilded")
			outputText("It's covered by a metallic gold cock-sock that clings tightly to you, its surface covered in glittering gems.  Despite the warmth of your body, the cock-sock remains cool.");
		else if (player.cocks[index].sock == "amaranthine") {
			outputText("It's covered by a lacey purple cock-sock");
			if (player.cocks[index].cockType != CockTypesEnum.DISPLACER)
				outputText(" that fits somewhat awkwardly on your member");
			else
				outputText(" that fits your coeurl cock perfectly");
			outputText(".  Just wearing it makes you feel stronger and more powerful.");
		}
		else if (player.cocks[index].sock == "red")
			outputText("It's covered by a red cock-sock that seems to glow.  Just wearing it makes you feel a bit powerful.");
		else if (player.cocks[index].sock == "green")
			outputText("It's covered by a green cock-sock that seems to glow.  Just wearing it makes you feel a bit healthier.");
		else if (player.cocks[index].sock == "blue")
			outputText("It's covered by a blue cock-sock that seems to glow.  Just wearing it makes you feel like you can cast spells more effectively.");

		else outputText("<b>Yo, this is an error.</b>");
	}
}
}