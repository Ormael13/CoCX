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
		
		override public function useText():void {} //No text for equipping fists

		override public function playerRemove():Weapon {
			return null;
		}
		
/*
		override public function unequip(player:Player, returnToInventory:Boolean, output:Boolean = false):void
		{
		}

		override protected function unequipReturnItem(player:Player, output:Boolean):ItemType
		{
<<<<<<< HEAD
			super("Fists  ", "Fists", "fists","fists \n\nType: Weapon (Unarmed) \nAttack: 0 \nBase value: N/A","punch",0);
=======
			return null;
>>>>>>> a82163c1688c17102ece58f63f28e75c34388695
		}
*/
	}
}
