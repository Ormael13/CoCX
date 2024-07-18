package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class SunriseSkill extends AbstractSoulSkill {
    public function SunriseSkill() 
	{
			super(
            "Sunrise",
            "Form a miniature sun to toss at the enemy.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_AOE, TAG_PLASMA, TAG_TIER2],
            StatusEffects.KnowsSunrise
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
		return "Sunrise";
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
			outputText("Glaring at [themonster], you feel your soul rising within you, a burning heat that radiates from your heart, down your left arm, and as you raise a finger to the sky above, you breathe, actively stoking the fire within your soul as it rises, a sphere of plasma forming just above your fingertip.\n\n");
			outputText("Your body, suddenly casting a stark shadow on the ground below, is dwarfed by the rapidly growing sun on your finger. The ball balances perfectly on your finger, and you can see your [themonster], a sullen, bleak mark on the world around, warmed by your radiance. For a moment, the world seems to slow, waiting on the gravity of your Sun.\n\n");
			outputText("You make your decision. You bring your finger down, pointing at the [themonster]. You stare down your nose at them, those who dare oppose you.\n\n");
			outputText("\"<i>Sunrise</i>\" The word comes out, calm yet firm, in a majestic tone. Your miniature sun is launched from your finger, engulfing the [themonster] with your power. ");
		}
		if (monsterDodgeSkill("miniature sun", display)) return;

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
		doPlasmaDamage(damage, true, display);
		if (display) outputText(" damage! ");
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		if (display) outputText("\n\n");
		if (!player.hasStatusEffect(StatusEffects.BloodCultivator) && flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] == 0) anubiHeartLeeching(damage);
		combat.heroBaneProc(damage);
    }
}
}