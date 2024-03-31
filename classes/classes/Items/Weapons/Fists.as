/**
 * Created by aimozg on 09.01.14.
 */
package classes.Items.Weapons
{
	import classes.Items.Weapon;

	public class Fists extends Weapon {
		
		public function Fists() {
			super("Fists  ", "Fists", "fists", "fists", "punch", 0, 0, "Type: Weapon (Unarmed) \nAttack: 0 \nBase value: N/A", WT_FISTS, WSZ_SMALL);
		}
		
		override public function useText():void {} //No text for equipping fists
		
		override public function canEquip(doOutput:Boolean):Boolean {
			return true;
		}
		
		override public function get isNothing():Boolean {
			return true;
		}
	}
}
