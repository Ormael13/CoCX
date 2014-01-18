/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items.Weapons
{
	import classes.ItemType;
	import classes.Items.Weapon;
	import classes.Player;

	public class Fists extends Weapon
	{
		override public function unequip(player:Player, output:Boolean):void
		{
		}


		override protected function unequipReturnItem(player:Player, output:Boolean):ItemType
		{
			return null;
		}

		public function Fists()
		{
			super("Fists  ", "Fists", "fists","fists","punch",0);
		}
	}
}
