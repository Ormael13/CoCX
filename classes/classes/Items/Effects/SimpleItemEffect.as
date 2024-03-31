package classes.Items.Effects {
import classes.ItemType;
import classes.Items.ItemEffect;
import classes.Items.ItemEffectType;
import classes.internals.Utils;

public class SimpleItemEffect extends ItemEffectType{
	private var descPattern:String;
	
	public function SimpleItemEffect(name:String, descPattern:String, priority:int) {
		super(name, priority);
		this.descPattern = descPattern;
	}
	
	override public function description(prop:ItemEffect, item:ItemType):String {
		if (!descPattern) return "";
		return Utils.substitute(descPattern, prop, {item:item});
	}
}
}
