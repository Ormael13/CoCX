package classes.Items.Effects {
import classes.ItemType;
import classes.Items.Equipable;
import classes.Items.ItemEffect;
import classes.Items.ItemEffectType;
import classes.Player;
import classes.internals.Utils;

public class SimpleItemEffect extends ItemEffectType{
	private var descPattern:String;
	private var onEquipFn:Function;
	private var onUnequipFn:Function;
	
	public function SimpleItemEffect(name:String, descPattern:String, priority:int, onEquipFn:Function, onUnequipFn:Function) {
		super(name);
		this.priority = priority;
		this.descPattern = descPattern;
		this.onEquipFn = onEquipFn;
		this.onUnequipFn = onUnequipFn;
	}
	
	override public function description(prop:ItemEffect, item:ItemType):String {
		if (!descPattern) return "";
		return Utils.substitute(descPattern, prop, {item:item});
	}
	
	override public function onEquip(player:Player, item:Equipable, effect:ItemEffect):void {
		if (onEquipFn != null) onEquipFn(player, item, effect);
	}
	
	override public function onUnequip(player:Player, item:Equipable, effect:ItemEffect):void {
		if (onUnequipFn != null) onUnequipFn(player, item, effect);
	}
}
}
