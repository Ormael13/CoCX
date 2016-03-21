package classes.Scenes.Areas.Desert {
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Items.Armors.LustyMaidensArmor;

	public class SandTrapScene extends BaseContent{
		private function get sandTrap():SandTrap{
			return monster as SandTrap;
		}

		public function SandTrapScene()
		{
		}

//const TIMES_ENCOUNTERED_SAND_TRAPS:int = 578;
// const SANDTRAP_NAGA_3SOME:int = 579;
//const SANDTRAP_LOSS_REPEATS:int = 812;


//Encounters (Z)
//First Encounter: (requires having met a Sand Witch)
public function encounterASandTarp():void {
	clearOutput();
	spriteSelect(97);
	if (flags[kFLAGS.SANDTRAP_LOSS_REPEATS] >= 2 && player.eyeType == EYES_BLACK_EYES_SAND_TRAP && player.wingType == WING_TYPE_GIANT_DRAGONFLY) {
		sandTrapBadEnd();
		return;
	}
	flags[kFLAGS.TIMES_ENCOUNTERED_SAND_TRAPS]++;
	if (flags[kFLAGS.TIMES_ENCOUNTERED_SAND_TRAPS] == 1) {
		//femininity <= 65: 
		if (player.femininity <= 65) {
			outputText("You are exploring the endlessly undulating landscape of the desert when you hear an agonized cry for help over the nearest dune.  You quickly scramble up it and are confronted by the sight of a small, flat lake of exceptionally fine sand, overlooked on each side by tall dunes.  Trapped in the middle of it is a young woman with black hair, up to her armpits in the sand.  \"<i>Oh, thank the Gods!</i>\" she cries, spotting you.  \"<i>I'm sinking, please help me!</i>\"  The word 'quicksand' flashes through your mind like fire and you take a nervous step back, attempting to quickly evaluate the situation.");
			if (player.inte > 65) outputText("  Something about this scene puts you on edge.  How come you've never encountered quicksand in this desert before, with no water and its steady, stubborn, but not violent winds?  There's something odd about the woman, too - although she can't be a sand witch with that hair, you can't quite make her features out clearly through the heat haze.");
			outputText("  You think you could just about reach her with your hand if you were careful.  If you're going to save her, it has to be now; even in the short time you've been here she has sunk down to her collarbone.  She stares at you with plaintive despair.");
		}
		else {
			outputText("You are exploring the endlessly undulating landscape of the desert when you hear an agonised cry for help over the nearest dune.  You quickly scramble up it and are confronted by the sight of a small, flat lake of exceptionally fine sand, overlooked on each side by tall dunes.  Trapped in the middle of it is a young man with black hair, up to his armpits in the sand.  \"<i>Oh, thank the Gods!</i>\" he cries, spotting you.  \"<i>I'm sinking, please help me!</i>\"  The word 'quicksand' flashes through your mind like fire and you take a nervous step back, attempting to quickly evaluate the situation.  ");
			if (player.inte > 65) outputText("Something about this scene puts you on edge.  How come you've never encountered quicksand in this desert before, with no water and its steady, stubborn, but not violent winds?  There's something odd about the man, too - although he probably isn't a demon, you can't quite make his features out clearly through the heat haze.  ");
			outputText("You think you could just about reach him with your hand if you were careful.  If you're going to save him, it has to be now; even in the short time you've been here he has sunk down to his collarbone.  He stares at you with plaintive despair.");
		}
		simpleChoices("Save", saveTheSandTarps, "Don't Save", dontSaveTheTarps, "", null, "", null, "", null);
	}
	else {
		//Standard encounter: 
		outputText("You are walking aimlessly through the desert when your [leg] sinks six inches into powdery sand.  The sound of hissing fills your ears as all around you sand cascades downwards into a conical depression.  A slender figure is emerging at the bottom... you desperately free your lower half and fight your way upwards, trying to stay ahead of the collapsing particulate.");
		if (player.spe/10 + rand(20) >= 16) {
			outputText("\n\nMoving as quickly and lightly as you can, you manage to hop clear of the sandtrap's pitfall and claw your way up a relatively stable dune.  You turn to take the androgynous creature in, half buried in its deep hollow.");
			outputText("\n\n\"<i>You've got quick feet, little ant!</i>\" it giggles.  It lowers its brow and leers up at you with smouldering black eyes, its hands slowly and sensuously trailing patterns in the sand.  \"<i>I bet you're good at lots of other things, too.  Why doesn't the brave little ant come down here and show me?</i>\"  If you're going to fight this creature, you will have to step into its treacherous hollow to get in range, which is surely its intention - if you try launching things at it from where you are, it will probably just hide itself.  On the other hand, it would be easy to just ignore its taunts and walk away.");
			//Fight]/[Leave]
			simpleChoices("Fight", startSandTarpFight, "", null, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
		}
		//Speed check fail: 
		else {
			outputText("\n\nYou don't move quickly enough, however, and you may as well be running on the spot; the edge of the pit recedes as the fluid sand carries you downwards.  You struggle upright as best you can and ready yourself to fight the sandtrap, which is leering at you hungrily from the bottom of its vast pit.");
			outputText("\n\n\"<i>Only a matter of time now, little ant,</i>\" it says huskily, in its fluttering, buzzing voice.  You will have to defeat it in order to escape, and before it pulls you to the bottom!");
			startCombat(new SandTrap());
			doNext(playerMenu);
		}
	}
}

//[Save]/[Don't Save]
//[Save]:
//go to fight after either save scene
//silly mode idea: return to camp and go directly to save menu, subsequent sandtrap encounters as per normal -Z
private function saveTheSandTarps():void {
	clearOutput();
	spriteSelect(97);
	//(femininity <= 65): 
	if (player.femininity <= 65) {
		outputText("You carefully kneel at the edge of the quicksand and stretch your hand out towards the stricken woman, commanding her to grab hold.   With effort she pulls an arm clear of the treacherous powder and, straining, reaches out to grab the very tips of your fingers... before, with a triumphant sneer, pulling as hard as she can.  Thrown off-balance, you fall face first into the quicksand.  Coughing, you right yourself and struggle desperately to get back up the side, but you have no leverage, and your thrashing causes you to sink waist deep into what feels like dry, impossibly heavy water.");
		outputText("\n\n\"<i>Don't struggle,</i>\" says the woman, drifting further away from you as easily as if she were swimming.  You can see a second collarbone flexing beneath her first as her arms rest easily upon the surface, a whole second pair of limbs doing the delicate balancing work, and she speaks in a buzzing, fluttering voice which is nothing like the one she enticed you into her trap with.  She smiles at you - or at least displays her teeth - and with a kind of horror you watch two sets of small, black eyes open on either side of her first pair to stare at you hungrily.  \"<i>Don't you know struggling just makes it worse?  Just relax.  Let me do all the work.</i>\"");
		outputText("\n\nA rumbling, hissing sound fills your ears and the dunes surrounding you lift out of sight as all the sand in the hollow begins to run downwards, taking you with it.  You fight against it desperately, but you cannot swim up a landslide and within moments you find yourself buried up to your neck at the bottom of a huge, conical depression, eyes level with the naked abdomen of your captor.  You cough, spit and blink sand away and stare helplessly up at it.  The creature has a long, slim human upper half with four arms and a pair of flat breasts; its twenty slender fingers stroke your face, brush you off and massage your [chest] as it allows you to take it in.  With its glamour gone you can see clearly the six eyed creature is in fact male... or is it?  Its long face is soft around the edges with a cute, pointed chin which is very pretty - or very handsome.  Every time the creature moves its face its gender seems to shift.  Unnerved, you look downwards, and wish you hadn't.  Although its lower half is obscured below the sand, you can see that below its waist the creature's body balloons outwards into what must be a massive, sand-colored insect thorax.  You feel something brush against you and you instinctively attempt to flinch, but you can't.  The sand feels packed against you, and straining every muscle you have to free your limbs gets you nowhere.  Gently, the creature slides its fingers behind your neck and makes you look into its black eyes.");
		outputText("\n\n\"<i>You made it all too easy for me, little ant,</i>\" it says pityingly.  \"<i>Did no one warn you about sandtraps?</i>\"  Slowly it sinks downwards, and whilst it fondles your face you feel its other set of hands cup your [butt].  \"<i>Never mind,</i>\" the insect monster sighs into your forehead in its fluttery voice.  \"<i>I'll teach you everything there is to know.</i>\"");
	}
	//(else fem > 65): 
	else {
		outputText("You carefully kneel at the edge of the quicksand and stretch your hand out towards the stricken man, commanding him to grab hold.   With effort he pulls an arm clear of the treacherous powder and, straining, reaches out to grab the very tips of your fingers... before, with a triumphant sneer, pulling as hard as he can.  Thrown off-balance, you fall face first into the quicksand.  Coughing, you right yourself and struggle desperately to get back up the side, but you have no leverage, and your thrashing causes you to sink waist deep into what feels like dry, impossibly heavy water.");
		outputText("\n\n\"<i>Don't struggle,</i>\" says the man, drifting further away from you as easily as if he were swimming.  You can see a second collarbone flexing beneath his first as his arms rest easily upon the surface, a whole second pair of limbs doing the delicate balancing work, and he speaks in a buzzing, fluttering voice which is nothing like the one he enticed you into his trap with.  He smiles at you - or at least displays his teeth - and with a kind of horror you watch two sets of small, black eyes open on either side of his first pair to stare at you hungrily.  \"<i>Don't you know struggling just makes it worse?  Just relax.  Let me do all the work.</i>\" ");
		outputText("\n\nA rumbling, hissing sound fills your ears and the dunes surrounding you lift out of sight as all the sand in the hollow begins to run downwards, taking you with it.  You fight against it desperately, but you cannot swim up a landslide and within moments you find yourself buried up to your neck at the bottom of a huge, conical depression, eyes level with the naked abdomen of your captor.  You cough, spit and blink sand away and stare helplessly up at it.  The creature has a long, slim human upper half with four arms and a pair of flat breasts; its twenty slender fingers stroke your face, brush you off and massage your [chest] as it allows you to take it in.  With its glamour gone you can see clearly the six eyed creature is in fact female... or is it?  Its long face is soft around the edges with a cute, pointed chin which is very pretty - or very handsome.  Every time the creature moves its face its gender seems to shift.  Unnerved, you look downwards, and wish you hadn't.  Although its lower half is obscured below the sand, you can see that below its waist the creature's body balloons outwards into what must be a massive, sand-colored insect thorax.  You feel something brush against you and you instinctively attempt to flinch, but you can't.  The sand feels packed against you, and straining every muscle you have to free your limbs gets you nowhere.  Gently, the creature slides its fingers behind your neck and makes you look into its black eyes.");
		outputText("\n\n\"<i>You made it all too easy for me, little ant,</i>\" it says pityingly.  \"<i>Did no one warn you about sandtraps?</i>\"  Slowly it sinks downwards, and whilst it fondles your face you feel its other set of hands cup your [butt].  \"<i>Never mind,</i>\" the insect monster sighs into your forehead in its fluttery voice.  \"<i>I'll teach you everything there is to know.</i>\"");
	}
	startCombat(new SandTrap());
	monster.changeStatusValue(StatusEffects.Level,1,2);
	doNext(playerMenu);
}

//[Don't Save]: 
private function dontSaveTheTarps():void {
	clearOutput();
	spriteSelect(97);
	outputText("You carefully step backwards from the quicksand, not taking your eyes off the stricken ");
	if (player.femininity <= 65) outputText("woman");
	else outputText("man");
	outputText(".  \"<i>Please!</i>\" ");
	if (player.femininity <= 65) outputText("she");
	else outputText("he");
	outputText(" cries, neck sinking into the drift.  \"<i>Don't let me die like this... oh, very well.  Have it YOUR way!</i>\"  The ");
	if (player.femininity <= 65) outputText("woman");
	else outputText("man"); 
	outputText(" suddenly thrusts upwards and plunges a fist into the fluid sand surrounding ");
	if (player.femininity <= 65) outputText("her");
	else outputText("him");
	outputText(".  The dune you are standing on caves inwards, turning into a shifting slide to the morass below you.  You stumble and hop backwards as fast as you can, managing to stay just ahead of the ");
	if (player.femininity <= 65) outputText("woman");
	else outputText("man");
	outputText("'s spell.  In front of you, sand collapses downwards into a great conical depression, at the epicentre of which is your supposed rescuee.  With ");
	if (player.femininity <= 65) outputText("her");
	else outputText("his");
	outputText(" midriff exposed and glamour gone, the creature looks quite different; six eyes as black as its hair look at you hungrily from its beautiful androgynous face, whilst four slender arms trail patterns in the sand around its willowy, flat-chested midsection.  It wriggles its body tauntingly at you, making the sand beneath it move ponderously.  You glimpse insect chitin beneath its flat humanoid belly; the buried half of this creature must be monstrous.");
	outputText("\n\n\"<i>You aren't as slow as you look, little ant,</i>\" it calls up to you, grinning slyly.  It speaks in a buzzing, fluttering voice which is nothing like the one it attempted to entice you into its trap with.  \"<i>Why don't you come down here and dance for me some more?  I'm sure a quick, strong traveller like you could run rings around a simple little sandtrap like me.</i>\"  If you're going to fight this creature, you will have to step into its treacherous hollow to get in range, which is surely its intention - if you try launching things at it from where you are, it will probably just hide itself.  On the other hand, it would be easy to just ignore its taunts and walk away.");
	//[Fight]/[Leave]
	simpleChoices("Fight", startSandTarpFight, "", null, "", null, "", null, "Leave", camp.returnToCampUseOneHour);
}


private function startSandTarpFight():void {
	startCombat(new SandTrap());
	playerMenu();
	spriteSelect(97);
}




public function sandtrapmentLoss(clear:Boolean = false):void {
	if (flags[kFLAGS.SFW_MODE] > 0) { //No rape in SFW mode.
		clearOutput();
		combat.cleanupAfterCombat();
		return;
	}
	if (flags[kFLAGS.SANDTRAP_LOSS_REPEATS] >= 2 && player.eyeType == EYES_BLACK_EYES_SAND_TRAP && player.wingType == WING_TYPE_GIANT_DRAGONFLY) {
		loseLastFightWithSandTrap();
		return;
	}
	flags[kFLAGS.SANDTRAP_LOSS_REPEATS]++;
	if (clear) clearOutput();
	else outputText("\n\n");
	spriteSelect(97);
	if (sandTrap.trapLevel() == 1) outputText("You are sunk to your belly in the depthless sand at the bottom of the pit, and are still falling fast.  The sun above you is blotted out by a shape which leans downwards towards you, smiling triumphantly.  Desperately, you try to keep your arms free so you can swing a blow at it, but with consummate ease, the sandtrap grabs your wrists with one set of hands while pushing you downwards with the others.  Within moments you are up to your armpits in the stuff, staring helplessly up at the strange androgynous creature which has you entirely at its mercy.");
	//PC lust loss: 
	else outputText("You feel as radiant and molten as the sun above you... you just want to sink into the warm sand surrounding you forever.  Why are you struggling against it again?  You can't remember; with a sigh, you fall backwards onto the soft powder and allow yourself to be carried right down to the bottom.  The sandtrap chuckles softly as it envelopes you in its waiting arms.  \"<i>Good " + player.mf("boy","girl") + "...</i>\"");
	
	if (player.hasCock()) doNext(dickwieldersLoseToSandTarps);
	else if (player.hasVagina()) doNext(chicksLoseToSandTarp);
	else doNext(genderlessLoss);
}

internal function pcBeatsATrap():void {
	clearOutput();
	spriteSelect(97);
	flags[kFLAGS.SANDTRAP_LOSS_REPEATS] = 0;
	//PC HP victory: 
	if (monster.HP < 1) outputText("The sandtrap groans and collapses forwards into the dirt.  With the creature no longer controlling it, the sand underneath you feels a great deal more stable... climbing out won't be too difficult.");
	//PC lust victory: 
	else outputText("The sand around you stops sinking.  Overpowered with lust, the sandtrap moans and gives up control over itself and its pit to desperately run one set of hands over its flat chest whilst the other pushes into the sand to masturbate... whatever it has down there.  With your foe in this state, climbing out won't be so difficult now.");
	
	var nagaThreeSome:Function = null;
	var putYourDickInIt:Function = null;
	var rideDatSantTrap:Function = null;
	var useSandTarpsHand:Function = null;
	var bikiniTits:Function = null;
	if (player.hasVagina() && player.biggestTitSize() >= 4 && player.armorName == "lusty maiden's armor") bikiniTits = createCallBackFunction2((player.armor as LustyMaidensArmor).lustyMaidenPaizuri,player,monster);
	//Requirements: Player is naga with tail and fangs, has met desert naga as naga at least once
	if (player.isNaga() && player.findStatusEffect(StatusEffects.Naga) >= 0 && player.gender > 0 && player.faceType == FACE_SNAKE_FANGS) nagaThreeSome = nagaThreesomeWithSandTrap;
	
	//Requires: Penis and str requirement
	if (player.hasCock() && player.str >= 60) putYourDickInIt = stickWangInSandgina;
	
	//\"<i>Ride</i>\" (Z)
	if (player.hasVagina()) rideDatSantTrap = rideDatSandTarpLikeIts1999;
	//\"<i>Hands</i>\" (Z)
	if (player.gender > 0) useSandTarpsHand = useSandTarpsHands;
	
	//additional victory sentence if PC lust over 30: 
	if (player.lust >= 33) {
		outputText("\n\nBefore you go, you take in the helpless body of your would-be ambusher.  What do you do?");
		
		choices("Naga3Some", nagaThreeSome, "UseYourCock", putYourDickInIt, "RideVaginal", rideDatSantTrap, "Handjob", useSandTarpsHand, "", null,
			"", null, "", null, "", null, "B.Titfuck", bikiniTits, "Leave", combat.cleanupAfterCombat);
	}
	else combat.cleanupAfterCombat();
}

//Male/Herm loss (Z)
private function dickwieldersLoseToSandTarps():void {
	clearOutput();
	spriteSelect(97);
	outputText("\"<i>You're probably wondering what part of you I want to use,</i>\" purrs the sandtrap, pushing itself further upwards using your shoulders and drawing you closer until your face is pressed against where its human torso and insect abdomen join.  You are helpless to ignore the fact it has a genital slit where its human cock would be, particularly as the sandtrap places its hands behind your head and proceeds to rub your face into it.  Its smooth, supple human flesh trades with its rough, leathery insect hide against your cheeks and forehead, and as its excitement grows you feel the slit slide open and something long, warm, and oily presses insistently into your face.  The creature pulls back momentarily, and with a feeling of deep trepidation you take it in... a black ten-inch insect prong, thicker at the base than its dull tip, dripping with a clear, viscous fluid.");
	outputText("\n\n\"<i>The ans-zwer is all of you-wve, my fris-zky little drone,</i>\" chatters the trap.  It seems the more excited it gets and the less it feels the need to pretend, the more fluttery and broken its voice becomes; it is like you are listening to a hive of bees that just happens to be forming words.  \"<i>I am going to usze you, inszide and out.  You'wwwe going to be both mommy and daddy for my children.  Iszn't that excithhhing?</i>\"  Smiling tenderly, it presses the tip of its gleaming black prong against your lips.  \"<i>Drink.  It will make thingsz so much easier for hwyou if hwyou do.</i>\"  The creature is not exactly giving you much choice.  Packed tightly inside its sand and incapable of resisting, you steel yourself, close your eyes, open your mouth and accept it.");
	
	outputText("\n\nThe cock prong slides into your mouth and past your teeth with ease, already dripping with its strange, clear lubicrant.  Sighing dreamily, the sandtrap slowly pushes half of its length into your mouth before pulling itself back out, then in again, picking up a gentle rhythm, each time pushing a bit more of itself into your mouth.  Soon it is stretching your lips wide as it takes you right to its thick base, its tip finding the back of your throat.  It groans and you feel your mouth fill with its oil; rather than ejaculate, the sandtrap's cock seems to perspire its odorless payload from all sides.  The stuff swabs and swathes your mouth in warmth; it makes your lips, the inside of your cheeks and your tongue feel relaxed, accepting and soft.  It feels like your mouth was made to take and enjoy this creature's cock... you begin to suckle the sandtrap eagerly, hoping for more.  Sighing at your greed, the creature pushes as much of itself as it can down your throat, leaking oil deliriously as it does.  Your lips stretched wide by the base of its prong, you can't help but dribble oil down your front even as you inadvertently swallow a great deal of its warm, coating ooze.");
	
	outputText("\n\nYou feel flutters spread throughout you, penetrating your core.  The rest of your body begins to feel just like your mouth; languid, sensual and submissive.  The sands encompassing you feel like the most comfortable straitjacket imaginable, and you close your eyes again as [eachCock] begins to harden.  It hazily occurs to you that the sensation of your cock hardening in the sand should irritate you, but in effect it doesn't; below you the substance feels more like packed mud, and the feeling of your length sliding through the yielding, enveloping dirt is incredibly pleasurable.  You actually smile dreamily around the prong stuffing your face when you feel something hot and wet press insistently against the tip of your " + player.cockDescript(0) + ".   The sand massages every inch of your body as below the surface the sandtrap begins to sink its insect cunt down your sensitive shaft.");
	//[Less than 6 inches:  
	if (player.cocks[0].cockLength < 6) outputText("\n\nThe creature looks down in surprise at you when its dripping, grasping sex reaches the base of your cock so quickly.  You feel a familiar sense of shame creeping across your cheeks... but the sandtrap uses the two hands grasping your head to stroke your brow and face with odd tenderness.  \"<i>Yyou do not like being all man, do you?  Perhaps little ant likes fooling mates with its looks, too.  Perhaps little ant is more like sandtrap than I thought.</i>\"  You look up at it, its prong still buried in your face, to see an odd look of hunger in its six eyes.  \"<i>Do not worry,</i>\" it says, smiling widely.  \"<i>Hyou are perfect to me.</i>\"  It begins to slowly work your small shaft, its pulsing muscles squeezing you possessively up and down.");
	//6 inches to 15: 
	else if (player.cocks[0].cockLength < 15) outputText("\n\nThe creature owns an incredibly tight sex which grasps you possessively once it is on you; it fits your cock like a glove.  The sandtrap sighs its fluttering sigh when it reaches your base and then slowly begins to work you, its punishing, pulsing muscles squeezing your cock up and down.");
	//More than 15 inches: 
	else outputText("\n\nThe creature owns an incredibly tight sex which grasp you possessively once it is on you.  Sweat beads the sandtrap's elegant brow as it forces itself brutally down your huge shaft; when it finally stops with a sizable portion of your " + player.cockDescript(0) + " inside it and draws back slightly, it feels like it is going to suck the cum right out of you.  It slowly begins to work what it can of you, its punishing, pulsing muscles squeezing your cock up and down.");
	
	outputText("\n\nThe sandtrap caresses your face tenderly as you suck its pseudo-cock while below the sand it assiduously begins to milk you.  You are pushed further into the hopelessly relaxed sex daze the creature's warm oil has instilled in you; it feels like the sand itself is moving with the creature, massaging your body in waves at the same gentle rhythm as the creature fucks your face and cock.  You can't keep track of time; there is only the sensation inundating your mouth, your body and " + player.cockDescript(0) + ", the sandtrap's gentle sighs, and the hiss and crunch of the sand itself.  Eventually the sandtrap begins to pick up the pace; it shoves your face into its groin as it begins to pant with need, stretching your mouth wide again as it begins to milk your cock as hard as it can.  Its vaginal muscles grip you tightly, rippling up and down your length; it feels like you are being fucked by a wet, grasping tube.  You can't possibly contain yourself against the creature which has sunk you into such glorious submission and, groaning around its prong, you spurt everything you can give into that clenching warmth.");
	//[High cum: 
	if (player.cumQ() > 1000) outputText("  The sandtrap gasps and coos as you ejaculate over and over again, and beneath you feel your cum wet the sands as it beads around the clenching grip it has you in.");
	if (player.hasVagina()) outputText("  Ignored entirely, your " + player.vaginaDescript(0) + " quivers and orgasms in tandem, flexing and wetting fruitlessly against the dry water pressing against it.");
	
	outputText("\n\nThe sandtrap finally releases you, humming and fluttering sounds of pleasure as it draws its unseen cunt away and retracts its prong from your mouth and back into its slit, trailing oil and saliva as it goes.  You don't really notice these things or even if it is trying to say anything to you in that bizarre voice it has, still deep within the encasing sand and deep within your muddling daze, and your limbs feel like any returning strength has been sucked right back out of you by the creature's milking cunt.  You do not struggle when the sandtrap takes you into its arms and begins to turn you around.  It fondles your [chest] with one hand as its others busily work at pulling your bottom half this way and that, until your [butt] is poked outwards in supplication.  Only then does it dozily occur to you that the creature is not done with you yet.");
	
	outputText("\n\n\"<i>You'hhve done well for me so farhh,</i>\" chuckles the sandtrap lowly, bending over you and threading one set of arms under your ");
	if (!player.isTaur()) outputText("armpits");
	else outputText("forelegs");
	outputText(".  You try and turn your head to see what it is doing but it gently but insistently pushes your face into the yielding sand.  \"<i>You arrrrhe a fine little drone.  I wwill thank you for yourrh hard work... with the fruits of ssame hard work.</i>\" What does it mean by...?");
	
	outputText("\n\nThe self-same tube which sucked away your cum pushes into your sphincter, sliding easily into your anal passage with its wet weight.  You arch your back and open your mouth... but the complete relaxation the sandtrap's oil has instilled in you stops your body from clenching against the invader, and you feel no pain.");
	player.buttChange(30,true,true,false);
	outputText("  The creature pushes your head down, making soothing shushing noises as it feeds more of its bulbous length into your ass.");
	if (player.analCapacity() < 40) outputText("  Although the oil which coats your thoughts and reflexes with sensual supplication makes things easier, the feeling is still incredibly intense, and you grit your teeth as something round travels down the creature's ovipositor and stretches your tight hole wide.");
	else outputText("  Your accommodating ass feels like it was made for this purpose, and with the creature's oil soothing your thoughts and reflexes you savor the creature taking you like this as if it were your quim.  You moan as something round travels down the creature's ovipositor and into your wet ass, the sensation making [eachCock] hard again.");
	
	outputText("\n\nThe sandtrap continues to make its soothing, humming sounds and caresses your [chest] and [hair] whilst it holds you firmly in its sandy grasp, sinking egg after egg into your [butt].  It is a process which seems to go on for minutes on end, and the sensation of having your ass bred like this starts to drive you inexorably towards another peak.  You groan as the slick pressure in your bowels makes you cum, your cock");
	if (player.hasVagina()) outputText(" and cunt");
	outputText(" flexing out more moisture into the sand beneath you.  The oil-induced serenity and the sexual marathon the sandtrap has put you through are too much and, even with the creature still relentlessly pumping away at you, you pass out.");
	
	outputText("\n\nYou awaken a while later, wearily getting to your feet and looking around.  You are standing in a featureless stretch of desert... there is no suggestion of the sandtrap, or indeed that you are in the same place where it caught you.  A fair amount of time has passed though, judging by the sky above you.  Perhaps it was all a particularly lucid mirage?  A sensation of... fullness in your abdomen suggests otherwise.  Clutching your bowels uneasily, you make your way back to camp.");
	monster.createStatusEffect(StatusEffects.Fertilized,0,0,0,0);
	sandTrapPregChance();
	player.orgasm();
	dynStats("lib", 1);
	player.slimeFeed();
	//reduce lust, increase lib, slimefeed, reset hours since cum
	combat.cleanupAfterCombat();
}

//Female loss (Z)
private function chicksLoseToSandTarp():void {
	clearOutput();
	spriteSelect(97);
	outputText("The sandtrap holds your hands whilst it pushes you further down with its other set of arms, until only your head is above the sand.  Below the surface you try to weakly move your limbs, try to work yourself out of this situation, but it is impossible; the sand feels impossibly heavy and is packed against you.  The sandtrap seems to have no such difficulty.  It sinks gracefully downwards until its face is almost level with yours.  You feel something wet touch your thigh and you try to flinch, but aside from flexing your muscles you cannot move.");
	outputText("\n\n\"<i>Hyou arrrhe a vessel creature, arrrhen't you?</i>\" says the sandtrap, gently stroking your face.  It seems the more excited it gets and the less it feels the need to pretend, the more fluttery and broken its voice becomes; it is like you are listening to a hive of bees that just happens to be forming words.");
	if (monster.findStatusEffect(StatusEffects.Fertilized) >= 0) outputText("  \"<i>A cute little wwworker hasz fallen into my home.  Wwwell, that isz ok.  Fortunately for hwyou, I already have some eggsz ready.  Hhyou will get to be a queen! Iszn't that exciting?</i>\"");
	else outputText("  \"<i>A cute little wwworker hasz fallen into my home, but I have no fertile eggsz to givve it.  Wwwell, that isz ok.  Hwwe can still have fun, can't we?</i>\"");
	
	outputText("\n\nIt makes a guttural noise, as if it were drawing fluids into its throat, and then draws you close.  \"<i>Drink.  It will make thingsz so much easier for hwyou if hwyou do.</i>\"  The creature is not exactly giving you much choice in the matter.  Packed tightly inside its sand and incapable of resisting, you steel yourself, close your eyes, and allow it to kiss you.");
	outputText("\n\nThe sandtrap's lips press against yours as it runs its hands through your [hair], before eagerly sliding its tongue into your mouth, finding and then lavishing your own with attention.  Your first thought is that the creature is an incredibly sloppy kisser - but as the fluid begins to coat your mouth, you realize that the fluid it is drooling into you isn't saliva, but some sort of odorless oil.  The viscous substance swabs and swathes your mouth in warmth; it makes your lips, the inside of your cheeks and your tongue feel relaxed, accepting and soft.  It feels like your mouth was made to take and enjoy this creature's tongue... you begin to kiss the sandtrap back eagerly, twining your tongues, hoping for more.  The creature hums happily at your greed, sending pleasurable vibrations through your mouth as it bends you into itself, kissing you deeply as it releases a great gush of oil into you.  You can't help but dribble oil down your front even as you inadvertently swallow a great deal of its warm, coating ooze.");
	outputText("\n\nYou feel flutters spread throughout you, penetrating your core.  The rest of your body begins to feel just like your mouth; languid, sensual and submissive.  The sands encompassing you feel like the most comfortable straitjacket imaginable, and you close your eyes again as your [vagina] moistens.  It hazily occurs to you that the sensation of your cunt being rubbed by the sand should irritate you, but in effect it doesn't; below you the substance acts more like packed mud, and the feeling of the dirt massaging against your most sensitive parts is incredibly pleasurable.  You actually smile dreamily as the creature takes you into its arms beneath the sand, its lean, supple chest rubbing against your [chest], and something hard and oily touches your [vagina].  The sands shift around your legs and you feel the endless particulate spreading your thighs wide; you have neither the strength nor the compulsion to fight against it.  You cling onto the sandtrap's back for support as it slowly slides into you.");
	player.cuntChange(30,true,true,false);
	outputText("\n\nYou have no idea what the sandtrap's cock looks like, but as it sinks into you, pushing half of its oiled length into your [vagina] before pulling itself back out, then in again, picking up a gentle rhythm, each time pushing a bit more of itself in, you quickly build up a good picture of it.  It must be at least ten inches long, and - it touches you deep in your wet sex, making you clutch the trap's supple flesh tighter for a second - it has a tapering dull point, much wider at the base than at the tip; less like a cock and more like a long barb.  ");
	if (player.vaginalCapacity() < 30) outputText("The creature sighs with pleasure, pressing you upon it as it begins to pick up the pace.  Whilst its narrow length feels great in your tight cunt, when it takes you to its base the feeling is incredibly intense, bordering on painful... your [vagina] isn't big enough.  Your mouth gapes open as you close your eyes, dreading each return thrust and yet longing for it, that sensation between pain and acute pleasure.");
	else outputText("  The creature sighs with pleasure, pressing you upon it as it begins to pick up the pace.  Although its tip sends darts of sensation up your spine, its narrow length cannot satisfy your vast cunt - that is, until it begins to take you to its wide base, spreading your outer lips wide.  You coo with delight and every time it thrusts you long for its peak, when it slides you wide open and plugs you fully with its dripping mass.");
	outputText("  The prong base rubs against your [clit] rhythmically and suddenly you find yourself orgasming in tandem with it, crying out as the creature groans and ejaculates its delicious ooze deliriously into you.");
	outputText("\n\nYou feel like you are leaking oil from every pore and you feel more relaxed than you have ever been before; you are just another million particles of warm sand, moving with it in the radiant heat freely.  It takes several moments for you to realize that the sandtrap has not retracted itself from you, and is still spearing you up to the hilt of its prong.  It smiles at you, affection glittering in its six black eyes as you feel something moist and hard push insistently against your sphincter.  What is...?  The creature kisses you again, pushing its tongue and hot breath into your mouth at the same time as it forces what feels like a long, lubricated, bulbous dick into your [butt].  You arch your back, but the complete relaxation the sandtrap's oil has instilled in you stops your body from clenching against the invader, and you feel no pain.");
	player.buttChange(30,true,true,false);
	outputText("\n\nThe creature makes soothing shushing noises into your mouth as it feeds more of its second, bulbous length into your ass.  ");
	if (player.analCapacity() < 30) outputText("Although the oil which coats your thoughts and reflexes with sensual supplication makes things easier, the feeling is still incredibly intense, and you grit your teeth as something round travels down the creature's ovipositor and stretches your tight ass wide.");
	else outputText("Your accommodating ass feels like it was made for this purpose, and with the creature's oil soothing your thoughts and reflexes you savor the creature taking you like this as if it were your second quim.  You moan as something round travels down the creature's ovipositor and into your wet ass.");
	outputText("  Slowly the creature begins to pick up its rhythm again, sliding in and out of your pussy as it breeds you.");
	outputText("\n\nThe sandtrap continues to make its soothing, humming sounds and caresses your [chest] and [hair] whilst holding you firmly in its sandy grasp as it fucks you, sinking egg after egg into your [butt].  It is a process which goes on for minutes on end.  The creature's prong and ovipositor rub against each through your inner walls and the sensation of being double penetrated like this drives you inexorably towards another peak.  You moan and your eyes roll as the slick pressure in your bowels makes you cum, both your gushing cunt and ass flexing helplessly against the creature's strange genitals.  The oil-induced serenity and the sexual marathon the sandtrap has put you through are too much and, even with the creature still relentlessly pumping away at you, you pass out.");
	outputText("\n\nYou awaken a while later, staggering to your feet and looking around.  You are standing in a featureless stretch of the desert... there is no suggestion of the sandtrap, or indeed that you are in the same place where it caught you.  A fair amount of time has passed though, judging by the sky above you.  Perhaps it was all a particularly lucid mirage?  A sensation of... fullness in your abdomen suggests otherwise.  Clutching your bowels uneasily, you make your way back to camp.");
	//buttpreg only if RNG decided trap was fertilized, reduce lust, increase lib, simefeed
	if (monster.findStatusEffect(StatusEffects.Fertilized) >= 0) sandTrapPregChance();
	player.orgasm();
	dynStats("lib", 1);
	player.slimeFeed();
	//reduce lust, increase lib, slimefeed, reset hours since cum
	combat.cleanupAfterCombat();
}

//Unsexed (Z)
private function genderlessLoss():void {
	clearOutput();
	spriteSelect(97);
	outputText("\n\nThe sandtrap holds your hands whilst it pushes you further down with its other set of arms, until only your head is above the sand.  Below the surface you try to weakly move your limbs, try to work yourself out of this situation but it is impossible; the sand feels impossibly heavy and is packed against you.  The sandtrap seems to have no such difficulty.  It towers above you, moving with sinuous grace.  You feel something wet touch your thigh and you try to flinch, but aside from flexing your muscles you cannot move.");
	outputText("\n\n\"<i>Hwhat a strange creature you arrrhe,</i>\" says the sandtrap, looking at you with vague bafflement as it gently strokes your face.  It seems the more excited it gets and the less it feels the need to pretend, the more fluttery and broken its voice becomes; it is like you are listening to a hive of bees that just happens to be forming words.  ");

	//(Trap has fertilised eggs: 
	if (monster.findStatusEffect(StatusEffects.Fertilized) >= 0) outputText("\"<i>Not a worker OR a drone! Wwwell, that isz ok.  Even ants who hhhave nothing can be someone for somebody.  And hhyou can be mommy for my childrrhen!</i>\"");
	else outputText("\"<i>Not a worker OR a drone! Wwwell, that isz ok.  Hwwe can still have fun, can't we?</i>\"");
	
	outputText("\n\nYou are helpless to ignore the fact it has a genital slit where its human cock would be, particularly as the sandtrap places its hands behind your head and proceeds to rub your face into it.  Its smooth, supple human flesh trades with its rough, leathery insect hide against your cheeks and forehead, and as its excitement grows you feel the slit slide open and something long, warm, and oily presses insistently into your face.  The creature pulls back momentarily, and with a feeling of deep trepidation you take it in... a black ten-inch insect cock prong, thicker at the base than its dull tip, dripping with a clear, viscous fluid.  Smiling tenderly, it presses the tip of its gleaming black prong against your lips.  \"<i>Drink.  It will make thingsz so much easier for hwyou if hwyou do.</i>\" The creature is not exactly giving you much choice in the matter.  Packed tightly inside its sand and incapable of resisting, you steel yourself, close your eyes, open your mouth and accept it.");
	
	outputText("\n\nThe cock prong slides into your mouth and past your teeth with ease, already dripping with its strange, clear lubicrant.  Sighing dreamily, the sandtrap slowly pushes half of its length into your mouth before pulling itself back out, then in again, picking up a gentle rhythm, each time pushing a bit more of itself into your mouth.  Soon it is stretching your lips wide as it takes you right to its thick base, its tip finding the back of your throat.  It groans and you feel your mouth fill with its oil; rather than ejaculate, the sandtrap's cock seems to perspire its odorless payload from all sides.  The stuff swabs and swathes your mouth in warmth; it makes your lips, the inside of your cheeks and your tongue feel relaxed, accepting and soft.  It feels like your mouth was made to take and enjoy this creature's cock... you begin to suckle the sandtrap eagerly, hoping for more.  Sighing at your greed, the creature pushes as much of itself as it can down your throat, leaking oil deliriously as it does.  Your lips stretched wide by the base of its prong, you can't help but dribble oil down your front even as you swallow as much of its warm, coating ooze as you can.");
	
	outputText("\n\nYou feel flutters spread throughout you, penetrating your core.  The rest of your body begins to feel just like your mouth; languid, sensual and submissive.  The sands encompassing you feel like the most comfortable straitjacket imaginable, and you close your eyes to bask in the radiant hormone glow.  It is as you are doing this that something moist and hard pushes insistently against your sphincter.  What is...?  The sandtrap reaches down to kiss you forcefully, pushing its tongue and hot breath into your mouth at the same time as it forces what feels like a long, lubricated, bulbous dick into your [butt].  You arch your back, but the complete relaxation the sandtrap's oil has instilled in you stops your body from clenching against the invader, and you feel no pain.");
	player.buttChange(30,true,true,false);
	outputText("\n\nThe creature makes soothing shushing noises into your mouth and feeds more of its bulbous length into your ass.  ");
	if (player.analCapacity() < 30) outputText("Although the oil which coats your thoughts and reflexes with sensual supplication makes things easier, the feeling is still incredibly intense, and you grit your teeth as something round travels down the creature's ovipositor and stretches your tight ass wide.");
	else outputText("Your accommodating ass feels like it was made for this purpose, and with the creature's oil soothing your thoughts and reflexes you savor the creature taking your [asshole] like this as if it were a quim.  You moan as something round travels down the creature's ovipositor and into your wet ass.");
	outputText("  Slowly the creature begins to pick up its rhythm again, sliding in and out of your butt as it breeds you.");
	
	outputText("\n\nThe sandtrap continues to make its soothing, humming sounds and caresses your [chest] and [hair] whilst it holds you firmly in its sandy grasp as it fucks you, sinking egg after egg into your [butt].  It is a process which seems to go on for minutes on end.  The creature's ovipositor rubbing you like this drives you inexorably towards your peak.  You moan and your eyes roll as the slick pressure in your bowels makes you cum, your ass flexing helplessly against the creature's strange genitals.  The oil-induced serenity and the sexual marathon the sandtrap has put you through are too much and, even with the creature still relentlessly pumping away at you, you pass out.");
	
	outputText("\n\nYou awaken a while later, wearily staggering to your feet and looking around.  You are standing in a featureless stretch of desert... there is no suggestion of the sandtrap, or indeed that you are in the same place where it caught you.  A fair amount of time has passed though, judging by the sky above you.  Perhaps it was all a particularly lucid mirage?  A sensation of... fullness in your abdomen suggests otherwise.  Clutching your bowels uneasily, you make your way back to camp.");
	//butteggpreg only if RNG has trap with fertilized eggs, reduce lust, increase lib, slimefeed
	sandTrapPregChance();
	
	player.orgasm();
	dynStats("lib", 1);
	player.slimeFeed();
	//reduce lust, increase lib, slimefeed, reset hours since cum
	combat.cleanupAfterCombat();
}

private function sandTrapPregChance():void {
	//Only happens if PC aint already buttpregged
	if (monster.findStatusEffect(StatusEffects.Fertilized) >= 0)
		player.buttKnockUp(PregnancyStore.PREGNANCY_SANDTRAP_FERTILE, PregnancyStore.INCUBATION_SANDTRAP, 1, 1);
	else
		player.buttKnockUp(PregnancyStore.PREGNANCY_SANDTRAP, PregnancyStore.INCUBATION_SANDTRAP, 1, 1);
}

public function birfSandTarps():void {
	spriteSelect(97);
	outputText("\nYour eyes widen as a gout of oil suddenly gushes from your ass.  Before panic can set in, an incredible light-headedness overtakes you.  Dreamily, you discard your [armor] and squat.  More oil oozes out of you, and in your hazy euphoria, you scoop some of it up and rub it dreamily into your " + player.nippleDescript(0) + "s.  Part of you is disgusted at yourself, questioning what you are doing, but that is one voice in a million-strong chorus crooning you into total relaxation... the oil clings to your skin and seems to radiate warmth and softness.  Something round stretches your rectum wide, but in your state the sensation is practically orgasmic.");
	//[Male: 
	if (player.gender == 1) {
		outputText("  You roll your eyes to the sky and moan, [eachCock] growing hard as you push out the egg.");
		//[(mans and qualified horses only)]
		if (!player.isTaur() || (player.tallness * (5/6) < player.cocks[player.longestCock()].cockLength)) outputText("  Your oily hands descend upon your cock, and you massage your shaft as you feel the pressure in your bowels intensify again.");
	}
	//Female: 
	else if (player.gender == 2) {
		outputText("  You roll your eyes to the sky and moan, your " + player.vaginaDescript(0) + " moistening as you push out the egg.");
		//[(no fukken horses from here)]
		if (!player.isTaur()) outputText("  Your oily hands push softly into your cleft, fingering your needy " + player.clitDescript() + " as you feel the pressure in your bowels intensify again.");
	}
	//Herm: 
	else if (player.gender == 3) {
		outputText("  You roll your eyes to the sky and moan, [eachCock] growing hard and your [vagina] moistening as you push out the egg.");
		//[(no horses)]
		if (!player.isTaur()) outputText("  Your oily hands descend upon your genitals and you begin to slowly pump your shaft and finger your needy " + player.clitDescript() + " as you feel the pressure in your bowels intensify again.");
	}
	outputText("\n\nYou nearly cum as egg number two squeezes out.  You DO cum when egg number three stretches you wide, blowing your mind into the empty sky.  Each egg seems to come out closer on the heels of the one before, and each time your conscious mind loses more of its ability to do anything but wallow in oil and pleasure.");
	
	outputText("\n\nYou are brought to your senses by something flitting past your eyes.  You wearily brush your face and pick yourself up.  Behind you, leaking and lying in a translucent ooze, is a multitude of black, oily eggshells.  Of more note are the pale blurs which keep zipping past your head.  They look rather like the fairies which inhabit the forest, except they have six black eyes, are flat-chested and are male... no, female...?  No, male... you can't tell.  They are lithe and beautiful and have tiny, undeveloped insect abdomens hanging above their trim butts and below their dragonfly wings.  They whirr in place for a moment before keeling around and about each other excitedly like hoverflies, chattering to each other in a tongue so fast it is beyond your comprehension.");
	
	//Libido <30:
	if (player.lib < 33) outputText("\n\nYou pick yourself up wearily, flap the flytraps you have birthed away and make your way back to camp.  This whole experience has been deeply unnerving, and you vow to make sure you don't have to repeat it.");
	//Libido 30-65: 
	else if (player.lib < 66) outputText("\n\nYou spend a moment enjoying your post-natal haze, then haul yourself out of it, flap the flytraps you have birthed away, and make your way back to camp.  Though this experience has been deeply unnerving, you can't help but acknowledge it has also been incredibly erotic.");
	//Libido >65: 
	else outputText("\n\nYou smile lazily, then lie back and glory in the sensual haze the oil has left you in.  After you have spent many minutes lying listening to the happy twittering of your flytrap children above you, you reluctantly get up.  You only hope that you get to experience the unearthly wonder of birthing these strange creatures again, and again, and again.");
	player.buttChange(25,true,true,false);
	outputText("\n");
	player.orgasm();
	dynStats("lib", 1, "sen", 4);
}

//\"<i>Hands</i>\" (Z)
//Requires: Genitals
private function useSandTarpsHands():void {
	clearOutput();
	spriteSelect(97);
	outputText("You bend into the sand and allow the slope to slowly carry you down to the bottom and the defeated sandtrap.  Its six eyes regard you with a mixture of lust and resentment, and as the soft powder delivers you to its side it tries to curl one pair of its hands around your thighs.  Whether this is one last attempt to drag you down or because it is trying to curry your favor somehow you don't know, but you aren't having any of it.  You catch its hands, easily overpowering it.  The monster uses its other pair of hands to try to pathetically prise itself out of your grasp; you find that its wrists are thin enough for you to reach your hands around both and hold all four of its arms quite comfortably.  You beam triumphantly at the helpless sandtrap, who glowers in response, then take a moment to look your strange conquest over.  Even up close you can't tell from its thin, fey beauty whether it is male or female.  Although it is affecting to look angry at you, its sculpted cheeks are quite flushed and there is a definite undercurrent of desire in its eyes; you suspect your display of strength and dominance appeals to it on some perverse, animalistic level.  Although its hidden insect half shifts around threateningly beneath the sand, you know that you must be holding the only usable limbs it has because it has made no attempt to move away from or kick out at you.  You look at its hands speculatively.  They are like its frame in miniature; long, slender, yet obviously nimble.  You smile again and then, looking into its face, force its hands downwards.  It tries to resist at first but it no longer has the strength, and you easily compel its quartet of hands to move where you want them to.  You make them touch your [armor], and then, moving downwards and inwards, your thigh, this time on your own terms.");
	
	outputText("\n\n\"<i>What's the matter, sand slut?</i>\" you ask softly.  \"<i>I thought this is what you wanted.</i>\"  It doesn't reply; it simply looks at you with that simmering mixture of indignation and lust.  You gently press its hands into your flesh and then release them.  \"<i>Service me,</i>\" you demand, simply.  It stares at you for a moment longer.");
	
	outputText("\n\n\"<i>Yes... lion,</i>\" it says at last, and begins to move its hands of its own accord.");
	//Male: 
	if (player.gender == 1) {

		outputText("\n\nOne pair of the creature's hands slowly brush up your inner thighs whilst the other two feel around your [armor], clumsily loosening clasps and belts as it finds them.  One hand locates [oneCock] and, after pausing for a split second, slides its fingers around your shaft and begins to slowly rub up and down.  You sigh as you quickly harden in the creature's smooth, dry, enveloping grasp.  You look into the sandtrap's face as it works; blushing, it looks down from your gaze and concentrates upon what it is doing.  It begins to pump you faster and you hiss slightly at the abrasion this causes.  The sandtrap makes a throaty sound.  Curiously you look down in time to see it bring its other pair of hands up to its mouth and deposit a great dollop of clear ooze into its cupped palms.  Your disgust turns to delight as it swaps its hands and begins to massage its oil into your length, the warm lubricant allowing the creatures' fingers to glide around your shaft and head like they were made of silk.  Tentatively the creature uses its other hands to cup your [butt] and really gets to work on you.");
		//Cock less than 6 inches: 
		if (player.cocks[0].cockLength < 6) {
			// balls:
			if (player.balls == 0) outputText("\n\nThe sandtrap only needs one hand to pump your diminutive cock; it barely moves its wrist as it jerks you, occasionally wriggling its oily fingers along the bottom of your " + player.cockDescript(0) + " to stimulate you even further.");
			else outputText("\n\nThe sandtrap only needs one hand to pump your diminutive cock; it barely moves its wrist as it jerks you, occasionally wriggling its oily fingers along the bottom of your " + player.cockDescript(0) + " to incite you even further, whilst it uses its free hand to gently cup your [balls].");
			outputText("  Your small size doesn't seem to bother it; if anything, judging from the red rising in its thin cheeks and its shortening breath, the girliness of your cock actually seems to excite it.  It pauses and, whilst you are both panting lightly, it slowly and gently circles your head with its index finger whilst it still holds the entirety of your cock with the rest of its hand.");
		}
		//Cock 6-16 inches: 
		else if (player.cocks[0].cockLength < 16) {
			//[no balls:
			if (player.balls == 0) outputText("\n\nThe sandtrap glides its hand up and down your " + player.cockDescript(0) + ", picking up a warm smooth rhythm.");
			//Balls:
			else outputText("\n\nThe sandtrap glides its hand up and down your " + player.cockDescript(0) + ", picking up a warm smooth rhythm as it gently cups your [balls] with its free hand.]  It slows down intermittently to move its palm around your length, letting every inch of your dick feel the tips of its delicate fingers.");
		}
		//Cock more than 16 inches: 
		else outputText("\n\nThe sandtrap quickly comes to the realisation it needs both hands for this.  Still cupping your behind, it moves one oily hand up the top end of your massive shaft, while the other works the other half.  You sigh with deep satisfaction, enjoying the all-too-rare sensation of having every inch of your " + player.cockDescript(0) + " immersed in pleasure.  The creature screws its face up and looks away in distaste at the size of your straining dick, which is in danger of poking it in the nose.  As you enjoy the warm, slippery sensation inundating you, you find you couldn't care less what it thinks.");
		//number of cock fork
		//One cock: 
		if (player.cockTotal() == 1) {
			outputText("  The sandtrap pumps you faster and faster until its slippery hands are a blur of motion.  It clutches onto your butt cheeks so tightly you hazily realize the indents of its slender digits will be with you for hours afterwards.");
			outputText("\n\nThe warm, oily double sensation is unbearably good and although you try to hold on to savor it as long as possible, it isn't long before you reach a toe-curling peak and, with a wordless bark, spurt out line after line of jizz.  The trap flinches slightly when your first cumshots hit it in the face and chest, but then goes back to gently rubbing you, guiding you up and down your warm, slippery orgasm.");
		}
		//Two cocks: 
		else if (player.cockTotal() == 2) {
			outputText("  As the sandtrap begins to pump you faster, your disregarded " + player.cockDescript(1) + " bobs in hard, eager concert with your " + player.cockDescript(0) + ".  You gasp as the trap slows down momentarily to grasp your second sex.  It is clumsy at first as it moves its lubricated palms in tandem, then with increasing confidence as it finds a position and rhythm that suits it, until it is jerking you off furiously, clutching your butt cheeks so tightly you hazily realize the indents of its slender digits will be with you for hours afterwards.");
			outputText("\n\nThe warm, oily double sensation is unbearably good and although you try to hold on to savor it as long as possible, it isn't long before you reach a toe-curling peak and, with a wordless bark, spurt out line after line of jizz.  The trap flinches slightly when your first cumshots hit it in the face and chest, but then goes back to gently rubbing you, guiding you up and down your warm, slippery orgasm.");
		}
		//Three cocks: 
		else if (player.cockTotal() == 3) {
			outputText("\n\nAs the sandtrap begins to pump you faster, your two other, disregarded cocks bob in hard, eager concert with your " + player.cockDescript(0) + ".  You gasp as the trap slows down momentarily to reach one of its hands down to grasp your second sex, and then stops entirely as  one of its hands clutching your ass releases and snakes back around to take hold of your " + player.cockDescript(2) + ".  It is clumsy at first as it works its way around the rather complex arrangement you have down below, but it moves its lubricated palms with increasing confidence, until it is jerking all three of your cocks in rhythm.");
			if (player.balls > 0) outputText("  It grins up at you shyly and, with its final hand, cups your [balls].  ]You laugh with an almost hysterical edge to the sky at how mindboggling getting a triple handjob feels, and the trap giggles slightly as well despite itself.");
			outputText("\n\nThe warm, oily tripled sensation is unbearably good and although you try to hold on to savor it as long as possible, it isn't long before you reach a toe-curling peak and, with a wordless bark, spurt out line after line of jizz.  The trap flinches slightly when your first shots hit it in the face and chest, but then goes back to gently rubbing you, guiding you up and down your warm, slippery multiple orgasm.");
		}
		//Four cocks: 
		else if (player.cockTotal() == 4) {
			outputText("\n\nAs the sandtrap begins to pump you faster, your three other, disregarded cocks bob in hard, eager concert with your " + player.cockDescript(0) + ".  You gasp as the trap slows down momentarily to reach one of its hands down to grasp your second sex, and then stops entirely as both of its hands clutching your ass release and snake back around to take hold of your " + player.cockDescript(2) + " and " + player.cockDescript(3) + ".  It is clumsy at first as it works its way around the rather complex arrangement you have down below, but it moves its lubricated palms with increasing confidence, until it is jerking all four of your cocks in rhythm.  You laugh into the sky with an almost hysterical edge at how mindbogglingly good getting a quadruple handjob feels; it glances up at you and giggles shyly as you look into each other's eyes and share a thought.  \"<i>At last, I've found somebody who complements my body perfectly.</i>");
			outputText("\n\nThe warm, oily quadrupled sensation is unbearably good and although you try to hold on to savor it as long as possible, it isn't long before you reach a toe-curling peak and, with a wordless bark, spurt out line after line of jizz.  The trap flinches slightly when your first cumshots hit it in the face and chest, but then goes back to gently rubbing you, guiding you up and down your warm, slippery multiple orgasm as you spurt like a cum sprinkler in front of it.");
		}
		//More than four cocks: 
		else {
			outputText("\n\nAs the sandtrap begins to pump you faster, your many other, disregarded cocks bob in hard, eager concert with your " + player.cockDescript(0) + ".  You gasp as the trap slows down momentarily to reach one of its hands down to grasp your second sex, and then stops entirely as its two hands clutching your ass snake back around to take hold of your " + player.cockDescript(2) + " and " + player.cockDescript(3) + ".  It is clumsy at first as it works its way around the incredibly complex arrangement you have down below, but it moves its lubricated palms with increasing confidence, until it is jerking four of your cocks in rhythm.  You laugh into the sky with an almost hysterical edge at how mindbogglingly good getting a quadruple handjob feels, and the trap giggles slightly as well despite itself.  Hazily you wonder if it is too much to wish that this creature, with its excellent wrist action, had just one or two more hands to its name.");
			outputText("\n\nThe warm, oily quadrupled sensation is unbearably good and although you try to hold on to savor it as long as possible, it isn't long before you reach a toe-curling peak and, with a wordless bark, spurt out line after line of jizz.  The trap flinches slightly when your first shots hit it in the face and chest, but then goes back to gently rubbing you, guiding you up and down your warm, slippery multiple orgasm as you spurt like a cum sprinkler in front of it.");
		}
	}
	//Female: 
	else if (player.gender == 2) {
		outputText("\n\nOne pair of the creature's hands slowly brush up your inner thighs while the other two feel around your [armor], clumsily loosening clasps and belts as it finds them.  One hand locates your [vagina] and, after pausing for a split second, slides its fingers into your moistness.  It is clumsy at first, evidently unfamiliar with your anatomy and you hiss slightly as it rubs your [clit] with its dry thumb.  At this, the sandtrap makes a throaty sound.  Curiously you look down in time to see it bring its other pair of hands up to its mouth and deposit a great dollop of clear ooze into its cupped palms.  Your disgust turns to delight as it swaps its hands and begins to slowly probe you with its lubricated digits; they glide over your lips and labia as if they were entirely frictionless.   Tentatively the creature uses its other pair of hands to cup your [butt] and bends into its work.  You sigh and begin to lose yourself in the wet, silky sensation.");
		outputText("\n\nThe creature's fingers move all around your sex, gently stroking and testing every fold and furl that it finds; it seems curious more than anything about what you have presented it with.  You glance at it in baffled amusement and, blushing, it looks down and sets about you with purpose.  It strokes your [clit] again and you gasp slightly; evidently knowing a good thing when it hears it, the sandtrap gently circles the base of your clit with its index finger whilst it gently probes your wet tunnel with its pinky.  It withdraws and you thrust yourself forward needily, not wanting to lose the heat it has begun to stoke.  Still cupping your butt with its other hands, the sandtrap slips three fingers of its free hand up your vagina as it continues to slowly caress your bud with its fourth.  You groan as your juices thicken at the gentle yet insistent pressure inundating your bottom half from all sides.");
		outputText("\n\nThe sandtrap is a fast learner.  After stroking and probing your dripping tunnel for a bit the creature makes you gasp again as it curls one of its long, slender digits and finds your G-spot.  The trap begins to finger your most sensitive point with a vengeance, curling its fingers and stroking outwards in a come-hither gesture.  Coupled with the attention it is lavishing on your clit, the sensation is eye-crossingly good and you begin to grunt and moan with need, thrusting your sex into its hands, coating them with your own lubricant.");
		if (player.tone < 60) outputText("  It picks up the pace gradually and soon it is doubly frigging you as fast as its fingers will allow, its other hands sinking deep into your soft, pillowy behind as it clutches onto you.");
		else outputText("  It picks up the pace gradually and soon it is doubly frigging you as fast as its fingers will allow, its other hands clutching onto your tight, muscled behind so tightly you hazily realize the indents of its slender digits will be with you for hours afterwards.");
		outputText("\n\nYou grab the sandtrap's black hair and cum with startling force, gushing fluid onto the trap and the sand beneath you as your cunt flexes around its fingers, which continue to curl and flick to send spasms of ecstatic pleasure up your spine.");
	}
	//Herm: 
	else if (player.gender == 3) {
		outputText("\n\nOne pair of the creature's hands slowly brush up your inner thighs whilst the other two feel around your \"<i>armor</i>\", clumsily loosening clasps and belts as it finds them.  One hand finds your " + player.cockDescript(0) + " and, after pausing for a split second, slides its fingers around your shaft and begins to slowly rub up and down.  You sigh as you quickly harden in the creature's smooth, dry, enveloping grasp.  You look into the sandtrap's face as it works; blushing, it looks down from your gaze and concentrates upon what it is doing.  It begins to pump you faster and you hiss slightly at the abrasion this causes.  At this the sandtrap makes a throaty sound.  Curiously you look down in time to see it bring its other pair of hands up to its mouth and deposit a great dollop of clear ooze into its cupped palms.  Your disgust turns to delight as it swaps its hands and begins to massage its oil into your length, the warm lubricant allowing the creatures' fingers to glide around your shaft and head like they were made of silk.  As it moves its first hand up and down, it tentatively moves its second further between your legs.  It finds your [vagina] and, after pausing for a split second, slides its slender fingers into your moistness.  Although it is clumsy at first, the oil which coats its digits make them glide over your shaft and labia as if they were entirely frictionless.  It quickly gains confidence and begins to gently frig you as it slides its warm, slippery grasp up and down your " + player.cockDescript(0) + ", circling your [clit] whilst occasionally dipping into your dripping hole.  You sigh and begin to lose yourself in the wet, silky sensation.");
		//Cock less than 6 inches:  
		if (player.cocks[0].cockLength < 6) {
			//[no balls: 
			if (player.balls == 0) outputText("\n\nThe sandtrap only needs one hand to pump your diminutive cock; it barely moves its wrist as it jerks you, occasionally wriggling its oily fingers along the bottom of your " + player.cockDescript(0) + " to stimulate you even further.");
			else outputText("\n\nThe sandtrap only needs one hand to pump your diminutive cock; it barely moves its wrist as it jerks you, occasionally wriggling its oily fingers along the bottom of your " + player.cockDescript(0) + " to incite you even further, whilst it uses its free hand to gently cup your [balls].");
			outputText("  Your small size doesn't seem to bother it; if anything, judging from the red rising in its thin cheeks and its shortening breath, the girliness of your cock actually seems to excite it.  It pauses and, while you are both panting lightly, it slowly and gently circles your head with its index finger, still holding the entirety of your cock with the rest of its hand.");
		}
		//Cock 6-16 inches: 
		else if (player.cocks[0].cockLength < 16) {
			if (player.balls == 0) outputText("\n\nThe sandtrap glides its hand up and down your " + player.cockDescript(0) + ", picking up a warm smooth rhythm.");
			else outputText("\n\nThe sandtrap glides its hand up and down your " + player.cockDescript(0) + ", picking up a warm smooth rhythm as it gently cups your [balls] with its free hand.]  It slows down intermittently to move its fingers around your length, letting every inch of your dick feel the tips of its delicate fingers.");
		}
		else {
			outputText("\n\nThe sandtrap quickly comes to the realisation it needs both hands for this.  Still cupping your behind, it moves one oily hand up the top end of your massive shaft, whilst the other works the other half.  You sigh with deep satisfaction, enjoying the all-too-rare sensation of having every inch of your " + player.cockDescript(0) + " immersed in pleasure.  The creature screws its face up and looks away in distaste at the size of your straining dick, which is in danger of poking it in the nose.  As you enjoy the warm, slippery sensation inundating you, you find you couldn't care less what it thinks.");
		}
		//One cock: 
		if (player.cockTotal() == 1) {
			outputText("\n\nThe sandtrap pumps you faster and faster until its slippery hands are a blur of motion, lavishing attention upon your clit and pussy, eventually pumping and flicking in furious rhythm.  It clutches onto your butt cheeks so tightly you hazily realize the indents of its slender digits will be with you for hours afterwards.");
			outputText("\n\nThe warm, oily double sensation is unbearably good and although you try to hold on to savor it as long as possible, it isn't long before you reach a toe-curling peak and, with a harsh moan, spurt out line after line of jizz whilst gushing femcum coat its hands and your thighs.  The trap flinches slightly when your first shots hit it in the face and chest, but then goes back to gently rubbing and frigging you as you ride your glorious orgasms out.");
		}
		//Two cocks: 
		else if (player.cockTotal() == 2) {
			outputText("\n\nAs the sandtrap begins to pump you faster, your disregarded " + player.cockDescript(1) + " bobs in eager concert with your " + player.cockDescript(0) + ".  You gasp as the trap slows down momentarily to reach one of the hands gripping your ass back around to grasp your second manhood.  It is clumsy at first as it moves its lubricated palms in tandem, then with increasing confidence as it finds a position and rhythm that suits it, it is jerking and flicking you off furiously, clutching your butt cheek with its final hand for what seems like dear life.");
			outputText("\n\nThe warm, oily triple sensation is unbearably good and although you try to hold on to savor it as long as possible, it isn't long before you reach a toe-curling peak and, with a harsh moan, spurt out line after line of jizz whilst gushing femcum coat its hands and your thighs.  The trap flinches slightly when your first shots hit it in the face and chest, but then goes back to gently rubbing and frigging you as you ride your glorious orgasms out.");
		}
		//hree cocks: 
		else if (player.cockTotal() == 3) {
			outputText("\n\nAs the sandtrap begins to pump you faster, your two other, disregarded cocks bob in eager concert with your " + player.cockDescript(0) + ".  You gasp as the trap slows down momentarily to reach both hands clutching your ass back around to take hold of your " + player.cockDescript(1) + " and " + player.cockDescript(2) + ".  It is clumsy at first as it works its way around the rather complex arrangement you have down below, but it moves its lubricated palms with increasing confidence, until it is jerking three of your cocks whilst fingering you in rhythm.  You laugh into the sky with an almost hysterical edge at how mindbogglingly good getting a quadruple handjob feels; it glances up at you and giggles shyly as you look into each other's eyes and share a thought.  At last, I've found somebody who compliments my body perfectly.");
			outputText("\n\nThe warm, oily sensation is unbearably good and although you try to hold on to savor it as long as possible, it isn't long before you reach a toe-curling peak and, with a harsh moan, spurt out line after line of jizz whilst gushing femcum coat its hands and your thighs.  The trap flinches slightly when your first shots hit it in the face and chest, but then goes back to gently rubbing you as you ride your glorious orgasms out, spurting like a cum sprinkler in front of it.");
		}
		//More than three cocks: 
		else {
			outputText("\n\nAs the sandtrap begins to pump you faster, your many other, disregarded cocks begin to harden in eager concert with your " + player.cockDescript(0) + ".  You gasp as the trap slows down momentarily to reach both of its hands clutching your ass back around to take hold of your " + player.cockDescript(1) + " and " + player.cockDescript(2) + ".  It is clumsy at first as it works its way around the rather complex arrangement you have down below, but it moves its lubricated palms with increasing confidence, until it is jerking three of your cocks whilst fingering you in rhythm.  You laugh into the sky with an almost hysterical edge at how mindbogglingly good getting a quadruple handjob feels, and the trap giggles slightly as well despite itself.  Hazily you wonder if it is too much to wish that this creature, with its excellent wrist action, had just one or two more hands to its name.");
			outputText("\n\nThe warm, oily quadrupled sensation is unbearably good and although you try to hold on to savor it as long as possible, it isn't long before you reach a toe-curling peak and, with a harsh moan, spurt out line after line of jizz whilst gushing femcum coat its hands and your thighs.  The trap flinches slightly when your first shots hit it in the face and chest, but then goes back to gently rubbing you as you ride your glorious orgasm out, spurting like a cum sprinkler in front of it.");
		}
	}
	//All sexes go to: 
	outputText("\n\nYou sigh with immense satisfaction and step back from the sandtrap.  Taking into account what an excellent job it did you opt not to rub its face in what you have made it do, particularly as you have managed to get quite a bit of your fluids on it anyway.  It watches you, still flushed and mouth slightly ajar, as you leisurely pull your [armor] back on.");
	outputText("\n\n\"<i>Please, lion,</i>\" it manages eventually.  You look at the strange, half-buried creature and notice that spots of fluid are darkening the sand around it; it is evidently perversely turned on by your domineering actions, and you have left it in no way satiated.  You curl your lip into an evil smirk.");
	outputText("\n\n\"<i>Not today, I think,</i>\" you say over your shoulder, as you clamber out of its pit.  \"<i>I think you'll have to try a bit harder if you want to get what you want from this lion.</i>\"  Your smile broadens as a deeply frustrated moan reaches your ears from behind you...");
	player.orgasm();
	dynStats("sen", -1);
	combat.cleanupAfterCombat();
}


//\"<i>Ride</i>\" (Z)
private function rideDatSandTarpLikeIts1999():void {
	clearOutput();
	spriteSelect(97);
	//Requirement: Vagina
	outputText("You bend into the sand and allow the slope to slowly carry you down to the bottom and the defeated sandtrap.  Its six black eyes regard you with a mixture of lust and resentment as you slowly discard your [armor], reveling in the hot desert sun upon your naked " + player.skin() + ".  As the soft sand delivers you to its side, it tries to curl its hands around your thighs.  Whether this is one last attempt to drag you down or because it is trying to curry your favor somehow you don't know, but you aren't having any of it.  You catch its hands, easily overpowering it.  It uses its other pair to try to pathetically prise itself out of your grasp; you find that its wrists are thin enough for you to reach your hands around both and hold all four of its arms quite comfortably.  You beam triumphantly at the helpless sandtrap, who glowers in response.  You take a moment to look your strange conquest over.  Even up close you can't tell from its thin, fey beauty whether it is male or female.  Although it is affecting to look angry at you, its sculpted cheeks are quite flushed and there is a definite undercurrent of desire in its eyes; you suspect your display of strength and dominance appeals to it on some perverse, animalistic level.  Still smiling victoriously, you bend your face into it, deliberately invading its personal space, silently demonstrating who is in charge here.  It can't hold your gaze and, blushing, looks downwards.  A flash of shiny black catches your eye beneath you.  Looking downwards you see that where its insect half meets its human half, where its cock should be, it instead has a genital slit; from this is emerging a long, black prong, dripping with clear oil.  Your show of dominance is turning this creature on, and it is powerless to disguise it.  Feeling playful, you reach down and caress its strange pseudo-cock, enjoying the feeling of the warm, sensual oil on your fingers.  The trap gasps and more of its length slides out; it must be about ten inches long all-told.  You stroke its cock until your hand is covered with its ooze, before trailing your fingers slowly up its taut, slender chest.");
	outputText("\n\n\"<i>You like that, don't you, sand sissy?</i>\"  It is breathing heavily but it still won't look into your face. \"<i>Look me in the eye!</i>\" As it finally does so you push your oil-covered fingers into its mouth and it moans around them as you swab its tongue and cheeks with its own grease.  You press your body against it, your " + player.allBreastsDescript() + " pushing into its own flat chest; it is powerless to resist you as its own pheromones take effect upon it, and you slowly push it backwards onto the flat of its back on the sloping sand.  You sit your moist " + player.vaginaDescript(0) + " at the base of its pseudo-cock and then slowly lead yourself back, luxuriating in pushing your " + player.clitDescript() + " up this oily slide.   It moans and shifts itself upwards needily, but you tut mockingly and stop your slow slide inches away from its tip.");
	outputText("\n\n\"<i>Ask for it.</i>\"");
	outputText("\n\n\"<i>Pleasze...</i>\" the sandtrap manages in a tiny voice.  Its slender cheeks are red and it stares hopelessly into your eyes.  You twist your thighs and very gently tease its tip with your wet opening, before once again coming to an agonising halt.  The trap almost sobs.");
	outputText("\n\n\"<i>Beg for it!</i>\"");
	outputText("\n\n\"<i>Pleasze lion!  I hwill do anything for you!  I hhwill do anything to serve your body!  I am hyour slave! Just... pleasze pleasze fuck me!</i>\" it cries out, its fluttering voice in danger of breaking up completely.  You suppose that will do.  Holding the sandtrap down, you sink your wetness down onto its long, thin length with a pleasurable sigh.");
	//Tight: 
	if (player.vaginalCapacity() < 30) outputText("  Its thin length is a perfect fit for your tight pussy - the slick prong slides against your inner walls like a hand into a silk glove.  After slowly working your [hips] back and forth for a while you quickly pick up a rhythm, until you are ruthlessly bucking its pseudo-penis back towards its face, giggling as you ride the creature for all it is worth.  Its willowy upper body is your plaything and you tweak its pale nipples, stroke its sensitive armpits, anything that will make it flinch and force another cute, fluttering moan out of it.");
	//Loose: 
	else outputText("  Its thin length is lost in your vast pussy, and you find you have to work your [hips] hard, ruthlessly bucking its pseudo-penis back towards its face, to get what you can from it.  You spare no expense telling it how unsatisfied it leaves you, what a pathetically-sized penis it owns, more like a sissy clit really, and as you do so you tweak its pale nipples, stroke its sensitive armpits, saying or doing anything that will make it flinch and force another cute, fluttering moan out of it.");
	player.cuntChange(14,true,true,false);
	outputText("\n\nIt can't last long against your domineering fuck and you are only minutes in when, with a trembling gasp, it thrusts itself upwards and orgasms.  Rather than ejaculate, the sandtrap's cock seems to perspire its odorless payload from all sides; oil drools out of your [vagina].  You swoon at the sensation; the stuff makes you feel like butter in the desert sun, imbuing you with a lazy, radiant sensitivity.  You grip your hips around the trap, plugging as much of the wonderful substance in on its thick base, savoring the softness it brings.  It dreamily occurs to you that whilst the creature is capable of ejaculating, it apparently can't lose its erection; the thing in your cunt is more like a stinger than anything.  This strikes you as a feature to take full advantage of.  You lean downwards and blissfully inform the sandtrap that it came instantly like the sissy it is, and the only way it can make it up to you is giving you everything it's got over the course of the next few merciless hours.  The creature is incapable of responding.  Its thin chest heaves for air as its six eyes roll to the heavens as you begin to slowly buck against it once more.");
	outputText("\n\nYou rotate your [hips], bending the sandtrap's dick this way and that, making it push into you in every direction.  Every time it weakly attempts to thrust into you, you simply stop moving.  With you sitting on top of it and your pussy not milking it the trap is incapable of pushing itself to another peak, and eventually it stops trying and begs you with its eyes.  Its own juices are working against it however, because you are in no hurry.  You simmer in the lazy, sensual sex, tormenting the creature beneath you by slowly working your [hips] backwards and forwards, blissfully circling your clit for what seems like hours, the time elongated by the effect of the radiant pheromone oil.  When it does come, it does so entirely on your terms; mercilessly you milk it, flexing your [vagina] around its thin length repeatedly until it groans and leaks more of its fluids into you.  You woozily drift your hand into the clear oil oozing out onto the sandtrap's flat abdomen before forcing it to lick your fingers, keeping it well sedated.");
	outputText("\n\nYou force the trap to orgasm like this two, three more times before you begin to pick up towards your own high.  Your thighs batter a fierce rhythm into the creature as red mist takes over, deep instinct forcing you into haste.  When you finally reach climax it feels like the crescendo of a long, beautiful song.  You cry out at the sky, sweat beading your skin as your innards clench over and over, spurting girl cum over the sandtrap's abdomen, covering it with your combined, sticky sex.");
	if (player.hasCock()) outputText("  [EachCock] flexes in delicious concert with your quim, spurting jizz onto the trap's chest and face.");
	outputText("\n\nIn an amplified post-coital euphoria, you slide off the sandtrap, almost falling straight over- you have been at it so long you've lost sensation in your [legs].  You slowly redress and then, before you take your leave, kneel next to the sandtrap's head.  It is still lying with its arms spread-eagled upon the slope, its abused, wilted oil prong slowly retracting, looking semi-comatose.  Smiling, you stroke its brow until it looks up and focuses on you.");
	outputText("\n\n\"<i>What do you say, slave?</i>\"");
	outputText("\n\nIt takes the creature several moments to gather its wits.  \"<i>Th-thank you, lion.</i>\"  Glowing with satisfaction, you begin the climb out of your conquest's hole and back towards camp.");
	player.orgasm();
	dynStats("sen", -1);
	combat.cleanupAfterCombat();
}
//\"<i>Vagina</i>\" (Z)
private function stickWangInSandgina():void {
	clearOutput();
	spriteSelect(97);
	//Requires: Penis and str requirement
	var x:int = player.cockThatFits(80);
	if (x < 0) x = player.smallestCockIndex();
	outputText("You bend into the sand and allow the slope to slowly carry you down to the bottom and the defeated sandtrap.  Its six black eyes regard you with a mixture of lust and resentment as you slowly discard your clothes, revelling in the hot desert sun upon your naked form.  As the soft powder delivers you to its side it tries to curl its hands around your thighs.  Whether this is one last attempt to drag you down or because it is trying to curry your favor somehow you don't know, but you aren't having any of it.  You catch its hands, easily overpowering it.  It uses its other pair to try to pathetically prise itself out of your grasp; you find that its wrists are thin enough for you to reach your hands around both and hold all four of its arms quite comfortably.  You beam triumphantly at the helpless sandtrap, who glowers in response.");
	outputText("\n\nYou take a moment to look your strange conquest over.  Even up close you can't tell from its thin, fey beauty whether it is male or female.  Although it is affecting to look angry at you, its sculpted cheeks are quite flushed and there is a definite undercurrent of desire in its eyes; you suspect your display of strength and dominance appeals to it on some perverse, animalistic level.  Still smiling victoriously, you bend your face into it, deliberately invading its personal space, silently demonstrating who is in charge here.  It can't hold your gaze and, blushing, looks downwards.  This submissive demureness sends heat rushing towards your " + player.multiCockDescriptLight() + "; the desire to fuck builds in you, to plough, to sink your cock into this strange, eerily beautiful creature, to establish once and for all who is giving and who is receiving around here... the only question is, how?  Its slim, androgyne upper body is devoid of obvious sexual features.  Your eyes roam steadily downwards.  Where its insect half meets its human half, where its cock should be, it instead has a genital slit; from this is emerging a long, black prong, dripping with clear oil.  Your show of dominance is turning this creature on, and it is powerless to disguise it.  It looks up at you with timid hopefulness... but you are in no mood for that.  There is a definite air of femininity to this creature, a pheromone scent which speaks directly to your " + player.cockDescript(0) + ", makes you hard");
	if (player.balls > 0) outputText(", makes your " + player.ballsDescriptLight() + " swell in readiness,");
	outputText(" and fills you with a deep, red urge; you grit your teeth in frustration at its essentially male upper half.  Its female half must be what is buried beneath the sand.  <i>Well,</i> says your dick.  <i>You've come this far...</i>");
	
	outputText("\n\nWith an air of purposefulness, you step forward and clinch the sandtrap around its abdomen.  It makes a startled, fluttering noise and grabs you instinctively with its four arms as you set your shoulder into it and heave, as if you were preparing to give it a fireman's lift.  With a rumbling, hissing sound, its bulging insect abdomen begins to emerge from the sand.  The sandtrap goes into full panic mode as you progressively winch it clear of its nest, beating its arms weakly against your back as it babbles.");
	outputText("\n\n\"<i>No!  Pleasze don't do that!  Pleasze I, I don't hhwant to be naked!  I'll leave you alone from nowhh on, I'll- I'll make sandcastles for you, juszt sztop...</i>\"  You ignore it, concentrating on the task in hand, and with one final heave pull it completely clear of its hole, spilling it onto the sand.  You catch your breath as you take it in.   Its fawn-coloured teardrop-shaped abdomen must be twice the mass of its human half, every bit as ponderous, leathery and alien as the rest of the creature is graceful, smooth and trim.  And at the very tip of it... a wave of heavy female sex pheromones assaults you as you observe, far more powerful this time, drawing blood from your head inexorably to your genitals.  Its lips and labia are strikingly human looking, bizarre against the leathery exoskeleton from which they protrude, but the vagina itself looks different: less like an opening and more like one end of a tight, fleshy tube.  Despite the creature's continuing babble of protests, it is dripping and ready, miraculously clean of sand.  You brace yourself against the beached trap's warm hide and try to clear your head, which is buzzing with the anticipation of sex.  Are you really going to do this?  <i>Yes.</i>  It's your dick again.  <i>Yes you are.</i>  You close your eyes and, thinking only of the heat in your veins and the pheromones in your nostrils, you grip the sandtrap's abdomen and push your " + player.cockDescript(0) + " into its wet sex.");
	//8 inches or less: 
	if (player.cocks[x].cockLength < 8) {
		outputText("\n\nThe creature's moist cunt is tight and is a perfect fit for your modest cock.  Working yourself slowly backwards and forwards, you sigh as you soon hilt yourself in the warm wet, nowhere near its full depth.");
	}
	//8 inches to 35: 
	else if (player.cocks[x].cockLength < 35) outputText("\n\nThe creature's moist sex is tight and you have to work your way in carefully, letting it get used to your girth, slowly working it loose enough to take your big cock.  The creature moans as you patiently squeeze more and more of yourself into its warm wet, eventually hilting yourself deep in its depths as it dribbles fluids on the sand at your feet.");
	//Megacock: 
	else {
		outputText("\n\nThe creature's moist sex is tight and you honestly doubt it can even take your obscenely massive tool.  Never say never, though.  You work your way in carefully, letting it get used to your girth, slowly working it loose enough to take your " + player.cockDescript(0) + ".  The creature gasps and then moans as you patiently squeeze more and more of yourself into its warm wet; its sex may be narrow but it is incredibly long, running perhaps the entire length of its abdomen.  Your cock is more than a match for it however and your breath quickens as you continue thrusting more of yourself in, until it feels like the end of your cock is trapped inside a hot, soft, grasping drainpipe.  \"<i>Hhhhwhat even is that?</i>\" squeaks the panting, peering sandtrap, in a tone somewhere between terror and awe.  \"<i>Yyour leg?  Hwhat kind of monszter even are you?</i>\"  You're not taking that from an androgynous insect chimera.  You respond by giving it one last savage, triumphant push, bottoming out in the sandtrap's egg sac.");
		//[Balls and cocklength >= 40:  
		if (player.balls > 0) outputText("  Your " + player.ballsDescriptLight() + " slap against the creature's wet opening.  ");
		outputText("  Any coherence flies straight out of the sandtrap's head and it can do nothing but whine, buzz and moan as you begin to thrust in and out of it, penetrating it to its very core, the [cockHead] bumping against strange bulbous objects which give and push back against your sensitive end delightfully.");
	}
	
	outputText("\n\nThe creature's tube-like opening sucks and sticks to your cock ever so slightly as you slide outwards, like an anemone grabbing at your finger");
	if (silly()) outputText(", though with fewer pouting blue lips and doe eyes");
	outputText(".  The trap's top half has quietened down a bit but is still trying to twist itself around, grasping futilely backwards with its four hands.  It can't possibly reach you or even move with you attached to its back end as you are; in fact it is completely helpless... yet, judging by its flow of fluids, is hugely turned on by the sensations you are forcing upon it; the revelation serves to quicken your own lust.  You grunt as you slowly move your cock up and down its tunnel, revelling in the sticking, sucking sensation inundating your cock before beginning to pick up the rhythm.  Soon you are slapping against it gleefully, clutching onto the sandtrap's chitin as you thrust your hips in and out of it, delighting in its wonderfully tight, succulent cunt.  The sandtrap itself has long since stopped struggling; it works its ovipositor in rhythm with you, relaxing and opening up on your outwards movement and tightening up to provide you with a jaw-droppingly tight return thrust.  Its human half clenches handfuls of sand fitfully, six eyes closed and mouth open, offering verbal encouragement whenever it can manage to form the words.");
	
	outputText("\n\n\"<i>Hhhhyes!  That'sz it lion, oh do me, do it to me hard!  Give me yyyyour strong spunk - uh! give hhit to me szo I can sink yyour children into evvryone I catch - yes!  Hhhhso the whole world can know hhwhat a " + player.mf("man","woman") + " you arrrrrhhhhhe!</i>\"  The creature's words subside into a high fluttering cry as it cums.  Its ovipositor spasms and clenches, milking you down your " + player.cockDescript(x) + " for all it is worth.  Even if you wanted to, you could not pull back from the brink.  You come with near-painful intensity, your jizz shooting out of you as if your dick were trapped in a vacuum, losing yourself in ecstasy - you feel nothing but the grasping wet around your " + player.cockDescript(x) + ", your cream spurting out of you like liquid gold, and the sun beating down on your back.");
	
	outputText("\n\nYou come to your senses some time later.  Your ");
	if (player.balls > 0) outputText("balls ache and your ");
	outputText("vision swims a bit as you slowly recede from the sandtrap, dripping shared sex as you go.  You give the top half of the creature a careful berth as you pick up your [armor] and slowly dress, but it is in no shape for retaliation.  The black haired androgyne seems to be in a deeply satisfied post-coital trance, humming and fluttering softly to itself as it trails patterns in the sand.  It blinks unsteadily at you as you begin to clamber your way out of the hole.  Behind you you hear sand being flung as it begins to go about the task of re-immersing itself.");
	outputText("\n\n\"<i>Thank you for your seed, lion,</i>\" its sleepy words reach you as you pull yourself clear of the hollow and step out towards camp.  \"<i>Perhaps next time we meet I will return the favor, hmm?</i>\"  In your wearily tranquil fug you can't tell if it intends this as an invitation or a threat.");
	player.orgasm();
	dynStats("sen", -1);
	combat.cleanupAfterCombat();
}

//Naga Threesome (Z)
private function nagaThreesomeWithSandTrap():void {
	clearOutput();
	spriteSelect(97);
	//Requirements: Player is naga with tail and fangs, has met desert naga as naga at least once
	outputText("You slowly slither down to the bottom of the pit, your long patterned tail undulating in the sand, until you are by the sandtrap's side.  There is a mixture of fear and lust in its eyes as it regards your sinuous form; you slowly prise yourself out of your [armor].  You're not quite sure what you want to do with your lean, tender prize yet, so you follow what your snake instincts, speaking to you in the warm hush of your scales brushing through the sand, tell you to do.  The sandtrap murmurs in disquiet as you pass yourself around its willowy upper body, your tail looping first its abdomen and then its flat breasts, strong, muscular coils easily overcoming the struggles of its four thin arms.  Soon its upper frame is swaddled in your lower body.  It scowls at you and you beam back, displaying your fangs, enjoying the sight and feeling of this former aggressor entirely at your mercy.");
	//First encounter: 
	if (flags[kFLAGS.SANDTRAP_NAGA_3SOME] == 0) {
		outputText("\n\nA small cough from above you makes you start.  Looking up you are startled to see the desert naga peering down at the two of you.  Anxiety vies with amusement on her face.");
		outputText("\n\n\"<i>I heard fighting and I heard you,</i>\" she says, in your lonely, shared tongue.  \"<i>I thought you might need help.</i>\"  She gestures with disdain at the creature held in your coils, the six eyes of whom are bulging with fright at the sight of the pair of you.  \"<i>I have encountered these creatures before.  They do... bad things if you let them surprise you.</i>\"  She twists her mouth, and you do the math yourself.");
		outputText("\n\n\"<i>Perhaps you're in the mood for a spot of revenge, then?</i>\" you suggest, languidly corkscrewing your coils around your prize.  She blinks, and then smiles warmly.  \"<i>We </i>are<i> of one blood, you and I,</i>\" she says fondly, as she slowly slides down to join you.");
	}
	//Repeat encounter: 
	else {
		outputText("\n\nYou look up and are somehow unsurprised to see that whilst you were twining yourself around the sandtrap, you gained a spectator.  You look into the eyes of the desert naga seated above you and the two of you smile; there's no need for words.  She sinuously descends into the pit, the sandtrap moaning in its fluttery voice at the sight of her.");
	}
	outputText("\n\n\"<i>Here, lover, allow me.</i>\"");
	outputText("\n\nYou loosen your coils and allow her to trade places with you, enjoying the feeling of your warm leathery scales brushing against hers.");
	outputText("\n\n\"<i>Liszten, why don't hwwe call it a draw?</i>\" says the sandtrap in a fluttering squeak as it helplessly clutches at the reptilian flesh roiling over and around it.  \"<i>I can szee you two would rather be alone, a-and I've got plazes to be, szo...</i>\"");
	outputText("\n\n\"<i>Shush now, prey creature.</i>\"  The naga has wrapped one coil around its abdomen and has positioned itself so her face and genital slit confront the sandtrap's own.  You lie on your own coils and watch.  The naga looks into the sandtrap's black eyes and then slowly and sinuously begins to move her lean body backwards and forwards, backwards and forwards, dancing like a flowing ribbon whilst keeping her head still, staring flatly into the sandtrap's face.");
	outputText("\n\n\"<i>That's it, prey creature, deeper and deeper you go... you are feeling so soft and helpless, and it feels so good to let go and sink, deeper and deeper... I am so much bigger than you, so much more powerful, and that feels right, so soft and warm and right for me to tower above you and move you as I wish,</i>\" she hisses huskily as she dances, her pert breasts palpitating gently.  You doubt the sandtrap can understand her - it occurs to you that this display is as much for your benefit as it is for the trap - but you see the fear bleed out of the creature's eyes, its sculpted jaw gently sagging as an expression of dozy serenity creeps over it.  The naga smiles and then, still staring into its eyes, hisses a long, wet, intimate sound whilst gently touching the creature's genital slit.  The sandtrap moans softly and lies back onto the sand, sliding its black, oily sex out of its hiding place.  Soon its ten inch pheromone cock prong is gently poked against the naga's skin.  The sandtrap makes no attempt to guide it into the naga's own genital slit, nor makes any needy movements or sounds; its eyes are miles away, its will subsumed entirely by the naga's.  Your lover smiles a pleased smile, gently stroking her victim's jaw line.");
	outputText("\n\n\"<i>Good,</i>\" she says.  \"<i>Now, prey creature, whilst I take my satisfaction from you, you will give the best sex your mouth is capable of to my friend here.  Perform well and who knows... perhaps we will show mercy and let you go.</i>\"  You know a cue when you hear one, and work your reptilian body around the sandtrap again, this time from the other end.  Balancing your upper half above its head on the coils you don't use to curl around the creature's chest, slithering down its face, sighing as you open your own slit and expose yourself to the warm desert air.");
	//Male/Herm: 
	if (player.hasCock()) {
		outputText("\n\nYou press your hardening " + player.cockDescript(0) + " against the creature's lips.  Its eyes still far away, the sandtrap opens its mouth and begins to lavish attention upon your head with its tongue, circling it with gentle pressure whilst giving your urethra the occasional faintest of flicks.  Sighing, you push yourself forward into the creature's soft mouth, its teeth parting to quiescently accept your dick.  At the edge of your concentration you hear a quiet gasp as your snake partner lowers herself slowly down the sandtrap's prong.  The creature's mind may be elsewhere, but its body evidently still understands pleasure; it gives out a muffled moan around your cock, sending pleasurable vibrations down your shaft, before beginning to suckle you in earnest.  The sensation is devilishly strange; you're feeding yourself into the sandtrap's mouth upside down, its tongue lavishing attention upon the upside of your dick.  It moves its tongue around and briefly you press against the incredibly wet and pliable tissue at the bottom of its mouth.  You light-headedly wonder if this isn't just the much better way of doing things.");
		//[<14 inches: 
		if (player.cocks[0].cockLength < 14) {
			outputText("\n\nYour " + player.cockDescript(0) + " is a good fit for the sandtrap's mouth and soon the creature is taking your whole length, lavishing its oil and saliva into your straining cock, lying its head back and opening its mouth wide so you can begin to piston into its submissive opening with fervor, ");
			if (player.balls > 0) outputText("slapping your " + player.ballsDescriptLight() + " into its nose, forcing your cock all the way to the top of its tight throat.");
		}
		//14 inches or more: 
		else {
			outputText("\n\nYour " + player.cockDescript(0) + " is bigger than what the sandtrap's mouth can accommodate, and it isn't long before you are beginning to push into the creature's tight throat.  It lavishes its oil and saliva onto your straining cock, lying its head back and opening its mouth as wide as it can to aid you in your task, and soon you are ");
			if (player.skinType == SKIN_TYPE_PLAIN) outputText("beading sweat, ");
			outputText("pistoning into its submissive opening with fervor, ");
			if (player.balls > 0) outputText("your " + player.ballsDescriptLight() + " swinging heavily in front of the sandtrap's nose, ");
			outputText("pushing as much of your lubricated dick down the creature's gullet as you can.");
		}
		outputText("\n\nIn front of you the naga moans, oil dribbling out of her snatch as she moves backwards and forwards sensuously on top of the sandtrap's prong; she looks at you with heavy, pheromone-induced lust, her forked tongue flicking out of her mouth.  Your coils rub together over your shared meal's slim body, and you find yourself flicking your own tongue out in tandem with your lover, smiling as you touch each other for the briefest of moments, breathing in the scent of each other's flesh.");
		if (player.cocks[0].cockLength >= 14) outputText("  You're not sure which is the more pleasing sight; her, or the rhythmic bulging in the sandtrap's neck.");
		outputText("  Mindlessly, the sandtrap's four arms clutch and stroke the warm scales which swaddle its upper body as the two of you continue to fuck it.");
		
		outputText("\n\nThe naga is soon deep within the sandtrap's oil and she slows her thrusting down as it relaxes her and amplifies what she can feel, smiling euphorically as she slowly rotates on the creature's leaking pseudo-cock.  You slow yourself down in sympathy; although it's difficult not to blow your load from the worshipful treatment the sandtrap is giving your " + player.cockDescript(0) + ", there is no harm in prolonging this quality sex and you've had enough oil rubbed into you to feel quite dreamy yourself.  Eventually though, your peer begins to pick up the pace, clutching your hands as she bucks, her breasts bouncing up and down, gasping and moaning.   Finally she clenches both you and the sandtrap tight as she rolls her eyes at the sky and screams, femcum spurting out around the sandtrap's base; the sight is enough for you to finally push to your own eye-crossing peak.  You grip the naga's hands, lean your head back and unload your cum straight down the sandtrap's throat.");
		if (player.cumQ() > 1000) outputText("  The long, sensuous blowjob has pushed your body into overdrive and you spurt endlessly down the creature's tight gullet, panting and sweating as you discharge a veritable flood.  The hypnotised sandtrap gladly drinks what you give it, but it's far too much and soon it is coughing your jizz back up, through its nose and around your still ejaculating " + player.cockDescript(0) + ".");
	}
	//Female: 
	else {
		outputText("\n\nYou press your moistening " + player.vaginaDescript(0) + " against the creature's lips.  Its eyes still far away, the sandtrap opens its mouth and pushes its soft tongue into your cleft.  It explores your labia and hole before turning its attention to your " + player.clitDescript() + ", circling it with gentle pressure whilst giving it the occasional faintest of flicks.");
		//[Squirtr, jotun of flooding: 
		if (player.wetness() < 4) outputText("  Its gentle worship of your " + player.vaginaDescript(0) + " soon has you streaming rivulets of girlcum from your oversexed hole, dribbling down the sandtrap's face as you eagerly press yourself down for more.");
		outputText("  You close your eyes and lose yourself to the delightful sensation, contracting and relaxing the coils wrapped around your prey in time with throbs of pleasure.  At the edge of your concentration you hear a quiet gasp as your snake partner lowers herself slowly down the sandtrap's prong.  The creature's mind may be elsewhere, but its body evidently still understands pleasure; it gives out a muffled moan in your cunt, sending pleasurable vibrations deep into you, before sinking its tongue deep into you, slathering your sex with saliva and oil as it pushes its mouth fully onto you.  You buck against it excitedly, forcing more and more of its tender muscle into you, squealing as you reach an exuberant high, your vagina flexing around the sandtrap's tongue as you reward its attentions with a small waterfall of girlcum.");
		outputText("\n\nSimmering with pleasure, you lazily work your thighs backwards and forwards, allowing the creature to lick your lips clean whilst still keeping you oiled and purring.  In front of you the naga moans, clear glaze dribbling out of her snatch as she moves sensuously atop the sandtrap's prong; she looks at you with heavy, pheromone-induced lust, her forked tongue flicking out of her mouth.  Your coils rub together over your shared meal's slim body, and you find yourself flicking your own tongue out in tandem with your lover, smiling as you touch one another for the briefest of moments, breathing in the scent of each other's flesh.  Mindlessly, the sandtrap's four arms clutch and stroke the warm scales which swaddle its upper body as the two of you continue to fuck it.");
		outputText("\n\nThe naga is soon deep within the sandtrap's oil fuge and she slows her thrusting down as it relaxes her and amplifies what she can feel, smiling euphorically as she slowly rotates on the creature's leaking pseudo-cock.  You pace yourself in sympathy; having already reached one ecstatic high you're more than happy to simply sit back and enjoy the sandtrap's worshipful ministrations, tending to every corner of your " + player.vaginaDescript(0) + ".  You've also had enough oil rubbed into you to feel quite dreamy yourself; the sand, the sun and even your own vagina seem bigger and more encompassing than they were before.");
		outputText("\n\nEventually however the naga begins to pick up the pace, clutching your hands as she bucks, her breasts bouncing up and down, gasping and moaning.  Finally she clenches both you and the sandtrap tight as she rolls her eyes at the sky and screams, femcum spurting out around the sandtrap's base; the sight is enough for you to finally push yourself to another own skin-tingling peak.  You grip the naga's hands, lean your head back and unload yet another spurt of sweet slime into the sandtrap's mouth.");
		if (player.cumQ() > 1000) outputText("  The long, sensuous tongue bath has pushed your body into overdrive and the waterfall you unleash is even more uncontrollable than the last; you wonder dizzily if you haven't just lost control of your bladder.  The hypnotised sandtrap gladly drinks what you give it, but it's far too much and soon it is coughing your girlcum back up, through its nose and back onto your still contracting " + player.vaginaDescript(0) + ".");
	}
	outputText("\n\nEventually the two of you ride out your shared orgasms and, after relaxing for a short while in the naga's arms sharing the bliss of an oil-coated post-coitus, you slowly disentangle from the sandtrap.  Exhausted by hypnosis and your own ministrations, the androgyne sinks down into the sand and slumps its head into its four arms, covered from head to waist in sticky sex.  Hand in hand, you and the naga slither out of its hole.  Your partner lets out an uncharacteristic giggle as a fluttering snore reaches you from below.");
	outputText("\n\n\"<i>That was wonderful,</i>\" she whispers as she slowly releases you and begins to trail off into the shimmering heat.  \"<i>Everything is so much more fun when you do it with two.</i>\"");
	outputText("\n\nYou definitely think visiting the desert more often is a good idea.");
	player.orgasm();
	combat.cleanupAfterCombat();
}

//Sandtrap Bad End
//Requirements
//*Has insect wings and insect eyes
//*Lost to a Sandtrap twice in a row
private function sandTrapBadEnd():void {
	clearOutput();
	spriteSelect(97);
	outputText("Once again you find yourself wandering back to the desert.  For all that it is a treacherous, barren wasteland, you feel an odd allure to the place; your feet seem to know where to take you as you walk far from the relative sanctuary of Tel'Adre, far from the slithering grounds of the Naga, your mind somewhere in the mercilessly clear sky.  Your thoughts bubble and seethe into a froth high up there above your vacant body; there is an odd... swarming sensation to them, as if they were reaching out to touch the tips of other consciences just like your own.  You feel an awakening yearning to join, a loneliness, a want to become more than the tiny speck in the desert that you are.");
	outputText("\n\nYou start and come to your senses as your feet point downwards into a shifting pit.  Out in the middle of nowhere, you have led yourself to a Sandtrap.  It lazily trails its hands in the sand at the bottom of its hollow and grins up at you, its face shimmering between genders.  There is something... knowing in its smile.  You try and collect yourself a bit.  Why didn't the creature try and surprise you?  Somehow the sight of it sitting there brazenly, waiting for you, is more eerie than if it had tried to suck you into its trap.");
	outputText("\n\n\"<i>My people have stories about wanderers like you,</i>\" the androgyne says softly, its multiple black eyes looking into your own black orbs.  \"<i>It has been so long since we had such a one as you, and we were so winnowed by the soulless lions of the mountains, that your kind have passed into legend.  Surface scratchers who not only bear our children, but choose to do so willingly; who drink the fluids we gift them to become of our flesh; who come back to our lands time and again, answering a call only they can hear.</i>\"  The creature opens all four of its arms to you, beaming triumphantly.  \"<i>You need only to take the final step, Flytrap.  Come to me, and embrace your desztiny.</i>\"");
	outputText("\n\nYou stand at the lip of the Sandtrap's hollow, shaking your head, trying to make sense of what it is saying.  It's talking nonsense...isn't it?  Again you feel light-headed, your thoughts a lonely cloud of bees without a hive.  They have no purpose, and the Sandtrap is offering you one... but don't you already have a purpose?  Not as good a purpose as this one.  Not as right a purpose, one that perfectly suits what your body has become...  ");
	if (player.hasCock()) outputText("[EachCock] hardens and your thin frame feels aflame, barely understood impulses deep within you begging you to walk down and submit to the Sandtrap's will.  ");
	//Female: 
	else if (player.hasVagina()) outputText("Your [vagina] moistens and your thin frame feels aflame, barely understood impulses deep within you begging you to walk down and submit to the Sandtrap's will.  ");
	outputText("You inhale hard and try to clear your head, forcing yourself not to sleepwalk downwards into the Sandtrap's waiting embrace.  The creature doesn't seem to mind your hesitation; it smiles softly and confidently, waiting for you with the infinite patience of its kind.  You need to make a choice here fast, before your burning body makes it for you.");
	//Fight/Desztiny/Leave
	menu();
	addButton(0,"Fight",sandTrapBadEndFight);
	addButton(1,"Desztiny",desztiny);
	addButton(4,"Leave",leaveSandTrapBadEnd);
	
}

//Fight: 
private function sandTrapBadEndFight():void {
	clearOutput();
	spriteSelect(97);
	outputText("You shake yourself out of your fog, clench your [weapon] and grit your teeth.  You are your own person, dammit, and you will show this creature just what that means!  The Sandtrap slowly lowers its arms and looks at you with almost parental disappointment as you march into its pit with the obvious intention of beating the crap out of it.  \"<i>You want to dance again, Flytrap?</i>\" it sighs.  \"<i>I would prefer that you look at yourself and accept what you are, but I will force you to accept it if that is what you wish.</i>\"");
	//(If fight won, resets counter)
	startCombat(new SandTrap());
}

//Leave:
private function leaveSandTrapBadEnd():void {
	clearOutput();
	spriteSelect(97);
	outputText("With some effort you break your stare with the Sandtrap, turn away and step back towards camp, resolving to leave this disturbing scenario with its disturbing thoughts behind.");
	outputText("\n\n\"<i>I understand, Flytrap,</i>\" a calm voice reaches you from behind.  \"<i>You need time to think things over and truly recognise what you are.  I know you will come back.  You always do.</i>\"");
	doNext(camp.returnToCampUseOneHour);
}

//Desztiny:
private function desztiny():void {
	clearOutput();
	spriteSelect(97);
	outputText("The Sandtrap is right.  What your body and subconscious are telling you is so right.  At your acceptance of what the creature is saying warmth floods through your body; your mind bubbles as blood rushes towards your skin, making you feel incredibly sensitive, incredibly sexual.  ");
	//Male: 
	if (player.hasCock()) outputText("Your cock strains upwards and you moan; feeling as sensitive as you do, you are both desperate to be touched and desperate not to be.  ");
	//Female:
	else if (player.hasVagina()) outputText("You feel but barely hear the drip of moisture on the sand, both your [asshole] and [vagina] beading with oily need.  ");
	outputText("It seems incredible, as you stumble slowly downwards, feeling every grain of sand underneath your receptive feet, that barely seconds ago you were even considering not doing this.  It dully occurs to you that there was a reason for that, that you had a purpose.  What is your purpose? You feel like you are shedding whatever that was like an old skin as you walk downwards, discarding an old, directionless life, becoming something newer and raw and purposeful.  You practically throw yourself into the waiting embrace of the Sandtrap, moaning softly as you press your hands against its supple body and feel its quartet of hands slowly explore your back, your nape, your thin wings, your [butt].  You feel like you've come home.");
	outputText("\n\n\"<i>Good " + player.mf("boy","girl") + ",</i>\" says the Sandtrap, giggling slightly as it caresses you.  \"<i>Of course, that word doesn't mean anything to you anymore.</i>\"  You blearily look into its thin, beautiful face to ask what it means by that, and the creature takes the opportunity to plunge its tongue into your unresisting mouth.");
	sandTrapBadEndFinale();
}

//Lose fight:
private function loseLastFightWithSandTrap():void {
	clearOutput();
	spriteSelect(97);
	outputText("\"<i>Hhhhhyou are brave, little Flytrap, and hyou dance well,</i>\" says the Sandtrap, color high in its cheeks as it strokes your face, the rest of you buried securely underneath the sand.  \"<i>But it is time to put reckless foolishnessz behind you.</i>\"  Don't you think?  \"<i>After all, hyou have much important wwwork to do.</i>\"  Isn't that right?  You blink.  How is it doing that?  Did it... open its mouth at all?  The Sandtrap smiles at you with terrible understanding in its black eyes as you struggle.  You may deny it, \"<i>but hhhyou are one of usz, now.  In body,</i>\" and in mind.  You shake your head and try and focus, but it is impossible.  The trance-like state you felt out in the desert has returned, and you can't focus on anything except that feeling of loneliness... of lacking a purpose.  That is what is wrong here, you lack a purpose and you feel so empty, a vessel that needs to be filled, in need of a warm, loving hand upon you, turning you and pointing where you need to go... like the hand brushing your face now.  You look up at the Sandtrap, trying to beg it with your eyes to explain what is going on, and it answers you by taking your head into its hands, bending in and kissing you deeply.");
	sandTrapBadEndFinale();
}

//Both go to: 
private function sandTrapBadEndFinale():void {
	spriteSelect(97);
	outputText("\n\nIts lips move a slippery friction against yours as it twines its tongue around yours and begins to work glands deep in its gourd, trickling oil into your mouth.  It holds the back of your head kindly yet firmly as it does this, as if it were feeding you, but there is no need for it to apply any pressure at all.  You are nothing but a vessel for it, accepting what it is doing to you without question; you know nothing but the texture of oil and the creature's tongue pushing into you.  Your willingness is rewarded by making the Sandtrap's fluids flow swifter; it smiles against your face before gushing oil into your mouth in a torrent.  At the very edge of your awareness, you feel the sand parting around your feet, of the Sandtrap pushing you slowly downwards, of the delicious feeling of an infinity of warm particles against your “thighs”; but this is as nothing to the warm ooze sliding down your throat, intensifying your sensitivity, making you gasp and pull away and gush fluids of your own against the Sandtrap, before being pushed back into its dripping mouth with that insistent, loving pressure.  You drink, and drink, and drink, transfixed by a kiss which is more like suckling at a teat...");
	outputText("\n\nYou start and wake.  Groggily you get to your feet, and look around.  You are out in a featureless tract of the desert; there doesn't seem to be anyone around, and the sun is sinking slowly towards the dunes.  The Sandtrap let you go! You are free to return to your quest.  What was that again? You strain your mind against the layers of wooziness which cosset you, and you feel your thoughts once again flow into the high sky above you, throb and meld with others.  You feel a deep urge seize you from somewhere else, encompass your soft thoughts and thrust into you with a dominant demand and you gasp");
	if (player.gender > 0) {
		outputText(", feeling your ");
		if (player.hasCock()) outputText("cock harden");
		else outputText("vagina dribble");
		
	}
	outputText(".  Yes.  You remember your quest.");
	
	outputText("\n\nYou flit around the desert until you find what you are looking for.  A lone, purple shape, trailing along the dunes, throwing glances around himself uneasily - an incubus, almost certainly one of the oasis demons who has wandered away from the pack.  You land quietly behind him, tuck your wings behind your back and then feel your face shimmer, taking on a look of young, naive femininity, before you call out to him.  He turns, a look of relief melting into poorly disguised lechery as he hurries towards you.  He sees a way out of this treacherous wasteland and a free fuck at the end of it, and he gladly follows you as you beckon him towards yourself.");
	outputText("\n\nHis expression only changes when his cloven hoof sinks ten inches into the sand, and he lets out a deliciously despairing wail as the desert floor collapses all around him and drags him down into the waiting arms of a Sandtrap.  The androgyne smiles up at you perched upon the lip of its nest as it pushes the incubus down into the sandy mire, and you feel incredible euphoria.  Approval soaks into you from the sky above and the mere fact that you have fulfilled your purpose, that the dominant caste are pleased with you, has you kneeling upon the sand, stroking your [nipple]");
	if (player.hasCock()) outputText(" and masturbating [oneCock] desperately");
	else if (player.hasVagina()) outputText(" and fingering your [vagina] desperately");
	outputText(".  But, of course, as a fresh dominant urge takes you and drags you reluctantly from your needy genitals, there is much still left to be done.");
	
	outputText("\n\nYou spend the rest of your life fulfilling the duties of a Flytrap, leading unsuspecting wanderers of the desert into the grasp of the Sandtraps.  When times are lean you gladly submit to the Sandtraps yourself - gleefully allow them to pump your moist, obedient ass full of eggs.  They don't have to do that too often though, because you quickly become an absolute master at fooling travellers with your looks; able to sense what even the most cautious want to see and becoming it at the twitch of a wing, the ultimate desert mirage.  Before too long the air of Mareth's desert and plains become full of little Flytraps, their reaches treacherously pregnant with shifting Sandtraps, deadly even to the demons; you are joined by many others who willingly submit to the warm oil and the thoughts in the sky.  You have fulfilled your desztiny.");
	getGame().gameOver();
}
	}
}