package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.Combat;

public class EAspectFireSkill extends AbstractMagicSpecial {
    public function EAspectFireSkill() {
        super (
            "Elemental Aspect: Fire",
            "Attack with a stronger version of a fire-attributed basic elemental attack",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_FIRE, TAG_MAGICAL, TAG_TIER2],
            StatusEffects.SummonedElementalsFire
        )
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

    override public function calcCooldown():int {
        return -1;
    }

    override public function get buttonName():String {
		return "Fire E.Asp";
	}

    override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(monster)) + " fire damage ";
    }

    override public function manaCost():Number {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsFire);
    }

    public function calcDamage(monster:Monster):Number {
        var damage:Number = elementalAspectBaseDamage(StatusEffects.SummonedElementalsFire);
        damage = elementalAspectDamageMod(StatusEffects.SummonedElementalsFire, damage);

        return damage;
    }

    override public function doEffect(display:Boolean = true):void {
        var damage:Number = calcDamage(monster);
        damage = calcInfernoMod(damage, true);

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

        if (display) outputText("Your fire elemental douses your opponent with a torrent of fire ");
		doFireDamage(damage, true, display);
		if (crit && display) outputText(" <b>Critical!</b>");
		outputText("\n\n");
    }
}
}  