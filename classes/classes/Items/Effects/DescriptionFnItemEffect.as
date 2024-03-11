package classes.Items.Effects {
import classes.ItemType;
import classes.Items.ItemEffect;
import classes.Items.ItemEffectType;

public class DescriptionFnItemEffect extends ItemEffectType {
	private var descFn:Function;
	
	/**
	 *
	 * @param name
	 * @param descFn `function(prop:ItemEffect, item:ItemType):String` returning a tooltip
	 * @param priority
	 */
	public function DescriptionFnItemEffect(name:String, descFn:Function, priority:int) {
		super(name, priority);
		this.descFn = descFn
	}
	
	override public function description(prop:ItemEffect, item:ItemType):String {
		if (descFn.length == 2) return descFn(prop, item);
		if (descFn.length == 1) return descFn(prop);
		return descFn();
	}
}
}
