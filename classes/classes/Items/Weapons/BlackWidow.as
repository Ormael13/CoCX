package classes.Items.Weapons 
{
	import classes.GlobalFlags.kFLAGS;
	import classes.CoC;
	import classes.Items.Weapon;
	
	public class BlackWidow extends Weapon
	{
		
		public function BlackWidow() 
		{
			super("BWidow", "B. Widow", "black widow rapier", "a black widow rapier", "slash", 20, 2400,
					"A rapier that used to belong a deceitful noblewoman, made in a strange, purple metal. Its pommel design looks similar to that of a spiderweb, while the blade and hilt are decorated with amethysts and arachnid-looking engravings."
			);
		}
		override public function get attack():Number{
			var boost:int = 0;
			if (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] < 2) boost += CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] * 2;
			else boost += 4 + (CoC.instance.flags[kFLAGS.RAPHAEL_RAPIER_TRANING] - 2);
			boost += ((game.player.femininity) / 20) + ((game.player.cor) / 20) / 2;
			return (20 + boost); 
		}
		
	}

}