package classes.Items {
import classes.Items.Dynamic.Effects.SimpleEnchtantmentType;
import classes.Items.Dynamic.Effects.StatEnchantmentType;

public class EnchantmentLib extends DynamicItems {
	// See EnchatmentType.genDescription for description expression syntax
	
	/*
	 * template
	 *
	 * public static const Xxxx:EnchantmentType = mk(UNIQUE_ID, "Name", {
	 * 	curse: true, // optional, default false. Guarantees cursed item
	 * 	negative: true, // optional, default false. Bigger chance for cursed item
	 * 	prefix: "Xxxx ", // optional, default empty
	 * 	suffix: " of Xxxx", // optional, default empty
	 * 	shortSuffix: "Xx", // optional, default empty. Button label. 2-3 chars!
	 * 	description: "+{X} to Xxxx", // required. See EnchantmentType.genDescription for formatter description
	 * 	rarity: RARITY_LEGENDARY, // optional, default = RARITY_MAGICAL. don't use RARITY_RARE or RARITY_COMMON.
	 * 	minLevel: 5, // optional, default = 1. min level to spawn the enchantment
	 * 	categories: [ItemType.CATEGORY_WEAPON_MELEE], // optional, default = all categories
	 * 	weight: 2.0, // optional, relative spawn chance, default 1
	 * 	minPower: 0, // optional, default 1
	 * 	maxPower: 10, // optional, default 1
	 * 	value: 100, // optional, default 0
	 * 	valuePerPower: 100, // optional, default 0
	 * 	valueX: 1.2, // optional, default 1
	 * 	valueXPerPower: 0.1, // optional, default 0
	 * });
	 */
	
	// Number IDs are written in saved and should never change across versions!
	// Everything else - can.
	
	public static const Strength:EnchantmentType     = new StatEnchantmentType(1, "Strength",
			"str.mult",
			"Strong ", " of Strength", "St",
			// minLevel, minPower, maxPower, value, valuePerPower, valueX, valueXPerPower
			1, 2, 5, 0, 300, 1, 0)
			.setSpawnChance(1);
	public static const Toughness:EnchantmentType    = new StatEnchantmentType(2, "Toughness",
			"tou.mult",
			"Tough ", " of Toughness", "To",
			1, 2, 5, 0, 300, 1, 0)
			.setSpawnChance(1);
	public static const Speed:EnchantmentType        = new StatEnchantmentType(3, "Speed",
			"spe.mult",
			"Fast ", " of Speed", "Sp",
			1, 2, 5, 0, 300, 1, 0)
			.setSpawnChance(1);
	public static const Intelligence:EnchantmentType = new StatEnchantmentType(4, "Intelligence",
			"int.mult",
			"Smart ", " of Intellect", "In",
			1, 2, 5, 0, 300, 1, 0)
			.setSpawnChance(1);
	public static const Wisdom:EnchantmentType       = new StatEnchantmentType(5, "Wisdom",
			"wis.mult",
			"Wise ", " of Wisdom", "Ws",
			1, 2, 5, 0, 300, 1, 0)
			.setSpawnChance(1);
	public static const Libido:EnchantmentType       = new StatEnchantmentType(6, "Libido",
			"lib.mult", "Libidinous ", " of Libido", "Lb",
			1, 2, 5, 0, 300, 1, 0)
			.setSpawnChance(1);
	
	public static function decode(o:Array):Enchantment {
		var id:int               = o[1];
		var type:EnchantmentType = EnchantmentType.ENCHANTMENT_TYPES[id];
		if (!type) return null;
		return type.decode(o);
	}
	
	/**
	 * (itemCategory+"/"+rarity) -> weighted table of enchantment types
	 */
	private var categoryTables:Object = {};
	
	public function getWeightedTable(itemCategory:String, rarity:int, level:int):Array {
		var key:String = itemCategory + "/" + rarity;
		if (!(key in categoryTables)) {
			var table:Array = [];
			var etype:EnchantmentType;
			for each (etype in values(EnchantmentType.ENCHANTMENT_TYPES)) {
				if (etype.rarity === rarity && etype.itemCategories.indexOf(itemCategory) >= 0) {
					table.push([etype.weight, etype]);
				}
			}
			categoryTables[key] = table;
		}
		return categoryTables[key].slice().filter(varargify(function(pair:Array):Boolean {
			return level >= (pair[1] as EnchantmentType).minLevel;
		}))
	}
	
	/**
	 * Might return null if no suitable enchantment types
	 */
	public function randomEnchantmentType(itemCategory:String, rarity:int, level:int):EnchantmentType {
		return weightedRandom(getWeightedTable(itemCategory, rarity, level));
	}
	
	/**
	 * Might return null if no suitable enchantment types
	 * @param level Pick enchantments with minLvl <= level
	 * @param options passed to EnchantmentType to fine-tune the roll
	 */
	public function randomEnchantment(itemCategory:String, rarity:int, level:int, options:Object = null):Enchantment {
		var etype:EnchantmentType = randomEnchantmentType(itemCategory, rarity, level);
		if (!etype) return null;
		return etype.generateRandom(options);
	}
	
	private static var _instance:EnchantmentLib;
	public static function get instance():EnchantmentLib {
		if (!_instance) new EnchantmentLib();
		return _instance;
	}
	
	public function EnchantmentLib() {
		_instance = this;
	}
	
	public static function mk(id:int, name:String, params:Object):EnchantmentType {
		var enchantmentType:EnchantmentType = new SimpleEnchtantmentType(
				id,
				name,
				valueOr(params.curse, false),
				valueOr(params.prefix, ""),
				valueOr(params.suffix, ""),
				valueOr(params.shortSuffix, ""),
				valueOrThrow(params.description, "Missing description"),
				valueOr(params.rarity, DynamicItems.RARITY_MAGICAL),
				valueOr(params.minLevel, 0),
				valueOr(params.minPower, 1),
				valueOr(params.maxPower, 1),
				valueOr(params.value, 0),
				valueOr(params.valuePerPower, 0),
				valueOr(params.valueX, 1),
				valueOr(params.valueXPerPower, 0)
		);
		if ('weight' in params) enchantmentType.setSpawnChance(params.weight);
		if ('categories' in params) enchantmentType.setItemCategories(params.categories.slice());
		if (params['negative']) enchantmentType.setNegative();
		return enchantmentType;
	}
}
}
