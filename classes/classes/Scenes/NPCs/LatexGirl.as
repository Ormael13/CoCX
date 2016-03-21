package classes.Scenes.NPCs{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;

	public class LatexGirl extends NPCAwareContent
	{

		public function LatexGirl()
		{
		}

//const GOO_TFED_MEAN:int = 654;
//const GOO_TFED_NICE:int = 655;
//const GOO_NAME:int = 656;
//const GOO_SLAVE_RECRUITED:int = 657;
//const GOO_EYES:int = 658;
//const GOO_TOSSED_AFTER_NAMING:int = 659;
//const TIMES_FUCKED_NORMAL_GOOS:int = 660;
//const PC_KNOWS_ABOUT_BLACK_EGGS:int = 661;
//const GOO_HAPPINESS:int = 662;
//const GOO_OBEDIENCE:int = 663;
//const GOO_FLUID_AMOUNT:int = 664;
//const GOO_PREFERRED_TIT_SIZE:int = 665;
//const GOO_NIPPLE_TYPE:int = 666;
//const GOO_DICK_LENGTH:int = 667;
//const GOO_DICK_TYPE:int = 668;
//const TIMES_THOUGHT_ABOUT_GOO_RECRUITMENT:int = 669;
//const GOO_INDIRECT_FED:int = 670;
//const TIMES_FED_LATEXY_MINO_CUM:int = 671;
//const LATEX_GOO_TIMES_FEMDOMMED_BY_PC:int = 672;

/*&Corrupt Plot:
Have sex with goos at least 5-6 times.
PC must have used a black egg at least once.
Defeat goo by lust.
Give it a black egg vaginally? and a succubi milk orally.
Latex 'skin' interferes with the usual goo methods of communication, and the succubi milk makes it more human-like.  The transformation makes it go unconscious and suitably intelligent or strong PCs can carry it back to camp.
When it wakes, explain that wanted a pet with all the advantages of goo and latex, and that she is that pet.
She fights you and runs away if she wins.
If she loses, she meekly accepts. (Happiness 0)

Stats:

Happiness - how happy she is in her confinement.
Obedience - decreases by 1 each day when happiness is below 75.  Increases if Happiness over 90.
Fluid % - 0 - 200%, decreases by 1 per day.  Minimum 1.
Preferred breast size - same scale as PC.  Cannot be higher than fluid level.  Use a scale ala Amily.
nipple type - -1 = cunt, 0 = normal, 1 = dicks
Dick length = 0 for none
Dick type = unlocked by giving proper transformative {default: dog}, {horse/cat/tentacle/demon}
Eye Color - determined by type of goo you recruit.
Misc Notes:


Runs away if unhappy.  Small chance of finding her and dragging her back once she escapes. (reset happiness/obedience to 0)
If happiness is below 50, she will ignore your preferred breast size and simply keep them at the maximum.  She will also set dick to 0 and nipple type to 0 randomly.
Obedience must be above 30 to set preferred breast size.
Obedience must be above 50 to set a dick length and type.
Obedience must be above 70 to set nipple type.
Happiness decreases whenever fluid level is less than 25 by 1 per day.
Happiness increases whenever fluid level is above 75 by 1 per day
Obedience decreases by 1 a week no matter what.
Sex before obedience is high enough greatly reduces happiness {varies per scene}.
Sex that gives fluids raises happiness.
Making her drink lust drafts raises obedience, reduces happiness if not followed by sex.
Making her consume anything else increases obedience at expense of happiness.
*/

/*
flags[kFLAGS.GOO_TFED_MEAN]
flags[kFLAGS.GOO_TFED_NICE]
flags[kFLAGS.GOO_NAME]
flags[kFLAGS.GOO_SLAVE_RECRUITED]
flags[kFLAGS.GOO_EYES]
flags[kFLAGS.GOO_TOSSED_AFTER_NAMING] = 1;
*/
public function gooFluid(arg:Number= 0, output:Boolean = true):Number {
	if (arg != 0) {
		flags[kFLAGS.GOO_FLUID_AMOUNT] += arg;
		if (output) outputText("\n<b>Fluid change: " + Math.round(arg*10)/10 + "%</b>");
		if (flags[kFLAGS.GOO_FLUID_AMOUNT] < 1) flags[kFLAGS.GOO_FLUID_AMOUNT] = 1;
		if (flags[kFLAGS.GOO_FLUID_AMOUNT] > 100) flags[kFLAGS.GOO_FLUID_AMOUNT] = 100;
	}
	return flags[kFLAGS.GOO_FLUID_AMOUNT];
}
public function gooHappiness(arg:Number = 0, output:Boolean = true):Number {
	if (arg != 0) {
		flags[kFLAGS.GOO_HAPPINESS] += arg;
		if (output) outputText("\n<b>Happiness change: " + Math.round(arg*10)/10 + "%</b>");
		if (flags[kFLAGS.GOO_HAPPINESS] < 1) flags[kFLAGS.GOO_HAPPINESS] = 1;
		if (flags[kFLAGS.GOO_HAPPINESS] > 100) flags[kFLAGS.GOO_HAPPINESS] = 100;
	}
	return flags[kFLAGS.GOO_HAPPINESS];
}
public function gooObedience(arg:Number = 0, output:Boolean = true):Number {
	if (arg != 0) {
		flags[kFLAGS.GOO_OBEDIENCE] += arg;
		if (output) outputText("\n<b>Obedience change: " + Math.round(arg*10)/10 + "%</b>");
		if (flags[kFLAGS.GOO_OBEDIENCE] < 1) flags[kFLAGS.GOO_OBEDIENCE] = 1;
		if (flags[kFLAGS.GOO_OBEDIENCE] > 100) flags[kFLAGS.GOO_OBEDIENCE] = 100;
	}
	return flags[kFLAGS.GOO_OBEDIENCE];
}
private function gooTits():String {
	return BreastStore.breastDescript(gooTitSize());
}

private function gooCock():String {
	return Appearance.cockDescription(CockTypesEnum.ParseConstantByIndex(flags[kFLAGS.GOO_DICK_TYPE]), flags[kFLAGS.GOO_DICK_LENGTH], flags[kFLAGS.GOO_DICK_LENGTH] / 6, 50, 100);
}
public function gooGetCockType():CockTypesEnum {
	return CockTypesEnum.ParseConstantByIndex(flags[kFLAGS.GOO_DICK_TYPE]);
}

public override function latexGooFollower():Boolean {
	return flags[kFLAGS.GOO_SLAVE_RECRUITED] > 0;

}

private function gooTitSize():Number {
	//If tits are lowered
	if (flags[kFLAGS.GOO_FLUID_AMOUNT]/2 >= flags[kFLAGS.GOO_PREFERRED_TIT_SIZE] && flags[kFLAGS.GOO_PREFERRED_TIT_SIZE] > 0) 
		return flags[kFLAGS.GOO_PREFERRED_TIT_SIZE];
	else 
		return flags[kFLAGS.GOO_FLUID_AMOUNT]/2;
}


//TF Scene:
public function meanGooGirlRecruitment():void {
	getGame().inCombat = false;
	clearOutput();
	flags[kFLAGS.GOO_TFED_MEAN] = 1;
	flags[kFLAGS.GOO_EYES] = monster.skinTone;
	if (player.hasItem(consumables.SUCMILK)) player.consumeItem(consumables.SUCMILK);
	else player.consumeItem(consumables.P_S_MLK);
	if (player.hasItem(consumables.BLACKEG)) player.consumeItem(consumables.BLACKEG);
	else player.consumeItem(consumables.L_BLKEG);
	outputText("You approach the horny gel-girl, admiring the marvelous, refractive hue of her soluble body for the last time.  Pulling the black egg from your pouches, you ");
	if (player.spe > 60) outputText("idly spin it on your finger, tossing it into the air and catching it on the next as you advance");
	else outputText("firmly grasp it in your hand as you approach");
	outputText(".  Uncomprehending, the goo girl looks up at you in confusion, eventually giving you a hopeful smile - the poor thing thinks you're going to fuck her!  You pat her on the head and instruct her to bend over.  She does of course, raising a delightfully feminine rump up out of her gooey base to present to you.  You can even see a pair of feminine lips, crafted perfectly in the form of a passion-inflamed female's.");
	outputText("\n\nWell, now's the time.  You take the egg and start to push it into her pussy, figuring it doesn't matter which hole she takes it in with her twisted anatomy.  The goo-girl quivers happily, her hole heating around your hand as you push the egg into the core.  Squirming pleasantly around you, her walls seem determined to milk phantom seed from your arm.");
	outputText("\n\nAbruptly, her motions stop, and you retract your arm before she can react, fearing she might try to imprison it in that gooey channel.  As you withdraw, her lips begin to darken, gradually turning opaque.  With a slosh of dismay, the goo-girl rises, spinning to face you.  Her lower lip is already a shining onyx, pouting and afraid.  Her arms rise angrily, covered in slowly growing black spots.  You were prepared for this and easily slip inside her guard, popping open the bottle of succubi milk you brought with you as you raise it to her lips.  The creamy fluid fills her mouth and the unholy flavor quickly sets her to swallowing.  Pulling the bottle out of your hands, she chugs the rest without thinking, not even noticing that her fingertips have solidified, becoming smooth solid things with clearly defined nails.  Her breasts enlarge as she finishes the draught, pulling her facedown on the ground.");
	outputText("\n\nShe wiggles but fails to rise, too encumbered by solidifying tits to move.  Her arms have congealed into smooth onyx up to the elbows by now, and her asscheeks are equally dark spheres of reflective material, just begging to be touched.  Below that, her pool is shrinking, pulling inward even as it becomes more opaque.  It divides in two, gradually twisting around itself until two shapely calves are visible, capped with a dainty pair of feet.  These solidify almost instantly - the transformation is accelerating!  Permeable membrane swiftly gives way to reflective, glossy latex all over her shuddering form, crafting the goo-girl into a visage of a bondage-slut's wet dream.  With her whole body changed from liquid to solid, the once-goo collapses into unconsciousness, black eyelids closing over her solid " + monster.skinTone + " eyes.");
	if (player.cor < 33) outputText("\n\nWorried that you might have killed her, you dart forward to check her breathing.  Whew!  She's okay, just out like a lamp.");
	else if (player.cor < 66) outputText("\n\nConfused as to why she lost consciousness, you go up to make sure she didn't die.  Thankfully, she's just out.");
	else outputText("\n\nIrritated that the items you fed her seem to be reacting in an unusual way, you stalk forward to make sure she didn't die.  Having this backfire would be a tremendous waste of two potent items!  Whew!  She's alive.");
	outputText("\n\nNow, you've got yourself a latex goo-girl... or a latex-girl... whatever.  How to get her home?");
	//{Intelligent:}
	if (player.inte >= 60) {
		outputText("\n\nYou quickly find a few pieces of wood and some strong reeds to use as rope.  It takes no more than 15 minutes to assemble the gathered components into a crude travois - one you'll have to carry.  Lifting the giant-breasted pile of sexy latex onto your construction proves to be quite the task, but you manage, barely.  Dragging her back to camp is no easier, but thanks to your quick wit, you save yourself a ton of effort.");
		//{fatigue + 20}
		player.changeFatigue(20);
	}
	//{Strong:}
	else if (player.str >= 60) {
		outputText("\n\nYou heave her up over your shoulder, straining your capable muscles to hold up those giant mammaries and remain upright.  The task is arduous, but you're strong enough for anything!  ");
		if (player.tou < 40) {
			outputText("Halfway there, you get too tired to continue.  You may be strong, but you don't have the endurance to heft a burden like this long term.  You'll have to leave her for now and try to recapture her once she's conscious.");
			doNext(camp.returnToCampUseOneHour);
			player.changeFatigue(30);
			return;
		}
		outputText("You're out of breath when you get to camp, but you made it!  It'll take awhile for you to catch your wind after all that work...  Your arms and legs are still burning from the exertion!");
		
		player.changeFatigue(10);
	}
	//Too weak and dumb: 
	else {
		 outputText("\n\nYou try to lift her, but she's too heavy!  Drat!  There's no way you'll get her back to camp like this, and you can't leave the portal undefended long enough to wait for her to wake.  You'll have to leave her for now and try to recapture her once she's awake.");
		 doNext(camp.returnToCampUseOneHour);
		 return;
	}
	//[Next] (Go to aftermath)
	menu();
	addButton(0,"Next",PCCarriedGooBackHome);
}

//Goo -> Latex Aftermath:
//PC Carried Her Back:
private function PCCarriedGooBackHome():void {
	clearOutput();
	outputText("You set the once-goo down in a secluded section of your camp");
	if (camp.companionsCount() > 0) outputText(", away from prying eyes");
	outputText(".  She looks almost alien in a way... more than she did before, when she was just an aqueous blob with tits and faux hair.  Now, every facet of her being is shiny, reflective latex.  Even her vaginal secretions, which dribble freely, are liquid latex, glossy black juices that slowly harden into a flexible solid once freed from her body.");
	if (player.totalCocks() > 1) outputText("  You can't help but wonder what it would feel like to let her sheath your " + player.multiCockDescriptLight() + " with her juices.");
	outputText("\n\nSurprisingly, she has hair, or what passes for hair for a woman made entirely of supple, inorganic semi-solids.  Her tresses hang down past her shoulders, slender strands that are as reflective as her skin.  Unlike her skin, the latex-goo's hair seems perpetually oily, slippery and lubricated.  Hesitantly, you extend a hand to touch, carefully caressing a few of the rubbery strands.  Their texture is smooth and slick, unlike any hair you've ever had the pleasure of touching.");
	outputText("\n\n\"<i>I can feel that, you know.</i>\"");
	outputText("\n\nYou backpedal wildly, surprised at the sudden statement to such a degree that you nearly fall flat on your [butt].  Giggling laughter bubbles up in response, \"<i>Sorry, I didn't mean to scare you.</i>\"");
	outputText("\n\nYou step forward, looking back down at your conscious prize.  She asks, \"<i>W-what happened to me?  I was... I was... was going to make you feel good... then...  You did this to me!</i>\"  She recoils, pressing her back against the rock, her form losing rigidity as her panic peaks.  The latex woman's back oozes over the boulder she presses against, her body slowly dissolving.  You reach out to stop her, but with a painful sounding snap, every semi-solid pseudopod recoils into place, dumping her forward onto her gigantic breasts.  It seems she's lost a good deal of her soluble flexibility.");
	outputText("\n\nLooking up at you, her panicked " + flags[kFLAGS.GOO_EYES] + " eyes seem as wide as dinner plates.  \"<i>Why did you do this to me?</i>\"");
	outputText("\n\nSmiling, you explain that the goo-girls of the lake have always intrigued you, and that it seemed like that was the best one to make one a little more... restrainable.  She moans in misery, hugging her hands across her expansive chest and shuddering, an action made all the more marvelous by the way her twisted body jiggles and shines in the light.  Holding your hands out peacefully, you explain ");
	if (player.cor < 33) outputText("that you'll be a nice [master].  She'll never be in want for the fluids she needs, and so long as she obeys you, you'll see to her other needs.");
	else if (player.cor < 66) outputText("that you'll be a good [master] for her.  You'll keep her healthy and satisfied, so long as she's obedient.");
	else outputText("that so long as she obeys you, she has nothing to fear.  She had better obey.");
	outputText("  Abruptly, you ask her what you should call her besides 'girl' or 'slave'.  Even pets need names, after all.");
	
	outputText("\n\n\"<i>Name?  My name is the warmth of my soul and the scent of the forgotten sea... or it was, before you made me like... this.  I don't think I could even communicate with my people properly at this point.  To your ears, I have no name, and honestly... my old name may as well be a forgotten memory.</i>\"  A solitary onyx teardrop runs from the corner of her eye, hardening on her cheek.  She brushes it away with a sniffle.");
	menu();
	addButton(0,"Next",PCCarriedGooBackHomeII);
}
private function PCCarriedGooBackHomeII():void {
	clearOutput();
	outputText("\"<i>Call me what you want, my name doesn't matter.</i>\"");
	outputText("\n\nWhat will you name her?");
	menu();
	addButton(0,"Next",nameZeLatexGoo);
	mainView.nameBox.text = "";
	mainView.nameBox.visible = true;
	mainView.nameBox.width = 165;
	mainView.nameBox.x = mainView.mainText.x + 5;
	mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
}
private function nameZeLatexGoo():void 
{
	if (mainView.nameBox.text == "") 
	{
		clearOutput();
		outputText("<b>You must select a name.</b>", false);
		mainView.nameBox.x = mainView.mainText.x + 5;
		mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		menu();
		addButton(0,"Next",nameZeLatexGoo);
		return;
	}
	flags[kFLAGS.GOO_NAME] = mainView.nameBox.text;
	mainView.nameBox.visible = false;
	//After Naming Her:
	clearOutput();
	outputText("\"<i>");
	if (flags[kFLAGS.GOO_NAME] == "Cattleya") outputText("Cattleya, huh?  I don't know if my tits are big enough to live up to that name,");
	else if (flags[kFLAGS.GOO_NAME] == "Helia") outputText("Helia, huh?  I don't know if I like anal enough for that!");
	else if (flags[kFLAGS.GOO_NAME] == "Urta") outputText("Urta, huh?  What do you take me for, a furry?  I guess it will have to do,");
	else if (flags[kFLAGS.GOO_NAME] == "Tifa") outputText("Tifa, huh?  I like the sound of that one!");
	else if (flags[kFLAGS.GOO_NAME] == "Aeris") outputText("Aeris, huh?  That sounds like a name for a hoity-toity pain in the ass!");
	else if (flags[kFLAGS.GOO_NAME] == "Latexy") outputText("Latexy, huh? That's, uh... real original...");
	else if (flags[kFLAGS.GOO_NAME] == "Goo") outputText("Goo, huh?  Wow, not too bright, are you?  Still, I guess I can live with it.  Call me Goo, I guess,");
	else if (flags[kFLAGS.GOO_NAME] == "Blacky") outputText("Blacky, huh?  Do I look like a horse or something?  I guess it will have to do,");
	else if (flags[kFLAGS.GOO_NAME] == "Fetish") outputText("Fetish, huh?  You're pretty transparent about your motives, aren't you?");
	else if (flags[kFLAGS.GOO_NAME] == "Fenoxo") outputText("Fenoxo?</i>\"  Her hair slowly morphs into a fedora.  \"<i>I'm not sure this is quite my look, but it's a lovely name,");
	else if (flags[kFLAGS.GOO_NAME] == "Maria") outputText("Maria?  Fuck, this isn't Cursed!  You don't expect me to turn you into a woman, do you?");
	else if (flags[kFLAGS.GOO_NAME] == "Valeria") outputText("Valeria? Wait, I've heard that name before...");
	else if (flags[kFLAGS.GOO_NAME] == "Christmas") outputText("Christmas, huh?  How very festive.  The big difference is that I can come more than once a year.");
	else if (flags[kFLAGS.GOO_NAME] == "Symphonie") outputText("Symphonie, eh?  That seems very... fitting.  Snug and comfortable, somehow,");
	else if (flags[kFLAGS.GOO_NAME] == "Savin") outputText("Savin, huh? Why would you want to name me after the second worst person since Stalin?");
	else if (flags[kFLAGS.GOO_NAME] == "Galatea") outputText("Galatea?  By Oblimo, that's a beautiful name!");
	else if (flags[kFLAGS.GOO_NAME] == "Kara") outputText("Kara, huh? Like, that sounds like a name for a girl with big gropable boobs in a French maid outfit!  I, like, totally love it!");
	else if (flags[kFLAGS.GOO_NAME] == "Karazelle") outputText("Karazelle, huh? Like, that sounds like a name for a girl with big gropable boobs in a French maid outfit!  I, like, totally love it!");
	else if (flags[kFLAGS.GOO_NAME] == "Jacques") outputText("Jacques?  That's kind of a boy's name isn't it?  ...Did my boobs just get bigger?");
	else if (flags[kFLAGS.GOO_NAME] == "Whitney") outputText("Whitney?  The farm-girl?  Well, I suppose I can fill in for that frigid cunt.");
	else if (flags[kFLAGS.GOO_NAME] == "Hedrah") outputText("Hedrah?  A nice strong name.  I approve,");
	else if (flags[kFLAGS.GOO_NAME] == "Third") outputText("Third, huh?  Do I speak with a silly accent and miss headshots all day long?  Well, I suppose it will work,");
	else if (flags[kFLAGS.GOO_NAME] == "Luckster") outputText("Luckster, huh?  Strange, I don't feel that Lucky.  Are there any cow-girls about?");
	else outputText(flags[kFLAGS.GOO_NAME] + ", huh?  I can live with that, I suppose,");
	outputText("</i>\" she muses, her mood brightening.  A storm cloud blows across her brow, darkening her gaze.  Petulantly, she asks, \"<i>Well, what now, [Master]?  What are the rules?</i>\"  Her voice carries an unhappy undercurrent that makes it clear she already resents her situation a little bit.");
	outputText("\n\nYou take her by the chin, tilting her head up to look at you.  ");
	if (player.cor < 50) outputText("Patiently");
	else outputText("Impatiently");
	outputText(", you explain that she is not to leave the camp.  The furthest she should go is to the stream, if she needs moisture.");
	outputText("\n\n\"<i>I don't need that much liquid... not any more,</i>\" " + flags[kFLAGS.GOO_NAME] + " says.  \"<i>I can already tell that I'm not losing it like I used to... but I still hunger for... well, juices.  I can probably live on water, but I won't be healthy that way.  I need you to feed me");
	if (player.gender == 0) outputText(", so please grow some genitals");
	outputText("!  Just every now and again...  It'll be pretty apparent when I'm hurting for food...  Take care of me, please?</i>\"");
	outputText("\n\nYou nod and tell her to get settled, you'll be back to check up on her shortly.");
	outputText("\n\n<b>(" + flags[kFLAGS.GOO_NAME] + " has been added to the slaves tab!)</b>");
	flags[kFLAGS.GOO_SLAVE_RECRUITED] = 1;
	flags[kFLAGS.GOO_HAPPINESS] = 1;
	flags[kFLAGS.GOO_OBEDIENCE] = 1;
	flags[kFLAGS.GOO_FLUID_AMOUNT] = 100;
	doNext(camp.returnToCampUseOneHour);
}
//PC Couldn't Bring Her Back
public function encounterLeftBehindGooSlave():void {
	clearOutput();
	if (flags[kFLAGS.GOO_TFED_NICE] > 0) {
		outputText("While exploring, you see something odd in the lake.  It's a black blob, barely visible in the azure waves, though it seems to be splashing wildly, as if it was struggling.  You walk up to the lake shore just as the black blob flops limply onto the beach, breathing hard.  It's the poor goo-girl that got turned into latex!");
		outputText("\n\n\"<i>It's... you...</i>\" she moans, looking up at you with wide " + flags[kFLAGS.GOO_EYES] + " eyes before they close...  It seems she's fainted.  She looks almost alien in a way... more than she did before, when she was just an aqueous blob with tits and faux hair.  Now, every facet of her being is shiny, reflective latex.  Even her vaginal secretions, which dribble freely, are liquid latex, glossy black juices that slowly harden into a flexible solid once freed from her body.");
		if (player.cockTotal() > 1) outputText("  You can't help but wonder what it would feel like to let her sheath your " + player.multiCockDescriptLight() + " with her juices.");
		outputText("\n\nSurprisingly, she has hair, or what passes for hair for a woman made entirely of supple, inorganic semi-solids.  Her tresses grow down past her shoulders, slender strands that are as reflective as her skin.  Unlike her skin, the latex-goo's hair seems perpetually oily, slippery and lubricated.  Hesitantly, you extend a hand to touch, carefully caressing a few of the rubbery strands.  Their texture is smooth and slick, unlike any hair you've ever had the pleasure of touching.");
		outputText("\n\n\"<i>I can feel that, you know.</i>\"");
		outputText("\n\nYou backpedal wildly, surprised at the sudden statement so much that you nearly fall flat on your [butt].  Giggling laughter bubbles up in response, \"<i>Sorry, I didn't mean to scare you.</i>\"");
		outputText("\n\nYou step forward, looking back down at the now-conscious once-goo.  She asks, \"<i>Is it really you?  I... after I tried to make you feel good, and this...</i>\" she indicates her latexy form and huge, blemishless breasts, \"<i>I never thought I would see YOU again.</i>\"  She looks away, struggling to her feet - and feet she has, a pair of long, slender legs, unlike the average googirl in the lake.  It seems she's lost a good deal of her amorphous qualities.");
		outputText("\n\nAs gently as you can, you try to tell her your side of the story: the black egg and milk fell out of your pack and splattered onto - into - her, and changed her.  She moans in misery, hugging her hands across her expansive chest and shuddering, an action made all the more marvelous by the way her twisted body jiggles and shines in the light.  You can't help but notice how sexy her body is, how sensual it seems, her latex form practically crying out for your touch and caress...  Just as the girl inside that body is crying in sorrow and desperation, you remind yourself.");
		outputText("\n\nTrying to be comforting isn't easy without knowing her name, though.  You ask her, trying to be as friendly as you can as you sit down beside her.");
		outputText("\n\n\"<i>Name?  My name is the warmth of my soul and the scent of the forgotten sea... or it was, before you made me like... this.  I don't think I could even communicate with my people properly at this point.  To your ears, I have no name, and honestly... my old name may as well be a forgotten memory.</i>\"  A solitary onyx teardrop runs from the corner of her eye, hardening on her cheek.  She brushes it away with a sniffle.");
	}
	else {
		outputText("While exploring, you see something odd in the lake.  It's a black blob, barely visible in the azure waves.  Occasionally, it splashes in frustration.  Curious, you find a nearby bush to hide behind and simply watch.  The onyx figure slams its arms into the water in a tremendous, enraged blow, blasting droplets of water a dozen feet into the air.  Then, it stalks up onto the shore and sits down, its globular breasts still wobbling as moisture runs in rivulets down its exotic, latex skin.");
		outputText("\n\nFiguring now is the best time, you exit your concealment to approach the odd, sexualized little package.  She notices at once, standing upright and shouting, \"<i>YOU!</i>\"");
		outputText("\n\n");
		if (player.cor < 33) outputText("Sighing apologetically");
		else if (player.cor < 66) outputText("Frowning");
		else outputText("Smirking");
		outputText(", you nod and admit, \"<i>Me.</i>\"  She rises, taking one shuddering step toward you, arms upraised threateningly.  You brace for a fight, but she stops, tumbling down to one knee.  Oily black tears drip from the corners of her " + flags[kFLAGS.GOO_EYES] + " eyes, raining unapologetically on the ground as she wails, \"<i>I can't hear them!</i>\"  The black drops splatter on the sand and grass, immediately hardening into a glossy, solid web.  You marvel at that as she continues, \"<i>I'm not a goo any more... my sisters... I'm deaf to them...</i>\"");
		outputText("\n\nThe latex woman takes a few more shuddering sobs before looking up at you with teardrops in her eyes.  \"<i>Why?  Why did you do this to me?  What do you want from me?</i>\"");
		outputText("\n\nSmiling, you explain that the goo-girls of the lake have always intrigued you, and that it seemed like the best way to make one a little more... restrainable.  She moans in misery, hugging her hands across her expansive chest and shuddering, an action made all the more marvelous by the way her twisted body jiggles and shines in the light.  Holding your hands out peacefully, you explain ");
		if (player.cor < 33) outputText("that you'll be a nice [master].  She'll never be in want for the fluids she needs, and so long as she obeys you, you'll see to her other needs.");
		else if (player.cor < 66) outputText("that you'll be a good [master] for her.  You'll keep her healthy and satisfied, so long as she's obedient.");
		else outputText("that so long as she obeys you, she has nothing to fear.  She had better obey.");
		outputText("\n\nYou take her by the hand and lift her to her feet, leading her to camp.  She plies you with questions, but you ignore her, bringing her back to a secluded portion of home.  Once safe and secure, you abruptly ask her what you should call her besides 'girl' or 'slave'.  Even pets need names, after all.");
		outputText("\n\n\"<i>Name?  My name is the warmth of my soul and the scent of the forgotten sea... or it was, before you made me like... this.  I don't think I can even communicate with my people properly at this point.  To your ears, I have no name, and honestly... my old name may as well be a forgotten memory.</i>\"  A solitary onyx teardrop runs from the corner of her eye, hardening on her cheek.  She brushes it away with a sniffle.");
	}
	menu();
	addButton(0,"Next",encounterLeftBehindGooSlaveII);
}
private function encounterLeftBehindGooSlaveII():void {
	clearOutput();
	outputText("\"<i>Call me what you want, my name doesn't matter.</i>\"");
	outputText("\n\nWhat will you name her?");
	//{To standard name prompts}
	menu();
	addButton(0,"Next",nameZeLatexGoo);
	mainView.nameBox.text = "";
	mainView.nameBox.visible = true;
	mainView.nameBox.width = 165;
	mainView.nameBox.x = mainView.mainText.x + 5;
	mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
}

//Pure Characters Intro(F):
public function pureGooRecruitmentStart():void {
	getGame().inCombat = false;
	clearOutput();
	flags[kFLAGS.GOO_TFED_NICE] = 1;
	flags[kFLAGS.GOO_EYES] = monster.skinTone;
	if (player.hasItem(consumables.SUCMILK)) player.consumeItem(consumables.SUCMILK);
	else player.consumeItem(consumables.P_S_MLK);
	if (player.hasItem(consumables.BLACKEG)) player.consumeItem(consumables.BLACKEG);
	else player.consumeItem(consumables.L_BLKEG);
	//Play after having defeated a Googirl, when you have a Black Egg & Succubi Milk in your inventory. Corruption less than 50.
	//NOTE: Starts with Obedience 30, Happiness 60~?
	outputText("The excitement of your scuffle proves too much for the goo-girl to keep up with and she collapses into the slime of her lower torso, her skin wiggling as she struggles to maintain cohesion.  Her expression is one of disappointment, and she looks at you with big, hopeful eyes, reaching out a hand, as if to offer an apology for her overexuberance.");
	outputText("\n\nAs you lean over the defeated goo-girl, trying to decide what to do with her, she suddenly surges forward, wrapping her goopy arms around you and pulling your face into her squishy tits.  You squirm as the goo-girl tries to give you a playful hug, apparently not quite finished with you yet, when your pack suddenly falls off!  You pull away in the confusion as your inventory clatters to the ground, but end up staring in surprise as the black egg you were carrying cracks right over the goo's head, pouring its latexy substance into her head even as your Succubi Milk pops open, spraying her " + monster.skinTone + " exterior with creamy milk.  Your eyes widen slightly as the two substances, black and white, trickle into her absorbent body, eventually slithering toward the heart-shaped core of her being.");
	outputText("\n\nAbruptly, her motions stop as the two substances swirl around her core, sucked in like seed into a hungry whore's mouth.  As the egg and milk mix inside her, the girl's lips begin to darken, gradually turning opaque.  With a slosh of dismay, the goo-girl rises, spinning to face you.  Her lower lip is already a shining onyx, pouting and afraid.  She raises her arms before her face, watching with abject horror as they become covered in slowly growing black spots.  She starts to waver, and falls to the ground; her fingertips have solidified, becoming smooth solid things with clearly defined nails that dig fearfully into the shore.  Her breasts enlarge as the last of the milk swirls into her heart, pulling her facedown on the ground.");
	outputText("\n\nShe wiggles but fails to rise, too encumbered by solidifying tits to move.  Her arms have congealed into smooth onyx up to the elbows by now, and her asscheeks are equally dark spheres of reflective material, just begging to be touched.  Below that, her pool is shrinking, pulling inward even as it becomes more opaque.  It divides in two, gradually twisting around itself until two shapely calves are visible, capped with a dainty pair of feet.  These solidify almost instantly - the transformation is accelerating!  Permeable membrane swiftly gives way to reflective, glossy latex all over her shuddering form, crafting the goo-girl into a visage of a bondage-slut's wet dream.  With her whole body changed from liquid to solid, the once-goo collapses into unconsciousness, black eyelids closing over her solid " + monster.skinTone + " eyes.");
	outputText("\n\nWorried that you might have killed her, you dart forward to check her breathing.  Whew!  She's okay, just out like a lamp.  You hold the poor girl in your arms for a long moment, looking around for somewhere to put her, for someone to help you deal with... whatever's she's just done to herself.  It looks like you've got yourself a latex goo-girl... or a latex-girl... whatever.  Leaving her out here seems cruel, as she'd certainly be snatched up by some horrid monster...  She'd be safer back at your camp, though that might be committing to a more long-term project than you're ready for.");
	//[Take her Home] [Leave Her]
	menu();
	addButton(0,"Take Home",niceGuysTakeLatexHome);
	addButton(4,"Leave Her",leaveTheLatexGooGirl);
}
//Leave Her(F)
private function leaveTheLatexGooGirl():void {
	clearOutput();
	outputText("You don't have the time to deal with this... thing.  You put the girl down on the shore and head on back to camp.  Hopefully, whatever finds her won't be TOO horrible.");
	doNext(camp.returnToCampUseOneHour);
}
//Take her Home(F)
private function niceGuysTakeLatexHome():void {
	clearOutput();
	//{Intelligent:}
	if (player.inte >= 60) {
		outputText("You quickly find a few pieces of wood and some strong reeds to use as rope.  It takes no more than 15 minutes to assemble the gathered components into a crude travois - one you'll have to carry.  Lifting the giant-breasted pile of sexy latex onto your construction proves to be quite the task, but you manage, barely.  Dragging her back to camp is no easier, but thanks to your quick wit, you save yourself a ton of effort.");
		//{fatigue + 20}
		player.changeFatigue(20);
	}
	//{Strong:}
	else if (player.str >= 60) {
		outputText("You heave her up over your shoulder, straining your capable muscles to hold up those giant mammaries and remain upright.  The task is arduous, but you're strong enough for anything!  ");
		if (player.tou < 40) {
			outputText("Halfway there, you get too tired to continue.  You may be strong, but you don't have the endurance to heft a burden like this long term.  You'll have to leave her for now and try to find her once she's conscious.");
			player.changeFatigue(30);
			doNext(camp.returnToCampUseOneHour);
			return;
		}
		outputText("You're out of breath when you get to camp, but you made it!  It'll take awhile for you to catch your wind after all that work...  Your arms and legs are still burning from the exertion!");
		player.changeFatigue(10);
	}
	//{Too weak and dumb:}
	else {
		outputText("You try to lift her, but she's too heavy!  Drat!  There's no way you'll get her back to camp like this, and you can't leave the portal undefended long enough to wait for her to wake.  You'll have to leave her for now and try finding her again once she's awake.");
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	//[Next] (Go to PURE aftermath)
	menu();
	addButton(0,"Next",pureGooGalRecruitAftermath);
}
//PURE Aftermath(F)
private function pureGooGalRecruitAftermath():void {
	clearOutput();
	outputText("You set the once-goo down in a secluded section of your camp.  She looks almost alien in a way... more than she did before, when she was just an aqueous blob with tits and faux hair.  Now, every facet of her being is shiny, reflective latex.  Even her vaginal secretions, which dribble freely, are liquid latex, glossy black juices that slowly harden into a flexible solid once freed from her body.");
	if (player.cockTotal() > 1) outputText("  You can't help but wonder what it would feel like to let her sheath your " + player.multiCockDescriptLight() + " with her juices.");
	outputText("\n\nSurprisingly, she has hair, or what passes for hair for a woman made entirely of supple, inorganic semi-solids.  Her tresses grow down past her shoulders, slender strands that are as reflective as her skin.  Unlike her skin, the latex-goo's hair seems perpetually oily, slippery and lubricated.  Hesitantly, you extend a hand to touch, carefully caressing a few of the rubbery strands.  Their texture is smooth and slick, unlike any hair you've ever had the pleasure of touching.");
	outputText("\n\n\"<i>I can feel that, you know.</i>\"");
	outputText("\n\nYou backpedal wildly, surprised at the sudden statement so much that you nearly fall flat on your [butt].  Giggling laughter bubbles up in response, \"<i>Sorry, I didn't mean to scare you.</i>\"");
	outputText("\n\nYou step forward, looking back down at the now-conscious once-goo.  She asks, \"<i>W-what happened to me?  I was... I was... Going to make you feel good, then you slipped and... oh, no!  What have I done!?</i>\"  She cries, starting to touch her now-latexy body. As her long, slender fingers begin to poke and prod her new body, she suddenly recoils, pressing her back against the rock, her form losing rigidity as her panic peaks.  The latex woman's back oozes over the boulder she presses against, her body slowly dissolving.  You reach out to stop her, but with a painful sounding snap, every semi-solid pseudopod recoils into place, dumping her forward onto her gigantic breasts.  It seems she's lost a good deal of her soluble flexibility.");
	outputText("\n\nLooking up at you, her panicked " + flags[kFLAGS.GOO_EYES] + " eyes seem as wide as dinner plates.  \"<i>W-what happened? I don't... how did... oh, no,</i>\" she whines, covering her face with her hands as sorrowful tears shudder through her new body.");
	outputText("\n\nAs gently as you can, you try to tell her what happened: the black egg and milk fell out of your pack and splattered onto - into - her, and changed her.  She moans in misery, hugging her hands across her expansive chest and shuddering, an action made all the more marvelous by the way her twisted body jiggles and shines in the light.  You can't help but notice how sexy her body is, how sensual it seems, her latex form practically crying out for your touch and caress...  Just as the girl inside that body is crying in sorrow and desperation, you remind yourself.");
	outputText("\n\nTrying to be comforting isn't easy without knowing her name, though. You ask her, trying to be as friendly as you can as you sit down beside her.");
	outputText("\n\n\"<i>Name?  My name is the warmth of my soul and the scent of the forgotten sea... or it was, before you made me like... this.  I don't think I could even communicate with my people properly at this point.  To your ears, I have no name, and honestly... my old name may as well be a forgotten memory.</i>\"  A solitary onyx teardrop runs from the corner of her eye, hardening on her cheek.  She brushes it away with a sniffle.");
	menu();
	addButton(0,"Next",pureGooGalRecruitAftermathII);
}
private function pureGooGalRecruitAftermathII():void {
	clearOutput();
	outputText("\"<i>Call me what you want, my name doesn't matter.</i>\"");
	outputText("\n\nWhat will you name her?");
	menu();
	addButton(0,"Next",nameZeLatexGooNice);
	mainView.nameBox.text = "";
	mainView.nameBox.visible = true;
	mainView.nameBox.width = 165;
	mainView.nameBox.x = mainView.mainText.x + 5;
	mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;

}

//After Naming Latexy(F):
private function nameZeLatexGooNice():void {
	if (mainView.nameBox.text == "") {
		clearOutput();
		outputText("<b>You must select a name.</b>", false);
		mainView.nameBox.x = mainView.mainText.x + 5;
		mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
		menu();
		addButton(0,"Next",nameZeLatexGoo);
		return;
	}
	flags[kFLAGS.GOO_NAME] = mainView.nameBox.text;
	mainView.nameBox.visible = false;
	clearOutput();
	outputText("\"<i>");
	if (flags[kFLAGS.GOO_NAME] == "Cattleya") outputText("Cattleya, huh?  I don't know if my tits are big enough to live up to that name,");
	else if (flags[kFLAGS.GOO_NAME] == "Helia") outputText("Helia, huh?  I don't know if I like anal enough for that!");
	else if (flags[kFLAGS.GOO_NAME] == "Urta") outputText("Urta, huh?  What do you take me for, a furry?  I guess it will have to do,");
	else if (flags[kFLAGS.GOO_NAME] == "Tifa") outputText("Tifa, huh?  I like the sound of that one!");
	else if (flags[kFLAGS.GOO_NAME] == "Aeris") outputText("Aeris, huh?  That sounds like a name for a hoity-toity pain in the ass!");
	else if (flags[kFLAGS.GOO_NAME] == "Latexy") outputText("Latexy, huh? That's, uh... real original...");
	else if (flags[kFLAGS.GOO_NAME] == "Goo") outputText("Goo, huh?  Wow, not too bright, are you?  Still, I guess I can live with it.  Call me Goo, I guess,");
	else if (flags[kFLAGS.GOO_NAME] == "Blacky") outputText("Blacky, huh?  Do I look like a horse or something?  I guess it will have to do,");
	else if (flags[kFLAGS.GOO_NAME] == "Fetish") outputText("Fetish, huh?  You're pretty transparent about your motives, aren't you?");
	else if (flags[kFLAGS.GOO_NAME] == "Fenoxo") outputText("Fenoxo?</i>\"  Her hair slowly morphs into a fedora.  \"<i>I'm not sure this is quite my look, but it's a lovely name,");
	else if (flags[kFLAGS.GOO_NAME] == "Maria") outputText("Maria?  Fuck, this isn't Cursed!  You don't expect me to turn you into a woman, do you?");
	else if (flags[kFLAGS.GOO_NAME] == "Valeria") outputText("Valeria? Wait, I've heard that name before...");
	else if (flags[kFLAGS.GOO_NAME] == "Christmas") outputText("Christmas, huh?  How very festive.  The big difference is that I can come more than once a year.");
	else if (flags[kFLAGS.GOO_NAME] == "Symphonie") outputText("Symphonie, eh?  That seems very... fitting.  Snug and comfortable, somehow,");
	else if (flags[kFLAGS.GOO_NAME] == "Savin") outputText("Savin, huh? Why would you want to name me after the second worst person since Stalin?");
	else if (flags[kFLAGS.GOO_NAME] == "Galatea") outputText("Galatea?  By Oblimo, that's a beautiful name!");
	else if (flags[kFLAGS.GOO_NAME] == "Kara") outputText("Kara, huh? Like, that sounds like a name for a girl with big gropable boobs in a French maid outfit!  I, like, totally love it!");
	else if (flags[kFLAGS.GOO_NAME] == "Karazelle") outputText("Karazelle, huh? Like, that sounds like a name for a girl with big gropable boobs in a French maid outfit!  I, like, totally love it!");
	else if (flags[kFLAGS.GOO_NAME] == "Jacques") outputText("Jacques?  That's kind of a boy's name isn't it?  ...Did my boobs just get bigger?");
	else if (flags[kFLAGS.GOO_NAME] == "Whitney") outputText("Whitney?  The farm-girl?  Well, I suppose I can fill in for that frigid cunt.");
	else if (flags[kFLAGS.GOO_NAME] == "Hedrah") outputText("Hedrah?  A nice strong name.  I approve,");
	else if (flags[kFLAGS.GOO_NAME] == "Third") outputText("Third, huh?  Do I speak with a silly accent and miss headshots all day long?  Well, I suppose it will work,");
	else if (flags[kFLAGS.GOO_NAME] == "Luckster") outputText("Luckster, huh?  Strange, I don't feel that Lucky.  Are there any cow-girls about?");
	else outputText(flags[kFLAGS.GOO_NAME] + ", huh?  I can live with that, I suppose,");
	outputText("</i>\" she muses, her mood brightening.  \"<i>I-I suppose I should start to get used to it... to all of this.  I... thank you, friend.  You didn't have to take me back here, to help me, but you did.  I'm grateful, truly I am.  But I don't think I would survive long out in the wilds, on my own.  I've lived my whole life as a goo, and it will take some time - years, maybe - to relearn how to survive on my own.  I know it's a lot to ask, but would you mind if I stayed here?  With... with you?  At least until I can get on my, uh, feet, as it were,</i>\" she says, her hands tracing along her body down to her new, dainty little feet.");
	//[Keep Her] [Boot her Out]
	menu();
	addButton(0,"Keep Her",niceGuysKeepTheirGooGals);
	addButton(1,"Boot Her", bootOutNiceGoo);
}
//Boot her Out(F):
private function bootOutNiceGoo():void {
	clearOutput();
	outputText("You did your civic duty bringing her back with you, but taking care of her in the long term... that's asking too much.  \"<i>I understand,</i>\" she says, bowing her head sadly as she struggles unsteadily to her feet.  \"<i>It's all right.  You've done more than enough, really.  I'll go.  Hopefully some of my sisters in the lake will be willing to help me, even if I'm so... so different... from them, now.  Goodbye, my friend.  Maybe we'll meet again sometime.</i>\"");
	outputText("\n\nShe's gone a moment later, waving over her shoulder as she unsteadily walks back toward the lake.");
	flags[kFLAGS.GOO_TOSSED_AFTER_NAMING] = 1;
	doNext(camp.returnToCampUseOneHour);
}

//Keep Her(F):
private function niceGuysKeepTheirGooGals():void {
	clearOutput();
	outputText("You take her by the chin, tilting her head up to look at you.  Of course you'll help her.  How could you not?  Overjoyed by your answer, " + flags[kFLAGS.GOO_NAME] + " throws her slender arms around you, pulling herself up so that her slick black lips press against yours.  \"<i>Oh, thank you! Thank you!</i>\" she cries, kissing you again.  Suddenly realizing what she's done, though, the latex-girl releases you and slips back against her rock, looking abashedly away.  \"<i>I'm sorry, I just...  Thank you.  I'm not going to just be a burden on you, I promise!  I don't know how much I can do, but so long as I'm here...  Just ask, for anything, and I promise I'll do my best.  It's the least I can do to pay you back for being so kind to me.</i>\"");
	outputText("\n\nYou smile, telling that seeing her safe and sound will be payment enough.  Speaking of which, what exactly is she going to need -- what can you do to help her now?  \"<i>All I used to need to survive was liquid, but... not that much.  Not any more,</i>\" " + flags[kFLAGS.GOO_NAME] + " says.  \"<i>I can already tell that I'm not losing it like I used to... but I still hunger for... well, juices.  I can probably live on water, but I won't be healthy that way.  I'll need you to, well, uh... feed me");
	if (player.gender == 0) outputText(", so you had better grow some genitals");
	outputText(".  Just every now and again, though - and I promise I'll make it feel good for you, too!  I'll try and let you know when I get... hungry... but keep an eye out for me, all right?  I'm not entirely used to this new metabolism yet..</i>\"");
	outputText("\n\nYou nod and tell her to get settled, you'll be back to check up on her shortly.");
	outputText("\n\n<b>(" + flags[kFLAGS.GOO_NAME] + " has been added to the slaves tab!)</b>");
	flags[kFLAGS.GOO_SLAVE_RECRUITED] = 1;
	flags[kFLAGS.GOO_HAPPINESS] = 60;
	flags[kFLAGS.GOO_OBEDIENCE] = 20;
	flags[kFLAGS.GOO_FLUID_AMOUNT] = 100;
	doNext(camp.returnToCampUseOneHour);
}


//Approach Her (Select From Slaves Tab)(F)
public function approachLatexy():void {
	clearOutput();
	//First Line - Happiness Dependent
	//(Sub 10)
	if (gooHappiness() < 10) outputText(flags[kFLAGS.GOO_NAME] + " scowls up at your approach, her unhappiness clearly visible in her " + flags[kFLAGS.GOO_EYES] + " eyes.  You doubt her solid onyx face could be any more morose.");
	//(Sub 20)
	else if (gooHappiness() < 20) outputText(flags[kFLAGS.GOO_NAME] + " glares at you as you approach, clearly unhappy with the situation.  She looks like she's having a pretty terrible time.");
	//(Sub 30) 
	else if (gooHappiness() < 30) outputText(flags[kFLAGS.GOO_NAME] + " frowns at you as you approach, more than a little displeased to see you.  She doesn't seem to be having a very good time.");
	//(Sub 40) 
	else if (gooHappiness() < 40) outputText(flags[kFLAGS.GOO_NAME] + " knits her eyebrows in consternation at your approach, visibly less than happy.  It doesn't look like she's thrilled to be here.");
	//(Sub 50)
	else if (gooHappiness() < 50) outputText(flags[kFLAGS.GOO_NAME] + " glances up at you when you approach, visibly bored.  She looks like she needs some cheering up.");
	//(Sub 60)
	else if (gooHappiness() < 60) outputText(flags[kFLAGS.GOO_NAME] + " gives you a wan smile as you approach, looking a tad bored.  Still, the glitter in her eyes tells you that she's still a good ways from unhappy.");
	//(Sub 70)
	else if (gooHappiness() < 70) outputText(flags[kFLAGS.GOO_NAME] + " cracks a small grin at the sight of you, happy to see you.  It's good to see her having a positive outlook.");
	//(Sub 80) 
	else if (gooHappiness() < 80) outputText(flags[kFLAGS.GOO_NAME] + " openly smiles at you as you approach, in good spirits, it seems.  Her sensual, fetishy skin reflects the light as she smiles, looking truly beautiful.");
	//(Sub 90) 
	else if (gooHappiness() < 90) outputText(flags[kFLAGS.GOO_NAME] + " grins at you, revealing rows of glittering black teeth.  She playfully regards you with happy, " + flags[kFLAGS.GOO_EYES] + " eyes.");
	//(Sub 100)
	else if (gooHappiness() < 100) outputText(flags[kFLAGS.GOO_NAME] + " bounces up at your approach, mouth splitting into a wide smile.  Her glittering, " + flags[kFLAGS.GOO_EYES] + " eyes twinkle with genuine pleasure.");
	//(MAX) 
	else outputText(flags[kFLAGS.GOO_NAME] + " jumps up on her feet at your approach, gleefully clapping her hands as you close in on her.  Her " + flags[kFLAGS.GOO_EYES] + " eyes and ecstatic visage make it clear how unbelievably happy she is.");
	//Second Line - Tit Size
	outputText("  ");
	//{Giant-Sized Titties}
	if (gooTitSize() >= 35) outputText("Utterly filled with moisture, her " + gooTits() + " are so big her arms can barely encompass them, her hands pressing fruitlessly against the sloshing sides.  The bubbly black surface bulges obscenely, barely containing the liquid weight within.");
	//{Very Big-Sized Titties}
	else if (gooTitSize() >= 24) outputText("Wobbling like crazy, her incredible chest barely stays bound up in her hands.  It completely obscures her torso from view.  Eventually, she gives up on restraining them and lets them slosh free.  You can't help but admire the flawless curves as you ponder how she can possibly remain upright.");
	//{Pretty nice sized} 
	else if (gooTitSize() >= 15) outputText("Big enough to hide most of her torso, the " + gooTits() + " sway and bounce ponderously.  Light reflects off the shiny, hypnotizing surface of her chest as she supports it with her hands.");
	//{Big SizedVolley}
	else if (gooTitSize() > 4) outputText("Well-rounded and jiggly, her " + gooTits() + " ripples slightly as she moves.  Those well-rounded spheres seem soft and firm at the same time.");
	//{LargeDD} 
	else if (gooTitSize() > 3) outputText("Sitting high on her chest, a proud pair of " + gooTits() + " jiggle slightly with her every movement.  They're still nice and round, but nowhere near the mammoths she had before.");
	//{MediumC} 
	else if (gooTitSize() > 2) outputText("High and curvy, her " + gooTits() + " looks pert and perky, topped with dark chocolate nipples.  The reflective surface makes them appear larger than they truly are, a feast of midnight darkness for your eyes.");
	//{LightA}  
	else outputText("Sitting high on her chest, her " + gooTits() + " seems almost disproportionately tiny for her frame.  The perky onyx nipples protrude invitingly, tiny caps of inviting midnight.");
	//{Regardless} 
	outputText("  You estimate " + flags[kFLAGS.GOO_NAME] + "'s chest would fit a " + Appearance.breastCup(gooTitSize()) + " bra, were she to wear one.");
	//Dicknips:
	if (flags[kFLAGS.GOO_NIPPLE_TYPE] == 1) outputText("  Those proud nipples have odd bulges at the tips, bulges that can swell tremendously, turning into rigid dicknipples.");
	//Cuntnips:
	else if (flags[kFLAGS.GOO_NIPPLE_TYPE] == -1) outputText("  Those proud nipples have a visible slit down the middle, just waiting to be spread into hungry pussies.");
	//Third Line - Fluid content
	//{Above 75}
	if (gooFluid() >= 75) outputText("  Her onyx lips are plush and inviting, full of liquid.  Likewise, her body seems flush and full of life, certainly not suffering for fluid nutrients.");
	//{Above 50}
	else if (gooFluid() >= 50) outputText("  Her onyx lips are full and pouty.  Likewise, her body is smooth and curvy, filled with plenty of fluid nutrients.");
	//{Above 25}
	else if (gooFluid() >= 25) outputText("  Her onyx lips look a little on the small side.  Likewise, her body is slim and narrow, not very filled out or curvy.  She could probably use more liquid nutrients.");
	//{Low} 
	else {
		outputText("  Her onyx lips are tiny, drawn into a thin line.  Likewise, her body is narrow and feeble, perhaps lacking in fluid sustenance.");
		if (gooFluid() <= 5) outputText("  She looks very unhealthy - she might be able to survive like this, but you can tell it will weigh heavily on her.");
	}
	//Fourth+ - special shit - NEWLINE
	outputText("\n\n");
	//{Dick}
	if (flags[kFLAGS.GOO_DICK_LENGTH] > 0) outputText("Below her waist, a " + num2Text(Math.round(flags[kFLAGS.GOO_DICK_LENGTH]*10)/10) + "-inch, " + gooCock() + " hangs, soft and shiny.  ");
	outputText("A glittering cleft that oozes with coal-colored lubricant nestles firmly at the joining of her sensuous latex legs.  They shine that much brighter thanks to the unnatural slickness.");
	//Last Pg Obedience:
	outputText("\n\n");
	//{sub 10}
	if (gooObedience() < 10) outputText(flags[kFLAGS.GOO_NAME] + " gives you a look of pure defiance, ready to disobey at the slightest notice.");
	//{sub 20}
	else if (gooObedience() < 20) outputText(flags[kFLAGS.GOO_NAME] + " idly twirls a raven lock of hair as she awaits your comment, a rebellious look glinting in her " + flags[kFLAGS.GOO_EYES] + " eyes.");
	//{sub 30}
	else if (gooObedience() < 30) outputText(flags[kFLAGS.GOO_NAME] + " smirks at you with a rebellious cast on her features.");
	//{sub 40}
	else if (gooObedience() < 40) outputText(flags[kFLAGS.GOO_NAME] + " bats charcoal eyelashes at you as she watches you with " + flags[kFLAGS.GOO_EYES] + ", fiery eyes, still far from obedient.");
	//{sub 50}
	else if (gooObedience() < 50) outputText(flags[kFLAGS.GOO_NAME] + " glances downwards for a moment, averting her eyes until she remembers to look up, defying her own submission.");
	//{sub 60}
	else if (gooObedience() < 60) outputText(flags[kFLAGS.GOO_NAME] + " casts her eyes down but peeks up through her charcoal eyelashes to regard you.");
	//{sub 70}
	else if (gooObedience() < 70) outputText(flags[kFLAGS.GOO_NAME] + " keeps her " + flags[kFLAGS.GOO_EYES] + " eyes cast down at the ground in deference to you, though she nervously draws in the dirt with a finger while she awaits a command.");
	//{sub 80}
	else if (gooObedience() < 80) outputText(flags[kFLAGS.GOO_NAME] + " fixes her gaze down obediently, her cheeks flushing purplish.  Is she enjoying submitting to you?");
	//{sub 90)
	else if (gooObedience() < 90) outputText(flags[kFLAGS.GOO_NAME] + " prostrates herself on the ground before you, tilting her head back so that she can fix her eyes on your waist, unfit to meet your gaze.");
	//{sub 100)
	else if (gooObedience() < 100) outputText(flags[kFLAGS.GOO_NAME] + " submissively prostrates herself before you, raising her onyx rump high as her forehead lowers.  Her cheeks and rump both manage to blush purple through her latex skin, clearly aroused by her own submissiveness.");
	//{MAX}
	else outputText(flags[kFLAGS.GOO_NAME] + " plants herself on all fours before you, kissing at your [feet].  Her smooth butt lightens along with her sides and cheeks, blushing violet with lust from the heat of her own submission.  Lewdly, she greets you, \"<i>[Master].</i>\"");
	outputText("\n\n<b>Fluid %:</b> " + Math.round(gooFluid()));
	outputText("\n<b>Happiness %:</b> " + Math.round(gooHappiness()));
	outputText("\n<b>Obedience %:</b> " + Math.round(gooObedience()));
	menu();
	addButton(14,"Back",camp.campSlavesMenu);
	addButton(0,"Feed Her",feedLatexy);
	if (player.gender > 0 && player.lust >= 33) addButton(1,"Use Her",useLatexy);
	addButton(3,"Breast Size",setLatexysBustSize);
	addButton(4, "Dick Options", changeGooDick);
	
	if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) addButton(14, "Back", kGAMECLASS.farm.farmCorruption.rootScene);
	
	if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 0 && flags[kFLAGS.FARM_CORRUPTION_STARTED] == 1) addButton(5, "Farm Work", sendToFarm);
	if (flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] == 1) addButton(5, "Go Camp", backToCamp);
}

