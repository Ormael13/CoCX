package classes.Scenes.Areas.Forest{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class TamainsDaughtersScene extends BaseContent implements TimeAwareInterface {

//New Status:
//+Tamani's Husband – (Still need too big loss scene and centaur version)
//--Every point in it adds to lust gain per turn vs Tamani or Tamani/wdaughters
//--Slight alteration to some scenes
//--Leads up to perk with Tamani autosexing (maybe bad end)

//Fuck Them:
//	*Fits
//	 *Alternate Tamani scenes directly in the event.
//	*Doesnt Fit
//	 *Alternate Tamani scenes directly in the event.

//Let Them:
//	*Fits
//	 *Tamani Is Here
//	 *No Tamani
//	*Doesnt Fit
//	 *No Tamani
//	 *Tamani is here

//Win:
	//*Rape -> "Fuck Them" scenes.

//Lose:
//	*Daughters drag PC back to caves and milking machine action ensues.
//	*Tamani is there and hypno's the PC, then orgy ensues.

//Variables to track:
//	Number of Daughters – Capped at 19 if PC has not yet encountered them yet.
	//"Tamani" v2
//	Times Encountered – 0 → infinity
	//flags[kFLAGS.TIMES_ENCOUNTED_TAMANIS_DAUGHTERS]
//	Tamani Hypno Level – increases by 1 for each hypno event.  1-4 slight lust raises, 5-9 medium lust raises, 10-19 super high lust raises, 20+ high chance of autorape with special scene. 
	//flags[kFLAGS.TAMANI_TIMES_HYPNOTISED]
//	Daughter Preg Counter – they will not return until this countdown timer is 0.  Same length as Tamani's incubation – approx 1 week. 
	//flags[kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN]	
//Tamani's Daughters – Tracked every birthing.  High cum production characters will produce more //Tamani babies and thus grow the mob (and achieve bad-end) faster.  
	//Tamani's Daughters first arrive after #12 is born.  
	//Tamani's Daughters encounter is expanded after #20
	//Tamani's Daughters gets much harder @ #40
	//Tamani's Daughters gets nigh-impossible @ #60

		public var pregnancy:PregnancyStore;

		public function TamainsDaughtersScene()
		{
			pregnancy = new PregnancyStore(kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_TYPE, kFLAGS.TAMANI_DAUGHTER_PREGGO_COUNTDOWN, 0, 0);
			CoC.timeAwareClassAdd(this);
		}

		//Implementation of TimeAwareInterface
		public function timeChange():Boolean
		{
			pregnancy.pregnancyAdvance(); //Preg should be 7*24, ends at 0 to -48 --> 9*24, ends at 0
			trace("\nTamani's Daughters time change: Time is " + model.time.hours + ", incubation: " + pregnancy.incubation + ", event: " + pregnancy.event);
			if (pregnancy.isPregnant && pregnancy.incubation == 0) {
				flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] += flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_COUNT];
				flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_COUNT] = 0;
				pregnancy.knockUpForce(); //Clear Pregnancy
			}
			//Put a cap on daughters if they havent been met yet.
			if (flags[kFLAGS.TIMES_ENCOUNTED_TAMANIS_DAUGHTERS] == 0 && flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] > 30) {
				flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] = 30;
			}
			//Lower daughter population by 1 every fourth day once population gets high
			if (flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] > 40 && model.time.hours > 23 && model.time.days % 4 == 0) {
				flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS]--;
			}
			return false;
		}
	
		public function timeChangeLarge():Boolean {
			return false;
		}
		//End of Interface Implementation

		internal static var tamaniPresent:Boolean = false; //Used to communicate between this class and TamanisDaughters.as
		
//Prime daughter tit-size
//12-20 – C
//21- 40 DD
//41 –60 E
//30+ - F mother fucker!
private function tdCup():String {
	if (flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] < 20) return "C";
	else if (flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] < 30) return "D";
	else if (flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] < 40) return "DD";
	else if (flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] < 50) return "E";
	else if (flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] < 60) return "EE";
	return "F";
}


//ENCOUNTER:
public function encounterTamanisDaughters():void {
	spriteSelect(57);
	flags[kFLAGS.TIMES_ENCOUNTED_TAMANIS_DAUGHTERS]++;
	clearOutput();
	if (flags[kFLAGS.TIMES_ENCOUNTED_TAMANIS_DAUGHTERS] > 0 && rand(10) == 0) {
		tamaniPresent = true;
		outputText("While roaming along, you find your path ahead blocked by " + num2Text(int(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 4)) + " goblins.  At the forefront of the mob is Tamani", false);
		if (flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] >= 10) outputText(", your wife", false);
		outputText(".  You realize now that the other goblins must be your daughters.  Another crowd of small women emerges from the bushes, closing in a ring around you, preventing any chance of escape.  The largest of the younger goblin-women steps forwards, her " + tdCup() + " breasts jiggling, barely contained by the bondage ropes she has tied around herself.  She stops once she's next to her mother and Tamani explains, \"<i>I just can't keep their aching cunts at home anymore!  They're fertile adults now and they're wanting to get some experience with real dicks.  I figured you wouldn't mind helping them out a little.</i>\"\n\nWhat do you do? (Fight them off, Fuck them willingly, Let them fuck you)", false);
		//[Fuck Them] [Let Them] [Fight]
		simpleChoices("Fight", fightTamanisDaughters, "Fuck Them", fuckYoDaughtersHomie, "Let Them", legTamanisDaughtersRAEPYou, "", null, "", null);
		return;
	}
	tamaniPresent = false;
	outputText("While roaming along, you find your path ahead blocked by ", false);
	outputText(num2Text(int(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 4)) + " goblins.  You ", false);
	if (player.weaponName == "fists") outputText("ready your fists ", false);
	else outputText("draw your weapon ", false);
	outputText("and glance around evaluating your options.   Another crowd of small women emerges from the bushes, closing in a ring around you, preventing any chance of escape.  The largest of the goblin-women steps forwards, her " + tdCup() + "-breasts jiggling, barely contained by the bondage ropes she has tied around herself.\n\n", false);
	//first time
	if (flags[kFLAGS.TIMES_FUCKED_TAMANIS_DAUGHTERS] == 0) {
		outputText("She calls out, \"<i>We're tired of getting leftovers, so we're coming to the source.  Are you going to give us what we want?</i>\"\n\n", false);
		//[Fuck them] [Fight] [Play Dumb]
		simpleChoices("Fight", fightTamanisDaughters, "Fuck Them", fuckYoDaughtersHomie, "Play Dumb", playDumbToTamanisDaughters, "Let Them", legTamanisDaughtersRAEPYou, "", null);
	}
	else {
		outputText("She calls out, \"<i>We came back for more cream!  Come on, let's fuck again!</i>\"\n\nIt doesn't look like 'no' is a word they understand.  What do you do?</i>", false);
		simpleChoices("Fight", fightTamanisDaughters, "Fuck Them", fuckYoDaughtersHomie, "Let Them", legTamanisDaughtersRAEPYou, "", null, "", null);
	}
}

