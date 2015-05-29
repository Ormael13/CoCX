/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Player;

	public class HugeWarhammer extends Weapon {
		
		public function HugeWarhammer() {
			super("Warhamr", "Warhammer", "huge warhammer", "a huge warhammer", "smash", 15, 1600, "A huge war-hammer made almost entirely of steel that only the strongest warriors could use.  Requires 80 strength to use.  Getting hit with this might stun the victim.", "Large");
		}
		
		override public function canUse():Boolean {
			if (game.player.str >= 80) return true;
			outputText("You aren't strong enough to handle such a heavy weapon!  ");
			return false;
		}
		
	}
}
