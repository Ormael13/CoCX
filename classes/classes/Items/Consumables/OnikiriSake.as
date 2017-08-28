/**
 * @author Liadri
 */
package classes.Items.Consumables {
import classes.Items.Consumable;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;

public class OnikiriSake extends Consumable {
	public function OnikiriSake() 
	{
		super("OniSake", "Onikiri Sake", "a bottle of Onikiri Sake", 6, "A drink favored by oni.");
	}
	
	override public function get description():String {
		var desc:String = _description;
		if (flags[kFLAGS.IZUMI_MET] > 0) desc += " Izumi kept a full stock of this in her camp. A strong beverage just like the people who drinks it."
		desc += "\n\nType: Consumable "
		desc += "\nBase value: " + String(value);
		return desc;
	}
	
	override public function useItem():Boolean {
		var changes:Number = 0;
		var changeLimit:Number = 1;
		if (rand(3) == 0) changeLimit++;
		if (player.findPerk(PerkLib.HistoryAlchemist) >= 0 || player.findPerk(PerkLib.PastLifeAlchemist) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.EzekielBlessing) >= 0) changeLimit++;
		if (player.findPerk(PerkLib.TransformationResistance) >= 0) changeLimit--;
		//Temporary storage
		var temp:Number = 0;
		player.slimeFeed();
		clearOutput();/*
		if () {
			outputText("(If silly mode) Oooooooh (End of cut)Yeaaaah!!!! (Silly mode) A walking amphora full of red wine bursts through a nearby wall and waves at you. (end of cut)That's just what you needed to quench your thirst…now time to beat up those puny eeehhh things to pulp!");
		}
		else */outputText("Woa! That sake sure is powerful. You laugh as your cheeks redden with the obvious sign of complete inebriation. You're so drunk you barely register as your body begins to change.");
		if (rand(3) == 0 && changes < changeLimit) {
			if (player.str <= 50) {
				outputText("\n\nPainful aches ripple through your body, flooding you with pain as your muscles flex and bulge, growing much stronger and more well-defined.");
				if (player.str <= 20) dynStats("str", 3);
				else dynStats("str", 2);
			}
			else {
				if (player.str >= 75) dynStats("str", .5);
				else dynStats("str", 1);
				outputText("\n\nYour muscles grow tighter, bulging outwards powerfully as you get even stronger!");
			}
			changes++;
		}
		if (rand(3) == 0 && changes < changeLimit) {
			if (player.tou <= 50) {
				outputText("\n\nYour hide... skin... whatever... you can feel it getting tougher as it thickens perceptibly.");
				if (player.tou <= 20) dynStats("tou", 3);
				else dynStats("tou", 2);
			}
			else {
				if (player.tou >= 75) dynStats("tou", .5);
				else dynStats("tou", 1);
				outputText("\n\nYour tough hide grows slightly thicker.");
			}
			changes++;
		}
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
		if (player.lowerBody == LOWER_BODY_TYPE_HUMAN && changes < changeLimit && rand(4) == 0) {
			outputText("\n\nNot again! Now it's the skin on your legs that is burning as a whole set of intricate warlike tattoos covers them. Furthermore, your toenails become increasingly pointed turning black just like a set of claws. Well it seems you will have get used to your");
			outputText(" <b>war tattooed legs and feet topped with sharp nails.</b>");
			mutations.setLowerBody(LOWER_BODY_TYPE_ONI);
			changes++;
		}
		if (player.lowerBody != LOWER_BODY_TYPE_ONI && player.lowerBody != LOWER_BODY_TYPE_HUMAN && player.lowerBody != LOWER_BODY_TYPE_GARGOYLE && changes < changeLimit && rand(4) == 0) {
			mutations.humanizeLowerBody();
		}
		//Arms
		if (player.armType != ARM_TYPE_ONI && player.armType != ARM_TYPE_GARGOYLE && player.lowerBody == LOWER_BODY_TYPE_ONI && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			if (player.armType != ARM_TYPE_HUMAN) outputText("You watch, spellbound, while your arms gradually changing it entire outer structure into plain human-like form. ");
			outputText("The skin on your arms feels like it’s burning as a whole set of intricate warlike tattoos covers them. Furthermore your nails become increasingly pointed turning black just like a set of claws. Well it seems you will have issues hiding your <b>war tattooed arms with sharp nails.</b>");
			mutations.setArmType(ARM_TYPE_ONI);
			changes++;
		}
		//Horn
		
		//Eyes
		/*if (player.faceType == FACE_MANTICORE && player.eyeType != EYES_MANTICORE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nWhile you do see way better in the dark, these red pupils are extremely intimidating and clearly don't belong on any normal feline. <b>You now have manticore eyes.</b>");
			mutations.setEyeType(EYES_MANTICORE);
			changes++;
		}*/
		//Ears
		if (player.armType == ARM_TYPE_ONI && player.earType == EARS_HUMAN && player.earType != EARS_ONI && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nYour ears tingle slightly as their shape sharpen to a point not unlike those of some kind of demonic fiend. Still you know all too well those are <b>Oni ears.</b>");
			mutations.setEarType(EARS_ONI);
			changes++;
		}
		if (player.armType == ARM_TYPE_ONI && player.earType != EARS_HUMAN && player.earType != EARS_ONI && changes < changeLimit && rand(3) == 0) {
			mutations.humanizeEars();
			changes++;
		}
		//Face
		if (player.earType == EARS_ONI && player.faceType != FACE_MANTICORE && changes < changeLimit && rand(3) == 0) {
			outputText("\n\nY");
			if (player.faceType != FACE_HUMAN) outputText("our face suddenly mold back into it’s former human shape. However y");
			outputText("ou feel your canines changing, growing bigger and slightly sharper. Hey you could pretend to be some kind of demon with that kind of mouth. <b>You now have oni canines.</b>");
			mutations.setFaceType(FACE_ONI_TEETH);
			changes++;
		}
		//Skin
		if (player.skinTone != "red" && player.skinTone != "reddish orange" && player.skinTone != "purple" && player.skinTone != "blue" && !player.isGargoyle() && changes < changeLimit && rand(4) == 0) {
			var color:String;
			color = randomChoice("purple","reddish orange","red","blue");
			player.skinTone = color;
			changes++;
			outputText("\n\nThe heat of the alcohol is getting to you; it's like if your ");
			if (player.hasFur()) outputText("skin");
			else outputText(player.skinDesc);
			outputText(" changed to  " + player.skinTone + ". Wait, it really did!");
		}
//		mutationStep(player.skin.base.type == SKIN_TYPE_PLAIN && !player.skin.hasBattleTattoo(), 3, function(): void {
//			outputText("\n\nAs you thought your skin couldn't handle more tattoo a few localised skin burns reveal a new set drawing along your skin, some decorating your chest. Well you might as well proudly display your <b>Oni tattooed skin.</b>");
		//	if (player.findPerk(PerkLib.GeneticMemory) >= 0 && !player.hasStatusEffect(StatusEffects.UnlockedTattoed)) {
		//		outputText("\n\n<b>Genetic Memory: Tattoed Skin - Memorized!</b>\n\n");
		//		player.createStatusEffect(StatusEffects.UnlockedTattoed, 0, 0, 0, 0);
		//	}
//			player.skin.base.pattern = PATTERN_BATTLE_TATTOO;
//			player.skin.base.adj = "tattooed";
//		});
//		if (!player.skin.hasBattleTattoo() && !player.hasPlainSkinOnly() && player.lowerBody != LOWER_BODY_TYPE_GARGOYLE && rand(3) == 0 && changes < changeLimit) {
//			mutations.humanizeSkin();
//		}
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
			player.refillHunger(10);
		}
		player.refillHunger(10);
		return false;
	}
}
}