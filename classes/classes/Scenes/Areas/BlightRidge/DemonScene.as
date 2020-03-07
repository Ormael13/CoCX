/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.BlightRidge 
{

import classes.*;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Dungeons.Factory;
import classes.Scenes.UniqueSexScenes;

//use namespace CoC;
	
	public class DemonScene extends BaseContent
	{
		public var FactoryScene:Factory = new Factory();
		public var uniquuuesexscene:UniqueSexScenes = new UniqueSexScenes();
		
		public function DemonScene() 
		{
			
		}
		
		//CowSuccubus
		
		//Incubus
		public function IncubusEncounter():void {
			clearOutput();
			outputText("As you wander in the ridge, from behind one of trees ahead comes out a purple skinned person.  Or more to be precise a male person.  When he is approaching closer you can clearly see his dick hangging free.  \"<i>I can feel tasty soul in you.  Give it to me!</i>\" he directly command with a manly voice.  Look like there is no way around it, you ready your [weapon] for the fight.");
			startCombat(new Incubus());
			doNext(playerMenu);
		}
		
		public function defeatIncubus():void {
			clearOutput();
			menu();
			outputText("You smile in satisfaction as the incubus collapses, unable to continue fighting.");
			if (player.lust>=33 && player.gender > 0) {
				outputText("\nNow would be the perfect opportunity to taste the fruits of his sex-ready form...\n\nDo you fuck him?");
				if (player.gender == 1) {
					addButton (0, "M. Fuck", IncubusGetsRapedByMale);
					addButton (2, "Service Him", GiveIncubusOral);
					addButton (3, "Catch Anal", FactoryScene.doRideIncubusAnally);
				}
				if (player.gender == 2) {
					if (player.hasVagina() && player.biggestTitSize() >= 4 && player.armor == armors.LMARMOR) addButton(0, "B.Titfuck", lustyPaizuri);
					addButton (1, "F. Fuck", IncubusGetsRapedByFemale);
					addButton (2, "Service Him", GiveIncubusOral);
					addButton (3, "Catch Anal", FactoryScene.doRideIncubusAnally);
				}
				if(player.gender == 3) {
					addButton (0, "M. Fuck", IncubusGetsRapedByMale);
					addButton (1, "F. Fuck", IncubusGetsRapedByFemale);
					addButton (2, "Service Him", GiveIncubusOral);
					addButton (3, "Catch Anal", FactoryScene.doRideIncubusAnally);
				}
				//if (player.lowerBody == LowerBody.PLANT_FLOWER) addButton(7, "Get Pollinated", uniquuuesexscene.alrauneGetPollinatedScene);
			}
			if (monster.HP < 1) addButton (5, "Kill Him", killDemon);
			if (player.pcCanUseUniqueSexScene()) addButton(13, "U. Sex Scenes", uniquuuesexscene.pcUniqueSexScenesChoiceMenu).hint("Other non typical sex scenes.");
			addButton (14, "Leave", cleanupAfterCombat);
		}
		
		public function lustyPaizuri():void {
			clearOutput();
			outputText("You make sure " + monster.a + monster.short + " is comfortably lying down, " + monster.pronoun3 + " " + monster.cockDescriptShort(0) + " exposed to the air");
			if(monster.lust < (monster.maxLust() * 0.5)) outputText(", soft and not yet ready.  You purr throatily as you touch the burgeoning boner, tracing your thumb across the sensitive urethral bulge.  It pulses slowly at your touch, and the base begins to fill with blood, thickening against your palm.  You splay your remaining fingers just under the " + monster.cockHead() + ", tickling around the glans until that too is flooding with blood, expanding under your caresses until it slowly lifts away from " + monster.pronoun3 + " abdomen.");
			else if(monster.lust < monster.maxLust()) outputText(", nicely turgid but quite ready to feel the sensuous pleasure of your girls' tight squeeze.  You lean over the defeated foe and kiss the rod just under the " + monster.cockHead() + ", smiling when it expands under your slow kisses.  Your fingers move up to play with the sensitive, urethral bulge that runs along the underside, and in no time, " + monster.a + monster.short + " is hard as a rock, so ready that " + monster.pronoun3 + " member is lifting up on its own.");
			else outputText(", bouncing with each beat of " + monster.pronoun3 + " heart, thick beads of pre dribbling from " + monster.pronoun3 + " tip as you bat " + monster.pronoun3 + " hands away before " + monster.pronoun1 + " can waste the load " + monster.pronoun1 + "'s saved up for you.");
			outputText("\n\nYour own moistness has risen to uncomfortable levels, and the sticky seal of your g-string's curvy front panel slips oh-so-slightly across your hot, hard clitty, something that makes your [legs] weak and your arms quake.  The leather fold on the front of your undergarments is so slippery that each movement has it shifting and shuffling across your nethers, a tiny bit at a time.  Already, you have your [butt] up in the air, shaking it back and forth for more of the delicious friction.  The motion only exacerbates the jiggling your [chest] are doing inside their tight containment.  " + monster.capitalA + monster.short + "'s head tilts up to watch, an unashamedly lusty look overtaking " + monster.pronoun3 + " features as " + monster.pronoun1 + " enjoys the inadvertent show you're giving.");
			outputText("\n\n\"<i>Such lascivious behavior!  I'll have to make sure you're thoroughly purified,</i>\" you state matter-of-factly with a feigned serious look on your blushing [face].  To put proof to your taunt, you grab the throbbing shaft by the base and aim it straight up, dropping your [chest] down on either side.  The slippery, self-lubricating leather that joins the cups of your sexy, chainmail bra together loops over the top of the " + monster.cockDescriptShort(0) + " to properly restrain it, pinned in the slick, sweaty valley you call your cleavage.  It thrums happily against your [skin] when you compress the jiggly flesh around it, leaning down to let it feel pleasure that rivals any pussy, no matter how wet or skilled.");
			outputText("\n\nYou smile at your defeated foe as you begin to bob over " + monster.pronoun2 + ", and you find more words coming from your lips without meaning to speak.  \"<i>That's better.  You really shouldn't go around trying to fuck everyone like that!  Pussies are ");
			if(!player.hasVirginVagina()) outputText("a gift too fine for a selfish brute like you");
			else outputText("sacred and to be shared only with a cherished loved one");
			outputText("!  Now, I'm going to squeeze all the impure thoughts out of you through your cock, so you just lie there and focus on letting them out all over my breasts.</i>\"");
			outputText("\n\n" + monster.capitalA + monster.short + " nods solemnly while " + monster.pronoun3 + " eyes half-cross from pleasure.  You bottom out around " + monster.pronoun3 + " base");
			if(monster.balls > 0) outputText(" and fondle " + monster.pronoun3 + " balls one-handed, squeezing the virile orbs to try and coax more of " + monster.pronoun3 + " dirty, perverted thoughts to distill into salty seed");
			else outputText(" and stroke " + monster.pronoun3 + " taint, even brushing close to " + monster.pronoun3 + " asshole to try and coax more of " + monster.pronoun3 + " dirty, perverted thoughts to distill into salty seed");
			outputText(".  A startled moan slips out of " + monster.pronoun3 + " lips, but you're just getting warmed up.  You dive down onto " + monster.pronoun3 + " " + monster.cockDescriptShort(0) + ", taking the " + monster.cockHead() + " straight into your mouth with a smooth gulp.");
			if(monster.cockArea(0) >= 80) outputText("  It's so big and strong that it pushes right into your throat, stretching out your neck in the shape of the intruding cock.");
			outputText("  The strong, pulsing cock feels so good inside your mouth, like it belongs there, and you can't help but think that you're doing a good deed by helping " + monster.a + monster.short + " empty every last perverse desire onto your purifying breasts.");
			outputText("\n\nUp and down, up and down, you slide across the expansive member with unhurried, slow strokes, each time making your [chest] bounce beautifully.  Your [nipples] are so hard");
			if(player.hasFuckableNipples() || player.lactationQ() >= 100) outputText(", dripping,");
			outputText(" and sensitive, scraping around the nebulous inner lining of your bikini and occasionally catching on the metal that feels even warmer than normal.  Behind you, your [butt] is bouncing happily to the rhythm your corruption-devouring breasts have set, the thong digging tightly into your [vagina] in the most exquisite way.  You feel so hot and sensual, but still secure in the knowledge that you won't have to worry about such a creature ravaging your ");
			if(player.hasVirginVagina()) outputText("maidenhead");
			else outputText("sloppy gash");
			outputText(".  Still, you're not sure how much hotter you can get before you're cumming all over your g-string, letting your own dark thoughts seep into your magical underwear.");
			outputText("\n\nBelow you, " + monster.a + monster.short + " is moaning out loud and roughly thrusting " + monster.pronoun3 + " hips to meet your every motion, their tip expanding slightly in your mouth as " + monster.pronoun3 + " passion mounts.  You pull back");
			if(monster.cockArea(0) >= 80) outputText(" with a messy cough to clear your throat");
			outputText(" and tease, \"<i>Oh, you're going to cum already, aren't you?  Well, go ahead then.</i>\"  You pump your [chest] faster against the twitching rod and smile when a thick bead of pre sloughs off into your squishy boobs, smearing across your [skin].  You kiss it, licking the dollop that slips out of the dilating cum-slit before commanding, \"<i>Cum for me, " + monster.mf("boy","girl") + ".  Let it allll out.</i>\"");
			outputText("\n\n" + monster.capitalA + monster.short + " groans and shakes");
			if(monster.balls > 0) outputText(", " + monster.pronoun3 + " balls pumping and bouncing in " + monster.pronoun3 + " sack");
			outputText(", " + monster.pronoun3 + " urethra swollen with the heavy load about to explode out of it.  \"<i>Drain out all that nasty jizz,</i>\" you quip as you bottom your breasts down on " + monster.pronoun2 + " and slurp the quivering cock-head into your sperm-hungry lips.  Salty warmth fires in a long rope into your well-prepared mouth and over your tongue.  The blissed out look on your captive foe's face combined with the feel of " + monster.pronoun2 + " giving up all " + monster.pronoun3 + " naughty thoughts thanks to your cleavage gets you so fucking hot that your [hips] begin to shake spastically.");
			outputText("\n\nYou do your best to hold on to the pumping cock while it fires spastic ropes into your mouth, but the way your undies are digging into your [vagina] and grinding across your [clit], you simply lack the control to keep it up.  You throw back your head and cry out ecstatically, taking the next ejaculation in a long line across your cheek, up your nose, and onto your forehead.  Again and again, long ropes of tainted jizz spatter all over your face, dripping messily over the exposed tops of your teats.  You lick your lips while you cream the inside of your [armor] with girlish love-goo, feeling such immense pleasure at letting your own impure desires out into the armor.  More jets, weaker than the early ones, crest from the bouncing cock-tip to fall weakly over your well-slicked mammaries.");
			outputText("\n\nYou seize " + monster.a + monster.short + " by " + monster.pronoun3 + " base and jerk " + monster.pronoun2 + " off with quick, sharp little strokes, commanding, \"<i>All of it!  Give me all of your lusts and cruel desires!</i>\".  " + monster.mf("His","Her") + " back arches as " + monster.pronoun3 + " orgasm redoubles, and fresh ropes begin to spout out again, ensuring your face and breasts are soaked with the sloppy spooge.  It runs in moist, warm rivulets into your concealing top, and what doesn't drip down, you compulsively rub into your skin, feeling a positively healthy glow from the feeling.  You don't free the " + monster.cockDescriptShort(0) + " from your chesty embrace until every single drop is splattered all over you, and when you do, you leave a thoroughly wiped-out " + monster.short + " behind you.");
			outputText("\n\nThe stink of sperm slowly fades as you move, almost seeming to absorb into your skin.  It leaves you with a healthy glow and a surety to your movements, sure that your revealing armor is going to protect you.");
			//Slimefeed, minus slight corruption if PC is a virgin, raise sensitivity
			player.slimeFeed();
			flags[kFLAGS.BIKINI_ARMOR_BONUS] += 2;
			if(flags[kFLAGS.BIKINI_ARMOR_BONUS] > 8) flags[kFLAGS.BIKINI_ARMOR_BONUS] = 8;
			player.orgasm();
			dynStats("sen", 2);
			if(player.hasVirginVagina()) dynStats("cor", -1);
			cleanupAfterCombat();
		}
		
		public function IncubusGetsRapedByMale():void {
			clearOutput();
			outputText("With a few deft motions, you shift your [armor] to expose your ");
			if(player.gender == 3) {
				if(player.balls > 0) outputText(multiCockDescriptLight() + ", [balls], and " + vaginaDescript(0));
				else outputText(multiCockDescriptLight() + " and " + vaginaDescript(0));
			}
			else {
				if(player.balls > 0) outputText(multiCockDescriptLight() + " and " + ballsDescriptLight());
				else outputText(multiCockDescriptLight());
			}
			outputText(".  Having resolved to take the demon's backdoor, you approach his weakened form with brimming confidence.  He looks up, clearly hoping your plan is to squat on his throbbing member.  You dispel his misguided notion when you grab him by the horns and shove his face against the ground. He struggles weakly until you press down harder, making it clear he is to stay in position - on his knees with his head down and his ass in the air.  Circling your prey, you inspect his flawless body and carefully note that the hole at his crotch actually exposes a fair portion of his very supple and surprisingly feminine-looking backside.\n\n");
			outputText("You don't waste any time, gripping your [cock] in one hand and ");
			if(player.cocks[0].cockType == CockTypesEnum.HORSE) outputText("pressing your thick flare ");
			if(player.cocks[0].cockType == CockTypesEnum.DOG) outputText("pressing your pointed tip ");
			if(player.cocks[0].cockType == CockTypesEnum.HUMAN || player.cocks[0].cockType.Index > 2) outputText("pressing your head ");
			outputText("between the incubus' cheeks towards his inhumanly smooth rear-passage.  You gasp in delight at the tight ribbed texture of his asshole as you slide ");
			if(player.cocks[0].cockLength > 10) outputText("deep inside ");
			else outputText("inside ");
			outputText(".  The demon underneath you grunts in an attempt to sound displeased, but it's plain to see the pre-cum he's dripping all over the ground.  What a slut!  You slap his ass and begin roughly butt-fucking him, panting with each plunge into the depths of his ridged passage, gradually increasing your tempo until your " + hipDescript() + " fill the surrounding area with loud slapping noises.");
			if(player.balls > 0) outputText("  Your [balls] swing freely, smacking into the demon's own and making both of you squeal and dribble more pre-cum.");
			outputText("\n\n");
			//(CUM)  
			if(player.balls > 0) outputText("You feel your [balls] draw up tight against your body.  ");
			outputText("Warm heat begins to build inside your groin, pooling under the base of your [cock].  You realize you're about to paint this demon's gut with white, the thought only turning you on more.  ");
			if(player.cumQ() > 200) outputText("You groan as you feel your urethra being stretched by the sheer volume of fluid beginning to shoot through it.  ");
			outputText("You throw back your head and cum, slapping the incubus' ass with one hand while you grip and squeeze the jiggling flesh of his other cheek.  ");
			if(player.cumQ() < 50) outputText("A few thick spurts later and y");
			if(player.cumQ() >= 50 && player.cumQ() < 400) outputText("Thick jets of cum pump into the demon's plump backside, soon building up a wave of pressure that pushes back against you.  Y");
			if(player.cumQ() >= 400) outputText("A massive cock-distending bulge of cum works through your shaft, splashing into the demon's rectum in an explosive burst of pleasure. Unfortunately for your victim, it is only the first of many such cum-blasts. In no time flat, jism is spurting from his overfilled rectum while his belly looks a few months pregnant. You feel weak from discharging so much fluid, and y");
			outputText("ou fall back, the fluid of your orgasm dripping from your [cock] and the gaping asshole of your latest conquest.\n\nYou turn to gather your [armor], and when you look back the demon is gone, leaving only a small puddle of male fluids in his wake.");
			player.orgasm();
			cleanupAfterCombat();
		}
		
		public function IncubusGetsRapedByFemale():void {
			player.slimeFeed();
			clearOutput();
			outputText("With a few deft motions, you shift your [armor] to expose your ");
			//Herm
			if(player.gender == 3) {
				if(player.balls > 0) outputText(multiCockDescriptLight() + ", [balls], and " + vaginaDescript(0));
				else if(player.balls > 0) outputText(multiCockDescriptLight() + " and " + vaginaDescript(0));
			}
			else {
				outputText(vaginaDescript(0));
			}
			outputText(".  Striding forwards with hunger in your eyes, you give your left hand free access to your groin and slip your fingers between the moist folds of your " + vaginaDescript(0) + ".  As you undulate into the incubus' personal space, a swift thrust of your " + hipDescript() + " buries your fingers up to the knuckles and knocks the demon onto his well-muscled back.\n\n");
			outputText("He looks up at you with a practiced eye, adjusting his demon-tool's size to better fill your  " + vaginaDescript(0) + ".  ");
			//(set cocksize = to 80% vaginalCapacity).
			outputText("Thankful for the gesture, you sink down onto him, letting the nubs of his crown stimulate your lips and the underside of your " + clitDescript() + ".  ");
			if(player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_SLICK) outputText("In no time flat your drooling fluids soak him in slippery wetness.  ");
			if(player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_SLICK && player.vaginas[0].vaginalWetness != VaginaClass.WETNESS_DRY) outputText("Before long, you've lubricated a fair portion of his tool with wetness.  ");
			if(player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) outputText("Despite your usual light lubrication, you manage to moisten the top-half of his tool with wetness.  ");
			outputText("Relaxing the muscles in your [legs], you let a few inches of his length slip inside you, every nub and nodule of his corrupted prick filling the walls of your love-canal with inhuman pleasures that make your knees weak.  A particularly delightful bump brushes your " + clitDescript() + ", causing your [legs] to finally give out. The incubus' nubbly cock plunges entirely inside you.\n\n");
			outputText("You gasp and moan like a cheap whore, disgusted by yourself and yet so turned on by the total loss of self-control.  The incubus is leering up at you, having regained some of his lost confidence.  Despite the lust, desire and pleasure burning through the hot pole buried in your abdomen, you work up enough rage to grip his neck with your left hand and practically choke him out.  You work your hips quickly as you feel his pre start to drip into your canal, spreading tingling warmth in the deepest parts of your passage and into your cervix.  You tighten your grip as you forcibly take your pleasure, barking in displeasure at the demon, \"<i>Don't look like you're enjoying this too much bitch, or I'll take it out of your hide.</i>\"  Satisfied at the renewed look of fear in his eyes, you return to using his magnificent tool as a masturbation aid.\n\n");
			outputText("Unable to contain your body's desires due to either the demon's aura or his wonderful penis, you slam your " + vaginaDescript(0) + " onto his member with impunity, twitching and squeezing involuntarily.  His tainted pre-cum begins seeping deep inside your uterus and you cry out with orgasmic intensity.  Your entire body clenches down, even the hand clamped on the incubus' windpipe. You feel his demon-cock swell up inside you in response to his stress, stretching your cunt taut.  His skin darkens from the lack of oxygen as he begins cumming HARD inside you.  Your womb immediately fills with his demon-seed, leaving ribbons of spunk to drip from your tightly-stretched cunt.  You sigh in delight as your muscles slowly stop quivering.  With a pleasured gasp, you rise off the distended demon-prick, and realize that you've choked your foe into unconsciousness. Still, you did let him cum, so maybe he won't mind too much when he wakes.  Feeling sensual and sated, you redress and prepare to come back to the camp. ");
			player.cuntChange(player.vaginalCapacity()*.8, true);
			player.orgasm();
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoyleCorrupted)) player.refillGargoyleHunger(30);
			if (player.jiangshiScore() >= 20 && player.statusEffectv1(StatusEffects.EnergyDependent) < 45) player.EnergyDependentRestore();
			dynStats("cor", 2);
			player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP);
			cleanupAfterCombat();
		}
		
		public function GiveIncubusOral():void {
			player.slimeFeed();
			clearOutput();
			outputText("You lick your lips, moistening them as you decide that the demon will provide your next 'snack'.  Touching the defeated incubus' soft skin, you grab him by the wrists and yank him to his clawed feet. Leaning him back against the near tree as he sways unsteadily, you tenderly slide down his body and take the measure of his monstrous meat with your hands. The smooth skin and tiny bumps slide between each finger as his manhood firms and twitches in response.  You glance up and grab his baseball size nuts, caressing the smooth hairless sack that contains them, watching the demon-man sigh and relax with equal parts desire and relief.\n\n");
			outputText("You lean forwards, opening your mouth ");
			if(player.hairLength > 10) outputText("and brushing a strand of [haircolor] out of the way ");
			outputText("as his shiny purplish monster-cock fills your view. You kiss the tip, swirling your tongue around the nubbly ridge that surrounds the crown.  After a few moments of your tongue's focused attention, you are rewarded with a dollop of slightly sweet pre-cum.  You pause momentarily to smile at your victim before you wrap your hand around as much of him as you can hold and start to jack him off, slowly cramming more and more of his length inside your mouth.  Your free hand continues to fondle his balls, occasionally sliding a finger along the inside of his thigh.\n\n");
			outputText("You feel his balls begin to grow. Perhaps he can sense your thirst for cum, or maybe he just wants to enjoy it - but you are sure he is going to finish spectacularly. They stop swelling just as they reach the size of grapefruits, tingling and pulsing spectacularly in your hand.  You stroke him faster, letting you guzzle his pre as it pours into your greedy mouth.  A coo of delight escapes from your tightly-stretched lips as you savor his tasty fluids.\n\n");
			outputText("The incubus' hips begin humping your face, stuffing a few more inches of his length into your throat and forcing you to struggle against gagging.  His cock swells wider and nearly unhinges your jaw as you feel a gooey warmth wash your throat, flooding your gullet with demon-seed.  Still impaled on his nubby member, your body is rocked back and forth by the strength of his orgasm, the motions making your belly slosh with an increasingly large load.  You moan at the warmth of his corruption seeping through your body as his orgasm diminishes. Yanking back hard, you let his dick slip free of your mouth as the last spurt of cum blasts your face.");
			player.refillHunger(50);
			outputText("\n\n");
			outputText("You push the exhausted demon down and idly collect the cum from your face with your fingers, slowly licking each clean.  Feeling rather sensual and sated, you decide to resume exploring.\n\nAfter redressing you turn about, and see the demon is gone, leaving only a small pool of cum in his wake.");
			cleanupAfterCombat();
		}
		
		public function loseToAIncubus():void {
			player.slimeFeed();
			clearOutput();
			//Nipplefuck city
			if(player.hasFuckableNipples() && player.lust >= player.maxLust()) {
				outputText("Molten arousal pumps through your veins, burning away your reason with an unquenchable desire to mate.  You drop your top, exposing your [allbreasts] to your foe in a submissive display. Lowering your eyes, you hope you can tempt him to plug your " + nippleDescript(0) + " with his demonic prick.  You roughly squeeze each sensitive tit, trailing your fingers down the sensitive breast-flesh towards your rapidly dampening fuck-holes.\n\n");
				outputText("Your eyes relax as pure sensation overwhelms your already over-excited body.  Your fingers find your nipple-holes, locking around them while tugging and squeezing, stretching them tight with pleasure and pain.  You cast a seductive glance to the incubus' groin, noting that he's been taken in by your wanton display.  He takes a step, his cock rippling and twisting as it shifts and changes before your eyes. It divides it half, splitting into two full-sized pricks.");
				if(player.totalNipples() > 2) outputText("  Each of those divides again, splitting into four prehensile penises.");
				if(player.totalNipples() > 4) outputText("  They continue dividing until his wriggling mass is sufficient to penetrate every single nipple and then some.");
				outputText("\n\n");
				outputText("A pleading moan escapes your lips and your captor obliges you, the cocks wriggling forward under their own power and sliding into your slippery " + nippleDescript(0) + "s with ease.  Each member is perfectly sized to stimulate you without over-stretching your tender breast-flesh.  You barely stifle a giggle, drunk on enough pleasure to shatter a lesser mind.  Your giggling is rudely interrupted by something hard and slick forcing itself between your lips.  You smile and slurp on it like a pacifier, swallowing droplets of pre-cum as his tentacle-like pricks fuck your breasts hard and fast, ");
				if(player.biggestLactation() > 1) outputText("splattering milk and pre everywhere.\n\n");
				else outputText("splattering your tits with escaped sexual fluids.\n\n");
				outputText("The demon tenses, pulling your head forwards and burying your nose against his belly.  The dick in your mouth slides down your throat, hanging just above your belly as it begins to fill your gut with bursts of demonic warmth.  Black cum erupts from your nipples as his orgasm overwhelms their meager storage capacity, soaking your tits in his corruptive essence as the pleasure finally breaks your mind.  Your eyes roll back into your head as you begin cumming... and cumming... and cumming. The orgasm drags on and on as more and more cum pours into your body.  Like a passenger in a car you see what's happening but have no control.  Your body is used and abused for hours before you finally drift off to sleep.");
				player.refillHunger(100);
				player.orgasm();
				if (player.isGargoyle() && player.hasPerk(PerkLib.GargoyleCorrupted)) player.refillGargoyleHunger(30);
				if (player.jiangshiScore() >= 20 && player.statusEffectv1(StatusEffects.EnergyDependent) < 45) player.EnergyDependentRestore();
				dynStats("cor", 20);
				cleanupAfterCombat();
				}
		//Tentacle gangbang
			else {
				if(player.lust >= player.maxLust()) outputText("Molten arousal pumps through your veins, burning away your reason with an unquenchable desire to mate. You drop your top, exposing your [allbreasts] to your foe in a submissive display, ");
				else outputText("You lower your top, exposing your nubile form to your foe in a submissive display, ");
				outputText("lowering your eyes and fixating on his now-rigid demonic member.  Right before your eyes, it begins splitting and dividing into thinner prehensile penises that squirm about in the air, each one reminding you of a snake on the prowl.  ");
				if(player.cor < 80) outputText("In a disgusting display");
				else outputText("As you grope yourself noisily with your hand into your undergarments, a salacious smile on your lips");
				outputText(", you watch as his pricks pulse and thicken out until their masses are as wide as his original dick.\n\n");
				if(player.cor >= 80) outputText("As you realize their size and number, you open your eyes wide and smile broadly, reflexively spreading your legs wide, practically begging him to fuck you.  ");
				outputText("In a flash, each fat tentacle-cock whips out and surrounds your body in slick demon-flesh.  The tentacles constrict, working in pairs to take off every piece of your [armor].  ");
				if(player.biggestTitSize() >= 2) outputText("They make sure to rub each of your breasts, spending a few seconds smearing slick pre-cum into your " + nippleDescript(0) + ".  ");
				outputText("A pair of them slides into your undergarments, pressing against your needy crotch and teasing your " + assholeDescript() + " with more slick demonic cum.  ");
				if(player.cor < 80) outputText("You wriggle and whine,");
				else outputText("You grab the thick tentacle-cock working on your cunt with both hands, as you can barely grab it with one. Then,  while letting out moans fit for a bitch in heat, which you are, you begin ");
				if(player.vaginas.length > 0) outputText("squeezing your legs around them and grinding your " + clitDescript() + " against the oddly textured demon-cock.");
				else {
					if(player.balls > 0) outputText("grinding down against the ribbed and textured demonic cock as it slides between your [balls].");
					else if(player.cocks.length > 0) outputText("squeezing your legs around the thick demonic flesh as a steady dribble of pre-cum drips from your [cock].");
					if(player.gender == 0) outputText("grinding suggestively on your captor's rods, barely noticing as the last of your [armor] falls away.");
				}
				outputText("\n\n");
				//FUCKKKING
				//Female paragraph
				if(player.vaginas.length > 0 && (player.cocks.length == 0 || rand(2))) {
					outputText("The incubus at last decides to tend to your over-aroused body and pulls you off the ground with his tentacles, suspending you in mid-air.  ");
					if(player.cor < 80) outputText("You feel your [legs] lifted and pulled tight as countless demonic cocks encircle your body, binding and constraining you further.  You whimper as a demonic tentacle probes your back door while a thicker one lines itself up just below your " + clitDescript() + ".  ");
					else outputText("As he lifts you, you spread your legs, showing him your cunt which is dripping wet from anticipation, and grabbing your ass to give him a perfect view of your " + assholeDescript() + ".  You then beg him, between lecherous moans, to use his three biggest tentacles, as you want to have the most sensations.  With a sadistic smile, he lines up two tentacle cocks about as big as your arm over your " + vaginaDescript(0) + " and your " + assholeDescript() + ".  ");
					outputText("You then giggle and try to wiggle your " + hipDescript() + " forward, begging for him to take you and quench the fire burning in your " + vaginaDescript(0) + ".  The incubus obliges, pressing forth with both drooling members and simultaneously plugging your front and back doors.  ");
					if(player.cor < 80) outputText("You gasp from pleasure and surprise, ");
					else outputText("You open your mouth wide, as the enormous tentacle-cocks force their way in, dripping demonic pre-cum all over. Quickly, it acts as additional lubricant, and the pain largely subsides.  You find that these massive demonic cocks' size is perfect to stimulate, in an incredibly pleasurable way, all sides of your cunt at once, and to stretch your ass just a bit over your preferred size.  As the incubus starts moving his appendages in rhythm, you're lost in heavenly pleasure, eyes closed, letting out deafening moans of lust, your legs and arms dangling without any thought for dignity.  You are deeply ");
					outputText("enjoying the knobbed texture of his shafts as you're double-penetrated by a single demon. The incubus smirks as another cock-tentacle wraps itself up around your neck like a shiny student collar and plugs your noisy little mouth.  You groan into his member as you're ");
					if(player.cor < 80) outputText("squeezed and caressed by the writhing tentacle-pricks in and around your body, lost in the pleasure and taste of demonic pre-cum.\n\n");
					else outputText("getting roughly fucked by the two tentacle-cocks at the same time.  Taking the tentacle-cock in your mouth with both hands, you eagerly swallow every bit of demonic pre-cum, then suckle on the huge cock-slit. \n\n");
					
					//FemCum
					if(player.clitLength > 3) outputText("You nearly cum on the spot when the cock fucking your pussy loops its length around your " + clitDescript() + ", the cum-slickened coils driving you mad with pleasure as they coil, slide, and jerk around your clit as if it was a cock.  ");
					else outputText("You nearly cum on the spot when the cock fucking your pussy curves up to rub its textured nodules against your " + clitDescript() + ".  ");
					player.cuntChange(player.vaginalCapacity()*.8, true);
					if(player.cor >= 80) outputText("You cum more times than you are able to count, each time causing a tightening of your fuckholes, which increases the rubbing against the demonic nodules and sends another wave of pleasure to your dazed brain.  You begin to drool freely, reveling in this most unholy mating.  ");
					outputText("The prick in your mouth surges forward, sliding deep into your throat.  The coils around your neck tighten in response, choking your neck into a tight cock-sleeve as you feel bulges of cum moving along its length.  In moments you feel your belly starting to grow full, sloshing with cum as you become desperate to breathe.  The tentacles lodged in your " + assholeDescript() + " and " + vaginaDescript(0) + " react in similar fashion, stretching you wide as they begin pumping your body full of vast quantities of spunk.  A few free tentacles begin spurting gobs of the white stuff onto your [skin.type], soaking you in the stuff as you black out from a combination of oxygen deprivation and pleasure.");
					player.refillHunger(100);
					player.orgasm();
					if (player.isGargoyle() && player.hasPerk(PerkLib.GargoyleCorrupted)) player.refillGargoyleHunger(30);
					if (player.jiangshiScore() >= 20 && player.statusEffectv1(StatusEffects.EnergyDependent) < 45) player.EnergyDependentRestore();
					dynStats("cor", 25);
					player.buttChange(monster.cockArea(0), true);	
					cleanupAfterCombat();
					}
				//Male/Genderless
					else {
						outputText("The incubus at last decides to tend to your over-aroused body and pulls you off the ground with his tentacles, suspending you in mid-air.  You feel your [legs] lifted and pulled tight as countless demonic cocks encircle your body, binding and constraining you further.  You whimper as a demonic tentacle probes your back door, slathering your " + assholeDescript() + " with a nubby cock-head as it slowly presses forward and fills you with incredible tainted warmth.  Each nub and ridge that grinds past your sphincter bumps against the organs in your backdoor and fills you with pleasure that only increases as more of the demonic pre-cum is wicked into your body.  The gasp you started fades into a soft croon of pleasure before being muffled entirely by another thick prick.  The shaft belonging to the dick in your mouth curls around your neck like the collar a pet or submissive slut would wear.");
						if(player.cocks.length > 0) outputText("  As your body's orifices fill with more and more dripping demonic dick-flesh, your [cock] becomes painfully hard.  Another tentacle wastes no time in wrapping itself tightly around the base like a cock-ring.  The rest of the demon's prehensile tool slides along your shaft, curling around to squeeze and jerk you off.");
						if(player.balls > 0) outputText("  You groan around the dick plugging your throat as another tentacle-like appendage wraps around your " + sackDescript() + ", pulling your [balls] down and gently squeezing them.");
						outputText("\n\n");
						//Genderless Orgasm
						if (player.gender == 0) outputText("The tainted cum mixed with the sensation of fullness provide you with pleasures beyond what your genderless body could accomplish on its own.  You writhe as the demon face-fucks you with one tendril while another continues to bury itself ever-deeper into your abused " + assholeDescript() + ".  ");
						if(player.cocks.length > 0) outputText("The cock-tentacle around your [cock]  increases the pace of its stimulation as it begins to spurt hot wet cum over you, giving it lubrication as it jacks you off while staying tight around your base to prevent you from an orgasming.  ");
						outputText("You feel cum pulse through the tentacles encircling you as the incubus loses control of his tentacles.  Cum pumps into your belly, suffusing you with drug-like warmth as the tentacle around your neck pulls tight enough to squeeze the cock inside your throat.  You squirm and gasp for oxygen as spooge begins unloading into and around your body to the point where you aren't sure where your body begins and the demonic-spunk ends.  You twitch in what you assume is orgasm as you fight to breathe; all the while more cum is squeezed into your stuffed belly and ruined anus. The tentacle in your ass backs out slowly, having filled every inch of your intestines with cum, until it pops free with a splatter.");
						outputText("\n\n");
						if(player.cocks.length > 0) {
							outputText("Being so thoroughly used and stimulated pushes you over the edge of orgasm, and your ");
							if(player.balls > 0) outputText("balls");
							else outputText("prostate");
							outputText(" unloads with enough force to squeeze past the constrictor clutching at your groin.\n\n");
							//Small cum
							if(player.cumQ() < 50) outputText("You groan and orgasm with enough force to splatter a few ropes of cum into the sea of demon-spunk that soaks you from head to toe.  ");
							//Big cum
							if(player.cumQ() >= 50 && player.cumQ() < 400) outputText("Your orgasm goes off like a shotgun blast, splattering the incubus with a huge wad of cum.  It's but the first of many, and though each load of jizz is of comparable size, the force behind them diminishes until the last few blasts drip down your body and soak your [legs] and [feet].  ");
							//Huge cum
							if(player.cumQ() >= 400) outputText("Your orgasm goes off like a volcano, visibly distending your [cock] as a huge wave of cum erupts from your groin, painting the incubus and floor with your spoo.  You cry from the sheer pleasure as the next wave builds and erupts, nearly as large as the last.  The demon-cock controlling your prick aims this blast up, forcing you to soak your " + hairDescript() + " and face with slick goo. The orgasming drags on and on while you slowly turn blue from oxygen deprivation. Before long, both you and the incubus are buried under a wave of white.  ");
							}
							outputText("The feeling is so intense that your " + hipDescript() + " twitch and move of their own volition while your eyes roll back in pleasure.\n\n");
							outputText("You black out just as you feel the cock-tentacle in your throat retracting. You dully feel your body drop to the ground, your pregnant-looking belly sloshing with demon jizz.");
							player.refillHunger(100);
							player.buttChange(monster.cockArea(0), true);
							player.orgasm();
							if (player.isGargoyle() && player.hasPerk(PerkLib.GargoyleCorrupted)) player.refillGargoyleHunger(30);
							if (player.jiangshiScore() >= 20 && player.statusEffectv1(StatusEffects.EnergyDependent) < 45) player.EnergyDependentRestore();
							cleanupAfterCombat();
					}
				}
		}
		
		//MinoIncubus
		
		//Omnibus
		public function OmnibusEncounter():void {
			clearOutput();
			outputText("As you wander in the ridge, from behind one of trees ahead comes out a purple skinned person.  On first glance it seems to be a female person.  When she is approaching closer despite rags covering some of her body you noticing demonic cock hangging free.  \"<i>I can feel tasty soul in you.  Give it to me!</i>\" she directly command yet still using a gentle feminine voice.  Look like there is no way around it, you ready your [weapon] for the fight.");
			startCombat(new Omnibus());
			doNext(playerMenu);
		}
		
		public function defeatOmnibus():void {
			clearOutput();
			menu();
			outputText("You smile in satisfaction as the omnibus collapses, unable to continue fighting.");
			if (player.lust>=33 && player.gender > 0) {
				outputText("\nNow would be the perfect opportunity to taste the fruits of her sex-ready form...\n\nDo you fuck her?");
				if (player.gender == 1 || player.gender == 3) addButton (0, "M. Fuck", OmnibusGetsRapedByMale);
				if (player.gender == 2 || player.gender == 3) addButton (1, "F. Fuck", OmnibusGetsRapedByFemale);/*
				if (player.lowerBody == LowerBody.PLANT_FLOWER) {
					addButton(2, "Seeding", uniquuuesexscene.alrauneSeedingScene);
					addButton(3, "Get Pollinated", uniquuuesexscene.alrauneGetPollinatedScene);
				}*/
			}
			if (monster.HP < 1) addButton (5, "Kill Her", killDemon);
			if (player.pcCanUseUniqueSexScene()) addButton(13, "U. Sex Scenes", uniquuuesexscene.pcUniqueSexScenesChoiceMenu).hint("Other non typical sex scenes.");
			addButton (14, "Leave", cleanupAfterCombat);
		}
		
		public function OmnibusGetsRapedByMale():void {
			clearOutput();
			if (player.cockArea(0) <= monster.vaginalCapacity()) {
				//[Male] Fuck 'Dat Pussah
				//[lust]
				if (monster.lust > 99) {
					outputText("Ignoring her squeals of pleasure, you force omnibus onto her back, oogling her perky breasts, indecent cock, and soaked cunt.  She looks up at you hungrily, and you have the feeling that on some level you're still giving her what she wants.  Mindful of her demonic wiles, you pull her hands together and use a few tattered strips of cloth to bind them over her head.  Moaning with helpless desire, the demon grinds her crotch against your [leg], spreading her thighs apart into a near split and giving you a world-class view of her juicy purple cunt.\n\n");
				}
				//[hp]
				else {
					outputText("Ignoring her grunts of pain, you force omnibus onto her back, oogling her perky breasts, limp cock, and hairless cunt.  She looks up at you with disdain, growling at you from the back of her throat.  Wary of the demon's abilities, you tie up her hands with a few tattered strips of cloth.  She seems to like it, judging by her tenting erection and now-glistening gash.  The slut even goes so far as to begin grinding her crotch against you, spreading her thighs wider and wider as she gets off on being restrained.  You're given a perfect view of her enticing purple cunt.\n\n");
				}
				outputText("Omnibus licks her lips and gazes up at you, begging with a voice that drips with seductive intent, \"<i>Please don't rape me, champion!  Don't tie me down and rape me like a helpless village-girl!</i>\"\n\n");
				if (player.cor < 33) outputText("Her words shame you.  Have you really sunk this low?  You wonder just how much this world has already corrupted you as you ready yourself to rape a sex-demon.");
				else if (player.cor < 66) outputText("Her words confuse you.  You never would've done this when you first came here, but you're horny and you know demons don't really mind.");
				else outputText("Her dishonest words anger you, and you slap her in the face.  Both of you know that she wants this almost as much as she wanted to rape you, and any pretense at disliking this act is a deceitful sham.");
				outputText("  It's too late for her to have any hope of swaying you anyway.  You strip off your [armor] ");
				outputText("and begin stroking ");
				if (player.cockTotal() > 1) outputText("each of ");
				outputText("your stiff [cocks], preparing to penetrate her.\n\n");
				outputText("Omnibus squirms in the dirt as you bring your [cock] closer and closer to her female hole, her cock twitching with need like some kind of perverse, mutant clit.  Her hips twitch at you, as if eager to devour your maleness.  You don't keep her waiting, ");
				if (player.cockArea(0) < 40) {
					outputText("and with a forceful thrust, you sheath yourself inside the demon's unholy pussy");
				}
				else outputText("and with a mighty effort, you force your over-sized cock inside her.  For a moment all you can do is stare in awe as it distorts her body – the fact that such a thing is possible puzzles you");
				outputText(".  Her interior is inhumanly hot and covered with thousands of slippery protrusions, each rubbing against your dick's flesh.  The orgy of sensation is incredible, and you immediately begin fucking your bound, demonic captive as the need to orgasm rises within you.\n\n");
				outputText("The defeated omnibus mewls in mock protest, \"<i>Oh, don't cum in my demonic twat, dear champion!  If you do, you'll never want any other pussy ever again!</i>\"\n\n");
				outputText("You grunt, pounding her harder and faster than before, knowing you couldn't pull out of her vise-like pleasure-hole if you wanted to.  It feels too good to hold out or resist, and you drop down, adjusting your angle as you rape the beautiful omnibus.  You're grunting like an animal, humping her as fast as your body will let you, but she lies under you with a serene and enticing expression, as if she's greatly enjoying the situation and awaiting your orgasm.  You pinch her nipple roughly, irritated by her superior air, but it only makes her wriggling pussy get even wetter.  It clamps down on you, wringing your [cock] dry as it erupts in a powerful orgasm.\n\n");
				outputText("Omnibus squeals happily, her sultry visage fracturing into an uninhibited expression of pleasure as she cries, \"<i>Fill me with your seed, champion!  Dominate the demon with your mighty spear!</i>\"\n\n");
				outputText("Her purple-hued pussy spasms around you, its oddly textured interior rippling and sucking in time with your ejaculations, drinking down your cum.  Omnibus squirms happily while her body absorbs your jizz with her impossibly pleasurable hole.");
				if (player.cumQ() >= 500 && player.cumQ() < 1000) outputText("  Her belly begins to rise with the volume of cum she's absorbed, and you finish your orgasm with a mildly pregnant demon underneath you.");
				else if (player.cumQ() >= 1000) outputText("  Her belly rises quickly from the volume of cum you're pumping into her, swelling up until she looks ready to give birth, but her taut purple body seems to handle the strain quite well, save for her belly-button turning into an outtie with an abrupt 'pop'.");
				outputText("  The omnibus' nubby shaft twitches happily and squirts out tiny dribbles of demon-semen, too left out by the sex to achieve a truly enjoyable orgasm, but more than willing to leak cum.\n\n");
				outputText("Omnibus exhales with exhaustion and rubs her hands over her belly, cooing, \"<i>So, you really did give up all your semen to me.  I guess I'll have to name the first imp I birth from this after you, won't I?</i>\"\n\n");
				if (player.cor < 33) outputText("You groan, just wishing she would stop reminding you of the consequences of this little tryst.  In a hurry to leave the demon behind, you get dressed and take off for camp.\n\n");
				else if (player.cor < 66) outputText("You groan, wondering why she just won't get over her little act.  Even though this wasn't your best idea, it isn't nearly as bad as she makes it out to be.  You get dressed and leave, eager to be rid of her.\n\n");
				else outputText("You bend over, rub her belly softly and whisper into her ear, \"<i>I'll be sure to spit him on my cock first chance I get, dear.</i>\"\n\n");
				outputText("As you leave, you don't bother to spare a glance at the confused omnibus.  She isn't worth your time.");
			}
			else {
				//[MALE TOO DAMN BIGGA WIGGA]
				//[lust] 
				if (monster.lust > 99) outputText("Ignoring her squeals of pleasure, you force omnibus onto her back, oogling her perky breasts, indecent cock, and soaked cunt.  She looks up at you hungrily, and you have the feeling that on some level you're still giving her what she wants.  Wary of the demon's wiles, you pull her hands together and use some scraps of cloth to bind them up.  Moaning with helpless desire, the demon grinds her crotch against your [leg], spreading her thighs apart into a near split and giving you a world-class view of her juicy purple cunt.\n\n");
				//[hp] 
				else outputText("Ignoring her grunts of pain, you force omnibus onto her back, oogling her perky breasts, limp cock, and hairless cunt.  She looks up at you with disdain, growling at you from the back of her throat. Wary of the demon's abilities, you tie up her hands with a few pieces of tattered cloth.  She seems to like it, judging by her tenting erection and now-glistening gash.  The slut even goes so far as to begin grinding her crotch against you, spreading her thighs wider and wider as she gets off on being restrained.  You're given a perfect view of her enticing purple cunt.\n\n");
				outputText("Omnibus licks her lips and gazes up at you, begging with a voice that drips with seductive intent, \"<i>Please, don't rape me Champion!  Don't tie me down and rape me like a helpless village-girl!</i>\"\n\n");
				if (player.cor < 33) outputText("Her words shame you.  Have you really sunk this low?  You wonder just how much this world has already corrupted you as you ready yourself to rape a sex-demon.");
				else if (player.cor < 66) outputText("Her words confuse you.  You never would've done this when you first came here, but you're horny and you know demons don't really mind.");
				else outputText("Her dishonest words anger you, and you slap her in the face.  Both of you know that she wants this almost as much as she wanted to rape you, and any pretense at disliking this act is a deceitful sham.");
				outputText("  It's too late for her to have any hope of swaying you anyway.  You strip off your [armor] ");
				outputText("and begin stroking ");
				if (player.cockTotal() > 1) outputText("each of ");
				outputText("your stiff [cocks], preparing to penetrate her.\n\n");
				outputText("The [cockhead] of your [cock] squishes flat against her twat, too big for her prodigious demon-cunt to swallow.  Spurred by frustrated desires, you lift her legs and wrap her girlcum-slicked thighs about your ");
				if (player.cockTotal() > 1) outputText("primary ");
				outputText(cockDescript(0) + ". Omnibus's smooth skin and soft thigh-flesh form a comfortably tight masturbation tube.  Starting slowly, you begin rocking back and forth, sawing your prodigious cock-flesh over her body.  The demoness swivels her hips underneath your [cock], her slippery gash and near-crushed member feverishly rubbing into you.  Though you didn't get to truly violate her, her thighs and unblemished skin are more than good enough to bring you to the brink of orgasm.\n\n");
				outputText("The defeated omnibus wraps her arms around your [cock] and whines lustily, \"<i>No, please!  You'll cover me in seed and despoil my face!  Please don't glaze me in that awful stuff!</i>\"\n\n");
				outputText("You grunt, hold the captive by her ankles, and use her like a disposable sex-toy.  The slap of your " + hipDescript() + " slapping into her thighs echoes loudly, nearly drowning out the wet squishing of your [cock] with each violent brush against her cuntlips.  ");
				if (player.cocks[0].cockLength < 18) outputText("Your [cockhead] crests between her breasts with every stroke, bumping against her chin.  It grows larger as the pleasure of the act intensifies to orgasmic levels.\n\n");
				else if (player.cocks[0].cockLength < 24) outputText("Your [cockhead] slides over her cheek with every stroke, leaving a trail of pre-cum on her face.  The smudges of glistening pre grow larger and larger as the pleasure of the act nears orgasmic levels.\n\n");
				else outputText("Your [cock] slides over her face with every stroke, smearing the demon's hair with your thick pre-seed before you pull back and dribble it on her face.  The pleasure of the act is incredible, and you feel yourself getting harder as the sensation nears orgasmic levels.\n\n");
				outputText("Omnibus squeals and blubbers incoherently for a moment as she cums, eventually managing to scream out, \"<i>Yes, splatter me with seed!  Punish this lowly demon with your powerful spunk.  Dominaaaaate meeee~</i>\"\n\n");
				outputText("Underneath your own mammoth erection, you can feel omnibus's smaller cock twisting and squirming, unloading its own hot fluids onto her sweat-slicked belly.  She wriggles and twitches under you, her thigh muscles clenching and releasing in time with her spurts as they push you beyond your limit.  You watch your [cock] as it strains and squirts, dumping your thick load into the demon's ");
				if (player.cocks[0].cockLength < 18) outputText("tits");
				else if (player.cocks[0].cockLength < 24) outputText("face");
				else outputText("long hair");
				outputText(".  The orgasming demonette continues to squirt underneath you, drenching and smearing herself with even more cum and her entire mid-section looks glazed in thick whitish goo.");
				if (player.cumQ() >= 1000) outputText("  Your prodigious fertility quickly forms a puddle around her, leaving the deceptive seductress practically submerged in cum.");
				outputText("\n\n");
				outputText("You sigh, feeling immense relief, and remove your softening bulk from atop her form.  Omnibus exhales in exhaustion and smears the mixture of cum over her belly, cooing, \"<i>So you really did give me a huge load.  I'll be sure to scoop a few batches of it into my womb so we can have lots of imps together.</i>\"\n\n");
				if (player.cor < 33) outputText("You groan, just wishing she would stop reminding you of the consequences of this little tryst.  In a hurry to leave the demon behind, you get dressed and take off for camp.\n\n");
				else if (player.cor < 66) outputText("You groan, wondering why she just won't get over her little act.  Even though this wasn't your best idea, it isn't nearly as bad as she makes it out to be.  You get dressed and leave, eager to be rid of her.\n\n");
				else outputText("You bend over, rub her belly softly and whisper into her ear, \"<i>I'll be sure to spit them on my cock first chance I get, dear.</i>\"\n\n");
				outputText("As you leave, you don't bother to spare a glance at the confused omnibus; she isn't worth your time.");
			}
			player.orgasm();
			dynStats("lib", 3, "sen", 3, "cor", 1);
			cleanupAfterCombat();
		}
		
		public function OmnibusGetsRapedByFemale():void {
			player.slimeFeed();
			clearOutput();
			//lust
			if (monster.lust > 99) outputText("Ignoring her squeals of pleasure, you force omnibus onto her back, oogling her perky breasts, indecent cock, and soaked cunt.  She looks up at you hungrily, and you have the feeling that on some level you're still giving her what she wants. Wary of the demon's wiles, you pull her hands together and use some tattered strips of cloth to bind them up.  Moaning with helpless desire, the demon grinds her crotch against your [leg], spreading her thighs apart into a near split and giving you a world-class view of her pulsating black demon-cock.\n\n");
			//[hp] 
			else outputText("Ignoring her grunts of pain, you force omnibus onto her back, oogling her perky breasts, limp cock, and hairless cunt.  She looks up at you with disdain, growling at you from the back of her throat.  Mindful of the demon's abilities, you tie up her hands with some tattered strips of cloth.  She seems to like it, judging by her tenting erection and now-glistening gash.  The slut even goes so far as to begin grinding her crotch against you, spreading her thighs wider and wider as she gets off on being restrained.  You're given a perfect view of her pulsating black demon-cock.\n\n");
			outputText("Omnibus licks her lips and gazes up at you, begging with a voice that drips with seductive intent, \"<i>Please don't rape me!  I took a vow of chastity!</i>\"\n\n");
			if (player.cor < 33) outputText("Her words shame you.  Have you really sunk this low?  You wonder just how much this world has already corrupted you as you ready yourself to get off on a sex-demon's tool.");
			else if (player.cor < 66) outputText("Her words confuse you.  You never would've done this when you first came here, but you're horny and you know demons don't really mind.");
			else outputText("Her dishonest words anger you, and you slap her in the face.  Both of you know that she wants this almost as much as she wanted to rape you, and any pretense at disliking this act is a deceitful sham.");
			outputText("\n\nIt's too late for her to have any hope of swaying you anyway.  You strip off your [armor] ");
			outputText("and begin touching your " + vaginaDescript(0) + ", getting yourself ready for what is to come.\n\n");
			outputText("You sink down, feeling yourself part around the hot demon-tool, its ring of crown-nubs stroking your walls as you slide down, and the bumpy texture of its shaft makes your [legs] feel weak.  You drop the rest of the way down in one smooth, wet slide, ");
			if (player.vaginalCapacity() < 12) outputText("unable to take the entire exquisite cock inside you.  The nubs squirm and wiggle, practically vibrating and massaging your internal muscles, and you're unable to stop yourself from bouncing on top of her, spearing yourself repeatedly upon the thick rod.\n\n");
			else outputText("able to take the entire exquisite cock inside you.  The nubs squirm and wiggle, practically vibrating and massaging your internal muscles, and you're unable to stop yourself from bouncing on top of her, spearing yourself repeatedly upon the thick rod.\n\n");
			outputText("Omnibus cries in mock protest, \"<i>No, don't make me cum inside you!  Please Champion, I swore not to spill my seed, lest I father a bastard child!</i>\"\n\n");
			outputText("The sensations of her vibrating nodules ensure you don't have the will or the strength to pull off of her, and what little power your [legs] have is used to keep bouncing and grinding on top of her, filling the air with wet squelches and slippery squishes.  You fall forwards, barely catching yourself before you slam into the sultry demoness.  Your ");
			if (player.biggestTitSize() < 1) outputText("chest ");
			else outputText("tits ");
			outputText("squish against hers, squeezing a gout of milk from her nipples.  Both pairs of ");
			if (player.biggestTitSize() < 1) outputText("nipples");
			else outputText("jiggling mounds");
			outputText(" feel wonderful as they're pressed between you, sliding back and forth in time with your body's urgent grinding.\n\n");
			outputText("The omnibus' facade of feigned innocence drops under the force of the hot, wet fuck.  Her mouth opens into an 'o' of pleasure, and you feel her rod thicken as it begins pumping the proof of her ecstasy inside you.  The nodules that cover omnibus's demonic erection wildly vibrate as she orgasms, throwing you over the edge and into the midst of a body-shaking orgasm.  Demon-seed floods your womb, squeezed inside it by your body's orgasmic contractions.  You shudder with the demon as you both begin calming down.\n\n");
			outputText("She groans, \"<i>Ooooh... Champion why did you make me despoil your womb?  ");
			if (player.pregnancyIncubation == 0) outputText("You're only feeding the swarms of imps that are despoiling this land.");
			else outputText("I'm sure whatever baby you have in there won't enjoy being so soaked in corruption.");
			outputText("</i>\"\n\n");
			if (player.cor < 33) outputText("You groan, just wishing she would stop reminding you of the consequences of this little tryst.  In a hurry to leave the demon behind, you get dressed and take off for camp.\n\n");
			else if (player.cor < 66) outputText("You groan, wondering why she just won't get over her little act.  Even though this wasn't your best idea, it isn't nearly as bad as she makes it out to be.  You get dressed and leave, eager to be rid of her.\n\n");
			else outputText("You bend over and rub your belly while whispering in her ear, \"<i>Like mother, like child.</i>\"\n\n");
			outputText("As you leave, you don't bother to spare a glance at the confused omnibus; she isn't worth your time.\n\n");
			player.cuntChange(monster.cockArea(0), true);
			player.orgasm();
			dynStats("lib", 3, "sen", 3,"cor", 1);
			player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 32, 61); //Ceraph causes faster pregnancies
			cleanupAfterCombat();
		}
		
		public function loseToAOmnibus():void {
			player.slimeFeed();
			clearOutput();
			//Nipplefuck city
			if(player.hasFuckableNipples() && player.lust >= player.maxLust()) {
				outputText("Molten arousal pumps through your veins, burning away your reason with an unquenchable desire to mate.  You drop your top, exposing your [allbreasts] to your foe in a submissive display. Lowering your eyes, you hope you can tempt her to plug your " + nippleDescript(0) + " with her demonic prick.  You roughly squeeze each sensitive tit, trailing your fingers down the sensitive breast-flesh towards your rapidly dampening fuck-holes.\n\n");
				outputText("Your eyes relax as pure sensation overwhelms your already over-excited body.  Your fingers find your nipple-holes, locking around them while tugging and squeezing, stretching them tight with pleasure and pain.  You cast a seductive glance to the omnibus' groin, noting that she's been taken in by your wanton display.  She takes a step, her cock rippling and twisting as it shifts and changes before your eyes. It divides it half, splitting into two full-sized pricks.");
				if(player.totalNipples() > 2) outputText("  Each of those divides again, splitting into four prehensile penises.");
				if(player.totalNipples() > 4) outputText("  They continue dividing until his wriggling mass is sufficient to penetrate every single nipple and then some.");
				outputText("\n\n");
				outputText("A pleading moan escapes your lips and your captor obliges you, the cocks wriggling forward under their own power and sliding into your slippery " + nippleDescript(0) + "s with ease.  Each member is perfectly sized to stimulate you without over-stretching your tender breast-flesh.  You barely stifle a giggle, drunk on enough pleasure to shatter a lesser mind.  Your giggling is rudely interrupted by something hard and slick forcing itself between your lips.  You smile and slurp on it like a pacifier, swallowing droplets of pre-cum as her tentacle-like pricks fuck your breasts hard and fast, ");
				if(player.biggestLactation() > 1) outputText("splattering milk and pre everywhere.\n\n");
				else outputText("splattering your tits with escaped sexual fluids.\n\n");
				outputText("The demon tenses, pulling your head forwards and burying your nose against her belly.  The dick in your mouth slides down your throat, hanging just above your belly as it begins to fill your gut with bursts of demonic warmth.  Black cum erupts from your nipples as her orgasm overwhelms their meager storage capacity, soaking your tits in her corruptive essence as the pleasure finally breaks your mind.  Your eyes roll back into your head as you begin cumming... and cumming... and cumming. The orgasm drags on and on as more and more cum pours into your body.  Like a passenger in a car you see what's happening but have no control.  Your body is used and abused for hours before you finally drift off to sleep.");
				player.refillHunger(100);
				player.orgasm();
				dynStats("cor", 20);
				cleanupAfterCombat();
			}
		//Tentacle gangbang
			else {
				if(player.lust >= player.maxLust()) outputText("Molten arousal pumps through your veins, burning away your reason with an unquenchable desire to mate. You drop your top, exposing your [allbreasts] to your foe in a submissive display, ");
				else outputText("You lower your top, exposing your nubile form to your foe in a submissive display, ");
				outputText("lowering your eyes and fixating on her now-rigid demonic member.  Right before your eyes, it begins splitting and dividing into thinner prehensile penises that squirm about in the air, each one reminding you of a snake on the prowl.  ");
				if(player.cor < 80) outputText("In a disgusting display");
				else outputText("As you grope yourself noisily with your hand into your undergarments, a salacious smile on your lips");
				outputText(", you watch as her pricks pulse and thicken out until their masses are as wide as her original dick.\n\n");
				if(player.cor >= 80) outputText("As you realize their size and number, you open your eyes wide and smile broadly, reflexively spreading your legs wide, practically begging her to fuck you.  ");
				outputText("In a flash, each fat tentacle-cock whips out and surrounds your body in slick demon-flesh.  The tentacles constrict, working in pairs to take off every piece of your [armor].  ");
				if(player.biggestTitSize() >= 2) outputText("They make sure to rub each of your breasts, spending a few seconds smearing slick pre-cum into your " + nippleDescript(0) + ".  ");
				outputText("A pair of them slides into your undergarments, pressing against your needy crotch and teasing your " + assholeDescript() + " with more slick demonic cum.  ");
				if(player.cor < 80) outputText("You wriggle and whine,");
				else outputText("You grab the thick tentacle-cock working on your cunt with both hands, as you can barely grab it with one. Then,  while letting out moans fit for a bitch in heat, which you are, you begin");
				if(player.vaginas.length > 0) outputText("squeezing your legs around them and grinding your " + clitDescript() + " against the oddly textured demon-cock.");
				else {
					if(player.balls > 0) outputText("grinding down against the ribbed and textured demonic cock as it slides between your [balls].");
					else if(player.cocks.length > 0) outputText("squeezing your legs around the thick demonic flesh as a steady dribble of pre-cum drips from your [cock].");
					if(player.gender == 0) outputText("grinding suggestively on your captor's rods, barely noticing as the last of your [armor] falls away.");
				}
				outputText("\n\n");
				//FUCKKKING
				//Female paragraph
				if(player.vaginas.length > 0 && (player.cocks.length == 0 || rand(2))) {
					outputText("The omnibus at last decides to tend to your over-aroused body and pulls you off the ground with her tentacles, suspending you in mid-air.  ");
					if(player.cor < 80) outputText("You feel your [legs] lifted and pulled tight as countless demonic cocks encircle your body, binding and constraining you further.  You whimper as a demonic tentacle probes your back door while a thicker one lines itself up just below your " + clitDescript() + ".  ");
					else outputText("As she lifts you, you spread your legs, showing her your cunt which is dripping wet from anticipation, and grabbing your ass to give her a perfect view of your " + assholeDescript() + ".  You then beg her, between lecherous moans, to use her three biggest tentacles, as you want to have the most sensations.  With a sadistic smile, she lines up two tentacle cocks about as big as your arm over your " + vaginaDescript(0) + " and your " + assholeDescript() + ".  ");
					outputText("You then giggle and try to wiggle your " + hipDescript() + " forward, begging for her to take you and quench the fire burning in your " + vaginaDescript(0) + ".  The omnibus obliges, pressing forth with both drooling members and simultaneously plugging your front and back doors.  ");
					if(player.cor < 80) outputText("You gasp from pleasure and surprise, ");
					else outputText("You open your mouth wide, as the enormous tentacle-cocks force their way in, dripping demonic pre-cum all over. Quickly, it acts as additional lubricant, and the pain largely subsides.  You find that these massive demonic cocks' size is perfect to stimulate, in an incredibly pleasurable way, all sides of your cunt at once, and to stretch your ass just a bit over your preferred size.  As the omnibus starts moving his appendages in rhythm, you're lost in heavenly pleasure, eyes closed, letting out deafening moans of lust, your legs and arms dangling without any thought for dignity.  You are deeply ");
					outputText("enjoying the knobbed texture of her shafts as you're double-penetrated by a single demon. The omnibus smirks as another cock-tentacle wraps itself up around your neck like a shiny student collar and plugs your noisy little mouth.  You groan into her member as you're ");
					if(player.cor < 80) outputText("squeezed and caressed by the writhing tentacle-pricks in and around your body, lost in the pleasure and taste of demonic pre-cum.\n\n");
					else outputText("getting roughly fucked by the two tentacle-cocks at the same time.  Taking the tentacle-cock in your mouth with both hands, you eagerly swallow every bit of demonic pre-cum, then suckle on the huge cock-slit. \n\n");
					
					//FemCum
					if(player.clitLength > 3) outputText("You nearly cum on the spot when the cock fucking your pussy loops its length around your " + clitDescript() + ", the cum-slickened coils driving you mad with pleasure as they coil, slide, and jerk around your clit as if it was a cock.  ");
					else outputText("You nearly cum on the spot when the cock fucking your pussy curves up to rub its textured nodules against your " + clitDescript() + ".  ");
					player.cuntChange(player.vaginalCapacity()*.8, true);
					if(player.cor >= 80) outputText("You cum more times than you are able to count, each time causing a tightening of your fuckholes, which increases the rubbing against the demonic nodules and sends another wave of pleasure to your dazed brain.  You begin to drool freely, reveling in this most unholy mating.  ");
					outputText("The prick in your mouth surges forward, sliding deep into your throat.  The coils around your neck tighten in response, choking your neck into a tight cock-sleeve as you feel bulges of cum moving along its length.  In moments you feel your belly starting to grow full, sloshing with cum as you become desperate to breathe.  The tentacles lodged in your " + assholeDescript() + " and " + vaginaDescript(0) + " react in similar fashion, stretching you wide as they begin pumping your body full of vast quantities of spunk.  A few free tentacles begin spurting gobs of the white stuff onto your [skin.type], soaking you in the stuff as you black out from a combination of oxygen deprivation and pleasure.");
					player.refillHunger(100);
					player.orgasm();
					dynStats("cor", 25);
					player.buttChange(monster.cockArea(0), true);	
					cleanupAfterCombat();
				}
				//Male/Genderless
				else {
					outputText("The omnibus at last decides to tend to your over-aroused body and pulls you off the ground with her tentacles, suspending you in mid-air.  You feel your [legs] lifted and pulled tight as countless demonic cocks encircle your body, binding and constraining you further.  You whimper as a demonic tentacle probes your back door, slathering your " + assholeDescript() + " with a nubby cock-head as it slowly presses forward and fills you with incredible tainted warmth.  Each nub and ridge that grinds past your sphincter bumps against the organs in your backdoor and fills you with pleasure that only increases as more of the demonic pre-cum is wicked into your body.  The gasp you started fades into a soft croon of pleasure before being muffled entirely by another thick prick.  The shaft belonging to the dick in your mouth curls around your neck like the collar a pet or submissive slut would wear.");
					if(player.cocks.length > 0) outputText("  As your body's orifices fill with more and more dripping demonic dick-flesh, your [cock] becomes painfully hard.  Another tentacle wastes no time in wrapping itself tightly around the base like a cock-ring.  The rest of the demon's prehensile tool slides along your shaft, curling around to squeeze and jerk you off.");
					if(player.balls > 0) outputText("  You groan around the dick plugging your throat as another tentacle-like appendage wraps around your " + sackDescript() + ", pulling your [balls] down and gently squeezing them.");
					outputText("\n\n");
					//Genderless Orgasm
					if (player.gender == 0) outputText("The tainted cum mixed with the sensation of fullness provide you with pleasures beyond what your genderless body could accomplish on its own.  You writhe as the demon face-fucks you with one tendril while another continues to bury itself ever-deeper into your abused " + assholeDescript() + ".  ");
					if(player.cocks.length > 0) outputText("The cock-tentacle around your [cock]  increases the pace of its stimulation as it begins to spurt hot wet cum over you, giving it lubrication as it jacks you off while staying tight around your base to prevent you from an orgasming.  ");
					outputText("You feel cum pulse through the tentacles encircling you as the omnibus loses control of her tentacles.  Cum pumps into your belly, suffusing you with drug-like warmth as the tentacle around your neck pulls tight enough to squeeze the cock inside your throat.  You squirm and gasp for oxygen as spooge begins unloading into and around your body to the point where you aren't sure where your body begins and the demonic-spunk ends.  You twitch in what you assume is orgasm as you fight to breathe; all the while more cum is squeezed into your stuffed belly and ruined anus. The tentacle in your ass backs out slowly, having filled every inch of your intestines with cum, until it pops free with a splatter.");
					outputText("\n\n");
					if(player.cocks.length > 0) {
						outputText("Being so thoroughly used and stimulated pushes you over the edge of orgasm, and your ");
						if(player.balls > 0) outputText("balls");
						else outputText("prostate");
						outputText(" unloads with enough force to squeeze past the constrictor clutching at your groin.\n\n");
						//Small cum
						if(player.cumQ() < 50) outputText("You groan and orgasm with enough force to splatter a few ropes of cum into the sea of demon-spunk that soaks you from head to toe.  ");
						//Big cum
						if(player.cumQ() >= 50 && player.cumQ() < 400) outputText("Your orgasm goes off like a shotgun blast, splattering the omnibus with a huge wad of cum.  It's but the first of many, and though each load of jizz is of comparable size, the force behind them diminishes until the last few blasts drip down your body and soak your [legs] and [feet].  ");
						//Huge cum
						if(player.cumQ() >= 400) outputText("Your orgasm goes off like a volcano, visibly distending your [cock] as a huge wave of cum erupts from your groin, painting the omnibus and floor with your spoo.  You cry from the sheer pleasure as the next wave builds and erupts, nearly as large as the last.  The demon-cock controlling your prick aims this blast up, forcing you to soak your " + hairDescript() + " and face with slick goo. The orgasming drags on and on while you slowly turn blue from oxygen deprivation. Before long, both you and the omnibus are buried under a wave of white.  ");
					}
					outputText("The feeling is so intense that your " + hipDescript() + " twitch and move of their own volition while your eyes roll back in pleasure.\n\n");
					outputText("You black out just as you feel the cock-tentacle in your throat retracting. You dully feel your body drop to the ground, your pregnant-looking belly sloshing with demon jizz.");
					player.refillHunger(100);
					player.buttChange(monster.cockArea(0), true);
					player.orgasm();
					cleanupAfterCombat();
				}
			}
		}
		
		//Succubus
		public function SuccubusEncounter():void {
			clearOutput();
			outputText("As you wander in the ridge, from behind one of trees ahead comes out a blue skinned person.  Or more to be precise a female person.  When she is approaching closer despite rags covering some of her body you not notice any 'addition' at her crotch.  \"<i>I can feel yummy soul in you.  Would you kindly give it to me?</i>\" she blurt directly.  Look like there is no way around it, you ready your [weapon] for the fight.");
			if (flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] <= 0) {
				flags[kFLAGS.CODEX_ENTRY_SUCCUBUS] = 1;
				outputText("\n\n<b>New codex entry unlocked: Succubus!</b>")
			}
			startCombat(new Succubus());
			doNext(playerMenu);
		}
		
		public function defeatSuccubus():void {
			clearOutput();
			menu();
			outputText("You smile in satisfaction as the succubus collapses, unable to continue fighting.");
			if (player.lust>=33 && player.gender > 0) {
				outputText("\nNow would be the perfect opportunity to taste the fruits of her sex-ready form...\n\nDo you fuck her?");
				if(player.gender == 1) addButton (0, "M. Fuck", SuccubusGetsRapedByMale);
				if(player.gender == 2) addButton (1, "F. Fuck", SuccubusGetsRapedByFemale);
				if(player.gender == 3) {
					addButton (0, "M. Fuck", SuccubusGetsRapedByMale);
					addButton (1, "F. Fuck", SuccubusGetsRapedByFemale);
				}
				//if (player.lowerBody == LowerBody.PLANT_FLOWER) addButton(2, "Seeding", uniquuuesexscene.alrauneSeedingScene);
			}
			if (monster.HP < 1) addButton (5, "Kill Her", killDemon);
			if (player.pcCanUseUniqueSexScene()) addButton(13, "U. Sex Scenes", uniquuuesexscene.pcUniqueSexScenesChoiceMenu).hint("Other non typical sex scenes.");
			addButton (14, "Leave", cleanupAfterCombat);
		}
		
		public function SuccubusGetsRapedByMale():void {
			clearOutput();
			//(LUSTY) 
			if(monster.lust > 99) outputText("Panting hotly, the succubus staggers towards you, her eyes fixated on the bulge in your crotch.  Dark viscous liquid drips from her dusky folds as her hips undulate hypnotically.  Blue fingers smear the corrupted lubricants over the smooth outer folds of her sex as she lies back enticingly, giving up on anything but bedding you.  In moments your [armor] are on the floor and you approach your prize.\n\n");
			//(HP) 
			else outputText("The succubus collapses on the floor, groaning in pain.  Most of her rags have been destroyed by the combat and her blue skin is marked with deep purple bruises and bloody lacerations.  You undress, straddling your conquest and gazing down on her helpless, curvaceous form.  She looks up at you and forces a smile, licking the blood from a cracked lip and beginning to masturbate for you.\n\n");
			//START ZE RAEP CANNONZ
			outputText("While pondering the best way to take your horny prize, her complexion begins to change, the marks of combat disappearing from her toned body.  The demonic horns crowning her perfect visage begin withdrawing into her head, and her hair ");
			if(player.hairLength > monster.hairLength) outputText("lengthens");
			else outputText("shortens");
			outputText(", shifting to [haircolor].  The bone structures of her cheeks, nose, and face shift ever so slightly, and you suddenly realize you are looking down at a slutty version of yourself!  You aren't sure if it's the growing pool of succubus fluid below you or how hot your female twin is, but your [cock] is as hard as a rock.\n\n");
			outputText("Well, you DID decide to rape her, and now you know that you ARE smoking hot.  You shrug and shove your fem-double's legs apart, exposing her glistening fuck-target.  You bend down and bite her nipple as you position yourself at her entrance, allowing her to grasp your [cock] and coat it with her slick dark fluids.  It tingles as the tainted cunt-juices wick up into your dick like the oil from a lantern back home. At first it burns painfully, as if badly sunburned, but you adjust to the discomfort and marvel as your skin turns blackish-purple. Midnight-colored nodules sprout along the upper and lower portions of your [cock], perfectly shaped to tease clits.  Just under its head, a ring of larger growths emerge, somewhat pointy, but flexible, rubbery and incredibly sensitive.  Your [cock] gets harder and harder as it grows slightly beyond its normal size.  It tugs your groin forwards, practically leaping towards its demonic mate on its own volition.  You cave in and press forwards, parting her folds and submerging your crown in corruptive bliss.\n\n");
			//((TOO BIG))
			if(player.cockArea(0) > monster.vaginalCapacity()) {
				outputText("But the pleasure is short-lived, as even her altered physiology can't accommodate your massive tool. With a grunt of frustration you yank your hungry demonic cock away from your goal.  She smiles knowingly and massages her breasts, releasing streams of the same black fluid from her tumescent nipples. It coats the valley of her pornstar-sized breasts, allowing the fluid to flow down and pool in her tight little belly button.\n\n");
				outputText("\"<i>This will, like, be even better anyways stud!</i>\" coos a higher pitched you, smashing her tits together wetly for emphasis.  Viscous strings of lubricants form a mesmerizing lattice between her mountainous tits as she puts on a show for you.  Entirely of its own accord, your [cock] drags you into her web of corruption, plopping itself firmly into the river of desire that fountains from the peaks on either side. With a steady rhythm, you rock your " + hipDescript() + " back and forwards, plunging into her delicious fuckpillows without abandon. With an inhuman strength, she pushes them together, forcing them to completely encircle your over-sized pole with a tight ring of corruption-dripping tit-flesh.\n\n");
				player.cocks[0].cockType = CockTypesEnum.DEMON;
				//[normal]
				if(player.cumQ() < 50) outputText("Droplets of pre begin to escape your cock-slit every time your sensitive nodules pass between your fem-clone's wondrous pleasure-tits.  You fuck harder, no longer caring if it's your choice or your cock's, mashing your purplish head against her lips with every stroke.  The flash-fire of an orgasm sweeps over you, over-engorging the nodules all over your cock and doubling their size.  Your hips resort to tiny rocking motions as you rub your cock-slit into your fem-self's open mouth, blasting thick ropes of tainted black cum into her mouth. Though you quickly empty of cum and collapse onto her, your " + hipDescript() + " continue to fuck like a machine.  All you can do is hang on to your meat and try to stay conscious as your demonic prick feasts on your double.\n\n");
				//[high]
				if(player.cumQ() >= 50 && player.cumQ() < 500) {
					outputText("A steady stream of pre begins to escape your cock-slit, drooling over your double's face and tits as you pound away at her bouncing ring of titflesh.  Every new bump and nodule seems as sensitive as your entire maleness used to be.  Every thrust into the dark wet prison only makes your pre-cum drool faster and your [cock]'s new adornments grow fuller and even more tender.  In a flash, the fire of orgasm overwhelms your body's new taint-saturated cock.  Like a kinky 'wave', each nodule from the base to the pointy ring at your crown grows larger as your muscles clench.  ");
					if(player.balls > 0) outputText("Your [balls] practically glow with relief as they begin contracting.  Their entire surface is covered with black veins that radiate from your demonic prick, sharing the corruption with your sperm factories.  ");
					outputText("You throw back your head as the first wave of release pours from your tip, splattering your female clone with inky black cum!  The color startles you for a moment before the next blast moves down your shaft, visibly distending your urethra until it bursts free to coat her hair.  Your hips keep moving of their own accord, massaging the crown-ring with tits during each thrust forwards and accompanying cumshot.  By the fourth load, your double is opening her soaked lips wide and guzzling it down.  By the sixth she's sputtering and coughing as the black sex juice sloughs off her.  By the ninth she's managed to clamp her lips over your cock-tip, and her throat bulges ludicrously with the effort of taking each load.  Thankfully, your orgasm finally winds down.  As the last few globs of inky jism escape from you, you realize your hips are still moving, plunging your massive possessed tool into its new favorite place.  Sighing, you hang onto your endowment and try to stay conscious in spite of your exhaustion and the overwhelming feelings coming from your groin.\n\n");
				}
				//[ultrahigh]
				if(player.cumQ() >= 500) {
					outputText("A river of pre-cum begins pouring from your cock-tip's slit, soaking your slutty double's face and tits as it mixes with the corruptive fluids already smeared about.  The alien bumps and nodules upon your [cock] flex and twitch at every pass through the fuck-able foe's soft tits, slowly growing as they absorb more of your slut-self's taint.  The tight squeeze around your newly retextured [cock] overwhelms any sense of control you may have had as your arousal-soaked groin takes over completely.  You begin pounding the tit-pussy as if your life depended on it, jack-hammering  your [cock] forward and back hard enough to make the mountains of breast ripple and shake like jello during an earthquake.  The ring of pointed nodules around your crown continues to swell and grow with every pass through the inky passage, soaking up more and more of the corruption until they are each nearly two inches long.  Overwhelmed by the pleasure, your eyes roll back and a mighty orgasm comes to boil in your groin.  ");
					if(player.balls > 0) outputText("Your " + ballsDescript() + " twitch and shake, the veiny surface of your sack darkening as the corruption begins to fill them.  ");
				}
				outputText("Still, your possessed maleness is far from finished as it continues to slide along her belly and between her still-dripping tits, and before long you feel another orgasm building.  You hang on for dear life, hoping just to stay conscious through the ordeal...\n\nHour later you pull away, sated.  For now.");
			}
			//((IT FITS))
			else {
				outputText("You plunge in to her velvety depths and feel her rippling cunt-muscles contract tightly around you for a perfect fit.  She gasps as each cock-distorting nodule bounces her two-inch clitty, making your mirror image moan like a bitch in heat.  The corrupted fluids dripping from her snatch squelch loudly, making your groin burn with pleasure.  ");
				if(player.balls > 0) outputText("Looking down, you even see the veins on your sack darkening to solid black as the corruption begins tainting your sperm-factories.  ");
				outputText("You pull back, letting the ring of pointed fleshy barbs spring free before plunging them back in. The pleasure makes you swoon, nearly forcing you to orgasm on the spot.  ");
				if(player.biggestTitSize() > 0) outputText("Your female double reaches down to pinch your nipple, spurring you on, \"<i>Please, could you like, cum for me?</i>\"");
				//New PG
				outputText("\n\n");
				player.cocks[0].cockType = CockTypesEnum.DEMON;
				outputText("The succubus bucks her hips weakly, still clearly defeated, but egging on your orgasm as dark fluids squelch free from her quim.  \"<i>Please... can't you see how hot you're making me?  I've made your cock perfect, so please make me cum!</i>\" she begs as she quivers with delight.  ");
				outputText("You pause to think about it, not noticing that your groin is pounding away with furious energy, splattering cum and pre over her thighs as your new cock's instincts take control from your waist down.  Gasping with sudden pleasure, you feel a flash of heat pass through your tainted meatstick as an orgasm builds.");
				//New PG
				outputText("Each of the new bumps and rounded spines of your [cock] flood with blood, doubling in size as orgasm overtakes you.  ");
				outputText("Your hips bury your entire length inside her, acting on their own as your [cock] clenches, pouring more and more spunk inside her");
				if(player.balls > 0) outputText(" as your balls empty their load queue");
				outputText(".  ");
				//Big cum
				if(player.cumQ() >= 50 && player.cumQ() < 400) outputText("You inhale as black cum spatters from her entrance, her belly distending slightly as you empty what feels like a gallon inside her.  ");
				//((Ginormohuge)) 
				if(player.cumQ() >= 400) outputText("Gasping in pleasure and surprise, you marvel as her belly visibly expands with each eruption of your dark load.  At first it looks like a tiny belly, but by the time the orgasm finishes, your girlish double looks like a woman in her ninth month of pregnancy – with twins.");
				outputText("\n\nYou pant with exertion and pull back, only to have your [cock] plunge right back in. Beginning another rough fucking session, your hips force-fuck her beyond your control.  Exhausted, you lean over her, figuring you may as well enjoy your double's wondrous breasts until your demonic cock has finally sated itself.  You just hope you don't black out from the waves of pleasure each of your new nubs radiates.\n\n\nHours later you pull away, sated.  For now.");
			}
			outputText("\n\nThe succubus licks her fingers clean, looking totally recovered.  In the blink of an eye, she dashes out and disappearing in the distance.");
			player.orgasm();
			dynStats("cor", 5);
			cleanupAfterCombat();
		}
		
		public function SuccubusGetsRapedByFemale():void {
			clearOutput();
			if(monster.HP < 1) outputText("Your foe staggers and falls hard on her ass, utterly defeated.  Her bruises and lacerations slowly fade and heal, regenerating with the aid of her demonic powers.  You easily tear through her clothes. It doesn't take much to force her down on her back and straddle her as you disrobe, ready to take your pleasure.\n\n");
			else outputText("Your foe drops to her knees, stuffing three digits into her greedy snatch as arousal overcomes her desire to subdue you.  With great care, you approach your insensible enemy and tear off her clothes as you force her down on her back.  As if possessing a will of their own, her legs lewdly spread as you disrobe.\n\n");
			outputText("Her budding clit rises from between her folds, hardening like a tiny three inch dick.\n\n");
			if(player.biggestLactation() > 1) {
				menu();
				outputText("<b>You could scissor with her, or maybe force-feed her some of the milk you've backed up.  Which will it be?</b>");
				addButton (0, "Scissor", ScissorSuccubus);
				addButton (1, "Force Feed", ForcefeedSuccubus);
			}
			//No choices if not lactating...
			else {
				ScissorSuccubus();
			}
		}
		
		public function ScissorSuccubus():void {
			clearOutput();
			outputText("You shiver with anticipation as you hook your leg under her thick thighs, lining up your " + vaginaDescript(0) + " as you press forwards.  The anticipation builds as your matched honeypots grow ever closer.  Making contact, your folds part as her purplish-red clit slips betwixt your nether-lips, vibrating slightly in tune with the succubus' heartbeats.  You gasp, feeling your own " + clitDescript() + " erecting and rubbing against her smooth mound.\n\n");
			if(player.clitLength >= 3) outputText("You groan with wanton desire as your " + clitDescript() + " continues to grow and grow until reaching full size and slipping inside the defeated slut's sloppy pleasure-hole.  ");
			outputText("It takes only a few seconds to get the succubus' juices really flowing, the sounds of your grinding hips dissolving into a cacophony of liquid squelches.  The gooey corrupt fem-cum tingles, spreading warmth through every patch of skin it touches.  Your locked hips writhe and twist with her's, eliciting pants and squeals from the both of you.  In no time flat, you find yourself cumming and feel your " + vaginaDescript(0) + "'s muscles clench hungrily with an unquenchable desire to be filled.  The succubus shivers in pleasure, probably feeding off your orgasm.  You back off, fingering your " + vaginaDescript(0) + " languidly and denying her a full meal.  Pouting, the succubus dips her fingers back in, determined to cum.");
			outputText("\n\nYou turn away with a bemused sigh.  When you glance back, she has vanished!");
			player.orgasm();
			dynStats("cor", 1);
			cleanupAfterCombat();
		}
		
		public function ForcefeedSuccubus():void {
			clearOutput();
			outputText("You chuckle as you decide to release some of the pent up pressure in your [allbreasts].  Laying down over your conquest, you grasp her wrists and pin them to the floor as you shove your tits in her face");
			if(player.biggestTitSize() > 6) outputText(", nearly smothering the succubus with the swell of tit-flesh");
			outputText(".  You jiggle back and forth, lining up a " + nippleDescript(0) + " with the demon's parted lips.  You press your weight down threateningly, making it clear you could suffocate her with a boob.\n\n");
			outputText("\"<i>Drink up bitch, these tits are full!</i>\" you command.\n\n");
			outputText("The succubus tentatively takes a " + nippleDescript(0) + " into her mouth, sighing at the tangy taste of your sweat-drenched skin.  Her lips gently suckle, wrapping around the perky hardening nub as it fills with arousal and milk.  You feel something let go inside your " + breastDescript(0) + " and the succubus smiles, now working to free more of your trapped cream.\n\n");
			if(player.biggestLactation() < 2) outputText("Her flexible tongue easily curls around one of your " + nippleDescript(0) + "'s, letting her pull and tug on it as she increases the suction from her lips.  Your body rewards her efforts with a faster flow of milk that she sucks down as if she were starving.\n\n");
			if(player.biggestLactation() >= 2 && player.biggestLactation() < 3) {
				outputText("Her flexible tongue wraps around your milk-engorged nipple, pulling it tightly as she increases the suction of her lips.  Your body wastes no time rewarding her and she begins gulping down a steady supply of your breastmilk with a pleased expression on her face. You muse to yourself that perhaps succubi are masochists as breast-milk runs freely from your un-milked ");
				if(player.totalBreasts() > 2) outputText("tits.\n\n");
				else outputText("tit.\n\n");
			}
			if(player.biggestLactation() >= 3 && player.biggestLactation() < 4) {
				outputText("Her flexible tongue wraps around a milk-swollen nipple, immediately squeezing out a jet of thick breast-milk.  The tongue squeezes and tugs while the succubus ramps up the suction between her thick bee-stung lips.  Your body rewards her with fountains of milk, forcing her to visibly gulp and struggle to keep up with the heavy flow.  Milk runs freely down the [skin.type] on your chest, pooling around the succubus' groin and your own as the unattended nipple");
				if(player.totalBreasts() > 2) outputText("s");
				outputText(" can't help but dribble in sympathy.\n\n");
			}
			if(player.biggestLactation() >= 4) {
				outputText("Her flexible tongue wraps around a milk-bloated nipple, immediately releasing a massive spray of cream that pours into her gullet, nearly choking her.  You stifle a giggle and pull her closer.  Thankfully, her determined tongue manages to stay in place and start tugging your nipple about, releasing even more of your over-large milk production.  She struggles, her throat and cheeks bulging from your explosive output of milk, until it overwhelms her and begin to pour out of her nose.  More milk pours from your unoccupied nipple");
				if(player.totalBreasts() > 2) outputText("s");
				outputText(" in sympathy, drenching your [skin.type] with creamy goodness until it puddles on your captive demon.\n\n");
			}
			if(player.totalNipples() == 2) outputText("As your first nipple drains, you move her to your other breast, being sure to motivate her cunt by grinding it with your [foot].  She squeals and sucks harder, emptying the last of your milk with a cute burp.  ");
			if(player.totalNipples() > 2 && player.totalNipples() < 6) outputText("As your first " + nippleDescript(0) + " drains, you forcibly move her to the next, unleashing a fresh batch of milk for her to feast upon.  Eventually, it too dries up, so you migrate her onwards to your next " + nippleDescript(0) + ".  After she drains each of your " + num2Text(player.totalNipples()) + ", you smile happily at your now emptied breasts.  ");
			if(player.totalNipples() >= 6) outputText("As your first " + nippleDescript(0) + " drains, you force her over to the next, unleashing even more milk for her to feast upon.  In time, that " + nippleDescript(0) + " also empties and you rotate her on to the next.  The cycle repeats seemingly endlessly as you work her from nipple to nipple, relieving the insistent pressure of your breasts and slowly filling her with your milk.  ");
			if(player.averageLactation() * player.totalBreasts() < 6) outputText("Her belly bulges slightly from all the breast-milk she's consumed.\n\n");
			else outputText("The succubus looks bloated and pregnant from all the milk you've forced into her.  She sloshes and moans incoherently from the strain of it all.\n\n");
			outputText("Despite the relief your [allbreasts] now feel, your " + vaginaDescript(0));
			if(player.cocks.length > 0) outputText(" and [cocks] feel hungrier than ever.  ");
			else outputText(" feels hungrier than ever.  ");
			outputText("You shove your crotch into your milk-dazed foe's white-stained visage, grinding your " + vaginaDescript(0) + " into her mouth until you cum all over her");
			if(player.cocks.length == 0) {
				if(player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_SLAVERING) outputText(", soaking her with girl-cum.");
				else {
					if(player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_WET) outputText(", slicking her face with girlish cum.");
					else outputText(", drenching her with a deluge of girlcum.");
				}
			}
			else outputText(", and unloading a wave of hot spunk into her hair.");
			outputText("\n\nYou push her over, noting that her freed fingers immediately bury themselves in her demonic snatch, loudly squelching as she tends to her own arousal.  Her perfect visage is a mess, coated with musky girlcum");
			if(player.cocks.length > 0) outputText(" and a thick layer of spunk");
			outputText(".");
			outputText("\n\nYou turn away with a bemused sigh.  When you glance back, she has vanished!");
			dynStats("lus", -50);
			cleanupAfterCombat();
		}
		
		public function loseToASuccubus():void {
			clearOutput();
			if(player.cocks.length > 0) {
				if(player.lust >= player.maxLust()) outputText("Driven half mad with lust, you drop to your knees. Your fingers fly over your body as you pry off every last piece of your [armor], displaying just how hard your alluring opponent has gotten you.  The succubus saunters over, every sinuous step radiating the inhuman sexuality that pours off her skin like heat from a bonfire.\n\n");
				else outputText("Exhausted, you collapse before the succubus.  She effortlessly slices away your [armor], peeling your possessions away with practiced ease.  In moments you are stark naked and wholly exposed to your captor.  In spite of yourself, your body begins to respond to her sultry aura, displaying the hardness of your desire and shame immediately.\n\n");
				outputText("\"<i>Awww, did I get you all <b>HOT</b> and bothered?</i>\" She croons, poising foot above you as her high-heels seem to fade away.  Warm skin begins to press against your groin as slender toes curl around the head of your throbbing maleness, your foe having her way with your desire-saturated form.  You mewl pitifully at the sensation, your hips twitching involuntarily against her demonic sole. The slippery surface of her foot squeezes as she expertly strokes you with her foot, delighting in her complete dominance over your easily controlled member.\n\n");
				//balls or pussy play
				if(player.balls > 0) {
					//[[balls]]
					if(player.ballSize < 6) outputText("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses your [balls] with soft touches.  Almost immediately you feel them clench with boiling heat, growing heavy and churning with a load big enough to satisfy a thirsty succubus.");
					//[[huge balls]]
					else outputText("Your sultry captor leans low, marveling at the size of your [balls] as she reaches down to caress them.  Her tits swing lewdly above you, bouncing in hypnotic motions. Her hands work gently, taking each one of your [balls] and hefting it gently.  Almost immediately you feel them fill with an unnatural heat that spreads everywhere her slender fingers touch.  They begin to feel full and heavy, practically sloshing as the pent up need inside you is channeled into liquid form.  \"<i>So ripe... and full,</i>\" she whispers to herself as she caresses them, her foot still sliding all over your [cock], pumping stroke after stroke of pleasure into your lust-weakened form.");
				}
				else {
					//[[no balls no pussy]]
					if(player.vaginas.length == 0) outputText("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses the skin between your [cock] and " + assholeDescript() + " with a slender finger.  Almost immediately you feel your groin clench with the boiling heat of a growing orgasm, thick cum churning out from your prostate as your body readies a load large enough to satisfy a thirsty succubus.");
					//[[no balls + pussy]]
					else outputText("Your sultry captor leans low over you, her luscious tits wobbling enticingly as she reaches down and caresses the slick skin of your slit with a single digit.  Other fingers circle your " + clitDescript() + ", teasing it from between the folds as it grows hard, peeking out from the hood and turning cherry-red.  Almost immediately you feel your groin clench with the boiling heat of a growing orgasm, thick cum churning in your prostate as your body readies a load large enough to satisfy a thirsty succubus.");
				}
				outputText("\n\n");
				//[[Cum]]
				outputText("The succubus licks her lips in anticipation as she curls her toes tighter around you, making you bulge and twitch in obscene pleasure.  With a naughty smile, she caresses your ass with her bulbous demonic tail.  Before you can react, it plunges inside you, easily slipping through your " + assholeDescript() + " and pressing tightly against your prostate.  The suddenness pushes you over the edge, but she immediately wraps her fingers around you, pinching tightly, bottling your cum inside you.  You cry out in pain and surprise as your entire thick load is trapped inside you.  After nearly a full minute, your groin aches with the discomfort of it all.\n\n");
				//More cum paragraph.  HAHA! TINY BABY CUM! 
				outputText("She wastes no time, and caresses you again.  You instantly feel another surge of heat and desire as a fresh load of cum brews behind your first strangled orgasm.  You need to cum so bad, her foot still stroking and squeezing you full of perverted desire.  She slaps your ");
				if(player.balls > 0) outputText("balls");
				else outputText("ass");
				outputText(" as she releases your [cock], shouting, \"<i>CUM!  Feed me!</i>\"  You are all too happy to oblige.  ");
				//[[normal volume]]
				if(player.cumQ() < 50) outputText("Freed at last, your body clenches tightly as it squirts the first jet of cum from your [cock].  She smears her foot over the head, catching the cum and using it to lubricate her silken foot as it massages your member with merciless strokes, alternatively catching your spooge and milking more from your obedient maleness.  Your orgasm lasts many times longer than normal as your dual loads feed her demonic hunger.");
				//[[big volume]]
				if(player.cumQ() >= 50 && player.cumQ() < 400) outputText("Freed at last, your body clenches tightly as it spurts a big glob of cum onto her waiting sole, soaking the bottom of her foot with slippery male-milk.  She smears her cum-covered foot over every inch of your [cock], making each successive spurt bigger and messier than the last. Somehow she manages to catch more and more of your jizm over her foot, bathing you in cummy silkiness.  You groan helplessly as she milks more and more of from you till her foot is dripping steadily, your own groin and belly soaked with the stuff.  You give a few final exhausted squirts as she languidly rubs it into you.");
				//[[huge volume]]
				if (player.cumQ() > 400) outputText("Freed at last, your body clenches powerfully as a massive eruption of cum launches from your [cock] onto her waiting foot.  The succubus looks on incredulously as her entire foot is soaked with your sticky whiteness, forgetting to move as the second wave of cum drenches her to the ankle and rains down over your stomach.  She giggles and moves it back to your cock, massaging your slick spooge into your cock with her foot, wringing an even bigger explosion of cum from your tortured body.  Flopping back, she gets her other foot in on the action, milking you between her feet as you soak yourself completely with bigger and bigger eruptions until at last your orgasm begins to wane.  She slides forwards, rubbing against you and smearing the mess over herself with a blissful expression.");
				outputText("\n\n\"<i>Good boy,</i>\" she croons, but you don't have time to ponder the meaning of that as you lose consciousness.");
				player.orgasm();
				dynStats("cor", 5);
				cleanupAfterCombat();
			}
			else {
				if(player.lust >= player.maxLust()) {
					outputText("Driven half mad with lust, you shake yourself free from the trappings of your [armor], first revealing your [allbreasts], then " + hipDescript() + " and finally your ");
					if(player.vaginas.length > 0) outputText(vaginaDescript(0) + " as the last pieces fall away.\n\n");
					else outputText("bare groin as the last pieces fall away.\n\n");
				}
				//(HP loss)
				else outputText("You realize you're wobbling unsteadily, either from a blow to the head or blood loss, you can't be sure which.  In a display of sublime defiance, you manage to stay on your feet.  Though your tenacity does little good as your lightning-fast foe effortlessly undresses you, easily avoiding your clumsy and pain-addled movements.\n\n");
				//START ZE RAPE
				outputText("The succubus steps away from you, withdrawing a tiny vial from a pocket in her rags.  She uncaps it with practiced ease, her outfit shifting into latex parody of a nurse's uniform as she attaches a small needle, completing the assembly of her injector.  \"<i>Like, don't worry about a thing hun, this will only hurt for a second,</i>\" she coos as she prances forwards, easily sinking the entire needle into your shoulder.\n\n\"<i>W-what did you do to me?</i>\" you manage to stammer.\n\n");
				outputText("She merely smiles and slips a delicately manicured finger under a rapidly disappearing skirt.  You ignore her crude display of wanton sexuality for the moment and try to focus on figuring out what the drugs did you, and what her needy slit smells like.  No, that wasn't it... you wanted to taste her nipples!  You shake your head and try to focus, but fail completely as the succubus lifts her sticky latex skirt, exposing her dripping snatch to you.  Your eyes lock on to the wondrous slut's fuckhole as her fingers tease you with glimpses between her folds every few seconds while she continues pleasuring herself.  With a flash of intuition, you realize what you were trying to think about:  finding something hard to penetrate that perfect hole with.  That little hungry snatch deserves to be filled with something throbbing and hard...\n\n");
				outputText("\"<i>OoooooOOOOH!  ...you're feeling it now are-AH AH YES-you dear?  Mmmmm yes, I bet this pussy is all you can think about.  I wonder if you can feel it-aaahhhhhhmmmm-yet?  This is always, like, the best part...</i>\" gasps out the succubus as she pleasures herself.  You wonder what she could be talking about as ");
				if(player.vaginas.length > 0) outputText("your " + clitDescript() + " parts your folds, growing harder.");
				else outputText("a fleshy growth erupts from your pale flesh, growing harder.");
				outputText("  In seconds you're playing with it, tugging the sensitive button as it fills up with more and more blood, growing bigger and harder than ever before.  Your legs give out as you begin stroking it with feverish intensity, barely registering as it grows to nearly eighteen inches in length, not noticing the increasingly veiny surface or different texture at the tip.  You force yourself to stop as a sudden truth asserts itself upon your consciousness - you need to shove your clit-like cock into a pussy.  You need to cum inside that hungry slut's blue spunk-receptacle.\n\n");
				outputText("You stand on shaky legs and lunge forwards, impaling the slutty nurse on your new tool with a violent animalistic passion.  Fucking her roughly, you lick her nipples to finally get the taste you've ached for.  Girl-cum squirts from the sloppy fuck-hole of the latex-nurse underneath you as you fuck her like a desperate animal.  She squeals with pleasure, splitting her legs wide apart to encourage your new maleness.  Your eyes roll back from the drug-enhanced pleasure of her dripping cunt as a male orgasm rocks your mind.  Mixed fluids splatter your pistoning hips as you do what you were always meant to do - feed and pleasure succubi.  Somehow your tool remains rigid and your hips continue plunging your new cum-spigot deeper and deeper into your mistress as the next orgasm begins to build inside your drug-addled mind, even as you black out.");
				dynStats("cor", 5);
				dynStats("lib", 3);
				if ((player.hasPerk(PerkLib.BigClit) && player.clitLength < 6)|| player.clitLength < 3) {	//all this code is copied from succubusmilk (except description)
					player.clitLength += (rand(4) + 2) / 10;
					outputText("\n\nWhen you wake up, your clit is back to a more reasonable size- though it seems a bit larger than before.");
				}
				cleanupAfterCombat();
			}
		}
		
		private function killDemon():void {
			clearOutput();
			flags[kFLAGS.IMPS_KILLED]++;
			outputText("You make a quick work of the ");
			if (monster.short == "succubus") outputText("succubus");
			if (monster.short == "incubus") outputText("incubus");
			if (monster.short == "omnibus") outputText("omnibus");
			outputText(" before dragging the corpse away. That's one less foul creature prowling the realms. ");
			if (player.cor < 25) dynStats("cor", -0.5);
			menu(); 
			addButton(0, "Take Skull", takeSkull);
			addButton(1, "Leave", cleanupAfterCombat);
		}
		private function takeSkull():void {
			inventory.takeItem(useables.DEMSKLL, cleanupAfterCombat);
		}
		
	}

}