//[Play Dumb]
private function playDumbToTamanisDaughters():void {
	spriteSelect(57);
	clearOutput();
	outputText("You shrug and ask, \"<i>What exactly is it you want again?  I'm not sure you have the right " + player.mf("guy","person") + ".</i>\"\n\n", false);
	
	//approx 33% chance at 0 int, going up the smarter you are.
	if (player.inte/2 + 25 > rand(75)) {
		outputText("The leader looks you up and down for a moment.  Her face slowly contorts to puzzlement, then rage, \"<i>Tammi you ditz!  I thought you said this was his trail?  Come on girls, we've got a dad to hunt.</i>\"\n\n", false);
		if (flags[kFLAGS.TIMES_ENCOUNTED_TAMANIS_DAUGHTERS] > 1) outputText("They really must not be paying much attention to what you look like.", false);
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	
	outputText("The leader stamps her foot in a fit of rage.  It would be more imposing if she wasn't three feet tall... Her eyes lock onto your crotch and she says, \"<i>Last chance.   We're getting our ", false);
	if (flags[kFLAGS.TIMES_ENCOUNTED_TAMANIS_DAUGHTERS] == 1) outputText("first ", false);
	outputText("litters one way or another!</i>\"\n\n", false);
	
	//[Fuck them] [Fight] [Let them have their way with you]
	simpleChoices("Fuck Them", fuckYoDaughtersHomie, "Fight", fightTamanisDaughters, "", null, "Let Them", legTamanisDaughtersRAEPYou, "", null);
}

//[Fight Them]
private function fightTamanisDaughters():void {
	clearOutput();
	
	outputText("You whirl around threateningly, intent on putting Tamani's wayward brood back in their place.\n\n", false);
	startCombat(new TamanisDaughters());
	spriteSelect(57);
	if (tamaniPresent) {
		//(+5 mob strength)
		monster.str += 5;
		//(+5 mob toughness)
		monster.tou += 5;
		monster.HP += 10;
		//(-20 mob lust)
		monster.lust -= 20;
		//append combat desc
		monster.long += " <b>Tamani lurks in the back of the crowd, curvier than her brood and watching with a mixture of amusement and irritation.  She runs a hand through her pink and black hair, waiting for an opportunity to get involved...</b>";
	}
	return;
}
	
//(COMBAT TEXT:  You're fighting Tamani's brood.  All total, there are (x) of them spread in a loose circle around you.  Most of them have their hair dyed wild colors, and dress in little more than fetish clothing – for easy access you assume.  Some are dolled up with make-up, others have oiled their luscious forms, and a few are stopping to kiss and lick each other, putting on a show for their latest victim.  (Tamani is here as well, fighting her way to the forefront and absently massaging one of her \" + tamaniChest + \" as eyehumps your body.\")
//(Combat is 1 attack per 10 girls + 1x Tamani attack)

//[Fuck them]
private function fuckYoDaughtersHomie():void {
	spriteSelect(57);
	flags[kFLAGS.TIMES_FUCKED_TAMANIS_DAUGHTERS]++;
	var cocks:Number = player.totalCocks();
	var daughters:Number = int(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 2);
	
	clearOutput();
	outputText("You shrug out of your " + player.armorName + " and grab hold of ", false);
	if (cocks == 1) outputText("your ", false);
	else outputText("one of your ", false);
	outputText(player.multiCockDescriptLight() + ", swinging it around as it hardens, teasing the crowd of lusty bitches.\n\n", false); 

	outputText("\"<i>Come and get it,</i>\" you shout, strutting forwards.  The ", false);
	if (daughters < 12) outputText("girls", false);
	else outputText("crowd", false);
	outputText(" surges forwards, mobbing you from all sides.  ", false);

	//Find a dick that fits
	var primary:Number = player.cockThatFits(50);	
	//(Fits)
	if (primary >= 0) {
		outputText("You pick a random body from the crowd, impaling her on your " + player.cockDescript(primary) + ".  The others crowd around, jealous of your chosen cock-sleeve.   She looks up at you, blissful as she hugs against you and grinds her tight body down, raping her virginal hole on the firmness of your " + player.cockDescript(primary) + ".   The others massage your " + player.legs() + ", licking and nibbling your skin as they compete to tempt you into taking them next.", false);
		if (tamaniPresent) {
			outputText("  Tamani pushes aside the smaller sluts and ", false);
			if (player.balls > 0) outputText("cups your " + player.ballsDescriptLight() + ".", false);
			else outputText("licks your taint.", false);
		}
		outputText("\n\n", false);
		
		outputText("In no time, the vise-like grip of her cunt and thrill of taking her virginal passage push you beyond your threshold.  You groan and pump thick loads of jism deep into the tiny twat", false);
		if (player.cumQ() >= 500) outputText(", bloating her belly until she gurgles and squishes on top of you", false);
		outputText(".  She falls off with her eyes crossed as her sisters scramble to take her place.", false);
		if (tamaniPresent) {
			outputText("  Tamani shoves the rest of them away and mounts you, ", false);
			if (player.tallness >= 60) outputText("scrabbling up enough to ", false);
			outputText("kiss you roughly on the lips, tasting of cherries and sweat.  Your body goes limp, dropping down onto your back as your green mistress has her way with you.\n\n", false);
		}
		else {
			outputText("  Another mounts you, launching herself at you with such force that she knocks you off your " + player.feet() + " and onto your back.  A hand clamps over your mouth and jams something inside while another massages your throat, forcing you to swallow it.  Numbness flows through most of your body, robbing you of strength and feeling in all but one place...\n\n", false);
		}
		
		outputText("You're swarmed as you lie in the mud, covered head to toe in nubile young goblin flesh.  Some part of you KNOWS you're being raped, but you're so effectively drugged there really isn't anything to do but try to enjoy it.   The tight goblin-cunt wrapped around your dickflesh refuses to let it go soft, massaging it with clenching ripples of muscle.  ", false);
		if (tamaniPresent) {
			outputText("Tamani's massive jugs rest against your " + player.breastDescript(0) + ", bouncing and wobbling.  She crosses her arms over them and sucks on a finger, watching your expression with a mix of amusement and arousal.  She asks, \"<i>So what do you think of your daughters, sweet stuff?  They're just aching for a taste of their daddy's spunk, and it's hard to keep so many rambunctious sluts under control.</i>\"\n\n", false);
		}
		else outputText("Tamani's daughter looks up at you, giggling happily while her hips vigorously abuse you.   She asks, \"<i>Do you think my cunt is tighter than mom's is?  Bet you never thought you'd be fucking one of your daughters pregnant, did you?</i>\"\n\n", false);
		
		outputText("Such perverse thoughts, and coming from your own daughters.  ", false);
		if (player.cor < 33) outputText("You were supposed to save the village from corruption, not breed tiny sluts to overrun it... y", false);
		else if (player.cor < 66) outputText("You came here to make things better for everyone... well, at least you're helping these girls. Y", false);
		else outputText("You came here to make things better, but you know you'll keep knocking up Tamani every chance you get.  It's too much fun to resist adding to the sea of green girls. Y", false);
		outputText("ou moan as a drooling green cunt is pressed into your " + player.face() + ", smothering away any protests you might have offered.  Your tongue laps away, servicing another one of your many goblin offspring as best it can.  It plunges deep to harvest her nectar, making her soak you with juice, performing oral as if it were possessed.  Your eyes cross and you feel your release building, cresting in a wave as it prepares to dump into your ");
		if (!tamaniPresent) outputText("daughter");
		else outputText("favorite goblin MILF");
		outputText(".\n\n", false);

		outputText("The pressure of orgasm spikes as the first blast takes ", false);
		if (!tamaniPresent) outputText("your goblin daughter", false);
		else outputText("Tamani", false);
		outputText(" in her waiting womb, painting her walls white.  Each successive glob mixes into the slurry of sexual fluids brewing in her slit, until it starts to dribble out.  The goblin on your face cums noisily, filling your mouth with female moisture.   With no other choice, you swallow it down while your tongue keeps trying to pleasure her.  A sudden void of sensation and cold air overtakes your " + player.cockDescript(primary) + " as you hear the goblins squabbling.  In no time flat a fresh cunt is squeezing over your still-orgasming member, clamping down to form a tight seal as you pump it full of even more fertile seed.\n\n", false);

		//(Go to End if < 10 daughters), else keep goin
		if (daughters > 10) {
			outputText("As your orgasm trails off, your green cock-sleeve is removed.  You sigh happily, glad the ordeal is over.  Your " + player.cockDescript(0) + " manages to continue to throb, and you wonder just how long you'll have to wait for the goblin drugs to wear off.  The answer comes sooner than you think, in the form of a large vial of sweet-tasting liquid.  Your nose is pinched shut by a teal hand and your throat is massaged until you swallow the entire thing.  The result is immediate.  Slight shakes work their way through your body as it reacts to the corrupted drugs.  ", false);
			if (player.balls > 0) outputText("Your balls visibly puff up and slosh as one of your daughters plays with them, filling with more seed than ever before.", false);
			else outputText("Your gut clenches painfully as something inside puffs up.  Pressure builds at the base of your cock and you realize somehow you're more full of cum than ever before.", false);
			outputText("\n\n", false);
		
			if (tamaniPresent) {
				outputText("Tamani pushes the slut on your face off and plants herself there, smearing your " + player.face() + " with a mixture of cum and vaginal wetness.  ", false);
				if (kGAMECLASS.forest.tamaniScene.pregnancy.isPregnant) {
					outputText("She rubs her pregnancy swollen belly", false);
				}
				else outputText("She fondles her nipples", false);
				outputText(" and moans as she grinds against you, \"<i>Ahh, you're going to have so many more daughters!  You realize if you keep cumming into them like this, I'll never be able to restrain them all.  So if you don't want to be gang-raped by your daughters like this you should probably stop orgasming, ok?  Just don't cream any more dripping virginal cunts.</i>\"\n\n", false);
			}
			//Else:  
			else {
				outputText("The first daughter to take your seed climbs onto your face and plants herself there, smearing your " + player.face() + " with a mixture of cum and vaginal wetness.  She pinches her budding chest and grinds on top of you, asking, \"<i>You realize I'm going to be pregnant don't you?  I can already feel your little swimmers tickling all my eggs.  Can you imagine what I'll look like in a few days?  With bigger tits leaking milk and my belly stuffed with offspring?  Just let your dick do the thinking and keep cumming until we're all stuffed, ok?  Don't hold back now, we're just aching for more!</i>\"\n\n", false);
			}

			outputText("The perverse thoughts get to you, worming their way inside you until they reach your " + player.cockDescript(primary) + ".  It clenches and explodes, packing the slut's womb with cream.  She's lifted off by her sisters, and your next blast fires into the air, splattering over the assembled goblins with a wet plop.  Many gather it up, licking and slurping it, or shoveling it directly into their waiting cunts.  Another pussy is placed on you, and the sensation of new flesh taking you makes the contraction feel even longer.  She staggers off a few moments later, looking pregnant already.  The cycle repeats until", false);
			if (daughters < 20) outputText(" the majority ", false);
			else outputText(" half ", false);
			outputText("of the girls have spooge-slicked cunts and big grins.\n\n", false);

			outputText("As your ", false);
			if (player.balls > 0) outputText(player.ballsDescriptLight() + " empty", false);
			else outputText("prostate empties", false);
			outputText(", one of the girls wanders over and asks, \"<i>How does it feel knowing your daughter is pregnant with even more children? Does it turn you on, <b>Daddy</b>?</i>\"\n\n", false);

			//(Go to end unless daughters > 20)
			if (daughters > 20) {
				outputText("You lie there, feeling like an empty husk.  The crowd starts to disperse", false);
				if (tamaniPresent) outputText(" while Tamani walks away", false);
				outputText(", but a few of the little sluts don't look satisfied yet.  They crowd around.  One straddles your chest and begins dancing in an erotic display.  Somehow, your " + player.cockDescript(primary) + " still manages to twitch weakly in response.  Another goblin opens a satchel and pulls out some fruit and a canteen.  She delicately begins feeding you, clearing wanting you to regain your strength.  It seems they aren't finished with you yet.  You down what feels like gallons of water, and then find yourself presented with another flask of pink goo.  Shrugging, you gulp it down willingly, enjoying the sensation of your " + player.cockDescript(0) + " re-inflating to its maximum, turgid size.\n\n", false);
				
				outputText("Sighing happily, you lie there as the remainder of your daughters take you, fucking you one after another.  The whole time you don't stop eating, converting all of the girl's rations into gallons of baby batter.  Your daughters don't seem to mind, and take turns posing sexily and feeding you while they take turns riding your pole until they're bloating and pregnant.  By the time the last one rises up on shaky legs, you're exhausted and your eyes are drifting closed.  ", false);
				if (daughters < 50) outputText("Girlish giggles sooth you to sleep as the crowd slowly disperses.", false);
				else outputText("Girlish giggles sooth you to sleep as your body caves in to its fatigue.  The last thing you hear is the biggest daughter suggesting, \"<i>We should keep daddy around all the time...</i>\"", false);
			}
		}
		//(Normal end)
		if (daughters <= 20) {
			outputText("Exhausted and shaken by the ordeal, you lie there as the girls regroup, gathering any dripping seed into bottles or their puffy cunts.  Several of them blow you kisses", false);
			if (tamaniPresent) outputText(" and Tamani passionately frenches you.", false);
			else outputText(".", false);
			outputText("  One of them licks your sore member and says, \"<i>Thanks for all the cream!</i>\"\n\n", false);
		}
	}
	//[DOESNT FIT]
	else {
		outputText("You pick a random girl from the crowd, and the others crowd around, jealous of your chosen cock-sleeve.   Her cries of excitement rapidly turn to pain when you try to push in though.  She's just too small, even for a goblin.  You set her down, disappointed, but then she lies down in the grass and spreads her legs wide.  She says, \"<i>Since you're too big for us, how about we take turns lining up on the ground while some of us suck out your sticky goop?</i>\"\n\n", false);
		
		outputText("The idea sounds great to you.  Two of the horny sluts are already climbing forwards while their sisters lay out, pulling their vulva apart and toying with their tiny green clits.  They must be twins, because aside from their wildly different hair, their features are identical.  The paired cock-sluts both kiss your swollen " + player.cockHead() + ", then drag their lips and tongues over your length.  At first they're working in sync, but as their efforts intensify they slowly get out of rhythm, until they're each slobbering over a different part of your " + player.cockDescript(0) + ".\n\n", false);
		
		if (tamaniPresent) {
			outputText("Tamani steps up and reaches into a pouch.  As she withdraws her hand, you get your first glimpse of her cargo.  It appears to be a massive double-ended dildo, pink and floppy.  One end is shaped like a canine, with a huge knot, while the other ends in the flared tip of a horse-cock.  Tamani grunts as she spears herself with the pointed canine side, even forcing the massive dildo's knot inside.  She releases the dildo and the horse-half bobbles imposingly in front of her, dripping pink fluids.  She grins up at you saying, \"<i>If my daughters are going to claim all your cream, I'm going to make sure you don't hold back.  You saw the knot on this thing, didn't you?  Well, it's filled with aphrodisiacs, so when I cum and clamp down on it, you'll be forced to squirt every ounce of seed into my girls.</i>\"\n\n", false);
		
			outputText("She disappears behind you and you cringe, knowing this will probably be at least slightly uncomfortable.  ", false);
			if (player.tallness > 48) outputText("You can hear her climbing up on something behind you, in order to get to the right height.  ", false);
			outputText("Your expression of disdain is ruined when one of the sluts stretches wide and slurps your " + player.cockHead() + " into her mouth.  Her tongue feels like heaven as it slides over your tip, and her sister works the shaft, jerking the spit-lubed monster off with fast strokes.   Your enjoyment is interrupted by a sudden intrusion at your backdoor.  The rubbery flared horse-toy presses against your " + player.assholeDescript() + ", dribbling a little bit of its strange lubricants into your backdoor as Tamani pushes it forward.   Tiny hands grab your " + player.assDescript() + " as it's pushed forward, and you have no choice but to relax and allow it inside.\n\n", false);
			
			outputText("Half the head slips inside you, then the other, and in no time Tamani is slowly forcing it inside you.  It hurts just a little, enough to make your hips swivel forwards in a futile attempt at escape.  The goblin on your cock nearly chokes from the sudden change, though her sister gives you a wicked grin and strokes harder.  A flash of warmth squirts inside you in time with a moan from Tamani, and suddenly your body is exploding with pleasure.\n\n", false);
			
			outputText("Cum bubbles from the first goblin's nose as she falls off you, getting a massive facial in the process.  Her twin sister happily jacks you off, aiming your tool down at the row of cunts below you.  The sticky spooge splatters into their holes, painting their toned midriffs and ample thighs with sticky whiteness as you're used like some kind of fertility sprinkler. Tamani shoves her artificial dong further into your backdoor and somehow you manage to squeeze out a few more splattering drops of whiteness for her daughters.\n\n", false);
			
			outputText("Spent, your " + player.cockDescript(0) + " wilts, drooping downward as it drips the last of its seed.  Tamani seems oblivious to that fact though, and continues to violate you from behind.  You're about to reach around to dislodge the tiny anal rapist when another squirt of aphrodisiacs releases inside you, catching some of your prostate with the goop.  A torrent of blood rushes to your " + player.cockDescript(0) + " and you're suddenly achingly hard again.", false);
			if (player.balls > 0) outputText("  Your " + player.ballsDescriptLight() + " ache from the strain, but struggle to churn up more sperm.  ", false);
			outputText("A drop of pre-cum beads on the tip and you find yourself relaxing, letting Tamani slide her drug-slicked horse-cock the rest of the way into you.\n\n", false);
		}
		outputText("A third goblin suddenly attacks your taint, licking between your " + player.assholeDescript() + " and ", false);
		if (player.balls > 0) outputText(player.ballsDescriptLight(), false);
		else if (player.hasVagina()) outputText(player.vaginaDescript(0), false);
		else outputText("shaft", false);
		outputText(" as she presses her hard nipples up against your " + player.legs() + ". ", false);
		//(No Tamani:
		if (!tamaniPresent) outputText("She presses something against your backdoor and before you have a chance to react, something hot and wet is filling your " + player.assholeDescript() + ".  You look down as she pulls out a tube of pink residue, and sways with burning desire.\n\n", false);
		else outputText("The feeling of the ridges and flare of Tamani's fake cock as it slides inside you makes you sway on your feet, drunk with the lust its fluids have induced.   You sway back and forth with burning desire as both of the twins caress and stroke your meat, coaxing as much pleasure from it as possible.\n\n", false);
			
		outputText("You explode, coming harder than ever from the pressure and drugs buried against your prostate.  One of the twins, tired of waiting, pulls your " + player.cockDescript(0) + " over and shoves your tip against her slickened folds.  You manage to pump a thick blob of cum deep inside her before her sister snatches it away, grinding her own hungry twat against you until her entire groin is stained white.  They glare at each other, but after seemingly being sated, they return to fondling your " + player.cockDescript(0) + " together, using it like a hose to drench their smiling sisters with the remaining cum.\n\n", false);
		
		if (tamaniPresent) {
			outputText("Tamani pushes hard and screams behind you, \"<i>OH FUCK YES KNOCK THEIR LITTLE CUNTS UP!  Oooooohh...</i>\"\n\n", false);
			
			outputText("Her voice trails off into indecipherable gibberish as her orgasm takes her.  You can feel the horse-dick shaped dildo in your ass squirting its tainted fluids into you as Tamani's cunt clenches down on its other side.  Abruptly, the entire thing slides out, and you hear Tamani collapse in the grass.  You turn around as your cock responds to the drugs again, and note that she's totally out of it, mashing her tits with both hands and trembling with short involuntary muscle spasms.\n\n", false);
		}
		if (!tamaniPresent) outputText("You're handed another bottle as t", false);
		else outputText("T", false);
		outputText("he girls shift position, rearranging themselves so that those who got the most love-juice are now positioned alongside you.  ", false);
		if (!tamaniPresent) outputText("You shrug and drink it, ", false);
		else outputText("You begin ", false);
		outputText(" feeling hornier and hornier, as ready now as you were when you got here.  Twitching, your " + player.cockDescript(0) + " announces its readiness to repaint these living cum-sponges.  A trio of goblin tongues slip over your shaft, and lip-gloss smeared lips worship every ounce of your life-giving rod.  One of the girls, an older one with prominent breasts, breaks off and begins to scale her way up your body.  She doesn't stop until she's sitting on your shoulders with her hot messy cunt pressed against your face.\n\n", false);
		
		outputText("One of the girls on your " + player.cockDescript(0) + " gets an idea and mashes her tits against it you while she licks and strokes you.  The combined goblin assault once again achieves its goal, and you are brought to a body shaking orgasm AGAIN.   The swarm of goblins giggles happily as they gather your falling spunk into their waiting cunts.  What doesn't fit inside is slurped up, and soon you're covering a writhing orgy of curvy green women with a thick coat of spunk.\n\n", false);
		
		outputText("You finish and collapse backwards, totally drained and losing consciousness.  ", false);
		if (daughters < 20) {}
		//(20+ daughters:
		else if (daughters < 30) {
			outputText("A glass vial is slipped into your mouth as you lose consciousness, and you reflexively swallow.  You swear you could hear something about, \"<i>not done yet,</i>\" but you pass out.  Your dreams are far from restful, but full of pleasure.", false);
			dynStats("tou", -.5, "int", -.5);
		}
		//(30+ Daughters: 
		else {
			outputText("Vial after vial is pressed against your mouth as liquids are poured down your throat.  Your body reflexively swallows and the massive jump in arousal prevents you from totally passing out.  You can't remember much before you truly lose consciousness, but one thing that sticks in your mind is some of your daughters asking, \"<i>Why don't we just bring Daddy back to camp and then we can fuck him whenever we want?</i>\"\n\nYou passed out before you could hear the answer.", false);
			dynStats("tou", -.75, "int", -1, "lib", .5);
		}
	}
	player.orgasm();
	dynStats("lib", 1, "cor", 1);
	//Knock the bitches up, boost libido, corruption
	if (tamaniPresent) kGAMECLASS.forest.tamaniScene.tamaniKnockUp(); //If she wasn't pregnant she will be now
	knockUpDaughters();
	player.cumMultiplier += .3;
	if (getGame().inCombat) combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseFourHours);
}

