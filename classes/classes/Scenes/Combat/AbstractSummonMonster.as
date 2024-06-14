package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.StatusEffectType;
import classes.StatusEffects;
import classes.PerkLib;
import classes.IMutations.IMutationsLib;
import classes.PerkType;

public class AbstractSummonMonster extends SummonMonster {
	public function AbstractSummonMonster(
			name:String,
			desc:String,
			targetType:int,
			timingType:int,
			tags:/*int*/Array
			knownCondition:*,
            canUseBlood:Boolean = true
	) {
		super(name, desc, targetType, timingType, tags);
        this.knownCondition = knownCondition;
        this.canUseBlood = canUseBlood;
	}
	
	override public function get category():int {
		return CAT_SOULSKILL;
	}

	override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

        if ((player.soulforce < sfCost()) && (!player.hasStatusEffect(StatusEffects.BloodCultivator) || !canUseBlood)) {
            return "Your soulforce cannot bring out a monster."
        }

        if (canUseBlood && player.hasStatusEffect(StatusEffects.BloodCultivator) && ((player.HP - player.minHP()) - 1) < (sfCost())) {
            return "Your life points are too low. You cannot bring out another monster."
        }

        return "";
    }
	override public function sfCost():int {
        var soulforcecost:Number = baseSFCost * soulskillCost() * soulskillcostmulti();
        return Math.round(soulforcecost);
    }

    override public function get isKnown():Boolean {
        if (knownCondition is StatusEffectType)
            return player.hasStatusEffect(knownCondition);
        if (knownCondition is PerkType)
            return player.hasPerk(knownCondition);
        return false;
    }

    override public function useResources():void {
        super.useResources();
        if (player.hasStatusEffect(StatusEffects.BloodCultivator) && canUseBlood) {
            player.takePhysDamage(sfCost());
        } 
        else {
            player.soulforce -= sfCost();
        }
    }

    protected function display():String {
        return "";
    } 
	}
	
}
}