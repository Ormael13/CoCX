/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
	import classes.CoC_Settings;
	import classes.Player;

	/**
	 * Represent item that can be used but does not necessarily disappears on use. Direct subclasses should overrride
	 * "useItem" method.
	 */
	public class Useable extends CommonItem {
		
		public function Useable(id:String, shortName:String = null, longName:String = null, value:Number = 0, description:String = null) {
			super(id, shortName, longName, value, description);
		}
		
		override public function get description():String {
			return this._description + "\n\nValue: " + this.value;
		}
		
		public function canUse():Boolean { return true; } //If an item cannot be used it should provide some description of why not
		
//		public function hasSubMenu():Boolean { return false; } //Only GroPlus and Reducto use this. //Replaced with a return
		
		public function useItem():Boolean {
			CoC_Settings.errorAMC("Useable", "useItem", id);
			return(false);
		}
		
		public function useText():void {} //Produces any text seen when using or equipping the item normally

        /**
         * @param player user
         * @param output print text
         * @param external item is external (used in consumables: do not remove from player inventory)
         */
/* New version removes the need for any parameters - item is always used on the player, item always outputs text if needed, item is never consumed from inventory (That's up to the calling code).
		public function useItem(player:Player,output:Boolean,external:Boolean):void
		{
			CoC_Settings.errorAMC("Useable", "useItem", id);
		}
*/
	}
}
