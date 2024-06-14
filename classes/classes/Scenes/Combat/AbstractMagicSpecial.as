package classes.Scenes.Combat {

import classes.StatusEffectType;
import classes.PerkType;
import classes.Races;
import classes.PerkLib;
import classes.StatusEffects;

public class AbstractMagicSpecial extends AbstractSpecial {

    public function AbstractMagicSpecial (
            name:String,
            desc:String,
            targetType:int,
            timingType:int,
            tags:/*int*/Array,
            knownCondition:*
    ) {
        super(name, desc, targetType, timingType, tags, knownCondition);
        this.knownCondition = knownCondition;
    }

	override public function get category():int {
        return CAT_MAGICAL_SPECIAL;
    }

    /**
    * Function to be used with elemental aspect magic specials to produce their base damage based on the level of the associated basic element
    * @param aspectStatusEffect StatusEffectType - contains the level of the assoicatedbasic elemental
    * @param damage Number - the starting damage of the function
    * @param halfEffect Boolean - Used with Wood Elemental Aspect, halves the effects of each modifier
    * @return damage Number - The final caluclated damage
    */
    protected function elementalAspectBaseDamage(aspectStatusEffect: StatusEffectType, damage:Number = 0, halfEffect:Boolean = false):Number {
        var multiplier:Number = halfEffect? 0.5: 1;
        var multiInt:Number = 0.5 * multiplier;
		var multiWis:Number = 0.5 * multiplier;
		if (player.statusEffectv2(aspectStatusEffect) >= 2) {
			multiInt += (0.2 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 1);
			multiWis += (0.2 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 1);
		}
		if (player.statusEffectv2(aspectStatusEffect) >= 5) {
			multiInt += (0.1 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 4);
			multiWis += (0.1 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 4);
		}
		if (player.statusEffectv2(aspectStatusEffect) >= 9) {
			multiInt += (0.1 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 8);
			multiWis += (0.1 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 8);
		}
		if (player.statusEffectv2(aspectStatusEffect) >= 13) {
			multiInt += (0.1 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 12);
			multiWis += (0.1 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 12);
		}
		if (player.statusEffectv2(aspectStatusEffect) >= 17) {
			multiInt += (0.1 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 16);
			multiWis += (0.1 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 16);
		}
		if (player.statusEffectv2(aspectStatusEffect) >= 21) {
			multiInt += (0.1 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 20);
			multiWis += (0.1 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 20);
		}
		if (player.statusEffectv2(aspectStatusEffect) >= 25) {
			multiInt += (0.1 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 24);
			multiWis += (0.1 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 24);
		}
		if (player.statusEffectv2(aspectStatusEffect) >= 29) {
			multiInt += (0.1 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 28);
			multiWis += (0.1 * multiplier) * (player.statusEffectv2(aspectStatusEffect) - 28);
		}
		damage += scalingBonusIntelligence() * multiInt;
		damage += scalingBonusWisdom() * multiWis;
        return damage;
    }

    protected function elementalAspectBaseDuration(aspectStatusEffect: StatusEffectType, duration:int = 0):int {
        if (player.statusEffectv2(aspectStatusEffect) >= 1) duration += player.statusEffectv2(aspectStatusEffect);
        if (player.statusEffectv2(aspectStatusEffect) >= 9) duration += player.statusEffectv2(aspectStatusEffect) - 8;
        if (player.statusEffectv2(aspectStatusEffect) >= 21) duration += player.statusEffectv2(aspectStatusEffect) - 20;

        return duration;
    }

    protected function elementalAspectDamageMod(aspectStatusEffect: StatusEffectType, damage:Number = 0):Number {
        damage *= combat.elementalAmplificationMod(5 * player.statusEffectv2(aspectStatusEffect));

        var perkMultiplier:Number = 1;
		if (player.hasPerk(PerkLib.FirstAttackElementalsEx) && player.hasStatusEffect(StatusEffects.SummonedElementals)) perkMultiplier += 1;
		if (player.hasPerk(PerkLib.FirstAttackElementalsSu)) perkMultiplier += 2;
		damage *= perkMultiplier;

		damage *= 3;

        return damage;
    }

	protected function elementalAspectManaCost(aspectStatusEffect: StatusEffectType, manaCost:Number = 1):Number {
		var manaCostInt:Number = 8;
		var manaCostWis:Number = 8;
		var summonedElementals:Number = 5 * player.statusEffectv2(aspectStatusEffect);

		if (player.hasPerk(PerkLib.FirstAttackElementalsSu)) {
			manaCostInt += 17;
			manaCostWis += 42;
		}
		manaCost += summonedElementals;
		if (summonedElementals >= 11) manaCost += summonedElementals;
		if (summonedElementals >= 21) manaCost += summonedElementals;
		if (summonedElementals >= 29) manaCost += summonedElementals;
		manaCost += player.inte / manaCostInt;
		manaCost += player.wis / manaCostWis;
		if (summonedElementals >= 2 && manaCost > 11 && player.hasPerk(PerkLib.StrongElementalBond)) manaCost -= 10;
		if (summonedElementals >= 4 && manaCost > 22 && player.hasPerk(PerkLib.StrongElementalBondEx)) manaCost -= 20;
		if (summonedElementals >= 6 && manaCost > 33 && player.hasPerk(PerkLib.StrongElementalBondSu)) manaCost -= 30;
		if (summonedElementals >= 9 && manaCost > 44 && player.hasPerk(PerkLib.StrongerElementalBond)) manaCost -= 40;
		if (summonedElementals >= 12 && manaCost > 55 && player.hasPerk(PerkLib.StrongerElementalBondEx)) manaCost -= 50;
		if (summonedElementals >= 15 && manaCost > 66 && player.hasPerk(PerkLib.StrongerElementalBondSu)) manaCost -= 60;
		if (summonedElementals >= 19 && manaCost > 77 && player.hasPerk(PerkLib.StrongestElementalBond)) manaCost -= 70;
		if (summonedElementals >= 23 && manaCost > 88 && player.hasPerk(PerkLib.StrongestElementalBondEx)) manaCost -= 80;
		if (summonedElementals >= 27 && manaCost > 99 && player.hasPerk(PerkLib.StrongestElementalBondSu)) manaCost -= 90;
		if (manaCost > 1 && player.hasPerk(PerkLib.FirstAttackElementalsSu)) manaCost *= 0.5;
		return Math.round(manaCost);
	}
}
}