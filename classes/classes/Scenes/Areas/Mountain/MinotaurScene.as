package classes.Scenes.Areas.Mountain {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Armors.LustyMaidensArmor;

	public class MinotaurScene extends BaseContent {

		public function MinotaurScene()
		{
		}
 /*
	private function minotaurAddicted():Boolean {
	return player.minotaurAddicted();
}
private function minotaurNeed():Boolean {
	return player.minotaurNeed();
}
 */
public function minoVictoryRapeChoices():void {
	spriteSelect(44);
	
	if (flags[kFLAGS.SFW_MODE] > 0) {
		outputText("You smile in satisfaction as the " + monster.short + " collapses, unable to continue fighting.", true);
		combat.cleanupAfterCombat();
		return;
	}
	
	//Hungry for cum?  Grab a snickers.
	if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1) {
		outputText("Smiling down at your vanquished foe, you feel a familiar hunger growing within you.  What do you do?", true);
	}
	//Not an addict
	else if (player.lust >= 33 && !player.isGenderless()) {
		if (monster.lust >= monster.eMaxLust()) outputText("You smile in satisfaction as the " + monster.short + " drops down on all fours and begins masturbating feverishly.  Sadly you realize your own needs have not been met.  Of course you could always fuck the eager bull...\n\nWhat do you do?", true);
		else outputText("You smile in satisfaction as the " + monster.short + " collapses, unable to continue fighting.  Sadly you realize your own needs have not been met.  Of course you could always rape the poor thing...\n\nWhat do you do?", true);
	}
	//Not able to rape but a feeder
	else if (player.hasStatusEffect(StatusEffects.Feeder)) {
		if (monster.lust >= monster.eMaxLust()) outputText("You smile in satisfaction as the " + monster.short + " collapses, unable to continue fighting.  Sadly you realize your own need to breastfeed has not been met.  You could always let the poor thing have a drink...\n\nDo you?", true);
		else outputText("You smile in satisfaction as the " + monster.short + " collapses, unable to continue fighting.  Sadly you realize your own need to breastfeed has not been met.  You could always let the poor thing have a drink...\n\nWhat do you do?", true);
	}
	//No rape, no feeder
	else {
		if (monster.lust >= monster.eMaxLust()) outputText("You smile in satisfaction as the " + monster.short + " drops down on all fours and begins masturbating feverishly.", true);
		else outputText("You smile in satisfaction as the " + monster.short + " collapses, unable to continue fighting.", true);
	}
	
	menu();
	
	addDisabledButton(0, "Use Cock", "This scene requires you to have fitting cock and sufficient arousal.");
	addDisabledButton(1, "Use Vagina", "This scene requires you to have vagina and sufficient arousal.");
	addDisabledButton(2, "Use Both", "This scene requires you to be herm and to have sufficient arousal. This scene can't accomodate taurs.");
	addDisabledButton(3, "TentacleDick", "This scene requires you to have at least two cocks, at least one of them should be tentacle and have sufficient arousal.");
	addDisabledButton(4, "UrethraFuck", "This scene requires you to have long enough, bot not too thick cock and sufficient arousal.");
	addDisabledButton(5, "MakeHimSuck", "This scene requires you to have fitting cock and sufficient arousal.");
	addDisabledButton(6, "MinoMutual", "This scene requires you to have cock and sufficient arousal.");
	addDisabledButton(7, "Get Filled", "This scene requires you to be a cum addict.");
	addDisabledButton(8, "Titfuck Him", "This scene requires you to be a cum addict with big tits or naga tail.");
	addDisabledButton(9, "Lay Eggs", "This scene requires you to have ovipositor and enough eggs. Bee oviposition requires genitals as well.");
	addDisabledButton(10, "Breastfeed", "This scene requires you to have enough milk.", "Breastfeed");
	// Button 11 is used for Lusty Maidens Armor special scene and is hidden without it
	
	//Determine if PC can rape with a dick!
	var x:Number = player.cockThatFits(monster.analCapacity());
	// Scenes with lust requirement first
	if (player.lust >= 33) {
		// buttfuck options
		if (x >= 0) {
			addButton(0, "Use Cock", bumRapeaMinotaur, undefined, undefined, undefined, "Fuck his ass with your cock.");
			addButton(6, "MinoMutual", minoMutual, undefined, undefined, undefined, "Fuck his ass with a lot of gentle foreplay.");
			if (player.cockTotal() > 1 && player.countCocksOfType(CockTypesEnum.TENTACLE) > 0)
				addButton(3, "TentacleDick", rapeMinotaurTentacles, undefined, undefined, undefined, "Tentacle-flavored buttfuck.");
		}
		
		if (player.hasCock()) {
			//Checking to see if can urethral pen
			//Loop through to see if any dicks qualify, and if so enable it.
			for (var counter:int = 0; counter < player.cockTotal(); counter++) 
			{
				if (player.cocks[counter].cockThickness <= 4 && player.cocks[counter].cockLength >= 14) {
					addButton(4, "UrethraFuck", minoUrethralPen, undefined, undefined, undefined, "Stick your cock into his own.", "Urethra Fuck");
					break;
				}
			}
			if (player.cockThatFits(80) >= 0) {
				addButton(5, "MakeHimSuck", minotaurBlowjob, undefined, undefined, undefined, "Get a blowjob.", "Make Him Suck");
			}
		}
		
		if (player.hasVagina()) {
			addButton(1, "Use Vagina", girlRapeAMinotaur, undefined, undefined, undefined, "Ride his cock.");
		}
		
		if (player.isHerm() && x >= 0 && !player.isTaur())
			addButton(2, "Use Both", minotaurGetsRapedByHerms, undefined, undefined, undefined, "Fuck his butt while using his cock.");
	}
	// Cum addict scenes
	if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1 || player.findPerk(PerkLib.MinotaurCumAddict) >= 0) {
		addButton(7, "Get Filled", takeMinoCumDirectly, undefined, undefined, undefined, "Get cum injection in your ass.");
		if (player.biggestTitSize() >= 5 && !player.isNaga()) {
			addButton(8, "Titfuck Him", minoGetsTitFucked, undefined, undefined, undefined, "Use your breasts to milk him for his cum.");
		}
		else if (player.isNaga()) {
			addButton(8, "ProstateMilk", minoGetsTitFucked, undefined, undefined, undefined, "Use your tail to milk him for his cum.");
		}
	}
	// Special scenes
	if (player.canOvipositSpider() || (player.canOvipositBee() && !player.isGenderless())) {
		addButton(9, "Lay Eggs", layEggsInAMinotaurSpiderLike, undefined, undefined, undefined, "Fuck his butt while using his cock.");
	}
	if (player.findPerk(PerkLib.Feeder) >= 0 || player.lactationQ() >= 1000) {
		addButton(10, "Breastfeed", minotaurDrinksMilkNewsAtEleven, undefined, undefined, undefined, "Feed this oversized calf.");
	}
	if (player.hasVagina() && player.biggestTitSize() >= 4 && player.armor is LustyMaidensArmor) {
		addButton(11, "B.Titfuck", (player.armor as LustyMaidensArmor).lustyMaidenPaizuri, undefined, undefined, undefined, "Lusty maiden paizuri.");
	}
	
	addButton(14, "Leave", combat.cleanupAfterCombat);
}


//Tentacle scenes require multi dicks at minimum
//(dicks > 1 && tentacledicks > 0)
private function rapeMinotaurTentacles():void {
	spriteSelect(44);
	//multicock but single tentalce rape scene
	if (player.cocks.length > 1 && player.countCocksOfType(CockTypesEnum.TENTACLE) == 1) {
		rapeMinotaurTentacle();
		return;
	}
	minoRapeIntro();
	var x:Number = 0;
	var counter:Number = 0;
	while(counter < player.cockTotal()) {
		if (player.cocks[counter].cockType == CockTypesEnum.TENTACLE) {
			x = counter;
			break;
		}
		counter++;
	}
	var mismatched:Boolean = false;
	var temp2:Number = 0;
	clearOutput();
	if (monster.HP <= 0) outputText("The minotaur collapses backwards after your last blow. Defeated and tired, he can barely stand up as you approach.  ", false);
	else {
		outputText("The minotaur drops his arm", false);
		if (monster.weaponName == "axe") outputText(", letting his axe clatter to the floor", false);
		outputText(". Transfixed by your " + player.multiCockDescript() + " in front of his face, he barely notices as you walk closer.  ", false);
	}
	outputText("You grab his arm firmly, making certain there will be no retaliation during the pleasure. By the look on his face, and the state of his torn, rolled up loincloth, though, you doubt that will be a problem.  ", false);
	if (player.cor < 25) outputText("You cry, petting his hair, smoothing it across his horns, justifying to yourself that you are raping this beast because this is how this world works as you maneuver your " + player.multiCockDescript() + " towards his tailhole.  ", false);
	if (player.cor >= 25 && player.cor < 50) outputText("You smoothly guide your " + player.multiCockDescript() + " toward his tailhole.  ", false);
	if (player.cor >= 50 && player.cor < 80) outputText("You roughly grab him, slamming him close to your " + player.multiCockDescript() + " - just how this beast likes it.  ", false);
	if (player.cor >= 80) outputText("You grin and roughly pull his horns towards your " + player.multiCockDescript() + ", ready to roughly ride this beast.  ", false);
	//Mixed dix
	if (player.cockTotal() != player.countCocksOfType(CockTypesEnum.TENTACLE)) {
		mismatched = true;
		temp = player.cocks.length;
		temp2 = -1;
		//Find the first non-tentacle dick for a point of comparison
		while(temp > 0 && temp2 == -1) {
			temp--;
			if (player.cocks[temp].cockType != CockTypesEnum.TENTACLE) temp2 = temp;
		}
		//failsafe
		if (temp2 == -1) temp2 = 0;
		//Find the longest non-tentace dick
		temp = player.cocks.length;
		while(temp > 0) {
			temp--;
			//Check to see if this cock is longer than the saved one.
			if (player.cocks[temp].cockLength > player.cocks[temp2].cockLength && player.cocks[temp].cockType != CockTypesEnum.TENTACLE) {
				temp2 = temp;
			}
		}
		outputText("Your " + player.cockDescript(temp2) + " slams into his tailhole, spreading it wider as you thrust in and out of the opening, relishing in the feeling of the rough, yet lubricated insides of the minotaur.  ", false);
	}
	//Not mismatched
	else {
		temp2 = 0;
		outputText("One of your prehensile dicks coils in on itself as it nears the minotaur's tailhole, readying itself. It then suddenly springs itself into his fleshy orifice, wiggling and writhing in deeper and deeper until all " + num2Text(int(player.cocks[0].cockLength)) + " inches of it have submerged itself inside his intestines. You and he both shudder as your cock starts weaving from side to side, making slithering motions inside him.  ", false);
	}
	//Vaginassss
	if (player.vaginas.length >= 1) {
		outputText("With your " + player.cockDescript(temp2) + " successfully embedded in the minotaur, you twist around, positioning your " + player.vaginaDescript(0) + " to take the minotaur's enormous length into yourself.  You feel his member deliciously slide in, and feel the beast's hot breath radiate as he starts panting in lust.  ", false);
		player.cuntChange(monster.cockArea(0),true,false,true);
	}
	//Multivaginas...wtf
	if (player.vaginas.length > 1 && !mismatched && player.cocks.length > 2) outputText("Your tentacle cocks writhe upon themselves, each turning to an unattended " + player.vaginaDescript(1) + " on your body, and quickly filling up the cavernous depths. You groan in ecstasy at the self-fucking you are receiving as all your pussies start leaking their wonderful fluids.  ", false);
	//more dicks than available holes
	if ((player.countCocksOfType(CockTypesEnum.TENTACLE) == 2 || player.countCocksOfType(CockTypesEnum.TENTACLE) == 3)) outputText("Your next tentacle dick, saddened by not having anything to writhe around, turns to the minotaurs protruding member. It darts out from your crotch, wrapping around his monstrous meat and constricting, like a snake might around its prey. Your tongue lolls out as you feel that cock twist and grab his dick, pulsing with both your blood and the beast's twitching member.  ", false);
	if (player.countCocksOfType(CockTypesEnum.TENTACLE) > 3) outputText("Your remaining tentacle dicks wave around the minotaur, tending to his balls, weaving around his limbs, and generally rubbing and throbbing all over him, spreading pre-cum around and through him, leaving both of you moaning in pleasure.  ", false);
	//Cum
	outputText("Your tentacles throb and pulse, quickening in pace as you can feel the cum swelling in your prostate. They wave madly, and then, just as their motion makes you dizzy, you feel them stiffen suddenly, and start spewing their load all in and across the minotaur. You gasp and pause, collapsing on the strong back of the minotaur, basking in the afterglow.", false);
	player.orgasm('Generic');
	combat.cleanupAfterCombat();
}

private function rapeMinotaurTentacle():void {
	spriteSelect(44);
	minoRapeIntro();
	var x:Number = 0;
	var counter:Number = 0;
	while(counter < player.cockTotal()) {
		if (player.cocks[counter].cockType == CockTypesEnum.TENTACLE) {
			x = counter;
			break;
		}
		counter++;
	}
	clearOutput();
	outputText("You stand before the defeated minotaur and your tentacle dick begins to lash back and forth quickly, showing your excitement.  You see the hardness of his dick, and decide to do something about it... for both of you.  ", false);
	outputText("You come up behind him and wrap your tentacle dick around his huge member, squeezing him tightly at his dick's base pump even more blood to it.  Then you wrap yourself around his massive erection a few more times and you're ready. You jerk him up and down, varying the pace, place, and strength of your grip, milking his dick for all he is worth.  ", false);
	outputText("The minotaur's balls begin to spasm, so you wrap the base of your tentacle around him tightly, preventing his " + monster.cockDescriptShort(0) + " from cumming, driving the minotaur mad with desire.  Your own " + player.cockDescript(x) + " delights in the feeling of the fur of his balls and the hardness of his " + monster.cockDescriptShort(0) + ".  ", false);
	//Reset for upcoming stuff
	temp = 0;
	//if multi with pony dick!
	if (player.countCocksOfType(CockTypesEnum.HORSE) == 1) {
    	outputText("But it isn't enough for you. You take your pony prick, and with your hands, pull his anus wide. The flare at your tip takes some effort to get in, but once it's inside, you ram right to the hilt, knocking the wind from the minotaur with a solid grunt.  ", false);
		temp = 1;
	}
	//if multi with dogdick
	if (player.dogCocks() == 1 && temp != 1) {
		temp = 1;
		outputText("But it isn't enough for you. You take your bitch knotter, and with your hands, pull his anus wide. You slide in easily, right up to your knot, but he's too tight for you to slip that in.  ", false);
	}
	//If single leftover dick
	if (player.cocks.length == 2 && temp != 1) {
		temp = 1;
		outputText("But you avail yourself of his free rear end, to further your own delights. A quick push, and you're in, buried to your hilt.  ", false);
	}
	if (player.cocks.length > 2 && temp != 1) {
		temp = 1;
		outputText("It's not enough! Your other dicks demand attention too! Fortunately, he has a large hole for you to abuse... you stuff as many of your " + player.multiCockDescript() + " as you can, the rest hanging underneath him, slapping against his sack. ");
	}
	if (player.getClitLength() > 6) {
		outputText("Eager for more stimulation, you muse that your clit's big enough to fuck with, so why not!? You take your fingers, spit on them, and slide them into place, opening him up wider to accept your " + player.clitDescript() + ". It's so sensitive, sliding into that tight hole, and the sensations are driving you wild as you hump against him with your dick-like clit.  ", false);
	}
	//Free pussy!
	if (player.vaginas.length > 0) {
		temp = 2;
		outputText("You're a woman, and it's about time you got some pussy action too!  You slide your " + player.vaginaDescript(0) + " onto " + player.cockDescript(x) + "-wrapped minotaur-prick, further driving the beast mad with lust.  He plaintively groans, struggling to get his dick free or to cum, you aren't quite sure.  ", false);
		outputText("Eventually, the moment is right.  You smile as you feel a boiling heat building in your groin, surging through your " + player.multiCockDescript() + " in a tide of white-hot pleasure.  You groan and shiver, lost in the pleasure until you begin to calm down.  ", false);
		if (player.cumQ() < 50) outputText("Your cock made quite a mess of things, and when you pull him out, your " + player.vaginaDescript(0) + " makes a wet sucking sound.  ", false);
		if (player.cumQ() >= 50 && player.cumQ() < 400) outputText("Your cock made quite a mess of things inside your " + player.vaginaDescript(0) + ".  As you pull free, cum drips freely down your thighs.  The heavenly scent of minotaur spunk fills your nose, and begin scooping the mixed jizz up to sample.  ", false);
		if (player.cumQ() >= 400) outputText("Your cock made quite a mess of things inside your " + player.vaginaDescript(0) + ".  As you pull free, a river of cum pours from betwixt your thighs.  The heavenly scent of minotaur spunk fills your nose, and you begin scooping the mixed jizz up to sample.  ", false);
	}
	//Free ass!
	else {
		temp = 2;
		outputText("You're feeling a little kinky so you step in front of him, offering him a little bit more, pushing yourself down onto his meaty dick.  You slowly push down, enjoying every inch as it travels down your " + player.assholeDescript() + ", the pre leaking from it acting as a lubricant as his tentacle-wrapped cock works its way inside you.  ", false);
		//Ass cum
		outputText("Eventually, the moment is right.  You smile as you feel a boiling heat building in your groin, surging through your " + player.multiCockDescript() + " in a tide of white-hot pleasure.  You groan and shiver, lost in the pleasure until you begin to calm down.  ", false);
		if (player.cumQ() < 50) outputText("Your cock in his ass made a mess of things, and when you pull out, it makes a wet sucking sound, trying to keep you inside.  ", false);
		if (player.cumQ() >= 50 && player.cumQ() < 400) outputText("Your cock in his ass spills forth, creating a puddle which will mat his fur later.  ", false);
		if (player.cumQ() >= 400) outputText("Your cock is blasted free from his ass by the force of your ejaculation, splattering rivers of spoo over the ground.  A river of the stickiness pours from his violated asshole, sticking in the fur of his thighs.  ", false);
	}
	//Cum tiem
	if (temp < 2) {
		if (player.cumQ() < 25) outputText("Eventually, the moment is right... you position yourself accordingly to do what you have in mind.  Your needs are both at their peak, and release will be soon!  Once you're properly set up behind him, you shove his head forward, making him take both your, and his own, dick into his mouth. His tongue trying to shove you out, slipping in between his and your own dick pushes you over the edge, and you release his balls, causing both of your dicks to fill his mouth with cum.", false);
		//Big Cum
		if (player.cumQ() >= 25 && player.cumQ() < 250) outputText("Eventually, the moment is right... you position yourself accordingly to do what you have in mind. Your needs are both at their peak, and release will be soon! Once you're properly set up behind him, you shove his head forward, making him take both your and his own dick into his mouth. His tongue tries to shove you out, slipping in between his and your own dick.  It pushes you over the edge, and you release his balls, causing both of your dicks to flood his mouth with cum, which dribbles out around his lips, and splatters onto his chest.", false);
		if (player.cumQ() >= 250 && player.cumQ() < 500) outputText("Eventually, the moment is right... you position yourself accordingly to do what you have in mind. Your needs are both at their peak, and release will be soon! Once you're properly set up behind him, you shove his head forward, making him take both your and his own dick into his mouth. His tongue tries to shove you out, slipping in between his and your own dick.  It pushes you over the edge, and you release his balls, causing both of your dicks to overflow his mouth with cum, spraying out his nose, forcing him to swallow from sheer volume.", false);
		if (player.cumQ() >= 500) outputText("Eventually, the moment is right... you position yourself accordingly to do what you have in mind. Your needs are both at their peak, and release will be soon! Once you're properly set up behind him, you shove his head forward, making him take both your, and his own dick into his mouth. His tongue tries to shove you out, slipping in between his and your own dick.  It pushes you over the edge, and you release his balls, allowing him to cum. However, your own cum dwarfs his pathetic volume... forcing him to swallow load after load of your hot sticky jizz. Even so, the volume exceeds his ability to down it, and cum sprays out of his mouth, an arc shooting out of his nose every now and again further commenting on the capacity of your massive ejaculation.", false);
	}
	combat.cleanupAfterCombat();
}

private function AddictNagaOnMinotaur():void {
	spriteSelect(44);
	clearOutput();
	//[if (monster.lust >= 99)
	if (monster.lust >= monster.eMaxLust()) outputText("You slither towards the fallen monster, wishing to taste his addictive semen.  He's currently engaged in stroking his enormous shaft up and down with both of his hands, but offers little resistance when you push him over to a sitting position.  You pull his hands away and replace them with yours, running your fingers up and down along his thickness, working yourself up with anticipation.  He leans back and exhales loudly, clearly appreciative.\n\n", false);
	else outputText("You slither towards the fallen monster, wishing to taste his addictive semen.  You notice that, despite the beating you just gave him, his huge cock is fully erect.  Delighted, you gently run both of your hands up and down its long shaft.  He exhales loudly, signaling his appreciation.\n\n", false);

	outputText("A bit of gooey pre-cum begins to gather at the tip of his thick, horse-like cock.  Your tongue flits out instinctively, and you taste its scent in the air.  It's too much for you to handle, and you are overcome with an absolute need to fill yourself with his nectar.  You throw yourself onto his crotch, grabbing his thighs and rubbing his cock along your torso as you position your mouth over his length, taking care to keep your long fangs out of the way.  You violently pull yourself to him, forcing more of him than you thought you could handle down your throat.  You feel his pre lubricating your insides, numbing you to the pain and allowing you to take him deeper.  You take one hand from his leg and place it on the still exposed bit of his shaft, stroking what you could not take in your mouth. His animal grunting grows louder as you take just a bit more of him with each thrust downwards.  Mad with lust, you remove your other hand from his thigh, balancing on your lengthy tail and his cock, and use it to ", false);

	//if (player.cocks.length > 0)
	if (player.hasCock()) outputText("furiously stroke your own " + player.multiCockDescriptLight() + ". Your muffled vocalizations of pleasure weakly join his own.\n\n", false);
	else outputText("part the folds of your " + player.vaginaDescript(0) + ", sliding it inside and masturbating with a furious vigor. Your muffled vocalizations of pleasure weakly join his own.\n\n", false);

	outputText("As your lungs pain for breath, you realize that you will need to finish him off quicker than this.  The tip of your tail darts towards him and slides under his rear.  You find his anus and slip the tip inside.  An abrupt change in his rhythmic grunting and panting signals his surprise, but he makes no move to remove your intrusion.  Thankful for this, you slowly pass it deeper into him even as you try to push him deeper into you.  You can feel the orgasm rising in the minotaur's huge prick, and before it hits, you begin to rub what you judge to be his prostate in an effort to milk him of his semen.  This is clearly successful, as you feel an enormous load of his cum pass through his cock, swelling it inside your throat. As the first ropes of the hot goodness shoot into you, your mind is overwhelmed, and you join him in orgasm, your eyes rolling back into your head and your cries gurgling as they are pushed back before they can even begin by the thick semen pooling inside you.  Dizzy from the lack of oxygen and the aphrodisiac nature of his cum, you continue to rub his prostate, and he continues to cum and cum into you, filling your belly and throat, the excess spilling out of your mouth.  You're in perfect bliss, but though the pleasure has numbed you to the pain, you realize that your body will give out soon.  Just as you feel that you cannot go on, the fountain of semen gushing into you begins to slow, and the minotaur's cock begins to soften.  You slide off of him and remove your tail from him, noticing that he passed out at some point during his marathon orgasm.\n\n", false);

	outputText("You start to wipe some off the cum off of your face, but you're so drenched that the efforts are futile.  Drunk from the pleasure, you giggle quietly and meander back to your camp in a dreamy haze, almost left unable to think by the pleasurable sensations that the minotaur's semen still gives you.  At camp you curl up, smiling as you think of the huge load inside you, and drift off into a satisfied sleep.", false);
	//(satisfy or progress mino addiction)
	minoCumAddiction(10);
	monster.short = "tit-fucked Minotaur";
	combat.cleanupAfterCombat();
}

