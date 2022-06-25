package classes.Items.Dynamic.Effects {
import classes.ItemType;
import classes.Items.Enchantment;
import classes.Player;
import classes.Stats.StatUtils;

/**
 * Buff stat by (power x 0.5%)
 */
public class StatEnchantmentType extends SimpleEnchtantmentType {
	public var statName:String;
	public var statPerPower:Number;
	
	public function StatEnchantmentType(
			id:int,
			name:String,
			statName:String,
			prefix:String,
			suffix:String,
			shortSuffix:String,
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
		super(id, name, false, prefix, suffix, shortSuffix, descPattern,
				RARITY_MAGICAL, minLevel,
				minPower, maxPower, valueAddBase, valueAddPerPower, valueMulBase, valueMulPerPower);
	}
	
	override public function onEquip(player:Player, enchantment:Enchantment, item:ItemType):void {
		player.buff(item.tagForBuffs)
				.addStat(statName, enchantment.power * statPerPower)
				.withText("Equipment")
				.withOptions({save: false})
				.permanent();
	}
	
	override public function onUnequip(player:Player, enchantment:Enchantment, item:ItemType):void {
		player.buff(item.tagForBuffs)
				.removeFromStat(statName);
	}
}
}