private function sendToFarm():void
{
	clearOutput();
	
	outputText("You tell your goo pet that she is to head towards the lake, find a farm, present herself to the lady who works there and do as she says. The word “lake” has the effect you expected it would have; joy creases [latexyname]’s liquid face as you mention the Promised Land.");

	outputText("\n\n“<i>No sneaking off,</i>” you warn. “<i>I want you to work hard and earn the fluids you’ll be given.</i>”");

	outputText("\n\n“<i>As you wish [master],</i>” she sighs, before slowly sliding off in the direction of the lake. She will be utterly useless as either a worker or a protector, you think; however, you suspect if Whitney keeps her well fed she will be able to harvest latex from her, which is surely worth something, and maybe some good old fashioned exertion will do the willful goo some good.");
	
	flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] = 1;
	
	doNext(camp.returnToCampUseOneHour);
}

private function backToCamp():void
{
	clearOutput();
	
	outputText("You tell her to head back to camp; there are things you need to do to her you can’t do whilst she’s here. Repeatedly. [latexyname] pauses and then glances over towards the lake, clearly unhappy at the prospect of being torn away from it. However, she knows her place.");
	
	outputText("\n\nYou watch the creature make its slow, ponderous progress back towards camp.");

	flags[kFLAGS.FOLLOWER_AT_FARM_LATEXY] = 0;
	
	//[+1 Obedience and -1 Happiness every two days kept at the farm]
	doNext(kGAMECLASS.farm.farmCorruption.rootScene);
}

