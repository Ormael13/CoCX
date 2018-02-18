/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Player;

	public class LargeClaymore extends Weapon {
		
		public function LargeClaymore() {
			super("Claymor", "L.Claymore", "large claymore", "a large claymore", "cleaving sword-slash", 15, 600, "A massive sword that a very strong warrior might use.  Requires 40 strength to unleash full attack power.", "Large");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 40) boost += 8;
			return (7 + boost); 
		}
	}
}