private function minoUrethralPen():void {
	spriteSelect(44);
	minoRapeIntro();
	var counter:Number = 0;
	var x:Number = 0;
	//Find which dick to use!
	while(counter < player.cockTotal()) {
		if (player.cocks[counter].cockThickness <= 4 && player.cocks[counter].cockLength >= 14) {
			x = counter;
			break;
		}
		counter++;
	}
	//Infested version!
	if (player.statusEffectv1(StatusEffects.Infested) == 5) {
		outputText("Grinning maliciously, you shove the minotaur onto his back, his massive equine dong slapping him in the chest as he lands with a grunt. Fondling your " + player.cockDescript(x) + " as you gaze upon his splendid rod, you suddenly shudder with pleasure as the worms in your " + player.sackDescript() + " wriggle around deliciously, a few of them escaping from your tip along with a copious dollop of pre.  The meager group of wiggling parasites crawling lamely towards the fallen brute gives you a wicked idea, flushing your entire body with arousal as you step over the minotaur and grab his prick firmly. Recognizing your plan, your parasitic pets begin to churn happily in your balls as you smear your pre over the minotaur's urethra.\n\n", false);

		outputText("The brute breaks out of his defeated daze with a look of abject horror as he feels unnatural squirming on his flare, bolting upright and loosing a terrified \"<i>MOO!!</i>\" as he scrambles to distance himself from your infested semen. You cackle with sick delight at his meager attempts to escape and grasp the head of his cock firmly, causing him to grunt with pain as you yank him back over to you by his flared rod and line the head of your " + player.cockDescript(x) + " up with his urethra. His eyes lock with yours, a pleading, desperate look in them as your balls surge from the anticipation. Unable to hold back against the unholy squirming of your infested cum, you grin evilly and ram your throbbing, infested prick deep into his shaft.\n\n", false);

		outputText("The minotaur writhes and moans, openly panicking but too weak to resist, as you saw your " + player.cockDescript(x) + " back and forth into his cock-hole, relishing the helpless look the once-mighty beast is displaying as you feel your worms steadily making their way down your cock. He must feel how the worms bulge your tool as they work their way down, nearing the end of your length as he shudders and shakes his head in denial. You give a tiny spasm of delight, tongue lolling out of your " + player.face() + " as the first of your worms pour out of your tip and directly into the beast's urethra.\n\n", false);

		outputText("Upon contact with his cum, your parasites go into overdrive, the musky narcotic cum of the minotaur exciting them as they suddenly begin surging out of your balls. Holding your orgasm back becomes impossible as you roar and buck your hips, ramming yourself fully into his shaft while the pulses of squirming jism shoot straight into his prostate and balls. You grip him with both hands, feeling the wonderfully perverse wriggling of your pets throughout his urethra and your own, truly relishing the thought of securing your pets a new home to infest as your mind nearly blanks from the release. Drooling with sick delight at infesting such a mighty beast, you suddenly feel the sensation of a large worm bulging your urethra as it shoots down into the minotaur, making you shudder with pleasure and making the poor mino lock his muscles in a sudden orgasm. Your surging cum and worms push his cum straight back into him, and he yells out in anguish, tears streaming from his eyes from the unbearable pressure that he must be feeling, aside from the obscene amounts of pleasure, that is...\n\n", false);

		outputText("The minotaur shivers, eyes wide and mouth open with breathless screams as his scrotum begins to visibly squirm, then bloat, swelling with the churning parasites. Without having to waste their effort on pinning the brute down, your worms get right down to business doing what they were made for, turning this minotaur into a constantly-cumming, worm infested, puddle of fuck - a slave to the endless orgasms your pets provide, just like you. The thought makes you cum one last time, a huge spurt of wormy jism making his balls swell obscenely before you finally pull out. Sated but exhausted, you flop down on your " + player.buttDescript() + " and fondle yourself in a daze, feeling the large worms in your " + player.sackDescript() + " wriggle happily while you watch the squirming, newly infested minotaur writhe in the dirt of the cave, bringing a wicked smile to your face.\n\n", false);

		outputText("Mooing and groaning, the beast succumbs to the obscene ministrations of his new \"<i>friends</i>\" and begins jacking himself off, a dull, glazed look of bliss on his face as his huge horse dong visibly worms in his grasp.  ", false);
		
		//- [Normal (with worms...) semen production]: 
		if (player.cumQ() < 1000) outputText("His obscenely wriggling sack bounces against his ass with his thrusts as pre and worms flow down the sides of his dick, his enhanced balls not hindering his desperation to cum for the worms as he jacks himself harder and harder. The cum you pumped into them has swollen them to the size of large watermelons, the squirming parasites turning his balls into worm-factories as you watch him with a dazed sense of pride. His pre leaks out slowly, dropping the occasional worm or two onto his chest as the beast eagerly picks up the pace, and the dribbles turn into a steady stream as the minotaur grits his teeth, his sack tightening against his groin.\n\n", false);
		//- [High semen production( messy orgasms perk, large balls, whatever)]:
		else if (player.cumQ() < 5000) outputText("His hugely bloated balls drape over his asshole, their sheer size spreading his legs apart and forcing him to lie on his back to masturbate. The mammoth balls in his outstretched sack are bigger than his head, about the size of beach balls as they pump a steady stream of worms and cum down the minotaur's horse-shaft, dribbling on his muscled chest lewdly as he brings himself back to his peak.\n\n", false);
		//- [Maximum/enhanced cum production(marae's gift: stud, elven bounty, spamming a shitload of succubus dream on debug mode, etc.)]: 
		else outputText("the beast's obscenely bloated balls actually lift his legs into the air as he jacks off, each nut almost as big as the minotaur's entire torso! You chuckle to yourself, impressed with your massive load and the additional swelling your pets provide as you watch his balls churn deliciously with their infested cargo, working to turn this bull into a worm-producing, cum-spraying, hyper-productive sex factory. Cum and worms pour out of the beast's cum-nozzle in what you assume to be his orgasm, splattering his chest and face obscenely with the squirming white goop. But you realize that this must just be a mere spurt of \"<i>pre-cum</i>\" as the beast soon arches his back and jacks harder and faster, his real orgasm fast approaching.\n\n", false);
		
		//scene finishers:
		//(normal and high cum production finish): 
		if (player.cumQ() < 5000) outputText("The beast cums, spraying a thick stream of infested jizz straight up into the roof of the cavern, causing wormy cum to rain down all over the both of you. The stream continues for several minutes, turning the entire interior of the cave white with worms and cum until the minotaur's eyes roll back into his skull.  He pants and drools as his new friends coat every inch of him. You shudder in arousal as some of his worms work their way back inside your own " + player.cockDescript(x) + " and travel down to your " + player.ballsDescriptLight() + " re-filling your spent reserves while you rise and walk over to the infested beast, who is barely conscious, utterly insensate from the constant stream of bliss coming from his cock.  It finally dies down and slows to a trickle. Planting a kiss upon his worm-covered forehead, you chuckle and leave him to his fate as a horny and insatiable parasite-spreading animal.\n\n", false);
		//(maximum/enhanced cum production finish): 
		else {
			outputText("The beast roars as his hideously swollen nuts churn, an absolute deluge of infested jism blasting from his squirming horse-cock and actually pushing the minotaur forward from the massive nut-pressure. Every muscle in the bull-man's body seizes as the endless stream literally begins flooding the cave, inch after inch of squirmy cum pooling on the floor until it's up to your ankles and pouring out of the cave's entrance like an obscene river. As his flow tapers off, the minotaur suddenly bucks his hips into the air as a second spurt begins, his sack beginning to shrink a bit as gallons and gallons pour from the cave down the side of the mountain. Watching your infested toy launch blast after blast against the cave walls is satisfying beyond measure, and you feel the worms build back up in your own " + player.ballsDescriptLight() + ", readying your perverted anatomy to spread the infestation once more. The bull's last shot tapers down to a drizzle, his balls shrunken to the point where he can at least walk with his new \"<i>friends</i>\" without tripping over his enhanced cum-factories. Laying in a three-inch cum flood, the infested minotaur promptly passes out in the wake of his gargantuan orgasm.\n\n", false);
			
			outputText("You walk over and pull him up against the wall, not wanting your sex beast to drown in his own jizz in his exhausted slumber. Chuckling slightly, you leave him and walk to the mouth of the cave, before a sudden noise from down the mountain catches your attention. The entire slope of the mountain below the minotaur's cave is glazed white with wormy cum, and you can't help the hysterical laughter that bellows from your lungs as you look down to see a couple of imps and a hellhound struggling fruitlessly against the newly released colony of worms, their dicks and balls bulging and swelling as the multitudes of parasites force their way into them. As you walk back to camp, you hear their terrified squeals turn into ecstatic howls and glance over your shoulder, seeing geysers of thick cum shoot into the air far behind you. You smile and pat your infested nuts, proud of the work of your vile symbiotic pets and resolving to let them loose on some unsuspecting prey again sometime...", false);
		}
	}
	else {
		//--MINOTAUR URETHRAL PENETRATION--
		//(If your cock is 4 inches or less in width, but 2 or more feet long)
		outputText("Overcome with lust and fatigue, the minotaur falls to the ground as you unhurriedly remove your " + player.armorName + ". The minotaur's eyes roam all over your body, his massive cock hard and throbbing. You slowly begin to stroke your own hard cock, pre-cum beginning to drool thickly from the head and over your hand. You slide your hand up and down your long shaft, lubing it with your juices as you decide what to do with the fallen brute before you. An idea forms in your mind and your cock throbs with anticipation, your imagination already working out the entertaining details.\n\n", true);
		outputText("With a hand covered in pre-cum, you roughly grab his fat prick and you smear it onto his flared cockhead, feeling it throb in your hand from the sensation. You press the head of your " + player.cockDescript(x) + " against his and start rubbing it slowly in circles, spreading your sweet pre all over its flared tip while your other hand slowly strokes his tool. The minotaur closes his eyes, enjoying the feeling of your hand and " + player.cockDescript(x) + " rubbing against his own. It's then you make your move. You suddenly shove your " + player.cockDescript(x) + " hard against the wide head of his equine-like prick. Naturally finding the only hole available, your " + player.cockDescript(x) + " slides straight into his urethra fully on the first rough thrust. The minotaur's eyes open wide in surprise and he moos loudly at the abrupt stretching of his cock-hole. His moos quickly turn to grunts as you thrust into him, but you remain unconcerned whether or not he is in pleasure or pain, only interested in the tight hole wrapped firmly around your " + player.cockDescript(x) + ".\n\n", false);
		outputText("The minotaur's grunts slowly turn into moans of pleasure as his body gives in to the stretching you're giving him, even making occasional thrusts towards you in an attempt to fit more of you into him. You smirk at the way you've managed to make this mighty beast into just another fuck toy for you to enjoy. As he thrusts at you again, you decide to oblige him. You firmly grasp the flared head of his cock with both hands and yank his cock onto yours even further. It presses into your groin and you feel a tight pressure at the tip of your " + player.cockDescript(x) + ". You shove once more, only to feel a hot liquid coat the head of your " + player.cockDescript(x) + ". Looking down, you realize your entire length has filled and even surpassed his own - the warm liquid splashing your head with each hard thrust as thick cum boils up from inside him! You continue to pound your " + player.cockDescript(x) + " into his and with aid from his hot sperm covering its head, your orgasm quickly approaches. You eagerly double your speed and before long, you slam your " + player.cockDescript(x) + " as deep as you can into him and unleash your seed directly into his urethra. You realize with a smile (and a groan from the minotaur) that his watermelon-sized balls and prostate could get quite a stretching, but the thought is quickly pushed aside as loads of cum pour out of you in mighty spurts. With each consecutive outpouring of jizz, you feel his balls swelling bigger and bigger until you've unloaded your last drop.\n\n", false);
		outputText("You survey the results of your orgasm, quite pleased and more than a little bit proud. His balls have swollen grotesquely, now so large that he will have difficulty moving. The minotaur groans in pain and it occurs to you that in his current state he can't manage to cum either. As you pull your spunk covered cock free from his now gaping urethra, another wicked thought comes to your mind. You shove the minotaur so he lands on his chest. His ass sticks out in the air and his legs are spread wide, hips held high from the beach ball sized balls underneath him. You reach underneath him and pull his cock back towards you, leaving it pressed snug against the ground with his heavy balls pinning it down. The cock-hole still gapes lewdly from the pounding you gave it, a slow oozing of your cum flowing back out. You run your hand over your cock to gather up the cum coating it then reach down and smear it over his tight asshole, feeling it pucker and clench against your fingertips. You continue smearing it until your semen has coated it liberally. You smack his ass hard, then turn around and holler as loud as you can, knowing it will interest every horny creature within earshot. You look back once at the minotaur and see his eyes wide with fear as he starts mooing, desperate to get out of the predicament he is in. You hesitate, seeing such an inviting target, but you tire from your performance and you leave the struggling creature to the inhabitants of the mountain.\n\n", false);
		outputText("You know that he won't be able to leave or put up much of a struggle until he's managed to cum, but with his balls pinning his cock down, that could be a while. Meanwhile, his raised ass and stretched urethra invite everyone around to take a turn.", false);
	}
	player.orgasm('Dick');
	combat.cleanupAfterCombat();
}

private function minoRapeIntro():void {	
	spriteSelect(44);
	clearOutput();
	//Monster got ass whupped
	if (monster.HP <= 0) {
		outputText("You roll the barely conscious beast over, lifting his ass up above his knees.  The loincloth flops open, giving you a perfect view of his hardening member.  In most ways it looks like a horse's dick, though it seems to be textured with multiple rings of prepuce along its length.  The scent boiling off that marvelously thickening endowment is pleasant yet musky, and overpoweringly strong.", true);
		//Vagina or not flavor texts		
		if (player.vaginas.length > 0) outputText("  Glancing back at you with hope in his eyes, the minotaur's " + monster.cockDescriptShort(0) + " twitches as he lays his gaze upon your " + player.vaginaDescript(0) + ".", false);
		else outputText("  Glancing back at you with eyes full of despair, the minotaur seems to realize you won't be helping the predicament his " + monster.ballsDescriptLight() + " are in.", false);
	}
	//Monster lost to lust
	else {
		outputText("You rip off the minotaur's loincloth with a savage grin, slapping his ass and admiring the jiggle of his " + monster.ballsDescriptLight() + " as they wobble from the force of your blow.  The cow-man moos softly with desire, ropes of pre splattering the ground from his arousal.   The musk pouring off him and his puddle of slick pre-cum is overpowering, making it difficult to think as you feel your blood rush to your groin ", false);
		//NIPPULAR ENJOYMENT
		if (player.totalNipples() > 1) outputText(" and nipples", false);
		outputText(".", false);
		//Vagina or not flavor texts
		if (player.vaginas.length > 0) outputText("  Glancing back at you with hope in its eyes, the minotaur's " + monster.cockDescriptShort(0) + " twitches as he lays his gaze upon your " + player.vaginaDescript(0) + ".", false);
		else outputText("  Glancing back at you with eyes full of despair, the minotaur doubts you'll help relieve the predicament his " + monster.ballsDescriptLight() + " are in.", false);
	}
}
//Man buttrapes a minotaur butt.
private function bumRapeaMinotaur():void {
	spriteSelect(44);
	var x:Number = player.cockThatFits(monster.analCapacity());
	minoRapeIntro();
	outputText("\n\nYou droop your ", false); 
	//Regular or multi...
	if (player.cockTotal() == 1) outputText(player.cockDescript(x), false);
	else outputText(player.multiCockDescriptLight(), false);
	outputText(" across his upraised backside, ", false);
	//pre-cum descriptions
	if (player.cumQ() < 25) outputText("dribbling a bit of slick pre-cum into his fur.  ", false);
	if (player.cumQ() >= 25 && player.cumQ() < 250) outputText("leaking thin ropes of pre-cum over his muscular ass.  ", false);
	if (player.cumQ() >= 250 && player.cumQ() < 500) {
		outputText("drizzling his ass with thick ropes of pre-cum.  You make sure to coat his tailhole liberally, ensuring plenty of lubrication.  ", false);
		monster.ass.analWetness++;
	}
	if (player.cumQ() > 500) {
		monster.ass.analWetness += 2;
		outputText("hosing him down with the constant flow of pre-cum produced by your over-sexed maleness.  Thick runners of the stuff coat his asshole, some dripping down his thighs, and the rest slicking the tumescent monster between his legs.  ", false);
	}
	//Unfinished minotaur cum addiction hook goes here?
	outputText("You gently squeeze his swollen balls as you align yourself with his pucker, breathing deeply as his musk intensifies, feeling dizzy and giddy.", false);
	//New paragraph for penetration.
	outputText("\n\n", false);
	outputText("With little warning, you push inside, amazed to feel his sphincter relax completely.  Pushing forward with ease, you slide all " + num2Text(Math.round(player.cocks[0].cockLength)) + " inches into him, bottoming out completely, feeling each beat of your victim's heart massage your " + player.cockDescript(x) + " inside his rectum.  Each beat sends a rhythmic contraction through the minotaur's backside, working forwards and with arousing intensity.  Between the sensations squeezing your " +  player.cockDescript(x) + " and the intoxicating musk filling your head, you lose control, your hips pistoning rapidly of their own accord, pumping harder and harder with every thrust, exhausting your body as you overexert yourself.\n\n", false);
	outputText("At last you feel the pressure of your climax approaching, spurring you on to jackhammer the mino's poor abused tail-hole even more brutally. ", false);
	if (player.cumQ() <= 25) {
		outputText("With long deep strokes you bury your " + player.cockDescript(x) + " inside him, jizz spurting into his backside.  The bull-man moans in helpless pleasure and pain as he continues jerking himself, unable to cum.  Eventually you pull away with a satisfied sigh.  The minotaur is a mess, still masturbating furiously and helpless with desire to orgasm.", false);
		player.orgasm('Dick');
	}
	if (player.cumQ() > 25 && player.cumQ() <= 250) {
		outputText("With long deep strokes you bury your " + player.cockDescript(x) + " inside him, pumping thick globs of cum into his deep monstrous rectum.  You feel the slick hotness around your " + player.cockDescript(x) + " as you finish pumping a few long last blasts into him.  The minotaur is a mess, masturbating furiously and dripping with pre-cum, on the edge of orgasm.  It looks like he might even manage to get himself off with enough time.", false);
		player.orgasm('Dick');
	}
	if (player.cumQ() > 250 && player.cumQ() <= 500) {
		outputText("With long deep strokes you bury your " + player.cockDescript(x) + " inside him, groaning as your own pressure releases, violent muscular contractions forcing out long blasts of seed.   By the second or third squeeze you can feel the slick hotness begin to fill back around your still-orgasming cock.  A few more pleasurable squeezes later you feel cum squirt out of the minotaur with every pulse of your manhood.  The beast twitches beneath you, gripping you like a vice as his own orgasm is unleashed.  His ass seems to milk your " + player.cockDescript(x) + " of any remaining seed as he squirms, explosively orgasming against the ground. You feel the stuff splatter against your legs as his " + monster.ballsDescriptLight() + " empty, the strong scent making you swoon dizzily, euphoric with the minotaur's drug-like cum-musk and your own orgasm.\n\nEventually you pull free, giggling in pleasure as your victim falls unconscious in a small lake of his own spooge. ", false);
		player.orgasm('Dick');
		dynStats("lus", 10+player.lib/10);
	}
	if (player.cumQ() > 500) {
		outputText("With long deep strokes you bury your " + player.cockDescript(x) + " inside him, your body trembling as the building pressure of your orgasm peaks, at last allowing you erupt a thick river of jism inside your victim.  You feel it back-flow around your " + player.cockDescript(x) + " with the first spurt, lubricating the passage as your first blast finally tapers off.  A moment later you begin the next, filling his rectum as your cum begins to drool out and down his thighs and " + monster.ballsDescriptLight() + ".  Each successive blast makes more and more of your spunk squirt free from his backside, distending his belly slightly from the quantity and pressure.  You squeeze your eyes closed from the pleasure, tongue hanging out of your mouth in a dopey, pleasure-filled haze, as you feel him tense underneath you.  His ass clamps down hard on your " + player.cockDescript(x) + " squeezing out an even thicker flow from you, even as you feel his balls tremble with the beginnings of his own orgasm.  With an explosive splattering sound, you hear him begin cumming, his " + monster.ballsDescriptLight() + " shrinking as they empty out on the ground, splattering everywhere, and coating the minotaur and your bottom half with seed.  The scent of the minotaur's musk seems to triple in the air, making it difficult to stand, but easier to keep cumming, distending the minotaur's belly until he looks very pregnant.\n\nWith an ecstatic sigh you pull free, stumbling away as the minotaur passes out in a lake of his own spooge.  You attempt to clean yourself up, licking your fingers and swooning from the heavenly taste as it fills your mind with a fog of lust.", false);
		player.orgasm('Dick');
		dynStats("lus", 15+player.lib/7);
	}
	combat.cleanupAfterCombat();
}
private function girlRapeAMinotaur():void {
	spriteSelect(44);
	minoRapeIntro();
	player.slimeFeed();
	minoCumAddiction(5);
	outputText("\n\nWith a quick shove, you roll the panting minotaur onto his back, exposing his pulsing " + monster.cockDescriptShort(0) + " to the open air.  A simple flourish later, you peel back your " + player.armorName + " to expose your " + player.vaginaDescript(0) + ", already wetter than usual from the scent in the air.   You walk forward, straddling the oblivious minotaur as he masturbates furiously, muscles bulging with exertion and covered in sweat.  Your eyes zero in as a dollop of pre escapes his ribbed horse-like member, locating the source of the scent.\n\n", false);
	//Too small
	if (player.vaginalCapacity() < monster.cockArea(0)) {
		outputText("Restraint evaporates as you lower yourself, your aching " + player.vaginaDescript(0) + " desperate for contact.  Your thighs quiver as you touch his wobbling column of maleness, the slick pre-cum soaking into your engorged clitty, filling it with tingling warmth.  Oblivious to the apparent size difference, your body pushes downwards, your knees giving out, forcing his flared head against your " + player.vaginaDescript(0) + " roughly.  The need to be speared on the beast's meat is overwhelming urged on by constantly leaking pre-cum currently pumping into your love-canal.  With strength born of unnatural lust, you grip his flanks and drive yourself downwards, feeling yourself stretch painfully as you take in his length.  ", false);
	}
	//Good match
	if (player.vaginalCapacity() >= monster.cockArea(0) && player.vaginalCapacity() < monster.cockArea(0) * 1.5) {
		outputText("Restraint evaporates as you lower yourself, your aching " + player.vaginaDescript(0) + " desperate for contact.  Your thighs quiver as you touch his wobbling column of maleness, the slick pre-cum soaking into your engorged clitty, filling it with tingling warmth.  You push downwards eagerly, happily noting that you should be able to accommodate his length and girth.  The overly wide head slips inside, easily lubricated with his copious fluids, musky pre-spunk lubricating your passage with its intoxicating sensation.  With deliberate slowness, you sink down along his shaft, shuddering once, twice, then three times as you pass each of the thick fleshy rings along his length.  Eventually, you bottom on him.  ", false);
	}
	//Bigger than he is
	if (player.vaginalCapacity() >= monster.cockArea(0) *1.5) {
		outputText("Restraint evaporates as you lower yourself, your aching " + player.vaginaDescript(0) + " desperate for contact.  Your thighs quiver as you touch his wobbling column of maleness, the slick pre-cum soaking into your engorged clitty, filling it with tingling warmth.  With a lusty giggle you slip his head inside your " + player.vaginaDescript(0) + ", allowing him to drool his musky pre-seed deep inside your wide love-canal.  Sinking down slowly, your easily encompass all of his equine-like member, enjoying the feeling of his three thick cock-ridges as they slip through your lips.  Eventually you take all of him, wishing he was just a bit bigger...", false);
	}
	//Resume sexings, p2
	outputText("\n\nAt last you feel the minotaur's meaty hands grab you by the ", false);
	if (player.isTaur()) outputText("hindquarters, forcefully grinding your vagina along his length like a toy.  ", false);
	else outputText(player.hipDescript() + ", forcefully grinding up and down along his length like a cheap sex-toy.  ", false);
	//Size variants
	//Too small
	if (player.vaginalCapacity() < monster.cockArea(0)) outputText("Every ridge of his " + monster.cockDescriptShort(0) + " presses tightly against your walls, smearing more of his wondrous pre-seed into your body with every stroke.  ", false);
	//Just right
	if (player.vaginalCapacity() >= monster.cockArea(0) && player.vaginalCapacity() * 1.5 < monster.cockArea(0)) outputText("Every stroke of his " + monster.cockDescriptShort(0) + " deposits a bit more of his wondrous preseed into your body, spreading a relaxing warmth throughout your groin.  ", false);
	//Too big
	if (player.vaginalCapacity() *1.5 >= monster.cockArea(0)) outputText("Every stroke of his " + monster.cockDescriptShort(0) + " slides easily into your " + player.vaginaDescript(0) + ", allowing him to slowly build up a puddle of his wondrous druggy pre-seed into your aching womb.  ", false);
	//Resume!
	outputText("The minotaur picks up the pace, heartbeat thudding through his rigid meat, making it convulse and vibrate as he slams you down on it over and over again.  You feel his balls twitching against your ass as his cock visibly thickens, bulging out at the base and slowly fattening inside you until it feels fit to burst.  With a throaty roar he cums at last, fountaining seed directly into your womb.  Your eyes roll back as it fills you, swooning as you feel the liquid pleasure seeping into you.  Your " + player.vaginaDescript(0) + " clamps down, trapping his seed inside, his orgasm dragging on as his balls begin to shrink.  The copious fluid fills your womb, distending your belly painfully.  The minotaur gives one last powerful spurt, the force pushing you off his " + monster.cockDescriptShort(0) + ", just as you both reach total sexual satisfaction.\n\n", false);
	//Check for stetchiness!
	player.cuntChange(monster.cockArea(0), true);

	//ITS OVER
	outputText("He passes out with a contented sigh, balls shrunk down to the size of baseballs and his cock still dribbling cum.  You pull yourself to your feet unsteadily, drunk with pleasure as you stagger away, clamping your " + player.vaginaDescript(0) + " down unconsciously to hold in his wonderful seed.", false);
	if (player.vaginalCapacity() < monster.cockArea(0)) outputText("\n\nMixed with the sheer sexual pleasure, you feel a diffuse pain and numbness coming from your much-abused " + player.vaginaDescript(0) + ", but decide with a smile that it was well worth it as his cum numbs away the last of the pain.", false);
	player.orgasm('Vaginal');
	dynStats("spe", -.5, "int", -.5, "sen", 1.5, "cor", 1);
	//Preggers chance!
	player.knockUp(PregnancyStore.PREGNANCY_MINOTAUR, PregnancyStore.INCUBATION_MINOTAUR);
	combat.cleanupAfterCombat();
}
private function minotaurGetsRapedByHerms():void {
	spriteSelect(44);
	minoRapeIntro();
	minoCumAddiction(5);
	player.slimeFeed();
	outputText("\n\nWith little care for the beast's feelings, you grip his cock with both hands, pulling it towards yourself, bending it up at an awkward angle that makes him give a trembling moo of pain.   You edge closer, your own " + player.cockDescript(0) + " bumping into his pucker, his obscene equine-like cock dripping that wonderfully scented spunk as you pull it to your " + player.vaginaDescript(0) + ", smearing it against your cunt-lips.\n\n", false);
	outputText("With a twisted grin and a grunt of pain, you push forward, slipping his " + monster.cockDescriptShort(0) + " into your " + player.vaginaDescript(0) + " as your " + player.cockDescript(0) + " penetrates his tight but accommodating back-door.  You immediately feel a surge of his pre-cum squirt into you as you push forward, forcefully spearing yourself AND him at the same time.  The slick fluids spread warmth through your groin, making you feel light-headed and horny at the same time, spurring you to force the last of both cock-lengths into their respective holes.\n\n", false);
	temp = player.vaginas[0].vaginalLooseness;
	player.cuntChange(monster.cockArea(0), true);
	if (player.vaginas[0].vaginalLooseness < VAGINA_LOOSENESS_GAPING) outputText("A small suppressed part of your mind dimly registers that this should be fairly painful, but the lust and drug-like pre-cum wash that thought away with waves of pleasure.  ", false);
	if (player.vaginas[0].vaginalLooseness >= VAGINA_LOOSENESS_GAPING) outputText("The intense feelings seem to grow more and more powerful as he stays inside you, his drug-like pre-cum making your " + player.vaginaDescript(0) + " tingle from the inside-out.", false);
	outputText("Your " + player.cockDescript(0) + " quivers from his tightness, each beat of his powerful heart squeezing you tightly in his rear passage.   Through your foggy mind, you come to realize that your hips are pistoning against him with disturbing speed, burning away what's left of your reason with white-hot lust and minotaur spunk.  You slap his ass as you fuck him, humiliating the beast, leering down at him as he moos and moans hopelessly.   At last the pleasure overwhelms you, and you fire your spunk into him like a cannon, your hips still fucking him with unthinking determination.   Jizz sputters from his tail-hole with each thrust, splattering over his ass-cheeks.  A sudden blast of inhuman warmth fills you as the beast begins to cum, huge blasts pouring directly into your womb with every thrust of monstrous meat into your " + player.vaginaDescript(0) + ".\n\n", false);
	outputText("Your orgasms drag on, until at last your belly is distended with the stuff and his ass is full of your cum.  With a lurch and a pop, you stagger free of him, barely able to walk with so much of his heavenly spunk inside you.  Even now your body tingles with unnatural pleasure and warmth.  Giggling, you realize the beast is passed out at your feet, his balls half as big as before. ", false);
	player.orgasm('Vaginal');
	dynStats("spe", -.5, "int", -.5, "sen", 1.5, "cor", 1);
	//Preggers chance!
	player.knockUp(PregnancyStore.PREGNANCY_MINOTAUR, PregnancyStore.INCUBATION_MINOTAUR);
	combat.cleanupAfterCombat();
}

