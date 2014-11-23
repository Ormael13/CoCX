/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Armors
{
	import classes.ItemType;
	import classes.Items.Armor;
	import classes.Player;

	public final class ComfortableUnderclothes extends Armor {
		
		public function ComfortableUnderclothes() {
			super("c.under", "c.under", "comfortable underclothes", "comfortable underclothes", 0, 0, "comfortable underclothes", "");
		}
		
		override public function playerRemove():Armor {
			return null; //Player never picks up their underclothes
		}

/*
		override public function unequip(player:Player, returnToInventory:Boolean, output:Boolean = false):void
		{
		}

		override protected function unequipReturnItem(player:Player,output:Boolean):ItemType
		{
			return null;
		}
<<<<<<< HEAD

		public function ComfortableUnderclothes()
		{
			super("c.under", "c.under", "comfortable underclothes", "comfortable underclothes", 0, 0, "comfortable underclothes", "Light");
		}
=======
*/
>>>>>>> a82163c1688c17102ece58f63f28e75c34388695
	}
}
