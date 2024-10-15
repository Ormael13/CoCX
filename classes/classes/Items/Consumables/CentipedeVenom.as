/**
 * Coded by Liadri 2020-04-01.
 */
package classes.Items.Consumables {
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.CoC;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;

public class CentipedeVenom extends Consumable {
	public function CentipedeVenom() {
		super("C.Venom", "C.Venom", "a vial of centipede venom", 50, "A small thin vial filled with a clear liquid produced by centipedes. If consumed, it may have a strange effect on you.");
		withTag(U_TF);
		refineableInto(
				AlchemyLib.DEFAULT_SUBSTANCES_DROP_TABLE,
				AlchemyLib.MULTIRACE_ESSENCE_DROP_TABLE(
						AlchemyLib.AE_CENTIPEDE,
						AlchemyLib.AE_OOMUKADE
				)
		)
	}

	override public function useItem():Boolean {
		var changes:Number = 0;
		var changeLimit:Number = 2;
		if (rand(2) == 0) changeLimit++;
		changeLimit += player.additionalTransformationChances;
		player.slimeFeed();
		clearOutput();
		outputText("You pop the cork on the vial and quickly chug the clear liquid. It tastes somewhat sweet, leaving your body feeling warm all over.");

		//Transformation effect list
		if (changeLimit && rand(3) == 0) {
			outputText("\n\nYou shudder as a strange warmth briefly spreads through you. The venom lingers on your tastebuds, leaving behind a tingling sensation and lingering pleasure.");
			dynStats("lus", (10+player.lib/10), "scale", false);
			changes++;
		}
		if (changes < changeLimit && rand(3) == 0 && player.MutagenBonus("spe", 1)) {
			outputText("\n\nYou suddenly jerk forward, feeling somewhat twitchy. Surprised, you didn't know you could react so quickly.");
			changes++;
		}
		//end of stat change list and starts of body changes
		if (player.blockingBodyTransformations()) changeLimit = 0;
		//Physical changes
		//Legs
		if (player.lowerBody != LowerBody.CENTIPEDE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.LowerBodyCentipede.applyEffect();
			changes++;
		}
		//Arms
		if (player.arms.type != Arms.HUMAN && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.ArmsHuman.applyEffect();
			changes++;
		}
		//Antenna
		if (player.antennae.type != Antennae.CENTIPEDE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.AntennaeCentipede.applyEffect();
			changes++;
		}
		//Ears
		if (player.ears.type != Ears.ELFIN && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.EarsElfin.applyEffect();
			changes++;
		}
		//Face
		if ((player.faceType != Face.ANIMAL_TOOTHS) && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.FaceAnimalTeeth.applyEffect();
			changes++;
		}
		//NeckMaxilipeds
		if (player.lowerBody == LowerBody.CENTIPEDE && player.rearBody.type != RearBody.CENTIPEDE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.RearBodyCentipede.applyEffect();
			changes++;
		}
		//Venom Increase TEMPORARY
		//if (changes < changeLimit && player.lowerBody == LowerBody.CENTIPEDE && player.tailRecharge < 15 && rand(2) == 0){
		//if (player.tailRecharge < 10) player.tailRecharge += 2;
		//if (player.tailRecharge < 15) player.tailRecharge += 2;
		//player.tailVenom += 50;
		//if (player.tailVenom > player.maxVenom()) player.tailVenom = player.maxVenom();
		//outputText("\n\nYou feel your tail jolt with increased vitality as it starts producing venom in larger quantities. " +
		//		"You smile wickedly at the idea of injecting this cocktail into someone.");
		//changes++;
		//}
		return false;
	}
}
}
