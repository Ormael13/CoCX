package classes {
import classes.IMutationPerkType;

import flash.utils.Dictionary;

public class IMutationManager {
    private var mutations:Dictionary;
    private var actor:Creature;
    private var arrayCache:Array;

    /**
     * @param owner {Creature} Optional. Creature to associate with this perk manager for buff add/remove.
     */
    public function IMutationManager(owner:Creature = undefined) {
        if (owner) {
            this.attach(owner);
        }
        this.clear();
    }

    /**
     * Associate an actor (Creature) to this perk manager. Overwrites any existing association.
     * @param actor {Creature}
     */
    public function attach(actor:Creature):void
    {
        this.actor = actor;
    }

    /**
     * Create a mutation instance and add it.
     * @param mtype {IMutationsPerkType} Mutation type descriptor to create an instance of.
     * @param value1 {Number} Optional. Defaults to 0
     * @param value2 {Number} Optional. Defaults to 0
     * @param value3 {Number} Optional. Defaults to 0
     * @param value4 {Number} Optional. Defaults to 0
     * @return {Boolean} True if mutation is added. False if mutation already exists or fails to add.
     */
    public function createMutation(mtype:IMutationPerkType, value1:Number = 0, value2:Number = 0, value3:Number = 0, value4:Number = 0):Boolean
    {
        // Checking if the mutation exists first just in case a mutation does something silly on creation.
        if (this.has(mtype)) {
            return false;
        }
        var newMutation:IMutationPerkClass = new IMutationPerkClass(mtype, value1, value2, value3, value4);
        return this.add(newMutation);
    }

    /**
     * Add a mutation instance.
     * @param perk {PerkClass} Mutation instance to add
     * @return {Boolean} True if mutation is added. False if mutation already exists or fails to add.
     */
    public function add(mutation:IMutationPerkClass):Boolean {
        trace("Attempting to add Mutation " + mutation.mtype.id + " to " + this.actor.short);
        if (this.has(mutation.mtype)) {
            trace("Mutation " + mutation.mtype.id + " already exists. Aborted.");
            return false;
        }
        this.mutations[mutation.mtype.id] = mutation;
        if (mutation.mtype.buffs != null) {
            trace("Mutations " + mutation.mtype.id + " has buffs.");
            this.actor.statStore.addBuffObject(
                    mutation.mtype.buffs,
                    "mutation_"+mutation.mtype.id,
                    {text:mutation.mutationName, save:false}
            );
        }
        this.arrayCache = null; // Invalidate array cache.
        trace("Mutations " + mutation.mtype.id + " added.");
        return true;
    }

    /**
     * Remove a mutation.
     * @param mtype {IMutationPerkType} Mutation type descriptor to remove
     * @return {Boolean} True if mutation removed, false if mutation did not exist.
     */
    public function remove(mtype:IMutationPerkType): Boolean {
        if (this.has(mtype)) {
            delete this.mutations[mtype.id];
            if (mtype.buffs) {
                this.actor.statStore.removeBuffs("mutation_"+mtype.id);
            }
            this.arrayCache = null;
            return true;
        }
        return false;
    }

    /**
     * Check if this mutation manager has a mutation.
     * @param mtype
     * @return
     */
    public function has(mtype:IMutationPerkType): Boolean {
        return this.mutations[mtype.id] !== undefined;
    }

    /**
     * Clear all mutations without individually removing them.
     * Use with caution as buffs are not cleaned up.
     */
    public function clear(): void {
        this.mutations = new Dictionary();
        this.arrayCache = null;
    }

    /**
     * Number of active mutations
     * @return {Number}
     */
    public function count(): Number {
        return this.mutations.length;
    }

    /**
     * Get a mutation instance.
     * @param mtype {IMutationPerkType}
     * @return {IMutationPerkClass} IMutationPerkClass if IMutationPerkType exists in this manager. Otherwise undefined.
     */
    public function get(mtype:IMutationPerkType): IMutationPerkClass {
        return this.mutations[mtype.id];
    }

    /**
     * Returns a shallow-copied array of all mutations on this IMutationManager.
     * @return {Array<PerkClass>}
     */
    public function asArray(): Array
    {
        if (this.arrayCache == null) {
            this.arrayCache = [];
            for each(var perk:PerkClass in this.mutations) {
                this.arrayCache.push(perk);
            }
            this.arrayCache.sortOn("mutationName"); // Pre-sort for compatibility.
        }
        return this.arrayCache;
    }

    /**
     * Get a value for a mutation.
     * @param mtype {IMutationPerkType} Target mutation.
     * @param valueIdx {Number} Index of value to get, 1 through 4.
     * @return {Number} 0 if mutation does not exist.
     */
    public function getMutationValue(mtype:IMutationPerkType, valueIdx:Number = 1): Number
    {
        var mutation:IMutationPerkClass = this.get(mtype);
        if (mutation) {
            switch (valueIdx) {
                case 1:
                    return mutation.value1;
                case 2:
                    return mutation.value2
                case 3:
                    return mutation.value3;
                case 4:
                    return mutation.value4;
                default:
                    CoC_Settings.error("Invalid mutation value index. Attempted to get mutation " + mtype.id + " value " + valueIdx +" ).");
            }
        }
        return 0;
    }

    /**
     * Modify a value for a mutation.
     * @param mtype {IMutationPerkType} Target mutation.
     * @param valueIdx {Number} Index of value to modify, 1 through 4.
     * @param bonus {Number} Amount to add to mutation value.
     */
    public function addMutationValue(mtype:IMutationPerkType, valueIdx:Number = 1, bonus:Number = 0): void
    {
        this.setMutationValue(mtype, valueIdx, this.getMutationValue(mtype, valueIdx) + bonus);
    }

    /**
     * Set a value for a mutation.
     * @param mtype {IMutationPerkType} Target mutation.
     * @param valueIdx {Number} Index of value to set, 1 through 4.
     * @param newNum {Number} Value to set.
     */
    public function setMutationValue(mtype:IMutationPerkType, valueIdx:Number = 1, newNum:Number = 0): void
    {
        // Do not invalidate the array cache for value modifications. Array cache is a shallow copy.
        var mutation:IMutationPerkClass = this.get(mtype);
        if (mutation) {
            switch (valueIdx) {
                case 1:
                    mutation.value1 = newNum;
                    return;
                case 2:
                    mutation.value2 = newNum;
                    return;
                case 3:
                    mutation.value3 = newNum;
                    return;
                case 4:
                    mutation.value4 = newNum;
                    return;
                default:
                    CoC_Settings.error("Invalid mutation value index. Attempted to set mutation " + mtype.id + " value " + valueIdx + " to " + newNum+ ").");
            }
        }
    }
}
}
