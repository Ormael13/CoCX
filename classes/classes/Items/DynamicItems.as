package classes.Items {
import classes.ItemTemplate;
import classes.ItemType;
import classes.Items.Dynamic.DynamicWeapon;
import classes.internals.EnumValue;
import classes.internals.Utils;

import coc.view.CoCButton;

/**
 * Dynamic Item Utilities
 */
public class DynamicItems extends Utils {
	
	/**
	 * EnumValue properties:
	 * - value: code (1)
	 * - id: var name ("MAGICAL")
	 *
	 * - name: display name ("magical")
	 * - buttonColor: button label color
	 */
	public static const Rarities:/*EnumValue*/Array = [];
	
	public static const RARITY_COMMON:int    = 0;
	public static const RARITY_MAGICAL:int   = 1;
	public static const RARITY_RARE:int      = 2;
	public static const RARITY_LEGENDARY:int = 3;
	public static const RARITY_DIVINE:int    = 4;
	
	EnumValue.add(Rarities, RARITY_COMMON, "COMMON", {
		name: "common",
		buttonColor: CoCButton.DEFAULT_COLOR
	});
	EnumValue.add(Rarities, RARITY_MAGICAL, "MAGICAL", {
		name: "magical",
		buttonColor: "#0000C0"
	});
	EnumValue.add(Rarities, RARITY_RARE, "RARE", {
		name: "rare",
		buttonColor: "#006000"
	});
	EnumValue.add(Rarities, RARITY_LEGENDARY, "LEGENDARY", {
		name: "legendary",
		buttonColor: "#FFFF40"
	});
	
	EnumValue.add(Rarities, RARITY_DIVINE, "DIVINE", {
		name: "divine",
		buttonColor: "#80EEEE"
	});
	
	public static const BTNCOLOR_CURSED:String = "#800000";
	
	public static const HIDDEN_UNCURSED:int = 0;
	public static const KNOWN_UNCURSED:int  = 1;
	public static const HIDDEN_CURSED:int   = 2;
	public static const KNOWN_CURSED:int    = 3;
	
	public static const CS_CURSED_MASK:int = 2; // 0b10
	public static const CS_KNOWN_MASK:int  = 1; // 0b01
	
	//////////////////////
	// Random generation Tables
	// (weights do not have to sum to 100)
	/////////////////////
	
	public static const RARITY_CHANCES_DEFAULT:Array = [
		// weights sum to 100 so chances are in %
		[30, RARITY_COMMON],
		[40, RARITY_MAGICAL],
		[20, RARITY_RARE],
		[8, RARITY_LEGENDARY],
		[2, RARITY_DIVINE]
	];
	
	public static const QUALITY_CHANCES_DEFAULT:Array = [
		[1 / 20, -10],
		[1 / 18, -9],
		[1 / 16, -8],
		[1 / 14, -7],
		[1 / 12, -6],
		[1 / 10, -5],
		[1 / 8, -4],
		[1 / 6, -3],
		[1 / 4, -2],
		[1 / 2, -1],
		[1, 0],
		[1, +1],
		[1 / 2, +2],
		[1 / 3, +3],
		[1 / 4, +4],
		[1 / 5, +5],
		[1 / 6, +6],
		[1 / 7, +7],
		[1 / 8, +8],
		[1 / 9, +9],
		[1 / 10, +10],
		[1 / 11, +11],
		[1 / 12, +12],
		[1 / 13, +13],
		[1 / 14, +14],
		[1 / 15, +15],
	];
	
	public static const CURSE_CHANCES_FOR_NEGATIVE:Array = [
		[30, HIDDEN_CURSED],
		[70, HIDDEN_UNCURSED],
	];
	public static const CURSE_CHANCES_DEFAULT:Array      = [
		[10, HIDDEN_CURSED],
		[90, HIDDEN_UNCURSED],
	];
	
	public static const ITEM_CATEGORY_CHANCES_DEFAULT:Array = [
		[5, ItemType.CATEGORY_WEAPON_MELEE],
		//		[1, ItemType.CATEGORY_WEAPON_RANGED],
		//		[1, ItemType.CATEGORY_SHIELD],
		//		[5, ItemType.CATEGORY_ARMOR],
		//		[1, ItemType.CATEGORY_UNDERGARMENT],
		//		[1, ItemType.CATEGORY_NECKLACE],
		//		[1, ItemType.CATEGORY_JEWELRY_HEAD],
		//		[1, ItemType.CATEGORY_JEWELRY_RING],
		//		[1, ItemType.CATEGORY_JEWELRY_MISC],
		//		[0.1, ItemType.CATEGORY_VEHICLE],
		//		[0.1, ItemType.CATEGORY_FLYING_SWORD],
	];
	
	/**
	 * @param options.rarity Rarity, const or weighted random table
	 * @param options.quality Quality, const or weighted random table
	 * @param options.category Item category (see ItemType.CATEGORY_XXXX) or weighted random table
	 * @param options.subtype Subtype within the category, or weighted random spetable
	 * @param options.cursed Curse status or weighted random table
	 * @param options.identified Effects are identified (defualt false)
	 * @return
	 */
	public static function randomItem(options:Object = null):ItemType {
		options = extend({
			rarity: RARITY_CHANCES_DEFAULT,
			quality: QUALITY_CHANCES_DEFAULT,
			category: ITEM_CATEGORY_CHANCES_DEFAULT,
			identified: false
		}, options);
		
		var rarity:int         = weightedRandom(options.rarity);
		var quality:int        = weightedRandom(options.quality);
		var category:String    = weightedRandom(options.category);
		var identified:Boolean = weightedRandom(options.identified);
		trace("Generating random " + Rarities[rarity].name + " q=" + quality + " " + category + "...");
		var subtype:String;
		
		function randomSubtype(subtypes:Object):String {
			var items:Array = [];
			for (var subtype:String in subtypes) {
				items.push([numberOr(subtypes[subtype].weight, 1), subtype]);
			}
			return weightedRandom(items);
		}
		
		var template:ItemTemplate;
		switch (category) {
			case ItemType.CATEGORY_WEAPON_MELEE:
				template = ItemTemplateLib.instance.TDynamicWeapon;
				if (options.subtype) {
					subtype = weightedRandom(options.subtype);
				} else {
					subtype = randomSubtype(DynamicWeapon.Subtypes);
				}
				break;
			default:
				throw new Error("Unsupported item category " + category);
		}
		trace("  subtype=" + subtype);
		
		// encoded enchantments [identified, type, ...]
		var enchantments:Array  = [];
		var hasNegative:Boolean = false;
		var hasCursed:Boolean   = false;
		
		function addEnchantment(rarity:int, tries:int = 5):void {
			var e:Enchantment = EnchantmentLib.instance.randomEnchantment(category, rarity, {identified: identified});
			if (e) {
				// Reroll max 5 times if found a duplicate
				for each (var e2:Array in enchantments) {
					if (e2[1] === e.type.id) {
						if (tries > 0) {
							trace("  " + e.description + " (rerolling)");
							addEnchantment(rarity, tries - 1);
						} else {
							trace("  " + e.description + " (reroll limit reached)");
						}
						return;
					}
				}
				trace("  " + e.description);
				enchantments.push(e.encode());
				if (e.curse) hasCursed = true;
			} else {
				trace("  (failed to generate magical effect)")
			}
		}
		
		var cursed:int;
		if (hasCursed) {
			cursed = HIDDEN_CURSED;
		} else if ('cursed' in options) {
			cursed = weightedRandom(options.cursed);
		} else if (hasNegative) {
			cursed = weightedRandom(CURSE_CHANCES_FOR_NEGATIVE);
		} else {
			cursed = weightedRandom(CURSE_CHANCES_DEFAULT);
		}
		if (identified) cursed |= CS_KNOWN_MASK; // set known flag
		trace("  cursed=" + cursed);
		
		switch (rarity) {
			case RARITY_DIVINE:
				addEnchantment(RARITY_MAGICAL);
				addEnchantment(RARITY_MAGICAL);
				addEnchantment(RARITY_LEGENDARY);
				addEnchantment(RARITY_DIVINE);
				break;
			case RARITY_LEGENDARY:
				addEnchantment(RARITY_MAGICAL);
				addEnchantment(RARITY_MAGICAL);
				addEnchantment(RARITY_LEGENDARY);
				break;
			case RARITY_RARE:
				addEnchantment(RARITY_MAGICAL);
				addEnchantment(RARITY_MAGICAL);
				break;
			case RARITY_MAGICAL:
				addEnchantment(RARITY_MAGICAL);
				break;
			case RARITY_COMMON:
			default:
				break;
		}
		
		var itemType:ItemType = template.createItem({
			t: subtype,
			c: cursed,
			q: quality,
			r: rarity,
			e: enchantments
		});
		trace("Generated '" + itemType.longName + "' " + itemType.id);
		return itemType;
	}
	
	/////////////////////
	// Utilities
	/////////////////////
	
	/**
	 * Load and process dynamic item params, generate name and desciption.
	 * @param params Encoded dynamic item params
	 * @param subtypes A subtype dictionary
	 * @return {{
	 *     subtypeId: String,
	 *     subtype: Object,
	 *     quality: int,
	 *     rarity: int,
	 *     curseStatus: int,
	 *     cursed: Boolean,
	 *     curseKnown: Boolean,
	 *     identified: Boolean,
	 *     effects: Enchantment[],
	 *     shortName: String,
	 *     name: String,
	 *     longName: String,
	 *     desc: String,
	 *     error: String
	 * }}
	 */
	public static function loadCommonDynamicItemParams(params:Object, subtypes:Object):Object {
		var o:Array;
		var e:Enchantment;
		
		if (!("t" in params && "q" in params && "r" in params && "c" in params && "e" in params)) {
			return {error: "Missing param key"};
		}
		// Pull out params
		var subtypeId:String = params["t"];
		var quality:int      = params["q"];
		var rarity:int       = params["r"];
		var curseStatus:int  = params["c"];
		var enchData:Array   = params["e"];
		if (rarity < RARITY_COMMON || rarity > RARITY_DIVINE
				|| curseStatus < 0 || curseStatus > 3
				|| !enchData
				|| !subtypeId
		) {
			return {error: "Invalid params"}
		}
		
		// Compute props
		var cursed:Boolean     = !!(curseStatus & CS_CURSED_MASK);
		var curseKnown:Boolean = !!(curseStatus & CS_KNOWN_MASK);
		var identified:Boolean = curseKnown;
		for each (o in enchData) {
			if (!o || o.length < 2) return {error: "Invalid enchantment"}
			if (!o[1]) continue;
			if (!o[0]) {
				identified = false;
				break;
			}
		}
		var effects:/*Enchantment*/Array = [];
		for each (o in enchData) {
			if (!o[1]) continue;
			e = EnchantmentLib.decode(o);
			if (!e) return {error: "Invalid enchantment type " + o[1]};
			effects.push(e);
		}
		
		// Pull stuff from the subtype and generate name and description
		var subtype:Object   = subtypes[subtypeId];
		var shortName:String = subtype.shortName;
		var name:String      = subtype.name;
		var desc:String      = subtype.desc;
		var value:Number     = subtype.value;
		var rname:String     = Rarities[rarity].name;
		var qname:String     = (quality < 0) ? "" + quality : "+" + quality;
		var longName:String;
		if (!subtype) return {error: "Invalid subtype"};
		
		// value = (base_value * rarity + sum of effects' add_value)
		//         * product of effects' mul_value
		// If quality > 0, add 20%*quality
		// If quality < 0, subtract 10%*quality but no less than 50%
		var valueMul:Number = 1.0;
		value *= rarity;
		if (quality > 0) valueMul *= quality * 0.2;
		if (quality < 0) valueMul *= Math.max(0.5, quality * 0.1);
		
		// Description:
		// 		Rarity: Divine
		// 		Quality: +15
		// 		This item is cursed!
		// 		+30% Int
		// 		(Unknown effet)
		// 		+10% EXP gain
		// 		(Unknown effect)
		// Names:
		// 		cursed Taoth's Vulpine sword of kitsune legacy +15
		// 		(?) legendary sword -5
		// Button names:
		// 		!swd TaoVlKL
		// 		?swd ??
		desc += "\n";
		if (!curseKnown) desc += "\nCurse: Unknown.";
		else if (cursed) desc += "\n<b>Cursed!</b>";
		desc += "\nRarity: " + capitalizeFirstLetter(rname);
		desc += "\nQuality: " + qname;
		var hasUnknownEffects:Boolean = false;
		for each (e in effects) {
			if (e.identified) {
				desc += "\n" + e.description;
				value += e.valueAdd;
				valueMul *= e.valueMul;
			} else {
				hasUnknownEffects = true;
				desc += "\n(Unknown effect)";
			}
		}
		if (identified) {
			var prefix:String       = "";
			var suffix:String       = "";
			var divinePrefix:String = "";
			if (effects.length > 0) shortName += " ";
			for each (e in effects) {
				shortName += e.shortSuffix;
				switch (e.rarity) {
					case DynamicItems.RARITY_DIVINE:
						divinePrefix += e.prefix;
						break;
					case DynamicItems.RARITY_LEGENDARY:
						break;
					case DynamicItems.RARITY_MAGICAL:
						if (!prefix) {
							prefix = e.prefix;
						} else if (!suffix) {
							suffix = e.suffix;
						}
						break;
				}
			}
			name = divinePrefix + prefix + name + suffix;
		} else {
			if (hasUnknownEffects) {
				if (rarity != DynamicItems.RARITY_COMMON) name = rname + " " + name;
				name = "unidentified " + name;
				shortName += " ??";
			}
		}
		// common name parts
		longName = name; // name - long name without (?) or +X
		if (quality != 0) {
			longName = longName + " " + qname;
		}
		if (!curseKnown) {
			longName  = "(?) " + longName;
			shortName = "?" + shortName;
		} else if (cursed) {
			longName  = "cursed " + longName;
			name      = "cursed " + name;
			shortName = "!" + shortName;
		}
		
		return {
			subtypeId: subtypeId,
			subtype: subtype,
			quality: quality,
			rarity: rarity,
			curseStatus: curseStatus,
			cursed: cursed,
			curseKnown: curseKnown,
			identified: identified,
			effects: effects,
			shortName: shortName,
			name: name,
			longName: longName,
			desc: desc,
			value: Math.round(value * valueMul),
			error: ""
		};
	}
	
	public static function itemHasEnchantment(item:ItemType, type:EnchantmentType):Boolean {
		return itemEnchantmentOfType(item, type) != null;
	}
	
	public static function itemEnchantmentPower(item:ItemType, type:EnchantmentType):Number {
		var e:Enchantment = itemEnchantmentOfType(item, type);
		return e ? e.power : 0;
	}
	
	public static function itemEnchantmentOfType(item:ItemType, type:EnchantmentType):Enchantment {
		for each (var e:Enchantment in item.getEnchantments()) {
			if (e.type == type) return e;
		}
		return null;
	}
	
	public static function itemButtonColor(item:IDynamicItem):String {
		if (item.curseStatus == KNOWN_CURSED) return BTNCOLOR_CURSED;
		return Rarities[item.rarity].buttonColor;
	}
	
	public static function encodeEnchantments(effects:/*Enchantment*/Array):Array {
		var e:Array = [];
		for each (var eff:Enchantment in effects) {
			e.push(eff.encode());
		}
		return e;
	}
	
	public static function createItem(
			template: ItemTemplate,
			subtype: String,
			rarity: int,
			quality: int,
			curseStatus: int,
			effects: /*Enchantment*/Array
	):ItemType {
		return template.createItem({
			t: subtype,
			r: rarity,
			q: quality,
			c: curseStatus,
			e: DynamicItems.encodeEnchantments(effects)
		});
	}
	
	public function DynamicItems() {
	}
}
}
