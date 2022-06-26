package classes.Items.Dynamic.Effects {
import classes.ItemType;
import classes.Items.Enchantment;
import classes.Items.EnchantmentType;
import classes.Player;

public class SimpleEnchtantmentType extends EnchantmentType {
	public var minPower:int;
	public var maxPower:int;
	public var valueAddBase:int;
	public var valueAddPerPower:int;
	public var valueMulBase:Number;
	public var valueMulPerPower:Number;
	public var onEquipFn:Function;
	public var onUnequipFn:Function;
	
	protected override function doDecode(identified:Boolean, paramsOnly:Array):Enchantment {
		var power:Number = paramsOnly[0];
		
		return new Enchantment(
				identified,
				this,
				prefix,
				suffix,
				shortSuffix,
				power,
				paramsOnly,
				valueAddBase + valueAddPerPower * power,
				valueMulBase + valueMulPerPower * power
		)
	}
	
	public function spawn(identified:Boolean, power:int):Enchantment {
		return doDecode(identified, [power]);
	}
	
	public override function generateRandom(options:Object = null):Enchantment {
		var power:int = (maxPower <= minPower) ? minPower : (rand(maxPower + 1 - minPower) + minPower);
		return doDecode(valueOr(options.identified, false), [power]);
	}
	
	public function SimpleEnchtantmentType(id:int,
										   name:String,
										   curse:Boolean,
										   prefix:String,
										   suffix:String,
										   shortSuffix:String,
										   description:String,
										   rarity:int,
										   minLevel:int,
										   minPower:int,
										   maxPower:int,
										   valueAddBase:int,
										   valueAddPerPower:int,
										   valueMulBase:Number,
										   valueMulPerPower:Number,
										   onEquipFn:Function = null,
										   onUnequipFn:Function = null) {
		super(id, name, curse, prefix, suffix, shortSuffix, description, rarity, minLevel);
		this.minPower         = minPower;
		this.maxPower         = maxPower;
		this.valueAddBase     = valueAddBase;
		this.valueAddPerPower = valueAddPerPower;
		this.valueMulBase     = valueMulBase;
		this.valueMulPerPower = valueMulPerPower;
		this.onEquipFn        = onEquipFn;
		this.onUnequipFn      = onUnequipFn;
	}
	
	override public function onEquip(player:Player, enchantment:Enchantment, item:ItemType):void {
		if (onEquipFn != null) varargify(onEquipFn)(player, enchantment, item);
	}
	
	override public function onUnequip(player:Player, enchantment:Enchantment, item:ItemType):void {
		if (onUnequipFn != null) varargify(onUnequipFn)(player, enchantment, item);
	}
}
}
