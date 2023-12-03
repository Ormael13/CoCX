package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;

public class EAspectEarthSkill extends AbstractMagicSpecial {
    public function EAspectEarthSkill() {
        super (
            "Elemental Aspect: Earth",
            "Creates an Earth armor around the player, increasing armor and magic resistance for a few turns.",
            TARGET_SELF,
            TIMING_LASTING,
            [TAG_BUFF, TAG_EARTH, TAG_TIER2],
            StatusEffects.SummonedElementalsEarth
        )
        
    }

    override public function calcCooldown():int {
        return -1;
    }

    override public function calcDuration():int {
        return elementalAspectBaseDuration(StatusEffects.SummonedElementalsEarth) + combat.magic.perkRelatedDurationBoosting();
    }

    override public function get buttonName():String {
		return "Earth E.Asp";
	}

    private function costMultiplier():Number {
		var spellMightMultiplier:Number = 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) spellMightMultiplier *= 2;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) spellMightMultiplier *= 2;
		return spellMightMultiplier;
	}

    override public function manaCost():Number {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsCorruption) * costMultiplier();
    }

    override public function describeEffectVs(target:Monster):String {
		return "Increases physical and magical resistance by " + numberFormat(getBonus()) + " for " + calcDuration() + " rounds";
    }

    /**
     * Returns the bonus of this ability grants to physical and magical resistance
     * @return stoneskinbonus (Number) - ability defense bonus
     */
    public function getBonus():Number {
        var stoneskinbonus:Number = 0;
		stoneskinbonus += player.inte * 0.5;
		stoneskinbonus += player.wis * 0.5;
		return Math.round(stoneskinbonus);
    }

    override public function doEffect(display:Boolean = true):void {
		if (display) outputText("Your elemental lifts stone and dirt from the ground, encasing you in a earthen shell stronger than any armor.\n\n");
        setDuration();
    }

    override public function durationEnd(display:Boolean = true):void {
        if (display) outputText("<b>Stone Skin effect wore off!</b>\n\n");
    }
}
}  