/**
 * @author Liadri
 */
package classes.Items.Consumables {
import classes.CoC;
import classes.EngineCore;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.Skin;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Consumable;
import classes.Items.Mutations;
import classes.PerkLib;
import classes.StatusEffects;

public class OnikiriSake extends Consumable {
	public function OnikiriSake()
	{
		super("OniSake", "Onikiri Sake", "a bottle of Onikiri Sake", 6, "A drink favored by oni.");
	}

	override public function get description():String {
		var desc:String = _description;
		if (flags[kFLAGS.IZUMI_MET] > 0) desc += " Izumi kept a full stock of this in her camp. A strong beverage just like the people who drinks it.";
		desc += "\n\nType: Consumable ";
		desc += "\nBase value: " + String(value);
		return desc;
	}

	override public function useItem():Boolean {
		changes = 0;
		var changeLimit:Number = 1;
		if (rand(2) == 0) changeLimit++;
		if (rand(2) == 0) changeLimit++;
		if (rand(2) == 0) changeLimit++;
		changeLimit += player.additionalTransformationChances;
		//Temporary storage
		var temp:Number = 0;
		player.slimeFeed();
		clearOutput();
		if (CoC.instance.inCombat) {
			if (EngineCore.silly()) outputText("Oooooooh ");
			outputText("Yeaaaah!!!! ");
			if (EngineCore.silly()) outputText("A walking amphora full of red wine bursts through a nearby wall and waves at you. ");
			outputText("That's just what you needed to quench your thirst... now time to beat up those puny eeehhh... things to a pulp!");
		}
		else outputText("Woa! That sake sure is powerful. You laugh as your cheeks redden with the obvious sign of complete inebriation. You're so drunk you barely register as your body begins to change.");
		if (!player.hasStatusEffect(StatusEffects.DrunkenPower) && CoC.instance.inCombat && player.oniScore() >= mutations.DrunkenPowerEmpowerOni()) mutations.DrunkenPowerEmpower();
		if (rand(3) == 0 && changes < changeLimit && player.MutagenBonus("str", 2)) {
			if (player.str <= 50)
				outputText("\n\nPainful aches ripple through your body, flooding you with pain as your muscles flex and bulge, growing much stronger and more well-defined.");
			else
				outputText("\n\nYour muscles grow tighter, bulging outwards powerfully as you get even stronger!");
			changes++;
		}

		if (rand(3) == 0 && changes < changeLimit && player.MutagenBonus("tou", 2)) {
			if (player.tou <= 50)
				outputText("\n\nYour hide... skin... whatever... you can feel it getting tougher as it thickens perceptibly.");
			else
				outputText("\n\nYour tough hide grows slightly thicker.");
			changes++;
		}

		if (changes < changeLimit && rand(3) == 0 && player.tone < player.maxToneCap()) {
			outputText(player.modTone(player.maxToneCap(), 3));
		}
		if (player.blockingBodyTransformations()) changeLimit = 0;
		//Sexual changed
		if ((player.gender == 1 || player.gender == 3) && player.cocks.length > 0 && changes < changeLimit && rand(3) == 0) {
			var selectedCock:int = -1;
			for (var i:int = 0; i < player.cocks.length; i++)
			{
				if (player.cocks[i].cockLength < 21 || player.cocks[i].cockThickness < 4)
				{
					selectedCock = i;
					break;
				}
			}
			if (selectedCock != -1) {
				if (player.cocks[selectedCock].cockThickness < 4) {
					temp = player.increaseCock(selectedCock, 2 + rand(4));
					temp += player.cocks[selectedCock].thickenCock(1);
					outputText("\n\nYour cock suddenly hardens, blood pumping in as it enlarges, growing both longer and thicker! The pleasure of the change cause you to orgasm, a big load of cum splattering the ground below you.");
					outputText("  To your delight and surprise, you discover it has grown slightly thicker as well!");
				}
				else {
					temp = player.increaseCock(selectedCock, 2 + rand(4));
					outputText("\n\nYour cock suddenly hardens, blood pumping in as it enlarges, growing both longer and thicker! The pleasure of the change cause you to orgasm, a big load of cum splattering the ground below you.");
				}
				changes++;
			}
		}
		if (player.gender >= 2 && player.biggestTitSize() <= 30 && changes < changeLimit && rand(3) == 0) {
			if (rand(2) == 0) outputText("\n\nYour [breasts] tingle for a moment before becoming larger.");
			else outputText("\n\nYou feel a little weight added to your chest as your [breasts] seem to inflate and settle in a larger size.");
			player.growTits(1 + rand(3), 1, false, 3);
			changes++;
		}
		//Physical changes
		//Legs
		if (player.lowerBody == LowerBody.HUMAN && changes < changeLimit && rand(4) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.LowerBodyOni.applyEffect();
			changes++;
		}
		if (player.lowerBody != LowerBody.ONI && player.lowerBody != LowerBody.HUMAN && player.lowerBody != LowerBody.GARGOYLE && changes < changeLimit && rand(4) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.LowerBodyHuman.applyEffect();
			changes++;
		}
		//Arms
		if (player.arms.type != Arms.ONI && player.arms.type != Arms.GARGOYLE && player.lowerBody == LowerBody.ONI && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.ArmsOni.applyEffect();
			changes++;
		}
		//Horn
		if (rand(3) == 0 && changes < changeLimit && (player.horns.type != Horns.ONI_X2 || player.horns.type != Horns.ONI) && player.arms.type == Arms.ONI) {
			outputText("\n\n");
			if (rand(2) == 0) {
				CoC.instance.transformations.HornsOniDual.applyEffect();
			}
			else {
				CoC.instance.transformations.HornsOni.applyEffect();
			}
			changes++;
		}
		//Eyes
		if ((player.horns.type == Horns.ONI_X2 || player.horns.type == Horns.ONI) && (CoC.instance.transformations.EyesOni.isPossible() || CoC.instance.transformations.EyesOniColors.isPossible()) && changes < changeLimit && rand(3) == 0) {
			if (CoC.instance.transformations.EyesOniColors.isPossible()) {
				CoC.instance.transformations.EyesOniColors.applyEffect();
			}

			if (CoC.instance.transformations.EyesOni.isPossible()) {
				CoC.instance.transformations.EyesOni.applyEffect();
			}
			changes++;
		}
		//Ears
		if (player.eyes.type == Eyes.ONI && player.ears.type == Ears.HUMAN && player.ears.type != Ears.ONI && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.EarsOni.applyEffect();
			changes++;
		}
		if (player.eyes.type == Eyes.ONI && player.ears.type != Ears.HUMAN && player.ears.type != Ears.ONI && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.EarsHuman.applyEffect();
			changes++;
		}
		//Face
		if (player.ears.type == Ears.ONI && player.faceType != Face.ONI_TEETH && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
      CoC.instance.transformations.FaceOniTeeth.applyEffect();
			changes++;
		}
		//Skin
		if (player.skinTone != "red" && player.skinTone != "reddish-orange" && player.skinTone != "purple" && player.skinTone != "blue" && !player.isGargoyle() && changes < changeLimit && rand(4) == 0) {
			var colorSkin:String;
			colorSkin = randomChoice("purple","reddish-orange","red","blue");
			player.skinTone = colorSkin;
			changes++;
			outputText("\n\nThe heat of the alcohol is getting to you; it's like if your ");
			if (player.hasFur()) outputText("skin");
			else outputText(player.skinDesc);
			outputText(" changed to  " + player.skinTone + ". Wait, it really did!");
		}
		//mutationStep(player.skin.base.type == PLAIN && !player.skin.hasBattleTattoo(), 3, function(): void {
		if (player.skin.base.type == Skin.PLAIN && !player.skin.hasBattleTattoo() && rand(3) == 0 && changes < changeLimit) {
			outputText("\n\n");
      CoC.instance.transformations.SkinPatternOni.applyEffect();
			changes++;
		}
		//});
		if (!player.skin.hasBattleTattoo() && !player.hasPlainSkinOnly() && player.lowerBody != LowerBody.GARGOYLE && rand(3) == 0 && changes < changeLimit) {
			outputText("\n\n");
			CoC.instance.transformations.SkinPlain.applyEffect();
		}
		//Taller
		if (changes < changeLimit && rand(3) == 0 && player.tallness < 132) {
			temp = rand(5) + 3;
			if (player.tallness > 117) temp = Math.floor(temp / 2);
			if (temp == 0) temp = 1;
			if (temp < 5) outputText("\n\nYou shift uncomfortably as you realize you feel off balance.  Gazing down, you realize you have grown SLIGHTLY taller.");
			if (temp >= 5 && temp < 7) outputText("\n\nYou feel dizzy and slightly off, but quickly realize it's due to a sudden increase in height.");
			if (temp == 7) outputText("\n\nStaggering forwards, you clutch at your head dizzily.  You spend a moment getting your balance, and stand up, feeling noticeably taller.");
			player.tallness += temp;
			changes++;
		}
		if (rand(4) == 0) outputText(player.modTone(85, 3));
		//FAILSAFE CHANGE
		if (changes == 0) {
			outputText("\n\nRemarkably, the sake has no effect aside making you feel little more drunk.  Maybe next time?");
		}
		player.refillHunger(10);
		return false;
	}
}
}
