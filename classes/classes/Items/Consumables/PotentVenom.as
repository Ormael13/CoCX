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
import classes.CockTypesEnum;
import classes.EngineCore;
import classes.Items.Consumable;
import classes.PerkLib;
import classes.VaginaClass;

public class PotentVenom extends Consumable {
	public function PotentVenom() {
		super("P.Venom", "P.Venom", "a vial of potent venom", 50, "A small vial filled with a bubbling, dark purple liquid. Even though it's corked, you can still smell the sweet scent wafting from it and it feels unnaturally warm to the touch.");
	}

	override public function useItem():Boolean {
		var changes:Number = 0;
		var changeLimit:Number = 1;
		var temp2:Number = 0;
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
		if (changeLimit && rand(2) == 0) {
			outputText("\n\nYou shudder as a strange warmth briefly spreads through you. The venom lingers on your tastebuds leaving behind a tingling sensation and lingering pleasure.");
			dynStats("lus", (10+player.lib/10), "scale", false);
			changes++;
		}

		if (player.spe < 80 && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYou suddenly jerk forward, feeling somewhat twitchy. Surprised, you didn't know you could react so quickly.");
			dynStats("spe", 1);
			changes++;
		}

		if (player.tou < 80 && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYou feel oddly revitalized. You're so pumped that you feel that you can take on the strongest of enemies and even they would fail to even leave a scratch on you.");
			dynStats("tou", 5);
			changes++;
		}

		if (player.wis > 20 && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nSomehow everything around seems so much duller. The world around you just seems so much more bland and uneventful.\n");
			dynStats("wis", -5);
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
		if (player.arms.type != Arms.HUMAN && player.arms.type != Arms.CENTIPEDE && changes < changeLimit && rand(3) == 0) {
			mutations.humanizeArms();
			changes++;
		}
		if (player.arms.type != Arms.CENTIPEDE && player.arms.type == Arms.HUMAN && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYour arms feel strangely warm. You look down at them, noticing purple markings being etched into your skin. Your nails sharpen and take on the same purple hue. <b>You could do some serious damage with your sharp nails.</b>");
			mutations.setArmType(Arms.CENTIPEDE);
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
		//Eyes
		if (player.faceType == Face.ANIMAL_TOOTHS && player.eyes.type != Eyes.CENTIPEDE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYou feel a sudden wave of sadness come over you. You sulk, wanting to find some dank dark place to curl up and hide in. " +
					"If anyone saw you now they would wonder why you appear so downtrodden." +
					//"" + (EngineCore.silly() ? "You could really use a hug and a tub of ice cream right now.": "You could really use a hug and a tub of ice cream right now.") + "" +
					"[if (silly) You could really use a hug and a tub of ice cream right now.] " +
					"You vaguely register the feeling of your teeth sharpening. " +
					"<b>Though saddened you suppose you could leave someone with a nasty bite with your new sharp teeth.</b>");
			mutations.setEyeType(Eyes.CENTIPEDE);
			changes++;
		}
		//Tatoo
		if (player.eyes.type == Eyes.CENTIPEDE && !player.skin.hasVenomousMarking() && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYou feel an unusual warmth in your chest. You look down to see a purple blot form on your chest and then begin to spread out across your skin like brushstrokes. " +
					"It doesn't stop until your skin is covered in intricate purple designs. You can feel your venom pumping through them. " +
					"<b>Your skin is covered in venomous body markings.</b>");
			player.skin.base.pattern = Skin.PATTERN_VENOMOUS_MARKINGS;
			player.skin.base.adj = "lightning shaped tattooed";
			changes++;
		}
		//Tatoo
		if (player.eyes.type == Eyes.CENTIPEDE && !player.skin.hasVenomousMarking() && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYou feel an unusual warmth in your chest. You look down to see a purple blot form on your chest and then begin to spread out across your skin like brushstrokes. " +
					"It doesn't stop until your skin is covered in intricate purple designs. You can feel your venom pumping through them. " +
					"<b>Your skin is covered in venomous body markings.</b>");
			player.skin.base.pattern = Skin.PATTERN_VENOMOUS_MARKINGS;
			player.skin.base.adj = "venomous marking covered";
			changes++;
		}

