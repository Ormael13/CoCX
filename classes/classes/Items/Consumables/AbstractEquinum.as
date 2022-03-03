/**
 * Coded by aimozg on 01.06.2017.
 */
package classes.Items.Consumables {
import classes.Appearance;
import classes.BaseContent;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.CoC_Settings;
import classes.CockTypesEnum;
import classes.EngineCore;
import classes.EventParser;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumable;
import classes.PerkLib;
import classes.StatusEffects;
import classes.VaginaClass;
import classes.CoC;

public class AbstractEquinum extends Consumable {
	public function AbstractEquinum(type:Number, id:String, shortName:String, longName:String, value:Number, description:String) {
		super(id, shortName, longName, value, description);
		this.type = type;
	}

	protected var type:Number;

	override public function useItem():Boolean {
		player.slimeFeed();
		//0 - normalne Equinum
		//1 - Unicornum
		//2 - Alicornum
		//Changes done
		var changes:Number     = 0;
		//Change limit
		var changeLimit:Number = 1;
		//Temporary storage
		var temp:Number        = 0;
		var temp2:Number       = 0;
		var temp3:Number       = 0;
		//Store location of cock to be changed
		var old:Number         = 0;
		//Chancee to raise limit
		if (rand(2) == 0) changeLimit++;
		if (rand(3) == 0) changeLimit++;
		changeLimit += player.additionalTransformationChances;
		//Used for random chances
		//Set up output
		clearOutput();
		outputText("You down the potion, grimacing at the strong taste.");
		//CHANCE OF BAD END - 20% if face/tail/skin/cock are appropriate.
		//If hooved bad end doesn't appear till centaured
		if (type == 0 && player.hasFur() && player.faceType == Face.HORSE && player.tailType == Tail.HORSE && (player.lowerBody != LowerBody.HOOFED)) {
			//WARNINGS
			//Repeat warnings
			if (player.hasStatusEffect(StatusEffects.HorseWarning) && rand(3) == 0) {
				if (player.statusEffectv1(StatusEffects.HorseWarning) == 0) outputText("<b>\n\nYou feel a creeping chill down your back as your entire body shivers, as if rejecting something foreign.  Maybe you ought to cut back on the horse potions.</b>");
				if (player.statusEffectv1(StatusEffects.HorseWarning) > 0) outputText("<b>\n\nYou wonder how many more of these you can drink before you become a horse...</b>");
				player.addStatusValue(StatusEffects.HorseWarning, 1, 1);
			}
			//First warning
			if (!player.hasStatusEffect(StatusEffects.HorseWarning)) {
				outputText("<b>\n\nWhile you drink the tasty potion, you realize how horse-like you already are, and wonder what else the potion could possibly change...</b>");
				player.createStatusEffect(StatusEffects.HorseWarning, 0, 0, 0, 0);
			}
			//Bad End
			if (rand(4) == 0 && player.hasStatusEffect(StatusEffects.HorseWarning) && !player.hasPerk(PerkLib.TransformationResistance)) {
				//Must have been warned first...
				if (player.statusEffectv1(StatusEffects.HorseWarning) > 0) {
					//If player has dicks check for horsedicks
					if (player.cockTotal() > 0) {
						//If player has horsedicks
						if (player.horseCocks() > 0) {
							outputText("\n\nSoon after you drink the Equinum, a burning sensation fills your chest. You have consumed too much of the potion, and the overdose starts to provoke dramatic changes in your body.  You collapse suddenly, twitching in pain as all the bones and muscles in your body break and reform. Eventually, you pass out from the strain you are put through.\n\nYou wake up after a few minutes. Once you get up on your legs, doubt fills your mind. You rush to a nearby pond and look down, nearly jumping when the reflection of a ");
							if (player.gender == 0 || player.gender == 3) outputText("horse ");
							if (player.gender == 1) outputText("stallion ");
							if (player.gender == 2) outputText("mare ");
							outputText(" with beautiful [haircolor] [skin.type] covering its body gazes back up at you.  That's you, and yet the doubt in your mind remains. Strange images fill your mind, and you feel as if you have not always been a horse, but some kind of funny fur-less creature standing on two legs. Your equine mind rapidly dismisses that doubt as a daydream however, and you trot away, oblivious to who you once were.\n\n");
							outputText("<b>One year later...</b>\n\nAs you graze upon the small plants that coat the open plains of your home, you hear a noise on your right side. As you raise your head to check where the noise comes from, preparing to run from a potential predator, you see a strange creature. It stands on its two feet, its furless pink skin appearing beneath its clothes.  With a start, you realize you can identify the strange creatures gender.  ");
							if (player.gender == 0 || player.gender == 1) outputText("He is clearly a male, but you are somewhat confused as you can see not one but three bulges where his manhood would be.\n\n");
							if (player.gender == 2) outputText("She is clearly a female, as you can see her six breasts jiggle as she walks towards you, small stains appearing on her shirt where her nipples are.\n\n");
							if (player.gender == 3) outputText("You are somewhat confused as you can see a bulge near her thighs but also huge boobs jiggling as she walks, and you can't say if she's a male or female.\n\n");
							outputText("As soon as you lay eyes on the creature, a wave of nostalgia overtakes you. Somehow, looking at that creature makes you sad, as if you forgot something important.\n\n\"<i>How strange to see a horse here all alone,</i>\" the creature muses, \"<i>In any case, you're still the least bizarre creature I've met here.  Not to mention the only one that hasn't tried to rape me,</i>\" it says with a sigh.\n\nYou answer with an interrogative whinny.\n\n\"<i>Hey, I've got an idea. I'll take you back to the camp. I'll feed you and in return you can help me complete my quest. What do you say?</i>\"\n\nInstinctively, you utter a happy and approving whinny.\n\nYou failed in your quest, losing your focus and more importantly, losing yourself.  But, even so, you found a new meaning to your life, and have a new chance to succeed where you once failed.");
							EventParser.gameOver();
							return false;
						}
					}
					//If player has no cocks
					else {
						outputText("\n\nSoon after you drink the Equinum, a burning sensation fills your chest. You have consumed too much of the drink, and the overdose starts to provoke dramatic changes in your body.  You collapse suddenly, twitching in pain as all the bones and all the muscles in your body break and reform. Eventually, you pass out from the strain you are put through.\n\nYou wake up after a few minutes. Once you get up on your legs, doubt fills your mind. You rush to a nearby pond and look down, nearly jumping when the reflection of a ");
						if (player.gender == 0 || player.gender == 3) outputText("horse ");
						if (player.gender == 1) outputText("stallion ");
						if (player.gender == 2) outputText("mare ");
						outputText("with beautiful [haircolor] [skin.type] covering its body looks back at you.  That's you, and yet the doubt in your mind remains. Strange mental images fill your mind.  You feel as if you have not always been a horse, but some kind of funny fur-less creature standing on two legs. But your equine mind rapidly dismisses that doubt as a daydream, and you trot away, oblivious to who you once were.\n\n");
						outputText("<b>One year after...</b>\n\nAs you graze small plants in the open plains that became your home, you hear a noise on your right side. As you raise your head to check where the noise comes from, preparing to run from a potential predator, you see a strange creature. It stands on two feet, its furless pink skin appearing beneath its clothes.  ");
						if (player.gender == 0 || player.gender == 1) outputText("He is clearly a male, but you are somewhat confused as you can see not one but three bulges where his manhood would be.\n\n");
						if (player.gender == 2) outputText("She is clearly a female, as you can see her six breasts jiggle as she walks towards you, small stains appearing on her shirt where her nipples are.\n\n");
						if (player.gender == 3) outputText("You are somewhat confused as you can see a bulge near her thighs but also huge boobs jiggling as she walks, and you can't say if she's a male or female.\n\n");
						outputText("As soon as you lay eyes on the creature, a wave of nostalgia overtakes you. Somehow, looking at that creature makes you sad, as if you forgot something important.\n\n\"<i>How strange to see a horse here all alone,</i>\" the creature muses, \"<i>In any case, you're still the least bizarre creature I've met here.  Not to mention the only one that hasn't tried to rape me,</i>\" it says with a sigh.\n\nYou answer with an interrogative whinny.\n\n\"<i>Hey, I've got an idea. I'll take you back to the camp. I'll feed you and in return you can help me to complete my quest. What do you say?</i>\"\n\nInstictively, you utter a happy and approving whinny.\n\nYou failed in your quest, losing you focus and more importantly, losing yourself.  But, even so, you found a new meaning to your life, and have a new chance to achieve what you once failed.");
						EventParser.gameOver();
						return false;
					}
				}
			}

		}
		//Stat changes first
		//STRENGTH
		if (rand(2) == 0 && player.MutagenBonus("str", 1)) {
			//Maxxed
			if (type == 0 && player.str >= 70) {
				outputText("\n\nYou feel strong enough to single-handedly pull a fully-loaded wagon.");
			}
			if ((type == 1 || type == 2) && player.str >= 60) {
				outputText("\n\nYou feel strong enough to single-handedly pull a fully-loaded wagon.");
			}
			//NOT MAXXED
			else {
				outputText("\n\nYour muscles clench and surge, making you feel as strong as a horse.");
				changes++;
			}
		}
		//TOUGHNESS
		if (rand(2) == 0) {
			//MAXXED ALREADY
			if (type == 0 && player.tou >= 85) {
				outputText("\n\nYour body is as tough and solid as a ");
				if (player.gender == 1 || player.gender == 3) outputText("stallion's.");
				else outputText("mare's.");
			}
			if ((type == 1 || type == 2) && player.tou >= 75) {
				outputText("\n\nYour body is as tough and solid as an ");
				if (type == 1) outputText("unicorn ");
				else outputText("alicorn ");
				if (player.gender == 1 || player.gender == 3) outputText("stallion's.");
				else outputText("mare's.");
			}
			//NOT MAXXED
			else {
				player.MutagenBonus("tou", 1);
				outputText("\n\nYour body suddenly feels tougher and more resilient.");
				changes++;
			}
		}
		//INTELLECT
		if (type == 0 && rand(3) == 0) {
			if (player.inte <= 5) {
				outputText("\n\nYou let out a throaty \"Neiiiigh\" as your animalistic instincts take over.");
			}
			if (player.inte < 10 && player.inte > 5) {
				player.addCurse("int", 1, 1);
				outputText("\n\nYou smile vacantly as you drink the potion, knowing you're just a big dumb animal who loves to fuck.");
				changes++;
			}
			if (player.inte <= 20 && player.inte >= 10) {
				player.addCurse("int", 2, 1);
				outputText("\n\nYou find yourself looking down at the empty bottle in your hand and realize you haven't thought ANYTHING since your first sip.");
				changes++;
			}
			if (player.inte <= 30 && player.inte > 20) {
				player.addCurse("int", 3, 1);
				outputText("\n\nYou smile broadly as your cares seem to melt away.  A small part of you worries that you're getting dumber.");
				changes++;
			}
			if (player.inte <= 50 && player.inte > 30) {
				player.addCurse("int", 4, 1);
				outputText("\n\nIt becomes harder to keep your mind focused as your intellect diminishes.");
				changes++;
			}
			if (player.inte > 50) {
				player.addCurse("int", 5, 1);
				outputText("\n\nYour usually intelligent mind feels much more sluggish.");
				changes++;
			}
		}
		if ((type == 1 || type == 2) && rand(3) == 0 && player.MutagenBonus("int", 1)) {
			outputText("\n\nAs you finish drinking the potion you suddently feel more cunning and by far way smarter.");
			changes++;
		}
		if (player.blockingBodyTransformations()) changeLimit = 0;
		//-Remove feather-arms (copy this for goblin ale, mino blood, equinum, centaurinum, canine pepps, demon items)
		if (changes < changeLimit && !InCollection(player.arms.type, Arms.HUMAN, Arms.GARGOYLE) && rand(4) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.ArmsHuman.applyEffect();
			changes++;
		}
		//-Remove feathery/quill hair (copy for equinum, canine peppers, Labova)
		if (changes < changeLimit && (player.hairType == Hair.FEATHER || player.hairType == Hair.QUILL) && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.HairHuman.applyEffect();
			changes++;
		}
		//-Remove leaf hair (copy for equinum, canine peppers, Labova)
		if (changes < changeLimit && player.hairType == 7 && rand(4) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.HairHuman.applyEffect();
			changes++;
		}
		//
		//SEXUAL CHARACTERISTICS
		//
		//MALENESS.
		if ((player.gender == 1 || player.gender == 3) && rand(1.5) == 0 && changes < changeLimit) {
			//If cocks that aren't horsified!
			if ((player.horseCocks() + player.demonCocks()) < player.cocks.length) {
				//Transform a cock and store it's index value to talk about it.
				//Single cock
				if (player.cocks.length == 1) {
					temp  = 0;
					//Use temp3 to track whether or not anything is changed.
					temp3 = 0;
					if (player.cocks[0].cockType == CockTypesEnum.HUMAN) {
						outputText("\n\nYour " + player.cockDescript(0) + " begins to feel strange... you pull down your pants to take a look and see it darkening as you feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.  A hot feeling envelops your member as it suddenly grows into a horse penis, dwarfing its old size.  The skin is mottled brown and black and feels more sensitive than normal.  Your hands are irresistibly drawn to it, and you jerk yourself off, splattering cum with intense force.");
						temp  = player.addHorseCock();
						temp2 = player.increaseCock(temp, rand(4) + 4);
						temp3 = 1;
						dynStats("lus", 35);
						player.addCurse("sen", 4, 1);
						player.MutagenBonus("lib", 5);
					}
					if (player.cocks[0].cockType == CockTypesEnum.DOG) {
						temp = player.addHorseCock();
						outputText("\n\nYour " + Appearance.cockNoun(CockTypesEnum.DOG) + " begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your " + Appearance.cockNoun(CockTypesEnum.DOG) + " as it flattens, flaring outwards.  Your cock pushes out of your sheath, inch after inch of animal-flesh growing beyond it's traditional size.  You notice your knot vanishing, the extra flesh pushing more horsecock out from your sheath.  Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", and you jerk yourself off, splattering thick ropes of cum with intense force.");
						temp2 = player.increaseCock(temp, rand(4) + 4);
						temp3 = 1;
						dynStats("lus", 35);
						player.addCurse("sen", 4, 1);
						player.MutagenBonus("lib", 5);
					}
					if (player.cocks[0].cockType == CockTypesEnum.TENTACLE) {
						temp = player.addHorseCock();
						outputText("\n\nYour " + player.cockDescript(0) + " begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your " + player.cockDescript(0) + " as it flattens, flaring outwards.  Your skin folds and bunches around the base, forming an animalistic sheath.  The slick inhuman texture you recently had fades, taking on a more leathery texture.  Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", and you jerk yourself off, splattering thick ropes of cum with intense force.");
						temp2 = player.increaseCock(temp, rand(4) + 4);
						temp3 = 1;
						dynStats("lus", 35);
						player.addCurse("sen", 4, 1);
						player.MutagenBonus("lib", 5);
					}
					if (player.cocks[0].cockType.Index > 4) {
						outputText("\n\nYour " + player.cockDescript(0) + " begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your " + player.cockDescript(0) + " as it flattens, flaring outwards.  Your skin folds and bunches around the base, forming an animalistic sheath.  The slick inhuman texture you recently had fades, taking on a more leathery texture.  Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", and you jerk yourself off, splattering thick ropes of cum with intense force.");
						temp  = player.addHorseCock();
						temp2 = player.increaseCock(temp, rand(4) + 4);
						temp3 = 1;
						dynStats("lus", 35);
						player.addCurse("sen", 4, 1);
						player.MutagenBonus("lib", 5);
					}
					if (temp3 == 1) outputText("  <b>Your penis has transformed into a horse's!</b>");
				}
				//MULTICOCK
				else {
					dynStats("lus", 35);
					player.addCurse("sen", 4, 1);
					player.MutagenBonus("lib", 5);
					temp = player.addHorseCock();
					outputText("\n\nOne of your penises begins to feel strange.  You pull down your clothes to take a look and see the skin of your " + player.cockDescript(temp) + " darkening to a mottled brown and black pattern.");
					if (temp == -1) {
						CoC_Settings.error("");
						clearOutput();
						outputText("FUKKKK ERROR NO COCK XFORMED");
					}
					//Already have a sheath
					if (player.horseCocks() > 1 || player.dogCocks() > 0) outputText("  Your sheath tingles and begins growing larger as the cock's base shifts to lie inside it.");
					else outputText("  You feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your " + player.cockDescript(temp) + "'s root, tightening and pulling your " + player.cockDescript(temp) + " inside its depths.");
					temp2 = player.increaseCock(temp, rand(4) + 4);
					outputText("  The shaft suddenly explodes with movement, growing longer and developing a thick flared head leaking steady stream of animal-cum.");
					outputText("  <b>You now have a horse-cock.</b>");
				}
				//Make cock thicker if not thick already!
				if (player.cocks[temp].cockThickness <= 2) player.cocks[temp].thickenCock(1);
				changes++;
			}
			//Players cocks are all horse-type - increase size!
			else {
				//single cock
				if (player.cocks.length == 1) {
					temp2 = player.increaseCock(0, rand(3) + 1);
					temp  = 0;
					dynStats("lus", 10);
					player.addCurse("sen", 1, 1);
				}
				//Multicock
				else {
					//Find smallest cock
					//Temp2 = smallness size
					//temp = current smallest
					temp3 = player.cocks.length;
					temp  = 0;
					while (temp3 > 0) {
						temp3--;
						//If current cock is smaller than saved, switch values.
						if (player.cocks[temp].cockLength > player.cocks[temp3].cockLength) {
							temp2 = player.cocks[temp3].cockLength;
							temp  = temp3;
						}
					}
					//Grow smallest cock!
					//temp2 changes to growth amount
					temp2 = player.increaseCock(temp, rand(4) + 1);
					dynStats("lus", 10);
					player.addCurse("sen", 1, 1);
				}
				outputText("\n\n");
				if (temp2 > 2) outputText("Your " + player.cockDescript(temp) + " tightens painfully, inches of taut horse-flesh pouring out from your sheath as it grows longer.  Thick animal-pre forms at the flared tip, drawn out from the pleasure of the change.");
				if (temp2 > 1 && temp2 <= 2) outputText("Aching pressure builds within your sheath, suddenly releasing as an inch or more of extra dick flesh spills out.  A dollop of pre beads on the head of your enlarged " + player.cockDescript(temp) + " from the pleasure of the growth.");
				if (temp2 <= 1) outputText("A slight pressure builds and releases as your " + player.cockDescript(temp) + " pushes a bit further out of your sheath.");
				changes++;
			}
			//Chance of thickness + daydream
			if (rand(2) == 0 && changes < changeLimit && player.horseCocks() > 0) {
				temp3 = 0;
				temp2 = player.cocks.length;
				while (temp2 > 0) {
					temp2--;
					if (player.cocks[temp2].cockThickness <= player.cocks[temp3].cockThickness) {
						temp3 = temp2;
					}
				}
				temp = temp3;
				player.cocks[temp].thickenCock(.5);
				outputText("\n\nYour " + Appearance.cockNoun(CockTypesEnum.HORSE) + " thickens inside its sheath, growing larger and fatter as your veins thicken, becoming more noticeable.  It feels right");
				if (player.cor + player.lib < 60) outputText(" to have such a splendid tool.  You idly daydream about cunts and pussies, your " + Appearance.cockNoun(CockTypesEnum.HORSE) + " plowing them relentlessly, stuffing them pregnant with cum");
				if (player.cor + player.lib >= 60 && player.cor + player.lib < 100) outputText(" to be this way... You breath the powerful animalistic scent and fantasize about fucking centaurs night and day until their bellies slosh with your cum");
				if (player.cor + player.lib >= 100 && player.cor + player.lib <= 175) outputText(" to be a rutting stud.  You ache to find a mare or centaur to breed with.  Longing to spend your evenings plunging a " + Appearance.cockNoun(CockTypesEnum.HORSE) + " deep into their musky passages, dumping load after load of your thick animal-cum into them.  You'd be happy just fucking horsecunts morning, noon, and night.  Maybe somewhere there is a farm needing a breeder..");
				if (player.cor + player.lib > 175) outputText(" to whinny loudly like a rutting stallion.  Your " + Appearance.cockNoun(CockTypesEnum.HORSE) + " is perfect for fucking centaurs and mares.  You imagine the feel of plowing an equine pussy deeply, bottoming out and unloading sticky jets of horse-jizz into its fertile womb.  Your hand strokes your horsecock of its own accord, musky pre dripping from the flared tip with each stroke.  Your mind wanders to the thought of you with a harem of pregnant centaurs.");
				outputText(".");
				if (player.cor < 30) outputText("  You shudder in revulsion at the strange thoughts and vow to control yourself better.");
				if (player.cor >= 30 && player.cor < 60) outputText("  You wonder why you thought such odd things, but they have a certain appeal.");
				if (player.cor >= 60 && player.cor < 90) outputText("  You relish your twisted fantasies, hoping to dream of them again.");
				if (player.cor >= 90) outputText("  You flush hotly and give a twisted smile, resolving to find a fitting subject to rape and relive your fantasies.");
				dynStats("lus", 10);
				player.MutagenBonus("lib", 1);
			}
			//Chance of ball growth if not 3" yet
			if (rand(2) == 0 && changes < changeLimit && player.ballSize <= 3 && player.horseCocks() > 0) {
				if (player.balls == 0) {
					player.balls    = 2;
					player.ballSize = 1;
					outputText("\n\nA nauseating pressure forms just under the base of your maleness.  With agonizing pain the flesh bulges and distends, pushing out a rounded lump of flesh that you recognize as a testicle!  A moment later relief overwhelms you as the second drops into your newly formed sack.");
					dynStats("lus", 5);
					player.MutagenBonus("lib", 2);
				}
				else {
					player.ballSize++;
					if (player.ballSize <= 2) outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your " + Appearance.ballsDescription(false, true, player) + " have grown larger than a human's.");
					if (player.ballSize > 2) outputText("\n\nA sudden onset of heat envelops your groin, focusing on your " + Appearance.sackDescript(player) + ".  Walking becomes difficult as you discover your " + Appearance.ballsDescription(false, true, player) + " have enlarged again.");
					dynStats("lus", 3);
					player.MutagenBonus("lib", 1);
				}
				changes++;
			}
		}
		//Unicorn grows cocks
		if ((type == 1 || type == 2) && (!player.hasCock()) && player.isTaur() && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYou feel a sudden stabbing pain between your back legs");
			if (player.hasVagina()) outputText(" just below your [vagina]");
			outputText(" and bend over, moaning in agony. falling on your back so you can get a stare at your hindquarters you are presented with the shocking site of once-smooth flesh swelling and flowing like self-animate clay, resculpting itself into the form of male genitalia! When the pain dies down, you are the proud owner of ");
			if (player.hasVagina()) outputText(" not only a [vagina], but");
			outputText( " a new human-shaped penis!");
			player.createCock(7, 1.4);
			dynStats("lus", 20);
			player.addCurse("sen", 5, 1);
			player.MutagenBonus("lib", 4);
			changes++;
		}
		//Unicorn grows vag
		if ((type == 1 || type == 2) && (!player.hasVagina()) && player.isTaur() && changes < changeLimit && rand(3) == 0) {
			changes++;
			//(balls)
			if (player.balls > 0) outputText("\n\nAn itch starts behind your [balls], but before you can reach under to scratch it, the discomfort fades. A moment later a warm, wet feeling brushes your [sack], and curious about the sensation, <b>you lift up your balls to reveal your new vagina.</b>");
			//(dick)
			else if (player.hasCock()) outputText("\n\nAn itch starts on your groin, just below your [cocks]. You pull the manhood aside to give you a better view, and you're able to watch as <b>your skin splits to give you a new vagina, complete with a tiny clit.</b>");
			//(neither)
			else outputText("\n\nAn itch starts on your groin and fades before you can take action. Curious about the intermittent sensation, <b>you peek under your [armor] to discover your brand new vagina, complete with pussy lips and a tiny clit.</b>");
			player.createVagina();
			player.clitLength = .25;
			player.addCurse("sen", 10, 1);
		}
		//FEMALE
		if (player.gender == 2 || player.gender == 3) {
			//Single vag
			if (player.vaginas.length == 1) {
				if (player.vaginas[0].vaginalLooseness <= VaginaClass.LOOSENESS_GAPING && changes < changeLimit && rand(2) == 0) {
					outputText("\n\nYou grip your gut in pain as you feel your organs shift slightly.  When the pressure passes, you realize your " + Appearance.vaginaDescript(player,0) + " has grown larger, in depth AND size.");
					player.vaginas[0].vaginalLooseness++;
					changes++;
				}
				if (player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_NORMAL && changes < changeLimit && rand(2) == 0) {
					outputText("\n\nYour " + Appearance.vaginaDescript(player,0) + " moistens perceptably, giving off an animalistic scent.");
					player.vaginas[0].vaginalWetness++;
					changes++;
				}
			}
			//Multicooch
			else {
				//determine least wet
				//temp - least wet
				//temp2 - saved wetness
				//temp3 - counter
				temp  = 0;
				temp2 = player.vaginas[temp].vaginalWetness;
				temp3 = player.vaginas.length;
				while (temp3 > 0) {
					temp3--;
					if (temp2 > player.vaginas[temp3].vaginalWetness) {
						temp  = temp3;
						temp2 = player.vaginas[temp].vaginalWetness;
					}
				}
				if (player.vaginas[temp].vaginalWetness <= VaginaClass.WETNESS_NORMAL && changes < changeLimit && rand(2) == 0) {
					outputText("\n\nOne of your " + Appearance.vaginaDescript(player,temp) + " moistens perceptably, giving off an animalistic scent.");
					player.vaginas[temp].vaginalWetness++;
					changes++;
				}
				//determine smallest
				//temp - least big
				//temp2 - saved looseness
				//temp3 - counter
				temp  = 0;
				temp2 = player.vaginas[temp].vaginalLooseness;
				temp3 = player.vaginas.length;
				while (temp3 > 0) {
					temp3--;
					if (temp2 > player.vaginas[temp3].vaginalLooseness) {
						temp  = temp3;
						temp2 = player.vaginas[temp].vaginalLooseness;
					}
				}
				if (player.vaginas[0].vaginalLooseness <= VaginaClass.LOOSENESS_GAPING && changes < changeLimit && rand(2) == 0) {
					outputText("\n\nYou grip your gut in pain as you feel your organs shift slightly.  When the pressure passes, you realize one of your " + Appearance.vaginaDescript(player,temp) + " has grown larger, in depth AND size.");
					player.vaginas[temp].vaginalLooseness++;
					changes++;
				}
			}
			if (player.statusEffectv2(StatusEffects.Heat) < 30 && rand(2) == 0 && changes < changeLimit) {
				if (player.goIntoHeat(true)) {
					changes++;
				}
			}

			if (!flags[kFLAGS.HYPER_HAPPY]) {
				if (rand(2) == 0 && changes < changeLimit) {
					//Shrink B's!
					//Single row
					if (player.breastRows.length == 1) {
						//Shrink if bigger than B cups
						if (player.breastRows[0].breastRating > 3) {
							temp = 1;
							player.breastRows[0].breastRating--;
							//Shrink again if huuuuge
							if (player.breastRows[0].breastRating > 8) {
								temp++;
								player.breastRows[0].breastRating--;
							}
							//Talk about shrinkage
							if (temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your " + player.breastDescript(0) + " have shrunk to a " + player.breastCup(0) + ".");
							if (temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are MUCH smaller, down to " + player.breastCup(0) + "s.");
							changes++;
						}

					}
					//multiple
					else {
						//temp2 = amount changed
						//temp3 = counter
						temp2 = 0;
						temp3 = player.breastRows.length;
						if (player.biggestTitSize() > 3) outputText("\n");
						while (temp3 > 0) {
							temp3--;
							if (player.breastRows[temp3].breastRating > 3) {
								player.breastRows[temp3].breastRating--;
								temp2++;
								outputText("\n");
								if (temp3 < player.breastRows.length - 1) outputText("...and y");
								else outputText("Y");
								outputText("our " + player.breastDescript(temp3) + " shrink, dropping to " + player.breastCup(temp3) + "s.");
							}
						}
						if (temp2 == 2) outputText("\nYou feel so much lighter after the change.");
						if (temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.");
						if (temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
						if (temp2 > 0) changes++;
					}
				}
			}
		}
		//NON - GENDER SPECIFIC CHANGES
		//Legs -> Tail -> Ears -> Fur -> Face
		//Hoofed legs

		if (player.hasVagina() && player.vaginaType() != VaginaClass.EQUINE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYou grip your gut in pain as you feel your organs shift slightly.  When the pressure passes, you realize your " + Appearance.vaginaDescript(player,0) + " has grown larger, in depth AND size. To your absolute surprise it suddenly resume deepening inside your body. " +
					"When you finally take a look you discover your vagina is now not unlike that of a horse, capable of taking the largest cock with ease." +
					"<b>  You now have a equine vagina!</b>");
			player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_GAPING;
			player.vaginaType(VaginaClass.EQUINE);
		}

		if (player.lowerBody != LowerBody.HOOFED && player.lowerBody != LowerBody.GARGOYLE) {
			if (changes < changeLimit && rand(3) == 0) {
				outputText("\n\n");
				CoC.instance.transformations.LowerBodyHoofed(2).applyEffect();
				changes++;
			}
		}
		//Remove odd eyes
		if (changes < changeLimit && rand(4) == 0 && CoC.instance.transformations.EyesHuman.isPossible()) {
			outputText("\n\n");
			CoC.instance.transformations.EyesHuman.applyEffect();
			changes++;
		}
		if ((type == 1 || type == 2) && changes < changeLimit && rand(3) == 0 && CoC.instance.transformations.EyesChangeColor(["blue", "red"]).isPossible()) {
			outputText("\n\n");
			if (player.cor >= 50) {
				CoC.instance.transformations.EyesChangeColor(["red"]).applyEffect();
			} else {
				CoC.instance.transformations.EyesChangeColor(["blue"]).applyEffect();
			}

			if (CoC.instance.transformations.EyesHuman.isPossible()) {
				outputText("\n\n");
				CoC.instance.transformations.EyesHuman.applyEffect();
			}
			changes++;
		}
		//HorseFace - Req's Fur && Ears
		if (player.faceType != Face.HORSE && !player.isGargoyle() && player.hasFur() && changes < changeLimit && rand(4) == 0 && player.ears.type == Ears.HORSE) {
			outputText("\n\n");
			CoC.instance.transformations.FaceHorse.applyEffect();
			changes++;
		}
		//Fur - if has horsetail && ears and not at changelimit
		if (!player.hasFur() && !player.isTaur() && !player.isGargoyle() && changes < changeLimit && rand(4) == 0 && player.tailType == Tail.HORSE) {
			outputText("\n\n");
			if (type == 0) 	CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {colors: ["brown", "chocolate", "auburn", "sandy brown", "caramel", "peach", "black", "midnight black", "dark gray", "gray", "light gray", "silver", "white", "brown and white", "black and white"]}).applyEffect();
			else CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {colors: ["platinum blonde", "silver", "white", "pure white"]}).applyEffect();
			changes++;
		}
		//Ears - requires tail
		if (player.ears.type != Ears.HORSE && player.tailType == Tail.HORSE && player.tailType != Tail.GARGOYLE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.EarsHorse.applyEffect();
			changes++;
		}
		//Tail - requires legs
		if (player.tailType != Tail.HORSE && player.tailType != Tail.GARGOYLE && player.lowerBody == LowerBody.HOOFED && rand(2) == 0 && changes < changeLimit) {
			outputText("\n\n");
			CoC.instance.transformations.TailHorse.applyEffect();
			changes++;
		}
		// Remove gills
		if (rand(4) == 0 && player.hasGills() && changes < changeLimit) {
			outputText("\n\n");
			CoC.instance.transformations.GillsNone.applyEffect();
			changes++;
		}

		if ((type == 1 || type == 2) && changes < changeLimit && rand(3) == 0 && player.ears.type == Ears.HORSE && player.tailType == Tail.HORSE) {
			temp = 1;
			//New horns or expanding unicorn/alicorn horns
			if (player.horns.type == Horns.UNICORN || player.horns.type == Horns.NONE) {
				//Get bigger if player has horns
				if (player.horns.type == Horns.UNICORN) {
					{
						temp = 1 + rand(3);
						player.horns.count += temp;
						if (temp == 0) changes--;
						if (temp == 1) outputText("\n\nAn aching pressure builds in your temples as you feel your horns push another inch of length from your skull.  ");
						if (temp == 2) outputText("\n\nA powerful headache momentarily doubles you over.  With painful slowness, you feel your horns push another two inches of length out from your brow, gradually thickening as it grow.  ");
						if (temp == 3) outputText("\n\nAgony overwhelms you as a headache of terrifying intensity sweeps through your skull.  You squeeze your eyes shut from the pain, but it does little to help.  The torture intensifies before finally diminishing as you feel an inch or two of new horns force its way out of your forehead.  The headache remains despite this, and desperate for relief, you grab hold of your horns and tug, pulling another inch of new horns free.  At last the pain fades, leaving you with significantly enhanced head-spike.  ");
						if (player.horns.count < 3) outputText("It is the size of tiny nub.");
						if (player.horns.count >= 3 && player.horns.count < 6) outputText("It is similar to what you would see on a young unicorn.");
						if (player.horns.count >= 6 && player.horns.count < 12) outputText("It look like the horn on a grown unicorn, big enough and dangerous enough to do some damage.");
						if (player.horns.count >= 12 && player.horns.count < 20) outputText("It is large and wicked looking.");
						if (player.horns.count >= 20) outputText("It is large, pointed and spiraling horn.");
						changes++;
					}
				}
				//If no horns yet..
				else {
					outputText("\n\n");
					CoC.instance.transformations.HornsUnicorn.applyEffect();
					changes++;
				}
			}
			//Not uni/ali horns, change to uni/ali-horns
			if (player.horns.type != Horns.UNICORN && player.horns.type != Horns.ORCHID) {
				outputText("\n\n");
				CoC.instance.transformations.HornsUnicorn.applyEffect();
				changes++;
			}
		}
		//Alicorn wings
		if (type == 2 && player.wings.type == Wings.NONE && changes < changeLimit && player.horns.type == Horns.UNICORN && rand(4) == 0) {
			outputText("\n\n");
      CoC.instance.transformations.WingsFeatheredAlicorn.applyEffect();
			changes++;
		}
		//Nightmare wings
		if (type == 2 && player.wings.type == Wings.NONE && changes < changeLimit && (player.horns.type == Horns.UNICORN || player.horns.type == Horns.BICORN) && player.cor > 89 && rand(4) == 0) {
			outputText("\n\n");
      CoC.instance.transformations.WingsNightmare.applyEffect();
			changes++;
		}
		//Remove old wings
		if (type == 2 && (player.wings.type != Wings.FEATHERED_ALICORN || (player.wings.type != Wings.NIGHTMARE && player.cor > 89)) && player.wings.type != Wings.GARGOYLE_LIKE_LARGE && player.wings.type > Wings.NONE && changes < changeLimit && rand(4) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.WingsNone.applyEffect();
			changes++;
		}
		if (rand(3) == 0) outputText(player.modTone(60, 1));
		//FAILSAFE CHANGE
		if (changes == 0) {
			outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
			if (type == 0) EngineCore.HPChange(20, true);
			if (type == 1) EngineCore.HPChange(100, true);
			if (type == 2) EngineCore.HPChange(500, true);
			dynStats("lus", 3);
		}
		player.refillHunger(15);
		return false;
	}
}
}
