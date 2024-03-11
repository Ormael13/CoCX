// Consumable by Furrin GOk
package classes.Items.Consumables {
import classes.BodyParts.*;
import classes.CoC;
import classes.CockTypesEnum;
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;
import classes.Races.AntRace;

public class HoneydewCake extends Consumable {
	public function HoneydewCake() {
		super("HDewCake", "HDewCake", "a cake flavored with honeydew", 6, "A very sweet cake beloved by Antmorphs.");
		withTag(U_TF);
		refineableInto(
				AlchemyLib.DEFAULT_SUBSTANCES_DROP_TABLE,
				AlchemyLib.MULTIRACE_ESSENCE_DROP_TABLE(AlchemyLib.AE_ANT),
				[],
				AntRace.AntChitinColors
		);
        }
	public override function useItem():Boolean {
		var changes:Number = 0;
		var changeLimit:Number = 2;
		if (rand(2) == 0) changeLimit++;
        if (rand(2) == 0) changeLimit++;
        if (rand(2) == 0) changeLimit++;
		changeLimit += player.additionalTransformationChances;
		//Temporary storage
        var counter:int = 0;
		player.slimeFeed();
		clearOutput();
		outputText("You scarf down the sweet cake, feeling a bit of a sugar high.");
		//Strength up to 125
		if (changes < changeLimit && rand(3) == 0 && player.MutagenBonus("str", 1)) {
			changes++;
            outputText("\n\nAfter eating the cake, your muscles suddenly feel sore, as though you just lifted heavy weights. You're probably stronger.");
		}
		//Toughness up to 125
		if (changes < changeLimit && rand(3) == 0 && player.MutagenBonus("tou", 1)) {
			outputText("\n\nAfter eating the cake, a soreness starts building up in your arms, as though you just blocked a boxer's punches. As it goes away, you feel like you've gotten tougher.");
            changes++;
		}
        if (player.inte > 50 && changes < changeLimit && rand(3) == 0) {
            outputText("\n\nYou feel a dull sensation in your brain. You may not be as intelligent as you used to be.");
            player.addCurse("int", 3);
            changes++;
        }
        if (player.wis > 50 && changes < changeLimit && rand(3) == 0) {
            outputText("\n\nYou suddenly feel like you're in a haze for a second. You may not be a wise as you used to be.")
            player.addCurse("wis", 3);
            changes++;
        }
		if (player.blockingBodyTransformations()) changeLimit = 0;
		//Antcock!
		if (changes < changeLimit && rand(3) == 0 && player.insectCocks() < player.cocks.length) {
            var choices:Array = [];
            counter = player.cockTotal();
            while (counter > 0) {
                counter--;
                //Add non-insect locations to the array
                if (player.cocks[counter].cockType != CockTypesEnum.INSECT) choices[choices.length] = counter;
            }
            if (choices.length != 0) {
                var select:int = choices[rand(choices.length)];
                CoC.instance.transformations.CockInsect(select).applyEffect();
                changes++;
            }
        }
        //Ant Legs
        if (player.hasCoatOfType(Skin.CHITIN) && player.lowerBody != LowerBody.ANT && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.LowerBodyAnt.applyEffect();
			player.MutagenBonus("spe", 3);
			changes++;
		}
        //oviposition
        if (changes < changeLimit && player.hasCoatOfType(Skin.CHITIN) && CoC.instance.transformations.OvipositorAnt.isPossible() && rand(2) == 0) {
            CoC.instance.transformations.OvipositorAnt.applyEffect();
            changes++;
        }
		//Ant Abdomen
		if (player.lowerBody == LowerBody.ANT && player.tailType != Tail.ANT_ABDOMEN && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.TailAnt.applyEffect();
			changes++;
		}
        //Wings
        if (!InCollection(player.wings.type, Wings.ANT_LARGE) && changes < changeLimit && rand(4) == 0) {
            //Grow bigger ant wings or convert bee wings into ant
            if (player.wings.type == Wings.ANT_SMALL || player.wings.type == Wings.BEE_LARGE) {
                outputText("[pg]");
                CoC.instance.transformations.WingsAntLarge.applyEffect();
            }
         //Grow small ant wings if player has none or small bee wings.
         else if (player.wings.type == Wings.NONE || player.wings.type == Wings.BEE_SMALL) {
              outputText("[pg]");
              CoC.instance.transformations.WingsAntSmall.applyEffect();
            }
            //Remove old wings
            else {
                outputText("[pg]");
                CoC.instance.transformations.WingsNone.applyEffect();
            }
            changes++;
        }
		//Chitin skin
        if (changes < changeLimit && player.hasPartialCoat(Skin.CHITIN) && player.tailType == Tail.ANT_ABDOMEN && rand(2) == 0) {
            outputText("[pg]");
            CoC.instance.transformations.SkinChitin(Skin.COVERAGE_COMPLETE, {colors: AntRace.AntChitinColors}).applyEffect();
            changes++;
        }
		//(Fur/Scales fall out replaced by chitin)
        if (!player.hasCoatOfType(Skin.CHITIN) && InCollection(player.ears.type, Ears.HUMAN, Ears.ELFIN, Ears.INSECT) && rand(3) == 0 && changes < changeLimit) {
			outputText("[pg]");
            CoC.instance.transformations.SkinChitin(Skin.COVERAGE_LOW, {colors: AntRace.AntChitinColors}).applyEffect();
            changes++;
        }
		//Insect ears
		if (player.ears.type != Ears.INSECT && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.EarsInsect.applyEffect();
			changes++;
		}
		//Ant face
		if (player.ears.type == Ears.INSECT && player.faceType != Face.ANT && changes < changeLimit && rand(3) == 0) {
			outputText("\n\n");
			CoC.instance.transformations.FaceAnt.applyEffect();
			changes++;
		}
        //Arms
        if (player.hasCoatOfType(Skin.CHITIN) && player.arms.type != Arms.ANT && changes < changeLimit && rand(3) == 0) {
            outputText("[pg]");
			CoC.instance.transformations.ArmsAnt.applyEffect();
            changes++;
        }
        //Removes horns
        if (changes < changeLimit && player.horns.count > 0 && rand(3) == 0) {
            outputText("[pg]");
            CoC.instance.transformations.HornsNone.applyEffect();
            changes++;
        }
        //Antennae
        if (changes < changeLimit && player.antennae.type != Antennae.ANT && rand(3) == 0) {
			outputText("[pg]");
			CoC.instance.transformations.AntennaeAnt.applyEffect();
			changes++;
		}
		//FAILSAFE CHANGE
		if (changes == 0) {
			outputText("[pg]Inhuman vitality spreads through your body, invigorating you!\n");
			EngineCore.HPChange(50, true);
		}
		player.refillHunger(20);
        flags[kFLAGS.TIMES_TRANSFORMED] += changes;
		return false;
	}
}
}
