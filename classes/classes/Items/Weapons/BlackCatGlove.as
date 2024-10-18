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
				"Not quite a weapon, these are black gloves with open fingers to expose the tips. These were made and custom enchanted for a cat girl adventurer. When worn by someone with cat-pawed hands in a feral stance, they allow the wearer to perform two additional claw attacks per turn. Feral attacks also counts as a light weapon for the purpose of sneak attacks.",
				WT_GAUNTLET, WSZ_SMALL);
		}
		
		private static const SLOTS:Array = [SLOT_WEAPON_MELEE];
		override public function slots():Array {
			return SLOTS;
		}
	}
}