//[Let them]
private function legTamanisDaughtersRAEPYou():void {
	spriteSelect(57);
	flags[kFLAGS.TIMES_FUCKED_TAMANIS_DAUGHTERS]++;
	var cocks:Number = player.totalCocks();
	var daughters:Number = int(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 2);
	//Find a dick that fits
	var primary:Number = player.cockThatFits(50);	
	
	clearOutput();
	outputText("Knowing full well that a ", false);
	if (daughters > 20) outputText("large ", false);
	outputText("crowd of goblins isn't going to let you leave while you still have a drop of sperm in your body, you disrobe and walk into their midst, lying down in a soft mossy patch and giving yourself up to the horde completely.  In an instant you're smothered in a sea of supple green flesh, and caressed from head to toe.  The largest of the group is happily stroking ", false);
	if (cocks > 1) outputText("one of ", false);
	outputText(" your " + player.multiCockDescriptLight() + ", teasing you as it near-instantly rises, \"<i>Mommy never told me you were such an easy " + player.mf("man-","") + "slut.</i>\"\n\n", false);
	
	outputText("A slippery gash mounts your " + player.face() + ", blocking your view of anything but a cute navel as pungent pussy slobbers over your lips.  With a resigned sigh, you open your mouth and bury your tongue into one of your many daughters' snatches.  It's tangy and sweet, and juicier than fresh fruit.   The girlish moans you hear let you know how successful your tongue is, and you work harder than ever to kiss and lick her slippery lips, pausing only to suck the tiny bud of her clit into your mouth.\n\n", false);
	
	outputText("Through it all the other girls stay busy, Tamani's eldest daughter gets most of your attention while she continues  to stroke you off.  She squeezes and caresses it until your member is trembling in her hand, ready to explode.\n\n", false);
	//(FORK BETWEEN TOO BIG AND FITS)
	//[FITS]
	if (primary >= 0) {
		outputText("Effortlessly, she straddles you and guides the entire length of your rod into her honeypot.  Amazingly the tiny girl is able to spread her cunt around you, forming a tight, but not uncomfortable, fit.  ", false);
		if (cocks == 2) outputText("Another set of hands latches on to your free dick and forces herself down on top it, sitting back to back with the other lucky slut as she takes it to the hilt.  Somehow you know that if you could see beyond the tight body smothering your face, watching your daughters fuck together would push you over the edge.", false);
		else if (cocks > 2) outputText("More and more hands latch onto the rest of your " + player.multiCockDescriptLight() + ", guiding each of them into a tight cunt-hole.   If you could see around the tight body of the slut on your face, you're sure the scene on your crotch would push you over the edge.", false);
		else outputText("You stiffen as a tongue suddenly presses against your " + player.assholeOrPussy() + " sliding inside and intensifying the feelings radiating down your fuck-pole until you're unable to hold on.", false);
		outputText("\n\n", false);
		
		outputText("A sudden flow of fluids soaks your " + player.face() + " and dribbles from your chin.  The face-riding goblin bucks like a bronco, nearly breaking your nose before the strength drains from her body and she slides off into the dirt, panting weakly.   Confronted with the sight of ", false);
		if (cocks > 2) outputText("so many girls impaled on your flesh", false);
		else if (cocks == 2) outputText("your daughters' whorish expressions of pleasure", false);
		else outputText("the sultry gaze of Tamani's oldest daughter as she rides your " + player.cockDescript(primary), false);
		outputText(", you can do nothing but cum.  ", false);
		if (cocks > 1) outputText("Twitching powerfully, your body unloads into the tight, fertile cum-receptacles, giving them exactly what they want.", false);
		else outputText("Twitching powerfully, your body unloads into the tight, fertile cum-receptacle, giving her exactly what she wants.", false);
		if (player.cumQ() >= 1000) {
			outputText("  The near-supernatural amount of spooge you produce easily bloats ", false);
			if (cocks == 1) outputText("her belly until she looks a little pregnant", false);
			else outputText("each of their uteruses until they look a little pregnant", false);
			outputText(".", false);
		}
		if (cocks == 1) outputText("  She rises up off of your wilting member, blowing you a kiss and saying, \"<i>I think you got me pregnant Daddy!</i>\"\n\n", false);
		else outputText("  They rise up off your wilting members.  The eldest daughter blows you a kiss and says, \"<i>I think you got us pregnant Daddy!</i>\"\n\n", false);
		
		//TAMANI IS THERE: 
		if (tamaniPresent) {
			outputText("Tamani shoves the cum-filled girls out of her way and looks down at you with an expression of disdain, \"<i>I swear honey, the way you act, I think your dick is already a slave to goblin-twat.</i>\"\n\n", false);
			
			outputText("She gives ", false);
			if (cocks > 1) outputText("one of ", false);
			outputText("your deflating " + player.multiCockDescriptLight() + " a playful slap, smirking when it stiffens in response, \"<i>Honestly, you're so shameful, getting hard again from such an innocent touch.  I didn't know you wanted to make our little family that much bigger.</i>\"\n\n", false);
			
			outputText("Pantomiming a sigh, Tamani drags her finger from your ", false);
			if (!player.hasSheath()) outputText("base", false);
			else outputText("sheath", false);
			outputText(" to the tip, giggling with mirth as her words and touches bring you to full readiness.\n\n", false);
			
			outputText("\"<i>Well, I wouldn't be a very nice wife if I didn't let you empty your stress into my hungry cunny from time to time would I?  Here, drink this, it'll make sure we have lots of daughters,</i>\" says the goblin, shoving a flask into your hand.  You nod, made agreeable by constant touches and strokes the goblin lavishes upon your groin.  The drink goes down smoothly, disappearing into you with a few quick sips from the colored glass bottle.  It settles into your belly, radiating pleasant warmth that seeps down to your crotch while it fills your mind with fuzz.\n\n", false);
			
			outputText("Tamani massages your ", false);
			if (player.biggestTitSize() < 1) outputText("chest", false);
			else outputText(player.allBreastsDescript(), false);
			outputText(" as she mounts you, ", false);
			outputText("squeezing her dripping wet cunt around your " + player.cockDescript(primary) + ".  She explains, caressing your cheek as you start to drool, \"<i>You see, " + player.short + ", this potion is a special one.  You can probably feel it now, emptying your mind and shutting down your thought processes.  That's what it's supposed to do.  You won't remember anything when I'm done either, aside from how great my pussy feels on your " + player.cockDescript(primary) + "</i>.\"\n\n", false);
			
			outputText("You drool, accepting the truth.  She's so right, there's no way you'd ever forget the feeling of hot wetness as it rubs around your shaft.  Tamani keeps talking, confidently riding you as your mind soaks up her instructions, \"<i>My hot little cunt needs filling, and your cock knows it.  It wants it.</i>\"  She leans back, allowing you a glimpse of pinkness and sticky female juices while she teases her button, \"<i>Just the sight of my pussy gets you hard and ready.  The thought of feeling that hot hole mounting you just diverts all your blood and willpower into your ready fuckstick.  You CAN'T resist my pussy.</i>\"\n\n", false);
			
			outputText("The words she's saying stop mattering.  All that matters is how much a slave your cock is to that tight little hole, and how great it feels to give yourself over it.  Your spunk-hungry wife never shuts up, and you just lie there, listening placidly, contentedly twitching against her as orgasm approaches.  A happy smile spreads over your face as you feel your ", false);
			if (player.balls > 0) outputText("balls", false);
			else outputText("groin", false);
			outputText(" churning with lust and desire, ready to give life to another batch of daughters for your mistress.  ", false);
			if (flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] < 10) outputText("'Wait... wife... mistress?' your mind wonders, rejecting the foreign thoughts.  You look up at Tamani, confused for a moment", false);
			else outputText("Yes, that sounds so right – Tamani is your wife, and it's your husbandly duty to keep her pregnant.  You dwell on that for a moment", false);
			outputText(", until an orgasm wracks your body and derails your train of thought, drowning it in a sea of pleasure.\n\n", false);
			
			outputText("She wriggles and moans as your internal muscles clench, pumping thick spurts into the goblin's womb.  A new-found sense of satisfaction and pleasure spreads through you.  It feels so good to knock Tamani up that your orgasm drags on forever, until you feel empty and exhausted.   Looking back, you realize just how much more pleasurable her box is in comparison to the other holes you've tasting in your travels, even her daughter's.  As Tamani rises up off of you, dripping with cum, the memories of everything but the sex slowly slip away, leaving behind happiness and anticipation of your next chance to fill her.\n\n", false);
			
			outputText("Your mistress steps away, swaying her more-than ample hips from side to side as she saunters past the throng of still-hungry goblins.  You shake your head, feeling a little out of sorts, but before you get a chance to puzzle it out, ", false);
			if (daughters < 20) outputText("the small pack of goblins is upon you, forcing liquids down your throat and making you fill cunt after cunt with sticky seed.", false);
			else if (daughters < 30) outputText("the pack of goblin daughters is upon you, forcing potent aphrodisiacs down your throat as you're raped for hours, forced to pack cunt after cunt full of jism.", false);
			else outputText("the massive group of goblins is on top of you, drugging and raping you over and over until you've had dozens of orgasms and licked off nearly as many cream-bloated sluts.", false);
			outputText("  As you lie there, drugged and drained, your daughters form up in a line and kiss you, one after another, each whispering pleasantries like, \"<i>Thanks dad,</i>\" or \"<i>Yummy cum daddy,</i>\" before flouncing off, sloshing into the woods.", false);
			//increase hypno value
			flags[kFLAGS.TAMANI_TIMES_HYPNOTISED]++;
			//preggo up tamani
			kGAMECLASS.forest.tamaniScene.tamaniKnockUp();
		}
		//NO TAMANI:  
		else {
			//(SMALL PACK)
			if (daughters < 20) {
				outputText("The smaller girls take turns, mounting your cum-soaked rod one after another, using their hungry cunts like cum-sponges until your " + player.cockDescript(primary) + " is polished with feminine fluids and cleaned of any residual jism.  After so many repeated mountings, you're hard and ready to cum again, and the horny sluts know it.   You're crammed back into each one of them, one after another in a barrage of quick fucks.  Each girl is only given a few seconds on your rod before she's pulled off by her peers and replaced by another ecstatic goblin.  While waiting for their next turn, the spare girls tease you, tweaking your " + player.nippleDescript(0) + "s while licking your ears and whispering, \"<i>Don't cum for her, it'll be much better in my hot little box,</i>\" or, \"<i>You won't cum for that skank, will you?  Save your baby-batter for me!</i>\"\n\n", false);
				
				outputText("Amazingly, you orgasm again.  An orgiastic squeal erupts from your " + player.cockDescript(primary) + "'s current owner, breaking off into pants and gasps ", false);
				if (player.cumQ() < 100) outputText("as you twitch underneath her, emptying the last of your cum inside her.", false);
				else if (player.cumQ() < 500) outputText("as you twitch underneath her, pumping her full of cum, thoroughly seeding her womb with spunk.", false);
				else outputText("as you twitch underneath her in powerful spasms, blasting huge gouts of cum into her waiting body until her belly is bloated with seed and it begins to squirt out around you in time with each eruption of spunk.", false);
				outputText("  Disappointed moans rise up from the others as they realize they've lost the cum-lottery.   The winner, patting her belly happily, stands up, filling the air with a loud 'slurrrrrp' as her twat noisily releases your " + player.cockDescript(primary) + ".", false);
				if (player.cumQ() >= 500) outputText("  A few enterprising goblins gather around, gathering up the loose spunk and shoveling it into their holes.", false);
				outputText("\n\n", false);
				
				outputText("Tired from the sexual acrobatics, your daughters gather up their possessions and begin dispersing, but a few stick around to lick your " + player.cockDescript(primary) + " clean and give you deep french-kisses.  Exhausted as well, you begin to doze off, but not before a girlish voice whispers in your ear, \"<i>Thanks daddy!  I'll bring your daughters back once they've grown up so you can have their cherries too.</i>\"\n\n", false);
			}
			//(MEDIUM PACK (or bigger))
			else {
				outputText("The smaller girls take turns, mounting your cum-soaked rod one after another, using their hungry cunts like cum-sponges until your " + player.cockDescript(primary) + " is polished with feminine fluids and cleaned of any residual jism.  After so many repeated mountings, you're hard and ready to cum again, and the horny sluts know it.   You're crammed back into each one of them, one after another in a barrage of quick fucks.  Each girl is only given a few seconds on your rod before she's pulled off by her peers and replaced by another ecstatic goblin.  While waiting for their next turn, the spare girls tease you, tweaking your " + player.nippleDescript(0) + "s while licking your ears and whispering, \"<i>Don't cum for her, it'll be much better in my hot little box,</i>\" or, \"<i>You won't cum for that skank, will you?  Save your babby-batter for me!</i>\"\n\n", false);
				
				outputText("Amazingly, you orgasm again.  An orgiastic squeal erupts from your " + player.cockDescript(0) + "'s current owner, breaking off into pants and gasps ", false);
				if (player.cumQ() < 100) outputText("as you twitch underneath her, emptying the last of your cum inside her.", false);
				else if (player.cumQ() < 500) outputText("as you twitch underneath her, pumping her full of cum, thoroughly seeding her womb with spunk.", false);
				else outputText("as you twitch underneath her in powerful spasms, blasting huge gouts of cum into her waiting body until her belly is bloated with seed and it begins to squirt out around you in time with each eruption of spunk.", false);
				outputText("  Disappointed moans rise up from the others as they realize they've lost the cum-lottery.   The winner, patting her belly happily, stands up, filling the air with a loud 'slurrrrrp' as her twat noisily releases your " + player.cockDescript(primary) + ".", false);
				if (player.cumQ() >= 500) outputText("A few enterprising goblins gather around, gathering up the loose spunk and shoveling it into their holes.", false);
				outputText("\n\n", false);
				
				outputText("You're exhausted from the sexual battering you've had to endure, but the giggling swarm won't let you rest.  Tiny hands pry open your jaws and force a bubbling concoction past your lips.  Another one massages your throat and you're forced to swallow the stuff.   The drug's effects are strong and immediate.  Your ", false);
				if (player.balls > 0) outputText("balls begin swelling, trembling as they visibly inflate, preparing a massive load of seed.", false);
				else outputText("groin shifts uncomfortably, trembling as it begins preparing a massive load of seed.", false);
				outputText("  Your " + player.multiCockDescriptLight() + " spasms, twitching as unearned pleasures fill the flesh and bring you to climax.\n\n", false);
				
				outputText("You grunt, squirting a long rope of the stuff that splatters onto your belly.  A palpable sense of relief comes with it, though the mystery drug they've fed you immediately turns that relief back into uncomfortable fullness.  Your hips twitch and try to launch the next load, but it's intercepted by a pierced goblin-twat that slides down on top of you.  The goblin pinches her nipples and coos happily as you send squirt after squirt into her, until she's cumming loudly and her over-full twat is squirting out each time you try to pack more in.\n\n", false);
				
				outputText("The filled goblin is pulled off by her sisters, and through your haze of artificially-induced pleasure she looks completely insensate.  Her mouth is drooling, her eyes are rolled back, and her entire body is twitching in the arms of her sisters as they lay her in the grass to recover.   Despite being exposed to the air, you're still cumming hard, and a few more ropes of cum spatter your neck and chest with goo before the next daughter climbs aboard.\n\n", false); 

				outputText("This goblin is riding you reverse cowgirl, grinding up and down, peeking over her shoulder to give you seductive smiles as she's fully fertilized.  Her thighs quiver and her vaginal muscles squirm around you, contracting and squeezing until it gets hard to push any more jizz inside her.  With a self-satisfied smile, she rises up off of you and helps the next of her sisters into place.\n\n", false);
				
				if (daughters < 40) {
					outputText("Locked in a ceaseless orgasm, you're raped by one goblin after another.  A parade of tight pink pussies and their green-skinned owners passes by you, and once each of them is dripping with white seed, they take the time for a second pass.  By the time it's over, you're raw and sore, and your ", false);
					if (player.balls > 0) outputText(player.ballsDescriptLight() + " hurt", false);
					else outputText("crotch hurts", false);
					outputText(" from having to generate such a ridiculous quantity of spooge.  The crowd of milling goblins seems much less frantic now that they've gotten what they want.  You're kissed and licked and massaged by the thankful mass, and you lose yourself to unconsciousness, still dribbling semen.", false);
				}
				//(LARGE PACK – as above minus last PG)
				else {
					outputText("Locked in a ceaseless orgasm, you're raped by one goblin after another.  A parade of tight pink pussies and their green-skinned owners passes by you, and once each of them is dripping with white seed, they take the time for a second pass.  You're raw, sore, and losing consciousness, but the huge mass of young goblins is far from done with you.  They force another potion into your throat as you lose consciousness.   Your dreams are filled with demented orgies where your dick is kept in one tight hole after another, a cruel reflection of reality.  When you awake they're gone and you're incredibly sore, but somehow still horny.  Getting dosed with so many goblin drugs in such a short time-span might not have been a good idea.", false);
					//libido/cumq/corruption booster?
					dynStats("lib", 1, "cor", .5);
					player.cumMultiplier += .3;
				}
			}
		}
	}
	//[NO FIT]
	else {
		//	[No Tamani]
		if (!tamaniPresent) {
			outputText("Effortlessly, Tamani's daughter launches herself onto you, straddling your body as she tries to work your " + player.cockDescript(0) + " into her tight gash.  No matter how hard she tries, she just can't get it in.  She looks up at you in confusion and asks, \"<i>How in Marae's cunt can my Mom take this beast?</i>\"\n\n", false);
			
			outputText("Frowning in consternation, she presses it down onto your belly and sits on top, spreading her cunt as wide as she can around the bulge your urethra makes on the underside of your " + player.cockDescript(0) + ".  Though you can't see her, the feeling of her starting to slide along your length is wonderfully pleasurable.  After a few moments you can feel her getting into it, leaning over and pressing her taut body and heavy breasts against you as well.  Incredibly turned on by the mental picture you're forced to form, you attack the cunt riding your " + player.face() + ", licking it with feverish intensity.\n\n", false);
			
			outputText("A sudden flow of fluids soaks your " + player.face() + " and dribbles from your chin.  The face-riding goblin bucks like a bronco, nearly breaking your nose before the strength drains from her body and she slides off into the dirt, panting weakly.  Now freed from your juicy prison, you can see the oldest daughter as she's squeezing on your " + player.cockDescript(0) + ", sliding her gash and ", false);
			if (daughters < 20) outputText("pert ", false);
			else if (daughters > 40) outputText("heavy ", false); 
			outputText("breasts over every part of it.", false);
			if (cocks == 2) outputText("  Another one of the petite sluts climbs aboard your " + player.cockDescript(1) + ", squealing happily to her sister as she joins her in riding you.", false);
			if (cocks > 2) {
				outputText("  A third, wearing slutty pink make-up with platinum blonde hair, lays out across your ", false);
				if (cocks > 3) outputText("remaining " + player.multiCockDescriptLight(), false);
				else outputText(player.cockDescript(2), false);
				outputText(".", false);
			}
			outputText("\n\n", false);
			
			outputText("She pivots around, placing her drooling, wet gash against your " + player.cockHead() + " and begins vigorously jerking you off.   Her ass bounces hypnotically on your ", false);
			if (player.biggestTitSize() < 1) outputText("chest", false);
			else outputText(player.allBreastsDescript(), false);
			outputText(", sending a fresh surge of arousal through your " + player.multiCockDescriptLight() + ".   Another one of the girls leans down between your " + player.legs() + " licking your ", false);
			if (player.balls > 0) outputText("balls", false);
			else if (player.hasVagina()) outputText("pussy", false);
			else outputText("taint", false);
			outputText(", massaging your ", false);
			if (player.hasSheath()) outputText("sheath", false);
			else outputText("crotch", false);
			outputText(", and the sensitive " + player.skinDesc + " around your crotch.   The busty girl on your " + player.cockDescript(0) + " teases, \"<i>Go ahead and let it out " + player.mf("stud","sexy") + ".  I'm tired of getting your cream second-hand, so squirt it right into my hot little cunt.</i>\"\n\n", false);
			
			if (cocks == 2) outputText("Her sister agrees, \"<i>Yeah, I want to feel the hot cum squirting into my cunt.  Fill me full of so many babies that you make Mom jealous!</i>\"\n\n", false);
			else if (cocks > 2) outputText("Her sisters agree, \"<i>Yeah, we want to feel the hot cum squirting into our cunts!  Fill us up with so many babies that Mom gets jealous!</i>\"\n\n", false);
	
			outputText("Your body caves into their demands.  The girl between your " + player.legs() + " licks hard as your muscles tense with orgasm.  ", false);
			//Single cock jizz scene
			if (cocks == 1) {
				outputText("The daughter giggles and squeals as bulges of cum squeeze up your urethra, visibly shifting her tight body before squirting inside with wet, fluid noises.  Sloshing squishing noises fill the air as you submit to your jizz-devouring pack of daughters, feeding their insatiable need for sperm.  Pleasure rocks you as ", false);
				//Cum stuff
				if (player.cumQ() < 100) outputText("your orgasm ends, pulsing weakly inside the sloppy goblin flesh.", false);
				else if (player.cumQ() < 500) outputText("your orgasm drags on, pumping the slut up until she looks slightly pregnant.", false);
				else {
					outputText("your orgasm drags on, splattering cum everywhere as you plump up the girl until she looks pregnant.", false);
					if (player.cumQ() > 1000) outputText("  Seed gushes out her opening, actually pushing the goblin away as your orgasm splatters cum into the grass.", false);
					if (player.cumQ() > 5000) outputText("  The other goblins frolic around in the stuff, greedily shoveling it into their dripping pussies with both hands as you form a small lake of seed.", false);
				}
			}
			//Multi jizz scene
			else {
				outputText("The daughters giggle and squeal as bulges of cum squeeze up your urethras, visibly shifting their tight bodies before squirting inside with wet, fluid noises.  Sloshing squishing noises fill the air as you submit to your jizz-devouring pack of daughters, feeding their insatiable need for sperm.  Pleasure rocks you as ", false);
				//Orgazmo
				if (player.cumQ() < 100) outputText("your orgasm ends, pulsing weakly inside the sloppy goblin flesh.", false);
				else if (player.cumQ() < 500) outputText("your orgasm drags on, pumping the sluts up till they look slightly pregnant.", false);
				else {
					outputText("your orgasm drags on, splattering cum everywhere as you plump up the girls until they look pregnant.", false);
					if (player.cumQ() > 1000) outputText("  Seed gushes out their openings, actually pushing the goblins away as your orgasm splatters cum into the grass.", false);
					if (player.cumQ() > 5000) outputText("  The other goblins frolic around in the stuff, greedily shoveling it into their dripping pussies with both hands as you form a small lake of seed.", false);
				}
			}
			outputText("\n\n", false);
	
			outputText("Spent, you lie in the dirt, twitching weakly with an exhausted grin on your face.  A goblin with a long pierced tongue kneels next to your face and gives you a long kiss, twisting her tongue around your own.  Her spit tastes almost sweet to you, and the passionate tongue-fuck has you getting hard again even as you're running out of breath.  She breaks it off, and as you gasp for air, she forces a pill into your mouth.  Knowing they'll make you swallow it one way or another, you sigh and ingest the foreign drug.  Your tongue-twisting partner licks her shiny, cock-sucking lips and says, \"<i>Mom always did say you were an eager fuck.  I even stole that pill from her – it should make you cum enough to stuff every single one of us!  I can't wait to catch the first blast in my tight little snatch!</i>\"\n\n", false);
			
			if (cocks == 1) outputText("Y", false);
			else outputText("Each of y", false);
			outputText("our " + player.multiCockDescriptLight() + " is now rock solid and beading pre-cum at the tip.  ", false);
			//(single)
			if (cocks == 1) outputText("The purple-lipped cock-slut grabs your " + player.cockDescript(0) + " and makes a show of smearing the slippery fluid over your shaft, lubricating it as she jacks you off.  Her warm lips form a tight seal on your " + player.cockHead() + " as the young goblin begins lapping at your pre-cum as she sucks it from your urethra.   It feels heavenly, and your " + player.hipDescript() + " pump weakly into the air in an instinctive bid to enhance the sensation.", false);
			//(multiple)
			else {
				outputText("The purple-lipped cock-slut grabs hold of one of your " + player.multiCockDescriptLight() + " and makes a show of smearing the slippering fluid over the shaft, lubricating it as she begins to jack you off.  Her sisters, taking the cue, step over the other sated sluts and grab hold of your " + player.cockDescript(1) + ", fondling it lovingly.  ", false);
				if (cocks > 2) outputText("They spread out until every one of your " + player.multiCockDescriptLight() + " has at least one goblin hanging off it, stroking and touching you.  ", false);
				outputText("It feels heavenly, and your " + player.hipDescript() + " pump weakly into the air in an instinctive bid to enhance the sensation.", false);
			}
			outputText("\n\n", false);
			
			outputText("The goblin who served between the legs crawls back into position, and you realize she must be the youngest, and therefore the lowest on the goblin totem-pole.  Her eager tongue is just as skilled as it was minutes ago, and between her attentions and the tongues on your " + player.multiCockDescriptLight() + ", you're leaking streamers of liquid lust.  Hands run over your ", false);
			if (player.biggestTitSize() < 1) outputText("chest", false);
			else outputText(player.allBreastsDescript(), false);
			outputText(", circling your nipples and massaging your chest while a girlish voice whispers in your ear, \"<i>Cum for us now daddy, we've gotten so wet having to wait on you...</i>\"\n\n", false);
			
			outputText("Ripples of convulsive pleasure wrack your midsection as you feel the muscular contractions of your orgasm threatening to tear you apart.   Your ", false);
			//(single)
			if (cocks == 1) outputText(player.cockDescript(0) + " blasts a wave of seed directly into your cock-obsessed daughter's mouth, flooding it until she falls off of it with jism dripping from her nostrils.  You squirt a massive spurt high into the air overhead, and more than a few goblins are running around with their tongues out, trying to catch it in their mouths.   Each wave of seed is larger than the last, erupting from your " + player.cockDescript(0) + " like a geyser.   Soon everyone is spattered in a layer of the stuff, and your gut-clenching orgasm tapers down to a more reasonable, but constant, slow flow of semen.  Each of your daughters comes up and takes turns angling your shaft into her waiting cunt, allowing the thick fluid to fill her to capacity before waddling off.  Then the next girl does the same, and the next, and the next...", false);
			//(Multi)
			else outputText(player.multiCockDescriptLight() + " blast waves of seed directly into your cock-obsessed daughters' mouths, flooding them until they fall off with jism dripping from their nostrils.   You spurt massive loads high into the air overhead, and more than a few goblins are running around with their tongues out, trying to catch the seed in their mouths.  Each wave is larger than the last, erupting from your " + player.multiCockDescriptLight() + " like a geyser.  Soon everyone is covered in a thick coating of the stuff, and your gut-clenching orgasm tapers down to a more reasonable, but constant, slow flow of semen.  Each of your daughters comes up and guides a shaft into her waiting cunt, filling herself to capacity with the thick fluid before waddling off.   Then the next set of girls does the same, and the next, and the next....", false);
			outputText("You're done in by the effort, and quickly lose consciousness.", false);
		}
		//[Tamani is There]
		else {
			outputText("A scuffle in the crowd breaks out to your right, and though you can hear it, the jiggling ass and delicious pussy of the goblin slut on your face makes it impossible to see what's going on.  You do what any horny " + player.mf("male","herm") + " would do in your position – groan into the slippery box and ignore it, focusing on the feel of skilled hands fondling ", false);
			if (cocks > 1) outputText("each of ", false);
			outputText("your " + player.multiCockDescriptLight() + ".\n\n", false);
			
			outputText("High pitched voices rise in pleading tones, followed by the impact of flesh on flesh.  A sultry, familiar voice clears her throat and asks, \"<i>Oh, so this is where you've been.  Tamani would've expected her husband to be in his proper place – lodged deep between her legs, rather than rewarding his ditzy daughters' misbehavior.</i>\"\n\n", false);
			
 			outputText("You sigh into the fragrant pussy, the warm air-flow turning the slippery box a dripping fountain of orgasm.   The walls clamp around your tongue, squeezing it from base to tip in a milking motion you've become intimately acquainted with.   A high pitched shriek of pleasure rises, then cuts off.  You blink away a sudden burst of light as the orgasming girl is ripped from your questing tongue, revealing the crowd of sultry bodies and Tamani's knowing smirk.\n\n", false);
			
			outputText("\"<i>Mother always said you had to keep your men on a tight leash, and boy was she ever right – you've been cheating on Tamani!  With your own daughters!</i>\" exclaims your ", false);
			if (flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] >= 10) outputText("wife",false);
			else outputText("\"wife\"", false);
			outputText(" in mock indignation.   She taps her chin for a moment, ignoring her daughters as they continue to lick and stroke ", false);
			if (cocks) outputText("each of ", false);
			outputText("your " + player.multiCockDescriptLight() + ".  Your eyes roll back in blissful pleasure as Tamani declares, \"<i>Tamani will take care of you, husband.  You're going to cum into these girls' hungry twats until they have to waddle home, and then you're going to remember why Tamani's cunt owns your " + Appearance.cockNoun(CockTypesEnum.HUMAN) + ", forever.</i>\"\n\n", false);
			
			outputText("Tamani pulls out a ring gag, shoves it into your protesting mouth, and pulls the straps securely around the back of your neck.  She tousles your " + player.hairDescript() + " as you squirm, but the crowd of goblins easily keeps you subdued, assisting their mother now that they know her plans.   You ", false);
			if (player.cor > 66) outputText("sigh, actually anticipating what's about to come", false);
			else if (player.cor > 33) outputText("don't resist, knowing there's no way to stop what's about to happen", false);
			else outputText("shudder, struggling to pull free", false);
			outputText(" as Tamani pulls out a half dozen vials and a handful of pills.  She drops the drug-filled capsules into your mouth, pouring in the potions, one at a time, to wash down her concoctions.\n\n", false);
			
			outputText("\"<i>Ok girls, line up; Daddy's gonna start squirting for you, so grab hold of that monster he's got and hold the tip against your horny little cunts until you're full.  And don't be greedy, once you've got a puss full of seed waddle on home, ", false);
			if (daughters < 20) outputText("there's other girls waiting", false);
			else if (daughters < 35) outputText("we've got a lot of girls to fill up", false);
			else outputText("there's a TON of you here so you'll need to move quick if you each want a turn", false);
			outputText(",</i>\" commands the goblin mother.\n\n", false);
			
			outputText("Her words are downright prophetic.  Churning, bubbling warmth floods your crotch with need as you look on, moaning.  Your back arches and your eyes cross in an involuntary reaction to your drug-induced orgasm.  Grunting, you twitch as the goblins line up, the eldest daughter grabbing home of your flexing " + player.cockDescript(0) + " as it begins to erupt.  Strangely, it isn't the pulsing, squirting orgasms you're used to.  Instead, a steady stream of cum washes out over the girl's abdomen as she lines up, eventually grinding her wet pussy against your straining urethra.  She giggles with lewd pleasure, grinding against your swollen " + player.cockHead() + " as her womb is pumped full of semen.  Her belly quickly rounds out, and she's forced to step away, leaving you to soak your belly while the next of your daughters gets in position.\n\n", false);
			
			//(MULTI)
			if (cocks > 2) {
				outputText("Meanwhile your other " + Appearance.cockNoun(CockTypesEnum.HUMAN) + "s are wasting their spunk over your belly, so some of the waiting girls grab them and pull them aside, ramming their tips deep inside their seemingly bottomless fuck-holes.  They giggle and run their manicured nails over your ", false);
				if (player.biggestTitSize() < 1) outputText("chest", false);
				else outputText(player.allBreastsDescript(), false);
				outputText(", circling your sensitive nipples", false);
				if (player.biggestLactation() >= 1) {
					outputText(" as they start to ", false);
					if (player.biggestLactation() < 2) outputText("leak", false);
					else if (player.biggestLactation() < 3) outputText("drip", false);
					else if (player.biggestLactation() < 5) outputText("spew", false);
					else outputText("fountain", false);
					outputText(" milk", false);
				}
				outputText(".  The perverse scene seems to feed you even more pleasure, and you feel your orgasm increase in intensity, thickening the flow of cum.\n\n", false);
			}
			//(SINGLE EXTRA)
			else if (cocks == 2) {
				outputText("Meanwhile your other " + Appearance.cockNoun(CockTypesEnum.HUMAN) + " is wasting its spunk over your belly, so one of the waiting girls grabs it and pulls it to the side, ramming its tip deep inside her seemingly bottomless fuck-hole.  She giggle and runs their manicured nails over your ", false);
				if (player.biggestTitSize() < 1) outputText("chest", false);
				else outputText(player.allBreastsDescript(), false);
				outputText(", circling your sensitive nipples", false);
				if (player.biggestLactation() >= 1) {
					outputText(" as they start to ", false);
					if (player.biggestLactation() < 2) outputText("leak", false);
					else if (player.biggestLactation() < 3) outputText("drip", false);
					else if (player.biggestLactation() < 5) outputText("spew", false);
					else outputText("fountain", false);
					outputText(" milk", false);
				}
				outputText(".  The perverse scene seems to feed you even more pleasure, and you feel your orgasm increase in intensity, thickening the flow of cum.\n\n", false);
			}
			
			outputText("The next slut grabs your " + player.cockHead() + " with both hands as she straddles you, pinching it tightly enough to make you wince.  The flow of white goo is pinched off, backing up painfully as she gets in position.  Just when you're about to cry, she's in position, and releases her too-tight grip.   Your body rewards the slut for her pain with a blast of seed so powerful it nearly blows her off your midsection, splattering out around her lips.  She holds on through an orgasm as you fill her depths with even more of your creamy load.  Surprisingly, she manages to take even more than her older sister, staying on until she looks a few months pregnant.  She staggers off, sloshing wetly while seed drips between her thighs.\n\n", false);

			outputText("While you continue to fertilize the slutty goblin girls, Tamani is nice enough to remove your gag.  Sadly, you're too drunk with pleasure and Tamani's chemicals to do anything but pant and drool, but it was a nice gesture.  ", false);
			//(SMALL CROWD: 
			if (daughters < 20) outputText("The crowd of girls takes their time since there's only around a dozen or so left to fill.  They ride you long and hard, getting their wombs packed full and making a mess while they do it.  Even after all of them has been filled, Tamani's potent chemicals keep you locked in orgasm, dripping unholy amounts of semen everywhere.  A few of the more daring of your offspring take turns sliding the tip into their tight assholes, allowing you to fill them completely as the drugs finally begin to wear off.\n\n", false);
			//(ALT MORE GIRLZ)
			else if (daughters < 35) outputText("The crowd of girls seems to take forever to get filled.  Every time one of them gets too into it, her mother pulls her back and guides the next willing hole into place.  In spite of the orderly procession, cum manages to get everywhere, soaking your torso and more than a few goblin thighs with a glaze of whiteness.  The whole time, you're kept in constant orgasm, though by the time you're filling the last girl with cum, the flow is slowing while the chemicals wear off.\n\n", false);
			//(ALT TOO MANY GIRLZ)
			else outputText("The massive crowd is forced to carefully ration your semen, bountiful though it is.   Tamani doesn't even let the girls get completely filled, instead forcing each of them to only get a few cunt-filling moments of your orgasm.  Those who've already had a turn hang around, scooping up the sperm-filled fluid that's leaking out and shoveling it into their baby-craving bodies.  The whole time you're kept locked in incredible climax.  If you had any capacity for reason you'd probably feel more like a tool than " + player.mf("man", "woman") + ", but the synapses of your brain are too busy firing off about how good it feels to think.  By the time the last girl gets her turn, your orgasm has trailed off to a weak flow, so she stays on until the drugs finally wear off.\n\n", false);
			
			outputText("The soon-to-be-pregnant goblins stagger off, a bit bow-legged and generously glazed with semen.  You come down from your high, panting weakly and trembling.  Tamani wraps her arms around your head, cradling you deep into her incredible bust.  The soft skin completely envelops you in breast-flesh as her sweet, fruity scent fills your lungs with every breath.  ", false);
			if (flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] > 10) outputText("She's the best wife ever.  You nuzzle deep into her cleavage, sighing happily.", false);
			else if (flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] > 5) outputText("She really is a great wife... wait, wife? You shrug away the thought and enjoy slowly motorboating her breasts.", false);
			else outputText("She really isn't that bad to you, is she?  You sigh and nuzzle against her jiggly love-pillows.", false);
			outputText("  Eventually she pulls you back and kisses you on the lips.\n\n", false);
			
			outputText("Tamani offers you a canteen, and you readily accept it, thirsty after such a physics-shattering orgasm.  The water is cold and satisfying.  You gulp it down in record time, chugging and guzzling until the container empties.  Satisfied, you lie back down.  The pleasure is short-lived, short-circuited by the realization that the water you just drank had a tangy after-taste.  You try to glare at ", false);
			if (flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] > 10) outputText("your wife", false);
			else outputText("Tamani", false);
			outputText(" in anger, but your head feels all numb, and looking over at her makes the world spin dizzily.\n\n", false);
			
			outputText("Pink haze crowds away your thoughts as your glare melts away into dopey confusion.  Tamani giggles and says, \"<i>", false);
			//(Done before)
			if (flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] > 0) outputText("Don't you remember the last time we did this?  Of course not.</i>\"  Your hot goblin wife gestures at your suddenly swollen and erect " + player.cockDescript(0) + ", and continues, \"<i>Your dick remembers my special potion though.  Now, let's get back to teaching that wonderful cum-spout of yours how to behave around its wife and mistress.</i>\"\n\n", false);
			//(Not Done Before)
			else outputText("I mixed a special potion in that drink.   It shuts down all those pesky thoughts so you'll listen to your wonderful wife and let her tell you how to think and feel.</i>\"  She strokes your partially softened " + Appearance.cockNoun(CockTypesEnum.HUMAN) + ", giggling as it hardens for her, \"<i>You won't remember what Tamani tells you once it wears off, but your dick won't ever forget.</i>\"\n\n", false);
			
			outputText("Tamani slides her jiggling body overtop of you, placing her sopping wet pussy directly over-top of your " + player.cockDescript(0) + ".  The warm wet fluids of her desire slowly drip down onto you until your entire surface is coated in her clear feminine-drool and the entire area smells like her cunt.  She shivers and looks into your eyes, smiling at your mindless expression as she lectures, \"<i>Feel how hard your dick is?  That's because it smells my hungry, wet pussy.  It knows that it wants to cum for my pussy.  Your cock wants nothing more than to touch my cunt, worship it and bathe it with cum.</i>\"\n\n", false);

			outputText("She lets her pink-lipped entrance touch you at last, gliding it up and down your length.  You drool on yourself as she reaches your tip, leans back, and displays her glistening entrance to you as she talks, \"<i>This is what you want, what you need.   Just looking at it makes you hot and ready to fuck.  One glance and all your worries melt into arousal and desire to please your goblin wife.</i>\"\n\n", false);
			
			outputText("She's completely right.  You're past truly comprehending words, all you know is how hot your wife is making your cock and had bad it wants to cum in her.   Tamani smirks knowingly and begins sliding herself along the sensitive shaft again, slowly bringing you closer to an inevitable orgasm with her glorious vagina.  She leans over and whispers, \"<i>You'll be a good obedient husband and fuck your wife, won't you?  That's a husband's duty – to worship his wife's beautiful pussy, bathe it in semen, and be obedient in her presence.</i>\"\n\n", false);
			
			outputText("The words she's saying stop mattering.  All that matters is how much a slave your cock is to that wonderful, wet gash, and how great it feels to give yourself over to it.  Your spunk-hungry wife never shuts up, and you just lie there, listening placidly, contentedly twitching against her as orgasm approaches.  A happy smile spreads over your face as you feel your ", false);
			if (player.balls > 0) outputText("balls", false);
			else outputText("groin", false);
			outputText(" churning with lust and desire, ready to give life to another batch of daughters for your mistress.  ", false);
			if (flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] < 10) outputText("'Wait... wife... mistress?' your mind wonders, rejecting the foreign thoughts.  You look up at Tamani, confused for a moment", false);
			else outputText("Yes, that sounds so right – Tamani is your wife, and it's your husbandly duty to keep her pregnant.  You dwell on that for a moment", false);
			outputText(", until an orgasm wracks your body and derails your train of thought, drowning it in a sea of pleasure.  She moans and slides down, pressing her entrance against your urethra as your internal muscles clench, pumping thick spurts into the goblin's womb.  A new-found sense of satisfaction and pleasure spreads through you.  It feels so good to knock Tamani up that your orgasm drags on forever, until you feel empty and exhausted.   Looking back, you realize just how much more pleasurable her box is in comparison to the other holes you've tasting in your travels, even her daughter's.  As Tamani rises up off of you, dripping with cum, the memories of everything but the sex slowly slip away, leaving behind happiness and anticipation of your next chance to fill her.\n\n", false);

			outputText("Your mistress steps away, swaying her more-than ample hips from side to side as she saunters off.  You shake your head, feeling a little out of sorts, but before you get a chance to puzzle it out, the exhaustion of the encounter overwhelms you, blacking you out.", false);
			//knock up tamani chance
			kGAMECLASS.forest.tamaniScene.tamaniKnockUp();
			//increase hypno value
			flags[kFLAGS.TAMANI_TIMES_HYPNOTISED]++;
		}
	}
	//knock bitches up, slight libido gain, slight strength/toughness loss.
	player.orgasm();
	dynStats("str", -.5,"int", -.5, "lib", 1, "cor", 1);
	if (tamaniPresent) kGAMECLASS.forest.tamaniScene.tamaniKnockUp(); //If she wasn't pregnant she will be now
	knockUpDaughters();
	if (getGame().inCombat) combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseFourHours);
}

