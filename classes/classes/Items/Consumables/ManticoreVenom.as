/**
 * Coded by aimozg on 01.06.2017.
 */
package classes.Items.Consumables {
import classes.Appearance;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.Items.Consumable;
import classes.PerkLib;
import classes.VaginaClass;
import classes.CoC;

public class ManticoreVenom extends Consumable {
	public function ManticoreVenom() {
		super("ManticV", "MantiVen", "a vial of manticore venom", 50, "This vial contains a clear green liquid, reminding you of some toxic liquids used back in ignam to kill vermin. Ingesting poison directly might not be the smartest idea. Who knows what it could do to you?");
	}

	override public function useItem():Boolean {
		var changes:Number = 0;
		var changeLimit:Number = 1;
		if (rand(3) == 0) changeLimit++;
		changeLimit += player.additionalTransformationChances;
		player.slimeFeed();
		clearOutput();
		outputText("You guzzle down the vial and your lust immediately spikes up, making you spontaneously orgasm. Your body seems to react strangely to the poison however.");
		if (changes < changeLimit && rand(2) == 0 && player.MutagenBonus("spe", 1)) {
			outputText("\n\nFeeling energetic you suddenly make a dash for the nearest tree and realize you're way faster than before.");
			changes++;
		}
		if (changes < changeLimit && rand(2) == 0 && player.MutagenBonus("int", 1)) {
			outputText("\n\nYou can't help but think about the various ways you will ambush and thoroughly rape your foes. That terrorised look on their face will be priceless.");
			changes++;
		}
		if (changes < changeLimit && rand(2) == 0) {
			outputText("\n\nYou suddenly became exceedingly aware of your surroundings, feeling the caress of the wind on your skin and especially its passage next to your endowment. You make a musical note of delighted pleasure at it.");
			player.addCurse("sen", 2,1);
			changes++;
		}
		if (player.cor < 100 && changes < changeLimit && rand(2) == 0) {
			outputText("\n\nYou daydream about your next victim. How will this one look as you take him? Various deliciously obscene designs play in your mind as you plan how you will torment whatever falls prey to you.");
			if (player.cor < 50) outputText(" You suddenly realize what you're doing and shake your head, trying to clear your mind, disgusted with yourself.");
			else outputText(" You idly start fingering yourself as you keep imagining the various tortures you will inflict on the cumpumps that are your victims. Seeing yourself drinking their cum as they beg you to stop. You almost orgasm at the thought of it, however, you're brought back to reality as your knees hit the ground.");
			dynStats("cor", 1);
			changes++;
		}
		if (player.blockingBodyTransformations()) changeLimit = 0;
		//Sexual changed
		if (player.gender == 2 || (player.gender == 3 && player.mf("m", "f") == "f")) {
			var boobsGrew:Boolean = false;
			if (player.biggestTitSize() <= 5 && changes < changeLimit && rand(3) == 0) {
				if (rand(2) == 0) outputText("\n\nYour [breasts] tingle for a moment before becoming larger.");
				else outputText("\n\nYou feel a little weight added to your chest as your [breasts] seem to inflate and settle in a larger size.");
				player.growTits(1 + rand(3), 1, false, 3);
				changes++;
				player.addCurse("sen", 2,1);
				boobsGrew = true;
			}
		}
		if (player.hasVagina() && player.sens > 20 && player.vaginaType() != VaginaClass.MANTICORE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYou suddenly became exceedingly aware of your surroundings, feeling the caress of the wind on your skin and especially its passage next to your endowment. " +
					"Out of curiosity you slid a single digit inside your pussy to test your new sensitiveness and yelp a sound note unlike a singing. " +
					"Your pussy has reached the sensitiveness of a manticore and the mere act of touching it will now cause you to moan an entire partition!" +
					"<b>Your ultrasensitive pussy is now exactly like that of a manticore!</b>");
			player.addCurse("sen", 20,1);
			player.vaginaType(VaginaClass.MANTICORE);
			changes++;
		}
		//Physical changes
		//Legs
		if (player.lowerBody != LowerBody.LION && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.LowerBodyLion(2).applyEffect();
			changes++;
		}
		//Arms
		if (player.lowerBody == LowerBody.LION && !InCollection(player.arms.type, Arms.GARGOYLE, Arms.LION) && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.ArmsLion.applyEffect();
			changes++;
		}
		//Scorpion tail
		if (player.arms.type == Arms.LION && changes < changeLimit && player.tailType != Tail.GARGOYLE && player.tailType != Tail.SCORPION && player.tailType != Tail.MANTICORE_PUSSYTAIL && rand(2) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.TailScorpion.applyEffect();
			changes++;
		}
		//PussyTail (only females)
		if ((player.gender == 2 || (player.gender == 3 && player.mf("m", "f") == "f")) && player.tailType == Tail.SCORPION && changes < changeLimit && player.tailType != Tail.MANTICORE_PUSSYTAIL && rand(2) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.TailManticore.applyEffect();
			changes++;
		}
		//Wings
		if ((player.tailType == Tail.SCORPION || player.tailType == Tail.MANTICORE_PUSSYTAIL) && player.wings.type != Wings.MANTICORE_LARGE && player.wings.type != Wings.GARGOYLE_LIKE_LARGE && changes < changeLimit && rand(4) == 0) {
			//Grow bigger manticore wings!
			if (player.wings.type == Wings.MANTICORE_SMALL) {
				outputText("\n\n");
        CoC.instance.transformations.WingsManticoreLarge.applyEffect();
			}
			//Grow small manticore wings if player has none.
			else if (player.wings.type == Wings.NONE) {
				outputText("\n\n");
        CoC.instance.transformations.WingsManticoreSmall.applyEffect();
			}
			//Remove old wings
			else {
				outputText("\n\n");
				CoC.instance.transformations.WingsNone.applyEffect();
			}
			changes++;
		}
		//Back(Rear) body
		if ((player.wings.type == Wings.MANTICORE_SMALL || player.wings.type == Wings.MANTICORE_LARGE) && player.rearBody.type != RearBody.LION_MANE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
      CoC.instance.transformations.RearBodyLionMane.applyEffect();
      changes++;
		}
		//Ears
		if (player.rearBody.type == RearBody.LION_MANE && player.ears.type == Ears.HUMAN && player.ears.type != Ears.LION && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.EarsLion.applyEffect();
			changes++;
		}
		if (player.rearBody.type == RearBody.LION_MANE && player.ears.type != Ears.HUMAN && player.ears.type != Ears.LION && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.EarsHuman.applyEffect();
			changes++;
		}
		//Face
		if (player.ears.type == Ears.LION && player.faceType != Face.MANTICORE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
      CoC.instance.transformations.FaceManticore.applyEffect();
			changes++;
		}
		//Eyes
		if (player.faceType == Face.MANTICORE && player.eyes.type != Eyes.MANTICORE && changes < changeLimit && rand(3) == 0) {
			CoC.instance.transformations.EyesManticore.applyEffect();
			changes++;
		}
		//Cat tounge
		if (player.faceType == Face.MANTICORE && player.tongue.type != Tongue.CAT && rand(3) == 0 && changes < changeLimit) {
			outputText("\n\n");
			CoC.instance.transformations.TongueCat.applyEffect();
			changes++;
		}
		//Venom Increase
		if (changes < changeLimit && player.tailType == Tail.MANTICORE_PUSSYTAIL && player.tailRecharge < 20 && rand(2) == 0) {
			if (player.tailRecharge < 10) player.tailRecharge += 2;
			if (player.tailRecharge < 15) player.tailRecharge += 2;
			if (player.tailRecharge < 20) player.tailRecharge += 2;
			player.tailVenom += 50;
			if (player.tailVenom > player.maxVenom()) player.tailVenom = player.maxVenom();
			outputText("\n\nYou feel your tail jolt with increased vitality as it starts producing venom in larger quantities. You smile wickedly at the idea of injecting this cocktail into someone.");
			changes++;
		}
		return false;
	}
}
}
