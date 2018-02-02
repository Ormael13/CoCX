/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;
	
	public class Trident extends Weapon
	{
		
		public function Trident() 
		{
			super("Trident", "Trident", "deadly trident", "a deadly trident", "piercing stab", 12, 480, "A very ordinary trident. This weapon has a decent reach and can be used to impale foes. It is capable of piercing armor just as well as any other spear.  Req. 75+ speed to unleash full attack power.");
		}
		
		override public function get attack():Number {
			var base:int = 0;
			if (game.player.spe >= 100) base += 3;
			if (game.player.spe >= 50) base += 3;
			return (6 + base);
		}
	}
}