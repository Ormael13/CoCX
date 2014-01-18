/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Armors
{
	import classes.ItemType;
	import classes.Items.Armor;
	import classes.Player;

	public final class ComfortableUnderclothes extends Armor
	{


		override public function unequip(player:Player, output:Boolean):void
		{
		}

		override protected function unequipReturnItem(player:Player,output:Boolean):ItemType
		{
			return null;
		}

		public function ComfortableUnderclothes()
		{
			super("c.under", "c.under", "comfortable underclothes", "comfortable underclothes", 0, 0, "comfortable underclothes", "");
		}
	}
}
