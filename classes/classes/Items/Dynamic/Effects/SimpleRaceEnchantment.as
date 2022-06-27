package classes.Items.Dynamic.Effects {
import classes.Items.Enchantment;
import classes.Items.EnchantmentType;
import classes.Race;

public class SimpleRaceEnchantment extends Enchantment {
	public var race:Race;
	public function SimpleRaceEnchantment(
			identified:Boolean,
			type:EnchantmentType,
			prefix:String,
			suffix:String,
			shortSuffix:String,
			power:Number,
			race:Race,
			params:Array,
			valueAdd:Number,
			valueMul:Number
	) {
		super(identified, type, prefix, suffix, shortSuffix, power, params, valueAdd, valueMul, false);
		this.race = race;
		genDescription();
	}
}
}
