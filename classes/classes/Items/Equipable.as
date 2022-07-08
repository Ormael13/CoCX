/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items {
import classes.CoC_Settings;
import classes.ItemType;

/**
 * Superclass for items that could be equipped by player (armor, weapon, jewelry, ...).
 *
 * Call order when player equips itemA into slotX while having itemB equipped:
 * (This is implemented in Player.internalEquipItem)
 * 1. Test
 * 1.1. Test itemA.canEquip. If false, stop
 * 1.2. Test itemB.canUnequip. If false, stop.
 * 2. Unequip itemB
 * 2.1. Call itemB.beforeUnequip (calls unequipText) and save itemReturn
 * 2.2. Put 'nothing' into slotX
 * 2.3. Call itemB.afterUnequip (effects go here)
 * 3. Equip itemA
 * 3.1. Call itemA.beforeEquip (calls equipText) and save itemActual
 * 3.2. Put itemActual into slotX
 * 3.3. Call itemActual.afterEquip (effects go here)
 * 4. Remove itemB from inventory.
 * 5. Add itemReturn to inventory.
 * (4 and 5 are done by calling function)
 *
 * Variations:
 * - If force=true, skip test
 * - All functions mentioned above have doOutput parameter
 * - When loading a save only afterEquip(doOutput=false) is called. Can be checked by game.isLoadingSave
 * - Skip certain sections for items flagged as 'nothing'
 */
public class Equipable extends Useable {
	
	private var _name:String;
	
	public function get name():String {
		return _name;
	}
	
	public function Equipable(id:String, shortName:String = null, name:String = null, longName:String = null, value:Number = 0, description:String = null) {
		super(id, shortName, longName, value, description);
		this._name = name || this.shortName;
	}
	
	override public function canUse():Boolean {
		return true;
	}
	
	/**
	 * Slot ids this item could be equipped into
	 */
	public function slots():/*int*/Array {
		CoC_Settings.errorAMC("Equipable("+id+")", "slots");
		return [];
	}
	
	/**
	 * Test if player can equip the item.
	 * Should NOT check empty target slot (but can check other slots).
	 * (ex. equipping large weapon can check for no shield but shouldn't check for no weapon)
	 * @param slot SLOT_XXXX
	 * @param doOutput Player tries equipping the item, if fails, print why
	 * @return
	 */
	public function canEquip(slot:int, doOutput:Boolean):Boolean {
		return true;
	}
	
	/**
	 * Test if player can unequip the item
	 * @param slot SLOT_XXXX
	 * @param doOutput Player tries unequiping the item, if fails, print why
	 * @return true if player can unequip the item
	 */
	public function canUnequip(slot: int, doOutput:Boolean):Boolean {
		if (cursed) {
			if (doOutput) outputText("You cannot remove a cursed item!");
			return false;
		}
		return true;
	}
	
	/**
	 * Called when player is equipping the item.
	 * Can transform item into another here.
	 * It is NOT called when loading a save, do not add any effects here.
	 * It is NOT called it item transforms into another.
	 * Do not apply equipment effects here.
	 * @param slot SLOT_XXXX where it is equipped into
	 * @param doOutput
	 * @return Actual item to be put into slot, or null
	 */
	public function beforeEquip(slot:int, doOutput:Boolean):Equipable {
		if (doOutput) equipText(slot);
		return this;
	}
	
	public function equipText(slot:int):void {
		outputText("You equip "+longName+". ");
	}
	
	/**
	 * Called after player has equipped the item.
	 * Also called during save load.
	 * Apply equipment effects here.
	 * @param doOutput
	 */
	public function afterEquip(slot:int, doOutput:Boolean):void {
		// do nothing
	}
	
	/**
	 * Called when player removes the item.
	 * canUnequip is already called (or ignored)
	 * Do not undo the effects here
	 * @param slot SLOT_XXXX
	 * @param doOutput
	 * @return Actual item to place into inventory (could be nothing)
	 */
	public function beforeUnequip(slot:int, doOutput:Boolean):ItemType {
		if (doOutput) unequipText(slot);
		return this;
	}
	
	public function unequipText(slot:int):void {
		outputText("You unequip "+longName+". ");
	}
	
	/**
	 * Called after player removes the item.
	 * Undo effects here
	 * @param slot SLOT_XXXX
	 * @param doOutput
	 */
	public function afterUnequip(slot: int, doOutput:Boolean):void {
		// do nothing
	}
}
}