public function minoPheromones():void {
	spriteSelect(44);
	outputText("The minotaur smiles at you and lifts his loincloth, flicking it at you.  Thick ropes of pre-cum fly through the air, ", false);
	//sometimes get hit with the pre for stronger effect!
	if (rand(3) == 0) {
		outputText("slapping into your face before you can react!  You wipe the slick snot-like stuff out of your eyes and nose, ", false);
		if (player.lust > 75) {
			outputText("swallowing it into your mouth without thinking.  ", false);
			dynStats("lus", 10 + player.lib/10);
		}
		else {
			outputText("feeling your heart beat with desire as your tongue licks the residue from your lips.  ", false);
			dynStats("lus", 5 + player.lib/20);
		}
	}
	else outputText("right past your head.  ", false);
	outputText("The animalistic scent of it seems to get inside you, the musky aroma burning a path of liquid heat to your groin.", false);
	dynStats("lus", 10 + player.lib/20);
	if (player.findPerk(PerkLib.MinotaurCumAddict) >= 0 || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) {
		if (rand(2) == 0) outputText("\n<b>You shiver with need, wanting nothing more than to bury your face under that loincloth and slurp out every drop of goopey goodness.</b>", false);
		else outputText("\n<b>You groan and lick your lips over and over, craving the taste of him in your mouth.</b>", false);
		dynStats("lus", 5+rand(5));
	}
	//YOU LOSE!
	if (player.lust >= player.maxLust())
		doNext(getGame().combat.endLustLoss);
	else doNext(getGame().combat.combatMenu);
}
public function getRapedByMinotaur(autoRape:Boolean = false):void {
	spriteSelect(44);
	player.slimeFeed();
	clearOutput();
	//BY BUTTS MCGEE
	//====================================================================
	//((This would be a Minotaur Loss Rape if the PC fulfills either of the following conditions.))
	//{CHECK: If male PC with big butt (Over... I have no idea what butt numbers are), use this}
	//{CHECK: If female or herm PC with big butt and vagina too small to fit minotaur cock, use this}		
	if (!autoRape)
	{
		if (doSFWloss()) { //No rape in SFW mode.
			combat.cleanupAfterCombat();
			return;
		}
		if (rand(2) == 0 && player.buttRating >= 15 && player.vaginalCapacity() < monster.biggestCockArea() && player.tone < 60) {
			getMinoHawtDawged();
			return;
		}
		//Oral rape chance
		if (rand(2) == 0 && !player.isTaur()) {
			getOralRapedByMinotaur();
			return;
		}
	}
	else
	{
		outputText("As you take the winding path up through the rocky trail, you come upon the opening to a cave. Peering inside, the stench of an overpowering musk washes over you. The primal scent excites you, causing you to become aroused almost immediately.  Not thinking as clearly as you normally might, you slowly sneak your way into the cave. Signs of life litter the cave floor.\n\n", true);
		dynStats("lus", 10 + player.lib / 5);
		
		//Detect minotaur coming
		if (rand(30) + player.inte / 5 > 18 || flags[kFLAGS.SFW_MODE] > 0)
		{
			outputText("You spot a shadow moving and spin around to see a minotaur lumbering after you from the back of the cave!", false);
			if (flags[kFLAGS.CODEX_ENTRY_MINOTAURS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_MINOTAURS] = 1;
				outputText("\n\n<b>New codex entry unlocked: Minotaurs!</b>")
			}
			startCombat(new Minotaur());
			return;
		}
		
		outputText("Suddenly you're grabbed from behind, your arms held together by a single massive, furry hand. A heavy, snorting breath brushes the top of your head. You turn your neck to see a massive bull-man. His impressive dick presses ", false);
		
		if (player.isTaur())
		{
			outputText("against your buttocks", false);
		}
		else
		{
			
			outputText("into the small of your back", false);
		}
		
		outputText(" as it grows larger and harder, smearing its pre-cum into your skin and making you shiver.  ", false);
		//High str escape
		if (/*rand(20) + player.str / 3 > 18*/ true || flags[kFLAGS.SFW_MODE])
		{
			outputText("\n\nYou twist around using the additional lubrication and squirm free!  Rolling away, you come up in a crouch, ready to fight!", false);
			startCombat(new Minotaur());
			return;
		}
	}
	
	if (doSFWloss() && getGame().inCombat) { //No rape in SFW mode.
		combat.cleanupAfterCombat();
		return;
	}
	//Normal RAEP
	if (player.vaginas.length > 0) {
		outputText("The bull-man roughly grabs your hair and begins rubbing the flared head of his penis along your " + player.vaginaDescript(0) + ".  ", false);
		if (player.averageVaginalWetness() < 2) outputText("You aren't very wet, and fear the damage this beast will inflict on your " + player.vaginaDescript(0) + ".  ", false);
		else outputText("You're shamefully wet by this point, and your knees are ready to buckle.  ", false);
		minoCumAddiction(5);
	}
	//BUTTSECKS!
	else {
		outputText("The bull-man roughly grabs your hair and repositions himself to press against your asshole, slowly building the pressure until suddenly, the flared head pops into you.  ", false);
		player.buttChange(monster.cockArea(0), true);
		minoCumAddiction(15);
	}
	if (player.isTaur()) outputText("\n\nHe positions himself behind your rear legs, and roughly impales you onto his shaft, forcing himself as far into you as he can manage. You cry out, and you feel your stomach distending to accommodate his incredible size. Grabbing your ass, he begins to violently pound your backside with his massive member.  ", false);
	else outputText("\n\nHe lifts you into the air, hefting your insignificant weight with little effort, and roughly impales you onto his shaft, forcing himself as far into you as he can manage. You cry out, and looking down you can see your stomach distending to accommodate his incredible size. Using you like a human cock-sleeve, he simply holds you by the torso and begins lifting you up and down.  ", false);
	
	//Vag stretch texts
	if (player.hasVagina()) player.cuntChange((24 * 3), true, false, true);
	
	//Continue
	if (player.biggestTitSize() > 0 && player.mostBreastsPerRow() > 1 && player.breastRows.length > 0) {
		outputText("He manhandles your tits as he does so, almost violently squeezing and stretching them to his enjoyment.  ", false);
		if (player.biggestLactation() > 1.5) outputText("He then gives a grunt in what you take to be approval as your milk begins to squirt out. He licks a milk-coated finger in satisfaction.  ", false);
	}
	if (player.cockTotal() == 1) outputText("The bull-man bends forward a little, and grabs your " + player.cockDescript(0) + " in a crushing grip. He makes short jerking motions as he keeps thrusting into you.", false);
	if (player.cockTotal() > 1) 	outputText("The bull-man bends forward a little, and grabs one of your " + player.cockDescript(0) + "s in a crushing grip. He makes short jerking motions as he keeps thrusting into you.", false);
	if (player.vaginas.length > 0) {
		if (player.vaginalCapacity() < monster.cockArea(0)) outputText("\n\nYou clench your teeth in pain as his thick ribbed cock ravages your tight pussy. After a while, a kind of numbness sets in, and you start to feel dim waves of pleasure piercing through the curtain of pain. You hear grunts of pleasure and satisfaction coming from the beast's mouth.", false);
		if (player.vaginalCapacity() >= monster.cockArea(0) && player.vaginalCapacity() < monster.cockArea(0) * 1.5) outputText("\n\nYou feel his monstrous ribbed cock deliciously rubbing against your love-canal, sending maddening waves of pleasure to your brain as the beast keeps shoving into you. Oblivious to anything but your own enjoyment, you moan loudly like a whore, as the beast chuckles and grunts from his own pleasure.", false);
		if (player.vaginalCapacity() >= monster.cockArea(0) *1.5) outputText("\n\nYou feel his monstrous cock sliding easily in and out of your wide fuck-hole, hearing the beast grunt in dissatisfaction. He suddenly clouts your left buttock, which makes you tense your muscles, including your vagina's, and you start to feel the ribs on his cock rubbing against your wall. The pleasure it procures you makes you tense your muscles harder, causing the pleasure to swell again. The minotaur grunts in approval, and continues his violent pounding as you start moaning.", false);
	}
	outputText("\n\nFinally, you can feel he's ready to cum. His thrusts become shorter and faster, and just when you think you can't stand it anymore he starts shooting his sperm into you. Your stomach begins to round out from the sheer amount of bull seed being pumped into your belly.  ", false);
	dynStats("lib", 1, "sen", -.5, "cor", 1);
	if (player.vaginas.length > 0) {
		if (player.averageVaginalWetness() >= 2) {
			if (player.averageVaginalWetness() < 4) outputText("You squirm and quiver, orgasming from the beast's rough usage.  ", false);
			if (player.averageVaginalWetness() == 4) outputText("You squirm and quiver, orgasming from the beast's rough usage, soaking him with your " + player.vaginaDescript(0) + ".  ", false);
			if (player.averageVaginalWetness() == 5) outputText("You orgasm on his massive rod, splattering the beast with girlcum.  ", false);
			player.orgasm('Vaginal');
			dynStats("lib", .5, "sen", 1, "cor", 1);
		}
		if (player.averageVaginalWetness() < 2) {
			outputText("You gasp in pain, your cunt rubbed raw by the rough and violent penetration.  ", false);
			dynStats("tou", -.5, "sen", 1, "lus", -5, "cor", 1);
		}
		//Preggers chance!
		player.knockUp(PregnancyStore.PREGNANCY_MINOTAUR, PregnancyStore.INCUBATION_MINOTAUR);
	}
	if (player.cockTotal() > 0 && (player.sens + rand(40) > 50)) {
		outputText("You orgasm, ", false);
		if (player.cumQ() < 25) outputText("spurting your seed helplessly from the brutal rape.  ", false);
		if (player.cumQ() >= 25 && player.cumQ() < 250) outputText("squirting thick ropes of cum over the cave.  ", false);
		if (player.cumQ() >= 250 && player.cumQ() < 500) outputText("erupting potent ropes of seed in thick bursts, splattering the cave walls and floors.  ", false);
		if (player.cumQ() >= 500) outputText("erupting a thick torrent of seed that seems to go on forever, spurred by the constant pressure of the huge minotaur cock.  You paint the cave wall with cum, the beast egging you on as it roughly jacks your " + player.cockDescript(0) + ".  You are vaguely aware of your orgasm dragging on and on, until eventually your orgasm stops, leaving a sizable puddle of cum on the floor.  ", false);
		player.orgasm('Anal');
		dynStats("lib", .5, "sen", 1, "cor", 1);
	}
	outputText("The bull-man relaxes for a moment, then shoves you off of him and to the cold ground. You pass out as a strange sense of euphoria washes over you while copious quantities of monstrous cum escape your distended ", false);
	if (player.hasVagina()) outputText("pussy.", false);
	else outputText("asshole.", false);
	if (getGame().inCombat) combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseFourHours);
}


private function getOralRapedByMinotaur():void {
	spriteSelect(44);
	clearOutput();
	outputText("The huge bull-man grabs you around the waist with one hand and flips you over. You hang upside down in his grip, your " + player.legs() + " splayed in the air.  The minotaur rubs your face across his sweat-slick balls, smearing his musk into your skin. Each of the minotaur's testicles is bigger than a man's head, and the skin of his sack is pulled taut over his cum-filled balls.\n\n", false);
	outputText("The minotaur traps your " + player.legs() + " in one hand and slams your back against the cold cave wall. You gasp, spraying drops of musky sweat from your lips. Dragging you against the rough stone, the minotaur lifts you higher and bends your " + player.legs() + " back over a rock ledge. You are pinned against the cave wall, " + player.legs() + " held in one of the minotaur's hands while his other roughly gropes your stretched-out body.", false);
	if (player.hasBreasts()) outputText("  The bull-man grabs your " + player.biggestBreastSizeDescript() + ", squeezing and mauling them with his calloused hand.", false);
	if (player.cockTotal() >= 1) {
		outputText("  Your " + player.multiCockDescriptLight() + " slap", false);
		if (player.cockTotal() == 1) outputText("s", false);
		outputText(" painfully against your belly as the minotaur drags you along the wall.", false);
	}
	outputText("  All you can see is the minotaur's huge shaft, the tip grinding against your mouth. The minotaur slaps his cock-head against your face, rubbing his musk and pre-cum into your cheeks and hair.\n\n", false);
	//new pg
	outputText("The minotaur reaches down and grabs your jaw, yanking it open. You know what's coming next but decide not to fight it. Submitting to this beast is the safest choice. You spread your jaws as wide as you can and bend your mouth towards the minotaur's monstrous cock-head...\n\n", false);
	//new pg
	outputText("Wasting no time, the minotaur grinds his glans past your lips and tries to force the tip of his " + monster.cockDescriptShort(0) + " into your mouth. Snorting and grunting, he pushes your head against the cave wall as he shoves the tip past your teeth. The minotaur's pre-cum pools in your mouth and dribbles out the corners, leaving trails of slime down your face.  You breathe through your nose, inhaling the minotaur's musk, as the brute forces another fraction of an inch of bull-cock into your mouth. Taking yet another quarter-inch of slimy meat, you wonder if it wouldn't be better to let yourself pass out while the minotaur uses you.\n\n", false);
	//new pg
	outputText("You hear a <i>POP</i> and feel a sharp pain in your jaw as the minotaur forces its full cock-head into your mouth.  The head slides past your jaws and into your mouth, pinning your tongue down and jabbing against the opening of your throat. The flared end of the shaft wedges itself behind your teeth. The minotaur moans, a sound somewhere between a bull calling to its herd and a man groaning in ecstasy. You grab the bull-man's shaft in both hands and brace yourself, trying to pull your head away from the cave wall. The minotaur starts grinding its hips, and with one hand grabs your head and twists it from side to side, rubbing its huge tip around in your mouth.\n\n", false);
	//new pg
	outputText("You arch your back off the wall, resting your weight on the minotaur's " + monster.cockDescriptShort(0) + ". Your chest and belly rub against the minotaur's massive torso", false);
	if (player.hasBreasts()) outputText(", painfully grinding your " + player.nippleDescript(0) + " against his wiry fur", false);
	if (player.balls > 0) outputText(", and you can feel the minotaur's hot breath on your " + player.ballsDescriptLight(), false);
	outputText(". The bull-man snorts and jerks his hips as you twist your hands around his shaft, hoping to make him cum sooner. You tickle your tongue against his cock-head and start sucking as hard as you can. You bend your neck as the minotaur grinds itself in your mouth, hoping to make the tip easier to take. The minotaur jerks his hips in short spasms and you can hear its grunts coming closer and closer together. You take a deep breath through your nose, filling your lungs with air before the beast floods your throat with its cum...\n\n", false);
	//new pg
	outputText("With no warning the minotaur yanks your " + player.legs() + " off of the ledge and grabs your waist. He shoves you down hard on his shaft while slamming his hips forward. Your eyes go wide in shock as the minotaur rams the massive tip of its cock past your mouth and into your throat. Grunting and moaning the minotaur forces its cock into your throat, inch by inch as it grinds you around its shaft. Your throat bulges as the first ridge around the minotaur's cock approaches your lips.\n\n", false);
	//new pg
	outputText("The minotaur bellows and slams its hips forward, forcing the ridge past your lips. You're almost out of air and the edges of your vision are starting to fade. All you can see is the minotaur's belly. Its " + monster.ballsDescriptLight() + " spasm just below your head, pumping hot come through its " + monster.cockDescriptShort(0) + ". The first wave of minotaur cum swells his cock and pushes past your teeth. The bull-man cums deep in your throat, inflating your stomach with hot seed. All you can feel is the minotaur's bloated shaft rammed deep into your throat, blast after blast of thick cum forcing its way down his cock and into your belly.\n\n", false);
	player.refillHunger(50, false);
	//last pg
	outputText("The minotaur grunts a few last times.  Finished with you, it lifts your " + player.leg() + " and pulls you off its " + monster.cockDescriptShort(0) + ". The huge cock-head slides through your throat, gets jammed behind your teeth, and finally pulls free with a loud sucking sound. Cum pours from your throat and over your face, and the minotaur sprays a few final loads across your bloated stomach. The minotaur drops you in the cum-pool and walks away, leaving you to cradle your distended belly and swoon as his drug-like sperm addles your mind.  You pass out with a blissful smile.", false);
	player.orgasm('Lips');
	dynStats("sen", 1);
	minoCumAddiction(10);
	if (getGame().inCombat) combat.cleanupAfterCombat();
	else doNext(camp.returnToCampUseFourHours);
}

