/**
 * ...
 * @author Shamanknight
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.Player;
	
	public class Halberd extends Weapon {
		
		public function Halberd() {
			super("Halberd", "Halberd", "halberd", "a halberd", "slash", 30, 1200, "This imposing cross between a spear and an axe features a 5 foot solid steel pole with two crescent-shaped blades on each end of the pole, with a prominent spear tip.  The tool feels heavy enough to crush armor.  Req. 100 strength to unleash full attack power.", "Large");
		}
		
		override public function get attack():Number {
			var base:int = 0;
			if (game.player.str >= 100) base += 15;
			if (game.player.str >= 50) base += 9;
			return (6 + base);
		}
	}
}