/**
 * ...
 * @author Liadri
 */
package classes.Items.Weapons
{
import classes.Items.IELib;
import classes.Items.Weapon;

	public class BlackCatGlove extends Weapon
	{
		
		public function BlackCatGlove() 
		{
			super("CatGlove", "CatGlove", "black cat glove", "a pair of black cat gloves", "punch", 0, 480,
				"Not quite a weapon as much as they are black gloves with open fingers to let the tips out. These were made and custom enchanted for a cat girl adventurer. While worn by someone with cat pawed hands in feral stance, allow to perform two more claw attacks per turn. Feral Attack also counts as a light weapon for the purpose of sneak attacks.",
				WT_GAUNTLET, WSZ_SMALL);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
	}
}