//[Lose Combat, Get Your Dick DRAINED]
private function tamaniDaughtersCombatLossDrain():void {
	spriteSelect(57);
	flags[kFLAGS.TIMES_FUCKED_TAMANIS_DAUGHTERS]++;
	clearOutput();
	
	//Vars
	var cocks:Number = player.totalCocks();
	var daughters:Number = int(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 2);

	outputText("Your efforts to resist were in vain – there's simply too many of your slutty daughters to fight off.  The crowd flows over your ", false);
	if (player.HP < 1) outputText("defeated", false);
	else outputText("lust weakened", false);
	outputText(" form, pulling you off your feet and carrying the whole of your body off.  ", false);
	if (player.lust >= player.maxLust()) {
		outputText("It doesn't bother you too much... they keep ", false);
		if (player.balls > 0) outputText("fondling your balls and ", false);
		outputText("stroking your shaft to keep you nice and excited, squirming helplessly with desire.", false);
	}
	else outputText("Your abused body slips in and out of consciousness, but the crowd applies salves as they travel to slowly invigorate your form.  Their hands keep touching and stroking you, and despite your mighty efforts to resist, you find yourself aroused and willing in short order.", false);
	outputText("\n\n", false);
	
	outputText("Perhaps an hour later, you're pulled into a cave.   Daylight fades away, replaced by the flickering light cast by a few torches and candles.  Your daughters are giggling and gossiping as they parade you through their subterranean lair, taking you ever-deeper.   An indeterminate amount of time later, you hear a door opening and are pulled through an entryway into what passes for a room.  You pant and moan as one of the tallest of Tamani's brood does her best to fellate ", false);
	if (cocks > 1) outputText("one of ", false);
	outputText("your " + player.multiCockDescriptLight() + ", keeping your more than turned on enough to go along with whatever they have planned.\n\n", false);
	
	//(regular lower body)
	if (!player.isTaur()) {
		outputText("The hands holding you slowly lower you into a comfortable feeling chair, securing your " + player.legs() + " into tightly bound stirrups.  A moment later, your hands are strapped into equally firm cuffs.  By this point, your lust-dulled mind has begun to worry, and you start to struggle, but binding leather straps are passed over your chest, midsection, and upper thighs, then tightened against the chair to completely restrain you.  Perhaps the only ", false);
		if (cocks > 1) outputText(" things not restrained are your " + player.multiCockDescriptLight() + ", standing at attention despite, or perhaps because of, your predicament.\n\n", false);
		else outputText(" thing not restrained is your " + player.multiCockDescriptLight() + ", standing at attention despite, or perhaps because of, your predicament.\n\n", false);
	}
	//(Shit taurs go!)
	else {
		outputText("The hands holding you slowly lower you down onto your back, guiding you into a combination chair and harness designed to accommodate a centuar's size and shape.  Before you know it, straps secure your " + player.legs() + " into tightly bound restraints.  A moment later your, hands are strapped into equally firm cuffs.  By this point, your lust-dulled mind has begun to worry, and you start to struggle, but binding leather straps are passed over your chest, midsection, and hindquarters, then tightened against the chair to completely restrain you.  Perhaps the only ", false);
		if (cocks > 1) outputText(" things not restrained are your " + player.multiCockDescriptLight() + ", standing at attention despite, or perhaps because of, your predicament.\n\n", false);
		else outputText(" thing not restrained is your " + player.multiCockDescriptLight() + ", standing at attention despite, or perhaps because of, your predicament.\n\n", false);
	}
	
	outputText("A goblin with lustrous blue hair pulls a lever on the side of the chair, shifting your position to further expose you.  She assures, ", false);
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00058] == 0) outputText("\"<i>Stop worrying.  I invented this while I was waiting on mom to bring me back more of your cum, just in case we ever got our hands on you.  I promise, after you've had a taste of my chair you'll never want to leave.</i>\"\n\n", false);
	else outputText("\"<i>Stop worrying!  We both know you love my little love-seat.  Just lie back and you'll be cumming too hard to care before long.</i>\"\n\n", false);
	
	
	outputText("You hear a commotion to the side and crane your head to watch.  There's a crowd of the girls clustered around a machine.   It's about the size of a large dresser or cabinet, only instead of holding clothes it's covered in knobs, levers, and various mechanical dials.  A goblin with light blue, almost silvery hair looks back at you and blows you a kiss while she pulls a lever.  A mechanical whirring noise fills the room, emanating from the ceiling.  You tilt your head back and look up, and see a massive metal bulb descending from the ceiling.\n\n", false);
	
	outputText("The goblin-made device is clearly sexual in nature.  Dozens of openings cover the bottom surface, and inside each one is a some kind of pink-lined hole, dripping with lubricants.  Most intriguing of all, you realize that the different holes all have different shapes, patterns, and sizes.  Some are huge, resembling something that would be at home between a monster's legs, and others are tiny, practically elf-like in appearance.   The bulb pauses just over your crotch, and a few snickering, green skanks guide " + player.sMultiCockDesc() + " into a perfectly sized hole.\n\n", false);
	
	outputText("You shiver as your manhood", false);
	if (cocks > 1) outputText("s are", false);
	else outputText(" is", false);
	outputText(" totally encapsulated within ");
	if (cocks == 1) outputText("a ");
	outputText("wet orifice", false);
	if (cocks > 1) outputText("s", false);
	outputText(".  They're so cold that you shiver involuntary against your restraints.  The blue-haired girl growls, \"<i>Hey bitch!  Crank the fuckin' machine up before you make Dad's dick", false);
	if (cocks > 1) outputText("s", false);
	outputText(" wilt!</i>\"\n\n", false);
	
	outputText("The machinery's humming gets louder as an unseen goblin does as she is told.  Noisy, wet suckling fills the room as the dozens of artificial mouths activate.  The wet, slimy substance encapsulating you immediately heats until it feels as warm as a maiden's love, and a gentle suction pulls on ", false);
	if (cocks > 1) outputText("each of ", false);
	outputText("your " + player.multiCockDescriptLight() + " until it feels much harder and thicker than normal.  You stifle an involuntary groan, but fail to conceal your lust-filled pants from your audience.   A daring girl leaps onto your ", false);
	if (player.biggestTitSize() < 1) outputText("chest", false);
	else outputText(player.allBreastsDescript(), false);
	outputText(" and shoves a lactating nipple into your mouth, commanding, \"<i>Drink up, the more fluid you have the more baby batter you can cook up for us!</i>\"\n\n", false);
	
	outputText("Unable to fight back in any way, you shrug and begin suckling the purplish nipple, tasting the creamy goblin milk as it easily fills your mouth.  You gulp it down, slowly relaxing between the mechanized cock-sucking and gentle breast-feeding.  Your daughter was right, it's almost like paradise. Unfortunately, the pleasure is interrupted by something probing at your backside.  Unable to look with your mouth full of delicious tit, you can only gurgle and dribble in protest as a lubricated tube is inserted into your " + player.assholeDescript() + ".\n\n", false);
	
	outputText("The familiar voice of the machine's inventor whispers, \"<i>", false);
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00058] == 0) outputText("Time for your medicine!  We need you to cum enough for each of us, and maybe have a little left over to play with, so suck up the medicine, okay?  Just relax and let it fill you so that you give us all that yummy cummy!</i>\"\n\n", false);
	else outputText("Relax Dad, we're just giving you your cummy medicine.  I know you're a sexy, virile " + player.mf("stud","slut") + "and all, but take your medicine and you'll have more than enough cum for us!</i>\"\n\n", false);
	
	outputText("You blush, ", false);
	//EXHIBITIONISTZ
	if (flags[kFLAGS.PC_FETISH] > 0) outputText("unimaginably turned on by being used and abused by such machinery in front of an audience of your own horny children.", false);
	else if (player.cor > 60) outputText("turned on by being milked in such an obscene way.", false);
	else outputText("horrified at the situation but unable to resist arousal as you're constantly sucked and pleasured.", false);
	outputText("\n\n", false);
	
	outputText("A trickle of warm fluid flows into you, and immediately your skin tingles, burning with heat and need.  ", false);
	if (player.balls > 0) outputText("Your balls tighten inside your sack and swell up like sponges, slowly increasing in size in time with your desire.", false);
	else outputText("Your body feels tight and needy, your gut clenching as your body adjusts to the drugs it's absorbing so readily through your " + player.assholeDescript() + ".", false);
	outputText("  The suckling pleasure around ", false);
	if (cocks > 1) outputText("each of ", false);
	outputText("your " + player.multiCockDescriptLight() + " seems to slowly increase as more of the drugs are absorbed by your body, until escaping the straps for your freedom is longer a concern.   Now all that matters is getting free so that you can fuck ");
	if (cocks == 1) outputText("that");
	else outputText("those");
	outputText(" mechanical hole", false);
	if (cocks > 1) outputText("s", false);
	outputText(" until you feel that wonderful, delicious release that you crave.\n\n", false);
	
	outputText("The goblins, upon seeing your change in demeanor, begin smiling to one another and congratulating each other on their hard work.  The girl at the console twists a few more levers and the warmth inside you seems to double as more drugs are forced into your captive frame.  You start " + player.mf("laughing","giggling") + ", the narcotics and pleasure overwhelming your thought processes, leaving you feeling like you're floating in heaven.  To anyone watching, you're panting and moaning in between the laughter, slobbering all over the milky goblin-tit in your mouth as your body begins squirting pre-cum into the cock-milker.\n\n", false);
	
	outputText("A few seconds away from your orgasm, the goblin running the machinery makes a few adjustments, and you feel the flow into your rectum growing stronger until you start to feel full and bloated.  Your body caves in to the pleasure, every inch of your skin tingling as you're forced to climax.  ", false);
	if (player.balls > 0) outputText("Straining and shaking, your " + player.ballsDescriptLight() + " clench against you, feeling tight as your body struggles to pump out the spooge they're producing.", false);
	else outputText("Straining and shaking , your body struggles through the orgasm as it tries to deal with all the cum your prostate and glands are putting out.", false);
	outputText("  The drugs and milking machines squish, suck, and whir noisily as you cum, flooding the tubes above the mechanical cunt-bulb with white.\n\n", false);
	
	outputText("The lactating green girl stops breast-feeding you and climbs off you, fed up that you're too busy moaning to properly suckle.  A few of the giggling goblins slap your face, laughing out loud when you fail to even register the blows.  The never-ending flow of orgasmic goop flooding out from ", false);
	if (cocks > 1) outputText("each of ", false);
	outputText("your " + player.multiCockDescriptLight() + " has your brain flooded with pleasure, blocking any other thoughts or feelings from arising from the swirling morass of fuck.\n\n", false);
	
	outputText("Another voice joins you in ecstatic moaning, echoing from the other side of the room.  The source is a curvy goblin with a hose rammed up her glistening snatch, buried to the hilt.  Her sisters are teasing her, opening and closing a valve on the machine, filling their sister up with short bursts of your copious cum.  She's moaning and fucking herself in desperation with the dildo-shaped tube-tip, but her brood-mates seem intent on staggering the flow of semen to prevent her from reaching orgasm.  It doesn't take more than a dozen seconds to fill her, and she's pulled off, crying and pouting about how she wasn't done.  The next girl steps in line, rams the juice-coated dispenser inside herself, and gets ready to become a mother...\n\n", false);
	
	outputText("Trapped in a constant orgasm by cruel machinery and a steady flow of specially tailored drugs, you start to smile uncontrollably.  True, you're utterly incapable of thinking by this point, but your body and mind are too pleased with the situation not to grin.  The situation in the corner of the scene repeats over and over as your daughters enjoy your 'milk'.  After they've had their fill they fall on each other, filling the room with orgiastic moans as any sense of order is blown away by a tide of female lust.\n\n", false);
	
	//// Chance of tamani saving you
	if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00058] < 4) {
		outputText("You lose consciousness a few hours into the ordeal, still cumming with no sign of stopping, your body sustained by the fluids pouring into your backside.  The dreams are a constant barrage of sexual situations, flitting between various incongruous orgasmic acts.  Were you capable of comprehending your situation, you probably wouldn't even want to wake up.  Alas, the pleasure does end, and you settle into a deeper slumber.  A gentle rocking and the exhaustion of your crotch keep you snoring soundly for hours.\n\n", false);
		
		outputText("When you do wake, you find yourself alone in a forest clearing, with a note taped to your face:\n\n", false);
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00058] == 0) {
			outputText("<i>   " + player.mf("Husband","Baby") + ",\n", false);
			outputText("      Do you have any idea how hard it is for Tamani to drag you out here all by herself?  If you weren't my favorite breeder, I would've let my daughters keep you.  Next time stand up to the little twats or Tamani might look the other way while you're being milked!\n\n", false);
			outputText("   Hugs & cums,\n", false);
			outputText("      -Tamani</i>", false);
		}
		else {
			outputText("<i>   Seriously, it isn't funny.  " + player.mf("Man","Toughen") + "-up and beat the little cunts silly instead of letting them force themselves on you.   Do you have any idea how hard it is to drag you out here?  If you weren't so much fun in the sack Tamani would be tempted to let her daughters keep you in their milker.   Maybe the girls would give Tamani a good cut of your production to join the operation?\n\n", false);
			outputText("   Fucks & Love,\n", false);
			outputText("      -Tamani</i>", false);
		}
		combat.cleanupAfterCombat();
	}
	//(ALT – BAD END GATEWAY)
	else {
		outputText("You lose consciousness a few hours into the ordeal, still cumming with no sign of stopping, your body sustained by the fluids pouring into your backside.  The dreams you have are a constant barrage of sexual situations, flitting between various incongruous orgasmic acts.  Were you capable of comprehending your situation, you probably wouldn't even want to wake up.  Thankfully, your unwished desires become reality.", false);
		//[NEXT]
		doNext(tamaniDaughtersBadEndChoice);
	}
	//Needz variable to track how many times PC has been 'chaired'
	flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00058]++;
	//moar daughters, increment 'times milked' by the daughters.
	knockUpDaughters();
	//boost cum production slightly.
	player.cumMultiplier += .3;
	//increase libido, slight corruption, minus stregth and speed.
	player.orgasm();
	dynStats("str", -.5,"int", -.5, "lib", 1, "cor", 1);
}

