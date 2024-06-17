package classes.Items.Effects {
import classes.ItemType;
import classes.Items.Equipable;
import classes.Items.ItemEffect;
import classes.Items.ItemEffectType;
import classes.Player;

public class DescriptionFnItemEffect extends ItemEffectType {
	private var descFn:Function;
	private var onEquipFn:Function;
	private var onUnequipFn:Function;
	
	/**
	 *
	 * @param name
	 * @param descFn `function(prop:ItemEffect, item:ItemType):String` returning a tooltip
	 * @param priority
	 */
	public function DescriptionFnItemEffect(name:String, descFn:Function, priority:int, onEquipFn:Function, onUnequipFn:Function) {
		super(name);
		this.priority = priority;
		this.descFn = descFn;
		this.onEquipFn = onEquipFn;
		this.onUnequipFn = onUnequipFn;
	}
	
	override public function description(prop:ItemEffect, item:ItemType):String {
		if (descFn.length == 2) return descFn(prop, item);
		if (descFn.length == 1) return descFn(prop);
		return descFn();
	}
	
	override public function onEquip(player:Player, item:Equipable, effect:ItemEffect):void {
		if (onEquipFn != null) onEquipFn(player, item, effect);
	}
	
	override public function onUnequip(player:Player, item:Equipable, effect:ItemEffect):void {
		if (onUnequipFn != null) onUnequipFn(player, item, effect);
	}
}
}