private function useLatexy():void {
	clearOutput();
	outputText("How will you use your pet?");
	menu();
	if (player.hasVagina()) {
		addButton(0,"DomWithVag",femalePCDomFucksLatexGoo);
		if (flags[kFLAGS.GOO_DICK_LENGTH] > 0) addButton(1,"RideGooCock",femalePCDomFucksLatexGooFuta);
	}
	if (player.hasCock()) addButton(2,"DickFuckHer",malePCDomFucksLatexGoo);
	addButton(4,"Back",approachLatexy);

}

//Setting Dick Type(F)
private function changeGooDick():void {
	clearOutput();
	//Supah High obedience slut!
	if (gooObedience() >= 60) {
		outputText("You ");
		if (flags[kFLAGS.GOO_DICK_LENGTH] == 0) outputText("ask " + flags[kFLAGS.GOO_NAME] + " if she's ever considered growing a dick for fun.");
		else outputText("ask her if she'd like to change what kind of dick she has.");
		outputText("  She whimpers and moans, \"<i>[Master], I loved growing penises back before I changed.  More than that, ");
		if (flags[kFLAGS.GOO_DICK_LENGTH] == 0) outputText("I want to grow one for you.  ");
		else outputText("I want you to order me to shift it often.  ");
		outputText("Changing myself further, twisting my body into a sexual playground for you... that would be the ultimate thrill!</i>\"");
		if (flags[kFLAGS.GOO_DICK_LENGTH] == 0) outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " pulls a hand away from her pussy and says, \"<i>I'll need something masculine if you want me to grow a cock, [Master].  An incubi draft would work, or some minotaur blood, though the blood might make it a horsecock...</i>\"  She shudders and closes her eyes, imagining herself with a rigid equine pole.  Your goo must have a bit of a fetish.");
		else outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " pulls a hand away from her pussy and says, \"<i>What kind of penis would please you most?  I could probably do the human ones, dog dicks, horse cocks, cat pricks, tentacle wangs, or demon dongs.</i>\"  She gives a little shudder at the last one and licks her lips.  \"<i>You'll need to have an appropriate item to assist me though, [Master].  I'm not as flexible as I once was.");
	}
	//High Happiness + Whatever Obedience(F)
	else if (gooHappiness() >= 70) {
		outputText("You ask " + flags[kFLAGS.GOO_NAME] + " if ");
		if (flags[kFLAGS.GOO_DICK_LENGTH] == 0) outputText("she's ever considered growing a dick for fun.");
		else outputText("she'd like to change what kind of dick she has.");
		outputText("  She beams and titters, \"<i>Omigod, I loved growing penises back before I changed!  It was so much fun to see how surprised it would make people and to make new shapes to see how they'd feel.  Let's do it!</i>\"");
		if (flags[kFLAGS.GOO_DICK_LENGTH] == 0) outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " taps her chin and says, \"<i>I'll need something masculine if you want me to grow a cock.  An incubi draft would work, or some minotaur blood, though the blood might make it a horsecock...</i>\"  She smiles wickedly.");
		else outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " taps her chin and says, \"<i>I can probably make almost any kind of penis, though I only really like the human ones, dog dicks, horse cocks, cat pricks, tentacle wangs, and demon dongs.</i>\"  She gives a little shudder at the last one and licks her lips.  \"<i>You'll need to have an appropriate item to assist me though, I'm not as flexible as I once was.");
	}
	//Low Obedience(F)
	else {
		outputText("You ");
		if (flags[kFLAGS.GOO_DICK_LENGTH] == 0) outputText("ask " + flags[kFLAGS.GOO_NAME] + " if she's ever considered growing a dick for fun.");
		else outputText("she'd like to change what kind of dick she has.");
		outputText("  She rolls her eyes and says, \"<i>Sorry, but I think you've made me change quite enough for right now.</i>\"");
		outputText("\n\nShe's going to have to learn to be a little more obedient before she'll do that.");
		gooObedience(-3);
		menu();
		addButton(0,"Next",approachLatexy);
		return;
	}
	menu();
	if (flags[kFLAGS.GOO_DICK_LENGTH] > 0) {
		if (player.hasItem(consumables.CANINEP) && flags[kFLAGS.GOO_DICK_TYPE] != CockTypesEnum.DOG) addButton(2,"Canine Pepper",latexyEatsADickItem,consumables.CANINEP);
		if (player.hasItem(consumables.EQUINUM) && flags[kFLAGS.GOO_DICK_TYPE] != CockTypesEnum.HORSE) addButton(3,"Equinum",latexyEatsADickItem,consumables.EQUINUM);
		if (player.hasItem(consumables.P_DRAFT) && flags[kFLAGS.GOO_DICK_TYPE] != CockTypesEnum.HUMAN) addButton(4,"Pure Draft",latexyEatsADickItem,consumables.P_DRAFT);
		if (player.hasItem(consumables.W_FRUIT) && flags[kFLAGS.GOO_DICK_TYPE] != CockTypesEnum.CAT) addButton(5,"Whisker Fruit",latexyEatsADickItem,consumables.W_FRUIT);
		if (player.hasItem(consumables.INCUBID) && flags[kFLAGS.GOO_DICK_TYPE] != CockTypesEnum.DEMON) addButton(0,"Incubi Draft",latexyEatsADickItem,consumables.INCUBID);
		if (player.hasItem(consumables.MINOBLO) && flags[kFLAGS.GOO_DICK_TYPE] != CockTypesEnum.HORSE) addButton(1,"Mino Blood",latexyEatsADickItem,consumables.MINOBLO);
		if (player.hasItem(consumables.GROPLUS) && flags[kFLAGS.GOO_DICK_LENGTH] < 24 + (flags[kFLAGS.HYPER_HAPPY] ? 0 : 36)) addButton(6,"Gro Plus",latexyEatsADickItem,consumables.GROPLUS);
		if (player.hasItem(consumables.REDUCTO) && flags[kFLAGS.GOO_DICK_LENGTH] >= 5) addButton(7,"Reducto",latexyEatsADickItem,consumables.REDUCTO);
	}	
	else {
		if (player.hasItem(consumables.INCUBID)) addButton(0,"Incubi Draft",latexyEatsADickItem,consumables.INCUBID);
		if (player.hasItem(consumables.P_DRAFT)) addButton(0,"Pure Draft",latexyEatsADickItem,consumables.P_DRAFT);
		if (player.hasItem(consumables.MINOBLO)) addButton(1,"Mino Blood",latexyEatsADickItem,consumables.MINOBLO);
	}
	addButton(14,"Back",approachLatexy);
}
	
private function latexyEatsADickItem(item:ItemType):void {
	player.consumeItem(item,1);
	clearOutput();
	outputText(flags[kFLAGS.GOO_NAME] + " uses your proffered item without a second though.  Surprisingly she doesn't seem to react in any way, aside from closing her eyes and taking on a look of incredible concentration.  ");
	if (flags[kFLAGS.GOO_DICK_LENGTH] == 0) {
		outputText("Her onyx mound bulges, the luscious lips spreading around something internal.  Gradually, they part like a silken veil to reveal a ");
		if (item == consumables.MINOBLO) outputText("flattened head");
		else outputText("bulbous crown");
		outputText(".  The newborn cock-tip thickens, spreading her wider as it gradually droops out of the female flesh surrounding it.  ");
		flags[kFLAGS.GOO_DICK_LENGTH] = 8;
		flags[kFLAGS.GOO_DICK_TYPE] = CockTypesEnum.HUMAN;
		if (item == consumables.MINOBLO) {
			outputText("On and on it comes.  She's truly going to be hung like a stallion at this rate!   ");
			flags[kFLAGS.GOO_DICK_LENGTH] = 13;
			flags[kFLAGS.GOO_DICK_TYPE] = CockTypesEnum.HORSE;
		}
		outputText("Then, it begins to stiffen, arching up into full arousal.  The new-grown cock appears to have grown from her clit, but as you lean down to examine her vagina, you realize her cunt has shifted down slightly, and a new clit has grown to replace the old.");
		outputText("\n\n\"<i>You're making it harder!</i>\" " + flags[kFLAGS.GOO_NAME] + " whines, trying to cover it with her hands.  Of course, that only makes it harder, and a bead of oily pre-cum beads at the tip.  You could get used to this.  <b>" + flags[kFLAGS.GOO_NAME] + " now has a " + num2Text(flags[kFLAGS.GOO_DICK_LENGTH]) + "-inch ");
		if (item == consumables.MINOBLO) outputText("horse-");
		outputText("cock!</b>");
		gooObedience(5);
	}
	else {
		if (item == consumables.GROPLUS) {
			outputText("Her " + gooCock() + " shivers, and starts to sprout outward from the base, lengthening before your very eyes.  One... two... three... new inches of gleaming prick reveal themselves to you!\n\n" + flags[kFLAGS.GOO_NAME] + " giggles, \"<i>You sure do like them big!</i>\"");
			flags[kFLAGS.GOO_DICK_LENGTH] += 3;
		}
		else if (item == consumables.REDUCTO) {
			outputText("Her " + gooCock() + " trembles, and starts to shrink inward, disappearing into her polished abdomen.  The effect is so startling profound that you have to do a double-take.  " + flags[kFLAGS.GOO_NAME]+ "'s penis is barely two thirds its original size!\n\nShe giggles, \"<i>Not a fan of the big boys, huh?</i>\"");
			flags[kFLAGS.GOO_DICK_LENGTH] = Math.round(flags[kFLAGS.GOO_DICK_LENGTH] * .66);
		}
		else {
			outputText("Her " + gooCock() + " rapidly erects, rising to full tumescence in seconds.  The veins begin to shift, crawling around under her onyx skin like little worms as her penis reshapes it.  A muffled moan escapes from " + flags[kFLAGS.GOO_NAME] + "'s lips along with a discharge of black pre-cum from her tip and slit.  Then, with a powerful flex, the latex woman's penis solidifies into a new shape.  <b>" + flags[kFLAGS.GOO_NAME] + "'s maleness is now a ");
			if (item == consumables.CANINEP) flags[kFLAGS.GOO_DICK_TYPE] = CockTypesEnum.DOG;
			if (item == consumables.EQUINUM) flags[kFLAGS.GOO_DICK_TYPE] = CockTypesEnum.HORSE;
			if (item == consumables.P_DRAFT) flags[kFLAGS.GOO_DICK_TYPE] = CockTypesEnum.HUMAN;
			if (item == consumables.W_FRUIT) flags[kFLAGS.GOO_DICK_TYPE] = CockTypesEnum.CAT;
			if (item == consumables.INCUBID) flags[kFLAGS.GOO_DICK_TYPE] = CockTypesEnum.DEMON;
			if (item == consumables.MINOBLO) flags[kFLAGS.GOO_DICK_TYPE] = CockTypesEnum.HORSE;
			outputText(gooCock() + "!</b>");
		}
		gooObedience(2);
	}
	menu();
	addButton(0,"Next",approachLatexy);
}
//Setting Preferred Bust Size(F)
private function setLatexysBustSize():void {
	clearOutput();
	outputText("You ask " + flags[kFLAGS.GOO_NAME] + " if she wouldn't mind keeping her tits around a certain size.");
	//Low Obedience
	if (gooObedience() < 60) {
		outputText("\n\nShe puts her hands on her hips and shouts, \"<i>As if!  I'll make 'em as big or as small as I want!  You're already getting a sexy latex woman who's dependent on you for sexual fluids - you don't need to micromanage everything about me too!</i>\"  She blushes a little when she realized she just discussed her new self as 'sexy'.  She must like this a little more than she lets on.");
		gooObedience(-2);
		menu();
		addButton(0,"Next",approachLatexy);
		return;
	}
	//Decent Obedience
	else if (gooObedience() < 80) outputText("\n\nShe nods and casually hefts her tits in her hands, bouncing them back and forth as if to distract you.  \"<i>How big do you want these beauts?  I could have nearly immobilizing udders down to pert apples.  A word of warning though - it's easy to keep 'em small when I'm well hydrated, but keeping them large when I'm low on fluids isn't going to be possible.  If you like grand titons on your sexy slave-girls, you'll have to keep me well fed.</i>\"  A violet blush colors her cheeks when she realized she just referred to herself as your sexy slave-girl, so she tries to change the topic.  \"<i>By well fed, I mean sexed.  Because, you know, goo-girl.</i>\"  It didn't work very well.");
	//Highly obedient
	else {
		outputText("\n\nShe nods and casually hefts her tits in her hands, bouncing them back and forth with a slutty expression on her face.  \"<i>How big do you want me to be, [Master]?  I could be a big-breasted whore for you, barely able to move under the weight of my own tits.  Then you'd have a mountain of latex cleavage to play in.  Or, I could keep them as pert, apple-sized breasts that just barely fit into your hands.  I'd be a glossy, petite slut for you then, wouldn't I?</i>\"  She groans at the thoughts coursing through her obedient, depraved little mind and whimpers, \"<i>Just keep me well fed if you want them full, [Master].  Without enough fluid, I can't keep them big!</i>\"  " + flags[kFLAGS.GOO_NAME] + " watches you, awaiting the command to change herself.");
	}
	menu();
	if (gooTitClass(gooTitSize()) != 1) addButton(0,"A-Cups",changeLatexyTits,1);
	if (gooTitClass(gooTitSize()) != 2) addButton(1,"C-Cups",changeLatexyTits,3);
	if (gooTitClass(gooTitSize()) != 3) addButton(2,"DD-Cups",changeLatexyTits,4);
	if (gooTitClass(gooTitSize()) != 4) addButton(3,"Volleyballs",changeLatexyTits,8);
	if (gooTitClass(gooTitSize()) != 5) addButton(4,"Basketballs",changeLatexyTits,15);
	if (gooTitClass(gooTitSize()) != 6) addButton(5,"Huge",changeLatexyTits,24);
	if (gooTitClass(gooTitSize()) != 7) addButton(6,"Gigantic",changeLatexyTits,35);
	if (flags[kFLAGS.GOO_PREFERRED_TIT_SIZE] != 0) addButton(7,"Whatever",changeLatexyTits,0);
	addButton(14,"Back",approachLatexy);
}
private function gooTitClass(arg:int):int {
	if (arg >= 35) return 7;
	else if (arg >= 24) return 6;
	else if (arg >= 15) return 5;
	else if (arg > 4) return 4;
	else if (arg > 3) return 3;
	else if (arg > 2) return 2;
	else return 1;
}


