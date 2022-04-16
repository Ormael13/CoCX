package classes.Items.Consumables {
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Horns;
import classes.BodyParts.RearBody;
import classes.BodyParts.Tail;
import classes.BodyParts.Wings;
import classes.CoC;
import classes.Items.Consumable;
import classes.PerkLib;
import classes.StatusEffects;
import classes.EngineCore;

import coc.xxc.BoundStory;

public class VampireBlood extends Consumable {
    private var pure:Boolean;
    public static var first:Boolean = true;
    public function VampireBlood(purified:Boolean=false) {
        super(
                purified ? "VampBld" : "RedVial",
                purified ? "VampBld" : "RedVial",
                purified ? "a vial of vampire blood" : "a vial of ominous red liquid",
                purified ? 30 : 15,
                purified ? "This vial is filled with vampire blood. You don’t need to be a genius to figure what will happen if you drink that." :
                        "A vial of thick, deep red liquid. It has a slightly metallic scent."
        );
        pure = purified;
    }
    override public function get description():String{
        if(pure){
            _description = "This vial is filled with vampire blood. You don’t need to be a genius to figure what will happen if you drink that.";
        } else if(first){
            _description = "A vial of thick, deep red liquid. It has a slightly metallic scent.";
        } else {
            _description = "This vial can’t seriously contain blood, can it? You hope you won’t turn into a vampire from drinking it.";
        }
        return super.description;
    }
    override public function useItem():Boolean{
        clearOutput();
        if(first){
            outputText("Ew! This thing is indeed blood. It tastes awful, a strong, coppery taste, the liquid is thick from the iron content.\nAs you try to get the taste out of your mouth, you feel something begin to change in you.");
            first = false;
        } else if (player.vampireScore() >= 6){
            outputText("The blood tastes wonderful, as always.\n\nYou have downed the whole vial much sooner than you would have liked, leaving you wishing for more even as the vampiric blood starts changing your body further.")
            if (EngineCore.silly()) outputText("\n\nYou filthy druggie.");
        } else if (pure) {
            outputText("The blood tastes awful, a strong, coppery taste, and is thick from the iron content. Yet, under the blood’s metallic aftertaste, there's a hint of sweetness to it that you can’t really put your finger on.\n\nAs you try to get the taste out of your mouth, you feel your body starting to change.");
        } else {
            outputText("You uncork the vial and down its contents. You gag disgusted as the thick, metallic tang of blood coats your throat.\n\n");
            if (EngineCore.silly()) outputText("What else were you expecting with that label and smell? Tomato juice with iron shavings?\n\n");
            outputText("With some effort, you force down the blood and swallow it. A rush of heat flows through your veins as your body starts to react to the new blood.");
        }

        changes = 0;
		var changeLimit:Number = 1;
		if (rand(2) == 0) changeLimit++;
		if (rand(2) == 0) changeLimit++;
        changeLimit += player.additionalTransformationChances;
		if (player.blockingBodyTransformations()) changeLimit = 0;

        if (pure) {
            if (pure && rand(3) == 0 && changes < changeLimit && CoC.instance.transformations.EarsVampire.isPossible()) {
                outputText("\n\n");
                CoC.instance.transformations.EarsVampire.applyEffect();
                changes++;
            }

            if (rand(3) == 0 && changes < changeLimit && player.arms.type != Arms.HUMAN) {
                outputText("\n\n");
                CoC.instance.transformations.ArmsHuman.applyEffect();
                changes++;
            }

            if (rand(3) == 0 && changes < changeLimit && player.wings.type !== Wings.VAMPIRE) {
                outputText("\n\n");
                if (player.hasGooSkin()) {
                    CoC.instance.transformations.SkinPlain.applyEffect();
                    outputText("\n\n");
                }

                CoC.instance.transformations.WingsVampire.applyEffect();
                changes++;
            }

            if (rand(3) == 0 && changes < changeLimit && player.skinTone !== "pale") {
                outputText("\n\n");
                outputText("Your skin suddenly starts itching, causing you to look at it just in time for you to see it finish paling into a shade that wouldn’t be     out of place on a corpse. You feel sleepy… horribly so, but you dismiss it as being the fault of the glaring light above your head. <b>You guess    you could use some extra sunlight with your pale skin.</b>");
                player.skinTone = "pale";

                changes++;
            }

            if (rand(3) == 0 && changes < changeLimit && CoC.instance.transformations.EyesChangeColor(["blood-red"]).isPossible()) {
                outputText("\n\n");
                CoC.instance.transformations.EyesChangeColor(["blood-red"]).applyEffect();

                changes++;
            }

            if (rand(3) == 0 && changes < changeLimit && player.tailType != Tail.NONE) {
                outputText("\n\n");
                CoC.instance.transformations.TailNone.applyEffect();
                changes++;
            }

            if (rand(3) == 0 && changes < changeLimit && player.horns.type == Horns.NONE) {
                outputText("\n\n");
                CoC.instance.transformations.HornsNone.applyEffect();
                changes++;
            }

            if (rand(3) == 0 && changes < changeLimit && player.antennae.type == Antennae.NONE) {
                outputText("\n\n");
                CoC.instance.transformations.AntennaeNone.applyEffect();
                changes++;
            }

            if (rand(3) == 0 && changes < changeLimit && player.rearBody.type !== RearBody.BAT_COLLAR) {
                outputText("\n\n");
                CoC.instance.transformations.RearBodyBatCollar.applyEffect();
                changes++;
            }
        } else {
            if (rand(3) == 0 && changes < changeLimit && CoC.instance.transformations.EarsBat.isPossible()) {
                outputText("\n\n");
                CoC.instance.transformations.EarsBat.applyEffect();
                changes++;
            }

            if (rand(3) == 0 && changes < changeLimit && player.arms.type != Arms.BAT) {
                outputText("\n\n");
                CoC.instance.transformations.ArmsBatWing.applyEffect();
                changes++;
            }
        }

        if (rand(3) == 0 && changes < changeLimit && CoC.instance.transformations.EyesVampire.isPossible()) {
            outputText("\n\n");
            CoC.instance.transformations.EyesVampire.applyEffect();
            changes++;
        }

        if (rand(3) == 0 && changes < changeLimit && CoC.instance.transformations.FaceVampire.isPossible()) {
            outputText("\n\n");
            CoC.instance.transformations.FaceVampire.applyEffect();
            changes++;
        }

	    if(changes == 0) {
            outputText("\n\nOdd. You don't feel any different.");
        }

        return false;
    }
}
}