private function minoGetsTitFucked():void {
	spriteSelect(44);
	player.slimeFeed();
	if (player.isNaga()) {
		AddictNagaOnMinotaur();
		return;
	}
	//(Rape – titfuck) Requires F+ cup breasts or DD+ breasts on top two rows.  
	clearOutput();
	outputText("The helpless minotaur lays in the dirt, ", false);
	if (monster.HP < 1) outputText("defeated.  ", false);
	else outputText("masturbating uncontrollably.  ", false);
	outputText("He's yours for the moment, and for right now, you want to see if that throbbing horse-cock will splatter its heavenly spunk all over your " + player.allBreastsDescript() + " and " + player.face() + ".  You really could use a fix, just enough to fuzz over all the worry and stress you've had to deal with.\n\n", false);
	if (monster.lust >= monster.eMaxLust()) outputText("You push his hands away and y", false);
	else outputText("Y", false);
	outputText("ou lean over him, feeling your generous breast-flesh jiggle, your " + player.nippleDescript(0) + "s tingling with desire as they rub across the horse-like minotaur dong.   The beast's pre starts forming into large drops along his flared head, and you waste no time smearing it through your cleavage, lubricating the space between your tits and breathing deeply of its perfect scent.", false);
	if (player.totalCocks() > 0) outputText("  Your " + player.cockDescript(0) + " grows harder and more aroused than ever before while your ", false);
	else outputText("  Your body aches with arousal while your ", false);
	if (player.hasVagina()) outputText(player.vaginaDescript(0) + " grows hotter and hotter, begging to be taken.", false);
	else outputText(player.assholeDescript() + " puckers slightly, as if begging to be taken by another monstrous beast.", false);
	outputText("\n\n", false);
	outputText("He moos out pitifully, clearly understanding what you're up to and frustrated he won't get to sate his desire in a tight mortal ", false);
	if (player.hasVagina()) outputText("cunt.  ", false);
	else outputText("ass.  ", false);
	outputText("Out to prove him wrong by letting him release all over your face, you wrap your " + player.allBreastsDescript() + " tightly around him and begin sliding your body along his length.  The constant drizzling pre-cum easily lubricates you, and soon your orbs are shiny and slick with his drug-like fluid.\n\n", false);
	outputText("As you begin shaking your breasts up and down, stroking his length, you feel the skin of his three rings of prepuce sliding the soaked skin of your tits.   You lick around the edge of his crown when it presents itself to your lips, making sure to take in a nice fat dollop of his thick cream.  It makes you dizzy for a moment, and you nearly slide off, but the sensation passes.  You need more.  You squeeze your " + player.allBreastsDescript() + " tighter around him, squeezing out a few more drops as you feel the manhood begin to swell, growing harder and larger as the minotaur's orgasm approaches.\n\n", false);
	outputText("The minotaur's balls clench tightly as the bull-man throws his head back and screams out in pleasure and relief, \"<i>MooooOOOOOOooooOOOOO!</i>\"\n\n", false);
	outputText("You squeeze tightly and press down, watching his dick-head flare out, nearly doubling size before it unloads, drenching your face and hair with his thick narcotic cream.   You manage to get your lips against it in time for the next blast, and nearly drown when it overfills your mouth.   You pull back, coughing, starting to get high, and swaying woozily as more and more cream spatters your body, continuing to be squeezed out by your slick heaving breasts.\n\n", false);  
	outputText("The bull-man relaxes at last, drenching you with one last wave before he passes out.  You stagger up and nearly trip over your legs, giggling and drunk on cow-spunk as you noisily slurp down the fluids drenching your face and hair.  You black out for a while...\n\n", false);
	outputText("You wake up an hour later, unsure how you made it back to your camp, light-headed and euphoric with the lingering after-affects.  You also find a bottle on the ground next to you, filled to the brim with the fluid.  You don't remember filling it up, but you're already itching to pop it open and guzzle it down.  You manage to resist the urge.  Besides, you're still feeling GREAT from your last 'sample'.", false);
	minoCumAddiction(10);
	monster.short = "tit-fucked Minotaur";
	player.orgasm('Tits');
	dynStats("sen", .5, "cor", .7);
	combat.cleanupAfterCombat();
}

//(Direct Injection) – GIGITY!
private function takeMinoCumDirectly():void {
	spriteSelect(44);
	clearOutput();
	outputText("Relishing your victory, you breathe deeply, shivering and stretching.  ", false);
	if (monster.HP < 1) outputText("The beast-man has fallen on his back, comatose and insensate, though his shaft has risen to full erectness, displacing his loincloth.", false);
	else outputText("The beast-man is on his back with his legs splayed, masturbating hopelessly.  His anguished moans tell you all you need to know – he'll never get off alone.", false);
	outputText("  You smile, blushing in anticipation, readying yourself for the coming bliss.\n\n", false);
	
	outputText("You shed your " + player.armorName + " and step over its waist, trembling slightly with anticipation of your next fix.  Taking his flared drug-nozzle in hand, you hold it steady and lower yourself down, feeling his slippery narcotic pre-cum smearing over your hole.  ", false);
	//Too tight!
	if (player.analCapacity() < monster.cockArea(0)) {
		outputText("You have to push harder and harder to get it inside you, even with the copious lube's drug-like affects relaxing your sphincter.  The penetration is slow, but inch by inch you force it inside you.", false);
	}
	else {
		outputText("Your muscles instantly relax on contact with the pre, and you feel the massive tool sliding up your spacious asshole with ease.", false);
	}
	if (!player.buttChange(monster.cockArea(0), true)) outputText("  ", false);
	outputText("The minotaur's eyes open wide as he lets out a lustful '<i>Moooooo</i>'.  He doesn't struggle or even move – you're giving him exactly what he wants, after all.\n\n", false);

	outputText("You bottom out, sighing happily as you feel his hot fluids leaking inside you, radiating pure pleasure out from your core.   Bestial hands grab your " + player.nippleDescript(0) + "s and begin gently twisting them, taking surprising care for all their strength.  Spurred on by the feelings radiating from your ", false);
	if (player.biggestTitSize() < 1) outputText("chest", false);
	else outputText(player.breastDescript(0), false);
	outputText(" and hungry for even more bliss, you begin bouncing atop the defeated beast, repeatedly squeezing and relaxing yourself around him, trying to wring out the maximum possible amount of fluid.\n\n", false);
	
	outputText("A flood of heated liquid pumps into you all at once as the minotaur caves in to your full-body stroking and squeezing of his massive shaft.   It swells inside you, pulsating a moment just before the next jet unloads into you.  You giggle uncontrollably as the effects of the ever-increasing spooge-load spread to your brain.  It feels as if your thoughts are struggling through cotton-candy, a pleasant pink fuzz that makes it hard to do anything but drool happily as you're pumped full of the drug you crave.\n\n", false);
	
	outputText("You zone out, dimly aware of your hands roaming over your body in a wave of orgiastic sensations.  The uncomfortable feeling of being packed so full is completely masked by the artificial drug that fills every pore of your body, and you keep bouncing not realizing that the minotaur has finished cumming.  You find yourself wishing life could be like this for every moment of every day, blissful and pleasure-filled.\n\n", false);
	
	outputText("An hour or so later, you pick yourself up out of a puddle of mud that reeks of sex.  Still feeling groggy and euphoric, you get dressed, not bothering to clean up.  You have to work to keep your " + player.assholeDescript() + " clenched, lest you lose some of the drug making you so happy.", false);
	//(-80 lust, then + 25, +(1-5 sensitivity based on current level), +corruption)
	dynStats("sen", 1, "lus", -80, "cor", 1);
	//A bit of post happy arousal
	dynStats("lus", 25);
	//bonus sensitivity if unsensitive.
	if (player.sens < 80) dynStats("sen", 1);
	if (player.sens < 60) dynStats("sen", 1);
	if (player.sens < 40) dynStats("sen", 1);
	if (player.sens < 20) dynStats("sen", 1);
	//+15 addiction
	minoCumAddiction(15);
	combat.cleanupAfterCombat();
}

private function minoCumAddiction(raw:Number = 10):void {
	player.minoCumAddiction(raw);
}

public function minoCumUpdate():Boolean {
	if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] == 0) return false;
	var output:Boolean = false;
	//Your addicted enough for it to be official!
	if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 0 && flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 50) {
		outputText("\nYou find yourself becoming aroused at the merest thought of minotaurs and their delicious cum.  Immediately you remember how great it made you feel, and you want more.  <b>You're now addicted to minotaur cum!</b>\n", false);
		flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 1;
		output = true;
	}
	//If under 50, clear addiction and stuff
	if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] < 50) {
		//Clear addiction if addicted!
		if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 0) {
			//Clear addiction text
			outputText("\n<b>For the first time in a long while, your head is clear and devoid of the unnatural need for minotaur cum. You've overcome your dependance on it, ", false);
			if (player.cor > 60) outputText("but miss the tingling apathy and fuzziness that filled your head every time one of them was squirting inside you.", false);
			else outputText("and resolve to give the beasts a wide berth from now on.", false);
			outputText("</b>\n", false);
			flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 0;
			output = true;
		}
		if (flags[kFLAGS.MINOTAUR_CUM_RESISTANCE_TRACKER] >= 150 && player.findPerk(PerkLib.MinotaurCumAddict) < 0 && player.findPerk(PerkLib.MinotaurCumResistance) < 0) {
			flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] = 0;
			flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 0;
			player.createPerk(PerkLib.MinotaurCumResistance, 0, 0, 0, 0);
			outputText("\n<b>You have finally learned enough about how to avoid getting addicted to Minotaur Cum again; you are now immune to the addictive properties of Minotaur Cum.</b> (You can never get addicted to Minotaur Cum.)\n", false);
			output = true;
		}
	}
	//If over 50, addicted, become addicted, withdrawl, etc
	else {
		//Recover if fed during need or want.
		if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] > 1 && flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] < 24) {
			outputText("<b>\nYou sigh happily before you return to camp.  You got just what you needed.</b>\n", false);
			flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 1;
			output = true;
		}
		//Go into 'need' if its time.
		if (flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] >= 24 && flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 1) {
			flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 2;
			output = true;
			flags[kFLAGS.MINOTAUR_SONS_CUM_REPEAT_COOLDOWN] = 12;
			outputText("\n<b>You shiver, feeling a little cold.  Maybe you ought to get some more minotaur cum?  You just don't feel right without that pleasant buzz in the back of your mind.</b>\n", false);
		}
		//Go into 'withdrawal' if its time.
		if (flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] >= 48 && flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2) {
			flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] = 3;
			output = true;
			flags[kFLAGS.MINOTAUR_SONS_CUM_REPEAT_COOLDOWN] = 12;
			outputText("\n<b>A steady fire of lust slowly grows within you as you shiver and grab at your head.  You're in withdrawal after having gone so long without a dose of minotaur love.  You just know you're going to be horny and achy until you get some.</b>\n", false);
		}
		//UBER ADDICTION MESSAGE
		if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 100 && player.findPerk(PerkLib.MinotaurCumResistance) < 0) {
			if (player.findPerk(PerkLib.MinotaurCumAddict) >= 0) {}
			else {
				player.createPerk(PerkLib.MinotaurCumAddict,0,0,0,0);
				outputText("<b>You are now a Minotaur Cum Addict</b> (Bottled Minotaur Cum now heals 25% of your HP, but causes HP damage to boost lust for a few hours.)\n", false);
				output = true;
			}
		}
		//3 lust an hour if in withdrawl, 1 if in need
		if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3 && flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] >= 48) {
			dynStats("lus", 2);
		}
		if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 2 && flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] >= 48) {
			dynStats("lus", 1);
		}
	}

	//Decrement addiction value as needed
	if (flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM] >= 48 && player.findPerk(PerkLib.MinotaurCumAddict) < 0) {
		if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] >= 0.15) {
			flags[kFLAGS.MINOTAUR_CUM_RESISTANCE_TRACKER] += 0.15;
			flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] -= 0.15;
		}
	}
	//Increment time since last imbibing cum...
	//used for withdrawal and reducing overall addiction.
	flags[kFLAGS.TIME_SINCE_LAST_CONSUMED_MINOTAUR_CUM]++;
	//Minotaur cum item's status affect decrement
	if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] > 0) {
		flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE]--;
		if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] == 0) {
			outputText("\n<b>Pain and pleasure are no longer so indistinguishable to you.\n</b>", false);
			output = true;
		}
		if (flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] < 0) flags[kFLAGS.MINOTAUR_CUM_REALLY_ADDICTED_STATE] = 0;
	}
	return output;
}

public function minoAddictionFuck():void {
	spriteSelect(44);
	clearOutput();
	outputText("While exploring the mountains, a familiar musky scent works its way into your nostrils.   Sniffing hungrily, you begin shaking, nearly convulsing with need.   You don't think, you act, sprinting heedlessly around the rock obstructions that litter the jagged mountain-side, chasing down your need.  Rounding a sharp bend, you sigh happily as the smell noticably increases in strength.  A few feet away is a minotaur, covered in shaggy fur and snacking on fruit.  Ecstatic, you scrabble forwards, sending tiny rocks everywhere.   The minotaur looks up, at first with a frown, then with a gradually widening grin as he recognizes the look in your eyes.\n\n", false);
		
	outputText("He tosses aside the fruit, forgotten as his veiny shaft forces aside his loincloth, proud and dripping.   You NEED him, and you drop to your knees and masturbate, knowing that soon he'll be filling you full of what you need.   The blatant sexual show does the trick, and you shudder as the drooling horse-cock gets closer and closer to you.   At the last moment the minotaur picks you up, and tosses you backwards, into a cave.  Your hope sinks, but then he starts to advance upon you again, and you know the time for waiting is over...", false);
	
	//(Max lust, load minotaur dicks & balls into monster stats and throw to rape-scenes.)
	dynStats("lus", 3000);
	monster = new Minotaur();
	doNext(kGAMECLASS.combat.endLustLoss);
}


//[Optional Bad-End For Uber-Addicted]
public function minoAddictionBadEndEncounter():void {
	spriteSelect(44);
	clearOutput();
	outputText("While exploring the mountains you catch a strong whiff of your favorite scent.  Tipping your head to the side, you take in a few deep lungfuls and sigh.   Judging by the strength of the smell, there must be MANY minotaurs gathered together.   Immediate visions of being surrounded by the muscly monsters fill your mind.   In your fantasy your holes are plugged and you're soaked in their wondrous stuff.  You desperately want it to be a reality, and all you need to do is follow your nose...\n\n", false);

	//(Withdrawal) 
	if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] == 3 && player.inte < 60) {
		outputText("So great is your need that you don't even think about it, you just start following.", false);
		doNext(minoAddictionBadEnd2);
	}
	else {
		//(if smart)
		if (player.inte > 40) outputText("A tiny voice speaks up, warning you that it would be hard to get away from such a gathering.  ", false);
		outputText("Do you follow the minotaur-scent like the addict that you are?", false);
		//[Yes] [No]
		doYesNo(minoAddictionBadEnd2,camp.returnToCampUseOneHour);
	}
}

private function minoAddictionBadEnd2():void {
	spriteSelect(44);
	clearOutput();
	outputText("You grin and stumble up the mountain, inhaling deep breaths from moment to moment to make sure you're on the right track.  The scent gets stronger and stronger, making you ", false);
	if (player.hasVagina()) {
		outputText("wet ", false);
		if (player.cockTotal() > 0) {
			outputText("and hard ", false);
		}
	}
	else if (player.cockTotal() > 0) outputText("hard ", false);
	else outputText("shiver ", false);
	outputText("with anticipation.  Though you don't notice, your pupils have dilated and your eyes are glassy from the smell alone.  Scrabbling up the rocks, you're oblivious to the cuts and scrapes that form on your hands and arms from the frantic climb.   You pull yourself up onto a ledge and heave yourself over it, lying down to pant and drool from exhaustion.  Only after you've recovered do you realize that you've found them!\n\n", false);  
	
	outputText("There's a whole village of minotaurs here!  Twenty or thirty cave openings are tunneled into the mountain, and an equal number of crude huts are built on the surrounding ledge.  You aren't looking at that way  – your eyes are riveted by what you see between the two sets of structures.  There are five of the shaggy beast-men gathered around a fire-pit, roasting some animal and relaxing.  Two of them are vigorously fucking tiny minotaur-like beings with feminine features, spearing their much shorter brethren on their mammoth shafts.  The look on the faces of the 'minitaurs' is one you know well, the pure ecstasy of indulging a potent addiction.\n\n", false);
	
	if (flags[kFLAGS.FACTORY_SHUTDOWN] > 0) {
		outputText("A third beast has a human-looking victim suspended by her ankles and is roughly fucking her throat.   Her eyes are rolled back, though whether from pleasure or lack of oxygen you're not sure.  A pair of beach-ball-sized breasts bounces on her chest, and a cock big enough to dwarf the minotaur's flops about weakly, dribbling a constant stream of liquid.  She must be one of the slaves that escaped from the factory, though it doesn't look like her life has improved much since her escape.\n\n", false);
	}
	
	outputText("One of the unoccupied monsters glances your way and gives you a predatory smile.  He puts down the axe he was sharpening and strides over, his loincloth nearly tearing itself from his groin as his member inflates to full size.  Amazingly, this minotaur bothers to speak, \"<i>New fuck-toy.  Suck.</i>\"\n\n", false);
	
	outputText("His words are music to your ears.  Crawling forwards, you wallow in the dirt until you're prostrate before him.  Looking up with wide eyes, you grip him in your hands and give him a gentle squeeze.  You open wide, struggling to fit his girthy member into your eager mouth, but you manage.  A drop of pre-cum rewards your efforts, and you happily plunge forwards, opening wider as he slips into the back of your throat.  Miraculously, your powerful needs have overcome your gag reflex, and you're gurgling noisily as your tongue slides along the underside of his cock, massaging him.\n\n", false);
	
	outputText("\"<i>Need... more!</i>\" grunts the beast, grabbing you around the neck and pulling you upwards, forcing himself further and further into your throat.   Normally being unable to breathe would incite panic, but the pre-cum dripping into your gullet blasts away the worry in your mind.   You're face-fucked hard and fast until you feel your master's cock swelling with pleasure inside your throat.  It unloads a thick batch of creamy minotaur jism directly into your stomach, rewarding you until your belly bulges out with the appearance of a mild pregnancy.\n\n", false);
	
	outputText("Your master pulls out and fastens a leather collar around your neck before dragging you through the mud back to his campfire.  Between the tugging of your collar and rough throat-fucking, you're breathless and gasping, but you couldn't be any happier.  Your new owner lifts you up by your " + player.assDescript() + " and forces himself inside your " + player.assholeDescript() + ", stuffing you full of thick minotaur cock.  Still heavily drugged by the load in your gut, you giggle happily as you're bounced up and down, totally relaxed in your master's presence.\n\n", false);
	
	outputText("He grunts and cums inside you for the second time, somehow still able to flood your bowels with what feels like a gallon of cum.  Drooling brainlessly, happy gurgles trickle from your throat as you're pulled off and tossed to the side.  You don't feel the impact of your body landing in the mud, or even notice when you're passed around the camp-fire, broken in as each of your new monstrous masters has his turn.", false);
	doNext(minoCumAddictBadEnd3);
	dynStats("int", -20, "lib", 5, "sen", 15, "lus", 50, "cor", 10);
}
//[PAGE 2]
private function minoCumAddictBadEnd3():void {
	spriteSelect(44);
	hideUpDown();
	clearOutput();
	outputText("Days and weeks pass in a half-remembered haze.  You're violated countless time, and after the first day they don't even bother to keep you on a leash.  Why would they need to restrain such an eager slave?  You're tossed to the side whenever you're not needed as a cum-dump, but as soon as you start to come out of your daze, you crawl back, gaping, dripping, and ready for another dose.  For their part, your new masters seem happy to take care of your needs.  The only time you aren't drugged is when the minotaurs are sleeping, but the minitaurs seem all too happy to let you suckle the pre from their tiny horse-cocks in the huddled slave-pile.\n\n", false);
	
	outputText("You are no longer the Champion of your village.  The only thing you're a champion of is cum-guzzling.  You take immense pride in showing the other cum-sluts just how many thick loads you can coax from your horny masters every day.  Life couldn't be any better.", false);
	getGame().gameOver();
	dynStats("int", -1, "lib", 5, "sen", 30, "lus=", 100, "cor", 20);
}

private function minotaurDrinksMilkNewsAtEleven():void {
	spriteSelect(44);
	clearOutput();
	outputText("You kneel next to the exhausted minotaur, lifting his head up to your " + player.breastDescript(0) + ". He turns his muzzle away from them, still trying to defy you. You force his head back toward your chest and push your " + player.nippleDescript(0) + " against his mouth, but he keeps his lips tightly shut. You pound your fist on his stomach, forcing a gasp of air out of his mouth as you cram your nipple inside. The minotaur is trying to shake his head to free up his mouth but you're holding his fur too firmly for him to wriggle free. His struggling only causes sips of milk to trickle down into his mouth. You squeeze your breast and send streams of milk down his throat. He soon stops fighting and just starts nursing. He's sucking hard, pulling the milk out of you, and stopping every few minutes to take a deep breath. He soon empties that teat and you put the other one up to his mouth. He obediently begins to nurse on that one, but he's a bit winded from the other, so his suckling is gentle and soothing. It takes him a bit longer for him to empty this nipple, but having such a strong minotaur reduced to a weak, suckling calf pleases you greatly for some reason.\n\n", false);

	outputText("You pop your " + player.nippleDescript(0) + " from the dazed minotaur's mouth and leave him there to enjoy the afteraffects of his meal.", false);
	//set lust to 0, increase sensitivity slightly
	dynStats("lib", .2, "lus", -50);
	//You've now been milked, reset the timer for that
	player.orgasm('Tits',false);
	player.addStatusValue(StatusEffects.Feeder,1,1);
	player.changeStatusValue(StatusEffects.Feeder,2,0);
	combat.cleanupAfterCombat();
}


