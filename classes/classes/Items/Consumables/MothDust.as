package classes.Items.Consumables {
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.CoC;
import classes.Items.Alchemy.AlchemyLib;
import classes.Items.Consumable;
import classes.Items.ItemTags;

public class MothDust extends Consumable {
    public function MothDust() {
        super("MothDus", "MothDust", "a handful of luminescent dust", 6, "A handful of luminescent dust.  It glows very softly, and smells sweet. You look at the handful of dust and wonder just how it'll affect you.");
        withTag(ItemTags.U_TF);
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
        //disable changes if blocking
        if (player.blockingBodyTransformations()) changeLimit = 0;
        clearOutput();
        //tail
        if (changes < changeLimit && rand(2) == 0 && player.tailType != Tail.MOTH_ABDOMEN) {
            outputText("\n\n");
            CoC.instance.transformations.TailMoth.applyEffect();
            changes++;
        }
        //Ears
        if (changes < changeLimit && rand(2) == 0 && player.ears.type != Ears.INSECT) {
            outputText("\n\n");
            CoC.instance.transformations.EarsInsect.applyEffect();
            changes++;
        }
        //LowerBody
        if (changes < changeLimit && rand(2) == 0 && player.lowerBody != LowerBody.MOTH) {
            outputText("\n\n");
            CoC.instance.transformations.LowerBodyMoth.applyEffect();
            changes++;
        }
        //Antenna
        if (changes < changeLimit && rand(2) == 0 && !player.antennae.type != Antennae.MOTH) {
            outputText("\n\n");
            CoC.instance.transformations.AntennaeMoth.applyEffect();
            changes++;
        }
        //Eyes
        if (changes < changeLimit && rand(2) == 0 && player.eyes.type != Eyes.MOTH) {
            outputText("\n\n");
            CoC.instance.transformations.EyesMoth.applyEffect();
            changes++;
        }
        //Arms
        if (changes < changeLimit && rand(2) == 0 && player.arms.type != Arms.MOTH) {
            outputText("\n\n");
            CoC.instance.transformations.ArmsMoth.applyEffect();
            changes++;
        }
        //Wings
        if (changes < changeLimit && rand(2) == 0 && ((player.wings.type != Wings.MOTH_SMALL)|| (player.wings.type != Wings.MOTH_LARGE))) {
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
        if (changes < changeLimit && rand(2) == 0 && player.horns.type != Horns.NONE) {
            outputText("\n\n");
            CoC.instance.transformations.HornsNone.applyEffect();
            changes++;
        }
        //Rearbody
        if (changes < changeLimit && rand(2) == 0 && player.rearBody.type != RearBody.MOTH_COLLAR) {
            outputText("\n\n");
            CoC.instance.transformations.RearBodyMoth.applyEffect();
            changes++;
        }

        return true;
    }
}
}
