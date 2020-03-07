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
			super("D.GAXE", "Demon G.Axe", "demonic greataxe", "a demonic greataxe", "cleave", 28, 1280,
					"A greataxe made in black metal and imbued with unholy power. Its shaft is wrapped in bat wings made of darkened bronze. Its deadly blade seems to always aim for the enemy necks.",
					"Large"
			);
		}
		override public function get attack():Number{
			var boost:int = 0;
			if (game.player.str >= 100) boost += 9;
			boost += Math.round(game.player.cor / 10);
			return (9 + boost);
		}
	}
}