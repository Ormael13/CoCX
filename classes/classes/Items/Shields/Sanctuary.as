/**
 * ...
 * @author Liadri
 */
package classes.Items.Shields
{
import classes.Items.Shield;
import classes.PerkLib;

	public class Sanctuary extends Shield
	{
		
		public function Sanctuary()
		{
			super("SanctL", "SanctuaryL", "Sanctuary shield (L)", "a Sanctuary shield (L)", 55, 5500,
					"Shining in snow-white ivory with a silver trim, this legendary shield is said to heal and protect a knight of pure heart. Embellishments carved on the ivory cover most of its surface.",
					"Large");
			withPerk(PerkLib.Sanctuary, 1, 0, 0, 0);
			withTag(I_LEGENDARY);
		}
		
		override public function get block():Number {
			var block:int = 0;
			var scal:Number = 10;
			if (game.player.str >= 125) {
				block += 10;
				scal -= 1;
			}
			if (game.player.str >= 100) {
				block += 10;
				scal -= 1;
			}
			if (game.player.str >= 75) {
				block += 5;
				scal -= 1;
			}
			if (game.player.str >= 50) {
				block += 5;
				scal -= 1;
			}
			if (game.player.str >= 25) {
				block += 3;
				scal -= 1;
			}
			block += Math.round((100 - game.player.cor) / 5);
			return (2 + block);
		}
	}
}
