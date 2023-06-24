package classes.Items {
import classes.Player;

public class Enchantment {
	public var identified:Boolean;
	public var type:EnchantmentType;
	public var prefix:String;
	public var suffix:String;
	public var shortSuffix:String;
	public var power:Number;
	public var params:Array;
	public var valueAdd:Number;
	public var valueMul:Number;
	
	public function get id():int {
		return type.id;
	}
	
	public function get rarity():int {
		return type.rarity;
	}
	
	public function get curse():Boolean {
		return type.curse;
	}
	
	public function encode():Array {
		return [identified ? 1 : 0, type.id].concat(params);
	}
	
	public function Enchantment(
			identified:Boolean,
			type:EnchantmentType,
			prefix:String,
			suffix:String,
			shortSuffix:String,
			power:Number,
			params:Array,
			valueAdd:Number,
			valueMul:Number,
			genText:Boolean = true
	) {
		this.identified  = identified;
		this.type        = type;
		this.prefix      = prefix;
		this.suffix      = suffix;
		this.shortSuffix = shortSuffix;
		this.power       = power;
		this.params      = params;
		this.valueAdd    = valueAdd;
		this.valueMul    = valueMul;
		if (genText) this.genDescription();
	}
	protected function genDescription():void {
		try {
			this.prefix      = EnchantmentType.parseEnchantmentText(prefix, this);
			this.suffix      = EnchantmentType.parseEnchantmentText(suffix, this);
		} catch (e:Error) {
			trace(e.getStackTrace());
		}
	}
	public function get description():String {
		var description:String = "";
		try {
			description = EnchantmentType.parseEnchantmentText(type.descPattern, this);
		} catch (e:Error) {
			trace(e.getStackTrace());
			description = "ERROR "+e.message+"\n"+e.getStackTrace();
		}
		return description;
	}
	
	/**
	 * Apply effects when enchanted item is equipped
	 */
	public function onEquip(player:Player, item:Equipable):void {
		type.onEquip(player, this, item);
	}
	
	/**
	 * Remove effects when enchanted item is unequipped
	 */
	public function onUnequip(player:Player, item:Equipable):void {
		type.onUnequip(player, this, item);
	}
}
}
