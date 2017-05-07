/**
 * ...
 * @author Zevos
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class Wardensblade extends WeaponWithPerk
	{
		
		public function Wardensblade() 
		{
			super("WGSword", "WardenGSword", "Warden’s greatsword", "a Warden’s greatsword", "slash", 30, 2400, "Wrought from alchemy, not the forge, this sword is made from sacred wood and resonates with Yggdrasil’s song.", "Large", PerkLib.DaoistsFocus, 0.4, 0, 0, 0);
		}
		
	}

}