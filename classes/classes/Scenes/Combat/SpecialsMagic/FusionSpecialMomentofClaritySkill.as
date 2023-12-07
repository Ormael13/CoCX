package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.Combat;
import classes.Races.ElementalRace;
import classes.EngineCore;

public class FusionSpecialMomentofClaritySkill extends AbstractMagicSpecial {
    public function FusionSpecialMomentofClaritySkill() {
        super (
            "Moment of Clarity",
            "Calm your inner sea to temporarily negate your lust.",
            TARGET_SELF,
            TIMING_LASTING,
            [TAG_BUFF, TAG_MAGICAL, TAG_TIER2, TAG_WATER],
            PerkLib.ElementalBody
        )
        baseSFCost = 400;
    }

    override public function get isKnown():Boolean {
        return super.isKnown && ElementalRace.getElement(player) == ElementalRace.ELEMENT_UNDINE && player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) >= 5;
    }

    override public function calcCooldown():int {
        return 6;
    }

    override public function calcDuration():int {
        return 3;
    }

    override public function describeEffectVs(target:Monster):String {
		return "Prevent lust damage, and reduces lust each turn for " + calcDuration() + " rounds";
    }

    override public function sfCost():int {
        return sfCostMod(baseSFCost);
    }

    override public function doEffect(display:Boolean = true):void {
        clearOutput();
		if (display) outputText("You empty your mind from needless thought turning yourself calm like the immobile water of a pond, only letting the ripple of the moment bother you. Thanks to your inner calm you manage to shrug off the desires that plagues you to concentrate on the ongoing battle with perfect clarity.\n\n");
        setDuration();
    }

    override public function durationEnd(display:Boolean = true):void {
        if (display) outputText("<b>Moment of Clarity effect ended!</b>\n\n");
    }

    override public function advance(display:Boolean):void {
        if (isActive()) dynStats("lus", -(Math.round(player.maxLust() * 0.05)));
        super.advance(display);
    }

  
}
}  