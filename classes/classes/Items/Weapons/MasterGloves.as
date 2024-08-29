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
				"These gloves belonged to Chi Chi. They seem to naturally strengthen the soulforce techniques of the user.",
				WT_GAUNTLET, WSZ_MEDIUM);
			withBuffs({ 'psoulskillpower': +0.4 });
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
	}
}