package classes.Items.Consumables {
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.RearBody;
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
        changeLimit = player.changeLimit;

        if (rand(3) == 0 && changes < changeLimit && pure ? player.arms.type != Arms.HUMAN : player.arms.type != Arms.BAT) {
            outputText("\n\n");
            if (player.arms.type != Arms.HUMAN) {
                CoC.instance.transformations.ArmsHuman.applyEffect();
            }
            if (!pure) {
                CoC.instance.transformations.ArmsBatWing.applyEffect();
            }
            changes++;
        }

        if (pure && rand(3) == 0 && changes < changeLimit && pure ? CoC.instance.transformations.EarsVampire.isPossible() : CoC.instance.transformations.EarsBat.isPossible()) {
            outputText("\n\n");
            if (pure) {
                CoC.instance.transformations.EarsVampire.applyEffect();
            } else {
                CoC.instance.transformations.EarsBat.applyEffect();
            }
            changes++;
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

        if (pure && rand(3) == 0 && changes < changeLimit && player.wings.type !== Wings.VAMPIRE) {
            outputText("\n\n");
            if (player.hasGooSkin()) {
                mutations.humanizeSkin();
            }

            if (player.vampireScore() >= 6) {
                outputText("As soon as the last drop of blood passes your now crimson lips, a terrible pain flares in the center of your back, a pain so intense thatyou black out briefly, coming back to your senses as you hit your head against the ground. You hear a horrifying ripping noise as your back stretches and tears to allow new bones to expand, black as tar and far lighter than mostof the bones in your body. These new bones shift under your shoulder blade skin as you fall on all groaning in pain and clawing at the ground. In a flash of pain they violently break out of your skin sending blood everywhere as you make a chilling scream your wounds slowlyclosing on their own. \n\nStill panting from the pain, you take a look at your new appendage. It's a pair of large vampire wings of impressive size.\n\nFeeling chilly you fold them back on your body and you ought to admit they indeed look like a large cape.");
            } else {
                outputText("You drop the vial, the glass shattering, as intense pain flares around your shoulder blades. The pain intensifies, causing you to drop to the ground, clawing and screaming in agony as your back suddenly explodes with a wet ripping noise, blood splattering around you as a large pair of black leathery wings emerge from the bloody ruin that is your backright now, stretching to their full span. The pain finally starts to recede, leaving a bone-deep weariness in it’s wake.\n\nAfter a while, you manage to recover enough to be sure that trying to stand up won’t result in graceless, and painful, flopping, soyou do just that, wrapping your new wings around you on instinct as you rise. Huh, wrapped like this you could probably pass them off as a long cape so long as nobody looks too closely, but you are certain they are the real deal.\n\nAfter all that pain, flying better be worth it.");
            }
            outputText("<b>You will be able to enjoy nightly flight using your brand new vampire wings.</b>");

            mutations.setWingType(Wings.VAMPIRE, "cape-like");
            changes++;
        }

        if (pure && rand(3) == 0 && changes < changeLimit && player.skinTone !== "pale") {
            outputText("\n\n");
            outputText("Your skin suddenly starts itching, causing you to look at it just in time for you to see it finish paling into a shade that wouldn’t be out of place on a corpse. You feel sleepy… horribly so, but you dismiss it as being the fault of the glaring light above your head. <b>You guess you could use some extra sunlight with your pale skin.</b>");
            player.skinTone = "pale";

            if (CoC.instance.transformations.EyesChangeColor(["blood-red"]).isPossible()) {
                outputText("\n\n");
                CoC.instance.transformations.EyesChangeColor(["blood-red"]).applyEffect();
            }

            changes++;
        }

        if (!pure && rand(3) == 0 && changes < changeLimit && player.rearBody.type !== RearBody.BAT_COLLAR) {
            outputText("\n\n");

            outputText("You drop the vial, the glass shattering as it hits the ground, as an intense itching sets in around your neck. Bringing your hands to your neck to scratch it, you find sparse, downy fuzz. As you scratch away, it continues lengthening and growing in density until you have a collar of fur around your neck.\n\nWell, this isn’t so bad, the scarf-like look is certainly nice, at the very least.<b>Your neck now sports a collar of fur.</b>");

            mutations.setRearBody(RearBody.BAT_COLLAR);
            changes++;
        }

	    if(changes == 0) {
            outputText("\n\nOdd. You don't feel any different.");
        }

        return false;
    }
}
}
