package classes.Items {
import classes.Items.Dynamic.Effects.SimpleEnchtantmentType;
import classes.Items.Dynamic.Effects.StatEnchantmentType;

public class EnchantmentLib extends ItemConstants {
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
	 * 	description: "{X;+d} to Xxxx", // required. See EnchantmentType.genDescription for formatter description
	 * 	rarity: RARITY_LEGENDARY, // optional, default = RARITY_MAGICAL. don't use RARITY_RARE or RARITY_COMMON.
	 * 	minLevel: 5, // optional, default = 1. min level to spawn the enchantment
	 * 	categories: [CATEGORY_WEAPON_MELEE], // optional, default = all categories
	 * 	chance: 2.0, // optional, relative spawn chance, default 1
	 * 	minPower: 0, // optional, default 1
	 * 	maxPower: 10, // optional, default 1
	 * 	value: 100, // optional, default 0
	 * 	valuePerPower: 100, // optional, default 0
	 * 	valueX: 1.2, // optional, default 1
	 * 	valueXPerPower: 0.1, // optional, default 0
	 * 	onEquip: function(player:Player, enchantment:Enchantment, item:ItemType):void { ... }, // optional, default null
	 * 	onUnequip: function(player:Player, enchantment:Enchantment, item:ItemType):void { ... }, // optional, default null
	 * });
	 */
	
	// Number IDs are written in saved and should never change across versions!
	// Everything else - can.
	
	private static const SPAWN_COMMON:Number     = 1.0;
	private static const SPAWN_UNCOMMON:Number   = 0.25;  //   4x are
	private static const SPAWN_RARE:Number       = 0.1;   //  10x rare
	private static const SPAWN_VERY_RARE:Number  = 0.025; //  40x rare
	private static const SPAWN_SUPER_RARE:Number = 0.01;  // 100x rare
	
	private static const CATEGORIES_WEARABLE:/*String*/Array = [
		CATEGORY_ARMOR, CATEGORY_UNDERGARMENT,
		CATEGORY_NECKLACE, CATEGORY_JEWELRY_RING, CATEGORY_JEWELRY_MISC, CATEGORY_JEWELRY_HEAD
	];
	private static const CATEGORIES_JEWELRY:/*String*/Array  = [
		CATEGORY_NECKLACE, CATEGORY_JEWELRY_RING, CATEGORY_JEWELRY_MISC, CATEGORY_JEWELRY_HEAD
	];
	
	public static const Strength:EnchantmentType          = new StatEnchantmentType(1, "Strength",
			"str.mult",
			"Strong ", " of Strength", "St",
			// minLevel, minPower, maxPower, statPerPower, value, valuePerPower, valueX, valueXPerPower
			2, 3, 6, 0.05, 0, 150)
			.setSpawnChance(SPAWN_COMMON);
	public static const Toughness:EnchantmentType         = new StatEnchantmentType(2, "Toughness",
			"tou.mult",
			"Tough ", " of Toughness", "To",
			2, 3, 6, 0.05, 0, 150)
			.setSpawnChance(SPAWN_COMMON);
	public static const Speed:EnchantmentType             = new StatEnchantmentType(3, "Speed",
			"spe.mult",
			"Fast ", " of Speed", "Sp",
			2, 3, 6, 0.05, 0, 150)
			.setSpawnChance(SPAWN_COMMON);
	public static const Intelligence:EnchantmentType      = new StatEnchantmentType(4, "Intelligence",
			"int.mult",
			"Smart ", " of Intellect", "In",
			2, 3, 6, 0.05, 0, 150)
			.setSpawnChance(SPAWN_COMMON);
	public static const Wisdom:EnchantmentType            = new StatEnchantmentType(5, "Wisdom",
			"wis.mult",
			"Wise ", " of Wisdom", "Ws",
			2, 3, 6, 0.05, 0, 150)
			.setSpawnChance(SPAWN_COMMON);
	public static const Libido:EnchantmentType            = new StatEnchantmentType(6, "Libido",
			"lib.mult", "Libidinous ", " of Libido", "Lb",
			2, 3, 6, 0.05, 0, 150)
			.setSpawnChance(SPAWN_COMMON);
	public static const Sensitivity:EnchantmentType       = new StatEnchantmentType(7, "Sensitivity",
			"sens", "Sensitive ", " of Sensitivity", "Sn",
			2, 3, 6, 2, 0, 150)
			.setSpawnChance(SPAWN_COMMON);
	public static const StrengthMinus:EnchantmentType     = new StatEnchantmentType(8, "Strength+",
			"str.mult",
			"Weak ", " of Weakness", "St-",
			// minLevel, minPower, maxPower, statPerPower, value, valuePerPower, valueX, valueXPerPower
			1, 3, 6, -0.05, 0, 0)
			.setNegative()
			.setSpawnChance(SPAWN_RARE);
	public static const ToughnessMinus:EnchantmentType    = new StatEnchantmentType(9, "Toughness-",
			"tou.mult",
			"Frail ", " of Frailty", "To-",
			1, 3, 6, -0.05, 0, 0)
			.setNegative()
			.setSpawnChance(SPAWN_RARE);
	public static const SpeedMinus:EnchantmentType        = new StatEnchantmentType(10, "Speed-",
			"spe.mult",
			"Slow ", " of Slowliness", "Sp-",
			1, 3, 6, -0.05, 0, 0)
			.setNegative()
			.setSpawnChance(SPAWN_RARE);
	public static const IntelligenceMinus:EnchantmentType = new StatEnchantmentType(11, "Intelligence-",
			"int.mult",
			"Dumb ", " of Dumbness", "In-",
			1, 3, 6, -0.05, 0, 0)
			.setNegative()
			.setSpawnChance(SPAWN_RARE);
	public static const WisdomMinus:EnchantmentType       = new StatEnchantmentType(12, "Wisdom-",
			"wis.mult",
			"Fool's ", " of Fool", "Ws-",
			1, 3, 6, -0.05, 0, 0)
			.setNegative()
			.setSpawnChance(SPAWN_RARE);
	public static const LibidoMinus:EnchantmentType       = new StatEnchantmentType(13, "Libido-",
			"lib.mult", "Frigid ", " of Frigidity", "Lb-",
			1, 3, 6, -0.05, 0, 0)
			.setNegative()
			.setSpawnChance(SPAWN_RARE);
	public static const SensitivityMinus:EnchantmentType  = new StatEnchantmentType(14, "Sensitivity-",
			"sens", "Numb ", " of Numbness", "Sn-",
			1, 3, 6, -2, 0, 0)
			.setNegative()
			.setSpawnChance(SPAWN_RARE);
	public static const MinLust:EnchantmentType           = new StatEnchantmentType(15, "MinLust",
			"minlustx", "Hotblooded ", " of hot blood", "HB",
			1, 1, 10, +0.01, 0, 100)
			.setItemCategories(CATEGORIES_WEARABLE)
			.setSpawnChance(SPAWN_COMMON);
	public static const MinFem:EnchantmentType            = mk(16, "MinFem", {
		prefix: "Femininie ",
		suffix: " of Femininity",
		shortSuffix: "Fem",
		description: "Min. femininity {power;+d}",
		minLevel: 1,
		categories: CATEGORIES_WEARABLE,
		chance: SPAWN_UNCOMMON,
		minPower: 1,
		maxPower: 10,
		value: 0,
		valuePerPower: 50
	});
	public static const MaxFem:EnchantmentType            = mk(17, "MaxFem", {
		prefix: "Masculine ",
		suffix: " of Masculinity",
		shortSuffix: "Mas",
		description: "Max. femininity {0-power;+d}",
		minLevel: 1,
		categories: CATEGORIES_WEARABLE,
		chance: SPAWN_UNCOMMON,
		minPower: 1,
		maxPower: 10,
		value: 0,
		valuePerPower: 50
	});
	public static const Androgyny:EnchantmentType         = mk(18, "Androgyny", {
		prefix: "Androgynous ",
		suffix: " of Androgyny",
		shortSuffix: "AG",
		description: "Min. femininity {power;+d}, max. femininity {0-power;+d}",
		minLevel: 1,
		categories: CATEGORIES_WEARABLE,
		chance: SPAWN_UNCOMMON,
		minPower: 1,
		maxPower: 10,
		value: 0,
		valuePerPower: 75
	});
	public static const BonusXp:EnchantmentType    = mk(19, "BonusXp", {
		prefix: "Sagely ",
		suffix: " of Sages",
		shortSuffix: "XP",
		description: "XP gain {power*5;+d}%",
		minLevel: 1,
		chance: SPAWN_RARE,
		minPower: 1,
		maxPower: 3,
		valueX: 1.0,
		valueXPerPower: 0.5
	});
	public static const TfImmunity:EnchantmentType = mk(20, "TfImmunity", {
		prefix: "Immutable ",
		suffix: " of Immutability",
		shortSuffix: "Im",
		description: "Transformation immunity",
		minLevel: 20,
		chance: SPAWN_VERY_RARE,
		value: 10000,
		categories: CATEGORIES_WEARABLE
	});
	
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
		return categoryTables[key].slice().filter(varargify(function (pair:Array):Boolean {
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
				valueOr(params.rarity, RARITY_MAGICAL),
				valueOr(params.minLevel, 0),
				valueOr(params.minPower, 1),
				valueOr(params.maxPower, 1),
				valueOr(params.value, 0),
				valueOr(params.valuePerPower, 0),
				valueOr(params.valueX, 1),
				valueOr(params.valueXPerPower, 0),
				valueOr(params.onEquip, null),
				valueOr(params.onUnEquip, null)
		);
		if ('chance' in params) enchantmentType.setSpawnChance(params.chance);
		if ('categories' in params) enchantmentType.setItemCategories(params.categories.slice());
		if (params['negative']) enchantmentType.setNegative();
		return enchantmentType;
	}
}
}
