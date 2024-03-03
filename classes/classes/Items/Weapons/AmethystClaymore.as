/**
 * ...
 * @author Zevos
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;

	public class AmethystClaymore extends Weapon
	{
		
		public function AmethystClaymore()
		{
			super("AClaymo", "A.Claymore", "amethyst claymore", "an amethyst claymore", "cleaving sword-slash", 15, 1200, "This two-handed sword is made of obsidian and grotesquely decorated with amethysts and lead engravings. The magic within this murky blade will bleed unnatural darkness when charged with magic.", "Large", "Sword");
		}
		
		override public function get attack():Number {
			var boost:int = 0;
			if (game.player.str >= 40 || game.player.hasPerk(PerkLib.HiddenJobSwordImmortal)) boost += 8;
			return (7 + boost); 
		}
	}
}