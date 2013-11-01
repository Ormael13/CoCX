function appearance(e:MouseEvent):void {
	funcs = new Array();
	args = new Array();
	//Temp vars
	var temp:Number = 0;
	var rando:Number = 0;
	//Determine race type:
	var race:String = "human";
	/*if(player.lowerBody == 4) race = "centaur";
	if(player.lowerBody == 11) race = "pony-kin";
	//determine sheath
	var sheath:Boolean = false;
	if(player.catScore() >= 4) race = "cat-" + player.mf("boy","girl");
	if(player.lizardScore() >= 4) {
		if(player.gender == 0) race = "lizan";
		else if(player.gender == 1) race = "male lizan";
		else if(player.gender == 2) race = "female lizan";
		else race = "hermaphrodite lizan";
	}
	if(player.dogScore() >= 4) race = "dog-morph";
	if(player.horseScore() >= 3) {
		if(player.lowerBody == 4) race = "centaur-morph";
		else race = "equine-morph";
	}
	if(player.mutantScore() >= 5) race = "corrupted mutant";
	if(player.minoScore() >= 4) race = "minotaur-morph";
	if(player.cowScore() > 5) {
		race = "cow-";
		if(player.gender <= 1) race += "boi";
		else race += "girl";
	}
	if(player.beeScore() >= 4) race = "bee-morph";
	if(player.goblinScore() >= 5) race = "goblin";
	if(player.humanScore() >= 5 && race == "corrupted mutant") race = "somewhat human mutant";
	if(player.demonScore() > 4) race = "demon-morph";
	if(player.lowerBody == 3) race = "naga";
	if(player.lowerBody == 4) race = "centaur";
	if(player.sharkScore() >= 3) race = "shark-morph";
	if(player.bunnyScore() >= 4) race = "bunny-" + player.mf("boy","girl");
	if(player.gooScore() >= 3) {
		race = "goo-";
		if(player.gender <= 1) race += "boi";
		else race += "girl";
	}*/
	race = player.race();
	//Discuss race
	outputText("", true);
	if(race != "human")	outputText("You began your journey as a human, but gave that up as you explored the dangers of this realm.  ", false);
	//Height and race.
	outputText("You are a " + Math.floor(player.tallness/12) + " foot " + player.tallness%12 + " inch tall " + race + ", with " + player.bodyType() + ".", false);
	if(player.armorName == "comfortable clothes") outputText("  <b>You are currently wearing " + player.armorName + " and using your " + player.weaponName + " as a weapon.</b>", false);
	else outputText("  <b>You are currently wearing your " + player.armorName + " and using your " + player.weaponName + " as a weapon.</b>", false);
	//Face
	if(player.faceType == 0 || player.faceType == 4 || player.faceType == 8 || player.faceType == 10) {
		if(player.skinType == 0 || player.skinType == 3) outputText("  Your face is human in shape and structure, with " + player.skin() + ".", false);
		if(player.skinType == 1) outputText("  Under your " + player.skinFurScales() + " you have a human-shaped head with " + player.skin(true,false) + ".", false);
		if(player.skinType == 2) outputText("  Your face is fairly human in shape, but is covered in " + player.skin() + ".", false);
		if(player.faceType == 4) outputText("  A set of razor-sharp, retractable shark-teeth fill your mouth and gives your visage a slightly angular appearance.", false);
		else if(player.faceType == 8) outputText("  The constant twitches of your nose and the length of your incisors gives your visage a hint of bunny-like cuteness.", false);
		else if(player.faceType == 10) outputText("  A set of retractable, needle-like fangs sit in place of your canines and are ready to dispense their venom.", false);
	}
	else if(player.faceType == 13) {
		//appearance for skinheads
		if(player.skinType != 1 && player.skinType != 2) {
			outputText("  Your face is human in shape and structure, with " + player.skin());
			if((player.skinTone == "ebony" || player.skinTone == "black") && (player.skinType == 0 || player.skinType == 3)) outputText(", though with your dusky hue, the black raccoon mask you sport isn't properly visible.");
			else outputText(", though it is decorated with a sly-looking raccoon mask over your eyes.");
		}
		//appearance furscales
		else {
			//(black/midnight furscales)
			if(((player.hairColor == "black" || player.hairColor == "midnight") && (player.skinType == 1 || player.skinType == 2))) outputText("  Under your " + player.skinFurScales() + " hides a black raccoon mask, barely visible due to your inky hue, and");
			else outputText("  Your " + player.skinFurScales() + " are decorated with a sly-looking raccoon mask, and under them");
			outputText(" you have a human-shaped head with " + player.skin(true,false) + ".");
		}
	}
	else if(player.faceType == 14) {
		outputText("  You have a triangular raccoon face, replete with sensitive whiskers and a little black nose; a mask shades the space around your eyes, set apart from your " + player.skinFurScales() + " by a band of white.");
		//(if skin)
		if(player.skinType == 0) outputText("  It looks a bit strange with only the skin and no fur.");
		else if(player.skinType == 2) outputText("  The presence of said scales gives your visage an eerie look, more reptile than mammal.");
	}
	else if(player.faceType == 11) {
		outputText("  You have a tapered, shrewd-looking vulpine face with a speckling of downward-curved whiskers just behind the nose.");
		if(player.skinType == 0) outputText("  Oddly enough, there's no fur on your animalistic muzzle, just " + player.skinFurScales() + "."); 
		else if(player.skinType == 1) outputText("  A coat of " + player.skinFurScales() + " decorates your muzzle.");
		else if(player.skinType == 2) outputText("  Strangely, " + player.skinFurScales() + " adorn every inch of your animalistic visage.");
	}
	else if(player.faceType == 15) {
		//appearance
		outputText("  Your face is generally human in shape and structure, with " + player.skin());
		if(player.skinType == 1 || player.skinType == 2) outputText(" under your " + player.skinFurScales());
		outputText(" and mousey buckteeth.");
	}
	else if(player.faceType == 16) {
		//appearance
		outputText("  You have a snubby, tapered mouse's face, with whiskers, a little pink nose, and ");
		if(player.skinType != 1 && player.skinType != 2) outputText(player.skin());
		else outputText(player.skin() + " under your " + player.skinFurScales());
		outputText(".  Two large incisors complete it.");
	}
	//Naga
	if(player.faceType == 5) {
		if(player.skinType == 0 || player.skinType == 3) outputText("  You have a fairly normal face, with " + player.skin() + ".  The only oddity is your pair of dripping fangs which often hang over your lower lip.", false);
		if(player.skinType == 1) outputText("  Under your " + player.skinFurScales() + " you have a human-shaped head with " + player.skin(true,false) + ".  In addition, a pair of fangs hang over your lower lip, dripping with venom.", false);
		if(player.skinType == 2) outputText("  Your face is fairly human in shape, but is covered in " + player.skinFurScales() + ".  In addition, a pair of fangs hang over your lower lip, dripping with venom.", false);
	}
	//horse-face
	if(player.faceType == 1) {
		if(player.skinType == 0 || player.skinType == 3) outputText("  Your face is equine in shape and structure.  The odd visage is hairless and covered with " + player.skinFurScales() + ".", false);
		if(player.skinType == 1) outputText("  Your face is almost entirely equine in appearance, even having " + player.skinFurScales() + ".  Underneath the fur, you believe you have " + player.skin(true,false) + ".", false);
		if(player.skinType == 2) outputText("  You have the face and head structure of a horse, overlaid with glittering " + player.skinFurScales() + ".", false);
	}
	//dog-face
	if(player.faceType == 2) {
		if(player.skinType == 0 || player.skinType == 3) outputText("  You have a dog-like face, complete with a wet nose.  The odd visage is hairless and covered with " + player.skinFurScales() + ".", false);
		if(player.skinType == 1) outputText("  You have a dog's face, complete with wet nose and panting tongue.  You've got " + player.skinFurScales() + ", hiding your " + player.skin(true,false) + " underneath your furry visage.", false);
		if(player.skinType == 2) outputText("  You have the facial structure of a dog, wet nose and all, but overlaid with glittering " + player.skinFurScales() + ".", false);
	}
	//cat-face
	if(player.faceType == 6) {
		if(player.skinType == 0 || player.skinType == 3) outputText("  You have a cat-like face, complete with a cute, moist nose and whiskers.  The " + player.skin() + " that is revealed by your lack of fur looks quite unusual on so feline a face.", false);
		if(player.skinType == 1) outputText("  You have a cat-like face, complete with moist nose and whiskers.  Your " + player.skinDesc + " is " + player.hairColor + ", hiding your " + player.skin(true,false) + " underneath.", false);
		if(player.skinType == 2) outputText("  Your facial structure blends humanoid features with those of a cat.  A moist nose and whiskers are included, but overlaid with glittering " + player.skinFurScales() + ".", false);
		if(player.eyeType != 2) outputText("  Of course, no feline face would be complete without vertically slit eyes.");
	}
	//Minotaaaauuuur-face
	if(player.faceType == 3) {
		if(player.skinType == 0 || player.skinType == 3) outputText("  You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose.  Despite your lack of fur elsewhere, your visage does have a short layer of " + player.hairColor + " fuzz.", false);
		if(player.skinType == 1) outputText("  You have a face resembling that of a minotaur, with cow-like features, particularly a squared off wet nose.  Your " + player.skinFurScales() + " thickens noticably on your head, looking shaggy and more than a little monstrous once laid over your visage.", false);
		if(player.skinType == 2) outputText("  Your face resembles a minotaur's, though strangely it is covered in shimmering scales, right up to the flat cow-like nose that protrudes from your face.", false);
	}
	//Lizard-face
	if(player.faceType == 7) {
		if(player.skinType == 0 || player.skinType == 3) outputText("  You have a face resembling that of a lizard, and with your toothy maw, you have quite a fearsome visage.  The reptilian visage does look a little odd with just " + player.skin() + ".", false);
		if(player.skinType == 1) outputText("  You have a face resembling that of a lizard.  Between the toothy maw, pointed snout, and the layer of " + player.skinFurScales() + " covering your face, you have quite the fearsome visage.", false);
		if(player.skinType == 2) outputText("  Your face is that of a lizard, complete with a toothy maw and pointed snout.  Reflective " + player.skinFurScales() + " complete the look, making you look quite fearsome.", false);
	}
	if(player.faceType == 12) {
		outputText("  Your face is a narrow, reptilian muzzle.  It looks like a predatory lizard's, at first glance, but with an unusual array of spikes along the under-jaw.  It gives you a regal but fierce visage.  Opening your mouth reveals several rows of dagger-like sharp teeth.  The fearsome visage is decorated by " + player.skinFurScales() + ".");
	}
	if(player.faceType == 9) {
		outputText("  Your face is ", false);
		if(player.skinType == 0) outputText("bald", false);
		else outputText("covered with " + player.skinFurScales(), false);
		outputText(" and shaped like that of a kangaroo, somewhat rabbit-like except for the extreme length of your odd visage.", false);
	}
	//M/F stuff!
	outputText("  It has " + player.faceDesc() + ".", false);
	//Eyes
	if(player.eyeType == 1) outputText("  In addition to your primary two eyes, you have a second, smaller pair on your forehead.", false);
	else if(player.eyeType == 2) outputText("  Your eyes are solid spheres of inky, alien darkness.");

	//Hair
	//if bald
	if(player.hairLength == 0) {
		if(player.skinType == 1) outputText("  You have no hair, only a thin layer of fur atop of your head.  ", false);
		else outputText("  You are totally bald, showing only shiny " + player.skinTone + " " + player.skinDesc + " where your hair should be.", false);
		if(player.earType == 1) outputText("  A pair of horse-like ears rise up from the top of your head.", false);
		else if(player.earType == 2) outputText("  A pair of dog ears protrude from your skull, flopping down adorably.", false);
		else if(player.earType == 3) outputText("  A pair of round, floppy cow ears protrude from the sides of your skull.", false);
		else if(player.earType == 4) outputText("  A pair of large pointy ears stick out from your skull.", false);
		else if(player.earType == 5) outputText("  A pair of cute, fuzzy cat ears have sprouted from the top of your head.", false);
		else if(player.earType == 6) outputText("  A pair of rounded protrusions with small holes on the sides of your head serve as your ears.", false);
		else if(player.earType == 7) outputText("  A pair of floppy rabbit ears stick up from the top of your head, flopping around as you walk.", false);
		else if(player.earType == 9) outputText("  A pair of large, adept fox ears sit high on your head, always listening.");
		else if(player.earType == 10) outputText("  A pair of rounded protrusions with small holes on the sides of your head serve as your ears.  Bony fins sprout behind them.", false);
		else if(player.earType == 11) outputText("  A pair of vaguely egg-shaped, furry raccoon ears adorns your head.");
		else if(player.earType == 12) outputText("  A pair of large, dish-shaped mouse ears tops your head.");
		if(player.antennae == 2) outputText("  Floppy antennae also appear on your skull, bouncing and swaying in the breeze.", false);
	}
	//not bald
	else {
		if(player.earType == 0) outputText("  Your " + hairDescript() + " looks good on you, accentuating your features well.", false);
		else if(player.earType == 1) outputText("  The " + hairDescript() + " on your head parts around a pair of very horse-like ears that grow up from your head.", false);
		else if(player.earType == 2) outputText("  The " + hairDescript() + " on your head is overlapped by a pair of pointed dog ears.", false);
		else if(player.earType == 3) outputText("  The " + hairDescript() + " on your head is parted by a pair of rounded cow ears that stick out sideways.", false);
		else if(player.earType == 4) outputText("  The " + hairDescript() + " on your head is parted by a pair of cute pointed ears, bigger than your old human ones.", false);
		else if(player.earType == 5) outputText("  The " + hairDescript() + " on your head is parted by a pair of cute, fuzzy cat ears, sprouting from atop your head and pivoting towards any sudden noises.", false);
		else if(player.earType == 6) outputText("  The " + hairDescript() + " atop your head makes it nigh-impossible to notice the two small rounded openings that are your ears.", false);
		else if(player.earType == 7) outputText("  A pair of floppy rabbit ears stick up out of your " + hairDescript() + ", bouncing around as you walk.", false);
		else if(player.earType == 8) outputText("  The " + hairDescript() + " atop your head is parted by a pair of long, furred kangaroo ears that stick out at an angle.", false);
		else if(player.earType == 9) outputText("  The " + hairDescript() + " atop your head is parted by a pair of large, adept fox ears that always seem to be listening.");
		else if(player.earType == 10) outputText("  The " + hairDescript() + " atop your head is parted by a pair of rounded protrusions with small holes on the sides of your head serve as your ears.  Bony fins sprout behind them.", false);
		else if(player.earType == 11) outputText("  The " + hairDescript() + " on your head parts around a pair of egg-shaped, furry raccoon ears.");
		else if(player.earType == 12) outputText("  The " + hairDescript() + " atop your head is funneled between and around a pair of large, dish-shaped mouse ears that stick up prominently.");
		if(player.antennae == 2) {
			if(player.earType == 7) outputText("  Limp antennae also grow from just behind your hairline, waving and swaying in the breeze with your ears.", false);
			else outputText("  Floppy antennae also grow from just behind your hairline, bouncing and swaying in the breeze.", false);
		}
	}
	//Tongue
	if(player.tongueType == 1) outputText("  A snake-like tongue occasionally flits between your lips, tasting the air.", false);
	else if(player.tongueType == 2) outputText("  A slowly undulating tongue occasionally slips from between your lips.  It hangs nearly two feet long when you let the whole thing slide out, though you can retract it to appear normal.", false);
	else if(player.tongueType == 3) outputText("  Your mouth contains a thick, fleshy tongue that, if you so desire, can telescope to a distance of about four feet.  It has sufficient manual dexterity that you can use it almost like a third arm.");

	//Horns
	//Demonic horns
	if(player.hornType == 1) {
		if(player.horns == 2) outputText("  A small pair of pointed horns has broken through the " + player.skinDesc + " on your forehead, proclaiming some demonic taint to any who see them.", false);
		if(player.horns == 4) outputText("  A quartet of prominent horns has broken through your " + player.skinDesc + ".  The back pair are longer, and curve back along your head.  The front pair protrude forward demonically.", false);
		if(player.horns == 6) outputText("  Six horns have sprouted through your " + player.skinDesc + ", the back two pairs curve backwards over your head and down towards your neck, while the front two horns stand almost eight inches long upwards and a little forward.", false);
		if(player.horns >= 8) outputText("  A large number of thick demonic horns sprout through your " + player.skinDesc + ", each pair sprouting behind the ones before.  The front jut forwards nearly ten inches while the rest curve back over your head, some of the points ending just below your ears.  You estimate you have a total of " + num2Text(player.horns) + " horns.", false);	
	}
	//Minotaur horns
	if(player.hornType == 2) {
		if(player.horns < 3) outputText("  Two tiny horn-like nubs protrude from your forehead, resembling the horns of the young livestock kept by your village.", false);
		if(player.horns >= 3 && player.horns < 6) outputText("  Two moderately sized horns grow from your forehead, similar in size to those on a young bovine.", false);
		if(player.horns >= 6 && player.horns < 12) outputText("  Two large horns sprout from your forehead, curving forwards like those of a bull.", false);
		if(player.horns >= 12 && player.horns < 20) outputText("  Two very large and dangerous looking horns sprout from your head, curving forward and over a foot long.  They have dangerous looking points.", false);
		if(player.horns >= 20) outputText("  Two huge horns erupt from your forehead, curving outward at first, then forwards.  The weight of them is heavy, and they end in dangerous looking points.", false);
	}
	//Lizard horns
	if(player.hornType == 3) {
		outputText("  A pair of " + num2Text(int(player.horns)) + " inch horns grow from the sides of your head, sweeping backwards and adding to your imposing visage.", false);
	}
	//Super lizard horns
	if(player.hornType == 4) outputText("  Two pairs of horns, roughly a foot long, sprout from the sides of your head.  They sweep back and give you a fearsome look, almost like the dragons from your village's legends.", false);
	//Antlers!
	if(player.hornType == 5) {
		if(player.horns > 0) outputText("  Two antlers, forking into " + num2Text(player.horns) + " points, have sprouted from the top of your head, forming a spiky, regal crown of bone.");
	}
	//BODY PG HERE
	outputText("\n\nYou have a humanoid shape with the usual torso, arms, hands, and fingers.", false);
	//WINGS!
	if(player.wingType == 1) outputText("  A pair of tiny-yet-beautiful bee-wings sprout from your back, too small to allow you to fly.", false);
	if(player.wingType == 2) outputText("  A pair of large bee-wings sprout from your back, reflecting the light through their clear membranes beautifully.  They flap quickly, allowing you to easily hover in place or fly.", false);
	if(player.wingType == 6) outputText("  A pair of tiny bat-like demon-wings sprout from your back, flapping cutely, but otherwise being of little use.", false);
	if(player.wingType == 7) outputText("  A pair of large bat-like demon-wings fold behind your shoulders.  With a muscle-twitch, you can extend them, and use them to soar gracefully through the air.", false);
	if(player.wingType == 8) outputText("  A large shark-like fin has sprouted between your shoulder blades.  With it you have far more control over swimming underwater.", false);
	if(player.wingType == 9) outputText("  A pair of large, feathery wings sprout from your back.  Though you usually keep the " + player.hairColor + "-colored wings folded close, they can unfurl to allow you to soar as gracefully as a harpy.", false);
	if(player.wingType == 10) outputText("  Small, vestigial wings sprout from your shoulders.  They might look like bat's wings, but the membranes are covered in fine, delicate scales.");
	else if(player.wingType == 11) outputText("  Magnificent wings sprout from your shoulders.  When unfurled they stretch further than your arm span, and a single beat of them is all you need to set out toward the sky.  They look a bit like bat's wings, but the membranes are covered in fine, delicate scales and a wicked talon juts from the end of each bone.");
	else if(player.wingType == 12) outputText("  Giant dragonfly wings hang from your shoulders.  At a whim, you could twist them into a whirring rhythm fast enough to lift you off the ground and allow you to fly.");

	//Wing arms
	if(player.armType == 1) outputText("  Feathers hang off your arms from shoulder to wrist, giving them a slightly wing-like look.", false);
	else if(player.armType == 2) outputText("  Shining black exoskeleton  covers your arms from the biceps down, resembling a pair of long black gloves from a distance.", false);	
	//Done with head bits. Move on to body stuff
	//Horse lowerbody, other lowerbody texts appear lower
	if(player.lowerBody == 11) outputText("  From the waist down you have an incredibly cute and cartoonish parody of a horse's body, with all four legs ending in flat, rounded feet.", false);
	else if(player.isTaur()) outputText("  From the waist down you have the body of a horse, with all four legs capped by hooves.", false);
	//Hip info only displays if you aren't a centaur. 
	if(!player.isTaur()) {
		if(player.thickness > 70) {
			outputText("  You have " + hipDescript(), false);
			if(player.hipRating < 6) {
				if(player.tone < 65) outputText(" buried under a noticeable muffin-top, and", false);
				else outputText(" that blend into your pillar-like waist, and", false);
			}
			if(player.hipRating >= 6 && player.hipRating < 10) outputText(" that blend into the rest of your thick form, and", false);
			if(player.hipRating >= 10 && player.hipRating < 15) outputText(" that would be much more noticeable if you weren't so wide-bodied, and", false);
			if(player.hipRating >= 15 && player.hipRating < 20) outputText(" that sway and emphasize your thick, curvy shape, and", false);
			if(player.hipRating >= 20) outputText(" that sway hypnotically on your extra-curvy frame, and", false);
		}
		else if(player.thickness < 30) {
			outputText("  You have " + hipDescript(), false);
			if(player.hipRating < 6) outputText(" that match your trim, lithe body, and", false);
			if(player.hipRating >= 6 && player.hipRating < 10) outputText(" that sway to and fro, emphasized by your trim body, and", false);
			if(player.hipRating >= 10 && player.hipRating < 15) outputText(" that swell out under your trim waistline, and", false);
			if(player.hipRating >= 15 && player.hipRating < 20) outputText(", emphasized by your narrow waist, and", false);
			if(player.hipRating >= 20) outputText(" that swell disproportionately wide on your lithe frame, and", false);
		}
		//STANDARD
		else {
			outputText("  You have " + hipDescript(), false);
			if(player.hipRating < 6) outputText(", and", false);
			if(player.femininity > 50) {
				if(player.hipRating >= 6 && player.hipRating < 10) outputText(" that draw the attention of those around you, and", false);
				if(player.hipRating >= 10 && player.hipRating < 15) outputText(" that make you walk with a sexy, swinging gait, and", false);
				if(player.hipRating >= 15 && player.hipRating < 20) outputText(" that make it look like you've birthed many children, and", false);
				if(player.hipRating >= 20) outputText(" that make you look more like an animal waiting to be bred than any kind of human, and", false);
			}
			else {
				if(player.hipRating >= 6 && player.hipRating < 10) outputText(" that give you a graceful stride, and", false);
				if(player.hipRating >= 10 && player.hipRating < 15) outputText(" that add a little feminine swing to your gait, and", false);
				if(player.hipRating >= 15 && player.hipRating < 20) outputText(" that force you to sway and wiggle as you move, and", false);
				if(player.hipRating >= 20) {
					outputText(" that give your ", false);
					if(player.balls > 0) outputText("balls plenty of room to breathe", false);
					else if(player.hasCock()) outputText(multiCockDescript() + " plenty of room to swing", false);
					else if(player.hasVagina()) outputText(vaginaDescript() + " a nice, wide berth", false);
					else outputText("vacant groin plenty of room", false);
					outputText(", and", false);
				}
			}
		}
	}
	//ASS
	//Horse version
	if(player.isTaur()) {
		//FATBUTT
		if(player.tone < 65) {
			outputText("  Your " + buttDescript(), false);
			if(player.buttRating < 4) outputText(" is lean, from what you can see of it.", false);
			if(player.buttRating >= 4 && player.buttRating < 6) outputText(" looks fairly average.", false);
			if(player.buttRating >= 6 && player.buttRating <10) outputText(" is fairly plump and healthy.", false);
			if(player.buttRating >= 10 && player.buttRating < 15) outputText(" jiggles a bit as you trot around.", false);
			if(player.buttRating >= 15 && player.buttRating < 20) outputText(" jiggles and wobbles as you trot about.", false);
			if(player.buttRating >= 20) outputText(" is obscenely large, bordering freakish, even for a horse.", false);
		}
		//GIRL LOOK AT DAT BOOTY
		else {
			outputText("  Your " + buttDescript(), false);
			if(player.buttRating < 4) outputText(" is barely noticable, showing off the muscles of your haunches.", false);
			if(player.buttRating >= 4 && player.buttRating < 6) outputText(" matches your toned equine frame quite well.", false);
			if(player.buttRating >= 6 && player.buttRating <10) outputText(" gives hints of just how much muscle you could put into a kick.", false);
			if(player.buttRating >= 10 && player.buttRating < 15) outputText(" surges with muscle whenever you trot about.", false);
			if(player.buttRating >= 15 && player.buttRating < 20) outputText(" flexes its considerable mass as you move.", false);
			if(player.buttRating >= 20) outputText(" is stacked with layers of muscle, huge even for a horse.", false);
		}
	}
	//Non-horse PCs
	else {
		//TUBBY ASS
		if(player.tone < 60) {
			outputText(" your " + buttDescript(), false);
			if(player.buttRating < 4) outputText(" looks great under your gear.", false);
			if(player.buttRating >= 4 && player.buttRating < 6) outputText(" has the barest amount of sexy jiggle.", false);
			if(player.buttRating >= 6 && player.buttRating <10) outputText(" fills out your clothing nicely.", false);
			if(player.buttRating >= 10 && player.buttRating < 15) outputText(" wobbles enticingly with every step.", false);
			if(player.buttRating >= 15 && player.buttRating < 20) outputText(" wobbles like a bowl full of jello as you walk.", false);
			if(player.buttRating >= 20) outputText(" is obscenely large, bordering freakish, and makes it difficult to run.", false);
		}
		//FITBUTT
		else {
			outputText(" your " + buttDescript(), false);
			if(player.buttRating < 4) outputText(" molds closely against your form.", false);
			if(player.buttRating >= 4 && player.buttRating < 6) outputText(" contracts with every motion, displaying the detailed curves of its lean musculature.", false);
			if(player.buttRating >= 6 && player.buttRating <10) outputText(" fills out your clothing nicely.", false);
			if(player.buttRating >= 10 && player.buttRating < 15) outputText(" stretches your gear, flexing it with each step.", false);
			if(player.buttRating >= 15 && player.buttRating < 20) outputText(" threatens to bust out from under your kit each time you clench it.", false);
			if(player.buttRating >= 20) outputText(" is marvelously large, but completely stacked with muscle.", false);
		}
	}
	//TAILS
	if(player.tailType == 1) outputText("  A long " + player.hairColor + " horsetail hangs from your " + buttDescript() + ", smooth and shiny.", false);
	if(player.tailType == 2) outputText("  A fuzzy " + player.hairColor + " dogtail sprouts just above your " + buttDescript() + ", wagging to and fro whenever you are happy.", false);
	if(player.tailType == 3) outputText("  A narrow tail ending in a spaded tip curls down from your " + buttDescript() + ", wrapping around your " + player.leg() + " sensually at every opportunity.", false);
	if(player.tailType == 4) outputText("  A long cowtail with a puffy tip swishes back and forth as if swatting at flies.", false);
	if(player.tailType == 5) {
		outputText("  A large, spherical spider-abdomen has grown out from your backside, covered in shiny black chitin.  Though it's heavy and bobs with every motion, it doesn't seem to slow you down.", false);
		if(player.tailVenom > 50 && player.tailVenom < 80) outputText("  Your bulging arachnid posterior feels fairly full of webbing.", false);
		if(player.tailVenom >= 80 && player.tailVenom < 100) outputText("  Your arachnid rear bulges and feels very full of webbing.", false);
		if(player.tailVenom == 100) outputText("  Your swollen spider-butt is distended with the sheer amount of webbing it's holding.", false);
	}
	if(player.tailType == 6) {
		outputText("  A large insectile bee-abdomen dangles from just above your backside, bobbing with its own weight as you shift.  It is covered in hard chitin with black and yellow stripes, and tipped with a dagger-like stinger.", false);
		if(player.tailVenom > 50 && player.tailVenom < 80) outputText("  A single drop of poison hangs from your exposed stinger.", false);
		if(player.tailVenom >= 80 && player.tailVenom < 100) outputText("  Poisonous bee venom coats your stinger completely.", false);
		if(player.tailVenom == 100) outputText("  Venom drips from your poisoned stinger regularly.", false);
	}
	if(player.tailType == 7) {
		outputText("  A long shark-tail trails down from your backside, swaying to and fro while giving you a dangerous air.", false);
	}
	if(player.tailType == 8) {
		outputText("  A soft " + player.hairColor + " cat-tail sprouts just above your " + buttDescript() + ", curling and twisting with every step to maintain perfect balance.", false);
	}
	if(player.tailType == 9) {
		outputText("  A tapered tail hangs down from just above your " + assDescript() + ".  It sways back and forth, assisting you with keeping your balance.", false);
	}
	if(player.tailType == 10) outputText("  A short, soft bunny tail sprouts just above your " + assDescript() + ", twitching constantly whenever you don't think about it.", false);
	else if(player.tailType == 11) outputText("  A tail of feathers fans out from just above your " + assDescript() + ", twitching instinctively to help guide you if you were to take flight.", false);
	else if(player.tailType == 12) {
		outputText("  A conical, ", false);
		if(player.skinType == 3) outputText("gooey, " + player.skinTone, false);
		else outputText("furry, " + player.hairColor, false);
		outputText(", tail extends from your " + assDescript() + ", bouncing up and down as you move and helping to counterbalance you.", false);
	}
	else if(player.tailType == 13) {
		if(player.tailVenom == 1) outputText("  A swishing, colorful fox's brush extends from your " + assDescript() + ", curling around your body - the soft fur feels lovely.");
		else outputText("  " + Num2Text(player.tailVenom) + " swishing, colorful fox's tails extend from your " + assDescript() + ", curling around your body - the soft fur feels lovely.");
	}
	else if(player.tailType == 14) {
		outputText("  A thin, scaly, prehensile reptilian tail, almost as long as you are tall, swings behind you like a living bullwhip.  Its tip menaces with spikes of bone, meant to deliver painful blows.");		
	}
	//appearance
	else if(player.tailType == 15) {
		outputText("  A black-and-" + player.hairColor + "-ringed raccoon tail waves behind you.");
	}
	else if(player.tailType == 16) {
		//appearance
		outputText("  A naked, " + player.skinTone + " mouse tail pokes from your butt, dragging on the ground and twitching occasionally.");
	}
	//LOWERBODY SPECIAL
	if(player.lowerBody == 0) outputText("  Two normal human legs grow down from your waist, ending in normal human feet.", false);
	else if(player.lowerBody == 1) outputText("  Your legs are muscled and jointed oddly, covered in fur, and end in a pair of bestial hooves.", false);
	else if(player.lowerBody == 2) outputText("  Two digitigrade legs grow downwards from your waist, ending in dog-like hind-paws.", false);
	else if(player.lowerBody == 3) outputText("  Below your waist your flesh is fused together into a very long snake-like tail.", false);
	//Horse body is placed higher for readability purposes
	else if(player.lowerBody == 5) outputText("  Your perfect lissom legs end in mostly human feet, apart from the horn protruding straight down from the heel that forces you to walk with a sexy, swaying gait.", false);
	else if(player.lowerBody == 6) outputText("  Your lithe legs are capped with flexible clawed feet.  Sharp black nails grow where once you had toe-nails, giving you fantastic grip.", false);
	else if(player.lowerBody == 7) outputText("  Your legs are covered in a shimmering insectile carapace up to mid-thigh, looking more like a pair of 'fuck-me-boots' than exoskeleton.  A bit of downy yellow and black fur fuzzes your upper thighs, just like a bee.", false);
	else if(player.lowerBody == 8) outputText("  In place of legs you have a shifting amorphous blob.  Thankfully it's quite easy to propel yourself around on.  The lowest portions of your " + player.armorName + " float around inside you, bringing you no discomfort.", false);
	else if(player.lowerBody == 9) outputText("  Two digitigrade legs grow downwards from your waist, ending in soft, padded cat-paws.", false);
	else if(player.lowerBody == 10) outputText("  Two digitigrade legs grow down from your " + hipDescript() + ", ending in clawed feet.  There are three long toes on the front, and a small hind-claw on the back.", false);
	else if(player.lowerBody == 12) outputText("  Your legs thicken below the waist as they turn into soft-furred rabbit-like legs.  You even have large bunny feet that make hopping around a little easier than walking.", false);
	else if(player.lowerBody == 13) outputText("  Your legs are covered with " + player.hairColor + " plumage.  Thankfully the thick, powerful thighs are perfect for launching you into the air, and your feet remain mostly human, even if they are two-toed and tipped with talons.", false);
	else if(player.lowerBody == 14) outputText("  Your furry legs have short thighs and long calves, with even longer feet ending in prominently-nailed toes.", false);
	else if(player.lowerBody == 15) outputText("  Your legs are covered in a reflective black, insectile carapace up to your mid-thigh, looking more like a pair of 'fuck-me-boots' than exoskeleton.", false);
	else if(player.lowerBody == 16) outputText("  Where your legs would normally start you have grown the body of a spider, with eight spindly legs that sprout from its sides.", false);
	else if(player.lowerBody == 17) outputText("  Your legs are crooked into high knees with hocks and long feet, like those of a fox; cute bulbous toes decorate the ends.");
	else if(player.lowerBody == 18) outputText("  Two human-like legs grow down from your " + hipDescript() + ", sheathed in scales and ending in clawed feet.  There are three long toes on the front, and a small hind-claw on the back.", false);
	else if(player.lowerBody == 19) outputText("  Your legs, though covered in fur, are humanlike.  Long feet on the ends bear equally long toes, and the pads on the bottoms are quite sensitive to the touch.");
	if(player.hasPerk("Incorporeality") >= 0) outputText("  Of course, your " + player.legs() + " are partially transparent due to their ghostly nature.", false);
	
	outputText("\n", false);
	//Pregnancy Shiiiiiitz
	if((player.buttPregnancyType == 23 && player.buttPregnancyIncubation > 0) || (player.buttPregnancyType == 19 && player.buttPregnancyIncubation > 0) || (player.pregnancyType > 0 && player.pregnancyIncubation > 0)) {
		if(player.pregnancyType == 5) {
			outputText("<b>", false);
			//Compute size
			temp = player.statusAffects[player.hasStatusAffect("eggs")].value3 + player.statusAffects[player.hasStatusAffect("eggs")].value2 * 10;
			if(player.pregnancyIncubation <= 50 && player.pregnancyIncubation > 20) {
				outputText("Your swollen pregnant belly is as large as a ", false);
				if(temp < 10) outputText("basketball.", false);
				if(temp >= 10 && temp < 20) outputText("watermelon.", false);
				if(temp >= 20) outputText("beach ball.", false);
			}
			if(player.pregnancyIncubation <= 20) {
				outputText("Your swollen pregnant belly is as large as a ", false);
				if(temp < 10) outputText("watermelon.", false);
				if(temp >= 10 && temp < 20) outputText("beach ball.", false);
				if(temp >= 20) outputText("large medicine ball.", false);
			}
			outputText("</b>", false);
			temp = 0;
		}
		//Satur preggos - only shows if bigger than regular pregnancy or not pregnancy
		else if((player.buttPregnancyType == 19 && player.buttPregnancyIncubation > 0) && (player.pregnancyIncubation == 0 || player.buttPregnancyIncubation > player.pregnancyIncubation)) {
			if(player.buttPregnancyIncubation < 125 && player.buttPregnancyIncubation >= 75) {
				outputText("<b>You've got the begginings of a small pot-belly.</b>", false);
			}
			else if(player.buttPregnancyIncubation >= 50) {
				outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy, yet it feels odd inside you - wrong somehow.</b>", false);	
			}
			else if(player.buttPregnancyIncubation >= 30) {
				outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>", false);
			}
			else {
				if(player.pregnancyType == 12 || player.pregnancyType == 4 || player.pregnancyType == 11 || player.pregnancyType == 17 || player.pregnancyType == 21) outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>", false);
				else if(player.pregnancyType != 8) outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>", false);
				else outputText("\n<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>", false);
			}
		}
		//URTA PREG
		else if(player.pregnancyType == 21) {
			trace("Urta Pregnancy detected, outputting descriptivez" + player.pregnancyIncubation);
			if(player.pregnancyIncubation <= 432 && player.pregnancyIncubation > 360) {
				outputText("<b>Your belly is larger than it used to be.</b>\n", false);
			}
			if(player.pregnancyIncubation <= 360 && player.pregnancyIncubation > 288) {
				outputText("<b>Your belly is more noticably distended.   You're pretty sure it's Urta's.</b>", false);
			}
			if(player.pregnancyIncubation <= 288 && player.pregnancyIncubation > 216) {
				outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy, and the baby within is kicking nowadays.</b>", false);	
			}
			if(player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 144) {
				outputText("<b>Your belly is large and very obviously pregnant to anyone who looks at you.  It's gotten heavy enough to be a pain to carry around all the time.</b>", false);		
			}
			if(player.pregnancyIncubation <= 144 && player.pregnancyIncubation > 72) {
				outputText("<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way.  It's large and round, frequently moving.</b>", false);
			}
			if(player.pregnancyIncubation <= 72 && player.pregnancyIncubation > 48) {
				outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>", false);
			}
			if(player.pregnancyIncubation <= 48) {
				outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>", false);
			}
		}
		else if(player.buttPregnancyType == 23) {
			if(player.buttPregnancyType >= 8) outputText("<b>Your stomach is so full of frog eggs that you look about to birth at any moment, your belly wobbling and shaking with every step you take, packed with frog ovum.</b>");
			else outputText("<b>You're stuffed so full with eggs that your belly looks obscenely distended, huge and weighted with the gargantuan eggs crowding your gut. They make your gait a waddle and your gravid tummy wobble obscenely.</b>");
		}
		else {
			trace("Pregnancy detected, outputting descriptivez" + player.pregnancyIncubation);
			if(player.pregnancyIncubation <= 336 && player.pregnancyIncubation > 280) {
				outputText("<b>Your belly is larger than it used to be.</b>", false);
			}
			if(player.pregnancyIncubation <= 280 && player.pregnancyIncubation > 216) {
				outputText("<b>Your belly is more noticably distended.   You are probably pregnant.</b>", false);
			}
			if(player.pregnancyIncubation <= 216 && player.pregnancyIncubation > 180) {
				outputText("<b>The unmistakable bulge of pregnancy is visible in your tummy.</b>", false);	
			}
			if(player.pregnancyIncubation <= 180 && player.pregnancyIncubation > 120) {
				outputText("<b>Your belly is very obviously pregnant to anyone who looks at you.</b>", false);		
			}
			if(player.pregnancyIncubation <= 120 && player.pregnancyIncubation > 72) {
				outputText("<b>It would be impossible to conceal your growing pregnancy from anyone who glanced your way.</b>", false);
			}
			if(player.pregnancyIncubation <= 72 && player.pregnancyIncubation > 48) {
				outputText("<b>Your stomach is painfully distended by your pregnancy, making it difficult to walk normally.</b>", false);
			}
			if(player.pregnancyIncubation <= 48) {
				if(player.pregnancyType == 12 || player.pregnancyType == 4 || player.pregnancyType == 11 || player.pregnancyType == 17 || player.pregnancyType == 21) outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the spawn of one of this land's natives.</b>", false);
				else if(player.pregnancyType != 8) outputText("\n<b>Your belly protrudes unnaturally far forward, bulging with the unclean spawn of some monster or beast.</b>", false);
				else outputText("\n<b>Your belly protrudes unnaturally far forward, bulging outwards with Marble's precious child.</b>", false);
			}
		}
		outputText("\n", false);
	}
	outputText("\n", false);
	if(player.gills) outputText("A pair of feathery gills are growing out just below your neck, spreading out horizontally and draping down your chest.  They allow you to stay in the water for quite a long time.  ", false);
	//Chesticles..I mean bewbz.
	if(player.breastRows.length == 1) {
		outputText("You have " + num2Text(player.breastRows[temp].breasts) + " " + breastDescript(temp) + ", each supporting ", false);
		if(player.breastRows[0].nipplesPerBreast == 1) outputText(num2Text(player.breastRows[temp].nipplesPerBreast) + " " + int(player.nippleLength*10)/10 + "-inch " + nippleDescript(temp) + ".", false);
		else outputText(num2Text(player.breastRows[temp].nipplesPerBreast) + " " + int(player.nippleLength*10)/10 + "-inch " + nippleDescript(temp) + "s.", false);
		if(player.breastRows[0].milkFullness > 75) outputText("  Your " + breastDescript(temp) + " are painful and sensitive from being so stuffed with milk.  You should release the pressure soon.", false);
		if(player.breastRows[0].breastRating >= 1) outputText("  You could easily fill a " + player.breastCup(temp) + " bra.", false);
		//Done with tits.  Move on.
		outputText("\n", false);
	}
	//many rows
	else {
		outputText("You have " + num2Text(player.breastRows.length) + " rows of breasts, the topmost pair starting at your chest.\n", false);
		while (temp < player.breastRows.length) {
			if(temp == 0) outputText("--Your uppermost rack houses ", false);
			if(temp == 1) outputText("\n--The second row holds ", false);
			if(temp == 2) outputText("\n--Your third row of breasts contains ", false);
			if(temp == 3) outputText("\n--Your fourth set of tits cradles ", false);
			if(temp == 4) outputText("\n--Your fifth and final mammory grouping swells with ", false);
			outputText(num2Text(player.breastRows[temp].breasts) + " " + breastDescript(temp) + " with ", false);
			if(player.breastRows[temp].nipplesPerBreast == 1) outputText(num2Text(player.breastRows[temp].nipplesPerBreast) + " " + int(player.nippleLength*10)/10 + "-inch " + nippleDescript(temp) + " each.", false);
			else outputText(num2Text(player.breastRows[temp].nipplesPerBreast) + " " + int(player.nippleLength*10)/10 + "-inch " + nippleDescript(temp) + "s each.", false);
			if(player.breastRows[temp].breastRating >= 1) outputText("  They could easily fill a " + player.breastCup(temp) + " bra.", false);
			if(player.breastRows[temp].milkFullness > 75) outputText("  Your " + breastDescript(temp) + " are painful and sensitive from being so stuffed with milk.  You should release the pressure soon.", false);
			temp++;
		}
		//Done with tits.  Move on.
		outputText("\n", false);
	}	
	//Crotchial stuff - mention snake
	if(player.lowerBody == 3 && player.gender > 0) {
		outputText("\nYour sex", false);
		if(player.gender == 3 || player.totalCocks() > 1) outputText("es are ", false);
		else outputText(" is ", false);
		outputText("concealed within a cavity in your tail when not in use, though when the need arises, you can part your concealing slit and reveal your true self.\n", false);
	}
	//Cock stuff!
	temp = 0;
	if(player.cocks.length == 1) {
		if(player.lowerBody==4) outputText("\nEver since becoming a centaur, your equipment has shifted to lie between your rear legs, like a horse.", false);
		outputText("\nYour " + cockDescript(temp) + " is " + int(10*player.cocks[temp].cockLength)/10 + " inches long and ", false);
		if(Math.round(10*player.cocks[temp].cockThickness)/10 < 2) {
			if(Math.round(10*player.cocks[temp].cockThickness)/10 == 1) outputText(int(10*player.cocks[temp].cockThickness)/10 + " inch thick.", false);
			else outputText(Math.round(10*player.cocks[temp].cockThickness)/10 + " inches thick.", false);
		}
		else outputText (num2Text(Math.round(10*player.cocks[temp].cockThickness)/10) + " inches wide.", false);
		//Horsecock flavor
		if(player.cocks[temp].cockType == CockTypesEnum.HORSE) {
			outputText("  It's mottled black and brown in a very animalistic pattern.  The 'head' of your shaft flares proudly, just like a horse's.", false);
		}
		//dog cock flavor
		if(player.cocks[temp].cockType == CockTypesEnum.DOG) {
			if(player.cocks[temp].knotMultiplier > 1 && player.cocks[temp].knotMultiplier < 1.4) outputText("  A small knot of thicker flesh is near the base of your " + cockDescript(temp) + ", ready to expand to help you lodge it inside a female.", false);
			if(player.cocks[temp].knotMultiplier >= 1.4 && player.cocks[temp].knotMultiplier < 1.8) outputText("  A large bulge of flesh nestles just above the bottom of your " + cockDescript(temp) + ", to ensure it stays where it belongs during mating.", false);
			if(player.cocks[temp].knotMultiplier >= 1.8) outputText("  The obscenely swollen lump of flesh near the base of your " + cockDescript(temp) + " looks almost too big for your cock.", false);
			//List thickness
			outputText("  The knot is " + Math.round(player.cocks[temp].cockThickness * player.cocks[temp].knotMultiplier * 10)/10 + " inches wide when at full size.", false);
		}
		//Demon cock flavor
		if(player.cocks[temp].cockType == CockTypesEnum.DEMON) {
			outputText("  The crown is ringed with a circle of rubbery protrusions that grow larger as you get more aroused.  The entire thing is shiny and covered with tiny, sensitive nodules that leave no doubt about its demonic origins.", false);
		}
		//Tentacle cock flavor
		if(player.cocks[temp].cockType == CockTypesEnum.TENTACLE) {
			outputText("  The entirety of its green surface is covered in perspiring beads of slick moisture.  It frequently shifts and moves of its own volition, the slightly oversized and mushroom-like head shifting in coloration to purplish-red whenever you become aroused.", false);
		}
		//Cat cock flavor
		if(player.cocks[temp].cockType == CockTypesEnum.CAT) {
			outputText("  It ends in a single point, much like a spike, and is covered in small, fleshy barbs. The barbs are larger at the base and shrink in size as they get closer to the tip.  Each of the spines is soft and flexible, and shouldn't be painful for any of your partners.", false);
		}
		//Snake cock flavor
		if(player.cocks[temp].cockType == CockTypesEnum.LIZARD) {
			outputText("  It's a deep, iridescent purple in color.  Unlike a human penis, the shaft is not smooth, and is instead patterned with multiple bulbous bumps.", false);
		}
		//Anemone cock flavor
		if(player.cocks[temp].cockType == CockTypesEnum.ANEMONE) {
			outputText("  The crown is surrounded by tiny tentacles with a venomous, aphrodisiac payload.  At its base a number of similar, longer tentacles have formed, guaranteeing that pleasure will be forced upon your partners.", false);
		}
		//Kangawang flavor
		if(player.cocks[temp].cockType == CockTypesEnum.KANGAROO) {
			outputText("  It usually lies coiled inside a sheath, but undulates gently and tapers to a point when erect, somewhat like a taproot.", false);
		}
		//Draconic Cawk Flava flav
		if(player.cocks[temp].cockType == CockTypesEnum.DRAGON) {
			outputText("  With its tapered tip, there are few holes you wouldn't be able to get into.  It has a strange, knot-like bulb at its base, but doesn't usually flare during arousal as a dog's knot would.");
		}
		//Worm flavor
		if(player.hasStatusAffect("infested") >= 0) 
			outputText("  Every now and again a slimy worm coated in spunk slips partway out of your " + cockDescript(0) + ", tasting the air like a snake's tongue.", false);		
		if(player.cocks[temp].sock) 
			sockDescript(temp);
		//DONE WITH COCKS, moving on!
		outputText("\n", false);
	}
	if(player.cocks.length > 1) 
	{
		temp = 0;
		rando = rand(4);
		if(player.lowerBody == 4) outputText("\nWhere a horse's penis would usually be located, you have instead grown " + multiCockDescript() + "!\n", false);
		else outputText("\nWhere a penis would normally be located, you have instead grown " + multiCockDescript() + "!\n", false);
		while(temp < player.cocks.length) 
		{
			
			//middle cock description
			if(rando == 0) {
				if(temp == 0)outputText("-Your first ", false);
				else outputText("-Your next ", false);
				outputText(cockDescript(temp), false);
				outputText(" is ", false);
				outputText(int(10*player.cocks[temp].cockLength)/10 + " inches long and ", false)
				if(Math.floor(player.cocks[temp].cockThickness) >= 2) outputText(num2Text(Math.round(player.cocks[temp].cockThickness * 10)/10) + " inches wide.", false);
				else {
					if(player.cocks[temp].cockThickness == 1) outputText("one inch wide.", false);
					else outputText(Math.round(player.cocks[temp].cockThickness*10)/10 + " inches wide.", false);
				}
			}
			if(rando == 1) {
				outputText("-One of your ", false);
				outputText(cockDescript(temp) + "s is " + Math.round(10*player.cocks[temp].cockLength)/10 + " inches long and ", false);
				if(Math.floor(player.cocks[temp].cockThickness) >= 2) outputText(num2Text(Math.round(player.cocks[temp].cockThickness * 10)/10) + " inches thick.", false);
				else {
					if(player.cocks[temp].cockThickness == 1) outputText("one inch thick.", false);
					else outputText(Math.round(player.cocks[temp].cockThickness*10)/10 + " inches thick.", false);
				}
			}
			if(rando == 2) {
				if(temp > 0) outputText("-Another of your ", false);
				else outputText("-One of your ", false);
				outputText(cockDescript(temp) + "s is " + Math.round(10*player.cocks[temp].cockLength)/10 + " inches long and ", false);
				if(Math.floor(player.cocks[temp].cockThickness) >= 2) outputText(num2Text(Math.round(player.cocks[temp].cockThickness * 10)/10) + " inches thick.", false);
				else {
					if(player.cocks[temp].cockThickness == 1) outputText("one inch thick.", false);
					else outputText(Math.round(player.cocks[temp].cockThickness*10)/10 + " inches thick.", false);
				}
			}
			if(rando == 3) {
				if(temp > 0) outputText("-Your next ", false);
				else outputText("-Your first ", false);
				outputText(cockDescript(temp) + " is " + Math.round(10*player.cocks[temp].cockLength)/10 + " inches long and ", false);
				if(Math.floor(player.cocks[temp].cockThickness) >= 2) outputText(num2Text(Math.round(player.cocks[temp].cockThickness * 10)/10) + " inches in diameter.", false);
				else {
					if(Math.round(player.cocks[temp].cockThickness*10)/10 == 1) outputText("one inch in diameter.", false);
					else outputText(Math.round(player.cocks[temp].cockThickness*10)/10 + " inches in diameter.", false);
				}
			}
			//horse cock flavor
			if(player.cocks[temp].cockType == CockTypesEnum.HORSE) {
				outputText("  It's mottled black and brown in a very animalistic pattern.  The 'head' of your " + cockDescript(temp) + " flares proudly, just like a horse's.", false);
			}
			//dog cock flavor
			if(player.cocks[temp].cockType == CockTypesEnum.DOG) {
				outputText("  It is shiny, pointed, and covered in veins, just like a large dog's cock.", false);
				if(player.cocks[temp].knotMultiplier > 1 && player.cocks[temp].knotMultiplier < 1.4) outputText("  A small knot of thicker flesh is near the base of your " + cockDescript(temp) + ", ready to expand to help you lodge your " + cockDescript(temp) + " inside a female.", false);
				if(player.cocks[temp].knotMultiplier >= 1.4 && player.cocks[temp].knotMultiplier < 1.8) outputText("  A large bulge of flesh nestles just above the bottom of your " + cockDescript(temp) + ", to ensure it stays where it belongs during mating.", false);
				if(player.cocks[temp].knotMultiplier >= 1.8) outputText("  The obscenely swollen lump of flesh near the base of your " + cockDescript(temp) + " looks almost comically mismatched for your " + cockDescript(temp) + ".", false);
				//List knot thickness
				outputText("  The knot is " + Math.floor(player.cocks[temp].cockThickness * player.cocks[temp].knotMultiplier * 10)/10 + " inches thick when at full size.", false);
			}
			//Demon cock flavor
			if(player.cocks[temp].cockType == CockTypesEnum.DEMON) {
				outputText("  The crown is ringed with a circle of rubbery protrusions that grow larger as you get more aroused.  The entire thing is shiny and covered with tiny, sensitive nodules that leave no doubt about its demonic origins.", false);
			}
			//Tentacle cock flavor
			if(player.cocks[temp].cockType == CockTypesEnum.TENTACLE) {
				outputText("  The entirety of its green surface is covered in perspiring beads of slick moisture.  It frequently shifts and moves of its own volition, the slightly oversized and mushroom-like head shifting in coloration to purplish-red whenever you become aroused.", false);
			}
			//Cat cock flavor
			if(player.cocks[temp].cockType == CockTypesEnum.CAT) {
				outputText("  It ends in a single point, much like a spike, and is covered in small, fleshy barbs. The barbs are larger at the base and shrink in size as they get closer to the tip.  Each of the spines is soft and flexible, and shouldn't be painful for any of your partners.", false);
			}
			//Snake cock flavor
			if(player.cocks[temp].cockType == CockTypesEnum.LIZARD) {
				outputText("  It's a deep, iridescent purple in color.  Unlike a human penis, the shaft is not smooth, and is instead patterned with multiple bulbous bumps.", false);
			}
			//Anemone cock flavor
			if(player.cocks[temp].cockType == CockTypesEnum.ANEMONE) {
				outputText("  The crown is surrounded by tiny tentacles with a venomous, aphrodisiac payload.  At its base a number of similar, longer tentacles have formed, guaranteeing that pleasure will be forced upon your partners.", false);
			}
			//Kangwang flavor
			if(player.cocks[temp].cockType == CockTypesEnum.KANGAROO) {
				outputText("  It usually lies coiled inside a sheath, but undulates gently and tapers to a point when erect, somewhat like a taproot.", false);
			}
			//Draconic Cawk Flava flav
			if(player.cocks[temp].cockType == CockTypesEnum.DRAGON) {
				outputText("  With its tapered tip, there are few holes you wouldn't be able to get into.  It has a strange, knot-like bulb at its base, but doesn't usually flare during arousal as a dog's knot would.");
			}
			if(player.cocks[temp].sock != "" && player.cocks[temp].sock != null)	// I dunno what was happening, but it looks like .sock is null, as it doesn't exist. I guess this is probably more left over from some of the restucturing.
			{																		// Anyways, check against null values, and stuff works again.
				trace("Found a sock description (WTF even is a sock?)", player.cocks[temp].sock);
				sockDescript(temp);
			}
			temp++;
			rando++
			outputText("\n", false);
			if(rando > 3) rando = 0;
		}
		//Worm flavor
		if(player.hasStatusAffect("infested") >= 0) outputText("Every now and again slimy worms coated in spunk slip partway out of your " + multiCockDescriptLight() + ", tasting the air like tongues of snakes.\n", false);
		//DONE WITH COCKS, moving on!
	}
	//Of Balls and Sacks!
	if(player.balls > 0) {
		if(player.hasStatusAffect("Uniball") >= 0) {
			if(player.skinType != 3) outputText("Your [sack] clings tightly to your groin, holding " + ballsDescript() + " snugly against you.");
			else if(player.skinType == 3) outputText("Your [sack] clings tightly to your groin, dripping and holding " + ballsDescript() + " snugly against you.");
		}
		else if(player.cockTotal() == 0) {
			if(player.skinType == 0) outputText("A " + sackDescript() + " with " + ballsDescript() + " swings heavily under where a penis would normally grow.", false);
			if(player.skinType == 1) outputText("A fuzzy " + sackDescript() + " filled with " + ballsDescript() + " swings low under where a penis would normally grow.", false);
			if(player.skinType == 2) outputText("A scaley " + sackDescript() + " hugs your " + ballsDescript() + " tightly against your body.", false);
			if(player.skinType == 3) outputText("An oozing, semi-solid sack with " + ballsDescript() + " swings heavily under where a penis would normally grow.", false);
		}
		else {
			if(player.skinType == 0) outputText("A " + sackDescript() + " with " + ballsDescript() + " swings heavily beneath your " + multiCockDescriptLight() + ".", false);
			if(player.skinType == 1) outputText("A fuzzy " + sackDescript() + " filled with " + ballsDescript() + " swings low under your " + multiCockDescriptLight() + ".", false);
			if(player.skinType == 2) outputText("A scaley " + sackDescript() + " hugs your " + ballsDescript() + " tightly against your body.", false);
			if(player.skinType == 3) outputText("An oozing, semi-solid sack with " + ballsDescript() + " swings heavily beneath your " + multiCockDescriptLight() + ".", false);
		}
		outputText("  You estimate each of them to be about " + num2Text(Math.round(player.ballSize)) + " ", false);
		if(Math.round(player.ballSize) == 1) 
			outputText("inch", false);
		else outputText("inches", false);
		outputText(" across.\n", false);
	}	
	//VAGOOZ
	if(player.vaginas.length > 0) {
		if(player.gender == 2 && player.lowerBody == 4) outputText("\nEver since becoming a centaur, your womanly parts have shifted to lie between your rear legs, in a rather equine fashion.", false);
		outputText("\n", false);
		if(player.vaginas.length == 1) outputText("You have a " + vaginaDescript(0) + ", with a " + int(player.clitLength*10)/10 + "-inch clit", false);
		if(player.vaginas[0].virgin) outputText(" and an intact hymen", false);
		outputText(".  ", false);
		if(player.vaginas.length > 1) outputText("You have " + player.vaginas.length+ " " + vaginaDescript(0) + "s, with " + int(player.clitLength*10)/10 + "-inch clits each.  ", false);
		if(player.lib < 50 && player.lust < 50) //not particularly horny
		{
			//Wetness
			if(player.vaginas[0].vaginalWetness >= 2 && player.vaginas[0].vaginalWetness< 4) outputText("Moisture gleams in ", false);
			if(player.vaginas[0].vaginalWetness>= 4) {
				outputText("Occasional beads of ", false);
				outputText("lubricant drip from ", false);
			}				
			//Different description based on vag looseness
			if(player.vaginas[0].vaginalWetness>= 2) {
				if(player.vaginas[0].vaginalLooseness< 2) outputText("your " + vaginaDescript(0) + ". ", false);
				if(player.vaginas[0].vaginalLooseness>= 2 && player.vaginas[0].vaginalLooseness< 4) outputText("your " + vaginaDescript(0) + ", its lips slightly parted. ", false);
				if(player.vaginas[0].vaginalLooseness>= 4) outputText("the massive hole that is your " + vaginaDescript(0) + ".  ", false);
			}
		}
		if((player.lib>=50 || player.lust >=50) && (player.lib< 80 && player.lust < 80)) //kinda horny
		{
			//Wetness
			if(player.vaginas[0].vaginalWetness< 2) outputText("Moisture gleams in ", false);
			if(player.vaginas[0].vaginalWetness>= 2 && player.vaginas[0].vaginalWetness< 4) {
				outputText("Occasional beads of ", false);
				outputText("lubricant drip from ", false);
			}
			if(player.vaginas[0].vaginalWetness>= 4) {
				outputText("Thin streams of ", false);
				outputText("lubricant occasionally dribble from ", false);
			}				
			//Different description based on vag looseness
			if(player.vaginas[0].vaginalLooseness< 2) outputText("your " + vaginaDescript(0) + ". ", false);
			if(player.vaginas[0].vaginalLooseness>= 2 && player.vaginas[0].vaginalLooseness< 4) outputText("your " + vaginaDescript(0) + ", its lips slightly parted. ", false);
			if(player.vaginas[0].vaginalLooseness>= 4) outputText("the massive hole that is your " + vaginaDescript(0) + ".  ", false);
		}
		if((player.lib> 80 || player.lust > 80)) //WTF horny!
		{
			//Wetness
			if(player.vaginas[0].vaginalWetness< 2) 
			{
				outputText("Occasional beads of ", false);
				outputText("lubricant drip from ", false);
			}
			if(player.vaginas[0].vaginalWetness>= 2 && player.vaginas[0].vaginalWetness< 4)
			{
				outputText("Thin streams of ", false);
				outputText("lubricant occasionally dribble from ", false);
			}
			if(player.vaginas[0].vaginalWetness>= 4) 
			{
				outputText("Thick streams of ", false);
				outputText("lubricant drool constantly from ", false);
			}				
			//Different description based on vag looseness
			if(player.vaginas[0].vaginalLooseness< 2) outputText("your " + vaginaDescript(0) + ". ", false);
			if(player.vaginas[0].vaginalLooseness>= 2 && player.vaginas[0].vaginalLooseness< 4) outputText("your " + vaginaDescript(0) + ", its lips slightly parted. ", false);
			if(player.vaginas[0].vaginalLooseness>= 4) outputText("the massive hole that is your cunt.  ", false);
		}
		//Line Drop for next descript!
		outputText("\n", false);
	}
	//Genderless lovun'
	if(player.cockTotal() == 0 && player.vaginas.length == 0) outputText("\nYou have a curious lack of any sexual endowments.\n", false);
	
	
	//BUNGHOLIO
	if(player.ass != undefined) {
		outputText("\n", false);
		outputText("You have one " + assholeDescript() + ", placed between your " + buttDescript() + "-cheeks where it belongs.\n", false);
	}
	//Piercings!
	if(player.eyebrowPierced > 0) outputText("\nA solitary " + player.eyebrowPShort + " adorns your eyebrow, looking very stylish.", false);
	if(player.earsPierced > 0) outputText("\nYour ears are pierced with " + player.earsPShort + ".", false);
	if(player.nosePierced > 0) outputText("\nA " + player.nosePShort + " dangles from your nose.", false);
	if(player.lipPierced > 0) outputText("\nShining on your lip, a " + player.lipPShort + " is plainly visible.", false);
	if(player.tonguePierced > 0) outputText("\nThough not visible, you can plainly feel your " + player.tonguePShort + " secured in your tongue.", false);
	if(player.nipplesPierced == 3) outputText("\nYour " + nippleDescript(0) + "s ache and tingle with every step, as your heavy " + player.nipplesPShort + " swings back and forth.", false);
	else if(player.nipplesPierced > 0) outputText("\nYour " + nippleDescript(0) + "s are pierced with " + player.nipplesPShort + ".", false);
	if(player.totalCocks() > 0) {
		if(player.cocks[0].pierced > 0) outputText("\nLooking positively perverse, a " + player.cocks[0].pShortDesc + " adorns your " + cockDescript(0) + ".", false);
	}
	if(flags[UNKNOWN_FLAG_NUMBER_00286] == 1) outputText("\nA magical, ruby-studded bar pierces your belly button, allowing you to summon Ceraph on a whim.", false);
	if(player.hasVagina()) {
		if(player.vaginas[0].labiaPierced > 0) outputText("\nYour " + vaginaDescript(0) + " glitters with the " + player.vaginas[0].labiaPShort + " hanging from your lips.", false);
		if(player.vaginas[0].clitPierced > 0) outputText("\nImpossible to ignore, your " + clitDescript() + " glitters with its " + player.vaginas[0].clitPShort + ".", false);
	}
	//MONEY!
	if(player.gems == 0) outputText("\n\n<b>Your money-purse is devoid of any currency.", false);
	if(player.gems > 1) outputText("\n\n<b>You have " + player.gems + " shining gems, collected in your travels.", false);
	if(player.gems == 1) outputText("\n\n<b>You have " + player.gems + " shining gem, collected in your travels.", false);
	mainText.htmlText = currentText;
	scrollBar.update();
	//menu();
	//addButton(0,"Next",camp);
}

