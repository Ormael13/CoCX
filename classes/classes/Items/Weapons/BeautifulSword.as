/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.CoC_Settings;
	import classes.Creature;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.Items.Weapon;
	import classes.Player;

	public class BeautifulSword extends Weapon
	{

		override public function get attack():Number
		{
			return 7 + int(10 - game.player.cor / 3);
		}


		override public function canUse(player:Player, output:Boolean):Boolean
		{
			if (player.cor >= 35) {
				if (output) {
					clearOutput();
					outputText("You grab hold of the handle of the sword only to have it grow burning hot.  You're forced to let it go lest you burn yourself.  Something within the sword must be displeased.  ");
				}
				return false;
			} else {
				return true;
			}
		}

		public function BeautifulSword()
		{
			super("B.Sword", "B.Sword", "beautiful sword","a beautiful shining sword", "slash", 7, 400, "This beautiful sword shines brilliantly in the light, showing the flawless craftsmanship of its blade.  The pommel and guard are heavily decorated in gold and brass.  Some craftsman clearly poured his heart and soul into this blade.  (ATK: +Varies) (Cost: 400)","holySword");
		}
	}
}
