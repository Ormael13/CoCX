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
import classes.CoC;
import classes.CockTypesEnum;
import classes.EngineCore;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;
import classes.StatusEffects;
import classes.VaginaClass;

public class Centaurinum extends Consumable {
	public function Centaurinum() {
		super("Centari", "Centari", "a vial of Centaurinum", 20, "This is a long flared vial with a small label that reads, \"<i>Centaurinum</i>\".  It is likely this potion is tied to centaurs in some way.");
		withTag(U_TF);
		refineableInto(
				AlchemyLib.DEFAULT_SUBSTANCES_DROP_TABLE,
				AlchemyLib.DEFAULT_ESSENCE_DROP_TABLE(AlchemyLib.AE_HORSE, true)
		)
	}
	public override function useItem():Boolean {
		var changes:Number = 0;
		var changeLimit:Number = 2;
		if (rand(2) == 0) changeLimit++;
		changeLimit += player.additionalTransformationChances;
		//Temporary storage
		var temp2:Number = 0;
		var temp3:Number = 0;
		player.slimeFeed();
		clearOutput();
		outputText("You down the potion, grimacing at the strong taste.");
		//Speed up to 100
		if (changes < changeLimit && rand(3) == 0 && player.MutagenBonus("spe", 3)) {
			changes++;
			outputText("\n\nAfter drinking the potion, you feel a bit faster.");
		}
		//Toughness up to 80!
		if (changes < changeLimit && rand(3) == 0 && player.MutagenBonus("tou", 2)) {
			outputText("\n\nYour body and skin both thicken noticeably.  You pinch your [skin.type] experimentally and marvel at how much tougher it has gotten.");
			changes++;
		}
		if (player.blockingBodyTransformations()) changeLimit = 0;
		//Increase player's breast size, if they are big FF or smaller
		if (player.smallestTitSize() <= 14 && player.gender == 2 && changes < changeLimit && rand(4) == 0) {
			outputText("\n\nAfter eating it, your chest aches and tingles, and your hands reach up to scratch at it unthinkingly.  Silently, you hope that you aren't allergic to it.  Just as you start to scratch at your " + player.breastDescript(player.smallestTitRow()) + ", your chest pushes out in slight but sudden growth.");
			player.breastRows[player.smallestTitRow()].breastRating++;
			changes++;
		}
		//Stalion
		if ((player.gender == 1 || player.gender == 3) && rand(3) == 0 && changes < changeLimit) {
			//If cocks that aren't horsified!
			if ((player.horseCocks() + player.demonCocks()) < player.cockTotal()) {
				var temp:int = player.findFirstCockNotInType([CockTypesEnum.HORSE,CockTypesEnum.DEMON]);
				CoC.instance.transformations.CockHorse(temp).applyEffect();
				temp2 = player.growCock(temp, rand(4) + 4);

				dynStats("lus", 35, "scale", false);
				player.addCurse("sen", 4, 1);
				player.MutagenBonus("lib", 5);
				//Make cock thicker if not thick already!
				if (player.cocks[temp].cockThickness <= 2) player.thickenCock(temp, 1);
				changes++;
			}
			//Players cocks are all horse-type - increase size!
			else {
				//single cock
				if (player.cocks.length == 1) {
					temp2 = player.growCock(0, rand(3) + 1);
					temp = 0;
					dynStats("lus", 10, "scale", false);
					player.addCurse("sen", 1, 1);
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
					temp2 = player.growCock(temp, rand(4) + 1);
					dynStats("lus", 10, "scale", false);
					player.addCurse("sen", 1, 1);
				}
				outputText("\n\n");
				if (temp2 > 2) outputText("Your [cock "+ (temp+1) +"] tightens painfully, inches of taut horse-flesh pouring out from your sheath as it grows longer.  Thick animal-pre forms at the flared tip, drawn out from the pleasure of the change.");
				if (temp2 > 1 && temp2 <= 2) outputText("Aching pressure builds within your sheath, suddenly releasing as an inch or more of extra dick flesh spills out.  A dollop of pre beads on the head of your enlarged " + player.cockDescript(temp) + " from the pleasure of the growth.");
				if (temp2 <= 1) outputText("A slight pressure builds and releases as your [cock " + (temp+1) + "] pushes a bit further out of your sheath.");
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
				player.thickenCock(temp, .5);
				outputText("\n\nYour " + Appearance.cockNoun(CockTypesEnum.HORSE) + " thickens inside its sheath, growing larger and fatter as your veins thicken, becoming more noticeable.  It feels right");
				if (player.cor + player.lib < 60) outputText(" to have such a splendid tool.  You idly daydream about cunts and pussies, your " + Appearance.cockNoun(CockTypesEnum.HORSE) + " plowing them relentlessly, stuffing them pregnant with cum");
				else if (player.cor + player.lib < 100) outputText(" to be this way... You breath the powerful animalistic scent and fantasize about fucking centaurs night and day until their bellies slosh with your cum");
				else if (player.cor + player.lib <= 175) outputText(" to be a rutting stud.  You ache to find a mare or centaur to breed with.  Longing to spend your evenings plunging a " + Appearance.cockNoun(CockTypesEnum.HORSE) + " deep into their musky passages, dumping load after load of your thick animal-cum into them.  You'd be happy just fucking horsecunts morning, noon, and night.  Maybe somewhere there is a farm needing a breeder..");
				else outputText(" to whinny loudly like a rutting stallion.  Your " + Appearance.cockNoun(CockTypesEnum.HORSE) + " is perfect for fucking centaurs and mares.  You imagine the feel of plowing an equine pussy deeply, bottoming out and unloading sticky jets of horse-jizz into its fertile womb.  Your hand strokes your horsecock of its own accord, musky pre dripping from the flared tip with each stroke.  Your mind wanders to the thought of you with a harem of pregnant centaurs.");
				outputText(".");
				if (player.cor < 30) outputText("  You shudder in revulsion at the strange thoughts and vow to control yourself better.");
				else if (player.cor < 60) outputText("  You wonder why you thought such odd things, but they have a certain appeal.");
				else if (player.cor < 90) outputText("  You relish your twisted fantasies, hoping to dream of them again.");
				else outputText("  You flush hotly and give a twisted smile, resolving to find a fitting subject to rape and relive your fantasies.");
				dynStats("lus", 10, "scale", false);
				player.MutagenBonus("lib", 1);
			}
			//Chance of ball growth if not 3" yet
			if (rand(2) == 0 && changes < changeLimit && player.ballSize <= 3 && player.horseCocks() > 0) {
				if (player.balls == 0) {
					outputText("\n\nA nauseating pressure forms just under the base of your maleness.  With agonizing pain the flesh bulges and distends, pushing out a rounded lump of flesh that you recognize as a testicle!  A moment later relief overwhelms you as the second drops into your newly formed sack.");
					CoC.instance.transformations.BallsDuo.applyEffect(false);
					dynStats("lus", 5, "scale", false);
					player.MutagenBonus("lib", 2);
				}
				else {
					player.ballSize++;
					if (player.ballSize <= 2) outputText("\n\nA flash of warmth passes through you and a sudden weight develops in your groin.  You pause to examine the changes and your roving fingers discover your " + Appearance.ballsDescription(false, true, player) + " have grown larger than a human's.");
					if (player.ballSize > 2) outputText("\n\nA sudden onset of heat envelops your groin, focusing on your [sack].  Walking becomes difficult as you discover your " + Appearance.ballsDescription(false, true, player) + " have enlarged again.");
					dynStats("lus", 3, "scale", false);
					player.MutagenBonus("lib", 1);
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
		if (player.hasVagina() && player.vaginaType() != VaginaClass.EQUINE && changes < changeLimit && rand(3) == 0) {
			CoC.instance.transformations.VaginaHorse().applyEffect();
		}

		//classic horse-taur version
		if (changes < changeLimit && rand(2) == 0 && player.lowerBody == LowerBody.HOOFED && !player.isTaur()) {
			outputText("\n\n");
			CoC.instance.transformations.LowerBodyHoofed(4).applyEffect();
			changes++;
			player.MutagenBonus("spe", 3);
		}
		//generic version
		if (player.lowerBody != LowerBody.HOOFED && !player.isTaur() && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.LowerBodyTaur().applyEffect();
			player.MutagenBonus("spe", 3);
			changes++;
		}
		//Horse tail
		if (player.lowerBody == LowerBody.HOOFED && player.tailType != Tail.HORSE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.TailHorse.applyEffect();
			changes++;
		}
		//Human skin
		if (player.tailType == Tail.HORSE && !player.hasPlainSkinOnly() && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.SkinPlain.applyEffect();
			changes++;
		}
		//-Remove feather-arms (copy this for goblin ale, mino blood, equinum, centaurinum, canine pepps, demon items)
		if (changes < changeLimit && !InCollection(player.arms.type, Arms.HUMAN) && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.ArmsHuman.applyEffect();
			changes++;
		}
		//Human ears
		if (player.arms.type == Arms.HUMAN && !InCollection(player.ears.type, Ears.HUMAN, Ears.HORSE) && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.EarsHuman.applyEffect();
			changes++;
		}
		if (player.ears.type != Ears.HORSE && player.ears.type == Ears.HUMAN && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.EarsHorse.applyEffect();
			changes++;
		}
		//Human face
		if (InCollection(player.ears.type, Ears.HUMAN, Ears.HORSE) && player.faceType != Face.HUMAN && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.FaceHuman.applyEffect();
			changes++;
		}
		if (rand(3) == 0) outputText(player.modTone(60, 1));
		//FAILSAFE CHANGE
		if (changes == 0) {
			outputText("\n\nInhuman vitality spreads through your body, invigorating you!\n");
			EngineCore.HPChange(50, true);
			dynStats("lus", 3, "scale", false);
		}
		player.refillHunger(10);
		return false;
	}
}
}
