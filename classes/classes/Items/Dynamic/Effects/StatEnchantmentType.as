package classes.Items.Dynamic.Effects {
import classes.ItemType;
import classes.Items.Enchantment;
import classes.Items.Equipable;
import classes.Player;
import classes.Stats.StatUtils;

/**
 * Buff stat by (power x 0.5%)
 */
public class StatEnchantmentType extends SimpleEnchantmentType {
	public var statName:String;
	public var statPerPower:Number;
	
	public function StatEnchantmentType(
			id:int,
			name:String,
			curse:Boolean,
			statName:String,
			prefix:String,
			suffix:String,
			shortSuffix:String,
			rarity:int,
			minLevel:int,
			minPower:int,
			maxPower:int,
			statPerPower:Number,
			valueAddBase:int,
			valueAddPerPower:int,
			valueMulBase:Number = 1.0,
			valueMulPerPower:Number = 0.0
	) {
		this.statName          = statName;
		this.statPerPower      = statPerPower;
		var displayName:String = StatUtils.nameOfStat(statName);
		var descPattern:String;
		if (StatUtils.isPercentageStat(statName)) {
			descPattern = displayName + " {power*" + (statPerPower * 100) + ";+d}%";
		} else {
			descPattern = displayName + " {power*" + statPerPower + ";+d}%";
		}
		super(id, name, curse, prefix, suffix, shortSuffix, descPattern, true,
				rarity, minLevel,
				minPower, maxPower, valueAddBase, valueAddPerPower, valueMulBase, valueMulPerPower);
	}
	
	override public function onAdd(enchantment:Enchantment, item:Equipable):void {
		super.onAdd(enchantment, item);
		item.withBuff(statName, statPerPower*enchantment.power);
	}
}
}