//should be restricted to PCs with 36" cocks or less (arm length-ish) since you're holding the minotaur's horns; centaur addition matches to same length because you're welcome
private function minotaurBlowjob():void {
	spriteSelect(44);
	clearOutput();
	var x:Number = player.cockThatFits(80);
	outputText("You step towards the minotaur, ", false);
	if (!player.isTaur()) outputText("peeling away your " + player.armorName + " and ", false);
	outputText("revealing your " + player.multiCockDescriptLight() + " to the defeated bull.  The beast looks to you in both arousal and shock, mouth parting slightly at the idea of another creature taking charge.  Within the musky stench of its dripping shaft you nearly lose yourself, and ", false);
	if (!player.isTaur()) outputText("taking the bull by the horns", false);
	else outputText("pinning his horns in the crook of your forelegs", false);
	outputText(", you guide its mouth closer to your member as if on autopilot.  \"<i>Let's see just how good you are at milking,</i>\" you blurt; the minotaur moos in defiance but is soon silenced when the head of your " + Appearance.cockNoun(player.cocks[x].cockType) + " presses into its bovine mouth.\n\n", false);

	outputText("You grimace at the awkward feeling of the beast's snout against you, but soon regain confidence in your choice as the monster begins to take your prick into his mouth.  His eyes grow wide as his lips wrap around you, with ", false);
	if (monster.lust >= monster.eMaxLust()) outputText("his own burning lusts", false);
	else if (player.findPerk(PerkLib.ArousingAura) >= 0) outputText("the power of your corruption", false);
	else outputText("the salty taste of your pre-cum", false);
	outputText(" leaving him hungry for more.\n\n", false);

	outputText("At this realization he attempts to pull away, to save himself from the ordeal, but in his debilitated state his efforts are as weak as a kitten's. Held firmly by the horns, the bull-man slowly succumbs.  Unable to control himself in his lust, he licks at the cock within his mouth wildly, his thick cow-like tongue roughly wrapping around your length as you move yourself further within his sucking mouth.  From the combined effects of the creature's musk and maw you start to lose yourself as well, ", false);
	if (!player.isTaur()) outputText("finding your hands leaving his horns for the back of his head ", false);
	outputText("as your hips begin to thrust into his face.  In your daze you glance down, to see the minotaur roughly and futilely stroking his shaft, his eyes full of shame and desperation - full of wanting to not only release his pent-up arousal, but to taste your thick cum as well.\n\n", false);
	
	outputText("You soon oblige the bull; your effort to fuck his face and the rapid bobbing of his head along your member quickly pass what little restraint you care to exercise on the monster's behalf.  Slamming the muzzle into your groin and leaning over his back, you begin layering the minotaur's tongue and tonsils with bursts of your seed.  Reaching down with ", false);
	if (!player.isTaur()) outputText("your hand", false);
	else outputText("a forehoof", false);
	outputText(", you quickly put a stop to his unimportant attempts to pleasure himself by knocking his hand from his meaty cock.  The bull moos over your prick in response, leaving you to shudder while he swallows every last drop of your cum.  You are unable to tell if the beast is blushing from arousal or being reminded of his submission, but it does not matter.\n\n", false);
	
	outputText("Pulling yourself free from the thing's mouth, you let the abused creature fall flat onto its chest and then gather your armor to leave.  Once, you turn back, only to catch sight of the minotaur lost with himself, desperately trying to fuck the ground beneath him and mooing in overstimulated agony from the experience.", false); 
	player.orgasm('Dick');
	combat.cleanupAfterCombat();
}


private function layEggsInAMinotaurSpiderLike():void {
	clearOutput();
	if (player.canOvipositBee()) {
		layBeeEggsInCowbutt();
		return;
	}
	outputText("The defeated minotaur turns and tries to flee.  You quickly fling a cord of sticky webbing that wraps around his massive horns, hauling him up short.  With a panicked moo, he begins to thrash his head, desperately trying to free himself.  You scurry forward and tackle the man-bull, forcing him onto his back.  Extruding more webbing, you wrap his wrists and bind them to his horns, then force his muscular legs upward, bending him almost double before lashing his legs to his horns as well.");
	
	outputText("\n\nNow helpless and hog-tied, the minotaur gazes up at you with wide eyes.  His throbbing, flared cock indicates that not all of him finds the situation as objectionable as he wants you to believe.  Gathering up his musky pre with your fingertips, you hold them beneath his nose before forcing your fingers into his mouth.  \"<i>Arrogant little cow,</i>\" you growl throatily, \"<i>I have a special gift for you.</i>\"");
	
	outputText("\n\nGathering the silk binding his limbs with one hand, you position your ovipositor at ");
	if (!silly()) outputText("his bovine rosebud.");
	else outputText("the entrance to his O.K. Corral.");
	outputText("  Grinning, you lift your abdomen high behind you, then snap it forward, forcing more than half of your long ovipositor deep into your beef-bitch.");
	
	if (player.gender > 0) {
		outputText("\n\n");
		if (player.hasCock()) outputText("Forcing [oneCock] between his bound thighs, you frot his flared bull-cock, your mixed pre soaking into the fur of his belly as you thrust against him.");
		if (player.hasVagina()) outputText("Grasping his bull-cock, you pull it against your pussy, rubbing your juices up and down his impressive length as your lips and clit grind on him, adding to your pleasure.");
	}

	//(If male or herm: 
	outputText("\n\n");
	if (player.hasCock()) {
		outputText("As your orgasm washes over you, you spray your cum, ");
		if (player.cumQ() < 100) outputText("spattering");
		else if (player.cumQ() < 500) outputText("drenching");
		else outputText("nearly drowning");
		outputText(" your helpless prey.  ");
	}
	if (player.hasVagina()) outputText("Your femcum sprays across his cock.  ");
	outputText("Simultaneously, your ovipositor pulses and throbs, forcing egg after egg between his beefy buns and deep into him.  The ");
	if (player.gender > 0) outputText("combination of the scent of your fluids and the ");
	outputText("sensation of eggs forcing their way past his sphincter proves too much for your bovine bitch to resist, and he helplessly sprays his musky cum, stream after stream jetting up his chest and across his face as his eyes roll back in his head.");
	//[(mino addict)
	if (flags[kFLAGS.MINOTAUR_CUM_ADDICTION_STATE] >= 1) {
		outputText("  The smell is too much for you as well, and as you come a second time, you point his flare at your mouth, gulping as much of his seed as you can get.");
		minoCumAddiction(3);
	}
	
	if (player.cor < 50) outputText("\n\nYou carefully unwrap his limbs, then pull his snout around to force him to look at you.");
	else outputText("\n\nChuckling at the thought of the fun the other mountain denizens will have with your well-trussed side of beef, you grab his snout and force him to look you in the eyes.");
	outputText("\n\n\"<i>We'll have to do this again.  In fact, every time you cross my path, we will do this again, my little cow-poke.</i>\"");
	player.dumpEggs();
	player.orgasm('Ovi');
	combat.cleanupAfterCombat();
	//satisfy mino cum addiction if addicted
}

//Bee on Minotaur: Finished (Woodrobin) (Zedit)(CODED)
//r.j.mote@gmail.com
private function layBeeEggsInCowbutt():void {
	clearOutput();
	outputText("Looking down at the defeated minotaur");
	if (monster.lust >= monster.eMaxLust()) outputText(", stroking his flared cock desperately"); 
	outputText(" you feel a throbbing sensation in your apiary appendage.  A leering grin spreads across your face as you force the minotaur onto his stomach, trapping his musky manhood beneath him.");
	if (!player.isTaur()) outputText("  Wrapping his tail around one hand, you lift his furred flanks up");
	else outputText("  Straddling him with all four legs, you slide forward");
	outputText(" while aiming your ovipositor.");
	
	outputText("\n\nAs your egg-phallus slides home, a confused moan escapes from the defeated man-bull.  For a moment, you are reminded of a lost calf calling for its mother.  ");
	if (player.cor < 50) outputText("You hesitate, feeling a surge of pity for the once-mighty creature, but your new instincts drive your egg-layer further into his prone body.  ");
	else outputText("Grinning cruelly, you grasp him by the horns and haul back with both hands until the minotaur is forced to look you in the eye.  You lean in close to his snout and buzz mockingly, \"<i>Whoz the bitch now?  Iz it you?  Yezz, it izz!</i>\"  ");
	outputText("You begin to thrust back and forth, your strong forward strokes punctuated by grunting moos from your huge but helpless brood-bull.");
	
	outputText("\n\nYour body, long-ready to lay, quickly achieves a climax; ");
	//(if male or herm:
	if (player.hasCock()) {
		outputText("you thrust your cock");
		if (player.cockTotal() > 1) outputText("s");
		outputText(" through the air harder and faster, drenching his ");
		//(if cum volume low: 
		if (player.cumQ() < 250) outputText("backside with your cum");
		else if (player.cumQ() < 500) outputText("back with your cum, with ropes dripping slowly off his horns and down his face");
		else outputText("back with your cum, before it covers him and spreads across the floor of his cave.");
	}
	//(if female: 
	else if (player.hasVagina()) outputText("you rub your pussy hard against the minotaur's muscular ass, marking him with the scent of your fem-cum.");
	
	outputText("\n\nFinally, you feel powerful pulses moving through your bee-like abdomen as your eggs move down your ovipositor into their bovine incubator, each one feeling like a mini-climax of its own.  You're beginning to understand why the bee girls are so keen on laying eggs in you when you pass through the forest.  You could definitely get used to this.");
	
	//(If Silly mode: 
	if (silly()) outputText("\n\nLooking down at the mass of bull-meat filled with eggs, you lean down and whisper into his ear, \"<i>And that's how you make Scotch Eggs, cowboy.</i>\"");
	//i like this writer, can we keep him?
	player.dumpEggs();
	player.orgasm('Ovi');
	combat.cleanupAfterCombat();
}

//BY BUTTS MCGEE
//====================================================================
//((This would be a Minotaur Loss Rape if the PC fulfills either of the following conditions.))
//{CHECK: If male PC with big butt (Over... I have no idea what butt numbers are), use this}
//{CHECK: If female or herm PC with big butt and vagina too small to fit minotaur cock, use this}
private function getMinoHawtDawged():void {
	clearOutput();
	if (player.lust >= player.maxLust()) {
		outputText("You collapse to your knees, hands racing to your crotch and your ");
		//(If Male or Herm: 
		if (player.hasCock()) outputText("[cock biggest], which you frantically try to stroke and rub through your [armor], its throbbing arousal clearly evident.");
		//If Herm: 
		if (player.gender == 3) outputText("  Your other hand races to your ");
		//(If Female or Herm: 
		if (player.hasVagina()) outputText("[vagina], which is dripping and drooling your arousal down the insides of your [armor].  You manage to apply some pressure to your [clit] through your [armor], which sends a shock of pleasure through you.");
	}
	//If PC lost by damage, and Minotaur has axe: 
	else if (monster.weaponName == "axe") outputText("The last great blow from the Minotaur's giant, man-slaughtering axe is just a little off, thankfully - the flat of the axe, rather than the blade, hits you upside the flat of your head, sending you tumbling into the dirt.");
	//(If PC lost by damage, and Minotaur does not:
	else outputText("The last great blow from the Minotaur's giant, beefy fist hits you upside your head, the blow strong enough to send you tumbling into the dirt.");
	
	outputText("\n\nThe clopping sounds of the Minotaur's footsteps barely register in your mind as you sit there, too broken to properly care, and its massive bull-cock grows harder and harder as it eyes you up, snorting.  The brown-furred beastman hauls you up by the neck, his grip forcing your hands to grab onto his arm lest he choke you, and he quickly strips you of your [armor], baring more and more of your naked flesh and vulnerable holes.");
	outputText("\n\nThe Minotaur's enormous cockhead spews a thick load of pre onto your crotch as he finally strips you bare, and the warm, slick wetness of his juices on your genitals sends a shiver through your spine.  The minotaur turns you over like a common trollop, eager to take his prize, and adjusts his grip so that one of his burly hands is wrapped around your waist instead of your neck.");
	if (player.hasVagina()) { 
		outputText("\n\nHe lines up his cock with your drooling cunt, your body betraying you as it gets turned on by the rough treatment, and his hips slowly but surely arch forward as his cockhead presses up against your drippy little snatch, making you bite your lip.  The feeling of his fat head rubbing up against your [vagina] is almost too much to bear, and it sends your toes curling underneath of you in pure pleasure.");
		outputText("\n\nFortunately or unfortunately, just as it seems he's about to crown his way into the depths of your [vagina] - he is rebuffed by your tightness, unable to advance any further.  The Minotaur lines up and tries again, making you bite your lip as he forcefully pushes against your slit... but it's no good.  He grunts in frustration, stamping a hoofed foot into the dirt - and then he pauses, getting a look at your [butt] for the first time.");
	}
	outputText("\n\nYou can hear the slurping of the Minotaur's tongue crossing his lips as he eyes up your [butt], and his free hand quickly reaches out to maul one of your fat, squishy cheeks.  His fingers sink in to the tender, jiggly buttcheek, drawing the surface of it inward as his hand makes a print, and you can physically feel his fingers digging around and playing with the sensitive, slutty flank.");
	outputText("\n\nYou bite back a moan as, [if (corruption < 50) much to your horror, ][if (corruption => 50) much to your carnal delight, ]his perverse groping actually starts to turn you on, and you find yourself pressing your hips against his squeezes and firm, exploring grip.  The Minotaur himself is quite enamored with your butt, it seems - or at least with fat butts in general - and so he lets go of your waist... only to haul you further up by the hips instead, bringing your [butt] to his face.");
	outputText("\n\nThe minotaur's muzzle eagerly digs into the crack between your bulbous ass-cheeks as you yelp, surprised, and you feel his tongue flicking out a moment later, searching around inside your tightly-sandwiched asscrack for your [asshole].  It slathers a good portion of your ass with saliva before it darts further inward, licking along your taint - and then skips right over your [asshole].");
	outputText("\n\nYou let out a frustrated moan, fairly into the licking by this point, and try to wiggle your hips encouragingly as his tongue continues to search and slather your tight rear with spit.  His tongue withdraws back into his mouth, making you jump from the sudden motion, but then a second later it's back out again, poking and prodding and licking up every bit it can - until finally, he finds your asshole.");
	outputText("\n\nThe minotaur's broad tongue licks and laps at your [butthole] as you writhe and moan, each lick twice as pleasant as the last, and you feel ");
	if (player.hasCock()) outputText("[eachCock] twitching beneath you, painting the floor with dribbles of your pre.");
	if (player.gender == 3) outputText("  You also feel ");
	if (player.hasVagina()) outputText("your [vagina] clenching and unclenching as your entire hips try to push against the Minotaur's searching tongue, dripping with his spit - along with your own juices.");
	
	outputText("\n\nYour body starts to shiver as he keeps up the anal attention, your asshole quite slick with his saliva as he lets out a approving, rumbling moo - and then he stops, withdrawing his muzzle from your [butt] and its oversized cheeks - which slap wetly back together, your crack still wet with his spit.  A moment later you're hauled back down again, the minotaur's hand wrapping once more around your waist, and it isn't long before his flared head starts to push against the crack between your cheeks, the thick cock demanding entry.");
	outputText("\n\nHis spittling and licking has lubed your fat butt up, treating you to the sound of a wet 'slorp' as his cock dives into your [butt], and you can feel his cock pressing deeper and deeper into you.  Any second now he'll hit your [asshole], and you'll be wrapping your insides around that monster cock of his, moaning like a whore for him.  You feel a gush of his pre splatter all over the flesh at the 'bottom' of your ass-crack, dripping onto your asshole, and you bite your lip in preparation.");
	outputText("\n\n...Only to feel his cock bump you just below your tailbone.  You let out a frustrated moan and wiggle impatiently as the minotaur tries to line up again, and as a result his cock hits the taint between your asshole and your crotch instead.  With a frustrated moo, the minotaur brings his free hand down on one of your jiggling cheeks - and a ringing <b><i>SLAP</i></b> echoes out as the strike sends an arc of pain through your [butt].  You settle down, obliging the powerful creature, and it tries to line up with your asshole again.");
	outputText("\n\nThis time, you feel his cock angle upward as he tries to push in... until the head pops out the top of your butt, neatly hotdogged between your cheeks.  You sigh, thinking you're going to be here for a while, and then he pulls back, only to hump your cheeks again in the exact same way.  You're confused, for a moment, as he uses his free hand to squish your cheeks together around his dick, but you let it slide as the strangely-pleasant feeling of him fucking your asscrack runs through you.");
	outputText("\n\nAgain and again his strong, masculine hips surge forward as he fucks your girly rump, your [butt] bouncing and jiggling every time his hips collide with it, and his pre-drooling flare erupts out the top of your crack to taste the air.  With each withdraw, his head sheaths inside of your crack again, trailing his tingle-inducing pre all the way, and the Minotaur's thrusts slowly speed up as he starts to moo.");
	outputText("\n\nThe bouncing of your captor's thrusts becomes increasingly violent as he uses your ass like just another hole for him to get off with, and you find yourself writhing in his grip for an entirely different reason, now; need.  While his fucking is turning you on like little else, the pleasurable strokes of his bull-cock in your [ass] aren't enough to get you off.  He, however, doesn't seem to care; his moos and grunts have turned into a panting rut as he fucks your ass-crack at full blast, the bouncing of your cheeks a constant, unending motion now.");
	outputText("\n\nYou let out a low whine as you try, helplessly, to grab for your crotch, but between the constant fucking and the minotaur's big arm blocking the way, you can't grab on long enough to masturbate.  Thankfully, it doesn't take the minotaur long to cum after that; there's a few more shuddering, insistent thrusts...");
	outputText("\n\n...and then his head pushes out the top of your ass again, fountaining with his spunk. Gout after gout of it rains down on you, painting your butt, ");
	//[if (hasTail = true)
	if (player.tailType > TAIL_TYPE_NONE) outputText("your tail, ");
	outputText("your back, and even your hair with gushes of his sticky, musk-smothered seed. Your entire backside flushes with the heat of his orgasm as it starts to die down, a few last drools of the hot stuff spilling out of his cock, and he withdraws from your butt, leaving you one last gift of a single spurt lodged between your fat cheeks and slowly dripping out. The Minotaur's cum seems to make your head swim, and everything starts to go foggy...");
	//{Loss message 'when you wake up you'll be missing gems' blah blah}
	dynStats("lus", 15+rand(player.lib/2));
	player.slimeFeed();
	minoCumAddiction(5);
	combat.cleanupAfterCombat();
}

