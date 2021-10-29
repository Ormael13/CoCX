/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class LargeAxe extends Weapon {
		
		public function LargeAxe() {
			super("L. Axe ","L. Axe","large axe","an axe large enough for a minotaur","cleave",18,720,"This massive axe once belonged to a minotaur.  It'd be hard for anyone smaller than a giant to wield effectively.  The axe is double-bladed and deadly-looking.  Requires height of 6'6\".","Large", "Axe");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 90) boost += 9;
			return (9 + boost); 
		}	
	}
}