private function tamaniDaughtersBadEndChoice():void {
	spriteSelect(57);
	outputText("The next morning your unfocused eyes blink open, and you find yourself in the same situation as before.  Thankfully your orgasm has been allowed to end, though you still feel dopey and unfocused from whatever is flowing into you.  You manage to twist your head around to get a better look at the situation and discover a pair of IV's lodged in your arms.  Twisting your body, you realize you can still feel the drug-enema tube lodged in your " + player.assholeDescript() + ".  Oddly, it's hard to feel worried or concerned about the situation.\n\n", false);
	
	outputText("A goblin leans over your face and hugs her jiggling breasts against you as she gushes, \"<i>Thank you so much daddy!   You probably can't see with all the straps holding you down, but you got me and my sisters totally pregnant.  There's even enough of your spunk left over to knock us up a few more times!  We decided that even though we don't need you to cum right now, we'd let you keep coming forever.  Do you want that?</i>\"\n\n", false);
	
	if (player.statusEffectv1(StatusEffects.Exgartuan) == 1) outputText("Exgartuan barks, \"<i>Hell yes I do!</i>\" but the goblin only smirks down for a moment before looking back at you.\n\n", false);
	
	outputText("(Options: Yes, No, I'd rather fill your cunts individually & personally)", false);
	simpleChoices("Yes", tamaniDaughtersYesBadEndMePlease, "No", tamaniDaughtersDeclineBadEnd, "Individual", tamanisDaughtersFillIndividuallyBADEND, "", null, "", null);
}

