/**
 * ...
 * @author Shamanknight
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class FlyWhisk extends WeaponWithPerk {
		
		public function FlyWhisk() 
		{
			super("FlyWhis", "FlyWhisk", "Fly-Whisk", "a Fly-Whisk", "slash", 0, 400, "This strange Daoist tool is a small wooden rod, with a prominently displayed ‘tail’ of plant fibers attached to the tip. Simply holding it seems to focus your concentration and empower your Soulforce!", "Daoist's Focus", PerkLib.DaoistsFocus, 0.2, 0, 0, 0);
		}
	}
}