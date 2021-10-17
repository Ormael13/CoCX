/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.CoC_Settings;
	import classes.Creature;
	import classes.Items.Weapon;
	import classes.Player;

	public class LargeHammer extends Weapon {
		
		public function LargeHammer() {
			super("L.Hammr", "L.Hammr", "large hammer", "Marble's large hammer", "smash", 18, 720, "This two-handed warhammer looks pretty devastating.  You took it from Marble after she refused your advances.", "Large, Whirlwind", "Mace/Hammer");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 70) boost += 9;
			return (9 + boost); 
		}
	}
}