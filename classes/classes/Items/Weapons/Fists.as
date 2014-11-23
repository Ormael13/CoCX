/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items.Weapons
{
	import classes.ItemType;
	import classes.Items.Weapon;
	import classes.Player;

	public class Fists extends Weapon {
		
		public function Fists() {
			super("Fists  ", "Fists", "fists", "fists \n\nType: Weapon (Unarmed) \nAttack: 0 \nBase value: N/A", "punch", 0);
		}
		
		override public function useText():void {} //No text for equipping fists

		override public function playerRemove():Weapon {
			return null;
		}
		
	}
}
