/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Consumables
{
	import classes.Items.Consumable;
	import classes.Player;

	public class SimpleConsumable extends Consumable {
		private var effect:Function;
		
		/**
		 * @param effect Function(player:Player)
		 */
		public function SimpleConsumable(id:String, shortName:String, longName:String, effect:Function, value:Number = 0, description:String = null) {
			super(id, shortName, longName, value, description);
			this.effect = effect;
		}
		
		override public function useItem():Boolean {
			clearOutput();
			effect(game.player);
			return(false); //Any normal consumable does not have a sub-menu. Return false so that the inventory runs the itemDoNext function after useItem.
		}
	}
}
