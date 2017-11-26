package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	/**
	 * ...
	 * @author Liadri
	 */
	public class DemonicGreataxe extends Weapon
	{
		
		public function DemonicGreataxe() 
		{
			super("D.GAXE", "Demon G.Axe", "demonic greataxe", "a demonic greataxe", "cleave", 28, 1280, "A Greataxe imbued with unholy power. The shaft has a demon motif, looking as if it was wrapped in leathery wings.", "Large");
		}
		override public function get attack():Number{
			var boost:int = 0;
			if (game.player.str >= 100) boost += 9;
			return (9 + (game.player.cor / 10));
		}
	}
}