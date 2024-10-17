/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;

	public class MasterGloves extends Weapon
	{
		
		public function MasterGloves() 
		{
			super("MastGlo", "MasterGloves", "Master Gloves", "a Master Gloves", "punch", 0, 400,
				"These gloves once belonged to Chi Chi. They naturally strengthen the user's soulforce techniques.",
				WT_GAUNTLET, WSZ_MEDIUM);
			withBuffs({ 'psoulskillpower': +0.4 });
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
	}
}
