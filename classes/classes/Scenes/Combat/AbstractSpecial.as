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
}
}
