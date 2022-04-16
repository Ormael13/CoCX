/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.CoC_Settings;
	import classes.Creature;
	import classes.CoC;
	import classes.Items.Weapon;
	import classes.Player;

	public class BeautifulSword extends Weapon {
		
		public function BeautifulSword() {
			super("B.Sword", "B.Sword", "beautiful sword", "a beautiful shining sword", "slash", 7, 560, "This beautiful sword shines brilliantly in the light, showing the flawless craftsmanship of its blade.  The pommel and guard are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this blade.", "", "Sword");
		}
		
		override public function get attack():Number { 
			var temp:int = 7 + (10 - game.player.cor / 3);
			if (temp < 5) temp = 5;
			return temp; 
		}
		
		override public function canUse():Boolean {
			if (game.player.cor < (33 + game.player.corruptionTolerance)) return super.canUse();
			outputText("You grab hold of the handle of the sword only to have it grow burning hot.  You're forced to let it go lest you burn yourself.  Something within the sword must be displeased.  ");
			return false;
		}
	}
}