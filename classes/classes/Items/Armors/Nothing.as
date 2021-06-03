package classes.Items.Armors
{
	import classes.ItemType;
	import classes.Items.Armor;
import classes.Items.ItemTags;
import classes.Player;

	public final class Nothing extends Armor {

		public function Nothing() {
			super("nothing", "nothing", "nothing", "nothing", 0, 0, 0, "nothing", "Light");
			withTag(ItemTags.REVEALING, ItemTags.AGILE);
		}

		override public function playerRemove():Armor {
			return null; //Player never picks up their underclothes
		}
	}

}