//[Yes]
private function tamaniDaughtersYesBadEndMePlease():void {
	spriteSelect(57);
	clearOutput();
	outputText("\"<i>Wonderful!</i>\" cries the excited pregnant slut.   She gives you a quick peck on the cheek as she prances back over to the machine.  You brace yourself in anticipation, eager to lose yourself to an eternal orgasm.  A switch clicks, and a dial whirs as it's turned up to the maximum.  The fluids pumping into your backside and directly into your veins suddenly jump in pressure, stinging painfully for a moment before the pleasure returns.  Your eyes slowly roll back, your jaw goes slack, and your " + player.multiCockDescriptLight() + " spew", false);
	if (player.totalCocks() == 1) outputText("s", false);
	outputText(" cum into the tubes.\n\n", false);
	if (player.statusEffectv1(StatusEffects.Exgartuan) == 1) outputText("Exgartuan moans, \"<i>Ohhhhhh yeeeeaaaaahhhh...</i>\" before slipping into silence.\n\n", false);
	
	outputText("You spend the rest of your life trapped in orgasm, constantly feeding the growth of what becomes the biggest goblin tribe in all the land of Mareth.  Even when every single one of them is pregnant, they let you enjoy your reward.  Over time your capacity for memory, morals, or anything other feeling besides pleasure dwindles.  Trapped in a heaven of your own choosing, you gave up everything that you were for never-ending bliss.", false);
	getGame().gameOver();
}

