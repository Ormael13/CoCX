package classes.Items {
import classes.ItemTemplate;
import classes.ItemType;

public class SimpleItemTemplate extends ItemTemplate {
	private var itemClass:Class;
	
	/**
	 * @param itemClass constructor should be (id:String, params:Object)
	 */
	public function SimpleItemTemplate(templateId:String, name:String, itemClass:Class, metadata:Object) {
		super(templateId, name, metadata||{});
		this.itemClass = itemClass;
	}
	
	override public function createItem(parameters:Object):ItemType {
		var itemId:String = ItemType.dynamicItemId(templateId, parameters);
		var item:ItemType = ItemType.lookupCachedItem(itemId);
		if (item) return item;
		return new itemClass(itemId, parameters) as ItemType;
	}
}
}