//She Changes Her Bust Size(F)
private function changeLatexyTits(arg:int = 0):void {
	clearOutput();
	//PC wants tits bigger than current preferred and fluid not sufficient to reach new size
	if (gooTitClass(arg) > gooTitClass(flags[kFLAGS.GOO_PREFERRED_TIT_SIZE]) && gooTitClass(flags[kFLAGS.GOO_FLUID_AMOUNT]/2) < gooTitClass(arg)) {
		//If already as big as possible
		if (gooTitClass(flags[kFLAGS.GOO_FLUID_AMOUNT]/2) == gooTitClass(gooTitSize()))
			outputText(flags[kFLAGS.GOO_NAME] + " nods, but her body doesn't change.  \"<i>There's not enough of me to make them any bigger right now.  You'll have to feed me if you want to see what they'll look at... full size.</i>\"");
		//Tits can't quite grow to max size:
		else 
			outputText(flags[kFLAGS.GOO_NAME] + " places her hands on her nipples and takes a deep breath.  She holds it for one second... two... three...  As she exhales, her breasts visibly inflate, not with air, but with ponderous liquid weight.  Unfortunately, they stop short of the size you requested.  " + flags[kFLAGS.GOO_NAME] + " just doesn't have enough juice to fill them... yet.  She tells you that once you feed her enough she'll be as rounded as you requested.");
	}
	//To max {Giant}size!
	else if (gooTitClass(arg) == 7) {
		outputText(flags[kFLAGS.GOO_NAME] + " places her hands on her nipples and takes a deep breath.  She holds it for one second... two... three...  As she exhales, her breasts visibly inflate, not with air, but with ponderous liquid weight.  They grow bigger and bigger, until they nearly obscure her waist.  They're clearly heavy, with something of a teardrop shape to them.  In between them, the lush latex cleavage draws your eyes.  Part of you wants to climb in and see if you can disappear into those heavy, latex-encased udders.");
	}
	//To huge {very nice} size!
	else if (gooTitClass(arg) == 6) {
		//BIGGER
		if (gooTitClass(gooTitSize()) < 6) outputText(flags[kFLAGS.GOO_NAME] + " places her hands on the underside of her breasts and winks.  As you watch, her " + gooTits() + " fill with greater and greater amounts of goo, stretching out to accommodate their obscene liquid weight.  They don't stop until they're nearly the size of beach balls, swaying heavily and obscuring most of your pet's torso from view.  Inky cleavage wobbles with every movement, inviting you to put something inside it.");
		//Smaller: 
		else outputText(flags[kFLAGS.GOO_NAME] + " places her hands on the underside of her gigantic breasts and winks.  Before your eyes, the mammoth mounds slowly recede, compressing their excessive mass into a smaller, more manageable form.  The smaller tits don't stop their shrinkage until they just barely obscure " + flags[kFLAGS.GOO_NAME] + "'s torso from view.  They still have an unbridled amount of cleavage, but now they come in a form that might be a little easier for your companion to carry.");
	}
	//To basketball {pretty nice} sized
	else if (gooTitClass(arg) == 5) {
		//Bigger: 
		if (gooTitClass(gooTitSize()) < 5) outputText(flags[kFLAGS.GOO_NAME] + " cups her " + gooTits() + " and pinches on her areola, tugging them outward.  The reflective black flesh gives to her pulls, stretching out and growing heavy with newfound weight.  The mammary growth doesn't stop until the breasts are about as big as basketballs, though far more jiggly.  The cleavage in between those impressive orbs seems to go on forever, almost inviting you to place something in it.");
		//Smaller: 
		else outputText(flags[kFLAGS.GOO_NAME] + " sighs and grabs hold of her bloated breasts.  She presses down, compressing them inward.  As if by magic, the pressure actually causes the oversized jugs to decrease in size.  They get smaller and smaller until they're just about the size of basketballs, still very big by any measure.  " + flags[kFLAGS.GOO_NAME] + "'s cleavage remains impressive, but not to such an obscene degree.  The women back home would've killed to have hooters like her.");
	}
	//To volley ball {big} sized
	else if (gooTitClass(arg) == 4) {
		//Bigger: 
		if (gooTitClass(gooTitSize()) < 4) outputText(flags[kFLAGS.GOO_NAME] + " giggles and asks, \"<i>Are you sure we can't go bigger?  The best part about being latex is that my new skin holds the shape without much work from me.  I can have huge, floor-dragging tits without any fuss!  Fuck, I'd be so horny having my nipples catch on every pebble!</i>\"  She sighs as she fantasizes and pulls on her nipples.  With every tug, her breasts expand a little bigger, engorging with fresh fluid.  They slosh and shake a little as they even out into volleyball-sized tits with a gorgeous slash of cleavage dividing them.");
		//Smaller:
		else outputText(flags[kFLAGS.GOO_NAME] + " sighs and says, \"<i>I wish you would've made me make them bigger.  Then I could crawl around on my hands and knees, dragging them on the ground and trying not to cum every time a nipple snagged on a pebble.</i>\"  She sighs as she fantasizes and pushes down on her oversized tits.  As if by magic, they shrink, compressing down until her breasts are about the size of volleyballs with a gorgeous slash of cleavage dividing them.");
	}
	//To DDish {large} sized:
	else if (gooTitClass(arg) == 3) {
		//Bigger: 
		if (gooTitClass(gooTitSize()) < 3) outputText(flags[kFLAGS.GOO_NAME] + " sighs as she cups her breasts and breaths, \"<i>Grow,</i>\" aloud.  Like the obedient sweater-puppies they are, her breasts expand and fill.  Their curves fill, the cleavage deepens, and " + flags[kFLAGS.GOO_NAME] + " smiles at the result.  Her breasts are now around a DD-cup - just as requested.");
		//Smaller: " + 
		else outputText(flags[kFLAGS.GOO_NAME] + " groans in disappointment, \"<i>I liked em big!  Well, you're the boss...</i>\"  She clenches her fists and closes her eyes.  Nothing happens at first, but after a moment, her " + gooTits() + " tighten up.  Over the span of a few dozen seconds, " + flags[kFLAGS.GOO_NAME] + " is reduced to having something like a DD-cup - a nice but fairly normal size, as ordered.");
	}
	//To C {medium} sized:
	else if (gooTitClass(arg) == 2) {
		//Bigger: 
		if (gooTitClass(gooTitSize()) < 2) outputText(flags[kFLAGS.GOO_NAME] + " says, \"<i>Well, that's a start I suppose.</i>\"  She cups her tiny teats and massages them with gentle gropes.  Each time, they jiggle a little bit more.  Almost as soon as she starts, she stops, leaving them as curvy C-cups.  \"<i>Could we go bigger?</i>\"");
		//Smaller: 
		else outputText(flags[kFLAGS.GOO_NAME] + " shudders, but obeys.  First, she presses down on her " + gooTits() + ", then, she blinks her eyes closed and shivers.  Before your eyes, the breast-flesh diminishes, eventually settling on a pair of curvy C-cups.  \"<i>I look like I must be dehydrated!  Good thing the other girls can't see me!</i>\"");
	}
	//To A {light} sized:
	else if (gooTitClass(arg) == 1 && arg > 0) {
		outputText(flags[kFLAGS.GOO_NAME] + " says, \"<i>I'll look anemic!  The other goo-girls will think I'm starving!</i>\"  You give her a condescending look and she sighs.  \"<i>All right, all right.  If my [master] wants tiny tits, " + player.mf("he'll","she'll") + " get them.</i>\"  She grabs hold of her " + gooTits() + " and compresses them in her grip.  Amazingly, the latex chest-flesh recedes into her as she pushes, diminishing before your very eyes.  She whimpers when they hit B-cups and groans when they reach A's.  " + flags[kFLAGS.GOO_NAME] + " pulls her hands away to show you the fruits of her labors - two tiny breasts, each barely a palmful.  A river of latex lubricants runs from her cleft, her arousal enhanced by the very act of obeying you against her wishes.");
	}
	else {
		outputText(flags[kFLAGS.GOO_NAME] + " blushes and gives you a smile that would be radiant, were it not on a midnight black canvas.  \"<i>Thank you.</i>\"");
		gooHappiness(2);
	}
	flags[kFLAGS.GOO_PREFERRED_TIT_SIZE] = arg;
	if (gooObedience() < 75) gooObedience(3);
	doNext(camp.returnToCampUseOneHour);
}
	
//Feeding Her(F)
//Can be fed cum, girl-cum, minotaur cum.  
//Can be fed directly or indirectly.  
//Direct feeding boosts happiness a fair bit but reduces obedience until obedience is over 50.
//Indirect feeding increases happiness somewhat.
private function feedLatexy():void {
	clearOutput();
	outputText("How will you feed her?");
	if (player.lust < 33 && player.gender > 0) outputText("  You aren't aroused enough to try and feed her any sexual fluids.");
	menu();
	if (player.hasCock() && player.lust >= 33) {
		addButton(0,"Cum, Indirect",feedLatexyCumIndirectly);
		addButton(1,"Cum, Direct",feedLatexyCumDirectly);
	}
	if (player.hasVagina() && player.lust >= 33) {
		addButton(2,"GirlCum, Ind.",feedLatexyGirlCumIndirectly);
		addButton(3,"GirlCum, Dir.",feedLatexyGirlCumDirect);
	}
	if (gooHappiness() >= 50 && player.lactationQ() >= 100 && player.biggestTitSize() >= 3) addButton(4,"Milk",feedLatexySomeMilk);
	if (player.hasItem(consumables.MINOCUM)) addButton(5,"MinoCum Nic",minotaurCumFeedingGoo, true);
	if (player.hasItem(consumables.MINOCUM)) addButton(6,"MinoCum Ruf",minotaurCumFeedingGoo, false);
	
	addButton(14,"Back",approachLatexy);
}

//Feed Cum Indirectly(F)
private function feedLatexyCumIndirectly():void {
	clearOutput();
	//{1st Time, any indirect scene:  
	if (flags[kFLAGS.GOO_INDIRECT_FED] == 0) {
		outputText("You toss a wooden bowl on the ground in your latex pet's area.  She looks more than a little confused by this development, poking it and asking, \"<i>What's this for?</i>\"\n\n");
		flags[kFLAGS.GOO_INDIRECT_FED] = 1;
	}
	outputText("Glancing down at " + flags[kFLAGS.GOO_NAME] + ", you tell her that it's feeding time.  She turns her gaze upward, more than a little eagerly");
	if (gooObedience() < 70) outputText(" and unashamedly reaching for your [armor].  You bat her hands away, forcing her greedy little latex digits to wait along with the rest of her");
	else outputText(", obediently waiting with her tongue wagging.");
	if (gooFluid() < 33) {
		outputText("  The hunger in her eyes is so relentless you fear her gaze could drill directly into your ");
		if (player.balls == 0) outputText("body");
		else outputText("ballsack");
		outputText(".");
	}
	else if (gooFluid() < 66) outputText("  The hunger in her eyes is a palpable thing, one you fear could prod her into rash action.");
	else if (gooFluid() < 90) outputText("  The hunger in her eyes is a lazy thing.  It doesn't seem that strong, but she's always willing to drink more.");
	else outputText("  The hunger in her eyes is a decadent, gluttonous thing that's barely roused by the prospect of fresh seed.  It still causes her to smear a lick across her shiny lips.");
	outputText("\n\n[EachCock] easily hardens as it's removed from your restraining gear, already fairly turgid.  You experimentally pump ");
	if (player.cockTotal() > 1) outputText("one");
	else outputText("it");
	outputText(", plumping it to full rigidity with a few quick strokes.  " + flags[kFLAGS.GOO_NAME] + " can only watch the salacious display with rapt attention, one hand nervously stroking her thigh while the other fiddles with her hair.  Willingly waiting, she seems to understand that you're just here to provide her with sustenance.  It doesn't make it any easier for her to restrain her lusts.");
	outputText("\n\nAs you rapidly masturbate, " + flags[kFLAGS.GOO_NAME] + "'s hands slip into her oil-slicked tunnel.  Two of her fingers are devoured by the pliable slit, engulfed in sable moisture.  Then, a third joins its kind, nosing in to massage the slick sensual walls within.  The panting latex woman easily allows her fourth finger to stretch her slit wide, exposing the ebony interior to you as fuel for your masturbatory ardor.  Her thumb grazes across her clit as she begins to rock her hips at you, lewdly thrusting as she begins to drool rivulets of raven honey.");
	outputText("\n\nYou groan, equally enraptured by the display she's putting on for you.  Soon, you're ");
	if (player.cumQ() < 250) outputText("oozing a thicker river of pre-cum than normal");
	else if (player.cumQ() < 500) outputText("dripping even more pre-cum than usual");
	else if (player.cumQ() < 1000) outputText("dribbling pre-cum");
	else outputText("oozing out a river of pre-cum");
	outputText(".  The sensitive skin around your [cockHead] is the perfect fodder for a quick caress, one that makes your spine tingle with forced sensation.  You pump again and shudder at the exquisite jolt of electric bliss, rocking your hips involuntarily.  " + flags[kFLAGS.GOO_NAME] + " is watching expectantly for the first sign of your jizz.");
	outputText("\n\nRather than disappoint those eager eyes, you cum.  The torrent of heat that swells inside you doubles in power and then, explodes.  You arch your back and pump forward, barely remembering to angle your " + player.multiCockDescriptLight() + " down toward the bowl before you spurt.  Spooge squirts from ");
	if (player.cockTotal() > 1) outputText("all of ");
	outputText("your tip");
	if (player.cockTotal() > 1) outputText("s at once");
	outputText(", raining down into the bowl in thick white ropes.");
	if (player.cumQ() >= 500) outputText("  In a short time, you have overfilled it, so you settle for spraying the remainder over your rubbery prize.  Long strands of sticky, slick breeding fluid rain over her charcoal mane, painting into a gray mop.");
	if (player.cumQ() >= 1000) outputText("  Still, you relentlessly pump yourself through more and more ejaculations, until the ground can bear no more and a puddle forms below.");
	if (player.cumQ() >= 4000) outputText("  That puddle swiftly fills into a foot deep lake of spunk, a muddy morass of your own virile semen.");
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " dives into the bowl with gusto, greedily devouring every drop.  Her tongue hangs free, thrashing against the polished wood as more and more of her latex mouth-muscle spools free to help with the feeding.  In seconds, the bowl is emptied");
	if (player.cumQ() >= 500) outputText(", and she turns to cleaning herself");
	outputText(".");
	if (player.cumQ() >= 1000) outputText("  Sadly, the copious jizz that puddled up has already been devoured by the dry ground.  It seems the dirt can drink faster than your latex slave.");
	//{Boost her fluid quantity, bonus for over 250mL.}
	temp = 20;
	if (player.cumQ() >= 500) temp += 10;
	gooFluid(temp);
	//{Boost her happiness a tiny amount.}
	gooHappiness(4);
	player.orgasm();
	doNext(camp.returnToCampUseOneHour);
}
//Feed Lady-Cum Indirectly(F)
private function feedLatexyGirlCumIndirectly():void {
	clearOutput();
	//{1st Time, any indirect scene:  
	if (flags[kFLAGS.GOO_INDIRECT_FED] == 0) {
		outputText("You toss a wooden bowl on the ground in your latex pet's area.  She looks more than a little confused by this development, poking it and asking, \"<i>What's this for?</i>\"\n\n");
		flags[kFLAGS.GOO_INDIRECT_FED] = 1;
	}
	outputText("Glancing down at " + flags[kFLAGS.GOO_NAME] + ", you tell her that it's feeding time.  She turns her gaze upward, more than a little eagerly");
	if (gooObedience() < 70) outputText(" and unashamedly reaching for your [armor].  You bat her hands away, forcing her greedy little latex digits to wait along with the rest of her");
	else outputText(", obediently waiting with her tongue wagging.");
	if (gooFluid() < 33) outputText("  The hunger in her eyes is so relentless you fear her gaze could drill directly into your [vagina].");
	else if (gooFluid() < 66) outputText("  The hunger in her eyes is a palpable thing, one you fear could prod her into rash action.");
	else if (gooFluid() < 90) outputText("  The hunger in her eyes is a lazy thing.  It doesn't seem that strong, but she's always willing to drink more.");
	else outputText("  The hunger in her eyes is a decadent, gluttonous thing that's barely roused by the prospect of fresh seed.  It still causes her to smear a lick across her shiny lips.");
	
	outputText("\n\nYou wriggle your way out of your bottoms and recline slightly, spreading your [legs] to position your [vagina] just above the feeding bowl.  Without pausing, your fingers slip inside that honeyed hole, caressing your lips with worshiping strokes, supplanting themselves at the altar of your womanhood.  You spread wider to allow them entrance.  Shuddering, you allow yourself to enjoy the feeling of your own ministrations, even thumbing at your [clit] with gentle, circular brushes.");
	if (player.clitLength >= 3.5) outputText("  Soon, it stands out proud and erect, a column of glistening femme-flesh that tingles with every stray breeze.");
	outputText("\n\nEnraptured by the arousing view, your latex pet is unable to resist echoing your motions.  One after another, her rubbery fingertips disappear from sight, each nestled deeply into the onyx crevasse below.  The only visible digit is the tip of her thumb, which lewdly circles at her buzzer through the thick, ebony lubricant that oozes out around her palm.  Her " + flags[kFLAGS.GOO_EYES] + " eyes look up at you pleadingly from under sable eyelids, her mouth wordlessly begging you for your girl-cum.  A climax rips through her sensitive body, a living fetish shuddering in climax.  Squirts of liquid latex erupt around her wrist as she orgasms.");
	outputText("\n\nYou groan, equally enraptured by the display she's putting on for you.  Soon, you're ");
	if (player.wetness() < 3) outputText("absolutely soaked with your girlish moisture");
	else if (player.wetness() < 4) outputText("dripping strings of girlish liquid with abandon");
	else outputText("practically gushing girlish moisture into the bowl");
	outputText(".  You instinctively rock your [hips] forward, slowly pumping them to an instinctive, animalistic beat.  " + flags[kFLAGS.GOO_NAME] + " watches raptly, still masturbating herself with relentless finger-fucks.  She watches expectantly, waiting for the first sign of your orgasm with spellbound attention.");
	outputText("\n\nRather than disappoint those eager eyes, you cum.  A bolt of electric intensity explodes in your [clit].");
	if (player.clitLength >= 3.5) outputText("  You wrap your hand around it without meaning to, caressing the slick, womanly shaft so fast that it floods your mind with white waves of unthinking pleasure.");
	outputText("  Mounting higher and higher, a wave of liquid ecstasy rises from inside the core of your being.  It grows to a mountainous peak before crashing out through your birth canal, setting off earthquakes of muscular contractions in its wake.  Those tumultuous clenches squeeze down on your fingers like a vice, only relaxing when a flow of girl-cum washes out to greet them.  You nearly tumble over in orgasmic delight but hold the bowl close, nearly spilling it as it fills.  ");
	if (player.wetness() < 3) outputText("Your dribbling cunny paints a thin film of lady-spunk on the bowl, filling it slowly as you drip and squirm.");
	else if (player.wetness() < 4) outputText("Your ludicrously wet cunt oozes thick flows of lady-spunk into the bowl, rapidly filling it with the proof of your orgasm.");
	else outputText("Your gushing cunny sprays a lurid flow of lady-spunk into the bowl, immediately filling it beyond its rim.  It does a fine job of muddying the ground with the proof of your orgasm as your bliss drags on.");
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " dives into the bowl with gusto, greedily devouring every drop.  Her tongue hangs free, thrashing against the polished wood as more and more of her latex mouth-muscle spools free to help with the feeding.  In seconds, the bowl is emptied.");
	if (player.wetness() >= 4) outputText("  Sadly, the copious vaginal lube that muddied the ground is already absorbed.  It seems the dirt can eat faster than your pet.");
	//{Boost her fluid quantity, bonus for over 250mL.}
	temp = 10;
	if (player.wetness() >= 3) temp+=5;
	if (player.wetness() >= 4) temp+=5;
	if (player.wetness() >= 5) temp+=5;
	player.orgasm();
	gooFluid(temp);
	//{Boost her happiness a tiny amount.}
	gooHappiness(4);
	doNext(camp.returnToCampUseOneHour);
}
//Feed Her Minotaur Cum {Nice Vs Hard}:(F)
private function minotaurCumFeedingGoo(nice:Boolean = false):void {
	clearOutput();
	player.consumeItem(consumables.MINOCUM);
	outputText("You pull a vial of minotaur cum from the pouches at your waist");
	if (player.minotaurNeed() || player.minotaurAddicted()) outputText(" and hungrily lick at your lips, always eager to take such a treat yourself");
	outputText(".  The latex woman ");
	if (flags[kFLAGS.TIMES_FED_LATEXY_MINO_CUM] > 0) outputText("claps in excitement, her dark-as-night nipples perking up immediately.  She hasn't forgotten her last taste of the heady treat.");
	else outputText(" tilts her head in confusion, though when she realizes that it's cum you carry, her dark-as-night nipples perk up.");
	outputText("  You swish the bottle back and forth, commenting on how you've brought your pet a treat.");
	
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " babbles without meaning to, \"<i>Really, [Master]?  For me?</i>\"  She presses her inhumanly smooth skin against you in a hug.  Her ebony coating nuzzles right up against you as her cheek brushes your ");
	if (player.tallness >= 72) outputText("[chest]");
	else if (player.tallness >= 60) outputText("neck");
	else if (player.tallness >= 52) outputText("own");
	else outputText("hair");
	outputText(".  Striking " + flags[kFLAGS.GOO_EYES] + " eyes imploringly beg at you, as if to say, \"<i>Can I have it now?</i>\"");
	//{HARD - skip if nice.}
	if (!nice) {
		outputText("\n\nYou shake your head, pushing her away unapologetically.  Patiently, you explain that if she is to have this treat, that she needs to be obedient.");
		if (gooObedience() >= 70) outputText("  " + flags[kFLAGS.GOO_NAME] + " immediately drops to the ground on all fours, rubbing her head against your [foot] and begging, \"<i>Please [Master], may your latex fuckpet have some of that wonderful cum?</i>\"  It seems she can be obedient after all.");
		//[Semi obedient:]
		else if (gooObedience() >= 40) {
			outputText("  " + flags[kFLAGS.GOO_NAME] + " gives a trifling protest, \"<i>Do I have to?  That cum looks really delicious!  I promise, I'll be good!  I'll let you fuck me any way you want.  I'll even fuck you, if you want me to!</i>\"");
			outputText("\n\nSmirking, you marvel at how she's learned to beg so well.  Still, she's not obeying.  You command her to drop to her knees.  She does without question, though a sad pout is clearly visible across her sable visage.  You command her to prostrate herself before you on all fours.  Again, she does so without question.  Then, you ask her to lick your [feet].");
			outputText("\n\nThere is a moment's hesitation in the quivering pile of ebony fuckpet.  She seems to want to rebel, but then, she begins to kiss at your [feet], eventually extending her tongue to worship you.  At first, her mouth's muscle is tenderly, experimentally touching you.  Yet, it soon gains in eagerness and speed.  " + flags[kFLAGS.GOO_NAME] + " is soon not just licking your [feet] but full on worshiping them, polishing them with her tongue.  A liquid dripping can be heard as she begins to enjoy herself.");
			outputText("\n\nOnly then do you allow her to stop, pulling her up by the scruff of the neck.  She's learning.");
			//{+obedience}
		}
		//[Not obedient:]
		else {
			outputText("  " + flags[kFLAGS.GOO_NAME] + " protests, \"<i>But you captured me!  You ought to at least have the decency to give me some of that yummy food!</i>\"");
			outputText("\n\nYou sigh and suggest that if she wants this that she needs to get on her knees.  She scowls, but after staring back at the alabaster prize in your hand, she regretfully sinks to her knees.  Looking up, she scowls and asks, \"<i>Now?</i>\"");
			outputText("\n\nShaking your head softly, you say, \"<i>Not like that.  Open your mouth and beg with your lips, then you can have it.</i>\"");
			//{high fluid and not yet submitted}
			if (gooFluid() >= 66) {
				outputText("\n\nStaggering onto her feet, " + flags[kFLAGS.GOO_NAME] + " growls, \"<i>Fuck it, I'm not that thirsty!</i>\"  She turns away from you, unwilling to even talk at this point.");
				gooObedience(-5);
				gooHappiness(-3);
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			outputText("\n\nStaggering up on her feet, " + flags[kFLAGS.GOO_NAME] + " looks about ready to quit.  Then, she licks her lips and shudders, as if remembering her own hunger.  She slumps down onto her knees and tips her head back, shaking a few strands of latex out of her face as she opens her mouth.  Then, her onyx lips mouth, \"<i>Feed me, please.</i>\"");
			outputText("That's more like it.");
		}
		
	}
	//{Both}
	//{if not hard, minus obedience}
	outputText("\n\nNodding, you uncork the bottle and hand it to her.  She immediately throws it back like a sailor with a shot, throat working silently to pass the liquid load directly into her belly.  " + flags[kFLAGS.GOO_NAME] + " burps loudly, her breath inundated with spunk-scent");
	if (player.minotaurNeed()) {
		outputText(" that makes you flush with an echoing need of your own.  Without meaning to, you pounce her, licking every trace of the heavenly minotaur spunk from her lips and licking the smallest of leftovers from inside her.  Your slave");
		if (gooHappiness() < 33) outputText(" reluctantly returns the kiss, seeming to tolerate it more than anything else.  You barely notice, lust drunk as you are.");
		else if (gooHappiness() < 66) outputText(" seems surprised at first but quickly comes to enjoy it, swapping cummy spit with passion.");
		else outputText(" eagerly returns the kiss, frenching you with abandon.  Her tongue happily pushes the leftover jizz into your mouth.");
		outputText("  You pull back, panting and unsated, wishing you had drank it yourself");
		player.minoCumAddiction(2);
	}
	outputText(".");
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " smiles up at you, giving you a rather long and sensual hug as thanks.  Then, as you watch, her smile broadens.  Her bright eyes dull, the irises dilating into vacant dinner plates.  Your latex pet's hairless snatch puffs up and begins to drool, hot and heavy.  Panting now, she moans, smiling and blissful.  Without another word, she pumps her hand into her cunt, burying her fist up to the wrist in pliant pussy.  Syrupy latex gushes out around it as she finger-fucks herself, giving her body and mind over to the numbing pleasure that the drugged spunk you gifted her has granted.  In seconds, she cums, splattering the ground with inky moisture.  She screams your name and thrusts in again, up to her own elbow.  This sets off another messy orgasm, even larger than the first.");
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + "'s eyes roll back into her head, and she collapses flat on her back, still fucking herself with her fist and forearm.  Like that, she cums over and over, succumbing to the narcotic arousal that dulls her wits and fills her body with lusty fire.  To her, there's nothing but mounting pleasure and the ecstatic release that follows, one after the other.  Her body's shaking intensifies to the point where you worry she'll injure her elastic body, but blessedly, her body goes completely limp, slumping into unconsciousness.");
	dynStats("lus", 10+player.lib/20);
	//{+fluid, +happiness}
	gooFluid(20);
	gooHappiness(15);
	if (nice) gooObedience(-1);
	else gooObedience(5);
	doNext(camp.returnToCampUseOneHour);
}

