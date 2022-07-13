package classes.Items {
import classes.ItemType;

public class ItemTypeNothing extends ItemType {
	
	override public function get category():String {
		return CATEGORY_OTHER;
	}
	
	override public function get isNothing():Boolean {
		return true;
	}
	
	public function ItemTypeNothing() {
		super("NOTHING!");
	}
}
}
