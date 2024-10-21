package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;
import classes.Races;

public class FingerOfDeathSkill extends AbstractSoulSkill {
    public function FingerOfDeathSkill() {
        super(
            "Finger Of Death",
            "Inflict massive dark damage. Also damage the opponent's toughness and strength by 10 percent. Ineffective on foes who lack a soul.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_DARKNESS, TAG_DEBUFF, TAG_MAGICAL],
            null
        )
		baseSFCost = 200;
		lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

    override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

		if (monster && monster.hasPerk(PerkLib.EnemyTrueDemon)) {
			return "You can't use this soulskill on somoene truly souless.";
		}
		if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathMagicalAbilities()) {
			return "You are too angry to think straight. Smash your puny opponents first and think later.";
		}

        return "";
    }

	override public function get buttonName():String {
		return "Finger Of Death";
	}

	override public function get isKnown():Boolean {
		return player.racialScore(Races.ANUBIS) >= 20;
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target, false)) + " magical damage";
	}

	override public function calcCooldown():int {
		var cooldown:int = 6;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4) cooldown -= 2;
		return soulskillTier2Cooldown(cooldown, false);
	}

	public function calcDamage(monster:Monster, casting:Boolean = false):Number {
		var damage:Number = (scalingBonusWisdom() + scalingBonusIntelligence()) * 2;
		if (damage < 20) damage = 20;

		//soulskill mod effect
		var damageMult:Number = 1;
		damageMult += (spellMod() - 1);
		damageMult += (soulskillMagicalMod() - 1);
		damage *= damageMult;
		
		damage = calcEclypseMod(damage, casting);

		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5)) damage *= 1.5;
		if (player.armor == armors.DEATHPGA) damage *= 1.5;
		return Math.round(damage * combat.darknessDamageBoostedByDao());
		
	}


    override public function doEffect(display:Boolean = true):void {
		if (display) outputText("You point a finger at your opponent condemning [monster his] soul as you call on to the power of death to claim a part of [monster him] early!"
			+ " A ghastly claw appears and pierces through [themonster] body tearing [monster his] soul apart.  ");
		combat.darkRitualCheckDamage();

		var damage:Number = calcDamage(monster, true);

		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		if (display) outputText(" ");

		doDarknessDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		monster.statStore.addBuffObject({str:-10*(monster.str/100),tou:-10*(monster.tou/100)}, "Finger of death",{text:"Finger of death"});

		checkAchievementDamage(damage);
		if (display) outputText("\n\n");
		if (!player.hasStatusEffect(StatusEffects.BloodCultivator) && flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] == 0) anubiHeartLeeching(damage);
		combat.heroBaneProc2();
		combat.EruptingRiposte2();
    }
}
}