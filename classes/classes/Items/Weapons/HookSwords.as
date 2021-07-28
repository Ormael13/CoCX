/**
 * ...
 * @author Shamanknight
 */
package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkLib;
	import classes.Player;
	
	public class HookSwords extends WeaponWithPerk {
		
		public function HookSwords() 
		{
			super("HSwords", "HookSwords", "hook swords", "a pair of hook swords", "slashes", 20, 1600, "Dual swords with wrist guards and an outwards-facing “hook” on the sword tip, useful for parrying and disarming opponents.", "Dual", PerkLib.DexterousSwordsmanship, 0, 0, 0, 0);
		}
		
		override public function canUse():Boolean {
			if (game.player.hasPerk(PerkLib.DualWield)) return true;
			outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}