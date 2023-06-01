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
			super("W.GAXE", "Winged G.Axe", "winged greataxe", "a winged greataxe", "cleave", 100, 8000,
					"A greataxe made in untarnished steel and imbued with holy power. Its shaft is wrapped in feathery wings made of brass and gold. This holy artifact was created to execute demonic fiends, always finding their weakest spot.",
					"Large", "Axe"
			);
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
			boost += Math.round((100 - game.player.cor) / scal);
			return (20 + boost);
		}
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.level >= 54) return super.canEquip(doOutput);
			if (doOutput) outputText("You try and wield the legendary weapon but to your disapointment the item simply refuse to stay in your hands. It would seem you yet lack the power and right to wield this item.");
			return false;
		}
	}
}
