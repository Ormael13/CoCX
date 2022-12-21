/**
 * ...
 * @author Ormael
 */
package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.PerkLib;

public class DualLance extends Weapon {
		
		public function DualLance()
		{
			super("D.Lance", "D.Lance", "dual lance", "a dual lances", "piercing stab", 12, 960, "A pair of long wooden shafts with a pointed metal heads, used as a weapon by knights and cavalry soldiers in charging.  They would ignore most armors.  Req. 100+ speed to unleash full attack power.", [WP_DUAL, WP_AP100].join(", "), WT_SPEAR);
		}
		
		override public function get attack():Number {
			var base:int = 0;
			base += 6;
			if (game.player.spe >= 100) base += 3;
			if (game.player.spe >= 50) base += 3;
			return (base);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.DualWield) || game.player.hasPerk(PerkLib.AntyDexterity)) {
				return super.canEquip(doOutput);
			}
			if (doOutput) outputText("You aren't skilled enough to handle this pair of weapons!  ");
			return false;
		}
	}
}
