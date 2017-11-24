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
			super("SanctL", "Sanctuary", "Sanctuary", "Sanctuary", 20, 2000, "The legendary shield is said to heal and protect a knight of pure heart.", "", PerkLib.Sanctuary, 1, 0, 0, 0);
		}
		
		override public function get block():Number {
			var block:int = 0;
			block += (100 - game.player.cor) / 5;
			return (0 + block);
		}
	}
}