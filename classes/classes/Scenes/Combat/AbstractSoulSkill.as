package classes.Scenes.Combat {
import classes.GlobalFlags.kFLAGS;
import classes.StatusEffectType;
import classes.StatusEffects;
import classes.Monster;
import classes.PerkLib;
import classes.IMutations.IMutationsLib;

public class AbstractSoulSkill extends CombatAbility {
    protected var statusEffect:StatusEffectType;
    public var baseSFCost:Number = 0;

    public function AbstractSoulSkill (
            name:String,
            desc:String,
            targetType:int,
            timingType:int,
            tags:/*int*/Array,
            statusEffect:StatusEffectType
    ) {
        super(name, desc, targetType, timingType, tags);
        this.statusEffect = statusEffect;
    }

    override public function get category():int {
        return CAT_SOULSKILL;
    }

    override public function costDescription():Array {
        var costs:/*String*/Array = super.costDescription().concat();
        if (sfCost() > 0) {
            costs.push("Soulforce Cost: "+sfCost());
        }
        return costs;
    }

    override protected function usabilityCheck():String {
        var uc:String =  super.usabilityCheck();
        if (uc) return uc;

        if ((player.soulforce < sfCost()) && !player.hasStatusEffect(StatusEffects.BloodCultivator)) {
            return "Your current soulforce is too low."
        }

        if (player.hasStatusEffect(StatusEffects.BloodCultivator) && ((player.HP - player.minHP()) - 1) < (sfCost())) {
            return "Your hp is too low to use this soulskill."
        }

        return "";
    }  

    public function sfCost():int {
        var soulforcecost:Number = baseSFCost * soulskillCost() * soulskillcostmulti();
        return Math.round(soulforcecost);
    }

    override public function get isKnown():Boolean {
        return player.hasStatusEffect(statusEffect);
    }

    override public function useResources():void {
        if (player.hasStatusEffect(StatusEffects.BloodCultivator)) {
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

	protected function monsterDodgeSkill(skillName:String, display:Boolean):Boolean {
		if (((player.playerIsBlinded() && rand(2) == 0) || ((monster.getEvasionRoll(false, player.spe) && !monster.hasPerk(PerkLib.NoDodges)))) && !monster.monsterIsStunned()) {
			if ((monster.spe - player.spe < 8) && display) outputText("[Themonster] narrowly avoids your " + skillName + "!");
			else if ((monster.spe-player.spe < 20) && display) outputText("[Themonster] dodges your " + skillName + " with superior quickness!");
			else if (display) outputText("[Themonster] deftly avoids your slow " + skillName + ".");
			enemyAI();
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

	protected function endTurnByBloodSkillUse(damage:Number, display:Boolean = true):void {
		if (rand(20) < 4) {
			if (monster.hasStatusEffect(StatusEffects.Hemorrhage)) monster.removeStatusEffect(StatusEffects.Hemorrhage);
			monster.createStatusEffect(StatusEffects.Hemorrhage, 2, 0.05, 0, 0);
			if (display) outputText(" The attack leaves many bloody gashes.");
		}
		if (display) outputText("\n\n");
		checkAchievementDamage(damage);
		combat.WrathGenerationPerHit2(15);
		combat.heroBaneProc(damage);
	}

    protected function advanceDuration(statusEffect:StatusEffectType, display:Boolean, endMessage:String = ""):void {
        if (player.hasStatusEffect(statusEffect)) {
            if (player.statusEffectv1(statusEffect) <= 0) {
                player.removeStatusEffect(statusEffect);
                if (endMessage && display)
                    outputText(endMessage);
            } else player.addStatusValue(statusEffect, 1, -1);
        }
    }    
}
}