//Written by Foxxit, edited by Shylok Vakarian, Coded by KiefKeith
//Added flag to kFlags for this at #2337
//Added button to rape choices, it tests whether player has cock and if it will fit in minotaur's ass. Added it to temp2 section.
private function minoMutual():void
{
	clearOutput();
	spriteSelect(44);
	var x:Number = player.cockThatFits(monster.analCapacity());
	
	if (flags[kFLAGS.TIMES_MINO_MUTUAL] <= 0) //First time
	{
		outputText("Every muscle in the minotaur’s body bulges as he pumps his swollen horse cock with reckless abandon. Despite the evident vigor with which he strokes the tower of meat he calls his penis, there is no hope for release in his eyes. He just sits there, mindlessly stimulating himself, unable to bring himself to climax but also unable to stop himself from trying."); 
		outputText("\n\nEven though he was just trying to rape the bejeezus out of you, you can’t help but feel a little bad for the helplessly rutting man-beast’s situation.");
	}
	else
	{	//Repeatable (Not first time?)
		outputText("You shake your head as you look down at the minotaur furiously trying to bring himself to climax despite the obvious rut he’s stuck in so deeply. You know that the combination of his bovine biology and corruption are more at fault for him trying to rape you than anything else... so you decide to help the poor guy and empty his big bloated balls.");
		outputText("\n\nYou grab the horny bull man by the horns. Using your grip on his horns to forcibly guide his gaze, you make the minotaur to look you in the [eyes] and by doing so help him focus on your words as you speak.");
		outputText("\n\nWhen you tell him you are willing to make him cum, his eyes ignite with a spark of hope. Before he can get too excited, you outline the rules, letting him know that he has to make you cum before you’ll even attempt to make his big, bloated cock spill its thick, creamy goo. When you ask him if that is all right with him, he nods vigorously, suddenly more than willing to do anything you ask in exchange for blessed relief from the debilitating arousal caused by his bovine biology."); 
		outputText("\n\nSo, after receiving a grunt of approval and shaking hands to seal the deal, you unceremoniously shed your [armor]. Once you are fully naked you plant your [feet] and present yourself to him.");
	}
	
	flags[kFLAGS.TIMES_MINO_MUTUAL]++; //Add one to our mino mutual flag
	
	outputText("\n\n[EachCock] swings between your [legs], erect and leaking. The rutting bull man looks upon the evidence of your masculinity. He is so enthralled by [eachCock] that a dollop of drool escapes his thick lips and runs down his chin. After wiping the physical evidence of his obvious attraction to [eachCock] off of his fuzzy chin, he unceremoniously shoves his face into your groin."); 
	outputText("\n\nHot breath bathes [eachCock] in a warm breeze as he buries his face in your groin. He inhales your scent deeply with his eyes rolled back in pure bliss. Despite the eagerness with which he moves, he manages not to skewer you with those horns of his, but other than that, he just seems to lose himself in your musky maleness."); 
	outputText("\n\nWhen his lips slide across the rigid surface of your [cock], his tongue pushes out, taking a quick little taste. For the sake of his own rutting cock the minotaur has completely submitted himself to you and, you have to admit, having this big masculine bull-man kissing and rubbing his face against like some little dick hungry little slut is making [eachCock] leak like a cup full of spunk with a hole in the bottom. Soon enough the minotaur’s thick lips pull away and he looks up at you, drops of pearly precum glistening amongst his bovine features like little erotic diamonds.");
	outputText("\n\nYour [face] pulls into a smile, letting him know he’s on the right track. Encouraged by your silent grin his lips part, opening wide as he leans in.");
	outputText("\n\nHis wet lips press against your [cockHead] with a kiss so tender it would be more easily attributed to a lover rather than someone who was trying to rape you moments before. With his next kiss, his thick lips paint the head of your dick with shining saliva that drools down his jaw as he begins to hungrily suck your leaking erection. Then his long tongue slides across the slit, probably searching for more evidence that his labor will bear its intended fruit.  When he finds it he locks his lips around your [cockHead] before pulling off with a loud pop that sends a boom of pleasure through your body, forcing an unexpected grunt from your lips.");
	outputText("\n\nKnowing he’s on the right track, the minotaur sucks off the head of your [cock] again and again. The sudden pop, pop, pop of his machine gun kisses send bullets of sharp pleasure through your [cock], causing you to rapidly convulse with each loud smack. Then, just when you’re beginning to get used to the wonderful sensation, his tongue lashes out. The minotaur begins to roughly bathe the belly of your [cock] with his wide, flat tongue, each hard slurp slathering drool across the underside. Your [legs] feel weak as you force them to hold you up.");
	outputText("\n\nAs he looks up at you, you can see lust burning in his eyes. Looking down at that raging inferno, you stoke his fire by flexing your penile muscle, causing your [cockHead] to jump up and fall against the thick pillows of his lips.");
	
	if (player.cocks[x].cockLength <= 10)
	{
		outputText("\n\nSlowly he pulls your leaking [cock] into his hot mouth. Those soft lips of his are paradise made manifest as powerful lungs suck your [cock] into the bull man’s hungry orifice. A deep baritone groan vibrates your [cock] as he holds you there, happily gobbling your entire length up with a look of supreme self satisfaction. Then he buries his nose in your groin, eyes closed as he takes in a deep pull of your scent.");
		outputText("\n\nYour voice comes out in a rush of sharp gasps as he begins to hum with your [cock] tucked between his lips. Even as his voice vibrates his oral cavity, his big mino tongue slides onto your shaft, curling around your rock hard [cock] and drawing a loud groan from your lips.");
		outputText("\n\nThen the minotaur begins to bob. Your [cock] slides in and out of his lips with loud squelching noises. Your body trembles with need as every every tug of his lips and his undulating tongue work together, threatening to make your cock explode with the force of a volcano.");
		outputText("\n\n\"<i>Mmmm.</i>\" He says, stroking his large equine dick as he increases the pace. It seems he’s really getting into this.");
	}
	else if (player.cocks[x].cockLength > 10 && player.cocks[x].cockLength <= 20)
	{ 
		outputText("\n\nWith exaggerated slowness, he pulls your leaking [cock] into his hot mouth. Those soft lips of his are a small piece of heaven as his powerful lungs suck your [cock] into the bull man’s hungry orifice. When your [cockHead] hits the soft velvety flesh at the back of his throat, the minotaur suddenly chokes, having been gagged by the length of your [cock]. Looking down you see he has yet to reach your groin and is having trouble pulling you into his throat. His second try ends in another flurry of choking and sputtering that, you have to admit, feels good against the sensitive flesh of your [cock]. Third time must be the charm though because as your [cock] hits the back of his throat he swallows perfectly. and strong throat muscles tug your [cock] into its rightful place inside the hot squeezing tunnel of his throat.");
		outputText("\n\nYour voice comes out in a rush of sharp gasps and deep groans as he inches slowly towards your groin. The tightness of his throat, the wetness of his tongue, and the heat of his breath combine to cause a fluttering pleasure that peaks with every movement he makes. You find yourself grinding your dick forward in an effort to help the bull man, which results in his twisting his face and holding your [legs] to stabilize himself."); 
		outputText("\n\nLike a true masculine beast-man, he perseveres, each gulp bringing more of your [cock] into the sweltering embrace of throat. When his wide nostrils finally mash into your groin, you almost lose it right then and there. You have to grab his horns and halt his movement in order to stop yourself from flooding his throat a little too early.");
		outputText("\n\nLooking down you see a knowing gleam in the minotaur’s eyes. You take a deep breath to steady your roaring libido. Now that you’ve mastered your urge to flood his throat with your dick milk, you give him a tap on his horn to tell him to continue.");
		outputText("\n\nAs if to show off, he twists his head, making your entire body spasm as his strong throat squeezes your [cockHead]."); 
		outputText("\n\nThe minotaur begins to bob, taking your full length into his hot throat. a glorious symphony of squelching sounds rises to join the erotic melody ripping uncontrolled from your heaving [fullChest].");
		outputText("\n\n\"<i>Mmmmmm.</i>\" He groans, stroking his long equine cock as he increases the pace. Each time he fully engulfs your cock, drool swings from his blurred lips. Looks like he is really getting into the swing of things.");
	}
	else if (player.cocks[x].cockLength > 20)
	{
		outputText("\n\nHe slowly pulls your leaking [cock] into his hot mouth, his cheeks ballooning with every breath he takes. Those soft lips of his are the gates to heaven as they strain to contain your [cock] and push you into a state of nirvana. When your [cockHead] touches the soft velvety flesh at the back of his throat, the minotaur gags loudly, choking on your [cock]. Looking down you see that there is plenty of dick left to swallow while his nostrils flare to bring more air into his lungs.");
		outputText("\n\nDrool drips from his strained lips as he shoves himself against your [cock]. His second try ends in defeat as a his gag reflex violently expels your [cock] in a flurry of choking and spit that feels glorious against your sensitive flesh. He tries again, this time your [cockHead] dips into his throat only to be expelled as his head jerks of its own accord. Yet he isn’t deterred in the slightest. Each failure only seems to reinvigorate his desire to try harder, and each try is a glorious symphony of violent sensation against your spit dripping [cock].");
		outputText("\n\nThen the minotaur suddenly gets this look of supreme concentration. It is almost as if he refuses to let your [cock] defeat him.With a furrowed brow and a mouth stretched wide by your dick, he swallows. This time he doesn’t choke or gag. The gulp smoothly tugs your [cockHead] into the velvety confines of his glorious throat. You hear a gag and then another but he perseveres despite the globs of bull spit being forced out of his lips by the sheer length of your [cock]. He takes a second to rest, his eyes watering as he mentally prepares to make a go at the rest of your gloriously hard cock.");
		outputText("\n\nA smile graces your face as each spit dripping gulp tugs a bit more of your [cock] into the minotaur’s sweltering throat. His progress is slow but steady. The wonderful trembling of his throat, the achingly erotic sound of his voice and the wetness of his oral cavity makes you shiver. For a second you think he might make it but then, sadly, he stops short. It seems he is physically incapable of reaching your groin.");
		outputText("\n\nYou watch the disheartened minotaur’s shoulders slump in defeat but the feeling of having his throat, tongue and lips straining to wrap around your [cock] is glorious.        So, sensing that he needs the encouragement, you tap his horn. When his eyes open and rise to meet your gaze you give him a reassuring smile. You feel a gulp travel the length of your [cock] that causes the bull man to choke. Amused, you groan mid chuckle and he begins to slurp up and down the length of your cock. He spares no expense as one hand grips the part of your [cock] that doesn’t fit inside of his mouth and uses it to pull you in and out of his thick lips. Soon he is making good time, spit flinging everywhere as he shoves his face into your [cock] until he chokes, retracts and repeats.");
		outputText("\n\n\"<i>Mmmmmm.</i>\" He groans, stroking his big equine dick as he tastes you. He seems really pleased to be giving you pleasure. Looks like he is really getting into the swing of things.");
	}
	
	outputText("\n\nStill stroking his big horse cock, he allows your [cock] to fall from his lips.");

	if (player.cocks[x].cockType == CockTypesEnum.HUMAN)
	{
		outputText("\n\nHe takes your [cock] and rubs it against his face, smearing your leaking precum across his bovine features. Wide nostrils take deep lung fulls of your [cock]. He does this several more times, the whole while his eyes are closed in silent elation. It is almost as if the bull man is trying to memorize your scent. He rubs his lips against your hard [cock] more and more, each round slippery wet lip tugs on your sensitive flesh as it passes, causing your [cock] to drip as the minotaur loses himself in ecstasy.");
		outputText("\n\nAs his reverence stretches on, you begin thrusting your [cock] against the crevice created by his big pillowy wet lips. Something that, from the way those dark eyes look up and the way he begins to jerk his dick harder, you know is turning him on like crazy. His free hand clutches at your [legs], holding on as you shove your hard and leaking cock against his face with steadily mounting force.");
	}
	else if (player.cocks[x].cockType == CockTypesEnum.DOG)
	{
		outputText("\n\nHe wraps curious fingers around your swollen knot, a question on his bovine features. When his gentle squeeze causes you to thrust against his hand his masculine features break into a wide toothy grin. He begins to nuzzle your knot, kissing and suckling the swollen bundle of nerves. The tingling sensation soon explodes into a brain bursting need to thrust.");
		outputText("\n\nSo you thrust your [cock] into the crevice formed by his soft, pillowy spit slick lips. He handles his face so that your knot crashes into his lips and at the apex of every thrust he sucks the tender swollen part of your [cock].");
		outputText("\n\nA strong hand grasps your [cock] and pulls it up. The minotaur begins sucking your knot in earnest, causing you to grab his horns and shove yourself against his face. He does nothing to stop you, quite the opposite, he spits on your sensitive knot and keeps his lips wet. All just for your pleasure.");
	}
	else if (player.cocks[x].cockType == CockTypesEnum.HORSE)
	{
		outputText("\n\nHe holds your [cock], his hand encircling the base of your thick horse like dick. He takes a deep pull… again. It appears he really likes the masculine musk coming from your [cock]. His eyes close as he takes a moment.");
		outputText("\n\nThen his face spreads into a grin, a grin that you’re not sure you shouldn’t be afraid of. He grips your [cockHead] in a way that makes you twitch. Seems he knows exactly what to do with a cock like yours.");
		outputText("\n\nHe begins running his tongue across each segment, spit bathing the belly of your [cock]. Your lips are sucked into your teeth as you bite your bottom lip and shove your [hips] forward. Then he begins nibbling on each of the ridges and you’re suddenly transported into an erotic heaven as your [cock] leaks globs of precum."); 
		outputText("\n\nHe isn’t done yet though. He begins to kiss-suckle your [cockHead], drinking your dripping precum as if it were the sweetest nectar.");
	}
	else //Player has other type of cock
	{
		outputText("\n\nWith exaggerated slowness he licks up the belly of your [cock]. He repeats this torturous practice several times. Then he squeezes your [cock], using his tight fist to pump your pearly white pre-cum onto his tongue. He continues this until your seminal fluid is sitting pretty on his wide tongue.");
		outputText("\n\nOnce he is satisfied with the amount of [cock] juice pooling on his tongue, he looks up at you with a question in his eyes. You smile as you realize what he wants: permission. The submissive way he sits there with one hand on his dick and the other on yours waiting to be told if he can swallow your cum makes your [cock] jump."); 
		outputText("\n\nWhen you give him the go ahead he gulps his precious prize down and licks his lips, eyes closed in silent exaltation. This is something that, from the way he begins to pump his giant horse dong even harder, you know is turning him on like crazy. His free hand maintains its tight grip on your [cock], still pumping as it allows the pearly drops of pre to fall onto his huge chest.");
	}
	
	if (player.balls > 0)
	{
		if (player.ballSize == 1) //Normal-sized balls
		{
			outputText("\n\nThe minotaur’s big warm hand cups your [balls], massaging them as he licks your quivering [cock]. With great tenderness he tugs your sensitive cum factories, using them to pull your your swollen, spit shined dick against his lips. The dual sensation of wet lips on the base of your [cock] and tender fingers tugging at your [balls] combine to form a fiery feeling of pure bliss.");
			outputText("\n\nThe next thing you know his face is buried in your sac, suddenly suckling and kissing the sensitive flesh of your [balls]. His strong lips firmly tug at the skin before just the right amount of suction pops the orb into his hungry mouth. His lips move, sending mind numbing sensations of pure bliss throughout your body. You grind into those lips, your [balls] delightfully enjoying the minotaur’s tender affection. [if (balls > 1) “He spits one orb out and takes in another, bestowing it with the same groan inducing attention he did on the other.");
		}
		else if (player.ballSize > 1 && player.ballSize <= 4) //Large balls
		{
			outputText("\n\nThe minotaur’s big warm hand slides across your [balls], massaging them as he licks your leaking [cock]. He massages your sensitive cum factories as he begins to kiss the point where they connect to your body. Drool slides down your hefty sac as he uses the combination of his hands and mouth to make you push forward into the tingling feeling of erotic euphoria...");
			outputText("\n\nThe next thing you know his face is buried in your sac, suddenly suckling and kissing the sensitive flesh of your [balls]. He can’t fit your orbs into his mouth but that doesn’t stop him from making sweet, sweet oral love to your tremendous sac. [if (balls > 1) “With a grin he takes your [balls] into his mouth one at a time, his tongue giving each a good erotic licking.");

		}
		else if (player.ballSize > 4) //Huge balls
		{
			outputText("\n\nReaching down he slides his big hand across your [balls]. The minotaur seems both impressed and intimidated by the incredible mass of the cum producing organs between your [legs]. He massages them gently, the way you would rub a treasured pet. The sensation is pleasant in its own right but it is nothing compared to the mind numbing ecstasy you feel when he leans in and drags his tongue across your [balls].");
			outputText("\n\nSlowly he gets into a nice little rhythm. He kisses and licks your [balls] while rubbing your huge cum factories in these tingling swirling motions. You gasp when his big equine cock slides belly first against your [balls]. When he begins humping against them while keeping up his already intense ministrations you almost blow your wad right then and there.”");
		}
		
		outputText("\n\nHe smiles against your tingling [balls] before burying his wide nose in your sac and taking in a deep whiff."); 
		outputText("\n\n\“<i>Mmmmm.</i>\” He says, eyes half lidded as he drinks in the while still tugging his erect cock. He kneels between your legs, breathing in the undeniably masculine scent of your cum filled [balls]."); 
		outputText("\n\nThe enraptured minotaur begins inhaling your sweet masculine ambrosia again and and again; licking you, savoring your taste as one would savor their last meal. It is almost as if he is trying to permanently imprint your scent onto his memory, as if he never wants to forget your glorious body or your cream filled [balls].");
		outputText("\n\nHis tongue rushes out to slide belly flat against the middle of your [balls]. Having gotten his final tender taste in he rises back to your shaft with a look of utter determination.");
	}
	
	//PC first org
	outputText("\n\nThe minotaur opens wide before shoving himself onto your [cock], violently sucking you into the hot wet tunnel of his mouth. He begins to bob hard, obviously trying very hard to make you cum. The slick squelching sound is accompanied by a pumping sensation you know all too well. You take the bull by the horns and begin to help him out by roughly shoving your [cock] against the thick greedy lips.");
	if (player.balls > 0) outputText("\n\nWith every thrust your [balls] slap loudly against his chin.");

	outputText("\n\nKnowing that this is the home stretch and you relentlessly fuck his oh so willing mouth with steadily mounting force until you feel your baby batter boiling over like a river of white fire.");
	outputText("\n\nWith a growl that shakes your entire being you wrench his thick lips from your cock and tell him to open his mouth so that he may receive the fruits of his labor.");
	outputText("\n\nThe minotaur obeys with a look of adoring submission, he even stick out his tongue. You, with one hand on his horn and the other on your [cock], begin to massage your boiling cum into a frenzy as it surges forth.");
	
	if (player.cumQ() <= 25) //Normal cum
	{
		outputText("\n\nAs you shove your [cockHead] against his wide wet tongue your [cock] spurts a rope of man milk that leaves your body like an erotic arrow shot from a master’s bow. Your gleaming seed crashes into his wide tongue with a violent splatter like milk being fired from a hose hitting a smooth surface. The moment the second seminal arrow hits his tongue the minotaur locks his soft lips around your cum spewing [cockHead].");
	
		if (player.balls > 0) 
		{
			outputText("\n\nWith a grunt of triumph the cum hungry minotaur greedily sucks your spurting cock, noisily gulping your load as he massages your [balls]. It is almost as if he wants you to cum even more.");
		}
		else
		{
			outputText("\n\nHe releases a grunt of triumph as he greedily sucks your spurting cock, noisily gulping your load as he rubs your [legs]. It is almost as if he wants you to cum even more.");
		}
	}
	else if (player.cumQ() > 25 && player.cumQ() <= 250) //High cum
	{
		outputText("\n\nAs you shove your [cockHead] against the minotaur’s wide wet tongue your [cock] erupts, sending a hard spurt of jizz directly into the back of the guy’s throat. As you shoot rope after rope of glistening white semen onto his wide pink tongue the minotaur’s lips close around your [cockHead] with a baritone groan."); 
		outputText("\n\nYour head goes slack as the creamy essence leaves your body, streaming through your cock and making your [legs] weak.");
		
		if (player.balls > 0) 
		{
			outputText("\n\nThe euphoria inducing flood of man milk streams from your [cock]. the minotaur allows your cum to pool in his mouth as he massages your [balls] with one hand and grips your shaft with the other. Once you’ve filled his lips to near-overflowing his strong hand tightens around your shaft, halting the flow of seed and sending a convulsion through your body. As he savors the taste of your milky baby batter he continues massaging your [balls], ensuring that your corked cock will give him the rest of his meal. He repeats this process once more, enjoying his second mouth full as much as the first before kissing the last dregs of cum from your spit shined and dripping [cockHead].");
		}
		else
		{
			outputText("\n\nAs the euphoria inducing flood of man milk streams from your [cock] the minotaur allows your cum to pool in his mouth as he grips your [cock] with one hand, the other still rubbing his big equine cock. Once you’ve filled his lips to near-overflowing his strong hand tightens around your shaft, halting the flow of seed and sending a convulsion through your body. He swishes your load around in his mouth, eyes rolled toward the back of his head as he tastes you. He repeats this process once more, enjoying his second mouth full as much as the first before kissing the last dregs of cum from your spit shined and dripping [cockHead].");
		}
	}
	else if (player.cumQ() > 250 && player.cumQ() < 500) //Very high cum
	{
		outputText("\n\n “As you shove your [cockHead] against the minotaur’s wide wet tongue your [cock] blasts, sending a thick spurt of creamy cum directly into the minotaur’s open mouth. As the ropes of alabaster jizz fire into the roof of the minotaur’s mouth his thick lips snap closed around your [cockHead] with a hungry groan.");
		outputText("\n\nYour head goes slack as the creamy essence blasts out of your body, sending shivers of ecstasy up your spine.");
		
		if (player.balls > 0) 
		{
			outputText("\n\nAs the gigantic flood of baby batter fires from your [cock] the minotaur allows your cum to pool in his mouth. He massages your [balls] with one hand and grips your shaft with the other with eyes glazed over in lusty adoration. Once you’ve filled his lips to near-overflowing his strong hand tightens around your shaft, halting the flow of seed and sending a hard convulsion through your body. As he savors the taste of your milky baby batter he continues massaging your [balls], ensuring that your corked cock will give him the rest of his meal.");
			outputText("\n\nThen his grip loosens and he allows your cum to fill his mouth. When his teeth, tongue and tonsils are swimming in your man milk his grip tightens again, halting the flow so he may swish your cum around in his mouth and swallow it.");
			outputText("\n\nHe repeats this process several times, savoring each mouthful as much as the first before kissing the last dregs of cum from your spit shined and dripping [cockHead].");
		}
		else
		{
			outputText("\n\n“As the gigantic flood of baby batter fires from your [cock] the minotaur allows your cum to pool in his mouth. One strong hand hand and grips and massages your shaft as he jerks himself, his eyes glazed over in lusty adoration. Once you’ve filled his lips to near-overflowing his strong hand tightens around your shaft, halting the flow of seed and sending a hard convulsion through your body.");
			outputText("\n\nThen his grip loosens and he allows your cum to fill his mouth again. When his teeth, tongue and tonsils are swimming in your man milk his grip tightens again, halting the flow so he may swish your cum around in his mouth and swallow it.");
			outputText("\n\nHe repeats this process several times, savoring each mouthful as much as the first before kissing the last dregs of cum from your spit shined and dripping [cockHead].");
		}
	}
	else if (player.cumQ() >= 500) //Extreme cum
	{
		outputText("\n\nAs you shove your [cockHead] against the minotaur’s wide wet tongue your [cock] explodes, sending a violent shotgun blasts of thick cream directly into his waiting mouth. As the ropes of snow white spunk shoot into the the minotaur’s mouth it impacts so violently it gushes back, creating a spray of creamy man milk with every ejaculation. In an attempt to stop the excess cream from being wasted he locks his lips around your violently spurting [cock]");
		outputText("\n\nYour body is wracked with convulsions as the creamy essence shoots out of your body, making your [legs] feel weak.");
		
		if (player.balls > 0)
		{
			outputText("\n\nAs the tsunami of man milk arcs from your [cock] the minotaur allows your cum to pool in his mouth. He massages your [balls] with one hand and grips your shaft with the other with eyes glazed over in lusty adoration. It doesn’t take long to fill his lips to overflowing and once you do his strong hand tightens around your shaft, probably attempting to halt flow of seminal fluid so that he may drink  it at his leisure.");
			outputText("\n\nInstead your cum forces his strong grip apart and he is hit full on in the face by a particularly hard blast of cum.");
			outputText("\n\nHis thirsty lips return to your [cockHead], desperately trying to keep up with the extreme, almost comical, amount of spunk you’re producing. Cum streams from the corners of his mouth like a waterfall.");
		}
		else
		{
			outputText("\n\nAs the tsunami of baby batter arcs from your [cock] the minotaur allows your cum to pool in his mouth. One strong hand grips and massages your shaft as he jerks himself, his eyes glazed over in lusty adoration. Once you’ve filled his lips to near-overflowing his strong hand tightens around your shaft, halting the flow of seed and sending a hard convulsion through your body.");
			outputText("\n\nThen his grip loosens and he allows your cum to fill his mouth again. When his teeth, tongue and tonsils are swimming in your man milk his grip tightens again, halting the flow so he may swish your cum around in his mouth and swallow it.");
			outputText("\n\nHe repeats this process several times, savoring each mouthful as much as the first before kissing the last dregs of cum from your spit shined and dripping [cockHead].");
		}
	}
	
	player.orgasm();
	doNext(createCallBackFunction(minoMutualPt2,x));
}


