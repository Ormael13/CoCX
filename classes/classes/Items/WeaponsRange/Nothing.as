/**
 * ...
 * @author Ormael
 */
package classes.Items.WeaponsRange  
{
	import classes.ItemType;
	import classes.Items.WeaponRange;
	import classes.Player;
	
	public class Nothing extends WeaponRange
	{
		public function Nothing()
		{
			super("norange", "norange", "nothing", "no range weapon \nAttack: 0", "nothing", 0);
		}
		
		override public function playerRemove():WeaponRange {
			return null; //There is nothing!
		}
	}
}