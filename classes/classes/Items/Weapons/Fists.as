/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items.Weapons
{
	import classes.ItemType;
	import classes.Items.Weapon;
	import classes.Player;

	public class Fists extends Weapon {
		
		public function Fists() {
			super("Fists  ", "Fists", "fists", "fists", "punch", 0);
		}
		
		override public function playerRemove():Weapon {
			return null;
		}
		
/*
		override public function unequip(player:Player, returnToInventory:Boolean, output:Boolean = false):void
		{
		}

		override protected function unequipReturnItem(player:Player, output:Boolean):ItemType
		{
			return null;
		}
*/
	}
}
