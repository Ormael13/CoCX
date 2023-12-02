package classes.Scenes.Combat {

import classes.StatusEffectType;
import classes.StatusEffects;

public class AbstractBloodSoulSkill extends AbstractSoulSkill {
    protected var sfInfusion:Boolean;
    
    public function AbstractBloodSoulSkill(
        name:String,
        desc:String,
        targetType:int,
        timingType:int,
        tags:/*int*/Array,
        statusEffect:StatusEffectType,
        canUseBlood:Boolean = true,
        sfInfusion:Boolean= false
    ) {
        super(name, desc, targetType, timingType, tags, statusEffect, canUseBlood);
        this.sfInfusion = sfInfusion;
    }

    override public function get category():int {
        return CAT_BLOOD_SOULSKILL;
    }

    override protected function usabilityCheck():String {
        //Soulforce check will be handled in this class instead of AbstractSoulForce
        var uc:String =  super.usabilityCheck();
        if (uc && uc != "Your current soulforce is too low.") return uc;

        if (monster.hasStatusEffect(StatusEffects.Dig)) {
            return "You can only use buff soulskills while underground.";
        }

        if (sfInfusion && (player.soulforce < sfCost()) && (!player.hasStatusEffect(StatusEffects.BloodCultivator) || !canUseBlood)) {
            return "Your current soulforce is too low."
        }

        if (combat.isEnemyInvisible) {
            return "You cannot use offensive soulskills against an opponent you cannot see or target.";
        }

        if (player.isGargoyle()) {
            return "You cannot use blood soulskills if you don't have blood at all."
        }
        
        return "";
    }

    override public function sfCost():int {
        return spellCostBlood(baseSFCost);
    }

    override public function costDescription():Array {
        var costs:/*String*/Array = super.costDescription().concat();
        //Remove addition from Abstract soulSkill Implementation
        if (sfCost() > 0) {
            costs.pop();
            if (sfInfusion) costs.push("Soulforce Cost: "+super.sfCost());
            costs.push("Blood Cost: "+sfCost());
        }
        return costs;
    }

    override public function useResources():void {
        //Set last attack type for Blood Soulskill
        CombatAbility.prototype.useResources.call(this);
        HPChange(sfCost(), false);

        if (sfInfusion) {
            player.soulforce -= super.sfCost();
        }
    }

    //Used to specifiy the base name of the blood soulskill, which will be a suffix added for the SF version
    protected function baseName():String {
        return "";
    }

    override public function get buttonName():String {
        return baseName() + (sfInfusion? " (SF)" : "");
    }

    protected function bloodSoulSkillCoolDown(baseCooldown:int):int {
        var cooldown:int = baseCooldown;
        if (sfInfusion) cooldown += 1;
        return cooldown;
    }
}
}