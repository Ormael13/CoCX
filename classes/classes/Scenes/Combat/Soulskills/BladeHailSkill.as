package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;

public class BladeHailSkill extends AbstractSoulSkill {
	//Skill name, number of attacks, status effect to sjow knowledge of skill, base SF cost, cooldown, number of attack rounds, hits per attack round
	private var hailArray:Array = [
		["Hail of Blades", "six", StatusEffects.KnowsHailOfBlades, 50, 0, 6, 1],
		["Grandiose Hail Of Blades", "eighteen", StatusEffects.KnowsGrandioseHailOfBlades, 200, 3, 9, 2],
		["Grandiose Hail Of Moon Blades", "fifty-six", StatusEffects.KnowsGrandioseHailOfMoonBlades, 800, 9, 19, 4]
	];
	private var hailSelection:int;
	private var count:int;

    public function BladeHailSkill(count: int) {
        super(
            count < 4 && count > 0? hailArray[count - 1][0]: "Thrust",
            "Form " + hailArray[count - 1][1] + " weapons from your soulforce traveling at extreme speeds.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_MAGICAL],
            count < 4 && count > 0? hailArray[count - 1][2]: null
        )
		hailSelection = count - 1;
		baseSFCost = hailArray[hailSelection][3];
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
		switch (hailSelection) {
			case 0: return "Hail of Blades";
			case 1: return "G.Hail of Blades";
			case 2: return "G.Hail of M.Blades";
			default: return "";
		}
	}

	override public function describeEffectVs(target:Monster):String {
		var attackRounds:int = hailArray[hailSelection][6];
		var attacksPerRound:int = hailArray[hailSelection][5]
		return "~" + numberFormat(Math.round(calcHailDamage() * attacksPerRound * attackRounds)) + " magical damage" 
	}

	override public function calcCooldown():int {
		var baseCooldown:int = hailArray[hailSelection][4];
		switch (hailSelection) {
			case 2: return soulskillTier3Cooldown(baseCooldown, false);
					break;
			case 1: return soulskillTier2Cooldown(baseCooldown, false);
					break;
			case 0: 
			default:return soulskillCooldown(baseCooldown, false);
					break;
		}
	}

	private function calcHailDamage():Number {
		var damage:Number = player.wis;
		damage += scalingBonusWisdom() * 2;
		if (damage < 10) damage = 10;
		//soulskill mod effect
		damage *= soulskillMagicalMod();
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType)))) damage *= 2;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5)) damage *= 1.5;
		return damage;
	}

	private function fireHail(hits:int = 1, display:Boolean = true):void {
		var damage:Number = calcHailDamage();
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		critChance += combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		var d2:Number = 0.9;
		d2 += (rand(21) * 0.01);
		damage *= d2;
		if (display) outputText(" ");
		doMagicDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		if (hits == 2) {
			if (display) outputText(" ");
			doMagicDamage(damage, true, display);
			if (crit && display) outputText(" <b>*Critical Hit!*</b>");
			damage *= 2;
		}
		if (hits == 4) {
			if (display) outputText(" ");
			doMagicDamage(damage, true, display);
			if (crit && display) outputText(" <b>*Critical Hit!*</b>");
			if (display) outputText(" ");
			doMagicDamage(damage, true, display);
			if (crit && display) outputText(" <b>*Critical Hit!*</b>");
			if (display) outputText(" ");
			doMagicDamage(damage, true, display);
			if (crit && display) outputText(" <b>*Critical Hit!*</b>");
			damage *= 4;
		}
		checkAchievementDamage(damage);
		if (player.hasStatusEffect(StatusEffects.HeroBane)) flags[kFLAGS.HERO_BANE_DAMAGE_BANK] += damage;
		if (player.hasStatusEffect(StatusEffects.EruptingRiposte)) flags[kFLAGS.ERUPTING_RIPOSTE_DAMAGE_BANK] += monster.tou + monster.inte + monster.wis;
	}

    override public function doEffect(display:Boolean = true):void {
		if (display) outputText("Letting soulforce leak out around you, you form " + hailArray[hailSelection][1] + " ethereal two meter long weapons in four rows. You thrust your hand outwards and in the blink of an eye, weapons shoot forwards [themonster].  ");
		if (monsterDodgeSkill("weapons", display)) return;
		if (display) outputText("Weapons hits [themonster], dealing ");
		var rounds:Number = hailArray[hailSelection][5];
		while (rounds-->0) fireHail(hailArray[hailSelection][6], display);
		if (display) outputText(" damage!\n\n");
		if (!player.hasStatusEffect(StatusEffects.BloodCultivator) && flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] == 0) anubiHeartLeeching(flags[kFLAGS.HERO_BANE_DAMAGE_BANK]);
		combat.heroBaneProc2();
		combat.EruptingRiposte2();
    }
}
}