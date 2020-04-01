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
			super("W.GAXE", "Winged G.Axe", "winged greataxe", "a winged greataxe", "cleave", 28, 1280,
					"A greataxe made in untarnished steel and imbued with holy power. Its shaft is wrapped in feathery wings made of brass and gold. This holy artifact was created to execute demonic fiends, always finding their weakest spot.",
					"Large"
			);
		}
		override public function get attack():Number{
			var boost:int = 0;
			if (game.player.str >= 100) boost += 9;
			boost += Math.round((100-game.player.cor) / 10);
			return (9 + boost);
		}
	}
}