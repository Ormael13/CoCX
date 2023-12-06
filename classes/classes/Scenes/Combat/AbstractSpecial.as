package classes.Scenes.Combat {

import classes.StatusEffectType;
import classes.PerkType;
import classes.Races;

public class AbstractSpecial extends CombatAbility {
    protected var knownCondition:*;

    public function AbstractSpecial (
            name:String,
            desc:String,
            targetType:int,
            timingType:int,
            tags:/*int*/Array,
            knownCondition:*
    ) {
        super(name, desc, targetType, timingType, tags);
        this.knownCondition = knownCondition;
    }

    override public function get isKnown():Boolean {
        if (knownCondition is StatusEffectType)
            return player.hasStatusEffect(knownCondition);
        if (knownCondition is PerkType)
            return player.hasPerk(knownCondition);
        if (knownCondition is Races)
            return player.isRaceCached(knownCondition);
        return false;
    }

    override public function useResources():void {
        super.useResources();

        var finalManaCost:Number = manaCost();
        var finalFatigueCost:Number = fatigueCost();
        var finalSFCost:Number = sfCost();
        var finalWrathCost:Number = wrathCost();

        if (finalManaCost > 0) {
            useMana(finalManaCost);
        }

        if (finalFatigueCost > 0) {
            fatigue(finalFatigueCost);
        }

        if (finalSFCost > 0) {
            player.soulforce -= finalSFCost;
        }

        if (finalWrathCost > 0) {
            player.wrath -= finalWrathCost;
        }   
    }

    override protected function usabilityCheck():String {
        // Run all check applicable to all abilities
		var uc:String = super.usabilityCheck();
		if (uc) return uc;

        if (player.fatigueLeft() < fatigueCost()) {
			return "You are too tired to use this ability."
		}

        if (player.mana < manaCost()) {
			return "Your mana is too low to use this ability."
		}

        if (player.soulforce < sfCost()) {
			return "Your soulforce is too low to use this ability."
		}

        if (player.wrath < wrathCost()) {
			return "Your wrath is too low to use this ability!"
		}

        return "";
    }

    protected function sfCostMod(sfCost:Number):int {
        return Math.round(sfCost * soulskillCost() * soulskillcostmulti());
    }
}
}
