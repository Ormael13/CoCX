/**
 * Coded by Liadri 2020-04-01.
 */
package classes.Items.Consumables {
import classes.Appearance;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.BodyPart;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.EngineCore;
import classes.Items.Consumable;
import classes.PerkLib;

public class CentipedeVenom extends Consumable {
	public function CentipedeVenom() {
		super("C.Venom", "C.Venom", "a vial of centipede venom", 50, "A small thin vial filled with a clear liquid produced by centipedes. If consumed, it may have a strange effect on you.");
	}

	override public function useItem():Boolean {
		var changes:Number = 0;
		var changeLimit:Number = 1;
		if (rand(3) == 0) changeLimit++;
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
		player.slimeFeed();
		clearOutput();
		outputText("You pop the cork on the vial and quickly chug the clear liquid. It tastes somewhat sweet, leaving your body feeling warm all over.");

		//Transformation effect list
		if (changeLimit && rand(3) == 0) {
			outputText("\n\nYou shudder as a strange warmth briefly spreads through you. The venom lingers on your tastebuds leaving behind a tingling sensation and lingering pleasure.");
			dynStats("lus", (10+player.lib/10), "scale", false);
			changes++;
		}

		if (player.spe < 80 && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYou suddenly jerk forward, feeling somewhat twitchy. Surprised, you didn't know you could react so quickly.");
			dynStats("spe", 1);
			changes++;
		}
		//end of stat change list and starts of body changes
		if (player.hasPerk(PerkLib.TransformationImmunity) || player.hasPerk(PerkLib.Undeath)) changeLimit = 0;

		//Physical changes
		//Legs
		if (player.lowerBody != LowerBody.CENTIPEDE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			if (player.lowerBody != LowerBody.HUMAN) outputText("You watch, spellbound, while your legs gradually change its entire outer structure back into a plain human-like form. ");
			outputText("Pain shoots through your legs as you stumble to the ground. You can feel the bones in your legs fuse and reshape themselves as they become longer. " +
					"As the initial pain passes you manage to sit up and look at what happened to you. To your shock or maybe even horror, in place of legs you now have the long, segmented, insectoid body of a centipede. " +
					"It's easily three times the length as you are tall. Each segment has a pair of pointed spindly legs which will make walking interesting to say the least. " +
					"At the very end of your insectoid body sits a pair of longer legs that appear to be a set of stingers. You get up to try out your new body. " +
					"At first you nearly face plant into the ground as you attempt to coordinate your many legs all at once. " +
					"After some practice you're able to move your new legs in sync and independently with little issue, even enjoying the feeling of curling into yourself. " +
					"<b>You think you'll have some fun with this new centipede body.</b>");
			mutations.setLowerBody(LowerBody.CENTIPEDE);
			player.legCount = 100;
			changes++;
		}
		//Arms
		if (player.arms.type != Arms.HUMAN && changes < changeLimit && rand(3) == 0) {
			mutations.humanizeArms();
			changes++;
		}
		//Antenna
		if (player.antennae.type != Antennae.CENTIPEDE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYour head itches momentarily as two long antennae sprout from atop your forehead. You can move both independently as if they're an extension of you.");
			mutations.setAntennae(Antennae.CENTIPEDE);
			changes++;
		}
		//Ears
		if (player.ears.type != Ears.ELFIN && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nA weird tingling runs through your scalp as your [hair] shifts slightly.  You reach up to touch and bump <b>your new pointed elfin ears</b>.  You bet they look cute!");
			mutations.setEarType(Ears.ELFIN);
			changes++;
		}
		//Face
		if ((player.faceType != Face.ANIMAL_TOOTHS) && changes < changeLimit && rand(3) == 0) {
			if (player.faceType != Face.HUMAN) {
				mutations.humanizeFace();
			}
			outputText("\n\nYou feel your some of your tooths changing, elongating into sharper dagger like form. Funnily, your face remained fully human even after the change. " +
					"<b>Your mouth is now a cross over between animal and human!</b>");
			mutations.setFaceType(Face.ANIMAL_TOOTHS);
			changes++;
		}
		//NeckMaxilipeds
		if (player.lowerBody == LowerBody.CENTIPEDE && player.rearBody.type != RearBody.CENTIPEDE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYour neck tingles and begins to itch all of a sudden. You reach up to scratch when your fingers brush up against something hard. " +
					"You look down to find a pair of grasping pincer like stingers around your neck. They open and close at will and tuck away easily when not in use. " +
					"<b>It will be easier to hold onto and bite enemies with your new maxillipeds.</b>");
			mutations.setRearBody(RearBody.CENTIPEDE);
			changes++;
		}
		//Venom Increase TEMPORARY
		//if (changes < changeLimit && player.lowerBody == LowerBody.CENTIPEDE && player.tailRecharge < 15 && rand(2) == 0){
		//if (player.tailRecharge < 5) player.tailRecharge += 2;
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
