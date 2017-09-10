package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	/**
	 * ...
	 * @author 
	 */
	public class DemonicGreataxe extends Weapon
	{
		
		public function DemonicGreataxe() 
		{
			super("D.GAXE", "Demon G.Axe", "demonic greataxe", "a demonic greataxe", "cleave", 27, 1280, "A Greataxe imbued with unholy power. The shaft has a demon motif, looking as if it was wrapped in leathery wings.", "Large");
		}
		override public function get attack():Number{
			return (17 + (game.player.cor / 10));
		}
	}

}