function sockDescript(index:int):void {
	outputText("  ");
	if(player.cocks[index].sock == "wool") 
		outputText("It's covered by a wooly white cock-sock, keeping it snug and warm despite how cold it might get.");
	else if(player.cocks[index].sock == "alabaster") 
		outputText("It's covered by a white, lacey cock-sock, snugly wrapping around it like a bridal dress around a bride.");
	else if(player.cocks[index].sock == "cockring") 
		outputText("It's covered by a black latex cock-sock with two attached metal rings, keeping your cock just a little harder and [balls] aching for release.");
	else if(player.cocks[index].sock == "viridian") 
		outputText("It's covered by a lacey dark green cock-sock accented with red rose-like patterns.  Just wearing it makes your body, especially your cock, tingle.");
	else if(player.cocks[index].sock == "scarlet") 
		outputText("It's covered by a lacey red cock-sock that clings tightly to your member.  Just wearing it makes your cock throb, as if it yearns to be larger...");
	else if(player.cocks[index].sock == "cobalt") 
		outputText("It's covered by a lacey blue cock-sock that clings tightly to your member... really tightly.  It's so tight it's almost uncomfortable, and you wonder if any growth might be inhibited.");
	else if(player.cocks[index].sock == "gilded") 
		outputText("It's covered by a metallic gold cock-sock that clings tightly to you, its surface covered in glittering gems.  Despite the warmth of your body, the cock-sock remains cool.");
	else if(player.cocks[index].sock == "amaranthine") 
	{
		outputText("It's covered by a lacey purple cock-sock");
		if(player.cocks[index].cockType != CockTypesEnum.DISPLACER) 
			outputText(" that fits somewhat awkwardly on your member");
		else
			outputText(" that fits your coeurl cock perfectly");
		outputText(".  Just wearing it makes you feel stronger and more powerful.");
	}
	else outputText("<b>Yo, this is an error.</b>");
}