package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.StatusEffectType;
import classes.StatusEffects;
import classes.PerkLib;
import classes.IMutations.IMutationsLib;
import classes.PerkType;

public class AbstractSoulSkill extends CombatAbility {
    protected var knownCondition:*;
    protected var canUseBlood:Boolean;

    public function AbstractSoulSkill (
            name:String,
            desc:String,
            targetType:int,
            timingType:int,
            tags:/*int*/Array,
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
            return "Your current soulforce is too low."
        }

        if (canUseBlood && player.hasStatusEffect(StatusEffects.BloodCultivator) && ((player.HP - player.minHP()) - 1) < (sfCost())) {
            return "Your hp is too low to use this soulskill."
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


    protected function anubiHeartLeeching(dmg:Number):void {
		flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] = 1;
		var leech:Number = dmg;
		var leechCap:Number = 0.1;
		if (player.perkv1(IMutationsLib.AnubiHeartIM) >= 4 && player.HP < Math.round(player.maxHP() * 0.5)) {
			leechCap *= 2;
			leech *= 0.2;
		}
		else leech *= 0.1;
		leech = Math.round(leech);
		if (leech > Math.round(player.maxHP() * leechCap)) leech = Math.round(player.maxHP() * leechCap);
		HPChange(leech, false);
	}

	protected function monsterDodgeSkill(skillName:String, display:Boolean = true, hitModifier:int = 0):Boolean {
		if (((player.playerIsBlinded() && rand(2) == 0) || (monster.getEvasionRoll(false, player.spe, hitModifier))) && !monster.monsterIsStunned()) {
			if ((monster.spe - player.spe < 8) && display) outputText("[Themonster] narrowly avoids your " + skillName + "!\n\n");
			else if ((monster.spe-player.spe < 20) && display) outputText("[Themonster] dodges your " + skillName + " with superior quickness!\n\n");
			else if (display) outputText("[Themonster] deftly avoids your slow " + skillName + ".\n\n");
			return true;
		}
		return false;
	}

    protected function endTurnBySpecialHit(damage:Number, display: Boolean = true):void {
		checkAchievementDamage(damage);
		if (display) outputText("\n\n");
		combat.WrathGenerationPerHit2(5);
		if (!player.hasStatusEffect(StatusEffects.BloodCultivator) && flags[kFLAGS.IN_COMBAT_PLAYER_ANUBI_HEART_LEECH] == 0) anubiHeartLeeching(damage);
		combat.heroBaneProc(damage);
		combat.EruptingRiposte();
	}

	protected function endTurnByBloodSkillUse(damage:Number, display:Boolean = true, endOfTurn:Boolean = true):void {
		if (rand(20) < 4 && !monster.isImmuneToBleed()) {
			if (monster.hasStatusEffect(StatusEffects.Hemorrhage)) monster.addStatusValue(StatusEffects.Hemorrhage, 1, 1);
			else monster.createStatusEffect(StatusEffects.Hemorrhage, 2, 0.05, 0, 0);
			if (display) outputText(" The attack leaves many bloody gashes.");
		}
		if (display) outputText("\n\n");

        if (endOfTurn) {
            checkAchievementDamage(damage);
            combat.WrathGenerationPerHit2(15);
            combat.heroBaneProc(damage);
        }
	}    
}
}
