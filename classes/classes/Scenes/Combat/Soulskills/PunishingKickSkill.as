package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.Races;
import classes.StatusEffects;
import classes.Monster;
import classes.Scenes.Combat.Combat;

public class PunishingKickSkill extends AbstractSoulSkill {
    public function PunishingKickSkill() {
        super(
            "Punishing Kick",
            "A vicious kick that can daze an opponent, reducing its damage for a while.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_DEBUFF, TAG_PHYSICAL, TAG_TIER2],
            StatusEffects.KnowsPunishingKick
        )
		baseSFCost = 30;
		lastAttackType = Combat.LAST_ATTACK_PHYS;
    }

    override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

        if (player.isDrider() || player.isGoo() || player.isNaga() || player.isScylla() || player.isAlraune()) {
				return "<b>Your legs do not allow you to use this technique.</b>";
		}

        return "";
    }

	override public function get buttonName():String {
		return "Punishing Kick";
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target)) + " damage, Lowers enemy damage by 50% for " + calcCooldown() + " rounds"
	}

	override public function calcCooldown():int {
        return soulskillTier2Cooldown(10);
    }

	override public function calcDuration():int {
        return 5;
    }

	public function calcDamage(monster:Monster):Number {
		var damage:Number = 0;
		damage += combat.meleeUnarmedDamageNoLagSingle();
		damage += player.wis;
		damage += scalingBonusWisdom() * 6;
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			if (player.isRaceCached(Races.MOUSE, 2) && player.countRings(jewelries.INMORNG)) damage *= 2.2;
			else damage *= 2;
			damage = combat.fireTypeDamageBonusLarge(damage);
		}
		//soulskill mod effect
		damage *= soulskillPhysicalMod();
		//other bonuses
		if (monster) {
			if (player.hasPerk(PerkLib.PerfectStrike) && monster.monsterIsStunned()) damage *= 1.5;
			if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		}
		return Math.round(damage);

	}

    override public function doEffect(display:Boolean = true):void {        

		var damage:Number = calcDamage(monster);

		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			damage = combat.fireTypeDamageBonus(damage);
			damage *= 1.1;
		}

		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		monster.createStatusEffect(StatusEffects.PunishingKick, calcDuration(), 0, 0, 0);
		if (display) outputText("You lash out with a devastating kick, knocking your opponent back and disorienting it. [Themonster] is knocked off balance by the ferocious blow! ");
		combat.checkForElementalEnchantmentAndDoDamageMain(damage, true, true, crit, false, 1);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		endTurnBySpecialHit(damage, display);
		
    }
}
}