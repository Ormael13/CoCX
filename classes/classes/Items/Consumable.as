/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items
{
import classes.CoC_Settings;
import classes.Player;

/**
	 * An item, that is consumed by player, and disappears after use. Direct subclasses should override "doEffect" method
	 * and NOT "useItem" method.
	 */
	public class Consumable extends Useable
	{
		/**
		 * Perform effect on player WITHOUT requiring item being in player's inventory and removing it
		 */
		public function doEffect(player:Player,output:Boolean):void
		{
			CoC_Settings.errorAMC("Consumable","doEffect",id);
		}

		public function canUse(player:Player,output:Boolean):Boolean
		{
			return true;
		}

		/**
		 * Removes item from player and does effect
		 */
		override public function useItem(player:Player, output:Boolean, external:Boolean):void
		{
			if (canUse(player,output)){
				if (!external) player.consumeItem(this,1);
				doEffect(player,output);
			}
		}

		public function Consumable(id:String, shortName:String=null, longName:String=null, value:Number=0, description:String=null)
		{
			super(id, shortName, longName, value, description);
		}
	}
}
