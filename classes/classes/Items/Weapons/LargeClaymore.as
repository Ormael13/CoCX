/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;
	import classes.Player;

	public class LargeClaymore extends Weapon
	{

		override public function canUse(player:Player, printReason:Boolean):Boolean
		{
			if (player.str < 40){
				if (printReason) {
					outputText("You aren't strong enough to handle such a heavy weapon!  ");
				}
				return false;
			} else {
				return true;
			}
		}

		public function LargeClaymore()
		{
			super("Claymor","Claymor","large claymore","a large claymore","cleaving sword-slash",15,1000,"A massive sword that a very strong warrior might use. Requires 40 strength to use.  (ATK: 15) (Cost: 1000)","Large")
		}
	}
}
