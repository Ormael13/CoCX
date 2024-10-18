/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;

	public class BigFuckingGauntlets extends Weapon
	{
		
		public function BigFuckingGauntlets() 
		{
			super("BFGaunt", "B.F.Gauntlets", "big fucking gauntlets", "a big fucking gauntlets", "smash", 0, 1600,
				"Big Fucking Gauntlets - the best solution for a tiny e-peen complex on this side of Mareth!  These huge gauntlets signed by mysterious 'Vi' requires 150 strength to fully unleash its power.\nIncreases unarmed damage by 2x.\nIncreases stun chance by 40.", WT_GAUNTLET, WSZ_LARGE);
				withEffect(IELib.Stun, 40);
				withTags(W_LGWRATH);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
	}
}
