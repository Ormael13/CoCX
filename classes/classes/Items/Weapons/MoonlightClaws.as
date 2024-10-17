/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;

	public class MoonlightClaws extends Weapon
	{
		
		public function MoonlightClaws() 
		{
			super("MClaws", "MoonlightClaws", "moonlight claws", "a pair of moonlight claws", "clawing punch", 25, 4000,
				"This pair of claws is imbued with magic that can be unleashed as a wave of moonlight. The magic within grants greater boons when charged with energy.",
				WT_GAUNTLET, WSZ_MEDIUM);
				withEffect(IELib.Bleed, 25);
				withEffect(IELib.ScaleAttack_Str, 50);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
	}
}
