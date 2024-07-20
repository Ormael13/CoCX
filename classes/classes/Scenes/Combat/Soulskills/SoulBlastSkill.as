package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class SoulBlastSkill extends AbstractSoulSkill {
    public function SoulBlastSkill() {
        super(
            "Soul Blast",
            "Focus your reserves of soul force to unleash a torrent of devastating energy and obliterate your opponent.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_MAGICAL, TAG_TIER3],
            StatusEffects.KnowsSoulBlast
        )
		baseSFCost = 900;
		lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

	override public function get buttonName():String {
		return "Soul Blast";
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target)) + " magical damage, Stuns for 3 rounds"
	}

	override public function calcCooldown():int {
        return soulskillTier3Cooldown(10, false);
    }

	public function calcDamage(monster:Monster):Number {
		var damage:Number = scalingBonusStrength() * 6;
		damage += scalingBonusIntelligence() * 6;
		damage += scalingBonusWisdom() * 6;
		if (damage < 10) damage = 10;
		
		//soulskill mod effect
		var damageMult:Number = 1;
		damageMult += (spellMod() - 1);
		damageMult += (soulskillMagicalMod() - 1);
		damage *= damageMult;

		//other bonuses
		if (monster) {
			if (player.hasPerk(PerkLib.PerfectStrike) && monster.monsterIsStunned()) damage *= 1.5;
			if (player.hasPerk(PerkLib.Heroism) && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType))) damage *= 2;
		}
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5)) damage *= 1.5;
		return Math.round(damage);
	}

    override public function doEffect(display:Boolean = true):void {
		var damage:Number = calcDamage(monster);

		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}

		if (display) outputText("You wave the sign of the gate, tiger and serpent as you unlock all of your soulforce for an attack. [Themonster] can’t figure out what you are doing until a small sphere of energy explodes at the end of your fist in a massive beam of condensed soulforce. ");
		doMagicDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 3, 0, 0, 0);
		else {
			if (display) {
				outputText("  <b>[Themonster] ");
				if(!monster.plural) outputText("is ");
				else outputText("are ");
				outputText("too resolute to be stunned by your attack.</b>");
			}
		}
		checkAchievementDamage(damage);
		if (display) outputText("\n\n");
		if (!player.hasStatusEffect(StatusEffects.BloodCultivator) && flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] == 0) anubiHeartLeeching(damage);
		combat.heroBaneProc(damage);
    }
}
}