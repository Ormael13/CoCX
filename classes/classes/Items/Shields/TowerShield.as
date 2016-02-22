package classes.Items.Shields 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Shield;
	import classes.Player;
	
	public class TowerShield extends Shield
	{
		
		public function TowerShield() 
		{
			super("TowerSh", "TowerShld", "tower shield", "a tower shield", 16, 500, "A towering metal shield. It looks heavy!");
		}
		
		override public function canUse():Boolean {
			if (game.player.str >= 40) return true;
			outputText("This shield is too heavy for you to hold effectively. Perhaps you should try again when you have at least 40 strength?");
			return false;
		}
	}

}