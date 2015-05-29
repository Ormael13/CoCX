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
			super("L.Hammr", "L.Hammr", "large hammer", "Marble's large hammer", "smash", 16, 90, "This two-handed warhammer looks pretty devastating.  You took it from Marble after she refused your advances.", "Large");
		}
		
		override public function canUse():Boolean {
			if (game.player.tallness >= 60) return true;
			outputText("This hammer is too large for you to wield effectively.  ");
			return false;
		}
		
	}
}
