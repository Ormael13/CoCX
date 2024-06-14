package classes.Items.Consumables
{
import classes.Items.*;
import classes.BodyParts.Ears;
import classes.BodyParts.Face;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.CoC;
import classes.CockTypesEnum;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;
import classes.VaginaClass;

/**
 * Golden Rind/Deer TF, part of the Wild Hunt by Frogapus
 * @author Kitteh6660
 */
	public class GoldenRind extends Consumable
	{
		
		public function GoldenRind()
		{
			super("GldRind", "GoldenRind", "a golden rind", ConsumableLib.DEFAULT_VALUE, "This shimmering, citrus peel is shaped like a corkscrew and smells sweet and sour at the same time.");
			withTag(U_TF);
			refineableInto(
					AlchemyLib.DEFAULT_SUBSTANCES_DROP_TABLE,
					AlchemyLib.MULTIRACE_ESSENCE_DROP_TABLE(AlchemyLib.AE_DEER)
			)
		}
		
		public override function useItem():Boolean {
			var changes:int = 0;
			var changeLimit:int = 2;
			if (rand(2) == 0) changeLimit++;
			if (rand(3) == 0) changeLimit++;
			changeLimit += player.additionalTransformationChances;
			outputText("You pop the sliver of fruit in your mouth, delighting in the sweetness and tanginess as you chew it.  A burst of lime-like tartness slaps your senses, and you feel an answering tingle further down in your body.");
			// Stat TFs
			//Increase strength
			if (rand(3) == 0 && player.MutagenBonus("str", 1 + rand(2))) {
				outputText("[pg]A painful ripple passes through the muscles of your body.  It takes you a few moments, but you quickly realize you're a little bit stronger now.");
				changes++;
			}
			//Increase toughness
			if (changes < changeLimit && rand(3) == 0 && player.MutagenBonus("tou", 4)) {
				if (player.tou < 50)
					outputText("[pg]Your body and skin both thicken noticeably.  You pinch your [skin.type] experimentally and marvel at how much tougher your hide has gotten.");
				else if (player.tou < 100)
					outputText("[pg]You grin as you feel your form getting a little more solid.  It seems like your whole body is toughening up quite nicely, and by the time the sensation goes away, you feel ready to take a hit.");
				else
					outputText("[pg]You snarl happily as you feel yourself getting even tougher.  It's a barely discernible difference, but you can feel your [skin.type] getting tough enough to make you feel invincible.");
				changes++;
			}
			//Increase Speed
			if (rand(2) == 0 && player.MutagenBonus("spe", 1 + rand(3))) {
				changes++;
				outputText("[pg]Shivering without warning, you nearly trip over yourself as you walk.  A few tries later you realize your muscles have become faster.");
			}
			//Decrease intellect
			if (player.inte > 40 && rand(3) == 0 && changes < changeLimit) {
				player.addCurse("int", (1 + rand(3)), 1);
				changes++;
				outputText("[pg]You shake your head and struggle to gather your thoughts, feeling a bit slow.");
			}
			//Increase Wisdom
			if (rand(2) == 0 && changes < changeLimit && player.MutagenBonus("wis", 1)) {
				outputText("[pg]You feel a tremendous rush of mental celerity, as if your mind were clear of all doubt.");
				changes++;
			}
			if (player.blockingBodyTransformations()) changeLimit = 0;
			// Main TFs
			//------------
			//Gain deer ears
            if (rand(3) == 0 && changes < changeLimit && player.ears.type != Ears.DEER) {
				outputText("[pg]")
				CoC.instance.transformations.EarsDeer.applyEffect();
				changes++;
			}
			//Gain deer tail
			if (rand(3) == 0 && changes < changeLimit && player.ears.type == Ears.DEER && player.tailType != Tail.DEER) {
				CoC.instance.transformations.TailDeer.applyEffect();
				changes++;
			}
			//Gain deer horns AKA antlers
			if (rand(3) == 0 && changes < changeLimit && player.horns.type == Horns.NONE) {
				outputText("\n\nYou feel an immense pressure from your forehead, and you reach up, feeling the nubs of two new horns.");
				CoC.instance.transformations.HornsAntlers.applyEffect(false);
				player.horns.count = 1;
				changes++;
			}
			if (rand(3) == 0 && changes < changeLimit && player.horns.count > 0 && player.horns.type != Horns.ANTLERS && player.horns.type != Horns.ORCHID) {
				outputText("\n\nYou feel a strange twisting sensation from your horns as they extend outwards.  You reach up to feel them and realize that you’ve now got <b>pronged, stag-like horns.</b>");
				CoC.instance.transformations.HornsAntlers.applyEffect(false);
				player.horns.count = 4;
				changes++;
			}
			//Increase points on deer antlers
			if (rand(3) == 0 && changes < changeLimit && player.horns.type == Horns.ANTLERS && player.horns.count < 34) {
				outputText("\n\nYou feel a strange twisting sensation from your antlers as they extend and split outwards.  You reach up to feel them and realize that your antlers are now even more branched out.");
				if (player.horns.count < 20 && rand(2) == 0) player.horns.count += (1 + rand(4));
				player.horns.count++;
				outputText("  After counting the number of points you have on your antlers, <b>you have " + player.horns.count + " points.</b>");
				if (player.horns.count >= 34) outputText("<b>  It seems that your antlers can't get any more pointier.</b>");
				changes++;
			}
			//Gain fur
			if (rand(3) == 0 && changes < changeLimit && player.horns.count > 0 && player.lowerBody != LowerBody.GARGOYLE && !player.hasFullCoatOfType(Skin.FUR)) {
				outputText("\n\nFor a moment, it looks like a ray of sunlight has shimmered through the canopy. You blink and realize that your fur has become dappled, with lighter, sun-speckled spots highlighting it.");
				CoC.instance.transformations.SkinFur(Skin.COVERAGE_COMPLETE, {color:"brown"}).applyEffect(false);
				changes++;
			}
			//Change face to normal
			if (rand(3) == 0 && changes < changeLimit && player.ears.type == Ears.DEER && (player.faceType != Face.HUMAN && player.faceType != Face.DEER)) {
				outputText("\n\nYour face grows warm as suddenly your vision is engulfed in smoke, coughing and beating the smoke back you noticed a marked change in your features. Touching yourself you confirm you have a <b>normal human shaped face once again</b>.");
				CoC.instance.transformations.FaceHuman.applyEffect(false);
				changes++;
			}
			//Gain deer face
			if (rand(3) == 0 && changes < changeLimit && player.isFurCovered() && player.ears.type == Ears.DEER && player.tailType == Tail.DEER && player.faceType != Face.DEER) {
				outputText("\n\n");
				CoC.instance.transformations.FaceDeer.applyEffect();
				changes++;
			}
			//Change legs to cloven hooves
			if (rand(3) == 0 && changes < changeLimit && player.ears.type == Ears.DEER && player.tailType == Tail.DEER && player.isFurCovered() && (player.lowerBody != LowerBody.DEERTAUR && player.lowerBody != LowerBody.CLOVEN_HOOFED)) {
				if (player.lowerBody == LowerBody.HOOFED) {
					outputText("\n\nYou feel a sharp stinging sensation from your hooves, accompanied by a loud CRACK.  You look down in alarm, prancing from one hooved foot to another, realizing that your solid, heavy hooves have been replaced with delicate, cloven hooves.  You squint, also noting a subtle thinness across your legs in general--if you had to guess, you’d hazard that you’re looking <b>more deer-like than horse-like</b>.");
				}
				else {
					outputText("\n\nYou feel a strange tightness from your feet and nearly topple over as your balance shifts.  You’re balancing on your toes for some reason.  You look down in amazement as your legs slim and lengthen, your feet elongating and darkening at the ends until you’re balancing on <b>two, graceful deer legs</b>.");
				}
				if (player.isTaur()) player.lowerBody = LowerBody.DEERTAUR;
				else CoC.instance.transformations.LowerBodyClovenHoofed(2).applyEffect(false);
				changes++;
			}
			//Change arms to deer
			if (rand(3) == 0 && changes < changeLimit && player.isFurCovered() && player.tailType == Tail.DEER && (player.lowerBody != LowerBody.DEERTAUR && player.lowerBody != LowerBody.CLOVEN_HOOFED)) {
				outputText("\n\n");
				CoC.instance.transformations.ArmsDeer.applyEffect();
				changes++;
			}
			// Genital Changes
			//------------
			//Morph dick to horsediiiiick
			if (rand(3) == 0 && changes < changeLimit && player.cocks.length > 0) {
				var selectedCockValue:int = player.findFirstCockNotInType([CockTypesEnum.HORSE]);
				if (selectedCockValue != -1) {
					CoC.instance.transformations.CockHorse(selectedCockValue).applyEffect();
					player.growCock(selectedCockValue, 4);
					dynStats("lus", 35, "scale", false);
					player.addCurse("spe", 4,1);
					player.MutagenBonus("lib", 5);
					changes++;
				}
			}
			if (player.hasVagina() && player.vaginaType() != VaginaClass.EQUINE && changes < changeLimit && rand(3) == 0) {
				CoC.instance.transformations.VaginaHorse().applyEffect();
			}
			// Body thickness/tone changes
			//------------
			if (rand(3) == 0 && player.tone > 20) {
				if (player.tone > 50) player.modTone(20, 2 + rand(3));
				else player.modTone(20, 2);
			}
			if (rand(3) == 0 && player.thickness > 20) {
				if (player.thickness > 50) player.modThickness(20, 2 + rand(3));
				else player.modThickness(20, 2);
			}
			flags[kFLAGS.TIMES_TRANSFORMED] += changes;
			player.refillHunger(10);
            return false;
		}
	}

}
