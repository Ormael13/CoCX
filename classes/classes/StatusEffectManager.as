package classes {

import flash.utils.Dictionary;

public class StatusEffectManager {
    private var statusEffects:Dictionary;
    private var actor:Creature;

    /**
     *
     * @param owner {Creature} Optional. Creature to associate with this manager for buff add/remove.
     */
    public function StatusEffectManager(owner:Creature = undefined)
    {
        if (owner) {
            this.attach(owner);
        }
        this.removeStatuses();
    }

    /**
     * Associate an actor (Creature) to this status manager. Overwrites any existing association.
     * @param actor {Creature}
     */
    public function attach(actor:Creature):void
    {
        this.actor = actor;
    }

    public function hasStatusEffect(stype:StatusEffectType):Boolean
    {
        return this.statusEffects[stype.id] != undefined;
    }

    public function statusEffectByType(stype:StatusEffectType): StatusEffectClass
    {
        return this.statusEffects[stype.id] || null;
    }

    public function createStatusEffect(stype:StatusEffectType, v1:Number, v2:Number, v3:Number, v4:Number, fireEvent:Boolean = true): StatusEffectClass
    {
        if (this.hasStatusEffect(stype)) {
            return undefined;
        }
        var sec:StatusEffectClass = stype.create(v1, v2, v3, v4);
        this.addStatusEffect(sec);
        return sec;
    }

    public function createOrFindStatusEffect(stype:StatusEffectType, v1:Number = 0, v2:Number = 0, v3:Number = 0, v4:Number = 0, fireEvent:Boolean = true):StatusEffectClass
    {
        if (this.hasStatusEffect(stype)) {
            return this.statusEffectByType(stype);
        }
        return this.createStatusEffect(stype, v1, v2, v3, v4, fireEvent);
    }

    public function addStatusEffect(sec:StatusEffectClass):void
    {
        if (this.hasStatusEffect(sec.stype)) {
            trace("addStatusEffect: stype "+ sec.stype.id + " already exists");
            return;
        }

        if (sec.host != this.actor) {
            // Automatically transfer status effects?
            sec.remove();
            sec.attach(this.actor /*,fireEvent*/);
        } else {
            this.statusEffects[sec.stype.id] = sec;
            sec.addedToHostList(this.actor,true);
        }
    }

    public function removeStatusEffect(stype:StatusEffectType):StatusEffectClass
    {
        var sec:StatusEffectClass = this.statusEffectByType(stype);
        if (sec) {
            sec.removedFromHostList(true);
            delete this.statusEffects[sec.stype.id];
            return sec;
        }
        return null;
    }

    public function removeStatusEffectInstance(sec:StatusEffectClass):void
    {
        /* Not trusting that the supplied StatusEffectClass instance exists on this
           StatusEffectManager.
         */
        this.removeStatusEffect(sec.stype);
    }

    public function changeStatusValue(stype:StatusEffectType, statusValueNum:Number = 1, newNum:Number = 0):void
    {
        if (statusValueNum < 1 || statusValueNum > 4) {
            CoC_Settings.error("ChangeStatusValue called with invalid status value number.");
            return;
        }
        var sac:StatusEffectClass = this.statusEffectByType(stype);
        //Various Errors preventing action
        if (!sac)return;
        if (statusValueNum == 1) sac.value1 = newNum;
        if (statusValueNum == 2) sac.value2 = newNum;
        if (statusValueNum == 3) sac.value3 = newNum;
        if (statusValueNum == 4) sac.value4 = newNum;
    }

    public function addStatusValue(stype:StatusEffectType, statusValueNum:Number = 1, bonus:Number = 0):void
    {
        if (statusValueNum < 1 || statusValueNum > 4) {
            CoC_Settings.error("ChangeStatusValue called with invalid status value number.");
            return;
        }
        var sac:StatusEffectClass = this.statusEffectByType(stype);
        //Various Errors preventing action
        if (!sac)return;
        if (statusValueNum == 1) sac.value1 += bonus;
        if (statusValueNum == 2) sac.value2 += bonus;
        if (statusValueNum == 3) sac.value3 += bonus;
        if (statusValueNum == 4) sac.value4 += bonus;
    }

    public function createOrAddStatusEffect(stype:StatusEffectType, statusValueNum:Number = 1, bonus:Number = 0):void
    {
        if (statusValueNum < 1 || statusValueNum > 4) {
            CoC_Settings.error("ChangeStatusValue called with invalid status value number.");
            return;
        }
        if (!this.hasStatusEffect(stype)) {
            createStatusEffect(stype, 0, 0, 0, 0);
        }
        addStatusValue(stype, statusValueNum, bonus);
    }

    public function getStatusValue(stype:StatusEffectType, statusValueNum:Number): Number
    {
        if (statusValueNum < 1 || statusValueNum > 4) {
            CoC_Settings.error("getStatusValue called with invalid status value number.");
            return 0;
        }
        var sac:StatusEffectClass = this.statusEffectByType(stype);
        if (!sac) return 0;
        if (statusValueNum == 1) return sac.value1;
        if (statusValueNum == 2) return sac.value2;
        if (statusValueNum == 3) return sac.value3;
        if (statusValueNum == 4) return sac.value4;
        return 0;
    }

    public function removeStatuses():void
    {
        this.statusEffects = new Dictionary();
    }

    public function asArray():Array
    {
        var array:Array = [];
        for each(var sec:StatusEffectClass in this.statusEffects) {
            array.push(sec);
        }
        return array;
    }
}
}
