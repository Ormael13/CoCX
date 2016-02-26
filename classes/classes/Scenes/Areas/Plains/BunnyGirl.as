package classes.Scenes.Areas.Plains{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	public class BunnyGirl extends BaseContent{
		public function isItEaster():Boolean {
			return (date.date >= 30 && date.date <= 31 && date.month == 2) || (date.month == 3 && date.date <= 1);
		}

//Easter Bunny 
//5'4", small B cup breasts.
//14" Human dick with a pointed head.  A pair of egg-shaped testes.
//Egg preg changes – Bunny Ears, Bunny Tail, Bunny Legs?, Hot pink nose & whiskers?

public function bunnbunbunMeet():void {
	clearOutput();
	spriteSelect(13);
	if (flags[kFLAGS.MET_BUNBUN] == 0) {
		outputText("A ", false);
		if (player.tallness > 64) outputText("short ", false);
		outputText("bunny-girl appears from behind some bushes, hopping about and clutching a basket full of multicolored eggs tightly in front of her muscular, fur-covered thighs.  She hops around a few times, peering closely at the ground as if searching for something.  Her slow, deliberate hopping comes to an end as she looks up and spots you.  The bunny's eyes widen into shocked dinner-plates, like she's utterly amazed someone saw her.  She freezes completely still, watching you, and you're given the chance to give her a good looking over.\n\n", false);
		
		outputText("Starting above the bunny's hips, her fur vanishes into dusky, olive skin, save for two 'poofs' of fur that ring her wrists like bracelets and a large, fluffy white tail above her butt-cheeks. It twitches nigh-constantly, the only part of the girl that's moving.  Her breasts are small - perhaps B-cups – and pear-shaped.  A tight, bright pink nipple perches atop each tiny tit's fleshy swell, hard from arousal or cold. Her face is human save for a bright pink nose and a few whiskers that sprout from the freckles on her cheeks.  The strange woman's groin is concealed behind the basket, ", false);
		
		if (player.lib > 50) outputText("and you find yourself wondering what sort of treasures she conceals behind it.", false);
		else if (player.cor < 40) outputText("and you find yourself thankful for her modesty.", false);
		else outputText("and you find yourself considering tearing away the basket so you can see what she's hiding down there.", false);
		outputText("\n\n", false);
		
		outputText("Even though nearly a minute has passed, the bunny-lass is STILL frozen and staring.  She hasn't done anything since realizing that you're looking at her.  Well, it looks like the ball's in your court.  What do you do?", false);
		//[Talk] [Rape Her]
		simpleChoices("Talk", talkToBunnyBunBun, "Rape Her", rapeBunBun, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
	}
	//Met her
	else {
		//Bunbunsplosions!
		if (rand(6) == 0 || (isEaster() && rand(3) == 0)) {
			adjathaEggsplosions();
			return;
		}
		outputText("While exploring the plains, you spy the familiar ears of a bunny-girl bobbing up and down behind a particularly tall patch of grasses.  You peek over the top of the grasses to find the dusky-skinned rabbit-girl playing with herself.  Both of her dainty, dextrous hands are clamped tightly around the wet, dripping length of her 14-inch cock as she hammers at the ground with her feet and humps away at her tightly-balled fists.\n\n", false);
		outputText("You lean forwards for a better look, dislodging a small pebble with your " + player.foot() + " while shifting position.  The bunny-girl leaps to her feet in a panic until her terrified irises lock onto your " + player.face() + ".  Her panic turns to embarrassment and in a flash every inch of her tanned skin is colored red.  She asks, \"<i>Ummm, since I'm still in s-season, c-could we b-breed or something?  Maybe just a little fuck?</i>\"\n\n", false);
		
		outputText("She claps both hands over her mouth, leaving her swollen prick to bounce precipitously while she awaits your response.\n\n", false);
		
		outputText("(If you're going to sex her, which of her body parts will you use?", false);
		dynStats("lus", 5+player.lib/20);
		var DickInV:Function = null;
		var Vagina:Function = null;
		var sixtyNine:Function = null;
		var eggs:Function = null;
		if (player.cockThatFits(40) >= 0) {
			Vagina = bunbunGetsFucked;
			outputText("  Fuck her vagina?", false);
		}
		else if (player.cockTotal() > 0) outputText("  <b>You're too to big fit inside her...</b>", false);
		
		//Dick requires one 40 area or smaller.
		if (player.hasVagina()) {
			DickInV = bunbunFucksYourVag;
			outputText("  Her dick in your vagina?", false);
		}
		if (player.gender > 0) {
			sixtyNine = bunbun69;
			outputText("  Sixty-nine her?", false);
		}
		
		if (player.canOviposit() && player.lust >= 33) {
			if (!player.canOvipositBee() || rand(2) == 0)
				eggs = ovipositBunnyEaster;
			else
				eggs = layEggsInBunbuns;
		}
		
		outputText("  Her dick in your ass?)", false);
		//var Ass:Number = 0;
		//Dick In V] [Dick in A] [Vagina] [Ass] [Leave]
		choices("Your Vagina", DickInV, "Her Vagina", Vagina, "69", sixtyNine, "LayYourEggs", eggs, "Your Ass", bunbunFucksPCInAss,
			"", null, "", null, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
	}
}
//[Talk]
private function talkToBunnyBunBun():void {
	spriteSelect(13);
	flags[kFLAGS.MET_BUNBUN]++;
	clearOutput();
	outputText("You slowly introduce yourself, and let the bunny-girl know that you mean her no harm. She doesn't move until you finish, but as you conclude she visibly relaxes and nods.  It doesn't stop her tail from twitching, and if anything, her nose joins it in twitching, but she asks, \"<i>How is it you can see me?  I've got a lot of eggs to hide and normally no one sees me.</i>\"\n\n", false);
	
	outputText("A shrug of your shoulders is the only answer you've got.  Does she think she's some kind of invisible bunny?  How crazy is that!\n\n", false);
	
	if (isEaster()) outputText("She sighs and wipes the sweat from her brow with one of the bracelet-like fur-poofs on her wrist as she tries to explain, \"<i>I've got to put out all these eggs! It's my duty! Once every year I turn invisible and go around hiding eggs for children to find.  It's a family duty that's been passed down for generations.  I seem to have gotten lost though.  I've never been anywhere like this and the food here makes me so terribly hot. It's like I just want to fuck and lay eggs all day!</i>\"\n\n", false);
	else outputText("She sighs and wipes the sweat from her brow with one of the bracelet-like fur-poofs on her wrist as she tries to explain, \"<i>I've got all these eggs to get rid of.  I'm not supposed to make so many, but I keep going into season over and over again that I make sooo many.  The worst part is every time I pop out a few eggs I want to do it even more the next time.  It's like I just want to fuck and lay eggs all day!</i>\"\n\n", false);
	
	outputText("Rose color erupts on her face as she drops her basket and covers her mouth, \"<i>Did I just say fuck!? EEP!</i>\"  With her basket no longer in hand, her groin is revealed!  A mammoth, 14-inch dong bounces proudly between her legs.  It's veiny and tipped with a narrow head while a pair of egg-shaped orbs bounce in the sack underneath it.  She jumps and tries to cover it up again, but all she succeeds in doing is accidentally giving it a stroke.  A dollop of pre-cum squirts onto her hand as she moans without thinking, \"<i>Ooooh damn I need to breed.</i>\"\n\n", false);
	
	outputText("In no time flat she's on her back, playing with herself and lifting her balls to expose a bubblegum-pink gash.  You could 'help' her with that or you could leave.  Of course if you leave you doubt you'll find her again.  Maybe a good fucking will clear her head long enough for her to figure out how to leave this land and return to wherever she came from?\n\n", false);
	outputText("(If you're going to sex her, which of her body parts will you use?", false);
	var DickInV:Function = null;
	var Vagina:Function = null;
	var sixtyNine:Function = null;
	//Dick requires one 40 area or smaller.
	if (player.hasVagina()) {
		DickInV = bunbunFucksYourVag;
		outputText("  Her dick in your vagina?", false);
	}
	if (player.cockThatFits(40) >= 0) {
		Vagina = bunbunGetsFucked;
		outputText("  Fuck her vagina?", false);
	}
	else if (player.cockTotal() > 0) outputText("  <b>You're too big to fit inside her...</b>", false);
	if (player.gender > 0) {
		sixtyNine = bunbun69;
		outputText("  Sixty-nine her?", false);
	}
	outputText("  Her dick in your ass?)", false);
	//var Ass:Number = 0;
	//Dick In V] [Dick in A] [Vagina] [Ass] [Leave]
	simpleChoices("Your Vagina",DickInV,"Your Ass",bunbunFucksPCInAss,"Her Vagina",Vagina,"69",sixtyNine,"Leave",camp.returnToCampUseOneHour);
	dynStats("lus", 5+player.lib/20);
}
//[Rape Her]
private function rapeBunBun():void {
	spriteSelect(13);
	clearOutput();
	if (player.spe < 60) {
		outputText("You lunge forward off your " + player.feet() + ", trying to tackle and pin the poor girl, but at the first sign of movement from you, she bounds off in the other direction!  She's hopping so fast there's no way you could possibly catch her, and in a matter of seconds you're left totally alone.  Well, perhaps not TOTALLY alone – there's one small egg nestled in the grass.  It fell from the bunny's basket in her haste to flee!", false);
		//(pick and loot random egg)
		inventory.takeItem(consumables.NPNKEGG, camp.returnToCampUseOneHour);
	}
	//[Rape Her Faster]
	else {
		flags[kFLAGS.MET_BUNBUN]++;
		outputText("You lunge forward off your " + player.feet() + ", trying to tackle and pin the poor girl, but at the first sign of movement from you,  she launches herself up and back with a powerful hop.  She didn't count on your speed, and you manage to tackle her mid-air.  Both of you slam into the ground, the bunny pinned tightly underneath you.  Her basket and eggs went flying when you hit her, and now there's a few dozen eggs scattered in the tall grass.   The girl wriggles, trying to squeeze out of your grip, but you hold firm to her as she cries, \"<i>YOU MEANIE!</i>\"\n\n", false);
	
		outputText("Your belly feels warm and wet, and as you pull back to examine the bunny, the source of the moisture is revealed.  The girl isn't a girl at all!  She's got a hard 14-inch dick and a pair of bouncing, egg-sized balls that are working quite hard to leak bunny-cum onto you.  You reach down underneath the orbs and thankfully find another source of wetness.  At least you weren't completely wrong!  You're dealing with a hermaphrodite, and a horny one at that.  Why would she bother resisting when her body is so thrilled to be so close to you?\n\n", false);
		
		outputText("The horny bun-herm follows your gaze and breaks into a slowly spreading grin, revealing a pair of cute buck-teeth as she asks, \"<i>Oh, you just wanted to fuck?  Why didn't you just ask?  I thought you were going to eat me!</i>\"  Her confident declaration does little to hide the bright red blush coloring her cheeks, making it clear this situation is a little strange to her.\n\n", false);
		
		dynStats("lus", 10, "cor", 3);
		outputText("(If you're going to sex her, which of her body parts will you use?", false);
		var DickInV:Function = null;
		var Vagina:Function = null;
		var sixtyNine:Function = null;
		//Dick requires one 40 area or smaller.
		if (player.hasVagina()) {
			DickInV = bunbunFucksYourVag;
			outputText("  Her dick in your vagina?", false);
		}
		if (player.cockThatFits(40) >= 0) {
			Vagina = bunbunGetsFucked;
			outputText("  Fuck her vagina?", false);
		}
		else if (player.cockTotal() > 0) outputText("  <b>You're too big to fit inside her...</b>", false);
		if (player.gender > 0) {
			sixtyNine = bunbun69;
			outputText("  Sixty-nine her?", false);
		}
		outputText("  Her dick in your ass?)", false);
		//var Ass:Number = 0;
		//Dick In V] [Dick in A] [Vagina] [Ass] [Leave]
		simpleChoices("Your Vagina",DickInV,"Your Ass",bunbunFucksPCInAss,"Her Vagina",Vagina,"69",sixtyNine,"Leave",camp.returnToCampUseOneHour);

	}
}

//[Take Dick in Vag Fukked]
private function bunbunFucksYourVag():void {
	spriteSelect(13);
	clearOutput();
	outputText("A anticipatory grin widens across your " + player.face() + " as you speedily disrobe, discarding your " + player.armorName, false);
	
	if (player.weaponName != "fists") outputText(" and " + player.weaponName, false);
	outputText(" in a hurry.   Meanwhile the bunny looks on in a semi-aroused stupor, stroking her length with one hand while her other teases one of the hard nubs of her nipples.  You sigh with excitement as you position yourself above her, lining up her somewhat angular crown with the entrance to your " + player.vaginaDescript(0) + " before you start to drop.", false);
	if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_DROOLING) outputText("  Moisture leaks in a steady drizzle, mixing with bunny-pre to totally slick the soon-to-be invading member.", false);
	outputText("\n\n", false);
	
	outputText("Gasping hotly, you swallow her pointed tip into your depths, feeling the rabbit-like girl's tip swell and pump out a few more drops of lube", false);
	if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLICK) outputText(", not that you needed it", false);
	outputText(".  You don't need any more encouragement.  The long, slow slide down her thick bunny-dick is heavenly, as the veins on its surface scratch your 'itch' in just the right way.  ", false);
	if (player.vaginalCapacity() < 20) outputText("By the time you're getting close to the bottom you have to work to encompass her length and girth within your velvet folds and grunt with discomfort from each new inch of throbbing fuck-stick, but you take it all.  ", false);
	else if (player.vaginalCapacity() < 50) outputText("By the time you get to the bottom you're panting and moaning, delighting in the feeling of being so perfectly impaled on a rigid fuck-stick.   With her entirely inside you, you're ready to fuck her in earnest.  ", false);
	else outputText("It doesn't take long to slide down the more-than footlong meat-pole, and to be honest you wish she was a bit bigger.  Your " + player.vaginaDescript(0) + " is so ready for big dicks that this disproportionate member is average at best.  Still, you clench your thigh muscles to wring it a little tighter, and swoon from the feeling of warm maleness filling your loins.  ", false);
	player.cuntChange(35, true);
	outputText("\n\n", false);
	
	outputText("While the bunny was content to remain passive up until this point, a fire lights in her eyes now that she's had a taste of pussy.  Her petite hands grab hold of your " + player.assDescript() + " while she pulls her powerful, oddly-jointed legs underneath of her.  A split second later she pushes up with enough force to bounce you a few inches into the air before you drop down on top of her.  ", false);
	if (player.tallness >= 72) {
		outputText("Your sheer weight makes her grunt in discomfort when you land back atop her, but the squish of copious sexual fluids nearly drowns it out. She even squirts another thick gout of pre inside you.  ", false);
		if (player.cor < 33) outputText("You'll have to try to slow your descent next time!  ", false);
		else outputText("If she's going to fuck you like this, she can handle your weight!  ", false);
	}
	else outputText("Your bodies clap together with a loud squish of copious sexual fluids, and another thick burble of pre warms your cunny.  ", false);
	outputText("How much pre-cum can she squirt?!\n\n", false);
	
	outputText("You reach down and grab the bunny's hips for support as she bounces you again, higher this time.  A solid five or six inches of her length slide in and out of your " + player.vaginaDescript(0) + " before you slap into her, and a split second later, you're airborne again.  She bounces you harder and harder until each thrust of her muscled thighs is launching you nearly a foot off her loins and letting gravity guide you back down her shaft.", false);
	if (player.clitLength >= 4) outputText("  Your " + player.clitDescript() + " bounces on her belly, tingling like mad every time it slaps into her tanned, sweat-slicked skin.", false);
	if (player.biggestLactation() >= 1) outputText("  Milk begins to bead on your " + player.allBreastsDescript() + " from the sensation of the bunny's brutal, almost mechanical fucking.", false);
	outputText("  The eager girl moans, \"<i>Ooooh fuckfuckyes... gotta fuck... gotta breed... ungh... eggs eggs eggs!</i>\"\n\n", false);
	
	outputText("Eggs?  Is she going to knock you up with eggs?  The confusion she's caused actually distracts you from the sex long enough to push back your orgasm, but the amorous bunny-gal pushes herself over the edge with one last thrust, hard enough to nearly launch you from her tumescent cock.  You slide back down the exhausted bunny, but don't feel the telltale spurting and warmth you'd expect to be bursting inside your " + player.vaginaDescript(0) + ".  Sure, there is a trickle of warmth, but your convulsing lover's rod hasn't spurted like a male's organ should.   You turn to get a better look at her and notice that she STILL seems lost in orgasm, and her balls are GONE!\n\n", false);
	
	outputText("Your eyes cross from a sudden, massive change in thickness of your lover's pole.  It starts out at your lower lips, spreading them until they're positively gaping.  Muscular contractions in the bunny's shaft make her dick pulse inside you, slowly pushing the bulge upwards and stretching your " + player.vaginaDescript(0) + "'s walls as it travels towards your womb.  More and more fluid leaks inside of your channel until your " + player.legs() + " relax and go limp.  It isn't just pre-cum anymore – it's dulling the pain and relaxing your body!  You can actually feel your cervix starting to open involuntarily as the bulge passes the halfway point.  From the distended spot downwards, your cunt hangs loosely around the swollen cock, but another knot emerges at the base and starts to slide up your abused tunnel.  ", false);
	//(Cunt Change HERE)
	player.cuntChange(70, true);
	outputText("\n\n", false);
	
	outputText("The girl underneath you is thrashing and moaning, chanting, \"<i>Yes... eggs eggs EGGS! YES!</i>\" while her ovipositor-like cock robs you of your strength and slides egg-shaped bulges inside you.  Amazingly, your " + player.vaginaDescript(0) + " is awash with pleasure, and you reach down to ", false);
	if (player.clitLength >= 4) outputText("fondle your " + player.clitDescript() + " a moment before wrapping your hand around it and stroking the girl-cock excitedly.", false);
	else outputText("caress your " + player.clitDescript() + " a moment before you start to circle it with a finger, teasing it expertly.", false);
	if (player.cockTotal() > 0) {
		outputText("  " + player.SMultiCockDesc() + " twitches and drools ", false);
		if (player.cocks[0].cockLength < 10) outputText("on the bunny's belly", false);
		else if (player.cocks[0].cockLength < 18) outputText("between the bunny's tiny tits", false);
		else if (player.cocks[0].cockLength < 28) outputText("on the bunny's face", false);
		else outputText("past the bunny's head", false);
		outputText(", and your free hand wastes no time in tending to your male ");
		if (player.cockTotal() == 1) outputText("half's needs, slathering it in pre-cum and stroking hard and fast.", false);
		else outputText("halfs' needs, slathering them in pre-cum and stroking hard and fast.", false);
	}
	outputText("  The futanari rabbit's dick-head swells as the egg reaches her tip, completely opening your womb, and then with one last explosive push, launches it deep inside you.\n\n", false);
	
	outputText("You get off hard.  Despite the drug-induced relaxation that's overwhelmed you from the waist down, rippling convulsions erupt up and down your "+ player.vaginaDescript(0) + ", squeezing the egg-spurting cock tightly.  This only speeds the passage of the bunny's second bulge, and in seconds her distended cock-head is stretched wider than before, locking her inside you for a moment.   The pair of you rock and grind your hips together futilely until the final egg erupts inside of you, accompanied by a huge wave of whatever it is that's made your lower body so nerveless.", false);
	if (player.cockTotal() > 0) {
		outputText("  At last, " + player.sMultiCockDesc() + " blasts sticky ropes of seed everywhere, cumming with you as your body slides sideways off the exhausted bunny into the dirt.  A few thick strands hit her tits and face, but judging by her half-closed eye-lids and questing tongue, she doesn't mind.", false);
		if (player.cumQ() > 500) outputText("  Not content with that, " + player.sMultiCockDesc() + " continues to pump until the bunny is coated with a generous layer of seed", false);
		if (player.cumQ() > 2000) outputText(" and the excess is running down the hill in a small river", false);
		if (player.cumQ() > 500) outputText(".", false);
	}
	outputText("\n\n", false);
	
	outputText("You sprawl out, leaking sexual fluids as your womb closes in around the foreign cargo, closing your cervix to hold in both the eggs.  An indeterminate amount of time has passed, but the forced euphoria of your new pregnancy makes it hard to get up just yet.  You see the bunny standing up with her dick finally going limp and no balls to speak of.  She leans down and gives you a kiss on the lips before whispering, \"<i>", false);
	if (player.bunnyScore() < 4) outputText("It's so good to finally think straight!  I don't know why I went into heat right now, but it's so much easier to think now that I've gotten rid of those eggs.  Don't worry, you won't be popping out rabbits since you aren't an easter-bun.  Your body will probably absorb them in a few days.  Just don't be surprised if you feel a little bloated or feel a little weird after.</i>\"\n\n", false);
	//Pregnant already
	else if (player.pregnancyIncubation > 0) outputText("It's so good to finally think straight!  I don't know why I went into heat right now, but it really is a shame you're pregnant.  Your body will destroy the little eggs before they can even do anything!  Well, at least I feel sooo much better...</i>\"\n\n", false);
	//Preggers
	else outputText("It's so good to finally think straight!  I don't know why I went into heat right now, but it feels so good to pour my babies into a nice, ready breeder-mom like yourself.  I bet the kids come out so cute!  Oh, I feel so much better.</i>\"\n\n", false);
	
	outputText("She walks away, her puffy tail twitching with the breeze while your eyes drift closed.", false);
	//(Easter vag-preg + 8 hours pass)
	if (player.bunnyScore() < 4) {
		player.knockUp(PregnancyStore.PREGNANCY_BUNNY, PregnancyStore.INCUBATION_BUNNY_EGGS);
	}
	else {
		player.knockUp(PregnancyStore.PREGNANCY_BUNNY, PregnancyStore.INCUBATION_BUNNY_BABY, 60);
	}
	player.orgasm();
	dynStats("lib", 1, "sen", -3);
	doNext(camp.returnToCampUseEightHours);
}

//[Take Dick In A] 
private function bunbunFucksPCInAss():void {
	spriteSelect(13);
	clearOutput();
	outputText("You get a very naughty idea and silently discard your " + player.armorName + ", tossing it aside as you turn around and present your " + player.assDescript() + " to the bunny-girl.  With a lewd shake, you tease her and give her a good view of your " + player.assholeDescript() + " while it lowers closer and closer to the turgid bunny-cock, just inches away.  Drops of clear pre-cum roll down her shaft as it twitches eagerly, and the girl watches you through a gleam of sexual excitement while her shaft gets closer and closer to your rear entrance.  You let your " + player.legs() + " relax a little until it's pressing tightly against your sphincter, feeling it slather pre-cum in preparation for the coming penetration.\n\n", false);
	
	outputText("Looking over your shoulder at the bunny's beet-red face, you let a little of your weight down and start to spread around the bunny-herm's cock.  It slides inside you easily, aided by her copious drops of pre-cum, but ", false);
	if (player.analCapacity() < 20) outputText("it stretches you dangerously wide as you slide down the thick shaft.  The further down it gets, the more you have to work to relax your muscles and push yourself along.  With enough time, patience, and copious bunny-pre, you manage to take it completely inside you.  It twitches happily while you adjust to the intrusion, but you know you're just getting started.", false);
	else if (player.analCapacity() < 40) outputText("you have to keep pausing as you slide down to let more of her pre-cum bubble out and lubricate the fourteen inch shaft.  It fills you nicely, pressing on your innards in all the right ways as you slowly engulf the bunny-cock with your " + player.assholeDescript() + ".  After bottoming out, your nervous lover's prick pulsates happily inside you, but you're just getting started.", false);
	else {
		outputText("you wish it was a bit bigger.  A few seconds is all it takes to get her thick shaft completely inside your " + player.assholeDescript() + ".  You clench and squeeze your muscles around it as you sit on the bunny-", false);
		if (player.cor < 50) outputText("girl", false);
		else outputText("bitch", false);
		outputText("'s lap, giggling as you feel it twitch happily inside you, but you're just getting started.", false);
	}
	//(BUTT CHANGE HERE)
	player.buttChange(35, true);
	outputText("\n\n", false);
	
	outputText("Your partner gasps in surprise as you pull yourself up, dragging her cock slowly through the tight ring of your pucker until she's about to slip out, and then dropping back down to envelop her again.  She involuntarily grunts wordless pleasure noises, thrilled with the sensation your warm body provides.  Her hands grab her nipples as you repeat your actions, working her with a slow, smooth rhythm that should bring her to orgasm... eventually.  ", false);
	if (player.totalCocks() > 0) outputText("Each time she bumps and slides past your prostate a dollop of your pre-cum spurts from " + player.sMultiCockDesc() + " onto the ground, and you have a hard time not using your new lover like an anal toy and masturbating yourself.  ", false);
	outputText("The long-eared slut makes a display of touching her nipples, pulling and twisting on them as you watch her over your shoulder.\n\n", false);
	
	outputText("Without meaning to, you begin to pick up the speed of your up and down strokes.  Your body is feeling horny and warm from all the sex, and having such a strange, attractive lover mating with your backside isn't helping.  ", false);
	if (player.hasVagina()) {
		if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLICK) outputText("Juices begin to run from your " + player.vaginaDescript(0) + ", but you ignore the empty feeling and focus on the throbbing meat inside your backdoor.  ", false);
	}
	outputText("Fingers find their way to your nipples without conscious thought, and begin ", false);
	if (!player.hasFuckableNipples()) {
		outputText("pulling and tugging on them", false);
		if (player.biggestLactation() >= 1) {
			outputText(", spurting out ", false);
			if (player.biggestLactation() >= 4) outputText("sprays", false);
			else outputText("drops", false);
			outputText(" of milk", false);
		}
		outputText(".", false);
	}
	else outputText("sliding inside them, fucking their cunt-like interiors as you start to lose yourself to the pleasure.", false);
	outputText("  The bunny reaches down to your " + player.assDescript() + " and gives it a gentle caress and squeeze.  A moment later both her hands are holding your butt-cheeks, guiding you up and down as you bounce atop her faster and faster.\n\n", false);
		
	outputText("You stroke the downy fur of her thighs through your fingers, marveling at her softness as you let the bunny start to set a tempo so fast that her pre-cum is squirting out with each wet, gushy fuck.   She occasionally gives your ass a gentle slap and starts moaning and panting out loud with every heated penetration, \"<i>Fuck... breed... mmm... yes... eggs eggs pleaseletmeegg!</i>\" It's hard to pay attention with the rising pleasure surging through your body", false);
	if (player.cockTotal() > 0) {
		outputText(", and " + player.sMultiCockDesc() + " pouring incredibly sticky pre-cum each time she squeezes your prostate", false);
	}
	else if (player.hasVagina()) outputText(", and your " + player.vaginaDescript(0) + " clenching and dripping on the verge of orgasm", false);
	outputText(".", false);
	if (player.biggestLactation() >= 1) {
		outputText("  Milk ", false);
		if (player.biggestLactation() < 2) outputText("leaks", false);
		else if (player.biggestLactation() < 4) outputText("drips", false);
		else outputText("pours", false);
		outputText(" from your " + player.nippleDescript(0) + "s, turning your front to a leaky mess as you ride the very edge of pleasure.", false);
	}
	outputText("\n\n", false);
	
	outputText("Wait a second, what was that about eggs?  The confusion that comes with that thought distracts you enough to keep you from cumming, but the bunny orgasms before you have a chance to reconsider your position atop her.  She convulses, her rod twitching and thickening slightly, but you don't feel the warmth of erupting cum that you would expect.  You look down at her, but the bunny-girl is too insensate to provide any answer, and it's not until you notice that her balls are missing that you realize something is wildly different about the way her orgasms work.\n\n", false);
	
	outputText("You gasp in pain as the thickness at the base of your lover's shaft doubles.  It stretches your " + player.assholeDescript() + " wide, almost painfully wide as something starts to push up her dick from the inside.  Before you can pull yourself off her, a massive gush of fluid drizzles inside of you, quickly numbing any pain and stealing the strength from your " + player.legs() + " and muscles.  You twist back and forth, but the pleasure intensifies as the bulge slips past your sphincter, leaving your body slightly agape in its wake.  You find the rest of its passage to be more comfortable ", false);
	if (player.cockTotal() > 0) {
		outputText("and as it squeezes past your prostate, " + player.sMultiCockDesc() + " spurts thick cum on the ground, though you don't QUITE orgasm.", false);
	}
	else outputText("and your arousal returns in force.", false);
	//(BUTT CHANGE HERE)
	player.buttChange(70, true);
	outputText("\n\n", false);
	
	outputText("A moment before the bulge reaches the tip of the rabbit-cock, you feel another sliding through your " + player.assholeDescript() + ".  The bunny-dick's head thickens for a moment before it dwindles down to its normal shape.  You feel something warm and orb shaped inside you – it's an egg!  The strangeness of the insemination can't hold back the excitement your body built up or the feelings the second egg's passage is leaving in its wake, and you cum hard.  Somehow your body gets enough control to squeeze the girl's penis tightly, but all it accomplishes is speeding the eggs passage as it spurts into your rectum along with another big burst of pleasant, relaxing fluids.", false);
	if (player.cockTotal() > 0) {
		outputText("  " + player.SMultiCockDesc() + " erupts in truth, spraying and splattering white goop over the grass and ground.", false);
		if (player.cumQ() > 500) outputText("  The splattering of your seed only increases in volume as it makes a rather large puddle", false);
		if (player.cumQ() > 2000) outputText(", but you just keep going until you create a lazily winding river of cum that flows its way through the grasses", false);
		if (player.cumQ() > 500) outputText(".", false);
	}
	if (player.hasVagina()) outputText("  Your " + player.vaginaDescript(0) + " clenches, empty, drooling, and neglected, wishing it something inside it.", false);
	outputText("\n\n", false);
	
	outputText("You slide off still-dripping bunny-tool and roll onto your back, panting from the force of your orgasm and remarkably sated.   The eggs inside you don't feel uncomfortable at all, in fact, you barely notice them.  Looking over, you see the rabbit-girl is finally done cumming, though her eyes haven't quite rolled the whole way back down.  Exhausted and filled with pleasant hormones that make it hard to think, the both of you simply lie and rest a bit.\n\n", false);
	
	outputText("An indeterminate amount of time later, the cute bunny-girl is giving you a long, wet kiss on the lips.  She stops to whisper, \"<i>It's so good to finally think straight!  I don't know why I went into heat right now, but it's so much easier to think now that I've gotten rid of those eggs.  Don't worry, I'm sure you'll absorb them in a couple days and be fine.  Just don't be surprised if you feel a little bloated and weird.</i>\"\n\n", false);
	
	outputText("She walks away, her puffy tail twitching with the breeze while your eyes drift closed.", false);
	//(Easter ass-preg + 8 hours pass)
	player.buttKnockUp(PregnancyStore.PREGNANCY_BUNNY, PregnancyStore.INCUBATION_BUNNY_EGGS, 1, 1);
	player.orgasm();
	dynStats("lib", 1, "sen", 1);
	doNext(camp.returnToCampUseEightHours);
}

//FUCK DAT BUNNYBUNBUNBUN.
private function bunbunGetsFucked():void {
	spriteSelect(13);
	clearOutput();
	//Requires wang that fits
	var x:Number = player.cockThatFits(40);
	//Second wang that fits for DP
	var y:Number = player.cockThatFits2(40);
	
	outputText("You disrobe and toss your " + player.armorName + " to the side, immediately forgetting about it as the bunny-girl lifts her sack to expose the bright pink flesh of her femininity.  It glistens, practically steaming up the air with her plentiful lubricants.  She runs a slender finger around the moist hole, beckoning you to plunge inside and fill her hungry flesh with your " + player.cockDescript(x) + ".  Lust burns through you as you drop to your knees and line your " + player.cockDescript(x) + " up with that ready opening", false);
	if (y != -1) outputText(", taking care to align your " + player.cockDescript(y) + " with her tightly puckered backdoor as well.", false);
	else outputText(", barely able to restrain yourself as the time for penetration approaches.", false);
	outputText("\n\n", false);
	
	outputText("The nubile bunny's eyes cross as you push forwards, sliding your " + player.cockHead(x) + " over her love-slicked lips until it has a generous coating and pressing harder.  ", false);
	if (y != -1) outputText("She squeaks at the pressure on her tender asshole, but doesn't object as your pre-cum smears over it.  ", false);
	outputText("At once, her greedy breeding hole relaxes ", false);
	if (y != -1) outputText("along with her anus ", false);
	outputText("and your " + player.cockDescript(x), false);
	if (y != -1) outputText(" and " + player.cockDescript(y) + " sink", false);
	else outputText(" sinks", false);
	outputText(" into her slippery, warm depths.  She pants and groans with happiness, going so far as to vocalize her pleasure, \"<i>Oooh yes, I don't know why but it feels just as good as breeding season!  If you keep this up, " + player.mf("stud","sexy") + ", you might... ahhhh.. make me egg!</i>\"\n\n", false);
	
	outputText("You don't try to make sense of it and instead plunge further forward, watching with delight as more and more of your length is devoured by the horny bunny's body.  ", false);
	if (player.cockArea(x) >= 25) outputText("Her belly bulges pleasantly, displaying the vaguely cylindrical shape of a cock through her skin in a way that makes you feel utterly dominant over this 'female'.  ", false);
	outputText("Once you bottom out, the hermaphrodite actually starts to squirt pre-cum onto herself.  It isn't quite as much as you'd expect from a real orgasm, but it's enough that she makes a slippery mess of her tits and belly.  She gathers it up and starts stroking herself off with it, and you watch the enthusiastic bunny masturbate herself.\n\n", false);
	
	outputText("\"<i>Nooooooo,</i>\" she cries, thinking you meant to stop, but you savagely slam back in, rocking her body and making her petite, pre-cum-glazed tits jiggle pleasantly.   Her 'no' turns into an 'OHHH' in that split second, and before she can stop or catch her breath, you start fucking hard, watching her cum-shined breasts wobble underneath you.  ", false);
	if (y != -1) outputText("Her tight asshole slowly loosens around your " + player.cockDescript(y) + ", and so much lubricant splatters from her cunt with each thrust that the sensations of both your dicks become nigh-identical, save for the tight ring gripping the bottom one.", false);
	else {
		outputText("So much lubricant splatters from her cunt that your thighs", false);
		if (player.balls > 0) outputText(", belly, and balls", false);
		else outputText(" and belly", false);
		outputText(" are soon sticky with the stuff, but it only spurs you on to fuck her harder.", false);
	}
	outputText("\n\n", false);
	
	outputText("The bunny-girl never lets up on the fourteen inch monster between her legs, and it seems to have gotten a little bit thicker and harder from all the attention.  Her cock has never stopped dripping and spurting pre-cum in all this time, and she's turning into a syrupy, cum-slicked mess before either of you have even gotten off.  The moans and heat pouring off her loins make it very clear that's going to change very soon, so you reach down and give her taut ass a rough slap.  It sets off a far different orgasm than you would've expected.\n\n", false);
	
	outputText("Before your eyes the rabbit-girl's balls disappear and the flesh of her sack pulls tight against her.  It actually looks like she never had one at all.  You look to her for answers, but her eyes are rolled back, her body is quaking around you, and her mouth is babbling, \"<i>Eggfuck... eggbreedegg... ungungegg... eggegg,</i>\" over and over.  Her cunt clamps down on you with a vice-like grip that makes your eyes cross and your crotch bubble with the heat of a coming orgasm.", false);
	if (y != -1) outputText("  Surprisingly, her asshole stays about the same, but it was already a little tighter and you know you'll be pumping it full of goo in a second.", false);
	outputText("\n\n", false);
	
	outputText("The bunny's convulsions take on a manic, thrashing pace, and before your eyes the base of her swollen cock begins to distend, nearly doubling in width from some internal object.  You wonder how she could enjoy something like that, but maybe her body is built for it?  It slowly works its way up the shaft while your long-eared lover stays locked in orgasm, panting, gasping, and leaking whiter-colored pre-cum that stops the convulsions anywhere it hits.  There must be something in it that forcibly relaxes the muscles, but before you can ponder it further your own climax has arrived.\n\n", false);
	
	outputText("You bottom out with brutal force", false);
	if (player.balls > 0) outputText(", slapping your balls against her ass", false);
	outputText(", as your ", false);
	if (player.hasSheath()) outputText("sheath", false);
	else outputText("base", false);
	outputText(" rubs her passion-inflamed pussy-lips.  " + player.SMultiCockDesc() + " unloads, splattering out ropes of cum into ", false);
	if ((player.cockTotal() == 2 && y == -1) || player.cockTotal() > 2) outputText("and onto ", false);
	outputText("the insensate bunny-breeder.  Her silken pussy milks and squeezes as you cum, seeming to draw your seed from your cock itself and pull it deeper inside, leaving none to waste.",false);
	if (y != -1) {
		outputText("  Her ass gurgles from your deposit", false);
		if (player.cumQ() > 500) outputText(", and her stomach gains a bit of pudge from the copious jism deluge you pump into her", false);
		outputText(".", false);
	}
	if (player.cumQ() > 500) outputText("  You keep cumming, slamming blast after blast of spooge into her welcoming nethers, delighted that none seems to leak out.", false);
	if (player.cumQ() >= 1500) outputText("  Somehow her womb never seems to fill or bulge, even though you must be pumpings gallons of fertile baby-batter into her cunt.  By the time your orgasm winds down, you feel a little confused by it all, but sated.", false);
	outputText("\n\n", false);
	
	outputText("The bunny's swollen cock has pushed the bulge all the way up to the tip, though you see another forming at the base.  She doesn't seem to mind, in fact she actually stops babbling and moaning long enough to scream with delight as she launches an egg onto her tits.  It sits between her small mounds, rolling and dripping white goo onto her nipples.  Her dick spurts out a few more blasts of whatever her 'cum' is before trailing off.  The other bulge isn't far from her still-somewhat stretched tip, and you know she'll be 'laying' another egg soon.\n\n", false); 
	
	outputText("There's a feminine grunt, a moan, and a burst of fluid as the second egg falls onto her belly.  The bunny-girl finally stops convulsing as she soaks herself with more white goop, and though her eyes make an attempt to focus on you, they seem a little more dilated than they should be.  The only movements she bothers to make are breathing and weakly pushing a globule of white stuff away from her eyes.  The bunny sighs dreamily while you pull out, and pets her eggs as she comes down from the absurdly long and unusual orgasm.\n\n", false);
	
	outputText("You ask her if that's normal, and she weakly nods.  A second later, a distinct rumble can be heard from the area of her groin.  You look at her as her cheeks turn red and she slowly starts to pant.  A moment later, her 'sack' reappears with a single 'ball' in it, though at this point you know what it is – an egg.  The bunny starts stroking her cock again, though this time without the feverish intensity she had before, and another egg drops down, restoring her 'pair'.", false);
	if (player.cumQ() > 100) outputText("  A few seconds later another rolls in, cramming three into her increasingly obscene looking 'sack'.", false);
	if (player.cumQ() > 250) outputText("  One more follows, giving her quads", false);
	var z:Number = 8 + rand(player.cumQ()/100);
	if (z > 50) z = 50;
	if (player.cumQ() > 700) outputText(", but she's not done.  Her gut rumbles loudly, and then one after another egg after egg pours into the sack, stretching it out until you're sure she has at least " + z + " in there and will have trouble walking.", false);
	else outputText(".", false);
	outputText("  She moans contentedly and closes her eyes, sighing blissfully.\n\n", false);
	
	outputText("You shrug and pick up one of her eggs, noticing that it's turned neon pink in color.  The bunny mumbles, \"<i>Have it, iz good for youuuu...</i>\" before she starts to snore and murmur out a sexual dream.\n\n", false);
	
	player.orgasm();

	dynStats("lib", 1, "sen", 1);
	inventory.takeItem(consumables.NPNKEGG, camp.returnToCampUseOneHour);
}

private function bunbun69():void {
	spriteSelect(13);
	clearOutput();
	//Centaur
	if (player.isTaur()) {
		if (rand(2) == 0) {
			//should trigger if PC is a centaur and height > 4'0", since a horse <= 4feet could 69 the bunny >_>
			outputText("Without thinking it over beyond 'that sounds hot', you declare your intention to 69 the bunny girl.  She stands there, mouth hanging open and heat briefly forgotten.\n\n", false);
			
			outputText("\"<i>What?</i>\"\n\n", false);
	
			outputText("By now you've realized the absurdity of your statement, but you're too proud to admit it and simply restate your goal.  You cross your arms to try to look as serious as possible.  She looks down at your equine portion while idly stroking her cock, making sure your \"equipment\" is where she thinks it is.\n\n", false);
	
			outputText("\"<i>You're weird,</i>\" declares the rabbit.\n\n", false);
	
			outputText("Before you can return with a witty remark, the bunny has hopped off, leaving you alone in the field with your face in your palm.\n\n", false); 
			//- Intelligence
			//+ Lust
			player.orgasm();
			dynStats("int", -2);
			doNext(camp.returnToCampUseOneHour);
		}
		else {
			outputText("Without thinking it over too hard beyond 'that sounds hot', you declare your intention to 69 the bunny girl.  She bursts into laughter.  You're a little perturbed by this and make it clear you're quite serious by restating your goal.\n\n", false);

			outputText("\"<i>No, no, stop – ahaha - you're killing me - haha!</i>\" she splutters.  \"<i>Hahaha - oh gods - I'm going to egg from laughter - HAHAHA!</i>\"\n\n", false);

			outputText("You realize the absurdity of your proposition just as she falls backwards, one hand on her belly and one on her cock.  You try to imagine some way to make your proposal work and save face, but the humiliation of having said something so ridiculous and thoughtless leaves you bereft of any more suggestions.\n\n", false);

			outputText("She's laughing so hard that her entire body starts to shake violently.  Thinking that it wasn't <i>that</i> funny, you're about to turn and leave when one of her testicles disappears.  You watch in mixed curiosity and confusion as the lump makes its way up the hysterical rabbit's cock and launches into the air, revealing itself to be a pastel pink and white egg.  You bend down to pick it up just as the other \"teste\" splatters onto your face.\n\n", false);

			outputText("\"<i>Hahah! Egg on your face! Ahahah!</i>\"\n\n", false);

			outputText("You wipe off what you can of the sticky goop and trot off with a scowl, leaving the hysterical rabbit to calm herself down.\n\n", false);
			//- Intelligence
			player.orgasm();
			dynStats("int", -2);
			//+ Lust
			//+ Pink Egg 
			inventory.takeItem(consumables.NPNKEGG, camp.returnToCampUseOneHour);
		}
		return;
	}
	//Dudes
	if (player.cockTotal() > 0) {
		//EASTER CANDY VERSION
		if (isEaster()) {
			outputText("It'd be a shame if both of you didn't have a chance at a little fun, wouldn't it? Gripping the dusky-skinned girl, you gently push her down and hover over her face for a moment, playing with the whiskers on her freckled cheeks. Your tickling seems to excite the girl and before long, she's panting through her buck teeth, her stiffness rigid and pulsing with her racing heartbeat. Flipping over her, you park your [legs] on either side of her ears and lean down toward her crotch, savoring the slightly sweet scent of chocolate that wafts from her sweat-slick body. Her cock is almost intimidating, bulging obscenely in front of you, tiny dollops of pre-cum oozing to the pointed tip in rich bubbles that trickle down her caramel skin. Warily, you bring your nose up to her shaft and sniff, pleasantly surprised to find that the bulbs of sticky semen smell more like fresh marshmallows than the salty discharge you're used to. Actually, it smells really, REALLY good. You rest your cheek against the bunny-girl's root and tentatively lick up her shaft, gathering the stray strands of cum that stripe her dusky dick with snowy white. She gasps and her cock twitches against your face, bobbing back and forth in time to the rapid vibration of her legs. When you taste her cum, it's even better than it smells- like an orgy of cotton candy, marshmallows, and sweet juice swirling in your mouth, as tantalizing as the first spoonful of ice cream. Invisible bunny or no, you just have to get more of her cum!\n\n", false);
	
			outputText("Underneath you, the bunny seems to be admiring your length with barely contained lust. The boiling horniness you saw earlier is overpowering her restraint and it's all she can do to try to lubricate you before taking your cock whole. A long, broad tongue licks up and down your manhood, hot and wet, her cute little nose rubbing against your bulging veins with a maddening tickle. A tremor of uneasiness creeps into you as she runs her long, buck teeth against your supple flesh, but surprisingly, you find that they're extremely dull and almost feel soft to the touch. As you bring your mouth to her pointed cockhead, she decides that treating your dick like a popsicle isn't enough and guides your tip to her eager lips with hungry relish. She slips your cock into her mouth with a satisfied gulp and uses the edge of her tongue to massage just under your cockhead, pressing into the swell of flesh while she uses the ridges of the top of her mouth to tease your urethra, opening and closing the tender hole with every bobbing head motion.\n\n", false);
			
			outputText("In turn, you suck all the harder on the bunny-girl's cock, swallowing a few inches at a time until your mouth feels full of the chocolate girl's erection. Around your head, she's drawn her knees up and braces her legs on the balls of her feet. Her lower body vibrates with the bouncing excitement of her twitching calves and it makes the prick in your mouth quiver like hot jelly. Her sac rolls this way and that in front of you, oval-shaped balls bouncing in eager appreciation and you can't help but wrap your hand around them, feeling the radiating heat pouring from the scrotum in the palm of your hand. Gently rolling them in your hand, you can feel the weight of the rapidly filling pouch in your palm. With your thumb, you stroke her bronzed nuts up to the tip of her vagina. The bunny's clit is as hard and large as a jelly bean and you circle it with the tips of your fingers, almost as if trying to tease it out of its dark chocolate-colored fleshy hood.\n\n", false);
			
			outputText("Your teasing and prodding may have been ill-advised, you realize, as the bunny-girl's restraint evaporates like fog on a hot day. Her animalistic instincts kick in and the girl's bobbing legs become full-sized thrusts. With surprising leg strength, she bucks her hips in increasingly long strokes until her whole butt is bouncing off the ground like fuzzy rubber. You try to compensate, but the girl's frenzy is relentless. In seconds she goes from your tongue to your tonsils to your throat, her conical dick perfectly shaped to slide right into a deep throat. You begin to choke in response to the sudden intrusion, but the bunny is just as eager to get cream-filled as she is to give you a rich, chocolate center. With a gleeful 'squeek' noise she opens her esophagus and works her head deeper onto your shaft, her broad, gentle rabbit teeth pressing your over-burdened veins just enough to send shivers through your body.", false);
			//[8"+ : 
			if (player.cocks[0].cockLength >= 8) outputText("  As she passes six inches into her throat, her sucking grows more anxious, her arms wrapping around your hips, fingers digging into your ass, drawing your groin down faster.", false);
			//[12"+ : 
			if (player.cocks[0].cockLength >= 12) outputText("  You can't concentrate with a foot of bunny cock plowing your lungs so you aren't prepared for the girl's desperation until it boils over. She takes a deep breath through her tiny nostrils and slams her head as hard as she can into your groin, fucking your cock with her face until the soft folds of her throat part and she buries her freckled cheeks in your thighs.", false);
			outputText("\n\n", false);
			 
			outputText("The bunny-girl's chest rises and falls rapidly, almost as if she's hyperventilating. You realize she's gone into a breeding frenzy! Wrapping her legs around your head, she clings tightly to you and flips the two of you around with a hard thud that bottoms out her 14\" cock in your throat. Your eyes go wide, too stunned by the caramel pole running from your lips to your stomach to be terribly concerned by the sudden lack of oxygen going to your body. Her balls lurch against your nose as her egg-laying urges turn the bunny into something feral. Every inch of her lean, olive body humps against yours in rapid, tiny hops that keep your bodies bouncing against each other. Her hyperactive overdrive gives a frisky energy to her fucking and sucking. The bunny's muscled body hops higher and higher, until she's thrusting nearly a foot of her chocolate prick in and out of your mouth, thankfully giving you enough respite to breathe through your nose between strokes.\n\n", false);
			
			outputText("The spry bunny starts to make you dizzy and the slapping of her modest B-cups against your " + player.chestDesc() + " has begun to leave tingling red welts on your sensitive flesh. Wrapping one arm around her waist, you pull her crotch tightly against your face and bury your other hand into her dripping snatch, bunny lips parting like taffy to your forceful grip. Digging in as many as you can fit, you hook your fingers around and drag them out until you find the squirming girl's G-spot. Her frenzied hops cease immediately and her whole body quivers in your embrace. You congratulate yourself on your quick thinking as her cock pulses in your mouth, the girl's orgasm imminent. To your considerable surprise, however, instead of merely pulsing, her balls begin to swell and one of them pops into her body! You can see an egg-shaped bulge work its way up her abdomen toward her cock and you quickly try to draw your head back. The bunny's arms shoot to the back of your head and her fingers dig into your hair, trying to force you back down as she moans into your straining inches. You pull against her grip, the egg-shaped bulge of her testicle working its way up her shaft just a bit faster than you can distend it from your gut. Drool-slick flesh expands as the protrusion slips past your lips and just as her cockhead slides against your tongue, her narrow corona swells, dilating obscenely. A hot rush of marshmallow cum erupts in your mouth, gooey strands filling your cheeks, sliding back down your throat, and even bursting from your nostrils in soupy ropes of sugarcoated ejaculate when your attempt to swallow her load closes your esophagus. The girl's testicle plops into your mouth a moment later and you're relieved to find that it seems to be an egg that's rolling around your tongue.\n\n", false);
			
			outputText("Still possessed by the delirious breeding hysteria, the bunny grunts and jams her cock back down your throat, pushing the egg along with it. Your skin mushrooms as the bunny's egg-ball slides down your cum-lubricated neck and tumbles into your belly with an audible, vulgar plop. A feeling of incredible fullness fills you, as if you've just finished eating a small mountain of candy treats. A surge of heat stuffs your belly like a confectionary oven and the bunny's egg between to bloat, soaking up her cum and your body heat, growing like a baking cake inside you. You become dizzy from the bunny's stuffing and when her sac deflates as the second egg slides into her dick, you shake your head weakly, as if to say you don't want seconds. The girl is too far gone in her wanton ardor to take your motion as anything but encouragement, however, and she nuzzles her nose into your ", false);
			if (player.balls > 0) outputText("balls", false);
			else outputText("clit", false);
			outputText(", whiskers vibrating with a happy little hum, her buck teeth massaging your root enthusiastically, impatient for her Champion-cream filling. Her hands slide from the back of your head, along your neck, down your back, and to your ass, fingers wrapping around to find your " + player.assholeOrPussy() + ". Slipping both middle fingers in, she strokes your ", false);
			if (!player.hasVagina()) outputText("prostate", false);
			else outputText("inner walls", false);
			outputText(" until your orgasm overpowers your saccharine-fat daze and you peak, egg-bloated body spurting in creaming jets of pale seed to paint the brown bunny's insides white.\n\n", false);
			
			outputText("Her second egg forces its way down your throat with gushing shudders and you can feel your hips straining against the weight of your overburdened stomach. You're a little afraid of what the second one will do to you as it slides out of the flared tip of the bunny's fourteen inches. Maybe it's the milking motion of the bunny's head bobbing in happy hops on your cock or maybe it's the swelling of the second egg, but your body begins to feel hot and your flesh tingles at your scalp and butt. You clench your eyes, willing yourself to digest the bunny's candy eggs and, to your surprise, your belly slows its expansion, gradually shrinking as the eggs burst in your stomach, unloading their gooey candy filling.", false);
			player.refillHunger(60);
			if (player.tailType != TAIL_TYPE_RABBIT) {
				//[No Tail: 
				if (player.tailType == TAIL_TYPE_NONE) outputText("  The heat around your lower back clutches at your tail bone and you feel a fluffy explosion swell around your butt cheeks as <b>a fluffy bunny's tail pops out of your back</b>, twitching excitedly!", false);
				//[Existing tail: 
				else outputText("  Your tail jiggles and shrinks, slowly sucking back into your body until only a tiny nub remains which quickly explodes with fluff into <b>your new cuddly, twitching bunny tail!</b>", false);
			}
			if (player.earType != EARS_BUNNY) {
				outputText("  The top of your head is next, it seems.", false);
				//[No antennae: 
				outputText("  Your eyebrows feel like they're being drawn upwards, your eyes getting larger and larger until you're almost painfully aware of every color and sound around you. You shake your head and <b>large, floppy bunny ears bounce in front of your eyes</b>. You slap the sides of your head and, sure enough, your old ears are gone.", false);
			}
			outputText("\n\n", false);
			
			outputText("With a happy sigh, the girl slides off of your cock and lets it flop against your leg, not a single drop of cum wasted. Her belly has ", false);
			if (player.cumQ() < 250) outputText("a slight swell", false);
			else if (player.cumQ() < 1000) outputText("a noticeable girth", false);
			else outputText("bloated obscenely", false);
			outputText(", your spunk calming the egg-laying passion that had her bouncing like whipped caramel. She pulls her shrinking phallus from your mouth with a wet slurp, the taste of her rich cum sweet on your lips. She rises to a crouch and gives your new ears a playful tweak between her thumb and forefinger. \"<i>Sorry about that, I don't know what came over me! I certainly didn't expect this, though! Kind of makes me want to stick around and see if you and I could pop out more bunnies,</i>\" she winks. \"<i>But unfortunately, I've got to get going! Hope you had a happy, tasty day! Maybe I'll try to find you again, some time down the line.</i>\" She gives you a moist little kiss and hops away, still energetic after all that. You groan, still feeling fat and bloated from the 'meal.'\n\n", false);
			
			player.tailType = TAIL_TYPE_RABBIT;
			player.earType = EARS_BUNNY;
			doNext(camp.returnToCampUseOneHour);
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
		}
		//REGULAR SHOW
		else {
			outputText("It'd be a shame if both of you didn't have a chance at a little fun, wouldn't it? Gripping the dusky-skinned girl, you gently push her down and hover over her face for a moment, playing with the whiskers on her freckled cheeks. Your tickling seems to excite the girl and before long, she's panting through her buck teeth, her stiffness rigid and pulsing with her racing heartbeat. Flipping over her, you park your [legs] on either side of her ears and lean down, toward her crotch, savoring the slightly sweet scent that wafts from her sweat-slick body. Her cock is almost intimidating, bulging obscenely in front of you, tiny dollops of pre-cum oozing to the pointed tip in rich bubbles that trickle down her caramel skin. You rest your cheek against the bunny-girl's root and tentatively lick up her shaft, gathering the stray strands of cum that stripe her dusky dick with snowy white. She gasps and her cock twitches against your face, bobbing back and forth in time to the rapid vibration of her legs. When you taste her cum, it gives you an oddly numb feeling in your mouth, cold and warm at once, but making the flesh inside your cheeks swell a bit, tightening your mouth.\n\n", false);
			
			outputText("Underneath you, the bunny seems to be admiring your length with barely contained lust. The boiling horniness you saw earlier is overpowering her restraint and it's all she can do to try to lubricate you before taking your cock whole. A long, broad tongue licks up and down your manhood, hot and wet, her cute little nose rubbing against your bulging veins with a maddening tickle. A tremor of uneasiness creeps into you as she runs her long, buck teeth against your supple flesh, but surprisingly, you find that they're extremely dull and almost feel soft to the touch. As you bring your mouth to her pointed cockhead, she mumbles something about 'eggs' and guides your tip to her eager lips with hungry relish. She slips your dick into her mouth with a satisfied gulp and uses the edge of her tongue to massage just under your glans, pressing into the swell of flesh while she uses the ridges of the top of her mouth to tease your urethra, opening and closing the tender hole with every bobbing head motion.\n\n", false);
			outputText("In turn, you suck all the harder on the bunny-girl's cock, swallowing a few inches at a time until your mouth feels full of the chocolate girl's erection. Around your head, she's drawn her knees up and braces her legs on the balls of her feet. Her lower body vibrates with the bouncing excitement of her twitching calves and it makes the prick in your mouth quiver with a breeder's anticipation. Her sac rolls this way and that in front of you, oval-shaped balls bouncing in eager appreciation and you can't help but wrap your hand around them, feeling the radiating heat pouring from the scrotum in the palm of your hand. Gently rolling them in your hand, you can feel the weight of the rapidly filling pouch in your palm. With your thumb, you stroke her bronzed nuts up to the tip of her vagina. The bunny's clit is as hard and large as the tip of your pinkie and you circle it with your fingers, trying to tease it out of its pink, fleshy hood.\n\n", false);
			
			outputText("Your teasing and prodding may have been ill-advised, you realize, as the bunny-girl's restraint evaporates like fog on a hot day. Her animalistic instincts kick in and the girl's bobbing legs become full-sized thrusts. With surprising leg strength, she bucks her hips in increasingly long strokes until her whole butt is bouncing off the ground like fuzzy rubber. You try to compensate, but the girl's face-fucking jubilation is relentless. In seconds she goes from your tongue to your tonsils to your throat, her conical dick perfectly shaped to slide right into your neck. You begin to choke in response to the sudden intrusion, but the bunny's trickling pre-cum provides a woozy numbness that relaxes your gag reflex and swells your throat into a soft, squishy tunnel, pulsing with cunt-tightness. Rocking her head in time to her hips, she seems just as eager to earn your load as she is to give you hers. With a gleeful 'squeek' noise she opens her esophagus and works her mouth deeper onto your shaft, her broad, gentle rabbit teeth pressing your over-burdened veins just enough to send shivers through your body.", false);
			//[8"+ : 
			if (player.cocks[0].cockLength >= 8) outputText("  As she passes six inches into her throat, her sucking grows more anxious, her arms wrapping around your hips, fingers digging into your ass, drawing your groin down faster.", false);
			//[12"+ : 
			if (player.cocks[0].cockLength >= 12) outputText("  You can't concentrate with a foot of bunny cock plowing your lungs so you aren't prepared for the girl's desperation until it boils over. She takes a deep breath through her tiny nostrils and slams her head as hard as she can into your groin, fucking your cock with her face until the soft folds of her throat part and she buries her freckled cheeks in your thighs.", false);
			outputText("\n\n", false);
			
			outputText("The bunny-girl's chest rises and falls rapidly, almost as if she's hyperventilating. You realize she's gone into a breeding frenzy! Wrapping her legs around your head, she clings tightly to you and flips the two of you around with a hard thud that bottoms out her 14\" cock in your throat. Your eyes go wide, too stunned by the caramel pole running from your lips to your stomach to be terribly concerned by the sudden lack of oxygen going to your body. Her balls lurch against your nose as her egg-laying urges turn the bunny into something feral. Every inch of her lean, olive body humps against yours in rapid, tiny hops that keep your bodies bouncing against each other. Her hyperactive overdrive gives a frisky energy to her fucking and sucking. The bunny's muscled body hops higher and higher, until she's thrusting nearly a foot of her chocolate prick in and out of your mouth, thankfully giving you enough respite to breathe through your nose between strokes.\n\n", false);
			
			outputText("The spry bunny starts to make you dizzy and the slapping of her modest B-cups against your " + player.chestDesc() + " has begun to leave tingling red welts on your sensitive flesh. Wrapping one arm around her waist, you pull her crotch tightly against your face and bury your other hand into her dripping snatch, bunny lips parting like velvet to your forceful grip. Digging three fingers in, you hook your fingers around and drag them along the girl's quivering walls until her choked squeals tell you that you've found her most sensitive spot. Her gleeful hops cease immediately and her whole body trembles in your embrace. You congratulate yourself on your quick thinking as her cock pulses in your mouth, the girl's orgasm imminent. To your considerable surprise, however, instead of merely pulsing, her balls begin to swell and one of them pops into her body! You can see an egg-shaped bulge work its way up her abdomen toward her cock and you quickly try to draw your head back. The bunny's arms shoot to the back of your head and her fingers dig into your hair, trying to force you back down as she moans into your groin. You pull against her grip, the egg-shaped bulge working its way up her shaft just a bit faster than you can distend it from your gut. Drool-slick flesh expands as the protrusion slips past your lips and just as her cockhead slides against your tongue, her narrow corona swells, dilating obscenely. A hot rush of tingling cum erupts in your mouth, gooey strands filling your cheeks, sliding back down your throat, and even bursting from your nostrils in soupy ropes of sticky ejaculate when your attempt to swallow her load closes your esophagus. The girl's load rolls in your mouth for a moment and you find that the cummy mess seems to have deposited an egg on your tongue!\n\n", false);
			
			outputText("Still possessed by the delirious egg-laying hysteria, the bunny grunts and jams her cock back down your throat, pushing the egg along with it. Your skin mushrooms as the bunny's load slides down your cum-lubricated neck and tumbles into your belly with an audible, vulgar plop. A feeling of incredible fullness fills you, as if you've been swallowing spunk and eggs for hours. You become dizzy from the bunny's numbing jizz and when her sac deflates as the second egg slides into her dick, you shake your head weakly, as if to say 'no more.' The girl is too far gone in her wanton ardor to take your motion as anything but encouragement, however, and she nuzzles her nose into your ", false);
			if (player.balls > 0) outputText("balls", false);
			else if (player.hasVagina()) outputText("clit", false);
			else outputText("groin", false);
			outputText(", whiskers vibrating with a happy little hum, her buck teeth massaging your root enthusiastically, impatient for her own creamy meal. Her hands slide from the back of your head, along your neck, down your back, and to your ass, fingers wrapping around to find your " + player.assholeOrPussy() + ". Slipping both middle fingers in, she strokes your ", false);
			if (!player.hasVagina()) outputText("prostate", false);
			else outputText("inner walls", false);
			outputText(" until your orgasm overpowers your bunny-fucked daze and you peak, your egg-bloated body spurting in gushing jets of pale seed to paint the olive girl's insides white.\n\n", false);
			
			outputText("Her second egg forces its way down your throat with pulsing shudders and you can feel your hips straining against the weight of your overburdened stomach. You're a little afraid of what the second one will do to you as it slides out of the flared tip of the bunny's fourteen inches. Maybe it's the milking motion of the bunny's head bobbing in happy hops on your cock or maybe it's the swelling numbness of the eggs, but your body begins to feel hot and your flesh tingles at your scalp and butt. You clench your eyes, grunting through the heat of the bunny's eggs and, to your surprise, your belly begins to feel like it's emptying.", false);
			player.refillHunger(60);
			if (player.tailType != TAIL_TYPE_RABBIT) {
				//[No Tail: 
				if (player.tailType == TAIL_TYPE_NONE) outputText("  The heat around your lower back clutches at your tail bone and you feel a fluffy explosion swell around your butt cheeks as a fluffy bunny's tail pops out of your back, twitching excitedly!", false);
				//Existing tail: 
				else outputText("  Your tail jiggles and shrinks, slowly sucking back into your body until only a tiny nub remains which quickly explodes with fluff into a cuddly, twitching bunny tail!", false);
			}
			if (player.earType != EARS_BUNNY) {
				outputText("  The top of your head is next, it seems.", false);
				//[No antennae:
				outputText("  Your eyebrows feel like they're being drawn upwards, your eyes getting larger and larger until you're almost painfully aware of every color and sound around you. You shake your head and large, floppy bunny ears bounce in front of your eyes.", false);
			}
			outputText("\n\n", false);
			
			outputText("With a happy sigh, the girl slides off of your cock and lets it flop against your leg, not a single drop of cum wasted. Her belly has ", false);
			if (player.cumQ() < 250) outputText("a slight swell", false);
			else if (player.cumQ() < 1000) outputText("a noticeable girth", false);
			else outputText("bloated obscenely", false);
			outputText(", your spunk calming the egg-laying passion. She pulls her shrinking phallus from your mouth with a wet slurp, the taste of her strange cum sweet on your lips. She rises to a crouch and gives your ", false);
			if (player.earType != EARS_BUNNY) outputText("new ", false);
			outputText("ears a playful tweak between her thumb and forefinger. \"<i>Sorry about that, I don't know what came over me! I certainly didn't expect this, though! Kind of makes me want to stick around and see if you and I could pop out more bunnies,</i>\" she winks. \"<i>But unfortunately, I've got to get going! Maybe I'll try to find you again, some time down the line.</i>\" She gives you a moist little kiss and hops away, still energetic after all that. You groan, still recovering from the eggs.", false);
			
			player.tailType = TAIL_TYPE_RABBIT;
			player.earType = EARS_BUNNY;
			doNext(camp.returnToCampUseOneHour);
			player.orgasm();
			dynStats("lib", 1, "sen", 1);
		}
	}
	//CUNTS
	else {
		outputText("It'd be a shame if both of you didn't have a chance at a little fun, wouldn't it? Gripping the dusky-skinned girl, you gently push her down and hover over her face for a moment, playing with the whiskers on her freckled cheeks. Your tickling seems to excite the girl and before long, she's panting through her buck teeth, her stiffness rigid and pulsing with her racing heartbeat. Flipping over her, you park your [legs] on either side of her ears and lean down, toward her crotch, savoring the slightly sweet scent that wafts from her sweat-slick body. Her cock is almost intimidating, bulging obscenely in front of you, tiny dollops of pre-cum oozing to the pointed tip in rich bubbles that trickle down her caramel skin. You rest your cheek against the bunny-girl's root and tentatively lick up her shaft, gathering the stray strands of cum that stripe her dusky dick with snowy white. She gasps and her cock twitches against your face, bobbing back and forth in time to the rapid vibration of her legs. When you taste her cum, it gives you an oddly numb feeling in your mouth, cold and warm at once, but making the flesh inside your cheeks swell a bit, tightening your mouth.\n\n", false);
		
		outputText("Underneath you, the bunny seems to be admiring your pussy with barely contained lust. The boiling horniness you saw earlier is overpowering her restraint and it's all she can do to keep herself from jamming her nose into your hot gash. Her long, broad tongue licks up and down your womanhood, hot and wet, her cute little whiskers rubbing against your labia with a maddening tickle. A tremor of uneasiness creeps into you as she runs her long, buck teeth against your supple flesh, but surprisingly, you find that they're extremely dull and almost feel soft to the touch. As you bring your mouth to her pointed cockhead, she mumbles something about 'eggs' and guides her teeth to your clitty with hungry relish. Using her teeth and her tongue, she strokes your sensitive button like she's wetting the tip of a carrot. She slips her tongue into your folds with a panting gladness. \"<i>Please please please please,</i>\" she chants, lips drinking in your moisture with each breath. \"<i>Must lay eggs, must breeeeeeed,</i>\" she whines before flicking her tongue into your inner labyrinth, flicking rapidly as her buck teeth massage your enflamed clit, every head bob sending shivering weakness through you from the delightfully cold incisors.\n\n", false);
		
		outputText("In turn, you suck all the harder on the bunny-girl's cock, swallowing a few inches at a time until your mouth feels full of the chocolate girl's erection. Around your head, she's drawn her knees up and braces her legs on the balls of her feet. Her lower body vibrates with the bouncing excitement of her twitching calves and it makes the prick in your mouth quiver with a breeder's anticipation. Her sac rolls this way and that in front of you, oval-shaped balls bouncing in eager appreciation and you can't help but wrap your hand around them, feeling the radiating heat pouring from the scrotum in the palm of your hand. Gently rolling them in your hand, you can feel the weight of the rapidly filling pouch in your palm. With your thumb, you stroke her bronzed nuts up to the tip of her vagina. The bunny's clit is as hard and large as the tip of your pinkie and you circle it with your fingers, trying to tease it out of its pink, fleshy hood.\n\n", false);

		outputText("Your teasing and prodding may have been ill-advised, you realize, as the bunny-girl's restraint evaporates like fog on a hot day. Her animalistic instincts kick in and the girl's bobbing legs become full-sized thrusts. With surprising leg strength, she bucks her hips in increasingly long strokes until her whole butt is bouncing off the ground like fuzzy rubber. You try to compensate, but the girl's face-fucking jubilation is relentless. In seconds she goes from your tongue to your tonsils to your throat, her conical dick perfectly shaped to slide right into your neck. You begin to choke in response to the sudden intrusion, but the bunny's trickling pre-cum provides a woozy numbness that relaxes your gag reflex and swells your throat into a soft, squishy tunnel, pulsing with cunt-tightness. Rocking her head in time to her hips, she seems just as eager to earn your orgasm as she is to give you hers. With a gleeful 'squeek' noise she opens her mouth wider than you would've believed possible and feeds her broad tongue into your nethers filling you with muscled flesh as thick as a cock, her gently stroking rabbit teeth pressing your over-stimulated clit just enough to send orgasmic shivers through your body.\n\n", false);
		
		outputText("The bunny-girl's chest rises and falls rapidly, almost as if she's hyperventilating. You realize she's gone into a breeding frenzy! Wrapping her legs around your head, she clings tightly to you and flips the two of you around with a hard thud that bottoms out her 14\" cock in your throat. Your eyes go wide, too stunned by the caramel pole running from your lips to your stomach to be terribly concerned by the sudden lack of oxygen going to your body. Her balls lurch against your nose as her egg-laying urges turn the bunny into something feral. Every inch of her lean, olive body humps against yours in rapid, tiny hops that keep your bodies bouncing against each other. Her hyperactive overdrive gives a frisky energy to her fucking and sucking. The bunny's muscled body hops higher and higher, until she's thrusting nearly a foot of her chocolate prick in and out of your mouth, thankfully giving you enough respite to breathe through your nose between strokes.\n\n", false);
		
		outputText("The spry bunny starts to make you dizzy and the slapping of her modest B-cups against your " + player.chestDesc() + " has begun to leave tingling red welts on your sensitive flesh. Wrapping one arm around her waist, you pull her crotch tightly against your face and bury your other hand into her dripping snatch, bunny lips parting like velvet to your forceful grip. Digging three fingers in, you hook your fingers around and drag them along the girl's quivering walls until her choked squeals tell you that you've found her most sensitive spot. Her gleeful hops cease immediately and her whole body trembles in your embrace. You congratulate yourself on your quick thinking as her cock pulses in your mouth, the girl's orgasm imminent. To your considerable surprise, however, instead of merely pulsing, her balls begin to swell and one of them pops into her body! You can see an egg-shaped bulge work its way up her abdomen toward her cock and you quickly try to draw your head back. The bunny's arms shoot to the back of your head and her fingers dig into your hair, trying to force you back down as she moans into your groin. You pull against her grip, the egg-shaped bulge working its way up her shaft just a bit faster than you can distend it from your gut. Drool-slick flesh expands as the protrusion slips past your lips and just as her cockhead slides against your tongue, her narrow corona swells, dilating obscenely. A hot rush of tingling cum erupts in your mouth, gooey strands filling your cheeks, sliding back down your throat, and even bursting from your nostrils in soupy ropes of sticky ejaculate when your attempt to swallow her load closes your esophagus. The girl's load rolls in your mouth for a moment and you find that the cummy mess seems to have deposited an egg on your tongue!\n\n", false);
		
		outputText("Still possessed by the delirious egg-laying hysteria, the bunny grunts and jams her cock back down your throat, pushing the egg along with it. Your skin mushrooms as the bunny's load slides down your cum-lubricated neck and tumbles into your belly with an audible, vulgar plop. A feeling of incredible fullness fills you, as if you've been swallowing spunk and eggs for hours. You become dizzy from the bunny's numbing jizz and when her sac deflates as the second egg slides into her dick, you shake your head weakly, as if to say 'no more.' The girl is too far gone in her wanton ardor to take your motion as anything but encouragement, however, and she nuzzles her nose into your vulva, whiskers vibrating with a happy little hum, her buck teeth massaging you enthusiastically, impatient for her own creamy meal. Her hands slide from the back of your head, along your neck, down your back, and to your rump, fingers wrapping around to find your sphincter. Slipping both middle fingers in, she strokes your inner walls with fingers and tongue until your orgasm overpowers your bunny-fucked daze and you climax again, your egg-bloated body spurting in gushing jets of female lubrication into the olive girl's twitching nose.\n\n", false);
		
		outputText("Her second egg forces its way down your throat with pulsing shudders and you can feel your hips straining against the weight of your overburdened stomach. You're a little afraid of what the second one will do to you as it slides out of the flared tip of the bunny's fourteen inches. Maybe it's the milking motion of the bunny's head bobbing in happy hops on your clit or maybe it's the swelling numbness of the eggs, but your body begins to feel hot and your flesh tingles at your scalp and butt. You clench your eyes, grunting through the heat of the bunny's eggs and, to your surprise, your belly begins to feel like it's emptying.", false);
		if (player.tailType != TAIL_TYPE_RABBIT) {
			//[No Tail: 
			if (player.tailType == TAIL_TYPE_NONE) outputText("  The heat around your lower back clutches at your tail bone and you feel a fluffy explosion swell around your butt cheeks as a fluffy bunny's tail pops out of your back, twitching excitedly!", false);
			//Existing tail: 
			else outputText("  Your tail jiggles and shrinks, slowly sucking back into your body until only a tiny nub remains which quickly explodes with fluff into a cuddly, twitching bunny tail!", false);
		}
		if (player.earType != EARS_BUNNY) {
			outputText("  The top of your head is next, it seems.", false);
			//[No antennae:
			outputText("  Your eyebrows feel like they're being drawn upwards, your eyes getting larger and larger until you're almost painfully aware of every color and sound around you. You shake your head and large, floppy bunny ears bounce in front of your eyes.", false);
		}
		outputText("\n\n", false);
		
		outputText("With a happy sigh, the girl rubs your slick honey off of her face and gives your clit a final, pleased lick. She pulls her shrinking phallus from your mouth with a wet slurp, the taste of her cum sweetly icy on your lips. She rises to a crouch and gives your ", false);
		if (player.earType != EARS_BUNNY) outputText("new ", false);
		outputText("ears a playful tweak between her thumb and forefinger. \"<i>Sorry about that, I don't know what came over me! I certainly didn't expect this, though! Kind of makes me want to stick around and see if you and I could pop out more bunnies,</i>\" she winks. \"<i>But unfortunately, I've got to get going! Maybe I'll try to find you again, some time down the line.</i>\" She gives you a moist little kiss and hops away, still energetic after all that. You groan, still recovering from the eggs.", false);
		player.tailType = TAIL_TYPE_RABBIT;
		player.earType = EARS_BUNNY;
		doNext(camp.returnToCampUseOneHour);
		player.orgasm();
		dynStats("lib", 1, "sen", 1);
	}
}


//Bee on Bunny, by Eliria
//Coded or questionable parts are in {}.
//Thank you for your time! Scene as follows (also in attachment):
public function layEggsInBunbuns():void {
	clearOutput();
	outputText("The displayed lapin in front of you has you excited, but not for a simple roll in the grass.  Your ");
	if (player.eggs() < 20) outputText("eager egg-tube slips free, ready to show the rabbit you can play the egg game too.");
	else if (player.eggs() < 40) outputText("distended bug part quivers in anticipation, the ovipositor pushing into view with a drop of honeyed pre on its tip.");
	else outputText("low-hanging bee abdomen drools honey-like ichor down its carapace from the bulge where the thick black organ shows its need to relieve your burden.");
	outputText("  The bunny gasps upon noticing it, the herm's hips wiggling. \"<i>Oh my, could... could you mount me with that?  I need to egg so badly.</i>\"  Not needing to be urged further, you arch your bee-section up underneath you while lifting the lusty bunny against you.");
	outputText("\n\nPulling her so that she presses her tits against your [chest], the throbbing egg-depositor rubs between her legs.  With a high squeal she pushes forward harder, the long lapin cock twitching with her heartbeat");
	if (player.gender == 0) outputText(" against the empty place of your crotch.");
	else {
		if (player.hasCock()) outputText(" alongside [eachCock]");
		if (player.hasVagina()) outputText(" and her hefty oval balls rubbing the [vagina] tucked between your thighs");
		 outputText(".");
	}
	outputText("  She braces herself with arms around your shoulders, trying to nearly jump onto you as you ram your engorged ovipositor into her tight ass.");
	
	outputText("\n\nYou shudder, adjusting to her position and beginning to buck up in order to stuff the length of flesh deeper into the warm passage under the rabbit's tail.  Wiggling her hips as it pushes half of itself further, the egg-chute pulses, then deposits some bee-secretion into the happy companion.  Having prepared her insides, your organ and abdomen flexes, sticking the egg-tunnel up to its base.");
	outputText("\n\nThe forces moving along the sensitive shaft give you a pseudo-orgasm, pushing an egg down the flesh-tube pleasurably slow.  She relaxes a moment, tongue hanging out cutely before her big dick spurts pre onto your stomach and [chest] just as the first ovoid finds her puckered entrance.  Another egg finds its way from your cache as soon as the first passes the entrance and joins it on its way to being planted inside her.");
	
	outputText("\n\nShe continues writhing against you, bouncing up and down against the bee-abdomen and working the eggs in faster.  As you feel the first one reach the end of the trail you find yourself experiencing an ecstatic energy");
	if (player.gender > 0) {
		outputText(", ");
		if (player.hasCock()) outputText("[eachCock]");
		if (player.gender == 3) outputText(" and ");
		if (player.hasVagina()) outputText("your [vagina]");
		outputText(" lathering the bunny-girl in ");
		if (player.hasCock()) outputText("spunk");
		if (player.gender == 3) outputText(" and ");
		if (player.hasVagina()) outputText("femcum");
	}
	outputText(".  Stuffing a warm hole with egg after egg is not only fulfilling (for <i>both</i> involved) but is also damn fun, which the rabbit agrees with!");
	outputText("\n\nAnother egg, then another and another pump down your egg-cock with plenty of honeyed goo between to push her belly further and further out. You lose count of how many slip into her, completely engulfed by the orgasmic joy. Your legs had given out sometime during the process and the hour has passed, but it doesn't matter to you so long as there is another egg to lay.");
	
	outputText("\n\nYour front is coated with the bunny-girl's spooge, dripping down both your thighs onto the yellow and black chitin of your bee-abdomen.");
	if (player.gender > 0) {
		outputText("  You add to the mess, ");
		if (player.hasCock()) outputText("spraying a long, thick load against the bunny's soft tits from your [eachCock]");
		if (player.gender == 3) outputText(" and ");
		if (player.hasVagina()) outputText("splashing her balls with your girlcum");
		outputText(".");
	}
	outputText("\n\nFinally you find you no longer have any to give to the egg-obsessed rabbit girl and the ovipositor retracts into its slit.  Tired but blissful, she curls up to slumber, and you leave her to deal with having a stomach chock full of eggs 'n honey, returning to camp until you once again need a warm body to play host.");
	player.dumpEggs();
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}


public function ovipositBunnyEaster():void {
	clearOutput();
	outputText("Smiling a little over-eagerly, you suggest, \"<i>You know, if you really like eggs, I know where you can get a few...</i>\"");
	outputText("\n\n\"<i>Oh?  Where's that?</i>\" she responds, both her floppy ears standing up stock-straight and quivering with excitement.  She hops over to you, unconsciously letting her dripping phallus bob ponderously with each jump, the inertia turning it into a sexual pendulum of ridiculous, fourteen-inch proportions.  \"<i>Are they behind you?</i>\"");
	outputText("\n\n\"<i>It's a surprise,</i>\" you promise, \"<i>Get on all fours, and I'll give you all the eggs you could ever want.</i>\"");
	outputText("\n\nThe confused, almost clueless look in her eyes betrays her hesitancy, but she obeys, spurred by needs she doesn't even seem to truly understand.  Her poofy little tail flips up as far as it can, and you're treated to the sight of her big, surprisingly muscular rump.  All that hopping around has done wonderful things for her rear, and the bunny-girl's thighs are similarly toned, obscured only by a hint of fat and her down-soft fur.  You can see moisture running freely from a puffy pink mound, much of it clinging to her smooth sack's gentle, oblong curves.  She shudders slightly as the enormity of the pose she has struck settles into her mind.");
	
	outputText("\n\nYou don't give her a chance to regret adopting such a sensual stance.  Instead, you grab two big handfuls of furry butt and squeeze as you climb atop her, not as a male taking a female but as an ");
	if (player.canOvipositBee()) outputText("insect");
	else outputText("arachnid");
	outputText(" claiming an incubator.  When she feels your groin pressing on the small of her back, the fluffy hare grows concerned, looking over her shoulder and declaring, \"<i>You... you can't put eggs in me like THAT!</i>\"");
	outputText("\n\nYou snicker and pat her right between the ears, even stretching down to lick at the flawless, dusky skin of her shoulder, tasting the salty flavor of the sweat she's started to bead.  Suggestively, you whisper, \"<i>Oh, I brought you LOTS of eggs...</i>\"");
	
	outputText("\n\nOn instinct, your ovipositor slides free of the concealing slit on your abdomen in an instant, spraying a fan of slippery, lube strands across the bunny-girl's tight ass.  The exotic organ squeezes right through her plush bottom-cleavage, twitching with pleasure as the rounded tip glides through the folds of her pussy, smearing fresh lubricant over itself and the ready, heated lips.  It goes on to bump up against the lapine woman's newly-exposed clit, which forms the perfect backstop for your ovipositional onslaught.  She gasps beneath you, squirming her fuzzy hips back at you as she reacts to the sensations unthinkingly.  Her damp nethers flush hotter, and you can feel a trickle of wetness dripping out of her snatch and down your alien rod.");
	
	outputText("\n\nYou chitter excitedly at the thought of having such a willing partner, and shift slightly, adjusting your egg-bound abdomen in an attempt to line up with the thick-thighed woman's entrance.  Her squirming and wiggling doesn't make it much of an easy task.  Again and again, you smack your thick tool into her butt, into her sack, or across one of her furry cheeks.  The attempts excite her further, to the point where she's openly moaning and crying, \"<i>Ohhhh, you're gonna egg me right?  Mmm, yeah, egg me!  Please, egg me!  I... I need them!</i>\"");
	outputText("\n\nIf she'd settle down, you'd already be filling her!  The troublesome slut is holding herself up with one hand and using the other to pump away at her disproportional dong with feverish, sloppy strokes, her pre noisily schlicking across her length with every stroke.  She's so big that you can think of an easy way to silence her...  You push down on the back of her head and drive the tip of her gushing cock-tip straight into her mouthy little maw.  She struggles at first, but as her pre-cum pools in between her lips, the fight flows out of her.  Drooling and moaning incoherently, her hips begin to rock slightly as her shoulders relax.  Her spittle hangs in long strands and froths at the corners of her mouth as she starts to autofellate, eyes slightly unfocused and body relaxing as if under the influence of some kind of drug.");
	
	outputText("\n\nLuckily, one of her backstrokes presses her juicing mound perfectly against your prong.  You gasp as more of it pushes free from your slit.  The fresh inches ensure that you're immediately docked with her fertile innards, connected by the thick protrusion while your eggs roll into position, some already migrating down the hollow tube, much to your relief and excitement.  Grabbing hold of her nerveless, relaxed shoulders, you pivot your body to force yourself deeper, the slick lubricants already running out of you to mix with the bunny's own.  Her lapine body is just waiting to be bred; you can feel it in the heat of her tunnel and the way it squishes down around your ovipositor.  You give up your own sigh of indulgence and relax muscles you didn't know you had, releasing your cargo to flow into your moaning mate.");
	outputText("\n\nYour prong ripples and distends to make room for what's passing through it, though the tip is still narrow enough that you can easily poke it through the bunny-gal's dilating cervix.  You actually felt it starting to yawn open before you plunged it into her womb, and it's still spreading even now, allowing you to spear deeper and deeper with each push.");
	
	outputText("\n\nSuddenly shifting, the hare-woman's body tilts as her arms give out, uselessly splayed alongside her.  Her dick is still barely inside her mouth, but the flow of pre-cum seems to be even faster than before.  Her cheeks keep puffing out with whenever a fresh wave of the stuff rolls into her maw, and though her throat is swallowing and unchecked rivers of the stuff leak out through the loosening seal around her shaft, you can tell she's just getting started.  Of course, the way she's just completely relaxing into your fuck hasn't stopped her from humping her own mouth or having her pussy caress your prong.  Sexual instinct seems largely unaffected by whatever her pre-cum is doing to her...");
	outputText("\n\nYou let your muses fade into the gentle thrum breeding pleasure that's taken hold of your mind.  Moving with swift contractions down your fleshy tube, many of your eggs are already stretching you and the bunny-girl out.  They glide through you and her together, setting off cascades of delightful nerve-impulses in both your bodies.  When the first one crests through her opened cervix, you're transported to an ecstatic nirvana.   Gentle, muffled 'pops' can be heard whenever one of your spheres is released from your prong.");
	//{Some Eggs}
	if (player.eggs() < 20) {
		outputText("\n\nOne after another, your eggs are perfectly deposited in the lapine's now-conquered womb.  It does not take long, as you didn't have that many eggs built up, but the pleasure from your organ is too great to simply withdraw.  You keep yourself buried inside and continue to slowly ply the slippery quim with your insectile tool, releasing plenty of lubricant for your eggs to swim in.  Your rutting [hips] keep their slow tempo until you run out of liquid to inject.  The orgasms are all blurred together, one after another, such that all you can really remember is a haze of pleasure and grinding bodies.");
	}
	//{Plenty of eggs}
	else if (player.eggs() < 40) {
		outputText("\n\nOne after another, your eggs lurch into the conquered womb in a steady stream of oviposition, each one coming closer on the heels of the previous one.  You release a whimper of bliss at the same time as your incubator, her tight pussy actually trying to milk you of sperm.  Of course, that just makes your eggs flow into her that much faster.  Her uterus is soon stuffed with your ");
		if (!player.canOvipositBee()) outputText("arachnid");
		else outputText("insectile");
		outputText(" cargo, but you aren't empty, so you force more and more inside her.  She's so stretchy that it's easy to do, and before long she has a nicely rounded, pregnant belly (even if it is a little bit bumpy).  Shuddering, you release a few long, thick squirts of lubricant over your leavings and sag down, spent.");
	}
	//{Lots of Eggs!}
	else {
		outputText("\n\nOne after another, your eggs are forcefully crammed into the lapine's conquered womb.  You've got so many that the spheres seem like an endless tide, one that feels like an equally endless orgasm, a constant surge of sexual release directly into the deepest part of your limp mate's incubator.  She's filled almost immediately, but you just keep forcing egg after egg into her.  At first, this only rounds her belly slightly.  You just keep going and going ");
		if (silly()) outputText("like an energizer bunny");
		else outputText("like some kind of endless, pregnancy-inducing fuck-beast");
		outputText(", forcing your willing prey's womb to stretch to new limits, so huge and full that it's pressing against the ground.  Rounded, pebble-like protrusions are visible on the gravid dome, each one of your deposits.  You groan as you push the last one inside of her and begin to drain the last of your lubricants inside her, savoring the last of your pleasure as you come down from the immense high.");
	}
	//{END FORKS}
	outputText("\n\nYou climb off as your ovipositor retracts into its slot.  The emptiness is a blessed change from the constant, needy weight of an unlaid brood.  As you gather your wits, you realize that the bunny-girl is still orgasming.  Her dick finally popped out of her mouth, and you're treated to the sight of her bukkaking herself with thick, clear sex-juice.  A huge bulge distends her urethra as it's forced through her shaft, erupting out into a bright pink egg.  It bounces off her drugged, dopey cheek as her nerveless lips try to moan, followed shortly after by a second.  In the wake of the two surprises, a wave of jism splatters across her head, plastering her ears back into her hair.");
	outputText("\n\nThe hare goes limp after that, her eyes drifting shut as her tongue idly licks her spent seed from her face.  It looks like she got more eggs than she reckoned for.");
	//ITS OVER
	player.dumpEggs();
	player.orgasm();
	dynStats("sen", -2);
	doNext(camp.returnToCampUseOneHour);
}

//Bunny Girl Eggsplosion 
//Additional, low chance encounter in the plains. Options in parentheses should be adjusted to the following format: (Normal text/ Easter text)
 //-----------
private function adjathaEggsplosions():void {
	clearOutput();
	outputText("Your trek through the plains is interrupted by a shrill, piercing cry that jolts you out of the daydreams that were floating through your mind.  The piercing wail of a woman in distress grabs your attention and you hurry over the rising hills to the source of the howling bluster.  You weren't sure exactly what to expect, but as the source of the commotion comes into view, you have to admit this wasn't exactly what you thought you'd find.");
	
	outputText("\n\nLying in a shallow valley is a ");
	if (!isEaster()) outputText("dusky");
	else outputText("chocolate");
	outputText(" skinned woman.  Atop her ");
	if (!isEaster()) outputText("tanned");
	else outputText("caramel");
	outputText(" head, two large pairs of bunny ears flop back and forth helplessly as she shakes her head in frustrated tension. Her long, muscled legs kick the ground in futile anguish, though you notice her feet are long and fuzzy, ending in thick paws with little pink pads underneath. Her arms appear to be secured behind her back by a corded rope that has her bound to a pair of tawny boulders. Between her legs, a fourteen inch erection throbs, fully erect and frothing with ");
	if (!isEaster()) outputText("thin, gushing pre-cum");
	else outputText("thick, syrupy cream");
	outputText(". It's a bunny-girl, certainly, but who would go through the effort of tying her up and then just leave?");
	
	outputText("\n\nAs you approach, she takes notice of you, turning her full attention to you with desperation dripping from every pore of her freckled, ");
	if (!isEaster()) outputText("olive");
	else outputText("cinnamon");
	outputText(" skin.  \"<i>Oh thank goodness,</i>\" she pants, her tongue lolling under her tiny buck teeth.  \"<i>You have to help me,</i>\" the ");
	if (!isEaster()) outputText("coffee");
	else outputText("toffee");
	outputText("-colored woman implores.  \"<i>I was minding my own business when some gnoll lady charged me and knocked me out!  When I came to, she'd bound me up and said she was leaving me here as punishment for invading her lands.  I've been helpless for hours and monsters keep finding me!</i>\"  You notice that a steady stream of pale semen leaks from between her legs - the sticky aftermath of those who found her before you.  Glancing at the ground, there are dozens of footprints in the loamy soil, most of them with cum pooling in the depressions. Considering the cacophony she was making just a moment ago, it's no wonder everything in the area seems to have found and sated themselves in her.");
	
	outputText("\n\n\"<i>That's not even the worst paaaaaaart!</i>\" she moans, squeezing her knees together tightly, trying to rub the throbbing back of her untended erection.  You notice a small, metallic glimmer at the base of her shaft and realize that the gnoll left her with a bronze cock-ring.  With her hands tied behind her, the bunny girl's been unable to get off throughout a full day of being fucked by anything with a sex drive.  A thought strikes you and you look at the boulders she's bound to a little closer.  Sure enough, what you mistook for darkish, strangely spherical stones are, in fact, the bunny girl's balls.  The swarthy surface strains with bloated need, their burden ballooning her taut testes with a throbbing multitude of eggs.  \"<i>Pleeeeeease! You've gotta let me go!  The pressure's unbearable!</i>\"  You notice a dangerous glint in her eyes as she says it, eyeing your [ass] with a frantic madness.  You could let her go, if you wanted, or use her like everyone else who's come before you.  Alternately, you could leave her bound and get her eggs out on your own terms.");
	
 	outputText("\n\nWhat will you do?");
	menu();
	//[Free Her (any)] [Fuck Her (male/futa)][Get Egged (female/futa)] [Leave]
	//[Free Her] (Any gender)
	addButton(0,"Free Her",freeHerOhGodWhyDidYouDoThis);
	//[Get Egged] (Female/Futa only)
	if (player.hasVagina()) addButton(1,"Get Egged",getEggflated);
	//[Fuck Her] (Male/Futa Only)
	if (player.hasCock()) {
		if (player.cockThatFits(40) >= 0) addButton(2,"Fuck Her",fuckTheEggBoundBun);
		else outputText("  <b>You're too big to fuck her!</b>");
	}
	addButton(14,"Leave",camp.returnToCampUseOneHour);
}
 
//[Free Her] (Any gender)
private function freeHerOhGodWhyDidYouDoThis():void {
	clearOutput();
	outputText("Taking a chance, you step up to the wriggling bunny and inspect her bonds.  The girl's body is covered in a ");
	if (!isEaster()) outputText("sheen of sweat");
	else outputText("shimmering glaze");
	outputText(", her urgent lust pulsing in every inch of her ");
	if (!isEaster()) outputText("freckled brown");
	else outputText("pudding rich");
	outputText(" skin.  Her abdomen is slightly rounded with a pot-bellied pout that you assume must be the seed of the previous Samaritans.  Due to her inability to climax, her pussy must be clenching so tightly that only a thin trickle of cum is able to escape.  Her ");
	if (isEaster()) outputText("cony ");
	outputText("cock jerks in the air with every hyperventilating breath, ");
	if (!isEaster()) outputText("bubbling pearls");
	else outputText("gooey marshmallows");
	outputText(" of pre dribbling from the narrow, spear-like crest. The lustful girl's balls are even more lewd close up, gargantuan orbs obscenely stuffed with ");
	if (!isEaster()) outputText("the carnal fruit of her unwelcome, monstrous couplings");
	else outputText("candied plenty, her saccharine treats swimming amid a warm sea of honeyed spunk");
	outputText(". She bites down on her lower lip with her prominent front two teeth, her eyes following your motions intently, hoping for the best but braced for the worst.");
	
	outputText("\n\nGently bending her forward at the waist, you examine the ropes around her wrists.  They appear to have been tied with a simple slip knot designed to cinch tighter the harder she struggles against it.  The girl's tuffed tail twitches eagerly atop her supple rump, as she bobs up and down on her large bunny toes.  With a few firm tugs, you manage to undo the cords and let her arms loose.  You almost expect the bunny-girl to make a grab for you, but she's so overcome by the need for release, she all but forgets her emancipator.  Breathlessly, the energetic hare seizes the constraining loop of metal and rolls it off her shaft with moaning delight, throwing it into the tall grasses triumphantly.");
	
	outputText("\n\nBefore the cock ring even lands, she's sunk to her knees, both hands pumping her length feverishly, coaxing her pent-up reservoirs to sweet release.  The behemoth balls next to you churn and gurgle in sympathetic fervor, trembling at the intensity of her passion.  A thick bulb forms at the base of her member, the pliant flesh distending to twice its normal girth.  Slowly, achingly, the protuberance is forced up her fourteen inch rod, the tip of her cockhead dilating like a gaping mouth.  Then, with a loud, gushing pop, the first egg spurts from her breeding pole, shooting through the air at the head of a tremendous fountain of ");
	if (!isEaster()) outputText("splattering spoo");
	else outputText("climaxing cream");
	outputText(".  The showering spray continues in an unbroken outpouring, a river of alabaster arcing and gushing in a throbbing surge that white-washes everything within ten feet of her frontal arc.  Countless ");
	if (!isEaster()) outputText("bright pink eggs");
	else outputText("candy-coated confections");
	outputText(" issue forth amid the ");
	if (!isEaster()) outputText("cum");
	else outputText("icing");
	outputText(" geyser, plopping moistly here and there.  Some stop in plain sight, others roll into hidden hollows, left for some curious treasure hunter.");
	
	outputText("\n\nGasping and squealing in unfettered release, the bunny girl continues pumping her torrential spigot with one hand while the other runs across her heaving, glistening breasts, pinching her ");
	if (!isEaster()) outputText("pert");
	else outputText("gum drop");
	outputText(" nipples as her big, soft toes dig rutting furrows into the ground beneath her.  Her orgasmic throes send spasms of bliss through her whole body, her clenched inner muscles finally relaxing enough to release the jism inside her womb, vulgar globules oozing down her trembling inner thighs.");
	
	outputText("\n\nThe frantic pace of her initial discharge ebbs as her hulking testes visibly shrink.  She leans up against the wobbling factories, resting atop them like they were hefty, liquid pillows.  It'll take her a while to finish emptying herself completely, but for the time being, she seems content.  You give her fluffy tail a playful poof and head back to camp, stooping to retrieve one of the girl's eggs from the ground as you go.\n\n");
	//[End Encounter, gain neon pink egg]
	dynStats("lus", 25);
	inventory.takeItem(consumables.NPNKEGG, camp.returnToCampUseOneHour);
}

//[Fuck Her] (Male/Futa Only)
private function fuckTheEggBoundBun():void {
	clearOutput();
	outputText("It's not often you find a treat gift wrapped so neatly for you; what kind of ingrate would you be if you just turned it down?  You step up to the wriggling bunny and inspect her carefully.  The girl's body is covered in a ");
	if (!isEaster()) outputText("sheen of sweat");
	else outputText("shimmering glaze");
	outputText(", her urgent lust pulsing in every inch of her ");
	if (!isEaster()) outputText("freckled brown");
	else outputText("pudding rich");
	outputText(" skin.  Her abdomen is slightly rounded with a pot bellied pout that you assume must be the seed of the previous Samaritans.  Due to her inability to climax, her pussy must be clenching so tightly that only a thin trickle of cum is able to escape.  Her cony cock jerks in the air with every hyperventilating breath, ");
	if (!isEaster()) outputText("bubbling pearls");
	else outputText("gooey marshmallows");
	outputText(" of pre dribbling from the narrow, spear-like crest.  The lustful girl's balls are even more lewd close up, gargantuan orbs obscenely stuffed with ");
	if (!isEaster()) outputText("the carnal fruit of her unwelcome, monstrous couplings");
	else outputText("candied plenty, her saccharine treats swimming amid a warm sea of honeyed spunk");
	outputText(".  She bites down on her lower lip with her prominent front two teeth, her eyes following your motions intently, hoping for the best but braced for the worst.");
	
	outputText("\n\nYou plant yourself firmly in front of the ");
	if (!isEaster()) outputText("dusky");
	else outputText("caramel-skinned");
	outputText(" bunny-girl with an easy smile.  Loosening your [armor] just enough to let your stiffening cock");
	if (player.cockTotal() > 1) outputText("s");
	outputText(" free, you set your hands lightly on her ample hips, guiding your fingertips up her narrow waist and along the slick flesh of her tensed arms.  She trembles at your touch, but the boiling lust within her turns the fearful shudder into an orgasmic one in the very next second.  In this state, even just the touch of your fingers is enough to set her off, the bound hare's shaft spasming fruitlessly as the thick bronze of her cock ring holds back the torrential flood of her impotent climax.  You wrap your hands around her back, guiding them back down, over the ");
	if (!isEaster()) outputText("supple mounds");
	else outputText("taut dough");
	outputText(" of her wiggling ass and across the fidgeting girl's athletic legs.  Hooking one hand under her knee, you hoist up one leg and spin the girl in place, pushing her face-first into her own colossal, egg-bloated ballsac.  She lets out a thin \"<i>eep!</i>\" as her boundless energy sets off another futile bout of struggling against her bindings.");
	
	outputText("\n\n\"<i>Please,</i>\" she begs, \"<i>not more eggssss!</i>\"  Despite her squeaking protests, the girl's overflowing urges put a husky, wanton thickness in her voice.  She wobbles from one leg to the other, wiggling her fluffy tail as her jutted ass slides up and down your crotch, carnal cravings to breed leaving her little more than a paper-thin ounce of restraint, the frothing mania of lewd depravity electrifying her every nerve.  She's so tightly wound, she doesn't even notice when you grab her butt cheeks and sink your fingers into the ");
	if (!isEaster()) outputText("yielding flesh");
	else outputText("semi-spongy hotcakes");
	outputText(".  Some light prodding tells you that her ass is far too tightly squeezed from the tension in her bloated organs to have any hope of penetration.  Her snatch is nearly as secure, but the drooling seed of her earlier suitors, along with her own glistening honey should provide all the lubrication you need.  The slimy spunk of countless suitors is warm against the throbbing flesh of your [cock] and you ");
	if (player.cor < 33) outputText("grimace at the vulgar goo that washes over your flesh");
	else if (player.cor < 66) outputText("swallow a gulp as the lewd spoo squelches around your member");
	else outputText("revel in the profane stimulation of bestial batter anointing your length in impure, liquid virility");
	outputText(".");
	
	outputText("\n\nWith a grunt, you force yourself into her, pulsing phallus parting her overwrought pussy lips in a spearing thrust.  The bunny-girl gasps, her control suffocated under the fathomless ocean of her keening lust.  She bucks wildly against you, desperate to hilt your [cock] as swiftly and fully as she can.  Her stomach bulges while ropes of spunk splatter out of her stuffed cunny, displaced by your girth.  It's amazing she's so frisky after being taken so many times, you consider with delight as you grasp her slender waist to set her pace to your own.  Before long, you have her thrashing in ecstasy, a writhing parade of unfulfilled orgasms setting her body ablaze, her inner walls virtually vibrating around you while rivers of spunk flow down her legs, painting her ");
	if (!isEaster()) outputText("darkly freckled thighs ivory");
	else outputText("savory, chocolate thighs with pale cream");
	outputText(".  Reaching your own threshold, you lean forward, pressing your cheek against hers, the intake of your breath hissing between your teeth.  She instinctively understands, slamming her ass against your [hips] with as much force as she can muster.");
	
	outputText("\n\nYou orgasm, [oneCock] erupting inside the frenzied woman's womb with thick gouts of heavy seed ");
	if (!isEaster()) outputText("flooding her semen-gorged cunt with fresh issue");
	else outputText("glazing her cream-filled center with your silky spunk");
	outputText(".  She bucks helplessly as her gut swells under your load, ");
	if (player.cumQ() < 250) outputText("steady streams of cum seeping from her pussy");
	else if (player.cumQ() < 1000) outputText("bulging enough that her belly button turns outward as the cum oozing from her pussy gushes between the two of you");
	else outputText("growing larger and larger as cum splatters in thick streams from her saturated pussy. Your seemingly endless gallons of flooding cum wash the remnants of her previous partners away, immersing the caramel woman in the fluid wealth of your liquid possession.");
	outputText("  No sooner has your spunk taken root inside her, than the bunny's already colossal testes tremble anew.  Before your eyes, they balloon even larger, fattening with the profit of your claim.  You remain inside her a moment longer to marvel at the impossible bulk of her egg-stuffed body, before withdrawing and stepping back to clean yourself off.  Bulbous dollops of spunk bubble from her cunny as she impotently grinds her shaft against the mammoth bulk of her stoppered balls.  Satisfied, you head back to camp, leaving the bunny to the mercies of the next rescuer.");
	//[End Encounter, corruption up]
	player.orgasm();
	dynStats("cor", 2);
	doNext(camp.returnToCampUseOneHour);
}

//[Get Egged] (Female/Futa only)
private function getEggflated():void {
	clearOutput();
	outputText("Deciding it'd be too cruel to leave her like this, you resolve to put the bunny-girl at ease. However, you're not so foolish that you're willing to just untie her - if that hungry look in her eyes is any warning.  Stepping up to the wriggling bunny, you inspect her carefully.  The girl's body is covered in a ");
	if (!isEaster()) outputText("sheen of sweat");
	else outputText("shimmering glaze");
	outputText(", her urgent lust pulsing in every inch of her ");
	if (!isEaster()) outputText("freckled brown");
	else outputText("pudding rich");
	outputText(" skin.  Her abdomen is slightly rounded with a pot bellied pout that you assume must be the seed of the previous Samaritans.  Due to her inability to climax, her pussy must be clenching so tightly that only a thin trickle of cum is able to escape.  Her ");
	if (isEaster()) outputText("cony ");
	outputText("cock jerks in the air with every hyperventilating breath, ");
	if (!isEaster()) outputText("bubbling pearls");
	else outputText("gooey marshmallows");
	outputText(" of pre dribbling from the narrow, spear-like crest.  The lustful girl's balls are even more lewd close up, gargantuan orbs obscenely stuffed with ");
	if (!isEaster()) outputText("the carnal fruit of her unwelcome, monstrous couplings");
	else outputText("candied plenty, her saccharine treats swimming amid a warm sea of honeyed spunk");
	outputText(".  She bites down on her lower lip with her prominent front two teeth, her eyes following your motions intently, hoping for the best but braced for the worst.");
	
	outputText("\n\nSettling standing in front of her, you turn your attention to the ");
	if (!isEaster()) outputText("twitching length");
	else outputText("succulent delicacy");
	outputText(" before you.  The thought of letting her empty her eggs into your body flickers across your mind.  It's a mad impulse, you have to admit, but you kind of want to see what she's capable of.  Stripping your [armor] and setting it far enough away to avoid potential spills, you carefully place your fingers on the bronze ");
	if (!isEaster()) outputText("ring");
	else outputText("donut");
	outputText(" around her conical cock.  The engorged flesh is swollen with pent-up need and you almost swear it gets a bit bigger when your fingertips press against her bindings.  Slowly, carefully, you start to remove the cock ring.  Luckily, the steady flow of her ");
	if (!isEaster()) outputText("pre-cum");
	else outputText("milky cream");
	outputText(" has lubricated her shaft enough to make the loop's passage relatively simple.  Up, up, up it slides, over bulging veins and over the flared peak of her cockhead until, at last, you peel the cinch from her distressed member.  She reflexively bucks at the air, groping for any friction with a weak whimper.  You take a deep breath to steady your own accelerating heart rate and prepare yourself.");
	
	outputText("\n\nStepping forward, you press against the girl, her perky B-cup breasts squishing against your [chest] until you can feel her racing pulse pounding in her chest.  Her mouth opens in a wanton moan as you grind against her with your [hips], guiding her pulsing pecker toward your [pussy].  Pre-lubricated in her own ");
	if (!isEaster()) outputText("frothy juices");
	else outputText("slick honey");
	outputText(", her spear-like head slips easily past your labia, fervent flesh filling your trembling cavity. The girl's ");
	if (!isEaster()) outputText("thick pole");
	else outputText("sweet shaft");
	outputText(" sends ripples of hot and cold through your gut as her peculiar, almost numbing jism bubbles up inside you.  In another moment, you find yourself completely impaled on her turgid length, despite the throbbing girth of her ");
	if (!isEaster()) outputText("swollen mast");
	else outputText("bloated baster");
	outputText(".  Pressing her backwards, the two of you lean against her ");
	if (!isEaster()) outputText("supple");
	else outputText("marshmallow");
	outputText(" testes, their soft, pliant surface enveloping her as you straddle the helpless bunny.  Testing the tension of her scrotum, you find that the egg-filled sac is firm enough to support both of your weights without causing the girl any pain.  Gleefully, you wrap your arms around her waist and push forward, rolling up and over until the two of you rest atop the gargantuan balls like spherical, ");
	if (!isEaster()) outputText("well-padded bedding");
	else outputText("sponge cakes baked for a giant");
	outputText(".");
	player.cuntChange(28,true,true,false);
	
	outputText("\n\nAtop your perch, bound to the lapin by fourteen inches of caramel-colored flesh, you take a moment to rock back and forth atop the girl.  Merely being mounted has taken every ounce of her restraint, but you can tell it's a matter of seconds before her resolve crumbles.  Positioned perfectly to take the full geyser of her ");
	if (!isEaster()) outputText("gurgling seed");
	else outputText("saccharine seed");
	outputText(", you realize there's really only one thing left to do.  Sliding a hand between her waist and the tender flesh the two of you are balanced upon, your fingers seek out the ");
	if (!isEaster()) outputText("twitching tuft");
	else outputText("cotton candy poof");
	outputText(" of her fluffy tail.  You find the junction where it meets the base of her spine and bear down on the sensitive point with your knuckles, eliciting a shrieking squeal of bliss from the over-burdened bunny-girl.  An intense pressure floods your cunt as her ");
	if (!isEaster()) outputText("swollen dick");
	else outputText("candied cock");
	outputText(" distorts under the heft of the emerging eggs.  As the first oval bulge travels up her shaft, you grind and slam deeper on her until the narrow point of her ");
	if (!isEaster()) outputText("jizz-burbling");
	else outputText("jelly-bubbling");
	outputText(" crest presses hotly against your cervix.  The sputtering flood of her opiate spunk saturates your inner walls, giving them a yielding elasticity.  As the egg nears her tip, you spear yourself down on the climaxing girl's prominence, feeling her dilating peak penetrating your womb.  With an exquisite moan of drugged euphoria, you watch your abdomen bulge as the egg pops free, followed by jets of ");
	if (!isEaster()) outputText("tingling, liquid passion");
	else outputText("fattening, cream filling");
	outputText(".  Another egg rushes up, followed by another, the pace accelerating as you bounce atop the vivacious hare with fast, short strokes that rub your [clit] against her cum-bloated belly.");
	
	outputText("\n\nEgg after egg fills your womb, swelling your abdomen with the heavy ");
	if (!isEaster()) outputText("load");
	else outputText("treat");
	outputText(". You pant, finding it difficult to draw a breath with the burden massing in your inner recess, your tongue hanging freely  and drool trickling down the side of your mouth.");
	//Futa:
	if (player.hasCock()) {
		outputText("  Quite without realizing it, [eachCock] spasms in messy orgasm, spurting ropes of spunk  across the bunny girl's tawny skin like a gooey glaze.");
	}
	outputText("  Your vision swims and when you blink back the dizziness, you find your gut has bloated to the size of ");
	if (!isEaster()) outputText("advanced pregnancy");
	else outputText("gluttonous excess");
	outputText(".  Though her cushioning balls have emptied some of their load inside you, they're still huge enough to support you both, so you regretfully begin to slide off the bunny girl's cock, eggs filling the gap her distended shaft leaves.  Pausing, with the tip at the cusp of your flush lower lips, you turn around atop the delirious bunny, popping her crest out, a rivulet of ");
	if (!isEaster()) outputText("cum");
	else outputText("cream");
	outputText(" leaking from your freshly stuffed snatch.  With a guiding hand, you steer her surging spout to your [ass] and drop your full ");
	if (!isEaster()) outputText("egg-loaded");
	else outputText("candy fattened");
	outputText(" weight on the conical cock.  With fresh space to fill, the eggs flow into you once more, one pushing another in a procession up your large intestine.");
	//Futa:
	if (player.hasCock()) outputText("  The steady movement of the orbs pushing past your prostate drills another, even messier orgasm from your " + player.multiCockDescriptLight() + ", cum arcing into the air to shower down on the two of you in pearl beads.");
	
	outputText("\n\nTime seems to flow from one moment to the next, your consciousness fading in and out as a small deluge of ");
	if (!isEaster()) outputText("bunny seed");
	else outputText("marshmallow and chocolate");
	outputText(" loads up your belly as fully as your twitching, clenching womb.  You can practically taste the sweetness in the back of your throat by the time the bunny-girl's orgasm ends.  Your body is inflated far beyond anything you could've imagined, eggs and spunk leaking from your gravid abdomen.  The bunny girl is lost to the world, dazed in a private bliss as her basketball-sized balls slowly push the last few eggs out of her dusky stalk with splattering plops.  You couldn't move if you wanted to, so you just remain on the ground, enjoying the feeling of utter, immobile bounty.  Gradually, the eggs in your belly and womb begin to melt, losing their firmness in favor of a fresh flux of raw warmth that wrings a final climax from your overtaxed body.");
	
	outputText("\n\n");
	//Futa:
	if (player.hasCock()) {
		outputText("Your exhausted " + player.multiCockDescriptLight() + " somehow find" + (player.cocks.length > 1 ? "" : "s") + " the strength for a gushing orgasm of " + (player.cocks.length > 1 ? "their" : "its") + " own, strands of spoo spilling across your own body, white hot spunk bringing a fresh sheen to your sweat-slick [chest].  ");
	}
	outputText("Eventually, enough of the eggs melt to let you stand under your own power.  You grab your [armor] but hold off on putting it on until you have a chance to shrink down to a more normal size.  Before you leave, you make sure to remove the rope from her wrists, for when she gathers her orgasm-blasted wits.");
	//[If full bunny morph, End Encounter. Weight up, sensitivity down, fertility up.]
	if (player.bunnyScore() < 4) {
		player.knockUp(PregnancyStore.PREGNANCY_BUNNY, PregnancyStore.INCUBATION_BUNNY_EGGS);
	}
	else {
		player.knockUp(PregnancyStore.PREGNANCY_BUNNY, PregnancyStore.INCUBATION_BUNNY_BABY, 60);
		player.fertility++;
	}
	outputText(player.modThickness(100,3));
	outputText(player.modTone(0,3));
	player.orgasm();
	dynStats("lib", 1, "sen", -3);
	doNext(camp.returnToCampUseEightHours);
}
//If not full bunny morph: [Next]
//On the way back to your camp, the torrid heat of the melting eggs inside you become unbearable and you drop to your hands and knees. Something is changing!
//[Insert every bunny morph change text that the player does not have. End Encounter. Weight up, Sensitivity down, fertility up.]
	}
}
