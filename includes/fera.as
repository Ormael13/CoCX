//const PUMPKIN_FUCK_YEAR_DONE:int = 522;

function isHalloween():Boolean {
	return ((date.date >= 28 && date.month == 9) || (date.date < 2 && date.month == 10));
}


function pumpkinFuckEncounter():void {
	clearOutput();
	outputText("Just ahead, in the middle of the path, lies a seeming innocuous gourd - a pumpkin to be precise.  The growth is oddly out of place.  Nothing else grows on the soft animal-forged path you now tread, and the pumpkin and its vines are moist, as if wet with morning dew.  They are the only plants in the vicinity to bear such moisture, gleaming dully in the muted arboreal light.");
	if(flags[PUMPKIN_FUCK_YEAR_DONE] > 0) outputText("  An old, haunting memory surfaces, and you realizes this seems... familiar.  Did you find this last year?  Yes... it could have been this very same pumpkin...");
	outputText("\n\nWhile startled by the vegetation's placement, it seems harmless enough.");
	outputText("\n\nYou advance cautiously, extremely familiar with the traps and pitfalls that all-too-often prevail in this world.  The pumpkin's rind is bright orange, ripe and seemingly ready to bulge out.  The vines are thick, dark green, and reflective, partly thanks to the oozing moisture that drips from them to the floor.  After closing, it becomes clear that it isn't a coating of dew on the pumpkin but thick, viscous slime instead.  The clear, syrupy ooze begins to drip from the vines even as it rolls down the pumpkin, seeping out of the plant's skin in fat, heavy rivulets.");
	var fuck:int = 0;
	var mount:int = 0;
	if(player.hasCock()) {
		outputText("\n\nOne of the many indentations that mar the sphere's circumference seems deeper, darker than the others.  You lean a little closer, for a better look, and the shadowed fold ripples, then undulates, yawning wider and wider to reveal whole new shades of inky blackness.  It squelches, and a wide streamer of slime oozes out to slide down the side of the rind.  The puddle below the obviously tainted gord deepens with this new addition even as the wide-open rent widens.  A sweet, fruity smell rises from the opening, splattering out with a fresh wave of goop. This time, the passed slime leaves something different behind.\n\nWhere once the pumpkin had a midnight-black crevasse, it now has a fleshy, purplish gash.  The slime it exudes is more a fragrant nectar.  The rind around the opening appears cushy, and soft.  Best of all, the interior as pink as any pussy you've ever seen, and as wet as a succubus's snatch.  You take a deep breath of the fruit's female musk and find yourself wondering: should you fuck it?");
		fuck = 3688;
	}
	/* UNUSED DUE TO FEN LAZINESS {PC has tits}{NIPNUMBER} of the corrupted growth's vines rise up, slowly waving, snake-like in the air.  As if hypnotized, they lazily bob back and forth, drawing a few inches closer at the culmination of each movement.  You ready your [weapon], reading to defend yourself, but the slimy green tentacles pause at the new development, their tips opening to reveal plush green lips and slobbery purple tongues.  They lick at their lips, hungrily watching your {allChest] and waiting, biding their time.  They seem hungry for tits, and at the sight you feel your burgeoning milk readying to let down.  You could feed the plant, if you want to.  The idea is oddly compelling.  Do you?*/
	//Chick sauce
	if(player.hasVagina()) {
		outputText("\n\nThe stem of the pumpkin is long and proud, as well as knotted, barbed, ribbed, and flared like someone crafted the world's most perverted dildo to simultaneously resemble every type of cock in existence.  The tip bubbles constantly with slime like pre-cum oozing out of an erect phallus.");
		outputText("\n\nAs you gaze upon the stem, you can see it twitching like an actual penis and the aroma that comes from it is as enticing as what any incubus could produce.  You take a deep breath of the fruit's musk and find yourself wondering: should you mount it?");
		mount = 3727;
	}
	if(player.gender == 3) outputText("\n\nSo many choices, so little time.");
	//If PC has neither
	if(player.gender == 0) {
		outputText("\n\nOdd as it is, it doesn't seem to react as you look it over.  You avoid it, for now.");
		doNext(13);
	}
	simpleChoices("Fuck It",fuck,"Mount It",mount,"",0,"",0,"No Way",13);
}

