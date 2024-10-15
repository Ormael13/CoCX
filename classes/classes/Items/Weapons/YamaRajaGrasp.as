/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;

	public class YamaRajaGrasp extends Weapon
	{
		
		public function YamaRajaGrasp() 
		{
			super("YamaRG", "YamaRajaGrasp", "Yama-Raja gloves", "a pair of Yama-Raja gloves", "punch", 0, 1600, "These black gloves are made of black leather and an ebony alloy. Their corrupt touch seeks to destroy the pure and innocent. As such, they target the weak points of its victims when striking.", WT_GAUNTLET, WSZ_MEDIUM);
			withBuffs({ 'psoulskillpower': +1.5 });
			withTags(I_LEGENDARY, W_CORRUPT_TYPE);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
	}
}
