package classes.Items {
import classes.CoC;
import classes.EngineCore;
import classes.ItemTemplate;
import classes.ItemType;
import classes.Items.Dynamic.DynamicArmor;
import classes.Items.Dynamic.DynamicRing;
import classes.Items.Dynamic.DynamicWeapon;

/**
 * Dynamic Item Utilities
 */
public class DynamicItems extends ItemConstants {
	
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
	
	public static const RARITY_CHANCES_LESSER:Array = [
		// weights sum to 100 so chances are in %
		[75, RARITY_COMMON],
		[20, RARITY_MAGICAL],
		[5, RARITY_RARE]
	];
	
	public static const RARITY_CHANCES_MINOR_LOW:Array = [
		// weights sum to 100 so chances are in %
		[40, RARITY_COMMON],
		[40, RARITY_MAGICAL],
		[20, RARITY_RARE]
	];
	
	public static const RARITY_CHANCES_MINOR_HIGH:Array = [
		// weights sum to 100 so chances are in %
		[20, RARITY_COMMON],
		[30, RARITY_MAGICAL],
		[50, RARITY_RARE]
	];
	
	/**
	 * Weighted random table for quality rolls at specific NG+ level
	 */
	public static function QUALITY_CHANCES(ngLevel:int):Array {
		var table:Array    = [[1, +0]];
		var maxQuality:int = ngLevel * 2;
		var chance:Number  = 1;
		for (var q:int = 1; q <= maxQuality; q++) {
			chance /= 4;
			table.push([chance, q]);
		}
		return table;
	}
	
	public static const CURSE_CHANCES_FOR_NEGATIVE:Array = [
		[30, CS_HIDDEN_CURSED],
		[70, CS_HIDDEN_UNCURSED],
	];
	public static const CURSE_CHANCES_DEFAULT:Array      = [
		[10, CS_HIDDEN_CURSED],
		[90, CS_HIDDEN_UNCURSED],
	];
	
	public static const ITEM_CATEGORY_CHANCES_DEFAULT:Array = [
		[5, CATEGORY_WEAPON_MELEE],
		//		[1, CATEGORY_WEAPON_RANGED],
		//		[1, CATEGORY_SHIELD],
		[5, CATEGORY_ARMOR],
		//		[1, CATEGORY_UNDERGARMENT],
		//		[1, CATEGORY_NECKLACE],
		//		[1, CATEGORY_JEWELRY_HEAD],
		[1, CATEGORY_JEWELRY_RING],
		//		[1, CATEGORY_JEWELRY_MISC],
		//		[0.1, CATEGORY_VEHICLE],
		//		[0.1, CATEGORY_FLYING_SWORD],
	];
	
	/**
	 * @param options.level Level (for picking enchantments), default - player level
	 * @param options.ng New Game+ factor, default - current NG factor
	 * @param options.rarity Rarity, const or weighted random table
	 * @param options.quality Quality, const or weighted random table
	 * @param options.category Item category (see ItemType.CATEGORY_XXXX) or weighted random table
	 * @param options.subtype Subtype within the category, or weighted random spetable
	 * @param options.cursed Curse status or weighted random table
	 * @param options.identified Effects are identified (defualt false)
	 * @return
	 */
	public static function randomItem(options:Object = null):ItemType {
		var ng:int    = valueOr(options.ng, CoC.instance.newGamePlusFactor());
		var level:int = valueOr(options.level, CoC.instance.player.level);
		options       = extend({
			rarity: RARITY_CHANCES_DEFAULT,
			quality: QUALITY_CHANCES(ng),
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
				items.push([numberOr(subtypes[subtype].chance, 1), subtype]);
			}
			return weightedRandom(items);
		}
		
		var template:ItemTemplate;
		var subtypeLib:Object;
		switch (category) {
			case CATEGORY_WEAPON_MELEE:
				template   = ItemTemplateLib.instance.TDynamicWeapon;
				subtypeLib = DynamicWeapon.Subtypes;
				break;
			case CATEGORY_ARMOR:
				template   = ItemTemplateLib.instance.TDynamicArmor;
				subtypeLib = DynamicArmor.Subtypes;
				break;
			case CATEGORY_JEWELRY_RING:
				template   = ItemTemplateLib.instance.TDynamicRing;
				subtypeLib = DynamicRing.Subtypes;
				break;
			default:
				throw new Error("Unsupported item category " + category);
		}
		if (options.subtype) {
			subtype = weightedRandom(options.subtype);
		} else {
			subtype = randomSubtype(subtypeLib);
		}
		trace("  subtype=" + subtype);
		var subtypeObj: Object = subtypeLib[subtype];
		if (!subtype || !subtypeObj) {
			throw new Error("Failed to pick subtype for " + category);
		}
		if ('quality' in subtypeObj) {
			quality = subtypeObj.quality;
		}
		
		// encoded enchantments [identified, type, ...]
		var enchantments:Array  = [];
		var hasNegative:Boolean = false;
		var hasCursed:Boolean   = false;
		
		function addEnchantment(rarity:int, tries:int = 5):void {
			var e:Enchantment = EnchantmentLib.instance.randomEnchantment(category, rarity, level, {identified: identified});
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
		
		var cursed:int;
		if (hasCursed) {
			cursed = CS_HIDDEN_CURSED;
		} else if ('cursed' in options) {
			cursed = weightedRandom(options.cursed);
		} else if (hasNegative) {
			cursed = weightedRandom(CURSE_CHANCES_FOR_NEGATIVE);
		} else {
			cursed = weightedRandom(CURSE_CHANCES_DEFAULT);
		}
		if (identified) cursed |= CSBITMASK_KNOWN; // set known flag
		trace("  cursed=" + cursed);
		
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
	 *     effectDesc: Array,
	 *     value: Number,
	 *     buffs: Object,
	 *     buffsStack: Boolean,
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
		var cursed:Boolean     = !!(curseStatus & CSBITMASK_CURSED);
		var curseKnown:Boolean = !!(curseStatus & CSBITMASK_KNOWN);
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
			try {
				e = EnchantmentLib.decode(o);
			} catch (error:Error) {
				trace(error.getStackTrace());
				return {error: error.message+"\n"+error.getStackTrace()};
			}
			if (!e) return {error: "Invalid enchantment type " + o[1]};
			effects.push(e);
		}
		
		// Pull stuff from the subtype and generate name and description
		var subtype:Object = subtypes[subtypeId];
		if (!subtype) return {error: "Invalid subtype"};
		var shortName:String           = subtype.shortName;
		var name:String                = subtype.name;
		var desc:String                = subtype.desc;
		var effectDesc:Array           = [];
		var value:Number               = subtype.value;
		var rname:String               = Rarities[rarity].name;
		var qname:String               = (quality < 0) ? "" + quality : "+" + quality;
		var longName:String;
		
		// value = (base_value * rarity + sum of effects' add_value)
		//         * product of effects' mul_value
		// If quality > 0, add 20%*quality
		// If quality < 0, subtract 10%*quality but no less than 50%
		var valueMul:Number = 1.0;
		value *= Rarities[rarity].valueMul;
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
		if (!curseKnown) effectDesc.push([0,"Curse: Unknown."]);
		else if (cursed) effectDesc.push([0,"<b>Cursed!</b>"]);
		effectDesc.push([40,"Rarity: " + capitalizeFirstLetter(rname)]);
		if (subtype.quality !== 0) {
			effectDesc.push([45,"Quality: " + qname]);
		}
		var hasUnknownEffects:Boolean = false;
		var i:int = 0;
		for each (e in effects) {
			if (e.identified) {
				if (!e.type.hideDescription(e)) {
					var description:String = e.description;
					if (description) {
						effectDesc.push([80 + i, "Effect: " + description]);
					}
				}
				value += e.valueAdd;
				valueMul *= e.valueMul;
			} else {
				hasUnknownEffects = true;
				effectDesc.push([80+i,"Effect: (Unknown effect)"]);
			}
			i++;
		}
		if (identified) {
			var me1:Enchantment     = null;
			var me2:Enchantment     = null;
			var prefix:String       = "";
			var suffix:String       = "";
			var divinePrefix:String = "";
			if (effects.length > 0) shortName += " ";
			for each (e in effects) {
				shortName += e.shortSuffix;
				switch (e.rarity) {
					case RARITY_DIVINE:
						divinePrefix += e.prefix;
						break;
					case RARITY_LEGENDARY:
						break;
					case RARITY_MAGICAL:
						if (!me1) me1 = e;
						else if (!me2) me2 = e;
						break;
				}
			}
			if (me1 && me2) {
				// 2 magical effects: use prefix and suffix
				if (me1.prefix && me2.suffix) {
					prefix = me1.prefix;
					suffix = me2.suffix;
				} else {
					prefix = me2.prefix;
					suffix = me1.suffix;
				}
			} else if (me1) {
				// 1 magical effect: use prefix (preferred) or suffix
				if (me1.prefix) prefix = me1.prefix;
				else suffix = me1.suffix;
			}
			name = divinePrefix + prefix + name + suffix;
		} else {
			if (hasUnknownEffects) {
				if (rarity != RARITY_COMMON) name = rname + " " + name;
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
		
		// buffs
		var buffs:Object = null;
		
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
			effectDesc: effectDesc,
			value: Math.round(value * valueMul),
			buffs: buffs,
			error: ""
		};
	}
	
	/**
	 * Finish initialization of a DynamicItem by assigning its tags, buffs, itemeffects, and invoking enchantments' onAdd() callbacks.
	 */
	public static function postConstruct(item:Equipable, tags:Array, buffs:Object, itemEffects:Array, qitemEffects:Array, quality:Number):void {
		item.stackSize = 1;
		item.pearlStackSize = 1;
		item.withTagsV(tags);
		item.withBuffs(buffs);
		for each (var iedef:Array in itemEffects) {
			var type:ItemEffectType = iedef[0] as ItemEffectType;
			var power:Number = iedef[1] as Number;
			var value1:* = iedef[2];
			var value2:* = iedef[3];
			var value3:* = iedef[4];
			var value4:* = iedef[5];
			for each (var qiedef:Array in qitemEffects) {
				if (qiedef[0] == type && qiedef[2] == value1 && qiedef[3] == value2 && qiedef[4] == value3 && qiedef[5] == value4) {
					power += qiedef[1]*quality;
					break;
				}
			}
			item.withEffect(type, power, value1, value2, value3, value4);
		}
		for each (var enchantment:Enchantment in item.getEnchantments()) {
			if (enchantment.identified) {
				enchantment.type.onAdd(enchantment, item);
			}
		}
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
		if (item.curseStatus == CS_KNOWN_CURSED) return BTNCOLOR_CURSED;
		return Rarities[item.rarity].buttonColor;
	}
	
	public static function encodeEnchantments(effects:/*Enchantment*/Array):Array {
		var e:Array = [];
		for each (var eff:Enchantment in effects) {
			e.push(eff.encode());
		}
		return e;
	}
	
	public static function identifiedCopy(item:ItemType):ItemType {
		var params:Object = item.templateParams();
		params.c |= CSBITMASK_KNOWN; // set known flag
		for each (var effect:Array in params.e) {
			effect[0] = 1; // set identified flag
		}
		var id:String = ItemType.dynamicItemId(item.templateId(), params);
		return ItemType.lookupItem(id);
	}
	
	public static function uncursedCopy(item:ItemType):ItemType {
		if (!item.cursed) return item;
		var params:Object = item.templateParams();
		params.c          = CS_KNOWN_UNCURSED;
		var id:String     = ItemType.dynamicItemId(item.templateId(), params);
		return ItemType.lookupItem(id);
	}
	
	public static function moddedCopy(item:ItemType, options:Object):ItemType {
		var idi:IDynamicItem = item as IDynamicItem;
		return createItem(ItemTemplate.lookupTemplate(item.templateId()),
				valueOr(options.t, idi.subtypeId),
				valueOr(options.r, idi.rarity),
				valueOr(options.q, idi.quality),
				valueOr(options.c, idi.curseStatus),
				valueOr(options.e, idi.effects)
		);
	}
	
	public static function copyWithEnchantment(item:ItemType, e:Enchantment):ItemType {
		return moddedCopy(item, {
			e: (item as IDynamicItem).effects.concat([e])
		});
	}
	
	public static function copyWithoutEnchantment(item:ItemType, e:Enchantment):ItemType {
		var effects:Array = (item as IDynamicItem).effects.slice();
		if (effects.indexOf(e) == -1) return item;
		effects.splice(effects.indexOf(e), 1);
		return moddedCopy(item, {
			e: effects
		});
	}
	
	public static function equipText(item:ItemType):void {
		EngineCore.outputText("You equip " + item.longName + ".  ");
		if (item.cursed) {
			if ((item as IDynamicItem).curseStatus == CS_HIDDEN_CURSED) {
				if (EngineCore.silly()) {
					EngineCore.outputText("A horrible chill runs down your spine - <b>this item is cursed!</b> ")
				} else if (item is Weapon) {
					EngineCore.outputText("You feel a sharp zap in your hand and realize you cannot let go of the weapon - <b>it is cursed!</b> ")
				} else if (item is Armor) {
					EngineCore.outputText("You feel blanketed by evil and realize you cannot remove the armor - <b>it is cursed!</b> ")
				} else {
					EngineCore.outputText("You feel an evil touch - <b>this item is cursed, you cannot unequip it!</b> ")
				}
			} else {
				EngineCore.outputText("<b>You cannot unequip it</b>. ")
			}
		}
		if (!(item as IDynamicItem).identified) {
			if ((item as IDynamicItem).effects.length > 0) {
				// This should be in sync with playerEquip
				EngineCore.outputText("You discover it to be " + identifiedCopy(item).longName + ". ");
			} else {
				EngineCore.outputText("It is not cursed. ");
			}
		}
	}
	
	public static function createItem(
			template:ItemTemplate,
			subtype:String,
			rarity:int,
			quality:int,
			curseStatus:int,
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
