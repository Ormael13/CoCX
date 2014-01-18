/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Armors
{
	import classes.ItemType;
	import classes.Items.Armor;
	import classes.Player;

	public class LeatherArmorSegments extends Armor
	{

		override protected function unequipReturnItem(player:Player,output:Boolean):ItemType
		{
			outputText("You have your old set of " + game.armors.LEATHRA.longName + " left over.  ");
			return game.armors.LEATHRA;
		}

		public function LeatherArmorSegments()
		{
			super("UrtaLta","UrtaLta","leather armor segments","leather armor segments",5,76,null,"Light");
		}
	}
}
