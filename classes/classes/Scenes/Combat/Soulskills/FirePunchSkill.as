package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Races;
import classes.Scenes.Combat.Combat;

public class FirePunchSkill extends AbstractSoulSkill {
    public function FirePunchSkill() {
        super(
            "Fire Punch",
            "Ignite your opponents dealing fire damage and setting them ablaze.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_FIRE, TAG_PHYSICAL],
            StatusEffects.KnowsFirePunch
        )
		baseSFCost = 30;
		lastAttackType = Combat.LAST_ATTACK_PHYS;
    }

    override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

		if ((player.hasPerk(PerkLib.ColdMastery) || player.hasPerk(PerkLib.ColdAffinity)) && (player.hasPerk(PerkLib.FireAffinity) || player.hasPerk(PerkLib.FireShadowAffinity) || player.hasPerk(PerkLib.AffinityIgnis))) {
			return "You call upon the power of flame...and you begin to sweat. You aren't built for the heat, and your body knows it.";
		}
		if (!player.isFistOrFistWeapon()) {
			return "<b>Your [weapon] can't be used with this soulskill.</b>";
		}

        return "";
    }

	override public function get buttonName():String {
		return "Fire Punch";
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target)) + " fire damage"
	}

	public function calcDamage(monster:Monster):Number {
		var damage:Number = 0;
		damage += combat.meleeUnarmedDamageNoLagSingle();
		if (player.hasPerk(PerkLib.SuperStrength) || player.hasPerk(PerkLib.BigHandAndFeet)) {
			damage += player.str;
			damage += scalingBonusStrength();
		}
		damage += player.wis;
		damage += scalingBonusWisdom() * 2;
		if (player.hasStatusEffect(StatusEffects.BlazingBattleSpirit)) {
			if (player.isRaceCached(Races.MOUSE, 2) && player.countRings(jewelries.INMORNG)) damage *= 2.2;
			else damage *= 2;
		}
		//soulskill mod effect
		damage *= soulskillPhysicalMod();
		//other bonuses
		if (player.hasPerk(PerkLib.PerfectStrike) && monster && monster.monsterIsStunned()) damage *= 1.5;
		if (player.hasPerk(PerkLib.Heroism) && monster && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5)) damage *= 1.5;
		damage *= combat.fireDamageBoostedByDao();
		return Math.round(damage);

	}

    override public function doEffect(display:Boolean = true):void {
		var damage:Number = calcDamage(monster);
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combat.combatPhysicalCritical();
		if (player.hasPerk(PerkLib.ElvenSense) && player.inte >= 50) critChance += 5;
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		monster.createStatusEffect(StatusEffects.FirePunchBurnDoT,16,0,0,0);
		if (display) outputText("Setting your fist ablaze, you rush at [themonster] and scorch [monster him] with your searing flames. ");
		combat.checkForElementalEnchantmentAndDoDamageMain(damage, true, true, crit, false, 3);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		endTurnBySpecialHit(damage, display);
    }
}
}