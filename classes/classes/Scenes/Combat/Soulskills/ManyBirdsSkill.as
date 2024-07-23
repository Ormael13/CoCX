package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class ManyBirdsSkill extends AbstractSoulSkill {
    public function ManyBirdsSkill() {
        super(
            "Many Birds",
            "Project a figment of your soulforce as a crystal traveling at extreme speeds.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_MAGICAL, TAG_TIER1, TAG_AOE],
            StatusEffects.KnowsManyBirds
        )
		baseSFCost = 200;
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
		return "Many Birds";
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target)) + " magical damage";
	}

	override public function calcCooldown():int {
		return soulskillCooldown(2, false);
	}

	public function calcDamage(monster:Monster):Number {
		var damage:Number = scalingBonusWisdom() * 2;
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
		if (silly()) 
			if (display) outputText("You focus your soulforce, projecting it as an aura around you.  As you concentrate, dozens, hundreds, thousands of tiny, ethereal birds shimmer into existence.  As you raise your hand up, more and more appear, until the area around you and [themonster]  is drowned in spectral flappy shapes.  ");
		else {
			outputText("You thrust your hand outwards with deadly intent, and in the blink of an eye a storm of crystals shoot towards [themonster].  ");
			if (monsterDodgeSkill("crystal storm", display)) return;
		}
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
		if (silly ()) {
			if (display) {
				outputText("You snap your fingers, and at once every bird lends their high pitched voice to a unified, glass shattering cry:");
				outputText("\n\n\"<i>AAAAAAAAAAAAAAAAAAAAAAAAAAAAA</i>\" ([themonster] takes ");
			}
			doMagicDamage(damage, true, display);
			if (display) outputText(" damage) ");
		}
		else {
			if (display) outputText("The crystals hit [themonster], dealing ");
			doMagicDamage(damage, true, display);
			if (display) outputText(" damage! ");
		}
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		if (display) outputText("\n\n");
		if (!player.hasStatusEffect(StatusEffects.BloodCultivator) && flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] == 0) anubiHeartLeeching(damage);
		combat.heroBaneProc(damage);
    }
}
}