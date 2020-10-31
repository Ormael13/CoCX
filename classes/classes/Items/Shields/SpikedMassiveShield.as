/**
 * ...
 * @author Ormael
 */
package classes.Items.Shields 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Items.Shield;
	import classes.Player;
	
	public class SpikedMassiveShield extends Shield
	{
		
		public function SpikedMassiveShield()
		{
			super("SpiM Sh", "SpikeMShield", "spiked massive shield", "a spiked massive shield", 56, 4200, "A massive shield with menacing spikes. \nReq 125 strength to fully use it potential.", "Massive");
		}
		
		override public function get block():Number {
			var block:int = 0;
			if (game.player.str >= 125) block += 21;
			if (game.player.str >= 100) block += 15;
			if (game.player.str >= 75) block += 10;
			if (game.player.str >= 50) block += 6;
			if (game.player.str >= 25) block += 3;
			return (1 + block);
		}
	}
}