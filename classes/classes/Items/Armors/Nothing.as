package classes.Items.Armors 
{
	import classes.ItemType;
	import classes.Items.Armor;
	import classes.Player;
	
	public final class Nothing extends Armor {
		
		public function Nothing() {
			super("nothing", "nothing", "nothing", "nothing", 0, 0, "nothing", "Light");
		}
		
		override public function playerRemove():Armor {
			return null; //Player never picks up their underclothes
		}
	}

}