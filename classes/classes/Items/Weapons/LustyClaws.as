/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;

	public class LustyClaws extends Weapon
	{
		
		public function LustyClaws() 
		{
			super("L.Claws","LustyClaws","gauntlet with an aphrodisiac-coated claws","a gauntlet with an aphrodisiac-coated claws","rend",0,200,
				"These metal gauntlets have finger tips shaped like natural claws.  They seems to be enchanted, always covered in a light aphrodisiac that arouses anything they cut.",
				WT_GAUNTLET, WSZ_MEDIUM);
				withEffect(IELib.Bleed, 10);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
	}
}
