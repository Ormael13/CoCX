package classes {
import classes.BodyParts.*;
import classes.BodyParts.LowerBody;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.NPCs.JojoScene;
import classes.Scenes.SceneLib;

import coc.xxc.BoundStory;
import coc.xxc.Story;

public class PlayerAppearance extends BaseContent {


	public function PlayerAppearance() {
		onGameInit(init);
	}
	protected function inchesOrCentimetres(...args):String { return Measurements.inchesOrCentimetres.apply(null, args); }
	protected function shortSuffix(...args):String { return Measurements.shortSuffix.apply(null, args); }
	private function init():void {
 }
	public function appearance():void {
 //Temp vars
		var temp:Number = 0;
		var rando:Number = 0;
		//Determine race type:
		clearOutput();
		mainView.hideComboBox();
		outputText("<font size=\"36\" face=\"Georgia\"><u>Appearance</u></font>\n");
		if (CoC.instance.gameSettings.charviewEnabled) {
			mainViewManager.showPlayerDoll(debug);
		}
		describeRace();
		outputText("\n\n");
		describeGear();
		outputText("\n\n");
		describeFaceShape();
		outputText(" It has " + player.faceDesc() + "."); //M/F stuff!
		describeEyes();
		describeHairAndEars();
		describeHairStyle();
		describeBeard();
		describeTongue();
		describeHorns();
		describeVisage();
		outputText("[pg]");
		describeBodyShape();
		describeWings();
		describeRearBody();
		describeArms();
		describeLowerBody();

		outputText("\n");
	if (player.hasStatusEffect(StatusEffects.GooStuffed))

	{
		outputText("\n<b>Your gravid-looking belly is absolutely stuffed full of goo. There's no way you can get pregnant like this, but at the same time, you look like some fat-bellied breeder.</b>\n");
	}
	//Pregnancy Shiiiiiitz
	if((player.buttPregnancyType == PregnancyStore.PREGNANCY_FROG_GIRL) || (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR) || player.isPregnant()) {
		if (player.pregnancyType == PregnancyStore.PREGNANCY_OVIELIXIR_EGGS)
		{
			outputText("<b>");
			//Compute size
			temp = player.statusEffectv3(StatusEffects.Eggs) + player.statusEffectv2(StatusEffects.Eggs) * 10;
			if(player.pregnancyIncubation <= 50 && player.pregnancyIncubation > 20)
			{
				outputText("Your swollen pregnant belly is as large as a ");
				if(temp < 10)
					outputText("basketball.");
				if(temp >= 10 && temp < 20)
					outputText("watermelon.");
				if(temp >= 20)
					outputText("beach ball.");
			}
			if(player.pregnancyIncubation <= 20)
			{
				outputText("Your swollen pregnant belly is as large as a ");
				if(temp < 10)
					outputText("watermelon.");
				if(temp >= 10 && temp < 20)
					outputText("beach ball.");
				if(temp >= 20)
					outputText("large medicine ball.");
			}
			outputText("</b>");
			temp = 0;
		}
		//Satur preggos - only shows if bigger than regular pregnancy or not pregnancy
		else if (player.buttPregnancyType == PregnancyStore.PREGNANCY_SATYR && player.buttPregnancyIncubation > player.pregnancyIncubation)
		{
			if(player.buttPregnancyIncubation < 125 && player.buttPregnancyIncubation >= 75)
			{
				outputText("<b>You've got the beginnings of a small pot-belly.</b>");
			}
			else if(player.buttPregnancyIncubation >= 50)
			{
				outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy, yet it feels odd inside you - wrong somehow.</b>");
			}
			else if(player.buttPregnancyIncubation >= 30)
			{
				outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
			}
			else
			{ //Surely Benoit and Cotton deserve their place in this list
				if (player.pregnancyType == PregnancyStore.PREGNANCY_IZMA || player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_AMILY || (player.pregnancyType == PregnancyStore.PREGNANCY_JOJO && (JojoScene.monk <= 0 || flags[kFLAGS.JOJO_BIMBO_STATE] >= 3)) || player.pregnancyType == PregnancyStore.PREGNANCY_EMBER || player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT || player.pregnancyType == PregnancyStore.PREGNANCY_COTTON
				|| player.pregnancyType == PregnancyStore.PREGNANCY_URTA || player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH || player.pregnancyType == PregnancyStore.PREGNANCY_ZENJI)
					outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
				else if(player.pregnancyType != PregnancyStore.PREGNANCY_MARBLE)
					outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>");
				else outputText("\n<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>");
			}
		}
		//URTA PREG
		else if (player.pregnancyType == PregnancyStore.PREGNANCY_URTA)
		{
			if(player.pregnancyIncubation <= 432 && player.pregnancyIncubation > 360)
			{
				outputText("<b>Your belly is larger than it used to be.</b>\n");
			}
			if(player.pregnancyIncubation <= 360 && player.pregnancyIncubation > 288)
			{
				outputText("<b>Your belly is more noticeably distended. You're pretty sure it's Urta's.</b>");
			}
			if(player.pregnancyIncubation <= 288 && player.pregnancyIncubation > 216)
			{
				outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy, and the baby within is kicking nowadays.</b>");
			}
			if(player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 144)
			{
				outputText("<b>Your belly is large and very obviously pregnant to anyone who looks at you. It's gotten heavy enough to be a pain to carry around all the time.</b>");
			}
			if(player.pregnancyIncubation <= 144 && player.pregnancyIncubation > 72)
			{
				outputText("<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way. It's large and round, frequently moving.</b>");
			}
			if(player.pregnancyIncubation <= 72 && player.pregnancyIncubation > 48)
			{
				outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
			}
			if(player.pregnancyIncubation <= 48)
			{
				outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
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
				outputText("<b>Your belly is larger than it used to be.</b>");
			}
			if(player.pregnancyIncubation <= 280 && player.pregnancyIncubation > 216)
			{
				outputText("<b>Your belly is more noticeably distended. You are probably pregnant.</b>");
			}
			if(player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 180)
			{
				outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy.</b>");
			}
			if(player.pregnancyIncubation <= 180 && player.pregnancyIncubation > 120)
			{
				outputText("<b>Your belly is very obviously pregnant to anyone who looks at you.</b>");
			}
			if(player.pregnancyIncubation <= 120 && player.pregnancyIncubation > 72)
			{
				outputText("<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way.</b>");
			}
			if(player.pregnancyIncubation <= 72 && player.pregnancyIncubation > 48)
			{
				outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>");
			}
			if (player.pregnancyIncubation <= 48)
			{ //Surely Benoit and Cotton deserve their place in this list
				if (player.pregnancyType == PregnancyStore.PREGNANCY_IZMA || player.pregnancyType == PregnancyStore.PREGNANCY_MOUSE || player.pregnancyType == PregnancyStore.PREGNANCY_AMILY || (player.pregnancyType == PregnancyStore.PREGNANCY_JOJO && JojoScene.monk <= 0) || player.pregnancyType == PregnancyStore.PREGNANCY_EMBER || player.pregnancyType == PregnancyStore.PREGNANCY_BENOIT || player.pregnancyType == PregnancyStore.PREGNANCY_COTTON
				|| player.pregnancyType == PregnancyStore.PREGNANCY_URTA || player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA || player.pregnancyType == PregnancyStore.PREGNANCY_BEHEMOTH || player.pregnancyType == PregnancyStore.PREGNANCY_ZENJI)
					outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>");
				else if (player.pregnancyType != PregnancyStore.PREGNANCY_MARBLE)
					outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>");
				else outputText("\n<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>");
			}
		}
		outputText("\n");
	}
	outputText("\n");
	if(player.gills.type == Gills.ANEMONE)
		outputText("A pair of feathery gills are growing out just below your neck, spreading out horizontally and draping down your chest. They allow you to stay in the water for quite a long time. ");
	//Chesticles..I mean bewbz.
	if(player.breastRows.length == 1) {
		outputText("You have " + num2Text(player.breastRows[temp].breasts) + " " + breastDescript(temp) + ", each supporting ");
		outputText(num2Text(player.breastRows[temp].nipplesPerBreast) + " "); //Number of nipples.
		outputText(Measurements.shortSuffix(int(player.nippleLength *10)/10)+" ");
		//if (flags[kFLAGS.USE_METRICS] > 0 ) outputText(int(player.nippleLength * 2.54 * 10) / 10 + "-cm "); //Centimeter display
		//else outputText(int(player.nippleLength * 10) / 10 + "-inch "); //Inches display
		outputText(nippleDescript(temp) + (player.breastRows[0].nipplesPerBreast == 1 ? "." : "s.")); //Nipple description and plural
		if(player.breastRows[0].milkFullness > 75)
			outputText(" Your " + breastDescript(temp) + " are painful and sensitive from being so stuffed with milk. You should release the pressure soon.");
		if(player.breastRows[0].breastRating >= 1)
			outputText(" You could easily fill a " + player.breastCup(temp) + " bra.");
		//Done with tits. Move on.
		outputText("\n");
	}
	//many rows
	else
	{
		outputText("You have " + num2Text(player.breastRows.length) + " rows of breasts, the topmost pair starting at your chest.\n");
		while (temp < player.breastRows.length)
		{
			if(temp == 0)
				outputText("--Your uppermost rack houses ");
			if(temp == 1)
				outputText("\n--The second row holds ");
			if(temp == 2)
				outputText("\n--Your third row of breasts contains ");
			if(temp == 3)
				outputText("\n--Your fourth set of tits cradles ");
			if(temp == 4)
				outputText("\n--Your fifth and final mammary grouping swells with ");
			outputText(num2Text(player.breastRows[temp].breasts) + " " + breastDescript(temp) + " with ");
			outputText(num2Text(player.breastRows[temp].nipplesPerBreast) + " "); //Number of nipples per breast
			outputText(Measurements.shortSuffix(int(player.nippleLength*10)/10));
			//if (flags[kFLAGS.USE_METRICS] > 0 ) outputText(int(player.nippleLength * 2.54 * 10) / 10 + "-cm "); //Centimeter
			//else outputText(int(player.nippleLength * 10) / 10 + "-inch "); //Inches
			outputText(" " + nippleDescript(temp) + (player.breastRows[0].nipplesPerBreast == 1 ? " each." : "s each.")); //Description and Plural
			if(player.breastRows[temp].breastRating >= 1)
				outputText(" They could easily fill a " + player.breastCup(temp) + " bra.");
			if(player.breastRows[temp].milkFullness > 75)
				outputText(" Your " + breastDescript(temp) + " are painful and sensitive from being so stuffed with milk. You should release the pressure soon.");
			temp++;
		}
		//Done with tits. Move on.
		outputText("\n");
	}
	//Crotchial stuff - mention snake
	if(player.isNaga() && player.gender > 0) {
		outputText("\nYour sex");
		if(player.gender == 3 || player.cockTotal() > 1)
			outputText("es are ");
		else outputText(" is ");
		outputText("concealed within a cavity in your tail when not in use, though when the need arises, you can part your concealing slit and reveal your true self.\n");
	}
	//Crotchial stuff - mention scylla
	if(player.lowerBody == LowerBody.SCYLLA || player.lowerBody == LowerBody.KRAKEN) {
		if(player.gender == 1)
		{
			outputText("\nYour sex is concealed between your front octopus tentacle legs dangling freely when not in use.\n");
		}
		if(player.gender == 2)
		{
			outputText("\nYour sex is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal your true self.\n");
		}
		if(player.gender == 3)
		{
			outputText("\nYour sex");
			if(player.cockTotal() > 1)
				outputText("es are ");
			else outputText(" is ");
			outputText("concealed between your front octopus tentacle legs dangling freely. Other set is concealed underneath your octopus tentacle legs when not in use, though when the need arises, you can rise some of the tentacles and reveal it.\n");
		}
	}
	if(player.lowerBody == LowerBody.MELKIE) {
		outputText("\nYou have a outer set of vaginal lips at the junction between your human body and seal tail in which your internal sex and human legs are hidden when not in use\n");
	}
	//Cock stuff!
	if (player.hasCock()) {
		rando = rand(100);
		//outputText("\nYour " + cockDescript(temp) + " is " + Measurements.inchesOrCentimetres(int(10*cock.cockLength)/10) + " long and ");
		if (player.isTaur() && player.cocks.length == 1)
			outputText("\nYour equipment has shifted to lie between your hind legs, like a feral animal.");
		else if (player.isTaur())
			outputText("\nBetween your hind legs, you have grown " + player.multiCockDescript() + "!\n");
		else if ((player.isScylla() || player.isKraken()) && player.cocks.length == 1)
			outputText("\nYour equipment has shifted to lie between your front tentacles.");
		else if (player.isScylla() || player.isKraken())
			outputText("\nBetween front tentacles of your bestial body you have grown " + player.multiCockDescript() + "!\n");
		else if (player.isAlraune())
			outputText("\nYour equipment has shifted to lie below your pitcher now in the form of a mass of tentacle vine.");
		else if (player.cocks.length == 1)
			outputText("\n");
		else
			outputText("\nWhere a penis would normally be located, you have instead grown " + player.multiCockDescript() + "!\n");
		for (var cock_index:int = 0; cock_index < player.cocks.length; cock_index++) {
			rando++;
			// How to start the sentence?
			if (player.cocks.length == 1) outputText("Your ");
			else if (cock_index == 0) outputText("--Your first ");
			else if (rando % 5 == 0) outputText("--The next ");
			else if (rando % 5 == 1) outputText("--The " + num2Text2(cock_index+1) + " of your ");
			else if (rando % 5 == 2) outputText("--One of your ");
			else if (rando % 5 == 3) outputText("--The " + num2Text2(cock_index+1) + " ");
			else if (rando % 5 == 4) outputText("--Another of your ");
			// How large?
			outputText(player.cockDescript(cock_index) + ((rando % 5) % 3 == 0 || cock_index == 0 ? "":"s") + " is " + inchesOrCentimetres(player.cocks[cock_index].cockLength) + " long and ");
			outputText(inchesOrCentimetres(player.cocks[cock_index].cockThickness));
			if (rando % 3 == 0) outputText(" wide.");
			else if (rando % 3 == 1) outputText(" thick.");
			else if (rando % 3 == 2) outputText(" in diameter.");
			// What flavor of cock do you have?
			switch (player.cocks[cock_index].cockType) {
				case CockTypesEnum.HORSE: outputText(" It's mottled black and brown in a very animalistic pattern. The 'head' of its shaft flares proudly, just like a horse's."); break;
				case CockTypesEnum.DOG: outputText(" It is shiny, pointed, and covered in veins, just like a large dog's cock."); break;
				case CockTypesEnum.WOLF: outputText(" It is shiny red, pointed, and covered in veins, just like a large wolf's cock."); break;
				case CockTypesEnum.FOX: outputText(" It is shiny, pointed, and covered in veins, just like a large fox's cock."); break;
				case CockTypesEnum.DEMON: outputText(" The crown is ringed with a circle of rubbery protrusions that grow larger as you get more aroused. The entire thing is shiny and covered with tiny, sensitive nodules that leave no doubt about its demonic origins."); break;
				case CockTypesEnum.TENTACLE: outputText(" The entirety of its green surface is covered in perspiring beads of slick moisture. It frequently shifts and moves of its own volition, the slightly oversized and mushroom-like head shifting in coloration to purplish-red whenever you become aroused."); break;
				case CockTypesEnum.STAMEN: outputText(" It is dark green, tampered, and crowned by several colorful balls near the tip that secrete pollen when aroused."); break;
				case CockTypesEnum.CAT: outputText(" It ends in a single point, much like a spike, and is covered in small, fleshy barbs. The barbs are larger at the base and shrink in size as they get closer to the tip. Each of the spines is soft and flexible, and shouldn't be painful for any of your partners."); break;
				case CockTypesEnum.LIZARD: outputText(" It's a deep, iridescent purple in color. Unlike a human penis, the shaft is not smooth, and is instead patterned with multiple bulbous bumps."); break;
				case CockTypesEnum.CAVE_WYRM: outputText(" It's a deep, glowing neon blue in color. Unlike a human penis, the shaft is not smooth, and is instead patterned with multiple bulbous bumps. It also regularly drips the acidic substance that serves as your cum. In the event you need to fertilise more fragile partner you can slightly alter the composition of your cum to prevent disolving their flesh."); break;
				case CockTypesEnum.CANCER: 	 outputText(" It constantly drips and produce bubbles."); break;
				case CockTypesEnum.ANEMONE: outputText(" The crown is surrounded by tiny tentacles with a venomous, aphrodisiac payload. At its base a number of similar, longer tentacles have formed, guaranteeing that pleasure will be forced upon your partners."); break;
				case CockTypesEnum.KANGAROO: outputText(" It usually lies coiled inside a sheath, but undulates gently and tapers to a point when erect, somewhat like a taproot."); break;
				case CockTypesEnum.DRAGON: outputText(" With its tapered tip, there are few holes you wouldn't be able to get into. It has a strange, knot-like bulb at its base, but doesn't usually flare during arousal as a dog's knot would."); break;
				case CockTypesEnum.BEE: outputText(" It's a long, smooth black shaft that's rigid to the touch. Its base is ringed with a layer of " + shortSuffix(4) + " long soft bee hair. The tip has a much finer layer of short yellow hairs. The tip is very sensitive, and it hurts constantly if you don’t have bee honey on it."); break;
				case CockTypesEnum.PIG: outputText(" It's bright pinkish red, ending in a prominent corkscrew shape at the tip."); break;
				case CockTypesEnum.AVIAN: outputText(" It's a red, tapered cock that ends in a tip. It rests nicely in a sheath."); break;
				case CockTypesEnum.RHINO: outputText(" It's a smooth, tough pink colored and takes on a long and narrow shape with an oval shaped bulge along the center."); break;
				case CockTypesEnum.ECHIDNA: outputText(" It is quite a sight to behold, coming well-equipped with four heads."); break;
				case CockTypesEnum.RED_PANDA: outputText(" It lies protected in a soft, fuzzy sheath."); break;
				case CockTypesEnum.OOMUKADE: outputText(" It constantly drips with venom."); break;
				case CockTypesEnum.USHI_ONI: outputText(" It's starfish tipped shaft."); break;
				default: //Nothing here, move along!
			}
			// Knot?
			if (player.cocks[cock_index].knotMultiplier > 1) {
				if (player.cocks[cock_index].knotMultiplier >= 1.8)
					outputText(" The obscenely swollen lump of flesh near the base of your " + player.cockDescript(cock_index) + " looks almost comically mismatched for your cock.");
				else if (player.cocks[cock_index].knotMultiplier >= 1.4)
					outputText(" A large bulge of flesh nestles just above the bottom of your " + player.cockDescript(cock_index) + ", to ensure it stays where it belongs during mating.");
				else // knotMultiplier < 1.4
					outputText(" A small knot of thicker flesh is near the base of your " + player.cockDescript(cock_index) + ", ready to expand to help you lodge it inside a female.");
				outputText(" The knot is " + inchesOrCentimetres(player.cocks[cock_index].cockThickness * player.cocks[cock_index].knotMultiplier) + " thick when at full size.");
			}
			// Sock Flavor
			if (player.cocks[cock_index].sock != "" && player.cocks[cock_index].sock != null){
				// I dunno what was happening, but it looks like .sock is null, as it doesn't exist. I guess this is probably more left over from some of the restucturing.
				// Anyways, check against null values, and stuff works again.
				//trace("Found a sock description (WTF even is a sock?)", player.cocks[cock_index].sock);
				sockDescript(cock_index);
			}
			outputText("\n");
		}
		//Worm flavor
		if (player.hasStatusEffect(StatusEffects.Infested)) outputText("Every now and again slimy worms coated in spunk slip partway out of your " + player.multiCockDescriptLight() + ", tasting the air like tongues of snakes.\n");
	}
	//Of Balls and Sacks!
	if(player.balls > 0) {
		if(player.hasStatusEffect(StatusEffects.Uniball))
		{
			if(player.skinType != Skin.GOO) outputText("Your [sack] clings tightly to your groin, holding [balls] snugly against you.");
			else if(player.skinType == Skin.GOO) outputText("Your [sack] clings tightly to your groin, dripping and holding [balls] snugly against you.");
		}
		else {
			var sdesc:String;
			if (player.skin.hasMagicalTattoo()) sdesc = " covered by magical tattoo";
			else if (player.skin.hasBattleTattoo()) sdesc = " covered by battle tattoo";
			else if (player.skin.hasLightningShapedTattoo()) sdesc = " covered with a few glowing lightning tattoos";
			else if (player.skin.hasWindSweptScars()) sdesc = " covered with scars as if your skin was cut in various place by a windstorm";
			else if (player.skin.hasOilySkin()) sdesc =" dripping with oily black fluids.";
			else if (player.skin.hasScarShapedTattoo()) sdesc = " covered by scar tattoos";
			else if (player.skin.hasVenomousMarking()) sdesc = " covered by venomous marking";
			else if (player.skin.hasWhiteBlackVeins()) sdesc = " covered by [base.color2] veins";
			else sdesc = "";
			var swingsWhere:String;
			if (player.cockTotal() == 0) swingsWhere = " where a penis would normally grow.";
			else swingsWhere = " under your [cocks].";
			if (player.hasPlainSkinOnly() || player.hasRubberSkin()) outputText("A [sack]" + sdesc + " with [balls] swings heavily" + swingsWhere);
			else if (player.hasFur()) outputText("A fuzzy [sack] filled with [balls] swings low" + swingsWhere);
			else if (player.hasCoatOfType(Skin.CHITIN)) outputText("A chitin [sack] hugs your [balls] tightly against your body.");
			else if (player.hasScales()) outputText("A scaly [sack] hugs your [balls] tightly against your body.");
			else if (player.skinType == Skin.STONE) outputText("A stone-solid sack with [balls] swings heavily" + swingsWhere);
			else if (player.skinType == Skin.GOO) outputText("An oozing, semi-solid sack with [balls] swings heavily" + swingsWhere);
		}

		outputText(" You estimate each of them to be about " + num2Text(Math.round(player.ballSize)) + " ");
		if(Math.round(player.ballSize) == 1)
			outputText("inch");
		else outputText("inches");
		outputText(" across.\n");
		//Worms extra descript. To match as seen in infested hellhounds.
		if (player.hasStatusEffect(StatusEffects.Infested) && player.statusEffectv1(StatusEffects.Infested) == 5) outputText("Across it's surface, random lumps move rapidly around, further proof of your infested sack, and it's wormy inhabitants that both boost and increase your cum production.\n")
	} else {
		if (player.hasStatusEffect(StatusEffects.Infested) && player.statusEffectv1(StatusEffects.Infested) == 5) outputText("Deep within your prostate you feel the worms moving, constantly rubbing against your trigger button, keeping you aroused and constantly churning up cum to be spewed out at a moment's notice.\n")
	}
	//VAGOOZ
	//Handling multiple vagooz.
	if (player.vaginas.length > 0){
		var vagLoop:int = 0
		var clitExists:int = 0
		if((player.gender == 2 || player.gender == 3) && player.isTaur() && player.lowerBody != 26)//26 is scylla.
			outputText("\nYour womanly parts have shifted to lie between your hind legs, in a rather feral fashion.");
		if((player.gender == 2 || player.gender == 3) && (player.isScylla() || player.isKraken()))
			outputText("\nYour womanly parts have shifted to lie underneath your tentacle legs.");
		if (player.vaginas.length == 1){
			if (player.lowerBody == LowerBody.MELKIE){
				outputText("\nYou have a set of vaginal lips, "); //one twice as big as the other and hiding the smaller within its folds. Behind your first set of lips, you have a " + vaginaDescript(0) + ", with a " + Measurements.shortSuffix(int(player.clitLength*10)/10) + " clit");
			} else {
				outputText("\nYour " + vaginaDescript(0));
			}
		} else {
			if (player.lowerBody == LowerBody.MELKIE){
				outputText("\nYou have two sets of vaginal lips, the first set"); //set in pairs, one twice as big as the other and hiding the smaller within its folds. Behind your first set of lips, you have a " + vaginaDescript(0) + ", with a " + Measurements.shortSuffix(int(player.clitLength*10)/10) + " clit, and behind your second set of lips, you have a " + vaginaDescript(1) + ", with a " + Measurements.shortSuffix(int(player.clitLength*10)/10) + " clit");
			} else {
				outputText("\nYour first " + vaginaDescript(0));
			}
		}
		for(var i:int=0; i<player.vaginas.length; i++){
			var vagType:int = player.vaginaType(-1, i) //It's not iterating properly to register the second pussy.
			switch(vagType){ //missing black sand trap, maybe melkie.
				case VaginaClass.EQUINE:
					outputText(" is deep and wide just like that of a horse. Sometime you lament that most of your partners are no longer big enough to satisfy you. Inside you have a ");
					break;
				case VaginaClass.CANCER:
					outputText(" is constantly foaming, in anticipation for a potential mate. Hidden within is a ");
					break;
				case VaginaClass.SCYLLA:
					outputText(" has no clit. Instead, several concentric rings of small nubs line up the walls of your gaping maw of a vagina, each easily as sensitive as a human clitoris would be.");
					clitExists++
					break;
				case LowerBody.MELKIE:
					outputText(" set is twice as big as the other, and the other hidden within it's folds. Your outer lips hide a")
					break;
				case VaginaClass.MANTICORE:
					outputText(" is ultrasensitive, even the slightest touch is enough to make you moan out a melody. Your song-box hides a ");
					break;
				case VaginaClass.CAVE_WYRM:
					outputText(" constantly drools acid, small puffs of dissolving matter wafting up from beneath where you're standing. Your dissolving chamber hides a ");
					break;
				case VaginaClass.VENOM_DRIPPING:
					outputText(" constantly drools an aphrodisiac venom, forcing any potential mates to be ready regardless of their physical state. Your lust-enhancers hides a ");
					break;
				case VaginaClass.ALRAUNE:
					outputText(" constantly secretes aphrodisiac-like nectar, ensuring any stamen that parts your petals are sufficiently lubricated and ready to fertilize you. Your flower hides a ");
					break;
				case VaginaClass.DEMONIC:
					outputText(", unlike a normal pussy, feels and acts akin to a mouth that allows you to taste and savor the flavor of the cum injected within as if it landed on your tongue. Your sensitive walls are also prehensile, and you can control them to milk a cock just as well as your hand could. Your dexterous, cum-hungry twat hides a ");
					break;
				case VaginaClass.NAGA:
					outputText(" is deep and wide enough to insert your entire arm lenght inside and some more. Sometime you lament that most of your partners are no longer big enough to satisfy you");
					if (player.lowerBody == LowerBody.NAGA) outputText("as your hot spot is now way further inside your lenghtly canal requiring quite a longer member to reach");
							outputText(". Inside you have a ");
					break;
				default:
					outputText(" hides a ");
					break;
			}
			//Clit check. Only for Scylla for now.
			if (clitExists == 0) outputText(Measurements.shortSuffix(int(player.clitLength * 10) / 10) + " clit");
			//Hymen check.
			if(player.vaginas[i].virgin) {
				outputText(". It's hymen is intact. ");
			} else{
				outputText(". ");
			}
			//Wetness check.
			if(player.lib < 50 && player.lust < 50) //not particularly horny
			{
				//Wetness
				if(player.vaginas[i].vaginalWetness >= VaginaClass.WETNESS_WET && player.vaginas[i].vaginalWetness< VaginaClass.WETNESS_DROOLING)
					outputText("Moisture gleams in ");
				if(player.vaginas[i].vaginalWetness>= VaginaClass.WETNESS_DROOLING)
				{
					outputText("Occasional beads of ");
					outputText("lubricant drip from ");
				}
				//Different description based on vag looseness
				if(player.vaginas[i].vaginalWetness>= VaginaClass.WETNESS_WET)
				{
					if(player.vaginas[i].vaginalLooseness< VaginaClass.LOOSENESS_LOOSE)
						outputText("your " + vaginaDescript(i) + ". ");
					if(player.vaginas[i].vaginalLooseness>= VaginaClass.LOOSENESS_LOOSE && player.vaginas[i].vaginalLooseness< VaginaClass.LOOSENESS_GAPING_WIDE)
						outputText("your " + vaginaDescript(i) + ", its lips slightly parted. ");
					if(player.vaginas[i].vaginalLooseness>= VaginaClass.LOOSENESS_GAPING_WIDE)
						outputText("the massive hole that is your " + vaginaDescript(0) + ". ");
				}
			}
			if((player.lib>=50 || player.lust >=50) && (player.lib< 80 && player.lust < 80)) //kinda horny

			{
				//Wetness
				if(player.vaginas[i].vaginalWetness< VaginaClass.WETNESS_WET)
					outputText("Moisture gleams in ");
				if(player.vaginas[i].vaginalWetness>= VaginaClass.WETNESS_WET && player.vaginas[i].vaginalWetness< VaginaClass.WETNESS_DROOLING)
				{
					outputText("Occasional beads of ");
					outputText("lubricant drip from ");
				}
				if(player.vaginas[i].vaginalWetness>= VaginaClass.WETNESS_DROOLING)
				{
					outputText("Thin streams of ");
					outputText("lubricant occasionally dribble from ");
				}
				//Different description based on vag looseness
				if(player.vaginas[i].vaginalLooseness< VaginaClass.LOOSENESS_LOOSE)
					outputText("your " + vaginaDescript(i) + ". ");
				if(player.vaginas[i].vaginalLooseness>= VaginaClass.LOOSENESS_LOOSE && player.vaginas[i].vaginalLooseness< VaginaClass.LOOSENESS_GAPING_WIDE)
					outputText("your " + vaginaDescript(i) + ", its lips slightly parted. ");
				if(player.vaginas[i].vaginalLooseness>= VaginaClass.LOOSENESS_GAPING_WIDE)
					outputText("the massive hole that is your " + vaginaDescript(0) + ". ");
			}
			if((player.lib> 80 || player.lust > 80)) //WTF horny!

			{
				//Wetness
				if(player.vaginas[i].vaginalWetness< VaginaClass.WETNESS_WET)

				{
					outputText("Occasional beads of ");
					outputText("lubricant drip from ");
				}
				if(player.vaginas[i].vaginalWetness>= VaginaClass.WETNESS_WET && player.vaginas[i].vaginalWetness< VaginaClass.WETNESS_DROOLING)

				{
					outputText("Thin streams of ");
					outputText("lubricant occasionally dribble from ");
				}
				if(player.vaginas[i].vaginalWetness>= VaginaClass.WETNESS_DROOLING)

				{
					outputText("Thick streams of ");
					outputText("lubricant drool constantly from ");
				}
				//Different description based on vag looseness
				if(player.vaginas[i].vaginalLooseness< VaginaClass.LOOSENESS_LOOSE)
					outputText("your " + vaginaDescript(i) + ". ");
				if(player.vaginas[i].vaginalLooseness>= VaginaClass.LOOSENESS_LOOSE && player.vaginas[i].vaginalLooseness< VaginaClass.LOOSENESS_GAPING_WIDE)
					outputText("your " + vaginaDescript(i) + ", its lips slightly parted. ");
				if(player.vaginas[i].vaginalLooseness>= VaginaClass.LOOSENESS_GAPING_WIDE)
					outputText("the massive hole that is your cunt. ");
			}

			if (player.vaginas.length > 1 && vagLoop == 0){
				outputText("\n\nYour second " + vaginaDescript(1)+ " ");
				vagLoop++
				clitExists = 0
			}
		}
		//Line Drop for next descript!
		outputText("\n");
	}

	//Genderless lovun'
	if(player.cockTotal() == 0 && player.vaginas.length == 0)
		outputText("\nYou have a curious lack of any sexual endowments.\n");


	//BUNGHOLIO
	if(player.ass) {
		outputText("\n");
		outputText("You have one " + assholeDescript() + ", placed between your butt-cheeks where it belongs.\n");
	}
	//Piercings!
	if(player.eyebrowPierced > 0)
		outputText("\nA solitary " + player.eyebrowPShort + " adorns your eyebrow, looking very stylish.");
	if(player.earsPierced > 0)
		outputText("\nYour ears are pierced with " + player.earsPShort + ".");
	if(player.nosePierced > 0)
		outputText("\nA " + player.nosePShort + " dangles from your nose.");
	if(player.lipPierced > 0)
		outputText("\nShining on your lip, a " + player.lipPShort + " is plainly visible.");
	if(player.tonguePierced > 0)
		outputText("\nThough not visible, you can plainly feel your " + player.tonguePShort + " secured in your tongue.");
	if(player.nipplesPierced == 3)
		outputText("\nYour " + nippleDescript(0) + "s ache and tingle with every step, as your heavy " + player.nipplesPShort + " swings back and forth.");
	else if(player.nipplesPierced > 0)
		outputText("\nYour " + nippleDescript(0) + "s are pierced with " + player.nipplesPShort + ".");
	if(player.cockTotal() > 0) {
		if(player.cocks[0].pierced > 0)
		{
			outputText("\nLooking positively perverse, a " + player.cocks[0].pShortDesc + " adorns your [cock].");
		}
	}
	if(flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00286] == 1)
		outputText("\nA magical, ruby-studded bar pierces your belly button, allowing you to summon Ceraph on a whim.");
	if(player.hasVagina()) {
		if(player.vaginas[0].labiaPierced > 0)
			outputText("\nYour " + vaginaDescript(0) + " glitters with the " + player.vaginas[0].labiaPShort + " hanging from your lips.");
		if(player.vaginas[0].clitPierced > 0)
			outputText("\nImpossible to ignore, your " + clitDescript() + " glitters with its " + player.vaginas[0].clitPShort + ".");
	}
	//MONEY!
	if(player.gems == 0)
		outputText("\n\n<b>Your money-purse is devoid of any currency.</b>");
	if(player.gems > 1)
		outputText("\n\n<b>You have " + addComma(Math.floor(player.gems)) + " shining gems, collected in your travels.</b>");
	if(player.gems == 1)
		outputText("\n\n<b>You have " + addComma(Math.floor(player.gems)) + " shining gem, collected in your travels.</b>");
	menu();
	addButton(0, "Next", playerMenu);
	if (player.hasPerk(PerkLib.RacialParagon)) addButton(1, "Set Race.", ApexRaceSetting);
	addButton(2, "Weap View", WeaponDisplay);
	addButton(7, "Reflect", campActionsReflect).hint("Reflect on your current state and future plans. (Also would make your body fully adjust to any sudden changes to natural limits of your attributes after eating any odd things and etc.)");
	addButton(11, "Gender Set.", GenderForcedSetting);
	addButton(10, "RacialScores", RacialScores);
	flushOutputTextToGUI();
}

	public function	WeaponDisplay():void {
		clearOutput();
		outputText("Select which weapon type you would prefer to see in the character portrait.");
		if (flags[kFLAGS.WEAPON_DISPLAY_FLAG] == 0) outputText("\n\nDisplay Style: <b>Melee</b>");
		if (flags[kFLAGS.WEAPON_DISPLAY_FLAG] == 1) outputText("\n\nDisplay Style: <b>Ranged</b>");
		mainView.hideAllMenuButtons();
		menu();
		addButton(0, "Melee", WeaponDisplaySwitch, 0).disableIf(flags[kFLAGS.WEAPON_DISPLAY_FLAG] == 0, "You are already displaying Melee weapons");
		addButton(1, "Ranged", WeaponDisplaySwitch, 1).disableIf(flags[kFLAGS.WEAPON_DISPLAY_FLAG] == 1, "You are already displaying Ranged weapons");
		addButton(14, "Back", appearance);
	}

	public function	WeaponDisplaySwitch(Display:Number):void {
		flags[kFLAGS.WEAPON_DISPLAY_FLAG] = Display;
		WeaponDisplay();
	}

	public function ApexRaceSetting():void {
		clearOutput();
		mainView.hideAllMenuButtons();
		ApexRaceDisplayTextUpdate();
		// Display selected race
		var races:Array = [];
		for (var i:int = 0; i < Race.ALL_RACES.length; i++) {
			var x:Race = Race.ALL_RACES[i];
			if (!x) continue; // Skip non-existing races
			races.push( { label: x.name, race: x} );
		}
		// fill the races
		CoC.instance.showComboBox(races,"Select race",function(item:Object):void {
			// item is selected
			flags[kFLAGS.APEX_SELECTED_RACE] = item.race.id;
			clearOutput();
			ApexRaceDisplayTextUpdate();
		});
		menu();
		addButton(0, "Finish", appearance);
	}

	public function ApexRaceDisplayTextUpdate():void {
		outputText("Select your racial paragon race: ");
		var selectedracetext:String;
		if (player.racialParagonSelectedRace() == null)
		{
			selectedracetext = "None";
		}
		else{selectedracetext = player.racialParagonSelectedRace().name}
		outputText("\n\nCurrently selected: <b>" + selectedracetext + "</b>");
		flushOutputTextToGUI()
	}

	public function describeBodyShape():void {
		outputText("You have a humanoid shape with the usual body");
		if (player.skin.coverage == Skin.COVERAGE_LOW) {
			outputText(" partialy covered with [skin coat]");
		} else if (player.skin.coverage >= Skin.COVERAGE_MEDIUM) {
			outputText(" covered with [skin coat]");
		}
		outputText(", arms, hands and fingers.");
		if (player.skin.base.pattern != Skin.PATTERN_NONE && player.skin.coverage < Skin.COVERAGE_MEDIUM){
			outputText(" Your skin is also covered in various place with "+player.skin.base.adj+".");
		}
		if (player.skin.base.pattern == Skin.PATTERN_ORCA_UNDERBODY) outputText(" However your skin is [skin color] with a [skin color2] underbelly that runs on the underside of your limbs and has a glossy shine, similar to that of an orca.");
		if (player.skin.base.pattern == Skin.PATTERN_SEADRAGON_UNDERBODY) outputText(" However your skin is [skin color] with a [skin color2] underbelly that runs on the underside of your limbs and has a glossy shine, similar to that of a sea dragon. Your underbelly is also lined up with bioluminescent dots like those of a deep sea fish.\n");
		if (player.skin.base.pattern == Skin.PATTERN_RED_PANDA_UNDERBODY) outputText(" Your body is covered from head to toe in [skin color] with a [skin color2] underbelly, giving to your nimble frame a red-panda appearance.");
		if (player.skin.base.pattern == Skin.PATTERN_USHI_ONI_ONNA_TATTOO) outputText(" You have strange ushi oni-onna tattoos in your body, they appear in your belly, chest, breasts, shoulders and even face, you don’t know why but some are like a black sheen plate while others are just fur.");
	}

	public function describeGear():void {
		// story.display("gear");
		outputText("<b>You are currently " + (player.armorDescript() != "gear" ? "wearing your " + player.armorDescript() : "naked") + "" + ". Using [weapon] as a melee weapon");
		if (player.weaponRangeName != "nothing")
			outputText(", [weaponrangename] as range weapon");
		if (player.shieldName != "nothing")
			outputText(" and [shield] as your shield");
		outputText(".");
		if (player.headjewelryName != "nothing") {
			if (player.headjewelryPerk == "Helmet") outputText(" On your head is " + player.headjewelryName + ".");
			else outputText(" In your hair is " + player.headjewelryName + ".");
		}
		if (player.necklaceName != "nothing")
			outputText(" On your neck is a " + player.necklaceName + ".");
		if (player.hasKeyItem("Gleipnir Collar") >= 0) {
			if (player.necklaceName != "nothing") outputText(" Benath it is ");
			else outputText(" On your neck is ");
			outputText("Fenrir's spiked Collar, pieces of the spectral chain Gleipnir still dangling from it, floating weightlessly and tracing your movements.");
		}
		if (player.jewelryName != "nothing") {
			outputText(" At one of your right hand fingers is a " + player.jewelryName + "");
			if (player.jewelryName3 != "nothing") outputText(" and on another finger is a " + player.jewelryName3 + "");
			if (player.jewelryName2 != "nothing") outputText(", on one of your left hand fingers is a " + player.jewelryName2 + "");
			if (player.jewelryName4 != "nothing") outputText(" and on another finger is a " + player.jewelryName4 + "");
			outputText(".");
		}
		outputText("</b>");
	}
	public function describeRace():void {
		// story.display("race");
//Discuss race
		if (player.race() != player.startingRace) outputText("You began your journey as a " + player.startingRace + ", but gave that up as you explored the dangers of this realm. ");
		//Height and race.
		outputText("You are a ");
		outputText(Measurements.footInchOrMetres(player.tallness));
		var pcrace:String = player.race();
		if (pcrace != "half cow-morph" && pcrace != "half cow-girl" && pcrace != "cow-girl" && pcrace != "cow-girl" && pcrace != "cow-morph"
				&& pcrace != "minotaur" && pcrace != "half-minotaur"
				&& pcrace != "alraune" && pcrace != "liliraune"
				&& pcrace != "half unicorn" && pcrace != "unicorn" && pcrace != "unicornkin" && pcrace != "half alicorn" && pcrace != "alicorn" && pcrace != "alicornkin" && pcrace != "true alicorn"
				&& pcrace != "half bicorn" && pcrace != "bicorn" && pcrace != "bicornkin" && pcrace != "half nightmare" && pcrace != "nightmare" && pcrace != "nightmarekin" && pcrace != "true nightmare")
		{
			outputText(" tall [malefemaleherm] [race], with [bodytype].");
		}
		else{
			outputText(" tall [race], with [bodytype].");
		}
	}
	public function describeLowerBody():void {
		const lowerBodyOpts:Object = {
			id: player.lowerBody,
			legCount: num2Text(player.legCount),
			legCountMinusTwo: num2Text(player.legCount - 2),
			doubleHeight: Measurements.footInchOrMetres(player.tallness * 2),
			quadrupleHeight: Measurements.footInchOrMetres(player.tallness * 4),
			hydraHeads: num2Text(player.statusEffectv1(StatusEffects.HydraTailsPlayer)),
			gargoyleMaterial: getGargoyleMaterial()
		};

		//LOWERBODY DESCRIPTION
		outputText(LowerBody.getAppearanceDescription(lowerBodyOpts));
		if (player.isBiped()) {
			outputText(LowerBody.getAppearanceDescriptionBiped(lowerBodyOpts));
		} else if (player.isTaur()) {
			outputText(LowerBody.getAppearanceDescriptionTaur(lowerBodyOpts));
		} else if (player.isDrider()) {
			outputText(LowerBody.getAppearanceDescriptionDrider(lowerBodyOpts));
		}

		// Special cases
		if (player.lowerBody == LowerBody.FROSTWYRM && player.tallness > 120)
			outputText(" Your body is so large it's no wonder your passage underground can cause tremors.");

		//Hip info only displays if you aren't a centaur.
		if (player.isBiped() || player.isNaga()) {
			if (player.thickness > 70) {
				outputText(" You have " + hipDescript());
				if (player.hips.type < 6) {
					if (player.tone < 65)
						outputText(" buried under a noticeable muffin-top, and");
					else outputText(" that blend into your pillar-like waist, and");
				}
				if (player.hips.type >= 6 && player.hips.type < 10)
					outputText(" that blend into the rest of your thick form, and");
				if (player.hips.type >= 10 && player.hips.type < 15)
					outputText(" that would be much more noticeable if you weren't so wide-bodied, and");
				if (player.hips.type >= 15 && player.hips.type < 20)
					outputText(" that sway and emphasize your thick, curvy shape, and");
				if (player.hips.type >= 20)
					outputText(" that sway hypnotically on your extra-curvy frame, and");
			}
			else if (player.thickness < 30) {
				outputText(" You have " + hipDescript());
				if (player.hips.type < 6)
					outputText(" that match your trim, lithe body, and");
				if (player.hips.type >= 6 && player.hips.type < 10)
					outputText(" that sway to and fro, emphasized by your trim body, and");
				if (player.hips.type >= 10 && player.hips.type < 15)
					outputText(" that swell out under your trim waistline, and");
				if (player.hips.type >= 15 && player.hips.type < 20)
					outputText(", emphasized by your narrow waist, and");
				if (player.hips.type >= 20)
					outputText(" that swell disproportionately wide on your lithe frame, and");
			}
			//STANDARD
			else {
				outputText(" You have " + hipDescript());
				if (player.hips.type < 6)
					outputText(", and");
				if (player.femininity > 50) {
					if (player.hips.type >= 6 && player.hips.type < 10)
						outputText(" that draw the attention of those around you, and");
					if (player.hips.type >= 10 && player.hips.type < 15)
						outputText(" that make you walk with a sexy, swinging gait, and");
					if (player.hips.type >= 15 && player.hips.type < 20)
						outputText(" that make it look like you've birthed many children, and");
					if (player.hips.type >= 20)
						outputText(" that make you look more like an animal waiting to be bred than any kind of human, and");
				}
				else {
					if (player.hips.type >= 6 && player.hips.type < 10)
						outputText(" that give you a graceful stride, and");
					if (player.hips.type >= 10 && player.hips.type < 15)
						outputText(" that add a little feminine swing to your gait, and");
					if (player.hips.type >= 15 && player.hips.type < 20)
						outputText(" that force you to sway and wiggle as you move, and");
					if (player.hips.type >= 20) {
						outputText(" that give your ");
						if (player.balls > 0)
							outputText("balls plenty of room to breathe");
						else if (player.hasCock())
							outputText(player.multiCockDescript() + " plenty of room to swing");
						else if (player.hasVagina())
							outputText(vaginaDescript() + " a nice, wide berth");
						else outputText("vacant groin plenty of room");
						outputText(", and");
					}
				}
			}
		}
		//ASS
		//Horse version
		if (player.isTaur()) {
			//FATBUTT
			if (player.tone < 65) {
				outputText(" Your " + buttDescript());
				if (player.butt.type < 4)
					outputText(" is lean, from what you can see of it.");
				if (player.butt.type >= 4 && player.butt.type < 6)
					outputText(" looks fairly average.");
				if (player.butt.type >= 6 && player.butt.type < 10)
					outputText(" is fairly plump and healthy.");
				if (player.butt.type >= 10 && player.butt.type < 15)
					outputText(" jiggles a bit as you trot around.");
				if (player.butt.type >= 15 && player.butt.type < 20)
					outputText(" jiggles and wobbles as you trot about.");
				if (player.butt.type >= 20)
					outputText(" is obscenely large, bordering freakish, even for a horse.");
			}
			//GIRL LOOK AT DAT BOOTY
			else {
				outputText(" Your " + buttDescript());
				if (player.butt.type < 4)
					outputText(" is barely noticeably, showing off the muscles of your haunches.");
				if (player.butt.type >= 4 && player.butt.type < 6)
					outputText(" matches your toned equine frame quite well.");
				if (player.butt.type >= 6 && player.butt.type < 10)
					outputText(" gives hints of just how much muscle you could put into a kick.");
				if (player.butt.type >= 10 && player.butt.type < 15)
					outputText(" surges with muscle whenever you trot about.");
				if (player.butt.type >= 15 && player.butt.type < 20)
					outputText(" flexes its considerable mass as you move.");
				if (player.butt.type >= 20)
					outputText(" is stacked with layers of muscle, huge even for a horse.");
			}
		}
		//Non-horse PCs
		else if (player.isBiped() || player.isNaga()) {
			//TUBBY ASS
			if (player.tone < 60) {
				outputText(" your " + buttDescript());
				if (player.butt.type < 4)
					outputText(" looks great under your gear.");
				if (player.butt.type >= 4 && player.butt.type < 6)
					outputText(" has the barest amount of sexy jiggle.");
				if (player.butt.type >= 6 && player.butt.type < 10)
					outputText(" fills out your clothing nicely.");
				if (player.butt.type >= 10 && player.butt.type < 15)
					outputText(" wobbles enticingly with every step.");
				if (player.butt.type >= 15 && player.butt.type < 20)
					outputText(" wobbles like a bowl full of jello as you walk.");
				if (player.butt.type >= 20)
					outputText(" is obscenely large, bordering freakish, and makes it difficult to run.");
			}
			//FITBUTT
			else {
				outputText(" your " + buttDescript());
				if (player.butt.type < 4)
					outputText(" molds closely against your form.");
				if (player.butt.type >= 4 && player.butt.type < 6)
					outputText(" contracts with every motion, displaying the detailed curves of its lean musculature.");
				if (player.butt.type >= 6 && player.butt.type < 10)
					outputText(" fills out your clothing nicely.");
				if (player.butt.type >= 10 && player.butt.type < 15)
					outputText(" stretches your gear, flexing it with each step.");
				if (player.butt.type >= 15 && player.butt.type < 20)
					outputText(" threatens to bust out from under your kit each time you clench it.");
				if (player.butt.type >= 20)
					outputText(" is marvelously large, but completely stacked with muscle.");
			}
		}

		//TAILS
		describeTail();
	}

	public function describeTail():void {
		if (player.tailType == Tail.HORSE)
			outputText(" A long [skin coat.color] horsetail hangs from your " + buttDescript() + ", smooth and shiny.");
		if (player.tailType == Tail.FERRET)
			outputText(" A long ferret tail sprouts from above your [butt]. It is thin, tapered, and covered in shaggy [skin coat.color] fur.");
		if (player.tailType == Tail.DOG)
			outputText(" A fuzzy [skin coat.color] dogtail sprouts just above your " + buttDescript() + ", wagging to and fro whenever you are happy.");
		if (player.tailType == Tail.DEMONIC)
			outputText(" A narrow tail ending in a spaded tip curls down from your " + buttDescript() + ", wrapping around your [leg] sensually at every opportunity.");
		if (player.tailType == Tail.COW)
			outputText(" A long cowtail with a puffy tip swishes back and forth as if swatting at flies.");
		if (player.tailType == Tail.SPIDER_ADBOMEN) {
			outputText(" A large, spherical spider-abdomen has grown out from your backside, covered in shiny [skin coat.color] chitin. Though it's heavy and bobs with every motion, it doesn't seem to slow you down.");
			if (player.tailVenom > (player.maxVenom() * 0.5) && player.tailVenom < (player.maxVenom() * 0.8))
				outputText(" Your bulging arachnid posterior feels fairly full of webbing.");
			if (player.tailVenom >= (player.maxVenom() * 0.8) && player.tailVenom < player.maxVenom())
				outputText(" Your arachnid rear bulges and feels very full of webbing.");
			if (player.tailVenom == player.maxVenom())
				outputText(" Your swollen spider-butt is distended with the sheer amount of webbing it's holding.");
		}
		if (player.tailType == Tail.BEE_ABDOMEN) {
			outputText(" A large insectile bee-abdomen dangles from just above your backside, bobbing with its own weight as you shift. It is covered in hard chitin with black and yellow stripes, and tipped with a dagger-like stinger.");
			if (player.tailVenom > (player.maxVenom() * 0.5) && player.tailVenom < (player.maxVenom() * 0.8))
				outputText(" A single drop of poison hangs from your exposed stinger.");
			if (player.tailVenom >= (player.maxVenom() * 0.8) && player.tailVenom < player.maxVenom())
				outputText(" Poisonous bee venom coats your stinger completely.");
			if (player.tailVenom == player.maxVenom())
				outputText(" Venom drips from your poisoned stinger regularly.");
		}
		if (player.tailType == Tail.SCORPION) {
			outputText(" A large insectile scorpion-like tail dangles from just above your backside, bobbing with its own weight as you shift. It is covered in hard chitin and tipped with a stinger.");
			if (player.tailVenom > (player.maxVenom() * 0.5) && player.tailVenom < (player.maxVenom() * 0.8))
				outputText(" A single drop of poison hangs from your exposed stinger.");
			if (player.tailVenom >= (player.maxVenom() * 0.8) && player.tailVenom < player.maxVenom())
				outputText(" Poisonous bee venom coats your stinger completely.");
			if (player.tailVenom == player.maxVenom())
				outputText(" Venom drips from your poisoned stinger regularly.");
		}
		if (player.tailType == Tail.MANTICORE_PUSSYTAIL) {
			outputText(" Your tail is covered in armored chitin from the base to the tip, it ends in a flower-like bulb. You can open and close your tail tip at will and its pussy-like interior can be used to milk male organs. ");
			outputText("The deadly set of spikes covering the tip regularly drips with your potent venom. When impaling your tail spikes in a prey isn’t enough you can fling them at a target on a whim like the most talented archer.");
		}
		if (player.tailType == Tail.MANTIS_ABDOMEN)
			outputText(" A large insectile mantis-abdomen dangles from just above your backside, bobbing with its own weight as you shift. It is covered in hard [skin coat.color]ish chitinous material.");
		if (player.tailType == Tail.SHARK) {
			outputText(" A long shark-tail trails down from your backside, swaying to and fro while giving you a dangerous air.");
		}
		if (player.tailType == Tail.CAT) {
			if (player.tailCount <= 1) outputText(" A soft [skin coat.color] cat-tail sprouts just above your " + buttDescript() + ", curling and twisting with every step to maintain perfect balance.");
			else outputText(" Pair of soft [skin coat.color] cat-tails sprouts just above your " + buttDescript() + ", curling and twisting with every step to maintain perfect balance.");
		}
		if (player.tailType == Tail.NEKOMATA_FORKED_1_3) {
			outputText(" A soft [skin coat.color] forked on its one third length cat-tail sprouts just above your " + buttDescript() + ", curling and twisting with every step to maintain perfect balance.");
		}
		if (player.tailType == Tail.NEKOMATA_FORKED_2_3) {
			outputText(" A soft [skin coat.color] forked on its two thirds length cat-tail sprouts just above your " + buttDescript() + ", curling and twisting with every step to maintain perfect balance.");
		}
		if (player.tailType == Tail.LIZARD) {
			outputText(" A tapered tail hangs down from just above your " + assDescript() + ". It sways back and forth, assisting you with keeping your balance.");
		}
		if (player.tailType == Tail.SALAMANDER) {
			outputText(" A tapered, covered in red scales tail hangs down from just above your " + assDescript() + ". It sways back and forth, assisting you with keeping your balance. When you are in battle or when you want could set ablaze whole tail in red-hot fire.");
		}
		if (player.tailType == Tail.CAVE_WYRM) {
			outputText(" A large newt tail trails down from your " + buttDescript() + ", tapering on the ground behind you. While it is heavy and plump, it can allow you to swim underwater like any fish if necessary, just like a newt.");
		}
		if (player.tailType == Tail.RABBIT)
			outputText(" A short, soft bunny tail sprouts just above your " + assDescript() + ", twitching constantly whenever you don't think about it.");
		else if (player.tailType == Tail.HARPY)
			outputText(" A tail of feathers fans out from just above your " + assDescript() + ", twitching instinctively to help guide you if you were to take flight.");
		else if (player.tailType == Tail.KANGAROO) {
			outputText(" A conical, ");
			if (player.hasFur()) outputText("furry, " + player.coatColor);
			else outputText("gooey, " + player.skinTone);
			outputText(", tail extends from your " + assDescript() + ", bouncing up and down as you move and helping to counterbalance you.");
		}
		else if (player.tailType == Tail.FOX) {
			if (player.tailCount <= 1)
				outputText(" A swishing [skin coat.color] fox's brush extends from your " + assDescript() + ", curling around your body - the soft fur feels lovely.");
			else outputText(" " + Num2Text(player.tailCount) + " swishing [skin coat.color] fox's tails extend from your " + assDescript() + ", curling around your body - the soft fur feels lovely.");
		}
		else if (player.tailType == Tail.DRACONIC) {
			outputText(" A thin, scaly, prehensile reptilian tail, almost as long as you are tall, swings behind you like a living bullwhip. Its tip menaces with spikes of bone, meant to deliver painful blows.");
		}
		//appearance
		else if (player.tailType == Tail.RACCOON) {
			outputText(" A black-and-[skin coat.color]-ringed raccoon tail waves behind you.");
		}
		else if (player.tailType == Tail.MOUSE) {
			//appearance
			outputText(" A naked, " + player.skinTone + " mouse tail pokes from your butt, dragging on the ground and twitching occasionally.");
		}
		//<mod>
		else if (player.tailType == Tail.BEHEMOTH) {
			outputText(" A long seemingly-tapering tail pokes from your butt, ending in spikes just like behemoth's.");
		}
		else if (player.tailType == Tail.PIG) {
			outputText(" A short, curly pig tail sprouts from just above your butt.");
		}
		else if (player.tailType == Tail.GOAT) {
			outputText(" A very short, stubby goat tail sprouts from just above your butt.");
		}
		else if (player.tailType == Tail.RHINO) {
			outputText(" A ropey rhino tail sprouts from just above your butt, swishing from time to time.");
		}
		else if (player.tailType == Tail.ECHIDNA) {
			outputText(" A stumpy echidna tail forms just about your [ass].");
		}
		else if (player.tailType == Tail.DEER) {
			outputText(" A very short, stubby deer tail sprouts from just above your butt.");
		}
		else if (player.tailType == Tail.WOLF) {
			outputText(" A bushy [skin coat.color] wolf tail sprouts just above your " + assDescript() + ", wagging to and fro whenever you are happy.");
		}
		else if (player.tailType == Tail.GARGOYLE) {
			outputText(" A long spiked tail hangs down from just above your " + assDescript() + ". It sways back and forth assisting in keeping your balance.");
		}
		else if (player.tailType == Tail.GARGOYLE_2) {
			outputText(" A long tail ending with an axe blade on both sides hangs down from just above your " + assDescript() + ". It sways back and forth assisting in keeping your balance.");
		}
		else if (player.tailType == Tail.ORCA) {
			outputText(" A long, powerful Orca tail trails down from your backside, swaying to and fro, always ready to propulse you through the water or smack an opponent on the head. It has a huge fin at the end and a smaller one not so far from your ass.");
		}
		else if (player.tailType == Tail.YGGDRASIL) {
			outputText(" A thin prehensile reptilian tail swings behind, covered by [skin coat]. Adorning the tip of your tail is a leaf, bobbing with each of your tail’s movements.");
		}
		else if (player.tailType == Tail.RAIJU) {
			outputText(" Your silky tail extends out from just above your " + assDescript() + ". Its fur is lovely to the touch and almost glows at the tip, letting others know of your lightning based motif.");
		}
		else if (player.tailType == Tail.WEASEL) {
			outputText(" Your short silky tail extends out from just above your " + assDescript() + ". Its fur is lovely to the touch.");
		}
		else if (player.tailType == Tail.RED_PANDA) {
			outputText(" Sprouting from your [ass], you have a long, bushy tail. It has a beautiful pattern of rings in [skin coat.color] fluffy fur. It waves playfully as you walk giving to your step a mesmerizing touch.");
		}
		else if(player.tailType == Tail.LION) {
			outputText(" A soft [skin coat.color] cat-tail sprouts just above your " + assDescript() + ", curling and twisting with every step to maintain perfect balance. It ends with a small puffy hair balls like that of a lion.");
		}
		else if (player.tailType == Tail.AVIAN) {
			outputText(" A tail shaped like a fan of long, [skin coat.color] feathers rests above your " + assDescript() + ", twitching instinctively to help guide you if you were to take flight.");
		}
		else if (player.tailType == Tail.GRIFFIN) {
			outputText(" From your backside hangs a long tail, leonine in shape and covered mostly by a layer of [skin coat.color2] fur with a tip made of a tuft of [skin coat.color] colored feathers. It moves sinuously as you walk.");
		}
		else if(player.tailType == Tail.BURNING) {
			outputText(" A blazing cat tail pokes out from your " + assDescript() + ". It has a tendency to light things on fire if you are not careful but at least it assists with your balance.");
		}
		else if(player.tailType == Tail.TWINKASHA) {
			outputText(" A pair blazing cat tail pokes out from your " + assDescript() + ". They have a tendency to light things on fire if you are not careful but at least they assists with your balance. From these tails you draw in tremendous fell power.");
		}
		else if(player.tailType == Tail.HINEZUMI) {
			outputText(" A blazing, " + player.skinTone + " mouse tail pokes out from your " + assDescript() + ". It has a tendency to light things on fire if you are not careful.");
		}
		else if(player.tailType == Tail.THUNDERBIRD) {
			outputText(" From just above your " + assDescript() + " extend a long thin sinuous tail tipped with feathers which are shaped like a lightning bolt.");
		}
		else if(player.tailType == Tail.BEAR) {
			outputText(" A cute, furry ursan tail sits up from your backside.");
		}
		else if(player.lowerBody == LowerBody.CANCER) {
			outputText(" On the front of your crab half, covering your privates, is a set of chitinous mandibula covered in feelers, constantly chittering and foaming with your drooling fluids.");
		}
		else if(player.tailType == Tail.USHI_ONI_ONNA) {
			outputText(" You have an Ushi-"+player.mf("oni","onna")+" tail, the furred member is "+(player.tallness > 72 ? "5":"4")+" feet long and prehensile, the tip can shoot web string that are very thick and strong, and produce an arousing substance when in contact with the victim.");
		}
		else if(player.tailType == Tail.SQUIRREL) {
			outputText(" At your back is a big long striped furry tail that curves up like that of a squirrel.");
		}
		else if(player.tailType == Tail.WENDIGO) {
			outputText(" Your silky tail extends out from just above your ass. Its fur is lovely to the touch and warm. It protects you well against the cold.");
		}
	}

	public function describeArms():void {
		const armsOpts:Object = {
			id: player.arms.type,
			skinTone: player.skinTone,
			gargoyleMaterial: getGargoyleMaterial()
		};

		outputText(Arms.getAppearanceDescription(armsOpts));
	}

	public function describeRearBody():void {
		if (player.rearBody.type == RearBody.FENRIR_ICE_SPIKES) {
			outputText(" Jagged ice shards grows out of your back, providing excellent defence and chilling the air around you.");
		}
		else if (player.rearBody.type == RearBody.LION_MANE) {
			outputText(" Around your neck there is a thick mane of [skin coat.color] fur. It looks great on you.");
		}
		else if (player.rearBody.type == RearBody.SHARK_FIN) {
			outputText(" A large shark-like fin has sprouted between your shoulder blades. With it you have far more control over swimming underwater.");
		}
		else if (player.rearBody.type == RearBody.ORCA_BLOWHOLE) {
			outputText(" Between your shoulder blades is a blowhole that allows to breath in air from your back while swimming, just like an orca.");
		}
		else if (player.rearBody.type == RearBody.RAIJU_MANE) {
			outputText(" A thick collar of fur grows around your neck. Multiple strands of fur are colored in a dark shade, making it look like a lightning bolt runs along the center of your fur collar.");
		}
		else if (player.rearBody.type == RearBody.BAT_COLLAR) {
			outputText(" Around your neck is a thick collar of fur reminiscent of a bat's.");
		}
		else if (player.rearBody.type == RearBody.WOLF_COLLAR) {
			outputText(" Around your neck, there is a thick coat of [skin coat.color] fur. It looks great on you. That said, you can dismiss every one of your bestial features at any time should the need arise for you to appear human.");
		}
		else if (player.rearBody.type == RearBody.DISPLACER_TENTACLES) {
			outputText(" On your back grows two tentacles with a pair of thick, heavy feelers. You use them to suck your victims dry of their milk loads as you pump them full of your lewd venom.");
		}
		else if (player.rearBody.type == RearBody.SNAIL_SHELL) {
			outputText(" On your back is a large spiralling shell which"+(player.hasPerk(PerkLib.FireAffinity)?" erupts regularly with magma and":"")+" protects your vital organs.");
		}
		else if (player.rearBody.type == RearBody.METAMORPHIC_GOO) {
			outputText(" Since your body is made of malleable goo you can reshape your form however you want to gain tentacle or any limb or appendage whenever you need one either for combat or for fun.");
		}
		else if (player.rearBody.type == RearBody.GHOSTLY_AURA) {
			outputText(" An eerie ghostly aura surrounds you. Your ominous presence is enough to disturb even the bravest of souls.");
		}
		else if (player.rearBody.type == RearBody.YETI_FUR) {
			outputText(" Covered with a natural "+(player.biggestTitSize() > 1 ? "fur bikini":"layer of fur")+", your "+(player.biggestTitSize() > 1 ? "chest and ":"")+"crotch is protected against the cold.");
		}
		else if (player.rearBody.type == RearBody.GLACIAL_AURA) {
			outputText(" The air temperature around you naturally drops to water freezing levels, causing snow flurries to appear around you every now and then as moisture enters your personal space.");
		}
		else if (player.rearBody.type == RearBody.CENTIPEDE) {
			outputText(" Around your neck sits a set of pincer like maxillipeds. You can use them to sting and hold onto your prey.");
		}
		else if (player.rearBody.type == RearBody.KRAKEN) {
			outputText(" Small glowing dots draw a trail all over the length of your body. They shine beautifully in both the deepest waters and the night giving you a somewhat ominous presence.");
		}
		else if (player.rearBody.type == RearBody.FROSTWYRM) {
			outputText(" Around your neck there is a thick collar of snowy white fur. It looks great on you and, best of all, shields you against the cold.");
		}
		else if (player.rearBody.type == RearBody.FUR_COAT) {
			outputText(" On your back you wear a thick fur coat, not unlike a mantle complete with a hood always worn over your head it has a pair of holes just to let a pair of horns or rather antlers juts through it.");
		}
		else if (player.rearBody.type == RearBody.TENTACLE_EYESTALKS) {
			outputText(" A set of "+player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer)+" tentacle eyestalks expand from your back giving you all around vision. Their gazes are charged with lethal magical powers.");
		}
		else if (player.rearBody.type == RearBody.ATLACH_NACHA) {
			outputText(" Two pairs of chitinous, black spider legs sprout from your shoulders and back. Red eyes blink and close at the tips.")
		}
	}
	public function describeWings():void {
	//WINGS!
		var wingType:Number = player.wings.type;
		if (wingType == Wings.BEE_LIKE_SMALL)
			outputText(" A pair of tiny-yet-beautiful bee-wings sprout from your back, too small to allow you to fly.");
		if (wingType == Wings.BEE_LIKE_LARGE)
			outputText(" A pair of large bee-wings sprout from your back, reflecting the light through their clear membranes beautifully. They flap quickly, allowing you to easily hover in place or fly.");
		if (wingType == Wings.MANTIS_LIKE_SMALL)
			outputText(" A pair of tiny mantis-wings sprout from your back, too small to allow you to fly.");
		if (wingType == Wings.MANTIS_LIKE_LARGE)
			outputText(" A pair of large mantis-wings sprout from your back, reflecting the light through their clear membranes beautifully. They flap quickly, allowing you to easily hover in place or fly.");
		if (wingType == Wings.BAT_LIKE_TINY)
			outputText(" A pair of tiny bat-like demon-wings sprout from your back, flapping cutely, but otherwise being of little use.");
		if (wingType == Wings.BAT_LIKE_LARGE)
			outputText(" A pair of large bat-like demon-wings fold behind your shoulders. With a muscle-twitch, you can extend them, and use them to soar gracefully through the air.");
		if (wingType == Wings.BAT_LIKE_LARGE_2)
			outputText(" Two pairs of large bat-like demon-wings fold behind your shoulders. With a muscle-twitch, you can extend them, and use them to soar gracefully through the air.");
		if (wingType == Wings.MANTICORE_LIKE_SMALL)
			outputText(" A pair of small leathery wings covered with [skin coat.color] fur rest on your back. Despite being too small to allow flight they at least look cute on you.");
		if (wingType == Wings.MANTICORE_LIKE_LARGE)
			outputText(" A pair of large ominous leathery wings covered with [skin coat.color] fur expand from your back. You can open them wide to soar high in search of your next prey.");
		if (wingType == Wings.FEATHERED_LARGE)
			outputText(" A pair of large, feathery wings sprout from your back. Though you usually keep the [haircolor]-colored wings folded close, they can unfurl to allow you to soar as gracefully as a harpy.");
		if (wingType == Wings.FEATHERED_ALICORN)
			outputText(" A pair of large, feathery wings sprout from your back. Though you usually keep the [haircolor]-colored wings folded close, they can unfurl to allow you to soar as gracefully as an alicorn.");
		if (wingType == Wings.FEATHERED_SPHINX)
			outputText(" A pair of large, feathery wings sprout from your back. Though you usually keep the [haircolor]-colored wings folded close, they can unfurl to allow you to soar as gracefully as a sphinx.");
		if (wingType == Wings.FEATHERED_PHOENIX)
			outputText(" A pair of large, feathery wings sprout from your back. Though you usually keep the crimson-colored wings folded close, they can unfurl to allow you to soar as gracefully as a phoenix.");
		if (wingType == Wings.DRACONIC_SMALL)
			outputText(" Small, vestigial wings sprout from your shoulders. They might look like bat's wings, but the membranes are covered in fine, delicate scales.");
		else if (wingType == Wings.DRACONIC_LARGE)
			outputText(" Large wings sprout from your shoulders. When unfurled they stretch further than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone.");
		else if (wingType == Wings.DRACONIC_HUGE)
			outputText(" Magnificent huge wings sprout from your shoulders. When unfurled they stretch over twice further than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone.");
		if (wingType == Wings.GIANT_DRAGONFLY)
			outputText(" Giant dragonfly wings hang from your shoulders. At a whim, you could twist them into a whirring rhythm fast enough to lift you off the ground and allow you to fly.");
		if (wingType == Wings.GARGOYLE_LIKE_LARGE) {
			outputText(" Large ");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) outputText("marble");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) outputText("alabaster");
			outputText(" wings sprout from your shoulders. When unfurled they stretch wider than your arm span and a single beat of them is all you need to set out toward the sky. They look a bit like ");
			if (flags[kFLAGS.GARGOYLE_WINGS_TYPE] == 1) outputText("bird");
			if (flags[kFLAGS.GARGOYLE_WINGS_TYPE] == 2) outputText("bat");
			outputText(" wings and, although they were made of stone, they allow you to fly around with excellent aerial agility.");
		}
		if (wingType == Wings.PLANT) {
			outputText(" Three pairs of oily, prehensile phalluses sprout from your shoulders and back. From afar, they may look like innocent vines, but up close, each tentacle contain a bulbous head with a leaking cum-slit, perfect for mass breeding.");
		}
		if (wingType == Wings.VAMPIRE){
			outputText(" Between your shoulder blades rest a pair of large, ominous black wings reminiscent of a bat’s. They can unfurl up to twice your arm’s length, allowing you to gracefully dance in the night sky.");
		}
		if (wingType == Wings.FEY_DRAGON_WINGS){
			outputText(" Magnificent huge wings sprout from your shoulders. When unfurled they stretch over twice further than your arm span, and a single beat of them is all you need to set out toward the sky. They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone. While draconic in appearance the delicate frame of your fey like dragon wings allows for even better speed and maneuverability.");
		}
		if (wingType == Wings.FEATHERED_AVIAN){
			outputText(" A pair of large, feathery wings sprout from your back. Though you usually keep the [skin coat.color] wings folded close, they can unfurl to allow you to soar as gracefully as a bird.");
		}
		if (wingType == Wings.NIGHTMARE){
			outputText(" A pair of large ominous black leathery wings expand from your back. You can open them wide to soar high in the sky.");
		}
		if (wingType == Wings.ETHEREAL_WINGS){
			outputText(" Three pairs of otherworldly tendrils grow out of your back. They have an ethereal glow around them and they gently sway against an invisible wind.");
		}
		if (wingType == Wings.THUNDEROUS_AURA){
			outputText(" You generate so much electricity that the sound of static and voltage follows you around, announcing your arrival.");
		}
		if (wingType == Wings.WINDY_AURA){
			outputText(" An aura of strong wind constantly seems to accompany you wherever you go. You can use it to create tornados and even take flight riding on a dust devil should you need to.");
		}
		if (wingType == Wings.LEVITATION){
			outputText(" You have the ability to levitate in the air should you wish to although you prefer to stay at ground level to not alert your would be victims to your otherworldly nature.");
		}
		if (wingType == Wings.FAIRY){
			outputText(" A large pair of colorful butterfly wings rest on your shoulder blades. Your fairy wings give you a regal appearance fit for fey royalty.");
		}
		if (wingType == Wings.SEADRAGON){
			outputText(" Two large majestic webbed wings not unlike the aquatic flippers of a deep-sea creature unfurls from your back, the interior lined with bright color patterns and bioluminescent specks that change depending on your mood. These wings are as good to fly as they are to swim.");
		}
	}
	public function describeHorns():void {
//Horns
		//Demonic horns
		if (player.horns.type == Horns.DEMON) {
			if (player.horns.count == 2)
				outputText(" A small pair of pointed horns has broken through the [skin.type] on your forehead, proclaiming some demonic taint to any who see them.");
			if (player.horns.count == 4)
				outputText(" A quartet of prominent horns has broken through your [skin.type]. The back pair are longer, and curve back along your head. The front pair protrude forward demonically.");
			if (player.horns.count == 6)
				outputText(" Six horns have sprouted through your [skin.type], the back two pairs curve backwards over your head and down towards your neck, while the front two horns stand almost eight inches long upwards and a little forward.");
			if (player.horns.count >= 8)
				outputText(" A large number of thick demonic horns sprout through your [skin.type], each pair sprouting behind the ones before. The front jut forwards nearly ten inches while the rest curve back over your head, some of the points ending just below your ears. You estimate you have a total of " + num2Text(player.horns.count) + " horns.");
		}
		//Minotaur horns
		if (player.horns.type == Horns.COW_MINOTAUR) {
			if (player.horns.count < 3)
				outputText(" Two tiny horns-like nubs protrude from your forehead, resembling the horns of the young livestock kept by your village.");
			if (player.horns.count >= 3 && player.horns.count < 6)
				outputText(" Two moderately sized horns grow from your forehead, similar in size to those on a young bovine.");
			if (player.horns.count >= 6 && player.horns.count < 12)
				outputText(" Two large horns sprout from your forehead, curving forwards like those of a bull.");
			if (player.horns.count >= 12 && player.horns.count < 20)
				outputText(" Two very large and dangerous looking horns sprout from your head, curving forward and over a foot long. They have dangerous looking points.");
			if (player.horns.count >= 20)
				outputText(" Two huge horns erupt from your forehead, curving outward at first, then forwards. The weight of them is heavy, and they end in dangerous looking points.");
		}
		//Lizard horns
		if (player.horns.type == Horns.DRACONIC_X2) {
			outputText(" A pair of " + Measurements.inchesOrCentimetres(int(player.horns.count)) + " horns grow from the sides of your head, sweeping backwards and adding to your imposing visage.");
		}
		//Super lizard horns
		if (player.horns.type == Horns.DRACONIC_X4_12_INCH_LONG)
			outputText(" Two pairs of horns, roughly a foot long, sprout from the sides of your head. They sweep back and give you a fearsome look, almost like the dragons from your village's legends.");
		//Frost wyrm Horns
		if (player.horns.type == Horns.FROSTWYRM){
			outputText(" Two large sized spiraling horns grow from the side of your head, similar to those of a ram or frost wyrm. They kind of look great");
			if (player.lowerBody == LowerBody.FROSTWYRM) outputText(" especially with your fur which makes you look like a sheep serpantine dragon");
			outputText(".");
		}
		//Antlers!
		if (player.horns.type == Horns.ANTLERS) {
			if (player.horns.count > 0)
				outputText(" Two antlers, forking into " + num2Text(player.horns.count) + " points, have sprouted from the top of your head, forming a spiky, regal crown of bone.");
		}
		if (player.horns.type == Horns.GOAT) {
			if (player.horns.count == 1)
				outputText(" A pair of stubby goat horns sprout from the sides of your head.");
			else
				outputText(" A pair of tall-standing goat horns sprout from the sides of your head. They are curved and patterned with ridges.");
		}
		if (player.horns.type == Horns.GOATQUAD) {
			if (player.horns.count == 1)
				outputText(" Four tall-standing goat horns sprout from the sides of your head denouncing your fiendish nature. They are curved and patterned with ridges.\n");
		}
		if (player.horns.type == Horns.RHINO) {
			if (player.horns.count >= 2) {
				if (player.faceType == Face.RHINO)
					outputText(" A second horns sprouts from your forehead just above the horns on your nose.");
				else
					outputText(" A single horns sprouts from your forehead. It is conical and resembles a rhino's horns.");
				outputText(" You estimate it to be about seven inches long.");
			}
			else {
				outputText(" A single horns sprouts from your forehead. It is conical and resembles a rhino's horns. You estimate it to be about six inches long.");
			}

		}
		if (player.horns.type == Horns.UNICORN) {
			if (player.horns.count < 3)
				outputText(" Tiny horns-like nub protrude from your forehead, resembling the horns of the young unicorn.");
			if (player.horns.count >= 3 && player.horns.count < 6)
				outputText(" One moderately sized horns grow from your forehead, similar in size to those on a young unicorn.");
			if (player.horns.count >= 6 && player.horns.count < 12)
				outputText(" One large horns sprout from your forehead, spiraling and pointing forwards like those of an unicorn.");
			if (player.horns.count >= 12 && player.horns.count < 20)
				outputText(" One very large and dangerous looking spiraling horns sprout from your forehead, pointing forward and over a foot long. It have dangerous looking tip.");
			if (player.horns.count >= 20)
				outputText(" One huge and long spiraling horns erupt from your forehead, pointing forward. The weight of it is heavy and ends with dangerous and sharp looking tip.");
		}
		if (player.horns.type == Horns.BICORN) {
			if (player.horns.count < 3)
				outputText(" A pair of tiny horns-like nub protrude from your forehead, resembling the horns of the young bicorns.");
			if (player.horns.count >= 3 && player.horns.count < 6)
				outputText(" Two moderately sized horns grow from your forehead, similar in size to those on a young bicorn.");
			if (player.horns.count >= 6 && player.horns.count < 12)
				outputText(" Two large horns sprout from your forehead, spiraling and pointing forwards like those of a bicorn.");
			if (player.horns.count >= 12 && player.horns.count < 20)
				outputText(" Two very large and dangerous looking spiraling horns sprout from your forehead, pointing forward and over a foot long. They have dangerous looking tip.");
			if (player.horns.count >= 20)
				outputText(" Two huge and long spiraling horns erupt from your forehead, pointing forward. The weight of them is heavy and ends with dangerous and sharp looking tips.");
		}
		if (player.horns.type == Horns.OAK) {
			if (player.horns.count > 0)
				outputText(" Two branches, forking into " + num2Text(player.horns.count) + " points, have sprouted from the top of your head, forming a spiky, regal crown made of oak wood.");
		}
		if (player.horns.type == Horns.GARGOYLE) {
			if (player.horns.count > 0)
				outputText(" A large pair of thick demonic looking horns sprout through the side of your head giving you a fiendish appearance.");
		}
		if (player.horns.type == Horns.ORCHID) {
			if (player.horns.count > 0)
				outputText(" A huge pair of "+player.NakedCoatColor+" orchids grows on each side of your head, their big long petals flopping gaily when you move.");
		}
		if (player.horns.type == Horns.ONI_X2) {
			if (player.horns.count > 0)
				outputText(" You have a pair of horns on your head warning anyone who looks that you are an oni and do mean serious business.");
		}
		if (player.horns.type == Horns.ONI) {
			if (player.horns.count > 0)
				outputText(" You have a single horns on your head warning anyone who looks that you are an oni and do mean serious business.");
		}
		if (player.horns.type == Horns.GHOSTLY_WISPS) {
			if (player.horns.count > 0)
				outputText(" Floating above your head is several wispy balls of light. They hold an unsettling ethereal presence around them, though in reality they’re merely an extension of yourself.");
		}
		if (player.horns.type == Horns.SPELL_TAG) {
			if (player.horns.count > 0)
				outputText(" On your forehead is a cursed spell tag, the source of your current predicament and supernatural powers.");
		}
		if (player.horns.type == Horns.KRAKEN) {
			if (player.horns.count > 0)
				outputText(" Crowning above your head is a fleshy Kraken hood easily adding you a few extra inch in height.\n");
		}
		if (player.horns.type == Horns.USHI_ONI_ONNA) {
			if (player.horns.count > 0)
				outputText(" You have a pair of ushi-" + player.mf("oni", "onna") + " horns, both come out of your skull and go upward in a spiral pattern.\n");
		}
		if (player.horns.type == Horns.SEADRAGON) {
			if (player.horns.count > 0)
				outputText(" Two large-sized horns grow from the side of your head. The faint bioluminescent specks that line the length of each horn enhance with a mesmerizing glow. At the tip of each horn is a bright red glow, both as a gentle warning and an enthralling lure to unwary prey.\n");
		}
	}
	public function describeTongue():void {
//Tongue
		if (player.tongue.type == Tongue.SNAKE)
			outputText(" A snake-like tongue occasionally flits between your lips, tasting the air.");
		else if (player.tongue.type == Tongue.DEMONIC)
			outputText(" A slowly undulating tongue occasionally slips from between your lips. It hangs nearly two feet long when you let the whole thing slide out, though you can retract it to appear normal.");
		else if (player.tongue.type == Tongue.DRACONIC)
			outputText(" Your mouth contains a thick, fleshy tongue that, if you so desire, can telescope to a distance of about four feet. It has sufficient manual dexterity that you can use it almost like a third arm.");
		else if (player.tongue.type == Tongue.ECHIDNA)
			outputText(" A thin echidna tongue, at least a foot long, occasionally flits out from between your lips.");
		else if (player.tongue.type == Tongue.CAT)
			outputText(" Your tongue is rough like that of a cat. You sometimes groom yourself with it.");
		else if (player.tongue.type == Tongue.ELF)
			outputText(" One could mistake you for a human but your voice is unnaturally beautiful and melodious giving you away as something else.");
		else if (player.tongue.type == Tongue.MELKIE)
			outputText(" One could mistake you for a human but your voice is unnaturally beautiful and melodious giving you away as something else. Your mermaid-like song is capable of captivating the minds of those who listens to it.");
		else if (player.tongue.type == Tongue.DOG)
			outputText(" You sometime let your panting canine tongue out to vent heat.");
		else if (player.tongue.type == Tongue.CAVE_WYRM)
			outputText(" A slowly undulating neon blue tongue that glow in the dark occasionally slips from between your lips. It hangs nearly two feet long when you let the whole thing slide out, though you can retract it to appear normal.");
		else if (player.tongue.type == Tongue.GHOST)
			outputText(" Occasionally a long transparent tongue slicks out of your mouth, stretching out about a foot in length.");
		else if (player.tongue.type == Tongue.RATATOSKR)
			outputText(" Your tongue is human in appearance but way more dexterous at handling words, able to form sentences and words so good it becomes art or so bad that it bleeds the ears and drives who hear them insane.");
		else if (player.tongue.type == Tongue.RAVENOUS_TONGUE)
			outputText(" You constantly hunger for food and your ravenous tongue has gained some unnatural skills of its own, always ready to coax a penis or a pussy into cumming.");
	}
	public function describeBeard():void {
//Beards!
		if (player.beardLength > 0) {
			outputText(" You have a " + beardDescript() + " ");
			if (player.beardStyle != Beard.GOATEE) {
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
		var eyeType:Number = player.eyes.type;
		if(eyeType == Eyes.FOUR_SPIDER_EYES)
			outputText(" In addition to your primary two [eyecolor] eyes, you have a second, smaller pair on your forehead.");
		else if(eyeType == Eyes.BLACK_EYES_SAND_TRAP)
			outputText(" Your eyes are solid spheres of inky, alien darkness.");
		else if(eyeType == Eyes.CAT_SLITS)
			outputText(" Your [eyecolor] eyes have vertically slit like those of cat.");
		else if(eyeType == Eyes.CANCER)
			outputText(" Your eyes look human at first glance, save for their natural [eyecolor] irises covered by a completely transparent layer of protective tissue to protect them against things such as salt and sand in the water.");
		else if(eyeType == Eyes.GORGON)
			outputText(" Your [eyecolor] eyes are similar to those of snake-like gorgons with ability to temporally petrify.");
		else if(eyeType == Eyes.FENRIR)
			outputText(" Your [eyecolor] eyes glow with a freezing blue light, and wisps of icy mist drift from them.");
		else if(eyeType == Eyes.MANTICORE)
			outputText(" Your eyes are similar to those of a cat, with slit pupils. However, their [eyecolor] iris dismiss any links to the regular felines in favor of something way more ominous.");
		else if(eyeType == Eyes.FOX)
			outputText(" Your [eyecolor] eyes looks like those of a fox with a slit in the middle.");
		else if(eyeType == Eyes.FIENDISH)
			outputText(" Your [eyecolor] eyes looks like those of a fiend with a slit in the middle.");
		else if(eyeType == Eyes.REPTILIAN)
			outputText(" Your eyes looks like those of a reptile with [eyecolor] irises and a slit.");
		else if(eyeType == Eyes.SNAKE)
			outputText(" Your [eyecolor] eyes have slitted pupils like that of a snake.");
		else if(eyeType == Eyes.DRAGON)
			outputText(" Your [eyecolor] eyes have slitted pupils like that of a dragon.");
		else if(player.eyes.type == Eyes.DEVIL)
			outputText(" Your eyes look fiendish, with their black sclera and glowing [eyecolor] iris.");
		else if(eyeType == Eyes.ONI)
			outputText(" Your eyes look normal enough save for their fiendish [eyecolor] iris and slitted pupils.");
		else if(eyeType == Eyes.ELF)
			outputText(" Your [eyecolor] elven eyes looks somewhat human, save for their cat-like vertical slit which draws light right in, allowing you to see with perfect precision both at day and night time.");
			if (player.hasPerk(PerkLib.BlessingOfTheAncestorTree)) outputText(" Despite their otherwordly beauty the misty hollow at the center of your eyes denounce the absence of a soul that wich now resides with the forest.")
		else if(eyeType == Eyes.RAIJU)
			outputText(" Your eyes are of an electric [eyecolor] hue that constantly glows with voltage power. They have slitted pupils like those of a beast.");
		else if(eyeType == Eyes.RATATOSKR)
			outputText(" Your [eyecolor] eyes have slitted pupils like those of a Ratatoskr. Your know it all smug expression plastered in them at all time upsets quite a few.");
		else if(eyeType == Eyes.WEASEL)
			outputText(" Your [eyecolor] eyes have slitted pupils like those of a weasel.");
		else if(eyeType == Eyes.VAMPIRE){
			outputText(" Your eyes looks somewhat normal, but their [eyecolor] irises seem to have the tendency of drawing in people’s gaze, like moths to a flame.");
		}
		else if(eyeType == Eyes.GEMSTONES){
			outputText(" Instead of regular eyes you see through a pair of gemstones that change hue based on your mood.");
		}
		else if(eyeType == Eyes.MONOEYE){
			outputText(" Your eye sockets have merged together to reform into a single cyclopean eye charged with powerful magical powers. Your almighty gaze is as peerless as its unsettling.");
		}
		else if(eyeType == Eyes.FERAL){
			outputText(" In your [eyecolor] eyes, sometimes a green light is visibly dancing. Hinting at the beast within. It encompasses your entire pupil when you let it loose.");
		}
		else if(eyeType == Eyes.GRYPHON){
			outputText(" Your gifted eyes have a bird-like appearance, having an [eyecolor] sclera and a large, black iris. A thin ring of black separates your sclera from your outer iris.");
		}
		else if(eyeType == Eyes.GOAT){
			outputText(" Your eyes are like those of a goat with horizontal slit pupils at the center of their [eyecolor] iris.");
		}
		else if(eyeType == Eyes.INFERNAL){
			outputText(" Your eyes look fiendish, with their black sclera and glowing [eyecolor] iris. What's more, a small trail of fire blazes on the corners making them all the more intimidating.");
		}
		else if(eyeType == Eyes.KRAKEN){
			outputText(" Your eyes are like those of a octopus with horizontal slit pupils at the center of their [eyecolor] iris.\"");
		}
		else if(eyeType == Eyes.ORC){
			outputText(" Your [eyecolor], slanted eyes have slitted pupils. They usually seem to gleam with a sort of malice, avarice, or lechery, giving off beady-eyed vibe.");
		}
		else if(eyeType == Eyes.CAVE_WYRM){
			outputText(" Dark blue iris with [eyecolor] eyes pupil that glow in the dark.");
		}
		else if(eyeType == Eyes.HINEZUMI){
			outputText(" Your eyes are human-like. However, their [eyecolor] irises are clearly those of an Hinezumi.");
		}
		else if(eyeType == Eyes.BEAR){
			outputText(" Your eyes are human save for your [eyecolor] pupils closer to those of a bear.");
		}
		else if(eyeType == Eyes.DISPLACER){
			outputText(" Your eyes are similar to those of a cat, with slit pupils. However, their black sclera dismiss any links to the regular felines clearly identifying you to something else.");
		}
		else if(eyeType == Eyes.FIRE_SNAIL){
			outputText(" Your eyes are normal save for your [eyecolor] iris which glows like smoldering embers.");
		}
		else if(eyeType == Eyes.GHOST){
			outputText(" Your eyes glow [eyecolor] with a ghostly aura. You can see clearly in the shadows and might terrify anyone wandering around alone at night.");
		}
		else if(eyeType == Eyes.JIANGSHI){
			outputText(" Your [eyecolor] eyes, while humans are vacant and devoid of the warmth of life.");
		}
		else if(eyeType == Eyes.FROSTWYRM){
			outputText(" Your [eyecolor] eyes have slitted pupils and dark sclera like those of a frost wyrm.");
		}
		else if(eyeType == Eyes.FAIRY){
			outputText(" Your beautiful [eyecolor] eyes sparkle with the eternal hope and child-like innocence of fairykind.");
		}
		else if(eyeType == Eyes.GREMLIN){
			outputText(" Your [eyecolor] eyes looks human enough though your eyelids are dark, just as if you very tired althought it's more likely traces of your demonic corruption.");
		}
		else if(eyeType == Eyes.DEAD_EYES){
			outputText(" Your eyes look dead, but the pupils glow in the dark with a [eyecolor].");
		}
		else outputText(" Your eyes are [eyecolor].");
	}
	public function describeHairAndEars():void {
		//if bald
		var earType:Number = player.ears.type;
		if(player.hairLength == 0)
		{
			if(player.skinType == Skin.FUR)
				outputText(" You have no hair, only a thin layer of fur atop of your head. ");
			else {
				outputText(" You are totally bald, showing only shiny " + player.skinTone + " [skin.type]");
				if(player.skin.hasMagicalTattoo()) outputText(" covered with [skin color2] magical tattoo");
				else if (player.skin.hasBattleTattoo()) outputText(" covered with [skin color2] battle tattoo");
				else if (player.skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
				else if (player.skin.hasWindSweptScars()) outputText(" covered with scars as if your skin was cut in various place by a windstorm");
				else if (player.skin.hasOilySkin()) outputText(" dripping with oily black fluids.");
				else if (player.skin.hasScarShapedTattoo()) outputText(" covered with a few [skin color2] scar tattoos");
				else if (player.skin.hasWhiteBlackVeins()) outputText(" covered by [skin color2] veins");
				outputText(" where your hair should be.");
			}
			if(earType == Ears.HORSE)
				outputText(" A pair of horse-like ears rise up from the top of your head.");
			else if(earType == Ears.FERRET)
				outputText(" A pair of small, rounded ferret ears sit on top of your head.");
			else if(earType == Ears.DOG)
				outputText(" A pair of dog ears protrude from your skull, flopping down adorably.");
			else if(earType == Ears.COW)
				outputText(" A pair of round, " + player.hairColor + " floppy cow ears protrude from the sides of your skull.");
			else if(earType == Ears.ELFIN)
				outputText(" A pair of large pointy ears stick out from your skull.");
			else if(earType == Ears.SHARK)
				outputText(" A pair of fin like ears with fins stick out from your skull. They allow you to hear every sound with perfect clarity while underwater");
			else if(earType == Ears.CAT)
				outputText(" A pair of cute, fuzzy cat ears have sprouted from the top of your head.");
			else if(earType == Ears.PIG)
				outputText(" A pair of pointy, floppy pig ears have sprouted from the top of your head.");
			else if(earType == Ears.LIZARD)
				outputText(" A pair of rounded protrusions with small holes on the sides of your head serve as your ears.");
			else if(earType == Ears.BUNNY)
				outputText(" A pair of floppy rabbit ears stick up from the top of your head, flopping around as you walk.");
			else if(earType == Ears.FOX)
				outputText(" A pair of large, adept fox ears sit high on your head, always listening.");
			else if(earType == Ears.DRAGON)
				outputText(" A pair of rounded protrusions with small holes on the sides of your head serve as your ears. Bony fins sprout behind them.");
			else if(earType == Ears.RACCOON)
				outputText(" A pair of vaguely egg-shaped, furry raccoon ears adorns your head.");
			else if(earType == Ears.MOUSE)
				outputText(" A pair of large, dish-shaped mouse ears tops your head.");
			else if (earType == Ears.PIG)
				outputText(" A pair of pointy, floppy pig ears have sprouted from the top of your head.");
			else if (earType == Ears.RHINO)
				outputText(" A pair of open tubular rhino ears protrude from your head.");
			else if (earType == Ears.SQUIRREL)
				outputText(" A pair of sideways round squirrel ears that flick toward every slight sound.");
			else if (earType == Ears.ECHIDNA)
				outputText(" A pair of small rounded openings appear on your head that are your ears.");
			else if (earType == Ears.DEER)
				outputText(" A pair of deer-like ears rise up from the top of your head.");
			else if(earType == Ears.WOLF)
				outputText(" A pair of pointed wolf ears rise up from the top of your head.");
			else if(earType == Ears.LION)
				outputText(" A pair of lion ears have sprouted from the top of your head.");
			else if(earType == Ears.YETI)
				outputText(" A pair of yeti ears, bigger than your old human ones have sprouted from the top of your head.");
			else if(earType == Ears.ORCA)
				outputText(" A pair of very large fin at least twice as large as your head which help you orient yourself underwater have sprouted from the top of your head. Their underside is [skin color2] while the top is [skin color].");
			else if(earType == Ears.ORCA2)
				outputText(" A pair of rounded protrusions with small holes on the sides of your head serve as your ears.");
			else if(earType == Ears.SNAKE)
				outputText(" A pair of large pointy ears covered in small scales stick out from your skull.");
			else if(earType == Ears.GOAT)
				outputText(" A pair of ears look similar to those of a goat, flapping from time to time in response to sounds.");
			else if(earType == Ears.ONI)
				outputText(" A pair of pointed elf-like oni ears stick out from your skull.");
			else if(earType == Ears.ELVEN)
				outputText(" A pair of cute, long, elven, pointy ears, bigger than your old human ones and alert to every sound stick out from your skull.");
			else if(earType == Ears.GREMLIN){
				outputText(" A pair of sideways leaning furry ears that flick toward every slight sound. They don’t belong to any known animal but like anything demonic related help improve your devilish charm.");
				if (silly()){
					outputText(" With ears like that anyone would be hard pressed to resist the urge to headpat you.");
				}
			}
			else if(earType == Ears.RAIJU)
				outputText(" A pair of sideways leaning raiju ears that flick toward every slight sound stick out from your skull.");
			else if (earType == Ears.WEASEL){
				outputText(" A pair of two round fuzzy weasel ears covered with [skin coat.color] and alert to sound stick out from your skull.");
			}
			else if (earType == Ears.BAT){
				outputText(" A pair of bat ears sit atop your head, always perked up to catch any stray sound.");
			}
			else if (earType == Ears.VAMPIRE){
				outputText(" A pair of pointed elfin ears powerful enough to catch even the heartbeat of those around you stick out from your skull.");
			}
			else if (earType == Ears.RED_PANDA){
				outputText(" Big, white furred, red-panda ears lie atop your head, keeping you well aware to your surroundings.");
			}
			else if (earType == Ears.AVIAN){
				outputText(" Two small holes at each side of your head serve you as ears. Hidden by tufts of feathers, they’re almost unnoticeable.");
			}
			else if (earType == Ears.GRYPHON){
				outputText(" A duo of triangular, streamlined ears are located at each side of your head, helping you to pinpoint sounds. They’re covered in soft, [skin coat.color] fur and end in tufts.");
			}
			else if (earType == Ears.CAVE_WYRM){
				outputText(" Your ears are furry yet they do not actually belong to any known type of mammal. You suspect them to be related to an ancestry closer to that of the serpentine dragons they emulate.");
			}
			else if (earType == Ears.BEAR){
				outputText(" A pair of two round fuzzy bear ears covered with [skin coat.color] and alert to sound stick out from your skull.");
			}
			else if (earType == Ears.PANDA){
				outputText(" A pair of two round fuzzy panda ears covered with black fur just like a panda and alert to sound stick out from your skull.");
			}
			else if (earType == Ears.DISPLACER){
				outputText(" A large long furry ears atop your head, always perked up to catch any stray sound.");
			}
			else if (earType == Ears.MELKIE){
				outputText(" Your furry Melkie ears are long and flat, reaching all the way down to your waist.");
			}
			//</mod>
			if (player.gills.type == Gills.FISH)
			{
				outputText(" A set of fish like gills reside on your neck, several small slits that can close flat against your skin."
						 +" They allow you to stay in the water for quite a long time.");
			}
			// ANEMONE are handled below
			if(player.antennae.type == Antennae.MANTIS)
				outputText(" Long prehensile antennae also appear on your skull, bouncing and swaying in the breeze.");
			if(player.antennae.type == Antennae.BEE)
				outputText(" Floppy antennae also appear on your skull, bouncing and swaying in the breeze.");
			if(player.antennae.type == Antennae.FIRE_SNAIL)
				outputText(" Two horn like antennae also grow from just behind your hairline, feeling the air around and feeding you sensory information.");
			if(player.antennae.type == Antennae.MOTH)
				outputText(" Floppy antennae also appear on your skull, bouncing and swaying in the breeze.");
			if(player.antennae.type == Antennae.CENTIPEDE)
				outputText(" A pair of long antennae have grown just behind your hairline. They occasionally curl and twitch at the slightest of movements.");
			if(player.antennae.type == Antennae.SEADRAGON)
				outputText(" Just below your ears are four bioluminescent strands that run down your neck, beautifully lighting up your front and giving you an air of mystique.");
		}
		//not bald
		else
		{
			if(earType == Ears.HUMAN)
				outputText(" Your [hairlongdesc] looks good on you, accentuating your features well.");
			else if(earType == Ears.FERRET)
				outputText(" A pair of small, rounded ferret ears burst through the top of your [hairlongdesc].");
			else if(earType == Ears.HORSE)
				outputText(" The [hairlongdesc] on your head parts around a pair of very horse-like ears that grow up from your head.");
			else if(earType == Ears.DOG)
				outputText(" The [hairlongdesc] on your head is overlapped by a pair of pointed dog ears.");
			else if(earType == Ears.COW)
				outputText(" The [hairlongdesc] on your head is parted by a pair of " + player.hairColor + " rounded cow ears that stick out sideways.");
			else if(earType == Ears.ELFIN)
				outputText(" The [hairlongdesc] on your head is parted by a pair of cute pointed ears, bigger than your old human ones.");
			else if(earType == Ears.CAT)
				outputText(" The [hairlongdesc] on your head is parted by a pair of cute, fuzzy cat ears, sprouting from atop your head and pivoting towards any sudden noises.");
			else if(earType == Ears.LIZARD)
				outputText(" The [hairlongdesc] atop your head makes it nigh-impossible to notice the two small rounded openings that are your ears.");
			else if(earType == Ears.BUNNY)
				outputText(" A pair of floppy rabbit ears stick up out of your [hairlongdesc], bouncing around as you walk.");
			else if(earType == Ears.KANGAROO)
				outputText(" The [hairlongdesc] atop your head is parted by a pair of long, furred kangaroo ears that stick out at an angle.");
			else if(earType == Ears.FOX)
				outputText(" The [hairlongdesc] atop your head is parted by a pair of large, adept fox ears that always seem to be listening.");
			else if(earType == Ears.DRAGON)
				outputText(" The [hairlongdesc] atop your head is parted by a pair of rounded protrusions with small holes on the sides of your head serve as your ears. Bony fins sprout behind them.");
			else if(earType == Ears.RACCOON)
				outputText(" The [hairlongdesc] on your head parts around a pair of egg-shaped, furry raccoon ears.");
			else if(earType == Ears.MOUSE)
				outputText(" The [hairlongdesc] atop your head is funneled between and around a pair of large, dish-shaped mouse ears that stick up prominently.");
			else if(earType == Ears.PIG)
				outputText(" The [hairlongdesc] on your head is parted by a pair of pointy, floppy pig ears. They often flick about when you’re not thinking about it.");
			else if(earType == Ears.RHINO)
				outputText(" The [hairlongdesc] on your head is parted by a pair of tubular rhino ears.");
			else if (earType == Ears.SQUIRREL)
				outputText(" The [hairlongdesc] on your head is parted by a pair of sideways round squirrel ears that flick toward every slight sound.");
			else if(earType == Ears.ECHIDNA)
				outputText(" Your [hairlongdesc] makes it near-impossible to see the small, rounded openings that are your ears.");
			else if(earType == Ears.DEER)
				outputText(" The [hairlongdesc] on your head parts around a pair of deer-like ears that grow up from your head.");
			else if(earType == Ears.WOLF)
				outputText(" The [hairlongdesc] on your head is overlapped by a pair of pointed wolf ears.");
			else if(earType == Ears.LION)
				outputText(" The [hairlongdesc] is parted by a pair of lion ears that listen to every sound.");
			else if(earType == Ears.YETI)
				outputText(" The [hairlongdesc] is parted by a pair of yeti ears, bigger than your old human ones.");
			else if(earType == Ears.ORCA)
				outputText(" The [hairlongdesc] on your head is parted by a pair of very large fin at least twice as large as your head which help you orient yourself underwater. Their underside is white while the top is black.");
			else if(earType == Ears.SNAKE)
				outputText(" The [hairlongdesc] on your head is parted by a pair of cute pointed ears covered in small scales, bigger than your old human ones.");
			else if(earType == Ears.GOAT)
				outputText(" The [hairlongdesc] on your head is parted by a pair of ears looking similar to those of a goat, flapping from time to time in response to sounds.");
			else if(earType == Ears.ONI)
				outputText(" The [hairlongdesc] on your head is parted by a pair of pointed elf-like oni ears.");
			else if(earType == Ears.ELVEN) {
				outputText(" The [hairlongdesc] is parted by a pair of cute, long, elven, pointy ears, bigger than your old human ones and alert to every sound.");
				//if (player.hairType == SILKEN) outputText(" .");
			}
			else if(earType == Ears.GREMLIN){
				outputText(" The [hairlongdesc] is parted by a pair of sideways leaning furry ears that flick toward every slight sound. They don’t belong to any known animal but like anything demonic related help improve your devilish charm.");
				if (silly()){
					outputText(" With ears like that anyone would be hard pressed to resist the urge to headpat you.");
				}
			}
			else if(earType == Ears.RAIJU)
				outputText(" Your [hairlongdesc] is parted by two sideways leaning raiju ears that flick toward every slight sound.");
			else if(earType == Ears.WEASEL)
				outputText(" Your [hairlongdesc] is parted by two sideways leaning weasel ears that flick toward every slight sound.");
			if (earType == Ears.BAT){
				outputText(" The [hairlongdesc] on your head is parted by large bat ears atop your head, always perked up to catch any stray sound.");
			}
			if (earType == Ears.VAMPIRE){
				outputText(" The [hairlongdesc] on your head is parted by pointed elfin ears powerful enough to catch even the heartbeat of those around you.")
			}
			if (earType == Ears.RED_PANDA) {
				outputText(" Big, white furred, red-panda ears lie atop your head, keeping you well aware to your surroundings.")
			}
			if (earType == Ears.AVIAN){
				outputText(" The [hairlongdesc] atop your head compliments you quite well, and two small holes at each side of your head serve you as ears. Hidden by tufts of feathers, they’re almost unnoticeable.");
			}
			if (earType == Ears.GRYPHON){
				outputText(" Two triangular ears part your [hairlongdesc] at each side of your head. They’re streamlined and adapted to fly, and are quite useful to locate sounds. They’re covered in soft, [skin coat.color] fur and end in tufts.");
			}
			if (earType == Ears.CAVE_WYRM){
				outputText(" Your ears are furry yet they do not actually belong to any known type of mammal. You suspect them to be related to an ancestry closer to that of the serpentine dragons they emulate.");
			}
			if (earType == Ears.BEAR){
				outputText(" The [hairlongdesc] on your head is parted by a pair of two round fuzzy bear ears covered with [skin coat.color] and alert to sound.");
			}
			if (earType == Ears.PANDA){
				outputText(" The [hairlongdesc] on your head is parted by a pair of two round fuzzy panda ears covered with black fur just like a panda and alert to sound.");
			}
			if (earType == Ears.DISPLACER){
				outputText(" The [hairlongdesc] on your head is parted by large long furry ears atop your head, always perked up to catch any stray sound.");
			}
			if (earType == Ears.MELKIE){
				outputText("The [hairlongdesc] on your head is parted by your long and flat furry Melkie ears, reaching all the way down to your waist.");
			}
			//</mod>
			if(player.antennae.type == Antennae.MANTIS)
			{
				if(earType == Ears.BUNNY)
					outputText(" Long prehensile antennae also grow from just behind your hairline, waving and swaying in the breeze with your ears.");
				else outputText(" Long prehensile antennae also grow from just behind your hairline, bouncing and swaying in the breeze.");
			}
			if(player.antennae.type == Antennae.BEE)
			{
				if(earType == Ears.BUNNY)
					outputText(" Limp antennae also grow from just behind your hairline, waving and swaying in the breeze with your ears.");
				else outputText(" Floppy antennae also grow from just behind your hairline, bouncing and swaying in the breeze.");
			}
			if(player.antennae.type == Antennae.FIRE_SNAIL)
			{
				if(earType == Ears.BUNNY)
					outputText(" Two horn like antennae also grow from just behind your hairline, waving and swaying in the breeze with your ears, feeling the air around and feeding you sensory information");
				else outputText(" Two horn like antennae also grow from just behind your hairline, feeling the air around and feeding you sensory information.");
			}
			if(player.antennae.type == Antennae.MOTH)
			{
				if(earType == Ears.BUNNY)
					outputText(" Limp antennae also grow from just behind your hairline, waving and swaying in the breeze with your ears.");
				else outputText(" Floppy antennae also grow from just behind your hairline, bouncing and swaying in the breeze.");
			}
		}
	}
	public function describeHairStyle():void {
		var hairStyle:Number = player.hairStyle;
		if(player.hairLength == 0 && (player.hairType == Hair.STORM || player.hairType == Hair.BURNING || player.hairType == Hair.ANEMONE
				|| player.hairType == Hair.QUILL || player.hairType == Hair.FEATHER || player.hairType == Hair.GORGON || player.hairType == Hair.FLUFFY || player.hairType == Hair.CRAZY)) {
		}
		else {
			if(hairStyle == Hair.PLAIN)
				outputText(" Your hairs hangs plainly along the side of your head.");
			else if(hairStyle == Hair.WILD)
				outputText(" Your hairs are stand up in a wild fashion.")
			else if(hairStyle == Hair.PONYTAIL)
				outputText(" Your hairs are tied up into a ponytail.");
			else if(hairStyle == Hair.LONGTRESSES)
				outputText(" Your hairs are tied up into a great ponytail.");
			else if(hairStyle == Hair.TWINPIGTAIL)
				outputText(" Your hairs are tied up into a pair of pigtail.");
			else if(hairStyle == Hair.DWARVEN)
				outputText(" Your hairs are tied up into a dwarven fashion.");
		}
	}

	//Call this function when looking for repeatable tattoo conditional text
	public function tattooAndPatternGeneric():void{
		if (player.skin.hasMagicalTattoo()) outputText(" covered with magical tattoo");
		else if (player.skin.hasBattleTattoo()) outputText(" covered with battle tattoo");
		else if (player.skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos");
		else if (player.skin.hasWindSweptScars()) outputText(" covered with scars as if your skin was cut in various place by a windstorm");
		else if (player.skin.hasOilySkin()) outputText(" dripping with oily black fluids");
		else if (player.skin.hasScarShapedTattoo()) outputText(" covered with a few scar tattoos");
		else if (player.skin.hasWhiteBlackVeins()) outputText(" covered by [skin color2] veins");
	}

	public function describeFaceShape():void {
		// story.display("faceShape");
		var faceType:Number = player.faceType;
		var skin:Skin = player.skin;
		if (player.facePart.isHumanShaped()) {
			var odd:int = 0;
			var skinAndSomething:String = "";
			if (player.facePart.type == Face.BUCKTEETH) {
				skinAndSomething = " and mousey buckteeth";
				odd++;
			}
			if (skin.coverage<Skin.COVERAGE_COMPLETE) {
				outputText("Your face is human in shape and structure, with [skin]"+skinAndSomething);
				if (skin.hasMagicalTattoo()) {
					outputText(" covered with [skin color2] magical tattoo");
					odd++;
				}
				else if (skin.hasBattleTattoo()) {
					outputText(" covered with [skin color2] battle tattoo");
					odd++;
				}
				else if (skin.hasLightningShapedTattoo()) {
					outputText(" covered with a few glowing lightning tattoos");
					odd++;
				}
				else if(skin.hasWindSweptScars()) {
					outputText(" covered with scars as if your skin was cut in various place by a windstorm");
					odd++;
				}
				else if(skin.hasOilySkin()){
					outputText(" dripping with oily black fluids.");
					odd++;
				}
				else if (skin.hasScarShapedTattoo()) {
					outputText(" covered with a few [skin color2] scar tattoos");
					odd++;
				}
				else if (skin.hasWhiteBlackVeins()) {
					outputText(" covered by [skin color2] veins");
					odd++;
				}
				if (skin.isCoverLowMid()) {
					outputText(".");
					outputText(" On your cheek you have [skin coat]");
					odd++;
				}
			} else if (skin.hasCoatOfType(Skin.FUR)) {
				odd++;
				outputText("Under your [skin coat]");
				if (skin.coat.pattern == Skin.PATTERN_TIGER_STRIPES) {
					outputText(" with [skin coat.color2] stripes");
					odd++;
				}
				outputText("you have a human-shaped head with [skin base]"+skinAndSomething);
			} else if (skin.hasCoat() && !skinAndSomething) {
				odd++;
				outputText("Your face is fairly human in shape, but is covered in [skin coat]");
				if (skin.coat.pattern == Skin.PATTERN_TIGER_STRIPES) {
					outputText(" with [skin coat.color2] stripes");
					odd++;
				}
			} else outputText("Your face is human in shape and structure, with [skin full]"+skinAndSomething);
				if (skin.coat.pattern == Skin.PATTERN_TIGER_STRIPES) {
					outputText(" and [skin coat.color2] stripes");
					odd++;
				}
			outputText(".");

			if (faceType == Face.SHARK_TEETH)
				outputText(" A set of razor-sharp, retractable shark-teeth fill your mouth and gives your visage a slightly angular appearance.");
			else if (faceType == Face.BUNNY)
				outputText(" The constant twitches of your nose and the length of your incisors gives your visage a hint of bunny-like cuteness.");
			else if (faceType == Face.SMUG)
				outputText(" the length of your incisors gives your visage a hint of squirrel-like cuteness. This said once in a while you can't help but smirk smuggly at your interlocutors.");
			else if (faceType == Face.SPIDER_FANGS)
				outputText(" A set of retractable, needle-like fangs sit in place of your canines and are ready to dispense their venom.");
			else if (faceType == Face.FERRET_MASK)
				outputText(" The [skinFurScales] around your eyes is significantly darker than the rest of your face, giving you a cute little ferret mask.");
			else if (faceType == Face.MANTICORE)
				outputText(" You have a set of sharp cat-like teeth in your mouth.");
			else if (faceType == Face.SNAKE_FANGS) {
				if (odd==0) {
					outputText(" The only oddity is your pair of dripping fangs which often hang over your lower lip.");
				} else {
					outputText(" In addition, a pair of fangs hang over your lower lip, dripping with venom.");
				}
			} else if (faceType == Face.SALAMANDER_FANGS) {
				if (odd == 0) {
					outputText(". The only oddity is your salamander fangs giving you a menacing smile.");
				} else {
					outputText(" In addition, a pair of salamander fangs grows out of your mouth giving you a menacing smile.");
				}
			} else if (faceType == Face.YETI_FANGS) {
				if (odd == 0){
					outputText(". Your mouth, while human looking, has sharp yeti fangs not unlike those of a monkey.");
				} else {
					outputText(" In addition, your mouth, while human looking, has sharp yeti fangs not unlike those of a monkey.");
				}
			} else if(faceType == Face.VAMPIRE){
				if (odd == 0){
				outputText(" Your mouth could pass for human if not for the pair of long and pointy canines you use to tear into your victims to get at their blood.");
				} else {
					outputText(" In addition, your mouth could pass for human if not for the pair of long and pointy canines you use to tear into your victims to get at their blood.");
				}
			} else if(faceType == Face.VAMPIRE){
				if (odd == 0){
					outputText(" Your mouth is human looking all right though your near constant crazy toothy smile isn't exactly helping to make you look sane. A careful onlooker could also easily notice that your canines are longer and pointier then normal like those of tiny fiends.");
				} else {
					outputText(" In addition, your mouth could pass for human if not for your near constant crazy toothy smile isn't exactly helping to make you look sane. A careful onlooker also could easily notice that your canines are longer and pointier then normal like those of tiny fiends.");
				}
			} else if(faceType == Face.FAIRY){
				if (odd == 0){
					outputText(" Your fairy nature allows you to always display a pure, cheerful, innocent smile that warms the hearts of those around you.");
				} else {
					outputText(" In addition, your fairy nature allows you to always display a pure, cheerful, innocent smile that warms the hearts of those around you.");
				}
			} else if(faceType == Face.ELF){
				if (odd == 0){
					outputText("  You have an enchanting smile and perfect pearlescent white teeth.");
				} else {
					outputText("  In addition, you have an enchanting smile and perfect pearlescent white teeth.");
				}
			}
		}
		else if (faceType == Face.FERRET) {
			if (player.hasFullCoatOfType(Skin.FUR)) outputText(" Your face is coated in [skin coat] with [skin base] underneath, an adorable cross between human and ferret features. It is complete with a wet nose and whiskers.");
			else if (player.hasCoat()) outputText(" Your face is an adorable cross between human and ferret features, complete with a wet nose and whiskers. The only oddity is [skin base] covered with [skin coat].");
			else outputText(" Your face is an adorable cross between human and ferret features, complete with a wet nose and whiskers. The only oddity is your lack of fur, leaving only [skin] visible on your ferret-like face.");
		}
		else if (faceType == Face.RACCOON_MASK) {
			if (!player.hasCoat()) { //appearance for skinheads
				outputText(" Your face is human in shape and structure, with [skin bases]");
				if (InCollection(skin.base.color, "ebony", "black")) outputText(", though with your dusky hue, the black raccoon mask you sport isn't properly visible.");
				tattooAndPatternGeneric();
				outputText(", though it is decorated with a sly-looking raccoon mask over your eyes.");
			} else { //appearance furscales
				//(black/midnight furscales)
				if (InCollection(skin.base.color, "black", "midnight", "black", "midnight", "black", "midnight"))
					outputText(" Under your [skin coat] hides a black raccoon mask, barely visible due to your inky hue, and");
				else outputText(" Your [skin coat] are decorated with a sly-looking raccoon mask, and under them");
				outputText(" you have a human-shaped head with [skin base].");
			}
		}
		else if (faceType == Face.RACCOON) {
			outputText(" You have a triangular raccoon face, replete with sensitive whiskers and a little black nose; a mask shades the space around your eyes, set apart from your [skin coat] by a band of white.");
			//(if skin)
			if (player.hasPlainSkinOnly()){
				outputText(" It looks a bit strange with only the skin");
				tattooAndPatternGeneric();
				outputText("and no fur.");
			}
			else if (player.hasScales()) outputText(" The presence of said scales gives your visage an eerie look, more reptile than mammal.");
			else if (skin.hasChitin()) outputText(" The presence of said chitin gives your visage an eerie look, more insect than mammal.");
		}
		else if (faceType == Face.FOX) {
			outputText(" You have a tapered, shrewd-looking vulpine face with a speckling of downward-curved whiskers just behind the nose.");
			if (!player.hasCoat()) {
				outputText(" Oddly enough, there's no fur on your animalistic muzzle, just [skin coat]");
				tattooAndPatternGeneric();
				outputText(".");
			}
			else if (player.hasFullCoatOfType(Skin.FUR)) outputText(" A coat of [skin coat] decorates your muzzle.");
			else if (skin.isCoverLowMid()) outputText(" Strangely, [skin coat] adorn your animalistic visage.");
			else outputText(" Strangely, [skin coat] adorn every inch of your animalistic visage.");
		}
		else if (faceType == Face.MOUSE) {
			//appearance
			outputText(" You have a snubby, tapered mouse's face, with whiskers, a little pink nose, and [skin full]");
			outputText(". Two large incisors complete it.");
		}
		//animal tooths
		if (faceType == Face.ANIMAL_TOOTHS) {
			if (!player.hasCoat()) {
				outputText(" Your face");
				tattooAndPatternGeneric();
				outputText(" looks human save for your sharp canines.");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText(" Your face looks human save for your sharp canines. Your [skin coat.nocolor] is [skin coat.color], hiding your [skin base] underneath.");
			} else {
				outputText(" Your face looks human save for your sharp canines, but overlaid with glittering patches of [skin coat].");
			}
			if (player.eyes.type == Eyes.CENTIPEDE){
				outputText(" You wear a constant expression of sadness, barely drawing attention away from your mouth.\n");
			}
		}
		//horse-face
		if (faceType == Face.HORSE) {
			if (!player.hasCoat()) {
				outputText(" Your face");
				tattooAndPatternGeneric();
				outputText(" is equine in shape and structure. The odd visage is hairless and covered with [skin base]");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText(" Your face");
				outputText(" is almost entirely equine in appearance, even having [skin coat]. Underneath the fur, you believe you have [skin base].");
			} else {
				outputText(" You have the face and head structure of a horse,");
				outputText(" overlaid with glittering [skin coat].");
			}
		}
		//dog-face
		if (faceType == Face.DOG) {
			if (!player.hasCoat()) {
				outputText(" You have a dog-like face");
				tattooAndPatternGeneric();
				outputText(" , complete with a wet nose. The odd visage is hairless and covered with [skin base].");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText(" You have a dog's face, complete with wet nose and panting tongue. You've got [skin coat], hiding your [skin base] underneath your furry visage.");
			} else {
				outputText(" You have the facial structure of a dog, wet nose and all, but overlaid with glittering patches of [skin coat]");
			}
		}
		//Squirrel-face
		if (faceType == Face.SQUIRREL) {
			if (!player.hasCoat()) {
				outputText(" You have a squirrel-like face");
				tattooAndPatternGeneric();
				outputText(" , complete with a twitching nose. The odd visage is hairless and covered with [skin base].");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText(" You have a squirrel's face, complete with twitching nose and two incisors. You've got [skin coat], hiding your [skin base] underneath your furry visage.");
			} else {
				outputText(" You have the facial structure of a squirrel, twitching nose incisors and all, but overlaid with glittering patches of [skin coat]");
			}
		}
		//wolf-face
		if (faceType == Face.WOLF) {
			if (!player.hasCoat()) {
				outputText(" You have a wolf-like face, complete with a wet nose. ");
				if (player.hasKeyItem("Gleipnir Collar") >= 0) outputText("Your breath freezes the air, and cold mist leaks from your jaws. ");
				outputText("The odd visage is hairless and covered with [skin coat]");
				tattooAndPatternGeneric();
				outputText(".");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText(" You have a wolf’s face, complete with wet nose a panting tongue and threatening teeth. ");
				if (player.hasKeyItem("Gleipnir Collar") >= 0) outputText("Your breath freezes the air, and cold mist leaks from your jaws. ");
				outputText("You've got [skin coat], hiding your [skin noadj] underneath your furry visage.");
			} else {
				outputText(" You have the facial structure of a wolf, wet nose and all, but overlaid with glittering patches of [skin coat].");
				if (player.hasKeyItem("Gleipnir Collar") >= 0) outputText(" Your breath freezes the air, and cold mist leaks from your jaws.");
			}
		}
		if (faceType == Face.WOLF_FANGS) {
			if (!player.hasCoat()) {
				outputText(" Your face is human in shape and structure with [skin coat]");
				outputText(". Your mouth is somewhat human save for your wolf-like canines.");
			} else if (player.hasPartialCoat(Skin.FUR)) {
				outputText(" Your face looks human save for your wolf-like canines, but overlaid with glittering patches of [skin coat].");
			} else {
				outputText(" Your face looks human save for your wolf-like canines. You've got [skin coat], hiding your [skin noadj] underneath your furry visage.");
			}
		}
		//cat-faces
		if (faceType == Face.CAT || faceType == Face.CHESHIRE) {
			if (!player.hasCoat()) {
				outputText(" You have a cat-like face, complete with a cute, moist nose and whiskers. The [skin] that is revealed by your lack of fur looks quite unusual on so feline a face");
				tattooAndPatternGeneric();
				outputText(".");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText(" You have a cat-like face, complete with moist nose and whiskers. Your [skin coat.nocolor] is [skin coat.color], hiding your [skin base] underneath.");
			} else {
				outputText(" Your facial structure blends humanoid features with those of a cat. A moist nose and whiskers are included, but overlaid with glittering patches of [skin coat].");
			}
			if (faceType == Face.CHESHIRE) outputText(" For some reason your facial expression is that of an everlasting yet somewhat unsettling grin.");
		}
		if (faceType == Face.CAT_CANINES || faceType == Face.CHESHIRE_SMILE) {
			outputText(" Your face is human in shape and structure with [skin coat]. Your mouth is somewhat human save for your cat-like canines.");
			if (faceType == Face.CHESHIRE_SMILE) outputText(" For some reason your facial expression is that of an everlasting yet somewhat unsettling grin.");
		}
		//Minotaaaauuuur-face
		if (faceType == Face.COW_MINOTAUR) {
			if (!player.hasCoat()) {
				outputText(" You have a face resembling that of a minotaur");
				if (!player.skin.hasNoPattern()){
					outputText(",");
					tattooAndPatternGeneric();
				}
				outputText(", with cow-like features, particularly a squared off wet nose. Despite your lack of fur elsewhere, your visage does have a short layer of [haircolor] fuzz.");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText(" You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose. Your [skin coat] thickens noticeably on your head, looking shaggy and more than a little monstrous once laid over your visage.");
			} else if (player.hasFullCoat()) {
				outputText(" Your face resembles a minotaur's, though strangely it is covered in shimmering [skin coat], right up to the flat cow-like nose that protrudes from your face.");
			} else {
				outputText(" Your face resembles a minotaur's, though strangely it is covered small patches of shimmering [skin coat], right up to the flat cow-like nose that protrudes from your face.");
			}
		}
		//Lizard-face
		if (faceType == Face.LIZARD) {
			if (!player.hasCoat()) {
				outputText(" You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage. The reptilian visage does look a little odd with just [skin]");
				tattooAndPatternGeneric();
				outputText(".");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText(" You have a face resembling that of a lizard. Between the toothy maw, pointed snout, and the layer of [skin coat] covering your face, you have quite the fearsome visage.");
			} else if (player.hasFullCoat()) {
				outputText(" Your face is that of a lizard, complete with a toothy maw and pointed snout. Reflective [skin coat] complete the look, making you look quite fearsome.");
			} else {
				outputText(" You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage. The reptilian visage does look a little odd with just [skin coat].");
			}
		}
		if (faceType == Face.DRAGON) {
			outputText(" Your face is a narrow, reptilian muzzle. It looks like a predatory lizard's, at first glance, but with an unusual array of spikes along the under-jaw. It gives you a regal but fierce visage. Opening your mouth reveals several rows of dagger-like sharp teeth. The fearsome visage is decorated by [skin coat].");
		}
		if (faceType == Face.DRAGON_FANGS) {
			outputText(" Your mouth is somewhat human save for your draconic fangs giving you a menacing smile. It's decorated by [skin coat].");
		}
		if (faceType == Face.JABBERWOCKY) {
			outputText(" Your face is a narrow, reptilian muzzle. It looks like a predatory lizard's, at first glance, but with an unusual array of spikes along the under-jaw. It gives you a regal but fierce visage. Opening your mouth reveals two buck tooth, which are abnormally large. Like a rabbit or rather a Jabberwocky. The fearsome visage is decorated by [skin coat].");
		}
		if (faceType == Face.BUCKTOOTH) {
			outputText(" Your mouth is somewhat human save for your two buck tooth, which are abnormally large. Like a rabbit or rather a Jabberwocky. It's decorated by [skin coat].");
		}
		if (faceType == Face.PLANT_DRAGON) {
			outputText(" Your face is a narrow, reptilian and regal, reminiscent of a dragon. A [skin coat] decorates your visage.");
		}
		if (faceType == Face.DEVIL_FANGS) {
			outputText(" Your mouth looks human enough, save for your fiendish canines. It's decorated by [skin coat].");
		}
		if (faceType == Face.ONI_TEETH) {
			outputText(" Your face is human in shape and structure with [skin coat]. Your mouth could pass for human if not for your two large ogre like canines.");
		}
		if (faceType == Face.WEASEL) {
			outputText(" Your face is human in shape and structure with [skin coat]. Your mouth could pass for human if not for your two sharp weasel canines.");
		}
		if (faceType == Face.ORC_FANGS) {
			outputText(" Your face is human in shape and structure, with [skin base] ");
			tattooAndPatternGeneric();
			outputText(". Your mouth could pass for human if it were not for your two lower canines resembling boar tusks poking out of your mouth.");
		}
		if (faceType == Face.ORCA) {
			if (skin.hasPlainSkinOnly() && player.skinAdj == "glossy" && player.skinTone == "white and black")
				outputText(" Your face is fairly human in shape save for a wider yet adorable nose. Your skin is pitch black with a white underbelly. From your neck up to your mouth and lower cheeks your face is white with two extra white circles right under and above your eyes. While at first one could mistake it for human skin, it has a glossy shine only found on sea animals.");
			else if (!player.hasFullCoat()) {
				if (skin.hasCoatOfType(Skin.SCALES, Skin.FUR)) {
					outputText(" You have a fairly normal face, with [skin base]. On your cheek you have [skin coat]");
				} else {
					outputText(" You have a fairly normal face, with [skin base]");
					tattooAndPatternGeneric();
				}
				outputText(". In addition you have a wide nose similar to that of an orca, which goes well with your sharp toothed mouth, giving you a cute look.");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText(" Under your [skin coat] you have a human-shaped head with [skin base]. In addition you have a wide nose similar to that of an orca, which goes well with your sharp toothed mouth, giving you a cute look.");
			} else {
				outputText(" Your face is fairly human in shape, but is covered in [skin coat]. In addition you have a wide nose similar to that of an orca, which goes well with your sharp toothed mouth, giving you a cute look.");
			}
		}
		if (faceType == Face.KANGAROO) {
			outputText(" Your face is ");
			if (!player.hasCoat()) {
				outputText("bald");
				tattooAndPatternGeneric();
			} else outputText("covered with [skin coat]");
			outputText(" and shaped like that of a kangaroo, somewhat rabbit-like except for the extreme length of your odd visage.");
		}
		//<mod>
		if (faceType == Face.PIG) {
			outputText(" Your face is like that of a pig, with " + player.skinTone + " skin, complete with a snout that is always wiggling.");
		}
		if (faceType == Face.BOAR) {
			outputText(" Your face is like that of a boar, ");
			if (player.skinType == Skin.FUR)
				outputText("with " + player.skinTone + " skin underneath your [skin coat.color] fur");
			outputText(", complete with tusks and a snout that is always wiggling.");
		}
		if (faceType == Face.RHINO) {
			outputText(" Your face is like that of a rhino");
			if (!player.hasCoat()) {
				outputText(", with [skin], complete with a long muzzle and a horns on your nose");
				tattooAndPatternGeneric();
				outputText(".");
			}
			else
				outputText(" with a long muzzle and a horns on your nose. Oddly, your face is also covered in [skin coat].");
		}
		if (faceType == Face.ECHIDNA) {
			outputText(" Your odd visage consists of a long, thin echidna snout.");
			if (!player.hasCoat()) {
				outputText(" The [skin base]");
				tattooAndPatternGeneric();
				outputText(" that is revealed by your lack of fur looks quite unusual.");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText(" It's covered in [skin coat].");
			} else {
				outputText(" It's covered in [skin coat], making your face even more unusual.");
			}
		}
		if (faceType == Face.DEER) {
			outputText(" Your face is like that of a deer, with a nose at the end of your muzzle.");
			if (!player.hasCoat()) {
				outputText(" The [skin]");
				tattooAndPatternGeneric();
				outputText(" that is revealed by your lack of fur looks quite unusual.");
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText(" It's covered in [skin coat] that covers your " + player.skinTone + " skin underneath.");
			} else {
				outputText(" It's covered in [skin coat], making your face looks more unusual.");
			}
		}
		if (faceType == Face.BEAR) {
			outputText(" Your face is that of a bear with an adorable wet nose and sharp teeth.");
			if (player.hasFullCoatOfType(Skin.FUR)) outputText(" A coat of soft, [skin coat.color] colored fur covers your head.");
		}
		if (faceType == Face.PANDA) {
			outputText(" Your face is that of a panda with an adorable wet nose and sharp teeth. Over your [skin], your face fur, much like most of your body, is white with two black circles right around your eyes.");
		}
		if (faceType == Face.RED_PANDA) {
			outputText(" Your face has a distinctive animalistic muzzle, proper from a red-panda, complete with a cute pink nose.");
			if (player.hasFullCoatOfType(Skin.FUR)) outputText(" A coat of soft, [skin coat.color] colored fur covers your head, with patches of white on your muzzle, cheeks and eyebrows.")
		}
		if (faceType == Face.AVIAN) {
			outputText(" Your visage has a bird-like appearance, complete with an avian beak. A couple of small holes on it makes up for your nostrils, while a long, nimble tongue is hidden inside.");
			if (player.hasFullCoatOfType(Skin.FEATHER)) outputText(" The rest of your face is decorated with a coat of [skin coat].")
		}
		if (faceType == Face.FIRE_SNAIL) {
			outputText(" Your face is human in shape and structure");
			if (!player.skin.hasNoPattern()){
				outputText("with ");
				tattooAndPatternGeneric();
			}
			outputText(" but your mouth is drooling from constant arousal.");
		}
		if (faceType == Face.GHOST) {
			outputText(" Your face is in human shape and structure");
			if (!player.skin.hasNoPattern()){
				outputText("with ");
				tattooAndPatternGeneric();
			}
			outputText(". The only thing out of place is the ever present wide smile on your face. Your unsettling smile often hides your true emotions much to the dismay of others.");
		}
		if (faceType == Face.JIANGSHI) {
			outputText(" Your face is human in form and shape with " + player.skinTone + " but your expression is kind of zombie like.");
		}
		if (faceType == Face.KUDERE) {
			outputText(" Your face is human in shape and structure with " + player.skinTone + ". The most unsettling thing about it is your complete and constant lack of emotion.");
			if (!player.hasCoat()) {
				if (!player.skin.hasNoPattern()){
					outputText(" The [skin] is");
					tattooAndPatternGeneric();
				}
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText(" It's covered in [skin coat] that covers your " + player.skinTone + " skin underneath.");
			} else {
				outputText(" It's covered in [skin coat], making your face looks even more unusual.");
			}
		}
		if (faceType == Face.YUKI_ONNA) {
			outputText(" Your face is fully human in appearance although your lips are dyed blue by the cold. As for your [skin] it yearns for the warmth of life.");
			if (!player.hasCoat()) {
				if (!player.skin.hasNoPattern()){
					outputText(" Your [skin] is");
					tattooAndPatternGeneric();
				}
			} else if (player.hasFullCoatOfType(Skin.FUR)) {
				outputText(" It's covered in [skin coat] that covers your " + player.skinTone + " skin underneath.");
			} else {
				outputText(" It's covered in [skin coat] that covers your " + player.skinTone + " skin underneath, making your face looks more unusual.");
			}
		}
		if (faceType == Face.USHI_ONI_ONNA) {
			outputText(" You have the face of a ushi " + player.mf("oni", "onna") + ", you have strange black tattoos circling your eyes and in your mouth small fangs with a weak poison can be seen when you smile or open you mouth.");
		}
		//WIP Code reformating of the face section
		//section for the tatoo
		//if (skin.hasMagicalTattoo()) outputText(" covered with magical tattoo.");
		//else if (skin.hasBattleTattoo()) outputText(" covered with battle tattoo.");
		//else if (skin.hasLightningShapedTattoo()) outputText(" covered with a few glowing lightning tattoos.");
		//else if (skin.hasScarShapedTattoo()) outputText(" covered with a few scar tattoos.");
		//else if (skin.hasWhiteBlackVeins()) outputText(" covered by [skin color2] veins.");
		//else outputText(".");
		//Section for the coat
		//if (!player.hasPartialCoatNoTypeDeclaration){
			//if (!player.hasPartialCoat(Skin.FUR)) outputText(" On your cheek you have [skin coat].");
			//if (!player.hasPartialCoat(Skin.SCALES)){} outputText(" On your cheek you have [skin coat].");
			//if (!player.hasPartialCoat(Skin.AQUA_SCALES)){} outputText(" On your cheek you have [skin coat].");
			//if (!player.hasPartialCoat(Skin.CHITIN)){} outputText(" On your cheek you have [skin coat].");
		//} else if (player.hasFullCoat()) {
			//if (player.hasFullCoatOfType(Skin.FUR)) outputText(" Your skin is covered in [skin coat] that covers your " + player.skinTone + " skin underneath.");
			//if (player.hasFullCoatOfType(Skin.SCALES)){} outputText(" Your skin is covered in [skin coat] that covers your " + player.skinTone + " skin underneath.");
			//if (player.hasFullCoatOfType(Skin.AQUA_SCALES)){} outputText(" Your skin is covered in [skin coat] that covers your " + player.skinTone + " skin underneath.");
			//if (player.hasFullCoatOfType(Skin.CHITIN)){} outputText(" Your skin is covered in [skin coat] that covers your " + player.skinTone + " skin underneath.");
		//}
		//Section for below the head
		if (player.skin.hasVenomousMarking()) {
			outputText(" Beneath your shoulder all the way down to your waist your skin is covered with purple venomous marking");
		}
		//</mod>
	}
	public function RacialScores():void {
		var score:int;
		clearOutput();
		outputText("<b>Current racial scores (and bonuses to stats if applicable):</b>\n");
		//Alicorn
		if (player.alicornScore() >= 24) outputText("\n<font color=\"#0000a0\">True Alicorn/True Nightmare: " + player.alicornScore() + " (+60% to Str racial multi, +70% to Tou racial multi, +140% to Spe racial multi, +85% to Int racial multi)</font>");
		else if (player.alicornScore() >= 12) outputText("\n<font color=\"#0000a0\">Alicorn/Nightmare: " + player.alicornScore() + " (+35% to Tou racial multi, +90% to Spe racial multi, +75% to Int racial multi)</font>");
		else if (player.alicornScore() >= 8) outputText("\n<font color=\"#0000a0\"> Half Alicorn/Half Nightmare: " + player.alicornScore() + " (+15% to Tou racial multi, +50% to Spe racial multi, +55% to Int racial multi)</font>");
		else if (player.alicornScore() >= 1) outputText("\n<font color=\"#008000\">Alicorn/Nightmare: " + player.alicornScore() + "</font>");
		else if (player.alicornScore() < 1) outputText("\n<font color=\"#ff0000\">Alicorn/Nightmare: 0</font>");
		//AlicornKin
		if (player.alicornkinScore() >= 12) outputText("\n<font color=\"#0000a0\">Alicornkin/Nightmarekin: " + player.alicornkinScore() + " (+45% to Tou racial multi, +60% to Spe racial multi, +75% to Int racial multi)</font>");
		else if (player.alicornkinScore() >= 1) outputText("\n<font color=\"#008000\">Alicornkin/Nightmarekin: " + player.alicornkinScore() + "</font>");
		else if (player.alicornkinScore() < 1) outputText("\n<font color=\"#ff0000\">Alicornkin/Nightmarekin: 0</font>");
		//Alraune > Liliraune
		if (player.lowerBody != LowerBody.FLOWER_LILIRAUNE) {
			if (player.alrauneScore() >= 17) outputText("\n<font color=\"#0000a0\">Greater Alraune: " + player.alrauneScore() + " (+115% to Tou racial multi, -60% to Spe racial multi, +200% to Lib racial multi)</font>");
			else if (player.alrauneScore() >= 13) outputText("\n<font color=\"#0000a0\">Alraune: " + player.alrauneScore() + " (+100% to Tou racial multi, -50% to Spe racial multi, +145% to Lib racial multi)</font>");
			else if (player.alrauneScore() >= 1) outputText("\n<font color=\"#008000\">Alraune: " + player.alrauneScore() + "</font>");
			else if (player.alrauneScore() < 1) outputText("\n<font color=\"#ff0000\">Alraune: 0</font>");
		}
		else {
			if (player.alrauneScore() >= 17) outputText("\n<font color=\"#0000a0\">Greater Liliraune: " + player.alrauneScore() + " (+115% to Tou racial multi, -60% to Spe racial multi, +200% to Lib racial multi)</font>");
			else if (player.alrauneScore() >= 13) outputText("\n<font color=\"#0000a0\">Liliraune: " + player.alrauneScore() + " (+100% to Tou racial multi, -50% to Spe racial multi, +145% to Lib racial multi)</font>");
			else if (player.alrauneScore() >= 1) outputText("\n<font color=\"#008000\">Liliraune: " + player.alrauneScore() + "</font>");
			else if (player.alrauneScore() < 1) outputText("\n<font color=\"#ff0000\">Liliraune: 0</font>");
		}
		//Atlach Nacha
		score = player.atlachNachaScore();
		if (score >= 30) outputText("\n<font color=\"#0000a0\">Greater Atlach Nacha: " + score + " (+115% to Str racial multi, +135% to Tou racial multi, +150% to Int racial multi, +150% to Lib racial multi, -50% to Wis racial multi, +50 to Sens)</font>");
		else if (score >= 18) outputText("\n<font color=\"#0000a0\">Atlach Nacha: " + score + " (+80% to Str racial multi, +90% to Tou racial multi, +100% to Int racial multi, +100% to Lib racial multi, -50% to Wis racial multi, +50 to Sens)</font>");
		else if (score >= 10) outputText("\n<font color=\"#0000a0\">Incomplete Atlach Nacha: " + score + " (+50% to Tou racial multi, +75% to Int racial multi, +20% to Lib racial multi, -20% to Wis racial multi)</font>");
		else if (score >= 1) outputText("\n<font color=\"#008000\">Incomplete Atlach Nacha: " + score + "</font>");
		else if (score < 1) outputText("\n<font color=\"#ff0000\">Half Spider-morph: 0</font>");
		//Avian
		if (player.avianScore() >= 9) outputText("\n<font color=\"#0000a0\">Avian-morph: " + player.avianScore() + " (+30% to Str racial multi, +75% to Spe racial multi, +30% to Int racial multib)</font>");
		else if (player.avianScore() >= 4) outputText("\n<font color=\"#0000a0\">Half Avian-morph: " + player.avianScore() + " (+15% to Str racial multi, +30% to Spe racial multi, +15% to Int racial multi)</font>");
		else if (player.avianScore() >= 1) outputText("\n<font color=\"#008000\">Half Avian-morph: " + player.avianScore() + "</font>");
		else if (player.avianScore() < 1) outputText("\n<font color=\"#ff0000\">Half Avian-morph: 0</font>");
		//Bat
		if (player.batScore() >= 10) outputText("\n<font color=\"#0000a0\">Batgirl/Batboy: " + player.batScore() + " (+35% to Str racial multi, +35% to Spe racial multi, +35% to Int racial multi, +45% to Lib racial multi)</font>");
		else if (player.batScore() >= 6) outputText("\n<font color=\"#0000a0\">Half Batgirl/Batboy: " + player.batScore() + " (+20% to Str racial multi, +20% to Spe racial multi, +20% to Int racial multi, +30% to Lib racial multi)</font>");
		else if (player.batScore() >= 1) outputText("\n<font color=\"#008000\">Half Batgirl/Batboy: " + player.batScore() + "</font>");
		else if (player.batScore() < 1) outputText("\n<font color=\"#ff0000\">Half Batgirl/Batboy: 0</font>");
		//Bear/Panda
		if (player.bearpandaScore() >= 10) outputText("\n<font color=\"#0000a0\">Bear/Panda-morph: " + player.bearpandaScore() + " (+100% to Str racial multi, +70% to Tou racial multi, -20% to Int racial multi)</font>");
		else if (player.bearpandaScore() >= 5) outputText("\n<font color=\"#0000a0\">Half Bear/Panda-morph: " + player.bearpandaScore() + " (+50% to Str racial multi, +30% to Tou racial multi, +5% to Int racial multi)</font>");
		else if (player.bearpandaScore() >= 1) outputText("\n<font color=\"#008000\">Half Bear/Panda-morph: " + player.bearpandaScore() + "</font>");
		else if (player.bearpandaScore() < 1) outputText("\n<font color=\"#ff0000\">Half Bear/Panda-morph: 0</font>");
		//Bee
		if (player.beeScore() >= 9) outputText("\n<font color=\"#0000a0\">Bee-morph: " + player.beeScore() + " (+50% to Tou racial multi, +50% to Spe racial multi, +35% to Int racial multi)</font>");
		else if (player.beeScore() >= 5) outputText("\n<font color=\"#0000a0\">Half Bee-morph: " + player.beeScore() + " (+30% to Tou racial multi, +30% to Spe racial multi, +15% to Int racial multi)</font>");
		else if (player.beeScore() >= 1) outputText("\n<font color=\"#008000\">Half Bee-morph: " + player.beeScore() + "</font>");
		else if (player.beeScore() < 1) outputText("\n<font color=\"#ff0000\">Half Bee-morph: 0</font>");
		//Bunny
		if (player.bunnyScore() >= 10) outputText("\n<font color=\"#0000a0\">Bunny-morph: " + player.bunnyScore() + " (-20% to Str racial multi, -10% to Tou racial multi, +90% to Spe racial multi, +90% to Lib racial multi)</font>");
		else if (player.bunnyScore() >= 5) outputText("\n<font color=\"#0000a0\">Half Bunny-morph: " + player.bunnyScore() + " (-10% to Str racial multi, -5% to Tou racial multi, +55% to Spe racial multi, +35% to Lib racial multi)</font>");
		else if (player.bunnyScore() >= 1) outputText("\n<font color=\"#008000\">Half Bunny-morph: " + player.bunnyScore() + "</font>");
		else if (player.bunnyScore() < 1) outputText("\n<font color=\"#ff0000\">Half Bunny-morph: 0</font>");
		//Cancer
		if (player.cancerScore() >= 20) outputText("\n<font color=\"#0000a0\">Cancer: " + player.cancerScore() + " (+125% to Str racial multi, +115% to Tou racial multi, +105% to Spe racial multi, -30% to Int racial multi, -15% to Wis racial multi)</font>");
		else if (player.cancerScore() >= 13) outputText("\n<font color=\"#0000a0\">Lesser Cancer: " + player.cancerScore() + " (+105% to Str racial multi, +80% to Tou racial multi, +55% to Spe racial multi, -30% to Int racial multi, -15% to Wis racial multi)</font>");
		else if (player.cancerScore() >= 8) outputText("\n<font color=\"#0000a0\">Lesser Half Cancer: " + player.cancerScore() + " (+60% to Str racial multi, +55% to Tou racial multi, +20% to Spe racial multi, -15% to Wis racial multi)</font>");
		else if (player.cancerScore() >= 1) outputText("\n<font color=\"#008000\">Lesser Half Cancer: " + player.cancerScore() + "</font>");
		else if (player.cancerScore() < 1) outputText("\n<font color=\"#ff0000\">Lesser Half Cancer: 0</font>");
		//Cat
		if (player.catScore() >= 8) outputText("\n<font color=\"#0000a0\">Cat-girl/Cat-boy/Cat Morph: " + player.catScore() + " (+"+(player.hasPerk(PerkLib.Flexibility) ? "60":"70")+"% to Spe racial multi, +60% to Lib racial multi)</font>");
		else if (player.catScore() >= 4) outputText("\n<font color=\"#0000a0\">Half Cat-morph: " + player.catScore() + " (+"+(player.hasPerk(PerkLib.Flexibility) ? "40":"50")+"% to Spe racial multi, +20% to Lib racial multi)</font>");
		else if (player.catScore() >= 1) outputText("\n<font color=\"#008000\">Half Cat-morph: " + player.catScore() + "</font>");
		else if (player.catScore() < 1) outputText("\n<font color=\"#ff0000\">Half Cat-morph: 0</font>");
		//Cave Wyrm
		if (player.cavewyrmScore() >= 10) outputText("\n<font color=\"#0000a0\">Cave Wyrm: " + player.cavewyrmScore() + " (+60% to Str racial multi, +70% to Tou racial multi, -30% to Wis racial multi, +50% to Lib racial multi)</font>");
		else if (player.cavewyrmScore() >= 5) outputText("\n<font color=\"#0000a0\">Half Cave Wyrm: " + player.cavewyrmScore() + " (+30% to Str racial multi, +35% to Tou racial multi, -15% to Wis racial multi, +25% to Lib racial multi)</font>");
		else if (player.cavewyrmScore() >= 1) outputText("\n<font color=\"#008000\">Half Cave Wyrm: " + player.cavewyrmScore() + "</font>");
		else if (player.cavewyrmScore() < 1) outputText("\n<font color=\"#ff0000\">Half Cave Wyrm: 0</font>");
		//Centaur
		if (player.centaurScore() >= 8) outputText("\n<font color=\"#0000a0\">Centaur: " + player.centaurScore() + " (+40% to Tou racial multi, +80% to Spe racial multi, +100 max HP)</font>");
		else if (player.centaurScore() >= 1) outputText("\n<font color=\"#008000\">Centaur: " + player.centaurScore() + "</font>");
		else if (player.centaurScore() < 1) outputText("\n<font color=\"#ff0000\">Centaur: 0</font>");
		//Centipede
		if (player.centipedeScore() >= 8) outputText("\n<font color=\"#0000a0\">Centipede: " + player.centipedeScore() + " (+60% to Str racial multi, +80% to Spe racial multi)</font>");
		else if (player.centipedeScore() >= 4) outputText("\n<font color=\"#0000a0\">Half Centipede:" + player.centipedeScore() + " (+30% to Str racial multi, +40% to Spe racial multi)</font>");
		else if (player.centipedeScore() >= 1) outputText("\n<font color=\"#008000\">Half Centipede: " + player.centipedeScore() + "</font>");
		else if (player.centipedeScore() < 1) outputText("\n<font color=\"#ff0000\">Half Centipede: 0</font>");
		//Cheshire cat
		if (player.cheshireScore() >= 11) {
			outputText("\n<font color=\"#0000a0\">Cheshire cat: " + player.cheshireScore() + " (+"+(player.hasPerk(PerkLib.Flexibility) ? "60":"70")+"% to Spe racial multi, +80% to Int racial multi, +25 max Sens)</font>");
		}
		else if (player.cheshireScore() >= 1) outputText("\n<font color=\"#008000\">Cheshire cat: " + player.cheshireScore() + "</font>");
		else if (player.cheshireScore() < 1) outputText("\n<font color=\"#ff0000\">Cheshire cat: 0</font>");
		//CHIMERA
		outputText("\nCHIMERA: " + player.chimeraScore());
		//Couatl
		if (player.couatlScore() >= 19) outputText("\n<font color=\"#0000a0\">Greater Couatl: " + player.couatlScore() + " (+"+(player.isNaga() ? "65":"50")+"% to Str racial multi, +45% to Tou racial multi, +"+(player.isNaga() ? "155":"140")+"% to Spe racial multi, +50% to Int racial multi)</font>");//, +50 max HP
		if (player.couatlScore() >= 11) outputText("\n<font color=\"#0000a0\">Couatl: " + player.couatlScore() + " (+"+(player.isNaga() ? "45":"30")+"% to Str racial multi, +25% to Tou racial multi, +"+(player.isNaga() ? "95":"80")+"% to Spe racial multi, +30% to Int racial multi)</font>");//, +50 max HP
		else if (player.couatlScore() >= 1) outputText("\n<font color=\"#008000\">Couatl: " + player.couatlScore() + "</font>");
		else if (player.couatlScore() < 1) outputText("\n<font color=\"#ff0000\">Couatl: 0</font>");
		//Cow
		if (player.cowScore() >= 15) outputText("\n<font color=\"#0000a0\">Lacta Bovine: " + player.cowScore() + " (+170% to Str racial multi, +45% to Tou racial multi, -40% to Spe racial multi, -20% to Int racial multi, +70% to Lib racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.cowScore() >= 10) outputText("\n<font color=\"#0000a0\">Cow-morph: " + player.cowScore() + " (+120% to Str racial multi, +45% to Tou racial multi, -40% to Spe racial multi, -20% to Int racial multi, +45% to Lib racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.cowScore() >= 4) outputText("\n<font color=\"#0000a0\">Half Cow-morph: " + player.cowScore() + " (+60% to Str racial multi, +10% to Tou racial multi, -20% to Spe racial multi, -10% to Int racial multi, +20% to Lib racial multi, +" + (25 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.cowScore() >= 1) outputText("\n<font color=\"#008000\">Half Cow-morph: " + player.cowScore() + "</font>");
		else if (player.cowScore() < 1) outputText("\n<font color=\"#ff0000\">Half Cow-morph: 0</font>");
		//Cyclop
		if (player.cyclopScore() >= 12) outputText("\n<font color=\"#0000a0\">Cyclop: " + player.cyclopScore() + " (+90% to Str racial multi, +90% to Tou racial multi)</font>");
		else if (player.cyclopScore() >= 6) outputText("\n<font color=\"#0000a0\">Half Cyclop: " + player.cyclopScore() + " (+45% to Str racial multi, +45% to Tou racial multi)</font>");
		else if (player.cyclopScore() >= 1) outputText("\n<font color=\"#008000\">Half Cyclop: " + player.cyclopScore() + "</font>");
		else if (player.cyclopScore() < 1) outputText("\n<font color=\"#ff0000\">Half Cyclop: 0</font>");
		//Dark Goo
		if (player.darkgooScore() >= 17) outputText("\n<font color=\"#0000a0\">Dark Slime Queen: " + player.darkgooScore() + " (+115% to Tou racial multi, -50% to Spe racial multi, +45% to Int racial multi, +145% to Lib racial multi)</font>");
		else if (player.darkgooScore() >= 13) outputText("\n<font color=\"#0000a0\">Dark Slime: " + player.darkgooScore() + " (+90% to Tou racial multi, -40% to Spe racial multi, +45% to Int racial multi, +100% to Lib racial multi)</font>");
		else if (player.darkgooScore() >= 6) outputText("\n<font color=\"#0000a0\">Half Dark Slime: " + player.darkgooScore() + " (+45% to Tou racial multi, -20% to Spe racial multi, +15% to Int racial multi, +50% to Lib racial multi)</font>");
		else if (player.darkgooScore() >= 1) outputText("\n<font color=\"#008000\">Half Dark Slime: " + player.darkgooScore() + "</font>");
		else if (player.darkgooScore() < 1) outputText("\n<font color=\"#ff0000\">Half Dark Slime: 0</font>");
		//Deer
		if (player.deerScore() >= 4) outputText("\n<font color=\"#0000a0\">Deer-morph: " + player.deerScore() + " (+20% to Spe racial multi)</font>");
		else if (player.deerScore() >= 1) outputText("\n<font color=\"#008000\">Deer-morph: " + player.deerScore() + "</font>");
		else if (player.deerScore() < 1) outputText("\n<font color=\"#ff0000\">Deer-morph: 0</font>");
		//Demon
		if (player.demonScore() >= 16 && player.hasPerk(PerkLib.Phylactery)) outputText("\n<font color=\"#0000a0\">Succub/Incubus: " + player.demonScore() + " (+30% to Spe racial multi, +35% to Int racial multi, +100% to Lib racial multi, +" + (100 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.demonScore() >= 11) outputText("\n<font color=\"#0000a0\">Succubi-kin/Incubi-kin: " + player.demonScore() + " (+30% to Spe racial multi, +35% to Int racial multi, +100% to Lib racial multi, +" + (100 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.demonScore() >= 5) outputText("\n<font color=\"#0000a0\">Half Succubus/Incubus: " + player.demonScore() + " (+15% to Spe racial multi, +15% to Int racial multi, +45% to Lib racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.demonScore() >= 1) outputText("\n<font color=\"#008000\">Half Succubus/Incubus: " + player.demonScore() + "</font>");
		else if (player.demonScore() < 1) outputText("\n<font color=\"#ff0000\">Half Succubus/Incubus: 0</font>");
		//Devil
		if (player.devilkinScore() >= 16 && player.hasPerk(PerkLib.Phylactery)) {
			if (player.devilkinScore() >= 21) outputText("\n<font color=\"#0000a0\">Archdevil: " + player.devilkinScore() + " (+95% to Str racial multi, -30% to Spe racial multi, +180% to Int racial multi, +120% to Lib racial multi, +50 min Sens, +" + (320 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
			else outputText("\n<font color=\"#0000a0\">Devil: " + player.devilkinScore() + " (+75% to Str racial multi, -25% to Spe racial multi, +130% to Int racial multi, +100% to Lib racial multi, +40 min Sens, +" + (230 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		}
		else if (player.devilkinScore() >= 11) outputText("\n<font color=\"#0000a0\">Devilkin: " + player.devilkinScore() + " (+55% to Str racial multi, -20% to Spe racial multi, +80% to Int racial multi, +65% to Lib racial multi, +15 min Sens, +" + (150 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.devilkinScore() >= 7) outputText("\n<font color=\"#0000a0\">Half fiend: " + player.devilkinScore() + " (+35% to Str racial multi, -10% to Spe racial multi, +50% to Int racial multi, +40% to Lib racial multi, +10 min Sens, +" + (75 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.devilkinScore() >= 1) outputText("\n<font color=\"#008000\">Half fiend: " + player.devilkinScore() + "</font>");
		else if (player.devilkinScore() < 1) outputText("\n<font color=\"#ff0000\">Half fiend: 0</font>");
		//Displacer beast
		if (player.displacerbeastScore() >= 20) outputText("\n<font color=\"#0000a0\">Displacer Beast: " + player.displacerbeastScore() + " (+140% to Str racial multi, +"+(player.hasPerk(PerkLib.Flexibility) ? "150":"140")+"% to Spe racial multi, -30% to Int racial multi, -30% to Wis racial multi, +80% to Lib racial multi)</font>");
		else if (player.displacerbeastScore() >= 14) outputText("\n<font color=\"#0000a0\">Displacer Beast: " + player.displacerbeastScore() + " (+95% to Str racial multi, +"+(player.hasPerk(PerkLib.Flexibility) ? "100":"110")+"% to Spe racial multi, -25% to Int racial multi, -20% to Wis racial multi, +60% to Lib racial multi)</font>");
		else if (player.displacerbeastScore() >= 1) outputText("\n<font color=\"#008000\">Displacer Beast: " + player.displacerbeastScore() + "</font>");
		else if (player.displacerbeastScore() < 1) outputText("\n<font color=\"#ff0000\">Displacer Beast: 0</font>");
		//Dog
		if (player.dogScore() >= 4) outputText("\n<font color=\"#0000a0\">Dog-morph: " + player.dogScore() + " (+15% to Spe racial multi, -5% to Int racial multi)</font>");
		else if (player.dogScore() >= 1) outputText("\n<font color=\"#008000\">Dog-morph: " + player.dogScore() + "</font>");
		else if (player.dogScore() < 1) outputText("\n<font color=\"#ff0000\">Dog-morph: 0</font>");
		//Dragon
		if (player.dragonScore() >= 32) {
			outputText("\n<font color=\"#0000a0\">Ancient Dragon: " + player.dragonScore() + " (+100% to Str / Tou / Spe racial multi, +80% to Int / Wis racial multi, +60% to Lib racial multi, +40 to min Sen, ");
			outputText("+30% max HP, +" + (50 * (1 + player.newGamePlusMod())) + " max Lust, +" + (200 * (1 + player.newGamePlusMod())) + " max Fatigue, +" + (10 * (1 + player.newGamePlusMod())) + " Armor / Magic Resistance)</font>");
		}
		else if (player.dragonScore() >= 24) {
			outputText("\n<font color=\"#0000a0\">Elder Dragon: " + player.dragonScore() + " (+80% to Str / Tou / Spe racial multi, +70% to Int / Wis racial multi, +40% to Lib racial multi, +30 to min Sen, ");
			outputText("+20% max HP, +" + (25 * (1 + player.newGamePlusMod())) + " max Lust, +" + (100 * (1 + player.newGamePlusMod())) + " max Fatigue, +" + (4 * (1 + player.newGamePlusMod())) + " Armor / Magic Resistance)</font>");
		}
		else if (player.dragonScore() >= 16) outputText("\n<font color=\"#0000a0\">Dragon: " + player.dragonScore() + " (+50% to Str / Tou / Spe racial multi, +40% to Int / Wis racial multi, +30% to Lib racial multi, +20 to min Sen, +10% max HP, +" + (1 + player.newGamePlusMod()) + " Armor / Magic Resistance)</font>");
		else if (player.dragonScore() >= 8) outputText("\n<font color=\"#0000a0\">Half-Dragon: " + player.dragonScore() + " (+25% to Str / Tou / Spe racial multi, +20% to Int / Wis / Lib racial multi, +15 to min Sen, +5% max HP)</font>");
		else if (player.dragonScore() >= 1) outputText("\n<font color=\"#008000\">Half-Dragon: " + player.dragonScore() + "</font>");
		else if (player.dragonScore() < 1) outputText("\n<font color=\"#ff0000\">Half-Dragon: 0</font>");
		//Dragonne
		outputText("\nDragonne: " + player.dragonneScore());
		//Easter Bunny
		if (player.easterbunnyScore() >= 1) {
			if (player.hasPerk(PerkLib.EasterBunnyBalls)) {
				if (player.easterbunnyScore() >= 15) outputText("\n<font color=\"#0000a0\">True Easter Bunny: " + player.easterbunnyScore() + " (-20% to Str racial multi, -10% to Tou racial multi, +105% to Spe racial multi, +150% to Lib racial multi)</font>");
				else if (player.easterbunnyScore() >= 12) outputText("\n<font color=\"#0000a0\">Easter Bunny: " + player.easterbunnyScore() + " (-20% to Str racial multi, -10% to Tou racial multi, +90% to Spe racial multi, +120% to Lib racial multi)</font>");
				else if (player.easterbunnyScore() >= 1) outputText("\n<font color=\"#008000\">Easter Bunny: " + player.easterbunnyScore() + "</font>");
			}
			else outputText("\n<font color=\"#ff0000\">Easter Bunny (Require Easter bunny balls): " + player.easterbunnyScore() + "</font>");
		}
		else if (player.easterbunnyScore() < 1) outputText("\n<font color=\"#ff0000\">Easter Bunny (Require Easter bunny balls): 0</font>");
		//Echidna
		outputText("\nEchidna: " + player.echidnaScore());
		//Elf
		if (player.elfScore() >= 11) outputText("\n<font color=\"#0000a0\">Elf: " + player.elfScore() + " (-10% to Str racial multi, -15% to Tou racial multi, +80% to Spe / Int racial multi, +60% to Wis racial multi, +30 min Sens, +20% max Mana)</font>");
		else if (player.elfScore() >= 5) outputText("\n<font color=\"#0000a0\">Half Elf: " + player.elfScore() + " (-5% to Str racial multi, -10% to Tou racial multi, +45% to Spe / Int racial multi, +30% to Wis racial multi, +15 min Sens, +10% max Mana)</font>");
		else if (player.elfScore() >= 1) outputText("\n<font color=\"#008000\">Half Elf: " + player.elfScore() + "</font>");
		else if (player.elfScore() < 1) outputText("\n<font color=\"#ff0000\">Half Elf: 0</font>");
		//Wood Elf
		if (player.woodElfScore() >= 25) outputText("\n<font color=\"#0000a0\">Wood Elf: " + player.woodElfScore() + " (-10% to Str racial multi, -15% to Tou racial multi, +150% to Spe racial multi, +125% to Int racial multi, +100% to Lib racial multi, +50 min Sens, +20% max Mana)</font>");
		else if (player.woodElfScore() >= 17) outputText("\n<font color=\"#0000a0\">Wood Elf little sister: " + player.woodElfScore() + " (-10% to Str racial multi, -15% to Tou racial multi, +100% to Spe / Int / Lib racial multi, +50 min Sens, +10% max Mana)</font>");
		else if (player.woodElfScore() >= 1) outputText("\n<font color=\"#008000\">Wood Elf: " + player.woodElfScore() + "</font>");
		else if (player.woodElfScore() < 1) outputText("\n<font color=\"#ff0000\">Wood Elf: 0</font>");
		//Ferret
		outputText("\nFerret-morph: " + player.ferretScore());
		//Fire snail
		if (player.firesnailScore() >= 15) outputText("\n<font color=\"#0000a0\">Fire Snail: " + player.firesnailScore() + " (+70% to Str racial multi, +175% to Tou racial multi, -80% to Spe racial multi, +110% to Lib racial multi, +50 min Sens)</font>");
		else if (player.firesnailScore() >= 1) outputText("\n<font color=\"#008000\">Fire Snail: " + player.firesnailScore() + "</font>");
		else if (player.firesnailScore() < 1) outputText("\n<font color=\"#ff0000\">Fire Snail: 0</font>");
		//Fox
		if (player.foxScore() >= 7) outputText("\n<font color=\"#0000a0\">Fox-morph: " + player.foxScore() + " (-30% to Str racial multi, +80% to Spe racial multi, +55% to Int racial multi, +" + (20 * (1 + player.newGamePlusMod())) + " max Fatigue)</font>");
		else if (player.foxScore() >= 4) outputText("\n<font color=\"#0000a0\">Half Fox: " + player.foxScore() + " (-5% to Str racial multi, +40% to Spe racial multi, +25% to Int racial multi)</font>");
		else if (player.foxScore() >= 1) outputText("\n<font color=\"#008000\">Half Fox: " + player.foxScore() + "</font>");
		else if (player.foxScore() < 1) outputText("\n<font color=\"#ff0000\">Half Fox: 0</font>");
		//Fairy
		if (player.fairyScore() >= 32) outputText("\n<font color=\"#0000a0\">Titania: " + player.fairyScore() + " (-20% to Str racial multi, -10% to Tou racial multi, +660% to Spe racial multi, +660% to Int racial multi, +200% to Wis racial multi, +50 Sens)</font>");
		if (player.fairyScore() >= 29) outputText("\n<font color=\"#0000a0\">Fairy Queen: " + player.fairyScore() + " (-20% to Str racial multi, -10% to Tou racial multi, +600% to Spe racial multi, +600% to Int racial multi, +175% to Wis racial multi, +40 Sens)</font>");
		if (player.fairyScore() >= 26) outputText("\n<font color=\"#0000a0\">Noble Fairy: " + player.fairyScore() + " (-20% to Str racial multi, -10% to Tou racial multi, +540% to Spe racial multi, +540% to Int racial multi, +150% to Wis racial multi, +30 Sens)</font>");
		if (player.fairyScore() >= 23) outputText("\n<font color=\"#0000a0\">Greater Fairy: " + player.fairyScore() + " (-20% to Str racial multi, -10% to Tou racial multi, +480% to Spe racial multi, +480% to Int racial multi, +125% to Wis racial multi, +20 Sens)</font>");
		else if (player.fairyScore() >= 1) outputText("\n<font color=\"#008000\">Fairy: " + player.fairyScore() + "</font>");
		else if (player.fairyScore() < 1) outputText("\n<font color=\"#ff0000\">Fairy: 0</font>");
		//Frost Wyrm
		if (player.frostWyrmScore() >= 26) outputText("\n<font color=\"#0000a0\">Greater Frost Wyrm: " + player.frostWyrmScore() + " (+200% to Str racial multi, +90% to Spe racial multi, +160% to Tou racial multi, -90% to Int racial multi, +75% to Lib racial multi)</font>");
		else if (player.frostWyrmScore() >= 18) outputText("\n<font color=\"#0000a0\">Frost Wyrm: " + player.frostWyrmScore() + " (+140% to Str racial multi, +75% to Spe racial multi, +125% to Tou racial multi, -90% to Int racial multi, +50% to Lib racial multi)</font>");
		else if (player.frostWyrmScore() >= 10) outputText("\n<font color=\"#0000a0\">Half Frost Wyrm: " + player.frostWyrmScore() + " (+90% to Str racial multi, +60% to Spe racial multi, +60% to Tou racial multi, -90% to Int racial multi, +30% to Lib racial multi)</font>");
		else if (player.frostWyrmScore() >= 1) outputText("\n<font color=\"#008000\">Half Frost Wyrm: " + player.frostWyrmScore() + "</font>");
		else if (player.frostWyrmScore() < 1) outputText("\n<font color=\"#ff0000\">Half Frost Wyrm: 0</font>");
		//GARGOYLE
		if (player.gargoyleScore() >= 20 && (player.hasPerk(PerkLib.GargoylePure) || player.hasPerk(PerkLib.GargoyleCorrupted))) {
			outputText("\n<font color=\"#0000a0\">" + (player.hasPerk(PerkLib.GargoylePure) ? "PURE":"CORRUPTED") + " GARGOYLE: " + player.gargoyleScore() + " (+");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) outputText("300% to Str racial multi, +510% to Tou racial multi, +100% to Spe racial multi, +80% to Int racial multi, ");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) outputText("100% to Str racial multi, +510% to Tou racial multi, +80% to Spe racial multi, +300% to Int racial multi, ");
			if (player.hasPerk(PerkLib.GargoylePure)) outputText("+130% to Wis racial multi, -20% to Lib racial multi, -10 Sens, +");
			if (player.hasPerk(PerkLib.GargoyleCorrupted)) outputText("-20% to Wis racial multi, +140% to Lib racial multi, +");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) outputText("" + (150 * (1 + player.newGamePlusMod())) + " Armor, +" + (25 * (1 + player.newGamePlusMod())) + " spell resistance");
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) outputText("" + (25 * (1 + player.newGamePlusMod())) + " Armor, +" + (150 * (1 + player.newGamePlusMod())) + " spell resistance");
			outputText(")</font>");
		}
		else if (player.gargoyleScore() >= 1) outputText("\n<font color=\"#008000\">GARGOYLE: " + player.gargoyleScore() + "</font>");
		else if (player.gargoyleScore() < 1) outputText("\n<font color=\"#ff0000\">GARGOYLE: 0</font>");
		//Gazer
		if (player.gazerScore() >= 21 && player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 10) outputText("\n<font color=\"#0000a0\">Eye Tyrant: " + player.gazerScore() + " (+80% to Tou racial multi, -75% to Spe racial multi, +180% to Int racial multi, +130% to Lib racial multi)</font>");
		else if (player.gazerScore() >= 14 && player.statusEffectv1(StatusEffects.GazerEyeStalksPlayer) >= 6) outputText("\n<font color=\"#0000a0\">Gazer: " + player.gazerScore() + " (+55% to Tou racial multi, -65% to Spe racial multi, +130% to Int racial multi, +90% to Lib racial multi)</font>");
		else if (player.gazerScore() >= 7) outputText("\n<font color=\"#0000a0\">Half Gazer: " + player.gazerScore() + " (+30% to Tou racial multi, -55% to Spe racial multi, +80% to Int racial multi, +50% to Lib racial multi)</font>");
		else if (player.gazerScore() >= 1) outputText("\n<font color=\"#008000\">Half Gazer: " + player.gazerScore() + "</font>");
		else if (player.gazerScore() < 1) outputText("\n<font color=\"#ff0000\">Half Gazer: 0</font>");
		//Goblin
		if (player.goblinScore() >= 10) outputText("\n<font color=\"#0000a0\">Goblin: " + player.goblinScore() + " (-50% to Str racial multi, +75% to Spe racial multi, +100% to Int racial multi, +25% to Lib racial multi)</font>");
		else if (player.goblinScore() >= 1) outputText("\n<font color=\"#008000\">Goblin: " + player.goblinScore() + "</font>");
		else if (player.goblinScore() < 1) outputText("\n<font color=\"#ff0000\">Goblin: 0</font>");
		//Gremlin
		if (player.gremlinScore() >= 18) outputText("\n<font color=\"#0000a0\">High Gremlin: " + player.gremlinScore() + " (-50% to Str racial multi, +90% to Spe racial multi, +135% to Int racial multi, +100% to Lib racial multi, +20 min sens)</font>");
		if (player.gremlinScore() >= 15) outputText("\n<font color=\"#0000a0\">Gremlin: " + player.gremlinScore() + " (-50% to Str racial multi, +75% to Spe racial multi, +120% to Int racial multi, +115% to Lib racial multi, +20 min sens)</font>");
		else if (player.gremlinScore() >= 1) outputText("\n<font color=\"#008000\">Gremlin: " + player.gremlinScore() + "</font>");
		else if (player.gremlinScore() < 1) outputText("\n<font color=\"#ff0000\">Gremlin: 0</font>");
		//Goo
		if (player.gooScore() >= 15) outputText("\n<font color=\"#0000a0\">Slime Queen: " + player.gooScore() + " (+115% to Tou racial multi, -50% to Spe racial multi, +160% to Lib racial multi)</font>");
		else if (player.gooScore() >= 11) outputText("\n<font color=\"#0000a0\">Slime: " + player.gooScore() + " (+105% to Tou racial multi, -40% to Spe racial multi, +100% to Lib racial multi)</font>");
		else if (player.gooScore() >= 5) outputText("\n<font color=\"#0000a0\">Half Slime: " + player.gooScore() + " (+45% to Tou racial multi, -20% to Spe racial multi, +50% to Lib racial multi)</font>");
		else if (player.gooScore() >= 1) outputText("\n<font color=\"#008000\">Half Slime: " + player.gooScore() + "</font>");
		else if (player.gooScore() < 1) outputText("\n<font color=\"#ff0000\">Half Slime: 0</font>");
		//Gorgon
		if (player.gorgonScore() >= 17) outputText("\n<font color=\"#0000a0\">Greater Gorgon: " + player.gorgonScore() + " (+"+(player.isNaga() ? "95":"80")+"% to Str racial multi, +65% to Tou racial multi, +"+(player.isNaga() ? "125":"110")+"% to Spe racial multi, +" + (100 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		if (player.gorgonScore() >= 11) outputText("\n<font color=\"#0000a0\">Gorgon: " + player.gorgonScore() + " (+"+(player.isNaga() ? "65":"50")+"% to Str racial multi, +45% to Tou racial multi, +"+(player.isNaga() ? "85":"70")+"% to Spe racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		else if (player.gorgonScore() >= 1) outputText("\n<font color=\"#008000\">Gorgon: " + player.gorgonScore() + "</font>");
		else if (player.gorgonScore() < 1) outputText("\n<font color=\"#ff0000\">Gorgon: 0</font>");
		//GRAND CHIMERA
		outputText("\nGRAND CHIMERA: " + player.grandchimeraScore());
		//Harpy
		if (player.harpyScore() >= 15) outputText("\n<font color=\"#0000a0\">Harpy Queen: " + player.harpyScore() + " (-30% to Tou racial multi, +150% to Spe racial multi, +105% to Lib racial multi)</font>");
		else if (player.harpyScore() >= 8) outputText("\n<font color=\"#0000a0\">Harpy: " + player.harpyScore() + " (-20% to Tou racial multi, +80% to Spe racial multi, +60% to Lib racial multi)</font>");
		else if (player.harpyScore() >= 4) outputText("\n<font color=\"#0000a0\">Half Harpy: " + player.harpyScore() + " (-10% to Tou racial multi, +40% to Spe racial multi, +30% to Lib racial multi)</font>");
		else if (player.harpyScore() >= 1) outputText("\n<font color=\"#008000\">Half Harpy: " + player.harpyScore() + "</font>");
		else if (player.harpyScore() < 1) outputText("\n<font color=\"#ff0000\">Half Harpy: 0</font>");
		//Hellcat
		if (player.hellcatScore() >= 17 && player.tailType == Tail.TWINKASHA && player.tailCount == 2) {
			outputText("\n<font color=\"#0000a0\">Kasha: " + player.hellcatScore() + " (+");
			if (player.hasPerk(PerkLib.Flexibility)) {
				if (player.hasPerk(PerkLib.CatlikeNimblenessFinalForm)) outputText("100");
				else if (player.hasPerk(PerkLib.CatlikeNimblenessEvolved)) outputText("90");
				else outputText("80");
			}
			else outputText("70");
			outputText("% to Spe racial multi, +135% to Int racial multi, +100% to Lib racial multi, +50 min/max Sens)</font>");
		}
		else if (player.hellcatScore() >= 10) {
			outputText("\n<font color=\"#0000a0\">Hellcat: " + player.hellcatScore() + " (+");
			if (player.hasPerk(PerkLib.Flexibility)) {
				if (player.hasPerk(PerkLib.CatlikeNimblenessFinalForm)) outputText("70");
				else if (player.hasPerk(PerkLib.CatlikeNimblenessEvolved)) outputText("60");
				else outputText("50");
			}
			else outputText("40");
			outputText("% to Spe racial multi, +70% to Int racial multi, +40% to Lib racial multi, +25 min/max Sens)</font>");
		}
		else if (player.hellcatScore() >= 1 && player.hellcatScore() < 10) outputText("\n<font color=\"#008000\">Hellcat: " + player.hellcatScore() + "</font>");
		else if (player.hellcatScore() < 1) outputText("\n<font color=\"#ff0000\">Hellcat: 0</font>");
		//Horse
		if (player.horseScore() >= 7) outputText("\n<font color=\"#0000a0\">Horse-morph: " + player.horseScore() + " (+35% to Tou racial multi, +70% to Spe racial multi, +" + (70 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		else if (player.horseScore() >= 4) outputText("\n<font color=\"#0000a0\">Half Horse-morph: " + player.horseScore() + " (+20% to Tou racial multi, +40% to Spe racial multi, +" + (35 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		else if (player.horseScore() >= 1) outputText("\n<font color=\"#008000\">Half Horse-morph: " + player.horseScore() + "</font>");
		else if (player.horseScore() < 1) outputText("\n<font color=\"#ff0000\">Half Horse-morph: 0</font>");
		//HUMANITY
		if (player.humanScore() == player.humanMaxScore()) outputText("\n<font color=\"#0000a0\">HUMANITY: " + player.humanMaxScore() + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 1) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 1) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 2) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 2) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 3) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 3) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 4) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 4) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 5) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 5) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 6) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 6) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 7) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 7) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 8) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 8) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() == player.humanMaxScore() - 9) outputText("\n<font color=\"#0000a0\">HUMANITY: " + (player.humanMaxScore() - 9) + " (+" + monster.humanityBoostExpValue() + " bonus EXP gains)</font>");
		else if (player.humanScore() < player.humanMaxScore() - 9) outputText("\n<font color=\"#008000\">HUMANITY: " + player.humanScore() + "</font>");
		//Hydra
		if (player.hydraScore() >= 14) {
			if (player.lowerBody == LowerBody.HYDRA) {
				if (player.hydraScore() >= 29) outputText("\n<font color=\"#0000a0\">Legendary Hydra: " + player.hydraScore() + " (+"+(player.isNaga() ? "175":"160")+"% to Str racial multi, +145% to Tou racial multi, +"+(player.isNaga() ? "145":"130")+"% to Spe racial multi)</font>");
				else if (player.hydraScore() >= 24) outputText("\n<font color=\"#0000a0\">Ancient Hydra: " + player.hydraScore() + " (+"+(player.isNaga() ? "145":"130")+"% to Str racial multi, +125% to Tou racial multi, +"+(player.isNaga() ? "120":"105")+"% to Spe racial multi)</font>");
				else if (player.hydraScore() >= 19) outputText("\n<font color=\"#0000a0\">Greater Hydra: " + player.hydraScore() + " (+"+(player.isNaga() ? "135":"120")+"% to Str racial multi, +105% to Tou racial multi, +"+(player.isNaga() ? "75":"60")+"% to Spe racial multi)</font>");
				else outputText("\n<font color=\"#0000a0\">Hydra: " + player.hydraScore() + " (+"+(player.isNaga() ? "115":"00")+"% to Str racial multi, +50% to Tou racial multi, +"+(player.isNaga() ? "75":"60")+"% to Spe racial multi)</font>");
			}
			else outputText("\n<font color=\"#008000\">Hydra: " + player.hydraScore() + "</font>");
		}
		else if (player.hydraScore() >= 1) outputText("\n<font color=\"#008000\">Hydra: " + player.hydraScore() + "</font>");
		else if (player.hydraScore() < 1) outputText("\n<font color=\"#ff0000\">Hydra: 0</font>");
		//INTERNAL CHIMERICAL DISPOSITION
		if (player.internalChimeraScore() >= 1) outputText("\n<font color=\"#0000a0\">INTERNAL CHIMERICAL DISPOSITION: (" + player.internalChimeraRating() + ") " + player.internalChimeraScore() + " (+" + (5 * player.internalChimeraScore()) + "% to Str racial multi / Tou / Spe / Int / Wis / Lib and +" + (5 * player.internalChimeraScore()) + " to Sens)</font>");
		else if (player.internalChimeraScore() < 1) outputText("\nINTERNAL CHIMERICAL DISPOSITION: 0</font>");
		//Jabberwocky
		if (player.jabberwockyScore() >= 25) outputText("\n<font color=\"#0000a0\">Greater Jabberwocky: " + player.jabberwockyScore() + " (+125% to Str racial multi, +95% to Tou racial multi, +145% to Spe racial multi, +40% to Int racial multi, -50% to Wis racial multi, +20% to Lib racial multi)</font>");
		else if (player.jabberwockyScore() >= 20) outputText("\n<font color=\"#0000a0\">Jabberwocky: " + player.jabberwockyScore() + " (+95% to Str racial multi, +95% to Tou racial multi, +100% to Spe racial multi, +40% to Int racial multi, -50% to Wis racial multi, +20% to Lib racial multi)</font>");
		else if (player.jabberwockyScore() >= 10) outputText("\n<font color=\"#0000a0\">Lesser Jabberwocky: " + player.jabberwockyScore() + " (+50% to Str racial multi, +40% to Tou racial multi, +50% to Spe racial multi, +20% to Int racial multi, -20% to Wis racial multi, +10% to Lib racial multi)</font>");
		else if (player.jabberwockyScore() >= 1) outputText("\n<font color=\"#008000\">Lesser Jabberwocky: " + player.jabberwockyScore() + "</font>");
		else if (player.jabberwockyScore() < 1) outputText("\n<font color=\"#ff0000\">Jabberwocky: 0</font>");
		//Jiangshi
		if (player.jiangshiScore() >= 20) outputText("\n<font color=\"#0000a0\">Jiangshi: " + player.jiangshiScore() + " (+150% to Str racial multi, -90 min Spe, -90 min Int, +130% to Wis racial multi, +200% to Lib racial multi)</font>");
		else if (player.jiangshiScore() < 20) outputText("\n<font color=\"#008000\">Jiangshi: " + player.jiangshiScore() + "</font>");
		//Kamaitachi
		if (player.kamaitachiScore() >= 18) outputText("\n<font color=\"#0000a0\">Greater Kamaitachi: " + player.kamaitachiScore() + " (-35% to Str racial multi, +200% to Spe racial multi, +55% to Int racial multi, +100% to Wis racial multi, +50 sens)</font>");
		else if (player.kamaitachiScore() >= 14) outputText("\n<font color=\"#0000a0\">Kamaitachi: " + player.kamaitachiScore() + " (-20% to Str racial multi, +140% to Spe racial multi, +45% to Int racial multi, +70% to Wis racial multi, +25 sens)</font>");
		else if (player.kamaitachiScore() >= 7) outputText("\n<font color=\"#0000a0\">Half Kamaitachi: " + player.kamaitachiScore() + " (-10% to Str racial multi, +65% to Spe racial multi, +20% to Int racial multi, +35% to Wis racial multi, +10 sens)</font>");
		else if (player.kamaitachiScore() >= 1) outputText("\n<font color=\"#008000\">Half Kamaitachi: " + player.kamaitachiScore() + "</font>");
		else if (player.kamaitachiScore() < 1) outputText("\n<font color=\"#ff0000\">Half Kamaitachi: 0</font>");
		//Kangaroo
		if (player.kangaScore() >= 4) outputText("\n<font color=\"#0000a0\">Kangaroo-morph: " + player.kangaScore() + " (+5% to Tou racial multi, +15% to Spe racial multi)</font>");
		else if (player.kangaScore() >= 1) outputText("\n<font color=\"#008000\">Kangaroo-morph: " + player.kangaScore() + "</font>");
		else if (player.kangaScore() < 1) outputText("\n<font color=\"#ff0000\">Kangaroo-morph: 0</font>");
		//Kitshoo
		//if (player.kitshooScore() >= 6) outputText("\n<font color=\"#0000a0\">Kitshoo: " + player.kitshooScore() + "</font>");
		//else if (player.kitshooScore() >= 1) outputText("\n<font color=\"#008000\">Kitshoo: " + player.kitshooScore() + "</font>");
		//else if (player.kitshooScore() < 1) outputText("\n<font color=\"#ff0000\">Kitshoo: 0</font>");
		//Kitsune
		if (player.kitsuneScore() >= 9 && player.tailType == Tail.FOX && player.tailCount >= 2) {
			if (player.kitsuneScore() >= 16 && player.tailCount == 9) {
				if (player.kitsuneScore() >= 21 && player.hasPerk(PerkLib.NinetailsKitsuneOfBalance)) {
					if (player.kitsuneScore() >= 26 && player.tailCount >= 9) outputText("\n<font color=\"#0000a0\">Inari: " + player.kitsuneScore() + " (-50% to Str racial multi, +50% to Spe racial multi, +140% to Int racial multi, +200% to Wis racial multi, +110% to Lib racial multi, +60 to min Sens, +" + (1000 * (1 + player.newGamePlusMod())) + " max Fatigue, +100% max Soulforce)</font>");
					else outputText("\n<font color=\"#0000a0\">Nine Tails Kitsune of Balance: " + player.kitsuneScore() + " (-45% to Str racial multi, +40% to Spe racial multi, +125% to Int racial multi, +160% to Wis racial multi, +80% to Lib racial multi, +45 to min Sens, +" + (500 * (1 + player.newGamePlusMod())) + " max Fatigue, +65% max Soulforce)</font>");
				}
				else outputText("\n<font color=\"#0000a0\">Nine Tails Kitsune: " + player.kitsuneScore() + " (-40% to Str racial multi, +30% to Spe racial multi, +110% to Int racial multi, +125% to Wis racial multi, +45% to Lib racial multi, +30 to min Sens, +" + (300 * (1 + player.newGamePlusMod())) + " max Fatigue, +40% max Soulforce)</font>");
			}
			else outputText("\n<font color=\"#0000a0\">Kitsune: " + player.kitsuneScore() + " (-35% to Str racial multi, +25% to Spe racial multi, +60% to Int racial multi, +75% to Wis racial multi, +30% to Lib racial multi, +20 to min Sens, +" + (100 * (1 + player.newGamePlusMod())) + " max Fatigue, +20% max Soulforce)</font>");
		}
		else if (player.kitsuneScore() >= 5) outputText("\n<font color=\"#0000a0\">Half Kitsune: " + player.kitsuneScore() + " (-30% to Str racial multi, +20% to Spe racial multi, +35% to Int racial multi, +40% to Wis racial multi, +25% to Lib racial multi, +15 to min Sens, +" + (50 * (1 + player.newGamePlusMod())) + " max Fatigue, +10% max Soulforce)</font>");
		else if (player.kitsuneScore() >= 1) outputText("\n<font color=\"#008000\">Half Kitsune: " + player.kitsuneScore() + "</font>");
		else if (player.kitsuneScore() < 1) outputText("\n<font color=\"#ff0000\">Half Kitsune: 0</font>");
		//Lizard
		if (player.lizardScore() >= 8) outputText("\n<font color=\"#0000a0\">Lizard-morph: " + player.lizardScore() + " (+70% to Tou racial multi, +50% to Int racial multi, +" + (30 * (1 + player.newGamePlusMod())) + " max Fatigue)</font>");
		else if (player.lizardScore() >= 4) outputText("\n<font color=\"#0000a0\">Half Lizard-morph: " + player.lizardScore() + " (+40% to Tou racial multi, +20% to Int racial multi, +" + (30 * (1 + player.newGamePlusMod())) + " max Fatigue)</font>");
		else if (player.lizardScore() >= 1) outputText("\n<font color=\"#008000\">Half Lizard-morph: " + player.lizardScore() + "</font>");
		else if (player.lizardScore() < 1) outputText("\n<font color=\"#ff0000\">Half Lizard-morph: 0</font>");
		//Magma Goo
		if (player.magmagooScore() >= 17) outputText("\n<font color=\"#0000a0\">Magma Slime Queen: " + player.magmagooScore() + " (+45% to Str racial multi, +115% to Tou racial multi, -50% to Spe racial multi, +145% to Lib racial multi)</font>");
		else if (player.magmagooScore() >= 13) outputText("\n<font color=\"#0000a0\">Magma Slime: " + player.magmagooScore() + " (+35% to Str racial multi, +100% to Tou racial multi, -40% to Spe racial multi, +100% to Lib racial multi)</font>");
		else if (player.magmagooScore() >= 6) outputText("\n<font color=\"#0000a0\">Half Magma Slime: " + player.magmagooScore() + " (+15% to Str racial multi, +45% to Tou racial multi, -20% to Spe racial multi, +50% to Lib racial multi)</font>");
		else if (player.magmagooScore() >= 1) outputText("\n<font color=\"#008000\">Half Magma Slime: " + player.magmagooScore() + "</font>");
		else if (player.magmagooScore() < 1) outputText("\n<font color=\"#ff0000\">Half Magma Slime: 0</font>");
		//Manticore
		if (player.manticoreScore() >= 22) outputText("\n<font color=\"#0000a0\">True Manticore: " + player.manticoreScore() + " (+160% to Spe racial multi, +90% to Int racial multi, +140% to Lib racial multi, +60 min Sens, +" + (150 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		else if (player.manticoreScore() >= 15) outputText("\n<font color=\"#0000a0\">Manticore: " + player.manticoreScore() + " (+110% to Spe racial multi, +70% to Int racial multi, +90% to Lib racial multi, +45 min Sens, +" + (100 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		else if (player.manticoreScore() >= 7) outputText("\n<font color=\"#0000a0\">Half Manticore: " + player.manticoreScore() + " (+65% to Spe racial multi, +30% to Int racial multi, +40% to Lib racial multi, +30 min Sens, +" + (50 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		else if (player.manticoreScore() >= 1) outputText("\n<font color=\"#008000\">Half Manticore: " + player.manticoreScore() + "</font>");
		else if (player.manticoreScore() < 1) outputText("\n<font color=\"#ff0000\">Half Manticore: 0</font>");
		//Mantis
		if (player.mantisScore() >= 12) {
			outputText("\n<font color=\"#0000a0\">Mantis-morph: " + player.mantisScore() + " (-40% to Str racial multi, +60% to Tou racial multi, +");
			if (player.hasPerk(PerkLib.MantislikeAgilityFinalForm)) {
				if (player.hasCoatOfType(Skin.CHITIN) && player.hasPerk(PerkLib.ThickSkin)) outputText("185");
				else if ((player.skinType == Skin.SCALES && player.hasPerk(PerkLib.ThickSkin)) || player.hasCoatOfType(Skin.CHITIN)) outputText("170");
				else if (player.skinType == Skin.SCALES || player.hasPerk(PerkLib.ThickSkin)) outputText("155");
				else outputText("140");
			}
			else if (player.hasPerk(PerkLib.MantislikeAgilityEvolved)) {
				if (player.hasCoatOfType(Skin.CHITIN) && player.hasPerk(PerkLib.ThickSkin)) outputText("170");
				else if ((player.skinType == Skin.SCALES && player.hasPerk(PerkLib.ThickSkin)) || player.hasCoatOfType(Skin.CHITIN)) outputText("160");
				else if (player.skinType == Skin.SCALES || player.hasPerk(PerkLib.ThickSkin)) outputText("150");
				else outputText("140");
			}
			else if (player.hasPerk(PerkLib.MantislikeAgility)) {
				if (player.hasCoatOfType(Skin.CHITIN) && player.hasPerk(PerkLib.ThickSkin)) outputText("155");
				else if ((player.skinType == Skin.SCALES && player.hasPerk(PerkLib.ThickSkin)) || player.hasCoatOfType(Skin.CHITIN)) outputText("150");
				else if (player.skinType == Skin.SCALES || player.hasPerk(PerkLib.ThickSkin)) outputText("145");
				else outputText("140");
			}
			else outputText("140");
			outputText("% to Spe racial multi, +20% to Int racial multi)</font>");
		}
		else if (player.mantisScore() >= 6) {
			outputText("\n<font color=\"#0000a0\">Half Mantis-morph: " + player.mantisScore() + " (-20% to Str racial multi, +30% to Tou racial multi, +");
			if (player.hasPerk(PerkLib.MantislikeAgilityEvolved)) {
				if (player.hasCoatOfType(Skin.CHITIN) && player.hasPerk(PerkLib.ThickSkin)) outputText("100");
				else if ((player.skinType == Skin.SCALES && player.hasPerk(PerkLib.ThickSkin)) || player.hasCoatOfType(Skin.CHITIN)) outputText("90");
				else if (player.skinType == Skin.SCALES || player.hasPerk(PerkLib.ThickSkin)) outputText("80");
				else outputText("70");
			} else if (player.hasPerk(PerkLib.MantislikeAgility)) {
				if (player.hasCoatOfType(Skin.CHITIN) && player.hasPerk(PerkLib.ThickSkin)) outputText("85");
				else if ((player.skinType == Skin.SCALES && player.hasPerk(PerkLib.ThickSkin)) || player.hasCoatOfType(Skin.CHITIN)) outputText("80");
				else if (player.skinType == Skin.SCALES || player.hasPerk(PerkLib.ThickSkin)) outputText("75");
				else outputText("70 ");
			}
			else outputText("70");
			outputText("% to Spe racial multi, +10% to Int racial multi)</font>");
		}
		else if (player.mantisScore() >= 1) outputText("\n<font color=\"#008000\">Half Mantis-morph: " + player.mantisScore() + "</font>");
		else if (player.mantisScore() < 1) outputText("\n<font color=\"#ff0000\">Half Mantis-morph: 0</font>");
		//Melkie
		if (player.melkieScore() >= 21) outputText("\n<font color=\"#0000a0\">Elder Melkie: " + player.melkieScore() + " (+140% to Spe / Int racial multi, +100% to Lib racial multi, +65 min Sens)</font>");
		else if (player.melkieScore() >= 18) outputText("\n<font color=\"#0000a0\">Melkie: " + player.melkieScore() + " (+120% to Spe / Int racial multi, +80% to Lib racial multi, +50 min Sens)</font>");
		else if (player.melkieScore() >= 8) outputText("\n<font color=\"#0000a0\">Half Melkie: " + player.melkieScore() + " (+55% to Spe / Int racial multi, +35% to Lib racial multi, +25 min Sens)</font>");
		else if (player.melkieScore() >= 1) outputText("\n<font color=\"#008000\">Half Melkie: " + player.melkieScore() + "</font>");
		else if (player.melkieScore() < 1) outputText("\n<font color=\"#ff0000\">Half Melkie: 0</font>");
		//Minotaur
		if (player.minotaurScore() >= 15) outputText("\n<font color=\"#0000a0\">Minotaur: " + player.minotaurScore() + " (+170% to Str racial multi, +45% to Tou racial multi, -20% to Spe racial multi, -40% to Int racial multi, +70% to Lib racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.minotaurScore() >= 10) outputText("\n<font color=\"#0000a0\">Minotaur: " + player.minotaurScore() + " (+120% to Str racial multi, +45% to Tou racial multi, -20% to Spe racial multi, -40% to Int racial multi, +45% to Lib racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.minotaurScore() >= 4) outputText("\n<font color=\"#0000a0\">Half Minotaur: " + player.minotaurScore() + " (+60% to Str racial multi, +10% to Tou racial multi, -10% to Spe racial multi, -20% to Int racial multi, +20% to Lib racial multi, +" + (25 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.minotaurScore() >= 1) outputText("\n<font color=\"#008000\">Half Minotaur: " + player.minotaurScore() + "</font>");
		else if (player.minotaurScore() < 1) outputText("\n<font color=\"#ff0000\">Half Minotaur: 0</font>");
		//Mouse & Hinezumi
		if (player.mouseScore() >= 8) {
			if (player.mouseScore() >= 15 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI) outputText("\n<font color=\"#0000a0\">Hinezumi: " + player.mouseScore() + " (+75% to Str racial multi, -10% to Tou racial multi, +80% to Spe racial multi, +80% to Wis racial multi)</font>");
			else if (player.mouseScore() >= 12 && player.arms.type == Arms.HINEZUMI && player.lowerBody == LowerBody.HINEZUMI) outputText("\n<font color=\"#0000a0\">Hinezumi: " + player.mouseScore() + " (+60% to Str racial multi, -10% to Tou racial multi, +80% to Spe racial multi, +50% to Wis racial multi)</font>");
			else outputText("\n<font color=\"#0000a0\">Mouse-morph: " + player.mouseScore() + " (-10% to Tou racial multi, +80% to Spe racial multi, +50% to Wis racial multi)</font>");
		}
		else if (player.mouseScore() >= 4) outputText("\n<font color=\"#0000a0\">Mouse girl/boy: " + player.mouseScore() + " (-10% to Tou racial multi, +40% to Spe racial multi, +30% to Wis racial multi)</font>");
		else if (player.mouseScore() >= 1) outputText("\n<font color=\"#008000\">Mouse girl/boy: " + player.mouseScore() + "</font>");
		else if (player.mouseScore() < 1) outputText("\n<font color=\"#ff0000\">Mouse girl/boy: 0</font>");
		//Naga
		if (player.nagaScore() >= 8) outputText("\n<font color=\"#0000a0\">Naga: " + player.nagaScore() + " (+"+(player.isNaga() ? "55":"40")+"% to Str racial multi, +20% to Tou racial multi, +"+(player.isNaga() ? "75":"60")+"% to Spe racial multi)</font>");
		else if (player.nagaScore() >= 4) outputText("\n<font color=\"#0000a0\">Half-Naga: " + player.nagaScore() + " (+"+(player.isNaga() ? "35":"20")+"% to Str racial multi, +"+(player.isNaga() ? "55":"40")+"% to Spe racial multi)</font>");
		else if (player.nagaScore() >= 1) outputText("\n<font color=\"#008000\">Half-Naga: " + player.nagaScore() + "</font>");
		else if (player.nagaScore() < 1) outputText("\n<font color=\"#ff0000\">Half-Naga: 0</font>");
		//Nekomata
		if (player.nekomataScore() >= 10) {
			if (player.tailType == 8 && player.tailCount >= 2 && player.nekomataScore() >= 12) outputText("\n<font color=\"#0000a0\">Elder Nekomata: " + player.nekomataScore() + " (+");
			else outputText("\n<font color=\"#0000a0\">Nekomata: " + player.nekomataScore() + " (+");
			outputText(""+(player.hasPerk(PerkLib.Flexibility) ? "40":"50")+"");
			if (player.tailType == 8 && player.tailCount >= 2 && player.nekomataScore() >= 12) outputText("% to Spe racial multi, +40% to Int racial multi, +100% to Wis racial multi, +20% max Soulforce)</font>");
			else outputText("% to Spe racial multi, +30% to Int racial multi, +80% to Wis racial multi, +10% max Soulforce)</font>");
		}
		else if (player.nekomataScore() >= 1) outputText("\n<font color=\"#008000\">Nekomata: " + player.nekomataScore() + "</font>");
		else if (player.nekomataScore() < 1) outputText("\n<font color=\"#ff0000\">Nekomata: 0</font>");
		//Oni
		if (player.oniScore() >= 18) outputText("\n<font color=\"#0000a0\">Elder Oni: " + player.oniScore() + " (+150% to Str racial multi, +90% to Tou racial multi, -30% to Int racial multi, +60% to Wis racial multi)</font>");
		else if (player.oniScore() >= 12) outputText("\n<font color=\"#0000a0\">Oni: " + player.oniScore() + " (+100% to Str racial multi, +60% to Tou racial multi, -20% to Int racial multi, +40% to Wis racial multi)</font>");
		else if (player.oniScore() >= 6) outputText("\n<font color=\"#0000a0\">Half Oni: " + player.oniScore() + " (+50% to Str racial multi, +30% to Tou racial multi, -10% to Int racial multi, +20% to Wis racial multi)</font>");
		else if (player.oniScore() >= 1) outputText("\n<font color=\"#008000\">Half Oni: " + player.oniScore() + "</font>");
		else if (player.oniScore() < 1) outputText("\n<font color=\"#ff0000\">Half Oni: 0</font>");
		//Oomukade
		if (player.oomukadeScore() >= 18) outputText("\n<font color=\"#0000a0\">Elder Oomukade: " + player.oomukadeScore() + " (+125% to Str racial multi, +45% to Tou racial multi, +60% to Spe racial multi, +110% to Lib racial multi, -50% to Wis racial multi)</font>");
		if (player.oomukadeScore() >= 15) outputText("\n<font color=\"#0000a0\">Oomukade: " + player.oomukadeScore() + " (+75% to Str racial multi, +40% to Tou racial multi, +50% to Spe racial multi, +110% to Lib racial multi, -50% to Wis racial multi)</font>");
		else if (player.oomukadeScore() >= 1) outputText("\n<font color=\"#008000\">Oomukade: " + player.oomukadeScore() + "</font>");
		else if (player.oomukadeScore() < 1) outputText("\n<font color=\"#ff0000\">Oomukade: 0</font>");
		//Orc
		/*if (player.orcScore() >= 11) outputText("\n<font color=\"#0000a0\">High Orc: " + player.orcScore() + " (+130% to Str racial multi, +30% to Tou racial multi, +10% to Spe racial multi, -30% to Int racial multi, +25% to Lib racial multi, +20% max Wrath)</font>");
 else */
		if (player.orcScore() >= 11) outputText("\n<font color=\"#0000a0\">Orc: " + player.orcScore() + " (+130% to Str racial multi, +30% to Tou racial multi, +10% to Spe racial multi, -30% to Int racial multi, +25% to Lib racial multi, +20% max Wrath)</font>");
		else if (player.orcScore() >= 5) outputText("\n<font color=\"#0000a0\">Half Orc: " + player.orcScore() + " (+60% to Str racial multi, +15% to Tou racial multi, +5% to Spe racial multi, -15% to Int racial multi, +10% to Lib racial multi, +10% max Wrath)</font>");
		else if (player.orcScore() >= 1) outputText("\n<font color=\"#008000\">Half Orc: " + player.orcScore() + "</font>");
		else if (player.orcScore() < 1) outputText("\n<font color=\"#ff0000\">Half Orc: 0</font>");
		//Orca
		if (player.orcaScore() >= 20) outputText("\n<font color=\"#0000a0\">Great Orca-boy/girl: " + player.orcaScore() + " (+140% to Str racial multi, +70% to Tou racial multi, +100% to Spe racial multi)</font>");
		else if (player.orcaScore() >= 14) outputText("\n<font color=\"#0000a0\">Orca-boy/girl: " + player.orcaScore() + " (+100% to Str racial multi, +40% to Tou racial multi, +70% to Spe racial multi)</font>");
		else if (player.orcaScore() >= 6) outputText("\n<font color=\"#0000a0\">Half Orca-boy/girl: " + player.orcaScore() + " (+35% to Str racial multi, +20% to Tou racial multi, +35% to Spe racial multi)</font>");
		else if (player.orcaScore() >= 1) outputText("\n<font color=\"#008000\">Half Orca-boy/girl: " + player.orcaScore() + "</font>");
		else if (player.orcaScore() < 1) outputText("\n<font color=\"#ff0000\">Half Orca-boy/girl: 0</font>");
		//Phantom > Poltergeist
		if (player.poltergeistScore() >= 18) outputText("\n<font color=\"#0000a0\">Eldritch Poltergeist: " + player.poltergeistScore() + " (-45% to Str racial multi, -45% to Tou racial multi, +150% to Spe racial multi, +150% to Int racial multi, +60% to Wis racial multi)</font>");
		else if (player.poltergeistScore() >= 12) outputText("\n<font color=\"#0000a0\">Poltergeist: " + player.poltergeistScore() + " (-25% to Str racial multi, -25% to Tou racial multi, +90% to Spe racial multi, +90% to Int racial multi, +45% to Wis racial multi)</font>");
		else if (player.poltergeistScore() >= 6) outputText("\n<font color=\"#0000a0\">Phantom: " + player.poltergeistScore() + " (-15% to Str racial multi, -15% to Tou racial multi, +45% to Spe racial multi, +45% to Int racial multi, +30% to Wis racial multi)</font>");
		else if (player.poltergeistScore() >= 1) outputText("\n<font color=\"#008000\">Phantom: " + player.poltergeistScore() + "</font>");
		else if (player.poltergeistScore() < 1) outputText("\n<font color=\"#ff0000\">Phantom: 0</font>");
		//Phoenix
		if (player.phoenixScore() >= 21) outputText("\n<font color=\"#0000a0\">Greater Phoenix: " + player.phoenixScore() + " (+40% to Str racial multi, +20% to Tou racial multi, +150% to Spe racial multi, +105% to Lib racial multi, +" + (25 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.phoenixScore() >= 10) outputText("\n<font color=\"#0000a0\">Phoenix: " + player.phoenixScore() + " (+20% to Str racial multi, +20% to Tou racial multi, +70% to Spe racial multi, +40% to Lib racial multi, +" + (25 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.phoenixScore() >= 1) outputText("\n<font color=\"#008000\">Phoenix: " + player.phoenixScore() + "</font>");
		else if (player.phoenixScore() < 1) outputText("\n<font color=\"#ff0000\">Phoenix: 0</font>");
		//Pig
		if (player.pigScore() >= 15) outputText("\n<font color=\"#0000a0\">Boar-morph: " + player.pigScore() + " (+125% to Str racial multi, +125% to Tou racial multi, -15% to Spe racial multi, -10% to Int racial multi)</font>");
		else if (player.pigScore() >= 10) outputText("\n<font color=\"#0000a0\">Pig-morph: " + player.pigScore() + " (+60% to Str racial multi, +120% to Tou racial multi, -15% to Spe racial multi, -10% to Int racial multi, -5% to Wis racial multi)</font>");
		else if (player.pigScore() >= 5) outputText("\n<font color=\"#0000a0\">Half Pig-morph: " + player.pigScore() + " (+30% to Str racial multi, +60% to Tou racial multi, -10% to Spe racial multi, -5% to Int racial multi)</font>");
		else if (player.pigScore() >= 1) outputText("\n<font color=\"#008000\">Half Pig-morph: " + player.pigScore() + "</font>");
		else if (player.pigScore() < 1) outputText("\n<font color=\"#ff0000\">Half Pig-morph: 0</font>");
		//Treant/Dryad
		if (player.plantScore() >= 7) outputText("\n<font color=\"#0000a0\">Treant/Dryad: " + player.plantScore() + " (+25% to Str racial multi, +100% to Tou racial multi, -50% to Spe racial multi, +" + (10 * (1 + player.newGamePlusMod())) + " Armor)</font>");
		else if (player.plantScore() >= 6) outputText("\n<font color=\"#0000a0\">Treant/Dryad: " + player.plantScore() + " (+20% to Str racial multi, +80% to Tou racial multi, -40% to Spe racial multi, +" + (8 * (1 + player.newGamePlusMod())) + " Armor)</font>");
		else if (player.plantScore() >= 5) outputText("\n<font color=\"#0000a0\">Plant-morph: " + player.plantScore() + " (+10% to Str racial multi, +50% to Tou racial multi, -20% to Spe racial multi, +" + (4 * (1 + player.newGamePlusMod())) + " Armor)</font>");
		else if (player.plantScore() >= 4) outputText("\n<font color=\"#0000a0\">Plant-morph: " + player.plantScore() + " (+30% to Tou racial multi, -10% to Spe racial multi, +" + (2 * (1 + player.newGamePlusMod())) + " Armor)</font>");
		else if (player.plantScore() >= 1) outputText("\n<font color=\"#008000\">Plant-morph: " + player.plantScore() + "</font>");
		else if (player.plantScore() < 1) outputText("\n<font color=\"#ff0000\">Plant-morph: 0</font>");
		//Raccon
		if (player.raccoonScore() >= 17 && player.balls > 0 && player.ballSize > 5) outputText("\n<font color=\"#0000a0\">Greater Tanuki: " + player.raccoonScore() + " (+105% to Spe racial multi, +150% to Int racial multi)</font>");
		else if (player.raccoonScore() >= 14 && player.balls > 0 && player.ballSize > 5) outputText("\n<font color=\"#0000a0\">Tanuki: " + player.raccoonScore() + " (+90% to Spe racial multi, +120% to Int racial multi)</font>");
		else if (player.raccoonScore() >= 4) outputText("\n<font color=\"#0000a0\">Raccoon-morph: " + player.raccoonScore() + " (+60% to Spe racial multi)</font>");
		else if (player.raccoonScore() >= 1) outputText("\n<font color=\"#008000\">Raccoon-morph: " + player.raccoonScore() + "</font>");
		else if (player.raccoonScore() < 1) outputText("\n<font color=\"#ff0000\">Raccoon-morph: 0</font>");
		//Raiju
		if (player.raijuScore() >= 14) outputText("\n<font color=\"#0000a0\">Greater Raiju: " + player.raijuScore() + " (+100% to Spe racial multi, +50% to Int racial multi, +120% to Lib racial multi, +60 min Sens)</font>");
		else if (player.raijuScore() >= 10) outputText("\n<font color=\"#0000a0\">Raiju: " + player.raijuScore() + " (+70% to Spe racial multi, +50% to Int racial multi, +80% to Lib racial multi, +50 min Sens)</font>");
		else if (player.raijuScore() >= 5) outputText("\n<font color=\"#0000a0\">Half Raiju: " + player.raijuScore() + " (+35% to Spe racial multi, +25% to Int racial multi, +40% to Lib racial multi, +25 min Sens)</font>");
		else if (player.raijuScore() >= 1) outputText("\n<font color=\"#008000\">Half Raiju: " + player.raijuScore() + "</font>");
		else if (player.raijuScore() < 1) outputText("\n<font color=\"#ff0000\">Half Raiju: 0</font>");
		//Ratatoskr
		if (player.ratatoskrScore() >= 18) outputText("\n<font color=\"#0000a0\">Ratatoskr: " + player.ratatoskrScore() + " (-25% to Str racial multi, +140% to Spe racial multi, +155% to Int racial multi)</font>");
		else if (player.ratatoskrScore() >= 12) outputText("\n<font color=\"#0000a0\">Squirrel morph: " + player.ratatoskrScore() + " (-20% to Str racial multi, +95% to Spe racial multi, +105% to Int racial multi)</font>");
		else if (player.ratatoskrScore() >= 6) outputText("\n<font color=\"#0000a0\">Half Squirrel morph: " + player.ratatoskrScore() + " (-10% to Str racial multi, +60% to Spe racial multi, +40% to Int racial multi)</font>");
		else if (player.ratatoskrScore() >= 1) outputText("\n<font color=\"#008000\">Half Squirrel morph: " + player.ratatoskrScore() + "</font>");
		else if (player.ratatoskrScore() < 1) outputText("\n<font color=\"#ff0000\">Half Squirrel morph: 0</font>");
		//Red Panda
		if (player.redpandaScore() >= 8) outputText("\n<font color=\"#0000a0\">Red Panda-morph: " + player.redpandaScore() + " (+15% to Str racial multi, +75% to Spe racial multi, +30% to Int racial multi)</font>");
		else if (player.redpandaScore() >= 4) outputText("\n<font color=\"#0000a0\">Half Red Panda-morph: " + player.redpandaScore() + " (+45% to Spe racial multi, +15% to Int racial multi)</font>");
		else if (player.redpandaScore() >= 1) outputText("\n<font color=\"#008000\">Half Red Panda-morph: " + player.redpandaScore() + "</font>");
		else if (player.redpandaScore() < 1) outputText("\n<font color=\"#ff0000\">Half Red Panda-morph: 0</font>");
		//Rhino
		if (player.rhinoScore() >= 4) outputText("\n<font color=\"#0000a0\">Rhino-morph: " + player.rhinoScore() + " (+15% to Str racial multi, +15% to Tou racial multi, -10% to Spe racial multi, -10% to Int racial multi, +" + (100 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		else if (player.rhinoScore() >= 1) outputText("\n<font color=\"#008000\">Rhino-morph: " + player.rhinoScore() + "</font>");
		else if (player.rhinoScore() < 1) outputText("\n<font color=\"#ff0000\">Rhino-morph: 0</font>");
		//Salamander
		if (player.salamanderScore() >= 16) outputText("\n<font color=\"#0000a0\">Primordial Salamander: " + player.salamanderScore() + " (+105% to Str racial multi, +80% to Tou racial multi, +130% to Lib racial multi, +75 min sens, +" + (25 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.salamanderScore() >= 7) outputText("\n<font color=\"#0000a0\">Salamander: " + player.salamanderScore() + " (+25% to Str racial multi, +25% to Tou racial multi, +40% to Lib racial multi, +" + (25 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.salamanderScore() >= 4) outputText("\n<font color=\"#0000a0\">Half Salamander: " + player.salamanderScore() + " (+15% to Str racial multi, +15% to Tou racial multi, +30% to Lib racial multi, +" + (25 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.salamanderScore() >= 1) outputText("\n<font color=\"#008000\">Half Salamander: " + player.salamanderScore() + "</font>");
		else if (player.salamanderScore() < 1) outputText("\n<font color=\"#ff0000\">Half Salamander: 0</font>");
		//Satyr
		if (player.satyrScore() >= 4) outputText("\n<font color=\"#0000a0\">Satyr: " + player.satyrScore() + " (+5% to Str racial multi, +5% to Spe racial multi)</font>");
		else if (player.satyrScore() >= 1) outputText("\n<font color=\"#008000\">Satyr: " + player.satyrScore() + "</font>");
		else if (player.satyrScore() < 1) outputText("\n<font color=\"#ff0000\">Satyr: 0</font>");/*
		//Scorpion
		if (player.scorpionScore() >= ) outputText("\n<font color=\"#0000a0\">Half Scorpion-morph: " + player.scorpionScore() + "</font>");
		else if (player.scorpionScore() >= 1) outputText("\n<font color=\"#008000\">Half Scorpion-morph: " + player.scorpionScore() + "</font>");
		else if (player.scorpionScore() < 1) outputText("\n<font color=\"#ff0000\">Half Scorpion-morph: 0</font>");*/
		outputText("\nScorpion-morph: " + player.scorpionScore());
		//Scylla
		var scyllakrakengland:Number = 0;
		if (player.hasPerk(PerkLib.ScyllaInkGlands)) scyllakrakengland += 10;
		if (player.scyllaScore() >= 12 && player.isKraken()) {
			if (player.scyllaScore() >= 17) outputText("\n<font color=\"#0000a0\">Elder Kraken: " + player.scyllaScore() + " (+"+(195+scyllakrakengland)+"% to Str racial multi, +60% to Tou racial multi, +60% to Int racial multi, +15 min sens, +" + (150 * (1 + player.newGamePlusMod())) + " max HP)</font>");
			else outputText("\n<font color=\"#0000a0\">Kraken: " + player.scyllaScore() + " (+"+(180+scyllakrakengland)+"% to Str racial multi, +60% to Int racial multi, +15 min sens, +" + (150 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		}
		else if (player.scyllaScore() >= 4 && player.isScylla()) {
			if (player.scyllaScore() >= 7) outputText("\n<font color=\"#0000a0\">Scylla: " + player.scyllaScore() + " (+"+(95+scyllakrakengland)+"% to Str racial multi, +40% to Int racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max HP)</font>");
			else outputText("\n<font color=\"#0000a0\">Half Scylla: " + player.scyllaScore() + " (+"+(player.hasPerk(PerkLib.ScyllaInkGlands) ? "80":"70")+"% to Str racial multi, +20% to Int racial multi, +" + (25 * (1 + player.newGamePlusMod())) + " max HP)</font>");
		}
		else if (player.scyllaScore() >= 1) outputText("\n<font color=\"#008000\">Half Scylla: " + player.scyllaScore() + "</font>");
		else if (player.scyllaScore() < 1) outputText("\n<font color=\"#ff0000\">Half Scylla: 0</font>");
		//Sea dragon
		if (player.leviathanScore() >= 30) outputText("\n<font color=\"#0000a0\">Leviathan-boy/girl: " + player.leviathanScore() + " (+200% to Str racial multi, +100% to Tou racial multi, +100% to Spe racial multi, +50% to Int racial multi)</font>");
		else if (player.leviathanScore() >= 20) outputText("\n<font color=\"#0000a0\">Sea dragon-boy/girl: " + player.leviathanScore() + " (+110% to Str racial multi, +70% to Tou racial multi, +70% to Spe racial multi, +50% to Int racial multi)</font>");
		else if (player.leviathanScore() >= 1) outputText("\n<font color=\"#008000\">Sea dragon-boy/girl: " + player.leviathanScore() + "</font>");
		else if (player.leviathanScore() < 1) outputText("\n<font color=\"#ff0000\">Sea dragon-boy/girl: 0</font>");
		//Shark
		if (player.sharkScore() >= 9 && player.vaginas.length > 0 && player.cocks.length > 0) outputText("\n<font color=\"#0000a0\">Tigershark-morph: " + player.sharkScore() + " (+60% to Str racial multi, +70% to Spe racial multi, +20% to Lib racial multi, +" + (50 * (1 + player.newGamePlusMod())) + " max Lust)</font>");
		else if (player.sharkScore() >= 8) outputText("\n<font color=\"#0000a0\">Shark-morph: " + player.sharkScore() + " (+40% to Str racial multi, +70% to Spe racial multi, +10% to Lib racial multi)</font>");
		else if (player.sharkScore() >= 4) outputText("\n<font color=\"#0000a0\">Half Shark-morph: " + player.sharkScore() + " (+20% to Str racial multi, +40% to Spe racial multi)</font>");
		else if (player.sharkScore() >= 1) outputText("\n<font color=\"#008000\">Half Shark-morph: " + player.sharkScore() + "</font>");
		else if (player.sharkScore() < 1) outputText("\n<font color=\"#ff0000\">Half Shark-morph: 0</font>");
		//Siren
		if (player.sirenScore() >= 16) outputText("\n<font color=\"#0000a0\">Greater Siren: " + player.sirenScore() + " (+70% to Str racial multi, +100% to Spe racial multi, +70% to Int racial multi)</font>");
		else if (player.sirenScore() >= 10) outputText("\n<font color=\"#0000a0\">Siren: " + player.sirenScore() + " (+40% to Str racial multi, +70% to Spe racial multi, +40% to Int racial multi)</font>");
		else if (player.sirenScore() >= 1) outputText("\n<font color=\"#008000\">Siren: " + player.sirenScore() + "</font>");
		else if (player.sirenScore() < 1) outputText("\n<font color=\"#ff0000\">Siren: 0</font>");
		//Sphinx
		if (player.sphinxScore() >= 26) outputText("\n<font color=\"#0000a0\">Greater Sphinx: " + player.sphinxScore() + " (+110% to Str racial multi, -20% to Tou racial multi, +"+(player.hasPerk(PerkLib.Flexibility) ? "70":"60")+"% to Spe racial multi, +130% to Int racial multi, +110% to Wis racial multi)</font>");
		if (player.sphinxScore() >= 14) outputText("\n<font color=\"#0000a0\">Sphinx: " + player.sphinxScore() + " (+50% to Str racial multi, -10% to Tou racial multi, +"+(player.hasPerk(PerkLib.Flexibility) ? "50":"40")+"% to Spe racial multi, +90% to Int racial multi, +40% to Wis racial multi)</font>");
		else if (player.sphinxScore() >= 1) outputText("\n<font color=\"#008000\">Sphinx: " + player.sphinxScore() + "</font>");
		else if (player.sphinxScore() < 1) outputText("\n<font color=\"#ff0000\">Sphinx: 0</font>");
		//Spider
		if (player.spiderScore() >= 7) outputText("\n<font color=\"#0000a0\">Spider-morph: " + player.spiderScore() + " (-20% to Str racial multi, +50% to Tou racial multi, +75% to Int racial multi)</font>");
		else if (player.spiderScore() >= 4) outputText("\n<font color=\"#0000a0\">Half Spider-morph: " + player.spiderScore() + " (-10% to Str racial multi, +30% to Tou racial multi, +40% to Int racial multi)</font>");
		else if (player.spiderScore() >= 1) outputText("\n<font color=\"#008000\">Half Spider-morph: " + player.spiderScore() + "</font>");
		else if (player.spiderScore() < 1) outputText("\n<font color=\"#ff0000\">Half Spider-morph: 0</font>");
		//Thunderbird
		if (player.thunderbirdScore() >= 21) outputText("\n<font color=\"#0000a0\">Greater Thunderbird: " + player.thunderbirdScore() + " (-25% to Tou racial multi, +155% to Spe racial multi, +185% to Lib racial multi)</font>");
		else if (player.thunderbirdScore() >= 16) outputText("\n<font color=\"#0000a0\">Thunderbird: " + player.thunderbirdScore() + " (-15% to Tou racial multi, +120% to Spe racial multi, +140% to Lib racial multi)</font>");
		else if (player.thunderbirdScore() >= 12) outputText("\n<font color=\"#0000a0\">Half Thunderbird: " + player.thunderbirdScore() + " (-15% to Tou racial multi, +95% to Spe racial multi, +100% to Lib racial multi)</font>");
		else if (player.thunderbirdScore() >= 1) outputText("\n<font color=\"#008000\">Half Thunderbird: " + player.thunderbirdScore() + "</font>");
		else if (player.thunderbirdScore() < 1) outputText("\n<font color=\"#ff0000\">Half Thunderbird: 0</font>");
		//Troll
		if (player.trollScore() >= 10) outputText("\n<font color=\"#0000a0\">Troll: " + player.trollScore() + " (-20% to Str racial multi, +50% to Tou racial multi, +75% to Int racial multi)</font>");
		else if (player.trollScore() >= 5) outputText("\n<font color=\"#0000a0\">Half Troll: " + player.trollScore() + " (-10% to Str racial multi, +30% to Tou racial multi, +40% to Int racial multi)</font>");
		else if (player.trollScore() >= 1) outputText("\n<font color=\"#008000\">Half Troll: " + player.trollScore() + "</font>");
		else if (player.trollScore() < 1) outputText("\n<font color=\"#ff0000\">Half Troll: 0</font>");
		//Ushi Onna
		if (player.ushionnaScore() >= 11) {
			outputText("\n<font color=\"#0000a0\">");
			if (player.statusEffectv1(StatusEffects.UshiOnnaVariant) == 1) outputText("Fiery Ushi-" + player.mf("oni", "onna") + "");
			else if (player.statusEffectv1(StatusEffects.UshiOnnaVariant) == 2) outputText("Frozen Ushi-" + player.mf("oni", "onna") + "");
			else if (player.statusEffectv1(StatusEffects.UshiOnnaVariant) == 3) outputText("Sandy Ushi-" + player.mf("oni", "onna") + "");
			else if (player.statusEffectv1(StatusEffects.UshiOnnaVariant) == 4) outputText("Pure Ushi-" + player.mf("oni", "onna") + "");
			else if (player.statusEffectv1(StatusEffects.UshiOnnaVariant) == 5) outputText("Wicked Ushi-" + player.mf("oni", "onna") + "");
			else outputText("Ushi-" + player.mf("oni", "onna") + "");
			outputText(": " + player.ushionnaScore() + " (+80% to Str racial multi, +70% to Tou racial multi, -40% to Int racial multi, -40% to Wis racial multi, +95% to Lib racial multi)</font>");
		}
		else if (player.ushionnaScore() >= 1) outputText("\n<font color=\"#008000\">Ushi-Onna: " + player.ushionnaScore() + "</font>");
		else if (player.ushionnaScore() < 1) outputText("\n<font color=\"#ff0000\">Ushi-Onna: 0</font>");
		//Wendigo
		if (player.wendigoScore() >= 25) outputText("\n<font color=\"#0000a0\">Greater Wendigo: " + player.wendigoScore() + " (+70% to Str racial multi, +70% to Tou racial multi, +60% to Int racial multi, -50% to Wis racial multi, +50% to Lib racial multi, +50 min sens)</font>");
		else if (player.wendigoScore() >= 10) outputText("\n<font color=\"#0000a0\">Wendigo: " + player.wendigoScore() + " (+70% to Str racial multi, +70% to Tou racial multi, +60% to Int racial multi, -50% to Wis racial multi, +50% to Lib racial multi, +50 min sens)</font>");
		else if (player.wendigoScore() >= 1) outputText("\n<font color=\"#008000\">Wendigo: " + player.wendigoScore() + "</font>");
		else if (player.wendigoScore() < 1) outputText("\n<font color=\"#ff0000\">Wendigo: 0</font>");
		//Werewolf
		if (player.werewolfScore() >= 12) outputText("\n<font color=\"#0000a0\">Werewolf: " + player.werewolfScore() + " (+100% to Str racial multi, +40% to Tou racial multi, +60% to Spe racial multi, -20% to Int racial multi)</font>");
		else if (player.werewolfScore() >= 1) outputText("\n<font color=\"#008000\">Werewolf: " + player.werewolfScore() + "</font>");
		else if (player.werewolfScore() < 1) outputText("\n<font color=\"#ff0000\">Werewolf: 0</font>");
		//Wolf
		if (player.wolfScore() >= 23) outputText("\n<font color=\"#0000a0\">Fenrir: " + player.wolfScore() + " (+135% to Str racial multi, +80% to Tou racial multi, +100% to Spe racial multi, -10% to Int racial multi)</font>");
		else if (player.wolfScore() >= 7 && player.coatColor == "glacial white") outputText("\n<font color=\"#0000a0\">Winter wolf: " + player.wolfScore() + " (+30% to Str racial multi, +20% to Tou racial multi, +30% to Spe racial multi, -10% to Int racial multi)</font>");
		else if (player.wolfScore() >= 6) outputText("\n<font color=\"#0000a0\">Wolf-morph: " + player.wolfScore() + " (+30% to Str racial multi, +10% to Tou racial multi, +30% to Spe racial multi, -10% to Int racial multi)</font>");
		else if (player.wolfScore() >= 4) outputText("\n<font color=\"#0000a0\">Wolf girl/boy: " + player.wolfScore() + " (+15% to Str racial multi, +10% to Spe racial multi, -10% to Int racial multi)</font>");
		else if (player.wolfScore() >= 1) outputText("\n<font color=\"#008000\">Wolf girl/boy: " + player.wolfScore() + "</font>");
		else if (player.wolfScore() < 1) outputText("\n<font color=\"#ff0000\">Wolf girl/boy: 0</font>");
		//Unicorn
		if (player.unicornScore() >= 24) outputText("\n<font color=\"#0000a0\">True Unicorn/True Bicorn: " + player.unicornScore() + " (+75% to Str racial multi, +70% to Tou racial multi, +115% to Spe racial multi, +120% to Int racial multi)</font>");
		else if (player.unicornScore() >= 12) outputText("\n<font color=\"#0000a0\">Unicorn/Bicorn: " + player.unicornScore() + " (+35% to Tou racial multi, +90% to Spe racial multi, +105% to Int racial multi)</font>");
		else if (player.unicornScore() >= 8) outputText("\n<font color=\"#0000a0\">Half Unicorn/Half Bicorn: " + player.unicornScore() + " (+25% to Tou racial multi, +40% to Spe racial multi, +55% to Int racial multi)</font>");
		else if (player.unicornScore() >= 1) outputText("\n<font color=\"#008000\">Unicorn/Bicorn: " + player.unicornScore() + "</font>");
		else if (player.unicornScore() < 1) outputText("\n<font color=\"#ff0000\">Unicorn/Bicorn: 0</font>");
		//UnicornKin
		if (player.unicornkinScore() >= 12) outputText("\n<font color=\"#0000a0\">Unicornkin/Bicornkin: " + player.unicornkinScore() + " (+55% to Tou racial multi, +70% to Spe racial multi, +85% to Int racial multi)</font>");
		else if (player.unicornkinScore() >= 1) outputText("\n<font color=\"#008000\">Unicorn/Bicorn: " + player.unicornkinScore() + "</font>");
		else if (player.unicornkinScore() < 1) outputText("\n<font color=\"#ff0000\">Unicornkin/Bicornkin: 0</font>");
		//Vampire
		if (player.vampireScore() >= 18) outputText("\n<font color=\"#0000a0\">Pureblood Vampire: " + player.vampireScore() + " (+65% to Str racial multi, +65% to Spe racial multi, +65% to Int racial multi, +75% to Lib racial multi)</font>");
		else if (player.vampireScore() >= 10) outputText("\n<font color=\"#0000a0\">Vampire: " + player.vampireScore() + " (+35% to Str racial multi, +35% to Spe racial multi, +35% to Int racial multi, +45% to Lib racial multi)</font>");
		else if (player.vampireScore() >= 6) outputText("\n<font color=\"#0000a0\">Dhampir: " + player.vampireScore() + " (+20% to Str racial multi, +20% to Spe racial multi, +20% to Int racial multi, +30% to Lib racial multi)</font>");
		else if (player.vampireScore() >= 1) outputText("\n<font color=\"#008000\">Dhampir: " + player.vampireScore() + "</font>");
		else if (player.vampireScore() < 1) outputText("\n<font color=\"#ff0000\">Dhampir: 0</font>");
		//Vouivre
		if (player.vouivreScore() >= 21) outputText("\n<font color=\"#0000a0\">Greater Vouivre: " + player.vouivreScore() + " (+"+(player.isNaga() ? "145":"130")+"% to Str racial multi, +95% to Tou racial multi, +"+(player.isNaga() ? "115":"100")+"% to Spe racial multi, +20% to Int racial multi, -20% to Wis racial multi)</font>");//, +" + (50 * (1 + player.newGamePlusMod())) + " max HP
		else if (player.vouivreScore() >= 16) outputText("\n<font color=\"#0000a0\">Vouivre: " + player.vouivreScore() + " (+"+(player.isNaga() ? "115":"100")+"% to Str racial multi, +65% to Tou racial multi, +"+(player.isNaga() ? "85":"70")+"% to Spe racial multi, +15% to Int racial multi, -15% to Wis racial multi)</font>");//, +" + (50 * (1 + player.newGamePlusMod())) + " max HP
		else if (player.vouivreScore() >= 11) outputText("\n<font color=\"#0000a0\">Lesser Vouivre: " + player.vouivreScore() + " (+"+(player.isNaga() ? "85":"70")+"% to Str racial multi, +45% to Tou racial multi, +"+(player.isNaga() ? "60":"45")+"% to Spe racial multi, +10% to Int racial multi, -10% to Wis racial multi)</font>");//, +" + (50 * (1 + player.newGamePlusMod())) + " max HP
		else if (player.vouivreScore() >= 1) outputText("\n<font color=\"#008000\">Lesser Vouivre: " + player.vouivreScore() + "</font>");
		else if (player.vouivreScore() < 1) outputText("\n<font color=\"#ff0000\">Lesser Vouivre: 0</font>");
		//Yeti
		if (player.yetiScore() >= 17) outputText("\n<font color=\"#0000a0\">True Yeti: " + player.yetiScore() + " (+130% to Str racial multi, +100% to Tou racial multi, +65% to Spe racial multi, -90% to Int racial multi, +50% to Lib racial multi)</font>");
		else if (player.yetiScore() >= 14) outputText("\n<font color=\"#0000a0\">Yeti: " + player.yetiScore() + " (+100% to Str racial multi, +80% to Tou racial multi, +50% to Spe racial multi, -70% to Int racial multi, +50% to Lib racial multi)</font>");
		else if (player.yetiScore() >= 7) outputText("\n<font color=\"#0000a0\">Half Yeti: " + player.yetiScore() + " (+50% to Str racial multi, +40% to Tou racial multi, +25% to Spe racial multi, -35% to Int racial multi, +25% to Lib racial multi)</font>");
		else if (player.yetiScore() >= 1) outputText("\n<font color=\"#008000\">Half Yeti: " + player.yetiScore() + "</font>");
		else if (player.yetiScore() < 1) outputText("\n<font color=\"#ff0000\">Half Yeti: 0</font>");
		//Yggdrasil
		if (player.yggdrasilScore() >= 10) outputText("\n<font color=\"#0000a0\">Yggdrasil: " + player.yggdrasilScore() + " (+50% to Str racial multi, +70% to Tou racial multi, -50% to Spe racial multi, +50% to Int racial multi, +80% to Wis racial multi, -50% to Lib racial multi, +" + (10 * (1 + player.newGamePlusMod())) + " Armor / Magic Resistance)</font>");
		else if (player.yggdrasilScore() >= 1) outputText("\n<font color=\"#008000\">Yggdrasil: " + player.yggdrasilScore() + "</font>");
		else if (player.yggdrasilScore() < 1) outputText("\n<font color=\"#ff0000\">Yggdrasil: 0</font>");
		//Yuki Onna
		if (player.yukiOnnaScore() >= 14) outputText("\n<font color=\"#0000a0\">Yuki Onna: " + player.yukiOnnaScore() + " (+70% to Spe racial multi, +140% to Int racial multi, +70% to Wis racial multi, +50% to Lib racial multi, " + (player.hasPerk(PerkLib.IcyFlesh) ? ", max Tou fixed at 1" : "") + ")</font>");
		else if (player.yukiOnnaScore() >= 1) outputText("\n<font color=\"#008000\">Yuki Onna: " + player.yukiOnnaScore() + "</font>");
		else if (player.yukiOnnaScore() < 1) outputText("\n<font color=\"#ff0000\">Yuki Onna: 0</font>");
		menu();
		addButton(0, "Next", playerMenu);
	}

	public function GenderForcedSetting():void {
		clearOutput();
		outputText("This menu allows you to choose if the game will treat your character as a female or a male. Using the automatic option will let the game orginal system do the work instead of setting your sex in one or another way.");
		menu();
		addButton(0, "Next", playerMenu);
		if (flags[kFLAGS.MALE_OR_FEMALE] == 0) addButtonDisabled(1, "Auto", "It's currently used setting option.");
		else addButton(1, "Auto", GenderForcedSettingAuto);
		if (flags[kFLAGS.MALE_OR_FEMALE] == 1) addButtonDisabled(2, "Male", "It's currently used setting option.");
		else addButton(2, "Male", GenderForcedSettingMale);
		if (flags[kFLAGS.MALE_OR_FEMALE] == 2) addButtonDisabled(3, "Female", "It's currently used setting option.");
		else addButton(3, "Female", GenderForcedSettingFemale);
	}

	public function GenderForcedSettingAuto():void {
		flags[kFLAGS.MALE_OR_FEMALE] = 0;
		doNext(GenderForcedSetting);
	}

	public function GenderForcedSettingMale():void {
		flags[kFLAGS.MALE_OR_FEMALE] = 1;
		doNext(GenderForcedSetting);
	}

	public function GenderForcedSettingFemale():void {
		flags[kFLAGS.MALE_OR_FEMALE] = 2;
		doNext(GenderForcedSetting);
	}

	public function getGargoyleMaterial(): String {
		var gargoyleMaterials: Array = ["marble","alabaster"];

		//Defines Gargoyle's material, 1 or 2 if successful
		const gargoyleFlag: int = flags[kFLAGS.GARGOYLE_BODY_MATERIAL] && flags[kFLAGS.GARGOYLE_BODY_MATERIAL] > 0 ? flags[kFLAGS.GARGOYLE_BODY_MATERIAL] - 1 : 0;

		return gargoyleMaterials[gargoyleFlag];
	}

	private function campActionsReflect():void {
		clearOutput();
		outputText("You sit down on your sleeping " + (flags[kFLAGS.CAMP_CABIN_FURNITURE_BED] > 0 ? "bed" : "bag") + " and contemplate your current outlook on life. You have been through much and became bigger, better, way more than what you once were.");
		if (player.race() != player.startingRace) outputText(" While you were formerly a " + player.startingRace + " you now are a " + player.race() + " for better or for worse and have decided to live this new life to its fullest.");
		player.strtouspeintwislibsenCalculation2();
		outputText(" As if this reflection unlocked some hidden door in you, you feel your body awaken with newfound vigor and might. Let your adversaries come, you are ready for them now!");
		doNext(playerMenu);
	}

	public function sockDescript(index:int):void {
		outputText(" ");
		if (player.cocks[index].sock == "wool")
			outputText("It's covered by a wooly white cock-sock, keeping it snug and warm despite how cold it might get.");
		else if (player.cocks[index].sock == "alabaster")
			outputText("It's covered by a white, lacey cock-sock, snugly wrapping around it like a bridal dress around a bride.");
		else if (player.cocks[index].sock == "cockring")
			outputText("It's covered by a black latex cock-sock with two attached metal rings, keeping your cock just a little harder and [balls] aching for release.");
		else if (player.cocks[index].sock == "viridian")
			outputText("It's covered by a lacey dark green cock-sock accented with red rose-like patterns. Just wearing it makes your body, especially your cock, tingle.");
		else if (player.cocks[index].sock == "scarlet")
			outputText("It's covered by a lacey red cock-sock that clings tightly to your member. Just wearing it makes your cock throb, as if it yearns to be larger...");
		else if (player.cocks[index].sock == "cobalt")
			outputText("It's covered by a lacey blue cock-sock that clings tightly to your member... really tightly. It's so tight it's almost uncomfortable, and you wonder if any growth might be inhibited.");
		else if (player.cocks[index].sock == "gilded")
			outputText("It's covered by a metallic gold cock-sock that clings tightly to you, its surface covered in glittering gems. Despite the warmth of your body, the cock-sock remains cool.");
		else if (player.cocks[index].sock == "amaranthine") {
			outputText("It's covered by a lacey purple cock-sock");
			if (player.cocks[index].cockType != CockTypesEnum.DISPLACER)
				outputText(" that fits somewhat awkwardly on your member");
			else
				outputText(" that fits your coeurl cock perfectly");
			outputText(". Just wearing it makes you feel stronger and more powerful.");
		} else if (player.cocks[index].sock == "red")
			outputText("It's covered by a red cock-sock that seems to glow. Just wearing it makes you feel a bit powerful.");
		else if (player.cocks[index].sock == "green")
			outputText("It's covered by a green cock-sock that seems to glow. Just wearing it makes you feel a bit healthier.");
		else if (player.cocks[index].sock == "blue")
			outputText("It's covered by a blue cock-sock that seems to glow. Just wearing it makes you feel like you can cast spells more effectively.");

		else outputText("<b>Yo, this is an error.</b>");
	}

	public function describeVisage():void{ //expressions!
		if (player.hasPerk(PerkLib.DarkenedKitsune)) {
			outputText(SceneLib.darkenedKitsuneScene.darkenedKitsuneExpression());
		}
	}
}
}