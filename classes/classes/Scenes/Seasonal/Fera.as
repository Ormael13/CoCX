package classes.Scenes.Seasonal {
	
	import classes.*;
	import classes.GlobalFlags.*;
	
	//const PUMPKIN_FUCK_YEAR_DONE:int = 522;
	
	public class Fera extends BaseContent 
	{
		public function Fera() {}

		public function isItHalloween():Boolean {
			return ((date.date >= 28 && date.month == 9) || (date.date < 2 && date.month == 10) || flags[kFLAGS.ITS_EVERY_DAY] > 0);
		}

		public function pumpkinFuckEncounter():void {
			clearOutput();
			awardAchievement("Pump-kin-kin-kin", kACHIEVEMENTS.HOLIDAY_HALLOWEEN_I);
			outputText("Just ahead, in the middle of the path, lies a seeming innocuous gourd - a pumpkin to be precise.  The growth is oddly out of place.  Nothing else grows on the soft animal-forged path you now tread, and the pumpkin and its vines are moist, as if wet with morning dew.  They are the only plants in the vicinity to bear such moisture, gleaming dully in the muted arboreal light.");
			if (flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE] > 0) outputText("  An old, haunting memory surfaces, and you realizes this seems... familiar.  Did you find this last year?  Yes... it could have been this very same pumpkin...");
			outputText("\n\nWhile startled by the vegetation's placement, it seems harmless enough.");
			outputText("\n\nYou advance cautiously, extremely familiar with the traps and pitfalls that all-too-often prevail in this world.  The pumpkin's rind is bright orange, ripe and seemingly ready to bulge out.  The vines are thick, dark green, and reflective, partly thanks to the oozing moisture that drips from them to the floor.  After closing, it becomes clear that it isn't a coating of dew on the pumpkin but thick, viscous slime instead.  The clear, syrupy ooze begins to drip from the vines even as it rolls down the pumpkin, seeping out of the plant's skin in fat, heavy rivulets.");
			var fuck:Function = null;
			var mount:Function = null;
			if (player.hasCock()) {
				outputText("\n\nOne of the many indentations that mar the sphere's circumference seems deeper, darker than the others.  You lean a little closer, for a better look, and the shadowed fold ripples, then undulates, yawning wider and wider to reveal whole new shades of inky blackness.  It squelches, and a wide streamer of slime oozes out to slide down the side of the rind.  The puddle below the obviously tainted gord deepens with this new addition even as the wide-open rent widens.  A sweet, fruity smell rises from the opening, splattering out with a fresh wave of goop. This time, the passed slime leaves something different behind.\n\nWhere once the pumpkin had a midnight-black crevasse, it now has a fleshy, purplish gash.  The slime it exudes is more a fragrant nectar.  The rind around the opening appears cushy, and soft.  Best of all, the interior is as pink as any pussy you've ever seen, and as wet as a succubus's snatch.  You take a deep breath of the fruit's female musk and find yourself wondering: should you fuck it?");
				fuck = pumpkinFuck;
			}
			/* UNUSED DUE TO FEN LAZINESS {PC has tits}{NIPNUMBER} of the corrupted growth's vines rise up, slowly waving, snake-like in the air.  As if hypnotized, they lazily bob back and forth, drawing a few inches closer at the culmination of each movement.  You ready your [weapon], reading to defend yourself, but the slimy green tentacles pause at the new development, their tips opening to reveal plush green lips and slobbery purple tongues.  They lick at their lips, hungrily watching your {allChest] and waiting, biding their time.  They seem hungry for tits, and at the sight you feel your burgeoning milk readying to let down.  You could feed the plant, if you want to.  The idea is oddly compelling.  Do you?*/
			//Chick sauce
			if (player.hasVagina()) {
				outputText("\n\nThe stem of the pumpkin is long and proud, as well as knotted, barbed, ribbed, and flared like someone crafted the world's most perverted dildo to simultaneously resemble every type of cock in existence.  The tip bubbles constantly with slime like pre-cum oozing out of an erect phallus.");
				outputText("\n\nAs you gaze upon the stem, you can see it twitching like an actual penis and the aroma that comes from it is as enticing as what any incubus could produce.  You take a deep breath of the fruit's musk and find yourself wondering: should you mount it?");
				mount = mountPumpkin;
			}
			if (player.gender == 3) outputText("\n\nSo many choices, so little time.");
			//If PC has neither
			if (player.gender == 0) {
				outputText("\n\nOdd as it is, it doesn't seem to react as you look it over.  You avoid it, for now.");
				doNext(camp.returnToCampUseOneHour);
			}
			simpleChoices("Fuck It", fuck, "Mount It", mount, "", null, "", null, "No Way", camp.returnToCampUseOneHour);
			//addButton(3, "Smash It", pumpkinSmash);
		}

		//Unfinished scene.
		public function pumpkinSmash():void {
			clearOutput();
			outputText("You have no idea but to be safe, you pick up the pumpkin and throw the pumpkin at the tree, shattering the pumpkins into several pieces.");
			outputText("\n\nAs you walk away, you are interrupted by someone.");
			doNext(pumpkinFuckPartII);
		}

		//[HOLY SHIT YOU BE FUCKING A PUMPKIN]
		public function pumpkinFuck():void {
			clearOutput();
			flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE] = date.fullYear;
			outputText("Well, fuck it.  You're horny, and this little pumpkin doesn't look like it could stop you from fucking that gushing gourd-pussy.  As you shed your [armor], a few of the rough, slime-sweating vines feebly rise up to embrace you, but you brush them away, having no time for corrupt foolishness.  You're going to bust a nut in this fruit's sweet, supple folds, not let some malformed tentacle-horror molest you.");
			outputText("\n\nYou kneel down before your target and examine the leaky orifice before you.  The rind around the opening is softer and smoother than human skin, yet oddly supple.  As soon as your fingers grace the surface of the moist fruit, a splash of ooze squirts from the gash to puddle at your [feet].  Curiously, you open the pumpkin's pussy with your fingers, feeling the slick wet walls trying to envelop your digits even as you gander at the compellingly vibrant interior.  The air seems thick with the plant's sweet smell, and [eachCock], regardless of your reason, seems hard as stone and painfully erect.");
			outputText("\n\nTentatively, you raise one of your juice-soaked fingertips to your lips and taste it.  The flavor is as you would expect from a pumpkin, though it has a sweet, cinnamony aftertaste, just like the pies your village would make around harvest!  Shuddering at the memories of your distant past and budding lust, you shift position to line your [cock biggest] up with the lurid purple plant-pussy.  Smiling at the absurdity of it all, you push forward, anticipating the slimy tightness of your pumpkin's pie.");
			outputText("\n\nThe gushy gourd's interior does not disappoint.  Though it lacks the warmth or heartbeat of frantic copulation with a female, the slick plant-pussy is incredibly soft and pliant.  However, the walls seem to be squeezing against every square inch of dick that you yield to them, and a gentle suction slowly drags you in, whether you planned on going ");
			if (player.balls > 0) outputText("balls deep ");
			else outputText("hilt deep ");
			outputText("or not.  Not that you mind - the swollen labia seem to be doing an adequate job of smooching all over your shaft as it passes through their glossy gates.");
			if (player.cocks[0].cockLength >= 20) outputText("  After you've fed over a foot of your [cock biggest] into the gluttonous gourd, you briefly wonder where it's all going.  The pumpkin can't be more than a foot and a half across, yet it's sucking down the second foot now, and you have yet to hit any wall!  The suction suddenly increases, yanking you deeper, faster, and you forget all about the whys, whens, and whatevers.  It feels great.");
			outputText("\n\n");
			if (player.balls > 0) outputText("Your [balls] slap");
			else outputText("Your groin slaps");
			outputText(" into the orange 'skin' wetly, the omnipresent ooze immediately soaking your " + player.skinFurScales() + " with corrupted lubricant.  You hardly mind, finding your hips already setting into motion as you steady your hands to either side of the heavy fruit.  The lascivious fruit doesn't show any signs of minding the fast fuck you're giving it.  Indeed, the once weakly-moving vines have stilled, their restless tremors silenced by the firm smacks of your groin against vibrant rind and swollen lips.  You hump away at your immobile lover, spellbound by its fecund fruit-cunt, too drunk on lust and pleasure to question the strangeness of it all.");
			outputText("\n\n'Slap-slap-slapslapslapslap' rings out as you piston faster and faster, violently plowing the plant's pussy in a rutting, mating frenzy.  Your eyes are repeatedly drawn downward to the slimy hole each time you pull out, the suction keeping your [cock biggest] as hard as absolutely possible.  The purple-lipped pussy seems even larger than before, the vulva monumentally swollen, a thick pillow for you to slam into as you ride the pumpkin into orgasm.  You feel a strange compulsion to cum inside, to flood the gourd with white goo until it sprays out around your [legs].");
			outputText("\n\nWith a triumphant roar, you climax and mash yourself against the pumpkin, slamming your [hips] hard enough into the pillow-like pussy that its mysteriously copious lube is squirted in every direction.  You don't care, your [cock biggest] is flexing, your urethra is dilating, and your cum is boiling out, flooding the pumpkin's innards in white goo.  Clenching tightly, your muscles lock, working in perfect concert with one goal: filling this fruit with cum.  ");
			if (player.cumQ() < 200) outputText("Your weak load disappears into the plant's sucking gullet, wicked away as fast as you fire.");
			else if (player.cumQ() < 1000) outputText("Your thick load disappears into the plant's sucking gullet almost as fast as you're firing it, though you can see a bit of white creampie forming around the edges of your cock.");
			else {
				outputText("Your massive load floods the pumping, a deluge of semen squirting around your [cock biggest] even as the pumpkin starts to enlarge.  Every titanic spooge-squirt pumps the gourd up another level.  Soon, the rind is rubbing your belly.  A few blasts later, it's lifting you from the ground, your still-spurting cock lodged firmly in its cunt.  The suction feels so much stronger now - you're not sure you could pull out now if you wanted to, and you don't!");
			}
			if (player.cumQ() < 1000) {
				outputText("\n\nAll too soon, you finish and step away, satisfied.  The pumpkin's pussy seals closed slowly, cutting off the worst of the slime-flow.  You get dressed, but the plant's tendrils no longer bother you.  They lie still and flat, and even the perverse sweating comes to an end.  Whatever fel magic was behind this, it seems to have settled after the salty snack you gave it.  You get dressed and walk back to camp with a spring in your step.");
				player.orgasm();
				dynStats("cor", 2);
				doNext(camp.returnToCampUseOneHour);
			}
			else {
				outputText("\n\nOver and over you empty your [balls] into the growing gourd, inflating it larger and larger, passionately giving up every drop of sperm to fuel its unnatural growth.  Even once you feel empty, your [cock biggest] continues to clench and pump, firing blanks in an effort to feed EVERYTHING to the semen-hungry plant.  Still, even your prodigious virility can only take so much, and once your dick starts to go soft inside the massive cunt, it releases you, allowing you to ride out the rest of your orgasm, below, on the ground.  Your descent is graceless, a lazy slide down the orange rind.  Were it not for the gentle slope, it would be a dangerous six-foot fall.");
				outputText("\n\nYou thank the gods for that small mercy as you calm down and climb to your feet, beholding the sudden gargantuan growth as if for the first time.  That pumpkin is at least six feet tall, and the swollen pussy that devoured your cum?  It has grown with it, now a gash big enough to devour a man.  A few strings of semen trail from the labia to the ground, but it looks like most of your cum is vanishing into the pumpkin's depths, drank down for some purpose only the demons would know.");
				outputText("\n\nA faint rumbling is the only warning you get (or need).  You jump back and ready yourself for anything, ");
				if (player.weaponName == "fists") outputText("brandishing your fists");
				else outputText("picking up your [weapon]");
				outputText(" as if it would somehow protect your nude body.");
				doNext(pumpkinFuckPartII);
				player.orgasm();
				dynStats("cor", 2);
			}
		}
		//[Next]
		public function pumpkinFuckPartII():void {
			clearOutput();
			outputText("The titanic rent shivers, flaps of fruit-flesh smacking wetly for a second before splitting along their length.  The crack goes up the height of the six-foot pumpkin until it looks on the verge of splitting in two.  Suddenly, the gap widens, strings of orangey-purple goo hanging wetly between them for a moment.  Soon, the bisected fruit falls apart, at last revealing the corrupt core.  No trace of your mammoth insemination remains.");
			outputText("\n\nStanding in the middle of the vegetational carnage is a human figure, shrouded in slime and pumpkin, but clearly alive.  Her waist-length hair shimmers, orange as the goop that drips from it as she turns to face you.  She casually brushes a wash of the filth from her head, revealing a achingly beautiful visage - pale skin, a button nose, and full, blood-red lips that glitter in the suddenly-dim light.  Burning crimson eyes lock onto you, and a voice as smooth as a razor's edge intones, \"<i>So... YOU are my savior, hrmmm?</i>\"");
			outputText("\n\nAwestruck by the sudden development, you nod mutely, not really sure if you're going to have to fight this new demon, or if this woman was righteous and somehow imprisoned in the oh-so-fuckable pumpkin.  She reads the unasked questions in your eyes and begins to answer, stepping forward with hips slowly swaying.  \"<i>I, my creamy little meal, am Fera, Goddess of Predation.</i>\"");
			outputText("\n\nThe goddess circles you, idly tracing black, claw-like nails over your exposed " + player.skin() + ".  When did she get so close?  She drops her hand low, the dagger-sharp protrusions tenderly cupping your ");
			if (player.balls > 0) outputText("[balls]");
			else outputText("base");
			outputText(" as she explains, \"<i>Almost a decade ago, my sister, Marae, bolstered by Tel'Adre's Covenant, sealed me away, bound me up in barren, lifeless soil.</i>\"  Her grip tightens, drawing a drop of blood and a wince of pain from you.  \"<i>She didn't approve of my decision to throw my lot in with Lethice's army.  The bitch always did think she knew best.</i>\"  The painful cage around your package relaxes, and she goes on, \"<i>You have no idea how hard it was to grow that pumpkin to the surface... but with your more than generous donation, you gave me the life I needed to break free.</i>\"");
			outputText("\n\nFera's pert bust catches your eye, but the most jarring thing by far is the realization that all the gunk and slime is gone.  She is cleaner and more pristine than a virgin on her wedding night.  Well, the hard red nipples and her puffy sex seem to disagree with that assumption.");
			outputText("\n\n\"<i>How should I thank my savior?  That is the human tradition, is it not?</i>\" Fera interrupts, sliding her palm along the sensitive underside of your [cock]");
			if (player.cockTotal() > 1) {
				outputText(", her free hand working ");
				if (player.cockTotal() == 2) outputText("your other");
				else outputText("another");
				outputText(" dick with child-like glee");
			}
			outputText(".  \"<i>");
			if (player.race() != "human") outputText("I know what you were, virile suitor.  ");
			outputText("There's never too much of a good thing.  Of course, my champion must have the proper train of thought...</i>\"");
			outputText("\n\nWait... what?  You start to pull back, but her grip tightens, forcing you rigid with involuntary pain.  Prickly vines boil out of the ground around your [legs] and entwine into a twisted web with the strength of iron.  In seconds, you're firmly bound up to your [chest], the only part left mobile being your poor, depleted dick.  It swings freely, controlled as effortlessly by the tainted goddess as your veridian prison.");
			outputText("\n\nFera rambles, \"<i>My sister is not so strong anymore... the planet itself has been turned to my way of thinking, just like you.</i>\"  She leans forward to kiss you, those ruby lips as smooth as glass and soft as the finest velvet.  You lose yourself in her lips, immediately kissing her back, devoting all your muscle control to passionately twisting your tongue about hers, tasting her cinnamon-sweet mouth, moist organs lapping against one another while bubbles of saliva roll between your hungry lips.  It's enough to blind you to the rising wall of verdant tentacles, at least until they touch your ears.");
			outputText("\n\nYou cry out when they slide into your ears, the slimy slickness worming into your cranium as they dribble warm lubricants everywhere.  Inch after inch of ropy green vine disappears inside you, and your first thought, aside from the panic coursing through your veins, is, \"<i>How is this even possible?</i>\"  The next one isn't nearly as cogent, as your entire body seems to light up with sensation, every inch of skin bathed in wet kisses, fragrant cunts, pillowy tits, and the occasional slippery dong.  It's an electric cacophony of pleasure like no other.  All of these sensual caresses move together, a perfectly orchestrated ballet of erotic movement timed to the rhythm of the gently thrusting ear-tentacles.");
			outputText("\n\nDimly, you feel rivulets of something sticky running down the sides of your neck, but the phantom tits smearing you with breastmilk and caressing your sensitive-as-genetalia skin are a more pressing, and arousing concern.  Fera somehow pushes through the phantom female forms to re-engage the liplock, and you happily return to frenching her, an obedient slave to her skillful techniques and mind-molding roots.  This cavalcade of sexual hallucinations is impossible to withstand, and though silent aside from the gentle squishes of your perpetual ear-fuck, you have to admit that you enjoy it as much anything you've ever done.");
			outputText("\n\nThe pleasant numbness from the intrusion - like the blissful crest of rolling waves - sweeps everything but pleasure from your mind.  You sag into your bindings, ecstatic, melted putty awaiting its sculptor's touch.  Fera hums and breaks the kiss to look into your empty, dazed eyes, two red stars of fire that utterly fill your view.  You drool and begin to lick at an imaginary pussy, your fevered attentions wasted on empty air, though to you it as real as a wet succubus's snatch.");
			outputText("\n\nMeanwhile, you feel a pussy sliding over your [cock].  Just as it hilts you, a second set of lips, slippery internal vulva, slide down your shaft, trailing the first until they nestle up against them, leaking their drool out the first's entrance.  Stranger still, a third vagina crests your [cockHead], slithering down your turgid mast to join its sisters, and that's only the beginning.  A seemingly endless array of vaginas wraps around your cock and squeeze it with twenty different textures, all of them as soft and wet as liquid butter.  Your [cock] may as well have died and gone to heaven, for it joins the rest of you in bliss.");
			outputText("\n\nFera giggles at your expression and puts her finger in your mouth, laughing uproariously when you immediately suck it, flicking your tongue about its circumference.  Those slow, pumping tendrils have utterly fucked your mind, and there's nothing you could have done about it.  It's hellishly good, a torture of sinful, unadulterated pleasure potent enough to keep your [cock] throbbing and aching to release, even though it just did.  You would mind, if it wasn't like every single other part of you was orgasming on its own, ecstatically twitching in the firm bindings as you give yourself wholly to Fera's minions.");
			outputText("\n\nHow long it goes on you can't say.  Somewhere along the lines your memory went dark, repurposed by your coiled masters to allow you to feel even greater heights of bliss.  There's faint flashes of you thrashing, but giant-sized labia keep you pinned in place, your limbs devoured in vaginal restraint.  With a triumphant surge, bulges stretch your abused noise-holes and work deep into your skull.  Your world goes white, an orgasmic soup of delight that washes any vestiges of thought from you and leaves behind only dripping obedience to pleasure.  Your cock fires weakly, offering tribute Fera in sympathy, yet the real thing is in your cum-bathed brain.  Runny tentacle-spooge drips from your nose as you gurgle in bliss, then black out.");
			hideUpDown();
			player.orgasm();
			doNext(pumpkinFuckPartIII);
		}

		public function pumpkinFuckPartIII():void {
			clearOutput();
			outputText("SLAP!  The crack of a palm on your face rouses you, a red handprint left on your cheek.  Fera smirks at you as you stir woozily in your plant-woven prison.  \"<i>Did you enjoy yourself?</i>\"  You slowly nod, feeling... liberated, free.  The situation is less worrying than before.  Fera just wanted to thank you, right?");
			outputText("\n\nThe sultry orange-haired maiden ");
			if (player.balls > 0) outputText("pats your sloshing sack");
			else outputText("caresses a sensitive spot beneath your dick");
			outputText(" as the vines unwind, allowing you to stand on your own [feet].  You go to wipe the cum from your nose and upper lip as soon as you're free.  It's dry.  Did any of that even happen?");
			outputText("\n\n\"<i>I went ahead and gave you your reward.  It seemed fitting to give you a little bit more 'juice', since that was how you saved me.  My hero,</i>\" Fera explains before giving you a chaste kiss on the lips.  \"<i>You'll find yourself cumming a little harder and recovering a little faster in the future.  Now go, take what you want from the weak.  Do not disappoint me.</i>\"");
			outputText("\n\nFera disappears along with all the evidence of your encounter, her ruby lips hanging in the air for a split-second before fading as well.  You're left naked, alone with your discarded armor, lusts, and recently adjusted attitude.");
			//(+30 corrution, Fera's Boon - Alpha gained)
			outputText("\n\n(<b>Perk Gained: Fera's Boon - Alpha</b>)");
			player.createPerk(PerkLib.FerasBoonAlpha,0,0,0,0);
			dynStats("cor", 30);
			doNext(camp.returnToCampUseOneHour);
		}

		public function mountPumpkin():void {
			clearOutput();
			flags[kFLAGS.PUMPKIN_FUCK_YEAR_DONE] = date.fullYear;
			//>Yes [Player is pregnant, has low vaginal wetness, or has low fertility and is not in heat]
			if (player.pregnancyIncubation > 0 || (player.wetness() < 2 && player.totalFertility() < 30)) {
				outputText("Well, fuck it.  You're horny, and this little pumpkin doesn't look like it could stop you from fucking that gushing stem-rod.  As you shed your [armor], a few of the rough, slime-sweating vines feebly rise up to embrace you, but you brush them away, having no time for corrupt foolishness.  You're going to mount this fruit's hard, pulsing phallus, not let some malformed tentacle-horror molest you.");
				outputText("\n\nYou kneel down before your target and examine the leaking cock before you.  The stem is softer and smoother than human skin, hard as wood, yet oddly supple.  As soon as your fingers grace the surface of the phallic protrusion, a splash of ooze squirts from the stem to puddle at your feet.  Curiously, you stroke the pumpkin's dick with your fingers, feeling the stiff rod twitch under your fingers even as you gander at the compellingly vibrant shaft.  The air seems thick with the plant's sweet smell, and your pussy, regardless of your reason, seems as wet as a riverbed.");
				outputText("\n\nTentatively, you raise a juice-soaked fingertip to your lips and taste it.  The flavor is exactly what you would expect from a pumpkin, though it has a sweet, cinnamony aftertaste, just like the pies your village would make around harvest!  Shuddering at the memories of your distant past and budding lust, you shift position to line your [vagina] up with the hard green phallus.  Smiling at the absurdity of it all, you push downward, anticipating the slimy thickness of your pumpkin's pie goo.\n\n");
				(player as Player).cuntChange(50, true, false, false);
				outputText("\n\nThe gourd's oozing stem does not disappoint.  Though it lacks the warmth or heartbeat of frantic copulation with a male, the slick plant-cock is both hard and pliant.  However, the shaft seems to be pulsating against every square inch of pussy that you lower onto it, and that gentle pulsing slowly draws you down, whether you planned on going to the hilt or not.  Not that you mind - the pulsing plant seems to be doing an adequate job of stimulating your walls as it passes through your glossy gates.");
				outputText("\n\nYour [hips] slap into the orange 'skin' wetly, the omnipresent ooze immediately soaking your " + player.skin() + " with corrupted lubricant.  You hardly mind, finding your body already setting into motion as you steady your hands to either side of the heavy fruit.  The lascivious fruit doesn't show any signs of minding the fast fuck you're giving it.  Indeed, the once weakly-moving vines have stilled, their restless tremors silenced by the firm smacks of your groin against vibrant rinds and swollen lips.  You hump away at your immobile lover, spellbound by its fecund fruit-cock, too drunk on lust and pleasure to question the strangeness of it all.");
				outputText("\n\nWet slapping noises ring out as you piston faster and faster, violently plowing the plant-cock into your [vagina] in a rutting, mating frenzy.  Your eyes are repeatedly drawn downward to the slimy shaft each time you pull up, the ooze keeping your [vagina] well lubricated.  The green shaft seems even larger than before, the phallus stretching you wider and longer each time you slam down on it as you ride the pumpkin into orgasm.  You feel a strange compulsion to let it cum inside, to flood your womb with pie goop until you appear immensely pregnant and the overflow is spraying out around your legs.");
				outputText("\n\nWith a triumphant roar, you climax and mash yourself against the pumpkin, slamming your [hips] hard enough onto the hard green shaft, that you could almost swear your cervix was penetrated.  You don't care, your vagina is clenching, the stem is flexing, and the pumpkin's ooze is gushing out, flooding your innards with pumpkin seed as you flood the pumpkin's surface with your female juices in turn.  Clenching tightly, your muscles lock, working in perfect concert with one goal; filling you up with fruity cum.  The pumpkin's thick load floods your inner folds, a deluge of sweet-smelling goop squirting deep into your [vagina], inflating you and then squirting back out mixed with your own juices.  The mixed juices are absorbed into the plant's rind almost as fast as they exit your body, though you can see a bit of glistening moisture around the base of the stem.");
				outputText("\n\nAll too soon, you finish and step away, satisfied.  The pumpkin's stem slowly stops pulsing, cutting off the worst of the slime-flow.  You get dressed, but the plant's tendrils no longer bother you.  They lie still and flat, and even the perverse sweating comes to an end.  Whatever fell magic was behind this, it seems to have settled after the pressure you relieved it of.  You get dressed and walk back to camp with a spring in your step.");
				doNext(camp.returnToCampUseOneHour);
			}	
			//Female characters don't have an easy analogue to cum production unless we count milk production, and female gender doesn't require either breasts or lactation to play.  So I just went for high vaginal wetness, not pregnant, and likely to become pregnant if she had sex with a male creature.  I hope that works out OK.
			else {
				//[Player is not currently pregnant, has high vaginal wetness, and is either in heat or has high fertility]
				outputText("Well, fuck it.  You're horny, and this little pumpkin doesn't look like it could stop you from fucking that gushing stem-rod.  As you shed your [armor], a few of the rough, slime-sweating vines feebly rise up to embrace you, but you brush them away, having no time for corrupt foolishness.  You're going to mount this fruit's hard, pulsing phallus, not let some malformed tentacle-horror molest you.");
				
				outputText("\n\nYou kneel down before your target and examine the leaking cock before you.  The stem is softer and smoother than human skin, hard as wood, yet oddly supple.  As soon as your fingers grace the surface of the phallic protrusion, a splash of ooze squirts from the stem to puddle at your feet.  Curiously, you stroke the pumpkin's dick with your fingers, feeling the stiff rod twitch under your fingers even as you gander at the compellingly vibrant shaft.  The air seems thick with the plant's sweet smell, and your pussy, regardless of your reason, seems as wet as a riverbed.");
				
				outputText("\n\nTentatively, you raise a juice-soaked fingertip to your lips and taste it.  The flavor is exactly what you would expect from a pumpkin, though it has a sweet, cinnamony aftertaste, just like the pies your village would make around harvest!  Shuddering at the memories of your distant past and budding lust, you shift position to line your [vagina] up with the hard green phallus.  Smiling at the absurdity of it all, you push downward, anticipating the slimy thickness of your pumpkin pie's goo.");
				
				outputText("\n\nThe gourd's oozing stem does not disappoint.  Though it lacks the warmth or heartbeat of frantic copulation with a male, the slick plant-cock is both hard and pliant.  However, the shaft seems to be pulsating against every square inch of pussy that you lower onto it, and that gentle pulsing slowly draws you down, whether you planned on going to the hilt or not.  Not that you mind - the pulsing plant seems to be doing an adequate job of stimulating your walls as it passes through your glossy gates.");
				
				outputText("\n\nYour [hips] slap into the orange 'skin' wetly, the omnipresent ooze immediately soak your " + player.skin() + " with corrupted lubricant.  You hardly mind, finding your body already setting into motion as you steady your hands to either side of the heavy fruit.  The lascivious fruit doesn't show any signs of minding the fast fuck you're giving it.  Indeed, the once weakly-moving vines have stilled, their restless tremors silenced by the firm smacks of your groin against vibrant rinds and swollen lips.  You hump away at your immobile lover, spellbound by its fecund fruit-cock, too drunk on lust and pleasure to question the strangeness of it all.");
				
				outputText("\n\nWet slapping noises ring out as you piston faster and faster, violently plowing the plant-cock into your [vagina] in a rutting, mating frenzy.  Your eyes are repeatedly drawn downward to the slimy shaft each time you pull up, the ooze keeping your [vagina] well lubricated.  The green shaft seems even larger than before, the phallus stretching you wider and longer each time you slam down on it as you ride the pumpkin into orgasm.  You feel a strange compulsion to let it cum inside, to flood your womb with pie goop until you appear immensely pregnant and the overflow is spraying out around your legs.");
				
				outputText("\n\nWith a triumphant roar, you climax and mash yourself against the pumpkin, slamming your [hips] hard enough onto the hard green shaft, that you could almost swear your cervix was penetrated.  You don't care, your vagina is clenching, the stem is flexing, and the pumpkin's ooze is gushing out, flooding your innards with pumpkin seed as you flood the pumpkin's surface with your female juices in turn.  Clenching tightly, your muscles lock, working in perfect concert with one goal; filling you up with fruity cum.  The pumpkin's massive load floods your inner folds, a deluge of sweet-smelling goop squirting deep into your [vagina], inflating you until you are certain you might burst and then squirting back out mixed with your own juices even as the pumpkin starts to enlarge.  Every titanic gush from your pussy pumps the gourd up another level.  Soon, the rind has forced your [legs] into an uncomfortable position as it grows.  A few blasts later, it's lifting you from the ground, its still-spurting stem-cock lodged firmly in your cunt.  You're not sure you could pull yourself off now if you wanted to, and you don't!");
				
				outputText("\n\nOver and over the growing gourd empties its ooze into you as it seems to suck up the torrent of mixed juices that pour back out of you, inflating it larger and larger.  Even once you feel like you've cummed to the point of dehydration, your [vagina] continues to milk the pumpkin's stem of ooze and gush femspunk in return in an effort to douse EVERYTHING onto to the fluid-hungry plant.  Still, even your prodigious libido can only take so much, and once your [vagina] starts to slow in its ministrations, the stem softens just enough to let you slide off to where you can ride out the rest of your orgasm, below, on the ground.  Your descent is graceless, a lazy slide down the orange rind.  Were it not for the gentle slope, it would be a rough six-foot fall.");
				
				outputText("\n\nYou thank the gods for that small mercy as you calm down and climb to your feet, beholding the sudden gargantuan growth as if for the first time.  That pumpkin is at least six feet tall, and the swollen stem that filled you with pumpkin ooze?  It has grown with it, now a towering rod as big as an average woman's torso.  As you wonder how you managed to fit such a monstrosity inside you at the end, you notice that only a few strings of mixed pumpkin goo and female cum trail from the stem to the ground.  It looks like most of the combined fluids are vanishing into the pumpkin's depths, drank down for some purpose only demons would know.");
				
				outputText("\n\nA faint rumbling is the only warning you get (or need).  You jump back and ready yourself for anything, ");
				if (player.weaponName != "fists") outputText("picking up your [weapon]");
				else outputText("raising your guard");
				outputText(" as if it would somehow protect your nude body.");
				
				doNext(pumpkinMountingLevelII);
			}
			player.orgasm();
			dynStats("cor", 1);
		}

		//>Next
		public function pumpkinMountingLevelII():void {
			clearOutput();
			outputText("The pumpkin's titanic stem shivers, the mighty shaft trembling immensely before the pumpkin splits from the top causing it to topple.  The crack goes around the rind in multiple directions, causing it to split open like a flower as strings of orangey-purple goo hang wetly between the pieces for a moment.  A moment later, the sectioned fruit falls apart, at last revealing the corrupt core.  No trace of the mammoth copulation remains.");
			outputText("\n\nStanding in the middle of the vegetational carnage is a human figure, shrouded in slime and pumpkin, but clearly alive.  Her waist-length hair shimmers, orange as the goop that drips from it as she turns to face you.  She casually brushes a wash of the filth from her head, revealing a achingly beautiful visage - pale skin, a button nose, and full, blood-red lips that glitter in the suddenly-dim light.  Burning crimson eyes lock onto you, and a voice as smooth as a razor's edge intones, <i>\"So... YOU are my savior, hmmm?\"</i>");
			
			outputText("\n\nAwestruck by the sudden development, you nod mutely, not really sure if you're going to have to fight this new demon, or if this woman was righteous and somehow imprisoned in the oh-so-fuckable pumpkin.  She reads the unasked questions in your eyes and begins to answer, stepping forward with hips slowly swaying.  <i>\"I, my creamy little meal, am Fera, Goddess of Predation.\"</i>");
			
			outputText("\n\nThe goddess circles you idly tracing black, claw-like nails over your exposed " + player.skin() + ".  When did she get so close?  She drops her hand low, the dagger-sharp protrusions tenderly cupping your [vagina] as she explains, <i>\"Almost a decade ago, my sister, Marae, bolstered by Tel'Adre's Covenant, sealed me away, bound me up in barren, lifeless soil.\"</i>  Her grip tightens, drawing a drop of blood and a wince of pain from you.  <i>\"She didn't approve of my decision to throw in my lot with Lethice's army.  The bitch always did think she knew best.\"</i>  The painful cage around your snatch relaxes, and she goes on, <i>\"You have no idea how hard it was to grow that pumpkin to the surface... but with your more than generous action, you gave me the strength I needed to break free.\"</i>");
			
			outputText("\n\nFera's pert bust catches your eye, but the most jarring thing by far is the realization that all the gunk and slime is gone.  She is cleaner and more pristine than a virgin on her wedding night.  Well, the hard red nipples and her puffy sex seem to disagree with that assumption.");
			
			outputText("\n\n<i>\"How should I thank my savior?  That is the human tradition is it not?\"</i>  Fera interrupts, sliding her palm along the sensitive folds of your [vagina]");
			if (player.biggestTitSize() >= 2) outputText(", her free hand working your [fullChest] with glee");
			outputText(".  <i>\"There's never too much of a good thing.  Of course, my champion must have the proper train of thought...\"</i>");
			
			outputText("\n\nWait... what? You start to pull back, but her grip tightens, forcing you rigid with involuntary pain.  Prickly vines boil out of the ground around your legs and entwine into a twisted web with the strength of iron.  In seconds, you're firmly bound up to your chest, no part of you left mobile.");

			outputText("\n\nFera rambles, <i>\"My sister is not so strong anymore; the planet itself has been turned to my way of thinking, just like you.\"</i>  She leans forward to kiss you, her ruby lips as smooth as glass and soft as the finest velvet.  You lose yourself in her lips, immediately kissing her back, devoting all your muscle control to passionately twisting your tongue about hers, tasting her cinnamon-sweet mouth, moist organs lapping against one another while bubbles of saliva roll between your hungry lips.  It's enough to blind you to the rising wall of verdant tentacles, at least until they touch your ears.");

			outputText("\n\nYou cry out when they slide into your ears, the slimy slickness worming into your cranium as they dribble warm lubricants everywhere.  Inch after inch of ropy green vine disappears inside you, and your first thought, aside from the panic coursing through your veins, is <i>\"How is this even possible?\"</i>  The next one isn't nearly as cogent, as your entire body seems to light up with sensation, every inch of skin bathed in wet kisses, pulsing cocks, fragrant balls, and the occasional slippery cunt.  It's an electric cacophony of pleasure like no other.  All of these sensual caresses move together, a perfectly orchestrated ballet of erotic movement timed to the rhythm of the gently thrusting ear-tentacles.");
			
			outputText("\n\nDimly, you feel rivulets of something sticky running down the sides of your neck, but the phantom shafts smearing you with pre and caressing your sensitive-as-genetalia skin are a matter of more pressing, and arousing concern.  Fera somehow pushes through the phantom male forms to re-engage the lip-lock, and you happily return to frenching her, an obedient slave to her skillful techniques and mind-moulding roots.  This cavalcade of sexual hallucinations is impossible to withstand, and though silent aside from the gentle squishes of your perpetual ear-fuck, you have to admit that you enjoy it more than anything you've ever done.");
			
			outputText("\n\nThe pleasant numbness from the intrusion - like the blissful crest of rolling waves - sweeps everything but pleasure from your mind.  You sag into your bindings, ecstatic, melted putty awaiting its sculptor's touch.  Fera hums and breaks the kiss to look into your empty, dazed eyes, two red stars of fire that utterly fill your view.  You drool and begin to lick at an imaginary dick, your fevered attentions wasted on empty air, though to you it's as real as a hard incubus's member.");
			
			outputText("\n\nMeanwhile, you feel a penis sliding into your pussy.  Just as it fills you, a second shaft, slides into your folds, trailing the first until it nestles up against it, both leaking their pre-cum out the first's tip.  Stranger still, a third rod breaches your entrance, slithering past your folds to join it's brothers, and that's only the beginning.  A seemingly endless array of penises nestle within your pussy and pulsate inside with twenty different textures, all of them as hard and strong as steel.  Your pussy may as well have died and gone to heaven, for it joins the rest of you in bliss.");
			
			outputText("\n\nFera giggles at your expression and puts her finger in your mouth, laughing uproariously when you immediately suck it, flicking your tongue about its circumference.  Those slow, pumping tendrils have utterly fucked your mind, and there's nothing you could have done about it.  It's hellishly good, a torture of sinful, unadulterated pleasure potent enough to keep your cunt drooling and aching to release, even though it just did.  You would mind, if every other part of you wasn't orgasming on its own, ecstatically twitching in the firm bindings as you give yourself wholly to Fera's ministrations.");
			
			outputText("\n\nHow long it goes on you can't say.  Somewhere along the lines your memory went dark, repurposed by your coiled masters to allow you to feel even greater heights of bliss.  There's faint flashes of you thrashing, but giant-sized testicles keep you pinned in place, your limbs devoured in penile restraint.  With a triumphant surge, bulges stretch your abused noise-holes and work deep into your skull.  Your world goes white, and an orgasmic soup of delight washes over you and erases any vestiges of thought from you, leaving behind only dripping obedience to pleasure.  Your pussy twitches weakly, offering tribute to Fera in sympathy, yet the real thing is in your cum-bathed brain.  Runny tentacle-spooge drips from your nose as you gurgle in bliss, then black out.");
			//>Next
			doNext(mountPumpkinsIII);
		}

		public function mountPumpkinsIII():void {
			clearOutput();
			outputText("SLAP!  The crack of a palm on your face rouses you, a red handprint left on your cheek.  Fera smirks at you as you stir woozy in your plant-woven prison.  <i>\"Did you enjoy yourself?\"</i>  You slowly nod, feeling... liberated... free.  The situation is less worrying than before.  Fera just wanted to thank you, right?");
			outputText("\n\nThe sultry orange-haired maiden pats your sloshing middle as the vines unwind, allowing you to stand on your own feet.  You go to wipe the cum from your nose and upper lip as soon as you're free.  It's dry.  Did any of that even happen?");
			outputText("\n\n<i>\"I went ahead and gave you your reward.  It seemed fitting to enhance the power of your womb, since that was how you saved me.  My hero,\"</i> Fera explains before giving you a chaste kiss on the lips.  <i>\"You'll find yourself breeding easier and giving birth faster.  Now go, fill this world with strong offspring.  Do not disappoint me.\"</i>");
			outputText("\n\nFera disappears along with all the evidence of your encounter, her ruby lips hanging in the air for a split-second before fading as well.  You're left naked, alone with your discarded armor, urge of release, and recently adjusted attitude.");
			outputText("\n\n(<b>Perk Gained: Fera's Boon - Breeding Bitch</b>)");
			player.createPerk(PerkLib.FerasBoonBreedingBitch,0,0,0,0);
			dynStats("cor", 30);
			doNext(camp.returnToCampUseOneHour);
		}

		//Perk name: Fera's Boon - Breeding Bitch
		//Perk description: Greatly increases fertility and doubles base pregnancy speed.
		//Increases the chance that the character will get pregnant and increases the speed of the character's pregnancies. 
		//Why, yes, I did copy/paste Marae's Gift - Fertility for this perk. Edit: And edited it to correct a mistake in its wording. YOU FAILED ME LAD. NOW ROT IN THE DEPTHS OF HELL.
		//Edit of this guy edit : You failed like, ¾ of your tags, you're the one to talk, man.
		//But I had to fix all the tags you tried to fix
		//You are just as much of a failure as he is.
		//Introduction
		public function feraSceneTwoIntroduction():void {
			clearOutput();
			outputText("While you're walking through the deepest, darkest parts of these overgrown woodlands, you come across a wild glade, filled with hundreds and hundreds of the most beautiful blossoming flowers. They cover the hundred or so feet across the clearing densely, some small, like dandelions and orchids, others enormous, on stalks as thick as small tree-trunks, blooming so vibrantly that you find yourself rubbing your eyes after gazing at them, dazzled by their many hued palettes. Sweet aromas of a thousand types of flowers blend together into a symphony of nasal delight, and you breathe deep, laughing loudly and openly at this wondrous find.");
			outputText("\n\nYou flop back into the soft grasses that ring this overwhelmingly sweet glade. The nectar-sweet ambrosia that's carried through the air on clouds of pollen ought to be attracting some insects, shouldn't it? You glance around, looking for the bees and butterflies you would normally expect to thrive in such a place, but there are none. No bugs, no gnats, no aphids... just flowers... flowers everywhere. You get up and wander around a little bit, looking this way and that, hunting for any proof of life while simultaneously taking in the cacophony of dazzling colors.");
			outputText("\n\nHere and there, you spot proof of Mareth's corruption in this seemingly pristine place: a flower whose petals look like plump, red lips, just waiting to be kissed, vines with distinctly phallic shapes protruding from the central stalk of the flower, and flowers whose entrances shine with slick fluids and part at your approach, appearing very much like a pair of clingy, virginal folds. And still, there are no bees. You run to the edge of the blooming meadow, and there, at last, you find what you were looking for.");
			outputText("\n\nA single, normal-looking bee, is lazily buzzing down onto a flower a few inches away, heedless of your presence. It homes right in on the sweet-smelling divot in the center of the petals, touching down without slowing or stopping to investigate the new arrival. Instead, it crawls deeper into the floral creases, hunting pollen and nectar. The petals snap up and around, slamming together with the speed of a clockwork trap, their edges seamlessly joined together into a single, entrapping sphere, perfectly encapsulating the poor insect. You hear a muffled buzz as the bug vainly attempts to escape, and then nothing. Whatever happened inside, the bee isn't struggling anymore.");
			outputText("\n\nA creeping shiver crawls down your back until you straighten and take in your surroundings once more. This place is too pretty for you to stay down in the dumps for too long, and besides, a particularly intriguing fragrance is tickling your nose. It seems to come from the center of the glade, where the biggest, most vibrant blooms have sprouted. Do you want to explore the center, around some of the huge flowers, or head back to the safety of your camp?");
			//[Explore] [Leave]
			menu();
			addButton(0,"Explore",exploreFerasWonderland);
			addButton(4,"Leave",leaveFerasWonderland);
		}
		//Leave
		public function leaveFerasWonderland():void {
			clearOutput();
			outputText("Nah, that whole place is probably some kind of giant venus fly trap. Fuck that.");
			flags[kFLAGS.FERAS_GLADE_EXPLORED_YEAR] = date.fullYear;
			doNext(camp.returnToCampUseOneHour);
		}

		//Explore Das Trees
		public function exploreFerasWonderland():void {
			clearOutput();
			awardAchievement("Fera's Wonderland", kACHIEVEMENTS.HOLIDAY_HALLOWEEN_II);
			flags[kFLAGS.FERAS_GLADE_EXPLORED_YEAR] = date.fullYear;
			outputText("Straightening to your full height, you take a few experimental sniffs and begin to walk back towards the middle of the meadow, brushing aside garish pink blooms that rise up past your waist.  That smell is getting stronger now.  How could you have missed it when you first arrived? It's heavenly, like a combination of every sweet treat you like with an undercurrent of passionate sexual musk blended in underneath.  You close in, " + player.mf("[hips] swaggering excitedly","[hips] sashaying excitedly") + ", " + player.skin() + " flushing.  A few baby blue sunflowers bump your shoulders as you muscle past them to hone in your new favorite aroma.  You've just got to know what bloom could possibly release such a heavenly scent!");
			outputText("\n\nYou idly wonder what you would look like to any new arrivals, nose up and dragging you forward, almost like a fish on a hook, your body stumbling past chest-high blossoms that are nearly as wide as your shoulders.  A shadow dims the light as you pass under a massive flower-bulb that stretches thirty feet overhead, its petals folded into a familiar-looking, sealed sphere.  That doesn't stop it from dripping sweet-smelling nectar that reminds you vaguely of pussy for some reason, and you certainly don't notice the feet-shaped impressions that kick against the petals after you pass by.");
			outputText("\n\nThat wondrous aroma guides you deeper, threading past delicate honeysuckles and crimson-colored lotus flowers.  Sometimes, you have you to stop and turn your head this way and that, testing the air with quick breaths to determine which way you must go to chase the increasingly omnipresent odor.  Other times it seems as obvious as a gold-plated path, dragging you right past vibrant foliage and smells that would normally incite you to stop and smell the roses if you weren't so focused on this one, heavenly, nose-tickling smell.");
			outputText("\n\nYou stumble a few steps forward, sighing in excitement as you near your prize.  It's so close that you can almost taste the pollen-scent you've been chasing on your tongue at this point.  Brushing back a petal nearly as tall as you, you loop past a plant as big as a house and come face to face with your current obsession.  It doesn't look at all like you expected, yet it seems so perfectly suited to its odor now that you're able to behold it up close and personal.  You blink a few times and smile widely, just taking it all in.");
			outputText("\n\nThe flower would stand nearly three times your own height were it not bending its stalk double under its own tremendous weight, the bottom-most petals long ago coming to rest on the ground in such a way that they'd make perfect ramps.  The outer and upper edges of its floral plumage stick out straight and true, almost like a daisy's would if it could grow to such a tremendous size.  In the very center is exactly what you'd expect from this twisted land: a pair of plump, obscene-looking lips compressed together into a smile and surrounded by dozens of phallic stamen, all wiggling this way and that.  Both the lips and the stamen leak a clear, glossy-looking fluid that seems to be the source of the smell.  It runs down creases in the petals towards your feet.");
			outputText("\n\nThe petals themselves are scarlet red near the center and a dusky, iridescent purple near their edges.  While you look, the colors seem to shift and change, slowly washing in towards the middle in an almost hypnotic pattern.  New hues scroll in from the tips of the bloom, turning it a psychedelic yellow-orange briefly before it too is pulled into the core, briefly staining the lips and stamen with its tawny hue before the next color in line washes it away.  You watch it for a few minutes, losing yourself in the flashing, changing colors, letting your eyes be guided to the unmistakably sexual accoutrements at the flower's core, watching and appreciating its unnatural beauty until you are roused by your [legs] starting to feel a little sore.");
			outputText("\n\nYou gather some of the nectar without thinking, compelled to lift it to your nose and take a sniff, heedlessly sampling its delicate bouquet, letting it tickle the back of your sinuses with its pheromonal payload while you enjoy the ambrosial levels of sweetness that come with it.  Your head swims a little... at least, until you lick your fingers clean and steady yourself against a nearby stalk.");
			if (player.gender > 0) outputText("  Your heart is hammering");
			if (player.hasCock() && !player.hasVagina()) outputText(", and there's a telltale tightness building in your groin, expanding and pressing oh-so-hard on your [armor]. You look up at those sweet lips and ponder what they would feel like wrapped around your " + player.multiCockDescriptLight() + ", a thought that only makes your gear that much harder to bear as it constrains you.");
			else if (player.hasVagina() && !player.hasCock()) outputText(", and there's a telltale heat building in your groin, practically dripping out to stain your [armor] with your leaking girl-honey. You look up at those leaky stamen and idly wonder what it would feel like to let one or two inside you, stirring your insides with their sticky-sweet lovejuices.");
			else if (player.hasVagina() && player.hasCock()) outputText(", and there's a telltale sticky tightness in your [armor], keeping your " + player.multiCockDescriptLight() + " tightly compressed while your [vagina] practically juices itself all over everything, so hot, wet, and unmistakably eager to feel something inside of it. You look up at those leaky stamen and the plump lips between them and wonder what it would feel like to stick yourself in between the lips and let the stamen go to town on your exposed holes.");
			else {
				outputText("\n\nWell, that was nice, but you don't see much reason to stick around.  You head back to camp with a wistful look over your shoulder.");
				dynStats("lib", 1, "lus", 20, "cor", 1);
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			
			outputText("\n\nYou bite your lip and search your feelings, gasping in more breaths of the delectable scent as you mull over your options.  Your eyes look down at the ramp-like lower petals, immediately chasing the shifting colors back up to the center, and a whimper escapes your lips.  You briefly recall that you only wanted to find the source of the scent");
			menu();
			if (player.inte >= 40) {
				outputText(", and with that accomplished, you could head back to camp.  Now, though, you'd rather stay; it smells and looks too good to leave this place.  If you focus on your better sense, you could still leave.");
				if (player.hasCock()) addButton(0,"Continue",fuckDemCorruptFlowerLips);
				else addButton(0,"Continue",stickAStamenInIt);
				addButton(4,"Leave",leaveAfterFlowerHuffing);
			}
			else {
				outputText(", but that thought slips out of your head as it fills with more of that sinfully exciting aroma, making you feel so hot, horny, and eager.  You have to get more of it, submerse yourself deeper in its cloying clutches as you watch the pretty colors drain away your worries and concerns.");
				if (player.hasCock()) addButton(0,"Next",fuckDemCorruptFlowerLips);
				else addButton(0,"Next",stickAStamenInIt);
			}	
			if (player.hasCock() && player.hasVagina()) {
				outputText("\n\nThe only ");
				if (player.inte >= 40) outputText("other ");
				outputText("question left to you is, are you more concerned with slipping [oneCock] into those subliminally-whispering lips or guiding a writhing stamen into your [vagina] and [asshole] so that you can take in as much nectar as possible?");
				addButton(0,"Lips",fuckDemCorruptFlowerLips);
				addButton(1,"Stamen",stickAStamenInIt);
			}
			dynStats("lib", 1, "lus", 25, "cor", 1);
		}

		//Leave
		public function leaveAfterFlowerHuffing():void {
			clearOutput();
			outputText("The farther you get from that glade, the more your head clears and the more you realize how close you came to disaster.  You resolve to avoid it in the future, lest you fall prey to that entrancing pollen and the hypnotic petals once more.");
			doNext(camp.returnToCampUseOneHour);
		}
		//Fuck the Lips
		public function fuckDemCorruptFlowerLips():void {
			clearOutput();
			flags[kFLAGS.FERAS_TRAP_SPRUNG_YEAR] = date.fullYear;
			outputText("You dazedly stagger forward, putting one [foot] after another on the supple flesh of the gigantic, color-swirling petal that leads to your goal: the plush, nectar-leaking lips at the center of the bloom.  With each plodding movement, the hues become more vibrant, the intoxicating scent becomes thicker, and the less well-reasoned your thoughts become, shutting down in the avalanche of sensory overload.  Soon, your thoughts are little more than: <i>Scent. Sex. Horny. Fuck.</i>");
			outputText("\n\nWith a slight stumble, you work your way out of your [armor], not stopping your plodding advance in the slightest and never letting the flower's core out of your sight, if you can help it.  Those lips seem to be pursing ever so slightly, beckoning you to slip something inside them... something hard and throbbing, aching to unload.  You shudder as you walk, slipping on a stream of leaking nectar and falling down onto your hands, but this doesn't impede your progress.  You continue to climb up, hand over hand, dragging yourself up until the 'floor' levels and you're about to smash yourself face-first into the flower's plump, mouth-like pillows.");
			outputText("\n\nYou drag yourself up onto your [feet] just as the stamen react to your presence, lashing out with snake-like swiftness to encircle your arms and [legs], binding them up in slippery stalks such that you can barely move.  Luckily, you're close enough that you can still do what you came here to do: fuck this flower.  You lunge your [hips] forward, slamming your crotch towards the huge, multi-hued lips, ");
			if (player.longestCockLength() >= 20) {
				outputText("easily ramming your huge endowment");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" straight into the erotic-looking mouth");
			}
			else if (player.longestCockLength() >= 8) {
				outputText("slipping your large endowments");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" right into the erotic-looking mouth");
			}
			else if (player.longestCockLength() >= 4) {
				outputText("easing the top hal");
				if (player.cockTotal() > 1) outputText("ves");
				else outputText("f");
				outputText(" of your phallus");
				if (player.cockTotal() > 1) outputText("es"); 
				outputText(" into the erotic-looking mouth");
			}
			else {
				outputText("barely managing to slip your tip");
				if (player.cockTotal() > 1) outputText("s");
				outputText(" into the erotic-looking mouth");
			}
			outputText(". The contact is everything you thought it would be: surprisingly warm, soaking-wet, and squeezing just tight enough to make your pillar");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" of lust twitch in excitement.");
			
			outputText("\n\nThe bindings around your arms and legs respond by tightening, forcing you spread-eagle, as caught as an insect in a spider's web.  Blessedly, instead of turning their control of your position to some nefarious turn, they pull you closer, slapping your ");
			if (player.balls > 0) outputText("[balls] against the cushy lower lip, wreathing them in syrupy sap or nectar.  You're not really sure what the appropriate name for such a substance is, and you're well past caring.");
			else outputText("loins against the cushy, sap-slicked lips, compressing their hot, smooth surfaces against your " + player.skin() + ".  You're not really sure if sap is the appropriate name for such a substance, but you're far beyond caring at this point.");
			outputText("  The fast-diminishing light doesn't even register, as your eyes have closed as you subsume yourself in pleasure.");
			
			outputText("\n\nThe bindings aren't tight enough to prevent you from flexing your [legs] and sawing yourself back and forth, thrusting in and out of the tight, slobbery hole, and you go at it like an animal in rut, savagely humping against the lurid lips, bound to them by dangling streamers of glittering nectar with each pull back. The petals slam closed with such force that it pops your ears, rousing you from your stupor. When you open your eyes, you're treated to the briefest moment of darkness before the petals light up with bioluminescent energy. Neither occurrence stops the frantic pounding your [hips] are doling out, but you do look up in a daze.");
			outputText("\n\nIt is at this point the colors begin to slide and change, twisting and shifting in a calming rhythm that seems perfectly synced to your sloppy, piston-like thrusts. A trickle of drool escapes the corner of your mouth as you moan, in ecstasy, right up until a free stamen arcs around to slam into your slack-jawed opening. It slides right into the back of your throat, throwing great big blobs of sweet, heavenly nectar so deep inside you that you have no choice but to swallow and sigh. Everywhere the juice touches practically sizzles with sexual energy, and after a few frenetic gulps you begin to eagerly gulp and swallow, drinking deeply of the goo until your belly begins to feel too full to drink any more.");
			outputText("\n\nYour motions slow as the ambrosial syrup is wicked into your body, frying your synapses with ecstasy until only lust, pleasure, and perfect heat are occupying your few remaining thoughts. By the time the tendril pulls free, glazing your face in sappy goo, your [hips] have stopped their thrusts entirely, leaving your " + player.multiCockDescriptLight() + " to pulsate and ache with need despite their owner's inability to remember how to hump. Best of all, the few times that you do manage to summon up a coherent thought, the flashing, undulating colors unravel it, letting you revel in unthinking arousal.");
			
			outputText("\n\nThe deluge of drugs, arousal, sexual stimulation, and mind-scattering visual patterns has made your mind as pliant and vulnerable as the lips your " + player.multiCockDescriptLight() + " ");
			if (player.cockTotal() > 1) outputText("are");
			else outputText("is");
			outputText(" buried in, so hot, wet, and soft. With each passing moment, you become more relaxed, more open and exposed, and more aroused than before. You would probably be afraid if you were capable of any kind of reason.");
			outputText("\n\nA perfectly smooth, perfectly dry hand traces down your back in a comforting yet sensual gesture, followed a moment later by another upon your [butt]. It squeezes you, kneading your cheek in its supple, dextrous fingers, letting long, sharp nails just barely dig into your " + player.skinFurScales() + ". Then the hands move down to your [legs] to continue their massage, dodging around the tentacle-like stamen so that they can reach your [feet]. There, the hands stop and separate from your body, vanishing until a familiar face leans in front of you, interrupting the slew of mind-tranquilizing colors briefly.");
			
			outputText("\n\nIt's Fera, Goddess of Predation, Marae's corrupt sister, and you've fallen directly into her trap.  The fair-skinned goddess titters, her fiery-orange tresses hanging down around you in a corrupted halo, drawing your slow-to-respond gaze to her pale, creamy skin, prominent lips, button nose, and smoldering red eyes.  \"<i>Oh, [name], I was hoping you'd come to my glade!</i>\"  She kisses your forehead tenderly.  \"<i>Last time we met, you saved me, and I gave you a gift for it. This time, I'll save you from a lifetime of orgasms, and you'll give me a gift, all right?</i>\"");
			outputText("\n\nYour mind has all the ability to resist of a fertile field before a plow, and you do the only thing you can think of: agreeing.  \"<i>Yyeshhh...</i>\" you slur, drooling sugar-sweetened spit out of the corner of your mouth.");
			
			outputText("\n\nFera rubs your ");
			if (player.balls == 0) outputText("inner thighs");
			else outputText("[balls]");
			outputText(", squeezing you encouragingly.  \"<i>Now, I am a generous goddess. Your gift will be to aid me by being a rapacious, horny predator, one who will seed every strong person or monster " + player.mf("he","she") + " encounters until there is an army of unstoppable fuck-monsters roaming the lands.  You will fertilize the weak again and again, until they give birth to strong offspring.  You'll make the males your subservient bitches, only fit to serve your pregnant slaves and to take your steaming loads in their holes whenever there's no suitable female around</i>\"  She taps her chin thoughtfully.  \"<i>How does that sound?</i>\"");
			outputText("\n\nThere isn't enough guidance in that question to rouse a response from your supine form, so Fera continues on, smiling all the while.  \"<i>Oh, I'm going to do it, [name].  You're going to do this for me.</i>\"  She idly slips a finger along the underside of [oneCock] and licks her lips.");
			
			//[next]
			dynStats("lus=", player.maxLust());
			menu();
			addButton(0,"Next",dickBoostingFuntimes);
		}
		//Get a Boosted Dick!
		public function dickBoostingFuntimes():void {
			clearOutput();
			outputText("You hang there, suspended, spread-eagled, and with your dick [sheath]-deep in a giant pair of fuck-hungry lips as the goddess circles you, running her dagger-sharp nails gently across your " + player.skinFurScales() + " until she stands behind you, arms wrapped around your [chest] and squeezing. She nips at your ear, biting it gently but getting no response from your blissed out, drug-ravaged body.");
			outputText("\n\n\"<i>Suck,</i>\" the goddess commands authoritatively to the flower, and to you, she bids, \"<i>Fuck.</i>\"");
			outputText("\n\nThose beautifully plump flower-lips compress down more tightly, sealing perfectly around your length");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" just in time to take the first thrust from your hips, burying yourself into them and immediately pulling back, setting an easy, average rhythm.  At the same time, the suction starts, causing your ");
			if (player.cockTotal() > 1) outputText("heads");
			else outputText("[cockHead]");
			outputText(" to swell up a little, and when the rest of your length is plowed through the tight, slippery ring, the tugging vacuum increases, plumping your dick");
			if (player.cockTotal() > 1) outputText("s");
			outputText(" bigger, harder, and fatter than ");
			if (player.cockTotal() == 1) outputText("it");
			else outputText("they");
			outputText(" should be.");
			
			outputText("\n\nFera, unseen but felt behind you, begins to whisper thoughts and ideas into your ears as you sway in the corrupt flower's embrace.  \"<i>You like to fuck, don't you [name]?  To thrust and hump until your [balls] ");
			if (player.balls > 0) outputText("empty");
			else outputText("empties");
			outputText(" so that you can start the cycle anew.  You love that, and this is the perfect place for that kind of behavior, isn't it? Everybody in this world wants to fuck, they just like to fight to see who gets to be on top, and you're good at winning, aren't you, pet champion?</i>\" Fera ");
			if (player.balls > 0) outputText("cups your [sack] tenderly");
			else outputText("tickles your taint");
			outputText(" to spur you to thrust harder while she fills your head with lurid thoughts.");
			outputText("\n\n\"<i>Go on, fuck it harder. Assert yourself, [name].  Tame that fuck-hole.  Give it the sperm-filling it deserves,</i>\" the goddess instructs.");
			outputText("\n\nOn command, you pound away, causing the huge pillows to shiver and shudder with your slap-happy impacts, feeling the tightness of an on-command orgasm building deep within you, as inexorable as the rising tide. Your eyes cross from the pleasure, and you hilt yourself, erupting what feels like gallon after gallon of sticky, fertilizing spooge into the suck-hungry passage, flooding it with your jism.");
			outputText("\n\nFera pinches your [nipples] and instructs, \"<i>Don't go soft, [name]. You go right back to humping, stay horny... always horny.  Remember how good it felt to fill that hole with cum.  Realize that you can feel like that again and that you will.  All you have to do is think about how horny Mistress Fera has made you and what a rutting, breeding fuck-tool you are.</i>\"  She squeezes your [sheath] when you pull back.  \"<i>It is your duty to flood every hole with your cum.  You are the superior mate.  You are the most powerful creature out there, and it is your duty to show every person you meet that fact.  It is your duty to fuck them into their place.</i>\"");
			outputText("\n\nShe squeezes harder until you whine with excitement, feeling a warm, wet tongue slither around [eachCock], licking and suckling as it devours your contribution.  [EachCock] is spasming and flexing, already as hard as it can possibly be and once more ready to unload.");
			outputText("\n\nFera coos, \"<i>Cum again for me while we make this tool a little more suited to your duty, [name]. Unload.  Your mistress commands it.</i>\"");
			outputText("\n\nYou sputter and spurt, each crest of pleasure stronger and more potent than the last, and Fera rubs your ");
			if (player.balls > 0) outputText("[balls]");
			else outputText("taint");
			outputText(" as you do, whispering, \"<i>Good " + player.mf("boy","girl") + ",</i>\" into your ears as dark energies flow into you, refilling your fast-emptying reservoirs faster than they can empty.  \"<i>Don't stop yet, [name].  You're going to be doing this a lot, so I'm giving you lots of practice.</i>\"");
			outputText("\n\nYou shudder as your climax starts all over again, right before the last one ends, locking you in a cycle of thrusting, shuddering, starting to withdraw and then planting yourself back in and groaning. Your eyes flutter closed, your mouth hangs open, and Fera whispers instruction after instruction into your pliant little mind, sowing the seeds of your libidinous behavior to come.  Honestly, you don't ever want to stop.");
			//Cum, dick length +1, dick thickness increased noticeably, libido +10, cum production +1000, bonus virility.
			for(var x:int = 0; x < player.cocks.length; x++) {
				player.cocks[x].cockLength++;
				if (player.cocks[x].cockThickness < player.cocks[x].cockLength/5) {
					player.cocks[x].cockThickness = player.cocks[x].cockLength/5;
				}
			}
			player.orgasm();
			dynStats("lib", 10, "cor", 5);
			player.createPerk(PerkLib.FerasBoonSeeder,0,0,0,0);
			menu();
			addButton(0,"Next",postSeederUpgrade);
		}

		public function postSeederUpgrade():void {
			clearOutput();
			outputText("You awaken fully dressed with a familiar ache between your legs.  Damn, that was a good nap.  You rise, scratching [oneCock] and smiling as you feel how hard and sensitive it is.  You're already feeling pretty anxious for a fuck, especially after the crazy wet dreams you had last night, and you resolve to find a nice hole to dump a few loads into before too long.  First, you had better go check back up on your camp.  You've got to bring your A-game if you're going to fuck stronger babies into every weak pussy you come across.  Besides, the wait will only make your eventual sexual enjoyment that much messier.");
			//Add ten more corruption.
			//Add 50 lust.
			dynStats("lus", 25, "cor", 10, "resisted", false);
			doNext(camp.returnToCampUseFourHours);
		}

		//Stick a Stamen in It!
		public function stickAStamenInIt():void {
			clearOutput();
			flags[kFLAGS.FERAS_TRAP_SPRUNG_YEAR] = date.fullYear;
			outputText("You dazedly stagger forward, one [foot] after another falling on the supple flesh of the gigantic, color-shifting petal that rises up towards the flower's center like steps on an ancient ziggurat.  The closer you get, the more vibrant the hues become, the thicker the scent becomes, and the simpler and more instinctive your thought processes become.  <i>Flower. Fuck. Sex. Need. Ache.</i>");
			outputText("\n\nStumbling slightly, you begin to wriggle out of your [armor].  First one arm, then the other.  You pause briefly to slide your kit off, forgotten on the petal behind you, and come closer to those juicy, turgid stamen, so heavy and sticky and perfectly hard looking.  The slickness of the leaking nectar nearly robs you of your footing but you struggle on and catch hold at the seam between two petals, never letting your goal out of your sight.  On hands and ");
			if (player.isNaga()) outputText("tail");
			else if (player.isGoo()) outputText("goo");
			else outputText("knees");
			outputText(", you drag yourself up until the 'floor' flattens out and you nearly ram into the pursed lips, stopping yourself abruptly once you realize you've reached your goal.");
			outputText("\n\nThe stamen react to your presence with snake-like swiftness, lunging out around your arms and [legs], tangling you up in their slippery length, surprisingly warm and comforting on your skin. Darkness reigns as the flower petals snap closed with enough force to make your ears pop with a near-deafening boom. The shock is enough to rouse you from your contented stupor, though your body still burns with an unnatural lust, craving for the tentacles to touch you in a far more intimate, internal way. You still try to struggle, but as your mouth opens to scream, it is immediately plugged by a thick, vein-corded stamen.");
			outputText("\n\nAt the same time, the petals abruptly light themselves in waves of multicolored bioluminescence that run that spectrum from violet to red, always shifting and sliding in such a way that whenever you try to follow them, you lose yourself in the swirl of exotic color.  It's distracting enough that you fail to bite down on the tentacle in your maw or resist its plunge towards the back of your throat.  Not that it matters, your fate was sealed the moment you decided to climb up the flower.  Having a tentacle leaking its perfect ooze onto your tongue and sliding back towards the rear of your throat is little more than the final stroke of color on a master's painting.  It's so potent, so strong, this close to the source that you can practically feel it sizzle through your taste buds and into your nervous system, frying synapses as it goes.");
			outputText("\n\nYour struggles cease as abruptly as they started and you backslide into the comfortable, sensual embrace of your restraints, letting your [legs] spread and your [vagina] drip hungrily");
			if (player.hasCock()) outputText(", [eachCock] bobbing");
			outputText(".  You aren't hoping they'll take you, though.  On the contrary, that delicious nectar has hit your consciousness with such sublime delight that you can't possibly resist its siren call, and you've let yourself slip into a kind of happy, receptive state, your eyes dilating wide as the sweet, drugged sap does its work.  Your vision stays locked straight in front of you, up towards the ceiling, given the way you've been suspended, where you can watch the colors flip and change, dancing so wonderfully and merging and twisting and changing in ways that would make you gasp if you had the capacity for it.");
			outputText("\n\nThe deluge of drugs, arousal, sexual stimulation, and mind-scattering visual patterns has made your mind as pliant and vulnerable as the dripping-wet delta between your legs, so hot, wet, and soft, just waiting to take something inside it.  For now, the plant seems content to merely hold you, pushing the stamen in your mouth a little deeper, past the point where a gag reflex would kick in, were it not suppressed.  Instead, your jaw works automatically, swallowing it into your esophagus, letting it ooze its drug-laced nectar into your receptive stomach, just like you wanted (until your brain switched off).");
			outputText("\n\nA perfectly smooth, perfectly dry hand traces down your back in a comforting yet sensual gesture, followed a moment later by another upon your [butt].  It squeezes you, kneading your cheek in its supple, dextrous fingers, letting long, sharp nails just barely dig into your " + player.skinFurScales() + ".  Then the hands move down to your [legs] to continue their massage, dodging around the tentacle-like stamen so that they can reach your [feet].  There, the hands stop and separate from your body, vanishing until a familiar face leans in front of you, interrupting the slew of mind-tranquilizing colors briefly.");
			outputText("\n\nIt's Fera, Goddess of Predation, Marae's corrupt sister, and you've fallen directly into her trap. Unfortunately, you're in no state to react, not with your belly full of sweet, narcotic goo.  In fact, you've gotten so full that the tentacle exits and allows you to breathe once more, leaving a few thick globs behind on your face as a parting gift.  The fair-skinned goddess titters, her fiery-orange tresses hanging down around you in a corrupted halo, drawing your slow-to-respond gaze to her pale, creamy skin, prominent lips, button nose, and smoldering red eyes.  \"<i>Oh, [name], I was hoping you'd come to my glade!</i>\"  She kisses your forehead tenderly.  \"<i>Last time we met, you saved me, and I gave you a gift for it.  This time, I'll save you from a lifetime of orgasms, and you'll give me a gift, all right?</i>\"");
			outputText("\n\nYour mind has all the ability to resist of a fertile field before a plow, and you do the only thing you can think of: agreeing.  \"<i>Yyeshhh...</i>\" You slur, drooling sugar-sweetened spit out of the corner of your mouth, your [hips] struggling against their restraints to get a good fuck.");
			outputText("\n\nFera rubs your [chest], tweaking a [nipple] encouragingly.  \"<i>Now, I am a generous goddess.  Your gift will be to aid me by being a rapacious, horny predator, one who will reproduce with every strong person or monster she encounters until there is an army of unstoppable fuck-monsters roaming the lands.  You will seed the weak again and again, until they give birth to strong offspring, and you will offer your womb to the biggest, strongest, toughest males you can find.  Perhaps the minotaurs.</i>\"  She taps her chin thoughtfully.  \"<i>Oh, I can let you pick!  How does that sound?</i>\"");
			outputText("\n\nThere isn't enough guidance in that question to rouse a response from your supine form, so Fera continues on, smiling all the while.  \"<i>I could work on your vagina, make it a proper breeding cunt, nice and gaped for easy birth and penetration.  You'll be a real hit with tentacle monsters, I bet.  They might even just slip past your poor cervix and fill you up in the rare moments where you aren't pregnant.</i>\"  She idly slips a finger in between your folds, ticking it back and forth as she talks.");
			outputText("\n\nFera adds, \"<i>Or, I could tighten this baby up, make it so that no matter how many cocks you take in your journeys you'll always be tight, always ready to really milk your fallen foes so that you can wick that cum up into your hungry pussy as soon as possible.</i>\"  She brushes your clit, sending involuntary shudders of exquisite pleasure through your body.");
			if (!player.hasCock()) {
				outputText("\n\n\"<i>Or, there's always a cock, I suppose.  You would be far more efficient at spreading your strengths that way, my obedient little slave,</i>\" Fera muses with a wide grin.  \"<i>Imagine yourself with a huge cock, constantly slick with your victims' fuckjuices, pounding pussy after pussy until every female in walking distance is carrying a litter of your young - young that will grow up and fuck and breed just as happily as their 'father.'</i>\"  You can't help but do it.  Your mind paints a vivid picture, one that makes your [legs] twist in excitement and your [vagina] drool.");
			}
			outputText("\n\nThe goddess pulls her finger out and brings it to her blood-red lips.  She slips it past her plump entrance to the knuckle and sighs, slowly dragging it back out, now as clean and dry as after a day at a spa. Her intense eyes regard you for a moment, and she leans down, low and close to your ear, \"<i>Tell me, pet. Tell me which is most your heart's desire.  Would you rather be a gaped, drooling breeder, ");
			if (player.hasCock()) outputText("or ");
			outputText("a tight, dick-milking rape-mother");
			if (!player.hasCock()) outputText(", or a libidinous dick-girl, sowing your seed everywhere you can and saving your cunt for only the strongest of mates");
			outputText("?</i>\"");
			outputText("\n\nWith the question asked, she awaits your slow-moving mind's answer.  No is not an option you're even capable of considering at this point.  Which do you want?");
			//[Gape] [Tight] [Dick]
			dynStats("lus=", player.maxLust(), "cor", 2);
			menu();
			addButton(0,"Gape",gapeMePleaseFera);
			addButton(1,"Tight",tightLikeAToigar);
			if (!player.hasCock()) addButton(2,"Dick",growADickForFera);
		}

		//Gape
		public function gapeMePleaseFera():void {
			clearOutput();
			outputText("Fera smiles as you announce your choice.  \"<i>I thought you might say that, little champion.  Now, you simply relax and enjoy the pleasure that only my normal weak-willed prey are allowed to experience.  You will be the first to taste it and be allowed free.  How wonderful!</i>\"  She pets your forehead.");
			outputText("\n\nMeanwhile, you hear a squelching, slithering sound down below as Fera pulls away, kneeling down beside you so that her lips are at your ear, washing her hot breath across it and occasionally letting her soft, pillow-like mouth press against your aural opening.  \"<i>Relllaaaax,</i>\" she commands, and you do.  Your body sags bonelessly into its organic cradle as a writhing mass of tentacle-like stamen contort just shy of your mons, their squirming shapes dripping almost as eagerly as you.");
			outputText("\n\nThe mass of tendrils does not delay. It lurches forward as one unified column of hole-fucking power, plowing straight into your [vagina]");
			if (player.vaginas[0].vaginalLooseness >= VAGINA_LOOSENESS_LEVEL_CLOWN_CAR) outputText(", spreading its well-widened lips as wide as they've ever been");
			else if (player.vaginas[0].vaginalLooseness >= VAGINA_LOOSENESS_GAPING) outputText(", spreading your lips well beyond the widest they've ever been and still farther.");
			else if (player.vaginas[0].vaginalLooseness >= VAGINA_LOOSENESS_LOOSE) outputText(", meeting a bit of token resistance at your unprepared entryway and slithering stamen after stamen inside, the forerunners widening you until the entirety of the column can pass inside, gaping you almost inhumanly wide.");
			else outputText(", meeting more than a little resistant at your unstretched entry and finding a way in anyhow. First one tentacle slithers in, then a second, then a fourth, and so on. One after another, they spread you wider and wider, opening you until the entire wiggling column is buried deep, pulling your lips ridiculously wide.");
			outputText("\n\nYou do not feel an ounce of pain from the extreme insertion. You don't even feel a whiff of discomfort. All you can feel is a sense of delicious, twat-stuffing fullness, filling and expanding you all while flooding you with more of that heavenly, brain-deadening slime. Your crotch quickly overflows. There simply isn't room for all the nectar they're leaking inside. The excess is painting you with a glossy coat of nectar and girl-honey, spraying over your [legs] around the impaling members.");
			//STEAL VIRGINITY!
			player.cuntChange(90000,true,true,false);
			
			outputText("\n\nFera's voice whispers with a voice that has as much heat as the crackling coals of a long-burning bonfire, \"<i>Feel the pleasure of being filled, my servant.  Feel the bliss of stuffing yourself so full, so very full.  Only the biggest, strongest, most well-hung of mates will ever come close to filling you like this, and you will seek them out.  Your twat will hunger for huge cocks.  It will </i>thirst<i> for the cum that's lurking in those big, meaty balls.  Your womb will ache for impregnation, and you will seek it, won't you?  Answer me, my pet champion.</i>\"");
			outputText("\n\nYour lips mouth, exhaling your answer in a barely audible, \"<i>yessss....</i>\"");
			outputText("\n\nThe sap-oozing tendrils respond by pulling back and thrusting in, scraping your tightly-stretched walls, rubbing over every sensitive place. Your lips, your clit, your g-spot - they're all caressed by slick heat, forced to accept the hip-stretching insertion with nothing short of incredible excitement.  Your body shudders from head to ");
			if (player.lowerBody == LOWER_BODY_TYPE_HUMAN) outputText("toe");
			else if (player.tailType > TAIL_TYPE_NONE) outputText("tail");
			else outputText("[foot]");
			outputText(" as you climax, arching your back and making guttural, beast-like sounds of pleasure.  Your eyelids hang low, lazily obscuring some of those wonderful colors from your view as the pleasure and plant-sap work on you.  Shuddering, you gush girlcum harder than ever, spraying a thick wave of lady-spunk across the tentacles, shining them with your juices");
			if (player.wetness() < 4) outputText(" even though you're not a squirter");
			outputText(".  They pump on with intense, unrelenting energy, squishing wetly with every thrust, splattering juice everywhere as they ruin your poor, convulsing cunny.");
			player.cuntChange(90000,true,true,false);
			
			outputText("\n\nAs you come down, Fera resumes talking. Your body doesn't seem to care, because you start to cum again three thrusts later, riding out wave after wave of ecstasy to the sound of her simmering-hot voice filling you with idea after idea.  Her words just slip right into your delicate, open consciousness, settling in as if they're your own with every cunt-shattering orgasm that wracks your bliss-riddled form.  \"<i>This is your top priority, [name].  Pleasure.  Ecstasy.  You are going to fuck who you want, when you want.  You are going to take the sperm you want from the male you choose to father your young and you are not going to take anything for an answer except his big, fat dick in your needy cooch.</i>\"");
			player.cuntChange(90000,true,true,false);
			outputText("\n\nYou pant, \"<i>Yessssssssss,</i>\" though you don't know if it's due to the nerve-incinerating excitement or in agreement with Fera's declarations.  Your world dissolves into pure rapture.  The colors fade away when your eyes roll back, and the instructions seem far away, almost as if spoken to someone else.  The tentacles never stop thrusting, and you never stop cumming, focusing solely on the hot, lurid flower-fuck until your mind is laden with cruel suggestions and your body has orgasmed into unconsciousness.");
			player.cuntChange(90000,true,true,false);
			//(cum!)
			//Minimum size to 4
			player.createPerk(PerkLib.FerasBoonWideOpen,0,0,0,0);
			//Boost fertility by a bunch
			player.fertility += 20;
			if (player.fertility > 50) player.fertility = 50;
			//Raise wetness to at least 3.
			if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLICK) player.vaginas[0].vaginalWetness = VAGINA_WETNESS_SLICK;
			if (player.vaginas[0].vaginalLooseness < VAGINA_LOOSENESS_GAPING_WIDE) player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_GAPING_WIDE;
			//Add five corruption.
			player.orgasm();
			dynStats("cor", 3);
			//[Next]
			menu();
			addButton(0,"Next",gapeByFeraEpilogue);
		}

		public function gapeByFeraEpilogue():void {
			clearOutput();
			outputText("You awaken fully dressed with a familiar ache between your legs. Damn, that was a good nap.  You rise, stretching as you rub your back, sore from lying against a tree for so long.  You suppose you could hunt down a tentacle monster and see if it'd really give you a filling");
			if (player.pregnancyIncubation == 0) outputText(", but you'd rather fuck something that'll get you good and pregnant with a well-hung fuck-monster, like a minotaur!");
			else outputText(".");
			outputText("  You idly reach into your [armor] and stuff four fingers into yourself before sighing and removing them.  It just isn't the same as being full of cock.");
			outputText("\n\nAs you head back to camp to prepare for your next adventure, you realize that you had some really, really fucked up dreams.  You hope you have more tomorrow night.");
			//Add ten more corruption.
			dynStats("lus", 20, "cor", 10, "resisted", false);
			doNext(camp.returnToCampUseFourHours);
		}

		//Tight
		public function tightLikeAToigar():void {
			clearOutput();
			outputText("Fera smiles.  \"<i>I had hoped we might do that, little champion.  Now, you simply relax and enjoy the pleasure that only my normal weak-willed prey are allowed to experience.  You will be the first to taste it and be allowed free.  How wonderful!</i>\"  She pets your forehead.");
			outputText("\n\nMeanwhile, one of the tentacles that had been holding you decides to disentangle itself from its brethren, swaying over towards Fera like a snake to a snake-charmer.  The goddess grabs the tentacle in her hands and smiles, tickling it just behind its exoticly-shaped glans in a way that makes it drip sweet-goo everywhere.  She stops before it can cum and changes posture, gripping the stalk tightly in her hand and curling her fingers inward until the tips of her nails pierce the plant-beast's skin.  It stiffens as if in pain and then goes limp, pinpricks of inky blackness spreading from where it's been punctured.  The inky coloration doesn't appear to be decay but rather an almost latex-like sheen.");
			outputText("\n\nThe tentacle's inky spots expand to big, black blotches before combining together to turn the first foot of the thing into a rubbery onyx dong.  The corrupted, sextoy-like texture spreads like wildfire down the stalk and beyond your view, though you're sure it must stop somewhere, because the other tentacles never change color.  That succulent syrup that leaks from the tip changes to the same color, every bit the same tone but still completely liquid, dripping down off of it to splatter wetly on the floor as Fera strokes it once more.");
			outputText("\n\n\"<i>Don't mind the exotic tone, dear.  It won't change how your pussy looks one iota");
			if (player.skinAdj == "latex" || player.skinAdj == "rubber") {
				outputText(", not that a " + player.skinAdj + " honey like you would notice");
			}
			outputText(", but it will change how quickly your pussy recovers from a nice gape.  It will definitely change how your pussy feels about getting fucked, no doubt about that,</i>\"  Fera promises as she continues to stroke her pet rubber-plant, leaning low to kiss you once she finishes.  Though you lack the capacity to kiss back by this point, your mouth is pliant and unresisting, and you are able to feel the intensely erotic sensation of a goddess' tongue in your mouth.  More importantly, you can taste her, and while her flavor is different than the nectary plant-sap you were instantly addicted to, it is even more divine, like cinnamon mixed with the essence of lust and sex.");
			outputText("\n\nBreaking away at last, she smiles once more and releases her tendril.  \"<i>Go on,</i>\" she says to it, \"<i>Do what I created you to do. Do what you were meant to do.</i>\"");
			outputText("\n\nThe sable shaft disappears below before surfacing above your vulnerable cleft, spattering hot, wet, goo all over the puffy lips of your sex.  Sighing, you arch your back and await the coming penetration, opening yourself to be used by this creature, obediently awaiting the remolding of your pussy into a permanently tight twat.");
			
			outputText("\n\n\"<i>Good girl,</i>\" Fera coos as she drops down beside you and presses her lips to the edge of your ear.  \"<i>Just relax and enjoy the pleasure that comes from being one of my pets.</i>\"");
			outputText("\n\nYou groan in unrestrained lust, forced by her command to relax in spite of the lava-hot need drooling out from your [vagina] and at the same time enjoy it as fully as possible, focusing on every tingle of pleasure from the vine's slow, slick shifting about your body.  Some more black goo splatters across your mons, and you nearly cream to the feeling of that warm, corruptive ooze sliding between your lips and tainting you with Fera's inescapable love.  Your lips spread on their own, displaying the interior of your nectar-stained pussy to the horny tendril, practically begging for it to take you and spear you over and over until your pussy is stuffed to the brim with its pussy-tightening fuck-slime.");
			outputText("\n\nTouching against the pliant, slippery vulva that girds your entrance, the tendril rubs its rounded head against you in a surprisingly gentle way, teasing your exterior until you're aching to buck back against it, but you can't, Fera told you to relax.  Disobedience is a concept your poor, addled psyche won't remember for some time.  You hang there, mewling like a cat in heat, pussy splayed and being touched but not penetrated.  Breathily, you repeatedly make pathetic little begging noises, and turn your slow-to-respond eyes towards Fera's face questioningly, begging the goddess with your moans.");
			
			outputText("\n\nShe smiles, and the tentacle finally pushes forward");
			if (player.vaginas[0].vaginalLooseness >= VAGINA_LOOSENESS_LEVEL_CLOWN_CAR) outputText(", slipping past your capacitive entrance with ease");
			else if (player.vaginas[0].vaginalLooseness >= VAGINA_LOOSENESS_GAPING) outputText(", sliding into your welcoming entrance fairly easily");
			else if (player.vaginas[0].vaginalLooseness >= VAGINA_LOOSENESS_LOOSE) outputText(", slowly working its way into your decently unstretched entrance");
			else outputText(", slowly burrowing past your tight, restrictive entrance");
			outputText(" and leaving a trail of slick, black corruption in its wake.  The tendril pushes the whole way up to your cervix, gently butting up against your womb's portal before dragging back out, sputtering more inky cum all the way.  When it pops out, the head catches the tip of your [clit], causing your [vagina] to spasm and contract, squeezing down on the foreign fluid with such strength that a geyser of sable spunk erupts from your quivering quim.");
			player.cuntChange(1,true,true,false);
			outputText("\n\nFera coos, \"<i>Atta girl, are you feeling it?  Can you feel the way your pussy is tightening up?  You can, I know, and your womb is getting thirstier and thirstier, just aching to squeeze the cum out of a helpless male or herm that you've taken the time to beat into their place, right, my pretty?</i>\"  Her fingers reach down to your black-stained cleft and rub around the hardening gunk that paints your crotch, making it look like someone painted liquid latex all across your " + player.skin() + ".  At the same time, the tendril lunges back in to your spunk-spouting cunt, plugging it just before it starts to unload once more, its stalk undulating between your legs with each thrust, rising up and straightening with each hip-shaking thrust it delivers to your increasingly supple, stained box.");
			outputText("\n\nYou cum, and you cum... and you cum some more.  Each orgasm comes closer on the heels of the one before, wetter, hotter, and more powerful than the last.  Despite the commands to relax, your body shakes and quivers like a leaf caught up in a tornado, helplessly tossed about on disastrously strong winds of ecstasy.  Your [legs] clench around the penetrating stalk, increasingly painted with the onyx hue of your floral lover's distilled love, and you give yourself over to the passion, screaming and crying and moaning until your voice goes hoarse and Fera's gentle whispers shush you into silence.");
			outputText("\n\nYou have no choice but to obey as you lose consciousness to the pleasure, your mind left as open to Fera's instructions as your pussy is to that ever-thrusting, continually-cumming vine-cock.");
			//(cum!)
			player.orgasm();
			dynStats("lib", 5, "sen", 20, "cor", 3);
			//Maximum size to 2
			player.createPerk(PerkLib.FerasBoonMilkingTwat,0,0,0,0);
			if (player.vaginas[0].vaginalLooseness > VAGINA_LOOSENESS_LOOSE) player.vaginas[0].vaginalLooseness = VAGINA_LOOSENESS_LOOSE;
			//Boost fertility a little
			player.fertility += 10;
			if (player.fertility >= 50) player.fertility = 50;
			//Raise wetness to at least 3.
			if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLICK) player.vaginas[0].vaginalWetness =VAGINA_WETNESS_SLICK;
			
			//[Next]
			menu();
			addButton(0,"Next",tightnessEpilogue);
		}
		public function tightnessEpilogue():void {
			clearOutput();
			outputText("You awaken fully dressed with a familiar ache between your legs.  Damn, that was a good nap.  You rise, stretching as you rub your back, sore from lying against a tree for so long.  You suppose you could find yourself something to fight and fuck, but you ought to head back to camp first.  You idly reach into your [armor] and slip a finger into your [vagina], feeling your tight walls instinctively clamp down and squeeze it.  It's nice, but it's just so much better when you can do that to a captive cock until it has no choice but to impregnate you with its hot seed.  What better way to save the world than by making sure that the strongest get to breed as often as possible?");
			outputText("\n\nAs you head back to camp to prepare for your next adventure, you realize that you had some really, really fucked up dreams.  You hope you have more tomorrow night.");
			dynStats("lus", 20, "cor", 10, "resisted", false);
			doNext(camp.returnToCampUseFourHours);
			//Add ten more corruption.
		}

		//Grow a Dick!
		public function growADickForFera():void {
			clearOutput();
			outputText("Fera's luscious lips twist up into a knowing smile as you announce your decision.  \"<i>Really? You're a girl after my own heart.  You're going to miss out on experiencing the pleasure I normally give my prey,</i>\" she says with a gesture to one of the tentacle-like stamen as it rises up above your face, dripping its sweet nectar across the bridge of your nose.  \"<i>But, you'll get to feel the bliss of cumming like a man, filling a nice, tight hole with a steaming-hot load of spunk again and again, and you'll even get to play with your cunt while you do it.  Prepare yourself, pet, for the experience of your lifetime.</i>\"");
			outputText("\n\nA juicy-sounding 'schluck' sounds from below your [butt] when she finishes her proclamation, and a tendril far different from its flowery brethren rises up above your [legs], angling down towards your groin with an unflinching, almost robotic attention.  The tip is clearly hollow and lined with thousands of tiny, wiggling cilia, all slick and slimy with some kind of clear ooze, but that isn't what catches your eye.  No, there is something far more menacing protruding from the stalk's opening - a needle-like spike at least four inches long, though only an inch sticks past the lips of the cup-like tendril.");
			outputText("\n\nFera crouches down next to your ear, planting her puffy, ruby kissers up against the lobe of your ear.  \"<i>It won't hurt, my pet champion. It won't hurt at all.  You've far too much of my sap inside you to feel pain by this point.  Instead, the only thing you'll experience is the erotic pleasure of allowing my voice to guide your thoughts and shape your mind, making you hotter, wetter, and more eager for a huge, throbbing cock.</i>\"  She purrs an indecipherable sound of pleasure.  \"<i>Get ready to feel so very good, [name]....</i>\"");
			outputText("\n\nAs soon as Fera trails off, the exotic vine begins to lower itself down, carefully positioning itself squarely above your mons, perhaps an inch above your [clit].  It holds steady there, making minute adjustments this way and that, jerking with each slight change in aim to track your less-than-stationary, suspended form.  There is a moment of complete silence and breathless anticipation, and then, it scythes downwards, slamming into you with sufficient force to rock you down in your organic harness");
			if (player.tailType > TAIL_TYPE_NONE) outputText(" and press your tail to the ground");
			outputText(".  You feel the wetness of the hollow tube as it presses against you along with a lance of pure desire and heat in the very center, undoubtedly caused by the tainted needle as it slips through your unprotected flesh.  The thing is compressed so tightly against you that it looks like the entire injector was able to bury itself in your body.");
			outputText("\n\nYour whole body shudders in surprise before Fera soothes you back into stillness, and then, it begins, not with pain but with a whimper of bliss. You feel that heat grow into a fiery knot before blossoming into a molton-hot ball of tight, aching need. That part of your body feels so... so compressed, almost crushed into place by the flesh around. You shudder and thrust your hips, crying out in eagerness and ecstasy, tears streaming from your empty, dilated eyes as you hump the tentacle in accordance with the drives you can't understand, only obey. The tightness increases until it feels like that spot is about to be crushed by the rest of you, yet you drip hot ladyspunk all over the organic 'floor,' loving every second of it.");
			outputText("\n\nPulling back, the tentacle's cup-like tip stretches away from your body a few inches, its base still sealed tight to your " + player.skinFurScales() + ", tugging and pulling with gentle suction.  There's a moment of insistent, tremendous pressure, upwelling like a long-dormant volcano, and suddenly, the pressure is gone, and gods, it's so fucking hot and good and sensitive and you start to cum, nearly throwing your back out as you scream out in pleasure for your goddess to hear.  There's more of you that feels pleasure than ever and it's so hot, full, and just... twitching with bliss that you can barely stop moaning long enough to breathe.");
			outputText("\n\nThe stalk above your crotch has bulged out significantly, distended with a thicker, concealed shape for the first eight inches of its length, and there are slow bulges traversing up and away from you, each timed to a particularly, bliss-loaded pulse from the new, concealed organ.  Every single, little, wriggling nub inside that hollow tube is stroking and squeezing down on your miraculous new cock, and a pillar of liquid-hot lust is boiling up and out the very middle of it while the spike sits, lodged inside and pumping something else back inside, keeping your orgasm going.");
			outputText("\n\nYou're crying with sublime ecstasy as you let the pleasure consume you, simply feeling yourself constantly erupting, constantly swelling... constantly blissful.  Your eyes roll back, and Fera is whispering into your ear, but the words don't need to be understood, only heard, only left to burrow deeply into your psyche and embed themselves there, right where they can stay and take root.  You slip from consciousness to the feel of your new cock expanding past nine inches in length...");
			//(cum!)
			player.orgasm();
			dynStats("lib", 10, "sen", 10, "cor", 3);
			//Grow a 10" human or tentacle dick! RANDOM!
			player.createCock();
			player.cocks[0].cockLength = 10;
			player.cocks[0].cockThickness = 2.5;
			//Add five corruption.
			player.createPerk(PerkLib.FerasBoonSeeder,0,0,0,0);
			menu();
			player.genderCheck();
			addButton(0,"Next",afterFeraGivesYouACawk);
		}

		public function afterFeraGivesYouACawk():void {
			clearOutput();
			outputText("You awaken fully dressed with a familiar ache between your legs.  Damn, that was a good nap. You rise, scratching your [cock] and smiling as you feel how hard and sensitive it is.  You're already feeling pretty anxious for a fuck, especially after the fucked up wet dreams you had last night, and you resolve to find a nice hole to dump a few loads into before too long.  First, you had better go check back up on your camp.  You've got to bring your A-game if you're going to fuck stronger babies into every weak pussy you come across.");
			//Add ten more corruption.
			//Add 50 lust.
			dynStats("lus", 20, "cor", 10);
			doNext(camp.returnToCampUseFourHours);
		}
	}
}