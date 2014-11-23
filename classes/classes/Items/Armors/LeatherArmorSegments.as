/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Armors
{
	import classes.ItemType;
	import classes.Items.Armor;
	import classes.Player;

	public class LeatherArmorSegments extends Armor {
		
		public function LeatherArmorSegments() {
			super("UrtaLta", "UrtaLta", "leather armor segments", "leather armor segments", 5, 76, null, "Light", true);
		}
		override public function removeText():void {
			outputText("You have your old set of " + game.armors.LEATHRA.longName + " left over.  ");
		}
		
		override public function playerRemove():Armor {
			super.playerRemove();
			return game.armors.LEATHRA;
		}
	}
}
