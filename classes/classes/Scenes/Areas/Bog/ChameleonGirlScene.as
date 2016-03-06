/**
 * Created by aimozg on 03.01.14.
 */
package classes.Scenes.Areas.Bog
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;

	public class ChameleonGirlScene extends BaseContent
	{
		public function ChameleonGirlScene()
		{
		}

		/*You can ignore this stuff, just sets a random color to the chameleon girl at each encounter
		 ENCOUNTER TEXT (Introduction; First Time) (Z edited)
		 ENCOUNTER INTRO; REPEAT (Z edited)
		 COMBAT TEXT (Combat Menu) (Z edited)
		 LOSS SCENES (Intro) (Z edited)
		 -Herm Loss (Z edited)
		 -Male Loss (Z edited)
		 -Female Loss (Z edited)
		 VICTORY SCENES INTRO(Z edited)
		 -Herm Victory (Z edited)
		 -Male (Z edited)
		 -Female (for herms without dicks) (Z edited)
		 Item Use Scenes Intro (Victory) (Z edited)
		 -Incubi Draft (badly flawed; skip coding for now as author reworks -Z)
		 -P. Succubi Milk or Succubi Milk (Z edited)
		 -Lust and Sens Draft (you you you you you need to find more ways to start sentences without using pronouns, she?) (Z edited)

		 /*FEN NOTE:  USE SKINADJ IN PLACE OF STRIPECOLOR*/

//ENCOUNTER TEXT (Introduction; First Time) (Z edited)
//Savin's Note: This is way too much intro shit for a repeat-encounter; I'm adding a 2nd Time + intro below.

// TIMES_MET_CHAMELEON:int = 561;

		public function encounterChameleon():void
		{
			clearOutput();
			startCombat(new ChameleonGirl());
			spriteSelect(89);
			if (flags[kFLAGS.TIMES_MET_CHAMELEON] == 0) {
				outputText("You work your way through the dense foliage of the bog, pushing aside branches and slogging through the thick mud in search of something new.  Feeling exhausted, you slow down and look for a place to rest; finding a small clearing with shallow water no more than a couple inches deep and firmer ground, you sit back against a tree to catch your breath.  You're so soaked by now that you hardly notice the murky water beneath you and the slick mud on the trunk seeping into your " + player.armorName + ".  You lean your head back and close your eyes, enjoying a few moments of peace.");

				outputText("\n\nYour brief respite is disturbed by the sensation of warm breath against your face.  You snap your head up to see a humanoid face hanging upside down in front of you, watching you intently.  Startled, you scramble to your feet, pressing your back against the tree.  Before you have a chance to get a better look at whatever was observing you, it drops from the branch and flips itself over in a whirl, landing on its feet in a crouched position.  Your observer is some sort of lizard-like humanoid, though it appears to have smooth " + monster.skinTone + " skin rather than any sort of scales.  Long, " + monster.skinAdj + " stripes run along its body from ankle to shoulder.   It straightens itself up, allowing you to see that it's definitely female:  she has a slender body with slightly pronounced hips, their bones easily visible beneath her skin, and her breasts look to be about B-cups.  Her arms and legs are a bit longer than they would be on a human body, and her tail is quite long by a lizard's standards.  Her hands, too, are disproportionately large and look as though they're made to better grip and climb trees.  The skin on her front side is a light tan, and looks softer than the rest.   A set of long, brown horns protrudes forward from her forehead.  She's hardly clothed, wearing only a thick silken cloth tied around her back to hide her chest and a thong tied at her hip cut from the same material.  Her long, thin tongue hangs out of her slightly parted mouth.  She licks her lips grotesquely and slurps it back into her mouth as she eyes you up and down.");

				outputText("\n\nAfter a few moments of this uncomfortable standoff, she speaks.  \"<i>W-what are you doing in my bog?!</i>\"  She makes what you can only guess to be a menacing sneer and snaps her jaws in an attempt at intimidating you.");

				if (player.tallness > 76) outputText("\n\nBeing much shorter than you, her intimidation comes off as a bit comical; she tries to puff herself up as big as she can, holding her arms out a bit wider.");

				outputText("\n\nYou chuckle at the display, wondering who she is to claim the entire bog as her own.  Her tongue suddenly lashes out and splats against your face, and you stagger, head whipped back by the force of it.  When you regain your stability, she's crouched and looking to fight, made more apparent by the claws that have grown out of her fingers.  \"<i>You're... you're gonna pay for laughing!  I'll show you who's in charge here!</i>\"  Her skin seems to be changing, shifting in color to match her mood.  You step forward from the tree and ready yourself for a fight.");

				outputText("\n\nYou're fighting a chameleon girl!");
			}
			else {
				//ENCOUNTER INTRO; REPEAT (Z edited)
				outputText("You work your way through the dense foliage of the bog, pushing aside branches and slogging through the thick mud in search of something new.  Feeling exhausted, you slow down and look for a place to rest; a small clearing with shallow water and firmer ground seems to fit the bill, and you sit back against a tree to catch your breath.  You're so soaked by now that you hardly notice the murky water beneath you and the slick mud on the trunk seeping into your " + player.armorName + ".");
				outputText("\n\nA sudden scrape sounds behind you!  You spin around in time to see the familiar shape of a chameleon girl peeling off the trees.  She approaches you with a menacing glare in her eyes, growling \"<i>This is my bog!  Get out now or... or face the consequences!</i>\"  You raise your " + player.weaponName + " and prepare to defend yourself.");
			}
			flags[kFLAGS.TIMES_MET_CHAMELEON]++;
			doNext(playerMenu);
		}//LOSS SCENES (Intro) (Z edited)
		public function loseToChameleonGirl():void
		{
			clearOutput();
			spriteSelect(89);
			//-Lose by lust
			if (player.lust >= player.maxLust()) {
				outputText("Losing control to your own growing arousal, you fall to your knees and desperately start working to get at your needy body beneath your " + player.armorName + ".");
			}
			//Lose by HP
			else outputText("Too weak to keep fighting, you stagger back and fall to your knees.");

			//Savin's Note: Dude what the fuck. Bracket off your bits and pieces and LABEL YOUR SCENES RIGHT. -Savin
			//Abraxas' Note: This is like the tenth edition of this doc, something got mixed up in one of the transitions, I lost a paragraph along the way. Your scene is fine though, sorry about that.
			if (player.gender == 3 && rand(2) == 0) loseToChameleonWithCockAnBallsAnCunt();
			else if (player.gender == 1 || (player.gender == 3 && rand(2) == 0)) dudesLoseToChamChams();
			else if (player.hasVagina()) loseToChamChamWithPCCunt();
			else {
				outputText("\n\nThe Chameleon Girl gives you a once-over, but finding no genitals, she sighs and slaps you hard enough to have you black out.");
				player.takeDamage(20);
				combat.cleanupAfterCombat();
			}
		}


		//Herm Loss (Z edited)
		private function loseToChameleonWithCockAnBallsAnCunt():void
		{
			var x:int = player.biggestCockIndex();
			spriteSelect(89);
			outputText("\n\n\"<i>Hah! You didn't think you could beat me in </i>my<i> bog, did you?</i>\" the haughty chameleon laughs. She stalks towards you, swaying her wide hips in an exaggerated imitation of a dominatrix, shedding her spare clothing as she approaches.  She stops and stands before you, trying her best to look intimidating.  Wondering what exactly she has planned for you, you await your fate.  From the worried look in her eyes, you can tell she has no idea what she's doing.");

			outputText("\n\n\"<i>Um, strip for me!</i>\" she commands, as forcefully as she can manage.  Still, it almost sounds like a question.  Too weak to do anything but play along, you comply, shedding your " + player.armorName + ".");

			outputText("\n\nAs you set the last bit of your " + player.armorName + " aside in the water, you're suddenly struck in your chest and pushed to the ground.  The chameleon girl's wide foot keeps you pinned down, and she looks at you almost apologetically.  She shakes the worry from her face, and tries to appear stern once again.  \"<i>I'll... I'll show you who's the boss around here!</i>\"  Her tail darts towards you and uncoils at its end.  The tip starts probing around your " + player.vaginaDescript(0) + ", brushing across your " + player.clitDescript() + " as it feels around for your entrance.");

			outputText("\n\nHer eyes are still locked to yours, and her expression betrays her frustration.  Finally she finds purchase and, unable to resist, you relax your cunt and allow her to slide a length of her smooth, round tail into you.");
			player.cuntChange(8, true, true, false);
			outputText("  She keeps pushing in, thicker and thicker tail-flesh stretching your gash wider as she goes.  The stimulation arouses you despite your situation; lubricant drips from your pussy, allowing the chameleon girl to push a bit deeper into you.  Just when you think you can take no more, you feel the tip of her tail coil up, freeing a bit more room to be filled.  She grins maliciously, perhaps growing a tad more comfortable with being in charge, and forces into your innermost depths.");
			//(stretch check)
			player.cuntChange(25, true, true, false);

			outputText("\n\nYou gasp as you're stretched wide and filled more completely than you can imagine; the girl standing over you looks extremely pleased with herself.  She starts to move her tail ever so slightly, its every movement filling you with a painful pleasure as your pussy is repeatedly stretched.  Too turned on by the sensation to be angry at her for taking advantage of you, your sexual fluids drip from your cunt and erect maleness like a faucet.");

			outputText("\n\nThe weight lifts from your chest, but you're kept where you are by what's filling you.  The chameleon girl slides her foot down your belly, dragging her dull claws lightly over your skin.  Her ankle bumps into the hard shaft of your prick, and she lifts her foot, balancing herself in practiced form on the other.  She chuckles quietly and bites her fingertip, teasing along your aching cock with her sole.  Its skin is smooth, and feels like thick, supple leather when she grips you with it.  You can tell from her flexibility that her feet are made for gripping and climbing trees, and she easily finds a hold on your cock.  Thankfully taking care to keep her claws out of the way, she begins to jerk you off with her foot, sliding the whole sole up and down");
			//[if (cockarea <40)
			if (player.cockArea(x) < 40) outputText(" and occasionally lifting it to take the shaft between two dexterous toes and work it more delicately");
			outputText(".  She blushes as she watches your breaths turn to pants from the pleasure.");

			outputText("\n\nThe feelings of being filled and having your " + player.cockDescript(x) + " serviced by her foot are just too good, and you quickly reach orgasm, spattering her foot and shin with your hot cum.  Her face is red as she tries to maintain her composure, and her entire body is starting to grow flush with barely contained excitement.  She softly rubs your semen into your softening man-meat as you recover from your orgasm, looking at it almost blankly and smiling.  After a moment she snaps herself out of her reverie, remembering that she was supposed to be punishing you but obviously too aroused to do much.  \"<i>Um, yeah! And you, uhh, better not come back!</i>\"  She rushes off back into the trees, presumably to masturbate somewhere where you won't notice.  You shake your head at the girl's antics, dress yourself, and head back to camp.");

			//send player back to camp, reset hours since cum, remove gems and add time
			player.orgasm();
			combat.cleanupAfterCombat();
		}


		//-Male Loss (Z edited)
		private function dudesLoseToChamChams():void
		{
			var x:int = rand(player.totalCocks());
			spriteSelect(89);
			outputText("\n\nRecognizing that you're no danger, her skin shifts back into its natural " + monster.skinTone + " coloration as she walks towards you.  She swings her hips seductively as she splashes slowly through the water and licks her lips with a loud smack of her tongue, then reaches out and forcefully pulls your " + player.armorName + " above your waist before you can even try to resist her advances, and pushes you back against a tree.  With a few quick pulls of fabric she's stripped her own clothes, and she tosses her thong over a low-hanging branch.  The other band of silk she uses to quickly bind your wrists.  Were you in any shape to fight back you could pull free, but you're too ");
			if (player.lust >= player.maxLust()) outputText("overwhelmed by lust");
			else outputText("battered");
			outputText(" to even rip the makeshift binding.");

			outputText("\n\nShe makes short work of your " + player.armorName + " in her haste to see her prize, then stands up and, still looking down, lets her tongue fall out of her mouth and find its way to [oneCock].  In an amazing display of control, she manages to wrap the warm pink appendage around your man-meat, sliding the slick length of her warm tongue up and down your shaft almost as if she were massaging you.  You shudder softly as she tickles the underside of your cock with just the tip of her tongue, trailing sticky saliva around its head.  Your member is soon erect and throbbing with need; satisfied, she slurps the slender length of muscle back into her mouth.");

			outputText("\n\nThe chameleon girl grips the tree with her right hand and foot, and pulls herself up so that her sex is hanging in front of your face.  You try to stumble out of her reach while she's positioning herself, but she catches your wrists with her left hand and forces them over your head into the trunk, grinding the backs of your wrists into it as a means of punishment.  Her left leg, dangling beside you, snaps you back into place against the trunk with little room to move between her and the tree.  You try weakly to struggle free, but her grip is deceptively strong, and she has you trapped like a vice.  With a groan you relax and resign yourself to the rape.");

			outputText("\n\nHer dripping cunt grinds against your face, clearly wanting for attention.  Reflex turns your head away, but immediately she skins your arms against the rough bark again.  You bury your face in her pussy, doing your best to eat her out and move this process along.  A sharp gasp fills the air above you; clearly, she didn't expect the assault on her sex so soon.  Her musky scent fills your nose, matching the humid bog air oddly well.  You feel something grip onto your " + player.cockDescript(x) + ", and realize that she must have moved her foot onto it.  Her toes are apparently as skilled at gripping as her fingers, and the sole of her foot is fortunately covered in the same soft skin as the front of her torso.  Still wet and slick from the waters of the bog, it glides easily along your cock, her toes working your shaft with impressive dexterity and bringing you more pleasure than you'd have thought possible. A gush of female fluids leaks out and drenches your face as she moans, and she pushes herself back.  You take a few grateful breaths as she removes her foot and carefully climbs her way down a bit, pulling your bound arms with her so that she's now in position to impale herself on your " + player.cockDescript(x) + ".");

			outputText("\n\nShe teases the head of your cock with the smooth folds of her cunt, swirling around a bit as she creeps forwards little by little.  By now your need has grown so great that you don't even care that you're being raped, or how she proceeds, only that you must get off.  You moan lustily and, breaking into a wide smile, the chameleon girl slides herself down your rod, taking you ");
			if (player.cockArea(x) <= monster.vaginalCapacity()) outputText("to the base of its shaft");
			else outputText("as far as you can go into her");
			outputText(".  Her eyes go wide and she gasps sharply.  She begins panting and gyrating her wide hips as she slides ever so slightly up and down your cock, not pulling herself more than a couple inches away from you.  The range of motion she's able to put into her hips while holding herself up on the trunk of a tree astounds, and you watch the girl sway her hips rhythmically left to right, back and forth, around and around as she slowly, slowly teases her way mere inches up your shaft, making the same controlled movements on the way back down.  You don't know how much more of this pleasure you can take.  You want to ram into her slick cunt, but you're forced to just stand there and feel every smooth movement of her hips drive you mad with lust.");

			outputText("\n\nApparently, the chameleon girl is nearing the breaking point too.  A few inches of her tongue loll out of her mouth with more slipping out every time she pants or moans in pleasure, and her eyes look almost crossed as she stares blankly towards the base of your shaft.  Her hips begin to move a bit more erratically and she takes more of you into and out of her with each push.  Soon she's abandoned the slow, teasing motions and is just riding up and down your cock, slamming it in and out of herself in a desperate attempt to get off.  Her breasts bounce wildly and her head rolls back, with just a bit more of her tongue escaping each time she comes down on you.  The pleasure is too great, and you feel as if you could hardly stand it another moment.  The need to cum blares in your mind, pushing all other thoughts out.  The moans of the girl riding your " + player.cockDescript(x) + " hardly register with you as you release your load into her");
			if (player.cumQ() > 500) outputText(", filling her with so much cum that it leaks out of her and drips to the water below");
			outputText(".  The chameleon girl's pace slows once again, and both of your breaths come in deeply as you each recover from orgasm.  She sucks her hanging tongue most of the way back into her mouth, grimacing as she wipes some mud from it.");

			outputText("\n\nYour softening member slides out of her and she hops down, legs nearly giving out as she lands.  She takes a moment to recuperate before jerking your still-bound wrists towards the ground.  You collapse, unable to stand any longer anyways.  The chameleon girl mutters, \"<i>Oh my gods, that felt so-</i>\"");

			outputText("\n\nShe catches herself, and looks back down at you and sneers.  \"<i>Y-yeah, and you better not come back around my bog again,</i>\" she says between tired breaths as she takes the silk from your wrists and dresses herself again.  She splashes off through the water, leaving you in silence.  You take a while to recover from the experience before managing to work up the energy to get out of the mud and back to your camp.");
			player.orgasm();
			combat.cleanupAfterCombat();
			//send player back to camp, reset hours since cum, remove gems and add time
		}

		//-Female Loss (Z edited)
		private function loseToChamChamWithPCCunt():void
		{
			spriteSelect(89);
			outputText("\n\n\"<i>Hah! You didn't think you could beat me in </i>my<i> bog, did you?</i>\"  She stalks toward you, swaying her wide hips in an exaggerated imitation of a dominatrix, shedding her clothes as she approaches.   Positioning her glistening sex right in front of your face, she looks down and makes the cruellest smile she can manage.  Too busy stifling laughter at the awkward display, you make no move to pleasure her.  Looking bewildered that you aren't following along, the chameleon girl opens and closes her mouth, trying to find words.  She finally stammers out, \"<i>W-well?  Get... to it?</i>\"  You resist the urge to ask her for a detailed explanation of what she wants and resolve yourself to play along.  You'd be too exhausted to resist if she really tried to force you, and this may lessen the severity of the experience.");

			outputText("\n\nYou grab her by the hips and pull her in towards your face.  She gasps in surprise, but her shock quickly turns to pleasure as you begin to toy with her tiny clit, circling it and brushing lightly over it with your tongue.  As the pleasure overwhelms her, she sighs, and you think you catch something shifting from the corner of your eye.  Angling your head a bit, you can see her skin tone grow brighter as your teasing arouses her.  You'd laugh if your mouth wasn't already engaged.");

			outputText("\n\nTurning your attention back to the pussy in front of you, you lick at it with a newfound determination, wanting to see how brightly you can make her glow.  She moans and her knees buckle as you slip your tongue in and out of her, licking passionately up her cunt.  Her stripes shift crazily, the rainbow stripes on her legs wavering with your every movement.  You pull her closer against you and keep at it, enjoying the show.");

			outputText("\n\nYou enjoy it a lot, actually.  Despite her awkward attempts at domination, her vivid display of pleasure manages to arouse you greatly, filling you with the need to have something inside yourself.  You pull your " + player.armorName + " open, allowing you access to your own " + player.vaginaDescript(0) + ", and you put a couple fingers inside.  It's not enough.  Looking down, you spot her long, slender tail twitching weakly in the water beside you.  You reach down and take the end in one hand, your other still pulling her hips against you.  Without letting up in the siege of her inflamed genitals, you slide the tail slowly towards you and slip it between your own moist folds.  The chameleon girl seems too caught up in her own sensations to notice or care, moaning and grinding her pussy into your face.  You push the nearly neon appendage deeper into yourself, gasping as you push in thicker and thicker tail-flesh.  Filling yourself, you begin to slide it in and out, your moans of pleasure joining hers in the air as you continue to eat her out.  The tip of her tail flits lightly about inside you as the chameleon girl loses herself.");

			outputText("\n\nHer moans quickly grow more insistent above you, though, and she nearly collapses forwards onto your head as she cums loudly.  You steady her with one hand, still using her tail like a smooth sex-toy in the other as her skin fades back to its normal " + monster.skinTone + " coloration.  Mind apparently cleared by her orgasm, she suddenly jerks her tail back, forcing it out of your hand and " + player.vaginaDescript(0) + ".  \"<i>Wha... no!  B-bitches like you don't get to cum!</i>\"  She puts her most menacing smile back on, with yet no idea how to manage one.  \"<i>And, umm, you better not come back to my bog!</i>\"  She turns and quickly scampers off, pulling her wet clothes up off the ground as she goes.  You chuckle a bit as the wannabe dominatrix runs back into the trees, but stop as you realize she did beat you and leave you horny.  With a frustrated \"<i>Hmph!</i>\" you pull your " + player.armorName + " back up.");

			//set lust to 100, return to camp
			dynStats("lus=", player.maxLust());
			player.lust = player.maxLust();
			combat.cleanupAfterCombat();
		}

		//VICTORY SCENES INTRO(Z edited)
		public function defeatChameleonGirl():void
		{
			clearOutput();
			spriteSelect(89);
			//-Win by lust
			if (monster.lust >= monster.eMaxLust()) {
				outputText("Unable to control her arousal, the chameleon girl collapses to her knees and begins masturbating underneath her thong, having lost all capacity to fight you; she moans and throws her head back as her hand splashes in and out of the water she's kneeling in.  Her skin returns to its usual " + monster.skinTone + " and then keeps going, shifting closer and closer to pink as her moans increase in both volume and volubility.");
				if (player.lust >= 33) outputText("  Do you help the horny girl to get you both off?  Or maybe you could punish her bad attitude with something from your bag...");
			}
			//-Win by HP
			else {
				outputText("Too weak to continue fighting, the chameleon girl drops to her knees, exhausted.  Her skin returns to its usual " + monster.skinTone + ", unable to maintain the camouflage.");
				if (player.lust >= 33) outputText("  Do you use the girl in her weakened state to get yourself off?  Or maybe you could punish her bad attitude with an item from your bags...");
			}
			if (player.lust < 33 || player.gender == 0 || flags[kFLAGS.SFW_MODE] > 0) {
				combat.cleanupAfterCombat();
				return;
			}
			//(Display Options: [Fuck Her Face] [Pussy Rub] [Herm Style Pussyrub] [Incubi Draft] [Succubi Milk] [Lust&Sens Drafts])
			var dick:Function =null;
			var pussy:Function =null;
			var herm:Function =null;
			var item:Function =null;
			if (player.hasCock()) dick = manFucksChameleonWithBiggishWang;
			if (player.hasVagina()) pussy = femaleHasWinSexWithChamCham;
			if (player.gender == 3) herm = fuckDatChameleonAsACoolGuyGirlHerm;
			//let PC use item
			if ((player.hasItem(consumables.SUCMILK) || player.hasItem(consumables.P_S_MLK)) && player.hasCock()) item = useAnItemOnTheChamcham;
			else if (player.hasItem(consumables.SENSDRF) && (player.hasItem(consumables.L_DRAFT) || player.hasItem(consumables.F_DRAFT))) item = useAnItemOnTheChamcham;
			simpleChoices("Use Dick", dick, "Use Pussy", pussy, "Herm Style", herm, "Use Item", item, "Leave", combat.cleanupAfterCombat);
		}

		//-Herm Victory (Z edited)
		private function fuckDatChameleonAsACoolGuyGirlHerm():void
		{
			clearOutput();
			spriteSelect(89);
			var x:Number = player.cockThatFits(monster.vaginalCapacity());
			if (x < 0) x = player.smallestCockIndex();
			outputText("You shed your " + player.armorName + " and approach the fallen chameleon girl.  She stares at you in fascination as she spots your multiple endowments: " + player.sMultiCockDesc() + " and " + player.vaginaDescript(0) + ".  You look her up and down, following the smooth curves of her thin body with your eyes.  Squatting down beside her, you take her by the shoulders in one arm and trail your fingertips lightly up her torso with the other, feeling the soft skin of her belly.  Her eyes widen, and she looks from her hand to your face and back again.  When your hand reaches the silk cloth covering her chest, you pull it off with a light tug and cast it off to the side.  You cup her small breast in your palm, and as you squeeze it her skin tone changes perceptibly, flashing to a much brighter shade of the colors it was.");

			outputText("\n\nCurious, you take her nipple between your index finger and thumb, pinching and twisting and pulling on it, eliciting a series of sharp gasps and squeals.  She arches her back into your supporting arm and her skin flashes wildly, long stripes of color shifting across her body with your every tweak.  You find her complete inability to hide what she's feeling amusing, but you're much too turned on to just sit there and play with her.  Releasing her breast, you take her arm and guide her hand to your own slick cunt.  She gets the idea and begins to work her fingers lightly in and out of your wet folds.  You squeeze her close and breathe in deep, enjoying the sensation of her long fingers plunging in and out of your " + player.vaginaDescript(0) + ".  It feels so good to have her touching you, and as you bask in the pleasure you lose your balance.  The two of you topple over backwards, landing in the shallow water with a splash.  Unsure what to do, the chameleon girl freezes up and looks almost apologetically into your eyes.  You laugh quietly at her confusion and guide her fingers back into motion with your hand.");

			outputText("\n\nTaking the hint, she starts playing with your dripping gash again, sometimes teasing your " + player.clitDescript() + " with her fingers.  Your throbbing cock aches for attention, though, and an interesting idea pops into your head; you pick her tail up off the ground and, though she tries to twitch it away instinctually, you hold tight.  It relaxes, and you guide it towards your needy member, then gently wrap its end around a few times.  With a mischievous smile, the girl tightens her grip more than you expected, slowly pumping your shaft up and down with her strong tail.  Pre-cum begins to leak from the tip of your " + player.cockDescript(x) + " and your pussy drools with sexual fluids as the extra the stimulation affects your body.");
			outputText("\n\nNot ");
			if (player.cor < 50) outputText("one to be selfish");
			else outputText("feeling quite as selfish as usual");
			outputText(", you remove your arm from its place behind her and slide your hand down towards her waist, easily untying the makeshift thong and laying it off to the side.  Slipping between her legs, you climb your way up her thigh to her glistening entrance, dancing your fingers around her tiny clit, stroking and stimulating it; she gasps and her skin once again begins flashing in a rainbow display.  You smile at the effect you have on her, and work your fingers into her pussy, sliding them up and down her smooth walls.  The gasps turn to pants, and she coos in pleasure as you push deep into her.   Her long, slender fingers in your own cunt press against you; you lean your head against her shoulder and just enjoy the feeling as the two of you lie there, fingering each other in the damp bog.  For her part, the chameleon girl looks unsure whether or not she should feel embarrassed, and seems almost to tense up a bit as her colors shift more rapidly.  Her hand remains just as passionate in its work at your " + player.vaginaDescript(0) + ", though, and her tail keeps its soft but insistent grip on your shaft.");

			outputText("\n\nAfter spending a while lying in the water with her and yielding to the pleasure running deeper and deeper through you, you feel the wave of an orgasm approaching.  The girl next to you is not far off either; her stripes and colors are pulsing faster, shifting in time with the beating of her heart.  Her pussy clenches around your fingers and she lets out a soft moan just before your orgasm washes over you, and with a roar of pleasure you splatter her tail and hand with your cum.");

			outputText("\n\nThe two of you slow down and eventually fall still, basking in the afterglow.  When you look back to the chameleon girl, you can see that she's fallen asleep cuddling against you, her arm still draped over your naked thigh and her tail lying limp against you.  The head pressed against your shoulder wears a content smile; you gently ");
			if (player.cor < 50) outputText("and guiltily ");
			outputText("roll her onto her back and get up to collect your things, rinsing yourself with the water and shaking the mud out before putting your " + player.armorName + " back on and heading back to camp.");
			player.orgasm();
			combat.cleanupAfterCombat();
		}

		//-Male (Z edited)
		//(Savin's note: This only makes a lot of sense for biggus dickus characters; consider an alternative for traps/weany dick characters. We don't all have even footlongs) (yuh)
		private function manFucksChameleonWithBiggishWang():void
		{
			clearOutput();
			spriteSelect(89);
			var x:int = player.biggestCockIndex();
			outputText("You approach the fallen girl, and she looks up at you, a pleading expression in her eyes.  You might feel worse for her if she hadn't tried to assault you in a bog.  Reaching down behind her, you find the knot of the cloth covering her breasts, and with a quick pull you yank it off and toss it aside, then drop your [armorName], revealing your erect prick.  Her eyes widen when she sees it and her mouth parts slightly, letting a bit of her tongue slip out to lick her lips.  Quietly disdainful of the slutty girl's open arousal, you decide that if she wants to taste it so badly, she may.  But when you put your hand on the back of her head to push her onto your stiff cock, she manages to work up the strength to grab your arm with a free hand and resist its impulse.  Looking her over, you can see that her sudden burst of energy is due to ");
			if (monster.lust >= monster.eMaxLust()) outputText("her masturbating even more furiously than before at the thought of having your cock.");
			//[if lost by HP:
			else outputText("her starting to work the fingers of her free hand in and out of her own sex.");

			outputText("\n\nWith a quick jerk of her head, she throws more than a foot of her tongue over your " + player.cockDescript(x) + ".  Her eyes narrow in concentration, and it works itself around and around your shaft, encircling it in thin pink bands.  Her tongue coats you with the thick saliva as it travels, wrapping more of you in its loose, warm embrace.  The folds of her tongue slide against your throbbing cock, almost completely covering it and making you feel as warm and wet as if you were in her.  You notice that her skin is beginning to take on a redder hue, and that her masturbation and moans of pleasure are growing more and more passionate as more of her tongue wraps around you, and you wonder for a moment if her excitement has something to do with the taste.  The train of thought is quickly abandoned as she begins to swirl the sticky tip of her tongue around the head of your prick; the pleasure is so intense that it almost burns, and your knees buckle just a bit at the sudden sensation.  Her tongue works its way up and down your shaft, gently massaging your cock as she squeezes and relaxes around different parts of it.");

			outputText("\n\nVery soon, drops of pre-cum begin to dribble from the tip of your cock.  She immediately darts the tip of her tongue around to catch them and wipe them up.  Her eyes roll back and she sighs heavily at the taste, thrusting her fingers deep into herself and enjoying the feeling for a moment.  The red tint of the chameleon girl's skin almost immediately changes to a bright pink, and she reaches up with her free hand to grip an uncovered part of your shaft near the base.  Her grip is firm, but the flesh on her palms and long fingers is thick and soft.  She begins pumping with her hand in time with the contractions of her tongue, and the supple skin gently but forcefully works with the wet muscle to bring you closer to orgasm.  Her tongue catches and wipes away every bit of pre-cum that she ekes out, the poor girl nearly driving herself insane with the need for more of it to taste.  The pace at which she works your cock increases, and you can feel that you'll cum soon at this rate.");

			outputText("\n\nAs if sensing this, she loosens her tongue's grip, letting her hand take over; supple flesh glides along the slick saliva left behind.  It bunches up under the tip of your cock, ready to catch your cum.  With a few final tugs, ");
			if (player.balls > 0) outputText("your " + player.ballsDescriptLight() + " clench and ");
			outputText("the semen erupts from the end of your " + player.cockDescript(x) + " spilling out hot spunk over her folded tongue.  She gasps audibly and arches her back as the thick ropes of your jizz coat her tongue, shoving her long fingers as far as she possibly can into her dripping pussy, and flashes so brightly pink she nearly glows.");
			if (player.cumQ() > 750) outputText("  The torrent of cum bursting from your cock just doesn't stop, and her eyes roll back into her head as your semen coats her face and runs off her tongue, drenching her breasts and belly in white.  Her head falls back and her tongue goes limp as she's sent into ecstasy by the flood.");

			outputText("\n\nYour orgasm comes to an end, and the chameleon girl lets her hands slide from your cock and out of her pussy.  She snaps her tongue back into her mouth, spooning what she can of your semen in with it.  With a loud swallow, her eyes roll back into her head and she falls onto her back, passing out from the pleasure.");
			if (player.cumQ() > 750) outputText("  Even the murky water around her is turned white as the pools of your cum on her body run off into it.");
			outputText("  Satisfied, you put your " + player.armorName + " back on and head back to camp.");
			//send player back to camp, reset hours since cum, add gems and time
			player.orgasm();
			combat.cleanupAfterCombat();
		}

		//-Female (for herms without dicks) (Z edited)
		private function femaleHasWinSexWithChamCham():void
		{
			clearOutput();
			spriteSelect(89);
			outputText("You shed your " + player.armorName + " and approach the fallen chameleon girl");
			if (monster.lust >= monster.eMaxLust()) outputText(", her moans of pleasure growing more desperate as you approach");
			outputText(".  You look her up and down, following the smooth curves of her thin body with your eyes.  Squatting down beside her, you take her weak body by the shoulders in one arm and trail your fingertips lightly up her torso with the other, feeling the soft skin of her belly.");
			if (monster.lust >= monster.eMaxLust()) outputText("  She coos lustily at the sensation.");
			else outputText("  Her eyes widen, and she looks from your hand to your face and back again.");
			outputText("  When your hand reaches the silk cloth covering her chest, you pull it off with a light tug and cast it off to the side.  You cup her small breast in your palm, and as you squeeze it her skin tone changes perceptibly, flashing to a much brighter shade of the colors it was.");

			outputText("\n\nCurious, you take her nipple between your index finger and thumb, pinching and twisting and pulling on it, eliciting a series of sharp gasps and squeals.  She arches her back into your supporting arm and her skin flashes wildly, long stripes of color shifting across her body with your every tweak.  You find her complete inability to hide what she's feeling amusing, but you're much too turned on to just sit there and play with her.  Releasing her breast, you take her arm and guide her hand to your own slick cunt.  She gets the idea and begins to work her fingers lightly in and out of your wet folds.  You squeeze her close and breathe in deep, enjoying the sensation of her long fingers plunging in and out of your " + player.vaginaDescript(0) + ".  It feels so good to have her touching you, and as you bask in the pleasure you lose your balance.  The two of you topple over backwards, landing in the shallow water with a splash.  Unsure what to do, the chameleon girl freezes up and looks almost apologetically into your eyes.  You laugh quietly at her confusion and guide her fingers back into motion with your hand.");

			outputText("\n\nNot ");
			if (player.cor < 50) outputText("one to be selfish");
			else outputText("feeling quite as selfish as usual");
			outputText(", you remove your arm from its place behind her and slide your hand down towards her waist, easily untying the makeshift thong and laying it off to the side.  Slipping between her legs, you climb your way up her thigh to her glistening entrance, dancing your fingers around her tiny clit, stroking and stimulating it; she gasps and her skin once again begins flashing in a rainbow display.  You smile at the effect you have on her, and work your fingers into her pussy, sliding them up and down her smooth walls.  The gasps turn to pants, and she coos in pleasure as you push deep into her.   Her long, slender fingers in your own cunt press against you; you lean your head against her shoulder and just enjoy the feeling as the two of you lie there, fingering each other in the damp bog.  For her part, the chameleon girl looks unsure whether or not she should feel embarrassed, and seems almost to tense up a bit as her colors shift more rapidly.  However, her soft hand remains just as passionate in its work at your " + player.vaginaDescript(0) + ".");

			outputText("\n\nAfter spending a while lying in the water with her and yielding to the pleasure running deeper and deeper through you, you feel the wave of an orgasm approaching.  The girl next to you is not far off either; her stripes and colors are pulsing faster, shifting in time with the beating of her heart.  Her pussy clenches around your fingers and she lets out a soft moan just before your orgasm washes over you, and you splatter her hand and the insides of your thighs with girlcum.  The two of you slow down and eventually fall still, basking in the afterglow. When you look back to the chameleon girl, you can see that she's fallen asleep cuddling against you, her arm still draped over your naked thigh.  You gently ");
			if (player.cor < 50) outputText("and somewhat guiltily ");
			outputText("roll her onto her back and get up to collect your things, shaking out the mud and water before putting your " + player.armorName + " back on and heading to camp.");
			//send player back to camp, reset hours since cum, add gems and time
			player.orgasm();
			combat.cleanupAfterCombat();
		}

		//Item Use Scenes Intro (Victory) (Z edited)
		private function useAnItemOnTheChamcham():void
		{
			clearOutput();
			spriteSelect(89);
			outputText("Looking at the poor girl kneeling pathetically before you, you almost feel sorry for her.  But, she did try to rape you and claim that you were on 'her' territory.  You rummage through your bags, trying to find a fun way to punish her.  Fun for you, at least.");

			//player must have either a purified or unpurified Succubi Milk (also requires cock,) Incubus Draft, or Lust & Sens Draft (both) in inventory
			//also incubi draft and succubi milk should probably have something of a corruption requirement
			//(Display Options: [Incubus Draft] [Succubi Milk](PC must have cock) [Lust&SensDrafts]
			//optionz go herez
			var milk:Function =null;
			var drafts:Function =null;
			if ((player.hasItem(consumables.SUCMILK) || player.hasItem(consumables.P_S_MLK)) && player.hasCock()) milk = giveTheChameleonASuccubiMilk;
			if (player.hasItem(consumables.SENSDRF) && (player.hasItem(consumables.L_DRAFT) || player.hasItem(consumables.F_DRAFT))) drafts = doseDatChameleonWithLustAndSensitivityDrafts;

			simpleChoices("SuccMilk", milk, "LustnSensD.", drafts, "", null, "", null, "Back", defeatChameleonGirl);
		}

		//-P. Succubi Milk or Succubi Milk (Z edited)
		//Prerequisite: at least one dick
		private function giveTheChameleonASuccubiMilk():void
		{
			clearOutput();
			spriteSelect(89);
			outputText("You find a bottle of Succubi Milk tucked away in a pouch.  A wicked smile comes to your face as you imagine filling her so full of the stuff that her tits grow to the point where she can't even move, but you ultimately decide that just one dose will suffice for now.");

			outputText("\n\nContainer in hand, you stride towards the collapsed girl.  She sees the glass full of liquid in your hand and tries to scramble away, but you're too fast for her, taking her by the shoulder to hold her forcefully in place.  With her mouth tightly closed, she shakes her head and tries to voice her disapproval through sealed lips.  You release her shoulder and dart your hand to her nipple, pinching it almost violently.  Her eyes water and she gasps, opening her mouth just long enough for you to put the neck of the bottle between her lips and tip the bottom of the glass up; the liquid spills into her mouth, and massaging her throat causes her to reflexively swallow the whole container's worth of fluid.");

			outputText("\n\nFor a moment, nothing happens, and she sits there paralyzed, waiting for the drug to take effect.  Her tits begin to plump up, slowly but surely growing as the milk has its way with her body; a smile parts your lips at the sight.  Her eyes widen as her once-meager tits fill out to DD-cups, pushing against and eventually tearing the thin silk covering from within.  They finally stop growing, and the chameleon girl sits there trembling, unsure what to think about her new disproportionate bust.  Completely pleased with her new appearance and harboring no such reservations, you start to shed your " + player.armorName + ".");

			var x:int = player.biggestCockIndex();
			outputText("\n\nShe looks back up from her rack to see you standing naked in front of her, cock erect after watching her sudden growth.  Her eyes water, and she flushes red with anger.  \"<i>You... why would you...</i>\"  You cut her off with a push, taking her off her knees and onto her back, and then jump on top of her, pinning her to the peat");
			if (player.hasLongTail() > 0) outputText(" with your tail,");
			else outputText(" by straddling her,");
			outputText(" your cock aimed for her pillowy tits.  She pushes and squirms beneath you, but cannot get enough leverage to move you.  You take her breasts in your hands and shimmy up her torso towards them, squeezing them around your " + player.cockDescript(x) + ".");

			outputText("\n\nThe chameleon girl's poor resistance dies as you move her tits up and down your shaft; she watches you with fascination rather than fear now.  You furiously pump her huge, soft breasts, slick enough with bog water and sweat that they slide easily along your length.  She's clearly warming up to her new proportions, and she places her hands on top of yours, even assisting you in fucking her tits.  You relax a bit and let her take over for you; she furrows her eyebrows in concentration as she tries to get the hang of handling such large breasts.  Though awkward in her motions at first, she manages to find a grip and a rhythm and is bouncing her tits around your aching member in no time.");

			outputText("\n\nDespite her inexperience, her huge, soft breasts feel divine as they smother and stimulate your cock.  Enough of your pre-cum has leaked out onto her skin and been rubbed back into your shaft that it feels nearly as warm and sticky as her sex; hands work ever more efficiently at squeezing her tits against you and getting you off, and she even moans a little as she finds the time to tweak a nipple.  Her efforts don't go unrewarded, and soon you're releasing a torrent of hot cum all over her neck and face; she opens her mouth wide, catching what she can and swallowing greedily.  The colors of her body shift slightly and her stripes grow so bright that they seem to shine.  She collapses back into a blissed-out heap, still covered in your semen.  Pushing out the last of it, you recover yourself and stand up, leaving the girl to enjoy the taste of your seed and her new endowments.");

			//send player back to camp, remove 1 succubi milk or p.milk, add gems and exp and time
			player.orgasm();
			if (player.hasItem(consumables.P_S_MLK)) player.consumeItem(consumables.P_S_MLK);
			else {
				player.consumeItem(consumables.SUCMILK);
				dynStats("cor", 5);
			}
			combat.cleanupAfterCombat();
		}

		//-Lust and Sens Draft (you you you you you need to find more ways to start sentences without using pronouns, she?) (Z edited)
		private function doseDatChameleonWithLustAndSensitivityDrafts():void
		{
			clearOutput();
			spriteSelect(89);
			outputText("You dig through your bags and come across a particularly tortuous combination of fluids.  With a Lust Draft in one hand and a Sensitivity Draft in the other, you return to the chameleon girl, swirling them and smiling at her menacingly.  She starts to protest, but you cut her off by shoving the opening of the Lust Draft vial into her open mouth.");

			outputText("\n\nHer eyes widen in shock as the sticky fluid pours over her tongue.  She clearly hasn't had a taste of the stuff before, and her eyelids half-close as it starts to take effect.  She sways and barely manages to catch herself before falling.  \"<i>What... what is this stuff?  Why do I...</i>\"  Her thoughts run away from her, and she groans, arousal overpowering her.  Too turned on to fight further, she doesn't resist as you easily remove the cloth covering her breasts and use it to bind her wrists, pulling her hands away from her groin in the process.  You lift her chin up and pry her mouth open with your thumb, to tip the bottle of Sensitivity Draft inside.  She swallows the stuff almost greedily, apparently expecting more of the first drink, then smacks her lips and licks them, trying to collect the residue.");

			outputText("\n\nToo turned on to just sit there, she falls forward, catching herself on you, then looks up, pleading with her eyes.  You laugh mirthlessly at her grovelling form, and tell her to beg if she wants you.  \"<i>Please!</i>\" she squeals, her eyes watering, \"<i>I need this!</i>\"  She tugs insistently at your " + player.armorName + ", begging for you to fill her and crying out that she can't stand to feel so empty.  You grin, and wonder if the sensitivity draft has started to take effect.  Two fingers run lightly up her forearm produce shivers at the obviously amplified sensation, and a tweak of her nipple elicits a shrill shriek.  \"<i>Why does it feel so good?!</i>\"  She puts her face into your lap and begs, \"<i>I don't even know what's going on, please, just fuck me, pleasepleaseplease...</i>\" trailing off as she grinds her pussy into you.");

			outputText("\n\nWorried that she might actually manage to cum just from rubbing herself against you, you shove her roughly onto her back, then kneel at her side; she looks up with pure desperation in her eyes.  Before she can beg any more, you reach down and start softly running your hand up and down her belly.  She gasps, clearly getting more out of this than she should thanks to the drugs, blushing and moaning as you rub the soft flesh of her midriff, taking care not to touch her breasts or pussy.  She squirms beneath the soft tickle of your palm, trying to force her cunt to your hand.  \"<i>S-stop it!</i>\"  Her blush spreads across her body, turning her skin a bright red.  \"<i>Just fuck me already!  Please!</i>\"  You pay her no mind and continue to stroke her belly, laughing when she starts to slap her tail against the water in frustration at feeling every sensation except those she needs most.");

			outputText("\n\nYou decide to push her a little bit further, and start playing with her naked breasts.  A light tug on one of her small nipples makes her yelp and arch her back, and you use the opportunity to take more of her flesh in your hands and squeeze; she shouts as the flood of sensation rushes over her.  It looks like the light has gone out of her eyes, and she's a babbling mess.  Clearly she's reached her breaking point and passed it, rolling from side to side thoughtlessly.  You chuckle to yourself and run your hand down her smooth abdomen, tracing the outlines of her hipbones, brushing lightly across her flesh.  When you reach her thigh, you rotate your hand around to the inside of her leg and rub in small circles with the tips of your fingers, and she moans with need between her heavy breaths.");

			outputText("\n\nYou keep going down her leg, though, teasing her along the length of her calf.  Reaching her foot, you bend her leg to give you better access to its sole.  You tickle her across her wide sole with just the lightest touch of your fingertips, and she shudders, too assaulted to even manage a proper giggle.  You play with her foot for a minute; she tries to kick back against your hand and her sole curls around and grips your fingers as though trying to milk them for their touch.  She seems to almost go limp below you, crazed by your tortuous wanderings over her hypersensitive flesh.  Deciding that she's finally had enough, you put her leg down and run your hand back up it, moving towards her waist.");

			//(if no cock or cock is too damn big)
			if (!player.hasCock() || player.cockArea(player.smallestCockIndex()) > monster.vaginalCapacity()) {
				outputText("\n\nYou reach under her thong and toy with her clit for just a moment.  She nearly jumps, almost managing to sit up before collapsing back down into the water, and you slip a couple fingers into her slick cunt to be immediately met with a gush of her fluids.  She cries out loudly and her pussy clenches around your fingers as she cums, getting off quickly after all her waiting; then curls up on her side as her tail thrashes wildly while orgasm slowly melts her painful nerves down to normal levels.  After a minute she slackens and spreads out on the ground, panting heavily as she recovers.  Smiling down at the tired chameleon girl, you wish her luck with her new nerves and untie her hands.  She's too exhausted to get up, though, and you leave her lying there to sleep in the swampy water.");
				//player.lust+=30;
				dynStats("lus", 30);
			}
			//(else if at least one cock of appropriate size)
			else {
				var x:int = player.cockThatFits(monster.vaginalCapacity());
				if (x < 0) {
					outputText("COCK ERROR");
					combat.cleanupAfterCombat();
					return;
				}
				outputText("\n\nYou gently tug at the knot of her thong, and the fabric easily slips away from her wide hips.  Her arousal is obvious; she's practically drooling lubricant.  The sight is just too enticing; you hastily shed your " + player.armorName + " and position your " + player.cockDescript(x) + " in front of her needy fuck-hole.  She gasps sharply and arches her back as you press the head of your erect member against her slick lips; her hands shoot out and grab at your arms, trying desperately to pull you in to her.  With a smile you oblige, pushing deep into her pussy.  Already too far gone with your earlier teasing, she immediately cries out in orgasm, the walls of her cunt squeezing your cock with all they've got.  Though you expect her to relax into a stupor after the release, she's clearly not satisfied with just cumming once while you're still inside her, gripping you tightly with her hands and beginning to slide her hips up and down your cock.");

				outputText("\n\nYou trace one finger lightly up and down her belly again, and she squirms as the powerful chemicals and sensations you've given her make her cum again and again.  Her eyes roll up and she pants openly, her mind completely broken by the overwhelming pleasure.  You start to notice that she feels almost a bit <i>too</i> good around you, and you wonder if the magic of the tainted liquids might also be affecting you to some extent, seeping into your system as her sexual fluids bathe your " + player.cockDescript(x) + ".  The squeezes of her hands on your skin feel as crisp as pinches but lack the pain, and you can feel the warm, wet folds of her pussy pressing against every inch of your prick.  Your thrusting intensifies as your whole body aches with need, and she wriggles and squeals as you push deeper into her, as if to outdistance your own orgasm building inside of you.  Her legs wrap around your back and hold you deep inside as you cum, and so much erupts from your " + player.cockDescript(x) + " that not even her vise-like wringing can prevent it from gushing back out and dripping down to the base of your cock.  Her grip on you loosens as she feels the proof of your lovemaking inside her.  You run a hand along her skin and she shudders, though your presence barely registers with her at this point.  Doubtful that this one will try to assert her dominance over you again any time soon, you pull your softening member out of the blissed-out chameleon-girl and stand up, donning your " + player.armorName + " and leaving the semi-conscious girl there in the bog to recover.  The chemicals that you've gotten a contact high from leave you feeling somewhat aroused as you make your way back to camp.");
				//player.lust = base + 20;
				player.orgasm();
				dynStats("lus", 20);
			}
			//send player back to camp, remove sens/fuck draft, reset hours since cum, add gems and exp and time
			player.consumeItem(consumables.SENSDRF);
			if (player.hasItem(consumables.L_DRAFT)) player.consumeItem(consumables.L_DRAFT);
			else player.consumeItem(consumables.F_DRAFT);
			combat.cleanupAfterCombat();
		}
	}
}