//Feed Cum Directly(F)
private function feedLatexyCumDirectly():void {
	clearOutput();
	outputText("Opening your [armor], you let [eachCock] flop free.  " + flags[kFLAGS.GOO_NAME] + " looks down immediately, " + flags[kFLAGS.GOO_EYES] + " eyes locking tightly to [oneCock], raptly watching it stiffen with rising lust.  You take it in hand to heft its weight.  Explaining that this is to be her meal, you give it an encouraging shake.  After all, what kind of master would you be if you didn't feed your goo-girl?");
	//HUNGRY: 
	if (gooFluid() < 33) {
		outputText("  A rumble makes " + flags[kFLAGS.GOO_NAME] + "'s tight belly tremble.  She brings a hand up to cover her featureless belly, giving you a nervous grin as she leans forward.  \"<i>How did you know I was so hungry");
		if (gooObedience() > 50) outputText(", [Master]");
		outputText("?</i>\"");
	}
	//INTERMEDIATE: 
	else if (gooFluid() < 66) {
		outputText("  A smirk spreads over " + flags[kFLAGS.GOO_NAME] + "'s visage.  She licks her lips and leans forward, saying, \"<i>Mmm...  I could go for a snack");
		if (gooObedience() > 50) outputText(", [Master]");
		outputText(".</i>\"");
	}
	//NOT HUNGRY:  
	else {
		outputText("  A lazy smile reveals itself on " + flags[kFLAGS.GOO_NAME] + "'s face.  She giggles, her lush body jiggling with liquid weight as she moves.  The latex woman comments, \"<i>Mmm...  I'm pretty full.</i>\"  She licks her lips and continues in a gluttonous purr, \"<i>You can always feed me more though");
		if (gooObedience() > 50) outputText(", [Master]");
		outputText(".</i>\"");
	}
	//{no new PG} 
	if (gooFluid() > 50) outputText("  Plump o");
	else outputText("  O");
	outputText("nyx lips purse idly, slowly spreading as if of their own volition as their mistress bends closer to inhale your scent.  Her smooth nostrils flare as she sniffs at your [cock biggest], savoring the scent of her meal.  Slowly, she's drawn forward to her meal, eventually coming to rest that puckered orifice tightly against your [cockHead biggest].");
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " has the sense to look up and give you a wink.  Then, she reveals her tongue - an ebony protrusion that spools without end.  A gleeful smile spreads over " + flags[kFLAGS.GOO_NAME] + "'s raven-hued mouth while her spit-glossed tongue wraps [eachCock] up tight.  Once satisfied, she stretches her jaw downward in order to fully open her mouth.  The puckered lips morph into a distended 'o' and advance, marching down the length of your [cock biggest] with unceasing determination, gleefully devouring your erection.");
	if (player.biggestCockArea() > 80) outputText("  Her throat is stretched so tightly that it appears more like an inky condom than anything else.  Every vein, every variation in length is perfectly represented - until it disappears into her chest.");
	else outputText("  Her body, devoid of gag reflex, swallows you with ease.");
	outputText("\n\nWith [oneCock] buried [sheath]-deep in your pet, you cannot help but groan.  You realize, after a moment, that her tongue untwisted as soon as she pulled you in, as you can feel the wet, pulsing walls of the latex woman's throat massaging your length, meticulously stimulating you with the semi-solid pressure that only a goo-girl can provide.  Her innards feel like gelatinous waves cresting over you, warm and gooey all at the same time.  " + flags[kFLAGS.GOO_NAME] + " tenderly milks your [cock biggest], squeezing out a few flows of pre-cum into her belly.  Pulling back, she squeezes a dollop of cream from your [cockHead biggest] as she withdraws, her oily tongue clinging to the underside of your tool as it's abandoned to cool air.");
	outputText("\n\nThe entirety of your maleness is wreathed in slowly solidifying blackness, a liquid latex that makes you appear to wear an inky, leaking condom.  The tightness of it tingles as it snugs tight about you.  It feels good in an unusual way, but you want more!  You grab hold of " + flags[kFLAGS.GOO_NAME] + " by the head and ram forward, hilting yourself back inside that sable fuck-cave, allowing the liquid latex of her core hug you close.  She gives a muffled grunt of surprise, but her expression quickly settles into one of content.  Driven by surging arousal, you bunch her slick strands in your hands and pull her back by her hair, yanking her back and forth.  You're fucking her face, and she loves it!");
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " sighs, a gurgling vibration almost below your ability to hear, but there nonetheless.  Her eyes meet yours, hungry and pleading.  They beg you with sultry, long-lashed blinks, imploring you to cum.  Her tongue fellates your [cock biggest] with lewd licks to further stir your passion, worshiping you as you pound her face.  To a normal woman, or even a demon, this would probably be uncomfortable, but to her, it's just another blowjob.  The semi-solid surfaces inside her suddenly squeeze shut, wrapping your rigid member tight in gushing velvet.  At the same time, she begins to hum, low and deep inside herself, vibrating those juicy cushions around your cock as she begins to suck.");
	outputText("\n\nSilky smooth fingers dig into your [butt], a mirror of the digits that hold her head tight.  Both of her hands pull and tug, mashing loins to lips in a salacious kiss of cock-creaming pleasure.  Your body goes rigid, your hands pull tighter, and you begin to shake as orgasm hits.  The pulsing warmth of her throat seems to wick up into your middle, where it churns and bubbles before bursting out in an explosion of gooey pleasure.  Rope after rope of seed fires into your pet's gooey interior, silencing her humming and setting her sloppy-slick walls to squeeze you with your convulsions, wringing your [cock biggest] dry.");
	if (player.cockTotal() > 1) {
		outputText("  Your remaining ");
		if (player.cockTotal() == 2) outputText("dick fruitlessly paints");
		else outputText("dicks fruitlessly paint");
		outputText(" her " + gooTits() + " with a sheen of white, wasting their moisture in a decadent display of virility.");
	}
	if (player.cumQ() >= 500) outputText("  You cream her internals so full that her belly distends and jiggles with each fresh pump of spunk.");
	if (player.cumQ() >= 1500) outputText("  Rounder and rounder she swells, until her middle is almost balloonish, stretched so taut it appears grayish-white thanks to all the white beneath.");
	if (player.cumQ() >= 500) outputText("  However, by the time your orgasm is winding down, she's already metabolizing it, converting her spunk-plumped belly into supple, denser curves for the rest of her form.");
	
	outputText("\n\nFeeling utterly empty, you sag back against a boulder.  The rough texture of the supporting stone keeps you upright, but there's next to no strength left in your [legs].  " + flags[kFLAGS.GOO_NAME] + " is still down there, still slurping and sucking, probing the delicate entrance to your cumvein with gentle licks as she squeezes the last few drops from you.  The sensation feels far too good this soon after climax.  You wriggle and squirm, putting a hand to " + flags[kFLAGS.GOO_NAME] + "'s forehead and commanding her to stop.");
	//{OBEDIENT:}
	if (gooObedience() >= 60) {
		outputText("\n\nAt the sound of your command, a whimper rolls over your [cock biggest], but the suckling heat that surrounds it withdraws, sliding off along with the succulent ring her glossy lips provide.  Your [cockHead biggest] pops free from the imprisoning puckers, trailing glossy black spit.  " + flags[kFLAGS.GOO_NAME] + " breathes hard, as if she's been holding her breath all this time, and for all you know, she may have.  In any event, she mewls hungrily, licking her gooey liquids from your cock to clean it.  Again, it feels so good that it nearly saps your strength, but you hold tight while she finishes melting the latex free, leaving your dick completely clean.");
		//Happy: 
		if (gooHappiness() >= 66) outputText("\n\n\"<i>Thank you for the food, [Master],</i>\" " + flags[kFLAGS.GOO_NAME] + " coos, \"<i>A pet like me only needs what you allow, isn't that right, [Master]?</i>\"");
		//Mediocre:
		else if (gooHappiness() >= 33) outputText("\n\n\"<i>Thanks for the food, I guess,</i>\" " + flags[kFLAGS.GOO_NAME] + " mutters, \"<i>I guess you don't let your pets overindulge, huh?</i>\"");
		//Grumpy: 
		else outputText("\n\n\"<i>Really?  That's it?</i>\" " + flags[kFLAGS.GOO_NAME] + " complains, \"<i>I thought you liked it, but I guess you're more concerned about obedience than my happiness, huh, [Master]?</i>\"");
		
		outputText("\n\nYou rise, giving your latex slave a knowing nod.  Her cunt");
		if (flags[kFLAGS.GOO_DICK_LENGTH] > 0) outputText(" and " + gooCock() + " spatter");
		else outputText(" spatters");
		outputText(" oily wetness onto the ground below at your affirmation, and she shudders with a submissive thrill.  You pat her on the head for a job well done and depart, secure in her obedience.");
		//{Boost her fluid quantity, bonus for over 250mL.}
		temp = 20;
		if (player.cumQ() >= 500) temp += 5;
		gooFluid(temp);
		//{Boost her happiness a tiny amount.}
		gooObedience(5);
		player.orgasm();
		dynStats("sen", -2);
		doNext(camp.returnToCampUseOneHour);
	}
	//{DISOBEDIENT:}
	else {
		outputText("\n\nAt the sound of your command, her suction redoubles.  That suckling heat plumps your [cock biggest] even bigger inside her, bombarding you with cacophonous sensation that scatters your bodily control like leaves in the breeze.  You give a strangled whimper as you slide down the stone, landing softly on your [butt] before the sensuous shape of your rebellious pet.  Her lips are locked vacuum tight to your groin, pumping up and down with wet, hungry smacks.  You arch your back into her ministrations, rolling your eyes back into your head.  What need is there for sight when the jolts of pleasure coming from your [cock biggest] are so powerful that they make the previous orgasm seem a wasted, worthless thing.");
		menu();
		addButton(0,"Let Her",maleDirectFeedLatexGooGoneWrong);
		addButton(1,"Try2Assert",tryToAssertMaleDomWhileLatexGooDrains);
	}
}

