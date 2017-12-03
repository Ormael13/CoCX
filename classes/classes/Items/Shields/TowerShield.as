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
			super("TowerSh", "TowerShld", "tower shield", "a tower shield", 16, 500, "A towering metal shield.  It looks heavy! \nReq 40 strength to fully use it potential.");
		}
		
		override public function get block():Number {
			var block:int = 0;
			if (game.player.str >= 40) block += 12;
			return (4 + block);
		}
	}
}