package classes.Items {
import classes.ItemTemplate;
import classes.ItemType;
import classes.Items.Consumables.HairDye;

public class TemplatedItemsLib {
	public static var instance:TemplatedItemsLib;
	
	/**
	 * Templated parameters:
	 * "color": string
	 * "rarity": 1-4 (determines price)
	 */
	public const THairDye:ItemTemplate = mk("HairDye", "Hair Dye", HairDye);
	
	public function createHairDye(color:String, rarity:int):HairDye {
		return THairDye.createItem({color: color, rarity: rarity}) as HairDye;
	}
	
	/**
	 * @param itemClass constructor should be (id:String, params:Object)
	 */
	private function mk(templateId:String, name:String, itemClass:Class):SimpleTemplateItem {
		return new SimpleTemplateItem(templateId, name, itemClass);
	}
	
	public function TemplatedItemsLib() {
		if (instance != null) throw new Error("Duplicate TemplatedItemsLib");
		instance = this;
	}
}
}
