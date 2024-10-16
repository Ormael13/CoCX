/**
 * Coded by aimozg on 01.06.2017.
 */
package classes.Items.Consumables {
import classes.Appearance;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Face;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.CoC;
import classes.CockTypesEnum;
import classes.EngineCore;
import classes.GeneticMemories.BallsMem;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;
import classes.Races.KirinRace;
import classes.Scenes.Metamorph;
import classes.StatusEffects;
import classes.VaginaClass;

public class AsumaKirin extends Consumable {
	public function AsumaKirin() {
		super("Asumaki", "Asumaki", "a bottle of Asuma Kirin", 20, "A glass bottle containing a golden liquid. The label features various symbols that you don't know, but you can still read Azuma Kirin written in golden letters! Even closed, you can still smell alcohol, musk and ozone on this thing!");
		withTag(U_TF);
		refineableInto(
				AlchemyLib.DEFAULT_SUBSTANCES_DROP_TABLE,
				AlchemyLib.MULTIRACE_ESSENCE_DROP_TABLE(
						AlchemyLib.AE_HORSE,
						AlchemyLib.AE_KIRIN
				),
				[
						[1, AlchemyLib.AR_SPE],
						[1, AlchemyLib.AR_TOU],
						[1, AlchemyLib.AR_LIB]
				],
				concat(
						KirinRace.KirinScaleColors,
						KirinRace.KirinEyeColors,
						KirinRace.KirinHairColors
				)
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
		outputText("You down the alcohol, feeling giddy for a few second as it gets to your brain. Suddenly you jump as a random shock of static jolts you.");
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
			if ((player.kirinCocks() + player.demonCocks()) < player.cocks.length) {
				var temp:int = player.findFirstCockNotInType([CockTypesEnum.HORSE, CockTypesEnum.DEMON]);
				CoC.instance.transformations.CockKirin(temp).applyEffect();
				dynStats("lus", 35, "scale", false);
				player.addCurse("sen", 4, 1);
				player.MutagenBonus("lib", 5);
				if (player.cocks[temp].cockThickness <= 2) player.thickenCock(temp, 1);
				changes++;
			} else {
				if (player.cocks.length == 1) {
					temp2 = player.growCock(0, rand(3) + 1);
					temp = 0;
					dynStats("sen", 1, "lus", 10);
				} else {
					//Find smallest cock
					//Temp2 = smallness size
					//temp = current smallest
					//temp3 = player.cocks.length;
					temp = player.shortestCockIndex();
					//Grow smallest cock!
					//temp2 changes to growth amount
					temp2 = player.growCock(temp, rand(4) + 1);
					dynStats("sen", 1, "lus", 10);
				}
				outputText("[pg]");
				if (temp2 > 2) outputText("Your " + player.cockDescript(temp) + " tightens painfully, inches of taut horse-flesh pouring out from your sheath as it grows longer.  Thick animal-pre forms at the flared tip, drawn out from the pleasure of the change.");
				if (temp2 > 1 && temp2 <= 2) outputText("Aching pressure builds within your sheath, suddenly releasing as an inch or more of extra dick flesh spills out.  A dollop of pre beads on the head of your enlarged " + player.cockDescript(temp) + " from the pleasure of the growth.");
				if (temp2 <= 1) outputText("A slight pressure builds and releases as your " + player.cockDescript(temp) + " pushes a bit further out of your sheath.");
				changes++;
			}
			//Chance of thickness + daydream
			if (rand(2) == 0 && changes < changeLimit && player.kirinCocks() > 0) {
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
				outputText("\n\nYour " + Appearance.cockNoun(CockTypesEnum.KIRIN) + " thickens inside its sheath, growing larger and fatter as your veins thicken, becoming more noticeable.  It feels right");
				if (player.cor + player.lib < 60) outputText(" to have such a splendid tool.  You idly daydream about cunts and pussies, your " + Appearance.cockNoun(CockTypesEnum.HORSE) + " plowing them relentlessly, stuffing them pregnant with cum");
				if (player.cor + player.lib >= 60 && player.cor + player.lib < 100) outputText(" to be this way... You breath the powerful animalistic scent and fantasize about fucking centaurs night and day until their bellies slosh with your cum");
				if (player.cor + player.lib >= 100 && player.cor + player.lib <= 175) outputText(" to be a rutting stud.  You ache to find a mare or centaur to breed with.  Longing to spend your evenings plunging a " + Appearance.cockNoun(CockTypesEnum.KIRIN) + " deep into their musky passages, dumping load after load of your thick animal-cum into them.  You'd be happy just fucking horsecunts morning, noon, and night.  Maybe somewhere there is a farm needing a breeder..");
				if (player.cor + player.lib > 175){
					outputText(" to whinny loudly like a rutting stallion.  Your " + Appearance.cockNoun(CockTypesEnum.KIRIN) + " is perfect for fucking centaurs and mares." +
							" You imagine the feel of plowing an equine pussy deeply, bottoming out and unloading sticky jets of kirin plasma into its fertile womb.");
					if (!player.isTaur()) outputText(" Your hand strokes your horsecock of its own accord, musky pre dripping from the flared tip with each stroke.");
					else outputText(" Your flared tip begins dripping large amount of plasma as arousal overtake your member.");
					outputText(" Your mind wanders to the thought of you with a harem of pregnant centaurs");
				}
				outputText(".");
				if (player.cor < 30) outputText("  You shudder in revulsion at the strange thoughts and vow to control yourself better.");
				if (player.cor >= 30 && player.cor < 60) outputText("  You wonder why you thought such odd things, but they have a certain appeal.");
				if (player.cor >= 60 && player.cor < 90) outputText("  You relish your twisted fantasies, hoping to dream of them again.");
				if (player.cor >= 90) outputText("  You flush hotly and give a twisted smile, resolving to find a fitting subject to rape and relive your fantasies.");
				dynStats("lus", 10, "scale", false);
				player.MutagenBonus("lib", 1);
			}
			//Chance of ball growth if not 3" yet
			if (rand(2) == 0 && changes < changeLimit && player.ballSize <= 3 && player.kirinCocks() > 0) {
				if (player.balls == 0) {
					player.balls = 2;
					player.ballSize = 1;
					outputText("\n\nA nauseating pressure forms just under the base of your maleness.  With agonizing pain the flesh bulges and distends, pushing out a rounded lump of flesh that you recognize as a testicle!  A moment later relief overwhelms you as the second drops into your newly formed sack.");
					dynStats("lus", 5, "scale", false);
					player.MutagenBonus("lib", 2);
					Metamorph.unlockMetamorphEx(BallsMem.getMemory(BallsMem.DUO));
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
		if (player.hasVagina() && player.vaginaType() != VaginaClass.KIRIN && changes < changeLimit && rand(3) == 0) {
			CoC.instance.transformations.VaginaKirin().applyEffect();
		}
		//classic horse-taur version
		if (changes < changeLimit && rand(2) == 0 && player.lowerBody != LowerBody.KIRIN && player.lowerBody != LowerBody.GARGOYLE && !player.isTaur()) {
			outputText("\n\n");
			CoC.instance.transformations.LowerBodyKirin(4).applyEffect();
			changes++;
			player.MutagenBonus("spe", 3);
		}
		//Horse tail
		if (player.lowerBody == LowerBody.KIRIN && player.tailType != Tail.GARGOYLE && player.tailType != Tail.KIRIN && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.TailKirin.applyEffect();
			changes++;
		}
		//Human skin
		if (!player.hasPartialCoat(Skin.DRAGON_SCALES) && !player.isGargoyle() && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			var scaleColor: String = player.coatColor;
			if (!InCollection(player.coatColor, KirinRace.KirinScaleColors)) scaleColor = randomChoice(KirinRace.KirinScaleColors);
			CoC.instance.transformations.SkinDragonScales(Skin.COVERAGE_LOW, {color: scaleColor}).applyEffect();
			changes++;
		}
		//-Remove feather-arms (copy this for goblin ale, mino blood, equinum, centaurinum, canine pepps, demon items)
		if (changes < changeLimit && !InCollection(player.arms.type, Arms.LIZARD, Arms.GARGOYLE) && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.ArmsLizard.applyEffect();
			changes++;
		}
		//Human ears
		if (player.ears.type != Ears.KIRIN && player.ears.type != Ears.HUMAN && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.EarsHuman.applyEffect();
			changes++;
		}
		if (player.ears.type != Ears.KIRIN && player.ears.type == Ears.HUMAN && player.tailType != Tail.GARGOYLE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.EarsKirin.applyEffect();
			changes++;
		}
		//Human face
		if (player.faceType != Face.HUMAN && changes < changeLimit && rand(3) == 0) {
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
		if (!player.skin.hasLightningShapedTattoo() && rand(3) == 0 && changes < changeLimit) {
			outputText("[pg]");
			CoC.instance.transformations.SkinPatternRaiju.applyEffect();
			changes++;
		}
		//New horns or expanding unicorn/alicorn horns
		if (player.horns.type == Horns.KIRIN || player.horns.type == Horns.NONE) {
			//Get bigger if player has horns
			if (player.horns.type == Horns.KIRIN) {
				{
					temp = 1 + rand(3);
					player.horns.count += temp;
					if (temp == 0) changes--;
					if (temp == 1) outputText("\n\nAn aching pressure builds in your temples as you feel your horns push another inch of length from your skull. ");
					if (temp == 2) outputText("\n\nA powerful headache momentarily doubles you over.  With painful slowness, you feel your horns push another two inches of length out from your brow, gradually thickening as it grows.  ");
					if (temp == 3) outputText("\n\nAgony overwhelms you as a headache of terrifying intensity sweeps through your skull.  You squeeze your eyes shut from the pain, but it does little to help.  The torture intensifies before finally diminishing as you feel an inch or two of new horns force its way out of your forehead.  The headache remains despite this, and desperate for relief, you grab hold of your horns and tug, pulling another inch of new horns free.  At last the pain fades, leaving you with significantly enhanced head-spike.  ");
					if (player.horns.count < 3) outputText("It is the size of a tiny nub.");
					if (player.horns.count >= 3 && player.horns.count < 6) outputText("It is similar to what you would see on a young unicorn.");
					if (player.horns.count >= 6 && player.horns.count < 12) outputText("It look like the horn on a grown kirin, big enough and dangerous enough to do some damage.");
					if (player.horns.count >= 12 && player.horns.count < 20) outputText("It is large and wicked looking.");
					if (player.horns.count >= 20) outputText("It is a large, pointed and spiraling horn.");
					changes++;
				}
			}
			//If no horns yet..
			else {
				outputText("\n\n");
				CoC.instance.transformations.HornsKirin.applyEffect();
				changes++;
			}
		}
		//Gain Dragon Tongue
		if (changes < changeLimit && rand(3) == 0 && player.tongue.type != Tongue.DRACONIC) {
			outputText("[pg]");
			CoC.instance.transformations.TongueDraconic.applyEffect();
			changes++;
			//Note: This type of tongue should be eligible for all things you can do with demon tongue... Dunno if it's best attaching a boolean just to change the description or creating a whole new tongue type.
		}
		if (!InCollection(player.hairColor, KirinRace.KirinHairColors) && changes < changeLimit && rand(3) == 0) {
			player.hairColor = randomChoice(KirinRace.KirinHairColors);
			outputText("[pg]Your hair stands up on end as bolts of lightning run through each strand, changing them to a <b>[haircolor] color!</b>");
		}
		if (InCollection(player.hairColor, KirinRace.KirinHairColors) && CoC.instance.transformations.HairStorm.isPossible() && changes < changeLimit && rand(4) == 0) {
			outputText("[pg]");
			CoC.instance.transformations.HairStorm.applyEffect();
			changes++;
		}
		if (player.hairType != 4 && player.hairLength < 26 && changes < changeLimit && rand(4) == 0) {
			temp2 += 1 + rand(3);
			outputText("[pg]Your hair tingles as it grows longer, adding " + temp2 + " inches of length to your scalp.");
			player.hairLength += temp2;
			changes++;
		}
		if (player.wings.type != Wings.THUNDEROUS_AURA && player.wings.type > Wings.NONE && changes < changeLimit && rand(3) == 0) {
			outputText("[pg]");
			CoC.instance.transformations.WingsNone.applyEffect();
			changes++;
		}
		if (player.rearBody.type == RearBody.RAIJU_MANE && player.wings.type == Wings.NONE && changes < changeLimit && rand(3) == 0) {
			outputText("[pg]");
			CoC.instance.transformations.WingsThunderousAura.applyEffect();
			changes++;
		}
		if (player.tailType == Tail.KIRIN && player.rearBody.type != RearBody.RAIJU_MANE && changes < changeLimit && rand(3) == 0) {
			outputText("[pg]");
			CoC.instance.transformations.RearBodyRaijuMane.applyEffect();
			changes++;
		}
		if ((CoC.instance.transformations.EyesDraconic.isPossible() || CoC.instance.transformations.EyesKirinColors.isPossible()) && changes < changeLimit && rand(3) == 0) {
			outputText("[pg]");
			if (CoC.instance.transformations.EyesKirinColors.isPossible()) CoC.instance.transformations.EyesKirinColors.applyEffect();
			if (CoC.instance.transformations.EyesDraconic.isPossible()) CoC.instance.transformations.EyesDraconic.applyEffect();
			changes++;
		}
		//Physical changes:
		//Nipples Start Glowing:
		if (CoC.instance.transformations.AssholeGlowing.isPossible() && rand(4) == 0 && changes < changeLimit) {
			CoC.instance.transformations.AssholeGlowing.applyEffect();
			changes++;
		}
		//Nipples Start Glowing:
		if (CoC.instance.transformations.NipplesGlowing.isPossible() && rand(4) == 0 && changes < changeLimit) {
			CoC.instance.transformations.NipplesGlowing.applyEffect();
			changes++;
		}
		//Nipples Turn Back:
		if (player.hasStatusEffect(StatusEffects.BlackNipples) && changes < changeLimit && rand(3) == 0) {
			CoC.instance.transformations.NipplesNoColor.applyEffect();
			changes++;
		}
		//Asshole Start Glowing:
		if (CoC.instance.transformations.AssholeGlowing.isPossible() && rand(4) == 0 && changes < changeLimit) {
			CoC.instance.transformations.AssholeGlowing.applyEffect();
			changes++;
		}
		player.refillHunger(10);
		return false;
	}
}
}
