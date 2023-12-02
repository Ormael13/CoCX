package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;

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
        var duration:int = 1;
        if (player.inte >= 20) duration += 1;
		if (player.inte >= 40) duration += 1;
		if (player.inte >= 60) duration += 1;
		if (player.inte >= 80) duration += 1;
		if (player.inte >= 100) duration += Math.round((player.inte - 50) / 50);

		if (player.wis >= 20) duration += 1;
		if (player.wis >= 40) duration += 1;
		if (player.wis >= 60) duration += 1;
		if (player.wis >= 80) duration += 1;
		if (player.wis >= 100) duration += Math.round((player.wis - 50) / 50);
        return elementalAspectBaseDuration(StatusEffects.SummonedElementalsAir, duration) * 2;
    }

    override public function get buttonName():String {
		return "Air E.Asp";
	}

    override public function describeEffectVs(target:Monster):String {
		return "Blocks certain projectile attacks for " + calcDuration() + " rounds";
    }

    /*override public function isActive():Boolean {
        return player.hasStatusEffect(StatusEffects.WindWall);
    }*/

    override public function doEffect(display:Boolean = true):void {
        //player.createStatusEffect(StatusEffects.WindWall, 0, duration, 0, 0);
		if (display) outputText("You call on your elemental projecting a air wall between you and [themonster] to deflect incoming projectiles.\n\n");
        setDuration();
    }

    override public function durationEnd(display:Boolean = true):void {
        if (display) outputText("<b>Wind Wall effect wore off!</b>\n\n");
    }
}
}  