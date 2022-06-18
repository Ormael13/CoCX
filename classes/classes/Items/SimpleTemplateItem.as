package classes.Items {
import classes.ItemTemplate;
import classes.ItemType;

public class SimpleTemplateItem extends ItemTemplate {
	private var itemClass:Class;
	
	/**
	 * @param itemClass constructor should be (id:String, params:Object)
	 */
	public function SimpleTemplateItem(templateId:String, name:String, itemClass:Class) {
		super(templateId, name);
		this.itemClass = itemClass;
	}
	
	override public function createItem(parameters:Object):ItemType {
		var itemId:String = ItemType.templatedItemId(templateId, parameters);
		return new itemClass(itemId, parameters) as ItemType;
	}
}
}
