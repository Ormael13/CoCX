/**
 * ...
 * @author Liadri
 */
package classes.Items.Shields 
{
	import classes.Items.Shield;
	import classes.PerkLib;
	import classes.Player;

	public class DarkAegis extends ShieldWithPerk
	{
		
		public function DarkAegis() 
		{
			super("SanctD", "Dark Aegis", "dark aegis", "a dark aegis", 20, 2000, "The legendary shield is said to heal and protect a fallen knight.", "", PerkLib.Sanctuary, 2, 0, 0, 0);
		}
		
		override public function get block():Number {
			var block:int = 0;
			block += (game.player.cor) / 5;
			return (0 + block);
		}
	}
}