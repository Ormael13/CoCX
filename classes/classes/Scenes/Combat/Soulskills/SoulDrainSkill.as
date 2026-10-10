package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;
import classes.Races;

public class SoulDrainSkill extends AbstractSoulSkill {
    public function SoulDrainSkill() {
        super(
            "Soul Drain",
            "Damage victim’s soul force directly, inflicting suffering both physical and spiritual in the form of heavy dark damage." + 
			"Ineffective on foes who lack a soul. Gain Healing as a percentage of the soul force stolen.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_HEALING],
            null,
			false
        )
		baseSFCost = 100;
		lastAttackType = Combat.LAST_ATTACK_SPELL;
    }

    override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

		if (monster && monster.hasPerk(PerkLib.EnemyTrueDemon)) {
			return "You can't use this soulskill on someone truly souless.";
		}
		if (player.hasStatusEffect(StatusEffects.OniRampage) || player.wrath > player.maxSafeWrathMagicalAbilities()) {
			return "You are too angry to think straight. Smash your puny opponents first and think later.";
		}

        return "";
    }

	override public function get buttonName():String {
		return "Soul Drain";
	}

	override public function get isKnown():Boolean {
		return player.racialScore(Races.ANUBIS) >= 20;
	}

	override public function describeEffectVs(target:Monster):String {
		var monsterDrain: String;
		if (target)
			monsterDrain = " health and drains ~" + numberFormat(calcSoulforceDrain(target)) + " soulforce from the enemy";
		else
			monsterDrain = "";

		return "Deals ~" + numberFormat(calcDamage(target, false)) + " magical damage, heals ~" + numberFormat(calcHealAmount()) + monsterDrain;
	}

	public function calcDamage(monster:Monster, casting:Boolean = false):Number {
		var damage:Number = scalingBonusWisdom() + scalingBonusIntelligence();
		if (damage < 10) damage = 10;
		//soulskill mod effect
		var damageMult:Number = 1;
		damageMult += (spellMod() - 1);
		damageMult += (soulskillMagicalMod() - 1);
		damage *= damageMult;
		damage = calcEclypseMod(damage, casting);
		//other bonuses
		if (player.hasPerk(PerkLib.Heroism) && (monster && (monster.hasPerk(PerkLib.EnemyBossType) || monster.hasPerk(PerkLib.EnemyHugeType)))) damage *= 2;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5)) damage *= 1.5;
		if (player.perkv1(IMutationsLib.UndeadMetabolismIM) >= 2) damage *= player.perkv1(IMutationsLib.UndeadMetabolismIM);
		if (player.hasPerk(PerkLib.ExanimationI)) damage *= combat.hollowSkillsAndSoulskillsBoost();
		if (player.hasPerk(PerkLib.WayOfTheClosestFist) && checkWayOfTheClosestFist()) damage *= 2;
		if (player.armor == armors.DEATHPGA) damage *= 1.5;
		return Math.round(damage * combat.darknessDamageBoostedByDao());
	}

	private function calcHealAmount():int {
		var calcHA:Number = player.maxHP() * 0.2;
		if (player.perkv1(IMutationsLib.StillHeartIM) >= 1) calcHA *= (1 + (0.25 * player.perkv1(IMutationsLib.StillHeartIM)));
		if (player.perkv1(IMutationsLib.StillHeartIM) >= 3) calcHA += Math.round(player.maxHP() * 0.01 * (player.perkv1(IMutationsLib.StillHeartIM) - 2));
		if (player.hasPerk(PerkLib.Ethereal) && player.armor == armors.FUNERSH) calcHA *= 1.5;
		return Math.round(calcHA);
	}

	private function calcSoulforceDrain(monster: Monster):int {
		return Math.round(monster.maxSoulforce() * 0.2);
	}

    override public function doEffect(display:Boolean = true):void {
		if (display) outputText("You reach out with your magic and attempt to tear a part of your opponent soul. [monster his] scream in pain and horror as you attack [monster his] very essence!  ");
		combat.darkRitualCheckDamage();
		var damage:Number = calcDamage(monster, true);
		//Determine if critical hit!
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.hasPerk(PerkLib.WayOfTheClosestFist) && checkWayOfTheClosestFist()) critChance += 10;
		critChance *= combatMagicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			damage *= 1.75;
		}
		doPlayerDarknessDamage(damage, true, display);
		if (crit && display) outputText(" <b>*Critical Hit!*</b>");
		checkAchievementDamage(damage);
		if (player.perkv1(IMutationsLib.StillHeartIM) >= 2) pc.HPChange(calcHealAmount(), display, true);
		else pc.HPChange(calcHealAmount(), display, false);
		monster.addSoulforce(-calcSoulforceDrain(monster)); 
		if (display) outputText("\n\n");
		if (player.hasPerk(PerkLib.BrutalSpells) && monster.armorMDef > 0) {
			outputText("Your soulskills are so brutal that you damage [themonster]'s magical resistance!\n\n");
			var bbc:Number = (Math.round(monster.armorMDef * 0.1) + 5);
			if (monster.armorMDef - bbc > 0) monster.armorMDef -= bbc;
			else monster.armorMDef = 0;
		}
		anubiHeartLeeching(damage);
		combat.heroBaneProc(damage);	
    }
}
}