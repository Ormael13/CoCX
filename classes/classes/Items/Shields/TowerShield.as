package classes.Items.Shields 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Items.Shield;
	import classes.Player;
	
	public class TowerShield extends Shield
	{
		
		public function TowerShield()
		{
			super("TowerSh", "TowerShld", "tower shield", "a tower shield", 36, 1800, "A towering metal shield.  It looks heavy! \nReq 100 strength to fully use it potential.", "Massive");
		}
		
		override public function get block():Number {
			var block:int = 0;
			if (game.player.str >= 100) block += 16;
			if (game.player.str >= 75) block += 10;
			if (game.player.str >= 50) block += 6;
			if (game.player.str >= 25) block += 3;
			return (1 + block);
		}
	}
}