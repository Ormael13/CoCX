package classes.Items.Consumables {
import classes.BodyParts.*;
import classes.CoC;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;
import classes.Races.MothRace;

public class MothDust extends Consumable {
    public function MothDust() {
        super("MothDus", "MothDust", "a handful of luminescent dust", 6, "A handful of luminescent dust.  It glows very softly, and smells sweet. You look at the handful of dust and wonder just how it'll affect you.");
        withTag(U_TF);
        refineableInto(
                AlchemyLib.DEFAULT_SUBSTANCES_DROP_TABLE,
                AlchemyLib.DEFAULT_ESSENCE_DROP_TABLE(AlchemyLib.AE_MOTH)
        )
    }
    override public function useItem():Boolean {
        player.slimeFeed();
        //Changes done
        var changes:Number = 0;
        //Change limit
        var changeLimit:Number = 2;
        if (rand(2) == 0) changeLimit++;
        if (rand(2) == 0) changeLimit++;
        if (rand(2) == 0) changeLimit++;
        if (changeLimit == 1) changeLimit = 2;
        changeLimit += player.additionalTransformationChances;
        //Statistical changes:
        //-Raises speed to 100.
        if (rand(2) == 0 && changes < changeLimit && player.MutagenBonus("spe", 1)) {
            outputText("[pg]Hearing a sudden sound you suddenly move by reflex to the side with such speed you nearly trip.  Seems your reaction speed has increased as well as your mobile execution.");
            changes++;
        }
        //disable changes if blocking
        if (player.blockingBodyTransformations()) changeLimit = 0;
        clearOutput();
        //tail
        if (changes < changeLimit && rand(3) == 0 && player.tailType != Tail.MOTH_ABDOMEN) {
            outputText("\n\n");
            CoC.instance.transformations.TailMoth.applyEffect();
            changes++;
        }
        //Ears
        if (changes < changeLimit && rand(3) == 0 && player.ears.type != Ears.INSECT) {
            outputText("\n\n");
            CoC.instance.transformations.EarsInsect.applyEffect();
            changes++;
        }
        //LowerBody
        if (changes < changeLimit && rand(3) == 0 && player.lowerBody != LowerBody.MOTH) {
            outputText("\n\n");
            CoC.instance.transformations.LowerBodyMoth.applyEffect();
            changes++;
        }
        //Antenna
        if (changes < changeLimit && rand(3) == 0 && !player.antennae.type != Antennae.MOTH) {
            outputText("\n\n");
            CoC.instance.transformations.AntennaeMoth.applyEffect();
            changes++;
        }
		//Chitin skin
        if (changes < changeLimit && player.hasPartialCoat(Skin.CHITIN) && player.tailType == Tail.MOTH_ABDOMEN && rand(2) == 0) {
            outputText("[pg]");
            CoC.instance.transformations.SkinChitin(Skin.COVERAGE_COMPLETE, {colors: MothRace.MothChitinColors}).applyEffect();
            changes++;
        }
		//(Fur/Scales fall out replaced by chitin)
        if (!player.hasCoatOfType(Skin.CHITIN) && InCollection(player.ears.type, Ears.HUMAN, Ears.ELFIN, Ears.INSECT) && rand(3) == 0 && changes < changeLimit) {
			outputText("[pg]");
            CoC.instance.transformations.SkinChitin(Skin.COVERAGE_LOW, {colors: MothRace.MothChitinColors}).applyEffect();
            changes++;
        }
        //Eyes
        if (changes < changeLimit && rand(3) == 0 && player.eyes.type != Eyes.MOTH) {
            outputText("\n\n");
            CoC.instance.transformations.EyesMoth.applyEffect();
            changes++;
        }
        //Arms
        if (changes < changeLimit && rand(3) == 0 && player.arms.type != Arms.MOTH) {
            outputText("\n\n");
            CoC.instance.transformations.ArmsMoth.applyEffect();
            changes++;
        }
        //Wings
        if (changes < changeLimit && rand(3) == 0 && ((player.wings.type != Wings.MOTH_SMALL)|| (player.wings.type != Wings.MOTH_LARGE))) {
            outputText("\n\n");
            //for now make it random
            if(rand(2) == 0) {
                CoC.instance.transformations.WingsMothSmall.applyEffect();
            } else {
                CoC.instance.transformations.WingsMothLarge.applyEffect();
            }
            changes++;
        }
        //Horns
        if (changes < changeLimit && rand(3) == 0 && player.horns.type != Horns.NONE) {
            outputText("\n\n");
            CoC.instance.transformations.HornsNone.applyEffect();
            changes++;
        }
        //Rearbody
        if (changes < changeLimit && rand(3) == 0 && player.rearBody.type != RearBody.MOTH_COLLAR) {
            outputText("\n\n");
            CoC.instance.transformations.RearBodyMoth.applyEffect();
            changes++;
        }

        return true;
    }
}
}
