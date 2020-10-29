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
	
	public class SpikedHeavyShield extends Shield
	{
		
		public function SpikedHeavyShield()
		{
			super("SpiH Sh", "SpikeHShield", "spiked heavy shield", "a spiked heavy shield", 24, 1800, "A large shield with spikes. \nReq 60 strength to fully use it potential.", "Large");
		}
		
		override public function get block():Number {
			var block:int = 0;
			if (game.player.str >= 60) block += 9;
			if (game.player.str >= 40) block += 7;
			if (game.player.str >= 20) block += 5;
			return (3 + block);
		}
	}
}