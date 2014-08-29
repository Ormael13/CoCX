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
			super("Claymor","L.Claymore","large claymore","a large claymore","cleaving sword-slash",15,1000,"A massive sword that a very strong warrior might use. \n\nType: Weapon (Sword, Heavy) \Attack: 15 \nBase value: 1,000 \nRequires 40 strength.","Large")
		}
	}
}
