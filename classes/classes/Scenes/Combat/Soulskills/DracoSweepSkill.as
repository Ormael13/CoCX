package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Combat.Combat;
import classes.Items.Weapons.Tidarion;

public class DracoSweepSkill extends AbstractSoulSkill {
    public function DracoSweepSkill() {
        super(
            "Drace Sweep",
            "Use a little bit of soulforce to empower your weapon, then sweep ahead hitting as many enemies as possible.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_PHYSICAL],
            StatusEffects.KnowsDracoSweep
        )
		baseSFCost = 50;
		lastAttackType = Combat.LAST_ATTACK_PHYS;
    }

	override public function get buttonName():String {
		return "Draco Sweep";
	}

	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target)) + " damage"
	}

	public function calcDamage(monster:Monster):Number {
		var damage:Number = scalingBonusWisdom() * 2;
		damage += combat.meleeDamageNoLagSingle();
		damage *= 1.75;
		//All special weapon effects like...fire/ice
		if (player.haveWeaponForJouster()) {
			if (player.isPolearmTypeWeapon()) damage *= 0.75;
			if (player.isTaur() || player.isDrider()) damage *= 2;
			if (player.isMeetingNaturalJousterReq()) damage *= 3;
			if (player.isMeetingNaturalJousterMasterGradeReq()) damage *= 5;
		}
		if ((player.weapon == weapons.L_WHIP || player.weapon == weapons.DL_WHIP || player.weapon == weapons.TIDAR) && monster) {
			if (monster.hasPerk(PerkLib.IceNature)) damage *= 5;
			if (monster.hasPerk(PerkLib.FireVulnerability)) damage *= 2;
			if (monster.hasPerk(PerkLib.IceVulnerability)) damage *= 0.5;
			if (monster.hasPerk(PerkLib.FireNature)) damage *= 0.2;
		}
		//soulskill mod effect
		damage *= soulskillPhysicalMod();
		//group enemies bonus
		if (monster && monster.plural) damage *= 5;
		//other bonuses
		if (player.armor.name == "some taur paladin armor" || player.armor.name == "some taur blackguard armor") damage *= 2;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5)) damage *= 1.5;
		return Math.round(damage);
	}

    override public function doEffect(display:Boolean = true):void {
		if (display) outputText("You ready your [weapon] and prepare to sweep it towards [themonster].  ");
		if (monsterDodgeSkill("attack", display)) return;
		var damage:Number = calcDamage(monster);
		if (player.weapon == weapons.TIDAR) (player.weapon as Tidarion).afterStrike();
		if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
			damage = combat.fireTypeDamageBonus(damage);
			if (player.lust > player.lust100 * 0.5) dynStats("lus", -1, "scale", false);
			damage *= 1.1;
		}
		var crit:Boolean = false;
		var critChance:int = 5;
		if (player.weapon.isSwordType() || player.weaponOff.isSwordType()) critChance += 10;
		if (player.weapon.isDuelingType() || player.weaponOff.isDuelingType()) critChance += 20;
		critChance += combat.combatPhysicalCritical();
		if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
		if (rand(100) < critChance) {
			crit = true;
			var buffMultiplier:Number = 0;
			buffMultiplier += combat.bonusCriticalDamageFromMissingHP();
			if (player.hasPerk(PerkLib.Impale) && player.spe >= 100 && player.haveWeaponForJouster()) damage *= ((1.75 + buffMultiplier) * combat.impaleMultiplier());
			else damage *= (1.75 + buffMultiplier);
		}
		if (display) outputText("Your [weapon] sweeps against [themonster], dealing ");
		combat.checkForElementalEnchantmentAndDoDamageMain(damage);
		if (display) outputText(" damage! ");
		if (crit) {
			if (display) outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		endTurnBySpecialHit(damage);
    }
}
}