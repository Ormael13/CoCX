package classes.Items.Dynamic.Effects {
import classes.Items.Enchantment;
import classes.Race;

public class SimpleRaceEnchantmentType extends SimpleEnchantmentType {
	private var allowedRaces:*;
	
	protected override function doDecode(identified:Boolean, paramsOnly:Array):Enchantment {
		var power:Number = paramsOnly[0];
		var race:Race = Race.byId(paramsOnly[1]);
		var valueAdd:Number = valueAddBase + valueAddPerPower * power;
		var valueMul:Number = valueMulBase + valueMulPerPower * power;
		
		if (!(allowedRaces is Array)) {
			valueAdd *= valueOr(allowedRaces[race.id].value, 1);
			if (valueMul != 1) valueMul *= valueOr(allowedRaces[race.id].value, 1);
		}
		
		return new SimpleRaceEnchantment(
				identified,
				this,
				prefix,
				suffix,
				shortSuffix,
				power,
				race,
				paramsOnly,
				valueAdd,
				valueMul
		)
	}
	
	[Deprecated(message="Use spawn2")]
	override public function spawn(identified:Boolean, power:int):Enchantment {
		throw new Error("Call spawn2")
	}
	public function spawn2(identified:Boolean, power:int, race:Race):SimpleRaceEnchantment {
		return doDecode(identified, [power, race.id]) as SimpleRaceEnchantment;
	}
	
	override public function generateRandom(options:Object = null):Enchantment {
		var power:int = randIntIn(minPower, maxPower);
		var race:Race;
		if (allowedRaces is Array) {
			race = randomChoice(allowedRaces);
		} else {
			race = weightedRandomBy(allowedRaces, "chance").race;
		}
		return doDecode(valueOr(options.identified, false), [power, race.id]);
	}
	
	public function SimpleRaceEnchantmentType(
			id:int,
			name:String,
			curse:Boolean,
			prefix:String,
			suffix:String,
			shortSuffix:String,
			descPattern:String,
			hasDescription:Boolean,
			rarity:int,
			allowedRaces:*,
			minLevel:int,
			minPower:int,
			maxPower:int,
			valueAddBase:int,
			valueAddPerPower:int,
			valueMulBase:Number,
			valueMulPerPower:Number,
			onAddFn:Function = null) {
		super(id, name,  curse, prefix, suffix, shortSuffix, descPattern, hasDescription, rarity, minLevel, minPower, maxPower, valueAddBase, valueAddPerPower, valueMulBase, valueMulPerPower, onAddFn);
		this.allowedRaces     = allowedRaces;
	}
}
}