private function maleDirectFeedLatexGooGoneWrong():void {
	clearOutput();
	if (player.cockTotal() > 1) {
		outputText("A flawless hand wraps around ");
		if (player.cockTotal() > 2) outputText("your remaining erections");
		else outputText("your other erection");
		outputText(", stroking ");
		if (player.cockTotal() == 2) outputText("it");
		else outputText("them");
		outputText(" with slow caresses.  Using the extra ejaculate as lubricant, she ensures that they're nearly as engulfed in slippery latex as your main member.  ");
	}
	outputText("Without warning, an explosion of ecstasy rises up, forcing decadent, pleasurable squeezes through your abdominal muscles, culminating in a release of white pressure from ");
	if (player.cockTotal() > 1) outputText("each of ");
	outputText("your cum-slit");
	if (player.cockTotal() > 1) outputText("s");
	outputText(".  " + flags[kFLAGS.GOO_NAME] + " looks up at your seizing body, smiling wide around her ");
	if (player.biggestCockArea() > 80) outputText("impressive ");
	outputText("mouthful of cock as it pumps directly into her belly, allowing her to drink even more deeply of your essence.");
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " releases you from your oral imprisonment long enough to leak a few trailing strands of spunk from your [cockHead biggest].  ");
	if (player.cockTotal() == 1) outputText("Her hands fixate on your slick, black-coated length, beginning to stroke it with eager pumps");
	else outputText("Her eager pumps never slow, and she moves one of her busy mitts to stroke your black-coated length");
	outputText(".  The latex waif tickles your ");
	if (player.balls > 0) outputText("[balls]");
	else outputText("taint");
	outputText(" with a finger as she happily explains, \"<i>The thing about us goo-girls is... we love to drink.  Mmmm...</i>\"  Her voice trails into a hum of delight as she digests your newest offering, eventually returning to say, \"<i>You taste so good, [name]... I can't stop and it's so sweet, so delectable.  Swallowing your spunk makes my pussy gush and my stomach purr.  You don't mind if I sample a few more swallows do you?</i>\"");
	outputText("\n\nYou grunt out something negative sounding.  You're beyond words by this point, locked in what feels like a cycle of ceaseless teasings on your over-tender member");
	if (player.cockTotal() > 1) outputText("s");
	outputText(".  Worse, the slimy handjob");
	if (player.cockTotal() > 1) outputText("s");
	outputText(" you've been getting morph");
	if (player.cockTotal() == 1) outputText("s");
	outputText(" into something that gives you even stronger strokes of pleasure.  If you could roll your eyes down to look, you'd see " + flags[kFLAGS.GOO_NAME] + "'s fingers merging together, joining into a single cylinder.  Dark-oil begins to drip from that tight grip, made all the more difficult to endure by the pleasant, purple-tinged latex lips that form on the bottom of her 'hand', a mock-pussy complete with latex-based lubricant.  At the bottom of every downstroke, your dick bursts free from the top, appearing just long enough for her to slurp languidly on your [cockHead].");
	outputText("\n\nOrgasm slams into you with the force of a sledgehammer, turning your vision red and ringing your ears.  More wet slurps and squelches emanate from your groin as " + flags[kFLAGS.GOO_NAME] + " drinks deeper of your essence, coaxing fresh spurts of white from your thoroughly milked [balls].  As you fire your liquid bliss into her, your tired eyelids close.");
	outputText("\n\n\"<i>You're not done yet, are you?</i>\" a sultry voice whispers, accompanied by fresh ministrations to your maleness.  \"<i>You promised to feed me, [Master], now come on, squirt in my slippery squeezes.  Give me your spunk!</i>\"  The voice begs and pleads, only silencing itself to plant itself back on your [cock biggest] again.  You lapse from conscious thought, only stirring to lift your hips high and release a fresh draught of nutrients for your greedy pet.");
	menu();
	player.orgasm();
	dynStats("lib", .5, "sen", -3);
	addButton(0,"Next",feedCumDirectEpilogue);
}
//[Next]
private function feedCumDirectEpilogue():void {
	clearOutput();
	outputText("You wake with your mouth so dry that it feels like sandpaper.  Looking around, you see " + flags[kFLAGS.GOO_NAME] + " slumbering in the corner, looking rather... full and fecund, plump with weight.  You feel equally, obnoxiously empty.  Your groin is tingling painfully from the forceful draining.  Staggering away toward some water, you realize you'll have to raise her obedience if you want her to stop on command.  Letting her drink so deeply probably didn't help either.");
	temp = 50
	if (player.cumQ() >= 500) temp += 30;
	gooFluid(temp);
	
	//{Boost her happiness a tiny amount.}
	gooHappiness(5);
	gooObedience(-4);
	doNext(camp.returnToCampUseFourHours);
}
//Feed Lady-Cum Direct(F)
private function feedLatexyGirlCumDirect():void {
	clearOutput();
	outputText("Gently shimmying out of your [armor], you languidly stretch and offhandedly mention that it's feeding time.");
	if (player.hasCock()) {
		outputText("  When " + flags[kFLAGS.GOO_NAME] + " glances to your " + player.multiCockDescriptLight() + ", you tut and ");
		if (player.balls > 0) outputText("lift your [balls]");
		else outputText("shift position");
		outputText(" to show your [vagina].");
	}
	else outputText("  When " + flags[kFLAGS.GOO_NAME] + " glances down, you sashay to better show your [vagina].");
	
	//HUNGRY: 
	if (gooFluid() < 33) {
		outputText("\n\nA rumble makes " + flags[kFLAGS.GOO_NAME] + "'s tight belly tremble.  She brings a hand up to cover her featureless belly, giving you a nervous grin as she leans forward.  \"<i>How did you know I was so hungry");
		if (gooObedience() > 50) outputText(", [Master]");
		outputText("?</i>\"");
	}
	//INTERMEDIATE: 
	else if (gooFluid() < 66) {
		outputText("\n\nA smirk spreads over " + flags[kFLAGS.GOO_NAME] + "'s visage.  She licks her lips and leans forward, saying, \"<i>Mmm...  I could go for a snack");
		if (gooObedience() > 50) outputText(", [Master]");
		outputText(".</i>\"");
	}
	//NOT HUNGRY:  
	else {
		outputText("\n\nA lazy smile reveals itself on " + flags[kFLAGS.GOO_NAME] + "'s face.  She giggles, her lush body jiggling with liquid weight as she moves.  The latex woman comments, \"<i>Mmm...  I'm pretty full.</i>\"  She licks her lips and continues in a gluttonous purr, \"<i>You can always feed me more though");
		if (gooObedience() > 50) outputText(", [Master]");
		outputText(".</i>\"");
	}
	outputText("\n\nYou confidently approach, stopping just in front of your latex pet.  She immediately drops to her knees, placing her nose a scant few inches from your vulva.  Her " + flags[kFLAGS.GOO_EYES] + " eyes lock onto the ");
	if (player.wetness() >= 3) outputText("glistening ");
	outputText("outer lips with excitement, dilating slightly as she leans closer.  " + flags[kFLAGS.GOO_NAME] + "'s nostrils flare as she breathes deeply of your scent, inhaling thick lungfuls of your feminine odor, the heady musk of an aroused woman.  Her mouth hangs open slightly, as if in awe of what she sees, and undirected by her conscious mind, she lazily drifts closer.");
	outputText("\n\nA shiver of indecent pleasure writhes up your spine when her nose casually crashes into your slit.  Jolting slightly, " + flags[kFLAGS.GOO_NAME] + " is roused from her cunt-induced stupor by the hot wetness on her proboscis.  She glances up at you, blushing just the slightest amount of violet, and hesitantly cranes her head to bring her lips in contact with your labia.  At first, she kisses and licks around the outer edges of your vulva, smearing their surface with her inky saliva.  The slick fluid thickens on contact with the air, even as she dives deeper into your [vagina], slowly spreading your inner lips with her exotic tongue.");
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " quickly loses herself in her own artful ministrations, her world narrowed down to the simmering cleft at the joint of your [hips] and [legs].  Slithering out, snakelike, her tongue burrows into your [vagina].  Its length is as large as it is slick, shiny and so smooth that it glides through your gates with ease.  " + flags[kFLAGS.GOO_NAME] + " skillfully twists it around inside you, forcing more of her sable spit into your channel as her lubricated muscle squirms inside you, pressing hard against every tender area.  It's so smooth that if it weren't pushing so pleasantly against you, you'd barely feel it.  As it is, a slick snake is writhing in your cunt and it's set your loins afire.");
	if (player.wetness() < 3) outputText("  Drizzling wetness pours down your pet's chin as she pleases you.  She swallows most of it with eager bobs of her throat, happy to have such a... moist [master].");
	else if (player.wetness() < 4) outputText("  Drops of wetness beat on your pet's chin as she pleases you.  She swallows most of it with eager bobs of her throat, pleased to have an appetizer before the main course.");
	else outputText("  Lubricant shines on your pet's glossy chin as she pleases you.  She swallows every now and again with eager bobs of her throat, sampling your flavor.");
	outputText("\n\nPulling back, the hungry latex woman smiles up at you, though she's muted by the tongue that hangs over the intervening distance, still locked to your pussy by her undulating oral appendage.  Her long lashes blink innocently while that potent mouth muscle massages your box's inner walls.  Taken in by the sensual assault and innocent visage accompanying it, you grab hold of " + flags[kFLAGS.GOO_NAME] + "'s face and cram it into your cunt, mashing her mouth up into your nethers hard enough to make an audible squelch.  The corners of " + flags[kFLAGS.GOO_NAME] + "'s eyes crinkle merrily.  She's still meeting your gaze, even as you hump her mouth, using her like a living latex sextoy.");
	outputText("\n\nHolding as tightly to that thought as your slave's head, you aggressively grind against her, letting the ecstatic pleasure haze your thought processes as it crests into a wave.  She twists and presses her tongue up hard, squeezing a supremely sensitive spot.  The ensuing explosion of heavenly indulgence echoes in your brain, short-circuiting your motor control.  Your limbs thrash freely, though your fingers and arms stay locked on " + flags[kFLAGS.GOO_NAME] + ", mashing her tightly into your gash.");
	if (player.wetness() >= 4) outputText("  You squirt a small river of gushing juices directly into her mouth, her cheeks flooded by the copious outpouring of lubricant.");
	else outputText("  You gradually fill her mouth with your free-flowing orgasmic lubricants.");
	outputText("  Her tongue is squished tight when your [vagina] clamps closed, convulsing around the mouth muscle as if it was a dick it could somehow milk.  Your [legs] lock as you endure the tidal wave of release.");
	outputText("\n\nThe pleasure doesn't fade fast.  In fact, the aftershocks that wrack your muscles continue to assault you with every kiss of your pet's eager lips.  She doesn't slow or stop after your orgasm.  If anything, she suckles your nether-lips and [clit] that much harder, greedy more of your delectable juices.  You wriggle and squirm, putting a hand to " + flags[kFLAGS.GOO_NAME] + "'s forehead and commanding her to stop.");
	//{OBEDIENT:}
	if (gooObedience() >= 60) {
		outputText("\n\nAt the sound of your order, a whimper rolls over your [vagina], but the undulating pleasure of her glossy tongue inside you gradually recedes.  Your [clit] pops free from the imprisoning puckers, joined by a web of inky spit and lady-cum.  " + flags[kFLAGS.GOO_NAME] + " breathes hard, as if she's been holding her breath all this time, and for all you know, she may have.  In any event, she mewls hungrily, licking her gooey liquids from your box to clean it.  Again, it feels so good that it nearly saps your strength, but you hold tight while she finishes lapping up the lubricants and saliva, leaving your entrance completely clean.")
		//Happy: 
		if (gooHappiness() >= 66) outputText("\n\n\"<i>Thank you for the food, [Master],</i>\" " + flags[kFLAGS.GOO_NAME] + " coos, \"<i>A pet like me only needs what you allow, isn't that right, [Master]?</i>\"");
		//Mediocre:
		else if (gooHappiness() >= 33) outputText("\n\n\"<i>Thanks for the food, I guess,</i>\" " + flags[kFLAGS.GOO_NAME] + " mutters, \"<i>I guess you don't let your pets overindulge, huh?</i>\"");
		//Grumpy: 
		else outputText("\n\n\"<i>Really?  That's it?</i>\" " + flags[kFLAGS.GOO_NAME] + " complaints, \"<i>I thought you liked it, but I guess you're more concerned about obedience than my happiness, huh, [Master]?</i>\"");
		outputText("\n\nYou rise, giving your latex slave a knowing nod.  Her cunt");
		if (flags[kFLAGS.GOO_DICK_LENGTH] > 0) outputText(" and " + gooCock() + " spatter");
		else outputText(" spatters");
		outputText(" oily wetness onto the ground below at your affirmation, and she shudders with a submissive thrill.  You pat her on the head for a job well done and depart, secure in her obedience.");
		//{Boost her fluid quantity, bonus for over 250mL.}
		temp = 10;
		if (player.wetness() >= 3) temp += 5;
		if (player.wetness() >= 4) temp += 5;
		if (player.wetness() >= 5) temp += 5;
		gooFluid(temp);
		
		//{Boost her happiness a tiny amount.}
		gooObedience(4);
		player.orgasm();
		dynStats("sen", -2);
		doNext(camp.returnToCampUseOneHour);
	}
	//{DISOBEDIENT; chose not to/could not Assert Control}
	else {
		outputText("\n\nAt the sound of your order, your pet's efforts redouble.  Her slick onyx opening latches tight to your [clit] while what feels like a foot of thick tongue thrashes inside you.  As sensitive as you are after cumming, you simply can't endure such rampant stimulation.  The strength goes out of your [legs] in weak little twitches as you slump back against a boulder, the rough stone slowing your descent as you slide to the ground.  " + flags[kFLAGS.GOO_NAME] + "'s mouth stays locked to your [vagina], attached with vacuum-like tightness.  You can actually feel your vulva puffing larger under the suction.  Hotter and more sensitive, your labia plump up nice and thick.");
		menu();
		addButton(0,"Let Her",letLatexGooDrainCuntDry);
		addButton(1,"Try2Assert",assertControlOverCuntDrainingLatexGoo);
	}
}

private function letLatexGooDrainCuntDry():void {
	clearOutput();
	outputText(flags[kFLAGS.GOO_NAME] + "'s face remains firmly, stubbornly attached to your loins.  No matter how you writhe or push against her, she stays latched onto your [vagina].  The near supernatural pleasure has turned your arms to jello, and you slump back ineffectually after a few attempts at freedom.  The " + flags[kFLAGS.GOO_EYES] + " of your hungry pet's eyes watches you, unblinking.  Mercilessly, she tongues your sodden slit to another orgasm.  The slippery latex lips slip and slide across your womanhood as sexual ecstasy subsumes your thoughts, eyes rolling back as your mind dedicates the whole of its power to simply experiencing the pleasure that's thrust upon you.");
	outputText("\n\nWordlessly, you writhe on " + flags[kFLAGS.GOO_NAME] + " until the orgasm finally releases you from its grip.  Your pet goo pulls back, even withdrawing her tongue from your well-juiced box.  Her fist doesn't waste any time in replacing in.  In fact, as the smooth limb slides home, you can feel the bulkiest parts smoothing, shaping it into a cylindrical object with a noticeable ridge just above the 'wrist'.  " + flags[kFLAGS.GOO_NAME] + " giggles, \"<i>Gosh, you taste good, and we goo girls... we love to drink.  Mmm...</i>\"  Her voice trails into a hum of delight as she digests your newest offering, eventually returning to say, \"<i>Your little slit here seems awful happy, [name]... I don't want to stop, and it's so sweet, so delectable...  Swallowing your cum makes my pussy gush and my stomach purr.  You don't mind if I sample a few more swallows do you?</i>\"");
	outputText("\n\nYou give voice to your objections, but the feel of latex lips snugging tight around your [clit] swiftly turns your protests into a moaning gurgle.");
	if (player.clitLength >= 3) outputText("  She happily fellates your female pole in time with the pumping of her arm.");
	else outputText("  She happily licks and sucks your most sensitive spot in time with the pumping of her arm.");
	outputText("  The lurid squelches of her pumping, dildo-like limb fill the air, easily drowning out your more coherent vocalizations.  There's nothing you can do but cum for your latex goo-girl.  Nothing to do but feel pleasure and orgasm, feeding her every drop of your liquid pleasure, again and again.");
	outputText("\n\nA whimper of protest slips out of your mouth, your [vagina] cums again, and " + flags[kFLAGS.GOO_NAME] + " drinks deeply once more.  With eyelids fluttering closed, you pass beyond conscious awareness, yielding your body to " + flags[kFLAGS.GOO_NAME] + " to claim again and again.");
	menu();
	player.orgasm();
	dynStats("lib", .5, "sen", -3);
	addButton(0,"Next",feedCumDirectEpilogueGirls);
}

//[Next]
private function feedCumDirectEpilogueGirls():void {
	clearOutput();
	outputText("You wake with your mouth so dry that it feels like sandpaper.  Looking around, you see " + flags[kFLAGS.GOO_NAME] + " slumbering in the corner, looking rather... full and fecund, plump with weight.  You feel equally, obnoxiously empty.  Your groin is tingling painfully from the forceful suckling.  Staggering away toward some water, you realize you'll have to raise her obedience if you want her to stop on command.  Letting her drink so deeply probably didn't help either.");
	gooFluid(50 + player.wetness() * 8);
	//{Boost her happiness a tiny amount.}
	gooHappiness(4);
	gooObedience(-4);
	doNext(camp.returnToCampUseFourHours);
}

/*Savin Says: Disobedient Pets get Punished with Gentle Loving PC-Dom (FEMALE)(F)*/

//[Display option to \"<i>Assert Control</i>\" with Moderate strength check if achieve Femdom end to direct feed scene: \"<i>You're strong enough to pull her off before she utterly dominates you!</i>\"]
private function assertControlOverCuntDrainingLatexGoo():void {
	if (player.str < 40 || player.str/10 + rand(20) + 1 < 9) {
		letLatexGooDrainCuntDry();
		return;
	}
	clearOutput();
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + "'s face remains firmly, stubbornly attached to your loins.  You struggle under her relentless oral assault until you finally manage to get a good grip on the rebellious goo-slut. Putting your impressive strength to work, you flip yourself and the goo-girl over, straddling her shoulders and crushing her beneath your body.  " + flags[kFLAGS.GOO_NAME] + " lets out a pathetic squeak as you assume command once again, pinning her onto the ground beneath you.  She's supposed to be the servile one here: it's time for this bitch to learn her place.  You grab her by her slick, latexy hair and mash her face into your twat, shuddering as her nose rubs against your [clit].  You snap a command to finish you a second time.  If she wants your fluids so bad, let her work for it the right way: meekly suckling from your cunt like a good little sub should.");
	outputText("\n\nPinned down as she is, " + flags[kFLAGS.GOO_NAME] + " struggles against your powerful [legs] for a few moments before another forceful face-shove into your waiting cunt stops her, her intense craving for your femcum overpowering her desire to rebel.  \"<i>I-I'm sorry, ");
	if (gooObedience() <= 50) outputText("[name]");
	else outputText("[Master]");
	outputText("</i>\" she mewls, giving you a long, tentative lick between your womanly folds.  You hold her firmly, telling her to prove just how sorry she is.  Your breath catches in your throat as her long, slick tongue slides through you again, stopping to swirl and tease your sensitive [clit], sending shudders of sudden pleasure wracking through you.");
	outputText("\n\n\"<i>Good girl,</i>\" you moan, arching your back as she slithers more and more of her long tongue into you, filling your [cunt] with black latex.  You run your fingers through her hair, urging " + flags[kFLAGS.GOO_NAME] + " on as she begins to explore your passage, still delightfully sensitive and malleable after the recent face-fucking you just received from her.  More and more of her creeps into you, spreading your vaginal walls wide until the tip of her tongue tickles the mouth of your cervix, pleasantly circling it with slow, rhythmic motions.  You remind " + flags[kFLAGS.GOO_NAME] + " that this is how it ought to be, with her meekly servicing your needy cunt as you desire; not her trying to dominate you. That isn't how this works, and she should know better by now.");
	outputText("\n\n\"<i>I'm sowwy, " + player.mf("Mashta","Mishtrish") + ",</i>\" she mumbles, her words slurred by her tongue being fully buried inside you.  She retracts herself from you, leaving you feeling empty and cold as she adds, \"<i>I didn't mean to, Master... I just, lose control...</i>\"  You smile down at the little latex girl and tell her that she doesn't need to worry.  You'll always be here to keep her nice and full with delicious femcum, so full that she's fit to burst with how much you've given her.  " + flags[kFLAGS.GOO_NAME] + " squirms, stirred by your words, and looking over your shoulders, you can see a fresh sprout of liquid latex pouring down between her thighs.");
	outputText("\n\nYou release " + flags[kFLAGS.GOO_NAME] + "'s head, leaving one hand to stroke her hair as your other plays down her slick, smooth skin, tracing along her shapely curves and huge, jiggling breasts until your fingertips brush along her thighs.  She gasps as a single digit plunges into her, sliding up to the knuckle into her ready cunt in one slow, languid motion.  Your other hand guides her head upwards, urging her back to her duties; she hesitates for a moment, but so do you, both still holding until she finally accepts your demand and resumes, her tongue flicking out to play along your [cunt].  \"<i>Good girl,</i>\" you say again, and start to move your hand, gently fingering her pussy as she tongues up the lubricant freely leaking from your loins.");
	outputText("\n\nBefore she can fall into a rhythm of tongue-fucking you, though, you decide to reward her newfound submissiveness: you twist around, leaving her pinned beneath your [legs] as you move your head between her shapely thighs.  You breathe in deep, reveling in the smell of her as " + flags[kFLAGS.GOO_NAME] + " slips her long tongue back into you, filling your empty [cunt] with her oral appendage.  You return the favor, gently sliding your middle-three fingers into her eager twat, stretching her until you can slide the whole of your fist in.  She gasps, her breath hot on your sensitive box, but you don't skip a beat as you push your fist into her, sliding in until you run out of cunt to fill.  You start to move, fisting her with slow, gentle motions, enjoying the feeling of her slick passage desperately contracting around the huge block inside it, trying to push you out as you push in; trying to suck you in as you pull out to the knuckles.");
	outputText("\n\n\"<i>" + player.mf("Masterrrr","Mistriiiiissss") + "!</i>\"  " + flags[kFLAGS.GOO_NAME] + " groans, rolling her head back as you fist-fuck her. She redoubles her oral ministrations, eagerly lapping at your sodden box, desperately trying to bring you to orgasm even as lube spurts liberally from between her legs, signaling her impending climax.  You're closer, though, so close to the edge that you'd cum even if she stopped.  But she wouldn't dare, instead grasping your thighs and shoving her face between your [legs], slurping her tongue through you with mind-wrecking speed.");
	outputText("\n\nYou jam your fist as far into " + flags[kFLAGS.GOO_NAME] + " as you can before you cum, making her shriek in pleasure and sending reverberations through your cunt as you rocket over the edge.  Your [cunt] practically explodes with femcum, showering " + flags[kFLAGS.GOO_NAME] + "'s face with it as your box squeezes down on her tongue, trapping her inside you as you pound her box, throwing her into orgasmic throes beneath you, her tongue writhing and squirming inside you to further your pleasure.");
	outputText("\n\nWhen your second orgasm passes, you roll limply off of " + flags[kFLAGS.GOO_NAME] + ", utterly sated.  Your [chest] heaving, you sigh peacefully as you close your heavy lids, eager to rest.  A moment later, though, you feel slick skin press against your own as " + flags[kFLAGS.GOO_NAME] + " curls up beside you, her face inches from your own.  With a wan smile, you reach out and run your fingers through her hair before pulling her into a long kiss that leaves the taste of womanhood on your lips.");
	//{Low happiness}
	if (gooHappiness() < 33) outputText("\n\n\"<i>If it's always going to be like that, maybe... being here with you isn't going to be so bad after all,</i>\" " + flags[kFLAGS.GOO_NAME] + " whispers.");
	//{Moderate happiness}
	else if (gooHappiness() < 66) outputText("\n\n\"<i>I'm sorry I got so forceful, [name].  I enjoy serving you... I do.</i>\"");
	//{High happiness}
	else outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " nuzzles against you, her head coming to rest on your [chest].  \"<i>Sorry, [name]. I didn't mean to try and force you.  I love you when you're so assertive, so... dominant.</i>\"");
	player.orgasm();
	dynStats("sen", -2);
	gooFluid(30 + player.wetness() * 5);
	//{Boost her happiness a tiny amount.}
	gooHappiness(5);
	gooObedience(5);
	doNext(camp.returnToCampUseOneHour);
}

//Savin Says: Disobedient Pets get Punished with Gentle Loving PC-Dom (MALE)
//[Display option to \"<i>Assert Control</i>\" with Moderate strength check if achieve Femdom end to direct feed scene: \"<i>You're strong enough to pull her off before she utterly dominates you!</i>\"]
private function tryToAssertMaleDomWhileLatexGooDrains():void {
	if (player.str < 40 || player.str/10 + rand(20) + 1 < 9) {
		maleDirectFeedLatexGooGoneWrong();
		return;
	}
	clearOutput();
	outputText("At the sound of your command, her suction redoubles.  That suckling heat plumps your [cock biggest] even bigger inside her, bombarding you with cacophonous sensation that scatters your bodily control like leaves in the breeze.  You give a strangled whimper as you slide down the stone, landing softly on your [butt] before the sensuous shape of your rebellious pet.  Her lips are locked vacuum tight to your groin, pumping up and down with wet, hungry smacks.  You arch your back into her ministrations, rolling your eyes back into your head.  What need is there for sight when the jolts of pleasure coming from your [cock biggest] are so powerful that they make the previous orgasm seem a wasted, worthless thing.");
	outputText("\n\nBut this isn't how it's supposed to be!  You're supposed to be in control here, not " + flags[kFLAGS.GOO_NAME] + ".  She's meant to serve you, not force herself on you like some goblin slut.  You struggle against her, grabbing " + flags[kFLAGS.GOO_NAME] + "'s hair and pulling back, forcing her off your cock with all your strength.  She tumbles back, coughing and gagging, her mouth still locked in an 'O' meant for your [cock biggest].  You dust yourself off, struggling upright before standing, looming over " + flags[kFLAGS.GOO_NAME] + " who looks meekly up at you.  \"<i>I... I...</i>\" she starts, but you cut her off, rolling her onto her belly and hiking her plump little ass up.  You sigh, starting to remind her of exactly who's in charge here, of how you're always here to feed her, and yet she tries to force herself on you like that...  Unacceptable. As you speak, you grab her plush buttcheeks, digging your fingers into her backside until a little moan escapes her lips.  \"<i>That's more like it,</i>\" you growl, flopping your [cock biggest] down between her cheeks, rubbing it across the smooth, yielding latex of her ass.");
	
	outputText("\n\n\"<i>I'm sorry, [Master],</i>\" " + flags[kFLAGS.GOO_NAME] + " mewls meekly, but the slut inside her starts wiggling her rump, her cheeks gently squeezing around your manhood.  Still, you 'tsk' at her as you begin to slowly rock your [hips], hotdogging yourself between her gropable buttcheeks, enjoying the onahole-like feel, even as latex lube starts to drip to the ground from between " + flags[kFLAGS.GOO_NAME] + "'s legs, her body desperately announcing its desire to fuck.  Despite the orgasm that just wracked your body, you can feel your lust stirring, too, spurred on by the oral onslaught " + flags[kFLAGS.GOO_NAME] + " attempted to inflict on you.  You give your [cock biggest] one last, rough thrust between her cheeks before pulling back, stroking yourself until your [cockHead biggest] presses against her lube-slicked cunt.  You rub the shaft of your prick along her slick, eager fuckhole, letting her liquid latex lube slosh out onto you as " + flags[kFLAGS.GOO_NAME] + " continues to whorishly wiggle her ass, trying to entice you to feed her.");
	outputText("\n\nOnce your [cock biggest] is nice and slick with her vaginal excretions, though, you pull back again and dig your fingers back into " + flags[kFLAGS.GOO_NAME] + "'s ass, spreading her lush cheeks apart to reveal the tight little star of her backdoor.  " + flags[kFLAGS.GOO_NAME] + " gasps as she feels your crown press against her asshole, her mouth opening wide as your oh-so-wet prick plunges the first inch into her without resistance.  You groan with satisfaction as her vice-tight hole squeezes down around your slick shaft, desperately, reflexively trying to repel the intruding cockmeat; but you're so slick, so covered in liquid latex that " + flags[kFLAGS.GOO_NAME] + "'s stunned body can't resist you, and you begin to slide inch after inch into her, burying yourself to the hilt in a single long, painfully slow push.");
	outputText("\n\nYou pause once you've hilted her, breathing deeply as you enjoy the intense squeeze her anus is applying to you, reveling in the sensation of smooth latex rubbing harshly along your goo-covered shaft, unable to gain traction.  Your fingers knead into " + flags[kFLAGS.GOO_NAME] + "'s supple assflesh, working her cheeks like dough in your hands, roughly massaging her backside until she starts to relax around you.  \"<i>Good girl,</i>\" you whisper, reaching forward to stroke " + flags[kFLAGS.GOO_NAME] + "'s hair.  \"<i>That's a good girl, just relax.  Take it...  You wanted it so bad.</i>\"");
	outputText("\n\n\"<i>I-I'm sorry, [Master],</i>\" " + flags[kFLAGS.GOO_NAME] + " repeats, her breath choking up as you grind your hips into her, pushing just a touch more prick into her ass.  \"<i>I didn't mean to...  I'll be a good girl, I promise,</i>\" she whines, groaning as you slowly pull out of her, retracting your cock until just the head remains.  \"<i>Fuck me, [Master], pleeeeaaaassssseeee,</i>\" she cries, \"<i>just fuck me, fuck me, fuck me!</i>\"");
	outputText("\n\nYou grab her hips and slam forward, hilting yourself again in a single thrust. " + flags[kFLAGS.GOO_NAME] + " cries out, her voice echoing in the distance as you roughly pound her asshole, thrusting into her again and again until you can feel yourself approaching your limit, the near-frictionless hole you're hammering too good to pass up.  But " + flags[kFLAGS.GOO_NAME] + " still hasn't been properly put in her place.  You're supposed to be in control here, not her.  You protect her, feed her, care for her, and she still thinks she can control you.  Unacceptable.  You push back into her, forcing yourself in to the hilt, and stop.  You hold yourself utterly still, simply enjoying the smooth liquid feel of her latex-coated ass.");
	outputText("\n\n\"<i>M-[Master]?  Please...</i>\" " + flags[kFLAGS.GOO_NAME] + " begs, looking pleadingly over her shoulder.  \"<i>I'm still so hungry...</i>\"");
	outputText("\n\nAs soon as she says \"<i>hungry,</i>\" you strike. With palm open, you level a harsh stroke across " + flags[kFLAGS.GOO_NAME] + "'s backside, sending her ass quivering.  You gasp with delight as the force of your spank carries right through her, making the latex inside her jiggle wildly around your [cock biggest].  " + flags[kFLAGS.GOO_NAME] + " sucks in breath through her onyx teeth, but looks back at you with a look filled with lust, as if she can sense how close you are.  She wiggles her ass again, almost invitingly.  You lash out again, spanking her hard enough to nearly knock the two of you over; then again, and again, each time nearly pushed over the edge by the jiggle in her butt after your attack.");
	outputText("\n\nEventually, you can take no more.  You feel the rush of semen hurtling through your [cock biggest], and with one last smack, send yourself over the edge.  You throw your head back and roar your pleasure into the sky as cum pours out of your cock-slit and into " + flags[kFLAGS.GOO_NAME] + "'s hungry ass, painting her ebony rectal walls white.  As spunk pours out of you, " + flags[kFLAGS.GOO_NAME] + " moans lewdly, hungrily, an orgasmic look on her face as the pain of the spanking is replaced by the satisfaction of your seed flowing into her.");
	outputText("\n\nWhen your second orgasm passes, you roll limply off of " + flags[kFLAGS.GOO_NAME] + ", utterly sated.  Your [chest] heaving, you sigh peacefully as you close your heavy lids, eager to rest.  A moment later, though, you feel slick skin press against your own as " + flags[kFLAGS.GOO_NAME] + " curls up beside you, her face inches from your own.  With a wan smile, you reach out and run your fingers through her hair before pulling her into a long kiss that leaves your own taste on your lips.");
	//{Low happiness}
	if (gooHappiness() < 33) outputText("\n\n\"<i>If it's always going to be like that, maybe... being here with you isn't going to be so bad after all,</i>\" " + flags[kFLAGS.GOO_NAME] + " whispers.");
	//{Moderate happiness}
	else if (gooHappiness() < 66) outputText("\n\n\"<i>I'm sorry I got so forceful, [name].  I enjoy serving you... I do.</i>\"");
	//{High happiness}
	else outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " nuzzles against you, her head coming to rest on your [chest].  \"<i>Sorry, [name]. I didn't mean to try and force you.  I love you when you're so assertive, so... dominant.</i>\"");
	temp = 30;
	player.orgasm();
	dynStats("sen", -2);
	if (player.cumQ() >= 500) temp += 20;
	gooFluid(temp);
	//{Boost her happiness a tiny amount.}
	gooHappiness(5);
	gooObedience(5);
	doNext(camp.returnToCampUseOneHour);
}