private function minoMutualPt2(x:Number):void
{
	clearOutput();
	//Mino Worship 
	outputText("Your [chest] rises and falls in splendid exhaustion as your body tingles with the glorious sensation of post-orgasmic euphoria. As you bask in the feeling the sound of desperate fapping brings you back down to earth. Your new fuck buddy is still furiously wanking his big horse cock, his hand becoming a brown blur as his rut intensifies.");
	outputText("\n\nIt is kind of sad when you think about how he was born not only with a natural bovine biology susceptible to rut but also in a land bleeding with corruption. Who is to say he wouldn’t be a much better person if he hadn’t been born in these specific circumstances? It sucks that, no matter how hard he beats his meat, it is a futile endeavor. When you tug his big bovine fist from his pulsing horse cock he doesn’t resist, relief visible on his face when he realizes you are going to keep your promise.");
	outputText("\n\nYou look down at his rutting horse cock. The swollen sex organ pulses visibly, leaking to lubricate a hole it isn’t even submerged in. Alongside its flared head and segmented ridges there are thick veins across its surface, visibly pumping against the taut skin of his dangerously swollen cock.");
	outputText("\n\nThe tower of horse meat practically reaches towards your [face] as you lean forward and press your mouth against the first swollen ridge. A violent spasm suddenly jerks his body which tells you, in no uncertain terms, how much of a relief it is for him to feel your mouth on his quivering stallion dick. He trembles as your lips move, his muscles contracting causing his towering horse cock to jump against your [face]. With every kiss his dick jerks again and you make a game of it, kissing a ridge and allowing the reaction to snatch it from your mouth before choosing another ridge and kissing it again. At first your little game is as almost as fun as strip poker but soon you are ready to take things to the next level.");
	outputText("\n\nWithout warning, you snatch the unruly horse cock toward your [face] and lock your lips around the widened cum slit with a growl. With his face contorted in surprise your minotaur jerks and grunts before settling down and letting you have your way. You begin suckling the thick, hot, seminal fluid leaking from his flared head. As you drink his sweet precum straight from the tap you hold his still flexing horse cock in place. As his mino-cum pools in your teeth you don’t swallow but instead spit the mixture back onto his meaty prick before sucking more and repeating the process.");
	outputText("\n\nThe minotaur squirms as his deep voice strains to an almost girly pitch, releasing several squealing sounds that could be either pain or pleasure. He begins to pump his hips into you and you roll your tongue across the flared head, lapping up even more of his thick cream to spit out and soak his cock with.");
	outputText("\n\nOnce you’ve had your fill of his tasty member you push his rock hard horse cock against his muscle etched belly and begin licking the minotaur’s swollen testes. Your [tongue] plays aimlessly along the wrinkled skin, causing him to sing a song of helpless arousal. You lock your lips around the soft skin and suck, massaging his aching nuts with tender kisses.");
	outputText("\n\nYou listen as the minotaur’s voice rises in strained groans of tortured euphoric delight. Using his voice as a guide you find the most sensitive parts of his cock and balls. You keep him on edge, not giving him the full attention you know is required for him to ejaculate and teasing him into a full out frenzy.");
	
	//Frot
	outputText("\n\nIn response to your keeping him on edge this big strong rutting bull man begins to whimper. At first he tries to suppress it, to show some dignity but after a while he gives all of that up. He even begins pleads with you, the deep baritone of his voice begging you to end his rutting misery. It is so cute that he thinks you need to be told of his predicament as if, from your position it is easy to see that his cum filled nuts are still very much in need of sweet release. You tell him the two of you had a deal and he manages a weak smile in acknowledgement, as if he wants to believe you and yet he isn’t sure he can.");
	outputText("\n\nWhen you rise he looks at you with an odd combination of awe and fear. That is when you take your [cock] in hand, straddle him and drop it against his big horse cock with an audible plop.");
	
	if (player.cocks[x].cockLength < 15)
	{
		outputText("\n\nLooking down you see that he is bigger than you but it doesn’t really matter, simply having your [cock] against his is causing his pre to pump even harder. You begin to thrust, slowly rubbing your [cock] against his.");
		outputText("\n\nThe ridges make for an interesting sensation, like little erotic speed bumps. Yet as good as it feels to you you can tell that the minotaur is loving it even more. He gasps and groans and squirms beneath you like a good little bovine bitch.");
	}
	else if (player.cocks[x].cockLength >= 15) 
	{
		outputText("\n\nLooking down you see that your [cock] is bigger than his and you look down at him, [chest] swelling with pride. His pre begins to pump harder as your larger erection lies on top of his. When you begin to pump your hips he releases this deep body shaking groan. You grin and just continue rubbing your [cock] against his segmented horse penis.");
		outputText("\n\nThe ridges feel good against your shaft, each a sexy little bump you press down into. The minotaur beneath you shivers as you focus on humping against his big swollen horse cock. He gasps and groans and squirms beneath you like a good little bovine bitch.");
	}
	
	outputText("\n\nYou keep it going and watch the minotaur’s teeth clench as his body begins to tremble even harder. Then you begin to increase the pace and each stroke becomes slightly faster than the previous.");
	outputText("\n\nReaching down you use your hand to press your dick down, holding it against his to increase the amount of friction and, thusly, the amount of pleasure. You have to admit, if only to yourself, that fucking your [cock] against his is starting to get to you. The way his segmented horse dong’s ridges feel against the underbelly of your [cock] is nothing short of amazing.");
	outputText("\n\nSoon you’re practically pounding your [cock] against his and he’s humping up against you, working like a madman towards his own release.");
	
 
	outputText("\n\nWhen you suddenly stop fucking your dick against his he lets out a frustrated growl, one that seconds later he sheepishly apologizes for. With a chuckle you tell him to be patient and reach for his leaking member.");
	outputText("\n\nHis equine penis is hot to the touch as you grip the flared head tightly so that, should his penile bone flex, it won’t be able to jerk away. His creamy precum is pungent, its scent filling your nostrils as it pools inside the surrounding ridge.");
	outputText("\n\nThen, with your free hand, you take your pointer finger and tickle his cum slit. This brings a loud moan from his lips. With exaggerated tenderness you rub his leaking cock. You tease in this way, with one hand gripping his cock like a vice and the other teasing his cum hole, for a while. Then he begins to tremor. He desperately tries to hold out, to deny how much you are affecting him by staying motionless.");
	outputText("\n\nHe fails. Soon his hips are wild, his spread legs bending as he thrusts and jerks. Thanks to your grip on his cock this does little to stop you from teasing him. Looking up you see a mixture of longing and madness in his eyes, his hands have grabbed twin handfuls of dirt but even so he wears a confused grin as if he isn’t sure he likes being teased or not.");
	outputText("\n\nBefore he can decide you force a trembling moo from his lips by dipping your finger into his hot sticky cum slit. The mino’s jaw remains agape as his legs shoot straight out on either side of you. When he reaches down to rub his balls you know it’s pure pleasure guiding his actions.");
	outputText("\n\nFrom his reaction you can tell that he is enjoying this so you decide to up the stakes and put another finger into his blistering hot leaking hole. The two fingers stretch the hole and the minotaur’s penile muscle flexes like a happy little muscle man. Looking down you can see the minotaur rubbing his balls but, upon closer inspection, you see he is also pressing his swollen taint. He’s getting so turned on it’s crazy. When you retract your fingers and smear cum across his rock hard nipple he whimpers.");
	outputText("\n\nThe bull man grinds against your hand with a bitten lip and insatiable hips. In an attempt to get him to calm down a little you stuff three fingers into his cum slit. It doesn’t work in the slightest, if anything he’s now more wild as he tries to grind his big ass cheeks around in the dirt and rubs his taint and balls with not one but two hands.");
	outputText("\n\nThen you force a fourth finger into him. That is when his voice breaks as you cork his hole. With his pungent man juice fully stopped he finally goes limp but only for a second. Without warning, “Fuuuuuck.” Bursts from his chest as he reaches up and grabs his horns, every muscle in his body tenses as your fingers wiggle within the slimy hot passage you’ve jammed them into. Had it not been for your fingers the minotaur would be done at this point, you know from the hot mess that just surged against your fingers. Too bad the only place his hot sticky bull cum had to go was back from whence it came.");
	outputText("\n\nThen you pluck your finger from the cummy hole, licking the erotic residue off with your [tongue].");
	
	outputText("\n\nYou dip your index finger back into his cumslit, going back for seconds, and find you’re able to stretch the hole pretty easily.");
	outputText("\n\nWhen you penetrate his cum tunnel with a second finger he gasps and does this sexy little dance. Your two fingers feel as if they are wrapped in a swelteringly hot tunnel of fleshy smoothness.");
	outputText("\n\nHis voice gains this pleading edge to it as you push a third finger into his cum tunnel, feeling the flesh widen even further. His powerful thighs tense and you rub the diamond hard muscle with your free hand. He shivers as your fingers move around inside him in an effort to force the fleshy hole open. Soon enough you are able to put a fourth finger into his hot cum slit.");
	outputText("\n\nBefore you can start to even think about how you’re going to get your thumb into his big horse dong he begins to thrash wildly, fucking himself on your fingers like a bitch in heat. As he does this you tuck your thumb, allowing it to sink into the hot cummy depths of his fiercly pre-cumming pecker. The lust crazed bull man even goes so far as to grab your hand, his cock suddenly taking you clear up to your upper arm, he must really love the feeling of you stretching his hole and, since he loves it so damn much, you can think of something that will give both of you some mind blowing pleasure.");

	doNext(createCallBackFunction(minoMutualPt3, x));
}

