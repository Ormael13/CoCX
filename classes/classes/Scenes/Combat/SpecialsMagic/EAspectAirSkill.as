package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;

public class EAspectAirSkill extends AbstractMagicSpecial {
    public function EAspectAirSkill() {
        super (
            "Elemental Aspect: Air",
            "Creates a Wind Wall that deflects incoming projectiles for a few turns. Each attack blocked lowers duration by one round",
            TARGET_SELF,
            TIMING_LASTING,
            [TAG_BUFF, TAG_WIND, TAG_TIER2],
            StatusEffects.SummonedElementalsAir
        )
        
    }

    override public function calcCooldown():int {
        return -1;
    }

    override public function calcDuration():int {
        return elementalAspectBaseDuration(StatusEffects.SummonedElementalsAir) + combat.magic.perkRelatedDurationBoosting();
    }

    override public function manaCost():Number {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsAir) * costMultiplier();
    }

    private function costMultiplier():Number {
		var spellMightMultiplier:Number = 1;
		if (player.hasPerk(PerkLib.EverLastingBuffs)) spellMightMultiplier *= 2;
		if (player.hasPerk(PerkLib.EternalyLastingBuffs)) spellMightMultiplier *= 2;
		return spellMightMultiplier;
	}

    override public function get buttonName():String {
		return "Air E.Asp";
	}

    override public function describeEffectVs(target:Monster):String {
		return "Blocks certain projectile attacks for " + calcDuration() + " rounds";
    }

    override public function doEffect(display:Boolean = true):void {
		if (display) outputText("You call on your elemental projecting a air wall between you and [themonster] to deflect incoming projectiles.\n\n");
        setDuration();
    }

    override public function durationEnd(display:Boolean = true):void {
        if (display) outputText("<b>Wind Wall effect wore off!</b>\n\n");
    }
}
}  