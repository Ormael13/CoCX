/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;

	public class GauntletWithClaws extends Weapon
	{
		
		public function GauntletWithClaws() 
		{
			super("Claws","Claws","gauntlet with claws","a gauntlet with claws","rend",0,100,
				"These metal gauntlets have finger tips shaped like sharp, natural claws. Though they lack the damaging potential of other weapons, they have a chance to leave bleeding wounds.",
				WT_GAUNTLET, WSZ_SMALL);
				withEffect(IELib.Bleed, 10);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
	}
}
