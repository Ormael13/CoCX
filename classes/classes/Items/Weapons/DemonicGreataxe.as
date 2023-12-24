package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Items.ItemTags;
	/**
	 * ...
	 * @author Liadri
	 */
	public class DemonicGreataxe extends Weapon
	{
		
		public function DemonicGreataxe()
		{
			super("D.GAXE", "Demon G.Axe", "demonic greataxe", "a demonic greataxe", "cleave", 100, 8000,
					"A greataxe made in black metal and imbued with unholy power. Its shaft is wrapped in bat wings made of darkened bronze. Its deadly blade seems to always aim for the enemy necks.",
					"Large", "Axe"
			);
			withTag(ItemTags.I_LEGENDARY);
		}
		override public function get attack():Number{
			var boost:int = 0;
			var scal:Number = 10;
			if (game.player.str >= 100) {
				boost += 30;
				scal -= 3;
			}
			if (game.player.str >= 50) {
				boost += 30;
				scal -= 2;
			}
			boost += Math.round(game.player.cor / scal);
			return (20 + boost);
		}
	}
}
