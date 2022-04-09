/**
 * ...
 * @author Liadri
 */
package classes.Items.Shields 
{
	import classes.Items.Shield;
	import classes.PerkLib;
	import classes.Player;

	public class Sanctuary extends ShieldWithPerk
	{
		
		public function Sanctuary() 
		{
			super("SanctL", "SanctuaryL", "Sanctuary shield (L)", "a Sanctuary shield (L)", 29, 2900,
					"Shining in snow-white ivory with a silver trim, this legendary shield is said to heal and protect a knight of pure heart. Embellishments carved on the ivory cover most of its surface.",
					"Large", PerkLib.Sanctuary, 1, 0, 0, 0);
		}
		
		override public function get block():Number {
			var block:int = 0;
			block += Math.round((100 - game.player.cor) / 5);
			if (game.player.str >= 40) block += 6;
			if (game.player.str >= 20) block += 3;
			return (0 + block);
		}
	}
}