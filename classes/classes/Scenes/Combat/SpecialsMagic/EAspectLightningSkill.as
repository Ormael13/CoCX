package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.Combat;

public class EAspectLightningSkill extends AbstractMagicSpecial {
    public function EAspectLightningSkill() {
        super (
            "Elemental Aspect: Lightning",
            "Attack with a stronger version of a lightning-attributed basic elemental attack.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_LIGHTNING, TAG_MAGICAL, TAG_TIER2],
            StatusEffects.SummonedElementalsLightning
        )
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

    override public function calcCooldown():int {
        return -1;
    }

    override public function get buttonName():String {
		return "Lightning E.Asp";
	}

    override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(monster)) + " lightning damage";
    }

    override public function manaCost():Number {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsLightning);
    }

    public function calcDamage(monster:Monster):Number {
        var damage:Number = elementalAspectBaseDamage(StatusEffects.SummonedElementalsLightning);
        damage = elementalAspectDamageMod(StatusEffects.SummonedElementalsLightning, damage);

        return damage;
    }

    override public function doEffect(display:Boolean = true):void {
        var damage:Number = calcDamage(monster);
        damage = calcVoltageMod(damage, true);

        //Determine if critical hit!
        var crit:Boolean = false;
        var critChance:int = 5;
        critChance += combatMagicalCritical();
        if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
        if (rand(100) < critChance) {
            crit = true;
			damage *= 1.5;
		}

        damage = Math.round(damage);

        if (display) outputText("Your elemental charges electricity, then discharges it with a blinding bolt doing ");
		doLightningDamage(damage, true, display);
		if (crit && display) outputText(" <b>Critical!</b>");
		outputText("\n\n");
    }
}
}  