//[HOLY SHIT YOU BE FUCKING A PUMPKIN]
function pumpkinFuck():void {
	clearOutput();
	flags[PUMPKIN_FUCK_YEAR_DONE] = date.fullYear;
	outputText("Well, fuck it.  You're horny, and this little pumpkin doesn't look like it could stop you from fucking that gushing gourd-pussy.  As you shed your [armor], a few of the rough, slime-sweating vines feebly rise up to embrace you, but you brush them away, having no time for corrupt foolishness.  You're going to bust a nut in this fruit's sweet, supple folds, not let some malformed tentacle-horror molest you.");
	outputText("\n\nYou kneel down before your target and examine the leaky orifice before you.  The rind around the opening is softer and smoother than human skin, yet oddly supple.  As soon as your fingers grace the surface of the moist fruit, a splash of ooze squirts from the gash to puddle at your [feet].  Curiously, you open the pumpkin's pussy with your fingers, feeling the slick wet walls trying to envelop your digits even as you gander at the compellingly vibrant interior.  The air seems thick with the plant's sweet smell, and [eachCock], irregardless of your reason, seems hard as stone and painfully erect.");
	outputText("\n\nTentatively, you raise one of your juice-soaked fingertips to your lips and taste it.  The flavor is as you would expect from a pumpkin, though it has a sweet, cinnamony aftertaste, just like the pies your village would make around harvest!  Shuddering at the memories of your distant past and budding lust, you shift position to line your [cock biggest] up with the lurid purple plant-pussy.  Smiling at the absurdity of it all, you push forward, anticipating the slimy tightness of your pumpkin's pie.");
	outputText("\n\nThe gushy gourd's interior does not disappoint.  Though it lacks the warmth or heartbeat of frantic copulation with a female, the slick plant-pussy is incredibly soft and pliant.  However, the walls seem to be squeezing against every square inch of dick that you yield to them, and a gentle suction slowly drags you in, whether you planned on going ");
	if(player.balls > 0) outputText("balls deep ");
	else outputText("hilt deep ");
	outputText("or not.  Not that you mind - the swollen labia seem to be doing an adequate job of smooching all over your shaft as it passes through their glossy gates.");
	if(player.cocks[0].cockLength >= 20) outputText("  After you've fed over a foot of your [cock biggest] into the gluttenous gourd, you briefly wonder where it's all going.  The pumpkin can't be more than a foot and a half across, yet it's sucking down the second foot now, and you have yet to hit any wall!  The suction suddenly increases, yanking you deeper, faster, and you forget all about the whys, whens, and whatevers.  It feels great.");
	outputText("\n\n");
	if(player.balls > 0) outputText("Your [balls] slap");
	else outputText("Your groin slaps");
	outputText(" into the orange 'skin' wetly, the omnipresent ooze immediately soaking your " + player.skinFurScales() + " with corrupted lubricant.  You hardly mind, finding your hips already setting into motion as you steady your hands to either side of the heavy fruit.  The lascivious fruit doesn't show any signs of minding the fast fuck you're giving it.  Indeed, the once weakly-moving vines have stilled, their restless tremors silenced by the firm smacks of your groin against vibrant rind and swollen lips.  You hump away at your immobile lover, spellbound by its fecund fruit-cunt, too drunk on lust and pleasure to question the strangeness of it all.");
	outputText("\n\n'Slap-slap-slapslapslapslap' rings out as you piston faster and faster, violently plowing the plant's pussy in a rutting, mating frenzy.  Your eyes are repeatedly drawn downward to the slimy hole each time you pull out, the suction keeping your [cock biggest] as hard as absolutely possible.  The purple-lipped pussy seems even larger than before, the vulva monumentally swollen, a thick pillow for you to slam into as you ride the pumpkin into orgasm.  You feel a strange compulsion to cum inside, to flood the gourd with white goo until it sprays out around your [legs].");
	outputText("\n\nWith a triumphant roar, you climax and mash yourself against the pumpkin, slamming your [hips] hard enough into the pillow-like pussy that its mysteriously copious lube is squirted in every direction.  You don't care, your [cock biggest] is flexing, your urethra is dilating, and your cum is boiling out, flooding the pumpkin's innards in white goo.  Clenching tightly, your muscles lock, working in perfect concert with one goal: filling this fruit with cum.  ");
	if(player.cumQ() < 200) outputText("Your weak load disappears into the plant's sucking gullet, wicked away as fast as you fire.");
	else if(player.cumQ() < 1000) outputText("Your thick load disappears into the plant's sucking gullet almost as fast as you're firing it, though you can see a bit of white creampie forming around the edges of your cock.");
	else {
		outputText("Your massive load floods the pumping, a deluge of semen squirting around your [cock biggest] even as the pumpkin starts to enlarge.  Every titanic spooge-squirt pumps the gourd up another level.  Soon, the rind is rubbing your belly.  A few blasts later, it's lifting you from the ground, your still-spurting cock lodged firmly in its cunt.  The suction feels so much stronger now - you're not sure you could pull out now if you wanted to, and you don't!");
	}
	if(player.cumQ() < 1000) {
		outputText("\n\nAll too soon, you finish and step away, satisfied.  The pumpkin's pussy seals closed slowly, cutting off the worst of the slime-flow.  You get dressed, but the plant's tendrils no longer bother you.  They lie still and flat, and even the perverse sweating comes to an end.  Whatever fel magic was behind this, it seems to have settled after the salty snack you gave it.  You get dressed and walk back to camp with a spring in your step.");
		stats(0,0,0,0,0,0,-100,2);
		doNext(13);
	}
	else {
		outputText("\n\nOver and over you empty your [balls] into the growing gourd, inflating it larger and larger, passionately giving up every drop of sperm to fuel its unnatural growth.  Even once you feel empty, your [cock biggest] continues to clench and pump, firing blanks in an effort to feed EVERYTHING to the semen-hungry plant.  Still, even your prodigious virility can only take so much, and once your dick starts to go soft inside the massive cunt, it releases you, allowing you to ride out the rest of your orgasm, below, on the ground.  Your descent is graceless, a lazy slide down the orange rind.  Were it not for the gentle slope, it would be a dangerous six-foot fall.");
		outputText("\n\nYou thank the gods for that small mercy as you calm down and climb to your feet, beholding the sudden gargantuan growth as if for the first time.  That pumpkin is at least six feet tall, and the swollen pussy that devoured your cum?  It has grown with it, now a gash big enough to devour a man.  A few strings of semen trail from the labia to the ground, but it looks like most of your cum is vanishing into the pumpkin's depths, drank down for some purpose only the demons would know.");
		outputText("\n\nA faint rumbling is the only warning you get (or need).  You jump back and ready yourself for anything, ");
		if(player.weaponName == "fists") outputText("brandishing your fists");
		else outputText("picking up your [weapon]");
		outputText(" as if it would somehow protect your nude body.");
		doNext(pumpkinFuckPartII);
		stats(0,0,0,0,0,0,-100,2);
	}
}
//[Next]
function pumpkinFuckPartII():void {
	clearOutput();
	outputText("The titanic rent shivers, flaps of fruit-flesh smacking wetly for a second before splitting along their length.  The crack goes up the height of the six-foot pumpkin until it looks on the verge of splitting in two.  Suddenly, the gap widens, strings of orangey-purple goo hanging wetly between them for a moment.  Soon, the bisected fruit falls apart, at last revealing the corrupt core.  No trace of your mammoth insemination remains.");
	outputText("\n\nStanding in the middle of the vegetational carnage is a human figure, shrouded in slime and pumpkin, but clearly alive.  Her waist-length hair shimmers, orange as the goop that drips from it as she turns to face you.  She casually brushes a wash of the filth from her head, revealing a achingly beautiful visage - pale skin, a button nose, and full, blood-red lips that glitter in the suddenly-dim light.  Burning crimson eyes lock onto you, and a voice as smooth as a razor's edge intones, \"<i>So... YOU are my savior, hrmmm?</i>\"");
	outputText("\n\nAwestruck by the sudden development, you nod mutely, not really sure if you're going to have to fight this new demon, or if this woman was righteous and somehow imprisoned in the oh-so-fuckable pumpkin.  She reads the unasked questions in your eyes and begins to answer, stepping forward with hips slowly swaying.  \"<i>I, my creamy little meal, am Fera, Goddess of Predation.</i>\"");
	outputText("\n\nThe goddess circles you, idly tracing black, claw-like nails over your exposed " + player.skin() + ".  When did she get so close?  She drops her hand low, the dagger-sharp protrusions tenderly cupping your ");
	if(player.balls > 0) outputText("[balls]");
	else outputText("base");
	outputText(" as she explains, \"<i>Almost a decade ago, my sister, Marae, bolstered by Tel'Adre's Covenant, sealed me away, bound me up in barren, lifeless soil.</i>\"  Her grip tightens, drawing a drop of blood and a wince of pain from you.  \"<i>She didn't approve of my decision to throw my lot in with Lethice's army.  The bitch always did think she knew best.</i>\"  The painful cage around your package relaxes, and she goes on, \"<i>You have no idea how hard it was to grow that pumpkin to the surface... but with your more than generous donation, you gave me the life I needed to break free.</i>\"");
	outputText("\n\nFera's pert bust catches your eye, but the most jarring thing by far is the realization that all the gunk and slime is gone.  She is cleaner and more pristine than a virgin on her wedding night.  Well, the hard red nipples and her puffy sex seem to disagree with that assumption.");
	outputText("\n\n\"<i>How should I thank my savior?  That is the human tradition, is it not?</i>\" Fera interrupts, sliding her palm along the sensitive underside of your [cock]");
	if(player.cockTotal() > 1) {
		outputText(", her free hand working ");
		if(player.cockTotal() == 2) outputText("your other");
		else outputText("another");
		outputText(" dick with child-like glee");
	}
	outputText(".  \"<i>");
	if(player.race() != "human") outputText("I know what you were, virile suitor.  ");
	outputText("There's never too much of a good thing.  Of course, my champion must have the proper train of thought...</i>\"");
	outputText("\n\nWait... what?  You start to pull back, but her grip tightens, forcing you rigid with involuntary pain.  Prickly vines boil out of the ground around your [legs] and entwine into a twisted web with the strength of iron.  In seconds, you're firmly bound up to your [chest], the only part left mobile being your poor, depleted dick.  It swings freely, controlled as effortlessly by the tainted goddess as your veridian prison.");
	outputText("\n\nFera rambles, \"<i>My sister is not so strong anymore... the planet itself has been turned to my way of thinking, just like you.</i>\"  She leans forward to kiss you, those ruby lips as smooth as glass and soft as the finest velvet.  You lose yourself in her lips, immediately kissing her back, devoting all your muscle control to passionately twisting your tongue about hers, tasting her cinnamon-sweet mouth, moist organs lapping against one another while bubbles of saliva roll between your hungry lips.  It's enough to blind you to the rising wall of verdant tentacles, at least until they touch your ears.");
	outputText("\n\nYou cry out when they slide into your ears, the slimy slickness worming into your cranium as they dribble warm lubricants everywhere.  Inch after inch of ropy green vine disappears inside you, and your first thought, aside from the panic coursing through your veins, is, \"<i>How is this even possible?</i>\"  The next one isn't nearly as cogent, as your entire body seems to light up with sensation, every inch of skin bathed in wet kisses, fragrant cunts, pillowy tits, and the occasional slippery dong.  It's an electric cacophony of pleasure like no other.  All of these sensual caresses move together, a perfectly orchestrated ballet of erotic movement timed to the rhythm of the gently thrusting ear-tentacles.");
	outputText("\n\nDimly, you feel rivulets of something sticky running down the sides of your neck, but the phantom tits smearing you with breastmilk and caressing your sensitive-as-genetalia skin are a more pressing, and arousing concern.  Fera somehow pushes through the phantom female forms to re-engage the liplock, and you happily return to frenching her, an obedient slave to her skillful techniques and mind-moulding roots.  This cavalcade of sexual hallucinations is impossible to withstand, and though silent aside from the gentle squishes of your perpetual ear-fuck, you have to admit that you enjoy it as much anything you've ever done.");
	outputText("\n\nThe pleasant numbness from the intrusion - like the blissful crest of rolling waves - sweeps everything but pleasure from your mind.  You sag into your bindings, ecstatic, melted putty awaiting its sculptor's touch.  Fera hums and breaks the kiss to look into your empty, dazed eyes, two red stars of fire that utterly fill your view.  You drool and begin to lick at an imaginary pussy, your fevered attentions wasted on empty air, though to you it as real as a wet succubus's snatch.");
	outputText("\n\nMeanwhile, you feel a pussy sliding over your [cock].  Just as it hilts you, a second set of lips, slippery internal vulva, slide down your shaft, trailing the first until they nestle up against them, leaking their drool out the first's entrance.  Stranger still, a third vagina crests your [cockHead], slithering down your turgid mast to join its sisters, and that's only the beginning.  A seemingly endless array of vaginas wraps around your cock and squeezes it with twenty different textures, all of them as soft and wet as liquid butter.  Your [cock] may as well have died and gone to heaven, for it joins the rest of you in bliss.");
	outputText("\n\nFera giggles at your expression and puts her finger in your mouth, laughing uproariously when you immediately suck it, flicking your tongue about its circumference.  Those slow, pumping tendrils have utterly fucked your mind, and there's nothing you could have done about it.  It's hellishly good, a torture of sinful, unadulterated pleasure potent enough to keep your [cock] throbbing and aching to release, even though it just did.  You would mind, if it wasn't like every single other part of you was orgasming on its own, ecstatically twitching in the firm bindings as you give yourself wholly to Fera's minions.");
	outputText("\n\nHow long it goes on you can't say.  Somewhere along the lines your memory went dark, repurposed by your coiled masters to allow you to feel even greater heights of bliss.  There's faint flashes of you thrashing, but giant-sized labia keep you pinned in place, your limbs devoured in vaginal restraint.  With a triumphant surge, bulges stretch your abused noise-holes and work deep into your skull.  Your world goes white, an orgasmic soup of delight that washes any vestiges of thought from you and leaves behind only dripping obedience to pleasure.  Your cock fires weakly, offering tribute Fera in sympathy, yet the real thing is in your cum-bathed brain.  Runny tentacle-spooge drips from your nose as you gurgle in bliss, then black out.");
	hideUpDown();
	stats(0,0,0,0,0,0,-100,0);
	doNext(pumpkinFuckPartIII);
}