//Dominant Fucking Her(F)
//Requires obedience of 60+
//Female Dominant Fuck (Goo No Futa)(F)
private function femalePCDomFucksLatexGoo():void {
	clearOutput();
	outputText("You start to undress, remarking to " + flags[kFLAGS.GOO_NAME] + " that you've got an itch she'd be great at scratching.  As if your language wasn't clear enough, you ");
	if (player.balls > 0) outputText("lift your [sack] out of the way to ");
	else if (player.hasCock()) outputText("lift your " + player.multiCockDescriptLight() + " out of the way to ");
	outputText("expose your [vagina], labia already engorged and rosy with lust.");

	//{NOT OBEDIENT ENOUGH}
	if (gooObedience() < 60) {
		if (gooFluid() < 33) outputText("\n\nLicking her lips with unrepentant hunger");
		else if (gooFluid() < 66) outputText("\n\nSticking her tongue against her cheek in consternation");
		else outputText("\n\nRolling her eyes");
		outputText(", " + flags[kFLAGS.GOO_NAME] + " ");
		if (gooObedience() < 20) outputText("boldly retorts");
		else if (gooObedience() < 40) outputText("answers snarkily");
		else outputText("timidly protests");
		outputText(", \"<i>No.  You can't make me.  I may be stuck in this camp and separated from my people, but I will not let myself be some sexual toy.</i>\"  A trickle of inky lubricant between her legs");
		if (flags[kFLAGS.GOO_DICK_LENGTH] > 0) outputText(" and the rigidity of her " + gooCock() + " have");
		else outputText(" has");
		outputText(" you doubting that claim, but she seems resolute in her desire to avoid direct sex, for now.");
		if (gooFluid() < 15) outputText("  Her hunger is palpable, perhaps it would be best if you simply 'fed' her soon?");
		doNext(camp.returnToCampUseOneHour);
		gooObedience(-3);
		return;
	}
	//{OBEDIENT}
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " immediately goes down on all fours and bows in submission.  \"<i>How would you like to fuck me, [Master]?</i>\" she asks.");
	outputText("\n\nTouching a finger to her chin, you raise her gaze to your own, commanding her in no uncertain terms to spread her legs.  You want to feel her onyx pussy grinding up against your own sultry box, clit buried in between her slippery labia.  She obeys, pliant slut that she is.  You finish undressing, and after tossing your [armor] aside, you slide right up against her, enjoying the smooth texture of her latex legs as they slide underneath your slick moisture.  There's a burst of warm electric heat in your groin when you contact " + flags[kFLAGS.GOO_NAME] + "'s liquid-covered loins, delicious, lust-fueled fire that melts your restraint.");
	outputText("\n\nImmediately, the sable slickness that coats " + flags[kFLAGS.GOO_NAME] + "'s hairless snatch begins to cling to yours.  It feels slipperier than your own secretions, but the edges of the sexual oil patch quickly begin to dry as they're exposed to the air.  The hardening liquid latex tingles tightly around your vulva, snaring the outer surface of your sex in solid black.  This new sensation is far from unpleasant.  In fact, the constricting encasement heightens the onslaught of sapphic sensations assaulting you.");
	if (flags[kFLAGS.GOO_DICK_LENGTH] > 0) outputText("  Meanwhile, the " + gooCock() + " sways uselessly above the conjoined vaginas, leaking its own secretions as it's ignored.");
	outputText("  Lost to the pleasure, you rock your [hips] back and forth, up and down, mindlessly rubbing yourself to new heights of ecstasy on your pet's super-slick snatch.");
	outputText("\n\nA sensual shiver rocks your world, assaulting your senses with its intensity.  Unthinkingly, you reach for your [chest]");
	if (player.biggestTitSize() >= 1) {
		outputText(", kneading your chest");
		if (player.lactationQ() > 50) {
			outputText(" as milk ");
			if (player.lactationQ() < 200) outputText("dribbles over your fingers");
			else if (player.lactationQ() < 500) outputText("squirts out unhindered");
			else outputText("sprays out in a fountain");
		}
	}
	else outputText(", pinching your [nipples]");
	outputText(".  Arching your back, you grab hold of " + flags[kFLAGS.GOO_NAME] + " by the ankles and drag her against you.  She whimpers at the pressure on her nethers, too sensitive to endure what you're forcing her to experience.  A high-pitched trill of excitement splits the air.  " + flags[kFLAGS.GOO_NAME] + " is cumming, hard by the sounds of it.  Hot, inky discharge splatters across your [clit] and into your [vagina].");
	if (player.hasCock()) outputText("  Some of it even splats onto your " + player.multiCockDescriptLight() + ", leaving tight black spots on your maleness.");
	if (flags[kFLAGS.GOO_DICK_LENGTH] > 0) outputText("  Her " + gooCock() + " practically bursts from within, distending to accommodate its lurid latex discharge.  Most of it splatters against " + flags[kFLAGS.GOO_NAME] + "'s skin and rolls down her flesh in a march of onyx droplets.");
	outputText("\n\nAs her essence burrows inside you, your [vagina] clenches of its own volition.  Your eyes roll back from the ecstasy your netherlips jolt into your spine, and you pull tighter on your toy's legs, dragging her oily quim tighter against your goo-gilt slit.  The two latex pussies gush and gleam with each other's hot lubricants.  They quiver feverishly, clits rigid and erect, happily sharing in feminine bliss.  There's two voices screaming, crying out to the heavens in mismatched harmony.  The higher one dies down to a low moan of contentment, and once your cunt slackens in the aftermath of your orgasm, you realize the second is your own.");
	outputText("\n\nYou mash your [vagina] against " + flags[kFLAGS.GOO_NAME] + "'s a few more times to savor the aftershocks of climax.  She grunts each time, her mouth widening into simple 'o's.  The sensuously skinned lady fails can't even scream any more.  The best she can do is moan, low and lewd as you finish using her.  As you slowly begin to separate, a tangle of sable webs hangs in the air, glittering with a coating of femcum.  Some of them are already semi-solid and snap at your withdrawal.  The others just come apart, wetly slapping against each twat as they separate.");
	outputText("\n\nRising, you examine your [vagina].  In addition to being so heavy and wet, it's coated with a solid sheet of latex.  You've no doubt it would hurt to remove");
	if (player.findPerk(PerkLib.Masochist) >= 0) outputText(", so you do, gleefully stripping the material from your skin.  Juices gush from your [vagina] as you torture your mons with masochistic pleasure, peeling the adhesive substance away to reveal pain-reddened skin.  " + flags[kFLAGS.GOO_NAME] + " looks up at you in awe, and with a shudder, you pat her on the head.  \"<i>Good pet.</i>\"");
	//{ALT:
	else {
		outputText(".  Of course, you've got a pet right here that's already an obedient little cunt-cleaner.  You plant your [vagina] right on her face and command, \"<i>Lick it clean.</i>\"");
		outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " enthusiastically puts her tongue to work, and at her touch, the inky substance melts away.  The parting fluid washes you with warmth as it vanishes into your pet's mouth, one drop at a time.  She greedily devours her leavings along with your copious, post-orgasmic lubrication, hungrily devouring it all.  Her tongue dives inside you to clean out your passageway.  Pistoning back and forth, she fucks you with it, making a meal for herself and carrying the liquid latex away on waves of your own lady-lubricants.  " + flags[kFLAGS.GOO_NAME] + " appears intent on slaking her unnatural thirst, and she continues to stimulate and drink long past when you think she'd be done.");
		//{FIRST TIME}
		if (flags[kFLAGS.LATEX_GOO_TIMES_FEMDOMMED_BY_PC] == 0) {
			outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " will not relent.  You command her, \"<i>Stop, I'm clean!</i>\"  She doesn't.  You push her away with a [foot], nearly dropping as two feet of tongue unspool from your tongue-gaped vagina.  She pants up at you, then tries again.  You boot her back down, this time pinning her under a leg.  " + flags[kFLAGS.GOO_NAME] + "'s tongue reaches out, but you grab it in your hand and push her forehead back down with her other.  She whimpers.  Calmly, you tell her that next time you request a cleaning, she had better stop on command.");
			outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " blinks raven-hued tears away, understanding at last.  You release her and step rise, feeling a twinge of fresh arousal.  Your pet appears humbled but sated.  Best of all, she's left a puddle of onyx cunt-juice below her, freshly excreted while she was restrained.  Good girl.");
		}
		//{REPEAT}
		else outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " obeys, remembering the last time.  Two feet of tongue unspool from your [vagina] as she retracts it.  Her shining face obediently lowers in a bow, but you swear you can see a smile twisting the corners of her mouth.  You tell her she's a good pet, and a fresh flow of wetness escapes from her nethers.");
		flags[kFLAGS.LATEX_GOO_TIMES_FEMDOMMED_BY_PC]++;
	}
	player.orgasm();
	dynStats("sen", -2);
	gooFluid(5+player.wetness()*2);
	gooObedience(5);
	gooHappiness(2);
	doNext(camp.returnToCampUseOneHour);
}
//Female Dominant Fuck (Goo IS Futa)(F)
private function femalePCDomFucksLatexGooFuta():void {
	clearOutput();
	outputText("You begin to remove your [armor] under " + flags[kFLAGS.GOO_NAME] + "'s curious eye.  She asks, \"<i>[name], what are you doing?</i>\"");
	outputText("\n\nWith a salacious wiggle of your [hips], you tell her that you're going to fuck her - to ride her shining pole to orgasm after orgasm.  " + flags[kFLAGS.GOO_NAME] + "'s " + gooCock() + " immediately stiffens, hard and proud.  ");
	//{NOT OBEDIENT ENOUGH}
	if (gooObedience() < 60) {
		if (gooFluid() < 33) outputText("Licking her lips with unrepentant hunger");
		else if (gooFluid() < 66) outputText("Sticking her tongue against her cheek in consternation");
		else outputText("Rolling her eyes");
		outputText(", " + flags[kFLAGS.GOO_NAME] + " ");
		if (gooObedience() < 20) outputText("boldly retorts");
		else if (gooObedience() < 40) outputText("answers snarkily");
		else outputText("timidly protests");
		outputText(", \"<i>No.  You can't make me.  I may be stuck in this camp and separated from my people, but I will not let myself be some sexual toy.</i>\"  A trickle of inky lubricant between her legs and the rigidity of her " + gooCock() + " have you doubting that claim, but she seems resolute in her desire to avoid direct sex, for now.");
		if (gooFluid() < 10) outputText("  Her hunger is palpable, perhaps it would be best if you simply 'fed' her soon?");
		gooObedience(-3);
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	//{OBEDIENT ENOUGH}
	outputText("At first, she reaches down to touch herself, so aroused by the idea she wants to get started right away, but she remembers her place and stops.  The ebony slave-girl asks, \"<i>Shall I sit down for you to ride me, [Master]?  Or would you rather I mount you?</i>\"");
	outputText("\n\nYou tell her that you're in charge, so you'll be on top.  " + flags[kFLAGS.GOO_NAME] + " smiles broadly and splays herself out on the ground, reclining against a sizable boulder.  Her ");
	if (gooFluid() > 60) outputText("nicely plumped ");
	outputText("rump bulges out a bit when she settles out on it, and you pause a moment to admire the curvy onyx shape before you.  Her " + gooCock() + " stiffens before your eyes.  Its reflective obsidian skin slowly goes taut, making it shine in the light.  Bigger and bigger, it grows until it reaches its limit, and even then, " + flags[kFLAGS.GOO_NAME] + "'s erection plumps a little further, like a sausage stuffed a little too full.  You gingerly touch it, and it rewards your curiosity with a bead of black pre-goo.");
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " lewdly moans, \"<i>Oooooh... I always loved making these things...</i>\"");
	outputText("\n\nYou gently pat the " + gooCock() + " and snicker at her - of course she did.  How fortuitous that she'll get to be your dildo today, then.  You stroke the iron-hard penis with a thumb and it jumps high, bouncing up towards the contact like a cat wanting to be petted.  Snickering, you brush through the black bubble, smearing pre-cum up and down over the turgid erection.  The liquid latex pre-cum quickly dries on your hand to give it the appearance of a gloss-black glove.  You figure you may as well complete the look, and after switching hands, you have matching mitts.  The latex woman's tool remains defiantly unchanged by her pre-cum - it seems to absorb directly into her skin once it dries, leaving it as slippery and black as ever.  As fun as this is, you don't want her to blow just yet, at least not until you've had your fun.");
	outputText("\n\nGrabbing it by the base, you angle the " + gooCock() + " up towards you.  Its tip thickens noticeably as if reading your intentions.  You swivel your [hips] around to hover above it, and without preamble, you push down, absorbing the slippery latex dick into your slick passage.  Between its pre-cum and your own lubricants, the penetration is blessedly easy.");
	if (flags[kFLAGS.GOO_DICK_LENGTH] * flags[kFLAGS.GOO_DICK_LENGTH]/6 > player.vaginalCapacity()) outputText("  Of course, as gigantic as it is, you can't take all of it, but you do your damnedest to try.");
	else outputText("  Soon, your [butt] comes to rest against " + flags[kFLAGS.GOO_NAME] + "'s oily skin, her erection nestled nicely inside you.");
	outputText("  You take a few experimental bounces, enjoying the feeling of that " + gooCock() + " pressing on your folds and stirring against your insides.  Your pet reaches up to grab onto your [hips] for support.  She pants ");
	if (player.isTaur()) outputText("into your haunches");
	else if (player.tallness >= 84) outputText("against your side");
	else if (player.tallness >= 70) outputText("into your shoulder");
	else if (player.tallness >= 60) outputText("into your neck");
	else outputText("over your head");
	outputText(", trying to pull herself up against you, deeper inside you.");
	player.cuntChange(flags[kFLAGS.GOO_DICK_LENGTH] * flags[kFLAGS.GOO_DICK_LENGTH]/6,true,true,false);
	
	outputText("\n\nYou bounce atop " + flags[kFLAGS.GOO_NAME] + " faster and faster");
	if (flags[kFLAGS.GOO_DICK_LENGTH] * flags[kFLAGS.GOO_DICK_LENGTH]/6 <= player.vaginalCapacity()) outputText(", your [butt] clapping wetly against her onyx thighs");
	outputText(".  All too soon, you feel a telltale twitching of the " + gooCock() + " inside you, and before you can stop it, a thick, slick feeling of warmth radiates outward from your womb.  Accompanying the explosion of moisture and bodily heat, a gradual pressure wells up in your womb, culminating in an explosion of slick sable goop that ");
	if (flags[kFLAGS.GOO_DICK_TYPE] == CockTypesEnum.DOG) outputText("stays trapped inside you thanks to your pet's thick knot");
	else outputText("sprays out of your [vagina]");
	outputText(".  You look over your shoulder and scold, \"<i>I didn't give you permission to cum!</i>\"");
	
	outputText("\n\n\"<i>I couldn't stop myself, [Master]...  You feel too good!  It's like a vice made out of honey just wringing me dry!</i>\" " + flags[kFLAGS.GOO_NAME] + " blurts.  Well, it's hard to be mad with a proclamation like that.  She goes on to say, \"<i>Don't worry, I'll stay hard.  I'm a goo-girl, remember?  Shifting a little bodily fluid around is nothing.</i>\"");
	outputText("\n\nDeciding that you'll forgive her for now");
	if (!player.isTaur()) {
		outputText(", you turn around to face her, pressing your [chest] into hers.");
		if (flags[kFLAGS.GOO_NIPPLE_TYPE] == -1) {
			outputText("  Her nipple-cunts ");
			if (player.hasFuckableNipples()) outputText("kiss yours");
			else outputText("swallow your nipples");
			outputText(".");
		}
		else if (flags[kFLAGS.GOO_NIPPLE_TYPE] == 1) {
			outputText("  Her nipple-cocks ");
			if (!player.hasFuckableNipples()) outputText("smear over the tops of your tits");
			else outputText("disappear into your nipplecunts");
			outputText(".");
		}
		else {
			outputText("  Her nipples ");
			if (!player.hasFuckableNipples()) outputText("rub all over your own");
			else outputText("dock into your nipple-cunts");
			outputText(".");
		}
	}
	else outputText(", you begin to fondle your [nipples] and bounce haunches on her lap.");
	outputText("  Gods, you could get used to this!  You spare a glance to your [vagina] and recoil when you see how your mound has been gilt with black latex.  It makes sense, but it startles you all the same.  Grunting, you resume fucking her, feeling her gooey cum squirting out of the messy onyx creampie she's turned your pussy into.  Beneath her, a puddle of her lubricants mixed with cum has formed.");
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " begs, \"<i>May I kiss you, please [Master]?  I-I'm gonna cum soon!</i>\"");
	outputText("\n\nAgain?  Feeling a little generous, or maybe just horny, you award her a nod.  She can kiss you.  ");
	if (player.isTaur()) outputText("The latex woman wastes no time in bending double to kiss your equine ass, even darting forward to smooch your tender ring.");
	else outputText("The latex woman wastes no time in placing her glossy lips against yours, even plunging her slick tongue into your mouth.");
	outputText("  Her passionate kisses and twitching boner overwhelm your senses, and before you can warn her, you cum.");
	outputText("\n\nYou clench down on the " + gooCock() + " without warning, immediately setting to massaging it with your velvety interior.  Your pussy seems to know just what to do in order to get what it wants, and " + flags[kFLAGS.GOO_NAME] + " is no match.  She stutters, \"<i>G-g-g-onna... OHGODS!</i>\" and begins to spurt, sputtering streams of onyx goop straight into your womb.  Her lips crush back into place, silencing her whimpers of bliss");
	if (!player.isTaur()) outputText(" along with your own");
	outputText(".  Together, the two of you give in to ecstasy and cum... and cum... and cum.");
	if (player.hasCock()) outputText("  White erupts from your " + player.multiCockDescriptLight() + " with abandon.  You don't even care that it stains " + flags[kFLAGS.GOO_NAME] + "'s " + gooTits() + ".  It feels so good and she looks so pretty with strands of icing spattering over top of her.");
	if (player.hasCock() && player.cumQ() >= 750) outputText("  Of course, you quickly bury those strands in a wave of alabaster.");
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " hugs you tight as she finishes unloading inside you.  Those last few squirts of sable spunk make your cunny feel like a mush of pleasure.  Sighing contentedly, you rise up off of your conquest");
	if (flags[kFLAGS.GOO_DICK_TYPE] == CockTypesEnum.DOG) outputText(", ignoring the loud 'pop' of her knot slipping free,");
	outputText(" and present your stained vagina to her face.  She knows what to do, and immediately sets to cleaning it with her tongue.  Over two feet of flexible mouth muscle burrow into your [vagina], and the pleasant caresses let you know just much your pet enjoys this task.  She devours her sticky spunk and your female fluids with ardor, never slowing in her task.  Even when you're sure that you're clean, she keeps going, inciting tingles of fresh lust from your body.");
	outputText("\n\nThat will not do.  You command her to stop");
	if (flags[kFLAGS.LATEX_GOO_TIMES_FEMDOMMED_BY_PC] > 0) outputText(", and obediently, she does.  To reward her for being a good pet, you give her a deep tongue kiss.");
	else {
		outputText(", but the order goes unheeded.  " + flags[kFLAGS.GOO_NAME] + "'s nose disappears into the slimy mess that your pussy has become, pressing deeper and harder to gluttonously devour your juices.  Tired of her insubordination, you shove her back, shuddering when inch after inch of slithering tongue slides free.  The sensuously-skinned slut immediately tries to get back up, but you force her down and slap her, right across the face.  She stops cold, slowly raising a hand to her cheek.  Glittery black tears escape from her eyes as she apologizes, \"<i>I'm sorry!  I'm sorry!  I'll be good, I'll be good!  I promise!</i>\"");
		outputText("\n\nYou nod, and then, before she can dwell on her punishment, you give her a kiss.  She blushes purple afterward, giggling into her palm.");
	}
	outputText("  You get dressed and leave with a swagger in your step.  A smiling, solid goo-girl sits in your wake.");
	player.orgasm();
	dynStats("sen", -2);
	player.slimeFeed();
	flags[kFLAGS.LATEX_GOO_TIMES_FEMDOMMED_BY_PC]++;
	gooFluid(5+player.wetness()*2);
	gooObedience(4);
	gooHappiness(2);
	doNext(camp.returnToCampUseOneHour);
}

