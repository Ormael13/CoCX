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
}
}