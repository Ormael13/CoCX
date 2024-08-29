/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;

	public class KarmicTouch extends Weapon
	{
		
		public function KarmicTouch() 
		{
			super("KarmTou", "KarmicTouch", "karmic gloves", "a pair of karmic gloves", "punch", 0, 400,
				"A pair of gauntlets, ordinary at first glance save by its immaculate appearance in shining metal and snow-white cloth.Their touch brings waste into the wicked flesh, punishing them in the form of blows more painful then should be.",
				WT_GAUNTLET, WSZ_MEDIUM);
				withBuffs({ 'psoulskillpower': +1.5 });
				withTags(I_LEGENDARY, W_PURE_TYPE);
				withEffect(IELib.Stun, 50);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
	}
}