function pumpkinFuckPartIII():void {
	clearOutput();
	outputText("SLAP!  The crack of a palm on your face rouses you, a red handprint left on your cheek.  Fera smirks at you as you stir woozily in your plant-woven prison.  \"<i>Did you enjoy yourself?</i>\"  You slowly nod, feeling... liberated, free.  The situation is less worrying than before.  Fera just wanted to thank you, right?");
	outputText("\n\nThe sultry orange-haired maiden ");
	if(player.balls > 0) outputText("pats your sloshing sack");
	else outputText("caresses a sensitive spot beneath your dick");
	outputText(" as the vines unwind, allowing you to stand on your own [feet].  You go to wipe the cum from your nose and upper lip as soon as you're free.  It's dry.  Did any of that even happen?");
	outputText("\n\n\"<i>I went ahead and gave you your reward.  It seemed fitting to give you a little bit more 'juice', since that was how you saved me.  My hero,</i>\" Fera explains before giving you a chaste kiss on the lips.  \"<i>You'll find yourself cumming a little harder and recovering a little faster in the future.  Now go, take what you want from the weak.  Do not disappoint me.</i>\"");
	outputText("\n\nFera disappears along with all the evidence of your encounter, her ruby lips hanging in the air for a split-second before fading as well.  You're left naked, alone with your discarded armor, lusts, and recently adjusted attitude.");
	//(+30 corrution, Fera's Boon - Alpha gained)
	outputText("\n\n(<b>Perk Gained: Fera's Boon - Alpha</b>)");
	player.createPerk("Fera's Boon - Alpha",0,0,0,0,"FUCKING SAVE EDITORS MANG");
	stats(0,0,0,0,0,0,0,30);
	doNext(13);
}

