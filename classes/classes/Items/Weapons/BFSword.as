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
			super("BFSword", "B.F.Sword", "big fucking sword", "a big fucking sword", "slash", 50, 2000, "Big Fucking Sword - the best solution for a tiny e-pen complex at this side of the Mareth!  This 2H 2,5 meters long sword requires 150 strength to fully unleash it power.", "Large, LGWrath", "Sword");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 150) boost += 20;
			if (game.player.str >= 100) boost += 15;
			if (game.player.str >= 50) boost += 10;
			return (5 + boost); 
		}
	}
}