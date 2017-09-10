package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	/**
	 * ...
	 * @author 
	 */
	public class WingedGreataxe extends Weapon
	{
		
		public function WingedGreataxe() 
		{
			super("W.GAXE", "Winged G.Axe", "winged greataxe", "a winged greataxe", "cleave", 27, 1280, "A Greataxe imbued with holy power. The shaft has an angel motif, looking as if it was wrapped in feathery wings.", "Large");
		}
		override public function get attack():Number{
			return (17 + ((100-game.player.cor) / 10));
		}
	}

}