function mountPumpkin():void {
	clearOutput();
	flags[PUMPKIN_FUCK_YEAR_DONE] = date.fullYear;
	//>Yes [Player is pregnant, has low vaginal wetness, or has low fertility and is not in heat]
	if(player.pregnancyIncubation > 0 || player.wetness() < 2 || player.totalFertility() < 30) {
		outputText("Well, fuck it.  You're horny, and this little pumpkin doesn't look like it could stop you from fucking that gushing stem-rod.  As you shed your [armor], a few of the rough, slime-sweating vines feebly rise up to embrace you, but you brush them away, having no time for corrupt foolishness.  You're going to mount this fruit's hard, pulsing phallus, not let some malformed tentacle-horror molest you.");
		outputText("\n\nYou kneel down before your target and examine the leaking cock before you.  The stem is softer and smoother than human skin, hard as wood, yet oddly supple.  As soon as your fingers grace the surface of the phallic protrusion, a splash of ooze squirts from the stem to puddle at your feet.  Curiously, you stroke the pumpkin's dick with your fingers, feeling the stiff rod twitch under your fingers even as you gander at the compellingly vibrant shaft.  The air seems thick with the plant's sweet smell, and your pussy, regardless of your reason, seems as wet as a riverbed.");
		outputText("\n\nTentatively, you raise a juice-soaked fingertip to your lips and taste it.  The flavor is exactly what you would expect from a pumpkin, though it has a sweet, cinnamony aftertaste, just like the pies your village would make around harvest!  Shuddering at the memories of your distant past and budding lust, you shift position to line your [vagina] up with the hard green phallus.  Smiling at the absurdity of it all, you push downward, anticipating the slimy thickness of your pumpkin's pie goo.");
		outputText("\n\nThe gourd's oozing stem does not disappoint.  Though it lacks the warmth or heartbeat of frantic copulation with a male, the slick plant-cock is both hard and pliant.  However, the shaft seems to be pulsating against every square inch of pussy that you lower onto it, and that gentle pulsing slowly draws you down, whether you planned on going to the hilt or not.  Not that you mind - the pulsing plant seems to be doing an adequate job of stimulating your walls as it passes through your glossy gates.");
		outputText("\n\nYour [hips] slap into the orange 'skin' wetly, the omnipresent ooze immediately soaking your " + player.skin() + " with corrupted lubricant.  You hardly mind, finding your body already setting into motion as you steady your hands to either side of the heavy fruit.  The lascivious fruit doesn't show any signs of minding the fast fuck you're giving it.  Indeed, the once weakly-moving vines have stilled, their restless tremors silenced by the firm smacks of your groin against vibrant rinds and swollen lips.  You hump away at your immobile lover, spellbound by it's fecund fruit-cock, too drunk on lust and pleasure to question the strangeness of it all.");
		outputText("\n\nWet slapping noises ring out as you piston faster and faster, violently plowing the plant-cock into your [vagina] in a rutting, mating frenzy.  Your eyes are repeatedly drawn downward to the slimy shaft each time you pull up, the ooze keeping your [vagina] well lubricated.  The green shaft seems even larger than before, the phallus stretching you wider and longer each time you slam down on it as you ride the pumpkin into orgasm.  You feel a strange compulsion to let it cum inside, to flood your womb with pie goop until you appear immensely pregnant and the overflow is spraying out around your legs.");
		outputText("\n\nWith a triumphant roar, you climax and mash yourself against the pumpkin, slamming your [hips] hard enough onto the hard green shaft, that you could almost swear your cervix was penetrated.  You don't care, your vagina is clenching, the stem is flexing, and the pumpkin's ooze is gushing out, flooding your innards with pumpkin seed as you flood the pumpkin's surface with your female juices in turn.  Clenching tightly, your muscles lock, working in perfect concert with one goal; filling you up with fruity cum.  The pumpkin's thick load floods your inner folds, a deluge of sweet-smelling goop squirting deep into your [vagina], inflating you and then squirting back out mixed with your own juices.  The mixed juices are absorbed into the plant's rind almost as fast as they exit your body, though you can see a bit of glistening moisture around the base of the stem.");
		outputText("\n\nAll too soon, you finish and step away, satisfied.  The pumpkin's stem slowly stops pulsing, cutting off the worst of the slime-flow.  You get dressed, but the plant's tendrils no longer bother you.  They lie still and flat, and even the perverse sweating comes to an end.  Whatever fell magic was behind this, it seems to have settled after the pressure you relieved it of.  You get dressed and walk back to camp with a spring in your step.");
		doNext(13);
	}	
	//Female characters don't have an easy analogue to cum production unless we count milk production, and female gender doesn't require either breasts or lactation to play.  So I just went for high vaginal wetness, not pregnant, and likely to become pregnant if she had sex with a male creature.  I hope that works out OK.
	else {
		//[Player is not currently pregnant, has high vaginal wetness, and is either in heat or has high fertility]
		outputText("Well, fuck it.  You're horny, and this little pumpkin doesn't look like it could stop you from fucking that gushing stem-rod.  As you shed your [armor], a few of the rough, slime-sweating vines feebly rise up to embrace you, but you brush them away, having no time for corrupt foolishness.  You're going to mount this fruit's hard, pulsing phallus, not let some malformed tentacle-horror molest you.");
		
		outputText("\n\nYou kneel down before your target and examine the leaking cock before you.  The stem is softer and smoother than human skin, hard as wood, yet oddly supple.  As soon as your fingers grace the surface of the phallic protrusion, a splash of ooze squirts from the stem to puddle at your feet.  Curiously, you stroke the pumpkin's dick with your fingers, feeling the stiff rod twitch under your fingers even as you gander at the compellingly vibrant shaft.  The air seems thick with the plant's sweet smell, and your pussy, irregardless of your reason, seems as wet as a riverbed.");
		
		outputText("\n\nTentatively, you raise a juice-soaked fingertip to your lips and taste it.  The flavor is exactly what you would expect from a pumpkin, though it has a sweet, cinnamony aftertaste, just like the pies your village would make around harvest!  Shuddering at the memories of your distant past and budding lust, you shift position to line your [vagina] up with the hard green phallus.  Smiling at the absurdity of it all, you push downward, anticipating the slimy thickness of your pumpkin pie's goo.");
		
		outputText("\n\nThe gourd's oozing stem does not disappoint.  Though it lacks the warmth or heartbeat of frantic copulation with a male, the slick plant-cock is both hard and pliant.  However, the shaft seems to be pulsating against every square inch of pussy that you lower onto it, and that gentle pulsing slowly draws you down, whether you planned on going to the hilt or not.  Not that you mind - the pulsing plant seems to be doing an adequate job of stimulating your walls as it passes through your glossy gates.");
		
		outputText("\n\nYour [hips] slap into the orange 'skin' wetly, the omnipresent ooze immediately soak your " + player.skin() + " with corrupted lubricant.  You hardly mind, finding your body already setting into motion as you steady your hands to either side of the heavy fruit.  The lascivious fruit doesn't show any signs of minding the fast fuck you're giving it.  Indeed, the once weakly-moving vines have stilled, their restless tremors silenced by the firm smacks of your groin against vibrant rinds and swollen lips.  You hump away at your immobile lover, spellbound by it's fecund fruit-cock, too drunk on lust and pleasure to question the strangeness of it all.");
		
		outputText("\n\nWet slapping noises ring out as you piston faster and faster, violently plowing the plant-cock into your [vagina] in a rutting, mating frenzy.  Your eyes are repeatedly drawn downward to the slimy shaft each time you pull up, the ooze keeping your [vagina] well lubricated.  The green shaft seems even larger than before, the phallus stretching you wider and longer each time you slam down on it as you ride the pumpkin into orgasm.  You feel a strange compulsion to let it cum inside, to flood your womb with pie goop until you appear immensely pregnant and the overflow is spraying out around your legs.");
		
		outputText("\n\nWith a triumphant roar, you climax and mash yourself against the pumpkin, slamming your [hips] hard enough onto the hard green shaft, that you could almost swear your cervix was penetrated.  You don't care, your vagina is clenching, the stem is flexing, and the pumpkin's ooze is gushing out, flooding your innards with pumpkin seed as you flood the pumpkin's surface with your female juices in turn.  Clenching tightly, your muscles lock, working in perfect concert with one goal; filling you up with fruity cum.  The pumpkin's massive load floods your inner folds, a deluge of sweet-smelling goop squirting deep into your [vagina], inflating you until you are certain you might burst and then squirting back out mixed with your own juices even as the pumpkin starts to enlarge.  Every titanic gush from your pussy pumps the gourd up another level.  Soon, the rind has forced your [legs] into an uncomfortable position as it grows.  A few blasts later, it's lifting you from the ground, its still-spurting stem-cock lodged firmly in your cunt.  You're not sure you could pull yourself off now if you wanted to, and you don't!");
		
		outputText("\n\nOver and over the growing gourd empties its ooze into you as it seems to suck up the torrent of mixed juices that pour back out of you, inflating it larger and larger.  Even once you feel like you've cummed to the point of dehydration, your [vagina] continues to milk the pumpkin's stem of ooze and gush femspunk in return in an effort to douse EVERYTHING onto to the fluid-hungry plant.  Still, even your prodigious libido can only take so much, and once your [vagina] starts to slow in its ministrations, the stem softens just enough to let you slide off to where you can ride out the rest of your orgasm, below, on the ground.  Your descent is graceless, a lazy slide down the orange rind.  Were it not for the gentle slope, it would be a rough six-foot fall.");
		
		outputText("\n\nYou thank the gods for that small mercy as you calm down and climb to your feet, beholding the sudden gargantuan growth as if for the first time.  That pumpkin is at least six feet tall, and the swollen stem that filled you with pumpkin ooze?  It has grown with it, now a towering rod as big as an average woman's torso.  As you wonder how you managed to fit such a monstrosity inside you at the end, you notice that only a few strings of mixed pumpkin goo and female cum trail from the stem to the ground.  It looks like most of the combined fluids are vanishing into the pumpkin's depths, drank down for some purpose only demons would know.");
		
		outputText("\n\nA faint rumbling is the only warning you get (or need).  You jump back and ready yourself for anything, ");
		if(player.weaponName != "fists") outputText("picking up your [weapon]");
		else outputText("raising your guard");
		outputText(" as if it would somehow protect your nude body.");
		
		doNext(pumpkinMountingLevelII);
	}
	stats(0,0,0,0,0,0,-100,1);
}

