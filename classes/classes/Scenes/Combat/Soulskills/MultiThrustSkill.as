package classes.Scenes.Combat.Soulskills {
import classes.PerkLib;
import classes.Scenes.Combat.AbstractSoulSkill;
import classes.StatusEffects;
import classes.IMutations.IMutationsLib;
import classes.Monster;
import classes.GlobalFlags.kFLAGS;
import classes.Races;
import classes.Scenes.Combat.Combat;
import classes.Items.Weapons.Tidarion;

public class MultiThrustSkill extends AbstractSoulSkill {
	private var thrustArray:Array = [
		["Triple Thrust", "three", StatusEffects.KnowsTripleThrust, 30, "thrice", 0],
		["Sextuple Thrust", "six", StatusEffects.KnowsSextupleThrust, 70, "sixfold", 3],
		["Nonuple Thrust", "nine", StatusEffects.KnowsNonupleThrust, 150, "ninefold", 9]
	];
	private var thrustSelection:int;
	private var multiTrustDNLag:Number = 0;
	private var count:int;

    public function MultiThrustSkill(count: int) {
        super(
            count < 4 && count > 0? thrustArray[count - 1][0]: "Thrust",
            "Use a little bit of soulforce to infuse your weapon with power, striking your foe " + thrustArray[count - 1][1] + " times.",
            TARGET_ENEMY,
            TIMING_INSTANT,
            [TAG_DAMAGING, TAG_PHYSICAL],
            count < 4 && count > 0? thrustArray[count - 1][2]: null
        )
		thrustSelection = count - 1;
		baseSFCost = thrustArray[thrustSelection][3];
		lastAttackType = Combat.LAST_ATTACK_PHYS;
    }

	override public function get buttonName():String {
		return thrustArray[thrustSelection][0];
	}

	override public function describeEffectVs(target:Monster):String {
		multiTrustDNLag = 0;
		return "~" + numberFormat(Math.round(multiThrustDSingle(target, false) * ((thrustSelection + 1) * 3))) + " damage ";
	}

	override public function calcCooldown():int {
		var baseCooldown:int = thrustArray[thrustSelection][5];
		switch (thrustSelection) {
			case 2: return soulskillTier3Cooldown(baseCooldown);
					break;
			case 1: return soulskillTier2Cooldown(baseCooldown);
					break;
			case 0: 
			default:return soulskillCooldown(baseCooldown);
					break;
		}
	}

	private function multiThrustDSingle(monster: Monster, casting:Boolean = true):Number {
		var damage:Number = scalingBonusWisdom() * 2;
		damage += combat.meleeDamageNoLagSingle();
		damage *= 1.75;
		if (casting) {
			//All special weapon effects like...fire/ice
			if (player.weapon == weapons.TIDAR) (player.weapon as Tidarion).afterStrike();
			if (player.isFistOrFistWeapon() && player.hasStatusEffect(StatusEffects.HinezumiCoat)) {
				var damage1:Number = damage;
				damage = combat.fireTypeDamageBonus(damage);
				if (player.lust > player.lust100 * 0.5) dynStats("lus", -1, "scale", false);
				damage += damage1;
				damage *= 1.1;
			}
		}
		//soulskill mod effect
		damage *= soulskillPhysicalMod();
		//other bonuses
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5)) damage *= 1.5;
		if (monster && monster.hasStatusEffect(StatusEffects.FrozenSolid)) damage *= 2;
		return damage;
	}

	private function MultiThrustD(monster:Monster, display:Boolean):void {
		var damage:Number = 0;
		if (multiTrustDNLag != 0) damage += multiTrustDNLag;
		else {
			multiTrustDNLag += multiThrustDSingle(monster);
			damage += multiThrustDSingle(monster);
		}
		var d2:Number = 0.9;
		d2 += (rand(21) * 0.01);
		damage *= d2;
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
		if (display) outputText(" ");
		combat.checkForElementalEnchantmentAndDoDamageMain(damage);
		if (crit) {
			if (display) outputText(" <b>*Critical Hit!*</b>");
			if (player.hasStatusEffect(StatusEffects.Rage)) player.removeStatusEffect(StatusEffects.Rage);
		}
		if (!crit && player.hasPerk(PerkLib.Rage) && (player.hasStatusEffect(StatusEffects.Berzerking) || player.hasStatusEffect(StatusEffects.Lustzerking))) {
			if (player.hasStatusEffect(StatusEffects.Rage) && player.statusEffectv1(StatusEffects.Rage) > 5 && player.statusEffectv1(StatusEffects.Rage) < 70) player.addStatusValue(StatusEffects.Rage, 1, 10);
			else player.createStatusEffect(StatusEffects.Rage, 10, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		combat.WrathGenerationPerHit2(5);
		if (player.hasStatusEffect(StatusEffects.HeroBane)) flags[kFLAGS.HERO_BANE_DAMAGE_BANK] += damage;
		if (player.hasStatusEffect(StatusEffects.EruptingRiposte)) flags[kFLAGS.ERUPTING_RIPOSTE_DAMAGE_BANK] += monster.tou + monster.inte + monster.wis;
	}

    override public function doEffect(display:Boolean = true):void {
		if (display) outputText("You ready your [weapon] and prepare to thrust it towards [themonster].");
		if (monsterDodgeSkill("attack", display)) return;

		multiTrustDNLag = 0;
		var thrustCount:Number = (thrustSelection + 1) * 3;
		if (player.hasPerk(PerkLib.FlurryOfBlows) && player.isFistOrFistWeapon()) thrustCount *= 3;

		if (monster.hasStatusEffect(StatusEffects.FrozenSolid)) {
			if (display) outputText("Your [weapon] hits the ice in three specific points, making it explode along with your frozen adversary!");
			while (thrustCount-->0) MultiThrustD(monster, display);
			monster.statStore.removeBuffs("FrozenSolid");
			monster.removeStatusEffect(StatusEffects.FrozenSolid);
			if (display) outputText(" damage!");
		}
		else {
			if (display) outputText("Your [weapon] hits " + thrustArray[thrustSelection][4] + " against [themonster],");
			while (thrustCount-->0) MultiThrustD(monster, display);
			if (display) outputText(" damage!");
		}

		if (display) outputText("\n\n");
		if (!player.hasStatusEffect(StatusEffects.BloodCultivator) && flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] == 0) anubiHeartLeeching(flags[kFLAGS.HERO_BANE_DAMAGE_BANK]);
		combat.heroBaneProc2();
		combat.EruptingRiposte2();
    }
}
}