/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Player;

	public class BFSword extends Weapon {
		
		public function BFSword() {
			super("BFSword", "B.F.Sword", "big fucking sword", "a big fucking sword", "slash", 25, 1000, "Big Fucking Sword - the best solution for a tiny e-pen complex at this side of the Mareth!  This 2H 2,5 meters long sword requires 70 strength to use.", "Large");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 70) boost += 15;
			return (10 + boost); 
		}
	}
}