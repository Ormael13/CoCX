/**
 * Coded by Liadri 2020-04-01.
 */
package classes.Items.Consumables {
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.CoC;
import classes.CockTypesEnum;
import classes.Items.Consumable;
import classes.VaginaClass;

public class PotentVenom extends Consumable {
	public function PotentVenom() {
		super("P.Venom", "P.Venom", "a vial of potent venom", 50, "A small vial filled with a bubbling, dark purple liquid. Even though it's corked, you can still smell the sweet scent wafting from it and it feels unnaturally warm to the touch.");
		withTag(U_TF);
	}

	override public function useItem():Boolean {
		var changes:Number = 0;
		var changeLimit:Number = 2 + player.additionalTransformationChances;
		var temp2:Number = 0;
		player.slimeFeed();
		clearOutput();
		outputText("You pop the cork on the vial and quickly chug the clear liquid. It tastes somewhat sweet, leaving your body feeling warm all over.");

		//Transformation effect list
		if (changeLimit && rand(2) == 0) {
			outputText("\n\nYou shudder as a strange warmth briefly spreads through you. The venom lingers on your tastebuds, leaving behind a tingling sensation and a lingering pleasure.");
			dynStats("lus", (10+player.lib/10), "scale", false);
			changes++;
		}

		if (changes < changeLimit && rand(3) == 0 && player.MutagenBonus("spe", 1)) {
			outputText("\n\nYou suddenly jerk forward, feeling somewhat twitchy. Surprised, you didn't know you could react so quickly.");
			changes++;
		}

		if (changes < changeLimit && rand(3) == 0 && player.MutagenBonus("tou", 5)) {
			outputText("\n\nYou feel oddly revitalized. You're so pumped that you feel that you can take on the strongest of enemies and even they would fail to even leave a scratch on you.");
			changes++;
		}

		if (player.wis > 20 && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nSomehow everything around seems so much duller. The world around you just seems so much more bland and uneventful.\n");
			player.addCurse("wis",5,1);
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
		if (player.arms.type != Arms.HUMAN && player.arms.type != Arms.CENTIPEDE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.ArmsHuman.applyEffect();
			changes++;
		}
		if (player.arms.type != Arms.CENTIPEDE && player.arms.type == Arms.HUMAN && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.ArmsCentipede.applyEffect();
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
		//Eyes
		if (player.faceType == Face.ANIMAL_TOOTHS && player.eyes.type != Eyes.CENTIPEDE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.EyesCentipede.applyEffect();
			changes++;
		}
		//Tatoo
		if (player.eyes.type == Eyes.CENTIPEDE && !player.skin.hasVenomousMarking() && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.SkinPatternVenomousMarkings.applyEffect();
			changes++;
		}

		//Genitals changes
		if (player.skin.hasVenomousMarking() && changes < changeLimit && rand(3) == 0) {
			var playerhadmorethenonecock:Boolean = false;
			var playerhadabnormalVagina:Boolean = false;
			var playerhadasheath:Boolean = false;
			outputText("\n\nYou double over as an overwhelming heat pools in your groin ");
			if (player.hasVagina() && player.vaginaType() != VaginaClass.VENOM_DRIPPING && player.vaginaType() != VaginaClass.HUMAN){
				outputText("as your vagina reverts back to a human one, at least in appearance.");
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
					CoC.instance.transformations.VaginaCentipede().applyEffect(false);
				}
			}
			//Male and herm area
			if (player.cockTotal() > 1)//merge back cock into one
			{
				outputText("and watch spellbound as your cocks all merge together back into a single human one. ");
				playerhadmorethenonecock = true;
				player.cocks.length = 1;
			}
			if (player.hasSheath()) { //(REMOVE SHEATH IF NECESSARY)
				if (playerhadmorethenonecock) outputText("Y");
				else outputText("y");
				outputText("our sheath tightens and starts to smooth out, revealing ever greater amounts of your " + player.cockDescript(temp2) + "'s lower portions.  After a few moments <b>your groin is no longer so animalistic – the sheath is gone.</b> " +
						"This said the changes are only starting as you moan out feeling your cock harden and tingle as it dribbles venom. ");
				playerhadasheath = true;
			}
			if (!player.hasVagina() && player.hasCock())
			{
				if (!playerhadmorethenonecock && !playerhadasheath)outputText("while ");
				if (player.cocks[0].cockType == CockTypesEnum.OOMUKADE)
				{
					if (playerhadasheath || playerhadmorethenonecock) outputText("You ");
					else outputText("and ");
					outputText("moan out, feeling your cock harden and tingle as it dribbles venom. ");
				}
				if (player.cocks[0].cockType != CockTypesEnum.OOMUKADE)
				{
					if (playerhadasheath || playerhadmorethenonecock) outputText("You ");
					else outputText("and ");
					outputText("moan out, feeling your cock harden and tingle as it dribbles a strange dark purple liquid. ");
					CoC.instance.transformations.CockCentipede().applyEffect(false);
				}
			}
			if (player.hasVagina() && player.hasCock())
			{
				if (!playerhadmorethenonecock)outputText("while ");
				if (player.cocks[0].cockType == CockTypesEnum.OOMUKADE)
				{
					if (playerhadasheath || playerhadmorethenonecock || playerhadabnormalVagina) outputText("You ");
					else outputText("and ");
					outputText("moan out, feeling your cock harden and tingle as it dribbles venom. ");
				}
				if (player.cocks[0].cockType == CockTypesEnum.OOMUKADE && player.vaginaType() == VaginaClass.VENOM_DRIPPING)
				{
					if (playerhadasheath || playerhadmorethenonecock || playerhadabnormalVagina) outputText("You ");
					else outputText("and ");
					outputText("moan out feeling your cock harden and pussy clenching tightly as venom drools from them. ");
				}
				else if (player.cocks[0].cockType != CockTypesEnum.OOMUKADE || player.vaginaType() != VaginaClass.VENOM_DRIPPING)
				{
					if (player.cocks[0].cockType != CockTypesEnum.OOMUKADE && player.vaginaType() != VaginaClass.VENOM_DRIPPING)
					{
						if (playerhadasheath || playerhadmorethenonecock || playerhadabnormalVagina) outputText("You ");
						else outputText("and ");
						outputText("moan out feeling your cock harden and pussy clenching tightly as a strange dark purple liquid drools from them.");
						outputText("It seems your venomous markings altered something fundamental about your genitals.");
					}
					else
					{
						if (playerhadasheath || playerhadmorethenonecock || playerhadabnormalVagina) outputText("You ");
						else outputText("and ");
						outputText("moan out feeling your cock harden and pussy clenching tightly as venom drools from them.");
						outputText("It seems your venomous markings altered your newly acquired genitals into producing venom as well.");
					}
				}
				if (player.vaginaType() != VaginaClass.VENOM_DRIPPING) {
					CoC.instance.transformations.VaginaCentipede().applyEffect(false);
				}
				if (player.cocks[0].cockType != CockTypesEnum.OOMUKADE) {
					CoC.instance.transformations.CockCentipede().applyEffect(false);
				}
			}
			dynStats("lus", 10, "scale", false);
			player.MutagenBonus("lib", 3);
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
