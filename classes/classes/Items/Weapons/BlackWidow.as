package classes.Items.Weapons 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Weapon;
	
	public class BlackWidow extends Weapon
	{
		
		public function BlackWidow() 
		{
			super("BWidow", "B. Widow", "black widow", "a black widow", "slash", 20, 2048, "This weapon’s pommel design looks similar to that of a spiderweb. It is said to poison the soul of the user and become stronger the more wicked and depraved the fencer is. This weapon was clearly designed for a deceitful woman who toys with men's hearts in order to obtain that which she desires as befits a black widow.");
		}
		override public function get attack():Number{
			var boost:int = 0;
			if (kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			else boost += 4 + (kGAMECLASS.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			boost += ((game.player.femininity) / 20) + ((game.player.cor) / 20) / 2;
			return (20 + boost); 
		}
		
	}

}