//>Next
function pumpkinMountingLevelII():void {
	clearOutput();
	outputText("The pumpkin's titanic stem shivers, the mighty shaft trembling immensely before the pumpkin splits from the top causing it to topple.  The crack goes around the rind in multiple directions, causing it to split open like a flower as strings of orangey-purple goo hang wetly between the pieces for a moment.  A moment later, the sectioned fruit falls apart, at last revealing the corrupt core.  No trace of the mammoth copulation remains.");
	outputText("\n\nStanding in the middle of the vegetational carnage is a human figure, shrouded in slime and pumpkin, but clearly alive.  Her waist-length hair shimmers, orange as the goop that drips from it as she turns to face you.  She casually brushes a wash of the filth from her head, revealing a achingly beautiful visage - pale skin, a button nose, and full, blood-red lips that glitter in the suddenly-dim light.  Burning crimson eyes lock onto you, and a voice as smooth as a razor's edge intones, <i>\"So... YOU are my savior, hmmm?\"</i>");
	
	outputText("\n\nAwestruck by the sudden development, you nod mutely, not really sure if you're going to have to fight this new demon, or if this woman was righteous and somehow imprisoned in the oh-so-fuckable pumpkin.  She reads the unasked questions in your eyes and begins to answer, stepping forward with hips slowly swaying.  <i>\"I, my creamy little meal, am Fera, Goddess of Predation.\"</i>");
	
	outputText("\n\nThe goddess circles you idly tracing black, claw-like nails over your exposed " + player.skin() + ".  When did she get so close?  She drops her hand low, the dagger-sharp protrusions tenderly cupping your [vagina] as she explains, <i>\"Almost a decade ago, my sister, Marae, bolstered by Tel'Adre's Covenant, sealed me away, bound me up in barren, lifeless soil.\"</i>  Her grip tightens, drawing a drop of blood and a wince of pain from you.  <i>\"She didn't approve of my decision to throw in my lot with Lethice's army.  The bitch always did think she knew best.\"</i>  The painful cage around your snatch relaxes, and she goes on, <i>\"You have no idea how hard it was to grow that pumpkin to the surface... but with your more than generous action, you gave me the strength I needed to break free.\"</i>");
	
	outputText("\n\nFera's pert bust catches your eye, but the most jarring thing by far is the realization that all the gunk and slime is gone.  She is cleaner and more pristine than a virgin on her wedding night.  Well, the hard red nipples and her puffy sex seem to disagree with that assumption.");
	
	outputText("\n\n<i>\"How should I thank my savior?  That is the human tradition is it not?\"</i>  Fera interrupts, sliding her palm along the sensitive folds of your [vagina]");
	if(player.biggestTitSize() >= 2) outputText(", her free hand working your [fullChest] with glee");
	outputText(".  <i>\"There's never too much of a good thing.  Of course, my champion must have the proper train of thought...\"</i>");
	
	outputText("\n\nWait... what? You start to pull back, but her grip tightens, forcing you rigid with involuntary pain.  Prickly vines boil out of the ground around your legs and entwine into a twisted web with the strength of iron.  In seconds, you're firmly bound up to your chest, no part of you left mobile.");

	outputText("\n\nFera rambles, <i>\"My sister is not so strong anymore... the planet itself has been turned to my way of thinking, just like you.\"</i>  She leans forward to kiss you, her ruby lips as smooth as glass and soft as the finest velvet.  You lose yourself in her lips, immediately kissing her back, devoting all your muscle control to passionately twisting your tongue about hers, tasting her cinnamon-sweet mouth, moist organs lapping against one another while bubbles of saliva roll between your hungry lips.  It's enough to blind you to the rising wall of verdant tentacles, at least until they touch your ears.");

	outputText("\n\nYou cry out when they slide into your ears, the slimy slickness worming into your cranium as they dribble warm lubricants everywhere.  Inch after inch of ropy green vine disappears inside you, and your first thought, aside from the panic coursing through your veins, is <i>\"How is this even possible?\"</i>  The next one isn't nearly as cogent, as your entire body seems to light up with sensation, every inch of skin bathed in wet kisses, pulsing cocks, fragrant balls, and the occasional slippery cunt.  It's an electric cacophony of pleasure like no other.  All of these sensual caresses move together, a perfectly orchestrated ballet of erotic movement timed to the rhythm of the gently thrusting ear-tentacles.");
	
	outputText("\n\nDimly, you feel rivulets of something sticky running down the sides of your neck, but the phantom shafts smearing you with pre and caressing your sensitive-as-genetalia skin are a matter of more pressing, and arousing concern.  Fera somehow pushes through the phantom male forms to re-engage the lip-lock, and you happily return to frenching her, an obedient slave to her skillful techniques and mind-moulding roots.  This cavalcade of sexual hallucinations is impossible to withstand, and though silent aside from the gentle squishes of your perpetual ear-fuck, you have to admit that you enjoy it more than anything you've ever done.");
	
	outputText("\n\nThe pleasant numbness from the intrusion - like the blissful crest of rolling waves - sweeps everything but pleasure from your mind.  You sag into your bindings, ecstatic, melted putty awaiting its sculptor's touch.  Fera hums and breaks the kiss to look into your empty, dazed eyes, two red stars of fire that utterly fill your view.  You drool and begin to lick at an imaginary dick, your fevered attentions wasted on empty air, though to you it as real as a hard incubus's member.");
	
	outputText("\n\nMeanwhile, you feel a penis sliding into your pussy.  Just as it fills you, a second shaft, slides into your folds, trailing the first until it nestles up against it, both leaking their pre-cum out the first's tip.  Stranger still, a third rod breaches your entrance, slithering past your folds to join it's brothers, and that's only the beginning.  A seemingly endless array of penises nestle within your pussy and pulsate inside with twenty different textures, all of them as hard and strong as steel.  Your pussy may as well have died and gone to heaven, for it joins the rest of you in bliss.");
	
	outputText("\n\nFera giggles at your expression and puts her finger in your mouth, laughing uproariously when you immediately suck it, flicking your tongue about its circumference.  Those slow, pumping tendrils have utterly fucked your mind, and there's nothing you could have done about it.  It's hellishly good, a torture of sinful, unadulterated pleasure potent enough to keep your cunt drooling and aching to release, even though it just did.  You would mind, if every other part of you wasn't orgasming on its own, ecstatically twitching in the firm bindings as you give yourself wholly to Fera's minions.");
	
	outputText("\n\nHow long it goes on you can't say.  Somewhere along the lines your memory went dark, repurposed by your coiled masters to allow you to feel even greater heights of bliss.  There's faint flashes of you thrashing, but giant-sized testicles keep you pinned in place, your limbs devoured in penile restraint.  With a triumphant surge, bulges stretch your abused noise-holes and work deep into your skull.  Your world goes white, and an orgasmic soup of delight washes over you and erases any vestiges of thought from you, leaving behind only dripping obedience to pleasure.  Your pussy twitches weakly, offering tribute to Fera in sympathy, yet the real thing is in your cum-bathed brain.  Runny tentacle-spooge drips from your nose as you gurgle in bliss, then black out.");
	//>Next
	doNext(mountPumpkinsIII);
}

