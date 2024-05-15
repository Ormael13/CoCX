package classes.Items {
import classes.ItemType;
import classes.Player;

public class ItemEffect {
	public var type:ItemEffectType;
	/**
	 * Effect strength
	 */
	public var power: Number;
	public var value1: *;
	public var value2: *;
	public var value3: *;
	public var value4: *;
	
	public function ItemEffect(
			type:ItemEffectType,
			power:Number,
			value1: * = undefined,
			value2: * = undefined,
			value3: * = undefined,
			value4: * = undefined
	) {
		this.type = type;
		this.power = power;
		this.value1 = value1;
		this.value2 = value2;
		this.value3 = value3;
		this.value4 = value4;
	}
	
	/**
	 * Description priority, smaller = appears first in the list.
	 */
	public function get priority():int {
		return type.priority;
	}
	
	/**
	 * Tooltip description. Empty string to hide.
	 * @param item Item (can be null)
	 * @return
	 */
	public function description(item:ItemType):String {
		return type.description(this, item);
	}
	public function onEquip(player:Player, item:Equipable):void {
		type.onEquip(player, item, this)
	}
	public function onUnequip(player:Player, item:Equipable):void {
		type.onUnequip(player, item, this)
	}
}
}
