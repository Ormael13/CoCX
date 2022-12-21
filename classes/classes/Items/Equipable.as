/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items {
import classes.CoC_Settings;
import classes.ItemType;
import classes.PerkClass;
import classes.PerkType;
import classes.Stats.StatUtils;
import classes.internals.Utils;

/**
 * Superclass for items that could be equipped by player (armor, weapon, jewelry, ...).
 *
 * ## Call order
 *
 * Call order when player equips itemA into slotX while having itemB equipped:
 * (This is implemented in Player.internalEquipItem)
 *
 * 1. Test
 * 1.1. Test `itemA.canEquip`. If false, stop.
 * 1.2. Test `itemB.canUnequip`. If false, stop.
 * 2. Unequip itemB
 * 2.1. Call `itemB.beforeUnequip` (calls `itemB.unequipText`) and save itemReturn
 * 2.2. Put 'nothing' into slotX
 * 2.3. Call `itemB.afterUnequip` (effects go here)
 * 3. Equip itemA
 * 3.1. Call `itemA.beforeEquip` (calls `itemA.equipText`) and save itemActual
 * 3.2. Put itemActual into slotX
 * 3.3. Call `itemActual.afterEquip` (effects go here)
 * 4. Remove itemB from inventory.
 * 5. Add itemReturn to inventory.
 * (4 and 5 are done by calling function)
 *
 * Variations:
 * - If force=true, skip test
 * - All functions mentioned above have doOutput parameter
 * - When loading a save only afterEquip(doOutput=false) is called. Can be checked by game.isLoadingSave
 * - Skip certain sections for items flagged as 'nothing'
 *
 * ## What to override in subclasses
 *
 * - To add effect when equipped: `afterEquip` and `afterUnequip`. Note that it is called when loading a save, too. Guard the section with `if (!game.isLoadingSave) { ... }`.
 * - To add requirements to wear/remove: `canEquip` and `canUnequip`
 * - To display different text: `equipText` and `unequipText`.
 * - To transform item into another when equipping: `beforeEquip`.
 * - To transform item into another when unequipping: `beforeUnequip`.
 */
public class Equipable extends Useable {
	
	protected var _name:String;
	protected var _buffs:Object;
	protected var _buffsStack:Boolean = false;
	/**
	 * Array of [perkType, value1, value2, value3, value4, stack]
	 */
	protected var _playerPerks:Array;
	
	public function get name():String {
		return _name;
	}
	
	public function Equipable(id:String, shortName:String, name:String, longName:String, value:Number, description:String) {
		super(id, shortName, longName, value, description);
		this._name = name || this.shortName;
	}
	
	override public function get description():String {
		var s:String = _description;
		var s2:String = effectDescription();
		if (s && s2) return s + "\n\n" + s2;
		return s || s2;
	}
	
	/**
	 * Array of pairs [order, name] to construct item description.
	 *
	 *   0: Curse status
	 *  10: type
	 *  15: subtype
	 *  20: main property (attack, defense)
	 *  30: secondary property (mdef)
	 *  40: rarity
	 *  45: quality
	 *  50: common specials
	 *  60: extra specials
	 *  70: buffs
	 *  80: enchantments
	 *  90: extra desc
	 * 100: value
	 */
	public function effectDescriptionParts():Array {
		var list:Array = [];
		list.push([100, "Base value: "+value]);
		if (_buffs) {
			var desc:String = ""
			for (var key:String in _buffs) {
				if (desc) desc += ", ";
				desc += StatUtils.explainBuff(key, _buffs[key]);
			}
			desc = "Effect: "+desc;
			list.push([70, desc]);
		}
		if (_playerPerks) {
			for each (var perk:Array in _playerPerks) {
				var pc:PerkClass = new PerkClass(perk[0], perk[1], perk[2], perk[3], perk[4]);
				list.push([50, pc.perkDesc]);
			}
		}
		return list;
	}
	public function effectDescription():String {
		var list:Array = effectDescriptionParts().sortOn('0',Array.NUMERIC);
		return Utils.mapOneProp(list, '1').join("\n");
	}
	
	override public function canUse():Boolean {
		return canEquip(true);
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
	 * @param doOutput Player tries equipping the item, if fails, print why. And do any side effects related to failed equip attempt.
	 * @return
	 */
	public function canEquip(doOutput:Boolean):Boolean {
		return true;
	}
	
	/**
	 * Test if player can unequip the item
	 * @param doOutput Player tries unequiping the item, if fails, print why. And do any side effects related to failed unequip attempt.
	 * @return true if player can unequip the item
	 */
	public function canUnequip(doOutput:Boolean):Boolean {
		if (isNothing) return false;
		if (cursed) {
			if (doOutput) outputText("<b>You cannot remove a cursed item!</b>");
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
	 * @param doOutput
	 * @return Actual item to be put into slot, or null
	 */
	public function beforeEquip(doOutput:Boolean):Equipable {
		if (doOutput) equipText();
		return this;
	}
	
	public function equipText():void {
		outputText("You equip "+longName+". ");
	}
	
	/**
	 * Called after player has equipped the item.
	 * Also called during save load.
	 * Apply equipment effects here.
	 * @param doOutput
	 */
	public function afterEquip(doOutput:Boolean):void {
		if (_buffs) {
			// don't write into savefile
			if (_buffsStack) {
				game.player.buff(tagForBuffs).addStats(_buffs).withText(name).withOptions({save:false});
			} else {
				game.player.buff(tagForBuffs).setStats(_buffs).withText(name).withOptions({save:false});
			}
		}
		
		if (!game.isLoadingSave) {
			if (_playerPerks) {
				for each (var perk:Array in _playerPerks) {
					game.player.createPerk(perk[0], perk[1], perk[2], perk[3], perk[4]);
				}
			}
		}
	}
	
	/**
	 * Called when player removes the item.
	 * canUnequip is already called (or ignored)
	 * Do not undo the effects here
	 * @param doOutput
	 * @return Actual item to place into inventory (could be nothing)
	 */
	public function beforeUnequip(doOutput:Boolean):ItemType {
		if (doOutput) unequipText();
		return this;
	}
	
	public function unequipText():void {
		outputText("You unequip "+longName+". ");
	}
	
	/**
	 * Called after player removes the item.
	 * Undo effects here
	 * @param doOutput
	 */
	public function afterUnequip(doOutput:Boolean):void {
		if (_buffs) {
			if (game.player.countSameEquippedItems(this) == 0 || !_buffsStack) {
				game.player.buff(tagForBuffs).remove();
			} else  {
				game.player.buff(tagForBuffs).subtractStats(_buffs);
			}
		}
		if (_playerPerks) {
			for each (var perk:Array in _playerPerks) {
				game.player.removePerk(perk[0]);
			}
		}
	}
	
	/**
	 * Give buffs when equipping this item.
	 * Only use when constructing the item type!
	 * @param buffs
	 * @param stack Stack buffs from identical items
	 * @return this
	 */
	public function withBuffs(buffs:Object, stack:Boolean=true):Equipable {
		if (buffs is Array) buffs = Utils.createMapFromPairs(buffs as Array);
		this._buffs = buffs;
		StatUtils.validateBuffObject(_buffs,"item "+id);
		this._buffsStack = stack;
		return this;
	}
	
	public function withBuff(statName:String, power:Number, stack:Boolean=true):Equipable {
		this._buffs = StatUtils.addBuffToObject(this._buffs, statName, power);
		StatUtils.validateBuff(statName,"item "+id);
		this._buffsStack = stack;
		return this;
	}
	
	public function hasBuff(statname:String):Boolean {
		return _buffs && statname in _buffs;
	}
	
	/**
	 * Give perk when equipping this item.
	 * Only use when constructing the item type!
	 * If multiple items granting a perk are equipped, their values would stack.
	 * @return this
	 */
	public function withPerk(perk:PerkType, value1:Number=0, value2:Number=0, value3:Number=0, value4:Number=0):Equipable {
		this._playerPerks ||= [];
		this._playerPerks.push([perk,value1,value2,value3,value4]);
		return this;
	}
	
	public function givesPerk(perk:PerkType):Boolean {
		if (!this._playerPerks) return false;
		for each (var entry:Array in _playerPerks) if (entry[0] == perk) return true;
		return false;
	}
}
}
