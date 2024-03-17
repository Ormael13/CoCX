package classes.Items {
import classes.ItemType;

import flash.utils.Dictionary;

public class ItemEffectType {
	
	public function ItemEffectType(name:String, priority:int) {
		this.name = name;
		this.priority = priority;
	}
	
	/** For debugging */
	public var name:String;
	/**
	 * Description priority in the tooltip
	 */
	public var priority:int;
	/**
	 * A bit mask of IEF_XXXX
	 */
	public var flags:int = 0;
	/**
	 * Tooltip description for itemeffect instance. Return empty string to hide.
	 * @param prop Actual property with values
	 * @param item Reference item (can be null)
	 * @return
	 */
	public function description(prop:ItemEffect, item:ItemType):String {
		return ""
	}
	/**
	 * (ItemEffectType construction only!) Set this effect flags. A |-masked IEF_XXX constants
	 * @example
	 * new ItemEffectType("name", 80).withFlags(IEF_ATTACK | IEF_REQUIREMENT);
	 */
	public function withFlags(flags:int):ItemEffectType {
		this.flags = flags;
		return this;
	}
}
}
