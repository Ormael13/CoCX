/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
import classes.CoC_Settings;
import classes.Scenes.SceneLib;

/**
	 * Represent item that can be used but does not necessarily disappears on use. Direct subclasses should overrride
	 * "useItem" method.
	 */
	public class Useable extends CommonItem {
	
		override public function get category():String {
			return CATEGORY_USABLE;
		}
		
		public function Useable(id:String, shortName:String = null, longName:String = null, value:Number = 0, description:String = null) {
			super(id, shortName, longName, value, description);
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: ";
			if (shortName == "Condom" || shortName == "GldStat") desc += "Miscellaneous";
			else if (shortName == "Debug Wand") desc += "Miscellaneous (Cheat Item)";
			else desc += "Material";
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}
		
		public function canUse():Boolean { return true; } //If an item cannot be used it should provide some description of why not
		
		public function useItem():Boolean {
			CoC_Settings.errorAMC("Useable", "useItem", id);
			return false;
		}
		
		public function useText():void {} //Produces any text seen when using or equipping the item normally
	}
}
