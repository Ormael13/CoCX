package classes.Items.Weapons 
{
	import classes.PerkLib;
	import classes.Player;
	import classes.Items.Weapon;

	public class SuccubiWhip extends Weapon
	{
		
		public function SuccubiWhip() 
		{
			super("SucWhip","SucWhip","succubi whip","a succubi whip","sexy whipping",10,400,"This coiled length of midnight-black leather practically exudes lust.  Though it looks like it could do a lot of damage, the feel of that slick leather impacting flesh is sure to inspire lust.  However, it might slowly warp the mind of wielder.");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.hasPerk(PerkLib.ArcaneLash)) boost += 8;
			return (10 + boost); 
		}
	}
}