//Male Dominant Fuck(F)
private function malePCDomFucksLatexGoo():void {
	clearOutput();
	outputText("You open your [armor] to expose your " + player.multiCockDescriptLight() + " to your latex-based lover.  She eyes it with unabashed affection and licks her lips unthinkingly, already tasting the flavor of semen on her tongue.  " + flags[kFLAGS.GOO_NAME] + " jolts out of her reverie to ask, \"<i>What are you doing");
	if (gooObedience() > 50) outputText(", [Master]");
	outputText("?</i>\"");
	outputText("\n\nYou take her chin in your palm and tilt her up to look at you as you explain.  You intend to fuck her nice and hard.  Then, you're going to blow a nice thick load in her stretchy, gooey little pussy until there's ribbons of white dripping out of her slit.  " + flags[kFLAGS.GOO_NAME] + " blushes violet at your proclamation.  Between her knees, a few drops fall unbidden to the ground.  Solid black nipple");
	if (flags[kFLAGS.GOO_NIPPLE_TYPE] == 1) outputText("-cock");
	outputText("s harden on her chest, jutting out and just begging to be sucked.");
	//{NOT OBEDIENT ENOUGH}
	if (gooObedience() < 60) {
		if (gooFluid() < 33) outputText("\n\nLicking her lips with unrepentant hunger");
		else if (gooFluid() < 66) outputText("\n\nSticking her tongue against her cheek in consternation");
		else outputText("\n\nRolling her eyes");
		outputText(", " + flags[kFLAGS.GOO_NAME] + " ");
		if (gooObedience() < 20) outputText("boldly retorts");
		else if (gooObedience() < 40) outputText("answers snarkily");
		else outputText("timidly protests");
		outputText(", \"<i>No.  You can't make me.  I may be stuck in this camp and separated from my people, but I will not let myself be some sexual toy.</i>\"  The trickle of inky lubricant between her legs");
		if (flags[kFLAGS.GOO_DICK_LENGTH] > 0) outputText(" and the rigidity of her " + gooCock() + " have");
		else outputText(" has");
		outputText(" you doubting that claim, but she seems resolute in her desire to avoid direct sex, at least until you train her a bit better.");
		if (gooFluid() < 10) outputText("  Her hunger is palpable, perhaps it would be best if you simply 'fed' her soon?");
		gooObedience(-3);
		doNext(camp.returnToCampUseOneHour);
		return;
	}
	//{OBEDIENT ENOUGH}
	outputText("\n\nBlowing you a seductive kiss, " + flags[kFLAGS.GOO_NAME] + " purrs, \"<i>And how would you like to take me today, [Master]?  In my ass?  In my pussy?  Or do you want to fuck my mouth?</i>\"");
	outputText("\n\nPointing down, you instruct her that you intend to take advantage of all three.  The rubbery slut squeals with glee and drops to her knees before you, giggling, \"<i>I bet I can make you cum in each of them, [Master]!</i>\"  ");
	if (player.cor < 33) outputText("Smiling");
	else if (player.cor < 66) outputText("Smiling knowingly");
	else outputText("Tired of her blather");
	outputText(", you grab her by the head and pull her forward.  She gets the idea and spreads her mouth into a wide 'O', just in time for [oneCock] to pop inside, sliding through the onyx opening with an accompanying groan of delight from your throat.  Your lover's gooey neck allows you to enter it, ");
	if (player.biggestCockArea() < 80) outputText("easily encompassing your erection");
	else outputText("gleefully stretching into a mold of your erection as it passes into her core");
	outputText(".  Past her mouth, her insides become far less solid.  It feels like a mass of warm goo that deep inside her, and combined with the feel of her slippery tongue caressing the underside of your " + player.cockDescript(0) + ", you feel like you're in heaven.");
	if (player.cockTotal() > 1) {
		outputText("  It gets even better when she grabs your remaining member");
		if (player.cockTotal() > 2) outputText("s");
		outputText(" and starts to pump with sure strokes.");
	}
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + "'s vibrant " + flags[kFLAGS.GOO_EYES] + " eyes look up at you as her cheeks hollow to provide suction.  You groan again, this time slowly pulling her head back.  As she withdraws, her slick black spit drips from your dick, though much of it gradually hardens into a reflective sheath for your tool.  You draw her off until only your " + player.cockHead() + " remains inside that suckling pleasure-hole.  Then, you slam her down, fucking her mouth");
	if (player.biggestCockArea() >= 10 && player.biggestCockArea() < 50) outputText(" and throat");
	else if (player.biggestCockArea() >= 50) outputText(", throat, and body");
	outputText(" with quick strokes.  Faster and faster you bounce her on your loins");
	if (player.biggestCockArea() >= 80) outputText(", amazed that she can take so much so easily");
	outputText(".  Best of all, her eyes never stop looking up at you, imploring you to cum, to release and stuff her face with spunk.");
	outputText("\n\nWith her looking at you like that, fuck... you're cumming!  You pull her lips tight into your abdominal " + player.skinFurScales() + " and release the boiling bliss within you.  Your jizz jumps out of you in thick ropes, as if it was seeking to escape all this time and just now found freedom.  " + flags[kFLAGS.GOO_NAME] + " smiles around your " + player.cockDescript(0) + " as it pumps its virile goo down her throat, and she grabs hold of your [butt] to press herself against you harder.");
	if (player.cumQ() >= 500) outputText("  Squirts of spooge run out of her nostrils after a particularly potent blast, but " + flags[kFLAGS.GOO_NAME] + " doesn't mind or even break her gaze.");
	if (player.cumQ() >= 1000) outputText("  Your copious spunk rounds her belly, but most of that liquid weight transfers to her tits, hips, and ass in moments.");
	if (player.cumQ() >= 4000) outputText("  That isn't enough to keep up with your potency.  A moment later, the corners of her mouth begin to ooze alabaster, squirting out with each pulse.  Poor girl.");
	outputText("  Once finished, you pull her off and leave her to pant for breath.");
	
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " licks her lips and admires the latex sheath her spit has molded around [oneCock].  \"<i>One hole down, [Master].</i>\"  She holds up a hand, fingertips lengthening as they grow razor-sharp nails.  Those prickly claws press into your ");
	if (player.balls > 0) outputText("[sack]");
	else outputText("[cock biggest]");
	outputText(" without warning, and you hold very, very still.  They stroke you with immaculate, teasing care, somehow feeling good in spite of the traceries of red irritation they leave in their wake.  " + flags[kFLAGS.GOO_NAME] + " tickles them across your taint longingly before retracting them wistfully and asking, \"<i>Are you ready for my pussy?</i>\"");
	outputText("\n\nPivoting around, the horny sextoy wiggles her ass in front of you to tease.  The rounded rump jiggles ever so slightly with each shake, reflecting the light as the ripples run across each plump cheek.  A fresh surge of blood to your genitals informs you that yes, you are ready for her pussy.  You grab hold of the ebony seductress by her narrow waistline and spank her for daring to scratch your ");
	if (player.balls > 0) outputText("balls");
	else outputText("cock");
	outputText(".  She whines, but wiggles back in your direction, staying locked on her target in spite of the punishment.  An ebony slit, so warm and wet that it feels like it's blowing steam onto your erection, closes the few inches of separating air.");
	outputText("\n\nThe teases have the desired effect on you, and you yank her down on your " + player.cockDescript(0) + ".  Like her mouth and throat, her cunt quickly goes gooey once you get past her feminine lips.  Inside, she feels like a combination of warm gelatin and vagina, having all the flexibility and yielding nature of the former combined with the exquisitely textured interior of the latter.  The sensuous, smooth surface of " + flags[kFLAGS.GOO_NAME] + "'s ass rubs over your [hips] as her cunt swallows the entirety of your prick.  Tendrils of inescapable excitement worm their way up your spine, fed by your stiff manhood's orgasm-induced sensitivity.  They send you into what can only be described as a sexual frenzy.");
	outputText("\n\nYou grab " + flags[kFLAGS.GOO_NAME] + "'s hair and pull in between strokes, forcing her to arch her back and display her body in a more pleasing manner.  Smack, smack, smack...  Your [hips] clap against her, growing faster with every moment.  Your hapless fuck-partner whines from pain and excitement, gushing black wetness across your [legs] as she cums.  You spank her rounded bottom again, and as the ripples of your vibration massage your " + player.cockDescript(0) + ", you cum again.  Her slick snatch greedily devours the first few spurts your body can offer up.  It even massages your length from root to " + player.cockHead() + " to coax out more.");
	if (player.cumQ() >= 1000) outputText("  This quickly bloats her into a pregnant-looking state, and after her last injection, she has nowhere to metabolize it all.");
	if (player.cumQ() >= 2000) outputText("  You keep going until a torrent of alabaster seed is running out of her cunt around your cock.  Glorious.");
	if (flags[kFLAGS.GOO_DICK_LENGTH] > 0) outputText("  The " + gooCock() + " below noisily fires inky loads into the dirt, where it's quickly absorbed.");
	
	outputText("\n\nStaggering back, you rest against a boulder.  In the process, your " + player.cockDescript(0) + " exits " + flags[kFLAGS.GOO_NAME] + "'s swelteringly sticky slit.  Webs of glittering black lube dangle from your tip to her entrance, mixed with spermy strands of semen.  Transfixed, you watch them break, one by one snapping back to the closest set of genitals.  A bubbly voice cheers, \"<i>That's number two!");
	if (player.cumQ() >= 1000) outputText("  And so messy!  I don't know if I can hold any more!");
	outputText("</i>\"  A hand that appears to be wearing a latex glove smears the juices that hang from " + flags[kFLAGS.GOO_NAME] + "'s mound up and through her crack, coating her asshole with your leftover sperm.");
	outputText("\n\nYou're breathing hard and more than a little exhausted from cumming back to back.  Still, there's a bubbly latex butt just a few feet away, bouncing back and forth hypnotically.  You did say you were going to cream all three holes, didn't you?");
	outputText("\n\n\"<i>Come on, [Master],</i>\" " + flags[kFLAGS.GOO_NAME] + " cheers, \"<i>I'm all ready for your cock... just put it in and I'll take all the cum you've got.</i>\"");
	outputText("\n\nLike hell!  You stagger up from your impromptu brace and grab hold of your sensuous slut once again, this time lining up with her asshole.  You're in charge here, and by gods, you're going to outfuck her!  You spank her bottom on the cheek you've ignored up to now, setting it bouncing.  Before the waves of enticing jiggles can settle, you lurch your [hips] forward and stuff your " + player.cockDescript(0) + " straight into the crinkled latex asshole.  The ebony pucker stretches obscenely around your girth, much tighter than the other two holes you've plumbed today.  Inch after inch of semi-turgid dick-flesh passes into the goo-woman's anus, but not without some difficulty.");
	outputText("\n\nOnce fully inside, her tight sphincter clamps on your " + player.cockDescript(0) + " like a cock-ring, trapping the blood inside so that it gets harder and harder.  Your erection has no trouble returning to full mast with her anal aid, and with freshened lust, you begin to bounce that sable booty on your manhood.  Beyond the tight circle, the familiar, pliant goo you've come to love begins to massage you with liquid pressure.  Waves of force roll all along your length, lapping at it like a dozen tongues, all while you're kept super-hard by her entrance.");
	outputText("\n\nAgain and again, you claim your prize's anal star.  Your hips seem to go on autopilot, plumbing that black butthole with rough passion.  Squirts of gooey ink and leftover, smeared spunk dribble out as you fuck her, and you grab hold of her " + gooTits() + ", as if a handhold would help you wrangle the unruly pleasure any better.  " + flags[kFLAGS.GOO_NAME] + " moans, \"<i>Oh, [name]!  Fuck my ass!  Spank me and abuse me, then cum in my ass and tell me how I'm yours!</i>\"");
	outputText("\n\nYou growl and slap her tit for daring to order you around.  It makes her butt squeeze you even harder.  Still, you figure a slut with a little initiative is a good slut, and she showed initiative to beg so creatively.  You reward her by giving her what she wants.  SMACK!  Your hand falls on her backside with a broad blow that you can feel all the way inside her.  She whimpers and drips in answer, so you do it again, this time on the other side.  A bigger rain of drips escapes her this time.  You work the blows into your rhythm - bounce in, bounce out, slap, bounce in, bounce out, slap...  Fuck, she's too tight, and you're too sensitive to hold it in.");
	outputText("\n\nYou cry out, \"<i>Here it comes!</i>\" and hilt yourself inside your latex pet, pinching her nipples hard as you begin to unload inside her.  She trembles beneath you, whining in a high-pitched voice as you whisper, \"<i>My pet...</i>\" into her ear.  While your cock does its best to inseminate the gooey woman, you keep whispering to her, explaining that she is yours, body and soul, to be used and abused.  You even begin to mention kinky ways you can take advantage of her unique form, filling her mind with ideas for future submission as your " + player.cockDescript(0) + " fills the rest of her.");
	if (player.cumQ() >= 1000) outputText("  Almost immediately, cream drips out around her ass and over your [legs].  She's just too full to take much more - your cum has nowhere to go but out!");
	if (player.cumQ() >= 2000) {
		outputText("  You cum so much that your spunk forms a nice sized ");
		if (player.cumQ() < 4000) outputText("puddle");
		else outputText("lake");
		outputText(".");
	}
	outputText("\n\n" + flags[kFLAGS.GOO_NAME] + " slides off you, going flat on the ground and into a puddle ");
	if (player.cumQ() >= 1000) outputText("of mixed fluids");
	else outputText("of her own leftover sex-juice");
	outputText(".  Every now and again, her butt lifts slightly and jiggles, then lowers.  She's whimpering and twitching, riding the aftershocks of her own orgasm.  You're exhausted, but you stand triumphant.  You fucked your latex slave in all three of her holes and outlasted her to boot.");
	outputText("\n\nAs you get dressed, you realize your " + player.cockDescript(0) + " is totally clean.  It appears glossy, as if shined with spit, but there is no latex residue on it.  Somehow, her asshole must have absorbed her dried girl-cum and saliva back into her.  You didn't expect to get cleaner from anal sex, but it certainly let you end on a high note.  You get dressed with a swagger in your step and head back to the center of camp.");
	outputText("\n\nIn your absence, a tired voice sighs, \"<i>That's... three.</i>\"");
	temp = 15;
	player.orgasm();
	dynStats("sen", -2);
	if (player.cumQ() >= 500) temp += 10;
	if (player.cumQ() >= 1000) temp += 10;
	if (player.cumQ() >= 1500) temp += 10;
	if (player.cumQ() >= 2000) temp += 10;
	gooFluid(temp);
	player.changeFatigue(10);
	gooObedience(4);
	gooHappiness(2);
	doNext(camp.returnToCampUseOneHour);
}

//Savin Really Wants to Breastfeed Latexy Because He's a Weird Milk Fetishist Like That
//Mmm milk
//[Requirements: PC must be lactating, of course, and have C+ cup tits. Also high Happiness because I like lovey dovey stuff, okay?]
private function feedLatexySomeMilk():void {
	clearOutput();
	outputText("You cup your hands under your milk-laden breasts and ask " + flags[kFLAGS.GOO_NAME] + " if she's hungry.");
	//{Not hungry}
	if (gooFluid() >= 66) outputText("  She shrugs, but gives you a little smile as she sidles closer to you. \"<i>No, but if you need to lighten your load... I'm your girl!</i>\"");
	//{Middling hungry}
	else if (gooFluid() >= 33) outputText("  She licks her lips in response to your offer, obviously ready for a taste of your delicious milk.");
	//{Really fucking hungry}
	else outputText("  Before you've even completed your offer, " + flags[kFLAGS.GOO_NAME] + " is on you like a moth to a flame, eagerly pulling at your clothes to try and free your teats.");
	outputText("\n\nYou lead " + flags[kFLAGS.GOO_NAME] + " off to a nearby rock, and pull yourself up to a sitting position.  With a smile, your latex girl curls up on your lap, her soft, smooth arms affectionately wrapped around your shoulders.  You spare a moment to brush her long, sleek hair, running your fingers through the smooth strands as your other hand works to strip off your [armor].  Eventually, you disrobe, your milky teats popping free of your garments, [nipples] stiffening in the cool air.  " + flags[kFLAGS.GOO_NAME] + " opens her mouth hungrily, but to your surprise, presses her lips to yours before she drinks, locking you in a long, loving kiss.  You return her affection, holding her tight against you, embracing the hungry goo before finally guiding her head down to your needy [chest].");
	outputText("\n\nA tiny gasp escapes your lips as " + flags[kFLAGS.GOO_NAME] + "'s cool, smooth lips brush against your stiff nipple, the tip of her tongue just brushing against your sensitive flesh.  You moan as her full ebony lips finally lock around your teat, her long fingers holding your full breast as the first little suckle brings a drop of milk from within you, depositing it squarely into " + flags[kFLAGS.GOO_NAME] + "'s waiting palate.  A moment later, a full stream is pouring forth from you, your latex goo's oral skill tapping deep into your lactic reserves.  You roll your head back and moan lustily as " + flags[kFLAGS.GOO_NAME] + " suckles eagerly from you, her cheeks bulging slightly between each swallow, struggling to keep up with the flood of breastmilk she's taking from you.");
	outputText("\n\n\"<i>Delicious,</i>\" " + flags[kFLAGS.GOO_NAME] + " says with a grin, popping off one of your teats to tend to the other, leaving thick trails of sable saliva connecting her lips to your nipple until you brush them away with your thumb, your finger caressing her chin and cheek.  She nuzzles your hand, a sound not unlike a purr escaping her lips before she slips down, rubbing her cheek against your other breast.  \"<i>Mmm, I love the taste,</i>\" she giggles girlishly, resting her head a moment on your chest.  \"<i>You're wonderful, [name].  So good.</i>\"");
	outputText("\n\nYou smile and ruffle " + flags[kFLAGS.GOO_NAME] + "'s hair, giving her a gentle nudge toward your other needy tit.  Rather than suckle, she plants a quick kiss right on the tip of your [nipple], sending a shiver of pleasure rolling through you.  Before you've recovered, " + flags[kFLAGS.GOO_NAME] + "'s attached herself to you, her hands wrapped tight around your breast as her tongue flicks across your teat, teasing the first droplets of milk from you.  As she urges your first drops into a proper stream of warm, wonderful milk, you curl your fingers through " + flags[kFLAGS.GOO_NAME] + "'s hair and pull her tight against you, gently arching your back so that her face is wholly buried in your milky bosom.  She giggles into your titflesh, her laugh letting tiny rivulets of milk trickle down her chin and onto her own massive bosom, the contrast of white smearing onto black catching your eye even as her ebony tongue swirls around your sensitive bud.");
	//{elseif PC has both}
	if (player.hasCock() && player.hasVagina()) outputText("\n\nAs she suckles, " + flags[kFLAGS.GOO_NAME] + "'s hands wander downward, her fingers brushing tantalizingly across your supple flesh until her smooth tips find your dual genitals.  One hand quickly wraps around your half-turgid shaft as the other plunges into your slick and eager fuckhole, both aroused and ready by the teasing and suckling you're getting.  " + flags[kFLAGS.GOO_NAME] + " moves her hands in unison, one drawing up to the crown of your [cock biggest] as the other plunges deep into your vaginal depths before both release, pulling down to the base or withdrawing to the tips before going again and again.");
	//{If PC has a cock}
	else if (player.hasCock()) {
		outputText("\n\nAs she suckles, " + flags[kFLAGS.GOO_NAME] + "'s hand wanders downward, her fingers brushing tantalizingly across your supple flesh until her smooth tips rub against the half-hard shaft of your [cock biggest].  You stifle a gasp as the latex girl wraps her fingers around your prick, needing only the slightest touch to get you nice and turgid.  She moves her hand in slow, languid motions, slowly drawing her unnaturally smooth hands up and down your shaft, from crown to base, giving gentle twists and squeezes in time with her suckling upon your teat.");
	}
	//{elseif PC has cunt}
	else if (player.hasVagina()) outputText("\n\nAs she suckles, " + flags[kFLAGS.GOO_NAME] + "'s hand wanders downward, her fingers brushing tantalizingly across your supple flesh until her smooth tips rub against the outer folds of your [vagina].  You only just stifle a gasp as her long fingers slip into your ready hole, already aroused and eager to fuck.  Her hand moves into you, feeling like an unnaturally flexible dildo as she pushes inches of latex into you, each thrust in time with a suckle of your teat.");
	//{elseif PC ain't got shit, captain}
	else outputText("\n\nAs she suckles, " + flags[kFLAGS.GOO_NAME] + "'s hands wander downward, her fingers brushing tantalizingly across your supple flesh until her smooth tips send a shiver up your spine, her knuckles running across your exposed [asshole] as she works her fingers into your [butt].  With no other genitalia on offer, you grit your teeth as " + flags[kFLAGS.GOO_NAME] + " slithers a smooth finger into your rectum, pushing into your ass with agonizing slowness, tiny thrusts in and out timed with her suckling from your teat.");
	//{Combine, next paragraph}
	outputText("\n\nUnder the latex girl's combined milking and sexual advances, you feel an orgasm rising deep in your gut.  You steel yourself, trying to hold out a moment longer as " + flags[kFLAGS.GOO_NAME] + " intensifies her assault, suckling every last drop from you as her fingers work wonders upon your ");
	if (player.gender == 3) outputText("double genitals");
	else if (player.hasCock()) outputText("cock");
	else if (player.hasVagina()) outputText("cunt");
	else outputText("asshole");
	outputText(".  You don't last long, and soon throw your head back and cum, ");
	if (player.gender > 0) outputText("smearing her fingers with a liberal spattering of your cum");
	else outputText("your [ass] clamping down hard as her finger milks you from behind");
	outputText(".  Suddenly, your teat pops free of her mouth, a streak of milk still spraying until " + flags[kFLAGS.GOO_NAME] + " is liberally coated with your white orgasmic offering, laughing girlishly as she licks her fingers and brings her own breast to her mouth, trying to tongue off the milk splattered on her.");
	outputText("\n\n\"<i>Delicious!</i>\" she says with a smile, plating a long kiss on your lips.  You return her grin and pull her close, nesting her face into your now-lighter bosom for a few short, restful minutes.");
	if (player.findPerk(PerkLib.Feeder) >= 0) {
		//You've now been milked, reset the timer for that
		player.addStatusValue(StatusEffects.Feeder,1,1);
		player.changeStatusValue(StatusEffects.Feeder,2,0);
	}
	player.boostLactation(.5);
	gooHappiness(5);
	gooObedience(3);
	temp = 15;
	if (player.lactationQ() >= 200) temp += 10;
	if (player.lactationQ() >= 500) temp += 10;
	if (player.lactationQ() >= 1000) temp += 10;
	if (player.lactationQ() >= 2000) temp += 10;
	if (player.lactationQ() >= 4000) temp += 10;
	if (player.lactationQ() >= 8000) temp += 10;
	gooFluid(temp);
	player.changeFatigue(5);
	player.orgasm();
	dynStats("sen", 2);
	doNext(camp.returnToCampUseOneHour);
	
}
}
}
