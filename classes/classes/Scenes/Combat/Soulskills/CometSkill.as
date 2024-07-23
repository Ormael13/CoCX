package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class CometSkill extends AbstractSoulSkill {
    public function CometSkill() {
        super(
            "Comet",
            "Project a shard of soulforce, which will come crashing down upon your opponent as a crystalline comet.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_AOE, TAG_MAGICAL, TAG_TIER2],
            StatusEffects.KnowsComet
        )
		baseSFCost = 400;
		lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

    override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

		if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathMagicalAbilities()) {
			return "You are too angry to think straight. Smash your puny opponents first and think later.";
		}

        return "";
    }

	override public function get buttonName():String {
		return "Comet";
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target)) + " magical damage"
	}

	override public function calcCooldown():int {
		return soulskillTier2Cooldown(4, false);
	}

	public function calcDamage(monster:Monster):Number {
		var damage:Number = scalingBonusWisdom() * 6;
		if (damage < 10) damage = 10;
		//soulskill mod effect
		damage *= soulskillMagicalMod();
		//group enemies bonus
		if (monster && monster.plural) damage *= 5;
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType)))) damage *= 2;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5)) damage *= 1.5;
		return Math.round(damage);
	}

    override public function doEffect(display:Boolean = true):void {
		if (display) {
			outputText("You focus for a moment, projecting a fragment of your soulforce above you.  A moment later, a prismatic comet crashes down on your opponents [themonster].  ");
			if (monster.plural) outputText("Shattering into thousands of fragments that shower anything and everything around you.  ");
		}
		if (monsterDodgeSkill("comet fragments", display)) return;
		var damage:Number = calcDamage(monster);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		//final touches
		if (display) outputText("Comet fragments hits [themonster], dealing ");
		doMagicDamage(damage, true, display);
		if (display) outputText(" damage! ");
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		if (display) outputText("\n\n");
		if (!player.hasStatusEffect(StatusEffects.BloodCultivator) && flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] == 0) anubiHeartLeeching(damage);
		combat.heroBaneProc(damage);
    }
}
}