function mountPumpkinsIII():void {
	clearOutput();
	outputText("SLAP!  The crack of a palm on your face rouses you, a red handprint left on your cheek.  Fera smirks at you as you stir woozy in your plant-woven prison.  <i>\"Did you enjoy yourself?\"</i>  You slowly nod, feeling... liberated... free.  The situation is less worrying than before.  Fera just wanted to thank you, right?");
	outputText("\n\nThe sultry orange-haired maiden pats your sloshing sack as the vines unwind, allowing you to stand on your own feet.  You go to wipe the cum from your nose and upper lip as soon as you're free.  It's dry.  Did any of that even happen?");
	outputText("\n\n<i>\"I went ahead and gave you your reward.  It seemed fitting to enhance the power of your womb, since that was how you saved me.  My hero,\"</i> Fera explains before giving you a chaste kiss on the lips.  <i>\"You'll find yourself breeding easier and giving birth faster.  Now go, fill this world with strong offspring.  Do not disappoint me.\"</i>");
	outputText("\n\nFera disappears along with all the evidence of your encounter, her ruby lips hanging in the air for a split-second before fading as well.  You're left naked, alone with your discarded armor, urge of release, and recently adjusted attitude.");
	outputText("\n\n(<b>Perk Gained: Fera's Boon - Breeding Bitch</b>)");
	player.createPerk("Fera's Boon - Breeding Bitch",0,0,0,0,"HAXOR!");
	stats(0,0,0,0,0,0,0,30);
	doNext(13);
}

//Perk name: Fera's Boon - Breeding Bitch
//Perk description: Greatly increases fertility and doubles base pregnancy speed.
//Increases the chance that the character will get pregnant and increases the speed of the character's pregnancies. 
//Why, yes, I did copy/paste Marae's Gift - Fertility for this perk. Edit: And edited it to correct a mistake in its wording. YOU FAILED ME LAD. NOW ROT IN THE DEPTHS OF HELL.
//Edit of this guy edit : You failed like, ¾ of your tags, you're the one to talk, man.
//But I had to fix all the tags you tried to fix
//You are just as much of a failure as he is.