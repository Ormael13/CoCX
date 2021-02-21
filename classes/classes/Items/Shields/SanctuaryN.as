/**
 * ...
 * @author Liadri
 */
package classes.Items.Shields 
{
	import classes.Items.Shield;
	import classes.PerkLib;
	import classes.Player;

	public class SanctuaryN extends Shield
	{
		
		public function SanctuaryN()
		{
			super("SanctN", "SanctuaryN", "Sanctuary shield (N)", "a Sanctuary shield (N)", 21, 1050, "The legendary shield sanctuary. Its power is currently dormant and would require a powerful source of magic to fully unlock.", "Large");
		}
		
		override public function get block():Number {
			var block:int = 0;
			if (game.player.str >= 40) block += 10;
			if (game.player.str >= 20) block += 7;
			return (4 + block);
		}
	}
}