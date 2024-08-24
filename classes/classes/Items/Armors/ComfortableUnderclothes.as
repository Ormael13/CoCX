/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Armors
{
	import classes.ItemType;
	import classes.Items.Armor;
import classes.Items.ArmorLib;
import classes.Player;

	public final class ComfortableUnderclothes extends Armor {
		
		public function ComfortableUnderclothes() {
			super("c.under", "c.under", "comfortable underclothes", "comfortable underclothes", 0, 0, 1, "comfortable underclothes", "Light");
		}
		
		override public function beforeUnequip(doOutput:Boolean, slot:int):ItemType {
			return ArmorLib.NOTHING; //Player never picks up their underclothes
		}
	}
}
