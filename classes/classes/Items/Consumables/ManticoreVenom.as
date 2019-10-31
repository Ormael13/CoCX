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

public class ManticoreVenom extends Consumable {
	public function ManticoreVenom() {
		super("ManticV", "MantiVen", "a vial of manticore venom", 50, "This vial contains a clear green liquid, reminding you of some toxic liquids used back in ignam to kill vermin. Ingesting poison directly might not be the smartest idea. Who knows what it could do to you?");
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
		outputText("You guzzle down the vial and your lust immediately spikes up, making you spontaneously orgasm. Your body seems to react strangely to the poison however.");
		if (player.spe < 80 && changes < changeLimit && rand(2) == 0) {
			outputText("\n\nFeeling energetic you suddenly make a dash for the nearest tree and realize you're way faster than before.");
			dynStats("spe", 1);
			changes++;
		}
		if (player.inte < 60 && changes < changeLimit && rand(2) == 0) {
			outputText("\n\nYou can't help but think about the various ways you will ambush and thoroughly rape your foes. That terrorised look on their face will be priceless.");
			dynStats("int", 1);
			changes++;
		}
		if (player.sens < 100 && changes < changeLimit && rand(2) == 0) {
			outputText("\n\nYou suddenly became exceedingly aware of your surroundings, feeling the caress of the wind on your skin and especially its passage next to your endowment. You make a musical note of delighted pleasure at it.");
			dynStats("sen", 2);
			changes++;
		}
		if (player.cor < 100 && changes < changeLimit && rand(2) == 0) {
			outputText("\n\nYou daydream about your next victim. How will this one look as you take him? Various deliciously obscene designs play in your mind as you plan how you will torment whatever falls prey to you.");
			if (player.cor < 50) outputText(" You suddenly realize what you're doing and shake your head, trying to clear your mind, disgusted with yourself.");
			else outputText(" You idly start fingering yourself as you keep imagining the various tortures you will inflict on the cumpumps that are your victims. Seeing yourself drinking their cum as they beg you to stop. You almost orgasm at the thought of it, however, you're brought back to reality as your knees hit the ground.");
			dynStats("cor", 1);
			changes++;
		}
		if (player.hasPerk(PerkLib.TransformationImmunity) || player.hasPerk(PerkLib.Undeath)) changeLimit = 0;
		//Sexual changed
		if (player.gender == 2 || (player.gender == 3 && player.mf("m", "f") == "f")) {
			var boobsGrew:Boolean = false;
			if (player.biggestTitSize() <= 5 && changes < changeLimit && rand(3) == 0) {
				if (rand(2) == 0) outputText("\n\nYour [breasts] tingle for a moment before becoming larger.");
				else outputText("\n\nYou feel a little weight added to your chest as your [breasts] seem to inflate and settle in a larger size.");
				player.growTits(1 + rand(3), 1, false, 3);
				changes++;
				dynStats("sen", .5);
				boobsGrew = true;
			}
		}
		//Physical changes
		//Legs
		if (player.lowerBody != LowerBody.LION && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			if (player.lowerBody != LowerBody.HUMAN) outputText("You watch, spellbound, while your legs gradually change its entire outer structure into a plain human-like form. ");
			outputText("Your legs suddenly shift painfully, forcing you down on all fours as the bones of your feet changes shape into something entirely different. You feel hairs growing at a rapid rate all over your legs. Something juts out of your toes as they clench into the ground. As you feel the pain recede you sit and take a look at your foot; or rather, your large leonine hind paws, now armed with sharp, retractable claws. <b>You now have leonine paws.</b>");
			mutations.setLowerBody(LowerBody.LION);
			player.legCount = 2;
			changes++;
		}
		//Arms
		if (player.lowerBody == LowerBody.LION && !InCollection(player.arms.type, Arms.GARGOYLE, Arms.LION) && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			if (player.arms.type != Arms.HUMAN) outputText("You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. ");
			outputText("Your hands suddenly start to hurt as your arms grow a thick coat of -fur color- fur up to your shoulders where it turns -hair color-. You watch, enthralled, as your nails fall off your fingers, feline claws taking their place on your now five-fingered paw-like hands. <b>You now have leonine paw hands.</b>");
			mutations.setArmType(Arms.LION);
			changes++;
		}
		//Scorpion tail
		if (player.arms.type == Arms.LION && changes < changeLimit && player.tailType != Tail.GARGOYLE && player.tailType != Tail.SCORPION && player.tailType != Tail.MANTICORE_PUSSYTAIL && rand(2) == 0) {
			if (player.tailType != Tail.NONE) outputText("\n\nPainful swelling just above your " + Appearance.buttDescription(player) + " doubles you over, and you hear the sound of your tail dropping off onto the ground!  Before you can consider the implications, the pain gets worse, and you feel your backside bulge outward sickeningly, cracking and popping as a segmented scorpion-like tail grows in place of your old one.  It grows large enough to be impossible to hide, and with a note of finality, your stinger slides free with an audible 'snick'.  <b>You have a scorpion tail.</b>");
			else outputText("\n\nPainful swelling just above your " + Appearance.buttDescription(player) + " doubles you over.  It gets worse and worse as the swollen lump begins to protrude from your backside, swelling and extending with a series of pops until you have a segmented tail hanging just above your butt.  The whole thing is covered in a hard chitinous material, and large enough to be impossible to hide.  You sigh as your stinger slides into place with a 'snick', finishing the transformation.  <b>You have a scorpion tail.</b>");
			mutations.setTailType(Tail.SCORPION);
			player.tailVenom = 15;
			player.tailRecharge = 3;
			changes++;
		}
		//PussyTail (only females)
		if ((player.gender == 2 || (player.gender == 3 && player.mf("m", "f") == "f")) && player.tailType == Tail.SCORPION && changes < changeLimit && player.tailType != Tail.MANTICORE_PUSSYTAIL && rand(2) == 0) {
			outputText("\n\nYour scorpion tail starts shifting as your stinger falls to the ground, leaving you with a wide hole at the tip of your tail. You have a feeling of emptiness in your tail, like if it was hollowed from the inside. The end of your tail where the stinger used to be suddenly explodes into a flower-like bulb of flesh. The petals open into what looks like the inside of a pussy, its folds moist and well lubricated. Right after the previous transformation’s finished, spikes start to grow out of the bulbous tip giving your tail tip the appearance of a spiked bulb. ");
			outputText("Flinging your tail randomly to test your new appendage you shoot one of them straight into a nearby tree. You idly wonder what it will feel like to milk men with this.  <b>It seems you've grown the tail of a manticore.</b>");
			mutations.setTailType(Tail.MANTICORE_PUSSYTAIL);
			changes++;
		}
		//Wings
		if ((player.tailType == Tail.SCORPION || player.tailType == Tail.MANTICORE_PUSSYTAIL) && player.wings.type != Wings.MANTICORE_LIKE_LARGE && player.wings.type != Wings.GARGOYLE_LIKE_LARGE && changes < changeLimit && rand(4) == 0) {
			//Grow bigger manticore wings!
			if (player.wings.type == Wings.MANTICORE_LIKE_SMALL) {
				outputText("\n\nYou feel your wings growing larger by the second. They keep growing until they reach three times their original size. The transformation finally stops as your wings reach a span of twice your arm’s length. These will be really useful should you want to fly around in search of a meal.  <b>You now have fully grown manticore wings.</b>");
				mutations.setWingType(Wings.MANTICORE_LIKE_LARGE, "large manticore-like");
			}
			//Grow small manticore wings if player has none.
			else if (player.wings.type == Wings.NONE) {
				outputText("\n\nYou scream something akin to a roar from the tremendous amount of pain you're suddenly experiencing as something starts to push out from your back. Your claws start digging large marks into the ground as the things stretch out and burst through your skin. Large bones covered in a thin, yet sturdy layer of skin, forming a pair of small bat-like wings slowly push out before finally staying in place. They are too small right now to allow you to take flight but they sure look good on you.  <b>You now have small manticore wings.</b>");
				mutations.setWingType(Wings.MANTICORE_LIKE_SMALL, "small manticore-like");
			}
			//Remove old wings
			else {
				mutations.removeWings();
			}
			changes++;
		}
		//Back(Rear) body
		if ((player.wings.type == Wings.MANTICORE_LIKE_SMALL || player.wings.type == Wings.MANTICORE_LIKE_LARGE) && player.rearBody.type != RearBody.LION_MANE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYou suddenly feel hair growing all around your neck at a crazy pace. It soon get so thick it almost looks as if you're wearing a [haircolor] fur collar. <b>You now have a full lion mane around your neck.</b>");
			mutations.setRearBody(RearBody.LION_MANE);
			changes++;
		}
		//Ears
		if (player.rearBody.type == RearBody.LION_MANE && player.ears.type == Ears.HUMAN && player.ears.type != Ears.LION && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYour ears suddenly stretch painfully, making you scream in pain as they move toward the top of your head, growing rounder and bigger. Putting your hands to your ears you discover they are now covered with a fair amount of dark fur. <b>You now have lion ears.</b>");
			mutations.setEarType(Ears.LION);
			changes++;
		}
		if (player.rearBody.type == RearBody.LION_MANE && player.ears.type != Ears.HUMAN && player.ears.type != Ears.LION && changes < changeLimit && rand(3) == 0) {
			mutations.humanizeEars();
			changes++;
		}
		//Face
		if (player.ears.type == Ears.LION && player.faceType != Face.MANTICORE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nY");
			if (player.faceType != Face.HUMAN) outputText("our face suddenly mold back into it’s former human shape. However you feel your canines changing, elongating into sharp, dagger-like teeth capable of causing severe injuries. Y");
			outputText("ou feel your canines changing, elongating into sharp, dagger-like teeth capable of causing severe injuries. Funnily, your face remained relatively human even after the change. You feel the need to roar like a lion, to show the world how ferocious you look. <b>Your mouth is now filled with dagger-like canines.</b>");
			mutations.setFaceType(Face.MANTICORE);
			changes++;
		}
		//Eyes
		if (player.faceType == Face.MANTICORE && player.eyes.type != Eyes.MANTICORE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nFor a moment your sight shifts as the ambient light suddenly turns extremely bright, almost blinding you. You walk around disoriented for a moment until the luminosity fades back to normal. You run to a puddle of water to check your reflection and quickly notice your pupils have become cat-like. While you do see way better in the dark, your now red iris are extremely intimidating and clearly don't belong on any normal feline. <b>You now have manticore eyes.</b>");
			mutations.setEyeTypeAndColor(Eyes.MANTICORE, "red");
			changes++;
		}
		//Cat tounge
		if (player.faceType == Face.MANTICORE && player.tongue.type != Tongue.CAT && rand(3) == 0 && changes < changeLimit) {
			outputText("\n\nYour tongue suddenly feels weird. You try to stick it out to see what’s going on and discover it changed to look similar to the tongue of a cat. At least you will be able to groom yourself properly with <b>your new cat tongue.</b>");
			mutations.setTongueType(Tongue.CAT);
			changes++;
		}
		//Venom Increase
		if (changes < changeLimit && player.tailType == Tail.MANTICORE_PUSSYTAIL && player.tailRecharge < 15 && rand(2) == 0) {
			if (player.tailRecharge < 5) player.tailRecharge += 2;
			if (player.tailRecharge < 10) player.tailRecharge += 2;
			if (player.tailRecharge < 15) player.tailRecharge += 2;
			player.tailVenom += 50;
			if (player.tailVenom > player.maxVenom()) player.tailVenom = player.maxVenom();
			outputText("\n\nYou feel your tail jolt with increased vitality as it starts producing venom in larger quantities. You smile wickedly at the idea of injecting this cocktail into someone.");
			changes++;
		}
		return false;
	}
}
}