		//Genitals changes
		if (player.skin.hasVenomousMarking() && changes < changeLimit && rand(3) == 0) {
			var playerhadmorethenonecock:Boolean = false;
			var playerhadabnormalVagina:Boolean = false;
			var playerhadasheath:Boolean = false;
			outputText("\n\nYou double over as an overwhelming heat pools in your groin ");
			if (player.hasVagina() && player.vaginaType() != VaginaClass.VENOM_DRIPPING && player.vaginaType() != VaginaClass.HUMAN){
				outputText("as your vagina returns back to a human one, at least in appearance.");
				playerhadabnormalVagina = true;
			}
			//Female area
			if (player.hasVagina() && !player.hasCock())
			{
				if (player.vaginaType() == VaginaClass.VENOM_DRIPPING)
				{
					if (playerhadabnormalVagina) outputText("You ");
					else outputText("and ");
					outputText("moan out as your pussy tingles and clenches, drooling venom. ");
				}
				else
				{
					if (playerhadabnormalVagina) outputText("You ");
					else outputText("and ");
					outputText("moan out as your pussy tingles and clenches, drooling a strange dark purple liquid. ");
					player.vaginaType(7);
				}
			}
			//Male and herm area
			if (player.cockTotal() > 1)//merge back cock into one
			{
				outputText("and watch spellbound as your cocks all merge togueter back into a single human one. ");
				playerhadmorethenonecock = true;
				player.cocks.length = 1;
			}
			if (player.hasSheath()) { //(REMOVE SHEATH IF NECESSARY)
				if (playerhadmorethenonecock) outputText("Y");
				else outputText("y");
				outputText("our sheath tightens and starts to smooth out, revealing ever greater amounts of your " + player.cockDescript(temp2) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b> " +
						"This said the changes are only starting as you moan out feeling your cock harden and tingle as it dribbles venoms. ");
				playerhadasheath = true;
			}
			if (!player.hasVagina() && player.hasCock())
			{
				if (!playerhadmorethenonecock && !playerhadasheath)outputText("while ");
				if (player.cocks[0].cockType == CockTypesEnum.OOMUKADE)
				{
					if (playerhadasheath || playerhadmorethenonecock) outputText("You ");
					else outputText("and ");
					outputText("moan out, feeling your cock harden and tingle as it dribbles venoms. ");
				}
				if (player.cocks[0].cockType != CockTypesEnum.OOMUKADE)
				{
					if (playerhadasheath || playerhadmorethenonecock) outputText("You ");
					else outputText("and ");
					outputText("moan out, feeling your cock harden and tingle as it dribbles a strange dark purple liquid. ");
					player.cocks[0].cockType = CockTypesEnum.OOMUKADE;
				}
			}
			if (player.hasVagina() && player.hasCock())
			{
				if (!playerhadmorethenonecock)outputText("while ");
				if (player.cocks[0].cockType == CockTypesEnum.OOMUKADE)
				{
					if (playerhadasheath || playerhadmorethenonecock || playerhadabnormalVagina) outputText("You ");
					else outputText("and ");
					outputText("moan out, feeling your cock harden and tingle as it dribbles venoms. ");
				}
				if (player.cocks[0].cockType == CockTypesEnum.OOMUKADE && player.vaginaType() == VaginaClass.VENOM_DRIPPING)
				{
					if (playerhadasheath || playerhadmorethenonecock || playerhadabnormalVagina) outputText("You ");
					else outputText("and ");
					outputText("moan out feeling your cock harden and pussy clenching tightly as venoms drools from them. ");
				}
				else if (player.cocks[0].cockType != CockTypesEnum.OOMUKADE || player.vaginaType() != VaginaClass.VENOM_DRIPPING)
				{
					if (player.cocks[0].cockType != CockTypesEnum.OOMUKADE && player.vaginaType() != VaginaClass.VENOM_DRIPPING)
					{
						if (playerhadasheath || playerhadmorethenonecock || playerhadabnormalVagina) outputText("You ");
						else outputText("and ");
						outputText("moan out feeling your cock harden and pussy clenching tightly as a strange dark purple liquid drools from them.");
						outputText("It would seems your venomous markings altered something fundamental about your genitals.");
					}
					else
					{
						if (playerhadasheath || playerhadmorethenonecock || playerhadabnormalVagina) outputText("You ");
						else outputText("and ");
						outputText("moan out feeling your cock harden and pussy clenching tightly as venoms drools from them.");
						outputText("It would seems your venomous markings altered your newly aquired genitals into producing venom as well.");
					}
				}
				if (player.vaginaType() != VaginaClass.VENOM_DRIPPING) player.vaginaType(VaginaClass.VENOM_DRIPPING);
				if (player.cocks[0].cockType != CockTypesEnum.OOMUKADE) player.cocks[0].cockType = CockTypesEnum.OOMUKADE;
			}
			dynStats("lib", 3, "lus", 10);
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
