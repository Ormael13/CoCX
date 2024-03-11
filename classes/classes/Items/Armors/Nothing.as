package classes.Items.Armors
{
	import classes.ItemType;
	import classes.Items.Armor;
import classes.Player;

	public final class Nothing extends Armor {

		public function Nothing() {
			super("nothing", "nothing", "nothing", "nothing", 0, 0, 0, "nothing", "Light");
			withTag(A_REVEALING);
			withTag(A_AGILE);
		}
		
		override public function get isNothing():Boolean {
			return true;
		}
	}

}
