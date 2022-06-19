package classes.Items {
import classes.ItemTemplate;
import classes.Items.Consumables.HairDye;

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
	
	/**
	 * @param itemClass constructor should be (id:String, params:Object)
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
