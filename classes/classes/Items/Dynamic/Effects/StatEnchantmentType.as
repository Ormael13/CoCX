package classes.Items.Dynamic.Effects {
import classes.ItemType;
import classes.Items.DynamicItems;
import classes.Items.Enchantment;
import classes.Player;
import classes.Stats.StatUtils;

/**
 * Buff stat by (power x 0.5%)
 */
public class StatEnchantmentType extends SimpleEnchtantmentType {
	public var statName:String;
	
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
			valueAddBase:int,
			valueAddPerPower:int,
			valueMulBase:Number,
			valueMulPerPower:Number
	) {
		this.statName          = statName;
		var displayName:String = StatUtils.nameOfStat(statName);
		super(id, name, false, prefix, suffix, shortSuffix, displayName + " {power*0.5;+1f}%",
				DynamicItems.RARITY_MAGICAL, minLevel,
				minPower, maxPower, valueAddBase, valueAddPerPower, valueMulBase, valueMulPerPower);
	}
	
	override public function onEquip(player:Player, enchantment:Enchantment, item:ItemType):void {
		player.buff(item.tagForBuffs)
				.addStat(statName, enchantment.power * 0.005)
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
