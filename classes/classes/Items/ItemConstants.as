package classes.Items {
import classes.internals.EnumValue;
import classes.internals.Utils;

/**
 * Names & constants shared across various item types
 */
public class ItemConstants extends Utils {
	
	///////////////////////////////
	// Constants for all/any items
	///////////////////////////////
	
	// Item categories
	public static const CATEGORY_WEAPON_MELEE:String  = "weapon";
	public static const CATEGORY_WEAPON_RANGED:String = "weaponranged";
	public static const CATEGORY_SHIELD:String        = "shield";
	public static const CATEGORY_ARMOR:String         = "armor";
	public static const CATEGORY_UNDERGARMENT:String  = "undergarment";
	public static const CATEGORY_NECKLACE:String      = "necklace";
	public static const CATEGORY_JEWELRY_HEAD:String  = "headjewelry";
	public static const CATEGORY_JEWELRY_RING:String  = "jewelry";
	public static const CATEGORY_JEWELRY_MISC:String  = "miscjewelry";
	public static const CATEGORY_VEHICLE:String       = "vehicle";
	public static const CATEGORY_FLYING_SWORD:String  = "flyingsword";
	public static const CATEGORY_CONSUMABLE:String    = "consumable";
	public static const CATEGORY_USABLE:String        = "useable";
	public static const CATEGORY_OTHER:String         = "other";
	
	/////////////////
	// Armors
	/////////////////
	
	// Armor 'perks'
	public static const AP_LIGHT:String           = "Light";
	public static const AP_MEDIUM:String          = "Medium";
	public static const AP_HEAVY:String           = "Heavy";
	public static const AP_LIGHT_AYO:String       = "Light Ayo";
	public static const AP_HEAVY_AYO:String       = "Heavy Ayo";
	public static const AP_ULTRA_HEAVY_AYO:String = "Ultra Heavy Ayo";
	
	/////////////////
	// Weapons
	/////////////////
	
	// Weapon classes
	public static const WT_AXE:String           = "Axe";
	public static const WT_DAGGER:String        = "Dagger"; //~
	public static const WT_DUELING:String       = "Dueling";
	public static const WT_EXOTIC:String        = "Exotic";
	public static const WT_GAUNTLET:String      = "Gauntlet";
	public static const WT_MACE_HAMMER:String   = "Mace/Hammer";
	public static const WT_POLEARM:String       = "Polearm";
	public static const WT_RIBBON:String        = "Ribbon";
	public static const WT_SCYTHE:String        = "Scythe";
	public static const WT_SPEAR:String         = "Spear";
	public static const WT_STAFF:String         = "Staff";
	public static const WT_SWORD:String         = "Sword";
	public static const WT_THROWING:String      = "Throwing";
	public static const WT_WHIP:String          = "Whip";
	// Ranged weapon classes
	public static const WT_BOW:String           = "Bow";
	public static const WT_CROSSBOW:String      = "Crossbow";
	public static const WT_DUAL_FIREARMS:String = "Dual Firearms";
	public static const WT_PISTOL:String        = "Pistol";
	public static const WT_RIFLE:String         = "Rifle";
	public static const WT_2H_FIREARM:String    = "2H Firearm";
	
	// Weapon 'perks' (specials)
	public static const WP_DUAL:String       = "Dual";
	public static const WP_DUAL_SMALL:String = "Dual Small";
	public static const WP_DUAL_LARGE:String = "Dual Large";
	public static const WP_SMALL:String      = "Small";
	public static const WP_LARGE:String      = "Large";
	public static const WP_HYBRID:String     = "Hybrid";
	public static const WP_WHIPPING:String   = "Whipping";
	public static const WP_WHIRLWIND:String  = "Whirlwind";
	public static const WP_AP10:String       = "AP10";
	public static const WP_AP30:String       = "AP30";
	public static const WP_AP40:String       = "AP40";
	public static const WP_AP45:String       = "AP45";
	public static const WP_AP60:String       = "AP60";
	public static const WP_AP100:String      = "AP100";
	public static const WP_STUN10:String     = "Stun10";
	public static const WP_STUN15:String     = "Stun15";
	public static const WP_STUN20:String     = "Stun20";
	public static const WP_STUN25:String     = "Stun25";
	public static const WP_STUN30:String     = "Stun30";
	public static const WP_STUN40:String     = "Stun40";
	public static const WP_STUN50:String     = "Stun50";
	public static const WP_BLEED10:String    = "Bleed10";
	public static const WP_BLEED25:String    = "Bleed25";
	public static const WP_BLEED45:String    = "Bleed45";
	public static const WP_BLEED100:String   = "Bleed100";
	public static const WP_LGWRATH:String    = "LGWrath";
	public static const WP_MGWRATH:String    = "MGWrath";
	
	public static const WEAPON_PERK_NAMES:Object = createMapFromPairs([
		[WP_AP10, "10% Armor Penetration"],
		[WP_AP30, "30% Armor Penetration"],
		[WP_AP40, "40% Armor Penetration"],
		[WP_AP45, "45% Armor Penetration"],
		[WP_AP60, "60% Armor Penetration"],
		[WP_AP100, "100% Armor Penetration"],
		[WP_STUN10, "+10% Stun"],
		[WP_STUN15, "+15% Stun"],
		[WP_STUN20, "+20% Stun"],
		[WP_STUN25, "+25% Stun"],
		[WP_STUN30, "+30% Stun"],
		[WP_STUN40, "+40% Stun"],
		[WP_STUN50, "+50% Stun"],
		[WP_BLEED10, "+10% Bleed"],
		[WP_BLEED25, "+25% Bleed"],
		[WP_BLEED45, "+45% Bleed"],
		[WP_BLEED100, "+100% Bleed"],
		[WP_LGWRATH, "Low Grade Wrath"],
		[WP_MGWRATH, "Mid Grade Wrath"],
	])
	
	///////////////////
	// Jewelry (rings)
	///////////////////
	
	///////////////////
	// Enchanted items
	///////////////////
	
	/**
	 * EnumValue properties:
	 * - value: code (1)
	 * - id: var name ("MAGICAL")
	 *
	 * - name: display name ("magical")
	 * - buttonColor: button label color
	 * - value: Base value multiplier
	 */
	public static const Rarities:/*EnumValue*/Array = [];
	
	public static const RARITY_COMMON:int    = 0;
	public static const RARITY_MAGICAL:int   = 1;
	public static const RARITY_RARE:int      = 2;
	public static const RARITY_LEGENDARY:int = 3;
	public static const RARITY_DIVINE:int    = 4;
	EnumValue.add(Rarities, RARITY_COMMON, "COMMON", {
		name: "common",
		buttonColor: "#000000",
		value: 1
	});
	EnumValue.add(Rarities, RARITY_MAGICAL, "MAGICAL", {
		name: "magical",
		buttonColor: "#0000C0",
		value: 1
	});
	EnumValue.add(Rarities, RARITY_RARE, "RARE", {
		name: "rare",
		buttonColor: "#006000",
		value: 2
	});
	EnumValue.add(Rarities, RARITY_LEGENDARY, "LEGENDARY", {
		name: "legendary",
		buttonColor: "#FFFF40",
		value: 3
	});
	EnumValue.add(Rarities, RARITY_DIVINE, "DIVINE", {
		name: "divine",
		buttonColor: "#80EEEE",
		value: 4
	});
	
	public static const BTNCOLOR_CURSED:String = "#800000";
	
	public static const CS_HIDDEN_UNCURSED:int = 0;
	public static const CS_KNOWN_UNCURSED:int  = 1;
	public static const CS_HIDDEN_CURSED:int   = 2;
	public static const CS_KNOWN_CURSED:int    = 3;
	
	public static const CSBITMASK_CURSED:int = 2; // 0b10
	public static const CSBITMASK_KNOWN:int  = 1; // 0b01
	
	public function ItemConstants() {
	}
}
}
