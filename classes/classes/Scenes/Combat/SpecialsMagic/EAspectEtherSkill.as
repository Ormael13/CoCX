package classes.Scenes.Combat.SpecialsMagic {

import classes.Scenes.Combat.AbstractMagicSpecial;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.Combat;

public class EAspectEtherSkill extends AbstractMagicSpecial {
    public function EAspectEtherSkill() {
        super (
            "Elemental Aspect: Ether",
            "Attack with a stronger version of a ether-attributed basic elemental attack. Deals increased damage if the enemy is weak to Fire, Ice, Lightning or Darkness.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_MAGICAL, TAG_TIER2],
            StatusEffects.SummonedElementalsEther
        )
        this.lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

    override public function calcCooldown():int {
        return -1;
    }

    override public function get buttonName():String {
		return "Ether E.Asp";
	}

    override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(monster)) + " magic damage";
    }

    override public function manaCost():Number {
        return elementalAspectManaCost(StatusEffects.SummonedElementalsEther);
    }

    public function calcDamage(monster:Monster):Number {
        var damage:Number = elementalAspectBaseDamage(StatusEffects.SummonedElementalsEther);
        damage = elementalAspectDamageMod(StatusEffects.SummonedElementalsEther, damage);
        damage *= 0.5;

        if (monster && monster.hasPerk(PerkLib.FireNature)) damage *= 5;
		if (monster && monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
		if (monster && monster.hasPerk(PerkLib.IceNature)) damage *= 5;
		if (monster && monster.hasPerk(PerkLib.IceVulnerability)) damage *= 2;
		if (monster && monster.hasPerk(PerkLib.LightningNature)) damage *= 5;
		if (monster && monster.hasPerk(PerkLib.LightningVulnerability)) damage *= 2;
		if (monster && monster.hasPerk(PerkLib.DarknessNature)) damage *= 5;
		if (monster && monster.hasPerk(PerkLib.DarknessVulnerability)) damage *= 2;

        return damage;
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

        if (display) outputText("Your elemental unleash a barrage of star shaped bolts of arcane energy, blasting your opponent. ");
		doMagicDamage(damage, true, display);
		if (crit && display) outputText(" <b>Critical!</b>");
		outputText("\n\n");
    }
}
}  