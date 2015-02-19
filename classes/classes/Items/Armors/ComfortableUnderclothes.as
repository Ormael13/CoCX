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
			super("c.under", "c.under", "comfortable underclothes", "comfortable underclothes", 0, 0, "comfortable underclothes", "Light");
		}
		
		override public function playerRemove():Armor {
			return null; //Player never picks up their underclothes
		}
	}
}
