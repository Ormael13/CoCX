package classes.Scenes.Seasonal {

	import classes.*;
	import classes.GlobalFlags.*;
	
	public class XmasElf extends BaseContent
	{
		public function XmasElf() {}
		
		public function xmasBitchEncounter():void
		{
			clearOutput();
			spriteSelect(9);
			outputText("Your sleep is disturbed by something repeatedly smacking into your side.  Groggily at first, you grumble and throw back your blanket.  Then you remember where you are, and snap to full wakefulness.  You launch onto your feet, bring up your fists, and stare bewildered at the sight in front of you.\n\n", false);

			outputText("Standing there, innocent as can be, ");
			if (flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] == 0) outputText("is an elf.  She can't be more than four and a half feet tall, and though she has fairly womanly hips, her chest is nothing to speak of.  Her clothing is strange – a red two piece lined with some kind of white fur.  She has typically pointed ears, blond hair, and a red fur-lined cap topped with a white puffball. She's holding a large box in front of her and looking at you expectantly as you stare, dumbfounded.\n\n", false);
			else outputText("is the same elf you met last year.  She can't be more than four and a half feet tall, and though she has fairly womanly hips, her chest is nothing to speak of.  Her clothing is strange – a red two piece lined with some kind of white fur.  She has typically pointed ears, blond hair, and a red fur-lined cap topped with a white puffball. She's holding a large box in front of her and looking at you expectantly as you stare, dumbfounded.\n\n", false);

			outputText("The elf says, \"<i>Hiya " + player.short + "!  I brought you a");
			if (flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] > 0) outputText("nother");
			outputText(" present, straight from the big man himself!</i>\"\n\n", false);

			if (flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] > 0)
			{
				outputText("Confused by her sudden re-appearance, you dumbly ask if you'll be getting the same thing as last year.\n\n");

				outputText("She giggles, \"<i>Oh silly, that would spoil the surprise, wouldn't it?  We've got EVERYONE on our list, even ");
				if (flags[kFLAGS.KELT_BREAK_LEVEL] < 4) outputText("Kelt, though he's getting coal AGAIN");
				else outputText("Kelly, though I think she's getting another big fat dildo");
				outputText(".  You'll get what you're supposed to get!</i>\"\n\n", false);
			}
			else
			{
				outputText("Confused by her appearance and the fact that she already knows you by name, you dumbly ask how she can possibly know who you are.\n\n", false);

				outputText("She giggles, \"<i>Oh silly, don't you know what time of year it is?  We've got EVERYONE on our list, even ");
				if (flags[kFLAGS.KELT_BREAK_LEVEL] < 4) outputText("Kelt, though he's getting coal this year");
				else outputText("Kelly, though I think she's getting a big fat dildo this year");
				outputText(".</i>\"\n\n", false);
			}
			awardAchievement("Naughty or Nice", kACHIEVEMENTS.HOLIDAY_CHRISTMAS_I);
			outputText("You wonder out loud, \"<i>So this... present is mine?</i>\"\n\n", false);
			if (player.cor >= 90 || getGame().monk >= 5 || player.findStatusEffect(StatusEffects.Exgartuan) >= 0 || getGame().amilyScene.amilyCorrupt() || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00283] > 0 || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00282] > 0 || flags[kFLAGS.NIAMH_STATUS] > 0)
			{
				outputText("She nods, bouncing up and down in excitement and flushing slightly, \"<i>Yup, just tear the lid off and get your gift!</i>\"\n\n", false);
				if (flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] > 0) outputText("Here we go again...\n\n");
				//[Open Present] [Unwrap Elf] [Decline]
				simpleChoices("OpenPresent", openXmasPresent, "", null, "Decline", declineXmasPresent, "", null, "", null);
				return;
			}
			if (player.gender == 0)
			{
				outputText("She nods, bouncing up in down in excitement, \"<i>Yup!  Just open it up!  Are you ready?</i>\"\n\n", false);
				simpleChoices("OpenPresent", openXmasPresent, "", null, "Decline", declineXmasPresent, "", null, "", null);
				return;
			}
			outputText("She nods, bouncing up in down in excitement, \"<i>Yup!  You can unwrap it or unwrap me.  What'll it be?</i>\"\n\n", false);
			//[Open Present] [Unwrap Elf] [Decline]
			simpleChoices("OpenPresent", openXmasPresent, "Unwrap Elf", unwrapElfyPresent, "Decline", declineXmasPresent, "", null, "", null);
		}

		//[Decline]
		public function declineXmasPresent():void {
			spriteSelect(9);
			clearOutput();
			outputText("You shake your head 'no', and inform the elf that you'll have nothing to do with her 'gifts' or 'surprises'.  She looks on the verge of tears as she whines, \"<i>I'm going to get reamed for this!</i>\"\n\n", false);
			
			outputText("Before you can react, she sprints off into the darkness.", false);
			flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] = date.fullYear;
			doNext(playerMenu);
		}
		//[Open Present]
		public function openXmasPresent():void {
			spriteSelect(9);
			clearOutput();
			outputText("You easily rip through the ribbons holding the box together and pull off the top.   You gasp in ", false);
			if (player.cor >= 90 || getGame().monk >= 5 || player.findStatusEffect(StatusEffects.Exgartuan) >= 0 || getGame().amilyScene.amilyCorrupt() || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00283] > 0 || flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00282] > 0 || flags[kFLAGS.NIAMH_STATUS] > 0) {
				//[Bad Present]
				outputText("shock at the box's contents – a nine inch cock with damn near a dozen buzzing, elliptical devices taped to it.  A pair of coal lumps rattles around underneath it, positioned as if they were the dick's testicles.\n\n", false);
				
				outputText("Before you can utter a single word of confusion or protest, the elf moans and the cock erupts, spurting a rope of cum into your hair.  The next blast takes you across the nose, then on your lips, then your chin, and finally onto your " + player.allBreastsDescript() + ".  Shocked and dripping, you stand dumbfounded as the elf plants a kiss on your lips, tears off the box, and runs away with her cock flopping and buzzing in time with each step.  There's no way to catch her in this darkness.\n\n", false);
				
				outputText("The empty 'present' is on the ground with the coal still inside.  You wonder if the coal has any special effect. Everything else in this place does.  In the distance you can hear sleigh bells, and you know it's going to be hard to sleep with all that racket on top of the threat of more intruders...\n\n", false);
				inventory.takeItem(consumables.COAL___, playerMenu);
				flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] = date.fullYear;
			}
			else if (player.cor <= 33) {
				//Great present!
				outputText("surprise at the box's contents - there's a careful arranged set of equipment here, made from woven spider-silk!  Somebody must think you're pretty good.\n\n");
				if (rand(2) == 0) inventory.takeItem(armors.SS_ROBE, playerMenu);
				else inventory.takeItem(armors.SSARMOR, playerMenu);
				flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] = date.fullYear;
			}
			else if (player.cor < 60) {
				//[Good present]
				outputText("surprise at the box's contents – there's a vial labeled gro+.  It looks like it's going to be a 'big' Christmas this year...\n\n", false);
				inventory.takeItem(consumables.GROPLUS, playerMenu);
				flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] = date.fullYear;
			}
			else {
				//[Mediocre Present]
				outputText("surprise at the box's contents – there is a single vial of succubi's delight packed inside.  It's going to be a white Christmas after all...\n\n", false);
				inventory.takeItem(consumables.SDELITE, playerMenu);
				flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] = date.fullYear;
			}
		}

		//[Unwrap the elf]
		public function unwrapElfyPresent():void {
			spriteSelect(9);
			clearOutput();
			outputText("The elf tosses the present to the side and saunters up to you, her hips swaying sensually.  She ", false);
			if (player.tallness > 60) outputText("reaches up and presses herself against you seductively, caressing your body.", false);
			else outputText("cuddles up alongside, happy to have someone of similar stature to seduce.", false);
			outputText("  You find yourself getting more and more aroused as she teases you, sliding around your body as she feels every nook and cranny of your form.  She teases, \"<i>If you don't unwrap a present soon enough I hear it gets taken away, and we don't want that.</i>\"\n\n", false);
			
			outputText("You ", false);
			if (player.spe < 25) outputText("clumsily ", false);
			else outputText("easily ", false);
			outputText("reach around and grab hold of her fur-lined tube-top, yanking it up over her head in a smooth motion.  Her now exposed breasts are small but well formed.  Her skin is very pale, practically white, and it provides a stark contrast for her hard, cherry-red nipples.   She wiggles happily when you grab her short red skirt and undo the clasp, yanking it off to fully expose her.  The elf's sex is rosy pink in color, and her outer lips are puffy with arousal.   Her slit is completely hairless, and an intricate tattoo of a snowflake sits just above it.  You glance up at her hat and down at her stocking-clad legs and think, 'those can stay.'\n\n", false);
			
			if (player.gender == 1) dickXmasElfGo();
			else if (player.gender == 2) vagFuckXmasElf();
			else {
				outputText("Which part will you ravish her with?\n\n");
				menu();
				addButton(0,"Male",futaDickXmasElfClr);
				addButton(1,"Female",futaVagXmasElfClr);
			}
		}
		public function futaDickXmasElfClr():void {
			clearOutput();
			dickXmasElfGo();
		}
		public function futaVagXmasElfClr():void {
			clearOutput();
			vagFuckXmasElf();
		}


		public function dickXmasElfGo():void {
			//(Dickfuck)
			if (player.cockArea(0) < 80) {
				outputText("She pushes you down onto your bedroll and whispers, \"<i>Time to enjoy your present.</i>\"\n\n", false);
			
				outputText("She mounts you without pretense, straddling and inserting your " + player.cockDescript(0) + " in one smooth motion.  The sudden change from cool, night air to hot, tight pussy sends shockwaves of pleasure into your skull.  You master yourself before your eyes roll the whole way back and close your mouth before you start drooling.   Her vise-like tightness is inhuman, but somehow not so tight as to be uncomfortable.   The internal muscles clench and squeeze around you with an uncommon degree of control.  She's so hot, wet, and tight that you shiver.  You start rocking underneath her, giving in completely to the pleasure of her hole.\n\n", false);
				
				outputText("You grunt, pistoning into her over and over.  She clears her throat as she's bouncing atop of you, and you look back up, suddenly reminded that there's more to the world than the cunt milking your " + player.cockDescript(0) + ".  The elf explains, \"<i>Don't be ashamed.  We elves have magical cunts.  Once something is inside it'll feel so good that it never wants to leave.  Judging from the look on your face I don't think you ever want to leave, do you?  I'm the best present you've ever had, aren't I?  Go ahead, cum for me, show me what a great gift I am.</i>\"\n\n", false);
				
				outputText("She's absolutely right – there's some indescribably pleasurable thing about the heat radiating into your dick that makes it feel like it's about to melt and pass into heaven.  The elf giggles and the vibrations of her laugh somehow radiate into you, and it's just too much.  You cum for your present, submitting to her pleasure as your spooge boils up into her.   It squelches wetly as it pumps into her, sounding absolutely perverse.", false);
				if (player.cumQ() >= 250) outputText("  The spunk quickly fills her womb and flows back out her entrance, frothing and bubbling as it drips over your " + player.hipDescript() + ".  ", false);
				if (player.cumQ() >= 1000) outputText("  It begins to splatter everywhere as you pour out more and more, the elf looking on with amusement as her cunt turns into a cum-spraying fountain.  ", false);
				outputText("\n\n", false);
				
				outputText("Once your orgasm ends the elf begins gyrating her hips again, her pussy frothing and dripping a mixed batch of creamy cum.   You don't go soft.  If anything you get even harder and more sensitive.  Brain blasting pressure squeezes up your rod from the elf's cunt as she starts bouncing again, fucking you in earnest, \"<i>I told you my cunt was magical.  You'll never go soft inside me – your cum fuels my magic and makes you feel even better.</i>\"\n\n", false);
				
				outputText("Aside from your " + player.cockDescript(0) + ", your body has gone completely numb from the waist down.  You glance down and see your " + player.legs() + " twitching and convulsing under the elf's assault.   She's so hot inside, it's like her pussy's candy-coated in liquid pleasure.   You fuck her harder and harder, squeezing her hips tightly and roughly fucking her magical pussy.   Somehow you're on the edge again, about to unload.  You start counting in your head, trying to resist another orgasm.  You know if you do you'll never be able stop.  You doubt you'll even be able to think.\n\n", false);
			
				outputText("Your effort at holding out totally fails – you start counting in time with each thrust, tying the numbers into the feel of the velvet cock-sleeve as it massages your " + player.cockDescript(0) + ".   The elf smiles condescendingly and taunts, \"<i>I can see you've already lost the ability to resist the pleasure.  Just give in, and enjoy the night.  I'll be riding you 'til morning.</i>\"\n\n", false);
			
				outputText("It's too hot, oh gods it's too hot.  You cum again, splattering her womb with more seed.  The elf's skin flushes as you pump more into her, squirting more and more into her overfull entrance.  Miraculously, you cum just as much as before, ", false);
				if (player.cumQ() >= 250) outputText("dumping out more and more waves of jizm until you're lying in a deep puddle of it, ", false);
				outputText("and somehow the orgasm lasts on even after you've emptied.   Your eyes roll back for a moment as you nearly lose consciousness.\n\n", false);
				
				outputText("You snap out of it and the elf is smirking down at you, stationary.  You feel totally numb – your " + player.cockDescript(0) + " has all of your sensation, all of your sense of touch.   On their own, your " + player.hipDescript() + " continually rise and fall, pumping into her with noisy explosions of pleasure that leave you gasping and writhing.  Every time you start to think something, the vise-like tunnel slides down you and squeezes your " + player.cockDescript(0) + ", interrupting any attempt at thought.  You give up on thinking and start drooling all over yourself, your world fading into a heaven of constant pleasure and repeated orgasms.\n\n", false);
				
				outputText("The elf fucks you relentlessly for hours, forcing you to cum over and over.  Somehow you never go dry, and each time feels better than the last.  Your bedroll is soaked with cum, your body is exhausted, and the elf FINALLY cums with a high-pitched cry of orgasmic pleasure.  Her body quakes, and you cum again, squirting messily inside her again.  The vise of pleasure on you quivers and squeezes, growing hotter by the second as the elf's orgasm drags on and on, milking you of every drop and setting you in a feedback loop of infinite pleasure.  You black out.", false);
			}
			else {
				//(TOO BIG)
				outputText("She pushes you down onto your bedroll and whispers, \"<i>Time to enjoy your present.</i>\"\n\n", false);
				outputText("The elf grabs ahold of your " + player.cockDescript(0) + " with both hands and cuddles against it as if it were a person, planting kisses along the edge of its " + player.cockHead() + ".  She laughs, \"<i>Oh my, you're so big!  I almost wish I was big enough to take this bad boy.  Believe me, you haven't lived until you've been milked by an elf's cunt.</i>\"\n\n", false);
				
				outputText("She wraps her arms around it and begins licking it, squatting down and standing up, jerking you off with her whole body.  Each time her cute bottom bumps your " + player.allBreastsDescript() + " ", false);
				if (player.biggestTitSize() >= 2) outputText("making them jiggle", false);
				else outputText("making her tight butt give a tiny jiggle", false);
				outputText(".  She hums happily as she works at the task, slathering it in spit, pressing her moist cunt against you.   Her warm body sliding along you feels fantastic, and feeling a bit daring, you give her a light slap on the ass-cheek.\n\n", false);
				
				outputText("The elf looks over her shoulder and laughs, \"<i>Someone is feeling a bit naughty.  Well, I guess I'll have to help you drain out all that naughty energy.</i>\"\n\n", false);
				
				outputText("Before you can puzzle out her meaning, she takes a big gulp of air, grabs your " + player.cockHead() + " with both hands, and presses her lips into your urethra.  She blows into it with a look of intense concentration.  You can feel your urethra filling, expanding with something, but it feels more like liquid than air, tingling as it slides deep into your shaft towards your ", false);
				if (player.balls > 0) outputText("balls", false);
				else if (player.hasSheath()) outputText("sheath", false);
				else outputText("body", false);
				outputText(".   She blows and blows, seemingly filling you with an inexhaustible supply of whatever magical substance she's forcing inside you. The tingling grows stronger and stronger, and then changes to warmth as a pleasurable heat centers itself in your midsection.\n\n", false);
				
				outputText("The magic-using elf pulls back with a knowing grin and resumes stroking you, ignoring a dribble of pink fluid that squirts from your tip.   The warmth inside builds higher and you start sweating, even in the cool night air. The uncomfortable heat churns inside you", false);
				if (player.balls > 0) outputText("r " + player.ballsDescriptLight(), false);
				outputText(", a gentle pressure that builds higher and higher until you feel about to explode.  You need to cum, and you squirm in the elf's grasp, trembling and shuddering as one of her hands slips over a particularly sensitive spot. A bead of pre-cum rolls out of your " + player.cockHead() + " and starts sliding down the shaft, followed by another, and another, and another.\n\n", false);
				
				outputText("Your 'present' asks with gradually rising authority, \"<i>Do you feel the naughtyness leaking out?  It feels good doesn't it?  Yes it does, but that's just the start.  You've got a lot of pent up naughty that needs to come out so you'll be good and see me next year.  So be a good boy and cum out all those bad thoughts for me please.</i>\"\n\n", false);
				
				outputText("She flips around to the far side of your dick and hugs it tightly, squeezing it from base to tip in a fluid motion makes your abdominals clench with unexpected orgasm.   The first 'squirt' of cum is more like a geyser going off.  ", false);
				if (player.cumQ() < 500) outputText("You recoil from shooting out so much – it's far and away more than you're normally capable of.  ", false);
				outputText("The elf hugs it and squeezes tightly while whispering, \"<i>Naughty naughty.</i>\"\n\n", false);

				outputText("Thick ropes of your orgasmic goop splatter into her hair, and each successive blast comes out with less and less force, until you're leaking a steady stream of cum that rolls down your " + player.cockDescript(0) + " and soaks the pointy-eared woman completely.   As you release your prodigious load the scent of cinnamon fills the air, and you dumbly wonder if it's some side effect of the magic she used on you.  Regardless, cum keeps leaking out over the elf and onto you, and you eventually lose consciousness from perpetual orgasm.", false);
			}
			//(Go to followup for fucking scene)
			//[Next]
			doNext(xmasFuckFollowup);
			player.orgasm();
		}

		//[FEMALE SCENE]	
		public function vagFuckXmasElf():void {
			outputText("She pushes you down onto your bedroll and whispers, \"<i>Time to enjoy your present.</i>\"\n\n", false);
			outputText("The elf winks and spreads her legs, revealing her obviously aroused sex to you.  She winks and you see her muscles clench.  The moist lips of her vagina slowly spread apart, and a blunt white object begins to squeeze out.  Is she laying an egg?  Wait- no, more of the object slides out and you can see now that it's tubular in shape, like some sort of sex-toy, and it's covered in a spiraling red pattern.  The object continues its slow journey downwards, roughly six inches hanging free as the elf grunts and moans, her face flushed.   She grips it with both hands and pulls it slowly.  It reminds you the soldiers in training back home the first time they tried to draw a sword – a mix of awkwardness and excitement.\n\n", false);
			
			outputText("In seconds the elf has her hands around a red-striped double-sided dildo.  It wiggles back and forth obscenely, and now that you have a good look at it, you realize the red sections are slightly raised, to better stimulate the user.  She pants and runs her hand over its pussy-slicked surface, shivering in remembered pleasure until her attention returns to you.  Her lips curl into a knowing smile and she kneels between your " + player.legs() + ", spreading them apart for better access to your " + player.vaginaDescript(0) + ".\n\n", false);
			
			outputText("The diminutive elf rubs the tip over your lower lips and " + player.clitDescript() + " a few times, getting you nice and hot before she slides it up your " + player.vaginaDescript(0) + ".  The dildo feels wonderful inside, each curved ridge sending shivers up your spine as it enters you, then stroking along your walls as you take it deeper and deeper.  The motion is interrupted once your 'present' has decided she's lodged her candy-cane-like toy deep enough inside you.  She lies back and scoots forwards, taking the rest of the striped dildo into her hairless snatch until your mounds are locked together, feminine fluids mixing on an artificial cock.");
			player.cuntChange(15,true,true,false);
			outputText("\n\n", false);
			
			outputText("The elf giggles, \"<i>Merry Christmas,</i>\" as she starts rocking against you.  The dildo slides through your passage, massaging your inner walls and bumping against your " + player.clitDescript() + "'s underside with each stroke.   She's got such great muscle control that she's clamped down on the double-sided dildo and started using it as a cock to fuck you!  She smirks and pounds your vulnerable " + player.vaginaDescript(0) + ", raping it with increasingly forceful strokes.  You grunt and moan as each stroke loudly smacks into your hips.  You feel yourself closing in on an orgasm, but the elf-girl relaxes her grip and simply grinds against you, taking the stimulation down a notch.\n\n", false);
			
			outputText("Determined to get off, you wiggle against her, mashing your " + player.clitDescript() + " into her own.  She squirms and cries out, actually getting off before you!  You muse that elves must have extraordinarily sensitive clitorises, but before you can act on it, you feel a sudden stirring in your loins.   The dildo is starting to spin!  You prop yourself up and watch, unbelieving as the elf's orgasmic contractions visibly contort her belly, moving more and more quickly as the spinning speeds up.  In seconds the twirling assault has placed you back on the edge of orgasm, and you're groaning and rubbing against your insensate lover for more.\n\n", false);

			outputText("You cum, ", false);
			if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) outputText("gushing fluids", false);
			else if (player.vaginas[0].vaginalWetness >= VAGINA_WETNESS_SLICK) outputText("dripping fluids", false);
			else outputText("squishing wetly", false);
			outputText(" as your " + player.vaginaDescript(0) + " is drilled by the elf's double-ended dong.   It feels beyond good, like having a cock inside you that rubs against each part of your pussy over and over and over without the barest hint of mercy.  Your gasp and pant, glancing back up at the elf.  She's already recovered from her orgasm, though she has an intense look of concentration on her face while she focuses on twisting the dildo inside you.\n\n", false);

			outputText("\"<i>You don't think I'd let you cum just once did you?  I'm going to drill all the naughty, sinful little thoughts from your slut-hole!</i>\"\n\n", false);

			outputText("You throw your head back and let out a low shuddering moan as she spins the dildo even faster, forcing your convulsing cunt to stay locked in a mind-shattering orgasm.  Eyes crossed, you collapse onto your back and twitch, body wriggling and flopping about nervelessly as it caves in to pleasure it was never meant to handle.\n\n", false);

			outputText("You black out to the following words: \"<i>Good girl.  Keep cumming, let out all those naughty thoughts.  I can't wait to see you next year!</i>\"", false);
			doNext(xmasFuckFollowupFems);
			player.orgasm();
		}
			
		//MANTASTIC FOLLOWUP:
		public function xmasFuckFollowup():void {
			hideUpDown();
			clearOutput();
			outputText("You awaken in the morning, sore and exhausted, but more satisfied than you've ever felt before.  Your body feels INCREDIBLY sensitive from head to toe, but particularly on your well-used " + player.cockDescript(0) + ".  In spite of the traumatic lovemaking, you feel remarkably clear-headed.\n\n", false);
			outputText("Did you enjoy being able to cum so much");
			if (player.findPerk(PerkLib.ElvenBounty) >= 0) outputText(" <b>again</b>");
			outputText("?", false);
			//[Yes][No] – yes awards (+250 mls cum volume), no awards +15 intellect
			doYesNo(xmasPerkM,xmasSmart);
			//(-5 corruption)
			dynStats("cor", -5);
			//(+20 sens unless it would bring you over 80 sens, then +5 sens)
			if (player.sens + 20 > 80) dynStats("sen", 5);
			else dynStats("sen", 15);
			temp = 1001;
			flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] = date.fullYear;
		}
		//FEMTASTIC FOLLOWUP:
		public function xmasFuckFollowupFems():void {
			hideUpDown();
			clearOutput();
			outputText("You awaken in the morning, sore and exhausted, but more satisfied than you've ever felt before.  Your body feels INCREDIBLY sensitive from head to toe, but particularly in your well-used " + player.vaginaDescript(0) + ".  In spite of the traumatic lovemaking, you feel remarkably clear-headed.  The dildo appears to have completely dissolved inside you, leaving behind a pinkish fluid that drips from your lips.\n\n", false);
			
			outputText("Do you think it might have done anything to you");
			if (player.findPerk(PerkLib.ElvenBounty) >= 0) outputText(" <b>again</b>");
			outputText("?", false);
			//[Yes][No] – yes awards (+15 fertility!), no awards +15 intellect
			doYesNo(xmasPerkM,xmasSmart);
			//(-5 corruption)
			dynStats("cor", -5);
			//(+20 sens unless it would bring you over 80 sens, then +5 sens)
			if (player.sens + 20 > 80) dynStats("sen", 5);
			else dynStats("sen", 15);
			temp = 2002;
			flags[kFLAGS.PC_ENCOUNTERED_CHRISTMAS_ELF_BEFORE] = date.fullYear;
		}

		public function xmasPerkM():void {
			if (player.findPerk(PerkLib.ElvenBounty) < 0) {
				if (temp == 1001) player.createPerk(PerkLib.ElvenBounty,250,0,0,0);
				else player.createPerk(PerkLib.ElvenBounty,0,15,0,0);
				outputText("<b>New Perk Acquired - Elven Bounty!</b>", true);
			}
			else {
				clearOutput();
				outputText("<b>Perk Enhanced - Elven Bounty!</b>");
				if (temp == 1001) {
					player.addPerkValue(PerkLib.ElvenBounty,1,250);
					outputText("<b> - +250mL cum production!</b>");
				}
				else {
					player.addPerkValue(PerkLib.ElvenBounty,2,15);
					outputText("<b> - +15 bonus fertility!</b>");
				}
				
			}
			doNext(playerMenu);
		}
		public function xmasSmart():void {
			hideUpDown();
			outputText("You nod to yourself, feeling pretty smart about your decision.", true);
			doNext(playerMenu);
			dynStats("int", 15);
		}
	}
}