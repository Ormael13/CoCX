package classes {
import flash.utils.Dictionary;

public class PerkManager {
    private var perks:Dictionary;
    private var actor:Creature;
    private var arrayCache:Array;

    /**
     *
     * @param owner {Creature} Optional. Creature to associate with this perk manager for buff add/remove.
     */
    public function PerkManager(owner:Creature = undefined) {
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
     * Create a perk instance and add it.
     * @param ptype {PerkType} Perk type descriptor to create an instance of.
     * @param value1 {Number} Optional. Defaults to 0
     * @param value2 {Number} Optional. Defaults to 0
     * @param value3 {Number} Optional. Defaults to 0
     * @param value4 {Number} Optional. Defaults to 0
     * @return {Boolean} True if perk is added. False if perk already exists or fails to add.
     */
    public function createPerk(ptype:PerkType, value1:Number = 0, value2:Number = 0, value3:Number = 0, value4:Number = 0):Boolean
    {
        // Checking if the perk exists first just in case a perk does something silly on creation.
        if (this.has(ptype)) {
            return false;
        }
        var newPerk:PerkClass = new PerkClass(ptype, value1, value2, value3, value4);
        return this.add(newPerk);
    }

    /**
     * Add a perk instance.
     * @param perk {PerkClass} Perk instance to add
     * @return {Boolean} True if perk is added. False if perk already exists or fails to add.
     */
    public function add(perk:PerkClass):Boolean {
//        trace("Attempting to add perk " + perk.ptype.id + " to " + this.actor.short);
        if (this.has(perk.ptype)) {
            trace("Perk " + perk.ptype.id + " already exists. Aborted.");
            return false;
        }
        this.perks[perk.ptype.id] = perk;
        if (perk.ptype.buffs != null) {
            // trace("Perk " + perk.ptype.id + " has buffs.");
            this.actor.statStore.addBuffObject(
                    perk.ptype.buffs,
                    "perk_"+perk.ptype.id,
                    {text:perk.perkName, save:false}
            );
        }
        this.arrayCache = null; // Invalidate array cache.
//        trace("Perk " + perk.ptype.id + " added.");
        return true;
    }

    /**
     * Remove a perk.
     * @param ptype {PerkType} Perk type descriptor to remove
     * @return {Boolean} True if perk removed, false if perk did not exist.
     */
    public function remove(ptype:PerkType): Boolean {
        if (this.has(ptype)) {
            delete this.perks[ptype.id];
            if (ptype.buffs) {
                this.actor.statStore.removeBuffs("perk_"+ptype.id);
            }
            this.arrayCache = null;
            return true;
        }
        return false;
    }

    /**
     * Check if this perk manager has a perk.
     * @param ptype
     * @return
     */
    public function has(ptype:PerkType): Boolean {
        return this.perks[ptype.id] !== undefined;
    }

    /**
     * Clear all perks without individually removing them.
     * Use with caution as buffs are not cleaned up.
     */
    public function clear(): void {
        this.perks = new Dictionary();
        this.arrayCache = null;
    }

    /**
     * Number of active perks
     * @return {Number}
     */
    public function count(): Number {
        return this.perks.length;
    }

    /**
     * Get a perk instance.
     * @param ptype {PerkType}
     * @return {PerkClass} PerkClass if PerkType exists in this manager. Otherwise undefined.
     */
    public function get(ptype:PerkType): PerkClass {
        return this.perks[ptype.id];
    }

    /**
     * Returns a shallow-copied array of all perks on this PerkManager.
     * @return {Array<PerkClass>}
     */
    public function asArray(): Array
    {
        if (this.arrayCache == null) {
            this.arrayCache = [];
            for each(var perk:PerkClass in this.perks) {
                this.arrayCache.push(perk);
            }
            this.arrayCache.sortOn("perkName"); // Pre-sort for compatibility.
        }
        return this.arrayCache;
    }

    /**
     * Get a value for a perk.
     * @param ptype {PerkType} Target perk.
     * @param valueIdx {Number} Index of value to get, 1 through 4.
     * @return {Number} 0 if perk does not exist.
     */
    public function getPerkValue(ptype:PerkType, valueIdx:Number = 1): Number
    {
        var perk:PerkClass = this.get(ptype);
        if (perk) {
            switch (valueIdx) {
                case 1:
                    return perk.value1;
                case 2:
                    return perk.value2
                case 3:
                    return perk.value3;
                case 4:
                    return perk.value4;
                default:
                    CoC_Settings.error("Invalid perk value index. Attempted to get perk " + ptype.id + " value " + valueIdx +" ).");
            }
        }
        return 0;
    }

    /**
     * Modify a value for a perk.
     * @param ptype {PerkType} Target perk.
     * @param valueIdx {Number} Index of value to modify, 1 through 4.
     * @param bonus {Number} Amount to add to perk value.
     */
    public function addPerkValue(ptype:PerkType, valueIdx:Number = 1, bonus:Number = 0): void
    {
        this.setPerkValue(ptype, valueIdx, this.getPerkValue(ptype, valueIdx) + bonus);
    }

    /**
     * Set a value for a perk.
     * @param ptype {PerkType} Target perk.
     * @param valueIdx {Number} Index of value to set, 1 through 4.
     * @param newNum {Number} Value to set.
     */
    public function setPerkValue(ptype:PerkType, valueIdx:Number = 1, newNum:Number = 0): void
    {
        // Do not invalidate the array cache for value modifications. Array cache is a shallow copy.
        var perk:PerkClass = this.get(ptype);
        if (perk) {
            switch (valueIdx) {
                case 1:
                    perk.value1 = newNum;
                    return;
                case 2:
                    perk.value2 = newNum;
                    return;
                case 3:
                    perk.value3 = newNum;
                    return;
                case 4:
                    perk.value4 = newNum;
                    return;
                default:
                    CoC_Settings.error("Invalid perk value index. Attempted to set perk " + ptype.id + " value " + valueIdx + " to " + newNum+ ").");
            }
        }
    }
}
}
