/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;

	public class Venoclaw extends Weapon
	{
		
		public function Venoclaw() 
		{
			super("VenClaw","Venoclaw","Venoclaw","a Venoclaw","rend",0,400,
				"This set of catclaw gloves was tempered using Etna's own venom and reinforced using some of her tail bone spikes, a proof of her eternal love for you. It is also enchanted to reinforce natural attacks.",
				WT_GAUNTLET, WSZ_MEDIUM);
				withEffect(IELib.Bleed, 10);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
	}
}
