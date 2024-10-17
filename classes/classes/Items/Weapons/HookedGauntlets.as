/**
 * ...
 * @author ...
 */
package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;

	public class HookedGauntlets extends Weapon
	{
		
		public function HookedGauntlets() 
		{
			super("H.Gaunt", "H.Gaunt", "hooked gauntlets", "a set of hooked gauntlets", "clawing punch", 0, 400,
				"These metal gauntlets are covered in nasty-looking hooks that are sure to tear at your foe's flesh and cause them significant harm.",
				WT_GAUNTLET, WSZ_MEDIUM);
				withEffect(IELib.Bleed, 25);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
	}
}
