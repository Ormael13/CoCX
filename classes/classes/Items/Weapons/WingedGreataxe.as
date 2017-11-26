package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	/**
	 * ...
	 * @author Liadri
	 */
	public class WingedGreataxe extends Weapon
	{
		
		public function WingedGreataxe() 
		{
			super("W.GAXE", "Winged G.Axe", "winged greataxe", "a winged greataxe", "cleave", 28, 1280, "A Greataxe imbued with holy power. The shaft has an angel motif, looking as if it was wrapped in feathery wings.", "Large");
		}
		override public function get attack():Number{
			var boost:int = 0;
			if (game.player.str >= 100) boost += 9;
			return (18 + ((100-game.player.cor) / 10));
		}
	}
}