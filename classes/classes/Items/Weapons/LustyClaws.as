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
				"Those metal gauntlets have tips of the fingers shaped like natural claws.  They seems to have been enchanted to always be covered in a light aphrodisiac to arouse anything cut with it.",
				WT_GAUNTLET, WSZ_MEDIUM);
				withEffect(IELib.Bleed, 10);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
	}
}