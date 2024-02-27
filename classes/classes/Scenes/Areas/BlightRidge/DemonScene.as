/**
 * ...
 * @author Ormael
 */
package classes.Scenes.Areas.BlightRidge
{

import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Armors.LustyMaidensArmor;
import classes.Scenes.Areas.DefiledRavine.CowSuccubus;
import classes.Scenes.Areas.DefiledRavine.MinoIncubus;
import classes.Scenes.SceneLib;

//use namespace CoC;
	
	public class DemonScene extends BaseContent
	{
		public function DemonScene()
		{}
		
		//MinoIncubus
		
		public function MinoIncubusEncounter():void {
			clearOutput();
			outputText("As you wander in the ravine, from behind one of trees ahead comes out a purple skinned person covered in fur.  When he approaches closer, you can clearly see his horse dick hangging free.  Looks like this minotaur went to the dark side of Mareth.  \"<i>Tasty soul in you I can feel.  Give it to me!</i>\" he directly command with a manly voice.  Look like there is no way around it, you ready your [weapon] for the fight.");
			startCombat(new MinoIncubus());
			doNext(playerMenu);
		}
		
		public function defeatMinoIncubus():void {
			clearOutput();
			menu();
			outputText("You smile in satisfaction as the mino incubus collapses, unable to continue fighting.");
			if (monster.HP < 1) addButton (5, "Kill Him", killDemon);
            LustyMaidensArmor.addTitfuckButton(7);
			addButton (14, "Leave", cleanupAfterCombat);
			SceneLib.uniqueSexScene.pcUSSPreChecksV2(defeatMinoIncubus);
		}
		
		//Incubus
		public function IncubusEncounter():void {
			clearOutput();
			outputText("As you wander in the ridge, from behind one of trees ahead comes out a purple skinned person.  To be more precise, a male person.  When he approaches closer, you can clearly see his dick hanging free.  \"<i>I can feel tasty soul in you.  Give it to me!</i>\" he directly command with a manly voice.  Look like there is no way around it, you ready your [weapon] for the fight.");
			startCombat(new Incubus());
			doNext(playerMenu);
		}
		
		public function defeatIncubus():void {
			clearOutput();
			menu();
			outputText("You smile in satisfaction as the incubus collapses, unable to continue fighting.");
			if (monster.HP < 1) addButton (12, "Kill Him", killDemon);
			addButton (14, "Leave", cleanupAfterCombat);
			if (player.lust >= 33) {
				outputText("\nNow would be the perfect opportunity to taste the fruits of his sex-ready form...[pg]Do you fuck him?");
				addButtonIfTrue(0, "M. Fuck", IncubusGetsRapedByMale, "Req. a cock.", player.hasCock());
				addButtonIfTrue(1, "F. Fuck", IncubusGetsRapedByFemale, "Req. a vagina.", player.hasVagina());
				addButton (2, "Service Him", GiveIncubusOral);
				addButton (3, "Catch Anal", SceneLib.dungeons.factory.doRideIncubusAnally);
				addButtonIfTrue(4, "L.Paizuri", lustyPaizuri, "Req . to have Lusty Maiden or Succubus armor equipped (unique scene for incubi).",
					player.hasVagina() && player.biggestTitSize() >= 4 && (player.armor == armors.LMARMOR || player.armor == armors.S_ARMOR));
				SceneLib.uniqueSexScene.pcUSSPreChecksV2(defeatIncubus); //the last!
			} else {
				outputText("You're not aroused enough to rape him.");
				flushOutputTextToGUI();
			}
		}
		
		public function lustyPaizuri():void {
			clearOutput();
			outputText("You make sure [themonster] is comfortably lying down, [monster his] [monster cockshort] exposed to the air");
			if(monster.lust < (monster.maxLust() * 0.5)) outputText(", soft and not yet ready.  You purr throatily as you touch the burgeoning boner, tracing your thumb across the sensitive urethral bulge.  It pulses slowly at your touch, and the base begins to fill with blood, thickening against your palm.  You splay your remaining fingers just under the [monster cockhead], tickling around the glans until that too is flooding with blood, expanding under your caresses until it slowly lifts away from [monster his] abdomen.");
			else if(monster.lust < monster.maxOverLust()) outputText(", nicely turgid but quite ready to feel the sensuous pleasure of your girls' tight squeeze.  You lean over the defeated foe and kiss the rod just under the [monster cockhead], smiling when it expands under your slow kisses.  Your fingers move up to play with the sensitive, urethral bulge that runs along the underside, and in no time, [themonster] is hard as a rock, so ready that [monster his] member is lifting up on its own.");
			else outputText(", bouncing with each beat of [monster his] heart, thick beads of pre dribbling from [monster his] tip as you bat [monster his] hands away before [monster he] can waste the load [monster he]'s saved up for you.");
			outputText("[pg]Your own moistness has risen to uncomfortable levels, and the sticky seal of your g-string's curvy front panel slips oh-so-slightly across your hot, hard clitty, something that makes your [legs] weak and your arms quake.  The leather fold on the front of your undergarments is so slippery that each movement has it shifting and shuffling across your nethers, a tiny bit at a time.  Already, you have your [butt] up in the air, shaking it back and forth for more of the delicious friction.  The motion only exacerbates the jiggling your [chest] are doing inside their tight containment.  [Themonster]'s head tilts up to watch, an unashamedly lusty look overtaking [monster his] features as [monster he] enjoys the inadvertent show you're giving.");
			outputText("[pg]\"<i>Such lascivious behavior!  I'll have to make sure you're thoroughly purified,</i>\" you state matter-of-factly with a feigned serious look on your blushing [face].  To put proof to your taunt, you grab the throbbing shaft by the base and aim it straight up, dropping your [chest] down on either side.  The slippery, self-lubricating leather that joins the cups of your sexy, chainmail bra together loops over the top of the [monster cockshort] to properly restrain it, pinned in the slick, sweaty valley you call your cleavage.  It thrums happily against your [skin] when you compress the jiggly flesh around it, leaning down to let it feel pleasure that rivals any pussy, no matter how wet or skilled.");
			outputText("[pg]You smile at your defeated foe as you begin to bob over [monster him], and you find more words coming from your lips without meaning to speak.  \"<i>That's better.  You really shouldn't go around trying to fuck everyone like that!  Pussies are ");
			if(!player.hasVirginVagina()) outputText("a gift too fine for a selfish brute like you");
			else outputText("sacred and to be shared only with a cherished loved one");
			outputText("!  Now, I'm going to squeeze all the impure thoughts out of you through your cock, so you just lie there and focus on letting them out all over my breasts.</i>\"");
			outputText("[pg][Themonster] nods solemnly while [monster his] eyes half-cross from pleasure.  You bottom out around [monster his] base");
			if(monster.hasBalls()) outputText(" and fondle [monster his] balls one-handed, squeezing the virile orbs to try and coax more of [monster his] dirty, perverted thoughts to distill into salty seed");
			else outputText(" and stroke [monster his] taint, even brushing close to [monster his] asshole to try and coax more of [monster his] dirty, perverted thoughts to distill into salty seed");
			outputText(".  A startled moan slips out of [monster his] lips, but you're just getting warmed up.  You dive down onto [monster his] [monster cockshort], taking the [monster cockhead] straight into your mouth with a smooth gulp.");
			if(monster.cockArea(0) >= 80) outputText("  It's so big and strong that it pushes right into your throat, stretching out your neck in the shape of the intruding cock.");
			outputText("  The strong, pulsing cock feels so good inside your mouth, like it belongs there, and you can't help but think that you're doing a good deed by helping [themonster] empty every last perverse desire onto your purifying breasts.");
			outputText("[pg]Up and down, up and down, you slide across the expansive member with unhurried, slow strokes, each time making your [chest] bounce beautifully.  Your [nipples] are so hard");
			if(player.hasFuckableNipples() || player.lactationQ() >= 100) outputText(", dripping,");
			outputText(" and sensitive, scraping around the nebulous inner lining of your bikini and occasionally catching on the metal that feels even warmer than normal.  Behind you, your [butt] is bouncing happily to the rhythm your corruption-devouring breasts have set, the thong digging tightly into your [vagina] in the most exquisite way.  You feel so hot and sensual, but still secure in the knowledge that you won't have to worry about such a creature ravaging your ");
			if(player.hasVirginVagina()) outputText("maidenhead");
			else outputText("sloppy gash");
			outputText(".  Still, you're not sure how much hotter you can get before you're cumming all over your g-string, letting your own dark thoughts seep into your magical underwear.");
			outputText("[pg]Below you, [themonster] is moaning out loud and roughly thrusting [monster his] hips to meet your every motion, their tip expanding slightly in your mouth as [monster his] passion mounts.  You pull back");
			if(monster.cockArea(0) >= 80) outputText(" with a messy cough to clear your throat");
			outputText(" and tease, \"<i>Oh, you're going to cum already, aren't you?  Well, go ahead then.</i>\"  You pump your [chest] faster against the twitching rod and smile when a thick bead of pre sloughs off into your squishy boobs, smearing across your [skin].  You kiss it, licking the dollop that slips out of the dilating cum-slit before commanding, \"<i>Cum for me, " + monster.mf("boy","girl") + ".  Let it allll out.</i>\"");
			outputText("[pg][Themonster] groans and shakes");
			if(monster.hasBalls()) outputText(", [monster his] balls pumping and bouncing in [monster his] sack");
			outputText(", [monster his] urethra swollen with the heavy load about to explode out of it.  \"<i>Drain out all that nasty jizz,</i>\" you quip as you bottom your breasts down on [monster him] and slurp the quivering cock-head into your sperm-hungry lips.  Salty warmth fires in a long rope into your well-prepared mouth and over your tongue.  The blissed out look on your captive foe's face combined with the feel of [monster him] giving up all [monster his] naughty thoughts thanks to your cleavage gets you so fucking hot that your [hips] begin to shake spastically.");
			outputText("[pg]You do your best to hold on to the pumping cock while it fires spastic ropes into your mouth, but the way your undies are digging into your [vagina] and grinding across your [clit], you simply lack the control to keep it up.  You throw back your head and cry out ecstatically, taking the next ejaculation in a long line across your cheek, up your nose, and onto your forehead.  Again and again, long ropes of tainted jizz spatter all over your face, dripping messily over the exposed tops of your teats.  You lick your lips while you cream the inside of your [armor] with girlish love-goo, feeling such immense pleasure at letting your own impure desires out into the armor.  More jets, weaker than the early ones, crest from the bouncing cock-tip to fall weakly over your well-slicked mammaries.");
			outputText("[pg]You seize [themonster] by [monster his] base and jerk [monster him] off with quick, sharp little strokes, commanding, \"<i>All of it!  Give me all of your lusts and cruel desires!</i>\".  [monster His] back arches as [monster his] orgasm redoubles, and fresh ropes begin to spout out again, ensuring your face and breasts are soaked with the sloppy spooge.  It runs in moist, warm rivulets into your concealing top, and what doesn't drip down, you compulsively rub into your skin, feeling a positively healthy glow from the feeling.  You don't free the [monster cockshort] from your chesty embrace until every single drop is splattered all over you, and when you do, you leave a thoroughly wiped-out [monster name] behind you.");
			outputText("[pg]The stink of sperm slowly fades as you move, almost seeming to absorb into your skin.  It leaves you with a healthy glow and a surety to your movements, sure that your revealing armor is going to protect you.");
			flags[kFLAGS.BIKINI_ARMOR_BONUS] += 2;
			if(flags[kFLAGS.BIKINI_ARMOR_BONUS] > 8) flags[kFLAGS.BIKINI_ARMOR_BONUS] = 8;
			dynStats("sen", 2);
			if(player.hasVirginVagina()) dynStats("cor", -1);
			cleanupAfterCombat();
		}
		
		public function IncubusGetsRapedByMale():void {
            var x:int = player.biggestCockIndex();
			clearOutput();
			outputText("With a few deft motions, you shift your [armor] to expose your ");
			if(player.gender == 3) {
				if(player.hasBalls()) outputText(multiCockDescriptLight() + ", [balls], and " + vaginaDescript(0));
				else outputText(multiCockDescriptLight() + " and " + vaginaDescript(0));
			}
			else {
				if(player.hasBalls()) outputText(multiCockDescriptLight() + " and " + ballsDescriptLight());
				else outputText(multiCockDescriptLight());
			}
			outputText(".  Having resolved to take the demon's backdoor, you approach his weakened form with brimming confidence.  He looks up, clearly hoping your plan is to squat on his throbbing member.  You dispel his misguided notion when you grab him by the horns and shove his face against the ground. He struggles weakly until you press down harder, making it clear he is to stay in position - on his knees with his head down and his ass in the air.  Circling your prey, you inspect his flawless body and carefully note that the hole at his crotch actually exposes a fair portion of his very supple and surprisingly feminine-looking backside.[pg]");
			outputText("You don't waste any time, gripping your [cock] in one hand and ");
			if(player.cocks[x].cockType == CockTypesEnum.HORSE) outputText("pressing your thick flare ");
			if(player.cocks[x].cockType == CockTypesEnum.DOG) outputText("pressing your pointed tip ");
			if(player.cocks[x].cockType == CockTypesEnum.HUMAN) outputText("pressing your head ");
			outputText("between the incubus' cheeks towards his inhumanly smooth rear-passage.  You gasp in delight at the tight ribbed texture of his asshole as you slide ");
			if(player.cocks[x].cockLength > 10) outputText("deep inside ");
			else outputText("inside ");
			outputText(".  The demon underneath you grunts in an attempt to sound displeased, but it's plain to see the pre-cum he's dripping all over the ground.  What a slut!  You slap his ass and begin roughly butt-fucking him, panting with each plunge into the depths of his ridged passage, gradually increasing your tempo until your " + hipDescript() + " fill the surrounding area with loud slapping noises.");
			if(player.hasBalls()) outputText("  Your [balls] swing freely, smacking into the demon's own and making both of you squeal and dribble more pre-cum.");
			outputText("[pg]");
			//(CUM)
			if(player.hasBalls()) outputText("You feel your [balls] draw up tight against your body.  ");
			outputText("Warm heat begins to build inside your groin, pooling under the base of your [cock].  You realize you're about to paint this demon's gut with white, the thought only turning you on more.  ");
			if(player.cumQ() > 200) outputText("You groan as you feel your urethra being stretched by the sheer volume of fluid beginning to shoot through it.  ");
			outputText("You throw back your head and cum, slapping the incubus' ass with one hand while you grip and squeeze the jiggling flesh of his other cheek.  ");
			if(player.cumQ() < 50) outputText("A few thick spurts later and y");
			if(player.cumQ() >= 50 && player.cumQ() < 400) outputText("Thick jets of cum pump into the demon's plump backside, soon building up a wave of pressure that pushes back against you.  Y");
			if(player.cumQ() >= 400) outputText("A massive cock-distending bulge of cum works through your shaft, splashing into the demon's rectum in an explosive burst of pleasure. Unfortunately for your victim, it is only the first of many such cum-blasts. In no time flat, jism is spurting from his overfilled rectum while his belly looks a few months pregnant. You feel weak from discharging so much fluid, and y");
			outputText("ou fall back, the fluid of your orgasm dripping from your [cock] and the gaping asshole of your latest conquest.[pg]You turn to gather your [armor], and when you look back the demon is gone, leaving only a small puddle of male fluids in his wake.");
			cleanupAfterCombat();
		}
		
		public function IncubusGetsRapedByFemale():void {
			clearOutput();
			outputText("With a few deft motions, you shift your [armor] to expose your ");
			//Herm
			if(player.gender == 3) {
				if(player.hasBalls()) outputText(multiCockDescriptLight() + ", [balls], and " + vaginaDescript(0));
				else if(player.hasBalls()) outputText(multiCockDescriptLight() + " and " + vaginaDescript(0));
			}
			else {
				outputText(vaginaDescript(0));
			}
			outputText(".  Striding forwards with hunger in your eyes, you give your left hand free access to your groin and slip your fingers between the moist folds of your " + vaginaDescript(0) + ".  As you undulate into the incubus' personal space, a swift thrust of your " + hipDescript() + " buries your fingers up to the knuckles and knocks the demon onto his well-muscled back.[pg]");
			outputText("He looks up at you with a practiced eye, adjusting his demon-tool's size to better fill your  " + vaginaDescript(0) + ".  ");
			//(set cocksize = to 80% vaginalCapacity).
			outputText("Thankful for the gesture, you sink down onto him, letting the nubs of his crown stimulate your lips and the underside of your " + clitDescript() + ".  ");
			if(player.vaginas[0].vaginalWetness >= VaginaClass.WETNESS_SLICK) outputText("In no time flat your drooling fluids soak him in slippery wetness.  ");
			if(player.vaginas[0].vaginalWetness < VaginaClass.WETNESS_SLICK && player.vaginas[0].vaginalWetness != VaginaClass.WETNESS_DRY) outputText("Before long, you've lubricated a fair portion of his tool with wetness.  ");
			if(player.vaginas[0].vaginalWetness == VaginaClass.WETNESS_DRY) outputText("Despite your usual light lubrication, you manage to moisten the top-half of his tool with wetness.  ");
			outputText("Relaxing the muscles in your [legs], you let a few inches of his length slip inside you, every nub and nodule of his corrupted prick filling the walls of your love-canal with inhuman pleasures that make your knees weak.  A particularly delightful bump brushes your " + clitDescript() + ", causing your [legs] to finally give out. The incubus' nubbly cock plunges entirely inside you.[pg]");
			outputText("You gasp and moan like a cheap whore, disgusted by yourself and yet so turned on by the total loss of self-control.  The incubus is leering up at you, having regained some of his lost confidence.  Despite the lust, desire and pleasure burning through the hot pole buried in your abdomen, you work up enough rage to grip his neck with your left hand and practically choke him out.  You work your hips quickly as you feel his pre start to drip into your canal, spreading tingling warmth in the deepest parts of your passage and into your cervix.  You tighten your grip as you forcibly take your pleasure, barking in displeasure at the demon, \"<i>Don't look like you're enjoying this too much bitch, or I'll take it out of your hide.</i>\"  Satisfied at the renewed look of fear in his eyes, you return to using his magnificent tool as a masturbation aid.[pg]");
			outputText("Unable to contain your body's desires due to either the demon's aura or his wonderful penis, you slam your " + vaginaDescript(0) + " onto his member with impunity, twitching and squeezing involuntarily.  His tainted pre-cum begins seeping deep inside your uterus and you cry out with orgasmic intensity.  Your entire body clenches down, even the hand clamped on the incubus' windpipe. You feel his demon-cock swell up inside you in response to his stress, stretching your cunt taut.  His skin darkens from the lack of oxygen as he begins cumming HARD inside you.  Your womb immediately fills with his demon-seed, leaving ribbons of spunk to drip from your tightly-stretched cunt.  You sigh in delight as your muscles slowly stop quivering.  With a pleasured gasp, you rise off the distended demon-prick, and realize that you've choked your foe into unconsciousness. Still, you did let him cum, so maybe he won't mind too much when he wakes.  Feeling sensual and sated, you redress and prepare to come back to the camp. ");
			player.cuntChange(player.vaginalCapacity()*.8, true);
			player.sexReward("cum","Vaginal");
			dynStats("cor", 2);
			if (!player.isGoblinoid()) player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP);
			cleanupAfterCombat();
		}
		
		public function GiveIncubusOral():void {
			clearOutput();
			outputText("You lick your lips, moistening them as you decide that the demon will provide your next 'snack'.  Touching the defeated incubus' soft skin, you grab him by the wrists and yank him to his clawed feet. Leaning him back against the near tree as he sways unsteadily, you tenderly slide down his body and take the measure of his monstrous meat with your hands. The smooth skin and tiny bumps slide between each finger as his manhood firms and twitches in response.  You glance up and grab his baseball size nuts, caressing the smooth hairless sack that contains them, watching the demon-man sigh and relax with equal parts desire and relief.[pg]");
			outputText("You lean forwards, opening your mouth ");
			if(player.hairLength > 10) outputText("and brushing a strand of [haircolor] out of the way ");
			outputText("as his shiny purplish monster-cock fills your view. You kiss the tip, swirling your tongue around the nubbly ridge that surrounds the crown.  After a few moments of your tongue's focused attention, you are rewarded with a dollop of slightly sweet pre-cum.  You pause momentarily to smile at your victim before you wrap your hand around as much of him as you can hold and start to jack him off, slowly cramming more and more of his length inside your mouth.  Your free hand continues to fondle his balls, occasionally sliding a finger along the inside of his thigh.[pg]");
			outputText("You feel his balls begin to grow. Perhaps he can sense your thirst for cum, or maybe he just wants to enjoy it - but you are sure he is going to finish spectacularly. They stop swelling just as they reach the size of grapefruits, tingling and pulsing spectacularly in your hand.  You stroke him faster, letting you guzzle his pre as it pours into your greedy mouth.  A coo of delight escapes from your tightly-stretched lips as you savor his tasty fluids.[pg]");
			outputText("The incubus' hips begin humping your face, stuffing a few more inches of his length into your throat and forcing you to struggle against gagging.  His cock swells wider and nearly unhinges your jaw as you feel a gooey warmth wash your throat, flooding your gullet with demon-seed.  Still impaled on his nubby member, your body is rocked back and forth by the strength of his orgasm, the motions making your belly slosh with an increasingly large load.  You moan at the warmth of his corruption seeping through your body as his orgasm diminishes. Yanking back hard, you let his dick slip free of your mouth as the last spurt of cum blasts your face.");
			player.refillHunger(50);
			player.sexReward("cum","Lips");
			outputText("[pg]");
			outputText("You push the exhausted demon down and idly collect the cum from your face with your fingers, slowly licking each clean.  Feeling rather sensual and sated, you decide to resume exploring.[pg]After redressing you turn about, and see the demon is gone, leaving only a small pool of cum in his wake.");
			cleanupAfterCombat();
		}
		
		//Omnibus
		public function OmnibusEncounter():void {
			clearOutput();
			outputText("As you wander in the ridge, from behind one of trees ahead comes out a purple skinned person.  At first glance, it seems to be a female person.  When she approaches closer, despite rags covering some of her body you notice a demonic cock hanging free.  \"<i>I can feel tasty soul in you.  Give it to me!</i>\" she directly commands yet still using a gentle feminine voice.  Look like there is no way around it, you ready your [weapon] for the fight.");
			startCombat(new Omnibus());
			doNext(playerMenu);
		}
		
		public function defeatOmnibus():void {
			clearOutput();
			menu();
			outputText("You smile in satisfaction as the omnibus collapses, unable to continue fighting.");
			if (monster.HP < 1) addButton (5, "Kill Her", killDemon);
			addButton (14, "Leave", cleanupAfterCombat);
			if (player.lust>=33 && player.gender > 0) {
				outputText("\nNow would be the perfect opportunity to taste the fruits of her sex-ready form...[pg]Do you fuck her?");
				addButton (0, "M. Fuck", OmnibusGetsRapedByMale)
					.disableIf(!player.hasCock(), "Req. a cock.");
				addButton (1, "F. Fuck", OmnibusGetsRapedByFemale)
					.disableIf(!player.hasVagina(), "Req. a vagina.");
                LustyMaidensArmor.addTitfuckButton(2);
				addButton(3, "Use demon", rapeCerberusStyle)
					.disableIf(!player.isRaceCached(Races.CERBERUS), "Req. Cerberus race");
				SceneLib.uniqueSexScene.pcUSSPreChecksV2(defeatOmnibus); // the last!
			} else {
				outputText("You aren't aroused enough to rape her.");
				flushOutputTextToGUI();
			}
		}
		
		public function OmnibusGetsRapedByMale():void {
			clearOutput();
			sceneHunter.selectFitNofit(OGRBM_fits, OGRBM_toobig, monster.vaginalCapacity());
		}

        public function OGRBM_fits():void {
			var x:Number = player.cockThatFits(monster.vaginalCapacity());

            if (monster.lust >= monster.maxOverLust()) {
                outputText("Ignoring her squeals of pleasure, you force omnibus onto her back, oogling her perky breasts, indecent cock, and soaked cunt.  She looks up at you hungrily, and you have the feeling that on some level you're still giving her what she wants.  Mindful of her demonic wiles, you pull her hands together and use a few tattered strips of cloth to bind them over her head.  Moaning with helpless desire, the demon grinds her crotch against your [leg], spreading her thighs apart into a near split and giving you a world-class view of her juicy purple cunt.[pg]");
            }
            //[hp]
            else {
                outputText("Ignoring her grunts of pain, you force omnibus onto her back, oogling her perky breasts, limp cock, and hairless cunt.  She looks up at you with disdain, growling at you from the back of her throat.  Wary of the demon's abilities, you tie up her hands with a few tattered strips of cloth.  She seems to like it, judging by her tenting erection and now-glistening gash.  The slut even goes so far as to begin grinding her crotch against you, spreading her thighs wider and wider as she gets off on being restrained.  You're given a perfect view of her enticing purple cunt.[pg]");
            }
            outputText("Omnibus licks her lips and gazes up at you, begging with a voice that drips with seductive intent, \"<i>Please don't rape me, champion!  Don't tie me down and rape me like a helpless village-girl!</i>\"[pg]");
            if (player.cor < 33) outputText("Her words shame you.  Have you really sunk this low?  You wonder just how much this world has already corrupted you as you ready yourself to rape a sex-demon.");
            else if (player.cor < 66) outputText("Her words confuse you.  You never would've done this when you first came here, but you're horny and you know demons don't really mind.");
            else outputText("Her dishonest words anger you, and you slap her in the face.  Both of you know that she wants this almost as much as she wanted to rape you, and any pretense at disliking this act is a deceitful sham.");
            outputText("  It's too late for her to have any hope of swaying you anyway.  You strip off your [armor] ");
            outputText("and begin stroking ");
            if (player.cockTotal() > 1) outputText("each of ");
            outputText("your stiff [cocks], preparing to penetrate her.[pg]");
            outputText("Omnibus squirms in the dirt as you bring your [cock] closer and closer to her female hole, her cock twitching with need like some kind of perverse, mutant clit.  Her hips twitch at you, as if eager to devour your maleness.  You don't keep her waiting, ");
            if (player.cockArea(x) < 40) {
                outputText("and with a forceful thrust, you sheath yourself inside the demon's unholy pussy");
            }
            else outputText("and with a mighty effort, you force your over-sized cock inside her.  For a moment all you can do is stare in awe as it distorts her body – the fact that such a thing is possible puzzles you");
            outputText(".  Her interior is inhumanly hot and covered with thousands of slippery protrusions, each rubbing against your dick's flesh.  The orgy of sensation is incredible, and you immediately begin fucking your bound, demonic captive as the need to orgasm rises within you.[pg]");
            outputText("The defeated omnibus mewls in mock protest, \"<i>Oh, don't cum in my demonic twat, dear champion!  If you do, you'll never want any other pussy ever again!</i>\"[pg]");
            outputText("You grunt, pounding her harder and faster than before, knowing you couldn't pull out of her vise-like pleasure-hole if you wanted to.  It feels too good to hold out or resist, and you drop down, adjusting your angle as you rape the beautiful omnibus.  You're grunting like an animal, humping her as fast as your body will let you, but she lies under you with a serene and enticing expression, as if she's greatly enjoying the situation and awaiting your orgasm.  You pinch her nipple roughly, irritated by her superior air, but it only makes her wriggling pussy get even wetter.  It clamps down on you, wringing your [cock] dry as it erupts in a powerful orgasm.[pg]");
            outputText("Omnibus squeals happily, her sultry visage fracturing into an uninhibited expression of pleasure as she cries, \"<i>Fill me with your seed, champion!  Dominate the demon with your mighty spear!</i>\"[pg]");
            outputText("Her purple-hued pussy spasms around you, its oddly textured interior rippling and sucking in time with your ejaculations, drinking down your cum.  Omnibus squirms happily while her body absorbs your jizz with her impossibly pleasurable hole.");
            if (player.cumQ() >= 500 && player.cumQ() < 1000) outputText("  Her belly begins to rise with the volume of cum she's absorbed, and you finish your orgasm with a mildly pregnant demon underneath you.");
            else if (player.cumQ() >= 1000) outputText("  Her belly rises quickly from the volume of cum you're pumping into her, swelling up until she looks ready to give birth, but her taut purple body seems to handle the strain quite well, save for her belly-button turning into an outtie with an abrupt 'pop'.");
            outputText("  The omnibus' nubby shaft twitches happily and squirts out tiny dribbles of demon-semen, too left out by the sex to achieve a truly enjoyable orgasm, but more than willing to leak cum.[pg]");
            outputText("Omnibus exhales with exhaustion and rubs her hands over her belly, cooing, \"<i>So, you really did give up all your semen to me.  I guess I'll have to name the first imp I birth from this after you, won't I?</i>\"[pg]");
            if (player.cor < 33) outputText("You groan, just wishing she would stop reminding you of the consequences of this little tryst.  In a hurry to leave the demon behind, you get dressed and take off for camp.[pg]");
            else if (player.cor < 66) outputText("You groan, wondering why she just won't get over her little act.  Even though this wasn't your best idea, it isn't nearly as bad as she makes it out to be.  You get dressed and leave, eager to be rid of her.[pg]");
            else outputText("You bend over, rub her belly softly and whisper into her ear, \"<i>I'll be sure to spit him on my cock first chance I get, dear.</i>\"[pg]");
            outputText("As you leave, you don't bother to spare a glance at the confused omnibus.  She isn't worth your time.");
			player.sexReward("Default","Dick");
			dynStats("lib", 3, "sen", 3, "cor", 1);
			cleanupAfterCombat();

        }
        public function OGRBM_toobig():void {
			var x:Number = player.biggestCockIndex();
            //[MALE TOO DAMN BIGGA WIGGA]
            //[lust]
            if (monster.lust >= monster.maxOverLust()) outputText("Ignoring her squeals of pleasure, you force the omnibus onto her back, ogling her perky breasts, indecent cock, and soaked cunt.  She looks up at you hungrily, and you have the feeling that on some level you're still giving her what she wants.  Wary of the demon's wiles, you pull her hands together and use some scraps of cloth to bind them up.  Moaning with helpless desire, the demon grinds her crotch against your [leg], spreading her thighs apart into a near split and giving you a world-class view of her juicy purple cunt.[pg]");
            //[hp]
            else outputText("Ignoring her grunts of pain, you force the omnibus onto her back, ogling her perky breasts, limp cock, and hairless cunt.  She looks up at you with disdain, growling at you from the back of her throat. Wary of the demon's abilities, you tie up her hands with a few pieces of tattered cloth.  She seems to like it, judging by her tenting erection and now-glistening gash.  The slut even goes so far as to begin grinding her crotch against you, spreading her thighs wider and wider as she gets off on being restrained.  You're given a perfect view of her enticing purple cunt.[pg]");
            outputText("Omnibus licks her lips and gazes up at you, begging with a voice that drips with seductive intent, \"<i>Please, don't rape me Champion!  Don't tie me down and rape me like a helpless village-girl!</i>\"[pg]");
            if (player.cor < 33) outputText("Her words shame you.  Have you really sunk this low?  You wonder just how much this world has already corrupted you as you ready yourself to rape a sex-demon.");
            else if (player.cor < 66) outputText("Her words confuse you.  You never would've done this when you first came here, but you're horny and you know demons don't really mind.");
            else outputText("Her dishonest words anger you, and you slap her in the face.  Both of you know that she wants this almost as much as she wanted to rape you, and any pretense at disliking this act is a deceitful sham.");
            outputText("  It's too late for her to have any hope of swaying you anyway.  You strip off your [armor] ");
            outputText("and begin stroking ");
            if (player.cockTotal() > 1) outputText("each of ");
            outputText("your stiff [cocks], preparing to penetrate her.[pg]");
            outputText("The [cockhead] of your [cock] squishes flat against her twat, too big for her prodigious demon-cunt to swallow.  Spurred by frustrated desires, you lift her legs and wrap her girlcum-slicked thighs about your ");
            if (player.cockTotal() > 1) outputText("primary ");
            outputText(cockDescript(x) + ". Omnibus' smooth skin and soft thigh-flesh form a comfortably tight masturbation tube.  Starting slowly, you begin rocking back and forth, sawing your prodigious cock-flesh over her body.  The demoness swivels her hips underneath your [cock], her slippery gash and near-crushed member feverishly rubbing into you.  Though you didn't get to truly violate her, her thighs and unblemished skin are more than good enough to bring you to the brink of orgasm.[pg]");
            outputText("The defeated omnibus wraps her arms around your [cock] and whines lustily, \"<i>No, please!  You'll cover me in seed and despoil my face!  Please don't glaze me in that awful stuff!</i>\"[pg]");
            outputText("You grunt, hold the captive by her ankles, and use her like a disposable sex-toy.  The slap of your " + hipDescript() + " slapping into her thighs echoes loudly, nearly drowning out the wet squishing of your [cock] with each violent brush against her cuntlips.  ");
            if (player.cocks[x].cockLength < 18) outputText("Your [cockhead] crests between her breasts with every stroke, bumping against her chin.  It grows larger as the pleasure of the act intensifies to orgasmic levels.[pg]");
            else if (player.cocks[x].cockLength < 24) outputText("Your [cockhead] slides over her cheek with every stroke, leaving a trail of pre-cum on her face.  The smudges of glistening pre grow larger and larger as the pleasure of the act nears orgasmic levels.[pg]");
            else outputText("Your [cock] slides over her face with every stroke, smearing the demon's hair with your thick pre-seed before you pull back and dribble it on her face.  The pleasure of the act is incredible, and you feel yourself getting harder as the sensation nears orgasmic levels.[pg]");
            outputText("Omnibus squeals and blubbers incoherently for a moment as she cums, eventually managing to scream out, \"<i>Yes, splatter me with seed!  Punish this lowly demon with your powerful spunk.  Dominaaaaate meeee~</i>\"[pg]");
            outputText("Underneath your own mammoth erection, you can feel omnibus's smaller cock twisting and squirming, unloading its own hot fluids onto her sweat-slicked belly.  She wriggles and twitches under you, her thigh muscles clenching and releasing in time with her spurts as they push you beyond your limit.  You watch your [cock] as it strains and squirts, dumping your thick load into the demon's ");
            if (player.cocks[x].cockLength < 18) outputText("tits");
            else if (player.cocks[x].cockLength < 24) outputText("face");
            else outputText("long hair");
            outputText(".  The orgasming demonette continues to squirt underneath you, drenching and smearing herself with even more cum and her entire mid-section looks glazed in thick whitish goo.");
            if (player.cumQ() >= 1000) outputText("  Your prodigious fertility quickly forms a puddle around her, leaving the deceptive seductress practically submerged in cum.");
            outputText("[pg]");
            outputText("You sigh, feeling immense relief, and remove your softening bulk from atop her form.  Omnibus exhales in exhaustion and smears the mixture of cum over her belly, cooing, \"<i>So you really did give me a huge load.  I'll be sure to scoop a few batches of it into my womb so we can have lots of imps together.</i>\"[pg]");
            if (player.cor < 33) outputText("You groan, just wishing she would stop reminding you of the consequences of this little tryst.  In a hurry to leave the demon behind, you get dressed and take off for camp.[pg]");
            else if (player.cor < 66) outputText("You groan, wondering why she just won't get over her little act.  Even though this wasn't your best idea, it isn't nearly as bad as she makes it out to be.  You get dressed and leave, eager to be rid of her.[pg]");
            else outputText("You bend over, rub her belly softly and whisper into her ear, \"<i>I'll be sure to spit them on my cock first chance I get, dear.</i>\"[pg]");
            outputText("As you leave, you don't bother to spare a glance at the confused omnibus; she isn't worth your time.");
			player.sexReward("Default","Dick");
			dynStats("lib", 3, "sen", 3, "cor", 1);
			cleanupAfterCombat();
        }
		
		public function OmnibusGetsRapedByFemale():void {
			clearOutput();
			//lust
			if (monster.lust >= monster.maxOverLust()) outputText("Ignoring her squeals of pleasure, you force omnibus onto her back, oogling her perky breasts, indecent cock, and soaked cunt.  She looks up at you hungrily, and you have the feeling that on some level you're still giving her what she wants. Wary of the demon's wiles, you pull her hands together and use some tattered strips of cloth to bind them up.  Moaning with helpless desire, the demon grinds her crotch against your [leg], spreading her thighs apart into a near split and giving you a world-class view of her pulsating black demon-cock.[pg]");
			//[hp]
			else outputText("Ignoring her grunts of pain, you force omnibus onto her back, oogling her perky breasts, limp cock, and hairless cunt.  She looks up at you with disdain, growling at you from the back of her throat.  Mindful of the demon's abilities, you tie up her hands with some tattered strips of cloth.  She seems to like it, judging by her tenting erection and now-glistening gash.  The slut even goes so far as to begin grinding her crotch against you, spreading her thighs wider and wider as she gets off on being restrained.  You're given a perfect view of her pulsating black demon-cock.[pg]");
			outputText("Omnibus licks her lips and gazes up at you, begging with a voice that drips with seductive intent, \"<i>Please don't rape me!  I took a vow of chastity!</i>\"[pg]");
			if (player.cor < 33) outputText("Her words shame you.  Have you really sunk this low?  You wonder just how much this world has already corrupted you as you ready yourself to get off on a sex-demon's tool.");
			else if (player.cor < 66) outputText("Her words confuse you.  You never would've done this when you first came here, but you're horny and you know demons don't really mind.");
			else outputText("Her dishonest words anger you, and you slap her in the face.  Both of you know that she wants this almost as much as she wanted to rape you, and any pretense at disliking this act is a deceitful sham.");
			outputText("[pg]It's too late for her to have any hope of swaying you anyway.  You strip off your [armor] ");
			outputText("and begin touching your " + vaginaDescript(0) + ", getting yourself ready for what is to come.[pg]");
			outputText("You sink down, feeling yourself part around the hot demon-tool, its ring of crown-nubs stroking your walls as you slide down, and the bumpy texture of its shaft makes your [legs] feel weak.  You drop the rest of the way down in one smooth, wet slide, ");
			if (player.vaginalCapacity() < 12) outputText("unable to take the entire exquisite cock inside you.  The nubs squirm and wiggle, practically vibrating and massaging your internal muscles, and you're unable to stop yourself from bouncing on top of her, spearing yourself repeatedly upon the thick rod.[pg]");
			else outputText("able to take the entire exquisite cock inside you.  The nubs squirm and wiggle, practically vibrating and massaging your internal muscles, and you're unable to stop yourself from bouncing on top of her, spearing yourself repeatedly upon the thick rod.[pg]");
			outputText("Omnibus cries in mock protest, \"<i>No, don't make me cum inside you!  Please Champion, I swore not to spill my seed, lest I father a bastard child!</i>\"[pg]");
			outputText("The sensations of her vibrating nodules ensure you don't have the will or the strength to pull off of her, and what little power your [legs] have is used to keep bouncing and grinding on top of her, filling the air with wet squelches and slippery squishes.  You fall forwards, barely catching yourself before you slam into the sultry demoness.  Your ");
			if (player.biggestTitSize() < 1) outputText("chest ");
			else outputText("tits ");
			outputText("squish against hers, squeezing a gout of milk from her nipples.  Both pairs of ");
			if (player.biggestTitSize() < 1) outputText("nipples");
			else outputText("jiggling mounds");
			outputText(" feel wonderful as they're pressed between you, sliding back and forth in time with your body's urgent grinding.[pg]");
			outputText("The omnibus' facade of feigned innocence drops under the force of the hot, wet fuck.  Her mouth opens into an 'o' of pleasure, and you feel her rod thicken as it begins pumping the proof of her ecstasy inside you.  The nodules that cover omnibus's demonic erection wildly vibrate as she orgasms, throwing you over the edge and into the midst of a body-shaking orgasm.  Demon-seed floods your womb, squeezed inside it by your body's orgasmic contractions.  You shudder with the demon as you both begin calming down.[pg]");
			outputText("She groans, \"<i>Ooooh... Champion why did you make me despoil your womb?  ");
			if (!player.isPregnant()) outputText("You're only feeding the swarms of imps that are despoiling this land.");
			else outputText("I'm sure whatever baby you have in there won't enjoy being so soaked in corruption.");
			outputText("</i>\"[pg]");
			if (player.cor < 33) outputText("You groan, just wishing she would stop reminding you of the consequences of this little tryst.  In a hurry to leave the demon behind, you get dressed and take off for camp.[pg]");
			else if (player.cor < 66) outputText("You groan, wondering why she just won't get over her little act.  Even though this wasn't your best idea, it isn't nearly as bad as she makes it out to be.  You get dressed and leave, eager to be rid of her.[pg]");
			else outputText("You bend over and rub your belly while whispering in her ear, \"<i>Like mother, like child.</i>\"[pg]");
			outputText("As you leave, you don't bother to spare a glance at the confused omnibus; she isn't worth your time.[pg]");
			player.cuntChange(monster.cockArea(0), true);
			player.sexReward("cum","Vaginal");
			dynStats("lib", 3, "sen", 3,"cor", 1);
			if (!player.isGoblinoid()) player.knockUp(PregnancyStore.PREGNANCY_IMP, PregnancyStore.INCUBATION_IMP - 32, 61); //Ceraph causes faster pregnancies
			cleanupAfterCombat();
		}
		
		//CowSuccubus
		
		public function CowSuccubusEncounter():void {
			clearOutput();
			outputText("As you wander in the ridge, from behind one of trees ahead comes out a blue skinned person covered in fur.  To be more precise, a cow that felt that grass must be greener on the dark side.  When she approaches closer, despite rags covering some of her body, you don't notice any 'addition' at her crotch.  \"<i>A yummy soul in you I can feel.  Would you kindly give it to me?</i>\" she blurts directly.  Look like there is no way around it, you ready your [weapon] for the fight.");
			camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_SUCCUBUS);
			startCombat(new CowSuccubus());
			doNext(playerMenu);
		}
		
		public function defeatCowSuccubus():void {
			clearOutput();
			menu();
			outputText("You smile in satisfaction as the cow succubus collapses, unable to continue fighting.");
			if (monster.HP < 1) addButton (5, "Kill Her", killDemon);
			addButton (14, "Leave", cleanupAfterCombat);
			SceneLib.uniqueSexScene.pcUSSPreChecksV2(defeatCowSuccubus);
		}
		
		//Succubus
		public function SuccubusEncounter():void {
			clearOutput();
			outputText("As you wander in the ridge, from behind one of trees ahead comes out a blue skinned person.  To be more precise, a female person.  When she is approaches closer, despite rags covering some of her body, you don't notice any 'addition' at her crotch.  \"<i>I can feel yummy soul in you.  Would you kindly give it to me?</i>\" she blurts directly.  Look like there is no way around it, you ready your [weapon] for the fight.");
			camp.codex.unlockEntry(kFLAGS.CODEX_ENTRY_SUCCUBUS);
			startCombat(new Succubus());
			doNext(playerMenu);
		}
		
		public function defeatSuccubus():void {
			clearOutput();
			menu();
			outputText("You smile in satisfaction as the succubus collapses, unable to continue fighting.");
			if (monster.HP < 1) addButton (5, "Kill Her", killDemon);
			addButton (14, "Leave", cleanupAfterCombat);
			if (player.lust>=33) {
				outputText("\nNow would be the perfect opportunity to taste the fruits of her sex-ready form...[pg]Do you fuck her?");
				addButtonIfTrue(0, "M. Fuck", SuccubusGetsRapedByMale, "Req. a cock.", player.hasCock());
				addButtonIfTrue(1, "F. Fuck", SuccubusGetsRapedByFemale, "Req. a vagina.", player.hasVagina());
				addButton(2, "Use demon", rapeCerberusStyle)
					.disableIf(!player.isRaceCached(Races.CERBERUS), "Req. Cerberus race");
				SceneLib.uniqueSexScene.pcUSSPreChecksV2(defeatSuccubus);
			}
			else {
				outputText("You're not aroused enough to rape her.");
				flushOutputTextToGUI();
			}
		}
		
		public function SuccubusGetsRapedByMale():void {
			clearOutput();
			//(LUSTY)
			if(monster.lust >= monster.maxOverLust()) outputText("Panting hotly, the succubus staggers towards you, her eyes fixated on the bulge in your crotch.  Dark viscous liquid drips from her dusky folds as her hips undulate hypnotically.  Blue fingers smear the corrupted lubricants over the smooth outer folds of her sex as she lies back enticingly, giving up on anything but bedding you.  In moments your [armor] are on the floor and you approach your prize.[pg]");
			//(HP)
			else outputText("The succubus collapses on the floor, groaning in pain.  Most of her rags have been destroyed by the combat and her blue skin is marked with deep purple bruises and bloody lacerations.  You undress, straddling your conquest and gazing down on her helpless, curvaceous form.  She looks up at you and forces a smile, licking the blood from a cracked lip and beginning to masturbate for you.[pg]");
			//((TOO BIG))
			sceneHunter.selectFitNofit(SGRBM_fits, SGRBM_toobig, monster.vaginalCapacity());
		}

        private function SGRBM_start(x:int):void {
            //START ZE RAEP CANNONZ
			outputText("While pondering the best way to take your horny prize, her complexion begins to change, the marks of combat disappearing from her toned body.  The demonic horns crowning her perfect visage begin withdrawing into her head, and her hair ");
			if(player.hairLength > monster.hairLength) outputText("lengthens");
			else outputText("shortens");
			outputText(", shifting to [haircolor].  The bone structures of her cheeks, nose, and face shift ever so slightly, and you suddenly realize you are looking down at a slutty version of yourself!  You aren't sure if it's the growing pool of succubus fluid below you or how hot your female twin is, but your " + player.cockDescript(x) + " is as hard as a rock.[pg]");
			outputText("Well, you DID decide to rape her, and now you know that you ARE smoking hot.  You shrug and shove your fem-double's legs apart, exposing her glistening fuck-target.  You bend down and bite her nipple as you position yourself at her entrance, allowing her to grasp your " + player.cockDescript(x) + " and coat it with her slick dark fluids.  It tingles as the tainted cunt-juices wick up into your dick like the oil from a lantern back home. At first, it burns painfully, as if badly sunburned, but you adjust to the discomfort and marvel as your skin turns blackish-purple. Midnight-colored nodules sprout along the upper and lower portions of your " + player.cockDescript(x) + ", perfectly shaped to tease clits.  Just under its head, a ring of larger growths emerge, somewhat pointy, but flexible, rubbery and incredibly sensitive.  Your " + player.cockDescript(x) + " gets harder and harder as it grows slightly beyond its normal size.  It tugs your groin forwards, practically leaping towards its demonic mate on its own volition.  You cave in and press forwards, parting her folds and submerging your crown in corruptive bliss.[pg]")
        }

        public function SGRBM_toobig():void {
            var x:int = player.findCock(1, monster.vaginalCapacity(), -1);
            SGRBM_start(x);
            outputText("But the pleasure is short-lived, as even her altered physiology can't accommodate your massive tool. With a grunt of frustration you yank your hungry demonic cock away from your goal.  She smiles knowingly and massages her breasts, releasing streams of the same black fluid from her tumescent nipples. It coats the valley of her pornstar-sized breasts, allowing the fluid to flow down and pool in her tight little belly button.[pg]");
            outputText("\"<i>This will, like, be even better anyways stud!</i>\" coos a higher pitched you, smashing her tits together wetly for emphasis.  Viscous strings of lubricants form a mesmerizing lattice between her mountainous tits as she puts on a show for you.  Entirely of its own accord, your " + player.cockDescript(x) + " drags you into her web of corruption, plopping itself firmly into the river of desire that fountains from the peaks on either side. With a steady rhythm, you rock your [hips] back and forwards, plunging into her delicious fuckpillows without abandon. With an inhuman strength, she pushes them together, forcing them to completely encircle your over-sized pole with a tight ring of corruption-dripping tit-flesh.[pg]");
            transformations.CockDemon(x).applyEffect(false);
            //[normal]
            if(player.cumQ() < 50) outputText("Droplets of pre begin to escape your cock-slit every time your sensitive nodules pass between your fem-clone's wondrous pleasure-tits.  You fuck harder, no longer caring if it's your choice or your cock's, mashing your purplish head against her lips with every stroke.  The flash-fire of an orgasm sweeps over you, over-engorging the nodules all over your cock and doubling their size.  Your hips resort to tiny rocking motions as you rub your cock-slit into your fem-self's open mouth, blasting thick ropes of tainted black cum into her mouth. Though you quickly empty of cum and collapse onto her, your [hips] continue to fuck like a machine.  All you can do is hang on to your meat and try to stay conscious as your demonic prick feasts on your double.[pg]");
            //[high]
            if(player.cumQ() >= 50) {
                if (player.cumQ() < 500) {
                    outputText("A steady stream of pre begins to escape your cock-slit, drooling over your double's face and tits as you pound away at her bouncing ring of titflesh.  Every new bump and nodule seems as sensitive as your entire maleness used to be.  Every thrust into the dark wet prison only makes your pre-cum drool faster and your " + player.cockDescript(x) + "'s new adornments grow fuller and even more tender.  In a flash, the fire of orgasm overwhelms your body's new taint-saturated cock.  Like a kinky 'wave', each nodule from the base to the pointy ring at your crown grows larger as your muscles clench.  ");
                    if(player.hasBalls()) outputText("Your " + ballsDescript() + " twitch and shake, the veiny surface of your sack darkening as the corruption begins to fill them.  ");
                }
                else {
                    outputText("A river of pre-cum begins pouring from your cock-tip's slit, soaking your slutty double's face and tits as it mixes with the corruptive fluids already smeared about.  The alien bumps and nodules upon your " + player.cockDescript(x) + " flex and twitch at every pass through the fuck-able foe's soft tits, slowly growing as they absorb more of your slut-self's taint.  The tight squeeze around your newly retextured " + player.cockDescript(x) + " overwhelms any sense of control you may have had as your arousal-soaked groin takes over completely.  You begin pounding the tit-pussy as if your life depended on it, jack-hammering  your " + player.cockDescript(x) + " forward and back hard enough to make the mountains of breast ripple and shake like jello during an earthquake.  The ring of pointed nodules around your crown continues to swell and grow with every pass through the inky passage, soaking up more and more of the corruption until they are each nearly two inches long.  Overwhelmed by the pleasure, your eyes roll back and a mighty orgasm comes to boil in your groin.  ");
                    if(player.hasBalls()) outputText("Your [balls] practically glow with relief as they begin contracting.  Their entire surface is covered with black veins that radiate from your demonic prick, sharing the corruption with your sperm factories.  ");
                }
                outputText("You throw back your head as the first wave of release pours from your tip, splattering your female clone with inky black cum!  The color startles you for a moment before the next blast moves down your shaft, visibly distending your urethra until it bursts free to coat her hair.  Your hips keep moving of their own accord, massaging the crown-ring with tits during each thrust forwards and accompanying cumshot.  By the fourth load, your double is opening her soaked lips wide and guzzling it down.  By the sixth she's sputtering and coughing as the black sex juice sloughs off her.  By the ninth she's managed to clamp her lips over your cock-tip, and her throat bulges ludicrously with the effort of taking each load.  Thankfully, your orgasm finally winds down.  As the last few globs of inky jism escape from you, you realize your hips are still moving, plunging your massive possessed tool into its new favorite place.  Sighing, you hang onto your endowment and try to stay conscious in spite of your exhaustion and the overwhelming feelings coming from your groin.[pg]");
            }
            outputText("Still, your possessed maleness is far from finished as it continues to slide along her belly and between her still-dripping tits, and before long you feel another orgasm building.  You hang on for dear life, hoping just to stay conscious through the ordeal...[pg]Hour later you pull away, sated.  For now.");
            //common
            outputText("[pg]The succubus licks her fingers clean, looking totally recovered.  In the blink of an eye, she dashes out and disappearing in the distance.");
			player.sexReward("vaginalFluids","Dick");
			dynStats("cor", 5);
			cleanupAfterCombat();
        }

        public function SGRBM_fits():void {
            var x:int = player.findCock(1, -1, monster.vaginalCapacity());
            SGRBM_start(x);
            outputText("You plunge in to her velvety depths and feel her rippling cunt-muscles contract tightly around you for a perfect fit.  She gasps as each cock-distorting nodule bounces her two-inch clitty, making your mirror image moan like a bitch in heat.  The corrupted fluids dripping from her snatch squelch loudly, making your groin burn with pleasure.  ");
            if(player.hasBalls()) outputText("Looking down, you even see the veins on your sack darkening to solid black as the corruption begins tainting your sperm-factories.  ");
            outputText("You pull back, letting the ring of pointed fleshy barbs spring free before plunging them back in. The pleasure makes you swoon, nearly forcing you to orgasm on the spot.  ");
            if(player.biggestTitSize() > 0) outputText("Your female double reaches down to pinch your nipple, spurring you on, \"<i>Please, could you like, cum for me?</i>\"");
			transformations.CockDemon(x).applyEffect(false);
			//New PG
            outputText("[pg]");
			outputText("The succubus bucks her hips weakly, still clearly defeated, but egging on your orgasm as dark fluids squelch free from her quim.  \"<i>Please... can't you see how hot you're making me?  I've made your cock perfect, so please make me cum!</i>\" she begs as she quivers with delight.  ");
            outputText("You pause to think about it, not noticing that your groin is pounding away with furious energy, splattering cum and pre over her thighs as your new cock's instincts take control from your waist down.  Gasping with sudden pleasure, you feel a flash of heat pass through your tainted meatstick as an orgasm builds.");
            //New PG
            outputText("Each of the new bumps and rounded spines of your " + player.cockDescript(x) + " flood with blood, doubling in size as orgasm overtakes you.  ");
            outputText("Your hips bury your entire length inside her, acting on their own as your " + player.cockDescript(x) + " clenches, pouring more and more spunk inside her");
            if(player.hasBalls()) outputText(" as your balls empty their load queue");
            outputText(".  ");
            //Big cum
            if(player.cumQ() >= 50 && player.cumQ() < 400) outputText("You inhale as black cum spatters from her entrance, her belly distending slightly as you empty what feels like a gallon inside her.");
            //((Ginormohuge))
            if(player.cumQ() >= 400) outputText("Gasping in pleasure and surprise, you marvel as her belly visibly expands with each eruption of your dark load.  At first, it looks like a tiny belly, but by the time the orgasm finishes, your girlish double looks like a woman in her ninth month of pregnancy – with twins.");
            outputText("[pg]You pant with exertion and pull back, only to have your " + player.cockDescript(x) + " plunge right back in. Beginning another rough fucking session, your hips force-fuck her beyond your control.  Exhausted, you lean over her, figuring you may as well enjoy your double's wondrous breasts until your demonic cock has finally sated itself.  You just hope you don't black out from the waves of pleasure each of your new nubs radiates.[pg]\nHours later you pull away, sated.  For now.");
			//common
            outputText("[pg]The succubus licks her fingers clean, looking totally recovered.  In the blink of an eye, she dashes out and disappearing in the distance.");
			player.sexReward("vaginalFluids","Dick");
			dynStats("cor", 5);
			cleanupAfterCombat();
        }
		
		public function SuccubusGetsRapedByFemale():void {
			clearOutput();
			if(monster.HP <= monster.minHP()) outputText("Your foe staggers and falls hard on her ass, utterly defeated.  Her bruises and lacerations slowly fade and heal, regenerating with the aid of her demonic powers.  You easily tear through her clothes. It doesn't take much to force her down on her back and straddle her as you disrobe, ready to take your pleasure.[pg]");
			else outputText("Your foe drops to her knees, stuffing three digits into her greedy snatch as arousal overcomes her desire to subdue you.  With great care, you approach your insensible enemy and tear off her clothes as you force her down on her back.  As if possessing a will of their own, her legs lewdly spread as you disrobe.[pg]");
			outputText("Her budding clit rises from between her folds, hardening like a tiny three-inch dick.[pg]");
            menu();
            if (player.biggestLactation() > 1)
                outputText("<b>You could scissor with her, or maybe force-feed her some of the milk you've backed up.  Which will it be?</b>");
            addButton (0, "Scissor", ScissorSuccubus);
            addButtonIfTrue(1, "Force-feed", ForcefeedSuccubus, "Req. higher lactation", player.biggestLactation() > 1);
		}
		
		public function ScissorSuccubus():void {
			clearOutput();
			outputText("You shiver with anticipation as you hook your leg under her thick thighs, lining up your " + vaginaDescript(0) + " as you press forwards.  The anticipation builds as your matched honeypots grow ever closer.  Making contact, your folds part as her purplish-red clit slips betwixt your nether-lips, vibrating slightly in tune with the succubus' heartbeats.  You gasp, feeling your own " + clitDescript() + " erecting and rubbing against her smooth mound.[pg]");
			if(player.clitLength >= 3) outputText("You groan with wanton desire as your " + clitDescript() + " continues to grow and grow until reaching full size and slipping inside the defeated slut's sloppy pleasure-hole.  ");
			outputText("It takes only a few seconds to get the succubus' juices really flowing, the sounds of your grinding hips dissolving into a cacophony of liquid squelches.  The gooey corrupt fem-cum tingles, spreading warmth through every patch of skin it touches.  Your locked hips writhe and twist with hers, eliciting pants and squeals from both of you.  In no time flat, you find yourself cumming and feel your " + vaginaDescript(0) + "'s muscles clench hungrily with an unquenchable desire to be filled.  The succubus shivers in pleasure, probably feeding off your orgasm.  You back off, fingering your " + vaginaDescript(0) + " languidly and denying her a full meal.  Pouting, the succubus dips her fingers back in, determined to cum.");
			outputText("[pg]You turn away with a bemused sigh.  When you glance back, she has vanished!");
			player.sexReward("Default","Vaginal");
			dynStats("cor", 1);
			cleanupAfterCombat();
		}
		
		public function ForcefeedSuccubus():void {
			clearOutput();
			outputText("You chuckle as you decide to release some of the pent-up pressure in your [allbreasts].  Laying down over your conquest, you grasp her wrists and pin them to the floor as you shove your tits in her face");
			if(player.biggestTitSize() > 6) outputText(", nearly smothering the succubus with the swell of tit-flesh");
			outputText(".  You jiggle back and forth, lining up a " + nippleDescript(0) + " with the demon's parted lips.  You press your weight down threateningly, making it clear you could suffocate her with a boob.[pg]");
			outputText("\"<i>Drink up bitch, these tits are full!</i>\" you command.[pg]");
			outputText("The succubus tentatively takes a " + nippleDescript(0) + " into her mouth, sighing at the tangy taste of your sweat-drenched skin.  Her lips gently suckle, wrapping around the perky hardening nub as it fills with arousal and milk.  You feel something let go inside your " + breastDescript(0) + " and the succubus smiles, now working to free more of your trapped cream.[pg]");
			if(player.biggestLactation() < 2) outputText("Her flexible tongue easily curls around one of your " + nippleDescript(0) + "'s, letting her pull and tug on it as she increases the suction from her lips.  Your body rewards her efforts with a faster flow of milk that she sucks down as if she were starving.[pg]");
			if(player.biggestLactation() >= 2 && player.biggestLactation() < 3) {
				outputText("Her flexible tongue wraps around your milk-engorged nipple, pulling it tightly as she increases the suction of her lips.  Your body wastes no time rewarding her and she begins gulping down a steady supply of your breastmilk with a pleased expression on her face. You muse to yourself that perhaps succubi are masochists as breast-milk runs freely from your un-milked ");
				if(player.totalBreasts() > 2) outputText("tits.[pg]");
				else outputText("tit.[pg]");
			}
			if(player.biggestLactation() >= 3 && player.biggestLactation() < 4) {
				outputText("Her flexible tongue wraps around a milk-swollen nipple, immediately squeezing out a jet of thick breast-milk.  The tongue squeezes and tugs while the succubus ramps up the suction between her thick bee-stung lips.  Your body rewards her with fountains of milk, forcing her to visibly gulp and struggle to keep up with the heavy flow.  Milk runs freely down the [skin.type] on your chest, pooling around the succubus' groin and your own as the unattended nipple");
				if(player.totalBreasts() > 2) outputText("s");
				outputText(" can't help but dribble in sympathy.[pg]");
			}
			if(player.biggestLactation() >= 4) {
				outputText("Her flexible tongue wraps around a milk-bloated nipple, immediately releasing a massive spray of cream that pours into her gullet, nearly choking her.  You stifle a giggle and pull her closer.  Thankfully, her determined tongue manages to stay in place and start tugging your nipple about, releasing even more of your over-large milk production.  She struggles, her throat and cheeks bulging from your explosive output of milk, until it overwhelms her and begin to pour out of her nose.  More milk pours from your unoccupied nipple");
				if(player.totalBreasts() > 2) outputText("s");
				outputText(" in sympathy, drenching your [skin.type] with creamy goodness until it puddles on your captive demon.[pg]");
			}
			if(player.totalNipples() == 2) outputText("As your first nipple drains, you move her to your other breast, being sure to motivate her cunt by grinding it with your [foot].  She squeals and sucks harder, emptying the last of your milk with a cute burp.  ");
			if(player.totalNipples() > 2 && player.totalNipples() < 6) outputText("As your first " + nippleDescript(0) + " drains, you forcibly move her to the next, unleashing a fresh batch of milk for her to feast upon.  Eventually, it too dries up, so you migrate her onwards to your next " + nippleDescript(0) + ".  After she drains each of your " + num2Text(player.totalNipples()) + ", you smile happily at your now emptied breasts.  ");
			if(player.totalNipples() >= 6) outputText("As your first " + nippleDescript(0) + " drains, you force her over to the next, unleashing even more milk for her to feast upon.  In time, that " + nippleDescript(0) + " also empties and you rotate her on to the next.  The cycle repeats seemingly endlessly as you work her from nipple to nipple, relieving the insistent pressure of your breasts and slowly filling her with your milk.  ");
			if(player.averageLactation() * player.totalBreasts() < 6) outputText("Her belly bulges slightly from all the breast-milk she's consumed.[pg]");
			else outputText("The succubus looks bloated and pregnant from all the milk you've forced into her.  She sloshes and moans incoherently from the strain of it all.[pg]");
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
			outputText("[pg]You push her over, noting that her freed fingers immediately bury themselves in her demonic snatch, loudly squelching as she tends to her own arousal.  Her perfect visage is a mess, coated with musky girlcum");
			if(player.cocks.length > 0) outputText(" and a thick layer of spunk");
			outputText(".");
			outputText("[pg]You turn away with a bemused sigh.  When you glance back, she has vanished!");
			dynStats("lus", -50, "scale", false);
			player.sexReward("Default","Nipples");
			player.sexReward("Default","Tits");
			cleanupAfterCombat();
		}

		public function rapeCerberusStyle():void {
			flags[kFLAGS.TIMES_BEATEN_SERAPH_WITHOUT_LOSING]++;
			outputText("[Themonster] slowly backs away from you as its strength and charms wane, replaced by sheer terror. Your sensitive nose picks up a scent… the scent of a bitch in heat, ready to be bred by a mighty alpha… the slut is actually wet and ready for you and your twinned pricks react accordingly, hardening as a blob of steaming semen drops from your tip.[pg]");
			outputText("You shut off any protest from the bitch with a deafening roar, pouncing on your target and grabbing it by both arms as you lift the toy right above your twin corrupted dog dicks smearing your burning pre on the omnibus/succubus labia. You’re going to fuck that bitch pregnant with your seed. Soon, every cocksleeve of Mareth will know they belong to you.[pg]");
			outputText("It takes you mere seconds to properly align the tip of your dual erections with both holes before you slide your new toy along your throbbing erections. Ceraph's/The demon's body is now bloated with the sheer thickness of your members, her belly visibly giving out to accommodate your insertion. She desperately tries to pull out but with the work of gravity in tandem with your throbbing hardness working against her, all she does is fuel your lust in a flimsy attempt that only serves to jerk you off more.[pg]");
			outputText("Your left side growls in pleasure as your right side lecherously licks the demon's right breast…  Controlling them all the time can grow tiresome, and besides, you feel like letting them do what they want as you savor the ripples of the succubus cunt instinctively trying to draw the sperm out of your balls. The bitch can cry those alligator tears all she wants, you know that in truth, she's thoroughly enjoying being subject to your mighty cock. The thought of forcing the slut on her knees so you can fuck her throat next hit you for a moment but you sternly remember the bitch is just soulless flesh hardly worth your time aside from relieving the pressure in your balls. This worthless pile of meat is unworthy of being anywhere close to your beta.[pg]");
			outputText("You buck into her with increasing aggression as she squeezes her legs together, clenching her inner walls against you as she draws out a long moan, desperately trying to milk you of everything you have to offer as she cums. Her juices lubricate you further as your cocks throb with increasing intensity, twitching in barely contained anticipation.[pg]");
			outputText("Your three heads unleash a bellowing roar as you buck into her with all your might, shoving both your cocks as deep into her as you can reach, forcing her to take in every last ounce of cum as you unload it all into her. Her stomach deforms as she's helpless before the waves of jizz you deposit into her. Her belly bloats before you slowly pull out, your hot cum falling to the ground beneath you.[pg]");
			outputText("You toss the used toy to the ground now that you're done with it, taking your leave from the crumpled demon.");
			player.sexReward("vaginalFluids","Dick");
			cleanupAfterCombat();
		}
		
		private function killDemon():void {
			clearOutput();
			flags[kFLAGS.TRUE_DEMONS_KILLED]++;
			outputText("You make a quick work of the ");
			if (monster.short == "succubus") outputText("succubus");
			if (monster.short == "incubus") outputText("incubus");
			if (monster.short == "omnibus") outputText("omnibus");
			if (monster.short == "cow succubus") outputText("cow succubus");
			if (monster.short == "mino incubus") outputText("mino incubus");
			outputText(" before dragging the corpse away. That's one less foul creature prowling the realms. ");
			if (player.hasPerk(PerkLib.Purifier)) player.purifyDemonBonus();
			if (player.cor < 25) dynStats("cor", -0.5);
			if (player.enemiesKillCount() >= 10 && !player.hasPerk(PerkLib.KillingIntent)) {
				outputText("Kill upon kill, corpse after corpse... Ashes... to ashes... Your fingers itch, your blood boils, there's still more to kill, more fiends to slay. The fire burning inside is but another weapon of murder. <b>(You have gained the Killing Intent perk!)</b> ");
				player.createPerk(PerkLib.KillingIntent, 0, 0, 0, 0);
			}
			menu();
			addButton(1, "Leave", cleanupAfterCombat);
			addButton(2, "Take Skull", takeSkull);
			if (player.hasPerk(PerkLib.PrestigeJobNecromancer)) addButton(3, "Harvest", harvestBones);
			else addButtonDisabled(3, "???", "Req. Prestige Job: Necromancer.");
		}
		private function takeSkull():void {
			inventory.takeItem(useables.DEMSKLL, cleanupAfterCombat);
		}
		private function harvestBones():void {
			harvestDemonBones();
			cleanupAfterCombat();
		}
		public function harvestDemonBones():void {
			var harv:Number = 1 + rand(5);
			if (player.hasPerk(PerkLib.GreaterHarvest)) harv += 4 + rand(12);
			if (harv + player.perkv1(PerkLib.PrestigeJobNecromancer) > SceneLib.camp.campMake.maxDemonBonesStored()) harv = SceneLib.camp.campMake.maxDemonBonesStored() - player.perkv1(PerkLib.PrestigeJobNecromancer);
			outputText("You take your time to harvest material. You acquired " + harv + " bones!");
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, harv);
		}
	}
}
