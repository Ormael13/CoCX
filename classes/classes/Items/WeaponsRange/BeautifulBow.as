/**
 * Created by ormael on 02.03.19.
 */
package classes.Items.WeaponsRange 
{
	import classes.CoC_Settings;
	import classes.Creature;
	import classes.CoC;
	import classes.Items.WeaponRange;
	import classes.Player;

	public class BeautifulBow extends WeaponRange {
		
		public function BeautifulBow() {
			super("B.Bow", "B.Bow", "beautiful bow", "a beautiful shining bow", "shot", 1, 100, "The beautiful bow shines brilliantly in the light, showing of the flawless craftsmanship of the weapon.  The wood used to make the main bow is inlaid with gold and brass as the string glows in the light.  Some craftsmen clearly poured their heart and soul into this bow.", "Bow");
		}
		
		override public function get attack():Number { 
			var temp:int = 4 - (game.player.cor / 10);
			if (temp < 1) temp = 1;
			return temp; 
		}
		
		override public function canUse():Boolean {
			if (game.player.cor < (33 + game.player.corruptionTolerance())) return true;
			outputText("You grab hold of the handle of the bow only to have it grow burning hot.  You're forced to let it go lest you burn yourself.  Something within the bow must be displeased.  ");
			return false;
		}
	}
}