//[NO]
private function tamaniDaughtersDeclineBadEnd():void {
	spriteSelect(57);
	clearOutput();
	outputText("\"<i>Seriously!?</i>\" exclaims the pregnant slut, \"<i>What kind of person wouldn't want to cum all the time?  Fuck, just the idea of it is making me drip!</i>\"\n\n", false);
	
	outputText("She sighs, \"<i>Whatever, Dad.  Next time we need you I'm sure you'll remember how much fun this was and come running home.</i>\"\n\n", false);
	
	outputText("The restraints pop off you at once, and you pull the tubes and IV's from your skin.  You grunt with discomfort and remove the final tube from your " + player.assholeDescript() + ".  Climbing off the table, your " + player.legs() + " wobble unsteadily as you try to get your balance.   The goblin says, \"<i>Go on home dad before I strap you back down and teach you to enjoy my gifts!</i>\"\n\n", false);
	
	outputText("You sheepishly leave the cave and head home, glad to be out of there before your growing tribe of daughters decides to milk you forever.\n\n", false);
	combat.cleanupAfterCombat();
}
//[Rather Fill Individually]
private function tamanisDaughtersFillIndividuallyBADEND():void {
	spriteSelect(57);
	clearOutput();
	outputText("\"<i>Really?</i>\" asks the pregnant goblin before she exclaims, \"<i>You do love us!  Oh Dad, once mom comes home will you fuck all of us?  I want to feel you make love to my drippy, pregnant pussy while she watches!</i>\"\n\n", false);
	
	outputText("You agree to do just that, ", false);
	if (player.cockTotal() > 1) outputText("each of ", false);
	outputText("your " + player.multiCockDescriptLight() + " rising to full hardness in anticipation.  Your daughter pats ", false);
	if (player.cockTotal() > 1) outputText("one of them", false);
	else outputText("it", false);
	outputText(" as if it were a person and smiles as she pops the restraints from your chair.  She helps you as you stagger up to your " + player.feet() + ", though the feeling of her hand stroking ", false);
	if (player.cockTotal() > 1) outputText("a", false);
	else outputText("your", false);
	outputText(" " + player.cockDescript(0) + " doesn't make it easy.  The pair of you journey deeper into the caves to a massive antechamber filled with pregnant goblins.  Some are eating, others are sewing at tables, tinkering with machinery, or fiddling with alchemical equipment.  All of them turn to look at you as you enter.\n\n", false);
	
	outputText("The well endowed goblin next to you announces, \"<i>Dad has decided that he will willingly stay here and fuck each of us as often as we want.  Let's get him some succubi's delight, I want mom to watch him fill me when she gets home!</i>\"\n\n", false);
	
	outputText("A cheer reverberates off the ceiling as your daughters crowd around you, pressing their buxom chests and rounded backsides against you.  You're led to a secluded corner and fed food and strange drinks, while being kept incredibly horny for hours as you await Tamani's return.  True to her word, your daughter is on top of you in a flash once the clan's matriarch enters the room, and you're helpless to do anything but submit to her velvet pussy.  You cum loudly and messily, creaming her walls and flooding the area around you with spunk while Tamani is forced to watch with a jealous look on her face.\n\n", false);
	
	outputText("The rest of your life continues on in a similar fashion – you're kept happily fed, full, and pleasured by your hundreds of pregnant wives as your harem grows.  There's no shortage of sex, and no shortage of desire thanks to your wives' alchemical talents.  Within the span of a month you've utterly forgotten about your quest – it's hard to focus on anything but cuddling with your wives and daughters while you await your next fuck.", false);
	getGame().gameOver();
}

