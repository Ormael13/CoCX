/**
 * Coded by aimozg on 01.06.2017.
 */
package classes.Items.Consumables {
import classes.CockTypesEnum;
import classes.Items.Consumable;
import classes.PerkLib;
import classes.StatusEffects;

public class MaraFruit extends Consumable{
	public function MaraFruit() {
		super("MaraFru", "MaraFruit", "an apple-shaped fruit", 10, "This green apple-shaped fruit that spread delicious scent around.  Thou it may as many thing in this realm also posses some transformative properties.");
	}

	override public function useItem():Boolean {
		var changes:Number = 0;
		var changeLimit:Number = 1;
		if (rand(3) == 0) changeLimit++;
		if (player.findPerk(PerkLib.HistoryAlchemist) >= 0 || player.findPerk(PerkLib.PastLifeAlchemist) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.EzekielBlessing) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
		player.slimeFeed();
		//Temporary storage
		var temp2:Number = 0;
		var temp3:Number = 0;
		clearOutput();
		outputText("Biting into it, sweet juices seem to explode from the flesh, dribbling down your chin.  It tastes like a dessert and you chow down, happily munching away.  In no time flat, you're down to just a core.");
		//-Increase strength up to 80.
		if (player.str < 80 && changes < changeLimit && rand(4) == 0) {
			outputText("\n\nYour fill your muscles filling with plants might.");
			dynStats("str", 1);
			changes++;
		}
		//-Increase toughness up to 100.
		if (player.tou < 100 && changes < changeLimit && rand(4) == 0) {
			outputText("\n\nYour body suddenly feels tougher and more resilient just like a tree.");
			dynStats("tou", 1);
			changes++;
		}
		//-Reduces speed down to 60.
		if (player.spe > 60 && changes < changeLimit && rand(4) == 0) {
			outputText("\n\nYou start to feel sluggish and cold.  Lying down to bask in the sun might make you feel better.");
			dynStats("spe", -1);
			changes++;
		}
		//Female changes - pussy to flower (for now unused)
		if (player.gender == 2 || (player.gender == 3 && player.mf("m", "f") == "f")) {
			var boobsGrew:Boolean = false;
			if (player.biggestTitSize() <= 15 && changes < changeLimit && rand(3) == 0) {
				if (rand(2) == 0) outputText("\n\nYour [breasts] tingle for a moment before becoming larger.");
				else outputText("\n\nYou feel a little weight added to your chest as your [breasts] seem to inflate and settle in a larger size.");
				player.growTits(1 + rand(3), 1, false, 3);
				changes++;
				dynStats("sen", .5);
				boobsGrew = true;
			}
			if (rand(3) == 0 && changes < changeLimit && player.hipRating < 10) {
				outputText("\n\nYour gait shifts slightly to accommodate your widening [hips]. The change is subtle, but they're definitely broader.");
				player.hipRating++;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.buttRating < 8) {
				outputText("\n\nWhen you stand back, up your [ass] jiggles with a good bit of extra weight.");
				player.buttRating++;
				changes++;
			}
			if (player.vaginas.length > 0) {
				outputText("\n\n");
				//0 = dry, 1 = wet, 2 = extra wet, 3 = always slick, 4 = drools constantly, 5 = female ejaculator
				if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLAVERING) {
					if (player.vaginas.length == 1) outputText("Your [vagina] gushes fluids down your leg as you spontaneously orgasm.");
					else outputText("Your [vagina]s gush fluids down your legs as you spontaneously orgasm, leaving a thick puddle of pussy-juice on the ground.  It is rapidly absorbed by the earth.");
					player.orgasm();
				}
				if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DROOLING) {
					outputText("After the last few times, you thought that the sudden arousal weakened with each use of the fruit, with the last time having caused you almost no noticeable increase in it. Clearly, you were wrong, as the sudden spike of arousal obligingly points out to you.  ");
					if (player.vaginas.length == 1) outputText("You cannot resist as your hands dive into your [vagina].  ");
					if (player.vaginas.length > 1) outputText("You cannot resist plunging your hands inside your [vagina]s.  ");
					outputText("Your orgasm comes mercifully quickly, accompanied by an impressive spray of your fluids.  Still high from the aphrodisiac effects of the fruit, you cannot help but be delighted at this new development.  <b>You are now a squirter</b>.");
					player.orgasm();
				}
				if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_SLICK) {
					outputText("You suddenly feel something trickling down your leg. The strong smell of fish slams into your poor unprepared nose, clueing you in as to the nature of the liquid. But just when you are getting used to the idea of smelling like a fishing port, the smell begins to change to a far lighter and sweeter one, which you recognize as that of the fruit. Your [vagina] now constantly drools lubricant down your leg, filling the air with a pleasant scent that most would mistake for perfume.");
				}
				if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_WET) {
					outputText("Once more, the fruit’s effects make themselves known, leaving you hornier and wetter than you already were, the later of which is likely to be permanent. At least this time you were already expecting it, so you weren’t forced to relieve yourself on the spot like the last time.");
				}
				if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_NORMAL) {
					outputText("Suddenly your arousal spikes. You feel as if you had downed several lust drafts while already in heat or rut, forcing you to masturbate furiously on the spot.  ");
					if (player.vaginas.length == 1) outputText("You realize afterwards that your [vagina] felt much wetter than normal.");
					else outputText("You realize afterwards that your [vagina] were much wetter than normal.");
					outputText("  Will you eventually become as juicy as the fruit was?");
				}
				if (player.vaginas[0].vaginalWetness == VAGINA_WETNESS_DRY) {
					outputText("You feel a tingling in your crotch, but cannot identify it.");
				}
				var temp:int = player.vaginas.length;
				while (temp > 0) {
					temp--;
					if (player.vaginas[0].vaginalWetness < VAGINA_WETNESS_SLAVERING) player.vaginas[temp].vaginalWetness++;
				}
				changes++;
			}
			//Fertility boost
			if (player.vaginas.length > 0 && player.fertility < 40) {
				outputText("\n\nYou feel your womb start to give off a pleasant warmth, instinctively knowing it has become more fertile. Plants <b>are</b> known for their fertility, and you <b>are</b> trying to become somewhat closer to them, so this was to be expected. Perhaps being as fertile as this once verdant land won’t be so bad. Might as well try to give the goddess a run for her money.");
				player.fertility += 5;
				changes++;
			}
		}
		//Male changes
		if (player.gender <= 1 || (player.gender == 3 && player.mf("m", "f") == "m")) {
			if(rand(2) == 0 && player.cockTotal() > player.tentacleCocks()) {
				var choices:Array = [];
				temp = 0;
				while(temp < player.cockTotal()) {
					if(player.cocks[temp].cockType != CockTypesEnum.TENTACLE) choices[choices.length] = temp;
					temp++;
				}
				temp = choices[rand(choices.length)];
				outputText("\n\nYour " + num2Text2(temp+1) + " penis itches, and you idly scratch at it.  As you do, it begins to grow longer and longer, all the way to the ground before you realize something is wrong.  You pull open your [armor] and look down, discovering your " + game.cockDescript(temp) + " has become a tentacle!  As you watch, it shortens back up; it's colored green except for a purplish head, and evidence seems to suggest you can make it stretch out at will.  <b>You now have a");
				if(player.tentacleCocks() > 0) outputText("nother");
				outputText(" tentacle-cock!</b>");
				player.cocks[temp].cockType = CockTypesEnum.TENTACLE;
				player.cocks[temp].knotMultiplier = 1.3;
				dynStats("sen", 3, "lus", 10);
			}
			if (rand(3) == 0 && changes < changeLimit && player.breastRows.length > 0) {
				//Single row
				if (player.breastRows.length == 1) {
					//Shrink if bigger than B cups
					if (player.breastRows[0].breastRating >= 1) {
						temp = 1;
						player.breastRows[0].breastRating--;
						//Shrink again if huuuuge
						if (player.breastRows[0].breastRating > 8) {
							temp++;
							player.breastRows[0].breastRating--;
						}
						//Talk about shrinkage
						if (temp == 1) outputText("\n\nYou feel a weight lifted from you, and realize your " + game.breastDescript(0) + " have shrunk to " + player.breastCup(0) + "s.");
						if (temp == 2) outputText("\n\nYou feel significantly lighter.  Looking down, you realize your breasts are MUCH smaller, down to " + player.breastCup(0) + "s.");
						changes++;
					}
				}
				//multiple
				else {
					//temp2 = amount changed
					//temp3 = counter
					temp = 0;
					temp2 = 0;
					temp3 = 0;
					if (player.biggestTitSize() >= 1) outputText("\n");
					while (temp3 < player.breastRows.length) {
						if (player.breastRows[temp3].breastRating >= 1) {
							player.breastRows[temp3].breastRating--;
							temp2++;
							outputText("\n");
							//If this isn't the first change...
							if (temp2 > 1) outputText("...and y");
							else outputText("Y");
							outputText("our " + game.breastDescript(temp3) + " shrink, dropping to " + player.breastCup(temp3) + "s.");
						}
						temp3++;
					}
					if (temp2 == 2) outputText("\nYou feel so much lighter after the change.");
					if (temp2 == 3) outputText("\nWithout the extra weight you feel particularly limber.");
					if (temp2 >= 4) outputText("\nIt feels as if the weight of the world has been lifted from your shoulders, or in this case, your chest.");
					if (temp2 > 0) changes++;
				}
			}
			if (changes < changeLimit && rand(3) == 0 && player.hipRating >= 4) {
				outputText("\n\nYou stumble a bit as the bones in your pelvis rearrange themselves painfully.  Your waistline has narrowed, becoming [hips].");
				player.hipRating--;
				if (player.hipRating > 15) player.hipRating--;
				changes++;
			}
			if(player.buttRating >= 4 && rand(3) == 0 && changes < changeLimit)
			{
				outputText("\n\nYou cringe as your [butt] begins to feel uncomfortably tight.  Once the sensation passes, you look over your shoulder, inspecting yourself.  It would appear that your ass has become smaller!");
				player.buttRating--;
				if(player.buttRating > 10) player.buttRating--;
				if(player.buttRating > 15) player.buttRating--;
				if(player.buttRating > 20) player.buttRating--;
				if(player.buttRating > 23) player.buttRating--;
				changes++;
			}
		}
		//Skin
		if (!player.hasPlainSkinOnly() && !player.isGargoyle() && changes < changeLimit && rand(4) == 0 && player.faceType == FACE_HUMAN) {
			mutations.humanizeSkin();
			changes++;
		}
		if (player.hasPlainSkinOnly() && player.skinTone != "leaf green" && player.skinTone != "lime green" && player.skinTone != "turquoise" && changes < changeLimit && rand(2) == 0) {
			if (rand(10) == 0) player.skinTone = "turquoise";
			else {
				if (rand(5) == 0) player.skinTone = "lime green";
				else player.skinTone = "leaf green";
			}
			changes++;
			outputText("\n\nWhoah, that was weird.  You just hallucinated that your skin turned " + player.skinTone + ".  No way!  It's staying, it really changed color!");
		}
		//insert here turning into bark skin so it req. at least 2x use of mara fruit a także dodać wymaganie posiadanie już plant arms i legs
		//Legs
		if (player.skin.hasPlainSkinOnly() && (player.skinTone == "leaf green" || player.skinTone == "lime green" || player.skinTone == "turquoise") && changes < changeLimit && rand(3) == 0) {
			//Males/genderless get clawed feet
			if (player.gender <= 1 || (player.gender == 3 && player.mf("m", "f") == "m")) {
				if (player.lowerBody != LOWER_BODY_TYPE_PLANT_ROOT_CLAWS) {
					outputText("\n\n");
					if (player.lowerBody != LOWER_BODY_TYPE_HUMAN) outputText("You watch, spellbound, while your legs gradually change its entire outer structure into a plain human-like form. ");
					outputText("Every muscle and sinew below your hip tingles and you begin to stagger. Seconds after you sit down, pain explodes in your [feet]. In few places the skin on your feet breaks up to reveal... a root-like skin underneath. Gradually the rest of the skin around the ankle is shed of uncovering your new feet shape, that are roots arranged in a way to loosely reassemble feet. <b>Your feet are now formed into roots.</b>");
					mutations.setLowerBody(LOWER_BODY_TYPE_PLANT_ROOT_CLAWS);
					player.legCount = 2;
				}
			}
			//Females/futa get high heels
			else {
				if (player.lowerBody != LOWER_BODY_TYPE_PLANT_HIGH_HEELS && player.lowerBody != LOWER_BODY_TYPE_PLANT_FLOWER) {
					outputText("\n\n");
					if (player.lowerBody != LOWER_BODY_TYPE_HUMAN) outputText("You watch, spellbound, while your legs gradually change its entire outer structure into a plain human-like form. ");
					outputText("Soon after you start to feel something new tickling and crawling its way into being, this time on your tights, working its way down your legs.  Looking on them you can see a thin, delicate vines, with spade-shaped leaves unfolding from them as they curl snugly around your thighs and shank all the way down to your ankles. <b>You now have vine-covered legs.</b>");
					mutations.setLowerBody(LOWER_BODY_TYPE_PLANT_HIGH_HEELS);
					player.legCount = 2;
				}
			}
			changes++;
		}
		//Arms
		if ((player.lowerBody == LOWER_BODY_TYPE_PLANT_HIGH_HEELS || player.lowerBody == LOWER_BODY_TYPE_PLANT_ROOT_CLAWS) && !InCollection(player.armType, ARM_TYPE_GARGOYLE, ARM_TYPE_PLANT) && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYou watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. Soon after you start feel something new tickling and crawling its way into being, this time on your shoulders, working its way down your arms.  Looking on them you can see a thin, delicate vines, with spade-shaped leaves unfolding from them as they curl snugly around your biceps and deltoids all the way down to your wrists. <b>You now have vine-covered arms.</b>");
			mutations.setArmType(ARM_TYPE_PLANT);
			changes++;
		}
		//Wings slot aka tentacle cockvine wings
		if (player.armType == ARM_TYPE_PLANT && player.wingType != WING_TYPE_PLANT && player.lowerBody != LOWER_BODY_TYPE_PLANT_FLOWER && changes < changeLimit && rand(3) == 0) {
			if (player.wingType != WING_TYPE_NONE) {
				outputText("\n\nYour old wings are drooping leaving your back as smooth and unbroken as the day you entered the portal. But this state not last long.");
			}
			outputText("\n\nPressure is building in multiple spots on your upper back. It feels more like several over-eager erections trapped in incredibly tight undies. You can’t help but groan with relief when finally the pressure peaks and many thick protrusions burst impatiently out of your [skin.type]. The hot, thick, vine-like growths thrust their way into being, feet of oily green tentacles, alarmingly energetic and prehensile, thrashing around your [hips].");
			outputText(" After a moment of concentration you cause one of these growths to rear around into your hand to take a closer look at it. It feels unmistakably dick-like - bulging, tender flesh under the fibrous skin, with quite a bit of flexible, able to bend all along its length and dart its wet, distended head in any direction you wish. <b>You now have cockvine wings.</b>");
			mutations.setWingType(WING_TYPE_PLANT, "cockvine");
			changes++;
		}
		//Ears
		if (player.earType != EARS_ELFIN && !player.isGargoyle() && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nA weird tingling runs through your scalp as your [hair] shifts slightly.  You reach up to touch and bump <b>your new pointed elfin ears</b>.  You bet they look cute!");
			changes++;
			mutations.setEarType(EARS_ELFIN);
		}
		//Face
		if (player.faceType != FACE_HUMAN && changes < changeLimit && rand(4) == 0 && player.earType == EARS_ELFIN) {
			changes++;
			mutations.setFaceType(FACE_HUMAN);
			outputText("\n\nAnother violent sneeze escapes you.  It hurt!  You feel your nose and discover your face has changed back into a more normal look.  <b>You have a human looking face again!</b>");
		}
		//Leaf Hair
		if (player.hairColor == "green" && (player.hairType != HAIR_LEAF && player.hairType != HAIR_GRASS) && !player.isGargoyle() && rand(3) == 0 && changes < changeLimit)
		{
			if (rand(2) == 0) {
				outputText("\n\nYour [hair] begins to fall out in clumps, eventually leaving your scalp completely bald.  Although, thankfully, it does not remain like that for long.  Within moments a full head of grass sprouts from the skin of your scalp, protecting it from the chilly wind which was starting to annoy you.  You run your hands through your newly grown hair-like grass, stifling a moan at how sensitive the thousands of long, soft and leafy blades that replaced your hair are.  <b>Your hair has been replaced by grass, your scalp is now covered with soft blades of verdant greenery...</b>");
				mutations.setHairType(HAIR_GRASS);
			}
			else {
				outputText("\n\nYour [hair] begins to fall out in globs, eventually leaving you with a bald head.  Your head is not left bald for long, though.  Within moments, a full head of leaf sprouts from the skin of your scalp.  You run your hands through your new growth, sighing at the pleasure of being able to feel each individual leaf.  <b>Your hair turned into thin leafs replacing your current hair!</b>");
				mutations.setHairType(HAIR_LEAF);
			}
			changes++;
		}
		//green hair
		if (player.hairColor != "green" && !player.isGargoyle() && rand(3) == 0 && changes < changeLimit)
		{
			outputText("\n\nAt first it looks like nothing changed but then you realize all the hair on your body has shifted to a verdant green color.  <b>You now have green hair.</b>");
			player.hairColor = "green";
		}
		//Horns
		if ((player.hairType == HAIR_LEAF || player.hairType == HAIR_GRASS) && changes < changeLimit && rand(2) == 0) {
			//Males/genderless get oak horns
			if (player.gender <= 1 || (player.gender == 3 && player.mf("m", "f") == "m")) {
				if (player.horns == 0) {
					outputText("\n\nYou hear the sound of cracking branches erupting from the tip of your skull.  Small bulges on either side of your head advance outwards in a straight line, eventually spreading out in multiple directions like a miniature tree.  Investigating the exotic additions sprouting from your head, the situation becomes clear.  <b>You've grown oak horns!</b>");
					mutations.setHornType(HORNS_OAK, 4 + rand(4));
				}
				if (player.horns > 0 && player.hornType != HORNS_OAK) {
					outputText("\n\nYou hear the sound of cracking branches erupting from the tip of your skull.  The horns on your head begin to twist and turn fanatically, their texture and size morphing considerably until they resemble something more like trees than anything else.  Branching out rebelliously, you've come to the conclusion that <b>you've somehow gained oak horns!</b>");
					mutations.setHornType(HORNS_OAK, 4 + rand(4));
				}
			}
			//Females/futa get orchid flowers
			else {
				if (player.horns == 0 && player.hornType == HORNS_NONE) {
					outputText("\n\nA spot on each side of your head has been getting steadily sorer.  You’re beginning to think about finding somewhere quiet to take a look at it when it suddenly and rather shockingly bursts, allowing something hand-sized to bloom out from your [hair]. A huge orchids is now flourishing their floppy petals and stamen above your head!  <b>You've grown twin orchid flowers!</b>");
					mutations.setHornType(HORNS_ORCHID, 2);
				}
				if (player.horns > 0 && player.hornType != HORNS_ORCHID) {
					outputText("\n\nYour old horns slowly crumbling away until nothing is left.  Then a spot on each side of your head has been getting steadily sorer.  You’re beginning to think about finding somewhere quiet to take a look at it when it suddenly and rather shockingly bursts, allowing something hand-sized to bloom out from your [hair]. A huge pair of orchids is now flourishing their floppy petals and stamen above your head!  <b>You've grown a pair of orchid flowers!</b>");
					mutations.setHornType(HORNS_ORCHID, 2);
				}
			}
			changes++;
		}
		//
		if (player.plantScore() >= 7 && player.wingType == WING_TYPE_PLANT && player.hasStatusEffect(StatusEffects.AlrauneFlower) && changes < changeLimit && rand(2) == 0) {
			outputText("\n\nYour close your eyes to appreciate the feeling of the sun on your vegetal skin, losing yourself in the sensation. That is short lived as your feet suddenly tingle with a weird feeling. Opening your eye you look down in panic as your feet roots themselves in the ground and start to merge together up to your pussy into a trunk which turn a shade of green darker than the rest of your body. Your tentacle wings have also moved down to your feet tips but the weirdest happen when everything below your waist grow bloated easily becoming twice as large as you are. ");
			outputText("Your legs almost look... like a flower about to bloom? Bloom it does indeed as everything below your waist explode in a orchid of enormous size with petal large enough to engulf you entirely. Worried about being rooted in place you try and move and to your surprise you pretty much discover you can actually walk around on the vine like tentacle cocks at the base of your body. It feels weird at first but you think you will get used to walking on pseudo vines.");
			if (player.tailType != 0) {
				if (player.tailType == 5 || player.tailType == 6) outputText(" Your insectile abdomen");
				else if (player.tailType > 0 && player.tailCount > 1) outputText(" Your tails");
				else outputText(" Your tail");
				outputText(" recede back into your body disappearing entirely into your backside as if it never existed.");
			}
			if (player.tailType != 0) mutations.setTailType(0);
			mutations.setWingType(WING_TYPE_NONE, "non-existant");
			mutations.setLowerBody(LOWER_BODY_TYPE_PLANT_FLOWER);
			player.legCount = 12;
			changes++;
		}
		player.refillHunger(10);
		return false;
	}
}
}
