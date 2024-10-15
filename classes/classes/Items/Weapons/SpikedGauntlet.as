/**
 * ...
 * @author ...
 */
package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;

	public class SpikedGauntlet extends Weapon
	{
		
		public function SpikedGauntlet() 
		{
			super("S.Gaunt","S.Gauntlet","spiked gauntlet","a spiked gauntlet","spiked punch",0,200,
				"These metal gauntlets have knuckles tipped with metal spikes.  Though it lacks the damaging potential of other weapons, the sheer pain of its wounds has a chance of stunning your opponent.",
				WT_GAUNTLET, WSZ_MEDIUM);
			withEffect(IELib.Stun, 10);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
	}
}
