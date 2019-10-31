/**
 * Coded by aimozg on 01.06.2017.
 */
package classes.Items.Consumables {
import classes.Appearance;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Tail;
import classes.CoC_Settings;
import classes.CockTypesEnum;
import classes.EngineCore;
import classes.Items.Consumable;
import classes.PerkLib;
import classes.StatusEffects;
import classes.VaginaClass;

public class Centaurinum extends Consumable{
	public function Centaurinum() {
		super("Centari", "Centari", "a vial of Centaurinum", 20, "This is a long flared vial with a small label that reads, \"<i>Centaurinum</i>\".  It is likely this potion is tied to centaurs in some way.");
	}
	public override function useItem():Boolean {
		var changes:Number = 0;
		var changeLimit:Number = 1;
		if (rand(2) == 0) changeLimit++;
		if (player.findPerk(PerkLib.HistoryAlchemist) >= 0 || player.findPerk(PerkLib.PastLifeAlchemist) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.Enhancement) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.Fusion) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.Enchantment) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.Refinement) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.Saturation) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.Perfection) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.Creationism) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.EzekielBlessing) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
		//Temporary storage
		var temp2:Number = 0;
		var temp3:Number = 0;
		player.slimeFeed();
		clearOutput();
		outputText("You down the potion, grimacing at the strong taste.");
		//Speed up to 100
		if (changes < changeLimit && player.spe < 100 && rand(3) == 0) {
			changes++;
			outputText("\n\nAfter drinking the potion, you feel a bit faster.");
			dynStats("spe", 3);
		}
		//Toughness up to 80!
		if (changes < changeLimit && player.tou < 80 && rand(3) == 0) {
			dynStats("tou", 2);
			outputText("\n\nYour body and skin both thicken noticeably.  You pinch your [skin.type] experimentally and marvel at how much tougher it has gotten.");
			changes++;
		}
		if (player.hasPerk(PerkLib.TransformationImmunity) || player.hasPerk(PerkLib.Undeath)) changeLimit = 0;
		//Increase player's breast size, if they are big FF or smaller
		if (player.smallestTitSize() <= 14 && player.gender == 2 && changes < changeLimit && rand(4) == 0) {
			outputText("\n\nAfter eating it, your chest aches and tingles, and your hands reach up to scratch at it unthinkingly.  Silently, you hope that you aren't allergic to it.  Just as you start to scratch at your " + player.breastDescript(player.smallestTitRow()) + ", your chest pushes out in slight but sudden growth.");
			player.breastRows[player.smallestTitRow()].breastRating++;
			changes++;
		}
		//Stalion
		if ((player.gender == 1 || player.gender == 3) && rand(3) == 0 && changes < changeLimit) {
			//If cocks that aren't horsified!
			if ((player.horseCocks() + player.demonCocks()) < player.cocks.length) {
				//Transform a cock and store it's index value to talk about it.
				//Single cock
				if (player.cocks.length == 1) {
					var temp:int = 0;
					//Use temp3 to track whether or not anything is changed.
					temp3 = 0;
					if (player.cocks[0].cockType == CockTypesEnum.HUMAN) {
						outputText("\n\nYour [cock] begins to feel strange... you pull down your pants to take a look and see it darkening as you feel a tightness near the base where your skin seems to be bunching up.  A sheath begins forming around your cock's base, tightening and pulling your cock inside its depths.  A hot feeling envelops your member as it suddenly grows into a horse penis, dwarfing its old size.  The skin is mottled brown and black and feels more sensitive than normal.  Your hands are irresistibly drawn to it, and you jerk yourself off, splattering cum with intense force.");
						temp = player.addHorseCock();
						temp2 = player.increaseCock(temp, rand(4) + 4);
						temp3 = 1;
						dynStats("lib", 5, "sen", 4, "lus", 35);
					}
					if (player.cocks[0].cockType == CockTypesEnum.DOG) {
						temp = player.addHorseCock();
						outputText("\n\nYour " + Appearance.cockNoun(CockTypesEnum.DOG) + " begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your " + Appearance.cockNoun(CockTypesEnum.DOG) + " as it flattens, flaring outwards.  Your cock pushes out of your sheath, inch after inch of animal-flesh growing beyond it's traditional size.  You notice your knot vanishing, the extra flesh pushing more horsecock out from your sheath.  Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", and you jerk yourself off, splattering thick ropes of cum with intense force.");
						temp2 = player.increaseCock(temp, rand(4) + 4);
						temp3 = 1;
						dynStats("lib", 5, "sen", 4, "lus", 35);
					}
					if (player.cocks[0].cockType == CockTypesEnum.TENTACLE) {
						temp = player.addHorseCock();
						outputText("\n\nYour [cock] begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your [cock] as it flattens, flaring outwards.  Your skin folds and bunches around the base, forming an animalistic sheath.  The slick inhuman texture you recently had fades, taking on a more leathery texture.  Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", and you jerk yourself off, splattering thick ropes of cum with intense force.");
						temp2 = player.increaseCock(temp, rand(4) + 4);
						temp3 = 1;
						dynStats("lib", 5, "sen", 4, "lus", 35);
					}
					if (player.cocks[0].cockType.Index > 4) {
						outputText("\n\nYour [cock] begins to feel odd... you pull down your clothes to take a look and see it darkening.  You feel a growing tightness in the tip of your [cock] as it flattens, flaring outwards.  Your skin folds and bunches around the base, forming an animalistic sheath.  The slick inhuman texture you recently had fades, taking on a more leathery texture.  Your hands are drawn to the strange new " + Appearance.cockNoun(CockTypesEnum.HORSE) + ", and you jerk yourself off, splattering thick ropes of cum with intense force.");
						temp = player.addHorseCock();
						temp2 = player.increaseCock(temp, rand(4) + 4);
						temp3 = 1;
						dynStats("lib", 5, "sen", 4, "lus", 35);
					}
					if (temp3 == 1) outputText("  <b>Your penis has transformed into a horse's!</b>");
				}
				//MULTICOCK
				else {
					dynStats("lib", 5, "sen", 4, "lus", 35);
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
					temp = 0;
					dynStats("sen", 1, "lus", 10);
				}
				//Multicock
				else {
					//Find smallest cock
					//Temp2 = smallness size
					//temp = current smallest
					temp3 = player.cocks.length;
					temp = 0;
					while (temp3 > 0) {
						temp3--;
						//If current cock is smaller than saved, switch values.
						if (player.cocks[temp].cockLength > player.cocks[temp3].cockLength) {
							temp2 = player.cocks[temp3].cockLength;
							temp = temp3;
						}
					}
					//Grow smallest cock!
					//temp2 changes to growth amount
					temp2 = player.increaseCock(temp, rand(4) + 1);
					dynStats("sen", 1, "lus", 10);
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
				dynStats("lib", .5, "lus", 10);
			}
			//Chance of ball growth if not 3" yet
			if (rand(2) == 0 && changes < changeLimit && player.ballSize <= 3 && player.horseCocks() > 0) {
				if (player.balls == 0) {
					player.balls = 2;
					player.ballSize = 1;
					outputText("\n\nA nauseating pressure forms just under the base of your maleness.  With agonizing pain the flesh bulges and distends, pushing out a rounded lump of flesh that you recognize as a testicle!  A moment later relief overwhelms you as the second drops into your newly formed sack.");
					dynStats("lib", 2, "lus", 5);
				}
				else {
					player.ballSize++;
					if (player.ballSize <= 2) outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your " + Appearance.ballsDescription(false, true, player) + " have grown larger than a human's.");
					if (player.ballSize > 2) outputText("\n\nA sudden onset of heat envelops your groin, focusing on your [sack].  Walking becomes difficult as you discover your " + Appearance.ballsDescription(false, true, player) + " have enlarged again.");
					dynStats("lib", 1, "lus", 3);
				}
				changes++;
			}
		}
		//Mare
		if (player.gender == 2 || player.gender == 3) {
			//Single vag
			if (player.vaginas.length == 1) {
				if (player.vaginas[0].vaginalLooseness <= VaginaClass.LOOSENESS_GAPING && changes < changeLimit && rand(2) == 0) {
					outputText("\n\nYou grip your gut in pain as you feel your organs shift slightly.  When the pressure passes, you realize your [vagina] has grown larger, in depth AND size.");
					player.vaginas[0].vaginalLooseness++;
					changes++;
				}
				if (player.vaginas[0].vaginalWetness <= VaginaClass.WETNESS_NORMAL && changes < changeLimit && rand(2) == 0) {
					outputText("\n\nYour [vagina] moistens perceptably, giving off an animalistic scent.");
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
				temp = 0;
				temp2 = player.vaginas[temp].vaginalWetness;
				temp3 = player.vaginas.length;
				while (temp3 > 0) {
					temp3--;
					if (temp2 > player.vaginas[temp3].vaginalWetness) {
						temp = temp3;
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
				temp = 0;
				temp2 = player.vaginas[temp].vaginalLooseness;
				temp3 = player.vaginas.length;
				while (temp3 > 0) {
					temp3--;
					if (temp2 > player.vaginas[temp3].vaginalLooseness) {
						temp = temp3;
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
		}
		//Mare-gina

		//classic horse-taur version
		if (changes < changeLimit && rand(2) == 0 && player.lowerBody == LowerBody.HOOFED && player.lowerBody != LowerBody.GARGOYLE && !player.isTaur()) {
			changes++;
			outputText("\n\nImmense pain overtakes you as you feel your backbone snap.  The agony doesn't stop, blacking you out as your spine lengthens, growing with new flesh from your backside as the bones of your legs flex and twist.  Muscle groups shift and rearrange themselves as the change completes, the pain dying away as your consciousness returns.  <b>You now have the lower body of a centaur</b>.");
			if (player.gender > 0) {
				outputText("  After taking a moment to get used to your new body, you notice that your genitals now reside between the back legs on your centaur body.");
			}
			dynStats("spe", 3);
			mutations.setLowerBody(LowerBody.HOOFED);
			player.legCount = 4;
		}
		//generic version
		if (player.lowerBody != LowerBody.HOOFED && player.lowerBody != LowerBody.GARGOYLE && !player.isTaur()) {
			if (changes < changeLimit && rand(3) == 0) {
				changes++;
				//else if (player.lowerBody == DOG) outputText("\n\nYou stagger as your paws change, curling up into painful angry lumps of flesh.  They get tighter and tighter, harder and harder, until at last they solidify into hooves!");
				if (player.lowerBody == LowerBody.NAGA || player.lowerBody == LowerBody.SCYLLA) {
					if (player.lowerBody == LowerBody.NAGA) {
						outputText("\n\nYou collapse as your sinuous snake-tail tears in half, shifting into legs.  The pain is immense, particularly in your new feet as they curl inward and transform into hooves!");
					}
					if (player.lowerBody == LowerBody.SCYLLA) {
						outputText("\n\nYou collapse as your tentacle legs starts to merge in pairs, shifting into legs.  The pain is immense, particularly in your new feet as they curl inward and transform into hooves!");
					}
					mutations.setLowerBody(LowerBody.HOOFED);
				}
				//Catch-all
				else {
					if (player.lowerBody == LowerBody.HUMAN)
						mutations.setLowerBody(LowerBody.HOOFED);
					outputText("\n\nImmense pain overtakes you as you feel your backbone snap.  The agony doesn't stop, blacking you out as your spine lengthens, growing with new flesh from your backside as the bones of your legs flex and twist.  Muscle groups shift and rearrange themselves as the change completes, the pain dying away as your consciousness returns.  <b>You now have the lower body of a feral beast!</b>");
				}
				if (player.gender > 0)
					outputText("  After taking a moment to get used to your new body, you notice that your genitals now reside between the hind legs of your body.");
				dynStats("spe", 3);
				//outputText("  A coat of beastial fur springs up below your waist, itching as it fills in.<b>  You now have hooves in place of your feet!</b>");
				player.legCount = 4;
				//dynStats("cor", 0);
				changes++;
			}
		}
		//Horse tail
		if (player.lowerBody == LowerBody.HOOFED && player.tailType != Tail.GARGOYLE && player.tailType != Tail.HORSE && changes < changeLimit && rand(3) == 0) {
			//no tail
			if (player.tailType == 0) {
				outputText("\n\nThere is a sudden tickling on your ass, and you notice you have sprouted a long shiny horsetail of the same [haircolor] color as your hair.");
			}
			//if other animal tail
			if (player.tailType > Tail.HORSE && player.tailType <= Tail.COW) {
				outputText("\n\nPain lances up your [asshole] as your tail shifts and morphs disgustingly.  With one last wave of pain, it splits into hundreds of tiny filaments, transforming into a horsetail.");
			}
			//if bee/mantis/scorpion/spider-butt.
			if ((player.tailType > Tail.COW && player.tailType < Tail.SHARK) || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTIS_ABDOMEN) {
				outputText("\n\nYour insect-like abdomen bunches up as it begins shrinking, exoskeleton flaking off like a snake sheds its skin.  It bunches up until it is as small as a tennis ball, then explodes outwards, growing into an animalistic tail shape.  Moments later, it explodes into filaments of pain, dividing into hundreds of strands and turning into a shiny horsetail.");
			}
			if (player.tailType >= Tail.SHARK) {
				outputText("\n\nPain lances up your [asshole] as your tail shifts and morphs disgustingly.  With one last wave of pain, it splits into hundreds of tiny filaments, transforming into a horsetail.");
			}
			outputText("  <b>You now have a horse-tail.</b>");
			mutations.setTailType(Tail.HORSE, 1);
			player.tailVenom = 0;
			player.tailRecharge = 0;
			changes++;
		}
		//Human skin	
		if (player.tailType == Tail.HORSE && !player.hasPlainSkinOnly() && !player.isGargoyle() && changes < changeLimit && rand(3) == 0) {
			mutations.humanizeSkin();
			changes++;
		}
		//-Remove feather-arms (copy this for goblin ale, mino blood, equinum, centaurinum, canine pepps, demon items)
		if (changes < changeLimit && !InCollection(player.arms.type, Arms.HUMAN, Arms.GARGOYLE) && rand(3) == 0) {
			mutations.humanizeArms();
			changes++;
		}
		//Human ears
		if (player.arms.type == Arms.HUMAN && player.ears.type != Ears.HUMAN && changes < changeLimit && rand(3) == 0) {
			mutations.humanizeEars();
			changes++;
		}
		if (player.ears.type != Ears.HORSE && player.ears.type == Ears.HUMAN && player.tailType != Tail.GARGOYLE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYour ears tug painfully on your face as they begin shifting, moving upwards to the top of your head and transforming into a upright animalistic ears.  <b>You now have horse ears.</b>");
			mutations.setEarType(Ears.HORSE);
			changes++;
		}
		//Human face
		if (player.ears.type == Ears.HUMAN && player.faceType != Face.HUMAN && changes < changeLimit && rand(3) == 0) {
			mutations.humanizeFace();
			changes++;
		}
		if (rand(3) == 0) outputText(player.modTone(60, 1));
		//FAILSAFE CHANGE
		if (changes == 0) {
			outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
			EngineCore.HPChange(50, true);
			dynStats("lus", 3);
		}
		player.refillHunger(10);
		return false;
	}
}
}
