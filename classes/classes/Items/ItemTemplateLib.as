package classes.Items {
import classes.ItemTemplate;
import classes.Items.Consumables.HairDye;
import classes.Items.Dynamic.DynamicArmor;
import classes.Items.Dynamic.DynamicRing;
import classes.Items.Dynamic.DynamicWeapon;

public class ItemTemplateLib {
	public static var instance:ItemTemplateLib;
	
	public const THairDye:ItemTemplate = mk("HairDye", "Hair Dye", HairDye, {
		category: "consumable",
		params: [
			{name: "color", type: "text", value: "White"},
			/** Affects price */
			{name: "rarity", type: "number", value: 1, min: 1, max: 4},
		]
	});
	
	public function createHairDye(color:String, rarity:int):HairDye {
		return THairDye.createItem({color: color, rarity: rarity}) as HairDye;
	}
	
	// Generic dynamic items
	
	public const TDynamicWeapon:ItemTemplate = mk("DynamicWeapon", "Enchanted Weapon", DynamicWeapon, {
		category: "weapon",
		params: [
			{name: "t", label:"Subtype", type:"text", value:"sword"},
			{name: "r", label:"Rarity", type:"number", value:0, min:0, max: 4},
			{name: "q", label:"Quality", type:"number", value:0, min:-15, max:15},
			{name: "c", label:"Curse", type:"number", value:0, min:0, max:3},
			{name: "e", label:"Effects", type:"enchantments", value:[]}
		]
	});
	
	public function createWeapon(subtype:String, rarity:int, quality:int, curseStatus:int, effects:/*Enchantment*/Array):DynamicWeapon {
		return DynamicItems.createItem(TDynamicWeapon, subtype, rarity, quality, curseStatus, effects) as DynamicWeapon;
	}
	
	public const TDynamicArmor:ItemTemplate = mk("DynamicArmo"/* id, don't fix the typo */, "Enchanted Armor", DynamicArmor, {
		category: "armor",
		params: [
			{name: "t", label:"Subtype", type:"text", value:"sword"},
			{name: "r", label:"Rarity", type:"number", value:0, min:0, max: 4},
			{name: "q", label:"Quality", type:"number", value:0, min:-15, max:15},
			{name: "c", label:"Curse", type:"number", value:0, min:0, max:3},
			{name: "e", label:"Effects", type:"enchantments", value:[]}
		]
	});
	
	public function createArmor(subtype:String, rarity:int, quality:int, curseStatus:int, effects:/*Enchantment*/Array):DynamicArmor {
		return DynamicItems.createItem(TDynamicArmor, subtype, rarity, quality, curseStatus, effects) as DynamicArmor;
	}
	
	public const TDynamicRing:ItemTemplate = mk("DynamicRing", "Enchanted Ring", DynamicRing, {
		category: "armor",
		params: [
			{name: "t", label:"Subtype", type:"text", value:"ring"},
			{name: "r", label:"Rarity", type:"number", value:0, min:0, max: 4},
			{name: "q", label:"Quality", type:"number", value:0, min:-15, max:15},
			{name: "c", label:"Curse", type:"number", value:0, min:0, max:3},
			{name: "e", label:"Effects", type:"enchantments", value:[]}
		]
	});
	
	public function createRing(rarity:int, quality:int, curseStatus:int, effects:/*Enchantment*/Array):DynamicRing {
		return DynamicItems.createItem(TDynamicRing, "ring", rarity, quality, curseStatus, effects) as DynamicRing;
	}
	
	/**
	 * @param itemClass constructor should be (id:String, params:Object)
	 * @param metadata template metadata. Used for debugging and in save editor
	 */
	private function mk(templateId:String, name:String, itemClass:Class, metadata:Object):SimpleItemTemplate {
		return new SimpleItemTemplate(templateId, name, itemClass, metadata);
	}
	
	public function ItemTemplateLib() {
		if (instance != null) throw new Error("Duplicate ItemTemplateLib");
		instance = this;
	}
}
}