//[Lose to Daughters With Tamani There]
private function loseToDaughtersWithTamaniThere():void {
	spriteSelect(57);
	clearOutput();
	flags[kFLAGS.TIMES_FUCKED_TAMANIS_DAUGHTERS]++;
	//Find a dick that fits
	var primary:Number = player.cockThatFits(50);	

	outputText("Your attempts to resist prove to be in vain, as your daughters and their extra-curvy mother have completely defeated you.  ", false);
	if (player.HP < 1) outputText("Lying in the dirt, too hurt to fight back, you can only tremble in anticipation of what pleasures they're going to force upon you this time.", false);
	else {
		outputText("Lying back in the dirt, you're too hard to fight back.  You stroke ", false);
		if (player.totalCocks() > 1) outputText("one of ", false);
		outputText("your trembling " + player.multiCockDescriptLight() + ", feeling it leak pre-cum in anticipation of getting to knock up some of these beautiful curvy women.", false);
	}
	outputText("  Tamani pushes her way to the front of the pack, her daughters looking disappointed but yielding to their mother's authority for the time being.  She walks over to you, stepping over your fallen form and uncorking a a potion.  You grunt as she drops her jiggling ass down on your ", false);
	if (player.biggestTitSize() < 1) outputText("chest", false);
	else outputText(player.allBreastsDescript(), false);
	outputText(" and says, \"<i>Now husband, you've let your daughters beat you fair and square, so now it's time to take your medicine and give them their reward for becoming so strong.</i>\"\n\n", false);
	
	outputText("The potion's bottle becomes a plug for your mouth as Tamani forces your mouth open.  She tips it back and massages your throat with one hand, forcing you to gulp down the fluid.  ", false);
	if (flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] < 2) outputText("It tastes syrupy-sweet", false);
	else outputText("It has a familiar taste that you can't quite place", false);
	outputText(" and nearly makes you gag, but Tamani makes sure you drink down every drop.  An immediate numbness spreads through your body, starting at your fingertips.  It slowly crawls up your arms and then starts at your " + player.feet() + " as well.  In no time it's hard to move, and it becomes hard to think.  Your mind feels almost like its full of cotton-candy, with fuzzy pink stuff constantly getting in the way of your thoughts.\n\n", false);
	
	outputText("Tamani rubs your temples soothingly as your " + player.face() + " creases with worry and reassures you, \"<i>Don't worry, this will wear off soon.  This drug just shuts down your mind so it'll be nice and open to suggestion.  You can feel how hard it is to think, can't you?  Every time you muster up a thought it gets caught up in the little pink clouds and whisked away.  Don't bother, just relax and listen to Tamani's voice.</i>\"\n\n", false);
	
	outputText("She reaches into your " + player.armorName + " to rub ", false);
	if (player.totalCocks() > 1) outputText("one of ", false);
	outputText("your " + player.multiCockDescriptLight() + ", casually stroking the hard member as she pivots around to explain, \"<i>You get so hard for Mistress Tamani, don't you?  ", false);
	if (flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] > 10) outputText("Your body must remember how much it loves being my pussy-hungry husband.", false);
	else outputText("That's because your body knows how hot and moist Tamani's pussy is and how much you want to service it.", false);
	outputText("</i>\"\n\n", false);

	outputText("Of course she's right – you can feel her wetness on your chest and you want to bury your face in it while she strokes you.  Tamani watches your eyes and turns to give you a better view, presenting her snatch while she leans back to stroke you.  She titters, \"<i>Yes, get a good look at your wife's cunt.  It looks so delicious, so warm, so inviting.  You want nothing more than to bury your cock or face into it, don't you?  That's because it's your wife's cunt, and you're a good husband.</i>\"\n\n", false);
	
	outputText("Her hand starts stroking you faster and her juices start to drip down the sides of your torso", false);
	if (player.skinType == SKIN_TYPE_FUR) outputText(", matting your " + player.furColor + " fur", false);
	outputText(" as she continues ", false);
	if (flags[kFLAGS.TAMANI_TIMES_HYPNOTISED] < 10) outputText("filling your mind with truths", false);
	else outputText("reinforcing your image of yourself as an obedient husband", false);
	outputText(", \"<i>It feels so good to service your wife's aching pussy and fill it full of cum.  Your cock knows it and wants it so much that any time you see your wife, Tamani, you'll get so hard and hot for her that you'll forget about anything but worshipping her cunt, won't you?</i>\"\n\n", false);
			   
	outputText("You start nodding while she talks, your eyes never leaving the glistening fuck-hole a few inches away.  Your wife is so smart, and though you stop hearing the words, you know everything she's telling you is the truth.  The smooth skin of her hands strokes you perfectly, only getting better as they become slick with pre-cum.  Tamani's voice rises, taking on a tone of command, and then you're squirting obediently for her – a good husband.\n\n", false);
	
	if (player.cumQ() < 50) outputText("Cum splatters and drips down Tamani's hand, forming a tiny puddle on your chest.", false);
	//(ALT)
	else if (player.cumQ() < 250) outputText("Cum splatters over Tamani's hand and forearm, even hitting her ass and hips as you form a thick puddle over your torso that drips to the ground.", false);
	//(ALT2)
	else if (player.cumQ() < 600) outputText("Cum splatters out in thick waves, soaking Tamani's hand, forearm, and hips with thick puddles of the stuff.  It pools on your belly for a moment, then rolls off you, forming a small pool on the ground as you keep squirting.", false);
	//(ALT3)
	else {
		outputText("A massive wave of cum erupts from you, soaking Tamani from the shoulders to the knees in thick goop.  The next wave comes out with less force, pooling your belly before rolling off to puddle on the ground.   The puddle grows into a thick pool of the stuff as your orgasm drags on.", false);
		if (player.cumQ() >= 2000) outputText("  Eventually it stops, but by then the pool is huge and nearly five inches deep.", false);
	}
	outputText("  Pride wells up in you when you realize what a good husband you've been.  Tamani pats you on the head, and whispers, \"<i>Good job lover</i>\" as the cobwebs slowly clear away.   You remember your wife pouring a lust draft down your throat and giving you the 69 of a lifetime, but now it's time to be a good husband and father and help your daughters out too.   The girls clamber forwards, giggling to each other excitedly as they remove what little garments they have.\n\n", false);
	
	outputText("You welcome them into your arms as Tamani steps away with a strange glint in her eye, rubbing the seed on her hand into her snatch.  Potions are pressed to your lips, and you happily accept your daughters' gifts, guzzling them happily and taking the time to compliment them on their alchemical skills while ", false);
	if (player.cockTotal() > 1) outputText("each of ", false);
	outputText("your " + player.multiCockDescriptLight() + " grows back to full erectness and trembles with desire, ready to seed a womb.  The girls ", false);
	if (player.cockTotal() == 1) outputText("grab your " + player.multiCockDescriptLight() + " and stroke it with long slow strokes, just like their mother.  Unlike her, they don't seem content to wait, and in seconds a slippery gash is stretching to accommodate your cock-head.\n\n", false);
	else outputText("each grab one of your " + player.multiCockDescriptLight() + " and stroke it with long slow strokes, just like their mother.  Unlike her, they don't seem content to wait, and in seconds a slippery gash is stretching to accommodate each cock-tip.\n\n", false);
	
	//(TOO BIG)
	if (primary < 0) {
		outputText("Sadly, you're just too big to properly impregnate your daughter, and a stab of worry that you might be a bad father lances through you.  ", false);
		if (player.cockTotal() == 1) {
			outputText("Thankfully your daughter doesn't seem to mind.  She switches to resume stroking you, though the wet tightness of goblin cunt stretches around as much of your tip as it can.  Between the drugs, the sexy girl on top of you, and your desire to be a good patriarch, they have no problem getting you off into their waiting, fertile wombs.  You cry out and twitch, seeding your daughter's womb with spunk, treating her just like her mother now that she's all grown up.", false);
			if (player.cumQ() > 700) outputText("It gets everywhere as her womb fails to contain your massive load, even after you've bloated her belly with the stuff.", false);
			if (player.cumQ() > 2000) outputText("After a few more seconds the puddle from before gets even deeper, and your daughters kindly prop up your head to keep you from drowning in the jism pool.", false);
		}
		else {
			outputText("Thankfully your daughters don't seem to mind.  They switch to resume stroking you, though the wet tightness of goblin cunts stretches around as much of your tips it can.  Between the drugs, the sexy girls on top of you, and your desire to be a good patriarch, they have no problem getting you off into their waiting, fertile wombs.  You cry out and twitch, seeding your daughters' womb with spunk, treating them just like their mother now that they're all grown up.", false);
			if (player.cumQ() > 700) outputText("It gets everywhere as their wombs fail to contain your massive load, even after you've bloated their bellies with the stuff.", false);
			if (player.cumQ() > 2000) outputText("After a few more seconds the puddle from before gets even deeper, and your daughters kindly prop up your head to keep you from drowning in the jism pool.", false);
		}
		outputText("\n\n", false);
		
		outputText("Drained from two amazing orgasms, you start to nod off, but you're happy knowing they'll keep you hard and cumming until every empty pussy is full of thick baby-making cream.", false);
	}
	//(FITS)
	else {
		outputText("Thankfully, the hungry goblin twat is able to devour your " + player.cockDescript(0) + " with ease.  Those pliable, fluid-slicked cunt-walls clench ever-so-tightly around you", false);
		if (player.biggestCockArea() < 30) outputText(" in spite of the large sizes they usually handle.", false);
		else outputText("r large size.", false);
		if (player.totalCocks() > 1) {
			outputText("  You grunt happily as your daughters begin to slide up and down your lengths, moaning lewdly with every wet squelch that escapes their drooling pussies.  Thanks to the drugs, the writhing form of your sexy daughters, and the desire to be a good patriarch for your family, you get off in no time.  You cry out and twitch, seeding your daughters' womb with spunk, treating them just like their mother now that they're all grown up.", false);
			if (player.cumQ() > 700) outputText("  It gets everywhere as their wombs fail to contain your massive load, even after you've bloated their bellies with the stuff.", false);
			if (player.cumQ() > 2000) outputText("  After a few more seconds the puddle from before gets even deeper, and your daughters kindly prop up your head to keep you from drowning in the jism pool.", false);
		}
		else {
			outputText(" You grunt happily as your daughter begins to slide up and down your length, moaning lewdly with every wet squelch that escapes her drooling pussy.  Thanks to the drugs, the writhing form of your sexy daughter, and the desire to be a good patriarch for your family, you get off in no time.  You cry out and twitch, seeding your daughter's womb with spunk, treating her just like her mother now that she's all grown up.", false);
			if (player.cumQ() > 700) outputText("  It gets everywhere as her womb fails to contain your massive load, even after you've bloated her belly with the stuff.", false);
			if (player.cumQ() > 2000) outputText("  After a few more seconds the puddle from before gets even deeper, and your daughters kindly prop up your head to keep you from drowning in the jism pool.", false);
		}
		outputText("\n\n", false);
		
		outputText("Drained from two amazing orgasms, you start to nod off, but you're happy knowing they'll keep you hard and cumming until every empty pussy is full of thick baby-making cream.", false);
	}
	//Chance of tamani pregnancy, chance of daughter preggers
	knockUpDaughters();
	kGAMECLASS.forest.tamaniScene.tamaniKnockUp();
	flags[kFLAGS.TAMANI_TIMES_HYPNOTISED]++;
	//daughter countdown reset. 
	player.orgasm();
	dynStats("str", -.5,"int", -.5, "lib", 1, "sen", 1, "cor", 1);
	if (getGame().inCombat) combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseOneHour);
}


private function knockUpDaughters():void {
	if (pregnancy.isPregnant) return;
	pregnancy.knockUpForce(PregnancyStore.PREGNANCY_PLAYER, 216); //Nine day long pregnancy, just like mom
	//Determine how many kids...
	flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_COUNT] = 2;
	var cum:Number = player.cumQ();
	//Breeder perk is awesome
	if (player.findPerk(PerkLib.MaraesGiftStud) >= 0) flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_COUNT] += 3;
	if (cum >=  50 && rand(2) == 0) flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_COUNT]++;
	if (cum >= 100 && rand(2) == 0) flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_COUNT]++;
	if (cum >= 200 && rand(2) == 0) flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_COUNT]++;
	if (cum >= 300 && rand(2) == 0) flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_COUNT]++;
	if (cum >= 400 && rand(2) == 0) flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_COUNT]++;
	if (cum >= 500 && rand(2) == 0) flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_COUNT]++;
	if (cum >= 600 && rand(2) == 0) flags[kFLAGS.TAMANI_DAUGHTERS_PREGNANCY_COUNT]++;
}

internal function combatWinAgainstDaughters():void {
	spriteSelect(57);
	if (monster.HP < 1) {
		outputText("You smile in satisfaction as " + monster.a + monster.short + " collapses, unable to continue fighting.", true);
		if (player.lust >= 33 && player.cockTotal() > 0) {
			outputText("In spite of their injuries, they do try to present their bodies in as lewd a way as possible.  You could still fuck them, but things might get out of hand...\n\nDo you fuck them?", true);
			doYesNo(fuckYoDaughtersHomie, combat.cleanupAfterCombat);
		}
		else combat.cleanupAfterCombat();
		return;
	}
	else {
		outputText("You smile in satisfaction as your daughters collapse in upon themselves, devolving into a frenzied orgy.  It looks like they're too distracted to continue fighting.  They're putting on quite a show...\n\n", true);
		dynStats("lus", 5);
		if (player.lust >= 33 && player.cockTotal() > 0) {
			outputText("You could still fuck them, but things might get out of hand...\n\nDo you fuck them?", false);
			doYesNo(fuckYoDaughtersHomie, combat.cleanupAfterCombat);
		}
		else combat.cleanupAfterCombat();
		return;
	}
}

internal function loseToDaughters():void {
	spriteSelect(57);
	if (player.lust >= player.maxLust()) {
		//worms r gross mmmmkay?
		if (player.findStatusEffect(StatusEffects.Infested) >= 0) {
			kGAMECLASS.mountain.wormsScene.infestOrgasm();
			outputText("\n\nThe goblins sigh and say, \"<i>Dad, that's just gross.  Don't get me wrong, we're still gonna have you knock us up, but I hate the feeling of those worms inside me.</i>\"", false);
			player.orgasm();
		}
		outputText("\n\nYou give up, you're just too turned on by the sea of sexually charged deviants to resist them anymore.  You're ready to fuck them all.", false);
		if (player.cockTotal() == 0) {
			outputText("The sexy sluts pout, \"<i>Why did you have to go and get rid of your dick!?</i>\" before something hits you in the head, HARD, knocking you out.", false);
			combat.cleanupAfterCombat();
			return;
		}
		if (tamaniPresent) {
			if (rand(2) == 0) doNext(loseToDaughtersWithTamaniThere);
			else doNext(legTamanisDaughtersRAEPYou);
			return;
		}
		else {
			if (rand(2) == 0) doNext(tamaniDaughtersCombatLossDrain);
			else doNext(legTamanisDaughtersRAEPYou);
			return;
		}
	}
	//hp loss
	else {
		outputText("\n\nOverwhelmed by your wounds, you can't even try to stop the goblin horde...", false);
		if (player.cockTotal() == 0) {
			outputText("The sexy sluts pout, \"<i>Why did you have to go and get rid of your dick!?</i>\" before something hits you in the head, HARD, knocking you out.", false);
			combat.cleanupAfterCombat();
			return;
		}
		if (tamaniPresent) {
			doNext(loseToDaughtersWithTamaniThere);
			return;
		}
		else {
			if (rand(2) == 0) doNext(tamaniDaughtersCombatLossDrain);
			else doNext(legTamanisDaughtersRAEPYou);
			return;
		}
	}
}
}
}