private function minoMutualPt3(x:Number):void
{
	clearOutput();
	
	outputText("First you have to pry his grip off of your elbow and tug your own hand from the sweltering embrace of his fiercely leaking cock. The minotaur cringes, one hand holding his now throbbing segmented dong while the other still massages his huge balls.");
	outputText("\n\nWith a grin you take your own [cock] in hand and line it up with the bull man’s recently stretched penile slit. You look down at him, seeking confirmation which he supplies with a dreamy and somewhat hesitant nod.");
	outputText("\n\nYou take your [cock] in hand and begin to nose the tip against the widened hole to the minotaur’s urethra. A quivering moo worms its way out from between clenched teeth as you slowly increase the pressure. The minotaur’s voice cracks as your [cockHead] slides into him, every muscle in his body tensed as he receives you.");
	
	if (player.cocks[x].cockLength <= 7)
	{
		outputText("\n\nHe grunts as you suddenly thrust into him. The tight hole wrapped around your [cock] is stretched much larger than your hand could have. His body begins to thrust of its own accord again, an action you help it along with by grabbing the flared crown of his horse cock and force even more of your [cock] into his blissfully hot cock hole.");
	}
	else if (player.cocks[x].cockLength > 7 && player.cocks[x].cockLength <= 11) 
	{
		outputText("\n\nThe minotaur groans, a sound you’re not sure is pleasure or pain, as you stretch his urethra to accommodate your [cock], a hole much larger than your hand could have made. He takes a second to get used to the sensation and, once he does, begins to thrust up into you. You decide to help him get off and grab the flared crown of his flared horse cock before you begin forcing even more of your [cock] into his slimy hot cum tunnel.");
	}
	else if (player.cocks[x].cockLength > 11) 
	{
		outputText("\n\nThe minotaur’s face contorts as a weird growl emanates from his barrel chest. His urethra stretches just as you hoped it would, accepting your [cock] even as its owner gasps and groans beneath you. He trembles with wide eyes as he rubs his segmented horse cock, you can feel his hands through the hot slimy walls of his big dick. Once you feel he is sufficiently relaxed you begin to move. Displaying an impressive amount of self control you slide your [cock] in and out, going slow at first to let him get used to accommodating your length in this way. Once he begins softly thrusting against you though all bets are off. You grab the flared crown of his segmented horse cock and begin forcing even more of your [cock] into the hot embrace of his slimy cum tunnel.");
	}
	
	outputText("\n\nYou fuck his big horse cock hard, shoving as much of your [cock] into him as you can. You can feel his boiling cum surging around your dick as you pound his cock senselessly.");
	
	outputText("\n\nAs you wipe the left over residue of your spit and his cum onto his thigh the minotaur weakly smiles up at you. With a smile you resume your oral assault, determined to drain his nuts of every ounce of his hot baby batter.");
	outputText("\n\nAs you work to make the minotaur’s voice break, rise and fall over and over again, a glimmer of light catches your eye. Looking over you see a bottle with bubbling pink fluid in it sitting amidst some dried fluids, probably the remnants of a battle between a goblin and some other creature. Oh, the things you could do with that.");
	outputText("\n\nSmirking mischievously you snatch the lust draft up from where it lies on the ground. He doesn’t object in the slightest, too far gone from the fantastic attention you’ve lavished across his big burly body. Holding his segmented dick upright you uncork the lust draft and begin pouring the mixture into the flared head of his horse cock. The minotaur fidgets as you do, forcing you to tighten your grip to keep the fluid from spilling before you’re done.");
	outputText("\n\nFor a few moments you just sit and watch the fluid bubble, wondering how the lust inducing concoction will affect the minotaur when ingested through his cumslit instead of his bovine lips.");
	outputText("\n\nAs if to answer your unasked question the color of the fluid starts to get lighter and lighter as the minotaur’s precum mixes with the concoction. The fluid rolls and bubbles to a lesser degree but the scent it releases has your mouth watering. It is a combination of heady sex and your favorite meal, your own taste buds being turned perverse. Putting your [face] close to the minotaur’s dong you take a good long whiff.");
	outputText("\n\nThen, grinning at the sheer absurdity of it all, you press your lips against his flared cockhead and take a sip. The mixture is like a light but with an alcohol like kick at the end.");
	
	if (player.gender == 1) //Player is male
	{
		outputText("\n\nInstantly [eachCock] is at full mast. The lust inducing mixture, probably altered by the minotaur’s seminal fluid, warms your chest. You feel the intense urge to fuck, to use [eachCock] on any and everything you cum across. Even now you feel the wetness of your drooling loins salivating, desperately needing a hole to fill.");
	}
	else if (player.gender == 3) //Player is herm 
	{
		outputText("\n\nInstantly [eachCock] is at full mast as your [pussy] begs to be filled. The lust inducing mixture warms your [chest] the way alcohol would, probably due to the minotaur cum mixing with the lust draft. Your mind becomes consumed with the dual urges to fuck and be fucked. [EachCock] strains for a tight hole to fill while your [pussy] wants something big and drooling stuffed into its drooling opening. Even now you feel the wetness of your drooling loins salivating and you can’t help but wonder if there is another minotaur around here somewhere to make a [name] sandwich.");
	}
	
	outputText("\n\nYou drink your cocktail creation, each swallow sending a heady joy to your brain and [eachCock]. Your [face] twists into a silly grin as your loins stir with every sip.");
	
	outputText("\n\nThe minotaur gasps for breath while you reach down and grab your [cock]. As you rub your dick you look upon the inviting site of the minotaurs big burly body. His face is twisted in ecstasy, eyes rolled and tongue hanging out. His big barrel chest rises and falls rapidly, nipples every bit as hard as his cock. His big horse cock stands tall, like a tower leaking a steady waterfall of white cream. His big balls are drawn tight against his body like two living boulders covered in fuzz colored dark by his leaking seminal fluid. Then there is his hole, a winking little thing surrounded by two thick sculpted buns that look perfect for a little spanking. It is almost as if this big masculine bull man was made for your pleasure.");
	outputText("\n\nWhen you press your [cockHead] against the winking entrance to his anal cavity you feel the bullman clench, obviously not used to being on the receiving of any cock, including a [cock] like yours.");
	
	if (player.cocks[x].cockLength < 10) 
	{
		outputText("\n\nThe bullman winces when you shove your hips forward, sinking into the blissfully tight sweltering tunnel of his tail hole. He grunts as you fully hilt him, your [cock] sinking into his tight backdoor with a snarl. His eyes widen as he looks up at you, obviously trying to decide if he likes the feeling of being fucked."); 
		outputText("\n\nYou don’t give him the opportunity to make up his mind. instead you begin to pump your hips and send your [cockHead] hurtling into his prostate. He sends a hearty moo into the air, his body opening up to you instantly and allowing you to start really pounding the minotaur’s eager hole inward.");
	}
	else if (player.cocks[x].cockLength >= 10 && player.cocks[x].cockLength <= 24) 
	{
		outputText("\n\nThe bullman releases a pained grunt as you shove your hips forward, forcing your [cock] into the incredibly tight tunnel of his tail hole. Then you begin the process of hilting the minotaur who, apparently, hasn’t been fucked before.  Thanks to his rut you don’t have to be gentle. You shove against his rectal defenses, knocking them down one by one with brute force as the minotaur squirms and convulses as he is hit with the confusing sensation of painful pleasure. It takes some work but soon you’ve managed to submerge the full length of your [cock] into his barely cooperating tail hole."); 
		outputText("\n\nNow that you’ve managed to mold his innards to the shape of your [cock] you begin piston pumping the shivering hole until its owner is clawing at the cold earth between the two of you. Your hips slam into his upturned ass with a steady rhythm of harsh claps. His trembling moos rend the air as his body is forced to open up to your rectal assault, allowing you to really pound the minotaur’s now eager hole inward.");
	}
	else if (player.cocks[x].cockLength > 24) 
	{
		outputText("\n\nThe bullman’s entire body tenses up as you shove your [cockHead] into the unbearably tight tunnel of his virgin tail hole. You barely manage to get your dick head into the minotaur’s unwelcoming rectal entrance but that doesn’t matter because once you’re in, you begin forcing the rest of your enormous cock into his poor little hole. Thanks to his rut, though, he doesn’t seem to be suffering despite the hard time you’re having getting his hole to fit all of your [cock] inside. After a while of battering your [cock] against his anal walls and forcing them to stretch to accommodate the mass of meat that is your [cock] you manage to fully bury your fuck stick in his fuck me hole."); 
		outputText("\n\nYou stay here a minute, watching the minotaur’s eyes squeeze shut even as his cock trembles with arousal. Then you unceremoniously begin fucking the hell out of the minotaur’s perfectly tight hole. Your hips slamming into the muscled globes of his ass sends a timed clap into the air, one closer to that of a thunder clap than applause. The minotaur squeals and moos and yelps and begs for more as you distort his body and stab his guts with every full length thrust. Despite the sometimes agonized noises coming from his lips it is obvious that he is enjoying the way you’re pounding his hole raw.");
	}
	
	outputText("\n\nYour hips create a carnal drum beat against the minotaur’s spread ass. His voice provides a deep bass horn as he harmonizes with the growl rumbling in your chest. The erotic music rises into the air and like two masters would, the two of you synchronize and play a tune never heard before in all of Mareth.");
	outputText("\n\nThe mounting force of your ruthless thrusts causes his cock to whirl. The spinning sex organ sends pearly showers of pre in every direction and occasionally slaps against your [chest]. The way it flops around is almost hypnotic, as if the thick horse meat is begging for some attention.");
	outputText("\n\nYou decide to go all out and, since you’re a bit thirsty as well, you grab his huge dong and stuff the flared head into you mouth while you continue to fuck him with all the ferocity of a wild animal.");
	
	outputText("\n\nThe minotaur practically screams as the dual sensations cause his dick to really bring on the seminal fluid. It floods your mouth as his scent fills your nostrils. You’re hungry for his cum, for his ass, for his nipples and his lips. You want to fuck and fuck and fuck until his balls are sore from exhaustion. You want to breed this big masculine bitch until he looks pregnant from the titanic amount of seed you’ve fucked into his shivering bowels. You want him to give you a bittersweet meal of raw man juice from the source. You want to tug his balls and slap his ass and twist his nipples in every way you know he likes. You want to cum so many times that he’ll be able to taste your seed on his tongue.");
	outputText("\n\nYour desires well up inside you and you find yourself tugging the bull man’s nipple, a diamond hard bundle of flesh that stretches toward you as if beckoning. You tug and twist hard enough to make your point but not so hard as to hurt. His voice strains as you fuck suck and tug. Then your free hand rises and comes down on his burly ass with a resounding clap. This makes his already blissfully tight hole squeeze you. You accept the physical invitation and fuck him hard while occasionally smacking his ass and twisting his nipple.");
	outputText("\n\nYou’re giving the minotaur everything you’ve got and you can tell that the both of you are nearing the end of your coital interaction. So you suck and fuck with creamy white baby batter leaking from the corners of your mouth. The squelching sounds of your sucking are nearly drowned out by the fleshy clap, clap, clap of your trunk slamming into the bull man’s burly ass. As you continue to split his ass wide open while deep throating his segmented cock, the minotaur calls out in a sound easily confused with agony. You feel his rectal sleeve tighten around your [cock] and you force your [cock] through his convulsing hole, knowing exactly what is to come.");

	//Money shots
	outputText("\n\nYour bovine partner releases an unbelievably loud moo-like sound that vibrates his entire body. Moments later his hot thick cream boils over and your taste buds are alive with the flavor of hot cock juice as he violently erupts into your mouth.");
	outputText("\n\nThe way his happy hole shivers while you fuck it to pieces is too much.");
	
	if (player.balls > 0) 
	{
		outputText("\n\nYou feel your [balls] draw up and churn and all at once the world goes dark due to your eyes rolling up into the back of your head. With a throaty moan muffled by your mouthful of spurting horse cock you begin to roughly breed the bull man’s clenching rectal sleeve with a white hot river of dick cream.");
	}
	
	if (player.cumQ() <= 25) //Normal cum
	{
		outputText("\n\nYou shiver as your semen spurts into the groaning bull man.");
		outputText("\n\nLooking up you see his teeth are bared and every muscle on his sweat covered body stands in sharp relief, tensed as you ejaculate into his rectal sleeve. With his cum streaming down your chin you fuck him through your orgasm. Even as you groan you keep your lips locked around his member, swallowing none of the beast man’s seed but instead letting it fill your mouth and dribble out as you fill his ass.");
		outputText("\n\nThe minotaur’s voice rises as you drill his ass, enjoying the way your own jism feels inside of him. You fuck him until your [cock] can take no more of the intense sensation of post orgasmic fucking. So you pull your [cock] from his happy hole, leaving it gaping and glistening from your recent deposit.");
	}
	else if (player.cumQ() > 25 && player.cumQ() <= 250) //High cum
	{
		outputText("\n\nYou shiver as your [cock] pumps him full of your pearly seed. ");
		outputText("\n\nLooking up you see his bared teeth. Every muscle on his sweat covered body stands in sharp relief, tensed as you ejaculate into his rectal sleeve. With the minotaur’s own impressive load streaming down your chin you fuck him through your climax. Even as your own orgasm reaches its apex you keep your lips locked around the flared head of his horse cock, swallowing none of his jizz but instead letting it fill your mouth and spill out the way your seed fills his ass and spills out. His jizz slickened anal walls squelch erotically as you pound him raw.");
		outputText("\n\nThe minotaur’s voices rises, trying to match the fleshy applause caused by the way you slam your trunk into his big burly ass. You pound his wondrous ass until your [cock] can take no more of the intense sensations caused by your rapid post orgasmic fucking. You rise with your mouth full of mino cum and pull your [cock] from his happy hole. His battered tail hole gapes as a thin stream of creamy cum leaks from the glistening entrance");
	}
	else if (player.cumQ() > 250 && player.cumQ() < 500) //Very high cum
	{
		outputText("\n\nYou fuck your gushing [cock] deep into the minotaur’s clenching hole with powerful thrusts that clap against his muscular ass. He begins to whimper in helpless arousal as you roughly force your potent seed deeper and deeper into the bliss-inducing fleshy sleeve that is his anal passage.");
		outputText("\n\nLooking up at him you see teeth bared in ecstasy. Every muscle on his body bulges outward, tensed as he ejaculates into your mouth. Your impressive load is still flowing into him, causing his chiseled abs to lose a little definition as his body thickens from the excess liquid. Even as your own orgasm stretches on you keep your lips locked around the flared head of his big horse cock, swallowing none of his jizz but instead allowing his cum to fill your mouth and spill down your chin, the same way your seed is filling his ass and flowing down his crack. Your still spewing [cock] thrusts in and out of his cum caked anal walls, creating an erotic suckering noise as you breed him for all you are worth.");
		outputText("\n\nThe minotaur’s voice rises, breaking with every thrust as you decimate his rear entrance. Your bodies come together in a combination of ringing fleshy applause and wet squelching as you hose down his insides while slamming your trunk into his hard muscled ass. You fuck him through the entirety of your orgasm and keep at it until your [cock] can take no more of the intense sensations caused by your rough post orgasmic thrusts. So you rise with mino cum dripping from the corners of your mouth and pull your [cock] from the minotaur’s happy hole. Your baby batter drips from his now uncorked and gaping hole. It slides down the muscular cleft of his burly backside to create an impressive puddle as he squeezes his rectal muscles and pushes your cum outward.");
	}
	else if (player.cumQ() >= 500) //Extreme cum
	{
		outputText("\n\nYou slam your surging [cock] into the minotaur’s bliss inducing fuck hole, listening to the clap, clap, clap of your powerful thrusts rocketing into his muscled ass. He howls as you go ballistic and start fucking your hot baby batter deeper into his rectal passage.");
		outputText("\n\nLooking up at him you can see his teeth bared in ecstasy. Every muscle on his body bulge outward, tensed as he ejaculates into your mouth. His stomach begins to swell, the sheer amount of fluid you’re pumping into him causing his abs to disappear beneath a stomach that would look more at home on a woman pregnant with twins. Even so your orgasm rages on as you keep your lips locked around the flared head of his thick horse cock, swallowing none of his thick cream but instead letting it fill your mouth and flow down your chin. As you completely dominate the sexy bull man you can feel your seed spilling from his happy hole and flowing down his crack as you breed him for all you’re worth.");
		outputText("\n\nThe minotaur’s voice rises, breaking with every thrust as you decimate his muscled ass. Your bodies create a ringing fleshy applause and still his stomach swells. You keep it up, enjoying the boiling river of cum as it cakes his rectal walls and splashes around your [feet]. Soon you’re standing in an almost comically huge puddle of man milk, one that looks more like a small lake than anything else.");
		outputText("\n\nFeeling a little exhausted you rise, mino cum shining on your [face] as you keep your mouth closed and the erotic contents trapped inside. When you tug your [cock] from the minotaur’s battered hole your cum flows like a waterfall. As it cascades down his crack the minotaur moans, his stomach contracting as he pushes your spunk outward until his chiselled stomach has gained some semblance of its former self.");
		outputText("\n\nSpent and dripping from the anal cavity the minotaur’s limbs fall as he fully relaxes. His breaths are ragged huffs of splendid exhaustion, his eyes droopy as one hand rubs the hole you just finished fucking to pieces.");
	}
	
	outputText("\n\nBut you’re not done yet. With one of your [feet] you kick his legs back open and he lifts them obediently if not a little wearily. You simply press your hips into his soft horse cock and shove your mouth against his.");
	outputText("\n\nWhen you open your mouth you feel a deep moan rumble in his chest as he accepts his own sweet ejaculant back into his body. As you kiss you press your body against his, groping and grinding as his tongue and yours do the same. Then you feel him pushing his sweet dick cream back into your mouth. The kiss is intense as you swap spit and cum with a little bit drooling down your faces as the mino sucks the last dregs of his cum back into his mouth for the last time. After a few moments of this you rise and see a string of pearly goo connecting your lips to his. He looks up at you, intelligent brown eyes docile and submissive. You grin and wipe the cream from your lips with the back of your arm, smearing minotaur spunk across it. You rise to your knees above him, looking down in a way that isn’t threatening but doesn’t fail to assert your position as the dominant partner.");
	outputText("\n\n“Let me see it.” You command and the minotaur obeys, opening his mouth so you can gaze upon the creamy cock cream pooling around his wide tongue and bathing his white teeth in their sticky gooey goodness. Then with a grin you say, “Swallow.” and that is all it takes for him to  clamp his mouth shut. His prominent adam’s apple dances up and down as he swallows his own tasty man milk.");
	outputText("\n\nWith that you lean forward and tell him to clean your face. His wet tongue completely cleans your [face] and neck. Once he’s done you give the submissive bull man one last quick peck on the lips before rising and looking around for your discarded [armor].");
	outputText("\n\nBy the time you’re dressed the minotaur is sleeping softly and you leave him with a belly full of seed and a smile on his softly dozing face.");

	player.orgasm();
	combat.cleanupAfterCombat();
}

		public function joinBeingAMinoCumSlut():void
		{
			clearOutput();
			outputText("The prospect of getting a huge dose of that fresh minotaur cum is just too much to bear.  Before you realize what's happening, you're moving out of your rocky hiding spot and making your way down to the two bovine creatures, stripping your [armor] as you go.  By the time you reach the two figures, you're as naked as they are.  You shiver softly, whether due to some chill in the air or desperate anticipation, you can't say.");
			outputText("\n\nThe cow-girl is bent over, her hands on a low ledge with the minotaurs hands on either side of her ample ass.  She moans, more like a moo than a human groan, as the minotaur plunges into her quaking depths.  As you step forward, suddenly unsure of yourself, both the bull and the cow turn their sharp gazes on to you.  You feel very small");
			if (player.tallness <= 96) outputText(" despite your immense height");
			outputText(" as they look you up and down.  The entire area goes silent, even the goblins and the imps that are no doubt watching seem to be holding their breath, wondering what will happen to you.");
			outputText("\n\nThe minotaur grunts, finally, as if he finds you acceptable, and turns back to the plush ass before him, plowing into it once more.  The cow-girl, however, motions for you to move forward, and latches onto a [nipple] when you do.  Her soft lips encircle your areola, while her tongue dances over the rapidly hardening flesh of your teat.  Your breasts tingle with the slightest bit of suction, making you gasp as small droplets of milk escape your nipple and roll over the cow-girl's tongue.  She sucks more and more, eagerly gulping down your refreshing lactic beverage.");

			outputText("\n\nAll the while the minotaur continues grunting, thrusting his massive member into the woman's hungry cunt.  The two rock back and forth, pushing her face right into your breast before pulling back again.  The cow-girl's legs tremble and you suddenly find her arm grasping your shoulder for support.  Her other hand drifts down between your own naked legs, ");
			if (player.hasCock()) {
				outputText("ignoring your cock");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" entirely, ");
			}
			outputText("slipping a finger into your moistening ");
			if (player.hasVagina()) outputText("pussy");
			else outputText("asshole");
			outputText(".  A low moan escapes your lips as a second finger slips in while the busty bovine woman's thumb ");
			if (player.hasVagina()) outputText("swirls around your clitoris");
			else outputText("presses against your perineum");
			outputText(".");

			outputText("\n\nThe broad-shouldered minotaur urges his mate onto her knees while he does the same, his dick never leaving its temporary home.  The cow-girl pulls you along, bringing you to your knees and then onto your back.  You have a moment of sudden modesty as you fold your legs, trying to block your crotch from view.  The bovine woman simply chuckles in between moans and lightly presses your knees apart.  Your legs spread wide, lewdly showing off your nether region to the cow-girl, and anyone else that's watching.");

			outputText("\n\nWithout wasting any time, the girl leans down and");
			if (player.hasCock()) outputText(", once again ignoring your manhood completely");
			outputText(", dives tongue first into your wet ");
			if (player.hasVagina()) outputText("quim");
			else outputText("back door");
			outputText(".  The movement is so quick that you can't even suppress the sudden, perverted moan that leaves your lips... a moan that sounds shockingly like a cow's moo.  The surprise at your sudden bovine outburst quickly dissipates as the cow-girl's large tongue dips in and out of your ");
			if (player.hasVagina()) outputText("sodden box");
			else outputText("moist butthole");
			outputText(".  Any remaining fears of joining this very public sex show are gone, and you wonder why you didn't join in sooner.");

			outputText("\n\nThe tongue lavishes your hole, paying homage to your crotch in the only way it knows how.  Your breath comes shorter while your arms and legs tingle, fingers and toes curling against your will.  The cow-girl laps and licks, her broad mouth muscle slipping in and out, curving in and around to hit every tender part of your insides.  You run your fingers through the woman's long red hair, forcing her head even deeper into your crotch.  With her head down like this, you have an easy view of her ass high up in the air, getting fucked senseless by the minotaur.  Every thrust makes the cow-girl moan into your lap, the added vibrations causing you to squirm even more.");

			outputText("\n\nThe bull thrusts in to the hilt, letting out one final bellow of pleasure.  The cow-girl brings her head up, her mouth and chin slick and dripping with your juices.  She lets out a moo-like bellow along with the minotaur, whose balls churn, no doubt depositing a heavy load of that delicious cum directly into her waiting womb.  You lick your lips, wishing you could just wrap them around that cock right now, to get your fix and feel the blissful sensations of relief run across your body.");

			outputText("\n\nThe girl gibbers incoherently as she slides off the minotaur's still-rigid cock, a small spurt of pearly white spunk running down her thighs.  The minotaur smirks, smacking the cow's ass and casually pushing her to the side.  A goofy grin is plastered on her face, eyes rolled up into their sockets like she's just experienced the most divine fuck imaginable. He then looks you dead in the eyes and says, in a deep, masculine and very dominant voice, \"<i>You get to ride my cock next, cow.</i>\"");

			outputText("\n\nHis rough, strong hands grasp your legs and draw you closer.  You squirm half-heartedly, not really trying to get away.  Though your mind tries to fight it, you know all you really want is that warm, sticky cum inside you one way or another.  You want to be just like the half-unconscious girl beside you, stuffed with cock and turned into this rugged man's breeding bitch.");

			outputText("\n\n\"<i>Eager for a fucking, huh slut?</i>\" he taunts, his turgid member resting along your stomach.  You nod slowly.  You feel a deep burning in your core. You want that cock inside you.  You want to be filled to bursting with this bull's seed, to feel it churn ");
			if (player.hasVagina()) outputText("within your womb, knocked up by this manly beast");
			else outputText("within your bowels");
			outputText(".  \"<i>That's a good slut,</i>\" he grunts, pulling his cock off your belly and rubbing the slick, flat head against your awaiting [vagOrAss].  He teases you with the slight contact until you open your mouth to voice your complaints, then he suddenly thrusts inside.  Any words forming on your tongue fly away, replaced by a whine of relief as your hole gets stretched wide by the invading member.");
			if (player.hasVagina()) player.cuntChange(36, true, true, false);
			else player.buttChange(36, true, true, false);

			outputText("\n\n\"<i>Ahh, yeah.  That's some good ");
			if (player.hasVagina()) outputText("cow-pussy");
			else outputText("ass");
			outputText(" right there,</i>\" he groans, more of his bombastic cock slipping deep inside you.  The minotaur hooks an arm under each of your knees, lifting up your lower body, pressing even deeper.  Powerful sensations drift up from your ");
			if (player.hasVagina()) outputText("g-spot");
			else outputText("prostate");
			outputText(" as the minotaur's wide flare strokes it through your ");
			if (player.hasVagina()) outputText("vaginal");
			else outputText("anal");
			outputText(" walls.  Biting your lip with barely contained pleasure, you bring your hands to your breasts, playing with your milk-sodden nipples in between each orgasmic thrust of the bull's hips.");

			outputText("\n\nA giggle comes from your side, as you see the cow-girl is back up onto her knees, having recovered from her exalted orgasm.  She crawls forward, kneeling just over your head and leaning in to kiss her minotaur lover.  The two whisper sweet nothings to each other, too vague and indistinct to hear, but it doesn't matter.  All you can focus on is the dick lodged firmly inside of you... that, and the soaking cunt of the cow-girl just inches from your face.  Alabaster droplets drip down her legs, one even landing on your lips.  Before you can stop yourself, you lick them clean, savoring the taste of the second-hand cum.");

			outputText("\n\nSome part of your mind voices a complaint at what comes next, a voice that's quickly squelched inside the addiction-fueled haze of your brain.  You pull your head upwards and extend your tongue, slurping a large glob of cum from the cow-girl's snatch.  There's a surprised yelp from above you, followed by a coo of pleasure.  To your surprise, the cow-girl actually lowers her cunt down onto your face, giggling madly, filling your nostrils with the scent of her muff, with the scent of recent sex.  Not letting this opportunity go to waste, you repay her actions from earlier, slipping your ");
			if (player.tongueType == TONGUE_SNAKE) outputText("serpentine ");
			else if (player.tongueType == TONGUE_DEMONIC) outputText("demonic ");
			else if (player.tongueType == TONGUE_DRACONIC) outputText("draconic ");
			else if (player.hasLongTongue()) outputText("inhumanly long ");
			outputText("tongue inside her, eagerly licking out and guzzling down the remnants of the minotaur's present.");

			outputText("\n\nThe minotaur, for his part, is in no rush to give you a cream pie of your own. His thrusts are slow and deliberate, with a rhythm that has you writhing with pleasure.  The three of you moan together like some kind of erotic pyramid.  The bull's assault on your ");
			if (player.hasVagina()) outputText("womb");
			else outputText("back door");
			outputText(" increases slowly, and you can feel your limbs tingling at the prospect of your mino-cum-induced orgasm.");

			outputText("\n\nIt starts in your fingers, where your nerves seethe, gathering up fistfuls of grass like one might grab a sheet.  The heat continues down your arms and strikes your body like a lightning bolt, your belly suddenly spiking up, back arching as the orgasmic thunderstorm rolls over you.  The flames don't stop there, however.  They travel down into your crotch, suddenly lighting up every nerve in your ");
			if (player.hasVagina()) outputText("[vagina]");
			else outputText("[asshole]");
			outputText(" like a Christmas tree.  You're acutely aware of every single movement, every pulse, every little bit of contact between you and the huge cock living inside you.");

			outputText("\n\nYour muscles spasm and clench as the minotaur lets loose a powerful roar.  His own member twitches, suddenly releasing a flood of hot cum into your awaiting ");
			if (player.hasVagina()) outputText("womb");
			else outputText("bowels");
			outputText(".  The moment that long-awaited jism hits your walls, it's like another lightning bolt hits.  It travels up your spine and sets your entire brain aglow.  Ecstasy wrapped in bliss with a side of euphoric rapture consumes your thoughts.  Your vision goes white, pearly white like the seed filling your body, and your lips part as a primal \"<i>moo</i>\" slips out.");

			outputText("\n\nFor the longest time, the only thing your cum-addled mind can think about is cocks and cunts, of pregnant bellies and stomachs filled to capacity.  You mind fills itself with visions of yourself on your knees, servicing this minotaur daily, hoping to please him enough that he might grace your ");
			if (!player.hasVagina()) outputText("new ");
			outputText("womb with his divine dick.");

			outputText("\n\nIt takes several minutes for you to come down from this orgasmic high, and when you do, you see your minotaur lover has yet to recover from his.  He lays on his back in the midst of this clearing, his still-rock-hard cock jutting upwards, coating in a mixture of various juices.  The cow-girl sits beside him, carefully licking the towering pillar of cock clean.  You sit up, wobbly and clutch your stomach.  Filled with cum in two ends, you can't help but feel oddly unsatisfied.  Perhaps guzzling down some second-hand cum isn't quite enough to sate your hunger.  Perhaps you need it straight from the tap, as it were.");

			outputText("\n\nYou gingerly sit up, your body still quaking with pleasure.  Every movement sends another luxurious aftershock rippling through your body.  You crawl over to the splayed out minotaur, opposite your cow-girl partner, and join her in licking the man's cock clean.  It takes some work, but soon it glistens in the light of the red sky above you.");

			outputText("\n\nAs if you both possess some kind of bovine telepathy, you both lean forward, wrapping your ");
			if (player.bRows() > 1) outputText("uppermost ");
			outputText("breasts around his monolithic shaft.  Your faces meet and her soft lips press against yours, each of you earnestly pressing your tongues into the other's mouths, swapping the juices you've collected over the past hour or so.  The bull beneath you groans, awakening to the feeling of four breasts surrounding his love muscle.");

			outputText("\n\nThe two of your pump your breasts up and down, your lips barely leaving each other long enough to give his member the occasional kiss, lick or slurp.  Up and down you go, and this time it's the minotaur's body that's wracked with bliss, writhing on the ground.  Milk dribbles from your breasts, coating you, the cow-girl and the minotaur in a fine white sheen and creating a sweet-smelling aroma that permeates the air.");

			outputText("\n\nThe bull groans, biting his lip as a third, and likely final, orgasm rips through him.  His hips buck upwards, his cock flaring up and out of your mammaries.  Ropes of immaculate silver seed jet from his cumslit, arcing up into the air several feet before splattering down on your heads.  Wasting no time, you slip your lips around the flare, gulping down mouthful after mouthful of the sweet man-milk.  Even though it's his third load of the hour, it's just as big as the others, and soon your find you can't swallow any more; your cum-laden belly just won't allow it.");

			outputText("\n\nSadly, you relinquish your hold on his cock and sit back, watching the cow-girl opposite you pick up where you left off, slurping up whatever you missed with a dedicated fervor.");

			outputText("\n\n<b>Now</b> you feel satisfied.  Filled with that precious, precious minotaur spunk in both ends, fresh from the source.  You slump onto your back and drift off into a hazy, bull-filled dream world.");

			outputText("...");

			outputText("\n\nYou awaken several hours later.  The minotaur and the cow-girl are nowhere to be seen, but your [armor] is left neatly folded next to you, along with a small bottle filled with some white liquid, most likely a gift from your \"bull\".");

			outputText("\n\nYou quickly re-dress and head back to camp, spying the occasional goblin or imp scurrying from its hiding spot, no doubt recovering from their own self-inflicted orgasms.");
			player.orgasm('VaginalAnal');
			dynStats("lib", .5, "sen", -3, "cor", 1);
			if (flags[kFLAGS.PC_FETISH] > 0) {
				outputText("  A thrill runs through you.  Even though you were brought to such a satisfying climax, the whole thought that goblins and imps were watching you and getting off on it... it just makes you hornier than you were before.");
				dynStats("lus=", player.maxLust());
			}
			//Chance to impregnate PC, get mino-fix, and maybe relief from feeder perk.
			player.minoCumAddiction(10);
			player.knockUp(PregnancyStore.PREGNANCY_MINOTAUR, PregnancyStore.INCUBATION_MINOTAUR);
			if (player.hasStatusEffect(StatusEffects.Feeder)) {
				//You've now been milked, reset the timer for that
				player.addStatusValue(StatusEffects.Feeder, 1, 1);
				player.changeStatusValue(StatusEffects.Feeder, 2, 0);
			}
			//(Acquired minotaur cum!)
			model.time.hours++;
			inventory.takeItem(consumables.MINOCUM, camp.returnToCampUseOneHour);
		}

		public function watchAMinoCumSlut():void
		{
			clearOutput();
			outputText("Deciding not to risk it, you settle back into your nook in the rocks and watch on eagerly.  The cow-girl turns and places her hands on a low ledge, causing her to bend over, her ample ass facing the minotaur.  The minotaur closes the distance between them in a single step.");
			outputText("\n\nShe bellows, almost moaning, as the minotaur grabs her cushiony ass-cheeks with both massive hands.  Her tail raises to expose a glistening wet snatch, its lips already parted with desire.  She moos again as his rapidly hardening bull-cock brushes her crotch. You can't tear your eyes away as he positions himself, his flaring, mushroom-like cock-head eliciting another moan as it pushes against her nether lips.");
			outputText("\n\nWith a hearty thrust, the minotaur plunges into the cow-girl's eager fuck-hole, burying himself past one -- two of his oversized cock's three ridge rings.  She screams in half pain, half ecstasy and pushes back, hungry for his full length.  After pulling back only slightly, he pushes deeper, driving every inch of his gigantic dick into his willing partner who writhes in pleasure, impaled exactly as she wanted.");
			outputText("\n\nThe pair quickly settles into a rhythm, punctuated with numerous grunts, groans, and moans of sexual excess.  To you it's almost a violent assault sure to leave both of them bruised and sore, but the cow-girl's lolling tongue and expression of overwhelming desire tells you otherwise.  She's enjoying every thrust as well as the strokes, gropes, and seemingly painful squeezes the minotaur's powerful hands deliver to her jiggling ass and ponderous tits.  He's little better, his eyes glazed over with lust as he continues banging the fuck-hole he found and all but mauling its owner.");
			//[Next]
			dynStats("lus", 10);
			menu();
			addButton(0, "Next", watchMinoCumSlutII);
		}

		public function watchMinoCumSlutII():void
		{
			clearOutput();
			outputText("They go at it for nearly an hour, oblivious to you watching them, before their intensity heightens as they near orgasm.  The results are almost explosive, both of them crying out as they begin twitching uncontrollably.  Clinging desperately to the cow-girl's ass, the minotaur pumps so much cum into her depths that it begins spurting out.  This accidental lubrication releases his grip and the pair collapse to the ground.  Yet the minotaur isn't finished, his man-milk spraying into the air almost like his still-erect dick is a hose and splattering down onto both of them.");
			outputText("\n\nAs you look at the two cum-covered creatures laying there in their exhausted sex-induced stupors, the minotaur's thick horse-cock now slowly deflating, you realize that you've been touching yourself.  You make yourself stop in disgust.");
			outputText("\n\nOnly now do you notice other faces peeking over ledges and ridges.  You count at least two goblins and one imp who quickly pull back.  From the sounds, they were busy getting themselves off.  Apparently this isn't an uncommon show, and the locals enjoy it immensely.");
			dynStats("lus", 25);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function continueMinoVoyeurism():void {
			outputText("They go at it for nearly an hour, oblivious to you watching them, before their intensity heightens as they near orgasm. The results are almost explosive, both of them crying out as they begin twitching uncontrollably. Clinging desperately to the cow-girl's ass, the minotaur pumps so much cum into her depths that it begins spurting out. This accidental lubrication releases his grip and the pair collapse to the ground. Yet the minotaur isn't finished, his man-milk spraying into the air almost like his still-erect dick is a hose and splattering down onto both of them.\n\n", true);
			outputText("As you look at the two cum-covered creatures laying their in their exhausted sex-induced stupors, the minotaur's thick horse-cock now slowly deflating, you realize that you've been touching yourself.  You make yourself stop ", false);
			//[low corruption]
			if (player.cor < 33)
				outputText("in disgust.", false);
			else if (player.cor < 66)
				outputText("in confusion.", false);
			else
				outputText("reluctantly.", false);
			outputText("\n\nOnly now do you notice other faces peeking over ledges and ridges. You count at least two goblins and one imp who quickly pull back. From the sounds, they were busy getting themselves off.", false);
			//[if first appearance of this event]
			if (player.statusEffectv1(StatusEffects.MinoPlusCowgirl) == 0)
				outputText("  Apparently this isn't an uncommon show, and the locals enjoy it immensely.", false);
			//Lust!
			dynStats("lus", 5 + player.lib / 20 + player.minoScore() + player.cowScore());
			doNext(camp.returnToCampUseOneHour);
		}
}
}
