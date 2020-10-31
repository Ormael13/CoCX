/**
 * ...
 * @author ...
 */
package classes.Items.Shields 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Items.Shield;
	import classes.Player;
	
	public class GreatShield extends Shield
	{
		
		public function GreatShield()
		{
			super("GreatSh", "GreatShld", "greatshield", "a greatshield", 18, 900, "A large metal shield. \nReq 40 strength to fully use it potential.", "Large");
		}
		
		override public function get block():Number {
			var block:int = 0;
			if (game.player.str >= 40) block += 8;
			if (game.player.str >= 20) block += 6;
			return (4 + block);
		}
	}
}