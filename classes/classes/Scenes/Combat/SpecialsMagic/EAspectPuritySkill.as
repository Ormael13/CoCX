package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.Combat;

public class EAspectPuritySkill extends AbstractMagicSpecial {
    public function EAspectPuritySkill() {
        super (
            "Elemental Aspect: Purity",
            "Attack with a stronger version of a purity-attributed basic elemental attack. Damage is increased the more corrupt the enemy.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_MAGICAL, TAG_TIER2],
            StatusEffects.SummonedElementalsPurity
        )
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

    override public function calcCooldown():int {
        return -1;
    }

    override public function get buttonName():String {
		return "Purity E.Asp";
	}

    override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(monster)) + " magical damage";
    }

    public function calcDamage(monster:Monster):Number {
        var damage:Number = elementalAspectBaseDamage(StatusEffects.SummonedElementalsPurity);
        damage = elementalAspectDamageMod(StatusEffects.SummonedElementalsPurity, damage);
        if (monster) damage *= combat.purityScalingDA();

        return damage;
    }

    override public function manaCost():Number {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsPurity);
    }

    override public function doEffect(display:Boolean = true):void {
        var damage:Number = calcDamage(monster);

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

        if (display) outputText("Your purity elemental produces a ray of hyper condensed and pure light and aims it straight at [themonster] ");
		doMagicDamage(damage, true, display);
		if (crit && display) outputText(" <b>Critical!</b>");
		outputText("\n\n");
    }
}
}  