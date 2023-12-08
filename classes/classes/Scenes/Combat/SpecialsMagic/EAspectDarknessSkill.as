package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.Combat;

public class EAspectDarknessSkill extends AbstractMagicSpecial {
    public function EAspectDarknessSkill() {
        super (
            "Elemental Aspect: Darkness",
            "Attack with a stronger version of a darkness-attributed basic elemental attack",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_DARKNESS, TAG_MAGICAL, TAG_TIER2],
            StatusEffects.SummonedElementalsDarkness
        )
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

    override public function calcCooldown():int {
        return -1;
    }

    override public function get buttonName():String {
		return "Darkness E.Asp";
	}

    override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(monster)) + " darkness damage";
    }

    override public function manaCost():Number {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsDarkness);
    }

    public function calcDamage(monster:Monster):Number {
        var damage:Number = elementalAspectBaseDamage(StatusEffects.SummonedElementalsDarkness);
        damage = elementalAspectDamageMod(StatusEffects.SummonedElementalsDarkness, damage);

        return damage;
    }

    override public function doEffect(display:Boolean = true):void {
        var damage:Number = calcDamage(monster);
        damage = calcEclypseMod(damage, true);

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

        if (display) outputText("Your darkness elemental condenses shadows into solid matter, striking your opponent with them ");
		doDarknessDamage(damage, true, display);
		if (crit && display) outputText(" <b>Critical!</b>");
		outputText("\n\n");
    }
}
}  